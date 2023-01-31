unit frmBOMPlanner;

{replacing TfmEmpResProcScheduleVsRoster}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, ComCtrls, Shader, DNMPanel, DBPlanner, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, BOMColoursObj, Planner, DAScript, MyScript,
  DNMSpeedButton , BOMPlannerLib, DNMAction, ActnList, ProcessUtils;

type
  TDBSourceREfreshRec = record
    IntObj :Integer;
    ProcesstimeID:Integer;
  end;

  TfmBOMPlanner = class(TBaseInputGUI)
    pnlheader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    dtStart: TDateTimePicker;
    btnPrev: TButton;
    btnNext: TButton;
    pnlFooter: TDNMPanel;
    Planners: TPageControl;
    TabDAy: TTabSheet;
    TabWeek: TTabSheet;
    TabMonth: TTabSheet;
    pnlDay: TDNMPanel;
    pnnlWeek: TDNMPanel;
    pnlMonth: TDNMPanel;
    QryProcesstime: TERPQuery;
    dsWeekRoster: TDataSource;
    dsDayRoster: TDataSource;
    QryProcesstimeSaleID: TIntegerField;
    QryProcesstimeSaleLineId: TIntegerField;
    QryProcesstimecustomername: TWideStringField;
    QryProcesstimesaledate: TDateTimeField;
    QryProcesstimeProductName: TWideStringField;
    QryProcesstimeUnitofMeasureShipped: TFloatField;
    QryProcesstimeProctreetotalQty: TFloatField;
    QryProcesstimeUOM: TWideStringField;
    QryProcesstimeSalesconverted: TWideStringField;
    QryProcesstimecaption: TWideStringField;
    QryProcesstimeItemCaption: TWideStringField;
    QryProcesstimeProcessStep: TWideStringField;
    QryProcesstimeProcessstepId: TIntegerField;
    QryProcesstimeResource: TWideStringField;
    QryProcesstimeResourceDetail: TWideStringField;
    QryProcesstimeEmployeeName: TWideStringField;
    QryProcesstimeProcessTimeID: TIntegerField;
    QryProcesstimeProcessPartId: TIntegerField;
    QryProcesstimeTimeStart: TDateTimeField;
    QryProcesstimeTimeEnd: TDateTimeField;
    QryProcesstimeBuildDate: TDateTimeField;
    QryProcesstimeQtyScheduled: TFloatField;
    QryProcesstimeQtyBuilt: TFloatField;
    QryProcesstimeQtyUsed: TFloatField;
    pnlGrid: TDNMPanel;
    grdMain: TwwDBGrid;
    btnGrid: TwwIButton;
    Horizontal1: TSplitter;
    QryEmployees: TERPQuery;
    qryResourceD: TERPQuery;
    tabResDays: TTabSheet;
    TabResWeek: TTabSheet;
    TabResMonth: TTabSheet;
    pnlResDAys: TDNMPanel;
    pnlResWeek: TDNMPanel;
    pnlResMonth: TDNMPanel;
    plannerDay: TDBPlanner;
    sctProcesstimeList: TERPScript;
    QryProcesstimeDuration: TWideStringField;
    QryProcesstimeSchdDuration: TWideStringField;
    QryProcesstimeProcessStatus: TWideStringField;
    qryResourceDNo: TLargeintField;
    qryResourceDProcResourceId: TIntegerField;
    qryResourceDResource: TWideStringField;
    qryResourceDPRDID: TIntegerField;
    qryResourceDResourceDetail: TWideStringField;
    QryEmployeesEmployeeName: TWideStringField;
    QryProcesstimeID: TIntegerField;
    QryProcesstimeProcResourceId: TIntegerField;
    QryProcesstimeEmployeeID: TIntegerField;
    QryProcesstimePRDID: TIntegerField;
    QryEmployeesEmployeeID: TIntegerField;
    btnRequery: TDNMSpeedButton;
    plannerMonth: TDBPlanner;
    PlannerWeek: TDBPlanner;
    MonthSource: TDBWeekSource;
    dsMonthRoster: TDataSource;
    DaySource: TDBDaySource;
    btnOptions: TDNMSpeedButton;
    plannerResDay: TDBPlanner;
    PlannerREsWeek: TDBPlanner;
    PlannerResMonth: TDBPlanner;
    ResMonthSource: TDBWeekSource;
    resDaySource: TDBDaySource;
    dsResDayRoster: TDataSource;
    dsResWeekRoster: TDataSource;
    dsResMonthRoster: TDataSource;
    QryProcesstimeEmployeeIDLookup: TIntegerField;
    QryProcesstimePRDIdLookup: TIntegerField;
    sctDataUpdate: TERPScript;
    cmdCancel: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    QryEmployeesNo: TLargeintField;
    lblMsg: TLabel;
    QryResources: TERPQuery;
    QryResourcesNo: TLargeintField;
    QryResourcesProcResourceId: TIntegerField;
    QryResourcesResource: TWideStringField;
    TimeLineSource: TDBTimeLineSource;
    ResTimeLineSource: TDBTimeLineSource;
    ActionList: TActionList;
    actCancel: TAction;
    actSave: TAction;
    actOpenSale: TAction;
    actProductTree: TAction;
    actAutoSchedule: TAction;
    actPrintPickingSlip: TAction;
    actPrintWorkSheets: TAction;
    actRefresh: TAction;
    actInvoice: TAction;
    actOrderStatus: TDNMAction;
    actStowAway: TDNMAction;
    actPrintJobDetails: TDNMAction;
    actPQAllocation: TDNMAction;
    actallocPickingSlip: TDNMAction;
    actPartialInvoice: TDNMAction;
    MnuItemPopup: TAdvPopupMenu;
    FlagasScheduled1: TMenuItem;
    FlagasStarted1: TMenuItem;
    FlagasComplete1: TMenuItem;
    FlagasCompleteandEdit1: TMenuItem;
    FlagasQualityAssurance1: TMenuItem;
    FlagasNotScheduled1: TMenuItem;
    N2: TMenuItem;
    mnuGoodOrderStatus: TMenuItem;
    OpenSale1: TMenuItem;
    ProductTree1: TMenuItem;
    BinBatchSerialNoPickingSlip1: TMenuItem;
    CreatePickingSlip1: TMenuItem;
    ProductionWorkSheets1: TMenuItem;
    CompleteandInvoice1: TMenuItem;
    OrderStatus1: TMenuItem;
    PrintJobDetails1: TMenuItem;
    N3: TMenuItem;
    StowAways1: TMenuItem;
    PQAAllocation1: TMenuItem;
    mnuPartialInvoice: TMenuItem;
    mnuPartialShipments: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    actInvoiceTotOrder: TAction;
    CompleteandInvoiceTotalOrder1: TMenuItem;
    chkShowFinalised: TCheckBox;
    actSelectAll: TDNMAction;
    actUnselectAll: TDNMAction;
    N7: TMenuItem;
    SelectAll1: TMenuItem;
    UnSelectAll1: TMenuItem;
    btnAutoSchedule: TDNMSpeedButton;
    QryProcesstimeProductDesc: TWideStringField;
    DNMPanel1: TDNMPanel;
    Shader1: TShader;
    lblCaption: TLabel;
    rgCateogry: TRadioGroup;
    rgPeriod: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure rgPeriodClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dtStartChange(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QryEmployeesAfterOpen(DataSet: TDataSet);
    procedure SourceFieldsToitem(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure SourceItemTofields(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure btnOptionsClick(Sender: TObject);
    procedure qryResourceDAfterOpen(DataSet: TDataSet);
    procedure plannerDayItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure plannerDayItemHint(Sender: TObject; Item: TPlannerItem;
      var Hint: string);
    procedure lblCaptionDblClick(Sender: TObject);
    procedure QryProcesstimeAfterPost(DataSet: TDataSet);
    procedure QryProcesstimeBeforeDelete(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OnPlannerItemMoving(Sender: TObject; Item: TPlannerItem;
      DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
    procedure QryResourcesAfterOpen(DataSet: TDataSet);
    procedure QryProcesstimeAfterOpen(DataSet: TDataSet);
    procedure actPrintJobDetailsExecute(Sender: TObject);
    procedure actPrintWorkSheetsExecute(Sender: TObject);
    procedure mnuGoodOrderStatusClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actallocPickingSlipExecute(Sender: TObject);
    procedure actPQAllocationExecute(Sender: TObject);
    procedure actStowAwayExecute(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure actInvoiceTotOrderExecute(Sender: TObject);
    procedure chkShowFinalisedClick(Sender: TObject);
    procedure SelectOrUnselect(Sender: TObject);
    procedure mnuPartialShipmentsClick(Sender: TObject);
    procedure actPartialInvoiceExecute(Sender: TObject);
    procedure actOrderStatusExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actOpenSaleExecute(Sender: TObject);
    procedure actProductTreeExecute(Sender: TObject);
    procedure actAutoScheduleExecute(Sender: TObject);
    procedure actPrintPickingSlipExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure PlannerREsWeekItemPopupPrepare(Sender: TObject;
      PopupMenu: TPopupMenu; Item: TPlannerItem);
    procedure PlannerWeekItemSelect(Sender: TObject; Item: TPlannerItem);
    procedure pnlheaderDblClick(Sender: TObject);
  private
    fBOMColours :TBOMColours;
    TableName :String;
    fbshowSaleId        :Boolean;
    fbCustomerName      :Boolean;
    fbSaleDate          :Boolean;
    fbShowProductName   :Boolean;
    fbShowProductDesc   :Boolean;
    fbUOM               :Boolean;
    fbshipped           :Boolean;

    fbCaption           :Boolean;
    fbProcessStep       :Boolean;
    fbTotalduration     :Boolean;
    fbSchdDuration      :Boolean;
    fbProcessStatus     :Boolean;
    fbResourcename      :Boolean;
    fbREsourceDetailName:Boolean;
    fbShowSchdtime      :Boolean;
    Dirty               :boolean;

    fbDateSupplied      :boolean;

    DBSourceRefreshHistory : Array of TDBSourceREfreshRec;

    procedure ShowTab(Const PrdIndex, CatIndex:Integer);
    procedure Readguiprefs;
    procedure Writeguiprefs;
    Procedure RefreshQuery;
    Function DateFrom :TDatetime;
    Function DateTo :Tdatetime;

    function GetEmployeeFromPosition(const iPosition: integer): integer;
    //function GetResourceFromPosition(const iPosition: integer): integer;
    function GetResourceDetailsFromPosition(const iPosition: integer): integer;

    //function GetEmployeePositionFromID(const iID: integer): integer;
    function GetResourcePositionFromID(const iID: integer): integer;
    //function GetResourceDetailsPositionFromID(const iID: integer): integer;

    Function BOMColours : TBOMColours;
    procedure InitPlanners;
    procedure UpdateHeaders(const planner: TDBPlanner);
    procedure UpdateresHeaders(const planner: TDBPlanner);
    function NewItemProperty: TBOMPlannerItem;
    procedure InitBOMPlannerItemProperties(BOMPlannerItemProperties: TBOMPlannerItem;Fields: TFields);
    procedure InitScript;
    procedure MakeTempTable;
    procedure ExecuteUpdateSQL(const SQLValue: String);
    procedure LockCapacityplanner;
    function GetResourceFromDetailsPosition(const iPosition: integer): integer;
    Function CurItem             :TPlannerItem;
    Function isItemSelected(MsgWhenNoneSelected:String =''):Boolean;
    function CurPlannerResDay: TDBPlanner;
    procedure BeforeShowSalesPurchaseOrderList(Sender: TObject);
    procedure FlagSelectedItems(const status: TProcessPartStatus);Overload;
    procedure FlagSelectedItems(const status: TProcessPartStatus; SaleIDs:String);Overload;
    function ShowSelectedSales(SaleIDs: String): Boolean;
    procedure beforeshowsalesOrderInvoicesGUI(Sender: TObject);
    procedure initSalesorderInvoice(Sender: TObject);
    procedure OnSalesOrderInvoiceCreate(Sender: TObject);
    procedure beforeopenBOMOrderStatus(sender: TObject);
    procedure showDateSelection;
    procedure IntQueries;
    function LogItem(aItem: TPlannerItem;aitemobject: TBOMPlannerItem): String;
  Protected
    procedure BeginTransaction; Override;
    Procedure AfterFormShow; Override;
  public
    procedure ShowInDayForm(aDate: TDateTime);
    procedure ShowInWeekForm(aDate: TDateTime);
    procedure ShowInMonthForm(aDate: TDateTime);
  end;


implementation

uses CommonLib, CommonDbLib, dateutils, MySQLConst, LogLib,
  frmBOMPLannerOptions, frmBOMPlannerItemDetails , StrUtils, tcConst, SystemLib,
  ManufactureGuiLib, ManufactureLib,frmProcCapacityPlanningWork, SalesPurchaseOrderList,
  CommonFormLib, TempTableUtils, tcDataUtils, frmBOMAllocation, frmStowAway,
  frmProcCapacityPlanningPick ,IntegerListObj, ProcessDataUtils,
  frmMessageWithList, frmMessageBase, DbSharedObjectsObj, salesOrderInvoices,
  frmSalesorderInvoice, BOMOrderStatus, ProcCapacityPlanningObj, Preferences,
  AppEnvironment, BusObjProcPrefs, BOMLib;

const
  PageDay  = 0;
  Pageweek = -1;// week mode is disabled for the time being - calender entries were overlaping with sunset data  //1;
  Pagemonth= 1;// 2;

{$R *.dfm}

procedure TfmBOMPlanner.actPrintJobDetailsExecute(Sender: TObject);
var
  StrSQL:String;
  fsTablename :String;
begin
  inherited;
  if not isItemSelected then exit;

  with CurItem do begin
    if (TBOMPlannerItem(Itemobject).SaleLineId =0) or ( TBOMPlannerItem(Itemobject).ProcessPartId =0) or (TBOMPlannerItem(Itemobject).UnitofMeasureShipped =0) then exit;
    fsTablename := commondblib.GetUserTemporaryTableName('CPProductDetailreport');
    StrSQL :=ProductJobDEtailsSQL(fsTablename,  TBOMPlannerItem(Itemobject).SaleLineId,  TBOMPlannerItem(Itemobject).ProcessPartId,TBOMPlannerItem(Itemobject).ProctreetotalQty);
  end;

  fbReportSQLSupplied := True;
  PrintTemplateReport('Product Job Details' , strSQL , False, 1);
  TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + fstablename + ';');
  //DestroyUserTemporaryTable(fstablename);
end;

procedure TfmBOMPlanner.actPrintPickingSlipExecute(Sender: TObject);
var
  form: TfmProcCapacityPlanningPick;
  aDateFrom, aDateTo: TDateTime;

  i: integer;
begin
  inherited;
  if not isItemSelected then exit;

  CommitTransaction;
  try

    aDateFrom:= 0;
    aDateTo:= 0;
    form:= TfmProcCapacityPlanningPick.Create(nil);
    With CurPlannerResDay do begin
        for i := Items.Count - 1 downto 0  do begin
          if Items.Items[i].selected then begin
            if TBOMPlannerItem(Items.Items[i].Itemobject).Salesconverted=False then begin
                if (TBOMPlannerItem(Items.Items[i].Itemobject).timestart < aDateFrom) or (aDateFrom = 0) then
                    aDateFrom:= TBOMPlannerItem(Items.Items[i].Itemobject).timestart;
                  if (TBOMPlannerItem(Items.Items[i].Itemobject).timeend > aDateTo) then
                    aDateTo:= TBOMPlannerItem(Items.Items[i].Itemobject).timeend;
                  form.ProcesstepIdList.AddIfNotInList(TBOMPlannerItem(Items.Items[i].Itemobject).ProcessStepId);
                  form.ProcesstepIdList.AddIfNotInList(TBOMPlannerItem(Items.Items[i].Itemobject).ProcessStepId);
            end;
          end;
        end;
    end;

  if form.ProcesstepIdList.IsEmpty then begin
    MessageDlgXP_Vista('Nothing selected / Selected Jobs are Already Converted.',mtInformation,[mbOk],0);
    form.Free;
  end
  else begin

    form.DateFrom:= aDateFrom;
    form.DateTo:= aDateTo;
    form.ShowModal;

  end;
  finally
    BeginTransaction;
  end;
end;

procedure TfmBOMPlanner.actPrintWorkSheetsExecute(Sender: TObject);
var
  form: TfmProcCapacityPlanningWork;
  aDateFrom, aDateTo: TDateTime;
  //x,
  i: integer;
  planner :TDBPlanner;
begin
  inherited;
  Planner := CurPlannerResDay;
  if Planner =nil then exit;

  CommitTransaction;
  try

    aDateFrom:= 0;
    aDateTo:= 0;
    form:= TfmProcCapacityPlanningWork.Create(nil);
    form.CallingFormname := Self.classname;
    for i := planner.Items.Count - 1 downto 0  do begin
      if planner.Items.Items[i].selected then begin
        if TBOMPlannerItem(planner.Items.Items[i].Itemobject).Salesconverted=False then begin
            if (TBOMPlannerItem(planner.Items.Items[i].Itemobject).timestart < aDateFrom) or (aDateFrom = 0) then
                aDateFrom:= TBOMPlannerItem(planner.Items.Items[i].Itemobject).timestart;
              if (TBOMPlannerItem(planner.Items.Items[i].Itemobject).timeend > aDateTo) then
                aDateTo:= TBOMPlannerItem(planner.Items.Items[i].Itemobject).timeend;
              form.ProcesstepIdList.AddIfNotInList(TBOMPlannerItem(planner.Items.Items[i].Itemobject).ProcessStepId);
              form.SaleLineIDList.AddIfNotInList(TBOMPlannerItem(planner.Items.Items[i].Itemobject).saleLineID);
        end;
      end;
    end;

    if form.ProcesstepIdList.IsEmpty then begin
      MessageDlgXP_Vista('Nothing selected' +iif(chkShowFinalised.checked,' / Selected Jobs are Already Converted.', ''),mtInformation,[mbOk],0);
      form.Free;
    end else begin
      form.DateFrom:= aDateFrom;
      form.DateTo:= aDateTo;
      form.ShowModal;
    end;
  finally
    BeginTransaction;
  end;
end;

procedure TfmBOMPlanner.actProductTreeExecute(Sender: TObject);
begin
  inherited;
  if not isItemSelected then exit;

  if TBOMPlannerItem(CurItem.Itemobject).Salesconverted=False then
      ManufactureGuiLib.OpenTree(Self ,  TreeRootIDofPP(TBOMPlannerItem(curItem.Itemobject).ProcessPartId) , TBOMPlannerItem(curItem.Itemobject).SaleID , Userlock, self.Caption);

end;

procedure TfmBOMPlanner.actRefreshExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmBOMPlanner.BeginTransaction;
begin
  inherited;

end;



function TfmBOMPlanner.BOMColours: TBOMColours;
begin
  if fBOMColours =nil then fBOMColours := TBOMColours.create(Self);
  REsult := fBOMColours;
end;

procedure TfmBOMPlanner.btnNextClick(Sender: TObject);
begin
  inherited;
       if rgPeriod.ItemIndex = PageDay   then dtStart.Date := incday  (dtStart.Date,1)
  else if rgPeriod.ItemIndex = Pageweek  then dtStart.Date := incWeek (dtStart.Date,1)
  else if rgPeriod.ItemIndex = Pagemonth then dtStart.Date := incmonth(dtStart.Date,1)
  else exit;
  RefreshQuery;
end;

procedure TfmBOMPlanner.btnOptionsClick(Sender: TObject);
var
  frmOptions : TfmBOMPLannerOptions;
begin
  inherited;

  frmOptions := TfmBOMPLannerOptions.create(Self);
  try
      frmOptions.showSaleId        	:= fbshowSaleId        	;
      frmOptions.CustomerName      	:= fbCustomerName      	;
      frmOptions.SaleDate          	:= fbSaleDate          	;
      frmOptions.ShowProductName   	:= fbShowProductName   	;
      frmOptions.ShowProductDesc   	:= fbShowProductDesc   	;
      frmOptions.UOM               	:= fbUOM               	;
      frmOptions.shipped           	:= fbshipped           	;

      frmOptions.Caption           	:= fbCaption           	;
      frmOptions.ProcessStep       	:= fbProcessStep       	;
      frmOptions.Totalduration     	:= fbTotalduration     	;
      frmOptions.SchdDuration      	:= fbSchdDuration      	;
      frmOptions.ProcessStatus     	:= fbProcessStatus     	;
      frmOptions.Resourcename      	:= fbResourcename      	;
      frmOptions.REsourceDetailName	:= fbREsourceDetailName	;
      frmOptions.showmodal;
      frmOptions.ShowSchdtime     	:= fbShowSchdtime      	;
      if frmOptions.Modalresult = mrOk then begin
          fbshowSaleId        	:= 	frmOptions.showSaleId        	;
          fbCustomerName      	:= 	frmOptions.CustomerName      	;
          fbSaleDate          	:= 	frmOptions.SaleDate          	;
          fbShowProductName    	:= 	frmOptions.ShowProductName   	;
          fbShowProductDesc    	:= 	frmOptions.ShowProductDesc   	;
          fbUOM               	:= 	frmOptions.UOM               	;
          fbshipped           	:= 	frmOptions.shipped           	;

          fbCaption           	:= 	frmOptions.Caption           	;
          fbProcessStep       	:= 	frmOptions.ProcessStep       	;
          fbTotalduration     	:= 	frmOptions.Totalduration     	;
          fbSchdDuration      	:= 	frmOptions.SchdDuration      	;
          fbProcessStatus      	:= 	frmOptions.ProcessStatus      	;
          fbResourcename      	:= 	frmOptions.Resourcename      	;
          fbREsourceDetailName	:= 	frmOptions.REsourceDetailName	;
          fbShowSchdtime      	:= 	frmOptions.ShowSchdtime      	;
          RefreshQuery;
      end;
  finally
    FreeandNil(frmOptions);
  end;

end;

procedure TfmBOMPlanner.btnPrevClick(Sender: TObject);
begin
  inherited;
       if rgPeriod.ItemIndex = PageDay   then dtStart.Date := incday  (dtStart.Date,-1)
  else if rgPeriod.ItemIndex = Pageweek  then dtStart.Date := incWeek (dtStart.Date,-1)
  else if rgPeriod.ItemIndex = Pagemonth then dtStart.Date := incmonth(dtStart.Date,-1)
  else exit;
  RefreshQuery;
end;

procedure TfmBOMPlanner.chkShowFinalisedClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkShowFinalised then RefreshQuery;
end;

function TfmBOMPlanner.CurPlannerResDay: TDBPlanner;
begin
  result := nil;
       if (rgPeriod.itemindex =PageDay  ) and ( rgCateogry.itemindex =0) then result := plannerDay
  else if (rgPeriod.itemindex =PageDay  ) and ( rgCateogry.itemindex =1) then result := plannerResDay
  else if (rgPeriod.itemindex =Pageweek ) and ( rgCateogry.itemindex =0) then result := plannerWeek
  else if (rgPeriod.itemindex =Pageweek ) and ( rgCateogry.itemindex =1) then result := plannerresWeek
  else if (rgPeriod.itemindex =Pagemonth) and ( rgCateogry.itemindex =0) then result := plannerMonth
  else if (rgPeriod.itemindex =Pagemonth) and ( rgCateogry.itemindex =1) then result := plannerResMonth;

end;


function TfmBOMPlanner.CurItem: TPlannerItem;
var
  i:Integer;
  planner :TDBPlanner;
begin
  result := nil;
  Planner := CurPlannerResDay;
  if planner = nil then exit;

  for i := planner.Items.Count - 1 downto 0  do begin
    if planner.Items.Items[i].selected then begin
      result := planner.Items.Items[i];
      Exit;
    end;
  end;
end;

function TfmBOMPlanner.DateFrom: TDatetime;
begin
  Result := dateof(dtStart.Date);
end;

function TfmBOMPlanner.DateTo: Tdatetime;
begin
  Result := dateof(dtStart.Date);
       if rgPeriod.ItemIndex = PageDay then Result := endoftheday(Result)
  else if rgPeriod.ItemIndex = Pageweek then Result := endoftheday(incWeek(Result,1))
  else if rgPeriod.ItemIndex = Pagemonth then Result := endoftheday(IncMonth(Result,1));
end;

procedure TfmBOMPlanner.dtStartChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmBOMPlanner.FormActivate(Sender: TObject);
begin
  inherited;
  if Self.WindowState <> wsMaximized then Self.WindowState := wsMaximized;
end;

procedure TfmBOMPlanner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Writeguiprefs;
  inherited;
  Action := caFree;
end;
procedure TfmBOMPlanner.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ErrorOccurred then Exit;

  CanClose := false;
  if Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
            CommitAndNotify;
            CanClose := true;
            Dirty := false;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

Procedure TfmBOMPlanner.MakeTempTable;
begin
tablename := GetUserTemporaryTableName('BOMPlanner');
sctProcesstimeList.connection :=GetSharedMyDacConnection;
sctProcesstimeList.SQL.clear;
sctProcesstimeList.SQL.add('Drop table if Exists ' +Tablename+';');
sctProcesstimeList.SQL.add('CREATE TABLE  ' +Tablename+' ( '+
                      '	ID                    INT(10)       NOT NULL AUTO_INCREMENT, '+
                      '	SaleID                INT(11)       NULL DEFAULT 0, '+
                      '	SaleLineID            INT(11)       NULL DEFAULT 0, '+
                      '	customername          VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	saledate              DATETIME      NULL DEFAULT NULL, '+
                      '	ProductName           VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProductDesc           VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	UnitofMeasureShipped  DOUBLE        NULL DEFAULT 0, '+
                      '	UOM                   VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	Salesconverted        ENUM("T","F") DEFAULT "F", '+
                      '	caption               VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ItemCaption           VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProctreetotalQty      DOUBLE        NULL DEFAULT 0, '+
                      '	ProcessStep           VARCHAR(255)  NULL DEFAULT " ", '+
                      '	ProcessstepId         INT(11)       NULL DEFAULT 0, '+
                      '	Duration              VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	SchdDuration          VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProcessStatus         VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProcResourceId        int(11)       NULL DEFAULT 0, '+
                      '	EmployeeID            int(11)       NULL DEFAULT 0, '+
                      '	Resource              VARCHAR(255)  NULL DEFAULT NULL, '+
                      ' PRDID                 int(11)       NULL DEFAULT 0, '+
                      '	ResourceDetail        VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	EmployeeName          VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProcessTimeID         INT(11)       NULL DEFAULT 0, '+
                      '	ProcessPartId         INT(11)       DEFAULT NULL, '+
                      '	TimeStart             DATETIME      NULL DEFAULT NULL, '+
                      '	TimeEnd               DATETIME      NULL DEFAULT NULL, '+
                      '	BuildDate             DATETIME      NULL DEFAULT NULL, '+
                      '	QtyScheduled          DOUBLE        NULL DEFAULT NULL, '+
                      '	QtyBuilt              DOUBLE        NULL DEFAULT NULL, '+
                      '	QtyUsed               DOUBLE        NULL DEFAULT NULL, '+
                      '	PRIMARY KEY (ID), '+
                      '	INDEX SaleID (SaleID), '+
                      '	INDEX SaleLineID (SaleLineID), '+
                      '	INDEX ProcessstepId (ProcessstepId), '+
                      '	INDEX ProcessTimeID (ProcessTimeID), '+
                      '	INDEX ProcResourceId (ProcResourceId), '+
                      '	INDEX ProcessPartId (ProcessPartId) '+
                      '	  ) '+
                      '	  COLLATE="utf8_general_ci" '+
                      '	  ENGINE=MyISAM ;');

 sctProcesstimeList.Execute;
end;
procedure TfmBOMPlanner.mnuGoodOrderStatusClick(Sender: TObject);
begin
  inherited;
  if not isItemSelected then exit;
  openERPListform('TSalesPurchaseOrderListGUI' , BeforeShowSalesPurchaseOrderList);
end;
procedure TfmBOMPlanner.mnuPartialShipmentsClick(Sender: TObject);
begin
  inherited;
  if not isItemSelected then exit;
  OpenERPListForm('TsalesOrderInvoicesGUI', beforeshowsalesOrderInvoicesGUI);
end;
procedure TfmBOMPlanner.beforeshowsalesOrderInvoicesGUI(Sender: TObject);
begin
  if not(Sender is TsalesOrderInvoicesGUI) then exit;
  TsalesOrderInvoicesGUI(Sender).SaleID     := TBOMPlannerItem(curItem.Itemobject).saleId;
  TsalesOrderInvoicesGUI(Sender).SalelineID := TBOMPlannerItem(curItem.Itemobject).salelineId;
end;

procedure TfmBOMPlanner.BeforeShowSalesPurchaseOrderList(Sender: TObject);
begin
  if not(Sender is TSalesPurchaseOrderListGUI) then exit;
  if not isItemSelected then exit;
  TSalesPurchaseOrderListGUI(Sender).SaleLineId :=TBOMPlannerItem(curItem.Itemobject).SaleLineId;
end;
Procedure TfmBOMPlanner.IntQueries;
begin
 QryEmployees.SQL.Clear;
 QryEmployees.SQL.Add('Select');
 QryEmployees.SQL.Add('convert(@rownum:=@rownum+1, Signed INTEGER) as No,');
 QryEmployees.SQL.Add('Details.*');
 QryEmployees.SQL.Add('From(');
 QryEmployees.SQL.Add('Select Distinct EmployeeID, EmployeeName from ' + Tablename +'  ');
 if ProcPrefs.ShowAllEmployeesinProductionScheduler then QryEmployees.SQL.Add('union select distinct E.employeeId , E.employeename  from tblemployeeprocesssteps PT inner join tblemployees E on PT.employeeId = E.employeeId ');
 QryEmployees.SQL.Add('	Order by employeeName) Details');
 QryEmployees.SQL.Add(',(SELECT @rownum:=-1) r');

 QryProcesstime.SQL.text := 'Select * from ' + Tablename +' order by TimeStart , EmployeeName';
 QryResources.SQL.text   :='Select convert(@rownum:=@rownum+1, Signed INTEGER) as No, Details.* '+
                            ' From(Select distinct ProcResourceId , Resource from ' + Tablename +'  '+
                            ' Order by Resource) Details ,(SELECT @rownum:=-1) r';

 qryResourceD.SQL.text   := 'Select convert(@rownum:=@rownum+1, Signed INTEGER) as No, Details.* From  '+
                                          ' (Select distinct ProcResourceId , Resource, PRDID, ResourceDetail from ' + Tablename +' Order by ResourceDetail)  '+
                            ' Details ,(SELECT @rownum:=-1) r ';

logtext(QryEmployees.SQL.TExt +NL+
    QryProcesstime.SQL.text+NL+
    QryResources.SQL.text+NL+
    qryResourceD.SQL.text);


 end;
procedure TfmBOMPlanner.FormCreate(Sender: TObject);
begin
  setlength(DBSourceRefreshHistory,0);
  rgPeriod.items.Clear;
  rgPeriod.items.add('Day');
  //rgPeriod.items.add('Week');
  rgPeriod.items.AdD('Month');
  rgPeriod.Columns := 2;
(*  clog( 'name, '    +
        'int(obj), '+
        'saledate,'+
        'TimeStart,'+
        'TimeEnd,'+
        'BuildDate,'+
        'UnitofMeasureShipped,'+
        'QtyScheduled,'+
        'QtyBuilt,'+
        'QtyUsed,'+
        'SaleID,'+
        'SaleLineID,'+
        'ProcessTimeID,'+
        'ProcessPartId,'+
        'ProcResourceId,'+
        'EmployeeId,'+
        'PRDID,'+
        'Duration,'+
        'SchdDuration,'+
        'ProcessStatus,'+
        'UOM,'+
        'Salesconverted,'+
        'customername,'+
        'caption,'+
        'ProctreetotalQty,'+
        //'ItemCaption,'+
        'ProcessStep,'+
        'ProcessstepId,'+
        'Resource,'+
        'ResourceDetail,'+
        'EmployeeName,'+
        'ProductName,'+
        'ProductDesc');*)

  fbDateSupplied := False;
  MakeTempTable;
  IntQueries;

  Horizontal1.visible := Devmode;
  inherited;
  if rgPeriod.itemindex <PageDay then rgPeriod.itemindex := PageDay;
  InitPlanners;
end;

procedure TfmBOMPlanner.FormDestroy(Sender: TObject);
begin
//  Finalize(fBOMColours);
  fBOMColours.Free;
  CommonDbLib.DestroyUserTemporaryTable(Tablename);
  try finalize(DBSourceRefreshHistory); except end;
  inherited;

end;

procedure TfmBOMPlanner.FormShow(Sender: TObject);
begin
  inherited;
  chkShowFinalised.width := 120;
  Readguiprefs;
  rgPeriodClick(nil);
  //BeginTransaction;
  sctDataUpdate.connection := MyConnection;
  sctDataUpdate.SQL.clear;
  Dirty := false;
  LockCapacityplanner;
  Application.processmessages;
  //pnlGrid.anchors :=   [akLeft,akTop,akRight, akBottom];
end;
Procedure TfmBOMPlanner.LockCapacityplanner;
begin
  if not ManufactureLib.LockCapacityplanner(Userlock, titleLabel.Caption , 'Schedule') then begin
        AccessLevel := 5;
      end else begin
        self.BeginTransaction;
  end;
end;
procedure TfmBOMPlanner.rgPeriodClick(Sender: TObject);
begin
  inherited;
  ShowTab(rgPeriod.itemindex , rgCateogry.itemindex );
  RefreshQuery;
end;

Procedure TfmBOMPlanner.showDateSelection;
begin
             if (rgPeriod.itemindex =PageDay) and ( rgCateogry.itemindex =0) then begin lblCaption.Caption := 'Schedule for ' +Formatdatetime(FormatSettings.ShortDateformat +' ( dddd )', Datefrom);
    end else if (rgPeriod.itemindex =Pageweek) and ( rgCateogry.itemindex =0) then begin lblCaption.Caption := 'Schedule for ' +Formatdatetime(FormatSettings.ShortDateformat , Datefrom) +' to ' + Formatdatetime(FormatSettings.ShortDateformat , DateTo) ;
    end else if (rgPeriod.itemindex =Pagemonth) and ( rgCateogry.itemindex =0) then begin lblCaption.Caption := 'Schedule for ' +Formatdatetime(FormatSettings.ShortDateformat , Datefrom) +' to ' + Formatdatetime(FormatSettings.ShortDateformat , DateTo) ;

    end else if (rgPeriod.itemindex =PageDay) and ( rgCateogry.itemindex =1) then begin lblCaption.Caption := 'Schedule for ' +Formatdatetime(FormatSettings.ShortDateformat +' ( dddd )', Datefrom);
    end else if (rgPeriod.itemindex =Pageweek) and ( rgCateogry.itemindex =1) then begin lblCaption.Caption := 'Schedule for ' +Formatdatetime(FormatSettings.ShortDateformat , Datefrom) +' to ' + Formatdatetime(FormatSettings.ShortDateformat , DateTo) ;
    end else if (rgPeriod.itemindex =Pagemonth) and ( rgCateogry.itemindex =1) then begin lblCaption.Caption := 'Schedule for ' +Formatdatetime(FormatSettings.ShortDateformat , Datefrom) +' to ' + Formatdatetime(FormatSettings.ShortDateformat , DateTo) ;
    end else Exit;

end;
Procedure TfmBOMPlanner.ShowTab(Const PrdIndex, CatIndex:Integer);
var
  ButtonIndex:Integer;
  TabToshow:Integer ;
begin
    for ButtonIndex := Planners.PageCount-1 downto 0 do TTabsheet(Planners.pages[ButtonIndex]).Tabvisible := False;
    ShowDateSelection;

             if (rgPeriod.itemindex =PageDay) and ( rgCateogry.itemindex =0) then begin TabToshow :=0;
    end else if (rgPeriod.itemindex =Pageweek) and ( rgCateogry.itemindex =0) then begin TabToshow :=1;
    end else if (rgPeriod.itemindex =Pagemonth) and ( rgCateogry.itemindex =0) then begin TabToshow :=2;

    end else if (rgPeriod.itemindex =PageDay) and ( rgCateogry.itemindex =1) then begin TabToshow :=3;
    end else if (rgPeriod.itemindex =Pageweek) and ( rgCateogry.itemindex =1) then begin TabToshow :=4;
    end else if (rgPeriod.itemindex =Pagemonth) and ( rgCateogry.itemindex =1) then begin TabToshow :=5;
    end else Exit;

    Planners.ActivePageIndex :=TabToshow;
    TTabsheet(Planners.pages[TabToshow]).Tabvisible := False;
end;
procedure TfmBOMPlanner.InitBOMPlannerItemProperties(BOMPlannerItemProperties: TBOMPlannerItem;Fields: TFields);
begin
    BOMPlannerItemProperties.saledate             := Fields.FieldByName('saledate').asDateTime;
    BOMPlannerItemProperties.TimeStart            := Fields.FieldByName('TimeStart').asDateTime;
    BOMPlannerItemProperties.TimeEnd              := Fields.FieldByName('TimeEnd').asDateTime;
    BOMPlannerItemProperties.BuildDate            := Fields.FieldByName('BuildDate').asDateTime;

    BOMPlannerItemProperties.UnitofMeasureShipped := Fields.FieldByName('UnitofMeasureShipped').asFloat;
    BOMPlannerItemProperties.QtyScheduled         := Fields.FieldByName('QtyScheduled').asFloat;
    BOMPlannerItemProperties.QtyBuilt             := Fields.FieldByName('QtyBuilt').asFloat;
    BOMPlannerItemProperties.QtyUsed              := Fields.FieldByName('QtyUsed').asFloat;

    BOMPlannerItemProperties.SaleID               := Fields.FieldByName('SaleID').asInteger;
    BOMPlannerItemProperties.SaleLineID           := Fields.FieldByName('SaleLineID').asInteger;
    BOMPlannerItemProperties.ProcessTimeID        := Fields.FieldByName('ProcessTimeID').asInteger;
    BOMPlannerItemProperties.ProcessPartId        := Fields.FieldByName('ProcessPartId').asInteger;
    BOMPlannerItemProperties.ProcResourceId       := Fields.FieldByName('ProcResourceId').asInteger;
    BOMPlannerItemProperties.EmployeeId           := Fields.FieldByName('EmployeeId').asInteger;
    BOMPlannerItemProperties.PRDID                := Fields.FieldByName('PRDID').asInteger;

    BOMPlannerItemProperties.Duration             := Fields.FieldByName('Duration').asString;//inttostr(Secondsbetween(BOMPlannerItemProperties.TimeStart,BOMPlannerItemProperties.TimeEnd));
    BOMPlannerItemProperties.SchdDuration         := Fields.FieldByName('SchdDuration').asString;
    BOMPlannerItemProperties.ProcessStatus        := Fields.FieldByName('ProcessStatus').asString;
    BOMPlannerItemProperties.UOM                  := Fields.FieldByName('UOM').asString;
    BOMPlannerItemProperties.Salesconverted       := Fields.FieldByName('Salesconverted').asBoolean;
    BOMPlannerItemProperties.customername         := Fields.FieldByName('customername').asString;
    BOMPlannerItemProperties.caption              := Fields.FieldByName('caption').asString;
    BOMPlannerItemProperties.ProctreetotalQty     := Fields.FieldByName('ProctreetotalQty').asFloat;
    BOMPlannerItemProperties.ItemCaption          := Fields.FieldByName('ItemCaption').asString;
    BOMPlannerItemProperties.ProcessStep          := Fields.FieldByName('ProcessStep').asString;
    BOMPlannerItemProperties.ProcessstepId        := Fields.FieldByName('ProcessstepId').asInteger;
    BOMPlannerItemProperties.Resource             := Fields.FieldByName('Resource').asString;
    BOMPlannerItemProperties.ResourceDetail       := Fields.FieldByName('ResourceDetail').asString;
    BOMPlannerItemProperties.EmployeeName         := Fields.FieldByName('EmployeeName').asString;
    BOMPlannerItemProperties.ProductName          := Fields.FieldByName('ProductName').asString;
    BOMPlannerItemProperties.ProductDesc          := Fields.FieldByName('ProductDesc').asString;
(*    Logtext(Formatdatetime('dd-mm-yy hh:nn:ss', BOMPlannerItemProperties.TimeStart) +' to ' +
            Formatdatetime('dd-mm-yy hh:nn:ss', BOMPlannerItemProperties.TimeEnd));*)
end;
Function TfmBOMPlanner.LogItem(aItem: TPlannerItem;aitemobject:TBOMPlannerItem):String;
var
    s:String;
  (*Function AllFields:String;
  begin
    REsult := Alltrim(FormatdateTime('dd-mm-yy'               , Fields.FieldByName('saledate').asDateTime))+',' +
              Alltrim(FormatdateTime('dd-mm-yy hh:nn:ss am/pm', Fields.FieldByName('TimeStart').asDateTime))+',' +
              Alltrim(FormatdateTime('dd-mm-yy hh:nn:ss am/pm', Fields.FieldByName('TimeEnd').asDateTime))+',' +
              Alltrim(FormatdateTime('dd-mm-yy hh:nn:ss am/pm', Fields.FieldByName('BuildDate').asDateTime))+',' +
                                             Alltrim(FloattoStr(Fields.FieldByName('UnitofMeasureShipped').asFloat))+',' +
                                             Alltrim(FloattoStr(Fields.FieldByName('QtyScheduled').asFloat))+',' +
                                             Alltrim(FloattoStr(Fields.FieldByName('QtyBuilt').asFloat))+',' +
                                             Alltrim(FloattoStr(Fields.FieldByName('QtyUsed').asFloat))+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('SaleID').asInteger))+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('SaleLineID').asInteger))+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('ProcessTimeID').asInteger))+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('ProcessPartId').asInteger))+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('ProcResourceId').asInteger))+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('EmployeeId').asInteger))+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('PRDID').asInteger))+',' +
                                                        Alltrim(Fields.FieldByName('Duration').asString)+',' +
                                                        Alltrim(Fields.FieldByName('SchdDuration').asString)+',' +
                                                        Alltrim(Fields.FieldByName('ProcessStatus').asString)+',' +
                                                        Alltrim(Fields.FieldByName('UOM').asString)+',' +
                                           Alltrim(BooleanToStr(Fields.FieldByName('Salesconverted').asBoolean))+',' +
                                                        Alltrim(Fields.FieldByName('customername').asString)+',' +
                                                        Alltrim(Fields.FieldByName('caption').asString)+',' +
                                             Alltrim(FloattoStr(Fields.FieldByName('ProctreetotalQty').asFloat))+',' +
                                                        //Alltrim(Fields.FieldByName('ItemCaption').asString)+',' +
                                                        Alltrim(Fields.FieldByName('ProcessStep').asString)+',' +
                                               Alltrim(InttoStr(Fields.FieldByName('ProcessstepId').asInteger))+',' +
                                                        Alltrim(Fields.FieldByName('Resource').asString)+',' +
                                                        Alltrim(Fields.FieldByName('ResourceDetail').asString)+',' +
                                                        Alltrim(Fields.FieldByName('EmployeeName').asString)+',' +
                                                        Alltrim(Fields.FieldByName('ProductName').asString)+',' +
                                                        Alltrim(Fields.FieldByName('ProductDesc').asString);
  end;*)
  Procedure AddtoCaption(Const Value:String; sDel:String = ',');
  begin
    if s<> '' then s:= s +sDel;
    s:= s + Value;
  end;
