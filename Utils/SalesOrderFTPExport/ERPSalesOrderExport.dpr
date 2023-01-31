program ERPSalesOrderExport;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  SalesOrderFTPExportObj in 'SalesOrderFTPExportObj.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\Common\DbConst.pas',
  JSONObject in '..\..\Common\JSONObject.pas',
  DbSharedObjectsObj in '..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  InstallConst in '..\..\Common\InstallConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ERP Sales Order Export';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
