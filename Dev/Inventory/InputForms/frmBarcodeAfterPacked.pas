unit frmBarcodeAfterPacked;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton,
  GuiPrefsObj, ActnList, DNMAction, StdCtrls, Shader, DNMPanel, BaseInputForm, frmBarcodePicking, ImageDLLLib;

type
  TfmBarcodeAfterPacked = class(TBaseForm)
    ActionList: TActionList;
    actPrintDeldocket : TDNMAction;
    actPrintCNote     : TDNMAction;
    DNMPanel2: TDNMPanel;
    DNMPanel1: TDNMPanel;
    btnSelectAll: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnclose: TDNMSpeedButton;
    bPrintDeldocket: TDnMPanel;
    bPrintCNote: TDnMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    bPrintsale: TDnMPanel;
    actPrintsale: TDNMAction;
    pnlPrintPick: TDNMPanel;
    actPrintPick: TDNMAction;
    pnlPrintBarcode: TDNMPanel;
    actPrintDespatchBarcode: TDNMAction;
    chkPrintsale: TCheckBox;
    chkPrintDeldocket: TCheckBox;
    chkPrintCNote: TCheckBox;
    chkPrintPick: TCheckBox;
    chkPrintBarcode: TCheckBox;
    procedure OptionSelected(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    GuiPrefs: TFormGuiPrefs;

    btnPrintsale      : TERPMainSwitchButton;
    btnPrintDeldocket : TERPMainSwitchButton;
    BtnPrintCNote     : TERPMainSwitchButton;
    btnPrintPick      : TERPMainSwitchButton;
    btnPrintBarcode   : TERPMainSwitchButton;

    Function Ownerform:TfmBarcodePicking;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure MakeButtons;
  Protected
    Procedure DoExtraTranslation;Override;
  public
    { Public declarations }
  end;

implementation

uses Commonlib,systemlib,  FastFuncs , dmMainGUI;

{$R *.dfm}
procedure TfmBarcodeAfterPacked.MakeButtons;
begin
    btnPrintsale	    := TERPMainSwitchButton.create(Self);  With btnPrintsale      do begin  Name := MakeName(Self,'btnPrintsale')      ; Parent := bPrintsale     ;HelpContext := 686005;  DnmAction := actPrintsale           ; Align := alClient; Visible := True; AlignWithMargins := True; Margins.Left := 1;Margins.right := 1; Margins.top := 1;Margins.Bottom:= 0; end;
    btnPrintDeldocket	:= TERPMainSwitchButton.create(Self);  With btnPrintDeldocket do begin  Name := MakeName(Self,'btnPrintDeldocket') ; Parent := bPrintDeldocket;HelpContext := 686001;  DnmAction := actPrintDeldocket      ; Align := alClient; Visible := True; AlignWithMargins := True; Margins.Left := 1;Margins.right := 1; Margins.top := 1;Margins.Bottom:= 0; end;
    BtnPrintCNote	    := TERPMainSwitchButton.create(Self);  With BtnPrintCNote     do begin  Name := MakeName(Self,'BtnPrintCNote')     ; Parent := bPrintCNote    ;HelpContext := 686002;  DnmAction := actPrintCNote          ; Align := alClient; Visible := True; AlignWithMargins := True; Margins.Left := 1;Margins.right := 1; Margins.top := 1;Margins.Bottom:= 0; end;
    btnPrintPick	    := TERPMainSwitchButton.create(Self);  With btnPrintPick      do begin  Name := MakeName(Self,'btnPrintPick')      ; Parent := pnlPrintPick   ;HelpContext := 686009;  DnmAction := actPrintPick           ; Align := alClient; Visible := True; AlignWithMargins := True; Margins.Left := 1;Margins.right := 1; Margins.top := 1;Margins.Bottom:= 0; end;
    btnPrintBarcode	  := TERPMainSwitchButton.create(Self);  With btnPrintBarcode   do begin  Name := MakeName(Self,'btnPrintBarcode')   ; Parent := pnlPrintBarcode;HelpContext := 686030;  DnmAction := actPrintDespatchBarcode; Align := alClient; Visible := True; AlignWithMargins := True; Margins.Left := 1;Margins.right := 1; Margins.top := 1;Margins.Bottom:= 0; end;
end;

procedure TfmBarcodeAfterPacked.OptionSelected(Sender: TObject);
begin
  inherited;
//  if sender = actPrintDeldocket then chkPrintDeldocket.checked  := not(chkPrintDeldocket.checked);
//  if sender = actPrintCNote     then chkPrintCNote.checked      := not(chkPrintCNote.checked);
//  if sender = actPrintsale      then chkPrintsale.checked       := not(chkPrintsale.checked);
//  if sender = actPrintPick      then chkPrintPick.checked       := not(chkPrintPick.checked);
//  if sender = actPrintDespatchBarcode then chkPrintBarcode.checked := not(chkPrintBarcode.checked);

  chkPrintDeldocket.checked  := false;
  chkPrintCNote.checked      := false;
  chkPrintsale.checked       := false;
  chkPrintPick.checked       := false;
  chkPrintBarcode.checked    := false;

  if sender = actPrintDeldocket then chkPrintDeldocket.checked  := true;
  if sender = actPrintCNote     then chkPrintCNote.checked      := true;
  if sender = actPrintsale      then chkPrintsale.checked       := true;
  if sender = actPrintPick      then chkPrintPick.checked       := true;
  if sender = actPrintDespatchBarcode then chkPrintBarcode.checked := true;

  btnPrint.Click;
end;

procedure TfmBarcodeAfterPacked.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.active := TRue;
  ReadGuiPref;
  if chkPrintPick.Enabled and (not chkPrintDeldocket.Enabled) and
    (not chkPrintCNote.Enabled) and (not chkPrintBarcode.Enabled) then
   chkPrintPick.Checked := true;
end;

procedure TfmBarcodeAfterPacked.ReadGuipref;
begin
//  if GuiPrefs.Node.Exists('Options') then begin
//    chkPrintDeldocket.checked := StrToBoolean(GuiPrefs.Node['Options.PrintDeldocket'].AsString) and chkPrintDeldocket.Enabled;
//    chkPrintCNote.checked     := StrToBoolean(GuiPrefs.Node['Options.PrintCNote'].AsString) and chkPrintCNote.Enabled;
//    chkPrintsale.checked      := strToBoolean(GuiPrefs.Node['Options.Printsale'].asString) and chkPrintsale.Enabled;
//    chkPrintPick.checked      := strToBoolean(GuiPrefs.Node['Options.PrintPick'].asString) and chkPrintPick.Enabled;
//    chkPrintBarcode.checked   := strToBoolean(GuiPrefs.Node['Options.PrintBarcode'].asString) and chkPrintBarcode.Enabled;
//  end;
end;

procedure TfmBarcodeAfterPacked.WriteGuiPref;
begin
//    GuiPrefs.Node['Options.PrintDeldocket'].AsString:= BooleanToStr(chkPrintDeldocket.checked);
//    GuiPrefs.Node['Options.PrintCNote'].AsString    := BooleanToStr(chkPrintCNote.checked);
//    GuiPrefs.Node['options.Printsale'].asString     := booleantoStr(chkPrintsale.checked);
//    GuiPrefs.Node['options.PrintPick'].asString     := booleantoStr(chkPrintPick.checked);
//    GuiPrefs.Node['options.PrintBarcode'].asString  := booleantoStr(chkPrintBarcode.checked);
end;

procedure TfmBarcodeAfterPacked.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
  Action := caFree;
end;

procedure TfmBarcodeAfterPacked.btnSelectAllClick(Sender: TObject);
begin
  inherited;
  if chkPrintDeldocket.Enabled then chkPrintDeldocket.checked := true;
  if chkPrintCNote.Enabled then chkPrintCNote.checked     := true;
  if chkPrintsale.Enabled then chkPrintsale.checked      := True;
  if chkPrintPick.Enabled then chkPrintPick.checked      := True;
  if chkPrintBarcode.Enabled then chkPrintBarcode.checked   := True;
end;

procedure TfmBarcodeAfterPacked.DoExtraTranslation;
begin
  inherited;
  Guiprefs.DoTranslate;
end;

procedure TfmBarcodeAfterPacked.btncloseClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmBarcodeAfterPacked.FormCreate(Sender: TObject);
begin
  inherited;
  GuiPrefs := TFormGuiPrefs.Create(Self);
  Actionlist.Images := dtmMainGUI.ImageList;
  MakeButtons;
end;

procedure TfmBarcodeAfterPacked.btnPrintClick(Sender: TObject);
begin
  inherited;
  try
    Ownerform.AfterFinishProcess(chkPrintsale.checked, chkPrintDeldocket.checked, chkPrintCNote.checked, chkPrintPick.checked, chkPrintBarcode.Checked );
  Except
      // kill the exception if the owner is not TFrmbarcodepicking
  end;
  close;
end;

Function TfmBarcodeAfterPacked.Ownerform:TfmBarcodePicking;
begin
  result := nil;
  if assigned(Self.Owner) then
    if self.owner is TfmBarcodePicking then
      result := TfmBarcodePicking(Self.Owner);
end;

initialization
  RegisterClassOnce(TfmBarcodeAfterPacked);

end.
