unit frmMessageBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, DNMPanel, DNMSpeedButton,
  BaseFormForm, db, Menus;

type
  TMsgFunc          = Function  :Boolean    of Object;

  TPopupMsgParams = record
      Msgcaption:String ;
      MsgText:String;
      Custombuttons:String   ;
      Msg1:String;
      Msg2:String ;
      MsgFunc :TMsgFunc;
      MsgLeft:Integer;
      MsgTop:Integer;
      Defaultbutton:Integer;
      MsgHeight :Integer;
      MsgWidth :Integer;
      MsgColor :TColor;
      ChkCaption:String;
      checked:Boolean;
      Largefont:Boolean;
      MsgDs:TDataset;
      fieldnames :String;
      displayLabels:String ;
      Displaywidths:String;
      panel :TDNMPanel;
      MsgTExtForGrid:String;
      MsgTExtForGridDelim :String;
      Chkclick :TNotifyEvent;
      HideinGridwhen0:Boolean;
      Multiselect : Boolean;
      IdFieldname :String;
  end;


  TfmMessageBase = class(TfrmBaseGUI)
    pnlFooter: TDNMPanel;
    DnMPanel1: TDNMPanel;
    pnlDetails: TDNMPanel;
    Bevel1: TBevel;
    chk: TCheckBox;
    lbltop: TLabel;
    lblBottom: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkClick(Sender: TObject);
  private
    btnTag:Integer;
    fiMsgLeft: Integer;
    fiMsgTop: Integer;
    ButtonCtr:Integer;
    fiHeight: Integer;
    fcolor: Tcolor;
    fbPainting:Boolean;
    fiMsgWidth: Integer;
    fbLargefont :boolean;
    procedure setMsgcaption(const Value: String);
    procedure SetCustomButtons(const Value: String);
    Procedure MsgButtonclick(Sender:TObject);
    procedure setMsg1(const Value: String);
    procedure setcolor(const Value: Tcolor);
    procedure setMsg2(const Value: String);
    function getCheckboxcaption: String;
    procedure setCheckboxcaption(const Value: String);
    function getChecked: Boolean;
    function getLargefont: Boolean;
    procedure setChecked(const Value: Boolean);
    procedure setLargefont(const Value: Boolean);


  Protected
    fiMsgResult: Integer;
    fDefaultButton:TDNMSpeedButton;
    //Procedure InitMsgDlg(xMsgcaption:String ;xCustombuttons:String   ;xMsg1,xMsg2:String ; xiMsgLeft:Integer =0; xiMsgTop:Integer =0;Defaultbutton:Integer=0;xMsgHeight :Integer =0;xMsgColor :TColor=$00FFFFD7;xChkCaption:String ='');overload;virtual;
    Procedure InitMsgDlg;overload;virtual;
    procedure setMsgHeight(const Value: Integer);virtual;
    procedure SetMsgWidth(const Value: Integer);virtual;

  public
    Property Msgcaption:String Write setMsgcaption;
    Property Custombuttons:String write SetCustomButtons;
    Property MsgResult :Integer read fiMsgResult;
    Property Msg1:String Write setMsg1;
    Property Msg2 :String write setMsg2;
    Property MsgTop :Integer read fiMsgTop write fiMsgTop;
    Property MsgLeft :Integer Read fiMsgLeft Write fiMsgLeft;
    Property MsgHeight :Integer read fiHeight write setMsgHeight;
    Property MsgWidth :Integer read fiMsgWidth write SetMsgWidth;
    Property Msgcolor :Tcolor read fcolor write setcolor;
    Property Checkboxcaption :String read getCheckboxcaption write setCheckboxcaption;
    Property Checked :Boolean read getChecked write setChecked;
    Property Largefont :Boolean read getLargefont write setLargefont;

    class function MsgDlg:Integer;overload;virtual;



  end;

function MsgLine(double:Boolean =False):String;
Procedure InitMsgParams;

var
  PopupMsgParams:TPopupMsgParams;

implementation

uses CommonLib, CommonDbLib, tcTypes, tcConst;

{$R *.dfm}
{ TfmMessage }

procedure TfmMessageBase.setMsgcaption(const Value: String);
begin
  Self.Caption := Value;
end;