begin
  s:= '';
  try
          addtoCaption(inttostr(Integer(aItem)));
          if aitemobject =nil then begin
            addtoCaption('nil');
            Exit;
          end;
          addtoCaption(inttostr(Integer(aitemobject)));
          if fbshowSaleId       then AddtoCaption('#' + inttostr(aitemobject.SaleID));
          if fbCustomerName     then AddtoCaption(aitemobject.CustomerName);
          if fbSaleDate         then AddtoCaption(FormatDateTime(FormatSettings.ShortDateformat , aitemobject.SaleDate));
          if fbShowProductName  then AddtoCaption(aitemobject.Productname);
          if fbShowProductDesc  then AddtoCaption(aitemobject.ProductDesc);
          if fbshipped          then begin AddtoCaption(FloatTostrF(aitemobject.UnitofMeasureShipped , ffGeneral, 15, 2));
          if fbUOM              then AddtoCaption(aitemobject.UOM); end;
          if s = '' then begin
            AddtoCaption('#' + inttostr(aitemobject.SaleID));
            AddtoCaption(aitemobject.CustomerName);
          end;

  finally
    Result := s;
  end;
end;
procedure TfmBOMPlanner.SourceFieldsToitem(Sender: TObject; Fields: TFields;Item: TPlannerItem);
var
  BOMPlannerItemProperties:TBOMPlannerItem;
  s:String;
  Function Alltrim(const Value:String):String;
  begin
    result := Value;
    result := replacestr(result,'\n',' ');
    result := trim(Value);
  end;

  function DBSourceRefreshHistoryExists :Boolean;
  var
    ctr:Integer;
  begin
    result := false;
    if length(DBSourceRefreshHistory)=0 then exit;
    for ctr:= low(DBSourceRefreshHistory) to high(DBSourceRefreshHistory) do
      if DBSourceRefreshHistory[ctr].IntObj = integer(sender) then
        if DBSourceRefreshHistory[ctr].ProcesstimeID = Fields.FieldByName('ProcessTimeID').asInteger then begin
          result := True;
          Exit;
        end;
  end;
