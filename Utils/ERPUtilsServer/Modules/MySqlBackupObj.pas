unit MySqlBackupObj;

interface

uses
  Classes, LogThreadLib, LogThreadBase, LogMessageTypes, OpProgressObj,
  SyncObjs;

type
  TSendProgressEvent = procedure (const aSubOpName, aDetail: string; const aStepNo, aStepCount: int64) of object;

  TMySqlBackup = class(TObject)
  private
    fOnLog: TOnLogEvent;
    fMySqlBaseDir: string;
    fTableCount,
    fTableNumber: integer;
    fPreviousLine: string;
    fOnProgress: TNotifyEvent;
    fNextProgTime: TDateTime;
    fError: string;
    fNextTime: TDateTime;
    fTaskDone: boolean;
    fAssignedProgress,
    fPrivateProgress: TOperationProgress;
    fOnSendProgress: TSendProgressEvent;
    fMySQLServer: string;
    procedure Log(msg: string; aType: TLogMessageType = ltBlank);
    function GetMySqlBaseDir: string;
    procedure BackupTextHandler(const Text: string);
    procedure RestorTextHandler(const Text: string);
    procedure SendProgress(const aSubOpName, aDetail: string; const aStepNo, aStepCount: int64);
    function GetCreateCount(aFileName: string): integer;
    function GetTaskDone: boolean;
    procedure SetTaskDone(const Value: boolean);
    function GetProgress: TOperationProgress;
    procedure SetProgress(const Value: TOperationProgress);
//    procedure DoBackupProgressEvent(Sender: TObject; ObjectName: string; ObjectNum: integer; ObjectCount: integer; Percent: integer);
    procedure DoBackupProgressEventDump(Sender: TObject; ObjectName: string; ObjectNum: integer; ObjectCount: integer; Percent: integer);
    procedure DoRestoreProgressEvent(Sender: TObject; Percent: integer);
  protected
    Lock: TCriticalSection;
    property MySqlBaseDir: string read GetMySqlBaseDir;
//    property NextTime: TDateTime read GetNextTime write SetNextTime;
    property TaskDone: boolean read GetTaskDone write SetTaskDone;
  public
    constructor Create(aMySQLServer: string = '127.0.0.1');
    destructor Destroy; override;
    property Progress: TOperationProgress read GetProgress write SetProgress;
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    property OnProgress: TNotifyEvent read fOnProgress write fOnProgress;
    property OnSendProgress: TSendProgressEvent read fOnSendProgress write fOnSendProgress;
    function BackupDb(aDbName, aOutFileName: string): boolean;
    function RestoreDb(aDbName, aInFileName: string): boolean;
    property MySQLServer: string read fMySQLServer write fMySQLServer;
  end;


implementation

uses
  MySQLUtils, SysUtils, JclSysUtils, DbConst,
//  ShellApi, Windows,
  MyAccess, DateUtils, SystemLib, MyDump;

{ TMySqlBackup }

function TMySqlBackup.BackupDb(aDbName, aOutFileName: string): boolean;
var
  cmd: string;
  conn: TMyConnection;
//  fConnPort: integer;
  fConnServer: string;
  IsLocalServer: boolean;
  dump: TMyDump;
begin
  IsLocalServer := true;
  result := true;
  try
    { use a TMyConnection to test connection to db and get actual server and port .. need if mysql cluster used .. }
    Progress.OperationName := 'Backup';
    fTableNumber := 0;
    fPreviousLine := '';
    fError := '';
    fTableCount := MySQLUtils.GetMySQLTableCount(aDbName);
    conn := TMyConnection.Create(nil);
    try
      MySQLUtils.SetConnectionProps(conn,aDBName,fMySQLServer);
      Conn.Connect;
