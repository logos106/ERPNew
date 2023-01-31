unit NZTransReturnList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VATTransReturnList, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, TransReturnList, DAScript,
  MyScript;

type
  TNZTransReturnListGUI = class(TTransReturnListGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TNZTransReturnListGUI);

end.



