unit BusObjTerminationSimple;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/06/14  1.00.00  A.  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, JsonObject;


type
  TTerminationSimple = class(TMSBusObj)

  private
    function GetETPName                                 : string    ;
    function GetETPDisplayName                          : string    ;
    function GetETPRateType                             : string    ;
    function GetETPExpenseAccount                       : string    ;
    function GetETPExemptPaygWithholding                : Boolean   ;
    function GetETPExemptSuperannuationGuaranteeCont    : Boolean   ;
    function GetETPReportableW1onActivityStatement      : Boolean   ;
    function GetETPActive                               : Boolean   ;

    procedure SetETPName                                 (const Value: string    );
    procedure SetETPDisplayName                          (const Value: string    );
    procedure SetETPRateType                             (const Value: string    );
    procedure SetETPExpenseAccount                       (const Value: string    );
    procedure SetETPExemptPaygWithholding                (const Value: Boolean   );
    procedure SetETPExemptSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetETPReportableW1onActivityStatement      (const Value: Boolean   );
    procedure SetETPActive                               (const Value: Boolean   );


    function GetEmployeeID                     : Integer   ;
    function GetEmployeeName                   : string    ;
    function GetStartDate                      : TDateTime ;
    function GetEndDate                        : TDateTime ;
    function GetDaysServicePre01071983         : Integer   ;
    function GetDaysServicePost30061983        : Integer   ;
    function GetETPpre071983                   : Double    ;
    function GetETPpost061983Untaxed           : Double    ;
    function GetETPtaxfree                     : Double    ;
    function GetETPpost061994Component         : Double    ;
    function GetGrossTermination               : Double    ;
    function GetTaxWithheld                    : Double    ;
    function GetETPAssessable                  : Double    ;
    function GetDeathBenefit                   : Boolean   ;
    function GetTypeOfDeathBenefit             : string    ;
    function GetLumpSumA                       : Double    ;
    function GetLumpSumB                       : Double    ;
    function GetLumpSumD                       : Double    ;
    function GetLumpSumE                       : Double    ;
    function GetReasonLeft                     : string    ;
    function GetGrossETP                       : Double    ;
    function GetCDEP                           : Double    ;
    function GetReportableFB                   : Double    ;
    function GetTotalAllowances                : Double    ;
    function GetDeathBeneficiaryHasTFN         : Boolean   ;
    function GetIsPayEntitled                  : Boolean   ;
    function GetIsETPEntitled                  : Boolean   ;
    function GetIsManualLongService            : Boolean   ;
    function GetIsManualAnnualLeave            : Boolean   ;
    function GetOtherPaymentType               : string    ;
    function GetLongServicePre16081978         : Double    ;
    function GetLongServicePost16081978        : Double    ;
    function GetLongServicePost17081993        : Double    ;
    function GetAnnualLeavePre18081993         : Double    ;
    function GetAnnualLeavePost17081993        : Double    ;
    function GetAnnLeaveLoadingPre18081993     : Double    ;
    function GetAnnLeaveLoadingPost17081993    : Double    ;
    function GetOtherPaymentAmount             : Double    ;
    function GetETPEarlyRetirement             : Double    ;
    function GetETPRedundancy                  : Double    ;
    function GetETPInvalidity                  : Double    ;
    function GetETPUnusedRDOs                  : Double    ;
    function GetETPDeath                       : Double    ;
    function GetETPPayInLieu                   : Double    ;
    function GetETPGoldenHandshake             : Double    ;
    function GetETPJobLossComp                 : Double    ;
    function GetETPUnusedSick                  : Double    ;
    function GetETPOther                       : Double    ;
    function GetETPTotal                       : Double    ;
    function GetETPRollover                    : Double    ;
    function GetGross                          : Double    ;
    function GetTax                            : Double    ;
    function GetNet                            : Double    ;
    function GetTotalLumpSums                  : Double    ;
    function GetPayID                          : Integer   ;
    function GetLumpSumC                       : Double    ;
    function GetDeleted                        : Boolean   ;
    function GetPayGross                       : Double    ;
    function GetETPpost061983taxed             : Double    ;
    function GetComplete                       : Boolean   ;
    function GetData                           : string    ;
    procedure SetEmployeeID                     (const Value: Integer   );
    procedure SetEmployeeName                   (const Value: string    );
    procedure SetStartDate                      (const Value: TDateTime );
    procedure SetEndDate                        (const Value: TDateTime );
    procedure SetDaysServicePre01071983         (const Value: Integer   );
    procedure SetDaysServicePost30061983        (const Value: Integer   );
    procedure SetETPpre071983                   (const Value: Double    );
    procedure SetETPpost061983Untaxed           (const Value: Double    );
    procedure SetETPtaxfree                     (const Value: Double    );
    procedure SetETPpost061994Component         (const Value: Double    );
    procedure SetGrossTermination               (const Value: Double    );
    procedure SetTaxWithheld                    (const Value: Double    );
    procedure SetETPAssessable                  (const Value: Double    );
    procedure SetDeathBenefit                   (const Value: Boolean   );
    procedure SetTypeOfDeathBenefit             (const Value: string    );
    procedure SetLumpSumA                       (const Value: Double    );
    procedure SetLumpSumB                       (const Value: Double    );
    procedure SetLumpSumD                       (const Value: Double    );
    procedure SetLumpSumE                       (const Value: Double    );
    procedure SetReasonLeft                     (const Value: string    );
    procedure SetGrossETP                       (const Value: Double    );
    procedure SetCDEP                           (const Value: Double    );
    procedure SetReportableFB                   (const Value: Double    );
    procedure SetTotalAllowances                (const Value: Double    );
    procedure SetDeathBeneficiaryHasTFN         (const Value: Boolean   );
    procedure SetIsPayEntitled                  (const Value: Boolean   );
    procedure SetIsETPEntitled                  (const Value: Boolean   );
    procedure SetIsManualLongService            (const Value: Boolean   );
    procedure SetIsManualAnnualLeave            (const Value: Boolean   );
    procedure SetOtherPaymentType               (const Value: string    );
    procedure SetLongServicePre16081978         (const Value: Double    );
    procedure SetLongServicePost16081978        (const Value: Double    );
    procedure SetLongServicePost17081993        (const Value: Double    );
    procedure SetAnnualLeavePre18081993         (const Value: Double    );
    procedure SetAnnualLeavePost17081993        (const Value: Double    );
    procedure SetAnnLeaveLoadingPre18081993     (const Value: Double    );
    procedure SetAnnLeaveLoadingPost17081993    (const Value: Double    );
    procedure SetOtherPaymentAmount             (const Value: Double    );
    procedure SetETPEarlyRetirement             (const Value: Double    );
    procedure SetETPRedundancy                  (const Value: Double    );
    procedure SetETPInvalidity                  (const Value: Double    );
    procedure SetETPUnusedRDOs                  (const Value: Double    );
    procedure SetETPDeath                       (const Value: Double    );
    procedure SetETPPayInLieu                   (const Value: Double    );
    procedure SetETPGoldenHandshake             (const Value: Double    );
    procedure SetETPJobLossComp                 (const Value: Double    );
    procedure SetETPUnusedSick                  (const Value: Double    );
    procedure SetETPOther                       (const Value: Double    );
    procedure SetETPTotal                       (const Value: Double    );
    procedure SetETPRollover                    (const Value: Double    );
    procedure SetGross                          (const Value: Double    );
    procedure SetTax                            (const Value: Double    );
    procedure SetNet                            (const Value: Double    );
    procedure SetTotalLumpSums                  (const Value: Double    );
    procedure SetPayID                          (const Value: Integer   );
    procedure SetLumpSumC                       (const Value: Double    );
    procedure SetDeleted                        (const Value: Boolean   );
    procedure SetPayGross                       (const Value: Double    );
    procedure SetETPpost061983taxed             (const Value: Double    );
    procedure SetComplete                       (const Value: Boolean   );
    procedure SetData                           (const Value: string    );
    function GetETPCode: string;
    procedure SetETPCode(const Value: string);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;

  public
    DataObj: TJsonObject;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure Load(const fIsReadonly:boolean =False); override;
    procedure CalcTermination;

    property StartDate                       :TDateTime   read GetStartDate                     write SetStartDate                  ;
    property EndDate                         :TDateTime   read GetEndDate                       write SetEndDate                    ;

    property ETPpre071983                    :Double      read GetETPpre071983                  write SetETPpre071983               ;
    property ETPpost061983Untaxed            :Double      read GetETPpost061983Untaxed          write SetETPpost061983Untaxed       ;
    property ETPtaxfree                      :Double      read GetETPtaxfree                    write SetETPtaxfree                 ;
    property ETPpost061994Component          :Double      read GetETPpost061994Component        write SetETPpost061994Component     ;
    property GrossTermination                :Double      read GetGrossTermination              write SetGrossTermination           ;
    property TaxWithheld                     :Double      read GetTaxWithheld                   write SetTaxWithheld                ;
    property ETPAssessable                   :Double      read GetETPAssessable                 write SetETPAssessable              ;

    property TypeOfDeathBenefit              :string      read GetTypeOfDeathBenefit            write SetTypeOfDeathBenefit         ;
    property LumpSumA                        :Double      read GetLumpSumA                      write SetLumpSumA                   ;
    property LumpSumB                        :Double      read GetLumpSumB                      write SetLumpSumB                   ;
    property LumpSumD                        :Double      read GetLumpSumD                      write SetLumpSumD                   ;
    property LumpSumE                        :Double      read GetLumpSumE                      write SetLumpSumE                   ;
    property ReasonLeft                      :string      read GetReasonLeft                    write SetReasonLeft                 ;
    property GrossETP                        :Double      read GetGrossETP                      write SetGrossETP                   ;
    property CDEP                            :Double      read GetCDEP                          write SetCDEP                       ;
    property ReportableFB                    :Double      read GetReportableFB                  write SetReportableFB               ;
    property TotalAllowances                 :Double      read GetTotalAllowances               write SetTotalAllowances            ;

    property IsPayEntitled                   :Boolean     read GetIsPayEntitled                 write SetIsPayEntitled              ;
    property IsETPEntitled                   :Boolean     read GetIsETPEntitled                 write SetIsETPEntitled              ;
    property IsManualLongService             :Boolean     read GetIsManualLongService           write SetIsManualLongService        ;
    property IsManualAnnualLeave             :Boolean     read GetIsManualAnnualLeave           write SetIsManualAnnualLeave        ;
    property OtherPaymentType                :string      read GetOtherPaymentType              write SetOtherPaymentType           ;
    property LongServicePre16081978          :Double      read GetLongServicePre16081978        write SetLongServicePre16081978     ;
    property LongServicePost16081978         :Double      read GetLongServicePost16081978       write SetLongServicePost16081978    ;
    property LongServicePost17081993         :Double      read GetLongServicePost17081993       write SetLongServicePost17081993    ;
    property AnnualLeavePre18081993          :Double      read GetAnnualLeavePre18081993        write SetAnnualLeavePre18081993     ;
    property AnnualLeavePost17081993         :Double      read GetAnnualLeavePost17081993       write SetAnnualLeavePost17081993    ;
    property AnnLeaveLoadingPre18081993      :Double      read GetAnnLeaveLoadingPre18081993    write SetAnnLeaveLoadingPre18081993 ;
    property AnnLeaveLoadingPost17081993     :Double      read GetAnnLeaveLoadingPost17081993   write SetAnnLeaveLoadingPost17081993;
    property OtherPaymentAmount              :Double      read GetOtherPaymentAmount            write SetOtherPaymentAmount         ;
    property ETPEarlyRetirement              :Double      read GetETPEarlyRetirement            write SetETPEarlyRetirement         ;
    property ETPRedundancy                   :Double      read GetETPRedundancy                 write SetETPRedundancy              ;
    property ETPInvalidity                   :Double      read GetETPInvalidity                 write SetETPInvalidity              ;
    property ETPUnusedRDOs                   :Double      read GetETPUnusedRDOs                 write SetETPUnusedRDOs              ;
    property ETPDeath                        :Double      read GetETPDeath                      write SetETPDeath                   ;
    property ETPPayInLieu                    :Double      read GetETPPayInLieu                  write SetETPPayInLieu               ;
    property ETPGoldenHandshake              :Double      read GetETPGoldenHandshake            write SetETPGoldenHandshake         ;
    property ETPJobLossComp                  :Double      read GetETPJobLossComp                write SetETPJobLossComp             ;
    property ETPUnusedSick                   :Double      read GetETPUnusedSick                 write SetETPUnusedSick              ;
    property ETPOther                        :Double      read GetETPOther                      write SetETPOther                   ;
    property ETPTotal                        :Double      read GetETPTotal                      write SetETPTotal                   ;
    property ETPRollover                     :Double      read GetETPRollover                   write SetETPRollover                ;
    property Gross                           :Double      read GetGross                         write SetGross                      ;
    property Tax                             :Double      read GetTax                           write SetTax                        ;
    property Net                             :Double      read GetNet                           write SetNet                        ;
    property TotalLumpSums                   :Double      read GetTotalLumpSums                 write SetTotalLumpSums              ;
    property LumpSumC                        :Double      read GetLumpSumC                      write SetLumpSumC                   ;

    property PayGross                        :Double      read GetPayGross                      write SetPayGross                   ;
    property ETPpost061983taxed              :Double      read GetETPpost061983taxed            write SetETPpost061983taxed         ;
    property Complete                        :Boolean     read GetComplete                      write SetComplete                   ;
    property Data                            :string      read GetData                          write SetData                       ;

  published
    property EmployeeTerminationPaymentsName                                  :string      read GetETPName                                write SetETPName                             ;
    property EmployeeTerminationPaymentsDisplayName                           :string      read GetETPDisplayName                         write SetETPDisplayName                      ;
    property EmployeeTerminationPaymentsRateType                              :string      read GetETPRateType                            write SetETPRateType                         ;
    property EmployeeTerminationPaymentsExpenseAccount                        :string      read GetETPExpenseAccount                      write SetETPExpenseAccount                   ;
    property EmployeeTerminationPaymentsExemptPaygWithholding                 :Boolean     read GetETPExemptPaygWithholding               write SetETPExemptPaygWithholding            ;
    property EmployeeTerminationPaymentsExemptSuperannuationGuaranteeCont     :Boolean     read GetETPExemptSuperannuationGuaranteeCont   write SetETPExemptSuperannuationGuaranteeCont;
    property EmployeeTerminationPaymentsReportableW1onActivityStatement       :Boolean     read GetETPReportableW1onActivityStatement     write SetETPReportableW1onActivityStatement  ;
    property EmployeeTerminationPaymentsActive                                :Boolean     read GetETPActive                              write SetETPActive                           ;
    property PayID                           :Integer     read GetPayID                         write SetPayID                      ;
    property ETPCode                         :string      read GetETPCode write SetETPCode;

    property EmployeeID                      :Integer     read GetEmployeeID                    write SetEmployeeID                 ;
    property EmployeeName                    :string      read GetEmployeeName                  write SetEmployeeName               ;

    property DaysServicePre01071983          :Integer     read GetDaysServicePre01071983        write SetDaysServicePre01071983     ;
    property DaysServicePost30061983         :Integer     read GetDaysServicePost30061983       write SetDaysServicePost30061983    ;


    property DeathBenefit                    :Boolean     read GetDeathBenefit                  write SetDeathBenefit               ;
    property DeathBeneficiaryHasTFN          :Boolean     read GetDeathBeneficiaryHasTFN        write SetDeathBeneficiaryHasTFN     ;

    property Deleted                         :Boolean     read GetDeleted                       write SetDeleted                    ;


  end;


