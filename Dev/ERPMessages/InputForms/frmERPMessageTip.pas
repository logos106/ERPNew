unit frmERPMessageTip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, DNMPanel, DNMSpeedButton,
  Shader, wwcheckbox, SelectionDialog;

type
  TfmERPMessageTip = class(TBaseForm)
    pnlMain: TDNMPanel;
    lblTip: TLabel;
    Timertip: TTimer;
    lblLink: TLabel;
    DNMPanel1: TPanel;
    chkshowErptips: TwwCheckBox;
    lblMsg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TimertipTimer(Sender: TObject);
    procedure lblTipDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblLinkClick(Sender: TObject);
    procedure lblLinkMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkshowErptipsClick(Sender: TObject);
  private
    SecondsToclose:Integer;
    fiTipID: Integer;
    procedure showNextTip;
    { Private declarations }
  public
    Property TipID:Integer read fiTipID write fiTipID;

  end;



implementation

uses
  shellapi, CommonLib, CommonFormLib, ERPMessageTypes, ERPMessageLib,
  AppEnvironment, MainSwitchFrm2, MAIN;

{$R *.dfm}



procedure TfmERPMessageTip.lblLinkClick(Sender: TObject);
begin
  inherited;
  if lblLink.Caption = '' then exit;
  ShellExecute(Handle, 'open', PChar(lblLink.Caption), '', '', SW_SHOW);
end;

procedure TfmERPMessageTip.lblLinkMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  lblLinkClick(Sender);
end;

procedure TfmERPMessageTip.lblTipDblClick(Sender: TObject);
begin
  inherited;
//@@@@  MainSwitch2.btnVideos.Click;
//@@@  MainSwitch2.btnVideosClick(Self);
  Self.Close;
end;

procedure TfmERPMessageTip.showNextTip;
var
  s, sh:String;
begin
  Timertip.Enabled := False;
  s:= NextERPMessage(mtTip , sh , true, true, tipID);
  if s<> '' then begin
    lblTip.Caption := s;
    Timertip.Enabled := TRue;
  end;
  lblLink.caption := sh;
end;
procedure TfmERPMessageTip.chkshowErptipsClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkshowErptips then
  Appenv.employee.ShowERPTips :=chkshowErptips.Checked ;
end;

procedure TfmERPMessageTip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  //Processingcursor(False);
end;

procedure TfmERPMessageTip.FormCreate(Sender: TObject);
begin
  inherited;
    TipID := 0;
(*  Self.Top := mainswitch2.Top + Mainform.maintoolbar.height;
  Self.Left :=mainswitch2.Left;
  Self.Width:=mainswitch2.Width;*)

  Self.Top := mainswitch2.Top + Mainform.maintoolbar.height + mainswitch2.height - Self.Height+40;
  Self.Left :=mainswitch2.Left+3;
  Self.Width:=mainswitch2.Width;
  Secondstoclose:=10;
end;

procedure TfmERPMessageTip.FormShow(Sender: TObject);
begin
  inherited;
  showNextTip;
  Secondstoclose:=10;
  pnlMain.Color := clRed;
  chkshowErptips.Checked  := Appenv.employee.ShowERPTips ;
  //Processingcursor(True);
end;

procedure TfmERPMessageTip.TimertipTimer(Sender: TObject);
begin
  inherited;
  Secondstoclose := Secondstoclose-1;
  lblMsg.caption :='Closing in '+ inttostr(Secondstoclose)+' Seconds';
  lblMsg.Refresh;

  if Secondstoclose <=0 then Self.close;
end;

initialization
  RegisterClassOnce(TfmERPMessageTip);

end.
