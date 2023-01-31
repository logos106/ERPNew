unit frmJob;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/05/05  1.00.01 BJ  Fixed raising exception when the 'Product Sale' option
                       selected in the History tab
 16/06/05  1.00.02 BJ  When form is opened from repairs (when  preference
                       -CreateCustomerJobFromRepair- is set to True), 'RepairNo'
                       property of this form will have the ID of the repair record.
                       The job no is initialised to the repair no, used is
                       allowed to change this default value. In this situation
                       it is possible to have a duplicate job number - which is
                       ok for the time being.
 20/06/05  1.00.03 BJ  New fields added for Registration and hours used. The hours
                       used is for the equipment. The repairin this case means
                       the repain of a single equipment. But as it is possible to
                       have multiple equipments, the hours is given for the job.
 26/06/05  1.00.03 BJ  New field added for warranty finish date. The job is considered
                       as an equipment and this field indicates the warranty finish
                      date of the equipment.
                       If the job is selcted after the warranty a popup message should
                       be shown
                       Bug fixed :Create a new job, enter details for the first tab and
                       chang the tab to 'Equipments' without saving, breakes.
                       Same problem for all the tabs with Grids in it
                       Bug fixed : Open the form for a new job, selecting any tab
                       without entering the job name (which is a mandatory field),
                       the applciation breakes.
 01/07/05  1.00.04 BJ  New tab - Job cards - where multiple employees can be selected for
                       a job. The template of the employee is displayed as the default
                       template when the employee is selected. User can change it. The
                       List shows all the invoice templates (template type = 11)
                       New tab added for machinery - to make the no of tabs an even number.
                       Bug fixed: QryEquip was not using the form connection, but
                       a diferent connection, and so was not within the transaction.
                       Cancelling the changes to these tabs where not possible.
                       -------Was this done purposely????????????????
 05/07/05  1.00.05 BJ  The template of the employee in the job cards can be of any type
                       It is expected to have the tblCutomerJobcards selected in the SQL
                       of the report template that the user selects here.
 12/07/05  1.00.06 BJ  hrstaken is a clculated field when
                       AppEnv.CompanyPrefs.RepairEquipListLimit = 'C' and the field is made
                       disabled.
                       Caption is changed based on the preference
                       New field for the warranty period
                       Jobcards template is merged into the 'General detais' template and created
                       a new template - 'CustomerJobs' and the print option here is printing the
                       new report.
                       Note: When the middlename is 'Null' in the database the name is not comming
                       in the report. The name is concat_ws(firstname, lastname) ?????????????????
 21/07/05  1.00.07 BJ  CompanyName is changed to a combo to select adifferent client;
 02/08/05  1.00.08 IJB Removed chkActive checkbox on click handler (was causing
                       problems when form read only by trying to set field data
                       when table first opened in form show).
                       Modified FormCloseQuery to use DataState.
 26/08/05  1.00.12 BJ  SetContractDefaults sets the defualt values for the new
                       contract record
 20/09/05  1.00.13 DLS Check if Sender.asstring <> '' in qryJobJobNumberValidate
 23/09/05  1.00.14 DSP Moved a number of controls between tabs and renamed two
                       tabs.
 19/10/05  1.00.15 BJ  New field added for customer job number.
                       Job name gets the job number as the default value which
                       can be changed.
 28/10/05  1.00.16 DSP Added 'Attach' button and associated functionality.
 02/11/05  1.00.17 DSP Added 'Appointment' button and associated functionality.
 04/01/06  1.00.18 BJ  Field added for the outstanding hours
 05/01/06  1.00.19 IJB Added LastUpdated field to persistant fields - needs this
                       for attachments.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, StdCtrls, Mask, wwdbedit, wwcheckbox,
  wwdbdatetimepicker, ComCtrls,AdvOfficeStatusBar, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, wwdblook, wwriched,
  AppEvnts, BaseListingForm, SelectionDialog, kbmMemTable, DBCtrls, Wwdbigrd,
  Grids, Wwdbgrid, Wwdotdot, Wwdbcomb, OleServer, Word2000, ActnList, wwMemo,
  DateUtils, DBAccess, MyAccess,ERPdbComponents, MemDS, DNMLib, DataState, wwclearbuttongroup,
  wwradiogroup, frmAttachments, Menus, AdvMenus, Shader, MessageInterface,
  ImgList, frmClientEquipment, WordXP, ERPDbLookupCombo, ProgressDialog,
  HTMLUn2, HtmlView, IdMessage, FileAssociationDetails, Busobjcustomfields, Spin,
  Wwdbspin;

