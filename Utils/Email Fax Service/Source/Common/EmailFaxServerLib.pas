unit EmailFaxServerLib;

interface
   Uses Classes, SyncObjs, WinSvc, Windows, MyAccess, MyClasses, MySQLErrors, Graphics, InstallConst;

const
  AdvApiDLL      = 'advapi32.dll';
  SERVICE_CONFIG_FAILURE_ACTIONS = 2;
  MaxEmailSize =  15600000;
//  LOGSPATH    = 'C:\ERP Software\Logs\'; ==> SHould be ERP_SERVER_LOG_DIR
  LOGFILENAME = 'EmailFaxServerLog';
  CryptoKey = '~1|Wy4^|Wb7#|Pi7!|Qy0)|Ct3*|1~';
  INI_FileName = 'Setup.ini';

type
  TChangeServiceConfig2 = function(hService: SC_HANDLE; dwInfoLevel: DWORD; lpInfo: Pointer): BOOL; stdcall;

  SC_ACTION_TYPE = (SC_ACTION_NONE, SC_ACTION_RESTART, SC_ACTION_REBOOT, SC_ACTION_RUN_COMMAND);

  SC_ACTION = record
    aType: SC_ACTION_TYPE;
    Delay: DWORD;
  end;

  SERVICE_FAILURE_ACTIONS = record
    dwResetPeriod: DWORD;
    lpRebootMsg: LPTSTR;
    lpCommand: LPTSTR;
    cActions: DWORD;
    lpsaActions: ^SC_ACTION;
  end;


procedure RefreshMemoryUsage;
procedure DeleteFiles(const sPath, sMask: string);
function CreateDBConnection(const Owner: TComponent; const DatabaseName: string = ''): TMyConnection;
function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
function Empty(const s: string): boolean;
function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
function CharCounter(const char, TestString: string): integer;
procedure HoldWait(Const Seconds:Integer);
function GetFileVersion(const FileName: string): string;
function GetDBList(const MyConnection: TMyConnection): TStringList;
function TablesCount(Const DBConnection: TMyConnection; Const Database:String): Integer;
function TempDir: string;
procedure PerformPaints;

implementation
   Uses SysUtils, EmailFaxServerUnit, ShellApi, FastFuncs, ExcMagic, Messages;

const
  MysqlPort      = 3309;
  MysqlUsername  = 'P_One';
  MysqlPassword  = '1w$p&LD07';

procedure HoldWait(Const Seconds:Integer);
var
  I:Double;
Begin
  I := 0;
  repeat
    EmailFaxServer.ServiceThread.ProcessRequests(false);
    Sleep(50);
    EmailFaxServer.ServiceThread.ProcessRequests(false);
    Sleep(50);
    EmailFaxServer.ServiceThread.ProcessRequests(false);
    I := I + 1;
  until ((I/10) > Seconds);
end;

function CharCounter(const char, TestString: string): integer;
var
  TempStr: string;
  S, Count, I: integer;
begin
  TempStr := TestString;
  Count := 1;

  for I := 1 to Length(TestString) do begin
    S := Pos(char, TempStr);
    if S > 0 then begin
      Delete(TempStr, S, Length(char));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;

function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := Source + Delim;
  S := 1;
  for L9 := 1 to PosCount - 1 do begin
    S := Pos(Delim, Src);
    if S > 0 then Delete(Src, S, Length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;  

function Empty(const s: string): boolean;
begin
  Result := (Trim(s) = '');
end;

function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  Result := FastFuncs.AnsiStringReplace(sString, sOldStr, sNewStr, [rfReplaceAll]);
end;

procedure DeleteFiles(const sPath, sMask: string);
{Example Usage   sPath = c:\Temp\  sMask=*.tmp}
var
  lpFileOp: TSHFileOpStruct;
begin
  FillChar(lpFileOp, SizeOf(lpFileOp), #0);
  lpFileOp.wFunc := FO_DELETE;
  // The + #0 is required
  lpFileOp.pFrom := PChar(sPath + sMask + #0);
  lpFileOp.pTo := PChar(sPath);
  lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
  //Perform Operation
  if (SHFileOperation(lpFileOp) <> 0) then Exit;
end;

procedure RefreshMemoryUsage;
var
  MainHandle: THandle;
begin  
  MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
  SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
  CloseHandle(MainHandle);
end;

function SetMyDacConnection(const MyConnection: TMyConnection; const ServerName: string; const DatabaseName: string): boolean;
begin
  Result := true;
  try
    MyConnection.Disconnect;
    MyConnection.Server           := ServerName;
    MyConnection.Database         := DatabaseName;
    MyConnection.Username         := MysqlUsername;
    MyConnection.Password         := MysqlPassword;
    MyConnection.Port             := MysqlPort;
    MyConnection.Options.Compress := false;
    MyConnection.Options.Protocol := mpDefault;
    MyConnection.LoginPrompt      := false;
  except
    Result := false;
  end;
end;

function TestDBConnectionOk(const DBConnection: TMyConnection): boolean;
begin  
  Result := false;
  Try
    ExcMagic.ExceptionHook.LogEnabled := False;  
    try
      DBConnection.Disconnect;
      DBConnection.Connect;
      Result := true;
    except
      on E: EMyError do;
      on E: EMySqlException do;
      else
        raise;
    end;
  Finally
    ExcMagic.ExceptionHook.LogEnabled := True;
  end;    
end;

function CreateDBConnection(const Owner: TComponent; const DatabaseName: string): TMyConnection;
var
  Database:String;
begin
  Result := TMyConnection.Create(Owner);
  if DatabaseName = '' then
    Database := 'Mysql'
  else
    Database := DatabaseName;
  SetMyDacConnection(Result,EmailFaxServer.INI_Options.MySQLServer,Database);
  if not TestDBConnectionOk(Result) then
    SysUtils.FreeAndNil(Result);
end;

procedure PerformPaints;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) do
    DispatchMessage(Msg);
end;

function GetFileVersion(const FileName: string): string;
var
  VersionInfoSize, VersionInfoValueSize, Zero: DWord;
  VersionInfo, VersionInfoValue: Pointer;
begin
  Result := '';
  if not FileExists(FileName) then Exit;
  VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
  if VersionInfoSize = 0 then Exit;
  GetMem(VersionInfo, VersionInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo,
      '\', VersionInfoValue,
      VersionInfoValueSize) and (0 <> longint(VersionInfoValueSize)) then begin
      with TVSFixedFileInfo(VersionInfoValue^) do begin
        Result := FastFuncs.IntToStr(HiWord(dwFileVersionMS));
        Result := Result + '.' + FastFuncs.IntToStr(LoWord(dwFileVersionMS));
        Result := Result + '.' + FastFuncs.IntToStr(HiWord(dwFileVersionLS));
        Result := Result + '.' + FastFuncs.IntToStr(LoWord(dwFileVersionLS));
      end;
    end;
  finally
    FreeMem(VersionInfo);
  end;
end;

function TablesCount(Const DBConnection: TMyConnection; Const Database:String): Integer;
Var
  Tables : TStringList;
Begin
  Tables := TStringList.Create;
  Try
    DBConnection.GetTableNames(Tables);
    Result := Tables.Count;
  finally
    FreeAndNil(Tables);
  end;
end;

function GetDBList(const MyConnection: TMyConnection): TStringList;
Begin
  Result := TStringList.Create;
  MyConnection.GetDatabaseNames(Result);
end;

function TempDir: string;
var
  acDir: array[0..255] of char;
begin
  GetTempPath(SizeOf(acDir), acDir);
  result := StrPas(acDir);
end;

end.
 