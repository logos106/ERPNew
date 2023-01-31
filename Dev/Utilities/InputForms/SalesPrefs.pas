unit SalesPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/07/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton, Mask,
  wwdbedit, DB, kbmMemTable, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, DBCtrls,
  wwclearbuttongroup, wwradiogroup, wwdblook, MemDS, Wwdotdot, Wwdbcomb,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, MessageConst, frmBase, AdvEdit, BasePrefs,
  Menus, asgprev, AdvMenus, AdvTrackBar, AdvGlowButton, AdvOfficeSelectors,
  AdvScrollBox;

type
  TSalesPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryAccUnInvSO: TERPQuery;
    qryAccUnInvSOLabour: TERPQuery;
    qryAccount: TERPQuery;
    dsDefaultRunParts: TDataSource;
    qryDefaultRunParts: TERPQuery;
    qryParts: TERPQuery;
    qryColumnHeadings: TERPQuery;
    dsPersonalPreferences: TDataSource;
    qryPersonalPreferences: TERPQuery;
    QryRewardPointssoldAccount: TERPQuery;
    qryExpenseAccountforRewardPoints: TERPQuery;
    QryRewardPointsExpiredAccount: TERPQuery;
    QryStatusforSO: TERPQuery;
    QryStatusforInvoice: TERPQuery;
    QryStatusforSOid: TIntegerField;
    QryStatusforSOname: TWideStringField;
    QryStatusforInvoiceid: TIntegerField;
    QryStatusforInvoicename: TWideStringField;
    QrySaleslinesFields: TERPQuery;
    mnuEmailconfigfields: TAdvPopupMenu;
    qryclienttypeLookup: TERPQuery;
    DNMPanel23: TDNMPanel;
    Bevel28: TBevel;
    Label2: TLabel;
    wwCheckBox16: TwwCheckBox;
    wwCheckBox18: TwwCheckBox;
    wwCheckBox63: TwwCheckBox;
    chkIncludeContactNameInSalesBillingAddress: TwwCheckBox;
    DNMPanel8: TDNMPanel;
    Bevel8: TBevel;
    Bevel27: TBevel;
    Bevel26: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    wwDBLookupCombo6: TwwDBLookupCombo;
    wwDBLookupCombo5: TwwDBLookupCombo;
    wwDBLookupCombo7: TwwDBLookupCombo;
    cboWholeSaleCustomerType1: TwwDBLookupCombo;
    cboRetailcustomerType1: TwwDBLookupCombo;
    chkHideCustomertypeNotSelectedinSalesCatgbyItemReport: TDBCheckBox;
    DNMPanel22: TDNMPanel;
    Bevel29: TBevel;
    Bevel30: TBevel;
    Bevel31: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel32: TBevel;
    Bevel33: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    chkContainerRelatedProductColour: TwwCheckBox;
    chkPalletRelatedProductColour: TwwCheckBox;
    ContainerRelatedProductColour: TAdvOfficeColorSelector;
    ContainerRelatedProductGradIntensity: TAdvTrackBar;
    PalletRelatedProductColour: TAdvOfficeColorSelector;
    PalletRelatedProductGradIntensity: TAdvTrackBar;
    DNMPanel21: TDNMPanel;
    Bevel24: TBevel;
    Label12: TLabel;
    Label15: TLabel;
    Bevel25: TBevel;
    wwCheckBox29: TwwCheckBox;
    wwRadioGroup5: TwwRadioGroup;
    DNMPanel19: TDNMPanel;
    Bevel22: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Bevel20: TBevel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    wwRadioGroup3: TwwRadioGroup;
    cboStatusforInvoice: TwwDBLookupCombo;
    cboStatusforSO: TwwDBLookupCombo;
    wwCheckBox19: TwwCheckBox;
    DNMPanel20: TDNMPanel;
    Bevel21: TBevel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edtValue: TwwDBEdit;
    wwDBComboBox1: TwwDBComboBox;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo3: TwwDBLookupCombo;
    wwDBEdit9: TwwDBEdit;
    wwDBLookupCombo2: TwwDBLookupCombo;
    edtMultiples: TwwDBEdit;
    DNMPanel18: TDNMPanel;
    Bevel18: TBevel;
    Label33: TLabel;
    wwRadioGroup2: TwwRadioGroup;
    DNMPanel17: TDNMPanel;
    Bevel17: TBevel;
    Label36: TLabel;
    Label42: TLabel;
    wwCheckBox56: TwwCheckBox;
    wwDBEdit8: TwwDBEdit;
    wwCheckBox59: TwwCheckBox;
    DNMPanel14: TDNMPanel;
    Bevel14: TBevel;
    Bevel23: TBevel;
    Bevel19: TBevel;
    Label43: TLabel;
    Label48: TLabel;
    Label54: TLabel;
    Label34: TLabel;
    lblFutureSalesOrders1: TLabel;
    lblFutureSalesOrders2: TLabel;
    Label29: TLabel;
    wwCheckBox42: TwwCheckBox;
    wwCheckBox43: TwwCheckBox;
    wwCheckBox44: TwwCheckBox;
    wwCheckBox46: TwwCheckBox;
    wwCheckBox47: TwwCheckBox;
    wwCheckBox51: TwwCheckBox;
    wwCheckBox52: TwwCheckBox;
    wwCheckBox53: TwwCheckBox;
    wwCheckBox54: TwwCheckBox;
    wwCheckBox55: TwwCheckBox;
    cboDefaultSales: TwwDBLookupCombo;
    wwCheckBox57: TwwCheckBox;
    chkUseFutureSalesOrders: TwwCheckBox;
    edtFutureSalesOrdersDays: TwwDBEdit;
    wwCheckBox49: TwwCheckBox;
    wwDBEdit10: TwwDBEdit;
    chkCustomerTypeRequired: TwwCheckBox;
    wwCheckBox64: TwwCheckBox;
    edtSalesStartNum: TAdvEdit;
    wwCheckBox66: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    wwDBEdit11: TwwDBEdit;
    wwCheckBox9: TwwCheckBox;
    chkCustFirstAndLastNamesRequired: TwwCheckBox;
    DNMPanel13: TDNMPanel;
    Bevel13: TBevel;
    Label57: TLabel;
    Label59: TLabel;
    Label61: TLabel;
    wwCheckBox39: TwwCheckBox;
    cboDefaultSubPayment: TwwDBLookupCombo;
    wwDBEdit7: TwwDBEdit;
    DNMPanel12: TDNMPanel;
    Bevel12: TBevel;
    Label60: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    chkIncludeUnInvoicedSOtoGL: TwwCheckBox;
    cboUnInvoicedSOAccount: TwwDBLookupCombo;
    cboUnInvoicedSOLabourAccount: TwwDBLookupCombo;
    wwRadioGroup1: TwwRadioGroup;
    DNMPanel11: TDNMPanel;
    Bevel11: TBevel;
    Label56: TLabel;
    wwCheckBox36: TwwCheckBox;
    wwCheckBox37: TwwCheckBox;
    wwCheckBox61: TwwCheckBox;
    DNMPanel10: TDNMPanel;
    Bevel10: TBevel;
    Label52: TLabel;
    Label53: TLabel;
    Label58: TLabel;
    Label55: TLabel;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwCheckBox35: TwwCheckBox;
    wwDBEdit6: TwwDBEdit;
    DNMPanel9: TDNMPanel;
    Bevel9: TBevel;
    Label50: TLabel;
    Label51: TLabel;
    DBMemo1: TDBMemo;
    DNMPanel7: TDNMPanel;
    Bevel7: TBevel;
    Label41: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwCheckBox31: TwwCheckBox;
    wwCheckBox33: TwwCheckBox;
    wwCheckBox13: TwwCheckBox;
    wwCheckBox14: TwwCheckBox;
    DNMPanel6: TDNMPanel;
    Bevel6: TBevel;
    Label39: TLabel;
    Label40: TLabel;
    wwDBEdit1: TwwDBEdit;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Bevel34: TBevel;
    lblexplain: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label49: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    edtMaxDiscount: TEdit;
    wwCheckBox48: TwwCheckBox;
    edtMinMarkupPercentage: TEdit;
    edtMinimumMarginPercentage: TEdit;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Label35: TLabel;
    wwCheckBox32: TwwCheckBox;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label22: TLabel;
    Label75: TLabel;
    lblSortRelatedProductsinSalehint: TLabel;
    chkShowUnits: TwwCheckBox;
    chkShowCost: TwwCheckBox;
    chkShowPartsDescription: TwwCheckBox;
    chkShowProfitDollers: TwwCheckBox;
    chkShowMarkupProfitPercent: TwwCheckBox;
    chkShowGrossProfitPercent: TwwCheckBox;
    chkShowTaxCode: TwwCheckBox;
    chkShowTaxAmount: TwwCheckBox;
    chkShowDiscount: TwwCheckBox;
    chkShowSupplier: TwwCheckBox;
    chkShowSupplierContact: TwwCheckBox;
    chkQtyOnlyOnSalesOrder: TwwCheckBox;
    chkUseForeignCurrency: TwwCheckBox;
    chkShowLatestProductCost: TwwCheckBox;
    chkShowDocketNumberColumn: TwwCheckBox;
    chkEnforceMatrixAttributes: TwwCheckBox;
    chkUseProductSpecs: TwwCheckBox;
    grpDiscount: TwwRadioGroup;
    chkConfirmBeforeNegative: TwwCheckBox;
    wwRadioGroup4: TwwRadioGroup;
    chkConfirmBeforeReCalc: TwwCheckBox;
    chkAlterDate: TDBCheckBox;
    chkBODefaultOnSalesOrder: TwwCheckBox;
    chkMatchSaleLineShipDateToHeader: TwwCheckBox;
    chkMatchSalesLineShipdateToProductDeliveryDays: TDBCheckBox;
    rgLatestProductCostBasedOn: TwwRadioGroup;
    wwCheckBox25: TwwCheckBox;
    wwCheckBox26: TwwCheckBox;
    wwCheckBox30: TDBCheckBox;
    wwCheckBox68: TwwCheckBox;
    chkShowRelatedProductSelectioninSale: TDBCheckBox;
    optSalesDefaultValueForAreaFrom: TwwRadioGroup;
    wwCheckBox38: TwwCheckBox;
    chkDisableSaleLineZeroQuantityWarning: TwwCheckBox;
    chlShowSaleLineInStockQty: TwwCheckBox;
    chkMatchInvoiceDAteToShipDate: TwwCheckBox;
    wwCheckBox69: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label9: TLabel;
    wwCheckBox10: TwwCheckBox;
    wwCheckBox11: TwwCheckBox;
    wwCheckBox12: TwwCheckBox;
    wwCheckBox58: TwwCheckBox;
    wwCheckBox65: TwwCheckBox;
    chkAutomaticSODeliveryDocketPrint: TwwCheckBox;
    chkExcludeZeroAllocationsFromPickingSlip: TwwCheckBox;
    DNMPanel24: TDNMPanel;
    Bevel35: TBevel;
    Label76: TLabel;
    wwRadioGroup6: TwwRadioGroup;
    wwCheckBox6: TwwCheckBox;
    chkDisableInvCopyToSmartIfPOCreated: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label47: TLabel;
    Label77: TLabel;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    wwCheckBox5: TDBCheckBox;
    wwCheckBox7: TwwCheckBox;
    btnCustomerAccountNoSetup: TDNMSpeedButton;
    wwCheckBox60: TwwCheckBox;
    chkUSeSalesCommission: TwwCheckBox;
    wwCheckBox15: TwwCheckBox;
    chkPadQuotePricesIncTax: TwwCheckBox;
    chkAllowAlocationFromOtherClasses: TwwCheckBox;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwCheckBox17: TwwCheckBox;
    chkShowDeliveryDetailsformonDeldocketprint: TwwCheckBox;
    chkPrintAddressLabelfromDelPrint: TwwCheckBox;
    chkShowSalesProductAutoSelectOptions: TwwCheckBox;
    chkShowManufacutresummarywhenchangedfromSales: TwwCheckBox;
    chkShowAmountToAppearOnPrintout: TwwCheckBox;
    chkAusEParcel: TwwCheckBox;
    chkConvertConvertedSalesOrder: TwwCheckBox;
    wwCheckBox20: TwwCheckBox;
    wwCheckBox21: TwwCheckBox;
    wwCheckBox22: TwwCheckBox;
    wwCheckBox23: TwwCheckBox;
    wwCheckBox24: TwwCheckBox;
    wwCheckBox27: TDBCheckBox;
    wwCheckBox28: TDBCheckBox;
    chkPreventInvoiceOnStopCredit: TwwCheckBox;
    chkPreventSalesOrderOnStopCredit: TwwCheckBox;
    wwCheckBox34: TwwCheckBox;
    wwCheckBox62: TDBCheckBox;
    wwCheckBox67: TwwCheckBox;
    wwCheckBox70: TDBCheckBox;
    chkSalesDefaultAreaFromCustomer: TwwCheckBox;
    wwCheckBox50: TwwCheckBox;
    chkSalesTaxThresholdWholeOrder: TwwCheckBox;
    DNMPanel15: TDNMPanel;
    Bevel15: TBevel;
    Label69: TLabel;
    grdDefaultRunParts: TwwDBGrid;
    btnDelete: TwwIButton;
    cboProduct: TwwDBLookupCombo;
    cboFreqType: TwwDBComboBox;
    DNMPanel16: TDNMPanel;
    Bevel16: TBevel;
    Label70: TLabel;
    wwCheckBox40: TwwCheckBox;
    wwCheckBox41: TwwCheckBox;
    wwCheckBox45: TwwCheckBox;
    cboViaQry: TERPQuery;
    cboViaQryShippingMethod: TWideStringField;
    cboViaQryShippingMethodID: TAutoIncField;
    Label78: TLabel;
    cboVia: TwwDBLookupCombo;
    procedure btnCustomerAccountNoSetupClick(Sender: TObject);
    procedure cboUnInvoicedSOLabourAccountEnter(Sender: TObject);
    procedure edtMaxDiscountExit(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkUseFutureSalesOrdersClick(Sender: TObject);
    procedure cboStatusforInvoiceEnter(Sender: TObject);
    procedure cboStatusforSOEnter(Sender: TObject);
    procedure rgLatestProductCostBasedOnChange(Sender: TObject);
    procedure ContainerRelatedProductColourSelectColor(Sender: TObject;
      AColor: TColor);
    procedure PalletRelatedProductColourSelectColor(Sender: TObject;
      AColor: TColor);
    procedure chkAusEParcelClick(Sender: TObject);
    procedure wwCheckBox55Click(Sender: TObject);
    procedure edtMinMarkupPercentageExit(Sender: TObject);
    procedure edtMinimumMarginPercentageExit(Sender: TObject);
    procedure Label75MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label77MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label75Click(Sender: TObject);
    procedure Label77Click(Sender: TObject);
  private
    fPreferencesForm: TForm;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    (*procedure FillPickingSlipOrderCombo;*)
    procedure SetMaxAllowedDiscount;
    Procedure SetMinMarkupPercentage;
    Procedure SetMinimumMarginPercentage;
    procedure populatefieldListforOrderby;
    procedure GradIntensityChange(GradIntensity: TAdvTrackBar;ColorSelector: TAdvOfficeColorSelector);
    procedure SetcolorComp(TrackBar: TAdvTrackBar;
      colorSelector: TAdvOfficeColorSelector; colorField,
      GradientField: String);
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, CommonDbLib,  tcDataUtils, DNMLib,
  AppEnvironment, FastFuncs, frmSeqNumbersGUI,
  BusObjUtils, BusObjSales, tcConst ,GraphUtil, tcTypes, ShipIntegrationTypes,
  ShipIntegrationUtils,
  SalesPrefsStateFreight, Preferences;

{$R *.dfm}

procedure TSalesPrefsGUI.btnCustomerAccountNoSetupClick(Sender: TObject);
var
  AccessLevel: Integer;
begin
  inherited;
  AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCustomerAccountNoSetup');

  if (AccessLevel = 6) or (AccessLevel = 0) then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
                      [AppEnv.AccessLevels.GetFormDescription('FnCustomerAccountNoSetup')]), mtInformation, [mbOK], 0);
    Exit;
  end;

  frmSeqNumbersGUI.DoSequenceNumberConfig(CommonDbLib.SEQ_CustAccountNumber,
    'Customer Account No',
    AccessLevel,
    true);
