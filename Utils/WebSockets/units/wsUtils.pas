unit wsUtils;

interface
uses
  SysUtils,Forms, IniFiles,
  Registry, wsConsts,
  sgcWebSocket, sgcWebSocket_Server,
  sgcWebSocket_Classes, sgcWebSocket_Client;


  function ActivateLocalClient(AClient : TsgcWebSocketClient) : boolean;
  function ActivateRemoteClient(AClient : TsgcWebSocketClient) : boolean;
//  function ActivateSecondaryClient(AClient
  function ActivateServer(AServer : TsgcWSServer_Base) : boolean;
  procedure LoadLocalRPCConfig(AClient : TsgcWebSocketClient);
  procedure LoadRemoteRPCConfig(AClient : TsgcWebSocketClient);

  function ConnectionOrigin(aConnection : TsgcWSConnection) : string;

type
  TCrackedConnection = class(TsgcWSConnection)
  public
    property HeadersRequest;
    property HeadersResponse;
    property WSMessage;
  end;

implementation


function ActivateLocalClient(AClient : TsgcWebSocketClient) : boolean;
var
  lIni : TIniFile;
  lStr : string;
begin
  if not AClient.Active then
  begin
    if AClient.Options.Origin = '' then
    begin
      lStr := ExtractFilePath(Application.ExeName);
      lIni := TIniFile.Create(lStr + 'ERPLocalClient.ini');
      try
//        AClient.Port := lIni.ReadInteger('Server','Port',3000);
//        AClient.Host := lIni.ReadString('Server', 'Host', '127.0.0.1');
        AClient.TLS := SameText(lIni.ReadString('Client', 'TLS', 'False'), 'True');
        AClient.Port := lIni.ReadInteger('Server','Port',3000);
        AClient.Host := lIni.ReadString('Server', 'Host', '127.0.0.1');
        // temporarily - later on it is to be something unique for the installation
        // For now let it be App name
        //AClient.Options.Origin := ExtractFileName(Application.ExeName);
        AClient.Options.Origin := csLocalClient;
      finally
        lIni.Free;
      end;
    end;
    AClient.Active := true;
  end;
  Result := AClient.Active;
end;

procedure LoadLocalRPCConfig(AClient : TsgcWebSocketClient);
var
  lIni : TIniFile;
  lStr : string;
begin
  if not AClient.Active then
  begin
    if AClient.Options.Origin = '' then
    begin
      lStr := ExtractFilePath(Application.ExeName);
      lIni := TIniFile.Create(lStr + 'ERPLocalClient.ini');
      try
        AClient.TLS := SameText(lIni.ReadString('Client', 'TLS', 'False'), 'True');
        AClient.Port := lIni.ReadInteger('Server','Port',3000);
        AClient.Host := lIni.ReadString('Server', 'Host', '127.0.0.1');
        // temporarily - later on it is to be something unique for the installation
        // For now let it be App name
        //AClient.Options.Origin := ExtractFileName(Application.ExeName);
        AClient.Options.Origin := csLocalClient;
      finally
        lIni.Free;
      end;
    end;
  end;
end;

function ActivateRemoteClient(AClient : TsgcWebSocketClient) : boolean;
var
  lIni : TIniFile;
  lStr : string;
begin
  if not AClient.Active then
  begin
    if AClient.Options.Origin = '' then
    begin
      lStr := ExtractFilePath(Application.ExeName);
      lIni := TIniFile.Create(lStr + 'ERPRemoteClient.ini');
      try
//        AClient.Port := lIni.ReadInteger('Server','Port',3000);
//        AClient.Host := lIni.ReadString('Server', 'Host', '127.0.0.1');
        AClient.TLS := SameText(lIni.ReadString('Client', 'TLS', 'False'), 'True');
        AClient.Port := lIni.ReadInteger('Server','Port',3000);
        AClient.Host := lIni.ReadString('Server', 'Host', '127.0.0.1');
        // temporarily - later on it is to be something unique for the installation
        // For now let it be App name
        //AClient.Options.Origin := ExtractFileName(Application.ExeName);
        AClient.Options.Origin := csRemoteClient;
      finally
        lIni.Free;
      end;
    end;
    AClient.Active := true;
  end;
  Result := AClient.Active;
end;

procedure LoadRemoteRPCConfig(AClient : TsgcWebSocketClient);
var
  lIni : TIniFile;
  lStr : string;
begin
  if not AClient.Active then
  begin
    if AClient.Options.Origin = '' then
    begin
      lStr := ExtractFilePath(Application.ExeName);
      lIni := TIniFile.Create(lStr + 'ERPRemoteClient.ini');
      try
        AClient.TLS := SameText(lIni.ReadString('Client', 'TLS', 'False'), 'True');
        AClient.Port := lIni.ReadInteger('Server','Port',3000);
        AClient.Host := lIni.ReadString('Server', 'Host', '127.0.0.1');
        // temporarily - later on it is to be something unique for the installation
        // For now let it be App name
        //AClient.Options.Origin := ExtractFileName(Application.ExeName);
        AClient.Options.Origin := csRemoteClient;
      finally
        lIni.Free;
      end;
    end;
  end;
end;


function ActivateServer(AServer : TsgcWSServer_Base) : boolean;
var
  lIni : TIniFile;
  lStr : string;
begin
  if not AServer.Active then
  begin
    lStr := ExtractFilePath(Application.ExeName);
    lIni := TIniFile.Create(lStr + 'ERPServer.ini');
    try
      AServer.Port := lIni.ReadInteger('Server','Port',3000);
      lStr := lIni.ReadString('Server', 'SSL', 'False');
//      AServer.SSL := SameText(lIni.ReadString('Server', 'SSL', 'False'), 'True');
      AServer.SSL := SameText(lStr, 'True');
      if aServer.SSL then
      begin
        AServer.SSLOptions.CertFile := lIni.ReadString('Server', 'CertFile', '');
        AServer.SSLOptions.KeyFile := lIni.ReadString('Server', 'KeyFile', '');
        AServer.SSLOptions.RootCertFile := lIni.ReadString('Server', 'RootCertFile', '');
      end;
    finally
      lIni.Free;
    end;
    AServer.Active := true;
  end;
  Result := AServer.Active;

end;

function ConnectionOrigin(AConnection : TsgcWSConnection) : string;
//var
//  idx : integer;
begin
  Result := '';
  if (not (assigned(AConnection))) or
     (TCrackedConnection(AConnection).HeadersRequest = nil) then
     exit;

  Result := TCrackedConnection(AConnection).HeadersRequest.Values['Origin'];
//  for idx := 0 to AConnection.HeadersRequest.Strings.Count - 1 do


end;

end.
