program MySQL_Config;

uses
  Forms,
  DisplayForm in 'DisplayForm.pas' {UpdateGUI},
  Vista_MessageDlg in '..\..\Dev\General\Objects\CommonObjects\Vista_MessageDlg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MySQL Server Configuration';
  Application.CreateForm(TUpdateGUI, UpdateGUI);
  Application.Run;
end.
