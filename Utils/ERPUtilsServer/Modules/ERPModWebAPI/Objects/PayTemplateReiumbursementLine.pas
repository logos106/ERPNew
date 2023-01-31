unit PayTemplateReiumbursementLine;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TPayTemplateReiumbursementLine = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetActive: Boolean;
    function GetAmount: Double;
    function GetExpenseAccount: String;
    function GetDescription: String;
    function GetReiumbursementType: String;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetAmount(const Value: Double);
    procedure SetExpenseAccount(const Value: String);
    procedure SetDescription(const Value: String);
    procedure SetReiumbursementType(const Value: String);
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
    property Amount: Double read GetAmount write SetAmount;
    property ExpenseAccount: String read GetExpenseAccount write SetExpenseAccount;
    property Description: String read GetDescription write SetDescription;
    property ReiumbursementType: String read GetReiumbursementType write SetReiumbursementType;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayTemplateReiumbursementLine }

constructor TPayTemplateReiumbursementLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'PayTemplateReiumbursementLine';
  FSQL:= 'SELECT * FROM tblPayTemplateReiumbursementLine';
end;

destructor TPayTemplateReiumbursementLine.Destroy;
begin
  inherited;
end;

procedure TPayTemplateReiumbursementLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'PayTemplateReiumbursementLineEmployeeID');
  SetBooleanPropertyFromNode(node, 'PayTemplateReiumbursementLineActive');
  SetPropertyFromNode(node, 'PayTemplateReiumbursementLineAmount');
  SetPropertyFromNode(node, 'PayTemplateReiumbursementLineExpenseAccount');
  SetPropertyFromNode(node, 'PayTemplateReiumbursementLineDescription');
  SetPropertyFromNode(node, 'PayTemplateReiumbursementLineReiumbursementType');
end;

procedure TPayTemplateReiumbursementLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Amount', Amount);
  AddXMLNode(node, 'ExpenseAccount', ExpenseAccount);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'ReiumbursementType', ReiumbursementType);
end;

function TPayTemplateReiumbursementLine.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TPayTemplateReiumbursementLine.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TPayTemplateReiumbursementLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPayTemplateReiumbursementLine.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPayTemplateReiumbursementLine.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TPayTemplateReiumbursementLine.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TPayTemplateReiumbursementLine.GetBusObjectTablename: String;
begin
  Result:= 'tblPayTemplateReiumbursementLine';
end;

function TPayTemplateReiumbursementLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TPayTemplateReiumbursementLine.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TPayTemplateReiumbursementLine.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPayTemplateReiumbursementLine.GetAmount: Double;
begin
  Result := GetFloatField('Amount');
end;

function TPayTemplateReiumbursementLine.GetExpenseAccount: String;
begin
  Result := GetStringField('ExpenseAccount');
end;

function TPayTemplateReiumbursementLine.GetDescription: String;
begin
  Result := GetStringField('Description');
end;

function TPayTemplateReiumbursementLine.GetReiumbursementType: String;
begin
  Result := GetStringField('ReiumbursementType');
end;

procedure TPayTemplateReiumbursementLine.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TPayTemplateReiumbursementLine.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPayTemplateReiumbursementLine.SetAmount(const Value: Double);
begin
  SetFloatField('Amount', Value);
end;

procedure TPayTemplateReiumbursementLine.SetExpenseAccount(const Value: String);
begin
  SetStringField('ExpenseAccount', Value);
end;

procedure TPayTemplateReiumbursementLine.SetDescription(const Value: String);
begin
  SetStringField('Description', Value);
end;

procedure TPayTemplateReiumbursementLine.SetReiumbursementType(const Value: String);
begin
  SetStringField('ReiumbursementType', Value);
end;

initialization
  RegisterClass(TPayTemplateReiumbursementLine);

end.

CREATE TABLE tblPayTemplateReiumbursementLine(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  EmployeeID INTEGER,
  Active ENUM('T', 'F'),
  Amount DOUBLE,
  ExpenseAccount VARCHAR(50),
  Description VARCHAR(255),
  ReiumbursementType VARCHAR(50),
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
