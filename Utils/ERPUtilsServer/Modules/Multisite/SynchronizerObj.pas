unit SynchronizerObj;

interface

uses
  MultisiteConfigObj, JSONObject, LogThreadBase, LogMessageTypes,
  MyAccess, DbUtils, classes, MemData, DBAccess, Contnrs, ObjDataSync,
  ExtCtrls, sysutils, MyScript, DAScript, MultisiteConst;

type
  TConnectionMgr = class;
  TSyncTimer = class;
//  TTimestampList = class;

  TDataSynchronizer = class
  private
    fSchema: TJSONObject;
    fConfig: TServerConfig;
    fActive: boolean;
    fLogger: TLoggerBase;
    SrcConn, DestConn: TMyConnection;
    ConnMgr: TConnectionMgr;
    SyncTimer: TSyncTimer;
    SyncObjList: TStringList;
    fDataSyncList: TDataSyncList;
    fOnBeforeGetActive: TNotifyEvent;
//    TimestampList: TTimeStampList;
    fDbPreCheckDone: boolean;
    procedure SetActive(const Value: boolean);
    procedure SetLogger(const Value: TLoggerBase);
//    function GetDestTimeDiffToAdd(src, dst: TMyConnection): TDateTime;
//    function GetTimeZoneMins(conn: TMyConnection): integer;
    procedure SendStatus(msg: string);
    procedure SendNotification(msg: string; msgType: TLogMessageType);
    function CheckVersions(src, dst: TMyConnection; var msg: string): boolean;
    function PrepareTables(aClassName: string; Schema: TJSONObject): boolean;
    procedure PrepareTablesOnError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure SendNotificationHandler(msq: string; msgType: TLogMessageType);
    function GetActive: boolean;
    function GetRemoteChangeLog(RemoteConn, LocalConn: TMyConnection;
      Json: TJsonObject; TruncateTable: boolean; var msg: string): boolean;
    procedure DoSyncSite(siteConfig: TRemoteDatabase; aServer, aDatabase: string; SyncType: TDataSynchronizeType);
  public
    constructor create;
    destructor Destroy; override;
    property Config: TServerConfig read fConfig;
    property Schema: TJSONObject read fSchema;
    property Logger: TLoggerBase read fLogger write SetLogger;
    property Active: boolean read GetActive write SetActive;
    property DataSyncList: TDataSyncList read fDataSyncList;
    procedure SyncSite(siteConfig: TRemoteDatabase; aServer, aDatabase: string);
    property OnBeforeGetActive: TNotifyEvent read fOnBeforeGetActive write fOnBeforeGetActive;
    property DbPreCheckDone: boolean read fDbPreCheckDone write fDbPreCheckDone;
  end;

  TConnectionRec = class
  private
  public
    ServerName: string;
    DatabaseName: string;
    RetryLevel: integer;
    RetryCount: integer;
    LastRetry: TDateTime;
  end;

  TConnectionMgr = class
  private
    fList: TObjectList;
    fLogger: TLoggerBase;
  public
    constructor Create;
    destructor Destroy; override;
    property Logger: TLoggerBase read fLogger write fLogger;
    function Connect(Conn: TMyConnection; aServer, aDatabase: string): boolean;
    procedure Reset;
  end;

  TSyncRec = class
  public
    DatabaseName: string;
    LastTime: TDateTime;
  end;

  TSyncTimer = class
  private
    function GetItem(x: integer): TSyncRec;
  private
    fList: TObjectList;
    property Items[x: integer]: TSyncRec read GetItem;
  public
    constructor Create;
    destructor Destroy; override;
    function TimeToDoSync(aDatabaseName: string; aCheckInterval: TDateTime): boolean;
    procedure Clear;
  end;

  TTimestampItem = class
  public
    Server: string;
    Database: string;
    Table: string;
    TimeStamp: TDateTime;
  end;

//  TTimestampList = class
//  private
//    fList: TObjectList;
//    function GetTimestamp(aServer, aDatabase, aTable: string): TDateTime;
//    procedure SetTimestamp(aServer, aDatabase, aTable: string;
//      const Value: TDateTime);
//  public
//    constructor Create;
//    destructor Destroy; override;
//    procedure Clear;
//    property Timestamp[aServer, aDatabase, aTable: string]: TDateTime read GetTimestamp write SetTimestamp;
//  end;

implementation

uses
  Forms, dialogs, DecimalRounding, MultisiteUtils,
  MyDump, SystemLib, windows;

//  TLogMessageType = (ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug);

{ TDataSynchronizer }

constructor TDataSynchronizer.create;
begin
  fActive:= false;
  fDbPreCheckDone:= false;
  SyncTimer:= TSyncTimer.Create;
  fDataSyncList:= TDataSyncList.Create;
  fDataSyncList.OnSendNotification:= self.SendNotificationHandler;
  fSchema:= TJSONObject.Create;
  fConfig:= TServerConfig.Create;
  SrcConn:= dbUtils.GetNewDbConnection();
  DestConn:= dbUtils.GetNewDbConnection();
  ConnMgr:= TConnectionMgr.Create;
  SyncObjList:= TStringList.Create;
//  TimestampList:= TTimeStampList.Create;
end;

destructor TDataSynchronizer.Destroy;
begin
//  TimestampList.Free;
  SyncTimer.Free;
  fDataSyncList.Free;
  SyncObjList.Free;
  fSchema.Free;
  fConfig.Free;
  SrcConn.Free;
  DestConn.Free;
  ConnMgr.Free;
  inherited;
end;

procedure TDataSynchronizer.SetActive(const Value: boolean);
var
  node: TJSONObject;
  x: integer;
begin
  if fActive <> Value then begin
    fActive := Value;
    if Value then begin
//      TimestampList.Clear;
      SendStatus('Started');
      SyncObjList.Clear;
      node:= Schema.ObjectByName['ObjectsToSync'];
      for x:= 0 to node.Count -1 do
        SyncObjList.Add(node.Items[x].Name);
      fDataSyncList.Schema:= Schema;
    end
    else
      SendStatus('Stopped');
  end;
