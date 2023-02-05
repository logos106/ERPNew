unit UtilsServerUtils;

interface

uses
  JsonObject;


  function GetModuleList(const aServer: string): TJsonObject;
  function ModuleInstalled(const aServer, aModuleName: string): boolean;

implementation

uses
  JsonRpcTcpClient, sysutils;

function GetModuleList(const aServer: string): TJsonObject;
var
  Client: TJsonRpcTcpClient;
  obj: TJsonObject;
begin
  result:= nil;
  Client:= TJsonRpcTcpClient.Create;
  try
    Client.RequestWaitSecs:= 15;
    Client.ServerName:= aServer;
    try
      Client.Connected:= true;
      obj:= Client.SendRequestRetry('getmodules',nil);
      if Assigned(obj) and obj.ObjectExists('result') then begin
        try
          result:= JO;
          result.Assign(obj.O['result'].O['ModuleList']);
        finally
        end;
      end;
    except
      raise;
    end;
  finally
    Client.Free;
  end;
end;

function ModuleInstalled(const aServer, aModuleName: string): boolean;
var
  json: TJsonObject;
  x: Integer;
begin
  Result := False;
  json := nil;

  try
    json := GetModuleList(aServer);
    if Assigned(json) and json.ArrayExists('Items') then begin
      for x := 0 to json.A['Items'].Count - 1 do begin
        if SameText(aModuleName, json.A['Items'].Items[x].AsObject.O['Module'].S['ModuleName']) or
           SameText('ERPMod' + aModuleName,json.A['Items'].Items[x].AsObject.O['Module'].S['ModuleName']) then begin
          Result:= true;
          Exit;
        end;
      end;
    end;
  finally
    json.Free;
  end;
end;

end.
