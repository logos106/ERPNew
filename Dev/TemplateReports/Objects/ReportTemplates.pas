unit ReportTemplates;

interface

uses ReportTemplateBase, Dialogs;

type
  TReportTemplates = Class(TReportTemplateBase)
    Private
    Protected
      Procedure UserMsgInfo(Const value:String);Override;
      Procedure UserMsgWarn(Const value:String);Override;
  Public
  End;

implementation

uses CommonLib;

{ TReportTemplates }

procedure TReportTemplates.UserMsgInfo(const value: String);
begin
  inherited;
  MessageDlgXP_Vista(Value, mtInformation, [mbOk],0);
end;

procedure TReportTemplates.UserMsgWarn(const value: String);
begin
  inherited;
  MessageDlgXP_Vista(Value, mtWarning, [mbOk],0);
end;

end.