end;

procedure TSalesPrefsGUI.cboStatusforInvoiceEnter(Sender: TObject);
begin
  inherited;
  if QryStatusforInvoice.active = False then QryStatusforInvoice.Open;
end;

procedure TSalesPrefsGUI.cboStatusforSOEnter(Sender: TObject);
begin
  inherited;
    if QryStatusforSO.active = False then QryStatusforSO.open;
end;

procedure TSalesPrefsGUI.cboUnInvoicedSOLabourAccountEnter(Sender: TObject);
begin
  qryAccUnInvSOLabour.Close;
  qryAccUnInvSOLabour.Params.ParamByName('xAccountGroup').AsString :=  Trim(cboUnInvoicedSOAccount.Text);
  qryAccUnInvSOLabour.Open;
end;

(*procedure TSalesPrefsGUI.FillPickingSlipOrderCombo;
begin
  if qryColumnHeadings.Active then begin
    with qryColumnHeadings do begin
      cboPickSlipOrder.Items.Clear;
      cboPickSlipOrder.Items.Add(FieldByName('PartColumnName').AsString);
      cboPickSlipOrder.Items.Add('Bins');
      cboPickSlipOrder.Items.Add(FieldByName('FirstColumn').AsString);
      cboPickSlipOrder.Items.Add(FieldByName('SecondColumnName').AsString);
      cboPickSlipOrder.Items.Add(FieldByName('ThirdColumnName').AsString);
      cboPickSlipOrder.Items.Add('Displayed Order');
      cboPickSlipOrder.ItemIndex := dsPrefs.FieldByName('PickingSlipOrder').AsInteger;
    end;
  end;
end;*)


