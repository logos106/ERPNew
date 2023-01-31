unit frmAdvDateInputBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDateInputBox, DNMSpeedButton, ExtCtrls, DNMPanel, StdCtrls,
  ComCtrls;

type

  TfmAdvDateInputBox = class(TfmDateInputBox)
    chkOption: TCheckBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fDtValidation: TGeneralDateFunction;
    procedure setChkhint(const Value: String);
    procedure setchkCaption(const Value: String);
  public
    Property Chkhint :String write setChkhint;
    Property chkCaption :String write setchkCaption;
    Property DtValidation :TGeneralDateFunction read fDtValidation  write fDtValidation ;
    Function InputDate(const ACaption, APrompt , achkCaption: string; var Value: TDateTime; var checkOption:Boolean; backcolour :TColor = 0 ; achkHint :String ='';aDtValidation: TGeneralDateFunction =nil; HighlightCheckbox:Boolean=False): Boolean;
    Class Function InputValue(const ACaption, APrompt , chkCaption: string; var Value: TDateTime; var checkOption:Boolean; backcolour :TColor = 0 ; chkHint :String ='';aDtValidation: TGeneralDateFunction =nil;   HighlightCheckbox:Boolean=False): Boolean;
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TfmAdvDateInputBox.btnCancelClick(Sender: TObject);
begin
  inherited;
    ModalREsult := mrCancel;

end;

procedure TfmAdvDateInputBox.btnOkClick(Sender: TObject);
var
  dt:TDateTime;
  Msg:String;
begin
  inherited;
  if Assigned(fDtValidation) then begin
    dt:= edtDate.datetime;
    Msg:= '';
    if not (fDtValidation(dt, msg)) then begin
      edtDate.datetime := dt;
      if Msg <> '' then MessageDlgXP_Vista(Msg, mtWarning, [mbOK], 0);
      Exit;
    end;
  end;
  ModalResult := mrOk;
end;

procedure TfmAdvDateInputBox.FormCreate(Sender: TObject);
begin
  inherited;
  fDtValidation := nil;
end;
procedure TfmAdvDateInputBox.setchkCaption(const Value: String);
begin
  chkOption.caption := Value;
  chkOption.visible := Value <> '';
  if not chkOption.visible then
      height := Height - (chkOption.Height + chkOption.Margins.top + chkOption.Margins.Bottom);
end;

procedure TfmAdvDateInputBox.setChkhint(const Value: String);begin  ShowControlhint(chkOption , value);end;

function TfmAdvDateInputBox.InputDate(const ACaption, APrompt , achkCaption: string; var Value: TDateTime; var checkOption:Boolean; backcolour :TColor = 0 ; achkHint :String ='';aDtValidation: TGeneralDateFunction =nil; HighlightCheckbox:Boolean=False): Boolean;
begin
    chkCaption := achkCaption;
    chkhint := achkHint;
    DtValidation := aDtValidation;
    if HighlightCheckbox then Highlightcontrol(chkOption);
    result := inherited InputDate(ACaption, APrompt , Value,  backcolour);
    if result then
      checkOption :=chkOption.checked;
end;

Class Function TfmAdvDateInputBox.InputValue(const ACaption, APrompt , chkCaption: string; var Value: TDateTime; var checkOption:Boolean; backcolour :TColor = 0 ; chkHint :String ='';aDtValidation: TGeneralDateFunction =nil; HighlightCheckbox:Boolean=False): Boolean;
var
  form: TfmAdvDateInputBox;
begin
  form := TfmAdvDateInputBox.Create(nil);
  try
    REsult := Form.InputDate(ACaption, APrompt , chkCaption,Value,checkOption,backcolour ,chkHint ,aDtValidation , HighlightCheckbox);
  finally
    form.Free;
  end;

end;

end.
