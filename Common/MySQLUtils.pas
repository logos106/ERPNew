unit MySQLUtils;

interface

uses
  MyAccess, classes, MemData, DBAccess, ConTnrs, ERPDbComponents;

type
  TConnectionInfo = class(TObject)
  public
    Server: string;
    Port: integer;
  end;

  TClusterConnectionHelper = class(TComponent)
  private
    fConnectionInfoList: TObjectList;
    procedure DoOnConnectionLost(Sender: TObject; Component: TComponent; ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
    procedure DoOnConnectionError(Sender: TObject; E: EDAError; var Fail: boolean);
    function TryNextServer: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetConnectionInfo(Info: string);
  end;


function GetMySQLServerVersion(const Server: string): string;
function GetMySQLBaseDir(const Server: string = '127.0.0.1'): string;
function GetMySQLDataDir(const Server: string): string;
function GetMySQLConfigFileName: string;
function MySQLTablePrimaryKey(const TableName: string; Connection: TMyConnection; var HasGlobalRef: boolean): string;
function DatabaseList(Conn: TMyConnection; erpOnly: boolean): string; overload;
function DatabaseList(Server: string = '127.0.0.1'; erpOnly: boolean = true): string; overload;
function MYSQLShorDateFormat:String;
procedure SetConnectionProps(connection: TMyConnection;
  Database: string = ''; Server: string = '127.0.0.1'); overload;
procedure SetConnectionProps(Conn, SourceConn: TMyConnection); overload;


function TableExists(aConnection: TMyConnection; const TableName: string): boolean;

procedure ReadTableStructrue(tablename :String; tableStructure: TStringlist; Conn: TMyConnection); overload;
function ReadTableStructrue(tablename: String; Conn: TMyConnection): String; overload;
function GetMySQLTableCount(const DatabaseName: string; const Server: string = '127.0.0.1'): integer;

procedure SetConnectionServer(Conn: TMyConnection; Server: string);
//function NewMyDacConnection(const Owner: TComponent): TERPConnection; Overload;
//function NewMyDacConnection(const Owner: TComponent; Databasename: string): TERPConnection; Overload;
procedure GetTableList(Conn: TMyConnection; aList: TStringList; IncludeViews: boolean = false);

function TableVersionFromCreateSQL(createSQL: string): integer;

procedure CheckUpdateTable(aTableName, aNewCreateSQL: string; Conn: TMyConnection);

function GetMySQLTempDir(aConnection: TERPConnection): string;

//function IsERPDatabase(Conn: TMyConnection; aDbName: string): boolean;


implementation

uses
  DB, DbConst, AppRunUtils, sysutils, strutils, DbSharedObjectsObj,
  InstallConst, Types;

var
  MySQLTempDir_LastServer: string = '';
  MySQLTempDir_LastDatabase: string = '';
  MySQLTempDir_Value: string = '';



//function IsERPDatabase(Conn: TMyConnection; aDbName: string): boolean;
//var
//  qry: TMyQuery;
//begin
//  qry := TMyQuery.Create(nil);
//
//end;

procedure SetConnectionProps(connection: TMyConnection;
  Database: string = ''; Server: string = '127.0.0.1');
begin
//  Connection.Port:= DbConst.SERVER_PORT;
  Connection.Options.Compress:= DbConst.MYDAC_OPTIONS_COMPRESS;
  Connection.Options.Protocol:= DbConst.MYDAC_OPTIONS_PROTOCOL;
  Connection.Username:= DbConst.SYSDB_USER;
  Connection.Password:= DbConst.SYSDB_PASS;
  Connection.LoginPrompt:= false;
  Connection.Options.UseUnicode := true;
//  Connection.Server:= Server;
  Connection.Database:= Database;
  SetConnectionServer(Connection,Server);
end;

procedure SetConnectionProps(Conn, SourceConn: TMyConnection); overload;
begin
  Conn.Port:= SourceConn.Port;
  Conn.Options.Compress:= SourceConn.Options.Compress;
  Conn.Options.Protocol:= SourceConn.Options.Protocol;
  Conn.Username:= SourceConn.Username;
  Conn.Password:= SourceConn.Password;
  Conn.LoginPrompt:= SourceConn.LoginPrompt;
  Conn.Options.UseUnicode := SourceConn.Options.UseUnicode;
  Conn.Server:= SourceConn.Server;
  Conn.Database:= SourceConn.Database;
end;

function GetMySQLServerVersion(const Server: string): string;
var
  Conn: TMyConnection;
  qry: TMyQuery;
begin
  Result := '';
  Conn := TMyConnection.Create(nil);
  qry := TMyQuery.Create(nil);
  try
    SetConnectionProps(conn,MYSQL_DATABASE,Server);
    qry.Connection := conn;
    try
      conn.Connect;
      qry.SQL.Text := 'select version()';
      qry.Open;
      Result := qry.Fields[0].AsString;
      qry.Close;
      conn.Disconnect;
    except
      Result := '';
    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;

function GetMySQLBaseDir(const Server: string): string;
var
  Conn: TMyConnection;
  qry: TMyQuery;
begin
  result:= '';
  Conn:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  try
    SetConnectionProps(conn,MYSQL_DATABASE,Server);
    qry.Connection:= conn;
    try
      conn.Connect;
      qry.SQL.Text:= 'show variables like "basedir"';
      qry.Open;
      result:= qry.Fields[1].AsString;
      qry.Close;
      conn.Disconnect;
    except
      result:= '';
    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;

function GetMySQLDataDir(const Server: string): string;
var
  Conn: TMyConnection;
  qry: TMyQuery;
begin
  result:= '';
  Conn:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  try
    SetConnectionProps(conn,MYSQL_DATABASE,'127.0.0.1');
    qry.Connection:= conn;
    try
      conn.Connect;
      qry.SQL.Text:= 'show variables like "datadir"';
      qry.Open;
      result:= qry.Fields[1].AsString;
      qry.Close;
      conn.Disconnect;
    except
      result:= '';
    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;

function GetMySQLConfigFileName: string;
var
  s: string;
  sl: TStringList;
  x: integer;
  y: integer;
begin
  result:= '';
//  s:= GetServiceExecutablePath('','MySQL_ERP');
  s := GetServiceExecutablePath('', MySQL_ERP_SERVICE);
  if s <> '' then begin
    sl:= TStringList.Create;
    try
      sl.CommaText:= s;
      for x:= 0 to sl.Count -1 do begin
        s:= Lowercase(sl[x]);
        y:= Pos('file=',s);
        if y > 0 then begin
          s:= Copy(s,y+5,Length(s));
          s:= ReplaceText(s,'"','');
          result:= s;
          break;
        end;
      end;
    finally
      sl.Free;
    end;
  end;
end;

function MySQLTablePrimaryKey(const TableName: string; Connection: TMyConnection; var HasGlobalRef: boolean): string;
var
  qry: TMyQuery;
begin
  Result := '';
  qry := TMyQuery.create(nil);
  qry.Options.FlatBuffers := true;
  try
    qry.Connection := Connection;
    qry.SQL.Text := 'DESCRIBE `' + TableName + '`;';
    qry.Open;
    if qry.Locate('Key', 'PRI', [loCaseInsensitive]) then Result := qry.Fields[0].asString;
    HasGlobalRef := qry.Locate('Field', 'GlobalRef', [loCaseInsensitive]);

  finally FreeAndNil(qry);
  end;
end;

function DatabaseList(Conn: TMyConnection; erpOnly: boolean): string;
var
  sl: TStringList;
  qry: TMyQuery;
  x: integer;

  function IsERPDatabase(aDbName: string): boolean;
  begin
    result:= false;
    conn.Database:= aDbName;
    conn.Connect;
    qry.SQL.Text:= 'show tables';
    qry.Open;
    if qry.RecordCount > 300 then begin
      qry.Close;
      qry.SQL.Text:= 'show tables like "tblupdatedetails"';
      qry.Open;
      if not qry.IsEmpty then
        result:= true;
    end;
    qry.Close;
    conn.Disconnect;
  end;

begin
  result:= '';
  try
    sl:= TStringList.Create;
    qry:= TMyQuery.Create(nil);
    try
      conn.Disconnect;
      qry.Connection:= conn;
      conn.Database:= MYSQL_DATABASE;
      conn.Connect;
      conn.GetDatabaseNames(sl);
      conn.Disconnect;
      if (sl.IndexOf('erpnewdb') > -1) and (sl.IndexOf('erpnewdb') <> 0) then begin
        sl.Delete(sl.IndexOf('erpnewdb'));
        sl.Insert(0, 'erpnewdb');
      end;
      if erpOnly then begin
        x:= 0;
        while x < sl.Count do begin
          if IsERPDatabase(sl[x]) then
            Inc(x)
          else
            sl.Delete(x);
        end;
      end;
      result:= sl.CommaText;
    finally
      sl.Free;
      qry.Free;
    end;
  except
  end;
end;

function DatabaseList(Server: string = '127.0.0.1'; erpOnly: boolean = true): string;
var
  conn: TMyConnection;
begin
  conn := TMyConnection.Create(nil);
  try
    SetConnectionProps(conn,MYSQL_DATABASE,Server);
    conn.Connect;
    result := DatabaseList(conn,erpOnly);
 finally
    conn.Free;
  end;
end;


function MYSQLShorDateFormat:String;
begin
  REsult:= FormatSettings.ShortDateFormat;
  REsult:= replaceStr(result , 'ddd' , '%D');
  REsult:= replaceStr(result , 'dd' , '%d');
  REsult:= replaceStr(result , 'd' , '%d');

  REsult:= replaceStr(result , 'mmmm' , '%M');
  REsult:= replaceStr(result , 'mmm' , '%M');
  REsult:= replaceStr(result , 'mm' , '%m');
  REsult:= replaceStr(result , 'MM' , '%m');
  REsult:= replaceStr(result , 'm' , '%m');

  REsult:= replaceStr(result , 'yyyy' , '%Y');
  REsult:= replaceStr(result , 'yyyy' , '%Y');
  REsult:= replaceStr(result , 'yy' , '%y');
  REsult:= replaceStr(result , 'y' , '%y');
  REsult:= replaceStr(result , '%%' , '%');
end;

function TableExists(aConnection: TMyConnection; const TableName: string): boolean;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  try
    qryTemp.Connection := aConnection;
    qryTemp.Sql.Add('SHOW TABLES LIKE ' + QuotedStr(TableName));
    qryTemp.Open;
    Result := not qryTemp.IsEmpty;
  finally
    qryTemp.Free;
  end;
end;

procedure ReadTableStructrue(tablename :String; tableStructure: TStringlist; Conn: TMyConnection);
begin
  tableStructure.Text := ReadTableStructrue(tablename, Conn);
end;

function ReadTableStructrue(tablename: String; Conn: TMyConnection): String ;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(Conn);
  try
    qry.SQL.Text := 'Show create table ' +Tablename;
    qry.Open;
    result := qry.fields[1].asString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function GetMySQLTableCount(const DatabaseName: string; const Server: string = '127.0.0.1'): integer;
var
  Conn: TMyConnection;
  qry: TMyQuery;
begin
  Conn:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  try
    SetConnectionProps(conn,MYSQL_DATABASE,Server);
    qry.Connection:= conn;
    try
      conn.Connect;
      qry.SQL.Text:= 'select COUNT(*) from information_schema.tables where table_schema = ' + QuotedStr(DatabaseName);
      qry.Open;
      result:= qry.Fields[0].AsInteger;
      qry.Close;
      conn.Disconnect;
    except
      result:= 0;
    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;

procedure SetConnectionServer(Conn: TMyConnection; Server: string);
var
  SvrArr: TStringDynArray;
  Arr: TStringDynArray;
  x: integer;
begin
  SvrArr := SplitString(Server,',');
  if Length(SvrArr) =1 then begin
    { single server }
    Arr := SplitString(Server,':');
    Conn.Server := Arr[0];
    if Length(Arr) = 2 then
      Conn.Port := StrToInt(Arr[1])
    else
      Conn.Port := DbConst.SERVER_PORT;
  end
  else begin
    { cluster of servers }
    x := 0;
    while x < Conn.ComponentCount do begin
      if Conn.Components[x] is TClusterConnectionHelper then Conn.Components[x].Free
      else inc(x);
    end;
    with TClusterConnectionHelper.Create(Conn) do
      SetConnectionInfo(Server)
  end;
end;

{ TClusterConnectionHelper }

constructor TClusterConnectionHelper.Create(AOwner: TComponent);
begin
  inherited;
  fConnectionInfoList := TObjectList.Create;
  TMyConnection(AOwner).OnConnectionLost := DoOnConnectionLost;
  TMyConnection(AOwner).OnError := DoOnConnectionError;
  TMyConnection(AOwner).Options.LocalFailover := true;
end;

destructor TClusterConnectionHelper.Destroy;
begin
  fConnectionInfoList.Free;
  inherited;
end;

procedure TClusterConnectionHelper.DoOnConnectionError(Sender: TObject;
  E: EDAError; var Fail: boolean);
begin
  if POS('Can''t connect to MySQ', E.Message) > 0 then begin
    if TryNextServer then begin
      try
        TMyConnection(Sender).Connect;
      except

      end;
    end;
  end;
end;

procedure TClusterConnectionHelper.DoOnConnectionLost(Sender: TObject;
  Component: TComponent; ConnLostCause: TConnLostCause;
  var RetryMode: TRetryMode);
begin
  if TryNextServer then begin
    RetryMode := rmReconnectExecute;
    try
      TMyConnection(Sender).Connect;
    except

    end;
  end
  else
  RetryMode := rmRaise;
end;

procedure TClusterConnectionHelper.SetConnectionInfo(Info: string);
var
  SvrArr: TStringDynArray;
  Arr: TStringDynArray;
  x: Integer;
  InfoRec: TConnectionInfo;
begin
  SvrArr := SplitString(Info,',');
  for x := Low(SvrArr) to High(SvrArr) do begin
    Arr := SplitString(SvrArr[x],':');
    InfoRec := TConnectionInfo.Create;
    InfoRec.Server := Arr[0];
    if Length(Arr) = 2 then InfoRec.Port := StrToInt(Arr[1])
    else InfoRec.Port := DbConst.SERVER_PORT;
    fConnectionInfoList.Add(InfoRec);
    if x = 0 then begin
      TMyConnection(Owner).Server := InfoRec.Server;
      TMyConnection(Owner).Port := InfoRec.Port;
    end;
  end;

end;

function TClusterConnectionHelper.TryNextServer: boolean;
var
//  CurrentServer: string;
  x, y: integer;
begin
  result := false;
//  x:= 0;
  for x := 0 to fConnectionInfoList.Count -1 do begin
    if SameText(TConnectionInfo(fConnectionInfoList[x]).Server, TMyConnection(Owner).Server) and
       (TConnectionInfo(fConnectionInfoList[x]).Port = TMyConnection(Owner).Port) then begin
      if x < fConnectionInfoList.Count -1 then y := x + 1
      else y := 0;
      result := true;
      TMyConnection(Owner).Server := TConnectionInfo(fConnectionInfoList[y]).Server;
      TMyConnection(Owner).Port := TConnectionInfo(fConnectionInfoList[y]).Port;
      exit;
    end;
  end;
end;

//function NewMyDacConnection(const Owner: TComponent): TERPConnection;
//begin
//  result := TERPConnection.Create(Owner);
//  SetConnectionProps(result);
//end;
//
//function NewMyDacConnection(const Owner: TComponent; Databasename: string): TERPConnection;
//begin
//  result := NewMyDacConnection(Owner);
//  result.Database := DatabaseName;
//end;

procedure GetTableList(Conn: TMyConnection; aList: TStringList; IncludeViews: boolean = false);
var
  qry: TMyQuery;
begin
  if IncludeViews then
    Conn.GetTableNames(aList, false)
  else begin
    qry := TMyQuery.Create(nil);
    try
      qry.Connection := Conn;
      qry.SQL.Text := 'Show Full Tables';
      qry.Open;
      while not qry.Eof do begin
        if not SameText(qry.Fields[1].AsString,'VIEW') then
          aList.Add(qry.Fields[0].AsString);

        qry.Next;
      end;

    finally
      qry.Free;
    end;
  end;
end;

function TableVersionFromCreateSQL(createSQL: string): integer;
var
  x: integer;
  s, sVer: string;
begin
  result := 0;
  x:= Pos('TableVersion',createSQL);
  if x > 0 then begin
    s := Copy(createSQL,x + Length('TableVersion'),Length(createSQL));
    sVer := '';
    for x := 1 to Length(s) do begin
      if CharInSet(s[x], [' ','0'..'9']) then
        sVer := sVer + s[x]
      else
        break;
    end;
    result := StrToIntDef(Trim(sVer),0);
  end;
end;

procedure CheckUpdateTable(aTableName, aNewCreateSQL: string; Conn: TMyConnection);
var
  CurrentCreateSQL: string;
  TempTableName: string;
  cmd: TMyCommand;
  qrySource, qryDest: TMyQuery;
  I: Integer;
  fieldSource, fieldDest: TField;
  HasGlobalRef: boolean;
  PrimaryKeyName: string;
begin
  CurrentCreateSQL := ReadTableStructrue(aTableName, Conn);
  if TableVersionFromCreateSQL(aNewCreateSQL) > TableVersionFromCreateSQL(CurrentCreateSQL) then begin
    PrimaryKeyName := MySQLTablePrimaryKey(aTableName,Conn,HasGlobalRef);
    TempTableName := aTableName + '_tmp';
    cmd := TMyCommand.Create(nil);
    qrySource := TMyQuery.Create(nil);
    qryDest := TMyQuery.Create(nil);
    try
      cmd.Connection := Conn;
      qrySource.Connection := Conn;
      qryDest.Connection := Conn;
      cmd.SQL.Text := 'RENAME TABLE ' + aTableName + ' TO ' + TempTableName + ';';
      cmd.Execute;

      cmd.SQL.Text := aNewCreateSQL;
      cmd.Execute;

      qrySource.SQL.Text := 'SELECT * FROM ' +  TempTableName;
      qrySource.Open;
      qryDest.SQL.Text := 'SELECT * FROM ' + aTableName + ' LIMIT 1';
      qryDest.Open;

      while not qrySource.Eof do begin
        qryDest.Insert;
        for I := 0 to qrySource.Fields.Count -1 do begin
          fieldSource := qrySource.Fields[I];
          if (not SameText(fieldSource.FieldName, PrimaryKeyName)) and (not SameText(fieldSource.FieldName,'GlobalRef')) then begin
            fieldDest := qryDest.FindField(fieldSource.FieldName);
            if Assigned(fieldDest) then begin
              if not fieldSource.IsNull then
                fieldDest.Value := fieldSource.Value;
            end;
          end;
        end;
        qryDest.Post;
        qrySource.Next;
      end;

      cmd.SQL.Text := 'DROP TABLE ' + TempTableName;
      cmd.Execute;

    finally
      cmd.Free;
      qrySource.Free;
      qryDest.Free;
    end;
  end;
end;

function GetMySQLTempDir(aConnection: TERPConnection): string;
begin
  if (MySQLTempDir_Value = '') or
     (MySQLTempDir_LastServer <> aConnection.Server) or
     (MySQLTempDir_LastDatabase <> aConnection.Database) then begin

    MySQLTempDir_LastServer := aConnection.Server;
    MySQLTempDir_LastDatabase := aConnection.Database;
    with TERPQuery.Create(nil) do begin
      try
        Connection := aConnection;
        SQL.Text:= 'select @@tmpdir';
        Open;
        MySQLTempDir_Value:= Fields[0].AsString+'\';
      finally
        Free;
      end;
    end;
  end;
  result := MySQLTempDir_Value;
end;

end.
