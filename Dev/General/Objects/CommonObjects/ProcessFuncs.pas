unit ProcessFuncs;
interface

type
  eSvcStatus = (essUnknown, essRunning, essPaused, essStopped, essStarting, essStopping,
                essPausePending, essContinuePending);
  eSvcCmd = (escStart, escStop, escPause, escContinue);

  ISvcCtrl = interface
    function GetSvcStatus(): eSvcStatus;
    procedure SvcCmd(cmd: eSvcCmd);
    function IsConnected(): boolean;
    function StopOrKillService(const iTimeOutMs: cardinal): boolean;
  end;

function KillProcessByName(const sName: string): boolean;
function makeSvcCtrl(const sSvcName: string; const sModName: string): ISvcCtrl;
function StopOrKillService(const sSvcName: string; const sModName: string;
                           const iTimeOutMs: cardinal): boolean;


// ==================================================================

implementation

uses
  SysUtils,
  DateUtils,
  Windows,
  WinTypes,
  WinSvc,
  TlHelp32;

type
  TSvcCtrl = class (TInterfacedObject, ISvcCtrl)
    fsSvcName : string;
    fsModName : string;
    fhSCM : THandle;
    fhSvc : THandle;
    constructor Create(const sSvcName: string; const sModName: string);
    destructor Destroy; override;
    function IsConnected: boolean;
    function GetSvcStatus(): eSvcStatus;
    procedure SvcCmd(cmd: eSvcCmd);
    function StopOrKillService(const iTimeOutMs: cardinal): boolean;
    function StopService(const iTimeOutMs: cardinal): boolean;
  end;

// ==================================================================

function makeSvcCtrl(const sSvcName: string; const sModName: string): ISvcCtrl;
begin
  Result := TSvcCtrl.Create(sSvcName, sModName);
end;

// ==================================================================

function SetPrivilege(aPrivilegeName: string; aEnabled: boolean): boolean;
var
  TP : TTokenPrivileges;
  TPPrev : TTokenPrivileges;
  Token : THandle;
  dwRetLen : DWord;
begin
  Result := False;
  OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, Token);
  TP.PrivilegeCount := 1;
  if (LookupPrivilegeValue(nil, PChar(aPrivilegeName), TP.Privileges[0].LUID)) then begin
    if (aEnabled) then
      TP.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
    else
      TP.Privileges[0].Attributes := 0;
    dwRetLen := 0;
    Result := WinTypes.AdjustTokenPrivileges(Token, False, TP, SizeOf(TPPrev), TPPrev, dwRetLen);
  end;
  CloseHandle(Token);
end;

// ==================================================================

function StopOrKillService(const sSvcName: string; const sModName: string;
                           const iTimeOutMs: cardinal): boolean;
var
  SvcCtrl: TSvcCtrl;
begin
  SvcCtrl:= TSvcCtrl.Create(sSvcName,sModName);
  try
    result:= SvcCtrl.StopOrKillService(iTimeOutMs);
  finally
    SvcCtrl.Free;
  end;
end;

// ------------------------------------------------------------------

function KillProcessByPID(pid: cardinal): boolean;
var
  hProc : THandle;
begin
  Result := False;
  // you need debug privilege to kill a service
  if not SetPrivilege('SeDebugPrivilege', True) then exit;
  hProc := OpenProcess(STANDARD_RIGHTS_REQUIRED or PROCESS_TERMINATE, False, pid);
  try
    if hProc > 0 then begin
      Result := TerminateProcess(hProc, 1);
    end;
  finally
    CloseHandle(hProc);
    SetPrivilege('SeDebugPrivilege', False);
  end;
end;

// ------------------------------------------------------------------

function KillProcessByName(const sName: string): boolean;
var
  snap : THandle;
  ppe : PROCESSENTRY32;
  bRes : boolean;
  sNoPath : string;
