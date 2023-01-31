unit BusObjCoreEDIConfig;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, ErpDbComponents, JsonObject;

type

  TCoreEDIConfig = class(TMSBusObj)
  private
    fConfig: TJsonObject;
    function GetClientId: integer;
    function GetX12_ConfigStr: string;
    procedure SetClientId(const Value: integer);
    procedure SetX12_ConfigStr(const Value: string);
    function GetX12_POSendActive: boolean;
    function GetX12_SalesSendActive: boolean;
    procedure SetX12_POSendActive(const Value: boolean);
    procedure SetX12_SalesSendActive(const Value: boolean);
    function GetConfig: TJsonObject;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ): Boolean; override;
    Function  DoAfterPost(Sender :TDatasetBusObj ): Boolean; override;
    function GetSQL: string; override;
  public
    procedure Load(const fIsReadonly: boolean = False); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property Config: TJsonObject read GetConfig;
  published
    property ClientId: integer read GetClientId write SetClientId;
    property X12_POSendActive: boolean read GetX12_POSendActive write SetX12_POSendActive;
    property X12_SalesSendActive: boolean read GetX12_SalesSendActive write SetX12_SalesSendActive;
    property X12_ConfigStr: string read GetX12_ConfigStr write SetX12_ConfigStr;
  end;

implementation

uses
  BusObjClient, SysUtils;

{ TCoreEDIConfig }

constructor TCoreEDIConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'CoreEDIConfig';
  fSQL := 'SELECT * FROM tblCoreEDIConfig';
end;

destructor TCoreEDIConfig.Destroy;
begin
  try fConfig.Free; Except end;
  inherited;
end;

function TCoreEDIConfig.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) and (Owner is TClient) and (TClient(Owner).ID > 0) then
    ClientId := TClient(Owner).ID;
end;

function TCoreEDIConfig.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then exit;

end;

procedure TCoreEDIConfig.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

class function TCoreEDIConfig.GetBusObjectTablename: string;
begin
  result := 'tblCoreEDIConfig';
end;


function TCoreEDIConfig.GetConfig: TJsonObject;
begin
  if not Assigned(fConfig) then begin
    fConfig := JO;
    fConfig.AsString := X12_ConfigStr;
  end;
  result := fConfig;
end;
class function TCoreEDIConfig.GetIDField: string;
begin
  result := 'ID';
end;

function TCoreEDIConfig.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TCoreEDIConfig.Load(const fIsReadonly: boolean);
begin
  inherited;
  Config.AsString := X12_ConfigStr;
end;

procedure TCoreEDIConfig.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TCoreEDIConfig.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  try fConfig.Free; Except end;
  try fConfig:= nil; Except end;
  with Config do begin
    if not (Exists('ID')) or (I['ID'] =0) then begin
      I['ID'] := ID;
      X12_ConfigStr := AsString;
      PostDB;
    end;
  end;
end;

function TCoreEDIConfig.Save: Boolean;
begin
  if not(Config.Exists('ID')) or
      (Config.I['ID']=0) then Config.I['ID'] := ID;
  ResultStatus.Clear;
  if Assigned(fConfig) then
    X12_ConfigStr := fConfig.AsString;
  result := ValidateData;
  if not result then exit;
  result := inherited;
end;

procedure TCoreEDIConfig.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;
function TCoreEDIConfig.GetClientId: integer;begin  result := GetIntegerField('ClientID');end;
function TCoreEDIConfig.GetX12_ConfigStr: string;begin  result := GetStringField('X12_ConfigStr');end;
function TCoreEDIConfig.GetX12_POSendActive: boolean;begin  result := GetBooleanField('X12_POSendActive');end;
function TCoreEDIConfig.GetX12_SalesSendActive: boolean;begin  result := GetBooleanField('X12_SalesSendActive');end;
procedure TCoreEDIConfig.SetClientId(const Value: integer);begin  SetIntegerField('ClientID', value);end;
procedure TCoreEDIConfig.SetX12_ConfigStr(const Value: string);begin  SetStringField('X12_ConfigStr', value);end;
procedure TCoreEDIConfig.SetX12_POSendActive(const Value: boolean);begin  SetBooleanField('X12_POSendActive', Value);end;
procedure TCoreEDIConfig.SetX12_SalesSendActive(const Value: boolean);begin  SetBooleanField('X12_SalesSendActive', Value);end;

function TCoreEDIConfig.ValidateData: Boolean;begin  result := true;end;

initialization
  RegisterClass(TCoreEDIConfig);

end.
