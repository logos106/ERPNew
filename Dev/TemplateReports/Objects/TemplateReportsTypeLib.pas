unit TemplateReportsTypeLib;

interface

uses
  ErpDBComponents;

  function GetDefaultReport(const TemplateTypeID: integer; Conn: TERPConnection = nil): string; overload;
  function GetDefaultReport(const TemplateTypeName: String; Conn: TERPConnection = nil): string; overload;


implementation

uses
  SysUtils, AppEnvironmentVirtual;

function GetDefaultReport(const TemplateTypeID: integer; Conn: TERPConnection): string;
var
  qry: TERPQuery;
begin
  qry := TERpQuery.Create(nil);
  if Assigned(Conn) then
    qry.Connection := Conn
  else
    qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

  With qry do try
    SQL.text := 'SELECT TemplateClass FROM tblTemplates WHERE TypeID = '+ inttostr(TemplateTypeID)+' and DefaultTemplate = "T"';
    open;
    Result := FieldByname('TemplateClass').asString ;
  finally
    if Active then close;
    Free;
  end;
end;

function GetDefaultReport(const TemplateTypeName: String; Conn: TERPConnection): String;
var
  qry: TERPQuery;
begin
  qry := TERpQuery.Create(nil);
  if Assigned(Conn) then
    qry.Connection := Conn
  else
    qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

  With qry do try
    SQL.text := 'select tbltemplates.TemplateClass from tbltemplates, tbltemplatetype'+
          ' where tbltemplates.TypeID = tbltemplatetype.TypeID'+
          ' and tbltemplatetype.TypeName = ' + QuotedStr(TemplateTypeName)+
          ' and tbltemplates.DefaultTemplate = "T"';
    open;
    Result := FieldByname('TemplateClass').asString ;
  finally
    if Active then close;
    Free;
  end;
end;



end.
