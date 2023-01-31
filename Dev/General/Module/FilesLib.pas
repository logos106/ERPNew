unit FilesLib;

interface
function IsFiletypeKnown(const FileName: string): Boolean;
Procedure Openfile(Const FileName:String; Handle:THandle; FileDetails:String);
Procedure OpenfileLoc(Const FileName:String; Handle:THandle);
Function Savetofile(const afilename:String; aData :String;cleanfile:boolean=False):Boolean ;

implementation

uses Registry, windows, sysutils, CommonLib, shellapi, tcConst, Dialogs;

Function Savetofile(const afilename:String; aData :String;cleanfile:boolean=False):Boolean ;
var
  F: TextFile;
begin
  if afilename = '' then exit;
  try
{$I-}
      Assignfile(F, afilename);
      if FileExists(afilename) and cleanfile then begin
        Rewrite(F); // new file
        Writeln(F, '');
      end else if not FileExists(afilename) then
        Rewrite(F)
      else
        Append(F);
      Writeln(F,  aData);
      CloseFile(F);
{$I+}
    except
      on E: Exception do begin
        CommonLib.MessageDlgXP_Vista('Failed to make the file :'+afilename + E.Message, mtWarning, [mbOK], 0);
      end;
    end;
end;
function IsFiletypeKnown(const FileName: string): Boolean;
var
  FileClass: string;
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_EXECUTE);
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    FileClass := '';
    if Reg.OpenKeyReadOnly(ExtractFileExt(FileName)) then begin
      FileClass := Reg.ReadString('');
      Reg.CloseKey;
      Result := FileClass <> '';
    end;
  finally
    Reg.Free;
  end;
end;
Procedure OpenfileLoc(Const FileName:String; Handle:THandle);
var
  sDir:String;
begin
    sDir := ExtractfilePath(filename);
    ShellExecute(Handle, 'open',PChar(sDir),nil, nil, SW_SHOW);
end;
Procedure Openfile(Const FileName:String; Handle:THandle; FileDetails:String);
var
  sExt, sDir:String;

begin
  if not IsFiletypeKnown(filename) then begin
    sExt := ExtractFileExt(filename);
    sDir := ExtractfilePath(filename);
    if MessageDlgXP_Vista('The ' + FileDetails +' is a ' + Quotedstr(sExt)+' file.'+NL+NL+'This type of file is not associated with any application in your machine.'+NL+NL+
                        'Please double click on the file ' +Quotedstr(FileName)+' for windows to let you choose an application to associate for this file type.',
                        mtInformation, [], 0 , nil , '' , '' , False, nil , 'Ok,Open File Location') = 101 then
      ShellExecute(Handle, 'open',PChar(sDir),nil, nil, SW_SHOW);
  end;
  ShellExecute(Handle, 'open',PChar(filename),nil, nil, SW_SHOW);
end;

end.
