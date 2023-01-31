unit ApiFuncPrint;

interface

uses
  ApiFuncObj, ERPDbComponents;

type
  TFunc_Print = class(TApiFunc)
  private
  public
    procedure Execute; override;
  end;

implementation

uses
  SysUtils, CommonDbLib, ApiPrintObj, Classes, JsonObject;

  (*
    {
      "TemplateName":"Invoice with Customer Ref",
      "TypeName":"",                               // optional to get default template
      "ReportType":"Invoice",
      "ID": 237,                                   // the ID of the transaction to print
      "FileType":"PDF"                             // PDF,BMP,HTM

    }
  *)

{ TFunc_Print }

procedure TFunc_Print.Execute;
var
  ApiPrint: TApiPrint;
  repIn, repOut: TJsonObject;
  I: integer;

  function DoPrint(JIn, JOut: TJsonObject): boolean;
  var
    TemplateName: string;
    msg: string;
  begin
    result := true;
    if JIn.StringExists('TemplateName') then
      TemplateName := JIn.S['TemplateName']
    else if JIn.StringExists('TypeName') then begin
      { get default template }
      TemplateName := DefaultTemplateForType(JIn.S['TypeName']);
    end
    else begin
      result := false;
      ResponceNo := 406; { "Not Acceptable" }
      ErrorMessage := 'No TemplareName or TemplateClass found in request.';
      exit;
    end;

    ApiPrint.ReportType := JIn.S['ReportType'];
    ApiPrint.TemplateName := TemplateName;
    ApiPrint.ID := JIn.I['ID'];
    ApiPrint.FileType := JIn.S['FileType'];
    try
      if ApiPrint.Execute(msg) then begin
        JOut.S['ReportType'] := JIn.S['ReportType'];
        JOut.S['FileExt'] := ApiPrint.FileExt;
        JOut.S['MimeEncodedFile'] := ApiPrint.MimeEncodedFile;
      end
      else begin
        result := false;
        ResponceNo := 406; { "Not Acceptable" }
        ErrorMessage := msg;
        exit;
      end;
    finally
      if ApiPrint.FileName <> '' then
        DeleteFile(ApiPrint.FileName);
    end;
  end;

begin
  inherited;

  ApiPrint := TApiPrint.Create;
  try
    if JsonIn.ArrayExists('Reports') then begin
      // list of reports to print
      for I := 0 to JsonIn.A['Reports'].Count -1 do begin
        repIn := JsonIn.A['Reports'][I].AsObject;
        repOut := JO;
        JsonOut.A['Reports'].Add(repOut);
        if not DoPrint(repIn, repOut) then
          exit;
      end;
    end
    else begin
      // single report to print
      if not DoPrint(JsonIn,JsonOut) then
        exit;
    end;
  finally
    ApiPrint.Free;
  end;
end;

initialization
  RegisterClass(TFunc_Print);

end.
