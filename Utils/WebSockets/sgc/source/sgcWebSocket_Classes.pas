{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Classes;

interface

{$I sgcVer.inc}

uses
  Classes, Contnrs, Math, SysUtils, StrUtils,
  // indy
  IdTCPConnection, {$IFDEF INDY10_5_7}IdHashSHA, IdGlobalProtocols{$ELSE}IdHashSHA1{$ENDIF},
  IdGlobal, IdSync, IdHashMessageDigest, IdHeaderList,
  // macos
  {$IFDEF MACOS}
  types,
  {$ENDIF}
  // websocket
  sgcWebSocket_Extensions, sgcWebSocket_Types, sgcWebSocket_Helpers, sgcWebSocket_Const;

type

  TsgcWSConnection = Class;

  TsgcWSProtocol = class;
  TsgcWS_ProtocolClass = Class of TsgcWSProtocol;  

  TsgcWSMessageEvent = procedure(Connection: TsgcWSConnection; const Text:
      string) of object;
  TsgcWSBinaryEvent = procedure(Connection: TsgcWSConnection; const Data: TMemoryStream) of object;
  TsgcWSConnectEvent = procedure(Connection: TsgcWSConnection) of object;
  TsgcWSDisconnectEvent = procedure(Connection: TsgcWSConnection; Code: Integer) of object;
  TsgcWSErrorEvent = procedure(Connection: TsgcWSConnection; const Error: string)
      of object;
  TsgcWSSubscriptionEvent = procedure(Connection: TsgcWSConnection; const Subscription: String) of object;
  TsgcWSHandshakeEvent = procedure(Connection: TsgcWSConnection; var Headers: TStringList) of object;
  TsgcWSUpdateEvent = procedure(Connection: TsgcWSConnection; aType: Integer) of object;
  TsgcWSConnectionDataEvent = procedure(Connection: TsgcWSConnection; var aData:
      TObject) of object;

  TsgcExceptionEvent = procedure(Connection: TsgcWSConnection; E: Exception) of object;

  TsgcWSException = class(Exception)
  end;

  TsgcObjectList = class(TObjectList)
  public
    procedure AddNotifyObject(aConnection: TsgcWSConnection); overload;
    procedure AddNotifyObject(aConnection: TsgcWSConnection; aParam: String);
        overload;
    procedure AddNotifyObject(aConnection: TsgcWSConnection; aParam, aParam2:
        String); overload;
    procedure AddNotifyObject(aConnection: TsgcWSConnection; aParam, aParam2,
        aParam3: String); overload;
    procedure AddNotifyObject(aConnection: TsgcWSConnection; aParam, aParam2,
        aParam3, aParam4: String); overload;
    procedure AddNotifyObject(aConnection: TsgcWSConnection; aParam: Integer);
        overload;
    procedure AddNotifyObject(aConnection: TsgcWSConnection; aParam: TMemoryStream);
        overload;
  end;

  TsgcNotifyObject = class
  private
    FConnection: TsgcWSConnection;
    FInt: Integer;
    FStream: TMemoryStream;
    FText: String;
    FText2: string;
    FText3: string;
    FText4: String;
  protected
    function GetStream: TMemoryStream;
  public
    destructor Destroy; override;
  public
    property Connection: TsgcWSConnection read FConnection write FConnection;
    property Int: Integer read FInt write FInt;
    property Stream: TMemoryStream read GetStream write FStream;
    property Text: String read FText write FText;
    property Text2: string read FText2 write FText2;
    property Text3: string read FText3 write FText3;
    property Text4: String read FText4 write FText4;
  end;

  TsgcWSDrafts = class(TPersistent)
  private
    FHixie76: Boolean;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property Hixie76: Boolean read FHixie76 write FHixie76;
  end;

  TsgcWSSpecifications = class(TPersistent)
  private
    FDrafts: TsgcWSDrafts;
    FRFC6455: Boolean;
    procedure SetDrafts(const Value: TsgcWSDrafts);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  published
    property Drafts: TsgcWSDrafts read FDrafts write SetDrafts;
    property RFC6455: Boolean read FRFC6455 write FRFC6455;
  end;


  TsgcWSHandshake = class
  { properties }
  protected
    FProtocols: String;
    FExtensions: String;
  public
    property Protocols: String read FProtocols;
    property Extensions: String read FExtensions;
  { properties }

  { keys }
  protected
    function GetWSAccept(const aKey: String): String; overload; // spRFC6455
    function GetWSAccept(aKey1, aKey2, aKey3: String): TIdBytes; overload;
  { keys }

  { constructor }
  public
    constructor Create(aConnection: TIdTCPConnection; aHeaders: TIdHeaderList);
        virtual; abstract;
  { constructor }
  end;

  TMaskArray = array [0..3] of Byte;

  TsgcWSMsg = class
  private
    FContinuation: Boolean;
    FFragmented: Boolean;
    FMaskIndex: Integer;
    FOpCode: TOpcode;
    FPayLoad: TPayLoad;
    FPayLoadLength: Integer;
    FPLState: Integer;
    FReadMasked: Boolean;
    FState: Integer;
    FStream: TStream;
    function GetStream: TStream;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Free;
  protected
    Mask: array [0..3] of Byte;
  public
    procedure Clear;
    procedure ClearStream;
  public
    property Continuation: Boolean read FContinuation write FContinuation;
    property Fragmented: Boolean read FFragmented write FFragmented;
    property MaskIndex: Integer read FMaskIndex write FMaskIndex;
    property OpCode: TOpcode read FOpCode write FOpCode;
    property PayLoad: TPayLoad read FPayLoad write FPayLoad;
    property PayLoadLength: Integer read FPayLoadLength write FPayLoadLength;
    property PLState: Integer read FPLState write FPLState;
    property ReadMasked: Boolean read FReadMasked write FReadMasked;
    property State: Integer read FState write FState;
    property Stream: TStream read GetStream write FStream;
  end;


  TsgcWSConnection = class
  private
  { TCPConnection }
  private
    FTCPConnection: TIdTCPConnection;
    function GetTCPConnection: TIdTCPConnection;
    procedure SetTCPConnection(const Value: TIdTCPConnection);
  protected
    property TCPConnection: TIdTCPConnection read GetTCPConnection write
        SetTCPConnection;
  { TCPConnection }

  { extensions }
  private
    FExtensions: TsgcWSExtensions;
  protected
    function GetExtensions: TsgcWSExtensions; virtual;
    procedure SetExtensions(const Value: TsgcWSExtensions); virtual;
  public
    property Extensions: TsgcWSExtensions read GetExtensions write SetExtensions;
  { extensions }

  { message }
  private
    FWSMessage: TsgcWSMsg;
    FWSControlCode: TsgcWSMsg;
    FWSMSG: TsgcWSMsg;
    function GetWSMessage: TsgcWSMsg;
    function GetWSControlCode: TsgcWSMsg;
    function GetWSMSG: TsgcWSMsg;
    procedure SetWSMSG(const Value: TsgcWSMsg);
  protected
    property WSMSG: TsgcWSMsg read GetWSMSG write SetWSMSG;
    property WSMessage: TsgcWSMsg read GetWSMessage write FWSMessage;
    property WSControlCode: TsgcWSMsg read GetWSControlCode write
        FWSControlCode;
  { message }

  { protocol fields }
  private
    FState: Integer;
    FErrorCode: Integer;
    FMsgReceived: String;
    FMsgError: String;
    FSpecification: TwsSpecification;
    FStream: TStream;
    FMsgBinaryReceived: TMemoryStream;
  protected
    property ErrorCode: Integer read FErrorCode;
    function GetMsgBinaryReceived: TMemoryStream;
  public
    property MsgReceived: String read FMsgReceived write FMsgReceived;
    property MsgBinaryReceived: TMemoryStream read GetMsgBinaryReceived write
        FMsgBinaryReceived;
    property MsgError: String read FMsgError write FMsgError;
    property Specification: TwsSpecification read FSpecification write FSpecification;
  { protocol fields }

  { fields }
  private
    FIP: String;
    FPort: Integer;
    FMasked: Boolean;
    FProtocol: String;
    FRecBytes: Integer;
    FSendBytes: Integer;
    FGuid: String;
    FValidateUTF8: Boolean;
    function GetIP: String;
    function GetPort: Integer;
    function GetGuid: String;
  public
    property ValidateUTF8: Boolean read FValidateUTF8 write FValidateUTF8;
    property Masked: Boolean read FMasked write FMasked;
    property Protocol: String read FProtocol write FProtocol;
    property IP: String read GetIP;
    property Port: Integer read GetPort;
    property RecBytes: Integer read FRecBytes write FRecBytes;
    property SendBytes: Integer read FSendBytes write FSendBytes;
    property Guid: String read GetGuid;
  { fields }

  { user session data }
  private
    FData: TObject;
  public
    property Data: TObject read FData;

  { user session data }

  { subscriptions }
  private
    FSubscriptions: TStringList;
    FLastSubscription: String;
    FLastUnSubscription: String;
    function GetSubscriptions: TStringList;
  public
    procedure DoSubscribe(const aChannels: String);
    procedure DoUnSubscribe(const aChannels: String);
  public
    function Subscribed(const aChannel: String): Boolean;
    property Subscriptions: TStringList read GetSubscriptions write FSubscriptions;
    property LastSubscription: String read FLastSubscription write FLastSubscription;
    property LastUnSubscription: String read FLastUnSubscription write FLastUnSubscription;
  { subscriptions }

  { ping / pong }
  private
    FPing: string;
    FLastPong: TDateTime;
  public
    procedure Ping(const aText: string);
  public
    property LastPong: TDateTime read FLastPong write FLastPong;
  { ping / pong }

  { encode }
  private
    function DoEncodeHeader(aOpCode: TOpCode): Byte;
    function DoEncodeMaskingKey: TIdBytes;
    function DoEncodePayLoad(aLength: Int64): TIdBytes;
    function DoEncodeMessage(aBytes, aBytesMsg: TIdBytes): TIdBytes;
  { encode }

  { Handshake }
  private
    FHeadersRequest: TIdHeaderList;
    function GetHeadersRequest: TIdHeaderList;
    function GetHeadersResponse: TStringList;
  protected
    FHeadersResponse: TStringList;
    FEnabled: Boolean;
    procedure DoHandshake; virtual; abstract;
    property HeadersResponse: TStringList read GetHeadersResponse;
    property HeadersRequest: TIdHeaderList read GetHeadersRequest;
  public
    property Enabled: Boolean read FEnabled;
  { Handshake }

  { events }
  protected
    FOnUpdate: TsgcWSUpdateEvent;
    FOnMessage: TsgcWSMessageEvent;
    FOnBinary: TsgcWSBinaryEvent;
    FOnHandshake: TsgcWSHandshakeEvent;
    FOnSubscription: TsgcWSSubscriptionEvent;
    FOnUnSubscription: TsgcWSSubscriptionEvent;
    procedure DoMessageEvent(const aText: String);
    procedure DoBinaryEvent(aData: TMemoryStream);
  public
    property OnUpdate: TsgcWSUpdateEvent read FOnUpdate write FOnUpdate;
    property OnMessage: TsgcWSMessageEvent read FOnMessage write FOnMessage;
    property OnBinary: TsgcWSBinaryEvent read FOnBinary write
        FOnBinary;
    property OnSubscription: TsgcWSSubscriptionEvent read FOnSubscription write FOnSubscription;
    property OnUnSubscription: TsgcWSSubscriptionEvent read FOnUnSubscription write FOnUnSubscription;
    property OnHandshake: TsgcWSHandshakeEvent read FOnHandshake write FOnHandshake;
  { events }

  { write data }
  private
    procedure DoWriteBytes(aBuffer: TIdBytes);
  protected
    procedure DoWriteData_RFC6455(const aText: string; aOpCode: TOpCode); overload;
    procedure DoWriteData_RFC6455(aStream: TStream; aOpCode: TOpCode);
        overload;
    procedure DoWriteData_Hixie76(const aText: string; aOpCode: TOpCode);
  public
    procedure WriteData(const aText: string); overload;
    procedure WriteData(aStream: TMemoryStream); overload;
  { write data }

  { constructor }
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Free;
  { constructor }

  { ReadData }
  private
    procedure DoReadBytes(var aBuffer: TIdBytes; aCount: Integer);
  private
    procedure DoDisconnect(const aError: string = ''; aCloseCode: Integer =
        CS_CLOSE_NORMAL);
    procedure DoWriteWSMSG;
    function IsValidUTF8(aStream: TsgcStringStream): Boolean;
  protected
    function DoReadUTF8(aStream: TStream): String; virtual;
  protected
    procedure DoReadData_RFC6455(aErrorIfNotMasked: Boolean = False);
    procedure DoReadData_Hixie76;
  public
    procedure ReadData(aErrorIfNotMasked: Boolean = False);
  { ReadData }
  end;


  TsgcWSComponent_Base = class(TComponent)
  private
    FNotifyEvents: TwsNotifyEvent;
  private
    FNotifyConnect: TsgcObjectList;
    FNotifyDisconnect: TsgcObjectList;
    FNotifyMessage: TsgcObjectList;
    FNotifyBinary: TsgcObjectList;
    FNotifyError: TsgcObjectList;
  private
    FOnConnect: TsgcWSConnectEvent;
    FOnDisconnect: TsgcWSDisconnectEvent;
    FOnMessage: TsgcWSMessageEvent;
    FOnBinary: TsgcWSBinaryEvent;
    FOnError: TsgcWSErrorEvent;
    FOnException: TsgcExceptionEvent;
    FOnConnectionData: TsgcWSConnectionDataEvent;
  private
    procedure DoAsyncConnect;
    procedure DoAsyncDisconnect;
    procedure DoAsyncMessage;
    procedure DoAsyncBinary;
    procedure DoAsyncError;
  private
    function GetNotifyConnect: TsgcObjectList;
    function GetNotifyDisconnect: TsgcObjectList;
    function GetNotifyMessage: TsgcObjectList;
    function GetNotifyBinary: TsgcObjectList;
    function GetNotifyError: TsgcObjectList;
  private
    function GetVersion: String;
  private
    property NotifyConnect: TsgcObjectList read GetNotifyConnect;
    property NotifyDisconnect: TsgcObjectList read GetNotifyDisconnect;
    property NotifyMessage: TsgcObjectList read GetNotifyMessage;
    property NotifyBinary: TsgcObjectList read GetNotifyBinary;
    property NotifyError: TsgcObjectList read GetNotifyError;
  protected
    procedure DoEventConnect(aConnection: TsgcWSConnection); virtual;
    procedure DoEventDisconnect(aConnection: TsgcWSConnection; Code: Integer);
        virtual;
    procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string);
        virtual;
    procedure DoEventBinary(const aConnection: TsgcWSConnection; Data:
        TMemoryStream); virtual;
    procedure DoEventError(aConnection: TsgcWSConnection; const Error: string);
        virtual;
    procedure DoEventConnectionData(aConnection: TsgcWSConnection; var aData:
        TObject); virtual;
  protected
    procedure DoNotifyConnect(aConnection: TsgcWSConnection); virtual;
    procedure DoNotifyDisconnect(aConnection: TsgcWSConnection); virtual;
    procedure DoNotifyMessage(aConnection: TsgcWSConnection); virtual;
    procedure DoNotifyBinary(aConnection: TsgcWSConnection); virtual;
    procedure DoNotifyError(aConnection: TsgcWSConnection); virtual;
  protected
    procedure DoException(aConnection: TsgcWSConnection; E: Exception); virtual;
  protected
    procedure DoError(aConnection: TsgcWSConnection; E: Exception);
  protected
    function IsDestroying: Boolean;
    function IsLoading: Boolean;
    function IsDesigning: Boolean;
  protected
    property NotifyEvents: TwsNotifyEvent read FNotifyEvents write FNotifyEvents;
  public
    destructor Destroy; override;
  public
    property OnConnect: TsgcWSConnectEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TsgcWSDisconnectEvent read FOnDisconnect write
        FOnDisconnect;
    property OnMessage: TsgcWSMessageEvent read FOnMessage write FOnMessage;
    property OnBinary: TsgcWSBinaryEvent read FOnBinary write FOnBinary;
    property OnError: TsgcWSErrorEvent read FOnError write FOnError;
    property OnException: TsgcExceptionEvent read FOnException write FOnException;
    property OnConnectionData: TsgcWSConnectionDataEvent read FOnConnectionData
        write FOnConnectionData;
  public
    property Version: String read GetVersion;
  end;



  TsgcWSComponent = class(TsgcWSComponent_Base)
  { protocol }
  private
    FProtocolObjectList: TObjectList;
  protected
    function ProtocolRegistered(const aProtocolName: String; aProtocol:
        TsgcWSProtocol): Boolean;
    function GetProtocols: String;
    procedure RegisterProtocol(aObject: TsgcWSProtocol); virtual;
    procedure UnRegisterProtocol(aObject: TsgcWSProtocol); virtual;
  { protocol }

  { specifications }
  private
    FSpecifications: TsgcWSSpecifications;
  protected
    function GetSpecifications: TsgcWSSpecifications; virtual;
    procedure SetSpecifications(const Value: TsgcWSSpecifications); virtual;
  public
    property Specifications: TsgcWSSpecifications read GetSpecifications write
        SetSpecifications;
  { specifications }

  { extensions }
  private
    FExtensions: TsgcWSExtensions;
  protected
    function GetExtensions: TsgcWSExtensions; virtual;
    procedure SetExtensions(const Value: TsgcWSExtensions); virtual;
  public
    property Extensions: TsgcWSExtensions read GetExtensions write SetExtensions;
  { extensions }

  { notify }
  protected
    procedure DoNotifyConnect(aConnection: TsgcWSConnection); override;
    procedure DoNotifyDisconnect(aConnection: TsgcWSConnection); override;
    procedure DoNotifyError(aConnection: TsgcWSConnection); override;
    procedure DoNotifyMessage(aConnection: TsgcWSConnection); override;
    procedure DoNotifyBinary(aConnection: TsgcWSConnection); override;
  { notify }

  { handshake }
  private
    FSyncHandshake: TObjectList;
    function GetSyncHandshake: TObjectList;
  private
    procedure DoAsyncHandshake;
  private
    FOnHandshake: TsgcWSHandshakeEvent;
  protected
    procedure DoEventHandshake(aConnection: TsgcWSConnection; aHeaders:
        TStringList); virtual;
  protected
    procedure DoNotifyHandshake(aConnection: TsgcWSConnection); virtual;
  protected
    property SyncHandshake: TObjectList read GetSyncHandshake;
  public
    property OnHandshake: TsgcWSHandshakeEvent read FOnHandshake write FOnHandshake;
  { handshake }

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TsgcWSComponent_Server = Class(TsgcWSComponent)
  public
    procedure Broadcast(const aMessage: string; const aChannel: string = ''; const
        aProtocol: string = ''; const Exclude: String = ''; const Include: String =
        ''); overload; virtual; abstract;
    procedure Broadcast(aStream: TMemoryStream; const aChannel: string = ''; const
        aProtocol: string = ''; const Exclude: String = ''; const Include: String =
        ''); overload; virtual; abstract;
  public
    constructor Create(aOwner: TComponent); override;
  public
    function WriteData(const aGuid, aMessage: string): Boolean; overload; virtual;
        abstract;
    function WriteData(const aGuid: string; aStream: TMemoryStream): Boolean;
        overload; virtual; abstract;
  End;

  TsgcWSComponent_Client = Class(TsgcWSComponent)
  public
    constructor Create(aOwner: TComponent); override;
  public
    procedure WriteData(const aText: String); overload; virtual; abstract;
    procedure WriteData(const aStream: TMemoryStream); overload; virtual; abstract;
  End;

  TsgcWSProtocol = class(TsgcWSComponent_Base)
  { properties }
  protected
    FGuid: string;
  protected
    FProtocol: string;
  public
    property Protocol: string read FProtocol;
  { properties }

  public
  end;

  TsgcWSProtocol_Client = Class(TsgcWSProtocol)
  { from TComponent }
  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation);
        override;
    procedure Loaded; override;
  { from TComponent }

  { client component }
  private
    FClient: TsgcWSComponent_Client;
  protected
    procedure SetClient(const Value: TsgcWSComponent_Client); virtual;
  public
    property Client: TsgcWSComponent_Client read FClient write SetClient;
  { client component }

  public
    destructor Destroy; override;
  End;

  TsgcWSProtocol_Server = Class(TsgcWSProtocol)

  { from TComponent }
  protected
    procedure Loaded; override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
        override;
  { from TComponent }

  { guid }
  public
    property GUID: String read FGUID write FGUID;
  { guid }

  { server component }
  private
    FServer: TsgcWSComponent_Server;
  protected
    procedure SetServer(const Value: TsgcWSComponent_Server); virtual;
  public
    property Server: TsgcWSComponent_Server read FServer write SetServer;
  { server component }

  public
    destructor Destroy; override;
  End;