begin
  inherited;
  try
    s:= '';
    try
        if assigned(Item.ItemObject)    then begin s:= 'assigned(Item.ItemObject),'   ; s:= s+ LogItem(Item, TBOMPlannerItem(Item.ItemObject)); Exit; end;
        if DBSourceRefreshHistoryExists then begin s:= 'DBSourceRefreshHistoryExists,'; exit; end;

        Setlength(DBSourceRefreshHistory, length(DBSourceRefreshHistory)+1);
        DBSourceRefreshHistory[high(DBSourceRefreshHistory)].IntObj := integer(sender) ;
        DBSourceRefreshHistory[high(DBSourceRefreshHistory)].ProcesstimeID := Fields.FieldByName('ProcessTimeID').asInteger;

        BOMPlannerItemProperties := NewItemProperty;
        //Logtext(TDBTimelinesource(Sender).name+',' +  inttostr(integer(BOMPlannerItemProperties))+',' +AllFields);

          initBOMPlannerItemProperties(BOMPlannerItemProperties,fields);
          s:= LogItem(Item, BOMPlannerItemProperties);
          item.Shape := psRounded;
          item.CaptionType := Planner.ctText;
          item.ShowDeleteButton := True;
          item.Shadow := True;
          //item.Layer := 4;
          item.CaptionText := s;
          Item.ItemObject := BOMPlannerItemProperties;
          item.Color := BOMColours.Darkcolor(GetResourcePositionFromID(BOMPlannerItemProperties.ProcResourceId)+1);
          item.Captionbkg := item.Color;
          item.Captionbkgto := item.Color;
          Item.FixedPos := (AccessLevel <> 1);
          Item.FixedSize := (AccessLevel <> 1);
          Item.Id := fields.fieldbyname('ProcessTimeID').asInteger;
          Item.Text.Text :=fields.fieldbyname('ItemCaption').asString;
    finally
       if assigned(Item.ItemObject) then begin
         Logtext('F->I:' +s);
       end;
    end;
  Except
    on e:Exception do begin
      logtext(e.message);
    end;
  end;
