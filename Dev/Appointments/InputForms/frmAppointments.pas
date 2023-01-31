unit frmAppointments;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 29/04/05  1.00.01 IJB  Fixed missing GlobalRef site code, removed TDBEdit
                          fields being used as variable storage, commented out
                          incomplete grouped appointment code.
 03/05/05  1.00.02 BJ   Rep List list is filtered for the active records.
                          Old records will display the inactive records if they
                          are used.
 03/05/05  1.00.03 BJ   Charge Rate list is filtered for the active records.
                          Old records will display the inactive records if they
                          are used.
 07/06/05  1.00.04 IJB  Added flag 'DoingShow' to prevent
                        "Do You Wish To Add A Service" dialog before form
                        is visable, also stopped data edits if form read only.
 10/06/05  1.00.05 IJB  Added check/error handler around time combos.
 23/06/05  1.00.06 BJ   Drop down the customer combo and press escape
                        Application Crashes.
 27/06/05  1.00.06 BJ   If the 'IsfixedRate' of the selected service is true,
                        The 'Rate' is not multiplied by the hrs.
                        Bug Fixed: the form craashes when the it is cancelled. so
                        the tblMAster is 'cancelled' if it is in editmodes before
                        the form is closed. Also the closeQueries in the baseinput
                        form closes the query only if it is opened.
 28/06/05  1.00.07 BJ   Reschedule/cancel the repeated appointments when the original
                        appointment is rescheduled/cancelled.
                        --> Introduced a new field -LinkapptId which holds the Id
                        of the original appointment which is being repeated.
                        eg:appt1(1/12005)
                              _________________________
                              |---Appt1.1 (10/1/2005)
                              |
                              |---Appt1.2(20/1/2005)
                              |
                              |---Appt1.3(30/1/2005)
                              |
                              |---Appt1.4(10/2/2005)
                              |     |---Appt1.4.1
                              |     |---Appt1.4.2
                              |     |---Appt1.4.3
                              |     |---Appt1.4.4
                              |_________________________
                        -->After a child appt (appt1.4) is REPEATED, it becomes a main appointment
                        and reshceduling or cancelling the main appointment (appt1) will
                        not reschedule this appt.
                        -->Rescheduling popups the screen to specify the action for
                        Sat/sun/holiday appointments.
                        (for rescheduled appt date of the linked appointment )
                        -->Only the appointments which are not converted will be rescheduled.
                        -->Bug fixed : click on 'Cancel' - the application crashes.

 12/07/05  1.00.08 DMS  1. Invoicing the appointment will pick the right service name.
 27/07/05  1.00.09 IJB  Changed subfrmEquipment grid OnExit to prevent posting
                        empty row.
 29/07/05  1.00.09 DSP  The 'Rescheduled' field was not being set to 'T' when
                        the checkbox was ticked. This prevented the 'Rescheduled'
                        template from being used during printing.
 03/08/05  1.00.10 DSP  1. When entering a customer name not in the list and a
                           new customer is created; the new customer name was not
                           returned to the customer combobox. The fix also
                           required changes in BasInputForm.
                        2. Details were not being refreshed if the displayed
                           customer was reselected. This has been fixed.
 19/08/05  1.00.11 BJ   Only one service can be selected at a time, multiple were allowed
                        But when invoiced, all except the last selected service , were ignored.
                        Also the appointment list shows the last selected service.
 25/08/05  1.00.12 BJ   Bug fixed :Editing an appointment changes the service seelcted.

 12/10/05  1.00.13 ISB  Added Test User Locks on Convert to Invoice
 19/10/05  1.00.14 DLS  Added RegisterClass
 01/11/05  1.00.15 BJ   Locking implemented for all the linked appointments too
                        as rescheduling affects all of them, If the linked record
                        or the parent record is already locked by another user, the
                        appointment will be opened in readonly mode
 14/11/05  1.00.16 MV   ReDesigned the user interface of service type.
 15/11/05  1.00.17 MV   Added FindServiceRate to search for service procedure.
 18/11/05  1.00.18 MV   Added user option to define number of visible service colmns
                        Fixed invoice conversion issue service was not displayed within
                        invoice description.
 08/12/05  1.00.19 MV   Fixed Task Tracker Issue 299 Refres Screen.
 12/12/05  1.00.20 MV   Fixed Task Tracker Issue 300 issue where no service is
                        available when ability has not been specified.  Fixed Issie
                        with Assignment error and new methods implemented for
                        registering modules.
 19/12/05  1.00.21 AL   Removed "Instance", *Task306*
 03/01/06  1.00.22 BJ   Fields introduced for the actual date / times, invoicing uses FastFuncs,the
                        actuals instead of booking. When converting to an invoice, the
                        job/customer's free time is free of cost and the remaining hrs are charged.
 10/01/06  1.00.23 BJ   Converting to an invoice is not using the TransConvertobject anymore,
                        But using the invoice object. the invoice form is then shown based
                        on the preference - ShowInvoiceFormwhenApptInvoiced
 16/01/06  1.00.24 BJ   when showServiceHrsinInvoice is False, the customer's free hrs
                        is not updated or considered, appointment form then disabls the
                        outstaandng hrs and hrs to invoice. when this flag is false, the
                        service charge is for the total time not for an hr, but when the
                        flag is true, the service charge is mltiplied by the hrs to get the
                        total charge.
 24/01/06  1.00.25 BJ   showServiceHrsInInvoiceQty preference is removed , if the service selected
                        is a fixed rate service, it doesn;t show the qty in the invoice, and will
                        not calculate the client's free hours as well.
 01/02/06  1.00.26 IJB  Added cancellation reason.
 23/02/06  1.00.27 BJ   Invoicing an appointment updates the UOMID for the service(product).
 26/04/06  1.00.28 BJ   Default UOM fields are removed from the parts table, so invoicing an
                        Appointment gets the defualt_uom of the service product.
 06/09/06  1.00.29 DSP  Changed all occurrences of Application.ProcessMessages
                        to Update.
 22/09/06  1.00.30 DSP  Removed CloseQueries call from FormClose method.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,   ComCtrls,AdvOfficeStatusBar, StdCtrls, DBCtrls, dbcgrids, Buttons, DNMSpeedButton, Clipbrd,
  wwdbdatetimepicker, Mask, ExtCtrls, wwdblook, BaseInputForm, wwdbedit, DNMPanel,
  ActnList, kbmMemTable, Wwdbigrd, Grids, Wwdbgrid, ImgList, DBAccess, MyAccess,ERPdbComponents,
  MemDS, wwcheckbox, DataState, SelectionDialog, AppEvnts, wwDataInspector, CheckLst,
  Spin, Menus, AdvMenus, Shader, BusObjBase, BusObjAppointments, MessageInterface, MessageConst,
  BusObjRepServices, Wwdotdot, Wwdbcomb,frmEquipmentxRef, DNMAction, ProgressDialog,
  ERPDbLookupCombo, IntegerListObj, frmAttachments, erptimecombo, contactList;

const
  POST        = 0;
  DROP        = 1;
  SHIFTAFTER  = 2;
  SHIFTBEFORE = 3;

