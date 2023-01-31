unit BOMDailyProcessSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TBOMDailyProcessSalesGUI = class(TBaseListingGUI)
    qryMainsaleID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainsaledate: TDateField;
    qryMainShipped: TFloatField;
    qryMainProcessstep: TWideStringField;
    pnlshowScheduled: TDNMPanel;
    lblshowScheduled: TLabel;
    chkshowScheduled: TwwCheckBox;
    qryMainScheduled: TWideStringField;
    btnSchedule: TDNMSpeedButton;
    qryMainSaleLineId: TIntegerField;
    qryMainCheckAvailability: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure chkshowScheduledClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnScheduleClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  private
    aScheduleFromDate :TDateTime;
    function showScheduled: Boolean;
    procedure initBOMPLanner(Sender: TObject);
    procedure initBOMDailyProcessResourceAvailability(Sender: TObject);
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonDbLib, CommonLib, SystemLib, BOMDailyProcessLib, ProcessUtils,
  frmBOMPlanner, CommonFormLib, BOMDailyProcessResourceAvailability;

{$R *.dfm}

procedure TBOMDailyProcessSalesGUI.btnScheduleClick(Sender: TObject);
var
  salesLineIds:String;
begin
  inherited;
  IterateProcno := 1;
  IterateselectedRecordsReverse;
  if SelectedRecords =0 then begin
    MessageDlgXP_Vista('Please Select Un-scheduled Jobs to Schedule ', mtInformation, [mbOK], 0);
    Exit;
  end else if MessageDlgXP_Vista('Do You wish to Schedule '+ inttostr(SelectedRecords)+' Jobs Selected?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  salesLineIds:= SelectedIDs(qryMainSaleLineId.fieldname, true);
  if salesLineIds = '' then begin
    MessageDlgXP_Vista('Please Choose Orders to Schedule', mtInformation, [mbOK], 0);
    Exit;
  end;

  if TBOMDAilyProcessObj.AutoSchedule(self, SalesLineIDs , aScheduleFromDate) then begin
    RefreshQuery;
    openERPForm('TfmBOMPlanner' , 0, nil, initBOMPLanner);
  end;
end;
procedure TBOMDailyProcessSalesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
  inherited;
  if iterateprocno = 1 then begin
    if Qrymainscheduled.asBoolean then
      grdmain.unselectrecord;
  end;
end;
procedure TBOMDailyProcessSalesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainCheckAvailability.asString := '[CTRL+Click for Availability]';
end;

procedure TBOMDailyProcessSalesGUI.initBOMPLanner(Sender: TObject);
begin
  if sender is TfmBOMPlanner then begin
    //TfmBOMPlanner(Sender).ShowInWeekForm(aScheduleFromDate);
    TfmBOMPlanner(Sender).ShowInMonthForm(aScheduleFromDate);
  end;
end;
procedure TBOMDailyProcessSalesGUI.chkshowScheduledClick(Sender: TObject);
begin
  inherited;
  if chkshowScheduled.Focused then Refreshquery;
end;

procedure TBOMDailyProcessSalesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  grpfilters.itemindex := 3;
  HaveDateRangeSelection := False;
end;

procedure TBOMDailyProcessSalesGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('Select Items to Schedule');
end;

procedure TBOMDailyProcessSalesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
        if (grpfilters.itemindex=0) and (sametext(Field.fieldname,QrymainsaleID.fieldname) OR
                                         sametext(Field.fieldname,QrymainsaleDate.fieldname) OR
                                         sametext(Field.fieldname,qryMainProcessstep.fieldname)) then AFont.color := Abrush.color
  else  if (grpfilters.itemindex=1) and (sametext(Field.fieldname,QrymainsaleID.fieldname) OR
                                         sametext(Field.fieldname,qryMainProcessstep.fieldname)) then AFont.color := Abrush.color
  else  if (grpfilters.itemindex=2) and (sametext(Field.fieldname,QrymainsaleID.fieldname) OR
                                         sametext(Field.fieldname,QrymainProductName.fieldname) OR
                                         sametext(Field.fieldname,qryMainProcessstep.fieldname)) then AFont.color := Abrush.color;

end;

procedure TBOMDailyProcessSalesGUI.grdMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if  Sametext(ActiveFieldname,qryMainCheckAvailability.Fieldname) and  (ssCtrl in Shift) and (ssLeft in shift) then begin
    OpenERPListFormModal('TBOMDailyProcessResourceAvailabilityGUI', nil , initBOMDailyProcessResourceAvailability);
  end;
end;
procedure TBOMDailyProcessSalesGUI.initBOMDailyProcessResourceAvailability(Sender: TObject);
begin
  if sender is TBOMDailyProcessResourceAvailabilityGUI then begin
    TBOMDailyProcessResourceAvailabilityGUI(Sender).ProductId := qryMainProductID.asInteger
  end;
end;
procedure TBOMDailyProcessSalesGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
  Refreshquery;
end;

Function TBOMDailyProcessSalesGUI.showScheduled :Boolean;
begin
   Result := chkshowScheduled.checked;
end;
procedure TBOMDailyProcessSalesGUI.RefreshQuery;
begin
  closedb(qrymain);
  Qrymain.SQL.Clear;
  SalesListSQL(qrymain.SQL, '' , showScheduled);
  case grpfilters.itemindex of
    0: begin {by product}
        Qrymain.SQL.add('Group by SL.ProductID');
        Qrymain.SQL.add('ORDER BY ProductName ');
    end;
    1: begin {by SaleDate n Product}
        Qrymain.SQL.add('Group by S.SaleDate, SL.ProductID');
        Qrymain.SQL.add('ORDER BY SaleDate DESC, Productname');
    end;
    2: begin {by colour Seq}
        Qrymain.SQL.add('Group by PRPR.seqno');
        Qrymain.SQL.add('ORDER BY seqno');
    end;
    3: begin {Default}
        Qrymain.SQL.add('Group by sl.salelineId, S.SaleDate, SL.ProductID');
        Qrymain.SQL.add('ORDER BY SaleDate DESC, Productname');
    end;
  end;
  RefreshOrignalSQL(False);
  inherited;
end;
procedure TBOMDailyProcessSalesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainSaleLineId.fieldname);
  RemoveFieldfromGrid(qryMainProductId.fieldname);
end;

procedure TBOMDailyProcessSalesGUI.ReadnApplyGuiPrefExtra;
begin
    if GuiPrefs.Node.Exists('Options.showScheduled') then
      chkshowScheduled.Checked :=  GuiPrefs.Node['Options.showScheduled'].asBoolean;
end;
Procedure TBOMDailyProcessSalesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.showScheduled'].asBoolean := chkshowScheduled.Checked;
end;


initialization
  RegisterClassOnce(TBOMDailyProcessSalesGUI);

end.
