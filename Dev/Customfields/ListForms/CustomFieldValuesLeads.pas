unit CustomFieldValuesLeads;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomFieldValuesLeadsGUI = class(TCustomFieldValuesBaseGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, Busobjcustomfields;

{$R *.dfm}

initialization
  RegisterClassOnce(TCustomFieldValuesLeadsGUI);

end.
