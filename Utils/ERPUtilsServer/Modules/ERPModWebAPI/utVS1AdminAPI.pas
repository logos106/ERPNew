unit utVS1AdminAPI;

interface

uses
  BusObjVS1_Cloud, Classes, JsonObject,ERPDbComponents, LogThreadBase, LogMessageTypes,
  BusObjBase, VS1_RegonLicense, ModuleFileNameUtils, utServerTask, WebAPILib, SyncObjs, WebAPIThreadObj, utAPIBaseObj;

type

  TVS1AdminAPI = class(TAPIBaseObj)
  private
    procedure VS1SysInfo(aDBConn: TERPConnection; InJson:TJsonObject);
  public
    Constructor Create;Override;
    Destructor Destroy;Override;
    { returns true if request type is handled }
    class function DoCloudRequest(InJson, OutJson: TJsonObject; var OutStream: TStream; DbConn: TERPConnection; aLogger: TLoggerBase = nil; aTaskRecID:Integer =0): boolean;
  end;

  TVS1CloudTaskThread = class(TWebAPIThreadBase)
  private
    fCommand,
    fParams: string;
    TaskRec: TServerTaskRec;
    fconn :TERPConnection;
    AProcessCtr: Integer;

    Procedure VS1_NewRego;
    Function InitConn(aLogger: TLoggerBase): Boolean;
    procedure VS1_Logon;
    procedure VS1_SequenceList;
    procedure VS1_NextTransID;
    procedure VS1_SetCustomize;
    procedure VS1_GetCustomize;
    procedure VS1_SetClosingDates;
    procedure VS1_GetClosingDates;
    procedure VS1_InitNewDatabase;
    procedure VS1_Renew;
    procedure VS1_ChangePassword;
    procedure VS1_AddModules;
    procedure VS1_InvoiceAppt;
    procedure VS1_InvoiceTimesheet;
    procedure VS1_NewUser;
    procedure VS1_NewUser2;
    procedure VS1_ChangeDatabase;
    procedure VS1_DatabaseBackup;   // wang
    procedure VS1_BackupList;       // wang
    procedure VS1_DatabaseRestore;  // wang
    procedure VS1_PNLGetLayout;     // wang
    procedure VS1_PNLMoveAccount;   // wang
    procedure MoveAccount(ASelID, ADestID, ALayoutID: Integer);
    procedure VS1_PNLAddGroup;      // wang
    procedure VS1_PNLDeleteGroup;   // wang
    procedure VS1_PNLRenameGroup;   // wang
    procedure VS1_PNLGetGroups;     // wang
    procedure VS1_GetDataBases;     // Wang
    procedure VS1_SetAccountant;    // Wang

    Function VS1_DbConnectTest: Boolean;
    Procedure InitVS1EmployeeAccess;
    Procedure UpdateVS1CompanyPreference;
    Procedure VS1_RepeatAppointment;
    function CloneTrans(var msg: string; transType: string; transID: Integer; DateDue: TDateTime): Integer;
    Procedure VS1_RepeatTrans;
    Procedure VS1_DeleteRepeated;
    Procedure VS1_DeleteAllAppts;
    procedure VS1_BatchUpdate;
    //Function AddModule(aModulename :String):boolean;
    Procedure VS1_Test;
    Procedure InitVS1Rego(VS1_Rego: TVS1_Rego; Params:TJsonObject);
    Function AddClientModule(aClients: TVS1_Clients; aModuleNAme: String; aParams: TJSONObject): Boolean;
    procedure LogConn;
    procedure TransactionTableObjOnLog(const msg: string;LogType: TLogMessageType);
    //procedure VS1_Dashboard1;
    procedure VS1_Dashboard;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
    function APIPort(params: TJsonObject): Integer;
    procedure DeleteAllApptscallback(const Sender: TBusObj;var Abort: Boolean);
    procedure DeleteRepeatedCallback(const Sender: TBusObj;var Abort: Boolean);

  protected
    procedure Execute; override;
  public
    constructor Create(aCommand: string; aDBConn: TERPConnection; aOnEvent:TEventProc; aParams: string = ''; aLogger: TLoggerBase=nil);
    destructor Destroy; override;
  end;

implementation

uses
  AuthUtilsObj, SysUtils, ERPServerInfoObj, ObjectSerialiser, RandomUtils,
  DateTimeUtils, MyAccess, MySQLUtils, ConfigDbObj, MyDump, AppEnvironment,
  SystemLib, utNewDBUtils, DNMLIB, JsonToDatasetFuncs, DbConst, utVS1Const,
  ActiveX, utTokenList, DbSharedObjectsObj, commonlib, BusObjSales,
  VS1Lib, BusObjRegionalOptions, utCloudconst, utGTConst, TransactionsTable, WebApiConst,
  BusObjUser, BusObjEmployee, BusobjVS1Dashboard, AppEnvironmentVirtual,
  BusObjEmployeeFormAccess, BusObjEmployeePic, BusObjAppointments, tcConst,
  cloudLib, tcDataUtils, PreferenceLib, RepeatDatesLib, dateutils, IntegerListObj, db,
  BusobjProduct, TypInfo, variants, StrUtils, Generics.Collections,
  busobjcompinfo, BusObjTimeSheet, BusObjClient, CommonDbLib, CalcRepeatDates,
  busobjOrders, busobjExpenses, BusobjJournal, BusObjTrans, LogThreadDbLib,
  LogThreadLib;


{ TVS1AdminAPI }
constructor TVS1AdminAPI.Create;
begin
  inherited;
end;

destructor TVS1AdminAPI.Destroy;
begin
  inherited;
end;

class function TVS1AdminAPI.DoCloudRequest(InJson, OutJson: TJsonObject; var OutStream: TStream; DbConn: TERPConnection; aLogger: TLoggerBase = nil; aTaskRecID: Integer = 0): Boolean;
var
  MethodJson: TJsonObject;
  aVS1AdminAPI: TVS1AdminAPI;
  qry: TERPQuery;
  iNumRows: Integer;

  function IsVS1_cloudAuthRequest: Boolean;
  begin
    Result :=
      SameText(InJson.S[TAG_ERPUserName], ERP_CLOUD_ADMIN_USER) and
      SameText(InJson.S[TAG_ERPPassword], ERP_CLOUD_ADMIN_TOKEN);
  end;
