program SMSTest;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  URILib in '..\..\..\..\..\Common\URILib.pas',
  JSONObject in '..\..\..\..\..\Common\JSONObject.pas',
  DateTimeUtils in '..\..\..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  MessageMediaConst in '..\..\..\..\..\Common\MessageMedia\MessageMediaConst.pas',
  SMSMessageMediaObj in '..\..\..\..\..\Common\MessageMedia\SMSMessageMediaObj.pas',
  SMSObj in '..\..\..\..\..\Common\SMSObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
