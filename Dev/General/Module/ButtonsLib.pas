unit ButtonsLib;

interface

uses DNMSpeedButton, classes,DNMPAnel , Graphics;

procedure AddButtons( AOwner          :Tcomponent;
                      ParentPanel     :TDNMPAnel;
                      ButtonCaptions  :Array of String;
                      Buttonvisiblity :Array of Boolean;
                      Buttonhint      :Array of String;
                      btnclickHandler :TNotifyEvent;
                      var buttons:Array of TDNMSpeedButton ;
                      ButtonLeft      :Integer =7;
                      ButtonWidth     :Integer =148;
                      ButtonHeight    :Integer =28;
                      ButtonGap       :Integer =5;
                      NamePrefix      :String ='Button');
function btnGap(const buttons:Integer;btnWidth:Integer; ParentPanel:TDnmPanel; leftmargin :Integer =0; rightMargin :Integer =0):Integer;
function btnLeft(const buttons:Integer;btnWidth:Integer;btnPos:Integer; ParentPanel:TDnmPanel; leftmargin :Integer =0; rightMargin :Integer =0):Integer;
Procedure FormatBtnHelp(var btn : TDNMSpeedButton;aWidth :Integer = 24;aHeight:Integer  = 27;aHint :String ='';aColor :Tcolor = clMaroon);

implementation

uses sysutils,controls;

Procedure FormatBtnHelp(var btn : TDNMSpeedButton;aWidth :Integer = 24;aHeight:Integer  = 27;aHint :String ='';aColor :Tcolor = clMaroon);
begin
    with btn do begin
      Width         := aWidth;
      Height        := aHeight;
      if trim(aHint)<> '' then Hint := aHint;
      Font.Color    := aColor;
      Font.Height   := -19;
      Font.Name     := 'Arial';
      Font.Style    := Font.Style +[fsBold];
      ParentFont    := False;
      ParentShowHint:= false;
      ShowHint      := (Trim(hint)<> '');
    end;
end;
procedure AddButtons( AOwner          :Tcomponent;
                      ParentPanel     :TDNMPAnel;
                      ButtonCaptions  :Array of String;
                      Buttonvisiblity :Array of Boolean;
                      Buttonhint :Array of String;
                      btnclickHandler :TNotifyEvent;
                      var buttons:Array of TDNMSpeedButton ;
                      ButtonLeft      :Integer =7;
                      ButtonWidth     :Integer =148;
                      ButtonHeight    :Integer =28;
                      ButtonGap       :Integer =5;
                      NamePrefix      :String ='Button');
var
  ButtonTop: Integer;
  Button: TDNMSpeedButton;
  ButtonIndex , ButtonCtr: Integer;
begin
  ButtonTop := 5;
  ButtonCtr:=0;

  for ButtonIndex := low(ButtonCaptions) to high(ButtonCaptions) do begin
    if Buttonvisiblity[ButtonIndex] then begin
      Button := TDNMSpeedButton.Create(AOwner);
      with Button do begin
        Anchors := [akLeft, akTop];
        Left := ButtonLeft;
        Top := ButtonTop;
        Width := ButtonWidth;
        Height := ButtonHeight;
        Caption := ButtonCaptions[ButtonIndex];
        hint := Buttonhint[ButtonIndex];
        Showhint := hint <> '';
        ParentShowhint := False;
        Parent := ParentPanel;
        Alignment := taCenter;
        Color := clWhite;
        HotTrackColor := clBtnShadow;
        SlowDecease := True;
        Style := bsModern;
        inc(ButtonCtr);
        name := NamePrefix+inttostr(ButtonCtr);
        OnClick := btnclickHandler;
      end;
      ButtonTop := ButtonTop + ButtonHeight + ButtonGap;
      buttons[ButtonIndex] := Button;
    end;
  end;
  If ButtonTop > ParentPanel.Height then
     ParentPanel.Height := ButtonTop;
end;

function btnGap(const buttons:Integer;btnWidth:Integer; ParentPanel:TDnmPanel; leftmargin :Integer =0; rightMargin :Integer =0):Integer;
begin
  REsult := trunc((ParentPanel.width - leftmargin - rightmargin - (buttons*btnWidth))/(buttons+1));
end;
function btnLeft(const buttons:Integer;btnWidth:Integer;btnPos:Integer; ParentPanel:TDnmPanel; leftmargin :Integer =0; rightMargin :Integer =0):Integer;
var
  i:Integer;
begin
  i:= btnGap(buttons, btnWidth , parentPanel, leftmargin, rightmargin);
  result := leftmargin + (i*btnPos +(btnPos-1)*btnWidth);
end;
end.

