unit frmProcCapacityPlanning;
{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCapacityPlanningbase, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, DNMPanel, Grids,
  BaseGrid, AdvGrid, ActnList, StdCtrls, wwdbdatetimepicker, FlagListObj,
  AdvGlassButton, AdvGlowButton, wwclearbuttongroup, wwradiogroup,
  //BusObjProcPartSched,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, Shader,
   ProcCapacityPlanningObj, wwcheckbox,
  ImgList, MemDS, ProcessUtils, AdvObj, BaseInputForm,IntegerListObj, DNMAction,
  ProgressDialog, AdvUtil;

type

  TfmProcCapacityPlanning = class(TfmCapacityPlanningbase)
    Grid: TAdvStringGrid;
    FlagasStarted1: TMenuItem;
    FlagasComplete1: TMenuItem;
    FlagasScheduled1: TMenuItem;
    FlagasNotScheduled1: TMenuItem;
    OpenSale1: TMenuItem;
    ProductTree1: TMenuItem;
    CreatePickingSlip1: TMenuItem;
    ProductionWorkSheets1: TMenuItem;
    CompleteandInvoice1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    mnuGoodOrderStatus: TMenuItem;
    FlagasQualityAssurance1: TMenuItem;
    actOrderStatus: TDNMAction;
    OrderStatus1: TMenuItem;
    actRoster: TDNMAction;
    N3: TMenuItem;
    Roster1: TMenuItem;
    actLogTree: TDNMAction;
    actLogTree1: TMenuItem;
    pnlBottom: TDNMPanel;
    Label6: TLabel;
    lblSelcount: TLabel;
    btnSave: TDNMSpeedButton;
    btnAutoSchedule: TDNMSpeedButton;
    btnApply: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    FlagasCompleteandEdit1: TMenuItem;
    actStowAway: TDNMAction;
    StowAways1: TMenuItem;
    actPrintJobDetails: TDNMAction;
    PrintJobDetails1: TMenuItem;
    actPQAllocation: TDNMAction;
    PQAAllocation1: TMenuItem;
    actallocPickingSlip: TDNMAction;
    BinBatchSerialNoPickingSlip1: TMenuItem;
    actPartialInvoice: TDNMAction;
    mnuPartialInvoice: TMenuItem;
    mnuPartialShipments: TMenuItem;
    btnCalcnshowAvailaibityinCapacityPlanner: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

    procedure GridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure GridGetDisplText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    {$ifdef COMPILER_22_UP}
    procedure GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TAsgVAlignment);
    {$else}
    procedure GridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    {$endif}
    procedure GridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure GridDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure GridDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure FormShow(Sender: TObject);
    procedure actScheduledExecute(Sender: TObject);
    procedure actStartExecute(Sender: TObject);
    procedure actCompleteExecute(Sender: TObject);
    procedure actNotScheduledExecute(Sender: TObject);
    procedure actOpenSaleExecute(Sender: TObject);
    procedure popCustomiseGridPopup(Sender: TObject);
    procedure actProductTreeExecute(Sender: TObject);
    procedure actAutoScheduleExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actCreatePickingSlipExecute(Sender: TObject);
    procedure actPrintWorkSheetsExecute(Sender: TObject);
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GridCellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: String; var Valid: Boolean);
    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actInvoiceExecute(Sender: TObject);
    procedure GridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GridRowDisjunctSelect(Sender: TObject; ARow: Integer;
      AState: Boolean; var Allow: Boolean);
    procedure GridRowDisjunctSelected(Sender: TObject; ARow: Integer);
    procedure GridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure mnuGoodOrderStatusClick(Sender: TObject);
    procedure actQualityAssuranceExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actOrderStatusExecute(Sender: TObject);
    procedure actRosterUpdate(Sender: TObject);
    procedure actRosterExecute(Sender: TObject);
    procedure actLogTreeExecute(Sender: TObject);
    procedure FlagasCompleteandEdit1Click(Sender: TObject);
    procedure actStowAwayExecute(Sender: TObject);
    procedure actPrintJobDetailsExecute(Sender: TObject);
    procedure actPQAllocationExecute(Sender: TObject);
    procedure actallocPickingSlipExecute(Sender: TObject);
    procedure actPartialInvoiceExecute(Sender: TObject);
    procedure mnuPartialShipmentsClick(Sender: TObject);
    procedure btnCalcnshowAvailaibityinCapacityPlannerClick(Sender: TObject);
  private
    //SchedList: TSchedList;
    SelectedRow: integer;
    SelectedCol: integer;
    MouseDownX,
    MouseDownY: integer;
    DraggingCellWidth: boolean;
    DraggingCellCol: integer;
    gridrow :Integer;
    ProcItemstoReschedule :String;
    Hiddencolumns:Integer;


    procedure LoadGridCapacityHeaders;
    function ColData: integer;
    procedure ClearGrid;
    function RowRec: TProcItem; overload;
    function RootRowRec: TProcItem;
    function RowRec(const aRow: integer): TProcItem; overload;
    procedure Reschedule(aRowRec: TProcItem; OldDate, NewDate: TDateTime; Duration: double);


    procedure FlagSelectedRows(const status: TProcessPartStatus);
    function StatusToString(const Status: TProcessPartStatus): String;
    procedure BeforeShowSaleProcessList(Sender: TObject);
    procedure BeforeShowSalesPurchaseOrderList(Sender: TObject);
    function GoodsOnOrderStatusColumSelected: Boolean;
    procedure RestorecolWidthfromPref;
    Procedure RefreshCount;
    Procedure LogEvent(IdList:TIntegerList;EventDesc:String);
    procedure beforeopenBOMOrderStatus(sender: TObject);
    procedure RosterIt(timeStart: TDateTime; ProcstepID: Integer;
      Duration: double);
    procedure SelectRelatedRows(ProcTreeId,parentID:Integer; Movingforward:Boolean; OldDate, NewDate:TDateTime);
    function columindex(const dt: TDateTime): Integer;
    procedure OpenTree(aTreeRootId, aSaleID: Integer);
    procedure initSalesorderInvoice(Sender: TObject);
    procedure beforeshowsalesOrderInvoicesGUI(Sender: TObject);
    procedure OnSalesOrderInvoiceCreate(Sender:TObject);
    procedure RefreshPlanner;
    procedure CheckCalcnshowAvailaibityinCapacityPlanner;
  Protected
    procedure SetGridDetail;Override;
    procedure InitialiseForm;Override;
    procedure WriteGuiPrefs;override;
    procedure Readguiprefs;override;
    procedure LockCapacityplanner;override;
  public
    procedure LoadGrid;Override;
  end;

implementation

uses
  CommonDbLib, DNMExceptions, FastFuncs, CommonLib,
  frmProcTreeEdit, TreeFrame, VirtualTrees, tcConst, BusObjProcPrefs,
  frmProcCapacityPlanningPick, frmProcCapacityPlanningWork, MySQLConst,
  frmProcCapacityPlanDurationEdit, ProcessDataUtils, BusObjAudit, BusObjSales,
  CommonFormLib, SaleProcessList, SalesPurchaseOrderList, ManufactureGuiLib , dateutils,
  frmMessagePanel, BOMOrderStatus,  frmMessageWithList, frmMessageBase,
  frmStowAway, frmBOMAllocation, ProductQtyLib, tcDataUtils, frmSalesorderInvoice, salesOrderInvoices, AppEnvironment,
  DbSharedObjectsObj, ManufactureLib, TempTableUtils, BOMLib, LogLib;

{$R *.dfm}

const
//  PeriodsToDisplay = 14;
  RowDate = 0;
  RowTitle = 3;
  RowSubTitle = 4;
  RowOverAllocated = 3;
  RowCapacity = 1;
  RowAvailibility = 2;

  FixedCols = 11;
  ColSaleRef = 0;
  ColSaleCust = 1;
  ColSaleDueDate = 2;
  ColSaleLineProduct = 3;
  ColSaleLineQty = 4;
  ColTreeCaption = 5;
  ColTreeQty = 6;
  ColStepItem = 7;
  ColStepDuration = 8;
  ColStepStatus = 9;
  colGoodsOnOrderStatus=10;

{ TfmProcResourceAlloc }

procedure TfmProcCapacityPlanning.FormCreate(Sender: TObject);
begin
  inherited;
  mnuPartialInvoice.visible := not(Appenv.CompanyPrefs.EnableBoinBOMsalesOrder);
  mnuPartialShipments.visible := not(Appenv.CompanyPrefs.EnableBoinBOMsalesOrder);

  Hiddencolumns:=0;
  DraggingCellWidth:= false;
  DraggingCellCol:= -1;
  //SchedList:= TSchedList.Create;
  //SchedList.Connection:= MyConnection;
  Grid.DateTimePicker.Format:= 'dd/MM/yy';
  InitialiseForm;
  GuiPrefs.Active := True;
  Readguiprefs;
  UserFilterOptions;
  //RefreshPlanner;
