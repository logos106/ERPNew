unit ModUserUtils;
{$I ERP.inc}
interface

uses
  ServerModuleObj, JsonObject, ThreadProperty, {MailReaderObj,} JsonRpcTcpClient,
  SharedAppUserListObj, GoogleSynchObj, ConTnrs, LogThreadBase, LogMessageTypes,
  CustomProcessObj;
  const
    OneHour   = 1 / 24;
    OneMinute = OneHour / 60;
    OneSec    = OneMinute / 60;
   {$IFDEF NewUserUtils}
      utTaskAuditTrailPurge   = 'AuditTrailPurge';
      utTaskGoLive            = 'GoLive';
      utTaskEmail             = 'Email';
      utTaskDeleteTempTables  = 'DeleteTempTables';
      utTaskGoogleCalendar    = 'GoogleCalendar';
      utTaskGoogleAppointment = 'GoogleAppointment';
      utTaskGoogleTaskCheck   = 'GoogleTaskCheck';
      utTaskGoogleQueue       = 'GoogleQueue';
      utTaskSMSSend           = 'SMSSend';
      utTaskSMSReceive        = 'SMSReceive';
      utTaskPing              = 'Ping';
      utTaskValidatetime      = 'Validatetime';
      utLicenseCheck          = 'LicenseCheck';
      utTaskInactiveUser      = 'InactiveUser';
      utTaskUpdatebatch       = 'Updatebatch';
      utTaskGeneralcheck      = 'Generalcheck';
      utTaskScheduledreports  = 'Scheduledreports';
      utTaskCleanup           = 'Cleanup';
      utTaskDocdownload       = 'Docdownload';
      utTaskCustomProcess     = 'CustomProcess';
      utTaskOffsiteBackup     = 'OffsiteBackup';
      utTaskClearInUseTables  = 'ClearInUseTables';
      utTaskNonERPClone       = 'NonERPClone';
   {$ELSE}
      OFFSITE_BACKUP_CHECK_INTERVAL = OneMinute * 10;
   {$ENDIF}

type
  TModUserUtils = class(TServerModule)
  private
    fDbListJsonTextProp: TThreadProperty;
    AppUserList: TSharedAppUserList;
    fServerID: string;
    fLastAuditTrailPurgeCheckTime: TDateTime;
    fStartTime: TDateTime;
    fDocDBStrucCheckDone: boolean;
    fOffsiteBackupConfigText: string;
    fOffsiteRestoreConfigText: string;
    fClientConfig: string;
    (*fbstarted :boolean ;*)
   {$IFDEF NewUserUtils}
      fbEnable_AuditTrailPurge_Check_OnStartup	:Boolean;
      fbEnable_GoLive_Check_OnStartup	          :Boolean;
      fbEnable_Email_Check_OnStartup	          :Boolean;
      fbEnable_DeleteTempTables_Check_OnStartup	:Boolean;
      fbEnable_GoogleCalendar_Check_OnStartup	  :Boolean;
      fbEnable_GoogleAppointment_Check_OnStartup:Boolean;
      fbEnable_GoogleTask_Check_OnStartup	      :Boolean;
      fbEnable_GoogleQueue_Check_OnStartup	    :Boolean;
      fbEnable_SMSSend_Check_OnStartup	        :Boolean;
      fbEnable_SMSReceive_Check_OnStartup	      :Boolean;
      fbEnable_Ping_Check_OnStartup	            :Boolean;
      fbEnable_ValidateTime_Check_OnStartup	    :Boolean;
      fbEnable_InactiveUser_Check_OnStartup	    :Boolean;
      fbEnable_UpdateBatch_Check_OnStartup	    :Boolean;
      fbEnable_General_Check_OnStartup	        :Boolean;
      fbEnable_ScheduledReports_Check_OnStartup	:Boolean;
      fbEnable_FileCleanup_Check_OnStartup	    :Boolean;
      fbEnable_DocDownload_Check_OnStartup	    :Boolean;
      fbEnable_CustomProcess_Check_OnStartup	  :Boolean;
      fbEnable_OffsiteBackup_Check_OnStartup	  :Boolean;
      fbEnable_ClearInUseTables_Check_OnStartup	:Boolean;
      fbEnable_NonERPClone_Check_OnStartup	    :Boolean;

      fbEnable_AuditTrailPurge_Check	:Boolean;
      fbEnable_GoLive_Check	          :Boolean;
      fbEnable_Email_Check	          :Boolean;
      fbEnable_DeleteTempTables_Check	:Boolean;
      fbEnable_GoogleCalendar_Check	  :Boolean;
      fbEnable_GoogleAppointment_Check:Boolean;
      fbEnable_GoogleTask_Check	      :Boolean;
      fbEnable_GoogleQueue_Check	    :Boolean;
      fbEnable_SMSSend_Check	        :Boolean;
      fbEnable_SMSReceive_Check	      :Boolean;
      fbEnable_Ping_Check	            :Boolean;
      fbEnable_ValidateTime_Check	    :Boolean;
      fbEnable_InactiveUser_Check	    :Boolean;
      fbEnable_UpdateBatch_Check	    :Boolean;
      fbEnable_General_Check	        :Boolean;
      fbEnable_ScheduledReports_Check	:Boolean;
      fbEnable_FileCleanup_Check	    :Boolean;
      fbEnable_DocDownload_Check	    :Boolean;
      fbEnable_CustomProcess_Check	  :Boolean;
      fbEnable_OffsiteBackup_Check	  :Boolean;
      fbEnable_ClearInUseTables_Check	:Boolean;
      fbEnable_NonERPClone_Check	    :Boolean;

      fdGoLive_Check_Interval	          :Integer;
      fdAuditTrailPurge_Check_Interval  :Integer;
      fdEmail_Check_Interval	          :Integer;
      fdDeleteTempTables_Check_Interval	:Integer;
      fdGoogleCalendar_Check_Interval	  :Integer;
      fdGoogleAppointment_Check_Interval:Integer;
      fdGoogleTask_Check_Interval	      :Integer;
      fdGoogleQueue_Check_Interval	    :Integer;
      fdSMSSend_Check_Interval	        :Integer;
      fdSMSReceive_Check_Interval	      :Integer;
      fdPing_Check_Interval	            :Integer;
      fdValidateTime_Check_Interval	    :Integer;
      fdInactiveUser_Check_Interval	    :Integer;
      fdUpdateBatch_Check_Interval	    :Integer;
      fdGeneral_Check_Interval	        :Integer;
      fdScheduledReports_Check_Interval	:Integer;
      fdFileCleanup_Check_Interval	    :Integer;
      fdDocDownload_Check_Interval	    :Integer;
      fdCustomProcess_Check_Interval	  :Integer;
      fdOffsiteBackup_Check_Interval	  :Integer;
      fdClearInUseTables_Check_Interval	:Integer;
      fdNonERPClone_Check_Interval	    :Integer;

      fdGoLive_Check_StartupDelay	          :Integer;
      fdAuditTrailPurge_Check_StartupDelay  :Integer;
      fdEmail_Check_StartupDelay	          :Integer;
      fdDeleteTempTables_Check_StartupDelay	:Integer;
      fdGoogleCalendar_Check_StartupDelay	  :Integer;
      fdGoogleAppointment_Check_StartupDelay:Integer;
      fdGoogleTask_Check_StartupDelay	      :Integer;
      fdGoogleQueue_Check_StartupDelay	    :Integer;
      fdSMSSend_Check_StartupDelay	        :Integer;
      fdSMSReceive_Check_StartupDelay	      :Integer;
      fdPing_Check_StartupDelay	            :Integer;
      fdValidateTime_Check_StartupDelay	    :Integer;
      fdInactiveUser_Check_StartupDelay	    :Integer;
      fdUpdateBatch_Check_StartupDelay	    :Integer;
      fdGeneral_Check_StartupDelay	        :Integer;
      fdScheduledReports_Check_StartupDelay	:Integer;
      fdFileCleanup_Check_StartupDelay	    :Integer;
      fdDocDownload_Check_StartupDelay	    :Integer;
      fdCustomProcess_Check_StartupDelay	  :Integer;
      fdOffsiteBackup_Check_StartupDelay	  :Integer;
      fdClearInUseTables_Check_StartupDelay	:Integer;
      fdNonERPClone_Check_StartupDelay	    :Integer;


      fdAuditTrailPurge_Check_At	: Tdatetime;
      fdGoLive_Check_At	          : Tdatetime;
      fdEmail_Check_At	          : Tdatetime;
      fdDeleteTempTables_Check_At	: Tdatetime;
      fdGoogleCalendar_Check_At	  : Tdatetime;
      fdGoogleAppointment_Check_At: Tdatetime;
      fdGoogleTask_Check_At	      : Tdatetime;
      fdGoogleQueue_Check_At	    : Tdatetime;
      fdSMSSend_Check_At	        : Tdatetime;
      fdSMSReceive_Check_At	      : Tdatetime;
      fdPing_Check_At	            : Tdatetime;
      fdValidateTime_Check_At	    : Tdatetime;
      fdInactiveUser_Check_At	    : Tdatetime;
      fdUpdateBatch_Check_At	    : Tdatetime;
      fdGeneral_Check_At	        : Tdatetime;
      fdScheduledReports_Check_At	: Tdatetime;
      fdFileCleanup_Check_At	    : Tdatetime;
      fdDocDownload_Check_At	    : Tdatetime;
      fdCustomProcess_Check_At	  : Tdatetime;
      fdOffsiteBackup_Check_At	  : Tdatetime;
      fdClearInUseTables_Check_At	: Tdatetime;
      fdNonERPClone_Check_At	    : Tdatetime;
      fiWorkNo:Integer;
   {$ELSE}
      fNextGoLiveCheckTime            : TDateTime;
      fNextEmailCheckTime             : TDateTime;
      fNextDeleteTempTables           : TDateTime;
      fNextGoogleCalendarCheckTime    : TDateTime;
      fNextGoogleAppointmentCheckTime : TDateTime;
      fNextGoogleTaskCheckTime        : TDateTime;
      fNextScheduledReportsCheckTime  : TDateTime;
      NextPingCheckTime               : TDateTime;
      fNextInactiveUserCheckTime      : TDateTime;
      fNextGeneralCheckTime           : TDateTime;
      fNextGoogleQueueCheckTime       : TDateTime;
      fNextMessagesCheckTime          : TDateTime;
      fNextCustomProcessCheckTime     : TDateTime;
      fNextFileCleanupTime            : TDateTime;
      fNextDocDownloadCheckTime       : TDateTime;
      fNextClearInUseTablesCheckTime  : TDateTime;
      fNextNonERPCloneCheckTime       : TDateTime;
      fdValidateTime_Check_at         : TDateTime;
      fdUpdateBatch_Check_At          : TDateTime;
      fNextValidateTimeProp           : TThreadProperty;
      fNextOffsiteBackupCheckTime     : TThreadProperty;
      fNextUpdateCheckTimeProp        : TThreadProperty;
      NextSMSReceiveCheckTime         : TThreadProperty;
      NextSMSSendCheckTime            : TThreadProperty;
   {$ENDIF}

 {$IFDEF NewUserUtils}
 {$ELSE}
    function GetNextUpdateCheckTime: TDateTime;
    procedure SetNextUpdateCheckTime(const Value: TDateTime);
    function GetNextValidateTime: TDateTime;
    procedure SetNextValidateTime(const Value: TDateTime);
    function GetNextOffsiteBackupCheckTime: TDateTime;
    procedure SetNextOffsiteBackupCheckTime(const Value: TDateTime);
 {$ENDIF}

    //function IsNewCheck :Boolean;
    function GetERPServerName: string;
    function GetERPServerPort: integer;
    function GetLastMasterValidationTime: TDateTime;
    procedure SetLastMasterValidationTime(const Value: TDateTime);
    function CommsOkWithHeadOffice: boolean;
    function GetSoftwareReleaseType: string;
    function GetDbListJsonText: string;
    procedure SetDbListJsonText(const Value: string);

    procedure LogAlltimes;
    function GetClientConfig: string;
    procedure SetClientConfig(const Value: string);

    property DbListJsonText: string read GetDbListJsonText write SetDbListJsonText;
    Procedure LogCurtime(const Value:String);

  protected
    function GetModuleDescription: string; override;
    procedure ConfigNotFound; override;
    procedure AfterLoadConfig; override;

    procedure DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject); override;
    procedure DoOnMessage(aClientId: integer; aData: TJsonObject; ctx: TJsonObject); override;
    procedure DoOnCommandMessage(aData: string; ctx: TJsonObject); override;

    procedure DoOnRequest(aClientId: integer; aRequest: string; ctx: TJsonObject; var aResponse: string); override;
    procedure DoOnRequest(aClientId: integer; aRequest: TJsonObject; ctx: TJsonObject; aResponse: TJsonObject = nil); override;
    procedure DoOnCommandRequest(aRequest: string; var aResponse: string); override;
    function EncryptConfig: boolean; override;

    procedure DoWork; override;

  public
    CustomProcessList: TCustomProcessList;
    constructor Create(aLogger: TLoggerBase = nil); override;
    destructor Destroy; override;
    procedure LoadConfig; override;
    procedure SaveConfig; override;

    property ClientConfig: string read GetClientConfig write SetClientConfig;
    property LastMasterValidationTime: TDateTime read GetLastMasterValidationTime write SetLastMasterValidationTime;

 {$IFDEF NewUserUtils}
    property NextValidateTime: TDateTime read fdValidateTime_Check_at write fdValidateTime_Check_at;
    property NextOffsiteBackupCheckTime: TDateTime read fdOffsiteBackup_Check_At write fdOffsiteBackup_Check_At;
    Procedure ReInitTaskTime(const TaskDesc:String; aIntervel :Double =0);
 {$ELSE}
    property NextValidateTime: TDateTime read GetNextValidateTime write SetNextValidateTime;
    property NextUpdateCheckTime: TDateTime read GetNextUpdateCheckTime write SetNextUpdateCheckTime;
    property NextOffsiteBackupCheckTime: TDateTime read GetNextOffsiteBackupCheckTime write SetNextOffsiteBackupCheckTime;
 {$ENDIF}

  published
    property ERPServerName: string read GetERPServerName;
    property ERPServerPort: integer read GetERPServerPort;
    property SoftwareReleaseType: string read GetSoftwareReleaseType;
    property LastAuditTrailPurgeCheckTime: TDateTime read fLastAuditTrailPurgeCheckTime write fLastAuditTrailPurgeCheckTime;
    property ServerID: string read fServerID write fServerID;
    property OffsiteBackupConfigText: string read fOffsiteBackupConfigText write fOffsiteBackupConfigText;
    property OffsiteRestoreConfigText: string read fOffsiteRestoreConfigText write fOffsiteRestoreConfigText;


  end;


implementation

