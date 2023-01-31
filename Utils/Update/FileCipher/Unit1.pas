unit Unit1;

interface

uses Windows, Forms, SysUtils, Dialogs, StdCtrls, DNMSpeedButton,
     Controls, ExtCtrls, Shader, Classes;
type
  TForm1 = class(TForm)
    SpeedButton1: TDNMSpeedButton;
    Letter_Label: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    OpenDialog1: TOpenDialog;
    DNMSpeedButton1: TDNMSpeedButton;
    memFiles: TMemo;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  CipherUtils;

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var i: integer;
begin
  If (memFiles.Lines.Count > 0) and  FileExists(memFiles.Lines[memFiles.Lines.Count -1]) then
    OpenDialog1.InitialDir := memFiles.Lines[memFiles.Lines.Count -1];

  If (memFiles.Lines.Count > 0) and  DirectoryExists(ExtractFilePath(memFiles.Lines[memFiles.Lines.Count -1])) then
    OpenDialog1.InitialDir := ExtractFilePath(memFiles.Lines[memFiles.Lines.Count -1]);

  if OpenDialog1.Execute then begin
    for i:= 0 to OpenDialog1.Files.Count -1 do
      memFiles.Lines.Add(Opendialog1.Files[i]);
  end;
end;

procedure TForm1.btnOKClick(Sender: TObject);
var
  x: integer;
begin
  for x:= 0 to memFiles.Lines.Count -1 do
    CipherUtils.Encrypt(memFiles.Lines[x], memFiles.Lines[x] + '.enc');
  Close;
end;

procedure TForm1.DNMSpeedButton1Click(Sender: TObject);
var
  x: integer;
begin
  for x:= 0 to memFiles.Lines.Count -1 do
    CipherUtils.Decrypt(memFiles.Lines[x], memFiles.Lines[x] + '.dec');
  Close;
end;

procedure TForm1.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