end;
Procedure TfmProcCapacityPlanning.RefreshPlanner;
begin
  LoadGrid;
  RestorecolWidthfromPref;
  btnfirstpage.hint := 'This will Refresh the List to show from the Very first ''Scheduled'' or ''Started'' Process to ' +inttostr(ProcPrefs.CapacityPlanningWeeksToShow) +' Weeks' +NL;
  btnfirstpage.showHint := True;
end;
procedure TfmProcCapacityPlanning.InitialiseForm;
begin
  if FlagList.CheckFlag(Flg_Initialising) then exit;
  FlagList.SetFlag(Flg_Initialising);
  try
    ResourceItemIndex:= 0;
    ProcessItemIndex:= 0;


    Grid.FixedCols:= FixedCols;
    Grid.Cells[Grid.FixedCols-1,RowCapacity]:= 'Capacity';
    Grid.Cells[Grid.FixedCols-1,RowAvailibility]:= 'Available';
    Grid.Cells[Grid.FixedCols-1,RowOverAllocated]:= 'Over Allocated';


    Grid.Cells[ColSaleRef,RowTitle]:= 'Sales Order';
    Grid.Cells[ColSaleRef,RowSubTitle]:= 'Ref';
    Grid.ColWidths[ColSaleRef]:= 50;
    Grid.Cells[ColSaleCust,RowSubTitle]:= 'Customer';
    Grid.ColWidths[ColSaleCust]:= 100;
    Grid.Cells[ColSaleDueDate,RowSubTitle]:= 'Ship Date';
    Grid.Cells[ColSaleLineProduct,RowSubTitle]:= 'Product';
    Grid.ColWidths[ColSaleLineProduct]:= 80;
    Grid.Cells[ColSaleLineQty,RowSubTitle]:= 'Qty';
    Grid.ColWidths[ColSaleLineQty]:= 50;

    Grid.Cells[ColTreeCaption,RowTitle]:= 'Tree Item';
    Grid.Cells[ColTreeCaption,RowSubTitle]:= 'Item';
    Grid.ColWidths[ColTreeCaption]:= 80;
    Grid.Cells[ColTreeQty,RowSubTitle]:= 'Qty';
    Grid.ColWidths[ColTreeQty]:= 50;

    Grid.Cells[ColStepItem,RowTitle]:= 'Process';
    Grid.Cells[ColStepItem,RowSubTitle]:= 'Desc';
    Grid.ColWidths[ColStepItem]:= 80;
    Grid.Cells[ColStepDuration,RowSubTitle]:= 'Duration';
    Grid.ColWidths[ColStepDuration]:= 75;
    Grid.Cells[ColStepStatus,RowSubTitle]:= 'Status';
    Grid.ColWidths[ColStepStatus]:= 70;
    Grid.Cells[colGoodsOnOrderStatus,RowSubTitle]:= 'Goods on Order';
    Grid.ColWidths[colGoodsOnOrderStatus]:= 90;
   inherited;
  finally
    FlagList.ClearFlag(Flg_Initialising);
  end;
end;



procedure TfmProcCapacityPlanning.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPrefs;
  inherited;
  Action:= caFree;
  Userlock.unLock(Self.Caption);
end;

procedure TfmProcCapacityPlanning.FormDestroy(Sender: TObject);
begin
  ClearGrid;
  ClearProcessList;
  //SchedList.Free;
  inherited;
end;

procedure TfmProcCapacityPlanning.FormKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  inherited;
  if (ssctrl in Shift) and (Chr(Key) = 'A') then begin
    Grid.SelectRows(Grid.FixedRows , Grid.AllRowCount -1);
  end;
end;
procedure TfmProcCapacityPlanning.CheckCalcnshowAvailaibityinCapacityPlanner;
begin
  if AppEnv.Employee.CalcnshowAvailaibityinCapacityPlanner then
    btnCalcnshowAvailaibityinCapacityPlanner.caption := 'Do Not Calculate and Show Availaibity'
  else btnCalcnshowAvailaibityinCapacityPlanner.caption := 'Calculate and Show Availaibity';
end;
procedure TfmProcCapacityPlanning.FormShow(Sender: TObject);
begin
  CheckCalcnshowAvailaibityinCapacityPlanner;

  actLogTree.Visible := Devmode;
  DisableForm;
  try
    try
      inherited;
      RefreshPlanner;
      Userlock.Enabled := True;
      LockCapacityplanner;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
    lblSelcount.Caption :=  'Sales Selected : 0'
  finally
    fbformshown := true;
    EnableForm;
  end;
end;



procedure TfmProcCapacityPlanning.LoadGrid;
var
  x: integer;
  dt: TDateTime;
  firstRow: boolean;
begin
  if FlagList.CheckFlag(Flg_GridLoading) then exit;
  FlagList.SetFlag(Flg_GridLoading);
  try
    Grid.ClearRowSelect;
    Grid.ColCount:= Grid.FixedCols + PeriodsToDisplay;
    dt:= edtDateFrom.DateTime;

    //SchedList.PopulateForDateRange(Trunc(DateFrom), Trunc(DateTo));
    //SchedList.LogList;

    for x:= ColData to Grid.AllColCount -1 do begin

//      Grid.ColWidths[x]:= 55;
      Grid.Objects[x,0]:= TObject(Trunc(dt));

      dt:= dt + 1;
      if not ShowWeekends then begin
        while DayOfWeek(dt) in [1,7] do
          dt:= dt + 1;
      end;
    end;
    LoadGridCapacityHeaders;
    ClearGrid;
    firstRow:= true;

    if cboCustomers.ItemIndex > 0 then
      RowList.LoadList( DateFrom, DateTo, SelectedProcessStepIDList, cboCustomers.Text,SaleIdTofilter, fiUserFilterOption=101)
    else
      RowList.LoadList(DateFrom, DateTo, SelectedProcessStepIDList , '' , SaleIdTofilter , fiUserFilterOption=101);
    if fiUserFilterOption=101 then TimerMsg(lblMsg , 'You have ''Cancelled'' the Selection options. ' + trim(TitleLabel.caption) + ' Form is loaded empty. Please make selections and ''Refresh''.', 20);
    fiUserFilterOption :=0;
    grid.hint :=RowList.Gridhint+NL;
    grid.ShowHint := True;
    if (not chkShowFinalised.Checked) then begin
      x:= 0;
      while x < RowList.Count do begin
        if (RowList[x].ProcTreeComplete) or (RowList[x].ProcessStatus = psComplete)  then
          RowList.delete(x)
        else
          Inc(x);
      end;
    end;
    //LoadGridOverallocated;
    for x:= 0 to RowList.Count -1 do begin
//      if (not chkShowFinalised.Checked) and (RowList[x].ProcTreeComplete) then
//        continue;
      if not firstRow then Grid.RowCount:= Grid.RowCount + 1
      else firstRow:= false;
      {Sale}
      Grid.Cells[ColSaleRef, Grid.RowCount -1]:= RowList[x].SaleDocNumber;

      Grid.Cells[ColSaleCust, Grid.RowCount -1]:= RowList[x].SaleCustomerName;
      Grid.Cells[ColSaleDueDate, Grid.RowCount -1]:= FormatDateTime('dd/mm/yy',RowList[x].SaleLineShipDate);
      {Sale Line}
      Grid.Cells[ColSaleLineProduct, Grid.RowCount -1]:= RowList[x].SaleLineProductName;
      Grid.Cells[ColSaleLineQty, Grid.RowCount -1]:= FloatToStr(RowList[x].SaleLineQuantity);
      {Tree Node}
      Grid.Cells[ColTreeCaption, Grid.RowCount -1]:= RowList[x].ProcTreeCaption;
      Grid.Cells[ColTreeQty, Grid.RowCount -1]:= FloatToStr(RowList[x].ProcTreeTotalQty);
      {Process Part}
      Grid.Cells[ColStepItem, Grid.RowCount -1]:= RowList[x].ProcessDesc;
      Grid.Cells[ColStepStatus, Grid.RowCount -1]:= ProcessPartStatusToStr(RowList[x].ProcessStatus);
      Grid.Cells[colGoodsOnOrderStatus, Grid.RowCount -1]:= RowList[x].GoodsOnOrderstatus;
    end;
    Grid.Refresh;
  finally
    FlagList.ClearFlag(Flg_GridLoading);
  end;
end;


procedure TfmProcCapacityPlanning.LoadGridCapacityHeaders;
var
  x: integer;
  dt: TDateTime;
  aCapacity, aAvailable, aOverallocated: double;
  SchedList: TSchedList;
