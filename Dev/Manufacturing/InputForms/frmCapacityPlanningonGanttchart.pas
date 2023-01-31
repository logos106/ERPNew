unit frmCapacityPlanningonGanttchart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  wgsDataSource, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, wgsGanttEntities, wgsController, wgsGanttGraph, DNMSpeedButton,
  Shader, StdCtrls, wwdbdatetimepicker, ExtCtrls, DNMPanel, frmBaseGanttChart,
  wwclearbuttongroup, wwradiogroup, IntegerListObj, ProcCapacityPlanningObj,
  ObjCapacityPlanningganttchart, Spin, wgsGanttBar, ActnList, wwcheckbox , Contnrs,
  ProgressDialog, wgsSummaryBar, wgsOperation;

type
  TResIdObj = class(TObject)
  public
    ProcessStepId,
    ResourceId: integer;
  end;

  TfmCapacityPlanningonGanttchart = class(TfmBaseGanttChart)
    QryMasterparentId: TIntegerField;
    QryMasterProcTreeId: TIntegerField;
    QryMasterTreeRootId: TIntegerField;
    QryMasterSaleId: TIntegerField;
    QryMasterSaleDocNumber: TWideStringField;
    QryMasterSaleCustomerName: TWideStringField;
    QryMasterSaleDate: TDateField;
    QryMasterSaleShipDate: TDateField;
    QryMasterSaleLineId: TIntegerField;
    QryMasterSaleLineProductName: TWideStringField;
    QryMasterSaleLineProductDescription: TWideStringField;
    QryMasterSaleLineQuantity: TFloatField;
    QryMasterSaleLineShipDate: TDateTimeField;
    QryMasterProcTreeCaption: TWideStringField;
    QryMasterProcTreeDescription: TWideStringField;
    QryMasterProcTreeTotalQty: TFloatField;
    QryMasterProcTreePartId: TIntegerField;
    QryMasterProcTreeLevel: TIntegerField;
    QryMasterProcTreeSequenceDown: TIntegerField;
    QryMasterProcTreeComplete: TWideStringField;
    QryMasterProcessDesc: TWideStringField;
    QryMasterProcessPartId: TIntegerField;
    QryMasterProcessPartDuration: TFloatField;
    QryMasterProcessStatus: TWideStringField;
    QryMasterProcessTimeStart: TDateTimeField;
    QryMasterProcessPartSetupDuration: TFloatField;
    QryMasterProcessPartBreakdownDuration: TFloatField;
    QryMasterProcessSequence: TIntegerField;
    QryMasterProcessStepId: TIntegerField;
    QryMasterProcessResourceId: TIntegerField;
    QryMasterProcPickSlipId: TIntegerField;
    QryMastercProcessPartDuration: TStringField;
    QryDetailsProcesstimeID: TIntegerField;
    QryDetailsProcessPartID: TIntegerField;
    QryDetailsTimeStart: TDateTimeField;
    QryDetailstimeend: TDateTimeField;
    DNMSpeedButton1: TDNMSpeedButton;
    btnAutoSchedule: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grpGridDetailChange(Sender: TObject);
    procedure QryMasterCalcFields(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnAutoScheduleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spincolWidthExit(Sender: TObject);
    procedure DatasourceChange(Operation: TWGSOperation);
  private
    CPGanttChart:TCapacityPlanningGanttChart;
    (*procedure AddDateException;*)
  Protected
    procedure RefreshQuery;Override;
    function RefreshGridEvent(fieldName: String): String;Override;
    function Firstdate:TDatetime; override;
    function RefreshGrid:boolean; Override;
    Procedure DoOnAfterBarResize   (Bar : TWGSGanttBar) ;Override;
    Procedure DoOnAfterBarAdd      (Bar : TWGSGanttBar) ;Override;
    Procedure DoOnAfterBarMove     (Bar : TWGSGanttBar) ;Override;
    Procedure DoOnAfterBarMoveDetailed  (Bar : TWGSGanttBar; AFromSummaryBar:Boolean) ;Override;
    Procedure DoOnAfterBarDelete   (Bar : TWGSGanttBar) ;Override;
    Procedure DoOnBeforeBarMove    (Bar : TWGSGanttBar; var Cancel : Boolean);Override;
    Procedure DoOnBeforeBarDelete  (Bar : TWGSGanttBar; var Cancel : Boolean);Override;
    Procedure DoOnBeforeBarResize  (Bar : TWGSGanttBar; var Cancel : Boolean);Override;
    Procedure DoOnBeforeBarAdd     (Bar : TWGSGanttBar; var Cancel : Boolean);Override;
    Procedure DoOnBarResize        (Bar : TWGSGanttBar; changeX : Real; changeY : Integer; Right : Boolean; var Allowed : Boolean) ;Override;
    Procedure DoOnGanttBarMove     (Bar : TWGSGanttBar; NewRow : Integer; NewStartDate : TDateTime; var Allowed : Boolean);Override;
    procedure DoGanttChartEvent(const Sender: TObject; const Value,Msg: string) ;Override;
    Procedure WriteGuiPrefs;Override;
    Procedure Readguiprefs;Override;
    procedure GanttGraphTreeCellDblClick(Sender: TObject); Override;
    procedure LockCapacityplanner;override;
  public
  end;


implementation

uses CommonLib, CommonDbLib, dateutils, ProcessUtils, AppEnvironment,
  BusObjProcPrefs, wgsDocumentCalendar, ObjGanttChart, tcConst;

{$R *.dfm}


function TfmCapacityPlanningonGanttchart.FirstDate: TDatetime;
begin
  With TempMyQuery do try
    Connection := Self.MyConnection;
    SQL.add('SELECT min(PPT.TimeStart) as timestart  ' +
            ' FROM tblSales s ' +
            ' JOIN tblSalesLines sl ON s.SaleId = sl.SaleId ' +
            ' JOIN tblProcTree pt on pt.MasterId = sl.SaleLineId and pt.mastertype <> "mtProduct" ' +
            ' JOIN tblProcessPart pp ON pp.ProcTreeId = pt.ProcTreeId ' +
            ' JOIN tblProcessTime   PPT  on PPT.ProcessPartID = PP.ID ' +
            ' where S.converted = "F" and ifnull(PPT.timeStart,0)<> "1899-12-30 00:00:00" ' +
            ' and s.IsSalesOrder = "T" ' +
            ' and if(pt.ParentId=0 and pt.masterId = Sl.saleLineId,pt.TotalQty , pt.TreePartUOMTotalQty)  <> 0');
    open;
    REsult  := fieldByname('timestart').asDateTime;
    if result =0 then result := date;
  finally
    closenFree;
  end;
end;

(*procedure TfmCapacityPlanningonGanttchart.AddDateException;
var
  fixedDate : TWGSFixedDateException;
  ACategory : TWGSDateCategory;
begin
  // First we add a new date category …
  ACategory := TWGSDateCategory.Create('A new date category', clLime);
  // … after that, we create a fixed date exception
  fixedDate := TWGSFixedDateException.Create(Trunc(Now), 'A Date Exception');
  // Now we will add the date exception to the category
  ACategory.addDate(fixedDate);
  // Finally, we will add the category to the calendar.
  Datasource.Calendar.addDateCategory(ACategory);
end;*)
procedure TfmCapacityPlanningonGanttchart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  rowlist := nil;
end;

procedure TfmCapacityPlanningonGanttchart.FormCreate(Sender: TObject);
var
  x:Integer;
begin
  for x:= 0 to   Datasource.Calendar.CategoriesCount-1 do
    Datasource.Calendar.Categories[x].Working:= True;

(*  for x:= Datasource.Calendar.CategoriesCount-1 downto 0 do
    Datasource.Calendar.Categories[x].Visible:= False;*)


  CPGanttChart:= TCapacityPlanningGanttChart.create(Self, GanttGraph , Datasource , QryMaster, RefreshGridEvent);
  CPGanttChart.Connection := Self.MyConnection;
  CPGanttChart.Loading := true;
  GanttChart := CPGanttChart;
  RowList:=CPGanttChart.rowlist;
  inherited;
  Readguiprefs;
  UserFilterOptions;
  CPGanttChart.DetailsDs      := QryDetails;
  CPGanttChart.Groupingfield  := QryMastersaleID.FieldName;
  CPGanttChart.DateFromfield  := QryDetailsTimeStart.FieldName;
  CPGanttChart.DateTofield    := QryDetailsTimeEnd.FieldName;

  AddFixedcol('SaleID'              , 'Ref'      , 80); //saleID
  AddFixedcol('SaleCustomerName'    , 'Customer' , 80);
  AddFixedcol('Saledate'            , 'Sale Date', 80);
  AddFixedcol('SaleLineProductname' , 'Product'  , 80);
  AddFixedcol('SaleLineQuantity'    , 'Qty'      , 80);
  AddFixedcol('Proctreecaption'     , 'Tree Item', 80);
  AddFixedcol('ProctreetotalQty'    , 'Tree Qty' , 80);
  AddFixedcol('ProcessDesc'         , 'Process'  , 80);
  AddFixedcol('cProcessPartDuration', 'Duration' , 80);
  AddFixedcol('ProcessStatus'       , 'Status'   , 80);
  AddFixedcol(''                    , 'Goods on Order'  , 120);
  Enablehourmode := True;
  EnableDayMode  := True;
  grpTimeMode.Width := 116*grpTimeMode.Items.Count;
end;

procedure TfmCapacityPlanningonGanttchart.FormShow(Sender: TObject);
begin
  try
    inherited;
    LockCapacityplanner;
  finally
    CPGanttChart.Loading := False;
    fbformshown:= True;
  end;
end;


procedure TfmCapacityPlanningonGanttchart.GanttGraphTreeCellDblClick(Sender: TObject);
begin
  inherited;
  if CPGanttChart.FocusedProcItem = nil then exit;
  CPGanttChart.ChartDate := JobStart(CPGanttChart.FocusedProcItem.SaleLineId , CPGanttChart.FocusedProcItem.ProcessPartId);
end;

procedure TfmCapacityPlanningonGanttchart.grpGridDetailChange(Sender: TObject);
begin
  inherited;
  try
    if grpGridDetail.ItemIndex = 0 then begin
      CPGanttChart.hideColumn('Ref');
      CPGanttChart.hideColumn('Customer');
      CPGanttChart.hideColumn('Sale Date');
      CPGanttChart.hideColumn('Product'  );
      CPGanttChart.hideColumn('Qty'      );
      CPGanttChart.hideColumn('Tree Item');
      CPGanttChart.hideColumn('Tree Qty' );
    end else if grpGridDetail.ItemIndex = 1 then begin
      CPGanttChart.ShowColumn('Tree Item');
      CPGanttChart.ShowColumn('Tree Qty');
      CPGanttChart.hideColumn('Ref');
      CPGanttChart.hideColumn('Customer');
      CPGanttChart.hideColumn('Sale Date');
      CPGanttChart.hideColumn('Product'  );
      CPGanttChart.hideColumn('Qty'      );
    end else begin
      CPGanttChart.ShowColumn('Tree Item');
      CPGanttChart.ShowColumn('Tree Qty');
      CPGanttChart.ShowColumn('Ref');
      CPGanttChart.ShowColumn('Customer');
      CPGanttChart.ShowColumn('Sale Date');
      CPGanttChart.ShowColumn('Product'  );
      CPGanttChart.ShowColumn('Qty'      );
    end;
  finally
    Repaint;
  end;
end;
procedure TfmCapacityPlanningonGanttchart.LockCapacityplanner;
begin
  inherited;
  if Accesslevel >= 5 then begin
        btnAutoSchedule.enabled := False;
        btnSave.enabled := False;
  end;

end;

procedure TfmCapacityPlanningonGanttchart.QryMasterCalcFields(DataSet: TDataSet);
begin
  inherited;


  (*QryMasterProcesstimeEnd.AsDateTime     := (QryMasterProcessPartDuration.asFloat +
                                              QryMasterProcessPartSetupDuration.asfloat +
                                              QryMasterProcessPartBreakdownDuration.asFloat )*
                                              QryMasterProcTreeTotalQty.asfloat;*)

  QryMastercProcessPartDuration.asString := ProcTimeToStr((QryMasterProcessPartDuration.asFloat +
                                              QryMasterProcessPartSetupDuration.asfloat +
                                              QryMasterProcessPartBreakdownDuration.asFloat )*
                                              QryMasterProcTreeTotalQty.asfloat);
end;
procedure TfmCapacityPlanningonGanttchart.Readguiprefs;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.TimMode') then
    grpTimeMode.ItemIndex :=GuiPrefs.Node['Options.TimMode'].AsInteger;
end;

function TfmCapacityPlanningonGanttchart.RefreshGrid:Boolean ;
begin
  CPGanttChart.Loading := true;
  try
    result:= true;
    //inherited;
    CPGanttChart.AllowToMoveBar := true;
    try
      CPGanttChart.ListfilterStepIDList     :=SelectedProcessStepIDList;
      if cboCustomers.ItemIndex>0 then CPGanttChart.Listfiltercustomername   :=cboCustomers.Text
      else CPGanttChart.Listfiltercustomername   :='';
      CPGanttChart.ListfilterSaleId         :=SaleIdTofilter;
      CPGanttChart.ShowFinalised            := chkShowFinalised.checked;
      CPGanttChart.RefreshTree(DateFrom, DateTo);
    finally
      //CPGanttChart.AllowToMoveBar := False;
    end;
    CPGanttChart.ChartDate := DateFrom;
  finally
    CPGanttChart.Loading := False;
  end;
end;

function TfmCapacityPlanningonGanttchart.RefreshGridEvent(fieldName: String): String;
begin
  Result := inherited RefreshGridEvent(FieldName);
  if Sametext(FieldName , 'SaleDate') then begin
    REsult := formatDateTime(FormatSettings.shortDateformat , QryMastersaleDate.AsDateTime);
  end else if Sametext(fieldName, 'ProcessStatus') then begin
    REsult := ProcessPartStatusToUserStr(StrToProcessPartStatus(QryMasterProcessStatus.asString));
  end;

end;

procedure TfmCapacityPlanningonGanttchart.RefreshQuery;
Var
  s:String;
  RowList: TProcItemList;
begin
  RowList:= TProcItemList.Create;
  try
    RowList.Connection:= MyConnection;
    s:= RowList.LoadListSQL(DateFrom, DateTo, nil , '' , 0);
    closeDb(QryMaster);
    QryMaster.SQL.Clear;
    QryMaster.SQL.Add(s);
    openDb(QryMaster);
    openDb(QryDetails);
  finally
    RowList.Free;
  end;
end;
procedure TfmCapacityPlanningonGanttchart.spincolWidthExit(Sender: TObject);
begin
  inherited;
  GuiPrefs.Node['Options.'+ GanttChart.StringTimeMode +'.columnwidth'].AsInteger := SpinColWidth.Value;
end;

procedure TfmCapacityPlanningonGanttchart.WriteGuiPrefs;
begin
  GuiPrefs.Node['Options.TimMode'].asInteger:= grpTimeMode.ItemIndex;
  inherited;
end;

procedure TfmCapacityPlanningonGanttchart.DoOnAfterBarDelete(Bar: TWGSGanttBar);
begin
end;
procedure TfmCapacityPlanningonGanttchart.btnAutoScheduleClick(Sender: TObject);
var
  msg: string;
  count: integer;
begin
  inherited;
  if not CheckforUnAlloctedPS then exit;
    if AutoScheduleProduction(msg, count, MyConnection, userlock) then begin
      if count > 0 then begin
        self.CommitTransaction;
        Self.BeginTransaction;
        RefreshGrid;
      end;
    end else begin
      MessageDlgXP_Vista('Auto Production Scheduling failed with the following message: ' + NL + msg,mtWarning,[mbOk],0);
    end;
end;

procedure TfmCapacityPlanningonGanttchart.btnSaveClick(Sender: TObject);
begin
  inherited;
  CPGanttChart.Saving := True;
  try
    if SaveChanges then begin
      self.CommitTransaction;
      self.BeginTransaction;
      refreshGrid;
      LockCapacityplanner;
    end;
  finally
    CPGanttChart.Saving := False;
  end;
end;

procedure TfmCapacityPlanningonGanttchart.DatasourceChange(  Operation: TWGSOperation);
begin
  inherited;
        // TWGSSummaryBarMoveOperation (Operation).Row
        // TWGSSummaryBarMoveOperation (Operation).OldStartDate
        // TWGSSummaryBarMoveOperation (Operation).NewStartDate
end;

procedure TfmCapacityPlanningonGanttchart.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  CPGanttChart.AllowToMoveBar := true;
  try
    CPGanttChart.ClearGraph;
    CPGanttChart.rePaint;
  finally
    //CPGanttChart.AllowToMoveBar := False;
  end;
end;

procedure TfmCapacityPlanningonGanttchart.DoGanttChartEvent(const Sender: TObject; const  Value,Msg: string);
(*var
  dt:TDatetime;*)
begin
  inherited;
  if Msg<> '' then begin
    TimerMsg(lblMsg,Msg);
  end else if ( Value = BarMoveCancelled) then begin
    TimerMsg(lblMsg,'The Bars in the chart are made read-only. You cannot move the Bars');
  end else if ( Value = BarResizeCancelled) then begin
    TimerMsg(lblMsg,'The Bars in the chart are made read-only. You cannot resize the Bars');
  end else if ( Value = BarDeleteCancelled) then begin
    TimerMsg(lblMsg,'The Bars in the chart are made read-only. You cannot delete the Bars');
  end else if Value = BarRescheduled then begin
//    if CPGanttChart.FocusedProcItem <> nil then
//      dt:= CPGanttChart.FocusedProcItem.ProcessTimeStart else
//    dt:= 0;
    btnSave.Click;
//    if dt> 0 then CPGanttChart.ChartDate := dt;
  end;
end;

procedure TfmCapacityPlanningonGanttchart.DoOnAfterBarAdd     (Bar: TWGSGanttBar);begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnAfterBarMove    (Bar: TWGSGanttBar);begin end;
Procedure TfmCapacityPlanningonGanttchart.DoOnAfterBarMoveDetailed  (Bar : TWGSGanttBar; AFromSummaryBar:Boolean) ;begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnAfterBarResize  (Bar: TWGSGanttBar);begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnBeforeBarMove   (Bar: TWGSGanttBar;var Cancel: Boolean);begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnBeforeBarAdd    (Bar: TWGSGanttBar;var Cancel: Boolean);begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnBeforeBarDelete (Bar: TWGSGanttBar;var Cancel: Boolean);begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnBeforeBarResize (Bar: TWGSGanttBar;var Cancel: Boolean);begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnBarResize       (Bar: TWGSGanttBar;changeX: Real;  changeY: Integer; Right: Boolean; var Allowed: Boolean); begin end;
procedure TfmCapacityPlanningonGanttchart.DoOnGanttBarMove    (Bar: TWGSGanttBar;NewRow: Integer;NewStartDate: TDateTime; var Allowed: Boolean); begin end;

initialization
  RegisterClassOnce(TfmCapacityPlanningonGanttchart);

end.

