// set this define is you are using Indy 10
{$define INDY100}
// set this define is you are using Indy 9
{.$define INDY90}

unit ModPMI;

interface

uses
  ServerModuleObj, JsonObject, LogThreadBase, LogMessageTypes, ERPDbComponents,
  classes;

type

  TModPMI = class(TServerModule)
  private
    fNextCheckTime: TDateTime;
    fNextCheckCrashTime: TDateTime;
    FFtpSite: string;
    FFtpCertificate: string;
    FFtpPassword: string;
    FFtpUserName: string;
    FERPDatabase: string;
    FERPPassword: string;
    FERPUser: string;
//    FIncludeSupplierList: string;
//    FExcludeSupplierList: string;
//    FReportEmailList: string;
//    FAutoProcessStartTime: TDateTime;
//    FAutoProcessEndTime: TDateTime;
    fProcessNowClicked: boolean;
//    FDepartmentList: string;
    json: TJsonObject;
    fSupplierName: string;
    fProcessedStatus: string;
    fStatusToProcess: string;
    fGLN: string;
    fPOOutputDir: string;
//    FProcessDateFrom: TDateTime;
    procedure SetFtpCertificate(const Value: string);
    procedure SetFtpPassword(const Value: string);
    procedure SetFtpSite(const Value: string);
    procedure SetFtpUserName(const Value: string);
    procedure SetERPDatabase(const Value: string);
//    function FTPParamsOk: boolean;
    procedure SetERPPassword(const Value: string);
    procedure SetERPUser(const Value: string);
//    procedure SetIncludeSupplierList(const Value: string);
//    procedure SetExcludeSupplierList(const Value: string);
    function GuiStr: string;
    function OrderStatusList: string;
//    procedure SetReportEmailList(const Value: string);
//    procedure SetAutoProcessEndTime(const Value: TDateTime);
//    procedure SetAutoProcessStartTime(const Value: TDateTime);
//    procedure SetDepartmentList(const Value: string);
//    procedure SetProcessDateFrom(const Value: TDateTime);
  protected
    function GetModuleDescription: string; override;
    procedure AfterLoadConfig; override;

    procedure DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject); override;
    procedure DoOnMessage(aClientId: integer; aData: TJsonObject; ctx: TJsonObject); override;
    procedure DoOnCommandMessage(aData: string; ctx: TJsonObject); override;

    procedure DoOnRequest(aClientId: integer; aRequest: string; ctx: TJsonObject; var aResponse: string); override;
    procedure DoOnRequest(aClientId: integer; aRequest: TJsonObject; ctx: TJsonObject; aResponse: TJsonObject = nil); override;
    procedure DoOnCommandRequest(aRequest: string; var aResponse: string); override;

    function CreateNewLogger: TLoggerBase; override;
    procedure DoWork; override;
    procedure SetActive(const Value: boolean); override;
  public
    constructor Create;
    destructor Destroy; override;
//    procedure LoadConfig(encrypt: boolean = false); override;
//    procedure SaveConfig(encrypt: boolean = false); override;
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  published
    property FtpSite: string read FFtpSite write SetFtpSite;
    property FtpUserName: string read FFtpUserName write SetFtpUserName;
    property FtpPassword: string read FFtpPassword write SetFtpPassword;
    property FtpCertificate: string read FFtpCertificate write SetFtpCertificate;
    property ERPDatabase: string read FERPDatabase write SetERPDatabase;
    property ERPUser: string read FERPUser write SetERPUser;
    property ERPPassword: string read FERPPassword write SetERPPassword;
    property SupplierName: string read fSupplierName write fSupplierName;
    property StatusToProcess: string read fStatusToProcess write fStatusToProcess;
    property ProcessedStatus: string read fProcessedStatus write fProcessedStatus;
    property GLN: string read fGLN write fGLN; { Global Location Number }
    property POOutputDir: string read fPOOutputDir write fPOOutputDir;
    { List of Supplier names to ignore in the import }
//    property ExcludeSupplierList: string read FExcludeSupplierList write SetExcludeSupplierList;
    { List of Supplier names to include in the import }
//    property IncludeSupplierList: string read FIncludeSupplierList write SetIncludeSupplierList;
//    property ReportEmailList: string read FReportEmailList write SetReportEmailList;
//    property AutoProcessStartTime: TDateTime read FAutoProcessStartTime write SetAutoProcessStartTime;
//    property AutoProcessEndTime: TDateTime read FAutoProcessEndTime write SetAutoProcessEndTime;
//    property DepartmentList: string read FDepartmentList write SetDepartmentList;
//    property ProcessDateFrom: TDateTime read FProcessDateFrom write SetProcessDateFrom;
  end;


