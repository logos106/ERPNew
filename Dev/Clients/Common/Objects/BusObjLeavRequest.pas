unit BusObjLeavRequest;

interface

{$I ERP.inc}

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, CommonLib;

type
  TLeavRequest = class(TMSBusObj)
  private
    function GetLeave: String;
    procedure SetLeave(const Value: String);
    function GetLeaveMethod: String;
    procedure SetLeaveMethod(const Value: String);
    function GetHoursOfLeave: Double;
    procedure SetHoursOfLeave(const Value: Double);
    function GetOpenBalance: Double;
    procedure SetOpenBalance(const Value: Double);
    function GetHours: Double;
    procedure SetHours(const Value: Double);
    function GetTerminationbalace: Double;
    procedure SetTerminationbalace(const Value: Double);
    function GetEmployeeID: Integer;
    procedure SetEmployeeID(const Value: Integer);
    function GetEmployeeName: String;
    procedure SetEmployeeName(const Value: String);
    function GetDescription: String;
    procedure SetDescription(const Value: String);
    function GetPayPeriod: String;
    procedure SetPayPeriod(const Value: String);
    function GetStatus: String;
    procedure SetStatus(const Value: String);
    function GetStartDate: TDatetime;
    procedure SetStartDate(const Value :TDatetime);
    function GetEndDate: TDatetime;
    procedure SetEndDate(const Value :TDatetime);
    function GetTypeOfRequest: Integer;
    procedure SetTypeOfRequest(const Value: Integer);
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);

  protected
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property EmployeeName: String read GetEmployeeName write SetEmployeeName;
    property Leave: String read GetLeave write SetLeave;
    property LeaveMethod: String read GetLeaveMethod write SetLeaveMethod;
    property HoursOfLeave: Double read GetHoursOfLeave write SetHoursOfLeave;
    property OpeningBalance: Double read GetOpenBalance write SetOpenBalance;
    property Hours: Double read GetHours write SetHours;
    property Terminationbalace: Double read GetTerminationbalace write SetTerminationbalace;
    property Description: string read GetDescription write SetDescription;
    property PayPeriod: string read GetPayPeriod write SetPayPeriod;
    property Status: string read GetStatus write SetStatus;
    property StartDate: TDateTime read GetStartDate write SetStartDate;
    property EndDate: TDateTime read GetEndDate write SetEndDate;
    property TypeOfRequest: Integer read GetTypeOfRequest write SetTypeOfRequest;
    property Active: Boolean read GetActive write SetActive;

  end;

implementation

constructor TLeavRequest.Create(AOwner: TComponent);
begin
  inherited;

  fSQL := 'SELECT * FROM tblleaverequest';
//  FSQL :=
//    ' SELECT * FROM ' +
//    ' ( ' +
//    ' SELECT 1 LeaveID, ' +
//    '   123 EmployeeID, ''Tim Fisher'' EmployeeName, ' +
//    '   ''Annual Leave'' `Leave`, ''Test'' LeaveMethod, 3 HoursOfLeave, 10.5 OpeningBalance, 3 Hours, NULL Terminationbalance, ' +
//    '   ''DEF1'' GlobalRef, CURRENT_TIMESTAMP MsTimeStamp' +
//    ' UNION ' +
//    ' SELECT 2 LeaveID, ' +
//    '   456 EmployeeID, ''Jill Ahmed'' EmployeeName, ' +
//    '   ''Sick Leave'' `Leave`, ''Test 2'' LeaveMethod, 8 HoursOfLeave, 17 OpeningBalance, 8 Hours, NULL Terminationbalance, ' +
//    '   ''DEF2'' GlobalRef, CURRENT_TIMESTAMP MsTimeStamp ' +
//    ' UNION ' +
//    ' SELECT 3 LeaveID, ' +
//    '   789 EmployeeID, ''Ravi Varma'' EmployeeName, ' +
//    '   ''Sick Leave'' `Leave`, ''Test 3'' LeaveMethod, 16 HoursOfLeave, 34 OpeningBalance, 16 Hours, NULL Terminationbalance, ' +
//    '   ''DEF3'' GlobalRef, CURRENT_TIMESTAMP MsTimeStamp ' +
//    ' ) tblLeavRequest';
end;

destructor TLeavRequest.Destroy;
begin
  inherited;
end;

