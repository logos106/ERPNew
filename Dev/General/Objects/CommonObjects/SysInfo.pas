unit SysInfo;


// Conditional defines

// Assume all required facilities available
{$DEFINE REGISTRYEX}  // extra TRegistry methods available
{$DEFINE WARNDIRS}    // $WARN compiler directives available
{$DEFINE DEPRECATED}  // deprecated directive available

// Undefine facilities not available in earlier compilers
// Note: Delphi 1/2 not included since code will not compile on these compilers
{$IFDEF VER100} // Delphi 3
  {$UNDEF REGISTRYEX}
  {$UNDEF WARNDIRS}
  {$UNDEF DEPRECATED}
{$ENDIF}
{$IFDEF VER120} // Delphi 4
  {$UNDEF WARNDIRS}
  {$UNDEF DEPRECATED}
{$ENDIF}
{$IFDEF VER130} // Delphi 5
  {$UNDEF WARNDIRS}
  {$UNDEF DEPRECATED}
{$ENDIF}
{$IFDEF VER140} // Delphi 6
  {$UNDEF WARNDIRS}
{$ENDIF}


interface


uses
  // Delphi
  SysUtils, Classes, Windows;


// -----------------------------------------------------------------------------
// Windows types and constants not available in Delphi
// -----------------------------------------------------------------------------

type
  {
  TOSVersionInfoEx:
    Win API OSVERSIONINFOEX type
  }
  TOSVersionInfoEx = packed record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of AnsiChar;
    wServicePackMajor: WORD;
    wServicePackMinor: WORD;
    wSuiteMask: WORD;
    wProductType: Byte;
    wReserved: Byte;
  end;

const
  // These Windows-defined constants are required for use with TOSVersionInfoex
  // NT Product types
  VER_NT_WORKSTATION = $0000001;
  VER_NT_DOMAIN_CONTROLLER = $0000002;
  VER_NT_SERVER = $0000003;
  // Mask representing NT product suites
  VER_SUITE_SMALLBUSINESS = $00000001;
  VER_SUITE_ENTERPRISE = $00000002;
  VER_SUITE_BACKOFFICE = $00000004;
  VER_SUITE_COMMUNICATIONS = $00000008;
  VER_SUITE_TERMINAL = $00000010;
  VER_SUITE_SMALLBUSINESS_RESTRICTED = $00000020;
  VER_SUITE_EMBEDDEDNT = $00000040;
  VER_SUITE_DATACENTER = $00000080;
  VER_SUITE_SINGLEUSERTS = $00000100;
  VER_SUITE_PERSONAL = $00000200;
  VER_SUITE_SERVERAPPLIANCE = $00000400;
  VER_SUITE_BLADE = VER_SUITE_SERVERAPPLIANCE;

  //
  // These constants are required for GetSystemMetrics on XP machines
  // GetSystemMetrics returns non-zero when passed these flags if the
  // associated edition is present.
  //
  SM_MEDIACENTER = 87;  // Detects XP Media Center Edition
  SM_TABLETPC = 86;     // Detects XP Tablet Edition


