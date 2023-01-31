unit frmFixedAsset;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts,
  DNMSpeedButton, BusObjBase, wwdblook, Mask, wwSpeedButton, wwDBNavigator,
  wwclearpanel, pngimage, Wwdotdot, Wwdbcomb, wwcheckbox, wwdbedit, Wwdbspin,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, ComCtrls, BusObjFixedAsset,
  BaseListingForm,
  DMComps, frmAttachments, ERPDbLookupCombo, HireHistoryForAsset;

type
  TfmFixedAsset = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    qryAsset: TERPQuery;
    qryAssetAssetID: TAutoIncField;
    qryAssetParentID: TIntegerField;
    qryAssetAssetCode: TWideStringField;
    qryAssetAssetName: TWideStringField;
    qryAssetPurchDate: TDateField;
    qryAssetPurchCost: TFloatField;
    qryAssetAssetType: TWideStringField;
    qryAssetLocationDescription: TWideStringField;
    qryAssetBrandName: TWideStringField;
    qryAssetManufacture: TWideStringField;
    qryAssetModel: TWideStringField;
    qryAssetSerial: TWideStringField;
    qryAssetNotes: TWideMemoField;
    qryAssetQty: TIntegerField;
    qryAssetStatus: TWideStringField;
    qryAssetEstimatedValue: TFloatField;
    qryAssetReplacementCost: TFloatField;
    qryAssetWarrantyType: TWideStringField;
    qryAssetWarrantyExpiresDate: TDateField;
    qryAssetInsuredBy: TWideStringField;
    qryAssetInsurancePolicy: TWideStringField;
    qryAssetInsuredUntil: TDateField;
    qryAssetBusinessUsePercent: TFloatField;
    qryAssetCUSTFLD1: TWideStringField;
    qryAssetCUSTFLD2: TWideStringField;
    qryAssetCUSTFLD3: TWideStringField;
    qryAssetCUSTFLD4: TWideStringField;
    qryAssetCUSTFLD5: TWideStringField;
    qryAssetCUSTFLD6: TWideStringField;
    qryAssetCUSTFLD7: TWideStringField;
    qryAssetCUSTFLD8: TWideStringField;
    qryAssetCUSTFLD9: TWideStringField;
    qryAssetCUSTFLD10: TWideStringField;
    qryAssetCUSTFLD11: TWideStringField;
    qryAssetCUSTFLD12: TWideStringField;
    qryAssetCUSTFLD13: TWideStringField;
    qryAssetCUSTFLD14: TWideStringField;
    qryAssetCUSTFLD15: TWideStringField;
    qryAssetDepreciationOption: TSmallintField;
    qryAssetLife: TFloatField;
    qryAssetSalvageType: TSmallintField;
    qryAssetSalvage: TFloatField;
    qryAssetSalvageFactor: TFloatField;
    qryAssetDisposal: TWideStringField;
    qryAssetDisposalDate: TDateTimeField;
    qryAssetDisposalBookValue: TFloatField;
    qryAssetDisposalAccumDeprec: TFloatField;
    qryAssetSalesPrice: TFloatField;
    qryAssetPriorAccumDeprec: TWideStringField;
    qryAssetPriorAccumDeprecDate: TWideStringField;
    qryAssetPriorAccumDeprecAmount: TFloatField;
    qryAssetColour: TWideStringField;
    qryAssetSize: TWideStringField;
    qryAssetShape: TWideStringField;
    qryAssetFixedAssetDepreciationAccountName: TWideStringField;
    qryAssetFixedAssetDepreciationAccountID: TIntegerField;
    qryAssetClearingAccountName: TWideStringField;
    qryAssetClearingAccountID: TIntegerField;
    qryAssetGlobalRef: TWideStringField;
    qryAssetActive: TWideStringField;
    qryAssetEditedFlag: TWideStringField;
    qryAssetPARTNAME: TWideStringField;
    qryAssetPARTSID: TIntegerField;
    qryAssetSupplierName: TWideStringField;
    qryAssetSupplierID: TIntegerField;
    qryAssetBARCODE: TWideStringField;
    qryAssetDepreciationOption2: TSmallintField;
    qryAssetLife2: TFloatField;
    qryAssetSalvageType2: TSmallintField;
    qryAssetSalvage2: TFloatField;
    qryAssetSalvageFactor2: TFloatField;
    qryAssetPriorAccumDeprec2: TWideStringField;
    qryAssetPriorAccumDeprecDate2: TWideStringField;
    qryAssetPriorAccumDeprecAmount2: TFloatField;
    qryAssetDisposalDate2: TDateTimeField;
    qryAssetDisposalBookValue2: TFloatField;
    qryAssetDisposalAccumDeprec2: TFloatField;
    qryAssetSalesPrice2: TFloatField;
    qryAssetClearingAccountName2: TWideStringField;
    qryAssetClearingAccountID2: TIntegerField;
    qryAssetFixedAssetDepreciationAccountName2: TWideStringField;
    qryAssetFixedAssetDepreciationAccountID2: TIntegerField;
    qryAssetBusinessUsePercent2: TFloatField;
    qryAssetFixedAssetCostAccountName: TWideStringField;
    qryAssetFixedAssetCostAccountID: TIntegerField;
    qryAssetFixedAssetCostAccountName2: TWideStringField;
    qryAssetFixedAssetCostAccountID2: TIntegerField;
    qryAssetFixedAssetDepreciationAssetAccountName: TWideStringField;
    qryAssetFixedAssetDepreciationAssetAccountID: TIntegerField;
    qryAssetFixedAssetDepreciationAssetAccountName2: TWideStringField;
    qryAssetFixedAssetDepreciationAssetAccountID2: TIntegerField;
    qryAssetCUSTDATE1: TDateTimeField;
    qryAssetCUSTDATE2: TDateTimeField;
    qryAssetCUSTDATE3: TDateTimeField;
    qryAssetTotalChildAsset: TFloatField;
    qryAssetAssetCondition: TWideStringField;
    qryAssetClassID: TIntegerField;
    qryAssetLastTestDate: TDateField;
    qryAssetNextTestDate: TDateField;
    qryAssetmsTimeStamp: TDateTimeField;
    qryAssetmsUpdateSiteCode: TWideStringField;
    qryAssetDepreciationStartDate: TDateField;
    DSAsset: TDataSource;
    qryfixedassettypes: TERPQuery;
    qryfixedassettypesAssetTypeID: TAutoIncField;
    qryfixedassettypesAssetTypeCode: TWideStringField;
    qryfixedassettypesAssetTypeName: TWideStringField;
    qryfixedassettypesNotes: TWideMemoField;
    qryfixedassettypesDepreciationOption: TSmallintField;
    qryfixedassettypesLife: TFloatField;
    qryfixedassettypesSalvageType: TSmallintField;
    qryfixedassettypesSalvage: TFloatField;
    qryfixedassettypesSalvageFactor: TFloatField;
    qryfixedassettypesActive: TWideStringField;
    ERPQuery1: TERPQuery;
    AutoIncField1: TAutoIncField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideMemoField1: TWideMemoField;
    SmallintField1: TSmallintField;
    FloatField1: TFloatField;
    SmallintField2: TSmallintField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    WideStringField3: TWideStringField;
    cboAccountQry: TERPQuery;
    cboClassQry: TERPQuery;
    cboClassQryClassName: TWideStringField;
    cboClassQryClassID: TAutoIncField;
    cboClassQryClassPercent: TFloatField;
    qryCustomFields: TERPQuery;
    qryCustomFieldsCFLabel1: TWideStringField;
    qryCustomFieldsCFCust1: TWideStringField;
    qryCustomFieldsCFEmpl1: TWideStringField;
    qryCustomFieldsCFSupp1: TWideStringField;
    qryCustomFieldsCFLabel2: TWideStringField;
    qryCustomFieldsCFCust2: TWideStringField;
    qryCustomFieldsCFEmpl2: TWideStringField;
    qryCustomFieldsCFSupp2: TWideStringField;
    qryCustomFieldsCFLabel3: TWideStringField;
    qryCustomFieldsCFCust3: TWideStringField;
    qryCustomFieldsCFEmpl3: TWideStringField;
    qryCustomFieldsCFSupp3: TWideStringField;
    qryCustomFieldsCFLabel4: TWideStringField;
    qryCustomFieldsCFCust4: TWideStringField;
    qryCustomFieldsCFEmpl4: TWideStringField;
    qryCustomFieldsCFSupp4: TWideStringField;
    qryCustomFieldsCFLabel5: TWideStringField;
    qryCustomFieldsCFCust5: TWideStringField;
    qryCustomFieldsCFEmpl5: TWideStringField;
    qryCustomFieldsCFSupp5: TWideStringField;
    qryCustomFieldsCFLabel6: TWideStringField;
    qryCustomFieldsCFCust6: TWideStringField;
    qryCustomFieldsCFEmpl6: TWideStringField;
    qryCustomFieldsCFSupp6: TWideStringField;
    qryCustomFieldsCFLabel7: TWideStringField;
    qryCustomFieldsCFCust7: TWideStringField;
    qryCustomFieldsCFEmpl7: TWideStringField;
    qryCustomFieldsCFSupp7: TWideStringField;
    qryCustomFieldsCFLabel8: TWideStringField;
    qryCustomFieldsCFCust8: TWideStringField;
    qryCustomFieldsCFEmpl8: TWideStringField;
    qryCustomFieldsCFSupp8: TWideStringField;
    qryCustomFieldsCFLabel9: TWideStringField;
    qryCustomFieldsCFCust9: TWideStringField;
    qryCustomFieldsCFEmpl9: TWideStringField;
    qryCustomFieldsCFSupp9: TWideStringField;
    qryCustomFieldsCFLabel10: TWideStringField;
    qryCustomFieldsCFCust10: TWideStringField;
    qryCustomFieldsCFEmpl10: TWideStringField;
    qryCustomFieldsCFSupp10: TWideStringField;
    qryCustomFieldsCFLabel11: TWideStringField;
    qryCustomFieldsCFCust11: TWideStringField;
    qryCustomFieldsCFEmpl11: TWideStringField;
    qryCustomFieldsCFSupp11: TWideStringField;
    qryCustomFieldsCFLabel12: TWideStringField;
    qryCustomFieldsCFCust12: TWideStringField;
    qryCustomFieldsCFEmpl12: TWideStringField;
    qryCustomFieldsCFSupp12: TWideStringField;
    qryCustomFieldsCFLabel13: TWideStringField;
    qryCustomFieldsCFCust13: TWideStringField;
    qryCustomFieldsCFEmpl13: TWideStringField;
    qryCustomFieldsCFSupp13: TWideStringField;
    qryCustomFieldsCFLabel14: TWideStringField;
    qryCustomFieldsCFCust14: TWideStringField;
    qryCustomFieldsCFEmpl14: TWideStringField;
    qryCustomFieldsCFSupp14: TWideStringField;
    qryCustomFieldsCFLabel15: TWideStringField;
    qryCustomFieldsCFCust15: TWideStringField;
    qryCustomFieldsCFEmpl15: TWideStringField;
    qryCustomFieldsCFSupp15: TWideStringField;
    qryCustomFieldsEditedFlag: TWideStringField;
    qryCustomFieldsCFOthr1: TWideStringField;
    qryCustomFieldsCFOthr2: TWideStringField;
    qryCustomFieldsCFOthr3: TWideStringField;
    qryCustomFieldsCFOthr4: TWideStringField;
    qryCustomFieldsCFOthr5: TWideStringField;
    qryCustomFieldsCFOthr6: TWideStringField;
    qryCustomFieldsCFOthr7: TWideStringField;
    qryCustomFieldsCFOthr8: TWideStringField;
    qryCustomFieldsCFOthr9: TWideStringField;
    qryCustomFieldsCFOthr10: TWideStringField;
    qryCustomFieldsCFOthr11: TWideStringField;
    qryCustomFieldsCFOthr12: TWideStringField;
    qryCustomFieldsCFOthr13: TWideStringField;
    qryCustomFieldsCFOthr14: TWideStringField;
    qryCustomFieldsCFOthr15: TWideStringField;
    qryCustomFieldsCFLabel16: TWideStringField;
    qryCustomFieldsCFLabel17: TWideStringField;
    qryCustomFieldsCFLabel18: TWideStringField;
    qryCustomFieldsGlobalRef: TWideStringField;
    qryCustomFieldsID: TAutoIncField;
    qryCustomFieldsCFAssets1: TWideStringField;
    qryCustomFieldsCFAssets2: TWideStringField;
    qryCustomFieldsCFAssets3: TWideStringField;
    qryCustomFieldsCFAssets4: TWideStringField;
    qryCustomFieldsCFAssets5: TWideStringField;
    qryCustomFieldsCFAssets6: TWideStringField;
    qryCustomFieldsCFAssets7: TWideStringField;
    qryCustomFieldsCFAssets8: TWideStringField;
    qryCustomFieldsCFAssets9: TWideStringField;
    qryCustomFieldsCFAssets10: TWideStringField;
    qryCustomFieldsCFAssets11: TWideStringField;
    qryCustomFieldsCFAssets12: TWideStringField;
    qryCustomFieldsCFAssets13: TWideStringField;
    qryCustomFieldsCFAssets14: TWideStringField;
    qryCustomFieldsCFAssets15: TWideStringField;
    qryCustomFieldsCFAssets16: TWideStringField;
    qryCustomFieldsCFAssets17: TWideStringField;
    qryCustomFieldsCFAssets18: TWideStringField;
    qryParts: TERPQuery;
    qryPartsPARTSID: TIntegerField;
    qryPartsPARTNAME: TWideStringField;
    cboClientLookup: TERPQuery;
    qryPictures: TERPQuery;
    qryPicturesAssetPictureId: TIntegerField;
    qryPicturesGlobalref: TWideStringField;
    qryPicturesAssetId: TIntegerField;
    qryPicturesImage: TBlobField;
    qryPicturesmsTimeStamp: TDateTimeField;
    qryPicturesmsUpdateSiteCode: TWideStringField;
    qryPicturesImagetype: TWideStringField;
    dsPicture: TDataSource;
    qryAssetClass: TERPQuery;
    StringField1: TWideStringField;
    AutoIncField2: TAutoIncField;
    FloatField4: TFloatField;
    qryDepreciationCalcs1: TERPQuery;
    qryDepreciationCalcs1AssetDepreciationID: TAutoIncField;
    qryDepreciationCalcs1AssetID: TIntegerField;
    qryDepreciationCalcs1Year: TWideStringField;
    qryDepreciationCalcs1Month: TWideStringField;
    qryDepreciationCalcs1MonthNo: TIntegerField;
    qryDepreciationCalcs1Depreciation: TFloatField;
    qryDepreciationCalcs1TotalDepreciation: TFloatField;
    qryDepreciationCalcs1BookValue: TFloatField;
    qryDepreciationCalcs1Date: TDateField;
    qryDepreciationCalcs2: TERPQuery;
    qryDepreciationCalcs2AssetDepreciationID: TAutoIncField;
    qryDepreciationCalcs2AssetID: TIntegerField;
    qryDepreciationCalcs2Year: TWideStringField;
    qryDepreciationCalcs2Month: TWideStringField;
    qryDepreciationCalcs2MonthNo: TIntegerField;
    qryDepreciationCalcs2Depreciation: TFloatField;
    qryDepreciationCalcs2TotalDepreciation: TFloatField;
    qryDepreciationCalcs2BookValue: TFloatField;
    qryDepreciationCalcs2Date: TDateField;
    DNMPanel4: TDNMPanel;
    Label7: TLabel;
    AssetCode: TDBEdit;
    Label8: TLabel;
    AssetName: TDBEdit;
    Label6: TLabel;
    cboAssetType: TwwDBLookupCombo;
    PageControl1: TPageControl;
    AssetInfo: TTabSheet;
    DNMPanel6: TDNMPanel;
    Bevel17: TBevel;
    Bevel16: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    Label19: TLabel;
    Label45: TLabel;
    Label227: TLabel;
    Label85: TLabel;
    Label43: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    LblClass: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label53: TLabel;
    lblDayMatch: TLabel;
    cboPurchDate: TwwDBDateTimePicker;
    PurchCost: TDBEdit;
    Serial: TDBEdit;
    LocationDescription: TDBEdit;
    cboClient: TwwDBLookupCombo;
    txtBarcode: TDBEdit;
    cboProduct: TwwDBLookupCombo;
    btnProductBarcode: TDNMSpeedButton;
    btnProductSerial: TDNMSpeedButton;
    wwDBLookupParentAssetID: TwwDBLookupCombo;
    TotalChildAssets: TDBEdit;
    grdFAPercentage: TwwDBGrid;
    grdFAPercentageIButton: TwwIButton;
    cboClass: TwwDBLookupCombo;
    cboAssetClass: TwwDBLookupCombo;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    cboDepreciationStartDate: TwwDBDateTimePicker;
    tabAdditionalInfo: TTabSheet;
    DNMPanel5: TDNMPanel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label17: TLabel;
    Label18: TLabel;
    Label27: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Bevel6: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Bevel23: TBevel;
    Label22: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Shape: TDBEdit;
    InsurancePolicy: TDBEdit;
    InsuredBy: TDBEdit;
    cboInsuredUntil: TwwDBDateTimePicker;
    Colour: TDBEdit;
    Size: TDBEdit;
    WarrantyType: TDBEdit;
    cboWarrantyExpiresDate: TwwDBDateTimePicker;
    Status: TDBEdit;
    Qty: TwwDBSpinEdit;
    EstimatedValue: TDBEdit;
    ReplacementCost: TDBEdit;
    wwDBChildAssetGrid: TwwDBGrid;
    Manufacture: TDBEdit;
    BrandName: TDBEdit;
    Model: TDBEdit;
    Condition: TDBEdit;
    Depreciation1: TTabSheet;
    DNMPanel7: TDNMPanel;
    Bevel12: TBevel;
    Bevel3: TBevel;
    Bevel9: TBevel;
    Label26: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label11: TLabel;
    lblSalvage: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblFixedAssetsClearingAccount: TLabel;
    lblFixedAssetsAccount: TLabel;
    lblPercentInfo1: TLabel;
    grdDepreciationCalcs1: TwwDBGrid;
    btnCalculate: TDNMSpeedButton;
    BusinessUsePercent: TDBEdit;
    PriorAccumDeprec: TwwCheckBox;
    PriorAccumDeprecAmount: TDBEdit;
    PriorAccumDeprecDate: TDBEdit;
    SalvageFactor: TDBEdit;
    Salvage: TDBEdit;
    Life: TDBEdit;
    cboDepreciationOption: TwwDBComboBox;
    cboSalvageType: TwwDBComboBox;
    cboFixedAssetsClearingAccount: TwwDBLookupCombo;
    cboFixedAssetsAccount: TwwDBLookupCombo;
    Depreciation2: TTabSheet;
    DNMPanel8: TDNMPanel;
    Bevel20: TBevel;
    Bevel18: TBevel;
    Label48: TLabel;
    Label52: TLabel;
    lblSalvage2: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Bevel13: TBevel;
    lblFixedAssetAccountName2: TLabel;
    lblClearingAccountName2: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label66: TLabel;
    lblPercentInfo2: TLabel;
    grdDepreciationCalcs2: TwwDBGrid;
    btnCalculate2: TDNMSpeedButton;
    BusinessUsePercent2: TDBEdit;
    SalvageFactor2: TDBEdit;
    Salvage2: TDBEdit;
    Life2: TDBEdit;
    cboDepreciationOption2: TwwDBComboBox;
    cboSalvageType2: TwwDBComboBox;
    cboFixedAssetAccountName2: TwwDBLookupCombo;
    cboClearingAccountName2: TwwDBLookupCombo;
    PriorAccumDeprec2: TwwCheckBox;
    PriorAccumDeprecDate2: TDBEdit;
    PriorAccumDeprecAmount2: TDBEdit;
    Disposal: TTabSheet;
    DNMPanel9: TDNMPanel;
    Bevel8: TBevel;
    Bevel7: TBevel;
    Label28: TLabel;
    Label29: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label30: TLabel;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label65: TLabel;
    SalesPrice: TDBEdit;
    cboDisposalDate: TwwDBDateTimePicker;
    DisposalAccumDeprec: TDBEdit;
    DisposalBookValue: TDBEdit;
    DisposalCalculate: TDNMSpeedButton;
    DisposalofAsset: TwwCheckBox;
    SalesPrice2: TDBEdit;
    cboDisposalDate2: TwwDBDateTimePicker;
    DisposalAccumDeprec2: TDBEdit;
    DisposalBookValue2: TDBEdit;
    DisposalCalculate2: TDNMSpeedButton;
    Custom_Fields: TTabSheet;
    pnlCustFields: TDNMPanel;
    Bevel14: TBevel;
    Box181: TBevel;
    Label179: TLabel;
    CUSTLBL1: TLabel;
    CUSTLBL2: TLabel;
    CUSTLBL3: TLabel;
    CUSTLBL4: TLabel;
    CUSTLBL5: TLabel;
    CUSTLBL6: TLabel;
    CUSTLBL7: TLabel;
    CUSTLBL8: TLabel;
    CUSTLBL9: TLabel;
    CUSTLBL10: TLabel;
    CUSTLBL11: TLabel;
    CUSTLBL12: TLabel;
    CUSTLBL13: TLabel;
    CUSTLBL14: TLabel;
    CUSTLBL15: TLabel;
    CUSTLBL16: TLabel;
    CUSTLBL17: TLabel;
    CUSTLBL18: TLabel;
    cmdCustomLabelsOld: TDNMSpeedButton;
    CUSTFLD1: TwwDBComboBox;
    CUSTFLD2: TwwDBComboBox;
    CUSTFLD3: TwwDBComboBox;
    CUSTFLD4: TwwDBComboBox;
    CUSTFLD5: TwwDBComboBox;
    CUSTFLD10: TwwDBComboBox;
    CUSTFLD9: TwwDBComboBox;
    CUSTFLD8: TwwDBComboBox;
    CUSTFLD7: TwwDBComboBox;
    CUSTFLD6: TwwDBComboBox;
    CUSTFLD11: TwwDBComboBox;
    CUSTFLD12: TwwDBComboBox;
    CUSTFLD13: TwwDBComboBox;
    CUSTFLD14: TwwDBComboBox;
    CUSTFLD15: TwwDBComboBox;
    CUSTFLD16: TwwDBDateTimePicker;
    CUSTFLD17: TwwDBDateTimePicker;
    CUSTFLD18: TwwDBDateTimePicker;
    Notes: TTabSheet;
    DNMPanel10: TDNMPanel;
    Bevel11: TBevel;
    Label39: TLabel;
    MemoNotes: TDBMemo;
    btnAddDateTime: TDNMSpeedButton;
    tabPictures: TTabSheet;
    pnlImage: TDNMPanel;
    ImgImages: TImage;
    pnlPicHeader: TDNMPanel;
    btnAddPic: TDNMSpeedButton;
    btnStretch: TDNMSpeedButton;
    navPartPic: TwwDBNavigator;
    navPartPicFirst: TwwNavButton;
    navPartPicPriorPage: TwwNavButton;
    navPartPicPrior: TwwNavButton;
    navPartPicNext: TwwNavButton;
    navPartPicLast: TwwNavButton;
    navPartPicDelete: TwwNavButton;
    pnlPicturetype: TDNMPanel;
    DBText1: TDBText;
    Label12: TLabel;
    tabAttachments: TTabSheet;
    pnlAttachments: TPanel;
    tabHistory: TTabSheet;
    pnlHistory: TDNMPanel;
    grpHistory: TRadioGroup;
    qryFAPercentages: TERPQuery;
    qryFAPercentagesClassName: TWideStringField;
    qryFAPercentagesCost: TFloatField;
    qryFAPercentagesDepreciation: TFloatField;
    qryFAPercentagesDescription: TWideStringField;
    qryFAPercentagesActive: TWideStringField;
    qryFAPercentagesClassID: TIntegerField;
    qryFAPercentagesAssetPercentagesID: TIntegerField;
    qryFAPercentagesAssetID: TIntegerField;
    dsFAPercentages: TDataSource;
    lblFixedAssetDepreciationAssetAccountName2: TLabel;
    cboFixedAssetDepreciationAssetAccountName2: TwwDBLookupCombo;
    lblFixedAssetDepreciationAccountName2: TLabel;
    cboFixedAssetDepreciationAccountName2: TwwDBLookupCombo;
    Bevel19: TBevel;
    lblFixedAssetsDepreciationAccount: TLabel;
    bvel1: TBevel;
    cboFixedAssetsDepreciationAccount: TwwDBLookupCombo;
    lblFixedAssetDepreciationAccountName: TLabel;
    cboFixedAssetDepreciationAccountName: TwwDBLookupCombo;
    dsDepreciationCalcs2: TDataSource;
    dsDepreciationCalcs1: TDataSource;
    qryChildAssets: TERPQuery;
    qryChildAssetsAssetName: TWideStringField;
    qryChildAssetsPurchCost: TFloatField;
    qryChildAssetsParentID: TIntegerField;
    DSChildAssets: TDataSource;
    qryChildAssetsAssetCode: TWideStringField;
    qryChildAssetsAssetType: TWideStringField;
    Label40: TLabel;
    dlgSerialSelect: TSelectionDialog;
    btnClone: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdNewServiceLog: TDNMSpeedButton;
    tabHire: TTabSheet;
    pnlHire: TDNMPanel;
    pnlHireTop: TDNMPanel;
    Label70: TLabel;
    cboHireIncomeAccountName: TERPDbLookupCombo;
    pnlHirePricing: TDNMPanel;
    Label69: TLabel;
    grdRates: TwwDBGrid;
    btnDelete: TwwIButton;
    edtMinHirePeriod: TwwDBEdit;
    cboMinHirePeriodType: TwwDBComboBox;
    cboDuration: TwwDBLookupCombo;
    pnlHireHistory: TDNMPanel;
    qryAssetHire: TERPQuery;
    qryAssetHireAssetHireId: TIntegerField;
    qryAssetHireGlobalref: TWideStringField;
    qryAssetHireAssetId: TIntegerField;
    qryAssetHireMinHirePeriodQty: TIntegerField;
    qryAssetHireMinHirePeriodType: TWideStringField;
    qryAssetHireHireIncomeAccountID: TIntegerField;
    qryAssetHireHireIncomeAccountName: TWideStringField;
    qryAssetHireActive: TWideStringField;
    qryAssetHiremstimestamp: TDateTimeField;
    qryAssetHiremsUpdatesiteCode: TWideStringField;
    qryHirePricingLine: TERPQuery;
    qryHirePricingLineHirePriceLineId: TIntegerField;
    qryHirePricingLineGlobalref: TWideStringField;
    qryHirePricingLineAssetHireId: TIntegerField;
    qryHirePricingLineDurationID: TIntegerField;
    qryHirePricingLineDurationName: TWideStringField;
    qryHirePricingLineRate: TFloatField;
    qryHirePricingLineActive: TWideStringField;
    qryHirePricingLinemstimestamp: TDateTimeField;
    qryHirePricingLinemsUpdatesiteCode: TWideStringField;
    qryDuration: TERPQuery;
    qryIncomeAccountLookup: TERPQuery;
    qryIncomeAccountLookupAccountname: TWideStringField;
    qryIncomeAccountLookupAccountId: TIntegerField;
    dsAssetHire: TDataSource;
    dsHirePricingLine: TDataSource;
    chkHireEnabled: TwwCheckBox;
    Label41: TLabel;
    cboHireProduct: TERPDbLookupCombo;
    qryProductLookup: TERPQuery;
    qryAssetHireHireProductName: TWideStringField;
    qryIncomeAccountLookupAccountType: TWideStringField;
    btnCopyHire: TDNMSpeedButton;
    Label42: TLabel;
    edtAssetDescription: TDBEdit;
    qryAssetDescription: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cboDepreciationOptionChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryDepreciationCalcs1AfterPost(DataSet: TDataSet);
    procedure qryDepreciationCalcs2AfterPost(DataSet: TDataSet);
    procedure cboAssetTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure cboPurchDateExit(Sender: TObject);
    procedure cboDepreciationStartDateExit(Sender: TObject);
    procedure btnProductSerialClick(Sender: TObject);
    procedure btnProductBarcodeClick(Sender: TObject);
    procedure cboDepreciationOptionCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cboDepreciationOption2Change(Sender: TObject);
    procedure cboDepreciationOption2CloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure PriorAccumDeprec2Click(Sender: TObject);
    procedure PriorAccumDeprecClick(Sender: TObject);
    procedure btnCalculateClick(Sender: TObject);
    procedure btnCalculate2Click(Sender: TObject);
    procedure DisposalofAssetClick(Sender: TObject);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure btnAddPicClick(Sender: TObject);
    procedure btnStretchClick(Sender: TObject);
    procedure btnCloneClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdNewServiceLogClick(Sender: TObject);
    procedure grpHistoryClick(Sender: TObject);
    procedure qryAssetAfterOpen(DataSet: TDataSet);
    procedure qryAssetAfterPost(DataSet: TDataSet);
    procedure qryPicturesAfterOpen(DataSet: TDataSet);
    procedure qryPicturesAfterPost(DataSet: TDataSet);
    procedure qryPicturesAfterScroll(DataSet: TDataSet);
    procedure chkHireEnabledClick(Sender: TObject);
    procedure btnCopyHireClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    ffrmList: TBaseListingGUI;
    fServiceLogList: TBaseListingGUI;
    fFixedAssetRepairList: TBaseListingGUI;
    PurchDateChangedFlag: Boolean;
    AttachmentForm: TfmAttachments;
    fHireHistory: THireHistoryForAssetGUI;

    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
    procedure Initform;
    procedure TotalsPercentages;
    procedure CheckDatesDay;
    function ServiceLogList: TBaseListingGUI;
    function RepairsList: TBaseListingGUI;
    procedure ResetgrdDepreciationCalcs(const DepreciationNo: integer);
    procedure DoBeforeAssetListShow(Sender: TObject);
    procedure DaAssetListDataSelect(Sender: TwwDbGrid);
    procedure CalculateDepreciation(const DepreciationNo, AssetID: integer;
      const DepreciationOption: string; const PurchDate: TDateTime;
      const PurchaseCost, SalvagePercent, SalvageValue, AssetLife: double;
      const UsePriorAccumDeprec: Boolean; const PriorAccumDeprecAmt: double;
      const PriorAccumDeprecDate: string; const BusinessUsePercent: double; const Disposal: Boolean;
      const DisposalDate: TDateTime);
    function IsMonthly(const DepreciationNo: integer): Boolean;
    function IsYearly(const DepreciationNo: integer): Boolean;
    function IsHalfYearly(const DepreciationNo: integer): Boolean;
    function IsExcludeMonthofPurchase(const DepreciationNo: integer): Boolean;
    function IsIncludeMonthofPurchase(const DepreciationNo: integer): Boolean;
    function CheckDepreciationParameters: Boolean;
    procedure DoRecalc;
    procedure initServiceLogG(Sender: TObject);
    procedure InitAttachments;
    procedure RefreshPic(DataSet: TDataSet);

  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CommitAndNotify; override;
    Procedure InitERPLookupCombonFields; Override;
  public
    FixedAssets: TFixedAssets;
  end;

