unit dbUtils;

interface

uses
  contnrs;

type

  TErpDbRec = class
  private
  public
    DatabaseName: string;
    Version: string;
  end;

  TErpDbList = class
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItems(indx: integer): TErpDbRec;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[indx: integer]: TErpDbRec read GetItems;
    property Count: integer read GetCount;
    function ReadDatabaseInfo(aServer: string): boolean;
    function AnyNeedUpdating(aNewVersion: string): boolean;
  end;

implementation

uses
  MyAccess, MyClasses, classes;

const
  SYSDB_PASS = '1w$p&LD07';
  SYSDB_USER = 'P_One';
//  CONFIG_FILE = 'Connection.ini';
  MYSQL_DATABASE = 'mysql';
  MYSQL_PORT = 3309;


{ TErpDbList }

function TErpDbList.AnyNeedUpdating(aNewVersion: string): boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to Count -1 do begin
    if Items[x].Version < aNewVersion then begin
      result:= true;
      break;
    end;
  end;
end;

constructor TErpDbList.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TErpDbList.Destroy;
begin
  inherited;
  fList.Free;
end;

function TErpDbList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TErpDbList.GetItems(indx: integer): TErpDbRec;
begin
  result:= TErpDbRec(flist[indx]);
end;

function TErpDbList.ReadDatabaseInfo(aServer: string): boolean;
var
  con: TMyConnection;
  qry: TMyQuery;
  dbList, tableList: TStringList;
  x: integer;
  version: string;
  rec: TErpDbRec;
begin
  result:= false;
  fList.Clear;
  dbList:= TStringList.Create;
  tableList:= TStringList.Create;
  con:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  try
    con.Server           := aServer;
    con.Database         := MYSQL_DATABASE;
    con.Username         := SYSDB_USER;
    con.Password         := SYSDB_PASS;
    con.Port             := MYSQL_PORT;
    con.Options.Compress := false;
    con.Options.Protocol := mpDefault;
    con.LoginPrompt      := false;
    qry.Connection:= con;
    qry.SQL.Text:= 'SELECT ID, Version FROM tblupdatedetails Where ID = 1';
    try
      con.Connect;
    except
    end;
    if con.Connected then begin
      con.GetDatabaseNames(dbList);
      con.Disconnect;
      for x:= 0 to dbList.Count -1 do begin
        con.Database:= dbList[x];
        try
          con.Connect;
        except
        end;
        if con.Connected then begin
          con.GetTableNames(tableList);
          if tableList.Count > 300 then begin   { probably an ERP database }
            try
              qry.Open;
              version:= qry.FieldByName('Version').AsString;
            except
              version:= '';
            end;
            qry.Close;
            if version <> '' then begin
              rec:= TErpDbRec.Create;
              rec.DatabaseName:= dbList[x];
              rec.Version:= version;
              fLIst.Add(rec);
            end;
          end;
        end;
        con.Disconnect;
      end;
      result:= true;
    end;
  finally
    dbList.Free;
    tableList.Free;
    qry.Free;
    con.Free;
  end;
end;

end.
