program Multisite;

{%File 'ERPSchema.txt'}

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  SyncConfigObj in '..\SyncConfigObj.pas',
  JSONObject in '..\..\..\Dev\General\Objects\CommonObjects\JSONObject.pas',
  frmBase in 'frmBase.pas' {fmBase},
  frmBaseEdit in 'frmBaseEdit.pas' {fmBaseEdit},
  DbConst in '..\DbConst.pas',
  DBUtils in '..\DBUtils.pas',
  frmDatabaseEdit in 'frmDatabaseEdit.pas' {fmDatabaseEdit},
  frmSiteItemEdit in 'frmSiteItemEdit.pas' {fmSiteItemEdit},
  ObjDataSync in '..\ObjDataSync.pas',
  SynchronizerThread in '..\SynchronizerThread.pas',
  UserLockBaseObj in '..\..\..\Dev\General\Objects\CommonObjects\UserLockBaseObj.pas',
  SyncObj in '..\SyncObj.pas',
  ValueFields in '..\ValueFields.pas',
  SchemaObj in '..\SchemaObj.pas',
  SynchronizerObj in '..\SynchronizerObj.pas',
  ERPSchemaData in 'ERPSchemaData.pas',
  MultisiteConfigObj in '..\MultisiteConfigObj.pas',
  JsonToObject in '..\..\..\Dev\General\Objects\CommonObjects\JsonToObject.pas',
  MultisiteObj in '..\MultisiteObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ERP Multisite';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
