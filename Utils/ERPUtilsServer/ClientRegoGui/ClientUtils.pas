unit ClientUtils;

interface

uses
  JsonObject, MyAccess;

procedure LoadClient(aClientId: integer; Json: TJsonObject; Connection: TMyConnection);
procedure SaveClient(Json: TJsonObject; Connection: TMyConnection);
function IsDeleted(obj: TJsonObject): boolean;
function IsDirty(obj: TJsonObject): boolean;

implementation

uses
  SysUtils, JsonToDatasetFuncs, JsonObjectUtils;

procedure LoadClient(aClientId: integer; Json: TJsonObject; Connection: TMyConnection);
var
  qry, qry2: TMyQuery;
  server: TJsonObject;
  serverID: integer;
  licence: TJsonObject;
  config: TJsonObject;
  dbList, dbInfo: TJsonObject;
  x: integer;
begin
  Json.Clear;
  if aClientId = 0 then exit;

  qry := TMyQuery.Create(nil);
  qry2 := TMyQuery.Create(nil);
  dbList := JO;
  try
    qry.Connection := Connection;
    qry2.Connection := Connection;
    qry.SQL.Text:= 'select * from tclientconfig where id = ' + IntToStr(aClientID);
    qry.Open;
    if qry.IsEmpty then exit;

    DatasetToJson(qry, Json);

    qry.Close;
    qry.SQL.Text:= 'select * from tcomputer where clientid = ' + IntToStr(aClientID);
    qry.Open;
    while not qry.Eof do begin
      ServerId := qry.FieldByName('id').AsInteger;
      server:= JO;
      DatasetToJson(qry,Server);
      qry2.Close;
      qry2.SQL.Text := 'select * from tsoftwarelicence where computerid = ' + IntToStr(serverID);
      qry2.Open;
      while not qry2.EOF do begin
        licence := JO;
        DatasetToJson(qry2, licence, 'datatext');

        dbList.AsString := qry2.FieldByName('datatext').AsString;
        for x := 0 to dbList.O['erpinfo'].Count -1 do begin
          dbInfo := JO;
          dbInfo.Assign(dbList.O['erpinfo'].Items[x].Value.AsObject);
          licence.A['Database'].Add(dbInfo);
        end;

        server.A['Licence'].Add(licence);
        qry2.Next;
      end;
      qry2.Close;
      qry2.SQL.Text := 'select * from tcomputerconfig where computerid = ' + IntToStr(serverID);
      qry2.Open;
      while not qry2.EOF do begin
        config:= JO;
        DatasetToJson(qry2,config);
        server.A['Config'].Add(config);

        qry2.Next;
      end;

      Json.A['Server'].Add(server);
      qry.Next;
    end;

    // Json.SaveToFile('c:\temp\temp.txt');
    JsonToFileFormated(Json,'c:\temp\temp.txt');

  finally
    qry.Free;
    qry2.Free;
    dbList.Free;
  end;
end;

procedure SaveClient(Json: TJsonObject; Connection: TMyConnection);
var
  deleted: boolean;
  qry, qry2: TMyQuery;
  ClientId: integer;
begin
  deleted:= IsDeleted(Json);
  ClientId:= 0;
  qry := TMyQuery.Create(nil);
  qry2 := TMyQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry2.Connection := Connection;

    // save client
    if Json.IntegerExists('id') then
      ClientId := Json.I['id'];
    if (ClientId > 0) then begin
      if not deleted then begin
        if IsDirty(Json) then begin
          // update
          qry.Close;
          qry.SQL.Text := 'select * from tclientconfig where id = ' + IntToStr(ClientId);
          qry.Open;
          qry.Edit;
          JsonToDataset(Json,qry,'id,datetime');
          qry.Post;
          qry.Close;
        end;
      end
      else begin
        // client deleted
        qry.SQL.Text := 'delete from tclientconfig where id = ' + IntToStr(ClientId);
        qry.Execute;
      end;

    end
    else begin
      // no id .. new record
      qry.Close;
      qry.SQL.Text := 'select * from tclientconfig where id = ' + IntToStr(ClientId);
      qry.Open;
      qry.Insert;
      JsonToDataset(Json,qry,'id,datetime');
      qry.Post;
      ClientId := qry.FieldByName('id').AsInteger;
      qry.Close;
    end;

    // save servers



  finally
    qry.Free;
    qry2.Free;
  end;
end;

function IsDeleted(obj: TJsonObject): boolean;
begin
  result := obj.BooleanExists('_deleted') and obj.B['_deleted'];
end;

function IsDirty(obj: TJsonObject): boolean;
begin
  result := obj.BooleanExists('_dirty') and obj.B['_dirty'];
end;

end.
