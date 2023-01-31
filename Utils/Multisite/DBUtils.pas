unit DBUtils;

interface

uses
  Classes, MyAccess, DbConst;

type
  TERPDbInfo = class(TCollectionItem)
  private
    fDatabaseName: string;
    fVersion: string;
  public
    property DatabaseName: string read fDatabaseName write fDatabaseName;
    property Version: string read fVersion write fVersion;
  end;

  TERPDbServerInfo = class(TCollection)
  private
    fServerName: string;
    function GetDatabase(idx: integer): TERPDbInfo;
  public
    constructor Create;
    property ServereName: string read fServerName write fServerName;
    property Databases[idx: integer]: TERPDbInfo read GetDatabase;
    function GetServerInfo: boolean;
    function Add: TERPDbInfo;
  end;

  function GetNewDbConnection(ServerName: string = ''; DatabaseName: string = ''): TMyConnection;
  function GetDefaultSiteCode(Conn: TMyConnection): string;

implementation

uses
  MySQLErrors, MyClasses;

function GetNewDbConnection(ServerName: string = ''; DatabaseName: string = ''): TMyConnection;
begin
  result:= TMyConnection.Create(nil);
  result.Username:= SYSDB_USER;
  result.Password:= SYSDB_PASS;
  result.Options.Compress := MYDAC_OPTIONS_COMPRESS;
  result.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
  result.Port := SERVER_PORT;
  result.LoginPrompt:= false;
  result.Server:= ServerName;
  result.Database:= DatabaseName;
end;

function GetDefaultSiteCode(Conn: TMyConnection): string;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= conn;
    qry.SQL.Text:= 'select SiteCode from tblmsbackendid where BEDefault = "T"';
    qry.Open;
    result:= qry.Fields[0].AsString;
  finally
    qry.Free;
  end;
end;


{ TERPDbServerInfo }

function TERPDbServerInfo.Add: TERPDbInfo;
begin
  result:= TERPDbInfo(inherited Add);
end;

constructor TERPDbServerInfo.Create;
begin
  inherited Create(TERPDbInfo);
end;

function TERPDbServerInfo.GetDatabase(idx: integer): TERPDbInfo;
begin
  result:= TERPDbInfo(Items[idx]);
end;

function TERPDbServerInfo.GetServerInfo: boolean;
var
  conn: TMyConnection;
  dbList, tableList: TStringList;
  x: integer;
  qry: TMyQuery;
  item: TERPDbInfo;
begin
  result:= false;
  Clear;
  conn:= GetNewDbConnection(fServerName,'mysql');
  if Assigned(conn) then begin
    try
      dbList:= TStringList.Create;
      tableList:= TStringList.Create;
      try
        conn.GetDatabaseNames(dbList);
        for x:= 0 to dbList.Count -1 do begin
          conn.Disconnect;
          conn.Database:= dbList[x];
          try
            conn.Connect;
            conn.GetTableNames(tableList);
            if (TableList.Count > 200) and (tableList.IndexOf('tblupdatedetails') > -1) then begin
              result:= true;
              item:= Add;
              item.DatabaseName:= dbList[x];
              qry:= TMyQuery.Create(nil);
              try
                qry.Connection:= conn;
                qry.SQL.Text:= 'select * from tblupdatedetails';
                qry.Open;
                item.Version:=  qry.FieldByName('version').AsString;
              finally
                qry.Free;
              end;
            end;
          except
            on E: EMyError do;
            on E: EMySqlException do;
            else
              raise;
          end;
        end;
      finally
        dbList.Free;
        tableList.Free;
      end;
    finally
      conn.Free;
    end;    
  end;
end;

end.
