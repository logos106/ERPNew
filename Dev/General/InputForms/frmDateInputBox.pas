unit frmDateInputBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DNMSpeedButton, ExtCtrls, DNMPanel, frmBase;

type
  TGeneralDateFunction    = Function (Var Value:TDateTime; Var Msg:String):Boolean of Object;

  TfmDateInputBox = class(TfrmBaseGUI)
    lblPrompt: TLabel;
    edtDate: TDateTimePicker;
    DNMPanel1: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    //Function InputDate(const ACaption, APrompt , chkCaption: string; var Value: TDateTime; var checkOption:Boolean; backcolour :TColor = 0 ; chkHint :String ='';aDtValidation: TGeneralDateFunction =nil): Boolean;Virtual;
    Function InputDate(const ACaption, APrompt: string; var Value: TDateTime; backcolour :TColor = 0 ): Boolean;
    Class Function InputValue(const ACaption, APrompt: string; var Value: TDateTime; backcolour :TColor = 0 ): Boolean;
  end;

var
  fmDateInputBox: TfmDateInputBox;

implementation

{$R *.dfm}

{ TfmDateInputBox }

procedure TfmDateInputBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;
//Function TfmDateInputBox.InputDate(const ACaption, APrompt , chkCaption: string; var Value: TDateTime; var checkOption:Boolean; backcolour :TColor = 0 ; chkHint :String ='';aDtValidation: TGeneralDateFunction =nil): Boolean;
Function TfmDateInputBox.InputDate(const ACaption, APrompt: string; var Value: TDateTime; backcolour :TColor = 0 ): Boolean;
begin
    Caption := ACaption;
    lblPrompt.Caption := aPrompt;
    edtDate.DateTime := Value;
    if backcolour <> 0 then color := backcolour;
    result := ShowModal = mrOk;
    if result then
      Value := edtDate.DateTime;
end;

class function TfmDateInputBox.InputValue(const ACaption, APrompt: string;var Value: TDateTime; backcolour :TColor = 0): Boolean;
var
  form: TfmDateInputBox;
begin
  form := TfmDateInputBox.Create(nil);
  try
    result := form.InputDate(ACaption, APrompt , Value,  backcolour);
  finally
    form.Free;
  end;
end;

end.