// TsgcWSAuthentication_Session //

  TsgcWSAuthentication_Session = class(TPersistent)
  private
    FEnabled: Boolean;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
  end;

// TsgcWSAuthentication_URL //

  TsgcWSAuthentication_URL = class(TPersistent)
  private
    FEnabled: Boolean;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
  end;

// TsgcWSAuthentication_Options //

  TsgcWSAuthentication_Options = class(TPersistent)
  private
    FEnabled: Boolean;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
  end;


implementation

uses
  sgcWebSocket_CS;

{ TsgcWSConnection }

constructor TsgcWSConnection.Create;
begin
  FData := nil;
  FEnabled := False;
  ValidateUTF8 := False;
end;

destructor TsgcWSConnection.Destroy;
begin
  FreeAndNil(FData);
  FreeAndNil(FWSMessage);
  FreeAndNil(FWSControlCode);
  FreeAndNil(FExtensions);
  FreeAndNil(FMsgBinaryReceived);
  FreeAndNil(FSubscriptions);
  FreeAndNil(FHeadersRequest);
  FreeAndNil(FHeadersResponse);
  FWSMSG := nil;
  FTCPConnection := nil;
  inherited;
end;

procedure TsgcWSConnection.DoBinaryEvent(aData: TMemoryStream);
begin
  if Assigned(OnBinary) then
    OnBinary(Self, aData);
