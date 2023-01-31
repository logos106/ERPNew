// set this define is you are using Indy 10
{$define INDY100}
// set this define is you are using Indy 9
{.$define INDY90}

unit ModPerecorp;

interface

uses
  ServerModuleObj, JsonObject, LogThreadBase, LogMessageTypes, ERPDbComponents,
  classes;

type

  TModPerecorp = class(TServerModule)
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
    FIncludeSupplierList: string;
    FExcludeSupplierList: string;
    FReportEmailList: string;
    FAutoProcessStartTime: TDateTime;
    FAutoProcessEndTime: TDateTime;
    fProcessNowClicked: boolean;
    FDepartmentList: string;
    json: TJsonObject;
    FProcessDateFrom: TDateTime;
    procedure SetFtpCertificate(const Value: string);
    procedure SetFtpPassword(const Value: string);
    procedure SetFtpSite(const Value: string);
    procedure SetFtpUserName(const Value: string);
    procedure SetERPDatabase(const Value: string);
//    function FTPParamsOk: boolean;
    procedure SetERPPassword(const Value: string);
    procedure SetERPUser(const Value: string);
    procedure SetIncludeSupplierList(const Value: string);
    procedure SetExcludeSupplierList(const Value: string);
    function GuiStr: string;
    procedure SetReportEmailList(const Value: string);
    procedure SetAutoProcessEndTime(const Value: TDateTime);
    procedure SetAutoProcessStartTime(const Value: TDateTime);
    procedure SetDepartmentList(const Value: string);
    procedure SetProcessDateFrom(const Value: TDateTime);
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
    procedure LoadConfig(encrypt: boolean = false); override;
    procedure SaveConfig(encrypt: boolean = false); override;
  published
    property FtpSite: string read FFtpSite write SetFtpSite;
    property FtpUserName: string read FFtpUserName write SetFtpUserName;
    property FtpPassword: string read FFtpPassword write SetFtpPassword;
    property FtpCertificate: string read FFtpCertificate write SetFtpCertificate;
    property ERPDatabase: string read FERPDatabase write SetERPDatabase;
    property ERPUser: string read FERPUser write SetERPUser;
    property ERPPassword: string read FERPPassword write SetERPPassword;
    { List of Supplier names to ignore in the import }
    property ExcludeSupplierList: string read FExcludeSupplierList write SetExcludeSupplierList;
    { List of Supplier names to include in the import }
    property IncludeSupplierList: string read FIncludeSupplierList write SetIncludeSupplierList;
    property ReportEmailList: string read FReportEmailList write SetReportEmailList;
    property AutoProcessStartTime: TDateTime read FAutoProcessStartTime write SetAutoProcessStartTime;
    property AutoProcessEndTime: TDateTime read FAutoProcessEndTime write SetAutoProcessEndTime;
    property DepartmentList: string read FDepartmentList write SetDepartmentList;
    property ProcessDateFrom: TDateTime read FProcessDateFrom write SetProcessDateFrom;
  end;


implementation

uses
  SysUtils, LogThreadDbLib, JsonToObject, JsonRPCUtils, types, StrUtils,
  JsonRPCConst, ModuleFileNameUtils, MySQLUtils, DbSharedObjectsObj,
  XMLIntf, XMLDoc, XMLHelperUtils, Math,
  BusObjStock, AppEnvironment, ActiveX, BusObjClient, BusObjUOM,
  EmailUtilsSimple, PerecorpThreadTask;

const
  OneMin = 1/24/60;
  Check_Interval = OneMin * 15;
  Crash_Check_Interval = OneMin * 5;

{ TModWebPrestaShop }

procedure TModPerecorp.AfterLoadConfig;
var
  configChanged: boolean;
begin
  inherited;
  configChanged := false;
  if FtpSite = '' then begin
    FtpSite := 'ftp.perecorp.com.au';
    configChanged := true;
  end;
  if FtpUserName = '' then begin
    FtpUserName := 'TimPOS';
    configChanged := true;
  end;
  if FtpPassword = '' then begin
    FtpPassword := 'xTw5xQw7';
    configChanged := true;
  end;
  if FtpCertificate = '' then begin
    FtpCertificate := 'perecorp.ppk';
    configChanged := true;
  end;


  if configChanged then begin
    if ExcludeSupplierList = '' then
      ExcludeSupplierList :=
        'SMOKEMART,' +
        '"C STORE",' +
        '"GIFTBOX",' +
        '"REDLINE",' +
        '"TABACO LEAF PTY LTD",' +
        '"TUNBAC NATIONAL PTY LTD",' +
        '"LEBARA",' +
        '"ARABIC TOBACCO",' +
        '"PCM WHOLESALERS PTY LTD"';
    AutoProcessStartTime := EncodeTime(0,0,1,0);
    AutoProcessEndTime := EncodeTime(23,59,59,0);
    if DepartmentList = '' then DepartmentList := '976,982,907,983';
    if ERPDatabase = '' then ERPDatabase := 'smokemart_test';
    if ERPPassword = '' then ERPPassword := 'webuser';
    if ERPUser = '' then ERPUser := 'webuser';
    ProcessDateFrom := Trunc(now -2);
    Active := false;
    self.SaveConfig();
  end;
