unit EmailProcess;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 04/07/05  1.00.01 DSP  Initial version. Extends the functionality of the
  //                        T2cEmailSender class, eg. attaching report PDFs.

interface

uses
  Windows, SysUtils, Controls, Dialogs, EmailUtils;

type
  TEmailProcess = class(T2cEmailSender)
  private
    FFileName: string;
  public
    constructor Create;
    function CheckRecipientAddress(const Name: string): boolean;
    function SetNewSubject(const Name, ReportType, SubjectLine, OrderNumber: string): boolean;
    procedure AttachReport;
    property FileName: string read FFileName write FFileName;
  end;

implementation

uses
  CommonLib;

{ TEmailProcess }

constructor TEmailProcess.Create;
begin
  inherited Create;
  FFileName := '';
end;

procedure TEmailProcess.AttachReport;
var
  FileType: file;
begin
  AssignFile(FileType,  Commonlib.TempDir  + 'EmailReport.PDF');

  if not FileExists( Commonlib.TempDir  + FileName) then begin
    CopyFile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
      PChar( Commonlib.TempDir  + FileName), false);
  end;

  AddAttachment( Commonlib.TempDir  + FileName);
end;

function TEmailProcess.CheckRecipientAddress(const Name: string): boolean;
begin
  if Recipients = '' then begin
    Result := false;
    if CommonLib.MessageDlgXP_Vista(Name +' does not have an email address to send to.' +
      sLineBreak + sLineBreak + 'Do you wish to load the email program anyway?',
      mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      result := true;
  end else Result := true;
end;

function TEmailProcess.SetNewSubject(const Name, ReportType, SubjectLine, OrderNumber: string): boolean;
var
  MsgResult: word;
begin
  MsgResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' + Name +'.' +
    sLineBreak + 'Would you like to specify a subject for this email?' + sLineBreak + sLineBreak +
    'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
    [mbYes, mbNo, mbCancel], 0);

  case MsgResult of
    mrYes:
      begin
        Subject := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
          SubjectLine + ' ' + ReportType + ' #' + OrderNumber + ' for ' + Name);

        if Subject = '' then Subject := SubjectLine + ' ' + ReportType + ' #' + OrderNumber + ' for ' + Name;

        Result := true;
      end;

    mrNo:
      begin
        Subject := SubjectLine + ' ' + ReportType + ' #' + OrderNumber + ' for ' + Name;
        Result := true;
      end;

    else begin
        Result := false;
      end;
  end;
end;

end.
