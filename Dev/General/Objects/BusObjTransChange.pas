unit BusObjTransChange;

interface

uses
  BusObjBase, DB, Classes;

type
  TTransChange = Class(TMSBusObj)
  private
    procedure SetActive(const Value: boolean);
    procedure SetApproved(const Value: boolean);
    procedure SetApproverEmployeeID(const Value: integer);
    procedure SetCreateDate(const Value: TDateTime);
    procedure SetData(const Value: string);
    procedure SetEmployeeID(const Value: integer);
    procedure SetTransID(const Value: integer);
    procedure SetTransType(const Value: string);
    function GetActive: boolean;
    function GetApproved: boolean;
    function GetApproverEmployeeID: integer;
    function GetCreateDate: TDateTime;
    function GetData: string;
    function GetEmployeeID: integer;
    function GetTransID: integer;
    function GetTransType: string;
  protected
    procedure DoFieldOnChange(Sender: TField); override;
//    function  GetSQL                             : string; override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean; override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean; override;
    function GetBusObjectTypeDescription: string; override;
  public
    class function  GetIDField: string; override;
    class function  GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    constructor  Create(AOwner: TComponent); override;
    destructor   Destroy; override;
//    procedure    LoadFromXMLNode(const node: IXMLNode); override;
//    procedure    SaveToXMLNode(const node: IXMLNode); override;
    function     ValidateData: Boolean; override;
    function     Save: Boolean; override;
  published
    property TransType: string read GetTransType write SetTransType;
    property TransID: integer read GetTransID write SetTransID;
    property EmployeeID: integer read GetEmployeeID write SetEmployeeID;
    property ApproverEmployeeID: integer read GetApproverEmployeeID write SetApproverEmployeeID;
    property CreateDate: TDateTime read GetCreateDate write SetCreateDate;
    property Active: boolean read GetActive write SetActive;
    property Approved: boolean read GetApproved write SetApproved;
    property Data: string read GetData write SetData;
  end;

implementation

uses
  AppEnvironment, SysUtils;

{ TTransChange }

constructor TTransChange.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tbltranschanges';
end;

destructor TTransChange.Destroy;
begin

  inherited;
end;

function TTransChange.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  self.CreateDate := Date;
  self.Active := true;
  self.Approved := false;
  self.EmployeeID := AppEnv.Employee.EmployeeID;
end;

function TTransChange.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

procedure TTransChange.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TTransChange.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

function TTransChange.GetApproved: boolean;
begin
  result := GetBooleanField('Approved');
end;

function TTransChange.GetApproverEmployeeID: integer;
begin
  result := GetIntegerField('ApproverEmployeeID');
end;

class function TTransChange.GetBusObjectTablename: string;
begin
  result := 'tbltranschanges';
end;

function TTransChange.GetBusObjectTypeDescription: string;
begin
  if TransType <> '' then
    result := TransType + ' Change'
  else
    result := inherited;
end;

function TTransChange.GetCreateDate: TDateTime;
begin
  result := GetDateTimeField('CreateDate');
end;

function TTransChange.GetData: string;
begin
  result := GetStringField('Data');
end;

function TTransChange.GetEmployeeID: integer;
begin
  result := GetIntegerField('EmployeeID');
end;

class function TTransChange.GetIDField: string;
begin
  result := 'ID';
end;

class function TTransChange.GetKeyStringField: string;
begin
  result := inherited;
end;

function TTransChange.GetTransID: integer;
begin
  result := GetIntegerField('TransID');
end;

function TTransChange.GetTransType: string;
begin
  result := GetStringField('TransType');
end;

function TTransChange.Save: Boolean;
begin
  ResultStatus.Clear;
  result := ValidateData;
  if not result then exit;
  result := inherited;
end;

procedure TTransChange.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TTransChange.SetApproved(const Value: boolean);
begin
  SetBooleanField('Approved', Value);
end;

procedure TTransChange.SetApproverEmployeeID(const Value: integer);
begin
  SetIntegerField('ApproverEmployeeID', Value);
end;

procedure TTransChange.SetCreateDate(const Value: TDateTime);
begin
  SetDateTimeField('CreateDate', Value);
end;

procedure TTransChange.SetData(const Value: string);
begin
  SetStringField('Data', Value);
end;

procedure TTransChange.SetEmployeeID(const Value: integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TTransChange.SetTransID(const Value: integer);
begin
  SetIntegerField('TransID', Value);
end;

procedure TTransChange.SetTransType(const Value: string);
begin
  SetStringField('TransType', Value);
end;

function TTransChange.ValidateData: Boolean;
begin
  result := false;
  if TransType = '' then begin
    AddResult(false,rssWarning,0,'Trans Type is blank');
    exit;
  end;
  if TransID = 0 then begin
    AddResult(false,rssWarning,0,'Trans ID is blank');
    exit;
  end;
  if EmployeeID = 0 then begin
    AddResult(false,rssWarning,0,'Employee ID is blank');
    exit;
  end;
  if ApproverEmployeeID = 0 then begin
    AddResult(false,rssWarning,0,'Approver Employee ID is blank');
    exit;
  end;
  result := true;
end;

end.