end;

constructor TModPerecorp.Create;
begin
  inherited;
  Logger.LogAllTypes;
  LoadConfig(false);
  fProcessNowClicked := false;
  fNextCheckTime := now + OneMin;
  fNextCheckCrashTime := fNextCheckTime + Crash_Check_Interval;
  json := JO;
  Log('Started',ltDetail);
end;

function TModPerecorp.CreateNewLogger: TLoggerBase;
begin
  result := TDbLogger.Create(nil);
end;

destructor TModPerecorp.Destroy;
begin
  json.Free;
  inherited;
end;

procedure TModPerecorp.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;
  Log('DoOnCommandMessage: ' + aData, ltDetail);
end;

procedure TModPerecorp.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;
  Log('DoOnCommandRequest: ' + aRequest, ltDetail);
end;

procedure TModPerecorp.DoOnMessage(aClientId: integer; aData,
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData.AsString, ltDetail);
end;

procedure TModPerecorp.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData, ltDetail);
end;

procedure TModPerecorp.DoOnRequest(aClientId: integer; aRequest, ctx,
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
        self.SaveConfig(false);
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
        aResponse.O['Dialog'].S['Message'] := 'Any unprocessed files will now be processed and inventory will be updated.';
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

procedure TModPerecorp.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;
  Log('DoOnRequest: ' + aRequest, ltDetail);
end;

procedure TModPerecorp.DoWork;
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
      if SameText(j.S['ClassName'],'TPerecorpThreadTask') then begin
        if (now - J.DT['ProgressTime']) >= (OneMin * 5) then begin
          Log('Removing inactive Perecorp task with Id ' + J.S['TaskId'] + ' from Task list. ' +
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

      //ThreadTaskList.RemoveTask('TPerecorpThreadTask');

      params := JO;
      try
        ObjToJson(self,params);
        params.B['ProcessNowClicked'] := fProcessNowClicked;
        ThreadTaskList.AddTask(TPerecorpThreadTask.Create,0,params);
      finally
        params.Free;
      end;
    end;
    fProcessNowClicked := false;
    fNextCheckTime := now + Check_Interval;
  end;
end;

function TModPerecorp.GetModuleDescription: string;
begin
  result := 'ERP Perecorp Integration Module';
end;

function TModPerecorp.GuiStr: string;
const
  crlf = #13#10;
begin
  result :=
  '{' + crlf +
  '    "Height":475'+',' + crlf +
  '    "Children":[' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":14,' + crlf +
  '                "Width":116,' + crlf +
  '                "Height":40,' + crlf +
  '                "Caption":"Perecorp Intergration",' + crlf +
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
  '                "Hint":"Click to update inventory from unprocessed update files.",' + crlf +
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
  '                "Caption":"Email List",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":107,' + crlf +
  '                "Width":155,' + crlf +
  '                "Hint":"Comma separated list of email addresses to send reports to",' + crlf +
  '                "Name":"ReportEmailList"' + crlf +
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

  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":200,' + crlf +
  '                "Top":260,' + crlf +
  '                "Height":100,' + crlf +
  '                "Caption":"Exclude Supplier List",' + crlf +
//  '                "WordWrap":true,' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TMemo",' + crlf +
  '                "Left":59,' + crlf +
  '                "Top":287,' + crlf +
  '                "Width":200,' + crlf +
  '                "Height":170,' + crlf +
  '                "Hint":"Products from suppliers in this list will not be updated",' + crlf +
  '                "Name":"ExcludeSupplierList"' + crlf +
  '        },' + crlf +




  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":80,' + crlf +
  '                "Caption":"Dept/Store List",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":77,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"List of department/store file codes that will be updated, if list is blank all files will be processed",' + crlf +
  '                "Name":"DepartmentList"' + crlf +
  '        },' + crlf +

  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":150,' + crlf +
  '                "Top":110,' + crlf +
  '                "Caption":"Process Updates From",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TDateTimePicker",' + crlf +
  '                "Left":434,' + crlf +
  '                "Top":107,' + crlf +
  '                "Width":100,' + crlf +
  '                "Kind":"dtkDate",' + crlf +
  '                "Hint":"Only process update files that have a date greater or equal to this date",' + crlf +
  '                "Name":"ProcessDateFrom"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":150,' + crlf +
  '                "Top":140,' + crlf +
  '                "Caption":"Auto Process Start Time",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TDateTimePicker",' + crlf +
  '                "Left":434,' + crlf +
  '                "Top":137,' + crlf +
  '                "Width":100,' + crlf +
  '                "Kind":"dtkTime",' + crlf +
  '                "Hint":"Any pending files will be automatically processed and stock updated after this time",' + crlf +
  '                "Name":"AutoProcessStartTime"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":140,' + crlf +
  '                "Top":170,' + crlf +
  '                "Caption":"Auto Process End Time",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TDateTimePicker",' + crlf +
  '                "Left":434,' + crlf +
  '                "Top":167,' + crlf +
  '                "Width":100,' + crlf +
  '                "Kind":"dtkTime",' + crlf +
  '                "Hint":"Any pending files will be automatically processed and stock updated before this time",' + crlf +
  '                "Name":"AutoProcessEndTime"' + crlf +
  '        },' + crlf +

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
  '                "Hint":"User Name to use when automatically logging in to ERP to process files",' + crlf +
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
  '                "Hint":"User Password to use when automatically logging in to ERP to process files",' + crlf +
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
  '                "Hint":"ERP Database to use when automatically logging in to ERP to process files",' + crlf +
  '                "Name":"ERPDatabase"' + crlf +
  '        }' + crlf +

  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":200,' + crlf +
  '                "Top":290,' + crlf +
  '                "Height":100,' + crlf +
  '                "Caption":"Include Supplier List",' + crlf +
//  '                "WordWrap":true,' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TMemo",' + crlf +
  '                "Left":343,' + crlf +
  '                "Top":317,' + crlf +
  '                "Width":190,' + crlf +
  '                "Height":140,' + crlf +
  '                "Hint":"Products from only suppliers in this list will be updated, leave blank for all",' + crlf +
  '                "Name":"IncludeSupplierList"' + crlf +
  '        },' + crlf +


//  '        {' + crlf +
//  '                "ClassName": "TBevel",' + crlf +
//  '                "Left":3,' + crlf +
//  '                "Top":3,' + crlf +
//  '                "Width":'+IntToStr(PanelWidth-6)+',' + crlf +
//  '                "Height":'+IntToStr(PanelHeight-6)+'' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":10,' + crlf +
//  '                "Top":10,' + crlf +
//  '                "Caption":"Test Module",' + crlf +
//  '                "Font.Color":128,' + crlf +
//  '                "Font.Style": ["fsBold","fsUnderline"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TDNMSpeedButton",' + crlf +
//  '                "Caption":"Log",' + crlf +
//  '                "Width":87,' + crlf +
//  '                "Height":27,' + crlf +
//  '                "Left":'+IntToStr(PanelWidth-87-3-10)+',' + crlf +
//  '                "Top":14,' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '                "Style": "bsModern"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLoggingLevel",' + crlf +
//  '                "Width":345,' + crlf +
//  '                "Height":50,' + crlf +
//  '                "Left":'+IntToStr(PanelWidth-87-3-10-(345+20))+',' + crlf +
//  '                "Top":14' + crlf +
//  '        } ' + crlf +
  '    ]' + crlf +
  '}';
end;

procedure TModPerecorp.LoadConfig(encrypt: boolean);
begin
  inherited;

end;

procedure TModPerecorp.SaveConfig(encrypt: boolean);
begin
  inherited;

end;

procedure TModPerecorp.SetActive(const Value: boolean);
begin
  inherited;
  if not Value then Begin
    ThreadTaskList.RemoveTask('TPerecorpThreadTask');

  End;
end;

procedure TModPerecorp.SetAutoProcessEndTime(const Value: TDateTime);
begin
  FAutoProcessEndTime := Value;
end;

procedure TModPerecorp.SetAutoProcessStartTime(const Value: TDateTime);
begin
  FAutoProcessStartTime := Value;
end;

procedure TModPerecorp.SetDepartmentList(const Value: string);
begin
  FDepartmentList := Value;
end;

procedure TModPerecorp.SetERPDatabase(const Value: string);
begin
  FERPDatabase := Value;
end;

procedure TModPerecorp.SetERPPassword(const Value: string);
begin
  FERPPassword := Value;
end;

procedure TModPerecorp.SetERPUser(const Value: string);
begin
  FERPUser := Value;
end;

procedure TModPerecorp.SetExcludeSupplierList(const Value: string);
begin
  FExcludeSupplierList := Value;
end;

procedure TModPerecorp.SetFtpCertificate(const Value: string);
begin
  FFtpCertificate := Value;
end;

procedure TModPerecorp.SetFtpPassword(const Value: string);
begin
  FFtpPassword := Value;
end;

procedure TModPerecorp.SetFtpSite(const Value: string);
begin
  FFtpSite := Value;
end;

procedure TModPerecorp.SetFtpUserName(const Value: string);
begin
  FFtpUserName := Value;
end;

procedure TModPerecorp.SetIncludeSupplierList(const Value: string);
begin
  FIncludeSupplierList := Value;
end;

procedure TModPerecorp.SetProcessDateFrom(const Value: TDateTime);
begin
  FProcessDateFrom := Value;
end;

procedure TModPerecorp.SetReportEmailList(const Value: string);
begin
  FReportEmailList := Value;
end;

end.
