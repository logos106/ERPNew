unit BOMSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBOMSalesListGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDateTime: TDateField;
    qryMainCategory: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainstatus: TWideStringField;
    qryMaincStatus: TStringField;
    qryMainBOMProductionLine: TWideStringField;
    qryMainBOMGroupedLine: TWideStringField;
    qryMainSaleLineID: TIntegerField;
    lblhint: TLabel;
    qryMainToBeBuildQty: TFloatField;
    qryMainBuiltQty: TFloatField;
    qryMainconverted: TWideStringField;
    qryMainSaleDate: TDateField;
    btnPartialbuild: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnPartialbuildClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    procedure initProcProgressReport(Sender: TObject);
    procedure InitSalesLineID(Sender: TObject);
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery; override;
  end;

implementation

uses CommonLib, ProcessUtils, ProcProgressReport, CommonFormLib,
  FrmPartialBuild, AppEnvironment, SalesBuildAllocation;

{$R *.dfm}

procedure TBOMSalesListGUI.btnPartialbuildClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TFmPartialBuild' , 0 , InitSalesLineID, False);
end;
procedure TBOMSalesListGUI.InitSalesLineID(Sender: TObject);
begin
  if sender is TFmPartialBuild then begin
    TFmPartialBuild(Sender).SaleLineID := qrymainSaleLineId.AsInteger;
    TFmPartialBuild(Sender).ProctreeId := 0;
    TFmPartialBuild(Sender).EmployeeID := Appenv.Employee.Employeeid;
  end else if sender is TSalesBuildAllocationGUI then begin
    TSalesBuildAllocationGUI(Sender).SaleLineID := qrymainSaleLineId.AsInteger;
  end;
end;

procedure TBOMSalesListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSalesBuildAllocationGUI' , InitSalesLineID);
end;

procedure TBOMSalesListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryMainBOMGroupedLine.AsBoolean then Afont.Color := clInactiveCaption
  else if qryMainBOMProductionLine.AsBoolean then Afont.Style := Afont.Style  +[fsBold];
end;
procedure TBOMSalesListGUI.initProcProgressReport(Sender: TObject);
begin
  if not(sender is TProcProgressReportGUI) then exit;
  TProcProgressReportGUI(Sender).saleLineId := QrymainSaleLineID.asInteger;
end;
procedure TBOMSalesListGUI.grdMainDblClick(Sender: TObject);
begin
  if DoOnGridDataSelect(grdmain) then exit;

  if sametext(ActiveFieldname , qryMainManufactureUOMQty.fieldname)  then begin
    OpenERPListForm('TProcProgressReportGUI' ,initProcProgressReport);
    Exit;
  end;
  IF SameText(qryMainCategory.asString , 'Invoice') or SameText(qryMainCategory.asString , 'Quote')  then
         SubsequentID := Chr(95) +qryMainCategory.asString
  else SubsequentID := Chr(95) + 'Sales Order';
  inherited;

end;

procedure TBOMSalesListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblhint.caption := 'Double Click on ' + Quotedstr(qryMainManufactureUOMQty.DisplayLabel) +' to View Progress';
end;

procedure TBOMSalesListGUI.qryMainCalcFields(DataSet: TDataSet);
var
  s:String;
begin
  inherited;
  if qryMainBOMGroupedLine.AsBoolean  then s := 'Grouped'
  else begin
      s:= QrymainStatus.asString;
      s:= replacestr(s ,PS_NOTSCHEDULED     , ProcessPartStatusToUserStr(StrToProcessPartStatus(PS_NOTSCHEDULED)));
      s:= replacestr(s ,PS_SCHEDULED        , ProcessPartStatusToUserStr(StrToProcessPartStatus(PS_SCHEDULED)));
      s:= replacestr(s ,PS_STARTED          , ProcessPartStatusToUserStr(StrToProcessPartStatus(PS_STARTED)));
      s:= replacestr(s ,PS_COMPLETE         , ProcessPartStatusToUserStr(StrToProcessPartStatus(PS_COMPLETE)));
      s:= replacestr(s ,PS_STOPPED          , ProcessPartStatusToUserStr(StrToProcessPartStatus(PS_STOPPED)));
      s:= replacestr(s ,PS_UNKNOWN          , ProcessPartStatusToUserStr(StrToProcessPartStatus(PS_UNKNOWN)));
      s:= replacestr(s ,PS_QUALITYASSURANCE , ProcessPartStatusToUserStr(StrToProcessPartStatus(PS_QUALITYASSURANCE)));
  end;
  QrymaincStatus.asString := s;
end;

procedure TBOMSalesListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('DateFrom').AsDateTime:= FilterDateFrom;
  qryMain.Params.ParamByName('Dateto').AsDateTime:= FilterDateTo;
  inherited;
end;

procedure TBOMSalesListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Status');
  RemoveFieldfromGrid('SaleLineId');
  RemoveFieldfromGrid('mStatus');
  RemoveFieldfromGrid(qryMainBOMProductionLine.Fieldname);
  RemoveFieldfromGrid(qryMainBOMGroupedLine.Fieldname);
  RemoveFieldfromGrid(qryMainSaleDateTime.Fieldname);
end;

initialization
  RegisterClassOnce(TBOMSalesListGUI);
end.

