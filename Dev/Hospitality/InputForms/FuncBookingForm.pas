unit FuncBookingForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/02/06 1.00.01  DSP  Added customise fields to the grids.
 15/02/06 1.00.02  DSP  Changed dtpTime to use a 24 hour clock. 

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, Buttons, DNMSpeedButton,
  StdCtrls, DBCtrls, wwdbdatetimepicker, Mask, wwdblook, ExtCtrls, DNMPanel,
  wwdbedit, Wwdotdot, Wwdbcomb, wwcheckbox, Wwdbspin, Grids, Wwdbigrd,
  Wwdbgrid, ComCtrls, dbcgrids, wwriched, Psock, NMsmtp, ActnList, ImgList,
  DBAccess, MyAccess, DataState, Menus, AdvMenus, MemDS, Shader;

const
  SX_CalcTotalsMsg = WM_USER + 100;

type
  TFuncBookingGUI = class(TBaseInputGUI)
    DSFuncBookings: TDataSource;
    qryClientsLookup: TMyQuery;
    qryClientsLookupCompany: TStringField;
    qryClientsLookupStopCreditImage: TIntegerField;
    qryClientsLookupClientID: TIntegerField;
    qryClientsLookupCustomer: TStringField;
    qryClientsLookupStopCredit: TLargeIntField;
    tbTimeInc: TMyQuery;
    DSClientLookup: TDataSource;
    qryRoomLookup: TMyQuery;
    cboClassQry: TMyQuery;
    cboClassSrc: TDataSource;
    cboServiceIDQry: TMyQuery;
    cboServiceIDQryServiceID: TAutoIncField;
    cboServiceIDQryRate: TFloatField;
    cboServiceIDQryServiceDescription: TStringField;
    cboServiceIDQryPayRate: TFloatField;
    cboServiceIDQryEmployeeID: TIntegerField;
    DSTrainerRates: TDataSource;
    cboEquipmentLookup: TMyQuery;
    DSEquipment: TDataSource;
    qryContactsLookup: TMyQuery;
    qryContactsLookupContactID: TAutoIncField;
    qryContactsLookupCusID: TIntegerField;
    qryContactsLookupName: TStringField;
    qryContactsLookupContactFirstName: TStringField;
    qryContactsLookupContactSurName: TStringField;
    qryContactsLookupContactTitle: TStringField;
    qryContactsLookupContactAddress: TStringField;
    qryContactsLookupContactCity: TStringField;
    qryContactsLookupContactState: TStringField;
    qryContactsLookupContactPCode: TStringField;
    qryContactsLookupContactPh: TStringField;
    qryContactsLookupContactAltPh: TStringField;
    qryContactsLookupContactMOB: TStringField;
    qryContactsLookupContactFax: TStringField;
    pageControlMain: TPageControl;
    tabBooking: TTabSheet;
    DNMPanel1: TDNMPanel;
    Bevel8: TBevel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Label7: TLabel;
    Label15: TLabel;
    Cus_Alt_PH_Label: TLabel;
    Label6: TLabel;
    Start_Time_Label: TLabel;
    End_Time_Label: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Bevel5: TBevel;
    lblRescheduledDate: TLabel;
    lblCancellationDate: TLabel;
    Bevel6: TBevel;
    lblStatus1: TLabel;
    lblStatus2: TLabel;
    lblStatus3: TLabel;
    lblStatus5: TLabel;
    lblStatus4: TLabel;
    lblStatus6: TLabel;
    Label24: TLabel;
    Label1: TLabel;
    cboClient: TwwDBLookupCombo;
    edtClientDetails: TDBMemo;
    edtPhone: TDBEdit;
    edtAltPhone: TDBEdit;
    edtTotal: TDBEdit;
    edtExtrasPrice: TDBEdit;
    cboRescheduledDate: TwwDBDateTimePicker;
    cboCancellationDate: TwwDBDateTimePicker;
    edtOther: TDBEdit;
    chkStatus1: TwwCheckBox;
    chkStatus2: TwwCheckBox;
    chkStatus3: TwwCheckBox;
    chkStatus4: TwwCheckBox;
    chkStatus6: TwwCheckBox;
    chkOther: TwwCheckBox;
    chkStatus5: TwwCheckBox;
    edtRoomPrice: TwwDBEdit;
    dtpStart: TwwDBDateTimePicker;
    dtpEnd: TwwDBDateTimePicker;
    tabRooms: TTabSheet;
    DNMPanel2: TDNMPanel;
    pnlHeader: TDNMPanel;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    DNMPanel6: TDNMPanel;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdEmail: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnRepeat: TDNMSpeedButton;
    Label13: TLabel;
    dsAllRooms: TDataSource;
    qryAllRooms: TMyQuery;
    qryAllRoomsRoomID: TAutoIncField;
    qryAllRoomsName: TStringField;
    qryAllRoomsResetTime: TTimeField;
    qryAllRoomsPerDay: TFloatField;
    qryAllRoomsPerHalfDay: TFloatField;
    qryAllRoomsPerHour: TFloatField;
    grdRooms: TwwDBGrid;
    qryAllocRooms: TMyQuery;
    dsAllocRooms: TDataSource;
    qryAllRoomsCapacity: TIntegerField;
    grdRoomsIButton: TwwIButton;
    qryAllocRoomsNumPersons: TIntegerField;
    qryAllocRoomsPerHour: TFloatField;
    qryAllocRoomsRoomNameLookup: TStringField;
    qryAllocRoomsRoomAllocationID: TAutoIncField;
    qryAllocRoomsFuncBookingID: TIntegerField;
    qryAllocRoomsRoomID: TIntegerField;
    pageControlRooms: TPageControl;
    tabAllRooms: TTabSheet;
    tabMenu: TTabSheet;
    DNMPanel7: TDNMPanel;
    Label14: TLabel;
    Label16: TLabel;
    grdAllRooms: TwwDBGrid;
    grdAllRoomsIButton: TwwIButton;
    DNMPanel8: TDNMPanel;
    Label17: TLabel;
    Label18: TLabel;
    qryAllocRoomsStart: TDateTimeField;
    qryAllocRoomsEnd: TDateTimeField;
    qryAllocRoomsRateType: TStringField;
    qryAllocRoomsRate: TFloatField;
    qryAllocRoomsExtras: TFloatField;
    qryAllocRoomsLinePriceInc: TFloatField;
    qryAllocRoomsPerDay: TFloatField;
    qryAllocRoomsPerHalfDay: TFloatField;
    qryAllocRoomsIntervalCalc: TStringField;
    cboLineRateType: TwwDBComboBox;
    grdMeals: TwwDBGrid;
    qryFuncBookings: TMyQuery;
    qryFuncBookingsFuncBookingID: TAutoIncField;
    qryFuncBookingsGlobalRef: TStringField;
    qryFuncBookingsClientID: TIntegerField;
    qryFuncBookingsBookingDate: TDateField;
    qryFuncBookingsCreationDate: TDateField;
    qryFuncBookingsUpdateDate: TDateField;
    qryFuncBookingsCancellation: TStringField;
    qryFuncBookingsCancellationDate: TDateField;
    qryFuncBookingsRoomRateID: TIntegerField;
    qryFuncBookingsRoomID: TIntegerField;
    qryFuncBookingsContact: TStringField;
    qryFuncBookingsContactID: TIntegerField;
    qryFuncBookingsReschedulled: TStringField;
    qryFuncBookingsRescheduledDate: TDateField;
    qryFuncBookingsStart_Time: TStringField;
    qryFuncBookingsEnd_Time: TStringField;
    qryFuncBookingsStartVal: TFloatField;
    qryFuncBookingsEndVal: TFloatField;
    qryFuncBookingsRate: TFloatField;
    qryFuncBookingsRateType: TStringField;
    qryFuncBookingsRoomPrice: TFloatField;
    qryFuncBookingsNotes: TStringField;
    qryFuncBookingsFeedbackNotes: TMemoField;
    qryFuncBookingsCalloutValue: TFloatField;
    qryFuncBookingsStatus1: TStringField;
    qryFuncBookingsStatus2: TStringField;
    qryFuncBookingsStatus3: TStringField;
    qryFuncBookingsStatus4: TStringField;
    qryFuncBookingsStatus5: TStringField;
    qryFuncBookingsStatus6: TStringField;
    qryFuncBookingsOther: TStringField;
    qryFuncBookingsOthertxt: TStringField;
    qryFuncBookingsFeedback: TStringField;
    qryFuncBookingsTotalInc: TFloatField;
    qryFuncBookingsTotalCost: TFloatField;
    qryFuncBookingsEditedFlag: TStringField;
    qryFuncBookingsAppearDays: TIntegerField;
    qryFuncBookingsClassID: TIntegerField;
    qryFuncBookingsRescheduledFrom: TDateField;
    qryFuncBookingsEmployeeID: TIntegerField;
    qryFuncBookingsCustomerDetails: TStringField;
    qryFuncBookingsPhone: TStringField;
    qryFuncBookingsAltPhone: TStringField;
    qryFuncBookingsFax: TStringField;
    qryFuncBookingsStartBooking: TDateTimeField;
    qryFuncBookingsEndBooking: TDateTimeField;
    qryFuncBookingsServiceID: TWordField;
    qryFuncBookingsResourceID: TIntegerField;
    qryFuncBookingsConverted: TStringField;
    qryFuncBookingsUnavailable: TStringField;
    qryFuncBookingsNumPersons: TIntegerField;
    qryFuncBookingsExtras: TFloatField;
    qryFuncBookingMeals: TMyQuery;
    dsFuncBookingMeals: TDataSource;
    qryFuncBookingMealsFuncMealID: TAutoIncField;
    qryFuncBookingMealsProductID: TIntegerField;
    qryFuncBookingMealsProductName: TStringField;
    qryFuncBookingMealsDescription: TStringField;
    qryFuncBookingMealsQty: TFloatField;
    qryFuncBookingMealsPrice: TFloatField;
    qryFuncBookingMealsCourse: TStringField;
    qryFuncBookingMealsDate: TDateField;
    qryFuncBookingMealsTime: TTimeField;
    qryCourses: TMyQuery;
    cboCourse: TwwDBLookupCombo;
    cboProduct: TwwDBLookupCombo;
    qryMealProducts: TMyQuery;
    dtpDate: TwwDBDateTimePicker;
    qryFuncBookingDrinks: TMyQuery;
    dsFuncBookingDrinks: TDataSource;
    qryDrinkCourses: TMyQuery;
    qryDrinkProducts: TMyQuery;
    grdDrinks: TwwDBGrid;
    cboDrinkCourses: TwwDBLookupCombo;
    cboDrinkProduct: TwwDBLookupCombo;
    dtpDrinkDate: TwwDBDateTimePicker;
    qryFuncBookingDrinksFuncDrinkID: TAutoIncField;
    qryFuncBookingDrinksProductID: TIntegerField;
    qryFuncBookingDrinksCourse: TStringField;
    qryFuncBookingDrinksQty: TFloatField;
    qryFuncBookingDrinksDate: TDateField;
    qryFuncBookingDrinksTime: TTimeField;
    qryFuncBookingDrinksProductName: TStringField;
    qryFuncBookingDrinksDescription: TStringField;
    qryFuncBookingDrinksPrice: TFloatField;
    qryFuncBookingMealsFuncBookingID: TIntegerField;
    qryFuncBookingMealsRoomAllocationID: TIntegerField;
    qryFuncBookingDrinksFuncBookingID: TIntegerField;
    qryFuncBookingDrinksRoomAllocationID: TIntegerField;
    grdMealsIButton: TwwIButton;
    grdDrinksIButton: TwwIButton;
    qryFuncBookingsMealsPrice: TFloatField;
    qryFuncBookingsDrinksPrice: TFloatField;
    edtMealsPrice: TwwDBEdit;
    Label19: TLabel;
    Label20: TLabel;
    edtDrinksPrice: TwwDBEdit;
    btnFax: TDNMSpeedButton;
    DBCtrlGrid1: TDBCtrlGrid;
    lblRoom: TDBText;
    lblNumber: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    DBCtrlGrid2: TDBCtrlGrid;
    lblMeal: TDBText;
    lblQty: TDBText;
    Label8: TLabel;
    Label11: TLabel;
    Bevel7: TBevel;
    tabResources: TTabSheet;
    DNMPanel3: TDNMPanel;
    dsFuncResourceAllocations: TDataSource;
    qryFuncResourceAllocations: TMyQuery;
    grdResources: TwwDBGrid;
    Label21: TLabel;
    qryFuncResourceAllocationsFuncResourceAllocationID: TAutoIncField;
    qryFuncResourceAllocationsFuncBookingID: TIntegerField;
    qryFuncResourceAllocationsRoomAllocationID: TIntegerField;
    qryFuncResourceAllocationsFuncResourceID: TIntegerField;
    qryFuncResourceAllocationsResourceName: TStringField;
    qryFuncResourceAllocationsQty: TIntegerField;
    cboResource: TwwDBLookupCombo;
    grdResourcesIButton: TwwIButton;
    btnInvoice: TDNMSpeedButton;
    btnPos: TDNMSpeedButton;
    Label22: TLabel;
    btnLetter: TDNMSpeedButton;
    DBMemo2: TDBMemo;
    lblRoomName: TDBText;
    qryFuncBookingsUseBillTo: TStringField;
    qryFuncBookingsBillToClientID: TIntegerField;
    qryFuncBookingsBillToDetails: TStringField;
    qryFuncBookingsBillPhone: TStringField;
    qryFuncBookingsBillAltPhone: TStringField;
    qryFuncBookingsBillFax: TStringField;
    qryFuncBookingsBillToContactID: TIntegerField;
    edtFax: TDBEdit;
    Fax: TLabel;
    pnlBillTo: TDNMPanel;
    Bevel3: TBevel;
    Label9: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    cboBillClient: TwwDBLookupCombo;
    edtBillClientDetails: TDBMemo;
    edtBillPhone: TDBEdit;
    Label27: TLabel;
    edtBillAltPhone: TDBEdit;
    edtBillFax: TDBEdit;
    Label28: TLabel;
    qryFuncResources: TMyQuery;
    btnContacts: TDNMSpeedButton;
    cboFuncType: TwwDBLookupCombo;
    Label25: TLabel;
    qryFuncTypes: TMyQuery;
    qryFuncBookingsFuncTypeID: TIntegerField;
    dtpResetTime: TwwDBDateTimePicker;
    qryAllocRoomsResetTime: TDateTimeField;
    qryAllocRoomsRoomAllocDate: TDateField;
    dtpRoomAllocDate: TwwDBDateTimePicker;
    qryFuncBookingMealsMeal: TStringField;
    qryMealsLookup: TMyQuery;
    cboMeal: TwwDBLookupCombo;
    qryFuncBookingMealsMealSortOrder: TWordField;
    qryFuncBookingMealsCourseSortOrder: TWordField;
    qryDrinksMealsLookup: TMyQuery;
    cboDrinkMeal: TwwDBLookupCombo;
    qryFuncBookingDrinksMeal: TStringField;
    qryFuncBookingDrinksMealSortOrder: TWordField;
    qryFuncBookingDrinksCourseSortOrder: TWordField;
    btnSortMeals: TDNMSpeedButton;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    cboStartTime: TwwDBComboBox;
    cboEndTime: TwwDBComboBox;
    qryAllocRoomsStartDummy: TStringField;
    qryAllocRoomsEndDummy: TStringField;
    cboStartAlloc: TwwDBComboBox;
    cboEndAlloc: TwwDBComboBox;
    lblEmail: TLabel;
    qryContacts: TMyQuery;
    Label3: TLabel;
    lblContact: TDBText;
    Bevel14: TBevel;
    ActionList1: TActionList;
    actContacts: TAction;
    imgCredit: TImageList;
    Bevel15: TBevel;
    Label29: TLabel;
    edtDescription: TDBEdit;
    qryFuncBookingsBookingDescription: TStringField;
    chkBillTo: TwwCheckBox;
    lblBillTo: TLabel;
    Bevel9: TBevel;
    btnConvert2SalesOrder: TDNMSpeedButton;
    dtpTime: TwwDBComboBox;
    dtpDrinkTime: TwwDBComboBox;
    qryFuncBookingsCreatedSO: TStringField;
    qryFuncBookingsCreatedINV: TStringField;
    chkRescheduled: TwwCheckBox;
    chkCancellation: TwwCheckBox;
    Label2: TLabel;
    Label30: TLabel;
    actReschedule: TAction;
    actCancellation: TAction;
    lblConverted: TLabel;
    qryTempMeals: TMyQuery;
    qryTempDrinks: TMyQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    DateField1: TDateField;
    TimeField1: TTimeField;
    StringField3: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    StringField4: TStringField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    AutoIncField1: TAutoIncField;
    WordField1: TWordField;
    WordField2: TWordField;
    qryTempRecource: TMyQuery;
    StringField5: TStringField;
    IntegerField4: TIntegerField;
    AutoIncField2: TAutoIncField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboContactCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnCompletedClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdAllRoomsDblClick(Sender: TObject);
    procedure grdRoomsIButtonClick(Sender: TObject);
    procedure pageControlMainChange(Sender: TObject);
    procedure cboLineRateTypeCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure cboProductCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboDrinkProductCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryAllocRoomsAfterScroll(DataSet: TDataSet);
    procedure qryFuncBookingMealsNewRecord(DataSet: TDataSet);
    procedure qryFuncBookingDrinksNewRecord(DataSet: TDataSet);
    procedure qryFuncBookingMealsQtyChange(Sender: TField);
    procedure qryFuncBookingDrinksQtyChange(Sender: TField);
    procedure grdMealsIButtonClick(Sender: TObject);
    procedure grdDrinksIButtonClick(Sender: TObject);
    procedure grdMealsExit(Sender: TObject);
    procedure grdDrinksExit(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cboResourceCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdResourcesIButtonClick(Sender: TObject);
    procedure grdResourcesExit(Sender: TObject);
    procedure chkBillToClick(Sender: TObject);
    procedure cboBillClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnLetterClick(Sender: TObject);
    procedure qryAllocRoomsRoomAllocDateChange(Sender: TField);
    procedure qryFuncBookingMealsMealChange(Sender: TField);
    procedure qryFuncBookingDrinksMealChange(Sender: TField);
    procedure qryFuncBookingDrinksCourseChange(Sender: TField);
    procedure btnSortMealsClick(Sender: TObject);
    procedure btnRepeatClick(Sender: TObject);
    procedure qryFuncBookingsExtrasChange(Sender: TField);
    procedure btnInvoiceClick(Sender: TObject);
    procedure qryAllocRoomsRateChange(Sender: TField);
    procedure qryAllocRoomsRateTypeChange(Sender: TField);
    procedure qryAllocRoomsCalcFields(DataSet: TDataSet);
    procedure cboStartTimeCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure cboEndTimeCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure cboStartAllocCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure cboEndAllocCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure btnPosClick(Sender: TObject);
    procedure qryAllocRoomsIntervalCalcChange(Sender: TField);
    procedure qryFuncBookingMealsCourseChange(Sender: TField);
    procedure pageControlMainChanging(Sender: TObject; var AllowChange: boolean);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdEmailClick(Sender: TObject);
    procedure smtpFuncBookAuthenticationFailed(var Handled: boolean);
    procedure smtpFuncBookConnect(Sender: TObject);
    procedure btnFaxClick(Sender: TObject);
    procedure actContactsExecute(Sender: TObject);
    procedure actContactsUpdate(Sender: TObject);
    procedure qryClientsLookupCalcFields(DataSet: TDataSet);
    procedure chkRescheduledClick(Sender: TObject);
    procedure chkCancellationClick(Sender: TObject);
    procedure cboFuncTypeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure dtpTimeChange(Sender: TObject);
    procedure mnuCustomiseGridClick(Sender: TObject);
    procedure grdAllRoomsIButtonClick(Sender: TObject);
    procedure edtClientDetailsEnter(Sender: TObject);
  private
    { Private declarations }
    bChangingPrice: boolean;
    bIsCalcLineTotalsInProgress: boolean;
    iTimeInc: integer;
    bSuppressCourseChg: boolean;
    bStartingUp: boolean;
    fsLastClient: string;

    //procedure RefreshContactLookup;
    procedure TidyUpDates;
    procedure NewData;
    procedure ClearBlanksInAddressField;
    procedure SetStartAndEndTimeIncrements;
    procedure RefreshCustomer;
    procedure RefreshBillCustomer;
    procedure LoadContactDetails(RefreshQuery: Boolean = False);
    procedure PopulateStatusNames;
    procedure SetCancellationStatus;
    procedure SetRescheduledStatus;
    procedure CalcTotals;
    function SaveData: boolean;
    //function GetParentRoom(iRoomID: integer): integer;
    //function IsChildRoom(iChildRoomID, iParentRoomID: integer): boolean;
    //function GetTotalRate(sRateType: string): Currency;
    //function GetTotalPersons: Integer;
    procedure CalcLineTotals;
    function GetRoomRate(const iRoomID: integer; const sRateType: string): currency;
    function GetTotalRoomsPrice: currency;
    function GetTotalPrice(const sTableName: string): currency;
    procedure SetMealLinePrice;
    procedure SetDrinkLinePrice;
    procedure ReQueryMeals;
    procedure SelectClient;
    function IsRoomAvailable(const iRoomID: integer; const dtFrom, dtTo: TDateTime): boolean;
    procedure CalcTimeInterval;
    procedure SetTimeCbo(const cbo: TwwDBComboBox; const dtTime: TDateTime);
    function GetReportSql: string;
    function MealsHaveProducts: boolean;
    function BeveragesHaveProducts: boolean;
    function CheckTimeStr(const TimeStr: string): boolean;

  public
    { Public declarations }
    fdtDate: TDateTime;
    fdtStartBooking: TDateTime;
    fdtEndBooking: TDateTime;
    fiClientID: integer;
    fiRoomID: integer;
    
  end;

//var
// FuncBookingGUI: TFuncBookingGUI;

implementation

uses
  CommonDbLib,  DateUtils, DNMLib,
  FormFactory, DNMExceptions, ShellAPI,  
  ClientDiscountObj, frmClientReferenceFrm, ContactSelectorFrm, frmRepeat,
  TranConvertObj, frmInvoice, StrUtils, POSScreenGUI, FaxObj, frmSalesOrder,
  FuncTypesForm, CommonLib, AppEnvironment, FastFuncs, tcDataUtils;

const
  crlf        = Chr(13) + Chr(10);
  PER_DAY     = 'PerDay';
  PER_HALFDAY = 'PerHalfDay';
  PER_HOUR    = 'PerHour';



  {$R *.dfm}

procedure TFuncBookingGUI.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  SelectClient;
end;

procedure TFuncBookingGUI.ClearBlanksInAddressField;
var
  i: integer;
begin
  i := 0;
  while i <= edtClientDetails.Lines.Count - 1 do begin
    if FastFuncs.Trim(edtClientDetails.Lines[i]) = '' then begin
      edtClientDetails.Lines.Delete(i);
    end else begin
      Inc(i);
    end;;
  end;
end;

procedure TFuncBookingGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  try
    inherited;
    if qryFuncBookings.Active then begin
      if not (qryFuncBookings.State in [dsBrowse]) then begin
        qryFuncBookings.Post;
        Notify;
      end;
      CloseQueries;
      CommitTransaction;
    end;

    BeginTransaction;
    qryFuncBookings.ParamByName('xFuncBookingID').asInteger := KeyID;
    SetLength(QueryNamesNotToOpen, 2);
    QueryNamesNotToOpen[0]  := 'qryContactsLookup';
    QueryNamesNotToOpen[1]  := 'qryAllocRooms';
    qryFuncTypes.Connection := CommonDbLib.GetSharedMyDacConnection;
    OpenQueries(QueryNamesNotToOpen);
    SetStartAndEndTimeIncrements;

    if KeyID <> 0 then begin
      EditNoAbort(qryFuncBookings);
      qryAllocRooms.ParamByName('xFuncBookingID').asInteger := KeyID;
      qryAllocRooms.Open;
      qryAllocRooms.Edit;
      ReQueryMeals;
      //RefreshContactLookup;
      //cboResourceCloseUp(Sender, nil, nil, False);
      //EditNoAbort(tblDetails);
      TidyUpDates;
      ClearBlanksInAddressField;
      qryFuncBookings.Edit;
      lblConverted.Visible := qryFuncBookings.FieldByName('Converted').AsBoolean;
      CalcTotals;
      SetTimeCbo(cboStartTime, qryFuncBookingsStartBooking.AsDateTime);
      SetTimeCbo(cboEndTime, qryFuncBookingsEndBooking.AsDateTime);
    end else begin
      qryFuncBookings.Insert;
      NewData;
      Label2.Enabled := false;
      chkRescheduled.Checked := false;
      Label30.Enabled := false;
      chkCancellation.Checked := false;
    end;

    //chkCancellation.Checked := False;
    //chkRescheduled.Checked := False;
    PopulateStatusNames;
    pageControlMain.ActivePage := tabBooking;
    SetControlFocus(edtDescription);
    pageControlRooms.ActivePage := tabAllRooms;

    SaveFieldPrefs(GuiPrefs);
    //isChanged := False;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;

    else raise;
  end;

  bStartingUp := false;
end;

procedure TFuncBookingGUI.NewData;
begin
  qryFuncBookings.Insert;
  qryFuncBookings.FieldByName('BookingDate').AsDateTime := fdtDate;
  qryFuncBookings.FieldByName('StartBooking').AsDateTime := fdtStartBooking;
  qryFuncBookings.FieldByName('EndBooking').AsDateTime := fdtEndBooking;

  qryFuncBookings.FieldByName('CreationDate').AsDateTime := Now;
  qryFuncBookings.FieldByName('ClassID').AsInteger := AppEnv.DefaultClass.ClassID;
  // if Client has been set externally then populate combo
  if fiClientID <> 0 then begin
    if qryClientsLookup.Locate('ClientID', fiClientID, [loCaseInsensitive]) then begin
      cboClient.Text := qryClientsLookup.FieldByName('Company').AsString;
      SelectClient;  // as if a  cboCloseUp was done
    end;
  end;

  qryFuncBookings.post;
  qryFuncBookings.edit;

  qryAllocRooms.ParamByName('xFuncBookingID').AsInteger :=  qryFuncBookings.FieldByName('FuncBookingID').AsInteger;
  qryAllocRooms.Open;

  if fiRoomID <> 0 then begin
    if qryAllRooms.Locate('RoomID', fiRoomID, [loCaseInsensitive]) then begin
      grdAllRoomsDblClick(nil);
    end;
  end;
  SetTimeCbo(cboStartTime, fdtStartBooking);
  SetTimeCbo(cboEndTime, fdtEndBooking);
end;

procedure TFuncBookingGUI.SetStartAndEndTimeIncrements;
var
  qryTimeIncs: TMyQuery;
  dtTime: TDateTime;
begin
  qryTimeIncs := TMyQuery.Create(nil);
  qryTimeIncs.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qryTimeIncs do begin
      SQL.Add('SELECT TimeIncCalID, CalID, EmployeeID, TimeInc FROM tbltimeincsCal ' +
        ' WHERE EmployeeID = :xEmployeeID AND CalID = :xCalID');
      ParamByName('xEmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
      ParamByName('xCalID').AsInteger := CAL_FUNCS;
      Open;
      if RecordCount <> 0 then begin
        iTimeInc := FieldByName('TimeInc').AsInteger;  // Global variable is set here
        cboStartTime.Items.Clear;
        cboEndTime.Items.Clear;
        cboStartAlloc.Items.Clear;
        cboEndAlloc.Items.Clear;
        dtTime := StrToTime('00:00');
        while (dtTime <= 1) do begin  // ie less than one day
          if dtTime = 1 then dtTime := EndOfTheDay(0);
          cboStartTime.Items.Add(FormatDateTime('hh:nn', dtTime));
          cboEndTime.Items.Add(FormatDateTime('hh:nn', dtTime));
          cboStartAlloc.Items.Add(FormatDateTime('hh:nn', dtTime));
          cboEndAlloc.Items.Add(FormatDateTime('hh:nn', dtTime));
          dtTime := IncMinute(dtTime, iTimeInc);
        end;
      end;
      Close;
    end;
  finally
    FreeAndNil(qryTimeIncs);
  end;
end;


procedure TFuncBookingGUI.TidyUpDates;
begin
(*
  // make sure dates match and are in the correct format
  if qryFuncBookings.FieldByName('BookingDate').AsString <> FormatDateTime('dd/mm/yyyy', qryFuncBookings.FieldByName('StartTime').AsDateTime) then begin
    qryFuncBookings.FieldByName('BookingDate').AsString := FormatDateTime('dd/mm/yyyy', qryFuncBookings.FieldByName('StartTime').AsDateTime);
  end;
  if qryFuncBookings.FieldByName('Start_Time').AsString <> FormatDateTime('hh:nn AM/PM', qryFuncBookings.FieldByName('StartTime').AsDateTime) then begin
    qryFuncBookings.FieldByName('Start_Time').AsString := FormatDateTime('hh:nn AM/PM', qryFuncBookings.FieldByName('StartTime').AsDateTime);
  end;
  if not Empty(qryFuncBookings.FieldByName('End_Time').AsString) then begin
    if qryFuncBookings.FieldByName('End_Time').AsString <> FormatDateTime('hh:nn AM/PM', qryFuncBookings.FieldByName('EndTime').AsDateTime) then begin
      qryFuncBookings.FieldByName('End_Time').AsString := FormatDateTime('hh:nn AM/PM', qryFuncBookings.FieldByName('EndTime').AsDateTime);
    end;
  end;
*)
end;

procedure TFuncBookingGUI.FormCreate(Sender: TObject);
var
  Index: Integer;
begin
  AllowCustomiseGrid := True;
  inherited;
  bChangingPrice := false;
  bStartingUp := true;
  bSuppressCourseChg := false;
  fdtStartBooking := IncHour(Date(), 9);
  fdtEndBooking := IncHour(Date(), 17);
  fdtDate := Date;
  fiClientID := 0;
  fiRoomID := 0;
  bIsCalcLineTotalsInProgress := false;
  iTimeInc := 30;  // 30 min time increments by default

  for Index := 0 to GuiPrefs.Elements.Count - 1 do begin
    if GuiPrefs.Elements.Items[Index].Target = grdRooms then
      GuiPrefs.Elements.Items[Index].Description := 'Rooms Grid'
    else if GuiPrefs.Elements.Items[Index].Target = grdAllRooms then
      GuiPrefs.Elements.Items[Index].Description := 'Select Room Grid'
    else if GuiPrefs.Elements.Items[Index].Target = grdMeals then
      GuiPrefs.Elements.Items[Index].Description := 'Meals Grid'
    else if GuiPrefs.Elements.Items[Index].Target = grdDrinks then
      GuiPrefs.Elements.Items[Index].Description := 'Beverages Grid'
    else if GuiPrefs.Elements.Items[Index].Target = grdResources then
      GuiPrefs.Elements.Items[Index].Description := 'Resources Grid'
  end;

  GuiPrefs.Active := True;
end;

procedure TFuncBookingGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  Action := caFree;
// FuncBookingGUI := nil;
  notify;
  inherited;
end;


procedure TFuncBookingGUI.RefreshCustomer;
var
  qry: TMyQuery;
begin
  if not qryFuncBookingsContact.IsNull then begin
    LoadContactDetails;
  end else begin
    qry := TMyQuery.Create(Self);
    try
      if Empty(cboClient.Text) then begin
        CommonLib.MessageDlgXP_Vista('You must provide a Customer Name', mtError, [mbOK], 0);
        Exit;
      end;
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Text   := Format('SELECT Company, Title, FirstName, LastName, Street, Street2, Suburb, ' +
        'State, Postcode, Phone, AltPhone, FaxNumber, MedTypeID ' + 'FROM tblClients WHERE ClientID = %d ',
        [qryClientsLookup.FieldByName('ClientID').AsInteger]);
      qry.Open;
      Assert(qry.RecordCount = 1, 'Client Not Found');
      if qry.RecordCount > 0 then begin
        qryFuncBookingsCustomerDetails.AsString :=
          qry.FieldByName('Company').AsString + crlf + qry.FieldByName('Title').AsString + ' ' +
          qry.FieldByName('FirstName').AsString + ' ' + qry.FieldByName('LastName').AsString + crlf +
          qry.FieldByName('Street').AsString + crlf + qry.FieldByName('Street2').AsString + crlf +
          qry.FieldByName('Suburb').AsString + ' ' + qry.FieldByName('State').AsString + ' ' + qry.FieldByName('Postcode').AsString;
        edtPhone.Text := qry.FieldByName('Phone').AsString;
        edtAltPhone.Text := qry.FieldByName('AltPhone').AsString;
        edtFax.Text := qry.FieldByName('FaxNumber').AsString;
      end;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;
  end;
end;

procedure TFuncBookingGUI.LoadContactDetails(RefreshQuery: Boolean);
var
  strTemp: string;
begin
  if RefreshQuery then begin
    qryContacts.Close;
    qryContacts.Open;
  end;
  with qryContacts do begin
    if Locate('ContactID', qryFuncBookingsContactID.AsInteger, []) then begin
      if RecordCount > 0 then begin
        strTemp := '';
        if not FieldByName('ContactTitle').IsNull then strTemp := FieldByName('ContactTitle').AsString;
        if not FieldByName('ContactFirstName').IsNull then if strTemp = '' then
            strTemp := FieldByName('ContactFirstName').AsString
          else strTemp := strTemp + ' ' + FieldByName('ContactFirstName').AsString;
        if not FieldByName('ContactSurName').IsNull then if strTemp = '' then
            strTemp := FieldByName('ContactSurName').AsString
          else strTemp := strTemp + ' ' + FieldByName('ContactSurName').AsString;

        qryFuncBookingsCustomerDetails.AsString :=
          cboClient.Text + #13#10 +  //Company Name
          strTemp + #13#10 +         //Contact Name
          FieldByName('ContactAddress').AsString + #13 + #10 + FieldByName('ContactAddress2').AsString +
          #13 + #10 + FieldByName('ContactCity').AsString + ' ' + FieldByName('ContactState').AsString +
          ' ' + FieldByName('ContactPcode').AsString;

        edtPhone.Text := FieldByName('ContactPh').AsString;
        edtAltPhone.Text := FieldByName('ContactAltPh').AsString;
        edtFax.Text := FieldByName('ContactFax').AsString;
        qryFuncBookingsContact.AsString := strTemp;
      end;
    end else begin
      qryFuncBookingsContactID.Clear;
      qryFuncBookingsContact.Clear;
    end;
  end;
end;

procedure TFuncBookingGUI.cboContactCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryFuncBookingsContactID.AsInteger := qryContactsLookupContactID.AsInteger;
  LoadContactDetails;
end;

procedure TFuncBookingGUI.PopulateStatusNames;
var
  qry: TMyQuery;

  procedure SetStatusLabel(const lblLabel: TLabel; const chkStatus: TwwCheckBox; const sText: string);
  begin
    if not Empty(sText) then begin
      lblLabel.Caption  := sText;
      lblLabel.Visible  := true;
      chkStatus.Visible := true;
    end else begin
      lblLabel.Visible  := false;
      chkStatus.Visible := false;
    end;
  end;
begin
  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ID, Status1, Status2, Status3, Status4, Status5, Status6 ' +
        ' FROM tblfuncstatuses');
      Open;
      SetStatusLabel(lblStatus1, chkStatus1, qry.FieldByName('Status1').AsString);
      SetStatusLabel(lblStatus2, chkStatus2, qry.FieldByName('Status2').AsString);
      SetStatusLabel(lblStatus3, chkStatus3, qry.FieldByName('Status3').AsString);
      SetStatusLabel(lblStatus4, chkStatus4, qry.FieldByName('Status4').AsString);
      SetStatusLabel(lblStatus5, chkStatus5, qry.FieldByName('Status5').AsString);
      SetStatusLabel(lblStatus6, chkStatus6, qry.FieldByName('Status6').AsString);
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TFuncBookingGUI.SetCancellationStatus;
begin
  if qryFuncBookings.Active and (qryFuncBookings.State in [dsEdit, dsInsert]) then begin // a bit of protection
    if chkCancellation.Checked then begin
      cboCancellationDate.Enabled := true;
      lblCancellationDate.Enabled := true;
      qryFuncBookingsCancellationDate.AsDateTime := Date;
    end else begin
      cboCancellationDate.Enabled := false;
      lblCancellationDate.Enabled := false;
      cboCancellationDate.Clear;
    end;
  end;
end;

procedure TFuncBookingGUI.SetRescheduledStatus;
begin
  if chkRescheduled.Checked then begin
    cboRescheduledDate.Enabled := true;
    lblRescheduledDate.Enabled := true;
    qryFuncBookingsRescheduledDate.AsDateTime := Date;
  end else begin
    cboRescheduledDate.Enabled := false;
    lblRescheduledDate.Enabled := false;
    cboRescheduledDate.Clear;
  end;
end;

procedure TFuncBookingGUI.CalcTotals;
var
  savedCursor: TCursor;
begin
  if qryFuncBookings.Active and (qryFuncBookings.State in [dsInsert, dsEdit]) then begin
    if not Empty(qryFuncBookingsStartBooking.AsString) and not Empty(qryFuncBookingsEndBooking.AsString) then begin
      savedCursor := Screen.Cursor;
      try
        Screen.Cursor := crHourGlass;

        qryFuncBookingsRoomPrice.AsCurrency := GetTotalRoomsPrice;
        qryFuncBookingsMealsPrice.AsCurrency := GetTotalPrice('tblfuncbookingmeals');
        qryFuncBookingsDrinksPrice.AsCurrency := GetTotalPrice('tblfuncbookingdrinks');
        qryFuncBookingsTotalInc.AsCurrency := qryFuncBookingsExtras.AsCurrency +
          qryFuncBookingsMealsPrice.AsCurrency + qryFuncBookingsDrinksPrice.AsCurrency + qryFuncBookingsRoomPrice.AsCurrency;
      finally
        Screen.Cursor := savedCursor;
      end;
    end;
  end;
end;

procedure TFuncBookingGUI.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if SaveData() then begin
    self.Close;
  end;
end;

function TFuncBookingGUI.SaveData: boolean;
var
  dtStart, dtEnd, dtBooking: TDateTime;
  iDays: integer;
begin
  Result := false;

  if qryFuncBookingsClientID.AsInteger = 0 then begin
    CommonLib.MessageDlgXP_Vista('Please Enter Customer', mtError, [mbOK], 0);
    pageControlMain.ActivePage := tabBooking;
    SetControlFocus(cboClient);
    Exit;
  end;

  if qryAllocRooms.RecordCount = 0 then begin
    pageControlMain.ActivePage  := tabRooms;
    pageControlRooms.ActivePage := tabAllRooms;
    CommonLib.MessageDlgXP_Vista('Please Select a Room', mtError, [mbOK], 0);
    SetControlFocus(grdAllRooms);
    Exit;
  end;

  if Empty(qryFuncBookingsStartBooking.AsString) then begin
    CommonLib.MessageDlgXP_Vista('Please Enter a Start Time', mtError, [mbOK], 0);
    pageControlMain.ActivePage := tabBooking;
    SetControlFocus(dtpStart);
    Exit;
  end;

  if Empty(qryFuncBookingsEndBooking.AsString) then begin
    pageControlMain.ActivePage := tabBooking;
    CommonLib.MessageDlgXP_Vista('Please Enter an End Time', mtError, [mbOK], 0);
    SetControlFocus(dtpEnd);
    Exit;
  end;

  if not MealsHaveProducts then begin
    Exit;
  end;

  if not BeveragesHaveProducts then begin
    Exit;
  end;

  try
    CalcTotals;
    qryFuncBookings.Edit;

    if chkRescheduled.Checked then begin;
      dtStart := qryFuncBookings.FieldByName('StartBooking').AsDateTime;
      dtEnd := qryFuncBookings.FieldByName('EndBooking').AsDateTime;
      dtBooking := qryFuncBookings.FieldByName('BookingDate').AsDateTime;
      iDays := DaysBetween(qryFuncBookings.FieldByName('RescheduledDate').AsDateTime,
        qryFuncBookings.FieldByName('StartBooking').AsDateTime);
      if qryFuncBookings.FieldByName('RescheduledDate').AsDateTime < dtStart then begin
        dtStart := dtStart - iDays;
        dtEnd := dtEnd - iDays;
        dtBooking := dtBooking - iDays;
      end else begin
        Inc(iDays);
        dtStart := dtStart + iDays;
        dtEnd := dtEnd + iDays;
        dtBooking := dtBooking + iDays;
      end;

      qryFuncBookings.FieldByName('Reschedulled').AsString := 'F';
      qryFuncBookings.FieldByName('StartBooking').AsDateTime := dtStart;
      qryFuncBookings.FieldByName('EndBooking').AsDateTime := dtEnd;
      qryFuncBookings.FieldByName('BookingDate').AsDateTime := dtBooking;
      //      qryFuncBookings.FieldByName('AppDate').asDatetime := qryFuncBookings.FieldByName('RescheduledDate').asDatetime;
      qryFuncBookings.FieldByName('RescheduledDate').AsDateTime := Now;
    end;

    if chkCancellation.Checked then begin;
      qryFuncBookings.FieldByName('CancellationDate').AsDateTime := Now;
      qryFuncBookings.FieldByName('Converted').AsString := 'T';
    end;

    qryFuncBookings.Post;

    if qryAllocRooms.Active and not (qryAllocRooms.State in [dsBrowse]) then begin
      qryAllocRooms.Post;
    end;

    if qryFuncBookingMeals.Active and not (qryFuncBookingMeals.State in [dsBrowse]) then begin
      qryFuncBookingMeals.Post;
    end;

    if qryFuncBookingDrinks.Active and not (qryFuncBookingDrinks.State in [dsBrowse]) then begin
      qryFuncBookingDrinks.Post;
    end;

    if qryFuncResourceAllocations.Active and not (qryFuncResourceAllocations.State in [dsBrowse]) then begin
      qryFuncResourceAllocations.Post;
    end;

    CommitTransaction;
    Notify;
    Result := true;
  except
    on EAbort do HandleEAbortException;

    on e: Exception do else raise;
  end;
end;

procedure TFuncBookingGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if SaveData() then begin
    KeyID := 0;
    FormShow(Sender);
  end;
end;

procedure TFuncBookingGUI.grdAllRoomsDblClick(Sender: TObject);
  // Allocate the room doubleclicked, by adding it to this booking (ie add to qryAllocRooms)
var
  //bm: TBookMark;
  iRoomID: integer;
  //iParentRoomID: integer;
  //bOk: boolean;
  dtStart: TDateTime;
  dtEnd: TDateTime;
  savedCursor: TCursor;
begin
  inherited;
  savedCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    iRoomID       := qryAllRooms.FieldByName('RoomID').AsInteger;

    (*
    // This code checks if child or parent room is already in this booking
    iParentRoomID := GetParentRoom(iRoomID);
    bm := qryAllocRooms.GetBookmark;
    try
      qryAllocRooms.DisableControls;
      qryAllocRooms.First;
      while not qryAllocRooms.Eof do begin
        if qryAllocRooms.FieldByName('RoomID').AsInteger = iRoomID then begin
          CommonLib.MessageDlgXP_Vista('Room Already Selected', mtInformation, [mbOK], 0);
          EXIT;
        end;
        if qryAllocRooms.FieldByName('RoomID').AsInteger = iParentRoomID then begin
          CommonLib.MessageDlgXP_Vista('The Selected Room is a Parent of ' + qryAllocRooms.FieldByName('RoomNameLookup').AsString, mtInformation, [mbOK], 0);
          EXIT;
        end;
        if IsChildRoom(qryAllocRooms.FieldByName('RoomID').AsInteger, iRoomID) then begin
          CommonLib.MessageDlgXP_Vista('The Selected Room is a Sub-Room of ' + qryAllocRooms.FieldByName('RoomNameLookup').AsString, mtInformation, [mbOK], 0);
          EXIT;
        end;
        qryAllocRooms.Next;
      end;
    finally
      qryAllocRooms.GotoBookmark(bm);
      qryAllocRooms.EnableControls;
    end;
  *)

    // get a reasonable start and stop time for this room booking
    dtStart := qryFuncBookingsStartBooking.AsDateTime;
    if DateOf(dtStart) = DateOf(qryFuncBookingsEndBooking.AsDateTime) then begin
      dtEnd := qryFuncBookingsEndBooking.AsDateTime;
    end else begin
      dtEnd := DateOf(dtStart) + TimeOf(qryFuncBookingsEndBooking.AsDateTime);
    end;

    // check if room is already booked on that day
    if not IsRoomAvailable(iRoomID, StartOfTheDay(dtStart), EndOfTheDay(dtStart)) then begin
      if CommonLib.MessageDlgXP_Vista('The room you have Selected is already booked on ' +
        FormatDateTime('dd mmm yy', DateOf(dtStart)) + #13 + #10 +
        'Continue?', mtWarning, [mbYes, mbNo], 0) = mrNo then begin
        Exit;
      end;
    end;

    // Copy room details to allocated rooms
    if not (qryAllocRooms.State in [dsBrowse]) then begin
      qryAllocRooms.Post;
    end;

    qryAllocRooms.Append;
    qryAllocRooms.FieldByName('RoomID').AsInteger         := iRoomID;
    qryAllocRooms.FieldByName('FuncBookingID').AsInteger  := qryFuncBookings.FieldByName('FuncBookingID').AsInteger;
    qryAllocRooms.FieldByName('PerDay').AsCurrency        := qryAllRooms.FieldByName('PerDay').AsCurrency;
    qryAllocRooms.FieldByName('PerHalfDay').AsCurrency    := qryAllRooms.FieldByName('PerHalfDay').AsCurrency;
    qryAllocRooms.FieldByName('PerHour').AsCurrency       := qryAllRooms.FieldByName('PerHour').AsCurrency;
    qryAllocRooms.FieldByName('NumPersons').AsCurrency    := qryAllRooms.FieldByName('Capacity').AsCurrency;
    qryAllocRooms.FieldByName('RoomAllocDate').AsDateTime := DateOf(dtStart);
    qryAllocRooms.FieldByName('Start').AsDateTime         := dtStart;
    qryAllocRooms.FieldByName('End').AsDateTime           := dtEnd;
    qryAllocRooms.FieldByName('StartDummy').AsString      := FormatDateTime('hh:nn', dtStart);
    qryAllocRooms.FieldByName('EndDummy').AsString        := FormatDateTime('hh:nn', dtEnd);
    SetTimeCbo(cboStartAlloc, dtStart);
    SetTimeCbo(cboEndAlloc, dtEnd);
    qryAllocRooms.FieldByName('ResetTime').AsDateTime := TimeOf(qryAllRooms.FieldByName('ResetTime').AsDateTime);
    qryAllocRooms.Post;

    // Refresh query for grid
    qryAllocRooms.Close;
    qryAllocRooms.Open;
    qryAllocRooms.Last;
    qryAllocRooms.Edit;
  finally
    Screen.Cursor := savedCursor;
  end;
end;

procedure TFuncBookingGUI.grdRoomsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryAllocRooms);
end;

