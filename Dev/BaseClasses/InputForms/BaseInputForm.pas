unit BaseInputForm;

{ ML - This class is the base class for all basic input forms. It implements the
  observer pattern which notifys all interested GUIs when necessary.

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  04/04/05  1.00.01 IJB  Added CallingClassName property. This is automatically
  set by BaseListing with the class name of the list the
  user has dbl clicked on.
  11/04/05  1.00.02 IJB  Changed Notiy to exit if app is shutting down.
  13/04/05  1.00.03 IJB  Changed exception error handling to use new exception
  form and logging.
  29/04/05  1.00.04 IJB  Added DoingNotify logic to fix close exceptions in decendants.
  23/05/05  1.00.05 BJ   function 'ComboToPopUp' : ignoring the case of the fieldname
  06/06/05  1.00.06 IJB  Added logic to set form top to 0 if negative.
  10/06/05  1.00.07 IJB  Added logic to check report template exists before printing.
  26/06/05  1.00.08 BJ   'CloseQueries': The query/table is closed only if it Active=True
  30/06/05  1.00.09 IJB  Introduced new UserLockObj class to controll multi-user
  accsses issues with same KeyId in decendent classes.
  Also added KeyIdChaged method.
  18/07/05  1.00.10 BJ  Validation is added to check for the SQL and the template
  before printing a report template. This validation is done
  in the 'PrintTemplateReport' function as this is the one
  called from all the modules. If there is any other funtion
  to print a report , should call the validation.
  26/07/05  1.00.11 DMS  Added field Flags that allows all descendants to benefit
  from usage of this simple but effective class. For details
  see TSimpleFlags class in tcClasses.pas.
  27/07/05  1.00.12 IJB  Added check that Templates object is assigned before
  free in PrintTemplateReport, (users getting
  access violations here)
  03/08/05  1.00.13 DSP  When entering a customer name not in the list on the
  frmAppointments form and a new customer is created; the
  new customer name was not returned to the customer
  combobox.
  18/08/05  1.00.14 BJ   Note: if onComboNotInlistFunction or combodouble click
  events are invoked from any form,
  to get the the lookuptable refreshed for the new changes,
  do the following
  1) In the calling from
  introduce a new variable to store the lastaccessedcombo
  initialise lastaccessedcombo in both combochange and combocloseup
  introduce Updateme function (this function can use lastaccessedcombo
  2) In the popup form
  Set the KEYID after Save - if not done
  Call Notify(False) after Save
  Call Notify(True) after cancel but before self.close.
  FormDestroy should Notify;
  Eg: frmAppointment opening Customer form.
  01/09/05  1.00.15 IJB Changed OpenQueries to use a While loop rather than For
  loop (to prevent 'List index out of bounds' exception).
  06/09/05  1.00.16 DSP Added CompletedClick procedure to allow disabling of Save
  buttons while their click event processing occurs.
  14/09/05  1.00.17 DSP Changed CompletedClick procedure to use a lock-out flag
  in place of disabling the button.
  19/09/05  1.00.18 ISB UnlockTables.
  23/09/05  1.00.19 BJ  Accesslevel property is changing the DNMAccesslevelObj's accesslevel
  This is done for SO. The SO opens in RO mode when there is BO
  and need to update the 'Converted' when 'Copy to Invoice'
  which changes the accesslevel to 1 before updating the field.
  03/11/05  1.00.15 IJB Removed CourseUpdation property.
  03/01/06  1.00.16 DSP Changed PrintTemplateReport and SaveTemplateReport to use
  TPrintTemplates in PrintTemplateObj.
  06/01/06  1.00.17 IJB Added code to OnComboNotInList to set cbo.Text to
  NewValue if blank.
  11/01/06  1.00.18 IJB Modified Flag List functions to exit if list nil.
  12/01/06  1.00.19 IJB Modified template printing to pass fbReportSQLSupplied.
  13/01/06  1.00.20  AL Commented Instance as it is not used anymore
  25/01/06  1.00.21 DSP Changed 'IsOkToSave' from static to virtual for override
  in BaseTransForm.
  30/01/06  1.00.22 DSP Added methods to paint PageControl tabs and TabSheets
  with supplied bitmaps.
  31/01/06  1.00.23 DSP Moved DrawText method to allow for a bitmap file not
  existing.
  03/02/06  1.00.24 DSP Changed the font colour of an active tab to clNavy.
  09/02/06  1.00.25 DSP Moved handling of grid customisation and the drawing of
  the grid watermark from BaseTransForm unit to here.
  16/02/06  1.00.25 DSP The watermark on grids is now cleared after being
  displayed for 5 seconds.
  23/02/06  1.00.26 DSP Added code to fill-in the right side of tabs on any
  page controls with the bitmap.
  09/03/06  1.00.27 DSP Added code to use the form colour to create a bitmap
  if a background bitmap file cannot be found.
  31/03/06  1.00.29 BJ  Hint implemented
  Tab control's on change shows the hint for the current tab
  The hint is shown on exit of the tabsheet. this is to show the hint when clicked
  on the tab heading when the control is alsready inside the page. clicking
  on the heading fires the onExit of the tabsheet.
  10/05/06  1.00.30 DSP Added check for csDestroying in ComponentState in
  methods used for painting the grid watermark. This is
  to prevent access violations if the escape key is pressed
  as soon as the form appears.
  05/06/06  1.00.31 DSP Removed call to CloseQueries from FormDestroy as the
  query components close themselves in their Destroy
  method.
  24/07/06  1.00.32 DSP Moved GetBitmapNsme function from private to protected.
  02/08/06  1.00.33 DSP Moved SetClassLabels to DNMLib.
  15/08/06  1.00.34 BJ  1)fiAccesslevel and ignoreAccesslevels variables definition is moved into
  the baseform
  2)BusObjQueries is a string array, needs to be resized and initialised in
  the descendants in Formcreate after inherited.
  3) AccessManager property to access the DNMAccessmanager object - for the
  business objects, this object is created in the 'Create' of Baseinput. The
  Business objects are using it from the 'FormCreate' in the descendants.
  4)Changing the caption of the form is moved from the 'Formcreate' to the baseform's
  onFormShow.
  16/08/06  1.00.35 BJ  using TBalancePostList.postitems to update any related tables locks the tables
  and are relaeased in the after commit(UnlockRelatedTables)
  24/08/06  1.00.36 DSP Copied lines from constructor Create to
  CreateWithAccessLevel to prevent an access violation
  due to the DNMAccessManager not being created.
  04/09/06  1.00.37 BJ  ChkReqdFields :Required field validations added for the date fields
  12/09/06  1.00.38 DSP Added Cut, Copy and Paste (etc.) to the grid Popup Menu.

}

interface

{$I ERP.inc}

  uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, ComCtrls, AdvOfficeStatusBar, StdCtrls, Buttons,
    DNMSpeedButton, DBAccess, MyAccess, ERPdbComponents, AppEvnts, ExtCtrls, Mask, wwdblook, wwdbedit, Grids, WWDBGrid, MemDS, DBCtrls,
    SyncObjs, wwcheckbox, wwclearbuttongroup, wwradiogroup, wwdbdatetimepicker, PrintTemplateObj,
    dmGUIStylers,
    PersonalTabStops, BaseFormForm, SelectionDialog, DataState, UserLockObj,
    MyClasses, tcClasses, Contnrs, GuiPrefsObj, Menus, AdvMenus,
    ProgressDialog, GraphUtil, Shader, DNMPanel, Wwdbigrd, ImgList, JsonObject,
    ObserverListObj, busobjbase, Busobjcustomfields, ERPDbLookupCombo, CorrespondenceObj, typeslib, UserCustomisedNames, LookupcomboLib,
    FormEvents, ERPSets,MessageDlgXP_forPreference , ApprovalCheckObj;

  const
    TX_SetFocus     = WM_USER + 101;
    TX_GridPaint    = WM_USER + 111;
    TX_SetFormFocus = WM_USER + 112;

    // type
    // TIterateCallbackProc = Procedure(Const Sender: TDataset; var Abort: boolean) of Object;
    // TCourseUpdation = procedure(qryTemp: TERPQuery; ID: integer; InvDate: TDateTime; MarketingEnquiryID: integer) of object;
  type // Used to Save context for not-in-list processing when we return
    // .. from the child form via 'notify'.
    TNotInTListRec = record
      Combo: TwwDBLookupCombo;
      DisplayField: string;
      Popup: TForm;
      PopUpField: string;
      PopUpDataSet: TDataSet;
    end;

  type
    TDisablescontrolsHint = record
      ParentPanel: TPanel;
      disabledcontrol: TControl;
      ControlHint: String;
    end;

    TBaseInputGUI = class(TBaseForm, IObserverUpdateMeEdit, IObserverUpdateMeList, IObserverCompleteNotInList)
      ApplicationEvents1: TApplicationEvents;
      MyConnection: TERPConnection;
      DataState: TDataState;
      imgGridWatermark: TImage;
      popCustomiseGrid: TAdvPopupMenu;
      CustomiseGrid: TMenuItem;
      imgsort: TImageList;
      QryCustomField: TERPQuery;
      ProgressDialogOBJ: TProgressDialog;
      mnuBusobjProperties: TAdvPopupMenu;
      mnuBusobjPropertiesoption: TMenuItem;
      qryMemTrans: TERPQuery;
    tmrOnshow: TTimer;

      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure FormPaint(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: boolean); { This introduced method is used to catch all TwwDBLookupCombo dbl click events. }
      procedure OnComboDblClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
      procedure FormActivate(Sender: TObject);
      procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
      procedure CustomiseGridClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FeldSetTextDontAllowNulls(Sender: TField; const Text: String); VIRTUAL;
      procedure mnuBusobjPropertiesoptionClick(Sender: TObject);
      procedure MyConnectionAfterCommit(Sender: TObject);
      procedure MyConnectionAfterRollback(Sender: TObject);
      procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure tmrOnshowTimer(Sender: TObject);

    private { Private declarations }
      FFlags                : TSimpleFlags;
      fiKeyID               : integer;
      fNotInList            : TNotInTListRec;
      fApprovalcheckObj      : TApprovalcheckObj;
      fbStartupErrorOccurred: boolean;
      //fsReportName          : string;
      fCallingClassName     : string;
      fPreventClick         : boolean;
      fStoredCompletedClick : TNotifyEvent;

      fAllowCustomiseGrid    : boolean;
      fShowCustomisemenu     : boolean;
      fGridQueue             : TQueue;
      fCutAndPasteAdded      : boolean;
      fsForeignkeyValidations: array of Array of String;
      fbInComboNotinList     : boolean;
      fscombonotInlistValue  : String;
      fTabColor              : TColor;

      fAllowGridSorting            : boolean;
      fsGridstoExcludeFromsorting  : String;
      fsGridstoExcludefromcustomize: String;
      fsGridsToIncludeforDefaultOptions: String;
      FStateParams                 : TJsonObject;
      // LocalProgressbarcount:Integer;
      DisablescontrolsHints    : Array of TDisablescontrolsHint;
      DisablescontrolHintWindow: THintWindow;
      DoingonComboDblClick     : boolean;
      DoingonComboNotInlist    : boolean;
      fbComboCreateMew         : boolean;
      fCancelGridSort          : boolean;
      fNamenPrintNameGridObj   : TNamenPrintNameGridObj;
    fsBusobjAuditLogDetails: String;




      // fiAccessLevel: integer;//    procedure DNMPanelOnBeforeCaptionPaint(CurrentFont: TFont);
      { Method used to manage double clicking of combos }

      procedure HookupComboEvents;
      procedure DisableDeleteBoxesInGrids;
      function PointLookupUsingSelect(const cbo: TwwDBLookupCombo): boolean;
      function PointLookupUsingField(const cbo: TwwDBLookupCombo): boolean;
      procedure ComboToPopUp(const Popup: TForm; const cbo: TwwDBLookupCombo);
      function GetComboSelectField(const cbo: TwwDBLookupCombo): string;
      function GetComboIdent(const cbo: TComponent): string;
      function ValidReport(const ReportName, SQLPortion: string): boolean;
      procedure CompletedClick(Sender: TObject);
      procedure TabSheetShow(Sender: TObject);
      (* procedure PageControlDrawTab(Control: TCustomTabControl; TabIndex: integer; const Rect: TRect; Active: boolean); *)
      procedure pageControlChange(Sender: TObject);
      procedure Tabcontrolexit(Sender: TObject);
      Procedure OnERPComboBeforeOpenList(Sender: TObject);
      procedure HandleGridPaint(var Msg: TMessage); message TX_GridPaint;
      procedure ClearTimerTimeout(Sender: TObject);
      procedure SetupCustomiseGrid;
      Procedure SetupgridSorting;
      procedure AddCutAndPasteItems(const GridPopupMenu: TAdvPopupMenu; ItemIndex: integer);
      // procedure HandlePopupClick(Sender: TObject);
      procedure SetFormFocus(var Msg: TMessage); message TX_SetFormFocus;

      function FieldinNotToSortList(Gridname, AfieldName: String): boolean;
      Procedure MonitorConnectionEvents;
      Procedure DoErrorLog(Sender: TERPConnection; E: Exception);
      Procedure customiseGridDateTimePicker;
      procedure DocustomiseGridDateTimePicker(Sender: TObject; ADateTimePicker: TwwDBCustomDateTimePicker);
      Procedure AttachERPFormToObserver(Sender: TObject);
      Function InUseRecords: String;
      procedure DeletenReInitPref;
      Procedure MakeBusobjPropertiesMenuoption;
      procedure SetAllowCustomiseGrid(const Value: boolean);
      procedure OnMouseMoveofDisableControlParent(Sender: TObject; Shift: TShiftState; X, Y: integer);
      procedure OnExitofDisableControlParent(Sender: TObject);
      function getReportName(ChooseReport: boolean; LoadReportTypesconditions: STring): string;
      function getCancelPreviewAll: boolean;
      (*procedure OncheckApprovedclick(Sender: TObject);*)
      Function ApprovalcheckObj      : TApprovalcheckObj;
      Procedure DoShowUserApprovalPref;
    protected
      iMarketingEnquiryID            : integer;
      fConnectionFormReport          : TERPConnection;
      fbTemplateUsesNonFormConnection: boolean;
      foCombo                        : TObject;
      pTabStops                      : tpersonaltabs;
      // flstObservers: TList;
      fowwCombo                            : TObject;
      fbAllowNotInList                     : boolean; // set this to allow auto combo not-in-list processing for this form
      fbTabSettingEnabled                  : boolean;
      fbTabPaintDisabled                   : boolean;
      fbNoAccess                           : boolean;
      frmToPopup                           : TBaseInputGUI; // assign a form to this variable to bypass form factory for not-in-list processing
      SkinIdx                              : string;
      ImageDb                              : TdbImage;
      ImgD                                 : TImage; // Panel Size
      ImgS                                 : TImage; // Source File
      ImgR                                 : TImage; // Resized Image
      Lab                                  : TLabel;
      Loaded                               : integer;
      BaseInput_DupError                   : integer;
      DoingNotify                          : boolean;
      BusObjqueries                        : array of string;
      //PrintTemplate                        : TPrintTemplates;
      fPaintTimer                          : TTimer;
      SavedAccessLevel                     : integer;
      DescImageIndex                       : integer;
      ascImageIndex                        : integer;
      GridstoSort                          : array of String;
      Gridindexes                          : Array of String;
      fSavePointActive                     : boolean;
      fbIsLocalPrefChanged                 : boolean;
      fbExludeDiscontProductinProductcombo : boolean;
      fbExludeInactiveProductinProductcombo: boolean;
      fsBusobjClassname                    : String;
      fbforceSavesound                     : boolean;
      fbForceRollbackSound                 : boolean;
      fbNoSavesound                        : boolean;
      fbNoCanelsound                       : boolean;
      fTransConnection                     : TERPConnection;
      sizeMode                             : string;
      fPrefOptionObj : TPrefOptionObj;
      fsMessageOptionPrefix:String;
      fitmrOnshowNo :Integer;
      fLastComboAccessed: TwwDBLookupCombo;
      ShowAtcursor:Boolean;

      procedure PaintTimerTimeout(Sender: TObject); Virtual;
      Procedure SortGrid(const AfieldName: String; const Sender: TObject); Virtual;
      procedure GridTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
      procedure GridBeforePaint(Sender: TObject);
      procedure EnableDisable; Virtual;
      procedure SetKeyId(const Value: integer); virtual;
      Function GetMainTablename: String; virtual;
      procedure KeyIdChanged(const NewKeyId: integer); virtual;
      function TemplateNameToTemplateClassName(const TemplateName: string): string;
      function GetEmployeeEmail(const ThisEmployeeID: integer): string;
      function GetSalesEmails(aEmployeeID:Integer =0): string;
      function GetClientEmail(const ThisClientID: integer; OnlyIfPreferedMethod: boolean = false): string;
      procedure GetCustomerNameAndEmail(ACustomerId: integer; var email, name: string);
      // function GetClientEmailForSales(const aClientId : integer; const aFieldName : string; var aContactId : integer) : string;
      // function GetContactEmailsForSales(const AClientId : integer; const aFieldName : string) : TStringList;
      function GetContactEmail(const ContactID: integer): string; // (const ContactName:string;const ThisClientID: integer): string;
      function GetClientName(const ThisClientID: integer): string;
      // function GetClientFaxNumber(const ThisClientID: integer): string;//Function GetSkin(ClassName : String):String;
      { ML - Important Note : If you're trying to refresh a query on a form that is in a transaction,     you will need to override the SetConnectionString method because the queries will not     refresh until the transaction is committed. }
      procedure SetConnectionString(const TransactionMode: boolean = true); Virtual;
      Procedure SetTransconenctiontoQueries;
      procedure CheckForOpenDatasets; { Rename class labels etc to the default class heading }
      { Method used to manage double clicking of combos }
      procedure DivertComboDblClick(Sender: TObject); virtual;
      procedure OnComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean); virtual;
      procedure beforeOnComboNotInList(Sender: TObject); Virtual;
      procedure InitPopupform(frmPopup: TBaseInputGUI); Virtual;
      procedure AftershowPopupform(frmPopup: TBaseInputGUI); Virtual;
      procedure CloseQueries;
      procedure OpenQueries; overload;
      procedure OpenQueries(const QueryNamesNotToOpen: array of string); overload; { Exception handling routines for all basic input guis, can be added to on a needs basis }
      // procedure HandleUnknownException(const e: Exception);

      procedure DeactivateDefaultValues; overload;
      procedure DeactivateDefaultValues(const QueryNamesToExclude: array of string); overload;

      procedure HandleEAbortException;
      procedure HandleNoAccessException(const E: Exception; const bExit: boolean = true); { Transaction handling }
      procedure BeginTransaction; virtual;
      Procedure ExecuteSQLinconnection(sSQL: String); virtual;
      procedure CommitTransaction; virtual;
      procedure RollbackTransaction; virtual;
      function DataHasChanged: boolean;
      { This method should be overwritten in descendants to set the correct Report Type ID } { PRINTING ROUTINES - Utilizes the ReportBuilder Templates }
      function GetReportTypeID: integer; virtual;
      function GetReportType: string; virtual;
      procedure LoadReportTypes(reportType: String); Reintroduce; Overload;
      procedure LoadReportTypes(reportTypeID: integer = 0; LoadReportTypesconditions: String = ''); Overload; Override;
      function GetReportTypeIDForTypeName(const TypeName: string): integer;
      function GetReportNameForTypeName(const TypeName: string): string;
      procedure LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = ''); virtual;
      procedure NotInListWarning(Sender: TObject);
      function EditNoAbort(const DataSet: TDataSet): boolean;
      function getPopup(const sMneumonic: string): TBaseInputGUI;
      function GetCompanyName: string;
      function GetCompanyEmail: string; { Auto Cheque No's }
      procedure SetLastChequeNo(const AccountID, ChequeNo: integer);
      function IsOkToSave: boolean; virtual;
      function ChkReqdFields(const sFormType: string): boolean;
      procedure CompleteComboNotInList(const aObserver: TObject); virtual;
      //property ReportToPrint: string read fsReportName write fsReportName;
      Property InComboNotinList: boolean Read fbInComboNotinList Write fbInComboNotinList;
      Property CombonotInlistValue: String Read fscombonotInlistValue Write fscombonotInlistValue;
      Procedure UnlockRelatedTables; virtual;
      Procedure CheckRecordUsage(Const TableName, whereClause, IDFieldName: String; DescTablename: string);
      Function RecordinUse(var ErrMsg: STring): boolean;
      function BusObjconfirmation(const Msg: String; Buttons: TMsgDlgButtons): integer;
      function GetBusinessObject: TObject;
      Procedure ClosenOpenDB(Ds: TDataSet);
      Procedure CloseDB(Ds: TDataSet);
      Procedure openDB(Ds: TDataSet);
      function FieldsToExecludeFromsorting: String; virtual;
      procedure IterateRecords(Const Sender: TDataSet; CallbackFunc: TDatasetIterateCallbackProc; DisableFilter: boolean = false);
      Procedure CloseAfterPrint(aCloseWhenDone: boolean = true); virtual;
      Procedure AfterFormShow; override;
      procedure HideProgressbarform;
      procedure HideProgressbar;
      procedure showProgressbar(Progressbarcaption: String; Progresscount: integer; ISPercent: boolean = true);
      procedure stepProgressbar(const ProgressbarMsg: String = '');
      procedure CustomFieldRefresh(const CustomfieldPrefix: String; const pnl: TPanel; Ownerform: TForm = nil);
      Procedure OpenCustomFields; virtual;
      procedure OpenQryCustomField(const CustomfieldPrefix: String);
      procedure Disablecontrols(btnclose: TDnmSpeedButton);
      Function isParamAssigned(Qry: TERPQuery; Paramname: String): boolean;
      Function EmailReport(RecID: integer; CustomerName, RecipientAddress, reportType, sreportName, sSQL: String; ReportSQLSupplied: boolean; EmailforemptyAddress: boolean;
        ConfirmEmailforempty: boolean = true; aSilent: boolean = false; aSecret: boolean = false; AddAttachment :TNotifyEvent =nil; EmailSubject:String = ''): boolean;
      Function ActiveField(Grid: TObject): TField;
      function GetKeyString: string; virtual;
      procedure SetKeyString(const Value: string); Overload; virtual;
      Procedure logInuseform; Override;
      Procedure SetKeyString(busobjClass: TBusObjClass; Qrymain: TERPQuery; Value: String; KeyStringField: String); Overload; virtual;
      Function SaveOrCancelChanges: boolean; virtual;
      procedure CustomFieldRefreshExtra(const CustomfieldPrefix: String; const ctr: integer); Virtual;
      procedure CustomFieldsRefresh; Virtual;
      procedure SetStateParams(const Value: TJsonObject); virtual;
      Procedure ColorToInactive(fFont: Tfont);
      Procedure ColorToActive(fFont: Tfont);
      Function IsLocalPrefChanged: boolean; virtual;
      Procedure SwapPairdField(Ds: TDataSet; grd: TwwDBGrid; fieldshown, fieldtobeshown: String);
      procedure ShowLocalProgressbar(Progresscount: integer; Progressbarcaption: string; ProgressBarMessage: string = ''; IsPercenage: boolean = true);
      procedure StepLocalProgressbar(const ProgressBarMessage: String = ''); Overload;
      procedure HideLocalProgressbar; Overload;
      Procedure DoExtraTranslation; Override;
      procedure Openrecord(const ID: integer; const ComponentClassType: String); virtual;
      procedure AfterSubFormShow(Sender: TObject); virtual;
      procedure beforeSubFormShow(Sender: TObject); virtual;

      function formID: integer;
      Procedure ShowformComments;
      procedure DEtachAll;
      procedure FlagAsUpdated(aMainDataset: TDataSet);
      function IDfromcombo(Combo: TwwDBLookupCombo): integer; virtual;
      function SearchIDnUpdateName(Combo: TwwDBLookupCombo; LookupIDFieldName: String; LookupID: integer; fDataset: TDataSet; datasetfieldName: string; LookupFieldname: String)
        : boolean; virtual;
      Procedure TaxCodecomboHint(const TaxCodecombo: TwwDBLookupCombo);
      Procedure AddDisablescontrolforHint(const ParentPanel: TPanel; disabledcontrol: TControl; const ControlHint: String);
      Procedure InitGuiPrefsReadonlyFields; virtual;
      procedure GridTitleButtonClick(Sender: TObject; AfieldName: String); virtual;
      Procedure DoMemoriseTrans(const fID, fclientID: integer; autoPost: boolean; title: string);
      Function MakeForm(Const ComponentClassName: string; Const SingleInstance: boolean = true; Const Owner: TComponent = nil; Const CheckAccessLevel: boolean = true;
        Const showErrorMsg: boolean = true; Const iTag: integer = 0): TComponent;
      Procedure AssignConnectionToAllQrys(const Value: TERPConnection); virtual;
      procedure SetTransConnection(const Value: TERPConnection); Virtual;
      function GetCancelGridSort: boolean; virtual;
      property CancelGridSort: boolean read GetCancelGridSort write fCancelGridSort;
      (* Procedure FormatProductCombo(cbo:TERPDbLookupCombo); *)
      procedure DoFormSize(ChangeSize: boolean); virtual;
      procedure OnClearGridBedorePait(Grid: TwwDBGrid); virtual;
      //
      Procedure TransApprovalInit(checkApproved: TwwCheckBox; aTranstype:String; aBusobj:TMSBusobj; AmtName:String;AssignOnclick :Boolean = False;aApprovercombo :TwwDBLookupcombo =nil; aApproverlbl:TLabel = nil; aApprovernotify : Twwcheckbox = nil);
      //Procedure PrintTemplateOptionsReport(Sender: TTemplateOptions); virtual;
(*      procedure initPrintTemplateOptionsReport(Sender: TTemplateOptions; var sSQL: String; var MasterDetailLink: TJsonObject;
        var ShowCancelPreviewBtninReportPreview: boolean); Virtual;*)
      //procedure initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions; var OutGoingFileName: String; var Corres: TCorrespondenceGui); Virtual;
      procedure BusobjProgressbarEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
      Procedure InitERPLookupCombonFields; virtual;
      Procedure OnGuiPrefsActive(Sender: TObject); Virtual;
      procedure SetupClientNamenPrintNameinGrid(SelectedcleintID: integer; Combo, Printcombo: TERPDbLookupcombo; Fieldname, Printfieldname: String; Grid: TwwDBGrid;
        supplierList, CustomerList, ProspectList, JobList, SearchOnPrintName: boolean);
      procedure SetupProductNamenPrintNameinGrid(Combo, Printcombo: TERPDbLookupcombo; Fieldname, Printfieldname, DescField: String; Grid: TwwDBGrid;
        SearchonPreferredSupplier: boolean = true; SearchOnPrintName: boolean = true; SearchOnGroupfields: boolean = true);
      Function NamenPrintNameGridObj: TNamenPrintNameGridObj;
      procedure Saveclose;Virtual;
      procedure OnPasteSelection(var Key: word);Virtual;
      procedure OnCopySelection(var Key: word);Virtual;
      procedure DoAfterShowCustomiseForm; virtual;
      procedure InitGridcolumnsforGuiPrefs(sender: TwwDBGrid=nil);Virtual;
      Procedure InitreportOptionsform(Sender:TObject);Virtual;
      Function EmailOptiontoStr(const Value:Integer):string;
      Function PrefOptionObj(aSinglebuttonCaption: string;
                        afocuscontrolName: string;
                        aAccesslevel:Integer = 0;
                        aOpenAsModel: boolean = true;
                        aTextSearch: string = '';
                        aSinglePanelToshow: string = '';
                        ainitMsg: string=''): TPrefOptionObj;
      Procedure SetcontrolProperties(const comp :Tcomponent);virtual;
      Procedure InitForDefaultOptionsGrid;Virtual;
      Function ConnInTrans :TERPConnection;Virtual;
      Procedure SaveLastComboAccessed(var aLastComboAccessed:TwwDBLookupCombo; Sender:TObject);
      Procedure InitEERPDBLookupcombo(Combo : TwwDBLookupcombo;PER: PEventRec);Virtual;
      procedure OnERPComboEnter(Sender: TObject);Virtual;
      procedure OnERPComboDblClick(Sender: TObject);Virtual;
      procedure SetDnMPanelProperties(const Panel: TDNMPanel;DnMPanelPropertiesProc: TNotifyEvent=nil);
      Procedure CaptureQueryEvents;
      procedure OnQueryAfterOpen(DataSet: TDataSet);Virtual;
      procedure OnQueryBeforeOpen(DataSet: TDataSet);Virtual;
      procedure ReadnApplyGuiPrefExtra; virtual;
      Procedure WriteGuiPrefExtra; virtual;

    public { Public declarations }
      fbStartingUp: boolean;
      UserLock    : TUserLock;
      { Class functions - To be used without the need to create the object.     The FormActive function will be useful to determine if a form exists     prior to showing it. If you want to dispose of the form, call CloseMe, bare in     mind that only a few forms implement this functionality, e.g frmCustomerFrm } { Nice To Have - Would be good to change the instance method accept     and Owner as a parameter. Future enhancement :) }
      // class function Instance: TBaseInputGUI; virtual;
      fbReportSQLSupplied: boolean;
      GuiPrefs           : TFormGuiPrefs; { Enable/Disable combo boxes b/c we don't want their events to fire if the user doesn't have access }
      fbReopeningForm    : boolean;
      fsReopeningFormClass    : String;
      function DoNotAskMsg: boolean;Virtual;
      procedure DoOnDoNotAskMsgCheck(Sender: TObject; Checked: boolean);Virtual;
      Function MessageOption:Integer; Virtual;
      procedure PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject = nil;
        fsPrintename: String = ''; ShowCancelPreviewBtninReportPreview: boolean = false); Override;
      class function FormActive: boolean; virtual;
      class procedure CloseMe; virtual; { Implements a basic observer pattern. The notify will update the appropriate List }
      class function Load(const aClassName: string; const aKeyID: integer; oObserver: TObject = nil): TBaseInputGUI;
      procedure AttachObserver(const oObserver: TObject);
      procedure DetachObserver(const oObserver: TObject);
      procedure Notify; overload; virtual;
      procedure Notify(const Cancelled: boolean); overload; virtual; { Subjects can also be observers, you need to implement/override this method in descendants }
      procedure UpdateMe; overload; virtual;
      property TemplateReportName[ChooseReport: boolean; LoadReportTypesconditions: String]: string read getReportName;
      // procedure UpdateMe(const Cancelled: boolean; const Form: TForm = nil); overload; virtual;// flags methods
      procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); overload; virtual; // flags methods
      procedure onUpdateMe_Cancelled;Virtual;
      function AnyOfFlags(const Values: array of string): boolean;
      function IsFlag(const FlagName: string; const Reset: boolean = false): boolean;
      function NoneFlags(const Values: array of string): boolean;
      procedure AddFlag(const FlagName: string);
      procedure AddFlags(const Values: array of string);
      procedure RemoveFlag(const FlagName: string);
      procedure RemoveFlags(const Values: array of string);
      property MarketingEnquiryID: integer read iMarketingEnquiryID write iMarketingEnquiryID;
      property CallingClassName: string read fCallingClassName write fCallingClassName;
      Property ConnectionFormReport: TERPConnection read fConnectionFormReport write fConnectionFormReport;
      property ErrorOccurred: boolean read fbStartupErrorOccurred write fbStartupErrorOccurred default false;
      property AllowCustomiseGrid: boolean read fAllowCustomiseGrid write SetAllowCustomiseGrid;
      // property CourseUpdation: TCourseUpdation read fCourseUpdation write fCourseUpdation;
      Property ShowCustomisemenu: boolean read fShowCustomisemenu write fShowCustomisemenu;
      property AllowGridSorting: boolean Read fAllowGridSorting write fAllowGridSorting;
      Property GridstoExcludeFromsorting: String read fsGridstoExcludeFromsorting write fsGridstoExcludeFromsorting;
      Property GridstoExcludefromcustomize: String read fsGridstoExcludefromcustomize Write fsGridstoExcludefromcustomize;
      Property GridsToIncludeforDefaultOptions: String read fsGridsToIncludeforDefaultOptions Write fsGridsToIncludeforDefaultOptions;
      property TabColor: TColor read fTabColor write fTabColor;
      property TransConnection: TERPConnection read fTransConnection write SetTransConnection;
      property BusinessObject: TObject read GetBusinessObject;
      constructor CreateWithAccessLevel(const AOwner: TComponent; const FormAccessLevel: integer);
      constructor Create(AOwner: TComponent); override;
      Procedure excludeGridfromsorting(Const Sender: TwwDBGrid);
      Procedure ExcludeGridfromcustomize(const Sender: TwwDBGrid);
      procedure IncludeForDefaultOptions(const Sender: TwwDBGrid);
      Procedure ActivateGuiPrefs(Const Value: boolean = true);
      Function ReadGuipref(Const Prefname: String): String;
      Procedure WriteGuiPref(Const Prefname: String; Value: String);
      function DoComboToPopUp(const Fieldname: string; const cbo: TwwDBLookupCombo): boolean; virtual;
      Procedure AfterPopupformshow; virtual;
      property StateParams: TJsonObject read FStateParams write SetStateParams;
      function CustomFieldExtenderListtype: TListType; virtual;
      procedure CallHookupComboEvents;
      Procedure ReadSubformGuiPrefs; virtual;
      Procedure SetPagefocus(Page: TPagecontrol; Tabsheet: TTabsheet; Control: TWincontrol);
      procedure AddFieldtoGrid(const Grid: TwwDBGrid; const fsfieldName: string; fieldIndex: integer = -1);
      Property CancelPreviewAll: boolean read getCancelPreviewAll;
      Procedure CloseUpIdUpdateError(Sender: TObject; E: Exception); Virtual;
      Property ReopeningForm: boolean read fbReopeningForm write fbReopeningForm;
      Property ReopeningFormClass: String read fsReopeningFormClass write fsReopeningFormClass;
      function SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport';MasterDetailLink: TJsonObject = nil): boolean;Override;
      Property BusobjAuditLogDetails :String read fsBusobjAuditLogDetails;
      Procedure EnabletmrOnshow(atmrOnshowNo:Integer;Seconds :Integer = 1);virtual;
      Procedure DoFocusControl(Const FocusControltype:String);virtual;
      procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
      property LastComboAccessed: TwwDBLookupCombo read fLastComboAccessed write fLastComboAccessed;
      Procedure ShowUserApprovalPref;
  published
      property KeyID         : integer read fiKeyID write SetKeyId;
      property KeyString     : string read GetKeyString write SetKeyString;
      Property ComboCreateMew: boolean read fbComboCreateMew write fbComboCreateMew;
    end;

