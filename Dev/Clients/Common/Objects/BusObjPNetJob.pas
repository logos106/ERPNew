unit BusObjPNetJob;

interface

uses
  Classes, BusObjClient, busObjBase, DB, BusObjAttachment;

type

  TPNetJobExtra = class(TMSBusObj)
  private
    function GetBayNumber: string;
    function GetClaimDescription: string;
    function GetClaimManager: string;
    function GetCustomerCompanyName: string;
    function GetExtraQuoteInformationRequested: boolean;
    function GetJobID: integer;
    function GetOffsiteQuoting: boolean;
    function GetOperationalUnit: string;
    function GetProcessType: string;
    function GetQuoteDueTime: TDateTime;
    function GetQuotingMethodIndicator: string;
    function GetVehicleDamageDescription: string;
    function GetVehicleDescription: string;
    function GetVehicleFuelLevel: integer;
    function GetVehicleLocation: string;
    function GetVehicleNumberOfCylinders: string;
    function GetVehicleOdometer: integer;
    function GetVehicleOldDamageDescription: string;
    function GetVehiclePaintType: string;
    function GetVehicleTransmissionType: string;
    function GetWorkLocation: string;
    procedure SetBayNumber(const Value: string);
    procedure SetClaimDescription(const Value: string);
    procedure SetClaimManager(const Value: string);
    procedure SetCustomerCompanyName(const Value: string);
    procedure SetExtraQuoteInformationRequested(const Value: boolean);
    procedure SetJobID(const Value: integer);
    procedure SetOffsiteQuoting(const Value: boolean);
    procedure SetOperationalUnit(const Value: string);
    procedure SetProcessType(const Value: string);
    procedure SetQuoteDueTime(const Value: TDateTime);
    procedure SetQuotingMethodIndicator(const Value: string);
    procedure SetVehicleDamageDescription(const Value: string);
    procedure SetVehicleDescription(const Value: string);
    procedure SetVehicleFuelLevel(const Value: integer);
    procedure SetVehicleLocation(const Value: string);
    procedure SetVehicleNumberOfCylinders(const Value: string);
    procedure SetVehicleOdometer(const Value: integer);
    procedure SetVehicleOldDamageDescription(const Value: string);
    procedure SetVehiclePaintType(const Value: string);
    procedure SetVehicleTransmissionType(const Value: string);
    procedure SetWorkLocation(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property JobID: integer read GetJobID write SetJobID;
    property ClaimDescription: string read GetClaimDescription write SetClaimDescription;
    property ProcessType: string read GetProcessType write SetProcessType;
    property OperationalUnit: string read GetOperationalUnit write SetOperationalUnit;
    property WorkLocation: string read GetWorkLocation write SetWorkLocation;
    property ClaimManager: string read GetClaimManager write SetClaimManager;
    property CustomerCompanyName: string read GetCustomerCompanyName write SetCustomerCompanyName;
    property VehicleLocation: string read GetVehicleLocation write SetVehicleLocation;
    property BayNumber: string read GetBayNumber write SetBayNumber;
    property OffsiteQuoting: boolean read GetOffsiteQuoting write SetOffsiteQuoting;
    property ExtraQuoteInformationRequested: boolean read GetExtraQuoteInformationRequested write SetExtraQuoteInformationRequested;
    property QuoteDueTime: TDateTime read GetQuoteDueTime write SetQuoteDueTime;
    property VehicleDescription: string read GetVehicleDescription write SetVehicleDescription;
    property VehicleTransmissionType: string read GetVehicleTransmissionType write SetVehicleTransmissionType;
    property VehicleNumberOfCylinders: string read GetVehicleNumberOfCylinders write SetVehicleNumberOfCylinders;
    property VehiclePaintType: string read GetVehiclePaintType write SetVehiclePaintType;
    property VehicleOdometer: integer read GetVehicleOdometer write SetVehicleOdometer;
    property VehicleFuelLevel: integer read GetVehicleFuelLevel write SetVehicleFuelLevel;
    property VehicleDamageDescription: string read GetVehicleDamageDescription write SetVehicleDamageDescription;
    property VehicleOldDamageDescription: string read GetVehicleOldDamageDescription write SetVehicleOldDamageDescription;
    property QuotingMethodIndicator: string read GetQuotingMethodIndicator write SetQuotingMethodIndicator;
  published
  end;

  TPNetJob = class(TJob)
  private
    fExtra: TPNetJobExtra;
    function GetQuoteRequestNumber: string;
    function GetQuoteRequestVersionNumber: integer;
    procedure SetQuoteRequestNumber(const Value: string);
    procedure SetQuoteRequestVersionNumber(const Value: integer);
    function GetClaimDescription: string;
    procedure SetClaimDescription(const Value: string);
    function GetExtra: TPNetJobExtra;
    function GetProcessType: string;
    procedure SetProcessType(const Value: string);
    function GetOperationalUnit: string;
    procedure SetOperationalUnit(const Value: string);
    function GetWorkLocation: string;
    procedure SetWorkLocation(const Value: string);
    function GetClaimManager: string;
    procedure SetClaimManager(const Value: string);
    procedure SetCorporateCustomer(const Value: string);
    function GetCorporateCustomer: string;
    function GetClaimCustomerTitle: string;
    procedure SetClaimCustomerTitle(const Value: string);
    function GetClaimCustomerFirstName: string;
    procedure SetClaimCustomerFirstName(const Value: string);
    function GetClaimCustomerSurname: string;
    procedure SetClaimCustomerSurname(const Value: string);
    function GetClaimCustomerCompanyName: string;
    procedure SetClaimCustomerCompanyName(const Value: string);
    function GetVehicleLocation: string;
    procedure SetVehicleLocation(const Value: string);
    function GetBayNumber: string;
    procedure SetBayNumber(const Value: string);
    function GetOffSiteQuoting: boolean;
    procedure SetOffSiteQuoting(const Value: boolean);
    function GetExtraQuoteInformationRequired: boolean;
    procedure SetExtraQuoteInformationRequired(const Value: boolean);
    function GetQuoteDueTime: TDateTime;
    procedure SetQuoteDueTime(const Value: TDateTime);
    function GetVehicleRegistration: string;
    procedure SetVehicleRegistration(const Value: string);
    function GetVehicleDescription: string;
    procedure SetVehicleDescription(const Value: string);
    function GetVehicleMake: string;
    procedure SetVehicleMake(const Value: string);
    function GetVehicleYearOfManufacture: integer;
    procedure SetVehicleYearOfManufacture(const Value: integer);
    function GetVehicleMonthOfManufacture: integer;
    procedure SetVehicleMonthOfManufacture(const Value: integer);
    function GetVehicleBodyShape: string;
    procedure SetVehicleBodyShape(const Value: string);
    function GetVehicleTransmissionType: string;
    procedure SetVehicleTransmissionType(const Value: string);
    function GetVehicleNumberOfCylinders: string;
    procedure SetVehicleNumberOfCylinders(const Value: string);
    function GetVehicleVINChassis: string;
    procedure SetVehicleVINChassis(const Value: string);
    function GetVehicleColor: string;
    procedure SetVehicleColor(const Value: string);
    function GetPaintType: string;
    procedure SetPaintType(const Value: string);
    function GetVehicleOdometer: integer;
    procedure SetVehicleOdometer(const Value: integer);
    function GetVehicleFuelLevel: integer;
    procedure SetVehicleFuelLevel(const Value: integer);
    function GetVehicleDamageDescription: string;
    procedure SetVehicleDamageDescription(const Value: string);
    function GetVehicleOldDamageDescription: string;
    procedure SetVehicleOldDamageDescription(const Value: string);
    function GetInstructions: string;
    procedure SetInstructions(const Value: string);
    function GetAttachments: TAttachment;
    procedure SetClaimCustomerBusinessPhoneNumber(const Value: string);
    procedure SetClaimCustomerPrivatePhoneNumber(const Value: string);
    function GetClaimCustomerBusinessPhoneNumber: string;
    function GetClaimCustomerPrivatePhoneNumber: string;
  protected
    property Extra: TPNetJobExtra read GetExtra;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: Boolean; override;
  published
    property QuoteRequestNumber: string read GetQuoteRequestNumber write SetQuoteRequestNumber;
    property QuoteRequestVersionNumber: integer read GetQuoteRequestVersionNumber write SetQuoteRequestVersionNumber;
    { property ClaimNumber: string; Inherited }
    property ClaimDescription: string read GetClaimDescription write SetClaimDescription;
    property ProcessType: string read GetProcessType write SetProcessType;
    property OperationalUnit: string read GetOperationalUnit write SetOperationalUnit;
    property WorkLocation: string read GetWorkLocation write SetWorkLocation;
    property ClaimManager: string read GetClaimManager write SetClaimManager;
    property CorporateCustomer: string read GetCorporateCustomer write SetCorporateCustomer;
    property ClaimCustomerTitle: string read GetClaimCustomerTitle write SetClaimCustomerTitle;
    property ClaimCustomerFirstName: string read GetClaimCustomerFirstName write SetClaimCustomerFirstName;
    property ClaimCustomerSurname: string read GetClaimCustomerSurname write SetClaimCustomerSurname;
    property ClaimCustomerCompanyName: string read GetClaimCustomerCompanyName write SetClaimCustomerCompanyName;
    property ClaimCustomerPrivatePhoneNumber: string read GetClaimCustomerPrivatePhoneNumber write SetClaimCustomerPrivatePhoneNumber;            { TJob Mobile }
    property ClaimCustomerBusinessPhoneNumber: string read GetClaimCustomerBusinessPhoneNumber write SetClaimCustomerBusinessPhoneNumber;            { TJob Phone }
    property VehicleLocation: string read GetVehicleLocation write SetVehicleLocation;
    property BayNumber: string read GetBayNumber write SetBayNumber;
    property OffSiteQuoting: boolean read GetOffSiteQuoting write SetOffSiteQuoting;
    property ExtraQuoteInformationRequired: boolean read GetExtraQuoteInformationRequired write SetExtraQuoteInformationRequired;
    property QuoteDueTime: TDateTime read GetQuoteDueTime write SetQuoteDueTime;
    property VehicleRegistration: string read GetVehicleRegistration write SetVehicleRegistration;
    property VehicleDescription: string read GetVehicleDescription write SetVehicleDescription;
    property VehicleMake: string read GetVehicleMake write SetVehicleMake;
    property VehicleYearOfManufacture: integer read GetVehicleYearOfManufacture write SetVehicleYearOfManufacture;
    property VehicleMonthOfManufacture: integer read GetVehicleMonthOfManufacture write SetVehicleMonthOfManufacture;
    property VehicleBodyShape: string read GetVehicleBodyShape write SetVehicleBodyShape;
    property VehicleTransmissionType: string read GetVehicleTransmissionType write SetVehicleTransmissionType;
    property VehicleNumberOfCylinders: string read GetVehicleNumberOfCylinders write SetVehicleNumberOfCylinders;
    property VehicleVINChassis: string read GetVehicleVINChassis write SetVehicleVINChassis;
    property VehicleColor: string read GetVehicleColor write SetVehicleColor;
    property VehiclePaintType: string read GetPaintType write SetPaintType;
    property VehicleOdometer: integer read GetVehicleOdometer write SetVehicleOdometer;
    property VehicleFuelLevel: integer read GetVehicleFuelLevel write SetVehicleFuelLevel;
    property VehicleDamageDescription: string read GetVehicleDamageDescription write SetVehicleDamageDescription;
    property VehicleOldDamageDescription: string read GetVehicleOldDamageDescription write SetVehicleOldDamageDescription;
    property Instructions: string read GetInstructions write SetInstructions;
    property Attachments: TAttachment read GetAttachments;
  end;

implementation

uses
  SysUtils, types, StrUtils, BusObjManufacture, DateUtils;



{ TPNetJob }

procedure TPNetJob.SetCorporateCustomer(const Value: string);
var
  cust: TCustomer;
begin
  { make sure we have the parent customer }
  if TCustomer.IDToggle(Value, self.Connection.Connection) = 0 then begin
    cust := TCustomer.Create(nil);
    try
      cust.Connection := self.Connection;
      cust.New;
      cust.ClientName := Value;
      cust.PostDb;
    finally
      cust.Free;
    end;
  end;
  ParentClientName:= Value;
end;

procedure TPNetJob.SetExtraQuoteInformationRequired(const Value: boolean);
begin
  Extra.ExtraQuoteInformationRequested := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetInstructions(const Value: string);
begin
  self.Notes := Value;
end;

constructor TPNetJob.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblClients WHERE (IsJob = "T") and (tblClients.ClientID = (select ClientId from PNetJob where PNetJob.JobId = tblClients.ClientID))';
end;

destructor TPNetJob.Destroy;
begin

  inherited;
end;

function TPNetJob.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
  Extra.PostDb;
end;

function TPNetJob.GetAttachments: TAttachment;
begin
  result := TAttachment(GetContainerComponent(TAttachment ,'TableName = "tblClients" and TableId = ' + IntToStr(Self.ID)));
end;

function TPNetJob.GetBayNumber: string;
begin
  result:= Extra.BayNumber;
end;

function TPNetJob.GetClaimCustomerBusinessPhoneNumber: string;
begin
  result := self.Phone;
end;

function TPNetJob.GetClaimCustomerCompanyName: string;
begin
  result := Extra.CustomerCompanyName;
end;

function TPNetJob.GetClaimCustomerFirstName: string;
begin
  result := self.FirstName;
end;

function TPNetJob.GetClaimCustomerPrivatePhoneNumber: string;
begin
  result := self.Mobile
end;

function TPNetJob.GetClaimCustomerSurname: string;
begin
  result := self.LastName;
end;

function TPNetJob.GetClaimCustomerTitle: string;
begin
  result:= self.Title;
end;

function TPNetJob.GetClaimDescription: string;
begin
  result := Extra.ClaimDescription;
end;

function TPNetJob.GetClaimManager: string;
begin
  result:= Extra.ClaimManager;
end;

function TPNetJob.GetCorporateCustomer: string;
begin
  result:= ParentClientName;
end;

function TPNetJob.GetExtra: TPNetJobExtra;
begin
  if not Assigned(fExtra) then
    fExtra:= TPNetJobExtra.Create(self);
  result := fExtra;
  if self.ID = 0 then begin
    if Dataset.State in [dsEdit, dsInsert] then
      PostDb;
  end;
  if (result.ID <> self.ID) and (self.ID <> 0)then begin
    result.Load(Self.ID);
    if (result.ID <> self.ID) then begin
      result.New;
      result.JobID := self.ID;
      result.PostDb;
    end;
  end;
end;

function TPNetJob.GetExtraQuoteInformationRequired: boolean;
begin
  result:= Extra.ExtraQuoteInformationRequested;
end;

function TPNetJob.GetInstructions: string;
begin
  result := self.Notes;
end;

function TPNetJob.GetOffSiteQuoting: boolean;
begin
  result := Extra.OffsiteQuoting;
end;

function TPNetJob.GetOperationalUnit: string;
begin
  result := Extra.OperationalUnit;
end;

function TPNetJob.GetPaintType: string;
begin
  result := Extra.VehiclePaintType;
end;

function TPNetJob.GetProcessType: string;
begin
  result:= Extra.ProcessType;
end;

function TPNetJob.GetQuoteDueTime: TDateTime;
begin
  result := Extra.QuoteDueTime;
end;

function TPNetJob.GetQuoteRequestNumber: string;
var
  StringDynArray: TStringDynArray;
begin
  result := '';
  StringDynArray := SplitString(JobName,'-');
  if Length(StringDynArray) > 0 then
    result := StringDynArray[0];
end;

function TPNetJob.GetQuoteRequestVersionNumber: integer;
var
  StringDynArray: TStringDynArray;
begin
  result := 0;
  StringDynArray := SplitString(JobName,'-');
  if Length(StringDynArray) > 1 then
    result := StrToIntDef(StringDynArray[1],0);
end;

function TPNetJob.GetVehicleBodyShape: string;
begin
  result := self.BodyType;
end;

function TPNetJob.GetVehicleColor: string;
begin
  result := self.Colour;
end;

function TPNetJob.GetVehicleDamageDescription: string;
begin
  result := Extra.VehicleDamageDescription;
end;

function TPNetJob.GetVehicleDescription: string;
begin
  result:= Extra.VehicleDescription;
end;

function TPNetJob.GetVehicleFuelLevel: integer;
begin
  result:= Extra.VehicleFuelLevel;
end;

function TPNetJob.GetVehicleLocation: string;
begin
  result:= Extra.VehicleLocation;
end;

function TPNetJob.GetVehicleMake: string;
begin
  result:= self.ManufactureName;
end;

function TPNetJob.GetVehicleMonthOfManufacture: integer;
begin
  result := MonthOf(self.Year);
end;

function TPNetJob.GetVehicleNumberOfCylinders: string;
begin
  result := Extra.VehicleNumberOfCylinders;
end;

function TPNetJob.GetVehicleOdometer: integer;
begin
  result := Extra.VehicleOdometer;
end;

function TPNetJob.GetVehicleOldDamageDescription: string;
begin
  result := Extra.VehicleOldDamageDescription;
end;

function TPNetJob.GetVehicleRegistration: string;
begin
  result := self.JobRegistration;
end;

function TPNetJob.GetVehicleTransmissionType: string;
begin
  result := Extra.VehicleTransmissionType;
end;

function TPNetJob.GetVehicleVINChassis: string;
begin
  result := self.SerialNumber;
end;

function TPNetJob.GetVehicleYearOfManufacture: integer;
begin
  result:= YearOf(self.Year);
end;

function TPNetJob.GetWorkLocation: string;
begin
  result := Extra.WorkLocation;
end;

procedure TPNetJob.SetBayNumber(const Value: string);
begin
  Extra.BayNumber := Value;
end;

procedure TPNetJob.SetClaimCustomerBusinessPhoneNumber(const Value: string);
begin
  self.Phone := Value;
end;

procedure TPNetJob.SetClaimCustomerCompanyName(const Value: string);
begin
  Extra.CustomerCompanyName:= Value;
end;

procedure TPNetJob.SetClaimCustomerFirstName(const Value: string);
begin
  self.FirstName := Value;
end;

procedure TPNetJob.SetClaimCustomerPrivatePhoneNumber(const Value: string);
begin
  self.Mobile := Value;
end;

procedure TPNetJob.SetClaimCustomerSurname(const Value: string);
begin
  self.LastName:= Value;
end;

procedure TPNetJob.SetClaimCustomerTitle(const Value: string);
begin
  self.Title:= value;
end;

procedure TPNetJob.SetClaimDescription(const Value: string);
begin
  Extra.ClaimDescription := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetClaimManager(const Value: string);
begin
  Extra.ClaimManager:= Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetOffSiteQuoting(const Value: boolean);
begin
  Extra.OffsiteQuoting := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetOperationalUnit(const Value: string);
begin
  Extra.OperationalUnit := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetPaintType(const Value: string);
begin
  Extra.VehiclePaintType := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetProcessType(const Value: string);
begin
  Extra.ProcessType := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetQuoteDueTime(const Value: TDateTime);
begin
  Extra.QuoteDueTime := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetQuoteRequestNumber(const Value: string);
begin
  JobName:= Value + '-' + IntToStr(QuoteRequestVersionNumber);
end;

procedure TPNetJob.SetQuoteRequestVersionNumber(const Value: integer);
begin
  JobName := QuoteRequestNumber + '-' + IntToStr(Value);
end;

procedure TPNetJob.SetVehicleBodyShape(const Value: string);
begin
  self.BodyType := Value;
end;

procedure TPNetJob.SetVehicleColor(const Value: string);
begin
  self.Colour := Value;
end;

procedure TPNetJob.SetVehicleDamageDescription(const Value: string);
begin
  Extra.VehicleDamageDescription := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleDescription(const Value: string);
begin
  Extra.VehicleDescription := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleFuelLevel(const Value: integer);
begin
  Extra.VehicleFuelLevel := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleLocation(const Value: string);
begin
  Extra.VehicleLocation := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleMake(const Value: string);
begin
  if Trim(Value) <> '' then begin
    if TManufacture.IDToggle(Value, Self.Connection.Connection) > 0 then
      self.ManufactureName := Value
    else begin
      if TManufacture.NewManufacture(Value, Self.Connection.Connection) then
        self.ManufactureName := Value;
    end;
  end
  else
    self.ManufactureName := '';
end;

procedure TPNetJob.SetVehicleMonthOfManufacture(const Value: integer);
var
  yr, mth, day: word;
begin
  if Value = 0 then Exit;
  DecodeDate(self.Year, yr, mth, day);
  try
    self.Year := EncodeDate(yr,Value,day);
  except
    self.Year := EncodeDate(yr,Value,1);
  end;
end;

procedure TPNetJob.SetVehicleNumberOfCylinders(const Value: string);
begin
  Extra.VehicleNumberOfCylinders:= Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleOdometer(const Value: integer);
begin
  Extra.VehicleOdometer := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleOldDamageDescription(const Value: string);
begin
  Extra.VehicleOldDamageDescription := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleRegistration(const Value: string);
begin
  self.JobRegistration := Value;
end;

procedure TPNetJob.SetVehicleTransmissionType(const Value: string);
begin
  Extra.VehicleTransmissionType := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleVINChassis(const Value: string);
begin
  self.SerialNumber := Value;
  FlagAsUpdated;
end;

procedure TPNetJob.SetVehicleYearOfManufacture(const Value: integer);
var
  yr, mth, day: word;
begin
  if Value = 0 then Exit;
  DecodeDate(self.Year, yr, mth, day);
  try
    self.Year := EncodeDate(Value,mth,day);
  except
    self.Year := EncodeDate(Value,mth,1);
  end;
end;

procedure TPNetJob.SetWorkLocation(const Value: string);
begin
  Extra.WorkLocation:= Value;
  FlagAsUpdated;
end;

function TPNetJob.ValidateData: Boolean;
begin
  result := inherited;
  if not result then exit;
  result:= false;
  if self.QuoteRequestNumber = '' then begin
    AddResult(False, rssError, 0, 'Quote Request Number should not be blank.');
    exit;
  end;
  if self.QuoteRequestVersionNumber < 1 then begin
    AddResult(False, rssError, 0, 'Quote Request Version Number should not be blank.');
    exit;
  end;
  if self.ClaimNumber = '' then begin
    AddResult(False, rssError, 0, 'Claim Number should not be blank.');
    exit;
  end;
  if self.ProcessType = '' then begin
    AddResult(False, rssError, 0, 'Process Type should not be blank.');
    exit;
  end;
  if self.OperationalUnit = '' then begin
    AddResult(False, rssError, 0, 'Operational Unit should not be blank.');
    exit;
  end;
  if self.CorporateCustomer = '' then begin
    AddResult(False, rssError, 0, 'Corporate Customer should not be blank.');
    exit;
  end;
  if (self.ClaimCustomerSurname = '') and (self.ClaimCustomerCompanyName = '') then begin
    AddResult(False, rssError, 0, 'Claim Customer  Surname and Company Name are both blank, at least one of these must have a value.');
    exit;
  end;


  result:= true;
end;

{ TPNetJobExtra }

constructor TPNetJobExtra.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'PNetJob';
  fSQL := 'SELECT * FROM pnetjob';
end;

destructor TPNetJobExtra.Destroy;
begin

  inherited;
end;

function TPNetJobExtra.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
end;

procedure TPNetJobExtra.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TPNetJobExtra.GetBayNumber: string;
begin
  result := GetStringField('BayNumber');
end;

class function TPNetJobExtra.GetBusObjectTablename: string;
begin
  result := 'PNetJob';
end;

function TPNetJobExtra.GetClaimDescription: string;
begin
  result := GetStringField('ClaimDescription');
end;

function TPNetJobExtra.GetClaimManager: string;
begin
  result := GetStringField('ClaimManager');
end;

function TPNetJobExtra.GetCustomerCompanyName: string;
begin
  result := GetStringField('CustomerCompanyName');
end;

function TPNetJobExtra.GetExtraQuoteInformationRequested: boolean;
begin
  result := GetBooleanField('ExtraQuoteInformationRequested');
end;

class function TPNetJobExtra.GetIDField: string;
begin
  result := 'JobID';
end;

function TPNetJobExtra.GetJobID: integer;
begin
  result := GetIntegerField('JobID');
end;

function TPNetJobExtra.GetOffsiteQuoting: boolean;
begin
  result := GetBooleanField('OffsiteQuoting');
end;

function TPNetJobExtra.GetOperationalUnit: string;
begin
  result := GetStringField('OperationalUnit');
end;

function TPNetJobExtra.GetProcessType: string;
begin
  result := GetStringField('ProcessType');
end;

function TPNetJobExtra.GetQuoteDueTime: TDateTime;
begin
  result := GetDateTimeField('QuoteDueTime');
end;

function TPNetJobExtra.GetQuotingMethodIndicator: string;
begin
  result := GetStringField('QuotingMethodIndicator');
end;

function TPNetJobExtra.GetSQL: string;
begin
  result:= inherited;
end;

function TPNetJobExtra.GetVehicleDamageDescription: string;
begin
  result := GetStringField('VehicleDamageDescription');
end;

function TPNetJobExtra.GetVehicleDescription: string;
begin
  result := GetStringField('VehicleDescription');
end;

function TPNetJobExtra.GetVehicleFuelLevel: integer;
begin
  result := GetIntegerField('VehicleFuelLevel');
end;

function TPNetJobExtra.GetVehicleLocation: string;
begin
  result := GetStringField('VehicleLocation');
end;

function TPNetJobExtra.GetVehicleNumberOfCylinders: string;
begin
  result := GetStringField('VehicleNumberOfCylinders');
end;

function TPNetJobExtra.GetVehicleOdometer: integer;
begin
  result := GetIntegerField('VehicleOdometer');
end;

function TPNetJobExtra.GetVehicleOldDamageDescription: string;
begin
  result := GetStringField('VehicleOldDamageDescription');
end;

function TPNetJobExtra.GetVehiclePaintType: string;
begin
  result := GetStringField('VehiclePaintType');
end;

function TPNetJobExtra.GetVehicleTransmissionType: string;
begin
  result := GetStringField('VehicleTransMissionType');
end;

function TPNetJobExtra.GetWorkLocation: string;
begin
  result := GetStringField('WorkLocation');
end;

procedure TPNetJobExtra.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TPNetJobExtra.Save: Boolean;
begin
  result:= inherited;
end;

procedure TPNetJobExtra.SetBayNumber(const Value: string);
begin
  SetStringField('BayNumber',Value);
end;

procedure TPNetJobExtra.SetClaimDescription(const Value: string);
begin
  SetStringField('ClaimDescription',Value);
end;

procedure TPNetJobExtra.SetClaimManager(const Value: string);
begin
  SetStringField('ClaimManager',Value);
end;

procedure TPNetJobExtra.SetCustomerCompanyName(const Value: string);
begin
  SetStringField('CustomerCompanyName',Value);
end;

procedure TPNetJobExtra.SetExtraQuoteInformationRequested(const Value: boolean);
begin
  SetBooleanField('ExtraQuoteInformationRequested',Value);
end;

procedure TPNetJobExtra.SetJobID(const Value: integer);
begin
  SetIntegerField('JobID',Value);
end;

procedure TPNetJobExtra.SetOffsiteQuoting(const Value: boolean);
begin
  SetBooleanField('OffsiteQuoting',Value);
end;

procedure TPNetJobExtra.SetOperationalUnit(const Value: string);
begin
  SetStringField('OperationalUnit',Value);
end;

procedure TPNetJobExtra.SetProcessType(const Value: string);
begin
  SetStringField('ProcessType',Value);
end;

procedure TPNetJobExtra.SetQuoteDueTime(const Value: TDateTime);
begin
  SetDateTimeField('QuoteDueTime',Value);
end;

procedure TPNetJobExtra.SetQuotingMethodIndicator(const Value: string);
begin
  SetStringField('QuotingMethodIndicator',Value);
end;

procedure TPNetJobExtra.SetVehicleDamageDescription(const Value: string);
begin
  SetStringField('VehicleDamageDescription',Value);
end;

procedure TPNetJobExtra.SetVehicleDescription(const Value: string);
begin
  SetStringField('VehicleDescription',Value);
end;

procedure TPNetJobExtra.SetVehicleFuelLevel(const Value: integer);
begin
  SetIntegerField('VehicleFuelLevel',Value);
end;

procedure TPNetJobExtra.SetVehicleLocation(const Value: string);
begin
  SetStringField('VehicleLocation',Value);
end;

procedure TPNetJobExtra.SetVehicleNumberOfCylinders(const Value: string);
begin
  SetStringField('VehicleNumberOfCylinders',Value);
end;

procedure TPNetJobExtra.SetVehicleOdometer(const Value: integer);
begin
  SetIntegerField('VehicleOdometer',Value);
end;

procedure TPNetJobExtra.SetVehicleOldDamageDescription(const Value: string);
begin
  SetStringField('VehicleOldDamageDescription',Value);
end;

procedure TPNetJobExtra.SetVehiclePaintType(const Value: string);
begin
  SetStringField('VehiclePaintType',Value);
end;

procedure TPNetJobExtra.SetVehicleTransmissionType(const Value: string);
begin
  SetStringField('VehicleTransmissionType',Value);
end;

procedure TPNetJobExtra.SetWorkLocation(const Value: string);
begin
  SetStringField('WorkLocation',Value);
end;

function TPNetJobExtra.ValidateData: Boolean;
begin
  result := true;
end;

initialization
  RegisterClass(TPNetJob);

end.
