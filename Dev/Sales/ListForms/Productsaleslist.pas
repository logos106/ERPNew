unit Productsaleslist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DAScript, MyScript, ERPdbComponents, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductsaleslistsGUI = class(TBaseListingGUI)
    qryMainsaleLineID: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMainCustomerName: TWideStringField;
    qryMainsalestype: TWideStringField;
    qryMainproductname: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainsAledate: TDatetimeField;
    qryMainUOM: TWideStringField;
    pnlclientfilter: TDNMPanel;
    lblclientFilter: TLabel;
    chkclientfilter: TwwCheckBox;
    pnlProductFilter: TDNMPanel;
    lblProductfilter: TLabel;
    chkProdutfilter: TwwCheckBox;
    qryMainContactName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainQtysold: TFloatField;
    qryMainShipped: TFloatField;
    procedure chkProdutfilterClick(Sender: TObject);
    procedure chkclientfilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fiProductID :Integer;
    fiClientID :Integer;
    fiClassId: Integer;
    procedure SetProductID(const Value: Integer);
    procedure SetClientID(const Value: Integer);
    procedure SetClassId(const Value: Integer);
    procedure MakeQrymain;
  Protected
    procedure SetGridColumns; override;
    Procedure REfreshTotals;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Property ProductID :Integer read fiProductID write SetProductID;
    Property ClassId :Integer read fiClassId write SetClassId;
    Property ClientID :Integer read fiClientID write SetClientID;
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, tcConst, tcDataUtils, AppEnvironment, ProductQtyLib;

{$R *.dfm}

{ TProductsaleslistsGUI }

procedure TProductsaleslistsGUI.chkclientfilterClick(Sender: TObject);begin  inherited;  if screen.ActiveControl = Sender then RefreshQuery;end;
procedure TProductsaleslistsGUI.chkProdutfilterClick  (Sender: TObject);begin  inherited;  if screen.ActiveControl = Sender then RefreshQuery;end;
Procedure TProductsaleslistsGUI.MakeQrymain;
begin
  Qrymain.sql.clear;
  Qrymain.sql.add('Select');
  Qrymain.sql.add('SL.saleLineID as saleLineID,');
  Qrymain.sql.add('S.SaleId as SaleId,');
  Qrymain.sql.add('S.CustomerName as CustomerName ,');
  Qrymain.sql.add('S.ContactName as ContactName,');
  Qrymain.sql.add(SaleType+' as salestype ,');
  Qrymain.sql.add('SL.productname as productname,');
  Qrymain.sql.add('P.ProductPrintName as ProductPrintName,');
  Qrymain.sql.add('SL.UnitofMeasureQtySold as UnitofMeasureQtySold ,');
  Qrymain.sql.add('SL.UnitofMeasureShipped  as UnitofMeasureShipped ,');
  Qrymain.sql.add('SL.QtySold as QtySold ,');
  Qrymain.sql.add('SL.Shipped as Shipped ,');
  Qrymain.sql.add('S.sAledatetime as SaleDate,');
  Qrymain.sql.add('concat(SL.UnitofMeasureSaleLines ,  " (" , SL.UnitofMeasureMultiplier , ")") as UOM');
  Qrymain.sql.add('from tblsales S');
  Qrymain.sql.add('inner join tblsaleslines SL using (SaleID)');
  Qrymain.sql.add('inner join tblparts P on P.partsId = Sl.productId');
  Qrymain.sql.add('where (S.IsInvoice ="T" or S.issalesorder="T" or S.IsCashSAle="T" or S.ISPOS ="T" or S.IsRefund ="T") and SL.Invoiced ="T" and S.Deleted="F" and Cancelled ="F" and S.converted ="F"');
  Qrymain.sql.add('and (S.clientID =:ClientID or :ClientID=0)');
  Qrymain.sql.add('and (SL.ProductID =:ProductID or :ProductID=0)');
  Qrymain.sql.add('and (S.ClassID =:ClassID or :ClassID=0)');
  Qrymain.sql.add('and S.sAledatetime between :DateFrom and :DateTo');
  Qrymain.sql.add('order by SaleId, productName');
