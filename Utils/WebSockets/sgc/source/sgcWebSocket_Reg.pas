{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Reg;

interface

{$I sgcVer.inc}

uses
  Classes,
  {$IFDEF LAZARUS}
  PropEdits, ComponentEditors,
  {$ELSE}
  DesignEditors, DesignIntf,
  {$ENDIF}
  {$IFDEF IWIX}
  sgcIWWebSocket,
  {$ENDIF}
  sgcWebSocket;

  procedure Register;

implementation

procedure Register;
begin
  Classes.RegisterComponents('SGC WebSockets',
    [
      {$IFDEF IWIX}
      TsgcIWWebSocketClient,
      {$ENDIF}
      TsgcWebSocketServer,
      TsgcWebSocketHTTPServer,
      TsgcWebSocketClient,
      TsgcWebSocketClient_SocketIO
    ]
  );
end;

end.