implementation


uses tcDataUtils, CommonLib, BusObjPayBase, SysUtils;



  {TTerminationSimple}

procedure TTerminationSimple.CalcTermination;
var
  dHrsEntitled: double;
  found: boolean;
begin
  { if we have added a final annual leave line then delete it .. }
  found := false;
  if ((DataObj.F['AnnualLeaveHours'] <> 0) or (DataObj.F['RDOHours'] <> 0)) and
     (TPayBase(Self.Owner).PayLeaves.Count > 0) then begin
    TPayBase(Self.Owner).PayLeaves.Dataset.Last;
    while not TPayBase(Self.Owner).PayLeaves.BOF do begin
      if ((TPayBase(Self.Owner).PayLeaves.Leavetype = 'Annual Leave') and (TPayBase(Self.Owner).PayLeaves.Qty = DataObj.F['AnnualLeaveHours']) and (DataObj.F['AnnualLeaveHours'] <> 0)) or
         ((TPayBase(Self.Owner).PayLeaves.Leavetype = 'RDO') and (TPayBase(Self.Owner).PayLeaves.Qty = DataObj.F['RDOHours']) and (DataObj.F['RDOHours'] <> 0)) then begin
        found := true;
        TPayBase(Self.Owner).PayLeaves.Delete;
        TPayBase(Self.Owner).PayLeaves.PostDb;
        TPayBase(Self.Owner).PayLeaves.UpdatePayRatesWithLeaves;
        TPayBase(Self.Owner).RecalcAll;
      end
      else
        TPayBase(Self.Owner).PayLeaves.Dataset.Prior;
    end;
    if found then begin
      if TPayBase(Self.Owner).PaysPayRates.Dataset.Locate('PayRateId',2,[]) then begin
        { remove leave from normal hours (added call to UpdatePayRatesWithLeaves)  }
        TPayBase(Self.Owner).PaysPayRates.Qty := TPayBase(Self.Owner).PaysPayRates.Qty -
          (DataObj.F['AnnualLeaveHours'] + DataObj.F['RDOHours']);
        TPayBase(Self.Owner).PaysPayRates.PostDb;
      end;
    end;
  end;
  DataObj.F['AnnualLeaveHours'] := 0;
  DataObj.F['RDOHours'] := 0;

  if Deleted then begin


  end
  else begin
    { not deleted }
    { Annual Leave }
    dHrsEntitled := Tpaybase(Self.Owner).LeaveAccruals.GetAccruedHrs('Annual Leave',tpaybase(Self.Owner).Paydate) + TPayBase(Self.Owner).PayLeaves.GetThisPayLeaveHrsEntitlement('Annual Leave');
    if Tpaybase(Self.Owner).EmployeeLeave.Locate('Type','Annual Leave',[loCaseInsensitive]) then
      dHrsEntitled := dHrsEntitled + Tpaybase(Self.Owner).EmployeeLeave.Openningbalancehrs;
    if dHrsEntitled <> 0 then begin
      DataObj.F['AnnualLeaveHours'] := dHrsEntitled;
      TPayBase(Self.Owner).PayLeaves.New;
      TPayBase(Self.Owner).PayLeaves.Leavetype := 'Annual Leave';
      TPayBase(Self.Owner).PayLeaves.Datetaken := TPayBase(Self.Owner).PayDate;
      TPayBase(Self.Owner).PayLeaves.Qty := dHrsEntitled;
      TPayBase(Self.Owner).PayLeaves.PostDb;
      TPayBase(Self.Owner).PayLeaves.LeaveChanged := false;
      TPayBase(Self.Owner).PayLeaves.UpdatePayRatesWithLeaves;
      TPayBase(Self.Owner).RecalcAll;
    end;

    { RDO }
    dHrsEntitled := Tpaybase(Self.Owner).LeaveAccruals.GetAccruedHrs('RDO',tpaybase(Self.Owner).Paydate) + TPayBase(Self.Owner).PayLeaves.GetThisPayLeaveHrsEntitlement('RDO');
    if Tpaybase(Self.Owner).EmployeeLeave.Locate('Type','RDO',[loCaseInsensitive]) then
      dHrsEntitled := dHrsEntitled + Tpaybase(Self.Owner).EmployeeLeave.Openningbalancehrs;
    if dHrsEntitled <> 0 then begin
      DataObj.F['RDOHours'] := dHrsEntitled;
      TPayBase(Self.Owner).PayLeaves.New;
      TPayBase(Self.Owner).PayLeaves.Leavetype := 'RDO';
      TPayBase(Self.Owner).PayLeaves.Datetaken := TPayBase(Self.Owner).PayDate;
      TPayBase(Self.Owner).PayLeaves.Qty := dHrsEntitled;
      TPayBase(Self.Owner).PayLeaves.PostDb;
      TPayBase(Self.Owner).PayLeaves.LeaveChanged := false;
      TPayBase(Self.Owner).PayLeaves.UpdatePayRatesWithLeaves;
      TPayBase(Self.Owner).RecalcAll;
    end;


  end;
