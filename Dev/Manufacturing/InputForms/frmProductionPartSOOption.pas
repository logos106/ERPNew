unit frmProductionPartSOOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, StdCtrls, ExtCtrls, Shader,
  wwclearbuttongroup, wwradiogroup, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, DNMPanel;

type
  TfmProductionPartSOOption = class(TBaseInputGUI)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    DNMPanel1: TDNMPanel;
    btnok: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    rgoption: TwwRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnokClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fiMsgoption: Integer;
    { Private declarations }
    Procedure ReadGuipref;
    Procedure WriteGuiPref;

  public
    Property Msgoption :Integer REad fiMsgoption Write fiMsgoption;
  end;


implementation

uses GuiPrefsObj, CommonLib;

{$R *.dfm}
procedure TfmProductionPartSOOption.FormCreate(Sender: TObject);
begin
  inherited;
fiMsgoption:= -1;
end;

procedure TfmProductionPartSOOption.btnokClick(Sender: TObject);
begin
  inherited;
  fiMsgoption := rgoption.Itemindex;
  WriteGuiPref;
  ModalResult := mrOk;
end;

procedure TfmProductionPartSOOption.btnCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmProductionPartSOOption.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.active := TRue;
  ReadGuiPref;
end;

procedure TfmProductionPartSOOption.ReadGuipref;
begin
  if GuiPrefs.Node.Exists('Options') then
      rgoption.itemIndex := GuiPrefs.Node['Options.SOQtyOption'].AsInteger;
end;

procedure TfmProductionPartSOOption.WriteGuiPref;
begin
  GuiPrefs.Node['Options.SOQtyOption'].AsInteger:= rgoption.itemIndex ;
end;

initialization
  RegisterClassOnce(TfmProductionPartSOOption);

end.
