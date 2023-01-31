unit frmCalculator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, StdCtrls, ExtCtrls, Menus, DNMPanel, DNMSpeedButton;

type
  TfmCalculator = class(TfrmBaseGUI)
    Panel1: TDnMPanel;
    NumberEdit: TEdit;
    Equals: TLabel;
    DNMPanel1: TDNMPanel;
    Addition: TDnmSpeedbutton;
    Subtraction: TDnmSpeedbutton;
    Multiplication: TDnmSpeedbutton;
    Division: TDnmSpeedbutton;
    One: TDnmSpeedbutton;
    Two: TDnmSpeedbutton;
    three: TDnmSpeedbutton;
    Four: TDnmSpeedbutton;
    five: TDnmSpeedbutton;
    Six: TDnmSpeedbutton;
    Seven: TDnmSpeedbutton;
    Eight: TDnmSpeedbutton;
    nine: TDnmSpeedbutton;
    Zero: TDnmSpeedbutton;
    Decimal: TDnmSpeedbutton;
    Enter: TDnmSpeedbutton;
    ClearValue: TDnmSpeedbutton;
    Negative: TDnmSpeedbutton;
    Reset: TDnmSpeedbutton;
    btnBack: TDnmSpeedbutton;
    DNMPanel2: TDNMPanel;
    btnCancel: TDNMSpeedButton;
    btnOk: TDNMSpeedButton;
    lblResult: TLabel;
    lblhistory: TLabel;
    openbracket: TDNMSpeedButton;
    closedBracket: TDNMSpeedButton;
    lblMsg: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure AdditionClick(Sender: TObject);
    procedure ClearValueClick(Sender: TObject);
    procedure DivisionClick(Sender: TObject);
    procedure EnterClick(Sender: TObject);
    procedure MultiplicationClick(Sender: TObject);
    procedure NegativeClick(Sender: TObject);
    procedure NumberButtonClick(Sender: TObject);
    procedure ResetClick(Sender: TObject);
    procedure SubtractionClick(Sender: TObject);
    procedure nineClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DecimalClick(Sender: TObject);
    procedure closedBracketClick(Sender: TObject);
    procedure openbracketClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
   fdCalcValue: Double;
   Math : string;
   function getValue: Double;
   Procedure  SetCalcValue(const Value:double);
    procedure setExpression(const Value: String);
    function getExpression: String;
   //SNumber : real;
  public
    Property CalcValue :Double read getValue Write SetCalcValue;
    Property Expression : String read getExpression Write setExpression ;


  end;

Procedure DoCalc(Var fdValue: double; var fsDesc:String);
function Calculate(Var fdValue: double; var fsDesc:String) : boolean;


implementation

uses CommonLib, sndkey32, ParserLib, tcConst;


{$R *.dfm}



//The following procedure gives the number buttons their ability to add a
//numerical value to the first number's text box.

procedure TfmCalculator.NumberButtonClick (Sender: TObject);
begin
  if NumberEdit.SelText <> '' then begin
    NumberEdit.SelText  :=(Sender as TDnmSpeedbutton).Caption;
  end else begin
    NumberEdit.Text := NumberEdit.Text + (Sender as TDnmSpeedbutton).Caption;
  end;
  if NumberEdit.SelStart <=0 then NumberEdit.SelStart := length(NumberEdit.text)
  else NumberEdit.SelStart := NumberEdit.SelStart+1;
end;

procedure TfmCalculator.openbracketClick(Sender: TObject);
begin
  inherited;
         if Math = 'Add'      then lblhistory.caption := lblhistory.caption + ' + '
    else if Math = 'Subtract' then lblhistory.caption := lblhistory.caption + ' - '
    else if Math = 'Multiply' then lblhistory.caption := lblhistory.caption + ' * '
    else if Math = 'Divide'   then lblhistory.caption := lblhistory.caption+ ' / ';
  lblhistory.Caption := lblhistory.Caption +'(';
  ClearValue.Click;
  Math := 'Default';
end;

//The following procedure controls the negative/positive button.  The string in
//the edit box is converted into a real number, multiplied by -1, and then
//converted back into a string to be placed back into the edit box.

procedure TfmCalculator.NegativeClick(Sender: TObject);
begin
  CalcValue := 0-CalcValue;
