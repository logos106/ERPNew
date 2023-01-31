unit frmERPRunningHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, DNMPanel, AdvScrollBox;

type
  TfmERPRunningHelp = class(TBaseForm)
    DNMPanel1: TDNMPanel;
    sbMain: TAdvScrollBox;
    lblMsg: TLabel;
    pnlfooter: TDNMPanel;
    btnClose: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateParams(var Params: TCreateParams);Override;
    procedure FormResize(Sender: TObject);
  private
    fiOwnerformtop: Integer;
    fiOwnerheight : Integer;
    colorIndex:Integer;
    fsformOwnerform: String;

    { Private declarations }
  public
    Procedure ShowERPRunningHelp(Const Value:String);Overload;
    Property Ownerformtop :Integer read fiOwnerformtop write fiOwnerformtop;

    Property formOwnerform:String read fsformOwnerform Write fsformOwnerform;
    Class function  ShowERPRunningHelp(const Value: String;Aowner:Tform(*; fwidth:Integer=0;ftop:Integer=0;fLeft:Integer=0*)):TfmERPRunningHelp;Overload;
  end;


implementation

uses CommonLib, MAIN, LogLib;

{$R *.dfm}
{ TfmERPRunningHelp }

Class function  TfmERPRunningHelp.ShowERPRunningHelp(const Value: String;Aowner:Tform(*; fwidth:Integer=0;ftop:Integer=0;fLeft:Integer=0*)):TfmERPRunningHelp;
var
  Form :TfmERPRunningHelp;
begin
  form :=TfmERPRunningHelp(GetComponentByClassName('TfmERPRunningHelp' , false , AOwner));
  if Assigned(form) THEN begin
    if form.visible = False then begin
        if AOwner.FormStyle = fsmdichild then begin
          Form.formstyle := fsMdichild;
        end else begin
          form.Show;
        end;
    end;
    form.Ownerformtop := AOwner.top;
    form.height       := Aowner.height -20;
    form.top          := AOwner.top+10;
    form.Left         := AOwner.left + AOwner.width+10;
    form.Width        := Mainform.width - AOwner.left- AOwner.width-40;
    if form.formOwnerform = '' then form.formOwnerform := AOwner.Classname;
    form.borderstyle  := bsnone;
    form.bringTofront;
    form.fiOwnerheight := AOwner.height -20;
    form.ShowERPRunningHelp(Value);
  end;
  form.bringTofront;
  Logtext('After show');
  Logtext('form:' +inttostr(form.top)+'.'+
                     inttostr(form.left)+'.'+
                     inttostr(form.Width)+'.'+
                     inttostr(form.height));
  Logtext('lblMsg:' +inttostr(form.lblMsg.top)+'.'+
                     inttostr(form.lblMsg.left)+'.'+
                     inttostr(form.lblMsg.Width)+'.'+
                     inttostr(form.lblMsg.height));
  Result := Form;
end;

procedure TfmERPRunningHelp.ShowERPRunningHelp(const Value: String);
begin
  lblMsg.caption := Value;
  //lblMsg.Height :=   CharCounter(chr(13), Value)*35;
  Self.Height :=   CharCounter(chr(13), Value)*35+pnlfooter.height+20;
  if Self.Height < 160 then height := 160;
  Self.top :=  fiOwnerformtop +10;
  if height > fiOwnerheight  then height := fiOwnerheight;
  Self.bringtofront;
end;

procedure TfmERPRunningHelp.FormCreate(Sender: TObject);
begin
  inherited;
  fiOwnerformtop:= 0;
  fiOwnerheight  := 0;
  colorIndex:= 1;
  fsformOwnerform:= '';
end;

procedure TfmERPRunningHelp.FormResize(Sender: TObject);
begin
  inherited;
  (*sbMain.left := 0;
  sbMain.top :=0;
  sbMain.height := self.height - pnlfooter.height;
  sbMain.Width := self.width;*)
  lblMsg.left :=5;
  lblMsg.top := 5;
  lblMsg.width :=sbMain.Width-10;
  lblMsg.height :=sbMain.height-10;
  Logtext('Resize');
  Logtext('form:' +inttostr(top)+'.'+
                     inttostr(left)+'.'+
                     inttostr(Width)+'.'+
                     inttostr(height));
  Logtext('lblMsg:' +inttostr(lblMsg.top)+'.'+
                     inttostr(lblMsg.left)+'.'+
                     inttostr(lblMsg.Width)+'.'+
                     inttostr(lblMsg.height));
end;

procedure TfmERPRunningHelp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;
procedure TfmERPRunningHelp.CreateParams(var Params: TCreateParams) ;
 begin
 inherited;
   Params.style := Params.style and not WS_CAPTION;
 end;
initialization
  RegisterClassOnce(TfmERPRunningHelp);

end.
