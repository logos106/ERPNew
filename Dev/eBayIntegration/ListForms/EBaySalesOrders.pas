unit EBaySalesOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesorderListExpress, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TEBaySalesOrdersGUI = class(TSalesorderListExpressGUI)
  private
  Protected
    function ExtraTables: String;Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TEBaySalesOrdersGUI }


{ TEBaySalesOrdersGUI }

function TEBaySalesOrdersGUI.ExtraTables: String;
begin
    Result := 'inner join tblebay_orders EBS on S.saleId = EBS.SalesOrderId';
end;

initialization
  RegisterClassOnce(TEBaySalesOrdersGUI);

end.

