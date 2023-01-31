program XMLServerGUI;

uses
  Forms,
  OgFirst,
  frmMain in 'frmMain.pas' {fmMain},
  frmSvcGuiBase in '..\..\Common\frmSvcGuiBase.pas' {fmSvcGuiBase},
  datSvcControlClient in '..\..\Common\datSvcControlClient.pas' {SvcControlClient: TDataModule},
  ServiceGuiCommon in '..\..\Common\ServiceGuiCommon.pas',
  AppVarsObj in '..\..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas',
  XMLServerControlConst in '..\XMLServerControlConst.pas',
  ControlPortsConst in '..\..\Common\ControlPortsConst.pas',
  frmLog in '..\..\Common\frmLog.pas' {fmLog},
  frmConfig in 'frmConfig.pas' {fmConfig},
  Vista_MessageDlg in '..\..\..\Dev\General\Objects\CommonObjects\Vista_MessageDlg.pas',
  LogMessageTypes in '..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  frmSvcGuiConfig in '..\..\Common\frmSvcGuiConfig.pas' {fmSvcGuiConfig},
  frmBase in '..\..\Common\frmBase.pas' {fmBase};

{$R *.res}

begin
  if IsFirstInstance then begin
    Application.Initialize;
    Application.Title := 'XML Server Control';
    Application.CreateForm(TfmMain, fmMain);
    Application.Run;
  end else begin
    ActivateFirstInstance;
  end;
end.
