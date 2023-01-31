unit POSChequeGUI;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, DNMSpeedButton, ExtCtrls, rwButtonArray, DNMPanel, Shader,
  frmBase, Messages, Mask, wwdbedit, Menus;

type
  TPOSChequePopUp = class(TfrmBaseGUI)
    Bevel1: TBevel;
    edtInput1: TwwDBEdit;
    Bevel2: TBevel;
    OKBtn: TDNMSpeedButton;
    CancelBtn: TDNMSpeedButton;
    pnlNumericKeyPad: TDNMPanel;
    btnNum1: TLabel;
    btnNum2: TLabel;
    btnNum3: TLabel;
    btnNum4: TLabel;
    btnNum5: TLabel;
    btnNumDot: TLabel;
    btnNum6: TLabel;
    btnNum7: TLabel;
    btnNum8: TLabel;
    btnNum9: TLabel;
    btnNum0: TLabel;
    btnNumBS: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    procedure FormActivate(Sender: TObject);
    procedure btnNum1click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtInput1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtInput1Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure AddNumPadEntry(const cDigit: char);
  Protected
    edtSelected :TwwDBEdit;
  public
    { Public declarations }
  end;

implementation

uses FastFuncs,Dialogs,CommonDbLib,tcTypes, CommonLib , sndkey32;

{$R *.dfm}

procedure TPOSChequePopUp.FormActivate(Sender: TObject);
begin
  FocusControl(edtInput1);
end;

procedure TPOSChequePopUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TPOSChequePopUp.FormCreate(Sender: TObject);
begin
  inherited;
  edtInput1.Text := '';
  edtSelected:=edtInput1;
end;

procedure TPOSChequePopUp.btnNum1click(Sender: TObject);
var
  btn: TLabel;
begin
  inherited;
  if Sender is TLabel then begin
    btn := TLabel(Sender);
    if btn = btnNumBS then begin
      AddNumPadEntry(char(VK_BACK));
    end else if btn = btnNumDot then begin
      AddNumPadEntry(char('.'));
    end else if btn = btnNum1 then begin
      AddNumPadEntry(char('1'));
    end else if btn = btnNum2 then begin
      AddNumPadEntry(char('2'));
    end else if btn = btnNum3 then begin
      AddNumPadEntry(char('3'));
    end else if btn = btnNum4 then begin
      AddNumPadEntry(char('4'));
    end else if btn = btnNum5 then begin
      AddNumPadEntry(char('5'));
    end else if btn = btnNum6 then begin
      AddNumPadEntry(char('6'));
    end else if btn = btnNum7 then begin
      AddNumPadEntry(char('7'));
    end else if btn = btnNum8 then begin
      AddNumPadEntry(char('8'));
    end else if btn = btnNum9 then begin
      AddNumPadEntry(char('9'));
    end else if btn = btnNum0 then begin
      AddNumPadEntry(char('0'));
    end;
  end;
end;

procedure TPOSChequePopUp.edtInput1Change(Sender: TObject);
begin
  inherited;
//  if not CancelBtn.Enabled then begin
//    OKBtn.Enabled:= Trim(edtInput1.Text) <> '';
//  end;
end;

procedure TPOSChequePopUp.edtInput1Enter(Sender: TObject);
begin
  inherited;
  if Sender is TwwDBEdit then
    edtSelected := TwwDBEdit(Sender);
end;

procedure TPOSChequePopUp.AddNumPadEntry(const cDigit: char);
  { Adds the numeric digit to the views screen }
const
  CHR_BS = #8;
begin
       if cDigit ='.' then Sendkeys('{.}' , true)
  else if cDigit ='1' then Sendkeys('{1}' , true)
  else if cDigit ='2' then Sendkeys('{2}' , true)
  else if cDigit ='3' then Sendkeys('{3}' , true)
  else if cDigit ='4' then Sendkeys('{4}' , true)
  else if cDigit ='5' then Sendkeys('{5}' , true)
  else if cDigit ='6' then Sendkeys('{6}' , true)
  else if cDigit ='7' then Sendkeys('{7}' , true)
  else if cDigit ='8' then Sendkeys('{8}' , true)
  else if cDigit ='9' then Sendkeys('{9}' , true)
  else if cDigit ='0' then Sendkeys('{0}' , true)
  else if cDigit =char(VK_BACK) then Sendkeys('{BS}' , true);
  edtSelected.selstart := length(edtSelected.text);
end;

procedure TPOSChequePopUp.FormPaint(Sender: TObject);
var
  ColorMapRec: TColorMapRec;
begin
  ColorMapRec := GetGradientColor(Self.Classname);
  pnlTitle.Color := ColorMapRec.Color;
(*  TitleShader.FromColor := pnlTitle.Color;
  TitleShader.ToColorMirror := pnlTitle.Color;*)
  inherited;
  PaintGradientColor(Self);
end;

procedure TPOSChequePopUp.WMSysCommand(var Message: TWMSysCommand);
begin
  if (Message.CmdType and $FFF0 = SC_CLOSE) then begin
    { don't allow close }
  end
  else
    inherited;
end;

initialization
  RegisterClassOnce(TPOSChequePopUp);

end.
