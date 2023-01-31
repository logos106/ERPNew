unit WeeklySalesreport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DAScript, MyScript, ERPdbComponents, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TWeeklySalesreportGUI = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMaincustomername: TWideStringField;
    qryMainproductname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainLinePrice: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainLineCost: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMaintotalLineCost: TFloatField;
    qryMaintotalLineCostinc: TFloatField;
    qryMainweekfrom: TDateField;
    qryMainweekto: TDateField;
    qryMainType: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainWeekno: TIntegerfield;
    Panel4: TPanel;
    lblCustomer: TLabel;
    Label4: TLabel;
    chkAllcustomer: TwwCheckBox;
    btnCustomerSelect: TDNMSpeedButton;
    btnProductSelect: TDNMSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    chkAllProducts: TwwCheckBox;
    qryMainProductPrintName: TWideStringField;
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure btnCustomerSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkAllcustomerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnProductSelectClick(Sender: TObject);
    procedure chkAllProductsClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    Selectedcustomers: TStrings;
    SelectedProducts: TStrings;

    Procedure MakeQrymain;
    function Customerfilter: String;
    function Productfilter: String;
    Procedure DoProductSelection;
    procedure onProductselect(Sender: TwwDBGrid);
    Procedure DoCustomerSelection;
    procedure OncustomerSelect(Sender: TwwDBGrid);
  Protected
    function GetReportTypeID: integer; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure SetCustomerfilter;
    Procedure SetProducthint;
  public
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, MySQLConst, CommonFormLib, ProductListExpressForm, CustomerExpressList, AppEnvironment, CommonDbLib, tcConst;

{$R *.dfm}
{ TWeeklySalesreportGUI }

Procedure TWeeklySalesreportGUI.DoCustomerSelection;
begin
  OpenERPListFormultiselectModal('TCustomerExpressListGUI' , nil , OncustomerSelect );
end;
procedure TWeeklySalesreportGUI.OncustomerSelect(Sender: TwwDBGrid);
begin
  Selectedcustomers.CommaText := TCustomerExpressListGUI(Sender.Owner).SelectedIDs('ClientID');
  if chkAllcustomer.Checked then chkAllcustomer.Checked := Selectedcustomers.count =0;
  MakeQrymain;
  RefreshQuery;
  SetCustomerfilter;
end;
procedure TWeeklySalesreportGUI.btnCustomerSelectClick(Sender: TObject);
begin
  inherited;
  DoCustomerSelection;
end;
Procedure TWeeklySalesreportGUI.DoProductSelection;
begin
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil , onProductselect );
end;
procedure TWeeklySalesreportGUI.btnProductSelectClick(Sender: TObject);
begin
  inherited;
  DoProductSelection;
end;


procedure TWeeklySalesreportGUI.onProductselect(Sender: TwwDBGrid);
begin
  SelectedProducts.CommaText := TProductListExpressGUI(Sender.Owner).SelectedIDs('PartsID');
  if chkAllProducts.Checked then chkAllProducts.Checked := SelectedProducts.count =0;
  MakeQrymain;
  RefreshQuery;
  SetProducthint;
end;

procedure TWeeklySalesreportGUI.chkAllcustomerClick(Sender: TObject);
begin
  inherited;
  Selectedcustomers.Clear;
  MakeQrymain;
  RefreshQuery;
  SetCustomerfilter;
end;

procedure TWeeklySalesreportGUI.chkAllProductsClick(Sender: TObject);
begin
  inherited;
  SelectedProducts.Clear;
  MakeQrymain;
  RefreshQuery;
  SetProducthint;
end;

procedure TWeeklySalesreportGUI.cmdPrintClick(Sender: TObject);
begin
  TemplateSQL := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, '+
          ' CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO '+
          ' ~|||~{Details}' +SQLWithCustomfilterApplied +
          ' ~|||~{DateRange}Select convert(:DateFrom , Date) as DateFrom,  convert(:DateTo , Date) asDateto';

     TemplateSQL := replacestr(TemplateSQL , ':DateFrom', Quotedstr(formatDateTime(MysqlDatetimeformat , FilterdateFrom)));
     TemplateSQL := replacestr(TemplateSQL , ':DateTo', Quotedstr(formatDateTime(MysqlDatetimeformat , FilterdateTo)));
     ReportSQLSupplied := True;
  inherited;
end;

procedure TWeeklySalesreportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Selectedcustomers := TStringList.Create;
  SelectedProducts := TStringList.Create;
end;

procedure TWeeklySalesreportGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Selectedcustomers);
  FreeAndNil(SelectedProducts);
  inherited;

end;

function TWeeklySalesreportGUI.GetReportTypeID: integer;
begin
    result:= 119;
end;

procedure TWeeklySalesreportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Field is TFloatfield then
    if field.AsFloat =0 then
      AFont.Color := ABrush.Color;
end;

procedure TWeeklySalesreportGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + QrymainType.AsString;
  inherited;
end;
Function TWeeklySalesreportGUI.Customerfilter:String;
begin
  Result:= '';
  if (chkAllcustomer.Checked) or (Selectedcustomers.Count =0) then exit;
  Result:= ' AND S.ClientID in (' +Selectedcustomers.Commatext+')';
end;

function TWeeklySalesreportGUI.Productfilter: String;
begin
  Result:= '';
  if (chkAllProducts.Checked) or (SelectedProducts.Count =0) then exit;
  Result:= ' AND SL.productId  in (' +SelectedProducts.Commatext+')';
end;