procedure TLeavRequest.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(Node, 'Leave');
  SetPropertyFromNode(Node, 'LeaveMethod');
  SetPropertyFromNode(Node, 'HoursOfLeave');
  SetPropertyFromNode(Node, 'OpeningBalance');
  SetPropertyFromNode(Node, 'Hours');
  SetPropertyFromNode(Node, 'Terminationbalace');
end;

procedure TLeavRequest.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

  AddXMLNode(Node, 'Leave', Leave);
  AddXMLNode(Node, 'LeaveMethod', LeaveMethod);
  AddXMLNode(Node, 'HoursOfLeave', HoursOfLeave);
  AddXMLNode(Node, 'OpeningBalance', OpeningBalance);
  AddXMLNode(Node, 'Hours', Hours);
  AddXMLNode(Node, 'Terminationbalace', Terminationbalace);
end;

function TLeavRequest.ValidateData: Boolean;
begin
  Result := True;
end;

function TLeavRequest.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

class function TLeavRequest.GetBusObjectTablename: string;
begin
  Result := 'tblleaverequest';
end;

class function TLeavRequest.GetIDField: string;
begin
  Result := 'ID';
end;

function TLeavRequest.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited;
end;

function TLeavRequest.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

procedure TLeavRequest.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

function TLeavRequest.GetEmployeeName: String;
begin
  Result := GetStringField('EmployeeName');
end;

procedure TLeavRequest.SetEmployeeName(const Value: String);
begin
  SetStringField('EmployeeName' , Value);
end;

function TLeavRequest.GetLeave: String;
begin
  Result := GetStringField('Leave2');
end;

procedure TLeavRequest.SetLeave(const Value: String);
begin
  SetStringField('Leave2' , Value);
end;

function TLeavRequest.GetLeaveMethod: String;
begin
  Result := GetStringField('LeaveMethod');
end;

procedure TLeavRequest.SetLeaveMethod(const Value: String);
begin
  SetStringField('LeaveMethod', Value);
end;

function TLeavRequest.GetHoursOfLeave: Double;
begin
  Result := GetFloatField('HoursOfLeave');
end;

procedure TLeavRequest.SetHoursOfLeave(const Value: Double);
begin
  SetFloatField('HoursOfLeave', Value);
end;

function TLeavRequest.GetOpenBalance: Double;
begin
  Result := GetFloatField('OpeningBalance');
end;

procedure TLeavRequest.SetOpenBalance(const Value: Double);
begin
  SetFloatField('OpeningBalance', Value);
end;

function TLeavRequest.GetHours: Double;
begin
  Result := GetFloatField('Hours');
end;

procedure TLeavRequest.SetHours(const Value: Double);
begin
  SetFloatField('Hours', Value);
end;

function TLeavRequest.GetTerminationbalace: Double;
begin
  Result := GetFloatField('Terminationbalace');
end;

procedure TLeavRequest.SetTerminationbalace(const Value: Double);
begin
  SetFloatField('Terminationbalace', Value);
end;

function TLeavRequest.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

procedure TLeavRequest.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

function TLeavRequest.GetPayPeriod: string;
begin
  Result := GetStringField('PayPeriod');
end;

procedure TLeavRequest.SetPayPeriod(const Value: string);
begin
  SetStringField('PayPeriod', Value);
end;

function TLeavRequest.GetStatus: string;
begin
  Result := GetStringField('Status');
end;

procedure TLeavRequest.SetStatus(const Value: string);
begin
  SetStringField('Status', Value);
end;

function TLeavRequest.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TLeavRequest.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

function TLeavRequest.GetStartDate: TDatetime;
begin
  Result := GetDateTimeField('StartDate');
end;

procedure TLeavRequest.SetStartDate(const Value :TDatetime);
begin
  SetDateTimeField('Startdate', Value);
end;

function TLeavRequest.GetEndDate: TDatetime;
begin
  Result := GetDateTimeField('EndDate');
end;

procedure TLeavRequest.SetEndDate(const Value :TDatetime);
begin
  SetDateTimeField('EndDate', Value);
end;

function TLeavRequest.GetTypeOfRequest: Integer;
begin
  Result := GetIntegerField('TypeOfRequest');
end;

procedure TLeavRequest.SetTypeOfRequest(const Value: Integer);
begin
  SetIntegerField('TypeOfRequest', Value);
end;

initialization
  RegisterClassOnce(TLeavRequest);

end.

