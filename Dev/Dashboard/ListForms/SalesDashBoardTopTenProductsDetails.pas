unit SalesDashBoardTopTenProductsDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesDashBoardTopTenDetailbase, DAScript, MyScript, ERPdbComponents,
  DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TSalesDashBoardTopTenProductsDetailsGUI = class(TSalesDashBoardTopTenDetailbaseGUI)
  private
  Protected
    function getSQL:String ; Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, MySQLConst, tcConst;

{$R *.dfm}
{ TSalesDashBoardTopTenProductsDetailsGUI }

function TSalesDashBoardTopTenProductsDetailsGUI.getSQL: String;
var
  fsSalesID:string;
begin
  fsSalesID:= SaleIDs;
  (*REsult:= 'SELECT  ' + NL+
        ' SL.ProductName as DetailName,   ' + NL+
        ' Sum(SL.TotalLineAmount) as "Price",   ' + NL+
        ' Round(Sum(SL.Shipped), 5) as Quantity,   ' + NL+
        ' Sum(SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin"   ' + NL+
        ' FROM tblSales as S  ' + NL+
        ' INNER JOIN tblSalesLines as SL USING(SaleID)   ' + NL+
        ' WHERE (S.IsPOS ="T" or S.IsRefund ="T"   or S.IsCashSale="T" or S.IsInvoice="T" or S.IsSalesOrder="T" or S.IsLayby ="T")  AND SL.Invoiced="T"  AND S.Deleted ="F"  And S.IsQuote="F"  AND S.converted = "F"    ' + NL+
        ' AND S.SaleDate Between ' + Quotedstr(formatDatetime(MySQLDatetimeformat, FilterdateFrom)) +' and ' + Quotedstr(FormatDateTime(MySQLDatetimeformat, FilterDateTo))      ;
  if fsSalesID<> '' then result:= result + nl+ ' and S.SAleId in (' +fsSalesID +') ' ;
  result:= result + ' Group By SL.ProductName   ' + NL+
        ' Order By Price desc  ';*)

  fsSalesID:= SaleIDs;
  if Idtofilter =0 then begin
    result:= 'SELECT  ' + NL+
            ' S.SAleID as saleID , ' + NL+
            ' SL.productId as ID, ' + NL+
            ' "" as Type, '+nl+
        ' SL.ProductName as DetailName,   ' + NL+
        ' Sum(SL.TotalLineAmount) as "Price",   ' + NL+
        ' Round(Sum(SL.Shipped), 5) as Quantity,   ' + NL+
        ' Sum(SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin"   ' + NL+
        ' FROM tblSales as S  ' + NL+
        ' INNER JOIN tblSalesLines as SL USING(SaleID)   ' + NL+
        ' WHERE (S.IsPOS ="T" or S.IsRefund ="T"   or S.IsCashSale="T" or S.IsInvoice="T" or S.IsSalesOrder="T" or S.IsLayby ="T")  AND SL.Invoiced="T"  AND S.Deleted ="F"  And S.IsQuote="F"  AND S.converted = "F"    ' + NL+
            ' AND S.SaleDate Between ' + Quotedstr(formatDatetime(MySQLDatetimeformat, FilterdateFrom)) +' and ' + Quotedstr(FormatDateTime(MySQLDatetimeformat, FilterDateTo))  ;
    if fsSalesID<> '' then result:= result + nl +' and S.SAleId in (' +fsSalesID +') ' ;
    result:= result + nl +' Group By SL.ProductName ' + NL+
            ' Order By Price desc ';
  end else begin
    result:= 'SELECT  ' + NL+
            ' S.saleID as saleID , ' + NL+
            ' S.clientId as ID, ' + NL+
        ' If(S.IsVoucher="T" and isinvoice="T", "Invoice Voucher" , ' +
                      ' if(S.IsVoucher="T" ,"Voucher" ,  ' +
                      ' If(S.IsCashSale="T" And S.IsPOS="F" ,"Cash Sale",  ' +
                      ' If(S.IsRefund="T","Refund", ' +
                      ' If(S.IsInvoice="T","Invoice", ' +
                      ' If(S.IsCashSale="T" And S.IsPOS="T",if(S.IsLaybyPayment="T" ,if( S.TotalAmountInc <0 , "Layby Reverse Transaction ", ' +
                      ' "Layby Payment" ), "POS"),"Unknown")))))) as Type, '+NL+
        ' SL.ProductName as DetailName,   ' + NL+
        ' (SL.TotalLineAmount) as "Price",   ' + NL+
        ' Round((SL.Shipped), 5) as Quantity,   ' + NL+
        ' (SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin"   ' + NL+
        ' FROM tblSales as S  ' + NL+
        ' INNER JOIN tblSalesLines as SL USING(SaleID)   ' + NL+
        ' WHERE (S.IsPOS ="T" or S.IsRefund ="T"   or S.IsCashSale="T" or S.IsInvoice="T" or S.IsSalesOrder="T" or S.IsLayby ="T")  AND SL.Invoiced="T"  AND S.Deleted ="F"  And S.IsQuote="F"  AND S.converted = "F"    ' + NL+
            ' and  sL.ProductID = ' + inttostr(Idtofilter) + NL+
            ' AND S.SaleDate Between ' + Quotedstr(formatDatetime(MySQLDatetimeformat, FilterdateFrom)) +' and ' + Quotedstr(FormatDateTime(MySQLDatetimeformat, FilterDateTo))  ;
    if fsSalesID<> '' then result:= result + nl +' and S.SAleId in (' +fsSalesID +') ' ;
    result:= result + nl +(*' Group By SL.ProductName ' + NL+*)
            ' Order By SaleID ';
  end;
end;



initialization
  RegisterClassOnce(TSalesDashBoardTopTenProductsDetailsGUI);

end.