begin
{
  ---Vs1_Test
  ---GET
    |----Vs1_Logon
    |----VS1_Cloud_Task
       |----VS1_BatchUpdate
    |----VS1_Dashboard
    |----VS1_SequenceList
    |----VS1_NextTransID
    |----VS1_Customize
    |----VS1_ClosingDates
    |----VS1_SysInfo
    |----VS1_Cloud_Task
       |----VS1_DbConnectTest
    |----VS1_ClosingDates
    |----VS1_PNLGetLayout
    |----VS1_PNLGetGroups
    |----VS1_GetDatabases

  ---POST
    |----VS1_Cloud_Task
       |----VS1_NewUser
       |----VS1_DbConnectTest
       |----VS1_ChangeDatabase
       |----VS1_ReadERPDBInfo
       |----VS1_AddModules
       |----VS1_InvoiceAppt
       |----VS1_Renew
       |----VS1_ChangePassword
       |----VS1_EmployeeAccess
       |----VS1_UpdateCompPref
       |----VS1_RepeatAppointment
       |----VS1_RepeatTrans
       |----VS1_DeleteRepeated
       |----VS1_DeleteAllAppts
       |----VS1_NewRego
       |----VS1_InvoiceTimesheet
       |----VS1_InitNewDatabase
       |----VS1_DatabaseBackup
       |----VS1_BackupList
       |----VS1_DatabaseRestore
       |----VS1_PNLMoveAccount
       |----VS1_PNLAddGroup
       |----VS1_PNLDeleteGroup
       |----VS1_PNLRenameGroup
       |----VS1_Customize
       |----VS1_ClosingDates
}
  Result := False;

  if (InJson.A[TAG_URIParts].Count < 3) then Exit;
  Result :=  SameText(InJson.A[TAG_URIParts][2].AsString, VS1_Cloud_Task) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_Vs1_Logon) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_SequenceList) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_NextTransID) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_Customize) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_ClosingDates) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_PNLGetLayout) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_PNLGetGroups) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_GetDatabases) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_SysInfo) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_Dashboard) or
             SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_Test);
  if not Result then Exit;

  Result := True;

  aVS1AdminAPI := TVS1AdminAPI.Create;
  with aVS1AdminAPI do try
    TaskRecID := aTaskRecID;
    fLogger := aLogger;
    //fOutJson := OutJson;

    {Test}
    if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_Test) then begin
      OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
      OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_Test, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
      While ThreadRunning do;
      OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.AsString;
      Exit;
    end;

    {GET}
    if InJson.S['Command'] = 'GET' then begin
      if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_Vs1_Logon) or
         SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_SysInfo)  then begin
        Result := true;
        if not IsVS1_cloudAuthRequest then begin
          OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
          exit;
        end;
        if not InJson.Exists(TAG_CLOUD_Params) then begin
          OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
          exit;
        end;
      end;

      {Logon}
      if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_Vs1_Logon) then begin
        if not InJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_VS1UserName) then begin
          OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
          Exit;
        end;

        if not InJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_VS1Password) then begin
          OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
          Exit;
        end;

        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_Vs1_Logon, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger ).TaskRec.ID;
        While ThreadRunning do;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.asString;
        Exit;

      {BatchUpdte}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, VS1_Cloud_Task) and SameText(InJson.A[TAG_URIParts][3].AsString, TASK_VS1_BatchUpdate) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_BatchUpdate, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger ).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;
        Exit;

      {VS1 Dashboard}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_Dashboard) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_Dashboard, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {Number Sequence}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_SequenceList) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_SequenceList, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {Next Transaction ID}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_NextTransID) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_NextTransID, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {Customize}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_Customize) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_GetCustomize, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {ClosingDates}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_ClosingDates) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_GetClosingDates, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {PnLGetLayout}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_PnLGetLayout) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_PnLGetLayout, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {PnLGetGroups}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_PNLGetGroups) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_PnLGetGroups, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {GetDatabases}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_GetDatabases) then begin
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_GetDatabases, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;
        Exit;

      {SysInfo - License Check}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, TASK_VS1_SysInfo) then begin
        if not InJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_DatabaseName) then begin
          OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
          exit;
        end;
        if not InJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_ServerName) then begin
          OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
          exit;
        end;
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.S[TAG_ResponseStatus]:= 'OK'; { "OK" }
        VS1SysInfo(DbConn, InJson);
        OutJson.O[TAG_JsonOUT].O[VS1_TAG_ClientLicense].asString := fOutJson.asString;
        Exit;

      {DB Connect Test}
      end else if SameText(InJson.A[TAG_URIParts][2].AsString, VS1_Cloud_Task) and SameText(InJson.O[TAG_CLOUD_Params].S['Name'], TASK_VS1_DbConnectTest) then begin
        InJson.S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
        InJson.S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
        OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_DbConnectTest, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
        While ThreadRunning do ;
        OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        OutJson.S[TAG_ResponseStatus]:= 'OK'; { "OK" }
        OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;
        Exit;
      end;

      Result := False;   // VS1_Cloud_Task/Unknown
      Exit;
    end;

    if InJson.S['Command'] = 'POST' then begin
      Result := False;
{----}if SameText(InJson.A[TAG_URIParts][2].AsString, VS1_Cloud_Task) then begin
        OutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
        try
          if (InJson.A[TAG_URIParts].Count >= 4) then begin
            if SameText(InJson.A[TAG_URIParts][3].AsString, TAG_Method) then begin
              MethodJson := JO(InJson.O[TAG_JsonIN].AsString);
              try
                fiThreadProgresscount := 0;
        {------}if SameText(MethodJson.S['Name'], TASK_VS1_DbConnectTest) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_DbConnectTest, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_ChangeDatabase) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_ChangeDatabase, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_NewUser) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  {New User}
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] := InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] := InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_NewUser, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_SetAccountant) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  {Set Accountant}
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] := InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] := InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_SetAccountant, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_InvoiceTimesheet) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] := InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] := InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_InvoiceTimesheet, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_InvoiceAppt) then begin
                  if not(InJson.Exists(TAG_ERPUserName))  then begin
                    OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  if not(InJson.Exists(TAG_ERPPassword))  then begin
                    OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  if not(MethodJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_AppointIDs)) or
                      (MethodJson.O[TAG_CLOUD_Params].A[VS1_TAG_AppointIDs].count = 0)  then begin
                    OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;

                  Result := True;
                  OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }

                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];

                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_InvoiceAppt, DbConn, aVS1AdminAPI.DoEvent,  MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;
                  Exit;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_AddModules) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  if not(InJson.Exists(TAG_ERPUserName)) Or
                     not(MethodJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_CloudUserName)) then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  if not(InJson.Exists(TAG_ERPPassword)) Or
                     not(MethodJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_CloudPassword)) then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }

                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_AddModules, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

                  Exit;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_ChangePassword) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    exit;
                  end;
                  (*if not( MethodJson.O[TAG_CLOUD_Params].O[VS1_TAG_ERPLoginDetails].Exists(VS1_TAG_VS1UserName)) then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    exit;
                  end;*)
                  if not(MethodJson.O[TAG_CLOUD_Params].O[VS1_TAG_ERPLoginDetails].Exists(VS1_TAG_NewPassword))  then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;

                  OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }

                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[VS1_TAG_VS1UserName] :=   InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[VS1_TAG_VS1Password] :=   InJson.S[TAG_ERPPassword];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=   InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=   InJson.S[TAG_ERPPassword];

                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_ChangePassword, DbConn, aVS1AdminAPI.DoEvent,  MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

                  Exit;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_Renew) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    exit;
                  end;
                  if not(InJson.Exists(TAG_ERPUserName)) Or
                     not(MethodJson.O[TAG_CLOUD_Params].Exists(VS1_TAG_CloudUserName)) then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;
                  if not(InJson.Exists(TAG_ERPPassword))  then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;

                  OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }

                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_Renew, DbConn, aVS1AdminAPI.DoEvent,  MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;
                  Exit;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_EmployeeAccess) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] := InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] := InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_EmployeeAccess, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_UpdateCompPref) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_UpdateCompPref, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_RepeatAppointment) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_RepeatAppointment, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_RepeatTrans) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_RepeatTrans, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_DeleteRepeated) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_DeleteRepeated, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_DeleteAllAppts) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_DeleteAllAppts, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_NewRego) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;

                  {New Rego}
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] := InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] := InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_NewRego, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_InitNewDatabase) then begin
                  Result := True;
                  OutJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_InitNewDatabase, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

                  Exit;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_DatabaseBackup) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;

                  Result := True;
                  OutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_DatabaseBackup, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.asString;
      {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_BackupList) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;

                  Result := True;
                  OutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_BackupList, DbConn, aVS1AdminAPI.DoEvent, InJson.AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.asString;
        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_DatabaseRestore) then begin
                  if not IsVS1_cloudAuthRequest then begin
                    OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Unauthorized" }
                    Exit;
                  end;

                  if not(InJson.Exists(TAG_ERPDatabase)) then begin
                    OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "No parameter" }
                    exit;
                  end;

                  Result := True;
                  OutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_DatabaseRestore, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].asString := fOutJson.asString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_PNLMoveAccount) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_PNLMoveAccount, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_PNLAddGroup) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_PNLAddGroup, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_PNLDeleteGroup) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_PNLDeleteGroup, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_PNLRenameGroup) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_PNLRenameGroup, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_Customize) then begin
                  Result := True;
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPUserName] :=  InJson.S[TAG_ERPUserName];
                  MethodJson.O[TAG_CLOUD_Params].S[TAG_ERPPassword] :=  InJson.S[TAG_ERPPassword];
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_Customize, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;

        {------}end else if SameText(MethodJson.S['Name'], TASK_VS1_ClosingDates) then begin
                  Result := True;
                  OutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                  OutJson.O[TAG_JsonOUT].I[TAG_ServerTaskID] := TVS1CloudTaskThread.Create(TASK_VS1_ClosingDates, DbConn, aVS1AdminAPI.DoEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do ;
                  OutJson.O[TAG_JsonOUT].O[TAG_ProcessLog].AsString := fOutJson.AsString;

        {------}end;
              finally
                MethodJson.Free;
              end;
            end;
          end;
        except
          on e: exception do begin
            raise;
          end;
        end;
  {--}end; {VS1_Cloud_Task}
    end;
  Finally
    Freeandnil(aVS1AdminAPI);
  end;
end;


Procedure TVS1AdminAPI.VS1SysInfo(aDBConn: TERPConnection; InJson:TJsonObject);
var
  aVS1_Modules :TVS1_Modules;
  aVS1_databases :TVS1_databases;
  aVS1_ModuleItem: TJsonObject;
begin
    DoEvent(TAG_ResponseTask     , 'VS1 License Check');

      try
        aVS1_Modules:= TVS1_Modules.Create(nil);
        aVS1_databases:= TVS1_databases.Create(nil);
        try
            aVS1_Modules.connection := TMyDAcDataconnection.Create(aVS1_Modules);
            aVS1_Modules.connection.connection := aDBConn;

            if InJson.O[TAG_CLOUD_Params].Exists('ModuleName') and (trim(InJson.O[TAG_CLOUD_Params].S['ModuleName'])<> '') then
                 aVS1_Modules.LoadSelect('ModuleName =' + quotedstr(trim(InJson.O[TAG_CLOUD_Params].S['ModuleName'])))
            else if InJson.O[TAG_CLOUD_Params].Exists('ModuleID') and (InJson.O[TAG_CLOUD_Params].I['ModuleID']<> 0) then
                 aVS1_Modules.Load(InJson.O[TAG_CLOUD_Params].I['ModuleID'])
            else aVS1_Modules.Load;
            if aVS1_Modules.count =0 then Exit;

            aVS1_databases.connection:= aVS1_Modules.connection;
            aVS1_databases.LoadSelect('DatabaseName =' + Quotedstr(InJson.O[TAG_CLOUD_Params].S[VS1_TAG_DatabaseName])+ ' and '+
                                      'ServerName ='+  Quotedstr(InJson.O[TAG_CLOUD_Params].S[VS1_TAG_ServerName]));

            if aVS1_databases.count <> 1 then begin
              fOutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
              fOutJson.S[TAG_ResponseStatus]:= 'Database Doesn''t Exists';
              fOutJson.S[TAG_ResponseError]:= 'Provided Database / Server combination Doesn''t Exists';
              Exit;
            end;
            if aVS1_databases.VS1_Clients.count <> 1 then begin
              fOutJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Unauthorized" }
              fOutJson.S[TAG_ResponseStatus]:= 'Client Doesn''t Exists';
              fOutJson.S[TAG_ResponseError]:= 'Provided Database / Server  is not Assigned to any Client';
              Exit;
            end;
            aVS1_Modules.First;

            While aVS1_Modules.EOF = False do begin
              if aVS1_Modules.Active then begin
                aVS1_ModuleItem := JO;
                try
                  DatasetToJson(aVS1_Modules.dataset,aVS1_ModuleItem, 'ID,LicenseLevel,IsExtra,Active,RequiredLevel');
                  if aVS1_databases.VS1_Clients.ClientModules.locate('ModuleId',aVS1_Modules.ID, []) then begin
                    DatasetToJson(aVS1_databases.VS1_Clients.ClientModules.dataset,aVS1_ModuleItem, 'ID,ClientId,ClientId,RequiredLevel,ModuleId');
                  end;
                  fOutJson.A['LicenceOptions'].add(aVS1_ModuleItem);
                finally
                  //aVS1_ModuleItem.free;
                end;
              end;
              aVS1_Modules.Next;
            end;
        finally
          freeandnil(aVS1_Modules);
        end;
      Except
        on E:Exception do begin
          DoEvent (TAG_ResponseError     , E.message);
        end;
      end;
end;

{TVS1CloudTaskThread}
procedure TVS1CloudTaskThread.Execute;
begin
  CoInitialize(nil);

  try
    if not InitConn(fLogger) then Terminate;

             if SameText(fCommand, TASK_VS1_Test)                     then begin VS1_Test;
    end else if SameText(fCommand, TASK_Vs1_Logon)                    then begin Vs1_Logon;
    end else if SameText(fCommand, TASK_Vs1_SequenceList)             then begin VS1_SequenceList;
    end else if SameText(fCommand, TASK_Vs1_NextTransID)              then begin VS1_NextTransID;
    end else if SameText(fCommand, TASK_VS1_GetCustomize)             then begin VS1_GetCustomize;
    end else if SameText(fCommand, TASK_VS1_Customize)                then begin VS1_SetCustomize;
    end else if SameText(fCommand, TASK_VS1_GetClosingDates)          then begin VS1_GetClosingDates;
    end else if SameText(fCommand, TASK_VS1_ClosingDates)             then begin VS1_SetClosingDates;
    end else if SameText(fCommand, TASK_VS1_Renew)                    then begin VS1_Renew;
    end else if SameText(fCommand, TASK_VS1_ChangePassword)           then begin VS1_ChangePassword;
    end else if SameText(fCommand, TASK_VS1_NewUser)                  then begin VS1_NewUser2;
    end else if SameText(fCommand, TASK_VS1_SetAccountant)            then begin VS1_SetAccountant;
    end else if SameText(fCommand, TASK_VS1_ChangeDatabase)           then begin VS1_ChangeDatabase;
    end else if SameText(fCommand, TASK_VS1_DbConnectTest)            then begin VS1_DbConnectTest;
    end else if SameText(fCommand, TASK_VS1_AddModules)               then begin VS1_AddModules;
    end else if SameText(fCommand, TASK_VS1_InvoiceAppt)              then begin VS1_InvoiceAppt;
    end else if SameText(fCommand, TASK_VS1_InvoiceTimesheet)         then begin VS1_InvoiceTimesheet;
    end else if SameText(fCommand, TASK_VS1_EmployeeAccess)           then begin InitVS1EmployeeAccess;
    end else if SameText(fCommand, TASK_VS1_UpdateCompPref)           then begin UpdateVS1CompanyPreference;
    end else if SameText(fCommand, TASK_VS1_RepeatAppointment)        then begin VS1_RepeatAppointment;
    end else if SameText(fCommand, TASK_VS1_RepeatTrans)              then begin VS1_RepeatTrans;
    end else if SameText(fCommand, TASK_VS1_DeleteRepeated)           then begin VS1_DeleteRepeated;
    end else if SameText(fCommand, TASK_VS1_DeleteAllAppts)           then begin VS1_DeleteAllAppts;
    end else if SameText(fCommand, TASK_VS1_NewRego)                  then begin VS1_NewRego;
    end else if SameText(fCommand, TASK_VS1_InitNewDatabase)          then begin VS1_InitNewDatabase;
    end else if SameText(fCommand, TASK_VS1_BatchUpdate)              then begin VS1_BatchUpdate;
    end else if SameText(fCommand, TASK_VS1_Dashboard)                then begin VS1_Dashboard;
    end else if SameText(fCommand, TASK_VS1_DatabaseBackup)           then begin VS1_DatabaseBackup;
    end else if SameText(fCommand, TASK_VS1_BackupList)               then begin VS1_BackupList;
    end else if SameText(fCommand, TASK_VS1_DatabaseRestore)          then begin VS1_DatabaseRestore;
    end else if SameText(fCommand, TASK_VS1_PNLGetLayout)             then begin VS1_PNLGetLayout;
    end else if SameText(fCommand, TASK_VS1_PNLMoveAccount)           then begin VS1_PNLMoveAccount;
    end else if SameText(fCommand, TASK_VS1_PNLAddGroup)              then begin VS1_PNLAddGroup;
    end else if SameText(fCommand, TASK_VS1_PNLDeleteGroup)           then begin VS1_PNLDeleteGroup;
    end else if SameText(fCommand, TASK_VS1_PNLRenameGroup)           then begin VS1_PNLRenameGroup;
    end else if SameText(fCommand, TASK_VS1_PNLGetGroups)             then begin VS1_PNLGetGroups;
    end else if SameText(fCommand, TASK_VS1_GetDatabases)             then begin VS1_GetDatabases;
    end;

    if not TaskRec.Complete then begin
      TaskRec.Complete := True;
      TaskRec.Save;
    end;
  finally
    AppEnv.AppDb.Connection.Disconnect;
    CoUninitialize;
  end;

end;

function TVS1CloudTaskThread.InitConn(aLogger: TLoggerBase): Boolean;
var
  Params: TJSONObject;
begin
  Result := False;
  Params := JO(fParams);
  try
    if not(SameText(AppEnv.AppDb.Database, fconn.Database)) or (not(AppEnv.AppDb.Connection.Connected)) then begin
      AppEnv.AppDb.Database := '';
      AppEnv.AppDb.Server := fconn.Server;
      AppEnv.AppDb.Database := fconn.Database;
      try
        AppEnv.AppDb.ConnectUser(Params.S[TAG_ERPUserName], Params.S[TAG_ERPPassword], TLogger(aLogger));
        Result := True;
      except
        on eusr: exception do begin
          if Assigned(fOnEvent) then fOnEvent('Initconn Error', eusr.Message);
          Exit;
        end;
      end;
    end;
  finally
    Params.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_DeleteRepeated;
var
  Params: TJSONObject;
  TransID: Integer;
  TransType: String;
  BusObj: TMSBusObj;
begin
  Params := JO(fParams);
  try
    if not(Params.Exists(VS1_TAG_Repeat_TransID)) or (Params.I[VS1_TAG_Repeat_TransID] = 0) then begin
      fOnEvent('Missing Info', 'Missing Transaction ID to Delete');
      Exit;
    end;

    TransID := Params.I[VS1_TAG_Repeat_TransID];
    TransType := Params.S[VS1_TAG_Repeat_TransType];

    BusObj := nil;
    if SameText(TransType, 'PurchaseOrder') then
      BusObj:= TMSBusObj(TPurchaseOrder.Create(nil))
    else if SameText(TransType, 'Invoice') then
      BusObj := TMSBusObj(TInvoice.Create(nil))
    else if SameText(TransType, 'SalesOrder') then
      BusObj := TMSBusObj(TSalesOrder.Create(nil))
    else if SameText(TransType, 'Quote') then
      BusObj := TMSBusObj(TQuote.Create(nil))
    else if SameText(TransType, 'Cheque') then
      BusObj := TMSBusObj(TCheque.Create(nil))
    else if SameText(TransType, 'Bill') then
      BusObj := TMSBusObj(TBill.Create(nil))
    else if SameText(TransType, 'JournalEntry') then
      BusObj := TMSBusObj(TJournalEntry.Create(nil));

    if not Assigned(BusObj) then begin
      fOnEvent('Wrong Info', 'Wrong transaction type');
      Exit;
    end;

    try
      BusObj.LoadSelect('RepeatedFrom = ' + IntToStr(Params.I[VS1_TAG_Repeat_TransID]));
      if BusObj.Count = 0 then begin
        fOnEvent('Missing record', 'No transactons found for ID ' + IntToStr(Params.I[VS1_TAG_Repeat_TransID]) + ' to Delete');
        Exit;
      end;
        AProcessCtr := 0;
        BusObj.Connection.BeginTransaction;
        try
          BusObj.IterateRecords(DeleteRepeatedCallback);
          BusObj.Connection.CommitTransaction;
        Except
          on E: Exception do begin
            BusObj.Connection.RollbackTransaction;
          end;
        end;
        fOnEvent('Response', IntToStr(AProcessCtr) + ' Transactions Deleted from the group of ID ' + IntToStr(Params.I[VS1_TAG_Repeat_TransID]));
        OnStatus( VS1_HTTP_Success_STRCode, 'OK');
      finally
        FreeAndNil(BusObj);
      end;
  finally
    Params.Free;
  end;
end;

procedure TVS1CloudTaskThread.DeleteRepeatedCallback(const Sender: TBusObj; var Abort: Boolean);
var
  isFiltered: Boolean;
begin
  if (Sender is TTransBase) or (Sender is TJournalEntry) then begin
    if not TTransBase(Sender).Lock then begin

    end;

    TMSBusObj(Sender).Connection.BeginNestedTransaction;
    try
      if (Sender is TTransBase) then begin
        // Delete lines if any
        isFiltered := TTransBase(Sender).Lines.dataset.filtered;
        try
          TTransBase(Sender).Lines.Dataset.Filtered := False;
          TTransBase(Sender).Lines.First;
          while not TTransBase(Sender).Lines.EOF do begin
              if TTransBase(Sender).Lines.Deleted then else begin
                TTransBase(Sender).Lines.Deleted := True;
                TTransBase(Sender).Lines.PostDb;
                TTransBase(Sender).Lines.DoFieldChangewhenDisabled := False;
              end;
              TTransBase(Sender).Lines.Next;
          end;
        finally
          TTransBase(Sender).Lines.Dataset.Filtered := isFiltered;
        end;

        TTransBase(Sender).PostDB;
        if TTransBase(Sender).Save then begin
          TMSBusObj(Sender).Connection.commitnestedTransaction;
          TTransBase(Sender).Deleted := True;
          TTransBase(Sender).PostDB;
          if TTransBase(Sender).Save then begin
            TMSBusObj(Sender).Connection.commitnestedTransaction;
            AProcessCtr := AProcessCtr + 1;
          end;
        end else begin
          TMSBusObj(Sender).Connection.RollbacknestedTransaction;
        end;
      end;
    except
      on E:Exception do begin
        TMSBusObj(Sender).Connection.RollbacknestedTransaction;
      end;
    end;
  end;
end;

procedure TVS1CloudTaskThread.VS1_DeleteAllAppts;
var
  params:TJsonObject;
  SourceApt : TAppointment;
begin
  params := JO(fParams);
  try
    if not(params.Exists(VS1_TAG_AppointID)) or (params.I[VS1_TAG_AppointID] = 0) then begin
      fOnEvent('Missing Info', 'Missing Appointment#Id to Delete');
      Exit;
    end;
      SourceApt := TAppointment.CreateWithNewConn(nil, fconn);
      try
        SourceApt.LoadSelect('((IFNULL(LinkAppointID, 0) <> 0 ' +
                             ' AND LinkAppointID IN (SELECT IF(IFNULL(LinkAppointID, 0) = 0, AppointID, LinkAppointID) FROM tblappointments WHERE AppointID = ' + IntToStr(params.I[VS1_TAG_AppointID]) + ' )  '+
                             ' AND IFNULL(actual_appdate, 0) = 0) '+
                             ' OR (AppointID = ' + IntToStr(params.I[VS1_TAG_AppointID]) + '))' +
                             ' AND cancellation = "F" '+
                             ' AND Active = "T"');
        if SourceApt.Count = 0 then begin
          fOnEvent('Missing record', 'No Appointment not found for ID#' + IntToStr(params.I[VS1_TAG_AppointID]) + ' to Delete');
          Exit;
        end;
        AProcessCtr := 0;
        SourceApt.Connection.BeginTransaction;
        try
          SourceApt.IterateRecords(DeleteAllApptscallback);
          SourceApt.Connection.commitTransaction;
        Except
          on E:Exception do begin
            SourceApt.Connection.RollbackTransaction;
          end;
        end;
        fOnEvent('Response', IntToStr(AProcessCtr) + ' Appointments Deleted from the group of Appointment #' + inttostr(params.I[VS1_TAG_AppointID]));
        OnStatus( VS1_HTTP_Success_STRCode, 'OK');
      finally
        FreeAndNil(SourceApt);
      end;
  finally
    params.Free;
  end;
end;

procedure TVS1CloudTaskThread.DeleteAllApptscallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is  TAppointment then begin
    if not TAppointment(Sender).Lock then begin

    end;
    TAppointment(Sender).Connection.beginNestedTransaction;
    try
        TAppointment(Sender).active := False;
        TAppointment(Sender).PostDB;
        if TAppointment(Sender).save then begin
          TAppointment(Sender).Connection.commitnestedTransaction;
          AProcessCtr := AProcessCtr +1;
        end else begin
          TAppointment(Sender).Connection.RollbacknestedTransaction;
        end;
    Except
      on E:Exception do begin
        TAppointment(Sender).Connection.RollbacknestedTransaction;
      end;
    end;
  end;
end;

procedure TVS1CloudTaskThread.VS1_RepeatAppointment;
var
  dates: TDates;
  params: TJsonObject;
  ctr: Integer;
  SourceApt, RepeatApt: TAppointment;
  IdList: TIntegerList;

  function DoRepeatAppts: Boolean;
  var
    Index: Integer;
    stime, etime: TDateTime;
    fFlag: Boolean;
  begin
    Result := False;
    stime := TimeOf(SourceApt.StartTime);
    etime := TimeOf(SourceApt.EndTime);
    SourceApt.Connection.Begintransaction;
    try
      RepeatApt := TAppointment(SourceApt.CloneBusObj(SourceApt.IDFieldNAme, 0, False));
      if Assigned(RepeatApt) then begin
        RepeatApt.GoogleId      := '';
        RepeatApt.GoogleUpdated := 0;
        RepeatApt.Postdb;
        RepeatApt.EditDB;
        RepeatApt.StartTime         := DateOf(dates[ctr]) + stime;
        RepeatApt.EndTime           := DateOf(dates[ctr]) + etime;
        RepeatApt.AppDate           := Dates[ctr];
        RepeatApt.CreationDate      := Date;
        RepeatApt.UpdateDate        := Date;
        RepeatApt.Cancellation      := False;
        RepeatApt.Reschedulled      := False;
        RepeatApt.Feedback          := False;
        RepeatApt.Converted         := False;
        RepeatApt.Unavailable       := False;
        RepeatApt.LinkAppointID     := SourceApt.ID;
        RepeatApt.IsGroupParent     := False;
        RepeatApt.Actual_Start_Time := '';
        RepeatApt.Actual_End_Time   :='';
        fFlag := RepeatApt.NullWhenDateIs0;
        RepeatApt.NullWhenDateIs0 := True;
        try
          RepeatApt.Actual_AppDate    := 0;
          RepeatApt.Actual_StartTime  := 0;
          RepeatApt.Actual_EndTime    := 0;
        finally
          RepeatApt.NullWhenDateIs0 := fFlag;
        end;

        RepeatApt.SynchWithGoogle := SourceApt.SynchWithGoogle;
        RepeatApt.PostDB;
        if RepeatApt.Save then begin
          IdList.Add(RepeatApt.ID);
          Result := True;
          RepeatApt.Connection.Committransaction;
          fOnEvent('Response', 'Inserted Appointemnt # ' + IntToStr(RepeatApt.ID)+' For '+ formatDateTime(shortdateformat, Dates[ctr]));
        end;
      end;
    finally
      if not result then begin
        RepeatApt.connection.Rollbacktransaction;
      end;
    end;
  end;

begin
  params := JO(fParams);
  try
    if not(params.Exists(VS1_TAG_AppointID)) or (params.I[VS1_TAG_AppointID] = 0) then begin
      fOnEvent('Missing Info', 'Missing Appointment #Id to repeat');
      Exit;
    end;

    if (params.Exists(VS1_TAG_Repeat_Dates)) then begin
      SetLength(dates, 0);
      if params.A[VS1_TAG_Repeat_Dates].Count = 0 then begin
        fOnEvent('Response', 'Selection Doesn''t have any date to Book');
        OnStatus( VS1_HTTP_Success_STRCode, 'OK');
        Exit;
      end;

      for ctr := 0 to params.A[VS1_TAG_Repeat_Dates].Count - 1 do begin
        SetLength(dates, Length(dates) + 1);
        dates[High(Dates)] :=  TJsonObject(Params.A[VS1_TAG_Repeat_Dates].Items[ctr]).DT[VS1_TAG_Dates];
      end;
    end else begin
      if not(params.Exists(VS1_TAG_Repeat_Period)) then begin
        fOnEvent('Missing Info', 'Missing Period - [Repeat Appointment in Days/Weeks/Months]');
        Exit;
      end;

      if not(params.Exists(VS1_TAG_Repeat_BaseDate)) then begin
        fOnEvent('Missing Info', 'Missing Repeat from Date ');
        Exit;
      end;

      if not(params.Exists(VS1_TAG_Repeat_FinalDate)) then begin
        fOnEvent('Missing Info', 'Missing Repeat until Date ');
        Exit;
      end;

      if not(params.Exists(VS1_TAG_Repeat_Saturday))     then params.I[VS1_TAG_Repeat_Saturday]    := 0;
      if not(params.Exists(VS1_TAG_Repeat_Sunday))       then params.I[VS1_TAG_Repeat_Sunday]      := 0;
      if not(params.Exists(VS1_TAG_Repeat_Monday))       then params.I[VS1_TAG_Repeat_Monday]      := 0;
      if not(params.Exists(VS1_TAG_Repeat_Tuesday))      then params.I[VS1_TAG_Repeat_Tuesday]     := 0;
      if not(params.Exists(VS1_TAG_Repeat_Wednesday))    then params.I[VS1_TAG_Repeat_Wednesday]   := 0;
      if not(params.Exists(VS1_TAG_Repeat_thursday))     then params.I[VS1_TAG_Repeat_Thursday]    := 0;
      if not(params.Exists(VS1_TAG_Repeat_Friday))       then params.I[VS1_TAG_Repeat_Friday]      := 0;
      if not(params.Exists(VS1_TAG_Repeat_Holiday))      then params.I[VS1_TAG_Repeat_Holiday]     := 0;
      if not(params.Exists(VS1_TAG_Repeat_Weekday))      then params.I[VS1_TAG_Repeat_Weekday]     := 0;
      if not(params.Exists(VS1_TAG_Repeat_MonthOffset))  then params.I[VS1_TAG_Repeat_MonthOffset] := 0;
      if params.I[VS1_TAG_Repeat_Frequency] = 0 then params.I[VS1_TAG_Repeat_Frequency] := 1;

      DoCalcRepeatDates(params.I[VS1_TAG_Repeat_Frequency],
                        params.I[VS1_TAG_Repeat_Period],
                        params.DT[VS1_TAG_Repeat_BaseDate],
                        params.DT[VS1_TAG_Repeat_FinalDate],
                        params.I[VS1_TAG_Repeat_Saturday],
                        params.I[VS1_TAG_Repeat_Sunday],
                        params.I[VS1_TAG_Repeat_Monday],
                        params.I[VS1_TAG_Repeat_Tuesday],
                        params.I[VS1_TAG_Repeat_Wednesday],
                        params.I[VS1_TAG_Repeat_Thursday],
                        params.I[VS1_TAG_Repeat_Friday],
                        params.I[VS1_TAG_Repeat_Holiday],
                        params.I[VS1_TAG_Repeat_Weekday],
                        params.I[VS1_TAG_Repeat_MonthoffSet],
                        dates);
      if Length(dates) = 0 then begin
        fOnEvent('Response', 'Selection Doesn''t have any date to Book');
        OnStatus( VS1_HTTP_Success_STRCode, 'OK');
        Exit;
      end;
    end;

    SourceApt := TAppointment.CreateWithNewConn(nil, fconn);
    try
      SourceApt.Load(params.I[VS1_TAG_AppointID]);
      if SourceApt.Count = 0 then begin
        fOnEvent('Missing Info', 'appointemnt #' + IntToStr(params.I[VS1_TAG_AppointID]) + ' is missing.');
        Exit;
      end;
      IdList := TIntegerList.Create;
      try
        for ctr := Low(Dates) to High(Dates) do begin
          DoRepeatAppts;
        end;
        if IdList.Count > 0 then begin
          SourceApt.IsGroupParent := True;
          SourceApt.PostDB;
        end;
      finally
        if IdList.count > 0 then
          fOnEvent(TAG_ProcessLog, inttostr(IdList.Count) +' Appointments Created. IDs # ' +IdList.Commatext);
        IdList.Free;
      end;
    finally
      Freeandnil(SourceApt);
    end;

  finally
    params.Free;
  end;

  TaskRec.Complete := True;

  OnStatus(VS1_HTTP_Success_STRCode, 'OK');
end;

function TVS1CloudTaskThread.CloneTrans(var msg: string; transType: string; transID: Integer; dateDue: TDateTime): Integer;
var
  NewConnection: TERPConnection;
  BusObj, NewBusObj: TMSBusObj;

begin
  Result := 0;
  msg := '';
  NewConnection := GetNewMyDacConnection(nil);

  BusObj := nil;
  if SameText(transType, 'PurchaseOrder') then
    BusObj:= TMSBusObj(TPurchaseOrder.Create(nil))
  else if SameText(transType, 'Invoice') then
    BusObj := TMSBusObj(TInvoice.Create(nil))
  else if SameText(transType, 'SalesOrder') then
    BusObj := TMSBusObj(TSalesOrder.Create(nil))
  else if SameText(transType, 'Quote') then
    BusObj := TMSBusObj(TQuote.Create(nil))
  else if SameText(transType, 'Cheque') then
    BusObj := TMSBusObj(TCheque.Create(nil))
  else if SameText(transType, 'Bill') then
    BusObj := TMSBusObj(TBill.Create(nil))
  else if SameText(transType, 'JournalEntry') then
    BusObj := TMSBusObj(TJournalEntry.Create(nil));

  Try
    BusObj.SilentMode := True;
    if NewConnection.Intransaction = False then NewConnection.StartTransaction;
    BusObj.Connection := TMyDacDataConnection.Create(BusObj);
//    if BusObj is TTransBase then
//      TTransBase(BusObj).DoProductallocation := Self.DoProductallocation;

    BusObj.Connection.Connection := NewConnection;
    BusObj.Load(transID);
    if BusObj is TSales then TSales(BusObj).InstantiateAllTrees; // load the trees to copy
    if BusObj.Count = 0 then begin
      msg := 'Original transaction not found.';
      Exit;
    end;

    if (BusObj is TPurchaseOrder) or (BusObj is TReturnAuthority) or (BusObj is TExpenseBase) then
      NewBusObj := TTransBase(BusObj.CopyTrans('OrderDate', VarFromDateTime(dateDue), False, 'PurchaseOrderID'))
    else if (BusObj is TSales) then
      NewBusObj := TTransBase(BusObj.CopyTrans('SaleDate', VarFromDateTime(dateDue), False, 'SaleID'))
    else if BusObj is TJournalEntry then
      NewBusObj := TTransBase(BusObj.CopyTrans('TransactionDate', VarFromDateTime(dateDue), False, 'GJID'));

    if NewBusObj = nil then begin
//    Raise Exception.Create(TransObj.ResultStatus.Messages);
      msg := BusObj.ResultStatus.Messages;
      Exit;
    end;

    if BusObj is TTransBase then begin
      TTransBase(NewBusObj).totalbalance   := TTransBase(NewBusObj).totalamountinc;
      TTransBase(NewBusObj).totalpaid      := 0;
      TTransBase(NewBusObj).isPaid         := False;
      TTransBase(NewBusObj).RepeatedFrom   := TransID;
    end
    else if BusObj is TJournalEntry then
      TJournalEntry(NewBusObj).RepeatedFrom := TransID;

    if BusObj is TPurchaseOrder then begin
      TPurchaseOrder(NewBusObj).SupplierInvoiceNumber := '';
      TPurchaseOrder(NewBusObj).NullWhenDateIs0    := True;
      TPurchaseOrder(NewBusObj).SupplierInvoiceDate:= 0;
      TPurchaseOrder(NewBusObj).DueDate            := 0;
    end else if BusObj is TSales then begin
//      TSales(NewBusObj).SaleDate := TSales(NewBusObj).SaleDate;
      TSales(NewBusObj).Lines.Dataset.First;
      while not TSales(NewBusObj).Lines.Dataset.Eof do begin
        TSales(NewBusObj).Lines.ShipDate := TSales(NewBusObj).SaleDate;
        TSales(NewBusObj).Lines.Dataset.Next;
      end;
      TSales(NewBusObj).Lines.PostDb;

      if NewBusObj is TSalesorder then TSalesorder(NewBusObj).Converted := False;
      if NewBusObj is TQuote      then TQuote(NewBusObj).Converted := False;
      {early payment discount should not be copied across as its only added when the payment is made}
      if TSales(NewBusObj).Lines.Locate('Productname' , EARLY_PAYMENT_DISCOUNT_PRODUCT, []) then begin
        TSales(NewBusObj).Lines.Deleted:= True;
        TSales(NewBusObj).Lines.PostDB;
      end;
    end else if BusObj is TJournalEntry then begin
      TJournalEntry(NewBusObj).TransactionNo := IntToStr(TJournalEntry(NewBusObj).ID);
    end;

//    if NewBusObj is TTransBase then
//      ClientName := TTransBase(NewBusObj).ClientName
//    else
//      ClientName := '';
    NewBusObj.PostDB;
    NewBusObj.Save;
    Result := NewBusObj.ID;
    if NewConnection.Intransaction = True then NewConnection.Commit;
  Finally
    FreeAndNil(BusObj);
    FreeAndNil(NewBusObj);
    FreeAndNil(NewConnection);
  end;
end;

procedure TVS1CloudTaskThread.VS1_RepeatTrans;
var
  dates: TDates;
  params: TJsonObject;
  ctr: Integer;
  IdList: TIntegerList;
  msg: String;
  tID: Integer;
  tType: String;
  newID: Integer;
begin
  params := JO(fParams);
  try
    if not(params.Exists(VS1_TAG_Repeat_TransID)) or (params.I[VS1_TAG_Repeat_TransID] = 0) then begin
      fOnEvent('Missing Info', 'Missing transaction #Id to repeat');
      Exit;
    end;
    tID := params.I[VS1_TAG_Repeat_TransID];

    tType := 'Invoice';
    if params.Exists(VS1_TAG_Repeat_TransType) then
      tType := params.S[VS1_TAG_Repeat_TransType];

    if (params.Exists(VS1_TAG_Repeat_Dates)) then begin
      SetLength(dates, 0);
      if params.A[VS1_TAG_Repeat_Dates].Count = 0 then begin
        fOnEvent('Response', 'Selection Doesn''t have any date to clone');
        OnStatus( VS1_HTTP_Success_STRCode, 'OK');
        Exit;
      end;

      for ctr := 0 to params.A[VS1_TAG_Repeat_Dates].Count - 1 do begin
        SetLength(dates, Length(dates) + 1);
        dates[High(dates)] :=  TJSONObject(Params.A[VS1_TAG_Repeat_Dates].Items[ctr]).DT[VS1_TAG_Dates];
      end;
    end else begin
      if not(params.Exists(VS1_TAG_Repeat_Period)) then begin
        fOnEvent('Missing Info', 'Missing Period - [Repeat Invoice in Days/Weeks/Months]');
        Exit;
      end;

      if not(params.Exists(VS1_TAG_Repeat_BaseDate)) then begin
        fOnEvent('Missing Info', 'Missing Repeat from Date ');
        Exit;
      end;

      if not(params.Exists(VS1_TAG_Repeat_FinalDate)) then begin
        fOnEvent('Missing Info', 'Missing Repeat until Date ');
        Exit;
      end;

      if not(params.Exists(VS1_TAG_Repeat_Saturday))     then params.I[VS1_TAG_Repeat_Saturday]    := 0;
      if not(params.Exists(VS1_TAG_Repeat_Sunday))       then params.I[VS1_TAG_Repeat_Sunday]      := 0;
      if not(params.Exists(VS1_TAG_Repeat_Monday))       then params.I[VS1_TAG_Repeat_Monday]      := 0;
      if not(params.Exists(VS1_TAG_Repeat_Tuesday))      then params.I[VS1_TAG_Repeat_Tuesday]     := 0;
      if not(params.Exists(VS1_TAG_Repeat_Wednesday))    then params.I[VS1_TAG_Repeat_Wednesday]   := 0;
      if not(params.Exists(VS1_TAG_Repeat_thursday))     then params.I[VS1_TAG_Repeat_Thursday]    := 0;
      if not(params.Exists(VS1_TAG_Repeat_Friday))       then params.I[VS1_TAG_Repeat_Friday]      := 0;
      if not(params.Exists(VS1_TAG_Repeat_Holiday))      then params.I[VS1_TAG_Repeat_Holiday]     := 0;
      if not(params.Exists(VS1_TAG_Repeat_Weekday))      then params.I[VS1_TAG_Repeat_Weekday]     := 0;
      if not(params.Exists(VS1_TAG_Repeat_MonthOffset))  then params.I[VS1_TAG_Repeat_MonthOffset] := 0;
      if params.I[VS1_TAG_Repeat_Frequency] = 0 then params.I[VS1_TAG_Repeat_Frequency] := 1;

      DoCalcRepeatDates(params.I[VS1_TAG_Repeat_Frequency],
                        params.I[VS1_TAG_Repeat_Period],
                        params.DT[VS1_TAG_Repeat_BaseDate],
                        params.DT[VS1_TAG_Repeat_FinalDate],
                        params.I[VS1_TAG_Repeat_Saturday],
                        params.I[VS1_TAG_Repeat_Sunday],
                        params.I[VS1_TAG_Repeat_Monday],
                        params.I[VS1_TAG_Repeat_Tuesday],
                        params.I[VS1_TAG_Repeat_Wednesday],
                        params.I[VS1_TAG_Repeat_Thursday],
                        params.I[VS1_TAG_Repeat_Friday],
                        params.I[VS1_TAG_Repeat_Holiday],
                        params.I[VS1_TAG_Repeat_Weekday],
                        params.I[VS1_TAG_Repeat_MonthoffSet],
                        dates);
      if Length(dates) = 0 then begin
        fOnEvent('Response', 'Selection Doesn''t have any date to Book');
        OnStatus( VS1_HTTP_Success_STRCode, 'OK');
        Exit;
      end;
    end;

    IdList := TIntegerList.Create;
    try
      for ctr := Low(dates) to High(dates) do begin
        newID := CloneTrans(msg, tType, tID, Dates[ctr]);
        IdList.Add(newID);
      end;
    finally
      if IdList.count > 0 then
        fOnEvent(TAG_ProcessLog, IntToStr(IdList.Count) + ' ' + tType + ' Created. IDs # ' + IdList.Commatext);
      IdList.Free;
    end;

  finally
    params.Free;
  end;

  TaskRec.Complete := True;

  OnStatus(VS1_HTTP_Success_STRCode, 'OK');
end;

procedure TVS1CloudTaskThread.UpdateVS1CompanyPreference;
var

  cmd :TERPCommand;
  LockMessage:String;
  params:TJsonObject;
  aParam:TJsonObject;
  ctr:Integer;
begin
  params := JO(fParams);
  try
    if not(Params.Exists(VS1_TAG_CompanyPreferenceList))   or ((Params.A[VS1_TAG_CompanyPreferenceList].count =0)) then begin
      fOnEvent('Missing Data For Update', 'Array of ' + VS1_TAG_CompanyPreferenceList +' has 0 items');
      Exit;
    end;
    if not LockPreferenceTable(LockMessage) then begin
      fOnEvent('Lock Error',LockMessage);
      Exit;
    end;
    try
        cmd := DbSharedObj.Getcommand(fconn);
        try

            for ctr := 0 to Params.A[VS1_TAG_CompanyPreferenceList].count-1 do begin
              try
                  cmd.SQL.clear;
                  aParam:= TjsonObject(Params.A[VS1_TAG_CompanyPreferenceList].items[ctr]);

                  if sametext(aParam.S['Name'], 'DefaultServiceProduct') then
                        cmd.SQL.Add('update tblDBPreferences Set FieldValue = ' + quotedstr(Inttostr(TProductSimple.IDToggle(aParam.S['FieldValue'])))+' where Name=' + quotedstr('DefaultServiceProductID')+';')
                  else  cmd.SQL.Add('update tblDBPreferences Set FieldValue = ' + quotedstr(aParam.S['FieldValue'])                                   +' where Name=' + quotedstr(aParam.S['Name'])+';');
                  cmd.Execute;
                  fOnEvent('CompPrefUpdated ' , quotedstr(aParam.S['Name'])+'='+ quotedstr(aParam.S['FieldValue']));
                  Appenv.CompanyPrefs.PopulateMe;
              Except
                on E:Exception do begin
                    fOnEvent('Update Failed' , quotedstr(aParam.S['Name'])+'='+ quotedstr(aParam.S['FieldValue']));
                end;
              end;
            end;
        finally
          DbSharedObj.ReleaseObj(cmd);
        end;
    finally
        UnLockPreferenceTable;
    end;
  finally
    params.Free;
  end;
  TaskRec.Complete := true;
  OnStatus( VS1_HTTP_Success_STRCode,'OK');
end;

procedure TVS1CloudTaskThread.InitVS1EmployeeAccess;
var
  fiEmployeeId: Integer;
  cmd: TERPCommand;
  ctr: Integer;
  aVS1_TAG_VS1EmployeeAccess: TJsonObject;
  Params: TJsonObject;
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, 'VS1 Employee Access Levels', True);
  Params := JO(fParams);
  try
    if Params.Exists(VS1_TAG_VS1EmployeeAccessList) and (Params.A[VS1_TAG_VS1EmployeeAccessList].Count > 0) then begin
      cmd := DbSharedObj.Getcommand(fconn);
      try
        cmd.SQL.clear;
        for ctr := 0 to Params.A[VS1_TAG_VS1EmployeeAccessList].Count - 1 do begin
          aVS1_TAG_VS1EmployeeAccess := Params.A[VS1_TAG_VS1EmployeeAccessList].Items[ctr].asObject;
          if aVS1_TAG_VS1EmployeeAccess.Exists(VS1_TAG_EmployeeId) and
             aVS1_TAG_VS1EmployeeAccess.Exists(VS1_TAG_FormID) and
             aVS1_TAG_VS1EmployeeAccess.Exists(VS1_TAG_Access) and
             (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access] <> 0) then begin


            AddEventdata(fOnEvent, TAG_ResponseTask, 'EmployeeId :' + iif(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId]=0,'All' , IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId])) + ',   ' +
                                                                'FormId :' + iif(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormId]=0,'All' , IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormId]))+ ',   ' +
                                                                ' Access :' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]), true);
            if (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId] <> 0) and (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID] <> 0) then begin
              cmd.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess ' +
                            '(EmployeeId, FormID, Access) ' +
                            'SELECT ' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId]) + ' AS EmployeeId, ' +
                                        IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID]) + ' AS FormID, ' +
                                        IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + ' AS Access ON DUPLICATE KEY UPDATE Access= ' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + '; ' +
                            'UPDATE tblemployeeformsaccess  '+
                                      'SET Access= ' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + ' ' +
                                      'WHERE EmployeeId = ' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId]) + ' ' +
                                      'AND FormID = ' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID]) + ';');

            end else if (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId] <> 0) and (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID] = 0) then begin
                cmd.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess '+
                            '(EmployeeId, FormID, Access) '+
                            'SELECT ' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId]) + ' AS EmployeeId, ' +
                                        'FormID, ' +
                                        IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + ' AS Access '+
                            'FROM tblforms ' +
                            'WHERE (tabgroup = 26 OR formname LIKE "TAccessLevelsGUI" OR IFNULL(BusinessObjectName, "") <> "") AND (NOT(IFNULL(BusinessObjectName,"") LIKE "TVS1_%")) ON DUPLICATE KEY UPDATE Access= '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + '; ' +
                            'UPDATE tblemployeeformsaccess  '+
                                      'SET Access= '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + ' ' +
                                      'WHERE EmployeeId = '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId])+ ' ' +
                                      'AND FormID <> 0;');

            end else if (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId] = 0) and (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID] <> 0 ) then begin
              cmd.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess '+
                          ' (EmployeeId, FormID, Access)  '+
                          ' SELECT EmployeeId AS EmployeeId, ' +
                                      IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID]) +' , '+
                                      IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) +' AS Access  '+
                          ' FROM tblemployees WHERE NOT(firstname = ' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERFirstName) + ' AND LastName = ' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERLastName) + ') ' +
                                             ' and  NOT(firstname = ' + QuotedStr(ERP_VS1CLOUD_ADMIN_USERFirstName) + ' AND LastName = ' + QuotedStr(ERP_VS1CLOUD_ADMIN_USERLastName) + ') ' +
                                             ' ON DUPLICATE KEY update Access= '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + '; ' +
                          ' UPDATE tblemployeeformsaccess  '+
                                    'SET Access= '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + ' ' +
                                    'WHERE EmployeeId <> 0 ' + ' ' +
                                    'AND FormID = '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID]) +';');

            end else if (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_EmployeeId] = 0) and (aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_FormID] = 0) then begin
              cmd.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess ' +
                          '(EmployeeId, FormID, Access) ' +
                          'SELECT E.EmployeeId AS EmployeeId, ' +
                                   'F.FormId , '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) +' AS Access  '+
                          'FROM tblemployees E, tblforms F ' +
                          'WHERE NOT(E.firstname = ' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERFirstName) + ' AND E.Lastname = ' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERLastName) + ')  ' +
                                   'AND NOT(E.firstname = ' + QuotedStr(ERP_VS1CLOUD_ADMIN_USERFirstName)+' AND E.Lastname = ' + QuotedStr(ERP_VS1CLOUD_ADMIN_USERLastName) + ') ' +
                                   'AND ((tabgroup = 26 OR formname LIKE "TAccessLevelsGUI" OR IFNULL(BusinessObjectName, "") <> "") AND (NOT(IFNULL(BusinessObjectName,"") LIKE "TVS1_%"))) ' +
                                   'ORDER BY EmployeeId, FormID ON DUPLICATE KEY UPDATE Access= '+ IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) +'; '+
                          ' UPDATE tblemployeeformsaccess  '+
                                   'SET Access = ' + IntToStr(aVS1_TAG_VS1EmployeeAccess.I[VS1_TAG_Access]) + ' ' +
                                   'WHERE EmployeeId <> 0 and FormID <> 0;');
            end;
          end;
        end;

        cmd.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess '+
                    '(EmployeeId, FormID, Access)  '+
                    'SELECT E.EmployeeId AS EmployeeId, ' +
                             'F.formId, ' +
                             '6 AS Access ' +
                    'FROM tblemployees E , tblforms F '+
                    'WHERE NOT(E.FirstName = ' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERFirstName) + ' AND E.LastName = ' + QuotedStr(ERP_VS1CLOUD_DEFAULT_USERLastName) + ') '  +
                           'AND  NOT(E.firstname = ' +QuotedStr(ERP_VS1CLOUD_ADMIN_USERFirstName)+' AND E.Lastname = ' + QuotedStr(ERP_VS1CLOUD_ADMIN_USERLastName) + ') ' +
                           'AND (((IFNULL(F.BusinessObjectName, "") LIKE "TVS1_%"))) '+
                           'ORDER BY employeeid, formid ON DUPLICATE KEY UPDATE Access = 6 ; ');

        cmd.Execute;
        TaskRec.Complete := True;
        OnStatus( VS1_HTTP_Success_STRCode, 'OK');
      finally
        DbSharedObj.ReleaseObj(cmd);
      end;
    end;
  finally
    Params.Free;
  end;