type
  TJobGUI = class(TBaseInputGUI)
    pgeControl: TPageControl;
    tabMain: TTabSheet;
    tabAddress: TTabSheet;
    tabHistory: TTabSheet;
    DNMPanel2: TDNMPanel;
    qryJob: TERPQuery;
    dsJob: TDataSource;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    pnlHistory: TDNMPanel;
    lblCompany: TStaticText;
    edtBillStreet: TwwDBEdit;
    edtBillStreet2: TwwDBEdit;
    BillState: TwwDBEdit;
    BillPostCode: TwwDBEdit;
    Label1: TLabel;
    Label13: TLabel;
    lblBillSuburb: TLabel;
    lblBillState: TLabel;
    lblBillPostCode: TLabel;
    Bevel5: TBevel;
    Label17: TLabel;
    edtStreet: TwwDBEdit;
    edtStreet2: TwwDBEdit;
    State: TwwDBEdit;
    PostCode: TwwDBEdit;
    Label18: TLabel;
    Label19: TLabel;
    lblSuburb: TLabel;
    lblState: TLabel;
    lblPostCode: TLabel;
    Bevel6: TBevel;
    Label23: TLabel;
    btnOrigAdd: TDNMSpeedButton;
    BillSuburb: TwwDBLookupCombo;
    Suburb: TwwDBLookupCombo;
    grpHistory: TRadioGroup;
    memQryJob: TkbmMemTable;
    qryJobClientID: TAutoIncField;
    qryJobCompany: TWideStringField;
    qryJobABN: TWideStringField;
    qryJobTitle: TWideStringField;
    qryJobFirstName: TWideStringField;
    qryJobMiddleName: TWideStringField;
    qryJobLastName: TWideStringField;
    qryJobPosition: TWideStringField;
    qryJobPhone: TWideStringField;
    qryJobFaxNumber: TWideStringField;
    qryJobMobile: TWideStringField;
    qryJobEmail: TWideStringField;
    qryJobAltContact: TWideStringField;
    qryJobAltPhone: TWideStringField;
    qryJobContact1: TWideStringField;
    qryJobPhoneSupportTill: TDateField;
    qryJobContact2: TWideStringField;
    qryJobContact1Phone: TWideStringField;
    qryJobContact2Phone: TWideStringField;
    qryJobNotes: TWideMemoField;
    qryJobClientNo: TWideStringField;
    qryJobClientTypeID: TIntegerField;
    qryJobMedTypeID: TIntegerField;
    qryJobTYPE: TWideStringField;
    qryJobTAXID: TIntegerField;
    qryJobCreditLimit: TFloatField;
    qryJobBalance: TFloatField;
    qryJobTERMS: TWideStringField;
    qryJobTermsID: TIntegerField;
    qryJobShippingMethod: TWideStringField;
    qryJobShippingID: TIntegerField;
    qryJobSpecialDiscount: TFloatField;
    qryJobJobName: TWideStringField;
    qryJobIsJob: TWideStringField;
    qryJobPayMethodID: TIntegerField;
    qryJobFeedback: TWideStringField;
    qryJobCustomer: TWideStringField;
    qryJobSupplier: TWideStringField;
    qryJobOtherContact: TWideStringField;
    qryJobOtherContactType: TIntegerField;
    qryJobRepID: TIntegerField;
    qryJobGlobal: TWideStringField;
    qryJobDone: TWideStringField;
    qryJobActive: TWideStringField;
    qryJobEditedFlag: TWideStringField;
    qryJobDontContact: TWideStringField;
    qryJobParentClientID: TIntegerField;
    qryJobCompletionDate: TDateField;
    qryJobCreationDate: TDateField;
    qryJobSecurityLevel: TIntegerField;
    tabEquip: TTabSheet;
    Custom_Fields: TTabSheet;
    pnlCustFields: TDNMPanel;
    Box181: TBevel;
    Label179: TLabel;
    Bevel14: TBevel;
    cmdCustomLabelsOld: TDNMSpeedButton;
    qryJobJobNumber: TIntegerField;
    tabGeneral: TTabSheet;
    qryJobGlobalRef: TWideStringField;
    qryJobUpdateDate: TDateField;
    qryJobDateInactive: TDateField;
    qryJobSOBalance: TFloatField;
    qryJobAction: TDateTimeField;
    qryJobDateEntered: TDateField;
    qryJobCorrespondenceMethod: TWideStringField;
    qryJobShipTime: TWordField;
    qryJobGracePeriod: TWordField;
    qryJobLastContactDate: TDateField;
    qryJobLoyaltyValue: TFloatField;
    qryJobLastSaleDate: TDateField;
    qryJobAccountNo: TWideStringField;
    qryJobBankAccountName: TWideStringField;
    qryJobBankAccountBSB: TWideStringField;
    qryJobBankAccountNo: TWideStringField;
    qryJobURL: TWideStringField;
    qryJobCombinedInvoiceBOID: TWideStringField;
    qryJobCombinedSaleOrderBOID: TWideStringField;
    qryJobStopCredit: TWideStringField;
    qryJobRequired: TWideStringField;
    qryJobForcePOOnBooking: TWideStringField;
    qryJobForcePOOnInvoice: TWideStringField;
    qryJobPickingPriority: TIntegerField;
    qryJobDefaultInvoiceTemplateID: TIntegerField;
    DNMPanel4: TDNMPanel;
    Box71: TBevel;
    Label56: TLabel;
    Label52: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    AccountNo: TDBEdit;
    cboTerms: TwwDBLookupCombo;
    CreditLimit: TwwDBEdit;
    GracePeriod: TwwDBEdit;
    Bevel13: TBevel;
    Bevel8: TBevel;
    Label77: TLabel;
    Bevel10: TBevel;
    Label28: TLabel;
    Label29: TLabel;
    Email: TDBEdit;
    cboPaymentMethod: TwwDBLookupCombo;
    cboInvoiceTemplate: TwwDBLookupCombo;
    cboShippingMethod_Label: TLabel;
    Label30: TLabel;
    cboVia: TwwDBLookupCombo;
    cboTaxCode: TwwDBLookupCombo;
    qryJobRepName: TWideStringField;
    btnLoadCredit: TDNMSpeedButton;
    Bevel9: TBevel;
    tabDocuments: TTabSheet;
    tabContacts: TTabSheet;
    memqryContacts: TkbmMemTable;
    qryContacts: TERPQuery;
    qryDocuments: TERPQuery;
    DSContacts: TDataSource;
    DSDocuments: TDataSource;
    WordApplication1: TWordApplication;
    qryJobBankCode: TWideStringField;
    qryJobLoyaltyDateSaleDays: TDateField;
    qryJobLoyaltyDateAmount: TDateField;
    qryJobLoyaltyDateAppointDays: TDateField;
    qryJobStreet2: TWideStringField;
    qryJobSuburb: TWideStringField;
    qryJobState: TWideStringField;
    qryJobCountry: TWideStringField;
    qryJobPostcode: TWideStringField;
    qryJobBillStreet: TWideStringField;
    qryJobBillStreet2: TWideStringField;
    qryJobBillSuburb: TWideStringField;
    qryJobBillState: TWideStringField;
    qryJobBillCountry: TWideStringField;
    qryJobBillPostcode: TWideStringField;
    qryJobPOBox: TWideStringField;
    qryJobPOSuburb: TWideStringField;
    qryJobPOState: TWideStringField;
    qryJobPOCountry: TWideStringField;
    qryJobPOPostcode: TWideStringField;
    qryJobCUSTFLD1: TWideStringField;
    qryJobCUSTFLD2: TWideStringField;
    qryJobCUSTFLD3: TWideStringField;
    qryJobCUSTFLD4: TWideStringField;
    qryJobCUSTFLD5: TWideStringField;
    qryJobCUSTFLD6: TWideStringField;
    qryJobCUSTFLD7: TWideStringField;
    qryJobCUSTFLD8: TWideStringField;
    qryJobCUSTFLD9: TWideStringField;
    qryJobCUSTFLD10: TWideStringField;
    qryJobCUSTFLD11: TWideStringField;
    qryJobCUSTFLD12: TWideStringField;
    qryJobCUSTFLD13: TWideStringField;
    qryJobCUSTFLD14: TWideStringField;
    qryJobCUSTFLD15: TWideStringField;
    qryJobGroupDiscountOverridesAll: TWideStringField;
    qryJobCardNumber: TWideStringField;
    qryJobForeignExchangeSellCode: TWideStringField;
    qryJobDefaultClass: TWideStringField;
    qryJobArea: TWideStringField;
    qryJobDischargeDate: TDateField;
    Label128: TLabel;
    PhoneSupport: TwwDBDateTimePicker;
    qryJobJobTitle: TWideStringField;
    qryJobUseInvBase: TWideStringField;
    qryJobInvBaseNumber: TIntegerField;
    Label33: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    Label34: TLabel;
    Bevel17: TBevel;
    tabServices: TTabSheet;
    tabReferrals: TTabSheet;
    DNMPanel14: TDNMPanel;
    Bevel21: TBevel;
    Label37: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    lblReferralsWarning: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    grdReferrals: TwwDBGrid;
    btnDeleteReferral: TwwIButton;
    cboClients: TwwDBLookupCombo;
    btnLetters: TDNMSpeedButton;
    chkAllRefs: TCheckBox;
    qryCustomerServices: TERPQuery;
    qryCustomerServicesRepLookup: TWideStringField;
    qryCustomerServicesServiceLookup: TWideStringField;
    qryCustomerServicesRatingLookup: TWideStringField;
    qryCustomerServicesCustomerServicesID: TAutoIncField;
    qryCustomerServicesEmployeeID: TIntegerField;
    qryCustomerServicesServiceID: TIntegerField;
    qryCustomerServicesRatingID: TIntegerField;
    qryCustomerServicesEditedFlag: TWideStringField;
    qryCustomerServicesClientID: TIntegerField;
    dsCustomerServices: TDataSource;
    qryReferrals: TERPQuery;
    qryReferralsReferralID: TAutoIncField;
    qryReferralsClientID: TIntegerField;
    qryReferralsReferredClientID: TIntegerField;
    qryReferralsEditedFlag: TWideStringField;
    qryReferralsCompanyLookup: TWideStringField;
    qryReferralsPhoneLookup: TWideStringField;
    qryReferralsFaxLookup: TWideStringField;
    dsReferrals: TDataSource;
    ActionList1: TActionList;
    actReferralsPrint: TAction;
    EquipNotesDialog1: TwwMemoDialog;
    tabfollowup: TTabSheet;
    tabCarePlan: TTabSheet;
    DNMPanel5: TDNMPanel;
    DNMPanel8: TDNMPanel;
    qryCarePlan: TERPQuery;
    DSCarePlan: TDataSource;
    qryCarePlanGlobalRef: TWideStringField;
    qryCarePlanClientCarePlanID: TAutoIncField;
    qryCarePlanClientID: TIntegerField;
    qryCarePlanServiceID: TIntegerField;
    qryCarePlanServiceDesc: TWideStringField;
    qryCarePlanSundayFromTime: TDateTimeField;
    qryCarePlanSundayToTime: TDateTimeField;
    qryCarePlanMondayFromTime: TDateTimeField;
    qryCarePlanMondayToTime: TDateTimeField;
    qryCarePlanTuesdayFromTime: TDateTimeField;
    qryCarePlanTuesdayToTime: TDateTimeField;
    qryCarePlanWednesdayFromTime: TDateTimeField;
    qryCarePlanWednesdayToTime: TDateTimeField;
    qryCarePlanThursdayFromTime: TDateTimeField;
    qryCarePlanThursdayToTime: TDateTimeField;
    qryCarePlanFridayFromTime: TDateTimeField;
    qryCarePlanFridayToTime: TDateTimeField;
    qryCarePlanSaturdayFromTime: TDateTimeField;
    qryCarePlanSaturdayToTime: TDateTimeField;
    qryCarePlanEditedFlag: TWideStringField;
    grdCarePlan: TwwDBGrid;
    wwIButton1: TwwIButton;
    DNMPanel9: TDNMPanel;
    cboCareServices: TwwDBLookupCombo;
    qryJobApprovalFromDate: TDateTimeField;
    qryJobApprovalToDate: TDateTimeField;
    qryJobTasks: TWideMemoField;
    qryJobReminderDateTime: TDateTimeField;
    qryJobSpecialInstructions: TWideMemoField;
    wwDBDateTimePicker3: TwwDBDateTimePicker;
    wwDBDateTimePicker4: TwwDBDateTimePicker;
    Label35: TLabel;
    Task: TDBMemo;
    Label36: TLabel;
    SpecialInstructions: TDBMemo;
    Label38: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    wwDBDateTimePicker5: TwwDBDateTimePicker;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Bevel22: TBevel;
    Bevel23: TBevel;
    cmdPrint: TDNMSpeedButton;
    Button1: TDNMSpeedButton;
    btnSortMeals: TDNMSpeedButton;
    tbOtherFollowUp: TERPQuery;
    tbOtherFollowUpFollowUpDate: TDateTimeField;
    tbOtherFollowUpEmployeeName: TWideStringField;
    tbOtherFollowUpDone: TWideStringField;
    tbOtherFollowUpEmployeeID: TIntegerField;
    tbOtherFollowUpFollowUpID: TAutoIncField;
    tbOtherFollowUpOtherContactID: TIntegerField;
    tbOtherFollowUpRepairID: TIntegerField;
    tbOtherFollowUpEditedFlag: TWideStringField;
    tbOtherFollowUpAppearDays: TIntegerField;
    tbOtherFollowUpCreationDate: TDateTimeField;
    tbOtherFollowUpClientID: TIntegerField;
    tbOtherFollowUpIsSupplier: TWideStringField;
    tbOtherFollowUpIsOtherContact: TWideStringField;
    tbOtherFollowUpIsCustomer: TWideStringField;
    tbOtherFollowUpGlobalRef: TWideStringField;
    tbOtherFollowUpUpdateDate: TDateField;
    memtbOtherFollowUp: TkbmMemTable;
    dsOtherFollowUp: TDataSource;
    grdFollowUp: TwwDBGrid;
    btnInactiveFollowUp: TwwIButton;
    dtpDatePicker: TwwDBDateTimePicker;
    cboEmployee: TwwDBLookupCombo;
    actRepeat: TAction;
    tbOtherFollowUpHours: TFloatField;
    chkActive: TwwCheckBox;
    Label12: TLabel;
    qryClients: TERPQuery;
    qryDocPath: TERPQuery;
    qrySuburb: TERPQuery;
    qryEmployees: TERPQuery;
    qrySource: TERPQuery;
    qryServices: TERPQuery;
    qryRating: TERPQuery;
    qryEmpID: TERPQuery;
    qryMediaType: TERPQuery;
    qryInvoiceTemplates: TERPQuery;
    qryPayMethod: TERPQuery;
    qryShipping: TERPQuery;
    qryClientTypes: TERPQuery;
    qryTaxCodes: TERPQuery;
    qryTerms: TERPQuery;
    cboServiceIDQry: TERPQuery;
    qryCustomFields: TERPQuery;
    qryRep: TERPQuery;
    qryJobSerialNumber: TWideStringField;
    qryJobModelNumber: TWideStringField;
    qryJobManufacture: TWideStringField;
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    actServiceCycle: TAction;
    btnPrint: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    btnSalesOrder: TDNMSpeedButton;
    btnRepeat: TDNMSpeedButton;
    btnServiceCycle: TDNMSpeedButton;
    qryJobJobRegistration: TWideStringField;
    qryJobHoursTakenForJob: TFloatField;
    qryJobWarrantyFinishDate: TDateTimeField;
    tabSpecialproducts: TTabSheet;
    qryJobcards: TERPQuery;
    wa: TDataSource;
    qryJobcardsClientID: TIntegerField;
    qryJobcardsEmployeeId: TIntegerField;
    qryJobcardsNotes: TWideStringField;
    qryEmpLookup: TERPQuery;
    qryEmpLookupEmployeeID: TAutoIncField;
    qryEmpLookupEmployeeName: TWideStringField;
    qryJobcardsEmployeeName: TWideStringField;
    qryJobcardsID: TAutoIncField;
    tabCustomer: TTabSheet;
    qryJobcardsTemplateId: TIntegerField;
    qryJobcardsTemplateName: TWideStringField;
    qryEmpLookupDefaultInvoiceTemplateID: TIntegerField;
    DNMPanel11: TDNMPanel;
    qryJobWarrantyPeriod: TFloatField;
    qryTemplate: TERPQuery;
    qryTemplateTemplName: TWideStringField;
    qryTemplateTemplID: TAutoIncField;
    qryCustomer: TERPQuery;
    qryCustomerclientID: TAutoIncField;
    qryCustomerCompany: TWideStringField;
    qryCustomerGlobalRef: TWideStringField;
    qryCustomerClientTypeID: TIntegerField;
    qryCustomerABN: TWideStringField;
    qryCustomerTitle: TWideStringField;
    qryCustomerFirstName: TWideStringField;
    qryCustomerMiddleName: TWideStringField;
    qryCustomerLastName: TWideStringField;
    qryCustomerPosition: TWideStringField;
    qryCustomerStreet: TWideStringField;
    qryCustomerStreet2: TWideStringField;
    qryCustomerSuburb: TWideStringField;
    qryCustomerState: TWideStringField;
    qryCustomerCountry: TWideStringField;
    qryCustomerPostcode: TWideStringField;
    qryCustomerBillStreet: TWideStringField;
    qryCustomerBillStreet2: TWideStringField;
    qryCustomerBillSuburb: TWideStringField;
    qryCustomerBillState: TWideStringField;
    qryCustomerBillCountry: TWideStringField;
    qryCustomerBillPostcode: TWideStringField;
    qryCustomerPOBox: TWideStringField;
    qryCustomerPOSuburb: TWideStringField;
    qryCustomerPOState: TWideStringField;
    qryCustomerPOCountry: TWideStringField;
    qryCustomerPOPostcode: TWideStringField;
    qryCustomerPhone: TWideStringField;
    qryCustomerFaxNumber: TWideStringField;
    qryCustomerMobile: TWideStringField;
    qryCustomerEmail: TWideStringField;
    qryCustomerAltContact: TWideStringField;
    qryCustomerAltPhone: TWideStringField;
    qryCustomerPhoneSupportTill: TDateField;
    qryCustomerContact1: TWideStringField;
    qryCustomerContact2: TWideStringField;
    qryCustomerContact1Phone: TWideStringField;
    qryCustomerContact2Phone: TWideStringField;
    qryCustomerCreationDate: TDateField;
    qryCustomerUpdateDate: TDateField;
    qryCustomerDateInactive: TDateField;
    qryCustomerNotes: TWideMemoField;
    qryCustomerClientNo: TWideStringField;
    qryCustomerMedTypeID: TIntegerField;
    qryCustomerTYPE: TWideStringField;
    qryCustomerTAXID: TIntegerField;
    qryCustomerCreditLimit: TFloatField;
    qryCustomerBalance: TFloatField;
    qryCustomerSOBalance: TFloatField;
    qryCustomerTERMS: TWideStringField;
    qryCustomerTermsID: TIntegerField;
    qryCustomerShippingMethod: TWideStringField;
    qryCustomerShippingID: TIntegerField;
    qryCustomerDiscount: TFloatField;
    qryCustomerSpecialDiscount: TFloatField;
    qryCustomerJobName: TWideStringField;
    qryCustomerJobRegistration: TWideStringField;
    qryCustomerWarrantyFinishDate: TDateTimeField;
    qryCustomerHoursTakenForJob: TFloatField;
    qryCustomerIsJob: TWideStringField;
    qryCustomerCUSTFLD1: TWideStringField;
    qryCustomerCUSTFLD2: TWideStringField;
    qryCustomerCUSTFLD3: TWideStringField;
    qryCustomerCUSTFLD4: TWideStringField;
    qryCustomerCUSTFLD5: TWideStringField;
    qryCustomerCUSTFLD6: TWideStringField;
    qryCustomerCUSTFLD7: TWideStringField;
    qryCustomerCUSTFLD8: TWideStringField;
    qryCustomerCUSTFLD9: TWideStringField;
    qryCustomerCUSTFLD10: TWideStringField;
    qryCustomerCUSTFLD11: TWideStringField;
    qryCustomerCUSTFLD12: TWideStringField;
    qryCustomerCUSTFLD13: TWideStringField;
    qryCustomerCUSTFLD14: TWideStringField;
    qryCustomerCUSTFLD15: TWideStringField;
    qryCustomerPayMethodID: TIntegerField;
    qryCustomerFeedback: TWideStringField;
    qryCustomerCustomer: TWideStringField;
    qryCustomerSupplier: TWideStringField;
    qryCustomerOtherContact: TWideStringField;
    qryCustomerOtherContactType: TIntegerField;
    qryCustomerRepID: TIntegerField;
    qryCustomerRepName: TWideStringField;
    qryCustomerAction: TDateTimeField;
    qryCustomerGlobal: TWideStringField;
    qryCustomerDone: TWideStringField;
    qryCustomerDateEntered: TDateField;
    qryCustomerActive: TWideStringField;
    qryCustomerEditedFlag: TWideStringField;
    qryCustomerCorrespondenceMethod: TWideStringField;
    qryCustomerDontContact: TWideStringField;
    qryCustomerCompletionDate: TDateField;
    qryCustomerParentClientID: TIntegerField;
    qryCustomerShipTime: TWordField;
    qryCustomerGracePeriod: TWordField;
    qryCustomerLastContactDate: TDateField;
    qryCustomerLoyaltyValue: TFloatField;
    qryCustomerLastSaleDate: TDateField;
    qryCustomerAccountNo: TWideStringField;
    qryCustomerBankAccountName: TWideStringField;
    qryCustomerBankCode: TWideStringField;
    qryCustomerBankAccountBSB: TWideStringField;
    qryCustomerBankAccountNo: TWideStringField;
    qryCustomerURL: TWideStringField;
    qryCustomerCombinedInvoiceBOID: TWideStringField;
    qryCustomerCombinedSaleOrderBOID: TWideStringField;
    qryCustomerStopCredit: TWideStringField;
    qryCustomerRequired: TWideStringField;
    qryCustomerSecurityLevel: TIntegerField;
    qryCustomerForcePOOnBooking: TWideStringField;
    qryCustomerForcePOOnInvoice: TWideStringField;
    qryCustomerPickingPriority: TIntegerField;
    qryCustomerJobNumber: TIntegerField;
    qryCustomerDefaultInvoiceTemplateID: TIntegerField;
    qryCustomerLoyaltyDateSaleDays: TDateField;
    qryCustomerLoyaltyDateAmount: TDateField;
    qryCustomerLoyaltyDateAppointDays: TDateField;
    qryCustomerGroupDiscountOverridesAll: TWideStringField;
    qryCustomerForeignExchangeSellCode: TWideStringField;
    qryCustomerCardNumber: TWideStringField;
    qryCustomerDefaultClass: TWideStringField;
    qryCustomerArea: TWideStringField;
    qryCustomerDischargeDate: TDateField;
    qryCustomerJobTitle: TWideStringField;
    qryCustomerUseInvBase: TWideStringField;
    qryCustomerInvBaseNumber: TIntegerField;
    qryCustomerApprovalFromDate: TDateTimeField;
    qryCustomerApprovalToDate: TDateTimeField;
    qryCustomerTasks: TWideMemoField;
    qryCustomerReminderDateTime: TDateTimeField;
    qryCustomerSpecialInstructions: TWideMemoField;
    qryCustomerCUSTDATE1: TDateField;
    qryCustomerCUSTDATE2: TDateField;
    qryCustomerCUSTDATE3: TDateField;
    qryCustomerSerialNumber: TWideStringField;
    qryCustomerModelNumber: TWideStringField;
    qryCustomerManufacture: TWideStringField;
    qryCustomerParentRelatedClientID: TIntegerField;
    qryCustomerDeliveryNotes: TWideMemoField;
    qryCustomerDefaultContactMethod: TWideStringField;
    qryCustomerCreditCardNumber: TWideStringField;
    qryCustomerCreditCardExpiryDate: TWideStringField;
    qryCustomerCreditCardCardHolderName: TWideStringField;
    qryCustomerCreditCardNotes: TWideStringField;
    qryCustomerCompanyTypeId: TIntegerField;
    qryCustomerCreditCardType: TWideStringField;
    qryCustomerLastUpdated: TDateTimeField;
    qryCustomermsTimeStamp: TDateTimeField;
    qryCustomerWarrantyPeriod: TFloatField;
    Label9: TLabel;
    edtJobName: TwwDBEdit;
    Label25: TLabel;
    edtJobNo: TwwDBEdit;
    Label11: TLabel;
    edtNotes: TwwDBRichEdit;
    btnAddDateTime: TDNMSpeedButton;
    Bevel7: TBevel;
    Label24: TLabel;
    edtFirstName: TwwDBEdit;
    Label39: TLabel;
    edtLastName: TwwDBEdit;
    Label42: TLabel;
    cboClientType: TwwDBLookupCombo;
    Bevel11: TBevel;
    Label43: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    edtPhone: TwwDBEdit;
    edtFax: TwwDBEdit;
    edtAltPhone: TwwDBEdit;
    Label50: TLabel;
    cboRep: TwwDBLookupCombo;
    Label51: TLabel;
    cboSource: TwwDBLookupCombo;
    Label53: TLabel;
    wwDBEdit2: TwwDBEdit;
    Bevel12: TBevel;
    Bevel18: TBevel;
    Label54: TLabel;
    cboClassName: TwwDBLookupCombo;
    Label55: TLabel;
    edtcustjobno: TwwDBEdit;
    qryJobCustomerJobNumber: TWideStringField;
    qryModel: TERPQuery;
    qryManufacture: TERPQuery;
    qryManufactureID: TIntegerField;
    qryManufactureName: TWideStringField;
    qryModelId: TIntegerField;
    qryModelName: TWideStringField;
    btnAppointment: TDNMSpeedButton;
    qryJobhours: TFloatField;
    qryJobLastUpdated: TDateTimeField;
    Bevel24: TBevel;
    chkForcePOOnCustomer: TwwCheckBox;
    lblForcePORepairs: TLabel;
    Country: TDBEdit;
    BillCountry: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    qryJobForcePOOnCustomer: TWideStringField;
    Label16: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label20: TLabel;
    XMLEmail: TDBEdit;
    qryJobEmailXML: TWideStringField;
    qryJobSendXMLInvoices: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblAddress3: TLabel;
    edtStreet3: TwwDBEdit;
    lblBillAddress3: TLabel;
    edtBillStreet3: TwwDBEdit;
    qryJobStreet3: TWideStringField;
    qryJobBillStreet3: TWideStringField;
    DNMPanel6: TDNMPanel;
    chkShowAll: TCheckBox;
    cmdNewContact: TDNMSpeedButton;
    EditBtn: TDNMSpeedButton;
    EmailBtn: TDNMSpeedButton;
    FaxBtn: TDNMSpeedButton;
    LetterBtn: TDNMSpeedButton;
    Bevel16: TBevel;
    grdContact: TwwDBGrid;
    wwIButton2: TwwIButton;
    Label22: TLabel;
    CustEquipDNMPanel: TDNMPanel;
    qryJobSpecialProductPriceOverridesAll: TWideStringField;
    Label21: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    qryJobCallPriority: TIntegerField;
    qryJobDefaultContactMethod: TWideStringField;
    Bevel25: TBevel;
    Label31: TLabel;
    cboDefaultContactMethod: TwwDBComboBox;
    qryJobSkypeName: TWideStringField;
    qryJobARBalance: TFloatField;
    qryJobAPBalance: TFloatField;
    qryJobCombinedPurchaseBOID: TWideStringField;
    qryJobDefaultDeliveryTemplateID: TIntegerField;
    qryJobCUSTDATE1: TDateField;
    qryJobCUSTDATE2: TDateField;
    qryJobCUSTDATE3: TDateField;
    qryJobParentRelatedClientID: TIntegerField;
    qryJobDeliveryNotes: TWideMemoField;
    qryJobCreditCardNumber: TWideStringField;
    qryJobCreditCardExpiryDate: TWideStringField;
    qryJobCreditCardCardHolderName: TWideStringField;
    qryJobCreditCardNotes: TWideStringField;
    qryJobCompanyTypeId: TIntegerField;
    qryJobCreditCardType: TWideStringField;
    qryJobmsTimeStamp: TDateTimeField;
    qryJobInvoiceComment: TWideMemoField;
    qryJobPOComment: TWideMemoField;
    qryJobInvoiceCommentPopup: TWideStringField;
    qryJobPOCommentPopup: TWideStringField;
    qryJobDefaultPurchaseOrderTemplateID: TIntegerField;
    qryJobIncludeOnIntrastat: TWideStringField;
    qryJobShowInShipContainers: TWideStringField;
    qryJobForcePOOnRepair: TWideStringField;
    qryJobBPAYBillerCode: TWideStringField;
    qryJobBPAYReference: TWideStringField;
    qryJobManufactureID: TIntegerField;
    qryJobPortOfLanding: TWideStringField;
    qryJobPortOfDischarge: TWideStringField;
    qryJobFinalDestination: TWideStringField;
    qryJobIncoPlace: TWideStringField;
    qryJobShippingAgentID: TIntegerField;
    qryJobDefaultStatementTemplateId: TIntegerField;
    qryJobTeamviewerID: TWideStringField;
    qryJobInsuranceCompanyName: TWideStringField;
    qryJobClaimNumber: TWideStringField;
    qryJobStormLocation: TWideStringField;
    qryJobStormDate: TDateField;
    qryJobYear: TDateField;
    qryJobColour: TWideStringField;
    qryJobBodyType: TWideStringField;
    qryJobAssessorsName: TWideStringField;
    qryJobExcessAmount: TFloatField;
    qryInsuranceCompanyLookup: TERPQuery;
    Bevel2: TBevel;
    qryContactsGlobalRef: TWideStringField;
    qryContactsContactID: TIntegerField;
    qryContactsContactPH: TWideStringField;
    qryContactsContactMOB: TWideStringField;
    qryContactsContactFax: TWideStringField;
    qryContactsIsPrimarycontact: TWideStringField;
    qryContactsContactName: TWideStringField;
    qryContactsActive: TWideStringField;
    qryContactsContactFirstName: TWideStringField;
    qryContactsContactSurName: TWideStringField;
    qryContactsCompany: TWideStringField;
    qryContactsContactTitle: TWideStringField;
    qryContactsContactAddress: TWideStringField;
    qryContactsContactAddress2: TWideStringField;
    qryContactsContactAddress3: TWideStringField;
    qryContactsContactCity: TWideStringField;
    qryContactsContactState: TWideStringField;
    qryContactsContactPcode: TWideStringField;
    qryContactsContactCountry: TWideStringField;
    qryContactsContactAltPH: TWideStringField;
    qryContactsContactEmail: TWideStringField;
    qryContactsJobTitle: TWideStringField;
    qryJobBailmentNumber: TWideStringField;
    qryJobBailmentAmountEx: TFloatField;
    qryJobStockReceivedDate: TDateField;
    qryJobNewOrUsed: TWideStringField;
    qryContactsClientID: TIntegerField;
    qryContactsClientName: TWideStringField;
    tbOtherFollowUpNotes: TWideMemoField;
    cmdCopy: TDNMSpeedButton;
    pnlDocuments: TDNMPanel;
    Label72: TLabel;
    pnlDocumentsInner: TDNMPanel;
    Splitter1: TSplitter;
    pnlDocumentsList: TDNMPanel;
    Label73: TLabel;
    grdCorrespondence: TwwDBGrid;
    grdDocsIButton: TwwIButton;
    btnGetEmails: TButton;
    chkdocuments: TCheckBox;
    pnlDocumentsMessage: TDNMPanel;
    HtmlViewer: THtmlViewer;
    lvAttachments: TListView;
    DNMPanel1: TDNMPanel;
    grdEmp: TwwDBGrid;
    grdEmpIButton: TwwIButton;
    cboEmp: TwwDBLookupCombo;
    cboTemplate: TwwDBLookupCombo;
    Label74: TLabel;
    Label75: TLabel;
    qrySpecials: TERPQuery;
    qrySpecialsName: TWideStringField;
    qrySpecialsDescription: TWideStringField;
    qrySpecialsOrigPrice: TFloatField;
    qrySpecialsLinePrice: TFloatField;
    qrySpecialsCustomerLinesID: TAutoIncField;
    qrySpecialsProductID: TIntegerField;
    qrySpecialsEditedFlag: TWideStringField;
    qrySpecialsCustomerId: TIntegerField;
    DSSpecials: TDataSource;
    qryProdGroupDiscs: TERPQuery;
    qryProdGroupDiscsCol1: TWideStringField;
    qryProdGroupDiscsCol2: TWideStringField;
    qryProdGroupDiscsCol3: TWideStringField;
    qryProdGroupDiscsDiscount: TFloatField;
    qryProdGroupDiscsClientID: TIntegerField;
    qryProdGroupDiscsGrpDiscID: TIntegerField;
    dsProdGroupDiscs: TDataSource;
    cboProductQry: TERPQuery;
    qryProductGroupcol1: TERPQuery;
    qryProductGroupcol2: TERPQuery;
    qryProductGroupcol3: TERPQuery;
    DNMPanel10: TDNMPanel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    grdProdGroupDiscs: TwwDBGrid;
    grdProdGroupDiscsIButton: TwwIButton;
    cboCol1: TwwDBLookupCombo;
    cboCol2: TwwDBLookupCombo;
    cboCol3: TwwDBLookupCombo;
    chkgroupdiscount: TwwCheckBox;
    chksplPrductdiscount: TwwCheckBox;
    DNMPanel7: TDNMPanel;
    Label78: TLabel;
    Label79: TLabel;
    Label76: TLabel;
    grdSpecials: TwwDBGrid;
    grdSpecialsIButton: TwwIButton;
    cboProd: TERPDbLookupCombo;
    btnNewProd: TDNMSpeedButton;
    edtSpecDisc: TEdit;
    edtDisc: TEdit;
    btnCopySpecialPrices: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    memqrySpecials: TkbmMemTable;
    MiscPageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabAuseParcel: TTabSheet;
    pnlServices: TDNMPanel;
    Bevel4: TBevel;
    lblServicesWarning: TLabel;
    Label71: TLabel;
    grdServices: TwwDBGrid;
    cboServiceReps: TwwDBLookupCombo;
    cboServices: TwwDBLookupCombo;
    cboServiceRatings: TwwDBLookupCombo;
    pnlServicesBottom: TDNMPanel;
    Bevel15: TBevel;
    Label64: TLabel;
    Label66: TLabel;
    pnlAttachments: TPanel;
    Qryclients_eParcel: TERPQuery;
    Qryclients_eParcelGlobalRef: TWideStringField;
    Qryclients_eParcelID: TIntegerField;
    Qryclients_eParcelClientID: TIntegerField;
    Qryclients_eParceleParcelreference1: TWideStringField;
    Qryclients_eParceleParcelreference2: TWideStringField;
    Qryclients_eParcelPrinteParcelreference1: TWideStringField;
    Qryclients_eParcelPrinteParcelreference2: TWideStringField;
    Qryclients_eParcelReturn_Company: TWideStringField;
    Qryclients_eParcelReturn_Name: TWideStringField;
    Qryclients_eParcelReturn_Street1: TWideStringField;
    Qryclients_eParcelReturn_Street2: TWideStringField;
    Qryclients_eParcelReturn_Street3: TWideStringField;
    Qryclients_eParcelReturn_Suburb: TWideStringField;
    Qryclients_eParcelReturn_State: TWideStringField;
    Qryclients_eParcelReturn_Country: TWideStringField;
    Qryclients_eParcelReturn_Postcode: TWideStringField;
    Qryclients_eParcelReDir_Company: TWideStringField;
    Qryclients_eParcelReDir_Name: TWideStringField;
    Qryclients_eParcelReDir_Street1: TWideStringField;
    Qryclients_eParcelReDir_Street2: TWideStringField;
    Qryclients_eParcelReDir_Street3: TWideStringField;
    Qryclients_eParcelReDir_Suburb: TWideStringField;
    Qryclients_eParcelReDir_State: TWideStringField;
    Qryclients_eParcelReDir_Country: TWideStringField;
    Qryclients_eParcelReDir_Postcode: TWideStringField;
    Qryclients_eParcelEmailNotification: TWideStringField;
    dsclients_eParcel: TDataSource;
    cboAccountQry: TERPQuery;
    DNMPanel12: TDNMPanel;
    Shape6: TShape;
    Shape5: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape1: TShape;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Shape4: TShape;
    Label97: TLabel;
    Label98: TLabel;
    Label114: TLabel;
    lblAccount: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    wwDBLookupCombo1: TwwDBLookupCombo;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    wwDBLookupCombo2: TwwDBLookupCombo;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    wwCheckBox1: TwwCheckBox;
    btnCopyReturnAddress: TDNMSpeedButton;
    DBEdit18: TDBEdit;
    wwCheckBox2: TwwCheckBox;
    txtExtraDeliveryInstructions: TDBMemo;
    cboAccount: TwwDBLookupCombo;
    wwRadioGroup1: TwwRadioGroup;
    Shape7: TShape;
    Label99: TLabel;
    Label100: TLabel;
    wwCheckBox3: TwwCheckBox;
    Label113: TLabel;
    wwCheckBox4: TwwCheckBox;
    Label112: TLabel;
    wwCheckBox5: TwwCheckBox;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    lblArea: TLabel;
    Bevel26: TBevel;
    Qryclients_eParcelconsigneePhoneonLabel: TWideStringField;
    Qryclients_eParcelLeaveAtAddress: TWideStringField;
    Qryclients_eParcelSignatureReqd: TWideStringField;
    Qryclients_eParcelExtraDeliveryInstructions: TWideStringField;
    Qryclients_eParcelChargeBackAcntID: TIntegerField;
    Qryclients_eParcelChargeBackAcnt: TWideStringField;
    qryJobDocumentPath: TWideStringField;
    qryJobcDocumentPath: TStringField;
    pnlDocsBottom: TDNMPanel;
    btnOpenDocumentPath: TDNMSpeedButton;
    btnSetDocumentPath: TDNMSpeedButton;
    lblDocumentPath: TDBText;
    QryJobcontacts: TERPQuery;
    QryJobcontactsGlobalRef: TWideStringField;
    QryJobcontactsContactID: TIntegerField;
    QryJobcontactsClientID: TIntegerField;
    QryJobcontactsClientName: TWideStringField;
    QryJobcontactsCompany: TWideStringField;
    QryJobcontactsContactTitle: TWideStringField;
    QryJobcontactsContactFirstName: TWideStringField;
    QryJobcontactsContactSurName: TWideStringField;
    QryJobcontactsContactAddress: TWideStringField;
    QryJobcontactsContactAddress2: TWideStringField;
    QryJobcontactsContactAddress3: TWideStringField;
    QryJobcontactsContactCity: TWideStringField;
    QryJobcontactsContactState: TWideStringField;
    QryJobcontactsContactPcode: TWideStringField;
    QryJobcontactsContactCountry: TWideStringField;
    QryJobcontactsContactPH: TWideStringField;
    QryJobcontactsContactAltPH: TWideStringField;
    QryJobcontactsContactMOB: TWideStringField;
    QryJobcontactsContactFax: TWideStringField;
    QryJobcontactsContactEmail: TWideStringField;
    QryJobcontactsNotes: TWideStringField;
    QryJobcontactsEditedFlag: TWideStringField;
    QryJobcontactsActive: TWideStringField;
    QryJobcontactsCardNumber: TWideStringField;
    QryJobcontactsAccountNo: TWideStringField;
    QryJobcontactsJobTitle: TWideStringField;
    QryJobcontactsUseOnRun: TWideStringField;
    QryJobcontactsmsTimeStamp: TDateTimeField;
    QryJobcontactsLogMeInComputerIPAddress: TWideStringField;
    QryJobcontactsLogMeInEmailPassword: TWideStringField;
    QryJobcontactsLogMeInUserName: TWideStringField;
    QryJobcontactsLogMeInPassword: TWideStringField;
    QryJobcontactsLogMeInERPUserName: TWideStringField;
    QryJobcontactsLogMeInERPPassword: TWideStringField;
    QryJobcontactsLogMeIncomputerPassword: TWideStringField;
    QryJobcontactsIsPrimarycontact: TWideStringField;
    QryJobcontactsMainContactforCashSale: TWideStringField;
    QryJobcontactsMainContactforVoucher: TWideStringField;
    QryJobcontactsMainContactforPOS: TWideStringField;
    QryJobcontactsMainContactforRefund: TWideStringField;
    QryJobcontactsMainContactforInvoice: TWideStringField;
    QryJobcontactsMainContactforSalesOrder: TWideStringField;
    QryJobcontactsMainContactforQuote: TWideStringField;
    QryJobcontactsMainContactforCheque: TWideStringField;
    QryJobcontactsMainContactforCredit: TWideStringField;
    QryJobcontactsMainContactforBill: TWideStringField;
    QryJobcontactsMainContactforPO: TWideStringField;
    QryJobcontactsMainContactforRA: TWideStringField;
    QryJobcontactsMainContactforRepair: TWideStringField;
    QryJobcontactsMainContactforStatements: TWideStringField;
    QryJobcontactsNotaMainContact: TWideStringField;
    QryJobcontactsDoNotContact: TWideStringField;
    QryJobcontactsTeamviewerID: TWideStringField;
    QryJobcontactsmsUpdateSiteCode: TWideStringField;
    btnLoadCustomercontacts: TDNMSpeedButton;
    QryJobcontactsMainContactForSupplierPayment: TWideStringField;
    pgCustomFields: TPageControl;
    tabCustomFields: TTabSheet;
    pnlcustomfieldList: TDNMPanel;
    DNMPanel13: TDNMPanel;
    Memo1: TMemo;
    TabSheet3: TTabSheet;
    pnlCustFldsFixed: TDNMPanel;
    Bevel27: TBevel;
    Bevel28: TBevel;
    Label96: TLabel;
    CUSTLBL1: TLabel;
    CUSTLBL2: TLabel;
    CUSTLBL3: TLabel;
    CUSTLBL4: TLabel;
    CUSTLBL5: TLabel;
    CUSTLBL6: TLabel;
    CUSTLBL7: TLabel;
    CUSTLBL8: TLabel;
    CUSTLBL9: TLabel;
    CUSTLBL10: TLabel;
    CUSTLBL11: TLabel;
    CUSTLBL12: TLabel;
    CUSTLBL13: TLabel;
    CUSTLBL14: TLabel;
    CUSTLBL15: TLabel;
    CUSTLBL16: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    CUSTLBL17: TLabel;
    CUSTLBL18: TLabel;
    CUSTFLD1: TwwDBComboBox;
    CUSTFLD2: TwwDBComboBox;
    CUSTFLD3: TwwDBComboBox;
    CUSTFLD4: TwwDBComboBox;
    CUSTFLD5: TwwDBComboBox;
    CUSTFLD10: TwwDBComboBox;
    CUSTFLD9: TwwDBComboBox;
    CUSTFLD8: TwwDBComboBox;
    CUSTFLD7: TwwDBComboBox;
    CUSTFLD6: TwwDBComboBox;
    CUSTFLD11: TwwDBComboBox;
    CUSTFLD12: TwwDBComboBox;
    CUSTFLD13: TwwDBComboBox;
    CUSTFLD14: TwwDBComboBox;
    CUSTFLD15: TwwDBComboBox;
    CUSTFLD16: TwwDBDateTimePicker;
    CUSTFLD17: TwwDBDateTimePicker;
    CUSTFLD18: TwwDBDateTimePicker;
    qryJobExpiryDate: TDateField;
    DNMSpeedButton2: TDNMSpeedButton;
    lblClientPrintNameHeading: TLabel;
    edtPrintname: TwwDBEdit;
    qryJobPrintName: TWideStringField;
    lblPrintName: TStaticText;
    qryJobPrintJobName: TWideStringField;
    Label104: TLabel;
    wwCheckBox6: TwwCheckBox;
    memoSalesComments: TDBMemo;
    Bevel30: TBevel;
    Label105: TLabel;
    tabInsurance: TTabSheet;
    tabProducts: TTabSheet;
    DNMPanel15: TDNMPanel;
    Bevel31: TBevel;
    Bevel32: TBevel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    edtRegistration: TwwDBEdit;
    wwDBDateTimePicker7: TwwDBDateTimePicker;
    wwDBEdit5: TwwDBEdit;
    editKms: TwwDBEdit;
    cboManufacture: TwwDBLookupCombo;
    cboModel: TwwDBLookupCombo;
    edtHours: TwwDBEdit;
    edtColor: TwwDBEdit;
    cboYear: TwwDBDateTimePicker;
    edtBodyType: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    wwDBEdit12: TwwDBEdit;
    edtStormLocation: TwwDBLookupCombo;
    cboStormDate: TwwDBDateTimePicker;
    ERPDbLookupCombo1: TERPDbLookupCombo;
    wwDBDateTimePicker10: TwwDBDateTimePicker;
    wwDBEdit13: TwwDBEdit;
    wwDBEdit14: TwwDBEdit;
    wwDBEdit15: TwwDBEdit;
    wwDBEdit16: TwwDBEdit;
    wwDBDateTimePicker11: TwwDBDateTimePicker;
    DNMPanel16: TDNMPanel;
    qryStockAdjustEntries: TERPQuery;
    dsStockAdjustEntries: TDataSource;
    grdProducts: TwwDBGrid;
    btnGrid: TwwIButton;
    qryStockAdjustEntriesAdjustmentdate: TDateTimeField;
    qryStockAdjustEntriesProcessed: TWideStringField;
    qryStockAdjustEntriesDeleted: TWideStringField;
    qryStockAdjustEntriesGlobalRef: TWideStringField;
    qryStockAdjustEntriesStockAdjustEntryID: TIntegerField;
    qryStockAdjustEntriesAccountID: TIntegerField;
    qryStockAdjustEntriesAccountName: TWideStringField;
    qryStockAdjustEntriesPreferedSupplier: TWideStringField;
    qryStockAdjustEntriesProductID: TIntegerField;
    qryStockAdjustEntriesProductName: TWideStringField;
    qryStockAdjustEntriesDescription: TWideStringField;
    qryStockAdjustEntriesClassID: TIntegerField;
    qryStockAdjustEntriesClassName: TWideStringField;
    qryStockAdjustEntriesAvailableQty: TFloatField;
    qryStockAdjustEntriesFinalQty: TFloatField;
    qryStockAdjustEntriesAdjustQty: TFloatField;
    qryStockAdjustEntriesAvailableUOMQty: TFloatField;
    qryStockAdjustEntriesFinalUOMQty: TFloatField;
    qryStockAdjustEntriesAdjustUOMQty: TFloatField;
    qryStockAdjustEntriesUOMMultiplier: TFloatField;
    qryStockAdjustEntriesUOMID: TIntegerField;
    qryStockAdjustEntriesAdjusttype: TWideStringField;
    qryJobBurden: TIntegerField;
    qryAccount1: TERPQuery;
    qryAccount1AccountID: TIntegerField;
    qryAccount1AccountName: TWideStringField;
    qryAccount2: TERPQuery;
    qryJobAccount1ID: TIntegerField;
    qryJobAccount1Name: TWideStringField;
    qryJobAccount2ID: TIntegerField;
    qryJobAccount2Name: TWideStringField;
    qryAccount2AccountID: TIntegerField;
    qryAccount2AccountName: TWideStringField;
    qryStockAdjustEntriesUOM: TWideStringField;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    cboAccount1: TwwDBLookupCombo;
    cboAccount2: TwwDBLookupCombo;
    qryJobStreet: TWideStringField;
    qryJobDiscount: TFloatField;
    qryStockAdjustEntriesCost: TFloatField;
    qryStockAdjustEntriesUOMCost: TFloatField;
    qryStockAdjustEntriesTotalCost: TFloatField;
    qrySASum: TERPQuery;
    qrySASumAQty: TFloatField;
    qrySASumTotalCost: TFloatField;
    Label4: TLabel;
    Label5: TLabel;
    edtBurden: TwwDBSpinEdit;
    procedure actReferralsPrintExecute(Sender: TObject);
    procedure actReferralsPrintUpdate(Sender: TObject);
    procedure actRepeatExecute(Sender: TObject);
    procedure actRepeatUpdate(Sender: TObject);
    procedure actServiceCycleExecute(Sender: TObject);
    procedure actServiceCycleUpdate(Sender: TObject);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnContactsClick(Sender: TObject);
    procedure btnDeleteReferralClick(Sender: TObject);
    procedure btnInactiveClick(Sender: TObject);
    procedure btnInactiveFollowUpClick(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
    procedure btnLoadCreditClick(Sender: TObject);
    procedure btnOrigAddClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSalesOrderClick(Sender: TObject);
    procedure BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure BillSuburbEnter(Sender: TObject);
    procedure cboCareServicesCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClientsExit(Sender: TObject);
    procedure cboCustomerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboEmpCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboEmpDropDown(Sender: TObject);
    procedure cboServiceRepsExit(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTemplateCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllRefsClick(Sender: TObject);
    procedure chkShowAllClick(Sender: TObject);
    procedure cmdNewContactClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure dtpDatePickerExit(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure EmailBtnClick(Sender: TObject);
    procedure EquipNotesDialog1UserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
    procedure FaxBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdCarePlanExit(Sender: TObject);
    procedure grdContactRowChanged(Sender: TObject);
    procedure grdEmpIButtonClick(Sender: TObject);
    procedure grdFollowUpExit(Sender: TObject);
    procedure grdReferralsExit(Sender: TObject);
    procedure grdServicesExit(Sender: TObject);
    procedure grpHistoryClick(Sender: TObject);
    procedure LetterBtnClick(Sender: TObject);
    procedure pgeControlChange(Sender: TObject);
    procedure pgeControlChanging(Sender: TObject; var AllowChange: boolean);
    procedure pgeControlResize(Sender: TObject);
    procedure qryContactsAfterOpen(DataSet: TDataSet);
    procedure qryCustomerServicesBeforePost(DataSet: TDataSet);
    procedure qryJobAfterOpen(DataSet: TDataSet);
    procedure qryJobcardsAfterInsert(DataSet: TDataSet);
    procedure qryJobcardsBeforePost(DataSet: TDataSet);
    procedure qryJobJobNumberValidate(Sender: TField);
    procedure qryJobRepIDChange(Sender: TField);
    procedure qryReferralsBeforePost(DataSet: TDataSet);
    procedure tbOtherFollowUpAfterOpen(DataSet: TDataSet);
    procedure tbOtherFollowUpBeforePost(DataSet: TDataSet);
    procedure cboManufactureNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboModelNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure btnAppointmentClick(Sender: TObject);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
    procedure qryTaxCodesBeforeOpen(DataSet: TDataSet);
    procedure qryCarePlanBeforePost(DataSet: TDataSet);
    procedure wwIButton1Click(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure qryJobAfterInsert(DataSet: TDataSet);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtStormLocationEnter(Sender: TObject);
    procedure cmdCopyClick(Sender: TObject);
    procedure grdCorrespondenceDblClick(Sender: TObject);
    procedure btnGetEmailsClick(Sender: TObject);
    procedure chkdocumentsClick(Sender: TObject);
    procedure grdDocsIButtonClick(Sender: TObject);
    procedure lvAttachmentsDblClick(Sender: TObject);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure HtmlViewerImageRequest(Sender: TObject; const SRC: string;
      var Stream: TStream);
    procedure grdCorrespondenceRowChanged(Sender: TObject);
    procedure grdSpecialsExit(Sender: TObject);
    procedure grdSpecialsFieldChanged(Sender: TObject; Field: TField);
    procedure cboProdChange(Sender: TObject);
    procedure cboProdCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure grdProdGroupDiscsExit(Sender: TObject);
    procedure grdProdGroupDiscsFieldChanged(Sender: TObject; Field: TField);
    procedure grdProdGroupDiscsIButtonClick(Sender: TObject);
    procedure grdSpecialsIButtonClick(Sender: TObject);
    procedure btnCopySpecialPricesClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure qrySpecialsAfterInsert(DataSet: TDataSet);
    procedure qrySpecialsAfterOpen(DataSet: TDataSet);
    procedure qrySpecialsAfterPost(DataSet: TDataSet);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure qrySpecialsNameChange(Sender: TField);
    procedure edtDiscExit(Sender: TObject);
    procedure edtSpecDiscExit(Sender: TObject);
    procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure Qryclients_eParcelAfterInsert(DataSet: TDataSet);
    procedure MiscPageControlChange(Sender: TObject);
    procedure MiscPageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnCopyReturnAddressClick(Sender: TObject);
    procedure wwDBLookupCombo2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure wwDBLookupCombo1CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure qryProdGroupDiscsAfterInsert(DataSet: TDataSet);
    procedure qryProdGroupDiscsAfterOpen(DataSet: TDataSet);
    procedure qryProdGroupDiscsBeforeOpen(DataSet: TDataSet);
    procedure qryProdGroupDiscsAfterPost(DataSet: TDataSet);
    procedure qryProdGroupDiscsBeforePost(DataSet: TDataSet);
    procedure qryJobCalcFields(DataSet: TDataSet);
    procedure btnSetDocumentPathClick(Sender: TObject);
    procedure btnOpenDocumentPathClick(Sender: TObject);
    procedure QryJobcontactsBeforeOpen(DataSet: TDataSet);
    procedure btnLoadCustomercontactsClick(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure edtPrintnameExit(Sender: TObject);
    procedure qryJobAfterPost(DataSet: TDataSet);
    procedure edtPrintnameChange(Sender: TObject);
    procedure grdProductsUpdateFooter(Sender: TObject);
  private
    fMsgHandler: TMsgHandler;
    fbRepairNo: string;
    oTASDescription: TASDescription;
    Equipmentform:TfmClientEquipment;
    qryParent: TERPQuery;
    iParentID: integer;
    bIsNewJob: boolean;
    iClientID: integer;
    AttachmentForm: TfmAttachments;
    fDefaultTab: String;
    fEquipmenttoAdd: String;
    fRegotoAdd: String;
    fbIsModified: boolean;
    fListAppoints: TBaseListingGUI;
    fListbilljobs: TBaseListingGUI;
    fSalesOrderList: TBaseListingGUI;
    fListInvoices: TBaseListingGUI;
    fListRepairs: TBaseListingGUI;
    fListQuotes: TBaseListingGUI;
    fListJobprofit: TBaseListingGUI;
    fTimesheetList: TBaseListingGUI;
    fListProductSales: TBaseListingGUI;
    fPayJobList: TBaseListingGUI;
    fPOList : TBaseListingGUI;
    SelectedMail: TIdMessage;
    HTMLImageStream: TMemoryStream;
    FileAssociationDetails: TFileAssociationDetails;
    MailProgesss: TProgressDialog;
    ProgressCanceled: boolean;
    fbUpdatingcompanyonName :Boolean;
    fbclientnameMadeFromName :Boolean;

    Function ListAppoints: TBaseListingGUI;
    Function ListBilljobs: TBaseListingGUI;
    Function SalesOrderList: TBaseListingGUI;
    Function ListInvoices: TBaseListingGUI;
    Function ListRepairs: TBaseListingGUI;
    Function ListQuotes: TBaseListingGUI;
    Function ListJobprofit: TBaseListingGUI;
    Function TimesheetList: TBaseListingGUI;
    Function ListProductSales: TBaseListingGUI;
    Function PayJobList: TBaseListingGUI;
    function PurchaseOrdersList : TBaseListingGui;


    function PreSaveJob: boolean;
    function ChkCustReqdFields: boolean;
//    function GetNextJobNumber(Const TryThisNo:Integer): integer;
    function GetRepFilter: string;
    procedure CalcHrsTaken;
    procedure LoadCreditFromParent;
    procedure SetClientToJob;
    (* procedure SetJobToContact; *)
    Procedure Callcontactform(Sender:TDNMSpeedbutton);
    function VerifyAndSave: boolean;
    Procedure UpdatefromEquipment;
    function MakeJobcontact: boolean;
    function MakeNewcontactifnone: Boolean;
    procedure InitListofHistoryforms(Sender: TObject);
    procedure AssignComboAccessed(Sender: TObject);
    procedure CopySpecialPricesToOtherCustomers;
    procedure DoCustomerListBeforeShow(Sender: TObject);
    procedure CustomerGridDataSelect(Sender: TwwDbGrid);
    procedure GetDiscounts;
    procedure MakeNewJob(const CustID: Integer);
    Procedure Makecustomer_eParcelRec;
    Procedure CopycontactsFromCustomer(CopyAnyway:Boolean);
    Procedure SetProdColumQry(Qry :TERPQuery; colno :Integer);
    procedure Makecompany;
    Procedure newRego(const Value:String);
  protected
    function GetReportTypeID: integer; override;
    procedure CustomFieldsRefresh;Override;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    function SaveOrCancelChanges: boolean;override;
    procedure CheckForEmails;
    procedure DoOnCheckForEmailsProgress(const msg: string; var Continue: boolean);
    procedure DoOnGetMessageCount(const MessageCount: integer);
    procedure DoOnProgressCancel(Sender: TObject);
    procedure KeyIdChanged(const NewKeyId: integer); override;
  public
    fbUpdatingNotes: boolean;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;

    property RepairNo: string read fbRepairNo write fbRepairNo;
    property ServiceCycleDescription: TASDescription read oTASDescription write oTASDescription;
    Property DefaultTab :String read fDefaultTab write fDefaultTab;
    Property EquipmenttoAdd :String read fEquipmenttoAdd Write fEquipmenttoAdd;
    Property RegotoAdd :String read fRegotoAdd Write fRegotoAdd;
    Procedure newEquip(const Value:String);
    Procedure AfterPopupformshow;Override;
    function ShiptoAddress:String;
    Function CustomFieldExtenderListtype: TListType; Override;
  published
    procedure AppointmentClosed(MsgObj: TMsgObj);
  end;

implementation

{$R *.dfm}

uses
  FormFactory, DNMExceptions, AppointmentListForm, {RepairsListForm,} SalesOrderListForm,
  QuoteListForm, InvoiceListForm, CommonDbLib, frmContactFrm,
  (*frmClientReferenceFrm,*) remainClientFrm, (*JobProfitabilityForm,*) PayJobList, QueryManipulationObj,
  StrUtils,  frmPayTimesheetFrm, CustomerSalesOnProductList, frmRepeat,
  {HiredItemReport,  {PbxRecordingsList,} frmInvoice, frmSalesOrder,
  AppContextObj,  frmPrintOptions, Commonlib, frmServiceDescriptionGUI,
  MyClasses, AppEnvironment, FastFuncs, ReportTemplates, tcConst,(*frmEquipmentFrm,*)
  BaseFormForm, tcDataUtils, BusObjEquipment, JobProfitabilityforCustomer,
  CommonFormLib, BusObjClient, BUsObjManufacture, BusObjModel,
  MailReaderObj, BusObjEmailConfig, HTTPUtil, ContentTypeObj, IdText,
  IdAttachmentFile, IdAttachmentMemory, IdHTTP, SystemLib, IdAttachment,
  ShellAPI, BusObjBase, EmailConst, IntegerListObj, BusObjCommon,
  frmCustomerCorrespondenceCreate, tcTypes, SMSUtilsGui, docPathLib, PurchaseOrderListForm,
  DbSharedObjectsObj, ProductQtyLib, HTTPConst, RepairList;

procedure TJobGUI.FormCreate(Sender: TObject);
begin
  fbUpdatingcompanyonName := false;
  lblCompany.visible := Devmode;
  lblClientPrintNameHeading.caption := appenv.companyPrefs.ClientPrintNameHeading;
  tabAusEParcel.TabVisible:= (Appenv.RegionalOptions.RegionType = RAust) and (Appenv.CompanyPrefs.EnableAusEparcel);
  SelectedMail := nil;
  FileAssociationDetails := TFileAssociationDetails.Create;
  HTMLImageStream := TMemoryStream.Create;
  fMsgHandler := TMsgHandler.Create(Self);
  fDefaultTab := '';
  fEquipmenttoAdd := '';
  fRegotoAdd := '';
  inherited;
  UserLock.Enabled := true;
  fbUpdatingNotes := false;
  KeyID := 0;
  iClientID := 0;
  qryCustomFields.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryDocuments.Connection := CommonDbLib.GetSharedMyDacConnection;

//  lblForcePORepairs.caption:= 'Force PO Entry On ' + AppEnv.CompanyPrefs.RepairTitle;
end;

procedure TJobGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
(*  RollbackTransaction;
  ModalResult := mrCancel;
 // btnClose.Enabled := false;  //Stops Click Twice
  Notify(True);*)
  DisableForm;
  try
    Notify(true);
    Self.Close;
  finally
    EnableForm;
  end;

end;

function TJobGUI.VerifyAndSave: boolean;
var
  sPrefix: string;
  BusObj: TBusObj;

  procedure focusinvalidcomp(const ftabsheet :TTabsheet; const finvcomp :TWinControl; const invalidmsg :STring);
  begin
    if invalidmsg <> '' then
      CommonLib.MessageDlgXP_Vista(invalidmsg, mtWarning, [mbOK], 0);
    if ftabsheet <> pgeControl.ActivePage then begin
      pgeControl.ActivePage := TTabSheet(ftabsheet);
      pgeControlChange(pgeControl);
    end;
    SetControlFocus(finvcomp);
  end;
begin
  result:= false;
  PreSaveJob;
  MakeNewcontactifnone;

  if not ChkCustReqdFields() then exit;
  if qryjobSendXMLInvoices.asString = 'T' then begin
    if qryjobEmailXML.asString = '' then begin
      CommonLib.MessageDlgXP_Vista('''XML email'' should not be blank when ''Send XML Invoices on Invoice Run'' is selected', mtWarning, [mbOK], 0);
      Exit;
    end;
  end;

  // Check if both account are selected in main tab
  if edtBurden.Text <> '0' then
    if (cboAccount1.Text = '') or (cboAccount2.Text = '') then begin
      CommonLib.MessageDlgXP_Vista('In main tab, both accounts(COGS, Expense) should be specified', mtWarning, [mbOK], 0);
      Exit;
    end;

  if Assigned(Equipmentform) and (Equipmentform.qryEquip.RecordCount > 0) then begin
    if not Equipmentform.CustomerEquipment.Save then begin
//      focusinvalidcomp(tabEquip ,Equipmentform.grdEquipment, '');
      exit;
    end;
  end;

  if char_length(edtJobName.Text) <> 0 then begin
    if not (qryJob.State in [dsBrowse]) then begin
      qryJob.FieldByName('Customer').AsString := 'T';
      qryJob.FieldByName('CreationDate').AsDateTime := Now;
      if pos('^', qryJob.FieldByName('Company').AsString ) =0 then qryJob.FieldByName('Company').AsString := lblCompany.Caption + '^' + edtJobName.Text;
      if pos('^', qryJob.FieldByName('PrintName').AsString ) =0 then qryJob.FieldByName('PrintName').AsString := lblPrintName.Caption + '^' + edtPrintname.Text;
      ProcessEditedFlag('Main', Self, memqryJob, qryJob, nil);
      qryJob.Edit;
      qryJob.Post;
    end;
    if (qryCustomerServices.Active) and (qryCustomerServices.RecordCount > 0) then begin
      qryCustomerServices.Edit;
      qryCustomerServices.Post;
    end;
    PostDB(Qryclients_eParcel);

    if (qryReferrals.Active) and (qryReferrals.RecordCount > 0) then begin
      qryReferrals.Edit;
      qryReferrals.Post;
    end;
    if qryJobCards.Active then if qryJobCards.State in [dsEdit, dsInsert] then qryJobCards.Post;

    if Assigned(Equipmentform) then Equipmentform.Save;

    ProcessEditedFlag('Follow Up Lines', Self, memtbOtherFollowUp, tbOtherFollowUp, nil);
    tbOtherFollowUp.Edit;

    if tbOtherFollowUp.RecordCount > 0 then tbOtherFollowUp.Post;

    ProcessEditedFlag('Special Price Lines', Self, memqrySpecials, qrySpecials, qryJob);
    EditDB(qrySpecials);
    PostDB(qrySpecials);

    BusObj:= TSpecialProducts.Create(nil);
    try
      BusObj.Dataset:= qrySpecials;
      //BusObj.SilentMode:= true;
      if not BusObj.ValidateDataList then begin
        focusinvalidcomp(tabSpecialproducts ,grdSpecials, '' {BusObj.ResultStatus.Messages});
        exit;
      end;
    finally
      FreeandNil(BusObj);
    end;

    BusObj:= TProductGroupDiscount.Create(nil);
    try
      BusObj.Dataset:= qryProdGroupDiscs;
      //BusObj.sSilentMode:= true;
      if not BusObj.ValidateDataList then begin
        focusinvalidcomp(tabSpecialproducts ,grdProdGroupDiscs, '' {BusObj.ResultStatus.Messages});
        exit;
      end;
    finally
      BusObj.Free;
    end;

    (* SetJobToContact; *)

    result:= true;

    CommitTransaction;
    KeyId := qryJobClientID.asInteger;
    Notify(False);

  end else begin
    if AppContext['Job'].VarExists('Caption') then sPrefix := AppContext['Job'].VarByname['Caption']
    else sPrefix := 'Job';

    CommonLib.MessageDlgXP_Vista(sPrefix + ' name cannot be blank.', mtWarning, [mbOK], 0);
    pgeControl.ActivePage := tabMain;
    SetControlFocus(edtJobName);
  end;
end;

procedure TJobGUI.btnCompletedClick(Sender: TObject);
begin
  inherited;

  if VerifyAndSave then
    Close;
end;

procedure TJobGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShowWindow(Handle, SW_HIDE);
  if iClientID <> 0 then AppContext['TJobGUI'].IntVar['NewJobId'] := iClientID;
  Self.Enabled := false;
  if not (fsModal in Self.FormState) then  Action := caFree;
  inherited;
end;

Procedure TJobGUI.MakeNewJob(Const CustID:Integer);
var
  Qry:TERPQuery;
begin
  qryJob.Insert;
  qryJob.FieldByName('ParentClientID').AsInteger := CustID;
  postdb(qryJob);

  if Qryclients_eParcel.ParamByName('CusID').AsInteger <>CustID then begin
    CloseDb(Qryclients_eParcel);
    Qryclients_eParcel.ParamByName('CusID').AsInteger := CustID;
  end;
  openDb(Qryclients_eParcel);
  Qry := DbSharedObj.GetQuery(qryJob.connection);
  try
    with Qry do begin
      {client Address}
      SQL.Text := 'Select area, Discount , SpecialDiscount,    ' +
                    ' Street, street2, street3, suburb,state,postcode,country, ' +
                    ' billStreet, billstreet2, billstreet3, billsuburb,billstate,billpostcode,billcountry, ' +
                    ' GroupDiscountOverridesAll, SpecialProductPriceOverridesAll   ' +
                    ' from tblclients where clientId = ' + inttostr( CustID);
      open;
      EditDB(Qryjob);
      QryjobDiscount.AsFloat                          := FieldByname('Discount').asFloat;
      QryJobSpecialDiscount.AsFloat                   := Fieldbyname('SpecialDiscount').AsFloat;
      QryJobGroupDiscountOverridesAll.AsBoolean       := Fieldbyname('GroupDiscountOverridesAll').AsBoolean;
      QryJobSpecialProductPriceOverridesAll.AsBoolean := Fieldbyname('SpecialProductPriceOverridesAll').AsBoolean;
      QryJobStreet.asString       :=  Fieldbyname('street').asString;
      QryJobstreet2.asString      :=  Fieldbyname('street2').asString;
      QryJobstreet3.asString      :=  Fieldbyname('street3').asString;
      QryJobsuburb.asString       :=  Fieldbyname('suburb').asString;
      QryJobstate.asString        :=  Fieldbyname('state').asString;
      QryJobpostcode.asString     :=  Fieldbyname('postcode').asString;
      QryJobcountry.asString      :=  Fieldbyname('country').asString;
      QryJobbillStreet.asString   :=  Fieldbyname('billstreet').asString;
      QryJobbillstreet2.asString  :=  Fieldbyname('billstreet2').asString;
      QryJobbillstreet3.asString  :=  Fieldbyname('billstreet3').asString;
      QryJobbillsuburb.asString   :=  Fieldbyname('billsuburb').asString;
      QryJobbillstate.asString    :=  Fieldbyname('billstate').asString;
      QryJobbillpostcode.asString :=  Fieldbyname('billpostcode').asString;
      QryJobbillcountry.asString  :=  Fieldbyname('billcountry').asString;
      PostDB(Qryjob);

{-------------tblclients_eparcel}
      if Active then close;
      SQL.Clear;
      SQL.add('select * from tblclients_eparcel Where clientID = ' + inttostr( CustID));
      open;
      if recordcount >0 then begin
          Qryclients_eParcel.Append;
          Qryclients_eParceleParcelreference1.asString     := FieldByname(Qryclients_eParceleParcelreference1.FieldName).asString;
          Qryclients_eParceleParcelreference2.asString     := FieldByname(Qryclients_eParceleParcelreference2.FieldName).asString;
          Qryclients_eParcelPrinteParcelreference1.asString:= FieldByname(Qryclients_eParcelPrinteParcelreference1.FieldName).asString;
          Qryclients_eParcelPrinteParcelreference2.asString:= FieldByname(Qryclients_eParcelPrinteParcelreference2.FieldName).asString;
          Qryclients_eParcelReturn_Company.asString        := FieldByname(Qryclients_eParcelReturn_Company.FieldName).asString;
          Qryclients_eParcelReturn_Name.asString           := FieldByname(Qryclients_eParcelReturn_Name.FieldName).asString;
          Qryclients_eParcelReturn_Street1.asString        := FieldByname(Qryclients_eParcelReturn_Street1.FieldName).asString;
          Qryclients_eParcelReturn_Street2.asString        := FieldByname(Qryclients_eParcelReturn_Street2.FieldName).asString;
          Qryclients_eParcelReturn_Street3.asString        := FieldByname(Qryclients_eParcelReturn_Street3.FieldName).asString;
          Qryclients_eParcelReturn_Suburb.asString         := FieldByname(Qryclients_eParcelReturn_Suburb.FieldName).asString;
          Qryclients_eParcelReturn_State.asString          := FieldByname(Qryclients_eParcelReturn_State.FieldName).asString;
          Qryclients_eParcelReturn_Country.asString        := FieldByname(Qryclients_eParcelReturn_Country.FieldName).asString;
          Qryclients_eParcelReturn_Postcode.asString       := FieldByname(Qryclients_eParcelReturn_Postcode.FieldName).asString;
          Qryclients_eParcelReDir_Company.asString         := FieldByname(Qryclients_eParcelReDir_Company.FieldName).asString;
          Qryclients_eParcelReDir_Name.asString            := FieldByname(Qryclients_eParcelReDir_Name.FieldName).asString;
          Qryclients_eParcelReDir_Street1.asString         := FieldByname(Qryclients_eParcelReDir_Street1.FieldName).asString;
          Qryclients_eParcelReDir_Street2.asString         := FieldByname(Qryclients_eParcelReDir_Street2.FieldName).asString;
          Qryclients_eParcelReDir_Street3.asString         := FieldByname(Qryclients_eParcelReDir_Street3.FieldName).asString;
          Qryclients_eParcelReDir_Suburb.asString          := FieldByname(Qryclients_eParcelReDir_Suburb.FieldName).asString;
          Qryclients_eParcelReDir_State.asString           := FieldByname(Qryclients_eParcelReDir_State.FieldName).asString;
          Qryclients_eParcelReDir_Country.asString         := FieldByname(Qryclients_eParcelReDir_Country.FieldName).asString;
          Qryclients_eParcelReDir_Postcode.asString        := FieldByname(Qryclients_eParcelReDir_Postcode.FieldName).asString;
          Qryclients_eParcelEmailNotification.asString     := FieldByname(Qryclients_eParcelEmailNotification.FieldName).asString;
      end;
    end;
{-------------special discount}
      if qrySpecials.ParamByName('CusID').AsInteger <>qryJobClientID.AsInteger then begin
        CloseDb(qrySpecials);
        qrySpecials.ParamByName('CusID').AsInteger := qryJobClientID.AsInteger;
      end;
      openDb(qrySpecials);

      with Qry do begin
        if active then Close;
        SQL.Text := qrySpecials.SQL.Text;
        Parambyname('CusID').AsInteger :=CustID;
        open;
        if recordcount > 0 then begin
          first;
          While Eof = False do begin
            if qrySpecials.Locate('ProductID' , fieldbyname('ProductID').AsInteger , []) = False then begin
                QrySpecials.Append;
                QrySpecialsCustomerID.AsInteger := qryJobClientID.AsInteger;
                QrySpecialsProductID.AsInteger  := fieldbyname('ProductID').AsInteger;
            end;
            EditDB(QrySpecials);
            QrySpecialsLinePrice.AsFloat    := fieldbyname('LinePrice').asfloat;
            QrySpecialsOrigPrice.AsFloat    := fieldbyname('OrigPrice').asfloat;
            QrySpecialsName.AsString        := fieldbyname('Name').asString;
            QrySpecialsDescription.AsString := fieldbyname('Description').asString;
            PostDb(QrySpecials);
            Next;
          end;
        end;
      end;
{--------------group discount}
      if qryProdGroupDiscs.ParamByName('xClientId').AsInteger <>qryJobClientID.AsInteger then
        CloseDb(qryProdGroupDiscs);
      openDb(qryProdGroupDiscs);
      with Qry do begin
        if active then Close;
        SQL.Text := qryProdGroupDiscs.SQL.Text;
        Parambyname('xclientId').AsInteger :=CustID;
        open;
        if recordcount > 0 then begin
          first;
          While Eof = False do begin
            if qryProdGroupDiscs.Locate('col1;col2;col3' , vararrayof([fieldbyname('Col1').asString,fieldbyname('Col2').asString,fieldbyname('Col3').asString]), []) = False then begin
                qryProdGroupDiscs.Append;
                qryProdGroupDiscsClientID.asInteger := qryJobClientID.AsInteger;
                qryProdGroupDiscscol1.AsString      := fieldbyname('col1').AsString;
                qryProdGroupDiscscol2.AsString      := fieldbyname('col2').AsString;
                qryProdGroupDiscscol3.AsString      := fieldbyname('col3').AsString;
            end;
            EditDB(qryProdGroupDiscs);
            qryProdGroupDiscsdiscount.AsFloat       := fieldbyname('discount').asfloat;
            PostDb(qryProdGroupDiscs);
            Next;
          end;
        end;
      end;
{-------------contacts}
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;


  PostDB(qryJob);
  EditDb(qryJob);
end;

procedure TJobGUI.MiscPageControlChange(Sender: TObject);
begin
  inherited;
  if MiscPageControl.activepage = tabAusEParcel then
    Makecustomer_eParcelRec;

end;

procedure TJobGUI.MiscPageControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  if MiscPageControl.activepage = tabAusEParcel then
    PostDB(Qryclients_eParcel);
end;

procedure TJobGUI.FormShow(Sender: TObject);
var
  DonotOpenQueries: array of string;
  i, iCnt: integer;
  strCaption: string;
  str1: string;
  strFilter: string;
  Templates : TReportTemplates;
  qry: TERPQuery;
begin
  try
    try
    fbTabSettingEnabled := false;
    inherited;
    pgeControl.ActivePage := tabMain;
    SetControlFocus(edtJobName);

    if qryJob.Active then begin
      if not (qryJob.State in [dsBrowse]) then begin
        qryJob.Post;
        Notify;
      end;
      CommitTransaction;
      CloseQueries;
    end;

    BeginTransaction;

    if KeyID < 0 then begin
      // this is a new JOB and KeyID contains the parent ID
      iParentID := Abs(KeyID);
      KeyID := 0;
    end;

    if KeyID <> 0 then begin
      edtJobName.ReadOnly := true;

      // Set qryStockAdjustEntries param
      qryStockAdjustEntries.ParamByName('jobID').AsInteger := KeyID;
    end;

    if not chkShowAll.Checked then begin
      qryContacts.filtered := false;
      qryContacts.filter := 'Active = ''T''';
      qryContacts.filtered := true;
    end;

    qryJob.ParamByName('xClientID').asInteger := KeyID;
    qryContacts.ParamByName('CusID').asInteger := KeyID;
    qryDocuments.ParamByName('CusID').asInteger := KeyID;
    qrySpecials.ParamByName('CusID').asInteger := KeyID;
    qryReferrals.ParamByName('xClientID').asInteger := KeyID;
    qryCustomerServices.ParamByName('xClientID').asInteger := KeyID;
    qryCarePlan.ParamByName('xClientID').asInteger := KeyID;
    tbOtherFollowUp.ParamByName('xClientID').asInteger := KeyID;

    Setlength(DonotOpenQueries, 4);
    DonotOpenQueries[0] := 'qrySuburb';
    DonotOpenQueries[1] := 'qryEquip';
    DonotOpenQueries[2] := 'qryJobcards';
    DonotOpenQueries[3] := 'qryCustomer';
    OpenQueries(DonotOpenQueries);

    SetProdColumQry(QryProductGroupcol1 , 1);
    SetProdColumQry(QryProductGroupcol2,2);
    SetProdColumQry(QryProductGroupcol3,3);

    if KeyID = 0 then begin
      bIsNewJob := true;
      MakeNewJob(iParentID);
      iClientID := 0;
    end else begin
      iClientID := KeyID;
      bIsNewJob := false;
      EditNoAbort(qryJob);
    end;

    if (AccessLevel <= 2) or (bIsnewJob and (AccessLevel <= 3)) then begin
      btnOrigAdd.Enabled:= true;
      btnAddDateTime.Enabled:= true;
    end
    else begin
      btnOrigAdd.Enabled:= false;
      btnAddDateTime.Enabled:= false;
    end;

    chkActive.Enabled:= (AccessLevel = 1);

    // Get Parent Client's Details
    if not bIsNewJob then begin
      iParentID := qryJOB.FieldByName('ParentClientID').AsInteger;
    end;
    qryParent := TERPQuery.Create(nil);
    qryParent.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qryParent do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ClientID, Company, Printname, ABN, Title, FirstName, MiddleName, LastName, ' +
        'Position, Street, Street2,Street3, Suburb, State, Country, Postcode, BillStreet, ' +
        'BillStreet2,BillStreet3, BillSuburb, BillState, BillCountry, BillPostcode, POBox, POSuburb, ' +
        'POState, POCountry, POPostcode, Phone, FaxNumber, Mobile, Email, ' +
        'AltContact, AltPhone, Contact1, PhoneSupportTill, Contact2, Contact1Phone, ');
      SQL.Add('Contact2Phone, Notes, ClientNo, ' +
        'MedTypeID, TYPE, TAXID, CreditLimit, Balance, GracePeriod, TermsID,terms, ' +
        'ShippingMethod, ShippingID, Discount, SpecialDiscount, JobName, ' +
        'IsJob, CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, ' +
        'CUSTFLD6, CUSTFLD7, CUSTFLD8, CUSTFLD9, CUSTFLD10, ');
      SQL.Add('CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15, ' +
        'PayMethodID, Feedback, Customer, Supplier, OtherContact, ' +
        'OtherContactType, RepID, Global, Done, Active, ' +
        'EditedFlag, DontContact, ParentClientID, ClientTypeId ');
      SQL.Add('FROM tblClients where ClientID = :xClientID');
      ParamByName('xClientID').AsInteger := qryJOB.FieldByName('ParentClientID').AsInteger;
      Open;
      if not IsEmpty then begin
        lblCompany.Caption := FieldByName('Company').AsString;
        lblPrintName.Caption := FieldByName('Printname').AsString;
      end else begin
        lblCompany.Caption := CLIENT_WORKSHOP;
        lblPrintName.Caption := clientPrintName(CLIENT_WORKSHOP);
      end;
    end;

    edtNotes.PlainText := true;

    edtSpecDisc.Text := FloatToStrF(StrValue(edtSpecDisc.Text), ffFixed, 7, 2) + ' %';
    edtDisc.Text     := FloatToStrF(StrValue(edtDisc.Text), ffFixed, 7, 2) + ' %';

    if bIsNewJob then begin
      // Set account1, account2 default as Burden *
      qryAccount1.Locate('AccountName', 'Burden COGS', []);
      cboAccount1.Text := 'Burden COGS';
      qryAccount2.Locate('AccountName', 'Burden Expense', []);
      cboAccount2.Text := 'Burden Expense';

      edtBurden.Text := '0';

      qryJob.FieldByName('CreationDate').AsDateTime := Date;
      qryJob.FieldByName('Title').AsString :=
        qryParent.FieldByName('Title').AsString;
      qryJob.FieldByName('FirstName').AsString :=
        qryParent.FieldByName('FirstName').AsString;
      qryJob.FieldByName('LastName').AsString :=
        qryParent.FieldByName('LastName').AsString;
      qryJob.FieldByName('Phone').AsString :=
        qryParent.FieldByName('Phone').AsString;
      qryJob.FieldByName('FaxNumber').AsString :=
        qryParent.FieldByName('FaxNumber').AsString;
      qryJob.FieldByName('AltPhone').AsString :=
        qryParent.FieldByName('AltPhone').AsString;
      qryJob.FieldByName('Active').AsString := 'T';
      qryJob.FieldByName('IsJob').AsString := 'T';
      qryJob.FieldByName('MedTypeID').AsInteger :=
        qryParent.FieldByName('MedTypeID').AsInteger;
      qryJob.FieldByName('RepID').AsInteger :=
        qryParent.FieldByName('RepID').AsInteger;
      qryJob.FieldByName('ClientTypeID').AsInteger :=
        qryParent.FieldByName('ClientTypeID').AsInteger;

      if qryJob.State in [dsEdit, dsInsert] then
        qryJob.Post;

      qryJob.Edit;
      qryJob.FieldByName('JobNumber').AsString := CommonDbLib.GetSequenceNumber(SEQ_JobNumber);
//        GetNextJobNumber(qryJob.FieldByName('ClientID').AsInteger);
      if qryJob.State in [dsEdit, dsInsert] then
        qryJob.Post;

      qryJob.Edit;

      if AppEnv.CompanyPrefs.StartJobNameWithJobNumber then begin
        qryJob.FieldByName('JobName').AsString := qryJob.FieldByName('JobNumber').AsString;
      end;

      LoadCreditFromParent;

      qryJob.Post;
      iClientID := qryJob.FieldByName('ClientID').AsInteger;
    end;

    (*qryCustomer.filter := 'clientId = ' + IntToStr(qryJobParentClientID.asInteger);
    qryCustomer.Filtered := True;*)
    closedb(qryCustomer);
    qryCustomer.SQL.text :=   'SELECT * FROM tblClients ' +
                              ' WHERE clientId = ' + IntToStr(qryJobParentClientID.asInteger)+'  ' +
                              ' and isJob <> "T"   ' +
                              ' AND Active = "T"   ' +
                              ' AND Customer = "T"   ' +
                              ' ORDER BY Company';
    opendb(qryCustomer);

    if Self.CallingClassName = 'TfrmCustomerJobFollowupList' then begin
      pgeControl.ActivePage := TTabSheet(tabFollowUp);
    end;

    //Tab Width Calc (2 Rows)
    iCnt := 0;
    for i := 0 to pgeControl.PageCount - 1 do begin
      if pgeControl.Pages[i].TabVisible then begin
        Inc(iCnt);
      end;
    end;

    CustomFieldsRefresh;

    pgeControl.MultiLine   := true;
    pgeControl.RaggedRight := true;
    pgeControl.TabWidth    := Abs((pgeControl.Width - 4) div System.Round((iCnt + 0.5) / 2));

    {Initialising the job no to repairno when called from repairs form}
    if KeyId = 0 then
        if RepairNo <> '' then
        begin
          if not (qryJob.State in [dsEdit, dsInsert]) then qryJob.Edit;
          qryJob.FieldByName('JobName').AsString := 'Repair No ' + RepairNo;
          pgeControl.ActivePage := tabMain;
          if edtJobName.Enabled = false then edtJobName.Enabled := true;
          SetControlFocus(edtJobName);
        end;
    with qryTemplate do begin
      Templates := TReportTemplates.Create;
      try
        if Templates.CreatedOk then begin
          Templates.MyConnection := qryjob.connection;
          if Active = false then Open;
          First;
          strFilter := '';
          while Eof = false do begin
            str1 := Templates.GetSQLForReport(FieldByName('TemplName').AsString, 1);
            if FastFuncs.PosEx(uppercase('tblCustomerjobcards'), uppercase(str1)) > 0 then begin
              if strFilter <> '' then strFilter := strFilter + ' or ';
              strFilter := strFilter + ' TemplId = ' + FieldByName('templId').AsString;
            end;
            Next;
          end;
        end;
      finally
        if Assigned(Templates) then
          FreeandNil(Templates);
      end;
      if strFilter <> '' then begin
        filtered := false;
        strFilter := ' (' + strFilter + ')';
        if filter <> '' then filter := filter + ' and ' + strfilter
        else filter := strFilter;
        filtered := true;
      end;
    end;
    DataState.Activate;

    CalcHRsTaken;

    if AppContext['Job'].VarExists('Caption') then strCaption := AppContext['Job'].VarByname['Caption']
    else strCaption := 'Jobs';

    TitleLabel.Caption := strCaption;
    Self.Caption := ChangeFormCaption(strCaption, Self.Caption);
    Label9.Caption := strCaption + ' Name';
    Label55.Caption := 'Customer ' + strCaption + '#';
    Label25.Caption := AppEnv.CompanyPrefs.JobNumberHeader;

    (*if Trim(edtJobName.Text) = '' then begin
      if qryJob.State in [dsEdit, dsInsert] then else qryJob.Edit;
      qryJobJobName.AsString := edtJobNo.Text;
      edtJobName.Text     := edtJobNo.Text;
    end;*)
    if Trim(edtPrintname.Text) = '' then begin
      if qryJob.State in [dsEdit, dsInsert] then else qryJob.Edit;
      qryJobPrintname.AsString := edtJobNo.Text;
      edtPrintname.Text     := edtJobNo.Text;
    end;

    if AppContext['TJobGUI'].VarExists('JobName') then begin
      if not (qryJob.State in [dsEdit, dsInsert]) then QryJob.Edit;
      QryJob.FieldByName('JobName').AsString := AppContext['TJobGUI'].varByname['JobName'];
      edtJobName.Text := AppContext['TJobGUI'].varByname['JobName'];
      AppContext['TJobGUI'].DeleteVar('JobName');
    end;

    finally
      Setcontrolfocus(edtPrintname);
    if RegotoAdd <> '' then begin
      newRego(RegotoAdd);
    end else if EquipmenttoAdd <> '' then begin
      newEquip(EquipmenttoAdd);
    end else if fDefaultTab ='Equipment' then begin
      pgeControl.ActivePage:= tabEquip;
      pgeControlChange(pgeControl);
    end;
    end;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TJobGUI.CalcHRsTaken;
//var
//  Qry: TERPQuery;
begin
//  edtHoursTakenForJob.Enabled := AppEnv.CompanyPrefs.RepairEquipListLimit <> 'C';

//  if AppEnv.CompanyPrefs.RepairEquipListLimit = 'C' then begin
    if qryJob.FieldByName('clientId').AsInteger = 0 then begin
      if not (Qryjob.State in [dsEdit, dsInsert]) then qryJob.edit;
      qryJob.FieldByName('HoursTakenForJob').AsInteger := 0;
      Exit;
    end;
end;

procedure TJobGUI.btnOrigAddClick(Sender: TObject);
begin
  inherited;
  qrySuburb.Open;
  EditDb(qryJob);
  qryJob.FieldByName('BillStreet').AsString :=
    qryParent.FieldByName('BillStreet').AsString;
  qryJob.FieldByName('BillStreet2').AsString :=
    qryParent.FieldByName('BillStreet2').AsString;
  qryJob.FieldByName('BillStreet3').AsString :=
    qryParent.FieldByName('BillStreet3').AsString;
  qryJob.FieldByName('BillSuburb').AsString :=
    qryParent.FieldByName('BillSuburb').AsString;
  qryJob.FieldByName('BillState').AsString :=
    qryParent.FieldByName('BillState').AsString;
  qryJob.FieldByName('BillPostCode').AsString :=
    qryParent.FieldByName('BillPostCode').AsString;
  qryJob.FieldByName('BillPostCode').AsString :=
    qryParent.FieldByName('BillPostCode').AsString;
  qryJob.FieldByName('BillCountry').AsString :=
    qryParent.FieldByName('BillCountry').AsString;

  qryJob.FieldByName('Street').AsString :=
    qryParent.FieldByName('Street').AsString;
  qryJob.FieldByName('Street2').AsString :=
    qryParent.FieldByName('Street2').AsString;
  qryJob.FieldByName('Street3').AsString :=
    qryParent.FieldByName('Street3').AsString;
  qryJob.FieldByName('Suburb').AsString :=
    qryParent.FieldByName('Suburb').AsString;
  qryJob.FieldByName('State').AsString :=
    qryParent.FieldByName('State').AsString;
  qryJob.FieldByName('PostCode').AsString :=
    qryParent.FieldByName('PostCode').AsString;
  qryJob.FieldByName('Country').AsString :=
    qryParent.FieldByName('Country').AsString;
end;

procedure TJobGUI.BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.FieldByName('BillState').AsString    := LookupTable.FieldByName('State').AsString;
    FillTable.FieldByName('BillPostcode').AsString := LookupTable.FieldByName('Postcode').AsString;
    FillTable.FieldByName('BillCountry').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TJobGUI.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.FieldByName('State').AsString    := LookupTable.FieldByName('State').AsString;
    FillTable.FieldByName('Postcode').AsString := LookupTable.FieldByName('Postcode').AsString;
    FillTable.FieldByName('Country').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TJobGUI.grpHistoryClick(Sender: TObject);
var
  HistoryListform: TBaseListingGUI;
//  TempShowQuerySpeedNotification: boolean;
  iIndex: integer;
begin
  HistoryListform := nil;
//  TempShowQuerySpeedNotification := AppEnv.Employee.ShowQuerySpeedNotification;

  inherited;
  try
//    AppEnv.Employee.ShowQuerySpeedNotification := false;

    case grpHistory.ItemIndex of
      0:HistoryListform := ListAppoints;
      1:HistoryListform := SalesOrderList;
      2:HistoryListform := ListQuotes;
      3:HistoryListform := ListInvoices;
      4:HistoryListform := ListRepairs;
      5:HistoryListform := ListJobprofit;
      6:HistoryListform := PayJobList;
      7:HistoryListform := TimesheetList;
      8:HistoryListform := ListProductSales;
      9:HistoryListform := ListBilljobs;
      10:HistoryListForm := PurchaseOrdersList;
    end;
    if Assigned(HistoryListform) then begin
      pnlHistory.Font.Size := 9;
      grpHistory.Color := HistoryListform.pnlHeader.Color;
      HistoryListform.Parent := pnlHistory;
      HistoryListform.BorderStyle := bsNone;
      HistoryListform.Show;

      case grpHistory.ItemIndex of
        6:
          begin //Job Profitability Extra Details
            HistoryListform.grpFilters.ItemIndex := 2;
          end;
      end;

      // Show Print & Export
      for iIndex := 0 to HistoryListform.FooterPanel.ControlCount - 1 do begin
        if HistoryListform.FooterPanel.Controls[iIndex] is TControl then begin
          TControl(HistoryListform.FooterPanel.Controls[iIndex]).Visible := false;
        end;
      end;

//      HistoryListform.FooterPanel.Height := 30;
//      HistoryListform.cmdExport.Top := 1;
//      HistoryListform.cmdExport.Left := 100;
//      HistoryListform.cmdExport.Visible := true;
//      HistoryListform.cmdPrint.Top := 1;
//      HistoryListform.cmdPrint.Left := pnlHistory.Width - 200;
//      HistoryListform.cmdPrint.Visible := true;
//      HistoryListform.FooterPanel.Visible := true;
//      HistoryListform.grpFilters.Visible := true;
//      HistoryListform.pnlButtons.Visible := true;
//      HistoryListform.grdMain.PopupMenu := HistoryListform.mnuFilter;
//      HistoryListform.grdMain.Align := alClient;
//      HistoryListform.lblcustomReport.Visible := False;
//      HistoryListform.cboCustomReports.Visible := False;

      HistoryListform.Refresh;

      if HistoryListform.ClassNameIs('TInvoiceListGUI') then begin
        TInvoiceListGUI(HistoryListform).btnDelete.Visible := false;
      end;

      if HistoryListform.ClassNameIs('TJobProfitabilityforCustomerGUI') then begin
        TJobProfitabilityforCustomerGUI(HistoryListform).chkAllClients.Visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).ClientID := KeyID; //  And chkAllClients.checked=false
        TJobProfitabilityforCustomerGUI(HistoryListform).Label4.Visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).Label5.Visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).cboClients.Visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).cboClass.Visible := false;
      end;

      if HistoryListForm.ClassNameIs('TPurchaseOrderListGUI') then
      begin
        TPurchaseOrderListGUI(HistoryListForm).grpFilters.ItemIndex := 2;
        TPurchaseOrderListGUI(HistoryListForm).grdPOOptions.ItemIndex := 0;
        TPurchaseOrderListGUI(HistoryListForm).grpFilters.visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).Label4.Visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).Label5.Visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).cboClients.Visible := false;
        TJobProfitabilityforCustomerGUI(HistoryListform).cboClass.Visible := false;
      end;

    end else begin
      if Assigned(fListAppoints) then begin
        fListAppoints.Parent := nil;
        fListAppoints.Hide;
      end;
      if Assigned(fListbilljobs) then begin
        fListbilljobs.Parent := nil;
        fListbilljobs.Hide;
      end;
      (*if Assigned(fListAppoints) then begin
        fListAppoints.Parent := nil;
        fListAppoints.Hide;
      end;*)

      if Assigned(fListQuotes) then begin
        fListQuotes.Parent := nil;
        fListQuotes.Hide;
      end;

      if Assigned(fListInvoices) then begin
        fListInvoices.Parent := nil;
        fListInvoices.Hide;
      end;
      if Assigned(fListRepairs) then begin
        fListRepairs.Parent := nil;
        fListRepairs.Hide;
      end;

      if Assigned(fListJobprofit) then begin
        fListJobprofit.Parent := nil;
        fListJobprofit.Hide;
      end;

      if Assigned(fPayJobList) then begin
        fPayJobList.Parent := nil;
        fPayJobList.Hide;
      end;

      if assigned(fPOList) then
      begin
        fPOLIst.Parent := nil;
        fPOList.Hide;
      end;

      if Assigned(fTimesheetList) then begin
        fTimesheetList.Parent := nil;
        fTimesheetList.Hide;
      end;

      if Assigned(fListProductSales) then begin
        fListProductSales.Parent := nil;
        fListProductSales.Hide;
      end;

      pnlHistory.Font.Size := 15;
      pnlHistory.Caption := 'YOU DO NOT HAVE ACCESS TO THIS REPORT!';
      pnlHistory.Paint;
    end;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TJobGUI.HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
  var Handled: Boolean);