procedure TSalesPrefsGUI.SetcolorComp(TrackBar:TAdvTrackBar;colorSelector :TAdvOfficeColorSelector; colorField,GradientField:String);
begin
  colorSelector.SelectedColor  := TColor(dsPrefs.DataSet.FieldByName(colorField).AsInteger);
  TrackBar.Position            := dsPrefs.DataSet.FieldByName(GradientField).AsInteger;
  TrackBar.Color               := colorSelector.SelectedColor;
  TrackBar.ColorTo             := ColorAdjustLuma(TrackBar.Color,TrackBar.Position, False);
end;

procedure TSalesPrefsGUI.populatefieldListforOrderby;
var
  stSaleslines , stCustomFields:TStringlist;
  s:string;
  ctr:Integer;
begin
  stSaleslines:= tStringlist.create;
  stCustomFields:= tStringlist.create;
  try
    Commondblib.GetFieldNames('tblsaleslines' ,stSaleslines);
    With TempMyQuery do try
      SQL.Add('select description from tblcustomfieldlist where listtype =''ltSaleslines''');
      open;
      if recordcount>0 then begin
        first;
        while Eof = False do begin
          stCustomFields.Add(trim(fieldbyname('description').asString));
          Next;
        end;
      end;
    finally
      if active then close;
    end;
    for ctr:= 0 to stSaleslines.Count-1 do
      if Sametext(copy(stSaleslines[ctr], 1,  length('SalesLinesCustField')) , 'SalesLinesCustField') then else
        if s='' then
          s:= s+' Select ' + quotedstr(stSaleslines[ctr]) +' as description, ' +quotedstr(stSaleslines[ctr]) +' as Fieldname '
        else s:= s+' Union Select ' + quotedstr(stSaleslines[ctr]) +' as description, ' +quotedstr(stSaleslines[ctr]) +' as Fieldname ' ;

    if stCustomFields.Count> 0 then
      for ctr:= 0 to stCustomFields.Count-1 do s:= s+' Union Select ' +quotedstr(stCustomFields[ctr]) +' as description, '+quotedstr('SalesLinesCustField'+trim(inttostr(ctr+1))) +' as Fieldname ' ;
  finally
    Freeandnil(stSaleslines);
    Freeandnil(stCustomFields);
  end;
  s:= s+ ' order by description ' ;
  closeDb(QrySaleslinesFields);
  QrySaleslinesFields.SQL.Clear;
  QrySaleslinesFields.SQL.Add(s);
  openDB(QrySaleslinesFields);