implementation

uses CommonLib, BusObjConst, AppEnvironment, DateUtils, CommonFormLib,
  DNMExceptions,  CommonDbLib, DNMLib, FastFuncs, ImagesLib,
  BusObjPicture, frmFixedAssetServiceLogGUI, FormFactory, commonGuiLib, tcConst,
  BusObjAssetHire, BusObjHirePricingLine, FixedAssetsListFrm;

{$R *.dfm}

procedure TfmFixedAsset.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  AddDateTime(lcdOnLoganyway, MemoNotes, true);
end;

procedure TfmFixedAsset.btnAddPicClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    SelectPicture(TpotAssetPicture, self, self.qryPictures, qryPicturesAssetPictureId.fieldname,
      self.qryPicturesImage.fieldname, true, qryPicturesImagetype.fieldname, true);
  finally
    EnableForm;
    navPartPic.visible := False;
    navPartPic.visible := true;
    application.ProcessMessages;
  end;

end;

procedure TfmFixedAsset.btnCalculate2Click(Sender: TObject);
var
  SalvageValue: double;
begin
  DisableForm;
  try
    inherited;

    FixedAssets.InitAccounts;

    if (FixedAssets.SalvageType2 = 2) then begin
      SalvageValue := FixedAssets.PurchCost * (FixedAssets.Salvage2 / 100); // Percent salvage
    end
    else begin
      SalvageValue := FixedAssets.Salvage; // Amount salvage
    end;

    CalculateDepreciation(2, FixedAssets.ID, cboDepreciationOption2.Text, FixedAssets.PurchDate,
      FixedAssets.PurchCost, FixedAssets.SalvageFactor2, SalvageValue, FixedAssets.Life2,
      FixedAssets.PriorAccumDeprec2, FixedAssets.PriorAccumDeprecAmount2,
      FixedAssets.PriorAccumDeprecDate2, FixedAssets.BusinessUsePercent2, FixedAssets.Disposal,
      FixedAssets.DisposalDate2);
  finally
    EnableForm;
  end;