implementation

uses
  SysUtils, LogThreadDbLib, JsonToObject, JsonRPCUtils, types, StrUtils,
  JsonRPCConst, ModuleFileNameUtils, MySQLUtils, DbSharedObjectsObj,
  XMLIntf, XMLDoc, XMLHelperUtils, Math,
  AppEnvironment, ActiveX, BusObjClient, PMIThreadTask, MyAccess, DbUtils,
  BusObjSimpleTypes, tcConst, AppDatabase;

const
  OneMin = 1/24/60;
  Check_Interval = OneMin * 60;
  Crash_Check_Interval = OneMin * 5;

{ TModWebPrestaShop }

procedure TModPMI.AfterLoadConfig;
var
  configChanged: boolean;
begin
  inherited;
  configChanged := false;
//  if FtpSite = '' then begin
//    FtpSite := 'ftp.perecorp.com.au';
//    configChanged := true;
//  end;
//  if FtpUserName = '' then begin
//    FtpUserName := 'TimPOS';
//    configChanged := true;
//  end;
//  if FtpPassword = '' then begin
//    FtpPassword := 'xTw5xQw7';
//    configChanged := true;
//  end;
//  if FtpCertificate = '' then begin
//    FtpCertificate := 'perecorp.ppk';
//    configChanged := true;
//  end;


  if configChanged then begin
//    if ExcludeSupplierList = '' then
//      ExcludeSupplierList :=
//        'SMOKEMART,' +
//        '"C STORE",' +
//        '"GIFTBOX",' +
//        '"REDLINE",' +
//        '"TABACO LEAF PTY LTD",' +
//        '"TUNBAC NATIONAL PTY LTD",' +
//        '"LEBARA",' +
//        '"ARABIC TOBACCO",' +
//        '"PCM WHOLESALERS PTY LTD"';
//    AutoProcessStartTime := EncodeTime(21,0,0,0);
//    AutoProcessEndTime := EncodeTime(07,0,0,0);
//    if DepartmentList = '' then DepartmentList := '976,982,907,983';
//    if ERPDatabase = '' then ERPDatabase := 'smokemart_live';
//    if ERPPassword = '' then ERPPassword := 'webuser';
//    if ERPUser = '' then ERPUser := 'webuser';
//    ProcessDateFrom := Trunc(now -2);
//    Active := false;
//    self.SaveConfig();
  end;
end;

constructor TModPMI.Create;
begin
  inherited;
  AppDatabase.MIN_TABLE_VERSION := '2017.4.2.0';
  Logger.LogAllTypes;
//  LoadConfig(false);
  LoadConfig;
  fProcessNowClicked := false;
  fNextCheckTime := now + OneMin;
  fNextCheckCrashTime := fNextCheckTime + Crash_Check_Interval;
  json := JO;
  Log('Started',ltDetail);
end;

function TModPMI.CreateNewLogger: TLoggerBase;
begin
  result := TDbLogger.Create(nil);
end;

destructor TModPMI.Destroy;
begin
  json.Free;
  inherited;
end;

procedure TModPMI.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;
  Log('DoOnCommandMessage: ' + aData, ltDetail);
end;

procedure TModPMI.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;
  Log('DoOnCommandRequest: ' + aRequest, ltDetail);
end;

procedure TModPMI.DoOnMessage(aClientId: integer; aData,
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData.AsString, ltDetail);
end;

procedure TModPMI.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData, ltDetail);
end;

procedure TModPMI.DoOnRequest(aClientId: integer; aRequest, ctx,
  aResponse: TJsonObject);
var
  methodName: string;
  idx: integer;
begin
  if Terminated then
    exit;
  methodName:= Lowercase(aRequest.S['method']);
  Log('Request: ' +  methodName, ltDetail);
  try
    inherited;

    if ctx.B['Handled'] = true then
      exit;

    idx:= Pos('.',methodName);
    if idx > 0 then
      methodName:= Copy(methodName,idx+1,Length(methodName));

    if SameText(methodName,'GetConfig') then begin
      ObjToJson(self, aResponse.O['result']);
    end
    else if SameText(methodName,'SetConfig') then begin
      if aRequest.ObjectExists('params') then begin
        JsonToObj(aRequest.O['params'],self);
