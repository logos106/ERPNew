unit Earnings;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TEarnings = class(TMSBusObj)
  private
    function GetEarningsName: String;
    function GetActive: Boolean;
    function GetEarningType: String;
    function GetEarningsReportableW1onActivityStatement: Boolean;
    function GetEarningsExemptSuperannuationGuaranteeCont: Boolean;
    function GetEarningsExemptPaygWithholding: Boolean;
    function GetExpenseAccount: String;
    function GetEarningsRateType: String;
    function GetEarningsDisplayName: String;

    procedure SetEarningsName(const Value: String);
    procedure SetActive(const Value: Boolean);
    procedure SetEarningType(const Value: String);
    procedure SetEarningsReportableW1onActivityStatement(const Value: Boolean);
    procedure SetEarningsExemptSuperannuationGuaranteeCont(const Value: Boolean);
    procedure SetEarningsExemptPaygWithholding(const Value: Boolean);
    procedure SetExpenseAccount(const Value: String);
    procedure SetEarningsRateType(const Value: String);
    procedure SetEarningsDisplayName(const Value: String);
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
    property EarningsName: String read GetEarningsName write SetEarningsName;
    property Active: Boolean read GetActive write SetActive;
    property EarningType: String read GetEarningType write SetEarningType;
    property EarningsReportableW1onActivityStatement: Boolean read GetEarningsReportableW1onActivityStatement write SetEarningsReportableW1onActivityStatement;
    property EarningsExemptSuperannuationGuaranteeCont: Boolean read GetEarningsExemptSuperannuationGuaranteeCont write SetEarningsExemptSuperannuationGuaranteeCont;
    property EarningsExemptPaygWithholding: Boolean read GetEarningsExemptPaygWithholding write SetEarningsExemptPaygWithholding;
    property ExpenseAccount: String read GetExpenseAccount write SetExpenseAccount;
    property EarningsRateType: String read GetEarningsRateType write SetEarningsRateType;
    property EarningsDisplayName: String read GetEarningsDisplayName write SetEarningsDisplayName;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TEarnings }

constructor TEarnings.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'Earnings';
  FSQL:= 'SELECT * FROM tblEarnings';
end;

destructor TEarnings.Destroy;
begin
  inherited;
end;

procedure TEarnings.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'EarningsEarningsName');
  SetBooleanPropertyFromNode(node, 'EarningsActive');
  SetPropertyFromNode(node, 'EarningsEarningType');
  SetBooleanPropertyFromNode(node, 'EarningsEarningsReportableW1onActivityStatement');
  SetBooleanPropertyFromNode(node, 'EarningsEarningsExemptSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node, 'EarningsEarningsExemptPaygWithholding');
  SetPropertyFromNode(node, 'EarningsExpenseAccount');
  SetPropertyFromNode(node, 'EarningsEarningsRateType');
  SetPropertyFromNode(node, 'EarningsEarningsDisplayName');
end;

procedure TEarnings.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EarningsName', EarningsName);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'EarningType', EarningType);
  AddXMLNode(node, 'EarningsReportableW1onActivityStatement', EarningsReportableW1onActivityStatement);
  AddXMLNode(node, 'EarningsExemptSuperannuationGuaranteeCont', EarningsExemptSuperannuationGuaranteeCont);
  AddXMLNode(node, 'EarningsExemptPaygWithholding', EarningsExemptPaygWithholding);
  AddXMLNode(node, 'ExpenseAccount', ExpenseAccount);
  AddXMLNode(node, 'EarningsRateType', EarningsRateType);
  AddXMLNode(node, 'EarningsDisplayName', EarningsDisplayName);
end;

function TEarnings.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TEarnings.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TEarnings.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TEarnings.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TEarnings.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TEarnings.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TEarnings.GetBusObjectTablename: String;
begin
  Result:= 'tblEarnings';
end;

function TEarnings.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TEarnings.GetEarningsName: String;
begin
  Result := GetStringField('EarningsName');
end;

function TEarnings.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TEarnings.GetEarningType: String;
begin
  Result := GetStringField('EarningType');
end;

function TEarnings.GetEarningsReportableW1onActivityStatement: Boolean;
begin
  Result := GetBooleanField('EarningsReportableW1onActivityStatement');
end;

function TEarnings.GetEarningsExemptSuperannuationGuaranteeCont: Boolean;
begin
  Result := GetBooleanField('EarningsExemptSuperannuationGuaranteeCont');
end;

function TEarnings.GetEarningsExemptPaygWithholding: Boolean;
begin
  Result := GetBooleanField('EarningsExemptPaygWithholding');
end;

function TEarnings.GetExpenseAccount: String;
begin
  Result := GetStringField('ExpenseAccount');
end;

function TEarnings.GetEarningsRateType: String;
begin
  Result := GetStringField('EarningsRateType');
end;

function TEarnings.GetEarningsDisplayName: String;
begin
  Result := GetStringField('EarningsDisplayName');
end;

procedure TEarnings.SetEarningsName(const Value: String);
begin
  SetStringField('EarningsName', Value);
end;

procedure TEarnings.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TEarnings.SetEarningType(const Value: String);
begin
  SetStringField('EarningType', Value);
end;

procedure TEarnings.SetEarningsReportableW1onActivityStatement(const Value: Boolean);
begin
  SetBooleanField('EarningsReportableW1onActivityStatement', Value);
end;

procedure TEarnings.SetEarningsExemptSuperannuationGuaranteeCont(const Value: Boolean);
begin
  SetBooleanField('EarningsExemptSuperannuationGuaranteeCont', Value);
end;

procedure TEarnings.SetEarningsExemptPaygWithholding(const Value: Boolean);
begin
  SetBooleanField('EarningsExemptPaygWithholding', Value);
end;

procedure TEarnings.SetExpenseAccount(const Value: String);
begin
  SetStringField('ExpenseAccount', Value);
end;

procedure TEarnings.SetEarningsRateType(const Value: String);
begin
  SetStringField('EarningsRateType', Value);
end;

procedure TEarnings.SetEarningsDisplayName(const Value: String);
begin
  SetStringField('EarningsDisplayName', Value);
end;

initialization
  RegisterClass(TEarnings);

end.

CREATE TABLE tblEarnings(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  EarningsName VARCHAR(255),
  Active ENUM('T', 'F'),
  EarningType VARCHAR(50),
  EarningsReportableW1onActivityStatement ENUM('T', 'F'),
  EarningsExemptSuperannuationGuaranteeCont ENUM('T', 'F'),
  EarningsExemptPaygWithholding ENUM('T', 'F'),
  ExpenseAccount VARCHAR(255),
  EarningsRateType VARCHAR(50),
  EarningsDisplayName VARCHAR(255),
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
