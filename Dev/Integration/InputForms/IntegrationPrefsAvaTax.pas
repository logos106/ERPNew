unit IntegrationPrefsAvaTax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, AdvGroupBox,
  AdvOfficeButtons, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, DNMSpeedButton, frmbase;

type
  TIntegrationPrefsAvaTaxGUI = class(TfrmBaseGUI)
    pnlAvaTaxConfig: TDNMPanel;
    Bevel1: TBevel;
    lblTitle: TLabel;
    qryTaxLocations: TERPQuery;
    dsTaxLocations: TDataSource;
    qryTaxLocationsjurisdictionTypeId: TWideStringField;
    qryTaxLocationsjurisName: TWideStringField;
    qryTaxLocationsjurisCode: TWideStringField;
    qryTaxLocationscountry: TWideStringField;
    qryTaxLocationsnexusTypeId: TWideStringField;
    PnlERP: TPanel;
    Label1: TLabel;
    OptAccountType: TAdvOfficeRadioGroup;
    Label5: TLabel;
    edtUsername: TEdit;
    Label6: TLabel;
    edtPassword: TEdit;
    Label7: TLabel;
    edtBaseURL: TEdit;
    pnlcommon: TPanel;
    Label2: TLabel;
    edtCompanyID: TEdit;
    edtAvaTaxSaleCode: TEdit;
    Label3: TLabel;
    edtCompanyCode: TEdit;
    Panel1: TPanel;
    chkEnableAvaTax: TwwCheckBox;
    chkShowAvaTaxOnMainMenu: TwwCheckBox;
    chkAutosynchList: TwwCheckBox;
    pnlLocations: TPanel;
    Label9: TLabel;
    btnNewLoc: TDNMSpeedButton;
    grdTaxLocations: TwwDBGrid;
    pnlHint: TPanel;
    lblHintAvalara: TLabel;
    btnCoreEdiDetails: TDNMSpeedButton;
    lblHintAvalaraLink: TLabel;
    Panel2: TPanel;
    lblNotaxTaxcode: TLabel;
    lblTaxExcemptTaxCode: TLabel;
    lblPickupTaxcode: TLabel;
    lblShippingTaxcode: TLabel;
    Label12: TLabel;
    edtNotaxTaxcode: TEdit;
    edtTaxExcemptTaxCode: TEdit;
    edtShippingTaxcode: TEdit;
    edtPickupTaxcode: TEdit;
    Panel3: TPanel;
    lblTaxCodehint: TLabel;
    btnNotaxTaxcode: TDNMSpeedButton;
    btnTaxExcemptTaxCode: TDNMSpeedButton;
    btnPickupTaxcode: TDNMSpeedButton;
    btnShippingTaxcode: TDNMSpeedButton;
    Label4: TLabel;
    Panel4: TPanel;
    lblPickupShipingMethod: TLabel;
    edtPickupShipingMethod: TEdit;
    btnPickupShipingMethod: TDNMSpeedButton;
    lblCommittedStatus: TLabel;
    edtCommittedStatus: TEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    btnTaxCodesinAvalara: TDNMSpeedButton;

    procedure chkEnableAvaTaxClick(Sender: TObject);
    procedure chkAutosynchListClick(Sender: TObject);
    procedure chkShowAvaTaxOnMainMenuClick(Sender: TObject);
    procedure OptAccountTypeClick(Sender: TObject);
    procedure edtUsernameChange(Sender: TObject);
    procedure edtPasswordChange(Sender: TObject);
    procedure edtBaseURLChange(Sender: TObject);
    procedure edtCompanyIDChange(Sender: TObject);
    procedure edtAvaTaxSaleCodeChange(Sender: TObject);
    procedure edtCompanycodeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewLocClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCoreEdiDetailsClick(Sender: TObject);
    procedure lblHintAvalaraMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure edtNotaxTaxcodeChange(Sender: TObject);
    procedure edtPickupShipingMethodChange(Sender: TObject);
    procedure edtCommittedStatusChange(Sender: TObject);
    procedure edtTaxExcemptTaxcodeChange(Sender: TObject);
    procedure edtPickupTaxcodeChange(Sender: TObject);
    procedure edtShippingTaxcodeChange(Sender: TObject);
    procedure chooseTaxCode(Sender: TObject);
    procedure btnPickupShipingMethodClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnTaxCodesinAvalaraClick(Sender: TObject);
  private
    IsPrefLoaded :Boolean;
    btnTaxCode: TDNMSpeedButton;
    procedure RefreshAvaTaxNexus;
    procedure setMyConnection(const Value: TERPConnection);
    Function IsAvaTaxCredentialsValidated:Boolean;
    procedure SelectTaxCode(Sender: TwwDbGrid);
    procedure SelectShippingMethod(Sender: TwwDbGrid);
    procedure SelectCommtStatus(Sender: TwwDbGrid);
    { Private declarations }
  public
    procedure Load;
    procedure Save;
    Property MyConnection :TERPConnection write setMyConnection;
  end;

