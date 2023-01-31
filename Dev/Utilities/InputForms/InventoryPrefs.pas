unit InventoryPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MessageConst, StdCtrls, Mask, wwdbedit, ExtCtrls, DNMPanel, DB,
  DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, wwcheckbox, MemDS, wwdblook,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, frmBase, Wwdbspin, BasePrefs, AdvTrackBar, AdvGlowButton,
  AdvOfficeSelectors, Menus, AdvScrollBox;

type
  TInventoryPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryAccount: TERPQuery;
    dsPartsClassPreferences: TDataSource;
    qryPartsClassPreferences: TERPQuery;
    qryClass  : TERPQuery;
    cbTaxCodeQry: TERPQuery;
    cbTaxCodeQryName: TWideStringField;
    cbTaxCodeQryDescription: TWideStringField;
    cbTaxCodeQryTaxRatePercent: TFloatField;
    cbTaxCodeQryRate: TFloatField;
    cbTaxCodeQryTaxCodeID: TAutoIncField;
    cbTaxCodeQryTaxCode: TWideStringField;
    DNMPanel4: TDNMPanel;
    Bevel5: TBevel;
    Label2: TLabel;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    wwCheckBox9: TwwCheckBox;
    wwCheckBox19: TwwCheckBox;
    wwCheckBox21: TwwCheckBox;
    chkUseBarcodeDispatch: TwwCheckBox;
    DNMPanel5: TDNMPanel;
    Bevel28: TBevel;
    Bevel6: TBevel;
    Bevel10: TBevel;
    Bevel14: TBevel;
    Bevel13: TBevel;
    Bevel7: TBevel;
    Label9: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Bevel29: TBevel;
    Label35: TLabel;
    wwCheckBox10: TwwCheckBox;
    wwCheckBox11: TwwCheckBox;
    wwCheckBox14: TwwCheckBox;
    wwCheckBox15: TwwCheckBox;
    wwCheckBox16: TwwCheckBox;
    btnChangePrices: TDNMSpeedButton;
    wwCheckBox17: TwwCheckBox;
    edtWholesalePercentage: TEdit;
    edtMinAboveCost: TEdit;
    wwRadioGroup1: TwwRadioGroup;
    wwRadioGroup2: TwwRadioGroup;
    wwRadioGroup4: TwwRadioGroup;
    wwRadioGroup5: TwwRadioGroup;
    wwDBSpinEdit1: TwwDBSpinEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    chkRoundLotsnfrom: TwwCheckBox;
    wwRadioGroup3: TwwRadioGroup;
    wwDBEdit12: TwwDBEdit;
    wwCheckBox25: TwwCheckBox;
    wwCheckBox26: TwwCheckBox;
    wwCheckBox27: TwwCheckBox;
    wwCheckBox30: TwwCheckBox;
    wwCheckBox24: TwwCheckBox;
    wwCheckBox28: TwwCheckBox;
    cbxProductReorderRoundValue: TComboBox;
    edtRoundUp: TwwDBSpinEdit;
    spedtRoundLotsOf: TwwDBSpinEdit;
    DNMPanel6: TDNMPanel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label32: TLabel;
    Label33: TLabel;
    Label37: TLabel;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    DNMPanel7: TDNMPanel;
    Bevel15: TBevel;
    Bevel17: TBevel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Bevel16: TBevel;
    chkPartCalcfield1: TwwCheckBox;
    chkPartCalcfield2: TwwCheckBox;
    chkPartCalcfield4: TwwCheckBox;
    chkPartCalcfield3: TwwCheckBox;
    chkPartCalcfield5: TwwCheckBox;
    edtPartCalcField1: TwwDBEdit;
    edtPartCalcField2: TwwDBEdit;
    edtPartCalcField3: TwwDBEdit;
    edtPartCalcField4: TwwDBEdit;
    edtPartCalcField5: TwwDBEdit;
    QtysoldColorSelector: TAdvOfficeColorSelector;
    QtySoldGradIntensity: TAdvTrackBar;
    QtyshippedColorSelector: TAdvOfficeColorSelector;
    QtyShippedGradIntensity: TAdvTrackBar;
    DNMPanel8: TDNMPanel;
    Bevel19: TBevel;
    Label44: TLabel;
    Label36: TLabel;
    wwCheckBox22: TwwCheckBox;
    wwCheckBox23: TwwCheckBox;
    DNMPanel9: TDNMPanel;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Bevel23: TBevel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    SNAllocationGradIntensity: TAdvTrackBar;
    SNAllocationColour: TAdvOfficeColorSelector;
    BinAllocationColour: TAdvOfficeColorSelector;
    BinAllocationGradIntensity: TAdvTrackBar;
    BatchAllocationGradIntensity: TAdvTrackBar;
    BatchAllocationColour: TAdvOfficeColorSelector;
    wwCheckBox4: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox1: TwwCheckBox;
    wwRadioGroup6: TwwRadioGroup;
    wwCheckBox31: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    Label3: TLabel;
    DNMPanel10: TDNMPanel;
    Bevel20: TBevel;
    Label50: TLabel;
    Label51: TLabel;
    Label1: TLabel;
    wwCheckBox33: TwwCheckBox;
    edtPQADEtailsCUSTFLD1: TwwDBEdit;
    chkUseCustFld1ForSaleLineBatchAllocation: TwwCheckBox;
    wwCheckBox29: TwwCheckBox;
    wwDBEdit13: TwwDBEdit;
    DNMPanel12: TDNMPanel;
    Label52: TLabel;
    pnldefProductvalues4: TDNMPanel;
    Bevel9: TBevel;
    Label4: TLabel;
    grdDefaultClass: TwwDBGrid;
    btnDelete: TwwIButton;
    cboClassName: TwwDBLookupCombo;
    pnldefProductvalues3: TDNMPanel;
    Bevel8: TBevel;
    Label5: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwDBLookupCombo3: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwDBLookupCombo1: TwwDBLookupCombo;
    pnldefProductvalues2: TDNMPanel;
    Bevel4: TBevel;
    Label8: TLabel;
    Label38: TLabel;
    Label53: TLabel;
    cboTaxCode: TwwDBLookupCombo;
    cboPURTaxCode: TwwDBLookupCombo;
    pnldefProductvalues1: TDNMPanel;
    Bevel1: TBevel;
    Label54: TLabel;
    Label55: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwCheckBox13: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox20: TwwCheckBox;
    rgUOMToBeUsedInManufactureDefault: TRadioGroup;
    wwCheckBox32: TwwCheckBox;
    DNMPanel11: TDNMPanel;
    Bevel24: TBevel;
    Label56: TLabel;
    Bevel27: TBevel;
    rgoption: TwwRadioGroup;
    pnlStandedCost: TDNMPanel;
    Bevel35: TBevel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    cboStandardCostPurchaseAdjustmentAccountID: TwwDBLookupCombo;
    chkUseStandardCosting: TwwCheckBox;
    rgStockCostSystem: TwwRadioGroup;
    cboStandardCostCOGSAdjustmentAccountID: TwwDBLookupCombo;
    chkCostEditableinSales: TwwCheckBox;
    DNMPanel13: TDNMPanel;
    Bevel30: TBevel;
    Label62: TLabel;
    Label63: TLabel;
    optTotalvolumeUOMInsmartOrder: TwwRadioGroup;
    wwDBEdit14: TwwDBEdit;
    DNMPanel14: TDNMPanel;
    Bevel33: TBevel;
    Label64: TLabel;
    lblProductName: TLabel;
    lblProductfirstcolumn: TLabel;
    lblProductSecondcolumn: TLabel;
    lblThirdColumn: TLabel;
    lblSalesDesc: TLabel;
    lblPODesc: TLabel;
    lblPreferedSupplier: TLabel;
    lblSupProductcode: TLabel;
    lblProductcomboWidthHint: TLabel;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit15: TwwDBEdit;
    wwDBEdit17: TwwDBEdit;
    wwDBEdit18: TwwDBEdit;
    wwDBEdit19: TwwDBEdit;
    wwDBEdit20: TwwDBEdit;
    wwDBEdit21: TwwDBEdit;
    wwDBEdit22: TwwDBEdit;
    DNMPanel3: TDNMPanel;
    Bevel31: TBevel;
    Bevel32: TBevel;
    Bevel34: TBevel;
    Bevel36: TBevel;
    Bevel37: TBevel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    wwDBEdit23: TwwDBEdit;
    wwDBEdit24: TwwDBEdit;
    chkPackWeightQtyField1: TwwCheckBox;
    chkPackWeightQtyField2: TwwCheckBox;
    chkEnablePackWeightField1: TwwCheckBox;
    chkEnablePackWeightField2: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label6: TLabel;
    Label27: TLabel;
    lblAttrib1Caption: TLabel;
    lblAttrib2caption: TLabel;
    Label71: TLabel;
    chkEnableAttributes: TwwCheckBox;
    edtNoOfAttribstodisplay: TwwDBEdit;
    chkShowMeasurementAttributes: TwwCheckBox;
    edtProductAttrib1Name: TwwDBEdit;
    edtProductAttrib2Name: TwwDBEdit;
    wwCheckBox18: TwwCheckBox;
    wwDBEdit16: TwwDBEdit;
    chkGrossWeightnQtyRelated: TwwCheckBox;
    chkSubBOMUseAvailableQtyFromStock: TwwCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    lblhint1: TLabel;
    lblhint2: TLabel;
    lblhint3: TLabel;
    Label7: TLabel;
    chkAutoLocateLastRecord: TwwCheckBox;
    wwCheckBox12: TwwCheckBox;
    chkEnableProductOptions: TwwCheckBox;
    procedure chkEnableAttributesClick(Sender: TObject);
    procedure edtWholesalePercentageExit(Sender: TObject);
    procedure grdDefaultClassExit(Sender: TObject);
    procedure edtMinAboveCostExit(Sender: TObject);
    procedure rgStockCostSystemChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnChangePricesClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure chkShowMeasurementAttributesClick(Sender: TObject);
    procedure chkPartCalcfield1Exit(Sender: TObject);
    procedure chkPartCalcfield2Exit(Sender: TObject);
    procedure chkPartCalcfield3Exit(Sender: TObject);
    procedure chkPartCalcfield4Exit(Sender: TObject);
    procedure chkPartCalcfield5Exit(Sender: TObject);
    procedure QtySoldColorSelectorSelectColor(Sender: TObject; AColor: TColor);
    procedure QtyshippedColorSelectorSelectColor(Sender: TObject;AColor: TColor);
    procedure BatchAllocationColourSelectColor(Sender: TObject; AColor: TColor);
    procedure BinAllocationColourSelectColor(Sender: TObject; AColor: TColor);
    procedure SNAllocationColourSelectColor(Sender: TObject; AColor: TColor);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure edtPQADEtailsCUSTFLD1Change(Sender: TObject);
    procedure rgUOMToBeUsedInManufactureDefaultClick(Sender: TObject);
    procedure OnchooseQtyOption(Sender: TObject);
    procedure chkEnablePackWeightField2Click(Sender: TObject);
    procedure cbxProductReorderRoundValueChange(Sender: TObject);
    procedure dsPrefsStateChange(Sender: TObject);
    procedure MyConnectionBeforeConnect(Sender: TObject);
    procedure qryPartsClassPreferencesAfterPost(DataSet: TDataSet);
    procedure BatchAllocationGradIntensityChange(Sender: TObject);
    procedure BinAllocationGradIntensityChange(Sender: TObject);
    procedure SNAllocationGradIntensityChange(Sender: TObject);
    procedure cboPURTaxCodeChange(Sender: TObject);
    procedure cboTaxCodeChange(Sender: TObject);

  private
    fFormShown      : Boolean;
    fRunOnce        : Boolean;
    fPreferencesForm: TForm;
    Loading: boolean;
    procedure SetWholesalePercentage;
    procedure SetMinLinePriceAboveCost;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure checkPartCalcfield;
    //procedure GradIntensityChange(GradIntensity: TAdvTrackBar;ColorSelector: TAdvOfficeColorSelector);
    procedure SetcolorComp(TrackBar: TAdvTrackBar;      colorSelector: TAdvOfficeColorSelector; colorField,GradientField: String);
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;


