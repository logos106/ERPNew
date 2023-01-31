unit salesDashboardTopTenCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardTopTenCustomer, DB, DBAccess, MyAccess, ERPdbComponents,
  MemDS, Menus, ExtCtrls, StdCtrls, DNMPanel;

type
  TsalesDashboardTopTenCustomerGUI = class(TDashBoardTopTenCustomerGUI)
  private
  Protected
    function GetSQL:String ; override;

  public
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); overload;override;
  end;


implementation

uses CommonLib, salesAnalysisLib;

{$R *.dfm}
{ TsalesDashboardTopTenCustomerGUI }

function TsalesDashboardTopTenCustomerGUI.GetSQL: String;
begin
    SaleIDs := EmployeeSales(dtDateFrom , dtdateTo, fiEmployeeID);
    if SaleIDs = '' then SaleIDs := '0';
    result:= inherited getSQL;
end;

procedure TsalesDashboardTopTenCustomerGUI.RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean);
begin
  inherited RefreshQuery(EmployeeId, dateFrom, DateTo,ignoredates);
  RefreshQuery;
end;

initialization
  RegisterClassOnce(TsalesDashboardTopTenCustomerGUI);

end.

