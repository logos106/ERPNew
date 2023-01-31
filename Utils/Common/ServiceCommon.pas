unit ServiceCommon;


interface

uses Windows, SyncObjs, WinSvc, Classes, MyAccess, MyClasses,
     MySQLErrors, MySqlVioTcp;


const
  AdvApiDLL      = 'advapi32.dll';
  SERVICE_CONFIG_FAILURE_ACTIONS = 2;
  CRLF_STR       = '{CRLF}';


type

  TChangeServiceConfig2 = function(hService: SC_HANDLE; dwInfoLevel: DWORD; lpInfo: Pointer): BOOL;
  stdcall;

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

implementation

end.