end;

procedure TVS1CloudTaskThread.InitVS1Rego(VS1_Rego: TVS1_Rego;  Params: TJsonObject);
var
  ctr:Integer;
begin
  VS1_Rego.RegisterErr              := '';
  VS1_Rego.ClientName               := Params.S[VS1_TAG_ClientName];
  VS1_Rego.CloudUserName            := Params.S[VS1_TAG_CloudUserName];
  VS1_Rego.PhoneNumber              := Params.S[VS1_TAG_PhoneNumber];
  VS1_Rego.Sex                      := Params.S[VS1_TAG_Sex];
  VS1_Rego.datestarted              := Params.DT[VS1_TAG_datestarted];
  VS1_Rego.DOB                      := Params.DT[VS1_TAG_DOB];
  VS1_Rego.CloudPassword            := Params.S[VS1_TAG_CloudPassword];
  VS1_Rego.CloudSampleDBUserName    := Params.S[VS1_TAG_CloudSampleDBUserName];
  VS1_Rego.CloudSampleDBPassword    := Params.S[VS1_TAG_CloudSampleDBPassword];
  VS1_Rego.FirstName                := Params.S[VS1_TAG_FirstName];
  VS1_Rego.LastName                 := Params.S[VS1_TAG_LastName];
  VS1_Rego.RegionName               := Params.S[VS1_TAG_RegionName];
  VS1_Rego.CreditCardType           := Params.S[VS1_TAG_CreditCardType];
  VS1_Rego.CreditCardCardHolderName := Params.S[VS1_TAG_CreditCardCardHolderName];
  VS1_Rego.CreditCardNumber         := Params.S[VS1_TAG_CreditCardNumber];
  VS1_Rego.CreditCardNotes          := Params.S[VS1_TAG_CreditCardNotes];
  VS1_Rego.CreditCardCVC            := Params.S[VS1_TAG_CreditCardCVC];
  VS1_Rego.CreditCardExpirymonth    := Params.I[VS1_TAG_CreditCardExpirymonth];
  VS1_Rego.CreditCardExpiryYear     := Params.I[VS1_TAG_CreditCardExpiryYear];
  VS1_Rego.Paymentamount            := Params.F[VS1_TAG_Paymentamount];
  VS1_Rego.Price                    := Params.F[VS1_TAG_Price];
  VS1_Rego.DiscountedPrice          := Params.F[VS1_TAG_DiscountedPrice];
  VS1_Rego.DiscountAmt              := Params.F[VS1_TAG_DiscountedAmt];
  VS1_Rego.RenewPrice               := Params.F[VS1_TAG_Renew_Price];
  VS1_Rego.RenewDiscountedPrice     := Params.F[VS1_TAG_Renew_DiscountedPrice];
  VS1_Rego.RenewDiscountAmt         := Params.F[VS1_TAG_Renew_DiscountedAmt];
  VS1_Rego.DiscountDesc             := Params.S[VS1_TAG_DiscountDesc];
  VS1_Rego.RenewDiscountDesc        := Params.S[VS1_TAG_Renew_DiscountDesc];
  VS1_Rego.PayMethod                := Params.S[VS1_TAG_PayMethod];
  VS1_Rego.LicenseRenewDuration     := Params.I[VS1_TAG_LicenseRenewDuration];
  VS1_Rego.LicenseRenewDurationType := Params.S[VS1_TAG_LicenseRenewDurationType];
  VS1_Rego.LicenseExtensionDesc     := Params.S[VS1_TAG_LicenseExtensionDesc];

  if Params.Exists(VS1_TAG_DatabaseName) then VS1_Rego.DatabaseName := Params.S[VS1_TAG_DatabaseName] else VS1_Rego.DatabaseName := '';

  if Params.Exists(VS1_TAG_LicenseExtensionTo) then VS1_Rego.LicenseExtensionTo := Params.DT[VS1_TAG_LicenseExtensionTo] else VS1_Rego.LicenseExtensionTo := 0;
  if Params.Exists(VS1_TAG_AdjustmentExtension) then VS1_Rego.AdjustmentExtension := Params.B[VS1_TAG_AdjustmentExtension] else VS1_Rego.AdjustmentExtension := False;
  if Params.Exists(VS1_TAG_LicenseLevel)      then VS1_Rego.LicenseLevel      := Params.I[VS1_TAG_LicenseLevel];
  if Params.Exists(VS1_TAG_LicenseLevelDesc)  then VS1_Rego.LicenseLevelDesc  := Params.S[VS1_TAG_LicenseLevelDesc];

  VS1_Rego.InitVS1_RegoModules(Params);

  if Params.Exists('CreateNewDB') then
    VS1_Rego.CreateNewDB := Params.S['CreateNewDB'];

  if Params.Exists(GT_TAG_StSDefaults)  then begin
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSPackageTagProduct) then VS1_Rego.StSPackageTagProduct := Params.O[GT_TAG_StSDefaults].S[GT_TAG_StSPackageTagProduct];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSPlantTagProduct  ) then VS1_Rego.StSPlantTagProduct   := Params.O[GT_TAG_StSDefaults].S[GT_TAG_StSPlantTagProduct];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSSupplier         ) then VS1_Rego.StSSupplier          := Params.O[GT_TAG_StSDefaults].S[GT_TAG_StSSupplier];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSStockAccount     ) then VS1_Rego.StSStockAccount      := Params.O[GT_TAG_StSDefaults].S[GT_TAG_StSStockAccount];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSDefaultClass     ) then VS1_Rego.StSDefaultClass      := Params.O[GT_TAG_StSDefaults].S[GT_TAG_StSDefaultClass];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSDefaultWeightUOM ) then VS1_Rego.StSDefaultWeightUOM  := Params.O[GT_TAG_StSDefaults].S[GT_TAG_StSDefaultWeightUOM];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSUsesBins         ) then VS1_Rego.StSUsesBins          := Params.O[GT_TAG_StSDefaults].B[GT_TAG_StSUsesBins];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSSimpleMode       ) then VS1_Rego.StSSimpleMode        := Params.O[GT_TAG_StSDefaults].B[GT_TAG_StSSimpleMode];
    if Params.O[GT_TAG_StSDefaults].Exists(GT_TAG_StSInitWithDefaults ) then VS1_Rego.StSInitWithDefaults  := Params.O[GT_TAG_StSDefaults].B[GT_TAG_StSInitWithDefaults];
  end;
end;

constructor TVS1CloudTaskThread.Create(aCommand: string; aDBConn: TERPConnection; aOnEvent:TEventProc; aParams: string = ''; aLogger: TLoggerBase = nil);
begin
  inherited Create(aLogger, False);
  fCommand := aCommand;
  fConn := aDBConn;
  fParams := aParams;
  TaskRec := TServerTaskRec.New(fCommand, fConn.Server);
  TaskRec.TaskStatus := 'Unknown';
  TaskRec.Save;
  FreeOnTerminate := True;
  fOnEvent:= aOnEvent;
end;

destructor TVS1CloudTaskThread.Destroy;
begin
  if Assigned(fOnEvent) then fOnEvent('ThreadEvent', 'Oncomplete');
  TaskRec.Free;
  inherited;
end;

Procedure TVS1CloudTaskThread.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, Sender.classname + '->' + EventType + ':' + value, True);
end;

procedure TVS1CloudTaskThread.VS1_InvoiceTimesheet;
var
  Params: TJsonObject;
  Invoice: TInvoice;
  ClientID: Integer;
  ClassID: Integer;
  EmployeeID: Integer;
  Timesheets: TObjectList<TTimesheet>;
  ctr: Integer;
  InvIds: TJsonObject;
  InvErr: TJsonObject;
  Count: Integer;

  procedure MakeInvoice;
  begin
    if (Invoice = nil) then begin
      Invoice := TInvoice.Create(nil);
      Invoice.connection := TMyDAcDataconnection.Create(Invoice);
      Invoice.connection.connection := fConn;
      Invoice.BusObjEvent := DoBusinessObjectEvent;
      Invoice.Load(0);
      Invoice.SilentMode := true;
      Invoice.New;
      Invoice.GLAccountId      := AppEnv.CompanyPrefs.DefaultSalesAccount;
      Invoice.InvoiceToDesc    := GetShippingAddress(ClientID);
      Invoice.ShipToDesc       := GetPhysicalAddress(ClientID);
      Invoice.SaleDate         := Now;
      Invoice.SaleClassId      := ClassID;
      Invoice.ClientID         := ClientID;
      Invoice.CustomerName     := TCustomer.IDToggle(ClientID, fConn);
      Invoice.PostDb;
      Invoice.GlobalRef        := AppEnv.Branch.SiteCode + IntToStr(Invoice.ID);
      Invoice.OriginalDocNumber:= Invoice.GlobalRef;
      Invoice.Deleted          := False;
      Invoice.DocNumber        := IntToStr(Invoice.ID);
      Invoice.EmployeeId       := EmployeeID;
    end;
  end;

  procedure Timesheet2Inv(ATimesheeID: Integer);
  var
    Timesheet: TTimesheet;
    JObj: TJSONObject;
  begin
      Timesheet := TTimesheet.Create(nil);
      try
        //Timesheets.Add(Timesheet);

        Timesheet.connection := TMyDAcDataconnection.Create(Timesheet);
        Timesheet.connection.connection := fConn;
        Timesheet.SilentMode := true;
        Timesheet.BusObjEvent := DoBusinessObjectEvent;
        Timesheet.LoadSelect('T.ID=' + IntToStr(ATimesheeID));
        if Timesheet.Count = 0 then begin
          OnStatus(VS1_HTTP_Failed_STRCode, 'Missing Timesheet for ID #' + IntToStr(ATimesheeID));
          Exit;
        end;

        try
          ClassID := Timesheet.TimeSheetClassID;
          ClientID := Timesheet.Customer.ID;
          EmployeeID := Timesheet.EmployeeID;
          MakeInvoice;
          Timesheet.Invoice(Invoice, ClassID);
          JObj := jo;
          JObj.I[VS1_TAG_InvoiceID] := Invoice.ID;
          JObj.I[VS1_TAG_TimesheetID] := Timesheet.id;
          InvIds.A[VS1_TAG_InvoiceIDs].Add(JObj);
        Except
          on E:Exception do begin
            JObj := JO;
            JObj.I[VS1_TAG_TimesheetID] := Timesheet.id;
            JObj.S[VS1_TAG_Msg] := 'Exception ' + E.message;
            InvErr.A[VS1_TAG_Msgs].Add(JObj);
          end;
        end;
      finally
        Timesheet.Free;
      end;
  end;

  function ResultMessages :String;
  var
    ctr:Integer;
    fs:String;
  begin
    Result := '';
    if InvIds.Exists(VS1_TAG_InvoiceIDs) and (InvIds.A[VS1_TAG_InvoiceIDs].Count > 0) then begin
      for ctr := 0 to InvIds.A[VS1_TAG_InvoiceIDs].Count-1 do begin
        fs:= 'Invoice #' + inttostr(TJsonObject(InvIds.A[VS1_TAG_InvoiceIDs].Items[ctr]).I[VS1_TAG_InvoiceID]) +
                ' Created for timesheet #' + inttostr(TJsonObject(InvIds.A[VS1_TAG_InvoiceIDs].Items[ctr]).I[VS1_TAG_TimesheetID]);
        Result := trim(Result + NL + fs);
        OnStatus(VS1_HTTP_Success_STRCode, fs);
      end;
    end;

    if InvErr.Exists(VS1_TAG_Msgs) and (InvErr.A[VS1_TAG_Msgs].Count > 0) then begin
      for ctr := 0 to InvErr.A[VS1_TAG_Msgs].Count - 1 do begin
        fs:= 'Invoicing the timesheet ' + inttostr(TJsonObject(InvErr.A[VS1_TAG_Msgs].Items[ctr]).I[VS1_TAG_TimesheetID]) +
              ' Failed : ' + TJsonObject(InvErr.A[VS1_TAG_Msgs].Items[ctr]).S[VS1_TAG_Msg];
        Result := trim(Result + NL + fs);
        OnStatus(VS1_HTTP_Failed_STRCode ,  fs);
      end;
    end;

    if Result = '' then begin
      Result := 'No timesheet found';
      OnStatus(VS1_HTTP_Failed_STRCode ,  Result);
    end;

  end;