type
  TAppointmentGUI = class(TBaseInputGUI)
    DSDetails: TDataSource;
    DSMaster: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    lstTimes: TListBox;
    txtFeedbackNotes: TDBMemo;
    Label7: TLabel;
    txtClientDetails: TDBMemo;
    Label15: TLabel;
    Bevel2: TBevel;
    Label36: TLabel;
    LastTrainerID_Label: TLabel;
    Label9: TLabel;
    Cus_Alt_PH_Label: TLabel;
    Label6: TLabel;
    cboLastEmployee: TwwDBLookupCombo;
    cboEmployee: TwwDBLookupCombo;
    txtPhone: TwwDBEdit;
    txtAltPhone: TwwDBEdit;
    txtFax: TwwDBEdit;
    Bevel3: TBevel;
    actlstAppointments: TActionList;
    actPOS: TAction;
    actInvoice: TAction;
    lblConverted: TLabel;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    tblMasterAppointID: TAutoIncField;
    tblMasterGlobalRef: TWideStringField;
    tblMasterCusID: TIntegerField;
    tblMasterAppDate: TDateField;
    tblMasterCreationDate: TDateField;
    tblMasterUpdateDate: TDateField;
    tblMasterCancellation: TWideStringField;
    tblMasterTrainRateID: TIntegerField;
    tblMasterTrainerID: TIntegerField;
    tblMasterLastTrainerID: TIntegerField;
    tblMasterMedTypeID: TIntegerField;
    tblMasterContact: TWideStringField;
    tblMasterReschedulled: TWideStringField;
    tblMasterCancellationDate: TDateField;
    tblMasterRescheduledDate: TDateField;
    tblMasterStart_Time: TWideStringField;
    tblMasterEnd_Time: TWideStringField;
    tblMasterStartVal: TFloatField;
    tblMasterEndVal: TFloatField;
    tblMasterPH_Support_Till: TDateField;
    tblMasterRate: TFloatField;
    tblMasterTrainerCode: TWideStringField;
    tblMasterFeedbackNotes: TWideMemoField;
    tblMasterCalloutValue: TFloatField;
    tblMasterOther: TWideStringField;
    tblMasterOthertxt: TWideStringField;
    tblMasterFeedback: TWideStringField;
    tblMasterTotalInc: TFloatField;
    tblMasterTotalCost: TFloatField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterMSRef: TWideStringField;
    tblMasterAppearDays: TIntegerField;
    tblMasterClassID: TIntegerField;
    tblMasterRescheduledFrom: TDateField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterCustomerDetails: TWideStringField;
    tblMasterPhone: TWideStringField;
    tblMasterAltPhone: TWideStringField;
    tblMasterFax: TWideStringField;
    tblMasterSTARTTIME: TDateTimeField;
    tblMasterENDTIME: TDateTimeField;
    tblMasterJobDueDate: TDateField;
    tblMasterServiceID: TWordField;
    tblMasterResourceID: TWordField;
    tblMasterPosID: TIntegerField;
    tblMasterConverted: TWideStringField;
    Label11: TLabel;
    Label4: TLabel;
    imgCredit: TImageList;
    tblMasterUnavailable: TWideStringField;
    cboClientLookup: TERPQuery;
    cboClassQry: TERPQuery;
    cboLastRepLookup: TERPQuery;
    cboRepLookup: TERPQuery;
    cboClientLookupStopCreditImage: TIntegerField;
    cboClientLookupClientID: TIntegerField;
    Label3: TLabel;
    tblMasterEnteredByEmployeeID: TIntegerField;
    tblMasterEnteredByEmployeeName: TWideStringField;
    edtEnteredBy: TwwDBEdit;
    tblMasterNotes: TWideMemoField;
    tblMasterActive: TWideStringField;
    tblApptGroups: TERPQuery;
    tblApptGroupsAppointID: TIntegerField;
    tblApptGroupsGroupID: TIntegerField;
    qryApptGrp: TERPQuery;
    tblMasterLinkAppointID: TIntegerField;
    tblMasterIsGroupParent: TWideStringField;
    edtOverwriteAppID: TwwDBEdit;
    lblAppNo: TLabel;
    SchedulePageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DNMPanel2: TDNMPanel;
    Combo15_Label: TLabel;
    Label10: TLabel;
    Start_Time_Label: TLabel;
    End_Time_Label: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Cancellation_Label: TLabel;
    lblRescheduled: TLabel;
    lblRescheduleLabel: TLabel;
    AppDate: TwwDBDateTimePicker;
    cboChargeRate: TwwDBLookupCombo;
    txtCalloutValue: TwwDBEdit;
    txtStartTime: TErpDbTimeCombo;
    txtEndTime: TErpDbTimeCombo;
    txtTotal: TwwDBEdit;
    txtLabourCost: TwwDBEdit;
    txtTotalTime: TEdit;
    chkCancellation: TDBCheckBox;
    cboCancellationDate: TwwDBDateTimePicker;
    cboRescheduledDate: TwwDBDateTimePicker;
    edtlblRescheduleLabel: TwwDBEdit;
    lblDateCaption: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    tblMasterServiceDesc: TWideStringField;
    DNMPanel4: TDNMPanel;
    ServiceList: TCheckListBox;
    Label24: TLabel;
    txtOther: TwwDBEdit;
    Label17: TLabel;
    ServiceSearch: TEdit;
    Label18: TLabel;
    speColumns: TSpinEdit;
    Label19: TLabel;
    lblActualDate: TLabel;
    txtActual_appDate: TwwDBDateTimePicker;
    txtActualStarttime: TErpDbTimeCombo;
    txtActualEndTime: TErpDbTimeCombo;
    txtActualtotaltime: TEdit;
    Bevel6: TBevel;
    Bevel8: TBevel;
    tblMasterActual_AppDate: TDateField;
    tblMasterActual_Start_time: TWideStringField;
    tblMasterActual_End_time: TWideStringField;
    tblMasterActual_Starttime: TDateTimeField;
    tblMasterActual_Endtime: TDateTimeField;
    tblMasterTimesheetID: TIntegerField;
    chkRescheduled: TDBCheckBox;
    lblOutstandinghrs: TLabel;
    txtOutstandinghrs: TwwDBEdit;
    lblHrstoInvoice: TLabel;
    txtHrsToInvoice: TwwDBEdit;
    tblMasterHrstoInvoice: TFloatField;
    Bevel9: TBevel;
    Bevel7: TBevel;
    Label21: TLabel;
    cboCancellationReason: TwwDBLookupCombo;
    tblMasterCancellationReason: TWideStringField;
    qryCancellationReason: TERPQuery;
    txtMoblie: TwwDBEdit;
    Label22: TLabel;
    Bevel: TBevel;
    AppCount: TwwDBEdit;
    tblMasterMobile: TWideStringField;
    btnFax: TDNMSpeedButton;
    dtAppEndDate: TwwDBDateTimePicker;
    Label23: TLabel;
    Bevel10: TBevel;
    dtActualEndDate: TwwDBDateTimePicker;
    lblActualTime: TLabel;
    Label25: TLabel;
    cboFollowUpResult: TwwDBLookupCombo;
    qryStatusType: TERPQuery;
    tblMasterStatus: TWideStringField;
    tblMastermsTimeStamp: TDateTimeField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboClientLookupStopCredit: TWideStringField;
    cboClientLookupIsJob: TWideStringField;
    cboClientLookupCustomer: TWideStringField;
    cboClientLookupSupplier: TWideStringField;
    cboClientLookupOtherContact: TWideStringField;
    QryAvailableServices: TERPQuery;
    FloatField1: TFloatField;
    IntegerField1: TIntegerField;
    FloatField2: TFloatField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    Custom_Fields: TTabSheet;
    pnlCustFields: TDNMPanel;
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
    Label54: TLabel;
    Label55: TLabel;
    CUSTLBL17: TLabel;
    CUSTLBL18: TLabel;
    cmdCustomLabelsOld: TDNMSpeedButton;
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
    qryCustomFields: TERPQuery;
    tblMasterCUSTFLD1: TWideStringField;
    tblMasterCUSTFLD2: TWideStringField;
    tblMasterCUSTFLD3: TWideStringField;
    tblMasterCUSTFLD4: TWideStringField;
    tblMasterCUSTFLD5: TWideStringField;
    tblMasterCUSTFLD6: TWideStringField;
    tblMasterCUSTFLD7: TWideStringField;
    tblMasterCUSTFLD8: TWideStringField;
    tblMasterCUSTFLD9: TWideStringField;
    tblMasterCUSTFLD10: TWideStringField;
    tblMasterCUSTFLD11: TWideStringField;
    tblMasterCUSTFLD12: TWideStringField;
    tblMasterCUSTFLD13: TWideStringField;
    tblMasterCUSTFLD14: TWideStringField;
    tblMasterCUSTFLD15: TWideStringField;
    tblMasterCUSTDATE1: TDateField;
    tblMasterCUSTDATE2: TDateField;
    tblMasterCUSTDATE3: TDateField;
    qryMediaType: TERPQuery;
    cboMediaType: TwwDBLookupCombo;
    lblCurrency: TLabel;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsid: TIntegerField;
    tblDetailsCustomerEquipmentID: TIntegerField;
    tblDetailsRepairID: TIntegerField;
    tblDetailsAppointmentID: TLargeintField;
    tblDetailsSaleId: TLargeintField;
    tblDetailsInvoiceID: TLargeintField;
    tblDetailsNotes: TWideStringField;
    tblDetailsOnSite: TWideStringField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsDescription: TWideStringField;
    tblDetailsCreationDate: TDateField;
    tblDetailsUpdateDate: TDateField;
    tblDetailsCode: TWideStringField;
    tblDetailsCustomField1: TWideStringField;
    tblDetailsCustomField2: TWideStringField;
    tblDetailsCustomField3: TWideStringField;
    tblDetailsCustomField4: TWideStringField;
    tblDetailsCustomField5: TWideStringField;
    tblDetailsCustomField6: TWideStringField;
    tblDetailsCustomField7: TWideStringField;
    tblDetailsCustomField8: TWideStringField;
    tblDetailsCustomField9: TWideStringField;
    tblDetailsCustomField10: TWideStringField;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsWarantyPeriodTaken: TLargeintField;
    tblDetailsWarantyPeriodLeft: TLargeintField;
    tblDetailsQuantity: TFloatField;
    tblDetailsUOM: TWideStringField;
    tblDetailsUOMID: TLargeintField;
    tblDetailsUOMMultiplier: TFloatField;
    tblDetailsUOMQty: TFloatField;
    tabEquipment: TTabSheet;
    pnlEquipments: TDNMPanel;
    Label28: TLabel;
    wwCheckBox1: TwwCheckBox;
    btnPOS: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    Bevel1: TBevel;
    btnRepeat: TDNMSpeedButton;
    Label13: TLabel;
    cboClass: TwwDBLookupCombo;
    Bevel11: TBevel;
    MultipleReps: TDNMSpeedButton;
    tblMasterRateDesc: TWideStringField;
    DBEdit1: TwwDBEdit;
    tblMasterRepairID: TIntegerField;
    btnUpdateRepair: TDNMSpeedButton;
    ActUpdateRepairs: TDNMAction;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    txtNotes: TDBMemo;
    QryServiceLookup: TERPQuery;
    QryServiceLookupServiceID: TIntegerField;
    QryServiceLookupServiceDesc: TWideStringField;
    QryServiceLookupIsFixedRate: TWideStringField;
    cboClientLookupCompany: TWideStringField;
    tblMasterClientName: TWideStringField;
    cboClient: TERPDbLookupCombo;
    tblMastermsUpdateSiteCode: TWideStringField;
    tblMasterGoogleId: TWideStringField;
    tblMasterSynchWithGoogle: TWideStringField;
    tblDetailsNextServiceDate: TDateTimeField;
    tblDetailsmsUpdateSiteCode: TWideStringField;
    tabAttachments: TTabSheet;
    pnlReminderhint: TPanel;
    Label16: TLabel;
    TmrReminderhint: TTimer;
    btnContacts: TDNMSpeedButton;
    DBText1: TDBText;
    tblMasterDisplayStatus: TWideStringField;
    tblMasterLocalApp: TWideStringField;
    lblMsg: TLabel;
    tblMasterClientPrintName: TWideStringField;
    cboClientLookupPrintName: TWideStringField;
    DNMPanel5: TDNMPanel;
    cmdNew: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    DNMPanel6: TDNMPanel;
    chkSyncWithGoogle: TdbCheckBox;
    DNMPanel8: TDNMPanel;
    chkDeleted: TdbCheckBox;
    cmdEmail: TDNMSpeedButton;
    tblMasterStreet: TWideStringField;
    tblMasterStreet2: TWideStringField;
    tblMasterStreet3: TWideStringField;
    tblMasterSuburb: TWideStringField;
    tblMasterState: TWideStringField;
    tblMasterCountry: TWideStringField;
    tblMasterPostcode: TWideStringField;
    qrySuburb: TERPQuery;
    TabSheet3: TTabSheet;
    DNMPanel7: TDNMPanel;
    Label8: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    lblSuburb: TLabel;
    lblState: TLabel;
    lblPostCode: TLabel;
    Label2: TLabel;
    Street2: TDBEdit;
    Street: TDBEdit;
    Street3: TDBEdit;
    Suburb: TwwDBLookupCombo;
    State: TDBEdit;
    Postcode: TDBEdit;
    Country: TDBEdit;
    btnChooseProduct: TDNMSpeedButton;
    qryServices: TERPQuery;
    qryServicesRate: TFloatField;
    qryServicesServiceID: TIntegerField;
    qryServicesPayRate: TFloatField;
    qryServicesEmployeeID: TIntegerField;
    qryServicesClientID: TIntegerField;
    qryServicesServiceDesc: TStringField;
    qryServicesIsFixedRate: TWideStringField;
    tblMasterProductDesc: TWideStringField;
    tblMasterProductID: TIntegerField;
    TabTimeLog: TTabSheet;
    DNMPanel9: TDNMPanel;
    dsAppointmentsTimeLog: TDataSource;
    qryAppointmentsTimeLog: TERPQuery;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    qryAppointmentsTimeLogID: TIntegerField;
    qryAppointmentsTimeLogAppointID: TIntegerField;
    qryAppointmentsTimeLogGlobalRef: TWideStringField;
    qryAppointmentsTimeLogStartDatetime: TDatetimeField;
    qryAppointmentsTimeLogEndDatetime: TDatetimeField;
    qryAppointmentsTimeLogEnteredByEmployeeID: TIntegerField;
    qryAppointmentsTimeLogmsTimeStamp: TDateTimeField;
    qryAppointmentsTimeLogmsUpdateSiteCode: TWideStringField;
    DNMPanel10: TDNMPanel;
    btnStart: TDNMSpeedButton;
    qryAppointmentsTimeLogDuration: TFloatField;
    btnStop: TDNMSpeedButton;
    qryAppointmentsTimeLogEmployeeID: TIntegerField;
    qryAppointmentsTimeLogDescription: TWideStringField;
    qryAppointmentsTimeLogIncludeForInvoice: TWideStringField;
    QryEmployee: TERPQuery;
    cboTimesLogEmployee: TwwDBLookupCombo;
    QryEmployeeTrainerID: TIntegerField;
    QryEmployeeEmployeeName: TWideStringField;
    qryAppointmentsTimeLogEmployeeName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure chkCancellationClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cboEmployeeDblClick(Sender: TObject);
    procedure cboChargeRateBeforeDropDown(Sender: TObject);
    procedure actPOSUpdate(Sender: TObject);
    procedure actPOSExecute(Sender: TObject);
    procedure actInvoiceUpdate(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure btnRepeatClick(Sender: TObject);
    procedure cboChargeRateNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboLastEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboClientChange(Sender: TObject);
    procedure cboClientLookupCalcFields(DataSet: TDataSet);
    procedure cboClientDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cboClientLookupAfterOpen(DataSet: TDataSet);
    procedure cboChargeRateEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboRescheduledDateCloseUp(Sender: TObject);
    procedure SchedulePageControlResize(Sender: TObject);
    procedure ServiceListClickCheck(Sender: TObject);
    procedure ServiceSearchChange(Sender: TObject);
    procedure SchedulePageControlChange(Sender: TObject);
    procedure speColumnsChange(Sender: TObject);
    procedure cboCancellationReasonNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnFaxClick(Sender: TObject);
    procedure cboFollowUpResultNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure ComboCloseUp(Sender: TObject);
    procedure cboChargeRateCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure DBEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboClientNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure cboClientEnter(Sender: TObject);
    procedure chkRescheduledClick(Sender: TObject);
    procedure MultipleRepsClick(Sender: TObject);
    procedure ActUpdateRepairsExecute(Sender: TObject);
    procedure ActUpdateRepairsUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tblDetailsWarantyPeriodTakenChange(Sender: TField);
    procedure tblDetailsWarantyPeriodLeftChange(Sender: TField);
    procedure txtStartTimeDropDown(Sender: TObject);
    procedure txtEndTimeDropDown(Sender: TObject);
    procedure txtActualStarttimeDropDown(Sender: TObject);
    procedure txtActualEndTimeDropDown(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure tblMasterAfterPost(DataSet: TDataSet);
    procedure TmrReminderhintTimer(Sender: TObject);
    procedure Label16DblClick(Sender: TObject);
    procedure btnContactsClick(Sender: TObject);
    procedure tblMasterAfterInsert(DataSet: TDataSet);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure btnChooseProductClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure qryAppointmentsTimeLogBeforeOpen(DataSet: TDataSet);
    procedure txtActualtotaltimeDblClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure txtTotalTimeDblClick(Sender: TObject);
  private
    fMsgHandler: TMsgHandler;
    fInitNote: string;
    fInitEmployeeID: Integer;
    fInitDate: TDateTime;
    fInitStartTime: TDateTime;
    fInitClientID: Integer;
    fInitRepairID :Integer;
    fInitCustomerDetails: string;
    fInitActiveControl: TComponent;
    fNewAppointmentName: string;
    DoingShow: Boolean;
    ServiceQuestionAsked: Boolean;
    fWaitingForm: string;
    fbEnforceRepToFront: Boolean;
    fChargeRateValue: string;
    fChargeRateRecNo: Integer;
    fNewAppointment:Boolean;
    EquipmentxRefForm :TfmEquipmentxRef;
    RepIdList: TIntegerList;
    AppIdList: TIntegerList;
    AttachmentForm: TfmAttachments;
    fdGroupAptdates :Array of Tdatetime;
    function IsActualsUpdated: Boolean;
    procedure NewData;
    procedure ClearInitialiseFields;
    procedure OnCustomerSelect(Sender: TwwDbGrid);
    procedure PrintApp(const AppointID: integer);
    procedure SetStartAndEndTimeIncrements;
    procedure SetComboFocus(var Msg: TMessage); message TX_SetFocus;
    procedure SetServiceListColumnCount;
    procedure GetChargeRateDetails;

    function SaveAndCommit(AskQuestion: Boolean; CommitRetaining: Boolean = False): Boolean;
    function LoadAppointment(aID: Integer; AskQuestion: Boolean = False): Boolean;
    procedure AppointmentSaved(const aIsNew: Boolean);
    procedure TotalsChanged(Sender: TObject);
    procedure RefreshAvailableServices(Sender: TObject);
    procedure AddServiceCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure ServiceIDChanged(Sender: TObject);
    procedure ClientIDChanged(Sender: TObject);
    procedure NotifyWaitingForm;
    procedure WMBringToFrontSoon(var Msg: TMessage); message WM_BringToFrontSoon;
    Function FoundInInactiveList(var Accept: boolean;cbo :TwwDBLookupCombo;NewValue: string):Boolean;
    Procedure closecalendar;
    (*Procedure LocateTime(Sender :TObject;  timeValue :String );*)
    function ChkCustReqdFields: boolean;
    procedure DoOnGridDataSelectMultiRep(Sender: TwwDbGrid);
    procedure SendEmail;
    procedure SendSilentEmail;
    procedure SendMessageEmail;
    procedure SendMessageEmailSilent;
    procedure SendMessageSMS;
    procedure SendMessageSMSSilent(const MsgTo: string = '');
//    procedure SendMessageSMSSilentAsk;
    procedure SendMessageSMSSilentCompany;
    procedure SendMessageSMSSilentRep;
    procedure SendMessageSMSSilentBoth;
    procedure PrintAppointment;
    procedure PopulateMessageSubstituteList(SL: TStringList);
    procedure InitAttachments;
    procedure RepeatApptsforGroupAptdates;
    procedure UserInputStartdate(aDate: TDateTime; aMsg: String);
    procedure UserInputEnddate(aDate: TDateTime; aMsg: String);

  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure InitContactList(Sender : TObject);
    procedure InitProductList(Sender : TObject);
    Procedure UpdateFromContact(Sender: TwwDbGrid);
    Procedure OnChooseProduct(Sender: TwwDbGrid);
    procedure CompleteComboNotInList(const aObserver: TObject); override;
    procedure CustomFieldsRefresh;Override;
    Procedure InitERPLookupCombonFields; Override;
    procedure PrepareEmailText(var Recipient, Subject, Text : string);
    procedure SendPreparedEmail(const Recipient, Subject, Text : string; ASilent, aSecret : boolean);
  public
    Appointment: TAppointment;
    //Equipment: TApptEquipment;
    AvailableServices: TServicesWithRate;

    EmployeeID          : integer;
    tdDate              : TDateTime;
    sStartTime          : string;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
    //Property GroupAptdates: Array of TDateTime write setGroupAptdates;
    procedure GroupAptdates(const Value: array of TDateTime);
  published
    procedure RepServicesFormClosed(MsgObj: TMsgObj);
    procedure SetActiveControl(MsgObj: TMsgObj);
    function InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    property InitialClientId: integer read fInitClientID write fInitClientID;
    function InitialiserepairID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    property InitialRepairID: integer read fInitrepairID write fInitrepairID;
    function InitNote(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    property InitialNotes: string read fInitNote write fInitNote;
    function InitEmployeeID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    property InitialEmployeeID: integer read fInitEmployeeID write fInitEmployeeID;
    function InitDate(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    property InitialDate: TDateTime read fInitDate write fInitDate;
    function InitStartTime(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    property InitialStartTime: TDateTime read fInitStartTime write fInitStartTime;
    property InitialInitCustomerDetails: string read fInitCustomerDetails write fInitCustomerDetails;
    function CloseIfOpen(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
//    function InitStartTime(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
  end;

  TNewAppointment = class(TComponent)
  private
    fMsgHandler: TMsgHandler;
    fHandle: HWND;
    fNote: string;
    fEmployeeID: Integer;
    fAppDate: TDateTime;
    fStartTime: TDateTime;
    fClientID: Integer;
    fRepairId:Integer;
    fActiveControl: string;
    fCalendarGUI: TBaseInputGUI;
    fAppointmentGUI: TAppointmentGUI;
    fSaver: TComponent;
    procedure WndProc(var Message: TMessage);
    procedure Release;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    function AppDate(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    function StartTime(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    function ClientID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    function RepairId(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    function EmployeeID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    function Note(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    function ActiveControl(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    function AppointmentPlaced(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
    procedure AppointmentSaved(MsgObj: TMsgObj); //DateTime = StartTime, IntValue = EmployeeID
    procedure CreateNewAppointment(MsgObj: TMsgObj); //MsgObj.BoolValue = Ensure appointment is created
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib, DateUtils, FormFactory, DNMExceptions, POSScreenGUI,
  frmRepeat, ShellAPI, DNMLib,

  frmRescheduleAppt, tcDataUtils,
  CommonLib, GlobalEventsObj,frmSupplier,
  FaxObj, BusObjConst,frmOtherContactFrm,(*frmEquipmentFrm,*)
  BaseListingForm, BusObjClient, AppEnvironment, FastFuncs, tcconst,
  frmCustomFieldsFrm, frmCustomerFrm,
  BusObjEquipment, RepListFrm, busobjrepairs,
  EquipmentListforxRef, frmRepairs, frmCalendar, frmSimpleTypes, timelib,
  CommonFormLib, EmailUtils, frmReportingOptions, SMSUtils,
  frmMObileNumberInput, BusObjEmployee, CorrespondenceObj, PreferancesLib,
  ProductListExpressForm, frmDateInputBox;

const
  crlf = Chr(13) + Chr(10);

type
  TDBComboBoxHack = class(TErpDbTimeCombo)
  end;

  TwwDBCustomLookupComboHack = class(TwwDBCustomLookupCombo)
  end;

{ TAppointmentGUI }
procedure TAppointmentGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
var
  AppDest: TAppointment;
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TAppointment          then TAppointment(Sender).Dataset         := tblMaster
        else if Sender is TEquipmentxRef        then TEquipmentxRef(Sender).Dataset       := tblDetails
        else if Sender is TRepServices          then TRepServices(Sender).Dataset         := qryServices
        else if Sender is TAppointmentsTimeLog  then TAppointmentsTimeLog(Sender).Dataset := qryAppointmentsTimeLog;
    end else if (Sender is TAppointment) and (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_RepServiceCreate) then begin
      MessageDlgXP_vista('Created Service '+ Quotedstr(Appointment.ServiceDesc) +' for Rep '+ Quotedstr(Appointment.TrainerName) +'.' , mtInformation, [mbOK], 0);
    end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_CalcFields) then begin
      txtActualTotalTime.Text := Appointment.Actual_TotalHoursStr;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_DatetimeChanged) then begin
      txtTotalTime.Text := Appointment.TotalHoursStr;
      txtActualTotalTime.Text := Appointment.Actual_TotalHoursStr;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_TrainerChanged) then begin
      { if we are synching with google we need to keep a copy of the appointment for old trainer so that can be deleted }
      if TAppointment(Sender).SynchWithGoogle and (TAppointment(Sender).GoogleId <> '') and
        (AppEnv.CompanyPrefs.GoogleCalendarConfig.SynchWithGoogleCalendar and
         (AppEnv.CompanyPrefs.GoogleCalendarConfig.LastServerId = AppEnv.ServerID)) then begin
        { make a copy of the old appointment }
        AppDest := TAppointment.Create(nil);
        try
          AppDest.Connection := TAppointment(Sender).Connection;
          AppDest.Load(0);
          AppDest.New;
          AppDest.XML := TAppointment(Sender).XML;
          AppDest.TrainerID := TAppointment(Sender).CleanTrainerId;
          AppDest.Active := false;
          AppDest.PostDb;
          AppIdList.Add(AppDest.ID);
        finally
          AppDest.Free;
        end;
        { now for a different employee's calender so clear old calenderId }
        TAppointment(Sender).GoogleId := '';
      end;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ProductID) then begin
      RefreshAvailableServices(Sender);
      SchedulePageControl.ActivePage := TabSheet1;
    end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusObjEventVal_StartDateTime) and (Sender is TAppointmentsTimeLog) then begin
      UserInputStartdate(TAppointmentsTimeLog(Sender).StartDateTime, 'Start At');
    end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusObjEventVal_EndDateTime) and (Sender is TAppointmentsTimeLog) then begin
      UserInputEnddate(TAppointmentsTimeLog(Sender).EndDateTime, 'End At');
    end;
end;
procedure TAppointmentGUI.UserInputStartdate(aDate:TDateTime; aMsg:String);
begin
  Exit;
(*    if TfmDateInputBox.InputValue(aMsg,aMsg,aDate, 0 , true) then begin
      if Appointment.AppointmentsTimeLog.StartDateTime <> aDAte then begin
        Appointment.AppointmentsTimeLog.StartDateTime :=aDAte;
        Appointment.AppointmentsTimeLog.PostDB;
      end;
    end;*)
end;
procedure TAppointmentGUI.UserInputEnddate(aDate:TDateTime; aMsg:String);
begin
  Exit;
(*    if TfmDateInputBox.InputValue(aMsg,aMsg,aDate, 0 , true) then begin
      if Appointment.AppointmentsTimeLog.EndDateTime <> aDAte then begin
        Appointment.AppointmentsTimeLog.EndDateTime :=aDAte;
        Appointment.AppointmentsTimeLog.PostDB;
      end;
    end;*)
end;
procedure TAppointmentGUI.DoOnGridDataSelectMultiRep(Sender: TwwDbGrid);
var
  i: integer;
begin
  Sender.DataSource.DataSet.DisableControls;
  try
    for i := 0 to Sender.SelectedList.Count - 1 do begin
      Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList.Items[i]);
      RepIdList.Add(Sender.DataSource.DataSet.FieldByName('EmployeeID').AsInteger);
    end;
  finally
    Sender.DataSource.DataSet.EnableControls;
  end;
end;

procedure TAppointmentGUI.FormCreate(Sender: TObject);
begin
  AppDate.DisplayFormat := formatSettings.ShortDateFormat;
  dtAppEndDate.DisplayFormat := formatSettings.ShortDateFormat;
  AddPhoneCallbutton(txtPhone);
  AddPhoneCallbutton(txtAltPhone);
  AddPhoneCallbutton(txtMoblie);

  AllowCustomiseGrid := true;
  fMsgHandler := TMsgHandler.Create(Self);
  RepIdList:= TIntegerList.create;
  AppIdList := TIntegerList.create;

    Setlength(BusObjqueries, 2);
  BusObjqueries[0] := 'tblMaster';
  BusObjqueries[1] := 'tblDetails';

  Appointment                       := TAppointment.Create(Self);
  Appointment.Connection            := TMyDacDataConnection.Create(Appointment);
  Appointment.Connection.connection := MyConnection;
  Appointment.BusObjEvent           := DoBusinessObjectEvent;
  AvailableServices                 := TServicesWithRate.Create(Appointment);
  AvailableServices.BusObjEvent     := DoBusinessObjectEvent;
  AvailableServices.Dataset         := qryAvailableServices;
  Appointment.OnRefreshAvailableServices := RefreshAvailableServices;
  Appointment.OnServiceIDChange     := ServiceIDChanged;
  Appointment.OnClientIDChange      := ClientIDChanged;
  Appointment.OnTotalsChange        := TotalsChanged;
  Appointment.GUIMode               := True;

  inherited;
  ClearInitialiseFields;
  SetLength(fdGroupAptdates,0);
  TDBComboBoxHack(txtStartTime).OnCloseUp := ComboCloseUp;
  TDBComboBoxHack(txtEndTime).OnCloseUp := ComboCloseUp;
  TDBComboBoxHack(txtActualStartTime).OnCloseUp := ComboCloseUp;
  TDBComboBoxHack(txtActualEndTime).OnCloseUp := ComboCloseUp;
// Old stuff
  tdDate := Date;
  sStartTime := '08:00 AM';
  DoingShow := false;
end;

procedure TAppointmentGUI.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsnormal;
end;

procedure TAppointmentGUI.FormClose(Sender: TObject; var Action: TCloseAction);
var
  RepairMsgObj : TMsgObj;
begin
  Self.Enabled := false;
  Action := caFree;

  if Appointment.repairId <> 0 then begin
    RepairMsgObj := TMsgObj.Create;
    RepairMsgObj.SetAddress('TRepairsGUI', 'RefreshAppointments', 'RepairsGUI');
    fMsgHandler.Send(RepairMsgObj, RepairMsgObj);
  end;

  inherited;
end;

procedure TAppointmentGUI.NewData;
var
  RepairMsgObj : TMsgObj;
begin
  cboRepLookup.Close;
  cboRepLookup.ParamByName('EmpID').AsInteger := 0;
  cboRepLookup.Open;
  cboEmployee.Enabled := False;
  chkDeleted.Enabled := False;
  lblRescheduleLabel.Visible := False;
  edtlblRescheduleLabel.Visible := False;
  lblConverted.Visible := False;
  AppCount.Text := '';
  MultipleReps.enabled := False;

  Appointment.UnLock;
  MyConnection.StartTransaction;
  Appointment.New;

  if fInitEmployeeID <> 0 then
    Appointment.TrainerID := fInitEmployeeID;
  if fInitClientID <> 0 then begin
    Appointment.ClientID := fInitClientID;
    cboClient.Text := Appointment.ClientPrintName;
    cboClient.InitnOpenLookup;
    cboClient.CloseUp(false);
  end;
  if fInitRepairID <> 0 then begin
    Appointment.RepairId := fInitRepairID;
    Appointment.PostDB;
    RepairMsgObj := TMsgObj.Create;
    RepairMsgObj.SetAddress('TRepairsGUI', 'GetRepairDetails', 'RepairsGUI');
    RepairMsgObj.ObjPtr :=Appointment;
    fMsgHandler.Send(RepairMsgObj, RepairMsgObj);
  end;
  if fInitCustomerDetails <> '' then
    Appointment.CustomerDetails := fInitCustomerDetails;

  if fInitStartTime <> 0 then begin
    if DateOf(fInitStartTime) = 0 then begin
      if (fInitDate = 0) then
        fInitStartTime := Appointment.AppDate + TimeOf(fInitStartTime)
      else
        fInitStartTime := DateOf(fInitDate) + TimeOf(fInitStartTime);
    end;
    Appointment.StartTime := fInitStartTime;
  end else if fInitDate <> 0 then begin
    Appointment.AppDate := fInitDate;
  end else if Length(fdGroupAptdates)<> 0 then begin
    Appointment.End_Time := FormatdateTime('hh:nn Am/pm' ,Appenv.companyPrefs.EndOfday);
    Appointment.Start_Time := FormatdateTime('hh:nn Am/pm' ,Appenv.companyPrefs.StartOfday);
    Appointment.AppDate := fdGroupAptdates[0];
    Appointment.EndTime :=fdGroupAptdates[0] +TimeOf(Appenv.companyPrefs.EndOfday);
    Appointment.StartTime :=fdGroupAptdates[0] +TimeOf(Appenv.companyPrefs.StartOfday);
    Appointment.EndTime :=fdGroupAptdates[0] +TimeOf(Appenv.companyPrefs.EndOfday);
  end;
  cmdEmail.Enabled := (Appointment.ClientEmail <> '') or (Appointment.RepEmail <> '');
  if (Appointment.Start_time <> '') then
    AppCount.Text := IntToStr(Appointment.ClientAppointmentCount);
  RefreshAvailableServices(Self);
  Appointment.Recalculate;

  if tblMaster.State = dsInsert then begin
    tblMaster.Post;
    tblMaster.Edit;
  end;
end;

procedure TAppointmentGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    SchedulePageControl.TabIndex:=0;
    lblCurrency.Caption := AppEnv.RegionalOptions.CurrencySymbol;
    DoingShow := True;
    try
      try
        inherited;
        if Self.ErrorOccurred then
          Exit;
        BringToFront;
        Setlength(QueryNamesNotToOpen, 8);
        QueryNamesNotToOpen[0] := 'tblMaster';
        QueryNamesNotToOpen[1] := 'tblDetails';
        QueryNamesNotToOpen[2] := 'tblApptGroups';
        QueryNamesNotToOpen[3] := 'qryApptGrp';
        QueryNamesNotToOpen[4] := 'qryCancellationReason';
        QueryNamesNotToOpen[5] := 'qryAvailableServices';
        QueryNamesNotToOpen[6] := 'cboRepLookup';
        QueryNamesNotToOpen[7] := 'qryAppointmentsTimeLog';
        //QueryNamesNotToOpen[7] := 'cboClientLookup';

        {this has to be opened before the appointment object is loaded for the TERPLookupCombo to load the parameters properly in 'DoCahnge' event of the combo}
        //cboClientLookup.Params.Parambyname('Selectedclient').asInteger := AppointmentclientId(KeyID);

        QryServiceLookup.Open;
        OpenQueries(QueryNamesNotToOpen);
        MultipleReps.enabled := KeyId <> 0;

        SetStartAndEndTimeIncrements;
        Appointment.Load(0);
        if KeyID = 0 then begin
          fNewAppointment := True;

          if fNewAppointment then begin
            cboRescheduledDate.Visible := False;
            chkCancellation.Enabled := False;
            Cancellation_label.Enabled := False;
            chkRescheduled.Enabled := False;
            lblRescheduled.Enabled := False;
          end;

          if MyConnection.InTransaction then begin
            if not SaveAndCommit(True) then
              Exit;
            Notify;
          end;
          NewData;
        end else begin
          fNewAppointment := False;
          if MyConnection.InTransaction then begin
            if not LoadAppointment(KeyID, True) then
              Exit;
            Notify;
          end else
            LoadAppointment(KeyID, False);
            txtTotalTime.Text := Appointment.TotalHoursStr;
            txtActualTotalTime.Text := Appointment.Actual_TotalHoursStr;
            Self.Update;
        end;
        Appointment.AppointmentsTimeLog;
        (*Closedb(cboClientLookup);
        cboClientLookup.Params.Parambyname('Selectedclient').asInteger := Appointment.clientId;
        Opendb(cboClientLookup);*)
        GuiPrefs.Active := True;

        (*SetStartAndEndTimeIncrements;*)
        qryCancellationReason.Close;
        qryCancellationReason.ParamByName('TypeCode').asString := SimpleTypes_AppointmentCancellationType;
        qryCancellationReason.ParamByName('Name').asString := Appointment.CancellationReason;
        qryCancellationReason.Open;
        RealignTabControl(SchedulePageControl, 1);
        SchedulePageControl.ActivePageIndex := 0;
        SetServiceListColumnCount;
        //chkRescheduled.Enabled:= not tblMasterReschedulled.AsBoolean;
        try
          if Assigned(fInitActiveControl) then
            SetControlFocus(TWinControl(fInitActiveControl));
        Except

        end;
      except
        on EAbort do
          HandleEAbortException;
        on e: ENoAccess do begin
          HandleNoAccessException(e);
          Exit;
        end;
        else
          raise;
      end;
    finally
      DoingShow := False;
      ClearInitialiseFields;
      pnlReminderhint.visible := (tblMasterActual_AppDate.AsDateTime <>0) (*or (tblMasterAppDate.AsDateTime < date)*);
      TmrReminderhint.enabled := True;
    end;
  finally

    EnableForm;
    cboClient.SetFocus;

    lblActualDate.Enabled       := not(appenv.CompanyPrefs.AutoUpdateActual);
    lblActualTime.Enabled       := not(appenv.CompanyPrefs.AutoUpdateActual);
    txtActual_appDate.Enabled   := not(appenv.CompanyPrefs.AutoUpdateActual);
    txtActualStarttime.Enabled  := not(appenv.CompanyPrefs.AutoUpdateActual);
    dtActualEndDate.Enabled     := not(appenv.CompanyPrefs.AutoUpdateActual);
    txtActualEndTime.Enabled    := not(appenv.CompanyPrefs.AutoUpdateActual);
  end;
end;


procedure TAppointmentGUI.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin
  if not Modified then Exit;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TAppointmentGUI.btnSaveClick(Sender: TObject);
var
  x: integer;
begin
  DisableForm;
  try
    if SaveAndCommit(False) then begin
      AppEnv.GoogleUpdater.UpdateCalendar(Appointment.Id, AppEnv.ServerID);
      for x := 0 to AppIdList.Count -1 do
        AppEnv.GoogleUpdater.UpdateCalendar(AppIdList.Item[x], AppEnv.ServerID);
      AppIdList.Clear;
      if fsModal in Self.FormState then
        ModalResult := mrOk
      else
        Close;
    end;
  finally
    EnableForm;
  end;  
end;



procedure TAppointmentGUI.btnCancelClick(Sender: TObject);
begin
  RollbackTransaction;
  Self.Close;
end;

procedure TAppointmentGUI.btnChooseProductClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TProductListExpressGUI', OnChooseProduct , InitProductList);
end;
Procedure TAppointmentGUI.OnChooseProduct(Sender: TwwDbGrid);
var
  ds : TDataSet;
begin
  ds := Sender.DataSource.DataSet;
  Appointment.ProductId := ds.FieldByName('PartsID').AsInteger;
end;
procedure TAppointmentGUI.btnContactsClick(Sender: TObject);
begin
  inherited;
//  OpenERPListFormSingleselectModal('TContactListGUI' ,UpdateFromContact , initcontactList );
  OpenERPListFormSingleselectModal('TContactListGUI', UpdateFromContact, initcontactList );
end;

procedure TAppointmentGUI.cmdNewClick(Sender: TObject);
var
  x: integer;
begin
  DisableForm;
  try
    if SaveAndCommit(True) then begin
      AppEnv.GoogleUpdater.UpdateCalendar(Appointment.Id, AppEnv.ServerID);
      for x := 0 to AppIdList.Count -1 do
        AppEnv.GoogleUpdater.UpdateCalendar(AppIdList.Item[x], AppEnv.ServerID);
      AppIdList.Clear;
      NewData;
    end;
  finally
    EnableForm;
  end;    
end;

procedure TAppointmentGUI.cmdPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print the Appointment',PrintAppointment, false, true);

    OptsForm.ActionList.AddDivider('Email');
    OptsForm.ActionList.Add('Email Appointment', 'Email a Copy of the Appointment', self.SendEmail, false, true);
    OptsForm.ActionList.Add('Email Silently', 'Email a Copy of the Appointment Silently',SendSilentEmail, false, true);
    if AppEnv.CompanyPrefs.EnableAppointmentPrintEmail  then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Appointment', self.SendMessageEmailSilent, false, true);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Appointment', self.SendMessageEmail, false, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Appointment', self.SendMessageEmailSilent, false, false);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Appointment', self.SendMessageEmail, false, false);
    end;
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Appointment', self.SendMessageEmail, false, true);

    OptsForm.ActionList.AddDivider('SMS');

    IsEnabled := (AppEnv.CompanyPrefs.SMSEnabled and (AppEnv.CompanyPrefs.EnableAppointmentPrintSMS or AppEnv.CompanyPrefs.EnableAppointmentRepPrintSMS));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendMessageSMSSilentBoth, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendMessageSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

procedure TAppointmentGUI.SetStartAndEndTimeIncrements;
begin
  PopulateTimecombo(txtStartTime);
  PopulateTimecombo(txtEndTime);
  PopulateTimecombo(txtActualStartTime);
  PopulateTimecombo(txtActualEndTime);
end;

procedure TAppointmentGUI.cboEmployeeDblClick(Sender: TObject);
var
  Form: TForm;
  MsgObj: TMsgObj;
begin
  Form := TForm(GetComponentByClassName('TfrmRep'));
  if Assigned(Form) then begin
    MsgObj := TMsgObj.Create;
    try
      MsgObj.ClassStr := 'TfrmRep';
      MsgObj.MethodStr := 'LoadFromAppNoServices';
      MsgObj.SenderStr := Self.ClassName;
      MsgObj.IntValue := Appointment.TrainerID;
      fMsgHandler.Send(MsgObj, MsgObj);
    Finally
      FreeAndNil(MsgObj);
    end;
    Form.FormStyle := fsMDIChild;
    Form.BringToFront;
    ServiceQuestionAsked := True;
    fbEnforceRepToFront := True;
  end;
end;

procedure TAppointmentGUI.btnRepeatClick(Sender: TObject);
var 
  tblRepeat: TERPQuery;
  ID: integer;
  Result: Boolean;
  IdList: TIntegerList;
  x: integer;
  SynchWithGoogle: boolean;
  lMaxId : integer;

  procedure InsertRecords(const dates: array of TDateTime);
  var
    iCnt, Index: integer;
    stime, etime: TDateTime;
  begin
    try
      stime := TimeOf(tblMaster.FieldByName('STARTTIME').AsDateTime);
      etime := TimeOf(tblMaster.FieldByName('ENDTIME').AsDateTime);
      for iCnt := 0 to Length(dates) - 1 do begin
        tblRepeat.Append;
        for Index := 0 to tblMaster.FieldCount - 1 do begin
          if (tblMaster.Fields[Index].FieldKind = fkData) and
             (not Sysutils.SameText(tblMaster.Fields[Index].FieldName, 'AppointID')) and
             (not Sysutils.SameText(tblMaster.Fields[Index].FieldName, 'msTimeStamp')) then begin
            tblRepeat.FieldByName(tblMaster.Fields[Index].FieldName).AsVariant := tblMaster.Fields[Index].AsVariant;
          end;
        end;
        tblRepeat.FieldByName('GoogleId').Clear;
        tblRepeat.FieldByName('GoogleUpdated').Clear;
        tblRepeat.Post;
        tblRepeat.Edit;
        tblRepeat.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + tblRepeat.FieldByName('AppointID').AsString;
        tblRepeat.FieldByName('STARTTIME').AsDateTime := DateOf(dates[iCnt]) + stime;
        tblRepeat.FieldByName('ENDTIME').AsDateTime := DateOf(dates[iCnt]) + etime;
        tblRepeat.FieldByName('AppDate').AsDateTime := dates[iCnt];
        tblRepeat.FieldByName('CreationDate').AsDateTime := Date;
        tblRepeat.FieldByName('UpdateDate').AsDateTime := Date;
        tblRepeat.FieldByName('Cancellation').AsString := 'F';
        tblRepeat.FieldByName('Reschedulled').AsString := 'F'; // reschedulled????
        tblRepeat.FieldByName('Feedback').AsString := 'F';
        tblRepeat.FieldByName('Converted').AsString := 'F';
        tblRepeat.FieldByName('Unavailable').AsString := 'F';
        tblRepeat.FieldByName('Active').AsBoolean := True;
        tblRepeat.FieldByName('LinkAppointID').AsInteger := ID;
        tblRepeat.FieldByName('IsGroupParent').AsString := 'F';
        tblRepeat.FieldByName('SynchWithGoogle').AsBoolean := SynchWithGoogle;
        tblRepeat.Post;
        IdList.Add(tblRepeat.FieldByName('AppointID').AsInteger);
      end;
      tblRepeat.Close;
      CommonLib.MessageDlgXP_Vista(Format('Inserted %d Repeats into Appointments Table', [Length(dates)]), mtInformation , [mbOK], 0);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  end;
begin
  if not(Appointment.Active) then begin
     MessageDlgXP_vista('This is a Deleted Appointemnt. It is not possible to convert this to Invocie.', mtInformation, [mbOK], 0);
    Exit;
  end;
  DisableForm;
  IdList := TIntegerList.Create;
  try
    Result := False;
    if SaveAndCommit(False, True) then begin
      SynchWithGoogle := Appointment.SynchWithGoogle;
      with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do
      try
          StartBaseDate :=  Appointment.AppDate;
          Caption := 'Repeat Appointment';
          ShowModal;
          if ModalResult = mrOk then begin
            Appointment.IsGroupParent := True;
            Appointment.PostDb;
            ID := Appointment.Id;
            tblRepeat := TERPQuery.Create(self);
            try
              tblRepeat.Connection := tblMaster.Connection;

              // Get max AppointId - need to avoid select *, we had Out Of Memory on it
              tblRepeat.SQL.Text := 'SELECT Max(AppointId) FROM tblAppointments';
              tblRepeat.Open;
              if tblRepeat.RecordCount > 0 then
                lMaxId := tblRepeat.Fields[0].AsInteger
              else
                lMaxId := 1;
              tblRepeat.Close;

//              tblRepeat.SQL.Text := 'SELECT * FROM tblappointments';
              tblRepeat.SQL.Text := 'SELECT * FROM tblappointments where AppointId >' + IntToStr(lMaxId);
              tblRepeat.Open;
              InsertRecords(dates);
              Result := True;
            finally
              FreeandNil(tblRepeat);
            end;
          end;
      finally
        Free;
      end;
    end;
    if Result then
      if SaveAndCommit(False, False) then begin
        for x := 0 to IdList.Count -1 do
          AppEnv.GoogleUpdater.UpdateCalendar(IdLIst[x], AppEnv.ServerID);
        Close;
      end;
  finally
    IdList.Free;
    EnableForm;
  end;
end;

procedure TAppointmentGUI.PopulateMessageSubstituteList(SL: TStringList);
begin
  SL.Values['#Company#'] := Appointment.ClientName;
  SL.Values['#Date#'] := DateToStr(Appointment.AppDate);
  SL.Values['#StartTime#'] := TimeToStr(Appointment.StartTime);
  SL.Values['#EndTime#'] := TimeToStr(Appointment.EndTime);
end;

procedure TAppointmentGUI.PrepareEmailText(var Recipient, Subject, Text : string);
var
  i, j: integer;
  recipientType: string;
begin
      recipientType := CMessageDlg('Create Email for ...', mtConfirmation, 'Rep', 'Company', 'Cancel');

      if recipientType = 'Cancel' then Exit;

      if recipientType = 'Company' then recipient := Appointment.ClientEmail
      else recipient := Appointment.RepEmail;

      if recipient = '' then  begin
        commonlib.MessageDlgXP_Vista('Email address is blank.', mtInformation, [mbOk],0);
        exit;
      end;

      subject := 'Appointment ' + FormatDateTime('ddd dd. mmm hh:nn am/pm', Appointment.StartTime);

      if Appointment.Reschedulled then subject := subject + ' (Rescheduled)';

      if Appointment.Cancellation then subject := subject + ' - CANCELLED ';

      for i := 0 to txtClientDetails.Lines.Count - 1 do begin
        // '&' stuffs up in Outlook Express
        for j := 1 to char_length(txtClientDetails.Lines[i]) do begin
          if txtClientDetails.Lines[i][j] <> '&' then Text := Text + txtClientDetails.Lines[i][j]
          else Text := Text + '+';
        end;
        Text := Text + #13#10;
      end;

      if recipientType = 'Company' then begin
        if Appointment.Reschedulled then Text := Text +
            #13#10'I am writing to confirm our rescheduled appointment for'
        else Text := Text + #13#10'I am writing to confirm our appointment for';
        Text := Text + #13#10 + FormatDateTime('   dddd dd. mmmm  hh:nn am/pm', Appointment.StartTime);
      end else begin
        Text := Text + #13#10'Phone: ' + Appointment.Phone;
        if tblMasterAltPhone.AsString <> '' then Text := Text + #13#10'Alt Phone ' + Appointment.AltPhone;
        Text := Text + #13#10'Time: ' + Appointment.Start_time + ' - ' + Appointment.End_time;
      end;

      if Appointment.Cancellation then Text := Text + #13#10'has been CANCELLED.';
end;

procedure TAppointmentGUI.PrintApp(const AppointID: integer);
var
  sReportName, sSQL: string;
begin
  if Appointment.Cancellation and Appointment.Reschedulled then begin
    sReportName := 'Appointment R & C';
  end else if Appointment.Reschedulled then begin
    sReportName := 'Appointment Resched';
  end else if Appointment.Cancellation then begin
    sReportName := 'Appointment Cancel';
  end else begin
    sReportName := 'Appointment';
  end;

  sSql := Format('~|||~ WHERE tblAppointments.AppointID = %d', [AppointID]);
  PrintTemplateReport(sReportName, sSQL, not AppEnv.Employee.ShowPreview, 1);

  if AppEnv.CompanyPrefs.PrintBestPractices then begin
    sReportName := 'Best Practices';
    sSQL        := Format(' AND d2.AppointID = %d', [AppointID]);
    PrintTemplateReport(sReportName, sSQL, not AppEnv.Employee.ShowPreview,1);
  end;
  {report merged into the main appointment template}
  {if CompanyPref.PrintEquipment then  begin
    sReportName := 'Equipment Report';
    sSQL := Format(' WHERE tblAppointments.AppointID = %d', [AppointID]);
    PrintTemplateReport(sReportName, sSQL, not Employee.ShowPreview, CompanyPref.PrintEquipmentCount);
  end;}
end;

procedure TAppointmentGUI.PrintAppointment;
begin
  DisableForm;
  try
    if SaveAndCommit(False, True) then
      PrintApp(Appointment.Id);
  finally
    self.BeginTransaction;
    EnableForm;
  end;
end;

procedure TAppointmentGUI.qryAppointmentsTimeLogBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryAppointmentsTimeLogStartDatetime.Displayformat := FormatSettings.ShortDateformat +' HH/NN AM/PM';
  qryAppointmentsTimeLogEndDatetime.Displayformat   := FormatSettings.ShortDateformat +' HH/NN AM/PM';
end;

procedure TAppointmentGUI.cboChargeRateBeforeDropDown(Sender: TObject);
begin
  inherited;
  if Appointment.TrainerID = 0 then Abort;
  GetChargeRateDetails;
end;

procedure TAppointmentGUI.actPOSUpdate(Sender: TObject);
begin
  //actPOS.Enabled := (tblMasterTotalInc.AsFloat > 0);
end;

procedure TAppointmentGUI.actPOSExecute(Sender: TObject);
var
  iClientID: Integer; // Client to bill for services
  strMsg: string;
  dTotalHours, AdjustedTotalHours: Double;
  Form: TComponent;
  procedure  AdjustOutstandingHours;
  var
    lClient: TClient;
  begin
    AdjustedTotalHours := 0;
    {when the preference is off, should not consider the customer free hours - dene }
    //if companypref.ShowServiceHrsInInvoiceQty = False then begin
    if Appointment.Service.IsFixedRate then
      AdjustedTotalHours := dTotalHours
    else begin
      {client's hours is updated only when the POS is saved}
      lClient := TClient.Create(nil);
      try
        lClient.Load(iClientID , true);
        if lClient.Hours > 0 then begin
          if lClient.Hours >= dTotalHours then begin
            AdjustedTotalHours := 0;
          end else begin
            AdjustedTotalHours := dTotalHours - lClient.Hours;
          end;
        end else
          AdjustedTotalHours := dTotalHours;
      finally
        FreeandNil(lClient);
      end;
    end;
  end;

begin
  DisableForm;
  try
    if not IsActualsUpdated then Exit;
    if not Appointment.ValidateForInvoicing then Exit;
    strmsg := '';
    if Appointment.Rate = 0 then
      strmsg := 'You have selected a service with 0 Charge Rate.'#13#10;
    if (CommonLib.MessageDlgXP_Vista(StrMsg + 'Are you sure you want to convert this Appointment to a POS transaction?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;

    if not SaveAndCommit(False, True) then Exit;

    if FormStillOpen('TPosScreenForm') then begin
      if not TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).bTransComplete then begin
        CommonLib.MessageDlgXP_Vista('POS is currently in a transaction, ' +
          'wait until the POS transaction ' + #13 + #10 + 'is complete',
          mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
    if Appointment.Service.ClientID <> 0 then
      iClientID := Appointment.Service.ClientID
    else begin
      iClientID := Appointment.ClientID;
      if not Appointment.Client.Customer then begin
        Appointment.Client.Customer := True;
        Appointment.Client.PostDb;
      end;
    end;
    try
      if SaveAndCommit(False, True) then begin
        dTotalHours := Appointment.Actual_TotalHours;
        AdjustOutstandingHours;

        if not FormStillOpen('TPOSScreenForm') then begin  // start up POS
          Form := GetComponentByClassName('TPOSScreenForm');
          if Assigned(Form) then begin
            with TForm(Form) do begin
              FormStyle := fsMDIChild;
              BringToFront;
            end;
          end;
        end else begin
          with TForm(FindExistingComponent('TPOSScreenForm')) do begin
            Show;
            BringToFront;
          end;
        end;

        if FormStillOpen('TPOSScreenForm') then begin
          Form := FindExistingComponent('TPOSScreenForm');
          if Assigned(Form) then begin
            //TPOSScreenForm(Form).AppointmentTotalHours := StrValue(txtTotalTime.Text);
            //TPOSScreenForm(Form).AppointmentTotalHours := StrValue(txtHrsToInvoice.Text);
            if not Appointment.Service.IsFixedRate then begin
              TPOSScreenForm(Form).AppointmentTotalHours := AdjustedTotalHours;
              TPOSScreenForm(Form).AppointmentFreeHours  := dTotalHours - AdjustedTotalHours;
            end else begin
              TPOSScreenForm(Form).AppointmentTotalHours := 1;
              TPOSScreenForm(Form).AppointmentFreeHours  := 0;
            end;
            TPOSScreenForm(Form).AppointmentRate       := Appointment.Rate;
            TPOSScreenForm(Form).AppointID             := Appointment.Id;
          end;
          {if tblMaster.State in [dsEdit,dsInsert] then else tblMaster.Edit;
          tblMaster.FieldByName('Converted').AsBoolean := true;
          SaveData;}
          Self.Close;
        end;
      end;
    except
      on EAbort do HandleEAbortException;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TAppointmentGUI.actInvoiceUpdate(Sender: TObject);
begin
  //actInvoice.Enabled := (tblMasterTotalInc.AsFloat > 0);
end;
Function  TAppointmentGUI.IsActualsUpdated:Boolean ;
begin
    Result := true;
    if (txtActual_appDate.Text = '') or (txtActualStarttime.Text = '') or (txtActualEndTime.Text = '') then begin
      if CommonLib.MessageDlgXP_Vista('The actual appointment date/time not given. Do you wish to copy the ''Booked Date/time'' to the ''Actual Date/Time'' ?' , mtconfirmation , [mbYes, mbNo], 0) = mrNo then begin
        Result := False;
        exit;
      end;

      Appointment.Actual_StartTime := Appointment.StartTime;
      Appointment.Actual_EndTime := Appointment.EndTime;
    end;
end;
procedure TAppointmentGUI.actInvoiceExecute(Sender: TObject);
var
  strMsg: string;
  iInvoiceID: Integer;
  Form: TBaseInputGUI;
//  MsgObj: TMsgObj;
begin
  DisableForm;
  try
    Appointment.PostDB;
    if not IsActualsUpdated then Exit;
    if not Appointment.ValidateForInvoicing then Exit;

    strmsg := '';
    if Appointment.Rate = 0 then
      strmsg := 'You have selected a service with 0 Charge Rate.'#13#10;
    if (CommonLib.MessageDlgXP_Vista(StrMsg + 'Are you sure you want to Invoice this Appointment?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;

    if not SaveAndCommit(False, True) then exit;

    if Appointment.ConvertToInvoice(iInvoiceID) then begin
      Appointment.Connection.CommitTransaction;
      if AppEnv.CompanyPrefs.ShowInvoiceFormwhenApptInvoiced then begin
          Form := TBaseInputGUI(GetComponentByClassName('TInvoiceGUI'));
          if Assigned(Form) then begin
            Form.KeyID := iInvoiceID;
            Form.FormStyle := fsMDIChild;
            Form.BringToFrontSoon;
          end;
      end;

      GlobalEvents.Notify(Self, GEVENT_TransConvertedtoInvoice);
      Self.Close;
    end else begin
      Appointment.Connection.RollbackTransaction;
      Appointment.Connection.BeginTransaction;
    end;
  finally
    Appointment.ResultStatus.Clear;
    EnableForm;
  end;  
end;

procedure TAppointmentGUI.cboChargeRateNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: Boolean);
begin
  Accept := strValue(NEWValue) > 0;
  inherited;; // do not remove - don't want not-in-list processing
end;

procedure TAppointmentGUI.cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: Boolean);
begin
  inherited;
  Accept := false;
  NotInListWarning(Sender);
end;

procedure TAppointmentGUI.cboLastEmployeeNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept := false;
  NotInListWarning(Sender);
end;

procedure TAppointmentGUI.cboClientChange(Sender: TObject);
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;


procedure TAppointmentGUI.cboClientLookupCalcFields(DataSet: TDataSet);
begin
  inherited;
  If cboClientLookupStopCredit.AsString = 'T' then
    cboClientLookupStopCreditImage.AsInteger := 0
  else
    cboClientLookupStopCreditImage.AsInteger := 1;
end;

procedure TAppointmentGUI.cboClientDblClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;

  if Empty(cboClient.Text) then begin
    //List
    foCombo := cboClient;
    if not FormStillOpen('TCustomerListGUI') then begin
      Form := GetComponentByClassName('TCustomerListGUI');
      if Assigned(Form) then begin
        with TBaseListingGUI(Form) do begin
            FormStyle := fsMDIChild;
            OnGridDataSelect := OnCustomerSelect;
        end;
      end;
    end else begin
      TBaseListingGUI(FindExistingComponent('CustomerListGUI')).Show;
    end;

//    if not Assigned(CustomerListGUI) then begin
//      CustomerListGUI := TCustomerListGUI.Create(Self);
//      CustomerListGUI.FormStyle := fsMDIChild;
//      CustomerListGUI.OnGridDataSelect := OnCustomerSelect;
//    end else begin
//      CustomerListGUI.Show;
//    end;
    Exit;
  end else begin
    //Entry Form
    if (cboClientLookup.FieldByName('IsJob').AsString = 'T') then begin
      Form := GetComponentByClassName('TJobGUI');
      if Assigned(Form) then begin
        with TBaseInputGUI(Form) do begin
          KeyID := Appointment.ClientID;
          AttachObserver(Self);
          FormStyle := fsMDIChild;
          BringToFront;
          Exit;
        end;
      end;
    end else if (cboClientLookup.FieldByName('Customer').AsString = 'T') then begin
      Form := GetComponentByClassName('TfrmCustomer');
      if Assigned(Form) then begin
        with TBaseInputGUI(Form) do begin
          KeyID := Appointment.ClientID;
          AttachObserver(Self);
          FormStyle := fsMDIChild;
          BringToFront;
          Exit;
        end;
      end;
    end else if (cboClientLookup.FieldByName('Supplier').AsString = 'T') then begin
      Form := GetComponentByClassName('TfmSupplier');
      if Assigned(Form) then begin
        with TBaseInputGUI(Form) do begin
          KeyID := Appointment.ClientID;
          AttachObserver(Self);
          FormStyle := fsMDIChild;
          BringToFront;
          Exit;
        end;
      end;
    end else if (cboClientLookup.FieldByName('OtherContact').AsString = 'T') then begin
      Form := GetComponentByClassName('TfrmOtherContact');
      if Assigned(Form) then begin
        with TBaseInputGUI(Form) do begin
          KeyID := Appointment.ClientID;
          AttachObserver(Self);
          FormStyle := fsMDIChild;
          BringToFront;
          Exit;
        end;
      end;
    end;
  end;
end;

// customer list select event handler

procedure TAppointmentGUI.OnCustomerSelect(Sender: TwwDbGrid);
begin
  Appointment.ClientID := Sender.DataSource.DataSet.FieldByName('ClientID').AsInteger;
end;

procedure TAppointmentGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  Notify;
end;

procedure TAppointmentGUI.cboClientLookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //cboClientLookup.IndexFieldNames := 'Company ASC CIS';
end;

procedure TAppointmentGUI.cboChargeRateEnter(Sender: TObject);
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  GetChargeRateDetails;
end;

procedure TAppointmentGUI.FormDestroy(Sender: TObject);
begin
  NotifyWaitingForm;
  FreeAndNil(fMsgHandler);
  FreeandNil(RepIdList);
  AppIdList.Free;
  inherited;
end;

procedure TAppointmentGUI.UpdateFromContact(Sender: TwwDbGrid);
var
  ds : TDataSet;
  lStr : string;
  lPos : integer;
begin
//
//  cboClientLookup.Locate('ClientId', Sender.Datasource.dataset.FieldByName('ContactID').AsInteger, []);
  ds := Sender.DataSource.DataSet;
  // if in a new appointment contact was selected before anything else
  if Appointment.ClientId = 0 then
    Appointment.ClientId := ds.FieldByName('ClientId').AsInteger;

  Appointment.Phone := ds.FieldByName('ContactPH').AsString;
  Appointment.AltPhone := ds.FieldByName('ContactAltPh').asString;
  Appointment.Fax := ds.FieldByName('ContactFax').asString;
  Appointment.Mobile := ds.FieldByName('ContactMOB').asString;
  lStr := ds.FieldByName('ContactTitle').asString + ' ' + ds.FieldByName('ContactFirstName').asString + ' ' +
     ds.FieldByName('ContactSurName').asString;
  lStr := Trim(lStr);
  lPos := Pos('  ', lStr);
  while lPos > 0 do
  begin
    Delete(lStr, lPos, 1);
    lPos := Pos('  ', lStr);
  end;

  lStr := lStr + #13#10 + ds.FieldByName('ClientName').AsString;  // actually it is Company
  if Length(ds.FieldByName('ContactAddress').AsString) > 0 then
    lStr := lStr + #13#10 + ds.FieldByName('ContactAddress').AsString;
  if Length(ds.FieldByName('ContactAddress2').AsString) > 0 then
    lStr := lStr + #13#10 + ds.FieldByName('ContactAddress2').AsString;
  if Length(ds.FieldByName('ContactAddress3').AsString) > 0 then
    lStr := lStr + #13#10 + ds.FieldByName('ContactAddress3').AsString;
  if Length(ds.FieldByName('ContactCity').AsString) > 0 then
    lStr := lStr + #13#10 + ds.FieldByName('ContactCity').AsString;
  if Length(ds.FieldByName('ContactState').AsString) > 0 then
  begin
    lStr := lStr + #13#10 + ds.FieldByName('ContactState').AsString + ' ' +
            ds.FieldByName('ContactPCode').asString;
  end
  else if Length(ds.FieldByName('ContactPCode').AsString) > 0 then
    lStr := lStr + #13#10 + ds.FieldByName('ContactPCode').AsString;
  if Length(ds.FieldByName('ContactCountry').AsString) > 0 then
    lStr := lStr + #13#10 + ds.FieldByName('ContactCountry').AsString;

  Appointment.CustomerDetails := lStr;
end;

procedure TAppointmentGUI.UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);
begin
  inherited;
  if Cancelled then begin
    {if Assigned(fLastComboAccessed) then begin
      (*fLastComboAccessed.Text := '';
      if Sysutils.SameText(fLastComboAccessed.Name, 'cboClient') then begin
        txtClientDetails.Clear;
        txtClientDetails.DataSource.DataSet.Close;
        txtClientDetails.DataSource.DataSet.Open;
      end;*)
      CloseDB(fLastComboAccessed.LookupTable);
      openDB(fLastComboAccessed.LookupTable);
    end;}
    onUpdateMe_Cancelled;
  end else if Assigned(aObject) and (aObject is TBaseInputGUI) and Assigned(fLastComboAccessed) then begin
    if Sysutils.SameText(fLastComboAccessed.Name, 'cboClient') then begin
      with fLastComboAccessed do begin
        //LookupTable.Close;
//        TERPQuery(LookupTable).ParamByName('SelectedClient').AsInteger := TBaseInputGUI(aObject).KeyID;
        if aObject is TfmSupplier then begin
          TERPQuery(LookupTable).ParamByName('SearchValue').AsString :=
            TfmSupplier(aObject).qrySupplier.FieldByName('Company').AsString;
        end
        else if aObject is TFrmOtherContact then begin
          TERPQuery(LookupTable).ParamByName('SearchValue').AsString :=
            TFrmOtherContact(aObject).qryCustomers.FieldByName('Company').AsString;
        end;

        //LookupTable.Open;
        LookupTable.Refresh;
        if LookupTable.Locate('ClientID', TBaseInputGUI(aObject).KeyID, []) then begin
          try
            EditDB(DataSource.DataSet);
          except
          end;

          if DataSource.DataSet.State in [dsEdit, dsInsert] then begin
            DataSource.DataSet.FieldByName('CusID').AsInteger := TBaseInputGUI(aObject).KeyID;
            cboClientCloseup(fLastComboAccessed, LookupTable, DataSource.DataSet, true);
          end;
        end;
      end;

    end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboChargeRate') then begin
      CloseDB(fLastComboAccessed.LookupTable);
      OpenDb(fLastComboAccessed.LookupTable);
    end;
  end;
end;

procedure TAppointmentGUI.CompleteComboNotInList(const aObserver: TObject);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
  InComboNotinList := False;
end;

procedure TAppointmentGUI.SetComboFocus(var Msg: TMessage);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
end;


procedure TAppointmentGUI.GroupAptdates(const Value: array of TDateTime);
var
  ctr:Integer;
begin
  SetLength(fdGroupAptdates , length(Value));
  for ctr:= low(Value) to high(Value) do
    fdGroupAptdates[ctr] := value[ctr];
end;

procedure TAppointmentGUI.cboRescheduledDateCloseUp(Sender: TObject);
begin
  inherited;
  if Appointment.RescheduledDate <> 0 then begin
    lblRescheduleLabel.Visible    := Appointment.Reschedulled;
    edtlblRescheduleLabel.Visible := Appointment.Reschedulled;
  end;
  ComboCloseUp(Sender);
end;

procedure TAppointmentGUI.SchedulePageControlResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(SchedulePageControl, 1);
end;

procedure TAppointmentGUI.ServiceListClickCheck(Sender: TObject);
begin
  inherited;
  if not MyConnection.InTransaction then Exit;
  if Appointment.TrainerID = 0 then Exit;

  if ServiceList.Checked[ServiceList.ItemIndex] then
    Appointment.ServiceID := Integer(Pointer(ServiceList.Items.Objects[ServiceList.ItemIndex]))
  else
    Appointment.ServiceID := 0;

  SchedulePageControl.ActivePage := TabSheet1;
end;

procedure TAppointmentGUI.ServiceSearchChange(Sender: TObject);
begin
  inherited;
  if AvailableServices.FindService(ServiceSearch.Text) then
    Appointment.ServiceID := AvailableServices.ServiceID;
end;

procedure TAppointmentGUI.SchedulePageControlChange(Sender: TObject);
begin
  inherited;
  if SchedulePageControl.ActivePageIndex = 1 then begin
    SetControlFocus(ServiceSearch);
  end else if SchedulePageControl.ActivePageIndex = 3 then begin
    CustomFieldsRefresh;
  end else if (SchedulePageControl.ActivePage = TTabSheet(tabEquipment)) then begin
    Appointment.Equipment;
    EquipmentxRefForm := TfmEquipmentxRef.CreateEquipmentxREf(Self , tblDetails,AccessLevel = 5, '' , Appointment.clientid,98);
    if assigned(EquipmentxRefForm) then begin
      EquipmentxRefForm.Pnlfooter.visible := false;
      EquipmentxRefForm.Align             := alclient;
      EquipmentxRefForm.Parent            := pnlEquipments;
      EquipmentxRefForm.BorderStyle       := bsNone;
      EquipmentxRefForm.EquipmentxRef   := Appointment.Equipment;
      EquipmentxRefForm.show;
    end;
  end;
end;

procedure TAppointmentGUI.speColumnsChange(Sender: TObject);
var
  UpdateColmnQry: TERPQuery;
begin
  inherited;

  UpdateColmnQry := TERPQuery.Create(nil);
  UpdateColmnQry.Options.FlatBuffers := True;
  try
    UpdateColmnQry.Connection := CommonDbLib.GetSharedMyDacConnection;
    UpdateColmnQry.SQL.Add(' UPDATE tblpersonalpreferences');
    UpdateColmnQry.SQL.Add(' SET AppointmentServiceColumns = ' + IntToStr(speColumns.Value) + ' ');
    UpdateColmnQry.SQL.Add(' WHERE EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID) + ' ');
    PreferancesLib.DoPrefAuditTrail;
    UpdateColmnQry.Execute;
  finally
    FreeAndNil(UpdateColmnQry);
  end;

  if speColumns.Value < 2 then ServiceList.Columns := 0
  else ServiceList.Columns := speColumns.Value;
end;

procedure TAppointmentGUI.SetServiceListColumnCount;
var
  ColumnQry: TERPQuery;
begin
  ColumnQry := TERPQuery.Create(nil);
  ColumnQry.Options.FlatBuffers := True;
  try
    ColumnQry.Connection := CommonDbLib.GetSharedMyDacConnection;
    ColumnQry.SQL.Add(' SELECT AppointmentServiceColumns ');
    ColumnQry.SQL.Add(' FROM tblpersonalpreferences ');
    ColumnQry.SQL.Add(' WHERE EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID) + ' ');
    ColumnQry.Execute;

    if ColumnQry.RecordCount > 0 then begin
      ColumnQry.First;
      speColumns.Value := ColumnQry.FieldByName('AppointmentServiceColumns').AsInteger;
      if speColumns.Value < 2 then ServiceList.Columns := 0
      else ServiceList.Columns := speColumns.Value;
    end;
  finally
    FreeAndNil(ColumnQry);
  end;
end;

procedure TAppointmentGUI.cboCancellationReasonNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Would you like to add this Cancellation Reason to the list?',
    mtInformation, [mbYes,mbNo], 0) = mrYes then begin

    tcDataUtils.InsertSimpleTypeRecord(SimpleTypes_AppointmentCancellationType,NewValue,'',false,true);
    qryCancellationReason.Close;
    qryCancellationReason.Open;
    cboCancellationReason.Text := NewValue;
  end
  else begin
    Accept:= false;
  end;
end;

procedure TAppointmentGUI.btnFaxClick(Sender: TObject);
var
  Fax: TFaxObj;
  sCompany, sReportName, sSQL: string;
begin
  DisableForm;
  try
    inherited;

    sCompany := cboClientLookup.FieldByName('Company').AsString;
    ProcessingCursor(True);
    try
      if SaveAndCommit(False, True) then begin
        if Empty(txtFax.Text) then begin
          CommonLib.MessageDlgXP_Vista(sCompany + ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
            'Please Review Customer information to Add an Fax Number.', mtWarning, [mbOK], 0);
        end else begin
          {lblEmail.Visible := true;
          lblEmail.Caption := 'Adding to Fax Spool...';}

          if (chkCancellation.Checked = true) and (chkRescheduled.Checked = true) then begin
            sReportName := 'Appointment R & C';
          end else if (chkRescheduled.Checked = true) then begin
            sReportName := 'Appointment Resched';
          end else if (chkCancellation.Checked = true) then begin
            sReportName := 'Appointment Cancel';
          end else begin
            sReportName := 'Appointment';
          end;

          //fbReportSQLSupplied := true;

          sSql := Format(' WHERE tblAppointments.AppointID = %d', [tblMasterAppointID.AsInteger]);
          SaveTemplateReport(sReportName, sSQL,
            not AppEnv.Employee.ShowPreview, 'GraphicFile',
            'Booking_' + IntToStr(tblMasterAppointID.AsInteger));
          fbReportSQLSupplied := false;

          Fax := TFaxObj.Create;
          try
            Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
              sCompany,
              txtFax.Text, 'Appointment',
              IntToStr(tblMasterAppointID.AsInteger), 'Appointment',
              ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
          finally
            FreeandNil(Fax);
          end;
          {lblEmail.Visible := false;}
          DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
        end;
      end;
    finally
      ProcessingCursor(False);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TAppointmentGUI.cboFollowUpResultNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
// inherited;
  Accept := False;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_AppointmentStatusType,NewValue) then begin
      Accept:= true;
      LookupTable.Refresh;
    end;
  end;  
end;

procedure TAppointmentGUI.Label16DblClick(Sender: TObject);
begin
  inherited;
  TmrReminderhintTimer(TmrReminderhint);
end;

function TAppointmentGUI.LoadAppointment(aID: Integer; AskQuestion: Boolean): Boolean;
begin
  Result := SaveAndCommit(AskQuestion);
  if Result then begin
    Application.ProcessMessages;
    Appointment.UnLock;
    MyConnection.StartTransaction;
    Appointment.Load(aID);
    if Appointment.Unavailable then begin
        AccessLevel := 5; // read only
        timermsg(lblMsg , 'This is the Roster Entry to Indicate the Un-Availability.  Access Has Been Changed to Read-Only.', 30);
    end else if Appointment.LocalApp then begin
        AccessLevel := 5; // read only
        timermsg(lblMsg , 'This is the Go Live Appointment.  Access Has Been Changed to Read-Only.', 30);
    end else if not Appointment.Lock then begin
        AccessManager.AccessLevel:= 1;
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(Appointment.UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access Has Been Changed to Read-Only.',
          mtWarning, [mbOK], 0);
    end;
    Appointment.Equipment; // Ensure that Appointment.Equipment is open
    if (Appointment.Equipment.count = 0) and Appointment.Equipment.CanCreate then
      Appointment.Equipment.Dataset.Append;

    cmdEmail.Enabled := (Appointment.ClientEmail <> '') or (Appointment.RepEmail <> '');
    if accesslevel <=3 then begin
      if (Appointment.Start_time <> '') then
        AppCount.Text := IntToStr(Appointment.ClientAppointmentCount);
      RefreshAvailableServices(Self);
      Appointment.Recalculate;
      if (AppEnv.CompanyPrefs.CreditCheckAppointment = 'T') and Appointment.Active and not Appointment.Converted then begin
        Appointment.IsCustomerCreditOk;
        Appointment.IsCustomerTermsOk;
      end;
    end;
    cboRepLookup.Close;
    cboRepLookup.ParamByName('EmpID').AsInteger := Appointment.TrainerID;
    cboRepLookup.Open;
    cboEmployee.Enabled := True;
    chkDeleted.Enabled := True;
    lblRescheduleLabel.Visible := Appointment.Reschedulled;
    edtlblRescheduleLabel.Visible := Appointment.Reschedulled;
    lblConverted.Visible := Appointment.Converted;
  end;
end;

function TAppointmentGUI.SaveAndCommit(AskQuestion: Boolean; CommitRetaining: Boolean): Boolean;
var
  lResult: Word;
  lCommit: Boolean;
  lForm: TComponent;
  lIsNew: Boolean;
begin
  try
    Appointment.PostDb;

    Result := True;
    lCommit := False;
    lIsNew := Appointment.IsNew;

    if Appointment.Dirty then begin
      if AskQuestion then begin
        lResult := CommonLib.MessageDlgXP_Vista('Save changes to Appointment?', mtConfirmation, mbYesNoCancel, 0);
        case lResult of
          mrYes: lCommit := True;
          mrNo: begin end;
          mrCancel: Result := False;
        end;
      end else begin
        lCommit := True;
      end;
      if lCommit then begin
        if not Appointment.ValidateData then begin
          result:= false;
          exit;
        end;
        if not ChkCustReqdFields then begin
          REsult := False;
          exit;
        end;
        if Appointment.RescheduleWillOccurOnSave then begin
          lForm := GetComponentByClassName('TfmRescheduleAppt');
          if Assigned(lForm) then
            with TfmRescheduleAppt(lForm) do begin
              Position := poScreenCenter;
              SetRescheduleActions(Appointment.RescheduleActions);
              ShowModal;
              GetRescheduleActions(Appointment.RescheduleActions);
              Free;
            end
        end;
        { set silent so we dont get same messages from vlidate again }
        Appointment.SilentMode := true;
        try
          Result := Appointment.Save;
        finally
          Appointment.SilentMode := false;
        end;
        Appointment.ResultStatus.Clear;
      end;
    end;

    if Result then begin
      RepeatApptsforGroupAptdates;
      if lCommit then begin
        Appointment.Connection.CommitTransaction;
        if CommitRetaining then
          Appointment.Connection.BeginTransaction
        else
          AppointmentSaved(lIsNew);
        Notify;
      end else
        Appointment.Connection.RollbackTransaction;
    end;
  finally
    Appointment.ResultStatus.Clear;
  end;
end;
procedure TAppointmentGUI.RepeatApptsforGroupAptdates;
var
  ctr:Integer;
  stime, etime: TDateTime;
begin
  stime := TimeOf(Appointment.STARTTIME);
  etime := TimeOf(Appointment.ENDTIME);

  Appointment.FieldsnotToclone :=  'GoogleId,GoogleUpdated';
  if length(fdGroupAptdates)<=1 then exit;
  try
    Appointment.IsGroupParent := True;
    Appointment.PostDB;
    for ctr := 1 to high(fdGroupAptdates) do begin
      Appointment.Connection.BeginNestedTransaction;
      try
          if Appointment.CloneBusObj('AppDate' , fdGroupAptdates[ctr], False) <> nil then begin
            TAppointment(Appointment.ObjInstancetoclone).STARTTIME:= fdGroupAptdates[ctr] + stime;
            TAppointment(Appointment.ObjInstancetoclone).ENDTIME:= fdGroupAptdates[ctr] + etime;
            TAppointment(Appointment.ObjInstancetoclone).AppDate:= fdGroupAptdates[ctr];
            TAppointment(Appointment.ObjInstancetoclone).LinkAppointID:= Appointment.ID;
            TAppointment(Appointment.ObjInstancetoclone).IsGroupParent := False;
            TAppointment(Appointment.ObjInstancetoclone).PostDB;
            (*TAppointment(Appointment.ObjInstancetoclone).CreationDate:= Date;
            TAppointment(Appointment.ObjInstancetoclone).UpdateDate:= Date;
            TAppointment(Appointment.ObjInstancetoclone).Cancellation:= fAlse;
            TAppointment(Appointment.ObjInstancetoclone).Reschedulled:= False;
            TAppointment(Appointment.ObjInstancetoclone).Feedback:= False;
            TAppointment(Appointment.ObjInstancetoclone).Converted:= False;
            TAppointment(Appointment.ObjInstancetoclone).Unavailable:= False;
            TAppointment(Appointment.ObjInstancetoclone).IsGroupParent:= False;
            TAppointment(Appointment.ObjInstancetoclone).SynchWithGoogle:= False;*)
            if TAppointment(Appointment.ObjInstancetoclone).save then Appointment.Connection.CommitNestedTransaction
            else Appointment.Connection.RollbackNestedTransaction;
          end;
      Except
        on E : Exception do begin
          Appointment.Connection.RollbackNestedTransaction;
        end;
      end;
    end;
  finally
    SetLength(fdGroupAptdates , 0);
  end;
end;
procedure TAppointmentGUI.TmrReminderhintTimer(Sender: TObject);
begin
  inherited;
  pnlReminderhint.visible := False;
end;

procedure TAppointmentGUI.TotalsChanged(Sender: TObject);
begin
  txtTotalTime.Text := Appointment.TotalHoursStr;
  txtActualTotalTime.Text := Appointment.Actual_TotalHoursStr;
  if txtCallOutValue.Text = '' then
    Appointment.CalloutValue := 0.0;
  if (Appointment.Start_time <> '') then
    AppCount.Text := IntToStr(Appointment.ClientAppointmentCount);
  txtOutstandingHrs.Text := Format('%.2f', [Appointment.ClientHoursLeft]);
  txtHrsToInvoice.Text := Format('%.2f', [Appointment.HrsToInvoice]);
end;

procedure TAppointmentGUI.RefreshAvailableServices(Sender: TObject);
var
  Form: TForm;
  MsgObj: TMsgObj;
  i: Integer;
begin
  AvailableServices.Closedb;
  AvailableServices.LookupEmployeeID := Appointment.TrainerID;
  AvailableServices.LoadSelect(
    '((ifnull(TR.TrainRateID,0)=0) or (TR.EmployeeID = '+IntToStr(Appointment.TrainerID)+')) '+
            ' AND ((s.active = "T" ) OR (S.ServiceID = '+IntToStr(Appointment.ServiceID)+'))');

  if (AvailableServices.count = 0) and not DoingShow and not ServiceQuestionAsked then begin
    ServiceQuestionAsked := True;
    if CommonLib.MessageDlgXP_Vista('Do You Wish To Add A Service For This Rep?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      Form := TForm(GetComponentByClassName('TfrmRep'));
      if Assigned(Form) then begin
        MsgObj := TMsgObj.Create;
        Try
          MsgObj.ClassStr := 'TfrmRep';
          MsgObj.MethodStr := 'LoadFromAppNoServices';
          MsgObj.SenderStr := Self.ClassName;
          MsgObj.IntValue := Appointment.TrainerID;
          MsgObj.BoolValue := True; // Focus Rate_Info tab
          fMsgHandler.Send(MsgObj, MsgObj);
        Finally
          FreeAndNil(MsgObj);
        end;
        Form.FormStyle := fsMDIChild;
        Form.BringToFront;
        fbEnforceRepToFront := True;
      end;
    end;
  end;

  ServiceList.Clear;
  AvailableServices.IterateRecords(AddServiceCallback);
  i := ServiceList.Items.IndexOfObject(TObject(Pointer(Appointment.ServiceID)));
  ServiceList.ItemIndex := i;
  if i >= 0 then
    ServiceList.Checked[i] := True;

end;

procedure TAppointmentGUI.AddServiceCallback(const Sender: TBusObj; var Abort: Boolean);
var
  ServiceName: String;
begin
  If TServicesWithRate(Sender).ClientID=0 then
    ServiceName := TServicesWithRate(Sender).ServiceDescFixed
  else
    ServiceName := TServicesWithRate(Sender).ServiceDescFixed + ' - ' + GetClientName(TServicesWithRate(Sender).ClientID);


  ServiceList.AddItem(ServiceName, TObject(Pointer(TServicesWithRate(Sender).ServiceID)));
end;

procedure TAppointmentGUI.SendEmail;
var
  Text: string;
  subject: string;
  recipient: string;
begin
  DisableForm;
  try
    if not SaveAndCommit(False, True) then Exit;
    try

      PrepareEmailText(recipient, subject, text);

      sendPreparedEmail(Recipient, Subject, Text, true, false);

    finally
      self.BeginTransaction;
    end;
  finally
    EnableForm;
  end;
end;

procedure TAppointmentGUI.SendMessageEmail;
var
  recipientType, Recipient: string;
begin
  recipientType := CMessageDlg('Create Email for ...', mtConfirmation, 'Rep', 'Company', 'Cancel');

  if recipientType = 'Cancel' then Exit;

  if recipientType = 'Company' then recipient := Appointment.ClientEmail
  else recipient := Appointment.RepEmail;

  if recipient = '' then  begin
    commonlib.MessageDlgXP_Vista('Email Address is blank.', mtInformation, [mbOk],0);
    exit;
  end;

  if recipient = '' then exit;

  if SameText(recipientType,'Rep') then
    TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.TrainerID,rtEmployee)
  else begin
    if Appointment.Client.IsCustomer then
      TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtCustomer)
    else if Appointment.Client.IsSupplier then
      TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtSupplier)
    else if Appointment.Client.IsOtherContact then
      TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtOtherContact)
    else
      commonlib.MessageDlgXP_Vista('Could not send email, unknown client type.', mtInformation, [mbOk],0);
  end;

end;

procedure TAppointmentGUI.SendMessageEmailSilent;
var
  recipientType, Recipient: string;
begin
  recipientType := CMessageDlg('Create Email for ...', mtConfirmation, 'Rep', 'Company', 'Cancel');

  if recipientType = 'Cancel' then Exit;

  if recipientType = 'Company' then recipient := Appointment.ClientEmail
  else recipient := Appointment.RepEmail;

  if recipient = '' then  begin
    commonlib.MessageDlgXP_Vista('Email address is blank.', mtInformation, [mbOk],0);
    exit;
  end;

  if SameText(recipientType, 'Rep') then
    TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.TrainerID,rtEmployee, true)
  else begin
    if Appointment.Client.IsCustomer then
      TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtCustomer, true)
    else if Appointment.Client.IsSupplier then
      TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtSupplier, true)
    else if Appointment.Client.IsOtherContact then
      TCorrespondenceGui.Email(recipient, '',
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailSubject, PopulateMessageSubstituteList),
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintEmailText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtOtherContact, true)
    else
      commonlib.MessageDlgXP_Vista('Could not send email, unknown client type.', mtInformation, [mbOk],0);
  end;
