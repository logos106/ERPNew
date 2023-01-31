unit frmBarCodeManufacturingSalesorderInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmSalesorderInvoice, ActnList, DNMAction, DB, ProgressDialog, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, Shader, wwdbdatetimepicker, wwdblook,
  StdCtrls, DBCtrls, DNMSpeedButton, Mask, wwdbedit, Grids, Wwdbigrd, Wwdbgrid,
  DNMPanel , ImageDLLLib;

type
  TfmBarCodeManufacturingSalesorderInvoice = class(TfmSalesorderInvoice)
    actAllocate: TDNMAction;
    pnlInput: TDNMPanel;
    DBText1: TDBText;
    chkHideDetails: TCheckBox;
    pnlQty: TDNMPanel;
    lblQtytoBeinvoiced: TLabel;
    edtUOMQty: TDBEdit;
    procedure actDoAllocateExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkHideDetailsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    btnPQA : TERPMainSwitchButton;
    fsCallingformname: String;
    fdQtyBuilt: Double;
    Procedure ReadGuiprefs;
    Procedure SaveGuiprefs;
  Protected
    Procedure Makebuttons;Override;
  public
    constructor Create(AOwner:TComponent);Override;
    Property Callingformname :String read fsCallingformname write fsCallingformname;
    Property QtyBuilt :Double read fdQtyBuilt write fdQtyBuilt;
  end;


implementation

uses CommonLib, ButtonsLib, AdvGlowButton, tcConst;


{$R *.dfm}

procedure TfmBarCodeManufacturingSalesorderInvoice.actDoAllocateExecute(Sender: TObject);
begin
  inherited;
  DOProductAllocate;
end;

procedure TfmBarCodeManufacturingSalesorderInvoice.chkHideDetailsClick(
  Sender: TObject);
begin
try
  inherited;
  Setcontrolfocus(edtUOMQty);
  if chkHideDetails.checked then Self.Width := 430 else self.width := 1000;
  if chkHideDetails.checked then Self.height := 500 else self.height:= 590;
  grdTransactions.visible := not(chkHideDetails.checked);
  GuiPrefs.Node['Options.HideDetails'].asBoolean := chkHideDetails.checked;
  Position := poMainFormCenter;
Except

end;
end;

constructor TfmBarCodeManufacturingSalesorderInvoice.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TfmBarCodeManufacturingSalesorderInvoice.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  SaveGuiprefs;
end;

procedure TfmBarCodeManufacturingSalesorderInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  cboCreationDate.displayformat := FormatSettings.ShortdateFormat;
  Callingformname := 'Self';
  fdQtyBuilt := 0;
end;

procedure TfmBarCodeManufacturingSalesorderInvoice.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = vk_f5 then begin
      chkHideDetails.Checked := not(chkHideDetails.Checked);
      exit;
    end;
  inherited;

end;

procedure TfmBarCodeManufacturingSalesorderInvoice.FormShow(Sender: TObject);
begin
  if not (isformshown) then begin // this is not to call form show again when 'Hide Details' selected. The position is reset in the hide details to centralize the form
    inherited;
    Setcontrolfocus(edtUOMQty);
    ReadGuiprefs;
  end;
  cmdClose.Left         := btnLeft(4,cmdclose.width ,1, pnlButtons) ;
  btnAutoAllocate.Left  := btnLeft(4,cmdclose.width ,2, pnlButtons) ;
  btnshipAll.Left       := btnLeft(4,cmdclose.width ,3, pnlButtons) ;
  cmdCancel.Left        := btnLeft(4,cmdclose.width ,4, pnlButtons) ;
  if SaleLineID <> 0 then
    QrySaleSOrderInvoiceLines.Locate('SalesOrderLineID', SaleLineID , []);
  actautoAlocate.Caption :='AUTO'+NL+'ALLOCATE';
  if SalesOrderInvoices.SalesOrder.isinternalOrder then begin
      lblQtytoBeinvoiced.Caption := 'Place In To Stock ';
      actSave.Caption :='PLACE'+NL+'IN TO STOCK';
      actShipAll.Caption :='PLACE IN TO'+NL+'STOCK (ALL)';
  end else begin
      lblQtytoBeinvoiced.Caption := 'To Be Invoiced';
      actSave.Caption := 'MAKE INVOICE';
      actShipAll.Caption := 'INVOICE'+NL+'ALL';
  end;
  if fdQtyBuilt <> 0 then begin
    EditDb(QrySaleSOrderInvoiceLines);
    QrySaleSOrderInvoiceLinesUOMQty.asFloat :=  fdQtyBuilt;
    PostDb(QrySaleSOrderInvoiceLines);
  end;
end;
procedure TfmBarCodeManufacturingSalesorderInvoice.grdTransactionsCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean;
  AFont: TFont; ABrush: TBrush);
begin
  inherited;
  ABrush.Color := clwhite;
end;

procedure TfmBarCodeManufacturingSalesorderInvoice.Makebuttons;
begin
  inherited;
  with cmdClose         do begin    Height := 79;    Left := btnLeft(4,cmdclose.width ,1, pnlButtons) ; top := trunc((pnlButtons.height - height)/2); font.Style := font.Style  + [fsBold]; dnmaction := actsave        ; Layout := AdvGlowButton.blGlyphTop;  Wordwrap := True;end;
  with btnAutoAllocate  do begin;   Height := 79;    Left := btnLeft(4,cmdclose.width ,2, pnlButtons) ; top :=cmdClose.top                          ; font.Style := font.Style  + [fsBold]; dnmaction := actautoAlocate ; Layout := AdvGlowButton.blGlyphTop;  Wordwrap := True;end;
  with btnshipAll       do begin    Height := 79;    Left := btnLeft(4,cmdclose.width ,3, pnlButtons) ; top :=cmdClose.top                          ; font.Style := font.Style  + [fsBold]; dnmaction := actShipAll     ; Layout := AdvGlowButton.blGlyphTop;  Wordwrap := True;end;
  with cmdCancel        do begin    Height := 79;    Left := btnLeft(4,cmdclose.width ,4, pnlButtons) ; top :=cmdClose.top                          ; font.Style := font.Style  + [fsBold]; dnmaction := actclose       ; Layout := AdvGlowButton.blGlyphTop;  Wordwrap := True;end;
  btnPQA        := TERPMainSwitchButton.create(Self);  with btnPQA        do begin  UseLargeIcon := False;Parent := pnlQty;  align := alclient; alignwithMargins := True; dnmaction := actAllocate        ;  ParentFont := TRue;  taborder := 1; end;

  showcontrolhint(btnPQA,  'Choose to Do the Bin/Batch/Serial Number Allocation for the Manufactured Product'+NL);
end;

procedure TfmBarCodeManufacturingSalesorderInvoice.ReadGuiprefs;
begin
  if not(GuiPrefs.active) then GuiPrefs.active := TRue;
  chkHideDetails.checked := GuiPrefs.Node['Options.HideDetails'].asBoolean;
end;

procedure TfmBarCodeManufacturingSalesorderInvoice.SaveGuiprefs;
begin
  GuiPrefs.Node['Options.HideDetails'].asBoolean := chkHideDetails.checked;
end;

initialization
  RegisterClassOnce(TfmBarCodeManufacturingSalesorderInvoice);


end.
