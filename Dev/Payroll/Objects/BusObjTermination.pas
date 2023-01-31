unit BusObjTermination;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   10/10/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, MyAccess,ERPdbComponents,BusObjPaybase,
  XMLDoc, XMLIntf;


type
   Temployeeterminations = class(TMSBusObj)

   private
      fDoDelete                                :Boolean;
      fPayObj                                  :Tpaybase;
      fMyConnection                            :TERPConnection;
      fLongServiceCalcInProgress               :Boolean;
      fAnnualLeaveCalcInProgress               :Boolean;
      fMainCalculationsInProgress              :Boolean;
      fdAssesableETP                           :Double;
      fdTaxableETPAmt                          :Double;
      fdTaxFreeETPAmt                          :Double;
      fdAccruedAnnualLeaveHours                :Double;
      fdLeaveHourlyRate                        :Double;
      fAddToEft                                :Boolean;
      fTerminationLoadedToPay                  :Boolean;
      Function GetEmployeeid                   :Integer   ;
      Function GetEmployeename                 :String    ;
      Function GetStartdate                    :TDatetime ;
      Function GetEnddate                      :TDatetime ;
      Function GetDaysservicepre01071983       :Integer   ;
      Function GetDaysservicepost30061983      :Integer   ;
      Function GetEtppre071983                 :Double    ;
      Function GetEtppost061983untaxed         :Double    ;
      Function GetEtptaxfree         :Double    ;
      Function GetEtppost061994component       :Double    ;
      Function GetGrosstermination             :Double    ;
      Function GetTaxwithheld                  :Double    ;
      Function GetEtpassessable                :Double    ;
      Function GetDeathbenefit                 :Boolean   ;
      Function GetTypeofdeathbenefit           :String    ;
      Function GetLumpsuma                     :Double    ;
      Function GetLumpsumb                     :Double    ;
      Function GetLumpsumc                     :Double    ;
      Function GetLumpsumd                     :Double    ;
      Function GetLumpsume                     :Double    ;
      Function GetReasonleft                   :String    ;
      Function GetGrossetp                     :Double    ;
      Function GetCdep                         :Double    ;
      Function GetReportablefb                 :Double    ;
      Function GetTotalallowances              :Double    ;
      Function GetETPEntitled                  :Boolean   ;
      Function GetDeleted                      :Boolean   ;
      Function GetDeathTFN                     :Boolean   ;
      Function GetPayEntitled                  :Boolean   ;
      Function GetManualLongService            :Boolean   ;
      Function GetManualAnnualLeave            :Boolean   ;
      Function getLongServicePre16081978       :Double;
      Function getLongServicePost16081978      :Double;
      Function getLongServicePost17081993      :Double;

      Function getAnnualLeavePre18081993       :Double;
      Function getAnnualLeavePost17081993      :Double;
      Function getAnnLeaveLoadingPre18081993   :Double;
      Function getAnnLeaveLoadingPost17081993  :Double;

      Function GetOtherPaymentType             :String;
      Function getOtherPaymentAmount           :Double;

      Function getETPEarlyRetirement           :Double;
      Function getETPRedundancy                :Double;
      Function getETPInvalidity                :Double;
      Function getETPUnusedRDOs                :Double;
      Function getETPDeath                     :Double;
      Function getETPPayInLieu                 :Double;
      Function getETPGoldenHandshake           :Double;
      Function getETPJobLossComp               :Double;
      Function getETPUnusedSick                :Double;
      Function getETPOther                     :Double;
      Function getETPTotal                     :Double;
      Function getETPRollover                  :Double;

      Function getGross                        :Double;
      Function getPayGross                     :Double;
      Function getTax                          :Double;
      Function getNet                          :Double;
      Function getTotalLumpSums                :Double;
      Function getPayID                        :integer;

      Procedure SetEmployeeid                   (Const Value :Integer   );
      Procedure SetEmployeename                 (Const Value :String    );
      Procedure SetStartdate                    (Const Value :TDatetime );
      Procedure SetEnddate                      (Const Value :TDatetime );
      Procedure SetDaysservicepre01071983       (Const Value :Integer   );
      Procedure SetDaysservicepost30061983      (Const Value :Integer   );
      Procedure SetEtppre071983                 (Const Value :Double    );
      Procedure SetEtppost061983untaxed         (Const Value :Double    );
      Procedure SetEtptaxfree         (Const Value :Double    );
      Procedure SetEtppost061994component       (Const Value :Double    );
      Procedure SetGrosstermination             (Const Value :Double    );
      Procedure SetTaxwithheld                  (Const Value :Double    );
      Procedure SetEtpassessable                (Const Value :Double    );
      Procedure SetDeathbenefit                 (Const Value :Boolean   );
      Procedure SetTypeofdeathbenefit           (Const Value :String    );
      Procedure SetLumpsuma                     (Const Value :Double    );
      Procedure SetLumpsumb                     (Const Value :Double    );
      Procedure SetLumpsumc                     (Const Value :Double    );
      Procedure SetLumpsumd                     (Const Value :Double    );
      Procedure SetLumpsume                     (Const Value :Double    );
      Procedure SetReasonleft                   (Const Value :String    );
      Procedure SetGrossetp                     (Const Value :Double    );
      Procedure SetCdep                         (Const Value :Double    );
      Procedure SetReportablefb                 (Const Value :Double    );
      Procedure SetTotalallowances              (Const Value :Double    );
      Procedure SetETPEntitled                  (Const Value :Boolean  );
      Procedure SetDeathTFN                     (Const Value :Boolean  );
      Procedure SetPayEntitled                  (Const Value :Boolean  );
      Procedure SetDeleted                      (Const Value :Boolean  );
      Procedure SetManualLongService            (Const Value :Boolean  );
      Procedure SetManualAnnualLeave            (Const Value :Boolean  );
      Procedure SetLongServicePre16081978       (Const Value :Double  );
      Procedure SetLongServicePost16081978      (Const Value :Double  );
      Procedure SetLongServicePost17081993      (Const Value :Double  );

      Procedure SetETPEarlyRetirement           (Const Value :Double  );
      Procedure SetETPRedundancy                (Const Value :Double  );
      Procedure SetETPInvalidity                (Const Value :Double  );
      Procedure SetETPUnusedRDOs                (Const Value :Double  );
      Procedure SetETPDeath                     (Const Value :Double  );
      Procedure SetETPPayInLieu                 (Const Value :Double  );
      Procedure SetETPGoldenHandshake           (Const Value :Double  );
      Procedure SetETPJobLossComp               (Const Value :Double  );
      Procedure SetETPUnusedSick                (Const Value :Double  );
      Procedure SetETPOther                     (Const Value :Double  );
      Procedure SetETPTotal                     (Const Value :Double  );
      Procedure SetETPRollover                  (Const Value :Double  );

      Procedure SetAnnualLeavePre18081993       (Const Value :Double  );
      Procedure SetAnnualLeavePost17081993      (Const Value :Double  );
      Procedure SetAnnLeaveLoadingPre18081993   (Const Value :Double  );
      Procedure SetAnnLeaveLoadingPost17081993  (Const Value :Double  );

      Procedure SetOtherPaymentType             (Const Value :String  );
      Procedure SetOtherPaymentAmount           (Const Value :Double  );

      Procedure SetGross                        (Const Value :Double  );
      Procedure SetPayGross                     (Const Value :Double  );
      Procedure SetTax                          (Const Value :Double  );
      Procedure SetNet                          (Const Value :Double  );
      Procedure SetTotalLumpSums                (Const Value :Double  );
      Procedure SetPayID                        (Const Value :Integer   );

      function GetGrossTaxablePerWeek: double;
      function GetOpenningHours(LeaveType:string):double;
    function GetComplete: boolean;
    procedure SetComplete(const Value: boolean);
    function GetData: string;
    procedure SetData(const Value: string);

   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      property Data: string read GetData write SetData;

   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             overload;override;
      Constructor Create(AOwner: TComponent;PassedConnection:TERPConnection); reintroduce;overload;
      Destructor   Destroy;                                                override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     ValidateDetails :Boolean ;
      Function     Save :Boolean ;                                         Override;
     // Function     PreparePay:integer ;
      procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;
      Procedure CalcLongService;
      Procedure CalcOwedAnnual;
      procedure CalcETPs;
      procedure TerminateEmployee;
      procedure LoadTerminationToPay;
      Procedure DoFinalCalcs;

   Published
      Property Employeeid                    :Integer      Read getEmployeeid                 Write SetEmployeeid             ;
      Property Employeename                  :String       Read getEmployeename               Write SetEmployeename           ;
      Property Startdate                     :TDatetime    Read getStartdate                  Write SetStartdate              ;
      Property Enddate                       :TDatetime    Read getEnddate                    Write SetEnddate                ;
      Property Daysservicepre01071983        :Integer      Read getDaysservicepre01071983     Write SetDaysservicepre01071983 ;
      Property Daysservicepost30061983       :Integer      Read getDaysservicepost30061983    Write SetDaysservicepost30061983;
      Property Etppre071983                  :Double       Read getEtppre071983               Write SetEtppre071983           ;
      Property Etppost061983untaxed          :Double       Read getEtppost061983untaxed       Write SetEtppost061983untaxed   ;
      Property Etptaxfree                    :Double       Read getEtptaxfree                 Write SetEtptaxfree     ;
      Property Etppost061994component        :Double       Read getEtppost061994component     Write SetEtppost061994component ;
      Property Grosstermination              :Double       Read getGrosstermination           Write SetGrosstermination       ;
      Property Taxwithheld                   :Double       Read getTaxwithheld                Write SetTaxwithheld            ;
      Property Etpassessable                 :Double       Read getEtpassessable              Write SetEtpassessable          ;
      Property Deathbenefit                  :Boolean      Read getDeathbenefit               Write SetDeathbenefit           ;
      Property Typeofdeathbenefit            :String       Read getTypeofdeathbenefit         Write SetTypeofdeathbenefit     ;
      Property Lumpsuma                      :Double       Read getLumpsuma                   Write SetLumpsuma               ;
      Property Lumpsumb                      :Double       Read getLumpsumb                   Write SetLumpsumb               ;
      Property Lumpsumc                      :Double       Read getLumpsumc                   Write SetLumpsumc               ;
      Property Lumpsumd                      :Double       Read getLumpsumd                   Write SetLumpsumd               ;
      Property Lumpsume                      :Double       Read getLumpsume                   Write SetLumpsume               ;
      Property Reasonleft                    :String       Read getReasonleft                 Write SetReasonleft             ;
      Property Grossetp                      :Double       Read getGrossetp                   Write SetGrossetp               ;
      Property Cdep                          :Double       Read getCdep                       Write SetCdep                   ;
      Property Reportablefb                  :Double       Read getReportablefb               Write SetReportablefb           ;
      Property Totalallowances               :Double       Read getTotalallowances            Write SetTotalallowances        ;
      Property IsETPEntitled                 :Boolean      Read GetETPEntitled                Write SetETPEntitled;
      Property DeathBeneficiaryHasTFN        :Boolean      Read GetDeathTFN                   Write SetDeathTFN;
      Property IsPayEntitled                 :Boolean      Read GetPayEntitled                Write SetPayEntitled            ;
      Property IsManualLongService           :Boolean      Read GetManualLongService          Write SetManualLongService      ;
      Property IsManualAnnualLeave           :Boolean      Read GetManualAnnualLeave          Write SetManualAnnualLeave      ;
      Property LongServicePre16081978        :Double       Read getLongServicePre16081978     Write SetLongServicePre16081978 ;
      Property LongServicePost16081978       :Double       Read getLongServicePost16081978    Write SetLongServicePost16081978;
      Property LongServicePost17081993       :Double       Read getLongServicePost17081993    Write SetLongServicePost17081993;

      Property AnnualLeavePre18081993        :Double       Read getAnnualLeavePre18081993     Write SetAnnualLeavePre18081993;
      Property AnnualLeavePost17081993       :Double       Read getAnnualLeavePost17081993    Write SetAnnualLeavePost17081993;
      Property AnnLeaveLoadingPre18081993    :Double       Read getAnnLeaveLoadingPre18081993 Write SetAnnLeaveLoadingPre18081993;
      Property AnnLeaveLoadingPost17081993   :Double       Read getAnnLeaveLoadingPost17081993 Write SetAnnLeaveLoadingPost17081993;

      Property OtherPaymentType              :String       Read getOtherPaymentType           Write SetOtherPaymentType;
      Property OtherPaymentAmount            :Double       Read getOtherPaymentAmount         Write SetOtherPaymentAmount;

      Property ETPEarlyRetirement            :Double       Read getETPEarlyRetirement         Write SetETPEarlyRetirement;
      Property ETPRedundancy                 :Double       Read getETPRedundancy              Write SetETPRedundancy;
      Property ETPInvalidity                 :Double       Read getETPInvalidity              Write SetETPInvalidity;
      Property ETPUnusedRDOs                 :Double       Read getETPUnusedRDOs              Write SetETPUnusedRDOs;
      Property ETPDeath                      :Double       Read getETPDeath                   Write SetETPDeath;
      Property ETPPayInLieu                  :Double       Read getETPPayInLieu               Write SetETPPayInLieu ;
      Property ETPGoldenHandshake            :Double       Read getETPGoldenHandshake         Write SetETPGoldenHandshake;
      Property ETPJobLossComp                :Double       Read getETPJobLossComp             Write SetETPJobLossComp;
      Property ETPUnusedSick                 :Double       Read getETPUnusedSick              Write SetETPUnusedSick ;
      Property ETPOther                      :Double       Read getETPOther                   Write SetETPOther ;
      Property ETPTotal                      :Double       Read getETPTotal                   Write SetETPTotal ;
      Property ETPRollover                   :Double       Read getETPRollover                Write SetETPRollover ;

      Property Gross                         :Double       Read getGross                      Write SetGross;
      Property PayGross                      :Double       Read getPayGross                   Write SetPayGross;
      Property Tax                           :Double       Read getTax                        Write SetTax;
      Property Net                           :Double       Read getNet                        Write SetNet;
      Property TotalLumpSums                 :Double       Read getTotalLumpSums              Write SetTotalLumpSums;
      Property PayID                         :Integer      Read getPayID                      Write SetPayID;
      Property Deleted                       :Boolean      Read getDeleted                    Write SetDeleted;

      Property Pay                           :Tpaybase     read fPayObj  write fPayObj;
      Property DoDelete                      :Boolean      read fDoDelete write fDoDelete;
      Property AddToEFT                      :Boolean      read fAddToEFT write fAddToEFT;
      property Complete: boolean read GetComplete write SetComplete;
      procedure AddDoneStep(aStepName: string);
      function StepsDone(aStepNameList: string): boolean;
      property TerminationLoadedToPay: boolean read fTerminationLoadedToPay write fTerminationLoadedToPay;
   End;

