unit ERPLib;

interface

uses
  JsonObject;

function IsERPCustomEnabled:Boolean;
function IsERPHelpEditEnabled:Boolean;
function GetERPCustomConfig(ConfigFilename:String=''): TJsonObject;
function CanUpdateLanguageBaseURL :boolean;
function IsCurDBforAdminModule(TagGroup, tagCatg, tagDb :String; AllowAlldbonServer:boolean; ConfigFilename:String=''):Boolean;
function IsVS1_ProductionAdminDatabase  :Boolean;
function IsVS1_SandBoxAdminDatabase  :Boolean;

implementation

uses
  sysutils, SystemLib, AppEnvironment, utVS1Const;
function CanUpdateLanguageBaseURL :boolean;
begin
  Result := IsERPCustomEnabled;
end;
function IsERPHelpEditEnabled         :Boolean;begin Result := IsCurDBforAdminModule('Modules' ,  'HelpEdit'            ,'Database', True);end;
function IsERPCustomEnabled           :Boolean;begin Result := IsCurDBforAdminModule('Modules' ,  'ERP'                 ,'Database', False);end;
function IsVS1_ProductionAdminDatabase:Boolean;begin Result := IsCurDBforAdminModule('Modules' ,  'VS1_Cloud_Production','Database', False);end;
function IsVS1_SandBoxAdminDatabase   :Boolean;begin Result := IsCurDBforAdminModule('Modules' ,  'VS1_Cloud_SandBox'   ,'Database', False);end;
function IsCurDBforAdminModule(TagGroup, tagCatg, tagDb :String; AllowAlldbonServer:boolean; ConfigFilename:String=''):Boolean;
var
  CustConfig: TJsonObject;
begin
  REsult := False;
  if ConfigFilename = '' then ConfigFilename :='ERPCustomConfig.txt';

  if not FileExists(systemlib.ExeDir  + ConfigFilename ) then exit;

  CustConfig := JO;
  try
    CustConfig.LoadFromFile(systemlib.ExeDir+ ConfigFilename );
    if CustConfig.O[TagGroup].ObjectExists(tagCatg) then begin
      if SameText(CustConfig.O[TagGroup].O[tagCatg].S[tagDb], AppEnv.AppDb.Database) then begin
        Result := TRue;
        if CustConfig.O[TagGroup].O[tagCatg].Exists('Status') then
          REsult := Sametext(CustConfig.O[TagGroup].O[tagCatg].S['Status'] , 'Active');
      end else if AllowAlldbonServer and SameText(CustConfig.O[TagGroup].O[tagCatg].S[tagDb], '*') then begin
        Result := TRue;
      end;
    end;

  finally
    CustConfig.Free;
  end;

end;

function GetERPCustomConfig(ConfigFilename:String=''): TJsonObject;
begin
  result := JO;
  if ConfigFilename = '' then ConfigFilename :='ERPCustomConfig.txt';
  if not FileExists(systemlib.ExeDir  + ConfigFilename ) then exit;
  result.LoadFromFile(systemlib.ExeDir+ ConfigFilename );
end;

end.