end;
procedure TSalesPrefsGUI.rgLatestProductCostBasedOnChange(Sender: TObject);
begin
  inherited;
  (*dsPrefs.FieldByName('UseProductBuyCostForLatestCost').AsBoolean:=
    rgLatestProductCostBasedOn.ItemIndex = 1;*)
end;
procedure TSalesPrefsGUI.GradIntensityChange(GradIntensity: TAdvTrackBar;ColorSelector: TAdvOfficeColorSelector);
begin
        TAdvTrackBar(GradIntensity).Color := TAdvOfficeColorSelector(ColorSelector).SelectedColor;
        TAdvTrackBar(GradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(GradIntensity).Color,TAdvTrackBar(GradIntensity).Position, False);
end;

procedure TSalesPrefsGUI.Label75Click(Sender: TObject);
begin
  inherited;
  TPreferencesGUI(Preferenceform).SearchForText(chkSalesDefaultAreaFromCustomer.caption, '' , true);
end;

procedure TSalesPrefsGUI.Label75MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Shift = [ssCtrl] then begin
    TPreferencesGUI(Preferenceform).SearchForText(chkSalesDefaultAreaFromCustomer.caption, '' , true);
      //setcontrolfocus(chkSalesDefaultAreaFromCustomer);
  end;
end;

