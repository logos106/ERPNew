unit ClientServerLib;
interface

uses
  JsonObject;

  function ClientCanConnect(params: TJsonObject; var msg: string): boolean;

implementation

function ClientCanConnect(params: TJsonObject; var msg: string): boolean;
begin
  result:= true;
  { add stuff here }


end;

end.
