unit SalesDashBoardTopTenSalesManDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesDashBoardTopTenDetailbase, DAScript, MyScript, ERPdbComponents,
  DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TSalesDashBoardTopTenSalesManDetailsGUI = class(TSalesDashBoardTopTenDetailbaseGUI)
  private
  Protected
    function getSQL:String ; Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, MySQLConst, tcConst;

{$R *.dfm}
{ TSalesDashBoardTopTenSalesManDetailsGUI }

function TSalesDashBoardTopTenSalesManDetailsGUI.getSQL: String;
begin
 if Idtofilter =0 then begin
    result:= 'SELECT  ' + NL+
            ' s.SAleId as saleID , ' + NL+
            ' S.employeeId as ID, ' + NL+
            ' "" as Type, '+nl+
            ' S.Employeename as detailName,   ' + NL+
        ' Sum(SL.TotalLineAmount) as "Price",   ' + NL+
        ' Sum(SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin"   ' + NL+
        ' FROM tblSales as S  ' + NL+
        ' INNER JOIN tblSalesLines as SL USING(SaleID)   ' + NL+
        ' WHERE (S.IsRefund="T" OR S.IsCashSale="T" OR S.IsInvoice="T")   ' + NL+
            ' AND S.SaleDate Between ' + Quotedstr(formatDatetime(MySQLDatetimeformat, FilterdateFrom)) +' and ' + Quotedstr(FormatDateTime(MySQLDatetimeformat, FilterDateTo))  ;
    result:= result + nl +' Group By S.Employeename ' + NL+
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
            ' S.Employeename as detailName,   ' + NL+
        ' (SL.TotalLineAmount) as "Price",   ' + NL+
        ' (SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin"   ' + NL+
        ' FROM tblSales as S  ' + NL+
        ' INNER JOIN tblSalesLines as SL USING(SaleID)   ' + NL+
        ' WHERE (S.IsRefund="T" OR S.IsCashSale="T" OR S.IsInvoice="T")   ' + NL+
            ' and  s.EmployeeId = ' + inttostr(Idtofilter) + NL+
            ' AND S.SaleDate Between ' + Quotedstr(formatDatetime(MySQLDatetimeformat, FilterdateFrom)) +' and ' + Quotedstr(FormatDateTime(MySQLDatetimeformat, FilterDateTo))  ;
    result:= result + nl +
            ' Order By SaleId ';
  end;

end;

initialization
  RegisterClassOnce(TSalesDashBoardTopTenSalesManDetailsGUI);

end.

