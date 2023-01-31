unit AUSKeyConfigObj;

interface

uses
  JsonDbPrefsConfigObj;

type
  TAUSKeyConfig = class(TJsonDbPefConfig)
  private
    procedure SetKeyFilePath(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetSavePassword(const Value: boolean);
    procedure SetSelectedID(const Value: string);
    function GetKeyFilePath: string;
    function GetPassword: string;
    function GetSavePassword: boolean;
    function GetSelectedID: string;
  public
    constructor Create; override;
  published
    property KeyFilePath: string read GetKeyFilePath write SetKeyFilePath;
    property Password: string read GetPassword write SetPassword;
    property SelectedID: string read GetSelectedID write SetSelectedID;
    property SavePassword: boolean read GetSavePassword write SetSavePassword;
  end;

implementation

{ TAUSKeyConfig }

constructor TAUSKeyConfig.Create;
begin
  inherited;
  Encrypt := true;
end;

function TAUSKeyConfig.GetKeyFilePath: string;
begin
  result := S['KeyFilePath'];
end;

function TAUSKeyConfig.GetPassword: string;
begin
  result := S['Password'];
end;

function TAUSKeyConfig.GetSavePassword: boolean;
begin
  result := B['SavePassword'];
end;

function TAUSKeyConfig.GetSelectedID: string;
begin
  result := S['SelectedID'];
end;

procedure TAUSKeyConfig.SetKeyFilePath(const Value: string);
begin
  S['KeyFilePath'] := Value;
end;

procedure TAUSKeyConfig.SetPassword(const Value: string);
begin
  s['Password'] := Value;
end;

procedure TAUSKeyConfig.SetSavePassword(const Value: boolean);
begin
  B['SavePassword'] := Value;
end;

procedure TAUSKeyConfig.SetSelectedID(const Value: string);
begin
  S['SelectedID'] := Value;
end;

end.
