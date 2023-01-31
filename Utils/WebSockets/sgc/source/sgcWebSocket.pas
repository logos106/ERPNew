{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket;

interface

uses
  Classes,
  sgcWebSocket_Server, sgcWebSocket_Client, sgcWebSocket_Client_SocketIO;

type
  TsgcWebSocketServer = class(TsgcWSServer)
  published
    property Active;
    property Port;

    property OnConnect;
    property OnMessage;
    property OnBinary;
    property OnDisconnect;
    property OnError;
    property OnHandshake;

    property OnException;

    property OnConnectionData;

    property Authentication;
    property OnAuthentication;

    property Bindings;
    property MaxConnections;
    property SSL;
    property SSLOptions;
    property ThreadPool;
    property ThreadPoolOptions;

    property Extensions;
    property Options;
    property SecurityOptions;
    property Specifications;
    property NotifyEvents;

    property Version;
  end;

  TsgcWebSocketHTTPServer = class(TsgcWSHTTPServer)
  published
    property Active;
    property Port;

    property OnConnect;
    property OnMessage;
    property OnBinary;
    property OnDisconnect;
    property OnError;
    property OnHandshake;

    property OnCommandGet;
    property OnCommandOther;
    property OnSessionStart;
    property OnSessionEnd;

    property OnException;

    property OnConnectionData;

    property Authentication;
    property OnAuthentication;

    property AutoStartSession;
    property Bindings;
    property DocumentRoot;
    property KeepAlive;
    property MaxConnections;
    property SessionTimeOut;
    property SSL;
    property SSLOptions;
    property ThreadPool;
    property ThreadPoolOptions;

    property Extensions;
    property Options;
    property SecurityOptions;
    property Specifications;
    property NotifyEvents;

    property Version;
  end;

  TsgcWebSocketClient = class(TsgcWSClient)
  published
    property Active;
    property Host;
    property Port;
    property TLS;
    property Proxy;
    property HeartBeat;

    property OnConnect;
    property OnMessage;
    property OnBinary;
    property OnDisconnect;
    property OnError;
    property OnHandshake;

    property OnException;

    property Authentication;

    property Extensions;
    property Options;
    property Specifications;
    property NotifyEvents;

    property Version;
  end;


  TsgcWebSocketClient_SocketIO = class(TsgcWSClient_SocketIO)
  published
    property Active;
    property Host;
    property Port;
    property TLS;
    property Proxy;
    property HeartBeat;

    property OnConnect;
    property OnMessage;
    property OnBinary;
    property OnDisconnect;
    property OnError;
    property OnHandshake;

    property OnException;    

    property Extensions;    
    property Options;    
    property Specifications;
    property NotifyEvents;

    property Version;
  end;



implementation

end.
