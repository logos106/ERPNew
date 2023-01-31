unit MagentoObj;

interface

uses
  IdHttp, Classes, LogThreadBase, LogMessageTypes, JsonObject, MageDataFilter,
  mage_v2_soap;

type

(*
    IMPORTANT NOTES

    SOAP API
      1) On the server ensure the PHP SOAP module is enabpled in PHO.ini
      2) Open up ports 80 amd 443

    ERP API
      1)  Copy erpapi.php into ..\mahento\htdocs

*)


  TMagento = class(TObject)
  private
    fOnLogEvent: LogThreadBase.TOnLogEvent;
    Http: TIdHttp;
    fStoreId: integer;
    fStoreURL: string;
    fLogger: TLoggerBase;
    fStream: TStringStream;
    fEntityTypeList: TJsonObject;
    fEntityAttributeSetList: TJsonObject;
    fAPI: Mage_Api_Model_Server_V2_HandlerPortType;
    fApiUser: string;
    fApiKey: string;
    fApiURL: string;
    procedure Log(const aMsg: string; const aType: TLogMessageType);
    procedure SetStoreId(const Value: integer);
    procedure SetStoreURL(const Value: string);
    function GetEntityTypeList: TJsonObject;
    function GetEntityAttributeSetList: TJsonObject;
    function GetApiURL: string;
  protected
    property ApiURL: string read GetApiURL;
  public
    Filter: TMageDataFilter;
    SessionId: string;
    constructor Create;
    destructor Destroy; override;
    property Logger: TLoggerBase read fLogger write fLogger;
    property OnLogEvent: LogThreadBase.TOnLogEvent read fOnLogEvent write fOnLogEvent;
    property StoreURL: string read fStoreURL write SetStoreURL;
    property StoreId: integer read fStoreId write SetStoreId;
    property ApiUser: string read fApiUser write fApiUser;
    property ApiKey: string read fApiKey write fApiKey;
    { store data }
    property EntityTypeList: TJsonObject read GetEntityTypeList;
    function EntityTypeId(entity_type_code: string): string;
    function ProductEntityTypeId: string;

    property EntityAttributeSetList: TJsonObject read GetEntityAttributeSetList;
    function DefaultAttributeSetIdForEntityTypeId(entity_type_id: string): string;

    function DefaultProductAttributeSetId: string;

    function StockItemIdForProductId(ProductId: string): string; overload;
    function StockItemIdForProductId(ProductId: integer): string; overload;

    function API: Mage_Api_Model_Server_V2_HandlerPortType;

    { main functions to Get and Post data to store ... }
    function GetData(Stream: TStream; var Msg: string;
      aStoreID: integer;
      aResource: string;
      aResourceId: integer;
      aFilter: TMageDataFilter): boolean; overload;
    function GetData(Stream: TStream; var Msg: string;
      aResource: string;
      aResourceId: integer;
      aFilter: TMageDataFilter): boolean; overload;
    function GetData(Json: TJsonObject; var Msg: string;
      aResource: string;
      aResourceId: integer;
      aFilter: TMageDataFilter): boolean; overload;
    function GetData(Json: TJsonObject; var Msg: string;
      aResource: string;
      aResourceId: integer): boolean; overload;
    function GetData(Json: TJsonObject; var Msg: string;
      aResource: string): boolean; overload;
    function PostData(JsonIn, JsonOut: TJsonObject; var Msg: string;
      aResource: string; aResourceId: integer = 0): boolean;
  end;

implementation

uses
  SysUtils, URILib, StringUtils, HTTPConst;

const
  api_path = 'erpapi.php/';

{ TMagento }

function TMagento.API: Mage_Api_Model_Server_V2_HandlerPortType;
begin
  if not Assigned(fApi) then begin
    fApi := GetMage_Api_Model_Server_V2_HandlerPortType(false, StoreURL + '/api/v2_soap/');
    SessionId := fApi.login(ApiUser,ApiKey);
  end;
  if SessionId = '' then
    SessionId := fApi.login(ApiUser,ApiKey);
  result := fApi;
end;

