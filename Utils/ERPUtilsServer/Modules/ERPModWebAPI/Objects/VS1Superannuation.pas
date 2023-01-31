unit VS1Superannuation;

{ VS1 Object }

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TVS1Superannuation = class(TMSBusObj)
  private
    function GetSuperID: Integer;
    function GetEmployeeId: Integer;
    function GetTaxRate: Double;
    function GetTaxExempt: Boolean;
    function GetSuperTypeId: Integer;
    function GetSuperfund: String;
    function GetElectronicsServiceAddressAlias: String;
    function GetDepartmentName: String;
    function GetDateJoined: TDateTime;
    function GetClientId: Integer;
    function GetClassId: Integer;
    function GetCalcBy: String;
    function GetBSB: String;
    function GetArea: String;
    function GetAmountToPaid: Double;
    function GetAmount: Double;
    function GetAllClasses: Boolean;
    function GetAccountNumber: String;
    function GetAccountNo: String;
    function GetAccountName: String;
    function GetABN: String;

    procedure SetSuperID(const Value: Integer);
    procedure SetEmployeeId(const Value: Integer);
    procedure SetTaxRate(const Value: Double);
    procedure SetTaxExempt(const Value: Boolean);
    procedure SetSuperTypeId(const Value: Integer);
    procedure SetSuperfund(const Value: String);
    procedure SetElectronicsServiceAddressAlias(const Value: String);
    procedure SetDepartmentName(const Value: String);
    procedure SetDateJoined(const Value: TDateTime);
    procedure SetClientId(const Value: Integer);
    procedure SetClassId(const Value: Integer);
    procedure SetCalcBy(const Value: String);
    procedure SetBSB(const Value: String);
    procedure SetArea(const Value: String);
    procedure SetAmountToPaid(const Value: Double);
    procedure SetAmount(const Value: Double);
    procedure SetAllClasses(const Value: Boolean);
    procedure SetAccountNumber(const Value: String);
    procedure SetAccountNo(const Value: String);
    procedure SetAccountName(const Value: String);
    procedure SetABN(const Value: String);
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
    property SuperID: Integer read GetSuperID write SetSuperID;
    property EmployeeId: Integer read GetEmployeeId write SetEmployeeId;
    property TaxRate: Double read GetTaxRate write SetTaxRate;
    property TaxExempt: Boolean read GetTaxExempt write SetTaxExempt;
    property SuperTypeId: Integer read GetSuperTypeId write SetSuperTypeId;
    property Superfund: String read GetSuperfund write SetSuperfund;
    property ElectronicsServiceAddressAlias: String read GetElectronicsServiceAddressAlias write SetElectronicsServiceAddressAlias;
    property DepartmentName: String read GetDepartmentName write SetDepartmentName;
    property DateJoined: TDateTime read GetDateJoined write SetDateJoined;
    property ClientId: Integer read GetClientId write SetClientId;
    property ClassId: Integer read GetClassId write SetClassId;
    property CalcBy: String read GetCalcBy write SetCalcBy;
    property BSB: String read GetBSB write SetBSB;
    property Area: String read GetArea write SetArea;
    property AmountToPaid: Double read GetAmountToPaid write SetAmountToPaid;
    property Amount: Double read GetAmount write SetAmount;
    property AllClasses: Boolean read GetAllClasses write SetAllClasses;
    property AccountNumber: String read GetAccountNumber write SetAccountNumber;
    property AccountNo: String read GetAccountNo write SetAccountNo;
    property AccountName: String read GetAccountName write SetAccountName;
    property ABN: String read GetABN write SetABN;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TVS1Superannuation }

constructor TVS1Superannuation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription := 'VS1Superannuation';
  FSQL := 'SELECT * FROM tblVS1Superannuation';
end;

destructor TVS1Superannuation.Destroy;
begin
  inherited;
end;

