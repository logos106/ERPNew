unit DashBoardTopTenProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, DNMPanel, StdCtrls, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton,
  AdvPageControl, ComCtrls, ToolWin,
  DashBoardTopTenBase, Menus;

type
  TDashBoardTopTenProductsGUI = class(TDashBoardTopTenBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
    function GetSQL:String; override;
  public
  end;

implementation

uses CommonLib, tcConst, FastFuncs, MySQLConst;


{$R *.dfm}



procedure TDashBoardTopTenProductsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SaleIDs:= '';
end;

function TDashBoardTopTenProductsGUI.GetSQL: String;
begin
    REsult := 'SELECT ' +
              ' Left( concat(SL.ProductName , space(10)), 10) as Name , SL.ProductName as DetailName, ' +
              ' Sum(SL.TotalLineAmount) as "Price", '+
              ' Round(Sum(SL.Shipped), ' + IntToStr(tcconst.GeneralRoundPlaces) + ') as Quantity, '+
              ' Sum(SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin" '+
              ' FROM tblSales as S'+
              ' INNER JOIN tblSalesLines as SL USING(SaleID) '+
              ' WHERE '+
              '(S.IsPOS ="T" or S.IsRefund ="T"   or S.IsCashSale="T" or S.IsInvoice="T" or S.IsSalesOrder="T" or S.IsLayby ="T") '+
              ' AND SL.Invoiced="T" '+
              ' AND S.Deleted ="F" '+
              ' And S.IsQuote="F" '+
              ' AND S.converted = "F"  ' +
              ' AND S.SaleDate Between ' + DateFrom + ' AND ' + DateTo;
    if SaleIDs <> '' then result := result +' and S.SAleId in (' + SaleIDs +')';
    //if fiEmployeeId <> 0 then result := result +' and  S.employeeId = ' + inttoStr(fiEmployeeID);
    result := result +' Group By SL.ProductName ';
    case grpFilters.ItemIndex of
      0: result := result +' Order By Price desc ';
      1: result := result +' Order By Margin desc';
      2: result := result +' Order By Quantity desc';
    end;
    result := result +' Limit 10;';
end;

initialization
  RegisterClassOnce(TDashBoardTopTenProductsGUI);
end.

