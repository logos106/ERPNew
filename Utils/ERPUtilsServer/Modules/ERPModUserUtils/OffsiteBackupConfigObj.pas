unit OffsiteBackupConfigObj;

interface

uses
  Classes;

type

  TOffsiteBackupTargetType = (obERPServer = 0, obCustomServer = 1);

  {$M+}
  TOffsiteBackupConfig = class
  private
    fOffsiteBackupEnabled: boolean;
    fOffsiteBackupTarget: TOffsiteBackupTargetType;
    fFTPHost: string;
    fFTPPass: string;
    fFTPUser: string;
    fFTPPath: string;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
    function GetDatabaseList: string;
    procedure SetDatabaseList(const Value: string);
  public
    DatabaseItems: TStringList;
    property AsString: string read GetAsString write SetAsString;
  published
    constructor Create;
    destructor Destroy; override;
    property OffsiteBackupEnabled: boolean read fOffsiteBackupEnabled write fOffsiteBackupEnabled;
    property OffsiteBackupTarget: TOffsiteBackupTargetType read fOffsiteBackupTarget write fOffsiteBackupTarget;
    property FTPHost: string read fFTPHost write fFTPHost;
    property FTPPath: string read fFTPPath write fFTPPath;
    property FTPUser: string read fFTPUser write fFTPUser;
    property FTPPass: string read fFTPPass write fFTPPass;
    property DatabaseList: string read GetDatabaseList write SetDatabaseList;
  end;
  {$M-}

implementation

uses
  JsonToObject, JsonObject;

{ TOffsiteBackupConfig }

constructor TOffsiteBackupConfig.Create;
begin
  DatabaseItems := TStringList.Create;
end;

destructor TOffsiteBackupConfig.Destroy;
begin
  DatabaseItems.Free;
  inherited;
end;

function TOffsiteBackupConfig.GetAsString: string;
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

function TOffsiteBackupConfig.GetDatabaseList: string;
begin
  result := DatabaseItems.CommaText;
end;

procedure TOffsiteBackupConfig.SetAsString(const Value: string);
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

procedure TOffsiteBackupConfig.SetDatabaseList(const Value: string);
begin
  DatabaseItems.CommaText := Value;
end;

end.
