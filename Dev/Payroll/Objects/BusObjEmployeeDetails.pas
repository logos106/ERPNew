unit BusObjEmployeeDetails;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   03/04/07   1.00.01   A   Initial Version.
   }


interface
{$I ERP.inc}

uses BusObjBase, BusObjEmployee, BusObjTaxScales,  DB, Classes, XMLDoc, XMLIntf;


type
   TEmployeeDetails = class(TEmployee)
   private
      Function GetOptionno                       :Integer   ;
      Function GetTax                            :Double    ;
      Function GetGross                          :Double    ;
      Function GetNet                            :Double    ;
      Function GetWages                          :Double    ;
      Function GetCommission                     :Double    ;
      Function GetDeductions                     :Double    ;
      Function GetAllowances                     :Double    ;
      Function GetSundries                       :Double    ;
      Function GetSuper                          :Double    ;
      Function GetCdeproject                     :Boolean   ;
      Function GetFringebenefits                 :Double    ;
      Function GetDayspre01071983                :Integer   ;
      Function GetDayspost30061983               :Integer   ;
      Function GetCgtexempt                      :Double    ;
      Function GetNonqualifyingcomponent         :Double    ;
      Function GetUndeductedcontribution         :Double    ;
      Function GetConcessionalcomponent          :Double    ;
      Function GetRepcode                        :String    ;
      Function GetResident                       :Boolean   ;
      Function GetTfnapplicationmade             :Boolean   ;
      Function GetUnder18                        :Boolean   ;
      Function GetPensioner                      :Boolean   ;
      Function GetIncometype                     :Boolean   ;
      Function GetBasisofpayment                 :String   ;
      Function GetTaxfreethreshold               :Boolean   ;
      Function GetFamilytaxbenefit               :Boolean   ;
      Function GetZonedependentspecial           :Boolean   ;
      Function GetHecsindicator                  :Boolean   ;
      Function GetHecsTaxScale                   :Integer   ;
      Function GetStudentloanindicator           :Boolean   ;
      Function GetStudentLoanTaxScale            :Integer   ;
      Function GetUseoftfnforsuper               :Boolean   ;
      Function GetAnnuitysuperpension            :Boolean   ;
      Function GetSignaturepresent               :Boolean   ;
      Function GetDatesigned                     :TDatetime ;
      Function GetPayvia                         :Boolean   ;
      Function GetReportsto                      :Integer   ;
      Function GetPayperiod                      :String    ;
      Function GetAward                          :Integer   ;
      Function GetClassification                 :String    ;
      Function GetWorkerscompinsurer             :Integer   ;
      Function GetUseaward                       :Boolean   ;
      Function GetNextofkin                      :String    ;
      Function GetNextofkinrelationship          :String    ;
      Function GetNextofkinphone                 :String    ;
      Function GetTaxscaleid                     :Integer   ;
      Function GetLeaveloading                   :Double    ;
      Function GetSickhours                      :Double    ;
      Function GetAlhours                        :Double    ;
      Function GetLastpaid                       :TDatetime ;
      Function GetLastpayperiod                  :Integer   ;
      Function GetCommissiononvalue              :String    ;
      Function GetIsCommissiononpaidInvoice      :Boolean   ;
      Function GetCommissionlastpaid             :TDatetime ;
      Function GetPaynotes                       :String    ;
      Function GetIsontheroster                  :Boolean   ;
      Function GetonPMRoster                     :Boolean   ;
      Function GetLoadhoursfromroster            :Boolean   ;
      Function GetLoadleavefromroster            :Boolean   ;
      Function GetMealbreakhours                 :Double    ;
      Function GetMealbreakthreshold             :Double    ;
      Function GetArearange                      :String    ;
      Function GetPhotoidvaildfromdate           :TDatetime ;
      Function GetPhotoidvaildtodate             :TDatetime ;
      Function GetCdepwagetotal                  :Double    ;
      Function GetIsterminated                   :Boolean   ;
      Function GetExtrataxoptions                :String    ;
      Function GetExtratax                       :Double    ;
      Function GetUseclassificationadvance       :Boolean   ;

      Function GetCommissionflatrate             :Double    ;

      Function GetCommissioninvoiceexprice       :Boolean   ;
      Function GetEmployeeHasCommission          :Boolean   ;
      Function GetProductHascommission           :Boolean   ;
      Function GetPaysuperonleaveloading         :Boolean   ;
      Function GetDefaultinvoicetemplateid       :Integer   ;
      Function GetSalestarget                    :Double    ;
      Function GetSendpayslipviaemail            :String   ;
      Function GetWorkersCompRate                :double   ;
      Procedure SetOptionno                       (Const Value :Integer   );
      Procedure SetTax                            (Const Value :Double    );
      Procedure SetGross                          (Const Value :Double    );
      Procedure SetNet                            (Const Value :Double    );
      Procedure SetWages                          (Const Value :Double    );
      Procedure SetCommission                     (Const Value :Double    );
      Procedure SetDeductions                     (Const Value :Double    );
      Procedure SetAllowances                     (Const Value :Double    );
      Procedure SetSundries                       (Const Value :Double    );
      Procedure SetSuper                          (Const Value :Double    );
      Procedure SetWorkersCompRate                (Const Value :Double    );

      Procedure SetCdeproject                     (Const Value :Boolean   );

      Procedure SetFringebenefits                 (Const Value :Double    );
      Procedure SetDayspre01071983                (Const Value :Integer   );
      Procedure SetDayspost30061983               (Const Value :Integer   );
      Procedure SetCgtexempt                      (Const Value :Double    );
      Procedure SetNonqualifyingcomponent         (Const Value :Double    );
      Procedure SetUndeductedcontribution         (Const Value :Double    );
      Procedure SetConcessionalcomponent          (Const Value :Double    );

      Procedure SetRepcode                        (Const Value :String    );
      Procedure SetResident                       (Const Value :Boolean   );
      Procedure SetTfnapplicationmade             (Const Value :Boolean   );
      Procedure SetUnder18                        (Const Value :Boolean   );
      Procedure SetPensioner                      (Const Value :Boolean   );
      Procedure SetIncometype                     (Const Value :Boolean   );
      Procedure SetBasisofpayment                 (Const Value :String   );
      Procedure SetTaxfreethreshold               (Const Value :Boolean   );
      Procedure SetFamilytaxbenefit               (Const Value :Boolean   );
      Procedure SetZonedependentspecial           (Const Value :Boolean   );
      Procedure SetHecsindicator                  (Const Value :Boolean   );
      Procedure SetHecsTaxScale                   (Const Value :Integer   );
      Procedure SetStudentloanindicator           (Const Value :Boolean   );
      Procedure SetStudentloanTaxScale                   (Const Value :Integer   );
      Procedure SetUseoftfnforsuper               (Const Value :Boolean   );
      Procedure SetAnnuitysuperpension            (Const Value :Boolean   );
      Procedure SetSignaturepresent               (Const Value :Boolean   );
      Procedure SetDatesigned                     (Const Value :TDatetime );
      Procedure SetPayvia                         (Const Value :Boolean   );
      Procedure SetReportsto                      (Const Value :Integer   );
      Procedure SetPayperiod                      (Const Value :String    );
      Procedure SetAward                          (Const Value :Integer   );
      Procedure SetClassification                 (Const Value :String    );
      Procedure SetWorkerscompinsurer             (Const Value :Integer   );
      Procedure SetUseaward                       (Const Value :Boolean   );
      Procedure SetNextofkin                      (Const Value :String    );
      Procedure SetNextofkinrelationship          (Const Value :String    );
      Procedure SetNextofkinphone                 (Const Value :String    );
      Procedure SetTaxscaleid                     (Const Value :Integer   );
      Procedure SetLeaveloading                   (Const Value :Double    );
      Procedure SetSickhours                      (Const Value :Double    );
      Procedure SetAlhours                        (Const Value :Double    );
      Procedure SetLastpaid                       (Const Value :TDatetime );
      Procedure SetLastpayperiod                  (Const Value :Integer   );
      Procedure SetCommissiononvalue              (Const Value :String    );
      Procedure SetIsCommissiononpaidInvoice      (Const Value :Boolean   );
      Procedure SetCommissionlastpaid             (Const Value :TDatetime );
      Procedure SetPaynotes                       (Const Value :String    );
      Procedure SetIsontheroster                  (Const Value :Boolean   );
      Procedure SetonPMRoster                     (Const Value :Boolean   );
      Procedure SetLoadhoursfromroster            (Const Value :Boolean   );
      Procedure SetLoadleavefromroster            (Const Value :Boolean   );
      Procedure SetMealbreakhours                 (Const Value :Double    );
      Procedure SetMealbreakthreshold             (Const Value :Double    );
      Procedure SetArearange                      (Const Value :String    );
      Procedure SetPhotoidvaildfromdate           (Const Value :TDatetime );
      Procedure SetPhotoidvaildtodate             (Const Value :TDatetime );
      Procedure SetCdepwagetotal                  (Const Value :Double    );
      Procedure SetIsterminated                   (Const Value :Boolean   );
      Procedure SetExtrataxoptions                (Const Value :String    );
      Procedure SetExtratax                       (Const Value :Double    );
      Procedure SetUseclassificationadvance       (Const Value :Boolean   );
      Procedure SetCommissionflatrate             (Const Value :Double    );
      Procedure SetCommissioninvoiceexprice       (Const Value :Boolean   );
      Procedure SetEmployeeHasCommission          (Const Value :Boolean   );
      Procedure SetProductHascommission           (Const Value :Boolean   );
      Procedure SetPaysuperonleaveloading         (Const Value :Boolean   );
      Procedure SetDefaultinvoicetemplateid       (Const Value :Integer   );
      Procedure SetSalestarget                    (Const Value :Double    );
      Procedure SetSendpayslipviaemail            (Const Value :String   );
      function getCommissionOn: String;
      procedure setCommissionOn(const Value: String);
      function getOverheadbaserate: Double;
      procedure setOverheadbaserate(const Value: Double);
      function getCallPriority: Integer;
      procedure setCallPriority(const Value: Integer);
      function getDefaultContactMethod: String;
      procedure setDefaultContactMethod(const Value: String);
      function getEmployeeAddress: String;
      function getOverheadRate: double;
      procedure SetOverheadRate(const Value: double);
      function TaxScaleSelected: boolean;


   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;


   Public
      Constructor  Create(AOwner: TComponent);                             override;
      function    GetId: Integer; override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

      function GetTaxScale: TTaxScales;




      Property EmployeeAddress:String read getEmployeeAddress;




   published
      Property OptionNo                        :integer      Read getOptionno                     Write SetOptionno                 ;
      Property Tax                             :Double       Read getTax                          Write SetTax                      ;
      Property Gross                           :Double       Read getGross                        Write SetGross                    ;
      Property Net                             :Double       Read getNet                          Write SetNet                      ;
      Property Wages                           :Double       Read getWages                        Write SetWages                    ;
      Property Commission                      :Double       Read getCommission                   Write SetCommission               ;
      Property Deductions                      :Double       Read getDeductions                   Write SetDeductions               ;
      Property Allowances                      :Double       Read getAllowances                   Write SetAllowances               ;
      Property Sundries                        :Double       Read getSundries                     Write SetSundries                 ;
      Property Super                           :Double       Read getSuper                        Write SetSuper                    ;
      Property CdeProject                      :Boolean      Read getCdeproject                   Write SetCdeproject               ;
      Property FringeBenefits                  :Double       Read getFringebenefits               Write SetFringebenefits           ;
      Property DaysPre01071983                 :Integer      Read getDayspre01071983              Write SetDayspre01071983          ;
      Property DaysPost30061983                :Integer      Read getDayspost30061983             Write SetDayspost30061983         ;
      Property CgtExempt                       :Double       Read getCgtexempt                    Write SetCgtexempt                ;
      Property NonQualifyingComponent          :Double       Read getNonqualifyingcomponent       Write SetNonqualifyingcomponent   ;
      Property UndeductedContribution          :Double       Read getUndeductedcontribution       Write SetUndeductedcontribution   ;
      Property ConcessionalComponent           :Double       Read getConcessionalcomponent        Write SetConcessionalcomponent    ;
      Property RepCode                         :String       Read getRepcode                      Write SetRepcode                  ;
      Property Resident                        :Boolean      Read getResident                     Write SetResident                 ;
      Property TfnApplicationMade              :Boolean      Read getTfnapplicationmade           Write SetTfnapplicationmade       ;
      Property Under18                         :Boolean      Read getUnder18                      Write SetUnder18                  ;
      Property Pensioner                       :Boolean      Read getPensioner                    Write SetPensioner                ;
      Property IncomeType                      :Boolean      Read getIncometype                   Write SetIncometype               ;
      Property BasisOfPayment                  :String       Read getBasisofpayment               Write SetBasisofpayment           ;
      Property TaxFreeThreshold                :Boolean      Read getTaxfreethreshold             Write SetTaxfreethreshold         ;
      Property FamilyTaxBenefit                :Boolean      Read getFamilytaxbenefit             Write SetFamilytaxbenefit         ;
      Property ZoneDependentSpecial            :Boolean      Read getZonedependentspecial         Write SetZonedependentspecial     ;
      Property Hecsindicator                   :Boolean      Read getHecsindicator                Write SetHecsindicator            ;
      Property HecsTaxScale                    :Integer      Read getHecsTaxScale                 Write SetHecsTaxScale             ;
      Property StudentLoanIndicator            :Boolean      Read getStudentloanindicator         Write SetStudentloanindicator     ;
      Property StudentLoanTaxScale             :Integer      Read getStudentloanTaxScale          Write SetStudentloanTaxScale      ;
      Property UseoFtFnForSuper                :Boolean      Read getUseoftfnforsuper             Write SetUseoftfnforsuper         ;
      Property AnnuitySuperPension             :Boolean      Read getAnnuitysuperpension          Write SetAnnuitysuperpension      ;
      Property SignaturePresent                :Boolean      Read getSignaturepresent             Write SetSignaturepresent         ;
      Property DateSigned                      :TDatetime    Read getDatesigned                   Write SetDatesigned               ;
      Property PayVia                          :Boolean      Read getPayvia                       Write SetPayvia                   ;
      Property ReportsTo                       :Integer      Read getReportsto                    Write SetReportsto                ;
      Property Payperiod                       :String       Read getPayperiod                    Write SetPayperiod                ;
      Property Award                           :Integer      Read getAward                        Write SetAward                    ;
      Property Classification                  :String       Read getClassification               Write SetClassification           ;
      Property WorkersCompInsurer              :Integer      Read getWorkerscompinsurer           Write SetWorkerscompinsurer       ;
      Property UseAward                        :Boolean      Read getUseaward                     Write SetUseaward                 ;
      Property NextOfKin                       :String       Read getNextofkin                    Write SetNextofkin                ;
      Property NextOfKinRelationship           :String       Read getNextofkinrelationship        Write SetNextofkinrelationship    ;
      Property NextOfKinPhone                  :String       Read getNextofkinphone               Write SetNextofkinphone           ;
      Property TaxScaleID                      :Integer      Read getTaxscaleid                   Write SetTaxscaleid               ;
      Property LeaveLoading                    :Double       Read getLeaveloading                 Write SetLeaveloading             ;
      Property SickHours                       :Double       Read getSickhours                    Write SetSickhours                ;
      Property AlHours                         :Double       Read getAlhours                      Write SetAlhours                  ;
      Property LastPaid                        :TDatetime    Read getLastpaid                     Write SetLastpaid                 ;
      Property LastPayPeriod                   :Integer      Read getLastpayperiod                Write SetLastpayperiod            ;
      Property CommissionOnValue               :String       Read getCommissiononvalue            Write SetCommissiononvalue        ;
      Property IsCommissionOnPaidInvoice       :Boolean      Read getIsCommissiononpaidInvoice    Write SetIsCommissiononpaidInvoice;
      Property CommissionLastPaid              :TDatetime    Read getCommissionlastpaid           Write SetCommissionlastpaid       ;
      Property PayNotes                        :String       Read getPaynotes                     Write SetPaynotes                 ;
      Property IsOnTheRoster                   :Boolean      Read getIsontheroster                Write SetIsontheroster            ;
      Property onPMRoster                      :Boolean      Read getonPMRoster                   Write SetonPMRoster               ;
      Property LoadHoursFromRoster             :Boolean      Read getLoadhoursfromroster          Write SetLoadhoursfromroster      ;
      Property LoadLeaveFromRoster             :Boolean      Read getLoadleavefromroster          Write SetLoadleavefromroster      ;
      Property MealBreakHours                  :Double       Read getMealbreakhours               Write SetMealbreakhours           ;
      Property MealBreakThreshold              :Double       Read getMealbreakthreshold           Write SetMealbreakthreshold       ;
      Property AreaRange                       :String       Read getArearange                    Write SetArearange                ;
      Property PhotoIDVaildFromDate            :TDatetime    Read getPhotoidvaildfromdate         Write SetPhotoidvaildfromdate     ;
      Property PhotoIDVaildToDate              :TDatetime    Read getPhotoidvaildtodate           Write SetPhotoidvaildtodate       ;
      Property CdepWageTotal                   :Double       Read getCdepwagetotal                Write SetCdepwagetotal            ;
      Property IsTerminated                    :Boolean      Read getIsterminated                 Write SetIsterminated             ;
      Property ExtraTaxOptions                 :String       Read getExtrataxoptions              Write SetExtrataxoptions          ;
      Property ExtraTax                        :Double       Read getExtratax                     Write SetExtratax                 ;
      Property UseClassificationAdvance        :Boolean      Read getUseclassificationadvance     Write SetUseclassificationadvance ;
      Property CommissionFlatRate              :Double       Read getCommissionflatrate           Write SetCommissionflatrate       ;
      Property OverHeadBaseRate                :Double       REad getOverheadbaserate             Write setOverheadbaserate;
      Property CommissionOn                    :String       Read getCommissionOn                 Write setCommissionOn;
      Property CommissionInvoiceExPrice        :Boolean      Read getCommissioninvoiceexprice     Write SetCommissioninvoiceexprice ;
      Property EmployeeHasCommission           :Boolean      Read getEmployeeHasCommission        Write SetEmployeeHasCommission         ;
      Property ProductHasCommission            :Boolean      Read getProductHascommission         Write SetProductHascommission        ;
      Property PaySuperonLeaveLoading          :Boolean      Read getPaysuperonleaveloading       Write SetPaysuperonleaveloading   ;
      Property DefaultInvoiceTemplateID        :Integer      Read getDefaultinvoicetemplateid     Write SetDefaultinvoicetemplateid ;
      Property SalesTarget                     :Double       Read getSalestarget                  Write SetSalestarget              ;
      Property SendPayslipViaEmail             :String       Read getSendpayslipviaemail          Write SetSendpayslipviaemail      ;
      Property WorkersCompRate                 :double       Read getWorkerscompRate              write SetWorkersCompRate          ;
      Property CallPriority                    :Integer      REad getCallPriority                 write setCallPriority;
      Property DefaultContactMethod            :String       Read getDefaultContactMethod         Write setDefaultContactMethod;
      property OverheadRate                    : double      read getOverheadRate                 write SetOverheadRate;
   End;