implementation

{$R *.dfm}
  { Access Levels   *************   1 = Full Access   2 = Full Access No Delete   3 = Create + Read * Note :-> This mode has been omitted from the Transaction forms   due to the complexity of the Edit/Post mechanism.   5 = Read Only   6 = No Access }

  uses FastFuncs, CommonDbLib, CommonLib, DNMLib, // AuditObj,
    FormFactory, StrUtils, DNMExceptions, Wwdbcomb, GlobalEventsObj,
    tcDataUtils, AppEnvironment, DNMAccessManager, tcConst, ClassExtenderListObj,
    BaseListingForm, MonitorTransactionEvents, EmployeeObj{$IFDEF EXCEPTIONAL_MAGIC}, EMHelper{$ENDIF},
    CommonFormLib, EmailUtils, InuseFormslib, BusObjPreference,
    MySQLConst, FormReopenerObj, frmFormcomments, frmObjectProperties, frmRepeat,
    DbSharedObjectsObj, commonGuiLib, BusObjConst, LogLib, EmployeeAccesses, MAIN, ERPErrorEmailUtils,
    AppDatabase, EmailExtraUtils ,ERPVersionConst , Vista_MessageDlg,
  Preferences;

  constructor TBaseInputGUI.Create(AOwner: TComponent);
  begin
    fbExludeDiscontProductinProductcombo  := false;
    fbExludeInactiveProductinProductcombo := false;
    fPreventClick                         := false;
    fbInComboNotinList                    := false;
    fTransConnection                      := nil;
    AllowGridSorting                      := false;
    GridstoExcludeFromsorting             := '';
    GridstoExcludefromcustomize           := '';
    GridsToIncludeforDefaultOptions       := '';
    fiKeyID                               := 0;
    fLastComboAccessed := nil;
    inherited;
    DescImageIndex := 1;
    ascImageIndex  := 0;
  end;

  constructor TBaseInputGUI.CreateWithAccessLevel(const AOwner: TComponent; const FormAccessLevel: integer);
  begin
    fPreventClick                         := false;
    fTransConnection                      := nil;
    fbExludeDiscontProductinProductcombo  := false;
    fbExludeInactiveProductinProductcombo := false;
    inherited Create(AOwner);
    AccessLevel := FormAccessLevel;
  end;

    procedure TBaseInputGUI.SetDnMPanelProperties(const Panel: TDNMPanel; DnMPanelPropertiesProc:TNotifyEvent=nil);
    var
      fIndex: integer;
    begin
      if Assigned(DnMPanelPropertiesProc) then DnMPanelPropertiesProc(TDNMPanel(Panel))
      else begin
        Panel.Transparent := false;
        Panel.Color       := fTabColor;
      end;
      for fIndex := 0 to Panel.ControlCount - 1 do begin
        if Panel.Controls[fIndex] is TDNMPanel then
          SetDnMPanelProperties(TDNMPanel(Panel.Controls[fIndex]),DnMPanelPropertiesProc);
      end;
    end;
  procedure TBaseInputGUI.FormCreate(Sender: TObject);
  var
    Index       : integer;
    ControlIndex: integer;
    FoundBtn    : boolean;
    PER         : PEventRec;
  begin
    fApprovalcheckObj:= nil;
    fitmrOnshowNo :=0;
    fsMessageOptionPrefix:='';
    fsBusobjAuditLogDetails := '';
    fPrefOptionObj := nil;
    ReopeningForm          := false;
    ReopeningFormClass     := '';
    fNamenPrintNameGridObj := nil;
    ComboCreateMew         := false;
    DoingonComboDblClick   := false;
    DoingonComboNotInlist  := false;
    SetLength(DisablescontrolsHints, 0);
    DisablescontrolHintWindow := nil;
    CancelGridSort            := false;
    fbforceSavesound          := false;
    fbForceRollbackSound      := false;
    fbNoSavesound             := true;
    fbNoCanelsound            := true;
    inherited;
    ShowAtCursor:= False;
    fsBusobjClassname := '';
    // LocalProgressbarcount:= 0;
    ObserverList.DisableNotifyLists := Appenv.CompanyPrefs.DisableNotifyLists;
    fSavePointActive                := false;
    BusObjqueries                   := nil;
    //PrintTemplate                   := TPrintTemplates.Create;
    fGridQueue                      := TQueue.Create;
    fPaintTimer                     := TTimer.Create(Self);
    fPaintTimer.Interval            := 1000;
    fPaintTimer.Enabled             := false;
    fPaintTimer.OnTimer             := PaintTimerTimeout;
    fTabColor                       := Self.Color; // ColorAdjustLuma(GetGradientColor(Self.ClassName).Color,GetGradientColor(Self.ClassName).AdjLuma div 2 , False);
    (* Self.Color := fTabColor; *)
    GuiPrefs                := TFormGuiPrefs.Create(Self);
    GuiPrefs.OnActive       := OnGuiPrefsActive;
    fsForeignkeyValidations := nil;
    InitForDefaultOptionsGrid;
    SetupCustomiseGrid;
    SetupgridSorting;
    FFlags              := TSimpleFlags.Create;
    DoingNotify         := false;
    UserLock            := TUserLock.Create(Self);
    UserLock.Enabled    := false;
    iMarketingEnquiryID := 0;
    // Clear Design Time Connections
    MyConnection.Connected := false;
    MyConnection.Password  := '';
    MyConnection.Username  := '';
    MyConnection.Database  := '';
    MyConnection.Server    := '';
    fConnectionFormReport  := nil;
    fbReportSQLSupplied    := false;
    fbStartingUp           := true;
    fbAllowNotInList       := true;
    fStoredCompletedClick  := nil;
    // fbRestoringForm := False;
    fCutAndPasteAdded := false;
    customiseGridDateTimePicker;
    ProcessingCursor;
    try
      // DNMAccessManager1 := TDNMAccessManager.Create(self);
      // flstObservers     := TList.Create;
      CheckForOpenDatasets;
      SetConnectionString;
      try
        InitERPLookupCombonFields;
      Except
        // ignore exception if the busobj is not created yet - applicablee for some forms
      end;
      if not fbIgnoreAccessLevels then begin
        if AccessLevel = 6 then begin
          fbNoAccess    := true;
          ErrorOccurred := true;
          fbStartingUp  := false;
          Exit;
        end;
      end
      else begin
        AccessLevel := 1;
      end;
      pTabStops           := tpersonaltabs.Create(Self, Appenv.Employee.EmployeeID);
      fbTabSettingEnabled := true;
      Index               := 0;
      FoundBtn            := false;
      while (Index < ComponentCount) and (FoundBtn = false) do begin
        if (Components[Index] is TDnmSpeedButton) and ((Components[Index].Name = 'btnSave') or (Components[Index].Name = 'cmdSave') or (Components[Index].Name = 'btnOK') or
            (Components[Index].Name = 'cmdOk') or (Components[Index].Name = 'btnCompleted')) then begin
          fStoredCompletedClick                      := TDnmSpeedButton(Components[Index]).OnClick;
          TDnmSpeedButton(Components[Index]).OnClick := CompletedClick;
          FoundBtn                                   := true;
        end
        else Inc(Index);

      end;

      if not fbTabPaintDisabled then begin
        for Index := 0 to ComponentCount - 1 do begin
          if Components[Index] is TPagecontrol then begin
            TPagecontrol(Components[Index]).OwnerDraw := true;
            TPagecontrol(Components[Index]).OnDrawTab := PageControlDrawTab;

            { dynamic function for the on change event - for hint }
            if Assigned(TPagecontrol(Components[Index]).OnChange) then begin
              System.New(PER);
              PER^.EventType := on_change;
              PER^.Name      := TPagecontrol(Components[Index]).Name;
              PER^.Data      := TMethod(TPagecontrol(Components[Index]).OnChange).Data;
              PER^.Code      := TMethod(TPagecontrol(Components[Index]).OnChange).Code;
              EventList.Add(PER);
            end;
            TPagecontrol(Components[Index]).OnChange := pageControlChange;
          end else if Components[Index] is TTabsheet then begin
            TTabsheet(Components[Index]).OnShow := TabSheetShow;
            { dynamic function for the on-exit event  - for hint }
            if Assigned(TTabsheet(Components[Index]).OnExit) then begin
              System.New(PER);
              PER^.EventType := on_Exit;
              PER^.Name      := TTabsheet(Components[Index]).Name;
              PER^.Data      := TMethod(TTabsheet(Components[Index]).OnExit).Data;
              PER^.Code      := TMethod(TTabsheet(Components[Index]).OnExit).Code;
              EventList.Add(PER);
            end;
            TTabsheet(Components[Index]).OnExit := Tabcontrolexit;

            for ControlIndex := 0 to TTabsheet(Components[Index]).ControlCount - 1 do begin
              if TTabsheet(Components[Index]).Controls[ControlIndex] is TDNMPanel then SetDnMPanelProperties(TDNMPanel(TTabsheet(Components[Index]).Controls[ControlIndex]));
              SetcontrolProperties(Components[Index]);
            end;
          end;
        end;
      end;
    finally
      ProcessingCursor(false);
    end;

    for Index := 0 to ComponentCount - 1 do begin
      if Components[Index] is TERPDbLookupcombo then begin
        if Assigned(TERPDbLookupcombo(Components[Index]).OnBeforeOpenList) then begin
          System.New(PER);
          PER^.EventType := On_BeforeOpenList;
          PER^.Name      := TERPDbLookupcombo(Components[Index]).Lookupformclassname;
          PER^.Data      := TMethod(TERPDbLookupcombo(Components[Index]).OnBeforeOpenList).Data;
          PER^.Code      := TMethod(TERPDbLookupcombo(Components[Index]).OnBeforeOpenList).Code;
          EventList.Add(PER);
        end;
        TERPDbLookupcombo(Components[Index]).OnBeforeOpenList := OnERPComboBeforeOpenList;
      end;
      if Components[Index] is TwwDBLookupcombo then begin
        InitEERPDBLookupcombo(TwwDBLookupcombo(Components[Index]) ,PER);
      end;
    end;

    // fExtenderList:= TClassExtenderList.Create(self);
    ClassExtenderList.CreateExtenderClasses(Self);
    if not ErrorOccurred then begin
      GlobalEvents.Notify(Self, GEVENT_FormCreate);
    end;
    MonitorConnectionEvents;

end;
Procedure TBaseInputGUI.InitEERPDBLookupcombo(Combo : TwwDBLookupcombo;PER : PEventRec);
begin
    if Assigned(Combo.OnEnter) then begin
            System.New(PER);
            PER^.EventType := On_Enter;
            PER^.Name      := Combo.name;//Lookupformclassname;
            PER^.Data      := TMethod(Combo.OnEnter).Data;
            PER^.Code      := TMethod(Combo.OnEnter).Code;
            EventList.Add(PER);
    end;
    Combo.OnEnter := OnERPComboEnter;
    if Assigned(Combo.OnDblClick) then begin
            System.New(PER);
            PER^.EventType := On_DblClick;
            PER^.Name      := Combo.name;//Lookupformclassname;
            PER^.Data      := TMethod(Combo.OnDblClick).Data;
            PER^.Code      := TMethod(Combo.OnDblClick).Code;
            EventList.Add(PER);
    end;
    Combo.OnDblClick := OnERPComboDblClick;
end;
procedure TBaseInputGUI.OnERPComboEnter(Sender:TObject);
  var
    EventRec   : TFormEventRec;
    NotifyEvent: TNotifyEvent;
begin
    SaveLastComboAccessed(fLastComboAccessed ,Sender);


    if Self.GetEventRec(EventRec, TERPDbLookupcombo(Sender).name, On_Enter) then begin
      TMethod(NotifyEvent).Data := EventRec.Data;
      TMethod(NotifyEvent).Code := EventRec.Code;
      NotifyEvent(Sender);
    end;
end;
procedure TBaseInputGUI.OnERPComboDblClick(Sender:TObject);
  var
    EventRec   : TFormEventRec;
    NotifyEvent: TNotifyEvent;
begin
    SaveLastComboAccessed(fLastComboAccessed ,Sender);

    if Self.GetEventRec(EventRec, TERPDbLookupcombo(Sender).name, On_DblClick) then begin
      TMethod(NotifyEvent).Data := EventRec.Data;
      TMethod(NotifyEvent).Code := EventRec.Code;
      NotifyEvent(Sender);
    end;
    OnComboDblClick(Sender);
end;
procedure TBaseInputGUI.SetcontrolProperties(const comp: Tcomponent);
begin
  // descendants forms can override if any special compoenent requires colour set etc.
end;

  Procedure TBaseInputGUI.OnERPComboBeforeOpenList(Sender: TObject);
  var
    EventRec   : TFormEventRec;
    NotifyEvent: TNotifyEvent;
    s          : String;
  begin
    NotifyEvent := nil;
    if not(Sender is TBaseListingGUI) then Exit;

    s := '';
    if fbExludeDiscontProductinProductcombo then
      if Sender.ClassNameIs('TProductListExpressGUI') then begin
        s := '(Discontinued="F")';
      end;

    if fbExludeInactiveProductinProductcombo then
      if Sender.ClassNameIs('TProductListExpressGUI') then begin
        if s <> '' then s := s + ' and ';
        s                 := s + ' (Active="T")';
      end;

    if s <> '' then
      if TBaseListingGUI(Sender).FilterString <> '' then TBaseListingGUI(Sender).FilterString := '(' + TBaseListingGUI(Sender).FilterString + ') and (' + s + ')'
      else TBaseListingGUI(Sender).FilterString                                               := s;

    if Self.GetEventRec(EventRec, Sender.classname, On_BeforeOpenList) then begin
      TMethod(NotifyEvent).Data := EventRec.Data;
      TMethod(NotifyEvent).Code := EventRec.Code;
      NotifyEvent(Sender);
    end;

  end;

  procedure TBaseInputGUI.DEtachAll;
  begin
    ObserverList.DEtachAll(Self);
  end;

  procedure TBaseInputGUI.FormDestroy(Sender: TObject);
  begin
    DEtachAll;
    FreeandNil(fPrefOptionObj);
    FreeandNil(fApprovalcheckObj);
    if Assigned(FFlags) then FreeAndNil(FFlags);
    if Assigned(MyConnection) then begin
      if MyConnection.intransaction then begin
        RollbackTransaction;
      end;
      try
        if MyConnection.intransaction then MyConnection.Rollback;
      except
      end;
    end;

    If Assigned(pTabStops) then FreeAndNil(pTabStops);
    // if Assigned(flstObservers) then Begin
    // flstObservers.Clear;
    // FreeAndNil(flstObservers);
    // end;

    If Assigned(fGridQueue) then FreeAndNil(fGridQueue);
    //If Assigned(PrintTemplate) then FreeAndNil(PrintTemplate);

    // Deregister any event handlers that have been registered by ancestor forms
    GlobalEvents.DeregisterHandlers(Self);
    try
      if Assigned(MyConnection) then
        if MyConnection.Connected then MyConnection.Disconnect;
    except

    end;
    if fNamenPrintNameGridObj <> nil then FreeAndNil(fNamenPrintNameGridObj);
    FreeAndNil(GuiPrefs);
    Inherited;
  end;

  procedure TBaseInputGUI.FormShow(Sender: TObject);
  var
    X: integer;
  begin
    // ExtenderList.DoEvent(self,ExEvent_BeforeFormShow);
    fbNoAccess := false;
    // if access is CREATE-READ then set to READONLY if we are using this form
    // .. to view an existing enty (KeyID not zero) othewise set the access level to
    // .. FULL-NO DELETE
    if AccessLevel = 3 then begin
      if KeyID = 0 then begin
        AccessLevel := 2;
      end
      else begin
        AccessLevel := 5;
      end;
    end;
    if Self.fbIgnoreAccessLevels then begin
      AccessLevel := 1;
    end;
    if (AccessLevel = 6) then begin
      fbNoAccess    := true;
      ErrorOccurred := true;
      fbStartingUp  := false;
      raise ENoAccess.Create('You do not have Access to ' + GetFormDescription(Self.Classname));
    end
    else if (AccessLevel = 5) and (KeyID = 0) and (not(ClassNameIs('TPreferencesGUI'))) then begin
      fbNoAccess := true;
      if GetFormDescription(Self.Classname) <> '' then
        if not(Self.Owner is TBaseInputGUI) or (TBaseInputGUI(Self.Owner).AccessLevel <= 2) then
            CommonLib.MessageDlgXP_Vista('You have ''Read-only'' access to ' + GetFormDescription(Self.Classname), mtInformation, [mbOK], 0);
      // raise ENoAccess.Create('You have Read Only Access to ' + GetFormDescription(Self.ClassName));
    end;
    ProcessingCursor;
    try
      // FormConnection.Open;

      MakeBusobjPropertiesMenuoption;
      MyConnection.Open;

      if fbTabSettingEnabled then
        if not pTabStops.HookGridDataSets then pTabStops.Initialise(nil); // no gridDataSets:
      Self.AccessManager.Initialize(AccessLevel, BusObjqueries);
      Left := (Application.MainForm.ClientWidth - Self.Width) shr 1; // Left := (MainForm.ClientWidth div 2) - (Self.Width div 2);
      SetClassLabels(Self);
      EnableDisable; // Assign our Combo Double Click Event.
      HookupComboEvents;
      DisableDeleteBoxesInGrids;
      Activate;
    finally
      ProcessingCursor(false);
    end;
    inherited;
    InitGuiPrefsReadonlyFields;
    for X := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[X] is TERPDbLookupcombo then begin
        if not GuiPrefs.Active then
          try
            GuiPrefs.Active := true;
          Except
            on E: Exception do begin
              DeletenReInitPref;
            end;
          end;
        TERPDbLookupcombo(Components[X]).SearchMode := TERPLookupComboSearchMode(GuiPrefs.Node[TERPDbLookupcombo(Components[X]).Name + '.SearchMode'].AsInteger);
      end;
    end;

    GlobalEvents.Notify(Self, GEVENT_FormShow);
    DoFormSize(false);
    ReadnApplyGuiPrefExtra;
  end;

  procedure TBaseInputGUI.DeletenReInitPref;
  var
    Msg: string;
  begin
    TPreference.DeleteUserPrefs(Appenv.Employee.EmployeeID, Msg, MyConnection);
    GuiPrefs.Active := false;
    GuiPrefs.Active := true;
  end;

  procedure TBaseInputGUI.EnableDisable; // Enables / disables components according to access levels
  var
    iIndex  : integer;
    bEnabled: boolean;
  begin
    bEnabled   := AccessLevel < 5;
    for iIndex := 0 to ComponentCount - 1 do begin
      if Components[iIndex] is TWincontrol then begin // Combos
        if Components[iIndex] is TwwDBLookupCombo then begin
          if (TwwDBLookupCombo(Components[iIndex]).DataSource <> nil) then begin
            TwwDBLookupCombo(Components[iIndex]).Enabled := bEnabled;
          end;
        end; // Grids
        if Components[iIndex] is TwwDBGrid then begin
          TwwDBGrid(Components[iIndex]).ReadOnly := not bEnabled;
        end;

        if Components[iIndex] is TDnmSpeedButton then begin
          if (Components[iIndex].Name = 'btnSave') or (Components[iIndex].Name = 'btnNew') or (Components[iIndex].Name = 'cmdOk') or (Components[iIndex].Name = 'btnCompleted') or
            (Components[iIndex].Name = 'cmdSave') or (Components[iIndex].Name = 'cmdNew') then begin
            if TDnmSpeedButton(Components[iIndex]).Enabled then begin
              TDnmSpeedButton(Components[iIndex]).Enabled := bEnabled;
            end;
          end;
        end;
      end;
    end;
  end;

