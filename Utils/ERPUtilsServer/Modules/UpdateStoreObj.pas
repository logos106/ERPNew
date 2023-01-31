unit UpdateStoreObj;

interface

uses
  Windows, MyAccess, db, DBAccess;

type

  TUpdateStore = class(TObject)
  private
    Connection: TMyConnection;
    dataset: TMyQuery;
    FServer: string;
    procedure ConnectToDatabase;
    procedure SetServer(const Value: string);
    procedure DoOnConnectionError (Sender: TObject; E: EDAError; var Fail: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property Server: string read FServer write SetServer;
    procedure SaveUpdate(UpdateName, Version, Part, Params, FileName: string);
    function VersionUpdates(const UpdateName, Version: string; Part: string = ''): TDataset;
    function VersionForName(const aName: string): string;
    function ServerVersionNewer(const aFileName: string): boolean;
    procedure UpdateIfNeeded(const aFileName: string);
  end;


implementation

uses
  DbConst, ModuleDbUtils, sysutils, ThreadDataset, forms, FileVersion,
  VersionUtils, MySQLUtils, DBTables, Classes;

{ TUpdateStore }

procedure TUpdateStore.ConnectToDatabase;
var
  cmd: TMyCommand;
begin
  Connection.Database:= DbConst.MYSQL_DATABASE;
  Connection.Connect;
  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection:= Connection;
    cmd.SQL.Text:= 'CREATE DATABASE IF NOT EXISTS ' + UPDATES_DATABASE;
    cmd.Execute;
    Connection.Disconnect;
    Connection.Database:= UPDATES_DATABASE;
    Connection.Connect;
    cmd.SQL.Clear;
    cmd.SQL.Add('CREATE TABLE IF NOT EXISTS updates (');
    cmd.SQL.Add('ID int(11) NOT NULL auto_increment,');
    cmd.SQL.Add('UpdateName varchar(255) default NULL,');
    cmd.SQL.Add('Version varchar(255) default NULL,');
    cmd.SQL.Add('Part varchar(255) default NULL,');
    cmd.SQL.Add('Params varchar(255) default NULL,');
    cmd.SQL.Add('File longblob,');
    cmd.SQL.Add('PRIMARY KEY(ID)) ENGINE=MyISAM;');
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

constructor TUpdateStore.Create;
begin
  Connection:= TMyConnection.Create(nil);
  ModuleDbUtils.InitialiseConnection(Connection);
  Connection.OnError := DoOnConnectionError;
  dataset:= TMyQuery.Create(nil);
  dataset.Connection:= Connection;
end;

destructor TUpdateStore.Destroy;
begin
  dataset.Free;
  Connection.Free;
  inherited;
end;

procedure TUpdateStore.DoOnConnectionError(Sender: TObject; E: EDAError;
  var Fail: boolean);
begin
  if Pos('Lost connection to MySQL server during query',e.Message) > 0 then
    Fail := false
  else
    Fail := true;
end;

procedure TUpdateStore.SaveUpdate(UpdateName, Version, Part, Params, FileName: string);
var
  qry: TMyQuery;
//  FileField: TBlobField;
  BlobStream: TStream;
  FileStream: TFileStream;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Connection;
    qry.SQL.Add('DELETE FROM updates where UpdateName = ' + QuotedStr(UpdateName));
    qry.SQL.Add('AND VERSION <> ' + QuotedStr(Version));
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM updates where UpdateName = ' + QuotedStr(UpdateName));
    qry.SQL.Add('AND Part = ' + QuotedStr(Part));
    qry.SQL.Add('AND Version = ' + QuotedStr(Version));
    qry.Open;
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('UpdateName').AsString:= UpdateName;
      qry.FieldByName('Version').AsString:= Version;
      qry.FieldByName('Part').AsString:= Part;
    end
    else
      qry.Edit;
    qry.FieldByName('Params').AsString:= Params;
    //FileField:= TBlobField(qry.FieldByName('File'));
    //FileField.Clear;
    //FileField.LoadFromFile(FileName);
    BlobStream := qry.CreateBlobStream(qry.fieldByname('File'), bmWrite);
    FileStream := TFileStream.Create(FileName, fmOPenRead);
    try
      BlobStream.CopyFrom(FileStream,0);
    finally
      BlobStream.Free;
      FileStream.Free;
    end;
    qry.Post;
  finally
    qry.Free;
  end;
end;

function TUpdateStore.ServerVersionNewer(const aFileName: string): boolean;
var
  name: string;
  ServerVer, LocalVer: string;
begin
  result := false;
  name := ChangeFileExt(ExtractFileName(aFileName), '');
  ServerVer := VersionForName(name);
  if ServerVer = '' then exit;
  LocalVer := FileVersion.GetFileVersion(aFileName);
  if LocalVer = '' then begin
    result := true;
    exit;
  end;
  result := VersionUtils.VersionComp(ServerVer, LocalVer) > 0;
end;

procedure TUpdateStore.SetServer(const Value: string);
begin
  FServer := Value;
  Connection.Disconnect;
  MySQLUtils.SetConnectionServer(Connection, FServer);
  //Connection.Server:= FServer;
  ConnectToDatabase;
end;

procedure TUpdateStore.UpdateIfNeeded(const aFileName: string);
var
  ds: TDataset;
  name: string;
begin
  if self.ServerVersionNewer(aFileName) then begin
    SysUtils.DeleteFile(aFileName);
    name := ChangeFileExt(ExtractFileName(aFileName), '');
    ds := self.VersionUpdates(name,'');
    TBlobField(ds.FieldByName('File')).SaveToFile(aFileName);
  end;
end;

function TUpdateStore.VersionForName(const aName: string): string;
var
  qry: TMyQuery;
begin
  Connection.Disconnect;
  Connection.Database:= UPDATES_DATABASE;
  Connection.Connect;

  qry := TMyQuery.Create(nil);
  try
    qry.Connection := self.Connection;
    qry.SQL.Text := 'select Version from updates where UpdateName = ' + QuotedStr(aName);
    qry.Open;
    result := qry.FieldByName('Version').AsString;
  finally
    qry.Free;
  end;
end;

function TUpdateStore.VersionUpdates(const UpdateName, Version: string; Part: string = ''): TDataset;
begin
  dataset.Close;
  dataset.SQL.Clear;
  dataset.SQL.Add('SELECT * FROM updates');
  dataset.SQL.Add('WHERE UpdateName = ' + QuotedStr(UpdateName));
  if Version <> '' then
    dataset.SQL.Add('AND Version = ' + QuotedStr(Version));
  if Part <> '' then
    dataset.SQL.Add('AND Part = ' + QuotedStr(Part))
  else
    dataset.SQL.Add('ORDER BY Part');
//  dataset.Open;
  if not OpenDatasetThread(dataset, false) then begin
    raise Exception.Create('Unable to read update information from database');
  end;
  Result := dataset;
end;

end.
