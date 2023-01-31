unit BusObjPayUtils;

interface
{$I ERP.inc}

uses
  BusObjBase,Classes,BusObjEmployeePay,BusObjPayBase,DBAccess, MyAccess,ERPdbComponents,
  DB,EmailUtils;

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

type
   TpayUtils = class(TMSBusObj)
   private

//     CurrentPay  : Tpaybase;

     fPay              :Tpaybase;

     fPayForTimesheet     :Tpaybase;


     fEmployeePay      :Temployeepay;
     smallesttimesheetdt, largesttimesheetDt:TDatetime;
     procedure CallbackAddPayRatesToPay(const Sender: TBusObj; var Abort: Boolean);
     procedure TimeSheetDateCallback(const Sender: TBusObj; var Abort: Boolean);
     procedure CallbackAddDeductionsToPay(const Sender: TBusObj; var Abort: Boolean);
     procedure CallBackAddPaySplitsToPay(const Sender: TBusObj; var Abort: Boolean);
     procedure CallBackAddAllowancesToPay(const Sender: TBusObj; var Abort: Boolean);
     procedure CallBackAddSuperToPay(const Sender: TBusObj; var Abort: Boolean);
     procedure DeleteUnprocessedPay;

   public

     CurrentPay  : Tpaybase;
       CurrentConnection : TMyDacDataConnection;


      EmpAccRecList: TList;
      procedure Load(Const aId: integer;const fIsReadonly:boolean =False);override;
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor Create(AOwner: TComponent); overload;override;
      Constructor Create(AOwner: TComponent;PassedConnection:TERPConnection); reintroduce;overload;

      Destructor   Destroy;                                                override;
      Function Save:boolean; override;
      Function CreateNewPay(EmployeeID:integer;NewEmployee:Boolean;ModifyingPay:Boolean;Var FatalStatusItem: TResultStatusItem;const TerminationDate:TDatetime = 0):Boolean;
      procedure ProcessPay(const Pay:TPaybase;DatePaid:TDateTime;AddtoABA:Boolean;PreviewPaySlips:Boolean);
      procedure PrintPaySlip(Const ThisPay: TPaybase; Const Preview: Boolean; Const SendPaySlipViaEmail : String);
      procedure LoadTimeSheet(Pay:TPaybase;msgOption:Integer=0);
      procedure PrintPayHistoryReport(const Preview: Boolean;dtFrom:TDateTime;dtTo:TDateTime);
      procedure SendEmail(Const sEmailFrom,sEmailto,sPassword,sFilename,sSubject,sMessage:string);
      procedure PrintFromDB(Const empName:string; Const Preview: Boolean);
      procedure LoadRoster(const EmployeeID:integer);
      procedure VerifyAndFixAccruedLeave(iEmployeeID:integer);
      function PrintPaySlipSQL(const ThisPay: TPaybase): String;
      Function PaysReportSQL(const Preview: Boolean; const aPayId:Integer =0):String;
   end;

implementation
uses
  SysUtils,Dialogs,AppEnvironment,CommonLib,DateUtils,ReportTemplates,CommonDbLib,BusObjEmployeePayRates,
  BusObjEmployeeDeductions, BusObjEmployeePaySettings, BusObjLeaveAccruals,BusObjEmployeeLeave,Variants,
  DnMLib,BusObjPaysPayRatesBASE, tcTypes,Math,FastFuncs,BusObjEmployeePaySplit,BusObjEmployeeAllowances,
  PayCommon,BusObjPayssuperannuation, BusObjSuperannuation,ppZLib,AbZipKit,tcDataUtils,BusObjRoster,ABAObj,
  tcConst, BusObjTimeSheet, Windows, MySQLConst , Controls, PayAccounts, CorrespondenceObj, EmailExtraUtils,
  BusObjPaysDeductions;


Function TPayUtils.Save:Boolean;
begin
  try
    Self.fEmployeePay.Save;
    Result := True;
  except
    Result := False;
  end;
end;

constructor TPayUtils.Create(AOwner: TComponent;PassedConnection:TERPConnection);
begin
   inherited Create(AOwner);
   Connection  := TMyDacDataConnection.Create(Self);
   TMyDacDataConnection(Connection).MydacConnection  := PassedConnection;
   fEmployeePay      := Temployeepay.Create(Self,PassedConnection);
end;

constructor TPayUtils.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
end;

destructor TPayUtils.Destroy;
begin
  inherited;
end;

procedure TPayUtils.ProcessPay(const Pay:TPaybase;DatePaid:TDateTime;AddtoABA:Boolean;PreviewPaySlips:Boolean);
var
  ABAObj: TABAObj;
  FatalStatusItem: TResultStatusItem;


begin

    CurrentPay := Pay;

    Pay.Datepaid := DatePaid;
    Pay.Paid := True;
    Pay.Pay   := False;
    Pay.EmployeePaySettings.DateLastActuallyPaid := DatePaid;
    Pay.EmployeePaySettings.LastPaid := Pay.PayDate;
    Pay.EmployeePaySettings.PostDb;
    Pay.EmployeeLeave.AccrueLeaves;
    Pay.LeaveAccruals.UpdateLeaveTaken;
    if Pay.IsTermination then
      Pay.LeaveAccruals.ZeroOutAccruals;


    Pay.Save;

    Pay.PostToAccounts;

    try

      PrintPaySlip(Pay,PreviewPaySlips,'B');


    except
      CommonLib.MessageDlgXP_Vista('Could not print payslip. Check Payslip template', mtWarning, [mbOK], 0);
    end;


      {Create EFT Payment}
      if AddtoABA then begin
        ABAObj := TABAObj.Create;
        try
          if ABAObj.ValidEFTEmployee(Pay.PayID) then begin
            If ABAObj.HasValidEFTEmployeeAccountInfo(Pay.PayID) then Begin
              if not UserLock.IsLocked('tblabadescriptiverecord', -1, 'Electronic Funds Transfer') then begin
                  ABAObj.AddABADetailsRecord(Pay.EmployeeDetails.ID,Pay.PayPaysplits.DataSet,
                     PayAccounts.BankAccountID(Pay.Employeeid),Pay.Net,Pay.PayID,'Pay');
              end else begin
                CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Electronic Funds Transfer' +
                ' Failed.', mtWarning, [mbOK], 0);
              end;
            end else begin
              CommonLib.MessageDlgXP_Vista('EFT ERROR: ' + Pay.EmployeeDetails.EmployeeName + ' has Invalid Bank Details', mtWarning, [mbOK], 0);
            end;
          end;
        finally
          ABAObj.Free;
        end;
      end;


    if not Pay.IsTermination then
    begin

  //    CurrentConnection := Pay.Connection;
  //    CurrentPay := Pay;

      CreateNewPay(Pay.Employeeid,False,False, FatalStatusItem) ;

//      if not Assigned(Pay.Connection) then
//         Pay.Connection := CurrentConnection;

      CommonLib.MessageDlgXP_Vista('Pay OK.', mtInformation, [mbOK], 0);


//    if not Assigned(Pay.Connection) then
//       Sleep(10000);

     //   if Assigned(Pay.Connection) then ShowMessage('160 Pay has connection') else ShowMessage('160 Pay has no connection');
     //   if Assigned(Pay.Connection.Connection) then ShowMessage('161 Pay.Connection has connection') else ShowMessage('161 Pay.Connection has no connection');

    end;

//    if Assigned(Pay.Connection) then ShowMessage('164 Pay has connection') else ShowMessage('164 Pay has no connection');
//    if Assigned(Pay.Connection.Connection) then ShowMessage('166 Pay.Connection has connection') else ShowMessage('166 Pay.Connection has no connection');

end;


procedure TpayUtils.DeleteUnprocessedPay;
begin

   fPay.First;

   while not fPay.eof do
   begin // delete any unprocessed pays
      if (fPay.Paid = False) then
      begin
         if fPay.PayID < 1 then
            continue; // for safety so all pays can't get deleted
         fPay.CreateAndConnectSubObjs; // this is to refresh all sub objects
         fPay.PaysPayRates.DeleteAll;
         fPay.PayAllowances.DeleteAll;
         fPay.PayDeductions.DeleteAll;
         fPay.PaySundries.DeleteAll;
    //     fPay.LeaveAccruals.DeleteAll;
         fPay.PayCommissions.DeleteAll;
         if Assigned(fPay.PayBenefits) then{ no super for USA }
            fPay.PayBenefits.DeleteAll;
         fPay.Termination.DeleteAll;
         fPay.Lines.DeleteAll;
         fPay.Delete;
      end
      else
         fPay.next; // shouldn't have more than one unprocessed pay but lets be sure
   end;

     fPay.Connection.CommitTransaction;

end;


function TPayUtils.CreateNewPay(EmployeeID:integer;NewEmployee:boolean;ModifyingPay:Boolean;Var FatalStatusItem: TResultStatusItem;const TerminationDate:TDatetime = 0):Boolean;
var
  tmpPayID,iDays:integer;
begin

  Result := True;
  if EmployeeID = 0 then exit;
  if Assigned(fPay) then fPay.Free;


  fPay := Tpaybase.Create(Self,AppEnv.RegionalOptions.Region,TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection ));

 //   if Assigned(fPay.Connection) then ShowMessage('261 Pay has connection') else ShowMessage('261 Pay has no connection');

//  CurrentConnection := fPay.Connection;

  Try
    fPay.CreatingNewPay := True;
    fPay.ValidationDisabled := True;

    tmpPayID :=  UnprocessedPayExists(EmployeeID,TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection));

    if tmpPayID > 0 then begin
      fPay.Load(tmpPayID);
      DeleteUnprocessedPay;
    end;

    fPay.New;
    fPay.PostDb;
    tmpPayID               := fPay.PayID;
    fPay.Employeeid        := EmployeeID;
    fPay.PostDb;
    fPay.Load(tmpPayID);

    fEmployeePay.Load(EmployeeID);
    fPay.Empname := fEmployeePay.EmployeeDetails.Employeename;
    fPay.Region :=  AppEnv.RegionalOptions.Region;
    fPay.PayPeriod := fEmployeePay.EmployeePaySettings.Payperiod;
    fPay.Classid   := GetDeptID(fEmployeePay.EmployeeDetails.Defaultclassname);
    fPay.Department := fEmployeePay.EmployeeDetails.Defaultclassname;
    fPay.Pay := True;
    fPay.Paid := False;

    //add records to tblpayspayrates

  //  ShowMessage('CallbackAddPayRatesToPay');

    fPay.PaysPayRates.AllowRecalc := False;
    fEmployeePay.EmployeePayRates.IterateRecords(CallbackAddPayRatesToPay,False);


    //    ShowMessage('CallBackAddDeductionsToPay');

    //add deductions
    fEmployeePay.EmployeeDeductions.IterateRecords(CallBackAddDeductionsToPay,False);


    //    ShowMessage('CallBackAddAllowancesToPay');

    //add allowances
    fEmployeePay.EmployeeAllowances.IterateRecords(CallBackAddAllowancesToPay,False);

