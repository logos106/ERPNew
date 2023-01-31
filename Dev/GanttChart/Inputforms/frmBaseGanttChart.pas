unit frmBaseGanttChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMSpeedButton, Shader, StdCtrls, wwdbdatetimepicker, DNMPanel,
  wgsGanttEntities, wgsController, wgsGanttGraph, wgsDataSource , ObjGanttChart, wgsCalendar,
  Spin , wgsGanttBar ,frmCapacityPlanningbase, ActnList, wwclearbuttongroup,
  wwradiogroup, wwcheckbox, ProgressDialog , wgsTreeHeaderCell;

type
  TfmBaseGanttChart = class(TfmCapacityPlanningbase)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    GanttGraph: TWGSGanttGraph;
    QryMaster: TERPQuery;
    dsMaster: TDataSource;
    QryDetails: TERPQuery;
    DataSource1: TDataSource;
    Datasource: TWGSDataSource;
    DNMPanel2: TDNMPanel;
    grpTimeMode: TRadioGroup;
    spincolWidth: TSpinEdit;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure grpTimeModeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlTopDblClick(Sender: TObject);
    procedure spincolWidthChange(Sender: TObject);
    procedure GanttGraphTreeCellMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GanttGraphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GanttGraphDblClick(Sender: TObject);

  private
    fbEnableDecadeMode: boolean;
    fbEnableDayMode: boolean;
    fbEnableMonthMode: boolean;
    fbEnableWeekMode: boolean;
    fbEnableHourMode: boolean;
    fbEnableQuarterMode: boolean;
    fbEnableYearMode: boolean;

    function getShowTimeModeOptions: Boolean;
    procedure setShowTimeModeOptions(const Value: Boolean);
    procedure setEnableDayMode(const Value: boolean);
    procedure setEnableDecadeMode(const Value: boolean);
    procedure setEnableHourMode(const Value: boolean);
    procedure setEnableMonthMode(const Value: boolean);
    procedure setEnableQuarterMode(const Value: boolean);
    procedure setEnableWeekMode(const Value: boolean);
    procedure setEnableYearMode(const Value: boolean);
    procedure setEnableMode(Value: Boolean; var EnableMode: Boolean;ItemText: String; TimeMode: TWGSTimeMode);

  Protected
    GanttChart: TGanttChart;
    TreeCellSelected:Boolean;
    function RefreshGridEvent(fieldName: String): String;Virtual;
    Procedure AddFixedcol(FieldName:String;ColName: String;colwidth:Integer=80);
    function RefreshGrid:boolean; Override;
    Procedure LoadGrid; Override;
    procedure RefreshQuery;virtual;
    Procedure DoOnAfterBarResize        (Bar : TWGSGanttBar) ;Virtual;
    Procedure DoOnAfterBarAdd           (Bar : TWGSGanttBar) ;Virtual;
    Procedure DoOnAfterBarMove          (Bar : TWGSGanttBar) ;Virtual;
    Procedure DoOnAfterBarMoveDetailed  (Bar : TWGSGanttBar; AFromSummaryBar:Boolean) ;Virtual;
    Procedure DoOnAfterBarDelete        (Bar : TWGSGanttBar) ;Virtual;
    Procedure DoOnBeforeBarMove         (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
    Procedure DoOnBeforeBarDelete       (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
    Procedure DoOnBeforeBarResize       (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
    Procedure DoOnBeforeBarAdd          (Bar : TWGSGanttBar; var Cancel : Boolean);Virtual;
    Procedure DoOnBarResize             (Bar : TWGSGanttBar; changeX : Real; changeY : Integer; Right : Boolean; var Allowed : Boolean) ;Virtual;
    Procedure DoOnGanttBarMove          (Bar : TWGSGanttBar; NewRow : Integer; NewStartDate : TDateTime; var Allowed : Boolean);Virtual;
    Procedure DoOnTreeColumnMove(column:TWGSTreeHeaderCell;width : integer);virtual;
    procedure DoGanttChartEvent(const Sender: TObject; const Value,Msg: string) ;virtual;
    Procedure WriteGuiPrefs;Override;
    Procedure Readguiprefs;Override;
    procedure GanttGraphTreeCellDblClick(Sender: TObject); virtual;
  public
    Property ShowTimeModeOptions  :Boolean read getShowTimeModeOptions  write setShowTimeModeOptions;
    Property EnableHourMode       :boolean read fbEnableHourMode        write setEnableHourMode;
    Property EnableDayMode        :boolean read fbEnableDayMode         write setEnableDayMode;
    Property EnableWeekMode       :boolean read fbEnableWeekMode        write setEnableWeekMode;
    Property EnableMonthMode      :boolean read fbEnableMonthMode       write setEnableMonthMode;
    Property EnableQuarterMode    :boolean read fbEnableQuarterMode     write setEnableQuarterMode;
    Property EnableYearMode       :boolean read fbEnableYearMode        write setEnableYearMode;
    Property EnableDecadeMode     :boolean read fbEnableDecadeMode      write setEnableDecadeMode;

    function DateFrom:TDateTime;
    function Dateto:TDateTime;
  end;


implementation

uses Dateutils , BusObjProcPrefs;


{$R *.dfm}

procedure TfmBaseGanttChart.AddFixedcol(FieldName:String;ColName: String; colwidth: Integer );
begin
  GanttChart.AddFixedcol(FieldName, colName ,Colwidth  );
end;

procedure TfmBaseGanttChart.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

function TfmBaseGanttChart.DateFrom: TDateTime;
begin
  if edtDateFrom.Date =0 then edtDateFrom.Date := Date;
  result := edtDateFrom.Date;
end;

function TfmBaseGanttChart.Dateto: TDateTime;
begin
  REsult := incWeek(DateFrom , ProcPrefs.CapacityPlanningWeeksToShow);
  if result =0 then result := incmonth(DateFrom , 1);
end;

procedure TfmBaseGanttChart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPrefs;
  inherited;
  Action := caFree;
end;

procedure TfmBaseGanttChart.FormCreate(Sender: TObject);
begin
  inherited;
  TreeCellSelected:= False;
  grpTimeMode.Items.Clear;

  if not Assigned(GanttChart) then
    GanttChart:= TGanttChart.create(Self, GanttGraph , Datasource , QryMaster, RefreshGridEvent);

  GanttChart.GanttChartEvent          :=DoGanttChartEvent;
  GanttChart.OnAfterBarAdd             :=doOnAfterBarAdd;
  GanttChart.OnAfterBarDelete          :=doOnAfterBarDelete;
  GanttChart.OnBarResize               :=doOnBarResize;
  GanttChart.OnGanttBarMove            :=DoOnGanttBarMove;
  GanttChart.OnAfterBarResize          :=DoOnAfterBarResize;
  GanttChart.OnAfterBarMove            :=DoOnAfterBarMove;
  GanttChart.OnAfterBarMoveDetailed    :=DoOnAfterBarMoveDetailed;
  GanttChart.OnTreeColumnMove          :=DoOnTreeColumnMove;
  GanttChart.OnBeforeBarMove           :=DoOnBeforeBarMove;
  GanttChart.OnBeforeBarDelete         :=DoOnBeforeBarDelete;
  GanttChart.OnBeforeBarResize         :=DoOnBeforeBarResize;
  GanttChart.OnBeforeBarAdd            :=DoOnBeforeBarAdd;
  InitialiseForm;
  //UserFilterOptions;
  //edtDateFrom.date := Date;
end;

procedure TfmBaseGanttChart.FormShow(Sender: TObject);
begin
  inherited;
  //GuiPrefs.Active:= True;

  if grpTimeMode.ItemIndex <0 then
    if GuiPrefs.Node.Exists('Options.TimeMode') then
      grpTimeMode.ItemIndex :=GuiPrefs.Node['Options.TimeMode'].AsInteger
    else grpTimeMode.ItemIndex := 0;

  //REadguiprefs;
  RefreshGrid;
  GanttGraph.Hint := 'Please Double click on the ''Nr'' Column to move to the Allocation of the Process on the line';
  GanttGraph.ShowHint := true;

end;

procedure TfmBaseGanttChart.GanttGraphDblClick(Sender: TObject);
begin
  inherited;
  if TreeCellSelected then
    GanttGraphTreeCellDblClick(sender);

end;
procedure TfmBaseGanttChart.GanttGraphTreeCellDblClick(Sender: TObject);
begin

end;

procedure TfmBaseGanttChart.GanttGraphMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TreeCellSelected:= False;
end;


procedure TfmBaseGanttChart.GanttGraphTreeCellMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TreeCellSelected:=true;
end;

procedure TfmBaseGanttChart.grpTimeModeClick(Sender: TObject);
var
  colWidth:Integer;
begin
  inherited;
       if SameText(grpTimeMode.Items[grpTimeMode.itemindex], 'Hour'   ) then GanttChart.TimeMode := tmHour
  else if SameText(grpTimeMode.Items[grpTimeMode.itemindex], 'Day'    ) then GanttChart.TimeMode := tmDay
  else if SameText(grpTimeMode.Items[grpTimeMode.itemindex], 'Week'   ) then GanttChart.TimeMode := tmWeek
  else if SameText(grpTimeMode.Items[grpTimeMode.itemindex], 'Month'  ) then GanttChart.TimeMode := tmMonth
  else if SameText(grpTimeMode.Items[grpTimeMode.itemindex], 'Quarter') then GanttChart.TimeMode := tmQuarter
  else if SameText(grpTimeMode.Items[grpTimeMode.itemindex], 'Year'   ) then GanttChart.TimeMode := tmYear
  else if SameText(grpTimeMode.Items[grpTimeMode.itemindex], 'Decade' ) then GanttChart.TimeMode := tmDecade
  else GanttChart.TimeMode := tmNone;
  colWidth := GuiPrefs.Node['Options.'+ GanttChart.StringTimeMode +'.columnwidth'].AsInteger;
  if colWidth>0 then GanttChart.Graphcolumnwidth := colwidth else GanttChart.SetDefaultcolumnwidth;
  GanttChart.Repaint;
  SpinColWidth.Value := GanttChart.GraphColumnWidth;
end;
procedure TfmBaseGanttChart.LoadGrid;
begin
  RefreshGrid;
end;

procedure TfmBaseGanttChart.pnlTopDblClick(Sender: TObject);
begin
  inherited;
  (*if not(SpinColWidth.Visible) then begin
    SpinColWidth.Visible := true;
    SpinColWidth.Value := GanttChart.GraphColumnWidth;
  end else begin
    SpinColWidth.Visible := False;
    GuiPrefs.Node['Options.'+ GanttChart.StringTimeMode +'.columnwidth'].AsInteger := SpinColWidth.Value;
  end;*)
  GuiPrefs.Node['Options.'+ GanttChart.StringTimeMode +'.columnwidth'].AsInteger := SpinColWidth.Value;
end;

procedure TfmBaseGanttChart.Readguiprefs;
begin
  inherited;
//  if GuiPrefs.Node.Exists('Options.DateFrom') then edtDateFrom.Date :=GuiPrefs.Node['Options.DateFrom'].AsDatetime;
  if GuiPrefs.Node.Exists('Options.TimeMode') then
    grpTimeMode.ItemIndex :=GuiPrefs.Node['Options.TimeMode'].AsInteger;
end;

function TfmBaseGanttChart.RefreshGrid:Boolean;
begin
    RefreshQuery;
    GanttChart.RefreshChart;
    Result := TRue;
end;

function TfmBaseGanttChart.RefreshGridEvent(FieldName: String): String;
begin

end;

procedure TfmBaseGanttChart.RefreshQuery;
begin

end;

procedure TfmBaseGanttChart.setEnableMode(Value:Boolean; var EnableMode:Boolean; ItemText:String; TimeMode: TWGSTimeMode);
begin
  EnableMode := Value;
  if Value then begin
    if  (grpTimeMode.Items.IndexOf(ItemText) <0) then begin
      grpTimeMode.Items.Add(ItemText)   ;
      GanttChart.InsertScale(TimeMode)   ;
    end;
  end else begin
    if  (grpTimeMode.Items.IndexOf(ItemText)>=0) then
      grpTimeMode.items.Delete(grpTimeMode.Items.IndexOf(ItemText));
  end;
  grpTimeMode.columns := grpTimeMode.Items.Count;
end;

procedure TfmBaseGanttChart.setEnableHourMode   (const Value: boolean);begin  setEnableMode(Value,fbEnableHourMode    ,'Hour'   ,tmHour)   ;end;
procedure TfmBaseGanttChart.setEnableDayMode    (const Value: boolean);begin  setEnableMode(Value,fbEnableDayMode     ,'Day'    ,tmDay)    ;end;
procedure TfmBaseGanttChart.setEnableWeekMode   (const Value: boolean);begin  setEnableMode(Value,fbEnableWeekMode    ,'Week'   ,tmWeek)   ;end;
procedure TfmBaseGanttChart.setEnableMonthMode  (const Value: boolean);begin  setEnableMode(Value,fbEnableMonthMode   ,'Month'  ,tmMonth)  ;end;
procedure TfmBaseGanttChart.setEnableQuarterMode(const Value: boolean);begin  setEnableMode(Value,fbEnableQuarterMode ,'Quarter',tmQuarter);end;
procedure TfmBaseGanttChart.setEnableYearMode   (const Value: boolean);begin  setEnableMode(Value,fbEnableYearMode    ,'Year'   ,tmYear)   ;end;
procedure TfmBaseGanttChart.setEnableDecadeMode (const Value: boolean);begin  setEnableMode(Value,fbEnableDecadeMode  ,'Decade' ,tmDecade) ;end;

function TfmBaseGanttChart.getShowTimeModeOptions: Boolean;begin  REsult := grpTimeMode.Visible;end;
procedure TfmBaseGanttChart.setShowTimeModeOptions(const Value: Boolean);begin  grpTimeMode.Visible := Value;end;
procedure TfmBaseGanttChart.spincolWidthChange(Sender: TObject);
begin
  inherited;
  if spincolWidth.Value <=0 then exit;
  GanttChart.GraphColumnWidth :=spincolWidth.Value;
end;

procedure TfmBaseGanttChart.WriteGuiPrefs;
begin
//  GuiPrefs.Node['Options.DateFrom'].AsDatetime := edtDateFrom.Date;
  GuiPrefs.Node['Options.TimeMode'].AsInteger := grpTimeMode.ItemIndex;
  GuiPrefs.Node['Options.'+ GanttChart.StringTimeMode +'.columnwidth'].AsInteger := SpinColWidth.Value;
  inherited;
end;
procedure TfmBaseGanttChart.doOnAfterBarDelete(Bar: TWGSGanttBar);begin end;
procedure TfmBaseGanttChart.DoGanttChartEvent(const Sender: TObject;  const Value,MSg: string);
begin

end;

procedure TfmBaseGanttChart.doOnAfterBarAdd(Bar: TWGSGanttBar);begin end;
procedure TfmBaseGanttChart.DoOnAfterBarMove(Bar: TWGSGanttBar);begin end;
procedure TfmBaseGanttChart.DoOnAfterBarMoveDetailed(Bar: TWGSGanttBar;  AFromSummaryBar: Boolean);begin end;
procedure TfmBaseGanttChart.DoOnTreeColumnMove(column:TWGSTreeHeaderCell;width : integer); begin end;
procedure TfmBaseGanttChart.DoOnAfterBarResize(Bar: TWGSGanttBar);begin end;
procedure TfmBaseGanttChart.DoOnBarResize(Bar: TWGSGanttBar; changeX: Real;  changeY: Integer; Right: Boolean; var Allowed: Boolean); begin end;
procedure TfmBaseGanttChart.DoOnBeforeBarAdd(Bar: TWGSGanttBar; var Cancel: Boolean);begin end;
procedure TfmBaseGanttChart.DoOnBeforeBarDelete(Bar: TWGSGanttBar;var Cancel: Boolean);begin end;
procedure TfmBaseGanttChart.DoOnBeforeBarMove(Bar: TWGSGanttBar; var Cancel: Boolean);begin end;
procedure TfmBaseGanttChart.DoOnBeforeBarResize(Bar: TWGSGanttBar;var Cancel: Boolean);begin end;
procedure TfmBaseGanttChart.DoOnGanttBarMove(Bar: TWGSGanttBar; NewRow: Integer;NewStartDate: TDateTime; var Allowed: Boolean); begin end;


end.

