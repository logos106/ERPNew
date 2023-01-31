unit AssignLeaveType;

{ Auto-generated: 20220624@155407.292 }
{ Special defines  }

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TAssignLeaveType = class(TMSBusObj)
  private
    function GetLeaveType: String;
    function GetActive: Boolean;
    function GetSuperannuationGuarantee: Boolean;
    function GetEFTLeaveType: Boolean;
    function GetOnTerminationUnusedBalance: Double;
    function GetOpeningBalance: Double;
    function GetHoursLeave: Double;
    function GetHoursFullTimeEmpFortnightlyPay: Double;
    function GetHoursAccruedAnnuallyFullTimeEmp: Double;
    function GetHoursAccruedAnnually: Double;
    function GetLeaveCalcMethod: String;
    function GetEmployeeID: Integer;

    procedure SetLeaveType(const Value: String);
    procedure SetActive(const Value: Boolean);
    procedure SetSuperannuationGuarantee(const Value: Boolean);
    procedure SetEFTLeaveType(const Value: Boolean);
    procedure SetOnTerminationUnusedBalance(const Value: Double);
    procedure SetOpeningBalance(const Value: Double);
    procedure SetHoursLeave(const Value: Double);
    procedure SetHoursFullTimeEmpFortnightlyPay(const Value: Double);
    procedure SetHoursAccruedAnnuallyFullTimeEmp(const Value: Double);
    procedure SetHoursAccruedAnnually(const Value: Double);
    procedure SetLeaveCalcMethod(const Value: String);
    procedure SetEmployeeID(const Value: Integer);
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
    property LeaveType: String read GetLeaveType write SetLeaveType;
    property Active: Boolean read GetActive write SetActive;
    property SuperannuationGuarantee: Boolean read GetSuperannuationGuarantee write SetSuperannuationGuarantee;
    property EFTLeaveType: Boolean read GetEFTLeaveType write SetEFTLeaveType;
    property OnTerminationUnusedBalance: Double read GetOnTerminationUnusedBalance write SetOnTerminationUnusedBalance;
    property OpeningBalance: Double read GetOpeningBalance write SetOpeningBalance;
    property HoursLeave: Double read GetHoursLeave write SetHoursLeave;
    property HoursFullTimeEmpFortnightlyPay: Double read GetHoursFullTimeEmpFortnightlyPay write SetHoursFullTimeEmpFortnightlyPay;
    property HoursAccruedAnnuallyFullTimeEmp: Double read GetHoursAccruedAnnuallyFullTimeEmp write SetHoursAccruedAnnuallyFullTimeEmp;
    property HoursAccruedAnnually: Double read GetHoursAccruedAnnually write SetHoursAccruedAnnually;
    property LeaveCalcMethod: String read GetLeaveCalcMethod write SetLeaveCalcMethod;
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TAssignLeaveType }

constructor TAssignLeaveType.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'AssignLeaveType';
  FSQL:= 'SELECT * FROM tblAssignLeaveType';
end;

destructor TAssignLeaveType.Destroy;
begin
  inherited;
end;

procedure TAssignLeaveType.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'AssignLeaveTypeLeaveType');
  SetBooleanPropertyFromNode(node, 'AssignLeaveTypeActive');
  SetBooleanPropertyFromNode(node, 'AssignLeaveTypeSuperannuationGuarantee');
  SetBooleanPropertyFromNode(node, 'AssignLeaveTypeEFTLeaveType');
  SetPropertyFromNode(node, 'AssignLeaveTypeOnTerminationUnusedBalance');
  SetPropertyFromNode(node, 'AssignLeaveTypeOpeningBalance');
  SetPropertyFromNode(node, 'AssignLeaveTypeHoursLeave');
  SetPropertyFromNode(node, 'AssignLeaveTypeHoursFullTimeEmpFortnightlyPay');
  SetPropertyFromNode(node, 'AssignLeaveTypeHoursAccruedAnnuallyFullTimeEmp');
  SetPropertyFromNode(node, 'AssignLeaveTypeHoursAccruedAnnually');
  SetPropertyFromNode(node, 'AssignLeaveTypeLeaveCalcMethod');
  SetPropertyFromNode(node, 'AssignLeaveTypeEmployeeID');
end;

procedure TAssignLeaveType.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'LeaveType', LeaveType);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'SuperannuationGuarantee', SuperannuationGuarantee);
  AddXMLNode(node, 'EFTLeaveType', EFTLeaveType);
  AddXMLNode(node, 'OnTerminationUnusedBalance', OnTerminationUnusedBalance);
  AddXMLNode(node, 'OpeningBalance', OpeningBalance);
  AddXMLNode(node, 'HoursLeave', HoursLeave);
  AddXMLNode(node, 'HoursFullTimeEmpFortnightlyPay', HoursFullTimeEmpFortnightlyPay);
  AddXMLNode(node, 'HoursAccruedAnnuallyFullTimeEmp', HoursAccruedAnnuallyFullTimeEmp);
  AddXMLNode(node, 'HoursAccruedAnnually', HoursAccruedAnnually);
  AddXMLNode(node, 'LeaveCalcMethod', LeaveCalcMethod);
  AddXMLNode(node, 'EmployeeID', EmployeeID);
