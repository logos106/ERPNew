unit BusObjPosKeypadCustomise;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TPosKeypadCustomise = class(TMSBusObj)
  private
    function GetKeypadID: Integer;
    function GetKeyName: string;
    function GetQuickKey: Boolean;
    function GetCaptionLine1: string;
    function GetCaptionLine2: string;
    function GetFontColour: Integer;
    function GetFontName: string;
    function GetFontSize: Integer;
    function GetFontBold: Boolean;
    function GetFontItalic: Boolean;
    function GetFontUnderline: Boolean;
    function GetBackgroundColour: Integer;
    function GetTopMargin: Double;
    function GetProductID: Integer;
    function GetFunctionNo: Integer;
    function GetFunctionType: Integer;
    function GetFunctionName: string;
    function GetHint: string;
    function GetRoomID: Integer;
    function GetMemo: string;
    procedure SetKeypadID(const Value: Integer);
    procedure SetKeyName(const Value: string);
    procedure SetQuickKey(const Value: Boolean);
    procedure SetCaptionLine1(const Value: string);
    procedure SetCaptionLine2(const Value: string);
    procedure SetFontColour(const Value: Integer);
    procedure SetFontName(const Value: string);
    procedure SetFontSize(const Value: Integer);
    procedure SetFontBold(const Value: Boolean);
    procedure SetFontItalic(const Value: Boolean);
    procedure SetFontUnderline(const Value: Boolean);
    procedure SetBackgroundColour(const Value: Integer);
    procedure SetTopMargin(const Value: Double);
    procedure SetProductID(const Value: Integer);
    procedure SetFunctionNo(const Value: Integer);
    procedure SetFunctionType(const Value: Integer);
    procedure SetFunctionName(const Value: string);
    procedure SetHint(const Value: string);
    procedure SetRoomID(const Value: Integer);
    procedure SetMemo(const Value: string);
    function GetProductName: string;
    procedure SetProductName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function _Schema: string; override;
  published
    property KeypadID: Integer read GetKeypadID write SetKeypadID;
    property KeyName: string read GetKeyName write SetKeyName;
    property QuickKey: Boolean read GetQuickKey write SetQuickKey;
    property CaptionLine1: string read GetCaptionLine1 write SetCaptionLine1;
    property CaptionLine2: string read GetCaptionLine2 write SetCaptionLine2;
    property FontColour: Integer read GetFontColour write SetFontColour;
    property FontName: string read GetFontName write SetFontName;
    property FontSize: Integer read GetFontSize write SetFontSize;
    property FontBold: Boolean read GetFontBold write SetFontBold;
    property FontItalic: Boolean read GetFontItalic write SetFontItalic;
    property FontUnderline: Boolean read GetFontUnderline write SetFontUnderline;
    property BackgroundColour: Integer read GetBackgroundColour write SetBackgroundColour;
    property TopMargin: Double read GetTopMargin write SetTopMargin;
    property ProductID: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property FunctionNo: Integer read GetFunctionNo write SetFunctionNo;
    property FunctionType: Integer read GetFunctionType write SetFunctionType;
    property FunctionName: string read GetFunctionName write SetFunctionName;
    property Hint: string read GetHint write SetHint;
    property RoomID: Integer read GetRoomID write SetRoomID;
    property Memo: string read GetMemo write SetMemo;
  end;

implementation

uses tcDataUtils, CommonLib, BusObjStock, BusObjSchemaLib, sysutils;

{ TPosKeypadCustomise }

constructor TPosKeypadCustomise.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PosKeypadCustomise';
  fSQL := 'SELECT * FROM tblposkeypadcustomize';
  ExportExcludeList.Add('productid');
end;

destructor TPosKeypadCustomise.Destroy;
begin
  inherited;
end;

procedure TPosKeypadCustomise.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'KeypadID');
  SetPropertyFromNode(node, 'KeyName');
  SetBooleanPropertyFromNode(node, 'QuickKey');
  SetPropertyFromNode(node, 'CaptionLine1');
  SetPropertyFromNode(node, 'CaptionLine2');
  SetPropertyFromNode(node, 'FontColour');
  SetPropertyFromNode(node, 'FontName');
  SetPropertyFromNode(node, 'FontSize');
  SetBooleanPropertyFromNode(node, 'FontBold');
  SetBooleanPropertyFromNode(node, 'FontItalic');
  SetBooleanPropertyFromNode(node, 'FontUnderline');
  SetPropertyFromNode(node, 'BackgroundColour');
  SetPropertyFromNode(node, 'TopMargin');
  SetPropertyFromNode(node, 'ProductID');
  SetPropertyFromNode(node, 'FunctionNo');
  SetPropertyFromNode(node, 'FunctionType');
  SetPropertyFromNode(node, 'FunctionName');
  SetPropertyFromNode(node, 'Hint');
  SetPropertyFromNode(node, 'RoomID');
  SetPropertyFromNode(node, 'Memo');