end;

procedure TfmBOMPlanner.SourceItemTofields(Sender: TObject; Fields: TFields;Item: TPlannerItem);
var
  s:String;
begin
  inherited;
  logtext('I->F:' +LogItem(Item, TBOMPlannerItem(Item.ItemObject)));
  if assigned(Item.ItemObject) then begin
      try
        EditDB(QryProcesstime);
        QryProcesstimePRDID.asInteger := TBOMPlannerItem(Item.ItemObject).PRDID ;
        QryProcesstimeEmployeeId.asInteger := TBOMPlannerItem(Item.ItemObject).EmployeeId ;
        PostDB(QryProcesstime);
      Except
        on E:Exception do begin
          PostDB(QryProcesstime);
        end;
      end;
      Logtext('I->F:' +s);
  end;

end;


procedure TfmBOMPlanner.Readguiprefs;
function HeaderHeight(Const Value:Integer):Integer;begin  if Value > Self.width -50 then Result  :=Self.width -50  else result := Value;end;
begin
  if GuiPrefs.Node.Exists('rgPeriod.itemindex'  ) then rgPeriod.itemindex   := GuiPrefs.Node['rgPeriod.itemindex'].asInteger    else  rgPeriod.itemindex    := PageDay;
  if GuiPrefs.Node.Exists('rgCateogry.itemindex') then rgCateogry.itemindex := GuiPrefs.Node['rgCateogry.itemindex'].asInteger  else  rgCateogry.itemindex  := 0;
  if GuiPrefs.Node.Exists('pnlGrid.Height'      ) then pnlGrid.Height       := GuiPrefs.Node['pnlGrid.Height'].asInteger        else  pnlGrid.Height        := 130;

  if GuiPrefs.Node.Exists('PlannerItemOption.showSaleId')          then fbshowSaleId        	:= GuiPrefs.Node['PlannerItemOption.showSaleId'].asBoolean         else fbshowSaleId        	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.CustomerName')        then fbCustomerName      	:= GuiPrefs.Node['PlannerItemOption.CustomerName'].asBoolean       else fbCustomerName      	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.SaleDate')            then fbSaleDate          	:= GuiPrefs.Node['PlannerItemOption.SaleDate'].asBoolean           else fbSaleDate          	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.ShowProductName')     then fbShowProductName    	:= GuiPrefs.Node['PlannerItemOption.ShowProductName'].asBoolean    else fbShowProductName   	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.ShowProductDesc')     then fbShowProductDesc    	:= GuiPrefs.Node['PlannerItemOption.ShowProductDesc'].asBoolean    else fbShowProductDesc   	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.UOM')                 then fbUOM               	:= GuiPrefs.Node['PlannerItemOption.UOM'].asBoolean                else fbUOM               	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.shipped')             then fbshipped           	:= GuiPrefs.Node['PlannerItemOption.shipped'].asBoolean            else fbshipped           	:= False;

  if GuiPrefs.Node.Exists('PlannerItemOption.Caption')             then fbCaption           	:= GuiPrefs.Node['PlannerItemOption.Caption'].asBoolean            else fbCaption           	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.ProcessStep')         then fbProcessStep       	:= GuiPrefs.Node['PlannerItemOption.ProcessStep'].asBoolean        else fbProcessStep       	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.Totalduration')       then fbTotalduration     	:= GuiPrefs.Node['PlannerItemOption.Totalduration'].asBoolean      else fbTotalduration     	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.SchdDuration')        then fbSchdDuration      	:= GuiPrefs.Node['PlannerItemOption.SchdDuration'].asBoolean       else fbSchdDuration      	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.ProcessStatus')       then fbProcessStatus     	:= GuiPrefs.Node['PlannerItemOption.ProcessStatus'].asBoolean      else fbProcessStatus      	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.Resourcename')        then fbResourcename      	:= GuiPrefs.Node['PlannerItemOption.Resourcename'].asBoolean       else fbResourcename      	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.REsourceDetailName')  then fbREsourceDetailName	:= GuiPrefs.Node['PlannerItemOption.REsourceDetailName'].asBoolean else fbREsourceDetailName	:= False;
  if GuiPrefs.Node.Exists('PlannerItemOption.ShowSchdtime')        then fbShowSchdtime      	:= GuiPrefs.Node['PlannerItemOption.ShowSchdtime'].asBoolean       else fbShowSchdtime      	:= False;
  if GuiPrefs.Node.Exists('DataGrid.Visible')                      then pnlGrid.visible      	:= GuiPrefs.Node['DataGrid.Visible'].asBoolean                     else pnlGrid.visible      	:= devmode;
  if GuiPrefs.Node.Exists('Options.ShowFinalised')                 then chkShowFinalised.checked:= GuiPrefs.Node['Options.ShowFinalised'].asBoolean           ;


  if GuiPrefs.Node.Exists('Options.plannerDay.Header') then begin
    plannerDay.Header.height := HeaderHeight(GuiPrefs.Node['Options.plannerDay.Header.Height'].asInteger);
    plannerDay.Header.ItemHeight := plannerDay.Header.height ;
    plannerDay.Header.TextHeight := plannerDay.Header.height ;
  end;

  if GuiPrefs.Node.Exists('Options.PlannerWeek.Header') then begin
    plannerWeek.Header.height := HeaderHeight(GuiPrefs.Node['Options.PlannerWeek.Header.Height'].asInteger);
    plannerWeek.Header.ItemHeight := plannerWeek.Header.height ;
    plannerWeek.Header.TextHeight := plannerWeek.Header.height ;
  end;

  if GuiPrefs.Node.Exists('Options.plannerMonth.Header') then begin
    plannerMonth.Header.height := HeaderHeight(GuiPrefs.Node['Options.plannerMonth.Header.Height'].asInteger);
    plannerMonth.Header.ItemHeight := plannerMonth.Header.height ;
    plannerMonth.Header.TextHeight := plannerMonth.Header.height ;
  end;

  if GuiPrefs.Node.Exists('Options.plannerResDay.Header') then begin
    plannerResDay.Header.height := HeaderHeight(GuiPrefs.Node['Options.plannerResDay.Header.Height'].asInteger);
    plannerResDay.Header.ItemHeight := plannerResDay.Header.height ;
    plannerResDay.Header.TextHeight := plannerResDay.Header.height ;
  end;

  if GuiPrefs.Node.Exists('Options.plannerResWeek.Header') then begin
    plannerResWeek.Header.height := HeaderHeight(GuiPrefs.Node['Options.plannerResWeek.Header.Height'].asInteger);
    plannerResWeek.Header.ItemHeight := plannerResWeek.Header.height ;
    plannerResWeek.Header.TextHeight := plannerResWeek.Header.height ;
  end;

  if GuiPrefs.Node.Exists('Options.plannerResMonth.Header') then begin
    plannerResMonth.Header.height := HeaderHeight(GuiPrefs.Node['Options.plannerResMonth.Header.Height'].asInteger);
    plannerResMonth.Header.ItemHeight := plannerResMonth.Header.height ;
    plannerResMonth.Header.TextHeight := plannerMonth.Header.height ;
  end;