implementation


uses SysUtils,BusObjConst, CommonLib, BusObjClass,
  {BusobjPersonalPreference,} BusObjectListObj, AppEnvironment, tcTypes,
  ERPDbComponents, DbSharedObjectsObj, Dialogs;


{ Temployeedetails}
constructor Temployeedetails.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
end;


destructor Temployeedetails.Destroy;
begin
   inherited;
end;


function Temployeedetails.GetTaxScale: TTaxScales;
begin

   result := TTaxScales(GetContainerComponent(TTaxScales, 'ScaleID = ' + IntToStr(TaxScaleID)));

end;



procedure   Temployeedetails.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
   SetPropertyFromNode(Node,'Optionno');
   SetPropertyFromNode(Node,'Tax');
   SetPropertyFromNode(Node,'Gross');
   SetPropertyFromNode(Node,'Net');
   SetPropertyFromNode(Node,'Wages');
   SetPropertyFromNode(Node,'Commission');
   SetPropertyFromNode(Node,'Deductions');
   SetPropertyFromNode(Node,'Allowances');
   SetPropertyFromNode(Node,'Sundries');
   SetPropertyFromNode(Node,'Super');

   SetBooleanPropertyFromNode(Node,'Cdeproject');

   SetPropertyFromNode(Node,'Fringebenefits');
   SetPropertyFromNode(Node,'Dayspre01071983');
   SetPropertyFromNode(Node,'Dayspost30061983');
   SetPropertyFromNode(Node,'Cgtexempt');
   SetPropertyFromNode(Node,'Nonqualifyingcomponent');
   SetPropertyFromNode(Node,'Undeductedcontribution');
   SetPropertyFromNode(Node,'Concessionalcomponent');

   SetPropertyFromNode(Node,'Repcode');
   SetBooleanPropertyFromNode(Node,'Resident');
   SetBooleanPropertyFromNode(Node,'Tfnapplicationmade');
   SetBooleanPropertyFromNode(Node,'Under18');
   SetBooleanPropertyFromNode(Node,'Pensioner');
   SetBooleanPropertyFromNode(Node,'Incometype');
   SetPropertyFromNode(Node,'Basisofpayment');
   SetBooleanPropertyFromNode(Node,'Taxfreethreshold');
   SetBooleanPropertyFromNode(Node,'Familytaxbenefit');
   SetBooleanPropertyFromNode(Node,'Zonedependentspecial');
   SetBooleanPropertyFromNode(Node,'Hecsindicator');
   SetPropertyFromNode(Node,'HecsTaxScale');
   SetBooleanPropertyFromNode(Node,'Studentloanindicator');
   SetPropertyFromNode(Node,'StudentloanTaxScale');
   SetBooleanPropertyFromNode(Node,'Useoftfnforsuper');
   SetBooleanPropertyFromNode(Node,'Annuitysuperpension');
   SetBooleanPropertyFromNode(Node,'Signaturepresent');
   SetDateTimePropertyFromNode(Node,'Datesigned');
   SetBooleanPropertyFromNode(Node,'Payvia');
   SetPropertyFromNode(Node,'Reportsto');
   SetPropertyFromNode(Node,'Payperiod');
   SetPropertyFromNode(Node,'Award');
   SetPropertyFromNode(Node,'Classification');
   SetPropertyFromNode(Node,'Workerscompinsurer');
   SetBooleanPropertyFromNode(Node,'Useaward');
   SetPropertyFromNode(Node,'Nextofkin');
   SetPropertyFromNode(Node,'Nextofkinrelationship');
   SetPropertyFromNode(Node,'Nextofkinphone');
   SetPropertyFromNode(Node,'Taxscaleid');
   SetPropertyFromNode(Node,'Leaveloading');
   SetPropertyFromNode(Node,'Sickhours');
   SetPropertyFromNode(Node,'Alhours');
   SetDateTimePropertyFromNode(Node,'Lastpaid');
   SetPropertyFromNode(Node,'Lastpayperiod');
   SetPropertyFromNode(Node,'Commissiononvalue');
   SetBooleanPropertyFromNode(Node,'IsCommissiononpaidInvoice');
   SetDateTimePropertyFromNode(Node,'Commissionlastpaid');
   SetPropertyFromNode(Node,'Paynotes');
   SetBooleanPropertyFromNode(Node,'Isontheroster');
   SetBooleanPropertyFromNode(Node,'onPMRoster');
   SetBooleanPropertyFromNode(Node,'Loadhoursfromroster');
   SetBooleanPropertyFromNode(Node,'Loadleavefromroster');
   SetPropertyFromNode(Node,'Mealbreakhours');
   SetPropertyFromNode(Node,'Mealbreakthreshold');
   SetPropertyFromNode(Node,'Arearange');
   SetDateTimePropertyFromNode(Node,'Photoidvaildfromdate');
   SetDateTimePropertyFromNode(Node,'Photoidvaildtodate');
   SetPropertyFromNode(Node,'Cdepwagetotal');
   SetBooleanPropertyFromNode(Node,'Isterminated');
   SetPropertyFromNode(Node,'Defaultclassname');
   SetPropertyFromNode(Node,'Defaultclassid');
   SetPropertyFromNode(Node,'Extrataxoptions');
   SetPropertyFromNode(Node,'Extratax');
   SetBooleanPropertyFromNode(Node,'Useclassificationadvance');
   SetPropertyFromNode(Node, 'CommissionOn');
   SetPropertyFromNode(Node,'Commissionflatrate');
   SetPropertyFromnode(Node , 'Overheadbaserate');
   SetBooleanPropertyFromNode(Node,'Commissioninvoiceexprice');
   SetBooleanPropertyFromNode(Node,'EmployeeHasCommission');
   SetBooleanPropertyFromNode(Node,'ProductHascommission');
   SetBooleanPropertyFromNode(Node,'Paysuperonleaveloading');
   SetPropertyFromNode(Node,'Defaultinvoicetemplateid');
   SetPropertyFromNode(Node,'Salestarget');
   SetPropertyFromNode(Node,'Sendpayslipviaemail');
   SetPropertyFromNode(Node,'WorkersCompRate');
   SetPropertyFromNode(Node,'CallPriority');
   SetPropertyFromNode(Node,'DefaultContactMethod');
