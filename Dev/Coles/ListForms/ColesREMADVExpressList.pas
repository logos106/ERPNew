unit ColesREMADVExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustPaymentList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TColesCustPaymentListGUI = class(TCustPaymentListGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ColesCustPaymentListGUI: TColesCustPaymentListGUI;

implementation

uses
  CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TCustPaymentListGUI);

end.
