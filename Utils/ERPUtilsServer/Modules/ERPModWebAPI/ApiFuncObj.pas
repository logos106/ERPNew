unit ApiFuncObj;

interface

uses
  Classes, JsonObject;

type
  TApiFuncClass = class of TApiFunc;
  TApiFunc = class(TPersistent)
  protected
    function DefaultTemplateForType(aTypeName: string): string;
    function TemplateTypeNameForTemplateName(aTemplateName: string): string;
    function MimeEncodedFile(aFileName: string): string;
  public
    ResponceNo: integer;
    ErrorMessage: string;
    JsonIn: TJsonObject;
    JsonOut: TJsonObject;
    StreamOut: TStream;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Execute; virtual;
  end;

implementation

uses
  ERPDbComponents, CommonDbLib, SysUtils, IdCoderMime;

{ TApiFunc }

constructor TApiFunc.Create;
begin
  ResponceNo := 200;
  ErrorMessage := '';
end;

function TApiFunc.DefaultTemplateForType(aTypeName: string): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select TemplName from tbltemplates');
    qry.SQL.Add('inner join tbltemplatetype on tbltemplatetype.TypeID = tbltemplates.TypeID');
    qry.SQL.Add('and tbltemplatetype.TypeName = ' + QuotedStr(aTypeName));
    qry.SQL.Add('and tbltemplates.DefaultTemplate = "T"');
    qry.Open;
    result := qry.FieldByName('TemplName').AsString;
  finally
    qry.Free;
  end;
end;

destructor TApiFunc.Destroy;
begin

  inherited;
end;

procedure TApiFunc.Execute;
begin

end;

function TApiFunc.MimeEncodedFile(aFileName: string): string;
var
  MIMEEncoder: TIdEncoderMIME;
  stream: TFileStream;
begin
  stream := TFileStream.Create(aFileName, fmOpenRead);
  try
    MIMEEncoder := TIdEncoderMIME.Create(nil);
    try
      Result := MIMEEncoder.Encode(stream);
    finally
      MIMEEncoder.Free;
    end;
  finally
    stream.Free;
  end;
end;

function TApiFunc.TemplateTypeNameForTemplateName(
  aTemplateName: string): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select TypeName from tbltemplatetype');
    qry.SQL.Add('inner join tbltemplates on tbltemplatetype.TypeID = tbltemplates.TypeID');
    qry.SQL.Add('and tbltemplates.TemplName = ' + QuotedStr(aTemplateName));
    qry.Open;
    result := qry.FieldByName('TypeName').AsString;
  finally
    qry.Free;
  end;
end;

end.
