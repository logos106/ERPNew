// set this define is you are using Indy 10
{$define INDY100}
// set this define is you are using Indy 9
{.$define INDY90}

unit ModEDI;

interface

uses
  ServerModuleObj, JsonObject, LogThreadBase, LogMessageTypes, ERPDbComponents,
  classes;

type

  TModEDI = class(TServerModule)
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
    fProcessNowClicked: boolean;
    json: TJsonObject;
    fSupplierName: string;
    fProcessedStatus: string;
    fStatusToProcess: string;
    fGLN: string;
    fPOOutputDir: string;
    procedure SetFtpCertificate(const Value: string);
    procedure SetFtpPassword(const Value: string);
    procedure SetFtpSite(const Value: string);
    procedure SetFtpUserName(const Value: string);
    procedure SetERPDatabase(const Value: string);
    procedure SetERPPassword(const Value: string);
    procedure SetERPUser(const Value: string);
    function GuiStr: string;
//    function OrderStatusList: string;
    procedure GetClassProps(Params, aResponse: TJsonObject);
    procedure GetClassList(Params, aResponse: TJsonObject);
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
    constructor Create(aLogger: TLoggerBase = nil); override;
    destructor Destroy; override;
//    procedure LoadConfig(encrypt: boolean = false); override;
//    procedure SaveConfig(encrypt: boolean = false); override;
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  published
//    property FtpSite: string read FFtpSite write SetFtpSite;
//    property FtpUserName: string read FFtpUserName write SetFtpUserName;
//    property FtpPassword: string read FFtpPassword write SetFtpPassword;
//    property FtpCertificate: string read FFtpCertificate write SetFtpCertificate;
//    property ERPDatabase: string read FERPDatabase write SetERPDatabase;
//    property ERPUser: string read FERPUser write SetERPUser;
//    property ERPPassword: string read FERPPassword write SetERPPassword;
//    property SupplierName: string read fSupplierName write fSupplierName;
//    property StatusToProcess: string read fStatusToProcess write fStatusToProcess;
//    property ProcessedStatus: string read fProcessedStatus write fProcessedStatus;
//    property GLN: string read fGLN write fGLN; { Global Location Number }
//    property POOutputDir: string read fPOOutputDir write fPOOutputDir;
  end;


implementation

uses
  SysUtils, LogThreadDbLib, JsonToObject, JsonRPCUtils, types, StrUtils,
  JsonRPCConst, ModuleFileNameUtils, MySQLUtils, DbSharedObjectsObj,
  XMLIntf, XMLDoc, XMLHelperUtils, Math,
  AppEnvironment, ActiveX, BusObjClient, EDIThreadTask, MyAccess, DbUtils,
  BusObjSimpleTypes, BusObjBase, EDIConst, AppDatabase;

const
  OneMin = 1/24/60;
  Check_Interval = OneMin * 2;
  Crash_Check_Interval = OneMin * 5;

{ TModWebPrestaShop }

procedure TModEDI.AfterLoadConfig;
var
  configChanged: boolean;
begin
  inherited;
  configChanged := false;

  if configChanged then begin

  end;
end;

constructor TModEDI.Create(aLogger: TLoggerBase);
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

function TModEDI.CreateNewLogger: TLoggerBase;
begin
  result := TDbLogger.Create(nil);
end;

destructor TModEDI.Destroy;
begin
  json.Free;
  inherited;
end;

procedure TModEDI.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;
  Log('DoOnCommandMessage: ' + aData, ltDetail);
end;

procedure TModEDI.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;
  Log('DoOnCommandRequest: ' + aRequest, ltDetail);
end;

procedure TModEDI.DoOnMessage(aClientId: integer; aData,
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData.AsString, ltDetail);
end;

procedure TModEDI.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnMessage: ' + aData, ltDetail);
end;

