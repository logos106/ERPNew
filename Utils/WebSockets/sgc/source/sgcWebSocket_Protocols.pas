{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocols;

interface

uses
  Classes,
  sgcWebSocket_Protocol_sgc_Client, sgcWebSocket_Protocol_sgc_Server,
  sgcWebSocket_Protocol_Dataset_Client, sgcWebSocket_Protocol_Dataset_Server,
  sgcWebSocket_Protocol_WebRTC_Server,
  sgcWebSocket_Protocol_WAMP_Client, sgcWebSocket_Protocol_WAMP_Server;

type
  TsgcWSPServer_sgc = class(TsgcWSProtocol_sgc_Server)
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;
    property OnSubscription;
    property OnUnSubscription;

    property RPCAuthentication;

    property OnNotification;
    property OnRPC;
    property OnRPCAuthentication;

    property Server;

    property Guid;
    property Version;
  end;

  TsgcWSPClient_sgc = class(TsgcWSProtocol_sgc_Client)
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;
    property OnSubscription;
    property OnUnSubscription;

    property OnRPCResult;
    property OnRPCError;
    property OnEvent;

    property Client;

    property Version;
  end;


  TsgcWSPServer_Dataset = class(TsgcWSProtocol_Dataset_Server)
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;
    property OnSubscription;
    property OnUnSubscription;

    property Server;
    property Dataset;

    property Guid;    
    property Version;
  end;

  TsgcWSPClient_Dataset = class(TsgcWSProtocol_Dataset_Client)
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;
    property OnSubscription;
    property OnUnSubscription;

    property OnAfterNewRecord;
    property OnAfterUpdateRecord;
    property OnAfterDeleteRecord;

    property Client;
    property Dataset;

    property AutoSubscribe;

    property Version;
  end;


  TsgcWSPServer_WebRTC = class(TsgcWSProtocol_WebRTC_Server)
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;
    property OnSubscription;
    property OnUnSubscription;

    property Server;

    property Guid;
    property Version;
  end;


 TsgcWSPServer_WAMP = class(TsgcWSProtocol_WAMP_Server)
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;

    property OnSubscription;
    property OnUnSubscription;
    property OnCall;
    property OnPrefix;

    property Server;

    property Guid;
    property Version;
  end;

  TsgcWSPClient_WAMP = class(TsgcWSProtocol_WAMP_Client)
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;

    property OnWelcome;
    property OnCallResult;
    property OnCallError;
    property OnEvent;

    property Client;

    property Version;
  end;

implementation

end.
