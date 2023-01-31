unit DashBoardTopTenCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls, DB, MemDS,
  DBAccess, MyAccess,ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton,
  AdvPageControl, ComCtrls, ToolWin,  DashBoardBase, DashBoardTopTenBase,
  Menus;

type
  TDashBoardTopTenCustomerGUI = class(TDashBoardTopTenBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
    function GetSQL:String; override;
  public
  end;

implementation

uses CommonLib, MySQLConst, AppEnvironment;


{$R *.dfm}


procedure TDashBoardTopTenCustomerGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SaleIDs:= '';
end;

function TDashBoardTopTenCustomerGUI.GetSQL: String;
begin
    REsult := 'SELECT ' +
              ' Left( concat(S.customername , space(10)), 10) as Name , S.CustomerName as Detailname , ' +
              ' Sum(SL.TotalLineAmount) as "Price", '+
              ' Sum(SL.TotalLineAmount-(SL.LineCost*SL.Shipped)) as "Margin" '+
              ' FROM tblSales as S'+
              ' INNER JOIN tblSalesLines as SL USING(SaleID) '+
              ' WHERE (S.IsRefund="T" OR S.IsCashSale="T" OR S.IsInvoice="T") '+
              ' AND S.SaleDate Between ' + DateFrom + ' AND ' + DateTo ;
    if SaleIDs <> '' then result := result +' and S.SAleId in (' + SaleIDs +')';
    //if fiEmployeeId <> 0 then result := result +' and  S.employeeId = ' + inttoStr(fiEmployeeID);
    result := result +' Group By S.customername';
    case grpFilters.ItemIndex of
      0: result := result +' Order By Price desc';
      1: result := result +' Order By Margin desc';
    end;
    result := result +' Limit 10;';
end;

initialization
  RegisterClassOnce(TDashBoardTopTenCustomerGUI);
end.

