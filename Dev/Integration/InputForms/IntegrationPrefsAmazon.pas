unit IntegrationPrefsAmazon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, wwdblook;

type
  TIntegrationPrefsAmazonGUI = class(TForm)
    pnlAmazonConfig: TDNMPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    lblAmazonEnabled: TLabel;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label81: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    edtAccessKey: TEdit;
    edtSecretKey: TEdit;
    edtMWSAuthToken: TEdit;
    edtSellerId: TEdit;
    edtServicesURL: TEdit;
    chkAmazonEnabled: TwwCheckBox;
    btnAmazonTest: TDNMSpeedButton;
    btnTestAccount: TDNMSpeedButton;
    Label2: TLabel;
    edtMarketplaceId: TEdit;
    cboAmazonCustomer: TwwDBLookupCombo;
    cboAmazonAFNClass: TwwDBLookupCombo;
    cboAmazonMFNClass: TwwDBLookupCombo;
    Label3: TLabel;
    qryCustomerLookup: TERPQuery;
    dsCustomerLookup: TDataSource;
    chkAutoCheckForOrders: TwwCheckBox;
    Label4: TLabel;
    qryAFNClassLookup: TERPQuery;
    qryMFNClassLookup: TERPQuery;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure chkAmazonEnabledClick(Sender: TObject);
    procedure cboAmazonCustomerChange(Sender: TObject);
    procedure cboAmazonAFNClassChange(Sender: TObject);
    procedure cboAmazonMFNClassChange(Sender: TObject);
    procedure chkAutoCheckForOrdersClick(Sender: TObject);
    procedure btnAmazonTestClick(Sender: TObject);
  private
    procedure LoadGUI;
  public
    procedure Save;
  end;

var
  IntegrationPrefsAmazonGUI: TIntegrationPrefsAmazonGUI;

implementation

{$R *.dfm}

uses
  AppEnvironment, CommonDbLib, EdiGuiUtilsObj, JsonObject, DialogUtils,
  Vista_MessageDlg;

{ TIntegrationPrefsAmazonGUI }

procedure TIntegrationPrefsAmazonGUI.btnAmazonTestClick(Sender: TObject);
var
  EdiGuiUtils: TEdiGuiUtils;
  obj: TJsonObject;
  msg: string;
  status, statusMessage: string;
begin
  EdiGuiUtils := TEdiGuiUtils.Create;
  obj := JO;
  try
    if EdiGuiUtils.GetServiceStatus(msg,obj,'Amazon', true) then begin
      status := obj.O['Amazon'].S['Status'];
      statusMessage := obj.O['Amazon'].S['StatusMessage'];
      Vista_MessageDlg.MessageDlgXP_Vista(
        'Connection with Amazon Ok' + #13#10 + #13#10 +
        'Amazon Service Status: ' + status + #13#10 +
        statusMessage,mtInformation,[mbOk],0);
    end
    else begin
      Vista_MessageDlg.MessageDlgXP_Vista(
        'Connection with Amazon Not Ok' + #13#10 + #13#10 +
        msg ,mtInformation,[mbOk],0);
    end;
  finally
    EdiGuiUtils.Free;
    obj.Free;
  end;
end;

procedure TIntegrationPrefsAmazonGUI.cboAmazonCustomerChange(Sender: TObject);
begin
  AppEnv.CompanyPrefs.AmazonConfig.AmazonCustomerID := qryCustomerLookup.FieldByName('ClientID').AsInteger;
end;
procedure TIntegrationPrefsAmazonGUI.cboAmazonAFNClassChange(Sender: TObject);
begin
  AppEnv.CompanyPrefs.AmazonConfig.AmazonAFNClassID := qryAFNClassLookup.FieldByName('ClasSId').AsInteger;
end;
procedure TIntegrationPrefsAmazonGUI.cboAmazonMFNClassChange(Sender: TObject);
begin
  AppEnv.CompanyPrefs.AmazonConfig.AmazonMFNClassID := qryMFNClassLookup.FieldByName('ClasSId').AsInteger;
