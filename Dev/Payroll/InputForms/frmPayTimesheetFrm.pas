unit frmPayTimesheetFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmPayTimesheet = class(TBaseListingGUI)
    qryMainTimesheetEntryID: TIntegerField;
    qryMainEntryDate: TDateTimeField;
    qryMainType: TWideStringField;
    qryMainWhoEntered: TWideStringField;
    qryMainTimesheetDate: TDateTimeField;
    qryMainHours: TFloatField;
    qryMainJob: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainTotal: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainLabourCost: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainServiceName: TWideStringField;
    qryMainServiceDate: TDateField;
    qryMainChargeRate: TFloatField;
    qryMainPartName: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainUseTimeCost: TWideStringField;
    qryMainTax: TFloatField;
    qryMainPayRateTypeName: TWideStringField;
    qryMainHourlyRate: TFloatField;
    qryMainSuperInc: TWideStringField;
    qryMainSuperAmount: TFloatField;
    qryMainSalesID: TIntegerField;
    qryMainNotes: TWideMemoField;
    qryMainQty: TFloatField;
    qryMainEquipment: TWideStringField;
    qryMainTotalServicecharge: TFloatField;
    qryMainAppointmentID: TIntegerField;
    qryMainContactName: TWideStringField;
    qryMainRepairDocNo: TWideStringField;
    GrpOptions: TRadioGroup;
    qryMainDetails: TLargeintField;
    qryMainArea: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainDoneStatus: TWideStringField;
    qryMainApproved: TWideStringField;
    pnlSalesTimeSheets: TDNMPanel;
    Label1: TLabel;
    chkHideSalesEntries: TwwCheckBox;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure GrpOptionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); Override;
    procedure chkHideSalesEntriesClick(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure DoShowLookuplist; override;
    Procedure SetGridColumns;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetupFormInPanel; Override;
  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

implementation

uses
  CommonLib, DateUtils;

{$R *.dfm}

procedure TfrmPayTimesheet.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryMainDetails.AsInteger = 1 then begin
    if grpFilters.itemindex = 1 then AFont.Style := AFont.Style + [fsBold] else AFont.Style := AFont.Style - [fsBold];
  end else if Sametext(field.fieldname , QrymainTimesheetEntryID.FieldName) or
          Sametext(field.fieldname , QrymainEntryDate.FieldName) or
          Sametext(field.fieldname , QrymainType.FieldName) or
          Sametext(field.fieldname , QrymainWhoEntered.FieldName) then
    Afont.Color := ABrush.Color;
end;

procedure TfrmPayTimesheet.grdMainDblClick(Sender: TObject);
begin
  if sametext(qryMainType.AsString , 'WorkOrder') then SubsequentID := Chr(95) + qryMainType.AsString else SubsequentID := '';
  inherited;

end;

procedure TfrmPayTimesheet.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  if grpFilters.ItemIndex =0 then GroupFilterString := 'Details = 1' ;
  inherited;
end;

procedure TfrmPayTimesheet.GrpOptionsClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmPayTimesheet.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
      inherited;
      if GuiPrefs.Node.Exists('GrpOptions') then begin
        x := GuiPrefs.Node['GrpOptions.ItemIndex'].asInteger;
        if x > 0 then if GrpOptions.Items.Count >= x then GrpOptions.ItemIndex := x - 1;
      end;
end;

procedure TfrmPayTimesheet.RefreshQuery;
begin

  Qrymain.Params.parambyname('All'). asString := 'F';
  if GrpOptions.ItemIndex = 0 then Qrymain.Params.parambyname('Active'). asString := 'T'
  else if GrpOptions.ItemIndex = 1 then Qrymain.Params.parambyname('Active'). asString := 'F'
  else begin
    Qrymain.Params.parambyname('Active'). asString := 'T';
    Qrymain.Params.parambyname('All'). asString := 'T';
  end;
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('xFrom').AsDateTime := 0;
    qryMain.Params.ParamByName('xTo').AsDateTime := DateUtils.IncYear(now, 1000);
  end
  else begin
    qryMain.Params.ParamByName('xFrom').AsDateTime := dtFrom.DateTime;
    qryMain.Params.ParamByName('xTo').AsDateTime := dtTo.DateTime;
  end;
  inherited;
end;


procedure TfrmPayTimesheet.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainDetails.FieldName);
end;


procedure TfrmPayTimesheet.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['GrpOptions.ItemIndex'].asInteger := GrpOptions.ItemIndex + 1;
end;

procedure TfrmPayTimesheet.chkHideSalesEntriesClick(Sender: TObject);
begin
  inherited;
  if chkhidesalesentries.Checked then begin
    AddfilterString( 'SalesID  = 0');
    RefreshQuery;
  end;
end;

procedure TfrmPayTimesheet.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPayTimesheet.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPayTimesheet.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPayTimesheet.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmPayTimesheet.DoShowLookuplist;
begin
  inherited;
  Self.Caption := 'Manufacture Timesheet';
  FilterString := 'type = "Manufacture"';
end;





procedure TfrmPayTimesheet.FormCreate(Sender: TObject);
begin
  inherited;
  DisableSortoncolumtitleclick:= TRue;
  pnlSalesTimeSheets.Visible := devmode;
end;

procedure TfrmPayTimesheet.FormShow(Sender: TObject);
begin
  inherited;
  qryMainEntryDate.Displayformat := FormatSettings.ShortDateformat;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'jobid,ID,EmployeeID,ClassID,ServiceID,PartID,PayRateTypeID,SalesID,SaleLineID,CustomerEquipmentID,RepairID,AppointmentID,processparttimesheetID,RosterID,TypeID');
end;
procedure TfrmPayTimesheet.SetupFormInPanel;
begin
  inherited;
  GrpOptions.itemindex := 2;
  GrpOptions.visible := false;
end;

initialization
  RegisterClassOnce(TfrmPayTimesheet);
end.