//        self.SaveConfig(false);
        self.SaveConfig;
        JsonRPCUtils.AddResultOk(aResponse);
      end
      else begin
        JsonRPCUtils.AddResultError(aResponse,'Params object missing from request',RPC_INVALID_PARAMS);
      end;
    end
    else if SameText(methodName,'GetGUI') then begin
      aResponse.O['result'].AsString := GuiStr;
    end
    else if SameText(methodName,'Click') then begin
      if SameText(aRequest.O['Params'].S['Name'],'btnProcessNow') then begin
        self.fProcessNowClicked := true;
        self.fNextCheckTime := now;
        JsonRPCUtils.AddResultOk(aResponse);
        aResponse.O['Dialog'].S['Message'] := 'Any unprocessed orders will now be processed and sent to the supplier.';
        aResponse.O['Dialog'].S['Type'] := 'mtInformation';
        aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
      end;
    end
    else begin
      AddResultError(aResponse,'Request method (' + methodName + ') not found',RPC_METHOD_NOT_FOUND);
    end;

  finally
    if Assigned(aResponse) then begin
      if aResponse.Exists('result') then
        Log('Result: ' + aResponse.ItemByName['result'].Value.AsString,ltDetail);
    end;
  end;
end;

procedure TModPMI.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;
  Log('DoOnRequest: ' + aRequest, ltDetail);
end;

procedure TModPMI.DoWork;
var
  params: TJsonObject;
  x: integer;
  j: TJsonObject;
begin
  inherited;

  if now >= fNextCheckCrashTime then begin
    json.Clear;
    ThreadTaskList.GetTaskListAsJson(json);
    for x := 0 to json.A['TaskList'].Count -1 do begin
      j := json.A['TaskList'].Items[x].AsObject;
      if SameText(j.S['ClassName'],'TPMIThreadTask') then begin
        if (now - J.DT['ProgressTime']) >= (OneMin * 5) then begin
          Log('Removing inactive PMI task with Id ' + J.S['askId'] + ' from Task list. ' +
            'Task started at ' + DateTimeToStr(J.DT['StartTime']), ltWarning);
          ThreadTaskList.RemoveTask(J.S['TaskId']);
          fNextCheckTime := now + (OneMin * 2);
        end;
      end;
    end;

    fNextCheckCrashTime := now + Crash_Check_Interval;
  end;


  if now >= fNextCheckTime then begin
    if Active then begin

      params := JO;
      try
        ObjToJson(self,params);
        params.B['ProcessNowClicked'] := fProcessNowClicked;
        ThreadTaskList.AddTask(TPMIThreadTask.Create,0,params);
      finally
        params.Free;
      end;
    end;
    fProcessNowClicked := false;
    fNextCheckTime := now + Check_Interval;
  end;
end;

function TModPMI.GetModuleDescription: string;
begin
  result := 'ERP PMI Integration Module';
end;

function TModPMI.GuiStr: string;
const
  crlf = #13#10;
begin
  result :=
  '{' + crlf +
  '    "Height":300'+',' + crlf +
  '    "Children":[' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":14,' + crlf +
  '                "Width":116,' + crlf +
  '                "Height":40,' + crlf +
  '                "Caption":"PMI Intergration",' + crlf +
  '                "Font.Color":128,' + crlf +
  '                "WordWrap":true,' + crlf +
  '                "Font.Style": ["fsBold","fsUnderline"]' + crlf +
  '        },' + crlf +

  '        {' + crlf +
  '                "ClassName": "TDNMSpeedButton",' + crlf +
  '                "Caption":"Process Now",' + crlf +
  '                "Width":87,' + crlf +
  '                "Height":27,' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":60,' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '                "Style": "bsModern",' + crlf +
  '                "Hint":"Click to send any pending Purchase Orders.",' + crlf +
  '                "Name":"btnProcessNow"' + crlf +
  '        },' + crlf +


  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":119,' + crlf +
  '                "Width":60,' + crlf +
  '                "Top":77,' + crlf +
  '                "Caption":"Active",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TCheckBox",' + crlf +
  '                "Left":189,' + crlf +
  '                "Top":77,' + crlf +
  '                "Width":150,' + crlf +
  '                "Hint":"Click to Enable/Disable this module",' + crlf +
  '                "Name":"Active"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":110,' + crlf +
  '                "Caption":"PO Output Dir",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":107,' + crlf +
  '                "Width":155,' + crlf +
  '                "Hint":"Directory to save purchase orders into",' + crlf +
  '                "Name":"POOutputDir"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":140,' + crlf +
  '                "Caption":"FTP Site",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":137,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"FTP Site address or IP Address",' + crlf +
  '                "Name":"FTPSite"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":170,' + crlf +
  '                "Caption":"FTP User",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":167,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"User name for FTP site",' + crlf +
  '                "Name":"FTPUserName"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":200,' + crlf +
  '                "Caption":"FTP Password",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":197,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"Password for ftp site",' + crlf +
  '                "Name":"FTPPassword"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":230,' + crlf +
  '                "Caption":"Certificate File",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":227,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"Certificate file for FTP site",' + crlf +
  '                "Name":"FTPCertificate"' + crlf +
  '        },' + crlf +

