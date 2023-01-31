namespace SBR_Server;

interface

uses
  System,
  System.Net,
  System.Threading,
  System.Linq,
  System.Text;

type
  Webserver = public class
  private
    method getActive: Boolean;
    var _listener: HttpListener := new HttpListener();
    var _responderMethod: Func<HttpListenerRequest,String>;
    method Process(o: Object);
  public
    constructor(prefixes: array of String; &method: Func<HttpListenerRequest,String>);
    constructor(&method: Func<HttpListenerRequest,String>; prefixes: array of String);
    method Run;
    method Stop;
    property Active: Boolean read getActive;
   end;

implementation

constructor Webserver(prefixes: array of String; &method: Func<HttpListenerRequest,String>);
begin
  if not HttpListener.IsSupported then begin
    raise new NotSupportedException('Needs Windows XP SP2, Server 2003 or later.');
  end;
  //  URI prefixes are required, for example 
  //  "http://localhost:8080/index/".
  if (prefixes = nil) or (prefixes.Length = 0) then begin
    raise new ArgumentException('prefixes');
  end;
  //  A responder method is required
  if &method = nil then begin
    raise new ArgumentException('method');
  end;
  for each s: String in prefixes do
    _listener.Prefixes.Add(s);
  _responderMethod := &method;
  _listener.Start();
end;

constructor Webserver(&method: Func<HttpListenerRequest,String>; prefixes: array of String);
begin
  Constructor(prefixes,&method);
end;

method Webserver.Process(o: Object);
begin
  var ctx := HttpListenerContext(o);
  try
    try
      var rstr: String := _responderMethod(ctx.Request);
      var buf: array of Byte := Encoding.UTF8.GetBytes(rstr);
      ctx.Response.ContentLength64 := buf.Length;
      ctx.Response.OutputStream.Write(buf, 0, buf.Length);
    except
      // supress any exceptions
    end;
  finally
    ctx.Response.OutputStream.Close();
  end;
end;

method Webserver.Run;
begin
  ThreadPool.QueueUserWorkItem(
  method  begin
    //Console.WriteLine('Webserver sunning...');
    try
      while _listener.IsListening do begin
        ThreadPool.QueueUserWorkItem(@Process, _listener.GetContext());
      end;
    except
      // suppress any exceptions
    end;
  end
  );

end;

method Webserver.Stop;
begin
  _listener.Stop();
  _listener.Close();
end;

method Webserver.getActive: Boolean;
begin
  result := _listener.IsListening;
end;

end.
