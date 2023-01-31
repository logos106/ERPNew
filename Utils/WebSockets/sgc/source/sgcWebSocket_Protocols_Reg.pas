{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocols_Reg;

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
  sgcIWWebSocket_Protocols,
  {$ENDIF}
  sgcWebSocket,
  sgcWebSocket_Protocols;

  procedure Register;

implementation

procedure Register;
begin
  Classes.RegisterComponents('SGC WebSockets Protocols',
    [
      {$IFDEF IWIX}
      TsgcIWWSPClient_sgc, TsgcIWWSPClient_Dataset,
      {$ENDIF}
      TsgcWSPServer_sgc, TsgcWSPClient_sgc,
      TsgcWSPServer_Dataset, TsgcWSPClient_Dataset,
      TsgcWSPServer_WebRTC,
      TsgcWSPServer_WAMP, TsgcWSPClient_WAMP
    ]
  );
end;

end.
