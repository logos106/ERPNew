unit frmMessageStayontop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMPanel;

type
  TfmMessageStayontop = class(TfrmBaseGUI)
    MsgTimer: TTimer;
    Panel1: TPanel;
    pnlMain: TDNMPanel;
    lblMessage: TLabel;
    lbltimer: TLabel;
    procedure FormShow(Sender: TObject);
    procedure MsgTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblMessageDblClick(Sender: TObject);
  private
    fiMsgtime:Integer;
    fitime:Integer;
    fsMessagevalue: String;
    procedure SetMessagevalue(const Value: String);
  public
    Property Messagevalue:String read fsMessagevalue write SetMessagevalue;
    Property inttime :Integer read fitime write fitime;
    Class Procedure ShowMessage(Aowner:TComponent; const Msg:String; Interval :Integer = 10);
  end;

implementation

uses tcConst;

{$R *.dfm}


{ TfmMessageStayontop }

procedure TfmMessageStayontop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmMessageStayontop.FormShow(Sender: TObject);
begin
  inherited;
  fiMsgtime  := 0;
  MsgTimer.Enabled:= True;
end;

procedure TfmMessageStayontop.lblMessageDblClick(Sender: TObject);
begin
  inherited;
  fiMsgtime :=  fitime;
end;

procedure TfmMessageStayontop.MsgTimerTimer(Sender: TObject);
begin
  inherited;
  fiMsgtime := fiMsgtime +1;
  lbltimer.Caption:= 'Hiding in ' + inttostr(fitime-fiMsgtime)+' Seconds)'+NL+'(Please Double Click on the Msg to Hide)';
  lbltimer.REfresh;
  if fiMsgtime >= fitime then begin
     MsgTimer.Enabled:= False;
     Self.Close;
  end;
end;

procedure TfmMessageStayontop.SetMessagevalue(const Value: String);
begin
  if fsMessagevalue <> Value then begin
    fsMessagevalue := Value;
    lblMessage.Caption := Value;
    lblMessage.REfresh;
  end;
end;

class procedure TfmMessageStayontop.ShowMessage(Aowner:TComponent;const Msg: String;  Interval: Integer=10);
begin
  if Msg = '' then exit;
  if Interval =0 then Interval := 10;
  With TfmMessageStayontop.Create(AOwner) do begin
     Messagevalue := Msg;
     inttime := Interval;
     formstyle := fsStayontop;
     show;
     if AOwner is TForm then begin
       (*Transparentcolor := TRue;
       TransparentcolorValue := TForm(AOwner).Color;*)
       color := TForm(AOwner).Color;
     end;
  end;
end;

end.
