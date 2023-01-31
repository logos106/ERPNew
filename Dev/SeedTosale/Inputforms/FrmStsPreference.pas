unit FrmStsPreference;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, wwdblook, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, DNMSpeedButton, Buttons, Wwdbigrd, Grids,
  Wwdbgrid;

type
  TFmStsPreference = class(TForm)
    pnlStSConfig: TDNMPanel;
    Bevel1: TBevel;
    lblTitle: TLabel;
    Label8: TLabel;
    edtStSPackageTagProduct: TEdit;
    chkUseSeedToSale: TwwCheckBox;
    edtStSPlantTagProduct: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnStSPackageTagProduct: TDNMSpeedButton;
    btnStSPlantTagProduct: TDNMSpeedButton;
    edtStSSupplier: TEdit;
    btnStSSupplier: TDNMSpeedButton;
    Label3: TLabel;
    edtStSStockAccount: TEdit;
    btnStSStockAccount: TDNMSpeedButton;
    btnInitDefaults: TDNMSpeedButton;
    chkStSUsesBins: TwwCheckBox;
    chkStSSimpleMode: TwwCheckBox;
    Label4: TLabel;
    edtStSDefaultClass: TEdit;
    btnStSDefaultClass: TDNMSpeedButton;
    Label5: TLabel;
    cboUOM: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtstsbaseurl: TEdit;
    edtstslicensenumber: TEdit;
    edtstsvendorapikey: TEdit;
    edtstsuserapikey: TEdit;
    procedure chkUseSeedToSaleClick(Sender: TObject);
    procedure edtStSPackageTagProductChange(Sender: TObject);
    procedure edtStSPlantTagProductChange(Sender: TObject);
    procedure btnStSPackageTagProductClick(Sender: TObject);
    procedure btnStSPlantTagProductClick(Sender: TObject);
    procedure edtStSSupplierChange(Sender: TObject);
    procedure btnStSSupplierClick(Sender: TObject);
    procedure btnStSStockAccountClick(Sender: TObject);
    procedure edtStSStockAccountChange(Sender: TObject);

    procedure btnInitDefaultsClick(Sender: TObject);
    procedure chkStSUsesBinsClick(Sender: TObject);
    procedure chkStSSimpleModeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStSDefaultClassClick(Sender: TObject);
    procedure edtStSDefaultClassChange(Sender: TObject);
    procedure cboUOMChange(Sender: TObject);
  private
    procedure FilterINVProducts(Sender: TObject);
    procedure OnSelectStSPackageTagProduct(Sender: TwwDbGrid);
    procedure OnSelectStSPlantTagProduct(Sender: TwwDbGrid);
    function ProductnameFromlist(Sender: TwwDbGrid): String;
    procedure onSelectStSSupplier(Sender: TwwDbGrid);
    function AccountnameFromlist(Sender: TwwDbGrid): String;
    procedure onSelectStSAccount(Sender: TwwDbGrid);
    procedure onSelectStSDefaultClass(Sender: TwwDbGrid);
    procedure FilterEXPAccount(Sender: TObject);
    procedure LoadUOM;
    { Private declarations }
  public
    procedure Load;
    Procedure Save;
  end;

(*var
  FmStsPreference: TFmStsPreference;*)

implementation

uses AppEnvironment, CommonFormLib, ProductListExpressForm, CommonDbLib,
  ChartOfAccountsListExpress, BusobjProduct, BusObjClient, BusObjGLAccount,
  CommonLib, tcConst, tcDataUtils, DbSharedObjectsObj, DNMLib, UtilitiesPrefs,
  StSConst;

{$R *.dfm}
procedure TFmStsPreference.chkUseSeedToSaleClick        (Sender: TObject);
begin
    if not chkUseSeedtoSale.Focused  then exit;
    if AppEnv.CompanyPrefs.StSConfig.UseSeedtoSale       <> chkUseSeedtoSale.Checked   then begin
      AppEnv.CompanyPrefs.StSConfig.UseSeedtoSale         := chkUseSeedtoSale.Checked  ;
      if chkUseSeedtoSale.Checked then btnInitDefaults.click;
      if chkUseSeedtoSale.Checked   then
        if AppEnv.CompanyPrefs.EnforceBinVolume then begin
          AppEnv.CompanyPrefs.EnforceBinVolume := False;
          if Assigned(Owner) then
            if Owner is TUtilitiesPrefsGUI then
              TUtilitiesPrefsGUI(Owner).ShowTimerMsg('Enabling Seed To Sales, Disables the ''Enforce Bin Volume''.  Please Choose ''Enforce Bin Volume'' Under ''Inventory Preference'' To Change it');
        end;
    end;
  end;