begin
  AddEventdata(fOnEvent, TAG_ResponseTask, 'Invoicing Timesheet', true);

  Params := JO(fParams);
  try
    InvIds := JO;
    InvErr := JO;
    try
      if Params.Exists(VS1_TAG_TimesheetIDs) and (Params.A[VS1_TAG_TimesheetIDs].Count <> 0) then begin
        Invoice := nil;
        //Timesheets := TObjectList<TTimesheet>.Create;
        try
          Count := Params.A[VS1_TAG_TimesheetIDs].Count - 1;
          for ctr := 0 to Count do begin
            Timesheet2Inv(Params.A[VS1_TAG_TimesheetIDs].Items[ctr].AsInteger);
          end;

          if (Invoice <> nil) then
            Invoice.Save;
        finally
          //Timesheets.Free;
          if Invoice <> nil then Invoice.Free;
        end;
      end;
    finally
      OnStatus(VS1_HTTP_Success_STRCode, ResultMessages);
      InvIds.Free;
      InvErr.Free;
    end;
  finally
    Params.Free;
  end;

  Terminate;
end;

Procedure TVS1CloudTaskThread.VS1_InvoiceAppt;
type
  TInvoice = BusObjSales.TInvoice;
var
  params: TJsonObject;
  // iInvoiceID: Integer;
  Invoice: TInvoice;
  Appts: TObjectList<TAppointment>;
  ctr: Integer;
  InvIds: TJSONObject;
  InvErr: TJSONObject;

  Procedure MakeApptInv(aApptID: Integer);
  var
    Appt: TAppointment;
    j: TJsonObject;
  begin
    Appt := TAppointment.Create(nil);
    try
      Appts.Add(Appt);

      Appt.Connection := TMyDAcDataconnection.Create(Appt);
      Appt.Connection.Connection := fConn;
      Appt.SilentMode := True;
      Appt.BusObjEvent := DoBusinessObjectEvent;
      Appt.Load(aApptID);
      if Appt.Count = 0 then begin
        OnStatus(VS1_HTTP_Failed_STRCode, 'Missing Appointment for ID #' + IntToStr(params.I[VS1_TAG_AppointID]));
        Exit;
      end;

      try
        if Appt.ConvertToInvoice(Invoice) then begin
          //OnStatus( VS1_HTTP_Success_STRCode,'Invoice # '+ inttostr(iInvoiceID)+' Created for Appt #' + inttostr(appt.id)+'.','OK');
          j := JO;
          j.I[VS1_TAG_InvoiceID] := Invoice.ID;
          j.I[VS1_TAG_AppointID] := Appt.id;
          InvIds.A[VS1_TAG_InvoiceIDs].Add(j);
        end else begin
          j := JO;
          j.I[VS1_TAG_AppointID] := Appt.id;
          j.S[VS1_TAG_Msg] := Appt.ResultStatus.GetFirstFatalStatusItem.Message;
          InvErr.A[VS1_TAG_Msgs].Add(j);
          //OnStatus(VS1_HTTP_Failed_STRCode,'Invoicing the appointment failed. ' +  Appt.ResultStatus.GetFirstFatalStatusItem.Message );
        end;
      Except
        on E:Exception do begin
          //AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Exception '+E.message, true);
          j := JO;
          j.I[VS1_TAG_AppointID] := Appt.id;
          j.S[VS1_TAG_Msg] := 'Exception ' + E.message;
          InvErr.A[VS1_TAG_Msgs].Add(j);
        end;
      end;
    except
      // Freeandnil(Appt);
    end;
  end;

  Function VS1_InvoiceAppt_Messages :String;
  var
    ctr:Integer;
    fs:String;
  begin
    Result := '';
    if  InvIds.Exists(VS1_TAG_InvoiceIDs) and (InvIds.A[VS1_TAG_InvoiceIDs].Count > 0) then begin
      for ctr := 0 to InvIds.A[VS1_TAG_InvoiceIDs].Count - 1 do begin
        fs:= 'Invoice # '+ inttostr(TJsonObject(InvIds.A[VS1_TAG_InvoiceIDs].Items[ctr]).I[VS1_TAG_InvoiceID]) +
                                ' Created for Appt #' + inttostr(TJsonObject(InvIds.A[VS1_TAG_InvoiceIDs].Items[ctr]).I[VS1_TAG_AppointID]);
        Result := trim(Result + NL + fs);
        OnStatus(VS1_HTTP_Success_STRCode ,  fs);
      end;
    end;

    if  InvErr.Exists(VS1_TAG_Msgs) and (InvErr.A[VS1_TAG_Msgs].Count>0 ) then begin
      for ctr:= 0 to InvErr.A[VS1_TAG_Msgs].Count-1 do begin
        fs:= 'Invoicing the appointment  '+ inttostr(TJsonObject(InvErr.A[VS1_TAG_Msgs].Items[ctr]).I[VS1_TAG_AppointID]) +
                                ' Failed : ' + TJsonObject(InvErr.A[VS1_TAG_Msgs].Items[ctr]).S[VS1_TAG_Msg];
        Result := trim(Result + NL + fs);
        OnStatus(VS1_HTTP_Failed_STRCode ,  fs);
      end;
    end;
    if Result = '' then begin
      Result := 'No  Appointment found';
      OnStatus(VS1_HTTP_Failed_STRCode ,  Result);
    end;

  end;
begin
  // **FIX** Greg
  AddEventdata(fOnEvent, TAG_ResponseTask, 'Invoicing Appointment', True);
  params := JO(fParams);
  try
    InvIds := JO;
    InvErr := JO;
    try
      if params.Exists(VS1_TAG_AppointIDs) and (params.A[VS1_TAG_AppointIDs].Count <> 0) then begin
        Invoice := nil;
        Appts := TObjectList<TAppointment>.Create;
        try
          for ctr := 0 to params.A[VS1_TAG_AppointIDs].Count - 1 do begin
            MakeApptInv(TJsonObject(params.A[VS1_TAG_AppointIDs].Items[ctr]).I[VS1_TAG_AppointID]);
          end;

          if (Invoice <> nil) then
            Invoice.Save;
        finally
          Appts.Free;
          Invoice.Free;
        end;
      end;
    finally
      OnStatus(VS1_HTTP_Success_STRCode, 'OK ' + VS1_InvoiceAppt_Messages);
    end;
  finally
    params.Free;
  end;

  Terminate;
end;

Procedure TVS1CloudTaskThread.VS1_AddModules;
var
  Params: TJsonObject;
  VS1_Rego :TVS1_Rego;
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, 'Adding Extra Modules', True);
  Params := JO(fParams);
  try
    VS1_Rego := TVS1_Rego.Create(nil, fconn);
    try
      InitVS1Rego(VS1_Rego, Params);
      VS1_Rego.VS1_AddModules(fOnEvent, fLogger);
      Terminate;
    finally
      FreeandNil(VS1_Rego);
    end;
  finally
    Params.Free;
  end;
end;

function TVS1CloudTaskThread.AddClientModule(aClients: TVS1_Clients; aModuleName: String; aParams: TJSONObject) : Boolean;
var
  fModule: TVS1_Modules;
  fInvoiceID: Integer;
  fCustpaymentID: Integer;
  fCustPrepaymentID: Integer;
  fClientModule: TVS1_ClientModules;

  function MakeInvoice(aDatefrom: TDateTime): Integer;
  var
    fMsg: String;
  begin
    Result := VS1Lib.Makeinvoice(aClients.Connection, fClientModule.DiscountedPrice, aClients,
                                 'License from ' + QuotedStr(FormatDatetime(ShortDateFormat, aDatefrom)) + ' to ' + QuotedStr(formatdatetime(shortdateformat, aClients.LicenseUntil)),
                                 fClientModule.ModuleId, fClientModule.ID, Date, fMsg, fOnEvent, nil);
  end;

  function MakePayment:Integer;
  var
    fMsg: String;
  begin
    Result := VS1Lib.MakePayment(aClients.Connection, aClients, fInvoiceID, fClientModule.DiscountedPrice, aParams.S[VS1_TAG_PayMethod], fMsg, fOnEvent, fCustpaymentID, fCustPrepaymentID);
  end;

begin
  Result := False;

  {adding user, if number of users are less than the users included in the license }
  (* if sametext(  aModuleName ,VS1_MODULE_Add_Extra_User) then
    if aVS1_Clients.ClientUsers.count <  aVS1_Clients.VS1_licenselevels.UsersIncluded then begin
      Result := True;
      Exit;
    end;*)

  fModule := TVS1_Modules.Create(aClients);
  fModule.Connection := aClients.Connection;
  fModule.LoadSelect('ModuleName=' + QuotedStr(aModuleName));
  try
    if fModule.Count = 0 then begin
      {this shouldn't happen , but just in case}
      OnStatus(VS1_HTTP_Failed_STRCode, 'Missing Module', 'Missing Module in the VS1 server. Please Contact VS1 Admin - ' + VS1_Admin_Email);
      Exit;
    end;

    if SameText(aModuleName, VS1_MODULE_Add_Extra_User) and (aClients.ClientUsers.count >= aClients.VS1_licenselevels.UsersIncluded) then
      if not aParams.Exists(VS1_TAG_PayMethod) or not aParams.Exists(VS1_TAG_Paymentamount) then begin
        OnStatus(VS1_HTTP_Failed_STRCode,'Missing Payment Information', aClients.VS1_licenselevels.Description + ' has ' + IntToStr(aClients.VS1_licenselevels.UsersIncluded) + ' Users Included ' +
                                                    'and Already has ' + IntToStr(aClients.ClientUsers.Count) + ' Users.'+
                                                    'Required Payment.');
        Exit;
      end;

      fClientModule := aClients.ClientModules;
      try
        fClientModule.New;
        fClientModule.LicenseLevel   := aClients.LicenseLevel;
        fClientModule.ModuleId := fModule.ID;
        fClientModule.LicenseFrom := Date;
        fClientModule.LicenseUntil := aClients.LicenseUntil;
        fClientModule.LicenseRenewDurationType := aClients.LicenseRenewDurationType;
        fClientModule.LicenseRenewDuration    := aClients.LicenseRenewDuration;
        fClientModule.PostDB;

        if SameText(aModuleName, VS1_MODULE_Add_Extra_User) and (aClients.ClientUsers.Count < aClients.VS1_licenselevels.UsersIncluded) then begin
          fClientModule.Quantity            := 0;
          fClientModule.Price               := 0;
          fClientModule.DiscountedPrice     := 0;
          fClientModule.DiscountAmt         := 0;
          fClientModule.RenewPrice          := 0;
          fClientModule.RenewDiscountedPrice:= 0;
          fClientModule.RenewDiscountAmt    := 0;
          fClientModule.DiscountDesc        := 'Free User';
          fClientModule.RenewDiscountDesc   := 'Free User';
        end else begin
          fClientModule.Quantity            := aParams.I[VS1_TAG_ModuleQuantity           ];
          fClientModule.Price               := aParams.F[VS1_TAG_Price                    ];
          fClientModule.DiscountedPrice     := aParams.F[VS1_TAG_DiscountedPrice          ];
          fClientModule.DiscountAmt         := aParams.F[VS1_TAG_DiscountedAmt            ];
          fClientModule.RenewPrice          := aParams.F[VS1_TAG_Renew_Price              ];
          fClientModule.RenewDiscountedPrice:= aParams.F[VS1_TAG_Renew_DiscountedPrice    ];
          fClientModule.RenewDiscountAmt    := aParams.F[VS1_TAG_Renew_DiscountedAmt      ];
          fClientModule.DiscountDesc        := aParams.S[VS1_TAG_DiscountDesc             ];
          fClientModule.RenewDiscountDesc   := aParams.S[VS1_TAG_Renew_DiscountDesc       ];
        end;

        //aVS1_ClientModule.CalcPrice;
        fClientModule.PostDB;

        fInvoiceID := 0;
        fCustpaymentID := 0;
        fInvoiceID := MakeInvoice(Date);
        if (fInvoiceID <> 0) and (fClientModule.DiscountedPrice<>0)  then fCustpaymentID := MakePayment;
        if (fInvoiceID <> 0) and ((fCustpaymentID <> 0) or (fClientModule.DiscountedPrice = 0)) then begin
          fClientModule.LicenseFrom := date;
          fClientModule.LicenseUntil := aClients.LicenseUntil;
          fClientModule.PostDB;
        end;
        Result := True;
     finally
      fClientModule := nil;
     end;
  finally
    Freeandnil(fModule);
  end;
end;

function TVS1CloudTaskThread.VS1_DbConnectTest : Boolean;
var
  params : TJsonObject;
  fsURL : string;
  JsResultStr : string;

  procedure DoGetDBDetails;
  begin
    AddEventdata(fOnEvent, VS1_TAG_ERPVersion, Appenv.AppDb.TableVersion, true);
    AddEventdata(fOnEvent, VS1_TAG_ERPVersion, Appenv.AppDb.TableVersion, true);
  end;
begin
    Result := False;
  Log('====================================================',ltDebug);
  Log('VS1_DbConnectTest',ltDebug);
  Log(fParams, ltdetail);
  Log('====================================================',ltDebug);

    AddEventdata(fOnEvent, TAG_ResponseTask, 'VS1 DB connect Test');
    params := JO(fParams);
    try
      if  (Params.Exists(VS1_TAG_ServerName   )) and
          (Params.Exists(VS1_TAG_DatabaseName )) and
          (Params.Exists(VS1_TAG_VS1UserName  )) and
          (Params.Exists(VS1_TAG_VS1Password  )) and
          (Params.Exists(VS1_TAG_HTTPS        )) and
          (Params.Exists(VS1_TAG_APIPort      )) and
          (Trim(Params.S[VS1_TAG_ServerName   ])<>'') and
          (Trim(Params.S[VS1_TAG_DatabaseName ])<>'') and
          (Trim(Params.S[VS1_TAG_VS1UserName  ])<>'') and
          (Trim(Params.S[VS1_TAG_VS1Password  ])<>'') and
          (APIPort(Params)<>0) then begin
            if sametext(Trim(Params.S[VS1_TAG_ServerName]), fconn.Server) then begin
              AddEventdata(fOnEvent, 'Result', 'DB Connect Test Error Details:' +JsResultStr+'.  It is not possible to Test Connect to a Database on the Same Server', true);
              OnStatus(VS1_HTTP_Failed_STRCode,'Error Connecting to '+ Params.S[VS1_TAG_ServerName]+'.' +Params.S[VS1_TAG_DatabaseName]);
              Exit;
            end;
            fsURL:=WebAPIURL(Params.B[VS1_TAG_HTTPS], APIPort(Params),Params.S[VS1_TAG_ServerName], VS1_Cloud_Task+'/Method?Name="'+TASK_VS1_DbConnectTest+'"' );
            if DoHTTPGET(fsURL,
                         Params.S[VS1_TAG_DatabaseName],
                         Params.S[VS1_TAG_VS1UserName],
                         Params.S[VS1_TAG_VS1Password],
                         JsResultStr) then begin
              Params.free;
              Params := jo(JsResultStr);
              AddEventdata(fOnEvent, VS1_TAG_ERPVersion     , Params.O[TAG_ProcessLog].S[VS1_TAG_ERPVersion], true );
              OnStatus(VS1_HTTP_Success_STRCode, 'OK');
              Result := (Trim(Params.O[TAG_ProcessLog].S[VS1_TAG_ERPVersion]) <> '');
            end else begin
              OnStatus(VS1_HTTP_Failed_STRCode,'Error Connecting to '+ Params.S[VS1_TAG_ServerName]+'.' +Params.S[VS1_TAG_DatabaseName]);
              Params.free;
              Params := jo(JsResultStr);
              AddEventdata(fOnEvent, TAG_ResponseError     , Params.O[VS1_TAG_ResPonse].O[TAG_ResponseError].S[VS1_TAG_Msg], true);
            end;
        end else begin
          DoGetDBDetails;
          OnStatus(VS1_HTTP_Success_STRCode,'OK');
        end;
    finally
      params.Free;
    end;
end;

Function TVS1CloudTaskThread.APIPort(params: TJsonObject):Integer;
begin
  REsult := 0;
  if not (Params.Exists(VS1_TAG_APIPort      )) then exit;
  try
      result := Params.I[VS1_TAG_APIPort];
  Except
    on E:Exception do begin
      try
        result := strtoint(Params.S[VS1_TAG_APIPort]);
      Except
        on E:Exception do begin
          REsult := 0;
        end;
      end;
    end;
  end;

end;

Procedure TVS1CloudTaskThread.VS1_ChangeDatabase;
var
  params: TJsonObject;
  aVS1_databases: TVS1_databases;
  aVS1_ClientUsers: TVS1_ClientUsers;
  fiVs1Employeeid: Integer;
  msg: String;
  aIsHttps: Boolean;
  aAPIPort: Integer;
  aServerName: String;
  aAdminDB: String;
  aAdminUser: String;
  aAdminPass: String;
  errMsg: String;
begin
  try
    AddEventdata(fOnEvent, TAG_ResponseTask, 'Change Database');
    params := JO(fParams);
    try
  Log('====================================================',ltDebug);
  Log('VS1_ChangeDatabase',ltDebug);
  Log(fParams, ltdetail);
  Log('====================================================',ltDebug);


      if  (Params.Exists(VS1_TAG_ServerName   )) and
          (Params.Exists(VS1_TAG_DatabaseName )) and
          (Params.Exists(VS1_TAG_DatabaseNameToChange )) and
          (Params.Exists(VS1_TAG_VS1UserName  )) and
          (Params.Exists(VS1_TAG_VS1Password  )) and
          (Params.Exists(VS1_TAG_HTTPS        )) and
          (Params.Exists(VS1_TAG_APIPort      )) and
          (Trim(Params.S[VS1_TAG_ServerName   ])<>'') and
          (Trim(Params.S[VS1_TAG_DatabaseName ])<>'') and
          (Trim(Params.S[VS1_TAG_DatabaseNameToChange])<>'') and
          (Trim(Params.S[VS1_TAG_VS1UserName  ])<>'') and
          (Trim(Params.S[VS1_TAG_VS1Password  ])<>'') and
          (APIPort(Params)<>0) then else begin
          OnStatus(VS1_HTTP_Failed_STRCode,'Insufficient Details of Database');
          AddEventdata(fOnEvent, TAG_ResponseError, 'Insufficient Details of Database', true);
          AddEventdata(fOnEvent, TAG_ResponseError, 'It is not possible to change the database for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.', true);
          Exit;
      end;
      AddEventdata(fOnEvent ,TAG_ResponseStatus , 'Params Checked', true);
      aVS1_databases := TVS1_databases.create(Nil);
      try
          aVS1_databases.connection := TMyDAcDataconnection.Create(aVS1_databases);
          aVS1_databases.connection.connection := fConn;
          aVS1_ClientUsers := TVS1_ClientUsers.create(Nil);
          try
              aVS1_ClientUsers.connection := aVS1_databases.connection;
              aVS1_ClientUsers.LoadSelect('DatabaseName='+ quotedstr(Trim(Params.S[VS1_TAG_DatabaseName ]))+ ' OR ' +
                                          'EmailId='+ quotedstr(Trim(Params.O[VS1_TAG_EmployeeDetails].S[TAG_ERPUserName])));
              if aVS1_ClientUsers.count >0 then begin
                if sametext(Trim(Params.S[VS1_TAG_DatabaseName ]) , aVS1_ClientUsers.DatabaseName) then
                      errMsg:= 'Database ('+ Trim(Params.S[VS1_TAG_DatabaseName ])+ ')'
                else  errMsg:= 'User('+ Trim(Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName])+')';
                OnStatus(VS1_HTTP_Failed_STRCode,'Another VS1 Account Exist for '+errMsg+'.');
                AddEventdata(fOnEvent, TAG_ResponseError, 'Another VS1 Account Exist for  '+errMsg+'.', true);
                Exit;
              end else begin
                AddEventdata(fOnEvent, TAG_ResponseStatus, 'Checking for Existing VS1 Account for TrueERP Username/Password  - Success', true);
              end;
          finally
            Freeandnil(aVS1_ClientUsers);
          end;

          aVS1_databases.LoadSelect('DatabaseName=' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange])));
          if aVS1_databases.count = 0  then begin
            OnStatus(VS1_HTTP_Failed_STRCode,'VS1 License NOT found for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.');
            AddEventdata(fOnEvent, TAG_ResponseError, 'VS1 License NOT found for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.', true);
            Exit;
          end else begin
            AddEventdata(fOnEvent, TAG_ResponseStatus, 'Checking for Existing VS1 Account for TrueERP database name  - Success', true);
          end;
          if aVS1_databases.VS1_Clients.count = 0 then begin
            OnStatus(VS1_HTTP_Failed_STRCode,'VS1 License NOT found for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.');
            AddEventdata(fOnEvent, TAG_ResponseError, 'VS1 License NOT found for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.', true);
            Exit;
          end else begin
            AddEventdata(fOnEvent, TAG_ResponseStatus, 'Checking for VS1 License  - Success', true);
          end;
          aVS1_databases.Connection.BeginTransaction;
          try

            aIsHttps :=aVS1_databases.IsHttps;
            aAPIPort :=aVS1_databases.APIPort;
            aServerName := aVS1_databases.ServerName;
            aAdminDB    := aVS1_databases.vs1_clientdbserver.AdminDB;
            aAdminUser  := aVS1_databases.vs1_clientdbserver.AdminUser;
            aAdminPass  := aVS1_databases.vs1_clientdbserver.AdminPass;
            AddEventdata(fOnEvent ,TAG_ResponseStatus , 'Variables Initialised', true);
            if aVS1_databases.VS1_Clients.count =0 then begin
              OnStatus(VS1_HTTP_Failed_STRCode,'Client record not founf.');
              AddEventdata(fOnEvent, TAG_ResponseError, 'Client record not founf.', true);
              Exit;
            end;

            AddEventdata(fOnEvent, TAG_ResponseStatus, 'VS1 Database # ' + inttostr(aVS1_databases.ID), true);
            AddEventdata(fOnEvent, TAG_ResponseStatus, 'VS1 Database.client # ' + inttostr(aVS1_databases.VS1_Clients.ID), true);

            aVS1_databases.ServerName   := Trim(Params.S[VS1_TAG_ServerName   ]);
            aVS1_databases.DatabaseName := Trim(Params.S[VS1_TAG_DatabaseName ]);
            aVS1_databases.APIPort      := APIPort(Params);//Params.I[VS1_TAG_APIPort];
            aVS1_databases.IsHttps      := Params.B[VS1_TAG_HTTPS];
            aVS1_databases.PostDB;
            AddEventdata(fOnEvent, TAG_ResponseStatus, 'VS1 Database Name Changed for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.', true);
            AddEventdata(fOnEvent, TAG_ResponseStatus, 'VS1 Database # ' + inttostr(aVS1_databases.ID), true);
            AddEventdata(fOnEvent, TAG_ResponseStatus, 'VS1 Database.client # ' + inttostr(aVS1_databases.VS1_Clients.ID), true);
            aVS1_databases.VS1_Clients.ServerName   := Trim(Params.S[VS1_TAG_ServerName   ]);
            aVS1_databases.VS1_Clients.DatabaseName := Trim(Params.S[VS1_TAG_DatabaseName ]);
            aVS1_databases.VS1_Clients.APIPort      := APIPort(Params);//Params.I[VS1_TAG_APIPort];
            aVS1_databases.VS1_Clients.IsHttps      := Params.B[VS1_TAG_HTTPS];
            aVS1_databases.VS1_Clients.PostDB;
            AddEventdata(fOnEvent, TAG_ResponseStatus, 'VS1 Database Mapped for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.', true);

            aVS1_databases.VS1_Clients.ClientUsers.DeleteAll;

                     (*Params.S[VS1_TAG_VS1UserName  ] := ERP_VS1CLOUD_DEFAULT_USER;
                     Params.S[VS1_TAG_VS1Password  ] := ERP_VS1CLOUD_DEFAULT_TOKEN;*)
                     //Params.S[VS1_TAG_VS1UserName  ] := Params.S[VS1_TAG_VS1UserName];
                     //Params.S[VS1_TAG_VS1Password  ] := Params.S[VS1_TAG_VS1Password];
                     fiVs1Employeeid:= ClientEmployeeID(aVS1_databases, Params,msg);
                     if  fiVs1Employeeid=0 then begin
                        OnStatus(VS1_HTTP_Failed_STRCode,'Failed to Create User for ' + quotedstr(aVS1_databases.DatabaseName)+'.');
                        AddEventdata(fOnEvent ,TAG_ResponseError     , 'Failed to Create Users for ' + quotedstr(aVS1_databases.DatabaseName)+'.', true);
                        aVS1_databases.Connection.RollbackTransaction;
                        Exit;
                     end else begin
                      AddEventdata(fOnEvent ,TAG_ResponseStatus , 'User Created.', true);
                     end;
            aVS1_databases.VS1_Clients.ClientUsers.New;
            aVS1_databases.VS1_Clients.ClientUsers.DatabaseName := aVS1_databases.Databasename;
            aVS1_databases.VS1_Clients.ClientUsers.VS1Employeeid:= fiVs1Employeeid;
            aVS1_databases.VS1_Clients.ClientUsers.EmailId      := Params.O[VS1_TAG_EmployeeDetails].S[TAG_ERPUserName];//Params.S[VS1_TAG_VS1UserName];//Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName];//Params.S[VS1_TAG_VS1UserName];
            aVS1_databases.VS1_Clients.ClientUsers.Password     := Params.O[VS1_TAG_EmployeeDetails].S[TAG_ERPPassword];//Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPPassword];//Params.S[VS1_TAG_VS1Password];
            aVS1_databases.VS1_Clients.ClientUsers.ClientId     := aVS1_databases.VS1_Clients.ID;
            aVS1_databases.VS1_Clients.ClientUsers.Phone        := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_PhoneNumber];
            aVS1_databases.VS1_Clients.ClientUsers.Firstname    := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_FirstName];
            aVS1_databases.VS1_Clients.ClientUsers.LastName     := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_LastName];
            aVS1_databases.VS1_Clients.ClientUsers.isAdminuser  := true;
            aVS1_databases.VS1_Clients.ClientUsers.Active       := True;
            aVS1_databases.VS1_Clients.ClientUsers.PostDB;
            AddEventdata(fOnEvent ,TAG_ResponseStatus , 'Client User Created.', true);

            if aVS1_databases.VS1_Clients.ClientModules.locate('ModuleID' , VS1_Module_Link_To_TrueERP_ID, []) then begin
              aVS1_databases.VS1_Clients.ClientModules.Active := False;
              aVS1_databases.VS1_Clients.ClientModules.PostDB;
            end;
            {Drop old database databse }

            if not Vs1lib.DropDatabase(aIsHttps,aAPIPort,aServerName,Trim(Params.S[VS1_TAG_DatabaseNameToChange]),
                                aAdminDB ,aAdminUser,aAdminPass) then begin
                        OnStatus(VS1_HTTP_Failed_STRCode,'Failed to Drop the Current Database for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.');
                        AddEventdata(fOnEvent ,TAG_ResponseError     , 'Failed to Drop the Current Database for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.', true);
                        aVS1_databases.Connection.RollbackTransaction;
                        Exit;
            end else begin
              AddEventdata(fOnEvent ,TAG_ResponseStatus , 'Database Dropped.', true);
            end;
            aVS1_databases.Connection.CommitTransaction;
            OnStatus(VS1_HTTP_Success_STRCode,'OK');
            AddEventdata(fOnEvent ,'Response'     , 'Database is Changed for ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.', true);

          Except
            on E:Exception do begin
              OnStatus(VS1_HTTP_Failed_STRCode,'Failed to Change the Database for  ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.'+Char(13)+E.Message);
              AddEventdata(fOnEvent ,TAG_ResponseError     , 'Failed to Change the Database for  ' + quotedstr(Trim(Params.S[VS1_TAG_DatabaseNameToChange]))+'.'+Char(13)+E.Message, true);
              aVS1_databases.Connection.RollbackTransaction;
              Exit;
            end;
          end;
      finally
        Freeandnil(aVS1_databases);
      end;
    finally
      params.Free;
    end;
  Except
    on E:Exception do begin
      AddEventdata(fOnEvent ,TAG_ResponseError , E.message, true);
    end;
  end;
