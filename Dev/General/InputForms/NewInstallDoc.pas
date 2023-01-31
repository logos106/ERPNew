unit NewInstallDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, StdCtrls, wwcheckbox,Printers,
  AdvPicture, jpeg;

type
  TNewInstallDocGUI = class(TForm)
    Panel1: TPanel;
    btnClose: TDNMSpeedButton;
    ScrollBox: TScrollBox;
    Image1: TImage;
    chkDontShow: TwwCheckBox;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkDontShowClick(Sender: TObject);
    procedure ScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib,  AppEnvironment;

{$R *.dfm}

procedure TNewInstallDocGUI.FormCreate(Sender: TObject);
var
  Index: integer;
begin
  for Index := 0 to Self.ComponentCount - 1 do begin
    If Self.Components[Index] is TDNMSpeedButton then 
      with TDNMSpeedButton(Self.Components[Index]) do begin
        Alignment := taCenter;
        Color := clWhite;
        HotTrackColor := clBtnShadow;
        SlowDecease := true;
        Style := bsModern;
      end;
  end;
end;

procedure TNewInstallDocGUI.btnCloseClick(Sender: TObject);
begin
 Self.Close;
end;

procedure TNewInstallDocGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TNewInstallDocGUI.chkDontShowClick(Sender: TObject);
begin
  AppEnv.Employee.ShowNewInstallDoc := Not chkDontShow.Checked;
end;

procedure TNewInstallDocGUI.ScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Scrollbox.perform( wm_vscroll, SB_LINEDOWN, 0 );
end;

procedure TNewInstallDocGUI.ScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Scrollbox.perform( wm_vscroll, SB_LINEUP, 0 );
end;

procedure TNewInstallDocGUI.Timer1Timer(Sender: TObject);
begin
  CommonLib.SetControlFocus(ScrollBox);
end;

initialization
  RegisterClassOnce(TNewInstallDocGUI);
end.
