unit SynchronizerObj;

interface

uses
  MultisiteConfigObj, JSONObject, LogThreadLib, LogMessageTypes,
  MyAccess, DbUtils, classes, MemData, DBAccess, Contnrs, ObjDataSync,
  ExtCtrls, sysutils, MyScript, DAScript;

type
  TConnectionMgr = class;
  TSyncTimer = class;

  TDataSynchronizer = class
  private
    fSchema: TJSONObject;
    fConfig: TServerConfig;
    fActive: boolean;
    fLogger: TLogger;
    SrcConn, DestConn: TMyConnection;
    ConnMgr: TConnectionMgr;
    SyncTimer: TSyncTimer;
    SyncObjList: TStringList;
    fDataSyncList: TDataSyncList;
    Timer: TTimer;
    procedure SetActive(const Value: boolean);
    procedure SetLogger(const Value: TLogger);
    function GetDestTimeDiffToAdd(src, dst: TMyConnection): TDateTime;
    function GetTimeZoneMins(conn: TMyConnection): integer;
    procedure DoOnTimer(Sender: TObject);
    procedure SendStatus(msg: string);
    procedure SendNotification(msg: string);
    function CheckVersions(src, dst: TMyConnection; var msg: string): boolean;
    function PrepareTables(aClassName: string; Schema: TJSONObject): boolean;
    procedure PrepareTablesOnError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure SendNotificationHandler(msq: string);
  public
    constructor create;
    destructor Destroy; override;
    property Config: TServerConfig read fConfig;
    property Schema: TJSONObject read fSchema;
    property Logger: TLogger read fLogger write SetLogger;
    property Active: boolean read fActive write SetActive;
    property DataSyncList: TDataSyncList read fDataSyncList;
    procedure DoSync;
    procedure DoSyncDatabase(dbConfig: TDatabase; aServer: string);
    procedure DoSyncSite(siteConfig: TRemoteDatabase; aServer, aDatabase: string);
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
    fLogger: TLogger;
  public
    constructor Create;
    destructor Destroy; override;
    property Logger: TLogger read fLogger write fLogger;
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

implementation

uses
  Forms, dialogs, DecimalRounding;

//  TLogMessageType = (ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug);

{ TDataSynchronizer }

constructor TDataSynchronizer.create;
begin
  fActive:= false;
  SyncTimer:= TSyncTimer.Create;
  fDataSyncList:= TDataSyncList.Create;
  fDataSyncList.OnSendNotification:= self.SendNotificationHandler;
  fSchema:= TJSONObject.Create;
  fConfig:= TServerConfig.Create;
  SrcConn:= dbUtils.GetNewDbConnection();
  DestConn:= dbUtils.GetNewDbConnection();
  ConnMgr:= TConnectionMgr.Create;
  SyncObjList:= TStringList.Create;
  Timer:= TTimer.Create(nil);
  Timer.Enabled:= false;
  Timer.Interval:= 5000;
  Timer.OnTimer:= DoOnTimer;
end;

destructor TDataSynchronizer.Destroy;
begin
  SyncTimer.Free;
  fDataSyncList.Free;
  SyncObjList.Free;
  fSchema.Free;
  fConfig.Free;
  SrcConn.Free;
  DestConn.Free;
  ConnMgr.Free;
  Timer.Free;
  inherited;
end;

procedure TDataSynchronizer.SetActive(const Value: boolean);
var
  node: TJSONObject;
  x: integer;
begin
  fActive := Value;
  if Value then begin
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

procedure TDataSynchronizer.DoOnTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled:= false;
  try
    DoSync;
  finally
    if fActive then
      TTimer(Sender).Enabled:= true;
  end;
end;

procedure TDataSynchronizer.DoSync;
var
  x: integer;
  dbConfig: TDatabase;
begin
  for x:= 0 to Config.DatabaseList.Count -1 do begin
    Application.ProcessMessages;
    if not fActive then exit;
    dbConfig:= Config.DatabaseList[x];
    if dbConfig.SynchronizationActive and SyncTimer.TimeToDoSync(dbConfig.DatabaseName, dbConfig.CheckInterval) then begin
      SendStatus('Checking - ' + dbConfig.DatabaseName);
      DoSyncDatabase(dbConfig, Config.MySQLServer);
      SendStatus('Idle');
    end;
  end;
