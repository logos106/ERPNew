unit tcVideoUtils;

interface
uses
  Classes;

type
  TWMVFileIterator = class
  private
    fFileList: TStringList;
    fCurrentFile: integer;
    function GetCount: integer;
  protected
    property FileList : TStringList read fFileList write fFileList;
    property CurrentFile : integer read fCurrentFile write fCurrentFile;
  public
    Constructor Create(const aFolder : string);
    Destructor Destroy; override;
    function Next : string;
    function First : string;
    Function Last : string;
    property Count : integer read GetCount;
  end;

function MediaPlayerInstalled : boolean;
function WMVFileList(const aFolder : string) : TStringList;

implementation
uses
  SysUtils, tcConst, Forms, SystemLib;

function MediaPlayerInstalled : boolean;
begin
  Result := (FileExists(ExpandEnvStr('%ProgramFiles(x86)%') + '\Windows Media Player\WMPlayer.exe') or
            FileExists(ExpandEnvStr('%ProgramFiles%') + '\Windows Media Player\WMPlayer.exe')) or
            (FileExists(ExpandEnvStr('%ProgramFiles(x86)%') + '\VideoLAN\VLC\vlc.exe') or
            FileExists(ExpandEnvStr('%ProgramFiles%') + '\VideoLAN\VLC\vlc.exe'))

end;

function WMVFileList(const aFolder : string) : TStringList;
var
  s : string;
  sr : TSearchRec;
begin
//  Player.FileName := ExtractFilePath(Application.ExeName) + csSplashScreenVideoFile;
  Result := TStringList.Create;
  s := ExtractFilePath(Application.ExeName) + aFolder;
  if FindFirst(s + '*.wmv', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) and
         SameText(ExtractFileExt(SR.Name), '.wmv') then
      begin
        Result.Add(s + SR.Name);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;
{ TWMVFileIterator }

constructor TWMVFileIterator.Create(const aFolder: string);
begin
  inherited Create;
  if MediaPlayerInstalled then
  begin
    FileList := WMVFileList(aFolder);
  end
  else
    FileList := TStringList.Create;
  CurrentFile := 0;
end;

destructor TWMVFileIterator.Destroy;
begin
  FileList.Free;
  inherited;
end;

function TWMVFileIterator.First: string;
begin
  CurrentFile := 0;
  if Count > 0 then
    Result := FileList[CurrentFile]
  else
    Result := '';
end;

function TWMVFileIterator.GetCount: integer;
begin
  Result := FileList.Count;
end;

function TWMVFileIterator.Last: string;
begin
  if Count > 0 then
  begin
    CurrentFile := Count - 1;
    Result := FileList[CurrentFile]
  end
  else
    Result := '';
end;

function TWMVFileIterator.Next: string;
begin
  if Count > 0 then
  begin
    CurrentFile := CurrentFile + 1;
    if CurrentFile = Count then
      CurrentFile := 0;
    Result := FileList[CurrentFile];
  end
  else
    Result := '';
end;

end.
