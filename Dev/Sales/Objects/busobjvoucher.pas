unit busobjvoucher;

interface

uses BusObjBase,db, classes, XMLDoc, XMLIntf;

type

  TVoucher = class(TMSBusObj)
  private
    function GetVoucherno: string;
    function GetClientid: Integer;
    function GetClassID: Integer;
    function GetSaleid: Integer;
    function GetValue: Double;
    function GetDatecreated: TDatetime;
    function GetDateissued: TDatetime;
    function GetIsissued: Boolean;
    function GetDateredeemed: TDatetime;
    function GetIsredeemed: Boolean;
    function GetActive: Boolean;
    function GetRedeemedsaleid: Integer;
    function GetIssuedby: string;
    procedure SetVoucherno(const Value: string);
    procedure SetClientid(const Value: Integer);
    procedure setClassID(const Value: Integer);
    procedure SetSaleid(const Value: Integer);
    procedure SetValue(const Value: Double);
    procedure SetDatecreated(const Value: TDatetime);
    procedure SetDateissued(const Value: TDatetime);
    procedure SetIsissued(const Value: Boolean);
    procedure SetDateredeemed(const Value: TDatetime);
    procedure SetIsredeemed(const Value: Boolean);
    procedure SetActive(const Value: Boolean);
    procedure SetRedeemedsaleid(const Value: Integer);
    procedure SetIssuedby(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
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
    property VoucherNo: string read GetVoucherno write SetVoucherno;
    property ClientID: Integer read GetClientid write SetClientid;
    property ClassID: Integer read GetClassID write setClassID;
    property SaleID: Integer read GetSaleid write SetSaleid;
    property Value: Double read GetValue write SetValue;
    property DateCreated: TDatetime read GetDatecreated write SetDatecreated;
    property DateIssued: TDatetime read GetDateissued write SetDateissued;
    property IsIssued: Boolean read GetIsissued write SetIsissued;
    property DateRedeemed: TDatetime read GetDateredeemed write SetDateredeemed;
    property IsRedeemed: Boolean read GetIsredeemed write SetIsredeemed;
    property Active: Boolean read GetActive write SetActive;
    property RedeemedSaleId: Integer read GetRedeemedsaleid write SetRedeemedsaleid;
    property IssuedBy: string read GetIssuedby write SetIssuedby;
  end;


implementation

uses CommonLib, tcDataUtils, sysutils, BusObjSchemaLib, VoucherLib, ERPdbComponents  ,
  tcConst, BusObjConst, busobjPOS;


{ ========================================================
  TVouchers
  ======================================================== }
constructor TVoucher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblvouchers';
end;

destructor TVoucher.Destroy;
begin
  inherited;
end;

procedure TVoucher.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Voucherno');
  SetPropertyFromNode(node, 'Clientid');
  SetPropertyFromNode(node, 'Classid');
  SetPropertyFromNode(node, 'Saleid');
  SetPropertyFromNode(node, 'Value');
  SetDateTimePropertyFromNode(node, 'Datecreated');
  SetDateTimePropertyFromNode(node, 'Dateissued');
  SetBooleanPropertyFromNode(node, 'Isissued');
  SetDateTimePropertyFromNode(node, 'Dateredeemed');
  SetBooleanPropertyFromNode(node, 'Isredeemed');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'Redeemedsaleid');
  SetPropertyFromNode(node, 'Issuedby');
end;

procedure TVoucher.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Voucherno', Voucherno);
  AddXMLNode(node, 'Clientid', Clientid);
  AddXMLNode(node, 'Classid', Classid);
  AddXMLNode(node, 'Saleid', Saleid);
  AddXMLNode(node, 'Value', Value);
  AddXMLNode(node, 'Datecreated', Datecreated);
  AddXMLNode(node, 'Dateissued', Dateissued);
  AddXMLNode(node, 'Isissued', Isissued);
  AddXMLNode(node, 'Dateredeemed', Dateredeemed);
  AddXMLNode(node, 'Isredeemed', Isredeemed);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Redeemedsaleid', Redeemedsaleid);
  AddXMLNode(node, 'Issuedby', Issuedby);
