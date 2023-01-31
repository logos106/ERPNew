program CombineTemplates;

uses
  Forms,
  frmCombineTemplatesFrm in 'frmCombineTemplatesFrm.PAS' {CombineTemplatesGUI},
  CabSTComps in 'C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\ThirdParty\Cabmaker\Code\CabSTComps.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CombineTemplates';
  Application.CreateForm(TCombineTemplatesGUI, CombineTemplatesGUI);
  Application.Run;
end.
