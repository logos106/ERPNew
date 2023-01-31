unit utDllFunc;

interface

type
 TUpdateFunc = class(TObject)
 public
   class function GetMySqlRootDir: string;
   class procedure SendSupportEmail(Subject, Body: string; EmailTo: string = '');
   class function GetClientName: string;
   class function GetClientDetails: string;
   class function GetLastError: string;
   class function BackupAllDatabases: boolean;
   class function GetLog: string;
   class function ServiceStop(aServiceName: string): boolean;
   class function ServiceStart(aServiceName: string): boolean;
   class function UninstallMySQL: boolean;
   class function RunPostInstallSQL: boolean;
   class function RestoreAllDatabases: boolean;
   class function CheckMySQLRunning(WaitSeconds: integer): boolean;
   class procedure SetInstallTempDir(aDir: string);
   class procedure WriteLogFile(aName, aData: string);
 end;

implementation

uses
  classes, SysUtils, AppRunUtils, InstallConst, MySQLUtils, EmailUtilsSimple,
  MyAccess, JsonObject, CipherUtils, RandomUtils, MySQLBackupObj, ShellAPI,
  Windows, WinSVC, InnoSetupUtils, Types, MyScript, IOUtils, DateUtils,
  MailServerConst;

var
  fData: TJsonObject;

function Data: TJsonObject;
begin
  if not Assigned(fData) then
    fData := JO;
  result := fData;
end;

function StopServerService(aServiceName: string): boolean;
var
  count: integer;
begin
  result:= false;
  if not ServiceStop('',aServiceName, 120000) then begin {wait 2 mins}
//      Log('Could not stop service ('+aServiceName+') with "ServiceStop", trying "Taskkill" ..',ltWArning);
      count := 30;
      ShellExecute(0,nil,'Taskkill',PWideChar('/F /IM '+ aServiceName),nil,SW_HIDE);

      while (not (ServiceGetStatus('',aServiceName) in [SERVICE_STOPPED])) and (Count > 0) do begin
        Sleep(1000);
        Dec(count);
      end;
      if count > 0 then
        result := true;
  end
  else
    result := true;
end;

procedure Log(msg: string);
begin
  if Data.S['Log'] <> '' then Data.S['Log'] := Data.S['Log'] + #13#10;
  Data.S['Log'] := Data.S['Log'] + msg;
end;

function InstallTempDir: string;
begin
  result := Data.S['InstallTempDir'];
  if result <> '' then
    result := IncludeTrailingBackslash(result);
end;


{ TUpdateFunc }

class function TUpdateFunc.BackupAllDatabases: boolean;
var
  Backup: TMySQLBackup;
  I: integer;
begin
  Data.S['LastError'] := '';
  Data.B['AllBackupsArchived'] := false;
//  result := false;
  try
    Backup := TMySQLBackup.Create;
    try
      Backup.BackupPath := ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR;
      Backup.RemoveSQLFiles := false;
      Backup.LibraryPath := InstallTempDir;
      Backup.AddLIst.Add('services');
      Backup.DeleteERPTemporyTablesBeforeBackup := true;
      result := Backup.Backup(true);
      if result and Backup.AllBackupsArchived then
        Data.B['AllBackupsArchived'] := true;
      for I := 0 to Backup.BackupSQLList.Count -1 do
        Data.A['BackupSQLFiles'].Add(Backup.BackupSQLList[I]);
      Data.S['Log'] := Backup.LogList.Text;
    finally
      Backup.Free;
    end;
  except
    on e: exception do begin
      result := false;
      Data.S['LastError'] := e.Message;
    end;
  end;
end;

class function TUpdateFunc.CheckMySQLRunning(WaitSeconds: integer): boolean;
var
  Conn: TMyConnection;
  dt: TDateTime;
begin
  result := false;
  dt := now;
  Conn := TMyConnection.Create(nil);
  try
    SetConnectionProps(Conn,'MySQL');
    while not Conn.Connected do begin
      try
        Conn.Connect;
      except
        Sleep(5000);
        if now > (dt + (OneSecond * WaitSeconds)) then
          exit;
      end;
    end;
  finally
    Conn.Free;
  end;
  result := true;
end;

class function TUpdateFunc.GetClientDetails: string;
var
  Conn: TMyConnection;
  Json: TJsonObject;
  qry: TMyQuery;
