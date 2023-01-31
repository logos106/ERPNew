unit PartFormulaList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TPartFormulaListGUI = class(TBaseListingGUI)
    qryMainPartsId: TIntegerField;
    qryMainPartname: TWideStringField;
    qryMainFormulaName: TWideStringField;
    qryMainFormula: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure AfterPopup(Popupform:TComponent);Override;
  public
  end;

implementation

uses CommonLib, frmPartsFrm , ComCtrls;

{$R *.dfm}
{ TPartFormulaListGUI }

procedure TPartFormulaListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if Popupform is TfrmParts then begin
    TfrmParts(Popupform).pageControl.ActivePage := TTabSheet(TfrmParts(Popupform).Miscellaneous);
    TfrmParts(Popupform).MiscPageControl.ActivePage := TTabSheet(TfrmParts(Popupform).tabGeneral);
    Setcontrolfocus(TfrmParts(Popupform).cboProductformula);
  end;
end;

procedure TPartFormulaListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;

procedure TPartFormulaListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainpartsid.fieldname);
end;

initialization
  RegisterClassOnce(TPartFormulaListGUI);

end.