procedure TSalesPrefsGUI.Label77Click(Sender: TObject);
begin
  inherited;
  TPreferencesGUI(Preferenceform).SearchForText(optSalesDefaultValueForAreaFrom.caption, '' , true);
end;

procedure TSalesPrefsGUI.Label77MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Shift = [ssCtrl] then begin
    TPreferencesGUI(Preferenceform).SearchForText(optSalesDefaultValueForAreaFrom.caption, '' , true);
      //  SetcontrolFocus(optSalesDefaultValueForAreaFrom);
  end;
end;

procedure TSalesPrefsGUI.PalletRelatedProductColourSelectColor(Sender: TObject;
  AColor: TColor);
begin
  inherited;
  GradIntensityChange(PalletRelatedproductGradIntensity ,PalletRelatedProductColour );
end;
procedure TSalesPrefsGUI.ContainerRelatedProductColourSelectColor(
  Sender: TObject; AColor: TColor);
begin
  inherited;
  GradIntensityChange(ContainerRElatedProductGradIntensity ,ContainerRelatedProductColour );
end;


procedure TSalesPrefsGUI.SetMaxAllowedDiscount;
begin
   edtMaxDiscount.Text := FloatToStrF(dsPrefs.FieldByName('MaxDiscountPercentage').AsFloat * 100,
                                      ffFixed, 7, 2) + ' %';
