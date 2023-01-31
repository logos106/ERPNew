Unit frmCombineTemplatesFrm;

Interface

Uses
  Windows,Forms,Dialogs, StdCtrls, Buttons, Controls, ComCtrls, Classes,
  Shader, ExtCtrls, DNMPanel;

Type
  TCombineTemplatesGUI = Class(TForm)
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    Letter_Label: TLabel;
    lblImporting: TLabel;
    ImportProgressBar: TProgressBar;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    txtFilePath: TMemo;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);

  Private
    { Private declarations }
    TempFilePath:String;
    CombinedTemplates:String;
    CombinedF,F: TextFile;
    function Empty(const s: string): boolean;
    procedure DeleteFiles(Const Path, Mask: String);
    function TempDir: string;
    Function IsDir(Const DirPath: String): Boolean;
    Function IsFile(Const FileName: String): Boolean;
    Function LineCount(Const FileName: String): integer;
    Function GetLineOfString(Const I,LinesCount: Integer): String;
    procedure ExtractFiles(Const FileName, DataPath: String);
    procedure CompressFiles(Const FilesPath: String);
    Function DirectoryCopy(Const FromPath,ToPath,FileMask: String): Boolean;    
  Public
    { Public declarations }
  End;

var
  CombineTemplatesGUI: TCombineTemplatesGUI;

implementation

uses
  SysUtils,CabSTComps, FastFuncs, ShellAPI;

const
  MAXSTRINGLEN = 255;

{$R *.DFM}

procedure TCombineTemplatesGUI.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

Function TCombineTemplatesGUI.IsDir(Const DirPath: String): Boolean;
Begin
  Result := DirectoryExists(DirPath);
End;

Function TCombineTemplatesGUI.IsFile(Const FileName: String): Boolean;
Begin
  Result := FileExists(FileName);
End;

Function TCombineTemplatesGUI.LineCount(Const FileName: String): integer;
var
  Count: Integer;
begin
  Count := 0;
  AssignFile(F,FileName);
  Reset(F);
    while not eof(F) do begin
    readln(F);
    inc(Count);
    end;
   CloseFile(F);
   result:= Count;
end;

procedure TCombineTemplatesGUI.SpeedButton1Click(Sender: TObject);
Var
  I:Integer;
begin
  if OpenDialog1.Execute then begin
    for I := Opendialog1.Files.Count-1 downto 0 do
      txtFilePath.Lines.Add(Opendialog1.Files[I]);
  end;
end;

