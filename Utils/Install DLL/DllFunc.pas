unit DllFunc;

interface

uses
  Classes;

  Function MysqlConnectionOK(const sServer:PChar):Boolean; stdcall;
//  Function ServerServicesConnectionOk(const sServer:PChar):Boolean; stdcall;
  Function SetConnectionINI(const FilePath,sServer: PChar):Boolean; stdcall;
  Function SetDefaultCompanyRegion(const sDatabase,sServer,sCountry:PChar):Boolean; stdcall;
  function GetCurrentServer(const FilePath: PChar): PChar; stdcall;
  function GetSysCountryName: PChar; stdcall;
  function WinServiceIsInstalled(const sMachine, sService: PChar): boolean; stdcall;
  function WinServiceStart(const aMachine, aServiceName: PChar): boolean; stdcall;
  function WinServiceStop(const aMachine,aServiceName: PChar): boolean; stdcall;
  function StopOrKillService(const sSvcName, sModName: PChar;
                           const iTimeOutMs: cardinal): boolean; stdcall;
//  function KillProcessByName(const sName: string): boolean; stdcall;

implementation

uses
  SysUtils,MyAccess,MyClasses,{MiddleTier,}IdException,IniFiles,Registry,
  windows, AppRunUtils;

var
  CountryNameStr: string;  

Function MysqlConnectionOK(const sServer:PChar):Boolean;
var
  Connection: TMyConnection;
Begin
  Connection := TMyConnection.Create(nil);
  Try
    with Connection do begin
      Name := 'Connection';
      Database := 'mysql';
      Port := 3309;
      Username := 'P_One';
      Password := '1w$p&LD07';
      Server := sServer;
      LoginPrompt := False;
    end;
    Try
      Connection.Ping;
      Result := True;
    except
      on EMyError do Begin
        Result := False;
      end;
    end;
  finally
    Connection.Free;
  end;
end;

//Function ServerServicesConnectionOk(const sServer:PChar):Boolean;
//Var
//  MTClientPresent :TMTClient;
//  stream: TMemoryStream;
//  sl :TStringList;
//begin
//  stream := TMemoryStream.Create;
//  sl := TStringList.Create;
//  MTClientPresent := TMTClient.Create(nil);
//  Try
//    with MTClientPresent do begin
//      Host       := sServer;
//      Port       := 3310;
//    end;
//    Try
//      MTClientPresent.Execute(['PING'],stream);
//      sl.LoadFromStream(stream);
//      Result := (Pos('OK', sl.Text)>0);
//    except
//      on EIdSocketError do Begin
//        Result := False;
//      end;
//    end;
//  finally
//    sl.Free;
//    stream.Free;
//    MTClientPresent.Free;
//  end;
//end;

Function SetConnectionINI(const FilePath,sServer: PChar):Boolean;
var
  ini: TMemIniFile;
begin
  result := False;
  If not FileExists(FilePath + '\Connection.ini') then Exit;
  ini :=  TMemIniFile.Create(FilePath + '\Connection.ini');
  try
    ini.WriteString('Last_Database', 'Server', sServer);
    ini.WriteString('Servers', 'Server0', sServer);
    ini.UpdateFile;
    result := true;
  finally
    FreeandNil(ini);
  end;
end;

function GetCurrentServer(const FilePath: PChar): PChar;
var
  ini: TMemIniFile;
  s: string;
begin
  result := 'localhost';
  If not FileExists(FilePath + '\Connection.ini') then Exit;
  ini :=  TMemIniFile.Create(FilePath + '\Connection.ini');
  try
    s:= ini.ReadString('Last_Database', 'Server', result);
    if Trim(s) = '' then
      s:= 'localhost';
    result:= PChar(s);
  finally
    FreeandNil(ini);
  end;
end;

Function SetDefaultCompanyRegion(const sDatabase,sServer,sCountry:PChar):Boolean;
var
  Connection: TMyConnection;
Begin
  Connection := TMyConnection.Create(nil);
  Try
    with Connection do begin
      Name := 'Connection';
      Database := sDatabase;
      Port := 3309;
      Username := 'P_One';
      Password := '1w$p&LD07';
      Server := sServer;
      LoginPrompt := False;
    end;
    Try
      Connection.ExecSQL('UPDATE tbldbpreferences SET FieldValue="'+sCountry+'"  WHERE Name = "CompanyRegion";', []);
      Result := True;
    except
      on EMyError do Begin
        Result := False;
      end;
    end;
  finally
    Connection.Free;
  end;
end;

function GetSysCountryName: PChar;
var
  Reg: TRegistry;
  val: string;
begin
  { The default! }
  CountryNameStr:= 'Australia';
  Reg:= TRegistry.Create;
  try
    Reg.RootKey:= HKEY_CURRENT_USER;
    if Reg.OpenKey('Control Panel\International\Geo', false) then begin
      val:= Reg.ReadString('Nation');
      if Val = '12' then CountryNameStr:= 'Australia'
      else if Val = '242' then CountryNameStr:= 'United Kingdom'
      else if Val = '183' then CountryNameStr:= 'New Zealand';
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
  Result := PChar(CountryNameStr);
end;

function WinServiceIsInstalled(const sMachine, sService: PChar): boolean;
begin
//  with TStringList.Create do begin
//    if fileexists('InstallDll_Log.txt') then
//      LoadFromFile('InstallDll_Log.txt');
//    Add('ServiceIsInstalled - Start');
//    SavetoFile('InstallDll_Log.txt');
//    Free;
//  end;
  result:= AppRunUtils.ServiceIsInstalled(sMachine,sService);
//  with TStringList.Create do begin
//    if fileexists('InstallDll_Log.txt') then
//      LoadFromFile('InstallDll_Log.txt');
//    Add('ServiceIsInstalled - End');
//    SavetoFile('InstallDll_Log.txt');
//    Free;
//  end;
end;

function WinServiceStart(const aMachine, aServiceName: PChar): boolean;
begin
  result:= AppRunUtils.ServiceStart(aMachine, aServiceName);
end;

function WinServiceStop(const aMachine,aServiceName: PChar): boolean;
begin
  result:= AppRunUtils.ServiceStop(aMachine, aServiceName);
end;

function StopOrKillService(const sSvcName, sModName: PChar;
                           const iTimeOutMs: cardinal): boolean;
begin
  result:= AppRunUtils.ServiceStop('',sSvcName,iTimeOutMs);
  if not result then
    result:= AppRunUtils.KillTask(sModName) <> 0;
//  result:= ProcessFuncs.StopOrKillService(sSvcName, sModName, iTimeOutMs);
end;

//function KillProcessByName(const sName: string): boolean;
//begin
//  result:= ProcessFuncs.KillProcessByName(sName);
//end;


initialization

finalization

end.
