unit PayPreferencesObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/12/05  1.00.01 AL   Chenged from TAccessLevelObj = class(TObject)
                                  to TAccessLevelObj = class(TComponent)
                                RegisterClass only works with TPersistent
 12/10/06  1.00.02 DSP  Added access to tbldbpreferences using TPrefConvert.

}

{$I ERP.inc}

interface

uses
  Classes, DB, MyAccess,ERPdbComponents, CompanyPrefObj;

type
  TPayPreferencesObj = class(TObject)
  private
    fPrefConvert: TPrefConvert;
    qryPrefs: TERPQuery;
    fbPayByDepartment: boolean;
    fdDefaultSuperRate: double;
    fbPaySuperToOver70: boolean;
    fbPayUnder18: boolean;
    fiWageAccountID: integer;
    fiLiabilityAccountID: integer;
    fiLeaveLiabilityAccountID: integer;
    fiDeductionLiabilityAccountID: integer;
    fiAllowanceLiabilityAccountID: integer;
    fiPAYGTaxPayableAccountID: integer;


    fiSuperPayableAccountID: integer;
    fiDeductionsPaidAccountID: integer;
    fiAllowancePaidAccountID: integer;
    fiLeaveProvisionAccountID: integer;
    fiSundriesPaidAccountID: integer;
    fiCommissionPaidAccountID: integer;
    fiSuperPaidAccountID: integer;
    fiWagesPaidAccountID: integer;
    fiNetWagesAccountID:integer;

    fbMonthSuperTPermanent: boolean;
    fbMonthSuperTPartTime: boolean;
    fbMonthSuperTCasual: boolean;
    fbCalcSGCOnSS: boolean;
    fbExcludeSuperFromWC: boolean;
    fdSuperOverGross: double;
    fdEmployerSGCPercent: double;
    fbRDOAccrueDuringAL: boolean;
    fbRDOAccrueDuringSick: boolean;
    fbRDOAccrueDuringUL: boolean;
    fbLeaveAccrueDuringAL: boolean;
    fbLeaveAccrueDuringSick: boolean;
    fbLeaveAccrueDuringUL: boolean;
    fbAddToEFT: boolean;
    fbUseEmployeeServiceAsEmployeeCost: boolean;
    fbTimesheetIsDoneOnInvoice: boolean;
    fbSummariseTSForInvoiceCost: boolean;
    fbIncZeroPayRates:boolean;

    fbShowAccruedAnnualLeaveLiability: boolean;
    fbShowAccruedSickLeaveLiability: boolean;
    fbShowAccruedLongServiceLeaveLiability: boolean;

    fbShowAccruedAnnualLeavePaySlip: boolean;
    fbShowAccruedSickLeavePaySlip: boolean;
    fbShowAccruedLongServiceLeavePaySlip: boolean;


    fPaySuperOnLumpSumD: boolean;
    fLumpSumDPaidAccountID: integer;
    fOzEdiClientID: string;
    fSoftwareInformationBusinessManagementSystemId: string;
    fOzEDITestMode: boolean;
    fSTPDatesinUTCFormat: boolean;
    procedure SetSoftwareInformationBusinessManagementSystemId(const Value: string);

  Protected
    function FieldByName(const FieldName: string): TPrefConvert;
  public
    constructor Create;
    destructor Destroy; override;
    function PopulateMe: boolean;
    function PayrollAccountsExist(const bSilence: boolean): boolean;
    property BankAccountID: integer read fiWageAccountID;
    property LiabilityAccountID: integer read fiLiabilityAccountID;
    property LeaveLiabilityAccountID: integer read fiLeaveLiabilityAccountID;
    property DeductionLiabilityAccountID: integer read fiDeductionLiabilityAccountID;
    property AllowanceLiabilityAccountID: integer read fiAllowanceLiabilityAccountID;
    property PAYGTaxPayableAccountID: integer read fiPAYGTaxPayableAccountID;


    property SuperPayableAccountID: integer read fiSuperPayableAccountID;
    property NetWagesAccountID: integer read fiNetWagesAccountID;
    property DeductionsPaidAccountID: integer read fiDeductionsPaidAccountID;
    property AllowancePaidAccountID: integer read fiAllowancePaidAccountID;
    property LeaveProvisionAccountID: integer read fiLeaveProvisionAccountID;
    property SundriesPaidAccountID: integer read fiSundriesPaidAccountID;
    property CommissionPaidAccountID: integer read fiCommissionPaidAccountID;
    property SuperPaidAccountID: integer read fiSuperPaidAccountID;
    property GrossWagesAccountID: integer read fiWagesPaidAccountID;

    property MonthSuperTPermanent: boolean read fbMonthSuperTPermanent;
    property MonthSuperTPartTime: boolean read fbMonthSuperTPartTime;
    property MonthSuperTCasual: boolean read fbMonthSuperTCasual;
    property CalcSGCOnSS: boolean read fbCalcSGCOnSS;
    property ExcludeSuperFromWC: boolean read fbExcludeSuperFromWC;
    property SuperOverGross: double read fdSuperOverGross;
    property EmployerSGCPercent: double read fdEmployerSGCPercent;
    property RDOAccrueDuringAL: boolean read fbRDOAccrueDuringAL;
    property RDOAccrueDuringSick: boolean read fbRDOAccrueDuringSick;
    property RDOAccrueDuringUL: boolean read fbRDOAccrueDuringUL;
    property LeaveAccrueDuringAL: boolean read fbLeaveAccrueDuringAL;
    property LeaveAccrueDuringSick: boolean read fbLeaveAccrueDuringSick;
    property LeaveAccrueDuringUL: boolean read fbLeaveAccrueDuringUL;
    property PayByDepartment : boolean read fbPayByDepartment;
    property PaySuperToOver70: boolean read fbPaySuperToOver70;
    property PayUnder18: boolean read fbPayUnder18;
    property DefaultSuperRate: double read fdDefaultSuperRate;
    property AddToEFT: boolean read fbAddToEFT;
    property PaySuperOnLumpSumD: boolean read fPaySuperOnLumpSumD;

    property ShowAccruedAnnualLeaveLiability: boolean read fbShowAccruedAnnualLeaveLiability;
    property ShowAccruedSickLeaveLiability: boolean read fbShowAccruedSickLeaveLiability ;
    property ShowAccruedLongServiceLeaveLiability: boolean read fbShowAccruedLongServiceLeaveLiability ;

    property ShowAccruedAnnualLeavePaySlip: boolean read fbShowAccruedAnnualLeavePaySlip write fbShowAccruedAnnualLeavePaySlip;
    property ShowAccruedSickLeavePaySlip: boolean read fbShowAccruedSickLeavePaySlip write fbShowAccruedSickLeavePaySlip;
    property ShowAccruedLongServiceLeavePaySlip: boolean read fbShowAccruedLongServiceLeavePaySlip write fbShowAccruedLongServiceLeavePaySlip;

    property UseEmployeeServiceAsEmployeeCost: boolean read fbUseEmployeeServiceAsEmployeeCost;
    property TimesheetIsDoneOnInvoice: boolean read fbTimesheetIsDoneOnInvoice;
    property SummariseTSForInvoiceCost: boolean read fbSummariseTSForInvoiceCost;
    property IncZeroPayRates: boolean read fbIncZeroPayRates;

    property LumpSumDPaidAccountID: integer read fLumpSumDPaidAccountID;

    property OzEdiClientID: string read fOzEdiClientID;
    property SoftwareInformationBusinessManagementSystemId: string read fSoftwareInformationBusinessManagementSystemId write SetSoftwareInformationBusinessManagementSystemId;
    property OzEDITestMode: boolean read fOzEDITestMode;
    property STPDatesinUTCFormat: boolean read fSTPDatesinUTCFormat;
  end;

