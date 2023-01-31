unit BusObjRepServices;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TRepServices = class(TMSBusObj)
  private
    function GetRate: Double;
    function GetPayRate: Double;
    function GetAbilityID: Integer;
    function GetEmployeeID: Integer;
    function GetServiceID: Integer;
    function GetClientID: Integer;
    procedure SetRate(const Value: Double);
    procedure SetPayRate(const Value: Double);
    procedure SetAbilityID(const Value: Integer);
    procedure SetEmployeeID(const Value: Integer);
    procedure SetServiceID(const Value: Integer);
    procedure SetClientID(const Value: Integer);
    // function GetAbilityDesc: string;
    function GetIsFixedRate: Boolean;
    function GetRanking: Integer;
//    function GetServiceDesc: string;
    function GetServiceDescFixed: string;
    function GetAbilityDesc: string;
    procedure SetAbilityDesc(const Value: string);
    function GetServiceDesc: string;
    procedure SetServiceDesc(const Value: string);
    function GetCustomerName: string;
    procedure SetCustomerName(const Value: string);
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    function getactive: Boolean;
    procedure setactive(const Value: Boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;

    function FindService(aServiceDesc: string): Boolean; overload;
    function FindService(aServiceID: Integer): Boolean; overload;

//    property ServiceDesc: string read GetServiceDesc;
    property ServiceDescFixed: string read GetServiceDescFixed;
    // property AbilityDesc: string read GetAbilityDesc;
    property Ranking: Integer read GetRanking;
    property IsFixedRate: Boolean read GetIsFixedRate;
    class function _Schema: string; override;
    Procedure NewService(atrainerID, aServiceID:Integer; aRate:Double);
  published
    property Rate: Double read GetRate write SetRate;
    property PayRate: Double read GetPayRate write SetPayRate;
    property AbilityID: Integer read GetAbilityID write SetAbilityID;
    property AbilityDesc: string read GetAbilityDesc write SetAbilityDesc;
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property ServiceID: Integer read GetServiceID write SetServiceID;
    property ServiceDesc: string read GetServiceDesc write SetServiceDesc;
    property ClientID: Integer read GetClientID write SetClientID;
    property CustomerName: string read GetCustomerName write SetCustomerName;
    Property Active :Boolean read getactive write setactive;
  end;

  TServicesWithRate = class(TRepServices)
    Private
      fiLookupEmployeeID: Integer;
    Protected
      Function  DoBeforeOpen(Sender :TDataset):Boolean;Override;
    Public
      constructor Create(AOwner: TComponent); override;
      Property LookupEmployeeID:Integer read fiLookupEmployeeID write fiLookupEmployeeID;
    Published
  end;

implementation

uses
  CommonLib, SysUtils, BusObjAbility, BusObjCommon, BusObjClient, BusObjRep,
  ERPdbComponents,BusObjSchemaLib, tcDataUtils;

{ TRepServices }

constructor TRepServices.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'select * from tblTrainerRates';
  // fSQL := 'SELECT DISTINCT r.*, s.ServiceDesc, a.AbilityDesc, s.Ranking, s.IsFixedRate '
  // + 'FROM tblTrainerRates r '
  // + 'LEFT JOIN tblServices s ON s.ServiceID = r.ServiceID '
  // + 'LEFT JOIN tblAbility a ON a.AbilityID = r.AbilityID ';
  if Assigned(Owner) and (Owner is TRep) then fIsList:= true;
  ExportExcludeList.Add('abilityid');
  ExportExcludeList.Add('serviceid');
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('clientid');
end;

destructor TRepServices.Destroy;
begin
  inherited;
end;

procedure TRepServices.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  Rate      := GetXMLNodeFloatValue  (node, 'Rate');
  PayRate   := GetXMLNodeFloatValue  (node, 'PayRate');
  AbilityID := GetXMLNodeIntegerValue(node, 'AbilityID');
  EmployeeID:= GetXMLNodeIntegerValue(node, 'EmployeeID');
  ServiceID := GetXMLNodeIntegerValue(node, 'ServiceID');
  ClientID  := GetXMLNodeIntegerValue(node, 'ClientID');
end;

procedure TRepServices.NewService(atrainerID, aServiceID: Integer;aRate: Double);
begin
  New;
  EmployeeId := atrainerID;
  ServiceID  := aServiceID;
  Rate       := aRate;
  clientID   := 0;
  PostDB;
end;

procedure TRepServices.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Rate', Rate);
  AddXMLNode(node, 'PayRate', PayRate);
  AddXMLNode(node, 'AbilityID', AbilityID);
  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'ServiceID', ServiceID);
  AddXMLNode(node, 'ClientID', ClientID);
