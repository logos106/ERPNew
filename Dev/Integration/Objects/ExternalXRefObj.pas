unit ExternalXRefObj;

interface

uses
  ERPDbComponents;

type

  TExternXRef = class(TObject)
  public
    class procedure StartNew(const aExternalType, aObjectType: string;
      const aERPID: integer; Conn: TERPConnection = nil);
    class procedure Complete(const aExternalType, aObjectType: string;
      const aERPID: integer; const aExternalID: string; Conn: TERPConnection = nil);
    class function GetExternalRef(aExternalType, aObjectType: string;
      aERPID: integer; var aExtRef: string; var aDone: boolean; Conn: TERPConnection = nil): boolean;
  end;

implementation

uses
  SysUtils, DbSharedObjectsObj, AppEnvironment;

{ TExternXRef }

class procedure TExternXRef.Complete(const aExternalType, aObjectType: string;
  const aERPID: integer; const aExternalID: string; Conn: TERPConnection);
var
  //cmd: TERPCommand;
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(AppEnv.AppDb.Connection);
  try
    qry.SQL.Add('SELECT * FROM tblExternalXRef');
    qry.SQL.Add('WHERE ExternalType = ' + QuotedStr(aExternalType));
    qry.SQL.Add('AND ObjectType = ' + QuotedStr(aObjectType));
    qry.SQL.Add('AND ERPID = ' + IntToStr(aERPID));
    qry.Open;
    if qry.IsEmpty then begin
      qry.Insert;
      qry.FieldByName('ExternalType').AsString := aExternalType;
      qry.FieldByName('ObjectType').AsString := aObjectType;
      qry.FieldByName('ERPID').AsInteger := aERPID;
    end
    else begin
      qry.Edit;
    end;
    qry.FieldByName('ExternalID').AsString := aExternalID;
    qry.FieldByName('SynchState').AsString := 'Done';
    qry.Post;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TExternXRef.GetExternalRef(aExternalType, aObjectType: string;
  aERPID: integer; var aExtRef: string;  var aDone: boolean; Conn: TERPConnection): boolean;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(AppEnv.AppDb.Connection);
  try
    qry.SQL.Add('SELECT * FROM  tblExternalXRef');
    qry.SQL.Add('WHERE ExternalType = ' + QuotedStr(aExternalType));
    qry.SQL.Add('AND ObjectType = ' +QuotedStr(aObjectType));
    qry.SQL.Add('AND ERPID = ' + IntToStr(aERPID));
    qry.Open;
    result := not qry.IsEmpty;
    aExtRef := qry.FieldByName('ExternalID').AsString;
    aDone := SameText(qry.FieldByName('SynchState').AsString, 'Done');
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class procedure TExternXRef.StartNew(const aExternalType, aObjectType: string;
  const aERPID: integer; Conn: TERPConnection);
var
  cmd: TERPCommand;
begin
  if Assigned(Conn) then
    cmd := DbSharedObj.GetCommand(Conn)
  else
    cmd := DbSharedObj.GetCommand(AppEnv.AppDb.Connection);
  try
    cmd.SQL.Add('INSERT INTO tblExternalXRef');
    cmd.SQL.Add('(ExternalType,ObjectType,ERPID) VALUES (');
    cmd.SQL.Add(QuotedStr(aExternalType) + ',' + QuotedStr(aObjectType) + ',' + IntToStr(aERPID) + ')');
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

end.
