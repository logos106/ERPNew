unit WorkOrdersByRes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkOrders, DAScript, MyScript, ERPdbComponents, DB, SelectionDialog,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TWorkOrdersByResGUI = class(TWorkOrdersGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;



implementation

uses CommonLib;

{$R *.dfm}


Initialization
  RegisterClassOnce(TWorkOrdersByResGUI);
end.
