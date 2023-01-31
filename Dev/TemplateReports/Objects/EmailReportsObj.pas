unit EmailReportsObj;

interface

uses DB, MyAccess, PrintTemplateObj;

type
  TSendEmailedReport = Record
    ReportName: String;
    Mode: String;
    NextSend: TDateTime;
    FromDate: integer;
    ToDate: integer;
    TemplateName: String;
    Emails: String;
    UseBcc: Boolean;
  end;


  TEmailReportsObj = class(TObject)
  private
    PrintTemplate: TPrintTemplates;
    tmpEmailedReport: TSendEmailedReport;
    procedure SetParams(Const Query :TMyQuery);
    procedure SendReport(Const EmailedReport: TSendEmailedReport);
    procedure SetupRepeat(Const EmailedReport: TSendEmailedReport; Const EmailedReportDS: TDataset);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Send;

  end;

implementation

uses FastFuncs,SysUtils, CommonDbLib, EmailUtils, Windows,
     tcDataUtils, DateUtils,  
     CommonLib, AppEnvironment;

{ TEmailReportsObj }

procedure TEmailReportsObj.Send;
var
  qry: TMyQuery;
  EmailedReport: TSendEmailedReport;
begin
  qry:= TMyQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT * FROM tblemailedreportsschedule ');
    qry.SQL.Add('WHERE (Now()>NextSend) AND Active="T";');
    qry.Open;
    If (qry.RecordCount>0) then Begin
      While Not qry.Eof do Begin
        EmailedReport.ReportName := qry.FieldByName('ReportName').asString;
        EmailedReport.Mode := qry.FieldByName('Mode').asString;
        EmailedReport.NextSend := qry.FieldByName('NextSend').asDateTime;
        EmailedReport.FromDate := qry.FieldByName('FromDate').asInteger;
        EmailedReport.ToDate := qry.FieldByName('ToDate').asInteger;
        EmailedReport.TemplateName := tcDataUtils.GetTemplate(qry.FieldByName('TemplateID').asInteger);
        EmailedReport.Emails := qry.FieldByName('Emails').asString;
        EmailedReport.UseBcc := qry.FieldByName('UseBcc').asBoolean;
        SendReport(EmailedReport);
        SetupRepeat(EmailedReport,qry);
        qry.Next;
      end;
    end;
  finally
    SysUtils.FreeAndNil(qry);
  end;
end;

procedure TEmailReportsObj.SetParams(const Query: TMyQuery);
begin
  If (Query.ParamByName('xDateFrom')<>nil) AND (Query.ParamByName('xDateTo')<>nil) then Begin
    Query.ParamByName('xDateFrom').asString :=  FormatDateTime('yyyy-mm-dd', IncDay(tmpEmailedReport.NextSend,tmpEmailedReport.FromDate));
    Query.ParamByName('xDateTo').asString :=  FormatDateTime('yyyy-mm-dd', IncDay(tmpEmailedReport.NextSend,tmpEmailedReport.ToDate));
  end;
end;

procedure TEmailReportsObj.SendReport(Const EmailedReport: TSendEmailedReport);
Var
  EmptyEmailedReport: TSendEmailedReport;
  FEmailSender: T2cEmailSender;
  f: file;
  OutGoingFileName: string;
begin
  PrintTemplate.OnSetParameters := SetParams;
  tmpEmailedReport := EmailedReport;
  PrintTemplate.SaveTemplateReport(EmailedReport.TemplateName,'', false, 'PDF');
  PrintTemplate.OnSetParameters := nil;
  tmpEmailedReport := EmptyEmailedReport;
  FEmailSender := T2cEmailSender.Create;
  Try
    FEmailSender.ResetMessageData;

    FEmailSender.Subject := 'Emailed Report :' + EmailedReport.ReportName + ' ('+
    FormatDateTime(AppEnv.RegionalOptions.ShortDateFormat, IncDay(EmailedReport.NextSend,tmpEmailedReport.FromDate))+ ' - '+
    FormatDateTime(AppEnv.RegionalOptions.ShortDateFormat, IncDay(EmailedReport.NextSend,tmpEmailedReport.ToDate)) +')';
    FEmailSender.Recipients := CommonLib.ReplaceStr(EmailedReport.Emails,#13#10,';');
    FEmailSender.EmailBody.Add('This report email has been sent to you from ' + GetCompanyName);

    OutGoingFileName := GetCompanyName + ' Emailed Report :' + EmailedReport.ReportName + '.PDF';

    if not FileExists( (*ExtractFilePath(ParamStr(0)) +*)Commonlib.TempDir + 'EmailReport.PDF') then Exit;
    AssignFile(f, (*ExtractFilePath(ParamStr(0)) + *)Commonlib.TempDir +'EmailReport.PDF');

    if not FileExists(ExtractFilePath(ParamStr(0)) + OutGoingFileName) then begin
      Windows.Copyfile(PChar((*ExtractFilePath(ParamStr(0)) + *)Commonlib.TempDir +'EmailReport.PDF'),
      PChar(ExtractFilePath(ParamStr(0)) + OutGoingFileName), false);
    end;

    CloseFile(f);

    FEmailSender.AddAttachment(ExtractFilePath(ParamStr(0)) + OutGoingFileName);

    FEmailSender.Send;

  finally
    FreeAndNil(FEmailSender);
  end;
end;

procedure TEmailReportsObj.SetupRepeat(Const EmailedReport: TSendEmailedReport; Const EmailedReportDS: TDataset);
begin
  EmailedReportDS.Edit;
  if (FastFuncs.Trim(EmailedReportDS.FieldByName('Mode').AsString) = 'Once') then begin
    EmailedReportDS.FieldByName('Active').AsString := 'F';
  end else if (FastFuncs.Trim(EmailedReportDS.FieldByName('Mode').AsString) = 'Daily') then begin
    EmailedReportDS.FieldByName('NextSend').AsDateTime := IncDay(EmailedReportDS.FieldByName('NextSend').AsDateTime);
  end else if (FastFuncs.Trim(EmailedReportDS.FieldByName('Mode').AsString) = 'Weekly') then begin
    EmailedReportDS.FieldByName('NextSend').AsDateTime := IncDay(EmailedReportDS.FieldByName('NextSend').AsDateTime,7);
  end else if (FastFuncs.Trim(EmailedReportDS.FieldByName('Mode').AsString) = 'Monthly') then begin
   EmailedReportDS.FieldByName('NextSend').AsDateTime := IncMonth(EmailedReportDS.FieldByName('NextSend').AsDateTime);
  end;
  EmailedReportDS.Post;
end;

constructor TEmailReportsObj.Create;
begin
  Inherited;
  PrintTemplate := TPrintTemplates.Create;
end;

destructor TEmailReportsObj.Destroy;
begin
  If Assigned(PrintTemplate) then FreeAndNil(PrintTemplate);
  inherited;
end;

end.

