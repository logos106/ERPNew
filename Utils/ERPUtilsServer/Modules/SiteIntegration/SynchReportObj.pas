unit SynchReportObj;

interface

uses
  ERPDbComponents, JsonObject;

type

  TSyncReport = class
  private
    FLastOkDurationSecs: integer;
    FSourceURL: string;
    FName: string;
    FLastOkFinishTime: TDateTime;
    FStartTime: TDateTime;
    FTwoWaySynch: boolean;
    FSynchType: string;
    FId: integer;
    FStatus: string;
    FDurationSecs: integer;
    FDestinationDatabase: string;
    FSourceDatabase: string;
    FFinishTime: TDateTime;
    FDestinationURL: string;
    Connection: TERPConnection;
    FFailCount: integer;
    FOkCount: integer;
    FAvgSecs: integer;
    TotalSyncInterval: TDateTime;
    procedure SetDestinationDatabase(const Value: string);
    procedure SetDestinationURL(const Value: string);
    procedure SetDurationSecs(const Value: integer);
    procedure SetFinishTime(const Value: TDateTime);
    procedure SetId(const Value: integer);
    procedure SetLastOkDurationSecs(const Value: integer);
    procedure SetLastOkFinishTime(const Value: TDateTime);
    procedure SetName(const Value: string);
    procedure SetSourceDatabase(const Value: string);
    procedure SetSourceURL(const Value: string);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetStatus(const Value: string);
    procedure SetSynchType(const Value: string);
    procedure SetTwoWaySynch(const Value: boolean);
    procedure CheckDb;
    procedure SetFailCount(const Value: integer);
    procedure SetOkCount(const Value: integer);
    procedure SetAvgSecs(const Value: integer);
  public
    constructor Create(aMySQLServer: string);
    destructor Destroy; override;
    procedure Init(Site: TJsonObject);
    procedure Finalise;
    procedure Save;
    procedure AddOk(const msg: string; SyncInterval: TDateTime);
    procedure AddFail(const msg: string);
    property Id: integer read FId write SetId;
    property Name: string read FName write SetName;
    property TwoWaySynch: boolean read FTwoWaySynch write SetTwoWaySynch;
    property SourceURL: string read FSourceURL write SetSourceURL;
    property SourceDatabase: string read FSourceDatabase write SetSourceDatabase;
    property DestinationURL: string read FDestinationURL write SetDestinationURL;
    property DestinationDatabase: string read FDestinationDatabase write SetDestinationDatabase;
    property SynchType: string read FSynchType write SetSynchType; { Full, Pos, Product }
    property StartTime: TDateTime read FStartTime write SetStartTime;
    property FinishTime: TDateTime read FFinishTime write SetFinishTime;
    property DurationSecs: integer read FDurationSecs write SetDurationSecs;
    property LastOkFinishTime: TDateTime read FLastOkFinishTime write SetLastOkFinishTime;
    property LastOkDurationSecs: integer read FLastOkDurationSecs write SetLastOkDurationSecs;
    property AvgSecs: integer read FAvgSecs write SetAvgSecs;
    property Status: string read FStatus write SetStatus; { Checking, Ok, Fail, No Connection }
    property OkCount: integer read FOkCount write SetOkCount;
    property FailCount: integer read FFailCount write SetFailCount;
  end;

  TSyncReportLines = class
  private
    FLogTime: TDateTime;
    FLogType: string;
    FLogText: string;
    FId: integer;
    FParentId: integer;
    fParent: TSyncReport;
    procedure SetId(const Value: integer);
    procedure SetLogText(const Value: string);
    procedure SetLogTime(const Value: TDateTime);
    procedure SetLogType(const Value: string);
    procedure SetParentId(const Value: integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init(aParent: TSyncReport);
    procedure Save;
    property Id: integer read FId write SetId;
    property ParentId: integer read FParentId write SetParentId;
    property LogType: string read FLogType write SetLogType;
    property LogTime: TDateTime read FLogTime write SetLogTime;
    property LogText: string read FLogText write SetLogText;
  end;


const
  LF = #10;

  TSyncReport_SQL =
    'CREATE TABLE `tblsynchist` (' + LF +
    '  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,' + LF +
    '  `Name` varchar(255) DEFAULT NULL,' + LF +
    '  `TwoWaySynch` enum(''T'',''F'') DEFAULT ''T'',' + LF +
    '  `SourceURL` varchar(255) DEFAULT NULL,' + LF +
    '  `SourceDatabase` varchar(255) DEFAULT NULL,' + LF +
    '  `DestinationURL` varchar(255) DEFAULT NULL,' + LF +
    '  `DestinationDatabase` varchar(255) DEFAULT NULL,' + LF +
    '  `SynchType` varchar(10) DEFAULT NULL,' + LF +
    '  `StartTime` datetime DEFAULT NULL,' + LF +
    '  `FinishTime` datetime DEFAULT NULL,' + LF +
    '  `DurationSecs` bigint(20) DEFAULT ''0'',' + LF +
    '  `AvgSecs` bigint(20) DEFAULT ''0'',' + LF +
    '  `LastOkFinishTime` datetime DEFAULT NULL,' + LF +
    '  `LastOkDurationSecs` bigint(20) DEFAULT ''0'',' + LF +
    '  `Status` varchar(15) DEFAULT NULL,' + LF +
    '  `OkCount` bigint(20) DEFAULT ''0'',' + LF +
    '  `FailCount` bigint(20) DEFAULT ''0'',' + LF +
    '  PRIMARY KEY (`Id`),' + LF +
    '  KEY `NameIdx` (`Name`)' + LF +
    ') ENGINE=MyISAM;';

  TSyncReportTableName = 'tblsynchist';

  TSyncReportLines_SQL =
    'CREATE TABLE `tblsynchistlines` (' + LF +
    '  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,' + LF +
    '  `ParentId` bigint(20) DEFAULT NULL,' + LF +
    '  `LogTime` datetime DEFAULT NULL,' + LF +
    '  `LogType` varchar(20) DEFAULT NULL,' + LF +
    '  `LogText` text,' + LF +
    '  PRIMARY KEY (`Id`),' + LF +
    '  KEY `ParentIdIdx` (`ParentId`),' + LF +
    '  KEY `LogTypeIdx` (`LogType`)' + LF +
    ') ENGINE=MyISAM;';

  TSyncReportLinesTableName = 'tblsynchistLines';

implementation

uses
  MySQLUtils, MySQLConst, DbConst, SysUtils, classes;


{ TSyncReport }

procedure TSyncReport.AddFail(const msg: string);
var
  Line: TSyncReportLines;
begin
  if Id < 1 then Save;
  FailCount := FailCount + 1;
  Line := TSyncReportLines.Create;
  try
    Line.Init(self);
    Line.LogType := 'Fail';
    Line.LogText := msg;
    Line.Save;
  finally
    Line.Free;
  end;
  Save;
end;

procedure TSyncReport.AddOk(const msg: string; SyncInterval: TDateTime);
var
  Line: TSyncReportLines;
const
  OneSec = 1/24/60/60;
begin
  TotalSyncInterval := TotalSyncInterval + SyncInterval;
  if Id < 1 then Save;
  OkCount := OkCount + 1;
  Line := TSyncReportLines.Create;
  try
    Line.Init(self);
    Line.LogType := 'Ok';
    Line.LogText := msg;
    Line.Save;
  finally
    Line.Free;
  end;
  AvgSecs := Round((TotalSyncInterval / OkCount) / OneSec);
  Save;
end;

procedure TSyncReport.CheckDb;
var
  qry: TERPQuery;
  sl: TStringList;
  s: string;
begin
  sl := TStringList.Create;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection;
    Connection.GetTableNames(sl);
    if sl.IndexOf(TSyncReportTableName) < 0 then begin
      { table not there so create it! }
      qry.SQL.Text := TSyncReport_SQL;
      qry.Execute;
    end
    else begin
      { table exists, check structure }
      qry.SQL.Text := 'show create table ' + TSyncReportTableName;
      qry.Open;
      s:= qry.FieldByName('Create Table').AsString;
      s:= Copy(s,1,Pos('MyISAM',s) + 5) + ';';
      qry.Close;
      if not SameText(s, TSyncReport_SQL) then begin
        qry.SQL.Clear;
        qry.SQL.Add('drop table ' + TSyncReportTableName + ';');
        qry.SQL.Add(TSyncReport_SQL);
        qry.SQL.Add('truncate ' + TSyncReportLinesTableName + ';');
        qry.Execute;
      end;
    end;
    if sl.IndexOf(TSyncReportLinesTableName) < 0 then begin
      { table not there so create it! }
      qry.SQL.Text := TSyncReportLines_SQL;
      qry.Execute;
    end
    else begin
      { table exists, check structure }
      qry.SQL.Text := 'show create table ' + TSyncReportLinesTableName;
      qry.Open;
      s:= qry.FieldByName('Create Table').AsString;
      s:= Copy(s,1,Pos('MyISAM',s) + 5) + ';';
      qry.Close;
      if not SameText(s, TSyncReportLines_SQL) then begin
        qry.SQL.Clear;
        qry.SQL.Add('drop table ' + TSyncReportLinesTableName + ';');
        qry.SQL.Add(TSyncReportLines_SQL);
        qry.Execute;
      end;
    end;
    qry.SQL.Text := 'update ' + TSyncReportTableName;
    qry.SQL.Add('set Status = "Terminated" where Status = "Checking"');
    qry.Execute;

  finally
    sl.Free;
    qry.Free;
  end;

end;

constructor TSyncReport.Create(aMySQLServer: string);
begin
  fId := 0;
  Connection := TERPConnection.Create(nil);
  MySQLUtils.SetConnectionProps(Connection,DbConst.SERVICES_DATABASE,aMySQLServer);
  Connection.Connect;
  CheckDb;
end;

destructor TSyncReport.Destroy;
begin
  Connection.Free;
  inherited;
end;

procedure TSyncReport.Finalise;
begin
  FinishTime := now;
  if SameText(fStatus,'Checking') then begin
    if FailCount > 0 then
      fStatus := 'Fail'
    else
      fStatus := 'Ok';
  end;
  Save;
end;

procedure TSyncReport.Init(Site: TJsonObject);
var
  s: string;
  qry: TERPQuery;
begin
  FLastOkDurationSecs := 0;
  FSourceURL := Site.S['SourceURL'];
  FName := Site.S['Name'];
  FLastOkFinishTime := 0;
  FStartTime := now;
  FTwoWaySynch := Site.B['TwoWaySynch'];
  if Site.B['SynchAll'] then
    s := 'All'
  else begin
    if Site.B['SynchPos'] then
      s := 'POS';
    if Site.B['SynchProduct'] then begin
      if s <> '' then s := s + ',';
      s := s + 'Prod';
    end;
  end;
  FSynchType :=s;
  FId := 0;
  FStatus := 'Checking';
  FDurationSecs := 0;
  FDestinationDatabase := Site.S['DestinationDatabase'];
  FSourceDatabase := Site.S['SourceDatabase'];
  FFinishTime := 0;
  FDestinationURL := Site.S['DestinationURL'];
  fOkCount := 0;
  fFailCount := 0;
  fAvgSecs := 0;
  TotalSyncInterval := 0;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Add('select * from ' + TSyncReportTableName);
    qry.SQL.Add('where SourceURL = ' + QuotedStr(SourceURL));
    qry.SQL.Add('and SourceDatabase = ' + QuotedStr(SourceDatabase));
    qry.SQL.Add('and DestinationURL = ' + QuotedStr(DestinationURL));
    qry.SQL.Add('and DestinationDatabase = ' + QuotedStr(DestinationDatabase));
    qry.SQL.Add('and Status = "Ok"');
    qry.SQL.Add('order by ID Desc');
    qry.SQL.Add('limit 1');
    qry.Open;
    if not qry.IsEmpty then begin
      FLastOkFinishTime := qry.FieldByName('FinishTime').AsDateTime;
      if (FStartTime <> 0) and (FLastOkFinishTime <> 0) then
        FLastOkDurationSecs := Trunc(SecsPerDay * (FStartTime - FLastOkFinishTime));
    end;

  finally
    qry.Free;
  end;
  Save;
end;

procedure TSyncReport.Save;
var
  cmd: TERPCommand;
begin
  cmd := TERPCommand.Create(nil);
  try
    cmd.Connection:= Connection;
    if Id < 1 then
      cmd.SQL.Add('insert into ' + TSyncReportTableName)
    else
      cmd.SQL.Add('update ' + TSyncReportTableName);
    cmd.SQL.Add('set Name = ' + QuotedStr(Name));
    cmd.SQL.Add(', SourceUrl = ' + QuotedStr(SourceURL));
    cmd.SQL.Add(', SourceDatabase = ' + QuotedStr(SourceDatabase));
    cmd.SQL.Add(', DestinationUrl = ' + QuotedStr(DestinationURL));
    cmd.SQL.Add(', DestinationDatabase = ' + QuotedStr(DestinationDatabase));
    cmd.SQL.Add(', StartTime = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,StartTime)));
    cmd.SQL.Add(', FinishTime = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,FinishTime)));
    cmd.SQL.Add(', LastOkFinishTime = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,LastOkFinishTime)));
    cmd.SQL.Add(', DurationSecs = ' + IntToStr(DurationSecs));
    cmd.SQL.Add(', AvgSecs = ' + IntToStr(AvgSecs));
    cmd.SQL.Add(', LastOkDurationSecs = ' + IntToStr(LastOkDurationSecs));
    if TwoWaySynch then
      cmd.SQL.Add(', TwoWaySynch = ' + QuotedStr('T'))
    else
      cmd.SQL.Add(', TwoWaySynch = ' + QuotedStr('F'));
    cmd.SQL.Add(', SynchType = ' + QuotedStr(SynchType));
    cmd.SQL.Add(', Status = ' + QuotedStr(Status));
    cmd.SQL.Add(', OkCount = ' + IntToStr(OkCount));
    cmd.SQL.Add(', FailCount = ' + IntToStr(FailCount));
    if Id > 0 then
      cmd.SQL.Add('where Id = ' + IntToStr(Id));
    cmd.Execute;
    if Id < 1 then
      fId := cmd.InsertId;
  finally
    cmd.Free;
  end;
end;

procedure TSyncReport.SetAvgSecs(const Value: integer);
begin
  FAvgSecs := Value;
end;

procedure TSyncReport.SetDestinationDatabase(const Value: string);
begin
  FDestinationDatabase := Value;
end;

procedure TSyncReport.SetDestinationURL(const Value: string);
begin
  FDestinationURL := Value;
end;

procedure TSyncReport.SetDurationSecs(const Value: integer);
begin
  FDurationSecs := Value;
end;

procedure TSyncReport.SetFailCount(const Value: integer);
begin
  FFailCount := Value;
end;

procedure TSyncReport.SetFinishTime(const Value: TDateTime);
begin
  if FFinishTime <> Value then begin
    FFinishTime := Value;
    if (FStartTime > 0) and (fFinishTime > 0) then
      FDurationSecs := Trunc(SecsPerDay * (fFinishTime - fStartTime))
    else
      FDurationSecs := 0;
  end;
end;

procedure TSyncReport.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TSyncReport.SetLastOkDurationSecs(const Value: integer);
begin
  FLastOkDurationSecs := Value;
end;

procedure TSyncReport.SetLastOkFinishTime(const Value: TDateTime);
begin
  FLastOkFinishTime := Value;
end;

procedure TSyncReport.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TSyncReport.SetOkCount(const Value: integer);
begin
  FOkCount := Value;
end;

procedure TSyncReport.SetSourceDatabase(const Value: string);
begin
  FSourceDatabase := Value;
end;

procedure TSyncReport.SetSourceURL(const Value: string);
begin
  FSourceURL := Value;
end;

procedure TSyncReport.SetStartTime(const Value: TDateTime);
begin
  FStartTime := Value;
end;

procedure TSyncReport.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TSyncReport.SetSynchType(const Value: string);
begin
  FSynchType := Value;
end;

procedure TSyncReport.SetTwoWaySynch(const Value: boolean);
begin
  FTwoWaySynch := Value;
end;


{ TSyncReportLines }

constructor TSyncReportLines.Create;
begin
  fId := 0;
  fLogTime := now;
end;

destructor TSyncReportLines.Destroy;
var
  cmd: TERPCommand;
begin
  cmd := TERPCommand.Create(nil);
  try
    cmd.Connection:= fParent.Connection;
    if Id < 1 then
      cmd.SQL.Add('insert into ' + TSyncReportLinesTableName)
    else
      cmd.SQL.Add('update ' + TSyncReportTableName);
    cmd.SQL.Add('set ParentId = ' + IntToStr(ParentId));

    cmd.SQL.Add(', LogType = ' + QuotedStr(LogType));
    cmd.SQL.Add(', LogText = ' + QuotedStr(LogText));
    cmd.SQL.Add(', LogTime = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,LogTime)));
    if Id > 0 then
      cmd.SQL.Add('where Id = ' + IntToStr(Id));
    cmd.Execute;
    if Id < 1 then
      fId := cmd.InsertId;
  finally
    cmd.Free;
  end;
end;

procedure TSyncReportLines.Init(aParent: TSyncReport);
begin
  fParent := aParent;
  fId := 0;
  fPArentId := aParent.Id;
  fLogTime := now;
  fLogType := '';
  fLogTime := now;
  fLogText := '';
end;

procedure TSyncReportLines.Save;
begin

end;

procedure TSyncReportLines.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TSyncReportLines.SetLogText(const Value: string);
begin
  FLogText := Value;
end;

procedure TSyncReportLines.SetLogTime(const Value: TDateTime);
begin
  FLogTime := Value;
end;

procedure TSyncReportLines.SetLogType(const Value: string);
begin
  FLogType := Value;
end;

procedure TSyncReportLines.SetParentId(const Value: integer);
begin
  FParentId := Value;
end;

end.