end;

procedure TsgcWSConnection.DoDisconnect(const aError: string = ''; aCloseCode:
    Integer = CS_CLOSE_NORMAL);
var
  oStream: TMemoryStream;
  oByte: TIdBytes;
begin

  if not TCPConnection.IOHandler.InputBufferIsEmpty then
    TCPConnection.IOHandler.InputBuffer.Clear;

  oStream := TMemoryStream.Create;
  Try
    oByte := ToBytes(aCloseCode);
    oStream.Write(oByte[1], 1);
    oStream.Write(oByte[0], 1);

    DoWriteData_RFC6455(oStream, opClose);
  Finally
    FreeAndNil(oStream);
  End;

  TCPConnection.Disconnect;
  if aError <> '' then
    raise TsgcWSException.Create(aError);
end;

function TsgcWSConnection.DoEncodeHeader(aOpCode: TOpCode): Byte;
begin
  // ... header
  result := $80 or CS_Frames[Ord(aOpCode)];
  // ... deflate frame
  Extensions.EncodeHeader(result);
end;

function TsgcWSConnection.DoEncodeMaskingKey: TIdBytes;
var
  i: Integer;
begin
  SetLength(result, 4);
  Randomize;
  for i := 0 to 3 do
    result[i] := RandomRange(0, 255);
end;

function TsgcWSConnection.DoEncodePayLoad(aLength: Int64): TIdBytes;

  function GetPayLoad(aLength: Integer): Byte;
  begin
    if Masked then
      result := aLength OR $80
    else
      result := aLength;
  end;

begin
  Case aLength of
    0..125    : begin
                  AppendByte(result, GetPayLoad(aLength));
                end;
    126..65535: begin
                  AppendByte(result, GetPayLoad(126));
                  AppendByte(result, (aLength shr 8) AND $FF);
                  AppendByte(result, aLength AND $FF);
                end;
    else
                begin
                  AppendByte(result, GetPayLoad(127));
                  AppendByte(result, aLength shr 56 and $FF);
                  AppendByte(result, aLength shr 48 and $FF);
                  AppendByte(result, aLength shr 40 and $FF);
                  AppendByte(result, aLength shr 32 and $FF);
                  AppendByte(result, aLength shr 24 and $FF);
                  AppendByte(result, aLength shr 16 and $FF);
                  AppendByte(result, aLength shr 8 and $FF);
                  AppendByte(result, aLength and $FF);
                end;
  End;
end;

function TsgcWSConnection.DoEncodeMessage(aBytes, aBytesMsg: TIdBytes):
    TIdBytes;
var
  i, j: Integer;
  vMask: TIdBytes;
begin
  result := aBytesMsg;

  if Masked then
  begin
    j := 0;
    SetLength(vMask, 4);
    for i := Length(aBytes) - 4 to Length(aBytes) - 1 do
    begin
      vMask[j] := aBytes[i];
      inc(j);
    end;

    for i := 0 to Length(result) - 1 do
      result[i] := result[i] xor vMask[i mod 4];
  end;
end;

procedure TsgcWSConnection.DoMessageEvent(const aText: String);
begin
  if Assigned(OnMessage) then OnMessage(Self, aText);
end;

procedure TsgcWSConnection.DoReadBytes(var aBuffer: TIdBytes; aCount: Integer);
begin
  TCPConnection.IOHandler.ReadBytes(aBuffer, aCount);
  FRecBytes := FRecBytes + aCount;
end;

procedure TsgcWSConnection.DoReadData_Hixie76;
var
  vBuffer: TIdBytes;
begin
  DoReadBytes(vBuffer, 1);
  case FState of
    0:  begin
          if vBuffer[0] = $00 then
            Inc(FState)
          else if vBuffer[0] = $FF then
          begin
            DoReadBytes(vBuffer, 1);
            if vBuffer[0] = $00 then
              DoWriteData_Hixie76('', opClose);
          end
          else
            exit
        end;
    1:  begin
          if vBuffer[0] <> $FF then
          begin
            if not Assigned(FStream) then
              FStream := TsgcStringStream.Create('');
            FStream.Write(vBuffer[0], 1);
          end
          else
          begin
            {$IFDEF INDY10_5_5}
            DoMessageEvent(BytesToString(TsgcStringStream(FStream).Bytes, 0, FStream.size, TIdTextEncoding.UTF8));
            {$ELSE}
              {$IFDEF INDY10_2}
              DoMessageEvent(BytesToString(TsgcStringStream(FStream).Bytes, 0, FStream.size));
              {$ELSE}
              DoMessageEvent(UTF8Decode(TsgcStringStream(FStream).DataString));
              {$ENDIF}
            {$ENDIF}
            FreeAndNil(FStream);
            FState := 0;
          end;
    end;
  end;
end;

procedure TsgcWSConnection.DoReadData_RFC6455(aErrorIfNotMasked: Boolean =
    False);
var
  i: integer;
  vBuffer: TIdBytes;
