unit frmEmployeefrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/07/06  1.00.01 RM  First version.

}

interface
{$I ERP.inc}

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImageScroll, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB,
  DNMSpeedButton, StdCtrls, wwcheckbox, DataSourcePrefs, MessageConst,
  wwradiogroup, Mask, wwdbedit, Wwdotdot, Wwdbcomb, jpeg, GraphUtil, Shader,
  frmBase,BusObjPayUtils,BusObjEmployeePay, MemDS,BaseListingForm, BusObjBase,
  ImgList, ProgressDialog, Grids, Wwdbigrd, Wwdbgrid;


type
  TDisplayMode = (dmNone, dmPayDetails);

  TfrmEmployee = class(TBaseInputGUI)
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    cboSearch: TwwDBComboBox;
    Label2: TLabel;
    imgPrefs: TImage;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryemployee: TERPQuery;
    qryemployeeEmployeeID: TAutoIncField;
    qryemployeeTitle: TWideStringField;
    qryemployeeFirstName: TWideStringField;
    qryemployeeMiddleName: TWideStringField;
    qryemployeeLastName: TWideStringField;
    qryemployeeABN: TWideStringField;
    qryemployeeCanvasser: TWideStringField;
    qryemployeeRep: TWideStringField;
    qryemployeeDateStarted: TDateField;
    qryemployeeDateFinished: TDateField;
    qryemployeeNotes: TWideMemoField;
    qryemployeeActive: TWideStringField;
    qryemployeeCUSTFLD1: TWideStringField;
    qryemployeeCUSTFLD2: TWideStringField;
    qryemployeeCUSTFLD3: TWideStringField;
    qryemployeeCUSTFLD4: TWideStringField;
    qryemployeeCUSTFLD5: TWideStringField;
    qryemployeeCUSTFLD6: TWideStringField;
    qryemployeeCUSTFLD7: TWideStringField;
    qryemployeeCUSTFLD8: TWideStringField;
    qryemployeeCUSTFLD9: TWideStringField;
    qryemployeeCUSTFLD10: TWideStringField;
    qryemployeeCUSTFLD11: TWideStringField;
    qryemployeeCUSTFLD12: TWideStringField;
    qryemployeeCUSTFLD13: TWideStringField;
    qryemployeeCUSTFLD14: TWideStringField;
    qryemployeeCUSTFLD15: TWideStringField;
    qryemployeeEditedFlag: TWideStringField;
    qryemployeeEmployeeNo: TIntegerField;
    qryemployeeTFN: TWideStringField;
    qryemployeeDOB: TDateField;
    qryemployeeInitials: TWideStringField;
    qryemployeeSex: TWideStringField;
    qryemployeeOptionNo: TWordField;
    qryemployeeTax: TFloatField;
    qryemployeeGross: TFloatField;
    qryemployeeNet: TFloatField;
    qryemployeeWages: TFloatField;
    qryemployeeCommission: TFloatField;
    qryemployeeDeductions: TFloatField;
    qryemployeeAllowances: TFloatField;
    qryemployeeSundries: TFloatField;
    qryemployeeSuper: TFloatField;
    qryemployeeCDEProject: TWideStringField;
    qryemployeeFringeBenefits: TFloatField;
    qryemployeeDaysPre01071983: TIntegerField;
    qryemployeeDaysPost30061983: TIntegerField;
    qryemployeeCGTExempt: TFloatField;
    qryemployeeNonQualifyingComponent: TFloatField;
    qryemployeeUndeductedContribution: TFloatField;
    qryemployeeConcessionalComponent: TFloatField;
    qryemployeeRepCode: TWideStringField;
    qryemployeeResident: TWideStringField;
    qryemployeeTFNApplicationMade: TWideStringField;
    qryemployeeUnder18: TWideStringField;
    qryemployeePensioner: TWideStringField;
    qryemployeeIncomeType: TWideStringField;
    qryemployeeBasisOfPayment: TWideStringField;
    qryemployeeTaxFreeThreshold: TWideStringField;
    qryemployeeFamilyTaxBenefit: TWideStringField;
    qryemployeeZoneDependentSpecial: TWideStringField;
    qryemployeeHECSIndicator: TWideStringField;
    qryemployeeStudentLoanIndicator: TWideStringField;
    qryemployeeUseOfTFNForSuper: TWideStringField;
    qryemployeeAnnuitySuperPension: TWideStringField;
    qryemployeeSignaturePresent: TWideStringField;
    qryemployeeDateSigned: TDateField;
    qryemployeePayVia: TWideStringField;
    qryemployeeEmployeeName: TWideStringField;
    qryemployeeReportsTo: TIntegerField;
    qryemployeePayPeriod: TWideStringField;
    qryemployeeAward: TIntegerField;
    qryemployeeClassification: TWideStringField;
    qryemployeeWorkersCompInsurer: TIntegerField;
    qryemployeeUseAward: TWideStringField;
    qryemployeeNextOfKin: TWideStringField;
    qryemployeeNextOfKinRelationship: TWideStringField;
    qryemployeeNextOfKinPhone: TWideStringField;
    qryemployeeTaxScaleID: TIntegerField;
    qryemployeeLeaveLoading: TFloatField;
    qryemployeeExtraTax: TFloatField;
    qryemployeeSickHours: TFloatField;
    qryemployeeALHours: TFloatField;
    qryemployeeLastPaid: TDateField;
    qryemployeeCommissionOnValue: TWideStringField;
    qryemployeeCommissionLastPaid: TDateField;
    qryemployeeGlobalRef: TWideStringField;
    qryemployeePayNotes: TWideMemoField;
    qryemployeeIsOnTheRoster: TWideStringField;
    qryemployeeonPMRoster: TWideStringField;
    qryemployeeLoadHoursFromRoster: TWideStringField;
    qryemployeeLoadLeaveFromRoster: TWideStringField;
    qryemployeeMealBreakHours: TFloatField;
    qryemployeeMealBreakThreshold: TFloatField;
    qryemployeeAreaRange: TWideStringField;
    qryemployeeEmpPicture: TBlobField;
    qryemployeePhotoIDVaildFromDate: TDateField;
    qryemployeePhotoIDVaildToDate: TDateField;
    qryemployeeCDEPWageTotal: TFloatField;
    qryemployeeIsTerminated: TWideStringField;
    qryemployeeDefaultClassName: TWideStringField;
    qryemployeeDefaultClassID: TIntegerField;
    qryemployeeExtraTaxOptions: TWideStringField;
    qryemployeeUseClassificationAdvance: TWideStringField;
    qryemployeeLastPayPeriod: TSmallintField;
    qryemployeeCommissionFlatRate: TFloatField;
    qryemployeeCommissionInvoiceExPrice: TWideStringField;
    qryemployeeCommissionUseEmp: TWideStringField;
    qryemployeeCommissionUseProd: TWideStringField;
    qryemployeeDefaultInvoiceTemplateID: TIntegerField;
    qryemployeePaySuperOnLeaveLoading: TWideStringField;
    qryemployeeLastUpdated: TDateTimeField;
    qryemployeeSalesTarget: TFloatField;
    qryemployeeSendPaySlipViaEmail: TWideStringField;
    qryemployeeEmailsFromEmployeeAddress: TWideStringField;
    qryemployeeStreet: TWideStringField;
    qryemployeeStreet2: TWideStringField;
    qryemployeeSuburb: TWideStringField;
    qryemployeePostcode: TWideStringField;
    qryemployeeState: TWideStringField;
    qryemployeeCountry: TWideStringField;
    qryemployeePhone: TWideStringField;
    qryemployeeAltPhone: TWideStringField;
    qryemployeeFaxNumber: TWideStringField;
    qryemployeeMobile: TWideStringField;
    qryemployeeEmail: TWideStringField;
    qryemployeeAltContact: TWideStringField;
    qryemployeeCompany: TWideStringField;
    qryemployeePosition: TWideStringField;
    qryemployeeStreet3: TWideStringField;
    qryEmployeePaySplit: TERPQuery;
    qryEmployeePaySplittype: TWideStringField;
    qryEmployeePaySplitBank: TWideStringField;
    qryEmployeePaySplitGlobalRef: TWideStringField;
    qryEmployeePaySplitSplitID: TAutoIncField;
    qryEmployeePaySplitEmployeeID: TIntegerField;
    qryEmployeePaySplitSplit: TWideStringField;
    qryEmployeePaySplitBankID: TIntegerField;
    qryEmployeePaySplitBranch: TWideStringField;
    qryEmployeePaySplitBSB: TWideStringField;
    qryEmployeePaySplitAccountNo: TWideStringField;
    qryEmployeePaySplitAmount: TFloatField;
    qryEmployeePaySplitEditedFlag: TWideStringField;
    qryEmployeePaySplitAccountName: TWideStringField;
    qryBankCodes: TERPQuery;
    qryBasedOn: TERPQuery;
    qryCustomers: TERPQuery;
    qryemployeepayallowances: TERPQuery;
    qryemployeepayallowancesEAID: TAutoIncField;
    qryemployeepayallowancesEmployeeID: TIntegerField;
    qryemployeepayallowancesAllowanceID: TIntegerField;
    qryemployeepayallowancesQty: TFloatField;
    qryemployeepayallowancesBasedOnID: TIntegerField;
    qryemployeepayallowancesAmount: TFloatField;
    qryemployeepayallowancesCalcBy: TWideStringField;
    qryemployeepayallowancesArea: TWideStringField;
    qryemployeepayallowancesSuperInc: TWideStringField;
    qryemployeepayallowancesTaxExempt: TWideStringField;
    qryemployeepayallowancesClientID: TIntegerField;
    qryemployeepayallowancesClassID: TIntegerField;
    qryemployeepayallowancesBasedOn: TWideStringField;
    qryemployeepayallowancesAllowanceJob: TWideStringField;
    qryemployeepayallowancesClassName: TWideStringField;
    qryemployeepayallowancesAllowance: TWideStringField;
    qryemployeepayallowancesUseStartEndDates: TWideStringField;
    qryemployeepayallowancesStartDate: TDateField;
    qryemployeepayallowancesEndDate: TDateField;
    qryFBT: TERPQuery;
    qryFBTYearEnding: TDateField;
    qryFBTNotes: TWideStringField;
    qryFBTAmount: TFloatField;
    qryFBTFBTReportable: TFloatField;
    qryFBTClassName: TWideStringField;
    qryFBTGlobalRef: TWideStringField;
    qryFBTFBTID: TAutoIncField;
    qryFBTEmployeeID: TIntegerField;
    qryFBTEditedFlag: TWideStringField;
    qryFBTClassID: TIntegerField;
    qryFBTType: TIntegerField;
    qryEmployeePayDeductions: TERPQuery;
    qryemployeedeductionsNotes: TWideStringField;
    qryemployeedeductionsQty: TFloatField;
    qryemployeedeductionsBasedOnLookup: TWideStringField;
    qryemployeedeductionsAmount: TFloatField;
    qryemployeedeductionsCalcBy: TWideStringField;
    qryemployeedeductionsArea: TWideStringField;
    qryemployeedeductionsEDID: TAutoIncField;
    qryemployeedeductionsEmployeeID: TIntegerField;
    qryemployeedeductionsDeductionID: TIntegerField;
    qryemployeedeductionsIsWorkPlacegiving: TWideStringField;
    qryemployeedeductionsUnionFees: TWideStringField;
    qryemployeedeductionsBasedOnID: TIntegerField;
    qryemployeedeductionsClassID: TIntegerField;
    qryemployeedeductionsClassName: TWideStringField;
    qryemployeedeductionsDeduction: TWideStringField;
    qryemployeedeductionsUseStartEndDates: TWideStringField;
    qryemployeedeductionsStartDate: TDateField;
    qryemployeedeductionsEndDate: TDateField;
    qryreference: TERPQuery;
    qryreferenceRef_Date: TDateTimeField;
    qryreferenceRef_type: TWideStringField;
    qryreferenceReferencetxt: TWideStringField;
    qryreferenceRefID: TAutoIncField;
    qryreferenceContactID: TIntegerField;
    qryreferenceCusID: TIntegerField;
    qryreferenceSupID: TIntegerField;
    qryreferenceEmployeeID: TIntegerField;
    qryreferenceEditedFlag: TWideStringField;
    qryreferenceOtherContactID: TIntegerField;
    qryemployeepayrates: TERPQuery;
    qryemployeepayratesPayRate: TWideStringField;
    qryemployeepayratesRateType: TWideStringField;
    qryemployeepayratesQty: TFloatField;
    qryemployeepayratesHourlyRate: TFloatField;
    qryemployeepayratesAmount: TFloatField;
    qryemployeepayratesRateJob: TWideStringField;
    qryemployeepayratesClassName: TWideStringField;
    qryemployeepayratesSuper: TWideStringField;
    qryemployeepayratesLineTotal: TFloatField;
    qryemployeepayratesClientID: TIntegerField;
    qryemployeepayratesClassID: TIntegerField;
    qryemployeepayratesEmployeeRateID: TAutoIncField;
    qryemployeepayratesEmployeeID: TIntegerField;
    qryemployeepayratesPayRateID: TIntegerField;
    qryemployeepayratesTypeID: TIntegerField;
    qryemployeepayratesNICs: TWideStringField;
    qryPayRates: TERPQuery;
    qryPayRatesDescription: TWideStringField;
    qryPayRatesRateID: TAutoIncField;
    qryPayRateType: TERPQuery;
    qryJobs: TERPQuery;
    qryLeave: TERPQuery;
    qryLeaveAccrueAfterNo: TFloatField;
    qryLeaveAccrueAfterPeriod: TWideStringField;
    qryLeaveAccrueNo: TFloatField;
    qryLeaveAccruePeriod: TWideStringField;
    qryLeaveAccrueHours: TFloatField;
    qryLeaveAccruedHours: TFloatField;
    qryLeaveLeaveLoading: TFloatField;
    qryLeaveAccruedDate: TDateField;
    qryLeaveClassName: TWideStringField;
    qryLeaveOpenningBalanceHrs: TFloatField;
    qryLeaveOpenningBalanceDate: TDateField;
    qryLeaveUseStartEndDates: TWideStringField;
    qryLeaveStartDate: TDateField;
    qryLeaveEndDate: TDateField;
    qryLeaveTypeID: TIntegerField;
    qryLeaveClassID: TIntegerField;
    qryLeaveGlobalRef: TWideStringField;
    qryLeaveMaxHours: TFloatField;
    qryLeaveLeaveID: TAutoIncField;
    qryLeaveEmployeeID: TIntegerField;
    qryLeaveType: TWideStringField;
    qryempPaySettings: TERPQuery;
    qryempPaySettingsEmployeeID: TIntegerField;
    qryempPaySettingsUKTaxCode: TWideStringField;
    qryempPaySettingsABN: TIntegerField;
    qryempPaySettingsPayPeriod: TWideStringField;
    qryempPaySettingsEmployeePayNotes: TWideMemoField;
    qryempPaySettingsIsOnTheRoster: TWideStringField;
    qryempPaySettingsFirstPayDate: TDateField;
    qryempPaySettingsLastPaid: TDateField;
    qryempPaySettingsNICTableLetter: TWideStringField;
    qryempPaySettingsIsDirector: TWideStringField;
    qryempPaySettingsIsMarriedWoman: TWideStringField;
    qryempPaySettingsIsContractedOut: TWideStringField;
    qryempPaySettingsUKNINO: TWideStringField;
    qryempPaySettingsCIS: TWideStringField;
    qryempPaySettingsStudent: TWideStringField;
    qryempPaySettingsMaritalStatus: TWideStringField;
    qryEmpSkills: TERPQuery;
    qryEmpSkillsEmpSkillID: TAutoIncField;
    qryEmpSkillsSkillID: TIntegerField;
    qryEmpSkillsSkillName: TWideStringField;
    qryEmpSkillsSkillLevel: TIntegerField;
    qryEmpSkillsSkillExpDate: TDateField;
    qryEmpSkillsSecurityLevel: TIntegerField;
    qryEmpSkillsSecurityExpDate: TDateField;
    qryEmpSkillsEmployeeID: TIntegerField;
    qrysuperannuation: TERPQuery;
    qrysuperannuationSuperType: TWideStringField;
    qrysuperannuationSuperFund: TWideStringField;
    qrysuperannuationAccountNo: TWideStringField;
    qrysuperannuationDateJoined: TDateField;
    qrysuperannuationAmount: TFloatField;
    qrysuperannuationCalcBy: TWideStringField;
    qrysuperannuationArea: TWideStringField;
    qrysuperannuationSuperID: TAutoIncField;
    qrysuperannuationEmployeeID: TIntegerField;
    qrysuperannuationSuperTypeID: TIntegerField;
    qrysuperannuationClientID: TIntegerField;
    qrysuperannuationTaxExempt: TWideStringField;
    qrysuperannuationTaxRate: TFloatField;
    qrysuperannuationClassID: TIntegerField;
    qrysuperannuationAllClasses: TWideStringField;
    qrysuperannuationClassName: TWideStringField;
    qrysuperannuationAmountToPaid: TFloatField;
    qrySuperType: TERPQuery;
    qrySuppliers: TERPQuery;
    qryempPaySettingsIRPR: TWideStringField;
    qryworkerscompensation: TERPQuery;
    qryworkerscompensationWCDate: TDateField;
    qryworkerscompensationDescription: TWideStringField;
    qryworkerscompensationAmount: TFloatField;
    qryworkerscompensationType: TWideStringField;
    qryworkerscompensationWCID: TAutoIncField;
    qryworkerscompensationEmployeeID: TIntegerField;
    qryworkerscompensationClassID: TIntegerField;
    qryworkerscompensationClassName: TWideStringField;
    qryempPaySettingsDateLastActuallyPaid: TDateField;
    qryempPaySettingsEmployeePaySettingID: TIntegerField;
    qryemployeeHECSTaxScale: TIntegerField;
    qryemployeeStudentLoanTaxScale: TIntegerField;
    qryempPaySettingsWorkersCompRate: TFloatField;
    qryemployeeWorkPhone: TWideStringField;
    qryemployeeCommissionOn: TWideStringField;
    qryemployeeOverheadbaserate: TFloatField;
    qryemployeeCommissionOnPaid: TWideStringField;
    qryProductCommission: TERPQuery;
    qryProductCommissionPartname: TWideStringField;
    qryProductCommissionCommissionRate: TFloatField;
    qryProductCommissionIsPercentage: TWideStringField;
    qryProductCommissionForAllEmployees: TWideStringField;
    qryProductCommissionProductCommissionId: TIntegerField;
    qryProductCommissionPartsId: TIntegerField;
    qryProductCommissionGlobalRef: TWideStringField;
    qryProductCommissionActive: TWideStringField;
    qryProductCommissionmsTimeStamp: TDateTimeField;
    qryProductCommissionEmployeeId: TLargeintField;
    qryemployeeProductCommission: TERPQuery;
    StringField1: TWideStringField;
    FloatField1: TFloatField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField4: TWideStringField;
    StringField5: TWideStringField;
    DateTimeField1: TDateTimeField;
    LargeintField1: TLargeintField;
    qryProductCommissionCommission: TWideStringField;
    qryemployeeProductCommissionCommission: TWideStringField;
    QryEmployeeNoCommissionProducts: TERPQuery;
    QryEmployeeNoCommissionProductsGlobalref: TWideStringField;
    QryEmployeeNoCommissionProductsID: TIntegerField;
    QryEmployeeNoCommissionProductsEmployeeID: TIntegerField;
    QryEmployeeNoCommissionProductsProductID: TIntegerField;
    QryEmployeeNoCommissionProductsProductName: TWideStringField;
    QryEmployeeNoCommissionProductsmstimestamp: TDateTimeField;
    QryEmployeeNoCommissionProductsCommission: TWideStringField;
    Qryemployeeskills: TERPQuery;
    QryemployeeskillsGlobalRef: TWideStringField;
    QryemployeeskillsEmpSkillID: TIntegerField;
    QryemployeeskillsEmployeeID: TIntegerField;
    QryemployeeskillsSkillID: TIntegerField;
    QryemployeeskillsSkillLevelName: TWideStringField;
    QryemployeeskillsEditedFlag: TWideStringField;
    QryemployeeskillsSkillLevel: TIntegerField;
    QryemployeeskillsSkillExpDate: TDateField;
    QryemployeeskillsSecurityLevel: TIntegerField;
    QryemployeeskillsSecurityExpDate: TDateField;
    QryemployeeskillsmsTimeStamp: TDateTimeField;
    QryemployeeskillsProviderID: TIntegerField;
    QryemployeeskillsProviderName: TWideStringField;
    QryemployeeskillsTestMethod: TWideStringField;
    QryemployeeskillsCertificate: TWideStringField;
    QryemployeeskillsScheduledDate: TDateField;
    QryemployeeskillsCompletedDate: TDateField;
    QryemployeeskillsRenewalDate: TDateField;
    QryemployeeskillsRenewalOptions: TIntegerField;
    QryemployeeskillsRenewed: TWideStringField;
    QryemployeeskillsComments: TWideStringField;
    qryemployeeCallPriority: TIntegerField;
    qryemployeeDefaultContactMethod: TWideStringField;
    qryemployeeSkypeName: TWideStringField;
    qryemployeeTrackEmails: TWideStringField;
    qryreferenceGlobalRef: TWideStringField;
    qryreferenceLoyaltyProgram: TWideStringField;
    qryreferencemsTimeStamp: TDateTimeField;
    qryreferencemsUpdateSiteCode: TWideStringField;
    qryreferenceActive: TWideStringField;
    qryreferenceReferenceData: TBlobField;
    qryreferenceMessageId: TWideStringField;
    qryreferenceMessageFrom: TWideStringField;
    qryreferenceMessageTo: TWideStringField;
    qryemployeeArea: TWideStringField;
    qryreferenceStatus: TWideStringField;
    QryemployeeskillsSkillName: TWideStringField;
    qryemployeeGoogleEmail: TWideStringField;
    qryemployeeGooglePassword: TWideStringField;
    qryemployeeSynchWithGoogle: TWideStringField;
    qryemployeemsTimeStamp: TDateTimeField;
    qryemployeemsUpdateSiteCode: TWideStringField;
    OptionScrollbox: TScrollBox;
    qryemployeeClientID: TIntegerField;
    qryempPaySettingsSTPJobkeeperStartFN: TWideStringfield;
    qryempPaySettingsSTPJobkeeperFinishFN: TWideStringfield;
    qryempPaySettingsSTPTier: TIntegerField;
    qryPersonalPreferences: TERPQuery;
    qryEmpSkillsReminderDays: TIntegerField;
    QryemployeeskillsReminderDays: TIntegerField;
    pnlBottom: TDNMPanel;
    btnOK: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdPassword: TDNMSpeedButton;
    btnSupplier: TDNMSpeedButton;
    btnPrintBarcode: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnW4: TDNMSpeedButton;
    qryemployeeGoogleRefreshPassword: TWideStringField;
    qryemployeeOverheadRate: TFloatField;
    qryemployeeTrackSales: TWideStringField;
    qryreferenceHRFormID: TIntegerField;
    qryemployeeAssessableTermination: TFloatField;
    qryemployeeCommissionUseBoth: TWideStringField;
    qryemployeeEmployeeTypeID: TIntegerField;
    qryEmployeePayDeductionsTaxExempt: TWideStringField;
    DNMPanel1: TDNMPanel;
    chkActive: TwwCheckBox;
    qryempPaySettingsNonWageIncome: TFloatField;
    qryemployeeCreationDate: TDateTimeField;
    qryEmployeePayDeductionsBox12CodeID: TIntegerField;
    qryEmployeePayDeductionsTaxExemptFederal: TWideStringField;
    qryEmployeePayDeductionsTaxExemptState: TWideStringField;
    qryEmployeePayDeductionsTaxExemptSocial: TWideStringField;
    qryEmployeePayDeductionsTaxExemptMedicare: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cmdPasswordClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnPrintBarcodeClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Calccommission(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
    procedure QryemployeeskillsAfterInsert(DataSet: TDataSet);
    procedure OptionScrollboxDblClick(Sender: TObject);
    procedure btnSupplierClick(Sender: TObject);
    procedure qryemployeeEmployeeIDChange(Sender: TField);
    procedure qryemployeeAfterInsert(DataSet: TDataSet);
    procedure OptionScrollboxResize(Sender: TObject);
    procedure btnW4Click(Sender: TObject);
  private
    ffrmList1: TBaseListingGUI;
    fSuperFundNagged:Boolean;
    fNewEmployee:Boolean;
    fSingleButtonCaption: string;
    fTextSearch: string;
    fFocusControlName: string;
    fSourceForm: TForm;
    fPreventFinish: Boolean;
    fPanelColor: TColor;

    fbPayChangeOccured:boolean;
    PayUtils:Tpayutils;

    fsFirstName: string;
    fsLastName: string;
    FirstShow: boolean;
    ButtonCtr:Integer;
    Selectedbutton:TObject;
    fAfterPayCreate: TGeneralProc;
    fDisplayMode: TDisplayMode;
    mainbuttons :Array of TDNMSpeedbutton;
    CancelButtonclicked:Boolean;
    fPayListing           : TBaseListingGUI;
    fEmployeeReport       : TBaseListingGUI;
    fEmplyeeHRForm        : TBaseListingGUI;

    procedure LoadEmpTemplate(const TemplateName:String);
    function OfferToModifyPay:Boolean;
    procedure SetupActiveFrmBusObjs;
    procedure ShowSubForm(const TabName: String);
    procedure FocusComponent;
    procedure AddButton(const ButtonCaption: string; const ButtonTop: Integer);
    procedure AddMainButtons;
    procedure LoadPanels;
    procedure MainButtonClick(Sender: TObject);
    procedure ClearScrollBox;
    procedure SetScrollBarIncrement;
    procedure SetupConnections;
    procedure BuildSearchList;
    function FindMainButton(const Caption: string): TDNMSpeedButton;
    procedure CancelFinish(var Msg: TMessage); message TX_CancelFinish;
    procedure PerformTextSearch(var Msg: TMessage); message TX_PerformTextSearch;
    function IsButtonShown(const aButtonCaption: string): Boolean;
    procedure DoBusobjEvent_Common(const Sender: TDatasetBusObj; const EventType, Value: string);
    procedure DoBusobjEvent_PayUtils(const Sender: TDatasetBusObj; const EventType, Value: string);
    procedure PerformPaintPanel(var Msg: TMessage); message SX_InvalidatePanelHolderFrm;
    Procedure SetDisplaymode;
    Function HandleEmpFormErrors(FatalStatusItem: TResultStatusItem):Boolean;
    Function ChangePage(ButtonCaption:STring):boolean;
    procedure AssignDataset(DSrc: Tdatasource; Ds: TDataset);
    function ButtonForCaption(const aCaption: string): TDNMSpeedButton;
    function TabClassByTabName(const aTabName: string): string;
    function PayListing: TBaseListingGUI;
    function EmployeeReport: TBaseListingGUI;
    function EmplyeeHRForm: TBaseListingGUI;
    procedure InitPagecontrolsize;
    procedure Setbuttons;

  protected
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    function SaveOrCancelChanges: boolean;override;
    procedure OnFormShow(Sender: TObject);Override;
  public
    EmpPay:Temployeepay;
    Procedure AfterTranslate; Override;
    class procedure CloseMe; override;
    procedure SearchForText(const SearchStr: string; const FocusControlName: string = '');
    property SingleButtonCaption: string read fSingleButtonCaption write fSingleButtonCaption;
    property TextSearch: string read fTextSearch write fTextSearch;
    property FocusControlName: string read fFocusControlName write fFocusControlName;

    property NewFirstName: string read fsFirstName write fsFirstname;
    property NewLastName: string read fsLastName write fsLastName;
    Property AfterPayCreate :TGeneralProc Read fAfterPayCreate write fAfterPayCreate;
    Property Displaymode :TDisplayMode REad fDisplayMode write fDisplayMode;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
    Procedure LocateSkill(const EmpskillId :Integer;AFieldName:String);
    function Save(DoOfferToModifyPay: boolean = true): boolean;
    function Savencommit:Boolean;

  end;

implementation

uses
  CommonLib, DNMLib, StrUtils,
  CommonDBLib, AppEnvironment,EmployeePaySetupDetails,
  PayCommon,BusObjEmployeePaySettings,EmployeePaySetupLeave,
  EmployeePaySetupHours,EmployeePaySetupBanking,
  EmployeePaySetupDeductions,FormFactory,EmployeeInfoFrm,BusObjEmployeeDetails,EmployeeAddressFrm,
  EmployeePhotoFrm,EmployeeCustomFieldsFrm,EmployeeSuperFrm,
  EmployeeBenefitsFrm,EmployeeReportListFrm,EmployeeDocumentsFrm,
  tcTypes,BusObjConst,EmployeeAllowancesFrm,frmPasswordFrm,PrintTemplateObj,
  EmployeeWorkCoverFrm,EmployeeCommissionsFrm,FastFuncs,EmployeePaySetupNotes,
  FrmProductCommissionOptions, CommonFormLib, tcConst, EmployeeSkillsFrm,
  {EmployeeTaxationFrm, EmployeeTaxationUSFrm,}
  {EmployeeAccountsFrm, EmployeeAccountsUSFrm,} LogLib,
  EmployeeTaxFrm, EmployeeHRForms, tcDataUtils, PreferancesLib, frmPayW_4;


const
  cMainButtonWidth = 148;
  cMainButtonHeight = 28;
  cMainButtonGap = 1;
  cMainButtonLeft = 14;
  cMainButtonTopStart = 5;
  cMaxRange = 6000;

//  Tab_Accounts = 'Accounts';
  Tab_Address = 'Address';
  Tab_Allowances = 'Allowances';
  Tab_Banking = 'Banking';
  Tab_CustomFields= 'Custom Fields';
  Tab_Deductions = 'Deductions';
  Tab_Documents = 'Documents';
  Tab_HRForms = 'HR Forms';
  Tab_FringeBenefits = 'Fringe Benefits';
  Tab_Hours = 'Hours';
  Tab_Information = 'Information';
  Tab_LeaveAccruals = 'Leave Accruals';
  Tab_PayDetails = 'Pay Details';
  Tab_PayHistory = 'Pay History';
  Tab_PayNotes = 'Pay Notes';
  Tab_PhotoId = 'Photo ID';
  Tab_Report = 'Report';
  Tab_SalesCommission = 'Sales && Commission';
  Tab_SkillsAttachments = 'Skills / Attachments';
  Tab_Superannuation = 'Superannuation';
  Tab_Taxation = 'Taxation';
  Tab_Workcover = 'Workcover';
  Tab_Benefits = 'Benefits';
  Tab_Pension = 'Pension';

var
  Tabs: array[0..20] of array[0..1] of string =
    (
//      (Tab_Accounts         ,'TEmpAccounts'             ),
      (Tab_Address          ,'TEmployeeAddress'         ),
      (Tab_Allowances       ,'TfrmEmployeeAllowances'   ),
      (Tab_Banking          ,'TEmpPaySetUpBanking'      ),
      (Tab_CustomFields     ,'TEmployeeCustomFields'    ),
      (Tab_Deductions       ,'TEmpPaySetupDeductions'   ),
      (Tab_Documents        ,'TfrmEmployeeDocuments'    ),
      (Tab_FringeBenefits   ,'TfrmEmployeeBenefits'     ),
      (Tab_HRForms          ,'TEmployeeHRFormsGUI'      ),
      (Tab_Hours            ,'TEmpPaySetUpHours'        ),
      (Tab_Information      ,'TEmployeeInfo'            ),
      (Tab_LeaveAccruals    ,'TEmpPaySetupLeave'        ),
      (Tab_PayDetails       ,'TEmpPaySetupDetails'      ),
      (Tab_PayHistory       ,'TPayListingGUI'           ),
      (Tab_PayNotes         ,'TfrmEmployeePaySetupNotes'),
      (Tab_PhotoId          ,'TEmployeePhoto'           ),
      (Tab_Report           ,'TEmployeeReportGUI'       ),
      (Tab_SalesCommission  ,'TfrmEmployeeCommissions'  ),
      (Tab_SkillsAttachments,'TfmEmployeeSkills'        ),
      (Tab_Superannuation   ,'TEmployeeSuper'           ),
      (Tab_Taxation         ,'TEmpTaxGUI'               ),
      (Tab_Workcover        ,'TfrmEmployeeWorkcover'    ));

{$R *.dfm}

procedure TfrmEmployee.FormCreate(Sender: TObject);
begin
  inherited;
  AlignbuttonTopnHeight(pnlBottom);

  CancelButtonclicked:= False;
  fDisplayMode := dmNone;
  fAfterPayCreate := nil;
  Selectedbutton:=nil;
  ButtonCtr := 0;
  UserLock.Enabled := true;
  fbTabSettingEnabled := False;
  fTextSearch := '';
  fFocusControlName := '';
  fSingleButtonCaption := '';
  fSourceForm := nil;
  fPreventFinish := False;
  fPanelColor := Self.color;
  pnlButtons.Color := fPanelColor;
  PayUtils := TPayUtils.Create(Self,Self.MyConnection);
  PayUtils.BusObjEvent := DoBusObjEvent_PayUtils;
  EmpPay := Temployeepay.Create(Self,Self.MyConnection) ;
  EmpPay.BusObjEvent := DoBusobjEvent_Common;
  FirstShow:= true;
end;

function TfrmEmployee.TabClassByTabName(const aTabName: string): string;
var
  x: integer;
begin
  result:= '';
  for x := Low(Tabs) to High(Tabs) do begin
    if SameText(aTabName,Tabs[x,0]) then begin
      result := Tabs[x,1];
      break;
    end;
  end;
  if result = '' then
    raise Exception.Create(ClassName + ': Tab / Button name '+ aTabName + ' not found');
end;

Procedure TfrmEmployee.AssignDataset(DSrc:Tdatasource; Ds:TDataset);
begin
  DSrc.DataSet := ds;
  DoTranslate(ds);
end;

procedure TfrmEmployee.SetupActiveFrmBusObjs;
begin
  if not Assigned(fSourceForm) then Exit;

  if fSourceForm is TfrmBaseGUI then
    TfrmBaseGUI(fSourceForm).DoTranslateFormLanguage;

  if fSourceform.ClassName = 'TfrmEmployeePaySetupNotes' then begin
    with TfrmEmployeePaySetupNotes(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSEmployees,SubEmpPay.EmployeeDetails.Dataset);
      TfrmEmployeePaySetupNotes(fSourceForm).memPayNotes.Lines.Text :=SubEmpPay.EmployeeDetails.PayNotes;
    end;
  end;

  if fSourceform.ClassName = 'TfrmEmployeeCommissions' then begin
    with TfrmEmployeeCommissions(fSourceForm) do begin
      SubEmpPay := EmpPay;

      Assigndataset(DSEmployees,SubEmpPay.EmployeeDetails.Dataset);
      Assigndataset(dsEmployeeProductCommission,SubEmpPay.EmployeeProductCommission.Dataset);
      Assigndataset(dsProductcommission,SubEmpPay.allEmployeeProductCommission.Dataset);
      Assigndataset(dsEmpNoCommsProducts,SubEmpPay.EmployeeNoCommissionProducts.Dataset);
      USeSalesCommission:= Appenv.CompanyPrefs.USeSalesCommission;
      mainpage.ActivePageIndex := 0;
    end;
  end;

  if fSourceform.ClassName = 'TfrmEmployeeWorkcover' then begin
    with TfrmEmployeeWorkcover(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(TfrmEmployeeWorkcover(fSourceForm).DSworkerscompensation,SubEmpPay.WorkersCompensation.Dataset);
      Assigndataset(DSEmployeeCompRate,SubEmpPay.EmployeePaySettings.Dataset);
      qryDepartment.Open;
    end;
  end;

  if fSourceform.ClassName = 'TfrmEmployeeDocuments' then begin
    with TfrmEmployeeDocuments(fSourceForm) do begin
      grdCorrespondence.SetControlType('active',fctCheckBox,'T;F');
      SubEmpPay := EmpPay;
      Assigndataset(DSReference,SubEmpPay.EmployeeCorrespondence.Dataset);
      qryDocPath.Open;

      SetSourceFrmButtons(TfrmBaseGUI(fSourceForm));
    end;
  end;

  if fSourceform.ClassName = 'TfmEmployeeSkills' then begin
    with TfmEmployeeSkills(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(dsemployeeskills, SubEmpPay.EmployeeSkills.Dataset);

      SetSourceFrmButtons(TfrmBaseGUI(fSourceForm));
    end;
  end;

  if fSourceform.ClassName = 'TfrmEmployeeBenefits' then begin
    with TfrmEmployeeBenefits(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSFBT,SubEmpPay.FringeBenefits.Dataset);
      qryDepartment.Open;
    end;
  end;

   if fSourceform.ClassName = 'TEmpPaySetupDetails' then begin
    with TEmpPaySetupDetails(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSEmpPaySettings,SubEmpPay.EmployeePaySettings.Dataset);
      Assigndataset(DSEmployees,SubEmpPay.EmployeeDetails.Dataset);
      qryAward.Open;
      Opendb(qrySTPJobkeeperstartFNList);
      Opendb(qrySTPJobkeeperFinishFNList);

      if SubEmpPay.EmployeeDetails.Award > 0 then
        qryAwardClfn.Params.ParamByName('AwardID').AsInteger := SubEmpPay.EmployeeDetails.Award;
      qryAwardClfn.Open;
      qryDepartment.Open;
      qryEmpNames.Params.ParamByName('KeyID').AsInteger := Self.KeyID;
      qryEmpNames.Open;
    end;
  end;

  if fSourceform.ClassName = 'TEmpTaxGUI' then begin
    with TEmpTaxGUI(fSourceForm) do begin
      TEmpTaxGUI(fSourceform).dsPersonalPreferences.DataSet := qryPersonalPreferences;
      SubEmpPay := EmpPay;
      AssignDataset(DSEmployees, SubEmpPay.EmployeeDetails.Dataset);
      AssignDataset(DSEmpPaySettings, SubEmpPay.EmployeePaySettings.Dataset);
      qryTaxScales.Open;
      qryTaxScale.Open;
      qryHECSTaxScales.Open;
      qryStudentLoanTaxScales.Open;
      qrySuppliers.Open;
    end;
  end;

  if fSourceform.ClassName = 'TEmployeeSuper' then begin
    with TEmployeeSuper(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSSuperannuation,SubEmpPay.Superannuation.Dataset);
      qrySuperType.Open;
      qrySuppliers.Open;
      qryDepartment.Open;
      QryAreaCodes.Open;
    end;
  end;

  if fSourceform.ClassName = 'TEmployeeCustomFields' then begin
    with TEmployeeCustomFields(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSEmployees,SubEmpPay.EmployeeDetails.Dataset);
      CustomFieldsRefresh;
    end;
  end;

  if fSourceform.ClassName = 'TEmployeePhoto' then begin
    with TEmployeePhoto(fSourceForm) do begin
      EmpPay := Temployeepay.Create(Self,Self.MyConnection) ;
      EmpPay.EmployeeDetails.Dataset := qryEmployeesPhoto;
      EmpPay.Load(Self.KeyID);
      TEmployeePhoto(fSourceForm).EmployeeID := Self.KeyID;
      //photo does not go thru busobj
      qryphotoBlob.Params.ParamByName('xID').asInteger := Self.KeyID;
      TEmployeePhoto(fSourceform).KeyID := Self.KeyID;
      qryphotoBlob.Open;
    end;
  end;

  if fSourceform.ClassName = 'TEmployeeInfo' then begin
    with TEmployeeInfo(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSEmployeesInfo,SubEmpPay.EmployeeDetails.Dataset);
      Assigndataset(dsPersonalPrefs,SubEmpPay.EmployeeDetails.PersonalPreferences.Dataset);
      qryDepartment.Open;
    end;
  end;

  if fSourceform.ClassName = 'TEmployeeAddress' then begin
    with TEmployeeAddress(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSEmployeesAddress,SubEmpPay.EmployeeDetails.Dataset);
      qrySuburb.Params.ParamByName('xRegionID').AsInteger:= AppEnv.RegionalOptions.ID;
      qrySuburb.Open;
    end;
  end;

  if fSourceform.ClassName = 'TEmpPaySetupDeductions' then begin

    with TEmpPaySetupDeductions(fSourceForm) do begin
      grdDeductions.ShowHint := true;
      grdDeductions.Hint := 'Pre-taxed:'+chr(13)+
                    '   When True : Deduction is Taken from Gross Pay(Pay Before Tax).'    + #10#13+
                    '   When False: Deduction is Taken from Net Pay  (Pay After Tax)';
      SubEmpPay := EmpPay;
          //delete unwanted currency symbols from dropdown component in grid
      if AppEnv.RegionalOptions.RegionType = rUK then begin
        if cboDeductCalcBy.Items.Strings[1] = '$'#9'$' then begin
          cboDeductCalcBy.Items.Delete(1);
        end;
      end else begin
        if (cboDeductCalcBy.Items.Count >2) And (cboDeductCalcBy.Items.Strings[2] = '£'#9'£') then begin
          cboDeductCalcBy.Items.Delete(2);
        end;
      end;

      Assigndataset(DSEmployeeDeductions,SubEmpPay.EmployeeDeductions.Dataset);
      qryDepartment.Open;
      qryBasedOn.Open;
      qryDeductions.Open;
      QryAreaCodes.Open;

      //change CalcBy to Regional currency symbol if necessary
      with SubEmpPay.EmployeeDeductions.Dataset  do begin
        First;
        while not eof do begin
          //in case the allowance was originaly created in another region;
          if SubEmpPay.EmployeeDeductions.Calcby <> '%' then SubEmpPay.EmployeeDeductions.Calcby := AppEnv.RegionalOptions.CurrencySymbol;
          Next;
        end;
      end;
    end;
  end;

  if fSourceform.ClassName = 'TEmpPaySetupLeave' then begin
    with TEmpPaySetupLeave(fSourceForm) do begin
      SubEmpPay := EmpPay;
      SubPayUtils := PayUtils;

      Assigndataset(DSLeave,SubEmpPay.EmployeeLeaves.Dataset);
      Assigndataset(DSEmployee,SubEmpPay.EmployeeDetails.Dataset);

      //open lookup queries
      qryPayRates.Open;
      qryPayRateType.Open;
      qryJobs.Open;
      qryLeaveTypes.Open;
      qryDepartment.Open;
     end;
  end;

  if fSourceform.ClassName = 'TfrmEmployeeAllowances' then begin
    with TfrmEmployeeAllowances(fSourceForm) do begin

      grdAllowances.ShowHint := true;
      grdAllowances.Hint := 'Pre-taxed:'+chr(13)+
                            '   When True : Allowance is Added To Gross Pay(Pay before tax).'    + #10#13+
                            '   When False: Allowance is Added To Net Pay  (Pay after tax)';
      SubEmpPay := EmpPay;

    //delete unwanted currency symbols from dropdown component in grid
      if AppEnv.RegionalOptions.RegionType = rUK then begin
        if cboAllowCalcBy.Items.Strings[1] = '$'#9'$' then begin
          cboAllowCalcBy.Items.Delete(1);
        end;
      end else begin
        if (cboAllowCalcBy.Items.Count >2) And (cboAllowCalcBy.Items.Strings[2] = '£'#9'£') then begin
          cboAllowCalcBy.Items.Delete(2);
        end;
      end;

      Assigndataset(DSEmployeeAllowances,SubEmpPay.EmployeeAllowances.Dataset);
      qryCustomers.Open;
      qryAllowances.Open;
      qryDepartment.Open;
      qryBasedOn.Open;
      QryAreaCodes.Open;

    end;
  end;

  if fSourceform.ClassName = 'TEmpPaySetUpHours' then begin
    with TEmpPaySetUpHours(fSourceForm) do begin
      SubEmpPay := EmpPay;
      Assigndataset(DSEmployeePayRates,SubEmpPay.EmployeePayRates.Dataset);
      qryDepartment.Open;
      qryCustomers.Open;
      qryJobs.Open;
      qryPayRateType.Open;
      qryPayRates.Open;
    end;
  end;

  if fSourceform.ClassName = 'TEmpPaySetUpBanking' then begin
    with TEmpPaySetUpBanking(fSourceForm) do begin
      SubEmpPay := EmpPay;

      grdBanking.DataSource := DSPaySplit;

      Assigndataset(DSPaySplit,SubEmpPay.EmployeePaySplit.Dataset);
      qryBankCodes.Open;
    end;
  end;
//  if fSourceform.ClassName = 'TEmpAccounts' then begin
//    TEmpAccounts(fSourceform).qryAccount.Open;
//    TEmpAccounts(fSourceform).dsPersonalPreferences.DataSet := qryPersonalPreferences;
//  end;
//  if fSourceform.ClassName = 'TEmpAccountsUS' then begin
//    TEmpAccountsUS(fSourceform).qryAccount.Open;
//    TEmpAccountsUS(fSourceform).dsPersonalPreferences.DataSet := qryPersonalPreferences;
//  end;

end;

procedure TfrmEmployee.FormShow(Sender: TObject);
begin
DoShowProgressbar(25, WAITMSG);
try
  DisableForm;
  try
    inherited;
    if AccessLevel = 2 then
      AccessLevel:= 1;
    if UserLock.Enabled and (AccessLevel < 5) then begin
      // remove all existing locks
      UserLock.UnlockAllCurrentInstance;

      if (KeyId > 0) then begin
        if not UserLock.Lock('tblemployees', KeyId, Self.Caption) then begin
          AccessLevel := 5; // read only
          CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
            mtWarning, [mbOK], 0);
        end;
      end;
    end;
    DoStepProgressbar;
     EmpPay.Superannuation.Dataset          := qrysuperannuation;

    qryBankCodes.Open;  //lookup queries for lookup fields in queries below
    qryBasedOn.Open;
    qryCustomers.Open;
    qryPayRates.Open;
    qryPayRateType.Open;
    qryJobs.Open;
    qrySuperType.Open;
    qrySuppliers.Open;
    DoStepProgressbar;
    EmpPay.EmployeeDetails.Dataset                := qryemployee;
    EmpPay.EmployeeDetails.PersonalPreferences.Dataset := qryPersonalPreferences;
    EmpPay.EmployeePaySplit.Dataset               := qryemployeePaySplit;
    EmpPay.EmployeeAllowances.Dataset             := qryemployeePayAllowances;
    EmpPay.FringeBenefits.Dataset                 := qryFBT;
    EmpPay.EmployeeDeductions.Dataset             := qryemployeepaydeductions;
    EmpPay.EmployeeCorrespondence.Dataset         := qryReference;
    EmpPay.EmployeeSkills.Dataset                 := Qryemployeeskills;
    EmpPay.EmployeePayRates.Dataset               := qryEmployeePayRates;
    EmpPay.EmployeeLeaves.Dataset                 := qryLeave;
    EmpPay.EmployeePaySettings.Dataset            := qryEmpPaySettings;
    EmpPay.WorkersCompensation.Dataset            := qryworkerscompensation;
    EmpPay.EmployeeProductCommission.Dataset      := qryemployeeProductCommission;
    EmpPay.allEmployeeProductCommission.Dataset   := qryProductCommission;
    EmpPay.EmployeeNoCommissionProducts.Dataset   := QryEmployeeNoCommissionProducts;
    Setlength(mainbuttons,1);
    BeginTransaction;
    DoStepProgressbar;

    EmpPay.Load(Self.KeyID);
    if Self.KeyID <> 0 then begin
      //EmpPay.Load(Self.KeyID);

      if (qryemployeeEmployeeNo.asInteger < 1) and AppEnv.CompanyPrefs.GenerateEmployeeno and (AccessLevel = 1) then begin
        try
          EditDB(qryEmployee);
          qryemployeeEmployeeNo.asInteger := strtoint(CommonDbLib.GetSequenceNumber('EmployeeNo', LastEmployeeNo));
          PostDB(qryEmployee);
        Except
        end;
      end;

    end
    else begin
      fNewEmployee := True;
      EmpPay.EmployeeDetails.Load(0);
      EmpPay.EmployeeDetails.New;
      EmpPay.EmployeeDetails.Defaultclassname := AppEnv.DefaultClass.DefaultClassName;
      EmpPay.EmployeeDetails.PostDb;
      KeyID := EmpPay.EmployeeDetails.Id;
      EmpPay.Load(KeyID);
      if EmpPay.EmployeePaySettings.Dataset.RecordCount = 0 then begin
      end;
    end;
    DoStepProgressbar;
    EmpPay.EmployeeDetails.PersonalPreferences;
    //qryPersonalPreferences.ParamByName('EmployeeID').AsInteger := KeyID;
    OpenDb(qryPersonalPreferences);
    DoStepProgressbar;
    if EmpPay.EmployeeDetails.Active then
      chkActive.Checked := True
    else
      chkActive.Checked := False;
    DoStepProgressbar;
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnEmployeeBarcode') = 1 then begin
      btnPrintBarcode.Enabled := true;
    end;
    if cboSearch.visible then
      if FirstShow then
        BuildSearchList;

    if (SingleButtonCaption <> '') then begin
      AddButton(SingleButtonCaption, cMainButtonTopStart);
      fSourceForm := TForm(MakeForm(TabClassByTabName(SingleButtonCaption)));
      pnlActiveForm.Caption :=  SingleButtonCaption + ': ' + GetEmployeeName(Self.KeyID);
    end
    else begin
      AddMainButtons;

      if TextSearch = '' then begin
        fSourceForm := TForm(MakeForm(TabClassByTabName(Tab_Information)));
        pnlActiveForm.Caption :=  Tab_Information+ ': ' + GetEmployeeName(Self.KeyID);
      end;
    end;
    DoStepProgressbar;
    if Assigned(fSourceForm) then begin
      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;

      SetupActiveFrmBusObjs;

      LoadPanels;
      PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
      FocusComponent;
    end;
     DoStepProgressbar;
    SetDisplaymode;
  finally
    Setbuttons;
    FirstShow := false;
    InitPagecontrolsize;
    EnableForm;
  end;
finally
  DoHideProgressbar;
end;
end;

Function TfrmEmployee.HandleEmpFormErrors(FatalStatusItem: TResultStatusItem):boolean;
begin
  Result := False;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_EmployeePay_Err_NoAccountName,
      BOR_EmployeePay_Err_NoBank,
      BOR_EmployeePay_Err_NoBSBNumber ,
      BOR_EmployeePay_Err_NoAccountNumber,
      BOR_EmployeePay_Err_NoBankAmount,
      BOR_EmployeePay_Err_NoSplit,
      BOR_PaySplits_Err_NoBranch,
      BOR_EmployeePay_Err_RemainderWithOneRec :  begin
          if ChangePage('Banking') then
            if (assigned(fSourceForm)) and (fSourceForm is TEmpPaySetUpBanking) then begin
              TEmpPaySetUpBanking(fSourceForm).HandleEmployeePaySplitsErrors(FatalStatusItem);
              REsult := True;
            end;
        end;
    end;
  end;


end;

procedure TfrmEmployee.FormDestroy(Sender: TObject);
begin
  if FormStillOpen('TFmProductCommissionOptions') then
      TFmProductCommissionOptions(FindExistingComponent('TFmProductCommissionOptions')).close;
  Screen.OnActiveFormChange := nil;
  ClearScrollBox;
  PayUtils.Free;
  EmpPay.Free;
  inherited;
end;

procedure TfrmEmployee.btnCancelClick(Sender: TObject);
begin
  CancelButtonclicked := true;
  DisableForm;
  try
    Self.Close;
  finally
    EnableForm;
    CancelButtonclicked:= False;
  end;
end;

procedure TfrmEmployee.AddMainButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
begin
  ButtonTop := cMainButtonTopStart;

  for ButtonIndex := Low(Tabs) to High(Tabs) do begin
//    if SameText(Tabs[ButtonIndex,0],Tab_Accounts) and (not DnMLib.HasPayrollAccess) then
//      continue;
    if IsButtonShown(Tabs[ButtonIndex,0]) then begin
      AddButton(Tabs[ButtonIndex,0], ButtonTop);
      ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
    end;
  end;
  pnlButtons.Height := ButtonTop;
  if pnlButtons.Height > self.ClientHeight then begin
    pnlButtons.Width := sbButtons.ClientWidth;
    for ButtonIndex := 0 to pnlButtons.ControlCount -1 do begin
      pnlButtons.Controls[ButtonIndex].Left := 7;
    end;

  end
  else begin
    pnlButtons.Width := sbButtons.ClientWidth;


  end;
end;

procedure TfrmEmployee.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActiveForm.caption := TDNMSpeedButton(Selectedbutton).caption+ ': ' + GetEmployeeName(Self.KeyID);
end;

procedure TfrmEmployee.LoadPanels;
var
  TmpPanel: TDNMPanel;
  CurrentTop: Integer;
  PanelIndex: Integer;
  PanelList: TList;
  Bitmap: TBitmap;
  BitmapName: string;

  function GetPanel(Order: Integer): TDNMPanel;
  var
    Index: Integer;
  begin
    Result := nil;
    Index := 0;

    while (Index < fSourceForm.ControlCount) and (Result = nil) do begin
      if (fSourceForm.Controls[Index] is TDNMPanel) and
         (TDNMPanel(fSourceForm.Controls[Index]).TabOrder = Order) then
        Result := TDNMPanel(fSourceForm.Controls[Index])
      else
        Inc(Index);
    end;
  end;

  procedure SetPanelProperties(const Panel: TDNMPanel);
  begin
    Panel.BevelOuter := bvNone;
    Panel.Transparent := False;
    //Panel.Color := fPanelColor;
    Panel.Left := 0;
    Panel.Top := CurrentTop;
    Panel.DoubleBuffered := True;
    Panel.Anchors := [akLeft,akTop,akRight,akBottom];
    if Panel.Height < optionscrollbox.Height - (Panel.top *2) then
      Panel.Height := optionscrollbox.Height - (Panel.top *2);
    if Panel.Width < optionscrollbox.Width - (Panel.Left *2) then
      Panel.Width := optionscrollbox.Width - (Panel.Left *2);
    Panel.Parent := optionscrollbox;
    { for some reason after displaying a wider panel (list) the scroll box
      will display horiz scroll bar for paneles that are correct size ..
      the following is to fix this }
  end;

begin
  PanelList := TList.Create;
  Bitmap := TBitmap.Create;

  try
    if FileExists(BitmapName) then
      Bitmap.LoadFromFile(BitmapName);

    PanelIndex := 0;
    TmpPanel := GetPanel(PanelIndex);

    while Assigned(TmpPanel) do begin
      PanelList.Add(TmpPanel);

      Inc(PanelIndex);
      TmpPanel := GetPanel(PanelIndex);
    end;

    PanelIndex := 0;
    CurrentTop := 0;

    while PanelIndex < PanelList.Count do begin
      TmpPanel := TDNMPanel(PanelList[PanelIndex]);
      if TmpPanel.Visible then begin

        SetPanelProperties(TmpPanel);

        CurrentTop := CurrentTop + TmpPanel.Height;
      end;
      Inc(PanelIndex);
    end;
  finally
    FreeandNil(PanelList);
    FreeandNil(Bitmap);
  end;
end;

procedure TfrmEmployee.LocateSkill(const EmpskillId :Integer; AFieldName:String);
begin
  if KeyId =0 then exit;
  try
    ChangePage(Tab_SkillsAttachments);
    Qryemployeeskills.Locate('EmpSkillID' , EmpskillId , []);
    if fSourceForm is TfmEmployeeSkills then
    Setcontrolfocus(TfmEmployeeSkills(fSourceForm).grdemployeeskills);
    if AFieldName <> '' then TfmEmployeeSkills(fSourceForm).grdemployeeskills.SetActiveField(AFieldName);
  Except
    // kill exception if any
  end;
end;

function TfrmEmployee.OfferToModifyPay:Boolean;
var
  FatalStatusItem: TResultStatusItem;
begin
  Result := False;
  if not EmpPay.EmployeeDetails.Active then Begin
    Result := True; { Added To Cater for Save Inactive Employee}
    exit;
  end;

  if UnprocessedPayExists(Self.KeyID) = 0 then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish to Create a Pay for this Employee?',mtConfirmation,[mbYes,mbNo],0)of
      mrYes: begin
          EmpPay.EmployeePaySettings.PostDb;
          if EmpPay.EmployeePaySettings.Dataset.RecordCount = 0 then begin {added to cater for creating an employee with payroll turned on but not creating a pay till asked}
            EmpPay.EmployeePaySettings.New;
            if not EmpPay.Save then exit;
          end;
          if PayUtils.CreateNewPay(Self.KeyID,True,False , FatalStatusItem) then begin//new employee
            if assigned(fAfterPayCreate) then fAfterPayCreate
            else CommonLib.MessageDlgXP_Vista('Pay created.', mtInformation , [mbOK], 0);

            Result := True;
          end else begin
            CommonLib.MessageDlgXP_Vista('This Employees Pay was NOT Created.', mtInformation , [mbOK], 0);
          end;
      end;
      mrNo: begin
        if EmpPay.EmployeePaySettings.Isontheroster = True then EmpPay.EmployeePaySettings.Isontheroster := False; //can't be on the roster without an unprocessed pay
        Result := True;
      end;
    end;
  end else begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish to Modify this Employees Existing Pay?',mtConfirmation,[mbYes,mbNo],0) of
      mrYes: begin
          if PayUtils.CreateNewPay(Self.KeyID,False,True, FatalStatusItem) then begin
            if Assigned(fAfterPayCreate) then fAfterPayCreate
            else CommonLib.MessageDlgXP_Vista('Pay modified.', mtInformation , [mbOK], 0);
            Result := True;
          end else begin
            if not HandleEmpFormErrors(FatalStatusItem) then
              CommonLib.MessageDlgXP_Vista('This Employee Pay was NOT Modified.', mtInformation , [mbOK], 0);
          end;
      end;
      mrNo: begin
        Result := True;
      end;
    end;
  end;
end;

procedure TfrmEmployee.OnFormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmEmployee.OptionScrollboxDblClick(Sender: TObject);
begin
  inherited;
  if devmode then
    if assigned(fSourceForm) then
      MessageDlgXP_Vista(fSourceForm.Classname, mtWarning, [mbOK], 0);
end;

procedure TfrmEmployee.OptionScrollboxResize(Sender: TObject);
begin
  inherited;
  InitPagecontrolsize;
end;

procedure TfrmEmployee.MainButtonClick(Sender: TObject);
begin
  Disableform;
  try
    if Sender is TDNMSpeedButton then begin
      if SameText(EnglishCaption(TDNMSpeedButton(Sender)),Tab_Superannuation) then begin
        EmpPay.EmployeePaySettings.PostDB;
        if EmpPay.EmployeePaySettings.Count = 0 then begin
          CommonLib.MessageDlgXP_Vista('Please complete Pay Details before adding Superannuation details',mtInformation,[mbOk],0);
          exit;
        end;
      end;

      if TabClassByTabName(EnglishCaption(TDNMSpeedButton(Sender))) <> fSourceForm.ClassName then begin

        if fSourceForm<> nil then begin
          if fSourceForm is TBaseInputGUI then
            TBaseInputGUI(fSourceForm).GuiPrefs.SavePrefs;
          if fSourceForm is TfrmEmployeePaySetupNotes then
            EmpPay.EmployeeDetails.PayNotes := TfrmEmployeePaySetupNotes(fSourceForm).memPayNotes.Lines.Text;
        end;

        Selectedbutton:= sender;
        ClearScrollBox;
        try
          FreeAndNil(ffrmList1);
        except
        end;
        ffrmList1:= nil;
        if not fPreventFinish then begin

        if Sametext(TabClassByTabName(EnglishCaption(TDNMSpeedButton(Sender))) ,'TPayListingGUI') then begin
          fSourceForm:= PayListing;
        end else if Sametext(TabClassByTabName(EnglishCaption(TDNMSpeedButton(Sender))) ,'TEmployeeReportGUI') then begin
          fSourceForm:= EmployeeReport;
        end else if Sametext(TabClassByTabName(EnglishCaption(TDNMSpeedButton(Sender))) ,'TEmployeeHRFormsGUI') then begin
          fSourceForm:= EmplyeeHRForm;
        end else
          fSourceForm := TForm(MakeForm(TabClassByTabName(EnglishCaption(TDNMSpeedButton(Sender)))));

          { LIST FORMS The employee form loads a blank and the list form opens on top of employee form.}

          if Assigned(fSourceForm) then begin
            TDNMSpeedButton(Sender).HelpContext:= fSourceForm.HelpContext;
            if assigned(fSourceForm) and (fSourceForm is TBaseListingGUI) then begin
                TBaseListingGUI(fSourceForm).Anchors:= [akLeft,akTop,akRight,akBottom];
                TBaseListingGUI(fSourceForm).Height := optionscrollbox.Height - (TBaseListingGUI(fSourceForm).top *2);
                TBaseListingGUI(fSourceForm).Width := optionscrollbox.Width - (TBaseListingGUI(fSourceForm).Left *2);
                TBaseListingGUI(fSourceForm).Parent := OptionScrollbox;
                TBaseListingGUI(fSourceForm).align := alclient;
                TBaseListingGUI(fSourceForm).BorderStyle := bsNone;
                TBaseListingGUI(fSourceForm).fbIgnoreQuerySpeed := true;
                try
                  TBaseListingGUI(fSourceForm).Show;
                  (*if  fSourceForm = fEmplyeeHRForm then begin
                    TEmployeeHRFormsGUI(fEmplyeeHRForm).EmployeeId :=
                    TEmployeeHRFormsGUI(fEmplyeeHRForm).btnNewHrform.Width := 90;
                    TEmployeeHRFormsGUI(fEmplyeeHRForm).Centralisebuttons(TEmployeeHRFormsGUI(fEmplyeeHRForm).pnlNewHrform);
                  end;*)
                except
                  FreeAndNil(TBaseListingGUI(fSourceForm));
                end;
            end else begin
//              AppEnv.RegionalOptions.ChangeForm(fSourceForm);
              SetupConnections;
              SetupActiveFrmBusObjs;
              if fSourceForm is TBaseInputGUI then begin
                TBaseInputGUI(fSourceForm).GuiPrefs.active := TRue;
                TBaseInputGUI(fSourceForm).ReadSubformGuiPrefs;

             end;
              AppEnv.RegionalOptions.ChangeForm(fSourceForm);

             LoadPanels;
             if fSourceForm.classname = 'TfmEmployeeSkills' then TfmEmployeeSkills(fSourceForm).AddAttachmentsForm;
            end;
            pnlActiveForm.Caption := TDNMSpeedButton(Sender).Caption  + ': ' + EmpPay.EmployeeDetails.Employeename;
            PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
            FocusComponent;
          end;
        end
        else
          fPreventFinish := False;
      end;

      if SameText(EnglishCaption(TDNMSpeedButton(Sender)),Tab_documents) then
        if fSourceForm<> nil then
          if fSourceForm is TfrmEmployeeDocuments then
            TfrmEmployeeDocuments(fSourceForm).RefreshQuery;
      InitPagecontrolsize;
      Application.ProcessMessages;
      if Self.WindowState = wsMaximized then Self.FormResize(Self);
    end;
  finally
    Enableform;
  end;
end;

(*function TfrmEmployee.MakeForm(Const ComponentClassName: string;
                                 Const SingleInstance: boolean = true;
                                 Const Owner: TComponent = nil;
                                 Const CheckAccessLevel:Boolean=true;
                                 Const showErrorMsg :Boolean = True;
                                 Const iTag: Integer = 0): TComponent;
begin
    Result := FindExistingComponent(ComponentClassName,iTag);
    if Assigned(Result) then Exit;
    result := GetComponentByClassName(ComponentClassName,SingleInstance,Owner,CheckAccessLevel,showErrorMsg,iTag);
    if result is TBaseInputGUI then begin
      TBaseInputGUI(result).CallHookupComboEvents;
    end;
end;*)

procedure TfrmEmployee.FocusComponent;
begin
  Application.ProcessMessages;  // because a windows message has just been sent.
  if fSourceform.ClassName = 'TEmployeeInfo' then SetControlFocus(TEmployeeInfo(fSourceForm).Title);
  if fSourceform.ClassName = 'TEmpPaySetupDetails' then SetControlFocus(TEmpPaySetupDetails(fSourceForm).PayPeriod);
  if fSourceform.ClassName = 'TEmpTaxGUI' then SetControlFocus(TEmpTaxGUI(fSourceForm).edTFN);
  if fSourceform.ClassName = 'TfrmEmployeeCommissions' then SetControlFocus(TfrmEmployeeCommissions(fSourceForm).chkUseEmpComm);
  if fSourceform.ClassName = 'TEmpPaySetUpHours' then begin
    TEmpPaySetUpHours(fSourceForm).grdPayRate.SetActiveField('PayRate');
    SetControlFocus(TEmpPaySetUpHours(fSourceForm).cboPayRate);
  end;
  if fSourceform.ClassName = 'TEmployeeSuper' then begin
    TEmployeeSuper(fSourceForm).grdSuperannuation.SetActiveField('SuperType');
    SetControlFocus(TEmployeeSuper(fSourceForm).cboSuperType);
  end;
end;

function TfrmEmployee.GetKeyString: string;
begin
  if qryEmployee.Active then
    result:= qryemployeeEmployeeName.AsString
  else
    result:= '';
end;

procedure TfrmEmployee.ClearScrollBox;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
     if not fPreventFinish then begin
      for Index := optionscrollbox.ControlCount - 1 downto 0 do begin
        if optionscrollbox.Controls[Index].Owner is TForm then
          optionscrollbox.Controls[Index].Parent := TForm(TComponent(optionscrollbox.Controls[Index]).Owner);
      end;

      try
        fSourceForm.Release;
      except

      end;
      { allow form to process all messages before setting reference to nil }
      Application.ProcessMessages;
      fSourceForm := nil;
      fPayListing := nil;
      fEmployeeReport:= nil;
      fEmplyeeHRForm:= nil;
    end;
  end;
end;

procedure TfrmEmployee.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if fSourceForm<> nil then
    if fSourceForm is TBaseInputGUI then
      TBaseInputGUI(fSourceForm).GuiPrefs.SavePrefs;

  if ModalResult in [mrNone, mrCancel] then begin
    inherited;
    ClearScrollBox;

    if fPreventFinish then begin
      fPreventFinish := False;
      Action := caNone;
    end
    else begin
      RollbackTransaction;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
    end;
  end;
end;

procedure TfrmEmployee.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if CancelButtonclicked then begin
    Canclose:= SaveOrCancelChanges;
  end;
end;

function TfrmEmployee.Save(DoOfferToModifyPay: boolean): boolean;
var
  FatalStatusItem: TResultStatusItem;
  qry: TERPQuery;
  btn: TDNMSpeedButton;
begin
  result:= false;
  if (EmpPay.EmployeeDetails.firstname ='') and (EmpPay.EmployeeDetails.Lastname ='') then begin
    MessageDlgXP_Vista('Please Provide Firstname or Lastname', mtWarning, [mbOK], 0);
    Exit;
  end;
  PostDb(qryPersonalPreferences);
  if not EmpPay.EmployeeDetails.Active then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Options.FlatBuffers := True;
      qry.Connection := Self.MyConnection;
      qry.SQL.Add('SELECT EmployeeID,PayID FROM tblPays WHERE EmployeeID=' + QuotedStr(IntToStr(Self.KeyID))+ ' AND PAID <> "T"');
      qry.Open;
      if qry.RecordCount > 0 then begin
        qry.Delete;
      end;
      If not EmpPay.Save then Exit;
    finally
      FreeAndNil(qry);
    end;
  end else begin
    If not EmpPay.Save then Exit;

    if (AppEnv.Employee.PayrollAccess) and (AppEnv.CompanyPrefs.UsePayroll) then begin
      if not fSuperFundNagged then begin
        FatalStatusItem := EmpPay.Superannuation.ResultStatus.GetLastFatalStatusItem;
        if Assigned(FatalStatusItem) then begin
          case FatalStatusItem.Code of
            BOR_EmployeeSuper_NoFund_Nagged : begin
                                                fSuperFundNagged := True;
                                                CommonLib.MessageDlgXP_Vista('Although a Super Fund is not required to run pays it is recomended to select one.'+ NL+ FatalStatusItem.message, mtInformation , [mbOK], 0);
                                                if fSourceForm.ClassName <> 'TEmployeeSuper' then begin
                                                  btn := ButtonForCaption(Tab_Superannuation);
                                                  if Assigned(btn) then
                                                    MainButtonClick(btn);
                                                  exit;
                                                end;
                                              end;
          end;
        end;
      end;

      if DoOfferToModifyPay and AppEnv.CompanyPrefs.UsePayroll then
        if not OfferToModifyPay then exit;

    end;
  end;
  if fPreventFinish then exit;
  result:= true;
end;


function TfrmEmployee.SaveOrCancelChanges: boolean;
var
  iExitResult: integer;
begin
  Result := True;
  iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
    [mbYes, mbNo, mbCancel], 0);
  case iExitResult of
    mrYes:
      begin
        result := Save;
        if result then begin
          CommitTransaction;
          Notify(False);
        end;
      end;
    mrNo:
      begin;
        RollbackTransaction;
        REsult := true;
        Notify(true);
      end;
    mrCancel: REsult := false;
  end;
end;

procedure TfrmEmployee.btnOKClick(Sender: TObject);
begin
  if not Savencommit then exit;

  ClearScrollBox;
  Notify(False);
  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

function TfrmEmployee.Savencommit:Boolean;
begin
  result := False;
  DisableForm;
  try
    inherited;

    if not Save then exit;
    PreferancesLib.DoPrefAuditTrail;
    if not fPreventFinish then begin
      result :=  True;
      CommitTransaction;
      if AppEnv.Employee.EmployeeID = self.qryemployeeEmployeeID.AsInteger then
        AppEnv.Employee.PopulateMe(self.qryemployeeEmployeeID.AsInteger);

    end else
      fPreventFinish := False;

    if qryEmployee.FieldByName('EmployeeId').AsInteger = AppEnv.Employee.EmployeeID then
      AppEnv.Employee.PopulateMe(AppEnv.Employee.EmployeeID, false);
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployee.ShowSubForm(const TabName:String);
begin
  if Assigned(fSourceForm) then
    If SameText(TabClassByTabName(TabName), fSourceForm.Classname) then Exit;

  ClearScrollBox;
  SetControlFocus(FindMainButton(TabName));
  if not fPreventFinish then begin
    fSourceForm := TForm(MakeForm(TabClassByTabName(TabName)));
    if Assigned(fSourceForm) then begin
      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;
      SetupActiveFrmBusObjs;

      pnlActiveForm.Caption := TabName + ': ' + GetEmployeeName(Self.KeyID);
      LoadPanels;
      optionscrollbox.Refresh;
      imgPrefs.Picture.Graphic := nil;
      SetScrollBarIncrement;
      PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
      FocusComponent;
    end;
  end else  fPreventFinish := False;
end;

procedure TfrmEmployee.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  inherited;
  if Cancelled then begin

  end
  else begin
    if Assigned(aObject) then begin
      if aObject.ClassNameIs('TfmEmployeeCorrespondenceCreate') then begin
        CloseDb(qryReference);
        OpenDb(qryReference);
      end;
    end;
  end;
end;

procedure TfrmEmployee.SetDisplaymode;
var
  ctr:Integer;
begin
    if fDisplayMode = dmPaydetails then begin
      for ctr := low(mainbuttons) to high(Mainbuttons) do begin
        if mainbuttons[ctr] <> nil then
          if mainbuttons[ctr].caption = 'Pay Details' then begin
            mainbuttons[ctr].click;
            cmdNew.enabled := False;
          end;
      end;
    end;
end;

procedure TfrmEmployee.SetKeyString(const Value: string);
begin
  SetKeyString(TEmployeeDetails, qryEmployee, Value , 'EmployeeName');
end;

procedure TfrmEmployee.SetScrollBarIncrement;
begin
end;

procedure TfrmEmployee.SetupConnections;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
    for Index := 0 to fSourceForm.ComponentCount - 1 do begin
      if fSourceForm.Components[Index] is TERPQuery then begin
        TERPQuery(fSourceForm.Components[Index]).Connection := Self.MyConnection;
      end;
    end;
  end;
end;

procedure TfrmEmployee.BuildSearchList;
var
  Form: TForm;
  FormIndex: Integer;

  procedure AddCaptionsForForm(const Form: TForm; const FormID: string);
  var
    Index: Integer;
  begin
    for Index := 0 to Form.ComponentCount - 1 do begin
      if (Form.Components[Index] is TLabel) and (TLabel(Form.Components[Index]).Name <> 'lblWidth') and
         (not Sysutils.SameText(Copy(TLabel(Form.Components[Index]).Name, 1, 9), 'lblIgnore')) then
        cboSearch.Items.Add(Trim(TLabel(Form.Components[Index]).Caption) + ' | ' + FormID)
      else if (Form.Components[Index] is TwwRadioGroup) and (Trim(TwwRadioGroup(Form.Components[Index]).Caption) <> '') then
        cboSearch.Items.Add(Trim(TwwRadioGroup(Form.Components[Index]).Caption) + ' | ' + FormID)
      else if (Form.Components[Index] is TDNMSpeedButton) and (Trim(TDNMSpeedButton(Form.Components[Index]).Caption) <> '') then
        cboSearch.Items.Add(Trim(TDNMSpeedButton(Form.Components[Index]).Caption) + ' | ' + FormID);
    end;
  end;

begin
  cboSearch.Clear;

  if (SingleButtonCaption = '') or (AccessLevel = 1) then begin
    for FormIndex := Low(Tabs) to High(Tabs) do begin
      if IsButtonShown(Tabs[FormIndex,0]) then begin
        Form := TForm(MakeForm(Tabs[FormIndex,1]));

        try
          if Assigned(Form) then begin
            AppEnv.RegionalOptions.ChangeForm(Form);
            AddCaptionsForForm(Form, Tabs[FormIndex,0]);
          end;
        finally
          FreeAndNil(Form);
        end;
      end;
    end;
  end
  else begin
    Form := TForm(MakeForm(TabClassByTabName(SingleButtonCaption)));

    try
      if Assigned(Form) then begin
        AppEnv.RegionalOptions.ChangeForm(Form);
        AddCaptionsForForm(Form, SingleButtonCaption);
      end;
    finally
      FreeAndNil(Form);
    end;
  end;
end;

function TfrmEmployee.ButtonForCaption(const aCaption: string): TDNMSpeedButton;
var
  x: integer;
begin
  result := nil;
  for x := 0 to self.ComponentCount -1 do begin
    if (self.Components[x] is TDNMSpeedButton) and
      SameText(TDNMSpeedButton(self.Components[x]).Caption, aCaption) then begin
      result := TDNMSpeedButton(self.Components[x]);
      break;
    end;
  end;
end;

function TfrmEmployee.FindMainButton(const Caption: string): TDNMSpeedButton;
var
  Index: Integer;
  FoundButton: Boolean;
begin
  Index := 0;
  Result := nil;
  FoundButton := False;

  while (Index < ComponentCount) and (not FoundButton) do begin
    if (Components[Index] is TDNMSpeedButton) and (TDNMSpeedButton(Components[Index]).Caption = Caption) then begin
      Result := TDNMSpeedButton(Components[Index]);
      FoundButton := True;
    end
    else
      Inc(Index);
  end;
end;

procedure TfrmEmployee.cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  Update;

  if not fPreventFinish then
    SearchForText(cboSearch.Text);
end;

Function TfrmEmployee.ChangePage(ButtonCaption: STring):boolean;
var
  ctr:Integer;
begin
  Result := False;
  for ctr:= low(mainbuttons) to high(mainbuttons) do begin
    if Sametext(mainbuttons[ctr].caption, ButtonCaption) then begin
      mainbuttonclick(TDNMSpeedButton(mainbuttons[ctr]));
      REsult := true;
    end;
  end;

end;

procedure TfrmEmployee.AddButton(const ButtonCaption: string; const ButtonTop: Integer);
var
  Button: TDNMSpeedButton;
begin
  Button := TDNMSpeedButton.Create(Self);
  Setlength(mainbuttons , high(mainbuttons)+2);
  mainbuttons[high(mainbuttons)] := button;
  with Button do begin
    Left := cMainButtonLeft;
    Top := ButtonTop;
    Width := cMainButtonWidth;
    Height := cMainButtonHeight;
    Caption := ButtonCaption;
    Parent := pnlButtons;
    Alignment := taCenter;
    Color := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
    inc(ButtonCtr);
    name := 'mainbutton'+inttostr(ButtonCtr);
    OnClick := MainButtonClick;
  end;

end;

procedure TfrmEmployee.SearchForText(const SearchStr: string; const FocusControlName: string = '');
var
  ControlIndex: Integer;
  PanelIndex: Integer;
  FoundControl: Boolean;
  Panel: TPanel;
  MainButton: TDNMSpeedButton;
  IndexOfText: Integer;
  ControlCaption: string;
  SearchText: string;
  DelimiterPos: Integer;
  TmpControl: TWinControl;
begin
  IndexOfText := cboSearch.Items.IndexOf(SearchStr);

  if IndexOfText >= 0 then begin
    DelimiterPos := FastFuncs.PosEx('|', SearchStr);
    SearchText := Copy(SearchStr, 1, DelimiterPos - 2);

    with cboSearch do
      MainButton := FindMainButton(Copy(SearchStr, DelimiterPos + 2, char_length(SearchStr) - DelimiterPos - 1));

    if Assigned(MainButton) then
      MainButton.Click;

    PanelIndex := 0;
    FoundControl := False;

    while (PanelIndex < optionscrollbox.ControlCount) and (not FoundControl) do begin
      Panel := TPanel(optionscrollbox.Controls[PanelIndex]);
      ControlIndex := 0;

      while (ControlIndex < Panel.ControlCount) and (not FoundControl) do begin
        if Panel.Controls[ControlIndex] is TLabel then
          ControlCaption := Trim(TLabel(Panel.Controls[ControlIndex]).Caption)
        else if Panel.Controls[ControlIndex] is TwwRadioGroup then
          ControlCaption := Trim(TwwRadioGroup(Panel.Controls[ControlIndex]).Caption)
        else if Panel.Controls[ControlIndex] is TDNMSpeedButton then
          ControlCaption := Trim(TDNMSpeedButton(Panel.Controls[ControlIndex]).Caption)
        else
          ControlCaption := '';

        if ControlCaption <> '' then begin
          if Sysutils.SameText(ControlCaption, SearchText) then begin
            FoundControl := True;
          end
          else
            Inc(ControlIndex);
        end
        else
          Inc(ControlIndex);
      end;

      Inc(PanelIndex);
    end;

    if FoundControl and (FocusControlName <> '') then begin
      TmpControl := TWinControl(fSourceForm.FindComponent(FocusControlName));

      if Assigned(TmpControl) then
        SetControlFocus(TmpControl);
    end;
  end;
end;

procedure TfrmEmployee.PerformTextSearch(var Msg: TMessage);
begin
  SearchForText('Default Accounts Receivables Account | Sales', 'cboDefaultSales');
end;

procedure TfrmEmployee.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmEmployee.qryemployeeAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if AppEnv.CompanyPrefs.GenerateEmployeeno then
    try
      qryemployeeEmployeeNo.asInteger := strtoint(CommonDbLib.GetSequenceNumber('EmployeeNo', LastEmployeeNo));
    Except
    end;
end;

procedure TfrmEmployee.qryemployeeEmployeeIDChange(Sender: TField);
begin
  inherited;
  CloseDb(qryPersonalPreferences);
  qryPersonalPreferences.ParamByName('EmployeeID').AsInteger := qryemployeeEmployeeID.AsInteger;
  OpenDb(qryPersonalPreferences);
end;

procedure TfrmEmployee.QryemployeeskillsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QryemployeeskillsSkilllevelName.AsString := '';
end;

procedure TfrmEmployee.CancelFinish(var Msg: TMessage);
begin
  fPreventFinish := True;
end;

function TfrmEmployee.IsButtonShown(const aButtonCaption: string): Boolean;
begin
  Result := True;

  if Sysutils.SameText(aButtonCaption, Tab_Allowances)
    or Sysutils.SameText(aButtonCaption, Tab_Superannuation)
    or Sysutils.SameText(aButtonCaption, Tab_Banking)
    or Sysutils.SameText(aButtonCaption, Tab_Benefits)
    or Sysutils.SameText(aButtonCaption, Tab_SalesCommission)
    or Sysutils.SameText(aButtonCaption, Tab_Deductions)
    or Sysutils.SameText(aButtonCaption, Tab_FringeBenefits)
    or Sysutils.SameText(aButtonCaption, Tab_PayDetails)
    or Sysutils.SameText(aButtonCaption, Tab_PayHistory)
    or Sysutils.SameText(aButtonCaption, Tab_Taxation)
    or Sysutils.SameText(aButtonCaption, Tab_LeaveAccruals)
    or Sysutils.SameText(aButtonCaption, Tab_Pension)
    or Sysutils.SameText(aButtonCaption, Tab_PayNotes)
    or Sysutils.SameText(aButtonCaption, Tab_Hours) then begin

    if not (AppEnv.CompanyPrefs.UsePayroll and AppEnv.Employee.PayrollAccess) then begin
      Result := False;
      exit;
    end;
  end;

  if Sysutils.SameText(aButtonCaption, Tab_Report    ) then if AppEnv.AccessLevels.GetEmployeeAccessLevel('TEmployeeReportGUI' ) >= 6 then Result := False;
  if Sysutils.SameText(aButtonCaption, Tab_HRForms   ) then if AppEnv.AccessLevels.GetEmployeeAccessLevel('TEmployeeHRFormsGUI') >= 6 then Result := False;
  if Sysutils.SameText(aButtonCaption, Tab_PayHistory) then if AppEnv.AccessLevels.GetEmployeeAccessLevel('TPayListingGUI'     ) >= 6 then Result := False;
  if AppEnv.RegionalOptions.RegionType <> rAUST then begin
    { no super in usa }
    if Sysutils.SameText(aButtonCaption, Tab_Superannuation) then
      result := false;
  end;

end;

class procedure TfrmEmployee.CloseMe;
begin
  if FormStillOpen('TfrmEmployee') then begin
      TfrmEmployee(FindExistingComponent('TfrmEmployee')).Close;
      Application.ProcessMessages;
  end;
end;

procedure TfrmEmployee.cmdPasswordClick(Sender: TObject);
var
  Form : TComponent;
begin
  DisableForm;
  try
    if Save(false) then begin
      CommitTransaction;
      BeginTransaction;
    end
    else begin
      exit;
    end;
    Form := MakeForm('TfrmPassword');
    if Assigned(Form) then begin
      with TfrmPassword(Form) do begin
        PassedConnection:= MyConnection;
        KeyID     :=  EmpPay.EmployeeDetails.id;
        TfrmPassword(Form).EmployeeName := EmpPay.EmployeeDetails.Employeename;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployee.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;

    If not EmpPay.Save then Exit;

    if AppEnv.CompanyPrefs.UsePayroll then
      if (fbPayChangeOccured = True) or (NoPaysExistForEmployee(Self.KeyID)) then
        OfferToModifyPay;

    ClearScrollBox;

    CommitTransaction;
    BeginTransaction;
    KeyID := 0;

    SetLength(buttons, 0);

    FormShow(nil);
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployee.btnPrintBarcodeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    Self.LoadEmpTemplate(GetReportNameForTypeName('Employee'));
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployee.btnSupplierClick(Sender: TObject);
begin
  inherited;
  EmpPay.EmployeeDetails.PostDB;
  if (EmpPay.EmployeeDetails.ID=0) or (EmpPay.EmployeeDetails.EmployeeName = '') or (EmpPay.EmployeeDetails.firstname = '') or (EmpPay.EmployeeDetails.lastname ='') then begin
    MessageDlgXP_Vista('Please provide the Employee Information', mtWarning, [mbOK], 0);
    ChangePage(Tab_Information);
    Exit;
  end;
  if EmpPay.EmployeeDetails.clientID>0 then begin
    MessageDlgXP_Vista('Employee ' +quotedstr(EmpPay.EmployeeDetails.EmployeeName)+' is already a Supplier', mtWarning, [mbOK], 0);
    Exit;
  end;
  if EmpPay.EmployeeDetails.CopyTosupplier <> 0 then
    MessageDlg('Employee ' +quotedstr(EmpPay.EmployeeDetails.EmployeeName)+' is converted to a Supplier. Please save the employee card', mtWarning, [mbOK], 0);;
end;

procedure TfrmEmployee.btnW4Click(Sender: TObject);
var
  FmTemp: Tform;
begin
  inherited;
  FmTemp := fsourceForm;
  try
    fsourceForm := TForm(getcomponentbyClassname('TfmPayW_4', False, Self, False));

    SetupConnections;
    SetupActiveFrmBusObjs;

    TBaseInputGUI(fSourceForm).GuiPrefs.active := TRue;
    TBaseInputGUI(fSourceForm).ReadSubformGuiPrefs;
    TfmPayW_4(fSourceForm).EmployeeID := Self.KeyID;

    AppEnv.RegionalOptions.ChangeForm(fSourceForm);

    EmpPay.Connection.BeginNestedTransaction;
    if TBaseInputGUI(fSourceForm).ShowModal = mrOK then
      EmpPay.Connection.CommitNestedTransaction
    else
      EmpPay.Connection.RollbackNestedTransaction;
  finally
    Freeandnil(fsourceForm);
    fsourceForm := FmTemp ;
  end;

end;

Procedure TfrmEmployee.Setbuttons;
var
  ctr: Integer;
  Procedure Addbutton(btn: TDnMSpeedbutton);
  begin
    if not(btn.visible) then exit;
    SetLength(buttons, length(buttons) + 1);
    Buttons[high(Buttons)] := btn.Name;
  end;
begin
    btnw4.Enabled := true;
    btnw4.visible := (Appenv.RegionalOptions.RegionType = rUSA);



    for ctr:= 0 to componentcount - 1 do begin
      if components[ctr] is TDnMSpeedbutton then
        if (TDnMSpeedbutton(components[ctr]).Parent = pnlBottom) and
            TDnMSpeedbutton(components[ctr]).Visible then begin
          Addbutton(TDnMSpeedbutton(components[ctr]));
        end;
    end;

    Centralisebuttons(pnlBottom, 0, 0, 1);
end;

procedure TfrmEmployee.LoadEmpTemplate(const TemplateName:String);
var
  sSQL: string;
  PrintTemplate :TPrintTemplates;
begin
  PrintTemplate := TPrintTemplates.Create;
  try
    sSQL := Format(' AND tblEmployees.EmployeeID = %d', [Self.KeyID]);
    PrintTemplate.PrintTemplateReport(TemplateName, sSQL, not AppEnv.Employee.ShowPreview, 1,MyConnection);

  finally
    FreeAndNil(PrintTemplate);
  end;
end;

procedure TfrmEmployee.cmdPrintClick(Sender: TObject);
var
  ReportName, StrWhere: string;
  PrintTemplate :TPrintTemplates;
begin
  DisableForm;
  try
    If not EmpPay.Save then Exit;
    PrintTemplate := TPrintTemplates.Create;
    try
      ReportName := 'Employee Details';
      StrWhere := 'Where tblemployees.EmployeeId = ' + IntToStr(KeyId) + ' ~|||~ ' + ' Where EmployeeId = ' +
        IntToStr(KeyId) + ' ~|||~ ' + ' Where EmployeeId = ' + IntToStr(KeyId) + ' ~|||~ ' +
        ' Where EmployeeId = ' + IntToStr(KeyId) + ' ~|||~ ';
      PrintTemplate.PrintTemplateReport(ReportName, strWhere,not AppEnv.Employee.ShowPreview, 1,MyConnection);
    finally
      FreeAndNil(PrintTemplate);
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployee.chkActiveClick(Sender: TObject);
begin
  inherited;
  if not(Screen.ActiveControl = chkActive) then exit;
  if (EmpPay.EmployeeDetails.Active = True) and (chkActive.Checked = False) then begin //changing from active to inactive
    if EmpPay.EmployeeDetails.Active <> (chkActive.Checked ) then EmpPay.EmployeeDetails.Active := (chkActive.Checked );
  end;
  if (EmpPay.EmployeeDetails.Active = False) and (chkActive.Checked = True) then

    case CommonLib.MessageDlgXP_Vista('Are you re-employing this employee?',mtConfirmation,[mbYes,mbNo],0) of
      mrYes: begin
              EmpPay.EmployeeDetails.Active           := True;
              EmpPay.EmployeeDetails.Isterminated     := False;
              EmpPay.EmployeeDetails.Dataset.FieldByName('DateFinished').Clear;
              EmpPay.EmployeePaySettings.LastPaid     := 0;
              ShowSubForm(Tab_PayDetails);
              EmpPay.SendEvent(BusobjEventVal_HandleEmployeeReEmploy,BusObjEvent_Change );
            end;
      mrNo: begin
              chkActive.Checked := False;
            end;
    end;
end;

procedure TfrmEmployee.DoBusobjEvent_PayUtils(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited DoBusinessObjectEvent(Sender, eventtype , Value);
  if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_BankSplitsError) then begin
    CommonLib.MessageDlgXP_Vista('The Banking split amounts are greater than the net pay.', mtWarning, [mbOK], 0);
  end;
end;



procedure TfrmEmployee.DoBusobjEvent_Common(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited DoBusinessObjectEvent(Sender, eventtype , Value);
  if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_IDChange) then begin
    if assigned(fSourceForm) then
      if fSourceForm is TfrmEmployeeDocuments then
        TfrmEmployeeDocuments(fSourceForm).RefreshLookup;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_BeforeOpen) then begin
    DoStepProgressbar('Opening ' + Sender.XMLNodeName);
  end else
  If (Value = BusobjEventVal_FailedAddressValidateData) then Begin
    ShowSubForm(Tab_Address);
    TEmployeeAddress(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedAllowancesValidateData) then Begin
    ShowSubForm(Tab_Allowances);
    TfrmEmployeeAllowances(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedBankingValidateData) then Begin
    ShowSubForm(Tab_Banking);
    TEmpPaySetUpBanking(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedCommissionValidateData) then Begin
    ShowSubForm(Tab_SalesCommission);
    TfrmEmployeeCommissions(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else if (Eventtype = BusObjEvent_Change) and (Value = BusobjEventVal_ForAllEmployees) then begin
    ShowSubForm(Tab_SalesCommission);
    TfrmEmployeeCommissions(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedCustom_FieldsValidateData) then Begin
    ShowSubForm(Tab_CustomFields);
    TEmployeeCustomFields(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedDeductionsValidateData) then Begin
    ShowSubForm(Tab_Deductions);
    TEmpPaySetupDeductions(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedDocumentsValidateData) then Begin
    ShowSubForm(Tab_Documents);
    TfrmEmployeeDocuments(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedFringe_BenefitsValidateData) then Begin
    ShowSubForm(Tab_FringeBenefits);
    TfrmEmployeeBenefits(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedHoursValidateData) then Begin
    ShowSubForm(Tab_Hours);
    TEmpPaySetUpHours(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedInformationValidateData) then Begin
    ShowSubForm(Tab_Information);
    TEmployeeInfo(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedLeavesValidateData) then Begin
    ShowSubForm(Tab_LeaveAccruals);
    TEmpPaySetupLeave(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedPay_DetailsValidateData) then Begin
    ShowSubForm(Tab_PayDetails);
    TEmpPaySetupDetails(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedPay_NotesValidateData) then Begin
    ShowSubForm(Tab_PayNotes);
    TfrmEmployeePaySetupNotes(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedPhoto_IDValidateData) then Begin
    ShowSubForm(Tab_PhotoID);
    TEmployeePhoto(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedSuperannuationValidateData) then Begin
    ShowSubForm(Tab_Superannuation);
    TEmployeeSuper(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedTaxationValidateData) then Begin
    ShowSubForm(Tab_Taxation);
    if (fSourceForm is TEmpTaxGUI) then
      TEmpTaxGUI(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedWorkcoverValidateData) then Begin
    ShowSubForm(Tab_Workcover);
    TfrmEmployeeWorkcover(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_ShowProgressbar) then begin
    DoShowProgressbar(Sender.Progresscount, Sender.ProgressMsg);
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_ProgressbarProgress) then begin
    DoStepProgressbar(Sender.ProgressMsg);
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_HideProgressbar) then begin
    DoHideProgressbar;
  end;
end;

procedure TfrmEmployee.FormResize(Sender: TObject);
var
  Index:integer;
begin
  inherited;
  if ffrmList1 is TBaseListingGUI then begin
    ffrmList1.Width := optionscrollbox.ClientWidth;
    ffrmList1.Height := optionscrollbox.ClientHeight;
    exit;
  end;
  if Assigned(fSourceForm) then begin
    for Index := 0 to fSourceForm.ComponentCount - 1 do begin
      if fSourceForm.Components[Index] is TDNMPanel then begin
        if fSourceForm is TfmEmployeeSkills then begin
          TDNMPanel(fSourceForm.Components[index]).Width := optionscrollbox.Width - 8 ;
          TDNMPanel(fSourceForm.Components[index]).Height := optionscrollbox.Height - 8 ;
          break;
        end else begin
          TDNMPanel(fSourceForm.Components[index]).Width := optionscrollbox.Width - 3 ;
          TDNMPanel(fSourceForm.Components[index]).Height := optionscrollbox.Height - 3 ;
          break;
        end;
      end;
    end;
  end;
  InitPagecontrolsize;
end;



procedure TfrmEmployee.PerformPaintPanel(var Msg: TMessage);
begin
  optionscrollbox.Invalidate;
end;



procedure TfrmEmployee.Calccommission(
  DataSet: TDataSet);
begin
  inherited;
  if DataSet.fieldbyname('ispercentage').asBoolean then
    DataSet.fieldbyname('Commission').asString := DataSet.fieldbyname('CommissionRate').asString +'%'
  else DataSet.fieldbyname('Commission').asString :=  FloatToStrF(DataSet.fieldbyname('CommissionRate').asfloat, ffcurrency , 15,CurrencyRoundPlaces);
end;
function TfrmEmployee.EmployeeReport: TBaseListingGUI;
begin
  CreateHistorylistform('TEmployeeReportGUI' ,Self, fEmployeeReport,'`EmployeeID`', IntToStr(KeyID));
  result := fEmployeeReport;
end;
function TfrmEmployee.EmplyeeHRForm: TBaseListingGUI;
begin
  CreateHistorylistform('TEmployeeHRFormsGUI' ,Self, fEmplyeeHRForm,'`EmployeeID`', IntToStr(KeyID));
  TEmployeeHRFormsGUI(fEmplyeeHRForm).btnNewHrform.visible := True;
  TEmployeeHRFormsGUI(fEmplyeeHRForm).btnNewHrform.Top := 0;
  TEmployeeHRFormsGUI(fEmplyeeHRForm).referenceID := qryemployeeEmployeeID.asInteger;
  result := fEmplyeeHRForm;
end;
function TfrmEmployee.PayListing: TBaseListingGUI;
begin
  CreateHistorylistform('TPayListingGUI' ,Self, fPayListing,'`EmployeeId`', IntToStr(KeyID));
  fPayListing.qryMain.Filter := 'Deleted = "F"';
  fPayListing.qryMain.Filtered := true;
  result := fPayListing;
end;
Procedure TfrmEmployee.InitPagecontrolsize;
begin
  if assigned(fsourceform) then
    if fsourceform is TfrmEmployeeCommissions then begin
        RealignTabControl(TfrmEmployeeCommissions(fsourceform).mainpage, 1);
        TfrmEmployeeCommissions(fsourceform).FormResize(fsourceform);
    end;
end;

initialization
  RegisterClassOnce(TfrmEmployee);
  with FormFact do begin
    RegisterMe(TfrmEmployee, 'TfrmEmployeeList_*=EmployeeID');
    RegisterMe(TfrmEmployee, 'TEmployeeSkillListGUI_*=EmployeeID');
    RegisterMe(TfrmEmployee, 'TfrmPayTimesheet_Name=EmployeeID');
    RegisterMe(TfrmEmployee, 'TfrmPaySummary_Name=EmployeeID');
    RegisterMe(TfrmEmployee, 'TSalesReportGUI_Employee Name_Invoice=EmployeeID');
    RegisterMe(TfrmEmployee, 'TSalesReportGUI_Employee Name_Cash Sale=EmployeeID');
    RegisterMe(TfrmEmployee, 'TSalesReportGUI_Employee Name_Refund=EmployeeID');
    RegisterMe(TfrmEmployee, 'TSalesReportGUI_Employee Name_POS=EmployeeID');
    RegisterMe(TfrmEmployee, 'TSalesReportGUI_Employee Name_Unknown=EmployeeID');
    RegisterMe(TfrmEmployee, 'TGlobalListFrm_*_Employee=ID');
    RegisterMe(TfrmEmployee, 'TGlobalListSearchFrm_*_Employee=ID');
    RegisterMe(TfrmEmployee, 'TSalesListwithCommisionGUI_employeeName_*=EmployeeId');
    RegisterMe(TfrmEmployee, 'TSalescommissionListGUI_EmployeeName=EmployeeID');
    RegisterMe(TfrmEmployee, 'TLeaveAccruedListGUI_*=EmployeeID');
    RegisterMe(TfrmEmployee, 'TLeaveListGUI_*=EmployeeID');
    RegisterMe(TfrmEmployee, 'TTransactionListGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TBASTransReturnListGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TNZTransReturnListGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TVATTransReturnListGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TGlobalsearchGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TGlobalsearchGUI_*_Employee=EmployeeID');
    RegisterMe(TfrmEmployee, 'TTransAccountDetailsGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TBalTransListGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TToBeReconciledGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TReconListDetailFormGUI_*_Payroll Accrued Leave Adjustment=EmployeeID');
    RegisterMe(TfrmEmployee, 'TTransAccountDetailsGUI_Type_Payroll Accrued Leave Opening Balance=EmployeeID');
    (*RegisterMe(TfrmEmployee, 'TRemindersListGUI_*_Employee Skill Expired=ClientID');*)
    RegisterMe(TfrmEmployee, 'TReminderListGUI_*_Employee Skill Expired=ClientID');
    RegisterMe(TfrmEmployee, 'TOtherfollowupsGUI_*_employee=employeeID');
    RegisterControl(TfrmEmployee, '*_cboLastEmployee=EmployeeID');
    RegisterControl(TfrmEmployee, '*_cboEmployee=EmployeeID');
    RegisterControl(TfrmEmployee, '*_cboRep=EmployeeID');
    RegisterControl(TfrmEmployee, '*_cboRepName=EmployeeID');
    RegisterControl(TfrmEmployee, '*_cboEmployeeOthersFollowup=EmployeeID');
    RegisterControl(TfrmEmployee, '*_cboCanvasserName=EmployeeID');
    RegisterControl(TfrmEmployee, '*_EmployeeID=EmployeeID');

  end;
finalization
  UnregisterClass(TfrmEmployee);
end.




