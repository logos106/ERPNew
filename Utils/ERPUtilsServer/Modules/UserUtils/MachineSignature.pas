unit MachineSignature;

interface

uses
  JsonObject;

(*
    {
        "computername":"IANBLAKELEYPC",
        "memory": {
                "totalphysicalbytes":1071161344
        },
        "system": {
                "processorarchitecture":0,
                "pagesize":4096,
                "minimumapplicationaddress":"00010000",
                "maximumapplicationaddress":"7FFEFFFF",
                "numberofprocessors":2,
                "processortype":586,
                "allocationgranularity":65536,
                "processorrevision":3842,
                "processorlevel":6
        },
        "network": {
                "macaddress":"08-00-27-00-78-CF"
        },
        "storage": {
                "C": {
                        "storagetype":3,
                        "storagetypedescription":"Fixed Disk",
                        "volumename":"",
                        "filesystem":"NTFS",
                        "volumeserialnumber":-197816753,
                        "size":825253888
                },
                "D": {
                        "storagetype":5,
                        "storagetypedescription":"CD-ROM Drive",
                        "volumename":"",
                        "filesystem":"",
                        "volumeserialnumber":-197816753,
                        "size":0
                }
        },
        "bios": {
                "date":"2007-03-29"
        }
    }
*)
  function GetMachineSignature: TJsonObject;
  function GetPCName: string;
  function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
  function GetMACAddress: string;
  function GetAllMACAddresses: string;

implementation

uses
  sysutils,
  windows,  // TMemoryStatus, TSystemInfo
  nb30,     // TLanaEnum;
  OnGuard, Ogutil,
  registry;

type
  TDrvType = (dtNotDetermined, dtNonExistent, dtRemoveable, dtFixed,
              dtRemote, dtCDROM, dtRamDrive);



function GetAdapterInfo(Lana: AnsiChar): String;
var
  Adapter: TAdapterStatus;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBRESET);
  NCB.ncb_lana_num := Lana;
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac not found';
    Exit;
  end;

  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBASTAT);
  NCB.ncb_lana_num := Lana;
  NCB.ncb_callname := '*';

  FillChar(Adapter, SizeOf(Adapter), 0);
  NCB.ncb_buffer := @Adapter;
  NCB.ncb_length := SizeOf(Adapter);
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac not found';
    Exit;
  end;
  Result :=
  IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' +
  IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;

function GetMACAddress: string;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBENUM);
  NCB.ncb_buffer := @AdapterList;
  NCB.ncb_length := SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length) > 0 then
    Result := GetAdapterInfo(AdapterList.lana[0])
  else
  Result := 'mac not found';
end;

function GetAllMACAddresses: string;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
  I: integer;
begin
  result := '';
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBENUM);
  NCB.ncb_buffer := @AdapterList;
  NCB.ncb_length := SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length) > 0 then begin
    for I := 0 to Byte(AdapterList.length) -1 do begin
      if I > 0 then result := result + ',';
      result := result + GetAdapterInfo(AdapterList.lana[I]);
    end;
  end
  else
    Result := 'mac not found';
end;

function RegOpenKeyReadOnly(const Reg: TRegistry; const Key: string): Boolean;
  {uses registry object to open given key for reading only and returns whether
  successfully opened. On versions of Delphi that can't open keys as read only
  the key is opened normally}
begin
  {$IFDEF REGISTRYEX}
  Result := Reg.OpenKeyReadOnly(Key);
  {$ELSE}
  Result := Reg.OpenKey(Key, False);
  {$ENDIF}
end;

function GetRegistryString(const RootKey: HKEY;
  const SubKey, Name: string): string;
  {Gets a string value from the registry from the given root and sub key.
  Converts integers to strings and raises exception for binary and unknown
  value types. Returns '' if the sub key or value name are not known.}
var
  Reg: TRegistry;          // registry access object
  ValueInfo: TRegDataInfo; // info about registry value
begin
  Result := '';
  // Open registry at required root key
  Reg := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  try
    Reg.RootKey := RootKey;
    // Open registry key and check value exists
    if RegOpenKeyReadOnly(Reg, SubKey)
      and Reg.ValueExists(Name) then
    begin
      // Check if registry value is string or integer
      Reg.GetDataInfo(Name, ValueInfo);
      case ValueInfo.RegData of
        rdString, rdExpandString:
          // string value: just return it
          Result := Reg.ReadString(Name);
        rdInteger:
          // integer value: convert to string
          Result := IntToStr(Reg.ReadInteger(Name));
        else
          // unsupported value: raise exception
          raise Exception.Create('Bad Reg Type');
      end;
    end;
  finally
    // Close registry
    Reg.CloseKey;
    FreeAndNil(Reg);
  end;
