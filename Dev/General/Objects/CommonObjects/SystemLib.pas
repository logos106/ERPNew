unit SystemLib;

// Windows system related functions

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 14/03/05  1.00.00 IJB  Inital version.
  // 16/03/05  1.00.01 IJB  Added tempory file and temp directory functions

// {$I ERP.inc}
interface
{$WARN SYMBOL_PLATFORM OFF}

uses
  {$IfDef VER220}
  Windows,
  SysUtils,
  Classes
  {$Else}
  WinApi.Windows,
  System.SysUtils,
  System.Classes
  {$EndIf}
  ;

type
  PHICON = ^HICON;

const
  TemporyFileSubDir = 'Temp';

function IsValidFileName(const FileName: TFileName): boolean;

  // see notes below in implementation section
function GetAssociatedIcon(const AExtension: string; ASmall: boolean): HIcon;

  // see notes below in implementation section
procedure GetAssociatedIcons(FileName: TFileName; PLargeIcon, PSmallIcon: PHICON);

  // return the windows system directory
function GetSystemDir: TFileName;

  // Windows enviroment functins, see notes in implementation section
function GetEnvVarValue(const VarName: string): string;
function SetEnvVarValue(const VarName, VarValue: string): integer;
function DeleteEnvVar(const VarName: string): integer;
function GetAllEnvVars(const Vars: TStrings): integer;
function ExpandEnvVars(const Str: string): string;
function ExpandEnvStr(const szInput: string): string;
function CreateEnvBlock(const NewEnv: TStrings; const IncludeCurrent: boolean; const Buffer: Pointer;
  const BufSize: integer): integer;

procedure ExecNewProcess(const ProgramName: string; const Wait: boolean);
function ExecNewWinProcess(const ProgramName: string; const Wait: boolean; var msg: string): boolean;

  // returns the windows tempry directory
function WinTempDir: string;
function WinSysDir: string;
function WinDir: string;

  // Gets/creates application tempory directory
  // (sub dir of win temp dir with same name as app)
  // All files will be deleted from this directory when app closes
function GetAppTempDir: string;

  // All tempory files will be deleted when the appp closes
function GetTempFileName(const SuffixName: string = ''; const Extension: string = '.tmp';
  const CreateTheFile: boolean = false): string;

  // deletes all files from app temp dir
  // NOTE: this is called in Finalization section
procedure DeleteAllAppTemporyFiles;

//function GetFileVersion(const FileName: string): string;


function HasAttr(const FileName: string; Attr: Word): Boolean;


function SetFileDate(Const FileName : String;Const FileDate : TDateTime): Boolean;
function GetFileDate(FileName: string): TDateTime;
{* Returns path of special folders *}
function SpecialFolder(CSIDL: Integer): String;

function GetDesktopDir: string;
//{$ifdef COMPILER_22_UP}
function GetLocalAppDataDir: string;
function GetRoamingAppDataDir: string;
//{$endif}
function GetMyDocumentsDir: string;
function GetAllUserDocumentsDir: string;


{ This function forces windows to remove current app from physical memory to
  swap file (like when an app is minimized), this will "defrag" memory
  and free up unused memory }
procedure TrimWorkingSet;

{current memory size of the current process in bytes}
function CurrentMemoryUsage: Cardinal;
function TotalPhysicalMemoryBytes: Cardinal;

function CopyDir(const fromDir, toDir: string): Boolean;
function MoveDir(const fromDir, toDir: string): Boolean;
function DelDir(dir: string): Boolean;

function BringWindowToFront(WindowCaption: string): boolean;

function ProcessExists(exeFileName: string): Boolean;
function OutGoingFileName(dbname, Prefix,Suffix , extension :String):String;
Function GetValidfileName(filename:String):String;
function BooleanToStr(const Value:Boolean):String;
function BooleanToString(const Value:Boolean):String;
function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
function ExeDir: string;
function CharCounter(const char, TestString: string): integer;
function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
function GetCurrentWindowsUserName: string;
Function Searchfile(Const PathnfileToSerach:String; Resulttype:String):String;

{ returns true if running on windows server }
function IsWinServer : Boolean;


function StrToValidFileName(s: string; ReplaceInvalidCharWith: string = '_'): string;
function IsFileInUse(fName : string) : boolean;
function FileCanBeOpendForReading(const aFileName: string): boolean;

{ Get windows location id string .. eg en-au }
// function GetLCIDString: string;

function Is64BitWindows: boolean;

function ChangeFileNameIfExists(aFileName: string): string;
Function Roundfix(Fieldname:String):String;

function IsConsoleApp: boolean;

//Makes a string of aLength filled with random characters
function RandomStr(const aLength: longint): string;
Function ERPListMaxDatetime:TdateTime;
Function ERPListMinDatetime:TdateTime;


implementation