procedure TFuncBookingGUI.pageControlMainChange(Sender: TObject);
begin
  inherited;
  if pageControlMain.ActivePage = tabBooking then begin
    CalcTotals;
  end;
end;

procedure TFuncBookingGUI.CalcTimeInterval;
var
  dTimeSpan: double;
begin
  if not Empty(qryAllocRoomsStart.AsString) and not Empty(qryAllocRoomsStart.AsString) then begin
    if qryAllocRoomsRateType.AsString = PER_DAY then begin
      dTimeSpan := DaySpan(qryAllocRoomsStart.AsDateTime, qryAllocRoomsEnd.AsDateTime);
      if Frac(dTimeSpan) <> 0 then begin
        dTimeSpan := Int(dTimeSpan) + 1;
      end;
      qryAllocRoomsIntervalCalc.AsString := FloatToStr(dTimeSpan) + ' Days';
    end else if qryAllocRoomsRateType.AsString = PER_HALFDAY then begin
      dTimeSpan := DaySpan(qryAllocRoomsStart.AsDateTime, qryAllocRoomsEnd.AsDateTime) * 2;
      if Frac(dTimeSpan) <> 0 then begin
        dTimeSpan := Int(dTimeSpan) + 1;
      end;
      qryAllocRoomsIntervalCalc.AsString := FloatToStr(dTimeSpan) + 'Half Days';
    end else if qryAllocRoomsRateType.AsString = PER_HOUR then begin
      dTimeSpan := IncMinute(HourSpan(qryAllocRoomsStart.AsDateTime, qryAllocRoomsEnd.AsDateTime) - 1);
      dTimeSpan := Trunc(dTimeSpan) + 1;
      qryAllocRoomsIntervalCalc.AsString := FloatToStr(dTimeSpan) + ' Hours';
    end;
  end;