end;

procedure TfmFixedAsset.btnCalculateClick(Sender: TObject);
var
  SalvageValue: double;
begin
  DisableForm;
  try
    inherited;
    // Set UnSet Accounts
    FixedAssets.InitAccounts;

    if (FixedAssets.SalvageType = 2) then begin
      SalvageValue := FixedAssets.PurchCost * (FixedAssets.Salvage / 100); // Percent salvage
    end
    else begin
      SalvageValue := FixedAssets.Salvage; // Amount salvage
    end;

    CalculateDepreciation(1, FixedAssets.ID, cboDepreciationOption.Text, FixedAssets.PurchDate,
      FixedAssets.PurchCost, FixedAssets.SalvageFactor, SalvageValue, FixedAssets.Life,
      FixedAssets.PriorAccumDeprec, FixedAssets.PriorAccumDeprecAmount,
      FixedAssets.PriorAccumDeprecDate, FixedAssets.BusinessUsePercent, FixedAssets.Disposal,
      FixedAssets.DisposalDate);
  finally
    EnableForm;
  end;
end;

procedure TfmFixedAsset.btnCloneClick(Sender: TObject);
begin
  inherited;
  try
    if FixedAssets.dirty then begin
      if CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?',
        mtConfirmation, [mbYes, mbNo], 0) = mrno then
        exit;

      if not SaveRecord then
        exit;
      FixedAssets.Connection.CommitTransaction;
    end;
    FixedAssets.Connection.BeginTransaction;

    if not Assigned(FixedAssets.CloneBusObj('AssetCode', '', False)) then begin
      FixedAssets.Connection.RollbackTransaction;
      FixedAssets.Connection.BeginTransaction;
      MessageDlgXP_Vista('closing Fixed Asset Failed', mtInformation, [mbOK], 0);
      exit;
    end;
    if not(Assigned(FixedAssets.ObjInstanceToClone)) then begin
      FixedAssets.Connection.RollbackTransaction;
      FixedAssets.Connection.BeginTransaction;
      MessageDlgXP_Vista('closing Fixed Asset Failed', mtInformation, [mbOK], 0);
      exit;
    end;

    KeyId := FixedAssets.ObjInstanceToClone.ID;
    NewRecord;