procedure TFmStsPreference.onSelectStSDefaultClass(Sender: TwwDbGrid);
begin
  try
    edtStSDefaultClass.text  := TwwDbGrid(Sender).datasource.dataset.fieldbyname('Classname').asString;
  Except
  end;
end;

procedure TFmStsPreference.btnInitDefaultsClick(Sender: TObject);
begin
  if (Trim(edtStSSupplier.text) = '') or (Devmode) then begin
    if TSupplier.MakeSupplier(self, STS_METRC_Supplier, true)<>0 then begin
      edtStSSupplier.text :=STS_METRC_Supplier;
    end;
    TSupplier.MakeSupplier(self, STS_BioTrackTHC_Supplier, true);
  end;

  if (Trim(edtStSPlantTagProduct.text) = '') or (Devmode) then begin
      if TProductSimple.MakeProduct(STS_PLANT_TAG_PRODUCT,nil,False,False,true,False, STS_METRC_Supplier, 'StS^Tag') then begin
        edtStSPlantTagProduct.text := STS_PLANT_TAG_PRODUCT;
      end;
  end;
  if (Trim(edtStSPackageTagProduct.text) = '') or (Devmode) then begin
      if TProductSimple.MakeProduct(STS_PACKAGE_TAG_PRODUCT,nil,False,False,true, False,STS_METRC_Supplier, 'StS^Tag') then begin
        edtStSPackageTagProduct.text := STS_PACKAGE_TAG_PRODUCT;
      end;
  end;
  if (Trim(edtStSStockAccount.text) = '') or (Devmode) then begin
    if TAccount.MakeAccount(Self, STS_PLANT_STOCK_ACCOUNT, '', 'EXP', true) <> 0 then begin
      edtStSStockAccount.text := STS_PLANT_STOCK_ACCOUNT
    end;
  end;
end;

procedure TFmStsPreference.edtStSStockAccountChange     (Sender: TObject);begin AppEnv.CompanyPrefs.StSConfig.StSStockAccount       := edtStSStockAccount.Text        ; end;
procedure TFmStsPreference.edtStSSupplierChange         (Sender: TObject);begin AppEnv.CompanyPrefs.StSConfig.StSSupplier           := edtStSSupplier.Text            ; end;
procedure TFmStsPreference.edtStSPackageTagProductChange(Sender: TObject);begin AppEnv.CompanyPrefs.StSConfig.StSPackageTagProduct  := edtStSPackageTagProduct.Text   ; end;
procedure TFmStsPreference.edtStSPlantTagProductChange  (Sender: TObject);begin AppEnv.CompanyPrefs.StSConfig.StSPlantTagProduct    := edtStSPlantTagProduct.Text     ; end;
procedure TFmStsPreference.edtStSDefaultClassChange     (Sender: TObject);begin AppEnv.CompanyPrefs.StSConfig.StSDefaultClass       := edtStSDefaultClass.Text        ; end;

procedure TFmStsPreference.btnStSDefaultClassClick      (Sender: TObject);begin  OpenERPListFormSingleselectModal('TStSClassListGUI', onSelectStSDefaultClass );end;
procedure TFmStsPreference.btnStSStockAccountClick      (Sender: TObject);begin  OpenERPListFormSingleselectModal('TChartOfAccountsListExpressGUI', onSelectStSAccount, FilterEXPAccount);end;
procedure TFmStsPreference.btnStSSupplierClick          (Sender: TObject);begin  OpenERPListFormSingleselectModal('TSupplierExpressListGUI', onSelectStSSupplier, FilterINVProducts);end;
procedure TFmStsPreference.btnStSPackageTagProductClick (Sender: TObject);begin  OpenERPListFormSingleselectModal('TProductListExpressGUI', OnSelectStSPlantTagProduct, FilterINVProducts);end;
procedure TFmStsPreference.btnStSPlantTagProductClick   (Sender: TObject);begin  OpenERPListFormSingleselectModal('TProductListExpressGUI', OnSelectStSPackageTagProduct, FilterINVProducts);end;
procedure TFmStsPreference.cboUOMChange                 (Sender: TObject);begin AppEnv.CompanyPrefs.StSConfig.StSDefaultWeightUOM       := cboUOM.Text        ;end;

