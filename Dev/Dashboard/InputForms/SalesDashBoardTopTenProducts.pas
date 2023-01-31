unit SalesDashBoardTopTenProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardTopTenProducts, DB, DBAccess, MyAccess, ERPdbComponents,
  MemDS, Menus, ExtCtrls, StdCtrls, DNMPanel;

type
  TSalesDashBoardTopTenProductsGUI = class(TDashBoardTopTenProductsGUI)
  private
    { Private declarations }
  public
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); overload;override;
    function GetSQL:String;override;
  end;


implementation

uses CommonLib, salesAnalysisLib;

{$R *.dfm}
{ TSalesDashBoardTopTenProductsGUI }

function TSalesDashBoardTopTenProductsGUI.GetSQL: String;
begin
    SaleIDs := EmployeeSales(dtDateFrom , dtdateTo, fiEmployeeID);
    if SaleIDs = '' then SaleIDs := '0';
    result:= inherited GetSQL;
end;

procedure TSalesDashBoardTopTenProductsGUI.RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean);
begin
  inherited RefreshQuery(EmployeeId, dateFrom, DateTo,ignoredates);
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TSalesDashBoardTopTenProductsGUI);

end.