end;

procedure TPosKeypadCustomise.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'KeypadID', KeypadID);
  AddXMLNode(node, 'KeyName', KeyName);
  AddXMLNode(node, 'QuickKey', QuickKey);
  AddXMLNode(node, 'CaptionLine1', CaptionLine1);
  AddXMLNode(node, 'CaptionLine2', CaptionLine2);
  AddXMLNode(node, 'FontColour', FontColour);
  AddXMLNode(node, 'FontName', FontName);
  AddXMLNode(node, 'FontSize', FontSize);
  AddXMLNode(node, 'FontBold', FontBold);
  AddXMLNode(node, 'FontItalic', FontItalic);
  AddXMLNode(node, 'FontUnderline', FontUnderline);
  AddXMLNode(node, 'BackgroundColour', BackgroundColour);
  AddXMLNode(node, 'TopMargin', TopMargin);
  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'FunctionNo', FunctionNo);
  AddXMLNode(node, 'FunctionType', FunctionType);
  AddXMLNode(node, 'FunctionName', FunctionName);
  AddXMLNode(node, 'Hint', Hint);
  AddXMLNode(node, 'RoomID', RoomID);
  AddXMLNode(node, 'Memo', Memo);
end;

function TPosKeypadCustomise.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if KeyName = '' then begin
    AddResult(false,rssWarning,0,'Key Name is blank');
    exit;
  end;
  if KeyPadID = 0 then begin
    AddResult(false,rssWarning,0,'Key Pad ID is blank');
    exit;
  end;
  if ProductID < 0 then begin
    AddResult(false,rssWarning,0,'Product not found');
    exit;
  end;
  if Trim(FontName) = '' then begin
    AddResult(false,rssWarning,0,'Font Name is blank');
    exit;
  end;
  if FontSize < 1 then begin
    AddResult(false,rssWarning,0,'Font Size is invalid');
    exit;
  end;
  if (Trim(CaptionLine1) = '') and (Trim(CaptionLine2) = '') then begin
    AddResult(false,rssWarning,0,'Button caption is blank');
    exit;
  end;
  Result := True;
end;

class function TPosKeypadCustomise._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TPosKeypad','KeypadObj','KeypadID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductName','ProductName');
  TBOSchema.AddRefType(result,'TFuncRoom','FuncRoomObj','RoomID','ID');
end;

function TPosKeypadCustomise.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TPosKeypadCustomise.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPosKeypadCustomise.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPosKeypadCustomise.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPosKeypadCustomise.GetIDField: string;
begin
  Result := 'KeyID'
end;

class function TPosKeypadCustomise.GetBusObjectTablename: string;
begin
  Result := 'tblposkeypadcustomize';
end;

function TPosKeypadCustomise.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TPosKeypadCustomise.GetKeypadID: Integer;
begin
  Result := GetIntegerField('KeypadID');
end;

function TPosKeypadCustomise.GetKeyName: string;
begin
  Result := GetStringField('KeyName');
end;

function TPosKeypadCustomise.GetQuickKey: Boolean;
begin
  Result := GetBooleanField('QuickKey');
end;

function TPosKeypadCustomise.GetCaptionLine1: string;
begin
  Result := GetStringField('CaptionLine1');
end;

function TPosKeypadCustomise.GetCaptionLine2: string;
begin
  Result := GetStringField('CaptionLine2');
end;

function TPosKeypadCustomise.GetFontColour: Integer;
begin
  Result := GetIntegerField('FontColour');
end;

function TPosKeypadCustomise.GetFontName: string;
begin
  Result := GetStringField('FontName');
end;

function TPosKeypadCustomise.GetFontSize: Integer;
begin
  Result := GetIntegerField('FontSize');
end;

function TPosKeypadCustomise.GetFontBold: Boolean;
begin
  Result := GetBooleanField('FontBold');
end;

function TPosKeypadCustomise.GetFontItalic: Boolean;
begin
  Result := GetBooleanField('FontItalic');
end;

function TPosKeypadCustomise.GetFontUnderline: Boolean;
begin
  Result := GetBooleanField('FontUnderline');
