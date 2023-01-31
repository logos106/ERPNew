unit frmERPMessagePopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, AdvSmoothPopup,
  SelectionDialog;

type
  TfmERPMessagePopup = class(TBaseForm)
    popNew: TAdvSmoothPopup;
    pnlMsg: TPanel;
    tmrDelayMethod: TTimer;
    lblMsg: TLabel;
    lbltime: TLabel;
    lblLink: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tmrDelayMethodTimer(Sender: TObject);
    procedure popNewButtonClick(Sender: TObject; Index: Integer);
    procedure TimMsg1Timer(Sender: TObject);
    procedure lblLinkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Seconds:Integer;
    SecondsForPopup:Integer;
    Procedure Hidepopup;
    procedure ShowPopUp(msg: string; HyperlinkText:String);
    procedure ShowSeconds;
  public
    procedure NextERPpopup(ShowViewed:Boolean);
    procedure ERPpopup(popupID:Integer);
  end;

  procedure ShowERPpopup(ShowViewed:Boolean);
  procedure ShowaERPpopup(popupID:Integer);


implementation

uses
  ShellAPI, ERPMessageTypes, ERPMessageLib, CommonLib, MAIN,  tcConst;

{$R *.dfm}


procedure TfmERPMessagePopup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmERPMessagePopup.FormCreate(Sender: TObject);
begin
  inherited;
  SecondsforPopup := 10;
  Seconds :=  SecondsforPopup;
  popNew.Control := pnlMsg;
  popNew.HeaderCaption := 'TrueERP';
  popNew.FooterCaption := '';
  popNew.FooterHeight := 3;
  lblMsg.Caption:= 'Checking for New Messages from ERP';
  lblMsg.Refresh;
  lblMsg.height := 20;
  popNew.Height := 0;
  popNew.PopupAt(Mainform.width , Mainform.Height);
end;
procedure TfmERPMessagePopup.FormShow(Sender: TObject);
begin
  inherited;
  pnlMsg.Visible := true;
  lblMsg.Visible := true;
  lblLink.Visible := true;
  lbltime.Visible := true;
  lblMsg.caption :=lblMsg.name;
  lblLink.caption :=lblLink.name;
  lbltime.caption :=lbltime.name;
end;

procedure TfmERPMessagePopup.Hidepopup;
begin
  popNew.ClosePopup;
end;

procedure TfmERPMessagePopup.lblLinkClick(Sender: TObject);
begin
  inherited;
  if lblLink.Caption = '' then exit;
  ShellExecute(Handle, 'open', PChar(lblLink.Caption), '', '', SW_SHOW);
end;

procedure TfmERPMessagePopup.ShowPopUp(msg: string; HyperlinkText:String);
var
  x,y:Integer;
begin
  lblMsg.Caption := trim(Msg);
  lblMsg.Refresh;
  lblLink.Caption := trim(HyperlinkText);
  lblLink.refresh;
  popNew.Height := popNew.HeaderHeight +
          popNew.FooterHeight + lblMsg.Height +lbltime.Height + lblLink.height +
          pnlMsg.Padding.Top + pnlMsg.Padding.Bottom + 4;


  x:= Screen.WorkAreaRect.Right - popNew.Width - popNew.ShadowSize;
  y:= Screen.WorkAreaRect.Bottom - popNew.Height - popNew.ArrowSize - popNew.ShadowSize - mainform.StatusBar.Height;
  popNew.PopupAt(x,y);
//  setcontrolfocus(tpopupbutton(popNew.Buttons[0]));

end;
procedure TfmERPMessagePopup.TimMsg1Timer(Sender: TObject);
begin
  inherited;
  if (Seconds > SecondsforPopup ) or (Seconds <0) then exit;
  Seconds := Seconds -1;
  lbltime.Caption := '(' + inttostr(Seconds)+' Second(s))';
  lbltime.visible := TRue;
  lbltime.Refresh;
end;

procedure TfmERPMessagePopup.tmrDelayMethodTimer(Sender: TObject);
begin
  if Seconds >1 then begin
    Seconds := Seconds -1 ;
  end else begin
    Lbltime.Visible := False;
    Seconds :=  SecondsforPopup;
    NextERPpopup(TRue);
  end;
  ShowSeconds;
end;
Procedure TfmERPMessagePopup.ShowSeconds;
var
  s:String;
begin
  s:='( '+inttostr(Seconds)+' Second(s) )';
  if Lbltime.Visible and  sametext(Lbltime.Caption , s) then exit;
  Lbltime.Caption := s;
  Lbltime.Visible := True;
  Lbltime.REfresh;
end;
procedure ShowaERPpopup(popupID:Integer);
var
  form :TfmERPMessagePopup;
begin
  try
    form := TfmERPMessagePopup(getcomponentbyclassname('TfmERPMessagePopup' , true));
    form.ERPpopup(popupID);
  Except
    on E:Exception do begin
        if devmode then MessageDlgXP_Vista('The ERP Uitls Service is not updated.  Please restart the Service.' +E.message, mtWarning, [mbOK], 0);
    end;
  End;
end;

procedure ShowERPpopup(ShowViewed:Boolean);
var
  form :TfmERPMessagePopup;
begin
  try
    form := TfmERPMessagePopup(getcomponentbyclassname('TfmERPMessagePopup' , true));
    form.NextERPpopup(ShowViewed);
  Except
    on E:Exception do begin
        if devmode then MessageDlgXP_Vista('The ERP Uitls Service is not updated.  Please restart the Service.' +E.message, mtWarning, [mbOK], 0);
    end;
  End;

end;
procedure TfmERPMessagePopup.ERPpopup(popupID:Integer);
var
  s:String;
  sh:String;
begin
  inherited;
  try
    Hidepopup;
    s:= NextERPMessage(mtpopup, sh, true, true, popupid , iif(devmode , ERPPopupIntervalDevmode , ERPPopupInterval));
    if s='' then begin
      tmrDelayMethod.Enabled := False;
      exit;
    end;
    ShowPopUp(s, sh);
    if not tmrDelayMethod.Enabled  then tmrDelayMethod.Enabled := true;
  Except
    on E:Exception do begin
        if devmode then MessageDlgXP_Vista('The ERP Uitls Service is not updated.  Please restart the Service.' +E.message, mtWarning, [mbOK], 0);
    end;
  End;
end;

procedure TfmERPMessagePopup.NextERPpopup(ShowViewed:Boolean);
var
  s:String;
  sh:String;
begin
  inherited;
  try
    Hidepopup;
    s:= NextERPMessage(mtpopup, sh, true, ShowViewed , 0, iif(devmode , ERPPopupIntervalDevmode , ERPPopupInterval));
    if s='' then begin
      tmrDelayMethod.Enabled := False;
      exit;
    end;
    ShowPopUp(s, sh);
    if not tmrDelayMethod.Enabled  then tmrDelayMethod.Enabled := true;
  Except
    on E:Exception do begin
        if devmode then MessageDlgXP_Vista('The ERP Uitls Service is not updated.  Please restart the Service.' +E.message, mtWarning, [mbOK], 0);
    end;
  End;
end;

procedure TfmERPMessagePopup.popNewButtonClick(Sender: TObject; Index: Integer);
begin
  inherited;
  if sender = popNew.Buttons[0] then begin
    tmrDelayMethod.Enabled := False;
    Hidepopup;
  end;
end;
initialization
  RegisterClassOnce(TfmERPMessagePopup);

end.