end;


procedure   Temployeedetails.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Optionno' ,Optionno);
      AddXMLNode(node,'Tax' ,Tax);
      AddXMLNode(node,'Gross' ,Gross);
      AddXMLNode(node,'Net' ,Net);
      AddXMLNode(node,'Wages' ,Wages);
      AddXMLNode(node,'Commission' ,Commission);
      AddXMLNode(node,'Deductions' ,Deductions);
      AddXMLNode(node,'Allowances' ,Allowances);
      AddXMLNode(node,'Sundries' ,Sundries);
      AddXMLNode(node,'Super' ,Super);

      AddXMLNode(node,'Cdeproject' ,Cdeproject);

      AddXMLNode(node,'Fringebenefits' ,Fringebenefits);
      AddXMLNode(node,'Dayspre01071983' ,Dayspre01071983);
      AddXMLNode(node,'Dayspost30061983' ,Dayspost30061983);
      AddXMLNode(node,'Cgtexempt' ,Cgtexempt);
      AddXMLNode(node,'Nonqualifyingcomponent' ,Nonqualifyingcomponent);
      AddXMLNode(node,'Undeductedcontribution' ,Undeductedcontribution);
      AddXMLNode(node,'Concessionalcomponent' ,Concessionalcomponent);

      AddXMLNode(node,'Repcode' ,Repcode);
      AddXMLNode(node,'Resident' ,Resident);
      AddXMLNode(node,'Tfnapplicationmade' ,Tfnapplicationmade);
      AddXMLNode(node,'Under18' ,Under18);
      AddXMLNode(node,'Pensioner' ,Pensioner);
      AddXMLNode(node,'Incometype' ,Incometype);
      AddXMLNode(node,'Basisofpayment' ,Basisofpayment);
      AddXMLNode(node,'Taxfreethreshold' ,Taxfreethreshold);
      AddXMLNode(node,'Familytaxbenefit' ,Familytaxbenefit);
      AddXMLNode(node,'Zonedependentspecial' ,Zonedependentspecial);
      AddXMLNode(node,'Hecsindicator' ,Hecsindicator);
      AddXMLNode(node,'HecsTaxScale' ,HecsTaxScale);
      AddXMLNode(node,'Studentloanindicator' ,Studentloanindicator);
      AddXMLNode(node,'StudentloanTaxScale' ,StudentloanTaxScale);
      AddXMLNode(node,'Useoftfnforsuper' ,Useoftfnforsuper);
      AddXMLNode(node,'Annuitysuperpension' ,Annuitysuperpension);
      AddXMLNode(node,'Signaturepresent' ,Signaturepresent);
      AddXMLNode(node,'Datesigned' ,Datesigned);
      AddXMLNode(node,'Payvia' ,Payvia);
      AddXMLNode(node,'Reportsto' ,Reportsto);
      AddXMLNode(node,'Payperiod' ,Payperiod);
      AddXMLNode(node,'Award' ,Award);
      AddXMLNode(node,'Classification' ,Classification);
      AddXMLNode(node,'Workerscompinsurer' ,Workerscompinsurer);
      AddXMLNode(node,'Useaward' ,Useaward);
      AddXMLNode(node,'Nextofkin' ,Nextofkin);
      AddXMLNode(node,'Nextofkinrelationship' ,Nextofkinrelationship);
      AddXMLNode(node,'Nextofkinphone' ,Nextofkinphone);
      AddXMLNode(node,'Taxscaleid' ,Taxscaleid);
      AddXMLNode(node,'Leaveloading' ,Leaveloading);
      AddXMLNode(node,'Sickhours' ,Sickhours);
      AddXMLNode(node,'Alhours' ,Alhours);
      AddXMLNode(node,'Lastpaid' ,Lastpaid);
      AddXMLNode(node,'Lastpayperiod' ,Lastpayperiod);
      AddXMLNode(node,'Commissiononvalue' ,Commissiononvalue);
      AddXMLNode(node,'IsCommissiononpaidInvoice' ,IsCommissiononpaidInvoice);
      AddXMLNode(node,'Commissionlastpaid' ,Commissionlastpaid);
      AddXMLNode(node,'Paynotes' ,Paynotes);
      AddXMLNode(node,'Isontheroster' ,Isontheroster);
      AddXMLNode(node,'onPMRoster' ,onPMRoster);
      AddXMLNode(node,'Loadhoursfromroster' ,Loadhoursfromroster);
      AddXMLNode(node,'Loadleavefromroster' ,Loadleavefromroster);
      AddXMLNode(node,'Mealbreakhours' ,Mealbreakhours);
      AddXMLNode(node,'Mealbreakthreshold' ,Mealbreakthreshold);
      AddXMLNode(node,'Arearange' ,Arearange);
      AddXMLNode(node,'Photoidvaildfromdate' ,Photoidvaildfromdate);
      AddXMLNode(node,'Photoidvaildtodate' ,Photoidvaildtodate);
      AddXMLNode(node,'Cdepwagetotal' ,Cdepwagetotal);
      AddXMLNode(node,'Isterminated' ,Isterminated);
      AddXMLNode(node,'Defaultclassname' ,Defaultclassname);
      AddXMLNode(node,'Defaultclassid' ,Defaultclassid);
      AddXMLNode(node,'Extrataxoptions' ,Extrataxoptions);
      AddXMLNode(node,'Extratax' ,Extratax);
      AddXMLNode(node,'Useclassificationadvance' ,Useclassificationadvance);
      AddXMLNode(node,'Commissionflatrate' ,Commissionflatrate);
      ADDXMLNode(node, 'Overheadbaserate' , Overheadbaserate);
      AddXMLNode(node, 'CommissionOn' , CommissionOn);
      AddXMLNode(node,'Commissioninvoiceexprice' ,Commissioninvoiceexprice);
      AddXMLNode(node,'EmployeeHasCommission' ,EmployeeHasCommission);
      AddXMLNode(node,'ProductHascommission' ,ProductHascommission);
      AddXMLNode(node,'Paysuperonleaveloading' ,Paysuperonleaveloading);
      AddXMLNode(node,'Defaultinvoicetemplateid' ,Defaultinvoicetemplateid);
      AddXMLNode(node,'Salestarget' ,Salestarget);
      AddXMLNode(node,'Sendpayslipviaemail' ,Sendpayslipviaemail);
      AddXMLNode(node,'WorkersCompRate' ,WorkersCompRate);
      AddXMLNode(node,'CallPriority' ,CallPriority);
      AddXMLNode(node,'DefaultContactMethod' ,DefaultContactMethod);