procedure TWeeklySalesreportGUI.MakeQrymain;
begin
   Qrymain.Disablecontrols;
   try
     CloseDb(Qrymain);
     Qrymain.SQL.Clear;
     Qrymain.SQL.Add('SELECT');
     Qrymain.SQL.Add('CONVERT(ROUND(DateDiff( S.saleDate , :DateFrom )/7)+1 , SIGNED) as Weekno,');
     Qrymain.SQL.Add('CONVERT(Date_add(:DateFrom , Interval ROUND(DateDiff( S.saleDate , :DateFrom )/7) Week) , Date) as weekfrom,');
     Qrymain.SQL.Add('CONVERT(Date_add(Date_add(:DateFrom , Interval ROUND(DateDiff( S.saleDate ,:DateFrom )/7) Week), interval 6 day), Date) as weekto,');
     Qrymain.SQL.Add('S.SaleID as SAleID,');
     Qrymain.SQL.Add('S.Saledate as SaleDate,');
     Qrymain.SQL.Add('if(S.Isinvoice ="T", "Invoice", if(S.IsCashSale="T" , "cash Sale" , if(S.IsPOS="T" , "POS" , if(S.IsRefund="T" , "Refund", "")))) as Type,');
     Qrymain.SQL.Add('customername as customername,');
     Qrymain.SQL.Add('SL.productname as productname,');
     Qrymain.SQL.Add('P.ProductPrintName as ProductPrintName,');
     Qrymain.SQL.Add('concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as UOM,');
     Qrymain.SQL.Add('SL.UnitofMeasureShipped as UnitofMeasureShipped,');
     Qrymain.SQL.Add('SL.LinePriceInc as LinePriceInc,');
     Qrymain.SQL.Add('SL.TotalLineAmountInc as TotalLineAmountInc,');
     Qrymain.SQL.Add('SL.LinePrice as LinePrice,');
     Qrymain.SQL.Add('SL.TotalLineAmount as TotalLineAmount,');
     Qrymain.SQL.Add('SL.LineCost as LineCost,');
     Qrymain.SQL.Add('SL.LineCostInc as LineCostInc,');
     Qrymain.SQL.Add('SL.LineCost * SL.Shipped as totalLineCost ,');
     Qrymain.SQL.Add('SL.LineCostInc * SL.Shipped as totalLineCostinc');
     Qrymain.SQL.Add('FROM tblsales S');
     Qrymain.SQL.Add('INNER join tblsaleslines SL ON S.SaleID = SL.SaleID inner join tblparts P on P.partsId = SL.productId');
     Qrymain.SQL.Add('WHERE  (S.Isinvoice ="T" OR S.IsCashSale="T" OR S.IsPOS="T" OR S.IsRefund="T")');
     Qrymain.SQL.Add('AND S.Saledate BETWEEN :DateFrom AND :Dateto');
     Qrymain.SQL.Add(Customerfilter);
     Qrymain.SQL.Add(Productfilter);
     Qrymain.SQL.Add('ORDER BY Customername, weekno , Productname');
     RefreshOrignalSQL;
   finally
     Qrymain.EnableControls;
   end;
end;

procedure TWeeklySalesreportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  Selectedcustomers.CommaText:= GuiPrefs.Node['Selectedcustomers'].AsString;
  chkAllcustomer.OnClick:= nil;
  try
    chkAllcustomer.Checked:= Selectedcustomers.Count = 0;
  finally
    chkAllcustomer.OnClick:= chkAllcustomerClick;
  end;

  SelectedProducts.CommaText:= GuiPrefs.Node['SelectedProducts'].AsString;
  chkAllProducts.OnClick:= nil;
  try
    chkAllProducts.Checked:= SelectedProducts.Count = 0;
  finally
    chkAllProducts.OnClick:= chkAllProductsClick;
  end;
  SetProducthint;
  SetCustomerfilter;
  MakeQrymain;
end;

procedure TWeeklySalesreportGUI.RefreshQuery;
begin
  qryMain.ParamByName('DateFrom').AsDate := FilterDateFrom;
  qryMain.ParamByName('Dateto').AsDateTime := filterDateTo;
  inherited;
end;

procedure TWeeklySalesreportGUI.SetCustomerfilter;
var
  s:String;
begin
  if (Selectedcustomers.Count=0) then
    s := 'All Customer(s) Selected'
  else begin
    with TempMyQuery do try
      SQL.add('Select replace(company, "^" , " - ") as Company from tblclients where clientID in (' +Selectedcustomers.commatext+') order by company');
      Open;
      s:= 'Following Customer(s) are selected for the report. ' + NL + GroupConcat('Company' , '' , False, NL , '   ');
    finally
      closenFree;
    end;
  end;
  s:= s +NL;
  btnCustomerSelect.Hint := s;
  btnCustomerSelect.showhint := True;
  chkAllcustomer.Hint := s;
  chkAllcustomer.showhint := True;
end;

procedure TWeeklySalesreportGUI.SetProducthint;
var
  s:String;
begin
  if (SelectedProducts.Count=0) then
    s := 'All ' + Appenv.DefaultClass.PartColumn +'(s) Selected'
  else begin
    with TempMyQuery do try
      SQL.add('Select Partname from tblparts where PartsID in (' +SelectedProducts.commatext+') order by Partname');
      Open;
      s:= 'Following ' + Appenv.DefaultClass.PartColumn +'(s) are selected for the report. ' + NL + GroupConcat('Partname' , '' , False, NL  , '   ');
    finally
      closenFree;
    end;
  end;
  s:= s +NL;
  btnProductSelect.Hint := s;
  btnProductSelect.showhint := True;
  chkAllProducts.Hint := s;
  chkAllProducts.showhint := True;
end;

procedure TWeeklySalesreportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Selectedcustomers'].AsString := Selectedcustomers.CommaText;
  GuiPrefs.Node['SelectedProducts'].AsString    := SelectedProducts.CommaText;
end;

initialization
  RegisterClassOnce(TWeeklySalesreportGUI);

end.

