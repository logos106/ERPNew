unit PayTemplateSuperannuationLine;

{ Auto-generated: 20220624@165021.179 }
{ Special defines  }

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TPayTemplateSuperannuationLine = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetAmount: Double;
    function GetPercentage: Double;
    function GetPeriodPaymentDate: TDateTime;
    function GetPaymentFrequency: String;
    function GetExpenseAccount: string;
    function GetLiabilityAccount: string;
    function GetMinimumMonthlyEarnings: Double;
    function GetActive: Boolean;
    function GetCalculationType: Double;
    function GetReducesSGC: String;
    function GetContributionType: String;
    function GetFund: String;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetAmount(const Value: Double);
    procedure SetPercentage(const Value: Double);
    procedure SetPeriodPaymentDate(const Value: TDateTime);
    procedure SetPaymentFrequency(const Value: String);
    procedure SetExpenseAccount(const Value: string);
    procedure SetLiabilityAccount(const Value: string);
    procedure SetMinimumMonthlyEarnings(const Value: Double);
    procedure SetActive(const Value: Boolean);
    procedure SetCalculationType(const Value: Double);
    procedure SetReducesSGC(const Value: String);
    procedure SetContributionType(const Value: String);
    procedure SetFund(const Value: String);
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
    property Amount: Double read GetAmount write SetAmount;
    property Percentage: Double read GetPercentage write SetPercentage;
    property PeriodPaymentDate: TDateTime read GetPeriodPaymentDate write SetPeriodPaymentDate;
    property PaymentFrequency: String read GetPaymentFrequency write SetPaymentFrequency;
    property ExpenseAccount: string read GetExpenseAccount write SetExpenseAccount;
    property LiabilityAccount: string read GetLiabilityAccount write SetLiabilityAccount;
    property MinimumMonthlyEarnings: Double read GetMinimumMonthlyEarnings write SetMinimumMonthlyEarnings;
    property Active: Boolean read GetActive write SetActive;
    property CalculationType: Double read GetCalculationType write SetCalculationType;
    property ReducesSGC: String read GetReducesSGC write SetReducesSGC;
    property ContributionType: String read GetContributionType write SetContributionType;
    property Fund: String read GetFund write SetFund;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayTemplateSuperannuationLine }

constructor TPayTemplateSuperannuationLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'PayTemplateSuperannuationLine';
  FSQL:= 'SELECT * FROM tblPayTemplateSuperannuationLine';
end;

destructor TPayTemplateSuperannuationLine.Destroy;
begin
  inherited;
end;

procedure TPayTemplateSuperannuationLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineEmployeeID');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineAmount');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLinePercentage');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLinePeriodPaymentDate');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLinePaymentFrequency');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineExpenseAccount');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineLiabilityAccount');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineMinimumMonthlyEarnings');
  SetBooleanPropertyFromNode(node, 'PayTemplateSuperannuationLineActive');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineCalculationType');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineReducesSGC');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineContributionType');
  SetPropertyFromNode(node, 'PayTemplateSuperannuationLineFund');
end;

procedure TPayTemplateSuperannuationLine.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Amount', Amount);
  AddXMLNode(node, 'Percentage', Percentage);
  AddXMLNode(node, 'PeriodPaymentDate', PeriodPaymentDate);
  AddXMLNode(node, 'PaymentFrequency', PaymentFrequency);
  AddXMLNode(node, 'ExpenseAccount', ExpenseAccount);
  AddXMLNode(node, 'LiabilityAccount', LiabilityAccount);
  AddXMLNode(node, 'MinimumMonthlyEarnings', MinimumMonthlyEarnings);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'CalculationType', CalculationType);
  AddXMLNode(node, 'ReducesSGC', ReducesSGC);
  AddXMLNode(node, 'ContributionType', ContributionType);
  AddXMLNode(node, 'Fund', Fund);
end;

function TPayTemplateSuperannuationLine.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TPayTemplateSuperannuationLine.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TPayTemplateSuperannuationLine.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPayTemplateSuperannuationLine.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPayTemplateSuperannuationLine.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TPayTemplateSuperannuationLine.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TPayTemplateSuperannuationLine.GetBusObjectTablename: String;
begin
  Result:= 'tblPayTemplateSuperannuationLine';