//    FixedAssets.AssetName := '';
    FixedAssets.AssetCode := '';
    FixedAssets.Serial := '';
    if FixedAssets.PartsId <> 0 then begin
      if FixedAssets.Product.SNTracking then begin
        LoadSerials(FixedAssets.PartsId, FixedAssets.ClassId, dlgSerialSelect);
        dlgSerialSelect.MultiSelect := False;
        if (dlgSerialSelect.Items.Count > 0) then
          if dlgSerialSelect.Execute then begin
            FixedAssets.Serial := Trim(dlgSerialSelect.SelectedItems.Text);
            FixedAssets.AssetName := FixedAssets.Product.ProductName + '(' +
              FixedAssets.Serial + ')';
            exit;
          end;
      end;
    end;
    MessageDlgXP_Vista('A New fixed Asset is created copying the details.' + NL + NL +
      'Please Provide Asset Code and Asset Name for the New Record', mtInformation, [mbOK], 0);

  finally
    FixedAssets.Connection.BeginTransaction;
    Setcontrolfocus(AssetCode);
  end;
end;

procedure TfmFixedAsset.btnCopyHireClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then
    exit;
  FixedAssets.Connection.CommitTransaction;
  FixedAssets.Connection.BeginTransaction;
  CommonFormLib.OpenERPListFormultiselectModal('TFixedAssetsListGUI',DoBeforeAssetListShow,DaAssetListDataSelect);
end;

procedure TfmFixedAsset.btnDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then begin
    try
      self.FixedAssets.AssetHire.PriceLines.Delete;
    except
      {Do nothing - raise a silent exception}
    end;
  end;
end;

procedure TfmFixedAsset.btnProductBarcodeClick(Sender: TObject);
begin
  inherited;
  FixedAssets.BARCODE := GetPartBarcode(qryAssetPARTSID.AsInteger);

end;

procedure TfmFixedAsset.btnProductSerialClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if qryAssetPARTSID.AsInteger = 0 then begin
      MessageDlgXP_Vista('Please Choose Product to Choose a Serial Number', mtInformation,
        [mbOK], 0);
      exit;
    end;
    LoadSerials(FixedAssets.PartsId, FixedAssets.ClassId, dlgSerialSelect);
    if (dlgSerialSelect.Items.Count > 0) then begin
      dlgSerialSelect.MultiSelect := False;
      if dlgSerialSelect.Execute then begin
        FixedAssets.Serial := Trim(dlgSerialSelect.SelectedItems.Text);
      end;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('There Are No Serial Numbers For This Product On This ' +
        AppEnv.DefaultClass.ClassHeading, mtInformation, [mbOK], 0);
    end;
  finally
    EnableForm;
  end;

end;

procedure TfmFixedAsset.btnStretchClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    ImgImages.Stretch := not(ImgImages.Stretch);
  finally
    EnableForm;
  end;

end;

(* procedure TfmFixedAsset.LoadSerials;//(const PartsID, ClassID: integer);
  var
  qryTemp: TERPQuery;
  begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  with qryTemp do try
  Sql.Clear;
  SQL.add(StockQtyDetailswithSno(True, qryAssetPARTSID.asInteger , qryAssetClassID.AsInteger ));
  Open;
  dlgSerialSelect.Items.Clear;
  if not IsEmpty then begin
  First;
  while not Eof do begin
  if FieldByName('SerialNumber').AsString <> '' then dlgSerialSelect.Items.Add(FieldByName('SerialNumber').AsString);
  Next;
  end;
  end;
  finally
  FreeAndNil(qryTemp);
  end;
  end; *)
procedure TfmFixedAsset.cboAssetTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  modified: Boolean);
begin
  if not modified then
    exit;
  inherited;
  // #1
  FixedAssets.DepreciationOption := trunc(qryfixedassettypesDepreciationOption.AsFloat);
  FixedAssets.SalvageType := trunc(qryfixedassettypesSalvageType.AsFloat);
  FixedAssets.SalvageFactor := qryfixedassettypesSalvageFactor.AsFloat;
  FixedAssets.Life := qryfixedassettypesLife.AsFloat;
  FixedAssets.Salvage := qryfixedassettypesSalvage.AsFloat;
  FixedAssets.BusinessUsePercent := 100;

  // #2
  FixedAssets.DepreciationOption2 := trunc(qryfixedassettypesDepreciationOption.AsFloat);
  FixedAssets.SalvageType2 := trunc(qryfixedassettypesSalvageType.AsFloat);
  FixedAssets.SalvageFactor2 := qryfixedassettypesSalvageFactor.AsFloat;
  FixedAssets.Life2 := qryfixedassettypesLife.AsFloat;
  FixedAssets.Salvage2 := qryfixedassettypesSalvage.AsFloat;
  FixedAssets.BusinessUsePercent2 := 100;

  FixedAssets.Postdb;
  FixedAssets.Editdb;

end;

procedure TfmFixedAsset.cboDepreciationOption2Change(Sender: TObject);
begin
  inherited;
  if cboDepreciationOption2.Value <> '3' then begin
    cboDepreciationOption2.Width := 229;
    SalvageFactor2.visible := False;
    Salvage2.Enabled := true;
    cboSalvageType2.Enabled := true;
    lblSalvage2.Enabled := true;
  end
  else begin
    cboDepreciationOption2.Width := 157;
    SalvageFactor2.visible := true;
    Salvage2.Enabled := False;
    cboSalvageType2.Enabled := False;
    lblSalvage2.Enabled := False;
  end;

end;

procedure TfmFixedAsset.cboDepreciationOption2CloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  if cboDepreciationOption2.Value = '3' then begin
    FixedAssets.SalvageFactor2 := 200;
    FixedAssets.Salvage2 := 0;
  end

end;

procedure TfmFixedAsset.cboDepreciationOptionChange(Sender: TObject);
begin
  inherited;
  if cboDepreciationOption.Value <> '3' then begin
    cboDepreciationOption.Width := 229;
    SalvageFactor.visible := False;
    Salvage.Enabled := true;
    cboSalvageType.Enabled := true;
    lblSalvage.Enabled := true;
  end
  else begin
    cboDepreciationOption.Width := 157;
    SalvageFactor.visible := true;
    Salvage.Enabled := False;
    cboSalvageType.Enabled := False;
    lblSalvage.Enabled := False;
  end;
end;

procedure TfmFixedAsset.cboDepreciationOptionCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  if cboDepreciationOption.Value = '3' then begin
    FixedAssets.SalvageFactor := 200;
    FixedAssets.Salvage := 0;
  end

end;

procedure TfmFixedAsset.cboDepreciationStartDateExit(Sender: TObject);
begin
  inherited;
  CheckDatesDay;
end;

procedure TfmFixedAsset.cboPurchDateExit(Sender: TObject);
begin
  inherited;
  CheckDatesDay;
end;

procedure TfmFixedAsset.chkHireEnabledClick(Sender: TObject);
begin
  inherited;
  if not chkHireEnabled.Focused then exit;

  pnlHirePricing.Enabled := FixedAssets.AssetHire.Active;
  if FixedAssets.AssetHire.Active then
    FixedAssets.AssetHire.PriceLines;
  EditDb(qryAssetHire);
  cboHireIncomeAccountName.Enabled := FixedAssets.AssetHire.Active;
  cboHireProduct.Enabled := FixedAssets.AssetHire.Active;
  btnCopyHire.Enabled := FixedAssets.AssetHire.Active;
end;

procedure TfmFixedAsset.cmdCancelClick(Sender: TObject);
begin
  inherited;
  self.AddFlag('Canceled');
  self.Close;
end;

Function TfmFixedAsset.SaveRecord: Boolean;
begin
  result := False;
  FixedAssets.Postdb;
  if not(FixedAssets.Save) then
    exit;
  result := true;
end;

procedure TfmFixedAsset.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then
    exit;
  FixedAssets.Connection.CommitTransaction;
  FixedAssets.dirty := False;
  self.Close;

end;

procedure TfmFixedAsset.cmdNewClick(Sender: TObject);
begin
  inherited;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if FixedAssets.dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?',
        mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes: begin
            if SaveRecord then begin
              CommitAndNotify; // current record should be commited before inserting new reocrd
            end
            else
              exit;
          end;
        mrno: begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
          end;
        mrCancel: begin
            exit;
          end;
      end;
    end;
    KeyId := 0;
    NewRecord;
  finally
    EnableForm;
  end;

end;

procedure TfmFixedAsset.cmdNewServiceLogClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TServiceLogGUI', 0, nil, initServiceLogG)
end;

procedure TfmFixedAsset.initServiceLogG(Sender: TObject);
begin
  if not(Sender is TServiceLogGUI) then
    exit;
  TServiceLogGUI(Sender).PassAssetCode := FixedAssets.AssetCode;
end;

procedure TfmFixedAsset.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    inherited;
    try
      if FixedAssets.dirty then begin
        if CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?',
          mtConfirmation, [mbYes, mbNo], 0) = mrno then
          exit;

        if not SaveRecord then
          exit;
        FixedAssets.Connection.CommitTransaction;
      end;
      sSQL := ' WHERE FA.AssetID = ' + qryAssetAssetID.AsString;
      PrintTemplateReport('Fixed Asset', sSQL, not AppEnv.Employee.ShowPreview, 1);
    finally
      FixedAssets.Connection.BeginTransaction;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmFixedAsset.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  // AfterCommit;
  Notify;

end;

procedure TfmFixedAsset.DaAssetListDataSelect(Sender: TwwDbGrid);
var
  x: integer;
  FA: TFixedAssets;

