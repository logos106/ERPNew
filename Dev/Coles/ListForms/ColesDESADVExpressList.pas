unit ColesDESADVExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ColesSaleslistExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TColesDESADVExpressListGUI = class(TColesSaleslistExpressGUI)
  protected
    function GetRefObjectType: string; virtual;
  end;

implementation

uses
  CommonLib, FormFactory;

{$R *.dfm}

{ TColesDESADVExpressListGUI }

function TColesDESADVExpressListGUI.GetRefObjectType: string;
begin
  Result := '';
end;

initialization
  RegisterClassOnce(TColesDESADVExpressListGUI);

end.