(*  if GuiPrefs.Node.Exists('plannerDay.HeaderHeight')      then plannerDay.Header.height     := GuiPrefs.Node['plannerDay.HeaderHeight'].asInteger       else plannerDay.Header.height     := 100;
  if GuiPrefs.Node.Exists('PlannerWeek.HeaderHeight')     then PlannerWeek.Header.height    := GuiPrefs.Node['PlannerWeek.HeaderHeight'].asInteger      else PlannerWeek.Header.height    := 100;
  if GuiPrefs.Node.Exists('plannerMonth.HeaderHeight')    then plannerMonth.Header.height   := GuiPrefs.Node['plannerMonth.HeaderHeight'].asInteger     else plannerMonth.Header.height   := 100;
  if GuiPrefs.Node.Exists('plannerResDay.HeaderHeight')   then plannerResDay.Header.height  := GuiPrefs.Node['plannerResDay.HeaderHeight'].asInteger    else plannerResDay.Header.height  := 100;
  if GuiPrefs.Node.Exists('PlannerREsWeek.HeaderHeight')  then PlannerREsWeek.Header.height := GuiPrefs.Node['PlannerREsWeek.HeaderHeight'].asInteger   else PlannerREsWeek.Header.height := 100;
  if GuiPrefs.Node.Exists('PlannerResMonth.HeaderHeight') then PlannerResMonth.Header.height:= GuiPrefs.Node['PlannerResMonth.HeaderHeight'].asInteger  else PlannerResMonth.Header.height:= 100;*)

  if not fbDateSupplied then dtStart.Date := Date;
end;
Procedure TfmBOMPlanner.InitScript;

function ItemCaptionFields :String;
var
  s:String;
  Procedure Addfield(Const fieldname :String; sDel:String ='');
  begin
    if (s <> '') and (sDel <> '') then s := s +','+Quotedstr(sDel);
    if s<> '' then s := s +',';
    s:= s + fieldname;
  end;
begin
  s:= '';
  if fbCaption            then Addfield('PT.caption' , '\n');
  if fbProcessStep        then Addfield('PS.Description' , '\n');
  if fbTotalduration      then Addfield('FormatSecondsTotime((ifnull(PP.Duration,0)+ifnull(PP.SetupDuration,0)+ifnull(PP.BreakdownDuration,0))*PT.totalQty)' , '\n');
  if fbSchdDuration       then Addfield('	FormatSecondsTotime(PST.Duration)' , '\n');
  if fbProcessStatus      then Addfield('"Status :" , 	ProcessPartStatusToUserStr(PST.Status)' , '\n');
  if fbResourcename       then Addfield('PR.Description' , '\n');
  if fbREsourceDetailName then Addfield('PRD.Description' , '\n');
  if fbShowSchdtime       then Addfield('PST.TimeStart  , " To " , DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) ' , '\n');
  if s = '' then s:= 'PT.caption ,": " , PS.Description  , "\n",PR.Description , ". " ,PRD.Description ';
  Addfield('if(S.converted="T" , " Order Converted" , "")','\n');
  s:= 'Concat(' + s+ ')';
  Result := s;
end;
begin
(*sctProcesstimeList.connection :=GetSharedMyDacConnection;
sctProcesstimeList.SQL.clear;
//sctProcesstimeList.SQL.add('Drop table if Exists ' +Tablename+';');
sctProcesstimeList.SQL.add('CREATE TABLE if not exists ' +Tablename+' ( '+
                      '	ID                    INT(10)       NOT NULL AUTO_INCREMENT, '+
                      '	SaleID                INT(11)       NULL DEFAULT 0, '+
                      '	customername          VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	saledate              DATETIME      NULL DEFAULT NULL, '+
                      '	ProductName           VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	UnitofMeasureShipped  DOUBLE        NULL DEFAULT 0, '+
                      '	UOM                   VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	caption               VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ItemCaption           VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProcessStep           VARCHAR(255)  NULL DEFAULT " ", '+
                      '	Duration              VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	SchdDuration          VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProcResourceId        int(11)       NULL DEFAULT 0, '+
                      '	EmployeeID            int(11)       NULL DEFAULT 0, '+
                      '	Resource              VARCHAR(255)  NULL DEFAULT NULL, '+
                      ' PRDID                 int(11)       NULL DEFAULT 0, '+
                      '	ResourceDetail        VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	EmployeeName          VARCHAR(255)  NULL DEFAULT NULL, '+
                      '	ProcessTimeID         INT(11)       NULL DEFAULT 0, '+
                      '	ProcessPartId         INT(11)       DEFAULT NULL, '+
                      '	TimeStart             DATETIME      NULL DEFAULT NULL, '+
                      '	TimeEnd               DATETIME      NULL DEFAULT NULL, '+
                      '	BuildDate             DATETIME      NULL DEFAULT NULL, '+
                      '	QtyScheduled          DOUBLE        NULL DEFAULT NULL, '+
                      '	QtyBuilt              DOUBLE        NULL DEFAULT NULL, '+
                      '	QtyUsed               DOUBLE        NULL DEFAULT NULL, '+
                      '	PRIMARY KEY (ID), '+
                      '	INDEX SaleID (SaleID), '+
                      '	INDEX ProcessTimeID (ProcessTimeID), '+
                      '	INDEX ProcResourceId (ProcResourceId), '+
                      '	INDEX ProcessPartId (ProcessPartId) '+
                      '	  ) '+
                      '	  COLLATE="utf8_general_ci" '+
                      '	  ENGINE=MyISAM ;');
*)

sctProcesstimeList.connection :=QryProcesstime.connection;
sctProcesstimeList.SQL.clear;
sctProcesstimeList.SQL.add('TRuncate ' +Tablename+' ; ');
sctProcesstimeList.SQL.add('insert ignore into ' +Tablename+' '+
                      '	(SaleID,SaleLineID,customername,saledate,ProductName,ProductDesc,UnitofMeasureShipped,UOM,Salesconverted,caption,ItemCaption,ProctreetotalQty,ProcessStep,ProcessstepId,Duration,SchdDuration,ProcResourceId,Resource,'+
                      '	 PRDID,ResourceDetail,EmployeeName,EmployeeId,ProcessTimeID,ProcessPartId,TimeStart,TimeEnd,BuildDate,QtyScheduled,QtyBuilt,QtyUsed) '+
                      '	select '+
                      '	S.SaleID, '+
                      '	SL.SaleLineID, '+
                      '	S.customername, '+
                      '	S.saledate, '+
                      '	SL.ProductName, '+
                      '	SL.Product_Description, '+
                      '	SL.UnitofMeasureShipped, '+
                      '	Concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as UOM, '+
                      'S.Converted,'+
                      '	PT.caption, '+
                      ItemCaptionFields + ' as ItemCaption , '+
                      '	PT.totalqty, '+
                      '	PS.Description as ProcessStep, '+
                      '	PS.ID as ProcessStepID, '+
                      '	FormatSecondsTotime((ifnull(PP.Duration,0)+ifnull(PP.SetupDuration,0)+ifnull(PP.BreakdownDuration,0))*PT.totalQty) as Duration, '+
                      '	FormatSecondsTotime(PST.Duration) as SchdDuration, '+
                      '	PR.ProcResourceId, '+
                      '	PR.Description as Resource, '+
                      ' PRD.ID as PRDID,'+
                      '	PRD.Description as ResourceDetail, '+
                      '	E.EmployeeName, '+
                      '	PST.employeeId, '+
                      '	PST.ProcessTimeID , '+
                      '	PST.ProcessPartId , '+
                      '	PST.TimeStart , '+
                      '	DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) TimeEnd , '+
                      '	PPQ.BuildDate , '+
                      '	PPQ.QtyScheduled, '+
                      '	PPQ.QtyBuilt , '+
                      '	PPQ.QtyUsed '+
                      '	from TblSales S '+
                      '	inner join tblsaleslines SL on S.saleId = SL.saleId '+
                      '	inner join tblProcTree PT on PT.masterId = SL.saleLineId and PT.masterType <> "mtProduct" '+
                      '	inner join tblprocesspart PP on PT.proctreeId = PP.proctreeId '+
                      '	inner join tblprocessstep PS on PP.ProcessStepID = PS.ID '+
                      '	inner join tblProcesstime PST on PST.processpartId = PP.ID '+
                      '	Left join tblemployees E on E.EmployeeID = PST.EmployeeId '+
                      '	inner join tblprocresourcedetails PRD on PRD.ID= PST.ResourcedetailsID '+
                      '	inner join tblprocresource PR on PR.ProcResourceId = PRD.ProcResourceId '+
                      '	Left join tblprocesspartqty PPQ  on PST.ProcesstimeID = PPQ.ProcesstimeID and PST.ProcessPartID = PPQ.ProcessPartID '+
                      '	Where  ((PST.TimeStart between ' + Quotedstr(FormatdateTime(mySQLDAtetimeformat, Datefrom)) +' and ' + Quotedstr(FormatdateTime(mySQLDAtetimeformat, DateTo)) +' ) '+
                      '	or (DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) between ' + Quotedstr(FormatdateTime(mySQLDAtetimeformat, Datefrom)) +' and ' + Quotedstr(FormatdateTime(mySQLDAtetimeformat, DateTo)) +' ) '+
                      '	or (PST.TimeStart  < ' + Quotedstr(FormatdateTime(mySQLDAtetimeformat, Datefrom)) +' and DATE_ADD(PST.timeStart,INTERVAL PST.Duration second) > ' + Quotedstr(FormatdateTime(mySQLDAtetimeformat, DateTo)) +' )) '+
                      iif(chkShowFinalised.Checked =False , ' and S.converted ="F" ' , '') +
                      '	Order by S.saleId desc , SL.ProductName, PT.sequenceDown, PST.TimeStart;');
  logtext( sctProcesstimeList.SQL.Text);
  sctProcesstimeList.Execute;

end;
function TfmBOMPlanner.isItemSelected(MsgWhenNoneSelected: String): Boolean;
begin
  REsult := True;
  if curItem = nil then begin
    REsult := False;
    if MsgWhenNoneSelected ='' then MsgWhenNoneSelected := 'Please Choose an Item';
    MessageDlgXP_Vista(MsgWhenNoneSelected, mtWarning, [mbOK], 0);
  end;
end;