class function TBaseInputGUI.FormActive: boolean;
  begin
    result := FormStillOpen(Self.Classname);
    { ML - This method can be overwritten in descendants to determine if the instance is already alive,   where you need this functionality. }
  end;

  (* procedure TBaseInputGUI.FormatProductCombo(cbo: TERPDbLookupCombo);
    var
    st1:TStringlist;
    ctr:Integer;
    TempStr:String;
    tempS : string;
    begin

    st1:= TStringlist.create;
    st1.Delimiter := #9;
    try
    st1.text:= cbo.selected.text;
    for ctr:= 0 to st1.count -1 do begin
    tempS := ExtractStrPortion(cbo.Selected[ctr], #9, 1);
    TempStr := ExtractStrPortion(cbo.Selected[ctr], #9, 2);
    if Sametext(tempS , 'ProductPrintName'            ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductNameDropdownWidth))
    else if Sametext(tempS , 'PARTNAME'            ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductNameDropdownWidth))
    else if Sametext(tempS , 'Dept'                ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductThirdcolumnDropdownWidth))
    else if Sametext(tempS , 'Manuf'               ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductFirstcolumnDropdownWidth))
    else if Sametext(tempS , 'Type'                ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductSecondcolumnDropdownWidth))
    else if Sametext(tempS , 'PARTSDESCRIPTION'    ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductSalesDescDropdownWidth))
    else if Sametext(tempS , 'PreferedSupp'        ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductPreferedSupDropdownWidth))
    else if Sametext(tempS , 'PURCHASEDESC'        ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductPODescDropdownWidth))
    else if Sametext(tempS , 'SupplierProductCode' ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductSupplierProductCodeDropdownWidth));

    if Sametext(tempS , 'ProductPrintName' ) then if Trim(AppEnv.DefaultClass.PartColumn   ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'ProductPrintName', appenv.companyPrefs.ProductPrintNameHeading  , SptUpdateLabel)
    else if Sametext(tempS , 'PARTNAME' ) then if Trim(AppEnv.DefaultClass.PartColumn   ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'PartName', AppEnv.DefaultClass.PartColumn  , SptUpdateLabel)
    else if Sametext(tempS , 'ProductPrintName' ) then if Trim(appenv.companyPrefs.ProductPrintNameHeading   ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'ProductPrintName', appenv.companyPrefs.ProductPrintNameHeading  , SptUpdateLabel)
    else if Sametext(tempS , 'Dept'     ) then if Trim(AppEnv.DefaultClass.FirstColumn  ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'Manuf'   , AppEnv.DefaultClass.FirstColumn , SptUpdateLabel)
    else if Sametext(tempS , 'Manuf'    ) then if Trim(AppEnv.DefaultClass.SecondColumn ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'Type'    , AppEnv.DefaultClass.SecondColumn, SptUpdateLabel)
    else if Sametext(tempS , 'Type'     ) then if Trim(AppEnv.DefaultClass.ThirdColumn  ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'Dept'    , AppEnv.DefaultClass.ThirdColumn , SptUpdateLabel)
    else if Sametext(tempS , 'CustomerName' ) then if Trim(AppEnv.DefaultClass.CustomerColumnName   ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'CustomerName', AppEnv.DefaultClass.CustomerColumnName  , SptUpdateLabel)
    else if Sametext(tempS , 'SupplierName' ) then if Trim(AppEnv.DefaultClass.SupplierColumnName   ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'SupplierName', AppEnv.DefaultClass.SupplierColumnName  , SptUpdateLabel)
    else if Sametext(tempS , 'ProspectName' ) then if Trim(AppEnv.DefaultClass.ProspectColumnName   ) <> '' Then
    UpdateSelectedProp(cbo.Selected, 'ProspectName', AppEnv.DefaultClass.ProspectColumnName  , SptUpdateLabel);
    {
    if Sametext(copy(st1[ctr],1,8 ) , 'PARTNAME'            ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductNameDropdownWidth))
    else if Sametext(copy(st1[ctr],1,4 ) , 'Dept'                ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductfirstcolumnDropdownWidth))
    else if Sametext(copy(st1[ctr],1,5 ) , 'Manuf'               ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductsecondcolumnDropdownWidth))
    else if Sametext(copy(st1[ctr],1,4 ) , 'Type'                ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductthirdcolumnDropdownWidth))
    else if Sametext(copy(st1[ctr],1,16) , 'PARTSDESCRIPTION'    ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductSalesDescDropdownWidth))
    else if Sametext(copy(st1[ctr],1,12) , 'PreferedSupp'        ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductPODescDropdownWidth))
    else if Sametext(copy(st1[ctr],1,12) , 'PURCHASEDESC'        ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductPreferedSupDropdownWidth))
    else if Sametext(copy(st1[ctr],1,19) , 'SupplierProductCode' ) then
    cbo.Selected[ctr] := ReplaceStr(cbo.Selected[ctr], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductSupplierProductCodeDropdownWidth));

    if Sametext(copy(st1[ctr],1,8 ) , 'PARTNAME' ) then if Trim(AppEnv.DefaultClass.PartColumn   ) <> '' Then UpdateSelectedProp(cbo.Selected, 'PartName', AppEnv.DefaultClass.PartColumn  , SptUpdateLabel);
    if Sametext(copy(st1[ctr],1,4 ) , 'Dept'     ) then if Trim(AppEnv.DefaultClass.FirstColumn  ) <> '' Then UpdateSelectedProp(cbo.Selected, 'Manuf'   , AppEnv.DefaultClass.FirstColumn , SptUpdateLabel);
    if Sametext(copy(st1[ctr],1,5 ) , 'Manuf'    ) then if Trim(AppEnv.DefaultClass.SecondColumn ) <> '' Then UpdateSelectedProp(cbo.Selected, 'Type'    , AppEnv.DefaultClass.SecondColumn, SptUpdateLabel);
    if Sametext(copy(st1[ctr],1,4 ) , 'Type'     ) then if Trim(AppEnv.DefaultClass.ThirdColumn  ) <> '' Then UpdateSelectedProp(cbo.Selected, 'Dept'    , AppEnv.DefaultClass.ThirdColumn , SptUpdateLabel);
    }
    end;
    finally
    Freeandnil(st1);
    end;
    end; *)

  class procedure TBaseInputGUI.CloseMe;
  begin
    { ML - This method can be overwritten in descendants to close the instance if already alive. }
  end;

  procedure TBaseInputGUI.AttachObserver(const oObserver: TObject);
  begin
    Assert(oObserver <> nil, 'TBaseInputGUI cannot attach a NIL object');
    ObserverList.Attach(oObserver, Self);

    // try
    // Assert(oObserver <> nil, 'TBaseInputGUI cannot attach a NIL object');
    // if flstObservers.IndexOf(oObserver) = -1 then begin
    // flstObservers.Add(oObserver);
    // end;
    // except
    // end;
  end;

  procedure TBaseInputGUI.beforeOnComboNotInList(Sender: TObject);
  begin

  end;

  procedure TBaseInputGUI.DeactivateDefaultValues;
  var
    DummyArray: array of string;
  begin
    DummyArray := nil;
    DeactivateDefaultValues(DummyArray);
  end;

  procedure TBaseInputGUI.DeactivateDefaultValues(const QueryNamesToExclude: array of string);
  var
    iIndex, iCount: integer;
    bDoDeactivate : boolean;
  begin
    iIndex := 0;
    try
      try
        ProcessingCursor;
        while iIndex < Self.ComponentCount do begin
          if Self.Components[iIndex] is TCustomMyDataSet then begin
            with Self.Components[iIndex] as TCustomMyDataSet do begin
              bDoDeactivate := true;
              for iCount    := Low(QueryNamesToExclude) to High(QueryNamesToExclude) do begin
                if uppercase(Self.Components[iIndex].Name) = uppercase(QueryNamesToExclude[iCount]) then begin
                  bDoDeactivate := false;
                  Break;
                end;
              end;
              if bDoDeactivate then begin
                Options.DefaultValues := false;
              end;
            end;
          end;
          Inc(iIndex);
        end;
      finally
        ProcessingCursor(false);
      end;
    Except
      on E: Exception do begin
        raise Exception.Create('Error:' + Self.Classname + '.DeactivateDefaultValues->' + uppercase(Self.Components[iIndex].Name) + '  Message: ' + E.message);
      end;
    end;
  end;

  procedure TBaseInputGUI.DetachObserver(const oObserver: TObject);
  begin
    if Assigned(oObserver) then begin
      ObserverList.Detach(oObserver, Self);
      // flstObservers.Remove(oObserver);
    end;
  end;

  procedure TBaseInputGUI.Notify;
  // var
  // i: integer;
  begin
    DoingNotify := true;
    try
      ObserverList.Notify(Self);
    finally
      DoingNotify := false;
    end;

    // try
    // DoingNotify := true;
    // try
    // // Calling processMessages will set Terminated true if the exe is shutting down.
    // Application.ProcessMessages;// Don't try and update anything if app is shutting down.
    // if Application.Terminated then Exit;
    // for i := 0 to flstObservers.Count - 1 do begin
    // {This is a way of determining if the observer is still open/active}
    // if not empty(TForm(flstObservers[i]).Name) then begin
    // if TForm(flstObservers[i]) is TBaseListingGUI then begin
    // if not AppEnv.CompanyPrefs.DisableNotifyLists then begin
    //
    // TBaseListingGUI(flstObservers[i]).UpdateMe;
    // end;
    // end else if TForm(flstObservers[i]) is TBaseInputGUI then begin
    // TBaseInputGUI(flstObservers[i]).CompleteComboNotInList(flstObservers[i]);
    // TBaseInputGUI(flstObservers[i]).UpdateMe;
    // end;
    // end;
    // end;
    // finally
    // DoingNotify := false;
    // end;
    // except
    // end;
  end;

  procedure TBaseInputGUI.UpdateMe;
  { Virtual method used to update the observer, must be implemented in descendant }
  begin
  end;

  procedure TBaseInputGUI.CompleteComboNotInList(const aObserver: TObject);
  var
    bOk   : boolean;
    sValue: string;
  begin
    // if this observer opened its form as a result of a notinlist combo event then
    // .. nows the time to refresh the combo.
    bOk := false; // Check if not-in-list processing is active
    if Assigned(fNotInList.Combo) then begin
      with fNotInList.Combo do begin // need to refresh the lookups query so than it gets new value, also
        // .. need to ensure that the lookup is not in transaction mode by setting
        // .. its connection string.
        LookupTable.Close;
        TERPQuery(LookupTable).Connection := CommonDbLib.GetSharedMyDacConnection;
        LookupTable.Open;
        if Assigned(fNotInList.Popup) then begin
          if Assigned(fNotInList.PopUpDataSet) then begin
            if fNotInList.PopUpDataSet.Active then begin
              try // refresh combo values
                if Assigned(fNotInList.PopUpDataSet) then begin
                  sValue := fNotInList.PopUpDataSet.FieldByName(fNotInList.PopUpField).AsString;
                  if not Empty(sValue) then begin
                    if LookupTable.Locate(fNotInList.DisplayField, sValue, [loCaseInsensitive]) then begin
                      LookupValue := LookupTable.FieldByName(LookupField).AsString;
                      if not Empty(DataField) and Assigned(DataSource) then begin
                        DataSource.DataSet.Edit;
                        DataSource.DataSet.FieldByName(DataField).AsString := LookupValue;
                        fNotInList.Combo.RefreshDisplay;
                        if Assigned(fNotInList.Combo.OnCloseUp) then begin
                          fNotInList.Combo.OnCloseUp(TObject(fNotInList.Combo), fNotInList.Combo.LookupTable, fNotInList.Combo.DataSource.DataSet, true);
                        end;
                      end;
                      bOk := true;
                    end;
                  end;
                end;
              except
                on E: Exception do begin
                  // Do nothing, bOk will be false
                end;
              end;
            end;
          end;
        end;
      end;
      if not bOk then begin
        try
          SetControlFocus(fNotInList.Combo);
          // set focus back to combo if we can
        except
          // ignore
          on E: Exception do begin
          end;
        end;
        try
          if Assigned(aObserver) and (aObserver is TForm) then TForm(aObserver).BringToFront;
          Application.ProcessMessages;
        except
        end;
        fNotInList.Combo := nil;
        CommonLib.MessageDlgXP_Vista('Please select new value', mtInformation, [mbOK], 0);
      end;
    end;
  end;

  procedure TBaseInputGUI.CloseQueries;
  var
    iIndex: integer;
    aname : String;
  begin
    for iIndex := 0 to ComponentCount - 1 do begin
      try
        aname :=Components[iIndex].classname +':' + Components[iIndex].name;
          if Components[iIndex] is TERPQuery then begin
            if TERPQuery(Components[iIndex]).Active then TERPQuery(Components[iIndex]).Close;
          end else if Self.Components[iIndex] is TCustomMyDataSet then
            if TCustomMyDataSet(Components[iIndex]).Active then TCustomMyDataSet(Components[iIndex]).Close;
      Except
        on E:EXception do begin
          logtext('CloseQueries -> ' + aname +':' +E.message);
        end;
      end;
    end;
  end;

  procedure TBaseInputGUI.CloseUpIdUpdateError(Sender: TObject; E: Exception);
  begin
    SendEmailtoErp('CloseUpIdUpdateError', '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) + '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
        '    Datase      :' + GetSharedMyDacConnection.Database + chr(13) + '    Version     :' + TABLE_VERSION + chr(13) + '    Combo : ' + heirarchyname(TERPDbLookupcombo(Sender)
        ) + chr(13) + '    Data Select Update History : ' + TERPDbLookupcombo(Sender).DataSelectUpdateHistory + chr(13) + '    Exception : ' + E.message);

  end;

  procedure TBaseInputGUI.OpenQueries;
  var
    DummyArray: array of string;
  begin
    DummyArray := nil;
    OpenQueries(DummyArray);
  end;

  procedure TBaseInputGUI.OpenQueries(const QueryNamesNotToOpen: array of string);
  var
    iIndex, iCount: integer;
    bDoOpen       : boolean;
  begin
    iIndex := 0;
    try
      try
        ProcessingCursor;
        while iIndex < Self.ComponentCount do begin
          if Self.Components[iIndex] is TCustomMyDataSet then begin
            with Self.Components[iIndex] as TCustomMyDataSet do begin
              bDoOpen    := True;
              for iCount := Low(QueryNamesNotToOpen) to High(QueryNamesNotToOpen) do begin
                if uppercase(Self.Components[iIndex].Name) = uppercase(QueryNamesNotToOpen[iCount]) then begin
                  bDoOpen := False;
                  Break;
                end;
              end;
              if bDoOpen then begin
                try
                  Open;
                Except
                  on E: Exception do begin
                    if devmode then MessageDlgXP_Vista('Failed to open Query : ' + TCustomMyDataSet(Self.Components[iIndex]).Name + '.' + NL + E.message, mtError, [mbOK], 0)
                    else raise;
                  end;
                end;
              end;
            end;
          end;
          Inc(iIndex);
        end;
        SetClassLabels(Self);
        // replace '*class* in Labels and wwwDBGrid DisplayLabels
      finally
        ProcessingCursor(False);
      end;
    Except
      on E: Exception do begin
        raise Exception.Create('Error:' + Self.Classname + '.OpenQueries->' + uppercase(Self.Components[iIndex].Name) + '  Message: ' + E.message);
      end;
    end;
  end;

  procedure TBaseInputGUI.CallHookupComboEvents;
  begin
    HookupComboEvents;
  end;


procedure TBaseInputGUI.CheckForOpenDatasets;
  // If finds any open datsets then scolds the programmer
  var
    iIndex: integer;
  begin
    for iIndex := 0 to Self.ComponentCount - 1 do begin
      (* if Self.Components[iIndex] is TCustomMyConnection then begin
        with Self.Components[iIndex] as TCustomMyConnection do begin
        if Active then begin
        CommonLib.MessageDlgXP_Vista('Opened Dataset (' + Self.Components[iIndex].Name + '):  ' + self.ClassName, mtInformation , [mbOK], 0);
        end;
        end;
        end; *)
      if Self.Components[iIndex] is TCustomMyConnection then begin
        with Self.Components[iIndex] as TCustomMyConnection do begin
          if Connected then CommonLib.MessageDlgXP_Vista('Active Connection: ' + Self.Classname, mtInformation, [mbOK], 0);
        end;
      end;
      if Self.Components[iIndex] is TCustomMyDataSet then begin
        with Self.Components[iIndex] as TCustomMyDataSet do begin
          if Active then begin
            CommonLib.MessageDlgXP_Vista('Opened Dataset (' + Self.Components[iIndex].Name + '):  ' + Self.Classname, mtInformation, [mbOK], 0);
          end;
        end;
      end;
      if Self.Components[iIndex] is TERPConnection then begin
        with Self.Components[iIndex] as TERPConnection do begin
          if Connected then CommonLib.MessageDlgXP_Vista('Active Connection: ' + Self.Classname, mtInformation, [mbOK], 0);
        end;
      end;
    end;
  end;

  procedure TBaseInputGUI.SetConnectionString(const TransactionMode: boolean = true);
  var
    iIndex: integer;
  begin
    for iIndex := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iIndex] is TCustomMyDataSet then
        with Self.Components[iIndex] as TCustomMyDataSet do begin
          if (fTransconnection <> nil) and (fTransconnection.connected) then begin
                Connection := fTransconnection ;
          end else if TransactionMode then begin // No
                Connection := MyConnection;
          end else begin // Set standard NON Transaction MyDAC Connection
                Connection := CommonDbLib.GetSharedMyDacConnection;
          end;
        end;
    end;

    MyConnection.Server           := CommonDbLib.GetSharedMyDacConnection.Server;
    MyConnection.Username         := CommonDbLib.GetSharedMyDacConnection.Username;
    MyConnection.Password         := CommonDbLib.GetSharedMyDacConnection.Password;
    MyConnection.Database         := CommonDbLib.GetSharedMyDacConnection.Database;
    MyConnection.Options.Compress := MYDAC_OPTIONS_COMPRESS;
    MyConnection.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;

    // MyConnection.Options.Compress := CommonDbLib.GetSharedMyDacConnection.Options.Compress;
    // MyConnection.Options.Protocol := CommonDbLib.GetSharedMyDacConnection.Options.Protocol;
    MyConnection.Port := CommonDbLib.GetSharedMyDacConnection.Port;
  end;