end;


// Reference: How to Obtain BIOS Information from the Registry
// http://support.microsoft.com/default.aspx?scid=kb;en-us;q195268

{ TODO : the date string can be e.g. 00/00/00 }
function GetBIOSDate: TDateTime;
const
  WinNT_REG_PATH = 'HARDWARE\DESCRIPTION\System';
  WinNT_REG_KEY  = 'SystemBiosDate';
  Win9x_REG_PATH = 'Enum\Root\*PNP0C01\0000';
  Win9x_REG_KEY  = 'BiosDate';
var
  ISWinNT: boolean;
  RegStr: string;
  {$IFDEF RTL150_UP}
  FormatSettings: TFormatSettings;
  {$ELSE ~RTL150_UP}
  RegFormat: string;
  RegSeparator: Char;
  {$ENDIF ~RTL150_UP}
begin
  IsWinNT := Win32Platform = VER_PLATFORM_WIN32_NT;

  if IsWinNT then
    RegStr := GetRegistryString(HKEY_LOCAL_MACHINE, WinNT_REG_PATH, WinNT_REG_KEY)
  else
    RegStr := GetRegistryString(HKEY_LOCAL_MACHINE, Win9x_REG_PATH, Win9x_REG_KEY);
  {$IFDEF RTL150_UP}
  FillChar(FormatSettings, SizeOf(FormatSettings), 0);
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'm/d/y';
  if not TryStrToDate(RegStr, Result, FormatSettings) then
  begin
    FormatSettings.ShortDateFormat := 'y/m/d';
    if not TryStrToDate(RegStr, Result, FormatSettings) then
      Result := 0;
  end;
  {$ELSE ~RTL150_UP}
  Result := 0;
  { TODO : change to a threadsafe solution }
  RegFormat := FormatSettings.ShortDateFormat;
  RegSeparator := FormatSettings.DateSeparator;
  try
    FormatSettings.DateSeparator := '/';
    try
      FormatSettings.ShortDateFormat := 'm/d/y';
      Result := StrToDate(RegStr);
    except
      try
        FormatSettings.ShortDateFormat := 'y/m/d';
        Result := StrToDate(RegStr);
      except
      end;
    end;
  finally
    FormatSettings.ShortDateFormat := RegFormat;
    FormatSettings.DateSeparator := RegSeparator;
  end;
  {$ENDIF ~RTL150_UP}
end;

function GetPCName: string;
var
   pcName : pchar;   // Holds the computer name
   dwSize : dword;   // Size of the buffer holding the name
begin
  result:= '';
  dwSize := MAX_COMPUTERNAME_LENGTH + 1;
  pcName := strAlloc( dwSize );
  try

    if not getComputerName( pcName, dwSize ) then
      //
    else
      result:= pcName;
 finally
   strDispose( pcName );
 end;

end;



function GetMachineSignature: TJsonObject;
var
  MemoryStatus: TMemoryStatus;
  SysInfo: TSystemInfo;
  Drive: Char;
  drv: String;
  pVolName: PChar;
  pFSBuf: PChar;
  nVNameSer: PDWORD;
  FSSysFlags, maxCmpLen: DWord;
  dType: TDrvType;
  s: string;
  SectPerCls,
  BytesPerCls,
  FreeCls,
  TotCls      : DWord;
begin
  result:= JO;

  { general }
  result.S['computername']:= GetPCName;

  { memory }
  MemoryStatus.dwLength := SizeOf(MemoryStatus) ;
  GlobalMemoryStatus(MemoryStatus) ;
  // dwLength         Size of MemoryStatus record
  // dwMemoryLoad     % memory in use
  // dwTotalPhys      Total Physical Memory in bytes
  // dwAvailPhys      Available Physical Memory in bytes
  // dwTotalPageFile  Total Bytes of Paging File
  // dwAvailPageFile  Available bytes in paging file
  // dwTotalVirtual   User Bytes of Address space
  // dwAvailVirtual   Available User bytes of address space
  result.O['memory'].I['totalphysicalbytes']:= MemoryStatus.dwTotalPhys;
