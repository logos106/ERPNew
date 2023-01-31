unit ERPLicenseLib;
{$I ERP.inc}
interface

uses
  JsonObject;

function ByPassLicenseCheck:Boolean;
function GetFromconfig(TagA, TagB, TagC :String; ConfigFilename:String=''):String;
function IsERPDatabase(aDbName: string): boolean;

implementation

uses ERPDbComponents, SystemLib, sysutils, ModuleDbUtils, DbConst, JsonToObject,
  CipherUtils, MyAccess;

function ByPassLicenseCheck:Boolean;
var
  CustConfig: TJsonObject;
begin
  Result := False;
  if sametext(GetFromconfig('Packages' ,'Name', ''), 'ERP') then
         if isERPDatabase(GetFromconfig('Packages' ,'ByPassLicense','Database' )) then result := true
    else if isERPDatabase(GetFromconfig('Packages' ,'ByPassLicense','Database1')) then result := true
    else if isERPDatabase(GetFromconfig('Packages' ,'ByPassLicense','Database2')) then result := true
    else if isERPDatabase(GetFromconfig('Packages' ,'ByPassLicense','Database3')) then result := true
    else if isERPDatabase(GetFromconfig('Packages' ,'ByPassLicense','Database4')) then result := true
    else if isERPDatabase(GetFromconfig('Packages' ,'ByPassLicense','Database5')) then result := true;
end;
function GetFromconfig(TagA, TagB, TagC :String; ConfigFilename:String=''):String;
var
  Configjo: TJsonObject;
begin
  REsult := '';
  if ConfigFilename = '' then ConfigFilename :='ERPLicenseconfig.txt';

  if not FileExists(systemlib.ExeDir  + ConfigFilename ) then exit;


  Configjo := JO;
  try
    Configjo.LoadFromFile(systemlib.ExeDir+ ConfigFilename );
    try
      if TagA= '' then  Exit;
      if not Configjo.Exists(TagA) then Exit;

      if TagB ='' then begin
        Result := Configjo.S[TagA];
        exit;
      end;
      if not Configjo.O[TagA].Exists(TagB) then Exit;

      if TagC = '' then begin
        Result := Configjo.O[TagA].S[TagB];
        Exit;
      end;
      if not Configjo.O[TagA].O[TagB].exists(TagC) then Exit;
      result := Configjo.O[TagA].O[TagB].S[TagC];
  finally
    Configjo.Free;
  end;
  finally

  end;

end;

function IsERPDatabase(aDbName: string): boolean;
var
  fConnection: TErpConnection;
  Qry :TERPQuery;
begin
  result:= false;
  if aDbName = ''  then Exit;
  fConnection := TErpConnection.Create(nil);
  try
      InitialiseConnection(fConnection,'localhost',aDbName(*SERVICES_DATABASE*));
      fConnection.Connect;
      Qry := TERPQuery.Create(nil);
      try
          Qry.connection := fConnection;
          qry.SQL.Text:= 'show tables';
          qry.Open;
          if qry.RecordCount > 300 then begin
            qry.Close;
            qry.SQL.Text:= 'show tables like "tblupdatedetails"';
            qry.Open;
            if not qry.IsEmpty then
              result:= true;
          end;
          qry.Close;
      finally
        if qry.active then qry.close;
        Freeandnil(qry);
      end;
  finally
    FreeandNil(fConnection)
  end;

end;


end.
