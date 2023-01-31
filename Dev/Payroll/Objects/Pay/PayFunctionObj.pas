unit PayFunctionObj;

{  Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/06/05  1.00.01 IJB  Modified LoadTimeSheet to populate new field
                        tblPaysPayRates.TimeSheetId.
 09/01/06  1.00.02 DSP  Changed PrintPaySlip to use TReportTemplates in place
                        of TTemplates.
 20/02/06  1.00.03 DSP  Added password to email authentication.
 06/11/06  1.00.04  BJ  Email sender object using the default properties.
}

{$I Platinum1.inc}

interface

Uses
  Classes,DB, Controls,Dialogs,PayObj,EmailUtils,Windows,AbZipKit,kbmMemTable,XMLIntf,
  IdComponent,IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdBaseComponent, IdMessage,XMLDoc;

Type
  TempAccRec = class(TObject)
  Public
    OpenningBalanceHrs: double;
    OpenningBalanceDate:  TDateTime;
    AccruedHours: double;
    AccruedDate:  TDateTime;
    EmpNo:        Integer;
    UseStartEndDates: string;
    StartDate: TDateTime;
    EndDate: TDateTime;

  end;

type
  pTimesRec = ^TTimesRec;
  TTimesRec = record
    iEmployeeID: integer;
    dtStart: TDateTime;
    dtEnd: TDateTime;
    bMatched: boolean;
  end;

type
  pLeaveRec = ^TLeaveRec;
  TLeaveRec = record
    dtDate: TDateTime;
    sLeave: string;
    dTotHrs: double;
  end;

  TPayFunctionObj = class(TObject)
  Private
    TempPay: TPayObj;
    AbZipKit: TAbZipKit;
    stPlain: TMemoryStream;
    DSPay :TDataset;
    DSPayPayRates :TDataset;
    DSPayDeductions :TDataset;
    DSPayAllowances :TDataset;
    DSPaySundries :TDataset;
    DSPayCommission :TDataset;
    DSPaySuper :TDataset;
    DSEmployee :TDataset;
    DSEmployeePayRates :TDataset;
    DSEmployeeAllowances :TDataset;
    DSEmployeeDeductions :TDataset;
    DSEmployeeSuper :TDataset;
    DSEmployeeLeave :TDataset;
    DSEmployeeSundries :TDataset;
    DSEmployeeCommission :TDataset;
    DSPaysPayRates:TDataset;
    DSPayPaySplits:TDataset;
    DSPaySplit:TDataset;
    dMealBreakHours, dMealBreakThreshold: double;


    function GetNewUnprocessedPayID(Const iEmployeeID: Integer): Integer;
    procedure LoadPayTables(Const iPayID :Integer;IsVerify:Boolean);
    procedure LoadEmployeePayTables(Const iEmployeeID :Integer);
    procedure DeleteEmployeePayLeave(Const iPayID: Integer);
    procedure DeleteEmployeePayRates(Const iPayID: Integer);
    procedure SetPayObject(EmployeeID: integer);
    procedure DestroyPayObject;
    procedure LoadLeaveFromRoster(iEmpID: integer;iPayID: integer;iClassID: integer;
                                                            dtFrom: TDateTime;dtTo: TDateTime);
    Function GetBankDetailsMemo(Const ThisPay: TPayObj):String;
    function GetEmailAddress(ThisPay:TPayObj):string;

    function GetEmployeeRosterParams(const iEmployeeID: Integer;
       var bLoadHours, bLoadLeave: boolean;
       var dMealBreakHours, dMealBreakThreshold: double): boolean;
    function GetHoursFromRoster(iEmployeeID: integer;
                              dtFrom, dtTo: TDateTime;
                              dMealBreak, dMealBreakThreshold: double; iClassID: Integer): double;
    function GetNormalHoursID:integer;
    procedure CreateTmpTable;
    procedure DestroyTmpTable;
    function CalcBasedOnAmount(const Pay:TPayObj;const sCalcBy:String;const dAmount:double;const iBasedOnID:integer):double;
  Public
    EmpAccRecList: TList;
    FEmailSender: T2cEmailSender;
    constructor Create;  
    destructor Destroy; override;
    function GetUnprocessedPayID(Const iEmployeeID: Integer): Integer;
    function LoadUnprocessedPay(Const iEmployeeID :Integer):TPayObj;
    function LoadEmployeePay(const iEmployeeID: Integer): TPayObj;
    procedure SGCInThisPay(const iPayID: Integer; Var SGC,SGCNoThreshold: Double);

    procedure CreatePay(Const iEmployeeID :Integer);
    procedure DeletePay(Const iPayID :Integer);
    procedure ReallyDeletePay(Const iPayID :Integer);
    procedure ProcessPay(Const iPayID: Integer; Const DatePaid: TDateTime; Const AddtoABA,Preview: Boolean;IsTerminationPay:Boolean);
    procedure VerifyPay(Const iPayID: Integer);
    procedure PrintPaySlip(Const ThisPay: TPayObj; Const Preview: Boolean; Const SendPaySlipViaEmail : String; Const DoEmailSend:Boolean=false);
    procedure PrintUnprocessedPaysReport(Const Preview: Boolean);
    procedure PrintPayHistoryReport(const Preview: Boolean;dtFrom:TDateTime;dtTo:TDateTime);
    procedure LoadRoster;
    procedure LoadTimeSheet;
    procedure SendEmail(Const sEmailFrom,sEmailto,sPassword,sFilename,sSubject,sMessage:string);
    procedure PrintFromDB(Const empName:string; Const Preview: Boolean);
    function GetLeaveLoading(const EmployeeID: integer; const sType:String): double;
    // AWARD
    procedure UpdateEmployeeWithAward(const DS_Award,
                                            DS_AwardLeave,
                                            DS_Classification,
                                            DS_ClassificationAllowances,
                                            DS_ClassificationDeductions,
                                            DS_ClassificationExtraPayRates,
                                            DS_Employee,
                                            DS_EmployeeLeave,
                                            DS_EmployeePayRates,
                                            DS_EmployeeAllowances,
                                            DS_EmployeeDeductions,
                                            DS_EmployeeSuper :TDataset;
                                            Recreate_Unprocessed_Pay:Boolean;
                                            EmployeeID:integer);

  end;

implementation
  uses FastFuncs,SysUtils,MyAccess,CommonDbLib,DateUtils,Math,DnmLib,PayCommon,
       ABAObj, ReportTemplates, Forms, UserLockObj,
       AppEnvironment,tcDataUtils, CommonLib, ppPDFDevice, ppZLib;

{ TPayFunctionObj }
constructor TPayFunctionObj.Create;
begin
  inherited;
  if not Assigned(EmpAccRecList) then begin
    EmpAccRecList := TList.Create;
  end;
  if not Assigned(FEmailSender) then begin
    FEmailSender := T2cEmailSender.Create;
  end;
end;

function TPayFunctionObj.CalcBasedOnAmount(Const Pay:TPayObj;Const sCalcBy:String;Const dAmount:double;Const iBasedOnID:integer):double;
begin
  if sCalcBy = '%' then begin
    case iBasedOnID of
      1: result := dAmount;                                             //None
  //    2:                                                                //Kms
  //    3:                                                                //Items
  //    4:                                                                //Hours
  //    5:                                                                //Day
  //    6:                                                                //Week
      7: result := dAmount * Pay.PayTotals.Wages/100;                     //Pay

      8: result := dAmount * Pay.PayTotals.Wages/100;                   //Wages
  //    9:                                                                //Annual leave
  //    10:                                                               //CDEP payment
  //    11:                                                             //Compensation
      12:  result := dAmount * Pay.PayTotals.Wages/100 * 2;             //Double time
      13:  result := dAmount * Pay.PayTotals.Wages/100 * 2.5;           //Double time + 1/2
  //    14:                                                               //Long service
  //    15:                                                               //meal break
  //    16:                                                               //Normal hours
  //    17:                                                               //normal per item
  //    18:                                                               //Sick Leave
  //    19:                                                               //Special Leave
      20:  result := dAmount * Pay.PayTotals.Wages/100 * 1.25;            //Time + 1/4
      21:  result := dAmount * Pay.PayTotals.Wages/100 * 1.5;             //Time + 1/2
      22:  result := dAmount * Pay.PayTotals.Wages/100 * 1.75;           //Time + 3/4
  //    23:                                                               //Weekend rate
    else
      result := dAmount;
    end;
  end else begin
    result := dAmount;
  end;
end;

procedure TPayFunctionObj.ReallyDeletePay(Const iPayID: Integer);
begin
  ReallyDeletePayRecords('tblpays', iPayID);

  ReallyDeletePayRecords('tblpayspayrates', iPayID);
  ReallyDeletePayRecords('tblpaysallowances', iPayID);
  ReallyDeletePayRecords('tblpaysdeductions', iPayID);
  ReallyDeletePayRecords('tblpayssundries', iPayID);
  ReallyDeletePayRecords('tblpayscommission', iPayID);
  ReallyDeletePayRecords('tblpayssuperannuation', iPayID);
  ReallyDeletePayRecords('tblpaysleave', iPayID);
  ReallyDeletePayRecords('tblleaveaccruals', iPayID);
  ReallyDeletePayRecords('tblpaystransactions', iPayID);
end;

procedure TPayFunctionObj.DeletePay(Const iPayID: Integer);
begin
  DeletePayRecords('tblpays', iPayID);
end;

function TPayFunctionObj.GetUnprocessedPayID(const iEmployeeID: Integer): Integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT PayID FROM tblPays WHERE EmployeeID = '+FastFuncs.IntToStr(iEmployeeID)+' AND Paid = "F"  AND Deleted = "F";');
    qry.Open;
    if qry.RecordCount > 0 then begin
       result := qry.FieldByName('PayID').AsInteger;
    end else begin
       result := 0;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPayFunctionObj.GetNewUnprocessedPayID(const iEmployeeID: Integer): Integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT PayID,EmployeeID,Paid FROM tblPays WHERE EmployeeID = '+FastFuncs.IntToStr(iEmployeeID)+' AND Paid = "F";');
    qry.Open;
    qry.Append;
    qry.FieldByName('EmployeeID').AsInteger := iEmployeeID;
    qry.FieldByName('Paid').AsString := 'F';
    qry.Post;
    qry.RefreshRecord;
    result := qry.FieldByName('PayID').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

destructor TPayFunctionObj.Destroy;
begin
  if Assigned(DSPay) then FreeAndNil(DSPay);
  If Assigned(DSPayPayRates) then FreeAndNil(DSPayPayRates);
  If Assigned(DSPayAllowances) then FreeAndNil(DSPayAllowances);
  If Assigned(DSPayDeductions) then FreeAndNil(DSPayDeductions);
  If Assigned(DSPaySundries) then FreeAndNil(DSPaySundries);
  If Assigned(DSPayCommission) then FreeAndNil(DSPayCommission);
  If Assigned(DSPaySuper) then FreeAndNil(DSPaySuper);
  If Assigned(DSEmployee) then FreeAndNil(DSEmployee);
  If Assigned(DSEmployeePayRates) then FreeAndNil(DSEmployeePayRates);
  If Assigned(DSEmployeeAllowances) then FreeAndNil(DSEmployeeAllowances);
  If Assigned(DSEmployeeDeductions) then FreeAndNil(DSEmployeeDeductions);
  If Assigned(DSEmployeeSundries) then FreeAndNil(DSEmployeeSundries);
  If Assigned(DSEmployeeCommission) then FreeAndNil(DSEmployeeCommission);
  If Assigned(DSEmployeeSuper) then FreeAndNil(DSEmployeeSuper);
  If Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);
  If Assigned(FEmailSender) then FreeAndNil(FEmailSender);
  if Assigned(EmpAccRecList) then begin
    while EmpAccRecList.Count > 0 do begin
      TempAccRec(EmpAccRecList[0]).Free;
      EmpAccRecList.Delete((0));
    end;
  end;
  
  inherited;
end;

procedure TPayFunctionObj.LoadPayTables(Const iPayID :Integer;IsVerify:Boolean);
var
  Pay2: TPayObj;