end;

function TPosKeypadCustomise.GetBackgroundColour: Integer;
begin
  Result := GetIntegerField('BackgroundColour');
end;

function TPosKeypadCustomise.GetTopMargin: Double;
begin
  Result := GetFloatField('TopMargin');
end;

function TPosKeypadCustomise.GetProductID: Integer;
begin
  Result := GetIntegerField('PartID');
end;

function TPosKeypadCustomise.GetProductName: string;
begin
  if ProductId > 0 then
    result:= TProduct.IDToggle(ProductId, Connection.Connection)
  else
    result:= '';
end;

function TPosKeypadCustomise.GetFunctionNo: Integer;
begin
  Result := GetIntegerField('FunctionNo');
end;

function TPosKeypadCustomise.GetFunctionType: Integer;
begin
  Result := GetIntegerField('FunctionType');
end;

function TPosKeypadCustomise.GetFunctionName: string;
begin
  Result := GetStringField('FunctionName');
end;

function TPosKeypadCustomise.GetHint: string;
begin
  Result := GetStringField('Hint');
end;

function TPosKeypadCustomise.GetRoomID: Integer;
begin
  Result := GetIntegerField('RoomID');
end;

function TPosKeypadCustomise.GetMemo: string;
begin
  Result := GetStringField('Memo');
end;

procedure TPosKeypadCustomise.SetKeypadID(const Value: Integer);
begin
  SetIntegerField('KeypadID', Value);
end;

procedure TPosKeypadCustomise.SetKeyName(const Value: string);
begin
  SetStringField('KeyName', Value);
end;

procedure TPosKeypadCustomise.SetQuickKey(const Value: Boolean);
begin
  SetBooleanField('QuickKey', Value);
end;

procedure TPosKeypadCustomise.SetCaptionLine1(const Value: string);
begin
  SetStringField('CaptionLine1', Value);
end;

procedure TPosKeypadCustomise.SetCaptionLine2(const Value: string);
begin
  SetStringField('CaptionLine2', Value);
end;

procedure TPosKeypadCustomise.SetFontColour(const Value: Integer);
begin
  SetIntegerField('FontColour', Value);
end;

procedure TPosKeypadCustomise.SetFontName(const Value: string);
begin
  SetStringField('FontName', Value);
end;

procedure TPosKeypadCustomise.SetFontSize(const Value: Integer);
begin
  SetIntegerField('FontSize', Value);
end;

procedure TPosKeypadCustomise.SetFontBold(const Value: Boolean);
begin
  SetBooleanField('FontBold', Value);
end;

procedure TPosKeypadCustomise.SetFontItalic(const Value: Boolean);
begin
  SetBooleanField('FontItalic', Value);
end;

procedure TPosKeypadCustomise.SetFontUnderline(const Value: Boolean);
begin
  SetBooleanField('FontUnderline', Value);
end;

procedure TPosKeypadCustomise.SetBackgroundColour(const Value: Integer);
begin
  SetIntegerField('BackgroundColour', Value);
end;

procedure TPosKeypadCustomise.SetTopMargin(const Value: Double);
begin
  SetFloatField('TopMargin', Value);
end;

procedure TPosKeypadCustomise.SetProductID(const Value: Integer);
begin
  SetIntegerField('PartID', Value);
end;

procedure TPosKeypadCustomise.SetProductName(const Value: string);
begin
  if Value <> '' then begin
    ProductID:= TProduct.IDToggle(Value, Connection.Connection);
    if ProductId = 0 then
      ProductId:= -1;
  end
  else
    ProductID:= 0;
end;

procedure TPosKeypadCustomise.SetFunctionNo(const Value: Integer);
begin
  SetIntegerField('FunctionNo', Value);
end;

procedure TPosKeypadCustomise.SetFunctionType(const Value: Integer);
begin
  SetIntegerField('FunctionType', Value);
end;

procedure TPosKeypadCustomise.SetFunctionName(const Value: string);
begin
  SetStringField('FunctionName', Value);
end;

procedure TPosKeypadCustomise.SetHint(const Value: string);
begin
  SetStringField('Hint', Value);
end;

procedure TPosKeypadCustomise.SetRoomID(const Value: Integer);
begin
  SetIntegerField('RoomID', Value);
end;

procedure TPosKeypadCustomise.SetMemo(const Value: string);
begin
  SetStringField('Memo', Value);
end;

initialization

RegisterClass(TPosKeypadCustomise);

end.
