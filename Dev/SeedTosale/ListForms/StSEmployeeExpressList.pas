unit StSEmployeeExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EmployeeExpresslist, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls,
  ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, Shader, GIFImg,
  DNMPanel;

type
  TfmStsEmployeeExpressList = class(TEmployeeExpresslistGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // The form uses an additional condition in qryMain to exclude employees who are Drivers:
  // WHERE NOT (UPPER(Coalesce(E.CUSTFLD2, '')) = 'ISDRIVER')

implementation

{$R *.dfm}

uses
  CommonLib;

initialization
  RegisterClassOnce(TfmStsEmployeeExpressList);

end.