end;

procedure TFuncBookingGUI.CalcLineTotals;
begin
  if not bIsCalcLineTotalsInProgress then begin
    bIsCalcLineTotalsInProgress := true;
    if not Empty(qryAllocRoomsStart.AsString) and not Empty(qryAllocRoomsEnd.AsString) then begin
      //     CalcTimeInterval;
      if qryAllocRoomsRate.AsFloat = 0.0 then qryAllocRoomsRate.AsFloat :=
          GetRoomRate(qryAllocRoomsRoomID.AsInteger, cboLineRateType.Text);
      qryAllocRoomsLinePriceInc.AsCurrency :=
        qryAllocRoomsRate.AsFloat * StrValue(qryAllocRoomsIntervalCalc.AsString) + qryAllocRoomsExtras.AsCurrency;
    end;
    bIsCalcLineTotalsInProgress := false;
  end;
end;

function TFuncBookingGUI.GetRoomRate(const iRoomID: integer; const sRateType: string): currency;
var
  qry: TMyQuery;
begin
  Result := 0;

  if (sRateType <> 'PerDay') and (sRateType <> 'PerHalfDay') and (sRateType <> 'PerHour') then begin
    Exit;
  end;

  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT RoomID, PerDay, PerHalfDay, PerHour FROM tblFuncRooms ' +
        'WHERE RoomID = :xRoomID;');
      ParamByName('xRoomID').AsInteger := iRoomID;
      Open;
      if qry.RecordCount <> 0 then begin
        Result := qry.FieldByName(sRateType).AsFloat;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TFuncBookingGUI.cboLineRateTypeCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  //  qryAllocRooms.Edit;
  //  qryAllocRoomsRate.AsFloat := GetRoomRate(qryAllocRoomsRoomID.AsInteger, cboLineRateType.Text);
