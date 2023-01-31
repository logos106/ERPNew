unit OldLicenceInfo;

interface
uses
  JsonObject;

(*
  Example of returned JSON:

    {
    "machineid":"D7374309",
    "licence":"Stage365+",
    "licenceid":175,
    "clientid":463,
    "begins":"2009-08-20",
    "expires":"2010-08-20",
    "noclientslots":20,
    "nomultisites":9
    }
    
*)
function GetOldLicenceInfo: TJsonObject;

implementation

uses
  OnGuard, LbUtils, LbCipher, LbClass, MyAccess, sysutils, classes;

function GetMachineId: String;
var
  InfoSet: TEsMachineInfoSet;
  MachineID: Longint;
begin
  InfoSet := [];
  InfoSet := InfoSet + [midDrives];
  MachineID := OnGuard.CreateMachineID(InfoSet);
  Result := BufferToHex(MachineID, SizeOf(MachineID));
end;


function GetOldLicenceInfo: TJsonObject;
var
  LbBlowfish: TLbBlowfish;
  s: string;
  Conn: TMyConnection;
  qry: TMyQuery;
  sl: TStringList;
begin
  result:= nil;
  LbBlowfish:= TLbBlowfish.Create(nil);
  Conn:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  sl:= TStringList.Create;
  try
    conn.LoginPrompt:= false;
    conn.Server:= 'localhost';
    conn.Database:= 'services';
    conn.Username:= 'P_One';
    conn.Password:= '1w$p&LD07';
    conn.Port:= 3309;
    try
      conn.Connect;
      qry.Connection:= conn;
      qry.SQL.Text:= 'select * from tblServerLicence';
      qry.Open;
      LbBlowfish.GenerateKey(GetMachineID + GetMachineID);
      s:= LbBlowfish.DecryptString(qry.FieldByName('Data').asString);

      s:= Trim(s);
      if s <> '' then begin
        result:= JO();
        { strip off end bits }
        s:= StringReplace(s,'<Licence ','',[]);
        s:= StringReplace(s,'/>','',[]);
        sl.CommaText:= s;
        result.S['machineid']:= StringReplace(sl.Values['machineid'],'"','',[rfReplaceAll]);
        result.S['licence']:= StringReplace(sl.Values['licence'],'"','',[rfReplaceAll]);
        result.I['licenceid']:= StrToIntDef(StringReplace(sl.Values['licenceid'],'"','',[rfReplaceAll]),0);
        result.I['clientid']:= StrToIntDef(StringReplace(sl.Values['clientid'],'"','',[rfReplaceAll]),0);
        result.S['begins']:= StringReplace(sl.Values['begins'],'"','',[rfReplaceAll]);
        result.S['expires']:= StringReplace(sl.Values['expires'],'"','',[rfReplaceAll]);
        result.I['noclientslots']:= StrToIntDef(StringReplace(sl.Values['noclientslots'],'"','',[rfReplaceAll]),0);
        result.I['nomultisites']:= StrToIntDef(StringReplace(sl.Values['nomultisites'],'"','',[rfReplaceAll]),0);
      end;
    except
    end;  
  finally
    LbBlowfish.Free;
    qry.Free;
    conn.Free;
    sl.Free;
  end;
end;


end.
