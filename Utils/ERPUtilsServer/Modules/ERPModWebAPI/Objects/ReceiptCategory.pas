unit ReceiptCategory;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TReceiptCategory = class(TMSBusObj)

  private
    function GetCategoryName: string;
    function GetCategoryDesc: string;
    function GetAccountName: string;
    function GetAccountNo: string;
    function GetTaxRate: string;
    function GetActive: Boolean;

    procedure SetCategoryName(const Value: string);
    procedure SetCategoryDesc(const Value: string);
    procedure SetAccountName(const Value: string);
    procedure SetAccountNo(const Value: string);
    procedure SetTaxRate(const Value: string);
    procedure SetActive(const Value: Boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: String; override;
    function DoAfterPost(Sender:TDatasetBusObj): Boolean; override;

  public
    class function GetIDField: String; override;
    class function GetBusObjectTablename: String; override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;

  published
    property CategoryName: string         read GetCategoryName     write SetCategoryName;
    property CategoryDesc: string         read GetCategoryDesc     write SetCategoryDesc;
    property AccountName: string          read GetAccountName      write SetAccountName;
    property AccountNo: string            read GetAccountNo        write SetAccountNo;
    property TaxRate: string              read GetTaxRate          write SetTaxRate;
    property Active: Boolean              read GetActive           write SetActive;

  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayNotes }

constructor TReceiptCategory.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'ReceiptCategory';
  FSQL:= 'SELECT * FROM tblReceiptCategory';
end;

destructor TReceiptCategory.Destroy;
begin
  inherited;
end;

procedure TReceiptCategory.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'CateogryName');
  SetPropertyFromNode(node, 'CategoryDesc');
  SetPropertyFromNode(node, 'AccountName');
  SetPropertyFromNode(node, 'AccountNo');
  SetPropertyFromNode(node, 'TaxRate');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TReceiptCategory.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'CategoryName', CategoryName);
  AddXMLNode(node, 'CategoryDesc', CategoryDesc);
  AddXMLNode(node, 'AccountName', AccountName);
  AddXMLNode(node, 'AccpimtNo', AccountNo);
  AddXMLNode(node, 'TaxRate', TaxRate);
  AddXMLNode(node, 'Active', Active);
end;

function TReceiptCategory.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TReceiptCategory.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TReceiptCategory.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TReceiptCategory.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TReceiptCategory.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TReceiptCategory.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TReceiptCategory.GetBusObjectTablename: String;
begin
  Result:= 'tblReceiptCategory';
end;

function TReceiptCategory.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TReceiptCategory.GetCategoryName: string;                begin Result := GetStringField('CategoryName');end;
function TReceiptCategory.GetCategoryDesc: string;                begin Result := GetStringField('CategoryDesc');end;
function TReceiptCategory.GetAccountName: string;                 begin Result := GetStringField('AccountName');end;
function TReceiptCategory.GetAccountNo: string;                   begin Result := GetStringField('AccountNo');end;
function TReceiptCategory.GetTaxRate: string;                     begin Result := GetStringField('TaxRate');end;
function TReceiptCategory.GetActive: Boolean;                     begin Result := GetBooleanField('Active');end;

procedure TReceiptCategory.SetCategoryName(const Value: string);  begin SetStringField('CategoryName', Value);end;
procedure TReceiptCategory.SetCategoryDesc(const Value: string);  begin SetStringField('CategoryDesc', Value);end;
procedure TReceiptCategory.SetAccountName(const Value: string);   begin SetStringField('AccountName', Value);end;
procedure TReceiptCategory.SetAccountNo(const Value: string);     begin SetStringField('AccountNo', Value);end;
procedure TReceiptCategory.SetTaxRate(const Value: string);       begin SetStringField('TaxRate', Value); end;
procedure TReceiptCategory.SetActive(const Value: Boolean);       begin SetBooleanField('Active', Value);end;

initialization
  RegisterClass(TReceiptCategory);

end.