end;

procedure TVS1CloudTaskThread.VS1_NewUser;
var
  params: TJsonObject;
  aVS1_ClientUsers : TVS1_ClientUsers;
  aVS1_Database : TVS1_Databases;
  aVS1_Clients : TVS1_Clients;
  //conn: TMyConnection;
  msg : String;
  fiVs1Employeeid : Integer;
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 User');
  params := JO(fParams);
  try
    if not Params.Exists(VS1_TAG_DatabaseName)                            then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Database Name')   ; exit; end;
    if not Params.Exists(VS1_TAG_VS1UserName)                             then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - User Name')       ; exit; end;
    if not Params.Exists(VS1_TAG_VS1Password)                             then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Password')        ; exit; end;
    if not Params.Exists(VS1_TAG_EmployeeDetails)                         then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - New User Details'); exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_PhoneNumber)  then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Phone number')    ; exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_FirstName)    then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - First Name')      ; exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_LastName)     then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Last Name')       ; exit; end;

    try
      aVS1_Clients := TVS1_Clients.Create(Nil);
      try
        aVS1_Clients.Connection := TMyDAcDataconnection.Create(aVS1_Clients);
        aVS1_Clients.Connection.Connection := fConn;
        //aVS1_Clients.LoadSelect('ClientName=' + quotedstr(Params.S[VS1_TAG_ClientName] ));
        aVS1_Clients.LoadSelect('DatabaseName=' + QuotedStr(Params.S[VS1_TAG_DatabaseName] ));
        try
          aVS1_Clients.Connection.BeginTransaction;
          try
            if aVS1_Clients.Count = 0 then begin
              OnStatus(VS1_HTTP_Failed_STRCode, 'Client record not found');
              Exit;
            end;

            if not(SameText(aVS1_Clients.SampleDatabaseName, Params.S[VS1_TAG_DatabaseName])) then begin
              OnStatus(VS1_HTTP_Failed_STRCode,'Databse Doesn''t Match');
              Exit;
            end;

            if not AddClientModule(aVS1_Clients, VS1_MODULE_Add_Extra_User, params) then Exit;

            aVS1_Database := TVS1_Databases.Create(nil);
            try
              aVS1_Database.Connection := aVS1_Clients.Connection;
              aVS1_Database.LoadSelect('DatabaseName=' + QuotedStr(Params.S[VS1_TAG_DatabaseName]));

              if aVS1_Database.Count = 0 then begin
                OnStatus(VS1_HTTP_Failed_STRCode, 'Invalid Database');
                Exit;
              end;

              if aVS1_Database.Vs1_ClientID <> aVS1_Clients.Vs1ClientID then begin
                OnStatus(VS1_HTTP_Failed_STRCode, 'Client and Database doesn''t match');
                Exit;
              end;

              fiVs1Employeeid := ClientEmployeeID(aVS1_Database, Params, msg);
              if fiVs1Employeeid = 0 then begin
                OnStatus(VS1_HTTP_Failed_STRCode, 'Failed to Create User / employee');
                Exit;
              end;

              aVS1_ClientUsers := TVS1_ClientUsers.Create(nil);
              try
                aVS1_ClientUsers.Connection := aVS1_Database.Connection;
                aVS1_ClientUsers.LoadSelect('EmailId=' + QuotedStr(Params.S[VS1_TAG_VS1UserName]));
                if (aVS1_ClientUsers.Count <> 0) then begin
                  if SameText(aVS1_ClientUsers.DatabaseName, Params.S[VS1_TAG_DatabaseName]) then begin
                    OnStatus(VS1_HTTP_Failed_STRCode, 'User Credential Already Exists');
                  end else begin
                    OnStatus(VS1_HTTP_DupicateErr_STRCode, 'Duplicate User Credential');
                  end;
                  Exit;
                end;

                aVS1_ClientUsers.New;
                aVS1_ClientUsers.DatabaseName   := aVS1_Database.Databasename;
                aVS1_ClientUsers.VS1Employeeid  := fiVs1Employeeid;
                aVS1_ClientUsers.EmailId        := Params.S[VS1_TAG_VS1UserName];
                aVS1_ClientUsers.ClientId       := aVS1_Clients.ID;
                aVS1_ClientUsers.Phone          := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_PhoneNumber];
                aVS1_ClientUsers.Password       := Params.S[VS1_TAG_VS1Password];
                aVS1_ClientUsers.Firstname      := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_FirstName];
                aVS1_ClientUsers.LastName       := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_LastName];
                aVS1_ClientUsers.Active         := True;
                aVS1_ClientUsers.PostDB;

                OnStatus(VS1_HTTP_Success_STRCode, 'OK');
                aVS1_Clients.connection.CommitTransaction;

              finally
                freeandnil(aVS1_ClientUsers);
              end;
            finally
              Freeandnil(aVS1_Database);
            end;
          Except
            on E:Exception do begin
              aVS1_Clients.connection.RollbackTransaction;
            end;
          end;
        finally
          // if in transaction, rollback it
          aVS1_Clients.connection.RollbackTransaction;
        end;
      finally
        Freeandnil(aVS1_Clients);
      end;
    Except
      on E:Exception do begin
        AddEventdata(fOnEvent, TAG_ResponseError, E.message);
      end;
    end;
  finally
    params.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_NewUser2;
var
  params: TJsonObject;
  aVS1_Database : TVS1_Databases;
  iClientID: Integer;
  aVS1_ClientUsers : TVS1_ClientUsers;
  aVS1_Clients : TVS1_Clients;
  msg : String;
  fiVs1Employeeid : Integer;
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 User');
  params := JO(fParams);
  try
    if not Params.Exists(VS1_TAG_DatabaseName)                            then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Database Name')   ; exit; end;
    if not Params.Exists(VS1_TAG_VS1UserName)                             then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - User Name')       ; exit; end;
    if not Params.Exists(VS1_TAG_VS1Password)                             then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Password')        ; exit; end;
    if not Params.Exists(VS1_TAG_EmployeeDetails)                         then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - New User Details'); exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_PhoneNumber)  then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Phone number')    ; exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_FirstName)    then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - First Name')      ; exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_LastName)     then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Last Name')       ; exit; end;

    try
      aVS1_Database := TVS1_Databases.Create(nil);
      try
        aVS1_Database.Connection := TMyDAcDataconnection.Create(aVS1_Database);
        aVS1_Database.Connection.Connection := fConn;
        aVS1_Database.LoadSelect('DatabaseName=' + QuotedStr(Params.S[VS1_TAG_DatabaseName]));
        try
          aVS1_Database.Connection.BeginTransaction;

          if aVS1_Database.Count = 0 then begin
            OnStatus(VS1_HTTP_Failed_STRCode, 'Database record not found');
            Exit;
          end;

          iClientID := aVS1_Database.ClientID;

          aVS1_Clients := TVS1_Clients.Create(nil);
          try
            aVS1_Clients.Connection := aVS1_Database.Connection;
            aVS1_Clients.LoadSelect('ID=' + IntToStr(iClientID));
            if aVS1_Clients.Count = 0 then begin
              OnStatus(VS1_HTTP_Failed_STRCode, 'Client record not found');
              Exit;
            end;

            if not AddClientModule(aVS1_Clients, VS1_MODULE_Add_Extra_User, params) then Exit;

            fiVs1Employeeid := ClientEmployeeID(aVS1_Database, Params, msg);
            if fiVs1Employeeid = 0 then begin
              OnStatus(VS1_HTTP_Failed_STRCode, 'Failed to Create User / employee');
              Exit;
            end;

            aVS1_ClientUsers := TVS1_ClientUsers.Create(nil);
            try
              aVS1_ClientUsers.Connection := aVS1_Database.Connection;
              aVS1_ClientUsers.LoadSelect('EmailId=' + QuotedStr(Params.S[VS1_TAG_VS1UserName]));
              if (aVS1_ClientUsers.Count <> 0) then begin
                if SameText(aVS1_ClientUsers.DatabaseName, Params.S[VS1_TAG_DatabaseName]) then begin
                  OnStatus(VS1_HTTP_Failed_STRCode, 'User Credential Already Exists');
                end else begin
                  OnStatus(VS1_HTTP_DupicateErr_STRCode, 'Duplicate User Credential');
                end;
                Exit;
              end;

              aVS1_ClientUsers.New;
              aVS1_ClientUsers.DatabaseName   := aVS1_Database.Databasename;
              aVS1_ClientUsers.VS1Employeeid  := fiVs1Employeeid;
              aVS1_ClientUsers.EmailId        := Params.S[VS1_TAG_VS1UserName];
              aVS1_ClientUsers.ClientId       := aVS1_Clients.ID;
              aVS1_ClientUsers.Phone          := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_PhoneNumber];
              aVS1_ClientUsers.Password       := Params.S[VS1_TAG_VS1Password];
              aVS1_ClientUsers.Firstname      := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_FirstName];
              aVS1_ClientUsers.LastName       := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_LastName];
              aVS1_ClientUsers.Active         := True;
              aVS1_ClientUsers.PostDB;

              OnStatus(VS1_HTTP_Success_STRCode, 'OK');
              aVS1_Clients.connection.CommitTransaction;

            finally
              freeandnil(aVS1_ClientUsers);
            end;

          finally
            FreeAndNil(aVS1_Clients);
          end;

        finally
          aVS1_Database.Connection.RollbackTransaction;
        end;
      finally
        FreeAndNil(aVS1_Database);
      end;

    Except
      on E:Exception do begin
        AddEventdata(fOnEvent, TAG_ResponseError, E.message);
      end;
    end;
  finally
    params.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_SetAccountant;
var
  params: TJsonObject;
  aVS1_Database: TVS1_Databases;
  aVS1_Clients: TVS1_Clients;
  aVS1_ClientUsers: TVS1_ClientUsers;
  iClientID: Integer;
  msg: String;
  fiVs1Employeeid: Integer;
  toChange: Boolean;
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, 'Set accountant for this company');
  params := JO(fParams);
  try
    if not Params.Exists(VS1_TAG_DatabaseName)                            then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Database Name')   ; exit; end;
    if not Params.Exists(VS1_TAG_VS1UserName)                             then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - User Name')       ; exit; end;
    if not Params.Exists(VS1_TAG_VS1Password)                             then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Password')        ; exit; end;
    if not Params.Exists(VS1_TAG_EmployeeDetails)                         then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - New User Details'); exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_PhoneNumber)  then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Phone number')    ; exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_FirstName)    then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - First Name')      ; exit; end;
    if not Params.O[VS1_TAG_EmployeeDetails].Exists(VS1_TAG_LastName)     then begin OnStatus(VS1_HTTP_Failed_STRCode,'Missing Required Details - Last Name')       ; exit; end;

    try
      aVS1_Database := TVS1_Databases.Create(nil);
      try
        aVS1_Database.Connection := TMyDAcDataconnection.Create(aVS1_Database);
        aVS1_Database.Connection.Connection := fConn;
        aVS1_Database.LoadSelect('DatabaseName=' + QuotedStr(Params.S[VS1_TAG_DatabaseName]));
        try
          aVS1_Database.Connection.BeginTransaction;

          if aVS1_Database.Count = 0 then begin
            OnStatus(VS1_HTTP_Failed_STRCode, 'Database record not found');
            Exit;
          end;

          iClientID := aVS1_Database.ClientID;

          aVS1_Clients := TVS1_Clients.Create(nil);
          try
            aVS1_Clients.Connection := aVS1_Database.Connection;
            aVS1_Clients.LoadSelect('ID=' + IntToStr(iClientID));
            if aVS1_Clients.Count = 0 then begin
              OnStatus(VS1_HTTP_Failed_STRCode, 'Client record not found');
              Exit;
            end;

            fiVs1Employeeid := ClientEmployeeID(aVS1_Database, Params, msg);
            if fiVs1Employeeid = 0 then begin
              OnStatus(VS1_HTTP_Failed_STRCode, 'Failed to Create User / employee');
              Exit;
            end;

            aVS1_ClientUsers := TVS1_ClientUsers.Create(nil);
            try
              aVS1_ClientUsers.Connection := aVS1_Database.Connection;
              toChange := False;
              aVS1_ClientUsers.LoadSelect('DatabaseName=' + QuotedStr(aVS1_Database.DatabaseName) + ' AND IsAccountant="T"');
              if (aVS1_ClientUsers.Count <> 0) then begin
                if SameText(aVS1_ClientUsers.EmailId, Params.S[VS1_TAG_VS1UserName]) then begin
                  OnStatus(VS1_HTTP_Failed_STRCode, 'Already Exists');
                  Exit;
                end else begin
                  toChange := True;
                end;
              end;

              if not toChange then
                aVS1_ClientUsers.New;

              aVS1_ClientUsers.DatabaseName   := aVS1_Database.Databasename;
              aVS1_ClientUsers.VS1Employeeid  := fiVs1Employeeid;
              aVS1_ClientUsers.EmailId        := Params.S[VS1_TAG_VS1UserName];
              aVS1_ClientUsers.ClientId       := aVS1_Clients.ID;
              aVS1_ClientUsers.Phone          := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_PhoneNumber];
              aVS1_ClientUsers.Password       := Params.S[VS1_TAG_VS1Password];
              aVS1_ClientUsers.Firstname      := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_FirstName];
              aVS1_ClientUsers.LastName       := Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_LastName];
              aVS1_ClientUsers.IsAccountant   := True;
              aVS1_ClientUsers.Active         := True;
              aVS1_ClientUsers.PostDB;

              OnStatus(VS1_HTTP_Success_STRCode, 'OK');
              aVS1_Clients.connection.CommitTransaction;

            finally
              freeandnil(aVS1_ClientUsers);
            end;

          finally
            FreeAndNil(aVS1_Clients);
          end;

        finally
          aVS1_Database.Connection.RollbackTransaction;
        end;
      finally
        FreeAndNil(aVS1_Database);
      end;
    Except
      on E:Exception do begin
        AddEventdata(fOnEvent, TAG_ResponseError, E.message);
      end;
    end;
  finally
    params.Free;
  end;
end;

Procedure TVS1CloudTaskThread.VS1_ChangePassword;
var
  params: TJsonObject;
  //VS1_Rego :TVS1_Rego;
  aVS1_ClientUsers: TVS1_ClientUsers;
  msg:String;
  fiVS1Employeeid:Integer;
begin
    AddEventdata(fOnEvent ,TAG_ResponseTask     , 'VS1 Change User Password', true);
    params := JO(fParams);
    try

       aVS1_ClientUsers:= TVS1_ClientUsers.CreateWithNewConn(nil , fconn);
       try
            //aVS1_ClientUsers.LoadSelect('EmailId =' + quotedstr(Params.O[VS1_TAG_ERPLoginDetails].S[VS1_TAG_VS1UserName]));
            aVS1_ClientUsers.LoadSelect('EmailId =' + quotedstr(Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName]));
            if (aVS1_ClientUsers.count =0) then begin
              OnStatus(VS1_HTTP_Failed_STRCode,' VS1 User Invalid');
              Exit;
            end;
            aVS1_ClientUsers.Connection.begintransaction;
            try
                Params.S[VS1_TAG_DatabaseName]   := aVS1_ClientUsers.databasename;
                if aVS1_ClientUsers.VS1Employeeid =0 then begin