//   if Assigned(fPay.Connection) then ShowMessage('308 Pay has connection') else ShowMessage('308 Pay has no connection');

  //  ShowMessage('CallBackAddPaySplitsToPay');

    //add paysplits
    fEmployeePay.EmployeePaySplit.IterateRecords(CallBackAddPaySplitsToPay,False);


    if NewEmployee then begin
      fPay.Paydate := fPay.EmployeePaySettings.FirstPayDate;
      fPay.EmployeePaySettings.LastPaid := fPay.EmployeePaySettings.FirstPayDate;
    end else begin
      fPay.Datepaid := fPay.EmployeePaySettings.DateLastActuallyPaid;
      if not ModifyingPay then begin   //processing pay
        if Trim(fPay.EmployeePaySettings.PayPeriod) = 'Weekly' then Begin
           fPay.Paydate := IncDay(fPay.EmployeePaySettings.LastPaid,7);
           fPay.EmployeePaySettings.LastPaid := IncDay(fPay.EmployeePaySettings.LastPaid,7);
        end else if Trim(fPay.EmployeePaySettings.PayPeriod) = 'Fortnightly' then Begin
           fPay.Paydate := IncDay(fPay.EmployeePaySettings.LastPaid,14);
           fPay.EmployeePaySettings.LastPaid := IncDay(fPay.EmployeePaySettings.LastPaid,14);
        end else if Trim(fPay.EmployeePaySettings.PayPeriod) = 'Monthly' then Begin
           fPay.Paydate := IncMonth(fPay.EmployeePaySettings.LastPaid,1);
           fPay.EmployeePaySettings.LastPaid := IncMonth(fPay.EmployeePaySettings.LastPaid,1);
        end else if Trim(fPay.EmployeePaySettings.PayPeriod) = 'Bi-Monthly' then Begin
           iDays :=  Trunc(DaysInMonth(fPay.EmployeePaySettings.LastPaid)/2); //get approx half month for bi-month case
           fPay.Paydate := IncDay(fPay.EmployeePaySettings.LastPaid,iDays);
           fPay.EmployeePaySettings.LastPaid := IncDay(fPay.EmployeePaySettings.LastPaid,iDays);
        end
        else begin  { PayPeriod = None }
          { we don't know pay frequency so just use last paid date }
          fPay.Paydate := fPay.EmployeePaySettings.LastPaid;
        end;
      end else begin
        if TerminationDate <> 0 then //termination
          fPay.Paydate := TerminationDate
        else fPay.Paydate := fPay.EmployeePaySettings.LastPaid; //the last paid has already been incremented on previous processing
      end;                                   //LastPaid should have been named LastPayDate to be clearer
    end;

    if fPay.Paydate < AppEnv.CompanyPrefs.ClosingDate then
        if CommonLib.MessageDlgXP_Vista('First Pay Date on the Employee Pay Details Tab is Prior to the Closing Dates. Do you want to change this to the current date (' + FormatDateTime(FormatSettings.shortdateformat , date) +')?', mtWarning, [mbyes,mbno], 0) = mryes then begin
          fPay.Paydate := Date;
          fPay.PostDb;
        end;

    if fPay.Paydate < AppEnv.CompanyPrefs.ClosingDate then begin
      {todo take dialogs off BusObj}
      if NewEmployee then
        CommonLib.MessageDlgXP_Vista('First Pay Date on the Employee Pay Details Tab is Prior to the Closing Dates, Can Not Create Pay.', mtWarning, [mbOK], 0)
      else
        CommonLib.MessageDlgXP_Vista('Pay Date is Prior to the Closing Dates, Can Not Create Pay.', mtWarning, [mbOK], 0);
      fPay.Delete;
      Result := False;
      exit;
    end;

//       if Assigned(fPay.Connection) then ShowMessage('364 Pay has connection') else ShowMessage('364 Pay has no connection');


    //add super
    if AppEnv.RegionalOptions.RegionType <> rAUST then begin
      {no super for other countries }
    end
    else begin
      fPay.LoadingEmployeeSuper := True;
      fEmployeePay.Superannuation.IterateRecords(CallbackAddSuperToPay);
      fPay.LoadingEmployeeSuper := False;
    end;

    fPay.PaysPayRates.AllowRecalc := True;
    fPay.CreatingNewPay := False ;

 //   if Assigned(fPay.Connection) then ShowMessage('380 Pay has connection') else ShowMessage('380 Pay has no connection');

    if fPay.RecalcInProgress = False then begin
      fPay.RecalcAll;
    end;

 //   if Assigned(fPay.Connection) then ShowMessage('386 Pay has connection') else ShowMessage('386 Pay has no connection');

    result := fPay.Save;

  //  if Assigned(fPay.Connection) then ShowMessage('390 Pay has connection') else ShowMessage('390 Pay has no connection');

    if not result then exit;

    fPay.EmployeePaySettings.PostDb;

 //   if Assigned(fPay.Connection) then ShowMessage('396 Pay has connection') else ShowMessage('396 Pay has no connection');

    fPay.ValidationDisabled := False;
    fPay.RecalcAll;
    result := fPay.Save;



  finally
    FatalStatusItem := nil;
    if not result then FatalStatusItem:= fPay.ResultStatus.GetLastFatalStatusItem;
    FreeAndNil(fPay);
    fPay := nil;
  end;
end;


procedure TPayUtils.CallbackAddPayRatesToPay(const Sender: TBusObj; var Abort: Boolean);
var
  payLocal : Tpaybase;
begin

  if Assigned(fPayForTimeSheet) then payLocal := fPayForTimeSheet else payLocal := fPay;


  payLocal.PaysPayRates.New;
  payLocal.PaysPayRates.Payrateid        := Temployeepayrates(Sender).Payrateid;
  payLocal.PaysPayRates.Typeid           := Temployeepayrates(Sender).Typeid;
  payLocal.PaysPayRates.Qty              := Temployeepayrates(Sender).Qty;
  payLocal.PaysPayRates.Linetotal        := Temployeepayrates(Sender).Linetotal;
  if  getPayRateType(Temployeepayrates(Sender).Typeid) = 'Hourly Rate' then
    payLocal.PaysPayRates.Amount           := Divzer(Temployeepayrates(Sender).Amount,Temployeepayrates(Sender).Qty)

  else if  getPayRateType(Temployeepayrates(Sender).Typeid) = 'CDEP' then
    payLocal.PaysPayRates.Amount           := Divzer(Temployeepayrates(Sender).Amount,Temployeepayrates(Sender).Qty)

  else if getPayRateType(Temployeepayrates(Sender).Typeid) = 'Annual Payment' then begin
    payLocal.PaysPayRates.Amount           := Temployeepayrates(Sender).Hourlyrate;
    payLocal.PaysPayRates.Linetotal        := Temployeepayrates(Sender).Hourlyrate;
  end else if getPayRateType(Temployeepayrates(Sender).Typeid) = 'Piece-Rate' then begin
    payLocal.PaysPayRates.Amount           := Temployeepayrates(Sender).Hourlyrate;
  end else if getPayRateType(Temployeepayrates(Sender).Typeid) = 'Salary' then begin
    payLocal.PaysPayRates.Amount           := Temployeepayrates(Sender).Hourlyrate * Temployeepayrates(Sender).Qty;
  end;

  payLocal.PaysPayRates.Superinc         := Temployeepayrates(Sender).Super;
  payLocal.PaysPayRates.Clientid         := Temployeepayrates(Sender).Clientid;
  payLocal.PaysPayRates.Classid          := Temployeepayrates(Sender).Classid;
  payLocal.PaysPayRates.DepartmentName   := Temployeepayrates(Sender).DepartmentName;

  payLocal.PaysPayRates.PostDb;


//    fPay.PaysPayRates.New;
//  fPay.PaysPayRates.Payrateid        := Temployeepayrates(Sender).Payrateid;
//  fPay.PaysPayRates.Typeid           := Temployeepayrates(Sender).Typeid;
//  fPay.PaysPayRates.Qty              := Temployeepayrates(Sender).Qty;
//  fPay.PaysPayRates.Linetotal        := Temployeepayrates(Sender).Linetotal;
//  if  getPayRateType(Temployeepayrates(Sender).Typeid) = 'Hourly Rate' then
//    fPay.PaysPayRates.Amount           := Divzer(Temployeepayrates(Sender).Amount,Temployeepayrates(Sender).Qty)
//
//  else if  getPayRateType(Temployeepayrates(Sender).Typeid) = 'CDEP' then
//    fPay.PaysPayRates.Amount           := Divzer(Temployeepayrates(Sender).Amount,Temployeepayrates(Sender).Qty)
//
//  else if getPayRateType(Temployeepayrates(Sender).Typeid) = 'Annual Payment' then begin
//    fPay.PaysPayRates.Amount           := Temployeepayrates(Sender).Hourlyrate;
//    fPay.PaysPayRates.Linetotal        := Temployeepayrates(Sender).Hourlyrate;
//  end else if getPayRateType(Temployeepayrates(Sender).Typeid) = 'Piece-Rate' then begin
//    fPay.PaysPayRates.Amount           := Temployeepayrates(Sender).Hourlyrate;
//  end else if getPayRateType(Temployeepayrates(Sender).Typeid) = 'Salary' then begin
//    fPay.PaysPayRates.Amount           := Temployeepayrates(Sender).Hourlyrate * Temployeepayrates(Sender).Qty;
//  end;
//
//  fPay.PaysPayRates.Superinc         := Temployeepayrates(Sender).Super;
//  fPay.PaysPayRates.Clientid         := Temployeepayrates(Sender).Clientid;
//  fPay.PaysPayRates.Classid          := Temployeepayrates(Sender).Classid;
//  fPay.PaysPayRates.DepartmentName   := Temployeepayrates(Sender).DepartmentName;
//
//  fPay.PaysPayRates.PostDb;

//  ShowMessage('CallbackAddPayRatesToPay  done');

end;



procedure TPayUtils.CallbackAddDeductionsToPay(const Sender: TBusObj; var Abort: Boolean);
var
   dedid : Integer;

begin

 //  ShowMessage(' in  CallbackAddDeductionsToPay ' );


  fPay.PayDeductions.New;

  //   ShowMessage('  CallbackAddDeductionsToPay New done ' );

    //      ShowMessage('  Temployeedeductions(Sender).Deductionid ' + IntToStr(Temployeedeductions(Sender).Deductionid));

  dedid :=  Temployeedeductions(Sender).Deductionid;

  // ShowMessage('dedid  ' + IntToStr(dedid));


  fPay.PayDeductions.Deductionid       := dedid;


 // ShowMessage('fPay.PayDeductions.Deductionid ' + IntToStr(fPay.PayDeductions.Deductionid));

//  fPay.PayDeductions.Deductionid       := Temployeedeductions(Sender).Deductionid;

   //       ShowMessage('  Temployeedeductions(Sender).DepartmentName ' + Temployeedeductions(Sender).DepartmentName);


  fPay.PayDeductions.DepartmentName    := Temployeedeductions(Sender).DepartmentName;


  fPay.PayDeductions.Qty               := Temployeedeductions(Sender).Qty;
  fPay.PayDeductions.Notes             := Temployeedeductions(Sender).Notes;
  fPay.PayDeductions.Basedonid         := Temployeedeductions(Sender).Basedonid;
  fPay.PayDeductions.Box12CodeID       := Temployeedeductions(Sender).Box12CodeID;
  fPay.PayDeductions.Amount            := Temployeedeductions(Sender).Amount;
  fPay.PayDeductions.Calcby            := Temployeedeductions(Sender).Calcby;
  fPay.PayDeductions.Taxexempt         := Temployeedeductions(Sender).Taxexempt;
  fPay.PayDeductions.TaxexemptFederal  := Temployeedeductions(Sender).TaxexemptFederal;
  fPay.PayDeductions.TaxexemptState    := Temployeedeductions(Sender).TaxexemptState;
  fPay.PayDeductions.TaxexemptSocial   := Temployeedeductions(Sender).TaxexemptSocial;
  fPay.PayDeductions.TaxexemptMedicare := Temployeedeductions(Sender).TaxexemptMedicare;
  fPay.PayDeductions.IsWorkPlacegiving := Temployeedeductions(Sender).IsWorkPlacegiving;
  fPay.PayDeductions.Unionfees         := Temployeedeductions(Sender).Unionfees;
  fPay.PayDeductions.Classid           := Temployeedeductions(Sender).Classid;
  fPay.PayDeductions.Area              := Temployeedeductions(Sender).Area;

  fPay.PayDeductions.PostDb;
end;

procedure TPayUtils.CallbackAddAllowancesToPay(const Sender: TBusObj; var Abort: Boolean);
begin
  fPay.PayAllowances.New;
  fPay.PayAllowances.Allowanceid       := Temployeeallowances(Sender).Allowanceid;
  fPay.PayAllowances.Qty               := Temployeeallowances(Sender).Qty;
  fPay.PayAllowances.Basedonid         := Temployeeallowances(Sender).Basedonid;
  fPay.PayAllowances.Amount            := Temployeeallowances(Sender).Amount;
  fPay.PayAllowances.Calcby            := Temployeeallowances(Sender).Calcby;
  fPay.PayAllowances.Taxexempt         := Temployeeallowances(Sender).Taxexempt;
  fPay.PayAllowances.Classid           := Temployeeallowances(Sender).Classid;
  fPay.PayAllowances.DepartmentName    := Temployeeallowances(Sender).DepartmentName;
  fPay.PayAllowances.Superinc          := Temployeeallowances(Sender).Superinc;
  fPay.PayAllowances.Clientid          := Temployeeallowances(Sender).Clientid;
  fPay.PayAllowances.Area              := Temployeeallowances(Sender).Area;
  fPay.PayAllowances.PostDb;
end;


procedure TPayUtils.CallBackAddPaySplitsToPay(const Sender: TBusObj; var Abort: Boolean);
begin
  fPay.PayPaysplits.New;
  fPay.PayPaysplits.SplitType         := Tpaysplit(Sender).SplitType;
  fPay.PayPaysplits.Split             := Tpaysplit(Sender).Split;
  fPay.PayPaysplits.Bankid            := Tpaysplit(Sender).Bankid;
  fPay.PayPaysplits.Branch            := Tpaysplit(Sender).Branch;
  fPay.PayPaysplits.Bsb               := Tpaysplit(Sender).Bsb;
  fPay.PayPaysplits.Accountno         := Tpaysplit(Sender).Accountno;
  fPay.PayPaysplits.Amount            := Tpaysplit(Sender).Amount;
  fPay.PayPaysplits.Accountname       := Tpaysplit(Sender).Accountname;
  fPay.PayPaysplits.PostDb;
end;

procedure TPayUtils.CallBackAddSuperToPay(const Sender: TBusObj; var Abort: Boolean);
begin
  fPay.PayBenefits.New;

  TPayssuperannuation(fPay.PayBenefits).Payid           := fPay.Id;
  TPayssuperannuation(fPay.PayBenefits).Superid         := TSuperannuation(fEmployeePay.Superannuation).SuperID;
  TPayssuperannuation(fPay.PayBenefits).Supertypeid     := TSuperannuation(fEmployeePay.Superannuation).Supertypeid;
  TPayssuperannuation(fPay.PayBenefits).Clientid        := TSuperannuation(fEmployeePay.Superannuation).Clientid;
  TPayssuperannuation(fPay.PayBenefits).Accountno       := TSuperannuation(fEmployeePay.Superannuation).Accountno;
  TPayssuperannuation(fPay.PayBenefits).Datejoined      := TSuperannuation(fEmployeePay.Superannuation).Datejoined;
  TPayssuperannuation(fPay.PayBenefits).Amount          := TSuperannuation(fEmployeePay.Superannuation).Amount;
  TPayssuperannuation(fPay.PayBenefits).Calcby          := TSuperannuation(fEmployeePay.Superannuation).Calcby;
  TPayssuperannuation(fPay.PayBenefits).Amountpaid      := TSuperannuation(fEmployeePay.Superannuation).Amounttopaid; { will be updated on pay.recalcall later }
  TPayssuperannuation(fPay.PayBenefits).Belowthreshold  := False;

  TPayssuperannuation(fPay.PayBenefits).Classid         := TSuperannuation(fEmployeePay.Superannuation).Classid;
  TPayssuperannuation(fPay.PayBenefits).DepartmentName  := TSuperannuation(fEmployeePay.Superannuation).DepartmentName;
  TPayssuperannuation(fPay.PayBenefits).Allclasses      := TSuperannuation(fEmployeePay.Superannuation).Allclasses;
  TPayssuperannuation(fPay.PayBenefits).Area            := TSuperannuation(fEmployeePay.Superannuation).Area;

  fPay.PayBenefits.PostDb;
end;

procedure TPayUtils.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin

end;
class function TPayUtils.GetIDField: string;
begin
    Result := '';{IDfield Missing}
end;
Class function TPayUtils.GetBusObjectTablename: string;
begin
    REsult := '';{busobjectTablename Missing}
end;

Function TPayUtils.PrintPaySlipSQL(Const ThisPay: TPaybase):String;
var
  ANDstr : string;

  sAnnualLeaveDays,sAnnualLeaveHours,AnnualLeaveYTDdays,AnnualLeaveYTDHours,AnnualLeaveTotalDays,AnnualLeaveTotalHours, SickLeavetotalDays,SickLeavetotalHours , LongServiceLeavetotalDays,LongServiceLeavetotalHours :String;
  sSickLeaveHours,sSickLeaveDays,
  sSickLeaveYTDDays,sSickLeaveYTDHours:String;
  sRDOHours,sRDODays,sRDOYTDDays,sRDOYTDHours:String;
  saSQL,saSQL1,saSQL2,saSQL3,saSQL4,saSQL5,saSQL6,saSQL7,saSQL8,saSQL9,saSQL10,saSQL11,saSQL12 , saSQL13: String;
  EmployeeTaxSQL, CompanyTaxSQL: string;
  qryTemp: TERPQuery;
  dAmountReminder               :double;
begin

            {Payment Details}
            if ThisPay.Paid then begin
              AnnualLeaveYTDdays    := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs('Annual Leave',ThisPay.PayDate)/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              AnnualLeaveYTDHours   := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs('Annual Leave',ThisPay.PayDate)) ,-3));
              sAnnualLeaveDays      := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetThisPayAccruedHrs('Annual Leave')/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              sAnnualLeaveHours     := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetThisPayAccruedHrs('Annual Leave')),-3));
              sSickLeaveYTDDays     := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs( Appenv.RegionalOptions.SLName ,ThisPay.PayDate)/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              sSickLeaveYTDHours    := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs( Appenv.RegionalOptions.SLName ,ThisPay.PayDate)) ,-3));
              sSickLeaveDays        := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetThisPayAccruedHrs( Appenv.RegionalOptions.SLName )/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              sSickLeaveHours       := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetThisPayAccruedHrs( Appenv.RegionalOptions.SLName )),-3));
              sRDODays              := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetThisPayAccruedHrs('RDO')/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              sRDOYTDDays           := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs('RDO',ThisPay.PayDate)/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              sRDOYTDHours          := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs('RDO',ThisPay.PayDate)) ,-3));
              sRDOHours             := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetThisPayAccruedHrs('RDO')),-3));
            end else begin
              AnnualLeaveYTDdays    := FloatToStr(RoundTo(((ThisPay.LeaveAccruals.GetYTDHrs('Annual Leave',ThisPay.PayDate) + ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('Annual Leave'))/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              AnnualLeaveYTDHours   := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs('Annual Leave',ThisPay.PayDate) )  + ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('Annual Leave'),-3)  ) ;
              sAnnualLeaveDays      := FloatToStr(RoundTo((ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('Annual Leave')/(AppEnv.CompanyPrefs.HoursPerWeek/5)) ,-3));
              sAnnualLeaveHours     := FloatToStr(RoundTo((ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('Annual Leave')) ,-3));
              sSickLeaveYTDDays     := FloatToStr(RoundTo(((ThisPay.LeaveAccruals.GetYTDHrs( Appenv.RegionalOptions.SLName ,ThisPay.PayDate) + ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement( Appenv.RegionalOptions.SLName ))/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              sSickLeaveYTDHours    := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs( Appenv.RegionalOptions.SLName ,ThisPay.PayDate))  + ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement( Appenv.RegionalOptions.SLName ),-3));
              sSickLeaveDays        := FloatToStr(RoundTo((ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement( Appenv.RegionalOptions.SLName )/(AppEnv.CompanyPrefs.HoursPerWeek/5)) ,-3));
              sSickLeaveHours       := FloatToStr(RoundTo((ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement( Appenv.RegionalOptions.SLName )) ,-3));
              sRDODays              := FloatToStr(RoundTo((ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('RDO')/(AppEnv.CompanyPrefs.HoursPerWeek/5)) ,-3));
              sRDOYTDDays           := FloatToStr(RoundTo(((ThisPay.LeaveAccruals.GetYTDHrs('RDO',ThisPay.PayDate) + ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement( Appenv.RegionalOptions.SLName ))/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-3));
              sRDOYTDHours          := FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs('RDO',ThisPay.PayDate))  + ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement( Appenv.RegionalOptions.SLName ),-3));
              sRDOHours             := FloatToStr(RoundTo((ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('RDO')) ,-3));
            end;

            if ThisPay.EmployeeLeave.Locate('Type','Annual Leave',[loCaseInsensitive]) then begin
              AnnualLeaveTotalHours := FloatToStr(RoundTo(ThisPay.EmployeeLeave.Accruedhours ,-3));
              AnnualLeaveTotalDays := FloatToStr(RoundTo((ThisPay.EmployeeLeave.Accruedhours ) / (AppEnv.CompanyPrefs.HoursPerWeek/5),-3));
            end
            else begin
              AnnualLeaveTotalHours := '0.000';
              AnnualLeaveTotalDays := '0.000';
            end;

            if ThisPay.EmployeeLeave.Locate('Type', Appenv.RegionalOptions.SLName ,[loCaseInsensitive]) then begin
              SickLeavetotalHours := FloatToStr(RoundTo(ThisPay.EmployeeLeave.Accruedhours ,-3));
              SickLeavetotalDays := FloatToStr(RoundTo((ThisPay.EmployeeLeave.Accruedhours ) / (AppEnv.CompanyPrefs.HoursPerWeek/5),-3));
            end
            else begin
              SickLeavetotalHours := '0.000';
              SickLeavetotalDays := '0.000';
            end;

            if ThisPay.EmployeeLeave.Locate('Type','Long Service',[loCaseInsensitive]) then begin
              LongServiceLeavetotalHours := FloatToStr(RoundTo(ThisPay.EmployeeLeave.Accruedhours ,-3));
              LongServiceLeavetotalDays := FloatToStr(RoundTo((ThisPay.EmployeeLeave.Accruedhours ) / (AppEnv.CompanyPrefs.HoursPerWeek/5),-3));
            end
            else begin
              LongServiceLeavetotalHours := '0.000';
              LongServiceLeavetotalDays := '0.000';
            end;


            saSQL := 'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
                'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' +
                'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN,' +
                'tblPays.EmployeeID, EmpName, Datepaid,PayDate, PayPeriods, tblPays.Wages, tblPays.Commission, tblPays.Deductions, tblPays.Workplacegiving, tblPays.Allowances, ' +
                'tblPays.Sundries, tblPays.Superannuation, tblPays.Gross, tblPays.Tax, tblPays.Net,tblPays.Net-13 as Netsocial, tblPays.Deleted, ' +
                'B.Description, T.Description as Type, A.LineTotal, ' +
                'IF(T.Description = "Hourly Rate" OR T.Description = "Salary" OR T.Description = "Piece-Rate", A.Qty, 0.0) as Qty, ' +
                'IF(T.Description = "Hourly Rate" OR T.Description = "Salary" OR T.Description = "Piece-Rate", A.Amount, 0.0) as Rate, ' +
                QuotedStr(ThisPay.EmployeeDetails.Defaultclassname) + ' as "Employee Department", ' +

                FloatToStr(ThisPay.PayTotals.YTDWages) + ' as YTDWages, ' +
                FloatToStr(ThisPay.PayTotals.YTDCommission) + ' as YTDCommission, ' +
                FloatToStr(ThisPay.PayTotals.YTDDeduction) + ' as YTDDeductions, ' +
                FloatToStr(ThisPay.PayTotals.YTDWorkplacegiving) + ' as YTDWorkplacegiving, ' +
                FloatToStr(ThisPay.PayTotals.YTDAllowances) + ' as YTDAllowances, ' +
                FloatToStr(ThisPay.PayTotals.YTDSundries) + ' as YTDSundries, ' +
                FloatToStr(ThisPay.PayTotals.YTDSuperannuation) + ' as YTDSuper, ' +
                FloatToStr(ThisPay.PayTotals.YTDGross) + ' as YTDGross, ' +
                FloatToStr(ThisPay.PayTotals.YTDTax) +  ' as YTDTax, ' +
                FloatToStr(ThisPay.PayTotals.YTDNet) + ' as YTDNet, ' +

          {long service leave}
                {YTD :Days}   FloatToStr(RoundTo(((ThisPay.LeaveAccruals.GetYTDHrs('Long Service',ThisPay.PayDate) + ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('Long Service'))/(AppEnv.CompanyPrefs.HoursPerWeek/5)),-2)) + ' as TDLongServiceLeaveDays, ' +
                {YTD :hours}  FloatToStr(RoundTo((ThisPay.LeaveAccruals.GetYTDHrs('Long Service',ThisPay.PayDate)),-3)) + ' as TDLongServiceLeaveHrs, ' +
                {TP :Days}    FloatToStr(RoundTo(ThisPay.LeaveAccruals.GetThisPayAccruedHrs('Long Service'),-2)) + ' as LongServiceLeave, ' +
                {TP : Hours}  FloatToStr(RoundTo((ThisPay.PayLeaves.GetThisPayLeaveHrsEntitlement('Long Service')/(AppEnv.CompanyPrefs.HoursPerWeek/5)) ,-3)) + ' as LongServiceLeaveDays, ' +

          {annual leave}
                {YTD :Days}   QuotedStr(AnnualLeaveYTDdays) + ' as TDLeaveDays, ' +
                {YTD :hours}  QuotedStr(AnnualLeaveYTDHours) + ' as TDLeaveHrs, ' +
                {TP :Days}    QuotedStr(sAnnualLeaveHours) + ' as AnnualLeave, ' +
                {TP : Hours}  QuotedStr(sAnnualLeaveDays) + ' as AnnualLeaveDays, ' +

          {sickleave}
                {YTD :Days}   QuotedStr(sSickLeaveYTDDays) + ' as TDSickLeaveDays, ' +
                {YTD :hours}  QuotedStr(sSickLeaveYTDHours) + ' as TDSickLeaveHrs, ' +
                {TP :Days}    QuotedStr(sSickLeaveDays) + ' as SickLeaveDays, ' +
                {TP : Hours}  QuotedStr(sSickLeaveHours) + ' as SickLeave, ' +

          {RDO}
                {YTD :Days}   QuotedStr(sRDOYTDDays) + ' as TDRDODays, ' +
                {YTD :hours}  QuotedStr(sRDOYTDHours) + ' as TDRDOHrs, ' +
                {TP :Days}    QuotedStr(sRDODays) + ' as RDODays, ' +
                {TP : Hours}  QuotedStr(sRDOHours) + ' as RDO, ' +

          {totals }
                {Annual:Days} QuotedStr(AnnualLeaveTotalDays) + ' as TotalAnnualLeaveDays, ' +
                {Annual:hrs}  QuotedStr(AnnualLeaveTotalHours) + ' as TotalAnnualLeaveHrs, ' +
                {SL:Days}     QuotedStr(SickLeavetotalDays) + ' as TotalSickLeaveDays, ' +
                {SL:Hrs}      QuotedStr(SickLeavetotalHours) + ' as TotalSickLeaveHrs, ' +
                {LS:Days}     QuotedStr(LongServiceLeavetotalDays) + ' as TotalLongServiceDays, ' +
                {LS:Hrs}      QuotedStr(LongServiceLeavetotalHours) + ' as TotalLongServiceHrs, ' +



                'CAST('+QuotedStr(FormatDateTime(MysqlDateFormat, ThisPay.PayFromDate)) + ' as DATE) As PayFrom,' +

                'E.Street AS EmployeeStreet, E.Street2 AS EmployeeStreet2, E.Suburb AS EmployeeSuburb, ' +
                'E.Postcode AS EmployeePostCode,E.Position, E.State AS EmployeeState,tblPays.PayID,E.PayNotes, ' +
                'E.Award,Aw.AwardID, Aw.AwardName  ' +
                'FROM tblCompanyInformation AS CO, tblPays ' +
                'LEFT JOIN tblpayspayrates AS A USING (PayID) ' +
                'LEFT JOIN tblpayrates as B ON A.PayRateID = B.RateID ' +
                'LEFT JOIN tblpayratetype as T ON A.TypeID = T.TypeID ' +
                'LEFT JOIN tblemployees AS E ON tblPays.EmployeeID = E.EmployeeID ' +
                'LEFT JOIN tblawards AS Aw ON E.Award = Aw.AwardID ' +
                'WHERE (tblPays.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (tblPays.Deleted = "F")'  ;

        {Additions}
        saSQL1 := 'SELECT '+
                'A.Description AS "Description", PA.Qty AS "QTY / Hours", '+
                'PA.MoneyAmount AS "Amount",PA.Calcby,PA.Amount as "Rate",P.Deleted,P.PayID '+
                'FROM tblpaysallowances AS PA '+
                'INNER JOIN tblallowances AS A on PA.AllowanceID = A.AllowanceID '+
                'INNER JOIN tblpays as P on PA.PayID = P.PayID ' +
                'WHERE (PA.PayID = ' + IntToStr(ThisPay.PayID)+ ') AND (P.Deleted = "F")';
        {Deductions}
        saSQL2 := 'SELECT '+
                'D.Description AS "Description", PD.CalcBy, PD.Qty AS "QTY / Hours", '+
                'PD.MoneyAmount,PD.Amount as "Rate",P.Deductions,P.PayID,P.Deleted,BO.BasedOn '+
                'FROM tblpaysdeductions AS PD '+
                'INNER JOIN tbldeductions AS D ON PD.DeductionID = D.DeductionID and PD.IsWorkPlacegiving ="F" '+
                'INNER JOIN tblallowancebasedon AS BO ON BO.BasedOnID = PD.BasedOnID  ' +
                'LEFT JOIN tblpays AS P ON P.PayID = PD.PayID ' +
                'WHERE (PD.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';
        {Workplace giving}
        saSQL13 := 'SELECT '+
                'D.Description AS "Description", PD.CalcBy, PD.Qty AS "QTY / Hours", '+
                'PD.MoneyAmount,PD.Amount as "Rate",P.Workplacegiving,P.PayID,P.Deleted,BO.BasedOn '+
                'FROM tblpaysdeductions AS PD '+
                'INNER JOIN tbldeductions AS D ON PD.DeductionID = D.DeductionID and PD.IsWorkPlacegiving ="T" '+
                'INNER JOIN tblallowancebasedon AS BO ON BO.BasedOnID = PD.BasedOnID  ' +
                'LEFT JOIN tblpays AS P ON P.PayID = PD.PayID ' +
                'WHERE (PD.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';
        {Banking}
        qryTemp := TERPQuery.Create(nil);
        Try
          qryTemp.Options.FlatBuffers := True;
          qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

         qryTemp.SQL.Clear;
         qryTemp.SQL.Text :='SELECT '+
                                    'Sum(CASE PS.Type '+
                                    'WHEN "$" THEN Round(PS.Amount,'+inttostr(CurrencyRoundPlaces)+') '+
                                    'WHEN "%" THEN Round((PS.Amount/100)*P.Net,'+inttostr(CurrencyRoundPlaces)+') '+
                                    'ELSE 0.00 END) as Amount, '+
                                    'P.Net,P.Deleted '+
                                    'FROM tblpays AS P '+
                                    'INNER JOIN tblpayssplits AS PS on PS.PayID = P.PayID '+
                                    'WHERE (P.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F" )' +
                                    'Group By P.Net; ';
          qryTemp.Open;
          dAmountReminder := qryTemp.FieldByName('Net').asFloat - qryTemp.FieldByName('Amount').asFloat;
          qryTemp.Close;
        finally
          FreeAndNil(qryTemp);
        end;

        saSQL3 :='SELECT '+
                'PS.Accountname, P.EmpName AS "Employee Name",P.Deleted, '+
                'PS.Split as Type, '+
                'PS.BSB, '+
                'PS.AccountNo, '+
                'BC.BankCode, '+
                'BC.BankName As "Bank Description", '+

                'CASE PS.Type '+
                'WHEN "$" THEN Round(PS.Amount,'+inttostr(CurrencyRoundPlaces)+') '+
                'WHEN "%" THEN Round((PS.Amount/100)*P.Net,'+inttostr(CurrencyRoundPlaces)+') '+
                'WHEN "Remainder" THEN '+ FloatToStrF(dAmountReminder, ffFixed, 15, 2) +' '+
                'ELSE 0.00 END as Amount '+
                'FROM tblpays AS P '+
                'INNER JOIN tblpayssplits AS PS on PS.PayID = P.PayID '+
                'LEFT JOIN tblbankcodes AS BC on PS.BankID = BC.CodeID and (ifnull(RegionId,0) =0 or ifnull(RegionId,0) = ' + inttostr( AppEnv.RegionalOptions.ID)+')'+
                'WHERE (P.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';
        {Superannuation}
        saSQL4 :='SELECT P.Deleted,'+
                'IF(ISNULL(SUP.Company), "Unknown Super Fund", SUP.Company) AS "Super Fund", '+
                'PS.AmountPaid AS "Amount", '+
                'SUPT.Description as Type '+
                'FROM tblpays AS P '+
                'INNER JOIN tblpayssuperannuation AS PS on PS.PayID = P.PayID '+
                'LEFT JOIN tblsupertype as SUPT USING(SuperTypeID) '+
                'LEFT JOIN tblClients AS SUP on PS.ClientID = SUP.ClientID '+
                'WHERE (P.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")' +
                ' AND PS.BelowThreshold <> "T"'  ;

        {Entitlements}
        ANDstr := ' ';
        if not(commonlib.devmode) then begin
          if Not AppEnv.PayPrefs.ShowAccruedAnnualLeavePaySlip then begin
            ANDstr := ' AND L.LeaveType <> "Annual Leave" ';
          end;
          if Not AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip then begin
            ANDstr := ANDstr + ' AND L.LeaveType <> "' + Appenv.RegionalOptions.SLName +'" ';
          end;
          if Not AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip then begin
            ANDstr := ANDstr + ' AND L.LeaveType <> "Long Service" ';
          end;
        end;

        saSQL5 :='SELECT P.Deleted,P.PayID,'+
                'L.LeaveType As "Description", '+
                'L.AccruedHours,'+
                '(Sum(L.AccruedHours)+ OpenningBalanceHrs)/' + Floattostr((AppEnv.CompanyPrefs.HoursPerWeek/5)) +' AS "Days", '+
                'Sum(L.AccruedHours)+ OpenningBalanceHrs AS "Amount" '+
                'FROM tblleaveaccruals AS L '+
                'INNER JOIN tblleave AS EL on  EL.EmployeeID =  L.EmployeeID AND L.LeaveType=EL.Type '+
                'INNER JOIN tblpays AS P on L.PayID = P.PayID '+
                'WHERE P.Deleted = "F" AND L.EmployeeID = ' + IntToStr(ThisPay.EmployeeDetails.id) +
                ' AND P.PayDate <= ' + QuotedStr(DateTimeToMysqlDateStr(ThisPay.Paydate)) + ANDstr +
                ' GROUP BY L.LeaveType';

        {Sundries}
        saSQL6 :='SELECT P.Deleted,'+
                'S.Sundry As "Description", '+
                'S.Amount AS "Amount" '+
                'FROM tblpays AS P '+
                'INNER JOIN tblpayssundries AS S Using(PayID) '+
                'WHERE (P.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';

        {Commission}
        saSQL7 :='SELECT P.Deleted,Deleted,'+
                'C.CommissionDesc As "Description", '+
                'C.ClassName as Department,'+
                'C.Gross AS "Amount" '+
                'FROM tblpays AS P '+
                'INNER JOIN tblpayscommission AS C Using(PayID) '+
                'WHERE (P.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (P.Deleted = "F")';

         {TimeSheet}

         saSQL8 := 'SELECT DATE(TS.TimesheetDate) as Date,tblPays.Deleted,B.Description, T.Description as Type, A.LineTotal,' +
                ' IF(T.Description = "Hourly Rate" OR T.Description = "Salary" OR T.Description = "Piece-Rate", A.Qty, 0.0) as Qty,' +
                ' IF(T.Description = "Hourly Rate" OR T.Description = "Salary" OR T.Description = "Piece-Rate", A.Amount, 0.0) as Rate,' +
                ' tblPays.PayID,TS.ID,TS.Job' +
                ' FROM  tblPays' +
                ' INNER JOIN tblpayspayrates AS A USING (PayID)' +
                ' INNER JOIN tbltimesheets as TS ON A.timesheetID= TS.ID' +
                ' LEFT JOIN tblpayrates as B ON A.PayRateID = B.RateID' +
                ' LEFT JOIN tblpayratetype as T ON A.TypeID = T.TypeID' +
                ' WHERE (tblPays.PayID = ' + IntToStr(ThisPay.PayID) + ') AND (tblPays.Deleted = "F")' +
                ' AND (A.TimesheetID > 0)' ;




            {Notes}

            saSQL9 := 'SELECT PayNotes FROM tblpays WHERE tblpays.PayID = ' + IntToStr(ThisPay.PayID);

            {LeaveTaken}

            saSQL10 := 'SELECT *,p.Deleted FROM tblpaysleave as pl INNER JOIN tblpays as p WHERE pl.PayID = p.PayID ' +
                        'AND p.Deleted = "F" AND pl.PayID = ' + IntToStr(ThisPay.PayID) ;


            {EmployeeTerminate}

              //work around. EmployeeTermination subreport thinks its getting data even when the fields are null when a payID is used
              // there must be a solution cause it doesn't happen with deductions etc;  can remove the else code when solution is found

            if (ThisPay.Lumpa > 0) or (ThisPay.Lumpb > 0) or (ThisPay.Lumpd > 0) or (ThisPay.Lumpe > 0) or (ThisPay.Etp > 0) then begin
              saSQL11 := 'SELECT LumpA,LumpB,LumpD,LumpE,ETP FROM tblPays WHERE PayID = ' + IntToStr(ThisPay.PayID) +
                       ' AND Deleted = "F"';
            end else begin
              saSQL11 := 'SELECT LumpA,LumpB,LumpD,LumpE,ETP FROM tblPays WHERE PayID = 0';
            end;

            saSQL12 := 'SELECT type, accrueddate, OpenningBalanceHrs AS Amount ' +
                        ' FROM tblleave AS EL ' +
                        ' Where EL.EmployeeID =  ' +inttostr(ThisPay.EmployeeDetails.id);
            if not(commonlib.devmode) then begin
              if Not AppEnv.PayPrefs.ShowAccruedAnnualLeavePaySlip then begin
                saSQL12 := saSQL12 + ' AND EL.Type <> "Annual Leave" ';
              end;
              if Not AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip then begin
                saSQL12 := saSQL12 +  ' AND EL.Type <> "' + Appenv.RegionalOptions.SLName +'" ';
              end;
              if Not AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip then begin
                saSQL12 := saSQL12 +  ' AND EL.Type <> "Long Service" ';
              end;
            end;

            EmployeeTaxSQL :=
              'select tblpaytaxconfig.TaxName, ' +
              'sum(tblpaytax.Amount) as ThisPayTax, ' +
              '(select sum(pt.Amount) from tblpaytax pt inner join tblpays p ' +
              'on p.PayID = pt.PayID and p.Paid = "T" and p.Deleted = "F" ' +
              'and p.EmployeeId = ' + IntToStr(ThisPay.EmployeeId) + ' ' +
              'and p.PayDate between '+QuotedStr(FormatDateTime(MysqlDateFormat, GetCurrentFiscalYearStart(ThisPay.PayDate)))+
              ' and '+QuotedStr(FormatDateTime(MysqlDateFormat, ThisPay.PayDate))+' ' +
              'where pt.PayTaxConfigId = tblpaytaxconfig.ID) as YTDTax ' +
              'from tblpays ' +
              'inner join tblpaytax on tblpaytax.PayID = tblpays.PayID ' +
              'inner join tblpaytaxconfig on tblpaytax.PayTaxConfigId = tblpaytaxconfig.ID ' +
              'and tblpaytaxconfig.TaxType = "Employee" ' +
              'where tblPays.PayId = '+IntToStr(ThisPay.PayID)+' ' +
              'group by tblpaytaxconfig.Id ' +
              'order by tblpaytaxconfig.PrimaryTax, tblpaytaxconfig.TaxName';

            CompanyTaxSQL :=
              'select tblpaytaxconfig.TaxName, ' +
              'sum(tblpaytax.Amount) as ThisPayTax, ' +
              '(select sum(pt.Amount) from tblpaytax pt inner join tblpays p ' +
              'on p.PayID = pt.PayID and p.Paid = "T" and p.Deleted = "F" ' +
              'and p.EmployeeId = ' + IntToStr(ThisPay.EmployeeId) + ' ' +
              'and p.PayDate between '+QuotedStr(FormatDateTime(MysqlDateFormat, GetCurrentFiscalYearStart(ThisPay.PayDate)))+
              ' and '+QuotedStr(FormatDateTime(MysqlDateFormat, ThisPay.PayDate))+' ' +
              'where pt.PayTaxConfigId = tblpaytaxconfig.ID) as YTDTax ' +
              'from tblpays ' +
              'inner join tblpaytax on tblpaytax.PayID = tblpays.PayID ' +
              'inner join tblpaytaxconfig on tblpaytax.PayTaxConfigId = tblpaytaxconfig.ID ' +
              'and tblpaytaxconfig.TaxType = "Company" ' +
              'where tblPays.PayId = '+IntToStr(ThisPay.PayID)+' ' +
              'group by tblpaytaxconfig.Id ' +
              'order by tblpaytaxconfig.PrimaryTax, tblpaytaxconfig.TaxName';

            result := '{Payment Details}' +saSQL+
                                  '~|||~{Allowances}'+saSQL1+
                                  '~|||~{Deductions}'+saSQL2+
                                  '~|||~{WorkPlacegiving}'+saSQL13+
                                  '~|||~{Banking}'+saSQL3+
                                  '~|||~{Superannuation}'+saSQL4+
                                  '~|||~{Entitlements}'+saSQL5+
                                  '~|||~{Sundries}'+saSQL6+
                                  '~|||~{Commission}'+saSQL7+
                                  '~|||~{TimeSheet}'+saSQL8+
                                  '~|||~{PayNotes}'+saSQL9 +
                                  '~|||~{LeaveTaken}'+saSQL10+
                                  '~|||~{LeaveOpeningbalance}'+saSQL12 +
                                  '~|||~{TerminateDetails}'+saSQL11
                                  + '~|||~{EmployeeTax}'+EmployeeTaxSQL
                                  + '~|||~{CompanyTax}'+CompanyTaxSQL
                                  ;