procedure TfmBOMPlanner.lblCaptionDblClick(Sender: TObject);
begin
  inherited;
  if devmode then begin
    pnlGrid.visible := not (pnlGrid.visible);
  end;
end;

procedure TfmBOMPlanner.RefreshQuery;
begin
  if not(IsFormshown) then exit;
  ShowDateSelection;
  PlannerWeek.Mode.TimeLineStart := dtStart.Date;
  PlannerWeek.Mode.WeekStart := DayOf(dtStart.DateTime);

  PlannerResWeek.Mode.TimeLineStart := dtStart.Date;
  PlannerResWeek.Mode.WeekStart := DayOf(dtStart.DateTime);


  PlannerMonth.Mode.PeriodStartYear := YearOf(dtStart.DateTime);
  PlannerMonth.Mode.PeriodStartMonth := MonthOf(dtStart.DateTime);
  PlannerMonth.Mode.PeriodStartDay := DayOf(dtStart.DateTime);

  PlannerResMonth.Mode.PeriodStartYear := YearOf(dtStart.DateTime);
  PlannerResMonth.Mode.PeriodStartMonth := MonthOf(dtStart.DateTime);
  PlannerResMonth.Mode.PeriodStartDay := DayOf(dtStart.DateTime);


  if MonthSource.Active     = True then MonthSource.Active     := False;
  if TimeLineSource.Active  = True then TimeLineSource.Active  := False;
  if DaySource.Active       = True then DaySource.Active       := False;

  if ResDaySource.Active      = True then ResDaySource.Active      := False;
  if ResTimeLineSource.Active = True then ResTimeLineSource.Active := False;
  if ResMonthSource.Active    = True then ResMonthSource.Active    := False;
  try
    CloseDb(QryProcesstime);
    InitScript;
    CloseDb(QryEmployees); OpenDb(QryEmployees);
    CloseDb(QryResources); OpenDb(QryResources);
    CloseDb(qryResourceD); OpenDb(qryResourceD);
    OpenDb(QryProcesstime);
  finally
    if MonthSource.Active     = False then MonthSource.Active     := True;
    if TimeLineSource.Active  = False then TimeLineSource.Active  := True;
    if DaySource.Active       = False then DaySource.Active       := True;

    if ResDaySource.Active      = False then ResDaySource.Active      := True;
    if ResTimeLineSource.Active = False then ResTimeLineSource.Active := True;
    if ResMonthSource.Active    = False then ResMonthSource.Active    := True;
  end;


  MonthSource.Month := MonthOfTheYear(dtStart.Date);
  MonthSource.Year := YearOf(dtStart.Date);
  MonthSource.UpdatePlanner;
  plannerMonth.Display.DisplayEnd := DaysInMonth(dtStart.DateTime) + DaysInMonth(IncMonth(dtStart.DateTime,1)); //   2 months

  ResMonthSource.Month := MonthOfTheYear(dtStart.Date);
  ResMonthSource.Year := YearOf(dtStart.Date);
  ResMonthSource.UpdatePlanner;
  plannerResMonth.Display.DisplayEnd := DaysInMonth(dtStart.DateTime) + DaysInMonth(IncMonth(dtStart.DateTime,1)); //   2 months

  Try
    TimeLineSource.EndDate := incmonth(dtStart.Date,1);
    TimeLineSource.StartDate := dtStart.Date;
    TimeLineSource.EndDate := incmonth(dtStart.Date,1);
  Except
    on E:EXception do begin
      if devmode then
        MessageDlgXP_vista('Employee :' + E.Message, mtWarning, [mbOK], 0);
    end;
  End;

  Try
    ResTimeLineSource.EndDate := incmonth(dtStart.Date,1);
    ResTimeLineSource.StartDate := dtStart.Date;
    ResTimeLineSource.EndDate := incmonth(dtStart.Date,1);
  Except
    on E:EXception do begin
      if devmode then
        MessageDlgXP_vista('resource : ' +E.Message, mtWarning, [mbOK], 0);
    end;
  End;

  DaySource.Day := dtStart.Date;
  ResDaySource.Day := dtStart.Date;

  if ((QryEmployees.RecordCount =0) or ((QryEmployees.recordcount =1) and (QryEmployeesEmployeeID.asInteger =0) )) and
       (rgCateogry.ItemIndex=0) and (QryProcesstime.RecordCount >0) then
    TimerMsg(lblMsg , 'Please Allocate Employees to Resources for the Planner to Show the Schedule in "Employee" Category', 10);

end;
procedure TfmBOMPlanner.InitPlanners;
var
  fb:Boolean;
begin
  PlannerWeek.Mode.Plannertype := plTimeLine;
  PlannerMonth.Mode.Plannertype := plMonth;
  PlannerDay.Sidebar.DateTimeFormat   := FormatSettings.ShortDateFormat;
  PlannerWeek.Sidebar.DateTimeFormat  := 'ddd ' +FormatSettings.ShortDateFormat;
  plannerMonth.Sidebar.DateTimeFormat := 'dd-mm';//FormatSettings.ShortDateFormat;

  PlannerResMonth.Mode.Plannertype := plMonth;
  PlannerResMonth.Sidebar.DateTimeFormat := 'dd-mm';//FormatSettings.ShortDateFormat;
  PlannerResWeek.Mode.Plannertype := plTimeLine;
  PlannerResWeek.Sidebar.DateTimeFormat  := 'ddd ' +FormatSettings.ShortDateFormat;
  PlannerResDay.Sidebar.DateTimeFormat   := FormatSettings.ShortDateFormat;


   PlannerWeek.Display.DisplayUnit := 30; // 30 min steps
   PlannerWeek.Display.DisplayEnd := (14 * 48) - 1; // 14 days
   PlannerWeek.Display.DisplayScale := 12;
   PlannerWeek.Display.DisplayText := 2; // only display every second number .. ie hours
   PlannerWeek.Sidebar.Width := 40;
   TimeLineSource.StartDate := Date;
   TimeLineSource.EndDate := incmonth(Date,1);


   PlannerResWeek.Display.DisplayUnit := 30; // 30 min steps
   PlannerResWeek.Display.DisplayEnd := (14 * 48) - 1; // 14 days
   PlannerResWeek.Display.DisplayScale := 12;
   PlannerResWeek.Display.DisplayText := 2; // only display every second number .. ie hours
   PlannerResWeek.Sidebar.Width := 40;
   ResTimeLineSource.StartDate := Date;
   ResTimeLineSource.EndDate := incmonth(Date,1);

   PlannerDay.ShowHint := True;PlannerWeek.ShowHint := True;plannerMonth.ShowHint := True;PlannerResDay.ShowHint := True;PlannerResWeek.ShowHint := True;PlannerResMonth.ShowHint := True;

  fb:= IsSundayWeekend    ;PlannerDay.InactiveDays.Sun := fb; PlannerWeek.InactiveDays.Sun := fb;plannerMonth.InactiveDays.Sun := fb;PlannerResDay.InactiveDays.Sun := fb; PlannerResWeek.InactiveDays.Sun := fb;PlannerResMonth.InactiveDays.Sun := fb;
  fb:= IsMondayWeekend    ;PlannerDay.InactiveDays.Mon := fb; PlannerWeek.InactiveDays.Mon := fb;plannerMonth.InactiveDays.Mon := fb;PlannerResDay.InactiveDays.Mon := fb; PlannerResWeek.InactiveDays.Mon := fb;PlannerResMonth.InactiveDays.Mon := fb;
  fb:= IsTuesdayWeekend   ;PlannerDay.InactiveDays.Tue := fb; PlannerWeek.InactiveDays.Tue := fb;plannerMonth.InactiveDays.Tue := fb;PlannerResDay.InactiveDays.Tue := fb; PlannerResWeek.InactiveDays.Tue := fb;PlannerResMonth.InactiveDays.Tue := fb;
  fb:= IsWednesdayWeekend ;PlannerDay.InactiveDays.Wed := fb; PlannerWeek.InactiveDays.Wed := fb;plannerMonth.InactiveDays.Wed := fb;PlannerResDay.InactiveDays.Wed := fb; PlannerResWeek.InactiveDays.Wed := fb;PlannerResMonth.InactiveDays.Wed := fb;
  fb:= IsthursdayWeekend  ;PlannerDay.InactiveDays.Thu := fb; PlannerWeek.InactiveDays.Thu := fb;plannerMonth.InactiveDays.Thu := fb;PlannerResDay.InactiveDays.Thu := fb; PlannerResWeek.InactiveDays.Thu := fb;PlannerResMonth.InactiveDays.Thu := fb;
  fb:= IsFridayWeekend    ;PlannerDay.InactiveDays.Fri := fb; PlannerWeek.InactiveDays.Fri := fb;plannerMonth.InactiveDays.Fri := fb;PlannerResDay.InactiveDays.Fri := fb; PlannerResWeek.InactiveDays.Fri := fb;PlannerResMonth.InactiveDays.Fri := fb;
  fb:= IsSaturdayWeekend  ;PlannerDay.InactiveDays.Sat := fb; PlannerWeek.InactiveDays.Sat := fb;plannerMonth.InactiveDays.Sat := fb;PlannerResDay.InactiveDays.Sat := fb; PlannerResWeek.InactiveDays.Sat := fb;PlannerResMonth.InactiveDays.Sat := fb;

end;
procedure TfmBOMPlanner.QryEmployeesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //logtext(QryEmployees.SQL.Text);
  MonthSource.NumberOfResources := QryEmployees.RecordCount;
  //WeekSource.NumberOfResources  := QryEmployees.RecordCount;
  TimeLineSource.NumberOfResources  := QryEmployees.RecordCount;
  DaySource.NumberOfResources   := QryEmployees.RecordCount;


  UpdateHeaders(plannerDay);
  UpdateHeaders(plannerWeek);
  UpdateHeaders(plannerMonth);
  Logtext(QryEmployees.SQL.Text);

end;
procedure TfmBOMPlanner.ExecuteUpdateSQL(const SQLValue:String);
begin
  sctDataUpdate.SQL.text := SQLValue;
  sctDataUpdate.Execute;
  Self.Dirty := True;
  Logtext(SQLValue);
end;
procedure TfmBOMPlanner.QryProcesstimeAfterOpen(DataSet: TDataSet);
var
  Option : word;
begin
  inherited;
  if devmode then begin
    TimerMsg(lblMsg , inttostr(QryProcesstime.recordcount), 10);
  end;
  QryProcesstimeTimeStart.Displayformat := FormatSettings.Shortdateformat+' hh:nn:ss AM/PM';
  QryProcesstimeTimeEnd.Displayformat := FormatSettings.Shortdateformat+' hh:nn:ss AM/PM';
  QryProcesstimeBuildDate.Displayformat := FormatSettings.Shortdateformat+' hh:nn:ss AM/PM';
  if ((QryEmployees.recordcount =0) and (QryProcesstime.recordcount >0)) (*or devmode*)  then begin
  Option := 0;
  While (Option <> 102) (*or devmode*) do begin
    Option := MessageDlgXP_Vista('No Employee is Allocated to the Job Schedules.'+NL+
                       'To Have the Employees Allocated For Jobs, You Need to '+NL+
                       ' -> Do the Employee Allocation  before ''Auto Schedule'' and '+NL+
                       ' -> Turn the Preference on To Use the Employee Allocation', mtConfirmation, [], 0 , nil , '' , '' , False , nil , 'Open Employee Allocation,Open Preference Form,Do Not Confirm,Cancel');
         if Option = 100 then OpenERPFormModal('TfmEmpResProcRoster' , 0)
    else if option = 101 then OpenPrefform('Manufacturing', 'chkAutoScheduleBasedonBOMEmpRoster' ,1 ,True, 'Auto Schedule Based on BOM Schedule Roster | Manufacturing')
    else if option = 102 then
    else exit;
    TimerMsg(lblMsg , 'Please Note that Jobs that are already Scheduled before ''Employee Allocation'' will not be Changed. Please ''Unschedule'' and ''Schedule'' it Again to Have it with Employees', 20);
  end;
  end;
end;

procedure TfmBOMPlanner.QryProcesstimeAfterPost(DataSet: TDataSet);
begin
  inherited;
  ExecuteUpdateSQL('update tblprocesstime Set  TimeStart = ' + Quotedstr(FormatDateTime(MySQLDateTimeFormat , QryProcesstimeTimeStart.AsDatetime)) +', '+
                                   ' Duration = ' + inttostr(Secondsbetween(QryProcesstimeTimeStart.asDateTime , QryProcesstimeTimeend.asDatetime)) +',  '+
                                   ' TimeEnd = if (ifnull(TimeEnd,"1899-12-30 00:00:00") ="1899-12-30 00:00:00" , "1899-12-30 00:00:00" , '+Quotedstr(FormatdateTime(mySQLDatetimeFormat ,QryProcesstimeTimeend.asDatetime)) +') ,'+
                                   ' ResourcedetailsID = ' + inttostr(QryProcesstimePRDID.asInteger) +',  '+
                                   ' EmployeeId = ' + inttostr(QryProcesstimeEmployeeId.asInteger) +'  '+
                                   ' where  ProcessTimeID =' + inttostr(QryProcesstimeProcessTimeID.asInteger)+';' );
  ExecuteUpdateSQL('update tblprocresourceschedule PS  '+
                                   ' inner join tblprocesstime PT on PT.ProcessTimeId = PS.ProcesstimeID  '+
                                   ' Set PS.ScheduleDate = date(PT.TimeStart)  '+
                                   ' where PT.ProcessTimeID =' + inttostr(QryProcesstimeProcessTimeID.asInteger)+';' );

  ExecuteUpdateSQL('update tblprocresourceproducts RP  '+
                                   ' inner join  tblprocresourceschedule PS  on RP.ID = PS.ResourceProductID  '+
                                   ' Set RP.ResourceDate = DATE_ADD(DATE(PS.ScheduleDate),INTERVAL 1 Day) '+
                                   ' where PS.ProcessTimeID =' + inttostr(QryProcesstimeProcessTimeID.asInteger)+
                                   ' and RP.ResourceDate <= PS.ScheduleDate ;');
