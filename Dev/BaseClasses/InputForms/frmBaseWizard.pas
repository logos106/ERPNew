unit frmBaseWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMSpeedButton, AdvPicture, StdCtrls, Shader, DNMPanel,
  fraBaseWizardPage;

type
  TPageButton = class(TDNMSpeedButton)
  public
    Page: TfrBaseWizardPage;
  end;


  TfmBaseWizard = class(TBaseInputGUI)
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Shader1: TShader;
    pnlActivePage: TLabel;
    AdvPicture1: TAdvPicture;
    sbPages: TScrollBox;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnPrior: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    procedure PageButtonClick(Sender: TObject);
    function GetSelectedPage: TfrBaseWizardPage;
    procedure SetSelectedPage(const Value: TfrBaseWizardPage);
    function GetPriorPage: TfrBaseWizardPage;
    function GetNextPage: TfrBaseWizardPage;
  protected
    procedure OnPageChange(FromPage, ToPage: TfrBaseWizardPage; var AllowChange: boolean);
  public
    procedure AddPage(aPage: TfrBaseWizardPage);
    property SelectedPage: TfrBaseWizardPage read GetSelectedPage write SetSelectedPage;
//    procedure Initialise;
  end;

var
  fmBaseWizard: TfmBaseWizard;

implementation

{$R *.dfm}

procedure TfmBaseWizard.AddPage(aPage: TfrBaseWizardPage);
var
  PrevButton, Button: TPageButton;
  x: integer;
begin
  PrevButton := nil;
  for x := self.ComponentCount -1 downto 0 do begin
    if self.Components[x] is TPageButton then begin
      PrevButton := TPageButton(self.Components[x]);
      break;
    end;
  end;

  Button := TPageButton.Create(Self);

  with Button do begin
    Page:= aPage;
    Left := 14;
    if Assigned(PrevButton) then
      Top := PrevButton.Top + PrevButton.Height + 2
    else
      Top := 10;
    Width := 148;
    Height := 28;
    Caption := aPage.PageName;
    Parent := pnlButtons;
    Alignment := taCenter;
    Color := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
    OnClick := PageButtonClick;
  end;

  aPage.Button := Button;
  aPage.pnlMain.Parent:= sbPages;
  aPage.pnlMain.Left:= 0;
  aPage.pnlMain.Top:= 0;
  aPage.pnlMain.Width:= sbPages.ClientWidth;
  if not Assigned(PrevButton) then
    SelectedPage := aPage
  else
    aPage.Selected := false;
  aPage.AfterPageAdded(self);
end;

procedure TfmBaseWizard.btnNextClick(Sender: TObject);
var
  page: TfrBaseWizardPage;
begin
  inherited;
  page := GetNextPage;
  if Assigned(Page) then
    SelectedPage := Page;
end;

procedure TfmBaseWizard.btnPriorClick(Sender: TObject);
var
  page: TfrBaseWizardPage;
begin
  inherited;
  page := GetPriorPage;
  if Assigned(Page) then
    SelectedPage := Page;
end;

procedure TfmBaseWizard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmBaseWizard.FormShow(Sender: TObject);
var
//  pg: TfrBaseWizardPage;
  x: integer;
begin
  inherited;
//  AddPage(TfrBaseWizardPage.Create(self));
//  pg:= TfrBaseWizardPage.Create(self);
//  pg.PageName:= 'Page 2';
//  pg.pnlMain.Caption := 'Page2';
//  AddPage(pg);
//  pg:= TfrBaseWizardPage.Create(self);
//  pg.PageName := 'Page 3';
//  pg.pnlMain.Caption := 'Page3';
//  AddPage(pg);
  for x := 0 to self.ComponentCount -1 do begin
    if self.Components[x] is TfrBaseWizardPage then
      TfrBaseWizardPage(self.Components[x]).OnWizardInitialise(self);
  end;
end;

function TfmBaseWizard.GetNextPage: TfrBaseWizardPage;
var
  x: integer;
  first, current: TfrBaseWizardPage;
begin
  result := nil;
  current := nil;
  first := nil;
  for x := 0 to self.ComponentCount -1 do begin
    if (self.Components[x] is TfrBaseWizardPage) then begin
      if not Assigned(first) then first := TfrBaseWizardPage(self.Components[x]);
      if not Assigned(current) then begin
        if TfrBaseWizardPage(self.Components[x]).Selected then
          current := TfrBaseWizardPage(self.Components[x]);
      end
      else begin
        result:= TfrBaseWizardPage(self.Components[x]);
        exit;
      end;
    end;
  end;
  if (not Assigned(result)) and Assigned(First) and (not Assigned(Current)) then
    result:= first;
end;

function TfmBaseWizard.GetPriorPage: TfrBaseWizardPage;
var
  x: integer;
  first, current: TfrBaseWizardPage;
begin
  result := nil;
  current := nil;
  first := nil;
  for x := self.ComponentCount -1 downto 0 do begin
    if (self.Components[x] is TfrBaseWizardPage) then begin
      first := TfrBaseWizardPage(self.Components[x]);
      if not Assigned(current) then begin
        if TfrBaseWizardPage(self.Components[x]).Selected then
          current := TfrBaseWizardPage(self.Components[x]);
      end
      else begin
        result:= TfrBaseWizardPage(self.Components[x]);
        exit;
      end;
    end;
  end;
  if (not Assigned(result)) and Assigned(First) then
    result:= first;
end;

function TfmBaseWizard.GetSelectedPage: TfrBaseWizardPage;
var
  x: integer;
begin
  result := nil;
  for x := 0 to self.ComponentCount -1 do begin
    if (self.Components[x] is TfrBaseWizardPage) and (TfrBaseWizardPage(self.Components[x]).Selected) then begin
      result := TfrBaseWizardPage(self.Components[x]);
      break;
    end;
  end;
end;

procedure TfmBaseWizard.OnPageChange(FromPage, ToPage: TfrBaseWizardPage;
  var AllowChange: boolean);
begin

end;

procedure TfmBaseWizard.PageButtonClick(Sender: TObject);
begin
  SelectedPage := TPageButton(Sender).Page;
end;

procedure TfmBaseWizard.SetSelectedPage(const Value: TfrBaseWizardPage);
var
  FromPage: TfrBaseWizardPage;
  AllowChange: boolean;
begin
  AllowChange := true;
  FromPage := GetSelectedPage;
  if (not Assigned(FromPage)) or (FromPage <> Value) then begin
    OnPageChange(FromPage, Value, AllowChange);
    if AllowChange then begin
      if Assigned(FromPage) then FromPage.Selected := false;
      Value.Selected := true;
      pnlActivePage.Caption:= Value.PageName;
//      TDNMSpeedButton(Value.Button).Focused := true;
    end;
  end;
end;

initialization
  RegisterClass(TfmBaseWizard);

end.
