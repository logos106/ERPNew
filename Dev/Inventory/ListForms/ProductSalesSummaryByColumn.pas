unit ProductSalesSummaryByColumn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, Mask, wwdbedit, Wwdotdot, Wwdbcomb, KbmMemTable,
  ProgressDialog,  wwdblook, Shader, DAScript, MyScript,
  wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductSalesSummaryByColumnGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblColumnTitle: TLabel;
    cboColumn: TwwDBComboBox;
    qryMainOrderbycolumn: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainTotalCost: TFloatField;
    qryMainTotalPrice: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainMargin: TFloatField;
    qryMainLastsaledate: TDateField;
    qryMainMargin2: TFloatField;
    qryMainProductPrintName: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cboColumnCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    procedure initialiseProductDetails(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;    
  end;

//var
//  ProductSalesSummaryByColumnGUI: TProductSalesSummaryByColumnGUI;

implementation
    
uses AppEnvironment, CommonLib, ProductQtyLib, MySQLConst, tcDataUtils,
  ProductSalesDetails, CommonFormLib;
{$R *.dfm}

procedure TProductSalesSummaryByColumnGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  ProductSalesSummaryByColumnGUI := nil;
end;

procedure TProductSalesSummaryByColumnGUI.RefreshQuery;
begin
  if cboColumn.ItemIndex < 0 then cboColumn.ItemIndex := 0;
  qryMain.Close;
  qryMain.ParamCheck := true;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT ');

  if cboColumn.ItemIndex = 0 then qryMain.SQL.Add(Firstcolumn + ' as Orderbycolumn, ');
  if cboColumn.ItemIndex = 1 then qryMain.SQL.Add(Secondcolumn + ' as Orderbycolumn, ');
  if cboColumn.ItemIndex = 2 then qryMain.SQL.Add(Thirdcolumn + ' as Orderbycolumn, ');
  if cboColumn.ItemIndex = 3 then begin
    qryMain.SQL.Add('SL.ProductName as Orderbycolumn, ');
    qryMain.SQL.Add('SL.Product_Description as ProductDescription , ');
    qryMain.SQL.Add('SL.ProductPrintName as ProductPrintName , ');
  end else begin
    qryMain.SQL.Add('"" as ProductDescription , ');
    qryMain.SQL.Add('"" as ProductPrintName , ');
  end;

  qryMain.SQL.Add('Sum(SL.LineCost*SL.Shipped) as "TotalCost", ');
  qryMain.SQL.Add('Sum(SL.TotalLineAmount) as "TotalPrice", ');
  qryMain.SQL.Add('Sum(SL.LineTax) as "TotalTax", ');
  qryMain.SQL.Add('Sum(SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin", ');
  qryMain.SQL.Add('Max(S.SaleDate) Lastsaledate , ');
  qryMain.SQL.Add('Round(((Sum(SL.TotalLineAmount)- Sum(SL.LineCost*SL.Shipped))/SUM(SL.TotalLineAmount))*100,'+inttostr(CurrencyRoundPlaces)+') as "Margin (%)" ');
  qryMain.SQL.Add('FROM tblSales as S');
  qryMain.SQL.Add('INNER JOIN tblSalesLines as SL USING(SaleID) ');
  qryMain.SQL.Add('Inner join tblParts as P on P.PartsId =SL.ProductID');
  qryMain.SQL.Add('WHERE (S.IsPOS ="T" or S.IsRefund="T" OR S.IsCashSale="T" OR S.IsInvoice="T") ');
  qryMain.SQL.Add(' AND S.SaleDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat , dtFrom.DateTime)) +
                  ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat , dtTo.DateTime)) );

  (*case cboColumn.ItemIndex of
    0: qryMain.SQL.Add('Group By FirstColumn; ');
    1: qryMain.SQL.Add('Group By SecondColumn; ');
    2: qryMain.SQL.Add('Group By ThirdColumn; ');
    3: qryMain.SQL.Add('Group By ProductName; ');
  end;*)
  qryMain.SQL.Add('Group By Orderbycolumn; ');


  inherited;

  case cboColumn.ItemIndex of
    0: qryMain.FieldByName('Orderbycolumn').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
    1: qryMain.FieldByName('Orderbycolumn').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
    2: qryMain.FieldByName('Orderbycolumn').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
    3: qryMain.FieldByName('Orderbycolumn').DisplayLabel := AppEnv.DefaultClass.PartColumn;
  end;

  TFloatField(qryMain.FieldByName('TotalCost')).currency := True;
  TFloatField(qryMain.FieldByName('TotalPrice')).currency := True;
  TFloatField(qryMain.FieldByName('TotalTax')).currency := True;
  TFloatField(qryMain.FieldByName('Margin')).currency := True;
  TFloatField(qryMain.FieldByName('Margin (%)')).DisplayFormat := '##.##%';