begin
  case WSMSG.State of
    0:  begin
          DoReadBytes(vBuffer, 1);
          FErrorCode := 0;
          // ... opcode
          WSMSG.Continuation := False;
          case vBuffer[0] and $0F of
            $0:
              begin
                WSMSG := WSMessage;
                WSMSG.Continuation := True;
                if WSMSG.OpCode = opNone then
                  DoDisconnect(S_UNFRAGMENTED_MESSAGE_AFTER_FIN, CS_CLOSE_PROTOCOL_ERROR);
              end;
            $1:
              begin
                if WSMSG.Fragmented then
                  DoDisconnect(S_OPTEXT_AFTER_CONTINUATION_UNFINISHED, CS_CLOSE_PROTOCOL_ERROR);
                WSMessage.OpCode := opText;
                WSMSG := WSMessage;
              end;
            $2:
              begin
                if WSMSG.Fragmented then
                  DoDisconnect(S_OPBINARY_AFTER_CONTINUATION_UNFINISHED, CS_CLOSE_PROTOCOL_ERROR);
                WSMessage.OpCode := opBinary;
                WSMSG := WSMessage;
              end;
            $8:
              begin
                WSControlCode.OpCode := opClose;
                WSMSG := WSControlCode;
              end;
            $9:
              begin
                WSControlCode.OpCode := opPing;
                WSMSG := WSControlCode;
              end;
            $A:
              begin
                WSControlCode.OpCode := opPong;
                WSMSG := WSControlCode;
              end;
            else
              DoDisconnect(S_INVALID_OPTCODE, CS_CLOSE_PROTOCOL_ERROR);
          end;
          // ... fragmented
          WSMSG.Fragmented := (vBuffer[0] and $80) <> $80;

          // ... not allow rsv bits if not extension negotiated (only check if no opContinuation)
          if not WSMSG.Continuation then
          begin
            if (vBuffer[0] and $70) <> $0 then
            begin
              if not Extensions.ExtensionNegotiated then
                DoDisconnect(S_INVALID_RSV_NO_EXTENSION, CS_CLOSE_PROTOCOL_ERROR);
            end;
          end;
           // ... deflate frame
          Extensions.DecodeHeader(vBuffer[0]);
          // ... verify if control optcode is fragmented
          if WSMSG.Fragmented then
          begin
            case WSMSG.OpCode of
              opClose, opPing, opPong:
                DoDisconnect(S_OPTCODE_MUST_NOT_FRAGMENTED, CS_CLOSE_PROTOCOL_ERROR);
              else
                WSMSG.State := WSMSG.State + 1;
            end;
          end
          else
            WSMSG.State := WSMSG.State + 1;
        end;
    1:  begin
          DoReadBytes(vBuffer, 1);
          // mask
          WSMSG.ReadMasked := True;
          if (vBuffer[0] and $80) <> $80 then
          begin
            if aErrorIfNotMasked then
              DoDisconnect(S_MESSAGE_NOT_MASKED, CS_CLOSE_PROTOCOL_ERROR)
            else
              WSMSG.ReadMasked := False;
          end;

          // payload
          WSMSG.MaskIndex := 0;
          WSMSG.PayLoadLength := vBuffer[0] and $7F;
          case WSMSG.PayLoadLength of
            0..125: begin
                      WSMSG.PayLoad := pa7bits;
                      WSMSG.State := WSMSG.State + 1;
                      if not WSMSG.ReadMasked then
                      begin
                        if WSMSG.PayLoadLength > 0 then
                          WSMSG.State := WSMSG.State + 1
                        else
                        begin
                          // ... send message if not fragmented
                          DoWriteWSMSG;
                          exit;
                        end;
                      end;
                    end;
            126   : WSMSG.PayLoad := pa16bits;
            127   : WSMSG.PayLoad := pa64bits;
            else
              DoDisconnect(S_PAYLOAD_NOT_CORRECT);
          end;
          // ... control frames are only allowed to have payload up to and including 125 octets
          case WSMSG.OpCode of
            opClose, opPing, opPong:
              begin
                if WSMSG.PayLoad <> pa7bits then
                  DoDisconnect(S_CONTROL_FRAMES_UP_125, CS_CLOSE_PROTOCOL_ERROR);
              end;
          end;
          WSMSG.State := WSMSG.State + 1;
        end;
    2:  begin
          DoReadBytes(vBuffer, 1);
          case WSMSG.PLState of
            0:  WSMSG.PayLoadLength := vBuffer[0];
            else
              WSMSG.PayLoadLength := WSMSG.PayLoadLength shl 8 or vBuffer[0];
          end;

          if ((WSMSG.PLState = 1) and (WSMSG.PayLoad = pa16bits) or (WSMSG.PLState = 7) and (WSMSG.PayLoad = pa64bits)) then
          begin
            WSMSG.State := WSMSG.State + 1;
            if not WSMSG.ReadMasked then
              WSMSG.State := WSMSG.State + 1;
          end
          else
            WSMSG.PLState := WSMSG.PLState + 1;
        end;
    3:  begin
          DoReadBytes(vBuffer, 1);
          // mask
          WSMSG.Mask[WSMSG.MaskIndex] := vBuffer[0];

          if (WSMSG.MaskIndex = 3) then
          begin
            if WSMSG.PayLoadLength = 0 then
            begin
              if (WSMSG.OpCode = opClose) then // code error is optional
                DoDisconnect
              else
              begin
                // ... send message
                DoWriteWSMSG;
                exit;
              end;
            end
            else
              WSMSG.State := WSMSG.State + 1;
          end
          else
            WSMSG.MaskIndex := WSMSG.MaskIndex + 1;
        end;
    4:  begin
          // ... read all message
          DoReadBytes(vBuffer, WSMSG.PayLoadLength);
          if WSMSG.ReadMasked then
          begin
            for i := 0 to Length(vBuffer) - 1 do
              vBuffer[i] := vBuffer[i] xor WSMSG.Mask[i mod 4];
          end;

          // ... copy to stream
          if WSMSG.OpCode <> opClose then
            WSMSG.Stream.Write(vBuffer[0], WSMSG.PayLoadLength)
          else
          begin
            // ... close code
            if WSMSG.OpCode = opClose then // read close code
            begin
              case Length(vBuffer) of
                0: { optional code };
                1:
                  DoDisconnect(S_INVALID_PAYLOAD_LENGTH_CLOSE, CS_CLOSE_PROTOCOL_ERROR);
                2:
                  begin
                    FErrorCode := vBuffer[0];
                    FErrorCode := FErrorCode shl 8 or vBuffer[1];
                    case FErrorCode of
                      1..999:
                        DoDisconnect(S_INVALID_CLOSE_CODE, CS_CLOSE_PROTOCOL_ERROR);
                      1000..2999:
                        case FErrorCode of
                          CS_CLOSE_RESERVED,
                          CS_CLOSE_NO_STATUS_RECEIVED,
                          CS_CLOSE_ABNORMAL_CLOSURE:
                            DoDisconnect(S_INVALID_CLOSE_CODE, CS_CLOSE_PROTOCOL_ERROR);
                          CS_CLOSE_NORMAL,
                          CS_CLOSE_GOING_AWAY,
                          CS_CLOSE_PROTOCOL_ERROR,
                          CS_CLOSE_UNSUPPORTED_DATA,
                          CS_CLOSE_INVALID_PAYLOAD_DATA,
                          CS_CLOSE_POLICY_VIOLATION,
                          CS_CLOSE_MESSAGE_TOO_BIG,
                          CS_CLOSE_MANDATORY_EXTENSION,
                          CS_CLOSE_INTERNAL_SERVER_ERROR:
                            DoDisconnect(S_NORMAL_CLOSE_CODE, CS_CLOSE_NORMAL);
                          else
                            DoDisconnect(S_INVALID_CLOSE_CODE, CS_CLOSE_PROTOCOL_ERROR);
                        end;
                      3000..4999:
                        DoDisconnect(S_NORMAL_CLOSE_CODE, CS_CLOSE_NORMAL);
                      else
                        DoDisconnect(S_INVALID_CLOSE_CODE, CS_CLOSE_PROTOCOL_ERROR);
                    end;
                  end
                else
                begin
                  WSMSG.Stream.WriteBuffer(vBuffer[2], WSMSG.PayLoadLength - 2);
                  DoReadUTF8(WSMSG.Stream);
                end;
              end;
            end;
          end;
          WSMSG.PayLoadLength := 0;

          // ... extensions
          Extensions.ReadStream(WSMSG.FStream);
          // ... handle message
          DoWriteWSMSG;
        end;
  end;
end;

procedure TsgcWSConnection.DoWriteWSMSG;
begin
  if not WSMSG.Fragmented then
  begin
    WSMSG.Stream.Seek(0, soFromBeginning);

    case WSMSG.OpCode of
      opText:
        DoMessageEvent(DoReadUTF8(WSMSG.Stream));
      opBinary:
        DoBinaryEvent(TMemoryStream(WSMSG.Stream));
      opClose:
        begin
          FEnabled := False;
          if Assigned(FOnUpdate) then FOnUpdate(self, -1);
          DoDisconnect;
        end;
      opPing:
        DoWriteData_RFC6455(TStream(WSMSG.Stream), opPong);
      opPong:
        begin
          if FPing = '' then // do nothing on unsolicited pong
            WSMSG.Clear
          else if DoReadUTF8(WSMSG.Stream) <> FPing then
          begin
            // ... clear
            WSMSG.Clear;
            // ... raise
            DoDisconnect(S_PONG_DIFFERENT_PING)
          end
          else
          begin
            LastPong := Now;
            FPing := '';
          end;
        end;
    end;
    WSMSG.Clear;
  end
  else
  begin
    WSMSG.State := 0;
    WSMSG.PLState := 0;
  end;
end;

procedure TsgcWSConnection.DoSubscribe(const aChannels: String);
var
  oList: TsgcDelimitedStringList;
  i: Integer;
begin
  oList := TsgcDelimitedStringList.Create;
  Try
    oList.DelimitedText := aChannels;
    for i := 0 to oList.Count - 1 do
    begin
      if Subscriptions.IndexOf(oList[i]) = -1 then
      begin
        Subscriptions.Add(oList[i]);
        if Assigned(FOnUpdate) then FOnUpdate(self, 0);       
        if Assigned(FOnSubscription) then FOnSubscription(self, oList[i]);
      end;
    end;
  Finally
    FreeAndNil(oList);
  End;
end;

procedure TsgcWSConnection.DoUnSubscribe(const aChannels: String);
var
  oList: TsgcDelimitedStringList;
  i, j: Integer;
begin
  oList := TsgcDelimitedStringList.Create;
  Try
    oList.DelimitedText := aChannels;
    for i := 0 to oList.Count - 1 do
    begin
      j := Subscriptions.IndexOf(oList[i]);
      if j <> -1 then
      begin
        Subscriptions.Delete(j);
        if Assigned(FOnUpdate) then FOnUpdate(self, 0);        
        if Assigned(FOnUnSubscription) then FOnUnSubscription(self, oList[i]);
      end;
    end;
  Finally
    FreeAndNil(oList);
  End;
