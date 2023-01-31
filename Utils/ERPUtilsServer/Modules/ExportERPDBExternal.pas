unit ExportERPDBExternal;

interface

uses Classes, MyAccess , OpProgressObj, sysutils, ERPdbComponents, StrUtils;

Type
  TExportToExternal = class
  Private
    FServerName     : String;
    FPort           : Integer;
    FUserName       : String;
    FPassword       : String;
    FDatabaseName   : String;

    FConn, FERPConn : TMyConnection;

    fOnProgress     : TNotifyEvent;
    fNextProgTime   : TDateTime;

    function GetERPConn : TMyConnection;
    function GetExtConn : TMyConnection;
    function BackupERPDatabase(ABackupFile: string) : Boolean;
    function RestoreExtDatabase(ABackupFile: string) : Boolean;

    procedure SendProgress(const aSubOpName, aDetail: string; const aStepNo, aStepCount: int64);
    procedure BackupProgressEvent(Sender: TObject; ObjectName: string; ObjectNum: integer; ObjectCount: integer; Percent: integer);
    procedure RestoreProgressEvent(Sender: TObject; Percent: integer);


  Protected

  Public
    Progress: TOperationProgress;
    Function ExportDatabase: Boolean;

    Constructor Create;
    destructor Destroy; override;

    Property ServerName     : string        read FServerName    write FServerName;
    Property Port           : Integer       read FPort          write FPort;
    Property UserName       : String        read FUserName      write FUserName;
    Property Password       : string        read FPassword      write FPassword;
    Property DatabaseName   : string        read FPassword      write FPassword;
    property OnProgress     : TNotifyEvent  read fOnProgress    write fOnProgress;

  end;


implementation

uses DbConst, tcTypes, myscript , MySQLUtils, MyDump, windows,
  InstallConst;

constructor TExportToExternal.Create;
begin
  inherited;
  fConn := nil;
  Progress:= TOperationProgress.Create;
end;

destructor TExportToExternal.Destroy;
begin
  Progress.Free;
  inherited;
end;

function TExportToExternal.GetExtConn : TMyConnection;
begin
  if FConn = nil then begin
      FConn                  := TMyConnection.Create(nil);
      FConn.LoginPrompt      := False;
      FConn.Port             := FPort;
      FConn.Options.Compress := False;
      FConn.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
      FConn.Username         := FUserName;
      FConn.Password         := FPassword;
      FConn.Server           := FServerName;
      FConn.Database         := FDatabaseName;
  end;

  Result := FConn;
end;

function TExportToExternal.GetERPConn : TMyConnection;
begin
  if FERPConn = nil then begin
      FERPConn                  := TMyConnection.Create(nil);
      FERPConn.LoginPrompt      := False;
      FERPConn.Port             := SERVER_PORT;
      FERPConn.Options.Compress := True;
      FERPConn.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
      FERPConn.Username         := SYSDB_USER;
      FERPConn.Password         := SYSDB_PASS;
      FERPConn.Server           := FServerName;
      FERPConn.Database         := FDatabaseName;
  end;

  Result := FERPConn;
end;

procedure TExportToExternal.SendProgress(const aSubOpName, aDetail: string; const aStepNo, aStepCount: int64);
var
  dtl: string;
  Percent: integer;
  SendProgress: boolean;
const
  OneSec = (1/24/60/60);
begin
  if Assigned(fOnProgress) then begin
    SendProgress := false;
    dtl := aDetail;
    if (aStepNo <> 0) and (aStepCount <> 0) then
      Percent := Trunc((aStepNo / aStepCount) * 100)
    else
      Percent := 0;

    if aStepNo = 1 then fNextProgTime := now;

    if (Percent = 100) then SendProgress := true                { always show 100% }
    else if (now >= fNextProgTime) then SendProgress := true    { send if more thab x time has passed }
    else if (Frac(Percent / 10) = 0) then SendProgress := true;  { send 10% steps as a minimum }
    if not SendProgress then
      exit;

    fNextProgTime := now + (5 * OneSec);
    if aStepCount > 1 then begin
      { change message to % done .. }
      dtl := aSubOpName + ' ' + IntToStr(Percent) + '% Done';
    end;

    Progress.SubOperationName := aSubOpName;
    Progress.Detail := dtl; //aDetail;
    Progress.StepNo := aStepNo;
    Progress.StepCount := aStepCount;
    fOnProgress(self);
  end;
end;

procedure TExportToExternal.BackupProgressEvent(Sender: TObject; ObjectName: string; ObjectNum, ObjectCount, Percent: integer);
begin
  SendProgress('Backing up tables', IntToStr(Percent) + '%', ObjectNum, ObjectCount);
end;

procedure TExportToExternal.RestoreProgressEvent(Sender: TObject; Percent: integer);
begin
  SendProgress('Restoring tables', IntToStr(Percent) + '%', 100, Percent);
end;