//      fConnPort := Conn.Port;
      fConnServer := Conn.Server;
      if (not (SameText(fConnServer, 'localhost') or SameText(fConnServer,'127.0.0.1'))) then begin
        { not a local database so have to use TMyDump accross network to server .. }
        IsLocalServer := false;
        dump := TMyDump.Create(nil);
        try
          dump.Connection := conn;
          dump.Options.AddLock := false;
          dump.Options.DisableKeys := false;
          dump.Options.HexBlob := true; //false;
          dump.Options.UseExtSyntax := true;
          dump.Options.UseDelayedIns := false;
          dump.Options.InsertType := itInsert;
          dump.Options.GenerateHeader := false;
          dump.Options.AddDrop := false;
          dump.Options.QuoteNames := true;
          dump.Options.CompleteInsert := false;
          dump.Objects := [doTables, doViews, doData];
          SendProgress('Backup starting','', 1, 1);
          dump.OnBackupProgress := DoBackupProgressEventDump;
          dump.BackupToFile(aOutFileName);
        finally
          dump.Free;
        end;
        SendProgress('Backup complete', '', 1, 1);
        Exit;
      end;
    finally
      conn.Free;
    end;

    if IsLocalServer then begin
      cmd :=
        MySqlBaseDir + 'bin\mysqldump ' +
        ' --user="' + DbConst.SYSDB_USER + '"' +
        ' --password="' + DbConst.SYSDB_PASS + '"' +
        ' --port=' + IntToStr(DbConst.SERVER_PORT) +
        ' --verbose' +
        ' --routines' +
        ' --max_allowed_packet=500M' +
        ' ' + aDbName + ' -r "' + aOutFileName + '"';
      SendProgress('Backup starting', '', fTableCount, fTableNumber);
      JclSysUtils.Execute(cmd,BackupTextHandler);
    end;
//    TaskDone := false;
//    TThread.CreateAnonymousThread(
//      procedure
//      begin
//        JclSysUtils.Execute(cmd,BackupTextHandler);
//        TaskDone := true;
//      end
//    ).Start;
//
//    while true do begin
//      repeat
//        Sleep(500);
//      until (now >= fNextTime);
//      if TaskDone then Break;
//      if fTableNumber > 0 then
//        SendProgress('Backing up tables','', fTableNumber, fTableCount);
//      fNextTime := now + (10 * OneSecond);
//    end;

    if fTableNumber = 0 then begin
      { somthing went wrong }
      result := false;
      if fError <> '' then begin
        SendProgress('Backup Error - '+ fError,'', 1, 1);
        Log('Backup Error - '+ fError,ltError);
      end
      else
        Log('Backup Error - Zero tables backed up.',ltError);
    end
    else if (fError <> '') then begin
      result := false;
      SendProgress('Backup Error '+ fError,'', 1, 1);
      Log('Backup Error '+ fError,ltError);
    end
    else
      SendProgress('Backup complete','', fTableCount, fTableCount);
  except
    on e: exception do begin
      result := false;
      SendProgress('Backup Error - ',e.Message, 1, 1);
      Log('Backup Error - '+e.Message,ltError);
    end;
  end;
end;

function  TMySqlBackup.GetCreateCount(aFileName: string): integer;
var
  readFile: TextFile;
  s: string;
begin
  result := 0;
  AssignFile(readFile, aFileName);
  Reset(readFile);
  while not Eof(readFile) do begin
    ReadLn(readFile,s);
    if (Pos('CREATE TABLE',s) = 1) or (Pos('CREATE VIEW',s) > 0) then
      Inc(result);
  end;

  CloseFile(readFile);
end;

function TMySqlBackup.GetMySqlBaseDir: string;
begin
  if fMySqlBaseDir = '' then
    fMySqlBaseDir := SysUtils.IncludeTrailingPathDelimiter(MySQLUtils.GetMySQLBaseDir());
  result := fMySqlBaseDir;
end;

function TMySqlBackup.GetProgress: TOperationProgress;
begin
  if Assigned(fAssignedProgress) then
    result := fAssignedProgress
  else begin
    if not Assigned(fPrivateProgress) then
      fPrivateProgress := TOperationProgress.Create;
    result := fPrivateProgress;
  end;
end;

function TMySqlBackup.GetTaskDone: boolean;
begin
  Lock.Acquire;
  try
    result := fTaskDone;
  finally
    Lock.Release;
  end;
end;

procedure TMySqlBackup.Log(msg: string; aType: TLogMessageType);
begin
  if Assigned(fOnLog) then
    fOnLog(msg,aType);
end;

function TMySqlBackup.RestoreDb(aDbName, aInFileName: string): boolean;
var
  cmd: string;
  Conn: TMyConnection;
  qry: TMyQuery;
  tempFile: string;
  dump: TMyDump;
