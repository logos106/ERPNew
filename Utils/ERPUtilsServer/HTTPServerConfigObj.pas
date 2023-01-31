unit HTTPServerConfigObj;

interface

uses
  classes, ModuleConst, LogMessageTypes;

type

  {$M+}
  THTTPServerConfig = class
  private
  protected
    fOnChange: TNotifyEvent;
    FDefaultPort: integer;
    FMaxConnections: integer;
    FWebUserName: string;
    FConfigExists: boolean;
    FDefaultSSLPort: integer;
    FUseSSL: boolean;
    FActive: boolean;
    fLoggingLevel: TLoggingLevel;
    procedure SetActive(const Value: boolean); virtual;
    procedure SetDefaultPort(const Value: integer); virtual;
    procedure SetDefaultSSLPort(const Value: integer); virtual;
    procedure SetMaxConnections(const Value: integer); virtual;
    procedure SetUseSSL(const Value: boolean); virtual;
    procedure SetWebUserName(const Value: string); virtual;
    procedure SetLoggingLevel(const Value: TLoggingLevel); virtual;
  public
  published
    property Active: boolean read FActive write SetActive;
    property DefaultPort: integer read FDefaultPort write SetDefaultPort;
    property DefaultSSLPort: integer read FDefaultSSLPort write SetDefaultSSLPort;
    property MaxConnections: integer read FMaxConnections write SetMaxConnections;
    property UseSSL: boolean read FUseSSL write SetUseSSL;
    property WebUserName: string read FWebUserName write SetWebUserName;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property LoggingLevel: TLoggingLevel read fLoggingLevel write SetLoggingLevel;
  end;
  {$M-}


implementation

{ THTTPServerConfig }

procedure THTTPServerConfig.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    FActive:= Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure THTTPServerConfig.SetDefaultPort(const Value: integer);
begin
  if FDefaultPort <> Value then begin
    FDefaultPort:= Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure THTTPServerConfig.SetDefaultSSLPort(const Value: integer);
begin
  if FDefaultSSLPort <> Value then begin
    FDefaultSSLPort:= Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure THTTPServerConfig.SetLoggingLevel(const Value: TLoggingLevel);
begin
  if fLoggingLevel <> Value then begin
    fLoggingLevel := Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure THTTPServerConfig.SetMaxConnections(const Value: integer);
begin
  if FMaxConnections <> Value then begin
    FMaxConnections:= Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure THTTPServerConfig.SetUseSSL(const Value: boolean);
begin
  if FUseSSL <> Value then begin
    FUseSSL:= Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

procedure THTTPServerConfig.SetWebUserName(const Value: string);
begin
  if FWebUserName <> Value then begin
    FWebUserName:= Value;
    if Assigned(fOnChange) then
      fOnChange(self);
  end;
end;

end.
