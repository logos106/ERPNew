unit SalesDashBoardAnL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashboardAnL, Menus, ExtCtrls, ComCtrls, DNMSpeedButton, DNMPanel,
  StdCtrls;

type
  TSalesDashBoardAnLGUI = class(TDashBoardAnLGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TSalesDashBoardAnLGUI);

end.