end;
procedure TProductsaleslistsGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  SelectionOption :=soClassnProduct;
  AddCalcColumn(qryMainUnitofMeasureQtySold.fieldname, false);
  AddCalcColumn(qryMainUnitofMeasureShipped.fieldname, false);
  AddCalcColumn(qryMainQtysold.fieldname, false);
  AddCalcColumn(qryMainShipped.fieldname, false);

end;
procedure TProductsaleslistsGUI.RefreshQuery;
begin
  Qrymain.parambyname('dateFrom').asDatetime  := FilterDatefrom;
  Qrymain.parambyname('dateTo').asDatetime    := FilterDateTo;
  if (pnlclientfilter.visible ) and (chkclientfilter.checked) and (ClientID<>0) then
        Qrymain.parambyname('clientID').asInteger   := clientID
  else  Qrymain.parambyname('clientID').asInteger   := 0;

  if SelectedProductId<> 0 then
    Qrymain.parambyname('ProductID').asInteger  := SelectedProductId
  (*else if (pnlProductFilter.visible ) and (chkProdutfilter.checked) and (ProductID<>0) then
        Qrymain.parambyname('ProductID').asInteger  := ProductID*)
  else  Qrymain.parambyname('ProductID').asInteger  := 0;

  if SelectedClassId<> 0 then
    Qrymain.parambyname('ClassId').asInteger  := SelectedClassId
  else  Qrymain.parambyname('ClassId').asInteger  := 0;

  inherited;
end;

procedure TProductsaleslistsGUI.REfreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TProductsaleslistsGUI.SetClassId(const Value: Integer);
begin
  fiClassId := Value;
  if not GuiPrefs.active then GuiPrefs.ACtive := true;
  GuiPrefs.Node['Options.DEfaultSelectedClassId'].AsInteger := Value;
end;

procedure TProductsaleslistsGUI.SetClientID(const Value: Integer);
begin
  fiClientID := Value;
  pnlclientfilter.visible := Value <>0;
  chkclientfilter.Checked:= Value <>0;
  if Value <> 0 then
    lblclientFilter.caption := 'List of Customer' + NL +
                                tcdatautils.getClientName(Value);
end;

procedure TProductsaleslistsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainsaleLineID.FieldName);
end;

procedure TProductsaleslistsGUI.SetProductID(const Value: Integer);
begin
  fiProductID := Value;
  if not GuiPrefs.active then GuiPrefs.ACtive := true;
  GuiPrefs.Node['Options.DEfaultSelectedProductID'].AsInteger := Value;
  //pnlProductFilter.visible := Value <>0;
  //chkProdutfilter.Checked:= Value <>0;
  //if Value <> 0 then
  //  lblProductfilter.caption := 'List of ' + AppEnv.DefaultClass.PartColumn + NL +
  //                             tcdatautils.getproduct(Value);
end;

procedure TProductsaleslistsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.DEfaultSelectedProductID'].AsInteger  := SelectedProductId;
  GuiPrefs.Node['Options.Dateto'].asDatetime := FilterDateto;
  GuiPrefs.Node['Options.DateFrom'].asDatetime := FilterDateFrom;
end;

procedure TProductsaleslistsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if not fbDateRangeSupplied then begin
    if GuiPrefs.Node.Exists('Options.DEfaultSelectedProductID') then
      ProductId := GuiPrefs.Node['Options.DEfaultSelectedProductID'].AsInteger;
    dtfrom.date := 0;
    if GuiPrefs.Node.Exists('Options.Dateto') then
      dtto.date:=  GuiPrefs.Node['Options.Dateto'].asDatetime;
    if GuiPrefs.Node.Exists('Options.DateFrom') then
      dtfrom.date:=  GuiPrefs.Node['Options.DateFrom'].asDatetime;
    fbDateRangeSupplied := GuiPrefs.Node.Exists('Options.Dateto');
  end;
end;


initialization
  RegisterClassOnce(TProductsaleslistsGUI);

end.