end;

function Temployeedetails.ValidateData :Boolean;
var
//  tmpResultStatus: TResultStatusItem;
  tmpBusobjEventVal_Failed: String;
begin
   result:= inherited;
   if not result then
     exit;
   result := false;

   tmpBusobjEventVal_Failed := BusobjEventVal_FailedInformationValidateData;
   Try
    if AppEnv.RegionalOptions.RegionType <> rAUST then begin
      { everywhere else }

    end
    else begin
      { Australia }
      if (HECSindicator = False) and (HECSTaxScale > 0) then begin
         AddResult(False , rssError , BOR_Employee_Err_HECSTaxScale,  'HECS Cannot have a Tax scale if not checked'  );
         SendEvent(IntToStr(BOR_Employee_Err_HECSTaxScale),BusobjEventVal_FailedTaxationValidateData);
         Exit;
      end;
      if (HECSindicator = True) and (HECSTaxScale < 1) then begin
         AddResult(False , rssError , BOR_Employee_Err_NoHECSTaxScale,  'HECS must have a Tax scale if checked'  );
         SendEvent(IntToStr(BOR_Employee_Err_NoHECSTaxScale),BusobjEventVal_FailedTaxationValidateData);
         Exit;
      end;
      if (StudentLoanIndicator = False) and (StudentLoanTaxScale > 0) then begin
         AddResult(False , rssError , BOR_Employee_Err_StudentLoanTaxScale,  'SFSS Cannot have a Tax scale if not checked'  );
         SendEvent(IntToStr(BOR_Employee_Err_StudentLoanTaxScale),BusobjEventVal_FailedTaxationValidateData);
         Exit;
      end;
      if (StudentLoanIndicator = True) and (StudentLoanTaxScale < 1) then begin
         AddResult(False , rssError , BOR_Employee_Err_NoStudentLoanTaxScale,  'SFSS must have a Tax scale if checked'  );
         SendEvent(IntToStr(BOR_Employee_Err_NoStudentLoanTaxScale),BusobjEventVal_FailedTaxationValidateData);
         Exit;
      end;
      if (TFN = '') and TaxScaleSelected then  begin
        AddResult(False, rssError, BOR_Employee_Err_NoTaxScale, 'Tax File Number can not be blank when Tax Scale(s) have been selected. ');
        SendEvent(IntToStr(BOR_Employee_Err_NoTaxScale),tmpBusobjEventVal_Failed);
        Exit;
      end;
      if (TFN <> '') and (not TaxScaleSelected) then  begin
        AddResult(False, rssError, 0, 'No Tax Scale(s) have been selected. ');
        Exit;
      end;
    end;
     if BasisOfPayment = '' then begin
        AddResult(False , rssError , BOR_Employee_Err_NoBasisOfPayment,  'Basis of Employment should not be blank'  );
       SendEvent(IntToStr(BOR_Employee_Err_NoBasisOfPayment),tmpBusobjEventVal_Failed);
        Exit;
     end;
    if not( sametext(DefaultContactMethod,'Email' ) or
            sametext(DefaultContactMethod,'Fax'   ) or
            sametext(DefaultContactMethod,'Print' ) or
            sametext(DefaultContactMethod,'Phone' ) or
            sametext(DefaultContactMethod,'Mobile') or
            sametext(DefaultContactMethod,'Visit' ) ) then
      DefaultContactMethod:= '';


     Result := true;
   Finally
