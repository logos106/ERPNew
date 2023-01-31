program ServiceGuiServerTest;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  datSvcControlServer in 'datSvcControlServer.pas' {SvcControlServer: TDataModule},
  AppVarsObj in '..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas';

type
  TSimpleObject = class(TObject)
  public
    procedure DoOnGetPropertyStr(const propName: string; var propValue: string);
    procedure DoOnSetPropertyStr(const propName, propValue: string);
  end;

var
  inStr: String;
  server: TSvcControlServer;
  obj: TSimpleObject;

{ TSimpleObject }

procedure TSimpleObject.DoOnGetPropertyStr(const propName: string;
  var propValue: string);
begin
  PropValue:= 'You requested property: ' + propName;
end;

procedure TSimpleObject.DoOnSetPropertyStr(const propName, propValue: string);
begin
  WriteLn('You are setting property: ' + propName + '  with value: ' + propValue);
end;



begin
  { TODO -oUser -cConsole Main : Insert code here }
  server:= TSvcControlServer.Create(nil);
  obj:= TSimpleObject.Create;
  try
    Server.OnGetProperty:= obj.DoOnGetPropertyStr;
    Server.OnSetProperty:= obj.DoOnSetPropertyStr;
    WriteLn('Starting server ...');
    server.Active:= true;
    WriteLn('Hit return to terminate');

    ReadLn(inStr);


  finally
    server.Free;
    obj.Free;
  end;
end.