begin
  result := '';
  Data.S['LastError'] := '';
  try
    Conn := TMyConnection.Create(nil);
    Json := JO;
    qry := TMyQuery.Create(nil);
    try
      SetConnectionProps(Conn,'services');
      Conn.Connect;
      qry.Connection := Conn;
      qry.SQL.Text := 'select * from  tblconfig where ConfigName = "ClientConfig"';
      qry.Open;
      if qry.IsEmpty then exit;
      Json.AsString := DecryptString(qry.FieldByName('ConfigValue').AsString);
  //    result := Json.O['clientconfig'].S['Name'];
      result :=
        'Client ID: ' + IntToStr(Json.O['clientconfig'].I['Id']) +
        ' Name: ' + Json.O['clientconfig'].S['Name'] +
        ' ERP Client Name: ' + Json.O['clientconfig'].S['ERPClientName'];
    finally
      Json.Free;
      qry.Free;
      Conn.Free;
    end;
  except
    on e: exception do
      Data.S['LastError'] := e.Message;
  end;
end;

class function TUpdateFunc.GetClientName: string;
var
  Conn: TMyConnection;
  Json: TJsonObject;
  qry: TMyQuery;
begin
  result := '';
  Data.S['LastError'] := '';
  try
    Conn := TMyConnection.Create(nil);
    Json := JO;
    qry := TMyQuery.Create(nil);
    try
      SetConnectionProps(Conn,'services');
      Conn.Connect;
      qry.Connection := Conn;
      qry.SQL.Text := 'select * from  tblconfig where ConfigName = "ClientConfig"';
      qry.Open;
      if qry.IsEmpty then exit;
      Json.AsString := DecryptString(qry.FieldByName('ConfigValue').AsString);
      result := Json.O['clientconfig'].S['Name'];
  //    result :=
  //      'Client ID: ' + IntToStr(Json.O['clientconfig'].I['Id']) +
  //      ' Name: ' + Json.O['clientconfig'].S['Name'] +
  //      ' ERP Client Name: ' + Json.O['clientconfig'].S['ERPClientName'];
    finally
      Json.Free;
      qry.Free;
      Conn.Free;
    end;
  except
    on e: exception do
      Data.S['LastError'] := e.Message;
  end;
end;

class function TUpdateFunc.GetMySqlRootDir: string;
var
//  sl: TStringList;
  s: string;
  MySQLBaseDir: string;
begin
  result:= '';
  Data.S['LastError'] := '';
  try
  //  sl:= TStringList.Create;
  //  try
  //    s:= GetServiceExecutablePath('',MySQL_ERP_SERVICE);
  //    sl.CommaText:= s;
  //    if sl.Count > 1 then begin
  //      MySQLServiceFile:= sl[0];
  //      MySQLServiceParams:= sl[1];
  //    end
  //    else begin
  //      Log('  Error reading MySQL_ERP service executable path, value returned: ' + s, ltError);
  //      exit;
  //    end;
  //  finally
  //    sl.Free;
  //  end;
  //  MySQLDataDir:= '';
    MySQLBaseDir:= MySQLUtils.GetMySQLBaseDir('localhost');
    if MySQLBaseDir = '' then begin
  //    Log('  Error reading MySQL_ERP Base Directory, trying alternate method ...', ltWarning);
      s:= Lowercase(GetMySQLConfigFileName);
      if Pos('bin',s) > 0 then begin
        s:= Copy(s,1, Pos('bin',s)-1);
        if s <> '' then begin
          MySQLBaseDir:= s;
  //        MySQLDataDir:= s + 'data\';
        end;
      end;
      if MySQLBaseDir = '' then begin
  //      Log('  Error reading MySQL_ERP Base Directory.', ltError);
        exit;
      end;
    end;
  //  if MySQLDataDir = '' then  begin
  //    MySQLDataDir:= MySQLUtils.GetMySQLDataDir('localhost');
  //    if MySQLDataDir = '' then begin
  //      Log('  Error reading MySQL_ERP Data Directory.', ltError);
  //      exit;
  //    end;
  //  end;
  //  Log('  MySQL Info:');
  //  Log('    MySQL service: ' + MySQLServiceFile);
  //  Log('    MySQL params: ' + MySQLServiceParams);
  //  Log('    MySQL base directory: ' + MySQLBaseDir);
  //  Log('    MySQL data directory: ' + MySQLDataDir);
    result := MySQLBaseDir;
    Data.S['MySQLBaseDir'] := MySQLBaseDir;
  except
    on e: exception do
      Data.S['LastError'] := e.Message;
  end;
end;

class function TUpdateFunc.RestoreAllDatabases: boolean;
var
  Backup: TMySQLBackup;
  I: integer;
begin
  Data.S['LastError'] := '';
  Data.S['Log'] := '';
