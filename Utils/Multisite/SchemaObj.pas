unit SchemaObj;

interface

uses
  JSONObject, Classes;

type

  TSchema = class
  private
    fRoot: TJSONObject;
  public
    constructor Create;
    destructor Destroy; override;
    class function Inst: TSchema;
    property Root: TJSONObject read fRoot;
  end;

implementation

uses
  forms, sysutils, ERPSchemaData;

var
  fSchema: TSchema;

{ TSchema }

constructor TSchema.Create;
begin
  fRoot:= TJSONObject.Create;
//  fRoot.Text:= ERPSchemaData.ERPSchemaText;
  fRoot.LoadFromFile(ExtractFilePath(Application.ExeName) +  'ERPSchema.txt');
end;

destructor TSchema.Destroy;
begin
  inherited;
end;

class function TSchema.Inst: TSchema;
begin
  if not Assigned(fSchema) then
    fSchema:= TSchema.Create;
  result:= fSchema;
end;

initialization

finalization
  fSchema.Free;



end.
