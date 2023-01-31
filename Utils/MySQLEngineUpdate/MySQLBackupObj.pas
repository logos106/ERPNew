unit MySQLBackupObj;

interface

uses
  classes, LogThreadBase, LogThreadLib, LogMessageTypes, MyAccess,
  SysUtils, MyDump, DaScript, Types;

type

  TMySQLBackup = class
  private
    fOnLog: TOnLogEvent;
    fExcludeList: TStringList;
    fBackupPath: string;
    fLogPrefix: string;
    fRemoveSQLFiles: boolean;
    fAddList: TStringList;
    fLibraryPath: string;
    fAllBackupsArchived: boolean;
    fDeleteERPTemporyTablesBeforeBackup: boolean;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function BackupDb(conn: TMyConnection): boolean;
    function CreateDb(conn: TMyConnection): boolean;
    procedure DoDumpOnError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    function GetDbVersion(conn: TMyConnection): string;
    procedure RemoveERPTemporyTables(conn: TMyConnection);
  public
    BackupSQLList: TStringList;
    LogList: TStringList;
    constructor Create;
    destructor Destroy; override;
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    property ExcludeList: TStringList read fExcludeList write fExcludeList;
    property AddList: TStringList read fAddList write fAddList;
    property BackupPath: string read fBackupPath write fBackupPath;
    property LogPrefix: string read fLogPrefix write fLogPrefix;
    function Backup(ERPDatabassesOnly: boolean = false): boolean;
    property RemoveSQLFiles: boolean read fRemoveSQLFiles write fRemoveSQLFiles;
    property LibraryPath: string read fLibraryPath write fLibraryPath;
    function Restore: boolean;
    property AllBackupsArchived: boolean read fAllBackupsArchived;
    property DeleteERPTemporyTablesBeforeBackup: boolean read fDeleteERPTemporyTablesBeforeBackup write fDeleteERPTemporyTablesBeforeBackup;
  end;

implementation

uses
  MySQLUtils, IOUtils, StrUtils, JclCompression, DbBackupUtils, DbConst,
  ModuleFileNameUtils, AppRunUtils;

{ TMySQLBackup }

function TMySQLBackup.Backup(ERPDatabassesOnly: boolean): boolean;
var
  conn: TMyConnection;
  dbList: TStringList;
  x: integer;

begin
  result := false;
  try
    BackupSQLList.Clear;
    LogList.Clear;
    fAllBackupsArchived := true;
//    Log('Currently running as: ' + GetCurrentModuleName);
    dbList := TStringList.Create;
    conn := TMyConnection.Create(nil);
    try
      SetConnectionProps(conn,'mysql','localhost');
      conn.Connect;
//      conn.GetDatabaseNames(dbList);
      dbList.CommaText := DatabaseList(Conn, ERPDatabassesOnly);
      for x := 0 to AddList.Count -1 do
        dbList.Add(AddList[x]);
      for x := 0 to dbList.Count -1 do begin
        if fExcludeList.IndexOf(dbList[x]) < 0 then begin
          conn.Disconnect;
          conn.Database := dbList[x];
          conn.Connect;
          if not BackupDb(conn) then
            exit;
        end;
      end;
      result := true;
    finally
      conn.Free;
      dbList.Free;
    end;
  except
    on e: exception do begin
      Log('Backup Error: ' + e.Message, ltError);
    end;
  end;
end;

function TMySQLBackup.BackupDb(conn: TMyConnection): boolean;
var
  path: string;
  dump: TMyDump;
  cmd: TMyCommand;
  archive: TJclCompressArchive;
  archiveclass: TJclCompressArchiveClass;
  fVersion: string;
  backupFileName: string;
  dt: TDateTime;
begin
  result := false;
  try
    if self.BackupPath = '' then begin
      Log('Backup path is blank',ltError);
      exit;
    end;
    path := IncludeTrailingPathDelimiter(BackupPath);
    if not sysutils.ForceDirectories(path) then begin
      Log('Could not create backup directory: ' + path, ltError);
      exit;
    end;

    Log('Backing up database ' + conn.Database + ' ...');
    dt := now;
    if self.DeleteERPTemporyTablesBeforeBackup then
      RemoveERPTemporyTables(conn);
    dump := TMyDump.Create(nil);
    try
      if SameText(conn.Database, 'erpdocumentaion') then begin
        cmd := TMyCommand.Create(nil);
        try
          cmd.Connection := conn;
          cmd.SQL.Text := 'truncate tblvideos';
          try
            cmd.Execute;
          except
          end;
          cmd.SQL.Text := 'truncate tblvideoblobs';
          try
            cmd.Execute;
          except
          end;
          cmd.SQL.Text := 'truncate tblvideospages';
          try
            cmd.Execute;
          except
          end;

        finally
          cmd.Free;
        end;
      end;
      //===
      if SameText(conn.Database, 'serverupdates') then begin
        cmd := TMyCommand.Create(nil);
        try
          cmd.Connection := conn;
          cmd.SQL.Text := 'truncate updates';
          try
            cmd.Execute;
          except
          end;
        finally
          cmd.Free;
        end;
      end;
      //==

      dump.Connection := conn;

      dump.Options.AddLock := false;
      dump.Options.DisableKeys := false;
