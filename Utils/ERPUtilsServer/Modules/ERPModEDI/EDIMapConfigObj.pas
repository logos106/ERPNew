unit EDIMapConfigObj;

interface
uses
  JsonDbPrefsConfigObj, JsonObject, MyAccess, ERPDbComponents;


type

  TEDIMapConfig = class(TJsonDbPefConfig)
  private
  public
    function NameExists(aName: string; conn: TMyConnection): boolean;
  end;

implementation

uses
  DbSharedObjectsObj, SysUtils;

{ TEDIMapConfig }

function TEDIMapConfig.NameExists(aName: string; conn: TMyConnection): boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(conn);
  try
    qry.SQL.Text := 'select PrefId from tbldbpreferences where PrefType = ' +
      QuotedStr(ClassName)+ ' and Name = ' + QuotedStr(aName);
    qry.Open;
    result := not qry.IsEmpty;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

end.
