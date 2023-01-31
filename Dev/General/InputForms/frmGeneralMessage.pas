{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 21/01/06 1.00.00  BJ  Initial Version
                       The form is designed to have a maximum of 5 lines and 5 buttons
                       Form has full access always for all users}

 unit frmGeneralMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseFormForm, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  wwcheckbox, DNMPanel, AdvPanel, SelectionDialog, Menus;

type
  TfrmGeneralMessage = class(TBaseForm)
    pnlLabel: TAdvPanel;
    lblMessage: TLabel;
    btnPanel: TAdvPanel;
    btnSample: TDNMSpeedButton;
    AdvPanelStyler1: TAdvPanelStyler;
  private
    fiNoOfBtns :Integer;
    fbbuttons :Array of TDNMSpeedButton;
    fiREsultId : Integer;
    Procedure ButtonProperties(Const Sender :TDNMSpeedButton; Const ButtonCaption :STring);
    Procedure BtnClick(Sender :TObject);
    Procedure SetButtons(Const Captions :Array of String);
  Public
    Property ResultId :Integer read fiResultId;
  end;

var
  fmGeneralMessage: TfrmGeneralMessage;

Function MessageForm(Const fsMessage :WideString;  Const buttons :Array of String; Const FormCaption :String = 'Confirm') :Integer;

implementation

uses FastFuncs,CommonLib, Forms, ColourLib;

{$R *.dfm}
Function MessageForm(Const fsMessage :WideString;  Const buttons :Array of String; Const FormCaption :String = 'Confirm') :Integer;
var
    Form :  TfrmGeneralMessage;
begin
    Result := 0;
    if fsMessage = '' then Exit;
    form := TfrmGeneralMessage(GetComponentByClassName('TfrmGeneralMessage', False));
    try
        form.SetButtons(buttons);
        Form.Caption := FormCaption;
        Form.lblMessage.Caption := fsMessage;

        {Re-position and resize the label to the centre of the form.       }
        Form.lblMessage.Autosize := False;
        Form.lblMessage.Width := Form.pnlLabel.width-10;
        Form.lblMessage.Autosize := true;
        if Form.lblMessage.Height > 75 then Form.Height := Form.height + Form.lblMessage.Height-75;
        Form.lblMessage.Top := System.round((Form.pnlLabel.Height - Form.lblMessage.height)/2);
        Form.ShowModal;
        REsult := Form.ResultID;
    finally
        FreeandNil(form);
    end;
end;

Procedure TfrmGeneralMessage.ButtonProperties(Const Sender :TDNMSpeedButton; Const ButtonCaption :STring);
begin
    Sender.Caption              := ButtonCaption;
    Sender.Visible              := True;
    Sender.Parent               := btnPanel;
    {copy the btnproperties from the sample button}
    Sender.Top                  := btnSample.Top;
    Sender.Width                := btnSample.Width;
    Sender.Height               := btnSample.Height;
    Sender.Anchors              := btnSample.Anchors;
    Sender.Font.Charset         := btnSample.font.CharSet;
    Sender.Font.Color           := btnSample.font.color;
    Sender.Font.Height          := btnSample.font.Height;
    Sender.Font.Name            := btnSample.font.Name;
    Sender.Font.Style           := btnSample.Font.Style;
    Sender.HotTrackFont.Charset := btnSample.HotTrackFont.Charset ;
    Sender.HotTrackFont.Color   := btnSample.HotTrackFont.Color;
    Sender.HotTrackFont.Height  := btnSample.HotTrackFont.Height;
    Sender.HotTrackFont.Name    := btnSample.HotTrackFont.Name;
    Sender.HotTrackFont.Style   := btnSample.HotTrackFont.Style ;
    Sender.ParentFont           := btnSample.Parentfont;

    Sender.Default := ReplaceStr(uppercase(Sender.Caption), '&' , '')  = 'OK';
    Sender.Cancel  := ReplaceStr(uppercase(Sender.Caption), '&' , '')  = 'CANCEL';
    if ReplaceStr(uppercase(Sender.Caption), '&' , '') = 'OK'     then Sender.ModalResult := mrOk;
    if ReplaceStr(uppercase(Sender.Caption), '&' , '') = 'CANCEL' then Sender.ModalResult := mrCancel;
end;

Procedure TfrmGeneralMessage.SetButtons(Const Captions :Array of String);
var
    ctr : integer;
    btnWidth:Integer;
    fiWidth : Integer;
    DefaultCaptions :Array Of String;
begin
    if high(Captions) < 0 then fiNoOfBtns :=2 else fiNoOfBtns :=high(Captions)+1;
    btnWidth := 87;
    {resize the form if the number of buttons are more than 4, the default size is to accomodate 4 buttons}
    if fiNoOfBtns > 4 then Self.Width := btnWidth*fiNoOfBtns + 25* fiNoOfBtns;
    fiwidth := Self.Width;

    fiWidth:= System.round((fiWidth - (fiNoOfBtns*btnWidth))/(fiNoOfBtns+1));
    Setlength(fbbuttons ,fiNoOfBtns);
    Setlength(DefaultCaptions,2);
    DefaultCaptions [0] := '&Ok';
    DefaultCaptions [1] := '&Cancel';
    for ctr := 0 to high(Captions) do begin
         fbbuttons[ctr] := TDNMSpeedButton.Create(btnPanel);
         fbbuttons[ctr].OnClick := BtnClick;
         ButtonProperties(fbbuttons[ctr],Captions[ctr]);
         fbbuttons[ctr].Left := fiwidth+ ctr*(fiwidth+btnWidth);
    end;
    if high(Captions) < 0 then begin
        for ctr := 0 to high(DefaultCaptions) do begin
            fbbuttons[ctr] := TDNMSpeedButton.Create(btnPanel);
            fbbuttons[ctr].OnClick := BtnClick;
            ButtonProperties(fbbuttons[ctr],DefaultCaptions[ctr]);
            fbbuttons[ctr].Left := fiwidth+ ctr*(fiwidth+btnWidth);
        end;
    end;
  SetButtonProperties(btnPanel, '');
end;

Procedure TfrmGeneralMessage.BtnClick(Sender :TObject);
var
    ctr :Integer;
begin
    fiResultId := 0;
    for ctr := 0 to high(fbButtons) do
        if sender = fbbuttons[ctr] then fiREsultId := ctr+1;
    Self.Close;
end;
initialization
  RegisterClassOnce(TfrmGeneralMessage);

end.