//      dump.Options.HexBlob := false;
      dump.Options.HexBlob := true;
      dump.Options.UseExtSyntax := true;
      dump.Options.UseDelayedIns := false;
      dump.Options.InsertType := itInsert;
      dump.Options.GenerateHeader := false;
      dump.Options.AddDrop := false;
      dump.Options.QuoteNames := true;
      dump.Options.CompleteInsert := false;
      dump.Options.CommitBatchSize := 20;
      dump.Objects := [doTables, doViews, doData];
      dump.BackupToFile(path + conn.Database + '.sql');
      BackupSQLList.Add(path + conn.Database + '.sql');

      Log('  Done, time taken: ' + FormatDateTime('hh:nn:ss',now-dt));
    finally
      dump.Free;
    end;

    fVersion:= self.GetDbVersion(conn);
    if (fVersion <> '') and (not SameText(conn.Database, 'services')) then begin
      { make erp compatible backups }
      backupFileName := TDbBackupUtils.AddBackupNameSuffix(Path + conn.Database,fVersion) + '.7z';

      Log('  Adding data to Archive');
      dt := now;
      try
        archiveclass := TJcl7zCompressArchive; ;
        archive := archiveclass.Create(backupFileName);
        try
    //      archive.OnProgress := CompressionProgressEvent;
          archive.Password := DbConst.SYSDB_PASS;
          TJcl7zCompressArchive(archive).SetCompressionLevel(3);
          archive.AddFile(conn.Database + '.sql',path + conn.Database + '.sql');
          archive.Compress;
          if RemoveSQLFiles then
            DeleteFile(path + conn.Database + '.sql');
        finally
          archive.Free;
        end;
        Log('  Done, time taken: ' + FormatDateTime('hh:nn:ss',now-dt));
      except
        on ex: exception do begin
          if not RemoveSQLFiles then begin
            if FileExists(LibraryPath + '7za.exe') then begin
              try
                if not ExecNewProcess('"' + LibraryPath + '7za.exe" a "' + backupFileName + '" "' + path + conn.Database + '.sql" -p1w$p&LD07',true, 1000 * 60 * 60) then begin
                  fAllBackupsArchived := false;
                  Log('Unable to Zip Up Archive using 7za.exe', ltWarning);
                  Log('  Continuing.');
                end
                else
                  Log('  Done, time taken: ' + FormatDateTime('hh:nn:ss',now-dt));
              except
                on ex1 : exception do begin
                  fAllBackupsArchived := false;
                  Log('Unable to Zip Up Archive with error: ' + ex1.Message, ltWarning);
                  Log('  Continuing.');
                end;
              end;
            end
            else begin
              fAllBackupsArchived := false;
              Log('Unable to Zip Up Archive with error: ' + ex.Message, ltWarning);
              Log('  Continuing.');
            end;
          end
          else
            raise;
        end;
      end;
    end;

  except
    on e: exception do begin
      fAllBackupsArchived := false;
      Log('Error backing up database: ' + e.Message,ltError);
      exit;
    end;
  end;

  result := true;
end;

constructor TMySQLBackup.Create;
begin
  fDeleteERPTemporyTablesBeforeBackup := false;
  BackupSQLList := TStringLIst.Create;
  LogList := TStringLIst.Create;
  fRemoveSQLFiles := false;
  fExcludeList := TStringList.Create;
  fAddList := TStringList.Create;
  fExcludeList.CaseSensitive := true;
  fExcludeList.CommaText := 'information_schema,mysql';
  fLogPrefix := '';
  fAllBackupsArchived := false;
end;

function TMySQLBackup.CreateDb(conn: TMyConnection): boolean;
var
  path: string;
  dump: TMyDump;
begin
  result:= false;
  try
//    path := IncludeTrailingBackslash(BackupPath) + conn.Database + '\';
    path := IncludeTrailingPathDelimiter(BackupPath);
    Log('Restoring database ' + conn.Database + ' ...');
    dump := TMyDump.Create(nil);
    try
      dump.Connection := conn;

      dump.OnError := DoDumpOnError;
      dump.Options.AddLock := false;
      dump.Options.DisableKeys := false;
      dump.Options.HexBlob := false;
      dump.Options.UseExtSyntax := true;
      dump.Options.UseDelayedIns := false;
      dump.Options.InsertType := itInsert;
      dump.Options.GenerateHeader := false;
      dump.Options.AddDrop := false;
      dump.Options.QuoteNames := true;
      dump.Options.CompleteInsert := false;
      dump.Objects := [doTables, doViews, doData];
      dump.RestoreFromFile(path + conn.Database + '.sql');

      Log('Done.');
    finally
      dump.Free;
    end;
  except
    on e: exception do begin
      Log('Databse restore failed: ' + e.Message,ltError);
      exit;
    end;
  end;
  result := true;
end;