function TExportToExternal.BackupERPDatabase(ABackupFile: string) : Boolean;
var
  LConn : TMyConnection;
  LDump : TMyDump;
  LQry : TERPQuery;
  LTableNames: string;
begin
  try
    LConn := GetERPConn;

    // Select tables
    LQry := TERPQuery.Create(nil);
    LQry.Connection := LConn;
    try
      LQry.Options.FlatBuffers := True;
      LQry.SQL.Text := 'Show Tables;';
      LQry.Open;
      LTableNames := '';

      with LQry do begin
        if RecordCount > 0 then begin
          First;
          while not EOF do begin
            if LeftStr(Fields[0].AsString, 3) = 'tbl' then
              LTableNames := LTableNames + Fields[0].AsString + ';';
            Next;
          end;

          LTableNames := LeftStr(LTableNames, Length(LTableNames) - 1);
        end;
      end;
    finally
      FreeandNil(LQry);
    end;

    try
      LConn.Connect;

      LDump := TMyDump.Create(nil);
      try
        LDump.Connection := LConn;
        LDump.Options.AddLock := False;
        LDump.Options.DisableKeys := False;
        LDump.Options.HexBlob := True;
        LDump.Options.UseExtSyntax := True;
        LDump.Options.UseDelayedIns := False;
        LDump.Options.InsertType := itInsert;
        LDump.Options.GenerateHeader := False;
        LDump.Options.AddDrop := False;
        LDump.Options.QuoteNames := True;
        LDump.Options.CompleteInsert := False;
        LDump.Objects := [doTables, doData];
        LDump.TableNames := LTableNames;
        SendProgress('Backup starting', '', 1, 1);
        LDump.OnBackupProgress := BackupProgressEvent;
        LDump.BackupToFile(ABackupFile);
      finally
        LDump.Free;
      end;

      SendProgress('Backup complete', '', 1, 1);
    finally
      LConn.Free;
      Result := True;
    end;
  except
    on e: exception do begin
      Result := False;
      SendProgress('Backup Error - ', e.Message, 1, 1);
    end;
  end;
end;

function TExportToExternal.RestoreExtDatabase(ABackupFile: string) : Boolean;
var
  LConn : TMyConnection;
  LDump : TMyDump;
  qry : TMyQuery;
begin
  try
    try
      // Drop database if exist
      LConn := GetERPConn;
      LConn.Connect;
      qry := TMyQuery.Create(nil);
      qry.Connection := LConn;

      qry.SQL.Text := 'DROP DATABASE IF EXISTS ' + DatabaseName;
      qry.Execute;

      qry.SQL.Text := 'CREATE DATABASE ' + DatabaseName;
      qry.Execute;

      qry.SQL.Text := 'SET GLOBAL innodb_default_row_format="dynamic"';
      qry.Execute;

      qry.SQL.Text := 'SET SESSION innodb_strict_mode=OFF';
      qry.Execute;

      LDump := TMyDump.Create(nil);
      try
        LDump.Connection := LConn;
        LDump.Options.AddLock := False;
        LDump.Options.DisableKeys := False;
        LDump.Options.HexBlob := True;
        LDump.Options.UseExtSyntax := True;
        LDump.Options.UseDelayedIns := False;
        LDump.Options.InsertType := itInsert;
        LDump.Options.GenerateHeader := False;
        LDump.Options.AddDrop := False;
        LDump.Options.QuoteNames := True;
        LDump.Options.CompleteInsert := False;
        LDump.Objects := [doTables, doData];
        SendProgress('Restore starting', '', 100, 0);
        LDump.OnRestoreProgress := RestoreProgressEvent;
        LDump.RestoreFromFile(ABackupFile);
      finally
        LDump.Free;
        Freeandnil(qry);
      end;

      SendProgress('Restore complete', '', 1, 1);
    finally
      LConn.Free;
      Result := True;
    end;
  except
    on e: exception do begin
      Result := False;
      SendProgress('Restore Error - ', e.Message, 1, 1);
    end;
  end;
end;

function TExportToExternal.ExportDatabase: Boolean;
var
  LBackupPath : string;
  LTempFile : string;
  LConn : TMyConnection;
begin
  Progress.OperationName := 'Clone Database';

  // Prepare temporary file
  LBackupPath := ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR;
  ForceDirectories(LBackupPath);
  LTempFile := DatabaseName + '_Clone_' + FormatDateTime('yyyy-mm-dd_hh-nn', Now);

  // Backup
  Progress.SubOperationName := 'Backup ERP database';
  Progress.Detail := 'Backing up database ...';
  BackupERPDatabase(LTempFile);

  // Restore
  Progress.SubOperationName := 'Restoring the database in external server ...';
  Progress.Detail := 'Restoring the database ...';
  RestoreExtDatabase(LTempFile);

  Progress.Detail := 'Database ' + DatabaseName + ' has been exported to server ' + ServerName + '. ';

  Result := True;
end;


end.