type

  {
  TPJOSPlatform:
    Enumerated type for OS platforms
  }
  TPJOSPlatform = (
    ospWinNT,               // Windows NT platform
    ospWin9x,               // Windows 9x platform
    ospWin32s               // Win32s platform
  );

  {
  TPJOSProduct:
    Enumerated type indentifying OS product
  }
  TPJOSProduct = (
    osUnknownWinNT,         // Unknown Windows NT OS
    osWinNT,                // Windows NT (up to v4)
    osWin2K,                // Windows 2000
    osWinXP,                // Windows XP
    osUnknownWin9x,         // Unknown Windows 9x OS
    osWin95,                // Windows 95
    osWin98,                // Windows 98
    osWinMe,                // Windows Me
    osUnknownWin32s,        // Unknown OS running Win32s
    osWinSvr2003,           // Windows Server 2003
    osUnknown,              // Completely unknown Windows
    osWinVista              // Windows Vista
  );

  {
  EPJSysInfo:
    Exceptions raised by code in this unit
  }
  EPJSysInfo = class(Exception);

  {
  TPJOSInfo:
    Static class that provides operating system version information.
  }
  TPJOSInfo = class(TObject)
  private
    class function CheckSuite(const Suite: Integer): Boolean;
      {Checks if a given suite is installed on an NT system. Pass one of the
      VER_SUITE_* flags to the function as the suite to test for. Always returns
      False on non-NT systems}
    class function EditionFromReg: string;
      {Gets name of edition from registry: needed to get edition for NT4 pre
      SP6}
    class function IsNT4SP6a: Boolean;
      {Checks registry to see if NT4 Service Pack 6a is installed}
    class function ProductTypeFromReg: string;
      {Gets code describing product type from registry: used to get product
      type for NT4 SP5 and earlier}
  public
    class function IsWin9x: Boolean;
      {Returns true if a Windows 9x operating system is installed (i.e. Windows
      95, Windows 98 or Windows Me)}
    class function IsWinNT: Boolean;
      {Returns true if an NT operating system is installed (including Windows
      2000, Windows XP and Windows 2003 Server)}
    class function IsWin32s: Boolean;
      {Returns true if running on Win32s. This is unlikely to ever return true
      since Delphi is not believed to run on Win32s itself}
    class function IsWow64: Boolean;
      {Returns true if application is running under WOW64 on a 64 bit operating
      system}
    class function IsServer: Boolean;
      {Returns true if operating system is a server}
    class function Platform: TPJOSPlatform;
      {Returns value indentifying OS platform}
    class function Product: TPJOSProduct;
      {Returns value identifying product}
    class function ProductName: string;
      {Returns name of product}
    class function MajorVersion: Integer;
      {Returns operating system's major version number}
    class function MinorVersion: Integer;
      {Returns operating system's minor version number}
    class function BuildNumber: Integer;
      {Returns operating system's build number}
    class function ServicePack: string;
      {Returns name of any service pack installed}
    class function ServicePackMajor: Integer;
      {Returns major version number of any installed NT service pack or 0 if no
      service pack is installed or if the system is running Windows 9x}
    class function ServicePackMinor: Integer;
      {Returns minor version number of any installed NT service pack. Valid only
      when ServicePackMajor is non-zero}
    class function Edition: string;
      {Returns the product edition for an NT operating system or '' for a non-NT
      operating system}
    class function Description: string;
      {Returns full description of operating system}
    class function ProductID: string;
      {Returns the Windows product ID}
  end;

  {
  TPJComputerInfo:
    Static class that provides information about the computer.
  }
  TPJComputerInfo = class(TObject)
  public
    class function ComputerName: string;
      {Returns name of computer}
    class function UserName: string;
      {Returns name of currently logged on user}
  end;

  {
  TPJSystemFolders:
    Static class that provides paths of the system's standard folders.
  }
  TPJSystemFolders = class(TObject)
  {Returns fully qualified name of Windows folder}
  public
    class function CommonFiles: string;
      {Returns fully qualified name of Common Files folder}
    class function ProgramFiles: string;
      {Returns fully qualified name of Program Files folder}
    class function Windows: string;
      {Returns fully qualified name of Windows folder}
    class function System: string;
      {Returns fully qualified name of Windows system folder}
    class function Temp: string;
      {Returns fully qualified name of system's temporary folder}
  end;

  {
  TPJSysInfo:
    Component that provides system information.
  }
  TPJSysInfo = class(TComponent)
  private // properties
    function GetComputerName: string;
    function GetUserName: string;
    function GetCommonFilesFolder: string;
    function GetProgramFilesFolder: string;
    function GetSystemFolder: string;
    function GetTempFolder: string;
    function GetWindowsFolder: string;
    function GetOSDesc: string;
    function GetOSBuildNumber: Integer;
    function GetOSMajorVersion: Integer;
    function GetOSMinorVersion: Integer;
    function GetOSPlatform: TPJOSPlatform;
    function GetOSProduct: TPJOSProduct;
    function GetOSProductName: string;
    function GetOSProductType: string;
    function GetOSServicePack: string;
  public
    constructor Create(AOwner: TComponent); override;
      {Class constructor: ensures only one instance of component can be placed
      on a form}

    property ComputerName: string read GetComputerName;
      {Name of computer}
    property UserName: string read GetUserName;
      {Name of currently logged on user}

    property CommonFilesFolder: string read GetCommonFilesFolder;
      {Fully qualified name of common files folder}
    property ProgramFilesFolder: string read GetProgramFilesFolder;
      {Fully qualified name of program files folder}
    property SystemFolder: string read GetSystemFolder;
      {Fully qualified name of Windows system folder}
    property TempFolder: string read GetTempFolder;
      {Fully qualified name of current temporary folder}
    property WindowsFolder: string read GetWindowsFolder;
      {Fully qualified name of Windows folder}

    property OSBuildNumber: Integer read GetOSBuildNumber;
      {Operating system build number}
    property OSDesc: string read GetOSDesc;
      {Full description of operating system: included product name, suite and
      build numbers as applicable}
    property OSMajorVersion: Integer read GetOSMajorVersion;
      {Major version number of operating system}
    property OSMinorVersion: Integer read GetOSMinorVersion;
      {Minor version number of operating system}
    property OSPlatform: TPJOSPlatform read GetOSPlatform;
      {Operating system platform identifier}
    property OSProduct: TPJOSProduct read GetOSProduct;
      {Operating system product identifier}
    property OSProductName: string read GetOSProductName;
      {Name of operating system}
    property OSProductType: string read GetOSProductType;
      {Type of operating system - for NT. Always empty string for Win9x}
    property OSServicePack: string read GetOSServicePack;
      {Name of any service pack for NT or additional product info for Win9x}
  end {$IFDEF DEPRECATED}deprecated{$ENDIF};


function SIGetComputerName: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns name of computer}
function SIGetUserName: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns name of currently logged on user}

function SIGetCommonFilesFolder: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns fully qualified name of Common Files folder}
function SIGetProgramFilesFolder: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns fully qualified name of Program Files folder}
function SIGetSystemFolder: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns fully qualified name of Windows system folder}
function SIGetTempFolder: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns fully qualified name of current temporary folder}
function SIGetWindowsFolder: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns fully qualified name of Windows folder}