procedure TFmStsPreference.Load;
begin
  chkUseSeedtosale.checked        := AppEnv.CompanyPrefs.StSConfig.UseSeedtoSale        ;
  chkStSUsesBins.checked   := AppEnv.CompanyPrefs.StSConfig.StSUsesBins   ;
  chkStSSimpleMode.checked := AppEnv.CompanyPrefs.StSConfig.StSSimpleMode ;
  edtStSPackageTagProduct.Text    := AppEnv.CompanyPrefs.StSConfig.StSPackageTagProduct ;
  edtStSPlantTagProduct.Text      := AppEnv.CompanyPrefs.StSConfig.StSPlantTagProduct   ;
  edtStSSupplier.Text             := AppEnv.CompanyPrefs.StSConfig.StSSupplier          ;
  edtStSStockAccount.Text         := AppEnv.CompanyPrefs.StSConfig.StSStockAccount      ;
  edtStSDefaultClass.Text         := AppEnv.CompanyPrefs.StSConfig.StSDefaultClass      ;
  cboUOM.Text                     := AppEnv.CompanyPrefs.StSConfig.StSDefaultWeightUOM  ;
end;

Procedure TFmStsPreference.onSelectStSAccount(Sender: TwwDbGrid);
begin
    edtStSStockAccount.text  := AccountnameFromlist(Sender);
end;
Procedure TFmStsPreference.FilterEXPAccount(Sender:TObject);
begin
  if sender is TChartOfAccountsListExpressGUI then begin
      TChartOfAccountsListExpressGUI(Sender).filterString := 'Accounttype =' +quotedstr('EXP');
  end;
end;
Procedure TFmStsPreference.FilterINVProducts(Sender:TObject);
begin
  if sender is TProductListExpressGUI then begin
      TProductListExpressGUI(Sender).filterString := 'PartType =' +quotedstr('INV');
  end;
end;

procedure TFmStsPreference.FormCreate(Sender: TObject);
begin
  chkStSUsesBins.Readonly := AppEnv.CompanyPrefs.SeedToSaleStarted;
  if AppEnv.CompanyPrefs.SeedToSaleStarted then begin
    chkStSUsesBins.Hint := trim( 'Its not possible to Change the Usage of Bins for ' + REPORT_GROUP_SeedToSale+' After Starting to Use the Module.')+NL;
    chkStSUsesBins.ShowHint := true;
  end;
  pnlStSConfig.Height :=  410;
  LoadUOM;
  SetClassLabels(Self);
end;
Procedure TFmStsPreference.LoadUOM;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQL.text := 'SELECT DISTINCT UnitName FROM tblunitsofmeasure ORDER BY UnitName';
    qry.open;
    cboUOM.items.clear;
    cboUOM.items.CommaText := qry.groupconcat('UnitName');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Procedure TFmStsPreference.onSelectStSSupplier(Sender: TwwDbGrid);
begin
  try
    edtStSSupplier.text := TwwDbGrid(Sender).datasource.dataset.fieldbyname('SupplierName').asString
  Except
  end;
end;
Procedure TFmStsPreference.OnSelectStSPackageTagProduct(Sender: TwwDbGrid);
begin
    edtStSPackageTagProduct.text  := ProductnameFromlist(Sender);
end;
Procedure TFmStsPreference.OnSelectStSPlantTagProduct(Sender: TwwDbGrid);
begin
    edtStSPlantTagProduct.text  := ProductnameFromlist(Sender);
end;
Function TFmStsPreference.ProductnameFromlist(Sender: TwwDbGrid):String;
begin
  try
    Result := TwwDbGrid(Sender).datasource.dataset.fieldbyname('ProductName').asString
  Except
  end;
end;
Function TFmStsPreference.AccountnameFromlist(Sender: TwwDbGrid):String;
begin
  try
    Result := TwwDbGrid(Sender).datasource.dataset.fieldbyname('Accountname').asString
  Except
  end;
end;

procedure TFmStsPreference.Save;
begin
  AppEnv.CompanyPrefs.StsConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

procedure TFmStsPreference.chkStSUsesBinsClick(Sender: TObject);
begin
    if not chkStSUsesBins.Focused  then exit;
    AppEnv.CompanyPrefs.StSConfig.StSUsesBins         := chkStSUsesBins.Checked  ;
    if chkStSUsesBins.Checked then btnInitDefaults.click;

end;

procedure TFmStsPreference.chkStSSimpleModeClick(Sender: TObject);
begin
    if not chkStSSimpleMode.Focused  then exit;
    AppEnv.CompanyPrefs.StSConfig.StSSimpleMode         := chkStSSimpleMode.Checked  ;
end;

end.