(*                  fiVS1Employeeid := ClientEmployeeID(aVS1_ClientUsers.VS1_Database, Params,msg, true);
                  aVS1_ClientUsers.VS1Employeeid :=fiVS1Employeeid;*)
                  OnStatus(VS1_HTTP_Failed_STRCode,' User Doesn''t Exist');
                  Exit;
                end else begin
                  fiVS1Employeeid :=aVS1_ClientUsers.VS1Employeeid;
                end;
                if fiVS1Employeeid =0 then begin
                  OnStatus(VS1_HTTP_Failed_STRCode,' User Doesn''t Exist');
                  Exit;
                end;

                aVS1_ClientUsers.password:= Params.O[VS1_TAG_ERPLoginDetails].S[VS1_TAG_NewPassword];
                aVS1_ClientUsers.PostDB;
                Params.O[VS1_TAG_EmployeeDetails].I[VS1_TAG_ID] := fiVS1Employeeid;
(*                Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_firstname]:=Params.S[VS1_TAG_firstname];
                Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_lastname]:=Params.S[VS1_TAG_lastname];
                Params.O[VS1_TAG_EmployeeDetails].S[VS1_TAG_EmployeeName]:=Params.S[VS1_TAG_EmployeeName];*)

                {temporary default user for ClientEmployeeID}
                Params.S[VS1_TAG_VS1UserName  ]:= ERP_VS1CLOUD_DEFAULT_USER;
                Params.S[VS1_TAG_VS1Password  ]:= ERP_VS1CLOUD_DEFAULT_TOKEN;
                //Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName] := Params.O[VS1_TAG_ERPLoginDetails].S[VS1_TAG_VS1UserName];
                Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName] := Params.O[VS1_TAG_ERPLoginDetails].S[TAG_ERPUserName];

                if ClientEmployeeID(aVS1_ClientUsers.VS1_Database, Params,msg, False)>0 then begin
                  aVS1_ClientUsers.Connection.Committransaction;
                  OnStatus(VS1_HTTP_Success_STRCode,' VS1 Password Changed ');
                end else begin
                  aVS1_ClientUsers.Connection.Rollbacktransaction;
                  OnStatus(VS1_HTTP_Failed_STRCode,' VS1 Password Change Failed ');
                end;
            except
              on E:Exception do begin
                aVS1_ClientUsers.Connection.Rollbacktransaction;
              end;
            end;
    finally
       Freeandnil(aVS1_ClientUsers);
    end;
    finally
      params.Free;
    end;
end;

Procedure TVS1CloudTaskThread.VS1_Renew;
var
  params: TJsonObject;
  VS1_Rego :TVS1_Rego;
begin
    AddEventdata(fOnEvent ,TAG_ResponseTask     , 'VS1 REgo Renewal', true);
    params := JO(fParams);
    try
      VS1_Rego := TVS1_Rego.Create(nil, fconn);
      try
        InitVS1Rego(VS1_Rego, Params);
        VS1_Rego.VS1_Renew(fOnEvent, fLogger);
        Terminate;
      finally
        Freeandnil(VS1_Rego);
      end;
    finally
      params.Free;
    end;
end;

Procedure TVS1CloudTaskThread.VS1_InitNewDatabase;
var
  params: TJsonObject;
begin
  params := JO(fParams);
  try
    AddEventdata(fOnEvent, TAG_ResponseTask, TASK_VS1_InitNewDatabase, True);
    OnNewDatabase(fOnEvent, Params.O[TAG_JsonIN], fConn.database, fConn.Server, fConn, Params.O[TAG_CLOUD_Params].B[VS1_TAG_IsVS1Database]);
  finally
    params.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_Dashboard;
var
  Params: TJsonObject;
  DateFrom, DateTo: string;
  objconn: TMyDacDataConnection;
  JSONSerialiser: TJSONSerialiser;
  aResultJson: TJsonObject;
  aUser:  TUser;

  procedure InitBusObjProperties(aMSBusObj: TMSBusObj; PropertyList: Array of string);
  var
    count, x: integer;
    PropList: PPropList;
    propName: string;
    PropInfo: PPropInfo;
    s:string;

    function Contains(Const StringToSearch: string): Boolean;
    var
      i:Integer;
    begin
      Result := False;
      for i := Low(PropertyList) to High(PropertyList) do begin
        if SameText(PropertyList[i], StringToSearch) then begin
          Result := True;
          Exit;
        end;
      end;
    end;
  begin
    inherited;
    Count := GetPropList(aMSBusObj.ClassInfo, tkProperties, nil);
    GetMem(PropList, Count * SizeOf(PPropInfo));
    try
      GetPropList(aMSBusObj.ClassInfo, tkProperties, PropList);
      for x := 0 to Count -1 do begin
        s := String(PropList[x].Name);
        if Contains(s) then else
          aMSBusObj.ExportExcludeList.Add(s);
      end;
    finally
      FreeMem(PropList, Count * SizeOf(PPropInfo));
    end;
  end;

  procedure AddbusObj(aMSBusObj: TMSBusObj; islist: Boolean; noRecMsg: string='');
  begin
    if aMSBusObj.Count > 0 then begin
      aMSBusObj.First;
      if not islist then begin
        JSONSerialiser.Clear;
        aResultJson.O[aMSBusObj.ClassName] := JO(JSONSerialiser.SerialiseObject(aMSBusObj).AsString);
      end else begin
        aResultJson.O[aMSBusObj.ClassName] := JO;
        while not aMSBusObj.EOF do begin
          JSONSerialiser.Clear;
          aResultJson.O[aMSBusObj.ClassName].A['items'].Add(JO(JSONSerialiser.SerialiseObject(aMSBusObj).AsString));
          aMSBusObj.Next;
        end;
      end;
      aResultJson.O[aMSBusObj.ClassName].I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
    end else begin
      aResultJson.O[aMSBusObj.ClassName].I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "NO DATA" }
      if noRecMsg = '' then noRecMsg := aMSBusObj.XMLNodeName + ' - no data found';
      aResultJson.O[aMSBusObj.ClassName].S[TAG_ResponseStatus] := noRecMsg;
    end;
  end;

{------------}Procedure Do_VS1_dashboard_EmployeePicture;
              var
                aEmployeePicture : TEmployeePicture;
              begin
                aEmployeePicture := TEmployeePicture.create(nil);
                try
                  aEmployeePicture.Connection := objconn;
                  aEmployeePicture.LoadSelect(VS1_TAG_EmployeeId +'='+ inttostr(aUser.EmployeeId));
                  AddbusObj(aEmployeePicture,False);
                finally
                  Freeandnil(aEmployeePicture);
                end;
              end;

{------------}Procedure Do_VS1_dashboard_EmployeeAccessLevel;
              var
                aEmployeeFormAccessDetail: TEmployeeFormAccessDetail;
              begin
                aEmployeeFormAccessDetail := TEmployeeFormAccessDetail.Create(nil);
                try
                  aEmployeeFormAccessDetail.Connection := objconn;
                  aEmployeeFormAccessDetail.LoadSelect(VS1_TAG_EmployeeId + '=' + IntToStr(aUser.EmployeeId) + ' AND TabGroup = 26');
                  InitBusObjProperties(aEmployeeFormAccessDetail, ['FormID', 'AccessLevel', 'AccessLevelName', 'Description', 'formname', 'ID', 'Employeeid']);
                  AddbusObj(aEmployeeFormAccessDetail, True);
                finally
                  Freeandnil(aEmployeeFormAccessDetail);
                end;
              end;

{------------}Procedure Do_VS1_dashboard_TransTableLastUpdated;
              begin
                aResultJson.DT[VS1_TAG_TransTableLastUpdated] := AppEnvVirt.Float['CompanyPrefs.TransactionTableLastUpdated']
              end;

{------------}Procedure Do_VS1_dashboard_ap_report;
              var
                avs1_dashboard_ap_report : TVS1_dashboard_ap_report;
              begin
                avs1_dashboard_ap_report := TVS1_dashboard_ap_report.create(nil);
                try
                  avs1_dashboard_ap_report.Connection := objconn;
                  avs1_dashboard_ap_report.SQLOrder := 'datefrom';
                  avs1_dashboard_ap_report.Load;
                  AddbusObj(avs1_dashboard_ap_report, True );
                finally
                  Freeandnil(avs1_dashboard_ap_report);
                end;
              end;

{------------}Procedure Do_VS1_dashboard_PnL_Period;
              var
                avs1_dashboard_PnL_Period : TVS1_dashboard_PnL_Period;
              begin
                avs1_dashboard_PnL_Period := TVS1_dashboard_PnL_Period.create(nil);
                try
                  avs1_dashboard_PnL_Period.Connection := objconn;
                  avs1_dashboard_PnL_Period.Load;
                  AddbusObj(avs1_dashboard_PnL_Period, True );
                finally
                  Freeandnil(avs1_dashboard_PnL_Period);
                end;
              end;

{------------}Procedure Do_VS1_dashboard_SalesList;
              var
                avs1_dashboard_SalesList : TVS1_dashboard_SalesList;
              begin
                avs1_dashboard_SalesList := TVS1_dashboard_SalesList.create(nil);
                try
                  avs1_dashboard_SalesList.Connection := objconn;
                  avs1_dashboard_SalesList.SQLOrder := 'datefrom';
                  avs1_dashboard_SalesList.Load;
                  AddbusObj(avs1_dashboard_SalesList, True );
                finally
                  Freeandnil(avs1_dashboard_SalesList);
                end;
              end;

{------------}Procedure Do_VS1_dashboard_SalesPerEmployee;
              var
                avs1_dashboard_SalesPerEmployee : TVS1_dashboard_SalesPerEmployee;
              begin
                avs1_dashboard_SalesPerEmployee := TVS1_dashboard_SalesPerEmployee.create(nil);
                try
                  avs1_dashboard_SalesPerEmployee.Connection := objconn;
                  avs1_dashboard_SalesPerEmployee.Load;
                  AddbusObj(avs1_dashboard_SalesPerEmployee, True );
                finally
                  Freeandnil(avs1_dashboard_SalesPerEmployee);
                end;
              end;

{------------}Procedure Do_VS1_Dashboard_Summary;
              var
                avs1_dashboard_Summary: TVS1_dashboard_summary;
              begin
                avs1_dashboard_Summary := TVS1_dashboard_summary.create(nil);
                try
                  avs1_dashboard_Summary.Connection := objconn;
                  avs1_dashboard_Summary.Load;
                  AddbusObj(avs1_dashboard_Summary, False);
                finally
                  Freeandnil(avs1_dashboard_Summary);
                end;
              end;

{------------}Procedure Do_VS1_Dashboard_Summary2;
              var
                sum2_obj: TVS1_Dashboard_Summary2;
              begin
                sum2_obj := TVS1_Dashboard_Summary2.Create(nil);
                sum2_obj.CreateTemporaryTable(DateFrom, DateTo);
                try
                  sum2_obj.Connection := objconn;
                  sum2_obj.Load;
                  AddbusObj(sum2_obj, False);
                finally
                  Freeandnil(sum2_obj);
                end;
              end;

{------------}Procedure CheckUserforEmployeeEmailID(const aUserName:String);
              var
                aEmployee: TEmployee;
              begin
                {if there is a single user with the EmailId provided }
                aEmployee := TEmployee.Create(nil);
                try
                  aEmployee.Connection := objconn;
                  aEmployee.LoadSelect(VS1_TAG_EMail + '=' + Quotedstr(aUserName));
                  if aEmployee.count = 1 then
                    aUser.LoadSelect(VS1_TAG_EmployeeId + '=' + inttostr(aEmployee.ID));
                finally
                  Freeandnil(aEmployee);
                end;
              end;

{------------}Procedure Do_VS1_dashboard_Employee;
              var
                aEmployee: TEmployee;
                aCompanyInfo: TCompanyinfo;
              begin
                aEmployee := TEmployee.Create(nil);
                try
                  aEmployee.Connection := objconn;
                  aEmployee.LoadSelect(VS1_TAG_EmployeeId + '=' + IntToStr(aUser.EmployeeId));
                  if aEmployee.count <> 1 then begin
                    aResultJson.S['8->' + VS1_TAG_DashboardError + '_' + VS1_TAG_Dashboard_Employee    ]
                  end else begin
                    aResultJson.S[VS1_TAG_EMail] := aEmployee.Email;
                    if aEmployee.EmailsFromEmployeeAddress then
                      aResultJson.B[VS1_TAG_EmailsFromEmployeeAddress] := True
                    else aResultJson.B[VS1_TAG_EmailsFromEmployeeAddress] := False;
                    aResultJson.S[VS1_TAG_DashboardOption] := aEmployee.DashboardOption;
                    aResultJson.S[VS1_TAG_LoginDefault] := aEmployee.LoginDefault;
                  end;
                finally
                  FreeAndNil(aEmployee);
                end;

                aCompanyInfo := TCompanyInfo.create(nil);
                try
                  aCompanyInfo.Connection := objconn;
                  aCompanyInfo.Load;
                  aResultJson.S[VS1_TAG_CompanyEMail] := aCompanyInfo.Email;
                finally
                  Freeandnil(aEmployee);
                end;

              end;

