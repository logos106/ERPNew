unit AppRunUtils;

interface

uses
 types, classes, windows;

function ServiceStart(aMachine, aServiceName : string ) : boolean;
function ServiceStop(aMachine,aServiceName : string; WaitMs: Cardinal = INFINITE) : boolean;
{ ServiceGetStatus returns one of the following:
    SERVICE_STOPPED
    SERVICE_RUNNING
    SERVICE_PAUSED
    SERVICE_START_PENDING
    SERVICE_STOP_PENDING
    SERVICE_CONTINUE_PENDING
    SERVICE_PAUSE_PENDING }
function ServiceGetStatus(sMachine, sService: string): DWord;

function ServiceGetList(sMachine: string; dwServiceType, dwServiceState : DWord;
  slServicesList: TStrings; DisplayName: boolean = true; ServiceName: boolean = false ): boolean;

function ServiceIsInstalled(sMachine, sService: string): boolean;

function VistaExecElevated(FileName, CLParams, Dir : String;
                           var ExitCode: DWORD; const Wait: DWORD = 0): LongWord;
function ExecNewProcess(ProgramName : String; Wait: Boolean = false;
  WaitMilliSeconds: DWORD = INFINITE): boolean;
procedure CloseApp(AppMainWindowCaption: PChar);

function KillTask(ExeFileName: string): Integer;
function ProcessExists(exeFileName: string): Boolean;

function GetServiceExecutablePath(strMachine: string; strServiceName: string): string;
function GetProcessPath(exeFileName: string): string;

function RunAsAdmin(const Path, Params: string): Boolean;

const
  //
  // Service Types
  //
  SERVICE_KERNEL_DRIVER       = $00000001;
  SERVICE_FILE_SYSTEM_DRIVER  = $00000002;
  SERVICE_ADAPTER             = $00000004;
  SERVICE_RECOGNIZER_DRIVER   = $00000008;

  SERVICE_DRIVER              =
    (SERVICE_KERNEL_DRIVER or
     SERVICE_FILE_SYSTEM_DRIVER or
     SERVICE_RECOGNIZER_DRIVER);

  SERVICE_WIN32_OWN_PROCESS   = $00000010;
  SERVICE_WIN32_SHARE_PROCESS = $00000020;
  SERVICE_WIN32               =
    (SERVICE_WIN32_OWN_PROCESS or
     SERVICE_WIN32_SHARE_PROCESS);

  SERVICE_INTERACTIVE_PROCESS = $00000100;

  SERVICE_TYPE_ALL            =
    (SERVICE_WIN32 or
     SERVICE_ADAPTER or
     SERVICE_DRIVER  or
     SERVICE_INTERACTIVE_PROCESS);

implementation


uses WinSvc, ShellApi, Tlhelp32, sysutils, DateUtils, Psapi;

function ServiceStart(aMachine, aServiceName: string ): Boolean;
// aMachine is UNC path or local machine if left empty
var
  h_manager, h_svc: SC_Handle;
  svc_status: TServiceStatus;
  Temp: PChar;
  dwCheckPoint: DWord;
begin
  svc_status.dwCurrentState := 1;
  h_manager := OpenSCManager(PChar(aMachine), Nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName), SERVICE_START or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      temp := nil;
      if (StartService(h_svc, 0, temp)) then
        if (QueryServiceStatus(h_svc, svc_status)) then
        begin
          while (SERVICE_RUNNING <> svc_status.dwCurrentState) do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;

            Sleep(svc_status.dwWaitHint);

            if (not QueryServiceStatus(h_svc, svc_status)) then
              Break;

            if (svc_status.dwCheckPoint < dwCheckPoint) then
            begin
              // QueryServiceStatus didn't increment dwCheckPoint
              break;
            end;
          end;
        end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_RUNNING = svc_status.dwCurrentState;
end;


function ServiceStop(aMachine,aServiceName : string; WaitMs: Cardinal = INFINITE) : boolean;
// aMachine is UNC path or local machine if left empty
var
  h_manager,h_svc   : SC_Handle;
  svc_status     : TServiceStatus;
  dwCheckPoint : DWord;
  timeStart: TDateTime;
begin
  h_manager:=OpenSCManager(PChar(aMachine),nil,
                           SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(aServiceName),
                         SERVICE_STOP or SERVICE_QUERY_STATUS);

    if h_svc > 0 then
    begin
      if(ControlService(h_svc,SERVICE_CONTROL_STOP,
                        svc_status))then
      begin
        if(QueryServiceStatus(h_svc,svc_status))then
        begin
          timeStart:= now;
          while(SERVICE_STOPPED <> svc_status.dwCurrentState)do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
//            Sleep(svc_status.dwWaitHint);
            Sleep(100);

            if (timeStart <> INFINITE) and (MilliSecondsBetween(Now, timeStart) > timeStart) then
              break;
            if(not QueryServiceStatus(h_svc,svc_status))then
            begin
              // couldn't check status
              break;
            end;

            if(svc_status.dwCheckPoint < dwCheckPoint)then
              break;

          end;
        end;
      end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;

  Result := SERVICE_STOPPED = svc_status.dwCurrentState;