implementation


uses CommonLib,FastFuncs,BusObjConst,DateUtils,BusObjPayUtils,AppEnvironment,
  SysUtils, BusObjLeaveAccruals,PayCommon, BusObjEmployeeLeave,DnMLib,Dialogs,Controls,
  PayPreferencesObj, tcDataUtils;


{========================================================
         Temployeeterminations
========================================================}
constructor Temployeeterminations.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fTerminationLoadedToPay:= false;
end;

constructor Temployeeterminations.Create(AOwner: TComponent;PassedConnection:TERPConnection);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblemployeeterminations';
   Connection  := TMyDacDataConnection.Create(Self);
   TMyDacDataConnection(Connection).MydacConnection  := PassedConnection;
   fMyConnection := PassedConnection;
end;

procedure  Temployeeterminations.Load(Const aId: integer;const fIsReadonly:boolean =False);
var
  PayUtils:TPayUtils;
  strsql  :String;
  FatalStatusItem: TResultStatusItem;
begin
  inherited Load(aid,fIsReadonly);

   strsql := 'SELECT PayID,EmployeeID,Paid,Deleted FROM tblPays WHERE EmployeeID = ' +
      IntToStr(EmployeeID)+' AND Paid = "F"  AND Deleted = "F";';

  if Self.PayID = 0 then begin    //either get existing unproccessed pay or create one
    if Employeeid <> 0 then begin
      PayUtils := TPayUtils.Create(nil,TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection ));
      try
        if GetUnprocessedPayID(Employeeid) = 0 then
          PayUtils.CreateNewPay(Employeeid,False,True, FatalStatusItem,Self.Enddate);
      finally
        PayUtils.Free;;
      end;
    end;
    With GetNewDataSet(strsql, True) do try
      Self.PayID := fieldByname('PayID').asInteger;
    finally
      if active then close;
      Free;
    end;
  end;
  fPayObj := Tpaybase.Create(Self,Self.PayID,fMyConnection) ;
  if Self.Employeeid <> 0 then begin
    fPayObj.Load(Self.PayID);
    fPayObj.IsTermination := True;
    fPayObj.RecalcAll;
  end;
end;

procedure Temployeeterminations.LoadTerminationToPay;
begin  {handles leave payouts}
  if fTerminationLoadedToPay then exit;
  fTerminationLoadedToPay := True;
  if Self.IsPayEntitled then begin
//    Self.Pay.Gross := Self.Gross; //includes lumps and ETPs

    //payout accrued annual leave
//    if (AnnualLeavePre18081993 + AnnualLeavePost17081993 + AnnLeaveLoadingPre18081993 + AnnLeaveLoadingPost17081993) > 0 then begin
    if IsManualAnnualLeave then begin
      Self.Pay.PaysPayRates.New;
      Self.Pay.PaysPayRates.Payrateid := 1; //annual leave
      Self.Pay.PaysPayRates.Classid   :=  GetDeptID(Self.Pay.EmployeeDetails.Defaultclassname);
      Self.Pay.PaysPayRates.DepartmentName := Self.Pay.EmployeeDetails.Defaultclassname;
      Self.Pay.PaysPayRates.Qty       := DivZer((AnnualLeavePre18081993 + AnnualLeavePost17081993 + AnnLeaveLoadingPre18081993 + AnnLeaveLoadingPost17081993),fdLeaveHourlyRate);
      Self.Pay.PaysPayRates.Amount    := fdLeaveHourlyRate;
      Self.Pay.PaysPayRates.Linetotal := AnnualLeavePre18081993 + AnnualLeavePost17081993 + AnnLeaveLoadingPre18081993 + AnnLeaveLoadingPost17081993;
      Self.Pay.PaysPayRates.Typeid    := GetPayRateTypeID('Hourly Rate');
      
            //Set annual accrual to zero
      Self.Pay.EmployeeLeave.Dataset.Locate('Type','Annual Leave',[loCaseInsensitive]);
      Self.Pay.EmployeeLeave.Accruedhours := 0;
      Self.Pay.EmployeeLeave.Accruehours := 0;
      Self.Pay.EmployeeLeave.PostDb;
    end else begin
      Self.Pay.PaysPayRates.New;
      Self.Pay.PaysPayRates.Payrateid := 1; //annual leave
      Self.Pay.PaysPayRates.Classid   :=  GetDeptID(Self.Pay.EmployeeDetails.Defaultclassname);
      Self.Pay.PaysPayRates.DepartmentName := Self.Pay.EmployeeDetails.Defaultclassname;
      Self.Pay.PaysPayRates.Qty       := fdAccruedAnnualLeaveHours;
      Self.Pay.PaysPayRates.Amount    := fdLeaveHourlyRate;
      Self.Pay.PaysPayRates.Linetotal := fdLeaveHourlyRate * fdAccruedAnnualLeaveHours;
      Self.Pay.PaysPayRates.Typeid    := GetPayRateTypeID('Hourly Rate');
    end;
    //Set annual accrual to zero
//    Self.Pay.EmployeeLeave.Dataset.Locate('Type','Annual Leave',[loCaseInsensitive]);
//    Self.Pay.EmployeeLeave.Accruedhours := 0;
//    Self.Pay.EmployeeLeave.Accruehours := 0;
//    Self.Pay.EmployeeLeave.PostDb;
    Self.Pay.PaysPayRates.PostDb;  //ReCalc cause normaly annual leave paid out here
    Self.Pay.PaysPayRates.RemoveZeroTotalEntries;
    Self.Pay.RecalcAll;
    DoFinalCalcs;

    Self.Pay.Manualtax:= true;
    Self.Pay.Gross := Self.Gross; //includes lumps and ETPs
    Self.Pay.Tax   := Self.Tax;
    Self.Pay.Net   := Self.Net;
    Self.Pay.Lumpa := Self.Lumpsuma;
    Self.Pay.Lumpb := Self.Lumpsumb;
    Self.Pay.Lumpd := Self.Lumpsumd;
    Self.Pay.Lumpe := Self.Lumpsume;
    Self.Pay.Etp   := Self.ETPTotal;

    Self.Pay.PostDb;
    Self.Pay.PaysPayRates.PostDb;

  end;
end;

procedure Temployeeterminations.TerminateEmployee;
var
  PayUtils:TPayUtils;
  iTmpPayID:integer;
  qry: TERPQuery;
  bShowLongService,bShowSick:Boolean;
begin
  if Self.IsPayEntitled then begin
    PayUtils := TPayUtils.Create(nil,TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection ));
    bShowLongService := AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip;
    bShowSick := AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip;
    try
      LoadTerminationToPay;
      AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip := False;
      AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip := False;
      PayUtils.ProcessPay(Self.Pay,Now,AddToEFT,AppEnv.Employee.ShowPreview);
    finally
      PayUtils.Free;
      AppEnv.PayPrefs.ShowAccruedLongServiceLeavePaySlip := bShowLongService;
      AppEnv.PayPrefs.ShowAccruedSickLeavePaySlip := bShowSick;
    end;
  end;

  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := TERPConnection(TMyDacDataConnection(Self.Connection).MyDacConnection );
    qry.SQL.Add('SELECT EmployeeID,PayID FROM tblPays WHERE EmployeeID=' + QuotedStr(IntToStr(Self.Employeeid)) + ' AND PAID <> "T"');
    qry.Open;
    if qry.RecordCount > 0 then begin
      iTmpPayID := qry.FieldByName('PayID').Asinteger;
      Self.Pay.Load(iTmpPayID);
      Self.Pay.Delete;
    end;
  finally
    FreeAndNil(qry);
  end;

  Self.Pay.EmployeeDetails.Active       := False;
  Self.Pay.EmployeeDetails.Datefinished := self.Enddate;
  Self.Pay.EmployeeDetails.Isterminated := True;
  Self.Pay.EmployeeDetails.PostDb;
