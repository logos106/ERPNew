unit ERPServerInfoObj;

interface

uses
  Classes;

type
  TERPServerInfo = class(TComponent)
  private
    fUsedPercent: double;
    fUsedSpaceMB: double;
    fFreePercent: double;
    fFreeSpaceMB: double;
    fDatabaseList: string;
  published
  public
    constructor Create(AOwner: TComponent); override;
  published
    property FreeSpaceMB: double read fFreeSpaceMB;
    property UsedSpaceMB: double read fUsedSpaceMB;
    property FreePercent: double read fFreePercent;
    property UsedPercent: double read fUsedPercent;
    property DatabaseList: string read fDatabaseList;
  end;

implementation

uses
  SysUtils, AppEnvironment, MySQLUtils, MyAccess;

{ TERPServerInfo }


constructor TERPServerInfo.Create(AOwner: TComponent);
var
  DbDir: string;
  FreeAvailable, TotalSpace: Int64;
  qry: TMyQuery;
  conn: TMyConnection;
  sl: TStringList;
begin
  inherited;
//  if SameText(AppEnv.AppDb.Connection.Server, 'localhost') or SameText(AppEnv.AppDb.Connection.Server, '127.0.0.1') then begin
  if SameText(AppEnv.AppDb.Server, 'localhost') or SameText(AppEnv.AppDb.Server, '127.0.0.1') then begin
    { database is on same server }
    DbDir := GetMySQLDataDir(AppEnv.AppDb.Connection.Server);
    SysUtils.GetDiskFreeSpaceEx(PChar(DbDir), FreeAvailable, TotalSpace, nil);
    fFreeSpaceMB := FreeAvailable / 1024 / 1024;
    fUsedSpaceMB := (TotalSpace / 1024 / 1024) - fFreeSpaceMB;
    fFreePercent := Round((FreeAvailable / TotalSpace) * 100);
    fUsedPercent := Round(((TotalSpace - FreeAvailable) / TotalSpace) * 100);
  end
  else begin
    { cluster db server }
    conn := TMyConnection.Create(nil);
    qry := TMyQuery.Create(nil);
    try
      SetConnectionProps(conn,'services',AppEnv.AppDb.Server);
      qry.Connection := conn;
      try
        conn.Connect;
        qry.SQL.Text :=
          'select min(FreeSpaceMb) as FreeSpaceMb, max(UsedSpaceMb) as UsedSpaceMb, ' +
          'min(FreePercent) as FreePercent, max(UsedPercent) as UsedPercent from serverinfo';
        qry.Open;
        fFreeSpaceMB := qry.FieldByName('FreeSpaceMb').AsFloat;
        fUsedSpaceMB := qry.FieldByName('UsedSpaceMb').AsFloat;
        fFreePercent := qry.FieldByName('FreePercent').AsFloat;
        fUsedPercent := qry.FieldByName('UsedPercent').AsFloat;
      except
      end;
    finally
      qry.Free;
      conn.Free;
    end;
  end;
  conn := TMyConnection.Create(nil);
  sl := TStringList.Create;
  try
    SetConnectionProps(conn,'mysql',AppEnv.AppDb.Server);
    conn.Connect;
    conn.GetDatabaseNames(sl);
    fDatabaseList := sl.CommaText;
  finally
    conn.Free;
    sl.Free;
  end;
end;

initialization
  RegisterClass(TERPServerInfo);

end.