implementation

uses CommonDbLib, AppEnvironment, AvaTaxConfigObj, IdHTTP, IdSSLOpenSSL ,IdAuthentication,
  JSONObject, ERPLib, Preferences,
  CommonLib, ShellAPI, tcConst, CommonFormLib, SimpleTypes ,DevemodeLib;

{$R *.dfm}

{ TIntegrationPrefsAvaTaxGUI }

procedure TIntegrationPrefsAvaTaxGUI.btnCoreEdiDetailsClick(Sender: TObject);
begin
  TPreferencesGUI(FindExistingComponent('TPreferencesGUI',0)).SearchForText(DoTranslate('CoreEDI'), '' , true);
//  OpenPrefform('' ,  'edtCoreEDIUSerName');
end;

procedure TIntegrationPrefsAvaTaxGUI.btnNewLocClick(Sender: TObject);
begin
(*  if TfmIntegrationPrefsAvaTaxTaxLocation.AddNewTaxLocation(Self) then  begin
     RefreshAvaTaxNexus;
  end;*)
end;

procedure TIntegrationPrefsAvaTaxGUI.btnPickupShipingMethodClick(Sender: TObject);
begin
  inherited;
  if not (sender is TDNMSpeedButton) then exit;
  OpenERPListFormSingleselectModal('TShippingMethodsGUI', SelectShippingMethod);
end;

procedure TIntegrationPrefsAvaTaxGUI.btnTaxCodesinAvalaraClick(Sender: TObject);
begin
  inherited;
  showDevhelp('Taxcodes in Avalara');
end;

procedure TIntegrationPrefsAvaTaxGUI.chooseTaxCode(Sender: TObject);
begin
  inherited;
  if not (sender is TDNMSpeedButton) then exit;
  btnTaxCode := TDNMSpeedButton(Sender);
  try
    OpenERPListFormSingleselectModal('TTaxCodeListGUI', SelectTaxCode);
  finally
    btnTaxCode := nil;
  end;
end;
procedure TIntegrationPrefsAvaTaxGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if not (sender is TDNMSpeedButton) then exit;
  TSimpleTypesGUI.SimpleTypesLeadStatusTypeList(True, SelectCommtStatus);
end;
procedure TIntegrationPrefsAvaTaxGUI.SelectCommtStatus(Sender: TwwDbGrid);
var
  ds : TDataSet;
begin
  ds := Sender.DataSource.DataSet;
  edtCommittedStatus.text:= ds.FieldByName('Name').asString;
  edtCommittedStatusChange(edtCommittedStatus);
end;
procedure TIntegrationPrefsAvaTaxGUI.SelectShippingMethod(Sender: TwwDbGrid);
var
  ds : TDataSet;
begin
  ds := Sender.DataSource.DataSet;
  edtPickupShipingMethod.text:= ds.FieldByName('ShippingMethod').asString;
  edtPickupShipingMethodChange(edtPickupShipingMethod);
end;
Procedure TIntegrationPrefsAvaTaxGUI.SelectTaxCode(Sender: TwwDbGrid);
var
  ds : TDataSet;