end;

procedure TSalesPrefsGUI.SetMinMarkupPercentage;
begin
   edtMinMarkupPercentage.Text := FloatToStrF(dsPrefs.FieldByName('MinMarkupPercentage').AsFloat * 100,
                                      ffFixed, 7, 2) + ' %';

end;
procedure TSalesPrefsGUI.SetMinimumMarginPercentage;
begin
   edtMinimumMarginPercentage.Text := FloatToStrF(dsPrefs.FieldByName('MinimumMarginPercentage').AsFloat * 100,
                                      ffFixed, 7, 2) + ' %';

end;

procedure TSalesPrefsGUI.wwCheckBox55Click(Sender: TObject);
begin
  inherited;
  if not wwCheckBox55.Focused then exit;
  if wwCheckBox55.Checked then
    CheckShippingMethods(spTNT, []);
end;

procedure TSalesPrefsGUI.edtMaxDiscountExit(Sender: TObject);
var
  TempPercent: Double;
begin
  inherited;
  edtMaxDiscount.Text := FloatToStrF(StrValue(edtMaxDiscount.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtMaxDiscount.Text) / 100;
  dsPrefs.FieldByName('MaxDiscountPercentage').AsFloat := TempPercent;
  edtMaxDiscount.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';
end;

procedure TSalesPrefsGUI.edtMinimumMarginPercentageExit(Sender: TObject);
var
  TempPercent: Double;
begin
  inherited;
  edtMinimumMarginPercentage.Text := FloatToStrF(StrValue(edtMinimumMarginPercentage.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtMinimumMarginPercentage.Text) / 100;
  dsPrefs.FieldByName('MinimumMarginPercentage').AsFloat := TempPercent;
  edtMinimumMarginPercentage.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';

end;

procedure TSalesPrefsGUI.edtMinMarkupPercentageExit(Sender: TObject);
var
  TempPercent: Double;
begin
  inherited;
  edtMinMarkupPercentage.Text := FloatToStrF(StrValue(edtMinMarkupPercentage.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtMinMarkupPercentage.Text) / 100;
  dsPrefs.FieldByName('MinMarkupPercentage').AsFloat := TempPercent;
  edtMinMarkupPercentage.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';
end;

procedure TSalesPrefsGUI.btnDeleteClick(Sender: TObject);
begin
  DeleteRecord(qryDefaultRunParts);
end;

procedure TSalesPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  lblexplain.caption := 'These Fields can be Set'+NL+'For an EMPLOYEE'+NL+'in the "Employee" page .';
  lblSortRelatedProductsinSalehint.caption := 'When Checked : Adding a Product to Sales that has Related Products, will Add the  '+NL+
                                              '                              ''Container Product'' as the First Item and all other Related  '+NL+
                                              '                              Products in Alphabetical Order';
  fPreferencesForm := nil;
  chkAusEParcel.Visible := Appenv.RegionalOptions.RegionType = RAust;
  edtMultiples.hint :='Trigger group for the Reward points that can be redeemed.'+chr(13) +
                      'ie. If this is 100 and total available points are 325, 300(multiple of 100) can be redeemed.';
  edtValue.hint :='Value for each point.'+chr(13) +
                      'ie. If Value for Redeemed Points = 1, then each Point is worth ' + appenv.RegionalOptions.CurrencySymbol +'1.'+chr(13) +
                      'ie. If trigger group is set to 100, when they redeem 100 points they get ' + appenv.RegionalOptions.CurrencySymbol +'10, then this figure will be .1'+chr(13) +
                      'ie. If trigger group is set to 200, when they redeem 200 points they get ' + appenv.RegionalOptions.CurrencySymbol +'10, then this figure will be .05';
  edtMultiples.showhint := true;
  edtValue.showhint := true;
  showcontrolhint(chkAusEParcel, 'This will only work with an Australian Database. '+ chr(13) +
                        'You need to update the ''Customer Card''  and the ''Product Card'' to reflect the eParcel Settings.');
  chkHideCustomertypeNotSelectedinSalesCatgbyItemReport.caption := 'Sales Category By Item Report  : '+NL+
                                                                    'Hide Sales of Customers of Other Type(s) in '+NL+
                                                                    '''Wholesale'' / ''Retail'' / ''Combined'' Templates';
  chkHideCustomertypeNotSelectedinSalesCatgbyItemReport.Width := 600;
  mnuEmailconfigfields.items.Clear;

  with TSalesPrefsStateFreightGUI.Create(self) do begin
    pnlStateFreight.Parent := sbpanels;
    DataSourcePrefs := self.dsPrefs;
  end;
end;

procedure TSalesPrefsGUI.chkAusEParcelClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkAusEParcel then
    if chkAusEParcel.checked then
      MessageDlgXP_vista(trim(chkAusEParcel.hint), mtInformation, [mbOK], 0);
end;

procedure TSalesPrefsGUI.chkUseFutureSalesOrdersClick(Sender: TObject);
begin
  inherited;
  edtFutureSalesOrdersDays.Enabled := chkUseFutureSalesOrders.Checked;
  lblFutureSalesOrders1.Enabled := chkUseFutureSalesOrders.Checked;
  lblFutureSalesOrders2.Enabled := chkUseFutureSalesOrders.Checked;
end;
procedure TSalesPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TSalesPrefsGUI.StartupProcess(var Msg: TMessage);
var s: string;
begin
  inherited;
  fPreferencesForm := TForm(FindControl(Msg.WParam));
  qryAccUnInvSOLabour.Close;
  qryAccUnInvSOLabour.Params.ParamByName('xAccountGroup').AsString :=  tcDataUtils.GetAccountName(dsPrefs.FieldByName('UnInvoicedSOAccount').AsInteger);
  qryAccUnInvSOLabour.Open;
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  (*FillPickingSlipOrderCombo;*)
  SetMaxAllowedDiscount;
  SetMinMarkupPercentage;
  SetMinimumMarginPercentage;
  edtFutureSalesOrdersDays.Enabled := chkUseFutureSalesOrders.Checked;
  lblFutureSalesOrders1.Enabled := chkUseFutureSalesOrders.Checked;
  lblFutureSalesOrders2.Enabled := chkUseFutureSalesOrders.Checked;
  s:= grpDiscount.Items.Text;
  s:= StringReplace(s,'$',AppEnv.RegionalOptions.CurrencySymbol,[rfReplaceAll]);
  grpDiscount.Items.Text:= s;
  (*if dsPrefs.FieldByName('UseProductBuyCostForLatestCost').AsBoolean then
    rgLatestProductCostBasedOn.ItemIndex:= 1
  else
    rgLatestProductCostBasedOn.ItemIndex:= 0;*)
  populatefieldListforOrderby;
  ShowcontrolHint(chkShowDeliveryDetailsformonDeldocketprint , 'When checked' +NL +'        Printing an ''Invoice'' will have an option to enter the delivery details.' +NL +
                                                                                     '        The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);

  ShowcontrolHint(chkPrintAddressLabelfromDelPrint , 'When checked' +NL +'        Printing a ''Delivery docket'' from ''Delivery Docket Audit'' will print the address labels if the ''no of Boxes'' are specified.' +NL +
                                                                                     '        The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);

  ShowcontrolHint(chkShowSalesProductAutoSelectOptions , 'When checked' +NL +'        Selecting a Customer in the Quote / Invoice / Sales Order will popup an option to choose multiple products from the customer''s history.' +NL +
                                                                                     '        The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);

  ShowcontrolHint(chkShowManufacutresummarywhenchangedfromSales , 'When checked' +NL +'        Assigning a value for ''Shipped'' Quantity for a ''Manufacturing Product'' in Sales Order will open a summary report of the allocation. ie: total Quantity , Qty to be taken form stock, Manufacturing Qty and Ordering Quantity.' +NL +
                                                                                     '        The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);

  SetcolorComp(PalletRelatedProductGradIntensity ,PalletRelatedProductColour  ,'PalletRelatedProductColour'  ,'PalletRelatedProductGradIntensity');
  SetcolorComp(ContainerRelatedProductGradIntensity ,ContainerRelatedProductColour  ,'ContainerRelatedProductColour'  ,'ContainerRelatedProductGradIntensity');

  ShowcontrolHint(chkShowRelatedProductSelectioninSale , 'When checked' +NL +'        Selecting a new Product in Sales will open Related Product List if the selected product has any Related Products.' +NL +
                                                                                     '        The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);
end;
procedure TSalesPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TSalesPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  (*dsPrefs.FieldByName('PickingSlipOrder').AsInteger := cboPickSlipOrder.ItemIndex;*)

  if edtSalesStartNum.IntValue > 0 then begin
    BusObjUtils.SetBusObjNextIdNo(edtSalesStartNum.IntValue, TSales, dsPrefs.Connection);
   end;

  if qryPersonalPreferences.State in [dsEdit, dsInsert] then
    qryPersonalPreferences.Post;

  if Empty(cboDefaultSales.Text) then begin
    CommonLib.MessageDlgXP_Vista('Default Sales Account cannot be blank', mtWarning, [mbOK], 0);

    if Assigned(fPreferencesForm) then begin
      SendMessage(fPreferencesForm.Handle, TX_CancelFinish, 0, 0);
      PostMessage(fPreferencesForm.Handle, TX_PerformTextSearch, 0, 0);
    end;
  end;
  if qryColumnHeadings.State in [dsEdit, dsInsert] then
    qryColumnHeadings.Post;
  editdB(dsPrefs.DataSet);
  dsPrefs.DataSet.FieldByName('ContainerRelatedProductColour').AsInteger        := Integer(ContainerRelatedProductColour.SelectedColor);
  dsPrefs.DataSet.FieldByName('PalletRelatedProductColour').AsInteger           := Integer(PalletRelatedProductColour.SelectedColor);
  dsPrefs.DataSet.FieldByName('ContainerRelatedProductGradIntensity').AsInteger := ContainerRelatedProductGradIntensity.Position;
  dsPrefs.DataSet.FieldByName('PalletRelatedProductGradIntensity').AsInteger    := PalletRelatedProductGradIntensity.Position;
  postDB(dsPrefs.DataSet);
end;

initialization
  RegisterClassOnce(TSalesPrefsGUI);
finalization
  UnRegisterClass(TSalesPrefsGUI);
end.