function SIGetOSBuildNumber: Integer;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns build number of operating system}
function SIGetOSDesc: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns Full description of operating system: included product name, suite
  and build numbers as applicable}
function SIGetOSMajorVersion: Integer;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns major version of OS}
function SIGetOSMinorVersion: Integer;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns minor version of OS}
function SIGetOSPlatform: TPJOSPlatform;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns code identifying OS platform program is running on}
function SIGetOSProduct: TPJOSProduct;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns code identifying OS product program is running on}
function SIGetOSProductName: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns product name of operating system}
function SIGetOSProductType: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns type of product for Win NT and empty string for other OSs}
function SIGetOSServicePack: string;
  {$IFDEF DEPRECATED}deprecated;{$ENDIF}
  {Returns service pack info for NT and additional release info for Win9x}


var
  //
  // Global variables providing extended information about the OS version
  //
  Win32HaveExInfo: Boolean = False;
    {True if extended version info available (NT4, SP6 and later)}
  // Following variables only valid if Win32HaveExInfo is True
  Win32ServicePackMajor: Integer = 0;
    {Major version number of the latest Service Pack installed on the system. If
    no service pack has been installed the value is 0}
  Win32ServicePackMinor: Integer = 0;
    {Minor version number of the latest Service Pack installed on the system}
  Win32SuiteMask: Integer = 0;
    {Bit flags that identify the product suites available on the system. Value
    is a combination of the VER_SUITE_* flags defined above}
  Win32ProductType: Integer = 0;
    {Additional information about the system. Value is one of the VER_NT_* flags
    defined above}


implementation


uses
  // Delphi
  Registry;

resourcestring
  // Error messages
  sUnknownPlatform = 'Unrecognized operating system platform';
  sUnknownProduct = 'Unrecognised operating system product';
  sDupInstErr = 'Only one %0:s component is permitted on a form: '
    + '%1:s is already present on %2:s';
  sBadRegType =  'Unsupported registry type';
  sBadProcHandle = 'Bad process handle';


// -----------------------------------------------------------------------------
// Helper routines
// -----------------------------------------------------------------------------


procedure InitPlatformIdEx;
  {Initialise global variables with extended OS version information if possible}
var
  OSVI: TOSVersionInfoEx;  // extended OS version info structure
  POSVI: POSVersionInfo;   // pointer to OS version info structure