uses
  {$IfDef VER220}
  Dialogs,
  Registry, ShellAPI, ShlObj,
  PsAPI, { used for CurrentMemoryUsage }
  TlHelp32, { used for ProcessExists }
  {$Else}
  Vcl.Dialogs,
  WinApi.ShellApi,
  System.Win.Registry,
  WinApi.ShlObj,
  WinApi.PsAPI, { used for CurrentMemoryUsage }
  WinApi.TlHelp32, { used for ProcessExists }
  {$EndIf}
  Forms,ogutil,OnGuard,
  StrUtils, DateUtils  ;
var
  AppTempDir: string = '';

function BringWindowToFront(WindowCaption: string): boolean;
var
  handle: HWND;
  buffer: array[0..MAX_PATH] of char;
  i: Integer;
  s: string;
begin
  result:= false;
  handle := GetWindow(FindWindow(nil, nil), 0);
  While (handle <> 0) do begin
    i := GetWindowText(handle, buffer, MAX_PATH);
    if (i > 0) then begin
      s:= buffer;
      if Pos(Uppercase(WindowCaption),UpperCase(s)) > 0 then begin
        result:= true;
       {$IfDef VER220}
        Windows.ShowWindow(handle,1);
        Windows.SetForegroundWindow(handle);
        Windows.SetFocus(handle);
       {$Else}
        WinApi.Windows.ShowWindow(handle,1);
        WinApi.Windows.SetForegroundWindow(handle);
        WinApi.Windows.SetFocus(handle);
       {$EndIf}
        break;
      end;
    end;
    handle := GetWindow(handle, GW_HWNDNEXT);
  end;
end;

function StrToValidFileName(s: string; ReplaceInvalidCharWith: string): string;
var
  x: integer;
