unit ConfigDbObj;

interface

uses
  ErpDbComponents;

type

  TConfigDb = class
  private
    fConfigName: string;
    fServerName: string;
    fDbOk: boolean;
    fConn: TErpConnection;
    fQry: TErpQuery;
    function GetValue: string;
    procedure SetValue(const aValue: string);
    procedure SetServerName(const aValue: string);
    procedure CheckDb;
    function GetExists: boolean;
  public
    constructor Create(const aConfigName, aServerName: string);
    destructor Destroy; override;
    property ConfigName: string read fConfigName write fConfigName;
    property ServerName: string read fServerName write SetServerName;
    property Value: string read GetValue write SetValue;
    property Exists: Boolean read GetExists;
  end;

const

  tblConfig_SQL =
    'CREATE TABLE tblconfig ( ' +
  	'ID INT(11) NOT NULL AUTO_INCREMENT, ' +
	  'ConfigName VARCHAR(255) NULL DEFAULT NULL, ' +
	  'ConfigValue MEDIUMTEXT NULL, ' +
    'PRIMARY KEY (ID), ' +
	  'INDEX ConfigNameIdx (ConfigName) ' +
	  ') ' +
	  'ENGINE=InnoDB COMMENT="TableVersion 1";';


implementation

uses
  MySQLUtils, DbConst, classes;

{ TConfigDb }

procedure TConfigDb.CheckDb;
var
  sl: TStringList;
begin
  if not fDbOk then begin
    fConn.Server := fServerName;
    fConn.Database := MYSQL_DATABASE;
    fConn.Connect;
    sl := TStringList.Create;
    try
      fConn.GetDatabaseNames(sl);
      if sl.IndexOf(SERVICES_DATABASE) < 0 then begin
        fConn.ExecSQL('create database ' + SERVICES_DATABASE,[]);
        fConn.Disconnect;
        fConn.Database:= SERVICES_DATABASE;
        fConn.Connect;
        fConn.ExecSQL(tblConfig_SQL, []);
      end
      else begin
        fConn.Disconnect;
        fConn.Database:= SERVICES_DATABASE;
        fConn.Connect;
        fConn.GetTableNames(sl);
        if sl.IndexOf('tblconfig') < 0 then begin
          fConn.ExecSQL(tblConfig_SQL, []);
        end
        else begin
          CheckUpdateTable('tblconfig',tblConfig_SQL,fConn);
        end;
      end;
      fConn.Disconnect;
    finally
      sl.Free;
    end;
    fDbOk := True;
  end;
end;

constructor TConfigDb.Create(const aConfigName, aServerName: string);
var
  sl: TStringList;
begin
  fConfigName := aConfigName;
  fServerName := aServerName;
  fDbOk := false;
  fConn := TErpConnection.Create(nil);
  MySQLUtils.SetConnectionProps(fConn,MYSQL_DATABASE,fServerName);
  sl := TStringList.Create;
  try
    sl.CaseSensitive := false;
    fConn.Connect;
    fConn.GetDatabaseNames(sl);
    if sl.IndexOf(SERVICES_DATABASE) < 0 then
      fConn.ExecSQL('CREATE DATABASE ' + SERVICES_DATABASE, []);
    fConn.Disconnect;
  finally
    sl.Free;
  end;
  fQry := TErpQuery.Create(nil);
  fQry.Connection := fConn;
  fQry.SQL.Add('SELECT * FROM tblconfig');
  fQry.SQL.Add('WHERE ConfigName = :ConfigNameParam');
end;

destructor TConfigDb.Destroy;
begin
  fQry.Free;
  fConn.Free;
  inherited;
end;

function TConfigDb.GetExists: Boolean;
begin
  CheckDb;
  fConn.Connect;
  fQry.ParamByName('ConfigNameParam').AsString := fConfigName;
  fQry.Open;
  Result := not fQry.IsEmpty;
  fQry.Close;
  fConn.Disconnect;
end;

function TConfigDb.GetValue: string;
begin
  CheckDb;
  fConn.Connect;
  fQry.ParamByName('ConfigNameParam').AsString := fConfigName;
  fQry.Open;
  Result := fQry.FieldByName('ConfigValue').AsString;
  fQry.Close;
  fConn.Disconnect;
end;

procedure TConfigDb.SetServerName(const aValue: string);
begin
  fServerName := aValue;
  fDbOk:= false;
end;

procedure TConfigDb.SetValue(const aValue: string);
begin
  CheckDb;
  fConn.Connect;
  fQry.ParamByName('ConfigNameParam').AsString:= fConfigName;
  fQry.Open;
  if fQry.IsEmpty then begin
    fQry.Insert;
    fQry.FieldByName('ConfigName').AsString:= fConfigName;
  end
  else
    fQry.Edit;
  fQry.FieldByName('ConfigValue').AsString:= aValue;
  fQry.Post;
  fQry.Close;
  fConn.Disconnect;
end;

end.