procedure TModEDI.DoOnRequest(aClientId: integer; aRequest, ctx,
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
        aResponse.O['Dialog'].S['Message'] := 'Checking for and EDI Documents that are due to be processed.';
        aResponse.O['Dialog'].S['Type'] := 'mtInformation';
        aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
        JsonRPCUtils.AddResultOk(aResponse);
      end
      else if SameText(aRequest.O['Params'].S['Name'],'btnConfig') then begin
        JsonRPCUtils.AddResultOk(aResponse);
        aResponse.O['CustomConfig'].S['CustomConfigName'] := 'ERP_EDIConfig.exe';
      end;
    end
    else if SameText(methodName,'GetObjectProperties') then begin
      GetClassProps(aRequest.O['params'],aResponse);
      //JsonRPCUtils.AddResultOk(aResponse);
    end
    else if SameText(methodName,'GetClassList') then begin
      GetClassList(aRequest.O['params'],aResponse);
    end
    else if SameText(methodName,'GetMapperList') then begin
      aResponse.S['MapperList'] := EDIConst.MapperList;
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

procedure TModEDI.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;
  Log('DoOnRequest: ' + aRequest, ltDetail);
end;

procedure TModEDI.DoWork;
var
  params: TJsonObject;
//  x: integer;
  j: TJsonObject;
begin
  inherited;

//  if now >= fNextCheckCrashTime then begin
//    json.Clear;
//    ThreadTaskList.GetTaskListAsJson(json);
//    for x := 0 to json.A['TaskList'].Count -1 do begin
//      j := json.A['TaskList'].Items[x].AsObject;
//      if SameText(j.S['ClassName'],'TPMIThreadTask') then begin
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


  if now >= fNextCheckTime then begin
    if Active then begin

      params := JO;
      try
        ObjToJson(self,params);
        params.B['ProcessNowClicked'] := fProcessNowClicked;
//        ThreadTaskList.AddTask(TEDIThreadTask.Create,0,params);
        ThreadTaskList.StartTask(TEDIThreadTask,0,params,MySQLServer,true,true);
      finally
        params.Free;
      end;
    end;
    fProcessNowClicked := false;
    fNextCheckTime := now + Check_Interval;
  end;
end;

procedure TModEDI.GetClassList(Params, aResponse: TJsonObject);
begin
  aResponse.S['ClassList'] := 'ERPInvoice,ERPPurchaseOrder';
  JsonRPCUtils.AddResultOk(aResponse);
end;

procedure TModEDI.GetClassProps(Params, aResponse: TJsonObject);
var
  ResourceClass: TPersistentClass;
  BusObj: TBusObj;
  msg: string;
begin
  try
    CoInitialize(nil);
    try

      try
        AppEnv.AppDb.Database := Params.S['Database'];
        AppEnv.AppDb.ConnectUser(Params.S['ERPUser'], Params.S['ERPPass']);
      except
        on eusr: exception do begin
          msg := 'Error connecting to ERP: ' + eusr.Message;
          JsonRPCUtils.AddResultError(aResponse,msg);
          exit;
        end;
      end;
      try
        if not AppEnv.UtilsClient.ConnectUser(msg,'localhost',Params.S['Database'],Params.S['ERPUser'],'','',true) then begin
          msg := 'Could not connect to ERP. ' + msg;
          JsonRPCUtils.AddResultError(aResponse,msg);
          exit;
        end;
        try
          ResourceClass:= GetClass(Params.S['ClassName']);
          if not Assigned(ResourceClass) then begin
            JsonRPCUtils.AddResultError(aResponse,'Could not find ERP Class (' + Params.S['ClassName'] + ') to get Properties for');
            exit;
          end;
          if ResourceClass.InheritsFrom(TBusObj) then begin // InheritsFrom(TBusObj) then begin
      //      BusObj:= TBusObj(ResourceClass).CreateWithNewConn(nil);
            BusObj:= TBusObjClass(ResourceClass).Create(nil);
            try
              BusObj.Connection := TMyDacDataConnection.Create(BusObj);
              BusObj.Connection.Connection := AppEnv.AppDb.TransConnection;
              BusObj.SilentMode := true;
              BusObj.Load(0);
              ObjStructToJson(BusObj,aResponse.O['Props']);
              JsonRPCUtils.AddResultOk(aResponse);
            finally
              BusObj.Free;
            end;
          end
          else begin
            JsonRPCUtils.AddResultError(aResponse,'This ERP Class (' + Params.S['ClassName'] + ') not supported');
          end;

          finally
            AppEnv.UtilsClient.Disconnect;
          end;

        finally
          AppEnv.AppDb.TransConnection.Disconnect;
          AppEnv.AppDb.Connection.Disconnect;
        end;
    finally
      CoUninitialize;
    end;
  except
    on e: exception do begin
      JsonRPCUtils.AddResultError(aResponse,'Error getting information for ERP Class: ' + e.Message);
    end;

  end;
end;

function TModEDI.GetModuleDescription: string;
begin
  result := 'ERP EDI Integration Module';
end;

function TModEDI.GuiStr: string;
const
  crlf = #13#10;
begin
  result :=
  '{' + crlf +
  '    "Height":170'+',' + crlf +
  '    "Children":[' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":14,' + crlf +
  '                "Width":116,' + crlf +
  '                "Height":40,' + crlf +
  '                "Caption":"EDI integration",' + crlf +
  '                "Font.Color":128,' + crlf +
  '                "WordWrap":true,' + crlf +
  '                "Font.Style": ["fsBold","fsUnderline"]' + crlf +
  '        },' + crlf +

  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":60,' + crlf +
  '                "Top":44,' + crlf +
  '                "Caption":"Active",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TCheckBox",' + crlf +
  '                "Left":84,' + crlf +
  '                "Top":44,' + crlf +
  '                "Width":150,' + crlf +
  '                "Hint":"Click to Enable/Disable this module",' + crlf +
  '                "Name":"Active"' + crlf +
  '        },' + crlf +

  '        {' + crlf +
  '                "ClassName": "TDNMSpeedButton",' + crlf +
  '                "Caption":"Process Now",' + crlf +
  '                "Width":87,' + crlf +
  '                "Height":27,' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":74,' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '                "Style": "bsModern",' + crlf +
  '                "Hint":"Click to process any pending EDI Documents.",' + crlf +
  '                "Name":"btnProcessNow"' + crlf +
  '        },' + crlf +

  '        {' + crlf +
  '                "ClassName": "TDNMSpeedButton",' + crlf +
  '                "Caption":"Config",' + crlf +
  '                "Width":87,' + crlf +
  '                "Height":27,' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":114,' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '                "Style": "bsModern",' + crlf +
  '                "Hint":"Click to configure EDI Settings.",' + crlf +
  '                "Name":"btnConfig"' + crlf +
  '        }' + crlf +

  //  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":14,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":110,' + crlf +
//  '                "Caption":"PO Output Dir",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":119,' + crlf +
//  '                "Top":107,' + crlf +
//  '                "Width":155,' + crlf +
//  '                "Hint":"Directory to save purchase orders into",' + crlf +
//  '                "Name":"POOutputDir"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":14,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":140,' + crlf +
//  '                "Caption":"FTP Site",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":119,' + crlf +
//  '                "Top":137,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"FTP Site address or IP Address",' + crlf +
//  '                "Name":"FTPSite"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":14,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":170,' + crlf +
//  '                "Caption":"FTP User",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":119,' + crlf +
//  '                "Top":167,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"User name for FTP site",' + crlf +
//  '                "Name":"FTPUserName"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":14,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":200,' + crlf +
//  '                "Caption":"FTP Password",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":119,' + crlf +
//  '                "Top":197,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"Password for ftp site",' + crlf +
//  '                "Name":"FTPPassword"' + crlf +
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
//
//
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
//
//
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":200,' + crlf +
//  '                "Caption":"ERP User Name",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":394,' + crlf +
//  '                "Top":197,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"User Name to use when automatically logging in to ERP to process orders",' + crlf +
//  '                "Name":"ERPUser"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":230,' + crlf +
//  '                "Caption":"ERP Password",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TEdit",' + crlf +
//  '                "Left":394,' + crlf +
//  '                "Top":227,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Hint":"User Password to use when automatically logging in to ERP to process orders",' + crlf +
//  '                "Name":"ERPPassword"' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TLabel",' + crlf +
//  '                "Left":289,' + crlf +
//  '                "Width":90,' + crlf +
//  '                "Top":260,' + crlf +
//  '                "Caption":"ERP Database",' + crlf +
//  '                "Font.Style": ["fsBold"]' + crlf +
//  '        },' + crlf +
//  '        {' + crlf +
//  '                "ClassName": "TComboBox",' + crlf +
//  '                "Left":394,' + crlf +
//  '                "Top":257,' + crlf +
//  '                "Width":140,' + crlf +
//  '                "Style":"csDropDown",' + crlf +
//  '                "Items":"'+ERPDatabaseList(false)+'",' + crlf +
//  '                "Hint":"ERP Database to use when automatically logging in to ERP to process orders",' + crlf +
//  '                "Name":"ERPDatabase"' + crlf +
//  '        }' + crlf +

  '    ]' + crlf +
  '}';
end;

//procedure TModEDI.LoadConfig(encrypt: boolean);
procedure TModEDI.LoadConfig;
begin
  inherited;

end;

//function TModEDI.OrderStatusList: string;
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

//procedure TModEDI.SaveConfig(encrypt: boolean);
procedure TModEDI.SaveConfig;
begin
  inherited;

end;

procedure TModEDI.SetActive(const Value: boolean);
begin
  inherited;
  if not Value then Begin
    ThreadTaskList.RemoveTask('TEDIThreadTask');

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
procedure TModEDI.SetERPDatabase(const Value: string);
begin
  FERPDatabase := Value;
end;

procedure TModEDI.SetERPPassword(const Value: string);
begin
  FERPPassword := Value;
end;

procedure TModEDI.SetERPUser(const Value: string);
begin
  FERPUser := Value;
end;

//procedure TModPerecorp.SetExcludeSupplierList(const Value: string);
//begin
//  FExcludeSupplierList := Value;
//end;
//
procedure TModEDI.SetFtpCertificate(const Value: string);
begin
  FFtpCertificate := Value;
end;

procedure TModEDI.SetFtpPassword(const Value: string);
begin
  FFtpPassword := Value;
end;

procedure TModEDI.SetFtpSite(const Value: string);
begin
  FFtpSite := Value;
end;

procedure TModEDI.SetFtpUserName(const Value: string);
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
