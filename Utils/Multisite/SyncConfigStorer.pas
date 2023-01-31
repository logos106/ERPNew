unit SyncConfigStorer;

interface

uses
  SyncConfigObj, DBUtils;

  function LoadConfigFromDb(Config: TSyncConfig; var msg: string): boolean;

implementation

uses Classes, MyAccess, ObjectStorerObj;

function LoadConfigFromDb(Config: TSyncConfig; var msg: string): boolean;
var
  serverInfo: TERPDbServerInfo;
  x: integer;
  sl: TStringList;
  dbConfig: TSyncDatabaseConfig;
  siteConfig: TSyncSiteItem;
  conn: TMyConnection;
  qry: TMyQuery;
  objStorer: TObjectStorer;
begin
  result:= true;
  if Config.MySQLServer <> '' then begin
    serverInfo:= TERPDbServerInfo.Create;
    try
      serverInfo.ServereName:= Config.MySQLServer;
//      sl:= TStringList.Create;
      if serverInfo.GetServerInfo then begin
        for x:= 0 to serverInfo.Count -1 do begin
          dbConfig:= Config.DatabaseByName(serverInfo.Databases[x].DatabaseName);
          if not Assigned(dbConfig) then begin
            dbConfig:= Config.Add;
            dbConfig.DatabaseName:= serverInfo.Databases[x].DatabaseName;
          end;
//          sl.Add(serverInfo.Databases[x].DatabaseName);
          { now get sites for this db }
          conn:= dbUtils.GetNewDbConnection(Config.MySQLServer, dbConfig.DatabaseName);
          if Assigned(conn) then begin
            try
              qry:= TMyQuery.Create(nil);
              try
                qry.Connection:= conn;
                qry.SQL.Text:= 'select * from tblmsbackendid';
                qry.Open;
                while not qry.Eof do begin
                  siteConfig:= dbConfig.SiteByCode(qry.FieldByName('SiteCode').asString);
                  if not Assigned(siteConfig) then begin
                    siteConfig:= dbConfig.Add;
                  end;



                  qry.Next;
                end;
              finally
                qry.Free;
              end;
            finally
              conn.Free;
            end;
          end
          else begin
            result:= false;
            msg:= 'Could not connect to database: "' + Config.MySQLServer + '@' + dbConfig.DatabaseName + '"';
            break;
          end;
        end;
      end
      else begin
        result:= false;
        msg:= 'Could not connect to server "' + Config.MySQLServer + '"';
      end;
    finally
//      sl.Free;
      serverInfo.Free;
    end;
  end
  else begin
    result:= false;
    msg:= 'No server name specified';
  end;  
end;

end.