(*var
     OriginalNumber: double;
     TextNumber: string;
begin
     OriginalNumber := -(StrToFloat(NumberEdit.Text));
     TextNumber := FormatFloat('0.##########', OriginalNumber);
     NumberEdit.Text := TextNumber*)
end;

procedure TfmCalculator.nineClick(Sender: TObject);
begin
  inherited;

end;

//The following procedures give the mathematical function buttons their ability
//to instigate a specific math function.  When a function button is pressed,
//the string variable "Math" is assigned a specific term.  The procedures also
//turn the first string found in the edit box into a floating variable and
//clears the edit box so another value can be entered.

procedure TfmCalculator.AdditionClick       (Sender: TObject);begin    EnterClick(Sender);    Math := 'Add'     ;end;
procedure TfmCalculator.SubtractionClick    (Sender: TObject);begin    EnterClick(Sender);    Math := 'Subtract';end;
procedure TfmCalculator.MultiplicationClick (Sender: TObject);begin    EnterClick(Sender);    Math := 'Multiply';end;
procedure TfmCalculator.DivisionClick       (Sender: TObject);begin    EnterClick(Sender);    Math := 'Divide'  ;end;

procedure TfmCalculator.DecimalClick(Sender: TObject);
begin
  inherited;
  if pos('.' , NumberEdit.Text) <> 0 then exit;
  NumberButtonClick(Sender);
end;
//The following procedure gives the enter button its ability to interpret all
//previous procedures and calculate the correct answer.  The overall procedure
//turns the second number (formatted as a string) entered into the edit box into
//a floating variable.  The procedure then breaks into if statements.
//These if statements corespond with the string value the variable "Math" was
//given in above procedures.  The if statements contain code to give the real
//variable "Answer" which is formatted to be placed in the label designated for
//answers.

procedure TfmCalculator.EnterClick(Sender: TObject);
var
    SNumber: Double;
    fd:Double;
    s:String;
begin
  fd:= calcValue;  s:= lblhistory.Caption;
  try
    SNumber:=0;
    try
      if trim(NumberEdit.Text) = '' then exit;
      try
        SNumber := StrToFloat(NumberEdit.Text);
      Except
      end;
      if SNumber=0 then exit;
      if Math = 'Add' then begin
          lblhistory.caption := lblhistory.caption + ' + '+FloattoStr(SNumber);
          //SNumber := CalcValue + SNumber;
      end else if Math = 'Subtract' then begin
          lblhistory.caption := lblhistory.caption + ' - '+FloattoStr(SNumber)(*+ ' - '*);
          //SNumber := CalcValue  - SNumber;
      end else if Math = 'Multiply' then begin
          lblhistory.caption := lblhistory.caption + ' * '+FloattoStr(SNumber)(*+ ' * '*);
          //SNumber := CalcValue  * SNumber;
      end else if Math = 'Divide' then begin
          lblhistory.caption := lblhistory.caption+ ' / '+FloattoStr(SNumber) (*+ ' / '*);
          //SNumber := CalcValue  / SNumber;
      end else if Math = 'Default' then begin
        lblhistory.caption := lblhistory.caption+FloattoStr(SNumber);
      end else begin
        Exit;
      end;
    finally
      Expression := lblhistory.caption;
      //CalcValue:= SNumber;
    end;
  finally
    //if Screen.ActiveControl = Enter then
        if (fd = calcValue) and (s= lblhistory.Caption) then
          btnOk.Click;
  end;
end;

procedure TfmCalculator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if fsModal in FormState then
  else
    action := caFree;
end;

procedure TfmCalculator.FormCreate(Sender: TObject);
begin
  inherited;
  CalcValue :=0;
  Math := 'Default';
  lblMsg.Caption := 'Hit ENTER Key to do the Calculation' + NL +'ENTER again to close the calculator and return value';
end;

procedure TfmCalculator.FormKeyPress(Sender: TObject; var Key: Char);
var
  ctr:Integer;