end;

procedure TProductSalesSummaryByColumnGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
  cboColumn.Items.Clear;
  cboColumn.Items.Add(AppEnv.DefaultClass.FirstColumn);
  cboColumn.Items.Add(AppEnv.DefaultClass.SecondColumn);
  cboColumn.Items.Add(AppEnv.DefaultClass.ThirdColumn);
  cboColumn.Items.Add(AppEnv.DefaultClass.PartColumn);
  cboColumn.Refresh;
  cboColumn.ItemIndex := 3; {default to product}
end;

procedure TProductSalesSummaryByColumnGUI.grdMainDblClick(Sender: TObject);
begin
  case cboColumn.ItemIndex of
    0: if MessageDlgXP_Vista('Do You Wish To See the Sales Details of all products of '+ AppEnv.DefaultClass.FirstColumn   +' :' + QrymainOrderbycolumn.asString +'?' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;
    1: if MessageDlgXP_Vista('Do You Wish To See the Sales Details of all products of '+ AppEnv.DefaultClass.SecondColumn  +' :' + QrymainOrderbycolumn.asString +'?' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;
    2: if MessageDlgXP_Vista('Do You Wish To See the Sales Details of all products of '+ AppEnv.DefaultClass.ThirdColumn   +' :' + QrymainOrderbycolumn.asString +'?' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;
    3: if MessageDlgXP_Vista('Do You Wish To See the Sales Details of all products of '+ AppEnv.DefaultClass.PartColumn    +' :' + QrymainOrderbycolumn.asString +'?' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;
  end;
  OpenERPListForm('TProductDetailsGUI' , initialiseProductDetails);
  Self.close;
end;
procedure TProductSalesSummaryByColumnGUI.initialiseProductDetails(Sender:TObject);
begin
  case cboColumn.ItemIndex of
    0: TProductDetailsGUI(Sender).FirstColumn  := QrymainOrderbycolumn.asString ;
    1: TProductDetailsGUI(Sender).SecondColumn := QrymainOrderbycolumn.asString ;
    2: TProductDetailsGUI(Sender).ThirdColumn  := QrymainOrderbycolumn.asString ;
    3: TProductDetailsGUI(Sender).ProductId:= getproduct(QrymainOrderbycolumn.asString) ;
  end;
end;
procedure TProductSalesSummaryByColumnGUI.cboColumnCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  RefreshQuery;
end;

procedure TProductSalesSummaryByColumnGUI.RefreshTotals;
var
  dTotalCost, dTotalPrice, dTotalTax, dMargin: double;
  dMarginPercent: double;
  mem: TKbmMemTable;
begin
  inherited;
  mem := TKbmMemTable.Create(nil);
  try
    dTotalCost  := 0;
    dTotalPrice := 0;
    dTotalTax   := 0;
    dMargin     := 0;
    mem.LoadFromDataSet(qryMain, [mtcpoStructure, mtcpoProperties]);
    while not mem.Eof do begin
      dTotalCost := dTotalCost + mem.FieldByName('TotalCost').AsFloat;
      dTotalPrice := dTotalPrice + mem.FieldByName('TotalPrice').AsFloat;
      dTotalTax := dTotalTax + mem.FieldByName('TotalTax').AsFloat;
      dMargin := dMargin + mem.FieldByName('Margin').AsFloat;

      // Fetch next record.
      mem.Next;
    end;

    dMarginPercent :=0;
    if dTotalPrice> 0 then begin    {do division only if dTotalPrice >0 , otherwise Floating point error}
        dMarginPercent := ((dTotalPrice - dTotalCost) / dTotalPrice) * 100;
    end;
    grdMain.ColumnByName('TotalCost').FooterValue  := FloatToStrF(dTotalCost, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('TotalPrice').FooterValue := FloatToStrF(dTotalPrice, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('TotalTax').FooterValue   := FloatToStrF(dTotalTax, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('Margin').FooterValue     := FloatToStrF(dMargin, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('Margin (%)').FooterValue := FloatToStrF(dMarginPercent, ffFixed, 15, 2) + '%';

  finally
    // Release our used objects.
    if Assigned(mem) then
      FreeAndNil(mem);
  end;
end;


initialization
  RegisterClassOnce(TProductSalesSummaryByColumnGUI);
end.
