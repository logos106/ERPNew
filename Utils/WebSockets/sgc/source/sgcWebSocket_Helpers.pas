{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Helpers;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils, StrUtils,
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  {$IFNDEF LAZARUS}
  Masks,
  {$ENDIF}
  IdGlobal, IdHeaderList;

type
  TsgcDelimitedStringList = class(TStringList)
  public
    constructor Create;
  end;

  TsgcStringStream = class(TStringStream)
{$IFNDEF D2009}
  private
    FBytes: TIdBytes;
    function GetBytes: TIdBytes;
  protected
    procedure DoBytes; virtual;
  public
    function Write(const Buffer; Count: Longint): Longint; override;
  public
    property Bytes: TIdBytes read GetBytes;
{$ENDIF}
  end;

function HexToBase64(aText: string): string;
function HexToBytes(aText: String): TIdBytes;
function HexToString(const aText: String): String;
function sgcBytesToString(aStream: TsgcStringStream): String;
function sgcStringToBytes(const aText: String): TIdBytes;
function NewGuid: String;

function DecodeGETHeader(aHeaders: TIdHeaderList): String;
function DecodeGETFullPath(aHeaders: TIdHeaderList): String;
function IsWebSocketHeader(aHeaders: TIdHeaderList): Boolean;
function IsWebsocketAuthenticationHeader(aHeaders: TIdHeaderList): Boolean;
function IsAuthenticationHeader(aHeaders: TIdHeaderList): Boolean;
function IsRequestAuthenticationSessionHeader(aHeaders: TIdHeaderList): Boolean;
function IsAuthenticationURLHeader(aHeaders: TIdHeaderList): Boolean;
function IsAuthenticationSessionHeader(aHeaders: TIdHeaderList): Boolean;
function DecodeGETFileName(aText: string): String;

procedure ResizeStream(aStream: TStream; aSize: Integer);

function sgcContainsText(const aText, aSubText: String): Boolean;
function sgcMatchesMask(const Filename, Mask: string): Boolean;

implementation

uses
  sgcWebSocket_Const;

const
  MemoryDelta = $2000;

function HexToBase64(aText: string): string;

 function Encode_Byte(b: Byte): AnsiChar;
 const
   Base64Code: string[64] =
     'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
 begin
   Result := Base64Code[(b and $3F)+1];
 end;

var
  i: Integer;
begin
  aText := HexToString(aText);

  i := 1;
  Result := '';
  while i <= Length(aText) do
  begin
    Result := Result + String(Encode_Byte((Byte(aText[i]) shr 2) and $FF));
    if i + 1 <= Length(aText) then
      Result := Result + String(Encode_Byte(((Byte(aText[i]) shl 4) or
        (Byte(aText[i + 1]) shr 4)) and $FF))
    else
      Result := Result + String(Encode_Byte((Byte(aText[i]) shl 4) and $FF));
    if i + 2 <= Length(aText) then
      Result := Result + String(Encode_Byte(((Byte(aText[i + 1]) shl 2) or
        (Byte(aText[i + 2]) shr 6)) and $FF))
    else if i + 1 <= Length(aText) then
      Result := Result + String(Encode_Byte((Byte(aText[i + 1]) shl 2) and $FF))
    else
      Result := Result + '=';
    if i + 2 <= Length(aText) then
      Result := Result + String(Encode_Byte(Byte(aText[i + 2])))
    else
      Result := Result + '=';
    Inc(i, 3);
  end;
end;

function NewGuid: String;
var
  oGuid: TGuid;
begin
  CreateGuid(oGuid);
  result := GuidToString(oGuid);
  result := {$IFDEF D7}AnsiReplaceStr{$ELSE}{$IFDEF LAZARUS}StringReplace{$ELSE}ReplaceStr{$ENDIF}{$ENDIF}(result, '{',''{$IFDEF LAZARUS},[rfReplaceAll]{$ENDIF});
  result := {$IFDEF D7}AnsiReplaceStr{$ELSE}{$IFDEF LAZARUS}StringReplace{$ELSE}ReplaceStr{$ENDIF}{$ENDIF}(result, '}',''{$IFDEF LAZARUS},[rfReplaceAll]{$ENDIF});
  result := {$IFDEF D7}AnsiReplaceStr{$ELSE}{$IFDEF LAZARUS}StringReplace{$ELSE}ReplaceStr{$ENDIF}{$ENDIF}(result, '-',''{$IFDEF LAZARUS},[rfReplaceAll]{$ENDIF});
end;

function HexToBytes(aText: String): TIdBytes;
var
  i : Integer;
begin
  SetLength(Result, Length(aText) div 2);
  for i := 1 to length(aText) div 2 do
    Result[i-1] := StrToInt('$'+Copy(aText,(i-1)*2+1,2));
end;

function HexToString(const aText: String): String;
var
  i: Integer;
begin
  Result:= '';
  for i := 1 to length(aText) div 2 do
    Result := Result + Char(StrToInt('$' + Copy(aText,(i-1)*2+1,2)));
end;

function sgcBytesToString(aStream: TsgcStringStream): String;
{$IFDEF LAZARUS }
var
  i: integer;
{$ENDIF}
begin
  Result := '';
  {$IFDEF LAZARUS}
    {$IFDEF WINDOWS}
    if MultiByteToWideChar(65001, 8, PAnsiChar(aStream.Bytes), Length(aStream.Bytes), nil, 0) = 0 then
      exit;
    {$ENDIF}
    For i := 0 to Length(aStream.Bytes) - 1 do
      Result := Result + Char(aStream.Bytes[i]);
  {$ELSE}
    {$IFDEF INDY10_5_5}
    result := BytesToString(aStream.Bytes, 0, aStream.size, TIdTextEncoding.UTF8);
    {$ELSE}
      {$IFDEF INDY10_2}
      result := BytesToString(aStream.Bytes, 0, aStream.size);
      {$ELSE}
      result := UTF8Decode(aStream.DataString);
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

function sgcStringToBytes(const aText: String): TIdBytes;
begin
  SetLength(Result, Length(aText));
  if Length(Result) > 0 then
    Move(aText[1], Result[0], Length(aText));
end;

function DecodeGETHeader(aHeaders: TIdHeaderList): String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to aHeaders.Count - 1 do
  begin
    if sgcMatchesMask(aHeaders[i], 'GET *') then
    begin
      result := aHeaders[i];
      break;
    end;
  end;
end;

function DecodeGETFileName(aText: string): String;
var
  i: Integer;
begin
  if aText <> '' then
  begin
    i := AnsiPos(' HTTP', aText);
    result := MidStr(aText, 5, i - 5);
    result := MidStr(result, LastDelimiter('/', result) + 1, Length(result));
  end;
end;

function DecodeGETFullPath(aHeaders: TIdHeaderList): String;
var
  i: Integer;
  vText: String;
begin
  vText := DecodeGETHeader(aHeaders);
  if vText <> '' then
  begin
    i := AnsiPos(' HTTP', vText);
    result := MidStr(vText, 5, i - 5);
  end;
end;

function IsWebSocketHeader(aHeaders: TIdHeaderList): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to aHeaders.Count - 1 do
  begin
    if sgcMatchesMask(aHeaders[i], 'Upgrade: websocket') then
    begin
      result := True;
      break;
    end;
  end;
end;

procedure ResizeStream(aStream: TStream; aSize: Integer);
var
  oStream: TMemoryStream;
begin
  aStream.Position := aStream.Size - aSize;
  oStream := TMemoryStream.Create;
  Try
    oStream.CopyFrom(aStream, aSize);
    aStream.Size := aSize;
    aStream.Seek(0, soFromBeginning);
    oStream.Seek(0, soFromBeginning);
    aStream.CopyFrom(oStream, aSize);
  Finally
    FreeAndNil(oStream);
  End;
end;

function sgcContainsText(const aText, aSubText: String): Boolean;
begin
  {$IFDEF D2006}
  result := ContainsText(aText, aSubText);
  {$ELSE}
  result := AnsiContainsText(aText, aSubText);
  {$ENDIF}
end;

function IsAuthenticationHeader(aHeaders: TIdHeaderList): Boolean;
begin
  result := sgcMatchesMask(DecodeGETHeader(aHeaders), 'GET /sgc/req/auth/*');
end;

function IsWebsocketAuthenticationHeader(aHeaders: TIdHeaderList): Boolean;
begin
  result := IsWebSocketHeader(aHeaders);
  if result then
    result := sgcMatchesMask(DecodeGETHeader(aHeaders), 'GET /sgc/auth/*');
end;

function IsRequestAuthenticationSessionHeader(aHeaders: TIdHeaderList): Boolean;
begin
  result := sgcMatchesMask(DecodeGETHeader(aHeaders), 'GET ' + CS_REQ_AUTH_SESSION + '*');
end;

function IsAuthenticationURLHeader(aHeaders: TIdHeaderList): Boolean;
begin
  result := sgcMatchesMask(DecodeGETHeader(aHeaders), 'GET ' + CS_AUTH_URL + '*');
end;

function IsAuthenticationSessionHeader(aHeaders: TIdHeaderList): Boolean;
begin
  result := sgcMatchesMask(DecodeGETHeader(aHeaders), 'GET ' + CS_AUTH_SESSION + '*');
end;


function sgcMatchesMask(const Filename, Mask: string): Boolean;
begin
  {$IFDEF LAZARUS}
  Result := IsWild(FileName, Mask, True);
  {$ELSE}
  Result := MatchesMask(FileName, Mask);
  {$ENDIF}
end;

constructor TsgcDelimitedStringList.Create;
begin
  inherited;
  Delimiter := ',';
  {$IFDEF D2006}
  StrictDelimiter := True;
  {$ENDIF}
end;

{$IFNDEF D2009}

procedure TsgcStringStream.DoBytes;
begin
  SetLength(FBytes, Length(DataString));
  if Length(FBytes) > 0 then
    Move(DataString[1], FBytes[0], Length(DataString));
end;

function TsgcStringStream.GetBytes: TIdBytes;
begin
  if (DataString <> '') and (Length(FBytes) = 0) then
    DoBytes;
  Result := FBytes;
end;

function TsgcStringStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := inherited Write(Buffer, Count);
  DoBytes;
end;

{$ENDIF}



end.
