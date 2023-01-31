{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}


unit sgcWebSocket_CustomServer;

interface

uses
  IdHTTPServer, IdTCPServer,
  IdContext, IdSSL;

type
  TsgcWSQuerySSLPortEvent = procedure(aPort: Integer; var aSSL: Boolean) of object;

  TsgcWSCustomServer = class(TIdTCPServer)
  { ssl }  
  protected
    FOnQuerySSLPort: TsgcWSQuerySSLPortEvent;
    procedure DoConnect(AContext: TIdContext); override;
    function DoQuerySSLPort(aPort: Integer): Boolean; virtual;
  public
    property OnQuerySSLPort: TsgcWSQuerySSLPortEvent read FOnQuerySSLPort write
        FOnQuerySSLPort;
  { ssl }
  end;

  TsgcWSHTTPCustomServer = class(TIdHTTPServer)
  { http }
  protected
    function DoExecute(AContext: TIdContext): boolean; override;
  public
    procedure DoExecuteHTTP(AContext: TIdContext);
  { http }

  { ssl }
  protected
    FOnQueryHTTPSSLPort: TsgcWSQuerySSLPortEvent;
    procedure DoConnect(AContext: TIdContext); override;
    function DoQuerySSLPort(aPort: Integer): Boolean; reintroduce; virtual;
  public
    property OnExecute;
  public
    property OnQuerySSLPort: TsgcWSQuerySSLPortEvent read FOnQueryHTTPSSLPort write
        FOnQueryHTTPSSLPort;
  { ssl }
  end;

implementation

procedure TsgcWSHTTPCustomServer.DoConnect(AContext: TIdContext);
begin
// ... customized DoConnect
//  inherited;
  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then
  begin
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough :=
      not DoQuerySSLPort(AContext.Connection.Socket.Binding.Port);
  end;
  if Assigned(OnConnect) then OnConnect(AContext);
end;

function TsgcWSHTTPCustomServer.DoExecute(AContext: TIdContext): boolean;
begin
  if Assigned(FOnExecute) then
  begin
    FOnExecute(AContext);
    result := AContext.Connection.Connected;
  end
  else
    result := inherited DoExecute(AContext);
end;

procedure TsgcWSHTTPCustomServer.DoExecuteHTTP(AContext: TIdContext);
begin
  inherited DoExecute(AContext);
end;

function TsgcWSHTTPCustomServer.DoQuerySSLPort(aPort: Integer): Boolean;
begin
  Result := not Assigned(FOnQueryHTTPSSLPort);
  if not Result then FOnQueryHTTPSSLPort(aPort, Result);
end;

procedure TsgcWSCustomServer.DoConnect(AContext: TIdContext);
begin
// ... customized DoConnect
//  inherited;
  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then
  begin
    TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough :=
      not DoQuerySSLPort(AContext.Connection.Socket.Binding.Port);
  end;
  if Assigned(OnConnect) then OnConnect(AContext);
end;

function TsgcWSCustomServer.DoQuerySSLPort(aPort: Integer): Boolean;
begin
  Result := not Assigned(FOnQuerySSLPort);
  if not Result then FOnQuerySSLPort(aPort, Result);
end;


end.
