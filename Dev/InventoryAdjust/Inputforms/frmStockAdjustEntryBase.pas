unit frmStockAdjustEntryBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockAdjustEntryTree, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  ComCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, DNMSpeedButton, wwdblook, Mask, Shader, DNMPanel,
  ERPDbLookupCombo;

type
  TfmStockAdjustEntryBase = class(TfmStockAdjustEntryTree)
    lblMsg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cboPrintProductBeforeOpenList(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses AppEnvironment, frmStockAdjustEntryBatch, frmStockAdjustEntryBins, frmStockAdjustEntrySN,
  InventoryLib, ProductListExpressForm;

{$R *.dfm}
procedure TfmStockAdjustEntryBase.cboPrintProductBeforeOpenList(
  Sender: TObject);
begin
  inherited;

    if sender is TProductListExpressGUI then
           if self is TfmStockAdjustEntrySN     then TProductListExpressGUI(Sender).FilterString := 'SNTracking='   + quotedstr('T')
      else if self is TfmStockAdjustEntryBins   then TProductListExpressGUI(Sender).FilterString := 'MultipleBins=' + quotedstr('T')
      else if self is TfmStockAdjustEntryBatch  then TProductListExpressGUI(Sender).FilterString := 'batch='        + quotedstr('T');

end;

procedure TfmStockAdjustEntryBase.FormShow(Sender: TObject);
var
  S:String;
begin
  inherited;
  s:= '';
    if (KeyId =0) or ( qryStockAdjustEntryProcessed.asBoolean=False) then
        if self is TfmStockAdjustEntryBatch then s:= BatchAdjhint(true)
  else  if self is TfmStockAdjustEntryBins  then s:= BinAdjhint(true)
  else  if self is TfmStockAdjustEntrySN    then s:= SNAdjhint(true);

  if s<> '' then begin
    MessageDlg(s, mtInformation, [mbOK], 0);
    timerMsg(lblMsg, s, 20, clred);
  end;
end;

end.