end;

procedure TDataSynchronizer.DoSyncDatabase(dbConfig: TDatabase; aServer: string);
var
  x: integer;
  siteConfig: TRemoteDatabase;
begin
  for x:= 0 to dbConfig.RemoteDatabaseList.Count -1 do begin
    Application.ProcessMessages;
    if not fActive then exit;
    siteConfig:= dbConfig.RemoteDatabaseList[x];
    DoSyncSite(siteConfig, aServer, dbConfig.DatabaseName);
  end;
end;

procedure TDataSynchronizer.DoSyncSite(siteConfig: TRemoteDatabase; aServer, aDatabase: string);
var
  siteCode: string;
  qry: TMyQuery;
  qryLocal, qryRemote: TMyQuery;
  msg: string;
  x: integer;
  timeStart, timeEnd: TDateTime;
  node: TJSONObject;
  groupField: string;
  NeedsUpdating: boolean;
  IsList: boolean;
  GlobalRefList: string;
  UpdateCount: integer;
  ForceSync: boolean;

begin
  try
    if ConnMgr.Connect(DestConn, aServer, aDatabase) and
      ConnMgr.Connect(SrcConn, siteConfig.MySQLServer, siteConfig.DatabaseName) then begin
      try
        if not CheckVersions(SrcConn,DestConn,msg) then begin
          Logger.Log('Error while synchronizing - database version mismatch: '+ msg,ltError);
          exit;
        end;
        siteCode:= dbUtils.GetDefaultSiteCode(DestConn);
        if siteCode = '' then exit;
        fDataSyncList.SourceConn:= SrcConn;
        fDataSyncList.DestConn:= DestConn;
        fDataSyncList.DestTimeDiffToAdd:= self.GetDestTimeDiffToAdd(SrcConn,DestConn);
        fDataSyncList.DestTimeZoneMins:= self.GetTimeZoneMins(DestConn);
        qry:= TMyQuery.Create(nil);
        qryLocal:= TMyQuery.Create(nil);
        qryRemote:= TMyQuery.Create(nil);
        try
          qryLocal.Connection:= DestConn;
          qryRemote.Connection:= SrcConn;
          qry.Connection:= SrcConn;
          for x:= 0 to SyncObjList.Count-1 do begin
            { this is the main loop through all objects to be sych'd }
            UpdateCount:= 0;
            ForceSync:= false;
            Application.ProcessMessages;
            if not fActive then break;
            try
              if PrepareTables(SyncObjList[x],fDataSyncList.Schema) then begin

                IsList:= false;
                node:= fDataSyncList.Schema.ObjectByName[SyncObjList[x]];
                if node.Exists('ForceSync') and node.BooleanByName['ForceSync'] then
                  ForceSync:= true;
                qryRemote.SQL.Clear;
                groupField:= node.StringByName['GroupField'];
                if groupField <> '' then begin
                  IsList:= true;
                  qryRemote.SQL.Add('select Globalref, max(msTimeStamp) as msTimeStamp, ' + groupField);
                  qryRemote.SQL.Add('from ' + node.StringByName['TableName']);
                  qryRemote.SQL.Add('group by ' + groupField);
                  qryRemote.SQL.Add('order by msTimeStamp');
                end
                else begin
                  { no grouping }
                  qryRemote.SQL.Add('select Globalref, msTimeStamp');
                  qryRemote.SQL.Add('from ' + node.StringByName['TableName']);
                  qryRemote.SQL.Add('order by msTimeStamp');
                end;
                qryLocal.SQL.Text:= qryRemote.SQL.Text;
                qryRemote.Open;
                qryLocal.Open;
                try
                  self.SendStatus('Checking - ' +
                    siteConfig.MySQLServer + ' - ' + siteConfig.DatabaseName + ' - ' +
                    SyncObjList[x]);
                  while not qryRemote.Eof do begin
                    Application.ProcessMessages;
                    if not fActive then break;
                    Sleep(5);
                    NeedsUpdating:= false;
                    if qryRemote.FieldByName('GlobalRef').AsString <> '' then begin
                      if qryLocal.Locate('GlobalRef',qryRemote.FieldByName('GlobalRef').AsString,[]) then begin
                        { exists on local system }
                        if ForceSync then begin
                          NeedsUpdating:= true;
                        end
                        else if (qryLocal.FieldByName('msTimeStamp').AsDateTime +
                          fDataSyncList.DestTimeDiffToAdd) <
                          qryRemote.FieldByName('msTimeStamp').AsDateTime then begin
                          NeedsUpdating:= true;
                        end;
                      end
                      else begin
                        { does not exist on local system }
                        NeedsUpdating:= true;
                      end;
                      if NeedsUpdating then begin
                        timeStart:= now;

                        if IsList and (qryRemote.FieldByName(groupField).AsString <> '') then begin
                          GlobalRefList:= '';
                          qry.SQL.Clear;
                          qry.SQL.Add('select Globalref');
                          qry.SQL.Add('from ' + node.StringByName['TableName']);
                          qry.SQL.Add('where ' + groupField + ' = ' +
                            QuotedStr(qryRemote.FieldByName(groupField).AsString));
                          qry.Open;
                          while not qry.Eof do begin
                            if GlobalRefList <> '' then
                              GlobalRefList:= GlobalRefList + ',';
                            GlobalRefList:= GlobalRefList +
                              qry.FieldByName('GlobalRef').AsString;
                            qry.Next;
                          end;
                          qry.Close;
                        end
                        else begin
                          GlobalRefList:= qryRemote.FieldByName('GlobalRef').AsString;
                        end;
                        
                        self.SendStatus('Updating: ' + SyncObjList[x] +
                          ' [' + GlobalRefList + ']');

                        case fDataSyncList.SyncObjects(SyncObjList[x],GlobalRefList,msg) of
                          srOk:
                            begin
                              timeEnd:= now;
                              Logger.Log(IntToStr(qryRemote.RecNo) + ' of ' + IntToStr(qryRemote.RecordCount)+
                                ' Synchronization ok for object "' +
                                SyncObjList[x] + '" [' +
                                GlobalRefList +
                                '] (Time: '+ FormatDateTime('hh:nn:ss zzz',timeEnd - timeStart) + ')',ltDetail);
                            end;
                          srTempFail, srPermFail:
                            begin
                              timeEnd:= now;
                              Logger.Log(IntToStr(qryRemote.RecNo) + ' of ' + IntToStr(qryRemote.RecordCount)+
                                ' Synchronization falied for object "' +
                                SyncObjList[x] + '" [' +
                                GlobalRefList +
                                '] with message: "' + msg + '"' +
                                ' (Time: '+ FormatDateTime('hh:nn:ss zzz',timeEnd - timeStart) + ')',ltInfo);
                            end;
                        end;


                        self.SendStatus('Checking - ' +
                          siteConfig.MySQLServer + ' - ' + siteConfig.DatabaseName + ' - ' +
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
                    qryRemote.Next;
                  end;
                finally
                  qryRemote.Close;
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
        finally
          qry.Free;
          qryLocal.Free;
          qryRemote.Free;
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

procedure TDataSynchronizer.SetLogger(const Value: TLogger);
begin
  fLogger := Value;
  ConnMgr.Logger:= Value;
end;

function TDataSynchronizer.GetDestTimeDiffToAdd(src, dst: TMyConnection): TDateTime;
var
  qry: TMyQuery;
  srcTime, dstTime: TDateTime;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.SQL.Text:= 'select current_timestamp';
    qry.Connection:= src;
    qry.Open;
    srcTime:= qry.Fields[0].AsDateTime;
    qry.Close;
    qry.Connection:= dst;
    qry.Open;
    dstTime:= qry.Fields[0].AsDateTime;
    qry.Close;
    result:= DecimalRoundDbl((dstTime - srcTime), 3, drHalfUp);
    { round to 5 secs }
  finally
    qry.Free;
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
  sl: TStringList;
  script: TMyScript;
  aObj: TJSONObject;
  idx: integer;
  sql: string;

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
    subSql: string;
  begin
    obj:= schema.ObjectByName[ActualClassName(aName)];
    parentTable:= obj.StringByName['TableName'];
    SubObjList:= obj.ObjectByName['Objects'];
    if Assigned(SubObjList) then begin
      for x:= 0 to SubObjList.Count-1 do begin
        subObjDef:= TJSONObject(SubObjList.Items[x].Value);
        currClassName:= subObjDef.StringByName['ClassName'];
        if Lowercase(currClassName) <> 'parent' then begin
          subObj:= schema.ObjectByName[currClassName];
          childTable:= subObj.StringByName['TableName'];
          subSql:= 'update ' + parentTable + ',' + childTable +
            ' set ' + parentTable + '.msTimeStamp = ' + childTable + '.msTimeStamp' +
            ' where ' + parentTable + '.' + subObjDef.ObjectByName['Link'].StringByName['ParentField'] +
            ' = ' + childTable + '.' + subObjDef.ObjectByName['Link'].StringByName['LinkField'] +
            ' and ' + childTable + '.msTimeStamp > ' + childTable + '.msTimeStamp';
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
            Logger.Log('Prepare tables failed on local ERP with message: ' + e.Message, ltDetail);
          end
          else begin
            Logger.Log('Prepare tables failed on local ERP with message: ' + e.Message, ltError);
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
            Logger.Log('Prepare tables failed on remote ERP with message: ' + e.Message, ltDetail);
          end
          else begin
            Logger.Log('Prepare tables failed on remote ERP with message: ' + e.Message, ltError);
          end;
          exit;
        end;
      end;
      DestConn.Commit;
      SrcConn.Commit;
      result:= true;
    finally
      DestConn.Rollback;
      SrcConn.Rollback;
    end;
  finally
    sl.Free;
    script.Free;
  end;
end;

procedure TDataSynchronizer.PrepareTablesOnError(Sender: TObject;
  E: Exception; SQL: string; var Action: TErrorAction);
begin
  Action:= eaAbort;
  raise exception.Create(e.Message);
end;

function TDataSynchronizer.GetTimeZoneMins(conn: TMyConnection): integer;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Text:= 'select timestampdiff(minute,utc_timestamp(),current_timestamp)';
    qry.Open;
    result:= qry.Fields[0].AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TDataSynchronizer.SendNotification(msg: string);
begin
  Logger.Log('Notification:' +#13#10 + msg,ltError);
end;

procedure TDataSynchronizer.SendNotificationHandler(msq: string);
begin
  self.SendNotification(msq);
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
  if Conn.Connected then exit;
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
      Logger.Log('Connection failed for database "' + aDatabase  + '" on server "' + aDatabase + '" .. retrying.', ltError);
      rec.LastRetry:= now;
      rec.RetryLevel:= 1;
      rec.RetryCount:= 1;
    end;
  end
  else if rec.RetryLevel = 1 then begin
    if (now - rec.LastRetry) < level1Interval then exit;
    result:= DoConnect;
    if not result then begin
      Inc(rec.RetryCount);
      if rec.RetryCount > level1Retrys - 2 then begin
        Logger.Log('Connection failed (level 2) for database "' + aDatabase  + '" on server "' + aDatabase + '" .. retrying.', ltError);
        rec.RetryLevel:= 2;
        rec.RetryCount:= 0;
      end;
    end;
  end
  else if rec.RetryLevel = 2 then begin
    if (now - rec.LastRetry) < level2Interval then exit;
    result:= DoConnect;
    if not result then begin
      Inc(rec.RetryCount);
      if rec.RetryCount > level2Retrys - 2 then begin
        Logger.Log('Connection failed (level 3) for database "' + aDatabase  + '" on server "' + aDatabase + '" .. retrying.', ltError);
        rec.RetryLevel:= 3;
        rec.RetryCount:= 0;
      end;
    end;
  end
  else if rec.RetryLevel = 3 then begin
    if (now - rec.LastRetry) < level2Interval then exit;
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

end.
