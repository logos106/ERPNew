unit ProductBatchbinSNList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProductListExpressForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TProductBatchbinSNListGUI = class(TProductListExpressGUI)
    grdallocation: TRadioGroup;
  private
  Protected
    Procedure InitGroupFilterString; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TProductBatchbinSNListGUI.InitGroupFilterString;
begin
  inherited InitGroupFilterString;
  if grdallocation.itemindex < 4 then begin
    if GroupFilterString <> '' then GroupFilterString := '(' + GroupFilterString +') and ';
         if grdallocation.itemindex = 0  then GroupFilterString := 'Batch = ' + QuotedStr('T')
    else if grdallocation.itemindex = 1  then GroupFilterString := 'Multiplebins = ' + QuotedStr('T')
    else if grdallocation.itemindex = 2  then GroupFilterString := 'SNtracking = ' + QuotedStr('T')
    else if grdallocation.itemindex = 3  then GroupFilterString := '(Batch = ' + QuotedStr('T')+ ' or Multiplebins = ' + QuotedStr('T') + ' or SNtracking = ' + QuotedStr('T')+')';
  end;
end;

initialization
  RegisterClassOnce(TProductBatchbinSNListGUI);

end.

