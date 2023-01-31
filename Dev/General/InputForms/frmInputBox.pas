unit frmInputBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, DNMSpeedButton, StdCtrls, ExtCtrls, DNMPanel;

type
  TInputType = (tInputBox, tChoice, tConfirmation);
  TInputDatatype = (tGeneralData, tfloatData, tDateData, tIntegerData);

  TfmInputBox = class(TBaseForm)
    pnlUserInput: TDNMPanel;
    DNMPanel1: TDNMPanel;
    lblPrompt: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    edtInput: TEdit;
    lblWarning: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
  private
    ffInputDatatype: TInputDatatype;
    fiIsBlankAllowed: Boolean;
    fInputcaption: String;
    procedure SetDefaultValue(const Value: String);
    procedure SetInputcaption(const Value: String);
    procedure SetInputPrompt(const Value: String);
    procedure setBasecolor(const Value: Tcolor);
    procedure SetInputType(const Value: TInputType);
    Procedure Warning(Const Value:String='');
    { Private declarations }
  public
    Property Inputcaption   :String         read fInputcaption write SetInputcaption;
    Property DefaultValue   :String         Write SetDefaultValue;
    Property InputPrompt    :String         Write SetInputPrompt;
    Property InputDatatype  :TInputDatatype read ffInputDatatype Write ffInputDatatype;
    Property IsBlankAllowed :Boolean        read fiIsBlankAllowed Write fiIsBlankAllowed;
    Property Basecolor      :Tcolor         Write setBasecolor;
    Property InputType      :TInputType     Write SetInputType;

  end;
function UserInput(const UserInputcaption:String='';
                    const UserInputPrompt :String ='';
                    const UserInputDefaultValue:String='';
                    const fInputDatatype:TInputDatatype=tGeneralData;
                    const fIsBlankAllowed:boolean =  True;
                    const FormColor:TColor = clNone;
                    const fInputType :TInputType= tInputBox):String;

implementation

uses CommonLib, FastFuncs;

{$R *.dfm}
function (*UserInput(const UserInputcaption:String=''; const UserInputPrompt :String =''; const UserInputDefaultValue:String=''; const FormColor:TColor = clNone; const fInputType :TInputType= tInputBox; fInputDatatype:TInputDatatype=tGeneralData; fIsBlankAllowed:boolean =  True):String;*)
          UserInput(const UserInputcaption:String='';
                    const UserInputPrompt :String ='';
                    const UserInputDefaultValue:String='';
                    const fInputDatatype:TInputDatatype=tGeneralData;
                    const fIsBlankAllowed:boolean =  True;
                    const FormColor:TColor = clNone;
                    const fInputType :TInputType= tInputBox):String;
 var
  Form :TfmInputBox;
begin
  result :=UserInputDefaultValue;
  Form :=TfmInputBox.create(nil);
  try
    if UserInputcaption       <> ''     then Form.InputCaption  := UserInputcaption;
    if UserInputDefaultValue  <> ''     then Form.DefaultValue  := UserInputDefaultValue;
    if UserInputPrompt        <> ''     then Form.InputPrompt   := UserInputPrompt;
    if FormColor              <> clNone then Form.Basecolor     := formcolor;
    Form.InputType            := fInputType;
    form.InputDatatype := fInputDatatype;
    Form.IsBlankAllowed := fIsBlankAllowed;
    Form.ShowModal;
    if Form.ModalREsult = mrOk then Result := Form.edtInput.text;
  finally
    Form.Free;
  end;  
end;
{ TfmInputBox }
procedure TfmInputBox.setBasecolor    (const Value: Tcolor);begin  Self.Color       := Value;end;
procedure TfmInputBox.SetDefaultValue (const Value: String);begin  edtInput.text    := Value;end;
procedure TfmInputBox.SetInputcaption (const Value: String);begin  fInputcaption := Value; Self.Caption     := Value;end;
procedure TfmInputBox.SetInputPrompt  (const Value: String);begin  lblPrompt.caption:= Value;end;

procedure TfmInputBox.FormCreate(Sender: TObject);
begin
  fbignoreaccesslevels:= True;
  inherited;
  UseDefaultColor := False;
end;

procedure TfmInputBox.SetInputType(const Value: TInputType);
begin
  if Value = tInputBox then begin
      pnlUserInput.visible := true;
  end;
  {need to implement the rest}
end;


procedure TfmInputBox.btnCompletedClick(Sender: TObject);
var
   Value:String;
   dt:TDatetime;
begin
  inherited;
  Value := FastFuncs.trim(edtInput.text);
  if not(IsBlankAllowed)  then
    if value = '' then begin
      Warning('Please Enter a Value For ' +Inputcaption+'.');
      Exit;
    end;


  if (InputDatatype = tfloatData) and (not(IsNumeric(Value))) then Warning('Please Enter a Number For ' +Inputcaption+'.')
  else if (InputDatatype = tDateData) and (not(IsDate(Value, dt))) then Warning('Please Enter a Date For ' +Inputcaption+'.')
  else if (InputDatatype = tIntegerData) and (not(ISInteger(Value))) then Warning('Please Enter an Integer For ' +Inputcaption+'.')
  else modalresult := mrok;
end;

procedure TfmInputBox.Warning(const Value: String='');
begin
  if Value = '' then begin
    lblWarning.Visible := False
  end else begin
    lblWarning.Caption := Value;
    lblWarning.Visible := true;
  end;
end;
end.