end;

function TFuncBookingGUI.GetTotalRoomsPrice: currency;
  // totals the line price for all rooms
var
  bm: TBookMark;
begin
  Result := 0;
  bm := qryAllocRooms.GetBookmark;
  try
    qryAllocRooms.DisableControls;
    qryFuncBookingMeals.DisableControls;
    qryFuncBookingDrinks.DisableControls;
    qryAllocRooms.First;
    while not qryAllocRooms.Eof do begin
      Result := Result + qryAllocRooms.FieldByName('LinePriceInc').AsFloat;
      qryAllocRooms.Next;
    end;
  finally
    qryAllocRooms.GotoBookmark(bm);
    qryAllocRooms.EnableControls;
    qryFuncBookingMeals.EnableControls;
    qryFuncBookingDrinks.EnableControls;
  end;
end;

procedure TFuncBookingGUI.cboProductCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryFuncBookingMealsProductID.AsInteger := qryMealProducts.FieldByName('PARTSID').AsInteger;
  qryFuncBookingMealsDescription.AsString := qryMealProducts.FieldByName('PartsDescription').AsString;
  SetMealLinePrice;
end;

procedure TFuncBookingGUI.cboDrinkProductCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryFuncBookingDrinksProductID.AsInteger := qryDrinkProducts.FieldByName('PARTSID').AsInteger;
  qryFuncBookingDrinksDescription.AsString := qryDrinkProducts.FieldByName('PartsDescription').AsString;
  SetDrinkLinePrice;
end;

procedure TFuncBookingGUI.SetMealLinePrice;
var
  oDiscObj: TClientDiscountObj;
  dPriceEx, dPriceInc, dDiscount: double;
  sDummy, sDummy2: string;
begin
  oDiscObj := TClientDiscountObj.Create;
  try
    oDiscObj.ClientPrice_Discounts(qryFuncBookingsClientID.AsInteger, 0,
      qryFuncBookingMealsProductID.AsInteger,
      AppEnv.DefaultClass.ClassID,
      qryFuncBookingMealsQty.AsFloat,
      Date(),
      1,
      '',
      '',
      '',
      '',
      '',
      false, dPriceEx, dDiscount, sDummy, sDummy2);
  finally
    FreeAndNil(oDiscObj);
  end;

  //qryFuncBookingMealsPrice.AsCurrency := (dPriceEx - dDiscount)*qryFuncBookingMealsQty.AsFloat;

  dPriceInc := RoundCurrency(GetAmountInc(dPriceEx, GetTaxRate(qryFuncBookingMealsProductID.AsInteger)));
  qryFuncBookingMeals.Edit;
  qryFuncBookingMealsPrice.AsCurrency := dPriceInc * qryFuncBookingMealsQty.AsFloat;
end;

procedure TFuncBookingGUI.SetDrinkLinePrice;
var
  oDiscObj: TClientDiscountObj;
  dPriceEx, dPriceInc, dDiscount: double;
  sDummy, sDummy2: string;
begin
  oDiscObj := TClientDiscountObj.Create;
  try
    oDiscObj.ClientPrice_Discounts(qryFuncBookingsClientID.AsInteger, 0,
      qryFuncBookingDrinksProductID.AsInteger,
      AppEnv.DefaultClass.ClassID,
      qryFuncBookingDrinksQty.AsFloat,
      Date(),
      1,
      '',
      '',
      '',
      '',
      '',
      false, dPriceEx, dDiscount, sDummy, sDummy2);
  finally
    FreeAndNil(oDiscObj);
  end;

  //  qryFuncBookingDrinksPrice.AsCurrency := (dPrice - dDiscount)*qryFuncBookingDrinksQty.AsFloat;
  dPriceInc := RoundCurrency(GetAmountInc(dPriceEx, GetTaxRate(qryFuncBookingDrinksProductID.AsInteger)));
  qryFuncBookingDrinks.Edit;
  qryFuncBookingDrinksPrice.AsCurrency := dPriceInc * qryFuncBookingDrinksQty.AsFloat;
end;

procedure TFuncBookingGUI.ReQueryMeals;
begin
  if qryAllocRooms.RecordCount > 0 then begin
    if qryFuncBookingMeals.Active then begin
      if qryFuncBookingMeals.State in [dsInsert, dsEdit] then begin
        qryFuncBookingMeals.Cancel;
      end;
      qryFuncBookingMeals.Close;
    end;
    qryFuncBookingMeals.ParamByName('xFuncBookingID').AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
    qryFuncBookingMeals.ParamByName('xRoomAllocationID').AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
    qryFuncBookingMeals.Open;
    if qryFuncBookingMeals.RecordCount > 0 then begin
      EditNoAbort(qryFuncBookingMeals);
    end;

    if qryFuncBookingDrinks.Active then begin
      if qryFuncBookingDrinks.State in [dsInsert, dsEdit] then begin
        qryFuncBookingDrinks.Cancel;
      end;
      qryFuncBookingDrinks.Close;
    end;
    qryFuncBookingDrinks.ParamByName('xFuncBookingID').AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
    qryFuncBookingDrinks.ParamByName('xRoomAllocationID').AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
    qryFuncBookingDrinks.Open;
    if qryFuncBookingDrinks.RecordCount > 0 then begin
      EditNoAbort(qryFuncBookingDrinks);
    end;

    if qryFuncResourceAllocations.Active then begin
      if qryFuncResourceAllocations.State in [dsInsert, dsEdit] then begin
        qryFuncResourceAllocations.Cancel;
      end;
      qryFuncResourceAllocations.Close;
    end;
    qryFuncResourceAllocations.ParamByName('xFuncBookingID').AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
    qryFuncResourceAllocations.ParamByName('xRoomAllocationID').AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
    qryFuncResourceAllocations.Open;
    if qryFuncResourceAllocations.RecordCount > 0 then begin
      EditNoAbort(qryFuncResourceAllocations);
    end;

    //SetTimeCbo(cboStartAlloc, qryAllocRoomsStart.AsDateTime);
    //SetTimeCbo(cboEndAlloc, qryAllocRoomsEnd.AsDateTime);
  end;
