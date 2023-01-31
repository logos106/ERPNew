unit PayEmployeeSettingsObj;

interface

uses
  Classes, DB;

type
  TEmployeeSettings = class(TObject)
  private
    foOwner: TObject;
    fiAward: integer;
    fiAwardSickDayThreshold:integer;
    fiTaxScale: integer;
    fsPayPeriod: string; {Weekly,Fortnightly,Monthly,Bi-Monthly,None}
    fiPayPeriodThisYear: integer;
    fsTFN: string;
    fbHECS: boolean;
    fbSFSS: boolean;
    fiWorkCover: integer;
    fsEmploymentBasis: string; {F,P,C,L,S = Full Time ,Part Time,Casual,Labour Hire,Superannuation Pension or Annuity }
    fdLastPaid: TDateTime;
    fiLastPayPeriod: integer;
    fiClassID: integer;
    fdLeaveLoading: double;
    fsExtraTaxOption: string; {"$,%,Fixed"}
    fdExtraTax: double;
    fsUseClassificationAdvance: string;
    fbPaySuperOnLeaveLoading: boolean;
    fbSendPaySlipViaEmail: string;
    procedure SetLastPaidDate(const sValue: TDateTime);
    procedure SetLastPayPeriod(const sValue: integer);
  public
    procedure PopulateMe;
    constructor Create(const Owner: TObject);
    property Owner: TObject read foOwner;
    property Award: integer read fiAward;
    property AwardSickDayThreshold: integer read fiAwardSickDayThreshold;
    property TaxScale: integer read fiTaxScale;
    property PayPeriod: string read fsPayPeriod;
    property TFN: string read fsTFN;
    property HECS: boolean read fbHECS;
    property SFSS: boolean read fbSFSS;
    property WorkCover: integer read fiWorkCover;
    property EmploymentBasis: string read fsEmploymentBasis;
    property LastPaid: TDateTime read fdLastPaid write SetLastPaidDate;
    property LastPayPeriod: integer read fiLastPayPeriod write SetLastPayPeriod;
    property ClassID: integer read fiClassID;
    property LeaveLoading: double read fdLeaveLoading;
    property PayPeriodsThisYear: integer read fiPayPeriodThisYear;
    property ExtraTaxOption: string read fsExtraTaxOption;
    property ExtraTax: double read fdExtraTax;
    property UseClassificationAdvance: string read fsUseClassificationAdvance;
    property PaySuperOnLeaveLoading: boolean read fbPaySuperOnLeaveLoading;
    property SendPaySlipViaEmail: string read fbSendPaySlipViaEmail;
  end;

implementation
  
uses FastFuncs,PayCommon, PayObj, SysUtils, DateUtils,CommonDBLib,MyAccess;

{ TEmployeeSettings }

constructor TEmployeeSettings.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
end;

procedure TEmployeeSettings.PopulateMe;
var
  qryAwardDetails: TMyQuery;

  procedure FindAwardDetails;
  begin
    with qryAwardDetails do begin
      Sql.Add('SELECT AwardID,SickLeaveDaysThreshold FROM tblAwards WHERE AwardID = :xAwardID');
      Params.ParamByName('xAwardID').AsInteger := fiAward;
      Open;
    end;
  end;
begin
  if DatasetOk(TPayObj(Self.Owner).Employee.DataSet) then begin
    with TPayObj(Self.Owner).Employee.DataSet do begin
      fiAward := FieldByName('Award').AsInteger;
      fiTaxScale := FieldByName('TaxScaleID').AsInteger;
      fsPayPeriod := FastFuncs.Trim(FieldByName('PayPeriod').AsString);
      fsTFN := FastFuncs.Trim(FieldByName('TFN').AsString);
      fbHECS := FieldByName('HECSIndicator').AsBoolean;
      fbSFSS := FieldByName('StudentLoanIndicator').AsBoolean;
      fiWorkCover := FieldByName('WorkcoverID').AsInteger;
      fsEmploymentBasis := FieldByName('BasisOfPayment').AsString;
      fdLastPaid := FieldByName('LastPaid').AsDateTime;
      if (fdLastPaid = 0) then fdLastPaid := IncDay(TPayObj(Self.Owner).Employee.EmployeeDetails.DateStarted, - 1); //inc -1 so 1st day doesn't get inc'd +1 off later
      fiLastPayPeriod := FieldByName('LastPayPeriod').AsInteger;
      if (fiLastPayPeriod = 0) then fiLastPayPeriod := 1;
      fiClassID := FieldByName('Department').AsInteger;
      fdLeaveLoading := FieldByName('LeaveLoading').AsFloat / 100;
      if fsPayPeriod = 'Weekly' then begin
        fiPayPeriodThisYear := 52;
      end else if fsPayPeriod = 'Fortnightly' then begin
        fiPayPeriodThisYear := 26;
      end else if fsPayPeriod = 'Monthly' then begin
        fiPayPeriodThisYear := 12;
      end else if fsPayPeriod = 'Bi-Monthly' then begin
        fiPayPeriodThisYear := 24;
      end else begin
        fiPayPeriodThisYear := 52;
      end;
      fsExtraTaxOption := FieldByName('ExtraTaxOptions').AsString;
      fdExtraTax := FieldByName('ExtraTax').AsFloat;
      fsUseClassificationAdvance := FieldByName('UseClassificationAdvance').AsString;
      fbPaySuperOnLeaveLoading := GetPaySuperOnLeaveLoading(TPayObj(Self.Owner).Employee.EmployeeID);
      fbSendPaySlipViaEmail := FieldByName('SendPaySlipViaEmail').AsString;
    end;
  end;
    qryAwardDetails := TMyQuery.Create(nil);

  try
    qryAwardDetails.Options.FlatBuffers := True;
    qryAwardDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
    FindAwardDetails;
    If not qryAwardDetails.FieldByName('SickLeaveDaysThreshold').IsNull then
      fiAwardSickDayThreshold := qryAwardDetails.FieldByName('SickLeaveDaysThreshold').asInteger
    else
      fiAwardSickDayThreshold := 10000;
  finally
    FreeAndNil(qryAwardDetails);
  end;
end;

procedure TEmployeeSettings.SetLastPaidDate(const sValue: TDateTime);
begin
  if DatasetOk(TPayObj(Self.Owner).Employee.DataSet) then begin
    with TPayObj(Self.Owner).Employee.DataSet do begin
      Edit;
      FieldByName('LastPaid').AsDateTime := sValue;
      Post;
    end;
    PopulateMe;
  end;
end;

procedure TEmployeeSettings.SetLastPayPeriod(const sValue: integer);
begin
  if DatasetOk(TPayObj(Self.Owner).Employee.DataSet) then begin
    with TPayObj(Self.Owner).Employee.DataSet do begin
      Edit;
      FieldByName('LastPayPeriod').AsInteger := sValue;
      Post;
    end;
    PopulateMe;
  end;
end;

end.