function TBaseInputGUI.GetEmployeeEmail(const ThisEmployeeID: integer): string;
  var
    qryTempEmail: TERPQuery;
  begin
    qryTempEmail := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qryTempEmail.Sql.Add('SELECT Email FROM tblemployees');
      qryTempEmail.Sql.Add('WHERE EmployeeID =' + IntToStr(ThisEmployeeID));
      qryTempEmail.Active := true;
      if not qryTempEmail.IsEmpty then begin
        result := qryTempEmail.FieldByName('Email').AsString;
      end
      else begin
        result := '';
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTempEmail);
    end;
  end;

  function TBaseInputGUI.GetKeyString: string;
  begin
    result := '';
  end;

  function TBaseInputGUI.GetContactEmail(const ContactID: integer): string;
  var
    qryTempEmail: TERPQuery;

  begin
    qryTempEmail := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qryTempEmail.Sql.Add('SELECT ContactEmail,ContactID FROM tblContacts WHERE ContactID =' + IntToStr(ContactID));
      qryTempEmail.Active := true;
      if not qryTempEmail.IsEmpty then begin
        result := qryTempEmail.FieldByName('ContactEmail').AsString;
      end
      else begin
        result := '';
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTempEmail);
    end;
  end;

  procedure TBaseInputGUI.GetCustomerNameAndEmail(ACustomerId: integer; var email, name: string);
  var
    qryTempEmail: TERPQuery;
    // lName : string;
  begin
    qryTempEmail := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      // lName := '';
      name  := '';
      email := '';
      qryTempEmail.Sql.Add('SELECT Email, FirstName, LastName FROM tblClients');
      qryTempEmail.Sql.Add('WHERE ClientID =' + IntToStr(ACustomerId));
      qryTempEmail.Active := true;
      if not qryTempEmail.IsEmpty then begin
        Name  := trim(qryTempEmail.FieldByName('FirstName').AsString + ' ' + qryTempEmail.FieldByName('LastName').AsString);
        email := qryTempEmail.FieldByName('email').AsString;
        // if Email <> '' then
        // begin
        // Name := lName;
        // exit;
        // end;
      end;

    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTempEmail);
    end;
  end;

  (*
    function TBaseInputGUI.GetContactEmailsForSales(const AClientId: integer;
    const aFieldName: string): TStringList;
    var
    qry: TERPQuery;
    lSet : ERPSets.TIntegerSet;
    begin

    lSet := TIntegerSet.Create;
    try
    Result := TStringList.Create;
    Result.CaseSensitive := false;
    Result.Sorted := true;
    Result.Duplicates := dupIgnore;
    Result.OwnsObjects := false;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
    qry.Sql.Add('SELECT ContactId, ContactEmail from tblContacts where ' + aFieldName + '="T"  and clientId = ' + inttostr(aClientID));
    qry.Active := true;
    while not qry.Eof do
    begin
    if (Result.Count = 0) or not (lSet.Exists(qry.Fields[0].asInteger)) then
    begin
    Result.AddObject(qry.Fields[1].asString, Pointer(qry.Fields[0].asInteger));
    end;
    qry.Next;
    end;

    if Result.Count > 0 then
    exit;

    // not found - check for the primary contact
    qry.Close;
    qry.SQL.Text := 'select ContactId, ContactEmail from tblContacts where IsPrimaryContact="T"   and clientId = ' + inttostr(aClientID);
    qry.Open;

    if not qry.Eof and (qry.Fields[1].AsString <> '') then
    begin
    Result.AddObject(qry.Fields[1].asString, Pointer(qry.Fields[0].asInteger));
    exit;
    end;

    // look for ANY contact with e-mail
    qry.Close;
    qry.SQL.Text := 'select ContactId, ContactEmail from tblContacts where ContactEmail is not null and ContactEmail <> ""   and clientId = ' + inttostr(aClientID);
    qry.Open;
    if not qry.Eof and (qry.Fields[1].AsString <> '') then
    begin
    Result.AddObject(qry.Fields[1].asString, Pointer(qry.Fields[0].asInteger));
    end;
    finally// Free our used objects.
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
    finally
    lSet.Free;
    end;
    end;
  *)
  function TBaseInputGUI.GetCancelGridSort: boolean;
  begin
    result := fCancelGridSort;
  end;

  function TBaseInputGUI.getCancelPreviewAll: boolean;
  begin
    result := PrintTemplate.CancelPreviewAll;
  end;

  function TBaseInputGUI.GetClientEmail(const ThisClientID: integer; OnlyIfPreferedMethod: boolean = false): string;
  var
    qryTempEmail: TERPQuery;
  begin
    qryTempEmail := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qryTempEmail.Sql.Add('SELECT Email,ClientID FROM tblClients');
      qryTempEmail.Sql.Add('WHERE ClientID =' + IntToStr(ThisClientID));
      if OnlyIfPreferedMethod then qryTempEmail.Sql.Add('and DefaultContactMethod = "Email"');
      qryTempEmail.Active := true;
      if not qryTempEmail.IsEmpty then begin
        result := qryTempEmail.FieldByName('Email').AsString;
      end
      else begin
        result := '';
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTempEmail);
    end;
  end;

  (*
    function TBaseInputGUI.GetClientEmailForSales(const aClientId: integer;
    const aFieldName: string; var aContactId : integer): string;
    var
    qry: TERPQuery;
    begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
    qry.Sql.Add('SELECT ContactId, ContactEmail from tblContacts where ' + aFieldName + '="T"  and clientId = ' + inttostr(aClientID));
    qry.Active := true;
    Result := '';
    while not qry.Eof do
    begin
    Result := qry.Fields[1].asString;  // .FieldByName('ContactEmail').asString;
    if Result <> '' then
    begin
    AContactId := qry.Fields[0].AsInteger;
    exit;
    end;
    qry.Next;
    end;
    // not found - check for the primary contact
    qry.Close;
    qry.SQL.Text := 'select ContactId, ContactEmail from tblContacts where IsPrimaryContact="T"   and clientId = ' + inttostr(aClientID);
    qry.Open;

    if not qry.Eof and (qry.Fields[1].AsString <> '') then
    begin
    Result := qry.Fields[1].AsString;
    AContactId := qry.Fields[0].AsInteger;
    exit;
    end;
    // look for ANY contact with e-mail
    qry.Close;
    qry.SQL.Text := 'select ContactId, ContactEmail from tblContacts where ContactEmail is not null and ContactEmail <> ""   and clientId = ' + inttostr(aClientID);
    qry.Open;
    if not qry.Eof and (qry.Fields[1].AsString <> '') then
    begin
    Result := qry.Fields[1].AsString;
    AContactId := qry.Fields[0].AsInteger;
    exit;
    end;
    Result := '';
    AContactId := -1;
    finally// Free our used objects.
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;

    end;
  *)
  function TBaseInputGUI.GetClientName(const ThisClientID: integer): string;
  var
    qryTempEmail: TERPQuery;
  begin
    qryTempEmail := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qryTempEmail.Sql.Add('SELECT Company FROM tblClients WHERE ClientID =' + IntToStr(ThisClientID) + ';');
      qryTempEmail.Active := true;
      if not qryTempEmail.IsEmpty then begin
        result := qryTempEmail.FieldByName('Company').AsString;
      end
      else begin
        result := '';
      end;
    finally // Free our used objects.
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTempEmail);
    end;
  end;

  function TBaseInputGUI.GetCompanyName: string;
  begin
    result := CommonDbLib.GetCompanyName;
  end;

  function TBaseInputGUI.GetCompanyEmail: string;
  begin
    result := CommonDbLib.GetCompanyEmail;
  end;

  procedure TBaseInputGUI.HandleEAbortException;
  begin { Aborting used to manage access levels - Caught the exception, but don't do anything with it }
  end;

  procedure TBaseInputGUI.HandleNoAccessException(const E: Exception; const bExit: boolean = true);
  begin { User doesn't have access }
    ErrorOccurred := true;
    fbStartingUp  := false;
    CommonLib.MessageDlgXP_Vista(E.message, mtInformation, [mbOK], 0);
    if bExit then begin
      Application.ProcessMessages;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0); { Posting a message closes Modal forms }
      // Release;
    end;
  end;

  procedure TBaseInputGUI.FormPaint(Sender: TObject);
  var
    Index: integer;
  begin
    if not fbTabPaintDisabled then begin
      for Index := 0 to ComponentCount - 1 do begin
        if (Components[Index] is TPagecontrol) and Assigned(TPagecontrol(Components[Index]).ActivePage) then TabSheetShow(TPagecontrol(Components[Index]).ActivePage);
        if (Components[Index] is TShader) and (Components[Index].Name = 'TitleShader') then Begin
          TShader(Components[Index]).FromColor     := fTabColor;
          TShader(Components[Index]).ToColorMirror := fTabColor;
        end;
      end;
    end;
    inherited;
  end;

  procedure TBaseInputGUI.BeginTransaction;
  var
    Qry: TMyQuery;
  begin
{$IFDEF EXCEPTIONAL_MAGIC}
    UserActions.Add(uetNone, 0, 0, 'BeginTransaction');
{$ENDIF}
    if Assigned(fTransConnection) and (not fSavePointActive) then begin
      Qry := TMyQuery.Create(nil);
      try
        fSavePointActive := true;
        Qry.Connection   := fTransConnection;
        Qry.Sql.Text     := 'SAVEPOINT ' + Self.Classname + IntToStr(integer(Self));
        Qry.Execute;
      finally
        Qry.Free;
      end;
    end;
    MyConnection.Open;
    // if MyConnection.Connected and not MyConnection.InTransaction then Begin
    if not MyConnection.intransaction then begin
      MyConnection.StartTransaction;
    end;
  end;

  procedure TBaseInputGUI.CommitTransaction;
  var
    Qry: TMyQuery;
  begin
{$IFDEF EXCEPTIONAL_MAGIC}
    UserActions.Add(uetNone, 0, 0, 'CommitTransaction');
{$ENDIF}
    if Assigned(fTransConnection) and fSavePointActive then begin
      Qry := TMyQuery.Create(nil);
      try
        fSavePointActive := false;
        Qry.Connection   := fTransConnection;
        Qry.Sql.Text     := 'RELEASE SAVEPOINT ' + Self.Classname + IntToStr(integer(Self));
        Qry.Execute;
      finally
        Qry.Free;
      end;
    end;
    try
      if MyConnection.Connected and MyConnection.intransaction then begin
        MyConnection.Commit;
      end;
      UnlockRelatedTables;
      GlobalEvents.Notify(Self, GEVENT_AfterCommit);
    except
      RollbackTransaction;
      raise;
    end;
  end;

  procedure TBaseInputGUI.RollbackTransaction;
  var
    Qry: TMyQuery;
  begin
{$IFDEF EXCEPTIONAL_MAGIC}
    UserActions.Add(uetNone, 0, 0, 'RollbackTransaction');
{$ENDIF}
    if Assigned(fTransConnection) and fSavePointActive then begin
      Qry := TMyQuery.Create(nil);
      try
        fSavePointActive := false;
        Qry.Connection   := fTransConnection;
        Qry.Sql.Text     := 'ROLLBACK TO SAVEPOINT ' + Self.Classname + IntToStr(integer(Self));
        Qry.Execute;
      finally
        Qry.Free;
      end;
    end;
    try
      if MyConnection.Connected and MyConnection.intransaction then MyConnection.Rollback;

      UnlockRelatedTables;
      GlobalEvents.Notify(Self, GEVENT_AfterRollBack);
    except
    end;
  end;

  function TBaseInputGUI.DataHasChanged: boolean;
  var
    iIndex: integer;
  begin
    result := DataState.dirty;
    if result then Exit;
    for iIndex := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iIndex] is TERPQuery then begin
        with Self.Components[iIndex] as TERPQuery do begin
          if Modified then begin
            result := true;
            Break;
          end;
        end;
      end
      else if Self.Components[iIndex] is TMyTable then begin
        with Self.Components[iIndex] as TMyTable do begin
          if Modified then begin
            result := true;
            Break;
          end;
        end;
      end;
    end;
  end;

  function TBaseInputGUI.GetReportNameForTypeName(const TypeName: string): string;
  var
    Qry: TERPQuery;
  begin
    Qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      Qry.Sql.Add('select TemplName from tbltemplates, tbltemplatetype');
      Qry.Sql.Add('where tbltemplates.TypeId = tbltemplatetype.TypeID');
      Qry.Sql.Add('and tbltemplatetype.TypeName = ' + QuotedStr(TypeName));
      Qry.Sql.Add('and tbltemplates.DefaultTemplate = "T"');
      Qry.Open;
      result := Qry.FieldByName('TemplName').AsString;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
  end;

function TBaseInputGUI.GetReportType: string;
var
  qry: TERPQuery;
begin
  result := '';
  if GetReportTypeID = 0 then exit;

  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select TypeName from tbltemplatetype where TypeID = ' + IntToStr(GetReportTypeID);
    qry.Open;
    result := qry.FieldByName('TypeName').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TBaseInputGUI.GetReportTypeID: integer;
  begin
    result := 0;
  end;

  procedure TBaseInputGUI.LoadReportTypes(reportType: String);
  begin
    LoadReportTypes(TemplateTypeID(reportType));
  end;

  function TBaseInputGUI.TemplateNameToTemplateClassName(const TemplateName: string): string;
  begin
    result := CommonLib.TemplateToTemplClass(TemplateName);
  end;
procedure TBaseInputGUI.TransApprovalInit(checkApproved: TwwCheckBox; aTranstype:String; aBusobj:TMSBusobj; AmtName:String;AssignOnclick :Boolean = False;aApprovercombo :TwwDBLookupcombo =nil; aApproverlbl:TLabel = nil; aApprovernotify : Twwcheckbox = nil);
begin
  ApprovalcheckObj.AddcheckBox(checkApproved,aTranstype,aBusobj,AmtName,AssignOnclick ,aApprovercombo ,aApproverlbl,aApprovernotify );
(*  ApprovalcheckObj.AddcheckBox(checkApproved,aTranstype,aBusobj,AmtName , aApprovercombo);

  If Not Appenv.CompanyPrefs.UseApprovalLevels Then checkApproved.visible := false
  Else If not(CanApproveTran) then checkApproved.Enabled                  := false;

   if Appenv.CompanyPrefs.UseSteppedApproval then begin
      if aApprovercombo <> nil then aApprovercombo.Visible := False;
      if aApproverlbl   <> nil then aApproverlbl.Visible := False;
      if aApprovernotify<> nil then aApprovernotify.Visible := False;
   end;

  if AssignOnclick then begin
    checkApproved.OnClick := OncheckApprovedclick;
  end;*)
end;
(*procedure TBaseInputGUI.OncheckApprovedclick(Sender:TObject);
begin
   ApprovalcheckObj.OncheckApprovedclick(Sender);
end;*)

  procedure TBaseInputGUI.LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '');
  begin
    if not Empty(fsReportName) then begin
      fsReportName := TemplateNameToTemplateClassName(trim(fsReportName));
    end
    else begin
      fsReportName := tcDataUtils.GetDefaultReport(GetReportTypeID);
    end;
  end;

  procedure TBaseInputGUI.logInuseform;
  begin
    if ignorelogInuseform then Exit;
    LogInuse(integer(Self), Self.Classname, KeyID);
  end;

  function TBaseInputGUI.SaveOrCancelChanges: boolean;
  begin
    result := true;
  end;

  Function TBaseInputGUI.SearchIDnUpdateName(Combo: TwwDBLookupCombo; LookupIDFieldName: String; LookupID: integer; fDataset: TDataSet;
    datasetfieldName, LookupFieldname: String): boolean;
  begin
    result := false;
    try
      with Combo do begin
        LookupTable.Close;
        LookupTable.Open;
        if LookupTable.Locate(LookupIDFieldName, LookupID, []) then begin
          PostDB(fDataset);
          editDB(fDataset);
          fDataset.FieldByName(datasetfieldName).AsString := LookupTable.FieldByName(LookupFieldname).AsString;
          PostDB(fDataset);
          result := true;
        end
        else begin
          CancelDB(fDataset);
        end;
      end;
    Except
      on E: Exception do begin
        MessageDlgXP_Vista('Update Failed.' + NL + E.message, mtWarning, [mbOK], 0);
      end;
    end;

  end;

  procedure TBaseInputGUI.SetAllowCustomiseGrid(const Value: boolean);
  begin
    fAllowCustomiseGrid             := Value;
    if Value then ShowCustomisemenu := true;
  end;

  function TBaseInputGUI.ValidReport(const ReportName, SQLPortion: string): boolean;
  var
    Qry: TERPQuery;
  begin
    result := true;
    Qry    := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      with Qry do begin
        Sql.Add('Select * from tblTemplates where TemplName = ' + QuotedStr(trim(ReportName)));
        Sql.Add(' OR TemplateClass = ' + QuotedStr(trim(ReportName)));
        Open;
        if FieldByName('Report').AsString = '' then begin
          result := false;
          CommonLib.MessageDlgXP_Vista('The template is not created for this report.' + chr(13) + 'Create the template before printing / previewing' + chr(13) + 'Report Name: ' +
              ReportName, mtWarning, [mbOK], 0);
          Exit;
        end;
        if SQLPortion = '' then
          if FieldByName('SQLString').AsString = '' then begin
            result := false;
            CommonLib.MessageDlgXP_Vista('SQL for the report should not be blank.' + chr(13) + 'Report Name: ' + ReportName, mtWarning, [mbOK], 0);
            Exit;
          end;
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;
  end;

(*  procedure TBaseInputGUI.initPrintTemplateOptionsReport(Sender: TTemplateOptions; var sSQL: String; var MasterDetailLink: TJsonObject;
    var ShowCancelPreviewBtninReportPreview: boolean);
  begin

  end;*)

(*  procedure TBaseInputGUI.initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions; var OutGoingFileName: String; var Corres: TCorrespondenceGui);
  begin

  end;*)

(*  procedure TBaseInputGUI.PrintTemplateOptionsReport(Sender: TTemplateOptions);
  var
    sSQL                               : String;
    MasterDetailLink                   : TJsonObject;
    ShowCancelPreviewBtninReportPreview: boolean;
    OutGoingFileName                   : String;
    Corres                             : TCorrespondenceGui;
    ReportAttachmentfiles              : String;
  begin
    if Sender = nil then Exit;
    if Sender.Active then begin
      initPrintTemplateOptionsReport(Sender, sSQL, MasterDetailLink, ShowCancelPreviewBtninReportPreview);
      if Sender.Print then PrintTemplateReport(Sender.TemplateName, sSQL, true, 1, MasterDetailLink, Sender.PrinterName, ShowCancelPreviewBtninReportPreview);
      if Sender.Preview then PrintTemplateReport(Sender.TemplateName, sSQL, false, 1, MasterDetailLink, Sender.PrinterName, ShowCancelPreviewBtninReportPreview);
      if Sender.email then begin
        Corres := TCorrespondenceGui.Create;
        try
          Corres.Clear;
          SaveTemplateReport(Sender.TemplateName, sSQL, false, 'PDF');
          initCorresforPrintTemplateOptionsReport(Sender, OutGoingFileName, Corres);
          if Corres.RecipientList <> '' then begin
            if not FileExists(CommonLib.TempDir + 'EmailReport.PDF') then begin
              CommonLib.MessageDlgXP_Vista('Can''t Find Attachment' + #13 + #10 + #13 + #10 + 'Email Failed !', mtWarning, [mbOK], 0);
              Exit;
            end;
            Copyfile(PChar(CommonLib.TempDir + 'EmailReport.PDF'), PChar(CommonLib.TempDir + OutGoingFileName), false);
            Corres.AttachmentList.Add(CommonLib.TempDir + OutGoingFileName);
            ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres, GetTemplate(ReportToPrint));
            Corres.Execute();
          end;
        finally
          DeleteFiles(ExtractFilePath(ParamStr(0)), '*.PDF');
          DeleteMultipleFiles(CommonLib.TempDir, ReportAttachmentfiles);
          Corres.Free;
        end;
      end;
    end;
  end;*)

  procedure TBaseInputGUI.PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject = nil;
    fsPrintename: String = ''; ShowCancelPreviewBtninReportPreview: boolean = false);
  begin
    PrintTemplate.ShowCancelPreviewBtninReportPreview := ShowCancelPreviewBtninReportPreview;
    if Empty(ReportName) then begin
      MessageDlgXP_Vista('Report Template is not specified to print. Please contact ERP', mtWarning, [mbOK], 0);
      Exit;
    end;
    if (not ValidReport(trim(ReportName), SQLPortion)) then begin
      MessageDlgXP_Vista('SQL Mismatch for the template . Please contact ERP', mtWarning, [mbOK], 0);
      Exit;
    end;
    PrintTemplate.ReportSQLSupplied := fbReportSQLSupplied;
    if Assigned(fConnectionFormReport) then begin
      PrintTemplate.PrintTemplateReport(ReportName, SQLPortion, DoPrint, Copies, ConnectionFormReport, '', MasterDetailLink, fsPrintename);
    end
    else begin
      // No, determine if we are using the forms connection or something else.
      if not fbTemplateUsesNonFormConnection then begin // Use forms connection.
        if Assigned(TransConnection) then PrintTemplate.PrintTemplateReport(ReportName, SQLPortion, DoPrint, Copies, TransConnection, '', MasterDetailLink, fsPrintename)
        else PrintTemplate.PrintTemplateReport(ReportName, SQLPortion, DoPrint, Copies, MyConnection, '', MasterDetailLink, fsPrintename);
      end
      else begin
        // Use the default mainform NON transaction connection.
        PrintTemplate.PrintTemplateReport(ReportName, SQLPortion, DoPrint, Copies, CommonDbLib.GetSharedMyDacConnection, '', MasterDetailLink, fsPrintename);
      end;
    end;
  end;

  { TBaseInputGUI.ApplicationEvents1Message -------------------------- }
  { to capture CTRL-SPACE and set Form in and out of a particular State:
    this State shows for all TWinControls the TabStop value:
    true is indicated by a red frame around the control
    false is indicated by a green frame around the control
    the user can click into the controls (which have a frame)
    and toggle the tabstop value
    the settings will be stored into tblpersonaltabs so they remain
    permanent for the user }
  procedure TBaseInputGUI.ApplicationEvents1Message(var Msg: tagMSG; var Handled: boolean);
  begin
    If csDestroying in Self.ComponentState then Exit;
    if fbTabSettingEnabled and (Self = Screen.ActiveForm) then
      pTabStops.TabStopsOnOff(Msg, Handled); // TabStopsOnOff(self, pTabStops, msg, Handled);
  end;

function TBaseInputGUI.ApprovalcheckObj: TApprovalcheckObj;
begin
  if fApprovalcheckObj= nil then
    fApprovalcheckObj := TApprovalcheckObj.create(self);
  result := fApprovalcheckObj;
end;