end;



procedure TFuncBookingGUI.qryAllocRoomsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not IsFlag('DontRequeryMeals') then
    ReQueryMeals;
end;

procedure TFuncBookingGUI.qryFuncBookingMealsNewRecord(DataSet: TDataSet);
var
  bm: TBookMark;
  dtDate, dtTime: TDateTime;
  sCourse, sMeal: string;
  bDateIsNull,bTimeIsNull,bMealIsNull,bCourseIsNull : boolean;
begin
  if IsFlag('DontRequeryMeals') then Exit;
  bDateIsNull := false;
  bTimeIsNull := false;
  bMealIsNull := false;
  bCourseIsNull := false;

  inherited;
  qryFuncBookingMealsRoomAllocationID.AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
  qryFuncBookingMealsFuncBookingID.AsInteger := qryFuncBookingsFuncBookingID.AsInteger;

  // set default date and time
  if qryFuncBookingMeals.RecordCount > 0 then begin
    // get date from previous meal records
    qryFuncBookingMeals.Post;
    qryFuncBookingMeals.Edit;
    bm := qryFuncBookingMeals.GetBookmark;
    qryFuncBookingMeals.DisableControls;
    try
      // not found, so just get date from previous dish
      qryFuncBookingMeals.GotoBookmark(bm);
      qryFuncBookingMeals.Prior;
      if qryFuncBookingMealsDate.IsNull then bDateIsNull := true;
      dtDate := qryFuncBookingMealsDate.AsDateTime;
      if qryFuncBookingMealsTime.IsNull then bTimeIsNull := true;
      dtTime := qryFuncBookingMealsTime.AsDateTime;
      if qryFuncBookingMealsMeal.IsNull then bMealIsNull := true;
      sMeal := qryFuncBookingMealsMeal.AsString;
      if qryFuncBookingMealsCourse.IsNull then bCourseIsNull := true;
      sCourse := qryFuncBookingMealsCourse.AsString;
    finally
      qryFuncBookingMeals.GotoBookmark(bm);
      qryFuncBookingMeals.EnableControls;
    end;

    // now copy the values of the precious record into the current record
    qryFuncBookingMeals.Edit;
    if not bDateIsNull then
      qryFuncBookingMealsDate.AsDateTime := dtDate;
    if not bTimeIsNull then
    qryFuncBookingMealsTime.AsDateTime := dtTime;
    if not bMealIsNull then
      qryFuncBookingMealsMeal.AsString   := sMeal;

    if not bCourseIsNull then begin
      bSuppressCourseChg := true;
      qryFuncBookingMealsCourse.AsString := sCourse;
      bSuppressCourseChg := false;
    end;

    qryFuncBookingMealsCourseSortOrder.AsInteger := qryCourses.FieldByName('CourseOrder').AsInteger;

    qryFuncBookingMeals.Post;
    qryFuncBookingMeals.Edit;
  end;
end;

procedure TFuncBookingGUI.qryFuncBookingDrinksNewRecord(DataSet: TDataSet);
var
  bm: TBookMark;
  dtDate, dtTime: TDateTime;
  sCourse, sMeal: string;
begin
  if IsFlag('DontRequeryMeals') then Exit;
  inherited;
  qryFuncBookingDrinksRoomAllocationID.AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
  qryFuncBookingDrinksFuncBookingID.AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
  //qryFuncBookingDrinks.Post;
  //qryFuncBookingDrinks.Edit;

  qryFuncBookingDrinksRoomAllocationID.AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
  qryFuncBookingDrinksFuncBookingID.AsInteger := qryFuncBookingsFuncBookingID.AsInteger;


  // set default date and time
  if qryFuncBookingDrinks.RecordCount > 0 then begin
    // get date from previous meal records
    qryFuncBookingDrinks.Post;
    qryFuncBookingDrinks.Edit;
    bm := qryFuncBookingDrinks.GetBookmark;
    qryFuncBookingDrinks.DisableControls;
    try

      // not found, so just get date from previous dish
      qryFuncBookingDrinks.GotoBookmark(bm);
      qryFuncBookingDrinks.Prior;
      dtDate := qryFuncBookingDrinksDate.AsDateTime;
      dtTime := qryFuncBookingDrinksTime.AsDateTime;
      sMeal := qryFuncBookingDrinksMeal.AsString;
      sCourse := qryFuncBookingDrinksCourse.AsString;
    finally
      qryFuncBookingDrinks.GotoBookmark(bm);
      qryFuncBookingDrinks.EnableControls;
    end;

    // now copy the values of the previous record into the current record
    qryFuncBookingDrinks.Edit;
    qryFuncBookingDrinksDate.AsDateTime := dtDate;
    qryFuncBookingDrinksTime.AsDateTime := dtTime;
    qryFuncBookingDrinksMeal.AsString := sMeal;
    bSuppressCourseChg := true;
    qryFuncBookingDrinksCourse.AsString := sCourse;
    bSuppressCourseChg := false;

    qryFuncBookingDrinksCourseSortOrder.AsInteger := qryCourses.FieldByName('CourseOrder').AsInteger;

    qryFuncBookingDrinks.Post;
    qryFuncBookingDrinks.Edit;
  end;
end;

procedure TFuncBookingGUI.qryFuncBookingMealsQtyChange(Sender: TField);
begin
  inherited;
  SetMealLinePrice;
end;

procedure TFuncBookingGUI.qryFuncBookingDrinksQtyChange(Sender: TField);
begin
  inherited;
  SetDrinkLinePrice;
end;

procedure TFuncBookingGUI.grdMealsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryFuncBookingMeals);
end;

procedure TFuncBookingGUI.grdDrinksIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryFuncBookingDrinks);
end;

function TFuncBookingGUI.GetTotalPrice(const sTableName: string): currency;
var
  qry: TMyQuery;
begin
  Result := 0;
  if Result = 0 then; // prevent delphi hint
  qry := TMyQuery.Create(nil);
  qry.Connection := MyConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT SUM(Price) as TotalPrice FROM ' + sTableName +
        ' WHERE FuncBookingID = :xFuncBookingID');
      ParamByName('xFuncBookingID').AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
      Open;
      Result := qry.FieldByName('TotalPrice').AsCurrency;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TFuncBookingGUI.grdMealsExit(Sender: TObject);
begin
  inherited;
  if (qryFuncBookingMeals.Active) and (qryFuncBookingMeals.RecordCount <> 0) then begin
    qryFuncBookingMeals.Edit;
    qryFuncBookingMeals.Post;
    qryFuncBookingMeals.Edit;
  end;
end;

procedure TFuncBookingGUI.grdDrinksExit(Sender: TObject);
begin
  inherited;
  if (qryFuncBookingDrinks.Active) and (qryFuncBookingDrinks.RecordCount <> 0) then begin
    qryFuncBookingDrinks.Edit;
    qryFuncBookingDrinks.Post;
    qryFuncBookingDrinks.Edit;
  end;
end;

procedure TFuncBookingGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  if IsOkToSave() then begin
    RollbackTransaction;
  end;
  Self.Close;
end;

procedure TFuncBookingGUI.SelectClient;
begin
  if cboClient.Text <> fsLastClient then begin
    qryFuncBookingsContactID.Clear;
    qryFuncBookingsContact.Clear;
    fsLastClient := cboClient.Text;
  end;
  RefreshCustomer;
end;

procedure TFuncBookingGUI.cboResourceCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryFuncResourceAllocationsFuncResourceID.AsInteger := qryFuncResources.FieldByName('FuncResourceID').AsInteger;
  qryFuncResourceAllocationsFuncBookingID.AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
  qryFuncResourceAllocationsRoomAllocationID.AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
  qryFuncResourceAllocations.Post;
  qryFuncResourceAllocations.Edit;
end;

procedure TFuncBookingGUI.grdResourcesIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryFuncResourceAllocations);
end;

procedure TFuncBookingGUI.grdResourcesExit(Sender: TObject);
begin
  inherited;
  if qryFuncResourceAllocations.Active and (qryFuncResourceAllocations.State in [dsInsert, dsEdit]) then begin
    qryFuncResourceAllocations.Post;
  end;
end;

procedure TFuncBookingGUI.chkBillToClick(Sender: TObject);
begin
  inherited;
  EnablePanel(pnlBillTo, chkBillTo.Checked);
end;

procedure TFuncBookingGUI.cboBillClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  inherited;
  RefreshBillCustomer;
end;

