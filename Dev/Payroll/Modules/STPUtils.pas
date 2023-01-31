unit STPUtils;

interface
const
  OZEDI_UserLive = 'api@erpoz.com';
  OZEDI_PassLive = 'erpapil123';

  OZEDI_UserSandpit = 'api@erpoz.com';
  OZEDI_PassSandpit = 'erpapi1';


  OZEDI_Base_URL_Sandpit = 'https://dashboard-api.sandpit.ozedi.com.au/api/';
  OZEDI_Base_URL_Live = 'https://dashboard-api.ozedi.com.au/api/';
  OZEDI_Base_URL_Test = 'https://localhost:444/api/';
  //OZEDI_Testurl := 'https://www.dionecomplexsystems.com';

Function JobKeeperStartWeekSQL:String;
function OZEDI_BaseURL(mode:String) : string;
Function MessageStatusURL(mode:String;aClientID: string;aMessageUuid: string):String;
Function ResponseHeaderURL(mode:String;aClientID: string;aMessageUuid: string):String;
Function ResponsePayloadURL(mode:String;aClientID: string;aMessageUuid: string):String;

implementation

uses tcConst;
Function MessageStatusURL(mode:String;aClientID: string;aMessageUuid: string):String;
begin
  Result := OZEDI_BaseURL(mode) + 'message/status/' + aClientID + '/' + aMessageUuid;
end;
Function ResponseHeaderURL(mode:String;aClientID: string;aMessageUuid: string):String;
begin
  Result := OZEDI_BaseURL(mode) +'message/' + aClientID + '/' + aMessageUuid;
end;
Function ResponsePayloadURL(mode:String;aClientID: string;aMessageUuid: string):String;
begin
  Result := OZEDI_BaseURL(mode) +'message/payload/' + aClientID + '/' + aMessageUuid;
end;

Function JobKeeperStartWeekSQL:String;
begin
   Result := 'select * from tblSTPJobkeeperFNList order by FN';
end;
function OZEDI_BaseURL(mode:String) : string;
begin
       if mode='Test' then result    := OZEDI_Base_URL_Test
  else if mode ='Sandpit' then result := OZEDI_Base_URL_Sandpit
  else result := OZEDI_Base_URL_Live;
end;

end.
