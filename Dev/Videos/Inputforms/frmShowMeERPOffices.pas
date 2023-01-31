unit frmShowMeERPOffices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  GuiPrefsObj, Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, DNMPanel , ShowMeERPOffices,BaseListingForm,
  Shader, SelectionDialog;

type
  TfmShowMeERPOffices = class(TBaseForm)
    pnlMain: TDNMPanel;
    Panel1: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fShowMeERPOffices :TBaseListingGUI;
    GuiPrefs: TFormGuiPrefs;
    Function ShowMeERPOffices :TShowMeERPOfficesGUI;
    Procedure CloseFormclick(Sender:TObject);
  Protected
    Procedure AfterFormShow; Override;
  public
    class function ShowMe: TfmShowMeERPOffices;
    procedure DoShowMe;
  end;


implementation

uses CommonFormLib, frmShowMe, CommonLib , MAIN;


{$R *.dfm}

{ TfmShowMeERPOffices }

procedure TfmShowMeERPOffices.AfterformShow;
(*
  function ShowMeform :TfmShowMe ;
  begin
    //result := TfmShowMe(FindExistingComponent('TfmShowMe'));
    Result :=
  end;

  Function DefaultTop :Integer ;
  begin
    result := ShowMeform.top+(ShowMeform.height-height);
  end;
*)
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.Left') then
    Left:=  GuiPrefs.Node['Options.Left'].asInteger
  else
    // Left := ShowMeform.Left - Self.Width;
    Left := Application.MainForm.Width - Self.Width - 10;
  if GuiPrefs.Node.Exists('Options.top')  then
    Top:=  GuiPrefs.Node['Options.top'].asInteger
  else
    //top:= DefaultTop;
    top := Application.MainForm.Height - Self.Height - 6;

//  if (Left <(Application.MainForm.Left)) or ((Left+width >(ShowMeform.Left)) and (ShowMeform.top+ShowMeform.height > Top) ) then
//    Left := ShowMeform.Left - Self.Width;
//  if (top <(Application.MainForm.top  )) or (top  <DefaultTop) then top:= DefaultTop;

end;

procedure TfmShowMeERPOffices.CloseFormclick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfmShowMeERPOffices.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  GuiPrefs.Node['Options.Left'].asInteger:= Left;
  GuiPrefs.Node['Options.top'].asInteger := Top;
  try
    GuiPrefs.SavePrefs; except end;
  inherited;
  Action := cafree;
end;

procedure TfmShowMeERPOffices.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then self.close;
end;

procedure TfmShowMeERPOffices.FormShow(Sender: TObject);
begin
  inherited;
  ShowMeERPOffices;
  if not(Assigned(fShowMeERPOffices)) then exit;
  TShowMeERPOfficesGUI(fShowMeERPOffices).ShowbuttonsinPanel := True;
  TShowMeERPOfficesGUI(fShowMeERPOffices).Parent := pnlMain;
  TShowMeERPOfficesGUI(fShowMeERPOffices).fbIgnoreQuerySpeed := true;
  TShowMeERPOfficesGUI(fShowMeERPOffices).Show;
  TShowMeERPOfficesGUI(fShowMeERPOffices).pnlButtons.visible := False;
  if devmode then begin
    TShowMeERPOfficesGUI(fShowMeERPOffices).btnDetails.left := TRunc(TShowMeERPOfficesGUI(fShowMeERPOffices).Width /2)- (TShowMeERPOfficesGUI(fShowMeERPOffices).cmdClose.width+20);
    TShowMeERPOfficesGUI(fShowMeERPOffices).btnDetails.Enabled := True;
    TShowMeERPOfficesGUI(fShowMeERPOffices).cmdClose.left := TRunc(TShowMeERPOfficesGUI(fShowMeERPOffices).Width /2) + 20;
    TShowMeERPOfficesGUI(fShowMeERPOffices).cmdclose.Enabled := True;
  end else begin
    TShowMeERPOfficesGUI(fShowMeERPOffices).cmdClose.left := TRunc(TShowMeERPOfficesGUI(fShowMeERPOffices).Width /2)- trunc(TShowMeERPOfficesGUI(fShowMeERPOffices).cmdClose.width/2);
    TShowMeERPOfficesGUI(fShowMeERPOffices).cmdclose.Enabled := True;
    TShowMeERPOfficesGUI(fShowMeERPOffices).btnDetails.Visible := False;
  end;

  TShowMeERPOfficesGUI(fShowMeERPOffices).cmdclose.OnClick := CloseFormclick;
  TShowMeERPOfficesGUI(fShowMeERPOffices).barStatus.visible := devMode;
  //TShowMeERPOfficesGUI(fShowMeERPOffices).pnlbuttons.visible := False;
  TShowMeERPOfficesGUI(fShowMeERPOffices).HeaderPanel.visible := False;
  TShowMeERPOfficesGUI(fShowMeERPOffices).FooterPanel.height := 54;
  TShowMeERPOfficesGUI(fShowMeERPOffices).grdmain.Hint := '';

  GuiPrefs := TFormGuiPrefs.Create(Self);
  GuiPrefs.Active := TRue;
end;

function TfmShowMeERPOffices.ShowMeERPOffices: TShowMeERPOfficesGUI;
begin
  CreateHistorylistform('TShowMeERPOfficesGUI' ,Self, fShowMeERPOffices);
  fShowMeERPOffices.ShowbuttonsinPanel := False;
  result := TShowMeERPOfficesGUI(fShowMeERPOffices);
end;
class Function TfmShowMeERPOffices.ShowMe: TfmShowMeERPOffices;
begin
  result := TfmShowMeERPOffices(GetComponentByClassName('TfmShowMeERPOffices', True));
  result.DoShowMe;
end;

Procedure TfmShowMeERPOffices.DoShowMe;
begin
  if not visible then
  begin
    //Visible := True;
    FormStyle := fsMdichild;
  end;
  BringToFront;
end;

initialization
  RegisterClassOnce(TfmShowMeERPOffices);
end.