begin
  Result := False;
  ZeroMemory(@ppe, sizeof(ppe));
  ppe.dwSize := sizeof(ppe);
  sNoPath := ExtractFileName(sName);

  // you also find services using their bare exe name
  snap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    bRes := Process32First(snap, ppe);
    while (bRes) do begin
      if ppe.szExeFile = sNoPath then begin
        Result := KillProcessByPID(ppe.th32ProcessID);
        exit;
      end;
      ppe.dwSize := sizeof(ppe);
      bRes := Process32Next(snap, ppe);
    end;
  finally
    CloseHandle(snap);
  end;
end;

// ==================================================================
{ TSvcCtrl }

constructor TSvcCtrl.Create(const sSvcName: string; const sModName: string);
begin
  fsSvcName := sSvcName;
  fsModName := sModName;
  fhSCM := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  fhSvc := 0;
  if (fhSCM <> 0) then begin
    fhSvc := OpenService(fhSCM, PChar(fsSvcName), SERVICE_ALL_ACCESS);
  end;
end;

// ------------------------------------------------------------------

destructor TSvcCtrl.Destroy;
begin
  if (fhSvc <> 0) then
    CloseServiceHandle(fhSvc);
  if (fhSCM <> 0) then
    CloseServiceHandle(fhSCM);
  inherited;
end;

// ------------------------------------------------------------------

function TSvcCtrl.GetSvcStatus: eSvcStatus;
var
  st : _SERVICE_STATUS;
begin
  Result := essUnknown;
  if IsConnected() and QueryServiceStatus(fhSvc, st) then begin
    case st.dwCurrentState of
      SERVICE_STOPPED: Result := essStopped;
      SERVICE_START_PENDING: Result := essStarting;
      SERVICE_STOP_PENDING: Result := essStopping;
      SERVICE_RUNNING: Result := essRunning;
      SERVICE_CONTINUE_PENDING: Result := essContinuePending;
      SERVICE_PAUSE_PENDING: Result := essPausePending;
      SERVICE_PAUSED: Result := essPaused;
    end; // case
  end;
end;

// ------------------------------------------------------------------

function TSvcCtrl.IsConnected: boolean;
begin
  Result := (fhSCM <> 0) and (fhSvc <> 0);
end;

// ------------------------------------------------------------------

// tries to stop the service the normal way and if it doesn't succeed
// within the timeout, goes on to kill it via terminateprocedure
function TSvcCtrl.StopOrKillService(const iTimeOutMs: cardinal): boolean;
begin
  // trivial case first
  if GetSvcStatus() = essStopped then
    Result := True
  else if StopService(iTimeOutMs) then
    Result := True
  else 
    Result := KillProcessByName(fsModName);
end;

// ------------------------------------------------------------------

function TSvcCtrl.StopService(const iTimeOutMs: cardinal): boolean;
var
  startTime : TDateTime;
begin
  startTime := Now;
  Result := False;
  SvcCmd(escStop);
  repeat
    SleepEx(100, False);
    Result := (GetSvcStatus() = essStopped);
  until (MilliSecondsBetween(Now, startTime) > iTimeOutMs) or (Result = True);
end;

// ------------------------------------------------------------------

procedure TSvcCtrl.SvcCmd(cmd: eSvcCmd);
var
  stat : eSvcStatus;

  procedure SendSvcCmd(cmd: eSvcCmd);
  var
    dummy : PChar;
    SvcStatus : SERVICE_STATUS;
  begin
    case cmd of
      escStart : StartService(fhSvc, 0, dummy);
      escStop : ControlService(fhSvc, SERVICE_CONTROL_STOP, SvcStatus);
      escPause : ControlService(fhSvc, SERVICE_CONTROL_PAUSE, SvcStatus);
      escContinue : ControlService(fhSvc, SERVICE_CONTROL_CONTINUE, SvcStatus);
    end;
  end;

begin
  stat := GetSvcStatus();
  case cmd of
    escStart :
      if stat in [essStopped] then
        SendSvcCmd(cmd);
    escStop :
      if stat in [essRunning, essPaused, essPausePending, essContinuePending] then
        SendSvcCmd(cmd);
    escPause :
      if stat in [essRunning] then
        SendSvcCmd(cmd);
    escContinue :
      if stat in [essPaused] then
        SendSvcCmd(cmd);
  end;
end;

// ------------------------------------------------------------------

end.