//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":14,' + crlf +
//  '                "Width":200,' + crlf +
//  '                "Top":260,' + crlf +
//  '                "Height":100,' + crlf +
//  '                "Caption":"Exclude Supplier List",' + crlf +
////  '                "WordWrap":true,' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TMemo",' + crlf +
//  '                "Left":59,' + crlf +
//  '                "Top":287,' + crlf +
//  '                "Width":200,' + crlf +
//  '                "Height":170,' + crlf +
//  '                "Hint":"Products from suppliers in this list will not be updated",' + crlf +
//  '                "Name":"ExcludeSupplierList"' + crlf +
//  '        },' + crlf +




  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":80,' + crlf +
  '                "Caption":"Supplier Name",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":77,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"Name of Supplier to automatically send Purchase Orders to",' + crlf +
  '                "Name":"SupplierName"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":140,' + crlf +
  '                "Top":110,' + crlf +
  '                "Caption":"PO Status to process",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TComboBox",' + crlf +
  '                "Left":434,' + crlf +
  '                "Top":107,' + crlf +
  '                "Width":100,' + crlf +
  '                "Style":"csDropDown",' + crlf +
  '                "Items":"'+self.OrderStatusList+'",' + crlf +
  '                "Hint":"Status of Purchase Orders to process",' + crlf +
  '                "Name":"StatusToProcess"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":140,' + crlf +
  '                "Top":140,' + crlf +
  '                "Caption":"PO Status after process",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TComboBox",' + crlf +
  '                "Left":434,' + crlf +
  '                "Top":137,' + crlf +
  '                "Width":100,' + crlf +
  '                "Style":"csDropDown",' + crlf +
  '                "Items":"'+self.OrderStatusList+'",' + crlf +
  '                "Hint":"Status of Purchase Orders after processed",' + crlf +
  '                "Name":"ProcessedStatus"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":170,' + crlf +
  '                "Caption":"GLN Number",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":167,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"GLN (Global Location Number)",' + crlf +
  '                "Name":"GLN"' + crlf +
  '        },' + crlf +


//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":150,' + crlf +
//  '                "Top":110,' + crlf +
//  '                "Caption":"Process Updates From",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TDateTimePicker",' + crlf +
//  '                "Left":434,' + crlf +
//  '                "Top":107,' + crlf +
//  '                "Width":100,' + crlf +
//  '                "Kind":"dtkDate",' + crlf +
//  '                "Hint":"Only process update files that have a date greater or equal to this date",' + crlf +
//  '                "Name":"ProcessDateFrom"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":150,' + crlf +
//  '                "Top":140,' + crlf +
//  '                "Caption":"Auto Process Start Time",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TDateTimePicker",' + crlf +
//  '                "Left":434,' + crlf +
//  '                "Top":137,' + crlf +
//  '                "Width":100,' + crlf +
//  '                "Kind":"dtkTime",' + crlf +
//  '                "Hint":"Any pending files will be automatically processed and stock updated after this time",' + crlf +
//  '                "Name":"AutoProcessStartTime"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Top":170,' + crlf +
//  '                "Caption":"Auto Process End Time",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TDateTimePicker",' + crlf +
//  '                "Left":434,' + crlf +
//  '                "Top":167,' + crlf +
//  '                "Width":100,' + crlf +
//  '                "Kind":"dtkTime",' + crlf +
//  '                "Hint":"Any pending files will be automatically processed and stock updated before this time",' + crlf +
//  '                "Name":"AutoProcessEndTime"' + crlf +
//  '        },' + crlf +

  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":200,' + crlf +
  '                "Caption":"ERP User Name",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":197,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"User Name to use when automatically logging in to ERP to process orders",' + crlf +
  '                "Name":"ERPUser"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":230,' + crlf +
  '                "Caption":"ERP Password",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":227,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"User Password to use when automatically logging in to ERP to process orders",' + crlf +
  '                "Name":"ERPPassword"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":260,' + crlf +
  '                "Caption":"ERP Database",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TComboBox",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":257,' + crlf +
  '                "Width":140,' + crlf +
  '                "Style":"csDropDown",' + crlf +
  '                "Items":"'+ERPDatabaseList(false)+'",' + crlf +
  '                "Hint":"ERP Database to use when automatically logging in to ERP to process orders",' + crlf +
  '                "Name":"ERPDatabase"' + crlf +
  '        }' + crlf +

