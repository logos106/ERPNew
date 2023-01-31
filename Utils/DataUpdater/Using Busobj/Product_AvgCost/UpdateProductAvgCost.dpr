program UpdateProductAvgCost;

uses
  ShareMem,
  Forms,
  DLLConnectObj in '..\Data Updator base\DLLConnectObj.pas',
  DataUpdateObj in '..\Data Updator base\DataUpdateObj.pas',
  frmMainBase in '..\Data Updator base\frmMainBase.pas' {fmMainBase},
  DataUpdaterconfig in '..\Data Updator base\DataUpdaterconfig.pas',
  frmMain in 'frmMain.pas' {fmMain},
  Objects in 'Objects.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