end;

procedure TfmBOMPlanner.QryProcesstimeBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ExecuteUpdateSQL('Delete  tblprocesstime   where  ProcessTimeID =' + inttostr(QryProcesstimeProcessTimeID.asInteger)+';');
end;

procedure TfmBOMPlanner.qryResourceDAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //logtext(qryResourceD.SQL.Text);
  ResDaySource.NumberOfResources   := qryResourceD.RecordCount;
  //ResWeeksource.NumberOfResources  := qryResourceD.RecordCount;
  ResTimeLineSource.NumberOfResources  := qryResourceD.RecordCount;
  ResMonthSource.NumberOfResources := qryResourceD.RecordCount;

  UpdateresHeaders(plannerresDay);
  UpdateresHeaders(PlannerResWeek);
  UpdateresHeaders(PlannerResMonth);
  Logtext(qryResourceD.SQL.Text);
end;

procedure TfmBOMPlanner.QryResourcesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  Logtext(qryResources.SQL.Text);
end;

procedure TfmBOMPlanner.UpdateresHeaders(const planner: TDBPlanner);
begin

  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');


  with qryResourceD do begin
    First;
    while not Eof do begin
      planner.Header.Captions.Add(FieldByName('Resource').AsString+'-' +NL+ FieldByName('ResourceDetail').AsString);
      Next;
    end;
  end;

end;
procedure TfmBOMPlanner.UpdateHeaders(Const planner: TDBPlanner);
begin
  (*planner.Header.Height := 100;
  planner.Header.TextHeight := 100;
  planner.Header.Color := $00FFDDC6;*)
  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');
  (*planner.ItemGap := 0;*)

  with QryEmployees do begin
    First;
    while not Eof do begin
      planner.Header.Captions.Add(FieldByName('EmployeeName').AsString);
      Next;
    end;
  end;
end;
procedure TfmBOMPlanner.Writeguiprefs;
begin
  GuiPrefs.Node['rgPeriod.itemindex'].asInteger := rgPeriod.itemindex;
  GuiPrefs.Node['rgCateogry.itemindex'].asInteger := rgCateogry.itemindex;
  GuiPrefs.Node['pnlGrid.Height'].asInteger     := pnlGrid.Height;

  GuiPrefs.Node['PlannerItemOption.showSaleId'].asBoolean         := fbshowSaleId        	;
  GuiPrefs.Node['PlannerItemOption.CustomerName'].asBoolean       := fbCustomerName      	;
  GuiPrefs.Node['PlannerItemOption.SaleDate'].asBoolean           := fbSaleDate          	;
  GuiPrefs.Node['PlannerItemOption.ShowProductName'].asBoolean   := fbShowProductName   	;
  GuiPrefs.Node['PlannerItemOption.ShowProductDesc'].asBoolean   := fbShowProductDesc   	;
  GuiPrefs.Node['PlannerItemOption.UOM'].asBoolean                := fbUOM               	;
  GuiPrefs.Node['PlannerItemOption.shipped'].asBoolean            := fbshipped           	;

  GuiPrefs.Node['PlannerItemOption.Caption'].asBoolean            := fbCaption           	;
  GuiPrefs.Node['PlannerItemOption.ProcessStep'].asBoolean        := fbProcessStep       	;
  GuiPrefs.Node['PlannerItemOption.Totalduration'].asBoolean      := fbTotalduration     	;
  GuiPrefs.Node['PlannerItemOption.SchdDuration'].asBoolean       := fbSchdDuration      	;
  GuiPrefs.Node['PlannerItemOption.ProcessStatus'].asBoolean      := fbProcessStatus     	;
  GuiPrefs.Node['PlannerItemOption.Resourcename'].asBoolean       := fbResourcename      	;
  GuiPrefs.Node['PlannerItemOption.REsourceDetailName'].asBoolean := fbREsourceDetailName	;
  GuiPrefs.Node['PlannerItemOption.ShowSchdtime'].asBoolean       := fbShowSchdtime      	;
  GuiPrefs.Node['DataGrid.Visible'].asBoolean                     := pnlGrid.visible      ;
  GuiPrefs.Node['Options.ShowFinalised'].asBoolean                := chkShowFinalised.checked    ;

  GuiPrefs.Node['Options.plannerDay.Header.Height'].asInteger     := plannerDay.Header.height;
  GuiPrefs.Node['Options.PlannerWeek.Header.Height'].asInteger    := plannerWeek.Header.height;
  GuiPrefs.Node['Options.plannerMonth.Header.Height'].asInteger   := plannerMonth.Header.height;
  GuiPrefs.Node['Options.plannerResDay.Header.Height'].asInteger  := plannerResDay.Header.height;
  GuiPrefs.Node['Options.plannerResWeek.Header.Height'].asInteger := plannerResWeek.Header.height;
  GuiPrefs.Node['Options.plannerResMonth.Header.Height'].asInteger:= plannerResMonth.Header.height;

  (*  GuiPrefs.Node['plannerDay.HeaderHeight'].asInteger       := plannerDay.Header.height     ;
  GuiPrefs.Node['PlannerWeek.HeaderHeight'].asInteger      := PlannerWeek.Header.height    ;
  GuiPrefs.Node['plannerMonth.HeaderHeight'].asInteger     := plannerMonth.Header.height   ;
  GuiPrefs.Node['plannerResDay.HeaderHeight'].asInteger    := plannerResDay.Header.height  ;
  GuiPrefs.Node['PlannerREsWeek.HeaderHeight'].asInteger   := PlannerREsWeek.Header.height ;
  GuiPrefs.Node['PlannerResMonth.HeaderHeight'].asInteger  := PlannerResMonth.Header.height;*)

end;

function TfmBOMPlanner.GetEmployeeFromPosition        (Const iPosition: integer): integer;begin  Result := 0;  if QryEmployees.Locate('No', iPosition, [loCaseInsensitive]) then Result := QryEmployeesEmployeeID.AsInteger;end;
//function TfmBOMPlanner.GetResourceFromPosition        (Const iPosition: integer): integer;begin  Result := 0;  if QryResources.Locate('No', iPosition, [loCaseInsensitive]) then Result := QryResourcesProcResourceId.AsInteger;end;
function TfmBOMPlanner.GetResourceDetailsFromPosition (Const iPosition: integer): integer;begin  Result := 0;  if qryResourceD.Locate('No', iPosition, [loCaseInsensitive]) then Result := qryResourceDPRDID.AsInteger;end;
function TfmBOMPlanner.GetResourceFromDetailsPosition (Const iPosition: integer): integer;begin  Result := 0;  if qryResourceD.Locate('No', iPosition, [loCaseInsensitive]) then Result := qryResourceDProcResourceId.AsInteger;end;

//function TfmBOMPlanner.GetEmployeePositionFromID        (Const iID: integer): integer;begin  Result := 0;  if QryEmployees.Locate('EmployeeID'    , iID, [loCaseInsensitive]) then Result := QryEmployeesNO.AsInteger;end;
function TfmBOMPlanner.GetResourcePositionFromID        (Const iID: integer): integer;begin  Result := 0;  if QryResources.Locate('ProcResourceId', iID, [loCaseInsensitive]) then Result := QryResourcesNO.AsInteger;end;
//function TfmBOMPlanner.GetResourceDetailsPositionFromID (Const iID: integer): integer;begin  Result := 0;  if qryResourceD.Locate('PRDID'         , iID, [loCaseInsensitive]) then Result := qryResourceDNO.AsInteger;end;

function TfmBOMPlanner.NewItemProperty:TBOMPlannerItem;
begin
  REsult := TBOMPlannerItem.Create
end;

procedure TfmBOMPlanner.plannerDayItemDblClick(Sender: TObject;  Item: TPlannerItem);
begin
  inherited;
  TfmBOMPlannerItemDetails.ShowItemDetails(self, Item);
end;

procedure TfmBOMPlanner.plannerDayItemHint(Sender: TObject; Item: TPlannerItem;
  var Hint: string);
begin
  inherited;
  if StrUtils.RightStr(Hint,2) <> #13#10 then
    Hint := Hint + #13#10;
end;



procedure TfmBOMPlanner.PlannerREsWeekItemPopupPrepare(Sender: TObject;
  PopupMenu: TPopupMenu; Item: TPlannerItem);
begin
  inherited;
  logtext(Item.owner.name +':' +
          inttostr(item.itempos) +' , ' +inttostr(TBOMPlannerItem(Item.ItemObject).EmployeeId )+',' + inttostr(TBOMPlannerItem(Item.ItemObject).PRDID ) );
end;

procedure TfmBOMPlanner.PlannerWeekItemSelect(Sender: TObject;  Item: TPlannerItem);
var
  BOMPlannerItemProperties:TBOMPlannerItem;
begin
  inherited;
  if assigned(Item.ItemObject) then begin
    Logtext(Formatdatetime('dd-mm-yy hh:nn:ss', TBOMPlannerItem(Item.ItemObject).TimeStart) +' to ' +
            Formatdatetime('dd-mm-yy hh:nn:ss', TBOMPlannerItem(Item.ItemObject).TimeEnd));
  end;
end;

procedure TfmBOMPlanner.pnlheaderDblClick(Sender: TObject);
begin
  inherited;
  clog('');
end;

