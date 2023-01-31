unit frmWorkflowPlayPointer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, pngimage, ExtCtrls, StdCtrls, DNMPanel, Menus, GIFImg, DNMSpeedButton;

type
  TfmWorkflowPlayPointer = class(TfrmBaseGUI)
    lblMsg: TLabel;
    ImgPointerTop: TImage;
    ImgPointerbottom: TImage;
    procedure FormCreate(Sender: TObject);
    procedure lblMsgDblClick(Sender: TObject);
    procedure ImgPointerbottomDblClick(Sender: TObject);
    procedure ImgPointerTopDblClick(Sender: TObject);
  private

    fsWorkflowMsg:String;
    fWorkFlowcontrol :TControl;
    procedure SetWorkFlowPosition(const AlligntocontrolMiddle:Boolean; const Value: TPoint);
  Protected
    Spacing:String;
    procedure setWorkflowMsg(Value: String);Virtual;
  public
    Property WorkflowMsg:String read fsWorkflowMsg write setWorkflowMsg;
    Property WorkFlowPosition[const AlligntocontrolMiddle:Boolean] :TPoint write setWorkflowPosition;
    Property WorkFlowcontrol :TControl read fWorkFlowcontrol write fWorkFlowcontrol;
  end;

var
  fWorkflowPlayPointerForm: TfmWorkflowPlayPointer;

Function WorkflowPlayPointerForm: TfmWorkflowPlayPointer;

implementation

uses LogLib, tcConst, commonGuiLib;

{$R *.dfm}

procedure TfmWorkflowPlayPointer.FormCreate(Sender: TObject);
begin
  inherited;
(*  Self.Width := ImgPointer.Width;
  Self.height := ImgPointer.height;*)
  WorkflowMsg := '';
  fWorkFlowcontrol := nil;
  Spacing:=Nl;

 TGIFImage(ImgPointerbottom.Picture.Graphic).Animate := True;// gets it goin'
 TGIFImage(ImgPointerTop.Picture.Graphic).Animate := True;// gets it goin'
 //TGIFImage(ImgPointerTop.Picture.Graphic).AnimationSpeed:= 500;// adjust your speed
  DoubleBuffered := True;// stops flickering

end;
Function WorkflowPlayPointerForm: TfmWorkflowPlayPointer;
begin
  if fWorkflowPlayPointerForm  = nil then begin
    fWorkflowPlayPointerForm :=  TfmWorkflowPlayPointer.Create(Application);
    ShowWindow(fWorkflowPlayPointerForm.Handle, SW_SHOWNOACTIVATE);
    fWorkflowPlayPointerForm.Visible := False;
  end;
  Result := fWorkflowPlayPointerForm ;
  //ImgPointer.
end;

procedure TfmWorkflowPlayPointer.ImgPointerbottomDblClick(Sender: TObject);
begin
  inherited;
  Self.visible := False;
end;

procedure TfmWorkflowPlayPointer.ImgPointerTopDblClick(Sender: TObject);
begin
  inherited;
  Self.visible := False;
end;

procedure TfmWorkflowPlayPointer.lblMsgDblClick(Sender: TObject);
begin
  inherited;
  Self.visible := False;
end;

procedure TfmWorkflowPlayPointer.setWorkflowMsg(Value: String);
begin
  fsWorkflowMsg := Value;
  Value := trim(Value);
  if Value <> '' then Value :=Spacing+trim(Value)+Spacing;
  lblMsg.Caption := Value;
  lblMsg.visible := Value <> '';
  ImgPointertop.Top :=lblMsg.Height+1;
  ImgPointerbottom.Top :=lblMsg.Height+1;
  Self.height :=lblMsg.height + ImgPointertop.height;
end;

procedure TfmWorkflowPlayPointer.SetWorkFlowPosition(const AlligntocontrolMiddle:Boolean; const Value: TPoint);
begin
    ImgPointerbottom.left := lblMsg.Left + Trunc(lblMsg.Width/2) - Trunc(ImgPointerTop.Width/2) ;
    ImgPointerTop.Left :=ImgPointerbottom.left ;



  if AlligntocontrolMiddle then left := MiddlealignLeft(WorkFlowcontrol, self , Value.x)
  else left := Value.X;

  if Left <0 then begin
    ImgPointerbottom.left := ImgPointerbottom.left + Left;
    Left := 0;
    //ImgPointerbottom.left := MiddlealignLeft(WorkFlowcontrol, ImgPointerbottom , Value.x);
    ImgPointerTop.Left :=ImgPointerbottom.left ;
  end;
  top  := Value.Y - Height;
  if top <0 then begin
    top :=Value.Y + WorkFlowcontrol.Height;
    lblMsg.Align := albottom;
    ImgPointerbottom.top := 0;
    ImgPointerbottom.visible := True;
    ImgPointerTop.visible := False;
  end else begin
    lblMsg.Align := altop;
    ImgPointerbottom.visible := False;
    ImgPointerTop.visible := True;
    ImgPointertop.Top :=lblMsg.Height+1;
  end;
end;

initialization
  fWorkflowPlayPointerForm := nil;

end.