end;

{ ServiceGetStatus returns one of the following:
    SERVICE_STOPPED
    SERVICE_RUNNING
    SERVICE_PAUSED
    SERVICE_START_PENDING
    SERVICE_STOP_PENDING
    SERVICE_CONTINUE_PENDING
    SERVICE_PAUSE_PENDING
}
function ServiceGetStatus(sMachine, sService: string ): DWord;
var
  h_manager,h_service: SC_Handle;
  service_status     : TServiceStatus;
  hStat : DWord;
begin
  hStat := 1;
  h_manager := OpenSCManager(PChar(sMachine) ,Nil,
                             SC_MANAGER_CONNECT);

  if h_manager > 0 then
  begin
    h_service := OpenService(h_manager,PChar(sService),
                      SERVICE_QUERY_STATUS);

    if h_service > 0 then
    begin
      if(QueryServiceStatus(h_service, service_status)) then
        hStat := service_status.dwCurrentState;

      CloseServiceHandle(h_service);
    end;
    CloseServiceHandle(h_manager);
  end;

  Result := hStat;
end;

function VistaExecElevated(FileName, CLParams, Dir : String; var ExitCode: DWORD; const Wait: DWORD = 0): LongWord;
var
 shExecInfo : TShellExecuteInfo;
 iWaitRes: DWORD;
begin
 Result := 0;
 if FileName <> '' then
  begin
   FillChar(shExecInfo, SizeOf(shExecInfo), 0);
   shExecInfo.cbSize := SizeOf(shExecInfo);
   {if hHandle <> null then
    shExecInfo.WND := Hhandle;}
   shExecInfo.fMask  := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_NO_UI;
   //shExecInfo.hInstApp := NULL;
   shExecInfo.lpVerb := PChar('runas');
   shExecInfo.lpFile := PChar(FileName);
   if CLParams <> '' then
    shExecInfo.lpParameters := PChar(CLParams);
   if Dir <> '' then
    shExecInfo.lpDirectory := pchar(Dir);
   shExecInfo.nShow := SW_HIDE;   {SW_SHOW}
   ShellExecuteEx(@shExecInfo);
   Result := shExecInfo.hInstApp;
   if Result > 32 then
    begin
     // wait on process ?
     if (Wait > 0) then
      begin
       iWaitRes := WaitForSingleObject(shExecInfo.hProcess, Wait);
       // timeout reached ?
       if (iWaitRes = WAIT_TIMEOUT) then
        begin
          //Result := 0;
          TerminateProcess(shExecInfo.hProcess, 0);
        end;
       // get the exitcode
       GetExitCodeProcess(shExecInfo.hProcess, ExitCode);
      end;
     // close handle, because SEE_MASK_NOCLOSEPROCESS was set
     CloseHandle(shExecInfo.hProcess);
    end;
 end;
end;

{ ProgramName is full path and can include params }
function ExecNewProcess(ProgramName: String; Wait: Boolean = False; WaitMilliSeconds: DWORD = INFINITE): Boolean;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  WaitResult: Integer;
  ProgramNameVar: String;
begin
  ProgramNameVar := ProgramName;
  UniqueString(ProgramNameVar);
    { fill with known state }
  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);
  Result := CreateProcess(nil, PChar(ProgramNameVar), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);
    { check to see if successful }
  if Result then begin
        //may or may not be needed. Usually wait for child processes
    if Wait then begin
      WaitResult := WaitForSingleObject(ProcInfo.hProcess, WaitMilliSeconds);
      Result := WaitResult <> WAIT_TIMEOUT;
    end;
  end;

  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;

procedure CloseApp(AppMainWindowCaption: PChar);
var
   ProcessHandle:THandle;
   WinHwnd:HWND;
   ProcessID, ExitCode:Integer;
begin
   ProcessID := 0;
   ExitCode := 0;

   WinHwnd := FindWindow(nil,AppMainWindowCaption);
   // Or use next line of code. I found so issues with
   // it so I prefer the previous one
   //WinHwnd :=FindWindow('[MainApplicationClassName]', nil);

   if not (IsWindow(WinHwnd)) then
      Exit;

   GetWindowThreadProcessID(WinHwnd, @ProcessID);

   ProcessHandle := OpenProcess(PROCESS_CREATE_THREAD or PROCESS_VM_OPERATION
      or PROCESS_VM_WRITE or PROCESS_VM_READ or PROCESS_TERMINATE, False, ProcessID);

   if (ProcessHandle > 0) then
   begin
      GetExitCodeProcess(ProcessHandle, DWORD(ExitCode));
      TerminateProcess(ProcessHandle, ExitCode);
      CloseHandle(ProcessHandle);
   end;