end;

constructor TTerminationSimple.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TerminationSimple';
  fSQL := 'SELECT * FROM tblemployeeterminations';
  DataObj := TJsonObject.Create;
end;


destructor TTerminationSimple.Destroy;
begin
  DataObj.Free;
  inherited;
end;


procedure TTerminationSimple.Load(const fIsReadonly: boolean);
begin
  inherited;
  DataObj.AsString := Data;
end;

procedure TTerminationSimple.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EmployeeName');
  SetDateTimePropertyFromNode(node,'StartDate');
  SetDateTimePropertyFromNode(node,'EndDate');
  SetPropertyFromNode(node,'DaysServicePre01071983');
  SetPropertyFromNode(node,'DaysServicePost30061983');
  SetPropertyFromNode(node,'ETPpre071983');
  SetPropertyFromNode(node,'ETPpost061983Untaxed');
  SetPropertyFromNode(node,'ETPtaxfree');
  SetPropertyFromNode(node,'ETPpost061994Component');
  SetPropertyFromNode(node,'GrossTermination');
  SetPropertyFromNode(node,'TaxWithheld');
  SetPropertyFromNode(node,'ETPAssessable');
  SetBooleanPropertyFromNode(node,'DeathBenefit');
  SetPropertyFromNode(node,'TypeOfDeathBenefit');
  SetPropertyFromNode(node,'LumpSumA');
  SetPropertyFromNode(node,'LumpSumB');
  SetPropertyFromNode(node,'LumpSumD');
  SetPropertyFromNode(node,'LumpSumE');
  SetPropertyFromNode(node,'ReasonLeft');
  SetPropertyFromNode(node,'GrossETP');
  SetPropertyFromNode(node,'CDEP');
  SetPropertyFromNode(node,'ReportableFB');
  SetPropertyFromNode(node,'TotalAllowances');
  SetBooleanPropertyFromNode(node,'DeathBeneficiaryHasTFN');
  SetBooleanPropertyFromNode(node,'IsPayEntitled');
  SetBooleanPropertyFromNode(node,'IsETPEntitled');
  SetBooleanPropertyFromNode(node,'IsManualLongService');
  SetBooleanPropertyFromNode(node,'IsManualAnnualLeave');
  SetPropertyFromNode(node,'OtherPaymentType');
  SetPropertyFromNode(node,'LongServicePre16081978');
  SetPropertyFromNode(node,'LongServicePost16081978');
  SetPropertyFromNode(node,'LongServicePost17081993');
  SetPropertyFromNode(node,'AnnualLeavePre18081993');
  SetPropertyFromNode(node,'AnnualLeavePost17081993');
  SetPropertyFromNode(node,'AnnLeaveLoadingPre18081993');
  SetPropertyFromNode(node,'AnnLeaveLoadingPost17081993');
  SetPropertyFromNode(node,'OtherPaymentAmount');
  SetPropertyFromNode(node,'ETPEarlyRetirement');
  SetPropertyFromNode(node,'ETPRedundancy');
  SetPropertyFromNode(node,'ETPInvalidity');
  SetPropertyFromNode(node,'ETPUnusedRDOs');
  SetPropertyFromNode(node,'ETPDeath');
  SetPropertyFromNode(node,'ETPPayInLieu');
  SetPropertyFromNode(node,'ETPGoldenHandshake');
  SetPropertyFromNode(node,'ETPJobLossComp');
  SetPropertyFromNode(node,'ETPUnusedSick');
  SetPropertyFromNode(node,'ETPOther');
  SetPropertyFromNode(node,'ETPTotal');
  SetPropertyFromNode(node,'ETPRollover');
  SetPropertyFromNode(node,'Gross');
  SetPropertyFromNode(node,'Tax');
  SetPropertyFromNode(node,'Net');
  SetPropertyFromNode(node,'TotalLumpSums');
  SetPropertyFromNode(node,'PayID');
  SetPropertyFromNode(node,'LumpSumC');
  SetBooleanPropertyFromNode(node,'Deleted');
  SetPropertyFromNode(node,'PayGross');
  SetPropertyFromNode(node,'ETPpost061983taxed');
  SetBooleanPropertyFromNode(node,'Complete');
  SetPropertyFromNode(node,'Data');