procedure TFuncBookingGUI.RefreshBillCustomer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(Self);
  try
    if Empty(cboBillClient.Text) then begin
      CommonLib.MessageDlgXP_Vista('You must provide a Customer Name', mtError, [mbOK], 0);
      Exit;
    end;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   := Format('SELECT Company, Title, FirstName, LastName, Street, Street2, Suburb, ' +
      'State, Postcode, Phone, AltPhone, FaxNumber, MedTypeID ' + 'FROM tblClients WHERE ClientID = %d ',
      [qryClientsLookup.FieldByName('ClientID').AsInteger]);
    qry.Open;
    Assert(qry.RecordCount = 1, 'Client Not Found');
    if qry.RecordCount > 0 then begin
      qryFuncBookingsBillToDetails.AsString :=
        qry.FieldByName('Company').AsString + crlf + qry.FieldByName('Title').AsString + ' ' +
        qry.FieldByName('FirstName').AsString + ' ' + qry.FieldByName('LastName').AsString + crlf +
        qry.FieldByName('Street').AsString + crlf + qry.FieldByName('Street2').AsString + crlf +
        qry.FieldByName('Suburb').AsString + ' ' + qry.FieldByName('State').AsString + ' ' + qry.FieldByName('Postcode').AsString;
      edtBillPhone.Text := qry.FieldByName('Phone').AsString;
      edtBillAltPhone.Text := qry.FieldByName('AltPhone').AsString;
      edtBillFax.Text := qry.FieldByName('FaxNumber').AsString;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TFuncBookingGUI.btnLetterClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  qryFuncBookings.Post;
  qryFuncBookings.Edit;
  Form := GetComponentByClassName('TfrmClientReference');
  if Assigned(Form) then begin //if has acess

    with TfrmClientReference(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;

  if FormStillOpen('TfrmClientReference') then begin
    with TfrmClientReference(FindExistingComponent('TfrmClientReference')) do begin
        TitleLabel.Caption := 'Booking Letter';
        EditedFlag.Checked := true;
        Ref_Type.Text := 'Letter';
        ClientID.Text := FastFuncs.IntToStr(qryFuncBookings.FieldByName('clientid').AsInteger);
        CID           := qryFuncBookings.FieldByName('ContactID').AsInteger;
        Ref_Date.Text := DateToStr(Date);
        EmailNo.Text  := '';
        FaxNo.Text    := '';
        KeyID         := 0;
        Refresh;
    end;
  end;
end;

function TFuncBookingGUI.IsRoomAvailable(const iRoomID: integer; const dtFrom, dtTo: TDateTime): boolean;
var
  qry: TMyQuery;
begin
  Result := true;

  qry := TMyQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.Sql.Add('SELECT tblfuncroomallocation.RoomAllocationID, tblfuncroomallocation.RoomID, tblfuncroomallocation.Start, tblfuncroomallocation.End ');
    qry.Sql.Add('FROM tblfuncroomallocation INNER JOIN  tblfuncbookings USING(FuncBookingID) ');
    qry.Sql.Add
    ('WHERE tblfuncbookings.Cancellation <> "T" AND tblfuncroomallocation.RoomID = :xRoomID AND tblfuncroomallocation.Start < :xEnd AND tblfuncroomallocation.End > :xStart');
    qry.Params.ParamByName('xRoomID').AsInteger := iRoomID;
    qry.Params.ParamByName('xStart').AsDateTime := dtFrom;
    qry.Params.ParamByName('xEnd').AsDateTime   := dtTo;
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := false;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TFuncBookingGUI.qryAllocRoomsRoomAllocDateChange(Sender: TField);
begin
  inherited;
  if (qryAllocRoomsRoomAllocDate.AsDateTime <> 0) then begin
    qryAllocRooms.FieldByName('Start').AsDateTime :=
      DateOf(qryAllocRoomsRoomAllocDate.AsDateTime) + TimeOf(qryAllocRooms.FieldByName('Start').AsDateTime);
    qryAllocRooms.FieldByName('End').AsDateTime   :=
      DateOf(qryAllocRoomsRoomAllocDate.AsDateTime) + TimeOf(qryAllocRooms.FieldByName('End').AsDateTime);
  end;
end;

procedure TFuncBookingGUI.qryFuncBookingMealsMealChange(Sender: TField);
begin
  inherited;
  EditNoAbort(qryFuncBookingMeals);
  qryFuncBookingMealsMealSortOrder.AsInteger := qryMealsLookup.FieldByName('MealOrder').AsInteger;
end;

procedure TFuncBookingGUI.qryFuncBookingDrinksMealChange(Sender: TField);
begin
  inherited;
  qryFuncBookingDrinksMealSortOrder.AsInteger := qryDrinksMealsLookup.FieldByName('MealOrder').AsInteger;
end;

procedure TFuncBookingGUI.btnSortMealsClick(Sender: TObject);
begin
  inherited;
  qryFuncBookingMeals.Close;
  qryFuncBookingMeals.Open;
  qryFuncBookingMeals.Last;
  qryFuncBookingMeals.Edit;
  qryFuncBookingDrinks.Close;
  qryFuncBookingDrinks.Open;
  qryFuncBookingDrinks.Last;
  qryFuncBookingDrinks.Edit;
end;

procedure TFuncBookingGUI.btnRepeatClick(Sender: TObject);

  procedure AppendCurrent(const Dataset: Tdataset; const sAutoField: string);
  var
    aField: Variant;
    i: integer;
  begin
    // Create a variant Array
    aField := VarArrayCreate([0, DataSet.Fieldcount - 1], VarVariant);
    // read values into the array
    for i := 0 to (DataSet.Fieldcount - 1) do begin
      aField[i] := DataSet.fields[i].Value;
    end;
    DataSet.Append;
    // Put array values into new the record
    for i := 0 to (DataSet.Fieldcount - 1) do begin
      if DataSet.Fields[i].FieldName <> sAutoField then begin
        DataSet.fields[i].Value := aField[i];
      end;
    end;
  end;

  procedure AppendCurrentMeals(const DatasetSource,DataSetTarget: TMyQuery; const sAutoField: string);
  begin
    DataSetTarget.Insert;
    DataSetTarget.FieldByName('Meal').AsString := DatasetSource.FieldByName('Meal').AsString;
    DataSetTarget.FieldByName('Course').AsString := DatasetSource.FieldByName('Course').AsString;
    DataSetTarget.FieldByName('Date').asDateTime := DatasetSource.FieldByName('Date').asDateTime;
    DataSetTarget.FieldByName('Time').asDateTime := DatasetSource.FieldByName('Time').asDateTime;
    DataSetTarget.FieldByName('ProductName').AsString := DatasetSource.FieldByName('ProductName').AsString;
    DataSetTarget.FieldByName('Qty').AsFloat := DatasetSource.FieldByName('Qty').AsFloat;
    DataSetTarget.FieldByName('Price').AsFloat := DatasetSource.FieldByName('Price').AsFloat;
    DataSetTarget.FieldByName('Description').AsString := DatasetSource.FieldByName('Description').AsString;
    DataSetTarget.FieldByName('FuncBookingID').AsInteger := DatasetSource.FieldByName('FuncBookingID').AsInteger;
    DataSetTarget.FieldByName('RoomAllocationID').AsInteger := DatasetSource.FieldByName('RoomAllocationID').AsInteger;
    DataSetTarget.FieldByName('ProductID').AsInteger := DatasetSource.FieldByName('ProductID').AsInteger;
    DataSetTarget.FieldByName('MealSortOrder').AsInteger := DatasetSource.FieldByName('MealSortOrder').AsInteger;
    DataSetTarget.FieldByName('CourseSortOrder').AsInteger := DatasetSource.FieldByName('CourseSortOrder').AsInteger;
  end;

  procedure AppendCurrentDrinks(const DatasetSource,DataSetTarget: TMyQuery; const sAutoField: string);
  begin
    DataSetTarget.Insert;
    DataSetTarget.FieldByName('Meal').AsString := DatasetSource.FieldByName('Meal').AsString;
    DataSetTarget.FieldByName('Course').AsString := DatasetSource.FieldByName('Course').AsString;
    DataSetTarget.FieldByName('Date').asDateTime := DatasetSource.FieldByName('Date').asDateTime;
    DataSetTarget.FieldByName('Time').asDateTime := DatasetSource.FieldByName('Time').asDateTime;
    DataSetTarget.FieldByName('ProductName').AsString := DatasetSource.FieldByName('ProductName').AsString;
    DataSetTarget.FieldByName('Qty').AsFloat := DatasetSource.FieldByName('Qty').AsFloat;
    DataSetTarget.FieldByName('Price').AsFloat := DatasetSource.FieldByName('Price').AsFloat;
    DataSetTarget.FieldByName('Description').AsString := DatasetSource.FieldByName('Description').AsString;
    DataSetTarget.FieldByName('FuncBookingID').AsInteger := DatasetSource.FieldByName('FuncBookingID').AsInteger;
    DataSetTarget.FieldByName('RoomAllocationID').AsInteger := DatasetSource.FieldByName('RoomAllocationID').AsInteger;
    DataSetTarget.FieldByName('ProductID').AsInteger := DatasetSource.FieldByName('ProductID').AsInteger;
    DataSetTarget.FieldByName('MealSortOrder').AsInteger := DatasetSource.FieldByName('MealSortOrder').AsInteger;
    DataSetTarget.FieldByName('CourseSortOrder').AsInteger := DatasetSource.FieldByName('CourseSortOrder').AsInteger;
  end;

  procedure AppendCurrentRecources(const DatasetSource,DataSetTarget: TMyQuery; const sAutoField: string);
  begin
    DataSetTarget.Insert;
    DataSetTarget.FieldByName('ResourceName').asString := DatasetSource.FieldByName('ResourceName').asString;
    DataSetTarget.FieldByName('Qty').AsFloat := DatasetSource.FieldByName('Qty').AsFloat;
    DataSetTarget.FieldByName('FuncBookingID').AsInteger := DatasetSource.FieldByName('FuncBookingID').AsInteger;
    DataSetTarget.FieldByName('RoomAllocationID').AsInteger := DatasetSource.FieldByName('RoomAllocationID').AsInteger;
    DataSetTarget.FieldByName('FuncResourceID').AsInteger := DatasetSource.FieldByName('FuncResourceID').AsInteger;
  end;

  procedure CreateAllocations(const dates: array of TDateTime);
  var
    i,k: integer;
    dtStart, dtEnd: TDateTime;
    MealsIDList, BeveragesIDList,RecourcesIDList : TStringList;
  begin
    MealsIDList := TStringList.Create;
    BeveragesIDList := TStringList.Create;
    RecourcesIDList := TStringList.Create;
    Try
      if not (qryAllocRooms.State in [dsBrowse]) then begin
        qryAllocRooms.Post;
      end;
      dtStart := TimeOf(qryAllocRooms.FieldByName('Start').AsDateTime);
      dtEnd := TimeOf(qryAllocRooms.FieldByName('Start').AsDateTime);
      for i := 0 to Length(dates) - 1 do begin
       //take IDs from related Meals, Beverages, Recourses into apropriate lists
       MealsIDList.Clear;
       BeveragesIDList.Clear;
       RecourcesIDList.Clear;

        qryFuncBookingMeals.First;
        for k := 0 to qryFuncBookingMeals.RecordCount-1 do begin // Meals
          MealsIDList.Add(qryFuncBookingMealsFuncMealID.AsString);
          qryFuncBookingMeals.Next;
        end;

        qryFuncBookingDrinks.First;
        for k := 0 to qryFuncBookingDrinks.RecordCount-1 do begin // Drinks
          BeveragesIDList.Add(qryFuncBookingDrinksFuncDrinkID.AsString);
          qryFuncBookingDrinks.Next;
        end;

        qryFuncResourceAllocations.First;
        for k := 0 to qryFuncResourceAllocations.RecordCount-1 do begin // Resources
          RecourcesIDList.Add(qryFuncResourceAllocationsFuncResourceAllocationID.AsString);
          qryFuncResourceAllocations.Next;
        end;

        AddFlag('DontRequeryMeals');

        AppendCurrent(qryAllocRooms, 'RoomAllocationID');
        qryAllocRooms.FieldByName('RoomAllocDate').AsDateTime := dates[i];
        qryAllocRooms.FieldByName('Start').AsDateTime         := dates[i] + dtStart;
        qryAllocRooms.FieldByName('End').AsDateTime           := dates[i] + dtEnd;
        qryAllocRooms.Post;

        // repeat related Meals, Beverages, Recourses for new Booking



        for k := 0 to MealsIDList.Count-1 do begin // Meals

          qryFuncBookingMeals.Filter := 'FuncMealID = ' + MealsIDList.Strings[k];
          qryFuncBookingMeals.Filtered := true;

          qryTempMeals.Open;
          AppendCurrentMeals(qryFuncBookingMeals,qryTempMeals, 'FuncMealID');
          qryTempMeals.FieldByName('RoomAllocationID').AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
          qryTempMeals.FieldByName('FuncBookingID').AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
          qryTempMeals.FieldByName('Date').AsDateTime := qryAllocRooms.FieldByName('RoomAllocDate').AsDateTime;
          qryTempMeals.Post;
        end;
        qryFuncBookingMeals.Filtered := false;

        for k := 0 to BeveragesIDList.Count-1 do begin // Drinks
          qryFuncBookingDrinks.Filter := 'FuncDrinkID = ' + BeveragesIDList.Strings[k];
          qryFuncBookingDrinks.Filtered := true;

          qryTempDrinks.Open;
          AppendCurrentDrinks(qryFuncBookingDrinks,qryTempDrinks, 'FuncDrinkID');
          qryTempDrinks.FieldByName('RoomAllocationID').AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
          qryTempDrinks.FieldByName('FuncBookingID').AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
          qryTempDrinks.FieldByName('Date').AsDateTime := qryAllocRooms.FieldByName('RoomAllocDate').AsDateTime;
          qryTempDrinks.Post;
        end;
        qryFuncBookingDrinks.Filtered := false;

        for k := 0 to RecourcesIDList.Count-1 do begin // Resources
          qryFuncResourceAllocations.Filter := 'FuncResourceAllocationID = ' + RecourcesIDList.Strings[k];
          qryFuncResourceAllocations.Filtered := true;
          AppendCurrentRecources(qryFuncResourceAllocations,qryTempRecource, 'FuncResourceAllocationID');
          qryTempRecource.FieldByName('RoomAllocationID').AsInteger := qryAllocRoomsRoomAllocationID.AsInteger;
          qryTempRecource.FieldByName('FuncBookingID').AsInteger := qryFuncBookingsFuncBookingID.AsInteger;
          qryTempRecource.Post;
        end;
        qryFuncResourceAllocations.Filtered := false;


      end;
      RemoveFlag('DontRequeryMeals');
      // refresh query for grid
      qryAllocRooms.Close;
      qryAllocRooms.Open;
      qryAllocRooms.Last;
      qryAllocRooms.Edit;
    Finally
      FreeAndNil(MealsIDList);
      FreeAndNil(BeveragesIDList);
      FreeAndNil(RecourcesIDList);
    end;
  end;

begin
  if qryAllocRooms.RecordCount > 0 then begin
    with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
      try
        Caption := 'Repeat Room Booking';
        dtBaseDate.Date := qryAllocRoomsRoomAllocDate.AsDateTime;
        if qryFuncBookingsEndBooking.AsDateTime > dtBaseDate.Date then begin
          dtFinalDate.Date := DateOf(qryFuncBookingsEndBooking.AsDateTime);
        end else begin
          dtFinalDate.Date := qryAllocRoomsRoomAllocDate.AsDateTime + 5; // picked 5 out of my backside
        end;
        ShowModal;
        if ModalResult = mrOk then begin
          CreateAllocations(dates);
        end;
      finally
        Free;
      end;
    end;
  end;
end;

procedure TFuncBookingGUI.qryFuncBookingsExtrasChange(Sender: TField);
begin
  inherited;
  CalcTotals;
end;

procedure TFuncBookingGUI.btnInvoiceClick(Sender: TObject);
var
  oConvert: TTranConvertObj;
  iNewID: integer;
  frmInv: TInvoiceGUI;
  frmSO: TSalesOrderGUI;
  iClientID: integer;
  sMsg: string;
begin
  oConvert := TTranConvertObj.Create;
  try
    if Sender = btnConvert2SalesOrder then begin
      sMsg := 'Are you sure you want to convert this booking to a Sales Order?';
    end else begin
      sMsg := 'Are you sure you want to Invoice this Booking?';
    end;

    if (CommonLib.MessageDlgXP_Vista(sMsg, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      CalcTotals;

      if not SaveData then Exit;

      if qryFuncBookingsUseBillTo.AsString = 'T' then begin
        iClientID := qryFuncBookingsBillToClientID.AsInteger;
      end else begin
        iClientID := qryFuncBookingsClientID.AsInteger;
      end;


      if Sender = btnConvert2SalesOrder then begin
        qryFuncBookings.Edit;
        qryFuncBookings.FieldByName('CreatedSO').AsString := 'T';
        qryFuncBookings.Post;
        qryFuncBookings.Edit;
        iNewID := FastFuncs.StrToInt(oConvert.ConvertFuncBookingToSalesOrder(ttSalesOrder, iClientID,
          qryFuncBookings, qryAllocRooms, qryFuncBookingMeals, qryFuncBookingDrinks));
      end else begin
        qryFuncBookings.Edit;
        qryFuncBookings.FieldByName('CreatedInv').AsString := 'T';
        qryFuncBookings.Post;
        qryFuncBookings.Edit;
        iNewID := FastFuncs.StrToInt(oConvert.ConvertFuncBookingToInvoice(ttInvoice, iClientID, qryFuncBookings,
          qryAllocRooms, qryFuncBookingMeals, qryFuncBookingDrinks));
      end;

      if iNewID > 0 then begin
        if Sender = btnConvert2SalesOrder then begin
          frmSO := TSalesOrderGUI(GetComponentByClassName('TSalesOrderGUI'));
          if Assigned(frmSO) then begin //if has acess
            frmSO.bConvetingFromAppointment := true;
            // might add our own flag here in future - prevents recalc of prices according to special prices
            frmSO.KeyID := iNewID;
            frmSO.FromConversionObject := true;
            frmSO.btnClose.Enabled := false;
            frmSO.FormStyle := fsMDIChild;
            frmSO.SilentMode := true;

            // Are we using company search filtering?
            if AppEnv.Employee.UseSearchCompanies then begin
              // Yes, Set the company name as the filter
              // and with that we can then fill in the
              // upper half of the form details.
              frmSO.fbDontDropProductList := true;
              frmSO.edtCompanySearchFilter.Text := cboClient.LookupTable.FieldByName('Company').AsString;

              // Execute Search Filter Exit Event.
              frmSO.bDropDownClients := false;
              frmSO.edtCompanySearchFilterExit(Sender);

              Application.ProcessMessages;
            end else begin
              {Fire off the CloseUp event of the client combo to populate all other data}
              frmSO.cboClient.OnCloseUp(Self, frmSO.cboClientLookup, frmSO.tblMaster, true);
            end;

            {Recalculates the totals}
            PostMessage(frmSO.Handle, SX_CalcTotalsMsg, 0, 0);
            PostMessage(frmSO.Handle, SX_CalcTotalsMsg, 0, 0);     // X 2?

            {binny :frmInv.tblDetailsQtySoldChange does nothing as the functionality is moved into the object
            and the code in the form was commented. REmoving the commented code deleted the empty proc}
            (*with frmSO.tblDetails do begin
              First;
              while not frmSO.tblDetails.Eof do begin
                frmSO.tblDetailsQtySoldChange(frmSO.tblDetailsQtySold);
                Next;
              end;
              First;
            end;*)

            frmSO.BringToFront;

            // Are we using company search filtering?
            if AppEnv.Employee.UseSearchCompanies then begin
              // Yes, State that the product combos can now be dropped when chosen too.
              frmSO.fbDontDropProductList := false;
            end;
          end
        end else begin
          frmInv := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
          if Assigned(frmInv) then begin //if has acess
            frmInv.bConvetingFromAppointment := true;
            // might add our own flag here in future - prevents recalc of prices according to special prices
            frmInv.KeyID := iNewID;
            frmInv.FromConversionObject := true;
            frmInv.btnClose.Enabled := false;
            frmInv.FormStyle := fsMDIChild;
            frmInv.SilentMode := true;

            // Are we using company search filtering?
            if AppEnv.Employee.UseSearchCompanies then begin
              // Yes, Set the company name as the filter
              // and with that we can then fill in the
              // upper half of the form details.
              frmInv.fbDontDropProductList := true;
              frmInv.edtCompanySearchFilter.Text := cboClient.LookupTable.FieldByName('Company').AsString;

              // Execute Search Filter Exit Event.
              frmInv.bDropDownClients := false;
              frmInv.edtCompanySearchFilterExit(Sender);

              Application.ProcessMessages;
            end else begin
              {Fire off the CloseUp event of the client combo to populate all other data}
              frmInv.cboClient.OnCloseUp(Self, frmInv.cboClientLookup, frmInv.tblMaster, true);
            end;

            {Recalculates the totals}
            PostMessage(frmInv.Handle, SX_CalcTotalsMsg, 0, 0);
            PostMessage(frmInv.Handle, SX_CalcTotalsMsg, 0, 0);     // X 2?
            {binny : frmInv.tblDetailsQtySoldChange does nothing as the functionality is moved into the object
            and the code in the form was commented. REmoving the commented code deleted the empty proc}
          (*  with frmInv.tblDetails do begin
              First;
              while not frmInv.tblDetails.Eof do begin
                frmInv.tblDetailsQtySoldChange(frmInv.tblDetailsQtySold);
                Next;
              end;
              First;
            end;*)

            frmInv.tblMaster.Edit;
            frmInv.tblMaster.FieldByName('Class').AsString := GetClassName(AppEnv.DefaultClass.ClassID);
            frmInv.cboClass.Text := GetClassName(AppEnv.DefaultClass.ClassID);
            frmInv.tblMaster.FieldByName('ClassID').AsInteger := AppEnv.DefaultClass.ClassID;
            frmInv.BringToFront;

            // Are we using company search filtering?
            if AppEnv.Employee.UseSearchCompanies then begin
              // Yes, State that the product combos can now be dropped when chosen too.
              frmInv.fbDontDropProductList := false;
            end;
          end;  
        end;

        qryFuncBookings.FieldByName('Converted').AsString := 'T';
        qryFuncBookings.Post;
        Self.Close;
      end;
    end;
  finally
    FreeAndNil(oConvert);
  end;
end;

procedure TFuncBookingGUI.qryAllocRoomsRateChange(Sender: TField);
begin
  inherited;
  CalcLineTotals;
end;                   

procedure TFuncBookingGUI.qryAllocRoomsRateTypeChange(Sender: TField);
begin
  inherited;
  qryAllocRooms.Edit;
  qryAllocRoomsRate.AsFloat := GetRoomRate(qryAllocRoomsRoomID.AsInteger, cboLineRateType.Text);
end;

procedure TFuncBookingGUI.qryAllocRoomsCalcFields(DataSet: TDataSet);
begin
  inherited;
  CalcTimeInterval;
end;

procedure TFuncBookingGUI.cboStartTimeCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  qryFuncBookingsStartBooking.AsDateTime := DateOf(qryFuncBookingsStartBooking.AsDateTime) + StrToTime(cboStartTime.Text);
end;

procedure TFuncBookingGUI.cboEndTimeCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  qryFuncBookingsEndBooking.AsDateTime := DateOf(qryFuncBookingsEndBooking.AsDateTime) + StrToTime(cboEndTime.Text);
end;



procedure TFuncBookingGUI.SetTimeCbo(const cbo: TwwDBComboBox; const dtTime: TDateTime);
  // Sets the incremented time of the time combo to the time given by dtTime;
var
  i: integer;
  dtIncTime: TDateTime;
  sIncTime: string;
begin
  cbo.ItemIndex := -1;

  // Search thru combo's Time integrals looking to match the time specified
  for i := 0 to cbo.Items.Count - 1 do begin
    sIncTime := cbo.Items[i];
    try
      dtIncTime := StrToTime(sIncTime);
    except
      dtIncTime := 0;
    end;

    if IncSecond(dtIncTime) > TimeOf(dtTime) then begin
      cbo.ItemIndex := i;   // set combo's time to match dtTime
      Break;
    end;
  end;
end;

procedure TFuncBookingGUI.cboStartAllocCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  qryAllocRooms.Edit;
  qryAllocRoomsStart.AsDateTime := DateOf(qryAllocRoomsStart.AsDateTime) + StrToTime(cboStartAlloc.Text);
end;

procedure TFuncBookingGUI.cboEndAllocCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  qryAllocRooms.Edit;
  qryAllocRoomsEnd.AsDateTime := DateOf(qryAllocRoomsEnd.AsDateTime) + StrToTime(cboEndAlloc.Text);
end;

procedure TFuncBookingGUI.btnPosClick(Sender: TObject);
var
  bOk: bool;
  Form : TComponent;
begin
  Form := nil;
  inherited;
  bOK := true;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to convert this Booking to a POS ' +
    #13 + #10 + 'transaction?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if FormStillOpen('TPOSScreenForm') then begin
      if not TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).bTransComplete then begin
        CommonLib.MessageDlgXP_Vista('POS is currently in a transaction, ' +
          'wait until the POS transaction ' + #13 + #10 + 'is complete',
          mtWarning, [mbOK], 0);
        bOK := false;
      end;
    end;
    if bOK then begin
      try
        if SaveData then begin
          if not FormStillOpen('TPOSScreenForm') then begin  // start up POS
            Form := GetComponentByClassName('TPOSScreenForm');
            if Assigned(Form) then begin //if has acess
              with TForm(Form) do begin
                FormStyle := fsmdiChild;
                BringToFront;
              end;
            end;  
          end else begin
            with TForm(FindExistingComponent('TPOSScreenForm')) do begin
              Show;
              BringToFront;
            end;
          end;
          if not Assigned(Form) then Form := GetComponentByClassName('TPOSScreenForm');
          if Assigned(Form) then //if has acess
            TPOSScreenForm(GetComponentByClassName('TPOSScreenForm')).FuncBookingID := qryFuncBookings.FieldByName('FuncBookingID').AsInteger;
          qryFuncBookings.Edit;
          qryFuncBookings.FieldByName('Converted').AsString := 'T';
          qryFuncBookings.Post;
          Self.Close;
        end;
      except
        on EAbort do HandleEAbortException;
        else raise;
      end;
    end;
  end;
end;

procedure TFuncBookingGUI.qryAllocRoomsIntervalCalcChange(Sender: TField);
begin
  inherited;
  CalcLineTotals;
end;

procedure TFuncBookingGUI.qryFuncBookingMealsCourseChange(Sender: TField);
var
  bm: TBookMark;
  dtDate, dtTime: TDateTime;
  sCourse, sMeal: string;
  bFound: boolean;
begin
  inherited;
  if bSuppressCourseChg then Exit;

  bFound := false;
  // set default date and time
  if qryFuncBookingMeals.RecordCount = 0 then begin
    // if no records then just use room allocation date
    qryFuncBookingMealsDate.AsDateTime := StartOfTheDay(qryAllocRoomsStart.AsDateTime);
    qryFuncBookingMealsTime.AsDateTime := TimeOf(qryAllocRoomsStart.AsDateTime);
  end else begin
    // get date from previous meal records
    sMeal   := qryFuncBookingMealsMeal.AsString;
    sCourse := qryFuncBookingMealsCourse.AsString;
    qryFuncBookingMeals.Post;
    qryFuncBookingMeals.Edit;
    bm := qryFuncBookingMeals.GetBookmark;
    qryFuncBookingMeals.DisableControls;

    try
      // get date from any previous dishes with the same Meal & Course
      qryFuncBookingMeals.Prior;
      while not qryFuncBookingMeals.Bof do begin
        if (sMeal = qryFuncBookingMeals.FieldByName('Meal').AsString) and
          (sCourse = qryFuncBookingMeals.FieldByName('Course').AsString) then begin
          bFound := true;
          Break;
        end;
        qryFuncBookingMeals.Prior;
      end;

      if not bFound then begin
        // not found, so just get date from previous dish
        qryFuncBookingMeals.GotoBookmark(bm);
        qryFuncBookingMeals.Prior;
      end;

      // ok, store the dates of the record found
      dtDate := qryFuncBookingMealsDate.AsDateTime;
      dtTime := qryFuncBookingMealsTime.AsDateTime;
    finally
      qryFuncBookingMeals.GotoBookmark(bm);
      qryFuncBookingMeals.EnableControls;
    end;
    qryFuncBookingMeals.Edit;
    qryFuncBookingMealsDate.AsDateTime := dtDate;
    qryFuncBookingMealsTime.AsDateTime := dtTime;
  end;

  qryFuncBookingMealsCourseSortOrder.AsInteger := qryCourses.FieldByName('CourseOrder').AsInteger;
end;

procedure TFuncBookingGUI.qryFuncBookingDrinksCourseChange(Sender: TField);
var
  bm: TBookMark;
  dtDate, dtTime, dtMealTime: TDateTime;
  sCourse, sMeal: string;
  bFound: boolean;

  function GetTimeOfMeal(const sMeal, sCourse: string): TDateTime;
    // retrieves date and time of dish with matching Meal and course in the Meals
  var
    bm: TBookmark;
  begin
    Result := 0;
    bm := qryFuncBookingMeals.GetBookmark;
    qryFuncBookingMeals.DisableControls;
    try
      // get date from any previous dishes with the same Meal & Course
      qryFuncBookingMeals.Last;
      while not qryFuncBookingMeals.Bof do begin
        if (sMeal = qryFuncBookingMeals.FieldByName('Meal').AsString) and
          (sCourse = qryFuncBookingMeals.FieldByName('Course').AsString) then begin
          Result := DateOf(qryFuncBookingMealsDate.AsDateTime) + TimeOf(qryFuncBookingMealsTime.AsDateTime);
          Break;
        end;
        qryFuncBookingMeals.Prior;
      end;
    finally
      qryFuncBookingMeals.GotoBookmark(bm);
      qryFuncBookingMeals.EnableControls;
      qryFuncBookingMeals.Edit;
    end;
  end;
begin
  inherited;
  if bSuppressCourseChg then Exit;


  bFound := false;
  // set default date and time
  sMeal := qryFuncBookingDrinksMeal.AsString;
  sCourse := qryFuncBookingDrinksCourse.AsString;

  // this next line is used to determine if this is the first drink record
  if (qryFuncBookingDrinks.RecordCount = 0) or
    ((qryFuncBookingDrinks.RecordCount = 1) and Empty(qryFuncBookingDrinksDate.AsString)) then begin
    // get here if this is the first record
    dtMealTime := GetTimeOfMeal(sMeal, sCourse);
    // attempt to retrieve date and time from matching meal & course int the Meals grid
    if dtMealTime <> 0 then begin
      // Use Meal times
      qryFuncBookingDrinksDate.AsDateTime := DateOf(dtMealTime);
      qryFuncBookingDrinksTime.AsDateTime := TimeOf(dtMealTime);
    end else begin
      // just use room allocation date
      qryFuncBookingDrinksDate.AsDateTime := StartOfTheDay(qryAllocRoomsStart.AsDateTime);
      qryFuncBookingDrinksTime.AsDateTime := TimeOf(qryAllocRoomsStart.AsDateTime);
    end;
  end else begin
    // get date from previous drink records
    qryFuncBookingDrinks.Post;
    qryFuncBookingDrinks.Edit;
    bm := qryFuncBookingDrinks.GetBookmark;
    qryFuncBookingDrinks.DisableControls;

    try
      // get date from any previous drinks with the same Meal & Course
      qryFuncBookingDrinks.Prior;
      while not qryFuncBookingDrinks.Bof do begin
        if (sMeal = qryFuncBookingDrinks.FieldByName('Meal').AsString) and
          (sCourse = qryFuncBookingDrinks.FieldByName('Course').AsString) then begin
          bFound := true;
          Break;
        end;
        qryFuncBookingDrinks.Prior;
      end;

      if not bFound then begin
        // look for match in meals table
        dtMealTime := GetTimeOfMeal(sMeal, sCourse);
        // attempt to retrieve date and time from matching meal & course int the Meals grid
        if dtMealTime <> 0 then begin
          dtDate := DateOf(dtMealTime);
          dtTime := TimeOf(dtMealTime);
        end else begin
          // not found, so just get date from previous dish
          qryFuncBookingDrinks.GotoBookmark(bm);
          qryFuncBookingDrinks.Prior;
          // store the dates of the record found
          dtDate := qryFuncBookingDrinksDate.AsDateTime;
          dtTime := qryFuncBookingDrinksTime.AsDateTime;
        end;
      end else begin
        // ok, store the dates of the record found
        dtDate := qryFuncBookingDrinksDate.AsDateTime;
        dtTime := qryFuncBookingDrinksTime.AsDateTime;
      end;

    finally
      qryFuncBookingDrinks.GotoBookmark(bm);
      qryFuncBookingDrinks.EnableControls;
    end;
    qryFuncBookingDrinks.Edit;
    qryFuncBookingDrinksDate.AsDateTime := dtDate;
    qryFuncBookingDrinksTime.AsDateTime := dtTime;
  end;
  qryFuncBookingDrinksCourseSortOrder.AsInteger := qryCourses.FieldByName('CourseOrder').AsInteger;
end;

(*
procedure TFuncBookingGUI.qryFuncBookingDrinksCourseChange(Sender: TField);
var
  bm: TBookMark;
  dtDate, dtTime, dtDateTime: TDateTime;
begin
  inherited;
  if bSuppressCourseChg then EXIT;

  // set default date and time
  if qryFuncBookingDrinks.RecordCount <= 1 then begin
    dtDateTime = GetTimeFromMeals(
    // if no records then just use room allocation date
    qryFuncBookingDrinksDate.AsDateTime := StartOfTheDay(qryAllocRoomsStart.AsDateTime);
    qryFuncBookingDrinksTime.AsDateTime := TimeOf(qryAllocRoomsStart.AsDateTime);
  end else begin
    // get date from previous drink record
    bm := qryFuncBookingDrinks.GetBookmark;
    qryFuncBookingDrinks.DisableControls;

    try
      qryFuncBookingDrinks.Prior;
      dtDate := qryFuncBookingDrinksDate.AsDateTime;
      dtTime := qryFuncBookingDrinksTime.AsDateTime;
    finally
      qryFuncBookingDrinks.GotoBookmark(bm);
      qryFuncBookingDrinks.EnableControls;
    end;
    qryFuncBookingDrinks.Edit;
    qryFuncBookingDrinksDate.AsDateTime := dtDate;
    qryFuncBookingDrinksTime.AsDateTime := dtTime;
  end;

  qryFuncBookingDrinksCourseSortOrder.AsInteger := qryDrinkCourses.FieldByName('CourseOrder').AsInteger;

end;
*)

procedure TFuncBookingGUI.pageControlMainChanging(Sender: TObject; var AllowChange: boolean);
begin
  inherited;
  if (pageControlMain.ActivePage = tabBooking) then begin
    if qryFuncBookingsClientID.AsInteger = 0 then begin
      CommonLib.MessageDlgXP_Vista('Please Enter Customer', mtError, [mbOK], 0);
      SetControlFocus(cboClient);
      AllowChange := false;
    end;
  end;
end;                                    

procedure TFuncBookingGUI.cmdPrintClick(Sender: TObject);
begin
  if SaveData() then begin
    fbReportSQLSupplied := true;
    PrintTemplateReport('Function Booking', GetReportSql(), not AppEnv.Employee.ShowPreview, 1);
    fbReportSQLSupplied := false;
  end;
end;

procedure TFuncBookingGUI.cmdEmailClick(Sender: TObject);
begin
// ?
end;

procedure TFuncBookingGUI.smtpFuncBookAuthenticationFailed(var Handled: boolean);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista('Email connection to SMTP host failed. Please check your user authentication for SMTP', mtInformation , [mbOK], 0);
end;

procedure TFuncBookingGUI.smtpFuncBookConnect(Sender: TObject);
begin
  inherited;
  lblEmail.Caption := 'Connecting...';
end;

function TFuncBookingGUI.GetReportSql: string;
begin
  Result :=
    'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
    'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' + 'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, ' +
    '"Meals    " as Type, 1 as Sort, B.FuncBookingID, ClientID, ContactID, BookingDate, Cancellation,' +
    'MealsPrice, DrinksPrice, B.Extras, TotalInc, StartBooking, EndBooking,' +
    'Status1, Status2, Status3, Status4, Status5, Status6, CustomerDetails,' +
    'RA.RoomAllocDate, RA.Start, RA.End, R.Name, RA.NumPersons, RA.LinePriceInc,' +
    'BM.Date, BM.Time, BM.Meal, BM.MealSortOrder, BM.Course, BM.CourseSortOrder,' +
    'BM.Qty, BM.ProductName, BM.Price ' + 'FROM tblcompanyinformation as CO, tblfuncbookings as B ' +
    'LEFT JOIN tblfuncroomallocation as RA USING (FuncBookingID) ' +
    'LEFT JOIN tblfuncbookingmeals as BM USING (RoomAllocationID) ' + 'LEFT JOIN tblfuncrooms AS R ON R.RoomID = RA.RoomID ' +
    'WHERE B.FuncBookingID = ' + qryFuncBookingsFuncBookingID.AsString + ' ' + 'UNION ALL ' + ' ' +
    'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,    Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,    Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN,'
    + '"Drinks   " as Type, 2 as Sort, B.FuncBookingID, ClientID, ContactID, BookingDate, Cancellation,' +
    'MealsPrice, DrinksPrice, B.Extras, TotalInc, StartBooking, EndBooking,' +
    'Status1, Status2, Status3, Status4, Status5, Status6, CustomerDetails,' +
    'RA.RoomAllocDate, RA.Start, RA.End, R.Name, RA.NumPersons, RA.LinePriceInc,' +
    'BM.Date, BM.Time, BM.Meal, BM.MealSortOrder, BM.Course, BM.CourseSortOrder,' +
    'BM.Qty, BM.ProductName, BM.Price ' + 'FROM tblcompanyinformation as CO, tblfuncbookings as B ' +
    'LEFT JOIN tblfuncroomallocation as RA USING (FuncBookingID) ' +
    'LEFT JOIN tblfuncbookingdrinks as BM USING (RoomAllocationID)' + 'LEFT JOIN tblfuncrooms AS R ON R.RoomID = RA.RoomID ' +
    'WHERE B.FuncBookingID = ' + qryFuncBookingsFuncBookingID.AsString + ' ' + 'UNION ALL ' + ' ' +
    'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,    Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,    Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN,'
    + '"Resources" as Type, 3 as Sort, B.FuncBookingID, ClientID, ContactID, BookingDate, Cancellation,' +
    'MealsPrice, DrinksPrice, B.Extras, TotalInc, StartBooking, EndBooking,' +
    'Status1, Status2, Status3, Status4, Status5, Status6, CustomerDetails,' +
    'RA.RoomAllocDate, RA.Start, RA.End, R.Name, RA.NumPersons, RA.LinePriceInc,' +
    '"" as Date, "" as Time, "" as Meal, "" as MealSortOrder, "" as Course, "" as CourseSortOrder,' +
    'RES.Qty, RES.ResourceName as ProductName, "" as Price ' + 'FROM tblcompanyinformation as CO, tblfuncbookings as B ' +
    'LEFT JOIN tblfuncroomallocation as RA USING (FuncBookingID) ' +
    'LEFT JOIN tblfuncresourceallocation as RES USING (RoomAllocationID) ' +
    'LEFT JOIN tblfuncrooms AS R ON R.RoomID = RA.RoomID ' + 'WHERE B.FuncBookingID = ' +
    qryFuncBookingsFuncBookingID.AsString + ' ORDER BY RoomAllocDate, Start, Name, Sort, MealSortOrder, CourseSortOrder';
end;

procedure TFuncBookingGUI.btnFaxClick(Sender: TObject);
var
  Fax: TFaxObj;
  FaxNo: string;
  savedCursor: TCursor;
  iBookingID: integer;
  sCompany: string;
begin
  inherited;
  FaxNo := GetClientFaxNumber(qryFuncBookingsClientID.AsInteger);
  iBookingID := qryFuncBookingsFuncBookingID.AsInteger;
  sCompany := qryClientsLookup.FieldByName('Company').AsString;
  savedCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    if SaveData() then begin
      if Empty(FaxNo) then begin
        CommonLib.MessageDlgXP_Vista(sCompany + ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
          'Please Review Customer information to Add an Fax Number.', mtWarning, [mbOK], 0);
      end else begin
        lblEmail.Visible := true;
        lblEmail.Caption := 'Adding to Fax Spool...';
        fbReportSQLSupplied := true;
        SaveTemplateReport('Function Booking', GetReportSQL(),
          not AppEnv.Employee.ShowPreview, 'GraphicFile',
          'Booking_' + FastFuncs.IntToStr(iBookingID));
        fbReportSQLSupplied := false;

        Fax := TFaxObj.Create;
        try
          Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
            sCompany,
            FaxNo, 'Booking',
            FastFuncs.IntToStr(iBookingID), 'Function Booking',
            ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
        finally
          FreeAndNil(Fax);
        end;
        lblEmail.Visible := false;
        DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
      end;
    end;
  finally
    Screen.Cursor := savedCursor;
  end
end;

procedure TFuncBookingGUI.actContactsExecute(Sender: TObject);
var
  Form: TComponent;
begin
  inherited;
  if not FormStillOpen('TfrmContactSelector') then begin
    Form := GetComponentByClassName('TfrmContactSelector');
    if Assigned(Form) then begin //if has acess
      with TfrmContactSelector(Form) do begin
        ClientID :=  qryFuncBookings.FieldByName('ClientID').AsInteger;
        lblCustomer.Caption := cboClient.Text;
        strKeyName := cboClient.Text;
        frmCallingContactForm := nil;
        Position := poScreenCenter;

        ShowModal;
      end;
    end;
  end;
  LoadContactDetails(True);
end;

procedure TFuncBookingGUI.actContactsUpdate(Sender: TObject);
begin
  inherited;
  actContacts.Enabled := not Empty(cboClient.Text);
end;

procedure TFuncBookingGUI.qryClientsLookupCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryClientsLookupStopCreditImage.AsInteger := qryClientsLookupStopCredit.AsInteger;
end;

procedure TFuncBookingGUI.chkRescheduledClick(Sender: TObject);
begin
  inherited;
  SetRescheduledStatus;
end;

procedure TFuncBookingGUI.chkCancellationClick(Sender: TObject);
begin
  inherited;
  if not bStartingUp then begin
    SetCancellationStatus;
  end;
end;

procedure TFuncBookingGUI.cboFuncTypeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TFuncTypesGUI');
  if Assigned(Form) then begin //if has acess
    with TFuncTypesGUI(Form) do begin
      FuncTypeName := NewValue;
      ShowModal;
      Accept   := true;
      NewValue := FuncTypeName;
    end;
  end;  
  cboFuncType.LookupTable.Close;
  cboFuncType.LookupTable.Open;
  cboFuncType.LookupTable.Locate('FuncTypeName', NewValue, [loCaseInsensitive]);
  cboFuncType.Text := NewValue;
end;

function TFuncBookingGUI.BeveragesHaveProducts: boolean;
begin
  Result := true;
  qryFuncBookingDrinks.First;
  while not qryFuncBookingDrinks.Eof do begin
    if Empty(qryFuncBookingDrinksProductName.AsString) then begin
      pageControlMain.ActivePage := TTabSheet(tabRooms);    
      pageControlRooms.ActivePage := TTabSheet(tabMenu);
      SetControlFocus(grdDrinks);
      grdDrinks.SetActiveField('ProductName');
      CommonLib.MessageDlgXP_Vista('Must Enter Product Name !', mtWarning, [mbOK], 0);
      Result := false;
      Exit;
    end;
    qryFuncBookingDrinks.Next;
  end;
end;

function TFuncBookingGUI.MealsHaveProducts: boolean;
begin
  Result := true;
  qryFuncBookingMeals.First;
  while not qryFuncBookingMeals.Eof do begin
    if Empty(qryFuncBookingMealsProductName.AsString) then begin
      pageControlMain.ActivePage := TTabSheet(tabRooms);
      pageControlRooms.ActivePage := TTabSheet(tabMenu);
      SetControlFocus(grdMeals);
      grdMeals.SetActiveField('ProductName');
      CommonLib.MessageDlgXP_Vista('Must Enter Product Name !', mtWarning, [mbOK], 0);
      Result := false;
      Exit;      
    end;
    qryFuncBookingMeals.Next;
  end;
end;

procedure TFuncBookingGUI.dtpTimeChange(Sender: TObject);
begin
  inherited;
  if not Empty(dtpTime.Text) and not CheckTimeStr(dtpTime.Text) then begin
    dtpTime.Clear;
    Abort;
  end;    
end;

function TFuncBookingGUI.CheckTimeStr(const TimeStr: string): boolean;
begin
  Result := true;
  try
    StrToTime(TimeStr);
  except
    on EConvertError do begin
      Result := false;
      //      CommonLib.MessageDlgXP_Vista('"' + TimeStr + '" is not a valid time.', mtWarning, [mbOK], 0);
    end else raise;
  end;
end;

procedure TFuncBookingGUI.mnuCustomiseGridClick(Sender: TObject);
var
  SourceGrid: TComponent;
begin
  inherited;

  if Sender is TMenuItem then
  begin
    with TMenuItem(Sender) do
    begin
      SourceGrid := TAdvPopupMenu(TMenuItem(Sender).GetParentMenu).PopupComponent;

      if SourceGrid.Name = 'grdRooms' then
      begin
        GuiPrefs.ShowCustomiseForm('Rooms Grid');
      end
      else if SourceGrid.Name = 'grdAllRooms' then
      begin
        GuiPrefs.ShowCustomiseForm('Select Room Grid');
      end
      else if SourceGrid.Name = 'grdMeals' then
      begin
        GuiPrefs.ShowCustomiseForm('Meals Grid');
      end
      else if SourceGrid.Name = 'grdDrinks' then
      begin
        GuiPrefs.ShowCustomiseForm('Beverages Grid');
      end
      else if SourceGrid.Name = 'grdResources' then
      begin
        GuiPrefs.ShowCustomiseForm('Resources Grid');
      end;
    end;
  end;
end;

procedure TFuncBookingGUI.grdAllRoomsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryAllRooms);
end;

procedure TFuncBookingGUI.edtClientDetailsEnter(Sender: TObject);
begin
  inherited;
  ClearBlanksInAddressField;
end;

initialization
  RegisterClassOnce(TFuncBookingGUI);
  with FormFact do begin
    RegisterMe(TFuncBookingGUI, 'TRemindersListGUI_*_Function Booking=ID');
    RegisterMe(TFuncBookingGUI, 'TFuncBookingsListGUI_*=FuncBookingID');
    RegisterMe(TFuncBookingGUI, 'TFuncResourceAllocationListGUI_*=FuncBookingID');
    RegisterMe(TFuncBookingGUI, 'TFuncRoomAllocationListGUI_*=FuncBookingID');
  end;
end.