//    If not Result then Begin
//      tmpResultStatus := ResultStatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        if Assigned(Self.Owner) and (Self.Owner is TBusobj) then
//          TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code),tmpBusobjEventVal_Failed);
//    end;
   end;
end;


function    Temployeedetails.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   if not PersonalPreferences.Save then exit;
   Result := Inherited Save;
   PostDb;
end;


procedure Temployeedetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure Temployeedetails.DoFieldOnChange(Sender: TField);
begin
   inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName,  'DefaultContactMethod') then begin
    if not( sametext(DefaultContactMethod,'Email' ) or
            sametext(DefaultContactMethod,'Fax'   ) or
            sametext(DefaultContactMethod,'Print' ) or
            sametext(DefaultContactMethod,'Phone' ) or
            sametext(DefaultContactMethod,'Mobile') or
            sametext(DefaultContactMethod,'Visit' ) ) then
     try
      DefaultContactMethod:= Sender.OldValue;
     except
      DefaultContactMethod:= '';
     end;
  end;
end;


Function Temployeedetails.GetSQL: String ;
begin
  Result := Inherited GetSQL;
end;

function TEmployeeDetails.getCallPriority: Integer;begin  REsult := GetintegerField('CallPriority');end;

function TEmployeeDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
end;

Function  Temployeedetails.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

