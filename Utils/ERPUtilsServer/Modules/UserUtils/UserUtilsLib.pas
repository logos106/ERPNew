unit UserUtilsLib;

interface

uses
  JsonObject;


  function UserCanConnect(params: TJsonObject; var msg: string): boolean;

implementation

function UserCanConnect(params: TJsonObject; var msg: string): boolean;
begin
  result:= true;
  { add stuff here }


end;

end.
