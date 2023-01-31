namespace SBR_Server;

interface

uses
  System.Linq,
  System.Net,
  System.Configuration,
  System.IO;

type
  Program = class
  public
    class var ws: Webserver;
    class method Main(args: array of String): Int32;
    class method SendResponse(request: HttpListenerRequest): String;
    class method IsConsoleApp: Boolean;

  end;


implementation

class method Program.Main(args: array of String): Int32;
begin

  var PortStr: String := ConfigurationManager.AppSettings['Server.Port'];
  if PortStr = '' then PortStr := '8080';

//  var ws: Webserver := new Webserver(@Program.SendResponse,array of String(['http://localhost:'+PortStr+'/SBR/']));
  ws := new Webserver(@Program.SendResponse,array of String(['http://localhost:'+PortStr+'/SBR/']));
  ws.Run();

  Logger.Log('Server running on port: ' + PortStr,'Info');
  if IsConsoleApp then begin
    Console.WriteLine('Press any key to quit.');
    Console.ReadKey();
    ws.Stop();
  end
  else begin
    while ws.Active do begin
      System.Threading.Thread.Sleep(10);
    end;
  end;
end;

class method Program.SendResponse(request: HttpListenerRequest): String;
begin
  //exit String.Format('<HTML><BODY>My web page.<br>{0}</BODY></HTML>', DateTime.Now);
  result := SBR.DoWebRequest(request);
  if result = 'Terminating'then begin
    if IsConsoleApp then
      Environment.Exit(0)
    else
      ws.Stop;

  end;
end;

class method Program.IsConsoleApp: Boolean;
begin
  result := Console.OpenStandardInput(1) ≠ Stream.Null;
end;


end.