uses
  SysUtils, JsonToObject, ModuleConst, JsonRPCConst, classes, NotificationItem,
  ClientConfigObj, DbBackupObj, JsonRPCUtils, ModuleDbUtils, MachineSignature,
  InstallConst, ModuleServerUtils, ErpDbMaintObj, Windows, {MessagesDownloaderObj,}
  ModuleFileNameUtils, ERPDocsDBObj, ConfigDbObj, CipherUtils,
  { Module Thread Tasks }
  BackupModuleThreadTask,
  BatchUpdateModuleThreadTask,
  UpdateCheckModuleThreadTask,
  AuditPurgeThreadTask,
  EmailCheckThreadTask,
  GoogleCalendarThreadTask,
  GoogleQueueThreadTask,
  SMSCheckThreadTask,
  PingCheckThreadTask,
  LicenceCheckThreadTask,
  InactiveUserCheckThreadTask,
  ReportSchedulerThreadTask,
  CustomProcessCheckThreadTask,
  FileCleanupThreadTask,
  DocDownloadCheckThreadTask, DeleteTempTablesTask,
  OffsiteBackupThreadTask,
  ClearInUseTablesThreadTask,
  GoLiveSchedulerThreadTask, ERPDbComponents, DbConst, ServerModuleThreadTask;


 {$IFDEF NewUserUtils}
 {$ELSE}
      const
        EMAIL_CHECK_INTERVAL              = OneMinute * 30;
        GOLIVE_CHECK_INTERVAL             = OneMinute * 60;  // 1 hour
        SCHEDULEDREPORTS_CHECK_INTERVAL   = OneMinute * 60;  // 1 hours
        USER_INACTIVITY_CHECK_INTERVAL    = OneMinute * 3;
        GOOGLE_CALENDAR_CHECK_INTERVAL    = OneMinute * 5;
        GOOGLE_APPOINTMENT_CHECK_INTERVAL = OneMinute * 30;
        GOOGLE_TASK_CHECK_INTERVAL        = OneMinute * 30;
        GOOGLE_QUEUE_CHECK_INTERVAL       = OneMinute * 5;
        FILE_CLEANUP_CHECK_INTERVAL       = OneHour * 8;
        DOC_DOWNLOAD_CHECK_INTERVAL       = OneMinute * 60;
   {$ENDIF}


procedure DoDeleteFiles(const aFileNameMask: string);
var
  SearchRec: TSearchRec;
  Found: integer;
  sFile: string;
  sPath: string;