end;

procedure TPayUtils.PrintPaySlip(Const ThisPay: TPaybase; Const Preview: Boolean; Const SendPaySlipViaEmail : String);
var
  RTemplates                    :TReportTemplates;
  fsReportName:String;
  sALLSQL:string;
  iSQLcounter                   :Integer;
  TempMyqry             :TERPQuery;
  PipeName         :String;
  sBody                :String;
  PayslipFileName: string;

begin
  RTemplates := TReportTemplates.Create;
  RTemplates.MyConnection :=  TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
  try
    with RTemplates do begin
      if not CreatedOk then exit;

      fsReportName := tcdatautils.GetDefaultReport(68);
      sALLSQL := PrintPaySlipSQL(thisPay);

      If not empty(fsReportName) then Begin
        GetSQLForReport(fsReportName); // creates  report stream
      end else Begin
        GetSQLForReport('PaySlip'); // creates  report stream
      end;

      try
        for iSQLcounter := 1 to GetSQLCount(fsReportName) do begin
          TempMyqry := GetMyQuery(iSQLcounter );

          if (TempMyqry=nil) then
            Continue;

          TempMyqry.Close;
          TempMyqry.Sql.Clear;
          TempMyqry.Sql.Text := ExtractStrPortion(sALLSQL,'~|||~',iSQLcounter);
          PipeName :=Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));

          if (Trim(TempMyqry.Sql.Text)<>PipeName) then begin
            RTemplates.PipelineUserName[iSQLcounter] := PipeName;
            TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
          end;

          TempMyqry.Open;
        end;
      except

      end;

      ReportStream.Position := 0;
      Report.Template.LoadFromStream(ReportStream);
      Report.ShowPrintDialog := false;

      Report.DeviceType := 'Screen';
      if not Preview then begin
        Report.DeviceType := 'Printer';
      end;

      if AppEnv.Employee.ShowPrintDialog then
        Report.ShowPrintDialog := True
      else Report.ShowPrintDialog := False;

      Report.PrinterSetup.Copies := 1;
      if (ThisPay.EmployeeDetails.Sendpayslipviaemail = 'F')
       or (ThisPay.EmployeeDetails.SendPaySlipViaEmail = 'B') then begin
        Try
          Report.Print;
        except
          on E: Exception do begin
            If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
              CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
            end else
              raise;
          end;
        end;
      end;

      //email
      if (ThisPay.EmployeeDetails.Sendpayslipviaemail = 'T')
       or (ThisPay.EmployeeDetails.SendPaySlipViaEmail = 'B') then begin
        if (not empty(ThisPay.EmployeeDetails.Email)) then begin


          //Save as pdf file so we can attach to the email
          Report.AllowPrintToFile := True;
          Report.ShowPrintDialog := False;
          Report.DeviceType := 'PDF';
          PayslipFileName:= Commonlib.TempDir + ThisPay.EmployeeDetails.Employeename + IntToStr(ThisPay.PayID) + '.pdf';
          Report.TextFileName :=  PayslipFileName;

          Report.PDFSettings.Author := AppEnv.CompanyInfo.Tradingname;
          Report.PDFSettings.Title := 'Print to PDF!';
          Report.PDFSettings.CompressionLevel := clDefault;
          Report.PDFSettings.OptimizeImageExport := True;
          Report.PDFSettings.OpenPDFFile := False;

          Try
            Report.Print;
          except
            on E: Exception do begin
              If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
              end else
                raise;
            end;
          end;

          If (ThisPay.EmployeeDetails.Sendpayslipviaemail = 'T')
           or (ThisPay.EmployeeDetails.Sendpayslipviaemail = 'B') then Begin

            sBody := 'Attached is your Pay slip';
            try
              SendEmail(getEmailFrom,ThisPay.EmployeeDetails.Email, '',
                  PayslipFileName,
                  ThisPay.EmployeeDetails.EmployeeName + ' Pay Slip', sBody);

              SysUtils.DeleteFile(PayslipFileName);
            except

            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(RTemplates);
  end;