begin
  result := '';
  for x := 1 to Length(s) do
    if not CharInSet(s[x], ['\','/',':','*','?','"','<','>','|']) then
      result := result + s[x]
    else
      result := result + ReplaceInvalidCharWith;
end;

function IsValidFileName(const FileName: TFileName): boolean;
begin
//  {$ifdef COMPILER_22_UP}
  Result := (FileName <> '') and (Pos('\', FileName) = 0) and (Pos('/', FileName) = 0) and
    (Pos(':', FileName) = 0) and (Pos('*', FileName) = 0) and (Pos('?', FileName) = 0) and
    (Pos('"', FileName) = 0) and (Pos('<', FileName) = 0) and (Pos('>', FileName) = 0) and (Pos('|', FileName) = 0);
//  {$else}
//  Result := (FileName <> '') and (Pos('\', FileName) = 0) and (Pos('/', FileName) = 0) and
//    (Pos(':', FileName) = 0) and (Pos('*', FileName) = 0) and (Pos('?', FileName) = 0) and
//    (Pos('"', FileName) = 0) and (Pos('<', FileName) = 0) and (Pos('>', FileName) = 0) and (Pos('|', FileName) = 0);
//  {$endif}
end;

  // -----------------------------------------------------------------------------
  //
  //  Windows Enviroment functions
  //
  //------------------------------------------------------------------------------


  // This routine returns the value of a given environment variable
  // (or returns the empty string if there is no variable with that name).
function GetEnvVarValue(const VarName: string): string;
var
  BufSize: integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then begin
    // Read env var value into result string
    Setlength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName),
      PChar(Result), BufSize);
  end else // No such environment variable
    Result := '';
end;

  // This routine sets the value of an environment variable.
  // If the variable doesn't already exists it is created.
  // Zero is returned if all goes well, otherwise a Windows error code is returned.
  // An error may occur if there is no room in the environment block for the new value.
  // Setting an environment variable only operates on the program's copy of the
  // variable – it does not update the value of Window's copy of the variable.
function SetEnvVarValue(const VarName, VarValue: string): integer;
begin
  // Simply call API function
  if SetEnvironmentVariable(PChar(VarName),
    PChar(VarValue)) then Result := 0
  else Result := GetLastError;
end;

  // This routine deletes the given environment variable.
  // Note that SetEnvVarValue('') has the same effect. Again, zero is returned
  // on success and a Windows error code on error.
  // This function has no effect on Window's own copy of the environment variable.
function DeleteEnvVar(const VarName: string): integer;
begin
  if SetEnvironmentVariable(PChar(VarName), nil) then Result := 0
  else Result := GetLastError;
end;

  // This routine returns all the environment variables in a string list.
  // Each entry in the list is of the form Name=Value.
  // You can use the TStrings Names[] and Values[] properties to extract the
  // variable names and value from the string.
  // The function returns the amount of space taken by the strings in the
  // environment block. If you just want to know the size of the environment
  // variables, pass a nil parameter. Here's the definition:
function GetAllEnvVars(const Vars: TStrings): integer;
var
  PEnvVars: PChar;    // pointer to start of environment block
  PEnvEntry: PChar;   // pointer to an env string in block
begin
  // Clear the list
  if Assigned(Vars) then Vars.Clear;
  // Get reference to environment block for this process
  PEnvVars := GetEnvironmentStrings;
  if PEnvVars <> nil then begin
    // We have a block: extract strings from it
    // Env strings are #0 separated and list ends with #0#0
    PEnvEntry := PEnvVars;
    try
      while PEnvEntry^ <> #0 do begin
        if Assigned(Vars) then Vars.Add(PEnvEntry);
        Inc(PEnvEntry,  Length(PEnvEntry) + 1);
      end;
      // Calculate length of block
      Result := (PEnvEntry - PEnvVars) + 1;
    finally
      // Dispose of the memory block
      {$IfDef VER220}
      Windows.FreeEnvironmentStrings(PEnvEntry);
      {$Else}
      WinApi.Windows.FreeEnvironmentStrings(PEnvEntry);
      {$EndIf}
    end;
  end else // No block => zero length
    Result := 0;
end;

  // This function takes as a parameter a string of text containing one or more
  // environment variables, delimited by % characters, and returns the string
  // with each environment variable replaced by its value. E.g. if the
  // PROMPT environment variable has value '$p$g' then
  // ExpandEnvVars('The prompt is %PROMPT%') returns 'The prompt is $p$g'.
  // Note: This function can be useful when reading registry string of type
  // REG_EXPAND_SZ from the registry since these strings contain un-expanded
  // environment variables. Passing such a string to this function will expand
  // all the variables.
function ExpandEnvVars(const Str: string): string;
var
  BufSize: integer; // size of expanded string
begin
  // Get required buffer size
  BufSize := ExpandEnvironmentStrings(PChar(Str), nil, 0);
  if BufSize > 0 then begin
    // Read expanded string into result string
    Setlength(Result, BufSize);
    ExpandEnvironmentStrings(PChar(Str),
      PChar(Result), BufSize);
  end else // Trying to expand empty string
    Result := '';
end;

function ExpandEnvStr(const szInput: string): string;
var
  Dir : PChar;
begin
  Dir := StrAlloc(MAX_PATH);
  ExpandEnvironmentStrings(pchar(szInput),Dir, MAX_PATH);
  Result := String(Dir);
  StrDispose(Dir);
end;

  // This final function creates an environment block that can be passed to a
  // child process. It creates a new environment block containing the given strings.
  // If the IncludeCurrent parameter is true then the variables defined in the
  // current process's environment block are included. The new block is stored in
  // the memory pointed to by Buffer, which must be at least BufSize bytes.
  // The size of the block is returned. If the provided buffer is nil or is too
  // small then no block is created. The return value gives the required buffer size.

  // The way we use this function is similar to the idiom used by many Windows API
  // functions (such as GetEnvironmentVariable). We first call the function with
  // a nil buffer to find the required buffer size, then call it again with a
  // buffer of correct size to receive the data.
function CreateEnvBlock(const NewEnv: TStrings; const IncludeCurrent: boolean; const Buffer: Pointer;
  const BufSize: integer): integer;
var
  EnvVars: TStringList; // env vars in new block
  Idx: integer;         // loops thru env vars
  PBuf: PChar;          // start env var entry in block
begin
  // String list for new environment vars
  EnvVars := TStringList.Create;
  try
    // include current block if required
    if IncludeCurrent then GetAllEnvVars(EnvVars);
    // store given environment vars in list
    if Assigned(NewEnv) then EnvVars.AddStrings(NewEnv);
    // Calculate size of new environment block
    Result := 0;
    for Idx := 0 to Pred(EnvVars.Count) do Inc(Result, Length(EnvVars[Idx]) + 1);
    Inc(Result);
    // Create block if buffer large enough
    if (Buffer <> nil) and (BufSize >= Result) then begin
      // new environment blocks are always sorted
      EnvVars.Sorted := true;
      // do the copying
      PBuf := Buffer;
      for Idx := 0 to Pred(EnvVars.Count) do begin
        StrPCopy(PBuf, EnvVars[Idx]);
        Inc(PBuf, Length(EnvVars[Idx]) + 1);
      end;
      // terminate block with additional #0
      PBuf^ := #0;
    end;
  finally
    FreeAndNil(EnvVars);
  end;
end;

//------------------------------------------------------------------------------

procedure ExecNewProcess(const ProgramName: string; const Wait: boolean);
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: boolean;
begin
  { fill with known state }
  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);
  CreateOK := CreateProcess(nil, PChar(ProgramName), nil, nil, false, CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS,
    nil, nil, StartInfo, ProcInfo);
  { check to see if successful }
  if CreateOK then begin
    //may or may not be needed. Usually wait for child processes
    if Wait then WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  end else begin
    MessageDlg('Unable to run ' + ProgramName, mtInformation , [mbOK], 0);
  end;
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;

function ExecNewWinProcess(const ProgramName: string; const Wait: boolean; var msg: string): boolean;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: boolean;
begin
  { fill with known state }
  result:= true;
  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);
  CreateOK := CreateProcess(nil, PChar(ProgramName), nil, nil, false, CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS,
    nil, nil, StartInfo, ProcInfo);
  { check to see if successful }
  if CreateOK then begin
    //may or may not be needed. Usually wait for child processes
    if Wait then WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  end else begin
    result:= false;
    msg:= 'Unable to run ' + ProgramName;
  end;
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;