{Property functions}
Function  Temployeedetails.GetOptionno                 :Integer   ; begin Result := GetIntegerField('Optionno');End;
Function  Temployeedetails.GetTax                      :Double    ; begin Result := GetFloatField('Tax');End;
Function  Temployeedetails.GetGross                    :Double    ; begin Result := GetFloatField('Gross');End;
Function  Temployeedetails.GetNet                      :Double    ; begin Result := GetFloatField('Net');End;
Function  Temployeedetails.GetWages                    :Double    ; begin Result := GetFloatField('Wages');End;
Function  Temployeedetails.GetCommission               :Double    ; begin Result := GetFloatField('Commission');End;
Function  Temployeedetails.GetDeductions               :Double    ; begin Result := GetFloatField('Deductions');End;
Function  Temployeedetails.GetAllowances               :Double    ; begin Result := GetFloatField('Allowances');End;
Function  Temployeedetails.GetSundries                 :Double    ; begin Result := GetFloatField('Sundries');End;
Function  Temployeedetails.GetSuper                    :Double    ; begin Result := GetFloatField('Super');End;
Function  Temployeedetails.GetCdeproject               :Boolean   ; begin Result := GetBooleanField('Cdeproject');End;
Function  Temployeedetails.GetFringebenefits           :Double    ; begin Result := GetFloatField('Fringebenefits');End;
Function  Temployeedetails.GetDayspre01071983          :Integer   ; begin Result := GetIntegerField('Dayspre01071983');End;
Function  Temployeedetails.GetDayspost30061983         :Integer   ; begin Result := GetIntegerField('Dayspost30061983');End;
Function  Temployeedetails.GetCgtexempt                :Double    ; begin Result := GetFloatField('Cgtexempt');End;
Function  Temployeedetails.GetNonqualifyingcomponent   :Double    ; begin Result := GetFloatField('Nonqualifyingcomponent');End;
Function  Temployeedetails.GetUndeductedcontribution   :Double    ; begin Result := GetFloatField('Undeductedcontribution');End;
Function  Temployeedetails.GetConcessionalcomponent    :Double    ; begin Result := GetFloatField('Concessionalcomponent');End;
Function  Temployeedetails.GetRepcode                  :String    ; begin Result := GetStringField('Repcode');End;
Function  Temployeedetails.GetResident                 :Boolean   ; begin Result := GetBooleanField('Resident');End;
Function  Temployeedetails.GetTfnapplicationmade       :Boolean   ; begin Result := GetBooleanField('Tfnapplicationmade');End;
Function  Temployeedetails.GetUnder18                  :Boolean   ; begin Result := GetBooleanField('Under18');End;
Function  Temployeedetails.GetPensioner                :Boolean   ; begin Result := GetBooleanField('Pensioner');End;
Function  Temployeedetails.GetIncometype               :Boolean   ; begin Result := GetBooleanField('Incometype');End;
Function  Temployeedetails.GetBasisofpayment           :String    ; begin Result := GetStringField('Basisofpayment');End;
Function  Temployeedetails.GetTaxfreethreshold         :Boolean   ; begin Result := GetBooleanField('Taxfreethreshold');End;
Function  Temployeedetails.GetFamilytaxbenefit         :Boolean   ; begin Result := GetBooleanField('Familytaxbenefit');End;
Function  Temployeedetails.GetZonedependentspecial     :Boolean   ; begin Result := GetBooleanField('Zonedependentspecial');End;
Function  Temployeedetails.GetHecsindicator            :Boolean   ; begin Result := GetBooleanField('Hecsindicator');End;
Function  Temployeedetails.GetHecsTaxScale             :Integer   ; begin Result := GetIntegerField('HecsTaxScale');End;
Function  Temployeedetails.GetStudentloanindicator     :Boolean   ; begin Result := GetBooleanField('Studentloanindicator');End;
Function  Temployeedetails.GetStudentloanTaxScale      :Integer   ; begin Result := GetIntegerField('StudentloanTaxScale');End;
Function  Temployeedetails.GetUseoftfnforsuper         :Boolean   ; begin Result := GetBooleanField('Useoftfnforsuper');End;
Function  Temployeedetails.GetAnnuitysuperpension      :Boolean   ; begin Result := GetBooleanField('Annuitysuperpension');End;
Function  Temployeedetails.GetSignaturepresent         :Boolean   ; begin Result := GetBooleanField('Signaturepresent');End;
Function  Temployeedetails.GetDatesigned               :TDatetime ; begin Result := GetDatetimeField('Datesigned');End;
Function  Temployeedetails.GetPayvia                   :Boolean   ; begin Result := GetBooleanField('Payvia');End;
Function  Temployeedetails.GetReportsto                :Integer   ; begin Result := GetIntegerField('Reportsto');End;
Function  Temployeedetails.GetPayperiod                :String    ; begin Result := GetStringField('Payperiod');End;
Function  Temployeedetails.GetAward                    :Integer   ; begin Result := GetIntegerField('Award');End;
Function  Temployeedetails.GetClassification           :String    ; begin Result := GetStringField('Classification');End;
Function  Temployeedetails.GetWorkerscompinsurer       :Integer   ; begin Result := GetIntegerField('Workerscompinsurer');End;
Function  Temployeedetails.GetUseaward                 :Boolean   ; begin Result := GetBooleanField('Useaward');End;
Function  Temployeedetails.GetNextofkin                :String    ; begin Result := GetStringField('Nextofkin');End;
Function  Temployeedetails.GetNextofkinrelationship    :String    ; begin Result := GetStringField('Nextofkinrelationship');End;
Function  Temployeedetails.GetNextofkinphone           :String    ; begin Result := GetStringField('Nextofkinphone');End;
Function  Temployeedetails.GetTaxscaleid               :Integer   ; begin Result := GetIntegerField('Taxscaleid');End;
Function  Temployeedetails.GetLeaveloading             :Double    ; begin Result := GetFloatField('Leaveloading');End;
Function  Temployeedetails.GetSickhours                :Double    ; begin Result := GetFloatField('Sickhours');End;
Function  Temployeedetails.GetAlhours                  :Double    ; begin Result := GetFloatField('Alhours');End;
Function  Temployeedetails.GetLastpaid                 :TDatetime ; begin Result := GetDatetimeField('Lastpaid');End;
Function  Temployeedetails.GetLastpayperiod            :Integer   ; begin Result := GetIntegerField('Lastpayperiod');End;
Function  Temployeedetails.GetCommissiononvalue        :String    ; begin Result := GetStringField('Commissiononvalue');End;
Function  Temployeedetails.GetIsCommissiononpaidInvoice:Boolean   ; begin Result := GetBooleanField('Commissiononpaid');End;
Function  Temployeedetails.GetCommissionlastpaid       :TDatetime ; begin Result := GetDatetimeField('Commissionlastpaid');End;
Function  Temployeedetails.GetPaynotes                 :String    ; begin Result := GetStringField('Paynotes');End;
Function  Temployeedetails.GetIsontheroster            :Boolean   ; begin Result := GetBooleanField('Isontheroster');End;
Function  Temployeedetails.GetonPMRoster               :Boolean   ; begin Result := GetBooleanField('onPMRoster');End;
Function  Temployeedetails.GetLoadhoursfromroster      :Boolean   ; begin Result := GetBooleanField('Loadhoursfromroster');End;
Function  Temployeedetails.GetLoadleavefromroster      :Boolean   ; begin Result := GetBooleanField('Loadleavefromroster');End;
Function  Temployeedetails.GetMealbreakhours           :Double    ; begin Result := GetFloatField('Mealbreakhours');End;
Function  Temployeedetails.GetMealbreakthreshold       :Double    ; begin Result := GetFloatField('Mealbreakthreshold');End;
Function  Temployeedetails.GetArearange                :String    ; begin Result := GetStringField('Arearange');End;
Function  Temployeedetails.GetPhotoidvaildfromdate     :TDatetime ; begin Result := GetDatetimeField('Photoidvaildfromdate');End;
Function  Temployeedetails.GetPhotoidvaildtodate       :TDatetime ; begin Result := GetDatetimeField('Photoidvaildtodate');End;
Function  Temployeedetails.GetCdepwagetotal            :Double    ; begin Result := GetFloatField('Cdepwagetotal');End;
Function  Temployeedetails.GetIsterminated             :Boolean   ; begin Result := GetBooleanField('Isterminated');End;
function TEmployeeDetails.getDefaultContactMethod: String;begin  result := getstringfield('DefaultContactMethod');end;
Function  Temployeedetails.GetExtrataxoptions          :String    ; begin Result := GetStringField('Extrataxoptions');End;
Function  Temployeedetails.GetExtratax                 :Double    ; begin Result := GetFloatField('Extratax');End;
Function  Temployeedetails.GetUseclassificationadvance :Boolean   ; begin Result := GetBooleanField('Useclassificationadvance');End;
Function  Temployeedetails.GetCommissionflatrate       :Double    ; begin Result := GetFloatField('Commissionflatrate');End;
Function  Temployeedetails.GetCommissioninvoiceexprice :Boolean   ; begin Result := GetBooleanField('Commissioninvoiceexprice');End;
Function  Temployeedetails.GetEmployeeHasCommission    :Boolean   ; begin Result := GetBooleanField('Commissionuseemp');End;
Function  Temployeedetails.GetProductHascommission     :Boolean   ; begin Result := GetBooleanField('Commissionuseprod');End;
Function  Temployeedetails.GetPaysuperonleaveloading   :Boolean   ; begin Result := GetBooleanField('Paysuperonleaveloading');End;
Function  Temployeedetails.GetDefaultinvoicetemplateid :Integer   ; begin Result := GetIntegerField('Defaultinvoicetemplateid');End;
function TEmployeeDetails.getEmployeeAddress: String;
begin
  Result := ConcatStrings([EmployeeName, street, street2, street3 , ConcatStrings([Suburb , State , Postcode], ' ')] , chr(13)+chr(10));