procedure TVS1Superannuation.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'VS1SuperannuationSuperID');
  SetPropertyFromNode(node, 'VS1SuperannuationEmployeeId');
  SetPropertyFromNode(node, 'VS1SuperannuationTaxRate');
  SetBooleanPropertyFromNode(node, 'VS1SuperannuationTaxExempt');
  SetPropertyFromNode(node, 'VS1SuperannuationSuperTypeId');
  SetPropertyFromNode(node, 'VS1SuperannuationSuperfund');
  SetPropertyFromNode(node, 'VS1SuperannuationElectronicsServiceAddressAlias');
  SetPropertyFromNode(node, 'VS1SuperannuationDepartmentName');
  SetDateTimePropertyFromNode(node, 'VS1SuperannuationDateJoined');
  SetPropertyFromNode(node, 'VS1SuperannuationClientId');
  SetPropertyFromNode(node, 'VS1SuperannuationClassId');
  SetPropertyFromNode(node, 'VS1SuperannuationCalcBy');
  SetPropertyFromNode(node, 'VS1SuperannuationBSB');
  SetPropertyFromNode(node, 'VS1SuperannuationArea');
  SetPropertyFromNode(node, 'VS1SuperannuationAmountToPaid');
  SetPropertyFromNode(node, 'VS1SuperannuationAmount');
  SetBooleanPropertyFromNode(node, 'VS1SuperannuationAllClasses');
  SetPropertyFromNode(node, 'VS1SuperannuationAccountNumber');
  SetPropertyFromNode(node, 'VS1SuperannuationAccountNo');
  SetPropertyFromNode(node, 'VS1SuperannuationAccountName');
  SetPropertyFromNode(node, 'VS1SuperannuationABN');
end;

procedure TVS1Superannuation.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'SuperID', SuperID);
  AddXMLNode(node, 'EmployeeId', EmployeeId);
  AddXMLNode(node, 'TaxRate', TaxRate);
  AddXMLNode(node, 'TaxExempt', TaxExempt);
  AddXMLNode(node, 'SuperTypeId', SuperTypeId);
  AddXMLNode(node, 'Superfund', Superfund);
  AddXMLNode(node, 'ElectronicsServiceAddressAlias', ElectronicsServiceAddressAlias);
  AddXMLNode(node, 'DepartmentName', DepartmentName);
  AddXMLNode(node, 'DateJoined', DateJoined);
  AddXMLNode(node, 'ClientId', ClientId);
  AddXMLNode(node, 'ClassId', ClassId);
  AddXMLNode(node, 'CalcBy', CalcBy);
  AddXMLNode(node, 'BSB', BSB);
  AddXMLNode(node, 'Area', Area);
  AddXMLNode(node, 'AmountToPaid', AmountToPaid);
  AddXMLNode(node, 'Amount', Amount);
  AddXMLNode(node, 'AllClasses', AllClasses);
  AddXMLNode(node, 'AccountNumber', AccountNumber);
  AddXMLNode(node, 'AccountNo', AccountNo);
  AddXMLNode(node, 'AccountName', AccountName);
  AddXMLNode(node, 'ABN', ABN);
end;

function TVS1Superannuation.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TVS1Superannuation.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TVS1Superannuation.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVS1Superannuation.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVS1Superannuation.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TVS1Superannuation.GetIDField: String;
begin
  Result:= 'SuperID'
end;

class function TVS1Superannuation.GetBusObjectTablename: String;
begin
  Result:= 'tblVS1Superannuation';
end;

function TVS1Superannuation.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TVS1Superannuation.GetSuperID: Integer;
begin
  Result := GetIntegerField('SuperID');
end;

function TVS1Superannuation.GetEmployeeId: Integer;
begin
  Result := GetIntegerField('EmployeeId');
end;

function TVS1Superannuation.GetTaxRate: Double;
begin
  Result := GetFloatField('TaxRate');
end;

function TVS1Superannuation.GetTaxExempt: Boolean;
begin
  Result := GetBooleanField('TaxExempt');
end;

function TVS1Superannuation.GetSuperTypeId: Integer;
begin
  Result := GetIntegerField('SuperTypeId');
end;

function TVS1Superannuation.GetSuperfund: String;
begin
  Result := GetStringField('Superfund');
end;

function TVS1Superannuation.GetElectronicsServiceAddressAlias: String;
begin
  Result := GetStringField('ElectronicsServiceAddressAlias');
end;

function TVS1Superannuation.GetDepartmentName: String;
begin
  Result := GetStringField('DepartmentName');
end;

function TVS1Superannuation.GetDateJoined: TDateTime;
begin
  Result := GetDateTimeField('DateJoined');
