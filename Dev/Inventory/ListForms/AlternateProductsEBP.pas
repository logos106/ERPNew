unit AlternateProductsEBP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AlternateProducts, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TAlternateProductsEBPGUI = class(TAlternateProductsGUI)
  private
  Protected
    procedure AfterPopup(Popupform: TComponent); override;
  public
  end;


implementation

uses CommonLib, frmPartsFrm;

{$R *.dfm}

procedure TAlternateProductsEBPGUI.AfterPopup(Popupform:TComponent);
begin
  if Popupform is TfrmParts then begin
    if (qryMainCategory.asInteger = 4 ) and (qryMainExtraPriceID.AsInteger <> 0) then begin
      SetControlFocus(TfrmParts(Popupform).grdForeign);
      TfrmParts(Popupform).qryForeignPrice.Locate('ForeignPriceID' ,qryMainExtraPriceID.AsInteger , [] );
    end;
  end;
end;


initialization
  RegisterClassOnce(TAlternateProductsEBPGUI);

end.
