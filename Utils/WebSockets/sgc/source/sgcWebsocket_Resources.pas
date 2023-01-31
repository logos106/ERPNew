{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebsocket_Resources;

interface

uses
  StrUtils, {$IFDEF MACOS}Types{$ELSE}Windows{$ENDIF};

function GetResourceString(const aResource: String): string;

implementation

function GetResourceString(const aResource: String): string;
var
  oResInfo: HRSRC;
  oHandle: THandle;
  oBuffer: PAnsiChar;
  size: Integer;
begin
  if aResource = '' then exit;

  oResInfo := FindResource(0, PChar(aResource), RT_RCDATA);

  oHandle := LoadResource(0, oResInfo);
  Try
    if oHandle <> 0 then
    begin
      oBuffer := LockResource(oHandle);
      Try
        size := SizeofResource(0, oResInfo);
        result := LeftStr(String(oBuffer), size);
      Finally
        UnlockResource(oHandle);
      End;
    end;
  Finally
    FreeResource(oHandle);
  End;
end;

end.
