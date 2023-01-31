unit utBaseCoreService;

interface

uses
  JsonObject;

type
  TCoreServiceEvent = procedure (Sender: TObject; const EventName: string; Data: TJsonObject = nil) of object;

  TBaseCoreService = class
  private
    fOnEvent: TCoreServiceEvent;
    fiTimeout: Integer;
    procedure SetInitialized(const Value: boolean);
  protected
    fCoreEDI: TObject;
    fInitialized: boolean;
    fResultData: TJsonObject;
    Class function GetServiceName: string; virtual;
    procedure Write(const data: string);
    function WriteAndWait(const data: string; const aTimeout: integer = 10000): string;
    procedure TriggerEvent(const EventName: string; Data: TJsonObject);
    procedure InitRequestParams(areq :TJsonObject);Virtual;
  public
    constructor Create; overload;virtual;
    constructor Create(aCoreEDI: TObject); overload;virtual;
    destructor Destroy; override;
    property CoreEDI: TObject read fCoreEDI write fCoreEDI;
    property ServiceName: string read GetServiceName;
    procedure Process(const data: string); virtual;
    function ProcessAndReturn(const data: string): string; virtual;
    property OnEvent: TCoreServiceEvent read fOnEvent write fOnEvent;
    function Initialize: boolean; virtual;
    property Initialized: boolean read fInitialized write SetInitialized;
    property ResultData: TJsonObject read fResultData;
    function IdForName(const aObjectType, aObjectName: string; Data: TJsonObject = nil): boolean; virtual;
//    function IdForParams(const aObjectType: string; aParams: JsonObject): boolean; virtual;
    function InvoiceID(CustID: string; TotalInc: double; InvoiceDate: TDateTime): boolean;
    function AddERPObject(obj: TJsonObject): boolean;
    function ERPObjectExists(aType, aObjectID: string; var Exists: boolean): boolean;
    function GetObject(aObjectType: string; aObjectID: string): boolean;
    function GetData(QueryParams: string): boolean;
    function SendEDIDoc(aERPDoc, aConfig: TJsonObject; aCommand :String ='SendEDIDocument'): boolean;
    function GetPOEDIDocList(aData: TJsonObject; aConfig: TJsonObject): boolean;
    function DeleteMessage(aConfig: TJsonObject): boolean;
    Property Timeout : Integer read fiTimeout write fiTimeout;
  end;

implementation

uses
  CoreEDIObj;

{ TCoreServiceBase }

function TBaseCoreService.AddERPObject(obj: TJsonObject): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'AddERPObject';
    req.O['Params'].Assign(obj);
    InitRequestParams(req);
    fResultData.AsString := self.WriteAndWait(req.AsString, timeout);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

constructor TBaseCoreService.Create(aCoreEDI: TObject);
begin
  inherited Create;
  fInitialized := false;
  fResultData := JO;
  fiTimeout := 10000;
  fCoreEDI := aCoreEDI;
end;

constructor TBaseCoreService.Create;
begin
  fInitialized := false;
  fResultData := JO;
  fiTimeout := 10000;
end;

function TBaseCoreService.DeleteMessage(aConfig: TJsonObject): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'DeleteMessage';
    req.O['Params'].Assign(aConfig);
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

destructor TBaseCoreService.Destroy;
begin
  fResultData.Free;
  inherited;
end;

function TBaseCoreService.ERPObjectExists(aType, aObjectID: string;
  var Exists: boolean): boolean;
var
  req, json: TJsonObject;
begin
  req := JO;
  json := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'ERPObjectExists';
    req.O['Params'].S['ObjectType'] := aType;
    req.O['Params'].S['Id'] := aObjectId;
    json.AsString := self.WriteAndWait(req.AsString);
    result := json.S['ReturnCode'] = 'Ok';
    if result then
      Exists := json.B['ERPObjectExists'];
  finally
    req.Free;
    json.Free;
  end;
end;

function TBaseCoreService.GetData(QueryParams: string): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'GetData';
    req.O['Params'].S['QueryParams'] := QueryParams;
    InitRequestParams(req);
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;
function TBaseCoreService.GetPOEDIDocList(aData: TJsonObject;
  aConfig: TJsonObject): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'GetPOEDIDocList';
    req.O['Params'].O['Config'].Assign(aConfig);
    fResultData.AsString := self.WriteAndWait(req.AsString);
    aData.Assign(fResultData.O['Data']);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

procedure TBaseCoreService.InitRequestParams(areq :TJsonObject);
begin
  //
end;
function TBaseCoreService.GetObject(aObjectType, aObjectID: string): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'GetObject';
    req.O['Params'].S['ObjectType'] := aObjectType;
    req.O['Params'].S['Id'] := aObjectId;
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

Class function TBaseCoreService.GetServiceName: string;
begin
  result := '';
end;

function TBaseCoreService.IdForName(const aObjectType, aObjectName: string; Data: TJsonObject): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'IdForName';
    req.O['Params'].S['ObjectType'] := aObjectType;
    req.O['Params'].S['ObjectName'] := aObjectName;
    if Assigned(Data) then
      req.O['Params'].O['Data'].Assign(Data);
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

//function TBaseCoreService.IdForParams(const aObjectType: string;
//  aParams: JsonObject): boolean;
//var
//  req: TJsonObject;
//begin
//  req := JO;
//  try
//    req.FormatOutput := false;
//    req.S['Command'] := 'IdForParams';
//    req.O['Params'].Assign(aParams);
//    req.O['Params']. S['ObjectType'] := aObjectType;
//    fResultData.AsString := self.WriteAndWait(req.AsString);
//    result := fResultData.S['ReturnCode'] = 'Ok';
//  finally
//    req.Free;
//  end;
//end;

function TBaseCoreService.Initialize: boolean;
begin
  result := true;
end;

function TBaseCoreService.InvoiceID(CustID: string; TotalInc: double;
  InvoiceDate: TDateTime): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'InvoiceId';
    req.O['Params'].S['CustomerId'] := CustId;
    req.O['Params'].F['TotalInc'] := TotalInc;
    req.O['Params'].DT['InvoiceDate'] := InvoiceDate;
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

procedure TBaseCoreService.Process(const data: string);
begin

end;

function TBaseCoreService.ProcessAndReturn(const data: string): string;
begin
  result := '';
end;

function TBaseCoreService.SendEDIDoc(aERPDoc, aConfig: TJsonObject; aCommand :String ='SendEDIDocument' ): boolean;
var
  req: TJsonObject;
begin
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := aCommand;
    req.O['Params'].O['Document'].Assign(aERPDoc);
    req.O['Params'].O['Config'].Assign(aConfig);
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;
end;

procedure TBaseCoreService.SetInitialized(const Value: boolean);
begin
  if Value then
    fInitialized := Initialize
  else
    fInitialized := false;
end;

procedure TBaseCoreService.TriggerEvent(const EventName: string; Data: TJsonObject);
begin
  if Assigned(fOnEvent) then
    fOnEvent(self, EventName, Data);
end;

procedure TBaseCoreService.Write(const data: string);
begin
  TCoreEDI(fCoreEDI).Write(ServiceName, data);
end;

function TBaseCoreService.WriteAndWait(const data: string;
  const aTimeout: integer): string;
begin
  result := TCoreEDI(fCoreEDI).WriteAndWait(ServiceName, data);
end;

end.
