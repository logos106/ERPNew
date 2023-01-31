unit ExportToReportDBObj;

interface

  uses Classes, MyAccess , OpProgressObj, sysutils, DAScript ;

  Type
    TExportToreportDB = class
    Private
      fsDatabaseName: String;
      fsServerName  : String;
      fOnProgress   : TNotifyEvent;
      fConn: TMyConnection;
      aConn   : TMyConnection;
      function Connection: TMyConnection;
    function getDatabaseName: String;
    function getServerName: String;
    function IsERPDatabase(aDbName: string; Qry :TMyQuery): boolean;
    Procedure ScriptBeforeExecute(Sender: TObject;  var SQL: string; var Omit: Boolean);
    procedure onScriptError(Sender: TObject; E: Exception; SQL: string;var Action: TErrorAction);
    Protected
    Public
      Progress: TOperationProgress;
      Constructor Create;
      destructor Destroy; override;
      Property ServerName  : String read getServerName write fsServerName;
      Property DatabaseName: String read getDatabaseName write fsDatabaseName;
      property OnProgress  : TNotifyEvent read fOnProgress write fOnProgress;
      Function ExportToreport(Tablenames :String=''): Boolean;
      Property Conn : TMyConnection read fConn write fConn;
    end;

implementation

  uses DbConst, tcTypes, myscript ;

  { TExportToreportDB }
  function TExportToreportDB.Connection: TMyConnection;
  begin

    if fConn = nil then begin
      if aConn = nil then begin
        aConn                  := TMyConnection.Create(nil);
        aConn.LoginPrompt      := false;
        aConn.Port             := SERVER_PORT;
        aConn.Options.Compress := MYDAC_OPTIONS_COMPRESS;
        aConn.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
        aConn.Username         := SYSDB_USER;
        aConn.Password         := SYSDB_PASS;
        aConn.Server           := fsServerName;
        aConn.Database         := fsDatabaseName;
      end;
    end else begin
      aConn :=  fConn;
    end;
    result := aConn;
  end;

constructor TExportToreportDB.Create;
begin
  inherited;
  fConn := nil;
  aConn := Nil;
  Progress:= TOperationProgress.Create;
end;
destructor TExportToreportDB.Destroy;
begin
  Progress.Free;
  inherited;
end;

function TExportToreportDB.IsERPDatabase(aDbName: string; Qry :TMyQuery): boolean;
begin
  result := False;

  try
    with Qry do try
      SQL.Add('show tables from ' + aDbName +' like "tblupdatedetails"') ;
      open;
      if recordcount <> 1 then exit;
      result := True;
    finally
      if active then close;
    end;
  except
    // on exception return as the result is set to false;
  end;
end;

procedure TExportToreportDB.ScriptBeforeExecute(Sender: TObject;var SQL: string; var Omit: Boolean);
begin
  if Assigned(fOnProgress) then fOnProgress(self);
end;
procedure TExportToreportDB.onScriptError(Sender: TObject; E: Exception;  SQL: string; var Action: TErrorAction);
begin
  Action := eaContinue ;

end;
function TExportToreportDB.ExportToreport(Tablenames :String=''): Boolean;
var
  qry     : TMyQuery;
  Script  : TMyScript;
  SQL     : String;
  ReportDB: String;
begin
  result := false;
  Progress.Clear;
  Connection;
  try
    Progress.OperationName := 'ERP Export Tabels to Report DB';
    Progress.SubOperationName := '';
    if Assigned(fOnProgress) then fOnProgress(self);
    Progress.Detail:= 'Exporting "' + DatabaseName + '" to "' + ReportDB+'"';
    ReportDB := DatabaseName + REPORTING_DB_SUFIX;
    qry    := TMyQuery.Create(nil);
    Script := TMyScript.Create(nil);
    try
      qry.connection    := aConn;
      Script.connection := aConn;
      Script.OnError := onScriptError;

    if IsERPDatabase(ReportDB, qry) then begin
      Progress.SubOperationName := 'Error';
      Progress.Detail:= 'Export of "' + DatabaseName + '" failed. The Reporting Database "' + ReportDB+'" is an ERP Database. Please Rename it and Try Again';
      if Assigned(fOnProgress) then fOnProgress(self);
      result := False;
      Exit;
    end;

      qry.SQL.clear;
      qry.SQL.add('select TableName , SQLStatement  ' );
      qry.SQL.add(' from tblexporttables ');
      if Tablenames = '' then qry.SQL.add(' where  IncludeinMidnightupdate ="T" ')
      else qry.SQL.add(' where  TableName in (' + Tablenames+')');
      qry.SQL.add(' Order by Tablename');
      qry.open;
      if qry.recordcount = 0 then begin
        result := True;
        Exit;
      end;


      Script.SQL.add('Drop database if exists ' + ReportDB + ';');
      Script.SQL.add('Create database ' + ReportDB + ';');