end;

procedure TPayUtils.PrintPayHistoryReport(const Preview: Boolean;dtFrom:TDateTime;dtTo:TDateTime);
var
  sSQL: String;
  qryTemp:TERPQuery;
  Templates: TReportTemplates;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := False;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ');
    qryTemp.Sql.Add('Sum(P.Wages) as Wages,');
    qryTemp.Sql.Add('Sum(P.Commission) as Commission,');
    qryTemp.Sql.Add('Sum(P.Deductions) as Deductions,');
    qryTemp.Sql.Add('Sum(P.Workplacegiving) as Workplacegiving,');
    qryTemp.Sql.Add('Sum(P.Allowances) as Allowances,');
    qryTemp.Sql.Add('Sum(P.Sundries) as Sundries,');
    qryTemp.Sql.Add('Sum(P.Superannuation) as Superannuation,');
    qryTemp.Sql.Add('Sum(P.Gross) as Gross,');
    qryTemp.Sql.Add('Sum(P.Tax) as Tax,');
    qryTemp.Sql.Add('Sum(P.Net) as Net,');
    qryTemp.Sql.Add('Sum(P.CDEPGross) as CDEPGross ');
    qryTemp.Sql.Add('FROM tblpays AS P WHERE Paid = "T" AND Deleted <> "T"');
    qryTemp.Sql.Add(' AND PayDate BETWEEN ' + QuotedStr(FormatDateTime ('yyy-mm-dd',dtFrom)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat,dtTo)));

    qryTemp.Open;
    Templates := TReportTemplates.Create;
    with Templates do begin
      if not CreatedOk then exit;
      GetSQLForReport('Pay History Report'); // creates  report stream
      sSQL := 'SELECT   CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,  Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,     Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN AS ABN,'+
              'P.PayDate, P.Wages, P.Commission, P.Deductions, P.Workplacegiving, P.Allowances, P.Sundries, P.Superannuation, P.Gross, P.Tax, P.Net, P.CDEPGross, P.EmpName,'+
              'PR.PayID, PR.Qty, PR.Amount, PR.LineTotal, R.Description,'+

              FloatToStr(qryTemp.FieldByName('Wages').AsFloat)+' as TotalWages,'+
              FloatToStr(qryTemp.FieldByName('Commission').AsFloat)+' as TotalCommission,'+
              FloatToStr(qryTemp.FieldByName('Deductions').AsFloat)+' as TotalDeductions,'+
              FloatToStr(qryTemp.FieldByName('Workplacegiving').AsFloat)+' as TotalWorkplacegivings,'+
              FloatToStr(qryTemp.FieldByName('Allowances').AsFloat)+' as TotalAllowances,'+
              FloatToStr(qryTemp.FieldByName('Sundries').AsFloat)+' as TotalSundries,'+
              FloatToStr(qryTemp.FieldByName('Superannuation').AsFloat)+' as TotalSuperannuation,'+
              FloatToStr(qryTemp.FieldByName('Gross').AsFloat)+' as TotalGross,'+
              FloatToStr(qryTemp.FieldByName('Tax').AsFloat)+' as TotalTax,'+
              FloatToStr(qryTemp.FieldByName('Net').AsFloat)+' as TotalNet,'+
              FloatToStr(qryTemp.FieldByName('CDEPGross').AsFloat)+' as TotalCDEPGross '+

              'FROM tblCompanyInformation AS CO, tblpays AS P '+
              'LEFT JOIN tblpayspayrates AS PR Using(PayID) '+
              'LEFT  JOIN tblpayrates AS R ON PR.PayRateID = R.RateID ';
      sSQL := sSQL + 'WHERE Paid = "T"';
      sSQL := sSQL + ' AND P.PayDate BETWEEN ' + QuotedStr(FormatDateTime ('yyy-mm-dd',dtFrom)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat,dtTo));
      sSQL := sSQL + ' AND P.Deleted <> "T" ';
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
          If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
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