end;

procedure Temployeeterminations.CalcETPs;
var
  iYearsOfService: integer;
  iDaysToRetirement: integer;
  dTaxFreeRedundancyLimit:double;
  //dETPpreJul1983RollOver:double;
  //dETPpostJun1983RollOver: double;
  wYear, wMonth, wDay: word;
  dtTestDate,fdtEndOfFY: TDateTime;

begin
  { Definitions   Untaxed meaning tax has to be paid
                  Taxed meaning tax has already been paid ; this can ONLY be on superannuation
                  so is not used anywhere in terminations.

                  Note: Pre July1983 is only 5% assessable and no tax needs to be deducted from this component.
                        PostJuly1988 we only deal with the Untaxed component
                        PostAugust1993 fully taxable - shown as part of Gross earnings on Group Certificate
                           treat as a bonus(execption with Bona fide redundancy,invalidity or approved early retirement).
  }
//  if not Self.IsETPEntitled then exit;
  if fMainCalculationsInProgress then exit;    
  fMainCalculationsInProgress := True;
  Try
    iYearsOfService := YearsBetween(Self.Enddate, Self.Startdate);

    dtTestDate := EncodeDate(1983, 7, 1);
    if Self.Startdate < dtTestDate then begin
      Self.Daysservicepre01071983 := DaysBetween(Self.Startdate, dtTestDate) - 1;
    end else begin
      Self.Daysservicepre01071983 := 0;
    end;

    dtTestDate := EncodeDate(1983, 6, 30);
    fdtEndOfFY  := GetCurrentFiscalYearStart(Self.EndDate);
    DecodeDate(fdtEndOfFY, wYear, wMonth, wDay);
    if Self.Startdate < dtTestDate then begin
      Self.Daysservicepost30061983 := DaysBetween(dtTestDate, Self.Enddate) - 1;
    end else begin
      Self.Daysservicepost30061983 := DaysBetween(Self.Startdate, Self.Enddate) - 1;
    end;

    if (Self.Reasonleft = 'Redundancy') or (Self.Reasonleft = 'Early Retirement') then begin
      if iYearsOfService > 25 then begin
        iYearsOfService := 25;
      end;
      dTaxFreeRedundancyLimit := 6194 + (iYearsOfService * 3097);     //needs hard coding removed
      if Self.ETPTotal < dTaxFreeRedundancyLimit then begin
        Self.Lumpsumd := Self.ETPTotal;
      end else begin
        Self.Lumpsumd := dTaxFreeRedundancyLimit;
      end;

      //dtTestDate := EncodeDate(1983, 7, 1);
//      if Self.Startdate < dtTestDate then begin
//        Self.Daysservicepre01071983 := DaysBetween(Self.Startdate, dtTestDate) - 1;
//      end else begin
//        Self.Daysservicepre01071983 := 0;
//      end;
//
//      dtTestDate := EncodeDate(1983, 6, 30);
//      fdtEndOfFY  := GetCurrentFiscalYearStart(Self.EndDate);
//      DecodeDate(fdtEndOfFY, wYear, wMonth, wDay);
//      if Self.Startdate < dtTestDate then begin
//        Self.Daysservicepost30061983 := DaysBetween(dtTestDate, Self.Enddate) - 1;
//      end else begin
//        Self.Daysservicepost30061983 := DaysBetween(Self.Startdate, Self.Enddate) - 1;
//      end;

      Self.Etppre071983 := 0;
      Self.Etppost061983untaxed := 0;

      if Self.ETPTotal > Self.Lumpsumd then begin
        Self.Etppre071983 := (RoundCurrency(Divzer(Self.Daysservicepre01071983, (Self.Daysservicepre01071983 + Self.Daysservicepost30061983) * (Self.ETPTotal - Self.Lumpsumd - Self.ETPRollover))));
        fdTaxFreeETPAmt := RoundCurrency(Self.ETPTotal - Self.Lumpsumd - Self.ETPRollover - Self.Etppre071983);

      end;
      fdAssesableETP := Self.ETPTotal - Self.Lumpsumd - Self.ETPRollover - (Self.Etppre071983 * 0.95);
      fdTaxableETPAmt := Self.ETPTotal - Self.Lumpsumd - Self.ETPRollover - Self.Etppre071983;
    end else if Self.Reasonleft = 'Invalidity' then begin
      iDaysToRetirement := GetDaysToRetirement(Self.Employeeid, Self.Enddate);
      Self.Etppost061994component := RoundCurrency(divzer((Self.ETPTotal * iDaysToRetirement), (Self.Daysservicepre01071983 + Self.Daysservicepost30061983 + iDaysToRetirement)));
      Self.Etppre071983 := (RoundCurrency(Divzer(Self.Daysservicepre01071983, (Self.Daysservicepre01071983 + Self.Daysservicepost30061983)) * Self.ETPTotal));
      fdTaxFreeETPAmt := RoundCurrency(Self.ETPTotal - Self.Etppost061994component);
      fdAssesableETP := Self.ETPTotal - Self.Etppost061994component;
      fdTaxableETPAmt := fdAssesableETP;
    end else begin
      Self.Etppre071983 := (RoundCurrency(Divzer(Self.Daysservicepre01071983, (Self.Daysservicepre01071983 + Self.Daysservicepost30061983)) * Self.ETPTotal));
      Self.Etppost061983untaxed := Self.ETPTotal - Self.Etppre071983;

      fdTaxFreeETPAmt := RoundCurrency(Self.Etppre071983 * 0.95);
      fdAssesableETP := Self.ETPTotal - Self.Lumpsumd - Self.ETPRollover - (Self.Etppre071983 * 0.95);
      fdTaxableETPAmt := Self.ETPTotal - Self.Lumpsumd - Self.ETPRollover - Self.Etppre071983;
    end;
  //  dETPpreJul1983RollOver  := (RoundCurrency(Divzer(Self.Daysservicepre01071983, (Self.Daysservicepre01071983 + Self.Daysservicepost30061983)) * Self.ETPRollover));
 //   dETPpostJun1983RollOver := RoundCurrency(Self.ETPRollover - dETPpreJul1983RollOver);


     // bSetSummaryActive := empTermination.SetSummary(cboReasons.Text, cboPayType.Text, bPayEmployee,
  //      chkTFN.Checked, cboDeathPaidTo.Text);

   // if fdTaxableETPAmt > AppEnv.CompanyPrefs.RBLThreshold then    REASONABLE BENEFIT LIMIT ABOLISHED 1 JULY 2007
//    CommonLib.MessageDlgXP_Vista('PLEASE NOTE : This ETP Payment exceeds the limit of '
//         + FloatToStrF(AppEnv.CompanyPrefs.RBLThreshold,ffCurrency, 15, CurrencyRoundPlaces)
//         + ' This payment will have to be reported to the ATO for Reasonable Benefit Limit (RBL) Purposes.', mtInformation, [mbOK], 0);

    DoFinalCalcs;
  finally
    fMainCalculationsInProgress := False;
  end;
end;

function Temployeeterminations.GetGrossTaxablePerWeek: double;
begin
  if Trim(Self.Pay.EmployeePaySettings.PayPeriod) = 'Weekly' then begin
    Result := Self.Pay.PayTotals.GrossTaxable;
  end else if Trim(Self.Pay.EmployeePaySettings.PayPeriod) = 'Fortnightly' then begin
    Result := Self.Pay.PayTotals.GrossTaxable / 2;
  end else if Trim(Self.Pay.EmployeePaySettings.PayPeriod) = 'Bi-Monthly' then begin
    Result := Self.Pay.PayTotals.GrossTaxable / 2.667;
  end else if Trim(Self.Pay.EmployeePaySettings.PayPeriod) = 'Monthly' then begin
    Result := Self.Pay.PayTotals.GrossTaxable / 4.33333;
  end else begin
    Result := 0;
  end;
end;

procedure Temployeeterminations.DoFinalCalcs;
var
  iEmpAge: integer;
  tmpTax, tmpWageTax, dWagePerWeek, dWeeklyWageAverageYTD: double;
  dWageGross,dNonWageGross, dWageTax,dAccruedAnnualLongService,
  //dWageNet,
  dTotalLeaveLoading:double;
  dLumpBMargin,dNonETPTax,dETPtaxWitheld,dLumpETax,dGrossTax:double;
begin
  //if this is an existing termination and if the related pay has been processed issue a warning
  if Tpaybase(Self.Pay).Paid then
    case CommonLib.MessageDlgXP_Vista('The pay associated with this termination has already been processed. Continue?',mtConfirmation,[mbYes,mbNo],0) of
    mrYes: begin

    end;
    mrNo: begin
      exit;
    end;
  end;
  dLumpETax := 0;
  dGrossTax := 0;
  dNonWageGross := 0;
  dAccruedAnnualLongService := 0;
  try

    dWagePerWeek := GetGrossTaxablePerWeek;
    if not Self.IsPayEntitled = true then begin
      dWageGross := 0;
      dWageTax := 0;
    end else begin
      dWageGross :=  Self.Pay.PayTotals.GrossTaxable; // Self.Pay.PaysPayRates.Total;
      dWageTax := GetTaxComponent(Self.Pay.EmployeeDetails.Taxscaleid, RoundCurrency(dWagePerWeek),
        Trim(Self.Pay.EmployeePaySettings.Payperiod),False);
      //dWageNet := dWageGross - dWageTax;
    end;

    Self.PayGross := dWageGross; //this is simply to show the Wage component and is only to make it clear for the client

    // Did the employee leave due to a Redundancy, Invalidity or Early Retirement?
    if ((Self.Reasonleft = 'Redundancy') or (Self.Reasonleft = 'Invalidity') or (Self.Reasonleft = 'Early Retirement')) then begin
      // Yes, Calculate Lump Sums as so.
      dTotalLeaveLoading :=  Self.AnnLeaveLoadingPost17081993 + Self.AnnLeaveLoadingPre18081993;
      // Deduct Leave Load Threshold if applicable before applying tax.
      if dTotalLeaveLoading > AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then begin
        if Self.AnnualLeavePre18081993 > AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then begin
          Self.AnnualLeavePre18081993 := RoundCurrency(Self.AnnualLeavePre18081993 - AppEnv.CompanyPrefs.LeaveLoadTaxThreshold);
        end;
      end;
      // Lump Sum A
      Self.Lumpsuma := (Self.AnnualLeavePre18081993 + Self.AnnLeaveLoadingPre18081993) + (Self.AnnualLeavePost17081993 + Self.AnnLeaveLoadingPost17081993) +
        Self.LongServicePost16081978 + Self.LongServicePost17081993;

      // Lump Sum B
      Self.Lumpsumb := Self.LongServicePre16081978;

      // Lump Sum C
      Self.Lumpsumc := Self.Etppre071983 + Self.Etppost061983Untaxed +  + Self.Etppost061994component;

      // Lump Sum D
      if Self.Reasonleft = 'Invalidity' then begin
        Self.Etppost061983untaxed := (Self.Etppre071983 * 0.95) + Self.Etppost061994component;
      end;
     // Self.Gross := Self.Lumpsuma + Self.Lumpsumb + Self.Lumpsumd + Self.Lumpsume;
      dNonWageGross := Self.Lumpsuma + Self.Lumpsumb + Self.Lumpsumd + Self.Lumpsume;
    end else begin
      // Calculate Total Leave Loading
      dTotalLeaveLoading := Self.AnnLeaveLoadingPre18081993 + Self.AnnLeaveLoadingPost17081993;

      // Deduct Leave Load Threshold if applicable before applying tax.
      if dTotalLeaveLoading > AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then
        Self.AnnLeaveLoadingPost17081993 := RoundCurrency(Self.AnnLeaveLoadingPost17081993 - AppEnv.CompanyPrefs.LeaveLoadTaxThreshold);

      // Lump Sum A
      Self.Lumpsuma := Self.LongServicePost16081978 + Self.AnnualLeavePre18081993 + Self.AnnLeaveLoadingPre18081993;

      // Lump Sum B
      Self.Lumpsumb := Self.LongServicePre16081978;

      // Lump Sum C
      Self.Lumpsumc := Self.Etppre071983 + Self.Etppost061983untaxed + Self.Etppost061994component;

      // Lump Sum D
      if Self.Reasonleft <> 'Death' then begin
       // fdTaxFreeETPAmt  := (Self.Etppre071983 * 0.05);
        Self.Lumpsumd := 0;
      end else begin
        Self.Lumpsumd := Self.Etppre071983;
      end;
      dAccruedAnnualLongService := Self.LongServicePost17081993 + Self.AnnLeaveLoadingPost17081993 + Self.AnnLeaveLoadingPost17081993
                       + Self.ETPTotal +Self.AnnualLeavePost17081993 ;
      //Self.Gross := Self.LongServicePost17081993 + Self.AnnLeaveLoadingPost17081993 + Self.AnnLeaveLoadingPost17081993
