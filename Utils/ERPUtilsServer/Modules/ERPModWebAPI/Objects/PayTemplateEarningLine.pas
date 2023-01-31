unit PayTemplateEarningLine;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TPayTemplateEarningLine = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetActive: Boolean;
    function GetEarningRate: String;
    function GetAmount: Double;
    function GetExpenseAccount: String;
    function GetCalculationType: String;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetEarningRate(const Value: String);
    procedure SetAmount(const Value: Double);
    procedure SetExpenseAccount(const Value: String);
    procedure SetCalculationType(const Value: String);
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
    property EarningRate: String read GetEarningRate write SetEarningRate;
    property Amount: Double read GetAmount write SetAmount;
    property ExpenseAccount: String read GetExpenseAccount write SetExpenseAccount;
    property CalculationType: String read GetCalculationType write SetCalculationType;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayTemplateEarningLine }

constructor TPayTemplateEarningLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'PayTemplateEarningLine';
  FSQL:= 'SELECT * FROM tblPayTemplateEarningLine';
end;

destructor TPayTemplateEarningLine.Destroy;
begin
  inherited;
end;

procedure TPayTemplateEarningLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'PayTemplateEarningLineEmployeeID');
  SetBooleanPropertyFromNode(node, 'PayTemplateEarningLineActive');
  SetPropertyFromNode(node, 'PayTemplateEarningLineEarningRate');
  SetPropertyFromNode(node, 'PayTemplateEarningLineAmount');
  SetPropertyFromNode(node, 'PayTemplateEarningLineExpenseAccount');
  SetPropertyFromNode(node, 'PayTemplateEarningLineCalculationType');
end;

procedure TPayTemplateEarningLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'EarningRate', EarningRate);
  AddXMLNode(node, 'Amount', Amount);
  AddXMLNode(node, 'ExpenseAccount', ExpenseAccount);
  AddXMLNode(node, 'CalculationType', CalculationType);
end;

function TPayTemplateEarningLine.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TPayTemplateEarningLine.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TPayTemplateEarningLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPayTemplateEarningLine.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPayTemplateEarningLine.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TPayTemplateEarningLine.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TPayTemplateEarningLine.GetBusObjectTablename: String;
begin
  Result:= 'tblPayTemplateEarningLine';
end;

function TPayTemplateEarningLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TPayTemplateEarningLine.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TPayTemplateEarningLine.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPayTemplateEarningLine.GetEarningRate: String;
begin
  Result := GetStringField('EarningRate');
end;

function TPayTemplateEarningLine.GetAmount: Double;
begin
  Result := GetFloatField('Amount');
end;

function TPayTemplateEarningLine.GetExpenseAccount: String;
begin
  Result := GetStringField('ExpenseAccount');
end;

function TPayTemplateEarningLine.GetCalculationType: String;
begin
  Result := GetStringField('CalculationType');
end;

procedure TPayTemplateEarningLine.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TPayTemplateEarningLine.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPayTemplateEarningLine.SetEarningRate(const Value: String);
begin
  SetStringField('EarningRate', Value);
end;

procedure TPayTemplateEarningLine.SetAmount(const Value: Double);
begin
  SetFloatField('Amount', Value);
end;

procedure TPayTemplateEarningLine.SetExpenseAccount(const Value: String);
begin
  SetStringField('ExpenseAccount', Value);
end;

procedure TPayTemplateEarningLine.SetCalculationType(const Value: String);
begin
  SetStringField('CalculationType', Value);
end;

initialization
  RegisterClass(TPayTemplateEarningLine);

end.

CREATE TABLE tblPayTemplateEarningLine(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  EmployeeID INTEGER,
  Active ENUM('T', 'F'),
  EarningRate VARCHAR(50),
  Amount DOUBLE,
  ExpenseAccount VARCHAR(50),
  CalculationType VARCHAR(50),
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
