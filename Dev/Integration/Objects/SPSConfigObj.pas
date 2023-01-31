unit SPSConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess;

type

  {$M+}
  TSPSConfig = class(TJsonDbPefConfig)
  private
    function GetFTPPassword: string;
    function GetFTPSite: string;
    function GetFTPUserName: string;
    function GetSPSActive: boolean;
    procedure SetFTPPassword(const Value: string);
    procedure SetFTPSite(const Value: string);
    procedure SetFTPUserName(const Value: string);
    procedure SetSPSActive(const Value: boolean);
  public
    constructor Create; override;
    procedure Load(connection: TMyConnection); override;
  published
    property Active: boolean read GetSPSActive write SetSPSActive;
    property FTPUserName: string read GetFTPUserName write SetFTPUserName;
    property FTPPassword: string  read GetFTPPassword write SetFTPPassword;
    property FTPSite: string read GetFTPSite write SetFTPSite;
  end;
  {$M-}


implementation

{ TSPSConfig }

constructor TSPSConfig.Create;
begin
  inherited;
  Encrypt := true;
  Name := 'Config_EDI_SPS';
end;

function TSPSConfig.GetFTPPassword: string;
begin
  result := S['FTPPassword'];
end;

function TSPSConfig.GetFTPSite: string;
begin
  result := S['FTPSite'];
end;

function TSPSConfig.GetFTPUserName: string;
begin
  result := S['FTPUserName'];
end;

function TSPSConfig.GetSPSActive: boolean;
begin
  result := B['Active'];
end;

procedure TSPSConfig.Load(connection: TMyConnection);
begin
  inherited;
  if (FTPSite = '') then begin
    FTPSite := 'HTTP:\\';
    Save(connection);
  end;
end;

procedure TSPSConfig.SetFTPPassword(const Value: string);
begin
  S['FTPPassword'] := Value;
end;

procedure TSPSConfig.SetFTPSite(const Value: string);
begin
  S['FTPSite'] := Value;
end;

procedure TSPSConfig.SetFTPUserName(const Value: string);
begin
  S['FTPUserName'] := Value;
end;

procedure TSPSConfig.SetSPSActive(const Value: boolean);
begin
  B['Active'] := Value;
end;

end.