procedure TCombineTemplatesGUI.btnOKClick(Sender: TObject);
var
LINESTRING:String;
TempFilePathCombined:String;
FCount,I,LinesCount:Integer;
begin
 btnOK.Enabled := False;
 try
     If empty(txtFilePath.Lines.Text) then begin
        SpeedButton1Click(Sender);
     end;
     CombinedTemplates:='';
     for FCount := 0 to (txtFilePath.Lines.Count-1) do Begin
       TempFilePath := '';
       If IsDir(ExtractFileDir(txtFilePath.Lines[FCount])) then begin
            If IsFile(txtFilePath.Lines[FCount]) then begin
             //Import Function
              lblImporting.Caption := 'Please Wait Combining ..... 0%';
              lblImporting.Visible := True;

            //Decompress Files
                //TempFilePath := TempDir + 'Platinum1TemplateExport\Templates.pdi';
                TempFilePath := TempDir + 'ERPTemplateExport\Templates.pdi';
                    try
                     if not IsDir(ExtractFileDir(TempFilePath)) then begin
                       MkDir(ExtractFileDir(TempFilePath));
                     end;
                    except
                    end;
                    ExtractFiles(txtFilePath.Lines[FCount], ExtractFileDir(TempFilePath));
           //Start Process
              LinesCount := LineCount(TempFilePath);
              ImportProgressBar.Min := 0;
              ImportProgressBar.Max:=LinesCount;
              ImportProgressBar.Position := ImportProgressBar.Min;
                try
                    AssignFile ( F, TempFilePath );
                    Reset ( F );
                    for I := 1 to LinesCount do Begin
                        //get next Line
                       LINESTRING := GetLineOfString(I,LinesCount);

                       // Process Line String
                       LINESTRING := Trim(LINESTRING);

                       {COMBINE HERE}
                       If not Empty(LINESTRING) then Begin
                        CombinedTemplates := CombinedTemplates + LINESTRING + #13#10 ;
                       end;
                    End;
              finally
                CloseFile (f);
              end;
               //Delete Temp Directory
               try
                 DeleteFiles(ExtractFileDir(TempFilePath)+ '\','*.*');
               except
               end;

               lblImporting.Visible := True;
            end else begin
             MessageDlg('File "' + txtFilePath.Lines[FCount] + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
            end;
       end else begin
         MessageDlg('Directory "' + ExtractFileDir(txtFilePath.Lines[FCount]) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
       end;
     end;

        //Create Combined Str File
        TempFilePathCombined := TempDir + 'Platinum1TemplateExportCombined\Templates.pdi';
        if not DirectoryExists(ExtractFileDir(TempFilePathCombined)) then begin
          ForceDirectories(ExtractFileDir(TempFilePathCombined));
        end;
        AssignFile ( CombinedF,TempFilePathCombined  );
        Rewrite(CombinedF);
        Writeln(CombinedF,CombinedTemplates);
        Flush(CombinedF);
        CloseFile(CombinedF);

        //Copy RTMs
        if not DirectoryExists(ExtractFileDir(TempFilePathCombined) + '\TemplateFiles') then begin
          ForceDirectories(ExtractFileDir(TempFilePathCombined)+'\TemplateFiles');
        end;
        DirectoryCopy(ExtractFileDir(TempFilePath)+'\TemplateFiles',ExtractFileDir(TempFilePathCombined)+'\TemplateFiles','*.*');

        //Compress Combined Templates
        CompressFiles(ExtractFileDir(TempFilePathCombined));

           //Delete Temp Directory
                 {$I-}
                 try
                   DeleteFiles(ExtractFileDir(TempFilePath)+ '\TemplateFiles\','*.*');
                   DeleteFiles(ExtractFileDir(TempFilePath)+ '\','*.*');
                   RmDir(ExtractFileDir(TempFilePath)+ '\TemplateFiles');
                   RmDir(ExtractFileDir(TempFilePath));
                 except
                 end;

           //Delete CombinedTemp Directory
                 try
                   DeleteFiles(ExtractFileDir(TempFilePathCombined)+ '\TemplateFiles\','*.*');
                   DeleteFiles(ExtractFileDir(TempFilePathCombined)+ '\','*.*');
                   RmDir(ExtractFileDir(TempFilePathCombined)+ '\TemplateFiles');
                   RmDir(ExtractFileDir(TempFilePathCombined));
                 except
                 end;
                 {$I+}

  Self.Close;
  Finally
    btnOK.Enabled := True;
  end;
end;

function TCombineTemplatesGUI.GetLineOfString(Const I,LinesCount: integer): String;
begin
    try
      Readln(F,result);
      ImportProgressBar.StepIt;
      lblImporting.Caption := 'Please Wait Combining ..... ' + FloatToStrF(((I/LinesCount)* 100),ffFixed,18,0) + '% Complete';
      Application.ProcessMessages;
    except
      on EInOutError do result := '';
    end;
end;

procedure TCombineTemplatesGUI.ExtractFiles(Const FileName, DataPath: String);
var
  aCabRd: TSTCabReader;
begin
  aCabRd := TSTCabReader.Create(nil);
  try
    aCabRd.ExtractFiles(FileName, DataPath);
  finally
    aCabRd.Free;
  end;
end;


procedure TCombineTemplatesGUI.CompressFiles(Const FilesPath: String);
var
  aCabWr: TSTCabWriter;
begin
  aCabWr := TSTCabWriter.Create(nil);
  try
    aCabWr.CompressionType := cctMsZip;
    aCabWr.Open(ExtractFileDir(ParamStr(0))+'\CombinedTemplates.ptd');
    aCabWr.AddFiles(FilesPath +'\*.pdi', '', [cafsoRecurseSubdirs]);
    aCabWr.AddFiles(FilesPath +'\TemplateFiles\*.tcr', 'TemplateFiles', [cafsoRecurseSubdirs]);
  finally
    aCabWr.Close;
    aCabWr.Free;
  end;
end;

function TCombineTemplatesGUI.DirectoryCopy(Const FromPath, ToPath, FileMask: String): Boolean;
var
  CopyFilesSearchRec: TSearchRec;
  FindFirstReturn:    Integer;
Begin
  Result := False;
  FindFirstReturn :=  FindFirst(FromPath+'\'+FileMask, faAnyFile, CopyFilesSearchRec);
  If Not (CopyFilesSearchRec.Name = '') And (FindFirstReturn=0) Then Begin
    Result := True;
    CopyFile(PChar(FromPath+'\'+CopyFilesSearchRec.Name),PChar(ToPath+'\'+CopyFilesSearchRec.Name),False);
    While True Do Begin
      If FindNext(CopyFilesSearchRec)<>0 Then Begin
        Break;
      End Else Begin
        CopyFile(PChar(FromPath+'\'+CopyFilesSearchRec.Name),PChar(ToPath+'\'+CopyFilesSearchRec.Name),False);
        Application.ProcessMessages;
      End;
    End;
  End;
End;

function TCombineTemplatesGUI.Empty(const s: string): boolean;
begin
  result := (Fastfuncs.Trim(s) = '');
end;

function TCombineTemplatesGUI.TempDir: string;
(*var
  acDir: array[0..MAXSTRINGLEN] of char;
begin
  GetTempPath(SizeOf(acDir), acDir);
  result := StrPas(acDir);*)
var
  Buffer: array[0..MAX_PATH] of char;
begin
//  {$ifdef COMPILER_22_UP}
  GetTempPath(Length(Buffer), Buffer);
//  {$else}
//  GetTempPath(SizeOf(Buffer) - 1, Buffer);
//  {$endif}
  Result := StrPas(Buffer);
end;

procedure TCombineTemplatesGUI.DeleteFiles(const Path, Mask: String);
var
  lpFileOp : TSHFileOpStruct;
begin
  FillChar(lpFileOp, sizeof(lpFileOp), #0);
  lpFileOp.wFunc  := FO_DELETE;
  // The + #0 is required
  lpFileOp.pFrom  := PChar(Path + Mask + #0);
  lpFileOp.pTo    := PChar(Path);
  lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
  //Perform Operation
  if (SHFileOperation(lpFileOp) <> 0) then Exit;
end;

end.