begin
  try
    if not(AppEnv.Employee.CalcnshowAvailaibityinCapacityPlanner) then begin
      for x:= (*ColData*)0 to Grid.AllColCount -1 do begin
        dt:= Integer(Grid.Objects[x,0]);
        if dt > 0 then begin
          if not(AppEnv.Employee.CalcnshowAvailaibityinCapacityPlanner) then begin
            Grid.Cells[x,RowCapacity]:= 'Not';
            Grid.Cells[x,RowAvailibility]:= 'Calculated';
            Grid.Cells[x,RowOverAllocated]:='';
          end else begin
            Grid.Cells[x,RowCapacity]:= 'Not';
            Grid.Cells[x,RowAvailibility]:= 'Calculated';
            Grid.Cells[x,RowOverAllocated]:='DevMode';
          end;
        end;
      end;
      Exit;
    end;

    SchedList:= TSchedList.Create;
    try
      SchedList.Connection:= MyConnection;
      SchedList.PopulateForDateRange(Trunc(DateFrom), Trunc(DateTo));
      //SchedList.LogList;
      for x:= (*ColData*)0 to Grid.AllColCount -1 do begin
        dt:= Integer(Grid.Objects[x,0]);
        if dt > 0 then begin
          aCapacity:= 0;
          aAvailable:= 0;
          aOverallocated:=0;
          SchedList.SummaryForDate(dt,SelectedResourceIDList,aCapacity,aAvailable, aOverallocated);
    //      Grid.Floats[x,RowCapacity]:= aCapacity;
    //      Grid.Floats[x,RowAvailibility]:= aAvailable;
          Grid.Cells[x,RowCapacity]:= ProcTimeToStr(aCapacity);
          Grid.Cells[x,RowAvailibility]:= ProcTimeToStr(aAvailable);
          if round(aOverallocated,2)>0 then Grid.Cells[x,RowOverAllocated]:= ProcTimeToStr(aOverallocated ) else Grid.Cells[x,RowOverAllocated]:= '';
        end;
      end;
    finally
      SchedList.Free;
    end;
  finally
    Grid.REfresh;
  end;
end;




procedure TfmProcCapacityPlanning.LockCapacityplanner;
begin
  inherited;
  if Accesslevel >= 5 then begin
        btnAutoSchedule.enabled := False;
        btnApply.enabled := False;
        btnSave.enabled := False;
  end;
end;

Function TfmProcCapacityPlanning.GoodsOnOrderStatusColumSelected:Boolean;
begin
  Result := False;
 case grpGridDetail.ItemIndex of
    0: begin
         Result := Grid.Cells[Grid.col+7, Grid.Fixedrows-1] ='Goods on Order';
       end;
    1: begin
         Result := Grid.Cells[Grid.col+5, Grid.Fixedrows-1] ='Goods on Order';
       end;
    2: begin
         Result := Grid.Cells[Grid.col, Grid.Fixedrows-1] ='Goods on Order';
       end;
  end;
end;
procedure TfmProcCapacityPlanning.SetGridDetail;
begin
  Hiddencolumns:=0;
  case grpGridDetail.ItemIndex of
    0: begin
         Grid.UnHideColumnsAll;
         Grid.SplitAllCells;
         Grid.HideColumns(0,6);
         Hiddencolumns:= 7;
         Grid.FixedCols:= 4;
         Grid.MergeCells(0,RowDate,Grid.FixedCols-1,3);
         Grid.MergeCells(0,RowTitle,2,1);
       end;
    1: begin
         Grid.UnHideColumnsAll;
         Grid.SplitAllCells;
         Grid.HideColumns(0,4);
         Hiddencolumns:= 5;
         Grid.FixedCols:= 6;
         Grid.MergeCells(0,RowDate,Grid.FixedCols-1,3);
         Grid.MergeCells(0,RowTitle,2,1);
         Grid.MergeCells(2,RowTitle,2,1);
       end;
    2: begin
         Grid.UnHideColumnsAll;
         Grid.SplitAllCells;
         Grid.FixedCols:= FixedCols;
         Grid.MergeCells(0,RowDate,Grid.FixedCols-1,3);
         Grid.MergeCells(0,RowTitle,5,1);
         Grid.MergeCells(5,RowTitle,2,1);
         Grid.MergeCells(7,RowTitle,2,1);
       end;
  end;
end;

function TfmProcCapacityPlanning.ColData: integer;
begin
  result:= Grid.FixedCols + (FixedCols - Grid.FixedCols);

end;

procedure TfmProcCapacityPlanning.ClearGrid;
var x: integer;
begin
  { clear the grid }
  for x:= 0 to Grid.RowCount -1 do begin
    Grid.Objects[0,x].Free;
    Grid.Objects[0,x]:= nil;
  end;
  Grid.RowCount:= Grid.FixedRows + 1;
  Grid.ClearRows(Grid.RowCount-1, 1);
end;

procedure TfmProcCapacityPlanning.GridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit:= (self.AccessLevel < 5) and
            (ACol > colGoodsOnOrderStatus) and
            Assigned(RowRec(aRow)) and
            (RowRec(aRow).ProcessStatus <> psComplete);
end;

procedure TfmProcCapacityPlanning.GridGetDisplText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
  Duration: double;
begin
  inherited;
  if FlagList.CheckFlag(Flg_GetDisplayText) then
    exit;
  FlagList.SetFlag(Flg_GetDisplayText);
  try
    case ARow of
      RowDate:
        begin
          if (ACol >= Grid.FixedCols -1) then begin
            if Integer(Grid.Objects[aCol,0]) > 0 then
              Value:= FormatDateTime('ddd dd/mm',Integer(Grid.Objects[aCol,0]))
            else
              Value:= '';
          end;
        end;
      RowCapacity: ;
      RowAvailibility: ;
      else if (ARow >= Grid.FixedRows) then begin
        case aCol of
          colGoodsOnOrderStatus :
            if Assigned(RowRec(aRow)) then begin
                Value:= RowRec(aRow).GoodsOnOrderStatus;
            end else Value:= '';
          ColStepStatus:
            if Assigned(RowRec(aRow)) then begin
              if RowRec(aRow).ProcTreeComplete then
                Value:= 'Finalised'
              else
                Value:= ProcessPartStatusToUserStr(RowRec(aRow).ProcessStatus);
            end
            else
              Value:= '';
          ColStepDuration:
            if Assigned(RowRec(aRow)) then
              Value:= ProcTimeToStr(RowRec(aRow).ProcessDuration) +
                ' [' + ProcTimeToStr(RowRec(aRow).ProcTimeList.TotalUnScheduled) + ']';
          else begin
            if (aCol >= ColData) then begin
              if Assigned(RowRec(aRow)) then begin
                Duration:= RowRec(aRow).ProcTimeList.SchedTimeForDate(Integer(Grid.Objects[aCol,0]));
                if Duration <> 0 then
                  Value:= ProcTimeToStr(Duration)
                else
                  Value:= '';
              end
              else
                Value:= '';
            end;
          end;
        end;
      end;
    end;
  finally
    FlagList.ClearFlag(Flg_GetDisplayText);
  end;
end;

{$ifdef COMPILER_22_UP}
procedure TfmProcCapacityPlanning.GridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TAsgVAlignment);
{$else}
procedure TfmProcCapacityPlanning.GridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
{$endif}
begin
  inherited;
  if (ACol >= ColData) then
    HAlign:= taCenter
  else if ((ACol = ColSaleLineQty) or (ACol = ColTreeQty) or (ACol = ColStepDuration))
    and (aRow >= RowSubTitle) then
    HAlign:= taCenter;
end;

procedure TfmProcCapacityPlanning.GridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  inherited;
  if (ACol >= ColData) then begin
    if IsWeekendday(DayOftheWeek(Integer(Grid.Objects[aCol,0]))) then
      ABrush.Color:= clYellow;
    if Integer(Grid.Objects[aCol,0]) = Date then
      ABrush.Color:= clMoneyGreen;

    if Assigned(RowRec(aRow)) and RowRec(aRow).ProcessOverdue then
      AFont.Color:= clRed;

    if (Grid.Cells[acol,RowOverAllocated] <> '') and (Arow =RowOverAllocated) then
      ABrush.Color:= clTeal;

  end;
end;

procedure TfmProcCapacityPlanning.GridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow, ARealCol: integer;
begin
  inherited;
  MouseDownX:= x;
  MouseDownY:= y;
  Grid.MouseToCell(x,y,ACol,ARow);
  if (ACol < 0) or (ARow < 0) then
    exit;
  ARealCol:= Grid.RealColIndex(aCol);
  if Button = mbLeft then begin
    if (ARow >= Grid.FixedRows) and ((ARealCol = ColStepDuration) or
      ((ARealCol >= ColData) and (Grid.Cells[aRealCol, aRow] <> ''))) then begin
      SelectedRow:= aRow;
      SelectedCol:= aRealCol;
      if (Button = mbLeft) and (self.AccessLevel < 5) and
        (RowRec(aRow).ProcessStatus <> psComplete) then begin
        Grid.BeginDrag(false)
      end;
    end;
  end
  else if Button = mbRight then begin
//    Grid.ClearRowSelect;
    Grid.FocusCell(aCol,aRow);
    Grid.SelectRows(aRow,1);
    SelectedRow:= aRow;
    SelectedCol:= aRealCol;
  end;