end;

procedure TsgcWSConnection.DoWriteBytes(aBuffer: TIdBytes);
begin
  TCPConnection.IOHandler.Write(aBuffer);
  FSendBytes := FSendBytes + Length(aBuffer);
end;

procedure TsgcWSConnection.DoWriteData_Hixie76(const aText: string; aOpCode:
    TOpCode);
var
  Bytes: TIdBytes;
begin
  if ((aOpCode = opText)) or (aOpCode = opClose) then
  begin
    TCPConnection.IOHandler.WriteBufferOpen;
    Try
      if aOpCode = opText then
      begin
        AppendByte(Bytes, $00);
        {$IFDEF INDY10_5_5}
        AppendBytes(Bytes, ToBytes(aText, TIdTextEncoding.UTF8));
        {$ELSE}
        AppendBytes(Bytes, ToBytes(UTF8Encode(aText)));
        {$ENDIF}
        AppendByte(Bytes, $FF);
      end
      else if aOpCode = opClose then
      begin
        AppendByte(Bytes, $FF);
        AppendByte(Bytes, $00);
      end;
      DoWriteBytes(Bytes);
      TCPConnection.IOHandler.WriteBufferFlush;
    Finally
      TCPConnection.IOHandler.WriteBufferClose;
    End;
  end;
end;

procedure TsgcWSConnection.ReadData(aErrorIfNotMasked: Boolean = False);
begin
  if not Enabled then
  begin
    DoHandshake;
    FState := 0;
  end else
  begin
    while not TCPConnection.IOHandler.InputBufferIsEmpty do
    begin
      case Specification of
        spRFC6455: DoReadData_RFC6455(aErrorIfNotMasked);
        spHixie76: DoReadData_Hixie76;
      end;

      // ... check if inputbuffer has grown
      if TCPConnection.IOHandler.InputBufferIsEmpty then
        TCPConnection.IOHandler.CheckForDataOnSource(10);
    end;
  end;
end;

procedure TsgcWSConnection.WriteData(const aText: string);
begin
  if Enabled then
  begin
    if TCPConnection.Connected then
    begin
      case Specification of
        spRFC6455: DoWriteData_RFC6455(aText, opText);
        spHixie76: DoWriteData_Hixie76(aText, opText);
      end;
    end
    else
      FEnabled := False;
  end;
end;

procedure TsgcWSConnection.DoWriteData_RFC6455(const aText: string; aOpCode:
    TOpCode);
var
  Bytes: TIdBytes;
  oStream: TsgcStringStream;
begin
  // ... inflate frame
  if Extensions.DeflateFrame.Enabled then
  begin
    oStream := TsgcStringStream.Create(UTF8Encode(aText));
    Try
      DoWriteData_RFC6455(TStream(oStream), aOpCode);
    Finally
      FreeAndNil(oStream);
    End;
  end
  else
  begin
    // ... write data
    TCPConnection.IOHandler.WriteBufferOpen;
    Try
      AppendByte(Bytes, DoEncodeHeader(aOpCode));
      if aText = #0 then
        AppendBytes(Bytes, DoEncodePayLoad(1))
      else
        {$IFDEF LAZARUS}
        AppendBytes(Bytes, DoEncodePayLoad(Length(sgcStringToBytes(aText))));
        {$ELSE}
        AppendBytes(Bytes, DoEncodePayLoad(Length(UTF8Encode(aText))));
        {$ENDIF}
      if Masked then
        AppendBytes(Bytes, DoEncodeMaskingKey);
      {$IFDEF LAZARUS}
      AppendBytes(Bytes, DoEncodeMessage(Bytes, sgcStringToBytes(aText)));
      {$ELSE}
        {$IFDEF INDY10_5_5}
        AppendBytes(Bytes, DoEncodeMessage(Bytes, ToBytes(aText, TIdTextEncoding.UTF8)));
        {$ELSE}
        AppendBytes(Bytes, DoEncodeMessage(Bytes, ToBytes(UTF8Encode(aText))));
        {$ENDIF}
      {$ENDIF}
      DoWriteBytes(Bytes);
      TCPConnection.IOHandler.WriteBufferFlush;
    Finally
      TCPConnection.IOHandler.WriteBufferClose;
    End;
  end;
end;

procedure TsgcWSConnection.DoWriteData_RFC6455(aStream: TStream; aOpCode:
    TOpCode);
var
  vBytes, vBytesMsg: TIdBytes;
  oStream: TMemoryStream;
begin
  // ... extensions
  oStream := TMemoryStream.Create;
  Try
    // ... copy stream
    aStream.Seek(0, soFromBeginning);
    oStream.CopyFrom(aStream, aStream.Size);
    Extensions.WriteStream(TStream(oStream));
    // ... seek
    oStream.Seek(0, soFromBeginning);
    // ... write data
    TCPConnection.IOHandler.WriteBufferOpen;
    Try
      AppendByte(vBytes, DoEncodeHeader(aOpCode));
      AppendBytes(vBytes, DoEncodePayLoad(oStream.Size));
      if Masked then
        AppendBytes(vBytes, DoEncodeMaskingKey);
      ReadTIdBytesFromStream(oStream, vBytesMsg, oStream.Size);
      AppendBytes(vBytes, DoEncodeMessage(vBytes, vBytesMsg));
      TCPConnection.IOHandler.Write(vBytes);
      TCPConnection.IOHandler.WriteBufferFlush;
    Finally
      TCPConnection.IOHandler.WriteBufferClose;
    End;
  Finally
    FreeAndNil(oStream);
  End;
end;

procedure TsgcWSConnection.Free;
begin
  if Self <> nil then
    Destroy;
end;

function TsgcWSConnection.GetExtensions: TsgcWSExtensions;
begin
  if not Assigned(FExtensions) then
    FExtensions := TsgcWSExtensions.Create;
  Result := FExtensions;
end;

function TsgcWSConnection.GetSubscriptions: TStringList;
begin
  if not Assigned(FSubscriptions) then
    FSubscriptions := TStringList.Create;
  Result := FSubscriptions;
end;

function TsgcWSConnection.GetGuid: String;
begin
  if Assigned(self) then
  begin
    if FGuid = '' then
      FGuid := NewGuid;
    Result := FGuid;
  end;
end;

function TsgcWSConnection.GetHeadersRequest: TIdHeaderList;
begin
  if not Assigned(FHeadersRequest) then
    {$IFDEF INDY10_5_7}
    FHeadersRequest := TIdHeaderList.Create(QuoteHTTP);
    {$ELSE}
    FHeadersRequest := TIdHeaderList.Create;
    {$ENDIF}
  Result := FHeadersRequest;
end;

function TsgcWSConnection.GetHeadersResponse: TStringList;
begin
  if not Assigned(FHeadersResponse) then
    FHeadersResponse := TStringList.Create;
  Result := FHeadersResponse;
end;

function TsgcWSConnection.GetIP: String;
begin
  if Assigned(TCPConnection) then
    if Assigned(TCPConnection.Socket) then
      FIP := TCPConnection.Socket.Binding.PeerIP;

  result := FIP;
end;

function TsgcWSConnection.GetMsgBinaryReceived: TMemoryStream;
begin
  if not Assigned(FMsgBinaryReceived) then
    FMsgBinaryReceived := TMemoryStream.Create;
  Result := FMsgBinaryReceived;
end;

function TsgcWSConnection.GetWSMessage: TsgcWSMsg;
begin
  if not Assigned(FWSMessage) then
    FWSMessage := TsgcWSMsg.Create;
  Result := FWSMessage;
end;

function TsgcWSConnection.GetPort: Integer;
begin
  if Assigned(TCPConnection) then
    if Assigned(TCPConnection.Socket) then
      FPort := TCPConnection.Socket.Binding.PeerPort;

  result := FPort;
end;

function TsgcWSConnection.GetTCPConnection: TIdTCPConnection;
begin
  Result := FTCPConnection;
end;

function TsgcWSConnection.GetWSControlCode: TsgcWSMsg;
begin
  if not Assigned(FWSControlCode) then
    FWSControlCode := TsgcWSMsg.Create;
  Result := FWSControlCode;
end;

function TsgcWSConnection.GetWSMSG: TsgcWSMsg;
begin
  if not Assigned(FWSMSG) then
    FWSMSG := WSMessage;
  Result := FWSMSG;
end;

