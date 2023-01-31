unit OpeningBalances;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TOpeningBalances = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetActive: Boolean;
    function GetAmount: Double;
    function GetContributionType: String;
    function GetBalance: Double;
    function GetType: String;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetAmount(const Value: Double);
    procedure SetContributionType(const Value: String);
    procedure SetBalance(const Value: Double);
    procedure SetType(const Value: String);
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
    property ContributionType: String read GetContributionType write SetContributionType;
    property Balance: Double read GetBalance write SetBalance;
    property AType: String read GetType write SetType;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TOpeningBalances }

constructor TOpeningBalances.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'OpeningBalances';
  FSQL:= 'SELECT * FROM tblOpeningBalances';
end;

destructor TOpeningBalances.Destroy;
begin
  inherited;
end;

procedure TOpeningBalances.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'OpeningBalancesEmployeeID');
  SetBooleanPropertyFromNode(node, 'OpeningBalancesActive');
  SetPropertyFromNode(node, 'OpeningBalancesAmount');
  SetPropertyFromNode(node, 'OpeningBalancesContributionType');
  SetPropertyFromNode(node, 'OpeningBalancesBalance');
  SetPropertyFromNode(node, 'OpeningBalancesType');
end;

procedure TOpeningBalances.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Amount', Amount);
  AddXMLNode(node, 'ContributionType', ContributionType);
  AddXMLNode(node, 'Balance', Balance);
  AddXMLNode(node, 'Type', AType);
end;

function TOpeningBalances.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TOpeningBalances.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TOpeningBalances.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TOpeningBalances.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TOpeningBalances.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TOpeningBalances.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TOpeningBalances.GetBusObjectTablename: String;
begin
  Result:= 'tblOpeningBalances';
end;

function TOpeningBalances.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TOpeningBalances.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TOpeningBalances.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TOpeningBalances.GetAmount: Double;
begin
  Result := GetFloatField('Amount');
end;

function TOpeningBalances.GetContributionType: String;
begin
  Result := GetStringField('ContributionType');
end;

function TOpeningBalances.GetBalance: Double;
begin
  Result := GetFloatField('Balance');
end;

function TOpeningBalances.GetType: String;
begin
  Result := GetStringField('Type');
end;

procedure TOpeningBalances.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TOpeningBalances.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TOpeningBalances.SetAmount(const Value: Double);
begin
  SetFloatField('Amount', Value);
end;

procedure TOpeningBalances.SetContributionType(const Value: String);
begin
  SetStringField('ContributionType', Value);
end;

procedure TOpeningBalances.SetBalance(const Value: Double);
begin
  SetFloatField('Balance', Value);
end;

procedure TOpeningBalances.SetType(const Value: String);
begin
  SetStringField('Type', Value);
end;

initialization
  RegisterClass(TOpeningBalances);

end.

CREATE TABLE tblOpeningBalances(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  EmployeeID INTEGER,
  Active ENUM('T', 'F'),
  Amount DOUBLE,
  ContributionType VARCHAR(50),
  Balance DOUBLE,
  Type VARCHAR(50),
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
