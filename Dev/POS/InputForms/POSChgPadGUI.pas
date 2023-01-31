unit POSChgPadGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, BaseInputForm, ExtCtrls, DB, 
  POSEditPadsGUI, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdblook, SelectionDialog,
  AppEvnts, DataState, Menus, AdvMenus, Shader, DNMPanel;

type
  TPOSChgPadPopUP = class(TBaseInputGUI)
    btnOK: TDNMSpeedButton;
    cboKeyPads: TwwDBLookupCombo;
    qryKeypads: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    frmSender: TPOSEditPadsPopUp;
  end;



implementation

uses CustomizePOSGUI, CommonLib;

{$R *.dfm}

procedure TPOSChgPadPopUP.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
  frmSender := nil;
end;


procedure TPOSChgPadPopUP.btnOKClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSender) then begin
    CustomizePOSGUI.iChosenIndex := cboKeyPads.LookupTable.FieldByName('KeypadID').AsInteger;
  end else begin
    TPOSEditPadsPopUp(frmSender).iKeypadID := cboKeyPads.LookupTable.FieldByName('KeypadID').AsInteger;
  end;
end;

procedure TPOSChgPadPopUP.FormShow(Sender: TObject);
begin
  inherited;
  qryKeypads.Close;   
  qryKeypads.Open;
end;

Initialization
  RegisterClassOnce(TPOSChgPadPopUP);

end.
