unit CustomerShipAddressListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShipAddressListForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomerShipAddressListFormGUI = class(TShipAddressListGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TCustomerShipAddressListFormGUI);

end.
