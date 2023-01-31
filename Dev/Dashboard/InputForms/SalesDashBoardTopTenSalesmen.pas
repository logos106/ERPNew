unit SalesDashBoardTopTenSalesmen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardTopTenSalesmen, DB, DBAccess, MyAccess, ERPdbComponents,
  MemDS, Menus, ExtCtrls, StdCtrls, DNMPanel;

type
  TSalesDashBoardTopTenSalesmenGUI = class(TDashBoardTopTenSalesmenGUI)
  private
    { Private declarations }
  public
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); overload;override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TSalesDashBoardTopTenSalesmenGUI }

procedure TSalesDashBoardTopTenSalesmenGUI.RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean);
begin
  inherited RefreshQuery(EmployeeId, dateFrom, DateTo,ignoredates);
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TSalesDashBoardTopTenSalesmenGUI);

end.

