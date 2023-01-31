unit ColesInvoicelistExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InvoicelistExpress, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TColesInvoicelistExpressGUI = class(TInvoicelistExpressGUI)
    procedure grpFiltersClick(Sender: TObject); override;
  end;

implementation

uses
  CommonLib, FormFactory, BusobjExternalXRef, StrUtils;


{$R *.dfm}

procedure TColesInvoicelistExpressGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: GroupFilterString := 'SynchState = "Started"';
    1: GroupFilterString := 'SynchState = "Done"';
  end;
  ApplyQueryFilter;
end;

initialization
  RegisterClassOnce(TColesInvoicelistExpressGUI);

end.