end;


procedure TTerminationSimple.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'StartDate' ,StartDate);
  AddXMLNode(node,'EndDate' ,EndDate);
  AddXMLNode(node,'DaysServicePre01071983' ,DaysServicePre01071983);
  AddXMLNode(node,'DaysServicePost30061983' ,DaysServicePost30061983);
  AddXMLNode(node,'ETPpre071983' ,ETPpre071983);
  AddXMLNode(node,'ETPpost061983Untaxed' ,ETPpost061983Untaxed);
  AddXMLNode(node,'ETPtaxfree' ,ETPtaxfree);
  AddXMLNode(node,'ETPpost061994Component' ,ETPpost061994Component);
  AddXMLNode(node,'GrossTermination' ,GrossTermination);
  AddXMLNode(node,'TaxWithheld' ,TaxWithheld);
  AddXMLNode(node,'ETPAssessable' ,ETPAssessable);
  AddXMLNode(node,'DeathBenefit' ,DeathBenefit);
  AddXMLNode(node,'TypeOfDeathBenefit' ,TypeOfDeathBenefit);
  AddXMLNode(node,'LumpSumA' ,LumpSumA);
  AddXMLNode(node,'LumpSumB' ,LumpSumB);
  AddXMLNode(node,'LumpSumD' ,LumpSumD);
  AddXMLNode(node,'LumpSumE' ,LumpSumE);
  AddXMLNode(node,'ReasonLeft' ,ReasonLeft);
  AddXMLNode(node,'GrossETP' ,GrossETP);
  AddXMLNode(node,'CDEP' ,CDEP);
  AddXMLNode(node,'ReportableFB' ,ReportableFB);
  AddXMLNode(node,'TotalAllowances' ,TotalAllowances);
  AddXMLNode(node,'DeathBeneficiaryHasTFN' ,DeathBeneficiaryHasTFN);
  AddXMLNode(node,'IsPayEntitled' ,IsPayEntitled);
  AddXMLNode(node,'IsETPEntitled' ,IsETPEntitled);
  AddXMLNode(node,'IsManualLongService' ,IsManualLongService);
  AddXMLNode(node,'IsManualAnnualLeave' ,IsManualAnnualLeave);
  AddXMLNode(node,'OtherPaymentType' ,OtherPaymentType);
  AddXMLNode(node,'LongServicePre16081978' ,LongServicePre16081978);
  AddXMLNode(node,'LongServicePost16081978' ,LongServicePost16081978);
  AddXMLNode(node,'LongServicePost17081993' ,LongServicePost17081993);
  AddXMLNode(node,'AnnualLeavePre18081993' ,AnnualLeavePre18081993);
  AddXMLNode(node,'AnnualLeavePost17081993' ,AnnualLeavePost17081993);
  AddXMLNode(node,'AnnLeaveLoadingPre18081993' ,AnnLeaveLoadingPre18081993);
  AddXMLNode(node,'AnnLeaveLoadingPost17081993' ,AnnLeaveLoadingPost17081993);
  AddXMLNode(node,'OtherPaymentAmount' ,OtherPaymentAmount);
  AddXMLNode(node,'ETPEarlyRetirement' ,ETPEarlyRetirement);
  AddXMLNode(node,'ETPRedundancy' ,ETPRedundancy);
  AddXMLNode(node,'ETPInvalidity' ,ETPInvalidity);
  AddXMLNode(node,'ETPUnusedRDOs' ,ETPUnusedRDOs);
  AddXMLNode(node,'ETPDeath' ,ETPDeath);
  AddXMLNode(node,'ETPPayInLieu' ,ETPPayInLieu);
  AddXMLNode(node,'ETPGoldenHandshake' ,ETPGoldenHandshake);
  AddXMLNode(node,'ETPJobLossComp' ,ETPJobLossComp);
  AddXMLNode(node,'ETPUnusedSick' ,ETPUnusedSick);
  AddXMLNode(node,'ETPOther' ,ETPOther);
  AddXMLNode(node,'ETPTotal' ,ETPTotal);
  AddXMLNode(node,'ETPRollover' ,ETPRollover);
  AddXMLNode(node,'Gross' ,Gross);
  AddXMLNode(node,'Tax' ,Tax);
  AddXMLNode(node,'Net' ,Net);
  AddXMLNode(node,'TotalLumpSums' ,TotalLumpSums);
  AddXMLNode(node,'PayID' ,PayID);
  AddXMLNode(node,'LumpSumC' ,LumpSumC);
  AddXMLNode(node,'Deleted' ,Deleted);
  AddXMLNode(node,'PayGross' ,PayGross);
  AddXMLNode(node,'ETPpost061983taxed' ,ETPpost061983taxed);
  AddXMLNode(node,'Complete' ,Complete);
  AddXMLNode(node,'Data' ,Data);
