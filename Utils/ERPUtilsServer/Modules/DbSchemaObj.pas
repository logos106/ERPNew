unit DbSchemaObj;

interface

uses
  MyAccess, JsonObject;

type
  TDBSchema = class
  private
    fValidationResultMessage: string;
    FDatabaseName: string;
    FMySqlServer: string;
    fSchema: TJsonObject;
    procedure SetDatabaseName(const Value: string);
    procedure SetMySqlServer(const Value: string);
    procedure SetUpConnection(Conn: TMyConnection; aDatabaseName: string);
    function CreateTable(tableName: string; conn: TMyConnection): boolean;
    function ValidateTable(tableName: string; conn: TMyConnection): boolean;
    function FieldCreatString(aFieldName: string; fld: TJsonObject): string;
  public
    constructor Create;
    destructor Destroy; override;
    property MySqlServer: string read FMySqlServer write SetMySqlServer;
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property Schema: TJsonObject read fSchema write fSchema;
    property ValidationResultMessage: string read fValidationResultMessage;
    function ValidateSchema: boolean;
    class function ValidateDbSchema(const aServer, aDatabase: string;
      aSchema: TJsonObject; var msg: string; const FirstTimeOnly: boolean = true): boolean;
  end;


implementation

uses
  DbConst, sysutils, classes, DB, MyScript;

var
  LastServer, LastDatabase: string;

{ DBSchema }

constructor TDBSchema.Create;
begin
  fValidationResultMessage:= '';
end;

function TDBSchema.CreateTable(tableName: string; conn: TMyConnection): boolean;
var
  cmd: TMyCommand;
  x: integer;
  s: string;
  fld, idx: TJsonObject;
begin
  result:= false;
  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection:= conn;
    cmd.SQL.Add('create table ' + tablename + '(');
    for x:= 0 to Schema.O['tables'].O[tableName].O['fields'].Count -1 do begin
      s:= Schema.O['tables'].O[tableName].O['fields'].Items[x].Name;
      fld:= Schema.O['tables'].O[tableName].O['fields'].O[s];
      s:= FieldCreatString(s,fld);
      if x > 0 then s:= ', ' + s;
      cmd.SQL.Add(s);
    end;
    for x:= 0 to Schema.O['tables'].O[tableName].O['indexes'].Count -1 do begin
      s:= Schema.O['tables'].O[tableName].O['indexes'].Items[x].Name;
      idx:= Schema.O['tables'].O[tableName].O['indexes'].O[s];
      if idx.BooleanExists('isprimary') and idx.B['isprimary'] then
        s:= 'primary key'
      else begin
        if idx.BooleanExists('isunique') and idx.B['isunique'] then
          s:= 'unique key'
        else
          s:= 'key';
        s:= s + ' ' + Schema.O['tables'].O[tableName].O['indexes'].Items[x].Name;
      end;
      s:= s + ' (' + idx.S['fields'] + ')';
      if x > 0 then s:= ', ' + s;
      cmd.SQL.Add(s);
    end;
    if Schema.O['tables'].O[tableName].StringExists('engine') then
      cmd.SQL.Add(')engine=' + Schema.O['tables'].O[tableName].S['engine'] + ';')
    else
      cmd.SQL.Add(');');
    try
      cmd.Execute;
      result:= true;
    except
      on e: exception do begin
        self.fValidationResultMessage:=
          'Faild while creating table "' + tableName + '": ' + e.Message;
      end;
    end;
  finally
    cmd.Free;
  end;
end;

destructor TDBSchema.Destroy;
begin

  inherited;
end;

function TDBSchema.FieldCreatString(aFieldName: string;
  fld: TJsonObject): string;
begin
  result:= aFieldName;
  if fld.S['datatype'] = 'string' then begin
    result:= result + ' varchar(' + IntToStr(fld.I['size']) + ')';
  end
  else if fld.S['datatype'] = 'integer' then begin
    result:= result + ' int(11)';
  end
  else if fld.S['datatype'] = 'double' then begin
    result:= result + ' double';
  end
  else if fld.S['datatype'] = 'datetime' then begin
    result:= result + ' datetime';
  end
  else if fld.S['datatype'] = 'boolean' then begin
    result:= result + ' enum(''T'',''F'')';
  end;
  if fld.BooleanExists('allownull') then begin
    if not fld.B['allownull'] then
      result:= result + ' not null';
  end;
  if fld.StringExists('default') then begin
    if fld.S['default'] = 'null' then
      result:= result + ' default null'
    else
      result:= result + ' default "' + fld.S['default'] + '"';
  end
end;

procedure TDBSchema.SetDatabaseName(const Value: string);
begin
  FDatabaseName := Value;
end;

procedure TDBSchema.SetMySqlServer(const Value: string);
begin
  FMySqlServer := Value;
end;

procedure TDBSchema.SetUpConnection(Conn: TMyConnection;
  aDatabaseName: string);
begin
  Conn.Disconnect;
  Conn.Username:= SYSDB_USER;
  Conn.Password:= SYSDB_PASS;
  Conn.Options.Compress := MYDAC_OPTIONS_COMPRESS;
  Conn.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
  Conn.Port := SERVER_PORT;
  Conn.LoginPrompt:= false;
  Conn.Server:= self.FMySqlServer;
  Conn.Database:= aDatabaseName;
