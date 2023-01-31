unit ERPDbListObj;

interface

uses
  classes, ERPDbComponents;

type

  TERPDbList = class
  private
    fServer: string;
    fList: TStringList;
    fConnection: TErpConnection;
    fIndex: integer;
    fSiteCode: string;
    function GetCount: integer;
    function GetConnection: TERPConnection;
    function GetSiteCode: string;
  public
    constructor Create(aServer: string);
    destructor Destroy; override;
    property Count: integer read GetCount;
    function First: boolean;
    function Next: boolean;
    property Connection: TERPConnection read GetConnection;
    property SiteCode: string read GetSiteCode;
    function GoToDatabase(aDatabaseName: string): boolean;
  end;

implementation

uses
  ModuleDbUtils, DbConst, SysUtils;

{ ERPDbList }

constructor TERPDbList.Create(aServer: string);
var
  sl_db, sl_table: TStringList;
  x: integer;
begin
  fServer := aServer;
  fList := TStringList.Create;
  fList.CaseSensitive := true;
  fSiteCode := '';
  fConnection := TErpConnection.Create(nil);
  InitialiseConnection(fConnection,fServer,MYSQL_DATABASE);
  fConnection.Connect;
  sl_db := TStringList.Create;
  sl_table := TStringList.Create;
  try
    fConnection.GetDatabaseNames(sl_db);
    fConnection.Disconnect;
    for x := 0 to sl_db.Count -1 do begin
      if (not SameText(sl_db[x],'information_schema')) and
         (not SameText(sl_db[x],'apphelp')) and
         (not SameText(sl_db[x],'erp_export')) and
         (not SameText(sl_db[x],'erpnewdb,mysql')) and
         (not SameText(sl_db[x],'pbxmonitor')) and
         (not SameText(sl_db[x],'erpdocumentation')) and
         (not SameText(sl_db[x],'serverupdates')) and
         (not SameText(sl_db[x],'services')) then begin
        fConnection.Database := sl_db[x];
        fConnection.Connect;
        fConnection.GetTableNames(sl_table);
        fConnection.Disconnect;
        if (sl_table.Count > 100) and
           (sl_table.IndexOf('tblupdatedetails') > -1) and
           (sl_table.IndexOf('tblcompanyinformation') > -1) then begin   { probably an ERP database }
          fList.Add(sl_db[x]);
        end;
      end;
    end;
  finally
    sl_db.Free;
    sl_table.Free;
  end;
  First;
end;

destructor TERPDbList.Destroy;
begin
  fConnection.Free;
  fList.Free;
  inherited;
end;

function TERPDbList.First: boolean;
begin
  result:= false;
  if fList.Count > 0 then begin
    fIndex := 0;
    result := true;
  end;
end;

function TERPDbList.GetConnection: TERPConnection;
begin
  result := nil;
  if fList.Count > 0 then begin
    if not SameText(fConnection.Database,fList[fIndex]) then begin
      fConnection.Disconnect;
      fConnection.Database := fList[fIndex];
      fSiteCode := '';
    end;
    if not fConnection.Connected then
      fConnection.Connect;
    result:= fConnection;
  end;
end;

function TERPDbList.GetCount: integer;
begin
  result := fList.Count;
end;

function TERPDbList.GetSiteCode: string;
var
  qry: TERPQuery;
begin
  if fSiteCode = '' then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Connection;
      qry.SQL.Text := 'SELECT SiteCode FROM tblmsBackEndID WHERE BEDefault = "T"';
      qry.Open;
      fSiteCode := qry.FieldByName('SiteCode').AsString;
    finally
      qry.Free;
    end;
  end;
  result := fSiteCode;
end;

function TERPDbList.GoToDatabase(aDatabaseName: string): boolean;
var
  x: integer;
begin
  result := true;
  x := fList.IndexOf(aDatabaseName);
  if x < 0 then begin
    result := false;
    fIndex := x;
  end;
end;

function TERPDbList.Next: boolean;
begin
  result := false;
  if fIndex < (fList.Count -1) then begin
    Inc(fIndex);
    result := true;
  end;
end;

end.