begin
  if btnTaxCode = nil then exit;
  ds := Sender.DataSource.DataSet;
  if btnTaxCode = btnNotaxTaxcode then begin
    edtNotaxTaxcode.text:= ds.FieldByName('Name').asString;
    edtNotaxTaxcodeChange(edtNotaxTaxcode);
  end else if btnTaxCode = btnTaxExcemptTaxcode then begin
    edtTaxExcemptTaxcode.text:= ds.FieldByName('Name').asString;
    edtTaxExcemptTaxcodeChange(edtTaxExcemptTaxcode);
  end else if btnTaxCode = btnPickupTaxcode then begin
    edtPickupTaxcode.text:= ds.FieldByName('Name').asString;
    edtPickupTaxcodeChange(edtPickupTaxcode);
  end else if btnTaxCode = btnShippingTaxcode then begin
    edtShippingTaxcode.text:= ds.FieldByName('Name').asString;
    edtShippingTaxcodeChange(edtShippingTaxcode);
  end;
end;

procedure TIntegrationPrefsAvaTaxGUI.chkAutosynchListClick(Sender        : TObject);begin if not IsPrefLoaded then exit; if not chkAutoSynchList.Focused          then exit;  AppEnv.CompanyPrefs.AvaTaxConfig.AutoSynchList         := chkAutoSynchList.Checked        ;end;
procedure TIntegrationPrefsAvaTaxGUI.chkEnableAvaTaxClick(Sender         : TObject);begin if not IsPrefLoaded then exit; if not chkEnableAvaTax.Focused           then exit;  AppEnv.CompanyPrefs.AvaTaxConfig.EnableAvaTax          := chkEnableAvaTax.Checked         ;end;
procedure TIntegrationPrefsAvaTaxGUI.chkShowAvaTaxOnMainMenuClick (Sender: TObject);begin if not IsPrefLoaded then exit; if not chkShowAvaTaxOnMainMenu.Focused   then exit;  AppEnv.CompanyPrefs.AvaTaxConfig.ShowAvaTaxOnMainMenu  := chkShowAvaTaxOnMainMenu.Checked ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtPasswordChange            (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.Password        ,edtPassword.Text         ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.Password        := edtPassword.Text         ;RefreshAvaTaxNexus;end;
procedure TIntegrationPrefsAvaTaxGUI.edtCompanyIDChange           (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.CompanyID       ,edtCompanyID.Text        ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.CompanyID       := edtCompanyID.Text        ;RefreshAvaTaxNexus;end;
procedure TIntegrationPrefsAvaTaxGUI.edtAvaTaxSaleCodeChange      (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.AvaTaxSaleCode  ,edtAvaTaxSaleCode.Text   ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.AvaTaxSaleCode  := edtAvaTaxSaleCode.Text   ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtUsernameChange            (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.Username        ,edtUsername.Text         ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.Username        := edtUsername.Text         ;RefreshAvaTaxNexus;end;
procedure TIntegrationPrefsAvaTaxGUI.edtBaseURLChange             (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.BaseURL         ,edtBaseURL.Text          ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.BaseURL         := edtBaseURL.Text          ;end;

procedure TIntegrationPrefsAvaTaxGUI.edtCompanycodeChange         (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.Companycode     ,edtCompanycode.Text      ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.Companycode     := edtCompanycode.Text      ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtNotaxTaxcodeChange        (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.NotaxTaxcode    ,edtNotaxTaxcode.Text     ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.NotaxTaxcode    := edtNotaxTaxcode.Text     ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtTaxExcemptTaxcodeChange   (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.TaxExcemptTaxcode,edtTaxExcemptTaxcode.Text ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.TaxExcemptTaxcode:= edtTaxExcemptTaxcode.Text ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtPickupTaxcodeChange       (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.PickupTaxcode   ,edtPickupTaxcode.Text    ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.PickupTaxcode   := edtPickupTaxcode.Text    ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtShippingTaxcodeChange     (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.avaTaxConfig.ShippingTaxcode ,edtShippingTaxcode.Text  ) then exit; AppEnv.CompanyPrefs.avaTaxConfig.ShippingTaxcode := edtShippingTaxcode.Text  ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtPickupShipingMethodChange (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.PickupShipingMethod          ,edtPickupShipingMethod.Text) then exit; AppEnv.CompanyPrefs.PickupShipingMethod    := edtPickupShipingMethod.Text     ;end;
procedure TIntegrationPrefsAvaTaxGUI.edtCommittedStatusChange     (Sender: TObject);begin if not IsPrefLoaded then exit; if sametext(AppEnv.CompanyPrefs.CommittedStatus              ,edtCommittedStatus.Text    ) then exit; AppEnv.CompanyPrefs.CommittedStatus        := edtCommittedStatus.Text     ;end;

procedure TIntegrationPrefsAvaTaxGUI.FormCreate(Sender: TObject);
begin
  inherited;
  btnTaxCodesinAvalara.visible := commonlib.Devmode;
  IsPrefLoaded := False;
(*  PNLErp.visible :=IsERPCustomEnabled ;
  if IsERPCustomEnabled then begin
  end else begin
    pnlAvaTaxConfig.Height :=pnlAvaTaxConfig.Height -PNLErp.Height;
  end;*)
  pnlAvaTaxConfig.Height := pnlHint.Top + pnlHint.Height + 20;
  pnlLocations.Visible := false;
  lblHintAvalara.Color        := pnlAvaTaxConfig.Color;
  lblHintAvalaraLink.Color    := pnlAvaTaxConfig.Color;
  lblTaxCodehint.Color        := pnlAvaTaxConfig.Color;
  grdTaxLocations.TitleColor  := pnlAvaTaxConfig.Color;
  grdTaxLocations.FooterColor := pnlAvaTaxConfig.Color;
  AppEnv.CompanyPrefs.AvaTaxConfig.CheckIsAvaTaxCredentialsValidated :=IsAvaTaxCredentialsValidated;
  lblTaxCodehint.Caption := 'Please Make Sure'+NL+
                            'that One of These '+NL+
                            'Tax Codes is Assigned'+NL+
                            'to The Customer Card'+NL+
                            '(Accounts.Default Taxcode)'
end;
procedure TIntegrationPrefsAvaTaxGUI.FormDestroy(Sender: TObject);
begin
  AppEnv.CompanyPrefs.AvaTaxConfig.CheckIsAvaTaxCredentialsValidated := nil;
  inherited;
end;

Function TIntegrationPrefsAvaTaxGUI.IsAvaTaxCredentialsValidated : Boolean;
var
  IdHTTP: TIdHTTP;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;
  sdata:String;
  j:TJsonObject;
begin
          Result := False;
          try
              IdHTTP := TIdHTTP.Create(nil);
              LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
              IdHTTP.IOHandler := LHandler;
              IdHTTP.Request.Accept          := 'text/javascript';
              IdHTTP.Request.ContentType     := 'application/json';
              IdHTTP.Request.ContentEncoding := 'utf-8';
              IdHTTP.Request.BasicAuthentication     := true;
              IdHTTP.Request.Authentication          := TIdBasicAuthentication.Create;
              IdHTTP.Request.Authentication.Username := AppEnv.CompanyPrefs.AvaTaxConfig.Username;
              IdHTTP.Request.Authentication.Password := AppEnv.CompanyPrefs.AvaTaxConfig.Password;
              //sdata := IdHTTP.Get(AppEnv.CompanyPrefs.AvaTaxConfig.BaseURL+'utilities/ping');
              try
                sdata := IdHTTP.Get(AppEnv.CompanyPrefs.AvaTaxConfig.PINGURL);
              Except
                on E:Exception do begin
                 sdata:= '';
                end;
              end;

              if sdata ='' then exit;
              j:= jo(sdata);
              try
                if J.exists('authenticated') and J.B['authenticated'] then
                  if J.exists('authenticationType') and (sametext(J.S['authenticationType'], 'UsernamePassword')) then
                    if J.exists('authenticatedUserName') and (sametext(J.S['authenticatedUserName'], AppEnv.CompanyPrefs.AvaTaxConfig.Username)) then
                      Result := True;
              finally
                Freeandnil(j);
              end;
          finally
              LHandler.Free;
              FreeAndNil(IdHTTP);
          end;

end;

procedure TIntegrationPrefsAvaTaxGUI.lblHintAvalaraMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  fsURL:String;
begin
  inherited;
    if (Shift = [ssCtrl,ssLeft]) then begin
      if OptAccountType.itemindex =0 then fsURL :=AvaTax_Sandbox_URL else fsURL :=AvaTax_Production_URL;
      ShellExecute(0, 'open', pWidechar(fsURL), nil, nil, sw_shownormal);
    end;
end;

procedure TIntegrationPrefsAvaTaxGUI.Load;
begin
  chkEnableAvaTax.checked         := AppEnv.CompanyPrefs.AvaTaxConfig.EnableAvaTax        ;
  chkShowAvaTaxOnMainMenu.checked := AppEnv.CompanyPrefs.AvaTaxConfig.ShowAvaTaxOnMainMenu;
  chkAutosynchList.checked        := AppEnv.CompanyPrefs.AvaTaxConfig.AutosynchList        ;
  edtUsername.Text                := AppEnv.CompanyPrefs.AvaTaxConfig.Username         ;
  edtPassword.Text                := AppEnv.CompanyPrefs.AvaTaxConfig.Password      ;
  edtBaseURL.Text                 := AppEnv.CompanyPrefs.AvaTaxConfig.BaseURL      ;
  edtCompanyID.Text               := AppEnv.CompanyPrefs.AvaTaxConfig.CompanyID      ;
  edtAvaTaxSaleCode.Text               := AppEnv.CompanyPrefs.AvaTaxConfig.AvaTaxSaleCode      ;
  edtCompanycode.Text             := AppEnv.CompanyPrefs.AvaTaxConfig.Companycode      ;
  if AppEnv.CompanyPrefs.IsAvaTaxSandBox  then   OptAccountType.itemindex := 0 else OptAccountType.itemindex := 1;
  edtNotaxTaxcode.Text            := AppEnv.CompanyPrefs.AvaTaxConfig.NotaxTaxcode ;
  edtPickupShipingMethod.Text            := AppEnv.CompanyPrefs.PickupShipingMethod ;
  edtCommittedStatus.Text            := AppEnv.CompanyPrefs.CommittedStatus ;
  edtTaxExcemptTaxcode.Text        := AppEnv.CompanyPrefs.AvaTaxConfig.TaxExcemptTaxcode ;
  edtPickupTaxcode.Text           := AppEnv.CompanyPrefs.AvaTaxConfig.PickupTaxcode ;
  edtShippingTaxcode.Text         := AppEnv.CompanyPrefs.AvaTaxConfig.ShippingTaxcode ;
  IsPrefLoaded := true;
  RefreshAvaTaxNexus;
end;
procedure TIntegrationPrefsAvaTaxGUI.RefreshAvaTaxNexus;
var
  IdHTTP: TIdHTTP;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;
  sData :String;
  j :TJsonObject;
  ctr:Integer;
  Function NexusItemDetails(aJO:TJsonObject):String;
  begin
    if aJO <> nil then begin
    try
      Result :='Select ' + Quotedstr(aJo.S['jurisdictionTypeId']) +' as jurisdictionTypeId, '+
                           Quotedstr(aJo.S['jurisName']) +' as jurisName, ' +
                           Quotedstr(aJo.S['jurisCode']) +' as jurisCode, '+
                           Quotedstr(aJo.S['country']) +' as country, '+
                           Quotedstr(aJo.S['nexusTypeId']) +' as nexusTypeId ';
    Except
      on E:EXception do begin
        REsult := '';
      end;
    end;
    end else begin
      Result :='Select "None Found" as jurisdictionTypeId, '+
                       '""  as jurisName, ' +
                       '""  as jurisCode, '+
                       '""  as country, '+
                       '""  as nexusTypeId ';
    end;

    (*if sametext(aJo.S['jurisdictionTypeId'] , 'Country') then
      Result :='Select ' + Quotedstr(aJo.S['jurisName']) +' as Country'
    else begin
      Result := Result :='Select ' + Quotedstr(aJo.S['country'])+'  as Country, ' ;
                Quotedstr(aJo.S['jurisName']) +' as Country'
      result+'(' + aJo.S['jurisdictionTypeId']+')';
    end;
    Result :=  Result + '-' + aJo.S['nexusTypeId'];*)
  end;
begin
  if not IsPrefLoaded  then exit;
  if AppEnv.CompanyPrefs.AvaTaxConfig.CompanyID = '' then exit;
  if AppEnv.CompanyPrefs.AvaTaxConfig.Username = '' then exit;
  if AppEnv.CompanyPrefs.AvaTaxConfig.Password = '' then exit;
  if not(Assigned(qryTaxLocations.connection)) then exit;
  Closedb(qryTaxLocations);
  try
      qryTaxLocations.SQL.Clear;
      try
          try
              IdHTTP := TIdHTTP.Create(nil);
              LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
              IdHTTP.IOHandler := LHandler;
              IdHTTP.Request.Accept          := 'text/javascript';
              IdHTTP.Request.ContentType     := 'application/json';
              IdHTTP.Request.ContentEncoding := 'utf-8';
              IdHTTP.Request.BasicAuthentication     := true;
              IdHTTP.Request.Authentication          := TIdBasicAuthentication.Create;
              IdHTTP.Request.Authentication.Username := AppEnv.CompanyPrefs.AvaTaxConfig.Username;
              IdHTTP.Request.Authentication.Password := AppEnv.CompanyPrefs.AvaTaxConfig.Password;
              sdata := IdHTTP.Get('https://sandbox-rest.avatax.com/api/v2/companies/'+AppEnv.CompanyPrefs.AvaTaxConfig.CompanyID+'/nexus');
              if sdata ='' then exit;
              j := jo(sdata);
              try
                  if j.exists('value') then begin
                    for ctr:= 0 to j.A['Value'].Count - 1 do begin
                      sdata := NexusItemDetails(J.A['Value'].Items[ctr].AsObject);
                      if sdata <> '' then
                        if qryTaxLocations.SQL.count >0 then qryTaxLocations.SQL.add('Union ' +sdata)
                        else qryTaxLocations.SQL.add(sdata)
                    end;
                  end;
              finally
                Freeandnil(j);
              end;
          finally
              LHandler.Free;
              FreeAndNil(IdHTTP);
          end;
      Except
        on E:Exception do begin
        end;
      end;
  finally
    if qryTaxLocations.SQL.count =0 then
      qryTaxLocations.SQL.text := NexusItemDetails(nil);
    opendb(qryTaxLocations);
  end;

end;
procedure TIntegrationPrefsAvaTaxGUI.OptAccountTypeClick(Sender: TObject);
begin
  if OptAccountType.itemindex =0 then AppEnv.CompanyPrefs.AvaTaxConfig.AvaTax_AccountType  := AvaTax_SandBox
                                 else AppEnv.CompanyPrefs.AvaTaxConfig.AvaTax_AccountType  := AvaTax_Production;

  if OptAccountType.itemindex =0 then edtBaseURL.text := 'https://sandbox-rest.avatax.com/api/v2'
                                 else edtBaseURL.text := 'https://rest.avatax.com/api/v2';
  edtBaseURLChange(edtBaseURL);
end;

procedure TIntegrationPrefsAvaTaxGUI.Save;
begin
  AppEnv.CompanyPrefs.AvaTaxConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

procedure TIntegrationPrefsAvaTaxGUI.setMyConnection( const Value: TERPConnection);
begin
  Closedb(qryTaxLocations);
  qryTaxLocations.connection := Value;
end;

end.
