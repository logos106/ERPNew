unit BackOrdersPopupForm;

interface

uses
  Classes, Forms, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, BaseInputForm, Controls, dmMainGUI,
  Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB,
   Graphics, Shader, DNMPanel, ImgList, MemDS , ImageDLLLib, ProgressDialog ;

type
  TBackOrdersPopupGUI = class(TBaseInputGUI)
    cmdCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

  private
    btn_1  : TERPMainSwitchButton;
    btn_2  : TERPMainSwitchButton;
    btn_3  : TERPMainSwitchButton;
  public

  end;

implementation

uses CommonLib;

{$R *.DFM}

procedure TBackOrdersPopupGUI.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TBackOrdersPopupGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TBackOrdersPopupGUI.FormCreate(Sender: TObject);
var
  iLeft :Integer;
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  iLeft := 28;
  btn_1	    := TERPMainSwitchButton.create(Self);  With btn_1  do begin  Name := MakeName(Self,'btn_1'); Parent := self;Left := iLeft;Top := 65;Width := 110;Height := 95;DnmAction := dtmMainGUI.SOBOListExpress  ;iLeft := iLeft +Width+3;end;
  btn_2	    := TERPMainSwitchButton.create(Self);  With btn_2  do begin  Name := MakeName(Self,'btn_1'); Parent := self;Left := iLeft;Top := 65;Width := 110;Height := 95;DnmAction := dtmMainGUI.INVBOListExpress  ;iLeft := iLeft +Width+3;end;
  btn_3	    := TERPMainSwitchButton.create(Self);  With btn_3  do begin  Name := MakeName(Self,'btn_1'); Parent := self;Left := iLeft;Top := 65;Width := 110;Height := 95;DnmAction := dtmMainGUI.POBOExpressList  ;end;
end;

initialization
  RegisterClassOnce(TBackOrdersPopupGUI);
end.
