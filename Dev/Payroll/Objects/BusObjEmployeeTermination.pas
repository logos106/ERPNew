unit BusObjEmployeeTermination;

interface

uses
  BusObjBase, DB, Classes, MyAccess, ERPdbComponents, BusObjPaybase,
  XMLDoc, XMLIntf, JsonObject;

(*
   Detaild Lines are Json arrays of Json Objects with the following structure

   {
     "Caption":"Pre 18 Aug 1983",
     "Note":"Portion of annual leave accrued prior to 18 Aug 1983";
     "Amount":0,
     "LeaveLoading":0,
     "Total":0,
     "TaxWithheld":0
   }



*)



type
  TEmployeeTermination = class(TMSBusObj)
  private
    TableUpdated: boolean;
    fPay: TPayBase;
    function GetComplete: boolean;
    function getDeleted: boolean;
    function getEmployeeid: Integer;
    function getEmployeename: String;
    function getEnddate: TDatetime;
    function getPayID: Integer;
    function getReasonleft: String;
    function getStartdate: TDatetime;
    procedure SetComplete(const Value: boolean);
    procedure SetDeleted(const Value: boolean);
    procedure SetEmployeeid(const Value: Integer);
    procedure SetEmployeename(const Value: String);
    procedure SetEnddate(const Value: TDatetime);
    procedure SetPayID(const Value: Integer);
    procedure SetReasonleft(const Value: String);
    procedure SetStartdate(const Value: TDatetime);
    function GetCalcData: string;
    procedure SetCalcData(const Value: string);
    function GetTerminationReasonsCommaText: string;
    function GetTerminationReasonNote: string;
    function GetResident: boolean;
    function GetTaxFileNumberProvided: boolean;
    procedure SetResident(const Value: boolean);
    procedure SetTaxFileNumberProvided(const Value: boolean);
    function GetDeathBenefitPaidToCommaText: string;
    function GetDeathBenefit: boolean;
    function GetTypeOfDeathBenefit: string;
    procedure SetDeathBenefit(const Value: boolean);
    procedure SetTypeOfDeathBenefit(const Value: string);
    function GetPayEntitled: boolean;
    procedure SetPayEntitled(const Value: boolean);
    function GetPay: TPayBase;
  protected
    function  DoBeforeOpen(Sender :TDatasetBusObj ): boolean; override;
    function  DoAfterOpen(Sender :TDatasetBusObj ): boolean; override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
//    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): boolean; override;
    procedure LoadEmployeeDetails(aEmployeeName: string);
    procedure CalculateAnnualLeave;
  public
    Json: TJsonObject;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure New; override;
    function ValidateData: boolean; Override;
    function Save: boolean; Override;
    procedure DoFieldOnChange(Sender: TField); override;
    property TerminationReasonsCommaText: string read GetTerminationReasonsCommaText;
    property TerminationReasonNote: string read GetTerminationReasonNote;
    property DeathBenefitPaidToCommaText: string read GetDeathBenefitPaidToCommaText;
    property Pay: TPayBase read GetPay;
//    procedure Load(Const aId: Integer; const fIsReadonly: boolean = False); override;
  published
    property EmployeeId: Integer Read getEmployeeid Write SetEmployeeid;
    property EmployeeName: String Read getEmployeename Write SetEmployeename;
    property StartDate: TDatetime Read getStartdate Write SetStartdate;
    property EndDate: TDatetime Read getEnddate Write SetEnddate;
    property ReasonLeft: String Read getReasonleft Write SetReasonleft;
    property PayID: Integer Read getPayID Write SetPayID;
    property Deleted: boolean Read getDeleted Write SetDeleted;
    property Complete: boolean read GetComplete write SetComplete;
    property CalcData: string read GetCalcData write SetCalcData;
    property TaxFileNumberProvided: boolean read GetTaxFileNumberProvided write SetTaxFileNumberProvided;
    property Resident: boolean read GetResident write SetResident;
    property TypeOfDeathBenefit: string read GetTypeOfDeathBenefit write SetTypeOfDeathBenefit;
    property DeathBenefit: boolean read GetDeathBenefit write SetDeathBenefit;
    property PayEntitled: boolean read GetPayEntitled write SetPayEntitled;
  end;

implementation

uses
  CommonDbLib, SysUtils, BusObjEmployee, BusObjConst, BusObjLeaveAccruals;

{ TEmployeeTermination }

procedure TEmployeeTermination.CalculateAnnualLeave;
begin
  if self.EmployeeId > 0 then begin
    { hours of accrued (unpaid) annual leave .. }
    BusObjLeaveAccruals.TLeaveAccruals.TotalAccruedHours(EmployeeID,'Annual Leave', 0, Connection.Connection);
    { convert to days .. }
    { tblEmployeeRates gives hours (Qty) per pay period, tblAwards gives PayPeriod }


  end;