end;

function TVoucher.ValidateData: Boolean;
begin
  ResultStatus.clear;
  Result := true;
end;

class function TVoucher._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCustomer','CustObj','ClientID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DeptClassObj','ClassID','ID');
  TBOSchema.AddRefType(result,'TCashSale','SaleObj','SaleID','ID');
  TBOSchema.AddRefType(result,'TCashSale','RedeemSaleObj','RedeemedSaleID','ID');
end;

function TVoucher.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TVoucher.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVoucher.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVoucher.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TVoucher.GetIDField: string;
begin
  Result := 'Voucherid'
end;

class function TVoucher.GetBusObjectTablename: string;
begin
  Result := 'tblvouchers';
end;

function TVoucher.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Self.Owner) then
    if Self.Owner is TPOS then Saleid := TPOS(Self.Owner).Saleid;
  Datecreated := Date;
end;

function TVoucher.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property functions }
function TVoucher.GetVoucherno: string;
begin
  Result := GetStringField('Voucherno');
end;

function TVoucher.GetClientid: Integer;
begin
  Result := GetIntegerField('Clientid');
end;

function TVoucher.GetClassID: Integer;
begin
  Result := GetIntegerField('Classid');
end;

function TVoucher.GetSaleid: Integer;
begin
  Result := GetIntegerField('Saleid');
end;

function TVoucher.GetValue: Double;
begin
  Result := GetFloatField('Value');
end;

function TVoucher.GetDatecreated: TDatetime;
begin
  Result := GetDatetimeField('Datecreated');
end;

function TVoucher.GetDateissued: TDatetime;
begin
  Result := GetDatetimeField('Dateissued');
end;

function TVoucher.GetIsissued: Boolean;
begin
  Result := GetBooleanField('Isissued');
end;

function TVoucher.GetDateredeemed: TDatetime;
begin
  Result := GetDatetimeField('Dateredeemed');
end;

function TVoucher.GetIsredeemed: Boolean;
begin
  Result := GetBooleanField('Isredeemed');
end;

function TVoucher.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TVoucher.GetRedeemedsaleid: Integer;
begin
  Result := GetIntegerField('Redeemedsaleid');
end;

function TVoucher.GetIssuedby: string;
begin
  Result := GetStringField('Issuedby');
end;

procedure TVoucher.SetVoucherno(const Value: string);
begin
  SetStringField('Voucherno', Value);
end;

procedure TVoucher.SetClientid(const Value: Integer);
begin
  SetIntegerField('Clientid', Value);
end;

procedure TVoucher.setClassID(const Value: Integer);
begin
  SetIntegerField('Classid', Value);
end;

procedure TVoucher.SetSaleid(const Value: Integer);
begin
  SetIntegerField('Saleid', Value);
end;

procedure TVoucher.SetValue(const Value: Double);
begin
  SetFloatField('Value', Value);
end;

procedure TVoucher.SetDatecreated(const Value: TDatetime);
begin
  SetDatetimeField('Datecreated', Value);
end;

procedure TVoucher.SetDateissued(const Value: TDatetime);
begin
  SetDatetimeField('Dateissued', Value);
end;

procedure TVoucher.SetIsissued(const Value: Boolean);
begin
  SetBooleanField('Isissued', Value);
end;

procedure TVoucher.SetDateredeemed(const Value: TDatetime);
begin
  SetDatetimeField('Dateredeemed', Value);
end;

procedure TVoucher.SetIsredeemed(const Value: Boolean);
begin
  SetBooleanField('Isredeemed', Value);
end;

procedure TVoucher.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TVoucher.SetRedeemedsaleid(const Value: Integer);
begin
  SetIntegerField('Redeemedsaleid', Value);
end;

procedure TVoucher.SetIssuedby(const Value: string);
begin
  SetStringField('Issuedby', Value);
end;


end.