end;


function TTerminationSimple.ValidateData: Boolean ;
begin
  Result := False;
//  Resultstatus.Clear;
  if self.PayID = 0 then begin
    AddResult(false,rssWarning,0,'Pay ID is blank.');
    exit;
  end;
  if ETPCode = '' then begin
    AddResult(false,rssWarning,0,'Termination Code is blank.');
    exit;
  end;
  Result := True;
end;


function TTerminationSimple.Save: Boolean ;
begin
  Data := DataObj.AsString;
  PostDb;
  if Count = 0 then begin
    result := true;
    exit;
  end;
  Result := False;
  if not ValidateData then Exit;

  Result := inherited Save;
end;


procedure TTerminationSimple.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTerminationSimple.DoFieldOnChange(Sender: TField);
begin
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  inherited;
   if Sysutils.SameText(Sender.FieldName , 'LumpSumD') then begin
     if Assigned(Owner) and (Owner is Tpaybase) then begin
       PostDb;
       Tpaybase(Owner).RecalcAll;

     end;
   end;
end;


function TTerminationSimple.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTerminationSimple.GetIDField: string;
begin
  Result := 'TerminationID'
end;


class function TTerminationSimple.GetBusObjectTablename: string;
begin
  Result:= 'tblemployeeterminations';
end;


function TTerminationSimple.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is Tpaybase) then begin
    Self.PayID := Tpaybase(Owner).PayID;
    Self.EmployeeID := Tpaybase(Owner).Employeeid;
    self.EmployeeName := Tpaybase(Owner).Empname;
    self.ReasonLeft := 'Termination';
//    self.LumpSumD := 0;
  end;
end;

