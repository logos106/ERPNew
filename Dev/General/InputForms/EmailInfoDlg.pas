unit EmailInfoDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, tcTypes, ExtCtrls, Shader,
  DNMPanel, frmBase;

type
  TfrmEmailInfoDlg = class(TfrmBaseGUI)
    Label1: TLabel;
    edtEmailAddress: TEdit;
    Label2: TLabel;
    edtSMTPHost: TEdit;
    Label3: TLabel;
    edtPort: TEdit;
    bbtnOk: TDNMSpeedButton;
    bbtnCancel: TDNMSpeedButton;
    Label4: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Bevel1: TBevel;
    procedure bbtnOkClick(Sender: TObject);
    procedure edtPortExit(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    procedure CheckEnteredData;
  public
    { Public declarations }
  end;

var
  frmEmailInfoDlg: TfrmEmailInfoDlg;

function GetBasicEmailInfo: TBasicEmailInfoRec;  

implementation

uses CommonLib,CommonDbLib, FastFuncs;

{$R *.dfm}

function GetBasicEmailInfo: TBasicEmailInfoRec;  
begin
  Result.Address := '';
  Result.Host := '';
  Result.Port := 0;
  Result.Success := false;
  
  with TfrmEmailInfoDlg.Create(nil) do try
      if ShowModal = mrOk then begin
        Result.Address := edtEmailAddress.Text;
        Result.Host := edtSMTPHost.Text;
        Result.Port := FastFuncs.StrToInt(edtPort.Text);
        Result.Success := true;
      end;
    finally
      Free;
    end;
end;

procedure TfrmEmailInfoDlg.bbtnOkClick(Sender: TObject);
begin
  CheckEnteredData;
  ModalResult := mrOk;
end;

procedure TfrmEmailInfoDlg.CheckEnteredData;
begin
  if edtEmailAddress.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter the email address', mtInformation, [mbOK], 0);
    Abort;
  end;

  if edtSMTPHost.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter the SMTP host', mtInformation, [mbOK], 0);
    Abort;
  end;
  
  if edtPort.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter the Port number', mtInformation, [mbOK], 0);
    Abort;
  end;
end;

procedure TfrmEmailInfoDlg.edtPortExit(Sender: TObject);
begin
  try
    FastFuncs.StrToInt(edtPort.Text);
  except
    CommonLib.MessageDlgXP_Vista('Only the whole numbers are allowed', mtInformation, [mbOK], 0);
    edtPort.Clear;
    SetControlFocus(edtPort);
  end;
end;

procedure TfrmEmailInfoDlg.FormPaint(Sender: TObject);
var
  ColorMapRec: TColorMapRec;
begin
  ColorMapRec := GetGradientColor(Self.Classname);
  pnlTitle.Color := ColorMapRec.Color;
  TitleShader.FromColor := Self.Color;//pnlTitle.Color;
  TitleShader.ToColorMirror := Self.Color;//pnlTitle.Color;
  inherited;
  PaintGradientColor(Self);
end;

end.