procedure TfmMessageBase.setMsgHeight(const Value: Integer);
begin
  if Value =0 then exit;
  fiHeight := Value;
  Self.Height := Value;
end;

procedure TfmMessageBase.SetMsgWidth(const Value: Integer);
begin
  if value<> 0 then begin
    fiMsgWidth := Value;
    Self.Width := Value;
  end;
end;

procedure TfmMessageBase.chkClick(Sender: TObject);
begin
  inherited;
  if Assigned(PopupMsgParams.Chkclick) then
    PopupMsgParams.Chkclick(chk);
end;

procedure TfmMessageBase.FormCreate(Sender: TObject);
begin
  inherited;
  fDefaultButton:= nil;
  fbPainting := False;
  self.caption:= '';
  btnTag      :=100;
  fiMsgResult :=0;
  fiMsgLeft   :=0;
  fiMsgTop    :=0;
  ButtonCtr:= 0;
end;


procedure TfmMessageBase.SetCustomButtons(const Value: String);
var
  Button: TDNMSpeedButton;
  st:tSTringList;
  ctr:Integer;
  iGap:Integer;
  btnwidth :Integer;
   btnLeft:Integer;
  Procedure CalcGap;
  begin
    if st.Count=1 then begin
      btnwidth := 100;
      igap :=trunc((Self.Width -btnwidth)/2);
    end else begin
      btnwidth := system.Trunc(self.width / st.count);
      igap :=system.Trunc(btnwidth / 4);
      btnwidth := system.Trunc((self.width-(igap* (st.count+1)))/ st.count);
    end;
  end;
begin
  st:=  tStringList.Create;
  try
    st.commatext := Value;
    if st.Count = 0 then exit;
    CalcGap;
    btnLeft := igap;
    if st.count =0 then
      pnlfooter.visible := False
    else
    for ctr := 0 to st.count-1 do begin
      Button := TDNMSpeedButton.Create(Self);
      with Button do begin
        Left := btnLeft;
        Top := 15;
        Width := btnwidth;
        Caption := st.Strings[ctr];
        Parent := pnlFooter;
        Alignment := taCenter;
        Color := clWhite;
        HotTrackColor := clBtnShadow;
        SlowDecease := True;
        Style := bsModern;
        OnClick := MsgButtonclick;
        inc(ButtonCtr);
        name := 'mainbutton'+inttostr(ButtonCtr);
        tag := btnTag;
        inc(btnTag);
        btnLeft := btnLeft + btnWidth+ igap;
        if ctr=0 then default := True;
        if ctr = st.Count-1 then cancel := True;

        Font.Style := Font.Style +[fsBold];
        if Largefont then begin
          Height := 100;
          Font.size := 28;
        end else begin
          Height := 27;
          Font.size := 9;
        end;
      end;
    end;
  finally
      FreeandNil(ST);
  end;
end;

procedure TfmMessageBase.MsgButtonclick(Sender: TObject);
begin
  fiMsgResult := TDNMSpeedButton(SendeR).Tag;
  if fsModal in FormState then
    modalresult:= mrok
  else
    Self.Close;
end;

class function TfmMessageBase.MsgDlg: Integer;
begin
   Result:= 0;
end;

procedure TfmMessageBase.setMsg1(const Value: String);
begin
  lbltop.caption := Value;
end;

procedure TfmMessageBase.setMsg2(const Value: String);
begin
  lblBottom.caption := Value;
  if lblBottom.Visible <> (Value <> '') then lblBottom.Visible:= Value <> '';
  //if pnlbottom.visible <> (Value <> '') then pnlbottom.visible :=Value <> '';
end;

procedure TfmMessageBase.setcolor(const Value: Tcolor);
begin
  fcolor := Value;
  Self.Color := value;
end;

procedure TfmMessageBase.FormShow(Sender: TObject);
begin
  inherited;
  //if pnlbottom.Visible      then Self.Height := self.Height + pnlbottom.Height;
  if Self.Height < fiHeight then Self.Height := fiHeight;
end;


function TfmMessageBase.getCheckboxcaption: String;begin result:= chk.Caption;end;
function TfmMessageBase.getChecked: Boolean;begin result := chk.Checked;end;
function TfmMessageBase.getLargefont: Boolean;begin result := fbLargefont;end;
procedure TfmMessageBase.InitMsgDlg;
var
  comp:TComponent;