begin
  Pay2 := TPayObj.Create;
  try
    if Assigned(DSPay) then FreeAndNil(DSPay);
    If Assigned(DSPayPayRates) then FreeAndNil(DSPayPayRates);
    If Assigned(DSPayAllowances) then FreeAndNil(DSPayAllowances);
    If Assigned(DSPayDeductions) then FreeAndNil(DSPayDeductions);
    If Assigned(DSPaySundries) then FreeAndNil(DSPaySundries);
    If Assigned(DSPayCommission) then FreeAndNil(DSPayCommission);
    If Assigned(DSPaySuper) then FreeAndNil(DSPaySuper);
    If Assigned(DSEmployee) then FreeAndNil(DSEmployee);
    If Assigned(DSEmployeePayRates) then FreeAndNil(DSEmployeePayRates);
    If Assigned(DSEmployeeAllowances) then FreeAndNil(DSEmployeeAllowances);
    If Assigned(DSEmployeeDeductions) then FreeAndNil(DSEmployeeDeductions);
    If Assigned(DSEmployeeSuper) then FreeAndNil(DSEmployeeSuper);
    If Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);
    If Assigned(DSPayPaySplits) then FreeAndNil(DSPayPaySplits);
    If Assigned(DSPaySplit) then FreeAndNil(DSPaySplit);

    
    if (IsVerify) and (Pay2.DataXML.PayHasXML(iPayID)) then begin //load tables  from XML
      Pay2.DataXML.CreateAndLoadTmpTables(iPayID);
      DSPay := RetrievePaysDataset('tblpays','PayID',iPayID);
      DSPayPayRates := RetrievePaysDataset('tblpayspayrates','PayID',iPayID);
      DSPayAllowances := RetrievePaysDataset('tblpaysallowances','PayID',iPayID);
      DSPayDeductions := RetrievePaysDataset('tblpaysdeductions','PayID',iPayID);
      DSPaySundries := RetrievePaysDataset('tblpayssundries','PayID',iPayID);
      DSPayCommission := RetrievePaysDataset('tblpayscommission','PayID',iPayID);
      DSPaySuper := RetrievePaysDataset('tblpayssuperannuation','PayID',iPayID);
      DSEmployeeLeave := RetrieveDataset('tmp_tblpaysleave', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployee := RetrieveDataset('tmp_tblEmployees', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeePayRates := RetrieveDataset('tmp_tblemployeepayrates', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeeAllowances := RetrieveDataset('tmp_tblemployeeallowances', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeeDeductions := RetrieveDataset('tmp_tblemployeedeductions', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeeSuper := RetrieveDataset('tmp_tblsuperannuation', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSPayPaySplits := RetrieveDataset('tblpayssplits', 'PayID',iPayID);
    end else begin
      DSPay := RetrievePaysDataset('tblpays','PayID',iPayID);
      DSPayPayRates := RetrievePaysDataset('tblpayspayrates','PayID',iPayID);
      DSPayAllowances := RetrievePaysDataset('tblpaysallowances','PayID',iPayID);
      DSPayDeductions := RetrievePaysDataset('tblpaysdeductions','PayID',iPayID);
      DSPaySundries := RetrievePaysDataset('tblpayssundries','PayID',iPayID);
      DSPayCommission := RetrievePaysDataset('tblpayscommission','PayID',iPayID);
      DSPaySuper := RetrievePaysDataset('tblpayssuperannuation','PayID',iPayID);
      DSEmployeeLeave := RetrieveDataset('tblleave', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployee := RetrieveDataset('tblEmployees', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeePayRates := RetrieveDataset('tblemployeepayrates', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeeAllowances := RetrieveDataset('tblemployeeallowances', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeeDeductions := RetrieveDataset('tblemployeedeductions', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSEmployeeSuper := RetrieveDataset('tblsuperannuation', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
      DSPayPaySplits := RetrieveDataset('tblpayssplits', 'PayID',iPayID);
      DSPaySplit := RetrieveDataset('tblpaysplit', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);
    end;
  finally
    FreeAndNil(Pay2);
  end;
end;

procedure TPayFunctionObj.LoadEmployeePayTables(Const iEmployeeID :Integer);
begin
  If Assigned(DSEmployeeSundries) then FreeAndNil(DSEmployeeSundries);
  If Assigned(DSEmployeeCommission) then FreeAndNil(DSEmployeeCommission);
  If Assigned(DSEmployee) then FreeAndNil(DSEmployee);
  If Assigned(DSEmployeePayRates) then FreeAndNil(DSEmployeePayRates);
  If Assigned(DSEmployeeAllowances) then FreeAndNil(DSEmployeeAllowances);
  If Assigned(DSEmployeeDeductions) then FreeAndNil(DSEmployeeDeductions);
  If Assigned(DSEmployeeSuper) then FreeAndNil(DSEmployeeSuper);
  If Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);

  DSPaySundries := RetrieveDataset('tblemployeesundries','EmployeeID',iEmployeeID);
  DSPayCommission := RetrieveDataset('tblemployeecommission','EmployeeID',iEmployeeID);
  DSEmployee := RetrieveDataset('tblEmployees', 'EmployeeID',iEmployeeID);
  DSEmployeePayRates := RetrieveDataset('tblemployeepayrates', 'EmployeeID',iEmployeeID);
  DSEmployeeAllowances := RetrieveDataset('tblemployeeallowances', 'EmployeeID',iEmployeeID);
  DSEmployeeDeductions := RetrieveDataset('tblemployeedeductions', 'EmployeeID',iEmployeeID);
  DSEmployeeSuper := RetrieveDataset('tblsuperannuation', 'EmployeeID',iEmployeeID);
  DSEmployeeLeave := RetrieveDataset('tblleave', 'EmployeeID',iEmployeeID);
end;

procedure TPayFunctionObj.CreatePay(Const iEmployeeID: Integer);
var
  PayID:Integer;
  iDays:Integer;
  SavedCursor: TCursor;
  Pay: TPayObj;
  bDoAllowance: boolean;
  bDoDeduction: boolean;
  qry:TMyQuery;
begin
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  qry := TMyQuery.create(nil);
  try
   qry.Options.FlatBuffers := True;
   qry.Connection := CommonDbLib.GetSharedMyDacConnection;
   qry.SQL.Clear;
   qry.SQL.Add('SELECT PayID FROM tblPays WHERE EmployeeID = '+FastFuncs.IntToStr(iEmployeeID)+' AND Paid = "F";');
   qry.Open;
   qry.First;
   while not qry.Eof do begin
     ReallyDeletePay(qry.FieldByName('PayID').AsInteger);
     qry.Next;
   end;
  finally
    FreeAndNil(qry);
  end;
  PayID := GetNewUnprocessedPayID(iEmployeeID);
  LoadPayTables(PayID,False);
  //Check Award Advance
  If CheckAwardAdvanceRequiredUpdate(DSEmployee) then Begin
    LoadPayTables(PayID,False);
  end;
  //
  Pay := TPayObj.Create;
  Try
    Pay.Employee.DataSet := DSEmployee;
    Pay.PayRates.DataSet := DSEmployeePayRates;
    Pay.PayPaySplits.DataSet := DSPayPaySplits;
    Pay.PaySplit.DataSet := DSPaySplit;
    Pay.Allowances.DataSet := DSEmployeeAllowances;
    Pay.Deductions.DataSet := DSEmployeeDeductions;
    Pay.Superannuation.DataSet := DSEmployeeSuper;
    Pay.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
    Pay.PaySplit.DataSet := DSPaySplit;
    Pay.Recalc;
    //Create Pay
    DSPay.Edit;
    if FastFuncs.Trim(Pay.Employee.EmployeeSettings.PayPeriod) = '' then Begin
       DSPay.FieldByName('PayDate').AsDateTime := IncDay(Pay.Employee.EmployeeSettings.LastPaid,7*Pay.Employee.EmployeeSettings.LastPayPeriod);
    end else if FastFuncs.Trim(Pay.Employee.EmployeeSettings.PayPeriod) = 'Weekly' then Begin
       DSPay.FieldByName('PayDate').AsDateTime := IncDay(Pay.Employee.EmployeeSettings.LastPaid,7*Pay.Employee.EmployeeSettings.LastPayPeriod);
    end else if FastFuncs.Trim(Pay.Employee.EmployeeSettings.PayPeriod) = 'Fortnightly' then Begin
       DSPay.FieldByName('PayDate').AsDateTime := IncDay(Pay.Employee.EmployeeSettings.LastPaid,14*Pay.Employee.EmployeeSettings.LastPayPeriod);
    end else if FastFuncs.Trim(Pay.Employee.EmployeeSettings.PayPeriod) = 'Monthly' then Begin
       DSPay.FieldByName('PayDate').AsDateTime := IncMonth(Pay.Employee.EmployeeSettings.LastPaid,1*Pay.Employee.EmployeeSettings.LastPayPeriod);
    end else if FastFuncs.Trim(Pay.Employee.EmployeeSettings.PayPeriod) = 'Bi-Monthly' then Begin
       iDays :=  Trunc(DaysInMonth(Pay.Employee.EmployeeSettings.LastPaid)/2); //get approx half month for bi-month case
       DSPay.FieldByName('PayDate').AsDateTime := IncDay(Pay.Employee.EmployeeSettings.LastPaid,iDays*Pay.Employee.EmployeeSettings.LastPayPeriod);
    end;

    DSPay.FieldByName('PayVersion').AsInteger := Trunc(StrValue(ReplaceStr(GetFileVersion(Application.ExeName),'.','')));
    DSPay.FieldByName('EmpName').AsString := Pay.Employee.EmployeeDetails.EmployeeName;
    DSPay.FieldByName('ClassID').AsInteger := Pay.Employee.EmployeeSettings.ClassID;
    DSPay.FieldByName('Class').AsString := GetClassName(Pay.Employee.EmployeeSettings.ClassID);
    DSPay.FieldByName('PayPeriod').AsString := FastFuncs.Trim(Pay.Employee.EmployeeSettings.PayPeriod);
    DSPay.FieldByName('IsTimesheet').AsString := 'F';
    DSPay.FieldByName('CDEPGross').ASFloat := Pay.PayRates.GetBasedOnWage(GetBasedOnID('CDEP Payment'));
    DSPay.FieldByName('Wages').AsFloat := Pay.PayTotals.Wages;
    DSPay.FieldByName('Allowances').AsFloat := Pay.PayTotals.Allowances;
    DSPay.FieldByName('Deductions').AsFloat := Pay.PayTotals.Deduction;
    DSPay.FieldByName('Superannuation').AsFloat := Pay.PayTotals.Superannuation;
    DSPay.FieldByName('Gross').AsFloat := Pay.PayTotals.Gross;
    DSPay.FieldByName('Prepared').AsString := 'F';

    //For Group Cert
    DSPay.FieldByName('AllowancesBeforeTax').AsFloat := Pay.PayTotals.AllowancesBeforeTax;
    DSPay.FieldByName('GrossTaxable').AsFloat := Pay.PayTotals.GrossTaxable;

    DSPay.FieldByName('Net').AsFloat := Pay.PayTotals.Net;
    DSPay.FieldByName('Tax').AsFloat := Pay.PayTotals.Tax;
    DSPay.FieldByName('AnnualLeaveRate').AsFloat := 0.00;
    DSPay.FieldByName('PaySuperOnLeaveLoading').AsBoolean := Pay.Employee.EmployeeSettings.PaySuperOnLeaveLoading;
    DSPay.Post;
    // Add wages etc to tblEmployee
    DSEmployee.Edit;
    DSEmployee.FieldByName('Wages').AsFloat := Pay.PayTotals.Wages;
    DSEmployee.FieldByName('Allowances').AsFloat := Pay.PayTotals.Allowances;
    DSEmployee.FieldByName('Deductions').AsFloat := Pay.PayTotals.Deduction;
    DSEmployee.FieldByName('Super').AsFloat := Pay.PayTotals.Superannuation;
    DSEmployee.FieldByName('Gross').AsFloat := Pay.PayTotals.Gross;
    DSEmployee.FieldByName('Tax').AsFloat := Pay.PayTotals.Net;
    DSEmployee.FieldByName('Net').AsFloat := Pay.PayTotals.Tax;
    DSEmployee.Post;
    // Create new pay rates for this employee
    DSEmployeePayRates.First;
    While not DSEmployeePayRates.Eof Do Begin
      DSPayPayRates.Insert;
      DSPayPayRates.FieldByName('PayID').AsInteger := PayID;
      DSPayPayRates.FieldByName('PayRateID').AsInteger := DSEmployeePayRates.FieldByName('PayRateID').AsInteger;
      DSPayPayRates.FieldByName('TypeID').AsInteger := DSEmployeePayRates.FieldByName('TypeID').AsInteger;
      DSPayPayRates.FieldByName('Qty').AsFloat := DSEmployeePayRates.FieldByName('Qty').AsFloat;
      if FindInSet(GetPayRateType(DSEmployeePayRates.FieldByName('TypeID').AsInteger),'Hourly Rate,CDEP') then begin
        DSPayPayRates.FieldByName('Amount').AsFloat := DSEmployeePayRates.FieldByName('HourlyRate').AsFloat;
      end else begin
        DSPayPayRates.FieldByName('Amount').AsFloat := DSEmployeePayRates.FieldByName('Amount').AsFloat;
      end;
      DSPayPayRates.FieldByName('LineTotal').AsFloat := DSEmployeePayRates.FieldByName('LineTotal').AsFloat;
      DSPayPayRates.FieldByName('SuperInc').AsString := DSEmployeePayRates.FieldByName('Super').AsString;
      DSPayPayRates.FieldByName('ClientID').AsInteger := DSEmployeePayRates.FieldByName('ClientID').AsInteger;
      DSPayPayRates.FieldByName('ClassID').AsInteger := DSEmployeePayRates.FieldByName('ClassID').AsInteger;
      DSPayPayRates.FieldByName('ClassName').AsString := DSEmployeePayRates.FieldByName('ClassName').AsString;
      DSPayPayRates.Post;
      DSEmployeePayRates.Next;
    end;
    // Create new allowances if Dates permit
    DSEmployeeAllowances.First;
    with DSEmployeeAllowances do begin
        if FieldByName('UseStartEndDates').AsString = 'T' then begin
          if FieldByName('StartDate').AsDateTime <> 0 then begin
            if (Pay.PayDate > FieldByName('StartDate').AsDateTime ) and
                   (Pay.PayDate < FieldByName('EndDate').AsDateTime) then begin
              bDoAllowance := true;
            end else begin
              bDoAllowance := false;
            end;
          end else begin
            bDoAllowance := true;   //if date empty go ahead and do allowance
          end;
        end else begin
          bDoAllowance := true;
        end;
    end;
    if bDoAllowance = true then begin
      While not DSEmployeeAllowances.Eof Do Begin
        DSPayAllowances.Insert;
        DSPayAllowances.FieldByName('PayID').AsInteger := PayID;
        DSPayAllowances.FieldByName('AllowanceID').AsInteger := DSEmployeeAllowances.FieldByName('AllowanceID').AsInteger;
        DSPayAllowances.FieldByName('Qty').AsFloat:= DSEmployeeAllowances.FieldByName('Qty').AsFloat;
        DSPayAllowances.FieldByName('BasedOnID').AsInteger := DSEmployeeAllowances.FieldByName('BasedOnID').AsInteger;
        DSPayAllowances.FieldByName('Amount').AsFloat := DSEmployeeAllowances.FieldByName('Amount').AsFloat;

        DSPayAllowances.FieldByName('MoneyAmount').AsFloat :=
            CalcBasedOnAmount(Pay,DSEmployeeAllowances.FieldByName('CalcBy').AsString,DSEmployeeAllowances.FieldByName('Amount').AsFloat,DSEmployeeAllowances.FieldByName('BasedOnID').AsInteger);
        DSPayAllowances.FieldByName('CalcBy').AsString := DSEmployeeAllowances.FieldByName('CalcBy').AsString;
        DSPayAllowances.FieldByName('TaxExempt').AsString := DSEmployeeAllowances.FieldByName('TaxExempt').AsString;
        DSPayAllowances.FieldByName('SuperInc').AsString := DSEmployeeAllowances.FieldByName('SuperInc').AsString;
        DSPayAllowances.FieldByName('ClientID').AsInteger := DSEmployeeAllowances.FieldByName('ClientID').AsInteger;
        DSPayAllowances.FieldByName('ClassID').AsInteger := DSEmployeeAllowances.FieldByName('ClassID').AsInteger;
        DSPayAllowances.FieldByName('ClassName').AsString := DSEmployeeAllowances.FieldByName('ClassName').AsString;
        DSPayAllowances.Post;
        DSEmployeeAllowances.Next;
      end;
    end;
    // Create new deductions if dates permit
    DSEmployeeDeductions.First;

    with DSEmployeeDeductions do begin
      if FieldByName('UseStartEndDates').AsString = 'T' then begin
        if FieldByName('StartDate').AsDateTime <> 0 then begin
          if (Pay.PayDate > FieldByName('StartDate').AsDateTime ) and
                 (Pay.PayDate < FieldByName('EndDate').AsDateTime) then begin
            bDoDeduction := true;
          end else begin
            bDoDeduction := false;
          end;
        end else begin
          bDoDeduction := true;   //if date empty go ahead and do deduction
        end;
      end else begin
        bDoDeduction := true;
      end;
    end;

    if bDoDeduction = true then begin
      While not DSEmployeeDeductions.Eof Do Begin
        DSPayDeductions.Insert;
        DSPayDeductions.FieldByName('PayID').AsInteger := PayID;
        DSPayDeductions.FieldByName('ClassID').AsInteger := DSEmployeeDeductions.FieldByName('ClassID').AsInteger;
        DSPayDeductions.FieldByName('ClassName').AsString := DSEmployeeDeductions.FieldByName('ClassName').AsString;
        DSPayDeductions.FieldByName('DeductionID').AsInteger := DSEmployeeDeductions.FieldByName('DeductionID').AsInteger;
        DSPayDeductions.FieldByName('Qty').AsFloat:= DSEmployeeDeductions.FieldByName('Qty').AsFloat;
        DSPayDeductions.FieldByName('BasedOnID').AsInteger := DSEmployeeDeductions.FieldByName('BasedOnID').AsInteger;
        DSPayDeductions.FieldByName('Notes').AsString := DSEmployeeDeductions.FieldByName('Notes').AsString;
        DSPayDeductions.FieldByName('Amount').AsFloat := DSEmployeeDeductions.FieldByName('Amount').AsFloat;

        DSPayDeductions.FieldByName('MoneyAmount').AsFloat :=
             CalcBasedOnAmount(Pay,DSEmployeeDeductions.FieldByName('CalcBy').AsString,DSEmployeeDeductions.FieldByName('Amount').AsFloat,DSPayDeductions.FieldByName('BasedOnID').AsInteger);

        DSPayDeductions.FieldByName('TaxExempt').AsString := DSEmployeeDeductions.FieldByName('TaxExempt').AsString;
        DSPayDeductions.FieldByName('CalcBy').AsString := DSEmployeeDeductions.FieldByName('CalcBy').AsString;
        DSPayDeductions.FieldByName('UnionFees').AsString := DSEmployeeDeductions.FieldByName('UnionFees').AsString;
        DSPayDeductions.Post;
        DSEmployeeDeductions.Next;
      end;
    end;

    // Create new Superannuation
    DSEmployeeSuper.First;
    While not DSEmployeeSuper.Eof Do Begin
      DSPaySuper.Insert;
      DSPaySuper.FieldByName('PayID').AsInteger :=  PayID;
      DSPaySuper.FieldByName('AllClasses').AsBoolean := DSEmployeeSuper.FieldByName('AllClasses').AsBoolean;
      DSPaySuper.FieldByName('ClientID').AsInteger := DSEmployeeSuper.FieldByName('ClientID').AsInteger;
      DSPaySuper.FieldByName('ClassID').AsInteger := DSEmployeeSuper.FieldByName('ClassID').AsInteger;
      DSPaySuper.FieldByName('ClassName').AsString := DSEmployeeSuper.FieldByName('ClassName').AsString;
      DSPaySuper.FieldByName('SuperID').AsInteger := DSEmployeeSuper.FieldByName('SuperID').AsInteger;
      DSPaySuper.FieldByName('SuperTypeID').AsInteger := DSEmployeeSuper.FieldByName('SuperTypeID').AsInteger;
      DSPaySuper.FieldByName('AccountNo').AsString := DSEmployeeSuper.FieldByName('AccountNo').AsString;
      DSPaySuper.FieldByName('DateJoined').AsDateTime := DSEmployeeSuper.FieldByName('DateJoined').AsDateTime;
      DSPaySuper.FieldByName('Amount').AsFloat := DSEmployeeSuper.FieldByName('Amount').AsFloat;
      DSPaySuper.FieldByName('CalcBy').AsString := DSEmployeeSuper.FieldByName('CalcBy').AsString;
      if DSEmployeeSuper.FieldByName('CalcBy').AsString = '$' then begin
        DSPaySuper.FieldByName('AmountPaid').AsFloat := DSEmployeeSuper.FieldByName('Amount').AsFloat;
      end else begin
        DSPaySuper.FieldByName('AmountPaid').AsFloat := DSEmployeeSuper.FieldByName('AmountToPaid').AsFloat;
      end;
      DSPaySuper.Post;
      DSEmployeeSuper.Next;
    end;
    //create new pay splits
    with DSPaySplit do begin
      while not Eof do begin
        DSPayPaySplits.Insert;
        DSPayPaySplits.FieldByName('PayID').AsInteger :=  PayID;
        DSPayPaySplits.FieldByName('Type').AsString :=  FieldByName('Type').AsString;
        DSPayPaySplits.FieldByName('Split').AsString :=  FieldByName('Split').AsString;
        DSPayPaySplits.FieldByName('BankID').AsInteger :=  FieldByName('BankID').AsInteger;
        DSPayPaySplits.FieldByName('Branch').AsString :=  FieldByName('Branch').AsString;
        DSPayPaySplits.FieldByName('BSB').AsString :=  FieldByName('BSB').AsString;
        DSPayPaySplits.FieldByName('AccountNo').AsString :=  FieldByName('AccountNo').AsString;
        DSPayPaySplits.FieldByName('Amount').AsFloat :=  FieldByName('Amount').AsFloat;
        DSPayPaySplits.FieldByName('AccountName').AsString :=  FieldByName('AccountName').AsString;

        DSPayPaySplits.Post;
        Next;
      end
    end;
  finally
    Screen.Cursor := SavedCursor;
    FreeAndNil(Pay);
  end;
end;

procedure TPayFunctionObj.ProcessPay(Const iPayID: Integer; Const DatePaid: TDateTime; Const AddtoABA,Preview: Boolean;IsTerminationPay:Boolean);
Var
  SavedCursor: TCursor;
  ABAObj : TABAObj;
  tmpEmployeeID :Integer;
  PreviewFlag :Boolean;
  Pay: TPayObj;
  UserLock: TUserLock;
begin
  PreviewFlag := Preview;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ABAObj := TABAObj.Create;
  UserLock := TUserLock.Create(nil);
  Try
    Pay := TPayObj.Create;
    if IsTerminationPay then Pay.IsTerminationPay := True;
    Try
      LoadPayTables(iPayID,False);
      Pay.DataSet := DSPay;
      Pay.Employee.DataSet := DSEmployee;
      Pay.PayRates.DataSet := DSPayPayRates;
      Pay.PayPaySplits.DataSet := DSPayPaySplits;
      Pay.PaySplit.DataSet := DSPaySplit;
      Pay.Allowances.DataSet := DSPayAllowances;
      Pay.Deductions.DataSet := DSPayDeductions;
      Pay.Sundries.DataSet := DSPaySundries;
      Pay.Commission.DataSet := DSPayCommission;
      Pay.Superannuation.DataSet := DSPaySuper;
      Pay.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
      if not AppEnv.PayPrefs.IncZeroPayRates then Pay.PayRates.RemoveZeroTotalEntries;
      Pay.Recalc;

      {Process Pay}
        DSPay.Edit;
        DSPay.FieldByName('DatePaid').AsDateTime := DatePaid;
        DSPay.FieldByName('PayVersion').AsInteger := Trunc(StrValue(ReplaceStr(GetFileVersion(Application.ExeName),'.','')));
        DSPay.Post;
        Pay.PopulateMe;
        DSPay.Edit;
        DSPay.FieldByName('Paid').AsString := 'T';
        DSPay.FieldByName('Pay').AsString := 'F';
        DSPay.Post;
       
      {Update Employee Last Paid & Period}
        Pay.Employee.EmployeeSettings.LastPaid := Pay.PayDate;
        Pay.Employee.EmployeeSettings.LastPayPeriod := Pay.PayPeriods;

      {Accrued leave}
        Pay.Leave.LeaveTotals.AddLeaveAccrued;

      {Leave Taken}
        Pay.Leave.LeaveTotals.DeductLeaveTaken;

      {Post To Accounts}
        Pay.PostToAccounts;
        try
          Pay.DataXML.SnapshotXMLPayData;
        except

        end;

      {Print the Pay Slip}
        Pay.Recalc;
        //Print
        PrintPaySlip(Pay,PreviewFlag,Pay.Employee.EmployeeSettings.SendPaySlipViaEmail);
        //Flag Printed
        DSPay.Edit;
        DSPay.FieldByName('Printed').AsString := 'T';
        DSPay.Post;


      {Create EFT Payment}
      if AddtoABA then begin
         if ABAObj.ValidEFTEmployee(Pay.PayID) then begin
           If ABAObj.HasValidEFTEmployeeAccountInfo(Pay.PayID) then Begin
              if not UserLock.IsLocked('tblabadescriptiverecord', -1, 'Electronic Funds Transfer') then begin
                  ABAObj.AddABADetailsRecord(Pay.Employee.EmployeeID,Pay.PaySplit.DataSet,
                     AppEnv.PayPrefs.BankAccountID,Pay.PayTotals.Net,Pay.PayID, 'Pay');
              end else begin
                CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Electronic Funds Transfer' +
                ' Failed.', mtWarning, [mbOK], 0);
              end;

           end else begin
              CommonLib.MessageDlgXP_Vista('EFT ERROR: ' + Pay.Employee.EmployeeDetails.EmployeeName + ' has Invalid Bank Details', mtError, [mbOK], 0);
           end;
        end;
      end;

      tmpEmployeeID:=Pay.Employee.EmployeeID;
    finally
      FreeAndNil(Pay);
    end;

    {Create Next Pay}
    CreatePay(tmpEmployeeID);

  finally
    Screen.Cursor := savedCursor;
    FreeAndNil(ABAObj);
    FreeAndNil(UserLock);
  end;
end;


procedure TPayFunctionObj.PrintPaySlip(Const ThisPay: TPayObj; Const Preview: Boolean; Const SendPaySlipViaEmail : String; Const DoEmailSend:Boolean=false);
var
  sALLSQL,sSQL,sSQL1,sSQL2,sSQL3,sSQL4,sSQL5,sSQL6,sSQL7,sSQL8,sSQL9,sSQL10: String;
  qryTemp: TMyQuery;
  sBankDetails: String;
  TempMyqry: TMyQuery;
  iSQLcounter: Integer;
  PipeName:String;
  dAmountReminder : Currency;
  fsReportName: String;
  ms: TMemoryStream;
  RTemplates: TReportTemplates;
  sBody: string;
begin
    sBankDetails := '';
    //Bank Details
    sBankDetails := GetBankDetailsMemo(ThisPay);
    if sBankDetails = '' then sBankDetails := ' ';
      ThisPay.Leave.LeaveTotals.Recalc;
      // Now Apply SQL for template
      {Payment Details}
      sSQL := 'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
          'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' +
          'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN,' +
          'tblPays.EmployeeID, EmpName, PayDate, PayPeriods, tblPays.Wages, tblPays.Commission, tblPays.Deductions, tblPays.Allowances, ' +
          'tblPays.Sundries, tblPays.Superannuation, tblPays.Gross, tblPays.Tax, tblPays.Net,tblPays.Deleted, ' +
          'B.Description, T.Description as Type, A.LineTotal, ' +
          'IF(T.Description = "Hourly Rate" OR T.Description = "Salary", A.Qty, 0.0) as Qty, ' +
          'IF(T.Description = "Hourly Rate" OR T.Description = "Salary", A.Amount, 0.0) as Rate, ' +
          QuotedStr(GetClassName(ThisPay.Employee.EmployeeSettings.ClassID)) + ' as "Employee Department", ' +

          FloatToStr(ThisPay.Leave.LeaveAccrued.GetHrs(ThisPay.Leave.LeaveTotals.GetLeaveID('Annual Leave'))) + ' as Leave, ' +
          FloatToStr(ThisPay.Leave.LeaveAccrued.GetHrs(ThisPay.Leave.LeaveTotals.GetLeaveID('Sick Leave'))) + ' as SickLeave, ' +
          FloatToStr(RoundTo((ThisPay.Leave.LeaveAccrued.GetHrs(ThisPay.Leave.LeaveTotals.GetLeaveID('Annual Leave'))/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3)) + ' as LeaveDays, ' +
          FloatToStr(RoundTo((ThisPay.Leave.LeaveAccrued.GetHrs(ThisPay.Leave.LeaveTotals.GetLeaveID('Sick Leave'))/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3)) + ' as SickLeaveDays, ' +
          FloatToStr(ThisPay.Leave.LeaveAccrued.GetHrs(ThisPay.Leave.LeaveTotals.GetLeaveID('Long Service'))) + ' as LongServiceLeave, ' +
          FloatToStr(ThisPay.PayTotals.YTDWages) + ' as YTDWages, ' +
          FloatToStr(ThisPay.PayTotals.YTDCommission) + ' as YTDCommission, ' +
          FloatToStr(ThisPay.PayTotals.YTDDeduction) + ' as YTDDeductions, ' +
          FloatToStr(ThisPay.PayTotals.YTDAllowances) + ' as YTDAllowances, ' +
          FloatToStr(ThisPay.PayTotals.YTDSundries) + ' as YTDSundries, ' +
          FloatToStr(ThisPay.PayTotals.YTDSuperannuation) + ' as YTDSuper, ' +
          FloatToStr(ThisPay.PayTotals.YTDGross) + ' as YTDGross, ' +
          FloatToStr(ThisPay.PayTotals.YTDTax) +  ' as YTDTax, ' +
          FloatToStr(ThisPay.PayTotals.YTDNet) + ' as YTDNet, ' +
          FloatToStr(RoundTo((ThisPay.Leave.LeaveTotals.GetYTDHrs(GetLeaveTypeID('Annual Leave'),ThisPay.PayDate)),-3))   + ' as TDLeaveHrs, ' +
          FloatToStr(RoundTo((ThisPay.Leave.LeaveTotals.GetYTDHrs(GetLeaveTypeID('Annual Leave'),ThisPay.PayDate)/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3)) + ' as TDLeaveDays, ' +
          FloatToStr(RoundTo(ThisPay.Leave.LeaveTotals.GetYTDHrs(GetLeaveTypeID('Sick Leave'),ThisPay.PayDate),-4)) + ' as TDSickLeaveHrs, ' +
          FloatToStr(RoundTo((ThisPay.Leave.LeaveTotals.GetYTDHrs(GetLeaveTypeID('Sick Leave'),ThisPay.PayDate))/(AppEnv.CompanyPrefs.HoursPerWeek/5),-3)) + ' as TDSickLeaveDays, ' +
          FloatToStr(RoundTo(ThisPay.Leave.LeaveTotals.GetYTDHrs(GetLeaveTypeID('Long Service'),ThisPay.PayDate),-4)) + ' as TDLongServiceLeaveHrs, ' +
          QuotedStr(sBankDetails) + ' As BankingDetails, ' +
          'DATE_ADD('+QuotedStr(FormatDateTime('yyyy-mm-dd', ThisPay.StartPayPeriod)) + ',INTERVAL 0 SECOND) as PayFrom, ' +
          'E.Street AS EmployeeStreet, E.Street2 AS EmployeeStreet2, E.Suburb AS EmployeeSuburb, ' +
          'E.Postcode AS EmployeePostCode,E.Position, E.State AS EmployeeState,tblPays.PayID,E.PayNotes, ' +
          'E.Award,Aw.AwardID, Aw.AwardName  ' +
          'FROM tblCompanyInformation AS CO, tblPays ' +
          'LEFT JOIN tblpayspayrates AS A USING (PayID) ' +
          'LEFT JOIN tblpayrates as B ON A.PayRateID = B.RateID ' +
          'LEFT JOIN tblpayratetype as T ON A.TypeID = T.TypeID ' +
          'LEFT JOIN tblemployees AS E ON tblPays.EmployeeID = E.EmployeeID ' +
          'LEFT JOIN tblawards AS Aw ON E.Award = Aw.AwardID ' +
          'WHERE (tblPays.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (tblPays.Deleted = "F")'  ;

  {Additions}
  sSQL1 := 'SELECT '+
          'A.Description AS "Description", PA.Qty AS "QTY / Hours", '+
          'PA.MoneyAmount AS "Amount",PA.Calcby,PA.Amount as "Rate",P.Deleted,P.PayID '+
          'FROM tblpaysallowances AS PA '+
          'INNER JOIN tblallowances AS A on PA.AllowanceID = A.AllowanceID '+
          'INNER JOIN tblpays as P on PA.PayID = P.PayID ' +
          'WHERE (PA.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID)+ ') AND (P.Deleted = "F")';
  {Deductions}
  sSQL2 := 'SELECT '+
          'D.Description AS "Description", PD.CalcBy, PD.Qty AS "QTY / Hours", '+
          'PD.MoneyAmount,PD.Amount as "Rate",P.Deductions,P.PayID,P.Deleted,BO.BasedOn '+
          'FROM tblpaysdeductions AS PD '+
          'INNER JOIN tbldeductions AS D ON PD.DeductionID = D.DeductionID '+
          'INNER JOIN tblallowancebasedon AS BO ON BO.BasedOnID = PD.BasedOnID  ' +
          'LEFT JOIN tblpays AS P ON P.PayID = PD.PayID ' +
          'WHERE (PD.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';
  {Banking}
  qryTemp := TMyQuery.Create(nil);
  Try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

   qryTemp.SQL.Clear;
   qryTemp.SQL.Text :='SELECT '+
                              'Sum(CASE PS.Type '+
                              'WHEN "$" THEN Round(PS.Amount,2) '+
                              'WHEN "%" THEN Round((PS.Amount/100)*P.Net,2) '+
                              'ELSE 0.00 END) as Amount, '+
                              'P.Net,P.Deleted '+
                              'FROM tblpays AS P '+
                              'INNER JOIN tblpayssplits AS PS on PS.PayID = P.PayID '+
                              'WHERE (P.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F" )' +
                              'Group By P.Net; ';
    qryTemp.Open;
    dAmountReminder := qryTemp.FieldByName('Net').asFloat - qryTemp.FieldByName('Amount').asFloat;
    qryTemp.Close;
  finally
    FreeAndNil(qryTemp);
  end;
  sSQL3 :='SELECT '+
          'P.EmpName AS "Employee Name",P.Deleted, '+
          'PS.Split as Type, '+
          'PS.BSB, '+
          'PS.AccountNo, '+
          'BC.BankCode, '+
          'BC.BankName As "Bank Description", '+
          'CASE PS.Type '+
          'WHEN "$" THEN Round(PS.Amount,2) '+
          'WHEN "%" THEN Round((PS.Amount/100)*P.Net,2) '+
          'WHEN "Remainder" THEN '+ FloatToStrF(dAmountReminder, ffFixed, 15, 2) +' '+
          'ELSE 0.00 END as Amount '+
          'FROM tblpays AS P '+
          'INNER JOIN tblpayssplits AS PS on PS.PayID = P.PayID '+
          'LEFT JOIN tblbankcodes AS BC on PS.BankID = BC.CodeID '+
          'WHERE (P.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';
  {Superannuation}
  sSQL4 :='SELECT P.Deleted,'+
          'IF(ISNULL(SUP.Company), "Unknown Super Fund", SUP.Company) AS "Super Fund", '+
          'PS.AmountPaid AS "Amount", '+
          'SUPT.Description as Type '+
          'FROM tblpays AS P '+
          'INNER JOIN tblpayssuperannuation AS PS on PS.PayID = P.PayID '+
          'LEFT JOIN tblsupertype as SUPT USING(SuperTypeID) '+
          'LEFT JOIN tblClients AS SUP on PS.ClientID = SUP.ClientID '+
          'WHERE (P.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';
  {Entitlements}
  sSQL5 :='SELECT P.Deleted,'+
          'L.Type As "Description", '+
          'L.AccruedHours AS "Amount" '+
          'FROM tblpays AS P '+
          'INNER JOIN tblleave AS L on L.EmployeeID = P.EmployeeID '+
          'WHERE (P.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';

  {Sundries}
  sSQL6 :='SELECT P.Deleted,'+
          'S.Sundry As "Description", '+
          'S.Amount AS "Amount" '+
          'FROM tblpays AS P '+
          'INNER JOIN tblpayssundries AS S Using(PayID) '+
          'WHERE (P.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';

  {Commission}
  sSQL7 :='SELECT P.Deleted,Deleted,'+
          'C.CommissionDesc As "Description", '+
          'C.ClassName as Department,'+
          'C.Net AS "Amount" '+
          'FROM tblpays AS P '+
          'INNER JOIN tblpayscommission AS C Using(PayID) '+
          'WHERE (P.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';

   {TimeSheet}

  sSQL8 := 'SELECT Sum(Total) As Wages, Sum(SuperAmount) AS Super, Sum(Hours) AS WorkedHours,LabourCost AS Amount,' +
               ' tblTimesheets.* FROM tblTimesheets WHERE Active = "F" AND EmployeeID = ' + QuotedStr(FastFuncs.IntToStr(ThisPay.Employee.EmployeeID)) +
                  ' AND Date BETWEEN "' + FormatDateTime('yyyy-mm-dd', ThisPay.StartPayPeriod) + '"  AND "' + FormatDateTime('yyyy-mm-dd', ThisPay.PayDate) +
                 '" GROUP BY EmployeeID,PayRateTypeID,JobID,ServiceID,LabourCost,ChargeRate,HourlyRate,ClassID';


  {Notes}

  sSQL9 := 'SELECT PayNotes FROM tblpays WHERE tblpays.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID);

  {LeaveTaken}

  sSQL10 := 'SELECT *,p.Deleted FROM tblpaysleave as pl INNER JOIN tblpays as p WHERE pl.PayID = p.PayID ' +
              'AND p.Deleted = "F" AND pl.PayID = ' + FastFuncs.IntToStr(ThisPay.PayID) ;

  RTemplates := TReportTemplates.Create;
  stPlain := TMemoryStream.Create;
  AbZipKit := TAbZipKit.Create(nil);
  ms := TMemoryStream.Create;
  try
    with RTemplates do begin
      fsReportName := GetDefaultReport(68); //Payslip Type

      If not empty(fsReportName) then Begin
        GetSQLForReport(fsReportName); // creates  report stream
      end else Begin
        GetSQLForReport('PaySlip'); // creates  report stream
      end;

      sALLSQL := sSQL+'~|||~'+sSQL1+'~|||~'+sSQL2+'~|||~'+sSQL3+'~|||~'+
                 sSQL4+'~|||~'+sSQL5+'~|||~'+sSQL6+'~|||~'+sSQL7+'~|||~'+sSQL8+'~|||~'+sSQL9 + '~|||~'+
                 sSQL10;

      for iSQLcounter := 1 to GetSQLCount('PaySlip') do begin
        TempMyqry := GetMyQuery(iSQLcounter );

        if (TempMyqry=nil) then
          Continue;

        TempMyqry.Close;
        TempMyqry.Sql.Clear;
        TempMyqry.Sql.Text := ExtractStrPortion(sALLSQL,'~|||~',iSQLcounter);
        PipeName :=Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));

        if (FastFuncs.Trim(TempMyqry.Sql.Text)<>PipeName) then begin
          RTemplates.PipelineUserName[iSQLcounter] := PipeName; 
          TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
        end;

        TempMyqry.Open;
      end;
      ReportStream.Position := 0;
      Report.Template.LoadFromStream(ReportStream);
      Report.ShowPrintDialog := false;

      if not Preview then begin
        Report.DeviceType := 'Printer';
      end;

      if (ThisPay.Employee.EmployeeSettings.SendPaySlipViaEmail = 'T') or (ThisPay.Employee.EmployeeSettings.SendPaySlipViaEmail = 'B') then begin
        if (not empty (GetEmailAddress(ThisPay))) then begin
          //check for directory
          if not DirectoryExists(GetCurrentDir + '\PaySlipFiles') then
            if not CreateDir(GetCurrentDir + '\PaySlipFiles') then
              raise Exception.Create('Cannot create ' + GetCurrentDir + '\PaySlipFiles');

          //Save the ReportStream to data base to reload and print later if email fails
          Self.CreateTmpTable;
          qryTemp := TMyQuery.Create(nil);
          try
            qryTemp.Options.FlatBuffers := True;
            qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

            //save stream to backend to use later in case of email failure
            qryTemp.SQL.Add('SELECT * FROM tmp_pay_' + GetMachineIdentification(true, true, true, true));
            qryTemp.Open;
            qryTemp.Insert;
            RTemplates.ReportStream.Position := 0;
            TBlobField(qryTemp.FieldByName('Report')).LoadFromStream(RTemplates.ReportStream);
            qryTemp.FieldByName('SQLString').AsString := sALLSQL;
            qryTemp.FieldByName('empName').AsString := ThisPay.Employee.EmployeeDetails.EmployeeName;
            qryTemp.Post;

          finally
            FreeAndNil(qryTemp);
            Self.DestroyTmpTable;
          end;
          //save as pdf file
          Report.AllowPrintToFile := True;
          Report.ShowPrintDialog := False;
          Report.DeviceType := 'PDF';
          Report.TextFileName :=  'PaySlipFiles\' + ThisPay.Employee.EmployeeDetails.EmployeeName + FastFuncs.IntToStr(ThisPay.PayID)   + '.pdf';

          if Report.DeviceType = 'PDF' then begin
            Report.AllowPrintToFile := True;
            Report.ShowPrintDialog := False;
            Report.PDFSettings.Author := AppEnv.CompanyInfo.Tradingname;
            Report.PDFSettings.Title := 'Print to PDF!'; // Maybe Change to
            Report.PDFSettings.CompressionLevel := clDefault;
            Report.PDFSettings.OptimizeImageExport := True;
            Report.PDFSettings.OpenPDFFile := False;
          end;
          
          Try
            Report.Print;
          except
            on E: Exception do begin
              If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
                CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
              end else
                raise;
            end;
          end;

          //save file as .zip
          AbZipKit.OpenArchive(GetCurrentDir + '\PaySlipFiles\' + ThisPay.Employee.EmployeeDetails.EmployeeName + FastFuncs.IntToStr(ThisPay.PayID)   + '.zip');
          AbZipKit.BaseDirectory := GetCurrentDir + '\PaySlipFiles';

          If FileExists(GetCurrentDir +'\PaySlipFiles\' + ThisPay.Employee.EmployeeDetails.EmployeeName+ FastFuncs.IntToStr(ThisPay.PayID)   + '.pdf') then
            stPlain.LoadFromFile(GetCurrentDir +'\PaySlipFiles\' + ThisPay.Employee.EmployeeDetails.EmployeeName+ FastFuncs.IntToStr(ThisPay.PayID)   + '.pdf');

          if not empty (ThisPay.Employee.EmployeeDetails.TaxFileNumber) then begin
            AbZipKit.Password := ThisPay.Employee.EmployeeDetails.TaxFileNumber;
          end else begin
            AbZipKit.Password := 'tfn';
          end;

          stPlain.Position := 0;
          If stPlain.Size >0 then
            AbZipKit.AddFromStream(ThisPay.Employee.EmployeeDetails.EmployeeName + FastFuncs.IntToStr(ThisPay.PayID) + '.pdf', stPlain);

          AbZipKit.CloseArchive;

          If DoEmailSend then Begin
            if AppEnv.Employee.UseEmpEmailAsFromAddress then begin
              sBody := 'Attached is your Pay slip'
            end else begin
              sBody := 'Attached is your Pay slip. The sender does not have an individual email address.'
            end;


            SendEmail(getEmailFrom,tcDataUtils.GetEmployeeEmail(ThisPay.Employee.EmployeeID) , '',
                GetCurrentDir + '\PaySlipFiles\' + ThisPay.Employee.EmployeeDetails.EmployeeName + FastFuncs.IntToStr(ThisPay.PayID)   + '.zip',
                ThisPay.Employee.EmployeeDetails.EmployeeName + ' Pay Slip', sBody);
            DeleteFiles(GetCurrentDir + '\PaySlipFiles\', '*.pdf');
            DeleteFiles(GetCurrentDir + '\PaySlipFiles\', '*.zip');
          end;

        end;
      end;

      if (ThisPay.Employee.EmployeeSettings.SendPaySlipViaEmail = 'F') or (ThisPay.Employee.EmployeeSettings.SendPaySlipViaEmail = 'B') then begin
        Report.DeviceType := 'Screen';
        if not Preview then begin
          Report.DeviceType := 'Printer';
        end;

        Report.PrinterSetup.Copies := 1;
        Try
          Report.Print;
        except
          on E: Exception do begin
            If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
              CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
            end else
              raise;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(stPlain);
    FreeAndNil(AbZipKit);
    FreeAndNil(ms);
    FreeAndNil(RTemplates);
  end;
end;

procedure TPayFunctionObj.DestroyTmpTable ;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.SQL.Add ( 'DROP TABLE IF EXISTS  tmp_pay_' + GetMachineIdentification(true, true, true, true)+';');
    qryTemp.Execute;
    qryTemp.Close;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPayFunctionObj.CreateTmpTable;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.SQL.Add ( 'DROP TABLE IF EXISTS tmp_pay_' + GetMachineIdentification(true, true, true, true)+';');
    qryTemp.Execute;
    qryTemp.Close;
    qryTemp.SQL.Clear;

    qryTemp.SQL.Add('CREATE TABLE  tmp_pay_' + GetMachineIdentification(true, true, true, true)+' ( `GlobalRef` varchar(255) default NULL,');
    qryTemp.SQL.Add('`TemplID` int(11) NOT NULL auto_increment, `TemplName` varchar(30) default "PaySlip",');
    qryTemp.SQL.Add(' `Report` longblob, `msTimeStamp` timestamp(14) NOT NULL, ');
    qryTemp.SQL.Add(' `SQLString`text ,`DesignTimeSQLString` text,`empName`varchar(60),');
    qryTemp.SQL.Add('PRIMARY KEY  (`TemplID`),');
    qryTemp.SQL.Add('  KEY `GlobalRefIndex` (`GlobalRef`))');
    qryTemp.SQL.Add(' TYPE=InnoDB;');

    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPayFunctionObj.PrintFromDB(Const empName:string;Const Preview: Boolean);
var
  qryTemp :TMyQuery;
  tmpTemplates:TReportTemplates;
  TempMyqry: TMyQuery;
  sALLSQL:string;
  iSQLcounter: integer;
  PipeName:String;
  fsReportName: String;

begin
  qryTemp := TMyQuery.Create(nil);
  tmpTemplates := TReportTemplates.Create;
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.SQL.Add('SELECT * FROM tmp_pay_' + GetMachineIdentification(true, true, true, true)+' WHERE empName = "' + empName + '"');
    qryTemp.Open;

    sALLSQL := qryTemp.FieldByName('SQLString').AsString;

                      //Load template
    fsReportName := GetDefaultReport(68); //Payslip Type

    If not empty(fsReportName) then Begin
      tmpTemplates.GetSQLForReport(fsReportName,1); // creates  report stream
    end else Begin
      tmpTemplates.GetSQLForReport('PaySlip',1); // creates  report stream
    end;

    For iSQLcounter := 1 to CharCounter('~|||~',sALLSQL) do begin
      TempMyqry := tmpTemplates.GetMyQuery(iSQLcounter);
      If (TempMyqry=nil) then Continue;
      TempMyqry.Close;
      TempMyqry.Sql.Clear;
      TempMyqry.Sql.Text := ExtractStrPortion(sALLSQL,'~|||~',iSQLcounter);
      PipeName :=Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text,'{',''),'}',0));
      If (FastFuncs.Trim(TempMyqry.Sql.Text)<>PipeName) Then Begin
        tmpTemplates.PipelineUserName[iSQLcounter] := PipeName;
        TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text,'{'+PipeName+'}','');
      end;
      TempMyqry.Open;
    end;
    tmpTemplates.ReportStream.Position := 0;
    tmpTemplates.Report.Template.LoadFromStream(tmpTemplates.ReportStream);

    tmpTemplates.Report.ShowPrintDialog := false;
    if not Preview then begin
      tmpTemplates.Report.DeviceType := 'Printer';
    end;
    tmpTemplates.Report.PrinterSetup.Copies := 1;

    Try
      tmpTemplates.Report.Print;
    except
      on E: Exception do begin
        If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
          CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
        end else
          raise;
      end;
    end;

  finally
    FreeAndNil(tmpTemplates);
  end;
end;

procedure TPayFunctionObj.SendEmail(Const sEmailFrom,sEmailto,sPassword,sFilename,sSubject,sMessage:string);
var
sTemp : string;
begin
  // Assign new params/data
  FEmailSender.ResetMessageData;
  FEmailSender.Recipients  :=  sEmailto;
  FEmailSender.BccList     := '';
  FEmailSender.Subject     := sSubject;
  FEmailSender.EmailBody.Add(sMessage);


  If FileExists(ExtractFilePath(Paramstr(0)) + sFileName) then
    sTemp := ExtractFilePath(Paramstr(0)) + sFileName
  else If FileExists(sFileName) then
    sTemp := sFileName;

  if FileExists(sTemp) then FEmailSender.AddAttachment(sTemp);

  Application.ProcessMessages;

  try
    FEmailSender.Send;  //now just saving email to back end. Other app/service will send it.

  except

  end;
  Application.ProcessMessages;
end;

function TPayFunctionObj.GetEmailAddress(ThisPay:TPayObj):string;
var
  qryTempEmail: TMyQuery;
begin
  qryTempEmail := TMyQuery.Create(nil);
  qryTempEmail.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTempEmail.ParamCheck := False;
  try
    qryTempEmail.Options.FlatBuffers := True;
    qryTempEmail.Sql.Add('SELECT Email FROM tblemployees WHERE EmployeeID =' + FastFuncs.IntToStr(ThisPay.Employee.EmployeeID) + ';');
    qryTempEmail.Active := True;
    if not qryTempEmail.IsEmpty then
    begin
      result := qryTempEmail.FieldByName('Email').AsString;
    end
    else
    begin
      result := '';
    end;
  finally
    FreeAndNil(qryTempEmail);
  end;
end;

function TPayFunctionObj.GetBankDetailsMemo(Const ThisPay: TPayObj):String;
var
  qryTempEmpBanks: TMyQuery;
  sBankDetails: String;
  dAmountThisBank, dAmountLeft : Currency;
begin
  sBankDetails := '';
  dAmountLeft := ThisPay.PayTotals.Net;
  qryTempEmpBanks := TMyQuery.Create(nil);
  Try
    qryTempEmpBanks.Options.FlatBuffers := True;
    qryTempEmpBanks.Connection := CommonDbLib.GetSharedMyDacConnection;
    // Bank details on what amounts are going where.
    qryTempEmpBanks.Sql.Clear;
    qryTempEmpBanks.Sql.Add('SELECT PaySplitID, Split, Branch, BSB, AccountNo, Amount, Type, BC.BankCode, BC.BankName ');
    qryTempEmpBanks.Sql.Add('FROM tblpayssplits');
    qryTempEmpBanks.Sql.Add('LEFT JOIN tblbankcodes AS BC on BC.CodeID = BankID');
 //   qryTempEmpBanks.Sql.Add('Where EmployeeID='+FastFuncs.IntToStr(ThisPay.Employee.EmployeeID) + ' Order By SplitID;');
    qryTempEmpBanks.Sql.Add('Where PayID='+FastFuncs.IntToStr(ThisPay.PayID) + ' Order By PaySplitID;');
    qryTempEmpBanks.Open;

    While Not qryTempEmpBanks.Eof do Begin
      //#### Do Calcs
      If (FastFuncs.Trim(qryTempEmpBanks.FieldByName('Type').asString) ='Remainder') then Begin
         dAmountThisBank:= dAmountLeft;
         // Now add the bank details to our string
         if sBankDetails = '' then begin
            if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
               sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
            end else begin
               sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                               qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                               '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
            end;
         end else begin
            if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
               sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
            end else begin
               sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                               qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                               '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
            end;
         end;
      end Else If (qryTempEmpBanks.FieldByName('Type').asString ='$') then Begin
         If (dAmountLeft - qryTempEmpBanks.FieldByName('Amount').AsFloat) < 0.00 then Begin
            dAmountThisBank := dAmountLeft;
            // Now add the bank details to our string
            if sBankDetails = '' then begin
               if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
                  sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end else begin
                  sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                                  qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                                  '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end;
            end else begin
               if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
                  sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end else begin
                  sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                                  qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                                  '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end;
            end;
         end else Begin
            dAmountThisBank := qryTempEmpBanks.FieldByName('Amount').AsFloat;
            // Now add the bank details to our string
            if sBankDetails = '' then begin
               if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
                  sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end else begin
                  sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                                  qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                                  '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end;
            end else begin
               if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
                  sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end else begin
                  sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                                  qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                                  '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
               end;
            end;
         end;
      end Else If (qryTempEmpBanks.FieldByName('Type').asString ='%') then Begin
        dAmountThisBank := dAmountLeft * (qryTempEmpBanks.FieldByName('Amount').AsFloat / 100);
        // Now add the bank details to our string
        if sBankDetails = '' then begin
           if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
              sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end else begin
              sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                              qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                              '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end;
        end else begin
           if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
              sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end else begin
              sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                              qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                              '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end;
        end;
      end else begin
        dAmountThisBank := dAmountLeft;
        // Now add the bank details to our string
        if sBankDetails = '' then begin
           if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
              sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end else begin
              sBankDetails := qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                              qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                              '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end;
        end else begin
           if (qryTempEmpBanks.FieldByName('Split').AsString = 'Cash') or (qryTempEmpBanks.FieldByName('Split').AsString = 'Cheque') then begin
              sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ': ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end else begin
              sBankDetails := sBankDetails + qryTempEmpBanks.FieldByName('Split').AsString + ' (' + qryTempEmpBanks.FieldByName('BankCode').AsString + '): ' + qryTempEmpBanks.FieldByName('Branch').AsString + '-> ' +
                              qryTempEmpBanks.FieldByName('BSB').AsString + '-' + qryTempEmpBanks.FieldByName('AccountNo').AsString +
                              '-> ' + FloatToStrF(dAmountThisBank, ffCurrency, 15, 2)+#13+#10;
           end;
        end;
      end;
      dAmountLeft:= dAmountLeft - dAmountThisBank;
      qryTempEmpBanks.Next;
    end;
    qryTempEmpBanks.Close;
    Result := sBankDetails;
  finally
    FreeAndNil(qryTempEmpBanks);
  end;
end;

procedure TPayFunctionObj.UpdateEmployeeWithAward(const DS_Award,
                                                        DS_AwardLeave,
                                                        DS_Classification,
                                                        DS_ClassificationAllowances,
                                                        DS_ClassificationDeductions,
                                                        DS_ClassificationExtraPayRates,
                                                        DS_Employee,
                                                        DS_EmployeeLeave,
                                                        DS_EmployeePayRates,
                                                        DS_EmployeeAllowances,
                                                        DS_EmployeeDeductions,
                                                        DS_EmployeeSuper :TDataset;
                                                        Recreate_Unprocessed_Pay:Boolean;
                                                        EmployeeID:integer);
Var
   Pay: TPayObj;
   x: integer;
   EmpExists: boolean;
   DS_ExistLeaves: TDataSet;

begin
  try
    If (DS_Employee.RecordCount = 0) then begin
      EXIT;
    end;
 //   if DS_EmployeeLeave.FieldByName('EmployeeID').AsInteger <> 0 then begin
    if EmployeeID <> 0 then begin
      EmpExists := true;
    end else
    begin
      EmpExists := false;
    end;
   //store old leaves
    DS_ExistLeaves := RetrieveDataset('tblleave', 'EmployeeID',DS_EmployeeLeave.FieldByName('EmployeeID').AsInteger);

    LoadAwardGeneral(DS_Award,DS_Employee);

   // load Leave

    DeleteEntireDataset(DS_EmployeeLeave);
    LoadAwardLeave(DS_Award, DS_AwardLeave, DS_Employee, DS_EmployeeLeave);
    If EmpExists = true then begin
      //compare old leaves with award leaves, when award matches old put back Accrued hours and date
      // when old leave is not in award, put back but stop accumalating that leave.
      DS_EmployeeLeave.DisableControls;

      DS_EmployeeLeave.First;
      DS_ExistLeaves.First;
      for x := 1 to DS_ExistLeaves.RecordCount   do
      begin
        DS_EmployeeLeave.First;
        if DS_EmployeeLeave.Locate('Type',DS_ExistLeaves.FieldByName('Type').AsString,[]) then begin
          DS_EmployeeLeave.Edit;
          DS_EmployeeLeave.FieldByName('AccruedHours').ReadOnly := False;
          DS_EmployeeLeave.FieldByName('AccruedDate').ReadOnly := False;
          DS_EmployeeLeave.FieldByName('AccruedHours').AsFloat := DS_ExistLeaves.FieldByName('AccruedHours').AsFloat;
          DS_EmployeeLeave.FieldByName('AccruedDate').AsDateTime := DS_ExistLeaves.FieldByName('AccruedDate').AsDateTime;
          DS_EmployeeLeave.FieldByName('OpenningBalanceHrs').AsFloat := DS_ExistLeaves.FieldByName('OpenningBalanceHrs').AsFloat;
          DS_EmployeeLeave.FieldByName('OpenningBalanceDate').AsDateTime := DS_ExistLeaves.FieldByName('OpenningBalanceDate').AsDateTime;
          DS_EmployeeLeave.Post;
          DS_EmployeeLeave.FieldByName('AccruedHours').ReadOnly := True;
          DS_EmployeeLeave.FieldByName('AccruedDate').ReadOnly := True;
        end else begin
          DS_EmployeeLeave.Insert;
          DS_EmployeeLeave.FieldByName('Type').ReadOnly := False;
          DS_EmployeeLeave.FieldByName('AccrueNo').ReadOnly := False;
          DS_EmployeeLeave.FieldByName('AccruedHours').ReadOnly := False;
          DS_EmployeeLeave.FieldByName('AccruedDate').ReadOnly := False;
          DS_EmployeeLeave.FieldByName('AccruedHours').AsFloat := DS_ExistLeaves.FieldByName('AccruedHours').AsFloat;
          DS_EmployeeLeave.FieldByName('AccruedDate').AsDateTime := DS_ExistLeaves.FieldByName('AccruedDate').AsDateTime;
          DS_EmployeeLeave.FieldByName('OpenningBalanceHrs').AsFloat := DS_ExistLeaves.FieldByName('OpenningBalanceHrs').AsFloat;
          DS_EmployeeLeave.FieldByName('OpenningBalanceDate').AsDateTime := DS_ExistLeaves.FieldByName('OpenningBalanceDate').AsDateTime;
          DS_EmployeeLeave.FieldByName('ClassName').AsString := DS_ExistLeaves.FieldByName('ClassName').AsString;
          DS_EmployeeLeave.FieldByName('EmployeeID').AsInteger := DS_ExistLeaves.FieldByName('EmployeeID').AsInteger;
          DS_EmployeeLeave.FieldByName('LeaveLoading').AsFloat := DS_ExistLeaves.FieldByName('LeaveLoading').AsFloat;
          DS_EmployeeLeave.FieldByName('Type').AsString := DS_ExistLeaves.FieldByName('Type').AsString;
          DS_EmployeeLeave.FieldByName('AccrueNo').AsFloat := 0;
          DS_EmployeeLeave.Post;
          DS_EmployeeLeave.FieldByName('AccrueNo').ReadOnly := True;
          DS_EmployeeLeave.FieldByName('Type').ReadOnly := True;
          DS_EmployeeLeave.FieldByName('AccruedHours').ReadOnly := True;
          DS_EmployeeLeave.FieldByName('AccruedDate').ReadOnly := True;
        end;
        DS_ExistLeaves.Next;
      end;

      DS_EmployeeLeave.EnableControls;
      VerifyEmployeeLeave(DS_EmployeeLeave);

        // Load Superannuation
      LoadAwardSuper(DS_Award, DS_Employee, DS_EmployeeSuper);

        // Load Allowances
      DeleteEntireDataset(DS_EmployeeAllowances);
      LoadAwardAllowances(DS_Award, DS_ClassificationAllowances, DS_Employee, DS_EmployeeAllowances);

        // Load Deductions
      DeleteEntireDataset(DS_EmployeeDeductions);
      LoadAwardDeductions(DS_Award, DS_ClassificationDeductions, DS_Employee, DS_EmployeeDeductions);

        // Load Pay Rates
      DeleteEntireDataset(DS_EmployeePayRates);
      LoadAwardRates(DS_Award, DS_Classification, DS_ClassificationExtraPayRates, DS_Employee, DS_EmployeePayRates);

        // Update Employee Totals
      Pay := TPayObj.Create;
      Try
        Pay.Employee.DataSet := DS_Employee;
        Pay.PayRates.DataSet := DS_EmployeePayRates;
        Pay.Allowances.DataSet := DS_EmployeeAllowances;
        Pay.Deductions.DataSet := DS_EmployeeDeductions;
        Pay.Superannuation.DataSet := DS_EmployeeSuper;
        Pay.Leave.LeaveAccrued.DataSet := DS_EmployeeLeave;
        Pay.Recalc;
        DS_Employee.Edit;
        DS_Employee.FieldByName('Wages').AsFloat := Pay.PayTotals.Wages;
        DS_Employee.FieldByName('Deductions').AsFloat := Pay.PayTotals.Deduction;
        DS_Employee.FieldByName('Allowances').AsFloat := Pay.PayTotals.Allowances;
        DS_Employee.FieldByName('Super').AsFloat := Pay.PayTotals.Superannuation;
        DS_Employee.FieldByName('Gross').AsFloat := Pay.PayTotals.Gross;
        DS_Employee.FieldByName('Tax').AsFloat := Pay.PayTotals.Tax;
        DS_Employee.FieldByName('Net').AsFloat := Pay.PayTotals.Net;
        DS_Employee.Post;
        DS_Employee.Edit;
      finally
        FreeAndNil(Pay);
      end;
    end;
    // Re-Load Unprocessed Pay
    If Recreate_Unprocessed_Pay then CreatePay(DS_Employee.FieldByName('EmployeeID').asInteger);
  finally
    DS_EmployeePayRates.EnableControls;
    If Assigned(DS_ExistLeaves) then FreeAndNil(DS_ExistLeaves);
  end;
end;

procedure TPayFunctionObj.PrintUnprocessedPaysReport(const Preview: Boolean);
var
  sSQL: String;
  qryTemp:TMyQuery;
  Templates: TReportTemplates;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := False;
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT Sum(P.Wages) as Wages,Sum(P.Commission) as Commission,Sum(P.Deductions) as Deductions,');
    qryTemp.Sql.Add('Sum(P.Allowances) as Allowances,Sum(P.Sundries) as Sundries,Sum(P.Superannuation) as Superannuation,');
    qryTemp.Sql.Add('Sum(P.Gross) as Gross,Sum(P.Tax) as Tax,Sum(P.Net) as Net,Sum(P.CDEPGross) as CDEPGross ');
    qryTemp.Sql.Add('FROM tblpays AS P WHERE Paid = "F" And Pay="T" AND Deleted = "F"');
    qryTemp.Open;
    Templates := TReportTemplates.Create;
    with Templates do begin
      GetSQLForReport('Payslip Report'); // creates  report stream
      sSQL := 'SELECT   CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,  Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,     Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN AS ABN,'+
              'P.PayDate, P.Wages, P.Commission, P.Deductions, P.Allowances, P.Sundries, P.Superannuation, P.Gross, P.Tax, P.Net, P.CDEPGross, P.EmpName,'+
              'PR.PayID, PR.Qty, PR.Amount, PR.LineTotal, R.Description,'+

              FloatToStr(qryTemp.FieldByName('Wages').AsFloat)+' as TotalWages,'+
              FloatToStr(qryTemp.FieldByName('Commission').AsFloat)+' as TotalCommission,'+
              FloatToStr(qryTemp.FieldByName('Deductions').AsFloat)+' as TotalDeductions,'+
              FloatToStr(qryTemp.FieldByName('Allowances').AsFloat)+' as TotalAllowances,'+
              FloatToStr(qryTemp.FieldByName('Sundries').AsFloat)+' as TotalSundries,'+
              FloatToStr(qryTemp.FieldByName('Superannuation').AsFloat)+' as TotalSuperannuation,'+
              FloatToStr(qryTemp.FieldByName('Gross').AsFloat)+' as TotalGross,'+
              FloatToStr(qryTemp.FieldByName('Tax').AsFloat)+' as TotalTax,'+
              FloatToStr(qryTemp.FieldByName('Net').AsFloat)+' as TotalNet,'+
              FloatToStr(qryTemp.FieldByName('CDEPGross').AsFloat)+' as TotalCDEPGross '+

              'FROM tblCompanyInformation AS CO, tblpays AS P '+
              'INNER JOIN tblpayspayrates AS PR Using(PayID) '+
              'INNER JOIN tblpayrates AS R ON PR.PayRateID = R.RateID ';
      sSQL := sSQL + 'WHERE Paid = "F" and Pay="T" and Deleted="F" ORDER BY P.EmpName';

      with GetMyQuery(1) do begin
        Close;
        Sql.Clear;
        Sql.Add(sSQL);
        Open;
      end;
      ReportStream.Position := 0;
      Report.Template.LoadFromStream(ReportStream);
      Report.ShowPrintDialog := false;
      if not Preview then begin
        Report.DeviceType := 'Printer';
      end;

      Try
        Report.Print;
      except
        on E: Exception do begin
          If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
            CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
          end else
            raise;
        end;
      end;

    end;
  finally
    FreeAndNil(qryTemp);
    FreeAndNil(Templates);
  end;
end;

procedure TPayFunctionObj.PrintPayHistoryReport(const Preview: Boolean;dtFrom:TDateTime;dtTo:TDateTime);
var
  sSQL: String;
  qryTemp:TMyQuery;
  Templates: TReportTemplates;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := False;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT Sum(P.Wages) as Wages,Sum(P.Commission) as Commission,Sum(P.Deductions) as Deductions,');
    qryTemp.Sql.Add('Sum(P.Allowances) as Allowances,Sum(P.Sundries) as Sundries,Sum(P.Superannuation) as Superannuation,');
    qryTemp.Sql.Add('Sum(P.Gross) as Gross,Sum(P.Tax) as Tax,Sum(P.Net) as Net,Sum(P.CDEPGross) as CDEPGross ');
    qryTemp.Sql.Add('FROM tblpays AS P WHERE Paid = "T" And Pay="F"');
    qryTemp.Sql.Add(' AND PayDate BETWEEN ' + QuotedStr(FormatDateTime ('yyy-mm-dd',dtFrom)) + ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dtTo)));

    qryTemp.Open;
    Templates := TReportTemplates.Create;
    with Templates do begin
      GetSQLForReport('Pay History Report'); // creates  report stream
      sSQL := 'SELECT   CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,  Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,     Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN AS ABN,'+
              'P.PayDate, P.Wages, P.Commission, P.Deductions, P.Allowances, P.Sundries, P.Superannuation, P.Gross, P.Tax, P.Net, P.CDEPGross, P.EmpName,'+
              'PR.PayID, PR.Qty, PR.Amount, PR.LineTotal, R.Description,'+

              FloatToStr(qryTemp.FieldByName('Wages').AsFloat)+' as TotalWages,'+
              FloatToStr(qryTemp.FieldByName('Commission').AsFloat)+' as TotalCommission,'+
              FloatToStr(qryTemp.FieldByName('Deductions').AsFloat)+' as TotalDeductions,'+
              FloatToStr(qryTemp.FieldByName('Allowances').AsFloat)+' as TotalAllowances,'+
              FloatToStr(qryTemp.FieldByName('Sundries').AsFloat)+' as TotalSundries,'+
              FloatToStr(qryTemp.FieldByName('Superannuation').AsFloat)+' as TotalSuperannuation,'+
              FloatToStr(qryTemp.FieldByName('Gross').AsFloat)+' as TotalGross,'+
              FloatToStr(qryTemp.FieldByName('Tax').AsFloat)+' as TotalTax,'+
              FloatToStr(qryTemp.FieldByName('Net').AsFloat)+' as TotalNet,'+
              FloatToStr(qryTemp.FieldByName('CDEPGross').AsFloat)+' as TotalCDEPGross '+

              'FROM tblCompanyInformation AS CO, tblpays AS P '+
              'INNER JOIN tblpayspayrates AS PR Using(PayID) '+
              'INNER JOIN tblpayrates AS R ON PR.PayRateID = R.RateID ';
      sSQL := sSQL + 'WHERE Paid = "T" and Pay="F" ';
      sSQL := sSQL + ' AND P.PayDate BETWEEN ' + QuotedStr(FormatDateTime ('yyy-mm-dd',dtFrom)) + ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dtTo));
      sSQL := sSQL + ' ORDER BY P.EmpName';
      
      with GetMyQuery(1) do begin
        Close;
        Sql.Clear;
        Sql.Add(sSQL);
        Open;
      end;
      ReportStream.Position := 0;
      Report.Template.LoadFromStream(ReportStream);
      Report.ShowPrintDialog := false;
      if not Preview then begin
        Report.DeviceType := 'Printer';
      end;

      Try
        Report.Print;
      except
        on E: Exception do begin
          If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
            CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
          end else
            raise;
        end;
      end;
      
    end;
  finally
    FreeAndNil(qryTemp);
    FreeAndNil(Templates);
  end;
end;
procedure TPayFunctionObj.LoadTimeSheet;
var
  Pay: TPayObj;
//  OldCursor: TCursor;
  qryTimesheet: TMyQuery;
  qryTimesheetList: TMyQuery;
  qryPays: TMyQuery;
  qryPayRates: TMyQuery;
  iEmpID: Integer;
  dtLastDate, dtThisDate: TDateTime;
  dWage, dStdHours, dRemainHours: Double;
  dStdWage: Double;
  PR: TPayRecord;
  bPayingEmployee: Boolean;
  iPayID: Integer;

begin
  inherited;
  qryPayRates := TMyQuery.Create(nil);
  qryTimesheetList := TMyQuery.Create(nil);
  qryTimesheet := TMyQuery.Create(nil);
  qryPays := TMyQuery.Create(nil);

  try
    qryPayRates.Options.FlatBuffers := True;
    qryTimesheetList.Options.FlatBuffers := True;
    qryTimesheet.Options.FlatBuffers := True;
    qryPays.Options.FlatBuffers := True;


    // Get our pays that need to be processed.
    qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryPays.SQL.Clear;
    qryPays.SQL.Add('SELECT * FROM tblPays WHERE EmployeeID = :xEmployeeID AND Paid = ''F'' AND Deleted = ''F''');

    // Get our Timesheet Table.
    qryTimesheet.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTimesheet.SQL.Clear;

    qryTimesheet.SQL.Add('SELECT Sum(Total) As Wage, Sum(Hours) AS WorkedHours, tblTimesheets.* FROM tblTimesheets');
    qryTimesheet.SQL.Add('WHERE (Active = "T")');
    qryTimesheet.SQL.Add('GROUP BY EmployeeID,ClassID');
    qryTimesheet.SQL.Add('ORDER BY EmployeeName');
    qryTimesheet.Open;

    if qryTimesheet.RecordCount < 1 then begin
       CommonLib.MessageDlgXP_Vista('Currently there is no listed timesheet entries to be processed!', mtWarning, [mbOK], 0);
       Exit;
    end;

    // Get our Timesheet Table.
    qryTimesheetList.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTimesheetList.SQL.Clear;
    qryTimesheetList.SQL.Add('SELECT Sum(Total) As Wages, Sum(SuperAmount) AS Super, Sum(Hours) AS WorkedHours, tblTimesheets.* FROM tblTimesheets');
    qryTimesheetList.SQL.Add('WHERE (Active = "T" AND EmployeeID = :xEmpID AND Date BETWEEN :xFrom AND :xTo)');
    qryTimesheetList.SQL.Add('GROUP BY EmployeeID,PayRateTypeID,JobID,ServiceID,LabourCost,ChargeRate,HourlyRate,ClassID');

    // Get our Pay Rates.
    qryPayRates.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryPayRates.SQL.Clear;
    qryPayRates.SQL.Add('SELECT * FROM tblPaysPayRates');
    qryPayRates.Open;

    // Process Timesheet Pays.
    qryTimeSheet.First;
    while not qryTimesheet.EOF do begin
      bPayingEmployee := False;
      if bPayingEmployee then ; // Get rid of hint warning.

      iEmpID := qryTimeSheet.FieldByName('EmployeeID').AsInteger;

      // Get date range to retrieve pay hours for
      dtLastDate := GetLastPayDate(iEmpID);
      dtThisDate := GetEmployeeNextPayDate(iEmpID);
      dStdHours := GetStandardTotalHours(iEmpID);

      qryTimesheetList.Close;
      qryTimesheetList.Params.ParamByName('xEmpID').asInteger := iEmpID;
      qryTimesheetList.Params.ParamByName('xFrom').asDateTime := dtLastDate;
      qryTimesheetList.Params.ParamByName('xTo').asDateTime := dtThisDate;
      qryTimesheetList.Open;
      dRemainHours := dStdHours - GetTotalWorkedHours(iEmpID, dtLastDate, dtThisDate);

      // Did we get a valid date range?
      if dtThisDate = 0 then begin
         // Then default the pay for now.
         dtThisDate := Now;
      end;

      // Now we need to Get the gross wage for this employee.
      dWage := GetEmployeeGrossWageFromTimesheet(iEmpID, dtLastDate, dtThisDate);

      // We need to now determine if we need to add any remaining hours
      // to this set wage.
      PR := GetBiggestStandardPayRateDetails(iEmpID);

      if not PR.ClassID = 0 then begin
         // Nope, get next timesheet entry.
         qryTimeSheet.Next;
         continue;
      end;

      // No wage for this employee?
      if dWage = 0 then begin
         // Nope, get next timesheet entry.
         qryTimeSheet.Next;
         continue;
      end;

      bPayingEmployee := True;
      if dRemainHours > 0 then begin
         dStdWage := PR.Rate * dRemainHours;
         dWage := dWage + dStdWage;
      end;

      qryPays.Close;
      qryPays.Params.ParamByName('xEmployeeID').asInteger := iEmpID;
      qryPays.Open;

      // Now create the Pay Header.
      if qryPays.RecordCount > 0 then begin
         iPayID := qryPays.FieldByName('PayID').AsInteger;
         qryPays.Edit;
         qryPays.FieldByName('Wages').AsFloat := dWage;
         qryPays.FieldByName('Allowances').AsFloat := 0.00;
         qryPays.FieldByName('Superannuation').AsFloat := 0.00;
         qryPays.FieldByName('Gross').AsFloat :=  0.00;
         qryPays.FieldByName('Tax').AsFloat :=  0.00;
         qryPays.FieldByName('Deductions').AsFloat :=  0.00;
         qryPays.FieldByName('IsTimesheet').AsString := 'T';
         qryPays.FieldByName('Net').AsFloat := 0.00;
         qryPays.FieldByName('PayPeriod').AsString := GetEmployeePayPeriod(iEmpID);
         qryPays.FieldByName('Prepared').AsString := 'F';
         qryPays.Post;
      end else begin
         qryPays.Insert;
         qryPays.FieldbyName('EmployeeID').AsInteger := iEmpID;
         qryPays.FieldByName('EmpName').AsString := GetEmployeeName(iEmpID);
         qryPays.FieldByName('PayDate').AsDateTime := dtThisDate;
         qryPays.FieldByName('Wages').AsFloat := dWage;
         qryPays.FieldByName('Allowances').AsFloat :=  0.00;
         qryPays.FieldByName('Superannuation').AsFloat :=  0.00;
         qryPays.FieldByName('Gross').AsFloat :=  0.00;
         qryPays.FieldByName('Tax').AsFloat := 0.00;
         qryPays.FieldByName('Deductions').AsFloat :=  0.00;
         qryPays.FieldByName('IsTimesheet').AsString := 'T';
         qryPays.FieldByName('Net').AsFloat :=  0.00;
         qryPays.FieldByName('PayPeriod').AsString := GetEmployeePayPeriod(iEmpID);
         qryPays.FieldByName('Prepared').AsString := 'F';
         qryPays.Post;
         iPayID := qryPays.FieldByName('PayID').AsInteger;
      end;
      //need to delete unprocessed pays
      ReallyDeletePayRecords('tblpayspayrates', iPayID);
      ReallyDeletePayRecords('tblpaysleave', iPayID);
      ReallyDeletePayRecords('tblleaveaccruals', iPayID);
      ReallyDeletePayRecords('tblpaystransactions', iPayID);


      while not qryTimesheetList.EOF do begin
        with qryPayRates do begin
          Insert;
          FieldByName('PayID').AsInteger := iPayID;
          FieldByName('ClassID').AsInteger := qryTimesheetList.FieldByName('ClassID').AsInteger;
          FieldByName('ClassName').AsString := qryTimesheetList.FieldByName('ClassName').AsString;
          FieldByName('ClientID').AsInteger := qryTimesheetList.FieldByName('JobID').AsInteger;
          FieldByName('PayRateID').AsInteger := qryTimesheetList.FieldByName('PayRateTypeID').AsInteger;
          FieldByName('Qty').AsFloat := qryTimesheetList.FieldByName('WorkedHours').AsFloat;
          FieldByName('Amount').AsFloat := qryTimesheetList.FieldByName('LabourCost').AsFloat;
          FieldByName('LineTotal').AsFloat := qryTimeSheetList.FieldByName('Wages').AsFloat;
          FieldByName('TypeID').AsInteger := GetPayRateTypeID('Hourly Rate');
          FieldByName('SuperInc').AsString := 'T';
          FieldByName('TimeSheetId').AsInteger := qryTimesheetList.FieldByName('ID').AsInteger;
          Post;
        end;

        // Fetch next timesheet entry for this employee.
        qryTimesheetList.Next;
      end;

      // Do we have any remaining hours that need to be added
      // to this pay? If so, lets add it in now.
      if (dRemainHours > 0) and (bPayingEmployee) then begin
        with qryPayRates do begin
          Insert;
          FieldByName('PayID').AsInteger := iPayID;
          FieldByName('ClassID').AsInteger := PR.ClassID;
          FieldByName('ClassName').AsString := GetClassName(PR.ClassID);
          FieldByName('ClientID').AsInteger := PR.JobID;
          FieldByName('PayRateID').AsInteger := GetPayRateID('Normal Hours');
          FieldByName('Qty').AsFloat := dRemainHours;
          FieldByName('Amount').AsFloat := PR.Rate;
          FieldByName('LineTotal').AsFloat := dRemainHours * PR.Rate;
          FieldByName('TypeID').AsInteger := GetPayRateTypeID('Hourly Rate');
          FieldByName('SuperInc').AsString := 'T';
          FieldByName('TimeSheetId').AsInteger := qryTimesheetList.FieldByName('ID').AsInteger;
          Post;
        end;
      end;

      //Recalc Pay
      Pay := TPayObj.Create;
      Try
        LoadPayTables(iPayID,False);
        Pay.DataSet := DSPay;
        Pay.Employee.DataSet := DSEmployee;
        Pay.PayRates.DataSet := DSPayPayRates;
        Pay.Allowances.DataSet := DSPayAllowances;
        Pay.Deductions.DataSet := DSPayDeductions;
        Pay.Sundries.DataSet := DSPaySundries;
        Pay.Commission.DataSet := DSPayCommission;
        Pay.Superannuation.DataSet := DSPaySuper;
        Pay.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
        Pay.PayPaySplits.DataSet := DSPayPaySplits;
        Pay.PaySplit.DataSet := DSPaySplit;
        Pay.Recalc;
        //Pay Totals
        qryPays.Edit;
        qryPays.FieldByName('Allowances').AsFloat := Pay.PayTotals.Allowances;
        qryPays.FieldByName('Deductions').AsFloat := Pay.PayTotals.Deduction;
        qryPays.FieldByName('Sundries').AsFloat := Pay.PayTotals.Sundries;
        qryPays.FieldByName('Commission').AsFloat := Pay.PayTotals.Commission;
        qryPays.FieldByName('Superannuation').AsFloat := Pay.PayTotals.Superannuation;
        qryPays.FieldByName('CDEPGross').AsFloat := Pay.PayTotals.GrossCDEP;
        qryPays.FieldByName('Wages').AsFloat := Pay.PayTotals.Wages;
        qryPays.FieldByName('Gross').AsFloat := Pay.PayTotals.Gross;
        qryPays.FieldByName('Prepared').AsString := 'F';

        //For Group Cert
        qryPays.FieldByName('AllowancesBeforeTax').AsFloat := Pay.PayTotals.AllowancesBeforeTax;
        qryPays.FieldByName('GrossTaxable').AsFloat := Pay.PayTotals.GrossTaxable;

        qryPays.FieldByName('LeaveLoading').AsFloat := Pay.Employee.EmployeeSettings.LeaveLoading;
        qryPays.FieldByName('Tax').AsFloat := Pay.PayTotals.Tax;
        qryPays.FieldByName('Net').AsFloat := Pay.PayTotals.Net;
        qryPays.Post;
      finally
        FreeAndNil(Pay);
      end;

      // State that this timesheet entry for this employee has been converted.
      UpdateTimesheetAsConverted(iEmpID, dtLastDate, dtThisDate);

      // Fetch next timesheet record.
      qryTimesheet.Next;
    end;

    CommonLib.MessageDlgXP_Vista('The Employees Timesheets has now been Loaded.', mtInformation, [mbOK], 0);

  finally
    // Free our used objects.
    if Assigned(qryPays) then FreeAndNil(qryPays);
    if Assigned(qryPayRates) then FreeAndNil(qryPayRates);
    if Assigned(qryTimesheet) then FreeAndNil(qryTimesheet);
    if Assigned(qryTimesheetList) then FreeAndNil(qryTimesheetList);
  end;
end;

procedure TPayFunctionObj.DeleteEmployeePayLeave(Const iPayID: Integer);
var
  qry: TMyQuery;
begin
  qry := nil;
  try
    qry := TMyQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM tblpaysleave WHERE PayID = :xPayID;');
    qry.Params.ParamByName('xPayID').asInteger := iPayID;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPayFunctionObj.DeleteEmployeePayRates(Const iPayID: Integer);
var
  qry: TMyQuery;
begin
  qry := nil;
  try
    qry := TMyQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM tblpayspayrates WHERE PayID = :xPayID;');
    qry.Params.ParamByName('xPayID').asInteger := iPayID;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPayFunctionObj.LoadRoster ;
var
  qryMain,qryPayRates,qryTimesheet,qryClass,qryPays : TMyQuery;
  lstLeave: TList;
  iEmpID,iClassID,i: integer;
  bLoadHoursFromRoster,bLoadLeaveFromRoster: boolean;
  dMealBreakHours, dMealBreakThreshold,dRosterHrs: double;
  dtThisDate: TDateTime;
  Pay : TPayObj;
  SavedCursor: Tcursor;
begin    //Load Roster
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  lstLeave := TList.Create;

  qryMain := TMyQuery.Create(nil);
  qryMain.Options.FlatBuffers := True;
  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;

  qryMain.SQL.Add('SELECT p.PayID, p.EmployeeID, p.EmpName,p.PayDate,p.DatePaid, p.Wages,');
  qryMain.SQL.Add('p.Commission, p.Deductions,p.Allowances, p.Sundries, p.PayPeriods, p.Superannuation,');
  qryMain.SQL.Add('p.Gross, p.Tax, p.Net, p.Paid, p.Pay, p.PayPeriod, p.CDEPGross,e.LastPaid,e.LoadHoursFromRoster');
  qryMain.SQL.Add('FROM tblPays AS p LEFT JOIN tblemployees AS e ON p.EmployeeID=e.EmployeeID');
  qryMain.SQL.Add('WHERE p.Paid <> "T" AND p.Deleted = "F" GROUP BY p.EmployeeID  ORDER BY p.EmpName');

  qryPays := TMyQuery.Create(nil);
  qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPays.SQL.Clear;
  qryPays.SQL.Add('SELECT * FROM tblpays Where PayID=:xPayID AND Deleted = ');
  qryPays.SQL.Add(QuotedStr('F'));

  qryPayRates := TMyQuery.Create(nil);
  qryClass := TMyQuery.Create(nil);
  qryTimesheet := TMyQuery.Create(nil);
  try
    qryPayRates.Options.FlatBuffers := True;
    qryClass.Options.FlatBuffers := True;
    qryTimesheet.Options.FlatBuffers := True;
    qryMain.Open;
    // for each current pay ...
    qryMain.First;

    qryPayRates.Connection := CommonDbLib.GetSharedMyDacConnection;

    qryPayRates.SQL.Clear;
    qryPayRates.SQL.Add('SELECT * FROM tblpayspayrates WHERE (PayID = :xPayID AND ClassID = :xClassID)');

    qryClass.Connection := qryMain.Connection;
    qryClass.SQL.Clear;
    qryClass.SQL.Add('SELECT ClassID, ClassName FROM tblClass ORDER By ClassID');
    qryClass.Open;


    qryTimesheet.Connection := qryMain.Connection;
    qryTimesheet.SQL.Clear;
    qryTimesheet.SQL.Add('UPDATE tblTimesheets SET Active=''T'', UseTimeCost=''F'' WHERE (Date >= :xFromDate AND EmployeeID = :xEmpID)');

    while not qryMain.Eof do begin
      Application.ProcessMessages;
      iEmpID := qryMain.FieldByName('EmployeeID').AsInteger;
      // Ensure this employee is on the roster. If not, then do not
      // disturb the pay that already exists for this employee.
      if qryMain.FieldByName('LoadHoursFromRoster').AsString = 'F' then begin
         qryMain.Next;
         continue;
      end;

      DeleteEmployeePayLeave(qryMain.FieldByName('PayID').AsInteger);
      DeleteEmployeePayRates(qryMain.FieldByName('PayID').AsInteger);

      // Reactivate timesheet entries for this employee.
      qryTimesheet.Params.ParamByName('xEmpID').asInteger := iEmpID;
      qryTimesheet.Params.ParamByName('xFromDate').AsDate := qryMain.FieldByName('LastPaid').AsDateTime;
      qryTimesheet.Execute;

      // Get employee's Normal Hourly Rate.
      SetPayObject(iEmpID);
        //recPR := GetNormPayRateRec(iEmpID);

      // Get date range to retrieve roster hours for
      dtThisDate := qryMain.FieldByName('PayDate').AsDateTime;

      qryClass.First;
      while not qryClass.EOF do begin
        iClassID := qryClass.FieldByName('ClassID').AsInteger;

        qryPayRates.Close;
        qryPayRates.Params.ParamByName('xPayID').AsInteger := qryMain.FieldByName('PayID').AsInteger;
      //  qryPayRates.Params.ParamByName('xEmployeeID').AsInteger := iEmpID;
        qryPayRates.Params.ParamByName('xClassID').AsInteger := iClassID;
        qryPayRates.Open;

        if GetEmployeeRosterParams(iEmpID, bLoadHoursFromRoster, bLoadLeaveFromRoster,
                                   dMealBreakHours, dMealBreakThreshold) then begin

          // Load Leave hours
          if bLoadLeaveFromRoster then begin

         //   DeleteEmployeePayLeave(qryMain.FieldByName('PayID').AsInteger);
         //   DeleteEmployeePayRates(qryMain.FieldByName('PayID').AsInteger);
            //ADD LEAVE RECS IN ABOVE TABLES
            LoadLeaveFromRoster(iEmpID,qryMain.FieldByName('PayID').AsInteger,iClassID,
                                     IncDay(TempPay.Employee.EmployeeSettings.LastPaid), dtThisDate);

            // if Payroll.LeaveForThisDepartment(iEmpID, iClassID) then begin
             //   GetLeaveFromRoster(iEmpID,iClassID, IncDay(TempPay.Employee.EmployeeSettings.LastPaid), dtThisDate, qryMain.FieldByName('PayID').AsInteger);
              //  CheckLeaveHours(iEmpID, lstLeave);
              //  UpdateLeaveHours(iEmpID, qryMain.FieldByName('PayID').AsInteger, lstLeave, iClassID); // update this pay with the hrs
            // end;
          end;

          // load the roster hours worked
          if bLoadHoursFromRoster then begin
             dRosterHrs := GetHoursFromRoster(iEmpID, IncDay(TempPay.Employee.EmployeeSettings.LastPaid), dtThisDate,
                                             dMealBreakHours, dMealBreakThreshold, iClassID);
       //      TempPay.PayRates.
             if dRosterHrs > 0 then begin
               with qryPayRates do begin
                 Insert;
                 FieldByName('PayID').AsInteger := qryMain.FieldByName('PayID').AsInteger;
               //  FieldByName('EmployeeID').AsInteger := iEmpID;

              //   FieldByName('PayRateID').AsInteger := 2; //HARD CODED TO NORMAL?????  //GetNormalHoursID;
                 FieldByName('PayRateID').AsInteger := GetNormalHoursID;


                 FieldByName('TypeID').AsInteger := GetPayRateTypeID('Hourly Rate');
                 FieldByName('Qty').AsFloat := dRosterHrs;
                 FieldByName('Amount').AsFloat := TempPay.PayRates.HourlyRate;//recPR.HourlyRate;
                 FieldByName('LineTotal').AsFloat := dRosterHrs * TempPay.PayRates.HourlyRate;//recPR.HourlyRate;
                 FieldByName('ClassID').AsInteger := iClassID;
                 FieldByName('ClassName').AsString := GetClassName(iClassID);
                 FieldByName('ClientID').AsInteger := 0;
                 Post;
               end;
             end;
          end;
          // Load(change) hours for the pay that has been created previously in tblpays

        end;

        // Fetch Next Class Record.
        qryClass.Next;
      end;

      if bLoadHoursFromRoster then begin
         // Now Recalculate Employees Pay
        LoadPayTables(qryMain.FieldByName('PayID').AsInteger,False);
        Pay := TPayObj.Create;
        Try
          Pay.DataSet := DSPay;
          Pay.Employee.DataSet := DSEmployee;
          Pay.PayRates.DataSet := DSPayPayRates;
          Pay.Allowances.DataSet := DSPayAllowances;
          Pay.Deductions.DataSet := DSPayDeductions;
          Pay.Sundries.DataSet := DSPaySundries;
          Pay.Commission.DataSet := DSPayCommission;
          Pay.Superannuation.DataSet := DSPaySuper;
          Pay.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
          Pay.Recalc;
          //Create Pay
          DSPay.Edit;
          //load to tblpays
          if qryPays.Active then qryPays.Close;
          qryPays.Params.ParamByName('xPayID').AsInteger := qryMain.FieldByName('PayID').AsInteger;
          qryPays.Open;
          //Pay Totals
          qryPays.Edit;
          qryPays.FieldByName('Allowances').AsFloat := Pay.PayTotals.Allowances;
          qryPays.FieldByName('Deductions').AsFloat := Pay.PayTotals.Deduction;
          qryPays.FieldByName('Sundries').AsFloat := Pay.PayTotals.Sundries;
          qryPays.FieldByName('Commission').AsFloat := Pay.PayTotals.Commission;
          qryPays.FieldByName('Superannuation').AsFloat := Pay.PayTotals.Superannuation;
          qryPays.FieldByName('CDEPGross').AsFloat := Pay.PayTotals.GrossCDEP;
          qryPays.FieldByName('Wages').AsFloat := Pay.PayTotals.Wages;
          qryPays.FieldByName('Gross').AsFloat := Pay.PayTotals.Gross;
          qryPays.FieldByName('Prepared').AsString := 'F';

          //For Group Cert
          qryPays.FieldByName('AllowancesBeforeTax').AsFloat := Pay.PayTotals.AllowancesBeforeTax;
          qryPays.FieldByName('GrossTaxable').AsFloat := Pay.PayTotals.GrossTaxable;

          qryPays.FieldByName('LeaveLoading').AsFloat := Pay.Employee.EmployeeSettings.LeaveLoading;
          qryPays.FieldByName('Tax').AsFloat := Pay.PayTotals.Tax;
          qryPays.FieldByName('Net').AsFloat := Pay.PayTotals.Net;
          qryPays.Post;
          qryPays.Edit;
        Finally
          FreeAndNil(Pay);
        end;
      end;

      for i := 0 to lstLeave.Count-1 do begin
        Dispose(lstLeave.Items[i]);
      end;

      lstLeave.Clear;

      // Fetch Next Pay Record.
      qryMain.Next;
    end;

  //end;

    CommonLib.MessageDlgXP_Vista('Roster Loading Completed' + #13 + #10 + 'Click OK to update.'  , mtInformation, [mbOK], 0);
  finally
    // Free our used objects.
    if Assigned(qryClass) then FreeAndNil(qryClass);
    if Assigned(qryPayRates) then FreeAndNil(qryPayRates);
    if Assigned(qryTimesheet) then FreeAndNil(qryTimesheet);
    DestroyPayObject;
    FreeAndNil(lstLeave);
    Screen.Cursor := SavedCursor;
  end;
end;

function TPayFunctionObj.GetNormalHoursID:integer;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection; ;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT RateID, Description FROM tblPayRates WHERE Description = ' + QuotedStr('Normal Hours'));
    qry.Open;
    result := qry.FieldByName('RateID').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

function TPayFunctionObj.GetEmployeeRosterParams(const iEmployeeID: Integer;
       var bLoadHours, bLoadLeave: boolean;
       var dMealBreakHours, dMealBreakThreshold: double): boolean;
var
  qry: TMyQuery;
begin
  result := false;
  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT EmployeeID, LoadHoursFromRoster, LoadLeaveFromRoster, ' +
              'MealBreakHours, MealBreakThreshold ' +
              'FROM tblEmployees ' +
              'WHERE EmployeeID = :xEmployeeID');
      ParamByName('xEmployeeID').asInteger := iEmployeeID;
      Open;
      if not IsEmpty then begin
        result := true;
        bLoadHours := (qry.fieldbyname('LoadHoursFromRoster').AsString = 'T');
        bLoadLeave := (qry.fieldbyname('LoadLeaveFromRoster').AsString = 'T');
        dMealBreakHours := qry.Fieldbyname('MealBreakHours').AsFloat;
        dMealBreakThreshold := qry.Fieldbyname('MealBreakThreshold').AsFloat;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPayFunctionObj.VerifyPay(const iPayID: Integer);
Var
  Pay: TPayObj;
begin
  Pay := TPayObj.Create;
  try
    {Load Pay}
    LoadPayTables(iPayID,True);
    Pay.DataSet := DSPay;
    Pay.Employee.DataSet := DSEmployee;
    Pay.PayRates.DataSet := DSPayPayRates;
    Pay.PayPaySplits.DataSet := DSPayPaySplits;
    Pay.Allowances.DataSet := DSPayAllowances;
    Pay.Deductions.DataSet := DSPayDeductions;
    Pay.Sundries.DataSet := DSPaySundries;
    Pay.Commission.DataSet := DSPayCommission;
    Pay.Superannuation.DataSet := DSPaySuper;
    Pay.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
    Pay.ManualTax := True;  // MUST LEAVE TRUE : SEE IANOS
    Pay.IsPayVerify := True;
    Pay.Recalc;
    {Pay Totals}
    DSPay.Edit;
    DSPay.FieldByName('Allowances').AsFloat := Pay.PayTotals.Allowances;
    DSPay.FieldByName('Deductions').AsFloat := Pay.PayTotals.Deduction;
    DSPay.FieldByName('Sundries').AsFloat := Pay.PayTotals.Sundries;
    DSPay.FieldByName('Commission').AsFloat := Pay.PayTotals.Commission;
    DSPay.FieldByName('Superannuation').AsFloat := Pay.PayTotals.Superannuation;
    DSPay.FieldByName('CDEPGross').AsFloat := Pay.PayTotals.GrossCDEP;
    DSPay.FieldByName('Wages').AsFloat := Pay.PayTotals.Wages;
    DSPay.FieldByName('Gross').AsFloat := Pay.PayTotals.Gross;

    //For Group Cert
    DSPay.FieldByName('AllowancesBeforeTax').AsFloat := Pay.PayTotals.AllowancesBeforeTax;
    DSPay.FieldByName('GrossTaxable').AsFloat := Pay.PayTotals.GrossTaxable;

    DSPay.FieldByName('LeaveLoading').AsFloat := Pay.Employee.EmployeeSettings.LeaveLoading;
    DSPay.FieldByName('Tax').AsFloat := Pay.PayTotals.Tax;
    DSPay.FieldByName('Net').AsFloat := Pay.PayTotals.Net;
    DSPay.Post;
    {Accrued leave}
    Pay.Leave.LeaveTotals.AddLeaveAccrued;
    {Leave Taken}
    Pay.Leave.LeaveTotals.DeductLeaveTaken;
    {Post To Accounts}
    Pay.PostToAccounts;
    {Verfiy All Accrued Leave}

    //need to swap tmp_leave with tblleave here cause VerifyEmployeeLeave may edit it
    If Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);
    DSEmployeeLeave := RetrieveDataset('tblleave', 'EmployeeID',DSPay.FieldbyName('EmployeeID').asInteger);

    VerifyEmployeeLeave(DSEmployeeLeave);
    Pay.DataXML.DestroyTmpTables;
    
  finally
    FreeAndNil(Pay);
  end;
end;

function TPayFunctionObj.LoadUnprocessedPay(const iEmployeeID: Integer): TPayObj;
Var
  PayID :Integer;
begin
  Result := TPayObj.Create;
  PayID := GetUnprocessedPayID(iEmployeeID);
  LoadPayTables(PayID,False);
  Result.DataSet := DSPay;
  Result.Employee.DataSet := DSEmployee;
  Result.PayRates.DataSet := DSPayPayRates;
  Result.Allowances.DataSet := DSPayAllowances;
  Result.Deductions.DataSet := DSPayDeductions;
  Result.Sundries.DataSet := DSPaySundries;
  Result.Commission.DataSet := DSPayCommission;
  Result.Superannuation.DataSet := DSPaySuper;
  Result.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
  Result.Recalc;
end;

function TPayFunctionObj.LoadEmployeePay(const iEmployeeID: Integer): TPayObj;

begin
  Result := TPayObj.Create;

  LoadEmployeePayTables(iEmployeeID);
  Result.DataSet := DSPay;
  Result.Employee.DataSet := DSEmployee;
  Result.PayRates.DataSet := DSEmployeePayRates;
  Result.Allowances.DataSet := DSEmployeeAllowances;
  Result.Deductions.DataSet := DSEmployeeDeductions;
  Result.Sundries.DataSet := DSEmployeeSundries;
  Result.Commission.DataSet := DSEmployeeCommission;
  Result.Superannuation.DataSet := DSEmployeeSuper;
  Result.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
  Result.Recalc;

end;

procedure TPayFunctionObj.SGCInThisPay(const iPayID: Integer; Var SGC,SGCNoThreshold: Double);
Var
  PayTemp: TPayObj;
begin
  SGC := 0.00;
  SGCNoThreshold := 0.00;
  PayTemp := TPayObj.Create;
  try
    {Load Pay}
    LoadPayTables(iPayID,False);
    PayTemp.DataSet := DSPay;
    PayTemp.Employee.DataSet := DSEmployee;
    PayTemp.PayRates.DataSet := DSPayPayRates;
    PayTemp.Allowances.DataSet := DSPayAllowances;
    PayTemp.Deductions.DataSet := DSPayDeductions;
    PayTemp.Sundries.DataSet := DSPaySundries;
    PayTemp.Commission.DataSet := DSPayCommission;
    PayTemp.Superannuation.DataSet := DSPaySuper;
    PayTemp.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
    PayTemp.ManualTax := True;

    PayTemp.Superannuation.CalcSuperCatchUpMode := True;
    PayTemp.Recalc;
    SGCNoThreshold := PayTemp.Superannuation.SGCTotalNoSuperThreshold;
    SGC := PayTemp.Superannuation.SGCTotal;
    PayTemp.Superannuation.CalcSuperCatchUpMode := False;
   // PayTemp.Recalc;
   // SGC := PayTemp.Superannuation.SGCTotal;

  finally
    FreeAndNil(PayTemp);
  end;
end;

procedure TPayFunctionObj.SetPayObject(EmployeeID: integer);
begin
  If Assigned(TempPay) then FreeAndNil(TempPay);
  If Assigned(DSEmployee) then FreeAndNil(DSEmployee);
  If Assigned(DSEmployeePayRates) then FreeAndNil(DSEmployeePayRates);
  If Assigned(DSEmployeeAllowances) then FreeAndNil(DSEmployeeAllowances);
  If Assigned(DSEmployeeDeductions) then FreeAndNil(DSEmployeeDeductions);
  If Assigned(DSEmployeeSuper) then FreeAndNil(DSEmployeeSuper);
  If Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);
  If Assigned(DSPay) then FreeAndNil(DSPay);
  If Assigned(DSPaysPayRates) then FreeAndNil(DSPaysPayRates);
  If Assigned(DSPaySplit) then FreeAndNil(DSPaySplit);
  DSEmployee := RetrieveDataset('tblEmployees', 'EmployeeID',EmployeeID);
  DSEmployeePayRates := RetrieveDataset('tblemployeepayrates', 'EmployeeID',EmployeeID);
  DSPaySplit := RetrieveDataset('tblpaysplit', 'EmployeeID',EmployeeID);
  DSEmployeeAllowances := RetrieveDataset('tblemployeeallowances', 'EmployeeID',EmployeeID);
  DSEmployeeDeductions := RetrieveDataset('tblemployeedeductions', 'EmployeeID',EmployeeID);
  DSEmployeeSuper := RetrieveDataset('tblsuperannuation', 'EmployeeID',EmployeeID);
  DSEmployeeLeave := RetrieveDataset('tblleave', 'EmployeeID',EmployeeID);
  TempPay := TPayObj.Create;
  TempPay.Employee.DataSet := DSEmployee;
  TempPay.PayRates.DataSet := DSEmployeePayRates;
  TempPay.PaySplit.DataSet := DSPaySplit;
  TempPay.Allowances.DataSet := DSEmployeeAllowances;
  TempPay.Deductions.DataSet := DSEmployeeDeductions;
  TempPay.Superannuation.DataSet := DSEmployeeSuper;
  TempPay.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
  TempPay.Recalc;
end;

procedure TPayFunctionObj.DestroyPayObject;
begin
  If Assigned(TempPay) then FreeAndNil(TempPay);
  If Assigned(DSEmployee) then FreeAndNil(DSEmployee);
  If Assigned(DSEmployeePayRates) then FreeAndNil(DSEmployeePayRates);
  If Assigned(DSEmployeeAllowances) then FreeAndNil(DSEmployeeAllowances);
  If Assigned(DSEmployeeDeductions) then FreeAndNil(DSEmployeeDeductions);
  If Assigned(DSEmployeeSuper) then FreeAndNil(DSEmployeeSuper);
  If Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);
  If Assigned(DSPaySplit) then FreeAndNil(DSPaySplit);

end;


function TPayFunctionObj.GetHoursFromRoster(iEmployeeID: integer;
                              dtFrom, dtTo: TDateTime;
                              dMealBreak, dMealBreakThreshold: double; iClassID: Integer): double;
var
  i, j: integer;
//  iMealBreaks: integer;
  qry: TMyQuery;
  dHrs: double;
  lstTimes: TList;
  lstRostered: TList;
  pTimes, pRostered: pTimesRec;
  bUseClockedHours, bIgnoreEarlyStart, bIgnoreLateFinish: boolean;
  dDebug: double;
begin
  result := 0;

  bUseClockedHours := AppEnv.CompanyPrefs.UseClockedHrs;
  bIgnoreEarlyStart := AppEnv.CompanyPrefs.IgnoreEarlyStart;
  bIgnoreLateFinish := AppEnv.CompanyPrefs.IgnoreLateFinish;

  qry := TMyQuery.Create(nil);
  lstTimes := TList.Create;
  lstRostered := TList.Create;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;

 //    Create the Query to Get Entries in roster table for this employee.
 //    .. We will retrieve 'Clocked' OR  'Allocation' according to preference

    qry.SQL.Clear;
    qry.SQL.Add('SELECT RosterID, EmployeeID, Type, StartTime, EndTime, ClockedOff,TypeCatagory ' +
                'FROM tblroster ' +
              //  'WHERE (TypeCatagory = :xTypeCatagory AND ClassID = :xClassID AND ' +
                'WHERE IsClocked = :xIsClocked   AND ClassID = :xClassID AND ' +
                'EmployeeID = :xEmployeeID AND (StartTime BETWEEN :xFrom AND :xTo) AND ' +
                'TypeCatagory <> "Leave" ' +
                'ORDER BY StartTime');

    qry.ParamByName('xEmployeeID').asInteger := iEmployeeID;
    qry.ParamByName('xClassID').asInteger := iClassID;
    qry.ParamByName('xFrom').asDateTime := StartOfTheDay(dtFrom);
    qry.ParamByName('xTo').asDateTime := EndOfTheDay(dtTo);

    if bUseClockedHours then begin
      qry.ParamByName('xIsClocked').asString := 'T';
    end else begin
      qry.ParamByName('xIsClocked').asString := 'F';
    end;

  //   Create and fill lstTimes which is used for accumulating hours

    qry.Open;
    qry.First;
    while not qry.eof do begin
   //     if we are using clocked hours then we don't want to include any that
   //    .. have not been clocked off

      if (not bUseClockedHours) or
         (bUseClockedHours and (qry.FieldByName('ClockedOff').AsString = 'T')) then begin
        new(pTimes);
        lstTimes.Add(pTimes);
        pTimes^.dtStart := qry.FieldByName('StartTime').AsDateTime;
        pTimes^.dtEnd := qry.FieldByName('EndTime').AsDateTime;
      end;
      qry.Next;
    end;
    qry.Close;

     //    if using clocked hours and we want to ignore the early start and late finish
 //    ..then get a list of rostered hours for comparison and correction of clocked hours

    if bUseClockedHours and (bIgnoreEarlyStart or bIgnoreLateFinish) then begin
      qry.ParamByName('xIsClocked').asString := 'T';
      qry.Open;
      qry.First;
      while not qry.eof do begin
        new(pRostered);
        lstRostered.Add(pRostered);
        pRostered^.dtStart := qry.FieldByName('StartTime').AsDateTime;
        pRostered^.dtEnd := qry.FieldByName('EndTime').AsDateTime;
        pRostered^.bMatched := false;
        qry.Next;
      end;

   //    now correct the actual hours according to the rostered hours
  //     .. (wipe off early start or late finish hours)

      for i := 0 to lstTimes.Count-1 do begin
        pTimes := lstTimes[i];
        for j := 0 to lstRostered.Count -1 do begin
          pRostered := lstRostered[j];
          if (not pRostered^.bMatched) and
             (((pRostered^.dtStart <= pTimes^.dtStart) and
               (pRostered^.dtEnd >= pTimes^.dtStart)) or

              ((pRostered^.dtStart <= pTimes^.dtEnd) and
              (pRostered^.dtEnd >= pTimes^.dtEnd)) or

              ((pRostered^.dtStart >= pTimes^.dtStart) and
              (pRostered^.dtEnd <= pTimes^.dtEnd))) then begin

            if bIgnoreEarlyStart then begin
              if pTimes^.dtStart < pRostered^.dtStart then begin
                pTimes^.dtStart := pRostered^.dtStart;
              end;
            end;
            if bIgnoreLateFinish then begin
              if pTimes^.dtEnd > pRostered^.dtEnd then begin
                pTimes^.dtEnd := pRostered^.dtEnd;
              end;
            end;
            pRostered^.bMatched := true;
            break;
          end;
        end; // for j := 0....
      end; // for i := 0...
    end; // if bUseClockedHours and (bIgnoreEarlyStart or bIgnoreEarlyFinish)

  //   Now we accumulate the hours, correcting for meal break
    dDebug := 0;
    for i := 0 to lstTimes.Count-1 do begin
      pTimes := lstTimes[i];
      dHrs := HourSpan(pTimes^.dtEnd, pTimes^.dtStart);

      dDebug := dDebug +  HourSpan(pTimes^.dtEnd, pTimes^.dtStart);

      if dMealBreakThreshold > 0 then begin
        //iMealBreaks := Trunc(dHrs/(dMealBreakThreshold + dMealBreak));
//        dHrs := dHrs - iMealBreaks*(dMealBreakHours);
          if dMealBreak > dMealBreakThreshold then dMealBreak := dMealBreakThreshold; 
          dHrs := dHrs - dMealBreak;
        if dHrs < 0 then begin
          dHrs := 0;
        end;
      end;
      result := result + dHrs;
    end;

  finally
    for i := 0 to lstTimes.Count-1 do begin
      Dispose(lstTimes.Items[i]);
    end;
 
    FreeAndNil(lstTimes);
    for i := 0 to lstRostered.Count-1 do begin
      Dispose(lstRostered.Items[i]);
    end;
    FreeAndNil(lstRostered);
    FreeAndNil(qry);
  end;
end;

function TPayFunctionObj.GetLeaveLoading(Const EmployeeID: integer;Const sType:String): double;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetNewMyDacConnection(nil);
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EmployeeID,LeaveLoading,Type FROM tblleave WHERE EmployeeID = ' + FastFuncs.IntToStr(EmployeeID));
    qry.SQL.Add(' AND Type = ' + QuotedStr(sType));
    qry.Open;
    Result := qry.FieldByName('LeaveLoading').AsFloat / 100;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPayFunctionObj.LoadLeaveFromRoster(iEmpID: integer;iPayID: integer;iClassID: integer;dtFrom: TDateTime;dtTo: TDateTime);
var
  qryPaysPayRates,qryPaysLeave,qryRosterLeave: TMyQuery;
  dHrs,dMultiplier,dRate: double;
  sLeave: string;
  iBreaks: integer;
begin
  qryPaysPayRates := TMyQuery.Create(nil);
  qryPaysLeave := TMyQuery.Create(nil);
  qryRosterLeave := TMyQuery.Create(nil);
  qryPaysPayRates.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPaysLeave.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryRosterLeave.Connection := CommonDbLib.GetSharedMyDacConnection;

  try
    with qryRosterLeave do begin
      SQL.Clear;
      SQL.Add('SELECT EmployeeID, TypeCatagory,Type, StartTime, EndTime FROM tblroster ' +
              'WHERE ClassID = :xClassID AND EmployeeID = :xEmployeeID AND StartTime' +
              ' BETWEEN :xFrom AND :xTo AND TypeCatagory = "Leave"' );

      ParamByName('xEmployeeID').asInteger := iEmpID;
      ParamByName('xClassID').asInteger := iClassID;
      ParamByName('xFrom').asDateTime := StartOfTheDay(dtFrom);
      ParamByName('xTo').asDateTime := EndOfTheDay(dtTo);
      Open;
      First;
    end;

    while not qryRosterLeave.eof do begin
      sLeave := qryRosterLeave.FieldByName('Type').AsString;
      // Calc hours for this entry
      dHrs := HourSpan(qryRosterLeave.FieldByName('EndTime').AsDateTime,qryRosterLeave.FieldByName('StartTime').AsDateTime);

      // subtract meal break every 'dMealBreakThreshold' hours
      if dMealBreakThreshold > 0 then begin
        iBreaks := Trunc(divzer(dHrs, (dMealBreakThreshold + dMealBreakHours)));
        dHrs := dHrs - (iBreaks * dMealBreakHours);
        if dHrs < 0 then begin
          dHrs := 0;
        end;
      end;
        //insert a record for each leave
         // Add the new leave lines in tblPaysLeave
          with qryPaysLeave do begin
            Sql.Clear;
            Sql.Add('INSERT tblpaysleave (PayID, LeaveType, DateTaken, ClassID, ' +
                    'ClassName, Qty) VALUES (:xPayID, :xLeaveType, :xDateTaken, ' +
                    ':xClassID, :xClassName, :xQty)');

            with qryPaysLeave do begin
              ParamByName('xPayID').asInteger := iPayID;
              ParamByName('xLeaveType').asString := sLeave;
              ParamByName('xDateTaken').AsDateTime := qryRosterLeave.FieldByName('StartTime').AsDateTime;//dtDate;
              ParamByName('xClassID').asInteger := iClassID;
              ParamByName('xClassName').asString := GetClassName(iClassID);
              ParamByName('xQty').AsFloat := dHrs;
            end;

            Execute;
          end;
                    // Add the new leave lines in tblPaysPayRates
          with qryPaysPayRates do begin
            Sql.Clear;
            Sql.Add('INSERT tblpayspayrates (PayID, PayRateID, Amount, Qty, ' +
                    ' LineTotal, ClassID, ClassName, TypeID) VALUES (:xPayID, ' +
                    ' :xPayRateID, :xAmount, :xQty, :xLineTotal, :xClassID, ' +
                    ' :xClassName, :xTypeID)');

            with qryPaysPayRates do begin
              ParamByName('xPayID').asInteger := iPayID;
              ParamByName('xPayRateID').asInteger := GetPayRateID(qryRosterLeave.FieldByName('Type').AsString);//iLeaveRateID;

              ParamByName('xTypeID').asInteger := GetEmployeePayRateTypeID(iEmpID); //Hourly rate, salary etc

              ParamByName('xQty').AsFloat := dHrs;

              dMultiplier := GetPayRateMultiplier(GetPayRateID(qryRosterLeave.FieldByName('Type').AsString));

              dRate := TempPay.PayRates.HourlyRate * dMultiplier;
              //Add any Leave Loading
              dRate := dRate * (1 + GetLeaveLoading(iEmpID,qryRosterLeave.FieldByName('Type').AsString));

              ParamByName('xAmount').AsFloat := dRate;
              ParamByName('xLineTotal').AsFloat := dHrs * dRate;
              ParamByName('xClassID').asInteger := iClassID;
              ParamByName('xClassName').asString := GetClassName(iClassID);
            end;
            Execute;
          end;
     qryRosterLeave.Next;
    end;
  finally
    FreeAndNil(qryPaysPayRates);
    FreeAndNil(qryPaysLeave);
  end;
end;



end.