end;

procedure TfmProcCapacityPlanning.GridDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  ACol, ARow: integer;
begin
  inherited;
  Grid.MouseToCell(x,y,ACol,ARow);
  if Assigned(RowRec(aRow)) and (not RowRec(aRow).ProcTreeComplete) then begin
    ACol:= Grid.RealColIndex(aCol);
    if (ARow >= Grid.FixedRows) and
      ((ACol >= ColData) or (aCol = ColStepDuration)) then
      Accept:= true
    else
      Accept:= false;
  end
  else
    Accept:= false;
end;

procedure TfmProcCapacityPlanning.GridDblClickCell(Sender: TObject; ARow,ACol: Integer);
var
  col:Integer;
  Qry :TERPQuery;
  dt:TDateTime;
  tablename :String;
begin
  inherited;
  col:= acol+Hiddencolumns;
  gridrow := arow;
  if (gridrow =RowOverAllocated) or (gridrow =RowCapacity ) or (gridrow =RowAvailibility )  then begin
    //if grid.Cells[col,RowOverAllocated] <> '' then  begin
      Tablename := (*CommonDbLib.GetUserTemporaryTableName(*)UniqueTableName('ResCapacity');
      Qry := DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        dt:=    Integer(Grid.Objects[Col,0]);
        Qry.SQL.clear;
        Qry.SQL.Add('Drop table if exists '+Tablename +'1;');
        Qry.SQL.add('Create table ' + tablename +'1');
        Qry.SQL.Add('Select RDID,RDDescription,   ProcessStepId , Description , ');
        (*Qry.SQL.Add('convert(SEC_TO_TIME(Allocated) , char) as Allocated , ');
        Qry.SQL.Add('convert(SEC_TO_TIME(CapacityHoursDay) , char) as CapacityHoursDay , ');
        Qry.SQL.Add('convert(SEC_TO_TIME(if(allocated>CapacityHoursDay , allocated-CapacityHoursDay  , NULL)) , char) as OverAllocated ');*)

        Qry.SQL.Add('Allocated as Allocated , ');
        Qry.SQL.Add('CapacityHoursDay as CapacityHoursDay , ');
        Qry.SQL.Add('if(allocated>CapacityHoursDay , allocated-CapacityHoursDay  , NULL) as OverAllocated ');
        Qry.SQL.Add('From (SELECT  RD.ID RDID, RD.Description RDDescription,   ');
        Qry.SQL.Add('      Ps.ID ProcessStepId   , PS.description, ');
        Qry.SQL.Add('      (Select Sum(PPt.duration) ' +
                                    ' from tblProcessTime 				PPT  ' +
                                    ' inner join tblProcessPart PP on   PPT.ProcessPartId 	= PP.ID AND PP.IsTemplate = "F" ' +
                                    ' and PPT.TimeStart >= ' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'  AND PPT.TimeStart < ' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(incday(dt)))) +
                                    ' Where  PP.ProcessStepId 	= PS.ID ' +
                                    ' and  PPt.ResourcedetailsID = RD.ID ) allocated,');
        Qry.SQL.Add('       (if(DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) =1 and PRD.Sunday   = "T" , PRD.SundayCapacityHoursDay    ,');
        Qry.SQL.Add('       if(DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) =2 and PRD.Monday   = "T" , PRD.MondayCapacityHoursDay    ,');
        Qry.SQL.Add('       if(DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) =3 and PRD.TuesDay  = "T" , PRD.TuesdayCapacityHoursDay   ,');
        Qry.SQL.Add('       if(DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) =4 and PRD.Wednesday= "T" , PRD.WednesdayCapacityHoursDay ,');
        Qry.SQL.Add('       if(DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) =5 and PRD.Thursday = "T" , PRD.ThursdayCapacityHoursDay  ,');
        Qry.SQL.Add('       if(DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) =6 and PRD.Friday   = "T" , PRD.FridayCapacityHoursDay    ,');
        Qry.SQL.Add('       if(DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) =7 and PRD.Saturday = "T" , PRD.SaturdayCapacityHoursDay  ,0)))))))) CapacityHoursDay');
        (*Qry.SQL.Add('       From tblsaleslines SL');
        Qry.SQL.Add('       inner join tblproctree PT on SL.saleLineId = PT.masterId and PT.masterType <> "ptProduct"');
        Qry.SQL.Add('       inner join tblProcessPart PP on PT.proctreeId = PP.proctreeId');
        Qry.SQL.Add('       Left  join tblProcessTime 				PPT on PPT.ProcessPartId 	= PP.ID AND PP.IsTemplate = "F" ');
        Qry.SQL.Add('       and PPT.TimeStart >= ' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'  AND PPT.TimeStart < ' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(incday(dt)))) +' ');
        Qry.SQL.Add('       inner join tblProcessStep				PS	 on  PP.ProcessStepId 	= PS.ID');
        Qry.SQL.Add('       inner join tblProcResourceProcess	RP	 on rp.ProcessStepId 	= ps.Id');
        Qry.SQL.Add('       inner join tblProcResource				PR	 on RP.ProcResourceId 	= PR.ProcResourceId');
        Qry.SQL.Add('       inner join tblProcResourceDays 		PRD on PRD.ProcResourceID 	= PR.ProcResourceId');*)

        Qry.SQL.Add('       From tblProcessStep				PS	 ');
        Qry.SQL.Add('       inner join tblProcResourceProcess	RP	 on rp.ProcessStepId 	= ps.Id');
        Qry.SQL.Add('       inner join tblProcResource				PR	 on RP.ProcResourceId 	= PR.ProcResourceId');
        Qry.SQL.Add('       inner join tblProcResourceDays 		PRD on PRD.ProcResourceID 	= PR.ProcResourceId');
        Qry.SQL.Add('       left join tblprocresourcedetails RD on RD.ProcResourceId = PR.ProcResourceId');
        Qry.SQL.Add('       Where PR.ProcResourceId in (' + SelectedResourceIDList.CommaText +')');
        Qry.SQL.Add('       group by Ps.ID ,RD.ID  ) aaa;');

        Qry.SQL.Add('Drop table if exists '+Tablename +'2;');
        Qry.SQL.add('Create table ' + tablename +'2');
        Qry.SQL.add('Select RDID, RDDescription,  ProcessStepId ,Description , Sum(employeerostered) as employeerostered from (   select');
        Qry.SQL.add('RD.ID RDID, RD.Description RDDescription,Ps.ID ProcessStepId,');
        Qry.SQL.add('Ps.Description,');
        Qry.SQL.add('	TIME_TO_SEC(	TIMEDIFF(ER.timeto,ER.timefrom) ) employeerostered');
        Qry.SQL.add('from tblempresprocschedule ER inner join tblprocresourcedetails RD on RD.ID = ER.ResourceDetailId');
        Qry.SQL.add('inner join tblprocessstep Ps on Ps.ID =ER.processStepId');
        Qry.SQL.add('Where ER.WeekDayNo = DAYOFWEEK(' + Quotedstr(formatDateTime(MySQLDateTimeformat , Dateof(dt))) +'   ) and ER.ResourceID in (' + SelectedResourceIDList.CommaText +'))  aaa ');
        Qry.SQL.add('group by RDID, ProcessStepId ;');

        Qry.SQL.Add('Drop table if exists '+Tablename +';');
        Qry.SQL.add('Create table ' + tablename );
        Qry.SQL.add('Select Distinct RDID ,RDDescription ,  ProcessStepId , Description from ' + tablename +'1 union ' +
                    'Select Distinct RDID ,RDDescription , ProcessStepId , Description from ' + tablename +'2;');
        Qry.SQL.add('Alter table ' + tablename +' add column Allocated varchar(255),  add column CapacityHoursDay varchar(255),  add column OverAllocated varchar(255), add column employeerostered varchar(255);' );

        Qry.SQL.add( 'update '+Tablename +' T '+
                        ' Left join '+Tablename +'1 as T1 on T.ProcessStepId = T1.ProcessStepId and T.RDID = T1.RDID  SET '+
                        ' T.Allocated         = convert(SEC_TO_TIME(T1.Allocated ) , char), '+
                        ' T.CapacityHoursDay  = convert(SEC_TO_TIME(T1.CapacityHoursDay ) , char), '+
                        ' T.OverAllocated     = convert(SEC_TO_TIME(T1.OverAllocated ) , char);');

        Qry.SQL.add( 'update '+Tablename +' T '+
                        ' Left join '+Tablename +'2 as T1 on T.ProcessStepId = T1.ProcessStepId and T.RDID = T1.RDID  '+
                        ' SET T.employeerostered = convert(SEC_TO_TIME(T1.employeerostered) , char);');
        Qry.Execute;
        Qry.SQL.Clear;
        Qry.SQL.Text := 'Select * ' +
                        ' from '+Tablename +' T '+
                        ' Order by Description';
        Qry.Open;
        InitMsgParams;
        PopupMsgParams.Msgcaption := 'Allocated Processes';
        PopupMsgParams.displayLabels:= '"Process","Resource","Capacity","Allocated","Over Allocated","Rostered"' ;
        PopupMsgParams.fieldNames:= '"Description","RDDescription","CapacityHoursDay","allocated","OverAllocated","employeerostered"' ;
        PopupMsgParams.Displaywidths:= '100,110,60,60,85,60';
        PopupMsgParams.MSGDs := Qry;
        PopupMsgParams.Custombuttons := 'OK';
        PopupMsgParams.Msg1:='Resources : Allocation and Avaialbility on ' + FormatDateTime(FormatSettings.ShortDateFormat , Integer(Grid.Objects[Col,0]));
        PopupMsgParams.Msg2 := '';
        PopupMsgParams.MsgColor := Self.Color;
        TfmMessageWithList.MsgDlg;
        exit;
      finally
        DbSharedObj.ReleaseObj(Qry);
        TTempTableList.Inst.AddTable(Tablename);
        TTempTableList.Inst.AddTable(Tablename+'1');
        TTempTableList.Inst.AddTable(Tablename+'2');
        //DestroyUserTemporaryTable(Tablename);
        //DestroyUserTemporaryTable(Tablename+'1');
        //DestroyUserTemporaryTable(Tablename+'2');
      end;
    //end;
  end;
  if gridrow < Grid.fixedrows then exit;
  if RowList.count =0 then exit;
  if gridrow >= Grid.fixedrows+RowList.count then exit;
  if col = ColStepItem then begin
     dt:= JobStart(RowRec(gridrow).SaleLineId ,RowRec(gridrow).ProcessPartId);
     if dt>0 then begin
       Grid.Col:= columindex(dt);
       Grid.row := arow;
       Grid.refresh;

     end;
  end else if Acol<Grid.FixedCols then
    openErpListForm('TSaleProcessListGUI' , BeforeShowSaleProcessList);
