{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Const;

interface

{$I sgcVer.inc}

Const
  CS_FR_Continuation = $0;
  CS_FR_Text         = $1;
  CS_FR_Binary       = $2;
  CS_FR_Close        = $8;
  CS_FR_Ping         = $9;
  CS_FR_Pong         = $A;

  CS_Frames: Array [0..5] of Integer = (CS_FR_Continuation, CS_FR_Text, CS_FR_Binary,
    CS_FR_Close, CS_FR_Ping, CS_FR_Pong);

  CS_Deflate_Bytes: Array [0..5] of Byte = ($00, $00, $FF, $FF, $03, $00);
  CS_INFLATE_BUFFER = 4096; //4K
  CS_DEFLATE_BUFFER = 524288; // 512K

Const
  CS_DEFAULT_PORT   = 80;

Const
  CS_HTTP_REQUEST = 'HTTP_REQUEST';

Const
  CS_REQ_AUTH_SESSION = '/sgc/req/auth/session/';
  CS_AUTH_SESSION = '/sgc/auth/session/';
  CS_AUTH_URL = '/sgc/auth/url/';

Const
  CS_PROTOCOL_SGC = 'esegece.com';
  CS_PROTOCOL_DATASET = 'dataset.esegece.com';
  CS_PROTOCOL_WEBRTC = 'webrtc.esegece.com';
  CS_PROTOCOL_WAMP = 'WAMP';

Const
  CS_METHOD = 'method';
  CS_RESULT = 'result';
  CS_PARAMS = 'params';
  CS_MESSAGE = 'message';
  CS_CHANNEL = 'channel';
  CS_ID = 'id';
  CS_GUID = 'guid';
  CS_ERROR = 'error';
  CS_CODE = 'code';
  CS_DATA = 'data';
  CS_JSON_RPC = 'jsonrpc';
  CS_JSONRPC_VERSION = '2.0';

Const
  CS_SGC_BROADCAST = 'sgc@broadcast';
  CS_SGC_SUBSCRIBE = 'sgc@subscribe';
  CS_SGC_UNSUBSCRIBE = 'sgc@unsubscribe';
  CS_SGC_CHANNELS = 'sgc@channels';
  CS_SGC_PROTOCOL = 'sgc@protocol';
  CS_SGC_WEBRTC = 'sgc@webrtc';
  CS_SGC_MESSAGE = 'sgc@message';
  CS_SGC_PUBLISH = 'sgc@publish';
  CS_SGC_EVENT = 'sgc@event';

{ dataset protocol }
Const
  CS_DATASET = 'dataset';
  CS_SGC_DATASET = 'sgc@dataset';
  CS_SGC_DATASET_NEW = 'sgc@dataset@new';
  CS_SGC_DATASET_DELETE = 'sgc@dataset@delete';
  CS_SGC_DATASET_UPDATE = 'sgc@dataset@update';
{ dataset protocol }

{ wamp protocol }
Const
  CS_WAMP_VERSION = 1;
Const
  CS_WAMP_WELCOME = 0;
  CS_WAMP_PREFIX = 1;
  CS_WAMP_CALL = 2;
  CS_WAMP_CALLRESULT = 3;
  CS_WAMP_CALLERROR = 4;
  CS_WAMP_SUBSCRIBE = 5;
  CS_WAMP_UNSUBSCRIBE = 6;
  CS_WAMP_PUBLISH = 7;
  CS_WAMP_EVENT = 8;
{ wamp protocol }

{ close codes }
Const
  CS_CLOSE_NORMAL = 1000;
  CS_CLOSE_GOING_AWAY = 1001;
  CS_CLOSE_PROTOCOL_ERROR = 1002;
  CS_CLOSE_UNSUPPORTED_DATA = 1003;
  CS_CLOSE_RESERVED = 1004;
  CS_CLOSE_NO_STATUS_RECEIVED = 1005;
  CS_CLOSE_ABNORMAL_CLOSURE = 1006;
  CS_CLOSE_INVALID_PAYLOAD_DATA = 1007;
  CS_CLOSE_POLICY_VIOLATION = 1008;
  CS_CLOSE_MESSAGE_TOO_BIG = 1009;
  CS_CLOSE_MANDATORY_EXTENSION = 1010;
  CS_CLOSE_INTERNAL_SERVER_ERROR = 1011;
  CS_CLOSE_TLS_HANDSHAKE = 1015;
{ close codes }

{ json-rpc 2.0 }
const
  CS_JSONRPC_PARSE_ERROR = -32700;
  CS_JSONRPC_INVALID_REQUEST = -32600;
  CS_JSONRPC_METHOD_NOT_FOUND = -32601;
  CS_JSONRPC_INVALID_PARAMS = -32602;
  CS_JSONRPC_INTERNAL_ERROR = -32603;
  CS_JSONRPC_SERVER_ERROR = -32000;

resourcestring
  S_JSONRPC_PARSE_ERROR = 'Parse error. Invalid JSON was received by the server.';
  S_JSONRPC_INVALID_REQUEST = 'Invalid Request. The JSON sent is not a valid Request object.';
  S_JSONRPC_METHOD_NOT_FOUND = 'Method not found. The method does not exist / is not available.';
  S_JSONRPC_INVALID_PARAMS = 'Invalid params. Invalid method parameter(s)';
  S_JSONRPC_INTERNAL_ERROR = 'Internal JSON-RPC error.';
  S_JSONRPC_SERVER_ERROR = 'Server error.';
{ json-rpc 2.0 }

{ resource strings }
resourcestring
  S_AUTHENTICATION_DENIED = 'Authentication Denied';
  S_CONTROL_FRAMES_UP_125 = 'Control frames are only allowed to have payload up to and including 125 octets';
  S_ERROR_DECODING_GET = 'Error Decoding Header: GET';
  S_ERROR_DECODING_HOST = 'Error Decoding Header: Host';
  S_ERROR_DECODING_ORIGIN = 'Error Decoding Header: Origin';
  S_ERROR_DECODING_SEC_WEBSOCKET_KEY = 'Error decoding sec-webSocket-key.';
  S_ERROR_DECODING_SWITCHING_PROTOCOLS = 'Error Decoding Header: Switching Protocols';
  S_ERROR_DECODING_UPGRADE = 'Error Decoding Header: Upgrade';
  S_ERROR_DECODING_WEBSOCKET = 'Error Decoding Header: WebSocket';
  S_ERROR_DECODING_WEBSOCKET_KEY = 'Error Decoding Header: WebSocket-Key';
  S_ERROR_DECODING_WEBSOCKET_KEY1 = 'Error Decoding Header: WebSocket-Key1';
  S_ERROR_DECODING_WEBSOCKET_KEY2 = 'Error Decoding Header: WebSocket-Key2';
  S_ERROR_DECODING_WEBSOCKET_VERSION = 'Error Decoding Header: WebSocket Version';
  S_ERROR_DEFLATING_FRAME = 'Error Deflating Frame.';
  S_ERROR_INFLATING_FRAME = 'Error Inflating Frame.';
  S_HEARTBEAT_TIMEOUT_EXCEEDED = 'HeartBeat Timeout exceeded.';
  S_INVALID_ACCEPT_KEY = 'Handshake Error: Invalid Accept Key';
  S_INVALID_CLOSE_CODE = 'Invalid close code';
  S_INVALID_OPTCODE = 'Invalid Control OptCode';
  S_INVALID_PAYLOAD_LENGTH_CLOSE = 'Invalid Payload length for close code';
  S_INVALID_RSV_NO_EXTENSION = 'Invalid value of RSV while no Extension Negotiated';
  S_INVALID_UTF8_MESSAGE = 'Invalid UTF8 message';
  S_INVALID_WINDOWBITS = 'Invalid Value for WindowBits %d';
  S_MESSAGE_NOT_MASKED = 'Message is not masked';
  S_NORMAL_CLOSE_CODE = 'Normal close code';
  S_OPBINARY_AFTER_CONTINUATION_UNFINISHED = 'OpCode error, received opBinary after Continuation not finished';
  S_OPTCODE_MUST_NOT_FRAGMENTED = 'Control Message must not be fragmented';
  S_OPTEXT_AFTER_CONTINUATION_UNFINISHED = 'OpCode error, received opText after Continuation not finished';
  S_ORIGIN_NOT_ALLOWED = 'Origin %s not allowed';
  S_PAYLOAD_NOT_CORRECT = 'PayLoad is not correct';
  S_PONG_DIFFERENT_PING = 'Received Pong is different from Sent Ping';
  S_PROTOCOL_NOT_SUPPORTED = 'Protocol not supported.';
  S_PROTOCOL_UNSUPPORTED = 'Error Protocol: %s not supported.';
  S_UNABLE_GET_SESSION_SOCKETIO = 'Unable to Get Session Id from socket.io server';
  S_UNFRAGMENTED_MESSAGE_AFTER_FIN = 'Unfragmented message after continuation frame with FIN';
{ resource strings }


{ sgc }
Const
  CS_APPLICATION_NAME = 'sgcWebSockets';
  CS_VERSION = '2.3';
{ sgc }
  
implementation

end.
