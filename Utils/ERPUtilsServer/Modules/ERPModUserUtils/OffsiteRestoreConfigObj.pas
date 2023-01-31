unit OffsiteRestoreConfigObj;

interface

uses
  Classes;
type

  {$M+}
  TOffsiteRestoreConfig = class
  private
    fOffsiteRestoreEnabled: boolean;
    fFTPHost: string;
    fFTPPass: string;
    fFTPUser: string;
    fFTPPath: string;
    fLocalPath: string;
    fTimeStart: TTime;
    fTimeEnd: TTime;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    function GetDatabaseList: string;
    procedure SetDatabaseList(const Value: string);
    function GetLocalPath: string;
  public
    DatabaseItems: TStringList;
    property AsString: string read GetAsString write SetAsString;
  published
    constructor Create;
    destructor Destroy; override;
    property OffsiteRestoreEnabled: boolean read fOffsiteRestoreEnabled write fOffsiteRestoreEnabled;
    property FTPHost: string read fFTPHost write fFTPHost;
    property FTPPath: string read fFTPPath write fFTPPath;
    property FTPUser: string read fFTPUser write fFTPUser;
    property FTPPass: string read fFTPPass write fFTPPass;
    property LocalPath: string read GetLocalPath write fLocalPath;
    property DatabaseList: string read GetDatabaseList write SetDatabaseList;
    property TimeStart: TTime read fTimeStart write fTimeStart;
    property TimeEnd: TTime read fTimeEnd write fTimeEnd;
  end;
  {$M-}

implementation

uses
  JsonToObject, JsonObject, SysUtils;

{ TOffsiteRestoreConfig }

constructor TOffsiteRestoreConfig.Create;
begin
  DatabaseItems := TStringList.Create;
end;

destructor TOffsiteRestoreConfig.Destroy;
begin
  DatabaseItems.Free;
  inherited;
end;

function TOffsiteRestoreConfig.GetAsString: string;
var
  j: TJsonObject;
begin
  j := JO;
  try
    ObjToJson(self,j);
    result := j.AsString;
  finally
    j.Free;
  end;
end;

function TOffsiteRestoreConfig.GetDatabaseList: string;
begin
  result := DatabaseItems.CommaText;
end;

function TOffsiteRestoreConfig.GetLocalPath: string;
begin
  if fLocalPath = '' then
    Result := fLocalPath
  else
    {$WARNINGS OFF}
    result := SysUtils.IncludeTrailingBackslash(fLocalPath);
    {$WARNINGS ON}
end;

procedure TOffsiteRestoreConfig.SetAsString(const Value: string);
var
  j: TJsonObject;
begin
  j := JO;
  try
    j.AsString := Value;
    JsonToObj(j,self);
  finally
    j.Free;
  end;
end;

procedure TOffsiteRestoreConfig.SetDatabaseList(const Value: string);
begin
  DatabaseItems.CommaText := Value;
end;

end.