procedure TPayUtils.SendEmail(Const sEmailFrom,sEmailto,sPassword,sFilename,sSubject,sMessage:string);
var
  sTemp : string;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  Corres := TCorrespondenceGui.Create;
  try
    Corres.RecipientList := sEmailto;
    Corres.Subject := sSubject;
    Corres.MessageText := sMessage;
    If FileExists( Commonlib.TempDir  + sFileName) then
      sTemp :=  Commonlib.TempDir  + sFileName
    else If FileExists(sFileName) then
      sTemp := sFileName;
    if FileExists(sTemp) then
      Corres.AttachmentList.Add(sTemp);
    if not EmailShortSendMode(lSilent, lSecret) then
      exit;
    Corres.Execute(lSilent, lSecret);
  finally
    Corres.Free;
  end;
end;

procedure TPayUtils.PrintFromDB(Const empName:string;Const Preview: Boolean);
var
  qryTemp :TERPQuery;
  tmpTemplates:TReportTemplates;
  TempMyqry: TERPQuery;
  sALLSQL:string;
  iSQLcounter: integer;
  PipeName:String;
  fsReportName: String;

begin
  qryTemp := TERPQuery.Create(nil);
  tmpTemplates := TReportTemplates.Create;
  try
    if not tmpTemplates.CreatedOk then exit;
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.SQL.Add('SELECT * FROM tmp_pay_' + GetMachineIdentification(true, true, true, true)+' WHERE empName = "' + empName + '"');
    qryTemp.Open;

    sALLSQL := qryTemp.FieldByName('SQLString').AsString;

                      //Load template
    fsReportName := tcdatautils.GetDefaultReport(68); //Payslip Type

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
      If (Trim(TempMyqry.Sql.Text)<>PipeName) Then Begin
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
        If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
          CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
        end else
          raise;
      end;
    end;

  finally
    FreeAndNil(tmpTemplates);
  end;
