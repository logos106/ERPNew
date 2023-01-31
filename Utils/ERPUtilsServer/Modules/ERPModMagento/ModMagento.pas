// set this define is you are using Indy 10
{$define INDY100}
// set this define is you are using Indy 9
{.$define INDY90}

unit ModMagento;

interface

uses
  ServerModuleObj, JsonObject, LogThreadBase, LogMessageTypes, ERPDbComponents,
  classes, mage_v2_soap;

type

  TModMagento = class(TServerModule)
  private
    fNextCheckTime: TDateTime;
    fNextCheckCrashTime: TDateTime;
//    FFtpSite: string;
//    FFtpCertificate: string;
//    FFtpPassword: string;
//    FFtpUserName: string;
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
    fStoreId: string;
    fStoreURL: string;
    fAdminEmail: string;
    fUpdateQuantities: boolean;
    fApiUser: string;
    fApiKey: string;
    fGetStoreDataNowClicked: boolean;
    fGetStoreDataNextCheckTime: TDateTime;
    fUpdateERPFromStore: boolean;
    procedure SetERPPassword(const Value: string);
    procedure SetERPUser(const Value: string);
    function GuiStr: string;
    procedure SetERPDatabase(const Value: string);
    function GetStoreIdInt: integer;
    procedure SetStoreIdInt(const Value: integer);
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
    property StoreIdInt: integer read GetStoreIdInt write SetStoreIdInt;
  published
    property ERPDatabase: string read FERPDatabase write SetERPDatabase;
    property ERPUser: string read FERPUser write SetERPUser;
    property ERPPassword: string read FERPPassword write SetERPPassword;
    property StoreURL: string read fStoreURL write fStoreURL;
    property StoreId: string read fStoreId write fStoreId;
    property AdminEmail: string read fAdminEmail write fAdminEmail;
    property UpdateQuantities: boolean read fUpdateQuantities write fUpdateQuantities;
    property UpdateERPFromStore: boolean read fUpdateERPFromStore write fUpdateERPFromStore;
    property ApiUser: string read fApiUser write fApiUser;
    property ApiKey: string read fApiKey write fApiKey;
  end;


implementation

uses
  SysUtils, LogThreadDbLib, JsonToObject, JsonRPCUtils, types, StrUtils,
  JsonRPCConst, ModuleFileNameUtils, MySQLUtils, DbSharedObjectsObj,
  XMLIntf, XMLDoc, XMLHelperUtils, Math,
  AppEnvironment, ActiveX, BusObjClient, MagentoThreadTask, MyAccess, DbUtils,
  BusObjSimpleTypes;

const
  OneMin = 1/24/60;
  Check_Interval = OneMin * 5;
//  Crash_Check_Interval = OneMin * 5;

{ TModMagento }

procedure TModMagento.AfterLoadConfig;
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

constructor TModMagento.Create;
begin
  inherited;
  Logger.LogAllTypes;
  LoadConfig(false);
  fProcessNowClicked := false;
  fGetStoreDataNowClicked := false;
  fGetStoreDataNextCheckTime := MaxDateTime;
  fNextCheckTime := now + OneMin;
//  fNextCheckCrashTime := fNextCheckTime + Crash_Check_Interval;
  json := JO;
  Log('Started',ltDetail);
end;

function TModMagento.CreateNewLogger: TLoggerBase;
begin
  result := TDbLogger.Create(nil);
end;

destructor TModMagento.Destroy;
begin
  json.Free;
  inherited;
end;

procedure TModMagento.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;
  Log('DoOnCommandMessage: ' + aData, ltDetail);
end;

procedure TModMagento.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;
  Log('DoOnCommandRequest: ' + aRequest, ltDetail);
end;

procedure TModMagento.DoOnMessage(aClientId: integer; aData,
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData.AsString, ltDetail);
end;

procedure TModMagento.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData, ltDetail);
end;