end;

class function TDBSchema.ValidateDbSchema(const aServer, aDatabase: string;
  aSchema: TJsonObject; var msg: string; const FirstTimeOnly: boolean = true): boolean;
var
  inst: TDBSchema;
begin
  result:= false;
  msg:= '';
  if FirstTimeOnly and (LastServer = aServer) and (LastDatabase = aDatabase) then begin
    result:= true;
    exit;
  end;
  LastServer:= aServer;
  LastDatabase:= aDatabase;

  inst:= TDBSchema.Create;
  try
    inst.MySqlServer:= aServer;
    inst.DatabaseName:= aDatabase;
    inst.Schema:= aSchema;
    try
      result:= inst.ValidateSchema;
      if not result then
        msg:= inst.ValidationResultMessage;
    except
      on e: exception do begin
        result:= false;
        msg:= 'Exception while validating schema: ' + e.Message;
      end;
    end;
  finally
    inst.Free;
  end;
end;

function TDBSchema.ValidateSchema: boolean;
var
  Conn: TMyConnection;
  list, missingTables: TStringList;
  x: integer;
begin
  result:= false;
  Conn:= TMyConnection.Create(nil);
  list:= TStringList.Create;
  missingTables:= TStringList.Create;
  try
    SetUpConnection(Conn, MYSQL_DATABASE);
    try
      Conn.Connect;
    except
      on e: exception do begin
        fValidationResultMessage:=
          'Could not connect to MySQL Server: ' + e.Message;
        exit;
      end;
    end;
    conn.GetDatabaseNames(list);
    if list.IndexOf(FDatabaseName) < 0 then begin
      try
        conn.ExecSQL('create database ' + FDatabaseName + ';', []);
      except
        on e: exception do begin
          fValidationResultMessage:=
            'Could not create database "' + FDatabaseName + '": ' + e.Message;
          exit;
        end;
      end;
    end;
    SetUpConnection(Conn, FDatabaseName);
    try
      Conn.Connect;
    except
      on e: exception do begin
        fValidationResultMessage:=
          'Could not connect to database: ' + e.Message;
        exit;
      end;
    end;
    Conn.GetTableNames(list);
    for x:= 0 to Schema.O['tables'].Count -1 do begin
      if list.IndexOf(Schema.O['tables'].Items[x].Name) < 0 then begin
        { table does not exist so create it }
        if not CreateTable(Schema.O['tables'].Items[x].Name,Conn) then
          exit;
      end
      else begin
        { validate table structure }
        if not ValidateTable(Schema.O['tables'].Items[x].Name,Conn) then
          exit;
      end;
    end;
    result:= true;
  finally
    list.Free;
    missingTables.Free;
    Conn.Free;
  end;
end;

function TDBSchema.ValidateTable(tableName: string; conn: TMyConnection): boolean;
var
  qry: TMyQuery;
  fld: TJsonObject;
  dbFld: TField;
  x: integer;
  fldName: string;
  updateList: TStringList;
  fldOk: boolean;
  scr: TMyScript;
begin
  result:= false;
  qry:= TMyQuery.Create(nil);
  updateList:= TStringList.Create;
  try
    qry.Connection:= conn;
    qry.SQL.Text:= 'select * from ' + tableName + ' limit 0';
    qry.Open;
    for x:= 0 to Schema.O['tables'].O[tableName].O['fields'].Count -1 do begin
      fldName:= Schema.O['tables'].O[tableName].O['fields'].Items[x].Name;
      fld:= Schema.O['tables'].O[tableName].O['fields'].O[fldName];
      dbFld:= qry.FindField(fldName);
      if not Assigned(dbFld) then
        { new field so add it }
        updateList.Add('alter table ' + tablename + ' add ' + FieldCreatString(fldName,fld) + ';')
      else begin
        { check field def }
        fldOk:=
           (((fld.S['datatype'] = 'string') and (dbFld.DataType = ftString)) or
            ((fld.S['datatype'] = 'integer') and (dbFld.DataType in [ftInteger,ftAutoInc])) or
            ((fld.S['datatype'] = 'double') and (dbFld.DataType = ftFloat)) or
            ((fld.S['datatype'] = 'datetime') and (dbFld.DataType = ftDateTime)) or
            ((fld.S['datatype'] = 'boolean') and (dbFld.DataType = ftString)));

        if fldOk then
          if fld.IntegerExists('size') then
            fldOk:= (fld.I['size'] = dbfld.Size);
        if fldOk then
          if fld.BooleanExists('allownull') and (not fld.B['allownull']) then
            fldOk:= dbfld.Required;
        if not fldOk then
          updateList.Add('alter table ' + tablename + ' change ' + FieldCreatString(fldName,fld) + ';');
      end;
    end;
    if updateList.Count > 0 then begin
      scr:= TMyScript.Create(nil);
      try
        scr.Connection:= conn;
        scr.SQL.Text:= updateList.Text;
        try
          scr.Execute;
        except
          on e: exception do begin
            fValidationResultMessage:=
              'Failed to update table "' + tableName + '": '  + e.Message;
            exit;
          end;
        end;  
      finally
        scr.Free;
      end;
    end;
    result:= true;
  finally
    updateList.Free;
    qry.Free;
  end;
end;

initialization
  LastServer:= '';
  LastDatabase:= '';

end.