implementation

uses
  DNMLib, {tcMessaging,} SelectionDialog, CommonLib, AppEnvironment, dmMainGUI , GraphUtil,
  UserLockObj, DbSharedObjectsObj, CommonDbLib, tcDataUtils, tcConst,
  PreferancesLib, ColourLib;

{$R *.dfm}

{ TInventoryPrefsGUI }

procedure TInventoryPrefsGUI.qryPartsClassPreferencesAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  PreferancesLib.DoPrefAuditTrail;
end;

procedure TInventoryPrefsGUI.SetcolorComp(TrackBar:TAdvTrackBar;colorSelector :TAdvOfficeColorSelector; colorField,GradientField:String);
begin
(*  colorSelector.SelectedColor  := TColor(dsPrefs.DataSet.FieldByName(colorField).AsInteger);
  TrackBar.Position            := dsPrefs.DataSet.FieldByName(GradientField).AsInteger;
  TrackBar.Color               := colorSelector.SelectedColor;
  TrackBar.ColorTo             := ColorAdjustLuma(TrackBar.Color,TrackBar.Position, False);*)
  ColourLib.SetcolorComp(TrackBar, colorSelector, dsPrefs.DataSet, colorField , GradientField);
end;



procedure TInventoryPrefsGUI.chkEnableAttributesClick(Sender: TObject);
begin
(*  edtFirstAttribute.Enabled := chkEnableAttributes.Checked;
  edtSecondAttribute.Enabled := chkEnableAttributes.Checked;*)
  edtNoOfAttribstodisplay.Enabled := chkEnableAttributes.Checked;