end;

Function  Temployeedetails.GetSalestarget              :Double    ; begin Result := GetFloatField('Salestarget');End;
Function  Temployeedetails.GetSendpayslipviaemail      :String    ; begin Result := GetStringField('Sendpayslipviaemail');End;
Function  Temployeedetails.GetWorkersCompRate          :Double    ; begin Result := GetFloatField('WorkersCompRate');End;
function  TEmployeeDetails.GetId                       :Integer   ; begin Result := GetIntegerField('EmployeeID');end;
Procedure Temployeedetails.SetOptionno                 (Const Value :Integer   ); begin SetIntegerField('Optionno'                  , Value);End;
Procedure Temployeedetails.SetTax                      (Const Value :Double    ); begin SetFloatField('Tax'                       , Value);End;
Procedure Temployeedetails.SetGross                    (Const Value :Double    ); begin SetFloatField('Gross'                     , Value);End;
Procedure Temployeedetails.SetNet                      (Const Value :Double    ); begin SetFloatField('Net'                       , Value);End;
Procedure Temployeedetails.SetWages                    (Const Value :Double    ); begin SetFloatField('Wages'                     , Value);End;
Procedure Temployeedetails.SetCommission               (Const Value :Double    ); begin SetFloatField('Commission'                , Value);End;
Procedure Temployeedetails.SetDeductions               (Const Value :Double    ); begin SetFloatField('Deductions'                , Value);End;
Procedure Temployeedetails.SetAllowances               (Const Value :Double    ); begin SetFloatField('Allowances'                , Value);End;
Procedure Temployeedetails.SetSundries                 (Const Value :Double    ); begin SetFloatField('Sundries'                  , Value);End;
Procedure Temployeedetails.SetSuper                    (Const Value :Double    ); begin SetFloatField('Super'                     , Value);End;
Procedure Temployeedetails.SetWorkersCompRate          (Const Value :Double    ); begin SetFloatField('WorkersCompRate'           , Value);End;
Procedure Temployeedetails.SetCdeproject               (Const Value :Boolean   ); begin SetBooleanField('Cdeproject'                , Value);End;
Procedure Temployeedetails.SetFringebenefits           (Const Value :Double    ); begin SetFloatField('Fringebenefits'            , Value);End;
Procedure Temployeedetails.SetDayspre01071983          (Const Value :Integer   ); begin SetIntegerField('Dayspre01071983'           , Value);End;
Procedure Temployeedetails.SetDayspost30061983         (Const Value :Integer   ); begin SetIntegerField('Dayspost30061983'          , Value);End;
Procedure Temployeedetails.SetCgtexempt                (Const Value :Double    ); begin SetFloatField('Cgtexempt'                 , Value);End;
Procedure Temployeedetails.SetNonqualifyingcomponent   (Const Value :Double    ); begin SetFloatField('Nonqualifyingcomponent'    , Value);End;
Procedure Temployeedetails.SetUndeductedcontribution   (Const Value :Double    ); begin SetFloatField('Undeductedcontribution'    , Value);End;
Procedure Temployeedetails.SetConcessionalcomponent    (Const Value :Double    ); begin SetFloatField('Concessionalcomponent'     , Value);End;
Procedure Temployeedetails.SetRepcode                  (Const Value :String    ); begin SetStringField('Repcode'                   , Value);End;
Procedure Temployeedetails.SetResident                 (Const Value :Boolean   ); begin SetBooleanField('Resident'                  , Value);End;
Procedure Temployeedetails.SetTfnapplicationmade       (Const Value :Boolean   ); begin SetBooleanField('Tfnapplicationmade'        , Value);End;
Procedure Temployeedetails.SetUnder18                  (Const Value :Boolean   ); begin SetBooleanField('Under18'                   , Value);End;
Procedure Temployeedetails.SetPensioner                (Const Value :Boolean   ); begin SetBooleanField('Pensioner'                 , Value);End;
Procedure Temployeedetails.SetIncometype               (Const Value :Boolean   ); begin SetBooleanField('Incometype'                , Value);End;
Procedure Temployeedetails.SetBasisofpayment           (Const Value :String    ); begin SetStringField('Basisofpayment'            , Value);End;
procedure TEmployeeDetails.setCallPriority(const Value: Integer);begin  SetintegerField('CallPriority' , Value);end;

Procedure Temployeedetails.SetTaxfreethreshold         (Const Value :Boolean   ); begin SetBooleanField('Taxfreethreshold'          , Value);End;
Procedure Temployeedetails.SetFamilytaxbenefit         (Const Value :Boolean   ); begin SetBooleanField('Familytaxbenefit'          , Value);End;
Procedure Temployeedetails.SetZonedependentspecial     (Const Value :Boolean   ); begin SetBooleanField('Zonedependentspecial'      , Value);End;
function TEmployeeDetails.TaxScaleSelected: boolean;
var
  qry: TERPQuery;
begin
   qry := DbSharedObj.GetQuery(self.Connection.Connection);
   try
     qry.SQL.Add('select * from tblpaytaxscaleconfig');
     qry.SQL.Add('where tblpaytaxscaleconfig.EmployeeId = ' + IntToStr(self.ID));
     qry.SQL.Add('and ifNull(tblpaytaxscaleconfig.TaxScaleId,0) > 0');
     qry.Open;
     result := not qry.IsEmpty;
   finally
     DbSharedObj.ReleaseObj(qry);
   end;
end;