function TTerminationSimple.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TTerminationSimple.GetETPName                             : string    ; begin Result := GetStringField('ETPName');end;
function  TTerminationSimple.GetETPDisplayName                      : string    ; begin Result := GetStringField('ETPDisplayName');end;
function  TTerminationSimple.GetETPRateType                         : string    ; begin Result := GetStringField('ETPRateType');end;
function  TTerminationSimple.GetETPExpenseAccount                   : string    ; begin Result := GetStringField('ETPExpenseAccount');end;
function  TTerminationSimple.GetETPExemptPaygWithholding            : Boolean   ; begin Result := GetBooleanField('ETPExemptPaygWithholding');end;
function  TTerminationSimple.GetETPExemptSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('ETPExemptSuperannuationGuaranteeCont');end;
function  TTerminationSimple.GetETPReportableW1onActivityStatement  : Boolean   ; begin Result := GetBooleanField('ETPReportableW1onActivityStatement');end;
function  TTerminationSimple.GetETPActive                           : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TTerminationSimple.SetETPName                             (const Value: string    ); begin SetStringField('ETPName'                              , Value);end;
procedure TTerminationSimple.SetETPDisplayName                      (const Value: string    ); begin SetStringField('ETPDisplayName'                       , Value);end;
procedure TTerminationSimple.SetETPRateType                         (const Value: string    ); begin SetStringField('ETPRateType'                          , Value);end;
procedure TTerminationSimple.SetETPExpenseAccount                   (const Value: string    ); begin SetStringField('ETPExpenseAccount'                    , Value);end;
procedure TTerminationSimple.SetETPExemptPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('ETPExemptPaygWithholding'             , Value);end;
procedure TTerminationSimple.SetETPExemptSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('ETPExemptSuperannuationGuaranteeCont' , Value);end;
procedure TTerminationSimple.SetETPReportableW1onActivityStatement  (const Value: Boolean   ); begin SetBooleanField('ETPReportableW1onActivityStatement'   , Value);end;
procedure TTerminationSimple.SetETPActive                           (const Value: Boolean   ); begin SetBooleanField('Active'                            , Value);end;


function  TTerminationSimple.GetEmployeeID                 : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TTerminationSimple.GetEmployeeName               : string    ; begin Result := GetStringField('EmployeeName');end;
function  TTerminationSimple.GetStartDate                  : TDateTime ; begin Result := GetDateTimeField('StartDate');end;
function  TTerminationSimple.GetEndDate                    : TDateTime ; begin Result := GetDateTimeField('EndDate');end;
function  TTerminationSimple.GetDaysServicePre01071983     : Integer   ; begin Result := GetIntegerField('DaysServicePre01071983');end;
function  TTerminationSimple.GetDaysServicePost30061983    : Integer   ; begin Result := GetIntegerField('DaysServicePost30061983');end;
function  TTerminationSimple.GetETPpre071983               : Double    ; begin Result := GetFloatField('ETPpre071983');end;
function  TTerminationSimple.GetETPpost061983Untaxed       : Double    ; begin Result := GetFloatField('ETPpost061983Untaxed');end;
function  TTerminationSimple.GetETPtaxfree                 : Double    ; begin Result := GetFloatField('ETPtaxfree');end;
function  TTerminationSimple.GetETPpost061994Component     : Double    ; begin Result := GetFloatField('ETPpost061994Component');end;
function  TTerminationSimple.GetGrossTermination           : Double    ; begin Result := GetFloatField('GrossTermination');end;
function  TTerminationSimple.GetTaxWithheld                : Double    ; begin Result := GetFloatField('TaxWithheld');end;
function  TTerminationSimple.GetETPAssessable              : Double    ; begin Result := GetFloatField('ETPAssessable');end;
function TTerminationSimple.GetETPCode: string;
begin
  result := GetStringField('ETPCode');
end;