end;

function TRepServices.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if EmployeeID = 0 then begin
    AddResult(False, rssError, 0, 'Employee is blank');
    Exit;
  end;
  if Assigned(Owner) and (Owner is TRep) and (TRep(Owner).ID <> EmployeeID) then begin
    AddResult(False, rssError, 0, 'Service Employee ID does not match the Rep ID');
    Exit;
  end;
  if ServiceID = 0 then begin
    AddResult(False, rssError, 0, 'Service is blank');
    Exit;
  end;
  if AbilityID < 0 then begin
    AddResult(false, rssWarning, 0, 'Linked Ability not found');
    exit;
  end;
  if ServiceID < 0 then begin
    AddResult(false, rssWarning, 0, 'Linked Service not found');
    exit;
  end;
  if ClientID < 0 then begin
    AddResult(false, rssWarning, 0, 'Linked Customer not found');
    exit;
  end;
  Result := True;
end;

class function TRepServices._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAbility','AbilityObj','AbilityID','ID');
  TBOSchema.AddRefType(result,'TAbility','AbilityObj','AbilityDesc','AbilityDesc');
  TBOSchema.AddRefType(result,'TEmployee','RepObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','RepObj','EmployeeName','EmployeeName');
  TBOSchema.AddRefType(result,'TServices','ServicesObj','ServiceID','ID');
  TBOSchema.AddRefType(result,'TServices','ServicesObj','ServiceDesc','ServiceDesc');
  TBOSchema.AddRefType(result,'TCustomer','CustObj','ClientID','ID');
  TBOSchema.AddRefType(result,'TCustomer','CustObj','CustomerName','CustomerName');
end;

function TRepServices.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;
procedure TRepServices.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TRepServices.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TRepServices.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TRepServices.GetIDField: string;
begin
  Result := 'TrainrateID'
end;

class function TRepServices.GetBusObjectTablename: string;
begin
  Result := 'tblTrainerRates';
end;

function TRepServices.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
  EmployeeId := 0;
  ServiceID  := 0;
  Rate       := 0;
  clientID   := 0;
  if Assigned(Owner) and (Owner is TRep) then begin
    if TRep(Owner).ID < 1 then
      TRep(Owner).PostDb;
    EmployeeID:= TRep(Owner).ID;
  end;
end;

function TRepServices.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property functions }
function TRepServices.GetRate: Double;begin  Result := GetFloatField('Rate');end;
function TRepServices.GetPayRate: Double;begin  Result := GetFloatField('PayRate');end;
function TRepServices.GetAbilityID: Integer;begin  Result := GetIntegerField('AbilityID');end;
function TRepServices.getactive: Boolean;begin  Result := GetBooleanField('Active');end;

function TRepServices.GetEmployeeID: Integer;begin  Result := GetIntegerField('EmployeeID');end;

function TRepServices.GetAbilityDesc: string;
begin
  if AbilityID > 0 then
    Result := TAbility.IDToggle(AbilityID, Connection.Connection)
  else
    Result := '';
end;


function TRepServices.GetEmployeeName: string;
begin
  if Assigned(Owner) and (Owner is TRep) then
    result:= TRep(Owner).EmployeeName
  else if EmployeeID > 0 then
    result := TRep.IDToggle(EmployeeID, Connection.Connection)
  else
    result:= '';
end;

function TRepServices.GetServiceID: Integer;begin  Result := GetIntegerField('ServiceID');end;
function TRepServices.GetClientID: Integer;begin  Result := GetIntegerField('ClientID');end;

function TRepServices.GetCustomerName: string;
begin
  if ClientID > 0 then
    result := TCustomer.IDToggle(ClientID, Connection.Connection)
  else
    result := '';
