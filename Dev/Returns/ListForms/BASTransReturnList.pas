unit BASTransReturnList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TransReturnList, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript;

type
  TBASTransReturnListGUI = class(TTransReturnListGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;



implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TBASTransReturnListGUI);

end.


