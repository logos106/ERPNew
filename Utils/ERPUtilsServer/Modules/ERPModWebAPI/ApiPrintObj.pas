unit ApiPrintObj;

interface

type
  TApiPrint = class(TObject)
  private
    fTemplateName: string;
    fReportType: string;
    fID: integer;
    fFileType: string;
    fFileName: string;
    fFileExt: string;
    fTempFileName: string;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property ReportType: string read fReportType write fReportType;
    property TemplateName: string read fTemplateName write fTemplateName;
    property ID: integer read fID write fID;
    property FileType: string read fFileType write fFileType;
    function Execute(var msg: string): boolean;
    property FileName: string read fFileName write fFileName;
    property FileExt: string read fFileExt write fFileExt;
    function MimeEncodedFile: string;
  end;

implementation

uses
  TemplateReportSelectObj, classes, PrintTemplateBaseObj, SysUtils, SystemLib,
  IdCoderMime, Windows;

{ TApiPrint }

constructor TApiPrint.Create;
begin
  fTempFileName := '';
end;

destructor TApiPrint.Destroy;
begin
  if FileName <> '' then
    SysUtils.DeleteFile(FileName);

  inherited;
end;

function TApiPrint.Execute(var msg: string): boolean;
var
  TRTSel: TTemplateReportSelect;
  SelectSQL: TStringList;
  PrintTemplate: TPrintTemplateBase;
  ReportSQLSupplied: boolean;
  aFileType: string;
begin
  result := true;
  FileName := '';
  TRTSel := nil;
  ReportSQLSupplied := false;
  try
    SelectSQL := TStringList.Create;
    try
      if SameText(ReportType, 'Invoice') then
        TRTSel := TRTSelInvoice.Create
      else if SameText(ReportType, 'Sales Order') then
        TRTSel := TRTSelSalesOrder.Create
      else if SameText(ReportType, 'Quote') then
        TRTSel := TRTSelQuote.Create
      else if SameText(ReportType, 'Delivery Docket') then
        TRTSel := TRTSelDeliveryDocket.Create
      else begin
        result := false;
        msg := 'Report Type not supported: "' + ReportType + '"';
        exit;
      end;
      if Assigned(TRTSel) then begin
        TRTSel.ID := ID;
        if TRTSel.ID < 1 then begin
          result := false;
          msg := 'ID missing from request.';
          exit;
        end;
        TRTSel.ReportToPrint := TemplateName;
        TRTSel.ReportSQLSupplied := ReportSQLSupplied;
        SelectSQL.Text := TRTSel.SelectSQL;
        ReportSQLSupplied := TRTSel.ReportSQLSupplied;
      end;

      PrintTemplate := TPrintTemplateBase.Create;
      try
        PrintTemplate.ReportSQLSupplied := ReportSQLSupplied;
  //      if SameText(FileType,'HTM') then begin
  //        aFileType := 'HTMLFile';
  //        FileExt := 'HTM';
  //      end
  //      else if SameText(FileType,'BMP') then begin
  //        aFileType := 'GraphicFile';
  //        FileExt := 'BMP';
  //      end
  //      else if SameText(FileType,'PDF') then begin
  //        aFileType := 'PDF';
  //        FileExt := 'PDF';
  //      end
  //      else begin
          aFileType := 'PDF'; // default type
          FileExt := 'PDF';
  //      end;
        FileName := SystemLib.WinTempDir + 'Temp_' + RandomStr(6) + '.' + FileExt; //  SystemLib.GetTempFileName('', '.' + FileExt);
        if PrintTemplate.SaveReport(TemplateName,SelectSQL.Text,false,aFileType,FileName) then begin


        end
        else begin
          result := false;
          msg := PrintTemplate.SaveReportErrorMsg;
          exit;
        end;

      finally
        PrintTemplate.Free;
      end;

    finally
      SelectSQL.Free;
      TRTSel.Free;
    end;

  except
    on e: exception do begin
      result := false;
      msg := e.Message;
    end;

  end;

end;

function TApiPrint.MimeEncodedFile: string;
var
  MIMEEncoder: TIdEncoderMIME;
  stream: TFileStream;
begin
  stream := TFileStream.Create(FileName, fmOpenRead);
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

end.
