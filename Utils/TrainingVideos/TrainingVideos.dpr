program TrainingVideos;

uses
  Forms,
  frmMenu in 'frmMenu.pas' {frmMenuGUI};

{$R *.res}

begin
  Application.Title := 'Training Videos';
  Application.Initialize;
  Application.CreateForm(TfrmMenuGUI, frmMenuGUI);
  Application.Run;
end.
