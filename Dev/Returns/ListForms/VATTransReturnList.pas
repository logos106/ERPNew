unit  VATTransReturnList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TransReturnList, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript;

type
  TVATTransReturnListGUI = class(TTransReturnListGUI)
  private
    { Private declarations }
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TVATTransReturnListGUI }


initialization
  RegisterClassOnce(TVATTransReturnListGUI);

end.