end;

Function TPayUtils.PaysReportSQL(const Preview: Boolean; const aPayId:Integer =0):String;
var
  sSQL: String;
  qryTemp:TERPQuery;
  Templates: TReportTemplates;
begin
  sSQL := '';
  try
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := False;
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ');
    qryTemp.Sql.Add('Sum(P.Wages) as Wages,');
    qryTemp.Sql.Add('Sum(P.Commission) as Commission,');
    qryTemp.Sql.Add('Sum(P.Deductions) as Deductions,');
    qryTemp.Sql.Add('Sum(P.Workplacegiving) as Workplacegiving,');
    qryTemp.Sql.Add('Sum(P.Allowances) as Allowances,');
    qryTemp.Sql.Add('Sum(P.Sundries) as Sundries,');
    qryTemp.Sql.Add('Sum(P.Superannuation) as Superannuation,');
    qryTemp.Sql.Add('Sum(P.Gross) as Gross,');
    qryTemp.Sql.Add('Sum(P.Tax) as Tax,');
    qryTemp.Sql.Add('Sum(P.Net) as Net,');
    qryTemp.Sql.Add('Sum(P.CDEPGross) as CDEPGross ');
    qryTemp.Sql.Add('FROM tblpays AS P WHERE Paid = "F" And Pay="T" AND Deleted = "F" and IfNull(EmployeeID,0) > 0');
    qryTemp.Open;
    Templates := TReportTemplates.Create;
    with Templates do begin
      if not CreatedOk then exit;
      GetSQLForReport('Payslip Report'); // creates  report stream
      sSQL := 'SELECT   CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,  Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,     Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN AS ABN,'+
              'P.PayDate, P.Wages, P.Commission, P.Deductions, P.Workplacegiving, P.Allowances, P.Sundries, P.Superannuation, P.Gross, P.Tax, P.Net, P.CDEPGross, P.EmpName,'+
              'PR.PayID, PR.Qty, PR.Amount, PR.LineTotal, R.Description,'+

              FloatToStr(qryTemp.FieldByName('Wages').AsFloat)+' as TotalWages,'+
              FloatToStr(qryTemp.FieldByName('Commission').AsFloat)+' as TotalCommission,'+
              FloatToStr(qryTemp.FieldByName('Deductions').AsFloat)+' as TotalDeductions,'+
              FloatToStr(qryTemp.FieldByName('Workplacegiving').AsFloat)+' as TotalWorkplacegiving,'+
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

      if aPayId <> 0 then sSQL := sSQL + ' WHERE P.payId = '+ inttostr(aPayID) +
                                         ' and Pay="T" '+
                                         ' and Deleted<>"T"'
      else sSQL := sSQL + ' WHERE Paid = "F" '+
                        ' and Pay="T"  '+
                        ' and Deleted<>"T"';

       sSQL := sSQL + ' ORDER BY P.EmpName';
    end;
  finally
    result := sSQL;
  end;
  finally
    FreeAndNil(qryTemp);
    FreeAndNil(Templates);
  end;