end;

procedure TIntegrationPrefsAmazonGUI.chkAmazonEnabledClick(Sender: TObject);
begin
  if not chkAmazonEnabled.Focused then exit;
  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('Amazon') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;
  AppEnv.CompanyPrefs.AmazonConfig.Active := chkAmazonEnabled.Checked;
end;

procedure TIntegrationPrefsAmazonGUI.chkAutoCheckForOrdersClick(
  Sender: TObject);
begin
  if not chkAutoCheckForOrders.Focused then exit;
  AppEnv.CompanyPrefs.AmazonConfig.AutoCheckForOrders := chkAutoCheckForOrders.Checked;
end;

procedure TIntegrationPrefsAmazonGUI.edtChange(Sender: TObject);
begin
  if (Sender is TEdit) then begin
    if not TEdit(Sender).Focused then exit;
    if sender = edtAccessKey then
      AppEnv.CompanyPrefs.AmazonConfig.AccessKey := TEdit(Sender).Text
    else if sender = edtSecretKey then
      AppEnv.CompanyPrefs.AmazonConfig.SecretKey := TEdit(Sender).Text
    else if sender = edtMWSAuthToken then
      AppEnv.CompanyPrefs.AmazonConfig.MWSAuthToken := TEdit(Sender).Text
    else if sender = edtSellerId then
      AppEnv.CompanyPrefs.AmazonConfig.SellerId := TEdit(Sender).Text
    else if sender = edtMarketplaceId then
      AppEnv.CompanyPrefs.AmazonConfig.MarketplaceId := TEdit(Sender).Text
    else if sender = edtServicesURL then
      AppEnv.CompanyPrefs.AmazonConfig.ServiceURL := TEdit(Sender).Text
  end;
end;

procedure TIntegrationPrefsAmazonGUI.FormCreate(Sender: TObject);
begin
  LoadGUI;
end;

procedure TIntegrationPrefsAmazonGUI.LoadGUI;
begin
  qryCustomerLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomerLookup.Open;
  if qryCustomerLookup.Locate('ClientID',AppEnv.CompanyPrefs.AmazonConfig.AmazonCustomerID,[]) then
    cboAmazonCustomer.Text := qryCustomerLookup.FieldByName('PrintName').AsString;

  qryAFNClassLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAFNClassLookup.Open;
  if qryAFNClassLookup.Locate('ClassId',AppEnv.CompanyPrefs.AmazonConfig.AmazonAFNClassID,[]) then
    cboAmazonAFNClass.Text := qryAFNClassLookup.FieldByName('Classname').AsString;

  qryMFNClassLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryMFNClassLookup.Open;
  if qryMFNClassLookup.Locate('ClassId',AppEnv.CompanyPrefs.AmazonConfig.AmazonMFNClassID,[]) then
    cboAmazonMFNClass.Text := qryMFNClassLookup.FieldByName('Classname').AsString;


  chkAmazonEnabled.Checked := AppEnv.CompanyPrefs.AmazonConfig.Active;
  edtAccessKey.Text := AppEnv.CompanyPrefs.AmazonConfig.AccessKey;
  edtSecretKey.Text := AppEnv.CompanyPrefs.AmazonConfig.SecretKey;
  edtMWSAuthToken.Text := AppEnv.CompanyPrefs.AmazonConfig.MWSAuthToken;
  edtSellerId.Text := AppEnv.CompanyPrefs.AmazonConfig.SellerId;
  edtMarketplaceId.Text := AppEnv.CompanyPrefs.AmazonConfig.MarketplaceId;
  edtServicesURL.Text := AppEnv.CompanyPrefs.AmazonConfig.ServiceURL;
  chkAutoCheckForOrders.Checked := AppEnv.CompanyPrefs.AmazonConfig.AutoCheckForOrders;
end;

procedure TIntegrationPrefsAmazonGUI.Save;
begin
  AppEnv.CompanyPrefs.AmazonConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

end.
