unit frmMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,frmMessageBase, ExtCtrls, StdCtrls, DNMPanel, Menus;

type


  TfmMessage = class(TfmMessageBase)
    ScrollBox1: TScrollBox;
    TmrMsgFunc: TTimer;
    txtMsgText: TLabel;
    procedure TmrMsgFuncTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fMsgFunc: TMsgFunc;
    procedure setMsgText(const Value: String);
  Protected
    Procedure InitMsgDlg;overload;Override;
    procedure setMsgHeight(const Value: Integer);Override;
  public
    Property MsgText :String Write setMsgText;
    Property MsgFunc :TMsgFunc REad fMsgFunc write fMsgFunc;
    class function MsgDlg:Integer;overload;override;
  end;


implementation

uses tcConst;


{$R *.dfm}

{ TfrmBaseGUI1 }


procedure TfmMessage.setMsgHeight(const Value: Integer);
begin
  inherited;
  //txtMsgText.height := ScrollBox1.height +1;
end;

procedure TfmMessage.setMsgText(const Value: String);
begin
  txtMsgText.caption := Value;

  //txtMsgText.height := ScrollBox1.height +1;
end;
procedure TfmMessage.TmrMsgFuncTimer(Sender: TObject);
begin
  inherited;
  if Assigned(fMsgFunc) then
    if fMsgFunc then begin
        fiMsgResult :=1;
        self.Close;
    end;
end;

procedure TfmMessage.FormShow(Sender: TObject);
begin
  inherited;
  //txtMsgText.height := ScrollBox1.height +1;
end;

procedure TfmMessage.InitMsgDlg;
begin
  inherited;
  MsgText:= PopupMsgParams.MsgText;
  MsgFunc:= PopupMsgParams.MsgFunc;

  if Largefont then begin
      txtMsgText.Font.size := LARGE_FONT_SIZE;
      txtMsgText.Autosize := True;
      txtMsgText.Font.Style := txtMsgText.Font.Style +[fsBold];
      txtMsgText.Layout := tlcenter;
      txtMsgText.alignment := taCenter;
      txtMsgText.top := 0;
      txtMsgText.align := alclient;
    end;
end;

class function TfmMessage.MsgDlg: Integer;
begin
With TfmMessage.Create(nil) do try
  initMsgDlg;
  ShowModal;
  result :=  fiMsgResult;
finally
  Free;
end;
end;

end.

