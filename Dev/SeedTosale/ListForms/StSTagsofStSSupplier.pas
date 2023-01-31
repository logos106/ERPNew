
unit StSTagsofStSSupplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StSTags, DAScript, MyScript, ERPdbComponents, DB, SelectionDialog,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT, ImgList,
  AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStSTagsofStSSupplierGUI = class(TStSTagsGUI)
    pnlExtraButtons: TDNMPanel;
    btnSynch: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
  public
  end;


implementation

uses AppEnvironment, BusObjClient, CommonLib;

{$R *.dfm}


procedure TStSTagsofStSSupplierGUI.FormCreate(Sender: TObject);
begin
  inherited;
  btnSynch.caption := 'Synch';
  if trim(Appenv.companyprefs.StSSupplier) <> '' then
    btnSynch.caption := btnSynch.caption + ' With ' +trim(Appenv.companyprefs.StSSupplier);
  filterString := 'Supplier =' + quotedstr(Appenv.CompanyPrefs.StSSupplier);
end;

procedure TStSTagsofStSSupplierGUI.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := true;
  Self.caption :=trim(Appenv.companyprefs.StSSupplier) +' Tags';
  TitleLabel.caption :=trim(Appenv.companyprefs.StSSupplier) +' Tags';
end;

initialization
  RegisterClassOnce(TStSTagsofStSSupplierGUI);

end.