begin
  inherited;
  if SameText(qryDocuments.FieldByName('Ref_Typ').AsString,'Voice') then
    SMSUtilsGui.PlayMessages(SRC)
  else
    ShellExecute(0,'open',PChar(SRC),nil,nil,SW_NORMAL)
end;

procedure TJobGUI.HtmlViewerImageRequest(Sender: TObject; const SRC: string;
  var Stream: TStream);
var
  MessageId: string;
  HTTP: TIdHTTP;
  x: integer;
begin
  inherited;
  Stream := nil;
  HTMLImageStream.Clear;
  if Assigned(SelectedMail) then begin
    if Pos('cid:',LowerCase(SRC)) = 1 then begin
      { looking for content id from part of this message }
      MessageId := Copy(SRC,5,Length(SRC));

      for x := 0 to SelectedMail.MessageParts.Count -1 do begin
        if Pos(MessageId, SelectedMail.MessageParts[x].ContentID) > 0 then begin
          if SelectedMail.MessageParts[x] is TIdAttachmentFile then begin
            TIdAttachmentFile(SelectedMail.MessageParts[x]).SaveToStream(HTMLImageStream);
            HTMLImageStream.Position := 0;
            Stream := HTMLImageStream;
          end;
          break;
        end;
      end;
    end
    else if Pos('http',LowerCase(SRC)) = 1 then begin
      { external image request }
      HTTP:= TIDHTTP.Create(nil);
      try
        HTTP.Request.UserAgent := HTTPConst.TrueERPUserAgent;
        HTTP.Get(SRC,HTMLImageStream);
        try
          HTMLImageStream.Position := 0;
          if HTMLImageStream.Size > 0 then
            Stream := HTMLImageStream;
        except

        end;
      finally
        HTTP.Free;
      end;
    end;
  end;