end;
Function TfmProcCapacityPlanning.columindex(const dt:TDateTime):Integer;
var
  ctr:Integer;
begin
  result:= grid.FixedCols;
  for ctr:= grid.FixedCols to Grid.ColCount-1 do begin
         if Grid.Objects[ctr,0]= TObject(Trunc(dt)) then begin
           result:= ctr;
           exit;
         end;
  end;
end;

procedure TfmProcCapacityPlanning.btnCalcnshowAvailaibityinCapacityPlannerClick(Sender: TObject);
begin
  inherited;
  AppEnv.Employee.CalcnshowAvailaibityinCapacityPlanner  := not(AppEnv.Employee.CalcnshowAvailaibityinCapacityPlanner);
  CheckCalcnshowAvailaibityinCapacityPlanner;
  LoadGridCapacityHeaders;
end;

procedure TfmProcCapacityPlanning.BeforeShowSaleProcessList(Sender: TObject);
begin
  TSaleProcessListGUI(Sender).SaleId :=RowRec(gridrow).SaleID;
end;

procedure TfmProcCapacityPlanning.GridDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  ACol, ARow: integer;
  OldDate, NewDate: TDateTime;
  Duration: double;
  aRowRec: TProcItem;
begin
  inherited;
  Grid.MouseToCell(x,y,ACol,ARow);
  ACol:= Grid.RealColIndex(aCol);
  if arow <> Selectedrow then begin
      MessageDlgXP_Vista('You cannot Merge - can only reschedule to other dates', mtWarning, [mbOK], 0);
      exit;
  end;
  if (aCol >= ColData) or (aCol = ColStepDuration) then begin
    aRowRec:= RowRec(SelectedRow);
    OldDate:= Integer(Grid.Objects[SelectedCol,0]);
    NewDate:= Integer(Grid.Objects[aCol,0]);
    if OldDate = 0 then
      Duration:= aRowRec.ProcTimeList.TotalUnScheduled
    else
      Duration:= aRowRec.ProcTimeList.SchedTimeForDate(OldDate);

    Reschedule(aRowRec, OldDate, NewDate, Duration);

  end;
end;

procedure TfmProcCapacityPlanning.SelectRelatedRows(ProcTreeId,parentID :Integer; Movingforward:Boolean; OldDate, NewDate:TDateTime);
var
  x,y:Integer;
  aRowRec:TProcItem;
begin
  if (ProcTreeId=0) and (  parentID=0) then exit;
  for x:=  0  to rowlist.count-1 do begin
    aRowRec:=rowlist.item[x];
    if Assigned(aRowRec) then begin
      if ((ProcTreeId<>0) and (aRowRec.ProcTreeId = ProctreeId) )
            OR
          ((ProcTreeId=0) and (aRowRec.ParentProcTreeId = parentId)) then begin
          if ProcItemstoReschedule <> '' then ProcItemstoReschedule := ProcItemstoReschedule +',';
          ProcItemstoReschedule := ProcItemstoReschedule+ inttostr(aRowRec.ProctreeID);
          for y := aRowRec.ProcTimeList.Count-1 downto 0  do begin
            if ((oldDate <= dateof(aRowRec.ProcTimeList.Item[y].timestart)) and (Movingforward)) or
               ((oldDate >= dateof(aRowRec.ProcTimeList.Item[y].timestart)) and (not(Movingforward))) then begin
              aRowRec.ProcTimeList.Item[y].Duration:= 0;
              aRowRec.ProcTimeList.Item[y].Deleted:= true;
            end;
          end;
          if movingforward then RowList.selectedlist.Add(x)
          else RowList.selectedlist.Insert(0 , x);
          if movingforward then SelectRelatedRows(aRowRec.ParentProcTreeId,0 ,movingforward, oldDate,newDate)
          else SelectRelatedRows(0 , aRowRec.ProcTreeId , movingforward, oldDate, newDate);
      end;
    end;
  end;
end;

procedure TfmProcCapacityPlanning.Reschedule(aRowRec: TProcItem;  OldDate, NewDate: TDateTime; Duration: double);
var
  Msg:String;
  Stepcount: Integer;
  fAutoProdPlanSchedType :TAutoProdPlanSchedType;
  RowListCopy: TProcItemList;
begin
 //   Grid.SelectRows(Grid.FixedRows,0);
 if Dateof(OldDate) =  Dateof(NewDate) then exit;

 if NewDate < Date+1 then begin
  MessageDlgXP_Vista('Selected Date to Reschedule - ' + FormatdateTime(FormatSettings.ShortdateFormat , NewDate) +' - is prior today and cannot be rescheduled.', mtWarning, [mbOK], 0);
  Exit;
 end;

 RowListCopy:=TProcItemList.create;
 try
    RowList.CopyTo(RowListCopy);
    ProcItemstoReschedule:= '';
    RowList.SelectedList.Clear;

    SelectRelatedRows(aRowRec.ProcTreeId ,0, oldDate < NewDate , oldDate, newDate);

    if ProcItemstoReschedule <> '' then begin
      try
        fAutoProdPlanSchedType:= ProcPrefs.AutoProdPlanSchedType;
        try
          if Newdate>Olddate then ProcPrefs.AutoProdPlanSchedType := psForward else ProcPrefs.AutoProdPlanSchedType := psReverse;
          RowList.AutoScheduleProduction(Msg,Stepcount,NewDate,true, RowListCopy);
        finally
          ProcPrefs.AutoProdPlanSchedType := fAutoProdPlanSchedType;
        end;
      finally
      end;
    end;

  //LoadGridCapacityHeaders;
 finally
  RefreshGrid;
  FreeandNil(RowListCopy);
 end;
end;


function TfmProcCapacityPlanning.StatusToString(const Status :TProcessPartStatus):String;
begin
  REsult := '';
       if Status = psNotScheduled then result := PS_STR_NOTSCHEDULED
  else if Status = psQualityAssurance    then result := PS_STR_QualityAssurance
  else if Status = psScheduled    then result := PS_STR_SCHEDULED
  else if Status =  psStarted     then result := PS_STR_STARTED
  else if Status = psComplete     then result := PS_STR_COMPLETE;
end;

procedure TfmProcCapacityPlanning.FlagasCompleteandEdit1Click(Sender: TObject);
var
  IDList:TIntegerList;
  y:Integer;
begin
  inherited;
  IDList:=TIntegerList.Create;
  try
   for Y:= Grid.FixedRows to Grid.AllRowCount -1 do begin
      if Grid.RowSelect[Y] then begin
        if IDlist.Indexof(RowRec(y).treeRootID)<0 then begin
          IDlist.AddIfNotInList(RowRec(y).treeRootID);
          OpenTree( RowRec(y).TreeRootId,RowRec(y).saleID);
        end;
      end;
   end;
  finally
    Freeandnil(IdList);
  end;
  FlagSelectedRows(psComplete);
end;

procedure TfmProcCapacityPlanning.FlagSelectedRows(
  const status: TProcessPartStatus);
var
  Y: integer;
  IDList:TIntegerList;
  LockedsaleIDList:TIntegerList;
