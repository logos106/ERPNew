unit frmMessagePanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel, frmMessageBase,
  Menus;

type
  TfmMessagePanel = class(TfmMessageBase)
  private
    fPanel: TPanel;
    panelParent :TWincontrol;
    paneltop, panelleft, panelheight, panelwidth:Integer;
    panelAlign :TAlign;
    procedure setPanel(const Value: TPanel);
    { Private declarations }
  Protected
    Procedure InitMsgDlg;overload;Override;
    procedure SetMsgWidth(const Value: Integer);Override;
  public
    //class procedure MsgDlg(panel :TDNMPanel; xMsgcaption:String ;xCustombuttons:String;xMsg1,xMsg2:String);
    class function MsgDlg:Integer;Override;
    Property PAnel :TPanel read fPanel write setPanel;
  end;

implementation

{$R *.dfm}

(*class procedure TfmMessagePanel.MsgDlg(panel :TDNMPanel; xMsgcaption:String ;xCustombuttons:String;xMsg1,xMsg2:String);
var
  form:TfmMessagePanel;
  panelParent :TWincontrol;
  paneltop, panelleft, panelheight, panelwidth:Integer;
  panelAlign :TAlign;
begin
  form := TfmMessagePanel.Create(nil);
  try
    {store Panel Properties}
    panelParent:= Panel.Parent;
    PanelTop:= Panel.Top;
    Panelheight := panel.Height;
    Panelwidth := panel.Width;
    Panelleft:= Panel.left;
    PanelAlign := Panel.align;

    form.Width := panel.Width+20;
    form.initMsgDlg(xMsgcaption, xCustombuttons,xMsg1,xMsg2);
    form.Height := Panel.height + form.pnlbottom.height +form.pnltop.Height+ form.pnlFooter.Height;
    Panel.Parent := Form.pnlDetails;
    Panel.align := alclient;
    form.Showmodal;

    Panel.Align := Panelalign;
    panel.Top:= Paneltop;
    Panel.Left:= panelleft;
    Panel.width := Panelwidth;
    Panel.Height := panelheight;
    Panel.Parent := panelParent;

  finally
    Freeandnil(form);
  end;
end;*)

{ TfmMessagePanel }

procedure TfmMessagePanel.InitMsgDlg;
begin
  Panel := PopupMsgParams.panel;
  inherited;
end;

class function TfmMessagePanel.MsgDlg:Integer;
begin
  inherited;
With TfmMessagePanel.Create(nil) do try
  initMsgDlg;
  ShowModal;
  result :=  fiMsgResult;
finally
    Panel.Align := Panelalign;
    Panel.Top:= Paneltop;
    Panel.Left:= panelleft;
    Panel.width := Panelwidth;
    Panel.Height := panelheight;
    Panel.Parent := panelParent;
  Free;
end;

end;

procedure TfmMessagePanel.SetMsgWidth(const Value: Integer);
begin
  if (fPanel <> nil) and (Value < fPanel.width) then inherited SetMsgWidth(fPanel.width) else inherited SetMsgWidth(Value);
end;

procedure TfmMessagePanel.setPanel(const Value: TPanel);
begin
    fPanel := Value;
    {store Panel Properties}
    panelParent:= Value.Parent;
    PanelTop:= Value.Top;
    Panelheight := Value.Height;
    Panelwidth := Value.Width;
    Panelleft:= Value.left;
    PanelAlign := Value.align;
    Width := Value.Width+20;
    MsgHeight := Value.height + lblbottom.height +lbltop.Height+ pnlFooter.Height+50;
    Value.Parent := pnlDetails;
    Value.align := alclient;
end;

end.