implementation

uses SysUtils, Dialogs, CommonDbLib, CommonLib, AppEnvironment, tcTypes;

{ TPayPreferencesObj }

constructor TPayPreferencesObj.Create;
begin
  inherited;
  qryPrefs := nil;
  fPrefConvert := TPrefConvert.Create;
end;

destructor TPayPreferencesObj.Destroy;
begin
  FreeAndNil(fPrefConvert);
  inherited;
end;

function TPayPreferencesObj.FieldByName(const FieldName: string): TPrefConvert;
begin
  Result := fPrefConvert;
  fPrefConvert.FoundRecord := False;

  if Assigned(qryPrefs) and (not qryPrefs.IsEmpty) then begin
    fPrefConvert.FoundRecord := qryPrefs.Locate('Name', FieldName, [loCaseInsensitive]);
    fPrefConvert.Query := qryPrefs;
  end;
end;

function TPayPreferencesObj.PayrollAccountsExist(const bSilence: boolean): boolean;
var
  msg: string;
begin
  if fiWageAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Payroll Clearing Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Payroll Crearing Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if fiWagesPaidAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Gross Wages Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Gross Wages Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if fiDeductionLiabilityAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Deduction Liability Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Deduction Liability Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if fiDeductionsPaidAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Deduction Paid Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Deduction Paid Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if fiAllowanceLiabilityAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Allowance Liability Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Allowance Liability Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if fiAllowancePaidAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Allowance Paid Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Allowance Paid Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if fiLeaveLiabilityAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Leave Liability Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Leave Liability Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if fiLeaveProvisionAccountID = 0 then begin
    if not bSilence then begin
      msg:= 'Leave Provision Account has not been assigned.' + #13#10 + #13#10 +
        'Please go to Utilities -> Preferences -> Payroll and select a Leave Provision Account.';
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
  end;

  if AppEnv.RegionalOptions.RegionType <> rAUST then begin

