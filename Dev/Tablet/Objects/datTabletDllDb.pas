unit datTabletDllDb;

interface

uses
  System.SysUtils, System.Classes,
  System.SyncObjs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Param,
  FireDAC.UI.Intf,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.DatS,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Data.DB,
  FireDAC.Comp.UI;

type
  TDataModule1 = class(TDataModule)
    Connection: TFDConnection;
    Query: TFDQuery;
    WaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnectionAfterConnect(Sender: TObject);
  private
    procedure CreateDatabase;
  public
    function OpenDatabase(const DbFileName: String): boolean;
    function CloseDatabase: boolean;
    function Save(
      const ObjectType: String;
      const ErpID: integer;
      const msTimeStamp: TDateTime;
      const msUpdateSiteCode: String;
      const Data: String;
      const ApiID: integer): integer;
  end;

var
  Db: TDataModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

//uses
//  FMX.Objects.TPath;

function TDataModule1.CloseDatabase: boolean;
begin
  result := true;
  if Connection.Connected then
    Connection.Connected := false;
end;

procedure TDataModule1.ConnectionAfterConnect(Sender: TObject);
begin
  CreateDatabase;
end;

procedure TDataModule1.CreateDatabase;
begin
  { Main table to store objects }
  Connection.ExecSQL(
    'CREATE TABLE IF NOT EXISTS ObjectData (' +
    'ID               INTEGER  PRIMARY KEY,' +
    'ApiID            INTEGER DEFAULT 0,' +
    'ObjectType       TEXT,' +
    'Status           INTEGER DEFAULT 0,'+
    'ErpID            INTEGER,' +
    'msTimeStamp      DATETIME,' +
    'msUpdateSiteCode TEXT,' +
    'LastModified     DATETIME,' +
    'Data             TEXT);'
  );
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  Connection.DriverName := 'SQLITE';
//  Connection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath,DB_NAME);
  Connection.Params.Values['LockingMode'] := 'Normal';
  Connection.Params.Values['SharedCache'] := 'False';

end;

function TDataModule1.OpenDatabase(const DbFileName: String): boolean;
begin
  CloseDatabase;
  Connection.Params.Values['Database'] := DbFileName;
  Connection.Connected := true;
  result := true;
end;

function TDataModule1.Save(
  const ObjectType: String;
  const ErpID: integer;
  const msTimeStamp: TDateTime;
  const msUpdateSiteCode,
  Data: String;
  const ApiID: integer): integer;
begin

  Connection.ExecSQL('INSERT INTO ObjectData (ApiID,ObjectType,ErpID,msTimeStamp,msUpdateSiteCode,Data)' +
    ' VALUES (:ApiID,:ObjectType,:ErpID,:msTimeStamp,:msUpdateSiteCode,:Data) ',
    [
      ApiID,
      ObjectType,
      ErpID,
      FormatDateTime('yyyy-mm-dd hh:nn:ss',msTimeStamp),
      msUpdateSiteCode,
      Data
    ]);


    (*
    ' VALUES (' +
    IntToStr(ApiID) + ',' +
    QuotedStr(ObjectType) + ',' +
    IntToStr(ErpID) + ',' +
    QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',msTimeStamp)) + ',' +
    QuotedStr(msUpdateSiteCode) + ',' +
    QuotedStr(Data) + ');');
    *)
  (*
  Query.SQL.Text := 'select * from  ObjectData where ID = 0';
  Query.Active := true;
  try
    Query.Insert;
    Query.FieldByName('ApiID').AsInteger := ApiID;
    Query.FieldByName('ObjectType').AsString := ObjectType;
    Query.FieldByName('ErpID').AsInteger := ErpID;
    Query.FieldByName('msTimeStamp').AsDateTime := msTimeStamp;
    Query.FieldByName('msUpdateSiteCode').AsString := msUpdateSiteCode;
    Query.FieldByName('Data').AsString := Data;
    Query.Post;
  finally
    Query.Close;
  end;
  *)
  Query.SQL.Text := 'select last_insert_rowid()';
  Query.Active := true;
  try
    result := Query.Fields[0].AsInteger;
  finally
    Query.Active := false;
  end;
end;

end.
