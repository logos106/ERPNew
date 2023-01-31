unit ServerModuleList;

interface

uses
  ServerModuleStubObj, JsonRpcBase, JsonObject;

type

  TERPServerModuleList = class(TServerModuleList)
  private
    fMySQLServer: string;

  public
    constructor Create(aMySQLServer: string);
    destructor Destroy; override;
    procedure LoadModules(aPath: string);
    procedure DoDisconnect(Client: TJsonRpcBase);
    function DoRequest(Client: TJsonRpcBase; ReqJson: TJsonObject; ResJson: TJsonObject = nil): Boolean;
  end;



implementation

uses
  Classes, SysUtils, LogMessageTypes;

{ TERPServerModuleList }

constructor TERPServerModuleList.Create(aMySQLServer: string);
begin
  fMySQLServer := aMySQLServer;
  inherited Create;;
end;

destructor TERPServerModuleList.Destroy;
begin
  inherited;
end;

procedure TERPServerModuleList.DoDisconnect(Client: TJsonRpcBase);
var
  x: Integer;
  stub: TServerModuleStub;
  lst: TList;
begin
  lst := fList.LockList;
  try
    for x := 0 to lst.Count - 1 do begin
      stub := lst[x];
      stub.SendMessage(Integer(Client),'Disconnect');
    end;
  finally
    fList.UnlockList;
  end;
end;

function TERPServerModuleList.DoRequest(Client: TJsonRpcBase; ReqJson,
  ResJson: TJsonObject): boolean;
var
  methName, moduleName: string;
  x: Integer;
  stub: TServerModuleStub;
  s: string;
begin
  Result := False;
  if ReqJson.StringExists('method') then begin
    methName := Lowercase(ReqJson.S['method']);
    x := Pos('.', methName);
    if x > 1 then begin
      moduleName := Copy(methName, 1, x - 1);
      stub := ModuleByName[moduleName];
      if not Assigned(stub) then begin
        stub := ModuleByName['ERPMod' + moduleName];
      end;

      if Assigned(stub) then begin
        Result := True;
        if not stub.SendRequest(Integer(client), ReqJson, ResJson) then begin
          { failed to send, try restarting the module }
          Log('Unable to send a message to ' + stub.ModuleName + ', restarting the module.', ltWarning);
          s := stub.ModuleFileName;
(*
          { don't kill the User Utils Module .. }
          if Pos('ERPModUserUtils',s) > 0 then
            exit;
*)
          Self.RemoveModule(stub);
          Sleep(50);
          if not Self.AddModule(s, fMySQLServer) then begin
            Log('Could not load module ' + s, ltError);
            Result := False;
            Exit;
          end;
          Sleep(50);
          stub := ModuleByName[moduleName];
          if not Assigned(stub) then
            stub := ModuleByName['ERPMod' + moduleName];
          if not Assigned(stub) then begin
            Result := False;
            Log('Could not find module in list: ' + s, ltError);
            Exit;
          end;

          if not stub.SendRequest(Integer(client), ReqJson, ResJson) then begin
            Result := False;
            Log('Could not send message to module ' + stub.ModuleName, ltError);
          end;
        end;
      end else begin
      end;
    end;
  end
  else begin
  end;
end;

procedure TERPServerModuleList.LoadModules(aPath: String);
var
  sr: TSearchRec;
begin
  Log('Looking for ERP Server modules to load ...', ltInfo);

  if DirectoryExists(aPath) then begin
    if FindFirst(aPath + 'ERPMod*.exe', faAnyFile, sr) = 0 then begin
      repeat
        if Self.AddModule(aPath + sr.Name, fMySQLServer) then
          Log('  Loaded module: ' + sr.Name, ltInfo)
        else begin
          Log('  Failed to load module: ' + sr.Name + ', trying again ..', ltError);
          Sleep(10000);
          if Self.AddModule(aPath + sr.Name, fMySQLServer) then
            Log('  Loaded module: ' + sr.Name, ltInfo)
          else begin
            Log('  Failed to load module: ' + sr.Name + ', trying again ..', ltError);
            Sleep(10000);
            if Self.AddModule(aPath + sr.Name, fMySQLServer) then
              Log('  Loaded module: ' + sr.Name, ltInfo)
            else
              Log('  Failed to load module: ' + sr.Name, ltError);
          end;
        end;
      until FindNext(sr) <> 0;
      SysUtils.FindClose(sr);
    end;
  end;
  Log('Done loading modules.', ltInfo);
end;

end.