begin
  if Sender.SelectedList.Count > 0 then begin
    if CommonLib.MessageDlgXP_Vista('Do you wish to Copy the Hire Details to the ' +
      IntToStr(Sender.SelectedList.Count) + ' selected Asset(s)?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;

    ProgressDialog.DoShowProgressbar(Sender.SelectedList.Count,'Updating Assets');
    FA := TFixedAssets.Create(nil);
    try
      FA.Connection := self.FixedAssets.Connection;
      for x := 0 to Sender.SelectedList.Count -1 do begin
        Sender.Datasource.DataSet.GotoBookmark(Sender.SelectedList[x]);
        if Sender.Datasource.DataSet.FieldByName('AssetId').AsInteger = self.FixedAssets.id then
          continue;

        FA.Load(Sender.Datasource.DataSet.FieldByName('AssetId').AsInteger);

        if FA.AssetHire.Count > 0 then
          FA.AssetHire.Delete;
        FA.AssetHire.New;
        FA.AssetHire.Assign(self.FixedAssets.AssetHire);
        FA.AssetHire.AssetId := FA.ID;
        FA.AssetHire.PostDb;
        FA.AssetHire.PriceLines.First;
        self.FixedAssets.AssetHire.PriceLines.First;
        while not self.FixedAssets.AssetHire.PriceLines.EOF do begin
          FA.AssetHire.PriceLines.New;
          FA.AssetHire.PriceLines.Assign(self.FixedAssets.AssetHire.PriceLines);
          FA.AssetHire.PriceLines.AssetHireID := FA.AssetHire.ID;
          FA.AssetHire.PriceLines.PostDb;
          self.FixedAssets.AssetHire.PriceLines.Next;
        end;
        FA.PostDb;
        ProgressDialog.DoStepProgressbar();
      end;
    finally
      FA.Free;
      ProgressDialog.DoHideProgressbar;
      FixedAssets.Connection.CommitTransaction;
      FixedAssets.Connection.BeginTransaction;
    end;
    CommonLib.MessageDlgXP_Vista('Update Complete',mtInformation,[mbOk],0);
  end;
end;

procedure TfmFixedAsset.DisposalofAssetClick(Sender: TObject);
begin
  inherited;
  Label28.Enabled := DisposalofAsset.Checked;
  cboDisposalDate.Enabled := DisposalofAsset.Checked;
  Label29.Enabled := DisposalofAsset.Checked;
  SalesPrice.Enabled := DisposalofAsset.Checked;
  Label35.Enabled := DisposalofAsset.Checked;
  DisposalAccumDeprec.Enabled := DisposalofAsset.Checked;
  Label34.Enabled := DisposalofAsset.Checked;
  DisposalBookValue.Enabled := DisposalofAsset.Checked;
  DisposalCalculate.Enabled := DisposalofAsset.Checked;

  Label59.Enabled := DisposalofAsset.Checked;
  cboDisposalDate2.Enabled := DisposalofAsset.Checked;
  Label60.Enabled := DisposalofAsset.Checked;
  SalesPrice2.Enabled := DisposalofAsset.Checked;
  Label62.Enabled := DisposalofAsset.Checked;
  DisposalAccumDeprec2.Enabled := DisposalofAsset.Checked;
  Label61.Enabled := DisposalofAsset.Checked;
  DisposalBookValue2.Enabled := DisposalofAsset.Checked;
  DisposalCalculate2.Enabled := DisposalofAsset.Checked;

  DoRecalc;
end;

procedure TfmFixedAsset.DoRecalc;
begin
  inherited;
  if not qryAsset.Active then
    exit;
  if (FixedAssets.PurchCost <> 0.00) then begin
    if not PurchDateChangedFlag then begin
      PurchDateChangedFlag := true;
      try
        btnCalculate.Click;
        btnCalculate2.Click;
      finally
        PurchDateChangedFlag := False;
      end;

    end;
  end;
end;

procedure TfmFixedAsset.DoBeforeAssetListShow(Sender: TObject);
begin
  if Sender is  TFixedAssetsListGUI then begin
    TFixedAssetsListGUI(Sender).grpHireFilter.ItemIndex := 1;
//    TFixedAssetsListGUI(Sender).FilterString := 'AssetName = ' + QuotedStr(QryHireLinesAssetName.AsString);
  end;
end;

procedure TfmFixedAsset.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  { --- } if (EventType = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin

    if Sender is TFixedAssets then
      TFixedAssets(Sender).DataSet := qryAsset
    else if Sender is Tfixedassetsdepreciationdetails1 then
      Tfixedassetsdepreciationdetails1(Sender).DataSet := qryDepreciationCalcs1
    else if Sender is Tfixedassetsdepreciationdetails2 then
      Tfixedassetsdepreciationdetails2(Sender).DataSet := qryDepreciationCalcs2
    else if Sender is TAssetPicture then
      TAssetPicture(Sender).DataSet := qryPictures
    else if Sender is TFixedAssetPercentages then
      TFixedAssetPercentages(Sender).DataSet := qryFAPercentages
    else if Sender is TAssetHire then
      TAssetHire(Sender).DataSet := qryAssetHire
    else if Sender is THirePricingLine then
      THirePricingLine(Sender).DataSet := qryHirePricingLine;
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_PercentageCostTotal_Invalid) then
  begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(grdFAPercentage);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_PercentageDeprTotal_Invalid) then
  begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(grdFAPercentage);
    { --- } end
  else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_SalvageType) then begin
    if FixedAssets.SalvageType = 1 { amount } then begin
      qryAssetSalvage.currency := true;
      qryAssetSalvage.DisplayFormat := '';
    end
    else begin
      qryAssetSalvage.currency := False;
      qryAssetSalvage.DisplayFormat := '0.00%';
      if FixedAssets.Salvage > 100.00 then begin
        FixedAssets.Salvage := 0.00;
        FixedAssets.Postdb;
      end;
    end;
    { --- } end
  else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_SalvageType2) then begin
    if FixedAssets.SalvageType2 = 1 { amount } then begin
      qryAssetSalvage2.currency := true;
      qryAssetSalvage2.DisplayFormat := '';
    end
    else begin
      qryAssetSalvage2.currency := False;
      qryAssetSalvage2.DisplayFormat := '0.00%';
      if FixedAssets.Salvage2 > 100.00 then
        FixedAssets.Salvage2 := 0.00;
    end;
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_FA_DepAcc1_Invalid) then begin
    PageControl1.ActivePage := Depreciation1;
    Setcontrolfocus(cboFixedAssetsDepreciationAccount);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_FA_DepAcc2_Invalid) then begin
    PageControl1.ActivePage := Depreciation2;
    Setcontrolfocus(cboFixedAssetAccountName2);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD1_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD1);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD2_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD2);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD3_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD3);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD4_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD4);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD5_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD5);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD6_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD6);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD7_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD7);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD8_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD8);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD9_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD9);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD10_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD10);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD11_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD11);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD12_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD12);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD13_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD13);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD14_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD14);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD15_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD15);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD16_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD16);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD17_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD17);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_CUSTFLD18_Invalid) then begin
    PageControl1.ActivePage := TTabSheet(AssetInfo);
    Setcontrolfocus(CUSTFLD18);
    { --- } end
  else if (EventType = BusObjEvent_ToDO) and (Value = BusObjEvent_DoCalc) then begin
    DoRecalc;
  end;
end;

procedure TfmFixedAsset.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmFixedAsset.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then
    exit;

  CanClose := False;
  if FixedAssets.dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrno: begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          FixedAssets.dirty := False;
          CanClose := true;
          Notify(true);
        end;
      mrCancel: begin
          CanClose := False;
          cmdCancel.Enabled := true;
        end;
    end;
  end
  else begin
    CanClose := true;
    if IsFlag('Canceled') then
      Notify(true)
    else
      Notify(false);
  end;

end;

procedure TfmFixedAsset.FormCreate(Sender: TObject);
begin
  try
    PurchDateChangedFlag := False;
    inherited;
    NewBusObjinstance;
  Except
    on E: Exception do begin
      MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmFixedAsset.FormShow(Sender: TObject);
begin
  inherited;
  Openrec;
  if not FixedAssets.Lock then begin
    self.caption := self.caption + '     {Read-Only}';
    Accesslevel := 5;
  end;

  Initform;
  Setcontrolfocus(AssetCode);
end;

procedure TfmFixedAsset.Openrec;
begin
  FixedAssets.Load(KeyId);
  FixedAssets.Connection.BeginTransaction;
  if FixedAssets.Count = 0 then
    FixedAssets.new;
  FixedAssets.fixedassetsdepreciationdetails1;
  FixedAssets.fixedassetsdepreciationdetails2;
  FixedAssets.AssetPicture;
  FixedAssets.FixedAssetPercentages;
  openQueries;
  FixedAssets.dirty := False;
end;

procedure TfmFixedAsset.PageControl1Change(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = TTabSheet(Custom_Fields) then begin
    CustomFieldsRefresh;
  end;

  if PageControl1.ActivePage = TTabSheet(tabHistory) then begin
    grpHistoryClick(nil);
  end;

  if PageControl1.ActivePage = TTabSheet(Depreciation1) then begin
    ResetgrdDepreciationCalcs(1);

    qryDepreciationCalcs1.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]),
      [loCaseInsensitive]);
  end;

  if PageControl1.ActivePage = TTabSheet(Depreciation2) then begin
    ResetgrdDepreciationCalcs(2);

    qryDepreciationCalcs2.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]),
      [loCaseInsensitive]);
  end;

  if PageControl1.ActivePage = tabHire then begin

    { this will create the hire sub object }
    FixedAssets.AssetHire;
    if FixedAssets.AssetHire.Active then begin
      FixedAssets.AssetHire.PriceLines;
    end;
    if not Assigned(fHireHistory) then begin
      fHireHistory := THireHistoryForAssetGUI.Create(self);

      fHireHistory.Anchors:= [akLeft,akTop,akRight,akBottom];
      fHireHistory.Height := pnlHireHistory.Height - (fHireHistory.top *2);
      fHireHistory.Width := pnlHireHistory.Width - (fHireHistory.Left *2);
      fHireHistory.Parent := pnlHireHistory;
      fHireHistory.align := alclient;
      fHireHistory.BorderStyle := bsNone;
      fHireHistory.fbIgnoreQuerySpeed := true;

      fHireHistory.AssetId := FixedAssets.ID;
      fHireHistory.Show;
    end;

    pnlHirePricing.Enabled := FixedAssets.AssetHire.Active;
    if FixedAssets.AssetHire.Active then
      FixedAssets.AssetHire.PriceLines;
    cboHireIncomeAccountName.Enabled := FixedAssets.AssetHire.Active;
    cboHireProduct.Enabled := FixedAssets.AssetHire.Active;
    btnCopyHire.Enabled := FixedAssets.AssetHire.Active;
  end;

end;

procedure TfmFixedAsset.PriorAccumDeprec2Click(Sender: TObject);
begin
  inherited;
  Label58.Enabled := PriorAccumDeprec2.Checked;
  PriorAccumDeprecAmount2.Enabled := PriorAccumDeprec2.Checked;
  Label66.Enabled := PriorAccumDeprec2.Checked;
  PriorAccumDeprecDate2.Enabled := PriorAccumDeprec2.Checked;
end;

procedure TfmFixedAsset.PriorAccumDeprecClick(Sender: TObject);
begin
  inherited;
  Label32.Enabled := PriorAccumDeprec.Checked;
  PriorAccumDeprecAmount.Enabled := PriorAccumDeprec.Checked;
  Label33.Enabled := PriorAccumDeprec.Checked;
  PriorAccumDeprecDate.Enabled := PriorAccumDeprec.Checked;
end;

procedure TfmFixedAsset.qryAssetAfterOpen(DataSet: TDataSet);
begin
  inherited;
  InitAttachments;
end;

procedure TfmFixedAsset.InitAttachments;
begin
  if FixedAssets.ID = 0 then
    exit;
  If not Assigned(AttachmentForm) then begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self, true,
      true, FixedAssets.ID));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(self);
    AttachmentForm.TableName := FixedAssets.BusObjectTablename;
  end;
  if AttachmentForm.TableId <> FixedAssets.ID then begin
    AttachmentForm.TableId := FixedAssets.ID;
    AttachmentForm.Tag := FixedAssets.ID;
    AttachmentForm.lvAttachments.Parent := pnlAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;

procedure TfmFixedAsset.qryAssetAfterPost(DataSet: TDataSet);
begin
  inherited;
  InitAttachments;
end;

procedure TfmFixedAsset.qryDepreciationCalcs1AfterPost(DataSet: TDataSet);
begin
  inherited;
  TotalsPercentages;
end;

procedure TfmFixedAsset.qryDepreciationCalcs2AfterPost(DataSet: TDataSet);
begin
  inherited;
  TotalsPercentages;
end;

procedure TfmFixedAsset.qryPicturesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshPic(DataSet);
end;

procedure TfmFixedAsset.qryPicturesAfterPost(DataSet: TDataSet);
begin
  inherited;
  RefreshPic(DataSet);
end;

procedure TfmFixedAsset.qryPicturesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshPic(DataSet);
end;