procedure TfmBOMPlanner.OnPlannerItemMoving(Sender: TObject;  Item: TPlannerItem; DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
begin
  inherited;
  //DeltaBegin : number of columns moved , -ive :Move left and +ive :Move right
  //DeltaPos : Number orws moved , -ive :Moveup and +ive :Movedown
  Allow := (DeltaPos=0) or
           ((TBOMPlannerItem(Item.ItemObject).ProcResourceId =  GetResourceFromDetailsPosition(item.itempos +DeltaPos)) and
           (dateof(TBOMPlannerItem(Item.ItemObject).TimeStart) = dateof(TBOMPlannerItem(Item.ItemObject).Timeend) ));
  if Allow then begin
    if DeltaPos <> 0 then begin
      if (Item.owner = plannerResDay) or (Item.owner =  PlannerREsWeek) or (Item.owner =  PlannerResMonth) then begin
        TBOMPlannerItem(Item.ItemObject).PRDID := GetResourceDetailsFromPosition(item.itempos +DeltaPos);
      end else begin
        TBOMPlannerItem(Item.ItemObject).EmployeeId := GetEmployeeFromPosition(item.itempos +DeltaPos);
      end;
    end;
  end;
  //logtext(Item.owner.name +':' +Booleantostr(Allow)+'-> ' +inttostr(item.itempos) +' To ' +inttostr(item.itempos+DeltaBegin+DeltaPos)+',' + inttostr(TBOMPlannerItem(Item.ItemObject).EmployeeId )+',' + inttostr(TBOMPlannerItem(Item.ItemObject).PRDID ) );
  EditDB(QryProcesstime);
end;

procedure TfmBOMPlanner.actPartialInvoiceExecute(Sender: TObject);
begin
  if not isItemSelected then exit;
  self.CommitTransaction;
  try
    Userlock.UnlockAllCurrentInstance;

    OpenERPFormModal('TfmSalesorderInvoice' , 0 , initSalesorderInvoice, False, OnSalesOrderInvoiceCreate);
  finally
    RefreshQuery;
    LockCapacityplanner;
  end;
end;

procedure TfmBOMPlanner.OnSalesOrderInvoiceCreate(Sender:TObject);
begin
  if not(sender is TfmSalesorderInvoice) then exit;

  if TfmSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrder.isinternalOrder  then
    MessageDlgXP_vista('Quantity Selected is now in stock for Sales Order # ' + inttostr(TfmSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrderID)+'.', mtConfirmation, [mbOK], 0)
  else if TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId <> 0 then
        if MessageDlgXP_vista('Invoice #' + inttostr(TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId ) +' is Created. '+
                                'Do you want to see the invoice? ' , mtConfirmation, [mbyes,mbno], 0) = mryes then
            OpenERPForm('TInvoiceGUI' , TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId);
end;
procedure TfmBOMPlanner.initSalesorderInvoice(Sender: TObject);
begin
  if not(Sender is   TfmSalesorderInvoice) then exit;
  TfmSalesorderInvoice(Sender).saleID     := TBOMPlannerItem(curItem.Itemobject).saleId;
  TfmSalesorderInvoice(Sender).SaleLineID := TBOMPlannerItem(curItem.Itemobject).salelineID;
end;

procedure TfmBOMPlanner.actPQAllocationExecute(Sender: TObject);
begin
  inherited;
  if not isItemSelected then exit;

  if TBOMPlannerItem(CurItem.Itemobject).Salesconverted then exit;

  if (TBOMPlannerItem(curItem.Itemobject).SaleId =0) or ( TBOMPlannerItem(curItem.Itemobject).SaleLineId =0) then exit;
  TfmBOMAllocation.DoAllocation(TBOMPlannerItem(curItem.Itemobject).SaleId, TBOMPlannerItem(curItem.Itemobject).SaleLineId, nil);

end;

procedure TfmBOMPlanner.actSaveExecute(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  Dirty := false;
  Self.close;

end;

procedure TfmBOMPlanner.actStowAwayExecute(Sender: TObject);
var
  msg:String;
begin
  inherited;
  if not isItemSelected then exit;

  if TBOMPlannerItem(CurItem.Itemobject).Salesconverted then exit;

  if not TfmStowAway.DoStow(TreeRootIDofPP(TBOMPlannerItem(curItem.Itemobject).ProcessPartId) , msg) then
    MessageDLGXP_Vista(TBOMPlannerItem(curItem.Itemobject).ProductName+   ' Can''t Stow Away :' +Msg, mtWarning, [mbok],0);

end;

procedure TfmBOMPlanner.AfterFormShow;
begin
  inherited;
  RefreshQuery;
end;

procedure TfmBOMPlanner.actallocPickingSlipExecute(Sender: TObject);
var
  strSQL:String;
  Tablename :String;
begin
  inherited;
  if not isItemSelected then exit;

  if TBOMPlannerItem(CurItem.Itemobject).Salesconverted then exit;

  if (TBOMPlannerItem(curItem.Itemobject).SaleId =0) or ( TBOMPlannerItem(curItem.Itemobject).SaleLineId =0) then exit;
  tablename := GetUserTemporaryTableName('BOMPickingslip');
  MakeBOMPickingTable(inttostr(TBOMPlannerItem(curItem.Itemobject).SaleLineId), tablename);

  strSQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, '+
            ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
            ' ~|||~{details}Select * from '+tablename +' order by SeqID ';

  ReportToPrint :=tcdatautils.GetDefaultReport('BOM Picking Slip');
  fbReportSQLSupplied := True;
  fbTemplateUsesNonFormConnection := true;
  try
    PrintTemplateReport(ReportToPrint , StrSQL , False , 1);
  finally
    fbTemplateUsesNonFormConnection := false;
  end;
  //CommonDbLib.DestroyUserTemporaryTable(Tablename);
  TAfterTransList.Inst.AddAfterTransSQL(TERPConnection (MyConnection), 'drop table if exists ' + Tablename + ';');
end;

procedure TfmBOMPlanner.FlagSelectedItems(const status: TProcessPartStatus; SaleIDs:String);
begin
  if SaleIDs ='' then exit;
    ExecuteupdateSQL('update tblsaleslines SL ' +
                     ' inner join tblproctree PT on SL.SaleLineId = PT.masterID and PT.mastertype <> "mtProduct" ' +
                     ' inner join tblprocessPart PP on PP.proctreeID = PT.ProcTreeId ' +
                     ' inner join tblprocesstime PST on PST.ProcessPartId = PP.ID ' +
                     ' Set PST.Status =   '+ Quotedstr(ProcessPartStatusToStr(status)) +
                     ' Where SL.saleId in (' +saleIDs +');'+

                     'update tblsaleslines SL ' +
                     ' inner join tblproctree PT on SL.SaleLineId = PT.masterID and PT.mastertype <> "mtProduct" ' +
                     ' inner join tblprocessPart PP on PP.proctreeID = PT.ProcTreeId ' +
                     ' Set  PP.Status =   (Select ProcessPartStatusNoToStrVal(Min(ProcessPartStatusToNo(Status))) from tblprocesstime PT where PT.ProcessPartId = PP.ID) ' +
                     ' Where SL.saleId in (' +saleIDs +');'
                     );
end;

procedure TfmBOMPlanner.FlagSelectedItems(const status: TProcessPartStatus);
var
  i:Integer;
  st: TStringlist;
begin
  st := TStringlist.Create;
  try
    With CurPlannerResDay do begin
        for i := Items.Count - 1 downto 0  do begin
          if Items.Items[i].selected then begin
            if QryProcesstime.locate('ProcessTimeID' , TBOMPlannerItem(Items.Items[i].Itemobject).ProcessTimeID , []) then begin
                st.Add('update tblprocesstime Set  Status =   '+ Quotedstr(ProcessPartStatusToStr(status)) +
                                             ' where  ProcessTimeID =' + inttostr(QryProcesstimeProcessTimeID.asInteger)+';');
                st.Add('update tblprocesspart PP Set  Status =   (Select ProcessPartStatusNoToStrVal(Min(ProcessPartStatusToNo(Status))) from tblprocesstime PT where PT.ProcessPartId = PP.ID) ' +
                                             ' where  ID =' + inttostr(QryProcesstimeProcesspartID.asInteger)+';');
            end;
          end;
        end;
    end;
  finally
    if st.Count >0 then begin
      logtext(st.Text);
      ExecuteUpdateSQL(st.Text);
    end;
    Freeandnil(st);
  end;

end;
procedure TfmBOMPlanner.actAutoScheduleExecute(Sender: TObject);
var
  Msg:String;
  Count:Integer;
begin
  inherited;
  if Dirty then
    if MessageDlgXP_Vista('This Will Save all Changes. Do You Wish to Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  CommitTransaction;
  try
    if AutoScheduleProduction(msg, count, MyConnection, userlock) then begin
      if count > 0 then begin
        self.CommitTransaction;
        RefreshQuery;
      end;
    end
    else begin
      MessageDlgXP_Vista('Auto Production Scheduling failed with the following message: ' + CRLF + msg,mtWarning,[mbOk],0);
    end;
  finally
    RefreshQuery;
    self.BeginTransaction;
  end;
end;

procedure TfmBOMPlanner.actCancelExecute(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmBOMPlanner.actInvoiceExecute(Sender: TObject);
var
  IdList: TIntegerList;
  i: integer;
  Msg:String;
begin
  inherited;
  try
    FlagSelectedItems(psComplete);

    IdList:= TIntegerList.Create;
    try

    With CurPlannerResDay do begin
        for i := Items.Count - 1 downto 0  do begin
          if Items.Items[i].selected then begin
            if TBOMPlannerItem(Items.Items[i].Itemobject).Salesconverted =False then
              IdList.AddIfNotInList(TBOMPlannerItem(Items.Items[i].Itemobject).SaleId);
          end;
        end;
    end;

    {if the capacity planning has locked the sales record, unlock it }
    for i := 0 to IdList.count-1 do Userlock.unLock('tblsales' ,IdList[i] , '');

    if IdList.Count > 0 then begin
        self.CommitTransaction;
        if DoJobComplete(IdList, false, msg) then begin
          if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
          RefreshQuery;
        end;
    end;
    finally
      IdList.Free;
    end;
  finally
    self.BeginTransaction;
  end;
end;

procedure TfmBOMPlanner.SelectOrUnselect(Sender: TObject);
var
  i:Integer;
begin
  inherited;
    With CurPlannerResDay do begin
        for i := Items.Count - 1 downto 0  do begin
          if Items.Items[i].selected <> (Sender = actSelectAll) then begin
            Items.Items[i].selected := (Sender = actSelectAll);
          end;
        end;
    end;
end;

procedure TfmBOMPlanner.ShowInDayForm(aDate:TDateTime);
begin
  dtStart.date := aDate;
  fbDateSupplied := True;
  rgPeriod.itemindex := PageDay;
end;

procedure TfmBOMPlanner.ShowInWeekForm(aDate:TDateTime);
begin
  dtStart.date := aDate;
  fbDateSupplied := True;
  rgPeriod.itemindex := Pageweek;
end;

procedure TfmBOMPlanner.ShowInMonthForm(aDate: TDateTime);
begin
  rgPeriod.itemindex := Pagemonth;
  dtStart.date := aDate;
  fbDateSupplied := True;
  rgPeriod.itemindex := Pagemonth;

end;
function TfmBOMPlanner.ShowSelectedSales(SaleIDs:String):Boolean;
var
  ds:TERPQuery;
begin
  result:= False;
  if SaleIDs ='' then exit;

  ds := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    ds.SQL.text := 'select ' +
                  ' distinct S.sAleID, S.Saledate, S.CustomerName, Sl.ProductName  ,  ' +
                  ' concat(SL.UnitofMeasureSaleLines ,  "(" , SL.UnitofMeasureMultiplier , ")") as uom  ,  ' +
                  ' SL.UnitofMeasureShipped , if(ifnull(PT.ProcTreeId,0) =0 , " " ,"BOM") Category' +
                  ' from ' +
                  ' tblsales s ' +
                  ' inner join tblsaleslines SL  on s.saleId = sl.saleId ' +
                  ' Left join tblproctree PT on SL.SaleLineId = PT.masterID and PT.mastertype <> "mtProduct" ' +
                  ' Where S.saleId in (' + SaleIDs +' ) and s.converted ="F";' ;
    ds.Open;
    if ds.RecordCount >0 then begin
      result:= True;
      InitMsgParams;
            PopupMsgParams.Msgcaption := 'Confirmation';
            PopupMsgParams.Msgds := ds;
            PopupMsgParams.fieldnames := 'sAleID,Saledate,CustomerName,ProductName,UnitofMeasureShipped,uom,Category';
            PopupMsgParams.displayLabels:= 'Sale #,Sale Date,Customer,Product,Sale Qty,UOM,Category';
            PopupMsgParams.Displaywidths:= '50,80,100,100,50,50,50';
            PopupMsgParams.Custombuttons := 'Convert,Cancel';
            PopupMsgParams.Msg1:=  'Orders Selected to Complete and Convert';
            PopupMsgParams.Msg2 := 'All Scheduled Process(es) of these Order(s) will be Flagged as "Completed" to Convert the Order to "Invoice".';
            PopupMsgParams.MsgColor := Self.Color;
            Result := TfmMessageWithList.MsgDlg = 100;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(ds);
  end;

end;
procedure TfmBOMPlanner.actInvoiceTotOrderExecute(Sender: TObject);
var
  IdList: TIntegerList;
  i: integer;
  Msg:String;
begin
  inherited;
  try

    IdList:= TIntegerList.Create;
    try

    With CurPlannerResDay do begin
        for i := Items.Count - 1 downto 0  do begin
          if Items.Items[i].selected then begin
            if TBOMPlannerItem(Items.Items[i].Itemobject).Salesconverted =False then
              IdList.AddIfNotInList(TBOMPlannerItem(Items.Items[i].Itemobject).SaleId);
          end;
        end;
    end;

    if IdList.count =0 then exit;

    case MessageDlgXP_Vista('All Scheduled Process(es) of the Selected Order(s) will be Flagged as "Completed"'+NL+
                          'to Convert the Order to "Invoice". '+NL+NL+
                          'Do You Wish to Continue?',
                          mtConfirmation, [] , 0, nil , '' , '' , False, nil , 'Yes, No, Show Selected Orders') of
        100:;
        101:Exit;
        102:if not(ShowSelectedSales(Idlist.CommaText)) then exit;
    end;

    FlagSelectedItems(psComplete ,IdList.Commatext );

    {if the capacity planning has locked the sales record, unlock it }
    for i := 0 to IdList.count-1 do Userlock.unLock('tblsales' ,IdList[i] , '');

    if IdList.Count > 0 then begin
        self.CommitTransaction;

        if DoJobComplete(IdList, false, msg) then begin
          if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
          RefreshQuery;
        end;
    end;
    finally
      IdList.Free;
    end;
  finally
    self.BeginTransaction;
  end;

end;

procedure TfmBOMPlanner.actOpenSaleExecute(Sender: TObject);
begin
  inherited;
  if not isItemSelected then exit;
  openERPForm('TSalesOrderGUI' , TBOMPlannerItem(curItem.Itemobject).saleId);

end;

procedure TfmBOMPlanner.actOrderStatusExecute(Sender: TObject);
begin
  inherited;
  if not isItemSelected then exit;
  OpenERpListform('TBOMOrderStatusGUI' , beforeopenBOMOrderStatus )
end;
procedure TfmBOMPlanner.beforeopenBOMOrderStatus(sender:TObject);
begin
  if not(sender is TBOMOrderStatusGUI) then Exit;
  TBOMOrderStatusGUI(Sender).SaleId     := TBOMPlannerItem(curItem.Itemobject).saleID;
  TBOMOrderStatusGUI(Sender).SaleLineId := TBOMPlannerItem(curItem.Itemobject).SaleLineId;
end;

initialization
  RegisterClassOnce(TfmBOMPlanner);

end.