function  TTerminationSimple.GetDeathBenefit               : Boolean   ; begin Result := GetBooleanField('DeathBenefit');end;
function  TTerminationSimple.GetTypeOfDeathBenefit         : string    ; begin Result := GetStringField('TypeOfDeathBenefit');end;
function  TTerminationSimple.GetLumpSumA                   : Double    ; begin Result := GetFloatField('LumpSumA');end;
function  TTerminationSimple.GetLumpSumB                   : Double    ; begin Result := GetFloatField('LumpSumB');end;
function  TTerminationSimple.GetLumpSumD                   : Double    ; begin Result := GetFloatField('LumpSumD');end;
function  TTerminationSimple.GetLumpSumE                   : Double    ; begin Result := GetFloatField('LumpSumE');end;
function  TTerminationSimple.GetReasonLeft                 : string    ; begin Result := GetStringField('ReasonLeft');end;
function  TTerminationSimple.GetGrossETP                   : Double    ; begin Result := GetFloatField('GrossETP');end;
function  TTerminationSimple.GetCDEP                       : Double    ; begin Result := GetFloatField('CDEP');end;
function  TTerminationSimple.GetReportableFB               : Double    ; begin Result := GetFloatField('ReportableFB');end;
function  TTerminationSimple.GetTotalAllowances            : Double    ; begin Result := GetFloatField('TotalAllowances');end;
function  TTerminationSimple.GetDeathBeneficiaryHasTFN     : Boolean   ; begin Result := GetBooleanField('DeathBeneficiaryHasTFN');end;
function  TTerminationSimple.GetIsPayEntitled              : Boolean   ; begin Result := GetBooleanField('IsPayEntitled');end;
function  TTerminationSimple.GetIsETPEntitled              : Boolean   ; begin Result := GetBooleanField('IsETPEntitled');end;
function  TTerminationSimple.GetIsManualLongService        : Boolean   ; begin Result := GetBooleanField('IsManualLongService');end;
function  TTerminationSimple.GetIsManualAnnualLeave        : Boolean   ; begin Result := GetBooleanField('IsManualAnnualLeave');end;
function  TTerminationSimple.GetOtherPaymentType           : string    ; begin Result := GetStringField('OtherPaymentType');end;
function  TTerminationSimple.GetLongServicePre16081978     : Double    ; begin Result := GetFloatField('LongServicePre16081978');end;
function  TTerminationSimple.GetLongServicePost16081978    : Double    ; begin Result := GetFloatField('LongServicePost16081978');end;
function  TTerminationSimple.GetLongServicePost17081993    : Double    ; begin Result := GetFloatField('LongServicePost17081993');end;
function  TTerminationSimple.GetAnnualLeavePre18081993     : Double    ; begin Result := GetFloatField('AnnualLeavePre18081993');end;
function  TTerminationSimple.GetAnnualLeavePost17081993    : Double    ; begin Result := GetFloatField('AnnualLeavePost17081993');end;
function  TTerminationSimple.GetAnnLeaveLoadingPre18081993 : Double    ; begin Result := GetFloatField('AnnLeaveLoadingPre18081993');end;
function  TTerminationSimple.GetAnnLeaveLoadingPost17081993: Double    ; begin Result := GetFloatField('AnnLeaveLoadingPost17081993');end;
function  TTerminationSimple.GetOtherPaymentAmount         : Double    ; begin Result := GetFloatField('OtherPaymentAmount');end;
function  TTerminationSimple.GetETPEarlyRetirement         : Double    ; begin Result := GetFloatField('ETPEarlyRetirement');end;
function  TTerminationSimple.GetETPRedundancy              : Double    ; begin Result := GetFloatField('ETPRedundancy');end;
function  TTerminationSimple.GetETPInvalidity              : Double    ; begin Result := GetFloatField('ETPInvalidity');end;
function  TTerminationSimple.GetETPUnusedRDOs              : Double    ; begin Result := GetFloatField('ETPUnusedRDOs');end;
function  TTerminationSimple.GetETPDeath                   : Double    ; begin Result := GetFloatField('ETPDeath');end;
function  TTerminationSimple.GetETPPayInLieu               : Double    ; begin Result := GetFloatField('ETPPayInLieu');end;
function  TTerminationSimple.GetETPGoldenHandshake         : Double    ; begin Result := GetFloatField('ETPGoldenHandshake');end;
function  TTerminationSimple.GetETPJobLossComp             : Double    ; begin Result := GetFloatField('ETPJobLossComp');end;
function  TTerminationSimple.GetETPUnusedSick              : Double    ; begin Result := GetFloatField('ETPUnusedSick');end;
function  TTerminationSimple.GetETPOther                   : Double    ; begin Result := GetFloatField('ETPOther');end;
function  TTerminationSimple.GetETPTotal                   : Double    ; begin Result := GetFloatField('ETPTotal');end;
function  TTerminationSimple.GetETPRollover                : Double    ; begin Result := GetFloatField('ETPRollover');end;
function  TTerminationSimple.GetGross                      : Double    ; begin Result := GetFloatField('Gross');end;
function  TTerminationSimple.GetTax                        : Double    ; begin Result := GetFloatField('Tax');end;
function  TTerminationSimple.GetNet                        : Double    ; begin Result := GetFloatField('Net');end;
function  TTerminationSimple.GetTotalLumpSums              : Double    ; begin Result := GetFloatField('TotalLumpSums');end;
function  TTerminationSimple.GetPayID                      : Integer   ; begin Result := GetIntegerField('PayID');end;
function  TTerminationSimple.GetLumpSumC                   : Double    ; begin Result := GetFloatField('LumpSumC');end;
function  TTerminationSimple.GetDeleted                    : Boolean   ; begin Result := GetBooleanField('Deleted');end;
function  TTerminationSimple.GetPayGross                   : Double    ; begin Result := GetFloatField('PayGross');end;
function  TTerminationSimple.GetETPpost061983taxed         : Double    ; begin Result := GetFloatField('ETPpost061983taxed');end;
function  TTerminationSimple.GetComplete                   : Boolean   ; begin Result := GetBooleanField('Complete');end;
function  TTerminationSimple.GetData                       : string    ; begin Result := GetStringField('Data');end;
procedure TTerminationSimple.SetEmployeeID                 (const Value: Integer   ); begin SetIntegerField('EmployeeID'                  , Value);end;
procedure TTerminationSimple.SetEmployeeName               (const Value: string    ); begin SetStringField('EmployeeName'                , Value);end;
procedure TTerminationSimple.SetStartDate                  (const Value: TDateTime ); begin SetDateTimeField('StartDate'                   , Value);end;
procedure TTerminationSimple.SetEndDate                    (const Value: TDateTime ); begin SetDateTimeField('EndDate'                     , Value);end;
procedure TTerminationSimple.SetDaysServicePre01071983     (const Value: Integer   ); begin SetIntegerField('DaysServicePre01071983'      , Value);end;
procedure TTerminationSimple.SetDaysServicePost30061983    (const Value: Integer   ); begin SetIntegerField('DaysServicePost30061983'     , Value);end;
procedure TTerminationSimple.SetETPpre071983               (const Value: Double    ); begin SetFloatField('ETPpre071983'                , Value);end;
procedure TTerminationSimple.SetETPpost061983Untaxed       (const Value: Double    ); begin SetFloatField('ETPpost061983Untaxed'        , Value);end;
procedure TTerminationSimple.SetETPtaxfree                 (const Value: Double    ); begin SetFloatField('ETPtaxfree'                  , Value);end;
procedure TTerminationSimple.SetETPpost061994Component     (const Value: Double    ); begin SetFloatField('ETPpost061994Component'      , Value);end;
procedure TTerminationSimple.SetGrossTermination           (const Value: Double    ); begin SetFloatField('GrossTermination'            , Value);end;
procedure TTerminationSimple.SetTaxWithheld                (const Value: Double    ); begin SetFloatField('TaxWithheld'                 , Value);end;
procedure TTerminationSimple.SetETPAssessable              (const Value: Double    ); begin SetFloatField('ETPAssessable'               , Value);end;
procedure TTerminationSimple.SetETPCode(const Value: string);
begin
  SetStringField('ETPCode', Value);
end;