procedure TfmFixedAsset.ResetgrdDepreciationCalcs(const DepreciationNo: integer);
begin
  if (DepreciationNo = 1) then begin
    if (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Month') then begin
      grdDepreciationCalcs1.ColumnByName('Year').DisplayWidth := 9;
      grdDepreciationCalcs1.ColumnByName('Month').DisplayWidth := 12;
      grdDepreciationCalcs1.ColumnByName('Depreciation').DisplayWidth := 13;
      grdDepreciationCalcs1.ColumnByName('TotalDepreciation').DisplayWidth := 13;
      grdDepreciationCalcs1.ColumnByName('BookValue').DisplayWidth := 13;
    end
    else begin
      grdDepreciationCalcs1.RemoveField('Month');
      grdDepreciationCalcs1.ColumnByName('Year').DisplayWidth := 10;
      grdDepreciationCalcs1.ColumnByName('Depreciation').DisplayWidth := 16;
      grdDepreciationCalcs1.ColumnByName('TotalDepreciation').DisplayWidth := 16;
      grdDepreciationCalcs1.ColumnByName('BookValue').DisplayWidth := 16;
    end;
  end
  else if (DepreciationNo = 2) then begin
    if (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Full Month') then begin
      grdDepreciationCalcs2.ColumnByName('Year').DisplayWidth := 9;
      grdDepreciationCalcs2.ColumnByName('Month').DisplayWidth := 12;
      grdDepreciationCalcs2.ColumnByName('Depreciation').DisplayWidth := 13;
      grdDepreciationCalcs2.ColumnByName('TotalDepreciation').DisplayWidth := 13;
      grdDepreciationCalcs2.ColumnByName('BookValue').DisplayWidth := 13;
    end
    else begin
      grdDepreciationCalcs2.RemoveField('Month');
      grdDepreciationCalcs2.ColumnByName('Year').DisplayWidth := 10;
      grdDepreciationCalcs2.ColumnByName('Depreciation').DisplayWidth := 16;
      grdDepreciationCalcs2.ColumnByName('TotalDepreciation').DisplayWidth := 16;
      grdDepreciationCalcs2.ColumnByName('BookValue').DisplayWidth := 16;
    end;
  end;
end;

Procedure TfmFixedAsset.Initform;
begin
  DisableForm;
  try
    try
      PageControl1.ActivePage := TTabSheet(AssetInfo);

      cboFixedAssetsAccount.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
      cboFixedAssetsClearingAccount.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
      cboFixedAssetsDepreciationAccount.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
      cboFixedAssetDepreciationAccountName.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);

      lblFixedAssetsAccount.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
      lblFixedAssetsClearingAccount.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
      lblFixedAssetsDepreciationAccount.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
      lblFixedAssetDepreciationAccountName.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);

      // ##
      cboFixedAssetAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
      cboClearingAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
      cboFixedAssetDepreciationAssetAccountName2.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
      cboFixedAssetDepreciationAccountName2.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);

      lblFixedAssetAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
      lblClearingAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
      lblFixedAssetDepreciationAssetAccountName2.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
      lblFixedAssetDepreciationAccountName2.Enabled :=
        (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);

      CustomFieldRefresh('CFAssets', pnlCustFields);

      // ##

      TotalsPercentages;
      CheckDatesDay;

    except
      on EAbort do
        HandleEAbortException;
      on E: ENoAccess do begin
        HandleNoAccessException(E);
        exit;
      end;
      else
        raise;
    end;
  finally
    EnableForm;
  end;

end;

procedure TfmFixedAsset.TotalsPercentages;
begin
  grdFAPercentage.ColumnByName('Cost').FooterValue := FloatToStrF(FixedAssets.FAPercentageCostTotal,
    ffFixed, 15, 2) + '%';
  grdFAPercentage.ColumnByName('Depreciation').FooterValue :=
    FloatToStrF(FixedAssets.FAPercentageDepreciationTotal, ffFixed, 15, 2) + '%';
  (* var
    bm: TBookmark;
    Cost: double;
    Depreciation: double;
    begin
    inherited;
    bm := qryFAPercentages.GetBookmark;
    qryFAPercentages.DisableControls;
    try
    with qryFAPercentages do begin
    First;
    Cost := 0.0;
    Depreciation := 0.0;
    while not Eof do begin
    Cost := Cost + qryFAPercentages.FieldByName('Cost').AsFloat;
    Depreciation := Depreciation + qryFAPercentages.FieldByName('Depreciation').AsFloat;
    Next;
    end;
    end;
    Finally
    qryFAPercentages.GotoBookmark(bm);
    qryFAPercentages.FreeBookmark(bm);
    qryFAPercentages.EnableControls;
    end;
    grdFAPercentage.ColumnByName('Cost').FooterValue := FloatToStrF(Cost,  ffFixed, 15, 2) + '%';
    grdFAPercentage.ColumnByName('Depreciation').FooterValue := FloatToStrF(Depreciation,ffFixed, 15, 2) + '%'; *)
end;

procedure TfmFixedAsset.NewBusObjinstance;
begin
  FixedAssets := TFixedAssets.CreateWithNewConn(self);
  FixedAssets.Connection.Connection := self.MyConnection;
  FixedAssets.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmFixedAsset.NewRecord;
begin
  CloseQueries;
  NewBusObjinstance;
  Accesslevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(self.ClassName);
  self.BeginTransaction;
  Openrec;
  caption := TitleLabel.caption + AppEnv.AccessLevels.GetAccessLevelDescription(Accesslevel);
  Setcontrolfocus(AssetCode);
end;

procedure TfmFixedAsset.CheckDatesDay;
var
  bm: TBookMark;
  firstDate, lastDate: TDateTime;
  depAmt, remainDepAmt: double;
  dateDiff: TDateTime;
  s: string;
  yrs: integer;
begin
  lblDayMatch.caption := '';
  if (FixedAssets.DepreciationStartDate <> 0) and (FixedAssets.PurchDate <> 0) then
    if DayOfTheMonth(FixedAssets.DepreciationStartDate) <> DayOfTheMonth(FixedAssets.PurchDate) then
      lblDayMatch.caption := 'Day does not match Purchase Day';

  lblPercentInfo1.caption := '';
  lblPercentInfo2.caption := '';
  if FixedAssets.DepreciationStartDate <> FixedAssets.PurchDate then begin
    if qryDepreciationCalcs1.RecordCount > 0 then begin
      firstDate := 0;
      lastDate := 0;
      depAmt := 0;
      remainDepAmt := 0;
      s := '';
      bm := qryDepreciationCalcs1.GetBookmark;
      try
        qryDepreciationCalcs1.DisableControls;
        try
          qryDepreciationCalcs1.First;
          while not qryDepreciationCalcs1.Eof do begin
            if firstDate = 0 then
              firstDate := FixedAssets.fixedassetsdepreciationdetails1.Date;
            if FixedAssets.fixedassetsdepreciationdetails1.Depreciation > 0 then begin
              lastDate := FixedAssets.fixedassetsdepreciationdetails1.Date;
              depAmt := depAmt + FixedAssets.fixedassetsdepreciationdetails1.Depreciation;
              if lastDate >= qryAssetDepreciationStartDate.AsDateTime then
                remainDepAmt := remainDepAmt + FixedAssets.fixedassetsdepreciationdetails1.
                  Depreciation;
            end;
            qryDepreciationCalcs1.Next;
          end;
          qryDepreciationCalcs1.GotoBookmark(bm);
        finally
          qryDepreciationCalcs1.EnableControls;
        end;
      finally
        qryDepreciationCalcs1.FreeBookmark(bm);
      end;
      dateDiff := lastDate - qryAssetDepreciationStartDate.AsDateTime;
      yrs := 0;
      if dateDiff > 0 then begin
        if dateDiff > 365 then
          yrs := trunc(dateDiff / 365);
        s := '( ' + IntToStr(yrs) + ' Years ' + IntToStr(System.Round((dateDiff - (yrs * 365)) / 30)
          ) + ' Months';
        if (remainDepAmt > 0) and (depAmt > 0) then
          s := s + ' ' + IntToStr(System.Round((remainDepAmt / depAmt) * 100)) + '%';
        s := s + ' )';
      end
      else begin
        s := '( 0 Years )';
      end;
      lblPercentInfo1.caption := s;
    end;

    if qryDepreciationCalcs2.RecordCount > 0 then begin
      firstDate := 0;
      lastDate := 0;
      depAmt := 0;
      remainDepAmt := 0;
      s := '';
      bm := qryDepreciationCalcs2.GetBookmark;
      try
        qryDepreciationCalcs2.DisableControls;
        try
          qryDepreciationCalcs2.First;
          while not qryDepreciationCalcs2.Eof do begin
            if firstDate = 0 then
              firstDate := FixedAssets.fixedassetsdepreciationdetails2.Date;
            if FixedAssets.fixedassetsdepreciationdetails2.Depreciation > 0 then begin
              lastDate := FixedAssets.fixedassetsdepreciationdetails2.Date;
              depAmt := depAmt + FixedAssets.fixedassetsdepreciationdetails2.Depreciation;
              if lastDate >= qryAssetDepreciationStartDate.AsDateTime then
                remainDepAmt := remainDepAmt + FixedAssets.fixedassetsdepreciationdetails2.
                  Depreciation;
            end;
            qryDepreciationCalcs2.Next;
          end;
          qryDepreciationCalcs2.GotoBookmark(bm);
        finally
          qryDepreciationCalcs2.EnableControls;
        end;
      finally
        qryDepreciationCalcs2.FreeBookmark(bm);
      end;
      dateDiff := lastDate - qryAssetDepreciationStartDate.AsDateTime;
      yrs := 0;
      if dateDiff > 0 then begin
        if dateDiff > 365 then
          yrs := trunc(dateDiff / 365);
        s := '( ' + IntToStr(yrs) + ' Years ' + IntToStr(System.Round((dateDiff - (yrs * 365)) / 30)
          ) + ' Months';
        if (remainDepAmt > 0) and (depAmt > 0) then
          s := s + ' ' + IntToStr(System.Round((remainDepAmt / depAmt) * 100)) + '%';
        s := s + ' )';
      end
      else begin
        s := '( 0 Years )';
      end;
      lblPercentInfo2.caption := s;
    end;

  end;
end;

function TfmFixedAsset.ServiceLogList: TBaseListingGUI;
begin
  CreateHistorylistform('TServiceLogListGUI', self, fServiceLogList, 'AssetID  ',
    IntToStr(FixedAssets.ID));
  result := fServiceLogList;
end;

function TfmFixedAsset.RepairsList: TBaseListingGUI;
begin
  CreateHistorylistform('TfmFixedAssetRepairList', self, fFixedAssetRepairList, 'AssetID  ',
    IntToStr(FixedAssets.ID));
  result := fFixedAssetRepairList;
end;

procedure TfmFixedAsset.grpHistoryClick(Sender: TObject);
begin
  FixedAssets.Postdb;
  case grpHistory.ItemIndex of
    0:
      ffrmList := ServiceLogList;
    1:
      ffrmList := RepairsList;
  end;

  if Assigned(ffrmList) then begin
    grpHistory.Color := ffrmList.pnlHeader.Color;
    ffrmList.Parent := pnlHistory;
    ffrmList.Align := alClient;
    ffrmList.BorderStyle := bsNone;
    ffrmList.fbIgnoreQuerySpeed := true;
    try
      ffrmList.Show;
    except
      FreeAndNil(ffrmList);
    end;
    (*
      // Show Print & Export
      for iIndex := 0 to ffrmList.FooterPanel.ControlCount - 1 do begin
      if ffrmList.FooterPanel.Controls[iIndex] is TControl then begin
      TControl(ffrmList.FooterPanel.Controls[iIndex]).Visible := false;
      end;
      end;
      ffrmList.FooterPanel.Height         := 30;
      ffrmList.cmdExport.Top              := 1;
      ffrmList.cmdExport.Left             := 100;
      ffrmList.cmdExport.Visible          := true;
      ffrmList.cmdPrint.Top               := 1;
      ffrmList.cmdPrint.Left              := pnlHistory.Width - 200;
      ffrmList.cmdPrint.Visible           := true;
      ffrmList.FooterPanel.Visible        := true;
      ffrmList.grpFilters.Visible         := true;
      ffrmList.pnlButtons.Visible         := true;
      ffrmList.grdMain.PopupMenu          := ffrmList.mnuFilter;
      ffrmList.grdMain.Align              := alClient; *)

    ffrmList.Refresh;
  end
  else begin
    if Assigned(fFixedAssetRepairList) then begin
      fFixedAssetRepairList.Parent := nil;
      fFixedAssetRepairList.Hide;
    end;

    if Assigned(fServiceLogList) then begin
      fServiceLogList.Parent := nil;
      fServiceLogList.Hide;
    end;
    pnlHistory.Font.Size := 15;
    pnlHistory.caption := 'YOU DO NOT HAVE ACCESS TO THIS REPORT!';
    pnlHistory.Paint;
  end;

