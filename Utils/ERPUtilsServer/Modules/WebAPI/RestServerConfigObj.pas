unit RestServerConfigObj;

interface

uses
  syncobjs, classes;

type

  TRestServerConfigValues = class(TPersistent)
  private
    fDefaultPort: integer;
    fMaxConnections: integer;
    fDefaultSSLPort: integer;
    fUseSSL: boolean;
    fActive: boolean;
    fWebUserName: string;
  published
  public
    property DefaultPort: integer read fDefaultPort write fDefaultPort;
    property DefaultSSLPort: integer read fDefaultSSLPort write fDefaultSSLPort;
    property UseSSL: boolean read fUseSSL write fUseSSL;
    property Active: boolean read fActive write fActive;
    property MaxConnections: integer read fMaxConnections write fMaxConnections;
    property WebuserName: string read fWebUserName write fWebUserName;
    procedure Assign(Source: TPersistent); override;
  end;

  TRestServerConfig = class
  private
    fLock: TCriticalSection;
    fRestServerConfigValues: TRestServerConfigValues;
  public
    constructor Create;
    destructor Destroy; override;
    function Lock: TRestServerConfigValues;
    procedure Unlock;
  end;


implementation

{ TRestServerConfigValues }

procedure TRestServerConfigValues.Assign(Source: TPersistent);
begin
  if Source is TRestServerConfigValues then begin
    self.DefaultPort:= TRestServerConfigValues(Source).DefaultPort;
    self.DefaultSSLPort:= TRestServerConfigValues(Source).DefaultSSLPort;
    self.UseSSL:= TRestServerConfigValues(Source).UseSSL;
    self.Active:= TRestServerConfigValues(Source).Active;
    self.WebuserName:= TRestServerConfigValues(Source).WebuserName;
    self.MaxConnections:= TRestServerConfigValues(Source).MaxConnections;
  end;
end;

{ TRestServerConfig }

constructor TRestServerConfig.Create;
begin
  fLock:= TCriticalSection.Create;
  fRestServerConfigValues:= TRestServerConfigValues.Create;
end;

destructor TRestServerConfig.Destroy;
begin
  inherited;
  fLock.Free;
  fRestServerConfigValues.Free;
end;

function TRestServerConfig.Lock: TRestServerConfigValues;
begin
  fLock.Acquire;
  result:= fRestServerConfigValues;
end;

procedure TRestServerConfig.Unlock;
begin
  fLock.Release;
end;


end.