end;

procedure TDataSynchronizer.SyncSite(siteConfig: TRemoteDatabase; aServer, aDatabase: string);
begin
  DoSyncSite(siteConfig, aServer, aDatabase, dstReadFromRemote);
  DoSyncSite(siteConfig, aServer, aDatabase, dstWriteToRemote);
end;

procedure TDataSynchronizer.DoSyncSite(siteConfig: TRemoteDatabase; aServer, aDatabase: string; SyncType: TDataSynchronizeType);
var
  siteCode, sourceSiteCode: string;
  qry: TMyQuery;
  qryLocal: TMyQuery;
//  qryRemote: TMyQuery;
  msg: string;
  x: integer;
  timeStart, timeEnd: TDateTime;
//  timeStatus: TDateTime;
//  dt: TDateTime;
  node: TJSONObject;
//  groupField: string;
  NeedsUpdating: boolean;
//  IsList: boolean;
  GlobalRefList: string;
  UpdateCount: integer;
  ForceSync: boolean;
  allOk: boolean;
  lastGroupId: integer;
  DestServer, DestDatabase: string;
  SrcServer, SrcDatabase: string;
const
  FiveSecs = (1/24/60/60) * 5;

  function FromStr: string;
  begin
    result:= '(From: ' + SrcConn.Server + ' - ' + SrcConn.Database +
      '  To: ' + DestConn.Server + ' - ' + DestConn.Database + ')';
  end;

begin
  try
    if SyncType = dstReadFromRemote then begin
      DestServer:= aServer;
      DestDatabase:= aDatabase;
      SrcServer:= siteConfig.MySQLServer;
      SrcDatabase:= siteConfig.DatabaseName;
    end
    else begin
      DestServer:= siteConfig.MySQLServer;
      DestDatabase:= siteConfig.DatabaseName;
      SrcServer:= aServer;
      SrcDatabase:= aDatabase;
    end;
    if ConnMgr.Connect(DestConn, DestServer, DestDatabase) and
      ConnMgr.Connect(SrcConn, SrcServer, SrcDatabase) then begin
      try
        if not CheckVersions(SrcConn,DestConn,msg) then begin
          Logger.Log('Error while synchronizing - database version mismatch: '+ msg,ltError);
          exit;
        end;
        siteCode:= dbUtils.GetDefaultSiteCode(DestConn);
        if Trim(siteCode) = '' then begin
          Logger.Log('Error while synchronizing - Local database Site Code is blank.',ltError);
          exit;
        end;
        sourceSiteCode:= dbUtils.GetDefaultSiteCode(SrcConn);
        if Trim(sourceSiteCode) = '' then begin
          Logger.Log('Error while synchronizing - Remote database Site Code is blank.',ltError);
          exit;
        end;
        if sourceSiteCode = siteCode then begin
          Logger.Log('Error while synchronizing - Remote and Local database Site Codes are the same, these must be unique between sites.',ltError);
          Logger.Log('    Source - Server: "' + SrcConn.Server + '" Database: "' + SrcConn.Database + '" SiteCode: "' + sourceSiteCode + '"' ,ltInfo);
          Logger.Log('    Destination - Server: "' + DestConn.Server + '" Database: "' + DestConn.Database + '" SiteCode: "' + SiteCode + '"' ,ltInfo);
          exit;
        end;
        { check that we multisite change log table and all triggers exist on
          both source and destination databases }
        if not DbPreCheckDone then begin
          if CreateMSChangeLogTable(DestConn,msg) and CheckCreateMSTriggers(DestConn,msg) then begin
            DbPreCheckDone:= true;
          end
          else begin
            Logger.Log('Error while synchronizing - ' + msg,ltError);
            exit;
          end;
        end;
        if not siteConfig.DbPreCheckDone then begin
          if CreateMSChangeLogTable(SrcConn,msg) and CheckCreateMSTriggers(SrcConn,msg) and
          CheckRemoteSite(SrcConn,DestConn,SyncType,msg) then begin
            siteConfig.DbPreCheckDone:= true;
          end
          else begin
            Logger.Log('Error while synchronizing - ' + msg,ltError);
            exit;
          end;
        end;

        fDataSyncList.SourceConn:= SrcConn;
        fDataSyncList.DestConn:= DestConn;
//        fDataSyncList.DestTimeDiffToAdd:= self.GetDestTimeDiffToAdd(SrcConn,DestConn);
//        fDataSyncList.DestTimeZoneMins:= self.GetTimeZoneMins(DestConn);
        qry:= TMyQuery.Create(nil);
        qryLocal:= TMyQuery.Create(nil);
//        qryRemote:= TMyQuery.Create(nil);
        try
          qryLocal.Connection:= DestConn;
