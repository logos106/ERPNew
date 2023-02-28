unit BaseListingForm;

{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  18/03/05  1.00.01 IJB  Changed Grid double click to test for FormStyle when
  fOnGridDataSelect assigned and set modal result.
  Moved windows message consts to MessageConst unit.
  31/03/05  1.00.02  BJ  Changed on click event of the new button to a
  dynamic event - fonNewbtnClick
  04/04/05  1.00.03 IJB  Added code to set CallingClassName property on the
  fprm we are opening from grid double click.
  18/05/05  1.00.04 BJ  PnlHeader is positioned to the centre of headerpanel in
  form show so that positining need not be done in
  individual form.
  25/05/05  1.00.05 BJ  'Raise exception' is changed to MessageDlg for user messages
  20/06/05  1.00.06 IJB  Added tempory fix to UpdateMe to get around bookmark
  access violations.
  25/06/05  1.00.07 IJB  Removed old error handling (replaced my new
  ExcepionalMgic handling).
  22/08/05  1.00.08 IJB  Modified for use with new GuiPrefs stuff sd follows:
  Added IterateList function.
  Added EnabelWebSearch property.
  Added SearchMode property.
  Adde CustomReportName property.
  05/09/05  1.00.09 IJB  Modified list filtering to allow selection of multiple
  values/columns.
  NOTE: My changes to this form are not complete, I have
  introduced ApplyQueryFilter and GroupFilterString but
  these are not implemented yet.
  07/09/05  1.00.10 IJB  Completed implementation of above.
  08/09/05  1.00.11 IJB  Added GuiPrefs object to replace list customisation.
  12/09/05  1.00.12 IJB  Modified list filtering so user now has to hold down Alt
  key to add multiple fields to filter and all selected

  fileds are "ORed".
  14/09/05  1.00.13 IJB  Modified to use property FilterList on form rather than
  private variable flstFilter (flstFilter now gets created
  as required).
  26/09/05  1.00.14 MV   Modified FormShow added call to PopulateFilterCombo after
  applying GuiPrefs as active.
  04/10/05  1.00.15 DSP  Added the property MainTable to allow the use of memory
  tables in ApplyQueryFilter.
  02/11/05  1.00.16 AL   Added ability to search always wildcards
  (no star entry required) in btnGoClick (tmpSearchText := '%'...)
  05/01/05  1.00.17 AL   Added SearchModeLike (VK_F7)
  09/02/06  1.00.18 DSP  Changed HiddenFields to HideField.
  10/02/06  1.00.19 AL   Added THIS_FINANCIAL_YEAR_TO_DATE
  14/02/06  1.00.20 DSP  Added disabling of the cmdNew button when this is a
  modal form.
  27/02/06  1.00.21 DSP  Fixed problem associated with GuiPrefs. Now the
  function call to SaveFieldPrefs is used.
  03/03/06  1.00.22 DSP  Fixed problem with the btnRequery control flickering
  on the forms where it was disabled. Changed code in
  actRefreshQryUpdate.
  22/03/06  1.00.23 ISB  Removed OLD Search Stuff Replace btnGoClick with GoSearch
  28/03/06  1.00.24 BJ   Form activates doesn;t set the focus to the grid while showing
  the hint form.
  27/04/06  1.00.25 DSP  Added check for fkCalculated in actAddToFilterExecute to
  prevent calculated fields from being used in the filter.
  11/05/06  1.00.26 DSP  THe form is now set to be disabled when the grid is
  double-clicked while the event is processed.
  15/08/06  1.00.27 BJ   1)fiAccesslevel and ignoreAccesslevels variables definition is moved into
  the baseform
  2)BusObjQueries is a string array, needs to be resized and initialised in
  the descendants in Formcreate after inherited.
  3) AccessManager property to access the DNMAccessmanager object - for the
  business objects, this object is created in the 'Create' of Baseinput. The
  Business objects are using it from the 'FormCreate' in the descendants.
  4)Changing the caption of the form is moved from the 'Formcreate' to the baseform's
  onFormShow.
  23/08/06  1.00.28 DSP  Set GuiPrefs.Active at the end of FormShow. Had been
  commented out elsewhere in FormShow.

}
{$I ERP.inc}
interface

Uses listlib, TypesLib, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Mask, DBCtrls, ExtCtrls, BaseFormForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, wwDialog,
  Wwlocate, ActnList, SelectionDialog, QueryManipulationObj, ComCtrls, AdvOfficeStatusBar, DNMPanel, PrintDAT, ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwclearbuttongroup, wwradiogroup, wwexport, MessageConst, ProgressDialog, GuiPrefsObj, PrintTemplateObj, BusobjCustomfilter, CustomInputBox, wwdblook, BaseInputForm,
  frmSaveCustomFilter, MessageInterface, Shader, BusObjFCOnReport, kbmMemTable, IntegerListObj, JsonObject, ObserverListObj, UserLockObj,
  DAScript, MyScript , ListChartView , Busobjcustomfields, ReportSQLBase, DNMAction, ConTnrs, FrmClassLookup, FrmEmployeeLookup , FrmProductLookup , DataTreeObj , GridGuiObj,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWExtCtrls , frmBaseListtimerMsg ,frmBaselistingSelectionLookup,
  busobjbase, GIFImg, types , CommonLib;

const
  SEARCH_LABEL_FLASH_PERIOD = 5;
  ACCEPTABLE_LIST_OPENING_TIME = 7;


type
  TcmpProcessNo= (pn1 =1, pn2 = 2, pn3 =3, pn4 = 4, pn5=5, pn6 = 6 );

  TBaseListingGUI = class;
  TAfterPopupFormShowEvent = procedure(ListForm: TBaseListingGUI; PopupForm: TBaseInputGUI) of object;

  TOnGridDataSelect = procedure(Sender: TwwDbGrid) of object;

  TBaseListingSearchMode = (smNone, smFullList, smSearchEngine, smSearchEngineLike);
  TOnGidMultiselect = Procedure (Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean) of Object;
  TIterateselectedRecordsCallback = Procedure (var Abort: boolean; SelIndex:Integer)  of Object;

  TFCField = class(TObject)
  private
    fsDCFieldName: string;
    fsRatetype: string; // S:Sell rate, B:Buy rate , V :Varies on row
  public
    property DCFieldName: string read fsDCFieldName write fsDCFieldName;
    property Ratetype: string read fsRatetype write fsRatetype;
  protected
  end;

  TDateRangetype = (drNormal=1, drShort = 2 , drLong =3);

  TDBEventRec = class;

  TSelectionOptions = (soNone =0, soClass=1, soEmployee= 2, soProduct = 3, soClassnProduct=4);

TBaseListingGUI = class(TBaseForm, IObserverUpdateMeList)
    FooterPanel: TDnmPanel;
    lblNote: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdExport: TDNMSpeedButton;
    btnCustomize: TDNMSpeedButton;
    HeaderPanel: TPanel;
    pnlHeader: TPanel;
    Panel1: TPanel;
    dsMain: TDataSource;
    dlgSave: TSaveDialog;
    Panel2: TPanel;
    Panel3: TPanel;
    lblFilter: TLabel;
    cboFilter: TComboBox;
    lblSearchoptions: TLabel;
    edtSearch: TEdit;
    Label3: TLabel;
    lblTotal: TLabel;
    imgPopup: TImageList;
    grpFilters: TwwRadioGroup;
    dlgPrint: TPdtPrintDAT;
    pnlButtons: TPanel;
    btnAddFilter: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnClear: TDNMSpeedButton;
    actlstFilters: TActionList;
    actAddToFilter: TAction;
    actExecuteFilter: TAction;
    actClearFilter: TAction;
    lblFrom: TLabel;
    lblTo: TLabel;
    pnlAdvPrinting: TDNMPanel;
    LblChooseTemplate: TLabel;
    LblShowPreview: TLabel;
    ChkChooseRpt: TCheckBox;
    chkPreview: TCheckBox;
    chkAdvancedPrinting: TCheckBox;
    wwLocateDialog1: TwwLocateDialog;
    lblTimeLabel: TLabel;
    lblTime: TLabel;
    actMerge: TAction;
    CloseModalTimer: TTimer;
    qryMain: TERPQuery;
    qryPersonalPrefs: TERPQuery;
    MyConnection1: TERPConnection;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    cboDateRange: TComboBox;
    btnRequery: TDNMSpeedButton;
    actRefreshQry: TAction;
    ExportDialog: TProgressDialog;
    mnuFilter: TAdvPopupMenu;
    mnuAndFilter: TMenuItem;
    mnuORFilter: TMenuItem;
    menuline1: TMenuItem;
    mnuAndExcludeFilter: TMenuItem;
    mnuOrExcludefilter: TMenuItem;
    menuline2: TMenuItem;
    mnuAndPartialfilter: TMenuItem;
    mnuORPartialfilter: TMenuItem;
    mnuandExcludepartialfilter: TMenuItem;
    mnuOrexcludePartialfilter: TMenuItem;
    mnuStartSession: TMenuItem;
    mnuEndSession: TMenuItem;
    menuline3: TMenuItem;
    mnuCustomFilterList: TMenuItem;
    CustomInputBox: TCustomInputBox;
    mnuPreview: TMenuItem;
    mnuClearFilter: TMenuItem;
    lblcustomReport: TLabel;
    qryCustomReports: TERPQuery;
    qryCustomReportsID: TIntegerField;
    qryCustomReportsFilterName: TWideStringField;
    qryCustomReportsFilterStatement: TWideMemoField;
    cboCustomReports: TwwDBLookupCombo;
    FilterLabel: TLabel;
    qryCustomReportsDefaultFilter: TWideStringField;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryCurrencyConversion: TERPQuery;
    qryCurrencyConversionCurrencyID: TIntegerField;
    qryCurrencyConversionCountry: TWideStringField;
    qryCurrencyConversionCurrency: TWideStringField;
    qryCurrencyConversionCode: TWideStringField;
    qryCurrencyConversionBuyRate: TFloatField;
    qryCurrencyConversionSellRate: TFloatField;
    qryFConReport: TERPQuery;
    qryFConReportForeignCurrencyonReportID: TIntegerField;
    qryFConReportCurrencyID: TIntegerField;
    qryFConReportformID: TIntegerField;
    qryFConReportListName: TWideStringField;
    qryFConReportActive: TWideStringField;
    qryFConReportShowinthereport: TWideStringField;
    qryFConReportUserId: TIntegerField;
    qryFConReportmsTimeStamp: TDateTimeField;
    FConReport: TkbmMemTable;
    FConReportID: TIntegerField;
    FConReportCode: TWideStringField;
    FConReportRecno: TWideStringField;
    FConReportSymbol: TWideStringField;
    qryCurrencyConversionCurrencySymbol: TWideStringField;
    qryFConReportSymbol: TWideStringField;
    N11: TMenuItem;
    mnuAddCustomFilter: TMenuItem;
    barStatus: TAdvOfficeStatusBar;
    lblSearchMode: TLabel;
    TimerSearchLabel: TTimer;
    chkIgnoreDates: TCheckBox;
    fPaintTimer: TTimer;
    imgGridWatermark: TImage;
    EditCustomfilter1: TMenuItem;
    timerdateComments: TTimer;
    lblDateComments: TLabel;
    mnuHeader: TPopupMenu;
    rptsynchreporttables: TMenuItem;
    grdMain: TwwDbGrid;
    btnGrid: TwwIButton;
    mnuRefresh: TAdvPopupMenu;
    Refresh1: TMenuItem;
    SctMain: TERPScript;
    mnuChartList: TMenuItem;
    mnuNewChart: TMenuItem;
    mem_Note: TMemo;
    pnlGraph: TDNMPanel;
    grpView: TwwRadioGroup;
    mnuCharts: TAdvPopupMenu;
    pnlSearchbuttons: TDNMPanel;
    btnF7: TDNMSpeedButton;
    btnF6: TDNMSpeedButton;
    btnF5: TDNMSpeedButton;
    mnuHideSearchOptions: TAdvPopupMenu;
    Hide1: TMenuItem;
    btnEditCahrt: TDNMSpeedButton;
    mnuLogSQL: TMenuItem;
    mnuListclassname: TMenuItem;
    pnlIncludehistory: TDNMPanel;
    chkIncludehistory: TwwCheckBox;
    mnuDefaultOrder: TMenuItem;
    mnuDefaultOrderline: TMenuItem;
    lblcheck2: TLabel;
    lblCheck1: TLabel;
    LogGridfield1: TMenuItem;
    tmrtimedMsgOnshow: TTimer;
    mnuMakeTable: TMenuItem;
    lblTimerMsg: TLabel;
    chkShowEmailOptions: TCheckBox;
    imgReportTablesMsg: TImage;
    splMultiSelectList: TSplitter;
    pnlMultiSelectList: TDNMPanel;
    lblMultiSelectList: TLabel;
    chkhideMultiSelectSelectionList: TCheckBox;
    btnShowMultiSelectSelectionList: TDNMSpeedButton;
    btndec: TDNMSpeedButton;
    btninc: TDNMSpeedButton;
    procedure actMergeExecute(Sender: TObject);
    procedure actMergeUpdate(Sender: TObject); virtual;
    procedure actRefreshQryExecute(Sender: TObject);
    procedure actRefreshQryUpdate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure btnGridClick(Sender: TObject);
    procedure cboDateRangeCloseUp(Sender: TObject);
    procedure chkAdvancedPrintingClick(Sender: TObject);
    procedure CloseModalTimerTimer(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure DateChange(var message: TMessage); message SX_DatechangeMsg;
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchExit(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grdMainColEnter(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); virtual;
    procedure grpFiltersClick(Sender: TObject); virtual;
    procedure grdMainKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure pnlHeaderDblClick(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure RefreshTotalsMsg(var message: TMessage); message SX_RefreshTotalsMsg;
    procedure mnuChartViewClick(Sender: TObject);
    procedure mnuChartNewClick(Sender: TObject);
    procedure mnuChartListClick(Sender: TObject);
    procedure BeforeShowCustomChartList(Sender: TObject);
    Procedure doviewcustomchart(Sender: TwwDbGrid);
    procedure AddfieldFilter(Sender: TObject);
    function getPartialString(fField: TField; Filtertype: TFiltertype): string;
    procedure AddPartialfilter(Sender: TObject);
    procedure mnuStartSessionClick(Sender: TObject);
    procedure mnuEndSessionClick(Sender: TObject);
    procedure mnuPreviewClick(Sender: TObject);
    procedure mnuClearFilterClick(Sender: TObject);
    procedure cboCustomReportsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: boolean);
    procedure mnuFilterPopup(Sender: TObject);
    procedure actAddToFilterExecute(Sender: TObject);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure mnuAddCustomFilterClick(Sender: TObject);
    procedure mnuCustomFilterListClick(Sender: TObject);
    procedure TimerSearchLabelTimer(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure grdMainEnter(Sender: TObject);
    procedure grdMainBeforePaint(Sender: TObject);virtual;
    procedure fPaintTimerTimer(Sender: TObject);
    procedure grdMainKeyPress(Sender: TObject; var Key: char);
    procedure EditCustomfilter1Click(Sender: TObject);
    procedure timerdateCommentsTimer(Sender: TObject);
    procedure lblDateCommentsClick(Sender: TObject);
    procedure rptsynchreporttablesClick(Sender: TObject);
    procedure SctMainBeforeExecute(Sender: TObject; var SQL: string;var Omit: Boolean);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure dtToDropDown(Sender: TObject);
    procedure dtToExit(Sender: TObject);
    procedure dtFromExit(Sender: TObject);
    procedure grpViewClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure lblSearchoptionsDblClick(Sender: TObject);
    procedure btnF5Click(Sender: TObject);
    procedure btnF6Click(Sender: TObject);
    procedure btnF7Click(Sender: TObject);
    procedure pnlSearchbuttonsDblClick(Sender: TObject);
    procedure Hide1Click(Sender: TObject);
    procedure btnEditCahrtClick(Sender: TObject);
    procedure changeDates(Sender: TObject);
    procedure mnuLogSQLClick(Sender: TObject);
    procedure mnuListclassnameClick(Sender: TObject);
    procedure chkIncludehistoryClick(Sender: TObject);
    procedure mnuDefaultOrderClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure ShowParentComponentsclick(Sender: TObject);
    procedure LogGridfield1Click(Sender: TObject);
    procedure tmrtimedMsgOnshowTimer(Sender: TObject);
    procedure mnuMakeTableClick(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
    procedure chkShowEmailOptionsClick(Sender: TObject);
    procedure imgReportTablesMsgClick(Sender: TObject);
    procedure chkhideMultiSelectSelectionListClick(Sender: TObject);
    procedure btnShowMultiSelectSelectionListClick(Sender: TObject);
    procedure btnincClick(Sender: TObject);
    procedure btndecClick(Sender: TObject);
    procedure dlgPrintAfterOptionsLoaded(Sender: TObject; var ReportSettings: TpdtReportSettings);
  private
    { Private declarations }
    sShowParentComponents:String;
    fsFilterString: string;
    fsCustomFilterString: string;
    fsAppendFilter: string;
    fsSortColumnName: string;
    fbErrorOccurred: boolean;
    FFirstRun: boolean;
    StartTime, FinishedTime: TDateTime;
    fbUseSortinSearch: boolean;
    fbDisableSortoncolumtitleclick:Boolean;
    SQLStrList: TStringList;
    fbUseStringList: boolean;
    fbReportonForeignCurrency: boolean;
    fbshowFCFooters: boolean;
    fsTemplateFilter: string;
    //fsReportName: string;
    HIGHLIGHTLOCATE: TColor;
    fsSubsequentID: string;
    fbFromListSpeed: boolean;
    //fbNoDateRange: boolean;
    fsBaseIndexFieldNames: string;
    fsSecondaryIndexFieldNames: string;
    fbRequeryInProgress: boolean;
    fbSwapBaseIndexFieldPriority: boolean;
    fOnNewbtnClick: TNotifyEvent;
    fSearchMode: TBaseListingSearchMode;
    fCustomReportName: string;
    fExporting: boolean;
    fMainTable: TDataSet;
    fb_CloseOnRecSelect: boolean;
    fsWhereClause: string;
    fUseTmpTable: boolean;
    fCustomFilter: TCustomFilter;
    fShowChartViewOnPopup: boolean;
    CustomFilterForm: TfmSaveCustomFilter;
    fbIsGridcustomisable: boolean;
    fbCanCreatecustomReport: boolean;
    fActiveClasses: TkbmMemTable;
    bmBookmark: TBookmark;
    fOpenedByChart: boolean;
    fbShowGridonly: boolean;
    fbTimerLabelToggle: boolean;
    fTimerLabelStartTime: TDateTime;
    fNonSearchReport: boolean;
    fNonSearchMode: boolean;
    fbDashboardDetail: boolean;
    fsSearchWhenNotInlistfield:string;
    fbEnableClosingDateBalanceCheck: boolean;
    fUserLock: TUserLock;
    fInitListofSubform: TNotifyEvent;
    fsCustomChartToView: String;
    fListChartView :TListChartView;
    fsInitialfilter: String;
    fscharttolaunch: string;
    Graphform      : TListChartView;
    fsAddresstoEmail:String;
    fOnGidMultiselect :TOnGidMultiselect;
    fbShowbuttonsinPanel :Boolean;
    DBEventList: TObjectList;
    DoingOnGrdmainDblclick:Boolean;
    fbComboDataSelect: Boolean;
    fOnDataScroll: TDatasetEvent;
    fstimedMsgOnshow: String;
    pnltimedMsgOnshow: TDNMPanel;
    fbShowingWaterMark :Boolean;
    fiKeyIdtoLocate: Integer;
    fbistoDoAfterallSelected: Boolean;
    fOnRefreshQuery: TNotifyEvent;
    fOnRefreshTotals: TNotifyEvent;
    fsSelectrecordsValues: String;
    fsSelectrecordsfieldname: String;
    fOnListcose: TNotifyEvent;
    fGridGuiObj : TGridGuiObj;
    ffmBaseListtimerMsg : TfmBaseListtimerMsg;
    fbReportTablemsgshown:boolean;
    fDateRangetype: TDateRangetype;
    fbRemovedDateRangeHint : Boolean;
    fbclosingifListempty: Boolean;
    //fbHasAsondateRange: boolean;
    fSelectionOption: TSelectionOptions;
    fBaselistMultiSelectItems : TForm;
    fsKeyIdfieldname: String;
    fsKeyNamefieldname: String;
    fbResizeCompsforPanel:Boolean;
    fiParentWidth:Integer;
    fbHaveDateRangeSelection: boolean;
    fbhaveDateSelectionOptions: Boolean;
    fPassedConnection: TERPConnection;
    fbShowGridOnlyinPanel: Boolean;
    fbCheckedBaselistMultiSelectItems:Boolean;

    function getReportonForeignCurrency: boolean;
    procedure PrintDATSetID;
    procedure SetFilterString(const sValue: string);
//    procedure SetCustomReportName(const Value: string);
    procedure SetAppendFilter(const Value: string);
    procedure SetspecialNote(const Value: string);

    function getfilterType(Sender: TObject): TFiltertype;

    function getCustomFilter: TCustomFilter;
    procedure RefreshFCFields;
    function getFCsontheReport: string;
    function getActiveClasses: TkbmMemTable;
    function GetSubLevelIDs(const DeptName: string): string;
    procedure CreateTransPopupform;
    procedure SetShowGridOnly(const Value: boolean);

    procedure SetSearchfield(Sender: TObject);
    procedure HandleGridPaint(var Msg: TMessage); message TX_GridPaint;
    procedure SetSearchMode(const Value: TBaseListingSearchMode);
    procedure AddBasEindexfields(var Indexfields: String);
    procedure FocusGrid;
    Function OpenListIfsubform(Sender: TObject):Boolean;
    procedure OpenChart;
    procedure formhintoff;
    procedure formhintOn;
    function LockingTransTable:boolean;
    procedure ApplyInitialFilter;
    function ListShowingchart:Boolean;
    function Printchart: boolean;
    procedure Loadchartnames;
    function Radiogroupssame(grp1, grp2: TwwRadiogroup): Boolean;
    function getReportName: string;
    procedure setFormHintOnshow(const Value: String);
    procedure ResizeCompsforPanel;
    procedure ToggleSearchOptions;
    procedure formatSearchbuttons;

    { NOTE: The following 4 methods are a fix for the printDat component.
            printDat is removing the character that follows the ^ symbol
            eg in a job customer name.
            This code just inserts a single space after the ^ char.
            in the GetText event when printDat is printing.
    }
    procedure CapturedStringFieldGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure CaptureFieldGetTextEvents;
    procedure ReleaseFieldGetTextEvents;
    function EventRecFromList(aField: TField): TDBEventRec;
    Procedure Alignpagecontrols;
    procedure DoFormSize(ChangeSize:Boolean);
    function getAllClasses: Boolean;
    function getSelectedClassID: Integer;
    function getSelectedemployeeID: Integer;
    function getAllEmployees: Boolean;
    procedure setSelectionOptions(const Value: TSelectionOptions);
    procedure SetAllEmployees(const Value: Boolean);
    function getSelectedRecords: integer;
    function GuiPrefNode(const nodeName: String): TDataTreeNode;
    function GuiPrefIntValue(const nodeName: String; defaultValue:Integer = -1): Integer;
//    procedure ShowSearchModeWaterMark;
    procedure Check4futureDateRangeOptions;
    procedure ShowParentComponents(Sender: TObject);
    procedure SetHaveDateRangeSelection(const Value: boolean);
    //procedure SetHasAsondateRange(const Value: boolean);
    procedure SetDateRangeSelectionHint(const Value: String);
    Procedure ShowtimedMsgOnshow;
    //Procedure DoSelectionPopup;
    function getAllProducts: Boolean;
    function getSelectedProductID: Integer;
    procedure SetAllProducts(const Value: Boolean);
    procedure SetHaveOnlyToDate(TodateCaption: STring; const Value: Boolean);
    function getCancelPreviewAll: Boolean;
    function getShowPreview: Boolean;
    procedure SetCloseOnRecSelect(const Value: boolean);
    procedure Initcomponents;
    function GridGuiObj : TGridGuiObj;
    procedure setBaseIndexFieldNames(const Value: string);
    Function BaseListtimerMsgform : TfmBaseListtimerMsg ;
    function Exportdatafilename: String;
    Procedure RemoveDateRangeHint;
    procedure ShowReportTableMsgIcon;
    procedure InitReportTableMsgIcon;
    Function DoSelectionPopup:Boolean;
    function getIsMultiselecting: Boolean;
    Procedure BaselistMultiSelectItems ;
    procedure CheckBaselistMultiSelectItems;
    Function  DoRecSelect:Boolean;
    Function  ConfirmSelection:Boolean;
    procedure SetOnGridDataSelect(const Value: TOnGridDataSelect);
    function getIgnoreDateRange: Boolean;
    function cmpprocnotoStr(const ficmpProcess: TcmpProcessNo): string;
    function IsSubformParentShown: boolean;
    function IsSubformParentClosing: boolean;
    procedure SetHaveDateSelectionOptions(const Value: Boolean);
    function getRowSelect: Boolean;
    procedure SetRowSelect(const Value: Boolean);
    procedure SetPassedConnection(const Value: TERPConnection);
    procedure setSelectedClassID(const Value: Integer);
    procedure SetSelectedProductID(const Value: Integer);

    Procedure Recordstyle(AFont: TFont; ABrush: TBrush;
                          doBold: Boolean = False;
                          DoGreenhighlight :Boolean= False; (*dohide:Boolean = False ; *)
                          Doredhighlight :boolean = False;
                          DoGrayout:Boolean =False;
                          DoGrayoutCell:Boolean =False);
    procedure ChangeHeight(doinc: Boolean);
    function getSelectedID(const IDFieldname: String): Integer;
    function getSelectedData(const aFieldname: String): String;
    procedure initfloatfielddisplayformat(afield: TFloatfield);
    function AlternatingRowColor: Tcolor;
    function GetFirstRun: Boolean;

  protected
    dtFromLastDateTime: TDateTime;
    dtToLastDateTime: TDateTime;
    changingFromDate: boolean;
    changingToDate: boolean;
    FormShowCount: integer;
    fOnGridDataSelect: TOnGridDataSelect;
    fbNoRequery: boolean;
    fbEnableWebSearch: boolean;
    fbStartinWebSearchMode: boolean;
    fbFormOpenedOk: boolean;
    fsColumnOrderMode: string;
    ExtraTitleInfo: string;
    QueryManipulationObj: TQueryManipulationObj;
    FontColors: integer;
    StartColor: integer;
    fbNoRequeryBtn: boolean;
    // The default maximum grid column width, 0 = no change (ie width will not be changed)
    DefaultMaxGridColumnWidth: integer;
    DonotChangeGridLabels: boolean;
    GroupFilterString: string;
    GuiPrefs: TFormGuiPrefs;
    BusObjqueries: array of string;
    //PrintTemplate: TPrintTemplates;
    Ratetype: string;
    fFConReport: TForeignCurrencyonReport;
    FieldList: TStringList;
    CleanfieldList: TStringList;
//    AmountFields: array of string;
//    AmountCaptions: array of string;
    AmountFields,
    AmountCaptions: TStringDynArray;
    frmPopup: TBaseInputGUI;
    FooterCalcfields: TFooterCalcfieldsArray;
    IterateProcNo: integer;
    AutoSetColumnControlType: boolean;
    CleanFromDate, cleanTodate: TDateTime;
    usingReportTables: boolean;
    fOnAfterPopupFormShow: TAfterPopupFormShowEvent;
    BaseIndexfields:String;
    NoteCaption :String;
    Notecolor:TColor;
    Notevisible:Boolean;
    noteEnabled:Boolean;
    fbDisableDefaultGraphViewOption:Boolean;
    fbAllowdrilldownwhenModal:Boolean;
    AutoAlignButtonsinfooterPanel :boolean;
    fbhideIDFields:boolean;
    fbHideSitefields:Boolean;
    fbShowCancelPreviewBtninReportPreview:Boolean;
    fReportSQLobj :TReportSQLBase;
    fblistTobeRefreshed:Boolean;
    fbSaveListSortOrder:Boolean;
    ClassLookupform :TFmClassLookup;
    EmployeeLookupform : TFmEmployeeLookup;
    ProductLookupform : TFmProductLookup;
    fbHasfutureDateRangeOptions:Boolean;
    fbRemeberIgnoreDateSelection :boolean;
    sizeMode:string;
    fsExportedSQL :String;
    fbExportingall:Boolean;
    fiEmailMsgOption:Integer;
    Json: TJsonObject;
    fbSelectioninPopup:Boolean;
    fbForceWaterMark:Boolean;
    iTotalHeaderComponentWidth:Integer;
    iLeft, iGap:Integer;
    fiParentPanelWidth :Integer;
    Searching :Boolean;
    sSQL: string;
    fbReportSQLSupplied: boolean;
    fbCentralisePanelbuttons :boolean;
    fbShowcustomiseonMenu :Boolean;

    procedure SetCustomReportName(const Value: string);virtual;
    procedure Setcharttolaunch(const Value: string); virtual;
    function getFilterDateFrom: TDateTime; virtual;
    function getReportDateFrom: String ; virtual;
    function getFilterdateto: TDateTime; virtual;
    procedure PreviewFilteredReport;
    procedure ApplySpecialformfilter; virtual;
    function GetReportTypeID: integer; virtual;
    { This method should be overwritten in descendants to set the correct Report Type ID }
    function TemplateNameToTemplateClassName(const TemplateName: string): string;
    procedure HandleEAbortException;
    procedure HandleNoAccessException(const e: Exception);
    procedure LoadReportTypes(reportTypeID:Integer =0;LoadReportTypesconditions:String='');Override;
    Function LoadReportTypesconditions:String;Virtual;
    procedure LoadTemplate(const bPrint, bSave: boolean; ShowCancelPreviewBtninReportPreview :Boolean = False;doemailreport:Boolean =False;
      SilentEmail : boolean = false;  SecretEmail : boolean=false);  //virtual;
    procedure PopulateFilterCombo; virtual;
    Function FieldCanBeSearched(const FieldName:String):Boolean;virtual;
    procedure RefreshQuery; virtual;
    procedure RefreshTotals; virtual;
    procedure RemoveInvalidFilterComboItems(const InvalidItems: TStringList);
    procedure SetClassLabels;
    procedure SetConnectionString; virtual;
    property SubsequentID: string read fsSubsequentID write fsSubsequentID;
    //property ReportToPrint: string read fsReportName write fsReportName;
    property ReportName: string read getReportName;
    property TemplateFilter: string read fsTemplateFilter write fsTemplateFilter;
    property UseStringListForSQL: boolean read fbUseStringList write fbUseStringList;
    property StringListForSQL: TStringList read SQLStrList write SQLStrList;
    property TemplateSQL: string read sSQL write sSQL;
    property UseSortinSearch: boolean read fbUseSortinSearch write fbUseSortinSearch;
    Property DisableSortoncolumtitleclick :Boolean read fbDisableSortoncolumtitleclick write fbDisableSortoncolumtitleclick;
    property SwapBaseIndexFieldPriority: boolean read fbSwapBaseIndexFieldPriority write fbSwapBaseIndexFieldPriority default false;
    property BaseIndexFieldNames: string read fsBaseIndexFieldNames write setBaseIndexFieldNames;
    property SecondaryIndexFieldNames: string read fsSecondaryIndexFieldNames write fsSecondaryIndexFieldNames;
    property AppendFilter: string read fsAppendFilter write SetAppendFilter;
    property ColumnOrderMode: string read fsColumnOrderMode write fsColumnOrderMode;
    property SortColumnName: string read fsSortColumnName write fsSortColumnName;
    procedure IterateList(CallbackProc: TDatasetIterateCallbackProc);
    procedure ApplyQueryFilter; virtual;
    function getreportId(const FormId: string): string;
    procedure PopulateReportTable; virtual;
    procedure Loadmemtable;
    Procedure onLoadmemtable;Virtual;
    procedure AddGridSelectedfield(fsfieldName: string; const fidisplaywidth: integer; const fsDisplayLabel: string; const fsGroupName: string = ''; ds:TDataset=nil);
    procedure initFCFields; virtual;
    procedure DeleteTable(const tablename: string);
    procedure AssignKeyId(Popupform: TBaseInputGUI); virtual;
    Procedure DoPopupKeyIdNotFoundMsg; virtual;
    procedure BeforePopup(Popupform:TComponent);virtual;
    procedure AfterPopup(Popupform:TComponent);virtual;
    procedure CalcnShowFooter; virtual;
    procedure CalcFooter; virtual;
    procedure AddCalcColumn(const fFieldName: string; fIsCurrency: boolean; CalcType: TFooterCalcType = fctSum);
    procedure RemoveFieldfromGrid(const fsfieldName: string);
    procedure RemoveFieldsfromGrid(const fsFieldList: string);
    procedure AddFieldtoGrid(const fsfieldName: string; fieldIndex:Integer=-1);
    procedure AddFieldstoGrid(const fsfieldList: string; fieldIndex:Integer=-1);
    procedure SetUpcustomFields(const CustomField: string; fieldPrefix:String ='');Overload;virtual;
    procedure OnSetUpcustomFields(CustfieldVisible:Boolean;fieldno :Integer;  FlagFieldname , fieldname, DisplayLabel:String );virtual;
    procedure SetUpcustomFields(const CustomFields: string;cListType: TListtype);Overload;
    procedure setDashboardDetail(const Value: boolean); virtual;
    procedure closeDB(ds: TDataSet);
    procedure OpenDB(ds: TDataSet);
    function SelectedIDs(IDFieldname: string; var St: TStringList; ignoreduplicates: boolean = false; DoCheckrec:TBoolFunc=nil): string; overload;
    procedure IterateselectedRecords(UseProgressbar: boolean = false; Progressbarcaption: string = ''); virtual;
    procedure IterateRecords(UseProgressbar: boolean = false; Progressbarcaption: string = ''); virtual;
    procedure IterateselectedRecordsReverse(UseProgressbar: boolean = false; Progressbarcaption: string = ''); virtual;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); virtual;
    procedure HideProgressbar;Virtual;
    procedure showProgressbar(Progressbarcaption: string; Progresscount: integer = 0; AllowCancel:Boolean = True; aOnScriptExecuteProgressCancel:TNotifyEvent = nil);Virtual;
    procedure stepProgressbar(Const ProgressbarMsg :String = '');Virtual;
    Procedure ProgressValueReset(const Value:Integer);
    procedure IterateProc(UseProgressbar: boolean; var Abort: boolean; i: integer);
    procedure SetGridColumns; virtual;
    procedure DoShowLookuplist; virtual;
    function ActiveField: TField;
    function ActiveFieldNAme: string;
    procedure RefreshDatecomments;
    procedure StorecleanDate(FromTo: string);
    function DoDtFromChange(Sender: TObject): boolean; virtual;
    function DoDtToChange(Sender: TObject): boolean; virtual;
    procedure RefreshAll; virtual;
    procedure ReadnApplyGuiPrefExtra; virtual;
    Procedure WriteGuiPrefExtra; virtual;
    procedure AfterFormShow; override;
    function TablestoSync: string; virtual;
    procedure DoTablestoSync;
    function ChangeQuery(Query: string): string;
    procedure SetIndicatorbutton;
    procedure CloseList;
    procedure AdjustDisplayLabels; Overload;Virtual;
    procedure AdjustDisplayLabels(tmpField :TField; Var s:String);Overload;Virtual;
    function DoingFormShow: boolean;
    Procedure DoQrymainafteropen;Virtual;
    function UserLock: TUserLock;Virtual;
    Procedure BeforeShowOpenList(sender:TObject);virtual;
    Procedure ExecuteSQLwithProgress(fsSQL:String;AllowCancel:Boolean=False);
    Procedure ExecutewithProgress(AllowCancel:Boolean=False);
    function Iscolvisible(const fieldname:String):Boolean;
    procedure SetupFormInPanel; virtual;
    procedure Resetinpanel;virtual;

    procedure readGridfooterValue(columnname: String; Value: Double);virtual;
    procedure readGridfooterValues; virtual;
    Function FooterValue(const Fieldname :STring):Double;
    Procedure DoAfterallSelected;virtual;
    function isvalidtoSelect:Boolean;virtual;
    function LockTransTable(LockMsg:String):boolean;virtual;
    Procedure UnlockTransTable;virtual;
    Procedure DoExtraTranslation;Override;
    procedure ApplyDisplayLabelFrompreference;virtual;
    function FooterCalcfieldValue(const fieldName: String): Double;virtual;
    function Fieldgroupname(const fsfieldname: String): String;
    procedure ExtraSetupFormInPanel;Virtual;
    procedure RefreshGraph;overload;Virtual;
    procedure RefreshGraph(Sender:TObject);overload;Virtual;
    Procedure CopyParamsto(Sender:TObject);Virtual;
    function IncludedataPriorToClosingDate: Boolean;
    function Emailreport(Emailsubject , Emailbody, RecipientAddress, reportType :String; sSQL:String;fsReportName:String; reportfilename:String;
      SilentEmail : boolean = false; SecretEmail : boolean = false) :boolean;
    procedure CopyfilterParams(Sender: TObject);virtual;
    Function SQLWithCustomfilterApplied:String;
    procedure GetFieldValueList(const aFieldName: string; aList: TStringList; aIdFieldName: string = '');
    function DoEmailIfToBeEmailed: boolean; virtual;
    procedure HideHeaderwhenFormInPanel;
    function ReportSQLobj :TReportSQLBase;virtual;
    procedure InitDateFromnDateto(ParamDtfrom:String = 'DateFrom';ParamDtTo:String = 'DateTo');Virtual;
    procedure setInitSearchValue(const Value: String);virtual;
    Procedure InitformForSearchValue(Const Value:String);virtual;
    Function ExtraCompsforPanel:Integer; virtual;
    Function ExtraCompsforPanelWidths :Integer; virtual;
    //Procedure SetExtraCompsforPanelWidths(var ileft :Integer; var igap:Integer);virtual;
    function isTochooseTemplate:Boolean;
    Procedure InitGroupfilterString(filterfieldname :String; filterValues :Array of String; IsNumberFilter:Boolean =False; grp : TwwRadioGroup = nil );
    procedure AddAmountField(const aFieldName: string);
    procedure RemoveAmountField(const aFieldName: string);
    procedure MakeTemplateSQL;virtual;
    procedure SetDefaultDateRange; virtual;
    procedure OnClassSelection(Sender:TObject);virtual;
    procedure OnEmployeeSelection(Sender:TObject);virtual;
    procedure OnProductSelection(Sender:TObject);virtual;

    function DefaultAllClasses: Integer;virtual;
    function DefaultAllProducts: Integer;virtual;
    function DefaultAllEmployees: Integer;virtual;

    function DEfaultSelectedClassID: Integer;virtual;
    function DEfaultSelectedProductId: Integer;virtual;
    function DEfaultSelectedEmployeeID: Integer;virtual;

    procedure InitIncludehistory;virtual;
    procedure SetDefaultColor;Override;
    Function GridCurrentColumnIndex(const X, Y: Integer):Integer;
    function ISGrpfiltersfocussed:Boolean;
    function GetReportTypeIDForTypeName(const TypeName: string): integer;
    function getKeyIdfieldname:String;virtual;
    function getKeyNamefieldname:String;virtual;
    Function Email_subject :String;Virtual;
    Function Email_body :String;Virtual;
    Function ExporttoSQL(Const Typename:String; var filename:String):Boolean ;
    Procedure BignBold(Afont:TFont);
    Procedure RednBold(Afont:TFont);
    Procedure RedFont(Afont:TFont);
    Procedure BlueFont(Afont:TFont);
    procedure GreennLight(Afont: TFont);
    procedure GreennFont(Afont: TFont);
    Procedure LoadFooterValues(amountTotals: array of Double);Virtual;
    procedure OnScriptExecuteProgressCancel(Sender: TObject);Virtual;
    Procedure initPopupmenu;Virtual;
    Procedure doBold(AFont: TFont; ABrush: TBrush);
    Procedure DoGreenhighlight(AFont: TFont; ABrush: TBrush);
    Procedure DoHide(Field: TField;State: TGridDrawState; AFont: TFont; ABrush: TBrush);
    Procedure Doredhighlight(AFont: TFont; ABrush: TBrush);
    Procedure DohighlightCell(AFont: TFont; ABrush: TBrush);
    Procedure DoGrayout(AFont: TFont; ABrush: TBrush);
    Procedure DoGrayoutCell(AFont: TFont; ABrush: TBrush);
    Procedure DoHighlightColumn(Acolor :TColor;Afont:TFont; ABrush: TBrush);

    Procedure DoBeforeExport;Virtual;
    Procedure DoGridExport;
    Procedure DoAfterExport(const Exportfilename:String);Virtual;
    procedure DoExportdata(const Exportfilename:String);Virtual;
    procedure InitWwRadioGroup(Sender : TwwRadioGroup); virtual;
    Function IsLimit0selection:Boolean;
    Procedure DoOnDoNotAskMsgCheck(Sender: TObject; Checked: boolean);Virtual;
    Function DoNotAskMsg :boolean;Virtual;
    Procedure initchkShowEmailOptions;Virtual;
    function GetReportNameForTypeName(const TypeName: string): string;
    Procedure AddGuiPrefElements;Virtual;
    Procedure SelectionOptionQry(Lookupform:TfmBaselistingSelectionLookup; cboQry:TERPQuery);Virtual;
    function ChangeDisplayLabel(str, oldLabel, newLabel: string): string;
    function ReportJson: TJsonObject;Virtual;
    Procedure FreeReportJson; Virtual;
    procedure ShowSearchModeWaterMark;
    function ReportTableUpdatedtime(lineBreak:Boolean =False): String; Virtual;
    Procedure inPanelcomponents(const ficmpProcess :TcmpProcessNo);Virtual;
    procedure SetForeignFieldDisplayFormat(Amtfieldname,CurCodefieldName: String);Virtual;
    procedure Alignbuttons; Overload;Virtual;
    procedure Alignbuttons(pnl :TDnmpanel; Docentre :Boolean = False);Overload;
    Procedure InitFooterPanelButtons;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    Procedure SetSelectionOptionsFor(Value:TSelectionOptions);virtual;
    Function ListShortName:String;
    procedure initqrymainsql; virtual;
    procedure DocopyData(Sender: TObject);
    procedure HideZeroValueInNumberfield(State: TGridDrawState; Field: TField; AFont: TFont; ABrush: TBrush;Dofloat :boolean =true; DoInteger :boolean =true; DoDates :boolean =true);
    Procedure initList;virtual;
    function footerbuttonLeftMargin: Integer;virtual;
    function footerbuttonRightMargin: Integer;virtual;
    procedure ResizesubformGrid;
    Function NewTempTableName(const prefix:String):String;
    procedure OnRefreshQueryOutOfMemoryError(Sender: TObject);Virtual;
    procedure ShowStatus(const Value: String);Virtual;
    procedure HideStatus;
    Function QrymainBookmark(dodisablecontrol :Boolean = False):TBookmark;
    procedure QrymaingotoBookmarknFree(bm:TBookmark; DoEnablecontrol :Boolean = False);
    Procedure DisableAlternatingRowcolor;
    procedure ReadGrpfiltersPrefs;Virtual;
    Function SearchModeToStr(const Value: TBaseListingSearchMode):String;
  public
    { Public declarations }
    fbIncludehistory :Boolean;
    fiGuiID: integer;
    fbDateRangeSupplied: boolean;
    fbIgnoreQuerySpeed: boolean;
    //FilterOptionSupplied:Boolean;
    GrpfilterSupplied :boolean;
    DisablePopupmenuinPanel:Boolean;

    // These were moved from private area to the public area.
    ToPrevDate: TDateTime;
    FromPrevDate: TDateTime;
    ListManRunOnce: boolean;

    function ScriptMain :TERPScript;
    function ScriptMainInTrans :TERPScript;
    Function ScriptMainCommit:Boolean;
    Function ExecutenCommit:Boolean;
    Function ScriptMainrollback:Boolean;
    Function ScriptMainBeginTrans:Boolean;
    Procedure ScrptMainCleanConn;
    function IsSubform: boolean;
    constructor Create(AOwner: TComponent); override;
    procedure GoSearch; virtual;
    procedure EnableMultiSelect(const MultiSelectNote: string);
    function isPrefSettingsForm(var forCompany: boolean): boolean; virtual;
    procedure UpdateMe; virtual;
    property FilterString: string read fsFilterString write SetFilterString;
    Property InitialFilter:String read fsInitialFilter Write fsInitialFilter ;
    property CustomFilterString: string read fsCustomFilterString write fsCustomFilterString;
    property FromListSpeed: boolean read fbFromListSpeed write fbFromListSpeed;
    property IgnoreQuerySpeed: boolean read fbIgnoreQuerySpeed write fbIgnoreQuerySpeed;
    //property NoDateRange: boolean read fbNoDateRange write fbNoDateRange;
    property ErrorOccurred: boolean read fbErrorOccurred write fbErrorOccurred default false;
    property OnNewbtnClick: TNotifyEvent read fOnNewbtnClick write fOnNewbtnClick;
    property EnableWebSearch: boolean read fbEnableWebSearch;
    property CustomReportName: string read fCustomReportName write SetCustomReportName;
    property Exporting: boolean read fExporting;
    property MainTable: TDataSet read fMainTable write fMainTable;
    property CloseOnRecSelect: boolean read fb_CloseOnRecSelect write SetCloseOnRecSelect;
    property WhereClause: string read fsWhereClause write fsWhereClause;
    property UseTmpTable: boolean read fUseTmpTable write fUseTmpTable;
    property SpecialNote: string write SetspecialNote;
    property Customfilter: TCustomFilter read getCustomFilter write fCustomFilter;
    property IsGridcustomisable: boolean read fbIsGridcustomisable write fbIsGridcustomisable;
    property CanCreatecustomReport: boolean read fbCanCreatecustomReport write fbCanCreatecustomReport;
    property ReportonForeignCurrency: boolean read getReportonForeignCurrency write fbReportonForeignCurrency;
    property showFCFooters: boolean read fbshowFCFooters write fbshowFCFooters;
    property ActiveClasses: TkbmMemTable read getActiveClasses;
    property OpenedByChart: boolean read fOpenedByChart write fOpenedByChart;
    property showGridOnly: boolean read fbShowGridonly write SetShowGridOnly;
    property FilterDateTo: TDateTime read getFilterdateto;
    property FilterDateFrom: TDateTime read getFilterDateFrom;
    Property IgnoreDateRange:Boolean read getIgnoreDateRange;
    Property ReportDateFrom :String read getReportDateFrom;
    property DashboardDetail: boolean read fbDashboardDetail write setDashboardDetail;
    Property SearchWhenNotInlistfield :String read fsSearchWhenNotInlistfield write fsSearchWhenNotInlistfield;
    Property OnDataScroll : TDatasetEvent read fOnDataScroll write fOnDataScroll;
    procedure RefreshfilterLabel;
    class procedure ShowLookuplist(onrecordSelect: TOnGridDataSelect);
    procedure ProcessSearch(const fieldname, Value: string);
    procedure RefreshOrignalSQL(Addlimit0:Boolean =true);Virtual;
    function QrymainSQL: string;
    property EnableClosingDateBalanceCheck: boolean read fbEnableClosingDateBalanceCheck write fbEnableClosingDateBalanceCheck;
    property OnAfterPopupFormShow: TAfterPopupFormShowEvent read fOnAfterPopupFormShow write fOnAfterPopupFormShow;
    function SelectedDatas(Fieldname: string; ignoreduplicates: boolean = false;REsultDelim :char =','): string; overload;
    function SelectedDatas(Fieldname: string; var St: TStringList; ignoreduplicates: boolean = false): string;overload;
    procedure PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject = nil; fsPrintename: String = ''; ShowCancelPreviewBtninReportPreview: boolean = false); overload;Override;
    //procedure PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject = nil;ShowCancelPreviewBtninReportPreview :Boolean = False); overload;
    procedure PrintTemplateReport(const ReportName, SQLPortion: string; const SQLStringList: TStringList; const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject = nil; ShowCancelPreviewBtninReportPreview :Boolean = False); overload;

    property ReportSQLSupplied: boolean read fbReportSQLSupplied write fbReportSQLSupplied;
    Procedure GrdmainForPanel(parentPanel: TDNMPanel;beforeShow: TNotifyEvent = nil);
    Procedure ChangeNote(Note: String; notecolor: Tcolor = clred; noteSize:Integer =9);
    Property InitListofSubform :TNotifyEvent  read fInitListofSubform write fInitListofSubform;
    Property CustomChartToView:String read fsCustomChartToView write fsCustomChartToView;
    Procedure DoRefreshQuery; virtual;
    function ListDescription:String;Virtual;
    Property ListChartView :TListChartView read fListChartView;
    procedure SetOnsameLineOneafterOther(first, second: TControl; Spaces:Integer=2);
    Procedure Repositionheaderwithinpanel;
    function IDs(const IDFieldname: string; ignoreduplicates: boolean = false): string;
    function SelectedIDs(IDFieldname: string; ignoreduplicates: boolean = false): string; overload;
    Property charttolaunch:string read fscharttolaunch write Setcharttolaunch;
    procedure showGraph;virtual;
    procedure AddfilterString(const Value :String);
    function Fieldtotal(Const fieldName:String):double ;
//    Property AddresstoEmail:String read fsAddresstoEmail write fsAddresstoEmail;
    Property OnGidMultiselect :TOnGidMultiselect Read fOnGidMultiselect write fOnGidMultiselect;
    Property ShowbuttonsinPanel :Boolean read fbShowbuttonsinPanel write fbShowbuttonsinPanel;
    procedure Refreshdates;
    Property SelectionOption : TSelectionOptions read fSelectionOption Write setSelectionOptions;

    Property SelectedClassID:Integer read getSelectedClassID write setSelectedClassID;
    Property AllClasses : Boolean read getAllClasses;

    Property SelectedEmployeeID:Integer read getSelectedEmployeeID;
    Property AllEmployees : Boolean read getAllEmployees Write SetAllEmployees;

    Property SelectedProductID:Integer read getSelectedProductID Write SetSelectedProductID;
    Property AllProducts : Boolean read getAllProducts Write SetAllProducts;

    Property SelectedRecords :integer read getSelectedRecords;
    Procedure ListforToday;virtual;
    Procedure ListforAday(const Value:TDateTime);Virtual;
    Procedure ListTimerMsg(const MSg:String; abtntohighLight:TDnmSpeedbutton = nil;Secondstoshow: Integer=5);
    Procedure ListMsg(const MSg:String);
    Property HaveDateRangeSelection:boolean read fbHaveDateRangeSelection write SetHaveDateRangeSelection;
    Property HaveDateSelectionOptions :Boolean read fbhaveDateSelectionOptions write SetHaveDateSelectionOptions;
    //Property HasAsondateRange:boolean read fbHasAsondateRange write SetHasAsondateRange;
    Property HaveOnlyToDate[TodateCaption :STring] :Boolean Write SetHaveOnlyToDate;
    Property DateRangeSelectionHint :String Write SetDateRangeSelectionHint;
    procedure AddDateRangeSelectionHint(const Value:String);
    Function IsSelected(IDFieldNAme:String; SelectedIDList:TIntegerList):Boolean;Virtual;
    Property timedMsgOnshow : String read fstimedMsgOnshow write fstimedMsgOnshow;
    procedure ShowWaterMark(Img: TImage);
    Class Procedure MakeaList(AOwner:TComponent;Const SQL:String; AllowMultiSelect :Boolean; TitleCaption:String; SelectedText:String =''; BeforeShow:TNotifyEvent=nil;AfterShow:TNotifyEvent=nil;OnSelect:TOnGridDataSelect=Nil;IsModel:Boolean =False; aConnection:TERPConnection = nil);
    Property KeyIdtoLocate :Integer read fiKeyIdtoLocate write fiKeyIdtoLocate;
    Property istoDoAfterallSelected :Boolean read fbistoDoAfterallSelected write fbistoDoAfterallSelected;
    Procedure selectall; virtual;
    function DoOnGridDataSelect(Sender: TObject): boolean;
    Property OnRefreshQuery :TNotifyEvent  read fOnRefreshQuery write fOnRefreshQuery;
    Property OnRefreshTotals :TNotifyEvent  read fOnRefreshTotals write fOnRefreshTotals;
    function Locate(const KeyFields: string; const KeyValues: variant;Options: TLocateOptions): boolean; virtual;
    Property CancelPreviewAll :Boolean read getCancelPreviewAll;
    Property ShowPreview :Boolean read getShowPreview;
    Function SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport'; MasterDetailLink: TJsonObject = nil):Boolean;Override;
    Procedure Selectrecords; Virtual;
    Property Selectrecordsfieldname :String read fsSelectrecordsfieldname write fsSelectrecordsfieldname;
    Property SelectrecordsValues :String read fsSelectrecordsValues write fsSelectrecordsValues;
    property OnListcose :TNotifyEvent read fOnListcose write fOnListcose;
    Function IdfieldFor(Const IDfieldForClassname:String) : TField;Virtual;
    Procedure GridinLargefont;
    procedure showReportTableMsg;
    Property DateRangetype :TDateRangetype read fDateRangetype write fDateRangetype;
    Property closingifListempty :Boolean read fbclosingifListempty write fbclosingifListempty;
    Procedure ChangeSelectionPanel(Const PArentPanel:TPanel; aAlign :TAlign = alnone);
    function Listcaption: String;
    Property IsMultiselecting:Boolean read getIsMultiselecting;
    function SelectedDateRangeMsg:String;
    Property RowSelect:Boolean read getRowSelect write SetRowSelect; // Note that with this property the filtering shortcuts will not work properly as there is no active field
    function ReadControlDisplayName(Sender:TObject):String;Override;
    Property PassedConnection : TERPConnection read fPassedConnection  write SetPassedConnection ;
    function RadioGroupItemindex(Searchfor :String; rgp :TwwRadioGroup=nil):Integer;
    Property ShowGridOnlyinPanel:Boolean read fbShowGridOnlyinPanel write fbShowGridOnlyinPanel;
    Function Listconnection:TERPConnection; virtual;
    Property SelectedID[Const IDFieldname:String]:Integer read getSelectedID;
    Property SelectedData[Const aFieldname:String]:String read getSelectedData;
    function SelectedIDs(IDFieldname: string; var St: TIntegerList; ignoreduplicates: boolean = false; DoCheckrec:TBoolFunc=nil): string; overload;
    property FirstRun: Boolean read GetFirstRun;

  published
    property SearchMode: TBaseListingSearchMode read fSearchMode write SetSearchMode;
    property ShowChartViewOnPopup: boolean read fShowChartViewOnPopup write fShowChartViewOnPopup;
    property OnGridDataSelect: TOnGridDataSelect read fOnGridDataSelect write SetOnGridDataSelect;
    Property FormHintOnshow :String Write setFormHintOnshow;
    Property KeyIdfieldname :String read getKeyIdfieldname write fsKeyIdfieldname;
    Property KeyNamefieldname :String read getKeyNamefieldname write fsKeyNamefieldname;

    { set these properties on formcreate of the descendant if setting to true }
    property NonSearchReport: boolean read fNonSearchReport write fNonSearchReport;
    property NonSearchMode: boolean read fNonSearchMode write fNonSearchMode;
    Property InitSearchValue :String  write setInitSearchValue;
    Property AddresstoEmail:String read fsAddresstoEmail write fsAddresstoEmail;
    Property ComboDataSelect :Boolean read fbComboDataSelect write fbComboDataSelect;
    { just f5 }
  end;

  TDBEventRec = class(TObject)
  public
    Field: TField;
    Code, Data: Pointer;
  end;


implementation

{$R *.dfm}

uses CommonDbLib, FormFactory, StrUtils, DateUtils, DNMExceptions, PDATGbl0, PDATGbl, DNMLib,
  ListSpeedHintGUI, GlobalEventsObj, AppContextObj, FastFuncs, GraphUtil,
  AppEnvironment, DNMAccessManager, tcConst, CustomFilterList, BusObjSaleBase,
  busobjOrders, LogUtils, ShlObj, SystemLib, SyncReportTableObj, GridFieldsObj,
  CommonFormLib, CustomChartList, tcClasses, frmMessage , idglobal,
  frmMessageBase, CustomfieldonGrid, tcDataUtils, StringUtils, EmailUtils,
  MySQLConst,  BaseListExpress, BaseListDetails ,sndkey32, LogLib, frmListdates,
  ShellAPI, MAIN, CorrespondenceObj, ERPErrorEmailUtils, DbSharedObjectsObj,
  UserCustomisedNames, Clipbrd, AppDatabase , Vista_MessageDlg, FilesLib,
  ButtonsLib, frmBaselistingSelectionPopup, GridLib ,BaselistMultiSelectItems,
  ERPVersionConst, BaseListUtilsObj, frmBase, frmBaseListDateSelectionOptions,
  BusObjCurrency, BusObjConst, timelib , WwPaintOptions, tcTypes;

const
  STATUS_MSG = 'Auto List Updates Disabled';
  //GRID_FONT = 'GridFont';
  //GRID_FONT_SIZE = 'GridFontSize';
  //GRID_FONT_COLOR = 'GridFontColor';
  //TITLE_FONT = 'TitleFont';
  //TITLE_FONT_SIZE = 'TitleFontSize';
  //TITLE_FONT_COLOR = 'TitleFontColor';
  HIGHLIGHTLOCATEDEF = $00FFC891; // a very light Blue

  CAP_SEARCH_NON_SEARCH = '"F5" (Full)';
  CAP_SEARCH_F5 = '"F5,F6,F7" (Full)';
  CAP_SEARCH_F6 = '"F5,F6,F7" (Starts with)';
  CAP_SEARCH_F7 = '"F5,F6,F7" (Like)';

  CAP_SEARCH_NON_SEARCH_SHORT = '"F5" (Full)';
  CAP_SEARCH_F5_SHORT = '"F5,F6,F7" (Full)';
  CAP_SEARCH_F6_SHORT = '"F5,F6,F7" (S/W)';
  CAP_SEARCH_F7_SHORT = '"F5,F6,F7" (Like)';
  LONGDATERANGEHINT = 'Report is Flagged to have Long Date Range by Default';
  SHORTDATERANGEHINT = 'Report is Flagged to have Short Date Range by Default';
  SelectCaptiononMultiSelect = 'S&elect';


var
  activeRecord: integer;
  bDontFireExitEvent: boolean;
  bFormStarting: boolean;

procedure TBaseListingGUI.CopyParamsto(Sender: TObject);
begin
  if not(Sender is TBaseListingGUI) then exit;

  if (sender is TBaseListExpressGUI) or (Sender is TBaseListDetailsGUI) or (Sender is TBaseListingGUI) then begin
    TBaseListingGUI(sender).OnGridDataSelect  := self.OnGridDataSelect ;
    TBaseListingGUI(sender).filterString      := self.filterString;
  end;
  if TBaseListingGUI(sender).dtFrom.Visible and TBaseListingGUI(sender).dtTo.visible  then begin
    TBaseListingGUI(sender).dtFrom.Date       := 0;
    TBaseListingGUI(sender).dtTo.Date         := self.dtTo.Date;
    TBaseListingGUI(sender).dtFrom.Date       := self.dtFrom.Date;
    TBaseListingGUI(sender).chkIgnoreDates.Checked := chkIgnoreDates.Checked;
    TBaseListingGUI(sender).fbDateRangeSupplied    := True;
  end;
  if (sender is TBaseListExpressGUI) or (Sender is TBaseListDetailsGUI) or (Sender is TBaseListingGUI) then begin
    if TBaseListingGUI(sender).grpfilters.visible then
      if Radiogroupssame(TBaseListingGUI(sender).grpfilters,self.grpfilters) then begin
        TBaseListingGUI(sender).grpfilters.itemindex := self.grpfilters.Itemindex;
        TBaseListingGUI(sender).grpfilters.visible := self.grpfilters.visible;
      end;
  end;
end;
function TBaseListingGUI.RadioGroupItemindex(Searchfor: String;  rgp: TwwRadioGroup=nil): Integer;
var
  ctr:Integer;
begin
  result := -1;
  if rgp = nil then rgp := grpfilters;
  if rgp.items.count =0 then exit;
  for ctr := 0 to rgp.items.count-1 do begin
    if sametext(rgp.items[ctr] , Searchfor) then begin
      Result := ctr;
      exit;
    end;
  end;

  for ctr := 0 to rgp.items.count-1 do begin
    if sametext(replacestr(rgp.items[ctr], '&' , '') , Searchfor) then begin
      Result := ctr;
      exit;
    end;
  end;
end;

Function TBaseListingGUI.Radiogroupssame(grp1, grp2:TwwRadiogroup):Boolean;
var
  ctr:Integer;
begin
  result:= False;
  if grp1.items.count <> grp2.items.count then exit;
  for ctr := 0 to grp1.items.count-1 do begin
    if not(sametext(trim(grp1.items[ctr]) , trim(grp2.items[ctr]))) then exit;
  end;
  result:= True;
end;

constructor TBaseListingGUI.Create(AOwner: TComponent);
begin
  { descendants will reintialise in 'formcreate' (before inherited) if its different }
  fbShowingWaterMark := False;
  IsGridcustomisable := True;
  CanCreatecustomReport := True;
  ReportonForeignCurrency := false;
  showFCFooters := false;
  fbEnableWebSearch := false; { by default }
  //FilterOptionSupplied:= False;
  fsInitialfilter:= '';
  fbIncludehistory := False;
  AutoAlignButtonsinfooterPanel := True;
  fReportSQLobj := nil;
  fbHasfutureDateRangeOptions := False;
  fbRemeberIgnoreDateSelection := false;
  fbHaveDateRangeSelection := True;
  //fbHasAsondateRange := False;
  fbSelectioninPopup := False;
  fbForceWaterMark := False;
  fbCentralisePanelbuttons := true;
  inherited;
  fPassedConnection := nil;

end;

function TBaseListingGUI.getCancelPreviewAll: Boolean;
begin
  result := PrintTemplate.CancelPreviewAll;
end;

function TBaseListingGUI.getCustomFilter: TCustomFilter;
begin
  if not Assigned(CustomFilterForm) then begin
    CustomFilterForm := TfmSaveCustomFilter(GetComponentByClassName('TfmSaveCustomFilter', True, Self, True, True, AppEnv.AccessLevels.GetFormID(Self.ClassName)));
    CustomFilterForm.Tag := AppEnv.AccessLevels.GetFormID(Self.ClassName);
    // Instance Per List
    fCustomFilter := CustomFilterForm.Customfilter;
    fCustomFilter.Load(0);
    fCustomFilter.ReportList := Self;
  end;
  Result := fCustomFilter;
end;

procedure TBaseListingGUI.AdjustDisplayLabels(tmpField :TField; Var s:String);
begin

end;
Procedure TBaseListingGUI.initfloatfielddisplayformat(afield: TFloatfield);
begin
  if afield.Displayformat = '' then
    if afield.currency then
         afield.Displayformat := AppEnv.RegionalOptions.CurrencySymbol + DOUBLE_FIELD_MASK
    else afield.Displayformat := DOUBLE_FIELD_MASK;
end;

function TBaseListingGUI.ChangeDisplayLabel(str, oldLabel, newLabel: string): string;
var
  x: integer;
begin
  Result := str;
  for x := 0 to qryMain.Fields.Count - 1 do begin
    if SameText(qryMAin.Fields[x].DisplayLabel, newLabel) then begin
      Exit;
    end;
  end;
  {replace only if its a word}
  Result := StringReplace(Result, oldLabel + ' ', newLabel + ' ', [rfIgnoreCase]);
  Result := StringReplace(Result, ' ' + oldLabel, ' ' + newLabel, [rfIgnoreCase]);
end;

procedure TBaseListingGUI.AdjustDisplayLabels;
var
  iIndex: integer;
  s: string;
  ProductAttrib1Name: string;
  ProductAttrib2Name: string;
  PartColumn: string;
  FirstColumn: string;
  SecondColumn: string;
  ThirdColumn: string;
  AllocationBatchnoName: string;
  AllocationExpiryDateName: string;
  AllocationTruckLoadNoName: string;
  EquipmentName: string;
  HireName: string;
  clientPrintname :String;
  ProductPrintName :String;
  ClassHeading: string;
  B4DisplayLabel, AfterDisplayLabel: string;
  tmpField: TField;
  CustomerNameHeading:String;
  SupplierNameHeading:String;
  ProspectnameHeading:String;
  Fe1Heading: string;
  Fe2Heading: string;
  Fe3Heading: string;
  Fe4Heading: string;
  Fe5Heading: string;

begin
  { DID THIS FOR SPEED }
  ProductAttrib1Name := AppEnv.CompanyPrefs.ProductAttrib1Name;
  ProductAttrib2Name := AppEnv.CompanyPrefs.ProductAttrib2Name;
  PartColumn := AppEnv.DefaultClass.PartColumn;
  FirstColumn := AppEnv.DefaultClass.FirstColumn;
  SecondColumn := AppEnv.DefaultClass.SecondColumn;
  ThirdColumn := AppEnv.DefaultClass.ThirdColumn;
  AllocationBatchnoName := AppEnv.DefaultClass.AllocationBatchnoName;
  AllocationExpiryDateName := AppEnv.DefaultClass.AllocationExpiryDateName;
  AllocationTruckLoadNoName := AppEnv.DefaultClass.AllocationTruckLoadNoName;
  EquipmentName := AppEnv.DefaultClass.EquipmentName;
  HireName := AppEnv.DefaultClass.HireName;
  clientPrintname := AppEnv.CompanyPrefs.ClientPrintNameHeading;
  ProductPrintName := AppEnv.CompanyPrefs.ProductPrintNameHeading;
  ClassHeading := AppEnv.DefaultClass.ClassHeading;
  Fe1Heading := AppEnv.CompanyPrefs.Fe1Name;
  Fe2Heading := AppEnv.CompanyPrefs.Fe2Name;
  Fe3Heading := AppEnv.CompanyPrefs.Fe3Name;
  Fe4Heading := AppEnv.CompanyPrefs.Fe4Name;
  Fe5Heading := AppEnv.CompanyPrefs.Fe5Name;

  CustomerNameHeading:=UserCustomisedName(cpCustomerName);
  SupplierNameHeading:=UserCustomisedName(cpSupplierName);
  ProspectnameHeading:=UserCustomisedName(cpProspectname);

  for iIndex := 0 to qryMain.FieldCount - 1 do begin
    tmpField := qryMain.fields[iIndex];
    if tmpField = nil then continue
    else if tmpField <> nil then
      if ((tmpField.Tag and TAG_MASK_FC) = TAG_MASK_FC) then continue;

    if not tmpField.Visible then continue;

    if tmpfield is TFloatfield then
      initfloatfielddisplayformat(TFloatfield(tmpfield));

    if (tmpField.displaywidth > 20) and (tmpField.displaywidth = tmpField.Size) then tmpField.displaywidth := 20;
    s := tmpField.DisplayLabel;

    s := ChangeDisplayLabel(s, 'Class', ClassHeading);
    s := ChangeDisplayLabel(s, 'ClassName', ClassHeading);
    s := ChangeDisplayLabel(s, 'Departmentname', ClassHeading);

    s := ChangeDisplayLabel(s, 'CustomerName', CustomerNameHeading);
    s := ChangeDisplayLabel(s, 'SupplierName', SupplierNameHeading);
    s := ChangeDisplayLabel(s, 'ProspectName', ProspectnameHeading);

    s := ChangeDisplayLabel(s, 'Customer Name', CustomerNameHeading);
    s := ChangeDisplayLabel(s, 'Supplier Name', SupplierNameHeading);
    s := ChangeDisplayLabel(s, 'Prospect Name', ProspectnameHeading);

    s := ChangeDisplayLabel(s, 'Company Name', CustomerNameHeading);
    s := ChangeDisplayLabel(s, 'CompanyName', CustomerNameHeading);
    s := ChangeDisplayLabel(s, 'Company', CustomerNameHeading);

    if not empty(ProductAttrib1Name) then begin
      s := ChangeDisplayLabel(s, 'Attrib1', ProductAttrib1Name);
    end;
    if not empty(ProductAttrib2Name) then begin
      s := ChangeDisplayLabel(s, 'Attrib2', ProductAttrib2Name);
    end;
    if not empty(PartColumn) then begin
      s := ChangeDisplayLabel(s, 'ProductName', PartColumn);
    end;
    if not empty(FirstColumn) then begin
      s := ChangeDisplayLabel(s, 'FirstColumn', FirstColumn);
      s := ChangeDisplayLabel(s, 'column1', FirstColumn);
      s := ChangeDisplayLabel(s, 'col1', FirstColumn);
    end;
    if not empty(SecondColumn) then begin
      s := ChangeDisplayLabel(s, 'SecondColumn', SecondColumn);
      s := ChangeDisplayLabel(s, 'column2', SecondColumn);
      s := ChangeDisplayLabel(s, 'col2', SecondColumn);
    end;
    if not empty(ThirdColumn) then begin
      s := ChangeDisplayLabel(s, 'ThirdColumn', ThirdColumn);
      s := ChangeDisplayLabel(s, 'column3', ThirdColumn);
      s := ChangeDisplayLabel(s, 'col3', ThirdColumn);
    end;
    if not empty(AllocationBatchnoName) then begin
      s := ChangeDisplayLabel(s, 'Batchnumber', AllocationBatchnoName);
      s := ChangeDisplayLabel(s, 'BatchNo', AllocationBatchnoName);
    end;
    if not empty(AllocationExpiryDateName) then begin
      s := ChangeDisplayLabel(s, 'ExpiryDate', AllocationExpiryDateName);
      s := ChangeDisplayLabel(s, 'BatchExpiryDate', AllocationExpiryDateName);
    end;
    if not empty(AllocationTruckLoadNoName) then begin
      s := ChangeDisplayLabel(s, 'TruckLoadNo', AllocationTruckLoadNoName);
      s := ChangeDisplayLabel(s, 'truckLoadNumber', AllocationTruckLoadNoName);
      s := ChangeDisplayLabel(s, 'BatchtruckLoadNumber', AllocationTruckLoadNoName);
      s := ChangeDisplayLabel(s, 'BatchtruckLoadNo', AllocationTruckLoadNoName);
    end;
    if not empty(EquipmentName) then begin
      s := ChangeDisplayLabel(s, 'Equipment'           , EquipmentName);
      s := ChangeDisplayLabel(s, 'EquipmentName'       , EquipmentName+' Name');
      s := ChangeDisplayLabel(s, 'EquipmentNumber'     , EquipmentName+' No');
      s := ChangeDisplayLabel(s, 'EquipmentNo'         , EquipmentName+' No');
      s := ChangeDisplayLabel(s, 'Equipmentdescription', EquipmentName+' description');
    end;
    if not empty(HireName) then begin
      s := ChangeDisplayLabel(s, 'Hire'   , HireName);
      s := ChangeDisplayLabel(s, 'HireNumber' , HireName+' No');
      s := ChangeDisplayLabel(s, 'HireNo'     , HireName+' No');
    end;

    if not empty(ProductPrintName) then begin
      s := ChangeDisplayLabel(s, 'ProductPrintname'   , ProductPrintName);
      s := ChangeDisplayLabel(s, 'Product Print Name'   , ProductPrintName);
    end;

    if not empty(clientPrintname) then begin
      s := ChangeDisplayLabel(s, 'Printname'   , clientPrintname );
      s := ChangeDisplayLabel(s, 'Print Name'   , clientPrintname);
    end;

    s := ChangeDisplayLabel(s, 'Fe1Visible', Fe1Heading);    s := ChangeDisplayLabel(s, 'Fe1Name', Fe1Heading);
    s := ChangeDisplayLabel(s, 'Fe2Visible', Fe2Heading);    s := ChangeDisplayLabel(s, 'Fe2Name', Fe2Heading);
    s := ChangeDisplayLabel(s, 'Fe3Visible', Fe3Heading);    s := ChangeDisplayLabel(s, 'Fe3Name', Fe3Heading);
    s := ChangeDisplayLabel(s, 'Fe4Visible', Fe4Heading);    s := ChangeDisplayLabel(s, 'Fe4Name', Fe4Heading);
    s := ChangeDisplayLabel(s, 'Fe5Visible', Fe5Heading);    s := ChangeDisplayLabel(s, 'Fe5Name', Fe5Heading);

    AdjustDisplayLabels(tmpField , s);
    B4DisplayLabel := tmpField.DisplayLabel;
    if tmpField.Displaywidth = 255 then tmpField.Displaywidth  := 15;

    AfterDisplayLabel := SeparateWords(s);

    if not SysUtils.SameText(B4DisplayLabel, AfterDisplayLabel) then tmpField.DisplayLabel := AfterDisplayLabel;

  end; // for
  AppEnv.RegionalOptions.ChangeList(qryMain);
  s := GetSelectedTExtFromFields(grdmain,True);
  grdmain.Selected.Text := s;
  grdmain.ApplySelected;
end;
Procedure TBaseListingGUI.Loadchartnames;
var
  NewItem : TMenuItem;
begin
  With TempMyQuery do try
    SQL.add('SELECT chartname FROM tblcustomcharts '+
            ' WHERE reportclassname = '+ Quotedstr(Self.Classname)+
            ' AND (EmployeeId = ' + inttostr(Appenv.Employee.employeeID) +' OR Global="T" )' +
            ' ORDER BY chartname');
    open;
    if recordcount >0 then begin
      First;
      while Eof = False do begin
        NewItem := TMenuItem.Create(mnuCharts);
        NewItem.Caption := fieldbyname('Chartname').asString;
        NewItem.OnClick := REfreshgraph;
        mnuCharts.Items.Add(NewItem);
        Next;
      end;
    end;
  finally
    ClosenFree;
  end;
end;
procedure TBaseListingGUI.LoadFooterValues(amountTotals: array of Double);
begin
  // descendants will override if required
end;

procedure TBaseListingGUI.RefreshGraph(Sender:TObject);
begin
  if not (Sender is TMenuItem) then exit;
  if TMenuItem(Sender).Caption = '' then exit;

  if Sametext(charttolaunch ,replacestr( TMenuItem(Sender).Caption , '&' , '')) and (TMenuItem(Sender).checked) then exit;

  charttolaunch :=replacestr( TMenuItem(Sender).Caption , '&' , '');
  RefreshGraph;
end;

procedure TBaseListingGUI.InitWwRadioGroup(Sender : TwwRadioGroup);
begin
  Sender.ShowGroupCaption := False;
  Sender.ShowBorder       := true;
  Sender.ShowFocusRect    := true;
end;
function TBaseListingGUI.cmpprocnotoStr(const ficmpProcess: TcmpProcessNo):string;
begin
       if ficmpProcess = pn1 then result := '1'
  else if ficmpProcess = pn2 then result := '2'
  else if ficmpProcess = pn3 then result := '3'
  else if ficmpProcess = pn4 then result := '4'
  else if ficmpProcess = pn5 then result := '5'
  else if ficmpProcess = pn6 then result := '6'
  else result := '';
end;

procedure TBaseListingGUI.inPanelcomponents(const ficmpProcess: TcmpProcessNo);
Const
  MIN_GAP = 4;
begin
  iLeft := MIN_GAP;
  if (ficmpProcess = pn1) or (ficmpProcess = pn5) or (ficmpProcess = pn6)  then iTotalHeaderComponentWidth :=0;

  with btnRequery       do begin
    if visible then begin
      showcontrolhint(btnRequery,name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With lblFilter        do begin
    if visible then begin
      showcontrolhint(lblFilter,name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With cboFilter        do begin
    if visible then begin
      showcontrolhint(cboFilter,name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess = pn5 then begin if width > 30 then width := Width -5;  end;
      if ficmpProcess = pn6 then begin width := Width +5;end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With lblSearchoptions do begin
    if visible then begin
      showcontrolhint(lblSearchoptions, name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With edtSearch        do begin
    if visible then begin
      showcontrolhint(edtSearch,name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess = pn5 then begin if width > 30 then width := Width -5;end;
      if ficmpProcess = pn6 then begin width := Width +5;end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With lblFrom          do begin
    if visible then begin
      showcontrolhint(lblFrom,name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With dtFrom           do begin
    if visible then begin
      showcontrolhint(dtFrom,name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With lblTo            do begin
    if visible then begin
      showcontrolhint(lblTo, name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With dtTo             do begin
    if visible then begin
      showcontrolhint(dtTo, name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With lblcustomReport  do begin
    if visible then begin
      showcontrolhint(lblcustomReport,name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With cboCustomReports do begin
    if visible then begin
      showcontrolhint(cboCustomReports, name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess = pn5 then begin if width > 30 then width := Width -5;end;
      if ficmpProcess = pn6 then begin width := Width +5;end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With grpFilters       do begin
    if visible then begin
      showcontrolhint(grpFilters, name);
      if ficmpProcess = pn1 then begin Align := alnone; anchors :=[akleft,aktop]; end;
      if ficmpProcess = pn2 then begin Left := iLeft; iLeft :=Left + Width + MIN_GAP; end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin if left < iLeft then Left :=iLeft+MIN_GAP;iLeft:= left+width; end;
      if ficmpProcess in [pn1,pn5, pn6] then begin iTotalHeaderComponentWidth := iTotalHeaderComponentWidth + Width +MIN_GAP; end;

    end;
  end;

  With pnlSearchbuttons do begin
    if visible then begin
      showcontrolhint(pnlSearchbuttons, name);
      if ficmpProcess = pn2 then begin Left := lblSearchoptions.Left;              end;
      if ficmpProcess = pn3 then begin Top :=trunc(( pnlbuttons.height - Height)/2); end;
      if ficmpProcess = pn4 then begin Left := lblSearchoptions.Left; end;
    end;
    visible := false;
  end;
  pnlButtons.repaint;

end;

procedure TBaseListingGUI.Initcomponents;
var
  comp :TComponent;
begin
  InitWwRadioGroup(grpFilters);
  InitWwRadioGroup(grpView);
  comp := FindComponent('grpExtraFilters');
  if assigned(comp) and (comp is TwwRadioGroup) then
    InitWwRadioGroup(TwwRadioGroup(comp));
end;
procedure TBaseListingGUI.Alignbuttons;
begin
  Alignbuttons(FooterPanel , fbCentralisePanelbuttons);
end;
procedure TBaseListingGUI.Alignbuttons(pnl :TDnmpanel; Docentre :Boolean = False);
var
  ctr:Integer;
  btntop, btnheight :Integer;
  Procedure Addbutton(btn :TDnMSpeedbutton; isDefault :Boolean);
  begin
     if not Docentre then exit;
     if not(btn.visible) then exit;
     if isDefault or ((btn <> btnCustomize) and (btn<> cmdExport) and (btn <> cmdNew) and (btn <> cmdPrint) and (btn <>cmdClose)) then begin
        setlength(buttons, length(buttons)+1);
        buttons[high(buttons)] :=btn.Name;
     end;
  end;
begin
  btntop:=0;
  btnheight:= 0;
  setlength(buttons,0);
  Addbutton(btnCustomize,true);
  Addbutton(cmdExport,true);
  Addbutton(cmdNew,true);
  if (pnl <> FooterPanel) or (autoAlignButtonsinfooterPanel) then {Set this to false in formcreate before inherited}
    for ctr:= 0 to componentcount -1 do begin
      if components[ctr] is TDnMSpeedbutton then
        if TDnMSpeedbutton(components[ctr]).visible then
          if TDnMSpeedbutton(components[ctr]).parent = pnl then begin
            if btntop =0 then begin
              btntop := TDnMSpeedbutton(components[ctr]).top;
              btnheight:= TDnMSpeedbutton(components[ctr]).height;
            end else begin
              TDnMSpeedbutton(components[ctr]).top := btnTop;
              TDnMSpeedbutton(components[ctr]).height := btnheight;
            end;
              Addbutton(TDnMSpeedbutton(components[ctr]), False);
              (*if Docentre then
                  if TDnMSpeedbutton(components[ctr]).visible then begin
                  setlength(buttons, length(buttons)+1);
                  buttons[high(buttons)] :=TDnMSpeedbutton(components[ctr]).Name;
                end;*)
          end;
    end;
    Addbutton(cmdPrint,true);
    Addbutton(cmdClose,true);

    Label3.Left := 1;
    if Docentre and (Length(buttons)>0) then
      Centralisebuttons(pnl , footerbuttonLeftMargin, footerbuttonRightMargin);
end;
Function TBaseListingGUI.footerbuttonLeftMargin:Integer;
begin
  Result := Label3.Left +Label3.Width;
end;
Function TBaseListingGUI.footerbuttonRightMargin:Integer;
begin
  Result :=Label3.Left +Label3.Width;
end;
procedure TBaseListingGUI.Alignpagecontrols;
var
  Index:Integer;
begin
      for Index := 0 to ComponentCount - 1 do begin
        if Components[Index] is TPageControl then begin
          TPageControl(Components[Index]).OwnerDraw := true;
          TPageControl(Components[Index]).OnDrawTab := PageControlDrawTab;
        end;
      end;
end;

Procedure TBaseListingGUI.InitIncludehistory;
begin
  pnlIncludehistory.Visible := fbIncludehistory;
  pnlIncludehistory.hint := 'When not checked : if the ''From date'' is prior to the closing date(' +  Quotedstr(formatdateTime(FormatSettings.ShortDateFormat, appenv.CompanyPrefs.SummarisedTransDate)) +'), '+NL+
                            '                                  the ''From date'' is ignored and it sees all records from the beginning.'+NL+
                            'When Checked : the ''From date'' is used'+NL;
  pnlIncludehistory.showhint := True;
  pnlIncludehistory.ParentShowHint:= false;
end;
procedure TBaseListingGUI.initPopupmenu;
var
  NewItem : TMenuItem;
begin
  if Assigned(grdmain.popupmenu) then begin
        NewItem := TMenuItem.Create(grdmain.popupmenu);
        NewItem.Caption := '-';
        grdmain.popupmenu.Items.Add(NewItem);

        NewItem := TMenuItem.Create(grdmain.popupmenu);
        NewItem.Caption := 'Copy';;
        NewItem.OnClick := DocopyData;
        grdmain.popupmenu.Items.Add(NewItem);

        if fbShowcustomiseonMenu and (btnCustomize.visible) and (btnCustomize.enabled)  then begin
              NewItem := TMenuItem.Create(grdmain.popupmenu);
              NewItem.Caption := btnCustomize.caption;
              NewItem.OnClick := btnCustomize.Onclick;
              grdmain.popupmenu.Items.Add(NewItem);
        end;
  end;
end;
procedure TBaseListingGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
    function ProgressMsg: String;
    begin
      if Sender <> nil then begin
        result                     := Sender.ProgressMsg;
        if result = '' then result := WAITMSG;
      end else begin
        result := WAITMSG;
      end;
    end;
    Function Progresscount:Integer;
    begin
      if Sender <> nil then begin
        result                     := Sender.Progresscount;
        if result = 0 then result := 10;
      end else begin
        result := 10;
      end;
    end;
begin
    if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_ShowProgressbar) then begin
      showProgressbar(ProgressMsg, Progresscount, false);
      exit;
    end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_HideProgressbar) then begin
      HideProgressbar;
      Exit;
    end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_ProgressbarProgress) then begin
      stepProgressbar(ProgressMsg);
      Self.Refresh;
      Exit;
    end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TForeignCurrencyonReport then TForeignCurrencyonReport(Sender).Dataset  := qryFConReport;
    end;
  inherited;
end;

procedure TBaseListingGUI.DocopyData(Sender: TObject);
begin
  try
    Clipboard.asText:= Activefield.asString;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('Copy Failed.'+NL+E.Message+NL+NL+'Try Again', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TBaseListingGUI.Check4futureDateRangeOptions;
  Procedure AddDaterangeItem(const Value:String);
  begin
    if cboDateRange.items.IndexOf(Value) <0 then cboDateRange.items.Insert(cboDateRange.items.count-1 , Value);
  end;
begin
  if not fbHasfutureDateRangeOptions then exit;
  AddDaterangeItem('Tomorrow');
  AddDaterangeItem('Next Week');
  AddDaterangeItem('Next Month');
  AddDaterangeItem('Next Quarter');
  AddDaterangeItem('Next 12 Months');
end;

procedure TBaseListingGUI.FormCreate(Sender: TObject);
var
  fbIgnoreAccesslevel:boolean;
begin
  fbCheckedBaselistMultiSelectItems := False;
  fbShowGridOnlyinPanel:= False;
  fbShowcustomiseonMenu := False;
  fiParentPanelWidth :=0;
  fbResizeCompsforPanel := False;
  fiParentWidth := 0;
  fsKeyIdfieldname := '';
  fsKeyNamefieldname := '';
  fbclosingifListempty := False;
  fbRemovedDateRangeHint := False;
  fDateRangetype := drNormal;
  fbReportTablemsgshown := False;
  chkShowEmailOptions.caption := ' Show Email'+NL+' Options';
  fGridGuiObj :=nil;
  fOnListcose := nil;
  Selectrecordsfieldname :='';
  SelectrecordsValues :='';
  fbExportingall := False;
  fbistoDoAfterallSelected := False;
  fiKeyIdtoLocate := 0;
  fstimedMsgOnshow := '';
  fOnDataScroll := nil;
  lblcheck1.Caption := lblcheck1.Parent.Name +' visible';
  lblcheck2.Caption := lblcheck2.Parent.Name +' visible';
  lblcheck1.visible := False;
  lblcheck2.visible := False;

  Check4futureDateRangeOptions;
  AlignbuttonTopnHeight(FooterPanel);
  fbSaveListSortOrder:= False;
  SelectionOption := soNone;
  fbComboDataSelect:= False;
  mnuLogSQL.Visible := Devmode;
  mnuListclassname.Visible := Devmode;
  mnuMakeTable.Visible := Devmode;
  AlignPagecontrols;
  DoingOnGrdmainDblclick := False;
  Searching :=False;
  fOnGidMultiselect := nil;
  fbShowbuttonsinPanel := False;
  fsAddresstoEmail:= '';
  fbShowCancelPreviewBtninReportPreview:= False;
  fbhideIDFields:=False;
  fbHideSitefields:=False;

  Alignbuttons;
  Initcomponents;
  fbAllowdrilldownwhenModal:= False;
  DisablePopupmenuinPanel:= True;
  initIncludehistory;
  GrpfilterSupplied := fAlse;
  grpView.itemindex :=1;// default to values
  fbDisableDefaultGraphViewOption := False;
  fscharttolaunch:= '';
  fsCustomChartToView:='';
  fInitListofSubform:= nil;
  fOnRefreshQuery := nil;
  fOnRefreshTotals := nil;
  fbIgnoreAccesslevel := IgnoreAccessLevels;
  try
    GuiPrefs := nil;
    IgnoreAccessLevels := true;
    BaseIndexfields := '';
    FormShowCount := 0;
    if not DonotChangeGridLabels then adjustDisplayLabels;

    usingReportTables := false;
    SetIndicatorbutton;
    if accesslevel = 6 then exit;

    inherited;
    LoadChartnames;
    fbEnableClosingDateBalanceCheck := false;
    changingFromDate := false;
    changingToDate := false;
    dtFromLastDateTime := 0;
    dtToLastDateTime := 0;
    ListManRunOnce := false;
    AutoSetColumnControlType := True;
    Setlength(FooterCalcfields, 0);
    CustomFilterForm := nil;
    chkPreview.Checked := AppEnv.Employee.ShowPreview;
    fbShowGridonly := false;
    SearchWhenNotInlistfield := '';
    fOnGridDataSelect := nil;
    fCustomReportName := '';
    fExporting := false;
    CloseOnRecSelect := True;
    CustomFilterString := '';
    fShowChartViewOnPopup := True;
    fActiveClasses := nil;

    fbNoRequery := false;
    fbSwapBaseIndexFieldPriority := false;
    fsSortColumnName := '';
    fsColumnOrderMode := '';
    fsAppendFilter := '';
    bmBookmark := nil;
    GroupFilterString := '';
    fMainTable := qryMain;
    BusObjqueries := nil;
    fsWhereClause := '';
    fUseTmpTable := false;
    Setlength(AmountFields, 0);
    Setlength(AmountCaptions, 0);
    initFCFields;

    if dtFrom.Visible and dtTo.Visible then cboDateRange.Visible := True;

    // Clear Design Time Connections
    MyConnection1.Connected := false;
    MyConnection1.Password := '';
    MyConnection1.Username := '';
    MyConnection1.Database := '';
    MyConnection1.Server := '';

    fSearchMode := smNone;
    QueryManipulationObj := TQueryManipulationObj.Create(qryMain.SQL.Text);
    SearchMode := smSearchEngine; { default }
    if NonSearchMode then begin
      SearchMode := smFullList;
      { still searches but not with different modes;justF5 }
      lblSearchMode.Visible := false;
    end;

    { State that we are initialising our form for the first time. }
    bFormStarting := True;

    // Set StartTime to the current time it is now.
    StartTime := now;
    FFirstRun := True;
    fbIgnoreQuerySpeed := false; // true;
    fbUseSortinSearch := True;
    fbDisableSortoncolumtitleclick := False;
    fbStartinWebSearchMode := false;
    fOpenedByChart := false;
    ProcessingCursor(True);
    try
      initList;
      fbDateRangeSupplied := false;
      fiGuiID := 0;

      if AppEnv.Employee.ListSelectionColour = 0 then begin
        HIGHLIGHTLOCATE := HIGHLIGHTLOCATEDEF;
      end else begin
        HIGHLIGHTLOCATE := AppEnv.Employee.ListSelectionColour;
      end;

      // IJB    foFieldView := TCustomizeListObj.Create;
      SetConnectionString;

      // Does this user have NO Access?
      if accesslevel = 6 then begin
        // No Access, stop them right here!
        ErrorOccurred := True;
        Abort;
        // PostMessage(Self.Handle, WM_Close, 0, 0);
        exit;
      end;

      PrintDATSetID;

      //PrintTemplate := TPrintTemplates.Create;

      GuiPrefs := TFormGuiPrefs.Create(Self);
      if not(sametext(GuiprefName, self.classname)) then GuiPrefs.PrefsName := GuiprefName;

      if (AppContext['CustomReportListing'].VarExists('Prefname')) and (AppContext['CustomReportListing'].VarByname['Prefname'] <> '') then
          GuiPrefs.prefsname := AppContext['CustomReportListing'].VarByname['Prefname'];

      if (IsGridcustomisable or CanCreatecustomReport or fbReportonForeignCurrency) then begin
        if IsGridcustomisable then GuiPrefs.Elements.Add('TwwDbGridGuiElement', grdMain);
        if CanCreatecustomReport then GuiPrefs.Elements.Add('TBaseListingGuiElement', grdMain);
        if fbReportonForeignCurrency then GuiPrefs.Elements.Add('TReportonForeignCurrency', grdMain);
        AddGuiPrefElements;
      end;
      GuiPrefs.Active := True;

      CleanfieldList := TStringList.Create;
      CleanfieldList.Text := grdMain.Selected.Text;

      DefaultMaxGridColumnWidth := 80;
      DonotChangeGridLabels := false;

      //Self.Color := ColorAdjustLuma(GetGradientColor(Self.ClassName).Color, GetGradientColor(Self.ClassName).AdjLuma div 2, false);
      HeaderPanel.Color := Self.Color;
      grdMain.TitleColor := Self.Color;
      grdMain.FooterColor := Self.Color;
      FooterPanel.Color := Self.Color;
      if fbReportonForeignCurrency then begin
        fFConReport := TForeignCurrencyonReport.Create(Self);
        fFConReport.BusObjEvent := DoBusinessObjectEvent;
        fFConReport.Loadmemtable := Loadmemtable;
        //fFConReport.DataSet := qryFConReport;
        fFConReport.lkTblCurrencyConversion := qryCurrencyConversion;
        //qryFConReport.open;
        qryCurrencyConversion.open;
        fFConReport.LoadFCPref;
      end;
      Ratetype := '';
      // Status Text
      if AppEnv.CompanyPrefs.DisableNotifyLists then begin
        barStatus.Panels[barStatus.Panels.Count - 1].Style := psHTML;
        barStatus.Panels[barStatus.Panels.Count - 1].Text := '<P align="center"><FONT color="#800000"><B>' + STATUS_MSG + '</B></FONT></P>';;
      end else begin
        barStatus.Panels[barStatus.Panels.Count - 1].Style := psText;
        barStatus.Panels[barStatus.Panels.Count - 1].Text := '';
      end;
      DBEventList := TObjectList.Create(true);
    finally
      ProcessingCursor(False);
    end;
  finally
    IgnoreAccessLevels := fbIgnoreAccesslevel;
  end;
end;
procedure TBaseListingGUI.AddGuiPrefElements;
begin
// descendants will override it if required
end;
Procedure TBaseListingGUI.onLoadmemtable;
begin

end;
procedure TBaseListingGUI.Loadmemtable;
begin
  FConReport.Close;
  FConReport.EmptyTable;
  FConReport.open;
  if fbReportonForeignCurrency then begin
    fFConReport.first;
    while fFConReport.eof = false do begin
      FConReport.Insert;
      FConReportID.asInteger := fFConReport.currencyID;
      FConReportCode.asString := fFConReport.Code;
      FConReportRecno.asString := inttostr(fFConReport.RecNo);
      FConReportSymbol.asString := fFConReport.Symbol;
      FConReport.Post;
      fFConReport.Next;
    end;
  end;
  onLoadmemtable;
end;

procedure TBaseListingGUI.FormDestroy(Sender: TObject);
begin
  ObserverList.DetachAll(Self);
  FreeandNil(CleanfieldList);
  FreeandNil(fUserLock);
  FreeAndNil(fReportSQLobj);
  FreeAndNil(fGridGuiObj);
  DBEventList.Free;
  FreeAndNil(GuiPrefs);

  // LogD('TBaseListingGUI.FormDestroy',lbBegin);
  try
    { this is created with self as owner .. we dont need to free it }
    // Freeandnil(CustomFilterForm);
    //if Assigned(PrintTemplate) then FreeandNil(PrintTemplate);
    FreeandNil(QueryManipulationObj);
    fCustomFilter := nil;
    FreeandNil(fActiveClasses);
    // Deregister any event handlers that have been registered by ancestor forms
    GlobalEvents.DeregisterHandlers(Self);
    if Assigned(fFConReport) then FreeandNil(fFConReport);
    FreeandNil(SQLStrList);
    Finalize(AmountFields);
    Finalize(AmountCaptions);
    if Assigned(bmBookmark) then qryMain.FreeBookmark(bmBookmark);
    inherited;
  finally
    // LogD('',lbEnd);
  end;
end;

procedure TBaseListingGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
  tmpIndex: string;
begin
  if ErrorOccurred then exit;
  if (edtSearch.Text <> '') and (cboFilter.Text <> '') then begin
    sFieldName := TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).fieldname;
    if dsMain.DataSet.FindField(sFieldName) <> nil then begin
      try
        if fbUseSortinSearch then begin
          if not empty(BaseIndexFieldNames) and (QuotedStr(sFieldName) + ' ASC CIS' <> BaseIndexFieldNames) then begin
            tmpIndex := QuotedStr(sFieldName) + ' ASC CIS; ' + BaseIndexFieldNames;
          end else begin
            if not empty(SecondaryIndexFieldNames) then begin
              tmpIndex := QuotedStr(sFieldName) + ' ASC CIS; ' + SecondaryIndexFieldNames + ' ASC CIS;';
            end else begin
              tmpIndex := QuotedStr(sFieldName) + ' ASC CIS;';
            end;
          end;
          try
            qryMain.IndexFieldNames := '';
            Application.ProcessMessages;
            addbaseindexfields(tmpIndex);
            qryMain.IndexFieldNames := tmpIndex;
            DoQrymainafteropen;
          except
          end;
        end;
        dsMain.DataSet.Locate(sFieldName, ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', ''), [loCaseInsensitive, loPartialKey]);
      except
      end;
    end;
  end;
end;

procedure TBaseListingGUI.SetClassLabels;
var
  i: integer;
begin
  for i := 0 to Self.ComponentCount - 1 do begin
    if (Self.Components[i] is TLabel) then begin
      if FastFuncs.PosEx(uppercase('class'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin
        TLabel(Self.Components[i]).AutoSize := True;
        TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Class', AppEnv.DefaultClass.ClassHeading, [rfIgnoreCase]);
      end else if FastFuncs.PosEx(uppercase('fe1Visible'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin         TLabel(Self.Components[i]).AutoSize := True;         TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'fe1Visible', AppEnv.Companyprefs.Fe1Name, [rfIgnoreCase]);       end else if FastFuncs.PosEx(uppercase('fe1Name'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin         TLabel(Self.Components[i]).AutoSize := True;         TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'fe1Name', AppEnv.Companyprefs.Fe1Name, [rfIgnoreCase]);
      end else if FastFuncs.PosEx(uppercase('Fe2Visible'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin         TLabel(Self.Components[i]).AutoSize := True;         TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe2Visible', AppEnv.Companyprefs.Fe2Name, [rfIgnoreCase]);       end else if FastFuncs.PosEx(uppercase('Fe2Name'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin        TLabel(Self.Components[i]).AutoSize := True;          TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe2Name', AppEnv.Companyprefs.Fe2Name, [rfIgnoreCase]);
      end else if FastFuncs.PosEx(uppercase('Fe3Visible'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin         TLabel(Self.Components[i]).AutoSize := True;         TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe3Visible', AppEnv.Companyprefs.Fe3Name, [rfIgnoreCase]);       end else if FastFuncs.PosEx(uppercase('Fe3Name'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin        TLabel(Self.Components[i]).AutoSize := True;          TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe3Name', AppEnv.Companyprefs.Fe3Name, [rfIgnoreCase]);
      end else if FastFuncs.PosEx(uppercase('Fe4Visible'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin         TLabel(Self.Components[i]).AutoSize := True;         TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe4Visible', AppEnv.Companyprefs.Fe4Name, [rfIgnoreCase]);       end else if FastFuncs.PosEx(uppercase('Fe4Name'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin        TLabel(Self.Components[i]).AutoSize := True;          TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe4Name', AppEnv.Companyprefs.Fe4Name, [rfIgnoreCase]);
      end else if FastFuncs.PosEx(uppercase('Fe5Visible'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin         TLabel(Self.Components[i]).AutoSize := True;         TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe5Visible', AppEnv.Companyprefs.Fe5Name, [rfIgnoreCase]);       end else if FastFuncs.PosEx(uppercase('Fe5Name'), uppercase(TLabel(Self.Components[i]).Caption)) > 0 then begin        TLabel(Self.Components[i]).AutoSize := True;          TLabel(Self.Components[i]).Caption := StringReplace(TLabel(Self.Components[i]).Caption, 'Fe5Name', AppEnv.Companyprefs.Fe5Name, [rfIgnoreCase]);
      end; // if FastFuncs.PosEx(
    end;
  end; // for
end;
procedure TBaseListingGUI.SetCloseOnRecSelect(const Value: boolean);
begin
  fb_CloseOnRecSelect := Value;
end;

Function TBaseListingGUI.OpenListIfsubform(Sender:TObject):Boolean;
begin
  result := False;
  if not IsSubform then exit;
  result := TRue;
  OpenERPListForm(Self.ClassName,BeforeShowOpenList );
end;
procedure TBaseListingGUI.CopyfilterParams(Sender: TObject);
begin
  TBaseListingGUI(Sender).dtFrom.Date := Self.dtFrom.Date;
  TBaseListingGUI(Sender).DtTo.Date := Self.dtTo.Date;
end;
procedure TBaseListingGUI.BeforeShowOpenList(Sender: TObject);
begin
  if (not(Sender is TBaseListingGUI)) then exit;
  CopyfilterParams(SendeR);
  if assigned(fInitListofSubform) then
    fInitListofSubform(Sender)
  else if devmode then
    MessageDlgXP_Vista(Quotedstr(TBaseListingGUI(Sender).Listcaption) +' is opened from the panel for details - not filtered for the record selected', mtWarning, [mbOK], 0);
end;

procedure TBaseListingGUI.Hide1Click(Sender: TObject);
begin
  inherited;
  ToggleSearchoptions;
end;

procedure TBaseListingGUI.HideHeaderwhenFormInPanel;
begin
  HeaderPanel.visible := False;
  grdmain.align := alclient;
  panel1.align := alclient;
end;
procedure TBaseListingGUI.Resetinpanel;
begin
   inPanelcomponents(pn4);
end;

procedure TBaseListingGUI.SetupFormInPanel;
const
  TOPS = 4;
begin
  { If the parent is a TDNMPanel, disable some common characteristics,
    the form is used typically in History tabs }

  if fSearchMode = smFullList then begin
    if fbEnableWebSearch then begin
      if NonSearchMode then lblSearchoptions.Caption := CAP_SEARCH_NON_SEARCH_SHORT
      else lblSearchoptions.Caption := CAP_SEARCH_F5_SHORT;
    end;
  end
  else if (fSearchMode = smSearchEngine) or (fSearchMode = smSearchEngineLike) then begin
    if fSearchMode = smSearchEngine then begin
      lblSearchoptions.Caption := CAP_SEARCH_F6_SHORT
    end
    else if fSearchMode = smSearchEngineLike then begin
      lblSearchoptions.Caption := CAP_SEARCH_F7_SHORT
    end;
  end;
  borderStyle := bsNone;
  SelectionOption := soNone;
  Align := alClient;
  chkIgnoreDates.Checked := false;
  chkIgnoreDates.Visible:= false;
    pnlSearchbuttons.Visible := False;
    lblSearchoptions.Visible := True;
    cboDateRange.Visible := false;
    btnAddFilter.Visible := false;
    btnExecute.Visible := false;
    btnClear.Visible := false;
    actRefreshQry.visible := false;
    btnRequery.visible := false;
    FooterPanel.Visible := ShowbuttonsinPanel;
    if ShowbuttonsinPanel then cmdClose.enabled := False;
    HeaderPanel.Height := 35;
  //  pnlButtons.align := alNone;
  //  pnlButtons.Width := pnlButtons.Width -2;
    pnlButtons.align := alClient;
    pnlHeader.Visible := false;
    grpFilters.Visible := false;
    lblFilter.AutoSize := false;
    lblFilter.WordWrap := false;
    lblFilter.Width := 88;
    lblFilter.anchors := [akLeft,akTop];
  //  lblFilter.Width :=   lblFilter.Canvas.TextWidth(lblFilter.Caption) + 10;
    lblFilter.Parent := pnlButtons;
    lblFilter.Anchors := [akTop,akLeft];
    lblFilter.Left :=  4;
    cboFilter.Parent := pnlButtons;
    cboFilter.Anchors := [akTop,akLeft];
    cboFilter.Width := 110; // 80;//95;
    cboFilter.anchors := [akLeft,akTop];
    cboFilter.Left := lblFilter.Left + lblFilter.Width + 2;
    lblSearchoptions.Width := 138;
    lblSearchoptions.anchors := [akLeft,akTop];
    lblSearchoptions.Parent := pnlButtons;
    lblSearchoptions.Anchors := [akTop,akLeft];
    lblSearchoptions.caption := Trim(lblSearchoptions.caption);
    lblSearchoptions.top := 1;
    lblSearchoptions.height :=pnlButtons.height -2;
    lblSearchoptions.Layout := tlCenter;
    lblSearchoptions.Left := cboFilter.Left + cboFilter.Width + 6;
    edtSearch.Parent := pnlButtons;
    edtSearch.Anchors := [akTop,akLeft];
    edtSearch.Width := 200;
    edtSearch.anchors := [akLeft,akTop];
    edtSearch.Left := lblSearchoptions.Left + lblSearchoptions.Width + 2;
    Panel2.Height := HeaderPanel.Height;
    if dtTo.visible then begin
      dtTo.Parent := pnlButtons;
      dtTo.Anchors := [akTop,akLeft];
      dtTo.Left := dtTo.Parent.Width - dtTo.Width - 4;
      dtTo.Top := TOPS;
      lblTo.Parent := pnlButtons;
      lblTo.Anchors := [akTop,akLeft];
      lblTo.Left := dtTo.Left - lblTo.Width - 2;
    end;
    if dtFrom.visible then begin
      dtFrom.Parent := pnlButtons;
      dtFrom.Anchors := [akTop,akLeft];
      lblFrom.Parent := pnlButtons;
      lblFrom.Anchors := [akTop,akLeft];
    end;

    grdMain.Align := Alclient;
    if DisablePopupmenuinPanel then grdMain.PopupMenu := nil;

      //lblSearchoptions.AutoSize := True;

      { if width of all plus space > parent.width then proportionatly shrink }
      edtSearch.Width := cboFilter.Width;
      edtSearch.anchors := [akLeft,akTop];
      ExtraSetupFormInPanel;
      edtSearch.width := grpFilters.Width;
      edtSearch.anchors := [akLeft,akTop];
      cboFilter.width := grpFilters.Width;
      cboFilter.anchors := [akLeft,akTop];
      cboCustomReports.width := grpFilters.Width;
      cboCustomReports.anchors := [akLeft,akTop];
      ResizeCompsForPanel;
      GrdMain.Hint := 'This List is Based on ''' + ListDescription + '''.';
      Resetinpanel;
      CloseOnRecSelect := False;
      btninc.visible := False;
      btndec.visible := False;

      if fbShowGridOnlyinPanel then begin
        HeaderPanel.Visible := False;
        FooterPanel.Visible := False;
        pnlButtons.Visible := False;
        pnlButtons.height := 0;
        Panel1.align := alclient;
      end;
end;

Function TBaseListingGUI.ExtraCompsforPanel:Integer;
begin
  result:= 0;
end;

procedure TBaseListingGUI.SetDateRangeSelectionHint(const Value: String);
begin
  showControlHint(chkIgnoreDates , Value );
  showControlHint(cboDateRange , Value );
  showControlHint(lblFrom , Value );
  showControlHint(dtFrom , Value );
  showControlHint(lblTo , Value );
  showControlHint(dtTo , Value );
end;

procedure TBaseListingGUI.SetDefaultColor;
begin
  inherited;
end;

procedure TBaseListingGUI.SetDefaultDateRange;
begin
  { override in list forms if needed }
end;
function TBaseListingGUI.ExtraCompsforPanelWidths: Integer;
begin
  REsult:= 0;
end;

Procedure TBaseListingGUI.ResizeCompsforPanel;
var
  iTotalSpace: integer;
  fi:Integer;
Const
  WidthMargin = 30;
begin
    if Self.Parent.Width = fiParentWidth then exit;
    fiParentWidth := Self.Parent.Width;
    iTotalHeaderComponentWidth :=0;

    inPanelcomponents(pn1);
    fi:=0;
    if (fiParentPanelWidth <> (Self.Parent.Width-WidthMargin)) then begin
        if (iTotalHeaderComponentWidth ) > (Self.Parent.Width-WidthMargin)  then begin //adjust if they don't fit
          While  ((iTotalHeaderComponentWidth ) > (Self.Parent.Width-WidthMargin)) and (fi <>iTotalHeaderComponentWidth) do begin
              fi := iTotalHeaderComponentWidth;
              inPanelcomponents(pn5);
          end;
        end else if (iTotalHeaderComponentWidth ) < (Self.Parent.Width-WidthMargin) then begin //adjust if they don't fit
          While ((iTotalHeaderComponentWidth ) < (Self.Parent.Width-WidthMargin))  and (fi <>iTotalHeaderComponentWidth)  do begin
              fi := iTotalHeaderComponentWidth;
              inPanelcomponents(pn6);
          end;
        end;
        fiParentPanelWidth := (Self.Parent.Width-WidthMargin);
    end;

    inPanelcomponents(pn2);
    inPanelcomponents(pn3);

    Resetinpanel;
end;

procedure TBaseListingGUI.SetOnGridDataSelect(const Value: TOnGridDataSelect);
begin
  fOnGridDataSelect := Value;
  if Assigned(fOnGridDataSelect) then begin
    cmdPrint.Caption :=SelectCaptiononMultiSelect;
    cmdPrint.showhint := False;
  end;
end;

Procedure TBaselistingGUI.SetOnsameLineOneafterOther(first, second:TControl; Spaces:Integer=2);
begin
  second.Left   := first.Left +first.Width +spaces;
  Second.Height := first.Height;
  Second.Top    := First.Top;
  if first  is tlabel then tlabel(first).Layout   := tlCenter;
  if Second is tlabel then tlabel(Second).Layout  := tlCenter;
end;
procedure TBaseListingGUI.SetPassedConnection(const Value: TERPConnection);
begin
  fPassedConnection := Value;
  SetConnectionString;
end;

procedure TBaseListingGUI.SetRowSelect(const Value: Boolean);
begin
    if Value then
      if not(dgRowSelect in grdMain.Options) then grdMain.Options := grdMain.Options + [dgRowSelect]
    else if (dgRowSelect in grdMain.Options) then grdMain.Options := grdMain.Options - [dgRowSelect];
end;

Function TBaselistingGUI.Listcaption:String;
begin
  if trim(titleLabel.caption)<> '' then result := Trim(titleLabel.caption)
  else result := ReplaceStr(ReplaceStr(ReplaceStr(Self.Caption, AppEnv.AccessLevels.GetAccessLevelDescription(accesslevel), ''), '(Press F2 for Help)', '') , ReportTableUpdatedtime , '');
end;
function TBaseListingGUI.ListDescription: String;
begin
  REsult := TitleLabel.Caption;
end;

procedure TBaseListingGUI.ListforAday(const Value: TDateTime);
begin
  if dtFrom.Visible =false then exit;
  dtfrom.date := 0;
  dtto.date := Value;
  dtfrom.date := Value;
  fbDateRangeSupplied := True;
end;

procedure TBaseListingGUI.ListforToday;
begin
  if cboDateRange.Visible =false then exit;
  cboDateRange.Itemindex := cboDateRange.Items.IndexOf('Today');
  fbDateRangeSupplied := True;
end;

function TBaseListingGUI.ListShortName: String;
begin
  Result := Self.classname;
  if sametext(copy(result,1,1) ,'T') then Result := copy(result , 2, length(Result));
  if sametext(copy(result,length(result)-2,3) ,'GUI') then Result := copy(result , 1, length(Result)-3);
  if sametext(copy(result,length(result)-3,4) ,'Base') then Result := copy(result , 1, length(Result)-4);
  if sametext(copy(result,length(result)-5,6) ,'Report') then Result := copy(result , 1, length(Result)-6);
  if sametext(copy(result,length(result)-3,4) ,'List') then Result := copy(result , 1, length(Result)-4);
end;

function TBaseListingGUI.ListShowingchart: Boolean;
begin
  Result := False;
  if grpview.Visible then
    if grpview.ItemIndex= 0 then
      Result:= True;
end;
Procedure TBaseListingGUI.formatSearchbuttons;
begin
  pnlSearchbuttons.Left := lblSearchoptions.Left + lblSearchoptions.width -pnlSearchbuttons.width;
  pnlSearchbuttons.Parent := lblSearchoptions.Parent;
  {
    default button properties removed from dfm
          Color = clWhite
          ColorWhenDown = clBlack
          DisableTransparent = False
          HotTrackColor = clActiveBorder
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          LightColor = 12320699
          ParentColor = False
          SlowDecease = True
          Style = bsModern
  }
  if not Appenv.Employee.UseERPButtonColor then begin
        btnF5.LightColor := Self.Color;
        btnF6.LightColor := btnF5.LightColor;
        btnF7.LightColor := btnF5.LightColor;
  end;
  pnlSearchbuttons.height := pnlSearchbuttons.Parent.height -2;
end;
procedure TBaseListingGUI.FormShow(Sender: TObject);
var
  // iRowHeight: Integer;
  // sAltRowColor, sFontDetails,
  // sListMode, sColumnsOrder: string;
  // bGridLines: Boolean;
  QrySeconds: integer;
  StatusAndToolbarHeight: integer;
  // Form : TComponent;
  //MenuItem: TMenuItem;
begin // ---->> TBaseListingGUI.FormShow
  Try
      {$IFDEF DevMode}
      {$ELSE}
        barStatus.Panels[2].Width := 0;
      {$ENDIF}

      mnuDefaultOrder.Visible := not(DisableSortoncolumtitleclick);
      if not fbDisableDefaultGraphViewOption and (trim(Defaultchart(Self.Classname)) <>'') then begin
          charttolaunch:= Defaultchart(Self.Classname);
          grpView.visible := trim(charttolaunch)<> '';
          grpView.hint := 'Default chart : ' +charttolaunch;
          grpView.showhint := True;
      end;

      Inc(FormShowCount);
      try
        fbFormOpenedOk := false;
        ProcessingCursor(True);
        try // Access Levels Handling
          try
            inherited;
            InitReportTableMsgIcon;
            btnCustomize.enabled := (IsGridcustomisable or CanCreatecustomReport or fbReportonForeignCurrency);

            { set the title lines to 2 for the FC fields }
            if ReportonForeignCurrency then
              if grdMain.TitleLines < 2 then grdMain.TitleLines := 2;

            Panel1.Color := FooterPanel.Color;
            if qryCustomReports.Active then qryCustomReports.Close;
            qryCustomReports.Params.Parambyname('ReportName').asString := Self.ClassName;
            qryCustomReports.Params.Parambyname('USERID').asInteger := AppEnv.Employee.EmployeeId;
            qryCustomReports.open;
            Self.AccessManager.Initialize(accesslevel, BusObjqueries);
            if not ignoreaccesslevels then
                TitleLabel.Caption := ReplaceStr(ReplaceStr(ReplaceStr(Self.Caption, AppEnv.AccessLevels.GetAccessLevelDescription(accesslevel), ''), '(Press F2 for Help)', '') , ReportTableUpdatedtime , '')
            else if trim(TitleLabel.Caption ) = '' then
              TitleLabel.Caption := Self.caption;

            if (Pos('&',TitleLabel.Caption) > 0) and (Pos('&&',TitleLabel.Caption) = 0) then
              TitleLabel.Caption := StringReplace(TitleLabel.Caption, '&', '&&', []);

            qryPersonalPrefs.Close;
            qryPersonalPrefs.Params.Parambyname('EmployeeID').asInteger := AppEnv.Employee.EmployeeId;
            qryPersonalPrefs.open;

            // Set From & To dates provided that they have not been set externally
            if not fbDateRangeSupplied then begin
              dtFrom.Date := 0;
              if qryPersonalPrefs.RecordCount = 1 then begin
                if DateRangetype = drLong then begin
                  dtTo.Date := Date + qryPersonalPrefs.FieldByName('LongListDaysFuture').asInteger;
                  dtFrom.Date := Date - qryPersonalPrefs.FieldByName('LongListDaysPast').asInteger;
                  AddDateRangeSelectionHint(LONGDATERANGEHINT);
                end else if DateRangetype = drShort then begin
                  dtTo.Date := Date + qryPersonalPrefs.FieldByName('ShortListDaysFuture').asInteger;
                  dtFrom.Date := Date - qryPersonalPrefs.FieldByName('ShortListDaysPast').asInteger;
                  AddDateRangeSelectionHint(SHORTDATERANGEHINT);
                end else begin
                  dtTo.Date := Date + qryPersonalPrefs.FieldByName('ListDaysFuture').asInteger;
                  dtFrom.Date := Date - qryPersonalPrefs.FieldByName('ListDaysPast').asInteger;
                end;
              end else begin
                dtTo.Date := Date + 0;
                dtFrom.Date := Date - 14;
              end;
              SetDefaultDateRange;
            end;
            CleanFromDate := dtFrom.Date;
            cleanTodate := dtTo.Date;

            SetClassLabels;
            // cboFilter.ItemIndex := 0;

            if NonSearchReport then begin
              edtSearch.Visible := false;
              lblSearchoptions.Visible := false;
              pnlSearchbuttons.Visible := false;
              lblFilter.Visible := false;
              cboFilter.Visible := false;
            end
            else SetControlFocus(edtSearch);

            if IsSubform then begin
              Disableform;
              try
                SetupFormInPanel;
              finally
                Enableform;
              end;
            end;

            FormatSearchButtons;
            lblSearchoptions.Top := 1;
            if pnlSearchbuttons.height > pnlSearchbuttons.Parent.Height then pnlSearchbuttons.height := pnlSearchbuttons.Parent.Height;

            if (grpFilters.Visible) and empty(fsFilterString) then begin
              grpFiltersClick(Sender);
            end;

            StatusAndToolbarHeight := CommonLib.StatusAndToolbarHeight;
            Left := (Application.MainForm.ClientWidth - Self.Width) shr 1;

            if (Self.FormStyle <> fsMDIChild) then begin
              Top := ((Application.MainForm.ClientHeight + StatusAndToolbarHeight) - Self.Height) shr 1;
            end else begin
              Top := ((Application.MainForm.ClientHeight - StatusAndToolbarHeight) - Self.Height) shr 1;
            end;

            if Assigned(fOnGridDataSelect) then begin
              cmdPrint.Caption :=SelectCaptiononMultiSelect;
              cmdPrint.showhint := False;
            end;

            fbNoRequery := True;

            fbNoRequery := false;

            Application.ProcessMessages;

            // AppEnv.RegionalOptions.ChangeList(qryMain);
            grdMain.ApplySelected;
            ReadnApplyGuiPrefExtra;

            if NonSearchReport then begin
              fbEnableWebSearch := false;
              fbIgnoreQuerySpeed := True;
            end
            else if (not NonSearchMode) then begin
              fbEnableWebSearch := True;
              if (GuiPrefs.Node['SearchMode.type'].asString = '') then GuiPrefs.Node['SearchMode.type'].asString := 'StartsWith';
              if GuiPrefs.Node['SearchMode.type'].asString = 'Like' then begin
                lblSearchMode.Caption := '"F7 MODE"';
                fTimerLabelStartTime := now;
                TimerSearchLabel.enabled := True;
                fbEnableWebSearch := True;
                SearchMode := smSearchEngineLike;
              end
              else if GuiPrefs.Node['SearchMode.type'].asString = 'StartsWith' then begin
                lblSearchMode.Caption := '"F6 MODE"';
                fTimerLabelStartTime := now;
                TimerSearchLabel.enabled := True;
                fbEnableWebSearch := True;
                SearchMode := smSearchEngine;
              end
              else if GuiPrefs.Node['SearchMode.type'].asString = 'Full' then SearchMode := smFullList;
            end;

            // if NonSearchMode then begin
            // SearchMode := smFullList; {still searches but not with different modes;justF5}
            // lblSearchMode.Visible := False;
            // end;

            if IsSubform then begin
              fbIgnoreQuerySpeed := True;
              if GuiPrefs.Node['SearchMode.type'].asString <> 'Full' then begin
                fbEnableWebSearch := True;
                SearchMode := smFullList;
              end;
              if not qryMain.Active then begin
                initqrymainsql;
                RefreshQuery;
              end;
            end else begin
              if not qryMain.Active then begin
                initqrymainsql;
                RefreshQuery;
              end;

              // To Slow Timer
              Application.ProcessMessages;
              FinishedTime := now;
              lblTime.Caption := FormatDateTime('n:ss:zzz', FinishedTime - StartTime);
            end;

            if not fbIgnoreQuerySpeed then begin
              QrySeconds := SecondsBetween(FinishedTime, StartTime) + 1;
              if (QrySeconds >= ACCEPTABLE_LIST_OPENING_TIME) and (GuiPrefs.Node['SearchMode.type'].asString <> 'StartsWith') then begin
                CommonLib.MessageDlgXP_Vista
                  ('Based on your settings, the current list you have opened is working very inefficiently. ERP will now optimise this list for you so that you can achieve greater speed and efficiency next time.'
                  + #13 + #10 + #13 + #10 + 'The list will open empty so that you only need to start typing what you are looking for then hit enter.' + #13 + #10 + #13 + #10 +
                  '"F5" will bring the full list back for optimal functionality. "F7" will switch to search mode again for optimum performance.', mtInformation, [mbOK], 0);
                GuiPrefs.Node['SearchMode.type'].asString := 'StartsWith';
              end;
            end;
            if IsModalform then
              if fbAllowdrilldownwhenModal = false then
                cmdNew.enabled := false;
            { load if there is a default filter }
            try
              if qryCustomReports.Active = false then qryCustomReports.open;
              if (qryCustomReports.recordcount>0) and (qryCustomReports.Locate('DefaultFilter', 'T', [])) then begin
                cboCustomReports.Text := qryCustomReportsFilterName.asString;
                cboCustomReportsCloseUp(cboCustomReports, qryCustomReports, nil, True);
              end;
            Except
            end;
            SetControlFocus(edtSearch);
            fbFormOpenedOk := True;
            bFormStarting := false;
          finally
            ProcessingCursor(False);
            if (accesslevel = 6) and (fsModal in Self.FFormState) then begin
              CloseModalTimer.enabled := True;
            end;
          end;
          mnuNewChart.Visible :=fShowChartViewOnPopup;
          mnuChartList.Visible :=fShowChartViewOnPopup;

          PopulateFilterCombo;

          { setting the label positions , getting hidden in cenrtain lists }
          if lblFrom.Visible then
            if lblFrom.Left <= (pnlHeader.Left + pnlHeader.Width + 10) then pnlHeader.Width := lblFrom.Left - (pnlHeader.Left + 10);
          lblTotal.Top := 45;
          Label3.Top := 30;
          lblNote.Top := 15;
          chkAdvancedPrinting.Top := 1;
          lblNote.Left := 1;
          chkAdvancedPrinting.Left := 1;
          Label3.Left := 1;
          lblTotal.Left := 1;
          if (not dtFrom.Visible) and (not dtTo.Visible) then
            chkIgnoreDates.Visible := false;
          btnEditCahrt.visible := (grpView.Visible) and (grpView.itemindex = 0) and (trim(charttolaunch)<>'');
        except
          on EAbort do HandleEAbortException;
          on e: ENoAccess do begin
            HandleNoAccessException(e);
            exit;
          end;
          on E:Exception do begin
            raise;
          end;
        end;
        DoFormSize(False);
        initPopupmenu;
        if not DoSelectionPopup then
              ShowtimedMsgOnshow;

      finally
        if FormShowCount > 0 then Dec(FormShowCount);
        NoteCaption := lblNote.Caption;
        Notecolor := lblNote.font.color;
        Notevisible:= lblNote.Visible;
        noteEnabled:= lblNote.Enabled;
      end;
  finally
    //SelectRecords;

  end;
end;
procedure TBaseListingGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // LogD('TBaseListingGUI.FormClose',lbBegin);
  fblistTobeRefreshed:=False;
  WriteGuiPrefExtra;
  try
    inherited;
    Action := caFree;

    if not Assigned(Self.Parent) then Self.enabled := false;
    { if parent is assigned - this line generates error }
  finally
    // LogD('',lbEnd);
  end;
  if Assigned(fOnListcose) then fOnListcose(Self);
  if Assigned(pnltimedMsgOnshow) then pnltimedMsgOnshow.visible := False;
  try if Assigned(ffmBaseListtimerMsg) then ffmBaseListtimerMsg.close; Except end;
  fBaselistMultiSelectItems := nil;
end;

procedure TBaseListingGUI.DeleteTable(const tablename: string);
begin
  DestroyUserTemporaryTable(tablename);
end;

procedure TBaseListingGUI.DisableAlternatingRowcolor;
begin
    grdMain.PaintOptions.AlternatingRowRegions := [];
    grdMain.PaintOptions.BackgroundOptions := [coBlendFixedRow];
end;

function TBaseListingGUI.GetSubLevelIDs(const DeptName: string): string;
var
  qryTemp: TERPQuery;
  TempIDs: string;

begin
  TempIDs := '';
  qryTemp := DbSharedObjectsObj.DbSharedObj.GetQuery(Listconnection(*GetSharedMyDacConnection*));
  try
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT ClassID FROM tblclass WHERE Level1 = ' + QuotedStr(DeptName));
    qryTemp.SQL.Add('Union');
    qryTemp.SQL.Add('SELECT ClassID FROM tblclass WHERE Level2 = ' + QuotedStr(DeptName));
    qryTemp.SQL.Add('Union');
    qryTemp.SQL.Add('SELECT ClassID FROM tblclass WHERE Level3 = ' + QuotedStr(DeptName));
    qryTemp.SQL.Add('Union');
    qryTemp.SQL.Add('SELECT ClassID FROM tblclass WHERE Level4 = ' + QuotedStr(DeptName));
    qryTemp.Active := True;
    qryTemp.first;
    while not qryTemp.eof do begin
      TempIDs := TempIDs + qryTemp.FieldByName('ClassID').asString + ',';
      qryTemp.Next;
    end;
    qryTemp.Active := false;
    TempIDs := FastFuncs.LeftStr(TempIDs, FastFuncs.Strlength(TempIDs) - 1);
    Result := TempIDs;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTemp);
  end;
end;

function TBaseListingGUI.getActiveClasses: TkbmMemTable;
var
  qry: TERPQuery;
begin
  if not Assigned(fActiveClasses) then begin
    fActiveClasses := TkbmMemTable.Create(Self);
    with TIntegerField.Create(fActiveClasses) do begin
      fieldKind := fkData;
      fieldname := 'ClassID';
      name := 'ActiveClassesClassId';
      DataSet := fActiveClasses;
    end;
    with TWideStringField.Create(fActiveClasses) do begin
      fieldKind := fkData;
      fieldname := 'classname';
      size := 60;
      name := 'ActiveClassesClassname';
      DataSet := fActiveClasses;
    end;
    with TWideStringField.Create(fActiveClasses) do begin
      fieldKind := fkData;
      size := 255;
      fieldname := 'SubLevelIDs';
      name := 'ActiveClassesSubLevelIDs';
      DataSet := fActiveClasses;
    end;
    fActiveClasses.open;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Listconnection(*GetSharedMyDacConnection*));
    try
      with Qry do begin
        SQL.Add('SELECT ClassID, ClassName from tblclass where active = "T" and ifnull(ClassName , "") <> ""');
        open;
        if RecordCount > 0 then begin
          first;
          while eof = false do begin
            fActiveClasses.Insert;
            fActiveClasses.FieldByName('classId').asInteger := FieldByName('ClassId').asInteger;
            fActiveClasses.FieldByName('className').asString := trim(FieldByName('ClassName').asString);
            fActiveClasses.FieldByName('SubLevelIDs').asString := GetSubLevelIDs(trim(fActiveClasses.FieldByName('className').asString));
            fActiveClasses.Post;
            Next;
          end;
        end;
      end;
    finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end;
  Result := fActiveClasses;
end;


function TBaseListingGUI.getFCsontheReport: string;
begin
  Result := '';
  if FConReport.RecordCount = 0 then exit;
  FConReport.first;
  while FConReport.eof = false do begin
    if Result <> '' then Result := Result + ',';
    Result := Result + FConReportCode.asString;
    FConReport.Next;
  end;
end;
Function TBaseListingGUI.QrymainBookmark(dodisablecontrol :Boolean = False):TBookmark;
begin
  REsult := qryMain.GetBookmark;
  if dodisablecontrol then qryMain.DisableControls;
end;
Procedure TBaseListingGUI.QrymaingotoBookmarknFree(bm:TBookmark; DoEnablecontrol :Boolean = False);
begin
  qryMain.GotoBookmark(bm);
  qryMain.FreeBookmark(bm);
  if DoEnablecontrol then qryMain.EnableControls;
end;
procedure TBaseListingGUI.GetFieldValueList(const aFieldName: string;
  aList: TStringList; aIdFieldName: string);
var
  bm: TBookmark;
  x: integer;
begin
  qryMain.DisableControls;
  try
    bm := qryMain.GetBookmark;
    try
      for x := 0 to SelectedRecords -1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[x]);
        if qryMain.FieldByName(aFieldName).AsString <> '' then begin
          if aIdFieldName <> '' then
            aList.AddObject(qryMain.FieldByName(aFieldName).AsString, TObject(qryMain.FieldByName(aIDFieldName).AsInteger))
          else
            aList.Add(qryMain.FieldByName(aFieldName).AsString);
        end;
      end;

      qryMain.GotoBookmark(bm);
    finally
      qryMain.FreeBookmark(bm);
    end;
  finally
    qryMain.EnableControls;
  end;
end;

procedure TBaseListingGUI.btnCustomizeClick(Sender: TObject);
var
  FCs: string;
begin
  if fbReportonForeignCurrency then FCs := getFCsontheReport;
  GuiPrefs.ShowCustomiseForm;

  if fbReportonForeignCurrency then begin

    fFConReport.LoadFCPref;
    // change filter for userId if userid=0(global) was used
    //fFConReport.RefreshDB;
    if fbReportonForeignCurrency then
      if FCs <> getFCsontheReport then begin
        PopulateReportTable;
        fblistTobeRefreshed:=True;
        RefreshQuery;
      end;
  end;
end;


procedure TBaseListingGUI.btnEditCahrtClick(Sender: TObject);
begin
  inherited;
  try
    fsCustomChartToView := charttolaunch;
  Except
    // kill the exception if field not found etc.
  end;
  grpView.ItemIndex := 1;
  if fsCustomChartToView <> '' then   OpenChart;

end;

procedure TBaseListingGUI.btnF5Click(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(edtSearch);
  SendKeys('{F5}',true);
end;

procedure TBaseListingGUI.btnF6Click(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(edtSearch);
  SendKeys('{F6}',true);
end;

procedure TBaseListingGUI.btnF7Click(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(edtSearch);
  SendKeys('{F7}',true);
end;

procedure TBaseListingGUI.PopulateReportTable;
begin
  // descendants will overide if required
end;

Function TBaseListingGUI.FieldCanBeSearched(const FieldName:String):Boolean;
begin
  REsult := True;
end;

procedure TBaseListingGUI.PopulateFilterCombo;
var
  iIndex: integer;
  sLabel: string;
begin
  cboFilter.Items.Clear;
  if (SearchMode = smSearchEngineLike) or (SearchMode = smSearchEngine) then begin
    RemoveInvalidFilterComboItems(QueryManipulationObj.InVaildFilterItems);
  end else begin
    for iIndex := 0 to grdMain.FieldCount - 1 do begin
      if (grdMain.fields[iIndex].Visible) and ((grdMain.fields[iIndex].DataType = DB.ftString) or
                                               (grdMain.fields[iIndex].DataType = DB.ftWideString) or
                                               (grdMain.fields[iIndex].DataType = DB.ftMemo) or
                                               (grdMain.fields[iIndex].DataType = DB.ftWideMemo) or
                                               (grdMain.fields[iIndex].DataType = DB.ftInteger) or
                                               (grdMain.fields[iIndex].DataType = DB.ftLargeInt)) and
        ((grdMain.fields[iIndex].fieldKind <> fkLookup) and (grdMain.fields[iIndex].fieldKind <> fkCalculated)) then begin
        sLabel := StringReplace(grdMain.ColumnByName(grdMain.fields[iIndex].fieldname).DisplayLabel, '~', ' ', [rfReplaceAll]);
        if not empty(sLabel) and (grdMain.fields[iIndex].Visible) then begin
          if FieldCanBeSearched(grdMain.fields[iIndex].fieldname) then
            cboFilter.Items.AddObject(sLabel, grdMain.fields[iIndex]);
        end;
      end;
    end;
  end;
  cboFilter.Refresh;
  cboFilter.ItemIndex := 0;
end;

procedure TBaseListingGUI.RemoveInvalidFilterComboItems(const InvalidItems: TStringList);
var
  iIndex: integer;
  sLabel: string;
  index: integer;
begin
  cboFilter.Items.Clear;
  for iIndex := 0 to grdMain.FieldCount - 1 do begin
    if (grdMain.fields[iIndex].Visible) and ((grdMain.fields[iIndex].DataType = DB.ftString) or (grdMain.fields[iIndex].DataType = DB.ftWideString) or (grdMain.fields[iIndex].DataType = DB.ftInteger)) and
      (grdMain.fields[iIndex].fieldKind <> fkLookup) and (grdMain.fields[iIndex].fieldKind <> fkCalculated) and (not InvalidItems.Find(uppercase(grdMain.fields[iIndex].fieldname), index)) then begin
      sLabel := StringReplace(grdMain.ColumnByName(grdMain.fields[iIndex].fieldname).DisplayLabel, '~', ' ', [rfReplaceAll]);
      if not empty(sLabel) then begin
        cboFilter.Items.AddObject(sLabel, grdMain.fields[iIndex]);
      end;
    end;
  end;
end;

procedure TBaseListingGUI.cmdCloseClick(Sender: TObject);
begin
  GlobalEvents.Notify(Self, GEVENT_ListClosed);
  Self.Close;
end;

function TBaseListingGUI.isPrefSettingsForm(var forCompany: boolean): boolean;
begin
  Result := false; // only PrefSettingsListForm will override this with true
end;

procedure TBaseListingGUI.RefreshAll;
begin
  // descendants will override if required
end;
function TBaseListingGUI.Fieldgroupname(const fsfieldname:String):String;
begin
   result := TwwDbGridGuiElement(GuiPrefs.DbGridElement[grdMain]).SelectedEntryProperty(fsFieldname  ,septgroupname);
end;
function TBaseListingGUI.Fieldtotal(const fieldName: String): double;
var
  ctr:Integer;
begin
  result:=0;
  if Length(FooterCalcfields)<=0 then exit;
  for ctr:= low(FooterCalcfields) to high(FooterCalcfields) do
    if sameText(FooterCalcfields[ctr].FieldName , fieldname) then begin
      Result := FooterCalcfields[ctr].Total;
      Exit;
    end;
end;

procedure TBaseListingGUI.RefreshDatecomments;
begin
  lblDateComments.Visible := ((FilterDateFrom < AppEnv.CompanyPrefs.SummarisedTransDate) or
                             (FilterDateTo < AppEnv.CompanyPrefs.SummarisedTransDate)) and (chkIgnoreDates.checked=False);
end;


procedure TBaseListingGUI.RefreshFCFields;

  function Fieldvisible(const fsfieldname:String):Boolean;
  begin
    result := TwwDbGridGuiElement(GuiPrefs.DbGridElement[grdMain]).SelectedEntryProperty(FieldList.text,fsFieldname  ,septvisible);
  end;

  function FieldDisplayLabel(const fsfieldname:String):String;
  begin
    result := TwwDbGridGuiElement(GuiPrefs.DbGridElement[grdMain]).SelectedEntryProperty(FieldList.text,fsFieldname  ,septDisplayLabel);
  end;

var
  ctr: integer;
  fbLoop: boolean;
  Linkedfields: array of string;
  index: integer;
  Field: TField;

begin
//  if not ReportonForeignCurrency then Exit;
  if (not ReportonForeignCurrency) and (Length(AmountFields) = 0) then exit;

  fbLoop := True;
  ctr := 0;
  if qryMain.FieldCount > 0 then
    while fbLoop do begin
      if (qryMain.fields[ctr].Tag = TAG_MASK_FC) or (qryMain.fields[ctr].Tag = TAG_MASK_DC) then qryMain.fields[ctr].Free
      else ctr := ctr + 1;
      if ctr >= qryMain.FieldCount then fbLoop := false;
    end;

  for ctr := low(AmountFields) to high(AmountFields) do begin
    Field := qryMain.FindField(AmountFields[ctr]);
    if Assigned(Field) then begin
      Field.Free;
    end;
  end;

  GuiPrefs.clearLinkedfields(qryMain);

  FieldList := TStringList.Create;
  try
    FieldList.Text := CleanfieldList.Text;

    if Length(AmountFields) = 0 then exit;

    for ctr := low(AmountFields) to high(AmountFields) do begin
      // FConReport.first;
      if qryMain.FindField(AmountFields[ctr]) = nil then begin
        with TFloatField.Create(Self) do begin
          fieldKind := fkData;
          fieldname := AmountFields[ctr];
          name := ComponentName(self, 'qryMainAmtField');
          Displayformat := AppEnv.RegionalOptions.CurrencySymbol + DOUBLE_FIELD_MASK;
          DataSet := qryMain;
          Tag := TAG_MASK_DC;
          visible := fieldvisible(AmountFields[ctr]);
        end;
      end;
    end;

    if not ReportonForeignCurrency then begin
      for ctr := low(AmountFields) to high(AmountFields) do begin
        AddGridSelectedfield(AmountFields[ctr], 10, AmountCaptions[ctr]);
//        Field := qryMain.FindField(AmountFields[ctr]);
//        if Assigned(Field) then begin
//          Field.DisplayLabel := AmountCaptions[ctr];
//          Field.DisplayWidth := 10;
//        end;
      end;
      exit;
    end;

    if FConReport.RecordCount > 0 then begin
      Setlength(Linkedfields, FConReport.RecordCount);
      try
        for ctr := low(AmountFields) to high(AmountFields) do begin
          FConReport.first;
          index := 0;
          while FConReport.eof = false do begin
            Linkedfields[index] := FConReportCode.asString + '_' + AmountFields[ctr];
            index := index + 1;
            FConReport.Next;
          end;
          GuiPrefs.AddLinkedFields(AmountFields[ctr], AmountCaptions[ctr], Linkedfields, qryMain);
        end;
      finally Finalize(Linkedfields);
      end;
    end;

    if ReportonForeignCurrency then begin
      for ctr := low(AmountFields) to high(AmountFields) do begin
        FConReport.first;
        AddGridSelectedfield(AmountFields[ctr], 10, AppEnv.RegionalOptions.ForeignExDefault, AmountCaptions[ctr]);
        while FConReport.eof = false do begin
          if Qrymain.findfield(FConReportCode.asString + '_' + AmountFields[ctr]) = nil then begin
            with TFloatField.Create(qryMain) do begin
              fieldKind := fkData;
              fieldname := FConReportCode.asString + '_' + AmountFields[ctr];
              Displayformat := FConReportSymbol.asString + DOUBLE_FIELD_MASK;
              DataSet := qryMain;
              Tag := TAG_MASK_FC;
              Visible := TField(Qrymain.findfield(AmountFields[ctr])).visible ;
            end;
          end;
          AddGridSelectedfield(FConReportCode.asString + '_' + AmountFields[ctr], 10, FConReportCode.asString, AmountCaptions[ctr]);
          FConReport.Next;
        end;
      end;
    end;
  finally
    if IsGridcustomisable and GuiPrefs.Active then begin
//      if ReportonForeignCurrency then
        GuiPrefs.DbGridElement[grdMain].UpdateGridSelected(FieldList.Text);
    end else begin
      grdMain.Selected := FieldList;
    end;
    FreeandNil(FieldList);
  end;
end;

procedure TBaseListingGUI.InitFCFields;
begin
  ReportonForeignCurrency :=
    TBaseListUtils.InitFCFields(AmountFields,AmountCaptions,Self.ClassName,Listconnection(*CommonDbLib.GetSharedMyDacConnection*));
end;

procedure TBaseListingGUI.InitFooterPanelButtons;
var
  ctr:Integer;
begin
  setlength(buttons,0);
  if btnCustomize.visible then begin Setlength(Buttons , length(Buttons)+1); Buttons[high(Buttons)] := btnCustomize.name; end;
  if cmdExport.visible    then begin Setlength(Buttons , length(Buttons)+1); Buttons[high(Buttons)] := cmdExport.name; end;
  if cmdNew.visible       then begin Setlength(Buttons , length(Buttons)+1); Buttons[high(Buttons)] := cmdNew.name; end;
  if cmdPrint.visible     then begin Setlength(Buttons , length(Buttons)+1); Buttons[high(Buttons)] := cmdPrint.name; end;
  if cmdClose.visible     then begin Setlength(Buttons , length(Buttons)+1); Buttons[high(Buttons)] := cmdClose.name; end;

  for ctr := 0 to FooterPanel.ControlCount - 1 do begin
    if FooterPanel.Controls[ctr] is TDnmspeedbutton then begin
      if TDnmspeedbutton(FooterPanel.Controls[ctr]).Visible then begin
        if  (TDnmspeedbutton(FooterPanel.Controls[ctr]) <> btnCustomize) and
            (TDnmspeedbutton(FooterPanel.Controls[ctr]) <> cmdExport) and
            (TDnmspeedbutton(FooterPanel.Controls[ctr]) <> cmdNew) and
            (TDnmspeedbutton(FooterPanel.Controls[ctr]) <> cmdPrint) and
            (TDnmspeedbutton(FooterPanel.Controls[ctr]) <> cmdClose) then begin
          Setlength(Buttons , length(Buttons)+1);
          Buttons[high(Buttons)] := TDnmspeedbutton(FooterPanel.Controls[ctr]).Name;
        end;
      end;
    end;
  end;
end;

procedure TBaseListingGUI.InitformForSearchValue(const Value: String);
begin

end;

procedure TBaseListingGUI.InitGroupfilterString(filterfieldname: String; filterValues: array of String; IsNumberFilter:Boolean =False; grp : TwwRadioGroup = nil);
var
  ctr:Integer;
begin
  if grp = nil then grp  := grpfilters;
  groupfilterstring := '';
  for ctr:= low(filterValues) to high(filterValues) do begin
    if grp.ItemIndex = ctr then begin
      if filterValues[ctr] ='' then groupfilterstring :=  ''
      else if IsNumberFilter and  IsNumber(filterValues[ctr]) then  groupfilterstring :=  filterfieldname +' = ' + filterValues[ctr]
      else  groupfilterstring :=  filterfieldname +' = ' + quotedstr(filterValues[ctr]);
      break;
    end;
  end;
end;

procedure TBaseListingGUI.InitDateFromnDateto(ParamDtfrom:String = 'DateFrom';ParamDtTo:String = 'DateTo');
begin
  if Qrymain.FindParam(ParamDtfrom) <> nil then
    Qrymain.ParamByName(ParamDtfrom).AsDateTime := filterDateFrom;
  if Qrymain.FindParam(ParamDtTo) <> nil then
    Qrymain.ParamByName(ParamDtTo).AsDateTime := filterDateTo;
end;

function TBaseListingGUI.Iscolvisible(const fieldname: String): Boolean;
begin
  result := (grdmain.columnbyname(fieldname)<> nil) and (grdmain.columnbyname(fieldname).visible);
end;

function TBaseListingGUI.ISGrpfiltersfocussed: Boolean;
begin
  try
    result :=   ((Screen.ActiveControl = grpfilters) or ( (Assigned(screen.activecontrol.Owner)) and (Screen.ActiveControl.owner = grpfilters)));
  Except
    on E:Exception do begin
      REsult := False;
    end;
  end;
end;


function TBaseListingGUI.IsLimit0selection: Boolean;
begin
  result := ((edtSearch.Text = '') and (SearchMode <> smFullList)) ;
end;

procedure TBaseListingGUI.RefreshQuery;
  procedure SetColumnControlType;
  var
    iIndex: integer;
    i: integer;
    bAlreadyAssigned: boolean;
  begin { Set the Enum datatypes to Check Boxes }

    for iIndex := 0 to qryMain.FieldCount - 1 do begin
      if (qryMain.fields[iIndex].DataType = ftString) and (qryMain.fields[iIndex].DataSize = 2) then begin
        // determine if this field ALREADY has a contol assigned
        bAlreadyAssigned := false;
        for i := 0 to grdMain.ControlType.Count - 1 do begin
          if FastFuncs.PosEx(qryMain.fields[iIndex].fieldname, grdMain.ControlType[i]) = 1 then begin
            bAlreadyAssigned := True;
          end;
        end;

        if not bAlreadyAssigned then begin
          grdMain.SetControlType(qryMain.fields[iIndex].fieldname, fctCheckBox, 'T;F');
        end;
      end;
    end;
  end; // SetColumnControlType

begin // -->RefreshQuery
  if fbNoRequery then exit;

  if ReportonForeignCurrency then
    if grdMain.TitleLines < 2 then grdMain.TitleLines := 2;

  // GuiPrefs.Active := false;
  fbRequeryInProgress := True;
  Processingcursor(True);
  try
    if not Assigned(Self.Parent) then Self.enabled := false;
    { this line couses the error when listing form embedded in another form, so do it if no parent }
    if ((SearchMode = smSearchEngineLike) or (SearchMode = smSearchEngine)) and (fSearchMode <> smFullList) then begin
      qryMain.SQL.Text := QueryManipulationObj.ModifiedSQL;
    end;

    if (edtSearch.Text = '') and (fSearchMode <> smFullList) then
      if not AnsiContainsStr(uppercase(qryMain.SQL.Text), 'LIMIT 0') then qryMain.SQL.Add('LIMIT 0');

    qryMain.Close;
    AppEnv.RegionalOptions.ChangeQuery(qryMain);
    Self.Invalidate;
    RefreshFCFields;
    try
      qryMain.open;
      fblistTobeRefreshed := False;
    except
      on e: exception do begin
        if e is EOutOfMemory then begin
          qryMain.Close;
          qryMain.SQL.Add('LIMIT 0');
          qryMain.Open;
          OnRefreshQueryOutOfMemoryError(Self);
        end
        else
          raise;
      end;
    end;

    if ListShowingchart then refreshGraph;

    ApplydisplayLabelFromPreference;
    ApplyInitialfilter;

    DoTranslateFormLanguage;
    if AutoSetColumnControlType then SetColumnControlType;
    SetGridColumns;

    PopulateFilterCombo;
    PostMessage(Self.Handle, SX_RefreshTotalsMsg, 0, 0);

    if assigned(fOnRefreshQuery)    then fOnRefreshQuery(Self);
  finally
    Self.enabled := True;
    fbRequeryInProgress := false;
    Processingcursor(False);
    // GuiPrefs.Active := True;
  end;
end;

Procedure TBaseListingGUI.OnRefreshQueryOutOfMemoryError(Sender:TObject);
begin
  MessageDlgXP_Vista('The amount of data returned by this report is greater than the amount of memory Available, please narrow down your selection.',mtInformation, [mbOK], 0);
  if chkIgnoreDates.checked then chkIgnoreDates.checked  := False;
end;
Procedure TBaseListingGUI.ApplyInitialFilter;
begin
  if fsInitialfilter <> '' then begin
    Customfilter.Addfilter(fsInitialfilter,AndFilter);
    RefreshfilterLabel;
    PreviewFilteredReport;
    fsInitialfilter:= '';
  end;

end;
Procedure TBaseListingGUI.ApplyDisplayLabelFrompreference;
begin

  if AppEnv.DefaultClass.PartColumn <> '' then begin
    if qryMain.Findfield('Product Name')  <> nil then qryMain.FieldByName('Product Name').DisplayLabel := DoTranslate(AppEnv.DefaultClass.PartColumn);
    if qryMain.Findfield('Product')       <> nil then qryMain.FieldByName('Product').DisplayLabel      := DoTranslate(AppEnv.DefaultClass.PartColumn);
    if qryMain.Findfield('ProductName')   <> nil then qryMain.FieldByName('ProductName').DisplayLabel  := DoTranslate(AppEnv.DefaultClass.PartColumn);
    if qryMain.Findfield('Partname')      <> nil then qryMain.FieldByName('Partname').DisplayLabel     := DoTranslate(AppEnv.DefaultClass.PartColumn);
  end;

  if AppEnv.DefaultClass.FirstColumn <> '' then begin
    if qryMain.Findfield('Col1')         <> nil then qryMain.FieldByName('Col1').DisplayLabel        := AppEnv.DefaultClass.FirstColumn;
    if qryMain.Findfield('FirstColumn')  <> nil then qryMain.FieldByName('FirstColumn').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
    //if qryMain.Findfield('Department')   <> nil then qryMain.FieldByName('Department').DisplayLabel  := AppEnv.DefaultClass.FirstColumn;
  end;
  if AppEnv.DefaultClass.SecondColumn <> '' then begin
    if qryMain.Findfield('col2')         <> nil then qryMain.FieldByName('Col2').DisplayLabel        := AppEnv.DefaultClass.SecondColumn;
    if qryMain.Findfield('SecondColumn') <> nil then qryMain.FieldByName('SecondColumn').DisplayLabel:= AppEnv.DefaultClass.SecondColumn;
    //if qryMain.Findfield('Type')         <> nil then qryMain.FieldByName('Type').DisplayLabel        := AppEnv.DefaultClass.SecondColumn;
  end;
  if AppEnv.DefaultClass.ThirdColumn <> '' then begin
    if qryMain.Findfield('Col3')         <> nil then qryMain.FieldByName('col3').DisplayLabel        := AppEnv.DefaultClass.ThirdColumn;
    if qryMain.Findfield('ThirdColumn')  <> nil then qryMain.FieldByName('ThirdColumn').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
    //if qryMain.Findfield('Manufacturer') <> nil then qryMain.FieldByName('Manufacturer').DisplayLabel:= AppEnv.DefaultClass.ThirdColumn;
  end;
  if AppEnv.DefaultClass.CustomerColumnName <> '' then begin
    if qryMain.Findfield('Customer Name')  <> nil then qryMain.FieldByName('Customer Name').DisplayLabel := DoTranslate(AppEnv.DefaultClass.CustomerColumnName);
    if qryMain.Findfield('CustomerName')  <> nil then qryMain.FieldByName('CustomerName').DisplayLabel := DoTranslate(AppEnv.DefaultClass.CustomerColumnName);
  end;
  if AppEnv.DefaultClass.SupplierColumnName <> '' then begin
    if qryMain.Findfield('Supplier Name')  <> nil then qryMain.FieldByName('Supplier Name').DisplayLabel := DoTranslate(AppEnv.DefaultClass.SupplierColumnName);
    if qryMain.Findfield('SupplierName')  <> nil then qryMain.FieldByName('SupplierName').DisplayLabel := DoTranslate(AppEnv.DefaultClass.SupplierColumnName);
  end;
  if AppEnv.DefaultClass.prospectcolumnName <> '' then begin
    if qryMain.Findfield('Prospect Name')  <> nil then qryMain.FieldByName('Prospect Name').DisplayLabel := DoTranslate(AppEnv.DefaultClass.prospectcolumnName);
    if qryMain.Findfield('ProspectName')  <> nil then qryMain.FieldByName('ProspectName').DisplayLabel := DoTranslate(AppEnv.DefaultClass.prospectcolumnName);
  end;
  if AppEnv.DefaultClass.AllocationBatchnoName <> '' then begin
    if qryMain.Findfield('Batchnumber')    <> nil then qryMain.FieldByName('Batchnumber').DisplayLabel        := AppEnv.DefaultClass.AllocationBatchnoName;
    if qryMain.Findfield('Batchno')  <> nil then qryMain.FieldByName('Batchno').DisplayLabel := AppEnv.DefaultClass.AllocationBatchnoName;
  end;
  if AppEnv.DefaultClass.AllocationExpiryDateName <> '' then begin
    if qryMain.Findfield('ExpiryDate')    <> nil then qryMain.FieldByName('ExpiryDate').DisplayLabel        := AppEnv.DefaultClass.AllocationExpiryDateName;
    if qryMain.Findfield('BatchExpiryDate')  <> nil then qryMain.FieldByName('BatchExpiryDate').DisplayLabel := AppEnv.DefaultClass.AllocationExpiryDateName;
  end;
  if AppEnv.DefaultClass.AllocationTruckLoadNoName <> '' then begin
    if qryMain.Findfield('TruckLoadNo')    <> nil then qryMain.FieldByName('TruckLoadNo').DisplayLabel        := AppEnv.DefaultClass.AllocationTruckLoadNoName;
    if qryMain.Findfield('BatchTruckLoadNo')  <> nil then qryMain.FieldByName('BatchTruckLoadNo').DisplayLabel := AppEnv.DefaultClass.AllocationTruckLoadNoName;
    if qryMain.Findfield('TruckLoadNumber')    <> nil then qryMain.FieldByName('TruckLoadNumber').DisplayLabel        := AppEnv.DefaultClass.AllocationTruckLoadNoName;
    if qryMain.Findfield('BatchTruckLoadNumber')  <> nil then qryMain.FieldByName('BatchTruckLoadNumber').DisplayLabel := AppEnv.DefaultClass.AllocationTruckLoadNoName;
  end;
  if AppEnv.DefaultClass.EquipmentName <> '' then begin
    if pos('Equipment' , TitleLabel.caption) >0 then TitleLabel.caption := replaceStr(TitleLabel.caption , 'Equipment' , AppEnv.DefaultClass.equipmentName);
    if qryMain.Findfield('Equipment')           <> nil then qryMain.FieldByName('Equipment').DisplayLabel           := AppEnv.DefaultClass.EquipmentName;
    if qryMain.Findfield('EquipmentName')       <> nil then qryMain.FieldByName('EquipmentNAme').DisplayLabel       := AppEnv.DefaultClass.EquipmentName+' Name';
    if qryMain.Findfield('EquipmentNumber')     <> nil then qryMain.FieldByName('EquipmentNumber').DisplayLabel     := AppEnv.DefaultClass.EquipmentName+' No';
    if qryMain.Findfield('EquipmentNo')         <> nil then qryMain.FieldByName('EquipmentNo').DisplayLabel         := AppEnv.DefaultClass.EquipmentName+' No';
    if qryMain.Findfield('Equipmentdescription')<> nil then qryMain.FieldByName('Equipmentdescription').DisplayLabel:= AppEnv.DefaultClass.EquipmentName+' description';
  end;
  if AppEnv.DefaultClass.HireName <> '' then begin
    if qryMain.Findfield('Hire')       <> nil then qryMain.FieldByName('Hire').DisplayLabel       := AppEnv.DefaultClass.HireName;
    if qryMain.Findfield('HireNumber') <> nil then qryMain.FieldByName('HireNumber').DisplayLabel := AppEnv.DefaultClass.HireName+' No';
    if qryMain.Findfield('HireNo')     <> nil then qryMain.FieldByName('HireNo').DisplayLabel     := AppEnv.DefaultClass.HireName+' No';
  end;
  if AppEnv.CompanyPrefs.ProductAttrib1Name <> '' then begin
    if qryMain.Findfield('Attrib1Sale')  <> nil then qryMain.FieldByName('Attrib1Sale').DisplayLabel := 'Sell ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  end;
  if AppEnv.CompanyPrefs.Areacolumnname <> '' then begin
    if qryMain.Findfield('Area')        <> nil then qryMain.FieldByName('Area').DisplayLabel      :=  AppEnv.CompanyPrefs.Areacolumnname;
    if qryMain.Findfield('AreaCode')    <> nil then qryMain.FieldByName('AreaCode').DisplayLabel  :=  AppEnv.CompanyPrefs.Areacolumnname + ' Code';
    if qryMain.Findfield('AreaName')    <> nil then qryMain.FieldByName('AreaName').DisplayLabel  :=  AppEnv.CompanyPrefs.Areacolumnname+' Name';
  end;

  if AppEnv.CompanyPrefs.ProductAttrib1Name <> '' then begin
    if qryMain.Findfield('Attrib1Sale')  <> nil then qryMain.FieldByName('Attrib1Sale').DisplayLabel := 'Sell ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  end;
  if AppEnv.CompanyPrefs.ProductAttrib2Name <> '' then begin
    if qryMain.Findfield('Attrib2Sale')  <> nil then qryMain.FieldByName('Attrib2Sale').DisplayLabel := 'Sell ' + AppEnv.CompanyPrefs.ProductAttrib2Name;
  end;
  if AppEnv.CompanyPrefs.ProductAttrib1Name <> '' then begin
    if qryMain.Findfield('Attrib1SaleRate')   <> nil then qryMain.FieldByName('Attrib1SaleRate').DisplayLabel := 'Sell Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  end;

  if AppEnv.CompanyPrefs.ProductAttrib1Name <> '' then begin
    if qryMain.Findfield('Attrib1Purchase')  <> nil then qryMain.FieldByName('Attrib1Purchase').DisplayLabel := 'Buy ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  end;
  if AppEnv.CompanyPrefs.ProductAttrib2Name <> '' then begin
    if qryMain.Findfield('Attrib2Purchase')  <> nil then qryMain.FieldByName('Attrib2Purchase').DisplayLabel := 'Buy ' + AppEnv.CompanyPrefs.ProductAttrib2Name;
  end;
  if AppEnv.CompanyPrefs.ProductAttrib1Name <> '' then begin
    if qryMain.Findfield('Attrib1PurchaseRate')   <> nil then qryMain.FieldByName('Attrib1PurchaseRate').DisplayLabel := 'Buy Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  end;
end;

procedure TBaseListingGUI.RefreshTotals;
var
  amountTotals: array of Double;
  totamounts: integer;
  ctr1, ctr2: integer;
  oRecPointer: TBookmark;
begin
  if showFCFooters then begin
    qryMain.DisableControls;
    oRecPointer := qryMain.GetBookmark;
    try
      totamounts := Length(AmountFields);
      if ReportonForeignCurrency then totamounts := totamounts + totamounts * FConReport.RecordCount;

      Setlength(amountTotals, totamounts);
      for ctr1 := 1 to totamounts do amountTotals[ctr1 - 1] := 0;

      if qryMain.RecordCount > 0 then begin
        qryMain.first;
        while not qryMain.eof do begin

          for ctr1 := low(AmountFields) to high(AmountFields) do begin
            amountTotals[ctr1] := amountTotals[ctr1] + qryMain.FieldByName(AmountFields[ctr1]).AsCurrency;
          end;

          if ReportonForeignCurrency then begin
            FConReport.first;
            while FConReport.eof = false do begin
              ctr2 := FConReport.RecNo * ( high(AmountFields) + 1);
              for ctr1 := low(AmountFields) to high(AmountFields) do begin
                amountTotals[ctr2 + ctr1] := amountTotals[ctr2 + ctr1] + qryMain.FieldByName(FConReportCode.asString + '_' + AmountFields[ctr1]).AsCurrency;
              end;
              FConReport.Next;
            end;
          end;
          qryMain.Next;
        end;
      end;
    finally
      qryMain.GoToBookmark(oRecPointer);
      qryMain.FreeBookmark(oRecPointer);
      qryMain.Enablecontrols;
    end;

    for ctr1 := low(AmountFields) to high(AmountFields) do begin
      grdMain.ColumnByName(AmountFields[ctr1]).FooterValue := FloatToStrF(amountTotals[ctr1], ffCurrency, 15, CurrencyRoundPlaces);
    end;
    if ReportonForeignCurrency then begin
      FConReport.first;
      while FConReport.eof = false do begin
        ctr2 := FConReport.RecNo * ( high(AmountFields) + 1);
        for ctr1 := low(AmountFields) to high(AmountFields) do begin
          grdMain.ColumnByName(FConReportCode.asString + '_' + AmountFields[ctr1]).FooterValue := FConReportSymbol.asString + FloatToStrF(amountTotals[ctr2 + ctr1], ffFixed, 15, 2);
        end;
        FConReport.Next;
      end;
    end;
    if length(amountTotals)>0 then LoadFooterValues(amountTotals);
  end;
  if assigned(fOnRefreshTotals)    then fOnRefreshTotals(Self);
end;

procedure TBaseListingGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  with Popupform do begin
    if (FormFact.Identifier <> '') and (qryMain.FindField(FormFact.Identifier) <> nil) then begin
      if IsInteger(qryMain.fields.FieldByName(FormFact.Identifier).asString) then begin
        { This Is An Attempt to handle GlobalRef's }
        KeyID := qryMain.fields.FieldByName(FormFact.Identifier).asInteger;
      end else begin
        // if ((FormFact.Identifier = 'Repair') or (FormFact.Identifier = 'ConvertFromRepair')) then begin
        // KeyID := GetRepairID(qryMain.Fields.FieldByName(FormFact.Identifier).AsString);
        // end else
        if (((FormFact.Identifier = 'ConvertFromQuote') or (FormFact.Identifier = 'ConvertFromSO'))) or
          (((fsSubsequentID = '_Invoice') or (fsSubsequentID = '_Quote') or (fsSubsequentID = '_Sales Order'))) then begin
          KeyID := TSalesBase.IDToggle(qryMain.fields.FieldByName(FormFact.Identifier).asString);
        end
        else if ((FormFact.Identifier = 'OriginalNo')) or (((fsSubsequentID = '_Purchase Order') or (fsSubsequentID = '_Return Authority'))) then begin
          KeyID := TPurchaseOrder.IDToggle(qryMain.fields.FieldByName(FormFact.Identifier).asString);
        end;
      end;
    end else  if qryMain.FindField('TransID') <> nil then begin
      Popupform.KeyID := qryMain.FieldByName('TransID').asInteger;
    end else  if qryMain.FindField('Transactionno') <> nil then begin
      Popupform.KeyID := qryMain.FieldByName('Transactionno').asInteger;
    end;
  end;
end;

Function TBaseListingGUI.DoOnGridDataSelect(Sender: TObject):boolean;
begin
      REsult := False;
      try
        if Assigned(fOnGridDataSelect) then begin
          // form is being used as a lookup grid (eg ExpressProduct) so call handler then close
          // fOnGridDataSelect(grdMain);
          fOnGridDataSelect(TwwDbGrid(Sender));
          if CloseOnRecSelect then CloseList;
          REsult := True;
        end;
      except
        on e: Exception do begin
          CloseList;
        end;
      end;
end;
Procedure TBaseListingGUI.DoPopupKeyIdNotFoundMsg;
begin
  MessageDlgXP_Vista('ID not Found for the Selection', mtWarning, [mbOK], 0);
end;
procedure TBaseListingGUI.grdMainDblClick(Sender: TObject);
var
  PopupClassName: string;
  // iPos: Integer;
  // sTemp: String;
  lState : TWindowState;
begin
  if DoingOnGrdmainDblclick then exit;

  DoingOnGrdmainDblclick := True;
  Try
      if IsMultiselecting then begin
        if DoRecselect then exit;
      end;
      inherited;
      try
      if DoOnGridDataSelect(grdmain) then exit;
      except
        on E:Exception do begin
          if devmode then
            MessageDlgXP_vista(e.message, mtWarning, [mbOK], 0);
        end;
      end;

      if (fsmodal in formstate) and not(fbAllowdrilldownwhenModal) then exit;

      if (grdMain.GetActiveField <> nil) and not empty(grdMain.GetActiveField.asString) then begin
        bmBookmark := qryMain.GetBookmark;
        { Create the appropriate form to display }
        FormFact.fieldname := grdMain.GetActiveField.fieldname;
        ProcessingCursor(True);
        enabled := false;

        try
          { The following is to prevent closing parent form that contains history list }
          PopupClassName:= FormFact.formClassName[ClassName + Chr(95) + grdMain.GetActiveField.fieldname + Trim(fsSubsequentID)];
          if SameText(Classname, PopupClassName) or (Assigned(Owner) and SameText(Owner.ClassName, PopupClassNAme)) then
            exit;

          if ClassName = 'TfrmAllowanceList' then
          begin
             if AppEnv.RegionalOptions.RegionType = rUSA then
             begin
               frmPopup := TBaseInputGUI(GetComponentByClassName('TfrmAllowancesUSA'));
             end
             else
               frmPopup := FormFact.CreateForm[ClassName + Chr(95) + grdMain.GetActiveField.fieldname + Trim(fsSubsequentID)];
          end
          // For Payroll/TaxScaleList only
          else if ((ClassName = 'TTaxScaleList') or (ClassName = 'TfrmDeductionList') ) and (Ord(AppEnv.RegionalOptions.RegionType) = 5) then
            frmPopup := FormFact.CreateForm[ClassName + Chr(49) + Chr(95) + grdMain.GetActiveField.fieldname + Trim(fsSubsequentID)]
          else
            frmPopup := FormFact.CreateForm[ClassName + Chr(95) + grdMain.GetActiveField.fieldname + Trim(fsSubsequentID)];

          if not(Assigned(frmPopup)) then CreateTransPopupform;
          Self.BringToFront;

          if Assigned(frmPopup) then begin
            AssignKeyId(frmPopup);
            with frmPopup do
              try
                if frmPopup.KeyId =0 then begin
                  DoPopupKeyIdNotFoundMsg;
                  frmPopup.Close;
                  exit;
                end;
                frmPopup.CallingClassName := Self.ClassName;

                { double click on the one field to get both the forms based on the flag }
                AttachObserver(Self);

                if frmPopup.ClassName = 'TfrmTimeSheet' then begin
                  AppContext.ContextByName['TfrmTimeSheet'].BoolVar['ReadOnly'] := True;
                  // TfrmTimeSheet(frmPopup).ReadOnlyMode := True;
                end;

                if frmPopup.accesslevel = 6 then begin // No Access
                  frmPopup.Close;
                  exit;
                end;
                BeforePopup(frmPopup);
                if not Visible then begin
                  if IsModalForm then begin
                    showmodal;
                    Exit;
                  end;

                  //FormStyle := fsMDIChild; // Shows the form in MDIChild mode.
                  // Following should be performed by the MDI stuff, but looks like sometimes smth goes wrong
                  lState := MainForm.ActiveMDIChild.WindowState;
                  FormStyle := fsMDIChild;
                  if Self.WindowState <> lState then
                    Self.WindowState := lState;
(*                  if WindowState <> lState then
                    WindowState := lState;*)
                end else begin
                  OnShow(Self);
                  // Needs this to refresh itself when a new KeyID is selected
                end;

                // if Self is TMemTransListGUI then begin
                BringToFront;
                AfterPopup(frmPopup);
                AfterPopupformshow;
                if Assigned(fOnAfterPopupFormShow) then begin
                  fOnAfterPopupFormShow(self, frmPopup);
                  frmPopup.BringToFront;
                end;
              except raise;
              end;
          end else if not (OpenListIfsubform(grdmain)) then begin
            CommonLib.MessageDlgXP_Vista('No further information available on this column. ', mtInformation, [mbOK], 0);
          end;
        finally
          enabled := True;
          ProcessingCursor(False);
        end;
        // end;
      end;
  Finally
    DoingOnGrdmainDblclick := False;
  End;
end;

procedure TBaseListingGUI.btnGridClick(Sender: TObject);
begin
  grdMain.RowHeightPercent := 100;
end;
procedure TBaseListingGUI.btnShowMultiSelectSelectionListClick(Sender: TObject);
begin
  inherited;
  if not Appenv.companyprefs.ShowMultiSelectSelectionList then begin
    Appenv.companyprefs.ShowMultiSelectSelectionList:= True;
    RefreshQuery;
    btnShowMultiSelectSelectionList.visible := not(Appenv.companyprefs.ShowMultiSelectSelectionList);
  end;
end;

function TBaseListingGUI.Exportdatafilename:String;
begin
  result := Self.Classname;
  if sametext(copy(result, 1,1) ,'T') then result := copy(result, 2, length(result));
  if sametext(copy(result, length(result)-2,3) ,'GUI') then result := copy(result, 0, length(result)-3)
  else if sametext(copy(result, length(result)-3,4) ,'LIST') then result := copy(result, 0, length(result)-4);
  result := Result +'_' + FormatDateTime('dd-mm-yy_hh-nn-ss-zzz',now);
  result := Result +'.' + AppEnv.CompanyPrefs.DataExportDefaultExtension;
  result := GetMyDocumentsDir + Result;

end;
procedure TBaseListingGUI.cmdExportClick(Sender: TObject);
var
  fsFilename:String;
begin
  fsFilename:='';
  if AppEnv.CompanyPrefs.UseERPFilenameforDataExport then begin
    fsFilename := Exportdatafilename;
  end else begin
    dlgSave.Title := 'Export - ' + Caption;
    if dlgSave.Execute then fsFilename:=dlgSave.FileName;
  end;
  if fsFilename <> '' then DoExportData(fsFilename);
end;
Procedure TBaseListingGUI.DoExportdata(const Exportfilename:String);
var
  sFileExt: string;
begin
    grdMain.ExportOptions.FileName := Exportfilename;
    grdMain.ExportOptions.TitleName := Self.Caption;
    sFileExt := ExtractFileExt(Exportfilename);
    if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.txt') then begin
      grdMain.ExportOptions.ExportType := wwgetTxt;
      grdMain.ExportOptions.Delimiter := #9;
    end
    else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.csv') then begin
      grdMain.ExportOptions.ExportType := wwgetTxt;
      grdMain.ExportOptions.Delimiter := ',';
    end
    else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.slk') then begin
      grdMain.ExportOptions.ExportType := wwgetSYLK;
    end
    else if SysUtils.SameText(FastFuncs.LowerCase(sFileExt), '.html') then begin
      grdMain.ExportOptions.ExportType := wwgetHTML;
    end else begin
      CommonLib.MessageDlgXP_Vista('Unsupported Export Format.' + #13 + #10 + '' + #13 + #10 + 'Defaulted To Text (*.TXT) Format Export.', mtWarning, [mbOK], 0);
      grdMain.ExportOptions.ExportType := wwgetTxt;
      grdMain.ExportOptions.Delimiter := #9;
    end;
    enabled := false;
    ExportDialog.Caption := 'Exporting ' + ReplaceStr(TitleLabel.Caption, '&&', '&');
    ExportDialog.Execute;
    try
      fExporting := True;
      try
        DoBeforeExport;
        try
          try
            grdMain.ExportOptions.Save;
          Except
            on E:Exception do begin
              if pos('Out of Memory' , E.message)>0 then begin
                if MessageDlgXP_Vista('List Export Caused Out of Memory Error. Do you want to Try Dataset Export?', mtConfirmation, [mbYes, mbNo], 0) = mrok then DoGridExport;
              end else MessageDlgXP_Vista('List Export Caused Out of Memory Error.'+NL+NL+E.message, mtWarning, [mbOK], 0);
            end;
          end;
        finally
          DoAfterExport(Exportfilename);
        end;
      except
        on e: exception do begin
          if e is EFCreateError then begin
            CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
          end
          else begin
            if Pos('Out of memory',e.Message) > 0 then begin
              CommonLib.MessageDlgXP_Vista('Out of memory.', mtWarning, [mbOK], 0);
            end;
          end;
        end;
//        on e: EFCreateError do begin
//          CommonLib.MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
//        end;
      end;
    finally
      enabled := True;
      ExportDialog.CloseDialog;
      fExporting := false;
    end;
end;
Procedure TBaseListingGUI.DoBeforeExport; begin end;
Procedure TBaseListingGUI.DoAfterExport(const Exportfilename:String);
begin
  if AppEnv.CompanyPrefs.OpenfileWhenDataExported then
    Fileslib.Openfile(Exportfilename, self.Handle , 'Data Exported from - ' + quotedstr(TitleLabel.caption))
  else case MessageDlgXP_Vista('List is exported to '+quotedstr(Exportfilename), mtInformation, [], 0  , nil, '' , '' , False, nil , 'Ok ,Open Folder,Open file') of
    101:Fileslib.OpenfileLoc(Exportfilename, self.Handle );
    102:Fileslib.Openfile(Exportfilename, self.Handle , 'Data Exported from - ' + quotedstr(TitleLabel.caption));
  end;
end;
procedure TBaseListingGUI.CloseList;
begin
  if fsModal in Self.FormState then ModalResult := mrOk
  else Close; // close the form
end;

procedure TBaseListingGUI.cmdPrintClick(Sender: TObject);
var
  Msg: string;
  FontsDir: string;
  function GetFontsDir: string;
  var
    idFont: pItemIdList;
    pFontsPath: PChar;
  begin
    Result := '';
    GetMem(pFontsPath, Max_Path);
    try
      // Setlength(Result, Max_Path);
      try
        SHGetSpecialFolderLocation(Application.Handle, CSIDL_Fonts, idFont);
        SHGetPathFromIDList(idFont, pFontsPath);
        Result := pFontsPath;
        Result := Trim(Result);
      except Result := '';
      end;
    finally FreeMem(pFontsPath);
    end;
  end;

begin
  try
    if Assigned(fOnGridDataSelect) and (cmdPrint.Caption =SelectCaptiononMultiSelect) then begin
      // form is being used as a lookup grid (eg ExpressProduct) so call handler then close
      if Assigned(fBaselistMultiSelectItems) then begin
        if ConfirmSelection then begin
          TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).grdMain.selectAll;
          fOnGridDataSelect(TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).grdMain);
        end;
      end else fOnGridDataSelect(grdMain);
      CloseList;
      exit;
    end;
  except
    on e: Exception do begin
      CloseList;
      exit;
    end;
  end;

  ProcessingCursor(True);
  try

    if ListShowingchart then {print the graph }
      if Printchart then exit;

    if chkAdvancedPrinting.Checked then begin
      LoadTemplate((not chkPreview.Checked), false , fbShowCancelPreviewBtninReportPreview);
    end else begin
{$RANGECHECKS OFF} // Try For Error in win2k in print Dat Range Check Error
      dlgPrint.DialogTitle := ReplaceStr(TitleLabel.Caption, '&&', '&');
      try
        FontsDir := GetFontsDir;
        if (Trim(FontsDir) = '') then begin
          MessageDlgXP_Vista('Print Failed.  The Windows Fonts Directory is not defined.', mtInformation, [mbOK], 0);
          exit;
        end;

        if not CanUseFile(WinDir + '\' + PDATGbl.cIniFileName, Msg) then begin
          Msg := 'Unable to print report: ' + #13#10 + #13#10 + Msg + #13#10 + #13#10 + '(Alternatively have the administrator log into both Windows and ERP ' +
            'then print the report again to allow creation of this file)';
          MessageDlgXP_Vista(Msg, mtInformation, [mbOK], 0);
          exit;
        end;
        CaptureFieldGetTextEvents;
        try
          dlgPrint.Print;
        finally
          ReleaseFieldGetTextEvents;
        end;
      except
        on e: Exception do begin
          CommonLib.MessageDlgXP_Vista('Printer Error !', mtWarning, [mbOK], 0);
        end;
      end;
    end;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TBaseListingGUI.grpFiltersClick(Sender: TObject);
begin
  //eg: InitGroupfilterString('Levelno' , ['1','2','3'], true);
  ApplyQueryFilter;
end;


procedure TBaseListingGUI.grpViewClick(Sender: TObject);
begin
  inherited;
  if grpView.itemindex = 1 then begin
      Panel1.visible    := true;
      PnlGraph.visible  := False;
      if assigned(graphform) then begin
        graphform.unLockChartofList(Self.ClassName);
        Freeandnil(Graphform);
      end;
  end else begin
    RefreshGraph;
  end;
  btnEditCahrt.visible := (grpView.Visible) and (grpView.itemindex = 0) and (trim(charttolaunch)<>'');
end;

procedure TBaseListingGUI.UpdateMe;
begin
  // Requery our qryMain.
  RefreshQuery;

  if Assigned(grdMain) then begin
    grdMain.UnselectAll;
    grdMain.RefreshDisplay;
  end;

  if Assigned(grdMain) and (qryMain.RecordCount <> 0) then begin
    // Is the bookmark still valid?
    try
      if qryMain.BookmarkValid(bmBookmark) then begin
        // Yes, relocate cursor to entry record.
        try { TODO -binny: gives an access violation sometimes, I think when notify is called more than once from any form. eg:copySalesordertoInvocie calls notify before and after conversion }
          if Assigned(bmBookmark) then qryMain.GoToBookmark(bmBookmark);
        except
          on e: EDatabaseError do; // Filtered Datasets Fails ??
        end;
      end;
    except
      // tempory fix to solve problem of BookmarkValid causing access violations
    end;
  end;
  // Application.ProcessMessages;
  PostMessage(Self.Handle, SX_RefreshTotalsMsg, 0, 0);
  Application.ProcessMessages;

  { See FetchComplete If Turned On }
end;

function TBaseListingGUI.UserLock: TUserLock;
begin
  if not(Assigned(fUserLock)) then
   fUserLock:= TUserLock.Create(self);
  result := fUserLock;
end;

procedure TBaseListingGUI.WriteGuiPrefExtra;
begin
  try
    if not GrpfilterSupplied then
      if (grpFilters.Visible) and (grpFilters.Items.Count > 0) then begin
        GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger := grpFilters.ItemIndex + 1;
      end;
  except

  end;
  if fbRemeberIgnoreDateSelection then begin
    if chkIgnoreDates.visible then
      if Qrymain.recordcount > 10000 then
        GuiPrefs.Node['Options.Ignoredate'].asBoolean:= False
      else
        GuiPrefs.Node['Options.Ignoredate'].asBoolean:= chkIgnoreDates.checked;
    if cboDateRange.Visible then
      GuiPrefs.Node['Options.DateRangeOption'].asInteger := cboDateRange.ItemIndex;
  end;

  if Grpview.Visible then
      GuiPrefs.Node['Options.viewOption'].asInteger:= grpview.ItemIndex;

  if chkAdvancedPrinting.Visible then
    GuiPrefs.Node['Options.AdvancePrinting'].AsBoolean := chkAdvancedPrinting.checked ;
  if pnlIncludehistory.Visible then
    GuiPrefs.Node['Options.Includehistory'].AsString              := BooleanToStr(IncludedataPriorToClosingDate);
  if pnlAdvPrinting.visible then begin
    GuiPrefs.Node['Options.Previewreport'].AsBoolean:= chkPreview.checked ;
    GuiPrefs.Node['Options.Choosereport'].AsBoolean := ChkChooseRpt.checked;
  end;

  if cboDateRange.Visible then
      GuiPrefs.Node['Options.DateRangeOption'].asInteger:= cboDateRange.ItemIndex;

  GuiPrefs.Node['Options.Searchbuttons'].AsBoolean := pnlSearchbuttons.Visible;
  GuiPrefs.Node['Options.sizeMode'].asString := iif((WindowState = wsMaximized) and (sizeMode='M') ,'M' , 'N');
  if Assigned(ClassLookupform) then ClassLookupform.Writeguiprefs;
  if Assigned(EmployeeLookupform) then EmployeeLookupform.Writeguiprefs;
  if Assigned(ProductLookupform) then ProductLookupform.Writeguiprefs;

  if fbSaveListSortOrder then
    GuiPrefs.Node['Options.IndexFieldNames'].asString := qryMain.IndexFieldNames;

  GuiPrefs.Node['Options.DefaultAllClasses'].AsInteger        := iif(AllClasses ,1, 0);
  GuiPrefs.Node['Options.DefaultAllEmployees'].AsInteger      := iif(AllEmployees ,1, 0);
  GuiPrefs.Node['Options.DEfaultSelectedClassID'].AsInteger   := SelectedClassID;
  GuiPrefs.Node['Options.DEfaultSelectedEmployeeID'].AsInteger:= SelectedEmployeeID;
  GuiPrefs.Node['Options.DEfaultSelectedProductID'].AsInteger := SelectedProductID;

  if fBaselistMultiSelectItems <>  nil then begin
    GuiPrefs.Node['Options.MultiSelectItemsWidth'].asInteger:= pnlMultiSelectList.Width;
    GuiPrefs.Node['Options.MultiSelectNameDisplayWidth'].asInteger:= TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).NamedisplayWidth;
    GuiPrefs.Node['Options.MultiSelectSortList'].asBoolean:=TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).chksortList.checked ;
  end;
  if AppEnv.CompanyPrefs.AutoLocateLastRecord and (KeyIdfieldname <> '') and (Qrymain.findfield(KeyIdfieldname)<> nil) then begin
      GuiPrefs.Node['Options.'+KeyIdfieldname].asInteger := Qrymain.fieldbyname(KeyIdfieldname).asInteger;
  end;
end;

procedure TBaseListingGUI.AddAmountField(const aFieldName: string);
var
  i: integer;
begin
  for i := Low(AmountFields) to High(AmountFields) do begin
    if SameText(AmountFields[i],aFieldNAme) then
      exit;
  end;
  SetLength(AmountFields,Length(AmountFields)+1);
  AmountFields[High(AmountFields)] := aFieldName;
end;

Procedure TBaseListingGUI.AddBasEindexfields(var Indexfields:String);
begin
  GridGuiObj.AddBasEindexfields(BaseIndexfields,Indexfields);
end;
procedure TBaseListingGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  if DisableSortoncolumtitleclick then exit;

  Processingcursor(True);
  try
    GridGuiObj.GridTitleButtonClick(Sender, AFieldname, fsSortColumnName , fsBaseIndexFieldNames , fsColumnOrderMode , fbSwapBaseIndexFieldPriority, fsSecondaryIndexFieldNames , BaseIndexfields , Doqrymainafteropen);
  finally
    Processingcursor(False);
  end;
end;

procedure TBaseListingGUI.grdMainCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
begin
  if not Assigned(Field) then exit; { just in case user switches off all fields in gui prefs }
  if (FastFuncs.PosEx(QuotedStr(Field.fieldname) + ' ASC CIS;', qryMain.IndexFieldNames) > 0) or (FastFuncs.PosEx(Field.fieldname + ' ASC CIS;', qryMain.IndexFieldNames) > 0) then begin
    TitleImageAttributes.ImageIndex := 3;
  end
  else if (FastFuncs.PosEx(QuotedStr(Field.fieldname) + ' DESC CIS;', qryMain.IndexFieldNames) > 0) or (FastFuncs.PosEx(Field.fieldname + ' DESC CIS;', qryMain.IndexFieldNames) > 0) then begin
    TitleImageAttributes.ImageIndex := 4;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;

end;
procedure TBaseListingGUI.ReadGrpfiltersPrefs;
var
  x: integer;
begin
  //if FilterOptionSupplied then exit;

  if not GrpfilterSupplied then
    if (grpFilters.Visible) and (grpFilters.Items.Count > 0) then begin
      if GuiPrefs.Node.Exists('Grpfilters') then begin
        x := GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger;
        if x > 0 then if grpFilters.Items.Count >= x then grpFilters.ItemIndex := x - 1;
      end;
    end;
end;
procedure TBaseListingGUI.ReadnApplyGuiPrefExtra;
(*var
  x: integer;
begin
  //if FilterOptionSupplied then exit;

  if not GrpfilterSupplied then
    if (grpFilters.Visible) and (grpFilters.Items.Count > 0) then begin
      if GuiPrefs.Node.Exists('Grpfilters') then begin
        x := GuiPrefs.Node['Grpfilters.ItemIndex'].asInteger;
        if x > 0 then if grpFilters.Items.Count >= x then grpFilters.ItemIndex := x - 1;
      end;
    end;*)
begin
  ReadGrpfiltersPrefs;
  if Grpview.Visible then
    if GuiPrefs.Node.Exists('Options.viewOption') then
      grpview.ItemIndex :=  GuiPrefs.Node['Options.viewOption'].asInteger;

  if chkAdvancedPrinting.visible then
    chkAdvancedPrinting.checked :=  GuiPrefs.Node['Options.AdvancePrinting'].AsBoolean;

  if pnlAdvPrinting.visible then begin
    if GuiPrefs.Node.Exists('Options.Previewreport')  then
          chkPreview.checked    :=  GuiPrefs.Node['Options.Previewreport'].AsBoolean
    else  chkPreview.checked    :=  Appenv.Employee.ShowPreview;
    ChkChooseRpt.checked  :=  GuiPrefs.Node['Options.Choosereport'].AsBoolean;
  end;

  if not fbDateRangeSupplied then begin
    if pnlIncludehistory.Visible then begin
      chkIncludehistory.checked := StrToBoolean(GuiPrefs.Node['Options.Includehistory'].AsString);
    end;
    if fbRemeberIgnoreDateSelection then begin
      if chkIgnoreDates.visible then
        if GuiPrefs.Node.Exists('Options.Ignoredate') then
          chkIgnoreDates.checked :=  GuiPrefs.Node['Options.Ignoredate'].asBoolean;
      if cboDateRange.Visible then
        if GuiPrefs.Node.Exists('Options.DateRangeOption') then begin
          cboDateRange.ItemIndex := GuiPrefs.Node['Options.DateRangeOption'].asInteger;
          cboDateRangeCloseUp(cboDateRange);
        end;
    end;
  end;
  if fbSaveListSortOrder then
    if GuiPrefs.Node.Exists('Options.IndexFieldNames')  then
      qryMain.IndexFieldNames  := GuiPrefs.Node['Options.IndexFieldNames'].asString;

  pnlSearchbuttons.Visible:=  GuiPrefs.Node['Options.Searchbuttons'].AsBoolean;
  lblSearchoptions.Visible := not(pnlSearchbuttons.Visible) and lblSearchoptions.Visible;
  if not(lblSearchoptions.Visible or pnlSearchbuttons.Visible) then
    if not NonSearchReport then
      lblSearchoptions.Visible := True;
  edtSearch.Visible := lblSearchoptions.Visible or pnlSearchbuttons.Visible;
  SizeMode := GuiPrefs.Node['Options.sizeMode'].asString;

  initchkShowEmailOptions;

end;
procedure TBaseListingGUI.Recordstyle(AFont: TFont; ABrush: TBrush; doBold: Boolean = False; DoGreenhighlight :Boolean= False; (*dohide:Boolean = False; *)Doredhighlight :boolean = False; DoGrayout:Boolean =False;DoGrayoutCell:Boolean =False);
begin
  if doBold           then begin Afont.style  := Afont.style  +[fsBold];                        end;
  if DoGreenhighlight then begin Abrush.color := GridColhighLightGreen; Afont.color := clBlack; end;
  if Doredhighlight   then begin Abrush.color := GridColhighLightRed;   Afont.color := clBlack; end;
  if DoGrayout        then begin Afont.color  := GridcolInactive;                               end;
  if DoGrayoutCell    then begin Abrush.color := GridColBrushInactive;                          end;
(*  if dohide           then begin
    Afont.color  := ABrush.color;
    if (qrymain.RecNo = trunc(qrymain.RecNo/2)*2) and (grdmain.PaintOptions.AlternatingRowColor <> clNone) then
       if  (IscurRecordSelected) then
             Afont.color  := clnavy
       else  Afont.color  := grdmain.PaintOptions.AlternatingRowColor;
  end;*)
end;
Procedure TBaseListingGUI.doBold          (AFont: TFont; ABrush: TBrush); begin  Recordstyle(Afont, ABrush, true);end;
Procedure TBaseListingGUI.DoGreenhighlight(AFont: TFont; ABrush: TBrush); begin  Recordstyle(Afont, ABrush, False, True);end;
procedure TBaseListingGUI.DoGridExport;
var
  Stream: TFileStream;
  //i: Integer;
  OutLine: string;
  //sTemp: string;
  Procedure Savetofile;
  begin
    SetLength(OutLine, Length(OutLine) );
    Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
    Stream.Write(sLineBreak, Length(sLineBreak));
  end;
begin
  qrymain.Disablecontrols;
  try
    showProgressbar(WAITMSG, Qrymain.recordcount+1);
    try
      Stream := TFileStream.Create(grdMain.ExportOptions.FileName, fmCreate);
      try

        OutLine := dsToStr(True, qrymain , ',');
        Savetofile;
        StepProgressbar;
        Qrymain.first;
        while not Qrymain.Eof do begin
          OutLine := dsToStr(False, qrymain , ',');
          Savetofile;
          Qrymain.Next;
          StepProgressbar(inttostr(qrymain.recno)+' of ' + inttostr(qrymain.recordcount));
        end;
      finally
        Stream.Free;
      end;
    finally
      HideProgressbar;
    end;
  finally
    qrymain.Enablecontrols;
  end;
end;
Function TBaseListingGUI.AlternatingRowColor:Tcolor;
begin
  REsult := grdmain.PaintOptions.AlternatingRowColor;
  if not(arrDataColumns in  grdmain.PaintOptions.AlternatingRowRegions) then Result := clnone;
end;

Procedure TBaseListingGUI.DoHide(Field: TField;State: TGridDrawState; AFont: TFont; ABrush: TBrush);
begin
    Afont.color  := ABrush.color;
    if (qrymain.RecNo = trunc(qrymain.RecNo/2)*2) and (AlternatingRowColor <> clNone) then begin
      if (gdSelected in state) or (gdFocused in state) or (gdRowSelected in state) then begin
          Afont.color  := clblue;
      end else   begin
        Afont.color  := AlternatingRowColor;
      end;
    end;
end;
Procedure TBaseListingGUI.DohighlightCell  (AFont: TFont; ABrush: TBrush);
begin
     ABrush.color := clYellow;
     Afont.color := clBlack;
     Afont.style  := Afont.style  +[fsBold];
     Afont.Size := 10;
end;
procedure TBaseListingGUI.DoHighlightColumn(Acolor: TColor; Afont:TFont; ABrush: TBrush);
begin
  Abrush.color := Acolor;
  Afont.color := clBlack;
  (*grdmain.linecolors.shadowcolor :=Acolor;
  grdmain.linecolors.Datacolor   :=Acolor;
  grdmain.linecolors.groupingcolor :=Acolor;
  grdmain.linecolors.highlightcolor:=Acolor;*)

end;

Procedure TBaseListingGUI.Doredhighlight  (AFont: TFont; ABrush: TBrush); begin  Recordstyle(Afont, ABrush, False, False, True);end;
Procedure TBaseListingGUI.DoGrayout       (AFont: TFont; ABrush: TBrush); begin  Recordstyle(Afont, ABrush, False, False, False, True);end;
Procedure TBaseListingGUI.DoGrayoutCell   (AFont: TFont; ABrush: TBrush); begin  Recordstyle(Afont, ABrush, False, False, False, False,true);end;

procedure TBaseListingGUI.GreennFont(Afont: TFont);
begin
  Afont.Color := GridColFontGreen;
  Afont.Style :=  Afont.Style - [fsBold];
end;

procedure TBaseListingGUI.GreennLight     (Afont: TFont);
begin
  Afont.Color := GridColFontOlive;
  Afont.Style :=  Afont.Style - [fsBold];
end;
Procedure TBaseListingGUI.RedFont(Afont:TFont);
begin
  Afont.Color := GridColFontRed;
end;
Procedure TBaseListingGUI.BlueFont(Afont:TFont);
begin
  Afont.Color := GridColFontBlue;
end;
Procedure TBaseListingGUI.BignBold(Afont:TFont);
begin
  Afont.Style :=  Afont.Style + [fsBold];
  Afont.Size := 10;

end;
procedure TBaseListingGUI.RednBold(Afont: TFont);
begin
  RedFont(Afont);
  Afont.Style :=  Afont.Style + [fsBold];
end;

procedure TBaseListingGUI.SetFilterString(const sValue: string);
begin
  fsFilterString := sValue;
  ApplyQueryFilter;
end;

procedure TBaseListingGUI.setFormHintOnshow(const Value: String);
begin
  TimerMsg(lblDateComments , Value)
end;

procedure TBaseListingGUI.dtFromChange(Sender: TObject);
begin
  formhintOn;
  if (dtFromLastDateTime <> 0) and (dtFromLastDateTime = dtFrom.DateTime) then exit;
  if changingFromDate then exit;
  changingFromDate := True;
  try
    if ErrorOccurred then exit;
    if DoDtFromChange(Sender) then dtFromLastDateTime := dtFrom.DateTime;
    if fbEnableClosingDateBalanceCheck then RefreshDatecomments;
  finally
    changingFromDate := false;
  end;

end;

procedure TBaseListingGUI.dtFromExit(Sender: TObject);
begin
  inherited;
  formhintOn;
end;
procedure TBaseListingGUI.formhintoff;
begin
  Self.showhint := False;
end;
procedure TBaseListingGUI.formhintOn;
begin
  Self.showhint := trim(hint)<>'';
end;
procedure TBaseListingGUI.dtToChange(Sender: TObject);
begin
  formhinton;
  if (dtToLastDateTime <> 0) and (dtToLastDateTime = dtTo.DateTime) then exit;
  if changingToDate then exit;
  changingToDate := True;
  try
    if ErrorOccurred then exit;
    // StoreCleandate('T');

    if DoDtToChange(Sender) then dtToLastDateTime := dtTo.DateTime;
    if fbEnableClosingDateBalanceCheck then RefreshDatecomments;
  finally changingToDate := false;
  end;

end;


procedure TBaseListingGUI.dtToDropDown(Sender: TObject);
begin
  inherited;
  Formhintoff;
end;

procedure TBaseListingGUI.dtToExit(Sender: TObject);
begin
  inherited;
  formhintOn;
end;

procedure TBaseListingGUI.HandleEAbortException;
begin
  { Aborting used to manage access levels - Caught the exception, but don't do anything with it }
end;


procedure TBaseListingGUI.HandleNoAccessException(const e: Exception);
begin
  { User doesn't have access to this form }
  CommonLib.MessageDlgXP_Vista(e.Message, mtInformation, [mbOK], 0);
  Self.Close;
end;

procedure TBaseListingGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
    if not Assigned(Field) then exit; { just in case user switches off all fields in gui prefs }
  if (not empty(cboFilter.Text)) and (cboFilter.ItemIndex >= 0) and (not(gdSelected in State) or not TwwDbGrid(Sender).Focused) then begin
    try
      if (FastFuncs.PosEx(uppercase(ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', '')), uppercase(TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).asString)) = 1) then begin
        ABrush.Color := HIGHLIGHTLOCATE;
      end;
    except Self.PopulateFilterCombo;
    end;
  end;
end;

procedure TBaseListingGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if (fiKeyIdtoLocate <> 0) and (KeyIdfieldname <> '') and (Qrymain.findfield(KeyIdfieldname)<> nil) then
        Qrymain.Locate(KeyIdfieldname ,fiKeyIdtoLocate , [] )
  else if AppEnv.CompanyPrefs.AutoLocateLastRecord and (KeyIdfieldname <> '') and (Qrymain.findfield(KeyIdfieldname)<> nil) and GuiPrefs.Node.Exists('Options.'+KeyIdfieldname) then begin
      Qrymain.Locate(KeyIdfieldname ,GuiPrefs.Node['Options.'+KeyIdfieldname].asInteger  , [] );
      GuiPrefs.Node['Options.'+KeyIdfieldname].asInteger := 0;
  end;

  if (Pos(Limit0, Qrymain.SQL.text) > 0) or (fbForceWaterMark) then
      grdMain.OnBeforePaint := grdMainBeforePaint;
      ShowSearchModeWaterMark;

  showReportTableMsg;
  SelectRecords;
  CheckBaselistMultiSelectItems;
end;
procedure TBaseListingGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  activeRecord := DataSet.RecNo;
  if Assigned(fOnDataScroll) then
    fOnDataScroll(DataSet);
end;

procedure TBaseListingGUI.qryMainBeforeOpen(DataSet: TDataSet);
var
  ctr:Integer;
begin
  inherited;
  for ctr:= 0 to Qrymain.FieldCount-1 do
    if Qrymain.Fields[ctr] is TFloatfield then
      if TFloatfield(Qrymain.Fields[ctr]).currency = False then
        if TFloatfield(Qrymain.Fields[ctr]).DisplayFormat ='' then
          TFloatfield(Qrymain.Fields[ctr]).DisplayFormat := FloatFieldDisplayFormat;
end;

function TBaseListingGUI.QrymainSQL: string;
var
  ctr: integer;
begin
  Result := qryMain.SQL.Text;
  if qryMain.Params.Count = 0 then exit;
  for ctr := 0 to qryMain.Params.Count - 1 do Result := ReplaceStr(Result, ':' + qryMain.Params[ctr].Name, qryMain.Params[ctr].Value);
end;

function TBaseListingGUI.getReportName: string;
begin
  try
    if fsReportName <> '' then exit;

    if ChkChooseRpt.Checked = false then begin
      fsReportName := tcdatautils.GetDefaultReport(GetReportTypeID);
      if fsReportName <> '' then exit;
    end;

    LoadReportTypes;
    if (ChkChooseRpt.visible =False) or (pnlAdvPrinting.visible =False)  then
      if dlgReportSelect.items.count =1 then begin
        fsReportName := dlgReportSelect.items[0];
        if fsReportName <> '' then exit;
      end;

    if dlgReportSelect.Execute then begin
      fsReportName := dlgReportSelect.SelectedItems.Text;

      if not empty(fsReportName) then begin
        fsReportName := TemplateNameToTemplateClassName(Trim(fsReportName));
      end else begin
        fsReportName := tcdatautils.GetDefaultReport(GetReportTypeID);
      end;
    end;

  finally
    Result := fsReportName;
  end;

end;

function TBaseListingGUI.GetReportNameForTypeName(
  const TypeName: string): string;
var
  Qry: TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(Listconnection(*CommonDbLib.GetSharedMyDacConnection*));
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

function TBaseListingGUI.getReportonForeignCurrency: boolean;
begin
  Result := (fbReportonForeignCurrency) and (fFConReport.Count > 0);
end;

procedure TBaseListingGUI.PrintDATSetID;
var
  FormId: string;

  function PadChLeftStr(const s: string; const Ch: char; const Len: integer): string;
  begin
    Result := s;
    while char_length(Result) < Len do Result := Ch + Result;
  end;

begin // > -  PrintDAT Set FormID
  FormId := IntToStr(AppEnv.AccessLevels.GetFormID(Self.ClassName));
  FormId := PadChLeftStr(FormId, '0', 3);
  // dlgprint.ReportId := '(' + FormID + '.000)';
  dlgPrint.ReportId := getreportId(FormId);
end;


function TBaseListingGUI.getreportId(const FormId: string): string;
var
  ReportId: string;
begin
  ReportId := '000' + Trim(FormId);
  ReportId := Copy(ReportId, FastFuncs.Strlength(ReportId) - 5, 3) + '.' + Copy(ReportId, FastFuncs.Strlength(ReportId) - 2, 3);
  Result := '(' + ReportId + ')';
end;

procedure TBaseListingGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  // If the form is initialising then do not
  // accept the ESCAPE key.  Otherwise we get
  // exceptions.
  if (fsCreating in Self.FormState) or (fsShowing in Self.FormState) or (not Self.enabled) then exit;

  if Key = VK_ESCAPE then begin
    if GetKeyState(VK_LBUTTON) and $8000 <> 0 then
      exit;
    if not IsSubform then begin
      Key := 0;
      Close;
      exit;
    end;
  end;

  if Screen.ActiveControl = grdMain then begin
    if Shift = [ssShift, ssCtrl] then begin
      if Chr(Key) = 'N' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, AndFilter);
        RefreshfilterLabel;
        PreviewFilteredReport;
      end else if Chr(Key) = 'C' then begin
        mnuClearFilter.Click;
      end else if Chr(Key) = 'M' then begin
        Qrymain.Last;
        mnuClearFilter.Click;
        Qrymain.Next;
      end;
    end else if Shift = [ssctrl] then begin
      if Chr(Key) = 'C' then begin
        DocopyData(nil);
      end;
    end;

    if Shift = [ssShift] then begin
      if Chr(Key) = 'N' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, AndFilter);
        RefreshfilterLabel;
      end;
      if Chr(Key) = 'P' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, AddPartial);
        RefreshfilterLabel;
      end;
      if Chr(Key) = 'O' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, OrFilter);
        RefreshfilterLabel;
      end;
      if Chr(Key) = 'F' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, OrPartial);
        RefreshfilterLabel;
      end;
      if Chr(Key) = 'E' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, AndExclude);
        RefreshfilterLabel;
      end;
      if Chr(Key) = 'X' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, OrExclude);
        RefreshfilterLabel;
      end;
      if Chr(Key) = 'R' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, AndPartialExclude);
        RefreshfilterLabel;
      end;
      if Chr(Key) = 'L' then begin
        Customfilter.Addfilter(grdMain.GetActiveField, OrPartialExclude);
        RefreshfilterLabel;
      end;
    end;
  end;
  inherited;
end;

procedure TBaseListingGUI.DateChange(var message: TMessage);
begin
  RemoveDateRangeHint;
  if fbFormOpenedOk then RefreshQuery;
end;

procedure TBaseListingGUI.grdMainColEnter(Sender: TObject);
begin
  SetSearchfield(Sender);
end;

procedure TBaseListingGUI.SetSearchfield(Sender: TObject);
var
  iIndex: integer;
  ActiveField: TField;
begin
  try
    ActiveField := TwwDbGrid(Sender).GetActiveField;
    if Assigned(ActiveField) then begin
      iIndex := cboFilter.Items.IndexOf(StringReplace(TwwDbGrid(Sender).ColumnByName(ActiveField.fieldname).DisplayLabel,'~',' ',[rfReplaceAll]));
      if iIndex <> -1 then cboFilter.ItemIndex := iIndex;
    end;
  except
  end;
end;
Function TBaseListingGUI.Listconnection:TERPConnection;
begin
  if Assigned(fPassedConnection) and (fPassedConnection.connected) then result := fPassedConnection
  else REsult := CommonDbLib.GetSharedMyDacConnection;
end;
procedure TBaseListingGUI.SetConnectionString;
var
  iIndex: integer;
begin
  for iIndex := 0 to Self.ComponentCount - 1 do begin
    if Self.Components[iIndex] is TCustomMyDataSet then begin
      with Self.Components[iIndex] as TCustomMyDataSet do begin
        Connection := Listconnection;
      end;
    end else if Self.Components[iIndex] is TMyScript then begin
      with Self.Components[iIndex] as TMyScript do begin
        Connection := Listconnection;
      end;
    end;
  end;
end;

procedure TBaseListingGUI.dlgPrintAfterOptionsLoaded(Sender: TObject; var ReportSettings: TpdtReportSettings);
  function CnvtFontStylesToInt(FontStyles: TFontStyles): integer;
  { -------------------------------------------------------------------------- }
  { Convert the FontStyles into an Integer that can be stored in the record. }
  { -------------------------------------------------------------------------- }
  var
    FontStyle: TFontStyle;
  begin
    Result := 0;
    for FontStyle := low(FontStyle) to high(FontStyle) do begin
      Result := Result shl 1;
      if FontStyle in (FontStyles) then Result := Result + 1;
    end;
  end;

begin
  with ReportSettings.RptMemo[rmRptTi] do begin
    MemoBuf := CommonDbLib.GetCompanyName + #13#10 +
    // MainForm.CompanyName +#13#10 +
      ReplaceStr(TitleLabel.Caption, '&&', '&') + ' ' + ExtraTitleInfo;
    MemoXPosPer := 0;
    MemoWidPer := 100;
    MemoAlignment := taCenter;
    MemoVisible := True;
    MemoFontName := 'Arial';
    MemoFontSize := 12;
    MemoFontStyle := CnvtFontStylesToInt([fsBold]);
  end;
  with ReportSettings.RptMemo[rmRptHdr] do begin
    if dtFrom.Visible then begin
      MemoBuf := 'Data from ' + FormatDateTime(FormatSettings.shortdateformat, dtFrom.DateTime) + ' to ' + FormatDateTime(FormatSettings.shortdateformat, dtTo.DateTime);
    end;

    if dtTo.Visible and not dtFrom.Visible then begin
      MemoBuf := 'as of ' + FormatDateTime(FormatSettings.shortdateformat, dtTo.DateTime);
    end;

    if not dtFrom.enabled and dtFrom.Visible then begin
      MemoBuf := 'as of ' + FormatDateTime(FormatSettings.shortdateformat, now());
    end;

    MemoXPosPer := 0;
    MemoWidPer := 100;
    MemoAlignment := taCenter;
    MemoVisible := True;
    MemoFontName := 'Arial';
    MemoFontSize := 6;
    MemoFontStyle := CnvtFontStylesToInt([fsItalic]);
  end;

  ReportSettings.MaxStringColWid[umTxt] := 200;
  ReportSettings.MaxMemoColWid[umTxt] := 200;
end;

function TBaseListingGUI.GetReportTypeID: integer;
begin
  Result := 0;
end;



function TBaseListingGUI.GetReportTypeIDForTypeName(
  const TypeName: string): integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Listconnection(*GetSharedMyDacConnection*));
  try
(*    qry.SQL.Add('select tt.TypeID from tbltemplatetype tt, tbltemplates t');
    qry.SQL.Add('where t.TypeID = tt.TypeID');
    qry.SQL.Add('and t.DefaultTemplate = "T"');
    qry.SQL.Add('and TypeName = ' + QuotedStr(TypeName));*)
    qry.SQL.Add('select tt.TypeID from tbltemplatetype tt');
    qry.SQL.Add('where TypeName = ' + QuotedStr(TypeName));
    qry.Open;
    if not qry.IsEmpty then
      result:= qry.FieldByName('TypeID').AsInteger
    else
      result:= 0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TBaseListingGUI.LoadReportTypes(reportTypeID:Integer =0;LoadReportTypesconditions:String='');
begin
  inherited LoadReportTypes(iif(reportTypeID=0, GetReportTypeID, reportTypeID));
end;

function TBaseListingGUI.LoadReportTypesconditions: String;
begin
  REsult := '';
end;

procedure TBaseListingGUI.LoadTemplate(const bPrint, bSave: boolean; ShowCancelPreviewBtninReportPreview :Boolean = False;doemailreport:Boolean =False; SilentEmail : boolean = false; SecretEmail : boolean=false);
begin
  try
    if ChkChooseRpt.Checked then begin
      LoadReportTypes;
      if dlgReportSelect.Execute then begin
        ReportToPrint := dlgReportSelect.SelectedItems.Text;

        if not empty(fsReportName) then begin
          fsReportName := TemplateNameToTemplateClassName(Trim(fsReportName));
        end else begin
          fsReportName := tcdatautils.GetDefaultReport(GetReportTypeID);
        end;
      end;
    end else begin
      if not empty(fsReportName) then begin
        fsReportName := TemplateNameToTemplateClassName(Trim(fsReportName));
      end else begin
        fsReportName := tcdatautils.GetDefaultReport(GetReportTypeID);
      end;
    end;

    if fsReportName = '' then exit;
    MakeTemplateSQL;
    if fbUseStringList then begin
      if doemailreport then
        Emailreport(Email_subject ,Email_Body,
                      AddressToEmail,
                      TemplateTypeName(GetReportTypeID) ,
                      SQLStrList.Text,
                      fsReportName,
                      getOutGoingFileName('', GetTemporaryTableNameSuffix+'_' +fsReportName +inttostr(Appenv.Employee.EmployeeID) , 'PDF'))
      else PrintTemplateReport(ReportToPrint, sSQL, SQLStrList, bPrint, 1, ReportJson, ShowCancelPreviewBtninReportPreview);
    end else begin
      if doemailreport then
        Emailreport(Email_subject ,Email_Body,
                      AddressToEmail,
                      TemplateTypeName(GetReportTypeID) ,
                      sSQL,
                      fsReportName,
                      getOutGoingFileName('', GetTemporaryTableNameSuffix+'_' +fsReportName +inttostr(Appenv.Employee.EmployeeID) , 'PDF'), SilentEmail, SecretEmail)
      else PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1 , ReportJson, '', ShowCancelPreviewBtninReportPreview);
    end;
    ReportToPrint := '';
  finally
      FreeReportJson;
  end;
end;
Function TBaseListingGUI.ReportJson : TJsonObject;
begin
  Result := nil;
end;
procedure TBaseListingGUI.FreeReportJson;
begin
//
end;
function TBaseListingGUI.LockTransTable(LockMsg :String): boolean;
begin
      InitMsgParams;
      PopupMsgParams.Msgcaption    :=iif(TitleLabel.caption='' ,'Locking the Transaction Table', TitleLabel.caption);
      PopupMsgParams.MsgText       := LockMsg+NL+NL+'Please Choose Cancel to abort';
      PopupMsgParams.Custombuttons :='"Cancel"' ;
      PopupMsgParams.Msg1          :='Locking the Transaction Table';
      PopupMsgParams.Msg2          :='';
      PopupMsgParams.MsgFunc       := LockingTransTable;
      PopupMsgParams.MsgHeight     :=250;
      result:= TfmMessage.MsgDlg=1;
end;
procedure TBaseListingGUI.LogGridfield1Click(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  clog(grdmain.Selected.Text);
  logtext('======================================================');
  logtext('Visible fields' );
  for ctr:= 0 to qrymain.fields.count-1 do begin
    if qrymain.fields[ctr].Visible then
      logtext(qrymain.fields[ctr].fieldname+inttostr(VK_TAB)+
              qrymain.fields[ctr].Displaylabel+inttostr(VK_TAB)+
              inttostr(qrymain.fields[ctr].DisplayWidth));
  end;
  logtext('======================================================');
  logtext('Invisible fields' );
  for ctr:= 0 to qrymain.fields.count-1 do begin
    if not(qrymain.fields[ctr].Visible) then
      logtext(qrymain.fields[ctr].fieldname+inttostr(VK_TAB)+
              qrymain.fields[ctr].Displaylabel+inttostr(VK_TAB)+
              inttostr(qrymain.fields[ctr].DisplayWidth));
  end;

end;
procedure TBaseListingGUI.MakeTemplateSQL;
begin

end;

function TBaseListingGUI.Locate(const KeyFields: string;const KeyValues: variant; Options: TLocateOptions): boolean;
begin
  try
    Result := Qrymain.Locate(KeyFields, KeyValues,Options);
  Except
    on E:Exception do begin
      REsult := False;
    end;
  end;
end;

function TBaseListingGUI.LockingTransTable:boolean;
begin
  result := Userlock.Lock('tbltransactions' ,0)
end;
Procedure TBaseListingGUI.UnlockTransTable;
begin
  UserLock.UnLock('tbltransactions' , 0);
end;

procedure TBaseListingGUI.PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject = nil; fsPrintename: String = ''; ShowCancelPreviewBtninReportPreview: boolean = false);
begin
  inherited;
  if  ReportName = '' then begin
    MessageDlgXP_vista('The report template to print is blank. Please contact ERP', mtWarning, [mbOK], 0);
    exit;
  end;
  PrintTemplate.ReportSQLSupplied := fbReportSQLSupplied;
  PrintTemplate.ShowCancelPreviewBtninReportPreview:=ShowCancelPreviewBtninReportPreview;
  PrintTemplate.PrintTemplateReport(ReportName, SQLPortion, DoPrint, Copies, nil, TemplateFilter, MasterDetailLink , fsPrintename );
end;

procedure TBaseListingGUI.PrintTemplateReport(const ReportName, SQLPortion: string; const SQLStringList: TStringList; const DoPrint: boolean; const Copies: integer;
  MasterDetailLink: TJsonObject = nil; ShowCancelPreviewBtninReportPreview :Boolean = False);
begin
  if not empty(ReportName) then begin
    PrintTemplate.ReportSQLSupplied := fbReportSQLSupplied;
    PrintTemplate.ShowCancelPreviewBtninReportPreview:=ShowCancelPreviewBtninReportPreview;
    PrintTemplate.PrintTemplateReport(ReportName, SQLStringList.Text, DoPrint, Copies, nil, '', MasterDetailLink);
  end;
end;

function TBaseListingGUI.TablestoSync: string;
begin
  Result := '';
end;

function TBaseListingGUI.TemplateNameToTemplateClassName(const TemplateName: string): string;
begin
  REsult := commonlib.TemplateToTemplClass(TemplateName);
end;

procedure TBaseListingGUI.timerdateCommentsTimer(Sender: TObject);
begin
  inherited;
  timerdateComments.enabled := false;
end;

function TBaseListingGUI.DoEmailIfToBeEmailed:boolean;
begin
  Result:= False;
  try
    if AddresstoEmail <> '' then begin
      //Emailreport('' , '' , AddressToEmail, TemplateTypeName(GetReportTypeID), SQL)
      LoadTemplate(False, False , False, true);
      Result:= True;
    end;
  finally
    AddresstoEmail :='';
  end;
end;


procedure TBaseListingGUI.chkAdvancedPrintingClick(Sender: TObject);
begin
  pnlAdvPrinting.Visible := chkAdvancedPrinting.Checked;
  InvalidateComponents(Self);
end;

procedure TBaseListingGUI.pnlHeaderDblClick(Sender: TObject);
begin
  if (GetKeyState(VK_CONTROL) < 0) and (GetKeyState(VK_SHIFT) < 0) then begin
    lblTimeLabel.Visible := True;
    lblTime.Visible := True;
  end;
end;

procedure TBaseListingGUI.pnlSearchbuttonsDblClick(Sender: TObject);
begin
  inherited;
  ToggleSearchOptions;
end;
Function TBaseListingGUI.SearchModeToStr(const Value: TBaseListingSearchMode):String;
begin
       if value = smNone              then result := 'smNone'
  else if value = smFullList          then result := 'smFullList'
  else if value = smSearchEngine      then result := 'smSearchEngine'
  else if value = smSearchEngineLike  then result := 'smSearchEngineLike'
  else result := 'smFullList';
end;
procedure TBaseListingGUI.SetSearchMode(const Value: TBaseListingSearchMode);
begin
  if (fSearchMode = Value) { or (not EnableWebSearch) } then exit;
  fSearchMode := Value;
  if Assigned(GuiPrefs) and GuiPrefs.Active then begin
    case Value of
      smNone: GuiPrefs.Node['SearchMode.type'].asString := '';
      smFullList: GuiPrefs.Node['SearchMode.type'].asString := 'Full';
      smSearchEngine: GuiPrefs.Node['SearchMode.type'].asString := 'StartsWith';
      smSearchEngineLike: GuiPrefs.Node['SearchMode.type'].asString := 'Like';
    end;
  end;

  Processingcursor(True);
  try
    if fSearchMode = smFullList then begin
      if fbEnableWebSearch then begin
        if IsSubform then  begin
          if NonSearchMode then lblSearchoptions.Caption := CAP_SEARCH_NON_SEARCH_SHORT
          else lblSearchoptions.Caption := CAP_SEARCH_F5_SHORT;
        end
        else begin
          if NonSearchMode then lblSearchoptions.Caption := CAP_SEARCH_NON_SEARCH
          else lblSearchoptions.Caption := CAP_SEARCH_F5;
        end;
      end
      else lblSearchoptions.Caption := 'Search Text';
      qryMain.SQL.Text := QueryManipulationObj.OriginalSQL;
    end
    else if (fSearchMode = smSearchEngine) or (fSearchMode = smSearchEngineLike) then begin
      if fSearchMode = smSearchEngine then begin
        if IsSubform then
          lblSearchoptions.Caption := CAP_SEARCH_F6_SHORT
        else
          lblSearchoptions.Caption := CAP_SEARCH_F6;
      end
      else if fSearchMode = smSearchEngineLike then begin
        if IsSubform then
          lblSearchoptions.Caption := CAP_SEARCH_F7_SHORT
        else
          lblSearchoptions.Caption := CAP_SEARCH_F7;
      end;

      RefreshOrignalSQL;
      if cboFilter.Items.Count > 0 then RemoveInvalidFilterComboItems(QueryManipulationObj.InVaildFilterItems);
    end;
    if qryMain.Active then RefreshQuery;
  finally
    Processingcursor(False);
  end;
  cboFilter.ItemIndex := 0;
end;
procedure TBaseListingGUI.SetSelectedProductID(const Value: Integer);
begin
  if IsSubform then
  else if not Assigned(ProductLookupform)       then
  else   ProductLookupform.LookupID := Value ;
end;
procedure TBaseListingGUI.setSelectedClassID(const Value: Integer);
begin
  if IsSubform then
  else if not Assigned(ClassLookupform)       then
  else   ClassLookupform.LookupID := Value ;
end;

procedure TBaseListingGUI.setSelectionOptions(const Value: TSelectionOptions);
begin
  fSelectionOption := Value;
  if Value = soNone then begin
    if assigned(ClassLookupform)    then ClassLookupform.HideInstance;
    if assigned(EmployeeLookupform) then EmployeeLookupform.HideInstance;
    if assigned(ProductLookupform)  then ProductLookupform.HideInstance;
    exit;
  end;
  if (Value = soClass) or (Value = soClassnProduct) then begin
    ClassLookupform := TFmClassLookup.MakeInstance(Self, HeaderPanel, 0,pnlHeader.top , pnlHeader.height , alleft, GuiPrefs, OnClassSelection, DefaultAllClasses , DEfaultSelectedClassID);
    SelectionOptionQry(ClassLookupform , ClassLookupform.cboQry);
  end;
  if Value = soEmployee then begin
    EmployeeLookupform := TFmEmployeeLookup.MakeInstance(Self, HeaderPanel, 0,pnlHeader.top , pnlHeader.height , alleft, GuiPrefs, OnEmployeeSelection, DefaultAllEmployees , DEfaultSelectedEmployeeID);
    SelectionOptionQry(EmployeeLookupform , EmployeeLookupform.cboQry);
  end;
  if (Value = soProduct) or (Value = soClassnProduct) then begin
    ProductLookupform := TFmProductLookup.MakeInstance(Self, HeaderPanel, 0,pnlHeader.top , pnlHeader.height , alleft, GuiPrefs, OnProductSelection, DefaultAllProducts , DEfaultSelectedProductID);
    SelectionOptionQry(ProductLookupform , ProductLookupform.cboQry);
  end;

  SetSelectionOptionsFor(Value);
end;

procedure TBaseListingGUI.edtSearchKeyPress(Sender: TObject; var Key: char);
begin
//
end;
procedure TBaseListingGUI.FocusGrid;
begin
  grdMain.SetActiveRow(0);
  SetControlFocus(grdMain);
end;
procedure TBaseListingGUI.initqrymainsql;
begin
  // if qrymain.sql is dynamically created at run time, set it here as this is called before GOSEARCH process for F5/F6/F7
end;
procedure TBaseListingGUI.GoSearch;
var
  sFieldName: string;
  cboFilterPosition: integer;
  tmpSearchText, prefix: string;
begin
  if Searching  then exit;

  Searching :=true;
  try
    Processingcursor(True);
    try
      inherited;
      initqrymainsql;
      if (edtSearch.Text <> '') and (cboFilter.Text <> '') then begin
        sFieldName := TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).fieldname;
        tmpSearchText := edtSearch.Text;

        // Add Wildcard if Not Used
        if SearchMode = smSearchEngineLike then prefix := '%'
        else prefix := '';

        if not(AnsiContainsText(tmpSearchText, '*') or AnsiContainsText(tmpSearchText, '%')) and not empty(tmpSearchText) then begin
          tmpSearchText := prefix + Trim(tmpSearchText) + '%';
        end;

        if not empty(WhereClause) then
          QueryManipulationObj.ProcessSearch('`' + sFieldName + '`', ReplaceStr(tmpSearchText, '*', '%'), WhereClause)
        else
          QueryManipulationObj.ProcessSearch('`' + sFieldName + '`', ReplaceStr(tmpSearchText, '*', '%'));

        cboFilterPosition := cboFilter.ItemIndex;
        RefreshQuery;
        QueryManipulationObj.ClearSearchcondition;
        FocusGrid;
        try cboFilter.ItemIndex := cboFilterPosition;
        except
        end;
        if UseSortinSearch then qryMain.IndexFieldNames := QuotedStr(sFieldName) + ' ASC CIS';
        dsMain.DataSet.Locate(sFieldName, ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', ''), [loCaseInsensitive, loPartialKey]);
      end;
      Processingcursor(False);
    except
      Processingcursor(False);
    end;
  finally
    Searching :=False;
  end;
end;

procedure TBaseListingGUI.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);

function ChecknshowNonSearchModeMsg:Boolean;
begin
  result := False;
  if not fbEnableWebSearch then
    if ((edtSearch.Focused) and (Key = VK_RETURN)) Or
       (Key = VK_F5) or
       (Key = VK_F6) or
       (Key = VK_F7) then begin
          Listtimermsg('This List is Non-Searchable');
          Result := True;
    end;
end;
begin
  if ChecknshowNonSearchModeMsg then exit;

  if fbEnableWebSearch then begin
    if (edtSearch.Focused) and (Key = VK_RETURN) then begin
      case fSearchMode of
        smSearchEngineLike: Key := VK_F7;
        smSearchEngine: Key := VK_F6;
      else exit;
      end; { case }
    end;
    if (Key = VK_F7) and (NonSearchMode = false) then begin
      fSearchMode := smSearchEngineLike;

      if fUseTmpTable then RefreshOrignalSQL;

      if IsSubform then
        lblSearchoptions.Caption := CAP_SEARCH_F7_SHORT
      else
        lblSearchoptions.Caption := CAP_SEARCH_F7;
      GuiPrefs.Node['SearchMode.type'].asString := 'Like';
      GoSearch;
      exit;
    end;
    if (Key = VK_F6) and (NonSearchMode = false) then begin
      fSearchMode := smSearchEngine;

      if fUseTmpTable then RefreshOrignalSQL;

      if IsSubform then
        lblSearchoptions.Caption := CAP_SEARCH_F6_SHORT
      else
        lblSearchoptions.Caption := CAP_SEARCH_F6;
      GuiPrefs.Node['SearchMode.type'].asString := 'StartsWith';
      GoSearch;
      exit;
    end;
    if (Key = VK_F5) then begin
      SearchMode := smFullList;
      if IsSubform then
        lblSearchoptions.Caption := CAP_SEARCH_F5_SHORT
      else
        lblSearchoptions.Caption := CAP_SEARCH_F5;
      GuiPrefs.Node['SearchMode.type'].asString := 'Full';
      RefreshQuery;
      exit;
    end;
  end;
  if Key = vk_f8 then begin
        DoFormSize(true);
  end;

  if (Shift = [ssCtrl]) then begin
    // Are we to activate the From Date Control?
    if Chr(Key) = 'F' then begin
      SetControlFocus(dtFrom);
      exit;
    end;

    // Are we to toggle the status of the 'Advanced Printing' checkbox?
    if Chr(Key) = 'P' then begin
      chkAdvancedPrinting.Checked := chkAdvancedPrinting.Checked xor True;
      exit;
    end;

    // Are we to toggle the status of the 'Advanced Printing' checkbox?
    if Chr(Key) = 'W' then begin
      chkPreview.Checked := chkPreview.Checked xor True;
      exit;
    end;

    // Are we to activate the To Date Control?
    if Chr(Key) = 'T' then begin
      SetControlFocus(dtTo);
      exit;
    end;

    // Are we to activate the search column dropdown control?
    if Chr(Key) = 'M' then begin
      cboFilter.SelectAll;
      SetControlFocus(cboFilter);
      cboFilter.DroppedDown := True;
      exit;
    end;

    // Are we to toggle the status of the Choose Template
    if Chr(Key) = 'T' then begin
      ChkChooseRpt.Checked := ChkChooseRpt.Checked xor True;
    end;

    // Are we to activate the Text Search Control?
    if Chr(Key) = 'S' then begin
      edtSearch.SelectAll;
      SetControlFocus(edtSearch);
      exit;
    end;
    if Chr(Key) = 'A' then begin
      SelectAll;
    end;
  end;
  inherited;
end;

procedure TBaseListingGUI.FormResize(Sender: TObject);
begin
  inherited;
  if IsSubform then begin
    if IsFormshown =False then exit;
    if not(IsSubformParentShown) then exit;
    if IsSubformParentClosing then exit;
    HeaderPanel.visible := false;
    DisableForm;
    try
      if fbResizeCompsforPanel then exit;
      fbResizeCompsforPanel := true;
      try
        ResizeCompsforPanel;
      finally
        fbResizeCompsforPanel := False;
      end;
    finally
      HeaderPanel.visible := true;
      Enableform;
    end;
  end else begin
      if WindowState = wsMaximized then
        sizeMode:='M'
      else begin
        sizeMode:='N';
        InitList;
      end;
  end;
end;

procedure TBaseListingGUI.grdMainKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  // dont accept if form is starting up.
  if bFormStarting then exit;

  // Was the return key pressed? if so,
  // then show selected record.
//  if Key = VK_RETURN then begin
  if (Shift = [ssCtrl] ) and (Key = VK_RETURN) and IsMultiselecting then begin
    // Show Current Selected Record.
    // grdMainDblClick(Sender);
    if DoRecSelect then begin
      Key := 0;
      exit;
    end;
  end else if (Key = VK_RETURN)  then begin
    grdMain.OnDblClick(grdMain);
    Key := 0;
    exit;
  end;
end;
procedure TBaseListingGUI.FormActivate(Sender: TObject);
begin
  if ErrorOccurred then exit;

  // Do we have any visible records to start with.
  if (qryMain.Active) and (qryMain.RecordCount > 0) and (fbOnshowHint = false) then begin
    /// /////////////////////////////////////////////////////////
    // We need to be sure before setting focus to grdMain that
    // it is currently enabled and it must be visible otherwise
    // we cant and we will end up raising an exception.
    /// /////////////////////////////////////////////////////////
    if (grdMain.enabled) and (grdMain.Visible) and not(fbSelectioninPopup) then begin
      // Set the grid control to focus on first
      // record available.
      SetControlFocus(grdMain);
    end;
  end;
  inherited;
  // State that form initialisation has been completed.
  bFormStarting := false;
  showReportTableMsg;

end;

procedure TBaseListingGUI.edtSearchExit(Sender: TObject);
begin
  // Are we initialising our form, if so then exit straight out.
  if ErrorOccurred then exit;
  if (bFormStarting) then exit;
  // Are we requesting to not process this event?
  if (bDontFireExitEvent) then begin
    // Yes, Disable this status flag.
    bDontFireExitEvent := false;
    // Exit event.
    exit;
  end;

  if edtSearch.Text <> '' then begin
    // Was there any records found?
    if qryMain.RecordCount > 1 then begin
      // Yes, set the first record active.
      SetControlFocus(grdMain);
      // Exit
      exit;
    end;
    // else if qryMain.RecordCount = 1 then begin
    // bDontFireExitEvent := true;
    // // Open the record.
    // grdMainDblClick(Self);
    // bDontFireExitEvent := false;
    // // Exit
    // Exit;
    // end;
  end;
end;

procedure TBaseListingGUI.actMergeUpdate(Sender: TObject);
begin
  actMerge.enabled := SelectedRecords > 1;
end;

procedure TBaseListingGUI.actMergeExecute(Sender: TObject);
begin
  { Descendant use to perform Merge. (Don't Remove) }
end;

procedure TBaseListingGUI.RefreshTotalsMsg(var message: TMessage);
begin
  try
    if qryMain.Active then begin
      Self.lblTotal.Caption := IntToStr(qryMain.RecordCount);
      Self.RefreshTotals;
    end;
  except
  end;
end;

procedure TBaseListingGUI.CloseModalTimerTimer(Sender: TObject);
begin
  CloseModalTimer.enabled := false;
  Self.ModalResult := mrCancel;
  Self.Close;
end;

procedure TBaseListingGUI.cboDateRangeCloseUp(Sender: TObject);
const
  // Date Range Combo values
  TODAY = 0;
  YESTEDAY = 1;
  LAST_WEEK = 2;
  LAST_MONTH = 3;
  LAST_QUARTER = 4;
  LAST_12_MONTHS = 5;
  PREV_WEEK = 6;
  PREV_MONTH = 7;
  PREV_QUARTER = 8;
  PREV_FINANCIAL_YEAR = 9;
  THIS_WEEK = 10;
  THIS_MONTH = 11;
  THIS_QUARTER = 12;
  THIS_FINANCIAL_YEAR = 13;
  THIS_FINANCIAL_YEAR_TO_DATE = 14;
  TOMORROW =15;
  NEXT_WEEK =16;
  NEXT_MONTH = 17;
  NEXT_QUARTER = 18;
  NEXT_12_MONTHS = 19;


  // from 1st of [Fiscal Year] ()Preference in account tab) to Today

var
  MonthsList: TStringList;
  FiscalYearStartMonthIndex: integer;
  dt1, dt2:Tdatetime;

  function StartOfTheQuarter(dtDate: TDateTime): TDateTime;
  var
    iMonth: integer;
    iQuater: integer;
    iStartMonth: integer;
  begin
    iMonth := MonthOfTheYear(dtDate);
    iQuater := (iMonth - 1) div 3 + 1;
    iStartMonth := (iQuater - 1) * 3 + 1;
    Result := StartOfTheMonth(RecodeMonth(dtDate, iStartMonth));
  end;

begin
  if ErrorOccurred then exit;
  inherited;
  changingFromDate :=  True;
  changingToDate:=  True;
  try
    dt1:= filterdateFrom;
    dt2:= FilterDateto;
    try
        MonthsList := TStringList.Create;
        MonthsList.Add('January');
        MonthsList.Add('February');
        MonthsList.Add('March');
        MonthsList.Add('April');
        MonthsList.Add('May');
        MonthsList.Add('June');
        MonthsList.Add('July');
        MonthsList.Add('August');
        MonthsList.Add('September');
        MonthsList.Add('October');
        MonthsList.Add('November');
        MonthsList.Add('December');
        FiscalYearStartMonthIndex := MonthsList.IndexOf(AppEnv.CompanyPrefs.FiscalYearStarts);

        case cboDateRange.ItemIndex of
          TODAY: begin
              dtFrom.Date := Date;
              dtTo.Date := Date;
            end;
          YESTEDAY: begin
              dtFrom.Date := IncDay(Date, -1);
              dtTo.Date := IncDay(Date, -1);
            end;
          LAST_WEEK: begin
              dtFrom.Date := IncDay(Date, -6);
              dtTo.Date := Date;
            end;
          LAST_MONTH: begin
              dtFrom.Date := IncDay(IncMonth(Date, -1));
              dtTo.Date := Date;
            end;
          LAST_QUARTER: begin
              dtFrom.Date := IncDay(IncMonth(Date, -3));
              dtTo.Date := Date;
            end;
          LAST_12_MONTHS: begin
              dtFrom.Date := IncDay(IncYear(Date, -1));
              dtTo.Date := Date;
            end;
          PREV_WEEK: begin
              dtFrom.Date := IncWeek(StartOfTheWeek(Date), -1);
              dtTo.Date := IncDay(dtFrom.Date, 6);
            end;
          PREV_MONTH: begin
              dtFrom.Date := IncMonth(StartOfTheMonth(Date), -1);
              dtTo.Date := IncDay(IncMonth(dtFrom.Date), -1);
            end;
          PREV_QUARTER: begin
              dtFrom.Date := IncMonth(StartOfTheQuarter(Date), -3);
              dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), -1);
            end;
          PREV_FINANCIAL_YEAR: begin
              if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
                dtFrom.Date := IncYear(IncMonth(StartOfTheYear(IncYear(Date, -1)), FiscalYearStartMonthIndex), -1);
              end else begin
                dtFrom.Date := IncYear(IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex), -1);
              end;
              dtTo.Date := IncDay(IncYear(dtFrom.Date), -1);
            end;
          THIS_WEEK: begin
              dtFrom.Date := StartOfTheWeek(Date);
              dtTo.Date := IncDay(dtFrom.Date, 6);
            end;
          THIS_MONTH: begin
              dtFrom.Date := StartOfTheMonth(Date);
              dtTo.Date := IncDay(IncMonth(dtFrom.Date), -1);
            end;
          THIS_QUARTER: begin
              dtFrom.Date := StartOfTheQuarter(Date);
              dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), -1);
            end;
          THIS_FINANCIAL_YEAR: begin
              if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
                dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, -1)), FiscalYearStartMonthIndex);
              end else begin
                dtFrom.Date := IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex);
              end;
              dtTo.Date := IncDay(IncYear(dtFrom.Date), -1);
            end;
          THIS_FINANCIAL_YEAR_TO_DATE: begin
              if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
                dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, -1)), FiscalYearStartMonthIndex);
              end else begin
                dtFrom.Date := IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex);
              end;
              dtTo.Date := DateUtils.TODAY;
            end;
        else if fbHasfutureDateRangeOptions then begin
            case cboDateRange.ItemIndex of
                TOMORROW: begin
                    dtFrom.Date := IncDay(Date, +1);
                    dtTo.Date := IncDay(Date, +1);
                  end;
                NEXT_WEEK : begin
                    dtFrom.Date := Date;
                    dtTo.Date := IncDay(Date, +6);
                  end;
                NEXT_MONTH : begin
                    dtFrom.Date := Date;
                    dtTo.Date := IncMonth(Date, +1);
                  end;
                NEXT_QUARTER :begin
                    dtFrom.Date := Date;
                    dtTo.Date := IncMonth(Date, +3);
                  end;
                NEXT_12_MONTHS :begin
                    dtFrom.Date := Date;
                    dtTo.Date := IncYear(Date, +1);
                  end;
            end;
          end;
        end;
      finally
        if (dt1 <> filterDatefrom) or (dt2 <> filterDateTo) then begin
            // dtFromChange(nil);
            //dtToChange(nil);
            PostMessage(Self.Handle, SX_DatechangeMsg, 0, 0);
        end;
      end;
  finally
    changingFromDate :=  False;
    changingToDate:=  False;
  end;
end;


procedure TBaseListingGUI.changeDates(Sender: TObject);
begin
  inherited;
   if not devmode then exit;
   with TfmListdates.create(Self) do try
     Showmodal;
   finally
     Free;
   end;
end;

procedure TBaseListingGUI.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  actRefreshQry.enabled := false;
  try
    Application.ProcessMessages;
    Self.RefreshQuery;
  finally actRefreshQry.enabled := True;
  end;
end;

procedure TBaseListingGUI.actRefreshQryUpdate(Sender: TObject);
begin
  inherited;
  if fbNoRequeryBtn then actRefreshQry.enabled := false
  else actRefreshQry.enabled := (not fbRequeryInProgress);

  Application.ProcessMessages;
end;

procedure TBaseListingGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if Assigned(fOnNewbtnClick) then begin
    fOnNewbtnClick(Sender);
    exit;
  end;
end;

function TBaseListingGUI.IsSelected(IDFieldNAme: String; SelectedIDList:TIntegerList): Boolean;
begin
  Result := False;
  try
    if Qrymain.findfield(IDFieldNAme) = nil then exit;
    if Qrymain.findfield(IDFieldNAme).AsInteger =0 then exit;
    if SelectedIDList.count =0 then exit;

    Result := SelectedIDList.Indexof(Qrymain.findfield(IDFieldNAme).AsInteger)>=0;

  Except
    // kill the exception
  end;

end;
function TBaseListingGUI.IsSubformParentClosing: boolean;
begin
  REsult := True;
  if not(IsSubform) then exit;
  if Assigned(Parent.owner) then
    if Parent.owner is TfrmBaseGUI then
      REsult := TfrmBaseGUI(Parent.owner).Isclosing;

end;

function TBaseListingGUI.IsSubformParentShown: boolean;
begin
  REsult := True;
  if not(IsSubform) then exit;
  if Assigned(Parent.owner) then
    if Parent.owner is TfrmBaseGUI then
      REsult := TfrmBaseGUI(Parent.owner).IsFormshown;

end;
function TBaseListingGUI.IsSubform: boolean;
begin
  Result := false;
  if Assigned(Parent) then
    if (Parent is TDNMPanel) or (Parent is TScrollbox) then Result := True;
end;

function TBaseListingGUI.isTochooseTemplate: Boolean;
begin
  REsult := False;
  if not pnlAdvPrinting.visible then exit;
  if not ChkChooseRpt.visible then exit;
  if not ChkChooseRpt.enabled then exit;
  result := ChkChooseRpt.checked;
end;

function TBaseListingGUI.isvalidtoSelect: Boolean;
begin
  REsult:= true;
end;

procedure TBaseListingGUI.IterateList(CallbackProc: TDatasetIterateCallbackProc);
var
  bm: TBookmark;
  AbortIteration: boolean;
begin
  if not grdMain.DataSource.DataSet.Active then exit;
  with grdMain.DataSource.DataSet do begin
    bm := GetBookmark;
    try
      DisableControls;
      AbortIteration := false;
      first;
      while not eof do begin
        CallbackProc(grdMain.DataSource.DataSet, AbortIteration);
        if AbortIteration then Break;
        Next;
      end;
    finally
      GoToBookmark(bm);
      FreeBookmark(bm);
      Enablecontrols;
    end;
  end;
end;

procedure TBaseListingGUI.SetCustomReportName(const Value: string);
begin
  fCustomReportName := Value;

  GuiPrefs.prefsname := fCustomReportName;

  { Force to reload as the preference is different for the Custom report }
  GuiPrefs.Active := false;
  GuiPrefs.Active := True;

  Caption := fCustomReportName;
  // if not fbIgnoreAccessLevels then Caption := Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
  TitleLabel.Caption := fCustomReportName;
end;


procedure TBaseListingGUI.SetAppendFilter(const Value: string);
begin
  fsAppendFilter := Value;
  ApplyQueryFilter;
end;

procedure TBaseListingGUI.setBaseIndexFieldNames(const Value: string);
begin
  fsBaseIndexFieldNames := Value;
end;

procedure TBaseListingGUI.Setcharttolaunch(const Value: string);
begin
if value <> '' then begin
  fscharttolaunch := Value;
  grpView.hint := 'Chart : ' +charttolaunch;
  grpView.showhint := True;
end;
end;
Procedure TBaseListingGUI.ResizesubformGrid;
  Procedure DoResizesubformGrid(aParentObj :TWinControl);
  begin
    if aParentObj = nil then exit;
    DoResizesubformGrid(aParentObj.Parent);
    if assigned(aParentObj) and (aParentObj is TPanel) and (TPanel(aParentObj).Align =alclient) then begin
      TPanel(aParentObj).Align := alnone;
      TPanel(aParentObj).Left:= 0;
      TPanel(aParentObj).top := 0;
      TPanel(aParentObj).width := 10;
      TPanel(aParentObj).height := 10;
      TPanel(aParentObj).Align := Alclient;
    end else if assigned(aParentObj) and (aParentObj is TDnMPanel) and (TDnMPanel(aParentObj).Align =alclient) then begin
      TDnMPanel(aParentObj).Align := alnone;
      TDnMPanel(aParentObj).Left:= 0;
      TDnMPanel(aParentObj).top := 0;
      TDnMPanel(aParentObj).width := 10;
      TDnMPanel(aParentObj).height := 10;
      TDnMPanel(aParentObj).Align := Alclient;
    end else if assigned(aParentObj) and (aParentObj is TForm) and (TForm(aParentObj).Align =alclient) then begin
      TForm(aParentObj).Align := alnone;
      TForm(aParentObj).Left:= 0;
      TForm(aParentObj).top := 0;
      TForm(aParentObj).width := 10;
      TForm(aParentObj).height := 10;
      TForm(aParentObj).Align := Alclient;
    end else begin
      Exit;
    end;
  end;
begin
if issubform then begin
   {resize grid and its parent panels to get the scroll bars for grid}
    DoResizesubformGrid(grdMain.parent);
    grdMain.Align := alnone;
    grdmain.showhorzscrollbar := True;
    grdmain.showvertscrollbar := True;
    grdMain.Left:= 0;
    grdMain.top := 0;
    grdMain.width := 10;
    grdMain.height := 10;
    grdMain.Align := Alclient;
  end;
end;
procedure TBaseListingGUI.AfterformShow;
begin
  inherited;
  InitList;
  if DoEmailIfToBeEmailed then begin
    self.Close;
    Exit;
  end;
  resizesubformgrid;
end;

procedure TBaseListingGUI.AfterPopup(Popupform: TComponent);
begin

end;

procedure TBaseListingGUI.ApplyQueryFilter;
var
  fs, NewFilter: string;
begin

  if Assigned(MainTable) then begin
    grdMain.UnselectAll;
    NewFilter := GroupFilterString;
    if NewFilter <> '' then NewFilter := '(' + NewFilter + ')';

    // fs := GetFilterString;
    fs := CustomFilterString;
    fs := ReplaceStr(fs, ':CurDate', QuotedStr(FormatDateTime(FormatSettings.ShortDateFormat, Date)));
    fs := ReplaceStr(fs, ':CurDateTime', QuotedStr(FormatDateTime(FormatSettings.LongDateFormat, Date)));

    if (fs <> '') and (fs <> ' ') then begin
      if (NewFilter <> '') then NewFilter := NewFilter + ' AND ';
      NewFilter := NewFilter + '(' + fs + ')';
    end;

    if (fsFilterString <> '') then begin
      if (NewFilter <> '') then NewFilter := NewFilter + ' AND ';
      NewFilter := NewFilter + '(' + fsFilterString + ')';
    end;

    if fsAppendFilter <> '' then NewFilter := NewFilter + fsAppendFilter;

    MainTable.Filtered := false;
    MainTable.Filter := '';

    if NewFilter <> '' then begin
      try
        if foNoPartialCompare in MainTable.FilterOptions then MainTable.FilterOptions := MainTable.FilterOptions - [foNoPartialCompare];
        MainTable.Filter := NewFilter;
        MainTable.Filtered := True;
      except
        on e: Exception do begin
          CommonLib.MessageDlgXP_Vista('Please review your filter and try again.' + Chr(13) + Chr(13) + 'Filter :' + MainTable.Filter, mtWarning, [mbOK], 0);
          MainTable.Filter := GroupFilterString;
          MainTable.Filtered := MainTable.Filter <> '';
        end;
      end;
    end;

    if MainTable.Active then begin
      lblTotal.Caption := IntToStr(MainTable.RecordCount);
      RefreshTotals;
    end;

    barStatus.Panels[1].Text := MainTable.Filter;
    if devmode then barStatus.hint := MainTable.Filter;
  end;
end;

procedure TBaseListingGUI.SetspecialNote(const Value: string);
begin
  lblNote.Caption := Value;
  if grdmain.Hint = '' then
    Showcontrolhint(grdmain , value);
end;
procedure TBaseListingGUI.mnuChartViewClick(Sender: TObject);
begin
  OpenChart;
end;
procedure TBaseListingGUI.OpenChart;
begin
  fListChartView:=  TListChartView.ShowChartView(grdmain ,self , fsCustomChartToView);
end;
procedure TBaseListingGUI.mnuChartNewClick(Sender: TObject);
begin
  fsCustomChartToView := '';
  OpenChart;
end;
procedure TBaseListingGUI.mnuChartListClick(Sender: TObject);
begin
  OpenERPListFormSingleselectModal('TCustomChartListGUI' , doviewcustomchart , BeforeShowCustomChartList);
end;
Procedure TBaseListingGUI.doviewcustomchart(Sender: TwwDbGrid);
begin
  try
    fsCustomChartToView := Sender.DataSource.DataSet.FieldByName('ChartName').AsString;
  Except
    // kill the exception if field not found etc.
  end;
  if fsCustomChartToView <> '' then   OpenChart;
end;
procedure TBaseListingGUI.BeforePopup(Popupform: TComponent);
begin

end;

procedure TBaseListingGUI.BeforeShowCustomChartList(Sender: TObject);
begin
    if not(Sender is TCustomChartListGUI) then exit;
    TCustomChartListGUI(Sender).Reportclassname := Self.ClassName;
end;
procedure TBaseListingGUI.PreviewFilteredReport;
begin
  if not Customfilter.ValidateFilter then exit;
  CustomFilterString := Trim(Customfilter.Filterstatement);
  ApplySpecialformfilter;
  ApplyQueryFilter;
end;

function TBaseListingGUI.getPartialString(fField: TField; Filtertype: TFiltertype): string;
begin
  Result := '';

  CustomInputBox.Buttons := [sbOK, sbCancel];
  if Filtertype in [AddPartial, OrPartial] then CustomInputBox.Caption := 'Add Partial Filter';
  if Filtertype in [AndPartialExclude, OrPartialExclude] then CustomInputBox.Caption := 'Exclude Partial Filter';
  CustomInputBox.Message := 'Enter Filter';
  CustomInputBox.DefaultString := fField.asString;
  CustomInputBox.EditBoxFont.Name := 'Arial';
  CustomInputBox.EditBoxFont.size := 9;
  CustomInputBox.EditBoxFont.Style := [];
  CustomInputBox.MessageFont.Name := 'Arial';
  CustomInputBox.MessageFont.size := 9;
  CustomInputBox.MessageFont.Style := [fsBold];
  CustomInputBox.Height := 115;
  CustomInputBox.Width := 200;
  if CustomInputBox.Execute then Result := CustomInputBox.InputResult;
end;

function TBaseListingGUI.getReportDateFrom: String;
begin
  Result := formatdatetime(FormatSettings.Shortdateformat , dateof(dtFrom.DateTime));
  if not(dtFrom.visible) then Result:= '---'
  else if chkIgnoreDates.Visible and chkIgnoreDates.Checked then Result:= '---';
end;

function TBaseListingGUI.getfilterType(Sender: TObject): TFiltertype;
var
  tempCaption: string;
  i: integer;

  function TrimText(const fCaption: string): string;
  begin
    Result := ReplaceStr(fCaption, ' ', '');
    Result := ReplaceStr(Result, '&', '');
  end;

begin
  Result := unAssigned;
  if not(Sender is TMenuItem) then exit;
  { added short cut keys to caption so take any out here }
  tempCaption := TrimText(TMenuItem(Sender).Caption);
  i := Pos('(', tempCaption);
  if i > 0 then begin
    tempCaption := Copy(tempCaption, 0, (i - 1));
  end;

  if SysUtils.SameText(tempCaption, TrimText('AND Filter')) then Result := AndFilter
  else if SysUtils.SameText(tempCaption, TrimText('OR  Filter')) then Result := OrFilter
  else if SysUtils.SameText(tempCaption, TrimText('AND Partial Filter')) then Result := AddPartial
  else if SysUtils.SameText(tempCaption, TrimText('OR  Partial Filter')) then Result := OrPartial
  else if SysUtils.SameText(tempCaption, TrimText('AND Exclude Filter')) then Result := AndExclude
  else if SysUtils.SameText(tempCaption, TrimText('OR  Exclude Filter')) then Result := OrExclude
  else if SysUtils.SameText(tempCaption, TrimText('AND Exclude Partial Filter')) then Result := AndPartialExclude
  else if SysUtils.SameText(tempCaption, TrimText('OR  Exclude Partial filter')) then Result := OrPartialExclude;
end;

function TBaseListingGUI.GetFirstRun: Boolean;
begin
  Result := FFirstRun;
  FFirstRun := False;
end;

procedure TBaseListingGUI.RefreshfilterLabel;
var
  fs: string;
begin
  FilterLabel.AutoSize := false;
  fs := Customfilter.Filterstatement;
  fs := ReplaceStr(fs, ':CurDate', QuotedStr(FormatDateTime(FormatSettings.ShortDateFormat, Date)));
  fs := ReplaceStr(fs, ':CurDateTime', QuotedStr(FormatDateTime(FormatSettings.LongDateFormat, Date)));
  FilterLabel.Caption := Trim(fs);
  FilterLabel.Visible := Trim(Customfilter.Filterstatement) <> '';
  FilterLabel.AutoSize := True;
  FilterLabel.Refresh;
end;

procedure TBaseListingGUI.AddfieldFilter(Sender: TObject);
begin
  inherited;
  Customfilter.Addfilter(grdMain.GetActiveField, getfilterType(Sender));
  RefreshfilterLabel;
end;

procedure TBaseListingGUI.AddPartialfilter(Sender: TObject);
begin
  inherited;
  Customfilter.Addfilter(grdMain.GetActiveField, getfilterType(Sender), getPartialString(grdMain.GetActiveField, getfilterType(Sender)));
  RefreshfilterLabel;
end;

procedure TBaseListingGUI.mnuStartSessionClick(Sender: TObject);
begin
  inherited;
  Customfilter.StartSection;
  RefreshfilterLabel;
end;


function TBaseListingGUI.NewTempTableName(const prefix: String): String;
begin
  result := GetUserTemporaryTableName(prefix);
end;

procedure TBaseListingGUI.mnuEndSessionClick(Sender: TObject);
begin
  inherited;
  Customfilter.EndSection;
  RefreshfilterLabel;
end;

procedure TBaseListingGUI.mnuPreviewClick(Sender: TObject);
begin
  inherited;
  PreviewFilteredReport;
end;

procedure TBaseListingGUI.mnuClearFilterClick(Sender: TObject);
begin
  inherited;
  if Customfilter.ConnectionAssigned then Customfilter.Connection.BeginTransaction;
  Customfilter.New;
  // CustomFilter.Filterstatement := '';
  PreviewFilteredReport;
  RefreshfilterLabel;
  cboCustomReports.Text := '';
end;

procedure TBaseListingGUI.cboCustomReportsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: boolean);
begin
  if not modified or empty(cboCustomReports.Text) then exit;
  inherited;
  if Customfilter.Datasetassigned then begin
    if Customfilter.DataSet.State in [dsEdit, dsInsert] then Customfilter.DataSet.cancel;
    Customfilter.Load(qryCustomReportsID.asInteger)
  end
  else Customfilter.Filterstatement := qryCustomReportsFilterStatement.asString;
  RefreshfilterLabel;
  PreviewFilteredReport;
end;

procedure TBaseListingGUI.mnuFilterPopup(Sender: TObject);
var
  Tmp: TField;
begin
  inherited;

  mnuAddCustomFilter.enabled := Customfilter.Filterstatement <> '';
  mnuPreview.enabled := Customfilter.Filterstatement <> '';
  mnuClearFilter.enabled := Customfilter.Filterstatement <> '';
  Tmp := grdMain.GetActiveField;
  if not Assigned(Tmp) then exit;
  { disable menu item if a calculated field }
  mnuAndFilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuORFilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuAndExcludeFilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuOrExcludefilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuAndPartialfilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuORPartialfilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuandExcludepartialfilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuOrexcludePartialfilter.enabled := not(grdMain.GetActiveField.fieldKind in [fkLookup, fkCalculated]);
  mnuAndFilter.Hint := 'Add Filter : ' + grdMain.GetActiveField.fieldname + '=' + grdMain.GetActiveField.asString;
  mnuORFilter.Hint := 'Add OR Filter : ' + grdMain.GetActiveField.fieldname + '=' + grdMain.GetActiveField.asString;
  mnuAndExcludeFilter.Hint := 'Add Filter : ' + grdMain.GetActiveField.fieldname + '<>' + grdMain.GetActiveField.asString;
  mnuOrExcludefilter.Hint := 'Add OR Filter : ' + grdMain.GetActiveField.fieldname + '=' + grdMain.GetActiveField.asString;
  mnuAndPartialfilter.Hint := 'Add Filter : ' + grdMain.GetActiveField.fieldname + ' like ' + grdMain.GetActiveField.asString;
  mnuORPartialfilter.Hint := 'Add OR Filter : ' + grdMain.GetActiveField.fieldname + ' like ' + grdMain.GetActiveField.asString;
  mnuandExcludepartialfilter.Hint := 'Add Filter : ' + grdMain.GetActiveField.fieldname + ' not like ' + grdMain.GetActiveField.asString;
  mnuOrexcludePartialfilter.Hint := 'Add OR Filter : ' + grdMain.GetActiveField.fieldname + ' not like ' + grdMain.GetActiveField.asString;
end;

procedure TBaseListingGUI.mnuListclassnameClick(Sender: TObject);
begin
  inherited;
    MessageDlgXP_Vista(self.classname, mtinformation, [mbOK], 0);
    CopyToClipboard(Self.Classname);
end;

procedure TBaseListingGUI.mnuLogSQLClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  clog('');
  Logtext(heirarchyname(Qrymain.connection) +':' +NL+'Database : '+Qrymain.connection.Database);
  for ctr := 0 to componentcount-1 do
    if components[ctr] is TERPQuery then
      Logtext(TERPQuery(components[ctr]).Name +NLnLF+
              TERPQuery(components[ctr]).SQLText+NLnLF+
              TERPQuery(components[ctr]).Filter+NLnLF+
              '===============================================================');
end;

procedure TBaseListingGUI.mnuMakeTableClick(Sender: TObject);
begin
  inherited;
  clog('Drop table if exists tmp_1;' +
      ' Create table tmp_1 ' +Qrymain.SQL.Text);
end;

procedure TBaseListingGUI.actAddToFilterExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TBaseListingGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  //
end;

function TBaseListingGUI.ActiveField: TField;
begin
  Result :=GridLib.ActiveField(grdmain);
end;

function TBaseListingGUI.ActiveFieldNAme: string;
begin
  Result := GridLib.ActiveFieldName(grdmain);
end;

procedure TBaseListingGUI.AddGridSelectedfield(fsfieldName: string; const fidisplaywidth: integer; const fsDisplayLabel: string; const fsGroupName: string = ''; ds:TDataset=nil);
var
  str: string;
  fld: TField;
begin
  if ds = nil then ds := qryMain;
//  if Qrymain.findfield(fsfieldName) <> nil then
//    if not(TField(Qrymain.findField(fsfieldName)).visible) then exit;
  fsfieldName := ReplaceStr(fsfieldName, '`', '');
  fld := ds.FindField(fsfieldName);
  if not Assigned(fld) then Exit;
  if not fld.Visible then
    fld.Visible := True;

  if not Assigned(FieldList) then Exit;
  str := SelectedText(fsfieldName, DoTranslate(fsDisplayLabel), fidisplaywidth, fsGroupName);
  FieldList.Add(str);
end;

procedure TBaseListingGUI.mnuAddCustomFilterClick(Sender: TObject);
begin
  inherited;
  getCustomFilter; // Creates CustomFilterForm
  try
    CustomFilterForm.PreviewReport := PreviewFilteredReport;
    CustomFilterForm.ReportName := TitleLabel.Caption;
    if cboCustomReports.Text <> '' then CustomFilterForm.KeyID := qryCustomReportsID.asInteger;
    CustomFilterForm.KeyID := Customfilter.ID;
    CustomFilterForm.ShowModal;
  finally CustomFilterForm := nil;
  end;
  if qryCustomReports.Active then qryCustomReports.Close;
  qryCustomReports.open;
end;

procedure TBaseListingGUI.mnuCustomFilterListClick(Sender: TObject);
var
  Form: TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TCustomFiltersListGUI');
  with TCustomFiltersListGUI(Form) do begin
    TCustomFiltersListGUI(Form).UserId := AppEnv.Employee.EmployeeId;
    TCustomFiltersListGUI(Form).ReportName := Self.ClassName;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TBaseListingGUI.CreateTransPopupform;
begin
  if qryMain.FindField('formName') <> nil then
    if Trim(qryMain.FieldByName('formname').asString) <> '' then begin
      frmPopup := TBaseInputGUI(FindExistingComponent(qryMain.FieldByName('formname').asString));
      if Assigned(frmPopup) then begin
        frmPopup.Close;
        Application.ProcessMessages;
      end;
      if CommonLib.FormStillOpen(qryMain.FieldByName('formname').asString) then frmPopup := nil
      else frmPopup := TBaseInputGUI(CommonLib.GetComponentByClassName(qryMain.FieldByName('formname').asString));
    end;
end;

function TBaseListingGUI.GridCurrentColumnIndex(const X, Y: Integer): Integer;
var
    Cell: TGridCoord;
begin
  REsult := -1;
  Cell:=grdMain.MouseCoord(X,Y);
  if cell.y =0 then exit;  // header;
  result:= Cell.X;
  if dgIndicator in grdmain.Options then  Dec(result);
end;

procedure TBaseListingGUI.SetShowGridOnly(const Value: boolean);
begin
  fbShowGridonly := Value;
  HeaderPanel.Visible := not(Value);
  FooterPanel.Visible := not(Value);
  FilterLabel.Visible := not(Value);
  if (Value) then begin
    grdMain.PopupMenu := nil;
    Self.Height := Self.Height - (FooterPanel.Height + HeaderPanel.Height + FilterLabel.Height);
  end;
end;
procedure TBaseListingGUI.ListTimerMsg(const MSg: String; abtntohighLight :TDnmSpeedbutton= nil;Secondstoshow: Integer=5);
begin
    TimerMsg(abtntohighLight , lblTimerMsg , Msg , Secondstoshow);
end;
procedure TBaseListingGUI.ListMsg(const MSg: String);
begin
//  clog(msG);
  lblDateComments.Caption := Msg;
  if not lblDateComments.Visible then lblDateComments.Visible := TRue;
  lblDateComments.Refresh;
end;

procedure TBaseListingGUI.TimerSearchLabelTimer(Sender: TObject);
var
  iSeconds: integer;
begin
  inherited;
  if NonSearchMode then begin
    TimerSearchLabel.enabled := false;
    exit;
  end;

  iSeconds := SecondsBetween(now, fTimerLabelStartTime) + 1;
  if iSeconds >= SEARCH_LABEL_FLASH_PERIOD then begin
    TimerSearchLabel.enabled := false;
    lblSearchMode.Visible := false
  end else begin
    if fbTimerLabelToggle then begin
      fbTimerLabelToggle := false;
      lblSearchMode.Visible := false;
    end else begin
      fbTimerLabelToggle := True;
      lblSearchMode.Visible := True;
    end;
  end;
end;


procedure TBaseListingGUI.tmrtimedMsgOnshowTimer(Sender: TObject);
begin
  inherited;
  try
    pnltimedMsgOnshow.Visible := False;
    tmrtimedMsgOnshow.Enabled := False;
    Freeandnil(pnltimedMsgOnshow);
  Except

  end;
end;
procedure TBaseListingGUI.readGridfooterValues;
var
  ctr: integer;
begin
  for ctr := low(FooterCalcfields) to high(FooterCalcfields) do
    if (Qrymain.FindField(FooterCalcfields[ctr].fieldname) <> nil) then begin
      readGridfooterValue(FooterCalcfields[ctr].fieldname,FooterCalcfields[ctr].Total);
    end;
end;

procedure TBaseListingGUI.CalcFooter;
begin
  CalcGridFooter(qrymain, FooterCalcfields);

end;

Function TBaseListingGUI.FooterCalcfieldValue(const fieldName:String):Double;
var
  ctr:Integer;
begin
  REsult:=0;
  for ctr := low(FooterCalcfields) to high(FooterCalcfields) do
    if Sametext(FooterCalcfields[ctr].FieldName , fieldName) then begin
      REsult:=FooterCalcfields[ctr].Total;
      Exit;
    end;
end;
function TBaseListingGUI.FooterValue(const Fieldname: STring): Double;
var
  s:String;
begin
  REsult :=0;
  try
    s:= grdMain.ColumnByName(Fieldname).FooterValue;
    if s<> '' then begin
      s:= replacestr(s , AppEnv.RegionalOptions.CurrencySymbol , '');
      s:= replacestr(s , FormatSettings.ThousandSeparator , '');
      result := strtofloat(s);
    end;
  Except
    on E:Exception do begin
      // kill the exception
    end;
  end;
end;

procedure TBaseListingGUI.CalcnShowFooter;
begin
  CalcnShowGridFooter(grdmain, qrymain,  FooterCalcfields,CalcFooter );
end;

{ NOTE: This is a fix for the printDat component.
        printDat is removing the character that follows the ^ symbol
        eg in a job customer name.
        This code just inserts a single space after the ^ char.
}
procedure TBaseListingGUI.CapturedStringFieldGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  rec: TDBEventRec;
  FieldGetTextEvent: TFieldGetTextEvent;
begin
  Text := ReplaceStr(Sender.AsString, '^', '^ ');
  rec := EventRecFromList(Sender);
  if Assigned(rec) then begin
    TMethod(FieldGetTextEvent).Data := rec.Data;
    TMethod(FieldGetTextEvent).Code := rec.Code;
    if Assigned(FieldGetTextEvent) then
      FieldGetTextEvent(Sender,Text,DisplayText);
  end;
end;

procedure TBaseListingGUI.CaptureFieldGetTextEvents;
var
  x: integer;
  rec: TDBEventRec;
begin
  for x := 0 to qryMain.FieldCount -1 do begin
    if qryMain.Fields[x] is TWideStringField then begin
      rec := TDBEventRec.Create;
      rec.Field := qryMain.Fields[x];
      rec.Data := TMethod(qryMain.Fields[x].OnGetText).Data;
      rec.Code := TMethod(qryMain.Fields[x].OnGetText).Code;
      DBEventList.Add(rec);
      qryMain.Fields[x].OnGetText := CapturedStringFieldGetText;
    end;
  end;
end;

procedure TBaseListingGUI.ReleaseFieldGetTextEvents;
var
  x: integer;
  rec: TDBEventRec;
  FieldGetTextEvent: TFieldGetTextEvent;
begin
  for x := 0 to qryMain.FieldCount -1 do begin
    if qryMain.Fields[x] is TWideStringField then begin
      rec := EventRecFromList(qryMain.Fields[x]);
      if Assigned(rec) then begin
        TMethod(FieldGetTextEvent).Data := rec.Data;
        TMethod(FieldGetTextEvent).Code := rec.Code;
        qryMain.Fields[x].OnGetText := FieldGetTextEvent;
      end;
    end;
  end;
  DBEventList.Clear;
end;



procedure TBaseListingGUI.readGridfooterValue(columnname:String; Value:Double);
begin
  // descendatns can accesss this function to read the value if required as the footervalue of the grid is cannot be read
end;

procedure TBaseListingGUI.AddCalcColumn(const fFieldName: string; fIsCurrency: boolean; CalcType: TFooterCalcType = fctSum);
var
  x: integer;
begin
  for x := Low(FooterCalcfields) to High(FooterCalcfields) do begin
    if SameText(FooterCalcfields[x].FieldName,fFieldName) then
      exit; { already in list }
  end;


  Setlength(FooterCalcfields, high(FooterCalcfields) + 2);
  FooterCalcfields[ high(FooterCalcfields)].fieldname := fFieldname;
  FooterCalcfields[ high(FooterCalcfields)].IsCurrency := fIsCurrency;
  FooterCalcfields[ high(FooterCalcfields)].CalcType := CalcType;
end;

procedure TBaseListingGUI.AddDateRangeSelectionHint(const Value: String);
begin
  showControlHint(chkIgnoreDates, trim(chkIgnoreDates.Hint +NL+ Value ));
  showControlHint(cboDateRange  , trim(cboDateRange.Hint +NL+ Value ));
  showControlHint(lblFrom       , trim(lblFrom.Hint +NL+ Value ));
  showControlHint(dtFrom        , trim(dtFrom.Hint +NL+ Value ));
  showControlHint(lblTo         , trim(lblTo.Hint +NL+ Value ));
  showControlHint(dtTo          , trim(dtTo.Hint +NL+ Value ));

end;

function TBaseListingGUI.getFilterDateFrom: TDateTime;
begin
  Result := dateof(dtFrom.DateTime);
  if not(dtFrom.visible) then Result:= 0
  else if chkIgnoreDates.Visible then
    if chkIgnoreDates.Checked then
      Result:= ERPListMinDatetime;
end;

function TBaseListingGUI.getFilterdateto: TDateTime;
begin
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
  if not(dtTo.visible) then Result := MaxDateTime//incyear(Date , 20)
  else if chkIgnoreDates.Visible then
    if chkIgnoreDates.Checked then
      Result := ERPListMaxDatetime;//incyear(Date , 20);
end;
procedure TBaseListingGUI.AddFieldstoGrid(const fsfieldList: string; fieldIndex:Integer=-1);
begin
  GuiPrefs.DbGridElement[grdMain].AddFields(fsfieldList ,fieldIndex);
end;

procedure TBaseListingGUI.AddFieldtoGrid(const fsfieldName: string; fieldIndex:Integer=-1);
begin
  //GuiPrefs.DbGridElement[grdMain].UnHideField(fsfieldName);
  GuiPrefs.DbGridElement[grdMain].AddField(fsfieldName);
  if fieldIndex >=0 then Qrymain.fieldbyname(fsFieldName).Index := fieldIndex;
end;
procedure TBaseListingGUI.AddfilterString(const Value: String);
begin
  if FilterString <> '' then FilterString := '(' + FilterString +') and ('  + Value +')'
  else FilterString := Value;
end;

procedure TBaseListingGUI.RemoveAmountField(const aFieldName: string);
var
  y: integer;

  procedure DeleteArrayIndex(Index: Integer);
  var i: integer;
  begin
    if Index > High(AmountFields) then Exit;
    if Index < Low(AmountFields) then Exit;
    if Index = High(AmountFields) then begin
      SetLength(AmountFields, Length(AmountFields) - 1);
      Exit;
    end;
    for i := Index +1 to High(AmountFields) do
      AmountFields[i-1] := AmountFields[i];
//    Finalize(AmountFields[Index]);
//    System.Move(AmountFields[Index +1], AmountFields[Index],
//    (Length(AmountFields) - Index -1) * SizeOf(string) + 1);
    SetLength(AmountFields, Length(AmountFields) - 1);
  end;

begin
  for y := Low(AmountFields) to High(AmountFields) do
    if SameText(AmountFields[y],aFieldName) then begin
      DeleteArrayIndex(y);
      exit;
    end;
end;

procedure TBaseListingGUI.RemoveDateRangeHint;
begin
  if fbRemovedDateRangeHint then exit;

  fbRemovedDateRangeHint := true;
  showControlHint(chkIgnoreDates, replacestr(replacestr(chkIgnoreDates.Hint, LONGDATERANGEHINT, ''), SHORTDATERANGEHINT,'') );
  showControlHint(cboDateRange  , replacestr(replacestr(cboDateRange.Hint  , LONGDATERANGEHINT, ''), SHORTDATERANGEHINT,'') );
  showControlHint(lblFrom       , replacestr(replacestr(lblFrom.Hint       , LONGDATERANGEHINT, ''), SHORTDATERANGEHINT,'') );
  showControlHint(dtFrom        , replacestr(replacestr(dtFrom.Hint        , LONGDATERANGEHINT, ''), SHORTDATERANGEHINT,'') );
  showControlHint(lblTo         , replacestr(replacestr(lblTo.Hint         , LONGDATERANGEHINT, ''), SHORTDATERANGEHINT,'') );
  showControlHint(dtTo          , replacestr(replacestr(dtTo.Hint          , LONGDATERANGEHINT, ''), SHORTDATERANGEHINT,'') );


end;

procedure TBaseListingGUI.RemoveFieldfromGrid(const fsfieldName: string);
begin
  GuiPrefs.DbGridElement[grdMain].RemoveField(fsFieldName);
//  GuiPrefs.DbGridElement[grdMain].HideField(fsfieldName);
//  grdMain.RemoveField(fsfieldName);
end;
procedure TBaseListingGUI.RemoveFieldsfromGrid(const fsFieldList: string);
begin
  GuiPrefs.DbGridElement[grdMain].RemoveFields(fsFieldList);
end;

procedure TBaseListingGUI.SetUpcustomFields(const CustomFields: string;cListType: TListtype);
var
  CustomfieldonGrid : TCustomFieldonGrid;
begin
  CustomfieldonGrid := TCustomFieldonGrid.Create(Self,CustomFields,cListType, grdmain, guiprefs, nil);
  CustomfieldonGrid.SetUpcustomFields;
end;
procedure TBaseListingGUI.SetUpcustomFields(const CustomField: string; fieldPrefix:String ='');
var
  ctr: integer;
  CustomFields: TERPQuery;
  s: string;
begin
  CustomFields := DbSharedObjectsObj.DbSharedObj.GetQuery(Listconnection(*GetSharedMyDacConnection*));
  try

    CustomFields.SQL.Add('SELECT');
    s:= 'ID';
    for ctr := 1 to 18 do s:= s +',CFLabel' + Trim(IntToStr(ctr));
    for ctr := 1 to 18 do s:= s + ',CF' + CustomField + Trim(IntToStr(ctr));
    CustomFields.SQL.Add(s);

    CustomFields.SQL.Add('FROM tblcustomfields');
    CustomFields.open;

    { remove custom fields if not choosen }
    for ctr := 1 to 15 do begin
      if not CustomFields.FieldByName('CF' + CustomField + Trim(IntToStr(ctr))).asBoolean then RemoveFieldfromGrid(fieldPrefix+'CustFld' + Trim(IntToStr(ctr)));
      OnSetUpcustomFields(CustomFields.FieldByName('CF' + CustomField + Trim(IntToStr(ctr))).asBoolean  , ctr , 'CF' + CustomField + Trim(IntToStr(ctr)) , fieldPrefix+'CustFld' + Trim(IntToStr(ctr)) , CustomFields.FieldByName('CFLabel' + Trim(IntToStr(ctr))).asString);
    end;
    for ctr := 1 to 3 do begin
      if not CustomFields.FieldByName('CF' + CustomField + Trim(IntToStr(ctr + 15))).asBoolean then RemoveFieldfromGrid(fieldPrefix+'CUSTDATE' + Trim(IntToStr(ctr)));
      OnSetUpcustomFields(CustomFields.FieldByName('CF' + CustomField + Trim(IntToStr(ctr + 15))).asBoolean , ctr +15, 'CF' + CustomField + Trim(IntToStr(ctr + 15)) , fieldPrefix+'CUSTDATE' + Trim(IntToStr(ctr)) , CustomFields.FieldByName('CFLabel' + Trim(IntToStr(ctr + 15))).asString);
    end;

    { change caption }
    for ctr := 1 to 15 do
      if qryMain.FindField(fieldPrefix+'CustFld' + Trim(IntToStr(ctr))) <> nil then  begin
          qryMain.FieldByName(fieldPrefix+'CustFld' + Trim(IntToStr(ctr))).DisplayLabel := CustomFields.FieldByName('CFLabel' + Trim(IntToStr(ctr))).asString;
          if qryMain.FieldByName(fieldPrefix+'CustFld' + Trim(IntToStr(ctr))).displaywidth = 255 then qryMain.FieldByName(fieldPrefix+'CustFld' + Trim(IntToStr(ctr))).displayWidth := 20;
      end;
    for ctr := 1 to 3 do
      if qryMain.FindField(fieldPrefix+'CUSTDATE' + Trim(IntToStr(ctr))) <> nil then
          qryMain.FieldByName(fieldPrefix+'CUSTDATE' + Trim(IntToStr(ctr))).DisplayLabel := CustomFields.FieldByName('CFLabel' + Trim(IntToStr(ctr + 15))).asString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(CustomFields);
  end;
end;
procedure TBaseListingGUI.OnSetUpcustomFields(CustfieldVisible:Boolean;fieldno :Integer;  FlagFieldname , fieldname, DisplayLabel:String );
begin
// descendants will override if required
end;

procedure TBaseListingGUI.setDashboardDetail(const Value: boolean);
begin
  fbDashboardDetail := Value;
end;

procedure TBaseListingGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  inherited;
  cboDateRange.enabled := not(chkIgnoreDates.Checked);
  lblFrom.enabled := not(chkIgnoreDates.Checked);
  dtFrom.enabled := not(chkIgnoreDates.Checked);
  lblTo.enabled := not(chkIgnoreDates.Checked);
  dtTo.enabled := not(chkIgnoreDates.Checked);
  if screen.activecontrol = chkIgnoreDates then  RefreshQuery;
end;

procedure TBaseListingGUI.chkIncludehistoryClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol =  chkIncludeHistory then
    RefreshQuery;
end;

procedure TBaseListingGUI.closeDB(ds: TDataSet);
begin
  if ds.Active then ds.Close;
end;

procedure TBaseListingGUI.OpenDB(ds: TDataSet);
begin
  if ds.Active = false then ds.open;
end;

procedure TBaseListingGUI.grdMainEnter(Sender: TObject);
begin
  inherited;
  SetSearchfield(Sender);
end;

procedure TBaseListingGUI.GrdmainForPanel(parentPanel: TDNMPanel;beforeShow: TNotifyEvent = nil);
begin
  {full list}
  Tag         := 99;
  SearchMode  := smFullList;
  dtfrom.Date :=0;
  DtTo.Date   := incyear(now,100);
  if Assigned(beforeShow) then beforeShow(Self);
  RefreshQuery;
  Grdmain.parent := parentPanel;
  Grdmain.popupmenu := mnuRefresh;
  grdMain.TitleColor := ParentPanel.Color;
  grdMain.FooterColor := ParentPanel.Color;
  grdMain.Showhint := True;
  grdMain.hint := 'This list is derived from ' +formcaption;
end;

function TBaseListingGUI.SelectedIDs(IDFieldname: string; ignoreduplicates: boolean = false): string;
var
  St: TStringList;
begin
  St := TStringList.Create;
  try SelectedIDs(IDFieldname, St, ignoreduplicates);
  finally
    St.Delimiter := ',';
    Result := St.DelimitedText;
    FreeandNil(St);
  end;
end;
procedure TBaseListingGUI.Selectrecords;
var
  ctr:Integer;
  st:TIntegerList;
begin
  if trim(SelectrecordsValues )='' then exit;
  if qrymain.findfield(Selectrecordsfieldname)=nil then exit;
  if IsLimit0selection or (Qrymain.recordcount =0) then exit;

  EnableMultiSelect('');
  st:= TIntegerList.create;
  try
    st.commatext := SelectrecordsValues ;
    for ctr := 0 to st.count -1 do
      if qrymain.locate(Selectrecordsfieldname , inttostr(st[ctr]) , []) then grdmain.selectRecord;
    Application.ProcessMessages;

  finally
    SelectrecordsValues  := '';
    freeandnil(St);
  end;
end;

function TBaseListingGUI.Selecteddatas(Fieldname: string; ignoreduplicates: boolean = false;REsultDelim :char =','): string;
var
  St: TStringList;
begin
  St := TStringList.Create;
  try
    Selecteddatas(Fieldname, St, ignoreduplicates);
  finally
    St.Delimiter :=REsultDelim;
    Result := St.DelimitedText;
    FreeandNil(St);
  end;
end;
function TBaseListingGUI.SelectedDatas(Fieldname: string; var St: TStringList; ignoreduplicates: boolean = false): string;
begin
  try
    CommonLib.SelectedDatas(grdMain, Fieldname, St, ignoreduplicates);
  finally
    St.Delimiter := ',';
    Result := St.DelimitedText;
  end;
end;
procedure TBaseListingGUI.showProgressbar(Progressbarcaption: string; Progresscount: integer = 0; AllowCancel:Boolean = True; aOnScriptExecuteProgressCancel:TNotifyEvent = nil);
begin
try
  if not(Assigned(aOnScriptExecuteProgressCancel)) then aOnScriptExecuteProgressCancel := OnScriptExecuteProgressCancel;
  DoShowProgressbar(Progresscount, Progressbarcaption  , '' , True , False, OnScriptExecuteProgressCancel , AllowCancel);

Except end;
end;
function TBaseListingGUI.SQLWithCustomfilterApplied: String;
var
  QM:TQueryManipulationObj;
begin
  if Qrymain.Filter = '' then begin
      result:= Qrymain.SQL.Text;
  end else begin
    QM := TQueryManipulationObj.Create(qryMain.SQL.Text);
    try
      QM.RefreshOrignalSQL(qryMain.SQL.Text , False);
      REsult:= QM.SQLWithCustomfilterApplied(Qrymain.Filter);
    finally
      Freeandnil(QM);
    end;
  end;
end;

procedure TBaseListingGUI.HideProgressbar;
begin
try
  if HasActiveProgressbar then DoHideProgressbar;
Except
end;
end;

procedure TBaseListingGUI.stepProgressbar(Const ProgressbarMsg :String = '');
begin
try
  if HasActiveProgressbar then
    DoStepProgressbar(ProgressbarMsg);
Except end;
end;
procedure TBaseListingGUI.ProgressValueReset(const Value: Integer);
begin
try
  DoProgressValueReset(value);
Except
end;
end;

procedure TBaseListingGUI.StorecleanDate(FromTo: string);
begin
  if FromTo = 'F' then begin
    if Screen.ActiveControl = dtFrom then CleanFromDate := dtFrom.Date;
    if dtFrom.DateTime <= AppEnv.CompanyPrefs.SummarisedTransDate then dtFrom.DateTime := AppEnv.CompanyPrefs.FirstTransDate;
  end;
  if FromTo = 'T' then begin
    if Screen.ActiveControl = dtTo then cleanTodate := dtTo.Date;
    if dtTo.DateTime < AppEnv.CompanyPrefs.SummarisedTransDate then dtTo.DateTime := AppEnv.CompanyPrefs.SummarisedTransDate;
  end;
end;

procedure TBaseListingGUI.IterateselectedRecords(UseProgressbar: boolean = false; Progressbarcaption: string = '');
var
  i: integer;
  Abort: boolean;
  bm:TBookmark;
begin
  Abort := false;
  if SelectedRecords > 0 then begin
    if UseProgressbar then showProgressbar(Progressbarcaption, SelectedRecords);
    try
      bm := Qrymain.GetBookmark;
      try
            for i := 0 to SelectedRecords - 1 do begin
              IterateProc(UseProgressbar, Abort, i);
              if abort then exit;
            end;
      finally
        Qrymain.GotoBookmark(bm);
        Qrymain.FreeBookmark(bm);
      end;
    finally
      if UseProgressbar then HideProgressbar;
    end;
  end;
end;


function TBaseListingGUI.SelectedIDs(IDFieldname: string; var St: TIntegerList; ignoreduplicates: boolean = false; DoCheckrec:TBoolFunc=nil): string;
begin
  try CommonLib.SelectedIDs(grdMain, IDFieldname, St, ignoreduplicates , DoCheckrec);
  finally Result := St.CommaText;
  end;
end;
Function TBaseListingGUI.SaveTemplateReport(const ReportName,SQLPortion: string; const DoPrint: boolean; const FileType, FileName: string;MasterDetailLink: TJsonObject):Boolean;
begin
  REsult := False;
  if not Empty(ReportName) then begin
    PrintTemplate.ReportSQLSupplied := fbReportSQLSupplied;
    PrintTemplate.SaveTemplateReport(ReportName, SQLPortion, DoPrint, FileType, FileName, nil, MasterDetailLink);
    Result := True;
  end;
end;

function TBaseListingGUI.ScriptMain: TERPScript;
begin
  if (SctMain.Connection = nil) then SctMain.Connection := Qrymain.connection;
  if (SctMain.Connection = nil) then SctMain.Connection := Listconnection(*CommonDbLib.GetSharedMyDacConnection*);
  if  (SctMain.Connection.Connected = false) then SctMain.Connection := Listconnection(*CommonDbLib.GetSharedMyDacConnection*);
  REsult := SctMain;
end;
function TBaseListingGUI.ScriptMainInTrans :TERPScript;
begin
  if (SctMain.Connection = nil) or  (SctMain.Connection = Qrymain.connection) then SctMain.Connection:= GetNewMyDacConnection(Self);
  if  (SctMain.Connection.Connected = false) then SctMain.Connection.Connected := True;
  if not (SctMain.Connection.InTransaction ) then TERPConnection(SctMain.Connection).StartTransaction;
  REsult := SctMain;
end;
Function TBaseListingGUI.ScriptMainCommit:Boolean;
begin
  REsult := False;
  if SctMain.Connection = Qrymain.connection then exit;
  if SctMain.Connection.InTransaction then SctMain.Connection.Commit;
  REsult := true;
end;
Function TBaseListingGUI.ScriptMainrollback:Boolean;
begin
  REsult := False;
  if SctMain.Connection = Qrymain.connection then exit;
  if SctMain.Connection.InTransaction then SctMain.Connection.Rollback;
  REsult := true;
end;
Function  TBaseListingGUI.ScriptMainBeginTrans:Boolean;
begin
  REsult := False;
  if SctMain.Connection = Qrymain.connection then exit;
  if SctMain.Connection.InTransaction then
  else SctMain.Connection.StartTransaction;
  REsult := true;
end;

procedure TBaseListingGUI.ScrptMainCleanConn;
var
  fconn :TERPConnection;
begin
  fconn :=TERPConnection(SctMain.Connection);
  SctMain.Connection := nil;
  if (fConn <> nil) and  (fConn <> Qrymain.connection) and assigned(fConn.owner) and (fConn.owner = self) then
    Freeandnil(fConn);
end;

procedure TBaseListingGUI.SctMainBeforeExecute(Sender: TObject;  var SQL: string; var Omit: Boolean);
begin
  inherited;
  if devmode then stepProgressbar(SQL)
  else stepProgressbar;
end;


procedure TBaseListingGUI.SctMainError(Sender: TObject; E: Exception;  SQL: string; var Action: TErrorAction);
begin
  inherited;
  if devmode then MessageDlgXP_Vista('Please IGNORE - Silent Error, Message Shown only in Dev Mode' +NL+E.message +NL + SQL, mtWarning, [mbOK], 0)
  else SendEmailtoErp('Baselisitng MainSript.execute Error Error from :  ' + Appenv.Employee.EmployeeName+' ('+ Appenv.CompanyInfo.Companyname+')',
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Version  : ' +TABLE_VERSION+chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+
                                        'ERP form Name : ' +Self.classname +chr(13)+
                                        'Error :' + E.Message+chr(13) +
                                        '------------------------------------------------------------'+chr(13)+chr(13)+
                                        'Sql With error : ' + SQL+chr(13)+chr(13) +
                                        '------------------------------------------------------------'+chr(13)+chr(13)+
                                        'Qrymain.Sql : ' + Qrymain.SQLtext+chr(13)+chr(13)+
                                        '------------------------------------------------------------'+chr(13)+chr(13)+
                                        'Complete SQL: ' + sctmain.SQL.Text    , '' );

  Action := eaContinue ;
end;

procedure TBaseListingGUI.selectall;
begin
      if dgMultiselect in grdMain.Options then begin
        grdMain.selectAll;
        if istoDoAfterallSelected then  DoAfterallSelected;
      end;
end;

function TBaseListingGUI.SelectedIDs(IDFieldname: string; var St: TStringList; ignoreduplicates: boolean = false; DoCheckrec:TBoolFunc=nil): string;
begin
  try CommonLib.SelectedIDs(grdMain, IDFieldname, St, ignoreduplicates, DoCheckrec);
  finally
    St.Delimiter := ',';
    Result := St.DelimitedText;
  end;
end;

procedure TBaseListingGUI.IterateselectedRecordsReverse(UseProgressbar: boolean; Progressbarcaption: string);
var
  i: integer;
  Abort: boolean;
  bm:TBookmark;
begin
  Abort := false;
  if SelectedRecords > 0 then begin
    if UseProgressbar then showProgressbar(Progressbarcaption , SelectedRecords);
    try
      bm := Qrymain.GetBookmark;
      try
          for i := SelectedRecords - 1 downto 0 do begin
            IterateProc(UseProgressbar, Abort, i);
            if Abort then exit;
          end;
      finally
        Qrymain.GotoBookmark(bm);
        Qrymain.FreeBookmark(bm);
      end;
    finally
      if UseProgressbar then HideProgressbar;
    end;
  end;
end;

function TBaseListingGUI.getKeyIdfieldname: String;
begin
  Result := fsKeyIdfieldname;
end;

procedure TBaseListingGUI.lblDateCommentsClick(Sender: TObject);
begin
  inherited;
  if dtFrom.DateTime <= AppEnv.CompanyPrefs.SummarisedTransDate then dtFrom.DateTime := AppEnv.CompanyPrefs.FirstTransDate;
  if dtTo.DateTime < AppEnv.CompanyPrefs.SummarisedTransDate then dtTo.DateTime := AppEnv.CompanyPrefs.SummarisedTransDate;
  RefreshQuery;
  RefreshAll;
  // RefreshDatecomments;
end;

procedure TBaseListingGUI.lblSearchoptionsDblClick(Sender: TObject);
begin
  inherited;
  ToggleSearchOptions;
end;
procedure TBaseListingGUI.ToggleSearchOptions;
var
  fb:Boolean;
begin
  fb:= lblSearchoptions.visible;
  lblSearchoptions.visible := not(fb);
  pnlSearchbuttons.visible := fb;
  edtSearch.Visible := True;
end;
procedure TBaseListingGUI.IterateProc(UseProgressbar: boolean; var Abort: boolean; i: integer);
begin
  if UseProgressbar then stepProgressbar(inttostr(i+1) +' of ' + inttostr(SelectedRecords))
  else Listtimermsg(inttostr(i+1) +' of ' + inttostr(SelectedRecords));
  qryMain.GoToBookmark(grdMain.SelectedList.Items[i]);
  IterateselectedRecordsCallback(Abort, i);
end;

procedure TBaseListingGUI.IterateRecords(UseProgressbar: boolean; Progressbarcaption: string);
var
  Abort: boolean;
  bm: TBookmark;
begin
  Abort := false;
  if UseProgressbar then showProgressbar(Progressbarcaption);
  try
    if qryMain.RecordCount > 0 then begin
      bm := qryMain.GetBookmark;
      try
        qryMain.first;
        while qryMain.eof = false do begin
          IterateselectedRecordsCallback(Abort, qrymain.RecNo);
          if abort then exit;
          stepProgressbar(inttostr(Qrymain.recno)+' of ' + inttostr(Qrymain.recordcount));
          qryMain.Next;
        end;
      finally
        qryMain.GoToBookmark(bm);
        qryMain.FreeBookmark(bm);
      end;
    end;
  finally
    if UseProgressbar then HideProgressbar;
  end;

end;

function TBaseListingGUI.IdfieldFor(Const IDfieldForClassname:String) : TField;
begin
  REsult := nil;
end;

function TBaseListingGUI.IDs(const IDFieldname: string; ignoreduplicates: boolean): string;
var
  bm: TBookmark;
  St: TStringList;
begin
  Result := '';
  if qryMain.RecordCount = 0 then exit;
  try
    St := TStringList.Create;
    try
      bm := qryMain.GetBookmark;
      try
        qryMain.first;
        while qryMain.eof = false do begin
          if qryMain.FieldByName(IDFieldname).asString <> '' then begin
            if ignoreduplicates = false then
              St.Add(qryMain.FieldByName(IDFieldname).asString)
            else if SearchStringList(st, qryMain.FieldByName(IDFieldname).asString) < 0 then
              St.Add(qryMain.FieldByName(IDFieldname).asString);
          end;
          qryMain.Next;
        end;
      finally
        qryMain.GoToBookmark(bm);
        qryMain.FreeBookmark(bm);
      end;
    finally
      St.Delimiter := ',';
      Result := St.DelimitedText;
      FreeandNil(St);
    end;
  except
    //
  end;
end;

procedure TBaseListingGUI.imgReportTablesMsgClick(Sender: TObject);
begin
  inherited;
  fbReportTablemsgshown := False;
  showReportTableMsg;
end;

procedure TBaseListingGUI.EnableMultiSelect(const MultiSelectNote: string);
begin
  if not(dgMultiselect in grdMain.Options) then grdMain.Options := grdMain.Options + [dgMultiselect];
//  if not(dgRowSelect in grdMain.Options) then grdMain.Options := grdMain.Options + [dgRowSelect];
  if not(msoAutoUnselect in grdMain.MultiSelectOptions) then grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoAutoUnselect];
  if not(msoShiftSelect in grdMain.MultiSelectOptions) then grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect];
  if MultiSelectNote <> '' then SpecialNote := MultiSelectNote;
end;

function TBaseListingGUI.EventRecFromList(aField: TField): TDBEventRec;
  var i: integer;
begin
  result := nil;
  for i := 0 to DBEventList.Count -1 do begin
    if TDBEventRec(DBEventList[i]).Field = aField then begin
      result := TDBEventRec(DBEventList[i]);
      break;
    end;
  end;
end;

function TBaseListingGUI.ExecutenCommit: Boolean;
begin
  REsult := False;
  DoShowProgressbar(SctMain.SQL.count, WAITMSG);
  try
    try
        SctMain.Execute;
        ScriptMainCommit;
        Result := True;
    Except
      on E:Exception do begin
        ScriptMainrollback;
        MessageDlgXP_vista('Error in SQL.'+NL+E.message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    DoHideProgressbar;
  end;

end;

procedure TBaseListingGUI.ExecuteSQLwithProgress(fsSQL:String;AllowCancel:Boolean=False);
begin
  With ScriptMain do begin
    Connection := Qrymain.connection;
    SQL.Clear;
    SQL.Add(fsSQL);
    clog(sql.text);
    ExecutewithProgress(AllowCancel);
  end;
end;
Procedure TBaseListingGUI.ExecutewithProgress(AllowCancel:Boolean=False);
begin
  With ScriptMain do begin
    Processingcursor(True);
    try
      showProgressbar(WAITMSG, strCount(';' , SQL.Text) , AllowCancel , OnScriptExecuteProgressCancel );
      try
          Execute;
      finally
        HideProgressbar;
      end;
    finally
      ProcessingCursor(False);
    end;
  end;
end;
Procedure TBaseListingGUI.OnScriptExecuteProgressCancel(Sender :TObject);
begin
  ScriptMain.BreakExec;
end;


Function TBaseListingGUI.ExporttoSQL(const Typename: String; var filename:String):Boolean;
var
  st:TStringlist;
  errorlog:String;
begin
    result := False;
    if grdMain.SelectedList.Count >0 then begin
        filename:= appenv.companyinfo.Companyname +'_' +appenv.Employee.EmployeeName+'_' +Typename+'_'+ formatDatetime('yyymmddhhnn' , now())+'.SQL';
        if fileExists(filename) then sysutils.DeleteFile(FileName);
        fsExportedSQL:= '';
        IterateProcno := ItearteProcno4ExportToSQL;
        IterateselectedRecords(true);
        st:= TStringlist.Create;
        try
          st.Text:=fsExportedSQL;
          try
            St.SaveToFile(filename);
            REsult := TRue;
              if MessageDlgXP_Vista(iif(fbExportingall , 'All' , 'Selected') + ' ' + Typename +'s are exported as SQL into ' +NL+quotedstr(filename)+'.'+NL+NL+
                                      'Sending this to ''ERP'' will REPLACE these selected ' + Typename +'s with your ' + Typename +' in'+NL+
                                      'ALL DATABASES AND CANNOT BE REVERTED.'+NL+NL+
                                      'Do you want to send this to ERP?', mtconfirmation , [mbyes,mbNo], 0) = mryes then begin
              processingcursor(true);
              try
                errorlog:=  SendEmailtoErp('' + Typename +'s from :  ' + Appenv.Employee.EmployeeName+' ('+ Appenv.CompanyInfo.Companyname+')',
                                        'Following ' + inttostr(grdMain.SelectedList.Count) +' ' + Typename +'s attached ' +chr(13) +
                                              SelectedDatas('Description', False, NL) + NL+NL+
                                        'Filename :' + ExtractFileName(Filename) + chr(13) +
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+chr(13)+
                                        'Note for ERP: copy the content of this in to Devserver\P1\ SQL for Next Release'  , '' , filename  );
              finally
                ProcessingCursor(False);
              end;
              if errorlog <> '' then MessageDlgXP_Vista('Emailing ' + Typename +'s to ERP failed. Please Contact ERP.'+chr(13)+'Error Log:'+ErrorLog , mtwarning, [mbok],0)
              else MessageDlgXP_Vista(iif(fbExportingall , 'All' , 'Selected') + ' ' + Typename +'s are emailed to ERP.', mtInformation, [mbok],0);
            end else begin
              //ShellExecute(Handle, 'Open', PChar(ExtractFilePath(filename)) , '', '', SW_SHOWNORMAL)
              ShellExecute(0, nil, 'explorer.exe', PChar('/select,'+filename ), nil,  SW_SHOWNORMAL)
            end;
            grdmain.UnselectAll;
            Exit;
          Except
            on E:Exception do begin
              MessageDlgXP_Vista('Export the ' + Typename +'s as SQL failed.'+NL+E.Message, mtWarning, [mbOK], 0);
              Exit;
            end;
          end;
        finally
          Freeandnil(St);
        end;
end;


end;

procedure TBaseListingGUI.ExtraSetupFormInPanel;
begin

end;

procedure TBaseListingGUI.grdMainBeforePaint(Sender: TObject);
begin
  inherited;
  PostMessage(Handle, TX_GridPaint, TwwDbGrid(Sender).Handle, 0);
end;

procedure TBaseListingGUI.HandleGridPaint(var Msg: TMessage);
begin
  if self is TBaselistMultiSelectItemsGUI then
    HEaderpanel.visible := false;
  if (((GuiPrefs.Node['SearchMode.type'].asString = 'Full') or (GuiPrefs.Node['SearchMode.type'].asString = '') or (NonSearchMode)) and
      (not(fbShowingWaterMark))) and (not(fbForceWaterMark)) then begin
    grdMain.OnBeforePaint := nil;
    exit;
  end;
  ShowSearchModeWaterMark;
end;
procedure TBaseListingGUI.ShowWaterMark(Img :TImage);
begin
  fbShowingWaterMark := True;
  imgGridWatermark.picture.Assign(Img.Picture);
  grdMain.OnBeforePaint := grdMainBeforePaint;
  //ShowSearchModeWaterMark;
end;
procedure TBaseListingGUI.ShowSearchModeWaterMark;
var
  Min: integer;
  Max: integer;
  LeftPos: integer;
  TopPos: integer;
  ControlCanvas: TControlCanvas;
  ScrollBarVisible: boolean;
  ScrollBarAdjust: integer;
  TmpBitmap: TBitmap;
begin
  if not(csDestroying in ComponentState) then begin
    inherited;
    TmpBitmap := TBitmap.Create;
    ControlCanvas := TControlCanvas.Create;
    try
      //
      // Determine if the horizontal scroll bar is visible and adjust the
      // vertical positioning of the watermark if it is
      //
      GetScrollRange(grdMain.Handle, SB_HORZ, Min, Max);
      ScrollBarVisible := (Min <> Max);
      if ScrollBarVisible then ScrollBarAdjust := 16
      else ScrollBarAdjust := 0;
      TmpBitmap.Transparent := True;
      TmpBitmap.TransparentColor := Self.Color;
      TmpBitmap.Width := grdMain.Width;
      TmpBitmap.Height := grdMain.Height;
      ControlCanvas.Control := grdMain;
      TmpBitmap.Canvas.CopyRect(Rect(0, 0, grdMain.Width, grdMain.Height), ControlCanvas, Rect(0, 0, grdMain.Width, grdMain.Height));
      //
      // Calculate the position to draw the watermark
      //
      LeftPos := (grdMain.Width - imgGridWatermark.Picture.Bitmap.Width - 20) div 2;
      TopPos := (grdMain.Height - imgGridWatermark.Picture.Bitmap.Height + grdMain.RowHeights[0] - ScrollBarAdjust) div 2;
      //
      // Draw watermark
      //
      ControlCanvas.Draw(LeftPos, TopPos, imgGridWatermark.Picture.Bitmap);
      //
      // Paint the grid over the watermark
      //
      ControlCanvas.Draw(0, 0, TmpBitmap);
    finally
      FreeandNil(TmpBitmap);
      FreeandNil(ControlCanvas);
      fPaintTimer.enabled := True;
    end;

  end;

end;

procedure TBaseListingGUI.ShowtimedMsgOnshow;
begin
  if fstimedMsgOnshow = '' then exit;
  TRy
    pnltimedMsgOnshow:= TDNMPanel.Create(Self);
    pnltimedMsgOnshow.Left :=  grdmain.left + 150;
    pnltimedMsgOnshow.Top :=  grdmain.top +20;
    pnltimedMsgOnshow.Width :=  grdmain.Width - 300;
    pnltimedMsgOnshow.Height :=  grdmain.height-40;
    pnltimedMsgOnshow.BevelOuter :=  bvNone;
    pnltimedMsgOnshow.Font.Charset :=  DEFAULT_CHARSET;
    pnltimedMsgOnshow.Font.Color :=  clGreen;
    pnltimedMsgOnshow.Font.Size := 24;
    pnltimedMsgOnshow.Font.Name :=  'Arial';
    pnltimedMsgOnshow.Font.Style :=  [fsBold];
    pnltimedMsgOnshow.ParentFont :=  False;
    pnltimedMsgOnshow.TabOrder :=  2;
    pnltimedMsgOnshow.Transparent :=  True;;
    pnltimedMsgOnshow.PArent := grdmain.Parent;
    pnltimedMsgOnshow.Caption := fstimedMsgOnshow;
    pnltimedMsgOnshow.Visible := True;
    if devmode then   pnltimedMsgOnshow.borderstyle := bssingle else pnltimedMsgOnshow.borderstyle := bsNone;

    tmrtimedMsgOnshow.Enabled := True;
  Except

  End;
end;

procedure TBaseListingGUI.fPaintTimerTimer(Sender: TObject);
begin
  try
    if not(csDestroying in ComponentState) and Visible then
    begin
      grdMain.OnBeforePaint := nil;
      grdMain.Invalidate;
    end;
    fPaintTimer.enabled := false;
  Except
    on E:Exception do begin
      fPaintTimer.enabled := False;
    end;
  end;
end;

procedure TBaseListingGUI.grdMainKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if ((Key >= '0') and (Key <= '9')) or ((Key >= 'A') and (Key <= 'Z')) or ((Key >= 'a') and (Key <= 'z')) then begin
    if (edtSearch.Visible) and (edtSearch.enabled) then begin
      edtSearch.Text := Key;
      SetControlFocus(edtSearch);
      edtSearch.SelStart := 1;
      edtSearch.SelLength := 0;
    end;
  end;
end;

procedure TBaseListingGUI.grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Assigned(fOnGidMultiselect) then fOnGidMultiselect(Grid,Selecting,Accept);
end;

procedure TBaseListingGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Assigned(fOnGidMultiselect) then fOnGidMultiselect(Grid,Selecting,Accept);
end;

class procedure TBaseListingGUI.ShowLookuplist(onrecordSelect: TOnGridDataSelect);
var
  Form: TBaseListingGUI;
begin
  Form := TBaseListingGUI(GetComponentByClassName(ClassName, True));
  if not Assigned(Form) then exit;
  if Form.Visible then begin
    MessageDlgXP_Vista('Please Close The ' + Form.TitleLabel.Caption + '.', mtWarning, [mbOK], 0);
    Form.BringToFront;
    exit;
  end;
  Form.DoShowLookuplist;
  Form.OnGridDataSelect := onrecordSelect;
  Form.FormStyle := fsMDIChild;
  Form.BringToFront;
end;

procedure TBaseListingGUI.ShowParentComponents(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;

  if not(Sender is Tcontrol) then exit;

  for ctr:= 0 to componentcount-1 do
    if Components[ctr] is Tcontrol then
      if Tcontrol(Components[ctr] ).Parent = Tcontrol(Sender) then
        if Tcontrol(Components[ctr]).Visible then begin
          sShowParentComponents:= sShowParentComponents+ NL + Tcontrol(components[ctr]).PArent.name +'.' +Tcontrol(components[ctr]).Name +'-' + inttostr(Tcontrol(components[ctr]).Left) +':' +inttostr(Tcontrol(components[ctr]).Top)+ '  - ' + inttostr(Tcontrol(components[ctr]).Width) +':' +inttostr(Tcontrol(components[ctr]).Height);
          if (Components[ctr] is TPanel) or (Components[ctr] is TDnmPanel) then ShowParentComponents(Components[ctr]);
        end;

end;

procedure TBaseListingGUI.ShowParentComponentsclick(Sender: TObject);
begin
  inherited;
  sShowParentComponents:= '';
  ShowParentComponents(Tcontrol(Sender).parent);
  MessageDlg(sShowParentComponents, mtInformation, [mbOK], 0);
end;

procedure TBaseListingGUI.DoAfterallSelected;
begin
  IterateProcNo:= ItearteProcno4ValidateSelection;
  IterateselectedRecordsReverse;
end;
procedure TBaseListingGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
begin
  if IterateProcNo=ItearteProcno4ValidateSelection then begin
    if not(isvalidtoSelect) then
      grdMain.SelectedList.DeleteSelection(SelIndex);
  end else if IterateProcNo=ItearteProcno4AddSelectedRecords then begin
      DoRecSelect;
  end;
end;
Procedure TBaseListingGUI.Refreshdates;
begin
  PostMessage(Self.Handle, SX_DatechangeMsg, 0, 0);
  FromPrevDate := dtFrom.DateTime;
  ToPrevDate := dtTo.DateTime;
end;

function TBaseListingGUI.DoDtFromChange(Sender: TObject): boolean;
begin
  Result := false;
  if dtFrom.DateTime > dtTo.DateTime then dtFrom.DateTime := dtTo.DateTime;
  if not dtFrom.DroppedDown then begin
    if not(dtFrom.DateTime = FromPrevDate) and (screen.activecontrol = dtFrom) then begin
      PostMessage(Self.Handle, SX_DatechangeMsg, 0, 0);
      Result := True;
    end;
    FromPrevDate := dtFrom.DateTime;
  end;
end;

function TBaseListingGUI.DoDtToChange(Sender: TObject): boolean;
begin
  Result := false;
  if not dtFrom.visible then dtFrom.date := 0;
  if dtFrom.DateTime > dtTo.DateTime then dtTo.DateTime := dtFrom.DateTime;
  if not dtTo.DroppedDown then begin
    if not(dtTo.DateTime = ToPrevDate) and (Screen.activeControl = dtTo) then begin
      PostMessage(Self.Handle, SX_DatechangeMsg, 0, 0);
      Result := True;
    end;
    ToPrevDate := dtTo.DateTime;
  end;
end;

procedure TBaseListingGUI.DoExtraTranslation;
begin
  inherited;
  if Assigned(GuiPrefs) and GuiPrefs.Active then
  try
    Guiprefs.DoTranslate;
  except

  end;
end;

function TBaseListingGUI.DoingFormShow: boolean;
begin
  result:= FormShowCount > 0;
end;

procedure TBaseListingGUI.DoQrymainafteropen;
begin

end;

procedure TBaseListingGUI.DoRefreshQuery;
begin
  RefreshQuery;
end;

procedure TBaseListingGUI.DoShowLookuplist;
begin
  // descendants will overrride if required
end;

procedure TBaseListingGUI.ApplySpecialformfilter;
begin
  // Descendants will overrride if necessary
end;

procedure TBaseListingGUI.EditCustomfilter1Click(Sender: TObject);
var
  fsFilter: string;
  fs: string;
begin
  inherited;
  fsFilter := Customfilter.Filterstatement;
  Customfilter.Filterstatement := InputBox('Change Custom Filter', '', Customfilter.Filterstatement);
  if not Customfilter.ValidateFilter then Customfilter.Filterstatement := fsFilter;
  fs := Customfilter.Filterstatement;
  fs := ReplaceStr(fs, ':CurDate', QuotedStr(FormatDateTime(FormatSettings.ShortDateFormat, Date)));
  fs := ReplaceStr(fs, ':CurDateTime', QuotedStr(FormatDateTime(FormatSettings.LongDateFormat, Date)));
  FilterLabel.Caption := Trim(fs);

end;

procedure TBaseListingGUI.ProcessSearch(const fieldname, Value: string);
begin
  QueryManipulationObj.ProcessSearch(fieldname, Value);
  qryMain.SQL.Text := QueryManipulationObj.ModifiedSQL;
  RefreshOrignalSQL;
end;

procedure TBaseListingGUI.RefreshOrignalSQL(Addlimit0:Boolean =true);
begin
if assigned(QueryManipulationObj) then
  QueryManipulationObj.RefreshOrignalSQL(qryMain.SQL.Text, Addlimit0);
end;

procedure TBaseListingGUI.SetGridColumns;
begin
  // descendants will override if need to hide /remove the fieds etc.
  //  RemoveFieldfromGrid('fieldname');
    if fbHideSitefields then begin
      RemoveFieldfromGrid('mstimeStamp');
      RemoveFieldfromGrid('msUpdateSiteCode');
    end;
    if fbhideIDFields then begin
      RemoveFieldfromGrid('ID');
      RemoveFieldfromGrid('Globalref');
    end;
    if not AppEnv.CompanyPrefs.Fe1Visible then begin RemoveFieldfromGrid('Fe1Visible');RemoveFieldfromGrid('Fe1Name');end;
    if not AppEnv.CompanyPrefs.Fe2Visible then begin RemoveFieldfromGrid('Fe1Visible');RemoveFieldfromGrid('Fe2Name');end;
    if not AppEnv.CompanyPrefs.Fe3Visible then begin RemoveFieldfromGrid('Fe1Visible');RemoveFieldfromGrid('Fe3Name');end;
    if not AppEnv.CompanyPrefs.Fe4Visible then begin RemoveFieldfromGrid('Fe1Visible');RemoveFieldfromGrid('Fe4Name');end;
    if not AppEnv.CompanyPrefs.Fe5Visible then begin RemoveFieldfromGrid('Fe1Visible');RemoveFieldfromGrid('Fe5Name');end;
end;
procedure TBaseListingGUI.SetHaveDateRangeSelection(const Value: boolean);
begin
  fbHaveDateRangeSelection := Value;
  chkIgnoreDates.visible := Value;
  cboDateRange.visible := Value;
  lblFrom.visible := Value;
  dtFrom.visible := Value;
  lblTo.visible := Value;
  dtTo.visible := Value;
end;
procedure TBaseListingGUI.SetHaveDateSelectionOptions(const Value: Boolean);
begin
  fbhaveDateSelectionOptions := Value;
  if devmode then begin
    TfmBaseListDateSelectionOptions.Create(Self);
  end;
end;

(*procedure TBaseListingGUI.SetHasAsondateRange(const Value: boolean);
begin
fbHasAsondateRange  := Value;
if Value then begin
  cboDateRange.visible := False;
  lblFrom.visible := False;
  dtFrom.visible := False;

  chkIgnoreDates.visible := True;
  lblTo.visible := true;
  lblTo.alignment := taRightJustify;
  lblTo.Caption := 'As on :';
  dtTo.visible := True;

  chkIgnoreDates.wordwrap := False;
  //chkIgnoreDates.top :=lblTo.top;
  chkIgnoreDates.width := 100;
  chkIgnoreDates.Left := lblTo.left;
end;
end;*)

procedure TBaseListingGUI.SetHaveOnlyToDate(TodateCaption: STring;  const Value: Boolean);
begin
  if Value then begin
    lblTo.alignment         := taRightJustify;
    lblTo.caption           := TodateCaption;
    cboDateRange.visible    := False;
    lblFrom.visible         := False;
    dtFrom.visible          := False;
    chkIgnoreDates.visible  := True;
    chkIgnoreDates.Left     := lblTo.Left;
    chkIgnoreDates.height   := lblTo.height;
    chkIgnoreDates.Top      := 3;
    chkIgnoreDates.Wordwrap := False;
    chkIgnoreDates.Width    := 100;
  end;
end;

procedure TBaseListingGUI.SetIndicatorbutton;
begin
       if grdMain.TitleLines = 1 then btnGrid.Height := 22
  else if grdMain.TitleLines = 2 then btnGrid.Height := 34
  else if grdMain.TitleLines = 3 then btnGrid.Height := 49
  else if grdMain.TitleLines = 4 then btnGrid.Height := 64;
end;


procedure TBaseListingGUI.setInitSearchValue(const Value: String);
var
  iIndex:Integer;
begin
  if sametext(value , '[Open List]') then exit;
  InitFormforSearchValue(Value);
  if (trim(SearchWhenNotInlistfield)<> '') and (qrymain.FindField(SearchWhenNotInlistfield)<> nil)  then begin
      iIndex := cboFilter.Items.IndexOf(StringReplace(qrymain.FindField(SearchWhenNotInlistfield).DisplayLabel,'~',' ',[rfReplaceAll]));
      if iIndex <> -1 then cboFilter.ItemIndex := iIndex;
  end;


  edtSearch.Text := Value;
  GuiPrefs.Node['SearchMode.type'].asString := 'Full';
  SendKeys('{F6}',true);
  RefreshQuery;
end;

procedure TBaseListingGUI.ChangeNote(Note: String; notecolor: Tcolor = clred; noteSize:Integer =9);
begin
  lblNote.caption := Note;
  lblNote.visible := true;
  lblNote.Enabled := True;
  lblNote.font.Color := notecolor;
  lblNote.font.Size:= noteSize;
end;

function TBaseListingGUI.ChangeQuery(Query: string): string;
begin
  Result := SyncReportObj.ChangeQuery(Query, usingReportTables);
  if usingReportTables then
    if AppEnv.CompanyPrefs.TransactionTableLastUpdated <> 0 then
        Self.Caption := TitleLabel.Caption + ReportTableUpdatedtime;
end;
procedure TBaseListingGUI.ChangeSelectionPanel(const PArentPanel: TPanel; aAlign :TAlign = alnone);
begin
  if Assigned(EmployeeLookupform) then
      with EmployeeLookupform do begin
        pnl.Parent  := ParentPanel;
        pnl.color :=ParentPanel.color;
        pnl.ParentColor :=  True;
        if aAlign <> alnone then pnlAlign := aAlign;
      end;
  if Assigned(ProductLookupform)  then
      with ProductLookupform do begin
        pnl.Parent   := ParentPanel;
        pnl.color :=ParentPanel.color;
        pnl.ParentColor :=  True;
        if aAlign <> alnone then pnlAlign  := aAlign;
      end;
  if Assigned(ClassLookupform)    then
      With ClassLookupform do begin
        pnl.Parent     := ParentPanel;
        pnl.color :=ParentPanel.color;
        pnl.ParentColor :=  True;
        if aAlign <> alnone then pnlAlign    := aAlign;
      end;


  if ParentPanel = HeaderPanel then
    SetSelectionOptionsFor(Selectionoption)
  else if Assigned(PArentPanel.Owner) and (PArentPanel.Owner is TfmBaselistingSelectionPopup) then begin
    if Assigned(ClassLookupform)      then
      with ClassLookupform do
        TfmBaselistingSelectionPopup(ParentPanel.Owner).height := TfmBaselistingSelectionPopup(ParentPanel.Owner).height + pnl.height+pnl.Margins.top + pnl.Margins.Bottom;
    if Assigned(EmployeeLookupform)   then
      With EmployeeLookupform do
        TfmBaselistingSelectionPopup(ParentPanel.Owner).height := TfmBaselistingSelectionPopup(ParentPanel.Owner).height + pnl.height+pnl.Margins.top + pnl.Margins.Bottom;
    if Assigned(ProductLookupform)    then
      with ProductLookupform do
      TfmBaselistingSelectionPopup(ParentPanel.Owner).height := TfmBaselistingSelectionPopup(ParentPanel.Owner).height + pnl.height+pnl.Margins.top + pnl.Margins.Bottom;

  end;
end;

function TBaseListingGUI.ReportSQLobj: TReportSQLBase;
begin
  REsult :=fReportSQLobj;
end;

function TBaseListingGUI.ReportTableUpdatedtime(lineBreak:Boolean =False):String;
begin
  Result :=iif(lineBreak , 'Data on This Report is'+NL ,  '     -    ') +
          'Based on Report Tables Last Updated On ' +iif(lineBreak , NL , '') +
          quotedstr(FormatDateTime('dddd, mmmm d, yyyy, " at " hh:mm AM/PM',AppEnv.CompanyPrefs.ReportTablesLastUpdatedOn));
end;

procedure TBaseListingGUI.Repositionheaderwithinpanel;
begin
  SetupFormInPanel;
end;

procedure TBaseListingGUI.rptsynchreporttablesClick(Sender: TObject);
begin
  inherited;
  SyncReportObj.DosyncAll;
  btnRequery.Click;
end;

procedure TBaseListingGUI.DoTablestoSync;
begin
  SyncReportObj.DosyncTables(TablestoSync);
end;
procedure TBaseListingGUI.showGraph;
begin
 if not (grpView.Visible) then grpView.Visible:= True;
 if grpView.itemindex <> 0 then grpView.itemindex := 0 else refreshgraph;
end;
function  TBaseListingGUI.Printchart  :boolean;
begin
  result:= False;
  if Graphform <> nil then begin
    Graphform.printchart;
    result:= True;
    MessageDlg('The chart ' + quotedstr(charttolaunch) +' is being printed.', mtInformation, [mbOK], 0);
  end;
end;
procedure TBaseListingGUI.RefreshGraph;
var
  ctr:Integer;
begin
  if charttolaunch = '' then charttolaunch := Defaultchart(Self.classname);
  if charttolaunch = '' then exit;
  Panel1.visible := False;
  pnlGraph.visible := True;
  if Graphform = nil then
    Graphform := TListChartView(GetComponentByClassName('TListChartView', true, Self));
  Graphform.ShowChartView(Qrymain, charttolaunch, pnlGraph, Self.classname, pnlGraph.PopupMenu);
  for ctr:= 0 to mnuCharts.Items.Count-1 do begin
    mnuCharts.Items[ctr].Checked :=  SameText(charttolaunch , replaceStr(mnuCharts.Items[ctr].Caption , '&' , ''));
  end;
end;

function TBaseListingGUI.IncludedataPriorToClosingDate: Boolean;
begin
  result:= pnlIncludehistory.visible and chkIncludehistory.checked;
end;

function TBaseListingGUI.Emailreport(Emailsubject , Emailbody, RecipientAddress, reportType  :String; sSQL:String;fsReportName:String; reportfilename:String;
 SilentEmail : boolean = false; SecretEmail : boolean = false) :boolean;
var
  OutGoingFileName: string;
  EmailDate       : TDateTime;
  Corres: TCorrespondenceGui;
  ReportAttachmentfiles :String;
begin
  Result          := False;
  OutGoingFileName:= '';
  Corres := TCorrespondenceGui.Create;
  try
    if RecipientAddress = '' then begin
      CommonLib.MessageDlgXP_Vista(' Email address is blank.', mtInformation , [mbOK], 0);
      Exit;
    end;

    try
        SaveTemplateReport(fsReportName, sSQL, true, 'PDF');
        Corres.Subject := Emailsubject;

        Corres.RecipientList := RecipientAddress;
        Corres.MessageText := Emailbody;

        OutGoingFileName := reportfilename;
        if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
          copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'), PChar( Commonlib.TempDir  + OutGoingFileName), false);
        end;

        // Wait For OS Copy
        Sleep(1000);
        Application.ProcessMessages;


        if FileExists( Commonlib.TempDir  + OutGoingFileName) then
          Corres.AttachmentList.Add(Commonlib.TempDir  + OutGoingFileName);
        ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(fsReportName));
        if Corres.Execute(SilentEmail, SecretEmail) then begin
          EmailDate := Now;
          LogEmailedReport(0 , AppEnv.Employee.employeeID , EmailDate  , reportType , AppEnv.AccessLevels.GetFormDescription(Self.classname));
          result := true;
        end;

        DeleteFiles( Commonlib.TempDir , '*.PDF');
        DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
    except

    end;
  finally
    Corres.Free;
    DeleteFiles( Commonlib.TempDir , '*.PDF');
  end;
end;
function TBaseListingGUI.Email_subject: String;
begin
  REsult := AppEnv.AccessLevels.GetFormDescription(Self.classname);
end;
function TBaseListingGUI.Email_body: String;
begin
  REsult := AppEnv.AccessLevels.GetFormDescription(Self.classname);
end;

procedure TBaseListingGUI.DoFormSize(ChangeSize:Boolean);
begin
  if (ChangeSize and (SizeMode ='N')) or (not(ChangeSize) and (SizeMode='M')) then begin
    if Self.WindowState <> wsMaximized then
      Self.WindowState := wsMaximized;
    SizeMode := 'M';
  end else begin
    if Self.WindowState <> wsNormal then
      Self.WindowState := wsNormal;
    SizeMode := 'N';
  end;
end;

procedure TBaseListingGUI.mnuDefaultOrderClick(Sender: TObject);
begin
  inherited;
  if qryMain.IndexFieldNames = '' then exit;
  try
    closeDB(qryMain);
    qryMain.IndexFieldNames := '';
    Application.ProcessMessages;
  finally
    opendb(qryMain);
  end;
end;
Function TBaseListingGUI.GuiPrefNode(Const nodeName:String):TDataTreeNode;
begin
  result := nil;
  if not Assigned(GuiPrefs) then exit;
  if GuiPrefs.active = false then exit;
  if not GuiPrefs.Node.Exists(nodeName) then exit;
  result := TDataTreeNode(GuiPrefs.Node[nodeName]);
end;
Function TBaseListingGUI.GuiPrefIntValue(Const nodeName:String; defaultValue:Integer = -1):Integer;
var
  dtn : TDataTreeNode;
begin
  result := defaultValue;
  dtn := GuiPrefNode(nodeName);
  if not(Assigned(dtn)) then exit;
  result := dtn.AsInteger;
end;

Function TBaseListingGUI.DefaultAllClasses        : Integer;begin Result := GuiPrefIntValue('Options.DefaultAllClasses')        ;  end;
Function TBaseListingGUI.DefaultAllProducts       : Integer;begin Result := GuiPrefIntValue('Options.DefaultAllProducts')      ;  end;
Function TBaseListingGUI.DefaultAllEmployees      : Integer;begin Result := GuiPrefIntValue('Options.DefaultAllEmployees')      ;  end;
Function TBaseListingGUI.DEfaultSelectedClassID   : Integer;begin Result := GuiPrefIntValue('Options.DEfaultSelectedClassID')   ;  end;
Function TBaseListingGUI.DEfaultSelectedProductID : Integer;begin Result := GuiPrefIntValue('Options.DEfaultSelectedProductID') ;  end;
Function TBaseListingGUI.DEfaultSelectedEmployeeID: Integer;begin Result := GuiPrefIntValue('Options.DEfaultSelectedEmployeeID');  end;
function TBaseListingGUI.getSelectedRecords       : integer;begin result := grdMain.SelectedList.Count;end;
function TBaseListingGUI.getShowPreview           : Boolean;begin Result := chkPreview.Checked;end;
function TBaseListingGUI.getAllClasses            : Boolean;begin REsult := False; if IsSubform then result := True else if not Assigned(ClassLookupform)    then exit else   result := ClassLookupform.UseAll     ;end;
function TBaseListingGUI.getAllEmployees          : Boolean;begin REsult := False; if IsSubform then result := True else if not Assigned(EmployeeLookupform) then exit else   result := EmployeeLookupform.UseAll  ;end;
function TBaseListingGUI.getAllProducts           : Boolean;begin REsult := False; if IsSubform then result := True else if not Assigned(ProductLookupform)  then exit else   result := ProductLookupform.UseAll   ;end;

function TBaseListingGUI.getRowSelect: Boolean;
begin
  result := (dgRowSelect in grdMain.Options);
end;

function TBaseListingGUI.getSelectedClassID       : Integer;begin REsult := 0;     if IsSubform then result := 0 else if not Assigned(ClassLookupform)       then exit else   result := ClassLookupform.LookupID   ;end;
function TBaseListingGUI.getSelectedemployeeID    : Integer;begin REsult := 0;     if IsSubform then result := 0 else if not Assigned(EmployeeLookupform)    then exit else   result := EmployeeLookupform.LookupID;end;
function TBaseListingGUI.getSelectedID(const IDFieldname: String): Integer;
begin
  Result := 0;
  Try
     Result := Qrymain.Findfield(IDFieldname).asInteger;
  Except
    //
  End;
end;
function TBaseListingGUI.getSelectedData(const aFieldname: String): String;
begin
  Result := '';
  Try
     Result := Qrymain.Findfield(aFieldname).asString;
  Except
    //
  End;
end;

function TBaseListingGUI.getSelectedProductID     : Integer;begin REsult := 0;     if IsSubform then result := 0 else if not Assigned(ProductLookupform)     then exit else   result := ProductLookupform.LookupID ;end;

procedure TBaseListingGUI.OnClassSelection   (Sender:TObject);begin  RefreshQuery;end;
procedure TBaseListingGUI.OnEmployeeSelection(Sender:TObject);begin  RefreshQuery;end;
procedure TBaseListingGUI.OnProductSelection (Sender:TObject);begin  RefreshQuery;end;

procedure TBaseListingGUI.SetAllEmployees(const Value: Boolean);begin if not Assigned(EmployeeLookupform) then exit;  EmployeeLookupform.UseAll := Value; end;
procedure TBaseListingGUI.SetAllProducts (const Value: Boolean);begin if not Assigned(ProductLookupform)  then exit;  ProductLookupform.UseAll  := Value; end;

class procedure TBaseListingGUI.MakeaList(AOwner:TComponent;Const SQL:String; AllowMultiSelect :Boolean; TitleCaption:String; SelectedText:String =''; BeforeShow:TNotifyEvent=nil;AfterShow:TNotifyEvent=nil;OnSelect:TOnGridDataSelect=Nil;IsModel:Boolean =False; aConnection:TERPConnection = nil);
var
  List : TBaseListingGUI;
begin
  List := TBaseListingGUI.create(AOwner);
  try

    if Assigned(List) then begin //if has acess
      List.passedconnection := aConnection;
      List.Caption := titleCaption;
      List.Qrymain.SQL.text := SQL;
      List.RefreshOrignalSQL(False);
      if SelectedText <> '' then List.grdMain.Selected.Text := SelectedText;
      if pos('~' , SelectedText)>0 then begin
        List.grdMain.TitleLines := 2;
        List.SetIndicatorbutton
      end;
      List.HaveDateRangeSelection :=  False  ;
      If Assigned(BeforeShow) then BeforeShow(List);

        TBaseListingGUI(List).cmdNew.enabled := false;
        if AllowMultiSelect then begin
          TBaseListingGUI(List).grdMain.Options:=TBaseListingGUI(List).grdMain.Options + [dgMultiSelect];
          TBaseListingGUI(List).grdMain.MultiSelectOptions := [msoAutoUnselect,msoShiftSelect];
        end;
        TBaseListingGUI(List).OnGridDataSelect:= onSelect;
        //TBaseListingGUI(List).NonSearchReport := True;
        TBaseListingGUI(List).SearchMode := smFullList;
        if IsModel then
          TBaseListingGUI(List).showmodal
        else begin
          List.FormStyle := fsmdiChild;
          List.bringToFront;
          If Assigned(AfterShow) then AfterShow(List);
        end;
      end;
  finally
    if IsModel then FreeandNil(List);
  end;
end;
function TBaseListingGUI.GridGuiObj: TGridGuiObj;
begin
  if fGridGuiObj = nil then begin
    fGridGuiObj := TGridGuiObj.create(self);
    fGridGuiObj.grid := grdmain;
  end;
  Result := fGridGuiObj;
end;
procedure TBaseListingGUI.GridinLargefont;
begin
  grdMain.Font.size := LARGE_FONT_SIZE;
  grdMain.TitleFont.size := LARGE_FONT_SIZE;
end;
procedure TBaseListingGUI.initchkShowEmailOptions;
begin
  if GuiPrefs.Node.Exists('Options.DoNotAsk')  then begin
    chkShowEmailOptions.checked := not(GuiPrefs.Node['Options.DoNotAsk'].asBoolean);
    fiEmailMsgOption :=  GuiPrefs.Node['Options.MsgOption'].asInteger;
    chkShowEmailOptions.visible := not(chkShowEmailOptions.checked);
  end else begin
    fiEmailMsgOption :=  104;
    chkShowEmailOptions.visible := False;
  end;
end;
Function TBaseListingGUI.DoNotAskMsg :boolean;
begin
  REsult := False;
  if GuiPrefs = nil then exit;
  if GuiPrefs.active =false then GuiPrefs.active := True;
  if GuiPrefs.Node.Exists('Options.DoNotAsk') then
    REsult :=  GuiPrefs.Node['Options.DoNotAsk'].asBoolean;
end;

procedure TBaseListingGUI.DoOnDoNotAskMsgCheck(Sender: TObject;Checked: boolean);
begin
    if GuiPrefs = nil then exit;
    if GuiPrefs.active =false then GuiPrefs.active := True;
    if sender is TMessageDlgXP_VistaOption then begin
      GuiPrefs.Node['Options.MsgOption'].asInteger :=TMessageDlgXP_VistaOption(Sender).msgOption;
      fiEmailMsgOption := TMessageDlgXP_VistaOption(Sender).msgOption;
    end else begin
      GuiPrefs.Node['Options.DoNotAsk'].asBoolean  := Checked;
      chkShowEmailOptions.checked := not(checked);
      chkShowEmailOptions.visible := GuiPrefs.Node['Options.DoNotAsk'].asBoolean;
    end;
    if GuiPrefs <> nil then
      if GuiPrefs.active then GuiPrefs.SavePrefs;
end;
procedure TBaseListingGUI.chkShowEmailOptionsClick(Sender: TObject);
begin
  inherited;
  GuiPrefs.Node['Options.DoNotAsk'].asBoolean := not(chkShowEmailOptions.checked );
  GuiPrefs.SavePrefs;
end;
function TBaseListingGUI.BaseListtimerMsgform: TfmBaseListtimerMsg;
begin
  if ffmBaseListtimerMsg = nil then
      ffmBaseListtimerMsg := TfmBaseListtimerMsg.create(Self);
  result := ffmBaseListtimerMsg;
end;
procedure TBaseListingGUI.showReportTableMsg;
begin
  if fbSelectioninPopup then exit;
  if not AppEnv.Employee.ShowReportTablesMsg then exit;
  //if screen.activeform <> self then exit;
  if fbReportTablemsgshown then Exit;
  if qrymain.active and not(bFormStarting) and usingReportTables then begin
    if AppEnv.CompanyPrefs.TransactionTableLastUpdated <> 0 then begin
        ShowReportTableMsgIcon;
        BaseListtimerMsgform.TimerMsg :=ReportTableUpdatedtime(true);
        fbReportTablemsgshown := True;
    end;
  end;

end;
procedure TBaseListingGUI.ShowReportTableMsgIcon;
begin
   imgReportTablesMsg.visible  := devmode;
end;
procedure TBaseListingGUI.InitReportTableMsgIcon;
begin
  if devmode and usingReportTables  then begin
   cboDateRange.width := cboDateRange.width  -imgReportTablesMsg.width -1;
   imgReportTablesMsg.top :=cboDateRange.top;
   imgReportTablesMsg.height :=cboDateRange.height;
   imgReportTablesMsg.Left  :=cboDateRange.Left+cboDateRange.width +1;
  end;
end;
procedure TBaseListingGUI.SelectionOptionQry(Lookupform: TfmBaselistingSelectionLookup; cboQry: TERPQuery);
begin
//
end;

Function TBaseListingGUI.DoSelectionPopup:Boolean;
begin
  REsult := False;
  if fbSelectioninPopup and (SelectionOption <> soNone) then begin
    TfmBaselistingSelectionPopup.ShowSelectionOptions(Self);
    fbSelectioninPopup:= false;
      Result := True;
  end;
end;
procedure TBaseListingGUI.SetSelectionOptionsFor(Value: TSelectionOptions);
begin
{position the header and combos when multipler combos provided }
  if Value = soClassnProduct then begin
    ProductLookupform.pnlalign := alleft;
    if not (HaveDateRangeSelection) then ClassLookupform.pnlalign := alright else
    (*if HasAsondateRange then begin
      ClassLookupform.pnlalign := alleft;
      if pnlHeader.Left < ClassLookupform.pnlWidth + ProductLookupform.pnlWidth then
        pnlHeader.Left :=ClassLookupform.pnlWidth + ProductLookupform.pnlWidth;
      if pnlHeader.Left + pnlHeader.Width > lblTo.Left then
        pnlHeader.Width := lblTo.Left- pnlHeader.Left;
    end else begin*)
      ClassLookupform.pnlalign := alleft;
      if pnlHeader.Left < ClassLookupform.pnlWidth + ProductLookupform.pnlWidth then
        pnlHeader.Left :=ClassLookupform.pnlWidth + ProductLookupform.pnlWidth;
      if pnlHeader.Left + pnlHeader.Width > chkIgnoreDates.Left then
        pnlHeader.Width := chkIgnoreDates.Left- pnlHeader.Left;
    end;
  //end;
end;
function TBaseListingGUI.getIgnoreDateRange: Boolean;
begin
  Result := False;
  if chkIgnoreDates.Visible then
    result:= chkIgnoreDates.Checked;
end;

function TBaseListingGUI.getIsMultiselecting: Boolean;
begin
  result := dgMultiselect in grdMain.Options;
end;
Procedure  TBaseListingGUI.CheckBaselistMultiSelectItems;
begin
  if fbCheckedBaselistMultiSelectItems then exit;
  if self is TBaselistMultiSelectItemsGUI then exit;
  fbCheckedBaselistMultiSelectItems := True;
  if not (IsMultiselecting) then Exit;
  if issubform then exit;
  if (KeyIdfieldname ='') or (KeyNamefieldname = '') then exit;

  if not Appenv.companyprefs.ShowMultiSelectSelectionList then begin
    btnShowMultiSelectSelectionList.visible := True;
    exit;
  end;

  if fBaselistMultiSelectItems<> nil then exit;

  splMultiSelectList.visible := true;
  pnlMultiSelectList.visible := true;
  splMultiSelectList.left := 0;

  BaselistMultiSelectItems;

  {this is to deal with the lists that is opened with selection.
  eg: OTF Product -> ProductList selection (Abad foram)}
  IterateProcno := ItearteProcno4AddSelectedRecords;
  IterateSelectedRecords;
end;

Procedure  TBaseListingGUI.BaselistMultiSelectItems;
var
  x:Integer;
  fForm : TBaselistMultiSelectItemsGUI;
begin
  if fBaselistMultiSelectItems = nil then begin
     fForm := TBaselistMultiSelectItemsGUI.create(self);
     fBaselistMultiSelectItems := fForm;
    fForm.color := Self.color;
    fForm.grdMain.TitleColor := Self.Color;
    fForm.grdMain.FooterColor := Self.Color;
    fForm.IDFieldName :=KeyIdfieldname;
    fForm.NameFieldName:= KeyNamefieldname ;

    fForm.chksortList.Parent := pnlMultiSelectList;
    fForm.chksortList.Align := altop;
    fForm.chksortList.height := 16;

    fForm.Parent := pnlMultiSelectList;
    fForm.align := alclient;
    if GuiPrefs.active then fForm.chksortList.checked := GuiPrefs.Node['Options.MultiSelectSortList'].asBoolean;

    fForm.BorderStyle := bsNone;
    fForm.fbIgnoreQuerySpeed := true;
    try
      fForm.Show;
      pnlMultiSelectList.Paint;
    except

    end;


    x := 100;
    if GuiPrefs.Node.Exists('Options.MultiSelectNameDisplayWidth') then
        x := GuiPrefs.Node['Options.MultiSelectNameDisplayWidth'].asInteger;
    fForm.NamedisplayWidth := x;

    x := 260;
    if GuiPrefs.Node.Exists('Options.MultiSelectItemsWidth')  then
        x:= GuiPrefs.Node['Options.MultiSelectItemsWidth'].asInteger;
    pnlMultiSelectList.Width  := x;
  end;
end;
Function  TBaseListingGUI.DoRecSelect:Boolean;
begin
  result := False;
  if isMultiselecting and (fsKeyNamefieldname<> '') and (fsKeyIdfieldname<> '') then begin
     CheckBaselistMultiSelectItems;
    if (fBaselistMultiSelectItems<> nil) then begin
    if (Qrymain.FindField(fsKeyNamefieldname)<> nil) and (Qrymain.FindField(fsKeyIdfieldname)<> nil) then begin
      TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).addItem(Qrymain.Fieldbyname(fsKeyIdfieldname).asInteger, Qrymain.Fieldbyname(fsKeyNamefieldname).asString);
      Result := TRue;
    end;
    end;
  end;
end;
function TBaseListingGUI.getKeyNamefieldname: String;
begin
  Result := fsKeyNamefieldname;
end;
function TBaseListingGUI.ConfirmSelection:Boolean;
var
  s,s1,s2:String;
  msgoption : Word;
  function OnlyMain:Boolean;
  begin
    result := (s1<>'') and (msgoption=100);
  end;

  function OnlySelection:Boolean;
  begin
    result := ((s1<>'') and (s2<> '') and (msgoption=101)) Or
              ((s1= '') and (s2<> '') and (msgoption=100));
  end;

  function MainnSelection:Boolean;
  begin
    result := ((s1<>'') and (s2<> '') and (msgoption=102)) Or
              ((s1= '') and (s2<> '') and (msgoption=101)) or
              ((s1<>'') and (s2= '')  and (msgoption=101)) ;
  end;

  Function CancelSelection:Boolean;
  begin
    result := ((s1<>'') and (s2<> '') and (msgoption<>103)) Or
              ((s1= '') and (s2<> '') and (msgoption<>101)) or
              ((s1<>'') and (s2=  '') and (msgoption<>101)) ;
  end;

begin
  result := False;
  if (SelectedRecords = 0) and (TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).Qrymain.recordcount = 0) then exit;
  if (SelectedRecords = 1) and (TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).Qrymain.recordcount = 1) then begin
    result := true;
    exit;
  end;

  s:='You have Selected ';
  s1:= '';
  s2:= '';
  if SelectedRecords > 0 then s1:= inttostr(SelectedRecords)+' Record(s) in the Main List';
  if TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).Qrymain.recordcount > 0 then s2:= inttostr(TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).Qrymain.recordcount)+'  Record(s) in the Selection List';
  s:= s +
    iif(s1<> '' , NL+'    ' +s1, '')+
    iif(s2<> '' , NL+'    ' +s2, '')+
    NL+'Continue with Selection?';
{100 : mainlist
101 : selected list
102 : both
}
    msgoption := MessageDlgXP_Vista(s, mtConfirmation, [], 0 , nil, '', '', False, nil,
                                iif(s1<> '',s1+',','')+
                                iif(s2<> '',s2+',','')+
                                iif((s1<> '') and (s2<>'') , 'All,','')+
                                'Cancel');
    if  OnlyMain then
      TBaselistMultiSelectItemsGUI(fBaselistMultiSelectItems).DeleteAll;

    if OnlyMain or MainnSelection then begin
      IterateProcno := ItearteProcno4AddSelectedRecords;
      IterateSelectedRecords;
    end;

    result := CancelSelection;
end;

function TBaseListingGUI.ReadControlDisplayName(Sender: TObject): String;
begin
  if Sender = grdmain then result :='Data List'
  else if sender =cboFilter then result := 'Fields to Search'
  else if (sender =btnF7) or (Sender = btnF6) or (Sender = btnF5) or (Sender =edtSearch)  then result := 'Search Options'
  else if (sender =chkIgnoreDates) or (Sender = cboDateRange) or (Sender = dtFrom) or (Sender = dtTo) then result := 'Date Filter Options'
  else result := inherited ReadControlDisplayName(Sender);
end;

procedure TBaseListingGUI.chkhideMultiSelectSelectionListClick(Sender: TObject);
begin
  inherited;
  Appenv.companyprefs.ShowMultiSelectSelectionList := False;
end;
function TBaseListingGUI.SelectedDateRangeMsg: String;
begin
  Result := FormatDateTime(FormatSettings.ShortDateFormat , filterDateFrom) +' and ' + FormatDateTime(FormatSettings.ShortDateFormat , filterDateTo);
end;

procedure TBaseListingGUI.SetForeignFieldDisplayFormat(Amtfieldname, CurCodefieldName:String);
var
  CurrencySymbol,fmt: string;
  fld: TField;
begin
  try
      if (CurCodefieldName<>'') and (qrymain.FindField(CurCodefieldName)<> nil) then
        CurrencySymbol:= TCurrency.CurrencySymbolForCode(qrymain.FindField(CurCodefieldName).asString)
      else CurrencySymbol:= '';

      fmt:= CurrencySymbol + '#,##0.000;(' + CurrencySymbol + '#,##0.000)';
      if qrymain.Active then begin
        fld:= qrymain.FindField(Amtfieldname);
        if Assigned(fld) then TFloatField(fld).DisplayFormat:= fmt;
      end;
  Except
    // kill the exception if any
  end;
end;
procedure TBaseListingGUI.HideZeroValueInNumberfield(State: TGridDrawState; Field: TField; AFont: TFont; ABrush: TBrush;Dofloat :boolean =true; DoInteger :boolean =true; DoDates :boolean =true);
begin
  inherited;
  if Dofloat then begin
    if Field is TFloatfield then
      if TFloatfield(Field).asFloat =0 then
        DoHide(Field,State,Afont,ABrush);
  end;
  if DoInteger then begin
    if Field is TIntegerfield then begin
      if TIntegerfield(Field).asFloat =0 then
        DoHide(Field,State,Afont,ABrush);
    end else if Field is TLargeintField then begin
      if TLargeintField(Field).asFloat =0 then
        DoHide(Field,State,Afont,ABrush);
    end;
  end;
  if doDates then begin
    if Field is Tdatefield then begin
      if Tdatefield(Field).asFloat =0 then
        DoHide(Field,State,Afont,ABrush);
    end else if Field is TDateTimefield then begin
      if TDateTimefield(Field).asFloat =0 then
        DoHide(Field,State,Afont,ABrush);
    end;
  end;
end;
procedure TBaseListingGUI.btndecClick(Sender: TObject);
begin
  changeheight(true);
end;

procedure TBaseListingGUI.btnincClick(Sender: TObject);
begin
  inherited;
  ChangeHeight(False);
end;
Procedure TBaseListingGUI.ChangeHeight(doinc :Boolean );
var
  aFormResize : TNotifyEvent;
begin
  inherited;
  aFormResize :=Self.onResize;
  Self.onResize := nil;
  try
    if doinc then
         self.Height :=self.Height +1
    else self.Height :=self.Height -1;
    logtext(iif(dgShowFooter in grdmain.Options, 'Has Footer' , 'No Footer')+':'+   inttostr(self.Height));
  finally
    Self.onResize := aFormResize ;
  end;
end;
procedure TBaseListingGUI.initList;
begin
  btninc.visible := HeaderPanel.visible and  devmode;
  btndec.visible := HeaderPanel.visible and devmode;
  if dgShowFooter in grdmain.options then begin
    if grdmain.titlelines =1 then
         Self.height := 604
    else Self.height := 595;
    grdmain.options := grdmain.options - [dgFooter3DCells];
  end else begin
    if grdmain.titlelines =1 then
         Self.height := 601
    else Self.height := 593;
  end;
end;
procedure TBaseListingGUI.HideStatus;
begin
  lblTimerMsg.Visible := False;
end;
procedure TBaseListingGUI.ShowStatus(Const Value:String);
begin
  if Value = '' then Exit;
  lblTimerMsg.caption := Value;
  lblTimerMsg.Visible := TRue;
  lblTimerMsg.Refresh;
end;

end.

