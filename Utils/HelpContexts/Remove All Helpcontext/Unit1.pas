unit Unit1;

interface

Uses Windows, Classes, Forms, Sysutils, Controls, StdCtrls;

type
  TDirListCallback = function (const FileInfo: TSearchRec;
                               const Path: string): Boolean of Object;
type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    DFMPaths: TStringList;
    PathDIR: TStringList;
    procedure AddDFM(Dir: string; List: TStringList);
    procedure AddSubDirectories(Dir: string; List: TStringList);
    procedure DirectoryRecursionFileList(const Path: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  FastFuncs, Dialogs;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DFMPaths := TStringList.Create;
  DFMPaths.Duplicates := dupIgnore;
  PathDIR := TStringList.Create;
  PathDIR.Duplicates := dupIgnore;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DFMPaths);
  FreeAndNil(PathDIR);
end;

procedure TForm1.AddSubDirectories(Dir: string; List: TStringList);
var
  R: TSearchRec;
begin
  if FindFirst(Dir + '\*.*', faDirectory, R) = 0 then
  begin
    if (R.Attr and faDirectory <> 0) and
       (R.Name <> '.') and
       (R.Name <> '..') then
      List.Add(Dir + '\' + R.Name);
    while FindNext(R) = 0 do
      if (R.Attr and faDirectory <> 0) and
         (R.Name <> '.') and
         (R.Name <> '..') then Begin
          List.Add(Dir + '\' + R.Name);
          AddSubDirectories(Dir + '\' + R.Name, List);
        end;
  end;
  FindClose(R);
end;

procedure TForm1.AddDFM(Dir: string; List: TStringList);
var
  R: TSearchRec;
begin
  if FindFirst(Dir + '\*.dfm', faAnyFile	, R) = 0 then
  begin
    if (R.Attr and faAnyFile	 <> 0) and
       (R.Name <> '.') and
       (R.Name <> '..') then
      List.Add(Dir + '\' + R.Name);
    while FindNext(R) = 0 do
      if (R.Attr and faAnyFile <> 0) and
         (R.Name <> '.') and
         (R.Name <> '..') then Begin
          List.Add(Dir + '\' + R.Name);
          AddSubDirectories(Dir + '\' + R.Name, List);
        end;
  end;
  FindClose(R);
end;


procedure TForm1.DirectoryRecursionFileList(const Path: string);
var
  I:Integer;
begin
  PathDIR.Clear;
  AddSubDirectories(Path ,PathDIR);
  DFMPaths.Clear;
  for I := 0 to PathDIR.Count -1 do begin
    AddDFM(PathDIR[I],DFMPaths);
  end;
  PathDIR.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DirectoryRecursionFileList('C:\P1\Dev');
  Memo1.Lines.Text := DFMPaths.Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I:Integer;
  DFMFile: TStringList;

  Function HasRemovedHelpContext(Const DFMTEXT:TStringList):Boolean;
  Var
    Index :Integer;
  Begin
      Result := False;
      for Index := 0 to DFMTEXT.Count - 1 do Begin
        If FastFuncs.PosExIgnoreCase('HelpContext = ',DFMTEXT[Index])> 0 then begin
          DFMTEXT.Delete(Index);
          Result := True;
          Exit;
        end;
      end;  
  end;

begin
  DFMFile := TStringList.Create;
  Try
    for I := 0 to DFMPaths.Count -1 do begin
      If FileExists(DFMPaths[I]) then
        DFMFile.LoadFromFile(DFMPaths[I]);
      DFMFile.SaveToFile(DFMPaths[I]+'_'+ FormatDateTime('yyyy-mm-dd_hhnnss', Now)+'.bak');
      While HasRemovedHelpContext(DFMFile) do;
      DFMFile.SaveToFile(DFMPaths[I]);
      DFMFile.Clear;
    end;
    DFMPaths.Clear;
    Memo1.Clear;
  Finally
    FreeAndNil(DFMFile);
  end;
  MessageDlg('Done !', mtInformation, [mbOK], 0);
end;

end.


 