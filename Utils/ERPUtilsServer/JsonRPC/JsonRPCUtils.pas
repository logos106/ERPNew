unit JsonRPCUtils;

interface

uses
  JsonObject;

  procedure AddResultOk(aResponse: TJsonObject);
  procedure AddResultError(aResponse: TJsonObject; aMessage: string; aCode: integer = -1);


implementation

procedure AddResultOk(aResponse: TJsonObject);
begin
  if Assigned(aResponse) then
   aResponse.S['result']:= 'ok';
end;


procedure AddResultError(aResponse: TJsonObject; aMessage: string; aCode: integer = -1);
begin
  if Assigned(aResponse) then begin
    aResponse.O['error'].S['message'] := aMessage;
    aResponse.O['error'].I['code'] := aCode;
  end;
end;


end.
