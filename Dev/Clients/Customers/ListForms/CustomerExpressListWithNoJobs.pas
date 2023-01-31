unit CustomerExpressListWithNoJobs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomerExpressList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomerExpressListWithNoJobsGUI = class(TCustomerExpressListGUI)
    Label2: TLabel;
  private
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TCustomerExpressListWithNoJobsGUI);
end.
