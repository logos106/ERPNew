unit DashBoardTopTenSalesmen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton,
  AdvPageControl, ComCtrls, ToolWin, DashBoardBase,
  DashBoardTopTenBase, Menus;

type
  TDashBoardTopTenSalesmenGUI = class(TDashBoardTopTenBaseGUI)
  private

  Protected
    function GetSQL:String; override;
  public
  end;

implementation

uses CommonLib, MySQLConst, salesAnalysisLib;


{$R *.dfm}



function TDashBoardTopTenSalesmenGUI.GetSQL: String;
var
  SaleIDs:String;
begin
    SaleIDs := EmployeeSales(dtDateFrom , dtdateTo, fiEmployeeID);
    if SaleIDs = '' then SaleIDs := '0';
    REsult := 'SELECT ' +
              ' Left( concat(S.Employeename , space(10)), 10) as name , S.Employeename as detailName, ' +
              ' Sum(SL.TotalLineAmount) as "Price", '+
              ' Sum(SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin" '+
              ' FROM tblSales as S'+
              ' INNER JOIN tblSalesLines as SL USING(SaleID) '+
              ' WHERE (S.IsRefund="T" OR S.IsCashSale="T" OR S.IsInvoice="T") '+
              ' AND S.SaleDate Between ' + DateFrom + ' AND ' + DateTo(*+
              ' and S.SAleId in (' + SaleIDs +')'*); // as this is looking for top ten sales man, should not have filter for employees
    //if fiEmployeeId <> 0 then result := result +' and S.employeeId = ' + inttoStr(fiEmployeeID);
    result := result +' Group By S.Employeename';
    case grpFilters.ItemIndex of
      0: result := result +' Order By Price desc';
      1: result := result +' Order By Margin desc';
    end;
    result := result +' Limit 10;';
end;

initialization
  RegisterClassOnce(TDashBoardTopTenSalesmenGUI);
end.

