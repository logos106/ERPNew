unit ProductionOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox,
  CustomInputBox, GIFImg, wwclearbuttongroup, wwradiogroup;

type
  TProductionOrdersGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainSAleDate: TDateField;
    qryMainSaleLineId: TIntegerField;
    qryMainProduct_Description: TWideStringField;
    qryMainProduct_Description_Memo: TWideMemoField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainUnitofMeasureMultiplier: TFloatField;
    qryMainHasTree: TWideStringField;
    qryMainamountinc: TFloatField;
    btnAllocation: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    btnBOMPicking: TDNMSpeedButton;
    btnStowAway: TDNMSpeedButton;
    qryMainclassId: TIntegerField;
    qryMainProductId: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainUnitOfMeasureID: TIntegerField;
    qryMainSaleProductWeight: TFloatField;
    qryMainSaleProductLength: TFloatField;
    qryMainSaleProductVolume: TFloatField;
    qryMainQtybuilt: TFloatField;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnAllocationClick(Sender: TObject);
    procedure btnBOMPickingClick(Sender: TObject);
    procedure btnStowAwayClick(Sender: TObject);
  private
    procedure BeforeShowBOMWastageReport(Sender: TObject);
    Procedure BeforeShowmSalesLineBOMTree(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
    procedure ApplyQueryFilter; override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, BOMWastageReport, frmBOMAllocation, CommonDbLib,
  ManufactureLib, tcDataUtils, frmSalesLineBOMTree;

{$R *.dfm}
{ TProductionOrdersGUI }

procedure TProductionOrdersGUI.ApplyQueryFilter;
begin
  inherited;
  self.RefreshQuery;
end;

procedure TProductionOrdersGUI.BeforeShowBOMWastageReport(Sender: TObject);
begin
  if not(Sender is TBOMWastageReportGUI) then exit;

  TBOMWastageReportGUI(Sender).SaleId := QrymainSaleID.AsInteger;
  TBOMWastageReportGUI(Sender).SaleLineId := QrymainSaleLineId.AsInteger;
  (*if not (SameText(ActiveFieldNAme , 'SaleID')) then
    TBOMWastageReportGUI(Sender).SaleLineId := QrymainSaleLineId.AsInteger
  else TBOMWastageReportGUI(Sender).SaleLineId := 0;*)
end;

procedure TProductionOrdersGUI.btnAllocationClick(Sender: TObject);
begin
  if (QrymainSaleID.asInteger =0) or ( QrymainsaleLineID.asInteger =0) then exit;
  TfmBOMAllocation.DoAllocation(QrymainSaleID.asInteger, QrymainsaleLineID.asInteger, nil);
end;

procedure TProductionOrdersGUI.btnBOMPickingClick(Sender: TObject);
var
  strSQL:String;
  Tablename :String;
begin
  inherited;
  if (QrymainSaleID.asInteger =0) or ( QrymainsaleLineID.asInteger =0) then exit;
  tablename := GetUserTemporaryTableName('OrderPickingslip');
  MakeBOMPickingTable(inttostr(QrymainsaleLineID.asInteger), tablename);

  strSQL:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, '+
            ' CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
            ' ~|||~{details}Select * from '+tablename +' order by SeqID ';

  ReportToPrint := tcdatautils.GetDefaultReport('BOM Picking Slip');
  ReportSQLSupplied := True;
  PrintTemplateReport(ReportToPrint , StrSQL , False , 1);
  DestroyUserTemporaryTable(Tablename);
end;

procedure TProductionOrdersGUI.btnStowAwayClick(Sender: TObject);
var
  strSQL:String;
begin
  inherited;
  strSQL := '~|||~where Sl.SaleID= ' + inttostr(QrymainSaleID.asInteger);
  ReportToPrint :=tcdatautils.GetDefaultReport('Stow Away');
  if ReportToPrint = '' then ReportToPrint := 'Stow Away';
  ReportSQLSupplied := False;
  PrintTemplateReport(ReportToPrint , StrSQL , False , 1);
end;

procedure TProductionOrdersGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if QrymainHasTree.asBoolean =False then begin
    MessageDlgXP_Vista(Qrymainproductname.asString+' is not manufactured', mtInformation, [mbOK], 0);
    Exit;
  end;
  OpenERPListForm('TBOMWastageReportGUI' , BeforeShowBOMWastageReport);
end;

procedure TProductionOrdersGUI.grdMainDblClick(Sender: TObject);
begin

  if not isModalForm then begin
    if SameText(ActiveFieldNAme , 'SaleID') then begin
      if QrymainHasTree.asBoolean then begin
        OpenERPListForm('TBOMWastageReportGUI' , BeforeShowBOMWastageReport);
        Exit;
      end;
    end else if SameText(ActiveFieldNAme , qryMainUnitofMeasureShipped.fieldname) then
      if QrymainHasTree.asBoolean then begin
        OpenERPForm('TfmSalesLineBOMTree' , 0 , nil , BeforeShowmSalesLineBOMTree);
        Exit;
      end;
  end;
  inherited;
end;
Procedure TProductionOrdersGUI.BeforeShowmSalesLineBOMTree(Sender: TObject);
begin
  if not(Sender is TfmSalesLineBOMTree) then exit;
  TfmSalesLineBOMTree(Sender).SaleLineID := QrymainSaleLineID.asInteger;
end;
procedure TProductionOrdersGUI.RefreshQuery;
begin
  Qrymain.ParamByName('Datefrom').AsDateTime := FilterDateFrom;
  Qrymain.ParamByName('DateTo').AsDateTime := FilterDateTo;
  if grpFilters.ItemIndex = 0 then
    Qrymain.ParamByName('IncludeInternalOrders').AsString := 'T'
  else
    Qrymain.ParamByName('IncludeInternalOrders').AsString := 'F';

  inherited;
end;

procedure TProductionOrdersGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainSaleLineId.fieldname);
  RemoveFieldfromGrid(QrymainClassId.fieldname);
  RemoveFieldfromGrid(QrymainProductID.fieldname);
  RemoveFieldfromGrid(QrymainclientID.fieldname);
  RemoveFieldfromGrid(qryMainUnitOfMeasureID.fieldname);
end;

initialization
  RegisterClassOnce(TProductionOrdersGUI);

end.

