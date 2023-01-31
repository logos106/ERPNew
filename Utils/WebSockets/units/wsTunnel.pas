unit wsTunnel;

interface
uses
  sysutils, Classes, contnrs, sgcWebSocket_Classes, wsConsts;

type
  TwsTunnel = class
  private
    fExternalClient: TsgcWSConnection;
    fLocalClient: TsgcWSConnection;
  public
    property ExternalClient : TsgcWSConnection read fExternalClient write fExternalClient;
    property LocalClient : TsgcWSConnection read fLocalClient write fLocalClient;
  end;

  TwsTunnelsList = class
  private
    fList: TObjectList;
    fCallBack: TMessageProc;
    function GetCount: integer;
    function GetTunnel(idx: integer): TwsTunnel;
  protected
    procedure DoCallBack(const aStr : string);
    property List : TObjectList Read fList write fList;
  public
    constructor Create;
    destructor Destroy; override;

    function ForwardMessage(ASource : TsgcWSConnection; const aMessage : string) : boolean;
    function ForwardBinary(ASource : TsgcWSConnection; AStream : TMemoryStream) : boolean;
    // delete tunnel when connection closed
    procedure RemoveTunnel(AConnection : TsgcWSConnection);
    //
    procedure AddTunnel(ATunnel : TwsTunnel);

    function Destination(ASource : TsgcWSConnection) : TsgcWSConnection;
    // Destroy all tunnels with this connection
    procedure CloseTunnel(Connection : TsgcWSConnection);

    property Count : integer read GetCount;
    property Tunnel[idx : integer] : TwsTunnel read GetTunnel; default;
    property OnCallBack : TMessageProc read fCallBack write fCallBack;
  end;

  TTunnelEvent = procedure(ATunnel : TwsTunnel) of object;

implementation

function SortSources(Item1, Item2: Pointer): Integer;
begin
  if TwsTunnel(Item1).ExternalClient.Guid > TwsTunnel(Item2).ExternalClient.GUID then
    Result := 1
  else if TwsTunnel(Item1).ExternalClient.Guid < TwsTunnel(Item2).ExternalClient.GUID then
    Result := -1
  else
    Result := 0;
end;

function SortDestinations(Item1, Item2 : Pointer) : integer;
begin
  if TwsTunnel(Item1).LocalClient.Guid > TwsTunnel(Item2).LocalClient.GUID then
    Result := 1
  else if TwsTunnel(Item1).LocalClient.Guid < TwsTunnel(Item2).LocalClient.GUID then
    Result := -1
  else
    Result := 0;
end;
{ TwsTunnelsList }

procedure TwsTunnelsList.AddTunnel(ATunnel: TwsTunnel);
begin
  fList.Add(ATunnel);
  fList.Sort(SortSources);
end;

procedure TwsTunnelsList.CloseTunnel(Connection: TsgcWSConnection);
var
  idx : integer;
//  lTunnel : TwsTunnel;
begin
  for idx := Count - 1 downto 0 do
    if (Tunnel[idx].ExternalClient.Guid = Connection.Guid) or
       (Tunnel[idx].LocalClient.Guid = Connection.Guid) then
    begin
    // List owns objects, so Delete will destroy it
//      lTunnel := Tunnel[idx];
      fList.Delete(idx);
//      lTunnel.Free;
    end;

end;

constructor TwsTunnelsList.Create;
begin
  inherited;
  fList := TObjectList.Create(true);
end;

destructor TwsTunnelsList.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TwsTunnelsList.DoCallBack(const aStr: string);
begin
  if assigned(OnCallBack) then
    OnCallBack(aStr);
end;

function TwsTunnelsList.Destination(
  ASource: TsgcWSConnection): TsgcWSConnection;
var
  idx : integer;
  s : string;
begin
  Result := nil;
  s := '[TUNNEL] Request fo Dest=' + ASource.Guid + ': ';
  for idx := 0 to Count - 1 do
  begin
    if Tunnel[idx].ExternalClient.Guid = ASource.Guid  then
      Result := Tunnel[idx].LocalClient
    else if Tunnel[idx].LocalClient.Guid = ASource.Guid then
      Result := Tunnel[idx].ExternalClient;
    if Assigned(Result) then
    begin
      DoCallBack(s + ' SUCCESS');
      exit;
    end;
  end;
  DoCallBack(s + ' FAILED');
end;

function TwsTunnelsList.ForwardBinary(ASource: TsgcWSConnection;
  AStream: TMemoryStream) : boolean;
var
  lDest : TsgcWSConnection;
begin
  lDest := Destination(ASource);
  if assigned(lDest) then
    lDest.WriteData(AStream);
  Result := assigned(lDest);
end;

function TwsTunnelsList.ForwardMessage(ASource: TsgcWSConnection;
  const aMessage: string) : boolean;
var
  lDest : TsgcWSConnection;
begin
  lDest := Destination(ASource);
  if assigned(lDest) then
    lDest.WriteData(AMessage);
  Result := assigned(lDest);
  if Result then
    DoCallBack('[Tunnel] Forwarded "' + aMessage + '"')
  else
    DoCallBack('{Tunnel] Forward "' + aMessage + '" - FAILED');
end;

function TwsTunnelsList.GetCount: integer;
begin
  Result := List.Count;
end;

function TwsTunnelsList.GetTunnel(idx: integer): TwsTunnel;
begin
  Result := TwsTunnel(List[idx]);
end;

procedure TwsTunnelsList.RemoveTunnel(AConnection: TsgcWSConnection);
var
  idx : integer;
begin
  for idx := 0 to Count - 1 do
    if (Tunnel[idx].ExternalClient.Guid = AConnection.Guid) or
       (Tunnel[idx].LocalClient.Guid = AConnection.Guid) then
       List.Delete(idx);
end;

end.