constructor TMagento.Create;
begin
  fApiURL := '';
  Http := TIdHttp.Create(nil);
  Http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
  Http.Request.ContentType := 'application/x-www-form-urlencoded';
  Filter := TMageDataFilter.Create;
end;

function TMagento.DefaultAttributeSetIdForEntityTypeId(
  entity_type_id: string): string;
var
  x: integer;
  J: TJsonObject;
begin
  result := '';
  for x := 0 to EntityAttributeSetList.A['items'].Count -1 do begin
    J := EntityAttributeSetList.A['items'].Items[x].AsObject;
    if SameText(J.S['entity_type_id'], entity_type_id) and SameText(J.S['attribute_set_name'], 'Default') then begin
      result := J.S['attribute_set_id'];
      break;
    end;
  end;
end;

function TMagento.DefaultProductAttributeSetId: string;
begin
  result := DefaultAttributeSetIdForEntityTypeId(ProductEntityTypeId);
end;

destructor TMagento.Destroy;
begin
  Http.Free;
  fStream.Free;
  Filter.Free;
  fEntityTypeList.Free;
  fEntityAttributeSetList.Free;
  fAPI := nil;
  inherited;
end;

function TMagento.EntityTypeId(entity_type_code: string): string;
var
  x: integer;
  J: TJsonObject;
begin
  result := '';
  for x := 0 to EntityTypeList.A['items'].Count -1 do begin
    J := EntityTypeList.A['items'].Items[x].AsObject;
    if SameText(J.S['entity_type_code'], entity_type_code) then begin
      result := J.S['entity_type_id'];
      break;
    end;
  end;
end;

function TMagento.GetData(Json: TJsonObject; var Msg: string; aResource: string;
  aResourceId: integer): boolean;
begin
  result := GetData(Json,Msg,aResource,aResourceID,nil);
end;

function TMagento.GetApiURL: string;
begin
  if fApiURL = '' then begin
    fApiURL := StringReplace(self.StoreURL,'index.php/','',[rfIgnoreCase]);
    fApiURL := StringReplace(fApiURL,'index.php','',[rfIgnoreCase]);
    fApiURL := IncludeTrailingForwardSlash(fApiURL) + api_path;
  end;
  result := fApiURL;
end;

function TMagento.GetData(Json: TJsonObject; var Msg: string;
  aResource: string): boolean;
begin
  result := GetData(Json,Msg,aResource,0,Filter);
end;

function TMagento.GetEntityAttributeSetList: TJsonObject;
var
  msg: string;
begin
  if not Assigned(fEntityAttributeSetList) then
    fEntityAttributeSetList := TJsonObject.Create;
  if fEntityAttributeSetList.Count = 0 then begin
    if not GetData(fEntityAttributeSetList,msg,'eav_entity_attribute_set') then
      raise Exception.Create('GetEntityAttributeSetList - ' + msg);
  end;
  result := fEntityAttributeSetList;
end;

function TMagento.GetEntityTypeList: TJsonObject;
var
  msg: string;
begin
  if not Assigned(fEntityTypeList) then
    fEntityTypeList := TJsonObject.Create;
  if fEntityTypeList.Count = 0 then begin
    if not GetData(fEntityTypeList,msg,'eav_entity_type') then
      raise Exception.Create('GetEntityTypeList - ' + msg);
  end;
  result := fEntityTypeList;
end;

function TMagento.GetData(Json: TJsonObject; var Msg: string; aResource: string;
  aResourceId: integer; aFilter: TMageDataFilter): boolean;
begin
  Json.Clear;
  if not Assigned(fStream) then fStream := TStringStream.Create;
  try
    result := GetData(fStream,Msg,aResource,aResourceId,aFilter);
    if result then begin
      fStream.Position := 0;
      try
        Json.ReadFromStream(fStream);
      except
        result := false;
        Msg := 'Error getting data from Magento: ' + fStream.DataString;
      end;
    end;
  finally
    fStream.Clear;
  end;
  if Json.ObjectExists('error') then begin
    result := false;
    msg := Json.O['error'].S['description'];
  end;
end;

function TMagento.GetData(Stream: TStream; var Msg: string; aResource: string;
  aResourceId: integer; aFilter: TMageDataFilter): boolean;