end;

constructor TEmployeeTermination.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TableUpdated := false;
  fPay := nil;
  Json:= TJsonObject.Create;
end;

destructor TEmployeeTermination.Destroy;
begin
  Json.Free;
  inherited;
end;

function TEmployeeTermination.DoAfterOpen(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
  Json.AsString := CalcData;
end;

function TEmployeeTermination.DoAfterPost(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
end;

function TEmployeeTermination.DoBeforeOpen(Sender: TDatasetBusObj): boolean;
var
  qry: TERPQuery;
begin
  result := inherited;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLIb.GetSharedMyDacConnection;
    qry.SQL.Add('describe ' + self.TableName);
    qry.Open;
    if not qry.Locate('Field','CalcData',[loCaseInsensitive]) then begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('alter table '+ self.TableName);
      qry.SQL.Add('add column `CalcData` longtext null default null;');
      qry.Execute;
      TableUpdated := true;
    end;
  finally
    qry.Free;
  end;
end;

procedure TEmployeeTermination.DoFieldOnChange(Sender: TField);
begin
  inherited;
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
   if Sysutils.SameText(Sender.FieldName , 'EmployeeName') then begin
     LoadEmployeeDetails(EmployeeName);
   end;
   if Sysutils.SameText(Sender.FieldName , 'ReasonLeft') then begin
     SendEvent(BusObjEvent_Change, 'ReasonLeft', self);
     DeathBenefit := ReasonLeft = 'Death';
   end;
   if Sysutils.SameText(Sender.FieldName , 'IsPayEntitled') then begin
     SendEvent(BusObjEvent_Change, 'PayEntitled', self);
   end;
end;

class function TEmployeeTermination.GetBusObjectTablename: string;
begin
  result := 'tblEmployeeTerminations';
end;

function TEmployeeTermination.GetCalcData: string;
begin
  result := GetStringField('CalcData');
end;

function TEmployeeTermination.GetComplete: boolean;
begin
  result := GetBooleanField('Complete');
end;

function TEmployeeTermination.GetDeathBenefit: boolean;
begin
  result := GetBooleanField('DeathBenefit');
end;

function TEmployeeTermination.GetDeathBenefitPaidToCommaText: string;
begin
  result := 'Trustee,Dependant,"Non Dependant"';
end;

function TEmployeeTermination.GetDeleted: boolean;
begin
  result := GetBooleanField('Deleted');
end;

function TEmployeeTermination.GetEmployeeId: Integer;
begin
  result := GetIntegerField('EmployeeID');
end;

function TEmployeeTermination.GetEmployeeName: String;
begin
  result := GetStringField('EmployeeName');
end;

function TEmployeeTermination.GetEndDate: TDatetime;
begin
  result := GetDateTimeField('EndDate');
end;

class function TEmployeeTermination.GetIDField: string;
begin
  result := 'TerminationID';
end;

function TEmployeeTermination.GetPay: TPayBase;
begin
  if PayID > 0 then begin
    if not Assigned(fPay) then begin
      fPay:= TPayBase.Create(self);
      fPay.Connection := self.Connection;
      fPay.Load(PayID);
    end
    else begin
      if fPay.ID <> PayID then
        fPay.Load(PayID);
    end;
  end
  else begin
    if Assigned(fPay) then begin
      fPay.Free;
      fPay:= nil;
    end;
  end;
  result := fPay;
end;

function TEmployeeTermination.GetPayEntitled: boolean;
begin
  result:= GetBooleanField('IsPayEntitled');
end;

function TEmployeeTermination.GetPayID: Integer;
begin
  result := GetIntegerField('PayID');
end;

function TEmployeeTermination.GetReasonLeft: String;
begin
  result := GetStringField('ReasonLeft');
end;

function TEmployeeTermination.GetResident: boolean;
begin
  result:= Json.B['Resident'];
end;

function TEmployeeTermination.GetStartDate: TDatetime;
begin
  result := GetDateTimeField('StartDate');
end;

function TEmployeeTermination.GetTaxFileNumberProvided: boolean;
begin
  result:= Json.B['TFNProvided'];
end;

function TEmployeeTermination.GetTerminationReasonNote: string;
begin
  if SameText(ReasonLeft,'Death') then
    result := ''
  else if SameText(ReasonLeft,'Dismissal') then
    result := ''
  else if SameText(ReasonLeft,'Early Retirement') then
    result := 'Approved early retirement scheme.'
  else if SameText(ReasonLeft,'Employee Left') then
    result := ''
  else if SameText(ReasonLeft,'Invalidity') then
    result := 'Employee can no longer work due to physical or mental ill-health.'
  else if SameText(ReasonLeft,'Redundancy') then
    result := 'Employees job has been abolished.'
  else if SameText(ReasonLeft,'Retirement') then
    result := ''
  else
    result := '';
end;

function TEmployeeTermination.GetTerminationReasonsCommaText: string;
begin
  result :=
    'Death,Dismissal,"Early Retirement","Employee Left",Invalidity,Redundancy,Retirement';
end;

function TEmployeeTermination.GetTypeOfDeathBenefit: string;
begin
  result:= GetStringField('TypeOfDeathBenefit');
end;

procedure TEmployeeTermination.LoadEmployeeDetails(aEmployeeName: string);
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= Self.Connection.Connection;
    qry.SQL.Add('select * from tblEmployees where EmployeeName = ' + QuotedStr(aEmployeeName));
    qry.Open;
    if not qry.IsEmpty then begin
      EmployeeID := qry.FieldByName('EmployeeID').AsInteger;
      TaxFileNumberProvided :=  qry.FieldByName('TFN').AsString <> '';
      Resident := qry.FieldByName('Resident').AsBoolean;
      StartDate := qry.FieldByName('DateStarted').AsDateTime;
    end;
  finally
    qry.Free;
  end;
end;

procedure TEmployeeTermination.New;
begin
  inherited;
  Json.Clear;
end;

//procedure TEmployeeTermination.Load(const aId: Integer; const fIsReadonly: boolean);
//begin
//  inherited;
//
//end;

procedure TEmployeeTermination.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  SendEvent(BusObjEvent_OnDataIDChange, DataChangeTypeToStr(ChangeType), self);
end;

function TEmployeeTermination.Save: boolean;
begin
  resultStatus.Clear;
  result := ValidateData;
  if result then
    result := inherited;
end;

procedure TEmployeeTermination.SetCalcData(const Value: string);
begin
  SetStringField('CalcData', Value);
end;

procedure TEmployeeTermination.SetComplete(const Value: boolean);
begin
  SetBooleanField('Complete',Value);
  SendEvent(BusObjEvent_Change, 'Complete', self);
end;

procedure TEmployeeTermination.SetDeathBenefit(const Value: boolean);
begin
  SetBooleanField('DeathBenefit',Value);
  SendEvent(BusObjEvent_Change, 'DeathBenefit', self);
end;

procedure TEmployeeTermination.SetDeleted(const Value: boolean);
begin
  SetBooleanField('Deleted',Value);
  SendEvent(BusObjEvent_Change, 'Deleted', self);
end;

procedure TEmployeeTermination.SetEmployeeId(const Value: Integer);
begin
  SetIntegerField('EmployeeID',Value);
  SendEvent(BusObjEvent_Change, 'EmployeeID', self);
end;

procedure TEmployeeTermination.SetEmployeeName(const Value: String);
begin
  SetStringField('EmployeeName',Value);
  SendEvent(BusObjEvent_Change, 'EmployeeName', self);
end;

procedure TEmployeeTermination.SetEndDate(const Value: TDatetime);
begin
  SetDateTimeField('EndDate',Value);
  SendEvent(BusObjEvent_Change, 'EndDate', self);
end;

procedure TEmployeeTermination.SetPayEntitled(const Value: boolean);
begin
  SetBooleanField('IsPayEntitled', Value);
  SendEvent(BusObjEvent_Change, 'PayEntitled', self);
end;

procedure TEmployeeTermination.SetPayID(const Value: Integer);
begin
  SetIntegerField('PayID',Value);
  SendEvent(BusObjEvent_Change, 'PayID', self);
end;

procedure TEmployeeTermination.SetReasonleft(const Value: String);
begin
  SetStringField('ReasonLeft',Value);
  SendEvent(BusObjEvent_Change, 'ReasonLeft', self);
end;

procedure TEmployeeTermination.SetResident(const Value: boolean);
begin
  Json.B['Resident'] := Value;
  SendEvent(BusObjEvent_Change, 'Resident', self);
end;

procedure TEmployeeTermination.SetStartDate(const Value: TDatetime);
begin
  SetDateTimeField('StartDate',Value);
  SendEvent(BusObjEvent_Change, 'StartDate', self);
end;

procedure TEmployeeTermination.SetTaxFileNumberProvided(const Value: boolean);
begin
  Json.B['TFNProvided'] := Value;
  SendEvent(BusObjEvent_Change, 'TaxFileNumberProvided', self);
end;

procedure TEmployeeTermination.SetTypeOfDeathBenefit(const Value: string);
begin
  SetStringField('TypeOfDeathBenefit',Value);
  SendEvent(BusObjEvent_Change, 'TypeOfDeathBenefit', self);
end;

function TEmployeeTermination.ValidateData: boolean;
begin
  result := inherited;
end;

initialization
  RegisterClass(TEmployeeTermination);

end.
