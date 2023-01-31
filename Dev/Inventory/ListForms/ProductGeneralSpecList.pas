unit ProductGeneralSpecList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TProductGeneralSpecListGUI = class(TBaseListingGUI)
    qryMainPartname: TWideStringField;
    qryMainPartsId: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainSpecValue: TWideStringField;
    qryMainIsMultiplier: TWideStringField;
    qryMainPartSpecID: TIntegerField;
  private
  Protected
      procedure AfterPopup(Popupform:TComponent);Override;
      procedure SetGridColumns; Override;
  public
  end;


implementation

uses frmPartsFrm, CommonLib;

{$R *.dfm}

{ TProductGeneralSpecListGUI }

procedure TProductGeneralSpecListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if Popupform is TfrmParts then begin
    TfrmParts(Popupform).Pagecontrol.ActivePage:= TfrmParts(Popupform).Miscellaneous;
    TfrmParts(Popupform).MiscPageControl.ActivePage:= TfrmParts(Popupform).tabSpecifications;
    SetFocusedcontrol(TfrmParts(Popupform).grdGeneralSpec);
    TfrmParts(Popupform).qrySpecifications.Locate('PartSpecID' , qrymainPartSpecID.asInteger , []);
  end;
end;

procedure TProductGeneralSpecListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainpartsId.fieldname);
  RemoveFieldfromGrid(qryMainPartSpecID.fieldname);
end;
initialization
  RegisterClassOnce(TProductGeneralSpecListGUI);

end.