//  result.O['memory'].I['percentinuse']:= MemoryStatus.dwMemoryLoad;
//  result.O['memory'].I['availablephysicalbytes']:= MemoryStatus.dwAvailPhys;
  //result.O['memory'].I['totalpagefilebytes']:= MemoryStatus.dwTotalPageFile;
  //result.O['memory'].I['availablepagefilebytes']:= MemoryStatus.dwAvailPageFile;

  { system info }
  GetSystemInfo(SysInfo);
  result.O['system'].I['processorarchitecture']:= SysInfo.wProcessorArchitecture;
  result.O['system'].I['pagesize']:= SysInfo.dwPageSize;
  result.O['system'].S['minimumapplicationaddress']:=
    Format('%p', [SysInfo.lpMinimumApplicationAddress]);
  result.O['system'].S['maximumapplicationaddress']:=
    Format('%p', [SysInfo.lpMaximumApplicationAddress]);
  result.O['system'].I['numberofprocessors']:= SysInfo.dwNumberOfProcessors;
  result.O['system'].I['processortype']:= SysInfo.dwProcessorType;
  result.O['system'].I['allocationgranularity']:= SysInfo.dwAllocationGranularity;
  result.O['system'].I['processorrevision']:= SysInfo.wProcessorRevision;
  result.O['system'].I['processorlevel']:= SysInfo.wProcessorLevel;

  { network }
  result.O['network'].S['macaddress']:= GetAllMACAddresses;

  { storage }
  GetMem(pVolName, MAX_PATH);
  GetMem(pFSBuf, MAX_PATH);
  GetMem(nVNameSer, MAX_PATH);
  try
    for Drive := 'C' to 'Z' do begin
      drv := Drive + ':\';


      //Now, get the volume information
      GetVolumeInformation(PChar(drv), pVolName, MAX_PATH, nVNameSer,
                           maxCmpLen, FSSysFlags, pFSBuf, MAX_PATH);

      dType := TDrvType(GetDriveType(PChar(drv)));
      if not (dType in [dtFixed, dtCDROM]) then
        continue;


      { Get descriptions for File System Flags }
  //    for I := 0 to 5 do begin
  //      //do an AND bitwise operation to see if I is in the mask
  //      if ((FSSysFlags AND I) <> 0) then
  //        case I of
  //          Ord(fsCaseIsPreserved)     :
  //            memLog.Lines.Add('... preserves case with file names');
  //          Ord(fsCaseSensitive)       :
  //            memLog.Lines.Add('... supports case sensitive file names');
  //          Ord(fsUnicodeStoredOnDisk) :
  //            memLog.Lines.Add('... stores Unicodes as on disk');
  //          Ord(fsPersistentAcls)      :
  //            memLog.Lines.Add('... preserves and enforces ACLs');
  //          Ord(fsFileCompression)     :
  //            memLog.Lines.Add('... supports file-based compression');
  //          Ord(fsVolIsCompressed)  :
  //            memLog.Lines.Add('... resides on a compressed volume');
  //        end;
  //    end;

      { determine if system supports long file names }
  //    if (maxCmpLen > 8.3) then
  //      memLog.Lines.Add('...supports long file names');

      { Get the Drive Type information }
      case dType of
        dtNotDetermined : s:= 'Unable to Determine';
        dtNonExistent   : s:= 'Does not exist';
        dtRemoveable    : s:= 'Removable Drive (Floppy)';
        dtFixed         : s:= 'Fixed Disk';
        dtRemote        : s:= 'Remote or Network Drive';
        dtCDROM         : s:= 'CD-ROM Drive';
        dtRamDrive      : s:= 'RAM Drive';
      end;
//      result.O['storage'].O[Drive].I['storagetype']:= Ord(dType);
      result.O['storage'].O[Drive].S['storagetypedescription']:= s;

      if dType in [dtRemoveable,dtFixed,dtRemote] then begin
        result.O['storage'].O[Drive].S['volumename']:= StrPas(pVolName);
        result.O['storage'].O[Drive].S['filesystem']:= StrPas(pFSBuf);

      end
      else begin
        result.O['storage'].O[Drive].S['volumename']:= '';
        result.O['storage'].O[Drive].S['filesystem']:= '';
      end;
      result.O['storage'].O[Drive].I['volumeserialnumber']:= nVNameSer^;
      { Get the total and free space on selected drive }
      GetDiskFreeSpace(PChar(drv), SectPerCls, BytesPerCls, FreeCls, TotCls);
      result.O['storage'].O[Drive].F['size']:=
        SectPerCls * BytesPerCls * TotCls;
//      result.O['storage'].O[Drive].F['freespace']:=
//        SectPerCls * BytesPerCls * FreeCls;

    end;
  finally
    //Get rid of pointer resources
    FreeMem(pVolName, MAX_PATH);
    FreeMem(pFSBuf, MAX_PATH);
    FreeMem(nVNameSer, MAX_PATH);
  end;

  { BIOS }
  result.O['bios'].S['date']:= '';
  result.O['bios'].ItemByName['date'].Value.AsDateTime:= GetBIOSDate;

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


end.