procedure TModMagento.DoOnRequest(aClientId: integer; aRequest, ctx,
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
        aResponse.O['Dialog'].S['Message'] := 'Now checking for new Magento Orders.';
        aResponse.O['Dialog'].S['Type'] := 'mtInformation';
        aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
      end
      else if SameText(aRequest.O['Params'].S['Name'],'btnGetStoreData') then begin
        self.fGetStoreDataNowClicked := true;
        self.fGetStoreDataNextCheckTime := now;
        JsonRPCUtils.AddResultOk(aResponse);
        aResponse.O['Dialog'].S['Message'] := 'Now checking for new Magento Store Data.';
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

procedure TModMagento.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;
  Log('DoOnRequest: ' + aRequest, ltDetail);
end;

procedure TModMagento.DoWork;
var
  params: TJsonObject;
//  x: integer;
//  j: TJsonObject;
begin
  inherited;

//  if now >= fNextCheckCrashTime then begin
//    json.Clear;
//    ThreadTaskList.GetTaskListAsJson(json);
//    for x := 0 to json.A['TaskList'].Count -1 do begin
//      j := json.A['TaskList'].Items[x].AsObject;
//      if SameText(j.S['ClassName'],'TMagentoThreadTask') then begin
//        if (now - J.DT['ProgressTime']) >= (OneMin * 5) then begin
//          Log('Removing inactive PMI task with Id ' + IntToStr(J.I['TaskId']) + ' from Task list. ' +
//            'Task started at ' + DateTimeToStr(J.DT['StartTime']), ltWarning);
//          ThreadTaskList.RemoveTask(J.I['TaskId']);
//          fNextCheckTime := now + (OneMin * 2);
//        end;
//      end;
//    end;
//
//    fNextCheckCrashTime := now + Crash_Check_Interval;
//  end;

  if now >= fGetStoreDataNextCheckTime then begin

    params := JO;
    try
      ObjToJson(self,params);
      params.B['GetStoreDataNowClicked'] := fGetStoreDataNowClicked;
      ThreadTaskList.AddTask(TMagentoThreadTask.Create,0,params);
    finally
      params.Free;
    end;
    fGetStoreDataNowClicked := false;
    fGetStoreDataNextCheckTime := MaxDateTime;
  end;

  if now >= fNextCheckTime then begin
    if Active then begin

      params := JO;
      try
        ObjToJson(self,params);
        params.B['ProcessNowClicked'] := fProcessNowClicked;
        ThreadTaskList.AddTask(TMagentoThreadTask.Create,0,params);
      finally
        params.Free;
      end;
    end;
    fProcessNowClicked := false;
    fNextCheckTime := now + Check_Interval;
  end;
end;

function TModMagento.GetModuleDescription: string;
begin
  result := 'ERP Magento Integration Module';
end;

function TModMagento.GetStoreIdInt: integer;
begin
  result := StrToIntDef(StoreID,0);
end;

function TModMagento.GuiStr: string;
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
  '                "Caption":"Magento Intergration",' + crlf +
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
  '                "Hint":"Click to synch ERP with Magento.",' + crlf +
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
  '                "Caption":"Store ID",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":107,' + crlf +
  '                "Width":100,' + crlf +
  '                "Hint":"Magento Store ID",' + crlf +
  '                "Name":"StoreID"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":140,' + crlf +
  '                "Caption":"Store URL",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":137,' + crlf +
  '                "Width":155,' + crlf +
  '                "Hint":"Address of Magento Store",' + crlf +
  '                "Name":"StoreURL"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":170,' + crlf +
  '                "Caption":"Admin Email",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":167,' + crlf +
  '                "Width":155,' + crlf +
  '                "Hint":"Admin email address",' + crlf +
  '                "Name":"AdminEmail"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":200,' + crlf +
  '                "Caption":"Update Quantity",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TCheckBox",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":197,' + crlf +
  '                "Width":14,' + crlf +
  '                "Caption":"",' + crlf +
  '                "Hint":"Update quantities in Magento based on ERP quantities",' + crlf +
  '                "Name":"UpdateQuantities"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":230,' + crlf +
  '                "Caption":"Update ERP",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TCheckBox",' + crlf +
  '                "Left":119,' + crlf +
  '                "Top":227,' + crlf +
  '                "Width":14,' + crlf +
  '                "Caption":"",' + crlf +
  '                "Hint":"Update ERP data from Store data",' + crlf +
  '                "Name":"UpdateERPFromStore"' + crlf +
  '        },' + crlf +

//  '        {' + crlf +
//  '                "ClassName": "TDNMSpeedButton",' + crlf +
//  '                "Caption":"Get Store Data",' + crlf +
//  '                "Width":87,' + crlf +
//  '                "Height":27,' + crlf +
//  '                "Left":14,' + crlf +
//  '                "Top":227,' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '                "Style": "bsModern",' + crlf +
//  '                "Hint":"Click to update ERP with Store Data.",' + crlf +
//  '                "Name":"btnGetStoreData"' + crlf +
//  '        },' + crlf +


  //  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":14,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":230,' + crlf +
//  '                "Caption":"Certificate File",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":119,' + crlf +
//  '                "Top":227,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"Certificate file for FTP site",' + crlf +
//  '                "Name":"FTPCertificate"' + crlf +
//  '        },' + crlf +



//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":80,' + crlf +
//  '                "Caption":"Supplier Name",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":394,' + crlf +
//  '                "Top":77,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"Name of Supplier to automatically send Purchase Orders to",' + crlf +
//  '                "Name":"SupplierName"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Top":110,' + crlf +
//  '                "Caption":"PO Status to process",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TComboBox",' + crlf +
//  '                "Left":434,' + crlf +
//  '                "Top":107,' + crlf +
//  '                "Width":100,' + crlf +
//  '                "Style":"csDropDown",' + crlf +
//  '                "Items":"'+self.OrderStatusList+'",' + crlf +
//  '                "Hint":"Status of Purchase Orders to process",' + crlf +
//  '                "Name":"StatusToProcess"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Top":140,' + crlf +
//  '                "Caption":"PO Status after process",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TComboBox",' + crlf +
//  '                "Left":434,' + crlf +
//  '                "Top":137,' + crlf +
//  '                "Width":100,' + crlf +
//  '                "Style":"csDropDown",' + crlf +
//  '                "Items":"'+self.OrderStatusList+'",' + crlf +
//  '                "Hint":"Status of Purchase Orders after processed",' + crlf +
//  '                "Name":"ProcessedStatus"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":170,' + crlf +
//  '                "Caption":"GLN Number",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":394,' + crlf +
//  '                "Top":167,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"GLN (Global Location Number)",' + crlf +
//  '                "Name":"GLN"' + crlf +
//  '        },' + crlf +


  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":110,' + crlf +
  '                "Caption":"ERP User Name",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":107,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"User Name to use when automatically logging in to ERP to process orders",' + crlf +
  '                "Name":"ERPUser"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":140,' + crlf +
  '                "Caption":"ERP Password",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":137,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"User Password to use when automatically logging in to ERP to process orders",' + crlf +
  '                "Name":"ERPPassword"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":170,' + crlf +
  '                "Caption":"ERP Database",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TComboBox",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":167,' + crlf +
  '                "Width":140,' + crlf +
  '                "Style":"csDropDown",' + crlf +
  '                "Items":"'+ERPDatabaseList(false)+'",' + crlf +
  '                "Hint":"ERP Database to use when automatically logging in to ERP to process orders",' + crlf +
  '                "Name":"ERPDatabase"' + crlf +
  '        }' + crlf +

  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":200,' + crlf +
  '                "Caption":"Magento API User",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":197,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"Magento API User Name",' + crlf +
  '                "Name":"ApiUser"' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":289,' + crlf +
  '                "Width":90,' + crlf +
  '                "Top":230,' + crlf +
  '                "Caption":"Magento API Key",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TEdit",' + crlf +
  '                "Left":394,' + crlf +
  '                "Top":227,' + crlf +
  '                "Width":140,' + crlf +
  '                "Hint":"Magento API Key",' + crlf +
  '                "Name":"ApiKey"' + crlf +
  '        },' + crlf +

  '    ]' + crlf +
  '}';
end;

procedure TModMagento.LoadConfig(encrypt: boolean);
begin
  inherited;

end;

//function TModMagento.OrderStatusList: string;
//var
//  conn: TMyConnection;
//  qry: TERPQuery;
//begin
//  result := '';
//  try
//    if ERPDatabase <> '' then begin
//      conn:= DbUtils.GetNewDbConnection('localhost',ERPDatabase);
//      qry := TERPQuery.Create(nil);
//      try
//        conn.Connect;
//        qry.Connection := conn;
//        qry.SQL.Text := 'select Name from tblsimpletypes where TypeCode = ' + QuotedStr(SimpleTypes_OrderStatus) + ' and Active = "T"';
//        qry.Open;
//        while not qry.Eof do begin
//          if result <> '' then result := result + ',';
//          result := result + qry.FieldByName('Name').AsString;
//          qry.Next;
//        end;
//      finally
//        qry.Free;
//        conn.Free;
//      end;
//    end;
//  except
//
//  end;
//end;

procedure TModMagento.SaveConfig(encrypt: boolean);
begin
  inherited;

end;

procedure TModMagento.SetActive(const Value: boolean);
begin
  inherited;
  if not Value then Begin
    ThreadTaskList.RemoveTask('TMagentoThreadTask');

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
procedure TModMagento.SetERPDatabase(const Value: string);
begin
  FERPDatabase := Value;
end;

procedure TModMagento.SetERPPassword(const Value: string);
begin
  FERPPassword := Value;
end;

procedure TModMagento.SetERPUser(const Value: string);
begin
  FERPUser := Value;
end;


procedure TModMagento.SetStoreIdInt(const Value: integer);
begin
  StoreId := IntToStr(Value);
end;

end.
