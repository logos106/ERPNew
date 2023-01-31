unit PaySlips;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TPaySlips = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetActive: Boolean;
    function GetTotalPay: Double;
    function GetPeriod: String;
    function GetPaymentDate: TDateTime;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetTotalPay(const Value: Double);
    procedure SetPeriod(const Value: String);
    procedure SetPaymentDate(const Value: TDateTime);
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
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property Active: Boolean read GetActive write SetActive;
    property TotalPay: Double read GetTotalPay write SetTotalPay;
    property Period: String read GetPeriod write SetPeriod;
    property PaymentDate: TDateTime read GetPaymentDate write SetPaymentDate;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPaySlips }

constructor TPaySlips.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'PaySlips';
  FSQL:= 'SELECT * FROM tblPaySlips';
end;

destructor TPaySlips.Destroy;
begin
  inherited;
end;

procedure TPaySlips.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'EmployeeID');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'TotalPay');
  SetPropertyFromNode(node, 'Period');
  SetDateTimePropertyFromNode(node, 'PaymentDate');
end;

procedure TPaySlips.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'TotalPay', TotalPay);
  AddXMLNode(node, 'Period', Period);
  AddXMLNode(node, 'PaymentDate', PaymentDate);
end;

function TPaySlips.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TPaySlips.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TPaySlips.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPaySlips.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPaySlips.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TPaySlips.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TPaySlips.GetBusObjectTablename: String;
begin
  Result:= 'tblPaySlips';
end;

function TPaySlips.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TPaySlips.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TPaySlips.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPaySlips.GetTotalPay: Double;
begin
  Result := GetFloatField('TotalPay');
end;

function TPaySlips.GetPeriod: String;
begin
  Result := GetStringField('Period');
end;

function TPaySlips.GetPaymentDate: TDateTime;
begin
  Result := GetDateTimeField('PaymentDate');
end;

procedure TPaySlips.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TPaySlips.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPaySlips.SetTotalPay(const Value: Double);
begin
  SetFloatField('TotalPay', Value);
end;

procedure TPaySlips.SetPeriod(const Value: String);
begin
  SetStringField('Period', Value);
end;

procedure TPaySlips.SetPaymentDate(const Value: TDateTime);
begin
  SetDateTimeField('PaymentDate', Value);
end;

initialization
  RegisterClass(TPaySlips);

end.