end;

function TVS1Superannuation.GetClientId: Integer;
begin
  Result := GetIntegerField('ClientId');
end;

function TVS1Superannuation.GetClassId: Integer;
begin
  Result := GetIntegerField('ClassId');
end;

function TVS1Superannuation.GetCalcBy: String;
begin
  Result := GetStringField('CalcBy');
end;

function TVS1Superannuation.GetBSB: String;
begin
  Result := GetStringField('BSB');
end;

function TVS1Superannuation.GetArea: String;
begin
  Result := GetStringField('Area');
end;

function TVS1Superannuation.GetAmountToPaid: Double;
begin
  Result := GetFloatField('AmountToPaid');
end;

function TVS1Superannuation.GetAmount: Double;
begin
  Result := GetFloatField('Amount');
end;

function TVS1Superannuation.GetAllClasses: Boolean;
begin
  Result := GetBooleanField('AllClasses');
end;

function TVS1Superannuation.GetAccountNumber: String;
begin
  Result := GetStringField('AccountNumber');
end;

function TVS1Superannuation.GetAccountNo: String;
begin
  Result := GetStringField('AccountNo');
end;

function TVS1Superannuation.GetAccountName: String;
begin
  Result := GetStringField('AccountName');
end;

function TVS1Superannuation.GetABN: String;
begin
  Result := GetStringField('ABN');
end;

procedure TVS1Superannuation.SetSuperID(const Value: Integer);
begin
  SetIntegerField('SuperID', Value);
end;

procedure TVS1Superannuation.SetEmployeeId(const Value: Integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

procedure TVS1Superannuation.SetTaxRate(const Value: Double);
begin
  SetFloatField('TaxRate', Value);
end;

procedure TVS1Superannuation.SetTaxExempt(const Value: Boolean);
begin
  SetBooleanField('TaxExempt', Value);
end;

procedure TVS1Superannuation.SetSuperTypeId(const Value: Integer);
begin
  SetIntegerField('SuperTypeId', Value);
end;

procedure TVS1Superannuation.SetSuperfund(const Value: String);
begin
  SetStringField('Superfund', Value);
end;

procedure TVS1Superannuation.SetElectronicsServiceAddressAlias(const Value: String);
begin
  SetStringField('ElectronicsServiceAddressAlias', Value);
end;

procedure TVS1Superannuation.SetDepartmentName(const Value: String);
begin
  SetStringField('DepartmentName', Value);
end;

procedure TVS1Superannuation.SetDateJoined(const Value: TDateTime);
begin
  SetDateTimeField('DateJoined', Value);
end;

procedure TVS1Superannuation.SetClientId(const Value: Integer);
begin
  SetIntegerField('ClientId', Value);
end;

procedure TVS1Superannuation.SetClassId(const Value: Integer);
begin
  SetIntegerField('ClassId', Value);
end;

procedure TVS1Superannuation.SetCalcBy(const Value: String);
begin
  SetStringField('CalcBy', Value);
end;

procedure TVS1Superannuation.SetBSB(const Value: String);
begin
  SetStringField('BSB', Value);
end;

procedure TVS1Superannuation.SetArea(const Value: String);
begin
  SetStringField('Area', Value);
end;

procedure TVS1Superannuation.SetAmountToPaid(const Value: Double);
begin
  SetFloatField('AmountToPaid', Value);
end;

procedure TVS1Superannuation.SetAmount(const Value: Double);
begin
  SetFloatField('Amount', Value);
end;

procedure TVS1Superannuation.SetAllClasses(const Value: Boolean);
begin
  SetBooleanField('AllClasses', Value);
end;

procedure TVS1Superannuation.SetAccountNumber(const Value: String);
begin
  SetStringField('AccountNumber', Value);
end;

procedure TVS1Superannuation.SetAccountNo(const Value: String);
begin
  SetStringField('AccountNo', Value);
end;

procedure TVS1Superannuation.SetAccountName(const Value: String);
begin
  SetStringField('AccountName', Value);
end;

procedure TVS1Superannuation.SetABN(const Value: String);
begin
  SetStringField('ABN', Value);
end;

initialization
  RegisterClass(TVS1Superannuation);

end.