begin
  // Clear the structure
  FillChar(OSVI, SizeOf(OSVI), Char(0));
  // Get pointer to structure of non-extended type (GetVersionEx
  // requires a non-extended structure and we need this pointer to get
  // it to accept our extended structure!!
  {$IFDEF WARNDIRS}{$WARN UNSAFE_CODE OFF}{$ENDIF}
  {$TYPEDADDRESS OFF}
  POSVI := @OSVI;
  {$TYPEDADDRESS ON}
  {$IFDEF WARNDIRS}{$WARN UNSAFE_CODE ON}{$ENDIF}
  // Try to get exended information
  OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
  {$WARN UNSAFE_CODE OFF}
  Win32HaveExInfo := GetVersionEx(POSVI^);
  {$WARN UNSAFE_CODE ON}
  if Win32HaveExInfo then
  begin
    // We have extended info: store details in global vars
    Win32ServicePackMajor := OSVI.wServicePackMajor;
    Win32ServicePackMinor := OSVI.wServicePackMinor;
    Win32SuiteMask := OSVI.wSuiteMask;
    Win32ProductType := OSVI.wProductType;
  end;
end;

function MakeDirName(const DirOrPath: string) : string;
  {Removes any trailing '\' from given directory or path and returns result}
begin
  Result := DirOrPath;
  while (Result <> '') and (Result[Length(Result)] = '\') do
    Result := Copy(Result, 1, Length(Result) - 1);
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
  Reg := TRegistry.Create;
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
          raise EPJSysInfo.Create(sBadRegType);
      end;
    end;
  finally
    // Close registry
    Reg.CloseKey;
    FreeAndNil(Reg);
  end;
end;

function GetCurrentVersionRegStr(const ValName: string): string;
  {Gets string info from Windows current version key in registry}
const
  // required registry string
  cWdwCurrentVer = '\Software\Microsoft\Windows\CurrentVersion';
begin
  Result := GetRegistryString(
    Windows.HKEY_LOCAL_MACHINE,
    cWdwCurrentVer,
    ValName
  );
end;


// -----------------------------------------------------------------------------
// Public routines
// -----------------------------------------------------------------------------

function SIGetCommonFilesFolder: string;
  {Returns fully qualified name of Common Files folder}
begin
  Result := TPJSystemFolders.CommonFiles;
end;

function SIGetComputerName: string;
  {Returns name of computer}
begin
  Result := TPJComputerInfo.ComputerName;
end;

function SIGetOSBuildNumber: Integer;
  {Returns build number of operating system}
begin
  Result := TPJOSInfo.BuildNumber;
end;

function SIGetOSDesc: string;
  {Returns Full description of operating system: included product name, suite
  and build numbers as applicable}
begin
  Result := TPJOSInfo.Description;
end;

function SIGetOSMajorVersion: Integer;
  {Returns major version of OS}
begin
  Result := TPJOSInfo.MajorVersion;
end;

function SIGetOSMinorVersion: Integer;
  {Returns minor version of OS}
begin
  Result := TPJOSInfo.MinorVersion;
end;

function SIGetOSPlatform: TPJOSPlatform;
  {Returns code identifying OS platform program is running on}
begin
  Result := TPJOSInfo.Platform;
end;

function SIGetOSProduct: TPJOSProduct;
  {Returns code identifying OS product program is running on}
begin
  Result := TPJOSInfo.Product;
end;

function SIGetOSProductName: string;
  {Returns product name of operating system}
begin
  Result := TPJOSInfo.ProductName;
end;

function SIGetOSProductType: string;
  {Returns type of product for Win NT and empty string for other OSs}
begin
  Result := TPJOSInfo.Edition;
end;

function SIGetOSServicePack: string;
  {Returns service pack info for NT and additional release info for Win9x}
begin
  Result := TPJOSInfo.ServicePack;
end;

function SIGetProgramFilesFolder: string;
  {Returns fully qualified name of Program Files folder}
begin
  Result := TPJSystemFolders.ProgramFiles;
end;

function SIGetSystemFolder: string;
  {Returns fully qualified name of Windows system folder}
begin
  Result := TPJSystemFolders.System;
end;

function SIGetTempFolder: string;
  {Returns fully qualified name of current temporary folder}
begin
  Result := TPJSystemFolders.Temp;
end;

function SIGetUserName: string;
begin
  Result := TPJComputerInfo.UserName;
end;

function SIGetWindowsFolder: string;
begin
  Result := TPJSystemFolders.Windows;
end;


// -----------------------------------------------------------------------------
// Component implementation
// -----------------------------------------------------------------------------

{ TPJSysInfo }

constructor TPJSysInfo.Create(AOwner: TComponent);
  {Class constructor: ensures only one instance of component can be placed on a
  form}
var
  Idx: Integer; // loops thru components on Owner form
begin
  // Ensure that component is unique
  for Idx := 0 to Pred(AOwner.ComponentCount) do
    if AOwner.Components[Idx] is ClassType then
      raise Exception.CreateFmt(
        sDupInstErr,
        [ClassName, AOwner.Components[Idx].Name, AOwner.Name]
      );
  // All OK: go ahead and create component
  inherited Create(AOwner);
end;

function TPJSysInfo.GetCommonFilesFolder: string;
  {Read access method for CommonFilesFolder property}
begin
  Result := TPJSystemFolders.CommonFiles;
end;

function TPJSysInfo.GetComputerName: string;
  {Read access method for ComputerName property}
begin
  Result := TPJComputerInfo.ComputerName;
end;

function TPJSysInfo.GetOSBuildNumber: Integer;
  {Read access method for OSBuildNumber property}
begin
  Result := TPJOSInfo.BuildNumber;
end;

function TPJSysInfo.GetOSDesc: string;
  {Read access method for OSDesc property}
begin
  Result := TPJOSInfo.Description;
end;

function TPJSysInfo.GetOSMajorVersion: Integer;
  {Read access method for OSMajorVersion property}
begin
  Result := TPJOSInfo.MajorVersion;
end;

function TPJSysInfo.GetOSMinorVersion: Integer;
  {Read access method for OSMinorVersion property}
begin
  Result := TPJOSInfo.MinorVersion;
end;

function TPJSysInfo.GetOSPlatform: TPJOSPlatform;
  {Read access method for OSPlatform property}
begin
  Result := TPJOSInfo.Platform;
end;

function TPJSysInfo.GetOSProduct: TPJOSProduct;
  {Read access method for OSProduct property}
begin
  Result := TPJOSInfo.Product;
end;

function TPJSysInfo.GetOSProductName: string;
  {Read access method for OSProductName property}
begin
  Result := TPJOSInfo.ProductName;
end;

function TPJSysInfo.GetOSProductType: string;
  {Read access method for OSProductType property}
begin
  Result := TPJOSInfo.Edition;
end;

function TPJSysInfo.GetOSServicePack: string;
  {Read access method for OSServicePack property}
begin
  Result := TPJOSInfo.ServicePack;
end;

function TPJSysInfo.GetProgramFilesFolder: string;
  {Read access method for ProgramFilesFolder property}
begin
  Result := TPJSystemFolders.ProgramFiles;
end;

function TPJSysInfo.GetSystemFolder: string;
  {Read access method for SystemFolder property}
begin
  Result :=  TPJSystemFolders.System;
end;

function TPJSysInfo.GetTempFolder: string;
  {Read access method for TempFolder property}
begin
  Result := TPJSystemFolders.Temp;
end;

function TPJSysInfo.GetUserName: string;
  {Read access method for UserName property}
begin
  Result := TPJComputerInfo.UserName;
end;

function TPJSysInfo.GetWindowsFolder: string;
  {Read access method for WindowsFolder property}
begin
  Result := TPJSystemFolders.Windows;
end;

{ TPJOSInfo }

class function TPJOSInfo.BuildNumber: Integer;
  {Returns operating system's build number}
begin
  Result := Win32BuildNumber;
end;

class function TPJOSInfo.CheckSuite(const Suite: Integer): Boolean;
  {Checks if a given suite is installed on an NT system. Pass one of the
  VER_SUITE_* flags to the function as the suite to test for. Always returns
  False on non-NT systems}
begin
  Result := Win32SuiteMask and Suite <> 0;
end;

class function TPJOSInfo.Description: string;
  {Returns full description of operating system}

  // ---------------------------------------------------------------------------
  procedure AppendToResult(const Str: string);
    {Adds a non-empty string to end of result, preceeded by space}
  begin
    if Str <> '' then
      Result := Result + ' ' + Str;
  end;
  // ---------------------------------------------------------------------------

begin
  // Start with product name
  Result := ProductName;
  case Platform of
    ospWinNT:
    begin
      // We have an NT OS
      // append any product type
      if Product = osWinNT then
      begin
        // For NT3/4 append version number after product
        AppendToResult(Format('%d.%d', [MajorVersion, MinorVersion]));
        AppendToResult(Edition);
        AppendToResult(ServicePack);  // does nothing if no service pack
        AppendToResult(Format('(Build %d)', [BuildNumber]));
      end
      else
      begin
        // Windows 2000 and later: don't include version number
        AppendToResult(Edition);
        AppendToResult(ServicePack);  // does nothing if no service pack
        AppendToResult(Format('(Build %d)', [BuildNumber]));
      end;
    end;
    ospWin9x:
      // We have a Win 95 line OS: append service and build
      AppendToResult(ServicePack);
  end;
end;

class function TPJOSInfo.Edition: string;
  {Returns the product edition for an NT operating system or '' for a non-NT
  operating system}
begin
  Result := '';
  if IsWinNT then
  begin
    if Win32HaveExInfo then
    begin
      // Test for edition on Windows NT 4 SP6 and later
      if IsServer then
      begin
        // Server type
        case Product of
          osWinNT:
          begin
            // can only be NT 4 here
            if CheckSuite(VER_SUITE_ENTERPRISE) then
              Result := 'Enterprise Edition'
            else
              Result := 'Server';
          end;
          osWin2K:
          begin
            if CheckSuite(VER_SUITE_DATACENTER) then
              Result := 'Datacenter Server'
            else if CheckSuite(VER_SUITE_ENTERPRISE) then
              Result := 'Advanced Server'
            else
              Result := 'Server';
          end;
//          osWinXP:
//            {Do nothing}; // Windows XP has no server edition
          osWinSvr2003:
          begin
            if CheckSuite(VER_SUITE_DATACENTER) then
              Result := 'DataCenter Edition'
            else if CheckSuite(VER_SUITE_ENTERPRISE) then
              Result := 'Enterprise Edition'
            else if CheckSuite(VER_SUITE_BLADE) then
              Result := 'Web Edition'
            else
              Result := 'Standard Edition';
          end;
          osWinVista:
            // Beta version: may change
            Result := '"Longhorn" Server';
        end;
      end
      else
      begin
        // Workstation type
        case Product of
          osWinNT:
            // can only be NT4 here
            Result := 'Workstation';
          osWin2K:
            Result := 'Professional';
          osWinXP:
          begin
            if GetSystemMetrics(SM_MEDIACENTER) <> 0 then
              Result := 'Media Center Edition'
            else if GetSystemMetrics(SM_TABLETPC) <> 0 then
              Result := 'Tablet PC Edition'
            else if CheckSuite(VER_SUITE_PERSONAL) then
              Result := 'Home Edition'
            else
              Result := 'Professional';
          end;
//          osWinSvr2003:
//            {Do nothing}; // Windows Server 2003 has no workstation edition
//          osWinVista:
//            // Beta version: may change
//            {Do nothing}; // May change when out of Beta
        end;
      end;
    end
    else
      // No extended info (pre NT4 SP6a): get info from registry
      Result := EditionFromReg;
  end;
end;

class function TPJOSInfo.EditionFromReg: string;
  {Gets name of edition from registry: needed to get edition for NT4 pre SP6}
var
  EditionCode: string;  // OS product edition code stored in registry
begin
  EditionCode := ProductTypeFromReg;
  if CompareText(EditionCode, 'WINNT') = 0 then
    Result := 'WorkStation'
  else if CompareText(EditionCode, 'LANMANNT') = 0 then
    Result := 'Server'
  else if CompareText(EditionCode, 'SERVERNT') = 0 then
    Result := 'Advanced Server';
  Result := Result + Format(
    ' %d.%d', [Win32MajorVersion, Win32MinorVersion]
  );
end;

class function TPJOSInfo.IsNT4SP6a: Boolean;
  {Checks registry to see if NT4 Service Pack 6a is installed}
var
  Reg: TRegistry;
begin
  if (Product = osWinNT)
    and (Win32MajorVersion = 4)
    and (CompareText(Win32CSDVersion, 'Service Pack 6') = 0) then
  begin
    // System is reporting NT4 SP6
    // we have SP 6a if particular registry key exists
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Result := Reg.KeyExists(
        'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Hotfix\Q246009'
      );
    finally
      FreeAndNil(Reg);
    end;
  end
  else
    // System not reporting NT4 SP6, so not SP6a!
    Result := False;
end;

class function TPJOSInfo.IsServer: Boolean;
  {Returns true if operating system is a server}
begin
  if Win32HaveExInfo then
    // Check product type from extended OS info
    Result := Win32ProductType <> VER_NT_WORKSTATION
  else
  begin
    // Check product type stored in registry
    Result := CompareText(ProductTypeFromReg, 'WINNT') <> 0;;
  end;
end;

class function TPJOSInfo.IsWin32s: Boolean;
  {Returns true if running on Win32s. This is unlikely to ever return true since
  Delphi is not believed to run on Win32s itself}
begin
  Result := Platform = ospWin32s;
end;

class function TPJOSInfo.IsWin9x: Boolean;
  {Returns true if a Windows 9x operating system is installed (i.e. Windows 95,
  Windows 98 or Windows Me}
begin
  Result := Platform = ospWin9x;
end;

class function TPJOSInfo.IsWinNT: Boolean;
  {Returns true if an NT operating system is installed (including Windows 2000,
  Windows XP and Windows 2003 Server)}
begin
  Result := Platform = ospWinNT;
end;

class function TPJOSInfo.IsWow64: Boolean;
  {Returns true if application is running under WOW64 on a 64 bit operating
  system}
type
  TIsWow64Process = function( // Type of IsWow64Process API fn
    Handle: THandle;
    var Res: BOOL
  ): BOOL; stdcall;
var
  IsWow64Result: BOOL;              // result from IsWow64Process
  IsWow64Process: TIsWow64Process;  // IsWow64Process fn reference
begin
  // Try to load required function from kernel32
  IsWow64Process := GetProcAddress(
    GetModuleHandle('kernel32'), 'IsWow64Process'
  );
  if Assigned(IsWow64Process) then
  begin
    // Function is implemented: call it
    if not IsWow64Process(GetCurrentProcess, IsWow64Result) then
      raise Exception.Create(sBadProcHandle);
    // Return result of function
    Result := IsWow64Result;
  end
  else
    // Function not implemented: can't be running on Wow64
    Result := False;
end;

class function TPJOSInfo.MajorVersion: Integer;
  {Returns operating system's major version number}
begin
  Result := Win32MajorVersion;
end;

class function TPJOSInfo.MinorVersion: Integer;
  {Returns operating system's minor version number}
begin
  Result := Win32MinorVersion;
end;

class function TPJOSInfo.Platform: TPJOSPlatform;
  {Returns value indentifying OS platform}
begin
  case Win32Platform of
    VER_PLATFORM_WIN32_NT: Result := ospWinNT;
    VER_PLATFORM_WIN32_WINDOWS: Result := ospWin9x;
    VER_PLATFORM_WIN32s: Result := ospWin32s;
    else raise EPJSysInfo.Create(sUnknownPlatform);
  end;
end;

class function TPJOSInfo.Product: TPJOSProduct;
  {Returns value identifying product}
begin
  Result := osUnknown;
  case Platform of
    ospWin9x:
    begin
      // Win 9x platform: only major version is 4
      Result := osUnknownWin9x;
      case Win32MajorVersion of
        4:
        begin
          case Win32MinorVersion of
            0: Result := osWin95;
            10: Result := osWin98;
            90: Result := osWinMe;
          end;
        end;
      end;
    end;
    ospWinNT:
    begin
      // NT platform OS
      Result := osUnknownWinNT;
      case Win32MajorVersion of
        3, 4:
        begin
          // NT 3 or 4
          case Win32MinorVersion of
            0: Result := osWinNT;
          end;
        end;
        5:
        begin
          // Windows 2000 or XP
          case Win32MinorVersion of
            0: Result := osWin2K;
            1: Result := osWinXP;
            2: Result := osWinSvr2003;
          end;
        end;
        6:
        begin
          // Windows Vista
          case Win32MinorVersion of
            0: Result := osWinVista;
          end;
        end;
      end;
    end;
    ospWin32s:
      // Windows 32s: probably won't ever get this
      Result := osUnknownWin32s;
  end;
end;

class function TPJOSInfo.ProductID: string;
  {Returns the Windows product ID}
const
  // Registry keys for Win 9x/NT
  cRegKey: array[Boolean] of string = (
    'Software\Microsoft\Windows\CurrentVersion',
    'Software\Microsoft\Windows NT\CurrentVersion'
  );
begin
  Result := GetRegistryString(
    HKEY_LOCAL_MACHINE, cRegKey[IsWinNT], 'ProductID'
  );
end;

class function TPJOSInfo.ProductName: string;
  {Returns name of product}
begin
  case Product of
    osUnknownWinNT, osUnknownWin9x, osUnknownWin32s: Result := '';
    osWinNT: Result := 'Windows NT';
    osWin2K: Result := 'Windows 2000';
    osWinXP: Result := 'Windows XP';
    osWinVista: Result := 'Windows Vista';    // may change when out of beta
    osWin95: Result := 'Windows 95';
    osWin98: Result := 'Windows 98';
    osWinMe: Result := 'Windows Me';
    osWinSvr2003: Result := 'Windows 2003';
    else
      raise EPJSysInfo.Create(sUnknownProduct);
  end;
end;

class function TPJOSInfo.ProductTypeFromReg: string;
  {Gets code describing product type from registry: used to get product type for
  NT4 SP5 and earlier}
begin
  Result := GetRegistryString(
    HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\ProductOptions',
    'ProductType'
  );
end;

class function TPJOSInfo.ServicePack: string;
  {Returns name of any service pack installed}
begin
  // Assume to service pack
  Result := '';
  case Platform of
    ospWin9x:
      // On the Windows 9x platform we decode the service pack info
      if Win32CSDVersion <> '' then
      begin
        case Product of
          osWin95:
            if CharInSet(UpCase(Win32CSDVersion[1]),['B', 'C']) then
              Result := 'OSR2';
          osWin98:
            if UpCase(Win32CSDVersion[1]) = 'A' then
              Result := 'SE';
        end;
      end;
    ospWinNT:
      // On Windows NT we return service pack string, unless NT4 SP8 when we
      // need to check whether actually SP6 or SP6a
      if IsNT4SP6a then
        Result := 'Service Pack 6a' // do not localize
      else
        Result := Win32CSDVersion;
  end;
end;

class function TPJOSInfo.ServicePackMajor: Integer;
  {Returns major version number of any installed NT service pack or 0 if no
  service pack is installed or if the system is running Windows 9x}
begin
  Result := Win32ServicePackMajor;
end;

class function TPJOSInfo.ServicePackMinor: Integer;
  {Returns minor version number of any installed NT service pack. Valid only
  when ServicePackMajor is non-zero}
begin
  Result := Win32ServicePackMinor;
end;


{ TPJComputerInfo }

class function TPJComputerInfo.ComputerName: string;
  {Returns name of computer}
var
  PComputerName: array[0..MAX_PATH] of Char;// buffer for name returned from API
  Size: DWORD;                              // size of name buffer
begin
  Size := MAX_PATH;
  if Windows.GetComputerName(PComputerName, Size) then
    Result := PComputerName
  else
    Result := '';
end;

class function TPJComputerInfo.UserName: string;
  {Returns name of currently logged on user}
var
  PUserName: array[0..MAX_PATH] of Char;  // buffer for name returned from API
  Size: DWORD;                            // size of name buffer
begin
  Size := MAX_PATH;
  if Windows.GetUserName(PUserName, Size) then
    Result := PUserName
  else
    Result := '';
end;

{ TPJSystemFolders }

class function TPJSystemFolders.CommonFiles: string;
  {Returns fully qualified name of Common Files folder}
begin
  Result :=  MakeDirName(GetCurrentVersionRegStr('CommonFilesDir'));
end;

class function TPJSystemFolders.ProgramFiles: string;
  {Returns fully qualified name of Program Files folder}
begin
  Result :=  MakeDirName(GetCurrentVersionRegStr('ProgramFilesDir'));
end;

class function TPJSystemFolders.System: string;
  {Returns fully qualified name of Windows system folder}
var
  PFolder: array[0..MAX_PATH] of Char;  // buffer to hold name returned from API
begin
  if GetSystemDirectory(PFolder, MAX_PATH) <> 0 then
    Result := MakeDirName(PFolder)
  else
    Result := '';
end;

class function TPJSystemFolders.Temp: string;
  {Returns fully qualified name of system's temporary folder}
var
  PathBuf: array[0..MAX_PATH] of Char;  // buffer to hold name returned from API
begin
  if GetTempPath(MAX_PATH, PathBuf) <> 0 then
    Result := MakeDirName(PathBuf)
  else
    Result := '';
end;

class function TPJSystemFolders.Windows: string;
  {Returns fully qualified name of Windows folder}
var
  PFolder: array[0..MAX_PATH] of Char;  // buffer to hold name returned from API
begin
  if GetWindowsDirectory(PFolder, MAX_PATH) <> 0 then
    Result := MakeDirName(PFolder)
  else
    Result := '';
end;

initialization

// Initialize global variables from extended
InitPlatformIdEx;

end.
