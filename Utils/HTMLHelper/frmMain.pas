unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfmMain = class(TForm)
    pcMain: TPageControl;
    tabHTMLToStr: TTabSheet;
    memHTML: TMemo;
    Splitter1: TSplitter;
    memString: TMemo;
    pnlTop: TPanel;
    btnConvertToStr: TButton;
    btnFixReturns: TButton;
    procedure btnConvertToStrClick(Sender: TObject);
    procedure btnFixReturnsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.btnConvertToStrClick(Sender: TObject);
var
  s: string;
  I: Integer;
begin
  memString.Clear;
  for I := 0 to memHTML.Lines.Count -1 do begin
    if I < memHTML.Lines.Count -1 then s := ' +'
    else s := ';';
    //memString.Lines.Add('    ''' +  memHTML.Lines[I]  + '''' + s);
    memString.Lines.Add('    ' + QuotedStr(memHTML.Lines[I]) + s);
  end;
end;

procedure TfmMain.btnFixReturnsClick(Sender: TObject);
var
  s, s1: string;
  I: Integer;
begin
  s := memHTML.Text;
  memHTML.Clear;
  s1 := '';
  for I := 1 to Length(s) do begin
    if S[I] = Char(10) then s1 := s1 + Char(13) + Char(10)
    else S1 := s1 + S[I];
  end;
  memHTML.Text := s1;
end;

end.