end;

procedure TPayUtils.LoadRoster(const EmployeeID:integer);
var
  qryRosteredEmployees  :TERPQuery;
  Pay                   : TPaybase;
  Roster                : TRoster;
  dHours                : double;
  tmpStart,tmpEnd       :TDateTime;
  iTmpDay               :integer;
begin
  //for each employee on roster
  qryRosteredEmployees  := TERPQuery.Create(nil);
  Pay                   := TPaybase.Create(nil,AppEnv.RegionalOptions.Region,TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection )  );
  Roster                := Troster.Create(nil);
  try
    qryRosteredEmployees.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
    qryRosteredEmployees.SQL.Clear;
    qryRosteredEmployees.SQL.Text := 'SELECT EmployeeID,Active,IsOnTheRoster,LoadHoursFromRoster,LoadLeaveFromRoster ' +
                                     'FROM tblemployees WHERE Active = "T" AND IsOnTheRoster = "T" ';

    if EmployeeID <> 0 then qryRosteredEmployees.SQL.Add(' AND EmployeeID = ' + IntToStr(EmployeeID));

    qryRosteredEmployees.Open;
    qryRosteredEmployees.First;

    while not qryRosteredEmployees.Eof do begin
      if UnprocessedPayExists(qryRosteredEmployees.fieldByName('EmployeeID').AsInteger) = 0 then begin
        Next;
        Continue; //unprocessed pay should always exist
      end;
      Pay.Load(GetUnprocessedPayID(qryRosteredEmployees.fieldByName('EmployeeID').AsInteger));

      if (Pay.EmployeeDetails.Loadhoursfromroster = False) and (Pay.EmployeeDetails.Loadleavefromroster = False) then begin
        qryRosteredEmployees.Next;
        Continue;
      end;

      if Pay.EmployeeDetails.Loadhoursfromroster then begin
        While not Pay.PaysPayRates.EOF do begin
          Pay.PaysPayRates.Delete;
        end;
      end;
      if Pay.EmployeeDetails.Loadleavefromroster then begin
        while not Pay.PayLeaves.EOF do begin
          Pay.PayLeaves.Delete;
        end;
      end;

      Roster.LoadSelect('EmployeeID = ' + IntToStr(Pay.EmployeeDetails.Id) +
                         ' AND starttime <= ' + QuotedStr(FormatDateTime(MysqlDateFormat,Pay.Paydate)) +
                         ' AND endtime   >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,Pay.PayFromDate)));

      if (AppEnv.CompanyPrefs.UseClockedHrs) and (Roster.IsClocked = False) then begin
        QryRosteredEmployees.Next;
        Continue;
      end;
      if (AppEnv.CompanyPrefs.UseClockedHrs = False) and (Roster.IsClocked = True) then begin
        QryRosteredEmployees.Next;
        Continue;
      end;
      Roster.First;
      While not Roster.EOF do begin
        dHours := Roster.Hours;
        iTmpDay := Trunc(Roster.StartTime);
        if (AppEnv.CompanyPrefs.IgnoreEarlyStart) and (AppEnv.CompanyPrefs.IgnoreLateFinish) then begin
          if CompareTime(Roster.StartTime,(iTmpDay + AppEnv.CompanyPrefs.StartOfDay)) < 0 then begin
            tmpStart := iTmpDay + AppEnv.CompanyPrefs.StartOfDay;
          end else tmpStart := Roster.StartTime;

          if CompareTime(Roster.EndTime,(iTmpDay + AppEnv.CompanyPrefs.EndOfDay)) >= 1 then begin
            tmpEnd := iTmpDay + AppEnv.CompanyPrefs.EndOfDay;
          end else tmpEnd := Roster.EndTime;

          dHours := (tmpEnd - tmpStart) * 24;
          dHours := Round(dHours,OtherRoundPlaces);
        end;

        if (AppEnv.CompanyPrefs.IgnoreEarlyStart = True) and (AppEnv.CompanyPrefs.IgnoreLateFinish = False) then begin
          if CompareTime(Roster.StartTime,(iTmpDay + AppEnv.CompanyPrefs.StartOfDay)) < 0 then begin
            tmpStart := iTmpDay + AppEnv.CompanyPrefs.StartOfDay;
          end else tmpStart := Roster.StartTime;
          dHours := (Roster.EndTime - tmpStart) * 24;
          dHours := Round(dHours,OtherRoundPlaces);
        end;

        if (AppEnv.CompanyPrefs.IgnoreEarlyStart = False) and (AppEnv.CompanyPrefs.IgnoreLateFinish = True) then begin
          if CompareTime(Roster.EndTime,(iTmpDay + AppEnv.CompanyPrefs.EndOfDay)) >= 1 then begin
            tmpEnd := iTmpDay + AppEnv.CompanyPrefs.EndOfDay;
          end else tmpEnd := Roster.EndTime;
          dHours := (tmpEnd - Roster.StartTime) * 24;
          dHours := Round(dHours,OtherRoundPlaces);
        end;

        if dHours >= Pay.EmployeeDetails.Mealbreakthreshold then begin //this threshold will now control IF A MEAL BREAK IS TO BE TAKEN
          dHours := dHours - Pay.EmployeeDetails.Mealbreakhours;
          if dHours < 0 then dHours := 0; //just in case mealbreak is set stupidly high
        end;

        if Roster.TypeCatagory = 'Allocation' then begin   //normal hours
          if not Pay.EmployeeDetails.Loadhoursfromroster then Continue;
          Pay.ValidationDisabled := True;
          Pay.PaysPayRates.New;
          Pay.PaysPayRates.Payrateid        := 2; //hard coded to normal hours
          Pay.PaysPayRates.Typeid           := 1;  //hard codes to  hourly rate
          Pay.PaysPayRates.Qty              := dHours;
          Pay.PaysPayRates.Linetotal        := dHours * Pay.EmployeePayRates.HighestStandardHourlyRate;
          Pay.PaysPayRates.Amount           :=  Pay.EmployeePayRates.HighestStandardHourlyRate;
          Pay.PaysPayRates.Superinc         :=  True;
          Pay.PaysPayRates.Classid          := Roster.ClassID;
          Pay.PaysPayRates.DepartmentName   := tcDataUtils.GetClassName(Roster.ClassID);
          Pay.RecalcAll;
          Pay.PostDB;
          Pay.PaysPayRates.PostDb;
          Pay.ValidationDisabled := False;
        end else if Roster.TypeCatagory = 'Leave' then begin
          if not Pay.EmployeeDetails.Loadleavefromroster then Continue;
          Pay.ValidationDisabled := True;
          Pay.PaysPayRates.New;
          Pay.PaysPayRates.Typeid           := 1;  //hard codes to  hourly rate
          Pay.PaysPayRates.Payrateid        := GetPayRateID(roster.RosterType);
          Pay.PaysPayRates.Qty              := dHours;
          Pay.PaysPayRates.Linetotal        := dHours * (Pay.EmployeePayRates.HighestStandardHourlyRate * (1 + (GetLeaveLoading(Pay.EmployeeDetails.Id,Roster.RosterType)/100))) ;
          Pay.PaysPayRates.Amount           := Pay.EmployeePayRates.HighestStandardHourlyRate * (1 + (GetLeaveLoading(Pay.EmployeeDetails.Id,Roster.RosterType)/100));
          Pay.PaysPayRates.Superinc         := True;
          Pay.PaysPayRates.Classid          := Roster.ClassID;
          Pay.PaysPayRates.DepartmentName   := tcDataUtils.GetClassName(Roster.ClassID);

          Pay.PaysPayRates.PostDb;

          Pay.PayLeaves.New;
          Pay.PayLeaves.Leavetype           := roster.RosterType;
          Pay.PayLeaves.Qty                 := dHours;
          Pay.PayLeaves.Amount              := Pay.EmployeePayRates.HighestStandardHourlyRate * (1 + (GetLeaveLoading(Pay.EmployeeDetails.Id,Roster.RosterType)/100));
          Pay.PayLeaves.Classid             := Roster.ClassID;
          Pay.PayLeaves.DepartmentName      := tcDataUtils.GetClassName(Roster.ClassID);
          Pay.PayLeaves.Datetaken           := Roster.StartTime;

          Pay.PayLeaves.PostDb;
          Pay.ValidationDisabled := False;

          Pay.RecalcAll;
          Pay.PostDB;
        end;
        Roster.Next;
      end;
      Pay.RecalcAll;
      qryRosteredEmployees.Next;
    end;
  finally
    FreeAndNil(qryRosteredEmployees);
    Pay.Free;
    Roster.Free;
  end;
end;

procedure TPayUtils.TimeSheetDateCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is  TTimeSheet) then exit;
    if smallesttimesheetdt > TTimeSheet(Sender).TimeSheetDate then smallesttimesheetdt:= TTimeSheet(Sender).TimeSheetDate;
    if largesttimesheetDt  < TTimeSheet(Sender).TimeSheetDate then largesttimesheetDt := TTimeSheet(Sender).TimeSheetDate;