end;

procedure TJobGUI.pgeControlChange(Sender: TObject);
begin
  inherited;

  //Save Before Changing Tabs (They Need KeyID !)

  (* SetJobToContact; *)

  if pgeControl.ActivePage = TTabSheet(tabHistory) then begin
    pnlHistory.Update;
    Application.ProcessMessages;
    grpHistoryClick(Sender);
  end else if pgeControl.ActivePage = TTabSheet(tabReferrals) then begin
    if not qryReferrals.Active then begin
      qryReferrals.Open;
      qryClients.Open;
    end;
  end else if pgeControl.ActivePage = TTabSheet(tabEquip) then begin
    if Equipmentform = nil then begin
      Equipmentform:= TfmClientEquipment.Newform(KeyID, self.Myconnection, self, CustEquipDNMPanel, UpdatefromEquipment);
    end;
  end else if pgeControl.ActivePage = TTabSheet(tabServices) then begin
    qryEmpID.Close;
    qryEmpID.Open;
    qryEmpID.Filtered := false;
    qryEmpID.Filter   := GetRepFilter;
    qryEmpID.Filtered := true;
    qryServices.Close;
    qryServices.Open;
    qryRating.Close;
    qryRating.Open;
    qryCustomerServices.Open;
  end else if pgecontrol.ActivePage = TTabSheet(tabspecialproducts) then begin
    opendb(QryProductGroupcol1);
    opendb(QryProductGroupcol2);
    opendb(QryProductGroupcol3);
    opendb(qrySpecials);
    opendb(qryProdGroupDiscs);
  end else if pgecontrol.ActivePage = TTabSheet(tabfollowup) then begin
    if not qryJobcards.Active then begin
      qryJobcards.ParamByName('xClientID').asInteger := KeyID;
      qryJobcards.Open;
    end;
    if qryEmpLookup.Active = false then qryEmpLookup.Open;
  end else if pgecontrol.ActivePage = TTabSheet(tabDocuments) then begin
    AttachmentForm.PopulateListView;
  end else if pgecontrol.ActivePage = TTabSheet(tabCustomFields) then begin
    CustomFieldRefresh('CFCust' ,pnlCustFldsFixed);
  end;