begin
  Params := JO(fParams);

  DateFrom := '1970-01-01';
  DateTo := '2050-12-30';
  if Params.Exists(TAG_CLOUD_Params) and Params.O[TAG_CLOUD_Params].Exists('DateFrom') then
    DateFrom := Params.O[TAG_CLOUD_Params].S['DateFrom'];

  if Params.Exists(TAG_CLOUD_Params) and Params.O[TAG_CLOUD_Params].Exists('DateTo') then
    DateTo := Params.O[TAG_CLOUD_Params].S['DateTo'];

  try
    AddEventdata(fOnEvent, TAG_ResponseTask, TASK_VS1_Dashboard, true);
    JSONSerialiser := TJSONSerialiser.Create;
    try
      objconn := TMyDacDataConnection.Create(nil);
      try
{ -----------User }
        objconn.connection := fconn;
        aUser              := TUser.Create(nil);
        With aUser do try
          Connection := objconn;
          LoadSelect('Logon_name=' + QuotedStr(params.S[TAG_ERPUserName]));

          {Changes made for Exisitng ERP database
          Dene wants to use the emailId for VS1 login
          and in ERP username can be differnet .

          So if Use not found for VS1 Username, check in the employeeCard.EmailId
          if a single employee found with the emailId , then use it }
          if Count = 0 then
            CheckUserforEmployeeEmailID(params.S[TAG_ERPUserName]);

          if Count = 1 then begin
            aResultJson := JO;
            try
              if aUser.employeeID <> 0 then begin
                aResultJson.I[VS1_TAG_EmployeeID]   := aUser.employeeID;
                aResultJson.S[VS1_TAG_Employeename] := TEmployee.idtoggle(aUser.employeeID);

                try Do_VS1_dashboard_Employee             ; Except On E:Exception do begin  aResultJson.S['1->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_Employee    ] := E.message;  end; end;
                try Do_VS1_dashboard_EmployeePicture      ; Except On E:Exception do begin  aResultJson.S['2->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_EmpPicture  ] := E.message;  end; end;
                try Do_VS1_dashboard_EmployeeAccessLevel  ; Except On E:Exception do begin  aResultJson.S['3->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_EmpAccess   ] := E.message;  end; end;
                try Do_VS1_dashboard_TransTableLastUpdated; Except On E:Exception do begin  aResultJson.S['4->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_LastSumDate ] := E.message;  end; end;
                try Do_VS1_dashboard_ap_report            ; Except On E:Exception do begin  aResultJson.S['5->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_AP_report   ] := E.message;  end; end;
                try Do_VS1_dashboard_pnl_period           ; Except On E:Exception do begin  aResultJson.S['6->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_PnL_report  ] := E.message;  end; end;
                try Do_VS1_dashboard_saleslist            ; Except On E:Exception do begin  aResultJson.S['7->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_SalesList   ] := E.message;  end; end;
                try Do_VS1_dashboard_salesperemployee     ; Except On E:Exception do begin  aResultJson.S['8->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_SalesPerEmp ] := E.message;  end; end;
                try Do_VS1_Dashboard_Summary              ; Except On E:Exception do begin  aResultJson.S['9->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_Summary     ] := E.message;  end; end;
//                try Do_VS1_Dashboard_Summary2             ; Except On E:Exception do begin  aResultJson.S['10->'+VS1_TAG_DashboardError+'_'+VS1_TAG_Dashboard_Summary2   ] := E.message;  end; end;

                aResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                AddEventdata(fOnEvent, TAG_Obj, aResultJson.AsString, True, aUser.ClassName);
              end;
            finally
              aResultJson.free;
            end;
          end else begin
            aResultJson.I[TAG_ResponseNo]     := VS1_HTTP_Failed_Code; { "NO DATA" }
            aResultJson.S[TAG_ResponseStatus] := aUser.logon_name + ' User Doesn''t exists';
          end;
        finally
          free;
        end;
      finally
        Freeandnil(objconn);
      end;
    finally
      JSONSerialiser.free;
    end;
  finally
    params.free;
  end;
end;

Procedure TVS1CloudTaskThread.TransactionTableObjOnLog(const msg: string; LogType: TLogMessageType)  ;
begin
  AddEventdata(fOnEvent ,TAG_ResponseTask+'_'+trim(inttostr(AProcessCtr))     , LogMessageTypeToStr(LogType) + ' > ' + msg, true);
  AProcessCtr := AProcessCtr +1;
end;

Procedure TVS1CloudTaskThread.VS1_BatchUpdate;
var
  TransactionTableObj: TTransactionTableObj;
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, TASK_VS1_BatchUpdate, true);
  try
    Appenv.CompanyPrefs.BatchUpdateInProgress := False;
    TransactionTableObj := TTransactionTableObj.Create(False);
    try
      AProcessCtr := 1;
      TransactionTableObj.onLog := TransactionTableObjOnLog;
      TransactionTableObj.SetEmptyGlobalRef;
      if Terminated then begin
        AddEventdata(fOnEvent, TAG_ResponseStatus, 'Stopping Batch Update, task is terminating.', True);
        AddEventdata(fOnEvent, TAG_ResponseError, 'Stopping Batch Update, task is terminating.', True);
        Exit;
      end;
      AddEventdata(fOnEvent, TAG_ResponseTask, 'Batch Update: ' + fConn.Database, True);
      if not TransactionTableObj.CleanRefreshTrnsTable(True, False, True, True) then begin
        AddEventdata(fOnEvent, TAG_ResponseStatus, 'Batch Update Failed.', True);
        AddEventdata(fOnEvent, TAG_ResponseError, 'Batch Update Failed.', True);
        Exit;
      end;
    finally
      AProcessCtr := 1;
      FreeandNil(TransactionTableObj);
    end;
    OnStatus(VS1_HTTP_Success_STRCode, 'Finished Batch Update on Database ' + fconn.database);
  except
    on e: exception do begin
      AddEventdata(fOnEvent, TAG_ResponseStatus, 'Batch Update Error : ' + e.message, True);
      AddEventdata(fOnEvent, TAG_ResponseError, 'Batch Update Error : ' + e.message, True);
    end;
  end;
end;

procedure TVS1CloudTaskThread.VS1_Logon;
var
  Params : TJsonObject;
  aVS1_ClientUsers : TVS1_ClientUsers;
  fsClientEmployeeAccessLevel : String;
  jsClientEmployeeAccessLevel : TJsonObject;
  ctr:Integer;
  RegionalOption : TRegionalOptions;
  jsResponse, js : TJsonObject;
  EmailID, Passwd, DBName: String;
begin
  AddEventdata(fOnEvent, TAG_ResponseTask, 'VS1 Login');
  Params := JO(fParams);
  try
    try
      aVS1_ClientUsers := TVS1_ClientUsers.Create(nil);
      try
        aVS1_ClientUsers.Connection := TMyDAcDataconnection.Create(aVS1_ClientUsers);
        aVS1_ClientUsers.Connection.Connection := fConn;

        EmailID := Params.O[TAG_CLOUD_Params].S[VS1_TAG_VS1UserName];
        Passwd := Params.O[TAG_CLOUD_Params].S[VS1_TAG_VS1Password];
        DBName := '';
        if Params.O[TAG_CLOUD_Params].Exists(VS1_TAG_VS1Password) then
          DBName := Params.O[TAG_CLOUD_Params].S[VS1_TAG_VS1Database];

        aVS1_ClientUsers.LoadSelect('EmailId = ' + QuotedStr(EmailID) + ' AND Password = ' + QuotedStr(Passwd));
        if aVS1_ClientUsers.Count = 0 then begin
          OnStatus(VS1_HTTP_Failed_STRCode,'User Credentials Invalid');
          Exit;
        end;

        AddEventdata(fOnEvent, VS1_TAG_ClientUserID, InttoStr(aVS1_ClientUsers.ID), True);

        if aVS1_ClientUsers.VS1_Client.ClientUsers.Locate('IsAdminUser', 'T', []) then begin
          AddEventdata(fOnEvent, VS1_TAG_VS1AdminUserName, aVS1_ClientUsers.VS1_Client.ClientUsers.EmailId, True);
        end;

        with aVS1_ClientUsers.VS1_Client.VS1_ClientLicenseDetails[0, DBName] do begin
          if Count > 0 then begin
            First;
            AddEventdata(fOnEvent, VS1_TAG_ServerName     , ServerName, True);
            AddEventdata(fOnEvent, VS1_TAG_APIPort        , InttoStr(APIPort), True);
            AddEventdata(fOnEvent, VS1_TAG_DatabaseName   , Databasename, True);
            AddEventdata(fOnEvent, VS1_TAG_RegionName     , Regionname, True);
            //if IsHttps then AddEventdata(fOnEvent ,VS1_TAG_HTTPS     , 'True', true)
            //else AddEventdata(fOnEvent ,VS1_TAG_HTTPS     , 'False', true);
            AddEventdata(fOnEvent ,VS1_TAG_LicenseFrom    , FormatdateTime('yyyy-mm-dd', LicenseFrom), True);
            AddEventdata(fOnEvent ,VS1_TAG_LicenseUntil   , FormatdateTime('yyyy-mm-dd', LicenseUntil), True);
            AddEventdata(fOnEvent ,VS1_TAG_LicenseLevel   , LicenseLevelDesc, True);

            RegionalOption := TRegionalOptions.create(aVS1_ClientUsers);
            try
              RegionalOption.LoadSelect('Region=' + QuotedStr(Regionname));
              if RegionalOption.count > 0 then begin
                jsResponse := JO;
                try
                  jsResponse.S[VS1_TAG_CurrencySymbol]      := RegionalOption.CurrencySymbol;
                  jsResponse.S[VS1_TAG_WholeCurrencyName]   := RegionalOption.WholeCurrencyName;
                  jsResponse.S[VS1_TAG_DecimalCurrencyName] := RegionalOption.DecimalCurrencyName;
                  jsResponse.I[VS1_TAG_DecimalPlaces]       := RegionalOption.DecimalPlaces;
                  jsResponse.S[VS1_TAG_ShortDateformat]     := RegionalOption.ShortDateformat;
                  jsResponse.S[VS1_TAG_DateSeparator]       := RegionalOption.DateSeparator;
                  AddEventdata(fOnEvent, TAG_Obj, jsResponse.asString, True, VS1_Class_RegionalOptions);
                finally
                  jsResponse.free;
                end;
              end;
            finally
              Freeandnil(RegionalOption);
            end;

            jsResponse := JO;
            try
              While EOF = False do begin
                js := JO;
                js.B[VS1_TAG_ExtraModules]   := ExtraModule;
                js.S[VS1_TAG_ModuleName]     := ModuleName;
                js.B[VS1_TAG_ModuleActive]   := ModuleActive;
                js.I[VS1_TAG_ModuleQuantity] := ModuleQty;
                jsResponse.A[VS1_TAG_Modules].Add(js);
                Next;
              end;
              AddEventdata(fOnEvent, TAG_Obj, jsResponse.asString, true, VS1_TAG_Modules);
            finally
              jsResponse.free;
            end;

//            if ClientEmployeeAccessLevel(aVS1_ClientUsers, fsClientEmployeeAccessLevel, fOnEvent) then begin
//              fsClientEmployeeAccessLevel := replacestr(fsClientEmployeeAccessLevel, '"temployeeformaccessdetail"' , '"'+VS1_TAG_AccessLevels+'"');
//              AddEventdata(fOnEvent, TAG_Obj, fsClientEmployeeAccessLevel, True, VS1_TAG_ClientDetails);
//            end;
          end else begin
            OnStatus(VS1_HTTP_Failed_STRCode, 'Payment is Due');
            Exit;
          end;
        end;

        OnStatus(VS1_HTTP_Success_STRCode, 'OK');
      finally
        freeandnil(aVS1_ClientUsers);
      end;
    Except
      on E:Exception do begin
        AddEventdata(fOnEvent, TAG_ResponseError, E.message);
      end;
    end;
  finally
    Params.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_SequenceList;
var
  ResultJSON, RowJSON: TJSONObject;
  TableJSON: TJSONArray;
  MaxID: Integer;
  TableName1, TableName2, TableName3: string;
  ScriptMain: TERPScript;
  TempQuery: TERPQuery;
  Params: TJSONObject;
  DateFrom, DateTo: string;
begin
  Params := JO(fParams);
  DateFrom := '1970-01-01';
  DateTo := '2050-12-30';
  if Params.Exists(TAG_CLOUD_Params) and Params.O[TAG_CLOUD_Params].Exists('DateFrom') then
    DateFrom := Params.O[TAG_CLOUD_Params].S['DateFrom'];

  if Params.Exists(TAG_CLOUD_Params) and Params.O[TAG_CLOUD_Params].Exists('DateTo') then
    DateTo := Params.O[TAG_CLOUD_Params].S['DateTo'];

  ResultJSON := JO;

  TableName1 := commondbLib.CreateUserTemporaryTable('tmp_NumberSequenceList', '1');
  TableName2 := commondbLib.CreateUserTemporaryTable('tmp_NumberSequenceList', '2');
  TableName3 := commondbLib.CreateUserTemporaryTable('tmp_NumberSequenceList', '');

  Sleep(2000);

  ScriptMain := TERPScript.Create(nil);
  try
    With ScriptMain do begin
      ScriptMain.Connection := AppEnv.AppDb.Connection;

      SQL.Clear;
      SQL.Add('TRUNCATE ' + TableName1 + ';');
      SQL.Add('TRUNCATE ' + TableName2 + ';');
      SQL.Add('TRUNCATE ' + TableName3 + ';');

      SQL.Add('INSERT INTO ' + TableName1 + ' (TransType, TransactionNo, GlobalRef, TransDate, TransactionType, EmployeeName, TransStatus) ' +
              ' SELECT "S", ' +
              ' tblSales.SaleId as TransactionNo, ' +
              ' tblSales.GlobalRef AS GlobalRef, ' +
              ' DATE(IF(IFNULL(tblSales.SaleDate, 0)=0, tblSales.mstimeStamp, tblSales.SaleDate)) AS TransDate, ' +
              ' IF(tblSales.IsCashSale="T" AND tblSales.IsPOS="F", "Cash Sale", ' +
              ' IF(tblSales.IsRefund="T", "Refund", ' +
              ' IF(tblSales.IsCashSale="T" AND tblSales.IsPOS="T", "POS", ' +
              ' IF(tblSales.IsInvoice="T", "Invoice", ' +
              ' IF(tblSales.IsQuote="T", "Quote", "Sales Order"))))) AS TransactionType, ' +
              ' tblSales.EmployeeName AS EmployeeName, ' +
              ' IF(tblSales.Cancelled="T", "Cancelled", IF(tblSales.Deleted="T", "Deleted", "Active")) AS TransStatus ' +
              ' FROM tblSales ' +
              ' ORDER BY TransactionNo;');

      SQL.Add('INSERT INTO ' + TableName1 + ' (TransType, TransactionNo, GlobalRef, TransDate, TransactionType, EmployeeName, TransStatus) ' +
              ' SELECT "P", ' +
              ' tblpurchaseorders.PurchaseOrderID AS TransactionNo, ' +
              ' tblpurchaseorders.GlobalRef AS GlobalRef, ' +
              ' DATE(IF(IFNULL(tblpurchaseorders.OrderDate, 0)=0, tblpurchaseorders.mstimeStamp, tblpurchaseorders.OrderDate)) AS TransDate, ' +
              ' IF(tblpurchaseorders.IsPO="T", "Purchase Order", ' +
              ' IF(tblpurchaseorders.IsRA="T", "Return Authority", ' +
              ' IF(tblpurchaseorders.IsBill="T", "Bill", ' +
              ' IF(tblpurchaseorders.IsCredit="T", "Credit", ' +
              ' IF(tblpurchaseorders.IsCheque="T", "Cheque", "PO Credit"))))) AS TransactionType, ' +
              ' tblpurchaseorders.EmployeeName AS EmployeeName, ' +
              ' IF(tblpurchaseorders.Cancelled="T", "Cancelled", IF(tblpurchaseorders.Deleted="T", "Deleted", "Active")) AS TransStatus ' +
              ' FROM tblpurchaseorders ' +
              ' ORDER BY TransactionNo;');

      SQL.Add('INSERT INTO ' + TableName1 + ' (TransType, TransactionNo, GlobalRef, TransDate, TransactionType, EmployeeName, TransStatus) ' +
              ' SELECT "R", ' +
              ' R.RepairID AS TransactionNo, ' +
              ' R.GlobalRef AS GlobalRef, ' +
              ' DATE(IF(IFNULL(R.CreationDate, 0)=0, R.mstimeStamp, R.CreationDate)) AS TransDate, ' +
              ' "Repairs" AS TransactionType, ' +
              ' E.EmployeeName AS EmployeeName, ' +
              ' IF(R.Cancelled="T", "Cancelled", "Active") AS TransStatus ' +
              ' FROM tblrepairs R INNER JOIN tblemployees E ON R.employeeId=E.employeeID ' +
              ' ORDER BY TransactionNo;');

      Execute;

      TempQuery := TERPQuery.Create(nil);
      try
        TempQuery.Connection := AppEnv.AppDb.Connection;
        TempQuery.SQL.Clear;
        TempQuery.SQL.Add('select * from tblnumbersequencelistseqno');
        TempQuery.Open;

        SQL.Clear;

        while not TempQuery.Eof do begin
          SQL.Add('TRUNCATE ' + TableName2 + ';');
          SQL.Add('ALTER TABLE ' + TableName2 + ' AUTO_INCREMENT = ' + IntToStr(TempQuery.FieldByname('SeqnoTostart').AsInteger) + ';');
          SQL.Add('INSERT INTO ' + TableName2 + ' (TransType, TransactionNo, GlobalRef, TransDate, TransactionType, EmployeeName, TransStatus) SELECT TransType, TransactionNo, GlobalRef, TransDate, TransactionType, EmployeeName, TransStatus FROM ' + TableName1 + ' WHERE TransactionType=' + QuotedStr(TempQuery.Fieldbyname('TransactionType').AsString) + ';');
          SQL.Add('INSERT INTO ' + TableName3 + ' (SeqNo, TransType, TransactionNo, GlobalRef, TransDate, TransactionType, EmployeeName, TransStatus) SELECT ID, TransType, TransactionNo, GlobalRef, TransDate, TransactionType, EmployeeName, TransStatus FROM ' + TableName2 + ';');
          TempQuery.Next;
        end;

        Execute;
      finally
        TempQuery.Free;
      end;
    end;

    TableJSON := TJSONArray.Create();
    try
      TempQuery := TERPQuery.Create(nil);
      try
        with TempQuery do begin
          Connection := AppEnv.AppDb.Connection;
          SQL.Clear;
          SQL.Add(' SELECT');
          SQL.Add('`ID` AS `ID`,');
          SQL.Add('`TransType` AS `TransType`,');
          SQL.Add('`TransactionNo` AS `TransactionNo`,');
          SQL.Add('`GlobalRef` AS `GlobalRef`,');
          SQL.Add('`TransDate` AS `TransDate`,');
          SQL.Add('`TransactionType` AS `TransactionType`,');
          SQL.Add('`EmployeeName` AS `EmployeeName`,');
          SQL.Add('`TransStatus` AS `TransStatus`,');
          SQL.Add('`Seqno` AS `Seqno`');
          SQL.Add('FROM ' + TableName3);
          SQL.Add('WHERE TransDate BETWEEN ' + QuotedStr(DateFrom) + ' AND ' + QuotedStr(DateTo));
          SQL.Add('ORDER BY TransactionNo, TransactionType');
          Open;

          while not Eof do begin
            RowJSON := JO;
            RowJSON.I['ID'] := FieldByName('ID').AsInteger;
            RowJSON.S['TransType'] := FieldByName('TransType').AsString;
            RowJSON.I['TransactionNo'] := FieldByName('TransactionNo').AsInteger;
            RowJSON.S['GlobalRef'] := FieldByName('GlobalRef').AsString;
            RowJSON.DT['TransDate'] := FieldByName('TransDate').AsDateTime;
            RowJSON.S['TransactionType'] := FieldByName('TransactionType').AsString;
            RowJSON.S['EmployeeName'] := FieldByName('EmployeeName').AsString;
            RowJSON.S['TransStatus'] := FieldByName('TransStatus').AsString;
            RowJSON.I['SeqNo'] := FieldByName('Seqno').AsInteger;

            TableJSON.Add(RowJSON);
            Next;
          end;

          Close;
        end;

      finally
        TempQuery.Free;
      end;

      ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
      ResultJson.A['NumberSequence'] := TableJSON;
      AddEventdata(fOnEvent, TAG_Obj, ResultJson.AsString, true);
    finally
      TableJSON.Free;
    end;

    ScriptMain.SQL.Clear;
    ScriptMain.SQL.Add('DROP TABLE IF EXISTS ' + TableName1 + ';');
    ScriptMain.SQL.Add('DROP TABLE IF EXISTS ' + TableName2 + ';');
    ScriptMain.SQL.Add('DROP TABLE IF EXISTS ' + TableName3 + ';');
    ScriptMain.Execute;

  finally
    ScriptMain.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_NextTransID;
var
  Params: TJSONObject;
  NextID: Integer;
  TransType: string;
  TempQuery: TERPQuery;
begin
  Params := JO(fParams);
  TransType := 'S';
  if Params.Exists(TAG_CLOUD_Params) and Params.O[TAG_CLOUD_Params].Exists('TransType') then
    TransType := Params.O[TAG_CLOUD_Params].S['TransType'];

  TempQuery := TERPQuery.Create(nil);
  try
    with TempQuery do begin
      Connection := AppEnv.AppDb.Connection;
      SQL.Clear;
      if TransType = 'P' then begin
        AddEventdata(fOnEvent, 'TransType', 'Purchase', true);
        SQL.Add('SELECT Max(PurchaseOrderID) AS NextID FROM tblpurchaseorders');
      end
      else begin
        AddEventdata(fOnEvent, 'TransType', 'Sales', true);
        SQL.Add('SELECT Max(SaleID) AS NextID FROM tblsales');
      end;

      Open;
      NextID := FieldByName('NextID').AsInteger + 1;
    end;

  finally
    TempQuery.Free;
  end;

  AddEventdata(fOnEvent, 'NextID', IntToStr(NextID), true);
end;

procedure TVS1CloudTaskThread.VS1_Test;
begin
  Log('Wang - Log Test', ltInfo);
  AddEventdata(fOnEvent, TAG_ResponseStatus, 'Test Success', True);
end;

procedure TVS1CloudTaskThread.LogConn;
begin
  Exit; // remove for debugging
  if fconn = nil then exit;
  AddEventdata(fOnEvent ,TAG_ResponseTask     , '========', true);

  if fconn.Connected then  AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Connected', true) else AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Not Connected', true);
  AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Server: ' +fconn.Server, true);
  AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Database: ' +fconn.Database, true);
  AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Username: ' +fconn.Username, true);
  AddEventdata(fOnEvent ,TAG_ResponseTask     , 'Password: ' +fconn.Password, true);
  if fconn.Connected then  AddEventdata(fOnEvent ,TAG_ResponseTask     , appenv.Employee.EmployeeName);

  AddEventdata(fOnEvent ,TAG_ResponseTask     , '========', true);
end;

Procedure TVS1CloudTaskThread.VS1_NewRego;
var
  Params: TJSONObject;
  VS1_Rego: TVS1_Rego;
begin
  LogConn;
  AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 Rego', true);
  Params := JO(fParams);
  try
    AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 Rego-1', true);
    try
      VS1_Rego := TVS1_Rego.Create(nil, fconn);
      try
        AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 Rego-2', true);
        try
          InitVS1Rego(VS1_Rego, Params);
        Except
          on E:Exception do begin
            AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 Rego-3' + '===' + e.message, true);
          end;
        end;
        try
          VS1_Rego.VS1_NewRego(fOnEvent, fLogger);
        Except
          on E:Exception do begin
            AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 Rego-4'+ '===' + e.message, true);
          end;
        end;
        Terminate;
      finally
        Freeandnil(VS1_Rego);
      end;
    Except
      on E:Exception do begin
        AddEventdata(fOnEvent, TAG_ResponseTask, 'New VS1 Rego-1' + '===' + e.message, true);
      end;
    end;
  finally
    Params.Free;
  end;
end;

// Wang added
procedure TVS1CloudTaskThread.VS1_DatabaseBackup;
var
  Params, ResultJson, aParams: TJSONObject;
  Resp: string;
begin

  Params:= TJSONObject.Create;
  Params.S['UserName'] := AppEnv.AppDb.UserName;
  aParams := JO(fParams);
  try
    if aparams.exists(TAG_JsonIN) then
      if aparams.O[TAG_JsonIN].exists(TAG_DatabaseName) then
        Params.S[TAG_DatabaseName] := aparams.O[TAG_JsonIN].s[TAG_DatabaseName];
  finally
    aParams.free;
  end;
  if Params.S[TAG_DatabaseName] = '' then Params.S[TAG_DatabaseName] := AppEnv.AppDb.Database;
  Params.S['Operation'] := 'Backup';

  try
    AppEnv.UtilsClient.Client.Connected := True;

    ResultJson := AppEnv.UtilsClient.Client.SendRequest('UserUtils.dbbackup', Params);

    if Assigned(ResultJson) then
      AddEventData(fOnEvent, TAG_ResponseStatus, 'Backing up Database in Progress.  '+
                                                 'This Process can take upto 2 hours.  '(*+
                                                 'Please check the backup folder for the backup file.  '+
                                                 'Backup is .7z file and the name Will start with "' + AppEnv.AppDb.Database+'_'+AppEnv.AppDb.TableVersion+'_Backup_'+Formatdatetime('yyyy-mm-dd',date)+'".'*), True)
    else
      AddEventData(fOnEvent, TAG_ResponseError, 'Error while backing up', True);

  except
    on E:Exception do begin
      AddEventData(fOnEvent, TAG_ResponseError, 'Database backup, UtilsClient Connection' + '===' + e.message, true);
    end;
  end;

  Params.Free;
end;

procedure TVS1CloudTaskThread.VS1_DatabaseRestore;
var
  Params, ResultJson: TJSONObject;
  Resp: string;
begin
  Params := JO(fParams);
  Params.S['UserName'] := AppEnv.AppDb.UserName;
  if Params.S[TAG_DatabaseName] ='' then Params.S[TAG_DatabaseName] := AppEnv.AppDb.Database;
  Params.S['ArchiveName'] := Params.S['ArchiveName']; // For certain
  Params.S['Operation'] := 'Restore';

  try
    AppEnv.UtilsClient.Client.Connected := true;

    ResultJson := AppEnv.UtilsClient.Client.SendRequest('UserUtils.dbbackup', Params);
    if Assigned(ResultJson) then
      AddEventData(fOnEvent, TAG_ResponseStatus, 'Restoring Database in Progress.  '+
                                                 'This Process can take upto 2 hours.  '(*+
                                                 'Please Check Utilities Log on "ERP Service Menu" for progress.'*), True)
    else
      AddEventData(fOnEvent, TAG_ResponseError, 'Error while restoring', True);

  except
    on E:Exception do begin
      AddEventData(fOnEvent, TAG_ResponseError, 'DatabaseRestore, UtilsClient Connection' + '===' + e.message, true);
    end;
  end;

  Params.Free;
end;

procedure TVS1CloudTaskThread.VS1_BackupList;
var
  Params,aParams, ResultJson, BFile, Response: TJSONObject;
  LDatabase, LBackupList : string;
  LSList : TStringList;
  I: Integer;
  AllDBBackups :Boolean;
begin
  Params := JO;
  Response := JO;
  try
    AppEnv.UtilsClient.Client.Connected := true;

    ResultJson := AppEnv.UtilsClient.Client.SendRequest('UserUtils.getbackuparchivelist', Params);
    if Assigned(ResultJson) then begin
      try
        if ResultJson.ObjectExists('error') then begin
          AddEventdata(fOnEvent, TAG_ResponseTask, 'Database backup, Erro' + '===' + ResultJson.O['error'].S['message'], True);
          Exit;
        end
        else begin
          LBackupList := ResultJson.S['result'];
          AllDBBackups := False;
          LDatabase := '';
          aParams := JO(fParams);
            try
              if aparams.exists(TAG_JsonIN) then begin
                if aparams.O[TAG_JsonIN].exists(TAG_DatabaseName) then
                  LDatabase :=  aparams.O[TAG_JsonIN].s[TAG_DatabaseName];

                if aparams.O[TAG_JsonIN].exists('AllDBBackups') then
                  AllDBBackups :=  aparams.O[TAG_JsonIN].B['AllDBBackups'];
              end;
          finally
              aParams.free;
          end;
          if LDatabase = '' then LDatabase := AppEnv.AppDb.Database;
          //if LDatabase <> '' then begin
            LSList := TStringList.Create;
            try
              LDatabase := Lowercase(LDatabase);
              LSList.CommaText := LBackupList;
              I := 0;
              while I < LSList.Count do begin
                if AllDBBackups or (Pos(LDatabase, LSList[I]) = 1) then begin
                  BFile := JO;
                  BFile.S['FileName'] := LSList[I];
                  Response.A['Files'].Add(BFile);
                end;

                Inc(I);
              end;
            finally
              LSList.Free;
            end;
          //end;
        end;
      finally
        ResultJson.Free;
      end;
    end
    else begin
      AddEventdata(fOnEvent, TAG_ResponseError, 'BackupList, No reponse from server', True);
      exit;
    end;
  except
    on E:Exception do begin
      AddEventdata(fOnEvent, TAG_ResponseError, 'BackupList, UtilsClient Connection' + '===' + e.message, True);
    end;
  end;

  AddEventdata(fOnEvent, TAG_Obj, Response.AsString, True, VS1_TAG_BackupList);

  Response.Free;
//  Params.Free;
end;

procedure TVS1CloudTaskThread.VS1_PNLGetLayout;
var
  Params: TJSONObject;
  Response: TJSONObject;
  qryTemp : TERPQuery;
  iLevel, K: Integer;
  oLine : TJSONObject;
  iLayoutID: Integer;
begin
  Params := JO(fParams);
  try
    iLayoutID := 0;
    if Params.O[TAG_CLOUD_Params].Exists('LayoutID') then
      iLayoutID := Params.O[TAG_CLOUD_Params].I['LayoutID'];

    if iLayoutID > 0 then begin
      Response := JO;
      try
        // Get layout data from table
        qryTemp := TERPQuery.Create(nil);
        try
          with qryTemp do begin
            Connection := Appenv.AppDb.Connection;

            SQL.Clear;
            SQL.Add('SELECT Max(Length(Pos) DIV 2) AS MLevel FROM tblPnLLayoutData3 WHERE LayoutID=' + IntToStr(iLayoutID));
            Open;
            iLevel := FieldByName('MLevel').AsInteger;

            SQL.Clear;
            SQL.Add('SELECT (@row:=@row + 1) AS No, ID, Pos, Parent, IsRoot,');
            for K := 1 to iLevel - 1 do begin
              SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(K) + ',');
            end;
            SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(iLevel));
            SQL.Add('FROM tblPnLLayoutData3, (SELECT @row:=0) Dummy');
            SQL.Add('WHERE LayoutID=' + IntToStr(iLayoutID) + ' ORDER BY Pos');
            Open;

            while not EOF do begin
              oLine := JO;
              oLine.I['ID'] := FieldByName('ID').AsInteger;
              oLine.S['Pos'] := FieldByName('Pos').AsString;
              oLine.I['Parent'] := FieldByName('Parent').AsInteger;
              oLine.B['IsRoot'] := FieldByName('IsRoot').AsBoolean;
              for K := 1 to iLevel do begin
                oLine.S['Level' + IntToStr(K)] := FieldByName('Level' + IntToStr(K)).AsString;
              end;

              Response.A['Lines'].Add(oLine);

              Next;
            end;
          end;
        finally
          qryTemp.Free;
        end;

        AddEventdata(fOnEvent, TAG_Obj, Response.AsString, True, VS1_TAG_PNLLayout);

      finally
        Response.Free;
      end;
    end;

  finally
    Params.Free;
  end;

end;

procedure TVS1CloudTaskThread.VS1_PNLMoveAccount;
var
  Params, Response: TJSONObject;
  qryMain, qryTemp : TERPQuery;
  iSelID, iDestID : Integer;
  K : Integer;
  sPPos, sNewPos, sOldPos : string;
  iCnt : Integer;
  iLevel, iLen : Integer;
  bExist : Boolean;
  iPos : Integer;
  iLayoutID: Integer;
begin
  Params := JO(fParams);
  try
    iSelID := Params.I['Selected'];
    iDestID := Params.I['Destination'];
    iLayoutID := Params.I['LayoutID'];
    if iLayoutID < 1 then Exit;

    MoveAccount(iSelID, iDestID, iLayoutID);
  finally
    Params.Free;
  end;
end;

procedure TVS1CloudTaskThread.MoveAccount(ASelID, ADestID, ALayoutID: Integer);
var
  qryMain, qryTemp : TERPQuery;
  K : Integer;
  sPPos, sNewPos, sOldPos : string;
  iCnt : Integer;
  iLevel, iLen : Integer;
  bExist : Boolean;
  iPos : Integer;
begin
  qryTemp := TERPQuery.Create(nil);
  qryMain := TERPQuery.Create(nil);

  try
    // Get max level
    with qryTemp do begin
      Connection := Appenv.AppDb.Connection;
      SQL.Clear;
      SQL.Add('SELECT Max(Length(Pos) DIV 2) AS MLevel FROM tblPnLLayoutData3 WHERE LayoutID=' + IntToStr(ALayoutID));
      Open;
      iLevel := FieldByName('MLevel').AsInteger;
      Close;
    end;

    // Prepare SQL for main grid
    with qryMain do begin
      Connection := Appenv.AppDb.Connection;
      SQL.Clear;
      SQL.Add('SELECT (@row:=@row + 1) AS No, ID, Pos, Parent, IsRoot,');
      for K := 1 to iLevel - 1 do begin
        SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(K) + ',');
      end;
      SQL.Add('IF(LENGTH(Pos) = ' + IntToStr(K * 2) + ', `Name`, "") AS Level' + IntToStr(iLevel));
      SQL.Add('FROM tblPnLLayoutData3, (SELECT @row:=0) Dummy');
      SQL.Add('WHERE LayoutID=' + IntToStr(ALayoutID));
      SQL.Add('ORDER BY Pos');
      // Load data
      Open;
    end;

    with qryTemp do begin
      // Get target parent's pos
      SQL.Clear;
      SQL.Add('SELECT Pos FROM tblPnLLayoutData3 WHERE ID=' + IntToStr(ADestID) + ' AND LayoutID=' + IntToStr(ALayoutID));
      Open;
      sPPos := FieldByName('Pos').AsString;

      // Count my siblings
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS Cnt FROM tblPnLLayoutData3 WHERE Parent=' + IntToStr(ADestID) + ' AND LayoutID=' + IntToStr(ALayoutID));
      Open;
      iCnt := FieldByName('Cnt').AsInteger;

      // Get pos of siblings
      SQL.Clear;
      SQL.Add('SELECT SUBSTRING(Pos, Length("' + sPPos + '") + 1, 2) AS IDX FROM tblPnLLayoutData3 WHERE Parent=' + IntToStr(ADestID) + ' AND LayoutID=' + IntToStr(ALayoutID));
      Open;

      for K := 1 to iCnt + 1 do begin
        bExist := False;
        First;
        while not EOF do begin
          if K = FieldByName('IDX').AsInteger then begin
            bExist := True;
            Break;
          end;
          Next;
        end;

        if not bExist then begin
          iPos := K;
          Break;
        end;
      end;

      // Set my pos anew
      SQL.Clear;
      sNewPos := sPPos + Format('%.*d', [2, iPos]);
      SQL.Add('UPDATE tblPnLLayoutData3 SET Pos="' + sNewPos +'" WHERE ID=' + IntToStr(ASelID) + ' AND LayoutID=' + IntToStr(ALayoutID));
      Execute;

      // Change parent of mine
      SQL.Clear;
      SQL.Add('UPDATE tblPnLLayoutData3 SET Parent=' + IntToStr(ADestID) + ' WHERE ID=' + IntToStr(ASelID) + ' AND LayoutID=' + IntToStr(ALayoutID));
      Execute;

      // Change my offsprings' pos
      with qryMain do begin
        Locate('ID', ASelID, []);
        sOldPos := FieldByName('Pos').AsString;
        iLen := Length(sOldPos);
        while True do begin
          Next;
          if LeftStr(FieldByName('Pos').AsString, iLen) <> sOldPos then Break;

          // Replace the prefix of pos
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add('UPDATE tblPnLLayoutData3 SET Pos=CONCAT("' + sNewPos + '", RIGHT(Pos, LENGTH(Pos) - ' + IntToStr(Length(sOldPos)) + ')) WHERE ID=' + IntToStr(FieldByName('ID').AsInteger) + ' AND LayoutID=' + IntToStr(ALayoutID));
          qryTemp.Execute;
        end;
      end;
    end;

  finally
    qryMain.Free;
    qryTemp.Free;
  end;

  // Send the changed layout;
  //VS1_PNLGetLayout;
end;

procedure TVS1CloudTaskThread.VS1_PNLAddGroup;
var
  Params : TJSONObject;
  iDestID : Integer;
  sGName : string;
  qryTemp : TERPQuery;
  sPPos : string;
  K, iCnt, iPos : Integer;
  bExist : Boolean;
  iLayoutID: Integer;
begin
  Params := JO(fParams);
  try
    iDestID := Params.I['Destination'];
    sGName := Params.S['GroupName'];
    iLayoutID := Params.I['LayoutID'];

    qryTemp := TERPQuery.Create(nil);
    try
      qryTemp.Connection := Appenv.AppDb.Connection;
      with qryTemp do begin
        // Get target parent's pos
        SQL.Clear;
        SQL.Add('SELECT Pos FROM tblPnLLayoutData3 WHERE ID=' + IntToStr(iDestID) + ' AND LayoutID=' + IntToStr(iLayoutID));
        Open;
        sPPos := FieldByName('Pos').AsString;

        // Count my siblings
        SQL.Clear;
        SQL.Add('SELECT COUNT(*) AS Cnt FROM tblPnLLayoutData3 WHERE Parent=' + IntToStr(iDestID) + ' AND LayoutID=' + IntToStr(iLayoutID));
        Open;
        iCnt := FieldByName('Cnt').AsInteger;

        // Get pos of siblings
        SQL.Clear;
        SQL.Add('SELECT SUBSTRING(Pos, Length("' + sPPos + '") + 1, 2) AS IDX FROM tblPnLLayoutData3 WHERE Parent=' + IntToStr(iDestID) + ' AND LayoutID=' + IntToStr(iLayoutID));
        Open;

        for K := 1 to iCnt + 1 do begin
          bExist := False;
          First;
          while not EOF do begin
            if K = FieldByName('IDX').AsInteger then begin
              bExist := True;
              Break;
            end;
            Next;
          end;

          if not bExist then begin
            iPos := K;
            Break;
          end;
        end;

        // Insert a new record to the target group
        SQL.Clear;
        SQL.Add('INSERT INTO tblPnLLayoutData3 (Parent, Pos, `Name`, LayoutID) VALUES (:parent, :pos, :name, :lid)');
        Params.ParamByName('parent').Value := iDestID;
        Params.ParamByName('pos').Value :=  sPPos + Format('%.*d', [2, iPos]);
        Params.ParamByName('name').Value := sGName;
        Params.ParamByName('lid').Value :=  iLayoutID;
        Execute;

      end;
    finally
      qryTemp.Free;
    end;

  finally
    Params.Free;
    // Send the changed layout;
    //VS1_PNLGetLayout;
  end;

end;

procedure TVS1CloudTaskThread.VS1_PNLDeleteGroup;
var
  qryTemp : TERPQuery;
  Params : TJSONObject;
  iSelID : Integer;
  iPID : Integer;
  sPPos, sMyPos : string;
  iLen : Integer;
  chIDs : TList<Integer>;
  K : Integer;
  iLayoutID: Integer;
begin
  Params := JO(fParams);
  try
    iSelID := Params.I['Selected'];
    iLayoutID := Params.I['LayoutID'];

    qryTemp := TERPQuery.Create(nil);
    try
      qryTemp.Connection := Appenv.AppDb.Connection;
      with qryTemp do begin
        // Get parent's id, pos
        SQL.Clear;
        SQL.Add('SELECT Parent FROM tblPnLLayoutData3 WHERE ID=' + IntToStr(iSelID) + ' AND LayoutID=' + IntToStr(iLayoutID));
        Open;
        iPID := FieldByName('Parent').AsInteger;

        SQL.Clear;
        SQL.Add('SELECT Pos FROM tblPnLLayoutData3 WHERE ID=' + IntToStr(iPID) + ' AND LayoutID=' + IntToStr(iLayoutID));
        Open;
        sPPos := FieldByName('Pos').AsString;

        // Delete me
        SQL.Clear;
        SQL.Add('DELETE FROM tblPnLLayoutData3 WHERE ID=' + IntToStr(iSelID) + ' AND LayoutID=' + IntToStr(iLayoutID));
        Execute;

        // Get my children's ID
        chIDs := TList<Integer>.Create;

        SQL.Clear;
        SQL.Add('SELECT ID FROM tblPnLLayoutData3 WHERE Parent=' + IntToStr(iSelID) + ' AND LayoutID=' + IntToStr(iLayoutID));
        Open;
        while not EOF do begin
          chIDs.Add(FieldByName('ID').AsInteger);
          Next;
        end;

        // Move my children to new parent
        for K := 0 to chIDs.Count - 1 do begin
          MoveAccount(chIDs.Items[K], iPID, iLayoutID);
        end;

        chIDs.Free;
      end;
    finally
      qryTemp.Free;
    end;

  finally
    Params.Free;
    // Send the changed layout;
    //VS1_PNLGetLayout;
  end;

end;

procedure TVS1CloudTaskThread.VS1_PNLRenameGroup;
var
  Params : TJSONObject;
  iSelID : Integer;
  sGName : string;
  qryTemp : TERPQuery;
  iLayoutID: Integer;
begin
  Params := JO(fParams);
  try
    iSelID := Params.I['Selected'];
    sGName := Params.S['NewName'];
    iLayoutID := Params.I['LayoutID'];

    qryTemp := TERPQuery.Create(nil);
    try
      qryTemp.Connection := Appenv.AppDb.Connection;
      with qryTemp do begin
        SQL.Clear;
        SQL.Add('UPDATE tblPnLLayoutData3 SET `Name`=:name WHERE ID=:id AND LayoutID=:lid');
        Params.ParamByName('name').Value := sGName;
        Params.ParamByName('id').Value := iSelID;
        Params.ParamByName('lid').Value := iLayoutID;
        Execute;
      end;
    finally
      qryTemp.Free;
    end;

  finally
    Params.Free;
    // Send the changed layout;
    //VS1_PNLGetLayout;
  end;
end;

procedure TVS1CloudTaskThread.VS1_PNLGetGroups;
var
  Params: TJSONObject;
  Response: TJSONObject;
  qryTemp : TERPQuery;
  iLevel, K: Integer;
  oLine : TJSONObject;
  iLayoutID: Integer;
begin
  Params := JO(fParams);
  try
    iLayoutID := 0;
    if Params.O[TAG_CLOUD_Params].Exists('LayoutID') then
      iLayoutID := Params.O[TAG_CLOUD_Params].I['LayoutID'];

    if iLayoutID > 1 then begin
      Response := JO;
      try
        // Get groups
        qryTemp := TERPQuery.Create(nil);
        try
          qryTemp.Connection := Appenv.AppDb.Connection;
          with qryTemp do begin
            SQL.Clear;
            SQL.Add('SELECT ID, `Name` FROM tblPnLLayoutData3 WHERE IsAccount="F" AND LayoutID=' + IntToStr(iLayoutID));
            Open;

            while not EOF do begin
              oLine := JO;
              oLine.I['ID'] := FieldByName('ID').AsInteger;
              oLine.S['GName'] := FieldByName('Name').AsString;

              Response.A['Groups'].Add(oLine);
              Next;
            end;
          end;
        finally
          qryTemp.Free;
        end;

        AddEventdata(fOnEvent, TAG_Obj, Response.AsString, True, VS1_TAG_PNLGroupList);
      finally
        Response.Free;
      end;
    end;
  finally
    Params.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_SetCustomize;
var
  Params: TJSONObject;
  TableName: string;
  EmpID: Integer;
  Columns: string;
  ScriptMain: TERPScript;
  TempQuery: TERPQuery;
  SQLStr: string;
  Reset: Boolean;
begin
  Params := JO(fParams);

  if not Params.Exists('EmployeeID') or (Params.I['EmployeeID'] < 1) then begin
    AddEventdata(fOnEvent, TAG_ErrorMessage, 'No Employee ID', True);
    Exit;
  end;

  if not Params.Exists('TableName') or (Params.S['TableName'] = '') then begin
    AddEventdata(fOnEvent, TAG_ErrorMessage, 'No Table Name', True);
    Exit;
  end;

  if not Params.Exists('Columns') then begin
    AddEventdata(fOnEvent, TAG_ErrorMessage, 'No Columns', True);
    Exit;
  end;

  Reset := False;
  if Params.Exists('Reset') and Params.B['Reset'] then Reset := True;

  TableName := Params.S['TableName'];
  EmpID := Params.I['EmployeeID'];
  Columns := Params.A['Columns'].AsString;

  TempQuery := TERPQuery.Create(nil);
  TempQuery.Connection := AppEnv.AppDb.Connection;
  try
    TempQuery.SQL.Add('SELECT COUNT(*) AS CNT FROM tblpreferences');
    TempQuery.SQL.Add('WHERE PrefGroup="TablePrefs" AND PrefName=' + QuotedStr(TableName) + ' AND UserID=' + IntToStr(EmpID));
    TempQuery.Open;
    // Check if exists such a record
    if TempQuery.FieldByName('CNT').AsInteger = 0 then
      SQLStr := 'INSERT INTO tblpreferences SET PrefGroup="TablePrefs", PrefValue=' + QuotedStr(Columns) + ', PrefName=' + QuotedStr(TableName) + ', UserID=' + IntToStr(EmpID) + ';'
    else
      SQLStr := 'UPDATE tblpreferences SET PrefValue=' + QuotedStr(Columns) + ' WHERE PrefGroup="TablePrefs" AND UserID=' + IntToStr(EmpID) + ' AND PrefName=' + QuotedStr(TableName) + ';';

    if Reset then
      SQLStr := 'DELETE FROM tblpreferences WHERE PrefGroup="TablePrefs" AND UserID=' + IntToStr(EmpID) + ' AND PrefName=' + QuotedStr(TableName) + ';';

    ScriptMain := TERPScript.Create(nil);
    ScriptMain.Connection := AppEnv.AppDb.Connection;
    try
      with ScriptMain do begin
        SQL.Add(SQLStr);
        Execute;
      end;
    finally
      ScriptMain.Free;
      Params.Free
    end;
  finally
    TempQuery.Free;
  end;

  AddEventdata(fOnEvent, TAG_ResponseStatus, 'Customizaton saved', true);

end;

procedure TVS1CloudTaskThread.VS1_GetCustomize;
var
  Params: TJSONObject;
  TableName: string;
  EmpID: Integer;
  Columns: TJSONArray;
  dd: TJSONArray;
  ScriptMain: TERPScript;
  TempQuery: TERPQuery;
  TempStr: string;
  ResultJson, RowJSON: TJSONObject;
  ArrayJSON: TJSONArray;
  MyClass: TObject;
begin
  Params := JO(fParams);
  try
    TableName := '';
    EmpID := 0;

    if Params.O[TAG_CLOUD_Params].Exists('TableName') then
      TableName := Params.O[TAG_CLOUD_Params].S['TableName'];

    if Params.O[TAG_CLOUD_Params].Exists('EmployeeID') then
      EmpID := Params.O[TAG_CLOUD_Params].I['EmployeeID'];

    // Check if exists such a record
    TempQuery := TERPQuery.Create(nil);
    TempQuery.Connection := AppEnv.AppDb.Connection;
    try
      TempQuery.SQL.Add('SELECT PrefName, UserID, PrefValue FROM tblpreferences');
      TempQuery.SQL.Add('WHERE PrefGroup="TablePrefs"');
      if Tablename <> '' then
        TempQuery.SQL.Add('AND PrefName=' + QuotedStr(TableName));
      if EmpID <> 0 then
        TempQuery.SQL.Add('AND UserID=' + IntToStr(EmpID));
      TempQuery.Open;

      ArrayJSON := TJSONArray.Create();
      try
        while not TempQuery.Eof do begin
          TempStr := TempQuery.FieldByName('PrefValue').AsString;
          RowJSON := JO;
          RowJSON.S['TableName'] := TempQuery.FieldByName('PrefName').AsString;
          RowJSON.I['EmployeeID'] := TempQuery.FieldByName('UserID').AsInteger;
          Columns := TJSONArray.Create;
          Columns.AsString := TempStr;
          RowJSON.A['Columns'] := Columns;

          ArrayJSON.Add(RowJSON);
          TempQuery.Next;
        end;

        ResultJson := JO;
        ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
        ResultJson.A['CustomLayout'] := ArrayJSON;
        AddEventdata(fOnEvent, TAG_Obj, ResultJson.AsString, true);

      finally
        ArrayJSON.Free;
      end;

    finally
      TempQuery.Free;
    end;
  finally
    Params.Free;
  end;
end;

procedure TVS1CloudTaskThread.VS1_SetClosingDates;
var
  Params: TJSONObject;
  Date1: string;
  Date2: string;
  Date3: string;
  Date4: string;
  TempScript: TERPScript;
begin
  Params := JO(fParams);

  Date1 := '1900-01-01';
  if Params.Exists('ClosingDate') then
    Date1 := FloatToStr(Params.DT['ClosingDate']);

  Date2 := '1900-01-01';
  if Params.Exists('ClosingDateAP') then
    Date2 := FloatToStr(Params.DT['ClosingDateAP']);

  Date3 := '1900-01-01';
  if Params.Exists('ClosingDateAR') then
    Date3 := FloatToStr(Params.DT['ClosingDateAR']);

  Date4 := '1900-01-01';
  if Params.Exists('SummarisedTransDate') then
    Date4 := FloatToStr(Params.DT['SummarisedTransDate']);

  TempScript := TERPScript.Create(nil);
  TempScript.Connection := AppEnv.AppDb.Connection;
  try
    if Date1 <> '1900-01-01' then begin
      TempScript.SQL.Clear;
      TempScript.SQL.Add('UPDATE tbldbpreferences SET FieldValue=' + QuotedStr(Date1));
      TempScript.SQL.Add('WHERE `Name`="ClosingDate"');
      TempScript.Execute;
    end;

    if Date2 <> '1900-01-01' then begin
      TempScript.SQL.Clear;
      TempScript.SQL.Add('UPDATE tbldbpreferences SET FieldValue=' + QuotedStr(Date2));
      TempScript.SQL.Add('WHERE `Name`="ClosingDateAP"');
      TempScript.Execute;
    end;

    if Date3 <> '1900-01-01' then begin
      TempScript.SQL.Clear;
      TempScript.SQL.Add('UPDATE tbldbpreferences SET FieldValue=' + QuotedStr(Date3));
      TempScript.SQL.Add('WHERE `Name`="ClosingDateAR"');
      TempScript.Execute;
    end;

    if Date4 <> '1900-01-01' then begin
      TempScript.SQL.Clear;
      TempScript.SQL.Add('UPDATE tbldbpreferences SET FieldValue=' + QuotedStr(Date4));
      TempScript.SQL.Add('WHERE `Name`="SummarisedTransDate"');
      TempScript.Execute;
    end;

  finally
    TempScript.Free;
  end;

  AddEventdata(fOnEvent, TAG_ResponseStatus, 'Closing Dates updated.', true);

end;

procedure TVS1CloudTaskThread.VS1_GetClosingDates;
var
  RespJSON: TJSONObject;
  TempQuery: TERPQuery;
begin
  RespJSON := JO;

  TempQuery := TERPQuery.Create(nil);
  TempQuery.Connection := AppEnv.AppDb.Connection;
  try
    TempQuery.SQL.Add('SELECT FieldValue FROM tbldbpreferences');
    TempQuery.SQL.Add('WHERE `Name`="ClosingDate"');
    TempQuery.Open;
    RespJSON.DT['ClosingDate'] := StrToFloatDef(TempQuery.FieldByName('FieldValue').AsString, 0);
    TempQuery.Close;

    TempQuery.SQL.Clear;
    TempQuery.SQL.Add('SELECT FieldValue FROM tbldbpreferences');
    TempQuery.SQL.Add('WHERE `Name`="ClosingDateAP"');
    TempQuery.Open;
    RespJSON.DT['ClosingDateAP'] := StrToFloatDef(TempQuery.FieldByName('FieldValue').AsString, 0);
    TempQuery.Close;

    TempQuery.SQL.Clear;
    TempQuery.SQL.Add('SELECT FieldValue FROM tbldbpreferences');
    TempQuery.SQL.Add('WHERE `Name`="ClosingDateAR"');
    TempQuery.Open;
    RespJSON.DT['ClosingDateAR'] := StrToFloatDef(TempQuery.FieldByName('FieldValue').AsString, 0);
    TempQuery.Close;

    TempQuery.SQL.Clear;
    TempQuery.SQL.Add('SELECT FieldValue FROM tbldbpreferences');
    TempQuery.SQL.Add('WHERE `Name`="SummarisedTransDate"');
    TempQuery.Open;
    RespJSON.DT['SummarisedTransDate'] := StrToFloatDef(TempQuery.FieldByName('FieldValue').AsString, 0);
    TempQuery.Close;

  finally
    TempQuery.Free;
  end;

  AddEventdata(fOnEvent, TAG_Obj, RespJSON.AsString, true, 'ClosingDates');
end;

procedure TVS1CloudTaskThread.VS1_GetDataBases;
var
  Params: TJSONObject;
  Response: TJSONObject;
  oLine: TJSONObject;
  VS1Database: TVS1_Databases;
  VS1ClientUsers: TVS1_ClientUsers;
  EmailID: String;
  ClientID: Integer;
  MyClass: TComponent;
begin
  Params := JO(fParams);

  EmailID := '';
  if Params.O[TAG_CLOUD_Params].Exists('EmailID') then
    EmailID := Params.O[TAG_CLOUD_Params].S['EmailID'];

  try
    VS1Database := TVS1_Databases.Create(nil);
    try
      VS1Database.Connection := TMyDAcDataconnection.Create(VS1Database);
      VS1Database.Connection.Connection := fConn;

      VS1ClientUsers := TVS1_ClientUsers.Create(nil);
      try
        VS1ClientUsers.Connection := VS1Database.Connection;

        // Find the client with the email/
        VS1ClientUsers.LoadSelect('EmailId=' + QuotedStr(EmailID));

        if VS1ClientUsers.Count > 0 then begin
          ClientID := VS1ClientUsers.ClientID;

          // Find the databse with the client ID.
          VS1Database.LoadSelect('ClientID=' + IntToStr(ClientID));
          if VS1Database.Count > 0  then begin
            Response := JO;
            try
              while not VS1Database.EOF do begin
                Response.A[VS1_TAG_Databases].Add(VS1Database.DatabaseName);
                  VS1Database.Next;
              end;

              AddEventdata(fOnEvent, TAG_Obj, Response.AsString, True);
            finally
              Response.Free;
            end;

          end else begin
            AddEventdata(fOnEvent, TAG_ResponseError, 'No databases for the user.', True);
          end;
        end else begin
          AddEventdata(fOnEvent, TAG_ResponseError, 'No such user exists.', True);
        end;
      finally
        FreeAndNil(VS1ClientUsers);
      end;

    finally
      FreeAndNil(VS1Database);
    end;

  finally
    Params.Free;
  end;
end;

end.