//------------------------------------------------------------------------------

// return the windows system directory
function GetSystemDir: TFileName;
var
  SysDir: array [0..MAX_PATH - 1] of char;
begin
  SetString(Result, SysDir, GetSystemDirectory(SysDir, MAX_PATH));
  if Result = '' then raise Exception.Create(SysErrorMessage(GetLastError));
end;


  // The icon returned by the function must be
  // freed with the DestroyIcon API. This will be done automatically if you assign
  // the icon handle (HICON) to the Handle property of a TIcon object
  // (the icon will be released when this object gets freed or a new value is
  // assigned to it).

function GetAssociatedIcon(const AExtension: string; ASmall: boolean): HIcon;
var 
  Info: TSHFileInfo;
  Flags: cardinal; 
begin
  if ASmall then Flags := SHGFI_ICON or SHGFI_SMALLICON or SHGFI_USEFILEATTRIBUTES 
  else Flags           := SHGFI_ICON or SHGFI_LARGEICON or SHGFI_USEFILEATTRIBUTES; 

  SHGetFileInfo(PChar(AExtension), FILE_ATTRIBUTE_NORMAL, Info, SizeOf(TSHFileInfo), Flags); 
  Result := Info.hIcon; 
end; 


// GetAssociatedIcons

  // Procedure that gets the icon of a file whether it exists or not, and can also
  // get the small icon (ideal for a TListView that can be shown in vsIcon or
  // vsReport view styles). The procedure receives three parameters: the filename
  // and two pointers to HICON (integer) variables: one for the large icon (32x32)
  // and another one for the small icon (16x16). Any of them can be nil if you
  // don't need one of these icons. The icons "returned" by the procedure must be
  // freed with the DestroyIcon API. This will be done automatically if you assign
  // the icon handle (HICON) to the Handle property of a TIcon object
  // (the icon will be released when this object gets freed or a new value is
  // assigned to it).


procedure GetAssociatedIcons(FileName: TFileName; PLargeIcon, PSmallIcon: PHICON);
  // Gets the icons of a given file
var
  IconIndex: UINT;  // Position of the icon in the file
  FileExt, FileType: string;
  Reg: TRegistry;
  p: integer;
  p1, p2: PChar;
label
  noassoc;
begin
  IconIndex := 0;
  // Get the extension of the file
  FileExt := UpperCase(ExtractFileExt(FileName));
  if ((FileExt <> '.EXE') and (FileExt <> '.ICO')) or not FileExists(FileName) then begin
    // If the file is an EXE or ICO and it exists, then
    // we will extract the icon from this file. Otherwise
    // here we will try to find the associated icon in the
    // Windows Registry...
    Reg := nil;
    try
      Reg := TRegistry.Create(KEY_QUERY_VALUE);
      Reg.RootKey := HKEY_CLASSES_ROOT;
      if FileExt = '.EXE' then FileExt := '.COM';
      if Reg.OpenKeyReadOnly(FileExt) then try
          FileType := Reg.ReadString('');
        finally
          Reg.CloseKey;
        end;
      if (FileType <> '') and Reg.OpenKeyReadOnly(FileType + '\DefaultIcon') then try
          FileName := Reg.ReadString('');
        finally
          Reg.CloseKey;
        end;
    finally
      FreeAndNil(Reg);
    end;

    // If we couldn't find the association, we will
    // try to get the default icons
    if FileName = '' then goto noassoc;

    // Get the filename and icon index from the
    // association (of form '"filaname",index')
    p1 := PChar(FileName);
    p2 := StrRScan(p1, ',');
    if p2 <> nil then begin
      p := p2 - p1 + 1; // Position of the comma
      IconIndex := StrToInt(Copy(FileName, p + 1, Length(FileName) - p));
      Setlength(FileName, p - 1);
    end;
  end;
  // Attempt to get the icon
  if ExtractIconEx(PChar(FileName), IconIndex,
    PLargeIcon^, PSmallIcon^, 1) <> 1 then begin
    noassoc: // The operation failed or the file had no associated
             // icon. Try to get the default icons from SHELL32.DLL

    try // to get the location of SHELL32.DLL
      FileName := IncludeTrailingBackslash(GetSystemDir) + 'SHELL32.DLL';
    except
      FileName := 'C:\WINDOWS\SYSTEM\SHELL32.DLL';
    end;
    // Determine the default icon for the file extension
    if (FileExt = '.DOC') then IconIndex := 1
    else if (FileExt = '.DOCX') then IconIndex := 1
    else if (FileExt = '.EXE') or (FileExt = '.COM') then IconIndex := 2
    else if (FileExt = '.HLP') then IconIndex := 23
    else if (FileExt = '.INI') or (FileExt = '.INF') then IconIndex := 63
    else if (FileExt = '.TXT') then IconIndex := 64
    else if (FileExt = '.BAT') then IconIndex := 65
    else if (FileExt = '.DLL') or (FileExt = '.SYS') or (FileExt = '.VBX') or (FileExt = '.OCX') or (FileExt = '.VXD') then
      IconIndex := 66
    else if (FileExt = '.FON') then IconIndex := 67
    else if (FileExt = '.TTF') then IconIndex := 68
    else if (FileExt = '.FOT') then IconIndex := 69
    else IconIndex := 0;
    // Attempt to get the icon.
    if ExtractIconEx(PChar(FileName), IconIndex,
      PLargeIcon^, PSmallIcon^, 1) <> 1 then begin
      // Failed to get the icon. Just "return" zeroes.
      if PLargeIcon <> nil then PLargeIcon^ := 0;
      if PSmallIcon <> nil then PSmallIcon^ := 0;
    end;
  end;