end;

function TAssignLeaveType.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TAssignLeaveType.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TAssignLeaveType.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAssignLeaveType.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TAssignLeaveType.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TAssignLeaveType.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TAssignLeaveType.GetBusObjectTablename: String;
begin
  Result:= 'tblAssignLeaveType';
end;

function TAssignLeaveType.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TAssignLeaveType.GetLeaveType: String;
begin
  Result := GetStringField('LeaveType');
end;

function TAssignLeaveType.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TAssignLeaveType.GetSuperannuationGuarantee: Boolean;
begin
  Result := GetBooleanField('SuperannuationGuarantee');
end;

function TAssignLeaveType.GetEFTLeaveType: Boolean;
begin
  Result := GetBooleanField('EFTLeaveType');
end;

function TAssignLeaveType.GetOnTerminationUnusedBalance: Double;
begin
  Result := GetFloatField('OnTerminationUnusedBalance');
end;

function TAssignLeaveType.GetOpeningBalance: Double;
begin
  Result := GetFloatField('OpeningBalance');
end;

function TAssignLeaveType.GetHoursLeave: Double;
begin
  Result := GetFloatField('HoursLeave');
end;

function TAssignLeaveType.GetHoursFullTimeEmpFortnightlyPay: Double;
begin
  Result := GetFloatField('HoursFullTimeEmpFortnightlyPay');
end;

function TAssignLeaveType.GetHoursAccruedAnnuallyFullTimeEmp: Double;
begin
  Result := GetFloatField('HoursAccruedAnnuallyFullTimeEmp');
end;

function TAssignLeaveType.GetHoursAccruedAnnually: Double;
begin
  Result := GetFloatField('HoursAccruedAnnually');
end;

function TAssignLeaveType.GetLeaveCalcMethod: String;
begin
  Result := GetStringField('LeaveCalcMethod');
end;

function TAssignLeaveType.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

procedure TAssignLeaveType.SetLeaveType(const Value: String);
begin
  SetStringField('LeaveType', Value);
end;

procedure TAssignLeaveType.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TAssignLeaveType.SetSuperannuationGuarantee(const Value: Boolean);
begin
  SetBooleanField('SuperannuationGuarantee', Value);
end;

procedure TAssignLeaveType.SetEFTLeaveType(const Value: Boolean);
begin
  SetBooleanField('EFTLeaveType', Value);
end;

procedure TAssignLeaveType.SetOnTerminationUnusedBalance(const Value: Double);
begin
  SetFloatField('OnTerminationUnusedBalance', Value);
end;

procedure TAssignLeaveType.SetOpeningBalance(const Value: Double);
begin
  SetFloatField('OpeningBalance', Value);
end;

procedure TAssignLeaveType.SetHoursLeave(const Value: Double);
begin
  SetFloatField('HoursLeave', Value);
end;

procedure TAssignLeaveType.SetHoursFullTimeEmpFortnightlyPay(const Value: Double);
begin
  SetFloatField('HoursFullTimeEmpFortnightlyPay', Value);
end;

procedure TAssignLeaveType.SetHoursAccruedAnnuallyFullTimeEmp(const Value: Double);
begin
  SetFloatField('HoursAccruedAnnuallyFullTimeEmp', Value);
end;

procedure TAssignLeaveType.SetHoursAccruedAnnually(const Value: Double);
begin
  SetFloatField('HoursAccruedAnnually', Value);
end;

procedure TAssignLeaveType.SetLeaveCalcMethod(const Value: String);
begin
  SetStringField('LeaveCalcMethod', Value);
end;

procedure TAssignLeaveType.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

initialization
  RegisterClass(TAssignLeaveType);

end.

CREATE TABLE tblAssignLeaveType(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  LeaveType VARCHAR(50),
  Active ENUM('T', 'F'),
  SuperannuationGuarantee ENUM('T', 'F'),
  EFTLeaveType ENUM('T', 'F'),
  OnTerminationUnusedBalance DOUBLE,
  OpeningBalance DOUBLE,
  HoursLeave DOUBLE,
  HoursFullTimeEmpFortnightlyPay DOUBLE,
  HoursAccruedAnnuallyFullTimeEmp DOUBLE,
  HoursAccruedAnnually DOUBLE,
  LeaveCalcMethod VARCHAR(50),
  EmployeeID INTEGER,
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
