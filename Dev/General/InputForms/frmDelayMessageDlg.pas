unit frmDelayMessageDlg;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/12/05  1.00.01 IJB  Initial version.

}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfmDelayMessageDlg = class(TForm)
    Timer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
    DialogMessage: string;
    DialogType: TMsgDlgType;
    DialogButtons: TMsgDlgButtons;
    DialogHelpContext: longword;
  end;

  { This procedure displays a normal MessageDlg after a short delay
    (to allow combo drop downs to close up etc) }
procedure DelayMessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: longint; IsErrorMsg:Boolean =False);
Procedure CloseallUserMsgs;

implementation

uses CommonDbLib,CommonLib, AppEnvironment;

{$R *.dfm}

Procedure CloseAllUserMsgs;
begin
      While FormStillOpen('TfmDelayMessageDlg') Do Begin
        TForm(FindExistingComponent('TfmDelayMessageDlg')).BringToFront;
        Sleep(100);
        Application.ProcessMessages;
      end;
end;
procedure DelayMessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: longint; IsErrorMsg:Boolean =False);
var
  Form: TfmDelayMessageDlg;
  x, count: integer;
  HasError :Boolean;
begin
  if appenv.appdb.apimode  then exit;

  count:= 0;
  HasError := False;
  for x:= 0 to Application.ComponentCount -1 do begin
    if Application.Components[x] is TfmDelayMessageDlg then begin
      Inc(count);
      if TfmDelayMessageDlg(Application.Components[x]).DialogType = mtError then HasError:= True;
    end;
  end;
  if (count > 5) and (not(IsErrorMsg) or HasError) then
    exit;
  Form := TfmDelayMessageDlg.Create(Application);
  Form.DialogMessage := Msg;
  Form.DialogType := DlgType;
  if devmode and  IsErrorMsg then Form.DialogType := mtError;
  Form.DialogButtons := Buttons;
  Form.DialogHelpContext := HelpCtx;
  Form.Timer.Enabled:= true;
end;

procedure TfmDelayMessageDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer.Enabled:= false;
  inherited;
  Action := caFree;
end;

procedure TfmDelayMessageDlg.TimerTimer(Sender: TObject);
begin
  if fbMessaging then exit; // if another message is already showing wait until its closed
  Timer.Enabled := false;
  CommonLib.MessageDlgXP_Vista(DialogMessage, DialogType, DialogButtons, DialogHelpContext);
  Close;
end;

procedure TfmDelayMessageDlg.FormPaint(Sender: TObject);
begin
  PaintGradientColor(Self);
end;

procedure TfmDelayMessageDlg.FormDestroy(Sender: TObject);
begin
  Timer.Enabled := false;
  inherited;
end;

end.
