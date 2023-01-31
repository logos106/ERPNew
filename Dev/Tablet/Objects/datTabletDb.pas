unit datTabletDb;

interface

uses
  SysUtils, Classes, DB, DISQLite3DataSet, DISQLite3Database;

type
  TdmTabletDB = class(TDataModule)
    Database: TDISQLite3Database;
    Query: TDISQLite3UniDirQuery;
    procedure DatabaseAfterCreateDatabase(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    fDatabaseFileName: string;
    fNextDummyErpID: integer;
    function GetConnected: boolean;
    procedure SetConnected(const Value: boolean);
    procedure SetDatabaseFileName(const Value: string);
    function NextDummyErpID: integer;
    { Private declarations }
  public
    property DatabaseFileName: string read fDatabaseFileName write SetDatabaseFileName;
    property Connected: boolean read GetConnected write SetConnected;
    function SaveObjectData(
      const ObjectType: string;
      const ErpID: integer;
      const msTimeStamp: TDateTime;
      const msUpdateSiteCode: string;
      const Data: string;
      const ApiID: integer;
      const ReturnID: boolean = false): integer;
  end;

var
  dmTabletDB: TdmTabletDB;

implementation

uses
  utDbTables;

{$R *.dfm}

{ TdmTabletDB }

procedure TdmTabletDB.DatabaseAfterCreateDatabase(Sender: TObject);
var
  sl: TStringList;
  x: integer;
begin
(*
  Database.Execute(
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
*)
  sl := TStringList.Create;
  try
    TDbTAbles.GetDatabaseCreateSripts(SL);
    for x := 0 to sl.Count -1 do
      Database.Execute(UTF8String(sl[x]));
  finally
    sl.Free;
  end;
end;

procedure TdmTabletDB.DataModuleCreate(Sender: TObject);
begin
  fNextDummyErpID := 0;
end;

function TdmTabletDB.GetConnected: boolean;
begin
  result := Database.Connected;
end;

function TdmTabletDB.NextDummyErpID: integer;
var
  qry: TDISQLite3UniDirQuery;
begin
  if fNextDummyErpID = 0 then begin
    qry := TDISQLite3UniDirQuery.Create(nil);
    try
      qry.Database := Database;
      qry.SelectSQL :=
        'select Min(ErpID) as DataErpID, (select Min(ErpID) from ObjectVals) as ValsErpID from ObjectData';

      qry.Open;
      if (not qry.FieldByName('DataErpID').IsNull) and (qry.FieldByName('DataErpID').AsInteger < fNextDummyErpID) then
        fNextDummyErpID := qry.FieldByName('DataErpID').AsInteger;
      if (not qry.FieldByName('ValsErpID').IsNull) and (qry.FieldByName('ValsErpID').AsInteger < fNextDummyErpID) then
        fNextDummyErpID := qry.FieldByName('ValsErpID').AsInteger;
    finally
      qry.Free;
    end;
    Dec(fNextDummyErpID);
  end;
  Dec(fNextDummyErpID);
  result := fNextDummyErpID;

end;

function TdmTabletDB.SaveObjectData(const ObjectType: string;
  const ErpID: integer; const msTimeStamp: TDateTime; const msUpdateSiteCode,
  Data: string; const ApiID: integer; const ReturnID: boolean): integer;
var
  aErpID: integer;
begin
  aErpID := ERPID;
  if aErpID = 0 then
    aErpID := NextDummyErpID;
  result := 0;
  Database.Execute(UTF8String(
    ' INSERT INTO ObjectData (ApiID,ObjectType,ErpID,msTimeStamp,msUpdateSiteCode,Data)' +
    ' VALUES (' +
    IntToStr(ApiID) + ',' +
    QuotedStr(ObjectType) + ',' +
    IntToStr(aErpID) + ',' +
    QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',msTimeStamp)) + ',' +
    QuotedStr(msUpdateSiteCode) + ',' +
    QuotedStr(Data) +
    ' )'  ));
  if ReturnID then begin
    Query.SelectSQL := 'select last_insert_rowid()';
    Query.Open;
    try
      result := Query.Fields[0].AsInteger;
    finally
      Query.Close;
    end;
  end;
end;

procedure TdmTabletDB.SetConnected(const Value: boolean);
begin
  if Value then begin
    if fDatabaseFileName = '' then raise Exception.Create('Error - No Database Name Defined');
    ForceDirectories(ExtractFilePath(fDatabaseFileName));
    Database.DatabaseName := fDatabaseFileName;
    if not FileExists(fDatabaseFileName) then
      Database.CreateDatabase
    else
      Database.Open;
  end
  else begin
    if Database.Connected then
      Database.Connected := false;
  end;
end;

procedure TdmTabletDB.SetDatabaseFileName(const Value: string);
begin
  fDatabaseFileName := Value;
  if Database.Connected then
    Database.Connected := false;
end;

end.