//  result := true;
  try
    Backup := TMySQLBackup.Create;
    try
      Backup.BackupPath := ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR;
      Backup.RemoveSQLFiles := false;
      result := Backup.Restore;
      if result and Data.B['AllBackupsArchived'] then begin
        Log('Deleting backup sql files.');
        for I := 0 to Data.A['BackupSQLFiles'].Count -1 do begin
          sysUtils.DeleteFile(Data.A['BackupSQLFiles'][I].AsString);
        end;
      end;
      Data.S['Log'] := Backup.LogList.Text;
    finally
      Backup.Free;
    end;
  except
    on e: exception do begin
      result := false;
      Data.S['LastError'] := e.Message;
    end;
  end;
end;

class function TUpdateFunc.RunPostInstallSQL: boolean;
var
  conn: TMyConnection;
  scr: TMyScript;
  fileList: TStringDynArray;
  I: Integer;

begin
  result := true;
  Data.S['LastError'] := '';
  Data.S['Log'] := '';
  try
    if Data.S['MySQLBaseDir'] = '' then begin
      Data.S['LastError'] := 'MySQLBaseDir not set, call GetMySqlRootDir first.';
      result := false;
      exit;
    end;

    conn := TMyConnection.Create(nil);
    try
      SetConnectionProps(Conn,'MySQL');
      Conn.Connect;
      Log('Using MySQL Base Dir: ' + Data.S['MySQLBaseDir']);
      fileList := TDirectory.GetFiles(Data.S['MySQLBaseDir'] + '\sql');
      if Length(fileList) > 0 then begin
        scr := TMyScript.Create(nil);
        try
          scr.Connection := Conn;
          for I := Low(fileList) to High(fileList) do begin
            if SameText(ExtractFileExt(fileList[I]),'.sql') then begin
              Log('Running initial SQL on new server: ' + fileList[I]);
              scr.SQL.LoadFromFile(fileList[I]);
              scr.Execute
            end;
          end;
        finally
          scr.Free;
        end;
      end;
    finally
      conn.Free;
    end;
  except
    on e: exception do begin
      result := false;
      Data.S['LastError'] := e.Message;
    end;
  end;
end;

class function TUpdateFunc.GetLastError: string;
begin
  result := Data.S['LastError'];
end;

class function TUpdateFunc.GetLog: string;
begin
  result := Data.S['Log'];
end;

class procedure TUpdateFunc.SendSupportEmail(Subject, Body: string; EmailTo: string);
var
 str: string;
begin
  str := EMAIL_SUPPORT_RECEPIENT;
  try
    if EmailTo <> '' then
      Str := EmailTo;
    with TStringList.Create do begin
      Text := 'Subject: ' + Subject + #13#10 + 'Body: ' + Body;
      SaveToFile('c:\temp.txt');
      Free;
    end;
    SendEmail(str,Subject,Body);
  except

  end;
end;

class function TUpdateFunc.ServiceStart(aServiceName: string): boolean;
begin
  Data.S['LastError'] := '';
  result := AppRunUtils.ServiceStart('', aServiceName);
end;

class function TUpdateFunc.ServiceStop(aServiceName: string): boolean;
begin
  Data.S['LastError'] := '';
//  result := true;
  try
    result := StopServerService(aServiceName);
//    if not result then begin
//      result := AppRunUtils.ExecNewProcess('net stop ' + aServiceName, true, 1000 * 60  * 2);
//    end;
  except
    on e: exception do begin
      result := false;
      Data.S['LastError'] := e.Message;
    end;
  end;
end;

class procedure TUpdateFunc.SetInstallTempDir(aDir: string);
begin
  Data.S['InstallTempDir'] := aDir;
end;

class function TUpdateFunc.UninstallMySQL: boolean;
begin
//  result := true;
  try
    Data.S['LastError'] := '';
    if Data.S['MySQLBaseDir'] = '' then begin
      Data.S['LastError'] := 'MySQLBaseDir not set, call GetMySqlRootDir first.';
      result := false;
      exit;
    end;
    if not ServiceStop('MySQL_ERP') then begin
      result := false;
      Data.S['LastError'] := 'Could not stop the MySQL Service.';
      exit;
    end;

    result := InnoSetupUtils.UninstallApp(Data.S['MySQLBaseDir'],'',60000 * 5);  { wait 5 mins }

    TDirectory.Delete(Data.S['MySQLBaseDir'], true);

  except
    on e: exception do begin
      result := false;
      Data.S['LastError'] := e.Message;
    end;
  end;
end;

class procedure TUpdateFunc.WriteLogFile(aName, aData: string);
var
  dir: string;
begin
  dir := IncludeTrailingBackslash(ERP_SERVER_LOG_DIR);
  ForceDirectories(dir);
  try
    with TStringList.Create do begin
      Text := aData;
      SaveToFile(dir + aName);
      Free;
    end;

  except

  end;
end;

initialization
  fData := nil;

finalization
  fData.Free;


end.