function TsgcWSConnection.DoReadUTF8(aStream: TStream): String;
begin
  if IsValidUTF8(TsgcStringStream(aStream)) then
  begin
    result := sgcBytesToString(TsgcStringStream(aStream));

    if (result = '') and (aStream.Size > 0) then
      if (result <> #0) then // ... x00
        if (TsgcStringStream(aStream).Bytes[aStream.size - 1] <> $F4) then // ... multibyte
          DoDisconnect(S_INVALID_UTF8_MESSAGE, CS_CLOSE_INVALID_PAYLOAD_DATA);
  end
  else
    DoDisconnect(S_INVALID_UTF8_MESSAGE, CS_CLOSE_INVALID_PAYLOAD_DATA)
end;

function TsgcWSConnection.IsValidUTF8(aStream: TsgcStringStream): Boolean;
var
  i, j: Integer;
begin
  result := True;

  if not ValidateUTF8 then exit;

  if aStream.Size = 0 then exit;

  result := False;

  i := 0;
  j := aStream.Size;
  while i < j do
  begin
    case aStream.Bytes[i] of
      $00..$7F:
        i := i + 1;


      $C2..$DF:
        if (i + 1 < j)
            and ((aStream.Bytes[i + 1]) in [$80..$BF]) then
          i := i + 2
        else
          break;

      $E0:
        if (i + 2 < j)
            and ((aStream.Bytes[i + 1]) in [$A0..$BF])
            and ((aStream.Bytes[i + 2]) in [$80..$BF]) then
          i := i + 3
        else
          break;

      $E1..$EF:
        if (i + 2 < j)
            and ((aStream.Bytes[i + 1]) in [$80..$BF])
            and ((aStream.Bytes[i + 2]) in [$80..$BF]) then
          i := i + 3
        else
          break;

      $F0:
        if (i + 3 < j)
            and ((aStream.Bytes[i + 1]) in [$90..$BF])
            and ((aStream.Bytes[i + 2]) in [$80..$BF])
            and ((aStream.Bytes[i + 3]) in [$80..$BF]) then
          i := i + 4
        else
          break;

      $F1..$F3:
        if (i + 3 < j)
            and ((aStream.Bytes[i + 1]) in [$80..$BF])
            and ((aStream.Bytes[i + 2]) in [$80..$BF])
            and ((aStream.Bytes[i + 3]) in [$80..$BF]) then
          i := i + 4
        else
          break;

      $F4:
        if (i + 3 < j)
            and ((aStream.Bytes[i + 1]) in [$80..$8F])
            and ((aStream.Bytes[i + 2]) in [$80..$BF])
            and ((aStream.Bytes[i + 3]) in [$80..$BF]) then
          i := i + 4
        else if (i + 1 = j) then
          i := i + 1
        else
          break;
    else
      exit;
    end;
  end;

  if i = j then
    Result := True;
end;


procedure TsgcWSConnection.Ping(const aText: string);
begin
  FPing := aText;
  DoWriteData_RFC6455(aText, opPing);
end;

procedure TsgcWSConnection.SetExtensions(const Value: TsgcWSExtensions);
begin
  Extensions.Assign(Value);
end;

procedure TsgcWSConnection.SetTCPConnection(const Value: TIdTCPConnection);
begin
  if Assigned(self) then
    FTCPConnection := Value;
end;

procedure TsgcWSConnection.SetWSMSG(const Value: TsgcWSMsg);
begin
  FWSMSG := Value;
end;

function TsgcWSConnection.Subscribed(const aChannel: String): Boolean;
var
  oList: TsgcDelimitedStringList;
  i: Integer;
begin
  Result := aChannel = '';
  if not Result then
  begin
    oList := TsgcDelimitedStringList.Create;
    Try
      oList.DelimitedText := aChannel;
      for i := 0 to oList.Count - 1 do
      begin
        if Subscriptions.IndexOf(oList[i]) <> -1 then
        begin
          result := True;
          break;
        end;
      end;
    Finally
      FreeAndNil(oList);
    End;
  end;
end;

procedure TsgcWSConnection.WriteData(aStream: TMemoryStream);
begin
  if Enabled then
  begin
    if TCPConnection.Connected then
    begin
      case Specification of
        spRFC6455: DoWriteData_RFC6455(aStream, opBinary);
      end;
    end
    else
      FEnabled := False;
  end;
end;

function TsgcWSHandshake.GetWSAccept(const aKey: String): String;
var
 oHash: TIdHashSHA1;
begin
  oHash := TIdHashSHA1.Create;
  Try
    Result := aKey + '258EAFA5-E914-47DA-95CA-C5AB0DC85B11';
    {$IFDEF INDY10_2}
    Result := HexToBase64(oHash.HashStringAsHex(Result));
    {$ELSE}
    Result := HexToBase64(oHash.AsHex(oHash.HashValue(Result)));
    {$ENDIF}
  Finally
    FreeAndNil(oHash);
  End;
end;

function TsgcWSHandshake.GetWSAccept(aKey1, aKey2, aKey3: String): TIdBytes;

  procedure GetWSKey(const aKey: String; var Numbers, Spaces: Cardinal);
  var
    i: Integer;
    vChar: AnsiChar;
  begin
    Numbers := 0;
    Spaces := 0;
    for i := 1 to Length(aKey) do
    begin
      vChar := AnsiChar(aKey[i]);
      if vChar in ['0'..'9'] then
        Numbers := Cardinal(ord(akey[i])) - Cardinal(ord('0')) + Numbers * 10
      else if vChar = ' ' then
        Spaces := Spaces + 1;
    end;
    if Spaces = 0 then
      raise TsgcWSException.Create(S_ERROR_DECODING_SEC_WEBSOCKET_KEY);
  end;

  function GetMD5(aText: String): String;
  var
    oMD5: TIdHashMessageDigest5;
  begin
    oMD5 := TIdHashMessageDigest5.Create;
    try
    {$IFDEF INDY10_2}
      Result := oMD5.HashBytesAsHex(HexToBytes(aText));
    {$ELSE}
      Result := oMD5.AsHex(oMD5.HashValue(HexToString(aText)));
    {$ENDIF}
    finally
      oMD5.Free;
    end;
  end;

var
  vNumbers: Cardinal;
  vSpaces: Cardinal;
  vKey1, vKey2: String;
begin
  GetWSKey(aKey1, vNumbers, vSpaces);
  vKey1 := IntToHex((vNumbers div vSpaces), 8);
  GetWSKey(aKey2, vNumbers, vSpaces);
  vKey2 := IntToHex((vNumbers div vSpaces), 8);
  result := HexToBytes(GetMD5(vKey1 + vKey2 + aKey3));
end;

destructor TsgcWSComponent_Base.Destroy;
begin
  FreeAndNil(FNotifyConnect);
  FreeAndNil(FNotifyDisconnect);
  FreeAndNil(FNotifyMessage);
  FreeAndNil(FNotifyError);
  inherited;
end;

procedure TsgcWSComponent_Base.DoAsyncConnect;
var
  i: Integer;
begin
  for i := NotifyConnect.Count - 1 Downto 0 do
  begin
    DoEventConnect(TsgcNotifyObject(NotifyConnect.Items[i]).Connection);
    NotifyConnect.Delete(i);
  end;
end;

procedure TsgcWSComponent_Base.DoAsyncDisconnect;
var
  i: Integer;
begin
  for i := NotifyDisconnect.Count - 1 Downto 0 do
  begin
    DoEventDisconnect(TsgcNotifyObject(NotifyDisconnect.Items[i]).Connection,
      TsgcNotifyObject(NotifyDisconnect.Items[i]).Int);
    if Assigned(TsgcNotifyObject(NotifyDisconnect.Items[i]).Connection) then
      TsgcNotifyObject(NotifyDisconnect.Items[i]).Connection.Free;
    NotifyDisconnect.Delete(i);
  end;
end;

procedure TsgcWSComponent_Base.DoAsyncMessage;
var
  i: Integer;
begin
  for i := NotifyMessage.Count - 1 Downto 0 do
  begin
    DoEventMessage(TsgcNotifyObject(NotifyMessage.Items[i]).Connection,
      TsgcNotifyObject(NotifyMessage.Items[i]).Text);
    NotifyMessage.Delete(i);
  end;
end;

procedure TsgcWSComponent_Base.DoAsyncError;
var
  i: Integer;
begin
  for i := NotifyError.Count - 1 Downto 0 do
  begin
    DoEventError(TsgcNotifyObject(NotifyError.Items[i]).Connection,
      TsgcNotifyObject(NotifyError.Items[i]).Text);
    NotifyError.Delete(i);
  end;
end;

procedure TsgcWSComponent_Base.DoAsyncBinary;
var
  i: Integer;
begin
  for i := NotifyBinary.Count - 1 Downto 0 do
  begin
    DoEventBinary(TsgcNotifyObject(NotifyBinary.Items[i]).Connection,
      TsgcNotifyObject(NotifyBinary.Items[i]).Stream);
    NotifyBinary.Delete(i);
  end;
end;

procedure TsgcWSComponent_Base.DoError(aConnection: TsgcWSConnection; E: Exception);
begin
  if Assigned(FOnError) then
  begin
    if Assigned(aConnection) then
    begin
      aConnection.MsgError := E.Message;
      DoNotifyError(aConnection);
      // ... disconnect on error
      if aConnection.TCPConnection.Connected then
        aConnection.TCPConnection.Disconnect;
    end
    else
      DoEventError(nil, E.Message);
  end
  else
  begin
    // ... disconnect on error
    if aConnection.TCPConnection.Connected then
      aConnection.TCPConnection.Disconnect;
    // ... raise exception
    raise E;
  end;
end;

procedure TsgcWSComponent_Base.DoException(aConnection: TsgcWSConnection; E:
    Exception);
begin
  if Assigned(FOnException) then
    FOnException(aConnection, E);
end;

procedure TsgcWSComponent_Base.DoNotifyConnect(aConnection: TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        DoEventConnect(aConnection);
      neAsynchronous:
        begin
          NotifyConnect.AddNotifyObject(aConnection);
          TIdNotify.NotifyMethod(DoAsyncConnect);
        end;
      neSynchronous:
        begin
          NotifyConnect.AddNotifyObject(aConnection);
          TIdSync.SynchronizeMethod(DoAsyncConnect);
        end;
    end;
  end;
end;

procedure TsgcWSComponent_Base.DoNotifyDisconnect(aConnection: TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        begin
          DoEventDisconnect(aConnection, aConnection.ErrorCode);
          FreeAndNil(aConnection);
        end;
      neAsynchronous:
        begin
          NotifyDisconnect.AddNotifyObject(aConnection, aConnection.ErrorCode);
          TIdNotify.NotifyMethod(DoAsyncDisconnect);
        end;
      neSynchronous:
        begin
          NotifyDisconnect.AddNotifyObject(aConnection, aConnection.ErrorCode);
          TIdSync.SynchronizeMethod(DoAsyncDisconnect);
        end;
    end;
  end;
end;

procedure TsgcWSComponent_Base.DoNotifyError(aConnection: TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        DoEventError(aConnection, aConnection.MsgError);
      neAsynchronous:
        begin
          NotifyError.AddNotifyObject(aConnection, aConnection.MsgError);
          TIdNotify.NotifyMethod(DoAsyncError);
        end;
      neSynchronous:
        begin
          NotifyError.AddNotifyObject(aConnection, aConnection.MsgError);
          TIdSync.SynchronizeMethod(DoAsyncError);
        end;
    end;
  end;
end;

procedure TsgcWSComponent_Base.DoNotifyMessage(aConnection: TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        DoEventMessage(aConnection, aConnection.MsgReceived);
      neAsynchronous:
        begin
          NotifyMessage.AddNotifyObject(aConnection, aConnection.MsgReceived);
          TIdNotify.NotifyMethod(DoAsyncMessage);
        end;
      neSynchronous:
        begin
          NotifyMessage.AddNotifyObject(aConnection, aConnection.MsgReceived);
          TIdSync.SynchronizeMethod(DoAsyncMessage);
        end;
    end;
  end;
end;

procedure TsgcWSComponent_Base.DoNotifyBinary(aConnection:
    TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        DoEventBinary(aConnection, aConnection.MsgBinaryReceived);
      neAsynchronous:
        begin
          NotifyBinary.AddNotifyObject(aConnection, aConnection.MsgBinaryReceived);
          TIdNotify.NotifyMethod(DoAsyncBinary);
        end;
      neSynchronous:
        begin
          NotifyBinary.AddNotifyObject(aConnection, aConnection.MsgBinaryReceived);
          TIdSync.SynchronizeMethod(DoAsyncBinary);
        end;
    end;
  end;
end;

procedure TsgcWSComponent_Base.DoEventBinary(const aConnection:
    TsgcWSConnection; Data: TMemoryStream);
begin
  if Assigned(FOnBinary) then
    FOnBinary(aConnection, Data);
end;

procedure TsgcWSComponent_Base.DoEventConnect(aConnection: TsgcWSConnection);
begin
  if Assigned(FOnConnect) then FOnConnect(aConnection);

  DoEventConnectionData(aConnection, aConnection.FData);
end;

procedure TsgcWSComponent_Base.DoEventDisconnect(aConnection: TsgcWSConnection;
    Code: Integer);
begin
  if Assigned(FOnDisconnect) then
    FOnDisconnect(aConnection, Code);
end;

procedure TsgcWSComponent_Base.DoEventError(aConnection: TsgcWSConnection;
    const Error: string);
begin
  if Assigned(FOnError) then
    FOnError(aConnection, Error);
end;

procedure TsgcWSComponent_Base.DoEventMessage(aConnection: TsgcWSConnection;
    const Text: string);
begin
  if Assigned(FOnMessage) then
    FOnMessage(aConnection, Text);
end;

procedure TsgcWSComponent_Base.DoEventConnectionData(aConnection:
    TsgcWSConnection; var aData: TObject);
begin
  if Assigned(FOnConnectionData) then
    FOnConnectionData(aConnection, aData);
end;

function TsgcWSComponent_Base.GetNotifyConnect: TsgcObjectList;
begin
  if not Assigned(FNotifyConnect) then
    FNotifyConnect := TsgcObjectList.Create(True);
  Result := FNotifyConnect;
end;

function TsgcWSComponent_Base.GetNotifyDisconnect: TsgcObjectList;
begin
  if not Assigned(FNotifyDisconnect) then
    FNotifyDisconnect := TsgcObjectList.Create(True);
  Result := FNotifyDisconnect;
end;

function TsgcWSComponent_Base.GetNotifyError: TsgcObjectList;
begin
  if not Assigned(FNotifyError) then
    FNotifyError := TsgcObjectList.Create(True);
  Result := FNotifyError;
end;

function TsgcWSComponent_Base.GetNotifyMessage: TsgcObjectList;
begin
  if not Assigned(FNotifyMessage) then
    FNotifyMessage := TsgcObjectList.Create(True);
  Result := FNotifyMessage;
end;

function TsgcWSComponent_Base.GetNotifyBinary: TsgcObjectList;
begin
  if not Assigned(FNotifyBinary) then
    FNotifyBinary := TsgcObjectList.Create(True);
  Result := FNotifyBinary;
end;

function TsgcWSComponent_Base.GetVersion: String;
begin
  Result := CS_VERSION;
end;

function TsgcWSComponent_Base.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TsgcWSComponent_Base.IsDestroying: Boolean;
begin
  result := csDestroying in ComponentState;
end;

function TsgcWSComponent_Base.IsLoading: Boolean;
begin
  result := csLoading in ComponentState;
end;

constructor TsgcWSSpecifications.Create;
begin
  inherited;
  FDrafts := TsgcWSDrafts.Create;
end;

destructor TsgcWSSpecifications.Destroy;
begin
  FreeAndNil(FDrafts);
  inherited;
end;

procedure TsgcWSSpecifications.SetDrafts(const Value: TsgcWSDrafts);
begin
  FDrafts.Assign(Value);
end;

procedure TsgcObjectList.AddNotifyObject(aConnection: TsgcWSConnection; aParam:
    String);
var
  oComponent: TsgcNotifyObject;
begin
  oComponent := TsgcNotifyObject.Create;
  oComponent.Connection := aConnection;
  oComponent.Text := aParam;
  Add(oComponent);
end;

procedure TsgcObjectList.AddNotifyObject(aConnection: TsgcWSConnection; aParam:
    Integer);
var
  oComponent: TsgcNotifyObject;
begin
  oComponent := TsgcNotifyObject.Create;
  oComponent.Connection := aConnection;
  oComponent.Text := '';
  oComponent.Int := aParam;
  Add(oComponent);
end;

procedure TsgcObjectList.AddNotifyObject(aConnection: TsgcWSConnection; aParam:
    TMemoryStream);
var
  oComponent: TsgcNotifyObject;
begin
  oComponent := TsgcNotifyObject.Create;
  oComponent.Connection := aConnection;
  oComponent.Stream.LoadFromStream(aParam);
  Add(oComponent);
end;

procedure TsgcObjectList.AddNotifyObject(aConnection: TsgcWSConnection; aParam,
    aParam2: String);
var
  oComponent: TsgcNotifyObject;
begin
  oComponent := TsgcNotifyObject.Create;
  oComponent.Connection := aConnection;
  oComponent.Text := aParam;
  oComponent.Text2 := aParam2;
  Add(oComponent);
end;

procedure TsgcObjectList.AddNotifyObject(aConnection: TsgcWSConnection; aParam,
    aParam2, aParam3: String);
var
  oComponent: TsgcNotifyObject;
begin
  oComponent := TsgcNotifyObject.Create;
  oComponent.Connection := aConnection;
  oComponent.Text := aParam;
  oComponent.Text2 := aParam2;
  oComponent.Text3 := aParam3;
  Add(oComponent);
end;

procedure TsgcObjectList.AddNotifyObject(aConnection: TsgcWSConnection; aParam,
    aParam2, aParam3, aParam4: String);
var
  oComponent: TsgcNotifyObject;
begin
  oComponent := TsgcNotifyObject.Create;
  oComponent.Connection := aConnection;
  oComponent.Text := aParam;
  oComponent.Text2 := aParam2;
  oComponent.Text3 := aParam3;
  oComponent.Text4 := aParam4;
  Add(oComponent);
end;

procedure TsgcObjectList.AddNotifyObject(aConnection: TsgcWSConnection);
var
  oComponent: TsgcNotifyObject;
begin
  oComponent := TsgcNotifyObject.Create;
  oComponent.Connection := aConnection;
  Add(oComponent);
end;


constructor TsgcWSComponent.Create(aOwner: TComponent);
begin
  inherited;
  FProtocolObjectList := TObjectList.Create;
  FProtocolObjectList.OwnsObjects := False;
end;

destructor TsgcWSComponent.Destroy;
begin
  FreeAndNil(FExtensions);
  FreeAndNil(FSyncHandshake);
  FreeAndNil(FSpecifications);
  FreeAndNil(FProtocolObjectList);
  inherited;
end;

procedure TsgcWSComponent.DoAsyncHandshake;
var
  i: Integer;
begin
  for i := SyncHandshake.Count - 1 Downto 0 do
  begin
    DoEventHandshake(TsgcWSConnection(SyncHandshake.Items[i]),
      TsgcWSConnection(SyncHandshake.Items[i]).FHeadersResponse);
    SyncHandshake.Extract(TsgcWSConnection(SyncHandshake.Items[i]));
  end;

end;

procedure TsgcWSComponent.DoEventHandshake(aConnection: TsgcWSConnection;
    aHeaders: TStringList);
begin
  if Assigned(FOnHandshake) then
    FOnHandshake(aConnection, aHeaders);
end;

procedure TsgcWSComponent.DoNotifyConnect(aConnection: TsgcWSConnection);
var
  i: Integer;
begin
  if Assigned(aConnection) then
  begin
    if aConnection.Protocol <> '' then
    begin
      for i := 0 to FProtocolObjectList.Count - 1 do
      begin
        if ProtocolRegistered(aConnection.Protocol, TsgcWSProtocol(FProtocolObjectList[i])) then
          TsgcWSProtocol(FProtocolObjectList[i]).DoNotifyConnect(aConnection);
      end;
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TsgcWSComponent.DoNotifyDisconnect(aConnection: TsgcWSConnection);
var
  i: Integer;
begin
  if Assigned(aConnection) then
  begin
    if aConnection.Protocol <> '' then
    begin
      for i := 0 to FProtocolObjectList.Count - 1 do
      begin
        if ProtocolRegistered(aConnection.Protocol, TsgcWSProtocol(FProtocolObjectList[i])) then
        begin
          TsgcWSProtocol(FProtocolObjectList[i]).DoNotifyDisConnect(aConnection);
          break; // ... prevents to destroy aConnection twice
        end;
      end;
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TsgcWSComponent.DoNotifyError(aConnection: TsgcWSConnection);
var
  i: Integer;
begin
  if Assigned(aConnection) then
  begin
    if aConnection.Protocol <> '' then
    begin
      for i := 0 to FProtocolObjectList.Count - 1 do
      begin
        if ProtocolRegistered(aConnection.Protocol, TsgcWSProtocol(FProtocolObjectList[i])) then
          TsgcWSProtocol(FProtocolObjectList[i]).DoNotifyError(aConnection);
      end;
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TsgcWSComponent.DoNotifyMessage(aConnection: TsgcWSConnection);
var
  i: Integer;
begin
  if Assigned(aConnection) then
  begin
    if aConnection.Protocol <> '' then
    begin
      for i := 0 to FProtocolObjectList.Count - 1 do
      begin
        if ProtocolRegistered(aConnection.Protocol, TsgcWSProtocol(FProtocolObjectList[i])) then
          TsgcWSProtocol(FProtocolObjectList[i]).DoNotifyMessage(aConnection);
      end;
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TsgcWSComponent.DoNotifyBinary(aConnection: TsgcWSConnection);
var
  i: Integer;
begin
  if Assigned(aConnection) then
  begin
    if aConnection.Protocol <> '' then
    begin
      for i := 0 to FProtocolObjectList.Count - 1 do
      begin
        if ProtocolRegistered(aConnection.Protocol, TsgcWSProtocol(FProtocolObjectList[i])) then
          TsgcWSProtocol(FProtocolObjectList[i]).DoNotifyBinary(aConnection);
      end;
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TsgcWSComponent.DoNotifyHandshake(aConnection: TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        DoEventHandShake(aConnection, aConnection.HeadersResponse);
      neAsynchronous, neSynchronous:
        begin
          SyncHandshake.Add(aConnection);
          TIdSync.SynchronizeMethod(DoASyncHandshake);
        end;
    end;

  end;
end;

function TsgcWSComponent.GetExtensions: TsgcWSExtensions;
begin
  if not Assigned(FExtensions) then
    FExtensions := TsgcWSExtensions.Create;
  Result := FExtensions;
end;

function TsgcWSComponent.GetProtocols: String;
var
  i: Integer;
  oList: TStringList;
begin
  Result := '';
  oList := TStringList.Create;
  oList.Delimiter := ',';
  oList.Sorted := True;
  Try
    for i := 0 to FProtocolObjectList.Count - 1 do
    begin
      oList.Add(TsgcWSProtocol(FProtocolObjectList[i]).Protocol);
      // ... define object specific protocol
      if TsgcWSProtocol(FProtocolObjectList[i]).FGuid <> '' then
        oList.Add(
          TsgcWSProtocol(FProtocolObjectList[i]).FGuid + '.' +
          TsgcWSProtocol(FProtocolObjectList[i]).Protocol
        );
    end;
    result := oList.CommaText;
  Finally
    FreeAndNil(oList);
  End;
end;

function TsgcWSComponent.GetSpecifications: TsgcWSSpecifications;
begin
  if not Assigned(FSpecifications) then
  begin
    FSpecifications := TsgcWSSpecifications.Create;
    FSpecifications.RFC6455 := True;
    FSpecifications.Drafts.Hixie76 := True;
  end;
  Result := FSpecifications;
end;

function TsgcWSComponent.GetSyncHandshake: TObjectList;
begin
  if not Assigned(FSyncHandshake) then
    FSyncHandshake := TObjectList.Create;
  Result := FSyncHandshake;
end;

function TsgcWSComponent.ProtocolRegistered(const aProtocolName: String;
    aProtocol: TsgcWSProtocol): Boolean;
begin
  result := UpperCase(aProtocol.FGuid + '.' + aProtocol.Protocol) = UpperCase(aProtocolName);
  if not result then
    result := UpperCase(aProtocol.Protocol) = UpperCase(aProtocolName);
end;

procedure TsgcWSComponent.RegisterProtocol(aObject: TsgcWSProtocol);
begin
  // ... assign component notification type
  aObject.NotifyEvents := NotifyEvents;

  // ... register protocol
  FProtocolObjectList.Add(aObject);
end;

procedure TsgcWSComponent.SetExtensions(const Value: TsgcWSExtensions);
begin
  Extensions.Assign(Value);
end;

procedure TsgcWSComponent.SetSpecifications(const Value: TsgcWSSpecifications);
begin
  Specifications.Assign(Value);
end;

procedure TsgcWSComponent.UnRegisterProtocol(aObject: TsgcWSProtocol);
begin
  FProtocolObjectList.Extract(aObject);
end;

destructor TsgcWSProtocol_Client.Destroy;
begin
  Client := nil;
  inherited;
end;

procedure TsgcWSProtocol_Client.Loaded;
begin
  inherited;
  if Assigned(Client) then
    Client.RegisterProtocol(self);
end;

procedure TsgcWSProtocol_Client.Notification(AComponent : TComponent; Operation
    : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FClient) then
    FClient := nil;
end;

procedure TsgcWSProtocol_Client.SetClient(const Value: TsgcWSComponent_Client);
begin
  if Assigned(FClient) then
    FClient.RemoveFreeNotification(self);

  if [csDesigning, csLoading] * ComponentState = [] then
  begin
    if Assigned(FClient) then
    begin
      if not Assigned(Value) then
      begin
        FClient.UnRegisterProtocol(self);
        FClient := Value;
      end
      else if FClient <> Value then
      begin
        FClient := Value;
        FClient.RegisterProtocol(self);
      end;
    end
    else
    begin
      FClient := Value;
      if Assigned(Value) then
        FClient.RegisterProtocol(self);
    end;
  end
  else
    FClient := Value;

  if Assigned(FClient) then
    FClient.FreeNotification(self);
end;

destructor TsgcWSProtocol_Server.Destroy;
begin
  Server := nil;
  inherited;
end;

procedure TsgcWSProtocol_Server.Loaded;
begin
  inherited;
  if Assigned(Server) then
    Server.RegisterProtocol(self);
end;

procedure TsgcWSProtocol_Server.Notification(AComponent : TComponent; Operation
    : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FServer) then
    FServer := nil;
end;

procedure TsgcWSProtocol_Server.SetServer(const Value: TsgcWSComponent_Server);
begin
  if Assigned(FServer) then
    FServer.RemoveFreeNotification(self);

  if [csDesigning, csLoading] * ComponentState = [] then
  begin
    if Assigned(FServer) then
    begin
      if not Assigned(Value) then
      begin
        FServer.UnRegisterProtocol(self);
        FServer := Value;
      end
      else if FServer <> Value then
      begin
        FServer := Value;
        FServer.RegisterProtocol(self);
      end;
    end
    else
    begin
      FServer := Value;
      if Assigned(Value) then
        FServer.RegisterProtocol(self);
    end;
  end
  else
    FServer := Value;

  if Assigned(FServer) then
    FServer.FreeNotification(self);
end;

destructor TsgcNotifyObject.Destroy;
begin
  FreeAndNil(FStream);
  inherited;
end;

function TsgcNotifyObject.GetStream: TMemoryStream;
begin
  if not Assigned(FStream) then
    FStream := TMemoryStream.Create;
  Result := FStream;
end;

procedure TsgcWSDrafts.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSDrafts then
    FHixie76 := TsgcWSDrafts(aSource).Hixie76
  else
    inherited Assign(aSource);
end;

constructor TsgcWSComponent_Server.Create(aOwner: TComponent);
begin
  inherited;
  NotifyEvents := neAsynchronous;
end;

constructor TsgcWSComponent_Client.Create(aOwner: TComponent);
begin
  inherited;
  NotifyEvents := neAsynchronous;
end;

constructor TsgcWSMsg.Create;
begin
  Clear;
end;

destructor TsgcWSMsg.Destroy;
begin
  ClearStream;
  inherited;
end;

procedure TsgcWSMsg.Clear;
begin
  ClearStream;

  Continuation := False;
  Fragmented := False;
  MaskIndex := 0;
  OpCode := opNone;
  PayLoad := pa7bits;
  PayLoadLength := 0;
  PLState := 0;
  ReadMasked := False;
  State := 0;
end;

procedure TsgcWSMsg.ClearStream;
begin
  FreeAndNil(FStream);
end;

procedure TsgcWSMsg.Free;
begin
  if Self <> nil then
    Destroy;
end;

function TsgcWSMsg.GetStream: TStream;
begin
  if not Assigned(FStream) then
  begin
    case OpCode of
      opBinary:
        FStream := TMemoryStream.Create;
      else
        FStream := TsgcStringStream.Create('');
    end;
  end;
  Result := FStream;
end;

procedure TsgcWSAuthentication_Options.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSAuthentication_Options then
    FEnabled := TsgcWSAuthentication_Options(aSource).Enabled
  else
    inherited Assign(aSource);
end;

procedure TsgcWSAuthentication_Session.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSAuthentication_Session then
    FEnabled := TsgcWSAuthentication_Session(aSource).Enabled
  else
    inherited Assign(aSource);
end;

procedure TsgcWSAuthentication_URL.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSAuthentication_URL then
    FEnabled := TsgcWSAuthentication_URL(aSource).Enabled
  else
    inherited Assign(aSource);
end;



end.