end;

function TJobGUI.GetKeyString: string;
begin
  if qryJob.Active then
    result:= qryJobPrintName.AsString
  else
    result:= '';
end;

function TJobGUI.GetRepFilter: string;
var
  sAreas: string;
  iCustArea: integer;

  function AreaMatch(const icustArea: integer; const sRepAreas: string): boolean;
  var
    lst: TStringList;
    i: integer;
    index: integer;
    num1, num2: integer;
  begin
    Result := false;
    lst := TStringList.Create;
    try
      lst.CommaText := sRepAreas;
      for i := 0 to lst.Count - 1 do begin
        index := LastDelimiter('-', lst.Strings[i]);
        if index <> 0 then begin
          num1 := Trunc(StrValue(LeftStr(lst.Strings[i], index - 1)));
          num2 := Trunc(StrValue(RightStr(lst.Strings[i], char_length(lst.Strings[i]) - index)));
          if (num1 <> 0) and (num2 <> 0) and (num1 <= num2) then begin
            if (iCustArea >= num1) and (iCustArea <= num2) then begin
              Result := true;
              Break;
            end;
          end;
        end else begin
          if iCustArea = Trunc(StrValue(lst.Strings[i])) then begin
            Result := true;
            Break;
          end;
        end;
      end;
    finally
      FreeandNil(lst);
    end;
  end;
begin
  Result := '';
  if qryJobArea.AsString = '' then exit;
  if not(ISInteger(qryJobArea.AsString)) then exit;
  iCustArea := qryJobArea.AsInteger;
  if iCustArea <> 0 then begin
    qryEmpID.First;
    while not qryEmpID.Eof do begin
      sAreas := qryEmpId.FieldByName('AreaRange').AsString;
      if AreaMatch(iCustArea, sAreas) then begin
        if not Empty(Result) then begin
          Result := Result + ' OR ';
        end;
        Result := Result + 'EmployeeID = ' + IntToStr(qryEmpID.FieldByName('EmployeeID').AsInteger);
      end;
      qryEmpID.Next;
    end;
  end;
end;

procedure TJobGUI.qryJobAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryJob, memqryJob);
  GetDiscounts;
  If not Assigned(AttachmentForm) then Begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',True,Self,True,True,qryJobClientID.AsInteger));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblClients';
    AttachmentForm.TableId := qryJobClientID.AsInteger;
    AttachmentForm.Tag := qryJobClientID.AsInteger;
    AttachmentForm.lvAttachments.Parent := pnlAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;

procedure TJobGUI.Makecompany;
begin
  if not fbclientnameMadeFromName then  NamenPrintNameGridObj.Makecompany(fbUpdatingcompanyonName,qryJob , 'printjobname');
  fbclientnameMadeFromName := False;
end;
procedure TJobGUI.qryJobAfterPost(DataSet: TDataSet);
begin
  inherited;
  Makecompany;

end;

function TJobGUI.CustomFieldExtenderListtype: TListType;
begin
  Result := ltCustomer;
end;

procedure TJobGUI.CustomFieldsRefresh;
begin
  CustomFieldRefresh('CFCust', pnlCustFldsFixed);
end;


procedure TJobGUI.DoOnCheckForEmailsProgress(const msg: string;
  var Continue: boolean);
begin
  if Assigned(MailProgesss) then begin
    MailProgesss.Message := msg;
    MailProgesss.StepIt;
    Continue := not ProgressCanceled;
  end;
end;

procedure TJobGUI.DoOnGetMessageCount(const MessageCount: integer);
begin
  FreeAndNil(MailProgesss);
  MailProgesss := TProgressDialog.Create(self);
  MailProgesss.MaxValue := MessageCount;
  MailProgesss.Step := 1;
  MailProgesss.Caption := 'Checking for Emails';
  MailProgesss.AllowCancel := true;
  MailProgesss.OnCancel := DoOnProgressCancel;
  MailProgesss.Execute;
  ProgressCanceled := false;
end;

procedure TJobGUI.DoOnProgressCancel(Sender: TObject);
begin
  ProgressCanceled := true;
end;

//function TJobGUI.GetNextJobNumber(Const TryThisNo:Integer): integer;
//var
//  qry: TERPQuery;
//  Conn: TERPConnection;
//begin
//  Result := TrythisNo;
//  qry := TERPQuery.Create(self);
//  Conn := GetNewMyDacConnection(self);
//  try
//    qry.Connection := Conn;
//    with qry do begin
//      SQL.Clear;
//      SQL.Add('Select ClientID From tblclients WHERE JobNumber = '+IntToStr(TryThisNo));
//      Open;
//      If RecordCount=0 then Exit;
//      Close;
//    end;
//    Conn.Disconnect;
//    Conn.IsolationLevel := ilReadUncommitted;
//    with qry do begin
//      SQL.Clear;
//      SQL.Add('SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;');
//      Execute;
//    end;
//    with qry do begin
//      SQL.Clear;
//      SQL.Add('Select Max(JobNumber) as Next From tblclients');
//      Open;
//    end;
//    Result := qry.FieldByName('Next').asInteger + 1;
//  finally
//    FreeAndNil(qry);
//    FreeandNil(Conn);
//  end;
//end;


procedure TJobGUI.BillSuburbEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TJobGUI.qryJobRepIDChange(Sender: TField);
begin
  inherited;
  qryJob.Edit;
  qryJobRepName.AsString := qryRep.FieldByName('Name').AsString;
end;

procedure TJobGUI.qryProdGroupDiscsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  EditDB(qryProdGroupDiscs);
  qryProdGroupDiscs.FieldByName('ClientID').AsInteger := KeyID;
end;

procedure TJobGUI.qryProdGroupDiscsAfterOpen(DataSet: TDataSet);
begin
  inherited;
    qryProdGroupDiscsCol1.DisplayLabel := AppEnv.DefaultClass.FirstColumn;
    qryProdGroupDiscsCol2.DisplayLabel := AppEnv.DefaultClass.SecondColumn;
    qryProdGroupDiscsCol3.DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
end;

procedure TJobGUI.qryProdGroupDiscsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if Isrecordempty(qryProdGroupDiscs , qryProdGroupDiscsClientID.FieldName +',' +qryProdGroupDiscsGrpDiscID.FieldName) then
    grdProdGroupDiscsIButton.Click;
end;

procedure TJobGUI.qryProdGroupDiscsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  PostDB(qryJob);
  qryProdGroupDiscs.ParamByName('xClientID').AsInteger := qryJobClientID.AsInteger;
end;

procedure TJobGUI.qryProdGroupDiscsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not TProductGroupDiscount.IsUnique(qryProdGroupDiscsGrpDiscID.AsInteger, 'ClientID= ' + inttostr(qryProdGroupDiscsClientID.AsInteger) +
                                                                          ' and Col1= ' +quotedstr(qryProdGroupDiscsCol1.AsString) +
                                                                          ' and Col2= ' +quotedstr(qryProdGroupDiscsCol2.AsString) +
                                                                          ' and Col3= ' +quotedstr(qryProdGroupDiscsCol3.AsString),
                                        qryProdGroupDiscs.connection) then begin
    cancelDb(qryProdGroupDiscs);
    abort;
  end;
end;

procedure TJobGUI.btnLoadCreditClick(Sender: TObject);
begin
  LoadCreditFromParent;
end;

procedure TJobGUI.btnLoadCustomercontactsClick(Sender: TObject);
begin
  inherited;
  CopycontactsFromCustomer(True);
end;

procedure TJobGUI.LoadCreditFromParent;
var
  bInEdit: boolean;
begin
  bInEdit := false;
  if qryJob.State in [dsInsert, dsEdit] then begin
    qryJob.Post;
    bInEdit := true;
  end;
  qryJob.Edit;
  qryJobCreditLimit.AsCurrency := qryParent.FieldByName('CreditLimit').AsCurrency;
  qryJobGracePeriod.AsInteger := qryParent.FieldByName('GracePeriod').AsInteger;
  qryJobTermsID.AsInteger := qryParent.FieldByName('TermsID').AsInteger;
  qryJobTerms.asString := qryParent.FieldByName('Terms').asString;
  if qryTerms.Locate('TermsID', qryParent.FieldByName('TermsID').AsInteger, [loCaseInsensitive]) then begin
    cboTerms.LookupValue := qryTerms.FieldByName('TermsID').AsString;
    cboTerms.RefreshDisplay;
  end;
  qryJob.Post;
  if bInEdit then begin
    qryJob.Edit;
  end;
end;

procedure TJobGUI.lvAttachmentsDblClick(Sender: TObject);
var
  item: TListItem;
  Option: word;
  FileName: string;
  SaveDialog: TSaveDialog;
begin
  inherited;
  item := lvAttachments.Selected;
  if Assigned(item) then begin
    Option := MessageDlgXP_Vista('Do you wish to Save of Open this attachment?',
      mtConfirmation, [] , 0, nil , '','', False, nil, 'Save,Open,Cancel');
    case Option of
      100: { save }
        begin
          FileName := SystemLib.GetMyDocumentsDir + TIdAttachment(item.Data).FileName;
          SaveDialog:= TSaveDialog.Create(nil);
          try
            SaveDialog.FileName := FileName;
            SaveDialog.InitialDir := ExtractFilePath(FileName);
            if SaveDialog.Execute then begin
              TIdAttachment(item.Data).SaveToFile(SaveDialog.FileName);
            end;
          finally
            SaveDialog.Free;
          end;
        end;
      101: { open }
        begin
          FileName := SystemLib.GetAppTempDir + '\' + TIdAttachment(item.Data).FileName;
          TIdAttachment(item.Data).SaveToFile(FileName);
          ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL);
        end;
      102: exit; { Cancel }
    end;
  end;
end;

procedure TJobGUI.btnInactiveClick(Sender: TObject);
begin
  inherited;
  qryContacts.Edit;
  qryContacts.FieldByName('Active').AsString := 'F';
  qryContacts.Post;
  qryContacts.Close;
  qryContacts.Open;
end;

procedure TJobGUI.qryContactsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryContacts, memqryContacts);
end;

procedure TJobGUI.chkdocumentsClick(Sender: TObject);
begin
  inherited;
  qryDocuments.filtered := false;
  if not chkdocuments.Checked then begin
    qryDocuments.filter   := 'Active = ''T''';
    qryDocuments.filtered := true;
  end;
end;

procedure TJobGUI.chkShowAllClick(Sender: TObject);
begin
  inherited;
  qryContacts.filtered := false;
  if not chkShowAll.Checked then begin
    qryContacts.filter   := 'Active = ''T''';
    qryContacts.filtered := true;
  end;
end;

procedure TJobGUI.grdContactRowChanged(Sender: TObject);
begin
  inherited;
  Letterbtn.Enabled := (grdContact.datasource.dataset.Active) and (grdContact.datasource.dataset.recordcount > 0);
  Faxbtn.Enabled := Letterbtn.Enabled;
  Emailbtn.Enabled := Letterbtn.Enabled;
  Editbtn.Enabled := Letterbtn.Enabled;
end;

procedure TJobGUI.grdCorrespondenceDblClick(Sender: TObject);
var
  FileNamedocx,FileName: OleVariant;
  sRef: string;
  Form : TComponent;
  IdMessage: TIdMessage;
  Stream: TStream;
  EmailFileName: string;
