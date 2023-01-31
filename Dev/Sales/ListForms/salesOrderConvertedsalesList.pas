unit salesOrderConvertedsalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesConvertedtoList, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TsalesOrderConvertedsalesListGUI = class(TsalesConvertedtoListGUI)
    procedure FormShow(Sender: TObject);
  private
  Protected
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}
{ TsalesOrderConvertedsalesListGUI }


procedure TsalesOrderConvertedsalesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  TitleLabel.caption := 'Sales Converted from SO # ' +inttostr(ConvertingFromId);
end;

initialization
  RegisterClassOnce(TsalesOrderConvertedsalesListGUI);

end.

