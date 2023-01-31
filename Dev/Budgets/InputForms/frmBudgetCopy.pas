unit frmBudgetCopy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, Mask, wwdbedit,
  wwclearbuttongroup, wwradiogroup, ExtCtrls, DNMPanel, Menus, AdvMenus, DataState,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB, Shader, ImgList,
  MemDS;

type
  TfmBudgetCopy = class(TBaseInputGUI)
    pnlVariation: TDNMPanel;
    Label9: TLabel;
    lblCopy: TLabel;
    rdbVariationOption: TwwRadioGroup;
    rdbVariationType: TwwRadioGroup;
    edtVariationAmt: TwwDBEdit;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    BitBtn3: TDNMSpeedButton;
    BitBtn2: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtVariationAmtKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBudgetCopy: TfmBudgetCopy;

implementation

uses CommonLib, AppEnvironment, DNMLib;

{$R *.dfm}

procedure TfmBudgetCopy.FormCreate(Sender: TObject);
begin
  inherited;
  ChangeCurrencyNameinRAdioGroup(rdbVariationType);
(* var
  currencyName: string;
  x: integer;
begin
  self.fbIgnoreAccessLevels := True;
  inherited;
  { change currency name for region }
  currencyName:= AppEnv.RegionalOptions.WholeCurrencyName;
  x:= rdbVariationType.Items.IndexOf('Dollars');
  if x >= 0 then
    rdbVariationType.Items[x]:= currencyName; *)
end;
procedure TfmBudgetCopy.edtVariationAmtKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
    if ((Key <'0') or (Key > '9')) and  (Key <> #8 ) and (Key <> '.') then Key := Chr(0);
end;

procedure TfmBudgetCopy.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if (AccessLevel > 2) then
    begin
      PostMessage(Handle, WM_CLOSE, 0, 0);
      Exit;
    end;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfmBudgetCopy);

end.