end;

procedure TfmFixedAsset.CalculateDepreciation(const DepreciationNo, AssetID: integer;
  const DepreciationOption: string; const PurchDate: TDateTime;
  const PurchaseCost, SalvagePercent, SalvageValue, AssetLife: double;
  const UsePriorAccumDeprec: Boolean; const PriorAccumDeprecAmt: double;
  const PriorAccumDeprecDate: string; const BusinessUsePercent: double; const Disposal: Boolean;
  const DisposalDate: TDateTime);
var
  I, C, LifeCycles, Life: integer;
  ADLife, TempMonthStart: integer;
  MonthStart, MonthsLeft: integer;
  DisposalYear: integer;
  DisposalMonth: integer;
  DepreciationCycles: integer;
  LifeTemp, Depreciation: double;
  Year: string;
  DepreciationTotal: double;
  DepreciableBasis: double;
  LastDepreciationTotal: double;
  PriorAccumDeprecMonth: integer;
  ExitOnDisposalDate: Boolean;
  TempDate: TDateTime;
  TempDateDay: word;
  tmpTempDateDay: word;
  PurchaseDate: TDateTime;
  PriorAccumDeprecAmount: double;

  (* function DepCalcStartFinancialYearPrefSet: boolean;
    begin
    result :=
    ((DepreciationNo = 1) and SameText(AppEnv.CompanyPrefs.DepreciationCalcStart1, 'Financial Year')) or
    ((DepreciationNo = 2) and SameText(AppEnv.CompanyPrefs.DepreciationCalcStart2, 'Financial Year'));
    end; *)
  function FADObj: TfixedassetsdepreciationdetailsBase;
  begin
    if DepreciationNo = 1 then
      result := FixedAssets.fixedassetsdepreciationdetails1
    else
      result := FixedAssets.fixedassetsdepreciationdetails2;
  end;

  function DateStartForPriorAccum: TDateTime;
  var
    Month: integer;
  begin
    if DepreciationNo = 1 then begin // Deprec #1
      if SameText(AppEnv.CompanyPrefs.DepreciationCalcStart1, 'Financial Year') then begin
      // "Financial Year"
        Month := MonthNameToNumber(AppEnv.CompanyPrefs.FiscalYearStarts);
        if Month < 12 then
          result := EncodeDate(StrToInt(PriorAccumDeprecDate), Month, 1)
        else
          result := EncodeDate(StrToInt(PriorAccumDeprecDate) + 1, Month, 1);
      end
      else begin // "Calendar Year"
        result := EncodeDate(StrToInt(PriorAccumDeprecDate) + 1, 1, 1);
      end;
    end
    else begin // Deprec #2
      if SameText(AppEnv.CompanyPrefs.DepreciationCalcStart2, 'Financial Year') then begin
      // "Financial Year"
        Month := MonthNameToNumber(AppEnv.CompanyPrefs.FiscalYearStarts);
        if Month < 12 then
          result := EncodeDate(StrToInt(PriorAccumDeprecDate), Month, 1)
        else
          result := EncodeDate(StrToInt(PriorAccumDeprecDate) + 1, Month, 1);
      end
      else begin // "Calendar Year"
        result := EncodeDate(StrToInt(PriorAccumDeprecDate) + 1, 1, 1);
      end;
    end;
  end;

begin

  if (UsePriorAccumDeprec) and Empty(PriorAccumDeprecDate) then
    exit;
  PurchaseDate := PurchDate;
  PriorAccumDeprecAmount := PriorAccumDeprecAmt;
  ExitOnDisposalDate := False;
  TempDateDay := 1;

  FADObj.deleteall;

  if not IsMonthly(DepreciationNo) and
    (PurchaseDate > EncodeDate(YearOf(PurchaseDate),
    GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1)) then begin
    PurchaseDate := IncYear(PurchaseDate, 1);
  end;

  if IsYearly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then begin
    PurchaseDate := IncYear(PurchaseDate, 1);
  end;

  MonthStart := 0;
  MonthsLeft := 12;
  LastDepreciationTotal := 0;
  if CheckDepreciationParameters then
    exit;
  ResetgrdDepreciationCalcs(DepreciationNo);

  { Straight Line Depreciation }
  if DepreciationOption = 'Straight Line Depreciation' then begin
    if (UsePriorAccumDeprec) then begin
      // 2014-04-15 changes to use correct year start
      PurchaseDate := DateStartForPriorAccum;
      ADLife := YearOf(PurchaseDate) - YearOf(PurchDate);
      PriorAccumDeprecMonth := MonthOf(PurchaseDate);
      if IsIncludeMonthofPurchase(DepreciationNo) then
        PurchaseDate := IncMonth(PurchaseDate, 1);

      // ADLife := FastFuncs.StrToInt(PriorAccumDeprecDate) - (YearOf(PurchaseDate));
      // PurchaseDate := IncYear(PurchaseDate, ADLife);
      // PriorAccumDeprecMonth := MonthOf(PurchaseDate);
      // if IsIncludeMonthofPurchase(DepreciationNo) then PriorAccumDeprecMonth := PriorAccumDeprecMonth - 1;
    end
    else begin
      ADLife := 0;
      PriorAccumDeprecAmount := 0.00;
      PriorAccumDeprecMonth := 0;
    end;
    // Life
    Life := (System.Round(AssetLife) - ADLife);
    LifeCycles := Life;
    if IsYearly(DepreciationNo) then
      LifeCycles := Life - 1;
    if (UsePriorAccumDeprec) and IsMonthly(DepreciationNo) then
      Life := Life - 1;
    DepreciationTotal := 0.00;

    for I := 0 to LifeCycles do begin
      if IsMonthly(DepreciationNo) then begin
        // Start Month
        if (I = 0) then begin
          MonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then
            MonthStart := MonthStart - 1;
        end
        else begin
          MonthStart := 1; // MontStartBasedOnPrefs;
        end;
        // Months Left
        if (I = 0) then begin
          MonthsLeft := 12 - MonthStart;
        end
        else if (I = LifeCycles) then begin
          TempMonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then
            TempMonthStart := TempMonthStart - 1;
          MonthsLeft := 12 - TempMonthStart;
          MonthsLeft := 12 - MonthsLeft;
        end
        else begin
          MonthsLeft := 12;
        end;
        DepreciationCycles := MonthsLeft;
      end
      else begin
        DepreciationCycles := 1;
      end;

      // Year Period
      Year := IntToStr(YearOf(IncYear(PurchaseDate, I)));

      // Period's Depreciation
      if (UsePriorAccumDeprec) and IsMonthly(DepreciationNo) then begin
        if (I = LifeCycles) then begin
          Depreciation := (DivZer(((PurchaseCost - SalvageValue) - PriorAccumDeprecAmount),
            Life + (PriorAccumDeprecMonth / 12)) * (PriorAccumDeprecMonth / 12) *
            (BusinessUsePercent / 100));
        end
        else begin
          Depreciation := (DivZer(((PurchaseCost - SalvageValue) - PriorAccumDeprecAmount),
            Life + (PriorAccumDeprecMonth / 12)) * (BusinessUsePercent / 100));
        end;
      end
      else begin
        if IsMonthly(DepreciationNo) then begin
          if (I = 0) or (I = LifeCycles) then begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount), Life) *
              (MonthsLeft / 12) * (BusinessUsePercent / 100));
          end
          else begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount), Life) *
              (BusinessUsePercent / 100));
          end;
        end
        else if IsHalfYearly(DepreciationNo) then begin
          if (UsePriorAccumDeprec) then begin
            LifeTemp := Life - 0.5;
          end
          else begin
            LifeTemp := Life;
          end;
          if (I = 0) or (I = LifeCycles) or
            (Disposal and (YearOf(DisposalDate) = FastFuncs.StrToInt(Year))) then begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount),
              LifeTemp) * (1 / 2) * (BusinessUsePercent / 100));
          end
          else begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount),
              LifeTemp) * (BusinessUsePercent / 100));
          end;
        end
        else begin
          if (UsePriorAccumDeprec) then begin
            LifeTemp := Life - 1;
          end
          else begin
            LifeTemp := Life;
          end;
          Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount), LifeTemp)
            * (BusinessUsePercent / 100));
        end;
      end;

      if UsePriorAccumDeprec then begin
        DepreciationTotal := DepreciationTotal + Depreciation;
        // end;
        if (I = LifeCycles) and IsMonthly(DepreciationNo) then begin
          DepreciationCycles := PriorAccumDeprecMonth;
          MonthStart := 1;
          MonthsLeft := PriorAccumDeprecMonth;
        end;
      end
      else begin
        DepreciationTotal := DepreciationTotal + Depreciation;
      end;

      // Populate obj
      for C := 1 to DepreciationCycles do begin
        FADObj.new;
        FADObj.Year := Year;
        if IsMonthly(DepreciationNo) then begin
          if (C = 1) and (I = 0) then
            MonthStart := MonthStart + 1;
          FADObj.MonthNo := MonthStart;
          MonthStart := MonthStart + 1;
          FADObj.Month := GetMonthName(FADObj.MonthNo);
          TempDateDay := DayOf(PurchaseDate);
        end
        else if IsHalfYearly(DepreciationNo) then begin
          FADObj.MonthNo := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          FADObj.Month := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end
        else if IsYearly(DepreciationNo) then begin
          FADObj.MonthNo := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          FADObj.Month := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end;
        // Date
        tmpTempDateDay := TempDateDay; // This For 31th Date Of Purchase to find end of each month
        while not TryEncodeDate(StrToInt(FADObj.Year), FADObj.MonthNo, tmpTempDateDay, TempDate) do
        begin
          tmpTempDateDay := tmpTempDateDay - 1;
        end;
        FADObj.Date := EncodeDate(StrToInt(FADObj.Year), FADObj.MonthNo, tmpTempDateDay);

        // Depreciation
        if IsMonthly(DepreciationNo) then begin
          FADObj.Depreciation := Depreciation * (1 / MonthsLeft);
        end
        else begin
          FADObj.Depreciation := Depreciation;
        end;
        // Total Depreciation
        if IsMonthly(DepreciationNo) then begin
          FADObj.TotalDepreciation := LastDepreciationTotal +
            ((DepreciationTotal - LastDepreciationTotal) * (C / MonthsLeft));;
          // end;
        end
        else begin
          FADObj.TotalDepreciation := DepreciationTotal;
        end;

        // Book Value
        FADObj.BookValue := (PurchaseCost - FADObj.TotalDepreciation);
        FADObj.Postdb;

        // Disposal of Asset
        if (DepreciationNo = 1) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then
            DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then
            DisposalMonth := DisposalMonth - 1;

          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
          then begin
            FixedAssets.DisposalBookValue := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end
          else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
            and (DisposalMonth = FADObj.MonthNo) then begin
            FixedAssets.DisposalBookValue := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end;
        end
        else if (DepreciationNo = 2) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then
            DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then
            DisposalMonth := DisposalMonth - 1;
          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
          then begin
            FixedAssets.DisposalBookValue2 := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec2 := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end
          else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
            and (DisposalMonth = FADObj.MonthNo) then begin
            FixedAssets.DisposalBookValue2 := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec2 := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end;
        end;
      end;

      if ExitOnDisposalDate then
        Break;

      if IsMonthly(DepreciationNo) then begin
        LastDepreciationTotal := FADObj.TotalDepreciation;
      end;
    end;
    // Get first record.
    FADObj.First;
  end;
  { ########################## }
  { Declining Balance }
  if DepreciationOption = 'Declining Balance' then begin
    if (UsePriorAccumDeprec) then begin
      // 2014-04-15 changes to use correct year start
      PurchaseDate := DateStartForPriorAccum;
      ADLife := YearOf(PurchaseDate) - YearOf(PurchDate);
      PriorAccumDeprecMonth := MonthOf(PurchaseDate);
      if IsIncludeMonthofPurchase(DepreciationNo) then
        PurchaseDate := IncMonth(PurchaseDate, 1);

      // ADLife := FastFuncs.StrToInt(Trim(PriorAccumDeprecDate)) - YearOf(PurchaseDate);
      // PurchaseDate := IncYear(PurchaseDate, ADLife);
      // PriorAccumDeprecMonth := MonthOf(PurchaseDate);
      // if IsIncludeMonthofPurchase(DepreciationNo) then PriorAccumDeprecMonth := PriorAccumDeprecMonth - 1;
    end
    else begin
      ADLife := 0;
      PriorAccumDeprecAmount := 0.00;
      PriorAccumDeprecMonth := 0;
    end;
    // Life
    Life := (System.Round(AssetLife) - ADLife);
    LifeCycles := Life;
    if IsYearly(DepreciationNo) then
      LifeCycles := Life - 1;
    DepreciationTotal := 0.00;

    for I := 0 to LifeCycles do begin
      if IsMonthly(DepreciationNo) then begin
        // Start Month
        if (I = 0) then begin
          MonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then
            MonthStart := MonthStart - 1;
        end
        else begin
          MonthStart := 1; // MontStartBasedOnPrefs;
        end;
        // Months Left
        if (I = 0) then begin
          MonthsLeft := 12 - MonthStart;
        end
        else if (I = LifeCycles) then begin
          TempMonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then
            TempMonthStart := TempMonthStart - 1;
          MonthsLeft := 12 - TempMonthStart;
          MonthsLeft := 12 - MonthsLeft;
        end
        else begin
          MonthsLeft := 12;
        end;
        DepreciationCycles := MonthsLeft;
      end
      else begin
        DepreciationCycles := 1;
      end;

      // Year Period
      Year := IntToStr(YearOf(IncYear(PurchaseDate, I)));
      Life := System.Round(AssetLife);

      // Period's Depreciation
      if (UsePriorAccumDeprec) and IsMonthly(DepreciationNo) then begin
        if (I = LifeCycles) then begin
          DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
          Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
            (MonthsLeft / 12) * (BusinessUsePercent / 100);
        end
        else begin
          DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
          Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
            (BusinessUsePercent / 100);
        end;
      end
      else begin
        if IsMonthly(DepreciationNo) then begin
          if (I = 0) or (I = LifeCycles) then begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
              (MonthsLeft / 12) * (BusinessUsePercent / 100);
          end
          else begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
              (BusinessUsePercent / 100);
          end;
        end
        else if IsHalfYearly(DepreciationNo) then begin
          if (I = 0) or (I = LifeCycles) or
            (Disposal and (YearOf(DisposalDate) = FastFuncs.StrToInt(Year))) then begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) * (1 / 2)
              * (BusinessUsePercent / 100);
          end
          else begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
              (BusinessUsePercent / 100);
          end;
        end
        else begin
          DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
          Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
            (BusinessUsePercent / 100);
        end;
      end;
      if UsePriorAccumDeprec then begin
        DepreciationTotal := DepreciationTotal + Depreciation;
        if (I = LifeCycles) and IsMonthly(DepreciationNo) then begin
          DepreciationCycles := PriorAccumDeprecMonth;
          MonthStart := 1;
          MonthsLeft := PriorAccumDeprecMonth;
        end;
      end
      else begin
        DepreciationTotal := DepreciationTotal + Depreciation;
      end;
      // Calcs to MemTable
      for C := 1 to DepreciationCycles do begin
        FADObj.new;
        FADObj.Year := Year;
        // Month
        if IsMonthly(DepreciationNo) then begin
          if (C = 1) and (I = 0) then
            MonthStart := MonthStart + 1;
          FADObj.MonthNo := MonthStart;
          MonthStart := MonthStart + 1;
          FADObj.Month := GetMonthName(FADObj.MonthNo);
          TempDateDay := DayOf(PurchaseDate);
        end
        else if IsHalfYearly(DepreciationNo) then begin
          FADObj.MonthNo := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          FADObj.Month := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end
        else if IsYearly(DepreciationNo) then begin
          FADObj.MonthNo := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          FADObj.Month := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end;
        // Date
        tmpTempDateDay := TempDateDay; // This For 31th Date Of Purchase to find end of each month
        while not TryEncodeDate(StrToInt(FADObj.Year), FADObj.MonthNo, tmpTempDateDay, TempDate) do
        begin
          tmpTempDateDay := tmpTempDateDay - 1;
        end;
        FADObj.Date := EncodeDate(StrToInt(FADObj.Year), FADObj.MonthNo, tmpTempDateDay);

        // Depreciation
        if IsMonthly(DepreciationNo) then begin
          FADObj.Depreciation := Depreciation * (1 / MonthsLeft);
        end
        else begin
          FADObj.Depreciation := Depreciation;
        end;
        // Total Depreciation
        if IsMonthly(DepreciationNo) then begin
          FADObj.TotalDepreciation := LastDepreciationTotal +
            ((DepreciationTotal - LastDepreciationTotal) * (C / MonthsLeft));;
          // end;
        end
        else begin
          FADObj.TotalDepreciation := DepreciationTotal;
        end;
        // Book Value
        FADObj.BookValue := (PurchaseCost - FADObj.TotalDepreciation);
        FADObj.Postdb;

        // Disposal of Asset
        if (DepreciationNo = 1) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then
            DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then
            DisposalMonth := DisposalMonth - 1;
          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
          then begin
            FixedAssets.DisposalBookValue := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end
          else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
            and (DisposalMonth = FADObj.MonthNo) then begin
            FixedAssets.DisposalBookValue := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end;
        end
        else if (DepreciationNo = 2) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then
            DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then
            DisposalMonth := DisposalMonth - 1;
          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
          then begin
            FixedAssets.DisposalBookValue2 := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec2 := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end
          else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = StrToInt(FADObj.Year))
            and (DisposalMonth = FADObj.MonthNo) then begin
            FixedAssets.DisposalBookValue2 := FADObj.BookValue;
            FixedAssets.DisposalAccumDeprec2 := FADObj.TotalDepreciation;
            ExitOnDisposalDate := true;
            Break;
          end;
        end;
      end;
      if ExitOnDisposalDate then
        Break;
      if IsMonthly(DepreciationNo) then begin
        LastDepreciationTotal := FADObj.TotalDepreciation;
      end;
    end;
    FADObj.First;
  end;
  ResetgrdDepreciationCalcs(DepreciationNo);
  FADObj.DataSet.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]),
    [loCaseInsensitive]);
  CheckDatesDay;