end;


  //This example will change the icon of your form:
  //
  //procedure TForm1.Button1Click(Sender: TObject);
  //var
  //  SmallIcon: HICON;
  //begin
  //  GetAssociatedIcon('file.doc', nil, @SmallIcon);
  //  if SmallIcon <> 0 then
  //    Icon.Handle := SmallIcon;
  //end;

//------------------------------------------------------------------------------

// returns the windows tempry directory
function WinTempDir: string;
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

function WinSysDir: string;
var
  Buffer: array[0..MAX_PATH] of char;
begin
  GetSystemDirectory(Buffer, Length(Buffer));
  Result := StrPas(Buffer);
end;


function WinDir: string;
var
  Buffer: array[0..MAX_PATH] of char;
begin
  GetWindowsDirectory(Buffer, Length(Buffer));
  Result := StrPas(Buffer);
end;


  // Gets/creates application tempory directory
  // (sub dir of win temp dir with same name as app)
  // All files will be deleted from this directory when app closes
function GetAppTempDir: string;
begin
  if AppTempDir = '' then begin
    AppTempDir := WinTempDir;
    AppTempDir := AppTempDir + ChangeFileExt(ExtractFileName(Application.ExeName), '');
    if not DirectoryExists(AppTempDir) then CreateDir(AppTempDir);
  end;
  Result := AppTempDir;
end;

//Makes a string of aLength filled with random characters
function RandomStr(const aLength: longint): string;
var
  X: longint;
begin
  if aLength <= 0 then Exit;
  Setlength(Result, aLength);
  for X := 1 to aLength do Result[X] := Chr(Random(26) + 65);
end;


// All tempory files will be deleted when the appp closes
function GetTempFileName(const SuffixName: string = ''; const Extension: string = '.tmp';
  const CreateTheFile: boolean = false): string;
var
  f: file;
begin
  try
    Result := GetAppTempDir + '\Temp_' + RandomStr(6);
    if SuffixName <> '' then Result := Result + ' ' + SuffixName;
    Result := Result + Extension;
    while FileExists(Result) do begin
      Result := GetAppTempDir + '\Temp ' + RandomStr(6);
      if SuffixName <> '' then Result := Result + ' ' + SuffixName;
      Result := Result + Extension;
    end;
    if CreateTheFile then begin
      try Assign(f, Result) ;Except on E:Exception do begin (*MessageDlg(E.message, mtInformation , [mbOK], 0); *) end; end;
      try Rewrite(f)        ;Except on E:Exception do begin (*MessageDlg(E.message, mtInformation , [mbOK], 0); *) end; end;
      try CloseFile(f)      ;Except on E:Exception do begin (*MessageDlg(E.message, mtInformation , [mbOK], 0); *) end; end;
    end;
  Except
      on E:Exception do begin
        (*MessageDlg(E.message, mtInformation , [mbOK], 0); *)
      end;
  end;
end;

  // deletes all files from app temp dir
  // NOTE: this is called in Finalization section
procedure DeleteAllAppTemporyFiles;
var
  sr: TSearchRec;
  FileName: string;