end;

function TPayTemplateSuperannuationLine.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TPayTemplateSuperannuationLine.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TPayTemplateSuperannuationLine.GetAmount: Double;
begin
  Result := GetFloatField('Amount');
end;

function TPayTemplateSuperannuationLine.GetPercentage: Double;
begin
  Result := GetFloatField('Percentage');
end;

function TPayTemplateSuperannuationLine.GetPeriodPaymentDate: TDateTime;
begin
  Result := GetDateTimeField('PeriodPaymentDate');
end;

function TPayTemplateSuperannuationLine.GetPaymentFrequency: String;
begin
  Result := GetStringField('PaymentFrequency');
end;

function TPayTemplateSuperannuationLine.GetExpenseAccount: string;
begin
  Result := GetStringField('ExpenseAccount');
end;

function TPayTemplateSuperannuationLine.GetLiabilityAccount: string;
begin
  Result := GetStringField('ExpenseAccount');
end;

function TPayTemplateSuperannuationLine.GetMinimumMonthlyEarnings: Double;
begin
  Result := GetFloatField('MinimumMonthlyEarnings');
end;

function TPayTemplateSuperannuationLine.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPayTemplateSuperannuationLine.GetCalculationType: Double;
begin
  Result := GetFloatField('CalculationType');
end;

function TPayTemplateSuperannuationLine.GetReducesSGC: String;
begin
  Result := GetStringField('ReducesSGC');
end;

function TPayTemplateSuperannuationLine.GetContributionType: String;
begin
  Result := GetStringField('ContributionType');
end;

function TPayTemplateSuperannuationLine.GetFund: String;
begin
  Result := GetStringField('Fund');
end;

procedure TPayTemplateSuperannuationLine.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TPayTemplateSuperannuationLine.SetAmount(const Value: Double);
begin
  SetFloatField('Amount', Value);
end;

procedure TPayTemplateSuperannuationLine.SetPercentage(const Value: Double);
begin
  SetFloatField('Percentage', Value);
end;

procedure TPayTemplateSuperannuationLine.SetPeriodPaymentDate(const Value: TDateTime);
begin
  SetDateTimeField('PeriodPaymentDate', Value);
end;

procedure TPayTemplateSuperannuationLine.SetPaymentFrequency(const Value: String);
begin
  SetStringField('PaymentFrequency', Value);
end;

procedure TPayTemplateSuperannuationLine.SetExpenseAccount(const Value: string);
begin
  SetStringField('ExpenseAccount', Value);
end;

procedure TPayTemplateSuperannuationLine.SetLiabilityAccount(const Value: string);
begin
  SetStringField('LiabilityAccount', Value);
end;

procedure TPayTemplateSuperannuationLine.SetMinimumMonthlyEarnings(const Value: Double);
begin
  SetFloatField('MinimumMonthlyEarnings', Value);
end;

procedure TPayTemplateSuperannuationLine.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPayTemplateSuperannuationLine.SetCalculationType(const Value: Double);
begin
  SetFloatField('CalculationType', Value);
end;

procedure TPayTemplateSuperannuationLine.SetReducesSGC(const Value: String);
begin
  SetStringField('ReducesSGC', Value);
end;

procedure TPayTemplateSuperannuationLine.SetContributionType(const Value: String);
begin
  SetStringField('ContributionType', Value);
end;

procedure TPayTemplateSuperannuationLine.SetFund(const Value: String);
begin
  SetStringField('Fund', Value);
end;

initialization
  RegisterClass(TPayTemplateSuperannuationLine);

end.

CREATE TABLE tblPayTemplateSuperannuationLine(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  EmployeeID INTEGER,
  Amount DOUBLE,
  Percentage DOUBLE,
  PeriodPaymentDate DATETIME,
  PaymentFrequency VARCHAR(50),
  ExpenseAccount DOUBLE,
  MinimumMonthlyEarnings DOUBLE,
  Active ENUM('T', 'F'),
  CalculationType DOUBLE,
  ReducesSGC VARCHAR(50),
  ContributionType VARCHAR(50),
  Fund VARCHAR(50),
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