//    if fiPAYGTaxPayableAccountID = 0 then begin
//      if not bSilence then begin
//        msg:= 'Primary Tax Payable Account has not been assigned.' + #13#10 + #13#10 +
//          'Please go to Utilities -> Preferences -> Payroll and select a Federal Tax Payable Account.';
//        CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
//        Result := false;
//        Exit;
//      end;
//    end;
//
//    if PAYGExpenseAccountID = 0 then begin
//      if not bSilence then begin
//        msg:= 'Primary Tax Payed Account has not been assigned.' + #13#10 + #13#10 +
//          'Please go to Utilities -> Preferences -> Payroll and select a Federal Tax Payed Account.';
//        CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
//        Result := false;
//        Exit;
//      end;
//    end;

  end
  else begin

    if fiPAYGTaxPayableAccountID = 0 then begin
      if not bSilence then begin
        msg:= 'PAYG Tax Payable Account has not been assigned.' + #13#10 + #13#10 +
          'Please go to Utilities -> Preferences -> Payroll and select a PAYG Tax Payable Account.';
        CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
        Result := false;
        Exit;
      end;
    end;

(*    if PAYGExpenseAccountID = 0 then begin
      if not bSilence then begin
        msg:= 'PAYG Tax Payed Account has not been assigned.' + #13#10 + #13#10 +
          'Please go to Utilities -> Preferences -> Payroll and select a PAYG Tax Payed Account.';
        CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
        Result := false;
        Exit;
      end;
    end;*)

    if fiSuperPayableAccountID = 0 then begin
      if not bSilence then begin
        msg:= 'Superannuation Liability Account has not been assigned.' + #13#10 + #13#10 +
          'Please go to Utilities -> Preferences -> Payroll and select a Superannuation Liability Account.';
        CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
        Result := false;
        Exit;
      end;
    end;

    if fiSuperPaidAccountID = 0 then begin
      if not bSilence then begin
        msg:= 'Superannuation Paid Account has not been assigned.' + #13#10 + #13#10 +
          'Please go to Utilities -> Preferences -> Payroll and select a Superannuation Paid Account.';
        CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
        Result := false;
        Exit;
      end;
    end;

  end;


  Result := true;
end;