begin
     Largefont := PopupMsgParams.Largefont;
     MsgCaption := PopupMsgParams.Msgcaption;
     Msg1 := PopupMsgParams.Msg1;
     Msg2 := PopupMsgParams.Msg2;
     MsgLeft := PopupMsgParams.MsgLeft;
     Msgtop  := PopupMsgParams.MsgTop;
     MsgHeight := PopupMsgParams.MsgHeight;
     MsgWidth := PopupMsgParams.MsgWidth;
     custombuttons:= PopupMsgParams.CustomButtons;
     Msgcolor  := PopupMsgParams.Msgcolor;
     if PopupMsgParams.Defaultbutton >0 then begin
      Comp:=Findcomponent('mainbutton'+inttostr(PopupMsgParams.Defaultbutton));
      if (comp<> nil) and (comp is TDNMSpeedButton) then begin
        Setcontrolfocus(TDNMSpeedButton(Comp));
        fDefaultButton:=TDNMSpeedButton(Comp);
      end;
     end;
      if PopupMsgParams.msgTop  <> 0 then Top := PopupMsgParams.Msgtop;
      if PopupMsgParams.MsgLeft <> 0 then Left := PopupMsgParams.MsgLeft;
      if (PopupMsgParams.msgTop=0) and (PopupMsgParams.MsgLeft=0) then position := poScreenCenter;
     checkboxcaption := PopupMsgParams.ChkCaption;
     if Largefont then begin
      pnlFooter.Height := 130;
      lbltop.Font.size := 28;
      lbltop.Font.Style := lbltop.Font.Style +[fsBold];
      lbltop.height :=80;
    end;

end;

procedure TfmMessageBase.setChecked(const Value: Boolean);begin chk.Checked:= Value;end;
procedure TfmMessageBase.setLargefont(const Value: Boolean);
begin
  fbLargefont:= Value;
  if Value then begin
    Width  := 800;
    height := 450;
    Font.Size := 28;
    Font.Style := Font.Style +[fsBold];
  end;
end;
procedure TfmMessageBase.setCheckboxcaption(const Value: String);
begin
  if not(Sametext(chk.Caption,Value)) then begin
    chk.Caption := Value;
    chk.visible := trim(Value)<> '';
    if MsgHeight =0 then MsgHeight := Self.Height;
    if chk.visible then MsgHeight := MsgHeight + chk.Height
    (*else MsgHeight := MsgHeight - chk.Height*);
  end;
end;

function MsgLine(double:Boolean =False):String;
begin
  if double then result := '===================================================='
  else           result := '----------------------------------------------------'
end;
Procedure InitMsgParams;
begin
      PopupMsgParams.Msgcaption         := '';
      PopupMsgParams.MsgText            := '';
      PopupMsgParams.MsgFunc            := nil;
      PopupMsgParams.Custombuttons      := '';
      PopupMsgParams.Msg1               := '';
      PopupMsgParams.Msg2               := '';
      PopupMsgParams.MsgLeft            := 0;
      PopupMsgParams.MsgTop             := 0;
      PopupMsgParams.Defaultbutton      := 0;
      PopupMsgParams.MsgHeight          := 0;
      PopupMsgParams.MsgWidth           := 525;
      PopupMsgParams.MsgColor           := $00FFFFD7;
      PopupMsgParams.ChkCaption         := '';
      PopupMsgParams.checked            := False;
      PopupMsgParams.MsgTExtForGrid     := '';
      PopupMsgParams.MsgTExtForGridDelim:= ',';
      PopupMsgParams.MsgDs              := nil;
      PopupMsgParams.fieldnames         := '';
      PopupMsgParams.displayLabels      := '';
      PopupMsgParams.panel              := nil;
      PopupMsgParams.Chkclick           := nil;
      PopupMsgParams.HideinGridwhen0    := False;
      PopupMsgParams.Largefont          := False;
      PopupMsgParams.Multiselect        := False;
      PopupMsgParams.IdFieldname        :='';
  end;
initialization
  initMsgParams;
  RegisterClassOnce(TfmMessageBase);

end.