end;

procedure TInventoryPrefsGUI.chkEnablePackWeightField2Click(Sender: TObject);
begin
  inherited;
  if chkEnablePackWeightField2.Checked then
    if chkEnablePackWeightField1.Checked =False then  begin
      chkEnablePackWeightField1.Checked := True;
      EditDB(dsPrefs.dataset);
      dsPrefs.DataSet.FieldByName('EnablePackWeightField1').asBoolean := True;
      PostDB(dsPrefs.dataset);
    end;

end;

procedure TInventoryPrefsGUI.OnchooseQtyOption(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkPackWeightQtyField2 then chkPackWeightQtyField1.Checked := not(chkPackWeightQtyField2.Checked);
  if screen.ActiveControl = chkPackWeightQtyField1 then chkPackWeightQtyField2.Checked := not(chkPackWeightQtyField1.Checked);

  if chkPackWeightQtyField1.Checked  then chkEnablePackWeightField1.Checked := true;
  if chkPackWeightQtyField2.Checked  then chkEnablePackWeightField2.Checked := true;

  EditDB(dsPrefs.dataset);
  if dsPrefs.DataSet.FieldByName(chkEnablePackWeightField2.DataField).asBoolean <>  chkEnablePackWeightField2.Checked then dsPrefs.DataSet.FieldByName(chkEnablePackWeightField2.DataField).asBoolean := chkEnablePackWeightField2.Checked;
  if dsPrefs.DataSet.FieldByName(chkEnablePackWeightField1.DataField).asBoolean <> chkEnablePackWeightField1.Checked then dsPrefs.DataSet.FieldByName(chkEnablePackWeightField1.DataField).asBoolean := chkEnablePackWeightField1.Checked;
  postDB(dsPrefs.DataSet);

end;

procedure TInventoryPrefsGUI.chkPartCalcfield1Exit(Sender: TObject); begin  checkPartCalcfield;end;
procedure TInventoryPrefsGUI.chkPartCalcfield2Exit(Sender: TObject);begin  checkPartCalcfield; end;
procedure TInventoryPrefsGUI.chkPartCalcfield3Exit(Sender: TObject);begin  checkPartCalcfield; end;
procedure TInventoryPrefsGUI.chkPartCalcfield4Exit(Sender: TObject);begin  checkPartCalcfield;end;
procedure TInventoryPrefsGUI.chkPartCalcfield5Exit(Sender: TObject);begin  checkPartCalcfield; end;


procedure TInventoryPrefsGUI.cboPURTaxCodeChange(Sender: TObject);
begin
  inherited;
  if cboPURTaxCode.focused then
    Appenv.Companyprefs.DefaultPurchaseTaxCode := cboPURTaxCode.text;
end;

procedure TInventoryPrefsGUI.cboTaxCodeChange(Sender: TObject);
begin
  inherited;
  if cboTaxCode.focused then
    Appenv.Companyprefs.DefaultSalesTaxCode := cboTaxCode.text;
end;

procedure TInventoryPrefsGUI.cbxProductReorderRoundValueChange(Sender: TObject);
begin
  if Loading then Exit;
  dsPrefs.FieldByName('ProductReorderRoundValue').AsInteger := StrToInt(cbxProductReorderRoundValue.Items[cbxProductReorderRoundValue.ItemIndex]);
end;

procedure TInventoryPrefsGUI.checkPartCalcfield;
begin
    if chkPartCalcfield5.Checked and not(chkPartCalcfield4.Checked) then chkPartCalcfield4.Checked := True;
    if chkPartCalcfield4.Checked and not(chkPartCalcfield3.Checked) then chkPartCalcfield3.Checked := True;
    if chkPartCalcfield3.Checked and not(chkPartCalcfield2.Checked) then chkPartCalcfield2.Checked := True;
    if chkPartCalcfield2.Checked and not(chkPartCalcfield1.Checked) then chkPartCalcfield1.Checked := True;

    if (chkPartCalcfield1.Checked) and (edtPartCalcField1.Text = '') then begin editDB(dsPrefs.DataSet) ; dsPrefs.DataSet.Fieldbyname(edtPartCalcField1.datafield).asString := 'Field1';end;
    if (chkPartCalcfield2.Checked) and (edtPartCalcField2.Text = '') then begin editDB(dsPrefs.DataSet) ; dsPrefs.DataSet.Fieldbyname(edtPartCalcField2.datafield).asString := 'Field2';end;
    if (chkPartCalcfield3.Checked) and (edtPartCalcField3.Text = '') then begin editDB(dsPrefs.DataSet) ; dsPrefs.DataSet.Fieldbyname(edtPartCalcField3.datafield).asString := 'Field3';end;
    if (chkPartCalcfield4.Checked) and (edtPartCalcField4.Text = '') then begin editDB(dsPrefs.DataSet) ; dsPrefs.DataSet.Fieldbyname(edtPartCalcField4.datafield).asString := 'Field4';end;
    if (chkPartCalcfield5.Checked) and (edtPartCalcField5.Text = '') then begin editDB(dsPrefs.DataSet) ; dsPrefs.DataSet.Fieldbyname(edtPartCalcField5.datafield).asString := 'Field5';end;

end;
procedure TInventoryPrefsGUI.SetWholesalePercentage;
begin
  edtWholesalePercentage.Text := FloatToStrF(dsPrefs.FieldByName('WholesalePercentag').AsFloat * 100,
                                             ffFixed, 7, 2) + ' %';
end;



procedure TInventoryPrefsGUI.edtPQADEtailsCUSTFLD1Change(Sender: TObject);
begin
  inherited;
  //lblUseCustFld1ForSaleLineBatchAllocation.Caption :=
  chkUseCustFld1ForSaleLineBatchAllocation.Caption :=
    'Use [' + edtPQADEtailsCUSTFLD1.Text + '] For Sales Lines Batch Allocation';
end;

procedure TInventoryPrefsGUI.SetMinLinePriceAboveCost;
begin
  edtMinAboveCost.Text := FloatToStrF(dsPrefs.FieldByName('MinAboveCost').AsFloat * 100,
                                      ffFixed, 7, 2) + ' %';
end;

procedure TInventoryPrefsGUI.edtWholesalePercentageExit(Sender: TObject);
var
  TempPercent: Double;
begin
  inherited;
  edtWholesalePercentage.Text := FloatToStrF(StrValue(edtWholesalePercentage.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtWholesalePercentage.Text) / 100;
  dsPrefs.DataSet.Edit;
  dsPrefs.FieldByName('WholesalePercentag').AsFloat := TempPercent;
  edtWholesalePercentage.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';
end;

procedure TInventoryPrefsGUI.grdDefaultClassExit(Sender: TObject);
begin
  if qryPartsClassPreferences.Active then begin
    qryPartsClassPreferences.Edit;
    qryPartsClassPreferences.Post;
    qryPartsClassPreferences.Edit;
  end;
end;

procedure TInventoryPrefsGUI.MyConnectionBeforeConnect(Sender: TObject);
begin
  inherited;
//
end;

procedure TInventoryPrefsGUI.edtMinAboveCostExit(Sender: TObject);
var
  TempPercent: Double;
begin
  inherited;
  edtMinAboveCost.Text := FloatToStrF(StrValue(edtMinAboveCost.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtMinAboveCost.Text) / 100;
  dsPrefs.DataSet.Edit;
  dsPrefs.FieldByName('MinAboveCost').AsFloat := TempPercent;
  edtMinAboveCost.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';
end;

procedure TInventoryPrefsGUI.rgStockCostSystemChange(Sender: TObject);
var
  UserCount: integer;

  function GetCurrentUserCount: Integer;
  var
    s: string;
  begin
    result:= -1;
    if AppEnv.UtilsClient.GetDatabaseUserList(s, AppEnv.AppDb.Database,AppEnv.AppDb.UserName,true) then begin
      dtmMainGUI.dlgCurrentUsers.Items.CommaText:= s;
      Result := dtmMainGUI.dlgCurrentUsers.Items.Count;
    end;
  end;

begin
  inherited;

  if (not fRunOnce) and fFormShown and (dsPrefs.DataSet.State in [dsEdit, dsInsert]) then begin
    UserCount:= GetCurrentUserCount;
    if UserCount > 1 then begin
      if not VarIsNull(dsPrefs.DataSet.fieldbyname('StockCostSystem').oldvalue) then begin
        rgStockCostSystem.OnChange:= nil;
        try
          dsPrefs.DataSet.fieldbyname('StockCostSystem').AsInteger:=
            dsPrefs.DataSet.fieldbyname('StockCostSystem').oldvalue;
        finally
          rgStockCostSystem.OnChange:= rgStockCostSystemChange;
        end;
      end;
      dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Stock Cost System Changed';
      dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system';
      dtmMainGUI.dlgCurrentUsers.Execute;
    end
    else if UserCount < 0 then begin
      MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TInventoryPrefsGUI.rgUOMToBeUsedInManufactureDefaultClick(
  Sender: TObject);
begin
  inherited;
  if Loading then Exit;

  case rgUOMToBeUsedInManufactureDefault.ItemIndex of
    0: dsPrefs.FieldByName('UOMToBeUsedInManufactureDefault').AsString := 'P';
    1: dsPrefs.FieldByName('UOMToBeUsedInManufactureDefault').AsString := 'S';
  end;
end;

procedure TInventoryPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Loading := false;
(*  lblProductcomboWidthHint.catpion := 'Width of the Columns will not reduce less than the Length of the Label Associated with the Field.'+NL+
                                      'Reduce the Label Name in the ''Product List Headings'' Section(just above) as well as the Field Length.'*)
  fFormShown := False;
  fRunOnce := False;
  fPreferencesForm := nil;
  cbTaxCodeQry.Params.ParamByName('xRegionID').asInteger:= AppEnv.RegionalOptions.ID;
  lblProductName.caption        := AppEnv.DefaultClass.PartColumn;
  lblProductfirstcolumn.caption := AppEnv.DefaultClass.FirstColumn;
  lblProductSecondcolumn.caption:= AppEnv.DefaultClass.SecondColumn;
  lblThirdColumn.caption        := AppEnv.DefaultClass.ThirdColumn;

  chkUseCustFld1ForSaleLineBatchAllocation.Caption :=
    'Use [' + AppEnv.CompanyPrefs.PQADEtailsCUSTFLD1 + '] For Sales Lines Batch Allocation';
end;

procedure TInventoryPrefsGUI.QtyshippedColorSelectorSelectColor(Sender: TObject;AColor: TColor);
begin
  inherited;
  GradIntensityChange(QtyShippedGradIntensity ,QtyShippedColorSelector );
end;

procedure TInventoryPrefsGUI.QtySoldColorSelectorSelectColor(Sender: TObject;
  AColor: TColor);
begin
  inherited;
  GradIntensityChange(QtySoldGradIntensity ,QtysoldColorSelector );
end;
(*procedure TInventoryPrefsGUI.GradIntensityChange(GradIntensity: TAdvTrackBar;ColorSelector: TAdvOfficeColorSelector);
begin
        TAdvTrackBar(GradIntensity).Color := TAdvOfficeColorSelector(ColorSelector).SelectedColor;
        TAdvTrackBar(GradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(GradIntensity).Color,TAdvTrackBar(GradIntensity).Position, False);
end;*)

procedure TInventoryPrefsGUI.btnChangePricesClick(Sender: TObject);
var
  frm: TForm;
  btnOK: TDNMSpeedButton;
begin
  inherited;

  if dsPrefs.DataSet.State <> dsBrowse then begin
    if CommonLib.MessageDlgXP_Vista('Any Preference changes you made will be Saved Now',
                  mtConfirmation, [mbOK, mbCancel], 0) = mrOK then begin

        if Assigned(fPreferencesForm) then begin
          btnOK := TDNMSpeedButton(fPreferencesForm.FindComponent('btnOK'));
          if Assigned(btnOK) then  btnOK.Click;
          Application.ProcessMessages;
        end;

        frm := TForm(GetComponentByClassName('TPriceUpdateGUI'));
        if Assigned(frm) then begin
            SendMessage(frm.Handle, TX_PerformStartup, 0, 0);
            frm.FormStyle := fsMDIChild;
            frm.BringToFront;
        end;
    end;
  end;
end;

procedure TInventoryPrefsGUI.btnDeleteClick(Sender: TObject);
begin
  DeleteRecord(qryPartsClassPreferences);
end;

procedure TInventoryPrefsGUI.chkShowMeasurementAttributesClick(Sender: TObject);
begin
  inherited;
  lblAttrib1caption.enabled := chkShowMeasurementAttributes.checked;
  lblAttrib2caption.enabled := chkShowMeasurementAttributes.checked;
  edtProductAttrib1Name.enabled := chkShowMeasurementAttributes.checked;
  edtProductAttrib2Name.enabled := chkShowMeasurementAttributes.checked;
end;

procedure TInventoryPrefsGUI.DNMSpeedButton1Click(Sender: TObject);
var
  Userlock :TUserlock;
  script :TERPScript;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will update all existing stock transfers with the new account selected - ' + quotedstr(dsPrefs.fieldbyname('DefaultStockTransferAccount').asString)+'.'+ NL + NL +
                                  'Do you want to continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Userlock := TUserlock.create(Self);
    try
      if not Userlock.Lock('tblstocktransferentry' ,0) then begin
        CommonLib.MessageDlgXP_Vista(replacestr(ReplaceStr(Userlock.LockMessage, 'this record' , 'Stock Transfers') , 'Unable to update data.' , 'Unable to update Stock Transfers.'), mtWarning, [mbok] , 0);
        Exit;
      end;
      try
        Processingcursor(true);
        try
          script := DbsharedObj.getScript(commondblib.getsharedmydacconnection);
          try
            Script.SQL.clear;
            Script.SQL.add('update tblstocktransferentry '+
                            ' Set AccountId =' + inttostr(AccountIDForName(dsPrefs.fieldbyname('DefaultStockTransferAccount').asString))+' , '+
                            ' Accountname =' +Quotedstr(dsPrefs.fieldbyname('DefaultStockTransferAccount').asString)+' '+
                            ' where AccountName <> '+ Quotedstr(dsPrefs.fieldbyname('DefaultStockTransferAccount').asString)+';');
            Script.SQL.add('update tblstockmovement      '+
                            ' Set AccountId =' + inttostr(AccountIDForName(dsPrefs.fieldbyname('DefaultStockTransferAccount').asString))+' '+
                            ' where StockmovementEntryType = "StockTransferEntry" and  AccountId <>' + inttostr(AccountIDForName(dsPrefs.fieldbyname('DefaultStockTransferAccount').asString))+';');
            Script.execute;
            MessageDlgXP_Vista('All Stock Transfers are updated.'+NL+NL+'Please make sure you run the ''closing Date Refresh'' for the reports to reflect the changes.', mtInformation, [mbOK], 0);
          finally
            DBsharedobj.releaseobj(script);
          end;
        finally
          Processingcursor(False);
        end;
      finally
        USerlock.UnlockAllCurrentInstance;
      end;
    finally
      FreeandNil(Userlock);
    end;
  end;
end;

procedure TInventoryPrefsGUI.dsPrefsStateChange(Sender: TObject);
begin
  inherited;
//
end;
procedure TInventoryPrefsGUI.SNAllocationColourSelectColor    (Sender: TObject;  AColor: TColor);begin  inherited;  SNAllocationGradIntensityChange   (Sender);end;
procedure TInventoryPrefsGUI.BinAllocationColourSelectColor   (Sender: TObject;  AColor: TColor);begin  inherited;  BinAllocationGradIntensityChange  (Sender);end;
procedure TInventoryPrefsGUI.BatchAllocationColourSelectColor (Sender: TObject;  AColor: TColor);begin  inherited;  BatchAllocationGradIntensityChange(Sender);end;
procedure TInventoryPrefsGUI.SNAllocationGradIntensityChange    (Sender: TObject);begin  inherited;  GradIntensityChange(SNAllocationGradIntensity    ,SNAllocationColour   );end;
procedure TInventoryPrefsGUI.BinAllocationGradIntensityChange   (Sender: TObject);begin  inherited;  GradIntensityChange(BinAllocationGradIntensity   ,BinAllocationColour  );end;
procedure TInventoryPrefsGUI.BatchAllocationGradIntensityChange (Sender: TObject);begin  inherited;  GradIntensityChange(BatchAllocationGradIntensity ,BatchAllocationColour);end;
procedure TInventoryPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
  lblhint1.caption := 'Job Quantity will Order Based on'+NL+
                      'the Quantity Required for the Job';
  lblhint2.caption := 'All Others will Order Based on What is Required to Reach the Product''s Preferred Level Quantity as Set in the Product Card';
  lblhint3.caption := 'Unprocessed Sales Orders'+NL+
                      'will NOT affect "Instock Quantity",'+NL+
                      'will affect the "Available Quantity"';
  chkAutoLocateLastRecord.visible := Devmode;
end;

procedure TInventoryPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  Loading := true;
  try
    fPreferencesForm := TForm(FindControl(Msg.WParam));
    SetWholesalePercentage;
    SetMinLinePriceAboveCost;
    fFormShown := True;
    lblAttrib2caption.enabled := Appenv.CompanyPrefs.ShowMeasurementAttributes;
    lblAttrib1caption.enabled := Appenv.CompanyPrefs.ShowMeasurementAttributes;
    edtProductAttrib1Name.enabled := Appenv.CompanyPrefs.ShowMeasurementAttributes;
    edtProductAttrib2Name.enabled := Appenv.CompanyPrefs.ShowMeasurementAttributes;

    SetcolorComp(QtySoldGradIntensity         ,QtysoldColorSelector   ,'QtySoldColour'          ,'QtysoldGradIntensity');
    SetcolorComp(QtyShippedGradIntensity      ,QtyShippedColorSelector,'QtyShippedColour'       ,'QtyShippedGradIntensity');
    SetcolorComp(BatchAllocationGradIntensity ,BatchAllocationColour  ,'BatchAllocationColour'  ,'BatchAllocationGradIntensity');
    SetcolorComp(BinAllocationGradIntensity   ,BinAllocationColour    ,'BinAllocationColour'    ,'BinAllocationGradIntensity');
    SetcolorComp(SNAllocationGradIntensity    ,SNAllocationColour     ,'SNAllocationColour'     ,'SNAllocationGradIntensity');

          if dsPrefs.FieldByName('UOMToBeUsedInManufactureDefault').AsString = 'P' then rgUOMToBeUsedInManufactureDefault.ItemIndex := 0
    else  if dsPrefs.FieldByName('UOMToBeUsedInManufactureDefault').AsString = 'S' then rgUOMToBeUsedInManufactureDefault.ItemIndex := 1
    else rgUOMToBeUsedInManufactureDefault.ItemIndex := -1;

    chkPackWeightQtyField1.Checked := dsPrefs.FieldByName('PackWeightQtyField').asInteger = 1;
    chkPackWeightQtyField2.Checked := dsPrefs.FieldByName('PackWeightQtyField').asInteger = 2;


    (*TAdvOfficeColorSelector(QtysoldColorSelector).SelectedColor     := TColor(dsPrefs.DataSet.FieldByName('QtySoldColour').AsInteger);
    TAdvTrackBar(QtySoldGradIntensity).Position    := dsPrefs.DataSet.FieldByName('QtysoldGradIntensity').AsInteger;
    TAdvTrackBar(QtySoldGradIntensity).Color   := TAdvOfficeColorSelector(QtysoldColorSelector).SelectedColor;
    TAdvTrackBar(QtySoldGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(QtySoldGradIntensity).Color,TAdvTrackBar(QtySoldGradIntensity).Position, False);

    TAdvOfficeColorSelector(QtyShippedColorSelector).SelectedColor  := TColor(dsPrefs.DataSet.FieldByName('QtyShippedColour').AsInteger);
    TAdvTrackBar(QtyShippedGradIntensity).Position := dsPrefs.DataSet.FieldByName('QtyShippedGradIntensity').AsInteger;
    TAdvTrackBar(QtyShippedGradIntensity).Color   := TAdvOfficeColorSelector(QtyShippedColorSelector).SelectedColor;
    TAdvTrackBar(QtyShippedGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(QtyShippedGradIntensity).Color,TAdvTrackBar(QtyShippedGradIntensity).Position, False);

    TAdvOfficeColorSelector(BatchAllocationColour).SelectedColor  := TColor(dsPrefs.DataSet.FieldByName('BatchAllocationColour').AsInteger);
    TAdvTrackBar(BatchAllocationGradIntensity).Position := dsPrefs.DataSet.FieldByName('BatchAllocationGradIntensity').AsInteger;
    TAdvTrackBar(BatchAllocationGradIntensity).Color   := TAdvOfficeColorSelector(BatchAllocationColour).SelectedColor;
    TAdvTrackBar(BatchAllocationGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(BatchAllocationGradIntensity).Color,TAdvTrackBar(BatchAllocationGradIntensity).Position, False);

    TAdvOfficeColorSelector(BinAllocationColour).SelectedColor  := TColor(dsPrefs.DataSet.FieldByName('BinAllocationColour').AsInteger);
    TAdvTrackBar(BinAllocationGradIntensity).Position := dsPrefs.DataSet.FieldByName('BinAllocationGradIntensity').AsInteger;
    TAdvTrackBar(BinAllocationGradIntensity).Color   := TAdvOfficeColorSelector(BinAllocationColour).SelectedColor;
    TAdvTrackBar(BinAllocationGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(BinAllocationGradIntensity).Color,TAdvTrackBar(BinAllocationGradIntensity).Position, False);


    TAdvOfficeColorSelector(SNAllocationColour).SelectedColor  := TColor(dsPrefs.DataSet.FieldByName('SNAllocationColour').AsInteger);
    TAdvTrackBar(SNAllocationGradIntensity).Position := dsPrefs.DataSet.FieldByName('SNAllocationGradIntensity').AsInteger;
    TAdvTrackBar(SNAllocationGradIntensity).Color   := TAdvOfficeColorSelector(SNAllocationColour).SelectedColor;
    TAdvTrackBar(SNAllocationGradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(SNAllocationGradIntensity).Color,TAdvTrackBar(SNAllocationGradIntensity).Position, False);*)

    cbxProductReorderRoundValue.Items.Add('-100');
    cbxProductReorderRoundValue.Items.Add('-10');
    cbxProductReorderRoundValue.Items.Add('-5');
    cbxProductReorderRoundValue.Items.Add('-1');
    cbxProductReorderRoundValue.Items.Add('0');
    cbxProductReorderRoundValue.Items.Add('1');
    cbxProductReorderRoundValue.Items.Add('5');
    cbxProductReorderRoundValue.Items.Add('10');
    cbxProductReorderRoundValue.Items.Add('100');
    cbxProductReorderRoundValue.ItemIndex := cbxProductReorderRoundValue.Items.IndexOf(dsPrefs.FieldByName('ProductReorderRoundValue').AsString);
    if cbxProductReorderRoundValue.ItemIndex <0 then cbxProductReorderRoundValue.text := '0';
  finally
    Loading := false;
  end;
end;
procedure TInventoryPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TInventoryPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  editdB(dsPrefs.DataSet);

  dsPrefs.DataSet.FieldByName('QtySoldColour').AsInteger    := Integer(QtysoldColorSelector.SelectedColor);
  dsPrefs.DataSet.FieldByName('QtyShippedColour').AsInteger := Integer(QtyshippedColorSelector.SelectedColor);
  dsPrefs.DataSet.FieldByName('QtySoldGradIntensity').AsInteger    := QtySoldGradIntensity.Position;
  dsPrefs.DataSet.FieldByName('QtyShippedGradIntensity').AsInteger := QtyShippedGradIntensity.Position;

  dsPrefs.DataSet.FieldByName('BatchAllocationColour').AsInteger    := Integer(BatchAllocationColour.SelectedColor);
  dsPrefs.DataSet.FieldByName('BatchAllocationGradIntensity').AsInteger    := BatchAllocationGradIntensity.Position;

  dsPrefs.DataSet.FieldByName('BinAllocationColour').AsInteger    := Integer(BinAllocationColour.SelectedColor);
  dsPrefs.DataSet.FieldByName('BinAllocationGradIntensity').AsInteger    := BinAllocationGradIntensity.Position;

  dsPrefs.DataSet.FieldByName('SNAllocationColour').AsInteger    := Integer(SNAllocationColour.SelectedColor);
  dsPrefs.DataSet.FieldByName('SNAllocationGradIntensity').AsInteger    := SNAllocationGradIntensity.Position;

       if chkPackWeightQtyField1.Checked then  dsPrefs.FieldByName('PackWeightQtyField').asInteger := 1
  else if chkPackWeightQtyField2.Checked then  dsPrefs.FieldByName('PackWeightQtyField').asInteger := 2
  else if dsPrefs.FieldByName('PackWeightField1').asString <> '' then dsPrefs.FieldByName('PackWeightQtyField').asInteger := 1
  else if dsPrefs.FieldByName('PackWeightField2').asString <> '' then dsPrefs.FieldByName('PackWeightQtyField').asInteger := 2
  else dsPrefs.FieldByName('PackWeightQtyField').asInteger := 1;

  postDB(dsPrefs.DataSet);
  fFormShown := False;
end;
initialization
  RegisterClassOnce(TInventoryPrefsGUI);
finalization
  UnRegisterClass(TInventoryPrefsGUI);
end.
