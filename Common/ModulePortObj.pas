unit ModulePortObj;

interface

type

  TModulePort = class(TObject)
  private
    fServer: string;
  public
    constructor Create;
    property Server: string read fServer write fServer;
    function DoGetModulePort(aModuleName: string; RenewPort: boolean = false): integer;
    class function GetModulePort(aModuleName: string; RenewPort: boolean = false;  aServer: string = '127.0.0.1'): integer;
    class procedure ClearPortList(aServer: string = '127.0.0.1');
  end;

implementation

uses
  {ERPDbComponents, MyAccess, DBUtils,}

  {$IfDef VER220}
  DB,
  {$Else}
  Data.DB,
  {$EndIf  }
  DbGen, DbConst, classes, SysUtils, IdHttpServer;

const
  PortTableName = 'tblModulePorts';
  FirstModulePort = 49502;

{ TModulePort }

class procedure TModulePort.ClearPortList(aServer: string);
var
  Conn: TDbConnection;
  qry: TDbQuery;
begin
  Conn := TDbGen.NewConnection(MYSQL_DATABASE, aServer);
  qry := TDbQuery.Create(nil);
  try
    qry.DBConnection := Conn;
    Conn.Connect;
    qry.SQL.Add('TRUNCATE TABLE `' + PortTableName + '`;');
    try
      qry.Execute;
    except

    end;
  finally
    qry.Free;
    Conn.Free;
  end;

end;

constructor TModulePort.Create;
begin
  fServer := '127.0.0.1';
end;

function TModulePort.DoGetModulePort(aModuleName: string; RenewPort: Boolean = false): Integer;
var
  Conn: TDbConnection; //TMyConnection;
  sl: TStringList;
  qry: TDbQuery; //TERPQuery;
  PortNo: integer;

  function PortOpen: boolean;
//  var
//    svr: TIDHttpServer;
  begin
    result := true;
//    svr := TIDHttpServer.Create(nil);
//    try
//      svr.DefaultPort := PortNo;
//      try
//        svr.Active := true;
//      except
//        result := false;
//        exit;
//      end;
//      svr.Active := false;
//      svr.DefaultPort := PortNo + 1;
//      try
//        svr.Active := true;
//      except
//        result := false;
//        exit;
//      end;
//    finally
//      svr.Free;
//    end;
  end;

begin
  Result := 0;
  Conn := TDbGen.NewConnection(MYSQL_DATABASE, Server); //  DBUtils.GetNewDbConnection(Server,MYSQL_DATABASE);
  qry := TDbQuery.Create(nil); // TERPQuery.Create(nil);
  sl := TStringList.Create;
  try
    qry.DbConnection := Conn;
    sl.CaseSensitive := False;
    Conn.Connect;
    Conn.GetDatabaseNames(sl);
    if sl.IndexOf(SERVICES_DATABASE) < 0 then begin
      qry.SQL.Text := 'CREATE DATABASE ' + SERVICES_DATABASE;
      qry.Execute;
    end;
    Conn.Disconnect;
    Conn.Database := SERVICES_DATABASE;
    Conn.Connect;
    Conn.GetTableNames(sl);
    if sl.IndexOf(PortTableName) < 0 then begin
      qry.SQL.Clear;
      qry.SQL.Add('CREATE TABLE `' + PortTableName+'` (');
      qry.SQL.Add('`Id` INT(11) NOT NULL AUTO_INCREMENT,');
      qry.SQL.Add('`ModuleName` VARCHAR(255) NULL DEFAULT NULL,');
      qry.SQL.Add('`PortNumber` INT(11) NULL DEFAULT NULL,');
      qry.SQL.Add('PRIMARY KEY (`Id`)');
      qry.SQL.Add(')');
      qry.SQL.Add('ENGINE=InnoDB;');
      qry.Execute;
    end;
    if RenewPort then begin
      qry.SQL.Text := 'DELETE FROM ' + PortTableName + ' WHERE ModuleName = ' + QuotedStr(aModuleName);
      qry.Execute;
    end;
    qry.SQL.Text := 'SELECT * FROM ' + PortTableName + ' WHERE ModuleName = ' + QuotedStr(aModuleName);
    qry.Open;
    if not qry.IsEmpty then begin
      result := qry.FieldByName('PortNumber').AsInteger;
      exit;
    end;
    qry.Close;
    PortNo := 0;
    while result = 0 do begin
      if PortNo = 0 then begin
        qry.SQL.Text := 'SELECT max(PortNumber) as MaxPort from ' + PortTableName;
        qry.Open;
        PortNo := qry.FieldByName('MaxPort').AsInteger;
        qry.Close;
      end;
      if PortNo = 0 then PortNo := FirstModulePort
      else PortNo := PortNo + 2;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT INTO ' + PortTableName);
      qry.SQL.Add('(ModuleName, PortNumber) values');
      qry.SQL.Add('(' + QuotedStr(aModuleName) + ',' + IntToStr(PortNo) + ')');
      qry.Execute;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT * FROM ' + PortTableName);
      qry.SQL.Add('WHERE PortNumber = ' + IntToStr(PortNo));
      qry.Open;
      if qry.RecordCount = 1 then begin
        if PortOpen then
          Result := PortNo;

      end;
      qry.Close;
      if Result = 0 then  begin
        qry.SQL.Text := 'DELETE FROM ' + PortTableName + ' WHERE ModuleName = ' + QuotedStr(aModuleName);
        qry.Execute;
      end;
    end;

  finally
    Conn.Free;
    sl.Free;
    qry.Free;
  end;
end;

class function TModulePort.GetModulePort(aModuleName: string; RenewPort: Boolean = False; aServer: string = '127.0.0.1'): Integer;
var
  ModPort: TModulePort;
begin
  ModPort := TModulePort.Create;
  try
    ModPort.Server := aServer;
    Result := ModPort.DoGetModulePort(aModuleName, RenewPort);
  finally
    ModPort.Free;
  end;
end;

end.