//      Script.SQL.add('DROP USER If Exists ' + Quotedstr(REPORTING_DB_USER) + ';');

//      Script.SQL.add('CREATE USER ' + Quotedstr(REPORTING_DB_USER) + '@' + Quotedstr('%') + ' IDENTIFIED BY ' + Quotedstr(REPORTING_DB_USER_PASS) + ';');
//      Script.SQL.add('GRANT ALL ON ' + ReportDB + '.* TO ' + Quotedstr(REPORTING_DB_USER) + ';');
      Script.SQL.add('USE ' + ReportDB + ';');
      Script.SQL.add('DROP PROCEDURE IF EXISTS drop_user_if_exists;');
      Script.SQL.add('DELIMITER $$');
      Script.SQL.add('CREATE PROCEDURE drop_user_if_exists()');
      Script.SQL.add('BEGIN');
      Script.SQL.add('  DECLARE foo BIGINT DEFAULT 0 ;');
      Script.SQL.add('  SELECT COUNT(*) INTO foo');
      Script.SQL.add('   FROM mysql.user');
      Script.SQL.add('      WHERE User = "'+REPORTING_DB_USER+'" and Host = "localhost";');
      Script.SQL.add('   IF foo > 0 THEN');
      Script.SQL.add('         DROP USER "'+REPORTING_DB_USER+'"@"localhost" ;');
      Script.SQL.add('  END IF;');
      Script.SQL.add('END ;$$');
      Script.SQL.add('DELIMITER ;');
      Script.SQL.add('CALL drop_user_if_exists() ;');
      Script.SQL.add('DROP PROCEDURE IF EXISTS drop_user_if_exists ;');

      Script.SQL.add('CREATE USER ' + Quotedstr(REPORTING_DB_USER) + '@' + Quotedstr('%') + ' IDENTIFIED BY ' + Quotedstr(REPORTING_DB_USER_PASS) + ';');
      Script.SQL.add('GRANT ALL ON ' + ReportDB + '.* TO ' + Quotedstr(REPORTING_DB_USER) + ';');

      qry.First;
      While qry.EOF = false do begin
        SQL := StringReplace(qry.fieldByname('SQLStatement').AsString, 'tbl', DatabaseName + '.tbl', [rfReplaceAll]);
        if Pos('CREATE TABLE', Uppercase(SQL)) =  0   then SQL := 'Create table ' + qry.fieldByname('TableName').AsString + ' ' + SQL;
        if copy(SQL, length(SQL), 1)           <> ';' then SQL := SQL + ';';
        Script.SQL.add(SQL);
        qry.Next;
      end;
      Script.SQL.add('USE ' + DatabaseName + ';');
      if Script.SQL.Count > 0 then begin
        Script.BeforeExecute :=ScriptBeforeExecute;
        Script.Execute;
        Progress.SubOperationName := '';
        Progress.Detail:= 'Data from "' + DatabaseName + '" are Exported to "' + ReportDB+'" on (ERP Server)';
        if Assigned(fOnProgress) then fOnProgress(self);
        Result := True;
      end;
    finally
      Freeandnil(qry);
      Freeandnil(Script);
    end;
  finally
    if aConn <> fconn then Freeandnil(aConn);
  end;
end;

function TExportToreportDB.getDatabaseName: String;
begin
  Result := fsDatabaseName;
  if result = '' then Result := Connection.Database;
end;

function TExportToreportDB.getServerName: String;
begin
  Result := fsServerName;
  if result = '' then Result := Connection.Server;
end;

end.
