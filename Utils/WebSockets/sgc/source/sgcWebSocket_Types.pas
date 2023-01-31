{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Types;

interface

uses
  SysUtils;

{$I sgcVer.inc}

Type
  TOpcode = (opContinuation, opText, opBinary, opClose, opPing, opPong, opNone);
  TwsTransports = (wsWebSockets, wsEmulation);
  TwsSpecification = (spRFC6455, spHixie76);

Type
  TPayload = (pa7bits, pa16bits, pa64bits);

Type
  TwsServerType = (wsTCP, wsHTTP);

Type
  TwsNotifyEvent = (neNoSync, neAsynchronous, neSynchronous);


implementation

end.
