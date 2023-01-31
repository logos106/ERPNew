unit DbPrimaryKeysObj;

{ Date     Version  Who What
 -------- -------- --- ------------------------------------------------------
 20/07/05  1.00.00 IJB Initial version.
}

{
  Provides functions to check if primary key exists for database tables etc.
  Use class functions (they will create an instance of the object) and
  optionally call FreeMe to dispose of object.
}
interface

uses
  MyAccess,ERPdbComponents;

type
  TDbPrimaryKeys = class(TObject)
  private
    qry: TERPQuery;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function GetTableKeyExists(const aKeyName: string): boolean;
    class function TableKeyExists(const aKeyName: string): boolean;
    class procedure FreeMe;
  end;


implementation

uses
  SysUtils, CommonDbLib, DB;

{ TDbPrimaryKeys }

var 
  DbPrimaryKeys: TDbPrimaryKeys = nil;


constructor TDbPrimaryKeys.Create;
begin
  Inherited;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.SQL.Text := 'SELECT * FROM tblPrimaryKeys';
  qry.Open;
end;

destructor TDbPrimaryKeys.Destroy;
begin
  qry.Close;
  FreeAndNil(qry);
  inherited;
end;

class procedure TDbPrimaryKeys.FreeMe;
begin
  if Assigned(DbPrimaryKeys) then FreeAndNil(DbPrimaryKeys);
end;

class function TDbPrimaryKeys.TableKeyExists(const aKeyName: string): boolean;
begin
  if not Assigned(DbPrimaryKeys) then DbPrimaryKeys := TDbPrimaryKeys.Create;

  Result := DbPrimaryKeys.GetTableKeyExists(aKeyName);
end;

function TDbPrimaryKeys.GetTableKeyExists(const aKeyName: string): boolean;
begin
  Result := qry.Locate('KeyName', aKeyName, [loCaseInsensitive]);
end;

initialization

finalization
  TDbPrimaryKeys.FreeMe;
end.
