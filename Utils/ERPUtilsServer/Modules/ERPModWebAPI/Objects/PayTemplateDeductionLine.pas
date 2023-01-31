unit PayTemplateDeductionLine;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TPayTemplateDeductionLine = class(TMSBusObj)
  private
    function GetDeductionType: String;
    function GetActive: Boolean;
    function GetAmount: Double;
    function GetExpenseAccount: String;
    function GetCalculationType: String;
    function GetEmployeeID: Integer;
    function GetPercentage: string;

    procedure SetDeductionType(const Value: String);
    procedure SetActive(const Value: Boolean);
    procedure SetAmount(const Value: Double);
    procedure SetExpenseAccount(const Value: String);
    procedure SetCalculationType(const Value: String);
    procedure SetEmployeeID(const Value: Integer);
    procedure SetPercentage(const Value: string);

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
    property DeductionType: String read GetDeductionType write SetDeductionType;
    property Active: Boolean read GetActive write SetActive;
    property Amount: Double read GetAmount write SetAmount;
    property ExpenseAccount: String read GetExpenseAccount write SetExpenseAccount;
    property CalculationType: String read GetCalculationType write SetCalculationType;
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property Percentage: string read GetPercentage write SetPercentage;

  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayTemplateDeductionLine }

constructor TPayTemplateDeductionLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'PayTemplateDeductionLine';
  FSQL:= 'SELECT * FROM tblPayTemplateDeductionLine';
end;

destructor TPayTemplateDeductionLine.Destroy;
begin
  inherited;
end;

procedure TPayTemplateDeductionLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'PayTemplateDeductionLineID');
  SetPropertyFromNode(node, 'PayTemplateDeductionLineDeductionType');
  SetBooleanPropertyFromNode(node, 'PayTemplateDeductionLineActive');
  SetPropertyFromNode(node, 'PayTemplateDeductionLineAmount');
  SetPropertyFromNode(node, 'PayTemplateDeductionLineExpenseAccount');
  SetPropertyFromNode(node, 'PayTemplateDeductionLineCalculationType');
  SetPropertyFromNode(node, 'PayTemplateDeductionLineEmployeeID');
  SetPropertyFromNode(node, 'PayTemplateDeductionLinePercentage');
end;

procedure TPayTemplateDeductionLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'DeductionType', DeductionType);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Amount', Amount);
  AddXMLNode(node, 'ExpenseAccount', ExpenseAccount);
  AddXMLNode(node, 'CalculationType', CalculationType);
  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Percentage', Percentage);
end;

function TPayTemplateDeductionLine.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TPayTemplateDeductionLine.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TPayTemplateDeductionLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPayTemplateDeductionLine.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPayTemplateDeductionLine.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TPayTemplateDeductionLine.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TPayTemplateDeductionLine.GetBusObjectTablename: String;
begin
  Result:= 'tblPayTemplateDeductionLine';
end;

function TPayTemplateDeductionLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TPayTemplateDeductionLine.GetDeductionType: String;
begin
  Result := GetStringField('DeductionType');
end;

function TPayTemplateDeductionLine.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPayTemplateDeductionLine.GetAmount: Double;
begin
  Result := GetFloatField('Amount');
end;

function TPayTemplateDeductionLine.GetExpenseAccount: String;
begin
  Result := GetStringField('ExpenseAccount');
end;

function TPayTemplateDeductionLine.GetCalculationType: String;
begin
  Result := GetStringField('CalculationType');
end;

function TPayTemplateDeductionLine.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TPayTemplateDeductionLine.GetPercentage: string;
begin
  Result := GetStringField('Percentage');
end;

procedure TPayTemplateDeductionLine.SetDeductionType(const Value: String);
begin
  SetStringField('DeductionType', Value);
end;

procedure TPayTemplateDeductionLine.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPayTemplateDeductionLine.SetAmount(const Value: Double);
begin
  SetFloatField('Amount', Value);
end;

procedure TPayTemplateDeductionLine.SetExpenseAccount(const Value: String);
begin
  SetStringField('ExpenseAccount', Value);
end;

procedure TPayTemplateDeductionLine.SetCalculationType(const Value: String);
begin
  SetStringField('CalculationType', Value);
end;

procedure TPayTemplateDeductionLine.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TPayTemplateDeductionLine.SetPercentage(const Value: string);
begin
  SetStringField('Percentage', Value);
end;

initialization
  RegisterClass(TPayTemplateDeductionLine);

end.

CREATE TABLE tblPayTemplateDeductionLine(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  DeductionType VARCHAR(50),
  Active ENUM('T', 'F'),
  Amount DOUBLE,
  ExpenseAccount VARCHAR(50),
  CalculationType VARCHAR(50),
  EmployeeID INTEGER,
  Percentage VARCHAR(50),
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