end;

procedure TRepServices.SetRate(const Value: Double);begin  SetFloatField('Rate', Value);end;
procedure TRepServices.SetPayRate(const Value: Double);begin  SetFloatField('PayRate', Value);end;
procedure TRepServices.SetAbilityDesc(const Value: string);
begin
  if Value <> '' then begin
    AbilityID := TAbility.IDToggle(Value, Connection.Connection);
    if AbilityID = 0 then
      AbilityId := -1;
  end
  else
    AbilityID:= 0;
end;

procedure TRepServices.SetAbilityID(const Value: Integer);begin  SetIntegerField('AbilityID', Value);end;
procedure TRepServices.setactive(const Value: Boolean);begin  SetBooleanField('Active', Value);end;

procedure TRepServices.SetEmployeeID(const Value: Integer);begin  SetIntegerField('EmployeeId', Value);end;

procedure TRepServices.SetEmployeeName(const Value: string);
begin
  if Value <> '' then
    EmployeeID:= TRep.IDToggle(Value, Connection.Connection)
  else
    EmployeeID:= 0;
end;

procedure TRepServices.SetServiceDesc(const Value: string);
begin
  if Value <> '' then begin
    ServiceID := TServices.IDToggle(Value, Connection.Connection);
    if ServiceID = 0 then
      ServiceID:= -1;
  end
  else
    ServiceID:= 0;
end;

procedure TRepServices.SetServiceID(const Value: Integer);begin  SetIntegerField('ServiceID', Value);end;
procedure TRepServices.SetClientID(const Value: Integer);begin  SetIntegerField('ClientID', Value);end;


procedure TRepServices.SetCustomerName(const Value: string);
begin
  if Value <> '' then begin
    ClientID := TCustomer.IDToggle(Value, Connection.Connection);
    if ClientID = 0 then
      ClientID := -1;
  end
  else
    ClientID := 0;
end;

// function TRepServices.GetAbilityDesc: string;
// begin
// Result := GetStringField('AbilityDesc');
// end;

function TRepServices.GetIsFixedRate: Boolean;begin  Result := GetBooleanField('IsFixedRate');end;
function TRepServices.GetRanking: Integer;begin  Result := GetIntegerField('Ranking');end;

//function TRepServices.GetServiceDesc: string;
//begin
//  Result := GetStringField('ServiceDesc');
//end;

function TRepServices.GetServiceDesc: string;
begin
  if ServiceID > 0 then
    result := TServices.IDToggle(ServiceID, Connection.Connection)
  else
    result := '';
end;

function TRepServices.GetServiceDescFixed: string;
begin
  Result := ServiceDesc;
  if IsFixedRate then
    Result := Result + '(Fixed Rate)';
end;

function TRepServices.FindService(aServiceID: Integer): Boolean;
begin
  Result := Dataset.Locate('ServiceID', aServiceID, []);
end;

function TRepServices.FindService(aServiceDesc: string): Boolean;
var
  iServiceID:Integer;
begin
  aServiceDesc := Trim(ReplaceStr(aServiceDesc, '(Fixed Rate)', ''));
  iServiceId := tcdatautils.getServiceID(aServiceDesc );
  Result := Dataset.Locate('serviceID', iServiceId, []);
end;

{ TServicesWithRate }

constructor TServicesWithRate.Create(AOwner: TComponent);
begin
  inherited;
  fiLookupEmployeeID := 0;
  fbIsReadonly := true;
  fSQL := 'SELECT ifnull(TR.Rate,S.StandardRate) AS rate,ifnull(TR.PayRate,S.StandardRate) AS Payrate, '+
          ' TR.AbilityID, TR.EmployeeID,     S.ServiceID, TR.TrainRateID,TR.ClientID '+
          ' FROM  tblservices S Left JOIN  tbltrainerrates TR  ON TR.ServiceID = S.ServiceID    AND TR.EmployeeID = :EmployeeID ';
end;

function TServicesWithRate.DoBeforeOpen(Sender: TDataset): Boolean;
begin
  TERPQuery(Sender).parambyname('EmployeeID').asInteger :=LookupEmployeeID;
end;

initialization
  RegisterClassOnce(TRepServices);
end.