end;

procedure TAppointmentGUI.SendMessageSMS;
var
  recipientType, Recipient: string;
  aClient: TClient;
  aEmp: TEmployee;
begin
  recipientType := CMessageDlg('Create SMS for ...', mtConfirmation, 'Rep', 'Company', 'Cancel');

  if recipientType = 'Cancel' then Exit;

  if recipientType = 'Company' then begin
    recipient := Appointment.ClientMobile;
    if (recipient = '') or (not SMSUtils.NumberHasCorrectPrefix(recipient, MyConnection)) then begin
      if (recipient = '') then
        recipient := GetMobileNumberFromUser('Company (' + Appointment.ClientName +
          ') does not have a mobile number.' +#13#10 + 'Please enter a number.')
      else
        recipient := GetMobileNumberFromUser('Company (' + Appointment.ClientName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.',recipient,MyConnection);
      if recipient <> '' then begin
        aClient := TClient.Create(nil);
        try
          aClient.Connection := TMyDacDataConnection.Create(aClient);
          aClient.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aClient.Load(Appointment.ClientID);
          if aClient.Lock then begin
            try
              aClient.Mobile := recipient;
              aClient.PostDb;
              Appointment.Client.RefreshDB;
            finally
              aClient.UnLock;
            end;
          end;
        finally
          aClient.Free;
        end;
      end;
    end;
  end
  else begin
    recipient := Appointment.RepMobile;
    if (recipient = '') or (not SMSUtils.NumberHasCorrectPrefix(recipient, MyConnection)) then begin
      if (recipient = '') then
        recipient := GetMobileNumberFromUser('Rep' +
          ' does not have a mobile number.' +#13#10 + 'Please enter a number.')
      else
        recipient := GetMobileNumberFromUser('Rep' +
          ' number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.',recipient,MyConnection);

      if recipient <> '' then begin
        aEmp := TEmployee.Create(nil);
        try
          aEmp.Connection := TMyDacDataConnection.Create(aEmp);
          aEmp.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aEmp.Load(Appointment.TrainerID);
          if aEmp.Lock then begin
            try
              aEmp.Mobile := recipient;
              aEmp.PostDb;
            finally
              aEmp.UnLock;
            end;
          end;
        finally
          aEmp.Free;
        end;
      end;
    end;
  end;

  if recipient = '' then exit;

  if SameText(recipientType,'Rep') then
    TCorrespondenceGui.SMS(recipient,
      TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
      Appointment.TrainerID,rtEmployee)
  else begin
    if Appointment.Client.IsCustomer then
      TCorrespondenceGui.SMS(recipient,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtCustomer)
    else if Appointment.Client.IsSupplier then
      TCorrespondenceGui.SMS(recipient,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtSupplier)
    else if Appointment.Client.IsOtherContact then
      TCorrespondenceGui.SMS(recipient,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtOtherContact)
    else
      commonlib.MessageDlgXP_Vista('Could not send SMS, unknown client type.', mtInformation, [mbOk],0);
  end;
end;

procedure TAppointmentGUI.SendMessageSMSSilent(const MsgTo: string = '');
var
  recipientType, Recipient: string;
begin
  recipientType := MsgTo;
  if recipientType = '' then
    recipientType := CMessageDlg('Create SMS for ...', mtConfirmation, 'Rep', 'Company', 'Cancel');

  if recipientType = 'Cancel' then Exit;

  if recipientType = 'Company' then recipient := Appointment.ClientMobile
  else recipient := Appointment.RepMobile;

  if recipient = '' then  begin
    commonlib.MessageDlgXP_Vista('Mobile number address is blank.', mtInformation, [mbOk],0);
    exit;
  end;

  if SameText(recipientType,'Rep') then
    TCorrespondenceGui.SMS(recipient,
      TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
      Appointment.TrainerID,rtEmployee,true)
  else begin
    if Appointment.Client.IsCustomer then
      TCorrespondenceGui.SMS(recipient,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtCustomer,true)
    else if Appointment.Client.IsSupplier then
      TCorrespondenceGui.SMS(recipient,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtSupplier,true)
    else if Appointment.Client.IsOtherContact then
      TCorrespondenceGui.SMS(recipient,
        TMailUtils.SubstituteText(AppEnv.CompanyPrefs.AppointmentPrintSMSText, PopulateMessageSubstituteList),
        Appointment.Client.ID,rtOtherContact,true)
    else
      commonlib.MessageDlgXP_Vista('Could not send SMS, unknown client type.', mtInformation, [mbOk],0);
  end;
end;

//procedure TAppointmentGUI.SendMessageSMSSilentAsk;
//begin
//  SendMessageSMSSilent('');
//end;

procedure TAppointmentGUI.SendMessageSMSSilentBoth;
begin
  if AppEnv.CompanyPrefs.EnableAppointmentPrintSMS then SendMessageSMSSilentCompany;
  if AppEnv.CompanyPrefs.EnableAppointmentRepPrintSMS then SendMessageSMSSilentRep;
end;

procedure TAppointmentGUI.SendMessageSMSSilentCompany;
begin
  SendMessageSMSSilent('Company');
end;

procedure TAppointmentGUI.SendMessageSMSSilentRep;
begin
  SendMessageSMSSilent('Rep');
end;

procedure TAppointmentGUI.SendPreparedEmail(const Recipient, Subject,
  Text: string; ASilent, aSecret: boolean);
begin
  if Appointment.Client.IsCustomer then
    TCorrespondenceGui.Email(recipient, '', subject,Text,Appointment.Client.ID,rtCustomer, aSilent, aSecret)
  else if Appointment.Client.IsSupplier then
    TCorrespondenceGui.Email(recipient, '',subject,Text,Appointment.Client.ID,rtSupplier, aSilent, aSecret)
  else if Appointment.Client.IsOtherContact then
    TCorrespondenceGui.Email(recipient,'',subject,Text,Appointment.Client.ID,rtOtherContact, aSilent, aSecret)
  else
    commonlib.MessageDlgXP_Vista('Could not send email, unknown client type.', mtInformation, [mbOk],0);
end;

procedure TAppointmentGUI.SendSilentEmail;
var
  Text: string;
  subject: string;
  recipient: string;
begin
  DisableForm;
  try
    if not SaveAndCommit(False, True) then Exit;
    try

      PrepareEmailText(recipient, subject, text);

      sendPreparedEmail(Recipient, Subject, Text, true, true);

    finally
      self.BeginTransaction;
    end;
  finally
    EnableForm;
  end;
end;

procedure TAppointmentGUI.ServiceIDChanged(Sender: TObject);
var
  i, lServiceID: Integer;
begin
  lServiceID := Appointment.ServiceID;
  for i := ServiceList.Items.Count - 1 downto 0 do
    if lServiceID = Integer(Pointer(ServiceList.Items.Objects[i])) then
      ServiceList.Checked[i] := True
    else
      ServiceList.Checked[i] := False;
end;

procedure TAppointmentGUI.RepServicesFormClosed(MsgObj: TMsgObj);
begin
  FreeAndNil(MsgObj);
  fbEnforceRepToFront := False;
  cboRepLookup.RefreshQuick(True);
  RefreshAvailableServices(Self);
  ServiceQuestionAsked := False;
end;

procedure TAppointmentGUI.ClientIDChanged(Sender: TObject);
begin
//  if Appointment.ClientID <> 0 then begin
//    if cboClient.LookupTable.FieldByName('ClientID').AsInteger <> Appointment.ClientID then begin
//      if cboClient.LookupTable.Locate('ClientID',Appointment.ClientID,[]) then begin

//      end;
//    end;
//  end;
  if AppEnv.CompanyPrefs.CreditCheckAppointment = 'T' then begin
    Appointment.IsCustomerCreditOk;
    Appointment.IsCustomerTermsOk;
  end;
  cmdEmail.Enabled := (Appointment.ClientEmail <> '') or (Appointment.RepEmail <> '');
  if (Appointment.Start_time <> '') then
    AppCount.Text := IntToStr(Appointment.ClientAppointmentCount);
  cboEmployee.Enabled := True;
end;

function TAppointmentGUI.InitNote(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fInitNote := MsgObj.StrValue;
  Result := True;
end;

function TAppointmentGUI.InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fInitClientID := MsgObj.IntValue;
  Result := True;
end;

procedure TAppointmentGUI.SetActiveControl(MsgObj: TMsgObj);
var
  aComponent: TComponent;
begin
  aComponent := Self.FindComponent(MsgObj.StrValue);
  FreeAndNil(MsgObj);
  if Assigned(aComponent) then
    if TWinControl(aComponent).CanFocus then
      SetControlFocus(TWinControl(aComponent))
    else
      fInitActiveControl := aComponent;
end;

procedure TAppointmentGUI.InitAttachments;
begin
  if tblMasterAppointID.AsInteger = 0 then exit;
  If not Assigned(AttachmentForm) then begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True,tblMasterAppointID.AsInteger));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblAppointments';
  end;
  if AttachmentForm.TableId <> tblMasterAppointID.AsInteger then begin
    AttachmentForm.TableId := tblMasterAppointID.AsInteger;
    AttachmentForm.Tag := tblMasterAppointID.AsInteger;
    AttachmentForm.lvAttachments.Parent := tabAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;
procedure TAppointmentGUI.InitProductList(Sender : TObject);
begin
  if not(Sender is   TProductListExpressGUI) then exit;
  (Sender as TProductListExpressGUI).CloseOnRecSelect := true;
  TProductListExpressGUI(Sender).FilterString := 'Parttype <>' +Quotedstr('INV')+' and IsSystemProduct <>' +Quotedstr('T');
end;
procedure TAppointmentGUI.InitContactList(Sender: TObject);
begin
  if not(Sender is   TContactListGUI) then exit;
  (Sender as TContactListGUI).CloseOnRecSelect := true;
  TContactListGUI(Sender).clientId := tblMaster.FieldByName('CusId').asInteger;
end;

function TAppointmentGUI.InitDate(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fInitDate := DateOf(MsgObj.DateTime);
  Result := True;
end;

function TAppointmentGUI.InitEmployeeID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fInitEmployeeID := MsgObj.IntValue;
  Result := True;
end;

function TAppointmentGUI.InitStartTime(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  if MsgObj.BoolValue then
    fInitDate := DateOf(MsgObj.DateTime);
  fInitStartTime := MsgObj.DateTime;
  Result := True;
end;

procedure TAppointmentGUI.ClearInitialiseFields;
begin
  fInitNote := '';
  fInitEmployeeID := 0;
  fInitDate := 0;
  fInitStartTime := 0;
  fInitClientID := 0;
  fInitRepairID:= 0;
  fInitActiveControl := nil;
end;

function TAppointmentGUI.CloseIfOpen(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  MsgRet := MsgObj;
  if csDestroying in ComponentState then
    Result := False
  else begin
    Appointment.PostDb;
    Appointment.Equipment.PostDb;
    Result := Appointment.Dirty;
    if Result then begin
      fWaitingForm := MsgObj.SenderStr;
      BringToFrontSoon;
      PostMessage(Self.Handle, WM_Close, 0, 0);
      Result := True;
    end;
  end;
end;

procedure TAppointmentGUI.NotifyWaitingForm;
var
  MsgObj: TMsgObj;
begin
  if fWaitingForm <> '' then begin
    MsgObj := TMsgObj.Create;
    MsgObj.SetAddress(fWaitingForm, 'AppointmentClosed');
    fMsgHandler.Send(MsgObj);
    fWaitingForm := '';
  end;
end;

procedure TAppointmentGUI.WMBringToFrontSoon(var Msg: TMessage);
begin
  if not fbEnforceRepToFront then
    inherited
  else if FormStillOpen('TfrmRep') then
    TForm(FindExistingComponent('TfrmRep')).BringToFront;
end;

procedure TAppointmentGUI.GetChargeRateDetails;
begin
  fChargeRateValue := cboChargeRate.Value;
  fChargeRateRecNo := qryAvailableServices.RecNo;
end;

procedure TAppointmentGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryAppointmentsTimeLogIncludeForInvoice.asBoolean then ABrush.color := Color_White
  else ABrush.color := GridcolInactive;
end;

procedure TAppointmentGUI.AppointmentSaved(const aIsNew: Boolean);
var
  MsgObj: TMsgObj;
begin
  if aIsNew and (fNewAppointmentName <> '') then begin
    MsgObj := TMsgObj.Create;
    MsgObj.SetAddress('TNewAppointment', 'AppointmentSaved', fNewAppointmentName);
    MsgObj.DateTime := Appointment.StartTime;
    MsgObj.IntValue := Appointment.TrainerID;
    fMsgHandler.Send(MsgObj);
    fNewAppointmentName := '';
  end;
  MsgObj := TMsgObj.Create;
  MsgObj.SetAddress('TfmMarketingLead', 'AppointmentSaved');
  MsgObj.IntValue := Appointment.ClientID;
  fMsgHandler.Send(MsgObj);
end;

function TAppointmentGUI.FoundInInactiveList(var Accept: boolean;cbo :TwwDBLookupCombo;NewValue: string):Boolean;
var
  lClient: TClient;
begin
  result:= false;
  if cbo = cboClient then begin
    lClient := TClient.Create(Appointment);
    try
      lClient.Connection := Appointment.connection;
      lclient.LoadSelect('CONCAT_WS(" ", If(InStr(Company,"^") -1 >0,Left(Company,InStr(Company,"^")-1),Company),IF(char_length(JobName)>0, Concat("(",JobName,")"),"")) = ' + QuotedStr(NewValue) );
      if lclient.count = 0 then begin
          Result := False;
          Exit;
      end;
      if lclient.Active = False then begin
          if lclient.Lock then begin
            if MessageDlgXP_Vista(NewValue +' is inactive.  Do you wish to make ' +newValue +' active?' , mtconfirmation, [mbyes, mbNo], 0) = mrno then begin
              Result := TRue;
              Accept := False;
              Exit;
            end;
            lclient.Active := True;
            lclient.PostDB;
            Result := True;
            Accept := True;
            cboClient.LookupTable.Close;
            cboClient.LookupTable.Open;
            cboClient.DataSource.DataSet.Edit;
            cboClient.DataSource.DataSet.FieldByName('CusID').AsInteger := lClient.ID;
            cboClientCloseup(cboClient, cboClientLookup, tblMaster, true);
          end else begin
            Result := TRue;
            Accept := False;
            MessageDlgXP_Vista(NewValue +' is an inactive record.' + chr(13)+chr(13)+
                StringReplace(lclient.UserLock.LockMessage, 'Unable to update data.' , 'Unable to Lock the record to make it active.' , [rfIgnoreCase]) , mtWarning , [mbok], 0);
            exit;
          end;
      end;
    finally
      FreeandNil(lclient);
    end;
  end;
end;

function TAppointmentGUI.InitialiserepairID(MsgObj: TMsgObj;
  out MsgRet: TMsgObj): Boolean;
begin
  fInitrepairID := MsgObj.IntValue;
  Result := True;
end;


procedure TAppointmentGUI.closecalendar;
var
  form :TComponent;
begin
  form := FindExistingComponent('TCalendarGUI');
  if form = nil then exit;
  if TCalendarGUI(Form).visible then TCalendarGUI(Form).close;
end;

(*procedure TAppointmentGUI.LocateTime(Sender: TObject; timeValue: String);
var
  dtimeValue:TDAtetime;
  i:Integer;
begin
  if not (sender is  TDBComboBox) then exit;
  if timeValue = '' then exit;
   if txtStartTime.Items.Count = 0 then exit;
   try
    dtimeValue :=Appointment.ValidStrToTime(timeValue);
      for i := 0 to TDBComboBox(Sender).Items.Count-1 do
        if dtimeValue = Appointment.ValidStrToTime(TDBComboBox(Sender).Items[i]) then exit
        else if dtimeValue < Appointment.ValidStrToTime(TDBComboBox(Sender).Items[i]) then begin
          TDBComboBox(Sender).itemindex := i;
          exit;
        end;
      TDBComboBox(Sender).itemindex :=TDBComboBox(Sender).Items.Count-1;
    except

    end;
end;*)

function TAppointmentGUI.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Appointment');
  if not Result then SchedulePageControl.ActivePage := Custom_Fields;
end;

{ TNewAppointment }

function TNewAppointment.ActiveControl(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fActiveControl := MsgObj.StrValue;
  Result := True;
end;

function TNewAppointment.AppDate(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fAppDate := MsgObj.DateTime;
  Result := True;
end;

function TNewAppointment.ClientID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fClientID := MsgObj.IntValue;
  Result := True;
end;

constructor TNewAppointment.Create(AOwner: TComponent);
begin
  inherited;
  fMsgHandler := TMsgHandler.Create(Self);
  fHandle := Classes.AllocateHWnd(WndProc);
end;

procedure TNewAppointment.CreateNewAppointment(MsgObj: TMsgObj);
begin
  fSaver := TComponent(MsgObj.ObjPtr);
  fCalendarGUI := TBaseInputGUI(GetComponentByClassName('TCalendarGUI'));
  if Assigned(fCalendarGUI) then begin
    fCalendarGUI.FreeNotification(Self);
    MsgObj.SetAddress('TCalendarGUI', 'PlaceNewAppointment');
    MsgObj.SenderStr := Self.Name;
    fMsgHandler.Send(MsgObj );
    fCalendarGUI.FormStyle := fsMDIChild;
    fCalendarGUI.BringToFrontSoon;
  end;
end;

function TNewAppointment.AppointmentPlaced(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
var
  NewMsgObj: TMsgObj;
begin
  fAppointmentGUI := TAppointmentGUI(GetComponentByClassName('TAppointmentGUI'));
  if Assigned(fAppointmentGUI) then begin
    fAppointmentGUI.FreeNotification(Self);
    fAppointmentGUI.fNewAppointmentName := Self.Name;
    NewMsgObj := TMsgObj.Create;

    NewMsgObj.SetAddress('TAppointmentGUI', 'InitEmployeeID');
    NewMsgObj.IntValue := fEmployeeID;
    fMsgHandler.Send(NewMsgObj, NewMsgObj);

    NewMsgObj.MethodStr := 'InitNote';
    NewMsgObj.StrValue := fNote;
    fMsgHandler.Send(NewMsgObj, NewMsgObj);

    NewMsgObj.MethodStr := 'InitialiseCustomerID';
    NewMsgObj.IntValue := fClientID;
    fMsgHandler.Send(NewMsgObj, NewMsgObj);

    NewMsgObj.MethodStr := 'InitialiserepairId';
    NewMsgObj.IntValue := fRepairId;
    fMsgHandler.Send(NewMsgObj, NewMsgObj);

    NewMsgObj.MethodStr := 'InitDate';
    NewMsgObj.DateTime := fAppDate;
    fMsgHandler.Send(NewMsgObj, NewMsgObj);

    NewMsgObj.MethodStr := 'InitStartTime';
    NewMsgObj.DateTime := fStartTime;
    fMsgHandler.Send(NewMsgObj, NewMsgObj);

    NewMsgObj.MethodStr := 'SetActiveControl';
    NewMsgObj.StrValue := fActiveControl;
    fMsgHandler.Send(NewMsgObj);

    fAppointmentGUI.WindowState := wsnormal;
    fAppointmentGUI.FormStyle := fsMDIChild;
    fAppointmentGUI.BringToFrontSoon;
    fAppointmentGUI.WindowState := wsnormal;
  end;
  Result := True;
end;

destructor TNewAppointment.Destroy;
begin
  Classes.DeallocateHWnd(fHandle);
  FreeAndNil(fMsgHandler);
  inherited;
end;

function TNewAppointment.EmployeeID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fEmployeeID := MsgObj.IntValue;
  Result := True;
end;

function TNewAppointment.Note(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fNote := MsgObj.StrValue;
  Result := True;
end;

function TNewAppointment.StartTime(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  fStartTime := MsgObj.DateTime;
  Result := True;
end;

procedure TNewAppointment.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then begin
    if AComponent = fCalendarGUI then
      fCalendarGUI := nil;
    if AComponent = fAppointmentGUI then
      fAppointmentGUI := nil;
    if (fCalendarGUI = nil) and (fAppointmentGUI = nil) then
      Release;
  end;
end;

procedure TNewAppointment.Release;
begin
  PostMessage(fHandle, CM_RELEASE, 0, 0);
end;

procedure TNewAppointment.WndProc(var Message: TMessage);
begin
  if Message.Msg = CM_RELEASE then
    Free;
end;

procedure TAppointmentGUI.ComboCloseUp(Sender: TObject);
begin
  if Sender is TwwDBDateTimePicker then begin
    if TwwDBDateTimePicker(Sender).Modified then TwwDBDateTimePicker(Sender).UpdateRecord;
  end else if Sender is TWinControl {TDBComboBox} then begin
    PostMessage(TWinControl(Sender).Handle, CM_EXIT, 0, 0);
  end;
end;

procedure TAppointmentGUI.cboChargeRateCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  Appointment.ServiceID := QryAvailableServices.FieldByname('ServiceID').asInteger;
  Appointment.Rate := QryAvailableServices.fieldbyname('Rate').asFloat;
  GetChargeRateDetails;
end;


procedure TNewAppointment.AppointmentSaved(MsgObj: TMsgObj);
begin
  if Assigned(fSaver) then begin
    MsgObj.SetAddress(fSaver.ClassName, 'Save', fSaver.Name);
    if fMsgHandler.Send(MsgObj, MsgObj) then
      FreeAndNil(MsgObj);
    Release;
  end else
    FreeAndNil(MsgObj);
end;

procedure TAppointmentGUI.CustomFieldsRefresh;
begin
  CustomFieldRefresh('CFAppointment' ,pnlCustFields);
end;

procedure TAppointmentGUI.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
(*var Form : TComponent;
begin
  Form := GetComponentByClassName('TfrmCustomFields');
  if Assigned(Form) then begin
    with TfrmCustomFields(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;*)
end;

procedure TAppointmentGUI.DBEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  cboChargeRate.DropDown;
end;


procedure TAppointmentGUI.cboClientNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
Var
  option: word;
  frmToPopUp:TBaseInputGUI;
  newVal: string;
begin
  inherited;
  if FoundInInactiveList(Accept , cboClient , newValue) then begin
      Exit;
  end;
  if (Pos(ComboSpecialItem_CreateNew,NewValue) > 0) or (Pos(ComboSpecialItem_OpenList,NewValue) > 0) then
    newVal := ''
  else
    newVal := NewValue;

  option :=  MessageDlgXP_Vista('This name is not in the list.' +chr(13)+chr(13)+
                                'Click OK to add as a customer otherwise open relevant forms'
//                                ,mtInformation,[mbOK,mbCancel], 0, nil , '','', False, nil, 'Create New Supplier,Create New Prospect');
                                ,mtInformation,[], 0, nil , '','', False, nil, 'OK,Create New Supplier,Create New Prospect,Cancel');
  if Option = {mrOK}100 then begin
    frmToPopup := TfrmCustomer(GetComponentByClassName('TfrmCustomer'));
    frmToPopup.AttachObserver(Self);
    ProcessingCursor(True);
    try
      TFrmCustomer(frmToPopUp).NewCompanyName := cboClient.Text;
      TForm(frmToPopUp).ShowModal;
    finally
      ProcessingCursor(False);
    end;
  end else if Option = {101}102 then begin
    frmToPopup := TfrmOtherContact(GetComponentByClassName('TfrmOtherContact'));
    frmToPopup.AttachObserver(Self);
    ProcessingCursor(True);
    try
      TfrmOtherContact(frmToPopUp).NewName := newVal;
      TForm(frmToPopUp).ShowModal;
    finally
      ProcessingCursor(False);
    end;
  end else if Option = {100}101 then begin
    frmToPopup := TfmSupplier(GetComponentByClassName('TfmSupplier'));
    frmToPopup.AttachObserver(Self);
    ProcessingCursor(True);
    try
      TfmSupplier(frmToPopUp).NewCompanyName := newVal;
      TForm(frmToPopUp).ShowModal;
    finally
      ProcessingCursor(False);
    end;
  end;
end;

procedure TAppointmentGUI.cboClientEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;


procedure TAppointmentGUI.chkRescheduledClick(Sender: TObject);
begin
  inherited;
  if chkREscheduled.Checked then begin
    if not fNewAppointment then begin
      cboRescheduledDate.Visible := true;
      chkCancellation.Enabled := not Appointment.Cancellation;
      Cancellation_label.Enabled := not Appointment.Cancellation;
      cboCancellationDate.Enabled := not Appointment.Cancellation;
      cboCancellationReason.Enabled := not Appointment.Cancellation;
    end;
    if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  end else begin
    if not fNewAppointment then begin
      cboRescheduledDate.Visible := False;
      chkCancellation.Enabled := True;
      Cancellation_label.Enabled := True;
    end;
  end;
end;

procedure TAppointmentGUI.chkCancellationClick(Sender: TObject);
begin            
  if not Appointment.Cancellation then begin
    cboCancellationDate.Enabled         := chkCancellation.Checked;
    cboCancellationReason.Enabled       := chkCancellation.Checked;
    cboCancellationDate.Visible         := chkCancellation.Checked;
    cboCancellationReason.Visible       := chkCancellation.Checked;
  end else begin
    chkCancellation.Enabled             := not chkCancellation.Checked;
    Cancellation_Label.Enabled         := not chkCancellation.Checked;
    cboCancellationDate.Enabled         := not chkCancellation.Checked;
    cboCancellationReason.Enabled       := not chkCancellation.Checked;
    cboCancellationDate.Visible         := not chkCancellation.Checked;
    cboCancellationReason.Visible       := not chkCancellation.Checked;
  end;

//  chkReschedule.Checked := not chkCancellation.Checked;
  if not fNewAppointment then begin
    chkRescheduled.Enabled := not chkCancellation.Checked;
    lblRescheduled.Enabled := not chkCancellation.Checked;
    cboRescheduledDate.Enabled := not chkCancellation.Checked;
  end;
end;

procedure TAppointmentGUI.MultipleRepsClick(Sender: TObject);
var
  tblRepeat: TERPQuery;
  procedure InsertRecords;
  var
    iCnt, Index: integer;

  begin
    try
      for iCnt := 0 to RepIdList.count - 1 do begin
        if  RepIdList[icnt] <> tblmasterAppointID.asInteger then begin
          tblRepeat.Append;
          for Index := 0 to tblMaster.FieldCount - 1 do begin
            if (tblMaster.Fields[Index].FieldKind = fkData) and
               (not Sysutils.SameText(tblMaster.Fields[Index].FieldName, 'AppointID')) and
               (not Sysutils.SameText(tblMaster.Fields[Index].FieldName, 'msTimeStamp')) then begin
               if Sysutils.SameText(tblMaster.Fields[Index].FieldName, 'TrainerID') then
                tblrepeat.fieldbyname('TrainerID').asInteger := RepIdList[icnt]
               else
                  tblRepeat.FieldByName(tblMaster.Fields[Index].FieldName).AsVariant := tblMaster.Fields[Index].AsVariant;
            end;
          end;
        end;
        PostDb(tblRepeat);
        EditDb(tblRepeat);
        tblRepeat.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + tblRepeat.FieldByName('AppointID').AsString;
        tblRepeat.FieldByName('CreationDate').AsDateTime := Date;
        tblRepeat.FieldByName('UpdateDate').AsDateTime := Date;
        tblRepeat.FieldByName('IsGroupParent').asBoolean := False;
        PostDb(tblRepeat);
      end;
      tblRepeat.Close;
      CommonLib.MessageDlgXP_Vista(Format('Inserted %d Reps for the appointment', [RepIdList.count]), mtInformation , [mbOK], 0);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  end;
begin
  inherited;
    RepIdList.clear;
    (*With TRepListGUI(GetComponentByClassName('TRepListGUI' , False , self)) do begin
      ShowModal;*)
      OpenERPListFormultiselectModal('TRepListGUI',nil, self.DoOnGridDataSelectMultiRep);
      if RepIdList.count > 0 then begin
        tblRepeat := TERPQuery.Create(self);
            try
              tblRepeat.Connection := tblMaster.Connection;
              tblRepeat.SQL.Text := 'SELECT * FROM tblappointments Where appointId =0';
              tblRepeat.Open;
              InsertRecords;
            finally
              FreeandNil(tblRepeat);
            end;
        end;
    (*end;*)
end;

function TNewAppointment.RepairId(MsgObj: TMsgObj;
  out MsgRet: TMsgObj): Boolean;
begin
  fRepairId:= MsgObj.IntValue;
  Result := True;
end;

procedure TAppointmentGUI.ActUpdateRepairsExecute(Sender: TObject);
var
  RepairMsgObj : TMsgObj;
  RepairsOBJ :TRepairs;
  isrepairopen:Boolean;
  form :Tcomponent ;
begin
  inherited;

  if Appointment.repairId= 0 then begin
      CommonLib.MessageDlgXP_Vista('This appointment is not linked to any Repairs' , mtInformation , [mbok], 0);
      Exit;
  end;

  if not IsActualsUpdated then Exit;

  if not Appointment.ValidateForInvoicing then Exit;


  RepairMsgObj := TMsgObj.Create;
  RepairMsgObj.SetAddress('TRepairsGUI', 'Addtimesheetrecord', 'RepairsGUI');
  RepairMsgObj.ObjPtr :=Appointment;
  isrepairopen := false;
  Try
    if (fMsgHandler.Send(RepairMsgObj, RepairMsgObj)) and (RepairMsgObj.objptr <> nil) and (RepairMsgObj.objptr is TRepairs)  then begin
      RepairsOBJ := TRepairs(RepairMsgObj.objptr );
      isrepairopen := true;
    end else begin
      isrepairopen := false;
      RepairsOBJ := TRepairs.create(Self);
      RepairsOBJ.Connection := Appointment.Connection;
      RepairsOBJ.load(Appointment.repairID);
    end;
    if RepairsOBJ.count = 0 then exit;
    
    if Appointment.Notes <> '' then
      if pos(UpperCase(RepairsOBJ.Notes) ,uppercase(Appointment.Notes)) <> 0 then
          RepairsOBJ.Notes := Appointment.Notes
      else if pos(UpperCase(Appointment.Notes) ,uppercase(RepairsOBJ.Notes)) <> 0 then
      else RepairsOBJ.Notes := RepairsOBJ.Notes +Appointment.Notes;

    if Appointment.Feedbacknotes <> '' then
      if pos(UpperCase(RepairsOBJ.Feedbacknotes) ,uppercase(Appointment.Feedbacknotes)) <> 0 then
          RepairsOBJ.Feedbacknotes := Appointment.Feedbacknotes
      else if pos(UpperCase(Appointment.Feedbacknotes) ,uppercase(RepairsOBJ.Feedbacknotes)) <> 0 then
      else RepairsOBJ.Feedbacknotes := RepairsOBJ.Feedbacknotes +Appointment.Feedbacknotes;


        
    RepairsOBJ.newTimesheetEntry;
    if not(RepairsOBJ.Timesheetentry.Timesheet.Locate('AppointmentID' , Appointment.ID, [] )) then begin
      RepairsOBJ.Timesheetentry.Timesheet.New;
      RepairsOBJ.Timesheetentry.Timesheet.AppointmentID   := Appointment.Id;
      RepairsOBJ.Timesheetentry.Timesheet.ServiceID       := Appointment.ServiceID;
      RepairsOBJ.Timesheetentry.Timesheet.EmployeeID      := Appointment.TrainerID;
      RepairsOBJ.Timesheetentry.Timesheet.EmployeeName    := Appointment.TrainerName;
      RepairsOBJ.Timesheetentry.Timesheet.ServiceDate     := Appointment.Actual_StartTime;
      RepairsOBJ.Timesheetentry.Timesheet.ServiceName     := Appointment.ServiceDesc;
    end;
    RepairsOBJ.Timesheetentry.Timesheet.TimeSheetClassID := Appointment.ClassID;
    RepairsOBJ.Timesheetentry.Timesheet.quantity          := Round(Appointment.Actual_TotalHours,OtherRoundPlaces);
    RepairsOBJ.Timesheetentry.Timesheet.Hours             := RepairsOBJ.Timesheetentry.Timesheet.quantity;
    RepairsOBJ.Timesheetentry.Timesheet.ChargeRate        := Appointment.Rate;
    RepairsOBJ.Timesheetentry.Timesheet.TotalServicecharge:= Appointment.TotalInc;
    RepairsOBJ.Timesheetentry.Timesheet.PostDB;
    RepairsOBJ.UpdateStatus(SimpleTypeAction_appointment);
  finally
      if isrepairopen then
        RepairsObj := nil
      else
        Freeandnil(RepairsObj);
  end;

      if CommonLib.MessageDlgXP_Vista('The Repair Has Been Updated.'+ chr(13) +
                                  'Do You Wish To Save The Appointment And Open The Repair Form?' ,
                                  mtconfirmation , [mbyes, mbNo],0) = mrYes then begin
        if SaveAndCommit(False) then begin
           form := GetComponentByClassName('TRepairsGUI' , true);
           if not assigned(form) then exit;
           if TRepairsGUI(form).visible then begin
              if TRepairsGUI(form).KeyId = Appointment.RepairID then begin
                TRepairsGUI(form).BringToFront;
                closecalendar;
                self.close;
                exit;
              end else Commonlib.MessageDlgXP_Vista('Repair Form Is Already Opened For RepairID#' + IntToStr(TRepairsGUI(form).KeyId) +'.  Please Close it First to Open For This Appointment''s Repair' , mtinformation , [mbok],0);
           end else begin
              TRepairsGUI(form).KeyId := Appointment.RepairID;
              TRepairsGUI(form).FormStyle := fsMDIChild;
              TRepairsGUI(form).BringToFront;
              closecalendar;
              self.close;
              exit;
           end;
        end;
      end;
  
end;

procedure TAppointmentGUI.ActUpdateRepairsUpdate(Sender: TObject);
begin
  inherited;
  ActUpdateRepairs.enabled := (Appointment.repairId <> 0) and (Appointment.ClientID<>0)
  and ((Appointment.Actual_TotalHours <> 0)  or (Appointment.TotalHours<> 0) ) ; 
end;

procedure TAppointmentGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_F8 ) and (SchedulePageControl.ActivePage = tabEquipment)
    (*((Sysutils.SameText(screen.activecontrol.name ,'grdEquip'))) *) then begin
    if not Appointment.UserLock.Lock('tblClients' , Appointment.ClientID, Appointment.LockGroupName) then begin
      CommonLib.MessageDlgXP_Vista(StringReplace(Appointment.USerlock.LockMessage , 'Unable to update data.' , 'Equipment reference cannot be created for the selected client' , [rfIgnoreCase]), mtInformation , [mbok],0);
      Exit;
    end;
    try
      TEquipmentListforxRefGUI.EquipmentListForxRef(Appointment.clientId,
                                            EquipmentxRefForm.RefreshEquipmentLookup ,
                                            Appointment.Equipment);
    finally
        Appointment.UserLock.UnLock('tblClients' , Appointment.ClientID, Appointment.LockGroupName);
    end;
  end else inherited;
end;
procedure TAppointmentGUI.tblDetailsWarantyPeriodTakenChange(
  Sender: TField);
begin
  inherited;
  if tblDetails.findfield('WarantyPeriod')<> nil then
    tblDetailsWarantyPeriodLeft.asFloat := tblDetails.fieldbyname('WarantyPeriod').asFloat -  tblDetailsWarantyPeriodTaken.asfloat;
end;

procedure TAppointmentGUI.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  closedb(cboClientLookup);
  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(Appointment.clientId,  cboClient,True, True, True, true , true , 'ClientPrintName' , nil , true);
  opendb(cboClientLookup);
end;

procedure TAppointmentGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  InitERPLookupCombonFields;
  InitAttachments;
end;

procedure TAppointmentGUI.tblMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
  InitAttachments;
end;

procedure TAppointmentGUI.tblMasterCalcFields(DataSet: TDataSet);
begin
  inherited;
       if tblMasterUnavailable.asBoolean then tblMasterDisplayStatus.asString := 'Un-Available'
  else if tblMasterLocalApp.asBoolean then tblMasterDisplayStatus.asString := 'Go Live Appt'
  else tblMasterDisplayStatus.asString := '';
end;

procedure TAppointmentGUI.tblDetailsWarantyPeriodLeftChange(
  Sender: TField);
begin
  inherited;
  if tblDetails.findfield('WarantyPeriod')<> nil then
    tblDetailsWarantyPeriodTaken.asfloat:= tblDetails.fieldbyname('WarantyPeriod').asFloat -tblDetailsWarantyPeriodLeft.asFloat ;
end;

procedure TAppointmentGUI.txtStartTimeDropDown(Sender: TObject);
begin
  inherited;
  LocateTime(Sender , Appointment.start_time  );
end;

procedure TAppointmentGUI.txtTotalTimeDblClick(Sender: TObject);
begin
  inherited;
  if devmode then
    if Appointment.Actual_Appdate =0 then begin
      Appointment.Actual_Appdate := Appointment.Appdate;
      Appointment.Actual_StartTime := Appointment.StartTime;
      Appointment.Actual_EndTime := Appointment.EndTime;
      Appointment.PostDB;
    end;
end;

procedure TAppointmentGUI.txtEndTimeDropDown(Sender: TObject);
begin
  inherited;
  LocateTime(Sender , Appointment.end_time  );
end;

procedure TAppointmentGUI.txtActualStarttimeDropDown(Sender: TObject);
begin
  inherited;
  LocateTime(Sender , Appointment.Actual_start_time  );
end;

procedure TAppointmentGUI.txtActualtotaltimeDblClick(Sender: TObject);
begin
  inherited;
  Appointment.AppointmentsTimeLog.PostDB;
  if Appointment.AppointmentsTimeLog.count >0 then
    SchedulePageControl.TabIndex := 1;
end;

procedure TAppointmentGUI.txtActualEndTimeDropDown(Sender: TObject);
begin
  inherited;
  LocateTime(Sender , Appointment.Actual_end_time  );
end;

procedure TAppointmentGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
   //txtNotes.text:= AddDateTime(lcdOnLoganyway, txtNotes.text, true);
   AddDateTime(lcdOnLoganyway, txtNotes, true);
end;

procedure TAppointmentGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  //txtFeedBackNotes.text:= AddDateTime(lcdOnLoganyway,txtFeedBackNotes.text, true);
  AddDateTime(lcdOnLoganyway,txtFeedBackNotes, true);
end;

procedure TAppointmentGUI.InitERPLookupCombonFields;
begin
  inherited;
  if tblmaster.active then
    NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(Appointment.clientId,  cboClient,True, True, True, True , True , 'ClientPrintName' , nil, true);
end;
procedure TAppointmentGUI.btnStartClick(Sender: TObject);
begin
  inherited;
  Appointment.NewLog;
end;
procedure TAppointmentGUI.btnStopClick(Sender: TObject);
begin
  inherited;
  Appointment.EndLog;
end;

initialization
  RegisterClassOnce(TAppointmentGUI);
  RegisterClassOnce(TNewAppointment);
  with FormFact do begin
    (*RegisterMe(TAppointmentGUI, 'TRemindersListGUI_*_Appointment=ID');*)
    RegisterMe(TAppointmentGUI, 'TReminderListGUI_*_Appointment=ID');
    RegisterMe(TAppointmentGUI, 'TAppointmentListGUI_*=AppointID');
    RegisterMe(TAppointmentGUI, 'TAppointmentcomparisonGUI_*=AppointID');
    //RegisterMe(TAppointmentGUI, 'TSalesAnalysisGraphDrilldownapptsGUI_*=AppointID');
    RegisterMe(TAppointmentGUI, 'TFeedbackListGUI_*_Appoint=ID');
    RegisterMe(TAppointmentGUI, 'TAppointmentListReportGUI_*=AppointID');
    RegisterMe(TAppointmentGUI, 'TEmailedReportsList_*_Appointments=Transaction');
    RegisterMe(TAppointmentGUI, 'TfmMarketingLead_*_Appointment=ActionID');
    RegisterMe(TAppointmentGUI, 'TfmMarketingLead_*_Rescheduled=ActionID');
    RegisterMe(TAppointmentGUI, 'TfmMarketingLead_*_AppointmentSat=ActionID');
  end;
end.