begin
  IDList:=TIntegerList.create;
  LockedsaleIDList:=TIntegerList.create;
  try
    for Y:= Grid.FixedRows to Grid.AllRowCount -1 do begin
      if Grid.RowSelect[Y] then begin
        if Assigned(RowRec(y)) and (not RowRec(y).ProcTreeComplete) then begin
          if Userlock.Lock('tblsales' ,RowRec(y).saleID , '') then begin
            if RowRec(y).ProcessStatus<>  status then begin
              RowRec(y).ProcessStatus:= status;
              IdList.AddIfNotInList(RowRec(y).saleID);
              if status = psNotScheduled then begin
                RowRec(y).ProcessTimeStart:= 0;
                RowRec(y).ProcTimeList.UpdateProcItem(false);
              end else begin
                if RowRec(y).ProcessTimeStart = 0 then begin
                  if (Grid.Col >= Grid.FixedCols) then
                    RowRec(y).ProcessTimeStart:= Integer(Grid.Objects[Grid.RealColIndex(Grid.Col),0])
                  else
                    RowRec(y).ProcessTimeStart:= now;
                end;
                RowRec(y).ProcTimeList.UpdateProcItem;
              end;

            end;
          end else begin
            Grid.UnSelectRows(y,1);
            if LockedsaleIDList.InList(RowRec(y).saleID) = False then begin
              MessageDlgXP_Vista(ReplaceStr(ReplaceStr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to ' + StatusToString(status)) , 'this record' , 'Production Sales record #' +inttostr(RowRec(y).saleID)) ,mtWarning, [mbok],0);
              LockedsaleIDList.AddIfNotInList(RowRec(y).saleID);
            end;
          end;
        end;
      end;
    end;
  finally
    if IDList.count>0 then
      LogEvent(IdList, 'Manufacure :Status Changed to ' +Quotedstr(StatusToString(Status)));
    Freeandnil(LockedsaleIDList);
    Freeandnil(IDList);
  end;
  Grid.Refresh;
end;

procedure TfmProcCapacityPlanning.actScheduledExecute(Sender: TObject);
begin
  inherited;
  FlagSelectedRows(psScheduled);
end;

procedure TfmProcCapacityPlanning.actStartExecute(Sender: TObject);
begin
  inherited;
  FlagSelectedRows(psStarted);
end;

procedure TfmProcCapacityPlanning.actStowAwayExecute(Sender: TObject);
var
  msg:String;
begin
  inherited;
  With RootRowRec do begin
    if (Processstatus = psNotScheduled ) then begin
      MessageDLGXP_Vista(SaleLineProductName+ ' is not sheduled yet.  It is not possible to Stow away an unshceduled Item.', mtWarning, [mbok],0);
      Exit;
    end;
    if not TfmStowAway.DoStow(TreeRootId, msg) then
      MessageDLGXP_Vista(SaleLineProductName+ SaleLineProductName+  ' Can''t Stow Away :' +Msg, mtWarning, [mbok],0);
  end;
end;

procedure TfmProcCapacityPlanning.actCompleteExecute(Sender: TObject);
begin
  inherited;
  FlagSelectedRows(psComplete);
end;

procedure TfmProcCapacityPlanning.actLogTreeExecute(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
    if Grid.FixedRows-Grid.AllRowCount =0 then exit;
    for ctr:= Grid.FixedRows to Grid.AllRowCount -1 do begin
        if Assigned(RowRec(ctr)) then begin
          Logtext(Rowrec(ctr).Commatext);
        end;
    end;
end;

procedure TfmProcCapacityPlanning.actNotScheduledExecute(Sender: TObject);
begin
  inherited;
  FlagSelectedRows(psNotScheduled);
end;

procedure TfmProcCapacityPlanning.actOpenSaleExecute(Sender: TObject);
var
  SalesForm: TBaseInputGUI;
begin
  inherited;
  if RowRec <> nil then begin
    SalesForm:= TBaseInputGUI(GetComponentByClassName('TSalesOrderGUI'));
    if Assigned(SalesForm) then begin
      SalesForm.KeyID:= RowRec.SaleId;
      //SalesForm.AccessLevel:= 5;
      SalesForm.FormStyle := fsMDIChild;
      SalesForm.BringtoFront;
    end;
  end;
end;

procedure TfmProcCapacityPlanning.actOrderStatusExecute(Sender: TObject);
begin
  inherited;
  OpenERpListform('TBOMOrderStatusGUI' , beforeopenBOMOrderStatus )
end;
procedure TfmProcCapacityPlanning.beforeopenBOMOrderStatus(sender:TObject);
begin
  if not(sender is TBOMOrderStatusGUI) then Exit;
  TBOMOrderStatusGUI(Sender).SaleId :=RowRec.saleID;
  TBOMOrderStatusGUI(Sender).SaleLineId :=RowRec.SaleLineId;
end;
procedure TfmProcCapacityPlanning.popCustomiseGridPopup(Sender: TObject);
begin
  inherited;
  actOpenSale.Enabled:= RowRec <> nil;
  actProductTree.Enabled:= actOpenSale.Enabled;
  mnuGoodOrderStatus.visible := (GoodsOnOrderStatusColumSelected) and Assigned(RowRec()) and (Rowrec.GoodsOnOrderStatus <> '') ; // (Grid.Cells[Grid.col, Grid.row] <> '');
end;

procedure TfmProcCapacityPlanning.actProductTreeExecute(Sender: TObject);
var
  aRowRec: TProcItem;
begin
  aRowRec := RowRec;
  if not assigned(aRowRec) then
    exit;
  OpenTree( aRowRec.TreeRootId,aRowRec.saleID);
end;

procedure TfmProcCapacityPlanning.OpenTree( aTreeRootId , aSaleID:Integer);
begin
  ManufactureGuiLib.OpenTree(Self ,aTreeRootId , aSaleID , Userlock, Self.Caption);
(*var
  TreeForm: TfmProcTreeEdit;
  SalesRecLocked:Boolean;
begin
  SalesRecLocked:= False;
  inherited;
  TreeForm:= TfmProcTreeEdit.Create(self);
  try
    { does not use this but set here to stop "read-only" message from poping up }
    TreeForm.KeyID:= 1;
    { need all of the following to allow editing and saving of Info column in tree }
    TreeForm.TransConnection:= TreeForm.MyConnection;
    TreeForm.TransConnection.Connect;
    TreeForm.TransConnection.StartTransaction;
    TreeForm.Tree.TransConnection:= TreeForm.TransConnection;
    TreeForm.Tree.ProcessTreeID:= aTreeRootId; ;
    TreeForm.Tree.TreeMode:= tmTemplate ;
    TreeForm.Tree.vstProcessPart.Visible:= true;

    if not(Userlock.Lock('tblsales' ,aSaleID , Self.Caption)) then begin
      TreeForm.AccessLevel:= 5;
    end else begin
      SalesRecLocked:= True;
    end;
    TreeForm.ShowModal;
  finally
    if SalesRecLocked then
      Userlock.unLock('tblsales' ,asaleID , Self.Caption);
    TreeForm.Free;
  end;*)
end;

procedure TfmProcCapacityPlanning.actQualityAssuranceExecute(Sender: TObject);
begin
  inherited;
  FlagSelectedRows(psQualityAssurance);
end;

procedure TfmProcCapacityPlanning.RosterIt(timeStart:TDateTime; ProcstepID:Integer; Duration:double);
begin

end;

procedure TfmProcCapacityPlanning.actRosterExecute(Sender: TObject);
begin
  inherited;
  RosterIt(RowRec.ProcessTimeStart , RowRec.ProcessStepId ,RowRec.ProcTimeList.SchedTimeForDate(Integer(Grid.Objects[SelectedCol,0])));
end;

procedure TfmProcCapacityPlanning.actRosterUpdate(Sender: TObject);
begin
  inherited;
  actroster.Enabled := not( (RowRec=nil));
end;
function TfmProcCapacityPlanning.RootRowRec: TProcItem;
var
  ctr:Integer;
begin
  result:= RowRec;
  if RowRec.IsRoot then exit;
  For ctr:=  Grid.FixedRows to   Grid.Rowcount -1 do begin
    if RowList[ctr- Grid.FixedRows].ProcTreeId = result.TreeRootId then begin
      result:= RowList[ctr- Grid.FixedRows];
      exit;
    end;
  end;
end;

function TfmProcCapacityPlanning.RowRec: TProcItem;
begin
  result:= nil;
  if (Grid.Row > (Grid.FixedRows -1)) and (RowList.Count > 0) then
    result:= RowList[Grid.Row - Grid.FixedRows];
end;

function TfmProcCapacityPlanning.RowRec(const aRow: integer): TProcItem;
begin
  result:= nil;
  if (aRow > (Grid.FixedRows -1)) and (RowList.Count > 0) then
    result:= RowList[aRow - Grid.FixedRows];
end;

procedure TfmProcCapacityPlanning.mnuPartialShipmentsClick(Sender: TObject);
begin
  inherited;
  Try
    if Rowrec.saleId =0 then exit;
  Except
    Exit;
  End;
  OpenERPListForm('TsalesOrderInvoicesGUI', beforeshowsalesOrderInvoicesGUI);
end;
procedure TfmProcCapacityPlanning.beforeshowsalesOrderInvoicesGUI(Sender: TObject);
begin
  if not(Sender is TsalesOrderInvoicesGUI) then exit;
  TsalesOrderInvoicesGUI(Sender).SaleID     := Rowrec.saleId;
  TsalesOrderInvoicesGUI(Sender).SalelineID := Rowrec.salelineId;
end;
procedure TfmProcCapacityPlanning.actAutoScheduleExecute(Sender: TObject);
var
  msg: string;
  count: integer;
begin
  inherited;
  if RowList.Dirty then begin
    MessageDlgXP_Vista('Please Save current changes before production can be automatically scheduled.',mtInformation,[mbOk],0);
  end  else begin
    if not CheckforUnAlloctedPS then exit;

    if AutoScheduleProduction(msg, count, MyConnection, userlock) then begin
      if count > 0 then begin
        self.CommitTransaction;
        self.BeginTransaction;
        LoadGrid;
      end;
    end
    else begin
      MessageDlgXP_Vista('Auto Production Scheduling failed with the following message: ' + CRLF + msg,mtWarning,[mbOk],0);
    end;
  end;
end;

procedure TfmProcCapacityPlanning.actallocPickingSlipExecute(Sender: TObject);
var
  strSQL:String;
  Tablename :String;
begin
  inherited;
  if (Rowrec.SaleId =0) or ( RowRec.SaleLineId =0) then exit;
  tablename := (*CommonDbLib.GetUserTemporaryTableName(*)UniqueTableName('BOMPickingslip');
  MakeBOMPickingTable(inttostr(RowRec.SaleLineId), tablename);

  strSQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, '+
            ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
            ' ~|||~{details}Select * from '+tablename +' order by SeqID ';

  ReportToPrint :=tcdatautils.GetDefaultReport('BOM Picking Slip');
  fbReportSQLSupplied := True;
  PrintTemplateReport(ReportToPrint , StrSQL , False , 1);
  //DestroyUserTemporaryTable(Tablename);
end;

procedure TfmProcCapacityPlanning.actApplyExecute(Sender: TObject);
begin
  inherited;
  if SaveChanges then begin
    self.CommitTransaction;
    Userlock.UnlockAllCurrentInstance;
    LockCapacityplanner;
    refreshGrid;
  end;
end;

procedure TfmProcCapacityPlanning.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actSave.Enabled:= RowList.Dirty;
  actApply.Enabled:= actSave.Enabled;
  actAutoSchedule.Enabled:= self.AccessLevel < 5;
  actCreatePickingSlip.Enabled:= actAutoSchedule.Enabled;
  actPrintWorkSheets.Enabled:= actAutoSchedule.Enabled;
  actStart.Enabled:= actAutoSchedule.Enabled;
  actComplete.Enabled:= actAutoSchedule.Enabled;
  actInvoice.Enabled:= actAutoSchedule.Enabled;
  actScheduled.Enabled:= actAutoSchedule.Enabled;
  actNotScheduled.Enabled:= actAutoSchedule.Enabled;
end;

procedure TfmProcCapacityPlanning.actCreatePickingSlipExecute(
  Sender: TObject);
var
  form: TfmProcCapacityPlanningPick;
  aDateFrom, aDateTo: TDateTime;
  aRowRec: TProcItem;
  x: integer;
begin
  inherited;
  if not CheckSaveContinue then
    exit;
//  if self.RowList.Dirty then begin
//    MessageDlgXP_Vista('Please Save changes first.',mtInformation,[mbOk],0);
//    exit;
//  end;

  aDateFrom:= 0;
  aDateTo:= 0;
  form:= TfmProcCapacityPlanningPick.Create(nil);
  for x:= Grid.FixedRows to Grid.AllRowCount -1 do begin
    if Grid.RowSelect[x] then begin
      aRowRec:= RowRec(x);
      if Assigned(aRowRec) and (aRowRec.ProcessTimeStart > 0) then begin
        if (aRowRec.ProcessTimeStart < aDateFrom) or (aDateFrom = 0) then
          aDateFrom:= aRowRec.ProcessTimeStart;
        if (aRowRec.ProcessTimeStart > aDateTo) then
          aDateTo:= aRowRec.ProcessTimeStart;
        form.ProcesstepIdList.AddIfNotInList(aRowRec.ProcessStepId);
      end;
    end;
  end;

  if form.ProcesstepIdList.IsEmpty then begin
    MessageDlgXP_Vista('Nothing selected.',mtInformation,[mbOk],0);
    form.Free;
  end
  else begin

    form.DateFrom:= aDateFrom;
    form.DateTo:= aDateTo;
    form.ShowModal;

  end;
end;

procedure TfmProcCapacityPlanning.actPartialInvoiceExecute(Sender: TObject);
var
  curRow:Integer;
begin
  inherited;
  try
    if Rowrec.saleId =0 then exit;
  Except
    Exit;
    // kill the exception
  end;
  CurRow := Grid.Row;
  try
    if not SaveChanges then Exit;
    self.CommitTransaction;
    Userlock.UnlockAllCurrentInstance;
    LockCapacityplanner;
    refreshGrid;
  finally
    Grid.Row := curRow;
  end;

  OpenERPFormModal('TfmSalesorderInvoice' , 0 , initSalesorderInvoice, False, OnSalesOrderInvoiceCreate);
end;

procedure TfmProcCapacityPlanning.OnSalesOrderInvoiceCreate(Sender:TObject);
begin
  if not(sender is TfmSalesorderInvoice) then exit;

  if TfmSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrder.isinternalOrder  then
    MessageDlgXP_vista('Quantity Selected is now in stock for Sales Order # ' + inttostr(TfmSalesorderInvoice(Sender).SalesOrderInvoices.SalesOrderID)+'.', mtConfirmation, [mbOK], 0)
  else if TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId <> 0 then
        if MessageDlgXP_vista('Invoice #' + inttostr(TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId ) +' is Created. '+
                                'Do you want to see the invoice? ' , mtConfirmation, [mbyes,mbno], 0) = mryes then
            OpenERPForm('TInvoiceGUI' , TfmSalesorderInvoice(Sender).SalesOrderInvoices.InvoiceId);
end;
procedure TfmProcCapacityPlanning.initSalesorderInvoice(Sender: TObject);
begin
  if not(Sender is   TfmSalesorderInvoice) then exit;
  TfmSalesorderInvoice(Sender).saleID     := Rowrec.saleId;
  TfmSalesorderInvoice(Sender).SaleLineID := Rowrec.salelineID;
end;
procedure TfmProcCapacityPlanning.actPQAllocationExecute(Sender: TObject);
begin
  inherited;
  if (RowRec <> nil) then begin
    if (Rowrec.SaleId =0) or ( RowRec.SaleLineId =0) then exit;
    TfmBOMAllocation.DoAllocation(Rowrec.SaleId, RowRec.SaleLineId, nil);
  end;
end;

procedure TfmProcCapacityPlanning.actPrintJobDetailsExecute(Sender: TObject);
var
  StrSQL:String;
  fsTablename :String;
begin
  inherited;

  if (RowRec.SaleLineId =0) or ( RowRec.ProcessPartId =0) or (RowRec.SaleLineQuantity =0) then exit;
  {calculate Total quantity for the items on the tree}
  fsTablename := (*CommonDbLib.GetUserTemporaryTableName(*)UniqueTableName('CPProductDetailreport');
  StrSQL :=ProductJobDEtailsSQL(fsTablename,   RowRec.SaleLineId,  RowRec.ProcessPartId,RowRec.ProctreetotalQty);

  fbReportSQLSupplied := True;
  PrintTemplateReport('Product Job Details' , strSQL , False, 1);
  //DestroyUserTemporaryTable(fstablename);
end;

procedure TfmProcCapacityPlanning.actPrintWorkSheetsExecute(
  Sender: TObject);
var
  form: TfmProcCapacityPlanningWork;
  aDateFrom, aDateTo: TDateTime;
  aRowRec: TProcItem;
  x: integer;
begin
  inherited;
  if not CheckSaveContinue then
    exit;
//  if self.RowList.Dirty then begin
//    MessageDlgXP_Vista('Please Save changes first.',mtInformation,[mbOk],0);
//    exit;
//  end;

  aDateFrom:= 0;
  aDateTo:= 0;
  form:= TfmProcCapacityPlanningWork.Create(nil);
  form.CallingFormname := Self.classname;
  for x:= Grid.FixedRows to Grid.AllRowCount -1 do begin
    if Grid.RowSelect[x] then begin
      aRowRec:= RowRec(x);
      if Assigned(aRowRec) and (aRowRec.ProcessTimeStart > 0) then begin
        if (aRowRec.ProcessTimeStart < aDateFrom) or (aDateFrom = 0) then
          aDateFrom:= aRowRec.ProcessTimeStart;
        if (aRowRec.ProcessTimeStart > aDateTo) then
          aDateTo:= aRowRec.ProcessTimeStart;
        form.ProcesstepIdList.AddIfNotInList(aRowRec.ProcessStepId);
        form.SaleLineIDList.AddIfNotInList(aRowRec.saleLineID);
      end;
    end;
  end;

  if form.ProcesstepIdList.IsEmpty then begin
    MessageDlgXP_Vista('Nothing selected.',mtInformation,[mbOk],0);
    form.Free;
  end
  else begin

    form.DateFrom:= aDateFrom;
    form.DateTo:= aDateTo;
    form.ShowModal;

  end;
end;

procedure TfmProcCapacityPlanning.GridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  aCol, aRow: integer;
  aRealCol, aRealRow: integer;

  function ColSelected: integer;
  begin
    result:= -1;
    if (grid.CellRect(aCol,aRow).Right - x) <= 6 then
      result:= aCol
    else if x - grid.CellRect(aCol,aRow).Left <= 6 then
      result:= aCol -1;
  end;


begin
  inherited;
  grid.MouseToCell(x,y,aCol,aRow);
  aRealRow:= grid.RealRowIndex(aRow);
  aRealCol:= grid.RealColIndex(aCol);
  Grid.Cursor:= crDefault;

  if ((aRealRow = RowSubTitle) and (aRealCol <= colGoodsOnOrderStatus)) then begin
    if ColSelected > -1 then begin
      Grid.Cursor:= crHSplit;
      if ssLeft in Shift then begin
        if not DraggingCellWidth then begin
          DraggingCellWidth:= true;
          DraggingCellCol:= ColSelected;
        end;
        Grid.ColWidths[DraggingCellCol]:= Grid.ColWidths[DraggingCellCol] + (x - MouseDownX);
        MouseDownX:= x;
      end;
    end
    else begin
      Grid.Cursor:= crDefault;
    end;
  end;
end;

procedure TfmProcCapacityPlanning.GridCellValidate(Sender: TObject; ACol,
  ARow: Integer; var Value: String; var Valid: Boolean);
var
  OldDate, NewDate: TDateTime;
  Duration, OldDuration: double;
  aRowRec: TProcItem;
begin
  inherited;

  if (aCol >= ColData) then begin
    aRowRec:= RowRec(aRow);
    NewDate:= Integer(Grid.Objects[aCol,0]);
    OldDate:= NewDate;
    OldDuration:= aRowRec.ProcTimeList.SchedTimeForDate(OldDate);

    if (Value <> '') and (Value <> '  :  :  ') then begin
      Value:= StringReplace(Value,' ','0',[rfReplaceAll]);
      Duration:= StrToProcTime(Value);
      if Duration > OldDuration      then  Reschedule(aRowRec, 0, NewDate, Duration - OldDuration)
      else if Duration < OldDuration then  Reschedule(aRowRec, OldDate, 0, OldDuration - Duration);
    end else begin
      if OldDuration <> 0 then
        Reschedule(aRowRec, OldDate, 0, OldDuration);
    end;

    Grid.EndDrag(false);

    Value:= '';
    Grid.Refresh;

  end;
end;

procedure TfmProcCapacityPlanning.GridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  DraggingCellWidth:= false;
  DraggingCellCol:= -1;
  Grid.Cursor:= crDefault;
end;


procedure TfmProcCapacityPlanning.Readguiprefs;
begin
  inherited;
//  if GuiPrefs.Node.Exists('Options.DateFrom') then edtDateFrom.Date :=GuiPrefs.Node['Options.DateFrom'].AsDatetime;
end;

procedure TfmProcCapacityPlanning.RestorecolWidthfromPref;
var
  x: integer;
begin
  for x:= 0 to FixedCols -1 do begin
    if GuiPrefs.Node.Exists('ColWith_' + IntToStr(x)) then
      Grid.ColWidths[x]:= GuiPrefs.Node['ColWith_' + IntToStr(x)].AsInteger;
  end;
end;

procedure TfmProcCapacityPlanning.LogEvent(IdList: TIntegerList;  EventDesc: String);
var
  Audit: TAudit;
  ctr:Integer;
begin
      Audit:= TAudit.Create(nil);
      try
        Audit.Load(0);
        for ctr:= 0 to Idlist.count-1 do begin
          Audit.New;
          Audit.TransType:= TSalesOrder.XMLNodeName;
          Audit.DataDescription:= 'Main';
          Audit.AuditDate:= now;
          Audit.TransGlobalref := TSalesOrder.IDToggle(IDList[ctr]);
          Audit.ChangeDescription:= EventDesc;
          try
              Audit.Save;
          Except
              // kill the exception when ChangeDescription is more than 255 chars
          end;
        end;

      finally
        FreeandNil(Audit);
      end;


end;

procedure TfmProcCapacityPlanning.mnuGoodOrderStatusClick(Sender: TObject);
begin
  inherited;
  openERPListform('TSalesPurchaseOrderListGUI' , BeforeShowSalesPurchaseOrderList);
end;
procedure TfmProcCapacityPlanning.BeforeShowSalesPurchaseOrderList(Sender: TObject);
begin
  if not(Sender is TSalesPurchaseOrderListGUI) then exit;
  TSalesPurchaseOrderListGUI(Sender).SaleLineId :=RowRec(Grid.row).SaleLineID;
end;
procedure TfmProcCapacityPlanning.WriteGuiPrefs;
var
  x: integer;
begin
  for x:= 0 to FixedCols -1 do begin
    GuiPrefs.Node['ColWith_' + IntToStr(x)].AsInteger:= Grid.ColWidths[x];
  end;
  inherited;
//  GuiPrefs.Node['Options.DateFrom'].AsDatetime := edtDateFrom.Date;
end;



procedure TfmProcCapacityPlanning.actInvoiceExecute(Sender: TObject);
var
  IdList: TIntegerList;
  x: integer;
  Msg:String;
begin
  inherited;
  try
    FlagSelectedRows(psComplete);
    if not CheckSaveContinue(true) then
      exit;
    IdList:= TIntegerList.Create;
    try
      for x:= Grid.FixedRows to Grid.AllRowCount -1 do begin
        if Grid.RowSelect[x] and Assigned(RowRec(x)) then begin
          IdList.AddIfNotInList(RowRec(x).SaleId);
          if not RowRec(x).Dirty then
            RowRec(x).Dirty:= true;
        end;
      end;
      {if the capacity planning has locked the sales record, unlock it }
      for x := 0 to IdList.count-1 do Userlock.unLock('tblsales' ,IdList[x] , '');

      if IdList.Count > 0 then begin
        self.RollbackTransaction;
            if DoJobComplete(IdList, false, msg) then begin
              LogEvent(IdList, 'Completed and Invoiced');
              if msg <> '' then CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
              if CheckSaveContinue(true) then begin
                self.BeginTransaction;
                LoadGrid;
              end;
            end else if msg <> '' then CommonLib.MessageDlgXP_Vista(msg + NL +NL +'Please Double click on the Process to see the status of all processes of the Sale.',mtWarning,[mbOk],0);
      end;
    finally
      IdList.Free;
    end;
  finally
    self.BeginTransaction;
  end;
end;

procedure TfmProcCapacityPlanning.GridGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  inherited;
  if (aCol >= ColData) then begin
    Value:= '!90:00:00;1;0';
  end;
end;

procedure TfmProcCapacityPlanning.GridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
var
  Duration: double;  
begin
  inherited;
  if (aCol >= ColData) then begin
    if Assigned(RowRec(aRow)) then begin
      Duration:= RowRec(aRow).ProcTimeList.SchedTimeForDate(Integer(Grid.Objects[aCol,0]));
      if Duration <> 0 then
        Value:= ProcTimeToStr(Duration)
      else
        Value:= '';
    end
    else
      Value:= '';
  end;
end;

Procedure TfmProcCapacityPlanning.RefreshCount;
var
  x:Integer;
  ctr:Integer;
begin
  inherited;
  ctr:=0;
  for x:= Grid.FixedRows to Grid.AllRowCount -1 do
    if Grid.RowSelect[x] then ctr := ctr+1;
  lblSelcount.Caption :=  'Sales Selected : ' +IntToStr(ctr);
end;

procedure TfmProcCapacityPlanning.GridRowDisjunctSelect(Sender: TObject;
  ARow: Integer; AState: Boolean; var Allow: Boolean);
begin
  inherited;
 RefreshCount;
end;

procedure TfmProcCapacityPlanning.GridRowDisjunctSelected(Sender: TObject;
  ARow: Integer);
begin
  inherited;
  RefreshCount;
end;

initialization
  RegisterClassOnce(TfmProcCapacityPlanning);

end.


