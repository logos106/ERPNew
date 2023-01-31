program DataUpdaterBase;

uses
  Forms,
  frmMainBase in 'frmMainBase.pas' {fmMainBase};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMainBase, fmMainBase);
  Application.Run;
end.