begin
  // searh for normal files
  if FindFirst(GetAppTempDir + '\*.*', 0, sr) = 0 then begin
    repeat
      if not (((sr.Attr and faDirectory) <> 0) or
        ((sr.Attr and faReadOnly) <> 0)) then begin
        FileName := sr.Name;
        // try to delete (this will fail if another app has file open but will
        // be deleted next time app is closed) 
        DeleteFile(GetAppTempDir + '\' + FileName);
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

//function GetFileVersion(const FileName: string): string;
//var
//  VersionInfoSize, VersionInfoValueSize, Zero: DWord;
//  VersionInfo, VersionInfoValue: Pointer;
//begin
//  Result := '';
//  VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
//  if VersionInfoSize = 0 then Exit;
//  GetMem(VersionInfo, VersionInfoSize);
//  try
//    if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo,
//      '\', VersionInfoValue,
//      VersionInfoValueSize) and (0 <> longint(VersionInfoValueSize)) then begin
//      with TVSFixedFileInfo(VersionInfoValue^) do begin
//        Result := IntToStr(HiWord(dwFileVersionMS));
//        Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
//        Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
//        Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
//      end;
//    end;
//  finally
//    FreeMem(VersionInfo);
//  end;
//end;

function HasAttr(const FileName: string; Attr: Word): Boolean; 
begin
  Result := (FileGetAttr(FileName) and Attr) = Attr;
end;


function SetFileDate(Const FileName : String;Const FileDate : TDateTime): Boolean;
var
  FileHandle : THandle;
  FileSetDateResult : Integer;
begin
  result:= true;
  try
    FileHandle := FileOpen
       (FileName,
        fmOpenWrite OR fmShareDenyNone) ;
    try
      if FileHandle > 0 Then begin
        FileSetDateResult := FileSetDate(FileHandle,DateTimeToFileDate(FileDate)) ;
         result := (FileSetDateResult = 0) ;
       end;
     finally
       FileClose (FileHandle) ;
     end;
  except
    Result := False;
  end;
end;
function GetFileDate(FileName: string): TDateTime;
var
//  FileHandle : THandle;
  dt: TDateTime;
begin
  Result:= 0;
//  FileHandle := FileOpen(FileName,fmOpenWrite OR fmShareDenyNone) ;
//  try
//    if FileHandle > 0 Then
//      REsult := FileDateToDateTime(FileGetDate(FileHandle));
//  finally
//    FileClose (FileHandle) ;
//  end;
  {$WARNINGS OFF}
  if SysUtils.FileAge(FileName, dt, true) then
    result := dt;
  {$WARNINGS ON}
end;

function SpecialFolder(CSIDL: Integer): String;
{* Returns path of special folders *}
var
  ItemList: PItemIDList;
begin
  Setlength(Result, MAX_PATH);
  SHGetSpecialFolderLocation(0, CSIDL, ItemList);
  SHGetPathFromIDList(ItemList, @Result[1]);
  Result := PChar(Result);
  if result <> '' then result:= result + '\';
end;

function GetDesktopDir: string;
begin
  result := SpecialFolder(CSIDL_DESKTOP);
end;

//{$ifdef COMPILER_22_UP}
function GetLocalAppDataDir: string;
begin
  result := SpecialFolder(CSIDL_LOCAL_APPDATA);
end;

function GetRoamingAppDataDir: string;
begin
  result := SpecialFolder(CSIDL_APPDATA);
end;

//{$endif}

{ This function forces windows to remove current app from physical memory to
  swap file (like when an app is minimized), this will "defrag" memory
  and free up unused memory }
procedure TrimWorkingSet;
var
  MainHandle : THandle;
begin
 MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
 SetProcessWorkingSetSize(MainHandle,DWORD(-1),DWORD(-1));
 CloseHandle(MainHandle);
end;

{current memory size of the current process in bytes}
function CurrentMemoryUsage: Cardinal;
var
 pmc: TProcessMemoryCounters;
begin
 result:= 0;
 pmc.cb := SizeOf(pmc) ;
 if GetProcessMemoryInfo(GetCurrentProcess, @pmc, SizeOf(pmc)) then
   Result := pmc.WorkingSetSize
 else
   RaiseLastOSError;
end;

function TotalPhysicalMemoryBytes: Cardinal;
var
  MemoryStatus: TMemoryStatus;
begin
  MemoryStatus.dwLength := SizeOf(MemoryStatus) ;
  GlobalMemoryStatus(MemoryStatus) ;
  result := MemoryStatus.dwTotalPhys;
end;

function CopyDir(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_COPY;
    fFlags := FOF_NO_UI; //FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;


function MoveDir(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_MOVE;
    fFlags := FOF_NO_UI; //FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;

function DelDir(dir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom  := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
end;

function GetMyDocumentsDir: string;
begin
  result := SpecialFolder(CSIDL_PERSONAL);
end;
function GetAllUserDocumentsDir: string;
begin
  result := SpecialFolder(CSIDL_COMMON_DOCUMENTS);
end;
function ProcessExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;
function OutGoingFileName(dbname, Prefix,Suffix , extension :String):String;
begin
    result := GetValidfileName(Prefix +dbname+ Suffix + '.' + StringReplace(extension , '.' , '',[rfReplaceAll,rfIgnoreCase]));
end;

function GetValidfileName(filename:String):String;
begin
  result :=filename;
  result := StringReplace(result , '"' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , '*' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , '/' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , ':' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , '<' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , '>' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , '?' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , '\' , '',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result , '|' , '',[rfReplaceAll,rfIgnoreCase]);
end;
function BooleanToStr(const Value:Boolean):String;
begin
  if Value then Result := 'T' else Result := 'F';
end;
function BooleanToString(const Value:Boolean):String;
begin
  if Value then result := 'True' else result := 'False';
end;
function CharCounter(const char, TestString: string): integer;
var
  TempStr: string;
  s, Count, I: integer;
begin
  TempStr := TestString;
  Count := 1;

  for I := 1 to Length(TestString) do begin
    s := Pos(char, TempStr);
    if s > 0 then begin
      Delete(TempStr, s, length(char));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;
function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
var
  s: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := Source + Delim;
  s := 1;
  for L9 := 1 to PosCount - 1 do begin
    s := Pos(Delim, Src);
    if s > 0 then Delete(Src, s, length(Delim))
    else Break;
  end;

  Result := '';
  if s > 0 then begin
    E := Pos(Delim, Src + Delim);
    Result := Copy(Src, s, E - s);
  end;
end;
Function Searchfile(Const PathnfileToSerach:String; Resulttype:String):String;
var
  Rec:TSearchRec;
  st:TStringlist;
begin
  st:= TStringlist.create;
  try
    st.Sorted:= True;
    if FindFirst (exedir + PathnfileToSerach, faAnyFile - faDirectory, Rec) = 0 then begin
      try
      repeat
        st.Add(Rec.Name) ;
      until FindNext(Rec) <> 0;
      finally
        FindClose(Rec) ;
      end;
    end;
  finally
         if st.count =0 then Result := ''
    else if Sametext(Resulttype, 'all' ) then result := St.Text
    else if sametext(Resulttype , 'First') then Result := st[0]
    else Result := st[st.count-1];

    Freeandnil(st);
  end;
end;

function ExeDir: string;
begin
  Result := ExtractFilePath(Application.ExeName);
end;
function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
var
  InfoSet: TEsMachineInfoSet;
  MachineID: longint;
begin
  InfoSet := [];
  if User then InfoSet := InfoSet + [midUser];
  if System then InfoSet := InfoSet + [midSystem];
  if Network then InfoSet := InfoSet + [midNetwork];
  if Drives then InfoSet := InfoSet + [midDrives];

  MachineID := CreateMachineID(InfoSet);
  Result := BufferToHex(MachineID, SizeOf(MachineID));
end;

function GetCurrentWindowsUserName: string;
const
  cnMaxUserNameLen = 254;
var
  sUserName: string;
  dwUserNameLen: DWORD;
begin
  dwUserNameLen := cnMaxUserNameLen - 1;
  SetLength(sUserName, cnMaxUserNameLen);
  GetUserName(PChar(sUserName), dwUserNameLen);
  SetLength(sUserName, dwUserNameLen);
  Result := sUserName;
end;

function VerifyVersionInfo(var LPOSVERSIONINFOEX : OSVERSIONINFOEX;dwTypeMask: DWORD;dwlConditionMask: int64): BOOL; stdcall; external kernel32 name 'VerifyVersionInfoW';
function VerSetConditionMask(dwlConditionMask: int64;dwTypeBitMask: DWORD; dwConditionMask: Byte): int64; stdcall; external kernel32;

function IsWinServer : Boolean;
const
   VER_NT_SERVER      = $0000003;
   VER_EQUAL          = 1;
   VER_GREATER_EQUAL  = 3;
var
   osvi             : OSVERSIONINFOEX;
   dwlConditionMask : DWORDLONG;
   op               : Integer;
begin
   dwlConditionMask := 0;
   op:=VER_GREATER_EQUAL;

   ZeroMemory(@osvi, sizeof(OSVERSIONINFOEX));
   osvi.dwOSVersionInfoSize := sizeof(OSVERSIONINFOEX);
   osvi.dwMajorVersion := 5;
   osvi.dwMinorVersion := 0;
   osvi.wServicePackMajor := 0;
   osvi.wServicePackMinor := 0;
   osvi.wProductType := VER_NT_SERVER;

   dwlConditionMask:=VerSetConditionMask( dwlConditionMask, VER_MAJORVERSION, op );
   dwlConditionMask:=VerSetConditionMask( dwlConditionMask, VER_MINORVERSION, op );
   dwlConditionMask:=VerSetConditionMask( dwlConditionMask, VER_SERVICEPACKMAJOR, op );
   dwlConditionMask:=VerSetConditionMask( dwlConditionMask, VER_SERVICEPACKMINOR, op );
   dwlConditionMask:=VerSetConditionMask( dwlConditionMask, VER_PRODUCT_TYPE, VER_EQUAL );

   Result:=VerifyVersionInfo(osvi,VER_MAJORVERSION OR VER_MINORVERSION OR
      VER_SERVICEPACKMAJOR OR VER_SERVICEPACKMINOR OR VER_PRODUCT_TYPE, dwlConditionMask);
end;


(*
const
  LOCALE_NAME_MAX_LENGTH = 85;

function LCIDToLocaleName(Locale: LCID; lpName: LPWSTR; cchName: Integer;
  dwFlags: DWORD): Integer; stdcall;external kernel32 name 'LCIDToLocaleName';

function GetLCIDString: string;
var
   strNameBuffer : array [0..LOCALE_NAME_MAX_LENGTH-1] of WideChar;
begin
  if (LCIDToLocaleName(1033, strNameBuffer, LOCALE_NAME_MAX_LENGTH, 0) = 0) then
    RaiseLastOSError
  else
    Writeln(strNameBuffer);

  if (LCIDToLocaleName(1041, strNameBuffer, LOCALE_NAME_MAX_LENGTH, 0) = 0) then
    RaiseLastOSError
  else
    result := strNameBuffer;

end;
*)

function IsFileInUse(fName : string) : boolean;
var
  HFileRes : HFILE;
  Res: string[6];

  function CheckAttributes(FileNam: string; CheckAttr: string): Boolean;
  var
    fa: Integer;
  begin
    fa := GetFileAttributes(PChar(FileNam)) ;
    Res := '';
    if (fa and FILE_ATTRIBUTE_NORMAL) <> 0 then begin
      Result := False;
      Exit;
    end;
    if (fa and FILE_ATTRIBUTE_ARCHIVE) <> 0 then Res := Res + 'A';
    if (fa and FILE_ATTRIBUTE_COMPRESSED) <> 0 then Res := Res + 'C';
    if (fa and FILE_ATTRIBUTE_DIRECTORY) <> 0 then Res := Res + 'D';
    if (fa and FILE_ATTRIBUTE_HIDDEN) <> 0 then Res := Res + 'H';
    if (fa and FILE_ATTRIBUTE_READONLY) <> 0 then Res := Res + 'R';
    if (fa and FILE_ATTRIBUTE_SYSTEM) <> 0 then Res := Res + 'S';
    Result := AnsiContainsText(String(Res), CheckAttr) ;
  end; (*CheckAttributes*)

  procedure SetAttr(fName: string);
  var
    Attr: Integer;
  begin
    Attr := 0;
    if AnsiContainsText(String(Res), 'A') then Attr := Attr + FILE_ATTRIBUTE_ARCHIVE;
    if AnsiContainsText(String(Res), 'C') then Attr := Attr + FILE_ATTRIBUTE_COMPRESSED;
    if AnsiContainsText(String(Res), 'D') then Attr := Attr + FILE_ATTRIBUTE_DIRECTORY;
    if AnsiContainsText(String(Res), 'H') then Attr := Attr + FILE_ATTRIBUTE_HIDDEN;
    if AnsiContainsText(String(Res), 'S') then Attr := Attr + FILE_ATTRIBUTE_SYSTEM;
    SetFileAttributes(PChar(fName), Attr) ;
  end; (*SetAttr*)

begin //IsFileInUse
//  if CheckAttributes(fName, 'R') then begin
//    Result := False;
//    if not FileExists(fName) then exit;
//    if MessageDlg(ExtractFileName(fName) + ' is a READ-ONLY file.' + #13#10 + 'Do you wish to clear the READ-ONLY flag???', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
//      Result := True;
//      Exit;
//    end;
//  end;
  SetFileAttributes(PChar(fName), FILE_ATTRIBUTE_NORMAL);
  SetAttr(fName) ;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0) ;
  Result := (HFileRes = INVALID_HANDLE_VALUE) ;
  if not Result then CloseHandle(HFileRes) ;
end; //IsFileInUse

function FileCanBeOpendForReading(const aFileName: string): boolean;
var
  handle: integer;
begin
  result := false;
  handle := FileOpen(aFileName,fmOpenRead or fmShareDenyNone);
  if handle >= 0 then begin
    result := true;
    FileClose(handle);
  end;
end;

function Is64BitWindows: boolean;
type
  TIsWow64Process = function(hProcess: THandle; var Wow64Process: BOOL): BOOL;
    stdcall;
var
  DLLHandle: THandle;
  pIsWow64Process: TIsWow64Process;
  IsWow64: BOOL;
  WasCalled: BOOL;
begin
  IsWow64 := False;
  WasCalled := False;
  if not WasCalled then begin
    DllHandle := LoadLibrary('kernel32.dll');
    if DLLHandle <> 0 then begin
      pIsWow64Process := GetProcAddress(DLLHandle, 'IsWow64Process');
      if Assigned(pIsWow64Process) then
        pIsWow64Process(GetCurrentProcess, IsWow64);
//      WasCalled := True;
      FreeLibrary(DLLHandle);
    end;
  end;
  Result := IsWow64;
end;

function ChangeFileNameIfExists(aFileName: string): string;
var
  x: integer;
begin
  result := aFileName;
  x := 0;
  while FileExists(result) do begin
    Inc(x);
    result := ChangeFileExt(aFileName, '_' + IntToStr(x) + ExtractFileExt(aFileName));
  end;
end;

Function Roundfix(Fieldname:String):String;
begin
  REsult := Fieldname + '+  IF(' + FieldName +' > 0,0.00001, IF(' + FieldName +' < 0, -0.00001,0))';
end;

function IsConsoleApp: boolean;
var
  Stdout: THandle;
begin
  Stdout := GetStdHandle(Std_Output_Handle);
  {$Warnings Off}
  Win32Check(Stdout <> Invalid_Handle_Value);
  {$Warnings On}
  Result := Stdout <> 0;
end;
Function ERPListMaxDatetime:TdateTime;
begin
   result := incday(MaxDateTime, -1);
end;

Function ERPListMinDatetime:TdateTime;
begin
   result := 0;
end;

initialization

finalization
  DeleteAllAppTemporyFiles;
end.