Begin
  { path may me in MySQL (linex) format so change to windows }
  sPath:= ExtractFilePath(StringReplace(aFileNameMask,'/','\',[rfReplaceAll]));
  Found := FindFirst(aFileNameMask, faAnyFile, SearchRec);
  try
    while (Found = 0) do begin
      if not (SearchRec.Attr and faDirectory > 0) then begin
        sFile := SearchRec.Name;
        SysUtils.DeleteFile(sPath + sFile);
      end;
      Found := SysUtils.FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

{ TModUserUtils }

function RandString(const leng: integer): string;
const
  Chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  i, N: integer;
begin
  Randomize;
  result := '';
  for i := 1 to leng do begin
    N := Random(Length(Chars)) + 1;
    result := result + Chars[N];
  end;
end;

procedure TModUserUtils.AfterLoadConfig;
var
  changed: boolean;
  ConfigDb: TConfigDb;
  json, ModuleJson: TJsonObject;
begin
  { check / set config defaults }

  try
    ConfigDb := TConfigDb.Create('ClientConfig', Self.MySQLServer);
    try
      fClientConfig := DecryptString(ConfigDb.Value);
      //ChangeData;
    finally
      ConfigDb.Free;
    end;

    { we have moved the LastMasterValidationTime into the encrypted ClientConfig,
      so if not set yet take it from old location }
    json := JO;
    try
      json.AsString := fClientConfig;

      if json.DT['LastMasterValidationTime'] = 0 then begin
        { get old value }
        ConfigDb := TConfigDb.Create(self.ModuleName + '_Config', Self.MySQLServer);
        ModuleJson := JO;
        try
          ModuleJson.AsString := ConfigDb.Value;
          if ModuleJson.Exists('LastMasterValidationTime') then begin

            json.DT['LastMasterValidationTime'] := ModuleJson.DT['LastMasterValidationTime'];
            { save it }
            self.ClientConfig := json.AsString;

            { remove from old .. }
            ModuleJson.Delete('LastMasterValidationTime');
            { save back }
            ConfigDb.Value := ModuleJson.AsString;
          end;
        finally
          ConfigDb.Free;
          ModuleJson.Free;
        end;
      end;
    finally
      json.Free;
    end;

  except
    on e: exception do begin
      Log('Error reading ClientConfig (Licence) data drom database: ' + e.Message, ltError);
    end;
  end;

  changed:= false;
  { User Utils should probably always be active }
  if not self.Active then begin
    self.Active := True;
    changed := true;
  end;

  if ServerID = '' then begin
    ServerID := RandString(10);
    LoggingLevel := llDetail;
    changed := true;
  end;

  if Changed then
    //self.SaveConfig(true);
    self.SaveConfig;
end;

function TModUserUtils.CommsOkWithHeadOffice: boolean;
begin
  result:= true;
  if (self.LastMasterValidationTime = 0) or ((self.LastMasterValidationTime + PERIOD_NO_CONNECT_CANCEL) < now) then
    result:= false;
end;

procedure TModUserUtils.ConfigNotFound;
var
  configFileName: string;
  json: TJsonObject;
//  ConfigDb: TConfigDb;
begin
  inherited;
  { db config entry not found .. }
  configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
  if FileExists(configFileName) then begin
    json := JO;
    try
      EncryptedFileToJson(json, configFileName);
      if Json.StringExists('ConfigText') then begin
//        ConfigDb := TConfigDb.Create('ClientConfig',self.MySQLServer);
        ClientConfig := Json.S['ConfigText'];
        { remove this data and save }
        Json.Delete('ConfigText');
        JsonToEncryptedFile(Json,configFileName)
      end;
    finally
      json.Free;
    end;
  end;
end;

constructor TModUserUtils.Create(aLogger: TLoggerBase);
var
  msg:String;
begin
  try
    inherited;
    (*fbstarted := False;*)

    (*ConfigTextProp:= TThreadProperty.Create('');*)
    (*ERPServerNameProp:= TThreadProperty.Create('');*)
    (*ERPServerPortProp:= TThreadProperty.Create('0');*)
//    LastMasterValidationTimeProp:= TThreadProperty.Create('0');
    //fNextValidateTimeProp := TThreadProperty.Create('0');
    fDbListJsonTextProp := TThreadProperty.Create('');
    //LoadConfig(true);
    LoadConfig;
     {$IFDEF NewUserUtils}
     {$ELSE}
        fNextUpdateCheckTimeProp := TThreadProperty.Create('0');
        fNextEmailCheckTime := now + EMAIL_CHECK_INTERVAL;
        fNextGoLiveCheckTime := now + GOLIVE_CHECK_INTERVAL;
        fNextDeleteTempTables := now + (OneMinute * 1);
        fNextGoogleCalendarCheckTime := now + GOOGLE_CALENDAR_CHECK_INTERVAL;
        fNextGoogleAppointmentCheckTime := now + (OneMinute * 10);
        fNextGoogleTaskCheckTime := now + GOOGLE_TASK_CHECK_INTERVAL;
        fNextScheduledReportsCheckTime := now + (OneMinute * 60);
        NextPingCheckTime:= now + (OneMinute * 15);
        NextValidateTime:= now + OneMinute;
        fNextInactiveUserCheckTime := now + USER_INACTIVITY_CHECK_INTERVAL;
    {$ENDIF}


    AppUserList := TSharedAppUserList.Create(MySQLServer);
//    AppUserList.InitialiseDatabase;
    Log('Starting up User Utils',ltDetail);
    Log('Clearing App User List'              ,ltDetail);    AppUserList.ClearAppUserList;
    Log('Clearing Logon Lock'                 ,ltDetail);    AppUserList.ClearLogonLock;
    Log('Clearing Tables In USe'              ,ltDetail);    AppUserList.ClearInUseTable;
    Log('Reset Database inProgress Activities' ,ltDetail);    AppUserList.ResetDatabase(msg);
   // TSharedAppUserList.ExRemoveUser(ErpDbMaintObj.ERP_ADMIN_USER_DB_MAINT, MySQLServer);    //if dbmaintainance in progress, cancel it when service restarted
    if Msg <> '' then Log(Msg ,ltDetail);

    //NextUpdateCheckTime:= now + (OneMinute * 10);

    CustomProcessList := TCustomProcessList.Create;
    CustomProcessList.Logger := self.Logger;

    fDocDBStrucCheckDone := false;
    {$IFDEF NewUserUtils}
    {$ELSE}
      NextSMSReceiveCheckTime := TThreadProperty.Create;
      NextSMSSendCheckTime := TThreadProperty.Create;
      fNextOffsiteBackupCheckTime := TThreadProperty.Create;

      NextSMSSendCheckTime.AsDateTime := now + (OneMinute * 1);
      NextSMSReceiveCheckTime.AsDateTime := now + (OneMinute * 1.5);
      fNextGeneralCheckTime := now + (OneMinute * 10);
      fNextGoogleQueueCheckTime := now + (OneMinute * 5);
      fNextMessagesCheckTime := now + (OneMinute * 15);
      fNextCustomProcessCheckTime := now + (OneMinute * 5);
      fNextFileCleanupTime := now + FILE_CLEANUP_CHECK_INTERVAL;
      fNextDocDownloadCheckTime := now + (OneMinute * 1);
      fNextOffsiteBackupCheckTime.AsDateTime := now + OFFSITE_BACKUP_CHECK_INTERVAL;
      fNextClearInUseTablesCheckTime := now;
      fNextNonERPCloneCheckTime := now;
    {$ENDIF}

    fStartTime := now;
    logalltimes;
  except
    on e: exception do begin
      Log('Errror creating module: ' + e.Message,ltError);
    end;
  end;
end;

Procedure TModUserUtils.LogAlltimes;
begin
     {$IFDEF NewUserUtils}
     {$ELSE}
   Log('=============================================================================================================', ltDetail);
    Log('Start At                      : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fStartTime                            ), ltDetail);
    Log('Next Email check At           : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextEmailCheckTime                   ), ltDetail);
    Log('Next Go Live At               : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoLiveCheckTime                  ), ltDetail);
    Log('Next Delete Temp Tables At    : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextDeleteTempTables                 ), ltDetail);
    Log('Next Google Calendar At       : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleCalendarCheckTime          ), ltDetail);
    Log('Next Google Appt At           : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleAppointmentCheckTime       ), ltDetail);
    Log('Next Google Task At           : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleTaskCheckTime              ), ltDetail);
    Log('Next Scheduled Reports At     : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextScheduledReportsCheckTime        ), ltDetail);
    Log('Next Ping check At            : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,NextPingCheckTime                     ), ltDetail);
    Log('Next Validate Time At         : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,NextValidateTime                      ), ltDetail);
    Log('Next Inactive User Check At   : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextInactiveUserCheckTime            ), ltDetail);
    Log('Next Update check             : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,NextUpdateCheckTime                   ), ltDetail);
    Log('Next PPG check                : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,NextUpdateCheckTime                   ), ltDetail);
    Log('Next SMs Send check At        : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,NextSMSSendCheckTime.AsDateTime       ), ltDetail);
    Log('Next SMS Receive Check At     : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,NextSMSReceiveCheckTime.AsDateTime    ), ltDetail);
    Log('Next General Check At         : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGeneralCheckTime                 ), ltDetail);
    Log('Next Google Que At            : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleQueueCheckTime             ), ltDetail);
    Log('Next Message check At         : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextMessagesCheckTime                ), ltDetail);
    Log('Next Custom Process Check At  : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextCustomProcessCheckTime           ), ltDetail);
    Log('Next File Cleanup At          : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextFileCleanupTime                  ), ltDetail);
    Log('Next Download file check At   : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextDocDownloadCheckTime             ), ltDetail);
    Log('Next Offsite backup check At  : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextOffsiteBackupCheckTime.AsDateTime), ltDetail);
    Log('Next Clear inuse table At     : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextClearInUseTablesCheckTime        ), ltDetail);
    Log('Next NonERP Clone At          : '+ formatdatetime('dd-mm-yy hh:nn:ss' ,fNextNonERPCloneCheckTime             ), ltDetail);
    Log('=============================================================================================================', ltDetail);
     {$ENDIF}
end;

{$IFDEF NewUserUtils}

procedure TModUserUtils.ReInitTaskTime(const TaskDesc: String; aIntervel :Double =0);
  function Taskinterval(aDefaultIntervel:Integer):double;
  begin
    if aIntervel <> 0 then result :=aIntervel
    else if aDefaultIntervel =0 then REsult := 0
    else result := aDefaultIntervel / OneMinute;
    REsult := REsult +  (Random(180) * OneSec);
  end;
begin
       if Sametext(TaskDesc, utTaskAuditTrailPurge   ) then fdAuditTrailPurge_Check_At  := now + Taskinterval(fdAuditTrailPurge_Check_Interval)
  else if Sametext(TaskDesc, utTaskGoLive            ) then fdGoLive_Check_At           := now + Taskinterval(fdGoLive_Check_Interval)
  else if Sametext(TaskDesc, utTaskEmail             ) then fdEmail_Check_At            := now + Taskinterval(fdEmail_Check_Interval)
  else if Sametext(TaskDesc, utTaskDeleteTempTables  ) then fdDeleteTempTables_Check_At := now + Taskinterval(fdDeleteTempTables_Check_Interval)
  else if Sametext(TaskDesc, utTaskGoogleCalendar    ) then fdGoogleCalendar_Check_At   := now + Taskinterval(fdGoogleCalendar_Check_Interval)
  else if Sametext(TaskDesc, utTaskGoogleAppointment ) then fdGoogleAppointment_Check_At:= now + Taskinterval(fdGoogleAppointment_Check_Interval)
  else if Sametext(TaskDesc, utTaskGoogleTaskCheck   ) then fdGoogleTask_Check_At       := now + Taskinterval(fdGoogleTask_Check_Interval)
  else if Sametext(TaskDesc, utTaskGoogleQueue       ) then fdGoogleQueue_Check_At      := now + Taskinterval(fdGoogleQueue_Check_Interval)
  else if Sametext(TaskDesc, utTaskSMSSend           ) then fdSMSSend_Check_At          := now + Taskinterval(fdSMSSend_Check_Interval)
  else if Sametext(TaskDesc, utTaskSMSReceive        ) then fdSMSReceive_Check_At       := now + Taskinterval(fdSMSReceive_Check_Interval)
  else if Sametext(TaskDesc, utTaskPing              ) then fdPing_Check_At             := now + Taskinterval(fdPing_Check_Interval)
  else if Sametext(TaskDesc, utTaskValidatetime      ) then fdValidatetime_Check_At     := now + Taskinterval(fdValidatetime_Check_Interval)
  else if Sametext(TaskDesc, utTaskInactiveUser      ) then fdInactiveUser_Check_At     := now + Taskinterval(fdInactiveUser_Check_Interval)
  else if Sametext(TaskDesc, utTaskUpdatebatch       ) then fdUpdatebatch_Check_At      := now + Taskinterval(fdUpdatebatch_Check_Interval)
  else if Sametext(TaskDesc, utTaskGeneralcheck      ) then fdGeneral_Check_At          := now + Taskinterval(fdGeneral_Check_Interval)
  else if Sametext(TaskDesc, utTaskScheduledreports  ) then fdScheduledreports_Check_At := now + Taskinterval(fdScheduledreports_Check_Interval)
  else if Sametext(TaskDesc, utTaskCleanup           ) then fdFileCleanup_Check_At      := now + Taskinterval(fdFileCleanup_Check_Interval)
  else if Sametext(TaskDesc, utTaskDocdownload       ) then fdDocdownload_Check_At      := now + Taskinterval(fdDocdownload_Check_Interval)
  else if Sametext(TaskDesc, utTaskCustomProcess     ) then fdCustomProcess_Check_At    := now + Taskinterval(fdCustomProcess_Check_Interval)
  else if Sametext(TaskDesc, utTaskOffsiteBackup     ) then fdOffsiteBackup_Check_At    := now + Taskinterval(fdOffsiteBackup_Check_Interval)
  else if Sametext(TaskDesc, utTaskClearInUseTables  ) then fdClearInUseTables_Check_At := now + Taskinterval(fdClearInUseTables_Check_Interval)
  else if Sametext(TaskDesc, utTaskNonERPClone       ) then fdNonERPClone_Check_At      := now + Taskinterval(fdNonERPClone_Check_Interval);

end;
     {$ENDIF}

destructor TModUserUtils.Destroy;
begin
  try
    AppUserList.Free;

    inherited;
    (*ConfigTextProp.Free;*)
    (*ERPServerNameProp.Free;*)
    (*ERPServerPortProp.Free;*)
  //  LastMasterValidationTimeProp.Free;
     {$IFDEF NewUserUtils}
     {$ELSE}
        fNextUpdateCheckTimeProp.Free;
        NextSMSSendCheckTime.Free;
        NextSMSReceiveCheckTime.Free;
    {$ENDIF}
    //fNextValidateTimeProp.Free;
    fDbListJsonTextProp.Free;
    //fNextOffsiteBackupCheckTime.Free;
    CustomProcessList.Free;
  except

  end;
end;

//procedure TModUserUtils.DoGoogleProgress(var Abort: boolean);
//begin
//  if Terminated then
//    Abort := true;
//end;

//procedure TModUserUtils.DoOnAuditTrailPurgeProgress(Sender: TObject);
//var
//  fPercent: integer;
//begin
//  fPercent := Trunc((TAuditTrailPurge(Sender).RecordNumber / TAuditTrailPurge(Sender).RecordCount) * 100);
//
//  if fAuditTrailPurgeProgressPercent <> fPercent then begin
//    fAuditTrailPurgeProgressPercent := fPercent;
//    Log('Purging Audit Trail ' + TAuditTrailPurge(Sender).Connection.Database +
//      ' to file: '  + TAuditTrailPurge(Sender).CurrentPurgeFile + ': ' + IntToStr(fPercent) + '%', ltDetail);
//  end;
//end;

procedure TModUserUtils.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;

end;

procedure TModUserUtils.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;

end;

//procedure TModUserUtils.DoOnEmailProgress(const msg: string;
//  var Continue: boolean);
//begin
//  Continue := not Terminated;
//  if Continue then begin
//    Log(MailReader.Connection.Database + ' ' + MailReader.EmailAddress + ' ' + msg, ltDetail);
//  end
//  else begin
//    Log(ClassName + ' terminated, aborting email check during OnProgress event.',ltDetail);
//  end;
//end;

procedure TModUserUtils.DoOnMessage(aClientId: integer; aData: TJsonObject; ctx: TJsonObject);
begin
  inherited;

end;

procedure TModUserUtils.DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject);
var
  methodName: string;
  idx: integer;
begin
  inherited;
  if Terminated  then
    exit;
  methodName:= Lowercase(aData);
  try
    idx:= Pos('.',methodName);
    if idx > 0 then
      methodName:= Copy(methodName,idx+1,Length(methodName));

    if SameText(methodName,'Disconnect') then begin
      ctx.B['Handled'] := true;
      AppUserList.RemoveUser(aClientId);
    end;
  except
    on e: exception do begin
      Log('Exception while processing message ' + methodName + ': ' + e.Message,ltError);

    end;
  end;

end;

procedure TModUserUtils.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;
end;

procedure TModUserUtils.DoOnRequest(aClientId: integer; aRequest: TJsonObject;
  ctx: TJsonObject; aResponse: TJsonObject);
var
  methodName: string;
  idx: integer;
  lst: TList;
  ClientNotificationItem: TClientNotificationItem;
  NotificationType: string;
  x: integer;
  FreeSpaceGigaBytes: double;
  StoredConfig: TClientConfig;
  Json: TJsonObject;
  Licence: TSoftwareLicence;
  softwarename: string;
  reason: string;
  msg: string;
  DBBackup: TDBBackup;
  TaskStart: TDateTime;
  TaskFinished: boolean;
  TaskMessage: string;
  UpdateBaseDir: string;
  UpdateInfo, verList: TJsonObject;
begin
  if Terminated or (not Active) then exit;

  methodName:= Lowercase(aRequest.S['method']);
  try
    Log('Request: ' + methodName, ltDetail);
    try
         if Assigned(aResponse) then aResponse.B['RequestHandled'] := true;
         inherited;

         if ctx.B['Handled'] = true then exit;

         idx := Pos('.', methodName);
         if idx > 0 then methodName := Copy(methodName, idx+1, Length(methodName));

{------} if SameText(methodName, 'RegisterForNotification') then begin
              if Assigned(aResponse) then aResponse.B['RequestHandled'] := true;

              if aRequest.ObjectExists('params') and aRequest.O['params'].StringExists('NotificationType') then
                NotificationType := aRequest.O['params'].S['NotificationType']
              else
                NotificationType := '';

              lst:= ClientNotificationList.LockList;
              try
                ClientNotificationItem := TClientNotificationItem.Create;
                ClientNotificationItem.ClientId := aClientID;
                ClientNotificationItem.NotificationName:= NotificationType;
                lst.Add(ClientNotificationItem);
                AddResultOk(aResponse);

              finally
                ClientNotificationList.UnlockList;
              end;
{------} end else if SameText(methodName, 'DeregisterForNotification') then begin
              if Assigned(aResponse) then aResponse.B['RequestHandled'] := true;
              if aRequest.ObjectExists('params') and aRequest.O['params'].StringExists('NotificationType') then
                NotificationType := aRequest.O['params'].S['NotificationType']
              else
                NotificationType := '';
              Log('Removing notification list item, ClientId: ' + IntToStr(aClientId) + ', Type: ' + NotificationType, ltDetail);

              lst:= ClientNotificationList.LockList;
              try
                x:= 0;
                while x < lst.Count do begin
                  ClientNotificationItem := TClientNotificationItem(lst[x]);
                  if (ClientNotificationItem.ClientId = aClientID) and
                    ((NotificationType = '') or
                     (SameText(NotificationType,ClientNotificationItem.NotificationName))) then
                    lst.Delete(x)
                  else
                    Inc(x);
                end;
                AddResultOk(aResponse);
              finally
                ClientNotificationList.UnlockList;
              end;
{------} end else if SameText(methodName, 'BatchUpdate') then begin
              if Assigned(aResponse) then aResponse.B['RequestHandled'] := True;
              aResponse.O['result'].S['TaskID'] := ThreadTaskList.AddTask(TBatchUpdateModuleThreadTask.Create, aClientId, aRequest.O['params'], MySQLServer);
{------} end else if SameText(methodName, 'startsession') then begin
              if Assigned(aResponse) then
                aResponse.S['result']:= 'ok';
{------} end else if SameText(methodName, 'forcelicencecheck') then begin
              fdValidateTime_Check_at := now;////NextValidateTime := now;
              fbEnable_ValidateTime_Check_OnStartup := True;
             JsonRPCUtils.AddResultOk(aResponse);
{------} end else if SameText(methodName, 'forcelicencereset') then begin
              ClientConfig := '';
              fdUpdateBatch_Check_At := Now;  //NextUpdateCheckTime := now;
              fbEnable_UpdateBatch_Check_OnStartup := True;
              JsonRPCUtils.AddResultOk(aResponse);
{------} end else if SameText(methodName, 'forceupdatecheck') then begin
              fdUpdateBatch_Check_At := Now;//NextUpdateCheckTime := now;
              fbEnable_UpdateBatch_Check_OnStartup := True;
              JsonRPCUtils.AddResultOk(aResponse);
{------} end else if SameText(methodName, 'ping') then begin
              aResponse.S['result']:= 'ok';
              AppUserList.UpdateItemLastTime(aClientId);
{------} end else if SameText(methodName, 'log') then begin
              { log somthing to the modules log file }
              if aRequest.ObjectExists('params') and aRequest.O['params'].StringExists('message') then begin
                try
                  if aRequest.O['params'].StringExists('type') then
                    Log(aRequest.O['params'].S['message'],
                      StrToLogMessageType(aRequest.O['params'].S['type']))
                  else
                    Log(aRequest.O['params'].S['message'],ltNone);
                except
                end;
              end;
{------} end else if SameText(methodName, 'validate') then begin
              { grant this user access to ERP? ... }
              if aRequest.ObjectExists('params') then begin
                FreeSpaceGigaBytes := ModuleDbUtils.MySQLDriveFreeSpaceGigaBytes(MySQLServer);
                if not CommsOkWithHeadOffice then begin
                  aResponse.O['result'].B['valid'] := false;
                  aResponse.O['result'].S['reason'] :=
                    'ERP Server Menu has been unable to communicate ' +
                    'with ERP Head Office Server to validate your ERP licence information.' +
                    #13#10 + #13#10 +
                    'Please ensure that Ports 3309 (MySQL), 3310 (ERP) and 49500 (Server Menu)' +
                    ' are open for communication both ways on your router, firewalls and ' +
                    'virus scanner before contacting ERP';
                end
                else if (FreeSpaceGigaBytes <> -1) and (FreeSpaceGigaBytes < 2.0) then begin
                  aResponse.O['result'].B['valid']:= false;
                  aResponse.O['result'].S['reason']:=
                    'There is less than 2Gb of free disk space available on the server where MySQL is installed, ' +
                    'please free up at least 2Gb of space.';
                end
                else begin
                  StoredConfig := TClientConfig.Create;
                  try
                    Json:= JO;
                    try
      //                Json.AsString := ConfigText;
                      Json.AsString := ClientConfig;
                      JsonToObj(Json.O['clientconfig'], StoredConfig);
                    finally
                      Json.Free;
                    end;

                    softwarename := aRequest.O['params'].S['softwarename'];
                    Licence := StoredConfig.LicenceByName(GetPcName, softwarename);

                    if Assigned(Licence) then begin
                      if not Licence.IsLicenced(reason) then begin
                        aResponse.O['result'].B['valid'] := false;
                        aResponse.O['result'].S['reason'] := reason;
                      end
                      else begin
                        if AppUserList.DatabaseUserCount('') >= Licence.ConcurrentUsers then begin
                          aResponse.O['result'].B['valid'] := false;
                          aResponse.O['result'].S['reason'] :=
                            'Maximum number of licensed users reached.';
                        end
                        else begin
                          if AppUserList.AddUser(
                              msg,
                              aRequest.O['params'].S['user'],
                              aRequest.O['params'].S['databasename'],
                              aRequest.O['params'].S['organisationkey'],
                              aClientId,
                              aRequest.O['params'].S['firstname'],
                              aRequest.O['params'].S['lastname'],
                              aRequest.O['params'].B['multilogon'],
                              aRequest.O['params'].B['SystemUser']) then begin
                            { all ok }
                            aResponse.O['result'].B['valid']:= true;
                            aResponse.O['result'].S['serverversion']:= ServerVersion;
                            aResponse.O['result'].S['moduleversion']:= ModuleVersion;
                          end
                          else begin
                            aResponse.O['result'].B['valid']:= false;
                            aResponse.O['result'].S['reason']:= msg;
                          end;
                        end;
                      end;
                    end
                    else begin
                      { this is mainly to cater for older version of erp client ... so they can still log in  }
                      if softwarename = '' then begin
                        aResponse.O['result'].B['valid']:= true;
                        aResponse.O['result'].S['serverversion']:= ServerVersion;
                        aResponse.O['result'].S['moduleversion']:= ModuleVersion;
                      end
                      else begin
                        aResponse.O['result'].B['valid']:= false;
                        aResponse.O['result'].S['reason']:=
                          'No Licence information found for "' + aRequest.O['params'].S['software'] +
                          '" on the server "' + GetPcName + '".';
                      end;
                    end;
                  finally
                    StoredConfig.Free;;
                  end;

                end;
              end
              else begin
              end;
{------} end else if SameText(methodName, 'adduser') then begin
              { grant this user access to ERP? ... }
              if aRequest.ObjectExists('params') then begin
                  if AppUserList.AddUser(
                    msg,
                    aRequest.O['params'].S['user'],
                    aRequest.O['params'].S['databasename'],
                    aRequest.O['params'].S['organisationkey'],
                    aClientId,
                    aRequest.O['params'].S['firstname'],
                    aRequest.O['params'].S['lastname'],
                    aRequest.O['params'].B['multilogon'],
                    aRequest.O['params'].B['SystemUser']) then begin
                    { all ok }
                    aResponse.O['result'].B['ok']:= true;
                    aResponse.O['result'].S['serverversion']:= ServerVersion;
                    aResponse.O['result'].S['moduleversion']:= ModuleVersion;
                  end;
              end;
{------} end else if SameText(methodName, 'removeuser') then begin
              if aRequest.ObjectExists('params') then begin
                AppUserList.RemoveUser(aRequest.O['params'].S['user'],aRequest.O['params'].S['databasename']);
                JsonRPCUtils.AddResultOk(aResponse);
              end
              else
               JsonRPCUtils.AddResultError(aResponse, 'Parameters missing from ' + methodName + ' request.');
{------} end else if SameText(methodName, 'getlicence') then begin
              if aRequest.ObjectExists('params') and aRequest.O['params'].StringExists('softwarename') then begin
                StoredConfig := TClientConfig.Create;
                try

                  Json:= JO;
                  try
      //              Json.AsString := ConfigText;
                    Json.AsString := ClientConfig;
                    JsonToObj(Json.O['clientconfig'],StoredConfig);
                  finally
                    Json.Free;
                  end;

                  Licence:= StoredConfig.LicenceByName(GetPcName,aRequest.O['params'].S['softwarename']);
                  if Assigned(Licence) then begin
                    ObjToJson(Licence, aResponse.O['result'].O['licence']);
                  end
                  else begin
                    aResponse.O['error']:= JO('{"code": '+ IntToStr(-1) +
                      ', "message": "No licence info found for ' + aRequest.O['params'].S['softwarename'] + '"}');
                  end;
                finally
                  StoredConfig.Free;
                end;
              end
              else begin
                aResponse.O['error']:= JO('{"code": '+ IntToStr(-1) +
                  ', "message": "Invalid params for getlicence request."}');
              end;
{------} end else if SameText(methodName, 'getserverid') then begin
              aResponse.O['result'].S['serverid']:= self.ServerID;
{------} end else if SameText(methodName, 'getdatabaseusercount') then begin
              if aRequest.O['params'].BooleanExists('ExcludeMultiLogonUsers') then
                aResponse.O['result'].I['usercount']:=
                  AppUserList.DatabaseUserCount(aRequest.O['params'].S['databasename'],aRequest.O['params'].B['ExcludeMultiLogonUsers'])
              else
                aResponse.O['result'].I['usercount']:=
                  AppUserList.DatabaseUserCount(aRequest.O['params'].S['databasename']);
{------} end else if SameText(methodName, 'locklogon') then begin
              if aRequest.O['params'].S['lockreason'] <> '' then begin
                  if AppUserList.LockLogon(msg,aClientId,aRequest.O['params'].S['databasename'],aRequest.O['params'].S['lockreason']) then begin
                    aResponse.O['result'].B['ok']:= true;
                    aResponse.O['result'].S['reason']:= '';
                  end
                  else begin
                    aResponse.O['result'].B['ok']:= false;
                    aResponse.O['result'].S['reason']:= msg;
                  end;
              end
              else begin
                aResponse.O['error']:= JO('{"code": '+ IntToStr(-1) +
                  ', "message": "Invalid params for locklogon request, lockreason missing."}');
              end;
{------} end else if SameText(methodName, 'unlocklogon') then begin
              AppUserList.UnlockLogon(aClientId);
{------} end else if SameText(methodName,'getuserlist') then begin
              aResponse.O['result'].S['userlist']:=
                AppUserList.UserNameList(aRequest.O['params'].S['databasename']);
{------} end else if SameText(methodName, 'getfulluserlist') then begin
                aResponse.O['result'].O['userlist'].Assign(AppUserList.ListAsJson);
{------} end else if SameText(methodName, 'getbackuparchivelist') then begin
              DBBackup:= TDBBackup.Create;
              try
                DBBackup.ServerName := MySQLServer;
                aResponse.S['result']:= DBBackup.ArchiveList;
              finally
                DBBackup.Free;
              end;
{------} end else if SameText(methodName, 'getdatabaselist') then begin
              DBBackup:= TDBBackup.Create;
              try
                DBBackup.ServerName := MySQLServer;
                if aRequest.ObjectExists('params') and aRequest.O['params'].StringExists('servername') then
                  DBBackup.ServerName:= aRequest.O['params'].S['servername'];
                if DBBackup.ServerName = '' then
                  DBBackup.ServerName := MySQLServer;
                aResponse.S['result']:= DBBackup.DatabaseList(true);
              finally
                DBBackup.Free;
              end;
{------} end else if SameText(methodName, 'dbbackup') then begin
              { first register this client connection for progress notificationd }
              lst:= ClientNotificationList.LockList;
              try
                ClientNotificationItem := TClientNotificationItem.Create;
                ClientNotificationItem.ClientId := aClientID;
                ClientNotificationItem.NotificationName:= 'Progress';
                lst.Add(ClientNotificationItem);
              finally
                ClientNotificationList.UnlockList;
              end;

              { create and start the thread task }
              TaskFinished := False;
              aResponse.O['result'].S['TaskID']:=
                ThreadTaskList.AddTask(TBackupModuleThreadTask.Create,aClientId,aRequest.O['params'], MySQLServer);
              (*while  ThreadTaskList.GetTaskStatus(aResponse.O['result'].S['TaskID'],TaskFinished,TaskStart,TaskMessage) and not(TaskFinished) do begin
                aResponse.O['result'].S['TaskMessage'] := TaskMessage;
                sleep(100);
              end;
              aResponse.O['result'].B['TaskFinished'] :=TaskFinished;*)
{------} end else if SameText(methodName, 'gettaskstatus') then begin
              if ThreadTaskList.GetTaskStatus(aRequest.O['params'].S['TaskID'],TaskFinished,TaskStart,TaskMessage) then begin
                aResponse.O['result'].B['TaskFound']:= true;
                aResponse.O['result'].B['TaskFinished']:= TaskFinished;
                aResponse.O['result'].B['WasTaskError']:= false;
                aResponse.O['result'].DT['TaskStart']:= TaskStart;
                aResponse.O['result'].DT['TaskFinish']:= 0;
                aResponse.O['result'].S['TaskMessage']:= TaskMessage;
              end
              else begin
                aResponse.O['result'].B['TaskFound']:= false;
              end;
{------} end else if SameText(methodName, 'removetask') then begin
              ThreadTaskList.RemoveTask(aRequest.O['params'].S['TaskID']);
              aResponse.O['result'].S['Result']:= 'ok';
{------} end else if SameText(methodName, 'forceupdatecheck') then begin
                if aRequest.O['params'].Count > 0 then
                  DbListJsonText := aRequest.O['params'].AsString;
                fdUpdateBatch_Check_At:= Now;//NextUpdateCheckTime:= now;
                fbEnable_UpdateBatch_Check_OnStartup := True;
                aResponse.B['result'] := True;
{------} end else if SameText(methodName, 'getuserupdateinfo') then begin
              UpdateBaseDir:= ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Updates\';
              UpdateInfo:= TJsonObject.Create;
              try
                EncryptedFileToJson(UpdateInfo,UpdateBaseDir + 'erpupdatedetails.dat');
                verList:= UpdateInfo.O['updates'].O['erp'].O['versions'].O[SoftwareReleaseType];
                if verList.ObjectExists(aRequest.O['params'].S['version']) then begin
                  aResponse.O['result'].S['module']:= 'erp';
                  aResponse.O['result'].S['softwarereleasetype']:= SoftwareReleaseType;
                  aResponse.O['result'].O['update'].Assign(verList.O[aRequest.O['params'].S['version']]);
                end
                else begin
                  aResponse.O['error'].I['code']:= -1;
                  aResponse.O['error'].S['message']:= 'Update information not found.';
                end;
              finally
                UpdateInfo.Free;
              end;
{------} end else if SameText(methodName, 'getfileinfo') then begin
              ModuleServerUtils.JsonDoGetFileInfo(aRequest, aResponse);
{------} end else if SameText(methodName, 'getfilepart') then begin
              ModuleServerUtils.JsonDoGetFilePart(aRequest, aResponse);
{------} end else if SameText(methodName, 'deletefile') then begin
              if (not FileExists(aRequest.O['params'].S['filename'])) or
                 SysUtils.DeleteFile(aRequest.O['params'].S['filename']) then
                aResponse.B['result']:= true
              else
                aResponse.B['result']:= false;
{------} end else if methodName = 'deletefiles' then begin
              DoDeleteFiles(aRequest.O['params'].S['filename']);
              JsonRPCUtils.AddResultOk(aResponse);
{------} end else if SameText(methodName, 'GetConfig') then begin
              ObjToJson(self, aResponse.O['result']);
{------} end else if SameText(methodName, 'SetConfig') then begin
              if aRequest.ObjectExists('params') then begin
                JsonToObj(aRequest.O['params'],self);
                //self.SaveConfig(true);
                self.SaveConfig;
                JsonRPCUtils.AddResultOk(aResponse);
              end
              else begin
                AddResultError(aResponse,'Params object missing from request',RPC_INVALID_PARAMS);
              end;
{------} end else if SameText(methodName, 'GetLoggingLevel') then begin
              aResponse.O['result'].S['LoggingLevel']:= LoggingLevelToStr(self.LoggingLevel);
{------} end else if SameText(methodName,'SetLoggingLevel') then begin
              if aRequest.ObjectExists('params') then begin
                Self.LoggingLevel := StrToLoggingLevel(aRequest.O['params'].S['LoggingLevel']);
      //          self.SaveConfig(true);
                self.SaveConfig;
                JsonRPCUtils.AddResultOk(aResponse);
              end
              else begin
                JsonRPCUtils.AddResultError(aResponse,'Params object missing from request',RPC_INVALID_PARAMS);
              end;
{------} end else if SameText(methodName, 'GetSoftwareReleaseType') then begin
              aResponse.O['result'].S['SoftwareReleaseType']:=  SoftwareReleaseType;
{------} end else if SameText(methodName, 'SMSSend') then begin
              {$IFDEF NewUserUtils} fdSMSSend_Check_At := now;      fbEnable_SMSSend_Check_OnStartup := True;{$ELSE}NextSMSSendCheckTime.AsDateTime := now;{$ENDIF}
{------} end else if SameText(methodName, 'SMSCheck') then begin
              {$IFDEF NewUserUtils} fdSMSReceive_Check_At := now;       fbEnable_SMSReceive_Check_OnStartup := True; {$ELSE}NextSMSReceiveCheckTime.AsDateTime := now;{$ENDIF}
{------} end else if SameText(methodName,'GetTaskList') then begin
              ThreadTaskList.GetTaskListAsJson(aResponse.O['result']);
{------} end else begin
              AddResultError(aResponse, 'Request method (' + methodName + ') not found',RPC_METHOD_NOT_FOUND);
{------} end;

          finally
            Log('Request: ' +  methodName + ' done.', ltDetail);
        //    if Assigned(aResponse) then begin
        //      if aResponse.Exists('result') then
        //        Log('Result: ' + aResponse.ItemByName['result'].Value.AsString,ltDetail);
        //    end;
          end;
  except
    on e: exception do begin
      Log('Exception while processing request ' + methodName + ': ' + e.Message,ltError);

    end;
  end;
end;

procedure TModUserUtils.DoWork;
var
  params: TJsonObject;

 {$IFDEF NewUserUtils}
  function IsTaskEnabled(Const aTaskEnabledonStartup, aTaskEnabled: Boolean): Boolean;
  begin
    (*if not(fbStarted) then result := aTaskEnabledonStartup or aTaskEnabled
    else result :=aTaskEnabled;*)
    Result := aTaskEnabledonStartup or aTaskEnabled;
  end;

  procedure LogTaskRunMsg(const aTaskName: String; Const aTaskDone, aTaskEnabled: Boolean; aTaskInterval: Double);
  var
    s : String;
  begin
    s := aTaskName;
    if aTaskEnabled then s := s + ', Enabled' else s := s + ', Disabled';
    if aTaskDone then
      s:= s + ', Repeat in ' + FloatToStr(aTaskInterval) + ' min'
    else
      s := s + ', not due yet';
    Log(s, ltDetail);
  end;

  function DoTask(Var CheckOnStartupenabled: Boolean; CheckOnIntervalenabled: Boolean;
                  fd_Interval: Integer;
                  var NextCheckAt: TDateTime;
                  ThreadTask: TServerModuleThreadTaskClass;
                  TaskDesc: String;
                  aparams: TJSONObject = nil): Boolean;
  var
    fs: string;
  begin
    Result := False;
    //LogCurtime(TaskDesc +' at :' + formatdatetime('hh:nn:ss', NextCheckAt) +'     ');
    fs := TaskDesc + ' #' + IntToStr(fiWorkno) + ' at :' + FormatDateTime('hh:nn:ss', NextCheckAt);
    try
      if IsTaskEnabled(CheckOnStartupenabled, CheckOnIntervalenabled) then begin
        try
          if NextCheckAt <= Now() then begin
            if ThreadTask <> nil then begin
              fs := fs + '-' + ThreadTask.ClassName;
              if ThreadTaskList.ListContainsTask(ThreadTask.ClassName) then begin
                fs := fs + '-Running';
                NextCheckAt := Now + fd_Interval / OneMinute;
                LogTaskRunMsg('1: ' + TaskDesc, true, true, fd_Interval);
                Log('1: Can''t start ' + TaskDesc + ', ' + TaskDesc + ' still running, will try again At : ' + formatdatetime('dd-mm-yy hh:nn:ss' ,NextCheckAt)+'.',ltInfo);
                Exit;
              end;

              try
                fs := fs + '-Starting';
                LogTaskRunMsg('2: ' + TaskDesc, true, true, fd_Interval);
                ThreadTaskList.StartTask(ThreadTask, 0, aparams, MySQLServer);
                fs := fs + '-Started';
                if CheckOnStartupenabled then CheckOnStartupenabled := False;
              finally
                NextCheckAt := Now + fd_Interval;
                LogTaskRunMsg('3: ' + TaskDesc, true, true, fd_Interval);
                Log('Next ' + quotedstr(TaskDesc) + ' At : ' + formatdatetime('dd-mm-yy hh:nn:ss', NextCheckAt), ltDetail);
                fs := fs + '-Next Check at ' + formatdatetime('dd-mm-yy hh:nn:ss', NextCheckAt);
              end;
            end else begin
              NextCheckAt := Now + fd_Interval;
              fs := fs + '-Thread = Nil';
            end;
            Result := TRue;
          end else begin
            //LogTaskRunMsg('4:' +TaskDesc , False, true, fd_Interval);
          end;
        except
          on E: Exception do
          begin
            Log('Error Starting ' + TaskDesc + ' Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;
      end else begin
        fs := fs + '-Not Enabled';
        //LogTaskRunMsg('5: ' + TaskDesc , False, False, fd_Interval);
      end;
    finally
      //Log(fs, ltInfo);
    end;
  end;
 {$ENDIF}
begin
  inherited;

  try
   {$IFDEF NewUserUtils}
      //LogCurtime('Dowork' );
         fiWorkNo := 0;
      {1}fiWorkNo :=  1; DoTask(fbEnable_AuditTrailPurge_Check_OnStartup , fbEnable_AuditTrailPurge_Check  ,  fdAuditTrailPurge_Check_Interval , fdAuditTrailPurge_Check_At , TAuditPurgeThreadTask,      utTaskAuditTrailPurge);
      {2}fiWorkNo :=  2; DoTask(fbEnable_GoLive_Check_OnStartup          , fbEnable_GoLive_Check           ,  fdGoLive_Check_Interval          , fdGoLive_Check_At          , TGoLiveSchedulerThreadTask, utTaskGoLive);
      {3}fiWorkNo :=  3; DoTask(fbEnable_Email_Check_OnStartup           , fbEnable_Email_Check            ,  fdEmail_Check_Interval           , fdEmail_Check_At           , TEmailCheckThreadTask,      utTaskEmail);
      {4}fiWorkNo :=  4; DoTask(fbEnable_DeleteTempTables_Check_OnStartup, fbEnable_DeleteTempTables_Check ,  fdDeleteTempTables_Check_Interval, fdDeleteTempTables_Check_At, TDeleteTempTablesTask ,     utTaskDeleteTempTables);
      {5}params := JO;
         try
          params.I['SynchType'] := Ord(gsCalendar);
          params.S['ServerId'] := Self.ServerID;
          fiWorkNo:=  5; DoTask(fbEnable_GoogleCalendar_Check_OnStartup, fbEnable_GoogleCalendar_Check, fdGoogleCalendar_Check_Interval, fdGoogleCalendar_Check_At, TGoogleCalendarThreadTask, utTaskGoogleCalendar, Params);
         finally
            params.Free;
         end;
      {6}params := JO;
         try
            params.I['SynchType'] := Ord(gsERPCalandar);
            params.S['ServerId'] := Self.ServerID;
            fiWorkNo:=  6; DoTask(fbEnable_GoogleAppointment_Check_OnStartup, fbEnable_GoogleAppointment_Check, fdGoogleAppointment_Check_Interval, fdGoogleAppointment_Check_At, TGoogleCalendarThreadTask, utTaskGoogleAppointment, Params);
         finally
            params.Free;
         end;
      {7}params := JO;
         try
            params.I['SynchType'] := Ord(gsTask);
            params.S['ServerId'] := Self.ServerID;
            fiWorkNo:=  7; DoTask(fbEnable_GoogleTask_Check_OnStartup,fbEnable_GoogleTask_Check      ,fdGoogleTask_Check_Interval, fdGoogleTask_Check_At, TGoogleCalendarThreadTask, utTaskGoogleTaskCheck, Params);
         finally
            params.Free;
         end;
      {8}params := JO;
         try
            params.S['ServerId'] := Self.ServerID;
            fiWorkNo:=  8; DoTask(fbEnable_GoogleQueue_Check_OnStartup, fbEnable_GoogleQueue_Check ,fdGoogleQueue_Check_Interval   ,  fdGoogleQueue_Check_At, TGoogleQueueThreadTask,utTaskGoogleQueue, Params);
         finally
            params.Free;
         end;
      {9}params := JO;
         try
            params.I['CheckType'] := Ord(scSend);
            fiWorkNo:=  9; DoTask(fbEnable_SMSSend_Check_OnStartup, fbEnable_SMSSend_Check,fdSMSSend_Check_Interval   ,  fdSMSSend_Check_At	,TSMSCheckThreadTask, utTaskSMSSend , Params);
         finally
            params.Free;
         end;
      {10}params := JO;
         try
            params.I['CheckType'] := Ord(scReceive);
            fiWorkNo:=  10; DoTask(fbEnable_SMSReceive_Check_OnStartup, fbEnable_SMSReceive_Check,fdSMSReceive_Check_Interval   ,  fdSMSReceive_Check_At	,TSMSCheckThreadTask, utTaskSMSReceive , Params);
         finally
            params.Free;
         end;
      if Terminated then Exit;
      {11}fiWorkNo:= 11; DoTask(fbEnable_Ping_Check_OnStartup, fbEnable_Ping_Check,fdPing_Check_Interval   ,  fdPing_Check_At	,TPingCheckThreadTask, utTaskPing );
      {12}fiWorkNo:= 12; DoTask(fbEnable_Validatetime_Check_OnStartup, fbEnable_Validatetime_Check,fdValidateTime_Check_Interval   ,  fdValidateTime_Check_At	,TLicenceCheckThreadTask, utLicenseCheck );
      {13}fiWorkNo:= 13; DoTask(fbEnable_InactiveUser_Check_OnStartup, fbEnable_InactiveUser_Check, fdInactiveUser_Check_Interval   ,  fdInactiveUser_Check_At	,TInactiveUserCheckThreadTask, utTaskInactiveUser );
      {14}params := JO;
          try
            DbListJsonText := '';
            params.S['SoftwareReleaseType'] := SoftwareReleaseType;
            if CommonConfig.BooleanExists('IsCloudServer')  and CommonConfig.B['IsCloudServer'] then begin
              params.O['DbList'].A['List'].Add(JO('{"DatabaseName":"erpnewdb"}'));{ only update erpnewdb }
            end else params.O['DbList'].AsString := DbListJsonText;
            params.S['MySQLServer'] := MySQLServer;
            fiWorkNo:=  14; DoTask(fbEnable_UpdateBatch_Check_OnStartup, fbEnable_UpdateBatch_Check, fdUpdateBatch_Check_Interval, fdUpdateBatch_Check_At, TUpdateCheckModuleThreadTask, utTaskUpdatebatch, Params);
          finally
            params.Free;
            DbListJsonText:= '';
            Randomize;
          end;
      {15}fiWorkNo:=  15; if DoTask(fbEnable_General_Check_OnStartup, fbEnable_General_Check,fdGeneral_Check_Interval   ,  fdGeneral_Check_At	,nil, utTaskGeneralcheck ) then begin
            TSharedAppUserList.ExRemoveUser(ErpDbMaintObj.ERP_ADMIN_USER_DB_MAINT, MySQLServer);
          end;
       {16}  fiWorkNo:=  16; DoTask(fbEnable_ScheduledReports_Check_OnStartup  ,fbEnable_ScheduledReports_Check,fdScheduledReports_Check_Interval   ,  fdScheduledReports_Check_At	,TReportSchedulerThreadTask, utTaskScheduledreports );
       {17}  fiWorkNo:=  17; DoTask(fbEnable_FileCleanup_Check_OnStartup  ,fbEnable_FileCleanup_Check,fdFileCleanup_Check_Interval   ,  fdFileCleanup_Check_At	,TFileCleanupModuleThreadTask, utTaskCleanup );
       {18}  //if DoTask(fbEnable_DocDownload_Check_OnStartup  ,fbEnable_DocDownload_Check,fdDocDownload_Check_Interval   ,  fdDocDownload_Check_At	,nil, utTaskDocdownload ) then begin
              if IsTaskEnabled(fbEnable_DocDownload_Check_OnStartup , fbEnable_DocDownload_Check) then begin
                  if not fDocDBStrucCheckDone then begin
                    fDocDBStrucCheckDone := true;
                    try
                      with TERPDocsDB.Create do begin
                        Server := MySQLServer;
                        Free;
                      end;
                    except
                      on e: exception do begin
                        Log('Error checking Document Database Structure: ' + e.Message,ltError);
                      end;
                    end;
                  end;
                  fiWorkNo:=  18; DoTask(fbEnable_DocDownload_Check_OnStartup  ,fbEnable_DocDownload_Check,fdDocDownload_Check_Interval   ,  fdDocDownload_Check_At, TDocDownloadCheckThreadTask, utTaskDocdownload ) ;
                  //fbEnable_DocDownload_Check_OnStartup:= False;
                  Exit;
             end;
             fiWorkNo:=  18; DoTask(fbEnable_DocDownload_Check_OnStartup, fbEnable_DocDownload_Check,fdDocDownload_Check_Interval, fdDocDownload_Check_At	,TDocDownloadCheckThreadTask, utTaskDocdownload );
       {19}fiWorkNo:=  19; DoTask(fbEnable_CustomProcess_Check_OnStartup, fbEnable_CustomProcess_Check,fdCustomProcess_Check_Interval, fdCustomProcess_Check_At, TCustomProcessCheckThreadTask, utTaskCustomProcess);
       {20}params := JO;
          try
            params.S['OffsiteBackupConfigText'] := Self.OffsiteBackupConfigText;
            params.S['OffsiteRestoreConfigText'] := Self.OffsiteRestoreConfigText;
            params.S['ConfigText'] := self.ClientConfig;
            fiWorkNo := 20; DoTask(fbEnable_OffsiteBackup_Check_OnStartup, fbEnable_OffsiteBackup_Check, fdOffsiteBackup_Check_Interval, fdOffsiteBackup_Check_At, TOffsiteBackupThreadTask, utTaskOffsiteBackup , Params);
          finally
            params.Free;
         end;
        {21}fiWorkNo := 21; DoTask(fbEnable_ClearInUseTables_Check_OnStartup, fbEnable_ClearInUseTables_Check, fdClearInUseTables_Check_Interval, fdClearInUseTables_Check_At, TClearInUseTablesThreadTask, utTaskClearInUseTables);
        if (fdNonERPClone_Check_At < now) and (fdNonERPClone_Check_At <> 0) then
        {22}fiWorkNo := 22; if DoTask(fbEnable_NonERPClone_Check_OnStartup, fbEnable_NonERPClone_Check, fdNonERPClone_Check_Interval, fdNonERPClone_Check_At, TBatchUpdateModuleThreadTask, utTaskNonERPClone) then
                fdNonERPClone_Check_At := Now + (Onehour * 24)
            else fdNonERPClone_Check_At := Now + (oneminute);
        //Sleeptime:= 50000;
   {$ELSE}
      {1}try
          LogCurtime('Audit Trail Purge ' );
          if (Trunc(now) > Trunc(LastAuditTrailPurgeCheckTime)) and ((now - fStartTime) >= OneMinute) then begin
            try
      //        if cfg.B['DoPurge'] then
              ThreadTaskList.AddTask(TAuditPurgeThreadTask.Create, 0, nil, MySQLServer);
        //      self.CheckAuditTrailPurge;
            finally
              LastAuditTrailPurgeCheckTime := Trunc(now);
      //        self.SaveConfig(true);
              self.SaveConfig;
            end;
          end;
        except
          on e: exception do begin
            Log('Error adding Audit Trail Purge Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {2}try
          LogCurtime('GoLive Check ' );
          if fNextGoLiveCheckTime <= Now() then
          try
            ThreadTaskList.StartTask(TGoLiveSchedulerThreadTask, 0, nil, MySQLServer);
          finally
            fNextGoLiveCheckTime := Now + GOLIVE_CHECK_INTERVAL;
            Log('Next Go Live At : '              + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoLiveCheckTime                  ), ltDetail);
          end;
        except
          on E:Exception do
          begin
            Log('Error Starting GoLive Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;

        end;

        {3}try
          LogCurtime('Email Check ' );
          if fNextEmailCheckTime <= now then begin
            try
        //      CheckEmails;
      //        if cfg.B['DoEmailCheck'] then
              ThreadTaskList.StartTask(TEmailCheckThreadTask, 0, nil, MySQLServer);
            finally
              fNextEmailCheckTime := now + EMAIL_CHECK_INTERVAL;
              Log('Next Email check At : '          + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextEmailCheckTime                   ), ltDetail);
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting Email Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {4}try
          LogCurtime('Delete Temp Tables check' );
          if fNextDeleteTempTables <= now then begin
            try
              ThreadTaskList.StartTask(TDeleteTempTablesTask, 0, nil, MySQLServer);
            finally
              fNextDeleteTempTables := now + 999; // only do after restart
              //Log('Next Delete Temp Tables At : '   + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextDeleteTempTables                 ), ltDetail);
            end;
          end;
        except
          on e: exception do begin
            Log('Error Starting Delete Temp Tables check: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;


        {5}try
          LogCurtime('Google Calendar check' );
          if fNextGoogleCalendarCheckTime <= now then begin
            params := JO;
            try
        //      CheckGoogle(gsCalendar);
              params.I['SynchType'] := Ord(gsCalendar);
              params.S['ServerId'] := self.ServerID;
      //        if cfg.B['DoGoogleCalendar'] then
              ThreadTaskList.StartTask(TGoogleCalendarThreadTask, 0, params, MySQLServer);
            finally
              fNextGoogleCalendarCheckTime := now + GOOGLE_CALENDAR_CHECK_INTERVAL;
              Log('Next Google Calendar At : '      + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleCalendarCheckTime          ), ltDetail);
              params.Free;
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting Google Calendar Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {6}try
          LogCurtime('Appointment check' );
          if fNextGoogleAppointmentCheckTime <= now then begin
            params := JO;
            try
        //      CheckGoogle(gsERPCalandar);
              params.I['SynchType'] := Ord(gsERPCalandar);
              params.S['ServerId'] := self.ServerID;
      //        if cfg.B['DoGoogleCalendar'] then
              ThreadTaskList.StartTask(TGoogleCalendarThreadTask, 0, params, MySQLServer);
            finally
              fNextGoogleAppointmentCheckTime := now + GOOGLE_APPOINTMENT_CHECK_INTERVAL;
              Log('Next Google Appt At : '          + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleAppointmentCheckTime       ), ltDetail);
              params.Free;
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting Google Appointment Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {7}try
          LogCurtime('Task check' );
          if fNextGoogleTaskCheckTime <= now then begin
            params := JO;
            try
        //      CheckGoogle(gsTask);
              params.I['SynchType'] := Ord(gsTask);
              params.S['ServerId'] := self.ServerID;
      //        if cfg.B['DoGoogleCalendar'] then
              ThreadTaskList.StartTask(TGoogleCalendarThreadTask, 0, params, MySQLServer);
            finally
              fNextGoogleTaskCheckTime := now + GOOGLE_TASK_CHECK_INTERVAL;
              Log('Next Google Task At : '          + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleTaskCheckTime              ), ltDetail);
              params.Free;
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting Google Task Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {8}try
          LogCurtime('Que check' );
          if fNextGoogleQueueCheckTime <= now then begin
            params := JO;
            try
        //      CheckGoogleQueue;
              params.S['ServerId'] := self.ServerID;
      //        if cfg.B['DoGoogleQueue'] then
              ThreadTaskList.StartTask(TGoogleQueueThreadTask, 0, params, MySQLServer);
            finally
              fNextGoogleQueueCheckTime := now + GOOGLE_QUEUE_CHECK_INTERVAL;
              Log('Next Google Que At : '           + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGoogleQueueCheckTime             ), ltDetail);
              params.Free;
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting Google Queue Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {9}try
          LogCurtime('SMS check' );
          if NextSMSSendCheckTime.AsDateTime <= now then begin
            params := JO;
            try
        //      CheckSMSs(scSend);
              params.I['CheckType'] := Ord(scSend);
      //        if cfg.B['DoSMSCheck'] then
              ThreadTaskList.StartTask(TSMSCheckThreadTask, 0, params, MySQLServer);
            finally
              NextSMSSendCheckTime.AsDateTime := now + (OneMinute * 15);
              Log('Next SMs Send check At : '       + formatdatetime('dd-mm-yy hh:nn:ss' ,NextSMSSendCheckTime.AsDateTime       ), ltDetail);
              params.Free;
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting SMS Send Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {10}try
          LogCurtime('SMS Receive check' );
          if NextSMSReceiveCheckTime.AsDateTime <= now then begin
            params := JO;
            try
        //      CheckSMSs(scReceive);
              params.I['CheckType'] := Ord(scReceive);
      //        if cfg.B['DoSMSCheck'] then
              ThreadTaskList.StartTask(TSMSCheckThreadTask, 0, params, MySQLServer);
            finally
              NextSMSReceiveCheckTime.AsDateTime := now + (OneMinute * 15);
              Log('Next SMS Receive Check At : '    + formatdatetime('dd-mm-yy hh:nn:ss' ,NextSMSReceiveCheckTime.AsDateTime    ), ltDetail);
              params.Free;
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting SMS Receive Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        if Terminated then  exit;

        {11}try
          { this is to keep server network card awake }
          LogCurtime('Ping check' );
          if NextPingCheckTime <= now then begin
            NextPingCheckTime:= now + (OneMinute * 15);
            Log('Next Ping check At : '           + formatdatetime('dd-mm-yy hh:nn:ss' ,NextPingCheckTime                     ), ltDetail);
        //    InternetConnectivityUtils.InternetAccessOk(false);
      //      if cfg.B['DoPingCheck'] then
            ThreadTaskList.StartTask(TPingCheckThreadTask, 0, nil, MySQLServer);
          end;
        except
          on e: exception do begin
            Log('Error starting Ping Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        if Terminated then  exit;

        {12}try
          LogCurtime('License check' );
          if NextValidateTime <= now then begin
            NextValidateTime:= now + PERIOD_VALIDATION_CHECK;  { default }
            Log('Next Validate Time At : '        + formatdatetime('dd-mm-yy hh:nn:ss' ,NextValidateTime                      ), ltDetail);
        //    CheckLicence;
      //      if cfg.B['DoLicenceCheck'] then

            params := JO;
            try
      //        self.Li

              ThreadTaskList.AddTask(TLicenceCheckThreadTask.Create, 0, nil, MySQLServer);
            finally
              params.Free;
            end;
          end;
        except
          on e: exception do begin
            Log('Error adding Licence Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        if Terminated then exit;

        {13}try
          LogCurtime('Inactive User check' );
          if now > fNextInactiveUserCheckTime then begin
            try
        //        AppUserList.RemoveInactiveUsers(MAX_USER_INACTIVITY_TIME);
      //      if cfg.B['DoInactiveUserCheck'] then
                ThreadTaskList.StartTask(TInactiveUserCheckThreadTask, 0, nil, MySQLServer);

            finally
              fNextInactiveUserCheckTime:= now + USER_INACTIVITY_CHECK_INTERVAL;
              Log('Next At : '                      + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextInactiveUserCheckTime            ), ltDetail);
            end;
          end;
        except
          on e: exception do begin
            Log('Error while removing inactive users: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        if Terminated then exit;
        {14}try
          if now >= NextUpdateCheckTime then begin
            LogCurtime('Batch Update check ='+formatdateTime('dd-mm-yy hh:nn:ss am/pm' , NextUpdateCheckTime)  );
            if ThreadTaskList.ListContainsTask(TBatchUpdateModuleThreadTask.ClassName) then begin
              NextUpdateCheckTime := NextUpdateCheckTime + (5 * OneMinute);
              Log('Can''t start update check, Batch Update still running, will try again in 5 minutes.',ltInfo);
            end
            else begin
              params := JO;
              try
          //      CheckForUpdates;
                DbListJsonText := '';
                params.S['SoftwareReleaseType'] := SoftwareReleaseType;
                if CommonConfig.BooleanExists('IsCloudServer')  and CommonConfig.B['IsCloudServer'] then begin
                  { only update erpnewdb }
                  params.O['DbList'].A['List'].Add(JO('{"DatabaseName":"erpnewdb"}'));
                end
                else
                  params.O['DbList'].AsString := DbListJsonText;
                params.S['MySQLServer'] := MySQLServer;

        //      if cfg.B['DoUpdateCheck'] then
                ThreadTaskList.AddTask(TUpdateCheckModuleThreadTask.Create, 0, params, MySQLServer);
              finally
                params.Free;
                DbListJsonText:= '';
                { set next check to be between 1 and 2 am.
                  ERPUtilsService will check for service/module updates between
                  midnight and 00:45 }
                NextUpdateCheckTime:= Trunc(now) + 1 + (OneHour);  { 1am next day}
                Randomize;
                { add 0 to 60 random minutes }
                NextUpdateCheckTime:= NextUpdateCheckTime + (Random(60) * (OneMinute));
              end;
            end;
            Log('Next Update check : '      + formatdatetime('dd-mm-yy hh:nn:ss' ,NextUpdateCheckTime                   ), ltDetail);
          end;
        except
          on e: exception do begin
            Log('Error adding Update Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        if Terminated then exit;

        {15}try
          LogCurtime('ExRemove check' );
          if now >= fNextGeneralCheckTime then begin
            try
              try
      //      if cfg.B['DoRemoveAdminUser'] then
                TSharedAppUserList.ExRemoveUser(ErpDbMaintObj.ERP_ADMIN_USER_DB_MAINT, MySQLServer);
              except
                on e: exception do begin
                  Log('Error during ExRemoveUser: ' + e.Message,ltError);
                end;
              end;
            finally
              fNextGeneralCheckTime := now + (OneMinute * 10);
              Log('Next General Check At : '        + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextGeneralCheckTime                 ), ltDetail);
            end;
          end;
        except
          on e: exception do begin
            Log('Error while removing ERP Admin user: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {16}try
          LogCurtime('Scheduled Reports check' );
          if fNextScheduledReportsCheckTime <= now then begin
            try
        //      CheckScheduledReports;
      //      if cfg.B['DoReportCheck'] then
              ThreadTaskList.AddTask(TReportSchedulerThreadTask.Create, 0, nil, MySQLServer);
            finally
              fNextScheduledReportsCheckTime := now + SCHEDULEDREPORTS_CHECK_INTERVAL;
              Log('Next Scheduled Reports At : '    + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextScheduledReportsCheckTime        ), ltDetail);
            end;
          end;
        except
          on e: exception do begin
            Log('Error adding Report Scheduler Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {17}try
          LogCurtime('Cleanup Module check' );
          if now >= fNextFileCleanupTime then begin
            try
              ThreadTaskList.AddTask(TFileCleanupModuleThreadTask.Create, 0, nil, MySQLServer);
            finally
              fNextFileCleanupTime := now + FILE_CLEANUP_CHECK_INTERVAL;
              Log('Next File Cleanup At : '         + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextFileCleanupTime                  ), ltDetail);
            end;
          end;
        except
          on e: exception do begin
            Log('Error running file cleanup task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {18}try
          LogCurtime('Document Database Structure check' );
          if now >= fNextDocDownloadCheckTime then begin
            if not fDocDBStrucCheckDone then begin
              fDocDBStrucCheckDone := true;
              fNextDocDownloadCheckTime := now + (OneMinute * 3);
              try
                with TERPDocsDB.Create do begin
                  Server := MySQLServer;
                  Free;
                end;
              except
                on e: exception do begin
                  Log('Error checking Document Database Structure: ' + e.Message,ltError);
                end;
              end;
            end
            else begin
              try
                ThreadTaskList.AddTask(TDocDownloadCheckThreadTask.Create, 0, nil, MySQLServer);
              finally
                fNextDocDownloadCheckTime := now + DOC_DOWNLOAD_CHECK_INTERVAL;
              end;
            end;
            Log('Next Download file check At : '  + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextDocDownloadCheckTime             ), ltDetail);
          end;
        except
          on e: exception do begin
            Log('Error running doc download cleanup task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;


        {19}try
          LogCurtime('Custom Process check' );
          if fNextCustomProcessCheckTime <= now then begin
            try
          //    CustomProcessList.CheckCustomProcs;
              try
      //      if cfg.B['DoCustomCheck'] then
                ThreadTaskList.StartTask(TCustomProcessCheckThreadTask, 0, nil, MySQLServer);
              finally
                fNextCustomProcessCheckTime := now + (OneMinute * 5);
                Log('Next Custom Process Check At : ' + formatdatetime('dd-mm-yy hh:nn:ss', fNextCustomProcessCheckTime           ), ltDetail);
              end;
            except
              on e: exception do begin
                Log('Error while checking for Custom Processes to run: ' + e.Message, ltError);
              end;
            end;
          end;
        except
          on e: exception do begin
            Log('Error starting Custom Process Check Task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {20}try
          LogCurtime('Offset Backup check' );
          if fNextOffsiteBackupCheckTime.AsDateTime <= now then begin
            params := nil;
            try
              params := JO;
              params.S['OffsiteBackupConfigText'] := self.OffsiteBackupConfigText;
              params.S['OffsiteRestoreConfigText'] := self.OffsiteRestoreConfigText;
      //        params.S['ConfigText'] := self.ConfigText;
              params.S['ConfigText'] := self.ClientConfig;
              ThreadTaskList.StartTask(TOffsiteBackupThreadTask, 0, params,MySQLServer,false,true);
            finally
              { add a bit of randomness so the ftp server is not getting hit all at same time }
              Randomize;
              fNextOffsiteBackupCheckTime.AsDateTime := now + OFFSITE_BACKUP_CHECK_INTERVAL + (Random(180) * OneSec);
              Log('Next Offsite backup check At : ' + formatdatetime('dd-mm-yy hh:nn:ss' ,fNextOffsiteBackupCheckTime.AsDateTime), ltDetail);
              params.Free;
            end;

          end;
        except
          on e: exception do begin
            Log('Error running Offsite Backup task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;

        {21}try
          LogCurtime('Clear in Use Tables check' );
          if now > fNextClearInUseTablesCheckTime then begin
            fNextClearInUseTablesCheckTime := MaxDateTime;
            Log('Next Clear inuse table At : ' + formatdatetime('dd-mm-yy hh:nn:ss', fNextClearInUseTablesCheckTime), ltDetail);
            ThreadTaskList.AddTask(TClearInUseTablesThreadTask.Create, 0, nil, MySQLServer);
          end;
        except
          on e: exception do begin
            Log('Error Clear In Use Tables task: ' + e.Message, ltError);
            Sleep(5000);
          end;
        end;
  {$ENDIF}

  finally
    (*fbstarted := true;*)
  end;

end;

function TModUserUtils.EncryptConfig: boolean;
begin
  result := false;
end;

function TModUserUtils.GetClientConfig: string;
begin
  result := fClientConfig;
end;

//function TModUserUtils.GetConfigText: string;
//begin
//  result := ConfigTextProp.AsString;
//end;

function TModUserUtils.GetDbListJsonText: string;
begin
  result := fDbListJsonTextProp.AsString;
end;

function TModUserUtils.GetERPServerName: string;
begin
  result:= ERP_HEAD_OFFICE_SERVER_NAME_DEFAULT; //ERPServerNameProp.AsString;
end;

function TModUserUtils.GetERPServerPort: integer;
begin
  result:= DEFAULT_TCP_PORT; //ERPServerPortProp.AsInteger;
end;

function TModUserUtils.GetLastMasterValidationTime: TDateTime;
var
  Json: TJsonObject;
begin
//  result := LastMasterValidationTimeProp.AsDateTime;
  Json := JO(self.ClientConfig);
  try
    result := Json.DT['LastMasterValidationTime'];
  finally
    Json.Free;
  end;
end;

function TModUserUtils.GetModuleDescription: string;
begin
  result := 'Module to provide various user utilities for ERP';
end;

//function TModUserUtils.GetModuleVersion: string;
//begin
//  result := '11.0.0.0';
//end;
     {$IFDEF NewUserUtils}
     {$ELSE}

function TModUserUtils.GetNextOffsiteBackupCheckTime: TDateTime;
begin
  result := fNextOffsiteBackupCheckTime.AsDateTime;
end;

function TModUserUtils.GetNextUpdateCheckTime: TDateTime;
begin
  result := fNextUpdateCheckTimeProp.AsDateTime;
end;

function TModUserUtils.GetNextValidateTime: TDateTime;
begin
  result := fNextValidateTimeProp.AsDateTime;
end;
procedure TModUserUtils.SetNextOffsiteBackupCheckTime(const Value: TDateTime);
begin
  fNextOffsiteBackupCheckTime.AsDateTime := Value;
end;

procedure TModUserUtils.SetNextUpdateCheckTime(const Value: TDateTime);
begin
  fNextUpdateCheckTimeProp.AsDateTime := Value;
end;

procedure TModUserUtils.SetNextValidateTime(const Value: TDateTime);
begin
  fNextValidateTimeProp.AsDateTime := Value;
end;
     {$ENDIF}

function TModUserUtils.GetSoftwareReleaseType: string;
var
  StoredConfig: TClientConfig;
  Json: TJsonObject;
begin
  if CommonConfig.StringExists('SoftwareReleaseType') and (CommonConfig.S['SoftwareReleaseType'] <> '') then begin
    result := CommonConfig.S['SoftwareReleaseType'];
    exit;
  end;
  StoredConfig:= TClientConfig.Create;
  try
    Json:= JO;
    try
//      Json.AsString := ConfigText;
      Json.AsString := ClientConfig;
      JsonToObj(Json.O['clientconfig'],StoredConfig);
      result:= StoredConfig.SoftwareReleaseType;
      if result = '' then
        result:= 'Production2018';
    finally
      Json.Free;
    end;
  finally
    StoredConfig.Free;
  end;
end;


{ NOTE: Overiding this to load config file from old UserUtils.dll }
//procedure TModUserUtils.LoadConfig(encrypt: boolean);
procedure TModUserUtils.LoadConfig;
  {$IFDEF NewUserUtils}
    var
      fConnection: TErpConnection;
      Qry :TERPQuery;

      Function BooltoStr (const Value:Boolean):String;
      begin
      if value then result := 'True' else Result := 'F';
      end;

    {$ENDIF}
begin
  inherited;
  {$IFDEF NewUserUtils}
  fConnection := TErpConnection.Create(nil);
  try
      InitialiseConnection(fConnection, MySQLServer, SERVICES_DATABASE);
      fConnection.Connect;
      Qry := TERPQuery.Create(nil);
      try
          Qry.connection := fConnection;
          Qry.SQL.text := 'SELECT * FROM Services.tblerpfunctionsconf';
          Qry.open;
          fbEnable_AuditTrailPurge_Check_OnStartup  := Qry.fieldbyname('Enable_AuditTrailPurge_Check_OnStartup').AsBoolean;
          fbEnable_GoLive_Check_OnStartup	          := Qry.fieldbyname('Enable_GoLive_Check_OnStartup').AsBoolean;
          fbEnable_Email_Check_OnStartup	          := Qry.fieldbyname('Enable_Email_Check_OnStartup').AsBoolean;
          fbEnable_DeleteTempTables_Check_OnStartup	:= Qry.fieldbyname('Enable_DeleteTempTables_Check_OnStartup').AsBoolean;
          fbEnable_GoogleCalendar_Check_OnStartup	  := Qry.fieldbyname('Enable_GoogleCalendar_Check_OnStartup').AsBoolean;
          fbEnable_GoogleAppointment_Check_OnStartup:= Qry.fieldbyname('Enable_GoogleAppointment_Check_OnStartup').AsBoolean;
          fbEnable_GoogleTask_Check_OnStartup	      := Qry.fieldbyname('Enable_GoogleTask_Check_OnStartup').AsBoolean;
          fbEnable_GoogleQueue_Check_OnStartup		  := Qry.fieldbyname('Enable_GoogleQueue_Check_OnStartup').AsBoolean;
          fbEnable_SMSSend_Check_OnStartup		      := Qry.fieldbyname('Enable_SMSSend_Check_OnStartup').AsBoolean;
          fbEnable_SMSReceive_Check_OnStartup		    := Qry.fieldbyname('Enable_SMSReceive_Check_OnStartup').AsBoolean;
          fbEnable_Ping_Check_OnStartup		          := Qry.fieldbyname('Enable_Ping_Check_OnStartup').AsBoolean;
          fbEnable_ValidateTime_Check_OnStartup		  := Qry.fieldbyname('Enable_ValidateTime_Check_OnStartup').AsBoolean;
          fbEnable_InactiveUser_Check_OnStartup		  := Qry.fieldbyname('Enable_InactiveUser_Check_OnStartup').AsBoolean;
          fbEnable_UpdateBatch_Check_OnStartup      := Qry.fieldbyname('Enable_UpdateBatch_Check_OnStartup').AsBoolean;
          fbEnable_General_Check_OnStartup		      := Qry.fieldbyname('Enable_General_Check_OnStartup').AsBoolean;
          fbEnable_ScheduledReports_Check_OnStartup	:= Qry.fieldbyname('Enable_ScheduledReports_Check_OnStartup').AsBoolean;
          fbEnable_FileCleanup_Check_OnStartup		  := Qry.fieldbyname('Enable_FileCleanup_Check_OnStartup').AsBoolean;
          fbEnable_DocDownload_Check_OnStartup		  := Qry.fieldbyname('Enable_DocDownload_Check_OnStartup').AsBoolean;
          fbEnable_CustomProcess_Check_OnStartup		:= Qry.fieldbyname('Enable_CustomProcess_Check_OnStartup').AsBoolean;
          fbEnable_OffsiteBackup_Check_OnStartup		:= Qry.fieldbyname('Enable_OffsiteBackup_Check_OnStartup').AsBoolean;
          fbEnable_ClearInUseTables_Check_OnStartup	:= Qry.fieldbyname('Enable_ClearInUseTables_Check_OnStartup').AsBoolean;
          fbEnable_NonERPClone_Check_OnStartup		  := True;

          fbEnable_AuditTrailPurge_Check    := Qry.fieldbyname('Enable_AuditTrailPurge_Check').AsBoolean;
          fbEnable_GoLive_Check		          := Qry.fieldbyname('Enable_GoLive_Check').AsBoolean;
          fbEnable_Email_Check		          := Qry.fieldbyname('Enable_Email_Check').AsBoolean;
          fbEnable_DeleteTempTables_Check		:= Qry.fieldbyname('Enable_DeleteTempTables_Check').AsBoolean;
          fbEnable_GoogleCalendar_Check		  := Qry.fieldbyname('Enable_GoogleCalendar_Check').AsBoolean;
          fbEnable_GoogleAppointment_Check	:= Qry.fieldbyname('Enable_GoogleAppointment_Check').AsBoolean;
          fbEnable_GoogleTask_Check		      := Qry.fieldbyname('Enable_GoogleTask_Check').AsBoolean;
          fbEnable_GoogleQueue_Check		    := Qry.fieldbyname('Enable_GoogleQueue_Check').AsBoolean;
          fbEnable_SMSSend_Check		        := Qry.fieldbyname('Enable_SMSSend_Check').AsBoolean;
          fbEnable_SMSReceive_Check		      := Qry.fieldbyname('Enable_SMSReceive_Check').AsBoolean;
          fbEnable_Ping_Check		          	:= Qry.fieldbyname('Enable_Ping_Check').AsBoolean;
          fbEnable_ValidateTime_Check		    := Qry.fieldbyname('Enable_ValidateTime_Check').AsBoolean;
          fbEnable_InactiveUser_Check		    := Qry.fieldbyname('Enable_InactiveUser_Check').AsBoolean;
          fbEnable_UpdateBatch_Check	      := Qry.fieldbyname('Enable_UpdateBatch_Check').AsBoolean;
          fbEnable_General_Check		        := Qry.fieldbyname('Enable_General_Check').AsBoolean;
          fbEnable_ScheduledReports_Check		:= Qry.fieldbyname('Enable_ScheduledReports_Check').AsBoolean;
          fbEnable_FileCleanup_Check		    := Qry.fieldbyname('Enable_FileCleanup_Check').AsBoolean;
          fbEnable_DocDownload_Check		    := Qry.fieldbyname('Enable_DocDownload_Check').AsBoolean;
          fbEnable_CustomProcess_Check		  := Qry.fieldbyname('Enable_CustomProcess_Check').AsBoolean;
          fbEnable_OffsiteBackup_Check		  := Qry.fieldbyname('Enable_OffsiteBackup_Check').AsBoolean;
          fbEnable_ClearInUseTables_Check		:= Qry.fieldbyname('Enable_ClearInUseTables_Check').AsBoolean;
          fbEnable_NonERPClone_Check		    := True;

          fdAuditTrailPurge_Check_Interval  := Qry.fieldbyname('AuditTrailPurge_Check_Interval').asInteger;
          fdGoLive_Check_Interval		        := Qry.fieldbyname('GoLive_Check_Interval').asInteger;
          fdEmail_Check_Interval		        := Qry.fieldbyname('Email_Check_Interval').asInteger;
          fdDeleteTempTables_Check_Interval	:= Qry.fieldbyname('DeleteTempTables_Check_Interval').asInteger;
          fdGoogleCalendar_Check_Interval		:= Qry.fieldbyname('GoogleCalendar_Check_Interval').asInteger;
          fdGoogleAppointment_Check_Interval:= Qry.fieldbyname('GoogleAppointment_Check_Interval').asInteger;
          fdGoogleTask_Check_Interval		    := Qry.fieldbyname('GoogleTask_Check_Interval').asInteger;
          fdGoogleQueue_Check_Interval		  := Qry.fieldbyname('GoogleQueue_Check_Interval').asInteger;
          fdSMSSend_Check_Interval		      := Qry.fieldbyname('SMSSend_Check_Interval').asInteger;
          fdSMSReceive_Check_Interval		    := Qry.fieldbyname('SMSReceive_Check_Interval').asInteger;
          fdPing_Check_Interval		          := Qry.fieldbyname('Ping_Check_Interval').asInteger;
          fdValidateTime_Check_Interval		  := Qry.fieldbyname('ValidateTime_Check_Interval').asInteger;
          fdInactiveUser_Check_Interval		  := Qry.fieldbyname('InactiveUser_Check_Interval').asInteger;
          fdUpdateBatch_Check_Interval      := Qry.fieldbyname('UpdateBatch_Check_Interval').asInteger;
          fdGeneral_Check_Interval		      := Qry.fieldbyname('General_Check_Interval').asInteger;
          fdScheduledReports_Check_Interval	:= Qry.fieldbyname('ScheduledReports_Check_Interval').asInteger;
          fdFileCleanup_Check_Interval		  := Qry.fieldbyname('FileCleanup_Check_Interval').asInteger;
          fdDocDownload_Check_Interval		  := Qry.fieldbyname('DocDownload_Check_Interval').asInteger;
          fdCustomProcess_Check_Interval		:= Qry.fieldbyname('CustomProcess_Check_Interval').asInteger;
          fdOffsiteBackup_Check_Interval		:= Qry.fieldbyname('OffsiteBackup_Check_Interval').asInteger;
          fdClearInUseTables_Check_Interval	:= Qry.fieldbyname('ClearInUseTables_Check_Interval').asInteger;
          fdNonERPClone_Check_Interval		  := trunc(OneHour*24);


          fdAuditTrailPurge_Check_StartupDelay  := Qry.fieldbyname('AuditTrailPurge_Check_StartupDelay').asInteger;
          fdGoLive_Check_StartupDelay		        := Qry.fieldbyname('GoLive_Check_StartupDelay').asInteger;
          fdEmail_Check_StartupDelay		        := Qry.fieldbyname('Email_Check_StartupDelay').asInteger;
          fdDeleteTempTables_Check_StartupDelay	:= Qry.fieldbyname('DeleteTempTables_Check_StartupDelay').asInteger;
          fdGoogleCalendar_Check_StartupDelay		:= Qry.fieldbyname('GoogleCalendar_Check_StartupDelay').asInteger;
          fdGoogleAppointment_Check_StartupDelay:= Qry.fieldbyname('GoogleAppointment_Check_StartupDelay').asInteger;
          fdGoogleTask_Check_StartupDelay		    := Qry.fieldbyname('GoogleTask_Check_StartupDelay').asInteger;
          fdGoogleQueue_Check_StartupDelay		  := Qry.fieldbyname('GoogleQueue_Check_StartupDelay').asInteger;
          fdSMSSend_Check_StartupDelay		      := Qry.fieldbyname('SMSSend_Check_StartupDelay').asInteger;
          fdSMSReceive_Check_StartupDelay		    := Qry.fieldbyname('SMSReceive_Check_StartupDelay').asInteger;
          fdPing_Check_StartupDelay		          := Qry.fieldbyname('Ping_Check_StartupDelay').asInteger;
          fdValidateTime_Check_StartupDelay		  := Qry.fieldbyname('ValidateTime_Check_StartupDelay').asInteger;
          fdInactiveUser_Check_StartupDelay		  := Qry.fieldbyname('InactiveUser_Check_StartupDelay').asInteger;
          fdUpdateBatch_Check_StartupDelay      := Qry.fieldbyname('UpdateBatch_Check_StartupDelay').asInteger;
          fdGeneral_Check_StartupDelay		      := Qry.fieldbyname('General_Check_StartupDelay').asInteger;
          fdScheduledReports_Check_StartupDelay	:= Qry.fieldbyname('ScheduledReports_Check_StartupDelay').asInteger;
          fdFileCleanup_Check_StartupDelay		  := Qry.fieldbyname('FileCleanup_Check_StartupDelay').asInteger;
          fdDocDownload_Check_StartupDelay		  := Qry.fieldbyname('DocDownload_Check_StartupDelay').asInteger;
          fdCustomProcess_Check_StartupDelay		:= Qry.fieldbyname('CustomProcess_Check_StartupDelay').asInteger;
          fdOffsiteBackup_Check_StartupDelay		:= Qry.fieldbyname('OffsiteBackup_Check_StartupDelay').asInteger;
          fdClearInUseTables_Check_StartupDelay	:= Qry.fieldbyname('ClearInUseTables_Check_StartupDelay').asInteger;
          fdNonERPClone_Check_StartupDelay	    := trunc(oneMinute);


          if fdAuditTrailPurge_Check_StartupDelay   =0 then fdAuditTrailPurge_Check_StartupDelay  := fdAuditTrailPurge_Check_Interval;
          if fdGoLive_Check_StartupDelay		        =0 then fdGoLive_Check_StartupDelay           := fdGoLive_Check_Interval;
          if fdEmail_Check_StartupDelay		          =0 then fdEmail_Check_StartupDelay            := fdEmail_Check_Interval;
          if fdDeleteTempTables_Check_StartupDelay	=0 then fdDeleteTempTables_Check_StartupDelay := fdDeleteTempTables_Check_Interval;
          if fdGoogleCalendar_Check_StartupDelay		=0 then fdGoogleCalendar_Check_StartupDelay   := fdGoogleCalendar_Check_Interval;
          if fdGoogleAppointment_Check_StartupDelay =0 then fdGoogleAppointment_Check_StartupDelay:= fdGoogleAppointment_Check_Interval;
          if fdGoogleTask_Check_StartupDelay		    =0 then fdGoogleTask_Check_StartupDelay       := fdGoogleTask_Check_Interval;
          if fdGoogleQueue_Check_StartupDelay		    =0 then fdGoogleQueue_Check_StartupDelay      := fdGoogleQueue_Check_Interval;
          if fdSMSSend_Check_StartupDelay		        =0 then fdSMSSend_Check_StartupDelay          := fdSMSSend_Check_Interval;
          if fdSMSReceive_Check_StartupDelay		    =0 then fdSMSReceive_Check_StartupDelay       := fdSMSReceive_Check_Interval;
          if fdPing_Check_StartupDelay		          =0 then fdPing_Check_StartupDelay             := fdPing_Check_Interval;
          if fdValidateTime_Check_StartupDelay		  =0 then fdValidateTime_Check_StartupDelay     := fdValidateTime_Check_Interval;
          if fdInactiveUser_Check_StartupDelay		  =0 then fdInactiveUser_Check_StartupDelay     := fdInactiveUser_Check_Interval;
          if fdUpdateBatch_Check_StartupDelay       =0 then fdUpdateBatch_Check_StartupDelay      := fdUpdateBatch_Check_Interval;
          if fdGeneral_Check_StartupDelay		        =0 then fdGeneral_Check_StartupDelay          := fdGeneral_Check_Interval;
          if fdScheduledReports_Check_StartupDelay	=0 then fdScheduledReports_Check_StartupDelay := fdScheduledReports_Check_Interval;
          if fdFileCleanup_Check_StartupDelay		    =0 then fdFileCleanup_Check_StartupDelay      := fdFileCleanup_Check_Interval;
          if fdDocDownload_Check_StartupDelay		    =0 then fdDocDownload_Check_StartupDelay      := fdDocDownload_Check_Interval;
          if fdCustomProcess_Check_StartupDelay		  =0 then fdCustomProcess_Check_StartupDelay    := fdCustomProcess_Check_Interval;
          if fdOffsiteBackup_Check_StartupDelay		  =0 then fdOffsiteBackup_Check_StartupDelay    := fdOffsiteBackup_Check_Interval;
          if fdClearInUseTables_Check_StartupDelay	=0 then fdClearInUseTables_Check_StartupDelay := fdClearInUseTables_Check_Interval;
          if fdNonERPClone_Check_StartupDelay	      =0 then fdNonERPClone_Check_StartupDelay      := fdNonERPClone_Check_Interval;

          if fbEnable_AuditTrailPurge_Check_OnStartup   then fdAuditTrailPurge_Check_At   := Now +  fdAuditTrailPurge_Check_StartupDelay  * (OneMinute)	else fdAuditTrailPurge_Check_At       := Now + 	fdAuditTrailPurge_Check_Interval  *(OneMinute);
          if fbEnable_GoLive_Check_OnStartup            then fdGoLive_Check_At            := Now +  fdGoLive_Check_StartupDelay           * (OneMinute)	else fdGoLive_Check_At	              := Now + 	fdGoLive_Check_Interval	          *(OneMinute);
          if fbEnable_Email_Check_OnStartup             then fdEmail_Check_At             := Now +  fdEmail_Check_StartupDelay            * (OneMinute)	else fdEmail_Check_At	                := Now + 	fdEmail_Check_Interval	          *(OneMinute);
          if fbEnable_DeleteTempTables_Check_OnStartup  then fdDeleteTempTables_Check_At  := Now +  fdDeleteTempTables_Check_StartupDelay * (OneMinute)	else fdDeleteTempTables_Check_At	    := Now + 	fdDeleteTempTables_Check_Interval	*(OneMinute);
          if fbEnable_GoogleCalendar_Check_OnStartup    then fdGoogleCalendar_Check_At    := Now +  fdGoogleCalendar_Check_StartupDelay   * (OneMinute)	else fdGoogleCalendar_Check_At	      := Now + 	fdGoogleCalendar_Check_Interval	  *(OneMinute);
          if fbEnable_GoogleAppointment_Check_OnStartup then fdGoogleAppointment_Check_At := Now +  fdGoogleAppointment_Check_StartupDelay* (OneMinute)	else fdGoogleAppointment_Check_At	    := Now + 	fdGoogleAppointment_Check_Interval*(OneMinute);
          if fbEnable_GoogleTask_Check_OnStartup        then fdGoogleTask_Check_At        := Now +  fdGoogleTask_Check_StartupDelay       * (OneMinute)	else fdGoogleTask_Check_At	          := Now + 	fdGoogleTask_Check_Interval	      *(OneMinute);
          if fbEnable_GoogleQueue_Check_OnStartup       then fdGoogleQueue_Check_At       := Now +  fdGoogleQueue_Check_StartupDelay      * (OneMinute)	else fdGoogleQueue_Check_At	          := Now + 	fdGoogleQueue_Check_Interval	    *(OneMinute);
          if fbEnable_SMSSend_Check_OnStartup           then fdSMSSend_Check_At           := Now +  fdSMSSend_Check_StartupDelay          * (OneMinute)	else fdSMSSend_Check_At	              := Now + 	fdSMSSend_Check_Interval	        *(OneMinute);
          if fbEnable_SMSReceive_Check_OnStartup        then fdSMSReceive_Check_At        := Now +  fdSMSReceive_Check_StartupDelay       * (OneMinute)	else fdSMSReceive_Check_At	          := Now + 	fdSMSReceive_Check_Interval	      *(OneMinute);
          if fbEnable_Ping_Check_OnStartup              then fdPing_Check_At              := Now +  fdPing_Check_StartupDelay             * (OneMinute)	else fdPing_Check_At	                := Now + 	fdPing_Check_Interval	            *(OneMinute);
          if fbEnable_ValidateTime_Check_OnStartup      then fdValidateTime_Check_At      := Now +  fdValidateTime_Check_StartupDelay     * (OneMinute)	else fdValidateTime_Check_At	        := Now + 	fdValidateTime_Check_Interval	    *(OneMinute);
          if fbEnable_InactiveUser_Check_OnStartup      then fdInactiveUser_Check_At      := Now +  fdInactiveUser_Check_StartupDelay     * (OneMinute)	else fdInactiveUser_Check_At	        := Now + 	fdInactiveUser_Check_Interval	    *(OneMinute);
          if fbEnable_UpdateBatch_Check_OnStartup       then fdUpdateBatch_Check_At       := Now +  fdUpdateBatch_Check_StartupDelay      * (OneMinute)	else fdUpdateBatch_Check_At	          := Now + 	fdUpdateBatch_Check_Interval	    *(OneMinute);
          if fbEnable_General_Check_OnStartup           then fdGeneral_Check_At           := Now +  fdGeneral_Check_StartupDelay          * (OneMinute)	else fdGeneral_Check_At	              := Now + 	fdGeneral_Check_Interval	        *(OneMinute);
          if fbEnable_ScheduledReports_Check_OnStartup  then fdScheduledReports_Check_At  := Now +  fdScheduledReports_Check_StartupDelay * (OneMinute)	else fdScheduledReports_Check_At	    := Now + 	fdScheduledReports_Check_Interval	*(OneMinute);
          if fbEnable_FileCleanup_Check_OnStartup       then fdFileCleanup_Check_At       := Now +  fdFileCleanup_Check_StartupDelay      * (OneMinute)	else fdFileCleanup_Check_At	          := Now + 	fdFileCleanup_Check_Interval	    *(OneMinute);
          if fbEnable_DocDownload_Check_OnStartup       then fdDocDownload_Check_At       := Now +  fdDocDownload_Check_StartupDelay      * (OneMinute)	else fdDocDownload_Check_At	          := Now + 	fdDocDownload_Check_Interval	    *(OneMinute);
          if fbEnable_CustomProcess_Check_OnStartup     then fdCustomProcess_Check_At     := Now +  fdCustomProcess_Check_StartupDelay    * (OneMinute)	else fdCustomProcess_Check_At	        := Now + 	fdCustomProcess_Check_Interval	  *(OneMinute);
          if fbEnable_OffsiteBackup_Check_OnStartup     then fdOffsiteBackup_Check_At     := Now +  fdOffsiteBackup_Check_StartupDelay    * (OneMinute)	else fdOffsiteBackup_Check_At	        := Now + 	fdOffsiteBackup_Check_Interval	  *(OneMinute);
          if fbEnable_ClearInUseTables_Check_OnStartup  then fdClearInUseTables_Check_At  := Now +  fdClearInUseTables_Check_StartupDelay	* (OneMinute)	else fdClearInUseTables_Check_At	    := Now + 	fdClearInUseTables_Check_Interval	*(OneMinute);
          if fbEnable_NonERPClone_Check_OnStartup       then fdNonERPClone_Check_At       := Now +  fdNonERPClone_Check_StartupDelay	    * (OneMinute)	else fdNonERPClone_Check_At	          := Now + 	fdNonERPClone_Check_Interval	    *(OneMinute);

          Log('Startup:' + formatDateTime('HH:nn:ss' , Now), ltInfo);
          Log('AuditTrailPurge  -> Enabled On Startup :'+ BooltoStr(fbEnable_AuditTrailPurge_Check_OnStartup)   +',  Enable Time Check :' +  BooltoStr(fbEnable_AuditTrailPurge_Check)   +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdAuditTrailPurge_Check_at), ltInfo);
          Log('GoLive           -> Enabled On Startup :'+ BooltoStr(fbEnable_GoLive_Check_OnStartup)            +',  Enable Time Check :' +  BooltoStr(fbEnable_GoLive_Check)            +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdGoLive_Check_at), ltInfo);
          Log('Email            -> Enabled On Startup :'+ BooltoStr(fbEnable_Email_Check_OnStartup)             +',  Enable Time Check :' +  BooltoStr(fbEnable_Email_Check)             +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdEmail_Check_at), ltInfo);
          Log('DeleteTempTables -> Enabled On Startup :'+ BooltoStr(fbEnable_DeleteTempTables_Check_OnStartup)  +',  Enable Time Check :' +  BooltoStr(fbEnable_DeleteTempTables_Check)  +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdDeleteTempTables_Check_at), ltInfo);
          Log('GoogleCalendar   -> Enabled On Startup :'+ BooltoStr(fbEnable_GoogleCalendar_Check_OnStartup)    +',  Enable Time Check :' +  BooltoStr(fbEnable_GoogleCalendar_Check)    +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdGoogleCalendar_Check_at), ltInfo);
          Log('GoogleAppointment-> Enabled On Startup :'+ BooltoStr(fbEnable_GoogleAppointment_Check_OnStartup) +',  Enable Time Check :' +  BooltoStr(fbEnable_GoogleAppointment_Check) +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdGoogleAppointment_Check_at), ltInfo);
          Log('GoogleTask       -> Enabled On Startup :'+ BooltoStr(fbEnable_GoogleTask_Check_OnStartup)        +',  Enable Time Check :' +  BooltoStr(fbEnable_GoogleTask_Check)        +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdGoogleTask_Check_at), ltInfo);
          Log('GoogleQueue      -> Enabled On Startup :'+ BooltoStr(fbEnable_GoogleQueue_Check_OnStartup)       +',  Enable Time Check :' +  BooltoStr(fbEnable_GoogleQueue_Check)       +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdGoogleQueue_Check_at), ltInfo);
          Log('SMSSend          -> Enabled On Startup :'+ BooltoStr(fbEnable_SMSSend_Check_OnStartup)           +',  Enable Time Check :' +  BooltoStr(fbEnable_SMSSend_Check)           +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdSMSSend_Check_at), ltInfo);
          Log('SMSReceive       -> Enabled On Startup :'+ BooltoStr(fbEnable_SMSReceive_Check_OnStartup)        +',  Enable Time Check :' +  BooltoStr(fbEnable_SMSReceive_Check)        +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdSMSReceive_Check_at), ltInfo);
          Log('Ping             -> Enabled On Startup :'+ BooltoStr(fbEnable_Ping_Check_OnStartup)              +',  Enable Time Check :' +  BooltoStr(fbEnable_Ping_Check)              +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdPing_Check_at), ltInfo);
          Log('ValidateTime     -> Enabled On Startup :'+ BooltoStr(fbEnable_ValidateTime_Check_OnStartup)      +',  Enable Time Check :' +  BooltoStr(fbEnable_ValidateTime_Check)      +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdValidateTime_Check_at), ltInfo);
          Log('InactiveUser     -> Enabled On Startup :'+ BooltoStr(fbEnable_InactiveUser_Check_OnStartup)      +',  Enable Time Check :' +  BooltoStr(fbEnable_InactiveUser_Check)      +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdInactiveUser_Check_at), ltInfo);
          Log('UpdateBatch      -> Enabled On Startup :'+ BooltoStr(fbEnable_UpdateBatch_Check_OnStartup)       +',  Enable Time Check :' +  BooltoStr(fbEnable_UpdateBatch_Check)       +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdUpdateBatch_Check_at), ltInfo);
          Log('General          -> Enabled On Startup :'+ BooltoStr(fbEnable_General_Check_OnStartup)           +',  Enable Time Check :' +  BooltoStr(fbEnable_General_Check)           +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdGeneral_Check_at), ltInfo);
          Log('ScheduledReports -> Enabled On Startup :'+ BooltoStr(fbEnable_ScheduledReports_Check_OnStartup)  +',  Enable Time Check :' +  BooltoStr(fbEnable_ScheduledReports_Check)  +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdScheduledReports_Check_at), ltInfo);
          Log('FileCleanup      -> Enabled On Startup :'+ BooltoStr(fbEnable_FileCleanup_Check_OnStartup)       +',  Enable Time Check :' +  BooltoStr(fbEnable_FileCleanup_Check)       +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdFileCleanup_Check_at), ltInfo);
          Log('DocDownload      -> Enabled On Startup :'+ BooltoStr(fbEnable_DocDownload_Check_OnStartup)       +',  Enable Time Check :' +  BooltoStr(fbEnable_DocDownload_Check)       +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdDocDownload_Check_at), ltInfo);
          Log('CustomProcess    -> Enabled On Startup :'+ BooltoStr(fbEnable_CustomProcess_Check_OnStartup)     +',  Enable Time Check :' +  BooltoStr(fbEnable_CustomProcess_Check)     +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdCustomProcess_Check_at), ltInfo);
          Log('OffsiteBackup    -> Enabled On Startup :'+ BooltoStr(fbEnable_OffsiteBackup_Check_OnStartup)     +',  Enable Time Check :' +  BooltoStr(fbEnable_OffsiteBackup_Check)     +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdOffsiteBackup_Check_at), ltInfo);
          Log('ClearInUseTables -> Enabled On Startup :'+ BooltoStr(fbEnable_ClearInUseTables_Check_OnStartup)  +',  Enable Time Check :' +  BooltoStr(fbEnable_ClearInUseTables_Check)  +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdClearInUseTables_Check_at), ltInfo);
          Log('NonERPClone      -> Enabled On Startup :'+ BooltoStr(fbEnable_NonERPClone_Check_OnStartup)       +',  Enable Time Check :' +  BooltoStr(fbEnable_NonERPClone_Check)       +',  Next check At : ' + formatDateTime('hh:nn:ss am/pm' ,fdNonERPClone_Check_at), ltInfo);

      finally
        if qry.active then qry.close;
        Freeandnil(qry);
      end;
  finally
    FreeandNil(fConnection)
  end;
  {$ENDIF}

//  try
//    try
////      if FileExists(ExtractFilePath(ModuleFileName) + 'ERPModUserUtils_Config.cfg') then
////        configFileName:= ExtractFilePath(ModuleFileName) + 'ERPModUserUtils_Config.cfg'
////      else
////        configFileName:= ExtractFilePath(ModuleFileName) + 'UserUtils_Config.cfg';
//
//      configFileName:= ExtractFilePath(ModuleFileName) + 'ERPModUserUtils_Config.cfg';
//
//      if not FileExists(configFileName) then begin
//        Log('Config file not found: "' + configFileName + '"',ltError);
//      end;
//
//
//      { try to load 3 times }
//      try
//        FileToObj(configFileName, self, EncryptConfig);
//      except
//        Log('Error reading config file, trying for a second time ..',ltError);
//        Sleep(5000);
//        try
//          FileToObj(configFileName, self, EncryptConfig);
//        except
//          Log('Error reading config file, trying for a third time ..',ltError);
//          Sleep(5000);
//          FileToObj(configFileName, self, EncryptConfig);
//        end;
//      end;
//
////      {special stuff}
////      configFileName := ExtractFilePath(ModuleFileName) + 'CustomERPModUserUtils_Config.cfg';
////      if FileExists(configFileName) then begin
////        FileToObj(configFileName, self, false);
////      end;
//
//      if ServerID = '' then begin
//        Log('Config file has not been initialized, will be st to defaults.',ltError);
//      end;
//
//      AfterLoadConfig;
//    except
//      on e: exception do begin
//        Log('Error reading config file: ' + e.Message,ltError);
//        raise;
//      end;
//    end;
//  finally
//
//  end;
end;

//procedure TModUserUtils.SaveConfig(encrypt: boolean);
procedure TModUserUtils.SaveConfig;
begin
  if ServerId = '' then begin
    Log('Trying to save the modules config when Server ID is blank .. skipping', ltError);
    exit;
  end;

  inherited;

end;

procedure TModUserUtils.SetClientConfig(const Value: string);
var
  ConfigDb: TConfigDb;
begin
  fClientConfig := Value;
  try
    ConfigDb := TConfigDb.Create('ClientConfig', Self.MySQLServer);
    try
      ConfigDb.Value := EncryptString(Value);
    finally
      ConfigDb.Free;
    end;
  except
    on e: exception do begin
      Log('Error saving ClientConfig (Licence) data to database: ' + e.Message, ltError);
    end;
  end;
end;

//procedure TModUserUtils.SetConfigText(const Value: string);
//begin
//  ConfigTextProp.AsString:= Value;
//end;

procedure TModUserUtils.SetDbListJsonText(const Value: string);
begin
  fDbListJsonTextProp.AsString := Value;
end;

//procedure TModUserUtils.SetERPServerName(const Value: string);
//begin
//  ERPServerNameProp.AsString := Value;
//end;
//
//procedure TModUserUtils.SetERPServerPort(const Value: integer);
//begin
//  ERPServerPortProp.AsInteger := Value;
//end;

procedure TModUserUtils.SetLastMasterValidationTime(const Value: TDateTime);
var
  JSON: TJsonObject;
begin
//  LastMasterValidationTimeProp.AsDateTime := Value;
  Json := JO(self.ClientConfig);
  try
    Json.DT['LastMasterValidationTime'] := Value;
    self.ClientConfig := Json.AsString;
  finally
    Json.Free;
  end;
end;

//function TModUserUtils.StartERPServerSession(var msg: string;
//  aERPClient: TJsonRpcTcpClient): boolean;
////var
////  o, resp: TJsonObject;
//begin
//  msg:= '';
//  result:= aERPClient.Connected;
//  if result then
//    exit;
//  aERPClient.ServerName:= ERPServerName;
//  aERPClient.Port:= ERPServerPort;
//  try
//    aERPClient.Connected:= true;
//  except
//    on ex: exception do begin
//      try
//        aERPClient.ServerName:= 'ERPServer1';
//        aERPClient.Connected:= true;
//      except
//        try
//          aERPClient.ServerName:= 'Server1';
//          aERPClient.Connected:= true;
//        except
//          on e: exception do begin
//            msg:= e.Message;
//          end;
//        end;
//      end;
//    end;
//  end;
////  if aERPClient.Connected then begin
////    o:= JO;
////    o.S['sessiontype']:= 'client';
////    //o.S['clientname']:= '';
////    resp:= aERPClient.SendRequest('ClientServer.StartSession',o);
////    if Assigned(resp) then begin
////      try
////        if resp.StringExists('result') and (resp.S['result'] = 'ok') then begin
////          //
////        end
////        else begin
////          { failed to establisg a session }
////          aERPClient.Connected:= false;
////          msg:= 'Could not establish a session with the ERP server.';
////        end;
////      finally
////        resp.Free;
////      end;
////    end
////    else begin
////      aERPClient.Connected:= false;
////      msg:= 'No response received from ERP server.';
////    end;
////  end;
//  result:= aERPClient.Connected;
//end;

(*function TModUserUtils.IsNewCheck: Boolean;
begin
 {$IFDEF NewUserUtils}
    Result := True;
    Log('NewUserUtils', ltInfo);
 {$ELSE}
    Result := False;
    Log('NOT  NewUserUtils', ltInfo);
 {$ENDIF}
end;*)
procedure TModUserUtils.LogCurtime(const Value: String);
begin
  Log('LogCurtime -> ' + Value + ' : ' + FormatdateTime('hh:nn:ss am/pm', now) ,ltInfo);
end;

end.