end;


procedure TPayUtils.LoadTimeSheet(Pay:Tpaybase;msgOption:Integer=0);
var
  TotalTimesheetHrs,TotalStandardHrs:double;
  dDiff:double;
  fTimeSheet            :TTimeSheet;
begin
  inherited;

 // if Assigned(Pay.Connection) then ShowMessage('1499 pay connection ok') else ShowMessage('1499 no pay connection');

  fPayForTimeSheet := Pay;


  //delete all hours
  Pay.PaysPayRates.DeleteAll;
  //load employee hours
  Pay.PaysPayRates.AllowRecalc := False;


  Pay.EmployeePayRates.IterateRecords(CallbackAddPayRatesToPay,False);
  Pay.PaysPayRates.AllowRecalc := True;

  if Pay.RecalcInProgress = False then begin
     Pay.RecalcAll;
  end;




    fTimeSheet                   := TTimeSheet.Create(Self);
    fTimeSheet.Connection        := Self.Connection;
    fTimeSheet.SilentMode        := Self.SilentMode;
    fTimeSheet.LoadSelect('EmployeeID = ' + IntToStr(Pay.EmployeeID) +
                          ' and TimeSheetDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat,Pay.Paydate)) +
                          ' and T.id not in  (Select distinct ifnull(TimeSheetId,0) from tblPays AS P INNER JOIN tblpayspayrates AS PR on PR.PayID = P.PayID and P.Deleted ="F")');
    if fTimeSheet.count > 0 then begin
      if not silentMode then begin
        fTimeSheet.First;
        smallesttimesheetdt:= fTimeSheet.TimeSheetDate;
        largesttimesheetDt:= fTimeSheet.TimeSheetDate;
        fTimeSheet.Iteraterecords(TimeSheetDateCallback);
      if msgOption =0 then begin
        msgOption := 101;
        if (Pay.PayFromDate>smallesttimesheetdt) or (Pay.PayDate <largesttimesheetDt) then
          msgOption:= MessageDlgXP_Vista('This Pay is for the Period of ' + Quotedstr(formatdatetime(FormatSettings.shortdateformat , Pay.PayfromDate)) + ' to '  + Quotedstr(formatdatetime(FormatSettings.shortdateformat , Pay.PayDate))+'.'   + NL +NL+
                        'There are Timesheets Prior to this Period.' , // + formatdatetime(shortdateformat , smallesttimesheetDt)  +' to ' + formatdatetime(shortdateformat , LargesttimeSheetdt)+'.' ,
                          mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'Load Current Timesheets, Load All , Cancel');
      end;
    end else begin
      msgOption := 101;
    end;



    if msgOption <> 102 then begin
      //load timesheet hours
      fTimeSheet.First;
      while not fTimeSheet.EOF do begin
        if (msgOption = 101) or
           ((fTimeSheet.TimeSheetDate>=  Pay.PayfromDate) and (fTimeSheet.TimeSheetDate<=Pay.PayDate)) then begin
          Pay.PaysPayRates.New;
          Pay.PaysPayRates.Payrateid        :=  fTimeSheet.PayRateTypeID;   //normal hours,double time etc
          Pay.PaysPayRates.Typeid           :=  iif(fTimeSheet.RateTypeID=0, 1, fTimeSheet.RateTypeID);   //1 : hourly rate
          Pay.PaysPayRates.Qty              :=  fTimeSheet.Hours;
          Pay.PaysPayRates.Linetotal        :=  fTimeSheet.Total;
          Pay.PaysPayRates.Amount           :=  Divzer(fTimeSheet.Total,fTimeSheet.Hours);
          Pay.PaysPayRates.Superinc         :=  fTimeSheet.SuperInc;
          Pay.PaysPayRates.Clientid         :=  fTimeSheet.JobID;
          Pay.PaysPayRates.Classid          :=  fTimeSheet.TimeSheetClassID;
          Pay.PaysPayRates.DepartmentName   :=  tcDataUtils.GetClassName(fTimeSheet.TimeSheetClassID);
          Pay.PaysPayRates.Timesheetid      :=  fTimeSheet.TimeSheetID;
          Pay.PaysPayRates.PostDb;
        end;
        fTimeSheet.Next;
      end;
    end;
  end;

  //  if Assigned(Pay.Connection) then ShowMessage('1561 pay connection ok') else ShowMessage('1561 no pay connection');


  //Adjust non timesheet hours back
  Pay.PaysPayRates.First;
  TotalStandardHrs  := 0;
  TotalTimesheetHrs := 0;  //get total timesheet hours in payspayrates
  while not Pay.PaysPayRates.EOF do begin
    if Pay.PaysPayRates.Timesheetid > 0 then TotalTimeSheetHrs := TotalTimesheetHrs +  Pay.PaysPayRates.Qty;
    if (Pay.PaysPayRates.Timesheetid < 1) and (Pay.PaysPayRates.Payrateid = 2) then TotalStandardHrs := TotalStandardHrs + Pay.PaysPayRates.Qty;
    Pay.PaysPayRates.Next;
  end;

  Pay.PaysPayRates.First;
  dDiff := TotalStandardHrs - TotalTimesheetHrs;
  if dDiff > 0 then begin
    while not (Pay.PaysPayRates.EOF) and (TotalTimesheetHrs > 0) do begin
      if (Pay.PaysPayRates.Payrateid = 2) and (Pay.PaysPayRates.Timesheetid < 1) then begin  //normal hours
        if TotalTimesheetHrs <= Pay.PaysPayRates.Qty then  begin
          Pay.PaysPayRates.Qty := Pay.PaysPayRates.Qty - TotalTimesheetHrs;
          TotalTimesheetHrs := 0;
        end else begin
          TotalTimesheetHrs := TotalTimesheetHrs - Pay.PaysPayRates.Qty ;
          Pay.PaysPayRates.Qty := 0;
        end;
      end;
      Pay.PaysPayRates.PostDb;
      Pay.PaysPayRates.Next;
    end;
  end;
  Pay.PaysPayRates.RemoveZeroTotalEntries;

  //add leave taken to hours
  if Pay.PayLeaves.Count > 0 then begin
    Pay.PayLeaves.LeaveChanged := True;
    Pay.AddLeavesToPay;
  end;


//  FreeAndNil(fPayForTimeSheet);

  //    if Assigned(Pay.Connection) then ShowMessage('1599 pay connection ok') else ShowMessage('1599 no pay connection');

end;


procedure TPayUtils.VerifyAndFixAccruedLeave(iEmployeeID:integer);
var
  qry:TERPQuery;

begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection);
    qry.SQL.Add('SELECT tblleaveaccruals.PayID FROM tblleaveaccruals');
    qry.SQL.Add('INNER JOIN tblpays ON tblleaveaccruals.PayID=tblpays.PayId');
    qry.SQL.Add('WHERE  tblleaveaccruals.EmployeeID = :xEmployeeID');
    qry.SQL.Add('AND tblpays.Deleted = "F"');
    qry.SQL.Add('GROUP BY tblleaveaccruals.PayID');
    qry.SQL.Add('ORDER BY tblleaveaccruals.PayID');

    qry.Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
    qry.Open;

    if Assigned(fPay) then fPay.Free;
    fPay := Tpaybase.Create(Self,AppEnv.RegionalOptions.Region,TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection ));

    qry.First;
    while not qry.Eof do begin
      fPay.Load(qry.fieldByName('PayID').AsInteger);
      fPay.EmployeeLeave.VerifyAndFixAccruedLeaves := True;
      fPay.EmployeeLeave.AccrueLeaves;
      fPay.Save;
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;


initialization
  RegisterClassOnce(TPayUtils);
end.