Procedure Temployeedetails.SetHecsindicator            (Const Value :Boolean   ); begin SetBooleanField('Hecsindicator'             , Value);End;
Procedure Temployeedetails.SetHecsTaxScale             (Const Value :Integer   ); begin SetIntegerField('HecsTaxScale'             , Value);End;
Procedure Temployeedetails.SetStudentloanindicator     (Const Value :Boolean   ); begin SetBooleanField('Studentloanindicator'      , Value);End;
Procedure Temployeedetails.SetStudentloanTaxScale      (Const Value :Integer   ); begin SetIntegerField('StudentloanTaxScale'       , Value);End;
Procedure Temployeedetails.SetUseoftfnforsuper         (Const Value :Boolean   ); begin SetBooleanField('Useoftfnforsuper'          , Value);End;
Procedure Temployeedetails.SetAnnuitysuperpension      (Const Value :Boolean   ); begin SetBooleanField('Annuitysuperpension'       , Value);End;
Procedure Temployeedetails.SetSignaturepresent         (Const Value :Boolean   ); begin SetBooleanField('Signaturepresent'          , Value);End;
Procedure Temployeedetails.SetDatesigned               (Const Value :TDatetime ); begin SetDatetimeField('Datesigned'                , Value);End;
Procedure Temployeedetails.SetPayvia                   (Const Value :Boolean   ); begin SetBooleanField('Payvia'                    , Value);End;
Procedure Temployeedetails.SetReportsto                (Const Value :Integer   ); begin SetIntegerField('Reportsto'                 , Value);End;
Procedure Temployeedetails.SetPayperiod                (Const Value :String    ); begin SetStringField('Payperiod'                 , Value);End;
Procedure Temployeedetails.SetAward                    (Const Value :Integer   ); begin SetIntegerField('Award'                     , Value);End;
Procedure Temployeedetails.SetClassification           (Const Value :String    ); begin SetStringField('Classification'            , Value);End;
Procedure Temployeedetails.SetWorkerscompinsurer       (Const Value :Integer   ); begin SetIntegerField('Workerscompinsurer'        , Value);End;
Procedure Temployeedetails.SetUseaward                 (Const Value :Boolean   ); begin SetBooleanField('Useaward'                  , Value);End;
Procedure Temployeedetails.SetNextofkin                (Const Value :String    ); begin SetStringField('Nextofkin'                 , Value);End;
Procedure Temployeedetails.SetNextofkinrelationship    (Const Value :String    ); begin SetStringField('Nextofkinrelationship'     , Value);End;
Procedure Temployeedetails.SetNextofkinphone           (Const Value :String    ); begin SetStringField('Nextofkinphone'            , Value);End;
Procedure Temployeedetails.SetTaxscaleid               (Const Value :Integer   ); begin SetIntegerField('Taxscaleid'                , Value);End;
Procedure Temployeedetails.SetLeaveloading             (Const Value :Double    ); begin SetFloatField('Leaveloading'              , Value);End;
Procedure Temployeedetails.SetSickhours                (Const Value :Double    ); begin SetFloatField('Sickhours'                 , Value);End;
Procedure Temployeedetails.SetAlhours                  (Const Value :Double    ); begin SetFloatField('Alhours'                   , Value);End;
Procedure Temployeedetails.SetLastpaid                 (Const Value :TDatetime ); begin SetDatetimeField('Lastpaid'                  , Value);End;
Procedure Temployeedetails.SetLastpayperiod            (Const Value :Integer   ); begin SetIntegerField('Lastpayperiod'             , Value);End;
Procedure Temployeedetails.SetCommissiononvalue        (Const Value :String    ); begin SetStringField('Commissiononvalue'         , Value);End;
Procedure Temployeedetails.SetIsCommissiononpaidInvoice(Const Value :Boolean   ); begin SetBooleanField('Commissiononpaid'          , Value);End;
Procedure Temployeedetails.SetCommissionlastpaid       (Const Value :TDatetime ); begin SetDatetimeField('Commissionlastpaid'        , Value);End;
procedure TEmployeeDetails.SetOverheadRate(const Value: double);
begin
  SetFloatfield('Overheadrate' , Value);
end;

Procedure Temployeedetails.SetPaynotes                 (Const Value :String    ); begin SetStringField('Paynotes'                  , Value);End;
Procedure Temployeedetails.SetIsontheroster            (Const Value :Boolean   ); begin SetBooleanField('Isontheroster'             , Value);End;
Procedure Temployeedetails.SetonPMRoster               (Const Value :Boolean   ); begin SetBooleanField('onPMRoster'             , Value);End;
Procedure Temployeedetails.SetLoadhoursfromroster      (Const Value :Boolean   ); begin SetBooleanField('Loadhoursfromroster'       , Value);End;
Procedure Temployeedetails.SetLoadleavefromroster      (Const Value :Boolean   ); begin SetBooleanField('Loadleavefromroster'       , Value);End;
Procedure Temployeedetails.SetMealbreakhours           (Const Value :Double    ); begin SetFloatField('Mealbreakhours'            , Value);End;
Procedure Temployeedetails.SetMealbreakthreshold       (Const Value :Double    ); begin SetFloatField('Mealbreakthreshold'        , Value);End;
Procedure Temployeedetails.SetArearange                (Const Value :String    ); begin SetStringField('Arearange'                 , Value);End;
Procedure Temployeedetails.SetPhotoidvaildfromdate     (Const Value :TDatetime ); begin SetDatetimeField('Photoidvaildfromdate'      , Value);End;
Procedure Temployeedetails.SetPhotoidvaildtodate       (Const Value :TDatetime ); begin SetDatetimeField('Photoidvaildtodate'        , Value);End;
Procedure Temployeedetails.SetCdepwagetotal            (Const Value :Double    ); begin SetFloatField('Cdepwagetotal'             , Value);End;
Procedure Temployeedetails.SetIsterminated             (Const Value :Boolean   ); begin SetBooleanField('Isterminated'              , Value);End;
procedure TEmployeeDetails.setDefaultContactMethod(const Value: String);begin  SetStringField('DefaultContactMethod' , Value);end;

Procedure Temployeedetails.SetExtrataxoptions          (Const Value :String    ); begin SetStringField('Extrataxoptions'           , Value);End;
Procedure Temployeedetails.SetExtratax                 (Const Value :Double    ); begin SetFloatField('Extratax'                  , Value);End;
Procedure Temployeedetails.SetUseclassificationadvance (Const Value :Boolean   ); begin SetBooleanField('UseClassificationAdvanve'                  , Value);End;
Procedure Temployeedetails.SetCommissionflatrate       (Const Value :Double    ); begin SetFloatField('Commissionflatrate'        , Value);End;
Procedure Temployeedetails.SetCommissioninvoiceexprice (Const Value :Boolean   ); begin SetBooleanField('Commissioninvoiceexprice'            , Value);End;
Procedure Temployeedetails.SetEmployeeHasCommission    (Const Value :Boolean   ); begin SetBooleanField('Commissionuseemp'          , Value);End;
Procedure Temployeedetails.SetProductHascommission     (Const Value :Boolean   ); begin SetBooleanField('Commissionuseprod'         , Value);End;
Procedure Temployeedetails.SetPaysuperonleaveloading   (Const Value :Boolean   ); begin SetBooleanField('Paysuperonleaveloading'    , Value);End;
Procedure Temployeedetails.SetDefaultinvoicetemplateid (Const Value :Integer   ); begin SetIntegerField('Paysuperonleaveloading'    , Value);End;
Procedure Temployeedetails.SetSalestarget              (Const Value :Double    ); begin SetFloatField('Salestarget'               , Value);End;
Procedure Temployeedetails.SetSendpayslipviaemail      (Const Value :String    ); begin SetStringField('Sendpayslipviaemail'       , Value);End;

function TEmployeeDetails.getCommissionOn: String;
begin
  Result := getstringfield('CommissionOn');
  if result = '' then result := 'I' ; // default value
end;

procedure TEmployeeDetails.setCommissionOn(const Value: String);
begin
if value = '' then
  SetStringfield('CommissionOn', 'I') //default value
else
  SetStringfield('CommissionOn', Value);
end;

function TEmployeeDetails.getOverheadbaserate: Double;
begin
  Result := GetFloatField('Overheadbaserate');
end;

function TEmployeeDetails.getOverheadRate: double;
begin
  Result := GetFloatField('Overheadrate');
end;

procedure TEmployeeDetails.setOverheadbaserate(const Value: Double);
begin
  SetFloatfield('Overheadbaserate' , Value);
end;


initialization
  RegisterClassOnce(TEmployeeDetails);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Employee Details','TEmployeeDetails','TfrmEmployeeList');
end.