function TPayPreferencesObj.PopulateMe: boolean;
begin
  qryPrefs := TERPQuery.Create(nil);

  try
    qryPrefs.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryPrefs.SQL.Text := 'SELECT * FROM tbldbpreferences';
    qryPrefs.Open;
        fiWageAccountID := FieldByName('WageAccountID').AsInteger;
        fiLiabilityAccountID := FieldByName('LiabilityAccountID').AsInteger;
        fiDeductionLiabilityAccountID := FieldByName('DeductionLiabilityAccountID').AsInteger;
        fiAllowanceLiabilityAccountID := FieldByName('AllowanceLiabilityAccountID').AsInteger;
        fiPAYGTaxPayableAccountID := FieldByName('PAYGTaxPayableAccountID').AsInteger;



        fiLeaveLiabilityAccountID := FieldByName('LeaveLiabilityAccountID').AsInteger;
        fiSuperPayableAccountID := FieldByName('SuperPayableAccountID').AsInteger;
        fiDeductionsPaidAccountID := FieldByName('DeductionsPaidAccountID').AsInteger;
        fiAllowancePaidAccountID := FieldByName('AllowancePaidAccountID').AsInteger;
        fiLeaveProvisionAccountID := FieldByName('LeaveProvisionAccountID').AsInteger;
        fiSuperPaidAccountID := FieldByName('SuperPaidAccountID').AsInteger;
        fiSundriesPaidAccountID := FieldByName('SundriesPaidAccountID').AsInteger;
        fiCommissionPaidAccountID := FieldByName('CommissionPaidAccountID').AsInteger;
        fiWagesPaidAccountID := FieldByName('WagesPaidAccountID').AsInteger;
        fiNetWagesAccountID := FieldByName('NetWagesAccountID').AsInteger;


        fbMonthSuperTPermanent := FieldByName('MonthSuperTPermanent').AsBoolean;
        fbMonthSuperTPartTime := FieldByName('MonthSuperTPartTime').AsBoolean;
        fbMonthSuperTCasual := FieldByName('MonthSuperTCasual').AsBoolean;
        fbCalcSGCOnSS := FieldByName('CalcSGCOnSS').AsBoolean;
        fbExcludeSuperFromWC := FieldByName('ExcludeSuperFromWC').AsBoolean;
        fdSuperOverGross := FieldByName('SuperOverGross').AsFloat;
        fdEmployerSGCPercent := FieldByName('EmployerSGCPercent').AsFloat;
        fbRDOAccrueDuringAL := FieldByName('RDOAccrueDuringAL').AsBoolean;
        fbRDOAccrueDuringSick := FieldByName('RDOAccrueDuringSick').AsBoolean;
        fbRDOAccrueDuringUL := FieldByName('RDOAccrueDuringUL').AsBoolean;
        fbLeaveAccrueDuringAL := FieldByName('LeaveAccrueDuringAL').AsBoolean;
        fbLeaveAccrueDuringSick := FieldByName('LeaveAccrueDuringSick').AsBoolean;
        fbLeaveAccrueDuringUL := FieldByName('LeaveAccrueDuringUL').AsBoolean;
        fbPaySuperToOver70 := FieldByName('PaySuperToOver70').AsBoolean;
        fbPayUnder18 := FieldByName('PayUnder18').AsBoolean;
        fdDefaultSuperRate := FieldByName('DefaultSuperRate').AsFloat;
        fbAddToEFT := FieldByName('AddToEFT').AsBoolean;
        fPaySuperOnLumpSumD  := FieldByName('PaySuperOnLumpSumD').AsBoolean;

        fbShowAccruedAnnualLeaveLiability := FieldByName('ShowAccruedAnnualLeaveLiability').AsBoolean;
        fbShowAccruedSickLeaveLiability := FieldByName('ShowAccruedSickLeaveLiability').AsBoolean;
        fbShowAccruedLongServiceLeaveLiability := FieldByName('ShowAccruedLongServiceLeaveLiability').AsBoolean;

        fbShowAccruedAnnualLeavePaySlip := FieldByName('ShowAccruedAnnualLeavePaySlip').AsBoolean;
        fbShowAccruedSickLeavePaySlip := FieldByName('ShowAccruedSickLeavePaySlip').AsBoolean;
        fbShowAccruedLongServiceLeavePaySlip := FieldByName('ShowAccruedLongServiceLeavePaySlip').AsBoolean;

        fbUseEmployeeServiceAsEmployeeCost := FieldByName('UseEmpServiceAsEmpCost').AsBoolean;
        fbTimesheetIsDoneOnInvoice := FieldByName('TSDoneOnInvoice').AsBoolean;
        fbSummariseTSForInvoiceCost := FieldByName('SummariseTSForInvoiceCost').AsBoolean;
        fbPayByDepartment := FieldByName('PayByDepartment').AsBoolean;
        fbIncZeroPayRates := FieldByName('IncZeroPayRates').AsBoolean;

        fLumpSumDPaidAccountID := FieldByName('LumpSumDPaidAccountID').AsInteger;
        fOzEdiClientID := FieldByName('OzEdiClientID').AsString;
        fSoftwareInformationBusinessManagementSystemId := FieldByName('SoftwareInformationBusinessManagementSystemId').AsString;
        fOzEDITestMode := FieldByName('OzEDITestMode').AsBoolean;
        fSTPDatesinUTCFormat := True;//preference removed // FieldByName('STPDatesinUTCFormat').AsBoolean;
   finally
     FreeAndNil(qryPrefs);
   end;

  Result := true;

  if not PayrollAccountsExist(false) then begin
    Result := false;
    Exit;
  end;
end;

procedure TPayPreferencesObj.SetSoftwareInformationBusinessManagementSystemId(
  const Value: string);
begin
  fSoftwareInformationBusinessManagementSystemId := Value;
  FieldByName('SoftwareInformationBusinessManagementSystemId').AsString := Value;
end;

end.