end;

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function processExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function GetProcessPath(exeFileName: string): string;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;

  function GetMFEx(inmod: THandle): string;
    var
      hProcess: THandle;
      ModuleName: array [0..300] of Char;
    begin
      hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,
                  False, inmod);
      if (hProcess <> 0) then
        begin
          GetModuleFilenameEx(hProcess, 0, ModuleName, SizeOf(ModuleName));
          CloseHandle(hProcess);
          Result := ModuleName;
        end;
    end;

begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := '';
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := GetMFEx(FProcessEntry32.Th32ProcessID);;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

//-------------------------------------
// Get a list of services
//
// return TRUE if successful
//
// sMachine:
//   machine name, ie: \SERVER
//   empty = local machine
//
// dwServiceType
//   SERVICE_WIN32,
//   SERVICE_DRIVER or
//   SERVICE_TYPE_ALL
//
// dwServiceState
//   SERVICE_ACTIVE,
//   SERVICE_INACTIVE or
//   SERVICE_STATE_ALL
//
// slServicesList
//   TStrings variable to storage
//
// example call:
//   ServiceGetList('',SERVICE_WIN32,SERVICE_STATE_ALL,ListBox1.Items);
//
function ServiceGetList(sMachine: string; dwServiceType, dwServiceState : DWord;
  slServicesList: TStrings; DisplayName: boolean = true; ServiceName: boolean = false): boolean;
const
  // assume that the total number of services is less than 4096.
  // increase if necessary
  cnMaxServices = 4096;

type
  TSvcA = array[0..cnMaxServices]
          of TEnumServiceStatus;
  PSvcA = ^TSvcA;

var
  // temp. use
  j : integer;

  // service control manager handle
  schm          : SC_Handle;

  // bytes needed for the next buffer, if any
  nBytesNeeded,

  // number of services
  nServices,

  // pointer to the next unread service entry
  nResumeHandle : DWord;

  // service status array
  ssa : PSvcA;
begin
  Result := false;

  // connect to the service
  // control manager
  schm := OpenSCManager(
    PChar(sMachine),
    Nil,
    SC_MANAGER_ALL_ACCESS);

  // if successful...
  if(schm > 0)then
  begin
    nResumeHandle := 0;

    New(ssa);

    EnumServicesStatus(
      schm,
      dwServiceType,
      dwServiceState,
      ssa^[0],
      SizeOf(ssa^),
      nBytesNeeded,
      nServices,
      nResumeHandle );

    //
    // assume that our initial array
    // was large enough to hold all
    // entries. add code to enumerate
    // if necessary.
    //

    for j := 0 to nServices-1 do
    begin
      if DisplayName and ServiceName then
        slServicesList.Add(StrPas(ssa^[j].lpDisplayName) + ', ' + StrPas(ssa^[j].lpServiceName))
      else if ServiceName then
        slServicesList.Add(StrPas(ssa^[j].lpServiceName))
      else
        slServicesList.Add(StrPas(ssa^[j].lpDisplayName));
    end;

    Result := true;

    Dispose(ssa);

    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;
end;

function ServiceIsInstalled(sMachine, sService: string): boolean;
var
  SCManHandle, SvcHandle: THandle;
begin
  SvcHandle:= 0;
  SCManHandle:= OpenSCManager(PChar(sMachine), Nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
    SvcHandle := OpenService(SCManHandle, PChar(sService), SERVICE_QUERY_STATUS);

  result:= SvcHandle > 0;
end;

function GetServiceExecutablePath(strMachine: string; strServiceName: string): String;
var
  hSCManager,hSCService: SC_Handle;
  lpServiceConfig: PQueryServiceConfig;
  nSize, nBytesNeeded: DWord;
  sl: TStringList;
begin
  Result := '';
  hSCManager := OpenSCManager(PChar(strMachine), nil, SC_MANAGER_CONNECT);
  if (hSCManager > 0) then
  begin
    hSCService := OpenService(hSCManager, PChar(strServiceName), SERVICE_QUERY_CONFIG);
    if (hSCService > 0) then
    begin
      QueryServiceConfig(hSCService, nil, 0, nSize);
      lpServiceConfig := AllocMem(nSize);
      try
        if not QueryServiceConfig(
          hSCService, lpServiceConfig, nSize, nBytesNeeded) Then Exit;
          Result := lpServiceConfig^.lpBinaryPathName;
          if (Result <> '') and (Pos('"',Result) = 1) then begin
            { strip out run param stuff and just return executable name with path }
            sl:= TStringList.Create;
            try
              sl.CommaText:= result;
              Result:= SL[0];
            finally
              sl.Free;
            end;
          end;

      finally
        Dispose(lpServiceConfig);
      end;
      CloseServiceHandle(hSCService);
    end;
  end;
end;

function RunAsAdmin(const Path, Params: string): Boolean;
var
  sei: TShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := PChar('runas');
  sei.lpFile := PChar(ExtractFileName(Path));
  sei.lpDirectory := PChar(ExtractFilePath(Path));
  sei.lpParameters := PChar(Params);
  sei.nShow := SW_SHOWNORMAL;
  Result := ShellExecuteEx(@sei);
end;

end.
