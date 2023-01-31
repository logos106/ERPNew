program UpdateSalesBalance;

uses
  Forms,
  DLLConnectObj in '.\..\Data Updator base\DLLConnectObj.pas',
  DataUpdateObj in '.\..\Data Updator base\DataUpdateObj.pas',
  frmMainBase in '.\..\Data Updator base\frmMainBase.pas' {fmMainBase},
  DataUpdaterconfig in 'DataUpdaterconfig.pas',
  Objects in 'Objects.pas',
  frmMain in 'frmMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