begin
  inherited;
  try
    for ctr := 0 to componentcount-1 do begin
      if components[ctr] is TDnmSpeedbutton then
        if sametext(TDnmSpeedbutton(components[ctr]).Caption , Key) then begin
          TDnmSpeedbutton(components[ctr]).click;
          Key := chr(0);
          Exit;
        end;
    end;
    if Key = chr(VK_BACK) then begin
      btnBack.Click;
      Key := chr(0);
    end else   if Key = chr(VK_RETURN) then begin
      SetControlfocus(Enter);
      Enter.Click;
      Key := chr(0);
    end else   if Key = '*' then begin
      Multiplication.Click;
      Key := chr(0);
    end else   if Key = chr(VK_DELETE) then begin
      SetControlFocus(NumberEdit);
      SendKeys('{DELETE}',true);
      Key := chr(0);
    end;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TfmCalculator.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_f8 then
    btnOk.Click;
end;

Procedure  TfmCalculator.SetCalcValue(const Value:double);
begin
  fdCalcValue := Value;
  Equals.Caption := SysUtils.FloatToStrF(Value, ffGeneral, 15,2);
  NumberEdit.Clear;
  lblResult.caption := 'Result = ' + Trim(Equals.Caption);
end;

procedure TfmCalculator.setExpression(const Value: String);
var
  fd1, fd2:Double;
  s:String;

begin
  fd2 :=  CalcValue;
  fd1:= ParserValue(Self , nil ,Value, s);
  if s = '' then CalcValue := fd1
  else begin
    //if devmode then MessageDlgXP_vista(s, mtWarning, [mbOK], 0);
    CalcValue :=  fd2;
  end;
end;

function TfmCalculator.getExpression: String;
begin
  REsult := lblhistory.caption;
end;

function TfmCalculator.getValue: Double;
begin
    REsult := fdCalcValue;
end;

//This is the procedure for the clear value button.  This button will only clear
//a value entered onto the edit box; it will not clear selected functions.

procedure TfmCalculator.btnBackClick(Sender: TObject);
begin
  inherited;
  SetControlFocus(NumberEdit);
  try
    SendKeys('{BS}',true);
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_vista(e.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmCalculator.btnOkClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
    ModalResult := mrOk
  else
    Self.Close;

end;

procedure TfmCalculator.ClearValueClick(Sender: TObject);
  begin
    NumberEdit.Clear;
  end;

procedure TfmCalculator.closedBracketClick(Sender: TObject);
begin
  inherited;
(*
         if Math = 'Add'      then lblhistory.caption := lblhistory.caption + ' + '
    else if Math = 'Subtract' then lblhistory.caption := lblhistory.caption + ' - '
    else if Math = 'Multiply' then lblhistory.caption := lblhistory.caption + ' * '
    else if Math = 'Divide'   then lblhistory.caption := lblhistory.caption+ ' / ';*)
  Enter.Click;
  lblhistory.Caption := lblhistory.Caption +')';
  Expression := lblhistory.caption;
  ClearValue.Click;
  Math := 'Default';
end;

procedure TfmCalculator.btnCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Self.Close;
end;

//This is a procedure to reset the calculator.

procedure TfmCalculator.ResetClick(Sender: TObject);
  begin
    lblhistory.caption := '';
    CalcValue:=0;
    Math := 'Default';
  end;

Procedure DoCalc(Var fdValue: double; var fsDesc:String);
begin
  fdValue := 0;
  fsDesc := '';
  With TfmCalculator(GetComponentByClassName('TfmCalculator' , False )) do try
    ShowModal;
    if modalresult = mrok then begin
      fdValue :=  CalcValue;
      fsDesc := Expression;
    end;
  finally
    Free;
  end;
end;

function Calculate(Var fdValue: double; var fsDesc:String) : boolean;
var
  lForm : TfmCalculator;
begin
//  fdValue := 0;
//  fsDesc := '';
  lForm := TfmCalculator(GetComponentByClassName('TfmCalculator' , False ));
  try
    lForm.CalcValue := fdValue;
    lForm.Expression := fsDesc;
    lForm.ShowModal;
    if lForm.modalresult = mrok then
    begin
      fdValue :=  lForm.CalcValue;
      fsDesc := lForm.Expression;
      Result := true;
    end
    else
      Result := false;
  finally
    lForm.Free;
  end;
end;

initialization
  RegisterClassOnce(TfmCalculator);


end.