procedure TBaseInputGUI.AssignConnectionToAllQrys(const Value: TERPConnection);
  var
    iIndex  : integer;
    fbActive: boolean;
  begin
    if (Value = nil) or (Value.Connected = false) then Exit;

    for iIndex := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[iIndex] is TCustomMyDataSet then
        with Self.Components[iIndex] as TCustomMyDataSet do begin
          fbActive := TCustomMyDataSet(Self.Components[iIndex]).Active;
          CloseDB(TCustomMyDataSet(Self.Components[iIndex]));
          Connection := Value;
          if fbActive then openDB(TCustomMyDataSet(Self.Components[iIndex]));
        end;
    end;
  end;

  procedure TBaseInputGUI.ReadSubformGuiPrefs;
  begin

  end;

  procedure TBaseInputGUI.OnClearGridBedorePait(Grid: TwwDBGrid);
  begin

  end;

  procedure TBaseInputGUI.OnComboDblClick(Sender: TObject);
  var
    form: TBaseInputGUI;
    Fld : TField;
  begin
    { Currently only working on TwwDBLookupCombos, can be extended on a needs basis }
    if DoingonComboDblClick then Exit;
    DoingonComboDblClick := true;
    Try
      if Sender is TwwDBLookupCombo then begin

        if not Empty(TwwDBLookupCombo(Sender).Text) then begin
          FormFact.Fieldname := Classname;
          form               := FormFact.CreateForm[Classname + chr(95) + TwwDBLookupCombo(Sender).Name];
          if Assigned(form) then begin
            fowwCombo := Sender;
            with form do
              try
                if not PointLookupUsingSelect(TwwDBLookupCombo(Sender)) then PointLookupUsingField(TwwDBLookupCombo(Sender));
                if TwwDBLookupCombo(Sender).LookupTable.Locate(FormFact.Identifier, TwwDBLookupCombo(Sender).LookupTable.FieldByName(FormFact.Identifier).AsString,
                  [loCaseInsensitive]) then begin
                  Fld := TwwDBLookupCombo(Sender).LookupTable.findfield(FormFact.Identifier);
                  if Fld <> nil then begin
                    if (Fld is TIntegerField) or (Fld is TLargeIntField) then KeyID := TwwDBLookupCombo(Sender).LookupTable.FieldByName(FormFact.Identifier).AsInteger
                    else KeyID                                                      := IDfromcombo(TwwDBLookupCombo(Sender));
                    AttachObserver(Self);
                    if not visible then begin
                      FormStyle := fsMDIChild; // Shows the form in MDIChild mode.
                    end
                    else begin
                      OnShow(Self); // Needs this to refresh itself when a new KeyID is selected
                    end;
                    BringToFront;
                  end
                  else begin
                    MessageDlgXP_Vista('Field ' + QuotedStr(FormFact.Identifier) + ' not found', mtWarning, [mbOK], 0);
                  end;
                end;
              except
                raise;
              end;
          end
          else begin
            DivertComboDblClick(Sender);
          end;
        end
        else begin
          DivertComboDblClick(Sender);
        end;
      end;
    Finally
      DoingonComboDblClick := false;
    End;
  end;

  procedure TBaseInputGUI.OnComboNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
  var
    frmPopup    : TBaseInputGUI;
    cbo         : TwwDBLookupCombo;
    Buffer      : array [0 .. 1024] of char;
    tmpClassName: String;
  begin
    if DoingonComboNotInlist then Exit;
    DoingonComboNotInlist := true;
    Try
      Application.ProcessMessages;
      Accept := false;
      if fbAllowNotInList then begin
        if Sender is TwwDBLookupCombo then begin
          InComboNotinList := true;
          cbo              := TwwDBLookupCombo(Sender);
          // if not Empty(cbo.Text) then begin
          if not Empty(NewValue) then begin
            ZeroMemory(@Buffer, SizeOf(Buffer));
            // StrPCopy(Buffer, cbo.Text);
            StrPCopy(Buffer, NewValue);
            CombonotInlistValue := NewValue;
            frmPopup            := getPopup(Classname + chr(95) + TwwDBLookupCombo(Sender).Name);
            if Assigned(frmPopup) AND (frmPopup.KeyID <> 0) then begin
              frmPopup.CloseMe;
              Application.ProcessMessages;
              frmPopup := getPopup(Classname + chr(95) + TwwDBLookupCombo(Sender).Name);
            end;
            if Assigned(frmPopup) then begin
              if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                Accept := true;
                with frmPopup do begin // try
                  frmPopup.KeyID := 0;
                  frmPopup.AttachObserver(Self);
                  Self.beforeOnComboNotInList(Sender);
                  if not visible then begin
                    Self.InitPopupform(frmPopup);
                    if not(fsModal in Self.FormState) then begin
                      FormStyle := fsMDIChild; // Shows the form in MDIChild mode.
                      Self.AftershowPopupform(frmPopup);
                    end;
                    if TwwDBLookupCombo(Sender).DataSource <> NIL then
                      if not(TwwDBLookupCombo(Sender).DataSource.DataSet.State in [dsEdit, dsInsert]) then begin
                        TwwDBLookupCombo(Sender).DataSource.DataSet.Edit;
                      end;

                  end
                  else begin
                    OnShow(Self); // Needs this to refresh itself when a new KeyID is selected
                  end;
                  if not(fsModal in Self.FormState) then frmPopup.BringToFront;

                  // if cbo.Text = '' then
                  cbo.Text := NewValue;
                  Self.ComboToPopUp(frmPopup, cbo);

                  if (fsModal in Self.FormState) then frmPopup.ShowModal
                  else PostMessage(frmPopup.Handle, TX_SetFormFocus, 0, 0);
                  Self.Enabled := false;
                  try
                    tmpClassName := frmPopup.Classname;
                    While FormStillOpen(tmpClassName) Do Begin
                      Sleep(100);
                      Application.ProcessMessages;
                    end;
                  Finally
                    Self.BringToFront;
                    Self.Update;
                    Self.Enabled := true;
                    PostMessage(Self.Handle, TX_SetFormFocus, 0, 0);
                    PostMessage(Self.Handle, TX_SetFocus, 0, 0);
                  end;
                end;
              end
              else begin
                FreeAndNil(frmPopup);
                If Assigned(Sender) and (TwwDBLookupCombo(Sender).DataSource <> NIL) then
                  if (TwwDBLookupCombo(Sender).DataSource.DataSet.State in [dsEdit, dsInsert]) then begin
                    TwwDBLookupCombo(Sender).Undo;
                  end;
                PostMessage(Handle, TX_SetFocus, 0, 0);
              end;
            end
            else begin
              CommonLib.MessageDlgXP_Vista('Selection not in list for Combo: ' + GetComboIdent(cbo), mtWarning, [mbOK], 0);
            end
          end;
        end;
      end
      else begin
        CommonLib.MessageDlgXP_Vista('This item is not in the list. Try Again', mtWarning, [mbOK], 0);
        TwwDBLookupCombo(Sender).Text := '';
        SetControlFocus(TwwDBLookupCombo(Sender));
      end;
    Finally
      DoingonComboNotInlist := false;
    End;
  end;

  procedure TBaseInputGUI.HookupComboEvents;
  var
    iIndex: integer;
  begin
    for iIndex := 0 to ComponentCount - 1 do begin
      if Components[iIndex] is TWincontrol then begin

        if Components[iIndex] is TwwDBLookupCombo then begin
          if not Assigned(TwwDBLookupCombo(Components[iIndex]).OnDblClick) then begin
            TwwDBLookupCombo(Components[iIndex]).OnDblClick := OnComboDblClick;
          end;
          if not Assigned(TwwDBLookupCombo(Components[iIndex]).OnNotInList) then TwwDBLookupCombo(Components[iIndex]).OnNotInList := OnComboNotInList;
        end;

        if Components[iIndex] is TERPDbLookupcombo then begin
          { customer combos }
          if TERPDbLookupcombo(Components[iIndex]).LookupComboType = ctCustomer then begin
            if Appenv.CompanyPrefs.CustomercomboLookupExpressList and (sametext(TERPDbLookupcombo(Components[iIndex]).Lookupformclassname, 'TCustomerListGUI')) then
                TERPDbLookupcombo(Components[iIndex]).Lookupformclassname := 'TCustomerExpressListGUI'
            else if not(Appenv.CompanyPrefs.CustomercomboLookupExpressList) and (sametext(TERPDbLookupcombo(Components[iIndex]).Lookupformclassname, 'TCustomerExpressListGUI'))
            then TERPDbLookupcombo(Components[iIndex]).Lookupformclassname := 'TCustomerListGUI';
          end;

          { Product combos }
          if TERPDbLookupcombo(Components[iIndex]).LookupComboType = ctProduct then begin
            if Appenv.CompanyPrefs.ProductcomboLookupExpressList and (sametext(TERPDbLookupcombo(Components[iIndex]).Lookupformclassname, 'TProductListGUI')) then
                TERPDbLookupcombo(Components[iIndex]).Lookupformclassname := 'TProductListExpressGUI'
            else if not(Appenv.CompanyPrefs.ProductcomboLookupExpressList) and (sametext(TERPDbLookupcombo(Components[iIndex]).Lookupformclassname, 'TProductListExpressGUI')) then
                TERPDbLookupcombo(Components[iIndex]).Lookupformclassname := 'TProductListGUI';
          end;
        end;
      end;
    end;
  end;

  { This is the virtual method that can be overwritten in descendants to take a different action to that of Registering the component. }
  procedure TBaseInputGUI.DivertComboDblClick(Sender: TObject);
  begin
    CommonLib.MessageDlgXP_Vista('No further information available on this Drop Down. ', mtInformation, [mbOK], 0);
  end;

  procedure TBaseInputGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  begin
    if Key = VK_ESCAPE then Begin
      Key := 0;
      if GetKeyState(VK_LBUTTON) and $8000 <> 0 then Exit;
      if Self.Enabled then begin
        (* if fsModal in FormState then Close
          else Release; *)
        Notify(true);
        if fsModal in FormState then modalresult := mrCancel
        else Self.Close;
        // WorkflowActions.AddWorkflowAction(uetKeyboard, wParam, lParam);
      end;
    end
    else inherited;
  end;

  procedure TBaseInputGUI.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
  begin
    inherited;
    if Key = vk_f8 then begin
      DoFormSize(true);
    end;

  if ssCtrl in shift then  begin
    if (Key = ord('V')) or (Key =Ord('v')) then    begin
      OnPasteSelection(Key);
    end
    else if (Key = ord('C')) or (Key =Ord('c')) then    begin
      OnCopySelection(Key);
    end;
  end;

  end;

  procedure TBaseInputGUI.DisableDeleteBoxesInGrids;
  var
    i: integer;
  begin
    if AccessLevel > 1 then
      for i := 0 to Self.ComponentCount - 1 do
        if (Self.Components[i] is TwwDBGrid) then
          if Assigned(TwwDBGrid(Self.Components[i]).IndicatorButton) then TDnmSpeedButton(TwwDBGrid(Self.Components[i]).IndicatorButton).Enabled := false;
  end;

  function TBaseInputGUI.PointLookupUsingSelect(const cbo: TwwDBLookupCombo): boolean; // forces the lookup query of the combo to point to the record correcsponding
  // .. to the combo's text. This works only for TwwDBLookupCombo's
  var
    sField: string;
  begin // cbo.Selected is a TStrings, each record of which describes each field
    // .. in the combo dropdown.  The first record describes the field that
    // .. ends up being displayed in the combos text box.  Each record is split
    // .. into tab delimited fields, the first of which is the field name.  So the
    // .. first field of the first record represent the field that is displayed.
    if cbo.Selected.Count > 0 then begin
      sField := GetComboSelectField(cbo);
      try
        if (cbo.LookupTable is TERPQuery) and isParamAssigned(TERPQuery(cbo.LookupTable), 'SearchValue') then begin
          cbo.LookupTable.Close;
          TMyQuery(cbo.LookupTable).ParamByName('SearchValue').AsString := cbo.Text;
          cbo.LookupTable.Open;
        end;
      except
        // kill the exception
      end;
      result := cbo.LookupTable.Locate(sField, cbo.Text, [loCaseInsensitive]); // locate in lookup query
    end
    else begin
      result := false;
    end;
  end;

  function TBaseInputGUI.PointLookupUsingField(const cbo: TwwDBLookupCombo): boolean; // Use this only if the combo's 'select' TStrings is empty, otherwise use
  // .. PointLookupUsingSelect
  // forces the lookup query of the combo to point to the record correcsponding
  // .. to the combo's text. This works only for TwwDBLookupCombo's
  begin
    try
      if (cbo.LookupTable is TERPQuery) and isParamAssigned(TERPQuery(cbo.LookupTable), 'SearchValue') then begin
        cbo.LookupTable.Close;
        TMyQuery(cbo.LookupTable).ParamByName('SearchValue').AsString := cbo.Text;
        cbo.LookupTable.Open;
      end;
    except
      // kill the exception
    end;
    result := cbo.LookupTable.Locate(cbo.LookupField, cbo.Text, [loCaseInsensitive]); // locate in lookup query
  end;

  procedure TBaseInputGUI.ComboToPopUp(const Popup: TForm; const cbo: TwwDBLookupCombo);
  var
    iFieldID     : integer;
    DataSet      : TDataSet;
    bFound       : boolean;
    sField       : string;
    sTrimmedField: string;

    function SearchPopup(Const sTrimmedFields: string; var iFieldIDs: integer; var fDataset: TDataSet): boolean;
    var
      i, iItem: integer;
    begin
      result := false;

      { first try overriden code on popup }
      if Popup is TBaseInputGUI then result := TBaseInputGUI(Popup).DoComboToPopUp(sTrimmedFields, cbo);
      if result then Exit;

      for i := 0 to Popup.ComponentCount - 1 do begin
        if Popup.Components[i] is TDataSet then begin
          fDataset := TDataSet(Popup.Components[i]);
          if fDataset.Active then begin
            if fDataset.State in [dsInsert] then begin
              for iItem := 0 to fDataset.FieldCount - 1 do begin
                if uppercase(fDataset.Fields.Fields[iItem].Fieldname) = uppercase(sTrimmedFields) then begin
                  fDataset.Fields.Fields[iItem].AsString := cbo.Text;
                  result                                 := true;
                  iFieldIDs                              := iItem;
                  Break;
                end;
              end;
            end;
          end;
        end;
        if result then Break;
      end;
      if not result then begin // well, now we're desperate. Check for datsets in dsEdit mode
        for i := 0 to Popup.ComponentCount - 1 do begin
          if Popup.Components[i] is TDataSet then begin
            fDataset := TDataSet(Popup.Components[i]);
            if fDataset.Active then begin
              if fDataset.State in [dsEdit] then begin // dsEdit required for parts form
                for iItem := 0 to fDataset.FieldCount - 1 do begin
                  if uppercase(fDataset.Fields.Fields[iItem].Fieldname) = uppercase(sTrimmedFields) then begin
                    fDataset.Fields.Fields[iItem].AsString := cbo.Text;
                    result                                 := true;
                    iFieldIDs                              := iItem;
                    Break;
                  end;
                end;
              end;
            end;
          end;
          if result then Break;
        end;
      end;
    end;

  begin // ComboToPopup
    bFound  := false;
    DataSet := nil; // get the combos displayed text's field name
    if cbo.Selected.Count > 0 then begin
      sField := GetComboSelectField(cbo);
    end
    else begin
      sField := cbo.LookupField;
    end;
    sField        := uppercase(sField); // close up any spaces to give us a better chance of a match
    sTrimmedField := trim(ReplaceStr(sField, ' ', ''));
    if SearchPopup(sTrimmedField, iFieldID, DataSet) then begin
      bFound := true;
    end
    else begin // there are some rule breakers here - yuck!!!
      if sTrimmedField = 'Suburb' then begin
        sTrimmedField := 'City_sub';
      end; // try again
      if SearchPopup(sTrimmedField, iFieldID, DataSet) then begin
        bFound := true;
      end;
    end;
    if bFound then begin                                                              // set the field in the popup to that displayed in the combo
      if Assigned(DataSet) then DataSet.Fields.Fields[iFieldID].AsString := cbo.Text; // Save the combo and text to use when return from child form
      // .. via notify
      fNotInList.Combo        := cbo;
      fNotInList.DisplayField := sField;
      fNotInList.Popup        := Popup;
      if Assigned(DataSet) then begin
        fNotInList.PopUpField   := DataSet.Fields.Fields[iFieldID].Fieldname;
        fNotInList.PopUpDataSet := DataSet;
      end
      else begin
        fNotInList.PopUpField   := '';
        fNotInList.PopUpDataSet := nil;
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('You will have to Add the item manually', mtWarning, [mbOK], 0);
    end;
  end;

  function TBaseInputGUI.GetComboSelectField(const cbo: TwwDBLookupCombo): string; // returns the combos displayed text's field name
  var
    iIndex: integer;
  begin
    iIndex := FastFuncs.PosEx(#9, cbo.Selected[0]);
    result := FastFuncs.LeftStr(cbo.Selected[0], iIndex - 1); // get field
  end;

  procedure TBaseInputGUI.NotInListWarning(Sender: TObject);
  begin
    CommonLib.MessageDlgXP_Vista('You must select from list', mtWarning, [mbOK], 0);
    SetControlFocus(TwwDBLookupCombo(Sender));
  end;

  function TBaseInputGUI.GetComboIdent(const cbo: TComponent): string; // returns a user friendly identifier for the combo, could improve as required
  begin
    result := StringReplace(cbo.Name, 'cbo', '', [rfReplaceAll, rfIgnoreCase]);
  end;

  function TBaseInputGUI.EditNoAbort(const DataSet: TDataSet): boolean; // Simply places the dataset in Edit mode but handles the Abort Exception
  // .. raised by the BeforeEdit event.  This allows the calling method to
  // .. continue at the next statement if, say, the user has readonly access.
  // Returns true if dataset was put in edit mode successfully
  begin
    result := false;
    try
      DataSet.Edit;
      result := true;
    except
      on EAbort do HandleEAbortException;
    end;
  end;

  function TBaseInputGUI.EmailReport(RecID: integer; CustomerName, RecipientAddress, reportType, sreportName, sSQL: String; ReportSQLSupplied: boolean;
    EmailforemptyAddress: boolean; ConfirmEmailforempty: boolean = true; aSilent: boolean = false; aSecret: boolean = false; AddAttachment :TNotifyEvent =nil; EmailSubject:String = ''): boolean;
  var
    OutGoingFileName                             : string;
    qryEmailedList                               : TERPQuery;
    TransactionID, UserID, TransactionDescription: string;
    EmailDate                                    : TDateTime;
    Corres                                       : TCorrespondenceGui;
    ReportAttachmentfiles                        : String;
    idx                                          : integer;
  begin
    result           := false;
    OutGoingFileName := '';
    Corres           := TCorrespondenceGui.Create;
    try
      Corres.From := getEmailFrom;
      if RecipientAddress = '' then
        if (Appenv.CompanyPrefs.UseDefaultMailClient) and (Appenv.CompanyInfo.email <> '') then begin
          if ConfirmEmailforempty and (CommonLib.MessageDlgXP_Vista(QuotedStr(CustomerName) + ' does not have an email address.' + #13 + #10 +
                'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then Exit;
          RecipientAddress := Appenv.CompanyInfo.email;
        end
        else if EmailforemptyAddress and ConfirmEmailforempty then begin
          if CommonLib.MessageDlgXP_Vista(CustomerName + ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?', mtConfirmation,
            [mbYes, mbNo], 0) = mrNo then Exit;
        end
        else if EmailforemptyAddress and ConfirmEmailforempty = false then begin //
        end
        else begin
          CommonLib.MessageDlgXP_Vista(CustomerName + ' does not have an email address.' + #13 + #10 + 'Please review customer information to add an email address.', mtWarning,
            [mbOK], 0);
          Exit;
        end;
      if not aSecret then DoShowProgressbar(9, 'Emailing ' + CustomerName + '''' + ' ' + reportType + ' Report');
      try
        if not aSecret then DoStepProgressbar;
        Application.ProcessMessages;
        fbReportSQLSupplied := ReportSQLSupplied;
        SaveTemplateReport(sreportName, sSQL, false, 'PDF');
        if not FileExists(CommonLib.TempDir + 'EmailReport.PDF') then begin
          // CommonLib.MessageDlgXP_Vista(Reporttype +' Report Failed',mtInformation, [mbOK], 0);
          if not aSecret then
              CommonLib.MessageDlgXP_Vista(reportType + ': No Data.'#13#10'Cannot Email ' + sreportName + ' To ' + CustomerName + ' (' + RecipientAddress + ')', mtInformation,
              [mbOK], 0);
          // Really it means No Data To Send (Report body is empty)
          result := true; // @@@
          Exit;
        end;
        if PrintTemplate.NoRecordsToPrint then begin
          CommonLib.MessageDlgXP_Vista(reportType + ' Report does not have any Record to print', mtInformation, [mbOK], 0);
          Exit;
        end;
        if not aSecret then DoStepProgressbar('Connecting...');
        if EmailSubject <> '' then Corres.Subject :=EmailSubject
        else Corres.Subject := reportType + ' for ' + CustomerName;
        if not aSecret then DoStepProgressbar('Populating Email Details');
        Corres.RecipientList := RecipientAddress;
        Corres.MessageText   := 'This report email has been sent to you from ' + GetCompanyName +'(ERP)';
        if not aSecret then DoStepProgressbar('Making Attachment');
        OutGoingFileName := CommonLib.TempDir + getOutGoingFileName('', ' ' + reportType, '.PDF');
        idx              := 0;
        While FileExists(OutGoingFileName)
          do { windows 7 with windowsd live mail client doesn't delete the attachment file in the temp folder and so doesn't let you over write it , so get a filename that doesn't exists }
        begin
          OutGoingFileName := ReplaceStr(OutGoingFileName, '.PDF', IntToStr(idx) + '.PDF');
          Inc(idx);
        end;

        if not FileExists(OutGoingFileName) then
            MoveFileEx(PChar(CommonLib.TempDir + 'EmailReport.PDF'), PChar(OutGoingFileName), MOVEFILE_REPLACE_EXISTING + MOVEFILE_WRITE_THROUGH);
        if not aSecret then DoStepProgressbar('Adding Attachment');
        if FileExists(OutGoingFileName) then Corres.AttachmentList.Add(OutGoingFileName);
        if Assigned(AddAttachment) then AddAttachment(Corres);

        ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres, GetTemplate(sreportName));
        if not aSecret then DoStepProgressbar('Emailing, ' + WAITMSG);
        try
          if not Corres.Execute(aSilent, aSecret) then Exit;
        Except
          on E: Exception do begin
            if devmode then begin
              MessageDlgXP_Vista('Sending Email Failed. Please find the report as a pdf file in ' + CommonLib.TempDir + 'EmailReport.PDF', mtError, [mbOK], 0);
            end;
          end;
        end;
        if RecID <> 0 then begin
          if not aSecret then DoStepProgressbar('Emailed Report Logging');
          if not aSecret then DeleteFiles(CommonLib.TempDir, '*.PDF');
          DeleteMultipleFiles(CommonLib.TempDir, ReportAttachmentfiles);
          TransactionID          := IntToStr(RecID);
          UserID                 := Appenv.Employee.FirstName + ' ' + Appenv.Employee.LastName;
          EmailDate              := Now;
          TransactionDescription := GetCompanyName + ' ' + reportType + ' #' + IntToStr(RecID) + ' for ' + CustomerName;
          qryEmailedList         := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
          try
            qryEmailedList.Sql.Clear;
            qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' + TransactionID + '","'
                + UserID + '", "' + FormatDateTime(MysqlDateFormat, EmailDate) + '", "' + reportType + '", "' + TransactionDescription + '")');
            qryEmailedList.Execute;
            result := true;
          finally
            if not aSecret then begin
              DoStepProgressbar('Delete Temporary files');
              DeleteFiles(CommonLib.TempDir, '*.PDF');
            end;
            DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryEmailedList);
          end;
        end
        else if aSecret then result := true;
      finally
        FreeAndNil(Corres);
      end;
      if not aSecret then DoStepProgressbar('... Done');
    finally
      if not aSecret then DoHideProgressbar;
    end;
  end;

  function TBaseInputGUI.IsOkToSave: boolean;
  begin
    if (AccessLevel <= 2) then begin
      result := true;
    end
    else begin
      result := false;
    end;
  end;

  function TBaseInputGUI.getPopup(const sMneumonic: string): TBaseInputGUI;
  { Returns the popup that coincides with this combo either using sMneumonic   to use the form factory or by providing a form directly using frmToPopup.   NOTE: if using the latter then, an instance of frmToPopup must exist }
  begin
    if Assigned(frmToPopup) then begin
      result := frmToPopup;
    end
    else begin
      FormFact.Fieldname := Classname;
      result             := FormFact.CreateForm[sMneumonic];
    end;
  end;

  function TBaseInputGUI.getReportName(ChooseReport: boolean; LoadReportTypesconditions: String): string;
  begin
    try
      if fsReportName <> '' then
        if not ChooseReport then Exit;

      if ChooseReport = false then begin
        fsReportName := tcDataUtils.GetDefaultReport(GetReportTypeID);
        if fsReportName <> '' then Exit;
      end;

      LoadReportTypes(GetReportTypeID, LoadReportTypesconditions);

      if dlgReportSelect.Execute then begin
        fsReportName := dlgReportSelect.SelectedItems.Text;

        if not Empty(fsReportName) then begin
          fsReportName := TemplateNameToTemplateClassName(trim(fsReportName));
        end
        else begin
          fsReportName := tcDataUtils.GetDefaultReport(GetReportTypeID);
        end;
      end;

    finally
      result := fsReportName;
    end;

  end;

  procedure TBaseInputGUI.SetLastChequeNo(const AccountID, ChequeNo: integer);
  var
    qryTemp: TERPCommand;
  begin
    qryTemp            := TERPCommand.Create(Self);
    qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      qryTemp.Sql.Add('UPDATE tblchartofaccounts SET LastChequeNo =' + IntToStr(ChequeNo) + ' WHERE AccountID=' + IntToStr(AccountID) + ' AND LastChequeNo<' +
          IntToStr(ChequeNo) + ';');
      qryTemp.Execute;
    finally
      FreeAndNil(qryTemp);
    end;
  end;

  procedure TBaseInputGUI.SetPagefocus(Page: TPagecontrol; Tabsheet: TTabsheet; Control: TWincontrol);
  var
    OnChange: TNotifyEvent;
  begin
    Page.ActivePage := Tabsheet;
    OnChange        := Page.OnChange;
    if Assigned(OnChange) then OnChange(Page);
    if Control <> nil then SetControlFocus(Control);
  end;

  procedure TBaseInputGUI.SetStateParams(const Value: TJsonObject);
  begin
    FStateParams := Value;
  end;

  procedure TBaseInputGUI.SetTransconenctiontoQueries;
  var
    iIndex: integer;
  begin
    if Assigned(TransConnection) then begin
      for iIndex := 0 to Self.ComponentCount - 1 do begin
        if Self.Components[iIndex] is TERPQuery then begin
          CloseDB(TERPQuery(Self.Components[iIndex]));
          TERPQuery(Self.Components[iIndex]).Connection := TransConnection;
        end;
      end;
    end;
  end;

  procedure TBaseInputGUI.SetTransConnection(const Value: TERPConnection);
  begin
    fTransConnection := Value;
  end;

  function TBaseInputGUI.ChkReqdFields(const sFormType: string): boolean; { Possible values for form type are:   Cust, Supp, Empl, Othr, Assets }
  var
    iCFNumber    : integer;
    i            : integer;
    Qry          : TERPQuery;
    sField, sText: string;
    Field        : TField; // dataset: TDataset;
    function IsCustomField(const sName: string): boolean;
    begin
      result := false;
      if FastFuncs.PosEx('CUSTFLD', sName) = 1 then begin
        result := true;
        Exit;
      end
      else if FastFuncs.PosEx('CUSTDATE', sName) = 1 then begin
        result := true;
        Exit;
      end
    end;
    function IsFieldRequired(const iNumber: integer; const fqry: TERPQuery): boolean;
    begin
      result := false;
      if fqry.FieldByName('CF' + sFormType + IntToStr(iNumber)).AsString = 'T' then begin
        if fqry.FieldByName('CfIsRequired' + IntToStr(iNumber)).AsString = 'T' then begin
          result := true;
        end;
      end;
    end;
    function GetCustomFieldNumber(const sName: string): integer;
    begin
      { Isrequired flag field name for customedit fields's are 1 to 15 and
        custom dates are 16 to 18 }
      result := 0;
      if FastFuncs.PosEx('CUSTFLD', sName) = 1 then begin
        result := Trunc(StrValue(sName));
        Exit;
      end
      else if FastFuncs.PosEx('CUSTDATE', sName) = 1 then begin
        result := Trunc(StrValue(sName)) + 15;
        Exit;
      end
    end;
    function GetLabel(const iNumber: integer; const Qry: TERPQuery): string;
    begin
      result := Qry.FieldByName('CFLabel' + IntToStr(iNumber)).AsString;
    end;

  begin
    result := true;
    Qry    := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      with Qry do begin
        Close;
        Sql.Clear;
        Sql.Add('SELECT * FROM tblCustomFields;');
        Open;
        if IsEmpty then begin
          result := true;
          Exit;
        end;
      end;
      for i   := 0 to Self.ComponentCount - 1 do begin
        Field := nil;                                 // Is this component a TDBEdit Class?
        if (Self.Components[i] is TDBEdit) then begin // Yes
          Field := TDBEdit(Self.Components[i]).Field; // Is the field reference a valid pointer?
          if Assigned(Field) then begin
            sText := TDBEdit(Self.Components[i]).Text;
          end; // Is this component a TDBComboBox Class?
        end
        else if (Self.Components[i] is TDBComboBox) then begin // Yes
          Field := TDBComboBox(Self.Components[i]).Field;      // Is the field reference a valid pointer?
          if Assigned(Field) then begin
            sText := TDBComboBox(Self.Components[i]).Text;
          end; // Is this component a TwwDBEdit Class?
        end
        else if (Self.Components[i] is TwwDBEdit) then begin // Yes
          Field := TwwDBEdit(Self.Components[i]).Field;      // Is the field reference a valid pointer?
          if Assigned(Field) then begin
            sText := TwwDBEdit(Self.Components[i]).Text;
          end; // Is this component a TwwDBComboBox Class?
        end
        else if (Self.Components[i] is TwwDBComboBox) then begin // Yes
          Field := TwwDBComboBox(Self.Components[i]).Field;      // Is the field reference a valid pointer?
          if Assigned(Field) then begin
            sText := TwwDBComboBox(Self.Components[i]).Text;
          end; // Is this component a TwwDBDateTimePicker Class?
        end
        else if (Self.Components[i] is TwwDBDateTimePicker) then begin // Yes
          Field := TwwDBDateTimePicker(Self.Components[i]).Field;      // Is the field reference a valid pointer?
          if Assigned(Field) then begin
            sText := TwwDBDateTimePicker(Self.Components[i]).Text;
          end;
        end;                          // Do we have a field?
        if Assigned(Field) then begin // Get Field name.
          sField := Field.Fieldname;
        end
        else begin // No Field Name
          sField := '';
        end;                                              // Is this field a custom field?
        if IsCustomField(sField) then begin               // Get its numeric ID.
          iCFNumber := GetCustomFieldNumber(sField);      // Valid numeric id?
          if iCFNumber <> 0 then begin                    // Is this field required?
            if IsFieldRequired(iCFNumber, Qry) then begin // Is this field empty?
              if Empty(sText) then begin                  // Report to user that this field must be provided.
                CommonLib.MessageDlgXP_Vista('You must enter a value for custom field: ' + GetLabel(iCFNumber, Qry), mtWarning, [mbOK], 0);
                result := false;
                Break;
              end; // if Empty(sText)
            end;   // if IsFieldRequired
          end;     // if iCfNumber <> 0
        end;       // if IsCustomField
      end;         // for i :=
    finally        // Free our used object.
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;
  end;

  procedure TBaseInputGUI.FormActivate(Sender: TObject);
  var
    comp                          : TComponent;
    StatusAndToolbarHeight, NewTop: integer;
  begin
    if fbStartingUp then begin
      StatusAndToolbarHeight                        := 0;
      comp                                          := CommonLib.FindControlClass(Application.MainForm, 'TToolBar');
      if Assigned(comp) then StatusAndToolbarHeight := TToolBar(comp).Height;
      comp                                          := CommonLib.FindControlClass(Application.MainForm, 'TAdvOfficeStatusBar');
      if Assigned(comp) then StatusAndToolbarHeight := StatusAndToolbarHeight + TAdvOfficeStatusBar(comp).Height;
      if (Self.FormStyle <> fsMDIChild) then begin
        NewTop := ((Application.MainForm.ClientHeight + StatusAndToolbarHeight) - Self.Height) div 2;
      end
      else begin
        NewTop := ((Application.MainForm.ClientHeight - StatusAndToolbarHeight) - Self.Height) div 2;
      end;
      if NewTop < 0 then NewTop := 0;
      Top                       := NewTop; // Left := (MainForm.ClientWidth shr 1) - (Self.Width shr 1);
      Left                      := ((Application.MainForm.ClientWidth - Self.Width) div 2);
      if Left < 0 then Left     := 0;
      fbStartingUp              := false;
    end;
    inherited;
    if ShowAtCursor then begin
      Top :=Mouse.CursorPos.Y;
      Left :=Mouse.CursorPos.X;
      if top+height > mainform.Height+6 then top := mainform.Height - height-6;
      if left+width > mainform.width+6 then left := mainform.width - width-6;
      ShowAtCursor:= False;
    end;

  end;

  procedure TBaseInputGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
  begin
    Application.ProcessMessages; // An Attempt To Stop Msg Post After or In Destroy.
    inherited;
    CanClose := not DoingNotify;
  end;

  procedure TBaseInputGUI.SetKeyId(const Value: integer);
  begin // if UserLock object enabled the following code will prevent more than one
    // user opening the same class/KeyId combination in edit mode.
    if fiKeyID <> Value then begin
      fiKeyID := Value;
      KeyIdChanged(Value);
    end;
  end;

  procedure TBaseInputGUI.SetKeyString(busobjClass: TBusObjClass; Qrymain: TERPQuery; Value, KeyStringField: String);
  var
    fID: integer;
  begin
    fID := busobjClass.IDToggle(KeyStringField, Value);
    if (KeyID = fID) AND (fID <> 0) then Exit;

    if KeyID <> fID then KeyID := fID;

    if (KeyID = 0) and (Qrymain.Active) then Qrymain.FieldByName(KeyStringField).AsString := Value;
  end;

  procedure TBaseInputGUI.SetKeyString(const Value: string);
  begin

  end;

  procedure TBaseInputGUI.KeyIdChanged(const NewKeyId: integer);
  begin
    logInuseform;
    if UserLock.Enabled and (AccessLevel < 5) then begin
      UserLock.UnlockAllCurrentInstance;
      if (NewKeyId > 0) then begin
        if not UserLock.Lock(GetMainTablename, NewKeyId, Self.Caption) then begin
          AccessLevel := 5; // read only
          CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access will be changed to read-only.', mtWarning, [mbOK], 0);
        end;
      end;
    end;
    fsForeignkeyValidations := nil;
  end;

  function TBaseInputGUI.IsFlag(const FlagName: string; const Reset: boolean = false): boolean;
  begin
    result := false;
    if not Assigned(FFlags) then Exit;
    result := FFlags.IsFlag(FlagName, Reset);
  end;

  procedure TBaseInputGUI.RemoveFlag(const FlagName: string);
  begin
    if not Assigned(FFlags) then Exit;
    FFlags.RemoveFlag(FlagName);
  end;

  function TBaseInputGUI.AnyOfFlags(const Values: array of string): boolean;
  begin
    result := false;
    if not Assigned(FFlags) then Exit;
    result := FFlags.AnyOfFlags(Values);
  end;

  procedure TBaseInputGUI.RemoveFlags(const Values: array of string);
  begin
    if not Assigned(FFlags) then Exit;
    FFlags.RemoveFlags(Values);
  end;

  procedure TBaseInputGUI.AddFlag(const FlagName: string);
  begin
    if not Assigned(FFlags) then Exit;
    FFlags.AddFlag(FlagName);
  end;

  procedure TBaseInputGUI.AddFlags(const Values: array of string);
  begin
    if not Assigned(FFlags) then Exit;
    FFlags.AddFlags(Values);
  end;

  function TBaseInputGUI.NoneFlags(const Values: array of string): boolean;
  begin
    result := false;
    if not Assigned(FFlags) then Exit;
    result := FFlags.NoneFlags(Values);
  end;

  procedure TBaseInputGUI.Notify(const Cancelled: boolean);
  begin
    DoingNotify := true;
    try
      ObserverList.Notify(Self, Cancelled);
    finally
      DoingNotify := false;
    end;
  end;

  procedure TBaseInputGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject = nil);
  begin
    if Assigned(aObject) and aObject.ClassNameIs('TfrmCustomFields') then begin
      CustomFieldsRefresh;
    end;
  end;
  procedure TBaseInputGUI.onUpdateMe_Cancelled;
  var
    fs:String;
  begin
    if Assigned(fLastComboAccessed) then begin
        fs:= fLastComboAccessed.text;
        try if fLastComboAccessed.datasource.dataset.state  = dsInsert then fLastComboAccessed.datasource.dataset.cancel; Except end;
        fLastComboAccessed.LookupTable.Close;
        fLastComboAccessed.LookupTable.Open;
        if fLastComboAccessed.LookupTable.Locate(fLastComboAccessed.Lookupfield, fs, []) then else
          fLastComboAccessed.Datasource.DataSet.FieldByName(fLastComboAccessed.DataField).Clear;
      end;
  end;

  procedure TBaseInputGUI.CompletedClick(Sender: TObject);
  begin
    inherited;
    if not fPreventClick then begin
      fPreventClick := true;
      try
        if Assigned(fStoredCompletedClick) then fStoredCompletedClick(Sender);
      finally
        fPreventClick := false;
      end;
    end;
  end;

procedure TBaseInputGUI.TabSheetShow(Sender: TObject);
  var
    TabSheetRect   : TRect;
    PageControlRect: TRect;
    Bitmap         : TBitmap;
    fCanvas        : TControlCanvas;
  begin
    Bitmap  := TBitmap.Create;
    fCanvas := TControlCanvas.Create;
    try
      Bitmap.Width              := 300;
      Bitmap.Height             := 300;
      Bitmap.Canvas.Brush.Color := Self.Color; // ftabcolour;
      Bitmap.Canvas.FillRect(Rect(0, 0, 300, 300));
      TabSheetRect         := TTabsheet(Sender).ClientRect;
      fCanvas.Control      := TTabsheet(Sender);
      fCanvas.Brush.Bitmap := Bitmap;
      fCanvas.FillRect(TabSheetRect);
      fCanvas.Control        := TTabsheet(Sender).PageControl;
      fCanvas.Brush.Bitmap   := Bitmap;
      PageControlRect        := fCanvas.Control.ClientRect;
      PageControlRect.Left   := TTabsheet(Sender).Left - 2;
      PageControlRect.Top    := TTabsheet(Sender).Top - 2;
      PageControlRect.Right  := PageControlRect.Right - 2;
      PageControlRect.Bottom := PageControlRect.Bottom - 2;
      fCanvas.FillRect(PageControlRect);
    finally
      FreeAndNil(Bitmap);
      FreeAndNil(fCanvas);
    end;
  end;

  procedure TBaseInputGUI.TaxCodecomboHint(const TaxCodecombo: TwwDBLookupCombo);
  begin
    if Appenv.CompanyPrefs.filterTaxcodeforClient then begin
      TaxCodecombo.hint := 'The Taxcode list in this combo box is filtered for the Client''s ' + NL + '   -- Country :' +
        QuotedStr(TERPQuery(TaxCodecombo.LookupTable).ParamByName('Clientcountry').AsString) + NL + '   -- ' + Appenv.RegionalOptions.StateName + ' :' +
        QuotedStr(TERPQuery(TaxCodecombo.LookupTable).ParamByName('ClientState').AsString) + NL + '   -- ' + Appenv.RegionalOptions.SuburbName + ' :' +
        QuotedStr(TERPQuery(TaxCodecombo.LookupTable).ParamByName('clientLocation').AsString) + NL + '   -- Postcode :' +
        QuotedStr(TERPQuery(TaxCodecombo.LookupTable).ParamByName('ClientPostcode').AsString) + NL;
      TaxCodecombo.showhint       := true;
      TaxCodecombo.parentshowhint := false;
    end;
  end;

  procedure TBaseInputGUI.Tabcontrolexit(Sender: TObject);
  var
    EventRec   : TFormEventRec;
    NotifyEvent: TNotifyEvent;
  begin
    NotifyEvent := nil;
    if not(Sender is TTabsheet) then Exit;

    if TPagecontrol(TTabsheet(Sender).Parent).ActivePage = Sender then
      if Screen.activecontrol = TPagecontrol(TTabsheet(Sender).Parent) then begin
        fbPageFontrol         := TPagecontrol(TTabsheet(Sender).Parent);
        fbPageFontrolTabIndex := fbPageFontrol.ActivePageIndex;
        PostMessage(Self.Handle, CM_FOCUSCHANGED, 0, 0);
        Application.ProcessMessages;
        fbPageFontrol := nil;
      end;

    if Self.GetEventRec(EventRec, TTabsheet(Sender).Name, on_Exit) then begin
      TMethod(NotifyEvent).Data := EventRec.Data;
      TMethod(NotifyEvent).Code := EventRec.Code;
      NotifyEvent(Sender);
    end;
  end;

  procedure TBaseInputGUI.pageControlChange(Sender: TObject);
  var
    EventRec   : TFormEventRec;
    NotifyEvent: TNotifyEvent;
  begin
    Self.DisableForm;
    try
      NotifyEvent           := nil;
      fbPageFontrol         := TPagecontrol(Sender);
      fbPageFontrolTabIndex := fbPageFontrol.ActivePageIndex;
      PostMessage(Self.Handle, CM_FOCUSCHANGED, 0, 0);
      Application.ProcessMessages;
      fbPageFontrol := nil;
      if Self.GetEventRec(EventRec, TPagecontrol(Sender).Name, on_change) then begin
        TMethod(NotifyEvent).Data := EventRec.Data;
        TMethod(NotifyEvent).Code := EventRec.Code;
        NotifyEvent(Sender);
      end;
    finally
      Self.EnableForm;
    end;
  end;

  (* procedure TBaseInputGUI.PageControlDrawTab(Control: TCustomTabControl; TabIndex: integer; const Rect: TRect; Active: boolean);
    var
    TmpRect: TRect;
    Bitmap: TBitmap;

    Function FindPageforTabIndex( pagecontrol: TPagecontrol; tabindex: Integer ): TTabSheet;
    Var
    i: Integer;
    Begin
    Assert( Assigned( pagecontrol ));
    Assert( (tabindex >= 0) and (tabindex < pagecontrol.pagecount ));
    Result := nil;
    For i:= 0 To pagecontrol.pagecount-1 Do
    If pagecontrol.pages[i].tabVisible Then Begin
    Dec( tabindex );
    If tabindex < 0 Then Begin
    result := pagecontrol.pages[i];
    break;
    End;
    End;
    end;


    begin
    Bitmap := TBitmap.Create;
    try
    TmpRect    := Rect;
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := fTabColor;
    Bitmap.Canvas.FillRect(Classes.Rect(0, 0, 300, 300));

    Control.Canvas.Brush.Bitmap := Bitmap;
    TmpRect := Control.ClientRect;
    TmpRect.Left := ((TPageControl(Control).TabWidth * TPageControl(Control).PageCount) div TPageControl(Control).RowCount) + 4;
    TmpRect.Bottom := Rect.Bottom - 4;
    Control.Canvas.FillRect(TmpRect);
    TmpRect := Rect;
    TmpRect.Bottom := TmpRect.Bottom + 2;
    Control.Canvas.FillRect(TmpRect);
    TmpRect.Bottom := TmpRect.Bottom - 2;

    if Active then
    Control.Canvas.Font.Color := clNavy;

    Control.Canvas.Brush.Style := bsClear;

    DrawText(Control.Canvas.Handle, PChar(FindPageforTabIndex(TPageControl(Control),TabIndex).Caption), - 1, TmpRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

    finally
    FreeAndNil(Bitmap);
    end;
    end; *)
  Procedure TBaseInputGUI.UnlockRelatedTables;
  begin
    UserLock.Unlock(Copy(Classname, 2, FastFuncs.Strlength(Classname)));
    UserLock.Unlock(Self.Caption);
  end;

  function TBaseInputGUI.BusObjconfirmation(const Msg: String; Buttons: TMsgDlgButtons): integer;
  begin
    result := CommonLib.MessageDlgXP_Vista(Msg, mtConfirmation, Buttons, 0);
  end;

  Function TBaseInputGUI.RecordinUse(var ErrMsg: String): boolean;
  var
    strSQL: String;
    ctr   : integer;
    Qry   : TERPQuery;
  begin
    result := false;
    if fsForeignkeyValidations = nil then Exit;
    strSQL                        := '';
    for ctr                       := low(fsForeignkeyValidations[0]) to high(fsForeignkeyValidations[0]) do begin
      if strSQL <> '' then strSQL := strSQL + chr(13) + ' union All ' + chr(13);
      strSQL := strSQL + 'Select Distinct ' + QuotedStr(fsForeignkeyValidations[3, ctr]) + ' as TableDescription  from ' + fsForeignkeyValidations[0, ctr] + ' where ' +
        fsForeignkeyValidations[1, ctr];
    end;
    if strSQL <> '' then begin
      // with tcDatautils.Datautilsdataset(strSQL) do begin
      Qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
      try
        if Qry.Active then Qry.Close;
        Qry.Sql.Text := strSQL;
        Qry.Open;

        if Qry.recordcount > 0 then begin
          result := true;
          Qry.first;
          While Qry.Eof = false do begin
            if ErrMsg <> '' then ErrMsg := ErrMsg + chr(13);
            ErrMsg                      := ErrMsg + '              ' + Qry.FieldByName('TableDescription').AsString;
            Qry.Next;
          end;
        end;
      finally
        DbSharedObj.ReleaseObj(Qry);
      end;
    end;
  end;

  Procedure TBaseInputGUI.CheckRecordUsage(Const TableName, whereClause, IDFieldName: String; DescTablename: string);
  var
    bFlag: boolean;
    ctr  : integer;
  begin
    if (TableName = '') or (whereClause = '') then Exit;
    ctr := 0;
    if fsForeignkeyValidations = nil then begin
      SetLength(fsForeignkeyValidations, 4);
      SetLength(fsForeignkeyValidations[0], ctr);
      SetLength(fsForeignkeyValidations[1], ctr);
      SetLength(fsForeignkeyValidations[2], ctr);
      SetLength(fsForeignkeyValidations[3], ctr);
    end;
    bFlag := false;

    for ctr := low(fsForeignkeyValidations[0]) to high(fsForeignkeyValidations[0]) do
      if (fsForeignkeyValidations[0, ctr] = TableName) and (fsForeignkeyValidations[1, ctr] = whereClause) then bFlag := true;
    if bFlag then Exit;
    ctr                 := high(fsForeignkeyValidations[0]) + 1;
    if ctr < 0 then ctr := 0;
    SetLength(fsForeignkeyValidations[0], ctr + 1);
    SetLength(fsForeignkeyValidations[1], ctr + 1);
    SetLength(fsForeignkeyValidations[2], ctr + 1);
    SetLength(fsForeignkeyValidations[3], ctr + 1);
    fsForeignkeyValidations[0, ctr] := TableName;
    fsForeignkeyValidations[1, ctr] := whereClause;
    fsForeignkeyValidations[2, ctr] := IDFieldName;
    fsForeignkeyValidations[3, ctr] := DescTablename;
  end;

  procedure TBaseInputGUI.GridBeforePaint(Sender: TObject);
  begin
    //
    // Pass the handle of this grid in the message
    //
    if (Sender is TwwDBGrid) and (not(csDestroying in ComponentState)) then PostMessage(Handle, TX_GridPaint, TwwDBGrid(Sender).Handle, 0);
  end;

  procedure TBaseInputGUI.HandleGridPaint(var Msg: TMessage);
  var
    Min             : integer;
    Max             : integer;
    LeftPos         : integer;
    TopPos          : integer;
    TmpBitmap       : TBitmap;
    CurrentGrid     : TwwDBGrid;
    ControlCanvas   : TControlCanvas;
    ScrollBarVisible: boolean;
    ScrollBarAdjust : integer;
  begin
    if not(csDestroying in ComponentState) then begin
      inherited;
      //
      // Retrieve the grid by its handle stored in the message
      //
      CurrentGrid := TwwDBGrid(FindControl(Msg.WParam));

      if Assigned(CurrentGrid) then begin
        TmpBitmap     := TBitmap.Create;
        ControlCanvas := TControlCanvas.Create;
        try
          //
          // Determine if the horizontal scroll bar is visible and adjust the
          // vertical positioning of the watermark if it is
          //
          GetScrollRange(CurrentGrid.Handle, SB_HORZ, Min, Max);
          ScrollBarVisible                         := (Min <> Max);
          if ScrollBarVisible then ScrollBarAdjust := 16
          else ScrollBarAdjust                     := 0;
          TmpBitmap.Transparent                    := true;
          TmpBitmap.TransparentColor               := CurrentGrid.Color;
          TmpBitmap.Width                          := CurrentGrid.Width;
          TmpBitmap.Height                         := CurrentGrid.Height;
          ControlCanvas.Control                    := CurrentGrid;
          TmpBitmap.Canvas.CopyRect(Rect(0, 0, CurrentGrid.Width, CurrentGrid.Height), ControlCanvas, Rect(0, 0, CurrentGrid.Width, CurrentGrid.Height));
          //
          // Calculate the position to draw the watermark
          //
          LeftPos := (CurrentGrid.Width - imgGridWatermark.Picture.Bitmap.Width - 20) div 2;
          TopPos  := (CurrentGrid.Height - imgGridWatermark.Picture.Bitmap.Height + CurrentGrid.RowHeights[0] - ScrollBarAdjust) div 2;
          //
          // Draw watermark
          //
          ControlCanvas.Draw(LeftPos, TopPos, imgGridWatermark.Picture.Bitmap);
          //
          // Paint the grid over the watermark
          //
          ControlCanvas.Draw(0, 0, TmpBitmap);
        finally
          FreeAndNil(TmpBitmap);
          FreeAndNil(ControlCanvas);
          fGridQueue.Push(CurrentGrid);
          fPaintTimer.Enabled := true;
        end;
      end;
    end;
  end;

  procedure TBaseInputGUI.PaintTimerTimeout(Sender: TObject);
  var
    CurrentGrid: TwwDBGrid;
    ClearTimer : TTimer;
  begin
    if not(csDestroying in ComponentState) then begin
      while fGridQueue.Count > 0 do begin
        //
        // Retrieve the grid from the queue and clear its OnBeforePaint so
        // the watermark is only drawn once
        //
        CurrentGrid               := TwwDBGrid(fGridQueue.Pop);
        CurrentGrid.OnBeforePaint := nil;
        OnClearGridBedorePait(CurrentGrid);
        //
        // Store the grid's handle in the timer's tag and set the timer to clear
        // the watermark in 5 seconds
        //
        ClearTimer          := TTimer.Create(Self);
        ClearTimer.OnTimer  := ClearTimerTimeout;
        ClearTimer.Tag      := CurrentGrid.Handle;
        ClearTimer.Interval := 5000;
        ClearTimer.Enabled  := true;

      end;

      fPaintTimer.Enabled := false;
    end;
  end;

  procedure TBaseInputGUI.ClearTimerTimeout(Sender: TObject);
  var
    CurrentGrid: TwwDBGrid;
  begin
    if (Sender is TTimer) and (not(csDestroying in ComponentState)) then begin
      with TTimer(Sender) do begin
        //
        // Find the grid by the handle stored in the timer's tag
        //
        CurrentGrid := TwwDBGrid(FindControl(Tag));

        //
        // The watermark is cleared when the grid is repainted
        //
        if Assigned(CurrentGrid) then CurrentGrid.Invalidate;

        Free;
      end;
    end;
  end;

  procedure TBaseInputGUI.SetupgridSorting;
  var
    Index: integer;
    ctr  : integer;
    PER  : PEventRec;
    function GridtoincludedForsorting: boolean;
    begin
      result := pos(TwwDBGrid(Components[Index]).Name, GridstoExcludeFromsorting) = 0;
    end;

  begin
    SetLength(GridstoSort, 0);
    SetLength(Gridindexes, 0);
    ctr := 0;
    if not AllowGridSorting then Exit;
    for Index := 0 to ComponentCount - 1 do begin
      if (Components[Index] is TwwDBGrid) then begin
        if GridtoincludedForsorting then begin
          ctr := ctr + 1;
          SetLength(GridstoSort, ctr);
          SetLength(Gridindexes, ctr);
          GridstoSort[ctr - 1] := TwwDBGrid(Components[Index]).Name;
          Gridindexes[ctr - 1] := '';
          if Assigned(TwwDBGrid(Components[Index]).onTitleButtonClick) then begin
            System.New(PER);
            PER^.EventType := on_Titleclick;
            PER^.Name      := TwwDBGrid(Components[Index]).Name;
            PER^.Data      := TMethod(TwwCustomDBGrid(Components[Index]).onTitleButtonClick).Data;
            PER^.Code      := TMethod(TwwCustomDBGrid(Components[Index]).onTitleButtonClick).Code;
            EventList.Add(PER);
          end;
          TwwDBGrid(Components[Index]).onTitleButtonClick := GridTitleButtonClick;
          TwwDBGrid(Components[Index]).TitleImageList     := imgsort;

          if Assigned(TwwDBGrid(Components[Index]).onCalcTitleImage) then begin
            System.New(PER);
            PER^.EventType := On_CalcTitleImage;
            PER^.Name      := TwwDBGrid(Components[Index]).Name;
            PER^.Data      := TMethod(TwwCustomDBGrid(Components[Index]).onCalcTitleImage).Data;
            PER^.Code      := TMethod(TwwCustomDBGrid(Components[Index]).onCalcTitleImage).Code;
            EventList.Add(PER);
          end;
          TwwDBGrid(Components[Index]).onCalcTitleImage := GridTitleImage;

        end;
      end;
    end;
  end;

  procedure TBaseInputGUI.AddFieldtoGrid(const Grid: TwwDBGrid; const fsfieldName: string; fieldIndex: integer = -1);
  begin
    if not(GuiPrefs.Active) then Exit;
    if not(Assigned(GuiPrefs.DbGridElement[Grid])) then Exit;
    GuiPrefs.DbGridElement[Grid].AddField(fsfieldName);
    if fieldIndex >= 0 then Grid.DataSource.DataSet.FieldByName(fsfieldName).Index := fieldIndex;
  end;

  procedure TBaseInputGUI.GridTitleButtonClick(Sender: TObject; AfieldName: String);
  var
    NotifyEvent: TTitleButtonClickEvent;
    EventRec   : TFormEventRec;
  begin
    try
      if TwwDBGrid(Sender).DataSource.DataSet.findfield(AfieldName) = nil then Exit;
    finally
      // kill the exception for the group name
    end;
    try
      if Self.GetEventRec(EventRec, TwwDBGrid(Sender).Name, on_Titleclick) then begin
        TMethod(NotifyEvent).Data := EventRec.Data;
        TMethod(NotifyEvent).Code := EventRec.Code;
        NotifyEvent(Sender, AfieldName);
      end;
      if not CancelGridSort then SortGrid(AfieldName, Sender);
    finally
      CancelGridSort := false;
    end;
  end;

  procedure TBaseInputGUI.SetupCustomiseGrid;
  var
    Grid          : TwwDBGrid;
    Index         : integer;
//    NewItem       : TMenuItem;
    (*CountMenuItems: integer;
    FoundMenuItem : boolean;*)
    function GridtoincludedForCustomize: boolean;
    begin
      result := pos(TwwDBGrid(Components[Index]).Name, GridstoExcludefromcustomize) = 0;
    end;
    function GridHasDefaultOptions: boolean;
    begin
      result := pos(TwwDBGrid(Components[Index]).Name, GridsToIncludeforDefaultOptions) <>0;
    end;

  begin
    //if not AllowCustomiseGrid then Exit;
    for Index := 0 to ComponentCount - 1 do begin
      if (Components[Index] is TwwDBGrid) then begin
        Grid := TwwDBGrid(Components[Index]);
        if GridHasDefaultOptions then Grid.Options :=[dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit,dgWordWrap,dgMultiSelect,dgRowResize];
        if not AllowCustomiseGrid then continue;
        if GridtoincludedForCustomize then begin
          Grid.OnBeforePaint := GridBeforePaint;
          GuiPrefs.Elements.Add('TwwDbGridGuiElement', Grid);
          if ShowCustomisemenu then begin
            //FoundMenuItem := false;
            if Assigned(Grid.PopupMenu) then begin // Search for existing customise grid popup item
              NewMenuItem('Customise Grid' , CustomiseGridClick , False,  Grid.PopupMenu , '');
              if dgEditing in Grid.options then AddCutAndPasteItems(TAdvPopupMenu(Grid.PopupMenu), 0);
              (*CountMenuItems := 0;
              while (CountMenuItems < Grid.PopupMenu.Items.Count) and (FoundMenuItem = false) do begin
                if Grid.PopupMenu.Items[CountMenuItems].Caption = 'Customise Grid' then begin
                  FoundMenuItem                                                                                         := true;
                  if not Grid.PopupMenu.Items[CountMenuItems].visible then Grid.PopupMenu.Items[CountMenuItems].visible := true;
                  Break;
                end
                else Inc(CountMenuItems);
              end; // Customise menu item was not found, so add it

              if FoundMenuItem then begin
                AddCutAndPasteItems(TAdvPopupMenu(Grid.PopupMenu), 0);
              end
              else begin
                NewItem         := TMenuItem.Create(TAdvPopupMenu(Grid.PopupMenu));
                NewItem.Caption := 'Customise Grid';
                NewItem.OnClick := CustomiseGridClick;
                Grid.PopupMenu.Items.Add(NewItem);
                AddCutAndPasteItems(TAdvPopupMenu(Grid.PopupMenu), 0);
              end; *)
            end
            else begin
              Grid.PopupMenu := popCustomiseGrid;
              if dgEditing in Grid.options then AddCutAndPasteItems(popCustomiseGrid, 0);
            end;
          end;
        end;
      end;
    end;
  end;

  procedure TBaseInputGUI.CustomiseGridClick(Sender: TObject);
  begin
    inherited;
    try
      GuiPrefs.ShowCustomiseForm(iif(screen.activecontrol is twwdbgrid  ,GridnametoCaption(twwdbgrid(screen.activecontrol).name) , '')) // focus to the grid page
    Except
      on E:Exception do begin
        // if can't find the grid
        GuiPrefs.ShowCustomiseForm;
      end;
    end;
    DoAfterShowCustomiseForm;
  end;

  procedure TBaseInputGUI.FormClose(Sender: TObject; var Action: TCloseAction);
  var
    X           : integer;
    prefsChanged: boolean;
  begin
    WriteGuiPrefExtra;
    Application.ProcessMessages; // An Attempt To Stop Msg Post After or In Destroy.
    prefsChanged := false;
    for X        := 0 to Self.ComponentCount - 1 do begin
      if Self.Components[X] is TERPDbLookupcombo then begin
        if GuiPrefs.Node[TERPDbLookupcombo(Components[X]).Name + '.SearchMode'].AsInteger <> Ord(TERPDbLookupcombo(Components[X]).SearchMode) then begin

          GuiPrefs.Node[TERPDbLookupcombo(Components[X]).Name + '.SearchMode'].AsInteger := Ord(TERPDbLookupcombo(Components[X]).SearchMode);
          prefsChanged                                                                   := true;
        end;
      end;
    end;

    if prefsChanged or IsLocalPrefChanged or (Assigned(GuiPrefs) and (GuiPrefs.Dirty)) then begin
      if Assigned(GuiPrefs) then begin
        try
          GuiPrefs.SavePrefs;
          GuiPrefs.Dirty := false;
        except
          on E: Exception do begin
            raise Exception.Create('Error saving GuiPreffs: ' + E.Classname + ' ' + E.message);
          end;
        end;
      end;
    end;

    inherited;
  end;

  function TBaseInputGUI.ActiveField(Grid: TObject): TField;
  begin
    result                           := nil;
    if Grid is TwwDBGrid then result := TField(TwwDBGrid(Grid).GetActiveField);
  end;

  procedure TBaseInputGUI.AddCutAndPasteItems(const GridPopupMenu: TAdvPopupMenu; ItemIndex: integer);
  const
    ItemCaptions: array [1 .. 9] of string = ('Undo', '-', 'Cut', 'Copy', 'Paste', 'Delete', '-', 'Select All', '-');
  var
    Index  : integer;
    NewItem: TMenuItem;
  begin
    if not fCutAndPasteAdded then begin
        GridPopupMenu.AutoHotkeys := maManual;

        for Index         := Low(ItemCaptions) to High(ItemCaptions) do begin
          NewItem         := TMenuItem.Create(GridPopupMenu);
          NewItem.Caption := ItemCaptions[Index];
          NewItem.OnClick := HandlePopupClick;
          GridPopupMenu.Items.Insert(ItemIndex, NewItem);
          Inc(ItemIndex);
        end;

        fCutAndPasteAdded := true;
    end;
  end;

  (* procedure TBaseInputGUI.HandlePopupClick(Sender: TObject);
    begin
    try
    if ActiveControl= nil then exit;

    if Sender is TMenuItem then begin
    with TMenuItem(Sender) do begin
    if Sysutils.SameText(Caption, 'Undo') then
    SendMessage(ActiveControl.Handle, WM_UNDO, 0, 0)
    else if Sysutils.SameText(Caption, 'Cut') then
    SendMessage(ActiveControl.Handle, WM_CUT, 0, 0)
    else if Sysutils.SameText(Caption, 'Copy') then
    SendMessage(ActiveControl.Handle, WM_COPY, 0, 0)
    else if Sysutils.SameText(Caption, 'Paste') then
    SendMessage(ActiveControl.Handle, WM_PASTE, 0, 0)
    else if Sysutils.SameText(Caption, 'Delete') then
    SendMessage(ActiveControl.Handle, WM_CLEAR, 0, 0)
    else if Sysutils.SameText(Caption, 'Select All') then
    SendMessage(ActiveControl.Handle, EM_SETSEL, 0, -1);
    end;
    end;
    Except
    // kill the exception if any
    end;
    end; *)

  class function TBaseInputGUI.Load(const aClassName: string; const aKeyID: integer; oObserver: TObject): TBaseInputGUI;
  var
    lForm: TComponent;
  begin
    result := nil;
    ProcessingCursor(true);
    try
      lForm := GetComponentByClassName(aClassName);
      if Assigned(lForm) and (lForm is TBaseInputGUI) then begin
        result       := TBaseInputGUI(lForm);
        result.KeyID := aKeyID;
        if Assigned(oObserver) then result.AttachObserver(oObserver);
        if result.visible then begin
          result.BringToFront;
          if Assigned(result.OnShow) then result.OnShow(oObserver);
        end
        else begin
          result.FormStyle := fsMDIChild;
          result.BringToFront;
        end;
      end;
    finally
      ProcessingCursor(false);
    end;
  end;

  procedure TBaseInputGUI.LoadReportTypes(reportTypeID: integer; LoadReportTypesconditions: String);
  begin
    if reportTypeID = 0 then
         inherited LoadReportTypes(GetReportTypeID,LoadReportTypesconditions)
    else inherited LoadReportTypes(reportTypeID   ,LoadReportTypesconditions);
  end;

  function TBaseInputGUI.GetBusinessObject: TObject;
  begin
    result := nil;
  end;

  procedure TBaseInputGUI.SetFormFocus(var Msg: TMessage);
  begin
    SetControlFocus(frmToPopup);
  end;

  procedure TBaseInputGUI.ColorToActive(fFont: Tfont);
  begin
    fFont.Color := clBlack;
  end;

  procedure TBaseInputGUI.ColorToInactive(fFont: Tfont);
  begin
    fFont.Color := clgray;
  end;

  function TBaseInputGUI.IDfromcombo(Combo: TwwDBLookupCombo): integer;
  begin
    result := 0;
  end;

procedure TBaseInputGUI.InitGuiPrefsReadonlyFields;
  begin

  end;

  procedure TBaseInputGUI.InitPopupform(frmPopup: TBaseInputGUI);
  begin
    // descendants will override if necessary
  end;


procedure TBaseInputGUI.ClosenOpenDB(Ds: TDataSet);
  begin
    if Ds = nil then Exit;
    CloseDB(Ds);
    openDB(Ds);
  end;

  procedure TBaseInputGUI.FeldSetTextDontAllowNulls(Sender: TField; const Text: String);
  begin
    inherited;
    { NOTE: When users are typing values into an invoice at high speed we are
            occasinally getting a dataset not in edit exception here so the
            following code attempts to fix this. }
    if not (Sender.Dataset.State in [dsInsert, dsEdit]) then begin
      try
        Sender.Dataset.Edit;
      except
      end;
    end;

    try
      if Text = '' then Sender.AsString := '0'
      else Sender.AsString := Text;
    except
    end;
  end;

  procedure TBaseInputGUI.CloseDB(Ds: TDataSet);
  begin
    if Ds = nil then Exit;
    if Ds.Active then Ds.Close;
  end;


  procedure TBaseInputGUI.openDB(Ds: TDataSet);
  begin
    if Ds = nil then Exit;
    if Ds.Active = false then Ds.Open;

  end;

  procedure TBaseInputGUI.ShowformComments;
  begin
    TfmFormcomments.ShowformComments(formID);
  end;

procedure TBaseInputGUI.ShowUserApprovalPref;
begin
  DoDelayObjectProcedure(DoShowUserApprovalPref,1000, Self.classname +'.DoShowUserApprovalPref');
end;
procedure TBaseInputGUI.DoShowUserApprovalPref;
begin
  LogCurrenttime('opening Preference');
  OpenPrefform('Payments' ,  'chkUseApprovalLevels', 0 , True, 'Approvals' , 'pnlapprovals' ,
                    'Changes made here will not take affect unless the Application is Restarted.');
end;

procedure TBaseInputGUI.SortGrid(const AfieldName: String; const Sender: TObject);

    function DataSet: TERPQuery;
    begin
      result := TERPQuery(TwwDBGrid(Sender).DataSource.DataSet);
    end;

  begin
    if FieldinNotToSortList(TwwDBGrid(Sender).Name, AfieldName) then Exit;
    if (DataSet.FieldByName(AfieldName).FieldKind = fkLookup) then Exit;
    if (DataSet.FieldByName(AfieldName).FieldKind = fkCalculated) then Exit;

    if DataSet.IndexFieldNames = '' then begin
      DataSet.IndexFieldNames := AfieldName + ' ASC CIS;';
    end
    else begin
      if FastFuncs.PosEx(AfieldName, DataSet.IndexFieldNames) = 0 then begin
        DataSet.IndexFieldNames := AfieldName + ' ASC CIS;';
      end
      else begin
        if PosEx(' ASC ', DataSet.IndexFieldNames) <> 0 then DataSet.IndexFieldNames       := StringReplace(DataSet.IndexFieldNames, ' ASC ', ' DESC ', [])
        else if PosEx(' DESC ', DataSet.IndexFieldNames) <> 0 then DataSet.IndexFieldNames := StringReplace(DataSet.IndexFieldNames, ' DESC ', ' ASC ', [])
        else DataSet.IndexFieldNames                                                       := '';
      end;
    end;
    if GuiPrefs <> nil then
      if GuiPrefs.Active then
        if GuiPrefs.DbGridElement[TwwDBGrid(Sender)] <> nil then GuiPrefs.DbGridElement[TwwDBGrid(Sender)].Node['IndexFieldNames'].AsString := DataSet.IndexFieldNames;
  end;

  function TBaseInputGUI.FieldinNotToSortList(Gridname, AfieldName: String): boolean;
  begin
    result := pos(uppercase(trim(Gridname) + ':' + trim(AfieldName)), uppercase(FieldsToExecludeFromsorting)) <> 0;
  end;

  procedure TBaseInputGUI.GridTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
  var
    NotifyEvent: TwwCalcTitleImageEvent;
    EventRec   : TFormEventRec;

    function DataSet: TERPQuery;
    begin
      result := TERPQuery(TwwDBGrid(Sender).DataSource.DataSet);
    end;

  begin
    if Self.GetEventRec(EventRec, TwwDBGrid(Sender).Name, On_CalcTitleImage) then begin
      TMethod(NotifyEvent).Data := EventRec.Data;
      TMethod(NotifyEvent).Code := EventRec.Code;
      NotifyEvent(Sender, Field, TitleImageAttributes);
    end;
    if (FastFuncs.PosEx(QuotedStr(Field.Fieldname) + ' ASC', DataSet.IndexFieldNames) > 0) or (FastFuncs.PosEx(Field.Fieldname + ' ASC', DataSet.IndexFieldNames) > 0) then begin
      TitleImageAttributes.ImageIndex := ascImageIndex;
    end
    else if (FastFuncs.PosEx(QuotedStr(Field.Fieldname) + ' DESC', DataSet.IndexFieldNames) > 0) or (FastFuncs.PosEx(Field.Fieldname + ' DESC', DataSet.IndexFieldNames) > 0) then
    begin
      TitleImageAttributes.ImageIndex := DescImageIndex;
    end
    else begin
      TitleImageAttributes.ImageIndex := -1;
    end;
  end;

  Procedure TBaseInputGUI.ExcludeGridfromcustomize(const Sender: TwwDBGrid);
  begin
    if GridstoExcludefromcustomize <> '' then GridstoExcludefromcustomize := GridstoExcludefromcustomize + ';';
    GridstoExcludefromcustomize                                           := GridstoExcludefromcustomize + Sender.Name;
  end;
  Procedure TBaseInputGUI.IncludeForDefaultOptions(const Sender: TwwDBGrid);
  begin
    if GridsToIncludeforDefaultOptions <> '' then GridsToIncludeforDefaultOptions := GridsToIncludeforDefaultOptions + ';';
    GridsToIncludeforDefaultOptions                                           := GridsToIncludeforDefaultOptions + Sender.Name;
  end;

  procedure TBaseInputGUI.excludeGridfromsorting(const Sender: TwwDBGrid);
  begin
    if GridstoExcludeFromsorting <> '' then GridstoExcludeFromsorting := GridstoExcludeFromsorting + ';';
    GridstoExcludeFromsorting                                         := GridstoExcludeFromsorting + Sender.Name;
  end;

  procedure TBaseInputGUI.ExecuteSQLinconnection(sSQL: String);
  begin
    With TempMyScript do
      try
        Connection := Self.MyConnection;
        Sql.Add(sSQL);
        Execute;
      finally
        Free;
      end;
  end;

  function TBaseInputGUI.FieldsToExecludeFromsorting: String;
  begin
    result := ''
  end;

  procedure TBaseInputGUI.FlagAsUpdated(aMainDataset: TDataSet);
  var
    Field: TField;
  begin
    if not aMainDataset.Active then Exit;
    Field := aMainDataset.findfield('msTimeStamp');
    if Assigned(Field) then begin
      editDB(aMainDataset);
      Field.AsDateTime := Now;
    end;
  end;

  function TBaseInputGUI.IsLocalPrefChanged: boolean;
  begin
    result := fbIsLocalPrefChanged;
  end;

  procedure TBaseInputGUI.IterateRecords(Const Sender: TDataSet; CallbackFunc: TDatasetIterateCallbackProc; DisableFilter: boolean);
  var
    bm        : TBookmark;
    Abort     : boolean;
    fbFiltered: boolean;
  begin
    bm := Sender.GetBookmark;
    try
      fbFiltered                            := Sender.filtered;
      if DisableFilter THEN Sender.filtered := false;
      try
        if (Sender.recordcount < 1) then Exit;
        Sender.first;
        while not Sender.Eof do begin
          Abort := false;
          if Assigned(CallbackFunc) then CallbackFunc(Sender, Abort);
          if Abort then Break;
          Sender.Next;
        end;
      finally
        if DisableFilter then Sender.filtered := fbFiltered;
      end;
    finally
      Sender.GotoBookmark(bm);
      Sender.FreeBookmark(bm);
    end;

  end;

  function TBaseInputGUI.GetReportTypeIDForTypeName(const TypeName: string): integer;
  var
    Qry: TERPQuery;
  begin
    Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      Qry.Sql.Add('select tt.TypeID from tbltemplatetype tt, tbltemplates t');
      Qry.Sql.Add('where t.TypeID = tt.TypeID');
      Qry.Sql.Add('and t.DefaultTemplate = "T"');
      Qry.Sql.Add('and TypeName = ' + QuotedStr(TypeName));
      Qry.Open;
      if not Qry.IsEmpty then result := Qry.FieldByName('TypeID').AsInteger
      else result                    := 0;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qry);
    end;
  end;

  function TBaseInputGUI.GetSalesEmails(aEmployeeID:Integer =0): string;
  var
    qryTempEmail: TERPQuery;
  begin
    qryTempEmail := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qryTempEmail.Sql.Add('SELECT Distinct Email FROM tblemployees');
      qryTempEmail.Sql.Add('where (TrackSales = "T" or EmployeeId = ' + inttostr(aEmployeeID) +')  '+
                              ' and ifnull(Email,"") <> ""');
      qryTempEmail.Active := true;
      result              := '';
      while not qryTempEmail.Eof do begin
        if result = '' then result := qryTempEmail.FieldByName('Email').AsString
        else result                := result + ',' + qryTempEmail.FieldByName('Email').AsString;
        qryTempEmail.Next;
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTempEmail);
    end;
  end;

  procedure TBaseInputGUI.CloseAfterPrint(aCloseWhenDone: Boolean = True);
  begin
    if aCloseWhenDone = false then Self.BeginTransaction
    else if Appenv.Employee.CloseOnPrint and not(devmode) then Self.CloseWait
    else Self.BeginTransaction;
  end;

  function TBaseInputGUI.GetMainTablename: String;
  begin
    result := '';
  end;

  procedure TBaseInputGUI.MakeBusobjPropertiesMenuoption;
  var
    obj: TComponent;
  begin
    if fsBusobjClassname = '' then Exit;
    try
      { option available only if we have added properties in the list for validation }
      if devmode = false then
        if HasObjectProperties(fsBusobjClassname) = false then Exit;

      obj := GetComponentByClassName(fsBusobjClassname);
      try
        if obj = nil then Exit;
        if not(obj is Tbusobj) then Exit;

        if Assigned(PopupMenu) then PopupMenu.Items.Add(mnuBusobjPropertiesoption)
        else Self.PopupMenu               := mnuBusobjProperties;
        mnuBusobjPropertiesoption.Caption := 'Customise ' + Tbusobj(obj).xmlNodename + ' Validation';
      finally
        FreeAndNil(obj);
      end;
    Except
      // kill exception if called again
    end;
  end;

  function TBaseInputGUI.MakeForm(const ComponentClassName: string; const SingleInstance: boolean; const Owner: TComponent; const CheckAccessLevel, showErrorMsg: boolean;
    const iTag: integer): TComponent;
  begin
    result := FindExistingComponent(ComponentClassName, iTag);
    if Assigned(result) then Exit;
    result := GetComponentByClassName(ComponentClassName, SingleInstance, Owner, CheckAccessLevel, showErrorMsg, iTag);
    if result is TBaseInputGUI then begin
      TBaseInputGUI(result).CallHookupComboEvents;
    end;
  end;

procedure TBaseInputGUI.mnuBusobjPropertiesoptionClick(Sender: TObject);
  begin
    inherited;
    PopulateObjectProperties(fsBusobjClassname, Self);
  end;

  procedure TBaseInputGUI.MonitorConnectionEvents;
  var
    i: integer;
  begin
    if Appenv.CompanyPrefs.MonitorTransactionEvents = false then Exit;

    for i := 0 to ComponentCount - 1 do
      if Components[i] is TERPConnection then begin
        TERPConnection(Components[i]).MonitorTransactionEvents := true;
        TERPConnection(Components[i]).OnError                  := DoErrorLog;
        TERPConnection(Components[i]).ERPUser                  := Appenv.Employee.EmployeeName;
        TERPConnection(Components[i]).ERPPCName                := CommonLib.GetPCName;
      end;
  end;

procedure TBaseInputGUI.MyConnectionAfterCommit(Sender: TObject);
  begin
{$IFDEF EXCEPTIONAL_MAGIC}
    UserActions.Add(uetNone, 0, 0, 'MyConnectionAfterCommit');
{$ENDIF}
    inherited;
    if (fbforceSavesound) or (not(fbNoSavesound)) then PlaySavesound;

  end;

  procedure TBaseInputGUI.MyConnectionAfterRollback(Sender: TObject);
  begin
    inherited;
    if (fbForceRollbackSound) or (not(fbNoCanelsound)) then Playcancelsound;
  end;

  function TBaseInputGUI.InUseRecords: String;
  begin
    result := '---------------------------In Use Records----------------------';
    With CommonDbLib.TempMyQuery do
      try
        Sql.Add('Select * from tblinuse order by timeEntered');
        Open;
        if recordcount = 0 then Exit;
        result := result + chr(13) + 'ID' + #9 + 'Username' + #9 + 'Instance' + #9 + 'ClassName' + #9 + 'KeyID' + #9 + 'DatasetName' + #9 + 'GroupName' + #9 + 'TimeEntered' + #9 +
          'GlobalRef' + #9 + 'msTimeStamp';

        first;
        While Eof = false do begin
          result := result + chr(13) + FieldByName('ID').AsString + #9 + FieldByName('Username').AsString + #9 + FieldByName('Instance').AsString + #9 + FieldByName('ClassName')
            .AsString + #9 + FieldByName('KeyID').AsString + #9 + FieldByName('DatasetName').AsString + #9 + FieldByName('GroupName').AsString + #9 +
            FormatDateTime(FormatSettings.LongDateFormat, FieldByName('TimeEntered').AsDateTime) + #9 + FieldByName('GlobalRef').AsString + #9 +
            FormatDateTime(FormatSettings.LongDateFormat, FieldByName('msTimeStamp').AsDateTime);
          Next;
        end;
      finally
        if Active then Close;
        Free;
      end;
  end;

  procedure TBaseInputGUI.DoErrorLog(Sender: TERPConnection; E: Exception);
  var
    err: String;
  begin
    TRY
      err := E.message;
      err := err + chr(13) + InUseRecords;
      err := err + chr(13) + TransactionEvents.EventsInOtherTransactions(Sender);
{$IFDEF EXCEPTIONAL_MAGIC}
      ExceptionAppInfo.TransactionEventsummary := err;
      err                                      := E.message;
      Raise E;
{$ELSE}
      CommonLib.MessageDlgXP_Vista(err, mtWarning, [mbOK], 0);
{$ENDIF}
    FINALLY
      Sender.Rollback;
      Self.Close;
    END;
  end;

  procedure TBaseInputGUI.DoExtraTranslation;
  begin
    inherited;
    GuiPrefs.DoTranslate;
  end;

procedure TBaseInputGUI.DoFocusControl(const FocusControltype: String);
begin

end;

procedure TBaseInputGUI.DoFormSize(ChangeSize: boolean);
  begin
    if Assigned(GuiPrefs) then begin
      if not GuiPrefs.Active then GuiPrefs.Active := true;
      sizeMode                                    := ReadGuipref('Options.sizeMode');
      // SizeMode := GuiPrefs.Node['Options.sizeMode'].asString;
    end;

    if (ChangeSize and (sizeMode = 'N')) or (not(ChangeSize) and (sizeMode = 'M')) then begin
      if Self.WindowState <> wsMaximized then Self.WindowState := wsMaximized;
      sizeMode                                                 := 'M';
    end
    else begin
      if Self.WindowState <> wsNormal then Self.WindowState := wsNormal;
      sizeMode                                              := 'N';
    end;
    if Assigned(GuiPrefs) and GuiPrefs.Active then begin
      GuiPrefs.Node['Options.sizeMode'].AsString := iif((WindowState = wsMaximized) and (sizeMode = 'M'), 'M', 'N');
    end;
  end;

  procedure TBaseInputGUI.DoMemoriseTrans(const fID, fclientID: integer; autoPost: boolean; title: string);
  var
    RepeatFrm: TRepeatFrm;
    i        : integer;
  begin
    openDB(qryMemTrans);
    RepeatFrm := TRepeatFrm.Create(Self, CommonDbLib.GetSharedMyDacConnection.Database);
    try
      RepeatFrm.Caption := 'Memorise ' + title;
      If RepeatFrm.ShowModal = mrOk then begin
        for i := 0 to Length(RepeatFrm.dates) - 1 do begin
          qryMemTrans.Append;
          qryMemTrans.FieldByName('DateDue').AsDateTime     := RepeatFrm.dates[i];
          qryMemTrans.FieldByName('Type').AsString          := TypeToDescription(ClassNameToTranType(Self.Classname));
          qryMemTrans.FieldByName('TransID').AsInteger      := fID;
          qryMemTrans.FieldByName('ClientID').AsInteger     := fclientID;
          qryMemTrans.FieldByName('formClass').AsString     := Self.Classname;
          qryMemTrans.FieldByName('autoPost').asBoolean     := autoPost;
          qryMemTrans.FieldByName('createdDate').AsDateTime := Date;
          qryMemTrans.Post;
        end;
        CommonLib.MessageDlgXP_Vista(title + ' : Memorised ' + IntToStr(Length(RepeatFrm.dates)) + ' time(s) ', mtInformation, [mbOK], 0);
      end;
    finally
      RepeatFrm.Free;
    end;
  end;

procedure TBaseInputGUI.AfterFormShow;
  begin
    inherited;
    fbNoSavesound  := false;
    fbNoCanelsound := false;
    ReopeningForm:= False;
    ReopeningFormClass:= '';
    InitGridcolumnsforGuiPrefs;
  end;

  procedure TBaseInputGUI.HideProgressbar;
  begin
    DoHideProgressbar;
  end;

  procedure TBaseInputGUI.showProgressbar(Progressbarcaption: String; Progresscount: integer; ISPercent: boolean = true);
  begin
    DoShowProgressbar(Progresscount, Progressbarcaption, '', ISPercent);
  end;

  procedure TBaseInputGUI.stepProgressbar(const ProgressbarMsg: String = '');
  begin
    if HasActiveProgressbar then DoStepProgressbar(ProgressbarMsg);
  end;

  procedure TBaseInputGUI.SwapPairdField(Ds: TDataSet; grd: TwwDBGrid; fieldshown, fieldtobeshown: String);
  begin
    NamenPrintNameGridObj.SwapPairdField(Ds, grd, fieldshown, fieldtobeshown);

  end;

  procedure TBaseInputGUI.customiseGridDateTimePicker;
  var
    i: integer;
  begin
    inherited;
    for i                                                                                := 0 to ComponentCount - 1 do
      if Components[i] is TwwDBGrid then TwwDBGrid(Components[i]).OnCreateDateTimePicker := DocustomiseGridDateTimePicker
      else if Components[i] is TwwDBDateTimePicker then
        if TwwDBDateTimePicker(Components[i]).CalendarAttributes.PopupYearOptions.NumberColumns < 4 then
            TwwDBDateTimePicker(Components[i]).CalendarAttributes.PopupYearOptions.NumberColumns := 4;
  end;

  procedure TBaseInputGUI.DocustomiseGridDateTimePicker(Sender: TObject; ADateTimePicker: TwwDBCustomDateTimePicker);
  begin
    ADateTimePicker.CalendarAttributes.PopupYearOptions.NumberColumns  := 4;
    ADateTimePicker.CalendarAttributes.PopupYearOptions.StartYear      := 1990;
    ADateTimePicker.CalendarAttributes.PopupYearOptions.YearsPerColumn := 10;
  end;

  Procedure TBaseInputGUI.OpenQryCustomField(const CustomfieldPrefix: String);
  begin
    CloseDB(QryCustomField);
    QryCustomField.Sql.Clear;
    QryCustomField.Sql.Add('SELECT ');
    QryCustomField.Sql.Add('CFLabel2,');
    QryCustomField.Sql.Add('CFLabel3,');
    QryCustomField.Sql.Add('CFLabel4,');
    QryCustomField.Sql.Add('CFLabel5,');
    QryCustomField.Sql.Add('CFLabel6,');
    QryCustomField.Sql.Add('CFLabel7,');
    QryCustomField.Sql.Add('CFLabel8,');
    QryCustomField.Sql.Add('CFLabel9,');
    QryCustomField.Sql.Add('CFLabel10,');
    QryCustomField.Sql.Add('CFLabel11,');
    QryCustomField.Sql.Add('CFLabel12,');
    QryCustomField.Sql.Add('CFLabel13,');
    QryCustomField.Sql.Add('CFLabel14,');
    QryCustomField.Sql.Add('CFLabel15,');
    QryCustomField.Sql.Add('CFLabel16,');
    QryCustomField.Sql.Add('CFLabel17,');
    QryCustomField.Sql.Add('CFLabel18,');
    QryCustomField.Sql.Add('CFIsCombo1,');
    QryCustomField.Sql.Add('CFIsCombo2,');
    QryCustomField.Sql.Add('CFIsCombo3,');
    QryCustomField.Sql.Add('CFIsCombo4,');
    QryCustomField.Sql.Add('CFIsCombo5,');
    QryCustomField.Sql.Add('CFIsCombo6,');
    QryCustomField.Sql.Add('CFIsCombo7,');
    QryCustomField.Sql.Add('CFIsCombo8,');
    QryCustomField.Sql.Add('CFIsCombo9,');
    QryCustomField.Sql.Add('CFIsCombo10,');
    QryCustomField.Sql.Add('CFIsCombo11,');
    QryCustomField.Sql.Add('CFIsCombo12,');
    QryCustomField.Sql.Add('CFIsCombo13,');
    QryCustomField.Sql.Add('CFIsCombo14,');
    QryCustomField.Sql.Add('CFIsCombo15,');
    QryCustomField.Sql.Add('CFLabel1,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '1,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '2,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '3,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '4,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '5,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '6,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '7,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '8,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '9,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '10,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '11,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '12,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '13,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '14,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '15,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '16,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '17,');
    QryCustomField.Sql.Add(CustomfieldPrefix + '18,');
    QryCustomField.Sql.Add('CFIsRequired1,');
    QryCustomField.Sql.Add('CFIsRequired2,');
    QryCustomField.Sql.Add('CFIsRequired3,');
    QryCustomField.Sql.Add('CFIsRequired4,');
    QryCustomField.Sql.Add('CFIsRequired5,');
    QryCustomField.Sql.Add('CFIsRequired6,');
    QryCustomField.Sql.Add('CFIsRequired7,');
    QryCustomField.Sql.Add('CFIsRequired8,');
    QryCustomField.Sql.Add('CFIsRequired9,');
    QryCustomField.Sql.Add('CFIsRequired10,');
    QryCustomField.Sql.Add('CFIsRequired11,');
    QryCustomField.Sql.Add('CFIsRequired12,');
    QryCustomField.Sql.Add('CFIsRequired13,');
    QryCustomField.Sql.Add('CFIsRequired14,');
    QryCustomField.Sql.Add('CFIsRequired15,');
    QryCustomField.Sql.Add('CFIsRequired16,');
    QryCustomField.Sql.Add('CFIsRequired17,');
    QryCustomField.Sql.Add('CFIsRequired18');
    QryCustomField.Sql.Add('FROM');
    QryCustomField.Sql.Add('tblcustomfields AS CF');

    QryCustomField.Connection := CommonDbLib.GetSharedMyDacConnection;;
    openDB(QryCustomField);
  end;

  procedure TBaseInputGUI.CustomFieldRefreshExtra(const CustomfieldPrefix: String; const ctr: integer);
  begin

  end;

  function TBaseInputGUI.CustomFieldExtenderListtype: TListType;
  begin
    result := ltNone;
  end;

  procedure TBaseInputGUI.CustomFieldRefresh(const CustomfieldPrefix: String; const pnl: TPanel; Ownerform: TForm = nil);
  var
    ctr          : integer;
    comp, compLbl: TComponent;
  begin
    OpenQryCustomField(CustomfieldPrefix);
    if Ownerform = nil then Ownerform := Self;

    for ctr                                             := 1 to 18 do begin
      comp                                              := Ownerform.FindComponent('CUSTFLD' + trim(IntToStr(ctr)));
      compLbl                                           := Ownerform.FindComponent('CUSTLBL' + trim(IntToStr(ctr)));
      if Assigned(compLbl) then TLabel(compLbl).Caption := QryCustomField.FieldByName('CFLabel' + trim(IntToStr(ctr))).AsString;

      if Assigned(comp) then begin
        if ctr < 16 then begin
          TwwDBComboBox(comp).Enabled := QryCustomField.FieldByName(CustomfieldPrefix + trim(IntToStr(ctr))).AsString = 'T';
        end
        else begin
          TwwDBDateTimePicker(comp).Enabled := QryCustomField.FieldByName(CustomfieldPrefix + trim(IntToStr(ctr))).AsString = 'T';
        end;
      end;

      if Assigned(compLbl) then TLabel(compLbl).Enabled := TwwDBComboBox(Ownerform.FindComponent('CUSTFLD' + trim(IntToStr(ctr)))).Enabled;
      CustomFieldRefreshExtra(CustomfieldPrefix, ctr);
    end;

    CloseDB(QryCustomField);
    try
      PopulateCustomCombos(pnl);
    Except
      // kill the exception
    end;
  end;

  procedure TBaseInputGUI.OpenCustomFields;
  begin
    DisableForm;
    try
      OpenERPForm('TfrmCustomFields', 0, AttachERPFormToObserver);
    finally
      EnableForm;
    end;
  end;

  procedure TBaseInputGUI.CustomFieldsRefresh;
  begin
    // descendants will override if required
  end;

  procedure TBaseInputGUI.AttachERPFormToObserver(Sender: TObject);
  begin
    if Sender is TBaseInputGUI then TBaseInputGUI(Sender).AttachObserver(Self);
  end;

  procedure TBaseInputGUI.ActivateGuiPrefs(const Value: boolean);
  begin
    if GuiPrefs.Active <> Value then GuiPrefs.Active := Value;
  end;

  function TBaseInputGUI.ReadGuipref(const Prefname: String): String;
  begin
    result                                        := '';
    if GuiPrefs.Node.Exists(Prefname) then result := GuiPrefs.Node[Prefname].AsString;
  end;

  procedure TBaseInputGUI.WriteGuiPref(const Prefname: String; Value: String);
  begin
    if GuiPrefs.Node[Prefname].AsString <> Value then begin
      GuiPrefs.Node[Prefname].AsString := Value;
      fbIsLocalPrefChanged             := true;
    end;
  end;

procedure TBaseInputGUI.DoAfterShowCustomiseForm;
begin

end;

procedure TBaseInputGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
  begin
    inherited;
     if (Sender is TBusObj ) and (Eventtype = BusobjEvent_Event) and (Value = BusObjEvent_onauditTrail) then begin
        fsBusobjAuditLogDetails := TBusObj(Sender).AuditLogDetails;
     end else if eventtype = BusObjEvent_UserInfoMessage then begin
        MessageDlgXP_vista(Value, mtInformation, [mbOK], 0);
     end else if eventtype = BusObjEvent_UserWarningMessage then begin
        MessageDlgXP_vista(Value, mtWarning, [mbOK], 0);
     end else if eventtype = BusObjEvent_UserErrorMessage then begin
        MessageDlgXP_vista(Value, mtError, [mbOK], 0);
     end else if (eventtype = BusObjEvent_Change) and (Value = BusobjEventVal_ApproverID) then begin
        ApprovalcheckObj.OnTransApproverIDChange(Sender);
     end;
    BusobjProgressbarEvent(Sender, EventType, Value);
  end;

  procedure TBaseInputGUI.BusobjProgressbarEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
    function ProgressMsg: String;
    begin
      result                     := Sender.ProgressMsg;
      if result = '' then result := WAITMSG;
    end;

  begin
    inherited;
    if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_ShowProgressbar) then begin
      showProgressbar(ProgressMsg, Sender.Progresscount, false);
    end
    else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_HideProgressbar) then begin
      HideProgressbar;
    end
    else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_ProgressbarProgress) then begin
      stepProgressbar(Sender.ProgressMsg);
      //Self.Refresh;
    end;
  end;

  function TBaseInputGUI.DoComboToPopUp(const Fieldname: string; const cbo: TwwDBLookupCombo): boolean;
  begin
    result := false;
  end;

  Procedure TBaseInputGUI.Disablecontrols(btnclose: TDnmSpeedButton);
  var
    ctr: integer;
  begin
    for ctr := 0 to ComponentCount - 1 do begin
      if (Components[ctr] is TWincontrol) then
        if (Components[ctr] = btnclose) then btnclose.Enabled := true
        else TWincontrol(Components[ctr]).Enabled             := false;
    end;
  end;

  procedure TBaseInputGUI.HideProgressbarform;
  begin
    if HasActiveProgressbar then DoHideProgressbarForm;
  end;

  function TBaseInputGUI.isParamAssigned(Qry: TERPQuery; Paramname: String): boolean;
  begin
    Try
      result := Assigned(Qry.ParamByName(Paramname));
    except
      result := false;
    end;
  end;

  procedure TBaseInputGUI.AfterPopupformshow;
  begin
    // descendants will override if required
  end;

  procedure TBaseInputGUI.AftershowPopupform(frmPopup: TBaseInputGUI);
  begin
    // descendants will override if necessary
  end;

  procedure TBaseInputGUI.ShowLocalProgressbar(Progresscount: integer; Progressbarcaption, ProgressBarMessage: string; IsPercenage: boolean);
  begin
    ProgressDialogOBJ.MaxValue    := Progresscount;
    ProgressDialogOBJ.minValue    := 0;
    ProgressDialogOBJ.Step        := 1;
    ProgressDialogOBJ.ShowPercent := IsPercenage;
    ProgressDialogOBJ.Execute;
    // LocalProgressbarcount := LocalProgressbarcount +1;
  end;

  procedure TBaseInputGUI.StepLocalProgressbar(const ProgressBarMessage: String);
  begin
    ProgressDialogOBJ.StepIt;
    if ProgressBarMessage <> '' then ProgressDialogOBJ.message := ProgressBarMessage;
  end;

  procedure TBaseInputGUI.HideLocalProgressbar;
  begin
    // if LocalProgressbarcount> 0 then LocalProgressbarcount:= LocalProgressbarcount-1;
    // if LocalProgressbarcount<=0 then
    ProgressDialogOBJ.CloseDialog;
  end;

  procedure TBaseInputGUI.Openrecord(const ID: integer; const ComponentClassType: String);
  begin
    OpenERPForm(ComponentClassType, ID, AfterSubFormShow, beforeSubFormShow);
  end;

  Function TBaseInputGUI.formID: integer;
  begin
    result := getformID(Self.Classname);
  end;

  procedure TBaseInputGUI.AfterSubFormShow(Sender: TObject);
  begin
    StateParams            := FormReopenerObj.FormReopenerList.Add(Self.Classname, TForm(Sender)).Params;
    StateParams.i['KeyID'] := KeyID;
  end;
  procedure TBaseInputGUI.beforeSubFormShow(Sender: TObject);
  begin

  end;
  procedure TBaseInputGUI.AddDisablescontrolforHint(const ParentPanel: TPanel; disabledcontrol: TControl; const ControlHint: String);
  var
    ctr : integer;
    flag: boolean;
  begin
    flag    := false;
    for ctr := low(DisablescontrolsHints) to high(DisablescontrolsHints) do
      if DisablescontrolsHints[ctr].ParentPanel = ParentPanel then begin
        flag := true;
        Break;
      end;
    if not(flag) then begin
      ParentPanel.OnMouseMove := OnMouseMoveofDisableControlParent;
      ParentPanel.OnExit      := OnExitofDisableControlParent;
    end;

    flag    := false;
    for ctr := low(DisablescontrolsHints) to high(DisablescontrolsHints) do
      if (DisablescontrolsHints[ctr].ParentPanel = ParentPanel) and (DisablescontrolsHints[ctr].disabledcontrol = disabledcontrol) then begin
        flag := true;
        Break;
      end;
    if not(flag) then begin
      SetLength(DisablescontrolsHints, Length(DisablescontrolsHints) + 1);
      ctr                                        := high(DisablescontrolsHints);
      DisablescontrolsHints[ctr].ParentPanel     := ParentPanel;
      DisablescontrolsHints[ctr].disabledcontrol := disabledcontrol;
    end;
    DisablescontrolsHints[ctr].ControlHint := ControlHint;
  end;

  procedure TBaseInputGUI.OnExitofDisableControlParent(Sender: TObject);
  begin
    if Assigned(DisablescontrolHintWindow) then FreeAndNil(DisablescontrolHintWindow);
  end;

  procedure TBaseInputGUI.OnMouseMoveofDisableControlParent(Sender: TObject; Shift: TShiftState; X, Y: integer);
  var
    r     : TRect;
    p     : TPoint;
    cont  : TControl;
    ctr   : integer;
    fsHint: String;
  begin
    inherited;
    cont := nil;
    if not(Sender is TPanel) then Exit;

    for ctr := low(DisablescontrolsHints) to high(DisablescontrolsHints) do
      if (DisablescontrolsHints[ctr].ParentPanel = TPanel(Sender)) and not(DisablescontrolsHints[ctr].disabledcontrol.Enabled) and
        (X >= DisablescontrolsHints[ctr].disabledcontrol.Left) and (X <= (DisablescontrolsHints[ctr].disabledcontrol.Left + DisablescontrolsHints[ctr].disabledcontrol.Width)) and
        (Y >= DisablescontrolsHints[ctr].disabledcontrol.Top) and (Y <= (DisablescontrolsHints[ctr].disabledcontrol.Top + DisablescontrolsHints[ctr].disabledcontrol.Height)) then
      begin
        cont := DisablescontrolsHints[ctr].disabledcontrol;
        Break;
      end;
    if cont = nil then begin
      if Assigned(DisablescontrolHintWindow) then FreeAndNil(DisablescontrolHintWindow);
      Exit;
    end;

    fsHint                     := DisablescontrolsHints[ctr].ControlHint;
    if fsHint = '' then fsHint := DisablescontrolsHints[ctr].disabledcontrol.hint;
    if fsHint = '' then begin
      if Assigned(DisablescontrolHintWindow) then FreeAndNil(DisablescontrolHintWindow);
      Exit;
    end;

    if not Assigned(DisablescontrolHintWindow) then begin
      DisablescontrolHintWindow       := THintWindow.Create(Self);
      DisablescontrolHintWindow.Color := clWhite;
    end;

    p.X    := FormLeft(DisablescontrolsHints[ctr].disabledcontrol) + Trunc(DisablescontrolsHints[ctr].disabledcontrol.Width / 2);
    p.Y    := formtop(DisablescontrolsHints[ctr].disabledcontrol) + DisablescontrolsHints[ctr].disabledcontrol.Height;;
    p      := ClientToScreen(p);
    r.Left := p.X;
    r.Top  := p.Y;

    r.Right  := r.Left + DisablescontrolHintWindow.Canvas.TextWidth(fsHint) + 10;
    r.Bottom := r.Top + DisablescontrolHintWindow.Canvas.TextHeight(fsHint);
    DisablescontrolHintWindow.ActivateHint(r, fsHint);
  end;

  (* procedure TBaseInputGUI.pnlHeaderMouseMove(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
    var
    r: Trect;
    p: TPoint;
    begin
    inherited;
    if (not btnEdit.Enabled) and (btnEdit.Hint <> '') then begin
    if (x >= btnEdit.Left) and (x <= (btnEdit.Left + btnEdit.Width)) and
    (y >= btnEdit.top) and (y <= (btnEdit.Top + btnEdit.Height))then begin
    if not Assigned(EditHintWindow) then begin
    p.X := btnEdit.Left + btnEdit.Width - 10;
    p.Y := btnEdit.Top;
    p := ClientToScreen(p);
    r.Left := p.X;
    r.Top := p.Y;
    EditHintWindow := THintWindow.Create(self);
    EditHintWindow.Color := clWhite;
    r.Right := r.Left + EditHintWindow.Canvas.TextWidth(btnEdit.Hint) +10;
    r.Bottom := r.Top + EditHintWindow.Canvas.TextHeight(btnEdit.Hint);
    EditHintWindow.ActivateHint(r,btnEdit.Hint);
    end;
    end
    else begin
    if Assigned(EditHintWindow) then
    FreeAndNil(EditHintWindow);
    end;
    end;
    end; *)
  function TBaseInputGUI.NamenPrintNameGridObj: TNamenPrintNameGridObj;
  begin
    if fNamenPrintNameGridObj = nil then begin
      fNamenPrintNameGridObj          := TNamenPrintNameGridObj.Create(Self);
      fNamenPrintNameGridObj.GuiPrefs := GuiPrefs;
    end;
    result := fNamenPrintNameGridObj;
  end;

procedure TBaseInputGUI.InitERPLookupCombonFields;
  begin

  end;

procedure TBaseInputGUI.OnGuiPrefsActive(Sender: TObject);
  begin
    if not(Sender is TFormGuiPrefs) then Exit;

  end;

  procedure TBaseInputGUI.SetupProductNamenPrintNameinGrid(Combo, Printcombo: TERPDbLookupcombo; Fieldname, Printfieldname, DescField: String; Grid: TwwDBGrid;
    SearchonPreferredSupplier: boolean = true; SearchOnPrintName: boolean = true; SearchOnGroupfields: boolean = true);
  begin
    NamenPrintNameGridObj.SetupProductNamenPrintNameinGrid(Combo, Printcombo, Fieldname, Printfieldname, DescField, Grid, SearchonPreferredSupplier, SearchOnPrintName,
      SearchOnGroupfields);
  end;

  procedure TBaseInputGUI.SetupClientNamenPrintNameinGrid(SelectedcleintID: integer; Combo, Printcombo: TERPDbLookupcombo; Fieldname, Printfieldname: String; Grid: TwwDBGrid;
    supplierList, CustomerList, ProspectList, JobList: boolean; SearchOnPrintName: boolean);
  begin
    NamenPrintNameGridObj.SetupClientNamenPrintNameinGrid(SelectedcleintID, Combo, Printcombo, Fieldname, Printfieldname, Grid, supplierList, CustomerList, ProspectList, JobList,
      SearchOnPrintName);
  end;
Procedure TBaseInputGUI.Saveclose;
begin
      Notify;
      self.Notify(false);
      if fsModal in FormState then begin
          ModalResult := mrOk;
        end else begin
          Self.Close;
        end;
end;
procedure TBaseInputGUI.SaveLastComboAccessed(var aLastComboAccessed: TwwDBLookupCombo; Sender: TObject);
begin
  if sender is TwwDBLookupcombo then
    aLastComboAccessed := TwwDBLookupcombo(SendeR);
end;

Function TBaseInputGUI.SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport';MasterDetailLink: TJsonObject = nil): boolean;
begin
    result := False;
    if not Empty(ReportName) then begin
      PrintTemplate.ReportSQLSupplied := fbReportSQLSupplied;
      result                          := PrintTemplate.SaveTemplateReport(ReportName, SQLPortion, DoPrint, FileType, FileName, MyConnection, MasterDetailLink);
    end;
end;
procedure TBaseInputGUI.OnPasteSelection(var Key: word); begin end;
procedure TBaseInputGUI.OnCopySelection(var Key: word);begin end;
procedure TBaseInputGUI.InitGridcolumnsforGuiPrefs(sender: TwwDBGrid=nil);
begin
  // descendants will override if reauired . eg: customer form
end;
Function TBaseInputGUI.DoNotAskMsg :boolean;
begin
  REsult := False;
  if GuiPrefs = nil then exit;
  if GuiPrefs.active =false then GuiPrefs.active := True;
  if GuiPrefs.Node.Exists('Options.'+fsMessageOptionPrefix+'DoNotAsk') then
    REsult :=  GuiPrefs.Node['Options.'+fsMessageOptionPrefix+'DoNotAsk'].asBoolean;
end;
procedure TBaseInputGUI.DoOnDoNotAskMsgCheck(Sender: TObject;Checked: boolean);
var
  fiEmailMsgOption :Integer;
begin
    if GuiPrefs = nil then exit;
    if GuiPrefs.active =false then GuiPrefs.active := True;
    if sender is TMessageDlgXP_VistaOption then begin
      GuiPrefs.Node['Options.'+fsMessageOptionPrefix+'MsgOption'].asInteger :=TMessageDlgXP_VistaOption(Sender).msgOption;
      fiEmailMsgOption :=
        TMessageDlgXP_VistaOption(Sender).msgOption;
    end else begin
      GuiPrefs.Node['Options.'+fsMessageOptionPrefix+'DoNotAsk'].asBoolean  := Checked;
    end;
end;

function TBaseInputGUI.MessageOption: Integer;
begin
  REsult := 104;
  if GuiPrefs = nil then exit;
  if GuiPrefs.active =false then GuiPrefs.active := True;
  if GuiPrefs.Node.Exists('Options.'+fsMessageOptionPrefix+'MsgOption') then
    REsult :=  GuiPrefs.Node['Options.'+fsMessageOptionPrefix+'MsgOption'].asInteger;
end;
function TBaseInputGUI.EmailOptiontoStr(const Value: Integer): string;
begin
  if value = 0 then Result := 'Un-Specified'
  else if value = 100 then Result := 'Send Email'
  else if value = 101 then Result := 'Send n Edit Email'
  else if value = 102 then Result := 'Send Silent'
  else if value = 103 then Result := 'Send n Edit Silent'
  else if value = 104 then Result := 'Un-Specified'
  else Result := 'Un-Specified';
end;

procedure TBaseInputGUI.InitreportOptionsform(Sender: TObject);
begin
// descendants will override
end;
function TBaseInputGUI.PrefOptionObj(aSinglebuttonCaption: string;
                        afocuscontrolName: string;
                        aAccesslevel:Integer = 0;
                        aOpenAsModel: boolean = true;
                        aTextSearch: string = '';
                        aSinglePanelToshow: string = '';
                        ainitMsg: string=''): TPrefOptionObj;
begin
  if fPrefOptionObj = nil then fPrefOptionObj := NewPrefOptionObj(Self);
  fPrefOptionObj.InitIt(aSinglebuttonCaption,afocuscontrolName,aAccesslevel,aOpenAsModel,aTextSearch,aSinglePanelToshow,ainitMsg);
  REsult := fPrefOptionObj;
end;
procedure TBaseInputGUI.InitForDefaultOptionsGrid;
begin

end;
procedure TBaseInputGUI.EnabletmrOnshow(atmrOnshowNo:Integer; Seconds: Integer = 1);
begin
  showProgressbar(WAITMSG, 3, false);
  stepProgressbar;
  fitmrOnshowNo:= atmrOnshowNo;
  tmrOnshow.Interval :=Seconds*1000;
  tmrOnshow.Enabled := True;
end;
procedure TBaseInputGUI.tmrOnshowTimer(Sender: TObject);
begin
  inherited;
  tmrOnshow.Enabled := False;
  HideProgressbar
end;
function TBaseInputGUI.ConnInTrans: TERPConnection;
begin
  if Assigned(fTransConnection) then result := fTransConnection
  else result := MyConnection;
end;
procedure TBaseInputGUI.CaptureQueryEvents;
var
  Index:Integer;
  PER: ^TEventRec;
begin
for Index := 0 to ComponentCount - 1 do begin
      if Components[Index] is TERPQuery then begin
        if Assigned(TERPQuery(Components[Index]).BeforeOpen) then begin
          System.New(PER);
          PER^.EventType := BeforeOpen;
          PER^.Name      := TERPQuery(Components[Index]).Name;
          PER^.Data      := TMethod(TERPQuery(Components[Index]).BeforeOpen).Data;
          PER^.Code      := TMethod(TERPQuery(Components[Index]).BeforeOpen).Code;
          EventList.Add(PER);
        end;
        TERPQuery(Components[Index]).BeforeOpen := OnQueryBeforeOpen;

        if Assigned(TERPQuery(Components[Index]).AfterOpen) then begin
          System.New(PER);
          PER^.EventType := AfterOpen;
          PER^.Name      := TERPQuery(Components[Index]).Name;
          PER^.Data      := TMethod(TERPQuery(Components[Index]).AfterOpen).Data;
          PER^.Code      := TMethod(TERPQuery(Components[Index]).AfterOpen).Code;
          EventList.Add(PER);
        end;
        TERPQuery(Components[Index]).AfterOpen := OnQueryAfterOpen;
      end;
end;

end;
procedure TBaseInputGUI.OnQueryAfterOpen(DataSet: TDataSet);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
  try
    if Self.GetEventRec(EventRec, Dataset.Name, AfterOpen) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
	  end;
  End;

  Logtime(Dataset.name);
  ClearLogtime;
end;
procedure TBaseInputGUI.OnQueryBeforeOpen(DataSet: TDataSet);
var
  EventRec: TEventRec;
  DatasetNotifyEvent: TDatasetNotifyEvent;
begin
  try
    if Self.GetEventRec(EventRec, Dataset.Name, BeforeOpen) then
    begin
      TMethod(DatasetNotifyEvent).Data:= EventRec.Data;
      TMethod(DatasetNotifyEvent).Code:= EventRec.Code;
      DatasetNotifyEvent(Dataset);
    end;
  Except
    on E:Exception do begin
	  end;
  End;

  Logtext(Dataset.name);
  Logtext(TERPQuery(Dataset).SQL.Text);
  StartLogtime;
end;
procedure TBaseInputGUI.ReadnApplyGuiPrefExtra;
begin

end;
Procedure TBaseInputGUI.WriteGuiPrefExtra;
begin

end;
end.