begin
  result := true;
  try
    Conn := TMyConnection.Create(nil);
    qry := TMyQuery.Create(nil);
    try
      MySqlUtils.SetConnectionProps(Conn,DbConst.MYSQL_DATABASE,fMySQLServer);
      Conn.Connect;
      qry.Connection := Conn;
      Progress.OperationName := 'Restore';
      SendProgress('Check / Drop Databse','', 1, 100);
      qry.SQL.Text := 'drop database if exists ' + aDbName;
      qry.Execute;
      qry.SQL.Text := 'create database ' + aDbName;
      qry.Execute;
      Conn.Disconnect;
      Conn.Database := aDbName;
      Conn.Connect;

      if (not (SameText(Conn.Server,'localhost') or SameText(Conn.Server,'127.0.0.1'))) then begin
        { not a local database so have to use TMyDump accross network to server .. }
//        IsLocalServer := false;
        dump := TMyDump.Create(nil);
        try
          dump.Connection := conn;
          dump.Options.AddLock := false;
          dump.Options.DisableKeys := false;
          dump.Options.HexBlob := true; //false;
          dump.Options.UseExtSyntax := true;
          dump.Options.UseDelayedIns := false;
          dump.Options.InsertType := itInsert;
          dump.Options.GenerateHeader := false;
          dump.Options.AddDrop := false;
          dump.Options.QuoteNames := true;
          dump.Options.CompleteInsert := false;
          dump.Objects := [doTables, doViews, doData];
          SendProgress('Restore starting','', 100, 0);
          dump.OnRestoreProgress := DoRestoreProgressEvent;
          dump.RestoreFromFile(aInFileName);
        finally
          dump.Free;
        end;
        SendProgress('Restore complete', '', 100, 100);
      end
      else begin
        fTableNumber := 0;
        fPreviousLine := '';
        fError := '';
  //      fTableCount := GetCreateCount(aInFileName);
        SendProgress('Analyzing input file', '', 1, 100);
        fTableCount := GetCreateCount(aInFileName);
        if fTableCount < 400 then begin
          result := false;
          SendProgress('Restore Faild, Input file invalid','', 1, 1);
          exit;
        end;

        tempFile := SystemLib.GetTempFileName('', '.sql');
        cmd :=
          MySqlBaseDir + 'bin\mysql.exe --user="' + DbConst.SYSDB_USER + '"' +
          ' --password="' + DbConst.SYSDB_PASS + '"' +
          ' --port=' + IntToStr(DbConst.SERVER_PORT) +
          ' ' + aDbName + ' < "' + tempFile + '"';
        SendProgress('Restore starting', '', fTableCount, fTableNumber);
        cmd := '/c ' + cmd;
        with TStringList.Create do begin
          Add('source ' + StringReplace(aInFileName, '\', '/', [rfReplaceAll]) + ';');
  //        Add('quit;');
          SaveToFile(tempFile);
          free;
        end;

        { run in separate thread .. }
        fNextTime := now + (15 * OneSecond);
        TaskDone := false;
        TThread.CreateAnonymousThread(
          procedure
          begin
            JclSysUtils.Execute('cmd.exe ' + cmd,RestorTextHandler);
            TaskDone := true;
          end

        ).Start;

        qry.SQL.Text := 'SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = ' + QuotedStr(aDbName);

        while true do begin
          repeat
            Sleep(500);
          until (now >= fNextTime);
          if TaskDone then
            Break;
          qry.Open;
          fTableNumber := qry.Fields[0].AsInteger;
          qry.Close;
          SendProgress('Restoring tables','', fTableNumber, fTableCount);
          fNextTime := now + (10 * OneSecond);
        end;

        qry.Open;
        fTableNumber := qry.Fields[0].AsInteger;
        qry.Close;

        if fTableNumber = 0 then begin
          { somthing went wrong }
          result := false;
          if fError <> '' then begin
            SendProgress('Restore Error - '+ fError,'', 1, 1);
            Log('Restore Error - '+ fError,ltError);
          end
          else
            Log('Restore Error - Zero tables where restored. ',ltError);
        end
        else if (fError <> '') then begin
          result := false;
          SendProgress('Restor Error '+ fError,'', 1, 1);
          Log('Restore Error - '+ fError,ltError);
        end
        else
          SendProgress('Restore complete','', fTableCount, fTableCount);
      end;
    finally
      qry.Free;
      Conn.Free;
    end;
  except
    on e: exception do begin
      result := false;
      SendProgress('Restore Error: ' + e.Message,'', 1, 1);
      Log('Restore Error: ' + e.Message,ltError);
    end;
  end;
end;

procedure TMySqlBackup.RestorTextHandler(const Text: string);
begin
//  Log(Text);
  Lock.Acquire;
  try
    if Pos('error',Lowercase(Copy(Text,1,30))) > 0 then
      fError := Text;
  finally
    Lock.Release;
  end;
end;

procedure TMySqlBackup.SendProgress(const aSubOpName, aDetail: string;
  const aStepNo, aStepCount: int64);
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
    if aStepNo = 1 then begin
      fNextProgTime := now;
    end;
    if (Percent = 100) then SendProgress := true                { always show 100% }
    else if (now >= fNextProgTime) then SendProgress := true    { send if more thab x time has passed }
    else if (Frac(Percent /10) = 0) then SendProgress := true;  { send 10% steps as a minimum }
    if not SendProgress then
      exit;

    fNextProgTime := now + (5 * OneSec);
    if aStepCount > 1 then begin
      { change message to % done .. }
      dtl := aSubOpName + ' ' + IntToStr(Percent) + '% Done';
    end;

    Progress.SubOperationName:= aSubOpName;
    Progress.Detail:= dtl; //aDetail;
    Progress.StepNo:= aStepNo;
    Progress.StepCount:= aStepCount;
    fOnProgress(self);
  end;
  if Assigned(fOnSendProgress) then
    fOnSendProgress(aSubOpName, aDetail, aStepNo, aStepCount);
end;

procedure TMySqlBackup.SetProgress(const Value: TOperationProgress);
begin
  fAssignedProgress := Value;
end;

procedure TMySqlBackup.SetTaskDone(const Value: boolean);
begin
  Lock.Acquire;
  try
    fTaskDone := Value;
  finally
    Lock.Release;
  end;
end;

procedure TMySqlBackup.BackupTextHandler(const Text: string);
var
  ObjectName: string;
const
  LinePrefix = 'Retrieving table structure for table ';
begin
  Lock.Acquire;
  try
//    Log(Text);
    if Pos('error',Lowercase(Copy(Text,1,30))) > 0 then
      fError := Text;
    if (Pos('Sending SELECT query',Text) > 0) or (Pos('It''s a view, create dummy view',Text) > 0)  then begin
      Inc(fTableNumber);
      if fPreviousLine <> '' then begin
        ObjectName := '';
        if Pos(LinePrefix,fPreviousLine) > 0 then begin

          ObjectName := Copy(fPreviousLine,Pos(LinePrefix,fPreviousLine) + Length(LinePrefix),Length(fPreviousLine));
          ObjectName := Copy(ObjectName,1,Length(ObjectName)-3);
        end;
        SendProgress('Backing up tables',ObjectName, fTableNumber, fTableCount);
      end;
    end;

    fPreviousLine := Text;
  finally
    Lock.Release;
  end;
end;

constructor TMySqlBackup.Create(aMySQLServer: string);
begin
  fMySQLServer := aMySQLServer;
  Lock := TCriticalSection.Create;
//  Progress := TOperationProgress.Create;
end;

destructor TMySqlBackup.Destroy;
begin
  fPrivateProgress.Free;
  Lock.Free;
  inherited;
end;

//procedure TMySqlBackup.DoBackupProgressEvent(Sender: TObject;
//  ObjectName: string; ObjectNum, ObjectCount, Percent: integer);
//begin
//  SendProgress('Backing up tables',ObjectName, fTableNumber, fTableCount);
//  Inc(fTableNumber);
//end;

procedure TMySqlBackup.DoBackupProgressEventDump(Sender: TObject;
  ObjectName: string; ObjectNum, ObjectCount, Percent: integer);
begin
  SendProgress('Backing up tables',IntToStr(Percent) + '%', ObjectNum, ObjectCount);
end;

procedure TMySqlBackup.DoRestoreProgressEvent(Sender: TObject; Percent: integer);
begin
  SendProgress('Restoring tables',IntToStr(Percent) + '%', 100, Percent);
end;

end.