begin
  inherited;
  if SameText(qryDocuments.FieldByName('Ref_Type').AsString, 'Email') and (qryDocuments.FieldByName('MessageId').AsString <> '') then begin
    { this is an email }
    EmailFileName := SystemLib.GetAppTempDir + '\' + qryDocuments.FieldByName('MessageId').AsString + '.eml';
    IdMessage := TIdMessage.Create;
    try
      Stream := qryDocuments.CreateBlobStream(qryDocuments.FieldByName('ReferenceData'),bmRead);
      try
        IdMessage.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
      IdMessage.SaveToFile(EmailFileName);
    finally
      IdMessage.Free;
    end;
    ShellExecute(Handle, 'Open', PChar(EmailFileName), '', '', SW_SHOWNORMAL);
    exit;
  end;



  sRef := qryDocuments.FieldByName('ReferenceTxt').AsString;
  if qryDocPath.FieldByName('DocumentPath').AsString <> '' then
    FileName    := qryDocPath.FieldByName('DocumentPath').AsString + '\' + SRef
  else FileName := 'C:\' + SRef;

  if AppEnv.Employee.UseWord then Begin
    FileNamedocx := FileName + '.docx';
    FileName := FileName + '.doc'
  end else
    FileName := FileName + '.RTF';

  if FileExists(FileNamedocx) then
    FileName := FileNamedocx;

  if not FileExists(FileName) then begin
    CommonLib.MessageDlgXP_Vista('Cannot Find File !', mtWarning, [mbOK], 0);
    Exit;
  end;

  if AppEnv.Employee.UseWord then begin
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
    WordApplication1.Connect;
    WordApplication1.Visible := true;
    WordApplication1.Documents.Open(FileName, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
    WordApplication1.Documents.Save(EmptyParam, EmptyParam);
    WordApplication1.Activate;
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
  end else begin
    FileName := FileName + '.RTF';
    Form := GetComponentByClassName('TREMainClient');
    if Assigned(Form) then begin
      with TREMainClient(Form) do begin
        Referencetxt.Text := SRef;
        Edit1.Text := 'True';
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;
end;

procedure TJobGUI.grdCorrespondenceRowChanged(Sender: TObject);
var
  stream: TStream;
  str: string;
  PartContent: TContentType;
  x: integer;
  BodyFound: boolean;
  Item: TListItem;
  ImageIndex: integer;
begin
  inherited;
  HTMLViewer.Clear;
  lvAttachments.Clear;
  FileAssociationDetails.Clear;
  lvAttachments.SmallImages := FileAssociationDetails.Images;
  if qryDocuments.FieldByName('MessageId').AsString <> '' then begin
    if not Assigned(SelectedMail) then begin
      SelectedMail := TIdMessage.Create(self);
    end;
    Stream := qryDocuments.CreateBlobStream(qryDocuments.FieldByName('ReferenceData'),bmRead);
    try
      SelectedMail.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;

    if SelectedMail.MessageParts.Count > 0 then begin
      BodyFound := false;
      PartContent := TContentType.Create;
      try
        for x := 0 to SelectedMail.MessageParts.Count -1 do begin
          PartContent.AsString := SelectedMail.MessageParts[x].ContentType;
          if SelectedMail.MessageParts[x] is TIdText then begin
            if (PartContent.SubType = 'html') and (not BodyFound) then begin
              BodyFound := true;
              HTMLViewer.LoadFromString(TIdText(SelectedMail.MessageParts[x]).Body.Text);
            end;
          end
          else if SelectedMail.MessageParts[x] is TIdAttachmentFile then begin
            if SelectedMail.MessageParts[x].ContentID = '' then begin
              { does not have a ContentId so is probably a separate attachment (as opposed to a body image attachment) }
              item := lvAttachments.Items.Add;
              item.Caption := TIdAttachmentFile(SelectedMail.MessageParts[x]).FileName;
              item.Data := SelectedMail.MessageParts[x];
            end;
          end
          else if SelectedMail.MessageParts[x] is TIdAttachmentMemory then begin
            if SelectedMail.MessageParts[x].ContentID = '' then begin
              { does not have a ContentId so is probably a separate attachment (as opposed to a body image attachment) }
              item := lvAttachments.Items.Add;
              item.Caption := TIdAttachmentMemory(SelectedMail.MessageParts[x]).FileName;
              item.Data := SelectedMail.MessageParts[x];
            end;
          end;
        end;
      finally
        PartContent.Free;
      end;

    end
    else begin
      { not a multipart message, display body text. }
      { remove illegal characters and replace CR LF with <BR> }
      str := StringReplace(HTTPUtil.HTMLEscape(SelectedMail.Body.Text),#13#10,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#10#13,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#10,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#13,'<BR>',[rfReplaceAll]);

      HTMLViewer.LoadFromString(str);
    end;

  end
  else begin
    FreeAndNil(SelectedMail);
    if SameText(qryDocuments.FieldByName('Ref_Type').AsString,'Email') then begin
      HTMLViewer.LoadFromString(EmailConst.EmailContentNotAvailable);
    end;

  end;
  if lvAttachments.Items.Count > 0 then begin
    lvAttachments.Visible := true;
    HTMLViewer.Height := lvAttachments.Top - 3;
    for x := 0 to lvAttachments.Items.Count -1 do begin
      FileAssociationDetails.AddFile(lvAttachments.Items[x].Caption);
    end;
    FileAssociationDetails.GetFileIconsAndDescriptions;
    for x := 0 to lvAttachments.Items.Count -1 do begin
      ImageIndex := FileAssociationDetails.Extensions.IndexOf(ExtractFileExt(lvAttachments.Items[x].Caption));
      lvAttachments.Items[x].ImageIndex := ImageIndex;
    end;

  end
  else begin
    lvAttachments.Visible := false;
    HTMLViewer.Height := lvAttachments.Top + lvAttachments.Height;
  end;
end;

procedure TJobGUI.grdDocsIButtonClick(Sender: TObject);
begin
  inherited;
  if QryDocuments.FieldByName('Active').asBoolean =False then begin
    MessageDlgXP_Vista('This document is already deleted', mtInformation, [mbOK], 0);
    Exit;
  end;
  if MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  EditDB(qryDocuments);
  QryDocuments.FieldByName('Active').asBoolean:= False;
  PostDb(qryDocuments);
end;

procedure TJobGUI.LetterBtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;
    PostDB(qryJob);
    EditDB(qryJob);
    PostDB(qryContacts);
    EditDB(qryContacts);
  CustContactCreateCorrespondence(ctLetter, self , Qryjobcompany.AsString);
(*Var Form : TComponent;
begin
  inherited;
  if qryJob.State in [dsEdit,dsInsert] then begin
    qryJob.Post;
    qryJob.Edit;
  end;

  Form := GetComponentByClassName('TfrmClientReference');
  if Assigned(Form) then begin
    with TfrmClientReference(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
      TitleLabel.Caption := 'Letter To Contact';
      EditedFlag.Checked := true;
      Ref_Type.Text := 'Letter';
      ClientID.Text := IntToStr(qryJob.FieldByName('ClientID').AsInteger);
      CID           := qryContacts.FieldByName('ContactID').AsInteger;
      Ref_Date.Text := DateToStr(Date);
      EmailNo.Text  := '';
      FaxNo.Text    := '';
      KeyID         := 0;
      Refresh;
    end;
  end; *)
end;

procedure TJobGUI.FaxBtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;
    PostDB(qryjob);
    EditDB(qryjob);
    PostDB(qryContacts);
    EditDB(qryContacts);
  CustContactCreateCorrespondence(ctFax, self, Qryjobcompany.AsString);
(*Var Form : TComponent;
begin
  inherited;
  if qryJob.State in [dsEdit,dsInsert] then begin
    qryJob.Post;
    qryJob.Edit;
  end;

  Form := GetComponentByClassName('TfrmClientReference');
  if Assigned(Form) then begin
    with TfrmClientReference(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;

      TitleLabel.Caption := 'Fax To Contact';
      EditedFlag.Checked := true;
      Ref_Type.Text := 'Fax';
      ClientID.Text := IntToStr(qryJob.FieldByName('clientid').AsInteger);
      CID := qryContacts.FieldByName('ContactID').AsInteger;
      Ref_Date.Text := DateToStr(Date);
      EmailNo.Text := '';
      if edtFax.Text <> '' then FaxNo.Text := edtFax.Text
      else FaxNo.Text := 'Fax';

      KeyID := 0;
      Refresh;
    end;
  end;*)
end;

procedure TJobGUI.EmailBtnClick(Sender: TObject);
begin
    if self.qryContactsContactEmail.AsString = '' then begin
      if CommonLib.MessageDlgXP_Vista('The contact ' + self.qryContactsCompany.AsString +
        ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
    end;
    if Accesslevel >= 5 then Exit;
    PostDB(qryjob);
    EditDB(qryjob);
    PostDB(qryContacts);
    EditDB(qryContacts);
    CustContactCreateCorrespondence(ctEmail, self, Qryjobcompany.AsString);
(*Var Form : TComponent;
begin
  inherited;
  if self.qryContactsContactEmail.AsString = '' then begin
    if CommonLib.MessageDlgXP_Vista('The contact ' + self.qryContactsCompany.AsString +
      ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
      mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
  end;

  if qryJob.State in [dsEdit,dsInsert] then begin
    qryJob.Post;
    qryJob.Edit;
  end;

  Form := GetComponentByClassName('TfrmClientReference');
  if Assigned(Form) then begin
    with TfrmClientReference(Form) do begin
      FormStyle := fsMDIChild;
      AttachObserver(self);
      BringToFront;

      TitleLabel.Caption := 'Email To Contact';
      EditedFlag.Checked := true;
      Ref_Type.Text := 'Email';
      ClientID.Text := IntToStr(qryJob.FieldByName('ClientID').AsInteger);
      Ref_Date.Text := DateToStr(Date);
//      if Email.Text <> '' then EmailNo.Text := Email.Text
//      else EmailNo.Text := 'Email';
      if qryContacts.RecordCount > 0 then
        EmailNo.Text :=  qryContactsContactEmail.AsString;

      FaxNo.Text := '';
      KeyID := 0;
      Refresh;
    end;
  end;*)
end;

procedure TJobGUI.EditBtnClick(Sender: TObject);
begin
  if self.qryContacts.FieldByName('ContactID').AsInteger=0 then Exit;
  Callcontactform(TDNMSpeedButton(EditBtn));
end;

procedure TJobGUI.edtDiscExit(Sender: TObject);
var
  TempPercent: double;
begin
  inherited;
  if IsOkToSave() then begin
    edtDisc.Text := FloatToStrF(StrValue(edtDisc.Text), ffFixed, 7, 2) + ' %';
    TempPercent  := StrValue(edtDisc.Text) / 100;
    if not qryJob.Active then begin
      qryJob.ParamByName('CusID').asInteger := KeyID;
      opendb(qryJob);
    end;
    EditDB(qryJob);
    qryJob.FieldByName('Discount').AsFloat := TempPercent;
    edtDisc.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';
  end;
end;

procedure TJobGUI.edtPrintnameChange(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = Sender then
    fbclientnameMadeFromName := False;

end;

procedure TJobGUI.edtPrintnameExit(Sender: TObject);
begin
  inherited;
  if Trim(qryJob.FieldByname('PrintName').AsString) <> '' then PostDB(qryJob);
end;

procedure TJobGUI.edtSpecDiscExit(Sender: TObject);
var
  TempPercent: double;
begin
  inherited;
  edtSpecDisc.Text := FloatToStrF(StrValue(edtSpecDisc.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtSpecDisc.Text) / 100;
  EditDB(qryJob);
  qryJob.FieldByName('SpecialDiscount').AsFloat := TempPercent;
  edtSpecDisc.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';

end;
procedure TJobGUI.GetDiscounts;
begin
  edtDisc.Text := FloatToStrF(qryJob.FieldByName('Discount').AsFloat * 100, ffGeneral, 5, 2);
  edtSpecDisc.Text := FloatToStrF(qryJob.FieldByName('SpecialDiscount').AsFloat * 100, ffGeneral, 5, 2);
end;

procedure TJobGUI.edtStormLocationEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TJobGUI.cmdCopyClick(Sender: TObject);
begin
  inherited;
  if qryJob.Active then begin
    EditDb(qryJob);
    qryJobBillStreet.AsString   := edtStreet.Text;
    qryJobBillStreet2.AsString  := edtStreet2.Text;
    qryJobBillStreet3.AsString  := edtStreet3.Text;
    qryJobBillSuburb.AsString   := Suburb.Text;
    qryJobBillState.AsString    := State.Text;
    qryJobBillPostCode.AsString := PostCode.Text;
    qryJobBillCountry.AsString  := Country.Text;
  end;
end;

procedure TJobGUI.cmdNewContactClick(Sender: TObject);
begin
  Callcontactform(TDNMSpeedButton(Sender));
end;


procedure TJobGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  if Shift = [ssCtrl] then begin
    cThisKey := Chr(Key);

    if cThisKey = 'M' then begin
      pgeControl.ActivePage := tabMain;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'T' then begin
      pgeControl.ActivePage := tabCustomer;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'A' then begin
      pgeControl.ActivePage := tabAddress;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'G' then begin
      pgeControl.ActivePage := tabGeneral;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'H' then begin
      pgeControl.ActivePage := tabHistory;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'E' then begin
      pgeControl.ActivePage := tabEquip;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'F' then begin
      pgeControl.ActivePage := Custom_Fields;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'O' then begin
      pgeControl.ActivePage := tabContacts;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'D' then begin
      pgeControl.ActivePage := tabDocuments;
      pgeControlChange(Sender);
      Key := 0;
      Exit;
    end;
  end;

  if key = VK_ESCAPE then
    if qryJobCards.State in [dsEdit, dsInsert] then
      qryJobCards.cancel
    else if assigned(EquipmentForm) then
      if EquipmentForm.canceldb then
    else if qryCustomerServices.State in [dsEdit, dsInsert] then
      qryCustomerServices.Cancel
    else if tbOtherFollowUp.State in [dsEdit, dsInsert] then
      tbOtherFollowUp.Cancel
    else if qryCarePlan.State in [dsEdit, dsInsert] then
      qryCarePlan.Cancel
    else inherited;
end;

procedure TJobGUI.btnDeleteReferralClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryReferrals);
end;

procedure TJobGUI.btnGetEmailsClick(Sender: TObject);
begin
  inherited;
  CheckForEmails;
end;

procedure TJobGUI.actReferralsPrintExecute(Sender: TObject);
var
  // lstReports: TStrings;
  i, j: integer;
  sSql: string;
begin
  inherited;

  fbReportSQLSupplied := true;

  dlgReportSelect.MultiSelect := true;
  LoadReportTypes;

  if not dlgReportSelect.Execute then begin
    Exit;
  end;

  for j := 0 to grdReferrals.SelectedList.Count - 1 do begin
    qryReferrals.GotoBookmark(grdReferrals.SelectedList.Items[j]);
    for i := 0 to dlgReportSelect.SelectedItems.Count - 1 do begin
      ReportToPrint := dlgReportSelect.SelectedItems[i];
      sSql :=
        'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
        'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' + 'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, ' +
        'C1.Company, C1.Street, C1.Street2, C1.Suburb, C1.State, C1.Postcode, ' + 'C2.Company as ReferredCompany, ' +
        'C2.Street as ReferredStreet, ' + 'C2.Street2 as ReferredStreet2, ' + 'C2.Suburb as ReferredSuburb, ' +
        'C2.State as ReferredState, ' + 'C2.PostCode as ReferredPostCode ' + 'FROM tblCompanyInformation as CO, tblclients as C1 ' +
        'INNER JOIN tblClients AS C2 ON C2.ClientID= ' + qryReferralsReferredClientID.AsString + ' ' +
        'WHERE C1.ClientID = ' + qryJobClientID.AsString;
      PrintTemplateReport(dlgReportSelect.SelectedItems[i], sSQL, not AppEnv.Employee.ShowPreview, 1);
    end;
  end;
  fbReportSQLSupplied := false;
end;

procedure TJobGUI.actReferralsPrintUpdate(Sender: TObject);
begin
  inherited;
  actReferralsPrint.Enabled := (grdReferrals.SelectedList.Count <> 0);
end;

procedure TJobGUI.chkAllRefsClick(Sender: TObject);
begin
  inherited;
  if chkAllRefs.Checked then begin
    grdReferrals.SelectAll;
  end else begin
    grdReferrals.UnselectAll;
  end;
end;

function TJobGUI.GetReportTypeID: integer;
begin
  Result := 47;
end;

procedure TJobGUI.qryCustomerServicesBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryCustomerServicesClientID.AsInteger := qryJobClientID.AsInteger;
end;

procedure TJobGUI.qryReferralsBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryReferralsClientID.AsInteger := qryJobClientID.AsInteger;
end;

procedure TJobGUI.grdServicesExit(Sender: TObject);
begin
  inherited;
  if grdServices.DataSource.DataSet.Active = false then Exit;
  if grdServices.DataSource.DataSet.RecordCount > 0 then begin
    grdServices.DataSource.DataSet.Edit;
    grdServices.DataSource.DataSet.Post;
    grdServices.DataSource.DataSet.Edit;
  end;
end;

procedure TJobGUI.grdSpecialsExit(Sender: TObject);
begin
  inherited;
  if (grdSpecials.DataSource.DataSet.Active) and (grdSpecials.DataSource.DataSet.RecordCount > 0) then begin
    EditDB(grdSpecials.DataSource.DataSet);
    PostDB(grdSpecials.DataSource.DataSet);
    EditDB(grdSpecials.DataSource.DataSet);
  end;
end;

procedure TJobGUI.grdSpecialsFieldChanged(Sender: TObject; Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TJobGUI.grdSpecialsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qrySpecials);
  EditDB(qryJob);
  qryJob.FieldByName('EditedFlag').AsString := 'T';
  PostDB(qryJob);
  EditDB(qryJob);
end;

procedure TJobGUI.grdReferralsExit(Sender: TObject);
begin
  inherited;
  if grdReferrals.DataSource.DataSet.Active = false then Exit;
  if grdReferrals.DataSource.DataSet.RecordCount > 0 then begin
    grdReferrals.DataSource.DataSet.Edit;
    grdReferrals.DataSource.DataSet.Post;
    grdReferrals.DataSource.DataSet.Edit;
  end;
end;

procedure TJobGUI.cboServiceRepsExit(Sender: TObject);
begin
  inherited;
  if grdServices.DataSource.DataSet.RecordCount > 0 then begin
    grdServices.DataSource.DataSet.Edit;
    grdServices.DataSource.DataSet.Post;
    grdServices.DataSource.DataSet.Edit;
  end;
end;

procedure TJobGUI.cboClientsExit(Sender: TObject);
begin
  inherited;
  if grdReferrals.DataSource.DataSet.RecordCount > 0 then begin
    grdReferrals.DataSource.DataSet.Edit;
    grdReferrals.DataSource.DataSet.Post;
    grdReferrals.DataSource.DataSet.Edit;
  end;
end;

procedure TJobGUI.EquipNotesDialog1UserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
begin
  inherited;
  Memo.Lines.Text := Memo.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ') ' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
end;

procedure TJobGUI.cboCareServicesCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if not LookupTable.Locate('ServiceDescription', cboCareServices.Text, [loCaseInsensitive]) then begin
    Exit;
  end;
  FillTable.Edit;
  FillTable.FieldByName('ServiceID').AsInteger := LookupTable.FieldByName('ServiceID').AsInteger;
  FillTable.FieldByName('ClientID').AsInteger := qryJobClientID.AsInteger;
end;

procedure TJobGUI.grdCarePlanExit(Sender: TObject);
begin
  inherited;
  if grdCarePlan.DataSource.DataSet.Active = false then Exit;
  with grdCarePlan.DataSource.DataSet do begin
    if State in [dsEdit, dsInsert] then Begin
      Post;
      Edit;
    end;
  end;
end;

procedure TJobGUI.cmdPrintClick(Sender: TObject);
var
  SQL: string;
begin
  inherited;
  qryJob.Edit;
  qryJob.Post;
  qryJob.Edit;
  qryCarePlan.Edit;
  qryCarePlan.Post;
  qryCarePlan.Edit;
  SQL := 'Where C.ClientID = ' + qryJobClientID.AsString;
  PrintTemplateReport('Care Plan', SQL, not AppEnv.Employee.ShowPreview, 1);
end;

procedure TJobGUI.tbOtherFollowUpAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(tbOtherFollowUp, memtbOtherFollowUp);
end;

procedure TJobGUI.tbOtherFollowUpBeforePost(DataSet: TDataSet);
begin
  inherited;
  tbOtherFollowUpClientID.Value := qryJob.FieldByName('ClientID').AsInteger;
  if (tbOtherFollowUpEmployeeID.AsInteger = 0) or (tbOtherFollowUpEmployeeID.IsNull) then begin
    tbOtherFollowUpEmployeeID.AsInteger := AppEnv.Employee.EmployeeID;
  end;
  tbOtherFollowUpCreationDate.Value := Now;
  tbOtherFollowUpIsSupplier.AsBoolean := false;
  tbOtherFollowUpIsCustomer.AsBoolean := true;
end;

procedure TJobGUI.grdFollowUpExit(Sender: TObject);
begin
  inherited;
  if grdFollowUp.DataSource.DataSet.Active = false then Exit;
  grdFollowUp.DataSource.DataSet.Edit;
  grdFollowUp.DataSource.DataSet.Post;
  grdFollowUp.DataSource.DataSet.Edit;
end;

procedure TJobGUI.grdProductsUpdateFooter(Sender: TObject);
begin
  // Calculate the sumaries
  qrySASum.Active := True;

  // Show summaries in the footer
  grdProducts.ColumnByName('AdjustUOMQty').FooterValue := FloatToStrF(qrySASumAQty.AsFloat, ffNumber, 10, 2);
  grdProducts.ColumnByName('TotalCost').FooterValue := FloatToStrF(qrySASUMTotalCost.AsFloat, ffCurrency, 10, 2);
end;

procedure TJobGUI.grdProdGroupDiscsExit(Sender: TObject);
begin
  inherited;
  if (grdProdGroupDiscs.DataSource.DataSet.Active) and (grdProdGroupDiscs.DataSource.DataSet.RecordCount > 0) then begin
    EditDB(grdProdGroupDiscs.DataSource.DataSet);
    PostDB(grdProdGroupDiscs.DataSource.DataSet);
    EditDB(grdProdGroupDiscs.DataSource.DataSet);
  end;
end;

procedure TJobGUI.grdProdGroupDiscsFieldChanged(Sender: TObject; Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TJobGUI.grdProdGroupDiscsIButtonClick(Sender: TObject);
begin
  inherited;
  qryProdGroupDiscs.Delete;
  EditDB(qryProdGroupDiscs);

end;

procedure TJobGUI.dtpDatePickerExit(Sender: TObject);
begin
  inherited;
  grdFollowUp.DataSource.DataSet.Edit;
  grdFollowUp.DataSource.DataSet.Post;
  grdFollowUp.DataSource.DataSet.Edit;
end;

procedure TJobGUI.btnInactiveFollowUpClick(Sender: TObject);
begin
  inherited;
  tbOtherFollowUp.Delete;
  if tbOtherFollowUp.RecordCount = 0 then begin
    tbOtherFollowUp.Insert;
  end else begin
    tbOtherFollowUp.Edit;
  end;
end;

procedure TJobGUI.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  qryJob.Edit;
  edtNotes.text:=AddDateTime(lcdOnLoganyway,edtNotes.text, true);
  qryJobNotes.AsString := edtNotes.Lines.Text;
  edtNotes.Update;
end;

procedure TJobGUI.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeControl, 2);
  RealignTabControl(MiscPageControl, 1);
end;

procedure TJobGUI.actRepeatUpdate(Sender: TObject);
begin
  inherited;
  if pgeControl.ActivePage = tabFollowup then begin
    btnRepeat.Enabled := true;
  end else begin
    btnRepeat.Enabled := false;
  end;
end;

procedure TJobGUI.actRepeatExecute(Sender: TObject);
  procedure InsertRecords(const dates: array of TDateTime);
  var
    iCnt: integer;
  begin
    if tbOtherFollowup.FieldByName('FollowupDate').AsDateTime = 0 then tbOtherFollowup.Delete;
    try
      for iCnt := 0 to Length(dates) - 1 do begin
        tbOtherFollowup.Insert;
        tbOtherFollowup.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        tbOtherFollowup.FieldByName('Done').AsString := 'F';
        tbOtherFollowup.FieldByName('FollowupDate').AsDateTime := DateOf(dates[iCnt]);
        tbOtherFollowup.FieldByName('CreationDate').AsDateTime := Date;
        tbOtherFollowup.FieldByName('IsCustomer').AsString := 'T';
        tbOtherFollowup.FieldByName('Hours').AsFloat := 0.0;
        tbOtherFollowup.FieldByName('ClientID').AsInteger := GetClientID(lblCompany.Caption);
        tbOtherFollowup.Post;
      end;

      // Ensure the followup table is returned to edit mode.
      tbOtherFollowup.Edit;
      CommonLib.MessageDlgXP_Vista(Format('Inserted %d Repeats into Customer Job Followup Table', [Length(dates)]), mtInformation , [mbOK], 0);
    except
      on e: Exception do begin
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
  end;
begin
  inherited;
  with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
    try
      Caption := 'Repeat Customer Job';

      ShowModal;

      if ModalResult = mrOk then begin
        InsertRecords(dates);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TJobGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(EquipmentForm);
  FreeAndNil(fMsgHandler);
  If Assigned(AttachmentForm) then FreeAndNil(AttachmentForm);
  Freeandnil(fListAppoints);
  Freeandnil(fListbilljobs);
  Freeandnil(fListQuotes);
  Freeandnil(fListInvoices);
  Freeandnil(fListRepairs);
  Freeandnil(fListJobprofit);
  Freeandnil(fPayJobList);
  FreeAndNil(fPOList);
  Freeandnil(fTimesheetList);
  Freeandnil(fListProductSales);
  HTMLImageStream.Free;
  FileAssociationDetails.Free;
  inherited;
end;

procedure TJobGUI.pgeControlResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeControl, 2);
  RealignTabControl(MiscPageControl, 1);
end;

function TJobGUI.PreSaveJob: boolean;
var
  sPrefix: string;
begin
  Result := false;
  try
    if not Empty(edtJobName.Text) then begin
      Result := true;
      EditDB(qryJob);
      qryJob.FieldByName('Customer').AsString := 'T';
      qryJob.FieldByName('CreationDate').AsDateTime := Now;
      qryJob.FieldByName('Company').AsString := lblCompany.Caption + '^' + edtJobName.Text;
      qryJob.FieldByName('PrintName').AsString := lblPrintName.Caption + '^' + edtPrintname.Text;

      // Wang for timesheet journal
      qryJob.FieldByName('Account1ID').AsInteger := qryAccount1.FieldByName('AccountID').AsInteger;
      qryJob.FieldByName('Account2ID').AsInteger := qryAccount2.FieldByName('AccountID').AsInteger;

      PostDB(qryJob);
      CopycontactsFromCustomer(False);
      KeyID := qryJobClientID.AsInteger;
      FormShow(nil);
      pgeControl.ActivePage := tabMain;
      qryJob.Edit;
    end else begin
      if AppContext['Job'].VarExists('Caption') then sPrefix := AppContext['Job'].VarByname['Caption']
      else sPrefix := 'Job';

      CommonLib.MessageDlgXP_Vista(sPrefix + ' name should not be blank ', mtWarning, [mbOK], 0);
    end;
  except
  end;
end;

function TJobGUI.PurchaseOrdersList: TBaseListingGui;
const
  csField = 'CLIENTID';
var
//  QueryManipulationObj : TQueryManipulationObj;
//  lSQL,
  lStr : string;
  lPos : integer;
  lidx,
  idx : integer;
begin

//  CreateHistorylistform('TPurchaseOrderListGUI' ,Self, fPOList,'ClientId ' , IntToStr(KeyID) , InitListofHistoryforms);
  CreateHistorylistform('TPurchaseOrderListGUI' ,Self, fPOList, csField , IntToStr(KeyID) , InitListofHistoryforms);
  Result := fPOList;
  lPos := 0;
  //
  lIdx := 0;
  for idx := fPOList.qryMain.SQL.Count - 1 downto fPOList.qryMain.SQL.Count - 4 do
  begin
    lStr := 'AND TBLCLIENTS.' + csField;
    lpos := pos('AND TBLCLIENTS.' + csField, fPOList.qryMain.SQL[idx]);
    if lPos > 0 then
    begin
      lIdx := idx;
      break;
    end;
  end;

  if lIdx = 0 then
      exit;
  lStr := copy(fPOList.qryMain.SQL[lIdx], 1, lPos + 3) + '(' + copy(fPOList.qryMain.SQL[lIdx], lPos + 4, length(fPOList.qryMain.SQL[lIdx]));
  lStr := lStr + ' OR TBLPURCHASELINES.CUSTOMERJOBID = ' + IntToStr(KeyId) + ')';
  fPOList.qryMain.SQL[lIdx] := lStr;
  fPOList.RefreshOrignalSQL;
  fPOList.ListManRunOnce := true;

end;

function TJobGUI.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Cust');
  if not Result then pgeControl.ActivePage := Custom_Fields;
end;

procedure TJobGUI.actServiceCycleUpdate(Sender: TObject);
begin
  inherited;
  if pgeControl.ActivePage = tabFollowup then begin
    btnServiceCycle.Enabled := true;
  end else begin
    btnServiceCycle.Enabled := false;
  end;
end;

procedure TJobGUI.actServiceCycleExecute(Sender: TObject);
var
  frm: TfrmServiceDescription;

  procedure InsertRecords(const dates: array of TDateTime);
  var
    iCnt: integer;
  begin
    if tbOtherFollowup.RecordCount > 0 then begin
      if tbOtherFollowup.FieldByName('FollowupDate').AsDateTime = 0 then tbOtherFollowup.Delete;
    end;

    try
      for iCnt := 0 to Length(dates) - 1 do begin
        tbOtherFollowup.Insert;
        tbOtherFollowup.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        tbOtherFollowup.FieldByName('Done').AsString := 'F';
        tbOtherFollowup.FieldByName('FollowupDate').AsDateTime := DateOf(dates[iCnt]);
        tbOtherFollowup.FieldByName('CreationDate').AsDateTime := Date;
        tbOtherFollowup.FieldByName('IsCustomer').AsString := 'T';
        tbOtherFollowup.FieldByName('Notes').AsString := ServiceCycleDescription.Result;
        tbOtherFollowup.FieldByName('ClientID').AsInteger := qryJob.FieldByName('ClientID').AsInteger;
        tbOtherFollowup.Post;
      end;

      // Ensure the followup table is returned to edit mode.
      tbOtherFollowup.Edit;
      CommonLib.MessageDlgXP_Vista(Format('Inserted %d Service Cycle Repeats into Customer Followup Table', [Length(dates)]), mtInformation , [mbOK], 0);

    except
      on e: Exception do begin
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
  end;
begin
  inherited;
  frm := TfrmServiceDescription(GetComponentByClassName('TfrmServiceDescription'));
  if Assigned(Frm) then begin
    with TfrmServiceDescription(Frm) do begin
      frm.ReturnResult := @oTASDescription;
      frm.FormStyle := fsNormal;
      frm.ShowModal;
    end;
  end;

  if not Empty(oTASDescription.Result) then begin
    with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
      try
        Caption := 'Service Cycle Repeat';

        ShowModal;

        if ModalResult = mrOk then begin
          InsertRecords(dates);
        end;
      finally
        Free;
      end;
    end;
  end;
end;

Function TJobGUI.MakeNewcontactifnone:Boolean;
var
  fbShowAllL:Boolean;
begin
  REsult := False;
      fbShowAllL:=chkShowAll.checked;
      try
        if chkShowAll.checked = False then chkShowAll.checked := true;
        if qryContacts.recordcount =0 then begin
          if MakeJobcontact then begin
            qryContacts.First;
            REsult := true;
          end;
        end;
      finally
        chkShowAll.checked := fbShowAllL;
      end;
end;

procedure TJobGUI.Makecustomer_eParcelRec;
begin
  postDB(qryJob);
  if Qryclients_eParcel.ParamByName('CusID').AsInteger <>qryJobClientID.AsInteger then begin
          closedb(Qryclients_eParcel);
          Qryclients_eParcel.ParamByName('CusID').AsInteger := qryJobClientID.AsInteger;
          opendb(Qryclients_eParcel);
  end;
  postDB(Qryclients_eParcel);
  if Qryclients_eParcel.recordcount =0 then Qryclients_eParcel.append;
end;

function TJobGUI.MakeJobcontact: boolean;
begin
            if qryContacts.Locate('ContactFirstName;ContactSurName;Active' , vararrayof([QryjobFirstName.asString ,QryjobLastName.asString , 'F' ]) , []) then begin
              editDb(qryContacts);
              qryContactsactive.asBoolean := True;
              PostDB(qryContacts);
              Result:=true;
              Exit;
            end;
        if (QryjobFirstName.asString = '') and (QryjobLastName.asString = '') then begin
          result:= false;
          exit;
        end;


        if QryjobclientId.asInteger = 0 then begin
          PostDb(Qryjob);
          EditDb(Qryjob);
        end;

        if qryContacts.ParamByName('CusID').AsInteger <>Qryjob.FieldByName('ClientID').AsInteger then begin
          closedb(qryContacts);
          qryContacts.ParamByName('CusID').AsInteger := Qryjob.FieldByName('ClientID').AsInteger;
          opendb(qryContacts);
        end;
        qryContacts.Insert;
        if qryContacts.state in [dsedit,dsinsert] then else qryContacts.Edit;
        qryContactsClientID.AsInteger  := QryjobclientId.asInteger;
        qryContactsClientName.ASString := QryjobCompany.AsString;
        qryContactsContactTitle.asString          :=  QryjobTitle.asString;
        qryContactsContactFirstName.asString      :=  QryjobFirstName.asString;
        qryContactsContactSurName.asString        :=  QryjobLastName.asString;
        qryContactsCompany.asString               :=  QryjobFirstName.asString+' ' +QryjobLastName.asString;
        qryContacts.Post;
        qryContacts.Edit;
        qryContactsContactMOB.asString            :=  QryjobMobile.asString;
        qryContactsjobtitle.asString              :=  QryjobJobTitle.asString;
        qryContactsContactEmail.asString          :=  QryjobEmail.asString;
        qryContactsContactPH.asString             :=  QryjobPhone.asString;
        qryContactsContactFax.asString            :=  QryjobFaxNumber.asString;
        qryContactsContactAltPH.asString          :=  QryjobAltPhone.asString;
        qryContactsContactAddress.asString        :=  QryjobStreet.asString;
        qryContactsContactAddress2.asString       :=  QryjobStreet2.asString;
        qryContactsContactCity.asString           :=  QryjobSuburb.asString;
        qryContactsContactState.asString          :=  QryjobState.asString;
        qryContactsContactPcode.asString          :=  QryjobPostcode.asString;
        qryContactsContactcountry.asString        :=  QryjobCountry.asString;
        qryContactsISPrimaryContact.asBoolean     := True;
        qryContacts.Post;
        result := QryContactsContactId.asInteger > 0;
end;
(* procedure TJobGUI.SetJobToContact;
var
  qry: TERPQuery;
begin
  if Empty(edtFirstName.Text) then Exit;
  qry := TERPQuery.Create(nil);
  try
    //qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.Connection := qryContacts.Connection;

    qry.SQL.Add('SELECT * FROM tblcontacts');
    qry.SQL.Add('WHERE ContactIsJob = "T" AND CusID = ' + qryJob.FieldByName('ClientID').AsString);
    qry.Open;

    // Does this record already exist?
    if qry.RecordCount > 0 then begin
      // Yes, then update the details.
      qry.Edit;
    end else begin
      // No, then create a new contact record.
      qry.Insert;
    end;

    qry.FieldByName('CusID').AsInteger           := qryJob.FieldByName('ClientID').AsInteger;
    qry.FieldByName('ContactFirstName').AsString := edtFirstName.Text;
    qry.FieldByName('ContactSurName').AsString   := edtLastName.Text;
    qry.FieldByName('Active').AsString           := 'T';
    qry.FieldByName('ContactPH').AsString        := edtPhone.Text;
    qry.FieldByName('ContactFax').AsString       := edtFax.Text;
    qry.FieldByName('ContactAltPH').AsString     := edtAltPhone.Text;
    qry.FieldByName('Company').AsString          := lblCompany.Caption;
    qry.FieldByName('ContactAddress').AsString   := edtStreet.Text;
    qry.FieldByName('ContactAddress2').AsString  := edtStreet2.Text;
    qry.FieldByName('ContactCity').AsString      := Suburb.Text;
    qry.FieldByName('ContactState').AsString     := State.Text;
    qry.FieldByName('ContactPcode').AsString     := Postcode.Text;
    qry.FieldByName('ContactIsJob').AsString     := 'T';
    qry.Post;

    qryContacts.Close;
    qryContacts.ParamByName('CusID').AsInteger := qryJob.FieldByName('ClientID').AsInteger;
    qryContacts.Open;
  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end; *)


procedure TJobGUI.SetKeyString(const Value: string);
begin
  SetKeyString(TJob, qryJob, Value , 'PrintName');
end;


procedure TJobGUI.SetProdColumQry(Qry: TERPQuery; colno: Integer);
begin
  closedb(Qry);
  Qry.SQL.clear;
  Qry.SQL.add('SELECT');
  if colno = 1 then Qry.SQL.add(Firstcolumn)
  else if colno = 2 then Qry.SQL.add(Secondcolumn)
  else if colno = 3 then Qry.SQL.add(thirdcolumn);
  Qry.SQL.add('AS PartLevel');
  Qry.SQL.add('FROM tblparts P');
  Qry.SQL.add('where ' );
  if colno = 1 then Qry.SQL.add(Firstcolumn)
  else if colno = 2 then Qry.SQL.add(Secondcolumn)
  else if colno = 3 then Qry.SQL.add(thirdcolumn);
  Qry.SQL.add('<> ""');
  Qry.SQL.add('Group by PartLevel');
  Qry.SQL.add('Order by PartLevel;');
end;

function TJobGUI.ShiptoAddress: String;
begin
  Result := ConcatStrings([qryJobCompany.AsString , qryJobstreet.AsString, qryJobstreet2.AsString, qryJobstreet3.AsString ,
            ConcatStrings([qryJobSuburb.AsString , qryJobState.AsString , qryJobPostcode.AsString], ' ')] , NL);
end;

procedure TJobGUI.qryJobJobNumberValidate(Sender: TField);
var
  qry: TERPQuery;
begin
  inherited;
  if Sender.AsString <> '' then begin
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT ClientID, JobNumber FROM tblclients');
      if KeyID = 0 then begin
        qry.SQL.Add('WHERE IsJob="T" AND JobNumber = ' + Sender.AsString);
      end else begin
        qry.SQL.Add('WHERE IsJob="T" AND JobNumber = ' + Sender.AsString + ' AND ClientID <> ' + IntToStr(KeyID));
      end;

      qry.Open;

      if qry.RecordCount > 0 then begin
        if CommonLib.MessageDlgXP_Vista('This Job Number has already been allocated!' + #13#10#13#10 +
          'Do you still wish to use it?', mtWarning, [mbYes, mbCancel], 0) = mrCancel then begin
          Abort;
        end;
      end;
    finally
      // Release our used objects.
      if Assigned(qry) then FreeAndNil(qry);
    end;
  end;
end;

procedure TJobGUI.btnPrintClick(Sender: TObject);
var
  sSQL: string;
  sClientID: string;
  PrintReport: boolean;
  str1: string;
  frm: TfmPrintOptions;
  Templates :TReportTemplates;
begin
  DisableForm;
  try
    inherited;
    PrintReport := False;

    if not VerifyAndSave then
      exit;
    BeginTransaction;

    frm := TfmPrintOptions(GetComponentByClassName('TfmPrintOptions'));
    if Assigned(frm) then begin
      with frm do begin
        Position        := poScreenCenter;
        ShowModal;
        if frm.ModalResult = mrCancel then Exit;
        PrintReport := PrintOption = 'P';
      end;
    end;

    sClientID := qryJob.FieldByName('ClientID').AsString;
    fbTemplateUsesNonFormConnection := false;
    sSQL := '';
    fbReportSQLSupplied := true;
    {take a confirmation to preview the jobcard templates before printing}
    sSQL := sSQL + '{Master} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + '"Customer Job Detail Report" AS ReportTitle, ';
    sSQL := sSQL + 'C.*, SUBSTRING_INDEX(C.Company, "^", 1) as Company_NoJobName, CONCAT_WS(" ", C.Title, C.FirstName, C.LastName) AS FullName, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.Suburb, C.State, C.PostCode) AS FullPostal, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.BillSuburb, C.BillState, C.BillPostCode) AS FullBillPostal, S.MediaType AS "Source" ';
    sSQL := sSQL + 'FROM tblclients C ';
    sSQL := sSQL + 'LEFT JOIN tblsource S on C.MedTypeID = S.MedTypeID ';
    sSQL := sSQL + 'WHERE C.ClientID=' + sClientID + ' AND C.IsJob="T"; ';
    sSQL := sSQL + '~|||~{Custom Fields} ';
    sSQL := sSQL + 'SELECT * FROM tblcustomfields; ';
    sSQL := sSQL + '~|||~{Contacts} ';
    sSQL := sSQL + 'SELECT *, CONCAT_WS(" ", ContactTitle, ContactFirstName, ContactSurName) AS FullName ';
    sSQL := sSQL + 'FROM tblcontacts ';
    sSQL := sSQL + 'WHERE ClientID = ' + sClientID;
    sSQL := sSQL + ' AND Active="T"; ';
    sSQL := sSQL + '~|||~{FollowUps} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + 'FU.FollowUpDate, FU.Notes, ';
    sSQL := sSQL + 'CASE FU.Done ';
    sSQL := sSQL + '  WHEN "T" THEN "Yes" ';
    sSQL := sSQL + '  WHEN "F" THEN "No" ';
    sSQL := sSQL + 'END AS "Completed", E.EmployeeName ';
    sSQL := sSQL + 'FROM tblotherfollowup FU ';
    sSQL := sSQL + 'LEFT JOIN tblemployees E ON FU.EmployeeID = E.EmployeeID ';
    sSQL := sSQL + 'WHERE FU.ClientID = ' + sClientID + ' ';
    sSQL := sSQL + '~|||~{Documents} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + 'tblReference.RefID, tblReference.Ref_Date as Date, tblReference.Ref_type as Type, tblReference.Referencetxt as Reference, ';
    sSQL := sSQL +
      'tblReference.CusID, tblReference.ContactID, CONCAT_WS(" ",tblContacts.ContactFirstName,tblContacts.ContactSurname) as ContactName, ';
    sSQL := sSQL + 'tblContacts.ContactID, tblReference.EditedFlag ';
    sSQL := sSQL + 'FROM tblReference ';
    sSQL := sSQL + 'LEFT JOIN tblClients ON tblReference.CusID=tblClients.ClientID ';
    sSQL := sSQL + 'LEFT JOIN tblContacts ON tblReference.ContactID=tblContacts.ContactID ';
    sSQL := sSQL + 'WHERE tblReference.CusID=' + sClientID + ' ';
    sSQL := sSQL + 'GROUP BY tblReference.RefID ';
    sSQL := sSQL + 'ORDER BY tblReference.Ref_Date DESC';
    sSQL := sSQL + '~|||~{JobCards} ';
    sSQL := sSQL + 'Select tblCustomerjobcards.ClientId,    ';
    //sSQL := sSQL + 'Concat('' '', tblemployees.Firstname, tblemployees.LastName) as Name,    ';
    sSQL := sSQL + ' if(tblemployees.MiddleName <> '''' , ';
    sSQL := sSQL + ' CONCAT_WS( '' '', tblemployees.Firstname, tblemployees.MiddleName, tblemployees.LastName ) , ';
    sSQL := sSQL + ' CONCAT_WS( '' '', tblemployees.Firstname, tblemployees.LastName ) )  as Name, ';
    sSQL := sSQL + 'tblCustomerjobcards.Notes, tblTemplates.TemplName   ';
    sSQL := sSQL + 'from tblCustomerjobcards  ';
    sSQL := sSQL + 'inner join  tblemployees  on tblCustomerjobcards.EmployeeId =  tblemployees.employeeId  ';
    sSQL := sSQL + 'left join   tblTemplates on tblCustomerjobcards.TemplateId =  tblTemplates.TemplId  ';
    sSQL := sSQL + 'WHERE tblCustomerjobcards.ClientID=' + sClientID;
    sSQL := sSQL + '~|||~{Relatedcustomercontacts} Select Cn.* from tblrelatedclients RC inner join tblclients C on c.clientID = RC.ChildclientID inner join tblcontacts CN on c.ClientId = CN.clientID Where RC.MasterClientID=' + sClientID;
    sSQL := sSQL + '~|||~{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';
    sSQL := sSQL + '~|||~{Machine}';
    sSQL := sSQL + 'Select ''Machinery'' as Machine, ';
    sSQL := sSQL + 'Manufacture, ModelNumber , SerialNumber, JobRegistration, WarrantyFinishDate , ';
    sSQL := sSQL + 'WarrantyPeriod , HoursTakenForJob  from tblclients';
  //  if AppEnv.CompanyPrefs.RepairEquipListLimit = 'C' then
    sSQL := sSQL + ' Where tblclients.ClientID = ' + sClientID;
  //  else sSQL := sSQL + ' Where tblclients.ClientID = 0';
    {printing the job details}
    PrintTemplateReport('CustomerJob', sSQL, PrintReport, 1);
    fbReportSQLSupplied := false;

    {PRINTING THE JOBCARDS AND TEMPLATES}

    {job card table is opened only when the tab isa ctivated. So
    open the table if the table is closed}
    if not qryJobcards.Active then begin
      qryJobcards.ParamByName('xClientID').asInteger := KeyID;
      qryJobcards.Open;
    end;
    if qryEmpLookup.Active = false then qryEmpLookup.Open;
    {nothing to print if there is no job card}
    if qryJobCards.RecordCount = 0 then Exit;

    {takes the confirmation - the confirmation messgae is populated after checking
    ther ecords in the table - both the job cards and its template}
    {str1 := 'Do you wish to preview the jobcards ';
    qryJobCards.First;
    While qryJobCards.Eof = False do begin
          if qryJobCards.FieldByname('TemplateName').aSSTring <> '' then
          if str1 = 'Do you wish to preview the jobcards ' then
              str1 := str1 + 'and templates';
          qryJobCards.Next;
    end;}

    {printing the employee lists (job cards)}
    {sSql := 'where tblCustomerjobcards.ClientId = ' + qryJob.fieldByname('ClientId').asString ;
    PrintTemplateReport('JobCards', sSQL, PrintReport, 1);}

    {printing the report template for each employee}
    if qryJobCards.RecordCount > 0 then begin
      qryJobCards.First;
      while qryJobCards.Eof = false do begin
        if qryJobCards.FieldByName('TemplateName').AsString <> '' then begin
          Templates := TReportTemplates.Create;
          if not Templates.CreatedOk then exit;
          try
            Templates.MyConnection := qryjob.connection;
                  {check for the tblcustomerJobcards table in the second SQL of the report
                  template selected.}
            str1 := Templates.GetSQLForReport(qryJobCards.FieldByName('TemplateName').AsString, 1);
            if FastFuncs.PosEx(uppercase('tblCustomerjobcards'), uppercase(str1)) = 0 then
              CommonLib.MessageDlgXP_Vista('Error occured while printing the jobcard template for customer job' + Chr(13) +
                '   Customer  :' + lblPrintName.Caption +'(' + Trim(lblCompany.Caption) + ')' +chr(13)+
                '   Job          :' + Trim(edtJobName.Text) + Chr(13) +
                '   Employee  :' + qryJobCards.FieldByName('EmployeeName').AsString + Chr(13) +
                '   Template  :' + qryJobCards.FieldByName('TemplateName').AsString, mtWarning, [mbOK], 0)
            else try
                if FastFuncs.PosEx(uppercase('Where'), uppercase(str1)) = 0 then Ssql := ' where   '
                else SSQL := 'and ';
                ssql := ssql + ' tblCustomerjobcards.ClientId = ' + qryJobCards.FieldByName('clientId').AsString;
                ssql := ssql + ' and tblCustomerjobcards.EmployeeId = ' + qryJobCards.FieldByName('EmployeeId').AsString;

                PrintTemplateReport(qryJobCards.FieldByName('TemplateName').AsString, sSQL, PrintReport, 1);
              except
                // raise a silent exception and continue with the next template
              end;
          finally
            if Assigned(Templates) then
              FreeandNil(Templates);
          end;
        end;
        qryJobCards.Next;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TJobGUI.btnInvoiceClick(Sender: TObject);
var
  frm: TInvoiceGUI;
begin
  inherited;
  if not VerifyAndSave then exit;
  BeginTransaction;
  frm := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
  if Assigned(Frm) then begin
    frm.InitialiseStartup := true;
    frm.CustomerID := qryJob.FieldByName('ClientID').AsInteger;
    frm.FormStyle := fsMDIChild;
    frm.BringToFront;
  end;
end;

procedure TJobGUI.btnSalesOrderClick(Sender: TObject);
var
  frm: TSalesOrderGUI;
begin
  inherited;
  if not VerifyAndSave then exit;
  BeginTransaction;
  frm := TSalesOrderGUI(GetComponentByClassName('TSalesOrderGUI'));
  if Assigned(Frm) then begin
    frm.InitialiseStartup := true;
    frm.CustomerID := qryJob.FieldByName('ClientID').AsInteger;
    frm.FormStyle := fsMDIChild;
    frm.BringToFront;
  end;
end;


procedure TJobGUI.pgeControlChanging(Sender: TObject; var AllowChange: boolean);
begin
  inherited;
  if bIsNewJob and (pgeControl.ActivePage = tabMain) then
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Save This Customer Job' + #13 + #10 + 'Before Setting Up Advanced Features ?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then AllowChange := PreSaveJob
    else AllowChange := False;
end;

procedure TJobGUI.cboEmpCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  {remove the filter of the lookup table }
  if not Modified then begin
    Lookuptable.Filtered := false;
    Exit;
  end;

  if not (qryJobcards.State in [dsEdit, dsInsert]) then qryJobcards.Edit;
  qryJobcards.FieldByName('EmployeeId').AsInteger := qryEmpLookup.FieldByName('EmployeeId').AsInteger;
  qryJobcards.FieldByName('Employeename').AsString := qryEmpLookup.FieldByName('EmployeeName').AsString;


  if not (qryTemplate.Active) then qryTemplate.Open;
  if qryTemplate.Locate('TemplId', qryEmpLookup.FieldByName('DefaultInvoiceTemplateID').AsInteger, []) then begin
    qryJobcards.FieldByName('TemplateId').AsInteger  := qryEmpLookup.FieldByName('DefaultInvoiceTemplateID').AsInteger;
    qryJobcards.FieldByName('TemplateName').AsString := qryTemplate.FieldByName('TemplName').AsString;
  end;
  Lookuptable.Filtered := false;
end;

procedure TJobGUI.cboEmpDropDown(Sender: TObject);
var
  EmpIds: string;
  Qry: TERPQuery;
begin
  {set the filter to remove the already selected employees}
  inherited;
  EmpIds := '';
  Qry := TERPQuery.Create(nil);
  try
    //Qry.Clone(qryJobcards);
    CloneDataSet(qryJobcards, Qry);
    with Qry do begin
      First;
      while Eof = false do begin
        if FieldByName('Id').AsInteger <> qryJobcards.FieldByName('Id').AsInteger then begin
          if EmpIds <> '' then EmpIds := EmpIds + ' and ';
          EmpIds := EmpIds + ' EmployeeId <> ' + FieldByName('EmployeeId').AsString;
        end;
        Next;
      end;
      Close;
    end;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
  if EmpIds <> '' then begin
    qryEmpLookup.Filtered := false;
    qryEmpLookup.Filter   := empIds;
    qryEmpLookup.Filtered := true;
  end;
end;

procedure TJobGUI.qryJobcardsBeforePost(DataSet: TDataSet);
begin
  inherited;
  {employee name should not be blank }
  if Dataset.FieldByName('EmployeeId').AsInteger = 0 then begin
    CommonLib.MessageDlgXP_Vista('Employee name should not be blank ', mtWarning, [mbOK], 0);
    Abort;
  end;
end;

procedure TJobGUI.QryJobcontactsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryJobcontacts.ParamByName('CusID').AsInteger := qryJobClientID.AsInteger;
end;

procedure TJobGUI.grdEmpIButtonClick(Sender: TObject);
begin
  inherited;
  {exit when the tbale is blank }
  if (QryJobCards.Eof = true) and (QryJobCards.State <> dsInsert) then Exit;

  if CommonLib.MessageDlgXP_Vista('Do you wish to delete this employee from the job? ', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  if QryJobCards.Eof = false then qryJobCards.Delete
  else if QryJobCards.State = dsInsert then QryJobCards.Cancel;
end;

procedure TJobGUI.cboTemplateCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if not (qryJobcards.State in [dsEdit, dsInsert]) then qryJobcards.Edit;
  qryJobcards.FieldByName('TemplateId').AsInteger := qryTemplate.FieldByName('TemplID').AsInteger;
  qryJobcards.FieldByName('TemplateName').AsString := qryTemplate.FieldByName('TemplName').AsString;
end;

procedure TJobGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  qryJobTermsId.asInteger := qryTerms.FieldByname('TermsID').asInteger
end;

procedure TJobGUI.CheckForEmails;
var
  MailReader: TMailReader;
  MailConfig: TEmailConfig;
  msg: string;
begin
  MailReader := TMailReader.Create;
  MailConfig := TEmailConfig.Create(nil);
  try
    MailReader.Connection := TERPConnection(qryDocuments.Connection);
    MailConfig.Connection := TMyDacDataConnection.Create(MailConfig);
    MailConfig.Connection.Connection := qryDocuments.Connection;
    MailConfig.LoadSelect('EntityName = ' + QuotedStr(AppEnv.Employee.EmployeeName));
    if (MailConfig.Count > 0) then begin
      if MailConfig.ConfigValid then begin
        MailReader.Config.AsString := MailConfig.ConfigJSON;
        MailReader.EmailAddress := MailConfig.EmailAddress;
        MailReader.OnProgress := DoOnCheckForEmailsProgress;
        MailReader.OnGetMessageCount := DoOnGetMessageCount;
        try
          if MailReader.GetMail(msg) then begin

          end
          else begin

          end;

        finally
          //DoHideProgressBar;
          if Assigned(MailProgesss) then begin
            MailProgesss.CloseDialog;
            FreeAndNil(MailProgesss);
          end;
        end;
      end;
    end;
  finally
    MailReader.Free;
    MailConfig.Free;
  end;
  CloseDb(qryDocuments);
  OpenDb(qryDocuments);
end;

procedure TJobGUI.qryJobcardsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.FieldByName('ClientId').AsInteger := qryJob.FieldByName('clientId').AsInteger;
end;
function TJobGUI.SaveOrCancelChanges: boolean;
var iExitResult:integer;
begin
  REsult := True;
  iExitResult:=CommonLib.MessageDlgXP_Vista('Do you wish to Save changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if iExitResult = mrYes then begin
    Result:= VerifyAndSave ;
    if result then Notify(False);
  end else if iExitResult = mrNo then begin
    Result:=  true;
    RollbackTransaction;
    Notify(True);
  end else if iExitResult = mrCancel then begin
    Result := false;
  end;
end;
procedure TJobGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if (MyConnection.Connected and MyConnection.intransaction) or
    (MyConnection.Connected and MyConnection.InTransaction) then begin
    if DataState.IsActive and DataState.Dirty then begin
      canclose:= SaveOrCancelChanges;
    end else begin
      CanClose:= true;
      RollbackTransaction;
      Notify(false);
    end;
  end;
end;

procedure TJobGUI.btnContactsClick(Sender: TObject);
begin
  inherited;
  if not (QryJob.State in [dsEdit, dsInsert]) then QryJob.Edit;
  qryJob.FieldByName('ParentClientID').AsInteger := iParentID;
end;

procedure TJobGUI.btnCopyReturnAddressClick(Sender: TObject);
begin
  inherited;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Company.AsString   := Appenv.CompanyInfo.CompanyName;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Name.AsString      := Appenv.CompanyInfo.CompanyName;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Street1.AsString   := Appenv.CompanyInfo.Address;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Street2.AsString   := Appenv.CompanyInfo.Address2;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Street3.AsString   := Appenv.CompanyInfo.Address3;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Suburb.AsString    := Appenv.CompanyInfo.City;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_State.AsString     := Appenv.CompanyInfo.State;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Country.AsString   := Appenv.CompanyInfo.Country;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Postcode.AsString  := Appenv.CompanyInfo.Postcode;
end;

procedure TJobGUI.btnCopySpecialPricesClick(Sender: TObject);
begin
  inherited;
  if qrySpecials.RecordCount > 0 then begin
    self.CopySpecialPricesToOtherCustomers;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('There are are no Special Products to copy.',mtInformation,[mbOk],0);
  end;

end;
procedure TJobGUI.CopycontactsFromCustomer(CopyAnyway:Boolean);
var
  Qry :TERPQuery;
begin
        Closedb(QryJobcontacts);
        OpenDB(QryJobcontacts);
      if not CopyAnyway then begin
        if (QryJobcontacts.recordcount >0) or (KeyID <> 0) then exit;
        if not bIsNewJob then exit;
      end;
      Qry := DbSharedObj.GetQuery(qryJob.connection);
      try
          With Qry do begin
            if Active then close;
            SQL.Text := QryJobcontacts.SQL.Text;
            ParamByName('CusID').AsInteger :=  iParentID;
            open;
            if recordcount > 0 then begin
              if not(CopyAnyway) then
                if MessageDlgXP_Vista('Do You Wish to Copy All the Contacts of the Customer?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
              first;
              While Eof = False do begin
                if QryJobcontacts.Locate('Company;clientName' , vararrayof([fieldbyname('Company').asString,QryjobCompany.asString]), []) = False then begin
                  try
                    QryJobcontacts.Append;
                    QryJobcontactsClientID.asInteger := qryJobClientID.AsInteger;
                    QryJobcontactsClientName.ASString := QryjobCompany.asString;
                    QryJobcontactsCompany.ASString := FieldByname('Company').asSTring;
                    QryJobcontactsContactTitle.ASString := FieldByname('ContactTitle').asSTring;
                    QryJobcontactsContactFirstName.ASString := FieldByname('ContactFirstName').asSTring;
                    QryJobcontactsContactSurName.ASString := FieldByname('ContactSurName').asSTring;
                    QryJobcontactsContactAddress.ASString := FieldByname('ContactAddress').asSTring;
                    QryJobcontactsContactAddress2.ASString := FieldByname('ContactAddress2').asSTring;
                    QryJobcontactsContactAddress3.ASString := FieldByname('ContactAddress3').asSTring;
                    QryJobcontactsContactCity.ASString := FieldByname('ContactCity').asSTring;
                    QryJobcontactsContactState.ASString := FieldByname('ContactState').asSTring;
                    QryJobcontactsContactPcode.ASString := FieldByname('ContactPcode').asSTring;
                    QryJobcontactsContactCountry.ASString := FieldByname('ContactCountry').asSTring;
                    QryJobcontactsContactPH.ASString := FieldByname('ContactPH').asSTring;
                    QryJobcontactsContactAltPH.ASString := FieldByname('ContactAltPH').asSTring;
                    QryJobcontactsContactMOB.ASString := FieldByname('ContactMOB').asSTring;
                    QryJobcontactsContactFax.ASString := FieldByname('ContactFax').asSTring;
                    QryJobcontactsContactEmail.ASString := FieldByname('ContactEmail').asSTring;
                    QryJobcontactsNotes.ASString := FieldByname('Notes').asSTring;
                    QryJobcontactsActive.ASString := FieldByname('Active').asSTring;
                    QryJobcontactsCardNumber.ASString := FieldByname('CardNumber').asSTring;
                    QryJobcontactsAccountNo.ASString := FieldByname('AccountNo').asSTring;
                    QryJobcontactsJobTitle.ASString := FieldByname('JobTitle').asSTring;
                    QryJobcontactsUseOnRun.ASString := FieldByname('UseOnRun').asSTring;
                    QryJobcontactsLogMeInComputerIPAddress.ASString := FieldByname('LogMeInComputerIPAddress').asSTring;
                    QryJobcontactsLogMeInEmailPassword.ASString := FieldByname('LogMeInEmailPassword').asSTring;
                    QryJobcontactsLogMeInUserName.ASString := FieldByname('LogMeInUserName').asSTring;
                    QryJobcontactsLogMeInPassword.ASString := FieldByname('LogMeInPassword').asSTring;
                    QryJobcontactsLogMeInERPUserName.ASString := FieldByname('LogMeInERPUserName').asSTring;
                    QryJobcontactsLogMeInERPPassword.ASString := FieldByname('LogMeInERPPassword').asSTring;
                    QryJobcontactsLogMeIncomputerPassword.ASString := FieldByname('LogMeIncomputerPassword').asSTring;
                    QryJobcontactsIsPrimarycontact.ASString := FieldByname('IsPrimarycontact').asSTring;
                    QryJobcontactsMainContactforCashSale.ASString := FieldByname('MainContactforCashSale').asSTring;
                    QryJobcontactsMainContactforVoucher.ASString := FieldByname('MainContactforVoucher').asSTring;
                    QryJobcontactsMainContactforPOS.ASString := FieldByname('MainContactforPOS').asSTring;
                    QryJobcontactsMainContactforRefund.ASString := FieldByname('MainContactforRefund').asSTring;
                    QryJobcontactsMainContactforInvoice.ASString := FieldByname('MainContactforInvoice').asSTring;
                    QryJobcontactsMainContactforSalesOrder.ASString := FieldByname('MainContactforSalesOrder').asSTring;
                    QryJobcontactsMainContactforQuote.ASString := FieldByname('MainContactforQuote').asSTring;
                    QryJobcontactsMainContactforCheque.ASString := FieldByname('MainContactforCheque').asSTring;
                    QryJobcontactsMainContactforCredit.ASString := FieldByname('MainContactforCredit').asSTring;
                    QryJobcontactsMainContactforBill.ASString := FieldByname('MainContactforBill').asSTring;
                    QryJobcontactsMainContactforPO.ASString := FieldByname('MainContactforPO').asSTring;
                    QryJobcontactsMainContactforRA.ASString := FieldByname('MainContactforRA').asSTring;
                    QryJobcontactsMainContactforRepair.ASString := FieldByname('MainContactforRepair').asSTring;
                    QryJobcontactsMainContactforStatements.ASString := FieldByname('MainContactforStatements').asSTring;
                    QryJobcontactsMainContactforSupplierPayment.ASString := FieldByname('MainContactforSupplierPayment').asSTring;
                    QryJobcontactsNotaMainContact.ASString := FieldByname('NotaMainContact').asSTring;
                    QryJobcontactsDoNotContact.ASString := FieldByname('DoNotContact').asSTring;
                    QryJobcontactsTeamviewerID.ASString := FieldByname('TeamviewerID').asSTring;
                    PostDb(QryJobcontacts);
                  Except
                    // handle the exception if its a duplicate contact
                  end;
                end;

                Next;
              end;
            end;
          end;
          Closedb(qryContacts);
          OpenDB(qryContacts);
      finally
        DbSharedObj.ReleaseObj(Qry);
      end;
end;

procedure TJobGUI.CopySpecialPricesToOtherCustomers;
begin
 if OpenERPListFormultiselect('TCustomerExpressListGUI',DoCustomerListBeforeShow, false) then begin
 end;
end;
procedure TJobGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  SetControlFocus(grdSpecials);
  qrySpecials.Last;
  qrySpecials.Append;
end;

procedure TJobGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  OpenCustomFields;
end;

procedure TJobGUI.DoCustomerListBeforeShow(Sender: TObject);
begin
  TBaseListingGUI(Sender).OnGridDataSelect := CustomerGridDataSelect;
  TBaseListingGUI(Sender).FilterString := 'CompanyName <> "' + self.qryJobCompany.AsString + '"';
end;

procedure TJobGUI.CustomerGridDataSelect(Sender: TwwDbGrid);
var
  cmd: TMyCommand;
  i, x: integer;
  idList: TIntegerList;
begin
  if Sender.SelectedList.Count > 0 then begin
    cmd := TERPCommand.Create(nil);
    idList := TIntegerList.Create;
    try
      cmd.Connection := self.MyConnection;
      Sender.DataSource.DataSet.DisableControls;
      try
        for i := 0 to Sender.SelectedList.Count - 1 do begin
          idList.Add(Sender.DataSource.DataSet.FieldByName('ClientID').AsInteger);
          Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList.Items[i]);
        end;
      finally
        Sender.DataSource.DataSet.EnableControls;
      end;
      for i := 0 to idList.Count -1 do begin
        if not UserLock.Lock(GetMainTablename, idLIst[i], Self.Caption) then begin
          CommonLib.MessageDlgXP_Vista('Can not update customer ' + TClient.IDToggle(idLIst[i]) +
            '.' + #13#10 + #13#10 +  UserLock.LockMessage + #13#10 + #13#10 + 'All copying cancelld.',mtInformation,[mbOk],0);
          for x := i downto 0 do begin
            UserLock.UnLock(GetMainTablename,idList[x],Self.Caption);
            exit;
          end;
        end;
      end;
      for i := 0 to idList.Count -1 do begin
        cmd.SQL.Clear;
        cmd.SQL.Add('insert ignore into tblcustomerlines (CustomerId,ProductID,Name,Description,OrigPrice,LinePrice)');
        cmd.SQL.Add('select ' + IntToStr(idList[i]) + ' as ClientId,');
        cmd.SQL.Add('ProductID,Name,Description,OrigPrice,LinePrice');
        cmd.SQL.Add('from tblcustomerlines where CustomerID = ' + IntToStr(self.qryJobClientID.AsInteger));
        cmd.Execute;
        cmd.SQL.Clear;
        cmd.SQL.Add('update tblcustomerlines set GlobalRef = Concat("'  + AppEnv.Branch.SiteCode + '",CustomerLinesID)');
        cmd.SQL.Add('where CustomerID = ' + IntToStr(idList[i]));
        cmd.SQL.Add('and IsNull(GlobalRef)');
        cmd.Execute;
        cmd.SQL.Clear;
        cmd.SQL.Add('update tblcustomerlines set');
        cmd.SQL.Add('msUpdateSiteCode = "' + AppEnv.Branch.SiteCode + '"');
        cmd.SQL.Add('where CustomerID = ' + IntToStr(idList[i]));
        cmd.Execute;
      end;
      CommonLib.MessageDlgXP_Vista('Special Prices have beem copied to ' + IntToStr(idList.Count) + ' Customer(s).',mtInformation,[mbOk],0);
    finally
      cmd.Free;
      idList.Free;
    end;


  end;

end;

procedure TJobGUI.cboCustomerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  pgeControl.ActivePage := tabMain;
  SetControlFocus(edtJobName);
  SetClientToJob;
end;

procedure TJobGUI.SetClientToJob;
begin
  // job information
  qryJobFirstName.AsString := qryCustomerFirstName.AsString;
  qryJobLastName.AsString := qryCustomerLastName.AsString;
  qryJobClientTypeID.AsInteger := qryCustomerClientTypeID.AsInteger;
  qryJobPhone.AsString := qryCustomerPhone.AsString;
  qryJobFaxNumber.AsString := qryCustomerFaxNumber.AsString;
  qryJobAltPhone.AsString := qryCustomerAltPhone.AsString;

  // physical address
  qryJobStreet.AsString := qryCustomerStreet.AsString;
  qryJobStreet2.AsString := qryCustomerStreet2.AsString;
  qryJobSuburb.AsString := qryCustomerSuburb.AsString;
  qryJobState.AsString := qryCustomerState.AsString;
  qryJobPostcode.AsString := qryCustomerPostcode.AsString;
  qryJobCountry.AsString := qryCustomerCountry.AsString;

  // bill to
  qryJobBillStreet.AsString := qryCustomerBillStreet.AsString;
  qryJobBillStreet2.AsString := qryCustomerBillStreet2.AsString;
  qryJobBillSuburb.AsString := qryCustomerBillSuburb.AsString;
  qryJobBillState.AsString := qryCustomerBillState.AsString;
  qryJobBillPostcode.AsString := qryCustomerBillPostcode.AsString;
  qryJobBillCountry.AsString := qryCustomerBillCountry.AsString;

  // general
  qryJobEmail.AsString := qryCustomerEmail.AsString;
end;

procedure TJobGUI.cboManufactureNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Accept := false;
    Exit;
  end;
  if TManufacture.NewManufacture(NewValue, MyConnection) then begin
    EditDb(cboManufacture.datasource.Dataset);
    TERPQuery(cboManufacture.datasource.Dataset).FieldByName('Manufacture').AsString := NewValue;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Error adding new value.', mtWarning, [mbOk], 0);
    Accept := false;
  end;
end;

procedure TJobGUI.cboModelNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
var
  msg: string;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Accept := false;
    Exit;
  end;
  if TModel.AddNewModel(NewValue,msg,MyConnection) then begin
    EditDb(cboModel.datasource.Dataset);
    TERPQuery(cboModel.datasource.Dataset).FieldByName('ModelNumber').AsString := NewValue;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Error: ' + msg, mtWarning, [mbOk], 0);
    Accept := false;
  end;
end;

procedure TJobGUI.cboProdChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;
procedure TJobGUI.cboProdCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  AssignComboAccessed(Sender);
  inherited;
end;

procedure TJobGUI.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQry.IndexFieldNames := QuotedStr('PARTNAME') + ' ASC CIS';
end;

procedure TJobGUI.AssignComboAccessed(Sender: TObject);
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TJobGUI.UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);
begin
  inherited;
  if qryContacts.Active then begin
    qryContacts.Refresh;
  end;
  if not (qryJob.State in [dsEdit, dsInsert]) then
    EditDB(qryJob);
  qryJobLastUpdated.AsDateTime := Now;
  if Assigned(aObject) then begin
    if aObject.ClassNameIs('TfmCustomerCorrespondenceCreate') then begin
      CloseDb(qryDocuments);
      OpenDb(qryDocuments);
    end else if (aObject.Classname = 'TfrmContact') then begin
      if TfrmContact(aObject).Contact.IsPrimaryContact then begin
        PostDb(qryJob);
        qryJob.Refresh;
        EditDb(qryJob);
      end;
      if qryContacts.Active then begin
        qryContacts.Refresh;
      end;
    end else if Assigned(fLastComboAccessed) and Sysutils.SameText(fLastComboAccessed.Name, 'cboProd') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('PartsId', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qrySpecials);
          qrySpecialsProductID.AsInteger := LookupTable.FieldByName('PartsID').AsInteger;
          cboProdCloseUp(fLastComboAccessed, LookupTable, qrySpecials, true);
        end;

    end
  end;
end;

procedure TJobGUI.btnAppointmentClick(Sender: TObject);
var
  CustomerStr: string;
  NewAppointment: TComponent;
  MsgObj: TMsgObj;
begin
  MsgObj := TMsgObj.Create;
  Try
    MsgObj.SetAddress('TAppointmentGUI', 'CloseIfOpen');
    if fMsgHandler.Send(MsgObj, MsgObj) then begin
      Exit;
    end;
  Finally
    FreeAndNil(MsgObj);
  End;

  MsgObj := TMsgObj.Create;
  Try
    MsgObj.SetAddress('TCalendarGUI', 'IsPlacingAppointment');
    if fMsgHandler.Send(MsgObj, MsgObj) then begin
      CommonLib.MessageDlgXP_Vista('The last appointment has not been made. Please make it now.', mtInformation, [mbOK], 0);
      Exit;
    end;
  Finally
    FreeAndNil(MsgObj);
  End;

  inherited;
  CustomerStr := '';
  if not qryCustomer.IsEmpty then begin
    CustomerStr := 'With:';

    if qryCustomer.FieldByName('Title').AsString <> '' then CustomerStr :=
        CustomerStr + ' ' + qryCustomer.FieldByName('Title').AsString;
    if qryCustomer.FieldByName('FirstName').AsString <> '' then CustomerStr :=
        CustomerStr + ' ' + qryCustomer.FieldByName('FirstName').AsString;
    if qryCustomer.FieldByName('LastName').AsString <> '' then CustomerStr :=
        CustomerStr + ' ' + qryCustomer.FieldByName('LastName').AsString;
    if qryCustomer.FieldByName('Position').AsString <> '' then CustomerStr :=
        CustomerStr + 'Pos: ' + qryCustomer.FieldByName('Position').AsString;
    if qryCustomer.FieldByName('Phone').AsString <> '' then CustomerStr :=
        CustomerStr + 'Ph: ' + qryCustomer.FieldByName('Phone').AsString;
    if qryCustomer.FieldByName('Mobile').AsString <> '' then CustomerStr :=
        CustomerStr + 'Mbl: ' + qryCustomer.FieldByName('Mobile').AsString;
    if qryCustomer.FieldByName('Email').AsString <> '' then CustomerStr :=
        CustomerStr + 'Email: ' + qryCustomer.FieldByName('Email').AsString;
  end;

  if edtNotes.Text <> '' then begin
    if CustomerStr <> '' then CustomerStr := CustomerStr + #13#10;

    CustomerStr := CustomerStr + edtNotes.Text;
  end;

  NewAppointment := GetComponentByClassName('TNewAppointment', False);
  NewAppointment.Name := GetUniqueName(NewAppointment.ClassName);
  if Assigned(NewAppointment) then begin
    MsgObj := TMsgObj.Create;
    MsgObj.SetAddress('TNewAppointment', 'ClientID', NewAppointment.Name);
    MsgObj.IntValue := iClientID;
    fMsgHandler.Send(MsgObj, MsgObj);
    MsgObj.MethodStr := 'ActiveControl';
    MsgObj.StrValue := 'cboEmployee';
    fMsgHandler.Send(MsgObj, MsgObj);
    if CustomerStr <> '' then begin
      MsgObj.MethodStr := 'Note';
      MsgObj.StrValue := CustomerStr;
      fMsgHandler.Send(MsgObj, MsgObj);
    end;
    MsgObj.MethodStr := 'CreateNewAppointment';
    MsgObj.BoolValue := False; //appointment not required
    fMsgHandler.Send(MsgObj);
    {MsgObj FreeandNil in Calender}
  end;
end;

procedure TJobGUI.qrySpecialsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qrySpecialsCustomerId.AsInteger := KeyID;

end;

procedure TJobGUI.qrySpecialsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qrySpecials, memqrySpecials);

end;

procedure TJobGUI.qrySpecialsAfterPost(DataSet: TDataSet);
var
  SavedAccessLevel: integer;
begin
  inherited;
    if (qrySpecialsOrigPrice.asFloat=0) and
       (qrySpecialsLinePrice.asFloat=0) and
       (qrySpecialsProductID.asInteger=0) then begin
      SavedAccessLevel:= AccessLevel;
      try
        AccessLevel:= 1;
        qrySpecials.Delete;
      finally
        AccessLevel:= SavedAccessLevel;
      end;
    end;
end;

procedure TJobGUI.qrySpecialsNameChange(Sender: TField);
begin
  inherited;
  if not((screen.activecontrol = cboProd) or (Screen.activecontrol = grdSpecials)) then exit;
  if cboProductQry.Locate('PARTNAME' ,qrySpecialsName.asString , []) then begin
    qrySpecialsProductID.AsInteger  := cboProductQry.fieldbyname('PartsID').AsInteger;
    qrySpecialsDescription.AsString := cboProductQry.fieldbyname('PartsDescription').AsString;
    qrySpecialsOrigPrice.AsCurrency := cboProductQry.fieldbyname('Price1').AsCurrency;
    qrySpecialsLinePrice.AsCurrency := cboProductQry.fieldbyname('Price1').AsCurrency;
  end;
end;

procedure TJobGUI.qrySuburbBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TJobGUI.qryTaxCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxCodes.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TJobGUI.qryCarePlanBeforePost(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('ClientID').AsInteger := qryJobClientID.AsInteger;
end;

procedure TJobGUI.Qryclients_eParcelAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Qryclients_eParcelclientId.asInteger := QryjobclientID.asInteger;
end;

procedure TJobGUI.wwDBLookupCombo1CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  AssignComboAccessed(Sender);
  if not Modified then Exit;
  inherited;
  Qryclients_eParcelReturn_State.AsString := LookupTable.FieldByName('State').AsString;
  Qryclients_eParcelReturn_Postcode.AsString := LookupTable.FieldByName('Postcode').AsString;
  Qryclients_eParcelReturn_Country.asString := LookupTable.FieldByName('Country').asString;
end;

procedure TJobGUI.wwDBLookupCombo2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  AssignComboAccessed(Sender);
  if not Modified then Exit;
  inherited;
  Qryclients_eParcelRedir_State.AsString := LookupTable.FieldByName('State').AsString;
  Qryclients_eParcelRedir_Postcode.AsString := LookupTable.FieldByName('Postcode').AsString;
  Qryclients_eParcelReDir_Country.asString := LookupTable.FieldByName('Country').asString;
end;

procedure TJobGUI.wwIButton1Click(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryCarePlan);
end;


procedure TJobGUI.chkActiveClick(Sender: TObject);
begin
  inherited;

  if (not chkActive.Checked) and (RoundCurrency(qryJob.FieldByName('Balance').AsFloat) <> 0.00) then begin
    qryJob.FieldByName('Active').AsString := 'T';
    CommonLib.MessageDlgXP_Vista('This Job Can''t Be Made Inactive' + #13#10#13#10 +
               'There Is a Balance Outstanding !', mtWarning, [mbOK], 0);
  end;
end;

procedure TJobGUI.AppointmentClosed(MsgObj: TMsgObj);
begin
  FreeAndNil(MsgObj);
  btnAppointmentClick(Self);
end;

procedure TJobGUI.Callcontactform(Sender: TDNMSpeedbutton);
Var
  Form : TComponent;
begin
  inherited;
  PostDB(qryJob);
  Form := GetComponentByClassName('TfrmContact');
  if Assigned(Form) then begin
    with TfrmContact(Form) do begin
      AttachObserver(self);
      if sender = EditBtn then
        KeyID := self.qryContacts.FieldByName('ContactID').AsInteger
      else KeyID := 0;
      ClientID := qryJob.FieldByName('Clientid').asInteger;
      ClientName:= qryJobCompany.asString;
      PassedConnection := Self.MyConnection;
      Showmodal;
    end;
  end;

end;

procedure TJobGUI.UpdatefromEquipment;
begin
  EditDB(qryJob);
  qryJob.FieldByName('LastUpdated').AsDateTime := Now;
end;

procedure TJobGUI.newEquip(const Value: String);
begin
  pgeControl.ActivePage:= tabEquip;
  pgeControlChange(pgeControl);
  Equipmentform.NewEquip(Value);
end;

procedure TJobGUI.newRego(const Value: String);
begin
  pgeControl.ActivePage:= tabEquip;
  pgeControlChange(pgeControl);
  Equipmentform.newRego(Value);
end;

procedure TJobGUI.qryJobAfterInsert(DataSet: TDataSet);
begin
  inherited;
  fbclientnameMadeFromName := False;
  qryJobClientTypeID.asInteger := DefaultclientTypeId;
  qryJobDocumentPath.AsString := Appenv.DocPath.DocumentPath;
end;
Function TJobGUI.ListBilljobs: TBaseListingGUI;
begin
  CreateHistorylistform('TBillDetailsListGUI' ,Self, fListbilljobs,'CustomerJobID', IntToStr(KeyID), InitListofHistoryforms);
  result := fListbilljobs;
end;


function TJobGUI.ListAppoints: TBaseListingGUI;
begin
  CreateHistorylistform('TAppointmentListGUI' ,Self, fListAppoints,'ClientID', IntToStr(KeyID) , InitListofHistoryforms);
  result := fListAppoints;
end;

function TJobGUI.SalesOrderList: TBaseListingGUI;
begin
  CreateHistorylistform('TSalesOrderListGUI' ,Self, fSalesOrderList,'ClientID  ' , IntToStr(KeyID) , InitListofHistoryforms);
  result := fSalesOrderList;
end;

function TJobGUI.ListInvoices: TBaseListingGUI;
begin
  CreateHistorylistform('TInvoiceListGUI' ,Self, fListInvoices,'ClientID  ' , IntToStr(KeyID) , InitListofHistoryforms);
  result := fListInvoices;

end;
function TJobGUI.ListRepairs: TBaseListingGUI;
begin
  (*CreateHistorylistform('TRepairsList' ,Self, fListRepairs,'ClientID  ' , IntToStr(KeyID) , InitListofHistoryforms);
  result := fListRepairs;*)
  CreateHistorylistform('TRepairsList' ,Self, fListRepairs);
  result := fListRepairs;
  TRepairsList(fListRepairs).clientID := Self.KeyId;
end;

function TJobGUI.ListJobprofit: TBaseListingGUI;
begin
  CreateHistorylistform('TJobProfitabilityforCustomerGUI' ,Self, fListJobprofit,'ClientID  ' , IntToStr(KeyID) , InitListofHistoryforms);
  result := fListJobprofit;

end;

function TJobGUI.ListProductSales: TBaseListingGUI;
begin
  CreateHistorylistform('TCustomerSalesOnProductListGUI' ,Self, fListProductSales , '' , '' , InitListofHistoryforms);
  result := fListProductSales;
  TCustomerSalesOnProductListGUI(fListProductSales).lblCustomer.Caption := GetClientName(KeyId);
  TCustomerSalesOnProductListGUI(fListProductSales).fiClientID := KeyId;
  TCustomerSalesOnProductListGUI(fListProductSales).fiProductID := 0;
end;

function TJobGUI.ListQuotes: TBaseListingGUI;
begin
  CreateHistorylistform('TQuoteListGUI' ,Self, fListQuotes,'ClientID  ' , IntToStr(KeyID) , InitListofHistoryforms);
  result := fListQuotes;

end;

function TJobGUI.TimesheetList: TBaseListingGUI;
begin
  CreateHistorylistform('TfrmPayTimesheet' ,Self, fTimesheetList,'jobid ' , IntToStr(KeyID) , InitListofHistoryforms);
  result := fTimesheetList;
end;

function TJobGUI.PayJobList: TBaseListingGUI;
begin
  CreateHistorylistform('TPayJobListGUI' ,Self, fPayJobList,'ClientId ' , IntToStr(KeyID) , InitListofHistoryforms);
  result := fPayJobList;

end;
procedure TJobGUI.InitListofHistoryforms(Sender: TObject);
begin

      if Sender.ClassnameIs('TBillDetailsListGUI')              then TBaseListingGUI(Sender).FilterString := 'CustomerJobID=' + IntToStr(KeyID)
   else if Sender.ClassnameIs('TAppointmentListGUI')              then TBaseListingGUI(Sender).FilterString := 'ClientID=' + IntToStr(KeyID)
   else if Sender.ClassnameIs('TSalesOrderListGUI')               then TBaseListingGUI(Sender).FilterString := 'ClientID  =' +  IntToStr(KeyID)
   else if Sender.ClassnameIs('TInvoiceListGUI')                  then TBaseListingGUI(Sender).FilterString := 'ClientID  =' + IntToStr(KeyID)
   else if Sender.ClassnameIs('TJobProfitabilityforCustomerGUI')  then TJobProfitabilityforCustomerGUI(Sender).ClientID := KeyID //TBaseListingGUI(Sender).FilterString := 'ClientID  =' + IntToStr(KeyID)
   else if Sender.ClassnameIs('TQuoteListGUI')                    then TBaseListingGUI(Sender).FilterString := 'ClientID  =' + IntToStr(KeyID)
   else if Sender.ClassnameIs('TfrmPayTimesheet')                 then TBaseListingGUI(Sender).FilterString := 'jobid =' + IntToStr(KeyID)
   else if Sender.ClassnameIs('TPayJobListGUI')                   then TBaseListingGUI(Sender).FilterString := 'ClientId =' +  IntToStr(KeyID)
   else if Sender.ClassNameIs('TPurchaseOrderListGUI')            then TBaseListingGui(Sender).FilterString := 'ClientId=' + IntToStr(KeyId)

   else if Sender.ClassnameIs('TCustomerSalesOnProductListGUI') then begin
        TCustomerSalesOnProductListGUI(fListProductSales).lblCustomer.Caption := GetClientName(KeyId);
        TCustomerSalesOnProductListGUI(fListProductSales).fiClientID := KeyId;
        TCustomerSalesOnProductListGUI(fListProductSales).fiProductID := 0;
   end;
end;
procedure TJobGUI.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;
  if UserLock.Enabled and (AccessLevel < 5) then begin
    // remove all existing locks
    UserLock.UnlockAllCurrentInstance;

    if (KeyId > 0) then begin
      if not UserLock.Lock('tblClients', KeyId, Self.Caption) then begin
        AccessLevel := 5; // read only

        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);
      end;
    end;
  end;
  //Freeandnil(fShipAddressList);
end;

procedure TJobGUI.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if pgeControl.ActivePage = TTabSheet(tabHistory) then begin
    case grpHistory.ItemIndex of
      0 : if assigned(fListAppoints)        then fListAppoints.OnKeyUp(fListAppoints,Key,Shift);
      1 : if assigned(fSalesOrderList)      then fSalesOrderList.OnKeyUp(fSalesOrderList,Key,Shift);
      2 : if assigned(fListQuotes)          then fListQuotes.OnKeyUp(fListQuotes,Key,Shift);
      3 : if assigned(fListInvoices)        then fListInvoices.OnKeyUp(fListInvoices,Key,Shift);
      4 : if assigned(fListRepairs)         then fListRepairs.OnKeyUp(fListRepairs,Key,Shift);
      5 : if assigned(fListJobprofit)       then fListJobprofit.OnKeyUp(fListJobprofit,Key,Shift);
      6 : if assigned(fPayJobList)          then fPayJobList.OnKeyUp(fPayJobList,Key,Shift);
      7 : if assigned(fTimesheetList)       then fTimesheetList.OnKeyUp(fTimesheetList,Key,Shift);
      8 : if assigned(fListProductSales)    then fListProductSales.OnKeyUp(fListProductSales,Key,Shift);
      9 : if assigned(fListbilljobs)        then fListbilljobs.OnKeyUp(fListbilljobs,Key,Shift);
      10: if assigned(fPOList)              then fPOList.OnKeyUp(fPOList, Key, Shift);

    end;
  end;
end;

procedure TJobGUI.AfterPopupformshow;
begin
  inherited;
  if Sysutils.SameText(CallingClassName , 'TContactListGUI') or
    Sysutils.SameText(CallingClassName , 'TGlobalsearchGUI')  then
    pgeControl.Activepage := tabContacts;

end;
procedure TJobGUI.qryJobCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryJobcDocumentPath.AsString  := cDocumentPath(qryJob);
end;
procedure TJobGUI.btnSetDocumentPathClick(Sender: TObject);
begin
  inherited;
  SetDocPath(qryJob);
end;
procedure TJobGUI.btnOpenDocumentPathClick(Sender: TObject);
begin
  inherited;
   OpenDocPath(qryJob);
end;
initialization
  RegisterClassOnce(TJobGUI);

  with FormFact do begin
    RegisterMe(TJobGUI, 'TQuoteListGUI_Customer Name_Job=ClientID');
    RegisterMe(TJobGUI, 'TQuoteListGUI_FundingBody_Job=FundingBodyId');
    RegisterMe(TJobGUI, 'TCustomerListGUI_*_T=ClientID');
    RegisterMe(TJobGUI, 'TCustlistWithDetailsGUI_*_T=ClientID');
    RegisterMe(TJobGUI, 'TCustomerExpressListGUI_*_T=ClientID');
    RegisterMe(TJobGUI, 'TfrmPayTimesheet=JobID');
    RegisterMe(TJobGUI, 'TfrmPaySummary_Job=JobID');
    RegisterMe(TJobGUI, 'TGlobalListFrm_*_Job=ID');
    RegisterMe(TJobGUI, 'TGlobalListFrm_*_Job(Contact)=ID');
    (*RegisterMe(TJobGUI, 'TRemindersListGUI_*_FollowUpJ=ClientID');*)
    RegisterMe(TJobGUI, 'TReminderListGUI_*_FollowUpJ=ClientID');
    (*RegisterMe(TJobGUI, 'TRemindersListGUI_Client_AppointmentJob=ClientID');*)
    RegisterMe(TJobGUI, 'TReminderListGUI_Client_AppointmentJob=ClientID');
    RegisterMe(TJobGUI, 'TCustomerNotesReportGUI_*_T=ClientID');
    RegisterMe(TJobGUI, 'TSalescommissionListGUI_Company_Job=ClientID');
    RegisterMe(TJobGUI, 'TSalescommissionListGUI_Job Number_Job=ClientID');
    RegisterMe(TJobGUI, 'TSalescommissionListGUI_Job Name_Job=ClientID');
    RegisterMe(TJobGUI, 'TfrmCustomerJobFollowupList_*_Job=ClientID');
    RegisterMe(TJobGUI, 'TJobListGUI_*_T=ClientID');
    RegisterMe(TJobGUI, 'TAppointmentListGUI_Company_Job=ClientID');
    (*RegisterMe(TJobGUI, 'TMarketingLeadsGUI_Company_CustomerJob=ClientID');*)
    RegisterMe(TJobGUI, 'TCustomFieldValuesListLeadsGUI_Company_CustomerJob=ClientID');
    RegisterMe(TJobGUI, 'TGlobalsearchGUI_*_Job=ClientID');
    RegisterMe(TJobGUI, 'TGlobalsearchGUI_*_Job(Contact)=ClientID');
    RegisterMe(TJobGUI, 'TGlobalListSearchFrm_*_Job(Contact)=ID');
    RegisterMe(TJobGUI, 'TGlobalListSearchFrm_*_Job(Primary Contact)=ID');
    RegisterMe(TJobGUI, 'TGlobalListSearchFrm_*_Job=ID');
    RegisterMe(TJobGUI, 'TGlobalListFrm_*_Job(Contact)=ID');
    RegisterMe(TJobGUI, 'TGlobalListFrm_*_Job=ID');
    RegisterMe(TJobGUI, 'TClientListGUI_*_Job=ClientID');
    RegisterMe(TJobGUI, 'TContactListGUI_*_Job=ClientID');
    RegisterMe(TJobGUI, 'TClientMainContactsGUI_*_Job=ClientID');
    RegisterMe(TJobGUI, 'TCustomFieldValuesListContactGUI_*_Job=ClientId');
  end;
end.