procedure TTerminationSimple.SetDeathBenefit               (const Value: Boolean   ); begin SetBooleanField('DeathBenefit'                , Value);end;
procedure TTerminationSimple.SetTypeOfDeathBenefit         (const Value: string    ); begin SetStringField('TypeOfDeathBenefit'          , Value);end;
procedure TTerminationSimple.SetLumpSumA                   (const Value: Double    ); begin SetFloatField('LumpSumA'                    , Value);end;
procedure TTerminationSimple.SetLumpSumB                   (const Value: Double    ); begin SetFloatField('LumpSumB'                    , Value);end;
procedure TTerminationSimple.SetLumpSumD                   (const Value: Double    ); begin SetFloatField('LumpSumD'                    , Value);end;
procedure TTerminationSimple.SetLumpSumE                   (const Value: Double    ); begin SetFloatField('LumpSumE'                    , Value);end;
procedure TTerminationSimple.SetReasonLeft                 (const Value: string    ); begin SetStringField('ReasonLeft'                  , Value);end;
procedure TTerminationSimple.SetGrossETP                   (const Value: Double    ); begin SetFloatField('GrossETP'                    , Value);end;
procedure TTerminationSimple.SetCDEP                       (const Value: Double    ); begin SetFloatField('CDEP'                        , Value);end;
procedure TTerminationSimple.SetReportableFB               (const Value: Double    ); begin SetFloatField('ReportableFB'                , Value);end;
procedure TTerminationSimple.SetTotalAllowances            (const Value: Double    ); begin SetFloatField('TotalAllowances'             , Value);end;
procedure TTerminationSimple.SetDeathBeneficiaryHasTFN     (const Value: Boolean   ); begin SetBooleanField('DeathBeneficiaryHasTFN'      , Value);end;
procedure TTerminationSimple.SetIsPayEntitled              (const Value: Boolean   ); begin SetBooleanField('IsPayEntitled'               , Value);end;
procedure TTerminationSimple.SetIsETPEntitled              (const Value: Boolean   ); begin SetBooleanField('IsETPEntitled'               , Value);end;
procedure TTerminationSimple.SetIsManualLongService        (const Value: Boolean   ); begin SetBooleanField('IsManualLongService'         , Value);end;
procedure TTerminationSimple.SetIsManualAnnualLeave        (const Value: Boolean   ); begin SetBooleanField('IsManualAnnualLeave'         , Value);end;
procedure TTerminationSimple.SetOtherPaymentType           (const Value: string    ); begin SetStringField('OtherPaymentType'            , Value);end;
procedure TTerminationSimple.SetLongServicePre16081978     (const Value: Double    ); begin SetFloatField('LongServicePre16081978'      , Value);end;
procedure TTerminationSimple.SetLongServicePost16081978    (const Value: Double    ); begin SetFloatField('LongServicePost16081978'     , Value);end;
procedure TTerminationSimple.SetLongServicePost17081993    (const Value: Double    ); begin SetFloatField('LongServicePost17081993'     , Value);end;
procedure TTerminationSimple.SetAnnualLeavePre18081993     (const Value: Double    ); begin SetFloatField('AnnualLeavePre18081993'      , Value);end;
procedure TTerminationSimple.SetAnnualLeavePost17081993    (const Value: Double    ); begin SetFloatField('AnnualLeavePost17081993'     , Value);end;
procedure TTerminationSimple.SetAnnLeaveLoadingPre18081993 (const Value: Double    ); begin SetFloatField('AnnLeaveLoadingPre18081993' , Value);end;
procedure TTerminationSimple.SetAnnLeaveLoadingPost17081993(const Value: Double    ); begin SetFloatField('AnnLeaveLoadingPost17081993' , Value);end;
procedure TTerminationSimple.SetOtherPaymentAmount         (const Value: Double    ); begin SetFloatField('OtherPaymentAmount'          , Value);end;
procedure TTerminationSimple.SetETPEarlyRetirement         (const Value: Double    ); begin SetFloatField('ETPEarlyRetirement'          , Value);end;
procedure TTerminationSimple.SetETPRedundancy              (const Value: Double    ); begin SetFloatField('ETPRedundancy'               , Value);end;
procedure TTerminationSimple.SetETPInvalidity              (const Value: Double    ); begin SetFloatField('ETPInvalidity'               , Value);end;
procedure TTerminationSimple.SetETPUnusedRDOs              (const Value: Double    ); begin SetFloatField('ETPUnusedRDOs'               , Value);end;
procedure TTerminationSimple.SetETPDeath                   (const Value: Double    ); begin SetFloatField('ETPDeath'                    , Value);end;
procedure TTerminationSimple.SetETPPayInLieu               (const Value: Double    ); begin SetFloatField('ETPPayInLieu'                , Value);end;
procedure TTerminationSimple.SetETPGoldenHandshake         (const Value: Double    ); begin SetFloatField('ETPGoldenHandshake'          , Value);end;
procedure TTerminationSimple.SetETPJobLossComp             (const Value: Double    ); begin SetFloatField('ETPJobLossComp'              , Value);end;
procedure TTerminationSimple.SetETPUnusedSick              (const Value: Double    ); begin SetFloatField('ETPUnusedSick'               , Value);end;
procedure TTerminationSimple.SetETPOther                   (const Value: Double    ); begin SetFloatField('ETPOther'                    , Value);end;
procedure TTerminationSimple.SetETPTotal                   (const Value: Double    ); begin SetFloatField('ETPTotal'                    , Value);end;
procedure TTerminationSimple.SetETPRollover                (const Value: Double    ); begin SetFloatField('ETPRollover'                 , Value);end;
procedure TTerminationSimple.SetGross                      (const Value: Double    ); begin SetFloatField('Gross'                       , Value);end;
procedure TTerminationSimple.SetTax                        (const Value: Double    ); begin SetFloatField('Tax'                         , Value);end;
procedure TTerminationSimple.SetNet                        (const Value: Double    ); begin SetFloatField('Net'                         , Value);end;
procedure TTerminationSimple.SetTotalLumpSums              (const Value: Double    ); begin SetFloatField('TotalLumpSums'               , Value);end;
procedure TTerminationSimple.SetPayID                      (const Value: Integer   ); begin SetIntegerField('PayID'                       , Value);end;
procedure TTerminationSimple.SetLumpSumC                   (const Value: Double    ); begin SetFloatField('LumpSumC'                    , Value);end;
procedure TTerminationSimple.SetDeleted                    (const Value: Boolean   ); begin SetBooleanField('Deleted'                     , Value);end;
procedure TTerminationSimple.SetPayGross                   (const Value: Double    ); begin SetFloatField('PayGross'                    , Value);end;
procedure TTerminationSimple.SetETPpost061983taxed         (const Value: Double    ); begin SetFloatField('ETPpost061983taxed'          , Value);end;
procedure TTerminationSimple.SetComplete                   (const Value: Boolean   ); begin SetBooleanField('Complete'                    , Value);end;
procedure TTerminationSimple.SetData                       (const Value: string    ); begin SetStringField('Data'                        , Value);end;


initialization
  RegisterClass(TTerminationSimple);


end.
