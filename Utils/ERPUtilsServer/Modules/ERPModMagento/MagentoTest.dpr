program MagentoTest;

uses
  Forms,
  frmMagentoTest in 'frmMagentoTest.pas' {fmMagentoTest},
  magento_v2_soap in 'magento_v2_soap.pas',
  MagentoObjOld in 'MagentoObjOld.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  JsonDbPrefsConfigObj in '..\..\..\..\Common\JsonDbPrefsConfigObj.pas',
  UpdateTriggersObj in 'UpdateTriggersObj.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  MagentoEntityListBase in 'MagentoEntityListBase.pas',
  MagentoAttributeSetList in 'MagentoAttributeSetList.pas',
  MagentoTax in 'MagentoTax.pas',
  MagentoObj in 'MagentoObj.pas',
  MageDataFilter in 'MageDataFilter.pas',
  URILib in '..\..\..\..\Common\URILib.pas',
  StringUtils in '..\..\..\..\Common\StringUtils.pas',
  mage_v2_soap in 'mage_v2_soap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMagentoTest, fmMagentoTest);
  Application.Run;
end.
