unit IncomingOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TIncomingOrdersList = class(TBaseListingGUI)
    qryMainSuppliername: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainsaletype: TWideStringField;
    qryMainorderdate: TDateField;
    qryMainproductname: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainuomsold: TFloatField;
    qryMainuomshipped: TFloatField;
    qryMainuomBO: TFloatField;
    qryMainReceivedDate: TDateField;
    qryMainSalePriceinc: TFloatField;
    qryMainSalePriceEx: TFloatField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainSOLLineNotes: TWideMemoField;
    qryMainReceivedOrder: TWideStringField;
    qryMainPurchaseOrderID: TIntegerField;
    lblApproval: TLabel;
    qryLastRecddate: TERPQuery;
    qryLastRecddateproductId: TIntegerField;
    qryMainLastReceivedDate: TDateField;
    qryMainproductId: TIntegerField;
    chkShowNonApproved: TCheckBox;
    qryLastRecddatereceiveddate: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    procedure FindNonApproved;
    procedure makeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, ProductQtyLib, AppEnvironment;

{$R *.dfm}

{ TIncomingOrdersList }
procedure TIncomingOrdersList.makeQrymain;
begin
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('SELECT');
  Qrymain.SQL.Add('PO.PurchaseOrderID as PurchaseOrderID,');
  Qrymain.SQL.Add('PO.Suppliername  as Suppliername  ,');
  Qrymain.SQL.Add('PL.productId as productId,');
  Qrymain.SQL.Add('S.SaleID as SaleID ,');
  Qrymain.SQL.Add('S.customername  as customername ,');
  Qrymain.SQL.Add(SaleType('S' , '')+' as saletype,');
  Qrymain.SQL.Add('CAST(PO.orderdate AS DATE) as orderdate,');
  Qrymain.SQL.Add('PL.productname as productname ,');
  Qrymain.SQL.Add('PL.Product_Description as Product_Description ,');
  Qrymain.SQL.Add('concat(PL.UnitofMeasurePOLines , "(" , PL.UnitofMeasureMultiplier , ")") as UOM,');
  Qrymain.SQL.Add('PL.UnitofMeasureQtySold as uomsold,');
  Qrymain.SQL.Add('PL.UnitofMeasureShipped as uomshipped,');
  Qrymain.SQL.Add('PL.UnitofMeasureBackorder as uomBO ,');
  Qrymain.SQL.Add('CAST(PL.ReceivedDate as DATE) as ReceivedDate,');
  Qrymain.SQL.Add('SL.LinePriceinc as SalePriceinc ,');
  Qrymain.SQL.Add('SL.LinePrice as SalePriceEx ,');
  Qrymain.SQL.Add('P.SupplierProductCode as SupplierProductCode,');
  Qrymain.SQL.Add('P.GeneralNotes  as GeneralNotes ,');
  Qrymain.SQL.Add('SOL.LineNotes SOLLineNotes ,');
  Qrymain.SQL.Add('PL.invoiced as ReceivedOrder');
  Qrymain.SQL.Add('FROM tblPurchaseLines PL');
  Qrymain.SQL.Add('Left join tblsmartorderlines SOL on SOL.SmartOrderLinesID = PL.smartOrderLineId');
  Qrymain.SQL.Add('INNER JOIN tblPurchaseOrders PO ON PO.PurchaseOrderID=PL.PurchaseOrderID');
  Qrymain.SQL.Add('inner join tblParts P on PL.productId = P.partsId');
  Qrymain.SQL.Add('Left join tblsales S on S.GlobalRef = PO.SalesGlobalref');
  Qrymain.SQL.Add('Left join tblsaleslines SL on S.saleId  = SL.saleId and SL.SaleLineID = PL.SaleLineID');
  Qrymain.SQL.Add('LEFT JOIN tblEmployees E on E.EmployeeId = PO.SOApprovedBy');
  Qrymain.SQL.Add('WHERE PO.IsPO = "T" AND PO.IsRA = "F" AND PO.IsBill = "F" AND PO.IsCredit = "F"');
  Qrymain.SQL.Add('AND PO.Deleted="F"  and PO.OrderDate Between :DAteFrom AND :DateTo');
  Qrymain.SQL.Add('AND ((:Approved = "T" AND PO.Approved = "T") OR (:Approved = "F"))');
  Qrymain.SQL.Add('Order by PurchaseOrderID desc ');

  qryLastRecddate.SQL.Clear;
  qryLastRecddate.SQL.Add('SELECT');
  qryLastRecddate.SQL.Add('PL.productId, CAST(max(receiveddate) AS DATE) as receiveddate ');
  qryLastRecddate.SQL.Add('FROM tblPurchaseLines PL');
  qryLastRecddate.SQL.Add('INNER JOIN tblPurchaseOrders PO ON PO.PurchaseOrderID=PL.PurchaseOrderID');
  qryLastRecddate.SQL.Add('WHERE PO.IsPO = "T" AND PO.IsRA = "F" AND PO.IsBill = "F" AND PO.IsCredit = "F"');
  qryLastRecddate.SQL.Add('AND PO.Deleted="F"  and PO.OrderDate Between :DAteFrom AND :DateTo');
  qryLastRecddate.SQL.Add('AND ((:Approved = "T" AND PO.Approved = "T") OR (:Approved = "F"))');
  qryLastRecddate.SQL.Add('group by productId');
end;
procedure TIncomingOrdersList.FormCreate(Sender: TObject);
begin
  makeQrymain;
  inherited;
end;

procedure TIncomingOrdersList.FormShow(Sender: TObject);
begin
  inherited;
  chkShowNonApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
end;

procedure TIncomingOrdersList.grdMainDblClick(Sender: TObject);
begin
  if (QrymainsaleId.asInteger <> 0) and (sametext(ActiveFieldname , qryMainSaleID.fieldname) or
     sametext(ActiveFieldname , qryMainsaletype.fieldname) or
     sametext(ActiveFieldname , qryMainSalePriceinc.fieldname) or
     sametext(ActiveFieldname , qryMainSalePriceEx.fieldname) or
     sametext(ActiveFieldname , qryMaincustomername.fieldname)) then
  SubsequentID := Chr(95) + qryMainSaletype.AsString;
  inherited;

end;

procedure TIncomingOrdersList.RefreshQuery;
var
  ctr:Integer;
begin
  InitDateFromnDateto;
  if AppEnv.CompanyPrefs.UseApprovalLevels then begin
    if chkShowNonApproved.Checked then qryMain.Params.ParamByName('Approved').AsString := 'F'
    else qryMain.Params.ParamByName('Approved').AsString := 'T';
  end else begin
    qryMain.Params.ParamByName('Approved').AsString := 'F';
  end;
  Closedb(qryLastRecddate);
  for ctr := 0 to  qryMain.Params.count-1 do
    try
       qryLastRecddate.Parambyname(qryMain.Params[ctr].Name).Value := qryMain.Params[ctr].Value;
    Except
      on E:Exception do begin
        if devmode then MessageDlgXP_Vista(e.Message, mtWarning, [mbOK], 0);
      end;
    end;
  Opendb(qryLastRecddate);
  inherited;
  FindNonApproved;
end;
procedure TIncomingOrdersList.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainproductId.fieldname);
end;

procedure TIncomingOrdersList.FindNonApproved;
begin
  lblApproval.Visible := AppEnv.CompanyPrefs.UseApprovalLevels ;
end;

initialization
  RegisterClassOnce(TIncomingOrdersList);

end.
