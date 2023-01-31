unit InnoSetupUtils;

interface

{ will search aDir for innosetup log files (eg unins000.dat) and
  find the one that belongs to aAppName then if found
  run the coresponding uninstaller (eg unins000.exe) }
function UninstallApp(const aDir, aAppName: string; WaitMilliseconds: integer = 0): boolean;

implementation

uses
  classes, sysutils, AppRunUtils;

function GetInnoLogAppName(aInnoLogFile: string): string;
var
  stream: TFileStream;
  ch: Char;
  x: integer;
begin
  result:= '';
  stream:= TFileStream.Create(aInnoLogFile,fmOpenRead);
  try
    stream.Position:= 64;
    for x:= 0 to 63 do begin
      stream.Read(ch,1);
      if Ord(ch) <> 0 then
        result:= result + ch;
    end;
  finally
    stream.Free;
  end;
  result:= Trim(result);
end;


{ will search aDir for innosetup log files (eg unins000.dat) and
  find the one that belongs to aAppName then if found
  run the coresponding uninstaller (eg unins000.exe) }
function UninstallApp(const aDir, aAppName: string; WaitMilliseconds: integer = 0): boolean;
var
  sr: TSearchRec;
  uninstFile: string;
  waitForUninstall: boolean;
begin
  result:= true;
  waitForUninstall := WaitMilliseconds > 0;
  if DirectoryExists(aDir) then begin
    uninstFile:= '';
    if FindFirst(aDir + 'unins???.dat', faAnyFile, sr) = 0 then begin
      repeat
        if (aAppName = '') or  { any inno uninstaller found }
          (Lowercase(GetInnoLogAppName(aDir + sr.Name)) = Lowercase(aAppName)) then begin
          uninstFile:= sr.Name;
          uninstFile:= ChangeFileExt(uninstFile,'.exe');
          { run the uninstaller and wait }
          result:= AppRunUtils.ExecNewProcess(aDir + uninstFile + ' /VERYSILENT /SUPPRESSMSGBOXES /NORESTART', waitForUninstall, WaitMilliseconds);
          if (aAppName <> '') or (not result) then
            Break;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  end;
end;

end.
