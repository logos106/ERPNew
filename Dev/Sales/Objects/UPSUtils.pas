unit UPSUtils;

interface

uses
  SysUtils;

type

  TUPSError = class
  public
    ErrorNumber: string;
    ErrorName: string;
    ErrorNameHuman: string;
    ErrorCode: string;
    ErrorDesc: string;
    constructor Create(ex: exception);
  end;

implementation

uses
  types, StrUtils, Character;

(*
  Example of message from UPS exceotion:

  527: AuthenticationError:[250003] Invalid Access License number.
  Error occurred on: /soap:Envelope[1]/soap:Header[1]/UPSSecurity[1]/ServiceAccessToken[1]/AccessLicenseNumber[1]

*)

{ TUPSError }

constructor TUPSError.Create(ex: exception);
var
  arr: TStringDynArray;
  x: integer;
  s: string;
begin
  ErrorNumber := '';
  ErrorName := '';
  ErrorNameHuman := '';
  ErrorCode := '';
  ErrorDesc := '';
  arr := StrUtils.SplitString(ex.Message, #13#10);
  { we are only interested in the first line .. }
  if High(arr) < 0  then exit;
  { split up first line }
  arr := StrUtils.SplitString(arr[0], ':');
  if High(arr) >= 0 then ErrorNumber := arr[0];
  if High(arr) >= 1 then begin
    ErrorName := Trim(arr[1]);
    for x := 1 to Length(ErrorName) do begin
      if (x > 1) and TCharacter.IsUpper(ErrorName[x]) then
        ErrorNameHuman := ErrorNameHuman + ' ';
      ErrorNameHuman := ErrorNameHuman + ErrorName[x];
    end;
  end;
  if High(arr) >= 2 then begin
    s := Trim(arr[2]);
    x:= Pos(']',s);
    if (s[1] = '[') and (x > 0)  then begin
      ErrorCode := Copy(s,2,x-2);
      ErrorDesc := Trim(Copy(s,x+1,Length(s)));
    end
    else
      ErrorDesc := s;
  end;




end;

end.
