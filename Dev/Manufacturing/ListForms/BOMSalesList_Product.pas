unit BOMSalesList_Product;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMSalesList_Base, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel;

type
  TBOMSalesList_ProductGUI = class(TBOMSalesList_BaseGUI)
  private
  Protected
    function GrpfiltersItemidex :Integer ; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TBOMSalesList_ProductGUI }

function TBOMSalesList_ProductGUI.GrpfiltersItemidex: Integer;
begin
  Result := 0;
end;

initialization
  RegisterClassOnce(TBOMSalesList_ProductGUI);

end.