//          qryRemote.Connection:= SrcConn;
          qry.Connection:= SrcConn;
          for x:= 0 to SyncObjList.Count-1 do begin
            AllOk:= true;
            { this is the main loop through all objects to be sych'd }
            UpdateCount:= 0;
            ForceSync:= false;
            Application.ProcessMessages;
            if not Active then break;
            try
              self.SendStatus('Checking - ' +
                SrcConn.Server + ' - ' + SrcConn.Database + ' - ' +
                '(Object ' + IntToStr(x + 1) + ' of ' + IntToStr(SyncObjList.Count) + ') ' +
                SyncObjList[x]);
              if PrepareTables(SyncObjList[x],fDataSyncList.Schema) then begin

//              if SyncObjList[x] = 'TProduct' then
//                self.SendStatus('Starting TProduct');


                node:= fDataSyncList.Schema.O[SyncObjList[x]];
//                if not GetRemoteChangeLog(SrcConn,DestConn,node,msg) then begin
//                  Logger.Log('Error while reading remote change log - ' + msg,ltError);
//                  continue;
//                end;

//                IsList:= false;
                if node.Exists('ForceSync') and node.B['ForceSync'] then
                  ForceSync:= true;
//                qryRemote.SQL.Clear;

//                dt:= TimestampList.Timestamp[SrcConn.Server, SrcConn.Database,SyncObjList[x]];
//                groupField:= node.StringByName['GroupField'];
//                if groupField <> '' then begin
//
//                  continue;
//
//                  IsList:= true;
//                  qryRemote.SQL.Add('select Globalref,');
//                  qryRemote.SQL.Add('max('+MS_Change_Log_Table+'.UTCTimeStamp) as UTCTimeStamp,');
//                  qryRemote.SQL.Add(MS_Change_Log_Table+'.SiteCode as SiteCode,');
//                  qryRemote.SQL.Add(MS_Change_Log_Table+'.EditVersion as EditVersion,');
//                  qryRemote.SQL.Add(groupField);
//                  qryRemote.SQL.Add('from ' + node.StringByName['TableName'] + ', ' +MS_Change_Log_Table);
//                  qryRemote.SQL.Add('where ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(node.S['TableName']));
//                  qryRemote.SQL.Add('and ' + node.S['TableName'] + '.' + node.S['IdFieldName'] + ' = '+MS_Change_Log_Table+'.TableId');
//                  if dt > 0 then begin
//                    qryRemote.SQL.Add('and '+MS_Change_Log_Table+'.UTCTimeStamp >= "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',dt) + '"');
//                    if node.Exists('Filter') then
//                      qryRemote.SQL.Add('and ' + node.StringByName['Filter']);
//                  end
//                  else begin
//                    if node.Exists('Filter') then
//                      qryRemote.SQL.Add('and ' + node.StringByName['Filter']);
//                  end;
//                  qryRemote.SQL.Add('group by ' + groupField);
//                  qryRemote.SQL.Add('order by ' +MS_Change_Log_Table+'.UTCTimeStamp');
//                end
//                else begin
//                  { no grouping }
//                  qryRemote.SQL.Add('select Globalref, msTimeStamp');
//                  qryRemote.SQL.Add('from ' + node.StringByName['TableName']);
//
//                  qryRemote.SQL.Add('select Globalref, '+MS_Change_Log_Table+'.UTCTimeStamp as UTCTimeStamp');
//                  qryRemote.SQL.Add('from ' + node.S['TableName'] + ', ' +MS_Change_Log_Table);
//                  qryRemote.SQL.Add('where ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(node.S['TableName']));
//                  qryRemote.SQL.Add('and ' + node.S['TableName'] + '.' + node.S['IdFieldName'] + ' = '+MS_Change_Log_Table+'.TableId');
//                  if dt > 0 then begin
//                    qryRemote.SQL.Add('and '+MS_Change_Log_Table+'.UTCTimeStamp >= "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',dt) + '"');
//                    if node.Exists('Filter') then
//                      qryRemote.SQL.Add('and ' + node.StringByName['Filter']);
//                  end
//                  else begin
//                    if node.Exists('Filter') then
//                      qryRemote.SQL.Add('where ' + node.StringByName['Filter']);
//                  end;
//                  qryRemote.SQL.Add('order by ' +MS_Change_Log_Table+'.UTCTimeStamp');
//                end;

//
//                qryLocal.SQL.Clear;
//                qryLocal.SQL.Add('select Globalref, '+MS_Change_Log_Table+'.UTCTimeStamp as UTCTimeStamp');
//                qryLocal.SQL.Add('from ' + node.S['TableName'] + ', ' +MS_Change_Log_Table);
//                qryLocal.SQL.Add('where ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(node.S['TableName']));
//                qryLocal.SQL.Add('and ' + node.S['TableName'] + '.' + node.S['IdFieldName'] + ' = '+MS_Change_Log_Table+'.TableId');
//                qryLocal.SQL.Add('and GlobalRef = :GlobalRefVal');

                NeedsUpdating:= true;

                qryLocal.SQL.Clear;
                qryLocal.SQL.Add('select distinct ' + Remote_MS_Change_Log_Table + '.GlobalRef,');
                qryLocal.SQL.Add(Remote_MS_Change_Log_Table + '.GroupId');
                qryLocal.SQL.Add('from ' + Remote_MS_Change_Log_Table);
                qryLocal.SQL.Add('left join '+MS_Change_Log_Table+' using (TableName, GlobalRef)');
                qryLocal.SQL.Add('where ' + Remote_MS_Change_Log_Table + '.TableName = ' + QuotedStr(node.S['TableName']));
                qryLocal.SQL.Add('and ((tblRemoteMSChangeLog.SiteCode <> ifnull(tblMSChangeLog.SiteCode,"")');
                qryLocal.SQL.Add('or tblRemoteMSChangeLog.EditVersion <> ifnull(tblMSChangeLog.EditVersion,0))');
                qryLocal.SQL.Add('and (tblRemoteMSChangeLog.UTCTimeStamp > ifnull(tblMSChangeLog.UTCTimeStamp,0))');
                qryLocal.SQL.Add('or (tblRemoteMSChangeLog.UTCTimeStamp > ifnull(tblMSChangeLog.UTCTimeStamp,0) and');
                qryLocal.SQL.Add('tblRemoteMSChangeLog.SiteCode > ifnull(tblMSChangeLog.SiteCode,"")))');
                qryLocal.SQL.Add('order by ' + Remote_MS_Change_Log_Table + '.GroupId,' + Remote_MS_Change_Log_Table + '.UTCTimeStamp');

                qryLocal.Open;

                try
//                  self.SendStatus('Checking - ' +
//                    SrcConn.Server + ' - ' + SrcConn.Database + ' - ' +
//                    '(Object ' + IntToStr(x + 1) + ' of ' + IntToStr(SyncObjList.Count) + ') ' +
//                    SyncObjList[x] + ' ' + IntToStr(qryLocal.RecNo) + ' of ' +
//                    IntToStr(qryLocal.RecordCount));
//                  timeStatus:= now;
                  while not qryLocal.Eof do begin
                    Application.ProcessMessages;
                    if not Active then break;
                    Sleep(5);

//                    if (timeStatus + FiveSecs) < now then begin
//                      timeStatus:= now;
                      self.SendStatus('Checking - ' +
                        SrcConn.Server + ' - ' + SrcConn.Database + ' - ' +
                        '(Object ' + IntToStr(x + 1) + ' of ' + IntToStr(SyncObjList.Count) + ') ' +
                        SyncObjList[x] + ' ' + IntToStr(qryLocal.RecNo) + ' of ' +
                        IntToStr(qryLocal.RecordCount));
//                    end;

//                    NeedsUpdating:= false;
                    if qryLocal.FieldByName('GlobalRef').AsString <> '' then begin
//                      qryLocal.Close;
//                      qryLocal.ParamByName('GlobalRefVal').AsString:= qryRemote.FieldByName('GlobalRef').AsString;
//                      qryLocal.Open;
//                      if not qryLocal.IsEmpty then begin
//                        { exists on local system }
//                        if ForceSync then begin
//                          NeedsUpdating:= true;
//                        end
//                        else if (qryLocal.FieldByName('UTCTimeStamp').AsDateTime +
//                          fDataSyncList.DestTimeDiffToAdd) <
//                          qryRemote.FieldByName('UTCTimeStamp').AsDateTime then begin
//                          NeedsUpdating:= true;
//                        end;
//                      end
//                      else begin
//                        { does not exist on local system }
//                        NeedsUpdating:= true;
//                      end;
                      if NeedsUpdating then begin
                        timeStart:= now;

//                        if IsList and (qryRemote.FieldByName(groupField).AsString <> '') then begin
//                          GlobalRefList:= '';
//                          qry.SQL.Clear;
//                          qry.SQL.Add('select Globalref');
//                          qry.SQL.Add('from ' + node.StringByName['TableName']);
//                          qry.SQL.Add('where ' + groupField + ' = ' +
//                            QuotedStr(qryRemote.FieldByName(groupField).AsString));
//                          qry.Open;
//                          while not qry.Eof do begin
//                            if GlobalRefList <> '' then
//                              GlobalRefList:= GlobalRefList + ',';
//                            GlobalRefList:= GlobalRefList +
//                              qry.FieldByName('GlobalRef').AsString;
//                            qry.Next;
//                          end;
//                          qry.Close;
//                        end
//                        else begin
//                          GlobalRefList:= qryRemote.FieldByName('GlobalRef').AsString;
//                        end;

                        GlobalRefList:= qryLocal.FieldByName('GlobalRef').AsString;

                        if (qryLocal.FieldByName('GroupId').AsInteger > 0) and (not qryLocal.Eof) then begin
                          lastGroupId:= qryLocal.FieldByName('GroupId').AsInteger;
                          while (qryLocal.FieldByName('GroupId').AsInteger = lastGroupId) and (not qryLocal.Eof) do begin
                            qryLocal.Next;
                            GlobalRefList:= GlobalRefList + ',' + qryLocal.FieldByName('GlobalRef').AsString;
                          end;
                          if not qryLocal.Eof then
                            qryLocal.Prior;
                        end;

                        self.SendStatus('Updating: ' + SyncObjList[x] +
                          ' [' + GlobalRefList + ']');

//                        qryLocal.Next;
//                        continue;

                        if SameText(SyncObjList[x],'TEmployeeDetails') then
                          Logger.Log('');;
                        case fDataSyncList.SyncObjects(SyncObjList[x],GlobalRefList,msg) of
                          srOk:
                            begin
                              timeEnd:= now;
                              Logger.Log(IntToStr(qryLocal.RecNo) + ' of ' + IntToStr(qryLocal.RecordCount)+
                                ' Synchronization ok for object "' +
                                SyncObjList[x] + '" [' +
                                GlobalRefList +
                                '] (Time: '+ FormatDateTime('hh:nn:ss zzz',timeEnd - timeStart) + ') ' + FromStr,ltDetail);
                            end;
                          srTempFail:
                            begin
                              allOk:= false;
                              timeEnd:= now;
                              Logger.Log(IntToStr(qryLocal.RecNo) + ' of ' + IntToStr(qryLocal.RecordCount)+
                                ' Synchronization falied for object "' +
                                SyncObjList[x] + '" [' +
                                GlobalRefList +
                                '] with message: "' + msg + '"' +
                                ' (Time: '+ FormatDateTime('hh:nn:ss zzz',timeEnd - timeStart) + ') '+FromStr,ltWarning);
                            end;
                          srPermFail:
                            begin
                              allOk:= false;
                              timeEnd:= now;
                              Logger.Log(IntToStr(qryLocal.RecNo) + ' of ' + IntToStr(qryLocal.RecordCount)+
                                ' Synchronization falied for object "' +
                                SyncObjList[x] + '" [' +
                                GlobalRefList +
                                '] with message: "' + msg + '"' +
                                ' (Time: '+ FormatDateTime('hh:nn:ss zzz',timeEnd - timeStart) + ') '+FromStr,ltError);
                            end;
                        end;


                        self.SendStatus('Checking - ' +
                        '(Object ' + IntToStr(x + 1) + ' of ' + IntToStr(SyncObjList.Count) + ') ' +
                          SrcConn.Server + ' - ' + SrcConn.Database + ' - ' +
                          SyncObjList[x]);

                        if not ForceSync then begin
                          Inc(UpdateCount);
                          if UpdateCount > 99 then begin
                            Logger.Log('More than ' + IntToStr(UpdateCount) +
                              ' found for updating, continue next pass.',ltInfo);
                            Break;
                          end;
                        end;
                      end;
                    end;
                    if AllOk then begin
//                      if qryRemote.FieldByName('msTimeStamp').AsDateTime > dt then begin
//                        dt:= qryRemote.FieldByName('msTimeStamp').AsDateTime;
//                        TimestampList.Timestamp[SrcConn.Server, SrcConn.Database,SyncObjList[x]]:= dt;
//                      end;
                    end;
                    qryLocal.Next;
                  end;
//                  self.SendStatus('Idle');
                finally
//                  qryRemote.Close;
                  qryLocal.Close;
                end;
              end; { if PrepareTables }
            except
              on e: exception do begin
                Logger.Log('Synchronization falied while processing object "' +
                  SyncObjList[x] + '" with message ' + e.Message +
                  ' ... continue with next object type.',ltInfo);
                Continue;
              end;
            end
          end; { for x }
          self.SendStatus('Idle');
        finally
          qry.Free;
          qryLocal.Free;
//          qryRemote.Free;
        end;
      finally
        DestConn.Disconnect;
        SrcConn.Disconnect;
      end;
    end;
  except
    on E: Exception do begin
      Logger.Log('Error while synchronizing with message: ' + E.Message,ltError);
    end;
  end;
end;

procedure TDataSynchronizer.SetLogger(const Value: TLoggerBase);
begin
  fLogger := Value;
  ConnMgr.Logger:= Value;
end;

//function TDataSynchronizer.GetDestTimeDiffToAdd(src, dst: TMyConnection): TDateTime;
//var
//  qry: TMyQuery;
//  srcTime, dstTime: TDateTime;
//begin
//  qry:= TMyQuery.Create(nil);
//  try
//    qry.SQL.Text:= 'select current_timestamp';
//    qry.Connection:= src;
//    qry.Open;
//    srcTime:= qry.Fields[0].AsDateTime;
//    qry.Close;
//    qry.Connection:= dst;
//    qry.Open;
//    dstTime:= qry.Fields[0].AsDateTime;
//    qry.Close;
//    result:= DecimalRoundDbl((dstTime - srcTime), 3, drHalfUp);
//    { round to 5 secs }
//  finally
//    qry.Free;
//  end;
//end;

function TDataSynchronizer.GetRemoteChangeLog(RemoteConn, LocalConn: TMyConnection;
  Json: TJsonObject; TruncateTable: boolean; var msg: string): boolean;
var
  Dump: TMyDump;
  tempFileName1, tempFileName2: string;
  InStream, OutStream: TFileStream;
  StreamReader: TStreamReader;
  StreamWriter: TStreamWriter;
  s, sql: string;
begin
  result:= true;
  try
    tempFileName1:= GetLocalAppDataDir + 'tempRemoteMsChangeLogData1.sql';
    tempFileName2:= GetLocalAppDataDir + 'tempRemoteMsChangeLogData2.sql';
    Dump:= TMyDump.Create(nil);
    try
      Dump.Connection:= RemoteConn;
//      Dump.TableNames:= MS_Change_Log_Table;
      Dump.Options.AddLock:= false;
      Dump.Options.DisableKeys:= false;
      Dump.Options.HexBlob:= false;
      Dump.Options.UseExtSyntax:= true;
      Dump.Options.UseDelayedIns:= false;
      Dump.Options.GenerateHeader:= false;
      Dump.Options.AddDrop:= false;
      Dump.Options.QuoteNames:= false;
      Dump.Options.CompleteInsert:= false;
      Dump.Objects:= [doData];
      sql:=
        ' select ' +
        MS_Change_Log_Table + '.TableName,' +
        MS_Change_Log_Table + '.TableId,' +
        MS_Change_Log_Table + '.GlobalRef,';
      if Json.StringExists('GroupField') then
        sql:= sql + Json.S['TableName'] + '.' + Json.S['GroupField'] + ' as GroupId,'
      else
        sql:= sql + '0 as GroupId,';
      sql:= sql +
        MS_Change_Log_Table + '.SiteCode,' +
        MS_Change_Log_Table + '.EditVersion,' +
        MS_Change_Log_Table + '.UTCTimeStamp' +
        ' from ' + MS_Change_Log_Table + ', ' + Json.S['TableName'] +
        ' where ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(Json.S['TableName']) +
        ' and ' + MS_Change_Log_Table + '.TableId = ' + Json.S['TableName'] + '.' + Json.S['IdFieldName'];
      if Json.StringExists('Filter') then
        sql:= sql + ' and ' + Json.S['Filter'];

      Dump.BackupToFile(tempFileName1,sql);
      sysutils.DeleteFile(tempFileName2);

      InStream:= TFileStream.Create(tempFileName1,fmOpenRead);
      StreamReader:= TStreamReader.Create(InStream);
      OutStream:= TFileStream.Create(tempFileName2,fmCreate);
      StreamWriter:= TStreamWriter.Create(OutStream);
      try
        if TruncateTable then
          StreamWriter.WriteLine('truncate table ' + Remote_MS_Change_Log_Table + ';');
        while not StreamReader.EndOfStream do begin
          s:= StreamReader.ReadLine;
          if Pos('INSERT INTO',s) > 0 then
            s:= StringReplace(s,MS_Change_Log_Table,Remote_MS_Change_Log_Table,[rfIgnoreCase]);
          StreamWriter.WriteLine(s);
        end;

      finally
        StreamReader.Free;
        StreamWriter.Free;
        InStream.Free;
        OutStream.Free;
      end;
      Dump.Connection:= LocalConn;
      Dump.RestoreFromFile(tempFileName2);
    finally
      Dump.Free;
      sysutils.DeleteFile(tempFileName1);
      sysutils.DeleteFile(tempFileName2);
    end;
  except
    on e: exception do begin
      result:= false;
      msg:= 'Failed to read remote site change log with message: ' + e.Message;
    end;
  end;
end;

procedure TDataSynchronizer.SendStatus(msg: string);
begin
  Logger.Events.FireEvent(nil,'Status',msg);
end;

function TDataSynchronizer.CheckVersions(src, dst: TMyConnection; var msg: string): boolean;
var
  qry: TMyQuery;
  srcVersion, dstVersion: string;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.SQL.Text:= 'select version from tblupdatedetails';
    qry.Connection:= src;
    qry.Open;
    srcVersion:= qry.Fields[0].AsString;
    qry.Close;
    qry.Connection:= dst;
    qry.Open;
    dstVersion:= qry.Fields[0].AsString;
    qry.Close;
    result:= dstVersion = srcVersion;
    msg:= 'Source (' + src.Database + '@' + src.Server + ') version = ' + srcVersion +
    ' Destination (' + dst.Database + '@' + dst.Server + ') version = ' + dstVersion;
  finally
    qry.Free;
  end;
end;

{ 1. Make sure tables have global ref
  2. Make sure there are no zero msTimeStamp values (delphi epoch is diff than MySQL)
  3. Update msTimeStamp back up chain from child objects to top level object }
function TDataSynchronizer.PrepareTables(aClassName: string;
  Schema: TJSONObject): boolean;
var
  sl, ClassNameList: TStringList;
  script: TMyScript;
  aObj: TJSONObject;
  idx, x: integer;
  sql, msg: string;

  function ActualClassName(aName: string): string;
  var obj: TJSONObject;
  begin
    result:= aName;
    obj:= Schema.ObjectByName[aName];
    while Assigned(obj) and obj.Exists('InheritsFrom') do begin
      result:= obj.StringByName['InheritsFrom'];
      obj:= Schema.ObjectByName[result];
    end;
  end;

  procedure GetSubObjects(aName: string);
  var
    x: integer;
    obj, SubObjList, subObjDef, subObj: TJSONObject;
    currClassName, parentTable, childTable: string;
    parentIdFieldName, childIdFieldName: string;
    subSql: string;
  begin
    ClassNameList.Add(aName);
    obj:= schema.ObjectByName[ActualClassName(aName)];
    parentTable:= obj.StringByName['TableName'];
    parentIdFieldName:= obj.StringByName['IdFieldName'];
    SubObjList:= obj.ObjectByName['Objects'];
    if Assigned(SubObjList) then begin
      for x:= 0 to SubObjList.Count-1 do begin
        subObjDef:= TJSONObject(SubObjList.Items[x].Value);
        currClassName:= subObjDef.StringByName['ClassName'];
        if Lowercase(currClassName) <> 'parent' then begin
          subObj:= schema.ObjectByName[currClassName];
          childTable:= subObj.StringByName['TableName'];
          childIdFieldName:= subObj.StringByName['IdFieldName'];
          subSql:= '';
          subSql:= 'update ' + childTable +
            ' set Globalref = Concat((select SiteCode from tblmsbackendid where BEDefault = "T") ,' +
            subObj.StringByName['IdFieldName']  + ') where IsNull(Globalref) or (Globalref = "")';
          if subObj.Exists('Filter') then
            subSql:= subSql + ' and ' + subObj.StringByName['Filter'];
          subSql:= subSql + ';';
          sl.Add(subSql);
          { make sure the Multisite change log table has one entry for each
            record in the sub table we are going to process }
          subSql:= '';
          subSql:= 'insert into '+MS_Change_Log_Table+' (TableName,TableId,GlobalRef,SiteCode,EditVersion,UTCTimeStamp)' +
                ' select '+QuotedStr(childTable)+','+childTable+'.'+childIdFieldName+','+childTable+'.GlobalRef,(select SiteCode from tblmsbackendid where BEDefault = "T"),1,0' +
                ' from ' + childTable +
                ' left join '+MS_Change_Log_Table+' cl on cl.TableName = '+QuotedStr(childTable)+' and cl.TableId = '+childTable+'.'+childIdFieldName+
                ' where IsNull(cl.TableId)';
          if subObj.Exists('Filter') then
            subSql:= subSql + ' and ' + subObj.StringByName['Filter'];
          subSql:= subSql + ';';
          sl.Add(subSql);

          { update Change Log GlobalRefs for child table }
          subSql:=
            'update ' + MS_Change_Log_Table + ',' + childTable +
            ' set ' + MS_Change_Log_Table + '.GlobalRef = ' + childTable + '.GlobalRef' +
            ' where ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(childTable) +
            ' and ' + MS_Change_Log_Table + '.TableId = ' + childTable + '.' + childIdFieldName +
            ' and IsNull(' + MS_Change_Log_Table + '.GlobalRef);';
          sl.Add(subSql);

//          subSql:= '';
//          subSql:= 'update ' + parentTable + ',' + childTable +
//            ' set ' + parentTable + '.msTimeStamp = ' + childTable + '.msTimeStamp' +
//            ' where ' + parentTable + '.' + subObjDef.ObjectByName['Link'].StringByName['ParentField'] +
//            ' = ' + childTable + '.' + subObjDef.ObjectByName['Link'].StringByName['LinkField'] +
//            ' and ' + childTable + '.msTimeStamp > ' + parentTable + '.msTimeStamp';
          subSql:=
            'update '+MS_Change_Log_Table+' pcl, '+MS_Change_Log_Table+' ccl, '+parentTable+', '+childTable +
            '   set pcl.SiteCode = ccl.SiteCode,' +
            '   pcl.EditVersion = pcl.EditVersion + 1,' +
            '   pcl.UTCTimeStamp = ccl.UTCTimeStamp' +
            ' where ' + parentTable + '.' + subObjDef.O['Link'].S['ParentField'] +
            ' = ' + childTable + '.' + subObjDef.O['Link'].S['LinkField'] +
            ' and (pcl.TableName = '+QuotedStr(parentTable)+' and pcl.TableId = '+parentTable+'.'+parentIdFieldName+')' +
            ' and (ccl.TableName = '+QuotedStr(childTable)+' and ccl.TableId = '+childTable+'.'+childIdFieldName+')' +
            ' and ccl.UTCTimeStamp > pcl.UTCTimeStamp';
          if subObj.Exists('Filter') then
            subSql:= subSql + ' and ' + subObj.StringByName['Filter'];
          subSql:= subSql + ';';
          sl.Add(subSql);
        end;
        GetSubObjects(currClassName);
      end;
    end;
  end;

begin
  result:= false;
  sl:= TStringList.Create;
  ClassNameList:= TStringList.Create;
  script:= TMyScript.Create(nil);
  try
    script.OnError:= PrepareTablesOnError;
    GetSubObjects(aClassName);
    aObj:= schema.ObjectByName[ActualClassName(aClassName)];
    sql:= 'update ' + aObj.StringByName['TableName'] +
      ' set Globalref = Concat((select SiteCode from tblmsbackendid where BEDefault = "T") ,' +
      aObj.StringByName['IdFieldName']  + ') where IsNull(Globalref) or (Globalref = "")';
    if aObj.Exists('Filter') then
      sql:= sql + ' and ' + aObj.StringByName['Filter'];
    sql:= sql + ';';
    script.SQL.Add(sql);

    { make sure the Multisite change log table has one entry for each record in
      the table we are going to process }
    sql:= 'insert into '+MS_Change_Log_Table+' (TableName,TableId,GlobalRef,SiteCode,EditVersion,UTCTimeStamp)' +
          ' select '+QuotedStr(aObj.S['TableName'])+','+aObj.S['TableName']+'.'+aObj.S['IDFieldName']+','+aObj.S['TableName']+'.GlobalRef,(select SiteCode from tblmsbackendid where BEDefault = "T"),1,0' +
          ' from ' + aObj.S['TableName']+
          ' left join '+MS_Change_Log_Table+' cl on cl.TableName = '+QuotedStr(aObj.S['TableName'])+' and cl.TableId = '+aObj.S['TableName']+'.'+aObj.S['IDFieldName']+
          ' where IsNull(cl.TableId)';
    if aObj.Exists('Filter') then
      sql:= sql + ' and ' + aObj.StringByName['Filter'];
    sql:= sql + ';';
    script.SQL.Add(sql);

    { update change log  GlobalRef's }
    sql:=
      'update ' + MS_Change_Log_Table + ',' + aObj.S['TableName'] +
      ' set ' + MS_Change_Log_Table + '.GlobalRef = ' + aObj.S['TableName'] + '.GlobalRef' +
      ' where ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(aObj.S['TableName']) +
      ' and ' + MS_Change_Log_Table + '.TableId = ' + aObj.S['TableName'] + '.' + aObj.S['IDFieldName'] +
      ' and IsNull(' + MS_Change_Log_Table + '.GlobalRef);';
    script.SQL.Add(sql);

    { deal with grouped items }
    if aObj.StringExists('GroupField') then begin

    end;

    for idx:= sl.Count-1 downto 0 do
      script.SQL.Add(sl[idx]);

    { now run script on both source and dest database }
    DestConn.StartTransaction;
    SrcConn.StartTransaction;
    try
      script.Connection:= DestConn;
      try
        script.Execute;
      except
        on e: exception do begin
          if Pos('Lock wait timeout exceeded',e.Message) > 0 then begin
            Logger.Log('Unable to prepare tables on local database "' +
              DestConn.Server + '.' + DestConn.Database + '" (Lock Wait), skipping this pass.', ltWarning);
          end
          else if Pos('Deadlock found',e.Message) > 0 then begin
            Logger.Log('Unable to prepare tables on local database "' +
              DestConn.Server + '.' + DestConn.Database + '" (Deadlock), skipping this pass.', ltWarning);
          end
          else begin
            Logger.Log('Prepare tables failed on local  database "' +
              DestConn.Server + '.' + DestConn.Database + '" with message: ' + e.Message, ltError);
          end;
          exit;
        end;
      end;
      script.Connection:= SrcConn;
      try
        script.Execute;
      except
        on e: exception do begin
          if Pos('Lock wait timeout exceeded',e.Message) > 0 then begin
            Logger.Log('Unable to prepare tables on remote database "' +
              SrcConn.Server + '.' + SrcConn.Database + '" (Lock Wait), skipping this pass.', ltWarning);
          end
          else if Pos('Deadlock found',e.Message) > 0 then begin
            Logger.Log('Unable to prepare tables on remote database "' +
              SrcConn.Server + '.' + SrcConn.Database + '" (Deadlock), skipping this pass.', ltWarning);
          end
          else begin
            Logger.Log('Prepare tables failed on remote database "' +
              SrcConn.Server + '.' + SrcConn.Database + '" with message: ' + e.Message, ltError);
          end;
          exit;
        end;
      end;
      for x := 0 to ClassNameList.Count-1 do begin
        aObj:= schema.ObjectByName[ActualClassName(ClassNameList[x])];
        if not GetRemoteChangeLog(SrcConn,DestConn,aObj,x=0,msg) then begin
          Logger.Log('Unable to read change log table on remote database "' +
            SrcConn.Server + '.' + SrcConn.Database + '": ' + msg +' Skipping this pass.', ltWarning);
          exit;
        end;
      end;
      DestConn.Commit;
      SrcConn.Commit;
      result:= true;
    finally
      if DestConn.InTransaction then
        DestConn.Rollback;
      if SrcConn.InTransaction then
        SrcConn.Rollback;
    end;
  finally
    sl.Free;
    ClassNameList.Free;
    script.Free;
  end;
end;

procedure TDataSynchronizer.PrepareTablesOnError(Sender: TObject;
  E: Exception; SQL: string; var Action: TErrorAction);
begin
  Action:= eaAbort;
  raise exception.Create(e.Message);
end;

//function TDataSynchronizer.GetTimeZoneMins(conn: TMyConnection): integer;
//var
//  qry: TMyQuery;
//begin
//  qry:= TMyQuery.Create(nil);
//  try
//    qry.Connection:= Conn;
//    qry.SQL.Text:= 'select timestampdiff(minute,utc_timestamp(),current_timestamp)';
//    qry.Open;
//    result:= qry.Fields[0].AsInteger;
//  finally
//    qry.Free;
//  end;
//end;

procedure TDataSynchronizer.SendNotification(msg: string; msgType: TLogMessageType);
begin
  Logger.Log('Notification:' +#13#10 + msg,msgType);
end;

procedure TDataSynchronizer.SendNotificationHandler(msq: string; msgType: TLogMessageType);
begin
  self.SendNotification(msq, msgType);
end;

function TDataSynchronizer.GetActive: boolean;
begin
  if Assigned(fOnBeforeGetActive) then
    fOnBeforeGetActive(self);
  result:= fActive;
end;

{ TConnectionMgr }

function TConnectionMgr.Connect(Conn: TMyConnection; aServer, aDatabase: string): boolean;
var
  x: integer;
  rec: TConnectionRec;
const
  level1Retrys = 20;
  level1Interval = (1/24/60/60) * 5;  // 5 secs
  level2Retrys = 20;
  level2Interval = (1/24/60/60) * 30; // 30 secs
  level3Interval = (1/24/60) * 5;     // 5 mins

  function DoConnect: boolean;
  begin
    result:= true;
    Conn.Server:= aServer;
    Conn.Database:= aDatabase;
    try
      rec.LastRetry:= now;
      Conn.Connect;
      rec.RetryLevel:= 0;
      rec.RetryCount:= 0;
    except
      result:= false;
    end;
  end;

begin
  result:= true;
  if Conn.Connected then begin
    if (Conn.Server = aServer) and (Conn.Database = aDatabase) then
      exit
    else
      Conn.Disconnect;
  end;
  rec:= nil;
  for x:= 0 to fList.Count -1 do begin
    if (TConnectionRec(fList[x]).DatabaseName = Lowercase(aDatabase)) and
      (TConnectionRec(fList[x]).ServerName = Lowercase(aServer)) then begin
      rec:= TConnectionRec(fList[x]);
      break;
    end;
  end;
  if not Assigned(rec) then begin
    rec:= TConnectionRec.Create;
    rec.DatabaseName:= Lowercase(aDatabase);
    rec.ServerName:= Lowercase(aServer);
    rec.RetryLevel:= 0;
    rec.RetryCount:= 0;
    rec.LastRetry:= 0;
    fList.Add(rec);
  end;
  if rec.RetryLevel = 0 then begin
    { last connect was ok }
    result:= DoConnect;
    if not result then begin
      Logger.Log('Connection failed for database "' + aDatabase  + '" on server "' + aServer + '" .. retrying.', ltError);
      rec.LastRetry:= now;
      rec.RetryLevel:= 1;
      rec.RetryCount:= 1;
    end;
  end
  else if rec.RetryLevel = 1 then begin
    if (now - rec.LastRetry) < level1Interval then begin
      result:= false;
      exit;
    end;
    result:= DoConnect;
    if not result then begin
      Inc(rec.RetryCount);
      if rec.RetryCount > level1Retrys - 2 then begin
        Logger.Log('Connection failed (level 2) for database "' + aDatabase  + '" on server "' + aServer + '" .. retrying.', ltError);
        rec.RetryLevel:= 2;
        rec.RetryCount:= 0;
      end;
    end;
  end
  else if rec.RetryLevel = 2 then begin
    if (now - rec.LastRetry) < level2Interval then begin
      result:= false;
      exit;
    end;
    result:= DoConnect;
    if not result then begin
      Inc(rec.RetryCount);
      if rec.RetryCount > level2Retrys - 2 then begin
        Logger.Log('Connection failed (level 3) for database "' + aDatabase  + '" on server "' + aServer + '" .. retrying.', ltError);
        rec.RetryLevel:= 3;
        rec.RetryCount:= 0;
      end;
    end;
  end
  else if rec.RetryLevel = 3 then begin
    if (now - rec.LastRetry) < level2Interval then begin
      result:= false;
      exit;
    end;  
    result:= DoConnect;
    if not result then begin
      Inc(rec.RetryCount);
    end;
  end;
end;

constructor TConnectionMgr.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TConnectionMgr.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TConnectionMgr.Reset;
begin
  fList.Clear;
end;

{ TSyncTimer }

procedure TSyncTimer.Clear;
begin
  fList.Clear;
end;

constructor TSyncTimer.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TSyncTimer.Destroy;
begin
  fList.Free;
  inherited;
end;

function TSyncTimer.GetItem(x: integer): TSyncRec;
begin
  result:= TSyncRec(fList[x]);
end;

function TSyncTimer.TimeToDoSync(aDatabaseName: string; aCheckInterval: TDateTime): boolean;
var
  x: integer;
  rec: TSyncRec;
begin
  result:= false;
  rec:= nil;
  for x:= 0 to fList.Count -1 do begin
    if Items[x].DatabaseName = aDatabaseName then begin
      rec:= Items[x];
      break;
    end;
  end;
  if not Assigned(rec) then begin
    rec:= TSyncRec.Create;
    rec.DatabaseName:= aDatabaseName;
    rec.LastTime:= now;
    fList.Add(rec);
    result:= true;
  end
  else begin
    if now - rec.LastTime > aCheckInterval then begin
      result:= true;
      rec.LastTime:= now;
    end;
  end;
end;

//{ TTimestampList }
//
//procedure TTimestampList.Clear;
//begin
//  fList.Clear;
//end;
//
//constructor TTimestampList.Create;
//begin
//  fList:= TObjectList.Create(true);
//end;
//
//destructor TTimestampList.Destroy;
//begin
//  fList.Free;
//  inherited;
//end;
//
//function TTimestampList.GetTimestamp(aServer, aDatabase, aTable: string): TDateTime;
//var
//  x: integer;
//  item: TTimestampItem;
//begin
//  result:= 0;
//  for x:= 0 to fList.Count -1 do begin
//    item:= TTimestampItem(fList[x]);
//    if (item.Server = aServer) and (item.Database = aDatabase) and (item.Table = aTable) then begin
//      result:= item.TimeStamp;
//      break;
//    end;
//  end;
//end;
//
//procedure TTimestampList.SetTimestamp(aServer, aDatabase, aTable: string;
//  const Value: TDateTime);
//var
//  x: integer;
//  item: TTimestampItem;
//  found: boolean;
//begin
//  found:= false;
//  for x:= 0 to fList.Count -1 do begin
//    item:= TTimestampItem(fList[x]);
//    if (item.Server = aServer) and (item.Database = aDatabase) and (item.Table = aTable) then begin
//      found:= true;
//      item.TimeStamp:= Value;
//      break;
//    end;
//  end;
//  if not found then begin
//    item:= TTimestampItem.Create;
//    item.Server:= aServer;
//    item.Database:= aDatabase;
//    item.Table:= aTable;
//    item.TimeStamp:= Value;
//    fList.Add(item);
//  end;
//end;

end.