end;

function TfmFixedAsset.IsMonthly(const DepreciationNo: integer): Boolean;
begin
  result := False;
  if (DepreciationNo = 1) then begin
    result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Month');
  end
  else if (DepreciationNo = 2) then begin
    result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Full Month');
  end;
end;

function TfmFixedAsset.IsYearly(const DepreciationNo: integer): Boolean;
begin
  result := False;
  if (DepreciationNo = 1) then begin
    result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Year');
  end
  else if (DepreciationNo = 2) then begin
    result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Full Year');
  end;
end;

function TfmFixedAsset.IsHalfYearly(const DepreciationNo: integer): Boolean;
begin
  result := False;
  if (DepreciationNo = 1) then begin
    result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Half Year');
  end
  else if (DepreciationNo = 2) then begin
    result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Half Year');
  end;
end;

function TfmFixedAsset.IsExcludeMonthofPurchase(const DepreciationNo: integer): Boolean;
begin
  result := False;
  if (DepreciationNo = 1) then begin
    result := (AppEnv.CompanyPrefs.MonthofPurchase1 = 'Exclude');
  end
  else if (DepreciationNo = 2) then begin
    result := (AppEnv.CompanyPrefs.MonthofPurchase2 = 'Exclude');
  end;
end;

function TfmFixedAsset.IsIncludeMonthofPurchase(const DepreciationNo: integer): Boolean;
begin
  result := False;
  if (DepreciationNo = 1) then begin
    result := (AppEnv.CompanyPrefs.MonthofPurchase1 = 'Include');
  end
  else if (DepreciationNo = 2) then begin
    result := (AppEnv.CompanyPrefs.MonthofPurchase2 = 'Include');
  end;
end;

function TfmFixedAsset.CheckDepreciationParameters: Boolean;
begin
  result := False;

  // New Asset Not Posted
  if (qryAssetAssetID.AsInteger <= 0) then
    exit;

  // No Purchase Date
  if (qryAssetPurchDate.AsDateTime <= 0) then
    exit;

  // No Purchase Cost
  if (qryAssetPurchCost.AsFloat <> 0.00) then
    exit;

  // No Depreciation Option
  if Empty(cboDepreciationOption.Text) then
    exit;

  // No Asset Prior Depreciation Date
  if qryAssetPriorAccumDeprec.AsBoolean and Empty(qryAssetPriorAccumDeprecDate.AsString) then
    exit;

  result := true;
end;

procedure TfmFixedAsset.RefreshPic(DataSet: TDataSet);
begin
  ImagesLib.RefreshDsImage(DataSet, 'Image', 'Imagetype', ImgImages, pnlImage, pnlPicturetype);
end;

procedure TfmFixedAsset.InitERPLookupCombonFields;
begin
  inherited;
  NamenPrintNameGridObj.ProductLookupQueryWithSearchengine(cboHireProduct, 'PARTSDESCRIPTION', True , True, 'HirePrintProductname',true , nil, true);
end;

initialization

RegisterClassOnce(TfmFixedAsset);
with FormFact do begin
  RegisterMe(TfmFixedAsset, 'TReminderListGUI_*_Fixed Asset Insurance due to Expire=ID');
  RegisterMe(TfmFixedAsset, 'TReminderListGUI_*_Fixed Asset Warranty due to Expire=ID');
  RegisterMe(TfmFixedAsset, 'TfrmFixedAssetsDetails_*=AssetID');
  RegisterMe(TfmFixedAsset, 'TFixedAssetsListGUI_*=AssetID');
  RegisterMe(TfmFixedAsset, 'TAssetRegisterListGUI_*=AssetID');
  RegisterMe(TfmFixedAsset, 'TCheckWarranty_InsurancePolicyGUI_*=AssetID');
  RegisterMe(TfmFixedAsset, 'TTransAccountDetailsGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TBalTransListGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TToBeReconciledGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TReconListDetailFormGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TTrialBalTransListGUI_*_Fixed Asset=FixedAssetID');

  RegisterMe(TfmFixedAsset, 'TTransactionListGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TBASTransReturnListGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TNZTransReturnListGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TVATTransReturnListGUI_*_Fixed Asset=FixedAssetID');

  RegisterMe(TfmFixedAsset, 'TGlobalsearchGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TGeneralLedgerReportGUI_*_Fixed Asset=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TTransAccountDetailsGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TBalTransListGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TToBeReconciledGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TReconListDetailFormGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TTrialBalTransListGUI_*_Fixed Asset Depreciation=FixedAssetID');

  RegisterMe(TfmFixedAsset, 'TTransactionListGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TBASTransReturnListGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TNZTransReturnListGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TVATTransReturnListGUI_*_Fixed Asset Depreciation=FixedAssetID');

  RegisterMe(TfmFixedAsset, 'TGlobalsearchGUI_*_Fixed Asset Depreciation=FixedAssetID');
  RegisterMe(TfmFixedAsset, 'TGeneralLedgerReportGUI_*_Fixed Asset Depreciation=FixedAssetID');
end;

end.