//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":200,' + crlf +
//  '                "Top":290,' + crlf +
//  '                "Height":100,' + crlf +
//  '                "Caption":"Include Supplier List",' + crlf +
////  '                "WordWrap":true,' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TMemo",' + crlf +
//  '                "Left":343,' + crlf +
//  '                "Top":317,' + crlf +
//  '                "Width":190,' + crlf +
//  '                "Height":140,' + crlf +
//  '                "Hint":"Products from only suppliers in this list will be updated, leave blank for all",' + crlf +
//  '                "Name":"IncludeSupplierList"' + crlf +
//  '        },' + crlf +
  '    ]' + crlf +
  '}';
end;

//procedure TModPMI.LoadConfig(encrypt: boolean);
procedure TModPMI.LoadConfig;
begin
  inherited;

end;

function TModPMI.OrderStatusList: string;
var
  conn: TMyConnection;
  qry: TERPQuery;
begin
  result := '';
  try
    if ERPDatabase <> '' then begin
      conn:= DbUtils.GetNewDbConnection('localhost',ERPDatabase);
      qry := TERPQuery.Create(nil);
      try
        conn.Connect;
        qry.Connection := conn;
        qry.SQL.Text := 'select Name from tblsimpletypes where TypeCode = ' + QuotedStr(SimpleTypes_OrderStatus) + ' and Active = "T"';
        qry.Open;
        while not qry.Eof do begin
          if result <> '' then result := result + ',';
          result := result + qry.FieldByName('Name').AsString;
          qry.Next;
        end;
      finally
        qry.Free;
        conn.Free;
      end;
    end;
  except

  end;
end;

//procedure TModPMI.SaveConfig(encrypt: boolean);
procedure TModPMI.SaveConfig;
begin
  inherited;

end;

procedure TModPMI.SetActive(const Value: boolean);
begin
  inherited;
  if not Value then Begin
    ThreadTaskList.RemoveTask('TPMIThreadTask');

  End;
end;

//procedure TModPerecorp.SetAutoProcessEndTime(const Value: TDateTime);
//begin
//  FAutoProcessEndTime := Value;
//end;
//
//procedure TModPerecorp.SetAutoProcessStartTime(const Value: TDateTime);
//begin
//  FAutoProcessStartTime := Value;
//end;
//
//procedure TModPerecorp.SetDepartmentList(const Value: string);
//begin
//  FDepartmentList := Value;
//end;
//
procedure TModPMI.SetERPDatabase(const Value: string);
begin
  FERPDatabase := Value;
end;

procedure TModPMI.SetERPPassword(const Value: string);
begin
  FERPPassword := Value;
end;

procedure TModPMI.SetERPUser(const Value: string);
begin
  FERPUser := Value;
end;

//procedure TModPerecorp.SetExcludeSupplierList(const Value: string);
//begin
//  FExcludeSupplierList := Value;
//end;
//
procedure TModPMI.SetFtpCertificate(const Value: string);
begin
  FFtpCertificate := Value;
end;

procedure TModPMI.SetFtpPassword(const Value: string);
begin
  FFtpPassword := Value;
end;

procedure TModPMI.SetFtpSite(const Value: string);
begin
  FFtpSite := Value;
end;

procedure TModPMI.SetFtpUserName(const Value: string);
begin
  FFtpUserName := Value;
end;

//procedure TModPerecorp.SetIncludeSupplierList(const Value: string);
//begin
//  FIncludeSupplierList := Value;
//end;
//
//procedure TModPerecorp.SetProcessDateFrom(const Value: TDateTime);
//begin
//  FProcessDateFrom := Value;
//end;
//
//procedure TModPerecorp.SetReportEmailList(const Value: string);
//begin
//  FReportEmailList := Value;
//end;

end.
