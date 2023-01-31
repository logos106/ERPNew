unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    btnFile: TButton;
    memText: TMemo;
    OpenDialog: TOpenDialog;
    procedure btnFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

function ReplaceTabs(inStr: string): string;
var
  x: integer;
begin
  result:= '';
  for x:= 1 to Length(inStr) do begin
    if inStr[x] = #9 then
      result:= result + '  '
    else
      result:= result  + inStr[x];
  end;
end;

procedure TfmMain.btnFileClick(Sender: TObject);
var
  sl: TStringList;
  x: integer;
  s: string;
const
//  lineEnd = '+#13#10+';
  lineEnd = '+nl+';


begin
  if OpenDialog.Execute then begin
    memText.Lines.Clear;
    sl:= TStringList.Create;
    try
      sl.LoadFromFile(OpenDialog.FileName);
      for x:= 0 to sl.Count -1 do begin
        s:= '''' + ReplaceTabs(sl[x]) + '''';
        if x < sl.Count -1 then begin
          while (Length(s) + Length(lineEnd)) < 80 do
            s:= s + ' ';
          s:= s + lineEnd;
        end;
        memText.Lines.Add(s);
      end;


    finally
      sl.Free;
    end;
  end;
end;

end.
