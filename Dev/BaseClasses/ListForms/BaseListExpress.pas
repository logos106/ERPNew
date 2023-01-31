unit BaseListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, wwcheckbox, CustomInputBox, DNMAction,BaseListExpressDetails,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TBaseListExpressGUI = class(TBaseListExpressDetailsGUI)
  private
  Protected
  public
  end;


implementation

{$R *.dfm}


end.