begin
  result := GetData(Stream, Msg, StoreID, aResource, aResourceId, aFilter);
end;

function TMagento.GetData(Stream: TStream; var Msg: string; aStoreID: integer;
  aResource: string; aResourceId: integer; aFilter: TMageDataFilter): boolean;
var
  aURL: string;
//  x: integer;
begin
  result := true;
  aURL := ApiURL + IntToStr(aStoreId) + '/' + aResource;
  if aResourceId > 0 then aURL := aURL + '/' + IntToStr(aResourceId);
  if Assigned(aFilter) then begin
    aFilter.FormatOutput := false;
    Http.Request.CustomHeaders.AddValue('mage_filter', aFilter.AsString);
  end
  else begin
    Http.Request.CustomHeaders.Clear;
//    x := Http.Request.CustomHeaders.IndexOfName('mage_filter');
//    if x > -1 then
//      Http.Request.CustomHeaders.Delete(x);
  end;
//  Http.Request.CustomHeaders.AddValue('mage_filter', '{"fields":["*"]},"filters":[{"field":"entity_id","filter":{"gt":799}]}');
//  Http.Request.CustomHeaders.AddValue('mage_filter', '{"filters":[{"field":"entity_id","filter":{"gt":799}}]}');
  try
    if Stream is TMemoryStream then
      TMemoryStream(Stream).Clear;
    Http.Get(aURL ,Stream);
  except
    on e: exception do begin
      result := false;
      msg := e.Message;
    end;
  end;
end;

procedure TMagento.Log(const aMsg: string; const aType: TLogMessageType);
begin
  if Assigned(fLogger) then fLogger.Log(aMsg, aType);
  if Assigned(fOnLogEvent) then fOnLogEvent(aMsg, aType);
end;

function TMagento.PostData(JsonIn, JsonOut: TJsonObject; var Msg: string;
  aResource: string; aResourceId: integer = 0): boolean;
var
  aURL: string;
begin
  result := true;
  try
    aURL := ApiURL + IntToStr(StoreId) + '/' + aResource;
    if aResourceId > 0 then aURL := aURL + '/' + IntToStr(aResourceId);
    if not Assigned(fStream) then fStream := TStringStream.Create;
    try
      fStream.Clear;
      JsonIn.FormatOutput := false;
      fStream.WriteString('data='+ JsonIn.AsString);
      fStream.Position := 0;
      JsonOut.Clear;
      http.Request.ContentType := 'application/x-www-form-urlencoded';
      JsonOut.AsString := http.Post(aURL, fStream);
    finally
      fStream.Clear;
    end;
  except
    on e: exception do begin
      result := false;
      msg := e.Message;
    end;
  end;
  if JsonOut.ObjectExists('error') then begin
    result := false;
    msg := JsonOut.O['error'].S['description'];
  end;
end;

function TMagento.ProductEntityTypeId: string;
begin
  result := EntityTypeId('catalog_product');
end;

procedure TMagento.SetStoreId(const Value: integer);
begin
  fStoreId := Value;
  FreeAndNil(fEntityTypeList);
  FreeAndNil(fEntityAttributeSetList);
end;

procedure TMagento.SetStoreURL(const Value: string);
begin
  fStoreURL := Value;
  FreeAndNil(fEntityTypeList);
  FreeAndNil(fEntityAttributeSetList);
end;

function TMagento.StockItemIdForProductId(ProductId: integer): string;
begin
  result := StockItemIdForProductId(IntToStr(ProductId));
end;

function TMagento.StockItemIdForProductId(ProductId: string): string;
var
  Json, o: TJsonObject;
  msg: string;
  x: integer;
begin
  result := '';
  Json := TJsonObject.Create;
  try
    if not self.GetData(Json,msg,'cataloginventory_stock_item') then
      raise Exception.Create('StockItemIdForProductId: ' + Msg);
    for x := 0 to Json.A['items'].Count -1 do begin
      o := Json.A['items'].Items[x].AsObject;
      if o.S['product_id'] = ProductId then begin
        result := o.S['item_id'];
        exit;
      end;
    end;
  finally
    Json.Free;
  end;
end;

end.
