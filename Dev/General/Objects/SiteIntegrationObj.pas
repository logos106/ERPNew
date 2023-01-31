unit SiteIntegrationObj;

interface

uses
  LogThreadBase, LogMessageTypes, Classes, ERPDBComponents;

type

  TOnProcessProgress = procedure (aCaption, aMsg: string; aCount, aCountTotal: integer) of object;

  TSiteIntegration = class
  private
    fLogger: TLoggerBase;
    fLocalLogger: TLoggerBase;
    FERPDatabase: string;
    FERPServer: string;
    fAssignedConnection,
    fConnection: TERPConnection;
    fTempFileNo: integer;
    fTempFileNoPrefix: string;
    FExportDirectory: string;
    FTimeTo: TDateTime;
    FTimeFrom: TDateTime;
    fLastError: string;
    fOnProgress: TOnProcessProgress;
    fCaption,
    fMsg: string;
    function GetLogger: TLoggerBase;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    procedure SetERPDatabase(const Value: string);
    procedure SetERPServer(const Value: string);
//    function TimeStampSQL(const aClassName, OutTableName: string; Sql: TStrings): boolean;
    function BuildUpdateList(const aClassName: string; TimeFrom, TimeTo: TDateTime): boolean;
    function BuildExportList: boolean;
    function ExportJson: boolean;
    function GetConnection: TERPConnection;
    procedure SetExportDirectory(const Value: string);
    procedure SetTimeFrom(const Value: TDateTime);
    procedure SetTimeTo(const Value: TDateTime);
    function NextTempFile: string;
    function PrepareTables: boolean;
    procedure DoProgress(aCaption: string; aMessage: string = ''; Count: integer = 0; CountTotal: integer = 0);
  public
    constructor Create;
    destructor Destroy; override;
    property Logger: TLoggerBase read GetLogger write fLogger;
    property Connection: TERPConnection read GetConnection write fAssignedConnection;
    property ERPServer: string read FERPServer write SetERPServer;
    property ERPDatabase: string read FERPDatabase write SetERPDatabase;
    property ExportDirectory: string read FExportDirectory write SetExportDirectory;
    property TimeFrom: TDateTime read FTimeFrom write SetTimeFrom;
    property TimeTo: TDateTime read FTimeTo write SetTimeTo;
    function ExportData: boolean;
    property LastError: string read fLastError;
    property OnProgress: TOnProcessProgress read fOnProgress write fOnProgress;

  end;


implementation

uses
  LogThreadLib, SysUtils, MySQLUtils, AppEnvironmentVirtual, MySQLConst,
  SystemLib, BusObjBase, ActiveX, ObjectSerialiser, JsonObject;

{ TSiteIntegration }

function TSiteIntegration.BuildExportList: boolean;
var
  cmd: TERPCommand;
begin
  result:= true;
  DoProgress('Preparing export list ..');
  try
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := Connection;
      cmd.SQL.Add('update tmp_SiteIntTmp set msUpdateSiteCode = (select SiteCode from tblmsbackendid limit 1)');
      cmd.SQL.Add('where IfNull(msUpdateSiteCode,"") = "";');
      cmd.SQL.Add('insert ignore into tmp_SiteIntExp');
      cmd.SQL.Add('select * from tmp_SiteIntTmp;');
      cmd.SQL.Add('update tmp_SiteIntExp, tmp_SiteIntTmp set');
      cmd.SQL.Add('tmp_SiteIntExp.msTimeStamp = tmp_SiteIntTmp.msTimeStamp');
      cmd.SQL.Add(',tmp_SiteIntExp.msUpdateSiteCode = tmp_SiteIntTmp.msUpdateSiteCode');
      cmd.SQL.Add('where tmp_SiteIntExp.ClassName = tmp_SiteIntTmp.ClassName');
      cmd.SQL.Add('and tmp_SiteIntExp.ID = tmp_SiteIntTmp.ID');
      cmd.SQL.Add('and tmp_SiteIntExp.msTimeStamp < tmp_SiteIntTmp.msTimeStamp;');
      cmd.Execute;
    finally
      cmd.Free;
    end;
  except
    on e: exception do begin
      result := false;
      fLastError := 'Error builting export list: ' + e.Message;
      Log(fLAstError, ltError);
    end;
  end;
end;

function TSiteIntegration.BuildUpdateList(const aClassName: string; TimeFrom, TimeTo: TDateTime): boolean;
var
  MySQLTempDir: string;
  cmd: TERPCommand;
  tmpFile: string;
