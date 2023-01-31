unit frmLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls;

type
  TfmLog = class(TfrmBaseGUI)
    lblMsg: TLabel;
    Timershow: TTimer;
    procedure lblMsgDblClick(Sender: TObject);
    procedure TimershowTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fLogMsg:String;
    procedure setLogMsg(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    Property LogMsg:String read fLogMsg write setLogMsg;
  end;


Function Logform: TfmLog;

implementation

{$R *.dfm}

var
  fLogform: TfmLog;


Function Logform: TfmLog;
begin
  if fLogform  = nil then begin
    fLogform :=  TfmLog.Create(Application);
    fLogform.Left:= Application.MainForm.Left + Application.MainForm.Width  - fLogform.Width;
    fLogform.Top:= Application.MainForm.Top   + Application.MainForm.Height - fLogform.Height  ;
    ShowWindow(fLogform.Handle, SW_SHOWNOACTIVATE);
    fLogform.Visible := False;
  end;
  Result := fLogform ;
end;

{ TfmLog }

constructor TfmLog.Create(AOwner: TComponent);
begin
  inherited;
  
end;

procedure TfmLog.FormCreate(Sender: TObject);
begin
  inherited;

end;

procedure TfmLog.lblMsgDblClick(Sender: TObject);
begin
  inherited;
  Self.Visible := False;
  Timershow.Enabled := False;
end;

procedure TfmLog.setLogMsg(const Value: String);
begin
  Timershow.Enabled := False;
  fLogMsg := Value;
  lblMsg.Caption := Value;
  Self.Height := lblMsg.Height;
  Left:= Application.MainForm.Left + Application.MainForm.Width  - Width;
  Top:= Application.MainForm.Top   + Application.MainForm.Height - Height  ;
  Self.Visible := trim(Value) <> '';
  Timershow.Enabled := True;
end;

procedure TfmLog.TimershowTimer(Sender: TObject);
begin
  inherited;
  Self.Visible := False;
  Timershow.Enabled := False;
end;

 initialization
  fLogform := nil;
end.