//                       + Self.ETPTotal  ;
  //    fdSummaryGross := fdLongPost17Aug93 + fdAnnualPost17Aug93 + fdLoadingPost17Aug93;
    end;

    ///////////////////////
    // Calculate Totals.
    ///////////////////////
    // Calculate Taxable Amount from LumpSumB. Only 5% of amount is taxable.
    dLumpBMargin := Self.Lumpsumb * (5 / 100);

    // Lump Sum A & B Tax @ 30 + Medicare Levy Rate.
    if not Empty(Self.Pay.EmployeeDetails.Tfn) then begin
      dNonETPTax := (Self.Lumpsuma + dLumpBMargin) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
    end else begin
      dNonETPTax := (Self.Lumpsuma + dLumpBMargin) * ((AppEnv.CompanyPrefs.NoTFNTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
    end;
    // ETP Tax
    if Self.Reasonleft <> 'Death' then begin
      iEmpAge := GetEmployeeAge(Self.Pay.EmployeeDetails.Dob, Self.Enddate);
      //  dPreJuly1983Margin :=RemoveCents(fdETPpreJul1983 * (5 / 100) );

      if not Empty(Self.Pay.EmployeeDetails.Tfn) then begin
        if iEmpAge > 54 then begin
          if Self.Etppost061983Untaxed < AppEnv.CompanyPrefs.YearlyIncomeThreshold then begin
            dETPtaxWitheld := RemoveCents((Self.Etppost061983Untaxed) *
            ((AppEnv.CompanyPrefs.LumpSumTaxRateOver55 + AppEnv.CompanyPrefs.MedicareLevyRate) / 100));

          end else begin          //if above Low Rate Threshold
            dETPtaxWitheld := (RemoveCents((AppEnv.CompanyPrefs.YearlyIncomeThreshold) *
            ((AppEnv.CompanyPrefs.LumpSumTaxRateOver55 + AppEnv.CompanyPrefs.MedicareLevyRate) / 100)) )

            +  ((Self.Etppost061983Untaxed -  AppEnv.CompanyPrefs.YearlyIncomeThreshold )*
            ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100))  ;
          end;

        end else begin
          dETPtaxWitheld := RemoveCents((Self.Etppost061983Untaxed) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100));
        end;
      end else begin
        // Calculate on No TFN Tax Rate
        dETPtaxWitheld := RemoveCents((Self.Etppost061983Untaxed) * ((AppEnv.CompanyPrefs.NoTFNTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100));
      end;

      // Get total of Lump Sums
      Self.TotalLumpSums := Self.Lumpsuma + Self.Lumpsumb + Self.Lumpsumc + Self.Lumpsumd + Self.Lumpsume;

      // Calculate Lump Sum E Tax if applicable.
       {payments in arrears that were =< $400 which accrued more than 12 months prior do date of payment}
      if Self.OtherPaymentType = 'Back Payment of Salary or Wages' then begin
        dLumpETax := (Self.Lumpsume) * ((AppEnv.CompanyPrefs.LumpSumETaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end else if Self.OtherPaymentType = 'Return to Work Payment' then begin
        dLumpETax := (Self.Lumpsume) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end;

      // Calculate Overall Tax Balance.

      if Self.IsPayEntitled then begin
        if dAccruedAnnualLongService > 0 then begin
          //Accrued Annual leave and Long service treated like a bonus spread over a year
          dWeeklyWageAverageYTD := divzer(Self.Pay.PayTotals.YTDWages, WeeksBetweenSigned(Self.Enddate, StartOfTheFY(Self.Enddate)));

          tmpTax := PayCommon.GetTaxComponent(Self.Pay.EmployeeDetails.Taxscaleid,
                      ((dAccruedAnnualLongService / 52) + dWeeklyWageAverageYTD), Trim(Self.Pay.EmployeePaySettings.Payperiod),False);
           // ((Self.Gross / 52) + dWeeklyWageAverageYTD), Trim(Self.Pay.EmployeePaySettings.Payperiod),False);

          tmpWageTax := GetTaxComponent(Self.Pay.EmployeeDetails.Taxscaleid,
            RoundCurrency(dWeeklyWageAverageYTD), Trim(Self.Pay.EmployeePaySettings.PayPeriod),False);

          dGrossTax := (tmpTax - tmpWageTax) * 52;
        end;

        // Add the Wage gross onto the final gross.
        Self.Gross := dNonWageGross + dWageGross + dAccruedAnnualLongService;
        Self.Tax := dNonETPTax + dGrossTax + dETPtaxWitheld + Self.Lumpsume + dWageTax;
      end else begin
        Self.Tax := dNonETPTax + dGrossTax + dETPtaxWitheld + dLumpETax;
      end;
      //fdSummaryGross := fdSummaryGross + fdWageGross + fdGrossETP;
    end else begin     //DEATH
      if (Self.Typeofdeathbenefit = 'Non Dependant') and (Self.DeathBeneficiaryHasTFN) then begin
        dETPtaxWitheld := Self.Etppost061983Untaxed * (0.3 + AppEnv.CompanyPrefs.MedicareLevyRate);
      end else if (Self.Typeofdeathbenefit = 'Non Dependant') and (Self.DeathBeneficiaryHasTFN = false) then begin
        dETPtaxWitheld := Self.Etppost061983Untaxed * 0.485;
      end else begin
        dETPtaxWitheld := 0;
      end;
      // Save ETP Assessable Amount.
       fdAssesableETP := RemoveCents(Self.Etppost061983Untaxed);
      // Get total of Lump Sums
      Self.TotalLumpSums := Self.Lumpsuma + Self.Lumpsumb + Self.Lumpsumc + Self.Lumpsumd + Self.Lumpsume;

      if Self.OtherPaymentType = 'Back Payment of Salary or Wages' then begin
        dLumpETax := (Self.Lumpsume) * ((AppEnv.CompanyPrefs.LumpSumETaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end else if Self.OtherPaymentType = 'Return to Work Payment' then begin
        dLumpETax := (Self.Lumpsume) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end;

      dGrossTax := Self.Pay.PayTotals.Tax;

      // Calculate Overall Tax Balance.

      if Self.IsPayEntitled then begin
        // Add the Wage gross onto the final gross.  Since we have now
        // taxed the gross we can now add the wage gross
        Self.Gross := dNonWageGross + dWageGross + dAccruedAnnualLongService;
    //    fdSummaryGross := fdSummaryGross + fdWageGross + fdLumpSums;
        Self.Tax := dNonETPTax + dWageTax + dGrossTax + dETPtaxWitheld + dLumpETax;
      end else begin
        Self.Tax := dNonETPTax + dGrossTax + dETPtaxWitheld + dLumpETax;
      //  fdSummaryGross := fdSummaryGross + dLumpSums;
      end;
    end;
    Self.Tax          := RemoveCents(Self.Tax);
    Self.Net          := RemoveCents(Self.Gross - Self.Tax);
    Self.Lumpsuma     := RemoveCents(Self.Lumpsuma);
    Self.Lumpsumb     := RemoveCents(Self.Lumpsumb);
    Self.Lumpsumc     := RemoveCents(Self.Lumpsumc);
    Self.Lumpsumd     := RemoveCents(Self.Lumpsumd);
    Self.Lumpsume     := RemoveCents(Self.Lumpsume);
    Self.TotalLumpSums := RemoveCents(Self.TotalLumpSums);
    Self.Etptaxfree :=  fdTaxFreeETPAmt;
  finally

  end;
end;

destructor Temployeeterminations.Destroy;
begin
   inherited;
end;

class function Temployeeterminations.GetBusObjectTablename: string;
begin
  Result := 'tblemployeeterminations';
end;

function Temployeeterminations.GetOpenningHours(LeaveType:string):double;
begin
 if Self.Pay.EmployeeLeave.Dataset.Locate('Type',LeaveType,[]) then
   Result := Self.Pay.EmployeeLeave.Openningbalancehrs
 else Result := 0;
end;

procedure Temployeeterminations.CalcOwedAnnual;
var
  TestDate, dtLeaveGoesBackTo,tmpStart,tmpEnd: TDateTime;
  dLeaveLoadRate:double;   //,dLastPayAL: double;
  iDaysTotal, dNumOfAccumPeriods, dDaysInAccumPeriod: double;
 // dAccruedAnnualLeaveHours,
  dDaysBack :double;
  //dLeaveHourlyRate: double;
  wYear, wMonth, wDay: word;
  sPayPeriod: string;
  iDaysToNow:integer;
begin
  if fAnnualLeaveCalcInProgress then exit;
  if IsManualAnnualLeave then exit;
  fAnnualLeaveCalcInProgress := True;
  try 
    // Get the Leave Loading Rate for this employee.
    dLeaveLoadRate :=  Self.Pay.EmployeeLeave.GetTypeLeaveLoading('Annual Leave',Self.Employeeid);

    // Get Accrued Annual Leave.
    if Self.IsPayEntitled then begin
      fdAccruedAnnualLeaveHours :=  Self.Pay.LeaveAccruals.GetAccruedHrs('Annual Leave') + Self.Pay.PayLeaves.GetThisPayLeaveHrsEntitlement('Annual Leave') + GetOpenningHours('Annual Leave');
    end else begin
      fdAccruedAnnualLeaveHours :=  Self.Pay.LeaveAccruals.GetAccruedHrs('Annual Leave') + GetOpenningHours('Annual Leave');
    end;

    // create our test date.
    wYear    := 1993;
    wMonth   := 8;
    wDay     := 18;
    TestDate := EncodeDate(wYear, wMonth, wDay);

    /////////////////////////////////////////////////////
    // Now calculate the Outstanding Accrued Annual Leave
    /////////////////////////////////////////////////////
    fdLeaveHourlyRate := Self.Pay.EmployeePayRates.HighestStandardHourlyRate * (1 + dLeaveLoadRate);

    //need to calc how many pay periods have accumalated
    //and see if these go back further than the cut off date
    dDaysInAccumPeriod := 0;
    sPayPeriod         :=  Self.Pay.EmployeePaySettings.Payperiod;
    if sPayPeriod = 'Weekly' then begin
      dDaysInAccumPeriod := 7;
    end else if sPayPeriod = 'Fornightly' then begin
      dDaysInAccumPeriod := 14;
    end else if sPayPeriod = 'Monthly' then begin
      dDaysInAccumPeriod := 30.4375;     //averaged over 4 year span.
    end else if sPayPeriod = 'Bi-Monthly' then begin
      dDaysInAccumPeriod := 30.4375 / 2;
    end;

    Self.Pay.EmployeeLeave.Dataset.Locate('Type','Annual Leave',[loCaseInsensitive]);
    if Self.Pay.EmployeeLeave.Usestartenddates then begin
      if Self.Pay.EmployeeLeave.Startdate > Self.Startdate then tmpStart := Self.Pay.EmployeeLeave.Startdate else tmpStart := Self.Startdate;
      if Self.Pay.EmployeeLeave.Enddate < Self.Enddate then tmpEnd := Self.Pay.EmployeeLeave.Enddate else tmpEnd := Self.Enddate;
      iDaysToNow         := DaysBetween(tmpEnd, tmpStart);
    end else begin
      iDaysToNow         := DaysBetween(Self.Enddate, Self.Startdate);
    end;

    dNumOfAccumPeriods := Divzer(iDaysToNow, dDaysInAccumPeriod);
    dDaysBack          := dDaysInAccumPeriod * dNumOfAccumPeriods;
    dtLeaveGoesBackTo  := Self.Enddate - dDaysBack;

    Self.AnnualLeavePost17081993 := fdLeaveHourlyRate * fdAccruedAnnualLeaveHours;
    //Does the accumulation go back before 18/08/1993
    if dtLeaveGoesBackTo < TestDate then begin
      dDaysBack := DaysBetween(TestDate, dtLeaveGoesBackTo);
      iDaysTotal := DaysBetween(Self.Enddate, dtLeaveGoesBackTo);
      Self.AnnualLeavePre18081993 := RoundCurrency(Divzer(dDaysBack, iDaysTotal) * fdAccruedAnnualLeaveHours * fdLeaveHourlyRate);
      Self.AnnLeaveLoadingPre18081993 := RoundCurrency(Self.AnnualLeavePre18081993 * dLeaveLoadRate);
      Self.AnnualLeavePost17081993 := RoundCurrency((fdAccruedAnnualLeaveHours - Self.AnnualLeavePre18081993) * fdLeaveHourlyRate);
      Self.AnnLeaveLoadingPost17081993 := RoundCurrency(Self.AnnualLeavePost17081993 * dLeaveLoadRate);
    end else begin
      Self.AnnualLeavePre18081993     := 0;
      Self.AnnLeaveLoadingPre18081993 := 0;
      Self.AnnualLeavePost17081993 := RoundCurrency(fdAccruedAnnualLeaveHours * fdLeaveHourlyRate);
      Self.AnnLeaveLoadingPost17081993 := RoundCurrency(fdAccruedAnnualLeaveHours * dLeaveLoadRate);
    end;
  finally
    fAnnualLeaveCalcInProgress := False;
  end;
end;   

Procedure Temployeeterminations.CalcLongService;
var
  DateStarted, TestDate, TestDate2, TestDate3: TDateTime;
  dLongServiceSum: double;
  dAccruedLongServiceHours: double;
  dLeaveTakenUpto, dMyCalculated: double;
  iDaysToNow: integer;
  dDaysInAccumPeriod: double;
  dNumOfAccumPeriods: double;
  wYear, wMonth, wDay: word;
  sPayPeriod: string;
  iWholeSumDays, iTotalDaysC, iTotalDaysD, iDaysTotal: integer;
  dNormalHrs : double;
begin
  if IsManualLongService then exit;
  if fLongServiceCalcInProgress then exit;
  fLongServiceCalcInProgress := True;
  try
    // has employee been working for the required years
      if IncYear(Self.Startdate, 10) > Self.Enddate then Exit;
//    qryNormalHrs.Connection := Self.Connection;//CommonDbLib.GetSharedMyDACConnection;
//    qryNormalHrs.SQL.Clear;
//    qryNormalHrs.SQL.Add('SELECT EmployeeID,Qty FROM tblemployeepayrates  ');
//    qryNormalHrs.SQL.Add('WHERE EmployeeID = ' + IntToStr(EmployeeID) + ' AND TypeID = 1');
//
//    qryNormalHrs.Open;
    dNormalHrs :=  Self.Pay.PaysPayRates.TotalStandardHours;
//
//    qryLeave.Connection := Self.Connection;//CommonDbLib.GetSharedMyDACConnection;
//    qryLeave.SQL.Clear;
//    qryLeave.SQL.Add('SELECT EmployeeID,AccrueHours,Type FROM tblleave  ');
//    qryLeave.SQL.Add('WHERE EmployeeID = ' + IntToStr(EmployeeID) + ' AND Type = "Long Service"');
//
//    qryLeave.Open;
    sPayPeriod := Self.Pay.EmployeePaySettings.Payperiod;
//    // Get the date the employee started working.
    DateStarted        := Self.Pay.EmployeeDetails.Datestarted;
    iDaysToNow         := DaysBetween(Date(), DateStarted);
    dDaysInAccumPeriod := 0;
    if sPayPeriod = 'Weekly' then begin
      dDaysInAccumPeriod := 7;
    end else if sPayPeriod = 'Fornightly' then begin
      dDaysInAccumPeriod := 14;
    end else if sPayPeriod = 'Monthly' then begin
      dDaysInAccumPeriod := 30.4375;     //averaged over 4 year span.
    end else if sPayPeriod = 'Bi-Monthly' then begin
      dDaysInAccumPeriod := 30.4375 / 2;
    end;

    dNumOfAccumPeriods := Divzer(iDaysToNow, dDaysInAccumPeriod);
    // Get Accrued Long Service Hours.
    dAccruedLongServiceHours := dNumOfAccumPeriods *  Self.Pay.LeaveAccruals.GetAccruedHrs('Long Service');

//    // Now create our test date.
    wYear    := 1978;
    wMonth   := 8;
    wDay     := 16;
    TestDate := EncodeDate(wYear, wMonth, wDay);

    wYear     := 1993;
    wMonth    := 8;
    wDay      := 18;
    TestDate2 := EncodeDate(wYear, wMonth, wDay);

    wYear      := 1993;
    wMonth     := 8;
    wDay       := 17;
    TestDate3  := EncodeDate(wYear, wMonth, wDay);
    iDaysTotal := DaysBetween(Date(), DateStarted);

    // Calculate the Lump Sum of Long Service
    dLongServiceSum := Self.Pay.EmployeePayRates.HighestStandardHourlyRate * dAccruedLongServiceHours;

    // Employee Commenced before 16 August 1978
    if DateStarted < TestDate then begin
      // Step #1 - Calculate the Amount which accrued after 15 August 1978
      iTotalDaysC := DaysBetween(Self.Enddate, (TestDate - 1.0));



      dLeaveTakenUpto := Self.Pay.LeaveAccruals.GetLeaveTakenHrs('Long Service', (TestDate - 2.0));

      iTotalDaysD := Trunc(ConvertHoursToWorkingDays(dLeaveTakenUpTo,Self.Pay.EmployeePaySettings.Payperiod,dNormalHrs));
      iWholeSumDays := Trunc(ConvertHoursToWorkingDays(dAccruedLongServiceHours,Self.Pay.EmployeePaySettings.Payperiod,dNormalHrs));
      dMyCalculated := divzer(dLongServiceSum, iWholeSumDays) *
        ((divzer((iTotalDaysC * (iWholeSumDays + iTotalDaysD)), iDaysTotal)) - iTotalDaysD);

      // Step #2
      Self.LongServicePre16081978 := RoundCurrency(dLongServiceSum - dMyCalculated);

      // Step #3 - Now calculate the amount which accrued after 17 August 1993
      iTotalDaysC := DaysBetween(Self.Enddate, (TestDate3 + 1.0));

      dLeaveTakenUpto := Self.Pay.LeaveAccruals.GetLeaveTakenHrs('Long Service', (TestDate3 - 1.0));

      iTotalDaysD := Trunc(ConvertHoursToWorkingDays(dLeaveTakenUpTo,Self.Pay.EmployeePaySettings.Payperiod,dNormalHrs));
      iWholeSumDays := Trunc(ConvertHoursToWorkingDays(dAccruedLongServiceHours,Self.Pay.EmployeePaySettings.Payperiod,dNormalHrs));

      dMyCalculated := divzer(dLongServiceSum, iWholeSumDays) *
        ((divzer((iTotalDaysC * (iWholeSumDays + iTotalDaysD)), iDaysTotal)) - iTotalDaysD);
      //Step #4
      Self.LongServicePost16081978 := RoundCurrency(dLongServiceSum - dMyCalculated);
      Self.LongServicePost17081993 := RoundCurrency(dLongServiceSum - (Self.LongServicePost16081978 + Self.LongServicePre16081978));

      // Employee Commenced after 15 August but before 18 August 1993
    end else if (Self.Startdate > TestDate) and (Self.Startdate < TestDate2) then begin
      // Step #1 - Now calculate the amount which accrued after 17 August 1993
      iTotalDaysC := DaysBetween(Self.Enddate, (TestDate3 + 1.0));

      dLeaveTakenUpto := Self.Pay.LeaveAccruals.GetLeaveTakenHrs('Long Service', (TestDate3 - 1.0));

      iTotalDaysD := Trunc(ConvertHoursToWorkingDays(dLeaveTakenUpTo,Self.Pay.EmployeePaySettings.Payperiod,dNormalHrs));
      iWholeSumDays := Trunc(ConvertHoursToWorkingDays(dAccruedLongServiceHours,Self.Pay.EmployeePaySettings.Payperiod,dNormalHrs));
      try
        dMyCalculated := divzer(dLongServiceSum, iWholeSumDays) *
          ((divzer((iTotalDaysC * (iWholeSumDays + iTotalDaysD)), iDaysTotal)) - iTotalDaysD);

      except
        dMyCalculated := 0;
      end;
      // Step #2 - Calculate Balance.
      Self.LongServicePost16081978 := RoundCurrency(dLongServiceSum - dMyCalculated);
      Self.LongServicePre16081978 := 0;
      Self.LongServicePost17081993 := RoundCurrency(dLongServiceSum - (Self.LongServicePost16081978 + Self.LongServicePre16081978));

      // Accrued After the 17 August 1993
    end else begin
      Self.LongServicePre16081978  := 0;
      Self.LongServicePost16081978 := 0;
      Self.LongServicePost17081993 := RoundCurrency(dLongServiceSum);
    end;
  finally
    fLongServiceCalcInProgress := False;
  end;
end;

//function    Temployeeterminations.PreparePay:integer; //returns PayID of unprocessed pay/created new pay
//begin
// var
//  qry: TERPQuery;
//begin
//  qry := TERPQuery.Create(nil);
//  try
//    qry.connection := Self.Connection;
//    qry.SQL.Clear;
//    qry.SQL.Add('SELECT * FROM tblPays WHERE Paid = ''F'' AND Deleted = ''F'' AND EmployeeID = :xEmpID');
//    qry.Params.ParamByName('xEmpID').asInteger := EmployeeID;
//    qry.Open;
//
//    if qry.RecordCount = 0 then begin
//     // qry.Insert;
////      qry.FieldByName('EmpName').AsString := TempPay.Employee.EmployeeDetails.EmployeeName;
////      qry.FieldByName('EmployeeID').AsInteger := EmployeeID;
////      qry.FieldByName('PayPeriods').AsInteger := 1;
////      qry.FieldByName('PayPeriod').AsString := TempPay.Employee.EmployeeSettings.PayPeriod;
////      qry.FieldByName('Paid').AsString := 'F';
////      qry.Post;
//    end;
//    Result := qry.FieldByName('PayID').AsInteger;
//  finally
//    FreeAndNil(qry);
//  end;
//end;

procedure   Temployeeterminations.LoadFromXMLNode(Const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node,'Employeeid');
  SetPropertyFromNode(Node,'Employeename');
  SetDateTimePropertyFromNode(Node,'Startdate');
  SetDateTimePropertyFromNode(Node,'Enddate');
  SetPropertyFromNode(Node,'Daysservicepre01071983');
  SetPropertyFromNode(Node,'Daysservicepost30061983');
  SetPropertyFromNode(Node,'Etppre071983');
  SetPropertyFromNode(Node,'Etppost061983untaxed');
  SetPropertyFromNode(Node,'Etptaxfree');
  SetPropertyFromNode(Node,'Etppost061994component');
  SetPropertyFromNode(Node,'Grosstermination');
  SetPropertyFromNode(Node,'Taxwithheld');
  SetPropertyFromNode(Node,'Etpassessable');
  SetBooleanPropertyFromNode(Node,'Deathbenefit');
  SetPropertyFromNode(Node,'Typeofdeathbenefit');
  SetPropertyFromNode(Node,'Lumpsuma');
  SetPropertyFromNode(Node,'Lumpsumb');
  SetPropertyFromNode(Node,'Lumpsumc');
  SetPropertyFromNode(Node,'Lumpsumd');
  SetPropertyFromNode(Node,'Lumpsume');
  SetPropertyFromNode(Node,'Reasonleft');
  SetPropertyFromNode(Node,'Grossetp');
  SetPropertyFromNode(Node,'Cdep');
  SetPropertyFromNode(Node,'Reportablefb');
  SetPropertyFromNode(Node,'Totalallowances');
  SetBooleanPropertyFromNode(Node,'IsETPEntitled');
  SetBooleanPropertyFromNode(Node,'Deleted');
  SetBooleanPropertyFromNode(Node,'DeathBeneficiaryHasTFN');
  SetBooleanPropertyFromNode(Node,'IsPayEntitled');
  SetBooleanPropertyFromNode(Node,'IsManualLongService');
  SetBooleanPropertyFromNode(Node,'IsManualAnnualLeave');
  SetPropertyFromNode(Node,'LongServicePre16081978');
  SetPropertyFromNode(Node,'LongServicePost16081978');
  SetPropertyFromNode(Node,'LongServicePost17081993');

  SetPropertyFromNode(Node,'AnnualLeavePre18081993');
  SetPropertyFromNode(Node,'AnnualLeavePost17081993');
  SetPropertyFromNode(Node,'AnnLeaveLoadingPre18081993');
  SetPropertyFromNode(Node,'AnnLeaveLoadingPost17081993');

  SetPropertyFromNode(Node,'OtherPaymentType');
  SetPropertyFromNode(Node,'OtherPaymentAmount');

  SetPropertyFromNode(Node,'ETPEarlyRetirement');
  SetPropertyFromNode(Node,'ETPRedundancy');
  SetPropertyFromNode(Node,'ETPInvalidity');
  SetPropertyFromNode(Node,'ETPUnusedRDOs');
  SetPropertyFromNode(Node,'ETPDeath');
  SetPropertyFromNode(Node,'ETPPayInLieu');
  SetPropertyFromNode(Node,'ETPGoldenHandshake');
  SetPropertyFromNode(Node,'ETPJobLossComp');
  SetPropertyFromNode(Node,'ETPUnusedSick');
  SetPropertyFromNode(Node,'ETPOther');
  SetPropertyFromNode(Node,'ETPTotal');
  SetPropertyFromNode(Node,'ETPRollover');

  SetPropertyFromNode(Node,'Gross');
  SetPropertyFromNode(Node,'PayGross');
  SetPropertyFromNode(Node,'Tax');
  SetPropertyFromNode(Node,'Net');
  SetPropertyFromNode(Node,'TotalLumpSums');
  SetPropertyFromNode(Node,'PayID');
end;

procedure   Temployeeterminations.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Employeeid' ,Employeeid);
  AddXMLNode(node,'Employeename' ,Employeename);
  AddXMLNode(node,'Startdate' ,Startdate);
  AddXMLNode(node,'Enddate' ,Enddate);
  AddXMLNode(node,'Daysservicepre01071983' ,Daysservicepre01071983);
  AddXMLNode(node,'Daysservicepost30061983' ,Daysservicepost30061983);
  AddXMLNode(node,'Etppre071983' ,Etppre071983);
  AddXMLNode(node,'Etppost061983untaxed' ,Etppost061983untaxed);
  AddXMLNode(node,'Etptaxfree' ,Etptaxfree);
  AddXMLNode(node,'Etppost061994component' ,Etppost061994component);
  AddXMLNode(node,'Grosstermination' ,Grosstermination);
  AddXMLNode(node,'Taxwithheld' ,Taxwithheld);
  AddXMLNode(node,'Etpassessable' ,Etpassessable);
  AddXMLNode(node,'Deathbenefit' ,Deathbenefit);
  AddXMLNode(node,'Typeofdeathbenefit' ,Typeofdeathbenefit);
  AddXMLNode(node,'Lumpsuma' ,Lumpsuma);
  AddXMLNode(node,'Lumpsumb' ,Lumpsumb);
  AddXMLNode(node,'Lumpsumc' ,Lumpsumc);
  AddXMLNode(node,'Lumpsumd' ,Lumpsumd);
  AddXMLNode(node,'Lumpsume' ,Lumpsume);
  AddXMLNode(node,'Reasonleft' ,Reasonleft);
  AddXMLNode(node,'Grossetp' ,Grossetp);
  AddXMLNode(node,'Cdep' ,Cdep);
  AddXMLNode(node,'Reportablefb' ,Reportablefb);
  AddXMLNode(node,'Totalallowances' ,Totalallowances);
  AddXMLNode(node,'IsETPEntitled' ,IsETPEntitled);
  AddXMLNode(node,'DeathBeneficiaryHasTFN', DeathBeneficiaryHasTFN);
  AddXMLNode(node,'IsETPEntitled' ,IsPayEntitled);
  AddXMLNode(node,'IsManualLongService' ,IsManualLongService);
  AddXMLNode(node,'IsETPEntitled' ,IsManualAnnualLeave);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'LongServicePre16081978',LongServicePre16081978);
  AddXMLNode(node,'LongServicePost16081978',LongServicePost16081978);
  AddXMLNode(node,'LongServicePost17081993',LongServicePost17081993);

  AddXMLNode(node,'AnnualLeavePre18081993',AnnualLeavePre18081993);
  AddXMLNode(node,'AnnualLeavePost17081993',AnnualLeavePost17081993);
  AddXMLNode(node,'AnnLeaveLoadingPre18081993',AnnLeaveLoadingPre18081993);
  AddXMLNode(node,'AnnLeaveLoadingPost17081993',AnnLeaveLoadingPost17081993);

  AddXMLNode(node,'OtherPaymentType',OtherPaymentType);
  AddXMLNode(node,'OtherPaymentAmount',OtherPaymentAmount);

  AddXMLNode(node,'ETPEarlyRetirement',ETPEarlyRetirement);
  AddXMLNode(node,'ETPRedundancy',ETPRedundancy);
  AddXMLNode(node,'ETPInvalidity',ETPInvalidity);
  AddXMLNode(node,'ETPUnusedRDOs',ETPUnusedRDOs);
  AddXMLNode(node,'ETPDeath',ETPDeath);
  AddXMLNode(node,'ETPPayInLieu',ETPPayInLieu);
  AddXMLNode(node,'ETPGoldenHandshake',ETPGoldenHandshake);
  AddXMLNode(node,'ETPJobLossComp',ETPJobLossComp);
  AddXMLNode(node,'ETPUnusedSick',ETPUnusedSick);
  AddXMLNode(node,'ETPOther',ETPOther);
  AddXMLNode(node,'ETPTotal',ETPTotal);
  AddXMLNode(node,'ETPRollover',ETPRollover);

  AddXMLNode(node,'Gross',Gross);
  AddXMLNode(node,'PayGross',PayGross);
  AddXMLNode(node,'Tax',Tax);
  AddXMLNode(node,'Net',Net);
  AddXMLNode(node,'TotalLumpSums',TotalLumpSums);
  AddXMLNode(node,'PayID',PayID);
end;


function    Temployeeterminations.ValidateDetails :Boolean ;
begin
   Result := False;
   //Resultstatus.Clear;

   if Employeename = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_Termination_Err_NoName,  'Employee name should not be blank' );
      Exit;
   end;
   if Enddate = 0 then begin
      Resultstatus.AddItem(False , rssError , BOR_Termination_Err_NoDate,  'Termination date should not be blank'  );
      Exit;
   end;
   if Reasonleft = '' then begin
      Resultstatus.AddItem(False , rssError , BOR_Termination_Err_NoReason,  'Reason should not be blank' );
      Exit;
   end;  
   Result := true;
end;

function    Temployeeterminations.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Employeeid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Employeeid should not be 0' , False );
      Exit;
   end;
   if Employeename = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Employeename should not be blank' , False );
      Exit;
   end;
   if Startdate = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Startdate should not be blank' , False );
      Exit;
   end;
   if Enddate = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Enddate should not be blank' , False );
      Exit;
   end;
   if Daysservicepre01071983 = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Daysservicepre01071983 should not be 0' , False );
      Exit;
   end;
   if Daysservicepost30061983 = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Daysservicepost30061983 should not be 0' , False );
      Exit;
   end;
   if Etppre071983 = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Etppre071983 should not be 0' , False );
      Exit;
   end;
   if Etppost061983untaxed = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Etppost061983untaxed should not be 0' , False );
      Exit;
   end;
  // if Etptaxfree = 0 then begin
//      Resultstatus.AddItem(False , rssError , 0,  'Etppost061983taxfree should not be 0' , False );
//      Exit;
//   end;
   if Etppost061994component = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Etppost061994component should not be 0' , False );
      Exit;
   end;
   if Grosstermination = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Grosstermination should not be 0' , False );
      Exit;
   end;
   if Taxwithheld = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Taxwithheld should not be 0' , False );
      Exit;
   end;
   if Etpassessable = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Etpassessable should not be 0' , False );
      Exit;
   end;
   if Typeofdeathbenefit = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Typeofdeathbenefit should not be blank' , False );
      Exit;
   end;
   if Lumpsuma = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Lumpsuma should not be 0' , False );
      Exit;
   end;
   if Lumpsumb = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Lumpsumb should not be 0' , False );
      Exit;
   end;
   if Lumpsumd = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Lumpsumd should not be 0' , False );
      Exit;
   end;
   if Lumpsume = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Lumpsume should not be 0' , False );
      Exit;
   end;
   if Reasonleft = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Reasonleft should not be blank' , False );
      Exit;
   end;
   if Grossetp = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Grossetp should not be 0' , False );
      Exit;
   end;
   if Cdep = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Cdep should not be 0' , False );
      Exit;
   end;
   if Reportablefb = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Reportablefb should not be 0' , False );
      Exit;
   end;
   if Totalallowances = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Totalallowances should not be 0' , False );
      Exit;
   end;
   Result := true;
end;


function    Temployeeterminations.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;

procedure Temployeeterminations.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Temployeeterminations.DoFieldOnChange(Sender: TField);
begin
   inherited;
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

   if Sysutils.SameText(Sender.FieldName , 'IsPayEntitled') then begin
     DoFinalCalcs;
   end;

   if Sysutils.SameText(Sender.FieldName , 'IsETPEntitled') then begin
     SendEvent(BusobjEventVal_TerminateETPFldchanged,BusObjEvent_Change );
   end;

   if Sysutils.SameText(Sender.FieldName , 'EmployeeName') then begin
     SendEvent(BusobjEventVal_TerminateEmpNamechanged,BusObjEvent_Change );
   end;

   if Sysutils.SameText(Sender.FieldName , 'EmployeeName') then begin
     CalcLongService ;
   end;

   if Sysutils.SameText(Sender.FieldName , 'ETPRedundancy')
     or Sysutils.SameText(Sender.FieldName , 'ETPEarlyRetirement')
     or Sysutils.SameText(Sender.FieldName , 'ETPInvalidity')
     or Sysutils.SameText(Sender.FieldName , 'ETPUnusedRDOs')
     or Sysutils.SameText(Sender.FieldName , 'ETPDeath')
     or Sysutils.SameText(Sender.FieldName , 'ETPPayInLieu')
     or Sysutils.SameText(Sender.FieldName , 'ETPGoldenHandshake')
     or Sysutils.SameText(Sender.FieldName , 'ETPJobLossComp')
     or Sysutils.SameText(Sender.FieldName , 'ETPUnusedSick')
     or Sysutils.SameText(Sender.FieldName , 'ETPOther')
     or Sysutils.SameText(Sender.FieldName , 'ETPRollover')
     or Sysutils.SameText(Sender.FieldName , 'ETPDeath')
   then begin
     ETPTotal := ETPRedundancy + ETPEarlyRetirement + ETPInvalidity + ETPUnusedRDOs + ETPDeath
                 + ETPPayInLieu + ETPGoldenHandshake + ETPJobLossComp + ETPUnusedSick
                 + ETPOther - ETPRollover ;
     CalcETPs ;
   end;

   if Sysutils.SameText(Sender.FieldName , 'Deleted') then begin
     if Deleted then begin
        if self.Complete then begin
          if fDoDelete then begin
            SendEvent(BusobjEventVal_HandleDeleteDialog,BusObjEvent_Change );
          end;
          if fDoDelete then begin
            Pay.EmployeeDetails.Active       := True;
            Pay.EmployeeDetails.Datefinished:= 0;
            Pay.EmployeeDetails.Isterminated := False;
            Pay.DeletePay;
            PostDb;
            Pay.PostDb;
            Pay.EmployeeDetails.PostDb;
            SendEvent(BusobjEventVal_HandleDeletedTermination,BusObjEvent_Change );
          end else begin
            Deleted := False;
          end;
        end;  
     end;
   end;
end;

Function Temployeeterminations.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  Temployeeterminations.GetIDField : String;
begin
   Result := 'Terminationid'
end;


Function  Temployeeterminations.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  Temployeeterminations.GetEmployeeid             :Integer   ; begin Result := GetIntegerField('Employeeid');End;
Function  Temployeeterminations.GetEmployeename           :String    ; begin Result := GetStringField('Employeename');End;
Function  Temployeeterminations.GetStartdate              :TDatetime ; begin Result := GetDatetimeField('Startdate');End;
Function  Temployeeterminations.GetEnddate                :TDatetime ; begin Result := GetDatetimeField('Enddate');End;
Function  Temployeeterminations.GetDaysservicepre01071983 :Integer   ; begin Result := GetIntegerField('Daysservicepre01071983');End;
Function  Temployeeterminations.GetDaysservicepost30061983:Integer   ; begin Result := GetIntegerField('Daysservicepost30061983');End;
Function  Temployeeterminations.GetEtppre071983           :Double    ; begin Result := GetFloatField('Etppre071983');End;
Function  Temployeeterminations.GetEtppost061983untaxed   :Double    ; begin Result := GetFloatField('Etppost061983untaxed');End;
Function  Temployeeterminations.GetEtptaxfree   :Double    ; begin Result := GetFloatField('Etptaxfree');End;
Function  Temployeeterminations.GetEtppost061994component :Double    ; begin Result := GetFloatField('Etppost061994component');End;
Function  Temployeeterminations.GetGrosstermination       :Double    ; begin Result := GetFloatField('Grosstermination');End;
Function  Temployeeterminations.GetTaxwithheld            :Double    ; begin Result := GetFloatField('Taxwithheld');End;
Function  Temployeeterminations.GetEtpassessable          :Double    ; begin Result := GetFloatField('Etpassessable');End;
Function  Temployeeterminations.GetDeathbenefit           :Boolean   ; begin Result := GetBooleanField('Deathbenefit');End;
Function  Temployeeterminations.GetTypeofdeathbenefit     :String    ; begin Result := GetStringField('Typeofdeathbenefit');End;
Function  Temployeeterminations.GetLumpsuma               :Double    ; begin Result := GetFloatField('Lumpsuma');End;
Function  Temployeeterminations.GetLumpsumb               :Double    ; begin Result := GetFloatField('Lumpsumb');End;
Function  Temployeeterminations.GetLumpsumc               :Double    ; begin Result := GetFloatField('Lumpsumc');End;
Function  Temployeeterminations.GetLumpsumd               :Double    ; begin Result := GetFloatField('Lumpsumd');End;
Function  Temployeeterminations.GetLumpsume               :Double    ; begin Result := GetFloatField('Lumpsume');End;
Function  Temployeeterminations.GetReasonleft             :String    ; begin Result := GetStringField('ReasonLeft');End;
Function  Temployeeterminations.GetGrossetp               :Double    ; begin Result := GetFloatField('Grossetp');End;
Function  Temployeeterminations.GetCdep                   :Double    ; begin Result := GetFloatField('Cdep');End;
Function  Temployeeterminations.GetReportablefb           :Double    ; begin Result := GetFloatField('Reportablefb');End;
Function  Temployeeterminations.GetTotalallowances        :Double    ; begin Result := GetFloatField('Totalallowances');End;
Function  Temployeeterminations.GetETPEntitled            :Boolean   ; begin Result := GetBooleanField('IsETPEntitled');End;
Function  Temployeeterminations.GetDeleted                :Boolean   ; begin Result := GetBooleanField('Deleted');End;
Function  Temployeeterminations.GetDeathTFN               :Boolean   ; begin Result := GetBooleanField('DeathBeneficiaryHasTFN');End;
Function  Temployeeterminations.GetPayEntitled            :Boolean   ; begin Result := GetBooleanField('IsPayEntitled');End;
Function  Temployeeterminations.GetManualLongService      :Boolean   ; begin Result := GetBooleanField('IsManualLongService');End;
Function  Temployeeterminations.GetManualAnnualLeave      :Boolean   ; begin Result := GetBooleanField('IsManualAnnualLeave');End;
Function  Temployeeterminations.getLongServicePre16081978 :Double    ; begin Result := GetFloatField('LongServicePre16081978');End;
Function  Temployeeterminations.getLongServicePost16081978:Double    ; begin Result := GetFloatField('LongServicePost16081978');End;
Function  Temployeeterminations.getLongServicePost17081993:Double    ; begin Result := GetFloatField('LongServicePost17081993');End;

Function  Temployeeterminations.getAnnualLeavePre18081993 :Double    ; begin Result := GetFloatField('AnnualLeavePre18081993');End;
Function  Temployeeterminations.getAnnualLeavePost17081993 :Double    ; begin Result := GetFloatField('AnnualLeavePost17081993');End;
Function  Temployeeterminations.getAnnLeaveLoadingPre18081993 :Double ; begin Result := GetFloatField('AnnLeaveLoadingPre18081993');End;
Function  Temployeeterminations.getAnnLeaveLoadingPost17081993 :Double ; begin Result := GetFloatField('AnnLeaveLoadingPost17081993');End;

Function  Temployeeterminations.GetOtherPaymentType       :String    ; begin Result := GetStringField('OtherPaymentType');End;
Function  Temployeeterminations.getOtherPaymentAmount     :Double ; begin Result := GetFloatField('OtherPaymentAmount');End;

Function  Temployeeterminations.getETPEarlyRetirement     :Double ; begin Result := GetFloatField('ETPEarlyRetirement');End;
Function  Temployeeterminations.getETPRedundancy          :Double ; begin Result := GetFloatField('ETPRedundancy');End;
Function  Temployeeterminations.getETPInvalidity          :Double ; begin Result := GetFloatField('ETPInvalidity');End;
Function  Temployeeterminations.getETPUnusedRDOs          :Double ; begin Result := GetFloatField('ETPUnusedRDOs');End;
Function  Temployeeterminations.getETPDeath               :Double ; begin Result := GetFloatField('ETPDeath');End;
Function  Temployeeterminations.getETPPayInLieu           :Double ; begin Result := GetFloatField('ETPPayInLieu');End;
Function  Temployeeterminations.getETPGoldenHandshake     :Double ; begin Result := GetFloatField('ETPGoldenHandshake');End;
Function  Temployeeterminations.getETPJobLossComp         :Double ; begin Result := GetFloatField('ETPJobLossComp');End;
Function  Temployeeterminations.getETPUnusedSick          :Double ; begin Result := GetFloatField('ETPUnusedSick');End;
Function  Temployeeterminations.getETPOther               :Double ; begin Result := GetFloatField('ETPOther');End;
Function  Temployeeterminations.getETPTotal               :Double ; begin Result := GetFloatField('ETPTotal');End;
Function  Temployeeterminations.getETPRollover            :Double ; begin Result := GetFloatField('ETPRollover');End;

Function  Temployeeterminations.getGross                  :Double ; begin Result := GetFloatField('Gross');End;
Function  Temployeeterminations.getPayGross               :Double ; begin Result := GetFloatField('PayGross');End;
Function  Temployeeterminations.getTax                    :Double ; begin Result := GetFloatField('Tax');End;
Function  Temployeeterminations.getNet                    :Double ; begin Result := GetFloatField('Net');End;
Function  Temployeeterminations.getTotalLumpSums          :Double ; begin Result := GetFloatField('TotalLumpSums');End;
Function  Temployeeterminations.getPayID                  :Integer   ; begin Result := GetIntegerField('PayID');End;

Procedure Temployeeterminations.SetEmployeeid             (Const Value :Integer   ); begin SetIntegerField('Employeeid'              , Value);End;
Procedure Temployeeterminations.SetEmployeename           (Const Value :String    ); begin SetStringField('Employeename'            , Value);End;
Procedure Temployeeterminations.SetStartdate              (Const Value :TDatetime ); begin SetDatetimeField('Startdate'               , Value);End;
Procedure Temployeeterminations.SetEnddate                (Const Value :TDatetime ); begin SetDatetimeField('Enddate'                 , Value);End;
Procedure Temployeeterminations.SetDaysservicepre01071983 (Const Value :Integer   ); begin SetIntegerField('Daysservicepre01071983'  , Value);End;
Procedure Temployeeterminations.SetDaysservicepost30061983(Const Value :Integer   ); begin SetIntegerField('Daysservicepost30061983' , Value);End;
Procedure Temployeeterminations.SetEtppre071983           (Const Value :Double    ); begin SetFloatField('Etppre071983'            , Value);End;
Procedure Temployeeterminations.SetEtppost061983untaxed   (Const Value :Double    ); begin SetFloatField('Etppost061983untaxed'    , Value);End;
Procedure Temployeeterminations.SetEtptaxfree             (Const Value :Double    ); begin SetFloatField('Etptaxfree'      , Value);End;
Procedure Temployeeterminations.SetEtppost061994component (Const Value :Double    ); begin SetFloatField('Etppost061994component'  , Value);End;
Procedure Temployeeterminations.SetGrosstermination       (Const Value :Double    ); begin SetFloatField('Grosstermination'        , Value);End;
Procedure Temployeeterminations.SetTaxwithheld            (Const Value :Double    ); begin SetFloatField('Taxwithheld'             , Value);End;
Procedure Temployeeterminations.SetEtpassessable          (Const Value :Double    ); begin SetFloatField('Etpassessable'           , Value);End;
Procedure Temployeeterminations.SetDeathbenefit           (Const Value :Boolean   ); begin SetBooleanField('Deathbenefit'            , Value);End;
Procedure Temployeeterminations.SetTypeofdeathbenefit     (Const Value :String    ); begin SetStringField('Typeofdeathbenefit'      , Value);End;
Procedure Temployeeterminations.SetLumpsuma               (Const Value :Double    ); begin SetFloatField('Lumpsuma'                , Value);End;
Procedure Temployeeterminations.SetLumpsumb               (Const Value :Double    ); begin SetFloatField('Lumpsumb'                , Value);End;
Procedure Temployeeterminations.SetLumpsumc               (Const Value :Double    ); begin SetFloatField('Lumpsumc'                , Value);End;
Procedure Temployeeterminations.SetLumpsumd               (Const Value :Double    ); begin SetFloatField('Lumpsumd'                , Value);End;
Procedure Temployeeterminations.SetLumpsume               (Const Value :Double    ); begin SetFloatField('Lumpsume'                , Value);End;
Procedure Temployeeterminations.SetReasonleft             (Const Value :String    ); begin SetStringField('Reasonleft'              , Value);End;
Procedure Temployeeterminations.SetGrossetp               (Const Value :Double    ); begin SetFloatField('Grossetp'                , Value);End;
Procedure Temployeeterminations.SetCdep                   (Const Value :Double    ); begin SetFloatField('Cdep'                    , Value);End;
Procedure Temployeeterminations.SetReportablefb           (Const Value :Double    ); begin SetFloatField('Reportablefb'            , Value);End;
Procedure Temployeeterminations.SetTotalallowances        (Const Value :Double    ); begin SetFloatField('Totalallowances'         , Value);End;
Procedure Temployeeterminations.SetETPEntitled     (Const Value :Boolean    ); begin SetBooleanField('IsETPEntitled'      , Value);End;
Procedure Temployeeterminations.SetDeleted         (Const Value :Boolean    ); begin SetBooleanField('Deleted'      , Value);End;
Procedure Temployeeterminations.SetDeathTFN        (Const Value :Boolean    ); begin SetBooleanField('DeathBeneficiaryHasTFN'      , Value);End;
Procedure Temployeeterminations.SetPayEntitled     (Const Value :Boolean    ); begin SetBooleanField('IsPayEntitled'      , Value);End;
Procedure Temployeeterminations.SetManualLongService (Const Value :Boolean    ); begin SetBooleanField('IsManualLongService'      , Value);End;
Procedure Temployeeterminations.SetManualAnnualLeave (Const Value :Boolean    ); begin SetBooleanField('IsManualAnnualLeave'      , Value);End;
Procedure Temployeeterminations.SetLongServicePre16081978 (Const Value :Double  ); begin SetFloatField('LongServicePre16081978'   , Value);End;
Procedure Temployeeterminations.SetLongServicePost16081978(Const Value :Double  ); begin SetFloatField('LongServicePost16081978'  , Value);End;
Procedure Temployeeterminations.SetLongServicePost17081993(Const Value :Double  ); begin SetFloatField('LongServicePost17081993'  , Value);End;

Procedure Temployeeterminations.SetAnnualLeavePre18081993(Const Value :Double  ); begin SetFloatField('AnnualLeavePre18081993'    , Value);End;
Procedure Temployeeterminations.SetAnnualLeavePost17081993(Const Value :Double  ); begin SetFloatField('AnnualLeavePost17081993'  , Value);End;
Procedure Temployeeterminations.SetAnnLeaveLoadingPre18081993(Const Value :Double  ); begin SetFloatField('AnnLeaveLoadingPre18081993', Value);End;
Procedure Temployeeterminations.SetAnnLeaveLoadingPost17081993(Const Value :Double  ); begin SetFloatField('AnnLeaveLoadingPost17081993', Value);End;

Procedure Temployeeterminations.SetOtherPaymentType      (Const Value :String    ); begin SetStringField('OtherPaymentType'      , Value);End;
Procedure Temployeeterminations.SetOtherPaymentAmount(Const Value :Double  ); begin SetFloatField('OtherPaymentAmount', Value);End;


Procedure Temployeeterminations.SetETPEarlyRetirement   (Const Value :Double  ); begin SetFloatField('ETPEarlyRetirement', Value);End;
Procedure Temployeeterminations.SetETPRedundancy        (Const Value :Double  ); begin SetFloatField('ETPRedundancy', Value);End;
Procedure Temployeeterminations.SetETPInvalidity        (Const Value :Double  ); begin SetFloatField('ETPInvalidity', Value);End;
Procedure Temployeeterminations.SetETPUnusedRDOs        (Const Value :Double  ); begin SetFloatField('ETPUnusedRDOs', Value);End;
Procedure Temployeeterminations.SetETPDeath             (Const Value :Double  ); begin SetFloatField('ETPDeath', Value);End;
Procedure Temployeeterminations.SetETPPayInLieu         (Const Value :Double  ); begin SetFloatField('ETPPayInLieu', Value);End;
Procedure Temployeeterminations.SetETPGoldenHandshake   (Const Value :Double  ); begin SetFloatField('ETPGoldenHandshake', Value);End;
Procedure Temployeeterminations.SetETPJobLossComp       (Const Value :Double  ); begin SetFloatField('ETPJobLossComp', Value);End;
Procedure Temployeeterminations.SetETPUnusedSick        (Const Value :Double  ); begin SetFloatField('ETPUnusedSick', Value);End;
Procedure Temployeeterminations.SetETPOther             (Const Value :Double  ); begin SetFloatField('ETPOther', Value);End;
Procedure Temployeeterminations.SetETPTotal             (Const Value :Double  ); begin SetFloatField('ETPTotal', Value);End;
Procedure Temployeeterminations.SetETPRollover          (Const Value :Double  ); begin SetFloatField('ETPRollover', Value);End;

Procedure Temployeeterminations.SetGross                (Const Value :Double  ); begin SetFloatField('Gross', Value);End;
Procedure Temployeeterminations.SetPayGross             (Const Value :Double  ); begin SetFloatField('PayGross', Value);End;
Procedure Temployeeterminations.SetTax                  (Const Value :Double  ); begin SetFloatField('Tax', Value);End;
Procedure Temployeeterminations.SetNet                  (Const Value :Double  ); begin SetFloatField('Net', Value);End;
Procedure Temployeeterminations.SetTotalLumpSums        (Const Value :Double  ); begin SetFloatField('TotalLumpSums', Value);End;
Procedure Temployeeterminations.SetPayID                (Const Value :Integer   ); begin SetIntegerField('PayID', Value);End;


function Temployeeterminations.GetComplete: boolean;
begin
  result:= GetBooleanField('Complete');
end;

procedure Temployeeterminations.SetComplete(const Value: boolean);
begin
  SetBooleanField('Complete', Value);
end;

function Temployeeterminations.GetData: string;
begin
  result:= GetStringField('Data');
end;

procedure Temployeeterminations.SetData(const Value: string);
begin
  SetStringField('Data', Value);
end;

procedure Temployeeterminations.AddDoneStep(aStepName: string);
begin
  with TStringList.Create do begin
    CommaText:= self.Data;
    if IndexOf(aStepName) < 0 then begin
      Add(aStepName);
      self.Data:= CommaText;
    end;
    Free;
  end;
end;

function Temployeeterminations.StepsDone(aStepNameList: string): boolean;
var
  doneList, stepList: TStringList;
  x: integer;
begin
  result:= true;
  doneList:= TStringList.Create;
  stepList:= TStringList.Create;
  try
    doneList.CommaText:= Data;
    stepList.CommaText:= aStepNameList;
    for x:= 0 to stepList.Count -1 do begin
      if doneList.IndexOf(stepList[x]) < 0 then begin
        result:= false;
        break;
      end;
    end;
  finally
    doneList.Free;
    stepList.Free;
  end;
end;


initialization

RegisterClassOnce(Temployeeterminations);


end.