begin
  result:= false;
  DoProgress('Building update list ..');
  cmd := TERPCommand.Create(nil);
  try
    cmd.Connection := Connection;
    try
      MySQLTempDir:= StringReplace(AppEnvVirt.Str['CommonDbLib.GetMySQLTempDir'],'\','/',[rfReplaceAll]);
      if SameText(aClassName,'TPOSCashSale') then begin
        result := true;
        cmd.SQL.Clear;

        tmpFile := self.NextTempFile;
        cmd.SQL.Add('select "' + aClassName + '",');
        cmd.SQL.Add('tblsales.SaleID, Max(tblsales.msTimeStamp) as msTimeStamp,');
        cmd.SQL.Add('(select s.MsUpdateSiteCode from tblsales as s where s.SaleID = tblsales.SaleID order by s.msTimeStamp Desc limit 1) as msUpdateIteCode');
        cmd.SQL.Add('from tblsales');
        cmd.SQL.Add('where tblsales.IsPos = "T" and (tblsales.IsCashSale = "T" or tblsales.IsLaybyPayment = "T" or tblsales.IsLayby = "T")');
        cmd.SQL.Add('and tblsales.msTimeStamp >= "' + FormatDateTime(MysqlDateTimeFormat,TimeFrom) + '"');
        cmd.SQL.Add('and tblsales.msTimeStamp <= "' + FormatDateTime(MysqlDateTimeFormat,TimeTo) + '"');
        cmd.SQL.Add('into outfile "' + MySQLTempDir + tmpFile + '";');
        //cmd.SQL.Add('truncate tmp_SiteIntTmp;');

        cmd.Execute;
        cmd.SQL.Clear;
        cmd.SQL.Add('load data infile "' + MySQLTempDir + tmpFile +'" into table tmp_SiteIntTmp');
        cmd.Execute;
        cmd.SQL.Clear;

        tmpFile := self.NextTempFile;
        cmd.SQL.Add('select "' + aClassName + '",');
        cmd.SQL.Add('tblsaleslines.SaleID, Max(tblsaleslines.msTimeStamp) as msTimeStamp,');
        cmd.SQL.Add('(select sl.MsUpdateSiteCode from tblsaleslines as sl where sl.SaleID = tblsaleslines.SaleID order by sl.msTimeStamp Desc limit 1) as msUpdateIteCode');
        cmd.SQL.Add('from tblsaleslines, tblsales');
        cmd.SQL.Add('where tblsaleslines.SaleID = tblsales.SaleID');
        cmd.SQL.Add('and tblsales.IsPos = "T" and (tblsales.IsCashSale = "T" or tblsales.IsLaybyPayment = "T" or tblsales.IsLayby = "T")');
        cmd.SQL.Add('and tblsaleslines.msTimeStamp >= "' + FormatDateTime(MysqlDateTimeFormat,TimeFrom) + '"');
        cmd.SQL.Add('and tblsaleslines.msTimeStamp <= "' + FormatDateTime(MysqlDateTimeFormat,TimeTo) + '"');
        cmd.SQL.Add('group by tblsaleslines.SaleID');
        cmd.SQL.Add('into outfile "' + MySQLTempDir + tmpFile + '";');
        //cmd.SQL.Add('truncate tmp_SiteIntTmp;');
        cmd.Execute;
        cmd.SQL.Clear;
        cmd.SQL.Add('load data infile "' + MySQLTempDir + tmpFile +'" into table tmp_SiteIntTmp');
        cmd.Execute;
      end;
    except
      on e: exception do begin
        result:= false;
        Log(e.Message,ltError);
      end;
    end;
  finally
    cmd.Free;
    AppEnvVirt.DeleteServerFiles(StringReplace(MySQLTempDir,'/','\',[rfReplaceAll]) + 'SIExp' + fTempFileNoPrefix + '_*.tmp');
  end;
end;

constructor TSiteIntegration.Create;
begin
  fConnection := nil;
  fAssignedConnection := nil;
  fLogger := nil;
  fLocalLogger := nil;
  fTempFileNo := 0;
  fTempFileNoPrefix := FormatDateTime('yymmddhhnnss',now);
  FExportDirectory := WinTempDir + 'ERPSiteExport';
  fTimeFrom := 0;
  fTimeTo := now;
end;

destructor TSiteIntegration.Destroy;
begin
  fConnection.Free;
  fLocalLogger.Free;
  inherited;
end;

procedure TSiteIntegration.DoProgress(aCaption: string; aMessage: string = '';
  Count: integer = 0; CountTotal: integer = 0);
begin
  if (not SameText(fCaption,aCaption)) or (not SameText(fMsg,aMessage)) then begin
    fCaption := aCaption;
    fMsg := aMessage;
    Log(fCaption + ' ' + aMessage, ltInfo);
  end;

  if Assigned(fOnProgress) then
    fOnProgress(aCaption,aMessage,Count,CountTotal);
end;

function TSiteIntegration.ExportData: boolean;
begin
  result:= false;
  if not PrepareTables then
    exit;
  if not BuildUpdateList('TPosCashSale',TimeFrom, TimeTo) then
    exit;
  if not BuildExportList then
    exit;
  if not ExportJson then
    exit;
  result := true;
end;

function TSiteIntegration.ExportJson: boolean;
var
  qry: TERPQuery;
  sl: TStringList;
  x: integer;
  ObjClass: TPersistentClass;
  Obj: TPersistent;
  JSONSerialiser: TJSONSerialiser;
  Json: TJsonObject;
begin
  result := true;
  DoProgress('Exporting data ..');
  if not ForceDirectories(ExportDirectory) then begin
    result := false;
    fLastError := 'Can not create export directory: ' + ExportDirectory;
    Log(fLastError, ltError);
    exit;
  end;

  try
    qry := TERPQuery.Create(nil);
    sl := TStringList.Create;
    CoInitialize(nil);
    JSONSerialiser := TJSONSerialiser.Create;
    try
      qry.Connection:= Connection;
      qry.SQL.Add('select distinct ClassName from tmp_SiteIntExp');
      qry.Open;
      while not qry.Eof do begin
        sl.Add(qry.FieldByName('ClassName').AsString);
        qry.Next;
      end;
      qry.Close;
      for x := 0 to sl.Count -1 do begin

        ObjClass:= GetClass(sl[x]);
        Obj:= TDatasetBusObjClass(ObjClass).Create(nil);
        try
          if Obj is TDatasetBusObj then begin
            TDatasetBusObj(Obj).Connection:= TMyDacDataConnection.Create(TDatasetBusObj(Obj));
            TDatasetBusObj(Obj).Connection.MyDacConnection:= Connection;
          end;


          qry.SQL.Clear;
          qry.SQL.Add('select * from tmp_SiteIntExp where ClassName = "' + sl[x] + '"');
          qry.Open;
          while not qry.Eof do begin
            DoProgress('Exporting data ..','Exporting: ' + sl[x] + ' (' + IntToStr(x+1) + ' of ' + IntToStr(sl.Count)+ ')',qry.RecNo,qry.RecordCount);
            JSONSerialiser.Clear;
            if Obj is TDatasetBusObj then begin
              TDatasetBusObj(Obj).Load(qry.FieldByName('ID').AsInteger);
              Json:= JSONSerialiser.SerialiseObject(Obj);
              try
                Json.SaveToFile(ExportDirectory + '\' + sl[x] + '_'+ IntToStr(TDatasetBusObj(Obj).ID)+ '.txt');
              finally
                FreeAndNil(Json);
              end;
            end;
            qry.Next;
          end;
          qry.Close;
        finally
          Obj.Free;
        end;
      end;
    finally
      sl.Free;
      qry.Free;
      JSONSerialiser.Free;
      CoUninitialize();
    end;
  except
    on e: exception do begin
      result:= false;
      fLastError := 'Error exporting data: ' + e.Message;
      Log(fLastError,ltError);
    end;
  end;
end;

function TSiteIntegration.GetConnection: TERPConnection;
begin
  result := nil;
  if Assigned(fAssignedConnection) then begin
    result := fAssignedConnection;
    exit;
  end;
  if not Assigned(fConnection) then begin
    fConnection := TERPConnection.Create(nil);
    SetConnectionProps(fConnection,ERPDatabase,ERPServer);
    fConnection.Connect;
  end
  else begin
    if (not SameText(result.Database,FERPDatabase)) or (not SameText(result.Server,FERPServer)) then begin
      fConnection.Disconnect;
      fConnection.Database := FERPDatabase;
      fConnection.Server := FERPServer;
      fConnection.Connect;
    end;
  end;
  result := fConnection;
end;

function TSiteIntegration.GetLogger: TLoggerBase;
begin
  if Assigned(fLogger) then begin
    result := fLogger;
    exit;
  end;
  if not Assigned(fLocalLogger) then begin
    fLocalLogger := TLogger.Create(nil);
    fLocalLogger.LogName := 'SiteIntegration';
    fLocalLogger.LogAllTypes;
  end;
  result := fLocalLogger;
end;

procedure TSiteIntegration.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  Logger.Log(msg, LogMessageType);
end;

function TSiteIntegration.NextTempFile: string;
begin
  Inc(fTempFileNo);
  result:= 'SIExp' + fTempFileNoPrefix + '_' + IntToStr(fTempFileNo) + '.tmp';
end;

function TSiteIntegration.PrepareTables: boolean;
var
  cmd: TERPCommand;
begin
  result := true;
  DoProgress('Preparing ..');
  try
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection:= Connection;
      cmd.SQL.Add('drop table if exists tmp_SiteIntTmp;');
      cmd.SQL.Add('drop table if exists tmp_SiteIntExp;');
      cmd.SQL.Add('create table tmp_SiteIntTmp (');
      cmd.SQL.Add('  ClassName varchar(255) null default null,');
      cmd.SQL.Add('  ID int(11) null default null,');
      cmd.SQL.Add('  msTimeStamp TIMESTAMP null default null,');
      cmd.SQL.Add('  msUpdateSiteCode varchar(3) null default null,');
      cmd.SQL.Add('index IdIdx (ID),');
      cmd.SQL.Add('index ClassNameIdx (ClassName)');
      cmd.SQL.Add(')ENGINE=MyISAM;');
      cmd.SQL.Add('create table tmp_SiteIntExp (');
      cmd.SQL.Add('  ClassName varchar(255) null default null,');
      cmd.SQL.Add('  ID int(11) null default null,');
      cmd.SQL.Add('  msTimeStamp TIMESTAMP null default null,');
      cmd.SQL.Add('  msUpdateSiteCode varchar(3) null default null,');
      cmd.SQL.Add('index IdIdx (ID),');
      cmd.SQL.Add('index ClassNameIdx (ClassName),');
      cmd.SQL.Add('unique index ClassIdIdx (ClassName,ID)');
      cmd.SQL.Add(')ENGINE=MyISAM;');
      cmd.Execute;
    finally
      cmd.Free;
    end;
  except
    on e: exception do begin
      result := false;
      fLastError := 'Error preparing tables: ' + e.Message;
      Log(fLastError,ltError);
    end;
  end;
end;

procedure TSiteIntegration.SetExportDirectory(const Value: string);
begin
  FExportDirectory := Value;
end;

procedure TSiteIntegration.SetTimeFrom(const Value: TDateTime);
begin
  FTimeFrom := Value;
end;

procedure TSiteIntegration.SetTimeTo(const Value: TDateTime);
begin
  FTimeTo := Value;
end;

procedure TSiteIntegration.SetERPDatabase(const Value: string);
begin
  FERPDatabase := Value;
end;

procedure TSiteIntegration.SetERPServer(const Value: string);
begin
  FERPServer := Value;
end;

//function TSiteIntegration.TimeStampSQL(const aClassName, OutTableName: string; Sql: TStrings): boolean;
//begin
//  result:= false;
//  sql.Add('select "' + aClassName + '" as ClassName,');
//  if SameText(aClassName,'TInvoice') then begin
//    result := true;
//    sql.Add('tblSales.SaleId as ID,');
//    sql.Add('GREATEST(');
//    sql.Add('IfNull(tblSales.msTimeStamp,0),');
//    sql.Add('Max(IfNull(tblsaleslines.msTimeStamp,0)),');
//    sql.Add('Max(IfNull(tblpqa.msTimeStamp,0)),');
//    sql.Add('max(IfNull(tblpqadetails.msTimeStamp,0)),');
//    sql.Add('max(ifnull(tblpqadetailsclass.mstimestamp,0)),');
//    sql.Add('max(ifnull(tblfesaleslines.msTimeStamp,0)),');
//    sql.Add('max(ifnull(tblfesaleslinesrelatedprs.msTimeStamp,0)),');
//    sql.Add('max(ifnull(tblsaleslinespoints.msTimeStamp,0))');
//    sql.Add(') as msTimeStamp');
//    sql.Add('from tblsales');
//    sql.Add('left join tblsaleslines on tblsaleslines.SaleID = tblsales.SaleID');
//    sql.Add('left join tblpqa on tblpqa.TransLineID = tblsaleslines.SaleLineID');
//      sql.Add('and tblpqa.TransType in ("TCashSaleLine","TInvoiceLine","TSalesOrderLine","TPosLaybyLines","TPOSCashSaleLine","TRefundSaleLine")');
//    sql.Add('left join tblpqadetails on tblpqadetails.PQAID = tblpqa.PQAID');
//    sql.Add('left join tblpqadetailsclass on tblpqadetailsclass.PQADetailID = tblpqadetails.PQADetailID');
//    sql.Add('left join tblfesaleslines on tblfesaleslines.SaleLineID = tblsaleslines.SaleLineID');
//    sql.Add('left join tblfesaleslinesrelatedprs on tblfesaleslinesrelatedprs.FESalesLineID = tblfesaleslines.FESalesLineID');
//    sql.Add('left join tblsaleslinespoints on tblsaleslinespoints.SaleLineID = tblsaleslines.SaleLineId');
//    sql.Add('group by tblsales.SaleId');
//    sql.Add('INTO OUTFILE "' + OutTableName + '";');
//  end;
//end;

end.
