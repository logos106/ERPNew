unit frmAttributemain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, GradientLabel,
  DNMPanel, DNMSpeedButton, Shader;

type
  TfmAttributemain = class(TBaseInputGUI)
    Panel1: TPanel;
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    sbGroup: TScrollBox;
    pnlGroups: TDNMPanel;
    pnlBtnsTitle: TPanel;
    lblList: TGradientLabel;
    Bevel2: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlMain: TDNMPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAttributemain: TfmAttributemain;

implementation

{$R *.dfm}

end.