destructor TMySQLBackup.Destroy;
begin
  BackupSQLList.Free;
  LogList.Free;
  fExcludeList.Free;
  fAddList.Free;
  inherited;
end;

procedure TMySQLBackup.DoDumpOnError(Sender: TObject; E: Exception; SQL: string;
  var Action: TErrorAction);
begin
  Action := eaContinue;
  Log('Error while restoring: ' + E.Message,ltError);
end;

function TMySQLBackup.GetDbVersion(conn: TMyConnection): string;
var
  qry: TMyQuery;
begin
  Result := '';
  try
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= conn;
      qry.SQL.Text := 'Show Tables like "tblupdatedetails";';
      qry.Open;
      if qry.IsEmpty then
        Exit;
      qry.Close;
      qry.SQL.Text := 'SELECT Version FROM tblupdatedetails WHERE ID = 1';
      qry.Open;
      Result := qry.FieldByName('Version').AsString;
    finally
      qry.Free;
    end;
  except
  end;
end;

procedure TMySQLBackup.Log(const msg: string;
  const LogMessageType: TLogMessageType);
var
  s: string;
begin
  s := LogMessageTypeToStr(LogMessageType);
  if s <> '' then s := s + ' - ';
  s := s + msg;
  LogList.Add(s);
  if Assigned(fOnLog) then
    fOnLog(self.LogPrefix + msg,LogMessageType);
end;

procedure TMySQLBackup.RemoveERPTemporyTables(conn: TMyConnection);
var
  qry: TMyQuery;
  cmd: TMyCommand;
  dt: TDateTime;

function IsTempTable(aName: string): boolean;
var
  x, y: integer;
  cnt: integer;
begin
  result := false;
  if (Pos('erpfix_', aName) = 1) or (Pos('rpt_', aName) = 1) then begin
    result := true;
    exit;
  end;
  x := Pos('_', aName);
  if x > 1 then begin
    cnt := 0;
    for y := x to Length(aName) do begin
      if aName[y] in ['0' .. '9'] then  begin
        Inc(cnt);
        if cnt > 1 then begin
          result := true;
          exit;
        end;
      end;
    end;
  end;
end;

begin
  qry := TMyQuery.Create(nil);
  cmd := TMyCommand.Create(nil);
  try
    qry.Connection := conn;
    cmd.Connection := conn;
    qry.SQL.Add('SELECT distinct TABLE_SCHEMA , TABLE_NAME');
    qry.SQL.Add('FROM information_schema.TABLES');
    qry.SQL.Add('WHERE TABLE_SCHEMA = ' + QuotedStr(conn.Database));
    qry.SQL.Add('AND TABLE_TYPE = "BASE TABLE"');
    qry.SQL.Add('AND ((TABLE_NAME = :aTable) OR (:aTable = ""))');
    qry.ParamByName('aTable').AsString := 'tblupdatedetails';
    qry.Open;
    if qry.IsEmpty then
      exit;
    qry.Close;
    qry.ParamByName('aTable').AsString := '';
    qry.Open;
    if qry.RecordCount < 300 then
      exit;
    dt := now;
    Log('  Deleting tempory tables ..');
    while not qry.Eof do begin
      if IsTempTable(qry.FieldByName('TABLE_NAME').AsString) then begin
        cmd.SQL.Text := 'drop table ' + qry.FieldByName('TABLE_NAME').AsString;
        cmd.Execute;
      end;
      qry.Next;
    end;
    Log('  Done, time taben: ' + FormatDAteTime('hh:nn:ss',now-dt));
  finally
    qry.Free;
    cmd.Free;
  end;

end;

function TMySQLBackup.Restore: boolean;
var
//  dirList: TStringDynArray;
  fileList: TStringDynArray;
  conn: TMyConnection;
  x: integer;
  dbName: string;

  function ExtractDbName(const aPath: string): string;
  var
    arr: TStringDynArray;
  begin
    arr := StrUtils.SplitString(aPath, '\');
    result := arr[High(arr)];
  end;

begin
  result := false;
  try
    if self.BackupPath = '' then begin
      Log('Backup path is blank',ltError);
      exit;
    end;
    fileList := TDirectory.GetFiles(BackupPath);
    conn := TMyConnection.Create(nil);
    try
      SetConnectionProps(conn,'mysql','localhost');
      for x := Low(fileList) to High(fileList) do begin
        dbName := ChangeFileExt(ExtractFileName(fileList[x]),'');
        if SameText(ExtractFileExt(fileList[x]),'.sql') then begin
          if Conn.Connected then Conn.Disconnect;
          conn.Database := 'mysql';
          conn.Connect;
          conn.ExecSQL('drop database IF EXISTS ' + dbName,[]);
          conn.ExecSQL('create database ' + dbName,[]);
          conn.Disconnect;
          conn.Database := dbName;
          conn.Connect;
          if not CreateDb(conn) then
            exit;
        end;
      end;
    finally
      conn.Free;
    end;

  except
    on e: exception do begin
      Log('Error restoring databases: ' + e.Message,ltError);
      exit;
    end;

  end;
  result := true;
end;

end.
