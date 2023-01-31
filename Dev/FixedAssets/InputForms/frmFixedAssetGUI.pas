unit frmFixedAssetGUI;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 10/08/05 1.00.01  DSP  The customised labels were not displaying the entered
                        text. This was due to the fields width and size being
                        set to 11 when they should have 16.
 07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
 19/10/05 1.00.03  MV   Added support for parent assets.
 20/10/05  1.00.04 DLS  Added RegisterClass
 19/12/05  1.00.05 AL   Removed "Instance"  *Task306*
 09/01/06  1.00.06 BJ   Saving a serial number as fixed asset was assigning it
                        'For Hire' automatically, Changed to update it after
                        a user confirmation.
 31/01/06  1.00.07 AL   Now make post for new records to obtain new ID used for childassets
                        ChildAssets.OnNewRecord - sets childs parentid to current id
 14/02/06  1.00.08 AL   Changed class combo to grid                    
                       }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, DNMPanel, StdCtrls, wwcheckbox,
  Buttons, DNMSpeedButton, SelectionDialog, AppEvnts, DB,   ComCtrls,AdvOfficeStatusBar, wwdblook, Mask,
  DBCtrls, wwdbdatetimepicker, wwdbedit, Wwdotdot, Wwdbcomb, Wwdbspin,
  Grids, Wwdbigrd, Wwdbgrid, kbmMemTable, BaseListingForm, MemDS, DBAccess,
  MyAccess,ERPdbComponents, ActnList, DataState, Menus, AdvMenus, Shader, ImgList,
  wwSpeedButton, wwDBNavigator, wwclearpanel, ProgressDialog, frmAttachments, pngimage,
  ERPDbLookupCombo;

type
  TFixedAssetGUI = class(TBaseInputGUI)
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    PageControl1: TPageControl;
    Depreciation1: TTabSheet;
    Custom_Fields: TTabSheet;
    Notes: TTabSheet;
    qryAsset: TERPQuery;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    AssetInfo: TTabSheet;
    DNMPanel6: TDNMPanel;
    grdDepreciationCalcs1: TwwDBGrid;
    cboClassQry: TERPQuery;
    btnCalculate: TDNMSpeedButton;
    MemoNotes: TDBMemo;
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
    DSDepreciationCalcs1: TDataSource;
    qryfixedassettypes: TERPQuery;
    Disposal: TTabSheet;
    DNMPanel5: TDNMPanel;
    Bevel8: TBevel;
    Label28: TLabel;
    Label29: TLabel;
    SalesPrice: TDBEdit;
    cboDisposalDate: TwwDBDateTimePicker;
    Label34: TLabel;
    Label35: TLabel;
    DisposalAccumDeprec: TDBEdit;
    DisposalBookValue: TDBEdit;
    DisposalCalculate: TDNMSpeedButton;
    Bevel7: TBevel;
    Label30: TLabel;
    qryAssetAssetID: TAutoIncField;
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
    DisposalofAsset: TwwCheckBox;
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
    BusinessUsePercent: TDBEdit;
    Label26: TLabel;
    PriorAccumDeprec: TwwCheckBox;
    Label31: TLabel;
    Label32: TLabel;
    PriorAccumDeprecAmount: TDBEdit;
    Label33: TLabel;
    PriorAccumDeprecDate: TDBEdit;
    Bevel9: TBevel;
    qryAssetPriorAccumDeprec: TWideStringField;
    qryAssetPriorAccumDeprecDate: TWideStringField;
    qryAssetPriorAccumDeprecAmount: TFloatField;
    qryDepreciationCalcs1: TERPQuery;
    cmdNewServiceLog: TDNMSpeedButton;
    qryAssetColour: TWideStringField;
    qryAssetSize: TWideStringField;
    qryAssetShape: TWideStringField;
    cmdPrint: TDNMSpeedButton;
    DSAsset: TDataSource;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cboAssetType: TwwDBLookupCombo;
    AssetCode: TDBEdit;
    AssetName: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    cboPurchDate: TwwDBDateTimePicker;
    PurchCost: TDBEdit;
    Serial: TDBEdit;
    Bevel2: TBevel;
    Label19: TLabel;
    cboClass: TwwDBLookupCombo;
    LocationDescription: TDBEdit;
    Bevel3: TBevel;
    Label11: TLabel;
    lblSalvage: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SalvageFactor: TDBEdit;
    Salvage: TDBEdit;
    Life: TDBEdit;
    cboDepreciationOption: TwwDBComboBox;
    cboSalvageType: TwwDBComboBox;
    tabHistory: TTabSheet;
    pnlHistory: TDNMPanel;
    grpHistory: TRadioGroup;
    pnlCustFields: TDNMPanel;
    Box181: TBevel;
    Label179: TLabel;
    Bevel14: TBevel;
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
    Label39: TLabel;
    Bevel11: TBevel;
    cboAccountQry: TERPQuery;
    qryAssetClearingAccountName: TWideStringField;
    qryAssetClearingAccountID: TIntegerField;
    Label41: TLabel;
    cboFixedAssetsClearingAccount: TwwDBLookupCombo;
    Bevel12: TBevel;
    Label42: TLabel;
    cboFixedAssetsAccount: TwwDBLookupCombo;
    memDepreciationCalcs1: TkbmMemTable;
    qryAssetGlobalRef: TWideStringField;
    qryAssetActive: TWideStringField;
    qryAssetEditedFlag: TWideStringField;
    qryAssetPARTNAME: TWideStringField;
    qryAssetPARTSID: TIntegerField;
    Bevel15: TBevel;
    Label44: TLabel;
    cboFixedAssetsDepreciationAccount: TwwDBLookupCombo;
    qryAssetFixedAssetDepreciationAccountName: TWideStringField;
    qryAssetFixedAssetDepreciationAccountID: TIntegerField;
    Label40: TLabel;
    chkActive: TwwCheckBox;
    memDepreciationCalcs1AssetDepreciationID: TAutoIncField;
    memDepreciationCalcs1AssetID: TIntegerField;
    memDepreciationCalcs1Year: TWideStringField;
    memDepreciationCalcs1Month: TWideStringField;
    memDepreciationCalcs1MonthNo: TIntegerField;
    memDepreciationCalcs1Depreciation: TFloatField;
    memDepreciationCalcs1TotalDepreciation: TFloatField;
    memDepreciationCalcs1BookValue: TFloatField;
    memDepreciationCalcs1Date: TDateField;
    tabAdditionalInfo: TTabSheet;
    DNMPanel2: TDNMPanel;
    Bevel5: TBevel;
    Label17: TLabel;
    Label18: TLabel;
    Label27: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Shape: TDBEdit;
    InsurancePolicy: TDBEdit;
    InsuredBy: TDBEdit;
    cboInsuredUntil: TwwDBDateTimePicker;
    Colour: TDBEdit;
    Size: TDBEdit;
    Bevel6: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    WarrantyType: TDBEdit;
    cboWarrantyExpiresDate: TwwDBDateTimePicker;
    qryAssetSupplierName: TWideStringField;
    qryAssetSupplierID: TIntegerField;
    qryAssetBARCODE: TWideStringField;
    cboClient: TwwDBLookupCombo;
    Label45: TLabel;
    Bevel16: TBevel;
    Label227: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    qryDepreciationCalcs2: TERPQuery;
    qryDepreciationCalcs1AssetDepreciationID: TAutoIncField;
    qryDepreciationCalcs1AssetID: TIntegerField;
    qryDepreciationCalcs1Year: TWideStringField;
    qryDepreciationCalcs1Month: TWideStringField;
    qryDepreciationCalcs1MonthNo: TIntegerField;
    qryDepreciationCalcs1Depreciation: TFloatField;
    qryDepreciationCalcs1TotalDepreciation: TFloatField;
    qryDepreciationCalcs1BookValue: TFloatField;
    qryDepreciationCalcs1Date: TDateField;
    qryDepreciationCalcs2AssetDepreciationID: TAutoIncField;
    qryDepreciationCalcs2AssetID: TIntegerField;
    qryDepreciationCalcs2Year: TWideStringField;
    qryDepreciationCalcs2Month: TWideStringField;
    qryDepreciationCalcs2MonthNo: TIntegerField;
    qryDepreciationCalcs2Depreciation: TFloatField;
    qryDepreciationCalcs2TotalDepreciation: TFloatField;
    qryDepreciationCalcs2BookValue: TFloatField;
    qryDepreciationCalcs2Date: TDateField;
    Depreciation2: TTabSheet;
    DNMPanel7: TDNMPanel;
    Bevel18: TBevel;
    Label48: TLabel;
    Label52: TLabel;
    lblSalvage2: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    grdDepreciationCalcs2: TwwDBGrid;
    btnCalculate2: TDNMSpeedButton;
    BusinessUsePercent2: TDBEdit;
    SalvageFactor2: TDBEdit;
    Salvage2: TDBEdit;
    Life2: TDBEdit;
    cboDepreciationOption2: TwwDBComboBox;
    cboSalvageType2: TwwDBComboBox;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    SalesPrice2: TDBEdit;
    cboDisposalDate2: TwwDBDateTimePicker;
    DisposalAccumDeprec2: TDBEdit;
    DisposalBookValue2: TDBEdit;
    DisposalCalculate2: TDNMSpeedButton;
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
    Label63: TLabel;
    Label65: TLabel;
    memDepreciationCalcs2: TkbmMemTable;
    DSDepreciationCalcs2: TDataSource;
    memDepreciationCalcs2Year: TWideStringField;
    memDepreciationCalcs2Month: TWideStringField;
    memDepreciationCalcs2Depreciation: TFloatField;
    memDepreciationCalcs2TotalDepreciation: TFloatField;
    memDepreciationCalcs2BookValue: TFloatField;
    memDepreciationCalcs2AssetDepreciationID: TAutoIncField;
    memDepreciationCalcs2AssetID: TIntegerField;
    memDepreciationCalcs2MonthNo: TIntegerField;
    memDepreciationCalcs2Date: TDateField;
    btnAddDateTime: TDNMSpeedButton;
    cboFixedAssetDepreciationAccountName: TwwDBLookupCombo;
    Label64: TLabel;
    qryAssetFixedAssetCostAccountName: TWideStringField;
    qryAssetFixedAssetCostAccountID: TIntegerField;
    qryAssetFixedAssetCostAccountName2: TWideStringField;
    qryAssetFixedAssetCostAccountID2: TIntegerField;
    qryAssetFixedAssetDepreciationAssetAccountName: TWideStringField;
    qryAssetFixedAssetDepreciationAssetAccountID: TIntegerField;
    qryAssetFixedAssetDepreciationAssetAccountName2: TWideStringField;
    qryAssetFixedAssetDepreciationAssetAccountID2: TIntegerField;
    Bevel13: TBevel;
    Label49: TLabel;
    cboFixedAssetAccountName2: TwwDBLookupCombo;
    Label50: TLabel;
    cboClearingAccountName2: TwwDBLookupCombo;
    Label51: TLabel;
    cboFixedAssetDepreciationAssetAccountName2: TwwDBLookupCombo;
    Label56: TLabel;
    cboFixedAssetDepreciationAccountName2: TwwDBLookupCombo;
    Bevel19: TBevel;
    PriorAccumDeprec2: TwwCheckBox;
    Label57: TLabel;
    Label58: TLabel;
    Bevel20: TBevel;
    PriorAccumDeprecDate2: TDBEdit;
    PriorAccumDeprecAmount2: TDBEdit;
    Label66: TLabel;
    Bevel4: TBevel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Status: TDBEdit;
    Qty: TwwDBSpinEdit;
    EstimatedValue: TDBEdit;
    ReplacementCost: TDBEdit;
    Label85: TLabel;
    Label43: TLabel;
    txtBarcode: TDBEdit;
    cboProduct: TwwDBLookupCombo;
    btnProductBarcode: TDNMSpeedButton;
    Bevel17: TBevel;
    qryParts: TERPQuery;
    btnProductSerial: TDNMSpeedButton;
    qryPartsPARTSID: TIntegerField;
    qryPartsPARTNAME: TWideStringField;
    btnClone: TDNMSpeedButton;
    dlgSerialSelect: TSelectionDialog;
    cboClientLookup: TERPQuery;
    FAactionList: TActionList;
    actFAClone: TAction;
    CUSTLBL16: TLabel;
    CUSTFLD16: TwwDBDateTimePicker;
    CUSTLBL17: TLabel;
    CUSTFLD17: TwwDBDateTimePicker;
    CUSTLBL18: TLabel;
    CUSTFLD18: TwwDBDateTimePicker;
    qryAssetCUSTDATE1: TDateTimeField;
    qryAssetCUSTDATE2: TDateTimeField;
    qryAssetCUSTDATE3: TDateTimeField;
    qryCustomFieldsCFLabel16: TWideStringField;
    qryCustomFieldsCFLabel17: TWideStringField;
    qryCustomFieldsCFLabel18: TWideStringField;
    qryCustomFieldsCFAssets16: TWideStringField;
    qryCustomFieldsCFAssets17: TWideStringField;
    qryCustomFieldsCFAssets18: TWideStringField;
    Label67: TLabel;
    wwDBLookupParentAssetID: TwwDBLookupCombo;
    Bevel23: TBevel;
    wwDBChildAssetGrid: TwwDBGrid;
    qryParentAssetLookup: TERPQuery;
    qryAssetParentID: TIntegerField;
    qryAssetParentAssetName: TWideStringField;
    qryChildAssets: TERPQuery;
    DSChildAssets: TDataSource;
    Label68: TLabel;
    TotalChildAssets: TDBEdit;
    qryAssetTotalChildAsset: TFloatField;
    qryChildAssetsAssetName: TWideStringField;
    qryChildAssetsPurchCost: TFloatField;
    qryChildAssetsParentID: TIntegerField;
    Manufacture: TDBEdit;
    BrandName: TDBEdit;
    Bevel1: TBevel;
    Model: TDBEdit;
    Condition: TDBEdit;
    Label22: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    qryFAPercentages: TERPQuery;
    dsFAPercentages: TDataSource;
    qryFAPercentagesAssetPercentagesID: TIntegerField;
    qryFAPercentagesAssetID: TIntegerField;
    qryFAPercentagesClassID: TIntegerField;
    qryFAPercentagesCost: TFloatField;
    qryFAPercentagesDepreciation: TFloatField;
    qryFAPercentagesDescription: TWideStringField;
    qryFAPercentagesActive: TWideStringField;
    cboClassQryClassID: TAutoIncField;
    cboClassQryClassName: TWideStringField;
    cboClassQryClassPercent: TFloatField;
    qryFAPercentagesClassName: TWideStringField;
    grdFAPercentage: TwwDBGrid;
    grdFAPercentageIButton: TwwIButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryAssetAssetCondition: TWideStringField;
    cboAssetClass: TwwDBLookupCombo;
    LblClass: TLabel;
    qryAssetClass: TERPQuery;
    StringField1: TWideStringField;
    AutoIncField1: TAutoIncField;
    FloatField1: TFloatField;
    qryAssetClassID: TIntegerField;
    qryAssetLastTestDate: TDateField;
    qryAssetNextTestDate: TDateField;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Label9: TLabel;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    Label10: TLabel;
    tabPictures: TTabSheet;
    tabAttachments: TTabSheet;
    pnlImage: TDNMPanel;
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
    qryPictures: TERPQuery;
    dsPicture: TDataSource;
    qryPicturesAssetPictureId: TIntegerField;
    qryPicturesGlobalref: TWideStringField;
    qryPicturesAssetId: TIntegerField;
    qryPicturesImage: TBlobField;
    qryPicturesmsTimeStamp: TDateTimeField;
    qryPicturesmsUpdateSiteCode: TWideStringField;
    pnlAttachments: TPanel;
    qryAssetmsTimeStamp: TDateTimeField;
    qryAssetmsUpdateSiteCode: TWideStringField;
    qryPicturesImagetype: TWideStringField;
    pnlPicturetype: TDNMPanel;
    DBText1: TDBText;
    Label12: TLabel;
    ImgImages: TImage;
    qryAssetDepreciationStartDate: TDateField;
    Label53: TLabel;
    cboDepreciationStartDate: TwwDBDateTimePicker;
    lblDayMatch: TLabel;
    lblPercentInfo1: TLabel;
    lblPercentInfo2: TLabel;
    tabHire: TTabSheet;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cboDepreciationOptionChange(Sender: TObject);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure btnCalculateClick(Sender: TObject);
    procedure cboSalvageTypeChange(Sender: TObject);
    procedure PriorAccumDeprecClick(Sender: TObject);
    procedure cmdNewServiceLogClick(Sender: TObject);
    procedure DisposalofAssetClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure grpHistoryClick(Sender: TObject);
    procedure cboAssetTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryAssetPARTNAMEChange(Sender: TField);
    procedure qryAssetClearingAccountNameChange(Sender: TField);
    procedure qryAssetFixedAssetDepreciationAccountNameChange(Sender: TField);
    procedure cboPurchDateExit(Sender: TObject);
    procedure qryAssetPurchDateChange(Sender: TField);
    procedure chkDepreciateMonthlyClick(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnProductBarcodeClick(Sender: TObject);
    procedure qryAssetClearingAccountName2Change(Sender: TField);
    procedure qryAssetFixedAssetDepreciationAccountName2Change(Sender: TField);
    procedure cboDepreciationOption2Change(Sender: TObject);
    procedure btnCalculate2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure cboSalvageType2Change(Sender: TObject);
    procedure qryAssetFixedAssetCostAccountNameChange(Sender: TField);
    procedure qryAssetFixedAssetCostAccountName2Change(Sender: TField);
    procedure qryAssetFixedAssetDepreciationAssetAccountNameChange(Sender: TField);
    procedure qryAssetFixedAssetDepreciationAssetAccountName2Change(Sender: TField);
    procedure PriorAccumDeprec2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnProductSerialClick(Sender: TObject);
    procedure actFACloneUpdate(Sender: TObject);
    procedure actFACloneExecute(Sender: TObject);
    procedure wwDBLookupParentAssetIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryChildAssetsNewRecord(DataSet: TDataSet);
    procedure qryFAPercentagesClassNameChange(Sender: TField);
    procedure qryFAPercentagesNewRecord(DataSet: TDataSet);
    procedure grdFAPercentageIButtonClick(Sender: TObject);
    procedure qryFAPercentagesAfterPost(DataSet: TDataSet);
    procedure grdFAPercentageColExit(Sender: TObject);
    procedure cboDepreciationOptionCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboDepreciationOption2CloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure btnAddPicClick(Sender: TObject);
    procedure btnStretchClick(Sender: TObject);
    procedure qryPicturesAfterInsert(DataSet: TDataSet);
    procedure qryPicturesAfterPost(DataSet: TDataSet);
    procedure qryAssetAfterOpen(DataSet: TDataSet);
    procedure qryPicturesBeforeDelete(DataSet: TDataSet);
    procedure qryAssetAfterPost(DataSet: TDataSet);
    procedure qryPicturesAfterOpen(DataSet: TDataSet);
    procedure qryPicturesAfterScroll(DataSet: TDataSet);
    procedure grdDepreciationCalcs1CalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cboDepreciationStartDateExit(Sender: TObject);

  private
    { Private declarations }
    bFromSerialNumbersForm: boolean;
    iSerialPartID: integer;
    iPurchaseLineID: integer;
    slSerialNumberList: TStringList;
    
    PurchDateChangedFlag: boolean;
    ffrmList0: TBaseListingGUI;
    fFixedAssetREpairList: TBaseListingGUI;
//    ffrmList1: TBaseListingGUI;
    fAttachmentForm : TfmAttachments;
    fCleanPurchDate: TDateTime;
    fCleanDepreciationStartDate: TDateTime;
    procedure DeleteOldDepreciationDetails(const DepreciationNo: integer; const AssetID: integer);
    procedure CalculateDepreciation(const MemTable: TkbmMemTable; const DepreciationNo: integer;
      const AssetID: integer; const DepreciationOption: string; const PurchDate: TDateTime;
      const PurchaseCost, SalvagePercent, SalvageValue, AssetLife: double; const UsePriorAccumDeprec: string;
      const PriorAccumDeprecAmt: double; const PriorAccumDeprecDate: string; const BusinessUsePercent: double;
      const Disposal: boolean; const DisposalDate: TDateTime);
    function ChkAssetsReqdFields: boolean;
    function ChkAssetsReqdAccounts: boolean;
    function IsMonthly(const DepreciationNo: integer): boolean;
    function IsYearly(const DepreciationNo: integer): boolean;
    function IsHalfYearly(const DepreciationNo: integer): boolean;
    function IsExcludeMonthofPurchase(const DepreciationNo: integer): boolean;
    function IsIncludeMonthofPurchase(const DepreciationNo: integer): boolean;
    procedure CopyMemDepreciationCalcsToTables(const DepreciationNo: integer);
    procedure RefreshDepreciationCalcsToMem(const DepreciationNo: integer);
    procedure ResetgrdDepreciationCalcs(const DepreciationNo: integer);
    procedure SaveTransaction;
    procedure CheckAccounts;
    function CheckDepreciationParameters: boolean;
    procedure SetDefaultAssetAccounts;
    procedure LoadSerials;//(const PartsID, ClassID: integer);
    function SaveFixedAsset: boolean;
    function CloneAsset(const SerialNo: string): integer;
    function CloneAssetDetails(const OldID, NewID, DepreciationNo: integer): boolean;
    function CalculateChildAssetTotals(KeyID: integer): double;
    procedure UpdateParentsTotalAsset(KeyID: integer; Value: double);
    procedure RemoveAssetCostFromParent(KeyID: integer; Value: double);
    procedure AddPercentageDefaultClassIfEmpty;
    procedure TotalsPercentages;
    Procedure qryAssetPost;
    Procedure qryAssetEdit;
    function ChkCustReqdFields: boolean;
    function AttachmentForm : TfmAttachments;
    procedure RefreshPic(DataSet: TDataSet);
    procedure CheckDates;
    procedure CheckDatesDay;
  Protected
    procedure CustomFieldsRefresh;Override;
    property CleanPurchDate: TDateTime read fCleanPurchDate;
    property CleanDepreciationStartDate: TDateTime read fCleanDepreciationStartDate;
  public
    { Public declarations }
    property FromSerialNumbersForm: boolean read bFromSerialNumbersForm write bFromSerialNumbersForm;
    property SerialPartID: integer read iSerialPartID write iSerialPartID;
    property SerialNumberList: TStringList read slSerialNumberList write slSerialNumberList;
    property PurchaseLineID: integer read iPurchaseLineID write iPurchaseLineID;
  end;

implementation

uses
  CommonDbLib, DNMLib, AuditObj, FormFactory, DNMExceptions, frmCustomFieldsFrm, DateUtils,
  frmFixedAssetServiceLogGUI, { HiredItemReport, RepairsListForm,} FixedAssetsServiceLogList,
    {FixedAssetProfitabilityList,}
  CommonLib, MyClasses, MySQLErrors, AppEnvironment, FastFuncs,
  ProductQtyLib, ImagesLib, BusObjDeletedItem, frmFixedAssetRepairList, BusObjPicture;

{$R *.dfm}
Procedure TFixedAssetGUI.qryAssetPost;
begin
    if QryAsset.State in [dsEdit,dsInsert] then QryAsset.Post;
end;
Procedure TFixedAssetGUI.qryAssetEdit;
begin
    if not(QryAsset.State in [dsEdit,dsInsert]) then QryAsset.Edit;
end;

procedure TFixedAssetGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFixedAssetGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not ErrorOccurred then CloseQueries;
  Action := caFree;
  inherited;
end;

procedure TFixedAssetGUI.FormShow(Sender: TObject);
var
  slEntries     : TStringList;
  oInfo         : TProductInfo;
  qry           : TERPQuery;
begin
  DisableForm;
  try
    Processingcursor(True);
    slEntries := TStringList.Create;
    qry := TERPQuery.Create(nil);
    try
      try
        inherited;
        if qryAsset.Active then begin
          if not (qryAsset.State in [dsBrowse]) then begin
            qryAssetPost;
            Notify;
          end;
          CloseQueries;
        end;
        qryAsset.ParamByName('ID').asInteger := KeyID;
        qryDepreciationCalcs1.ParamByName('ID').asInteger := KeyID;
        qryDepreciationCalcs2.ParamByName('ID').asInteger := KeyID;
        qryChildAssets.ParamByName('ID').asInteger := KeyID;
        qryParentAssetLookup.ParamByName('xID').asInteger := KeyID;
        qryFAPercentages.ParamByName('xAssetID').asInteger := KeyID;
        qryPictures.ParamByName('AssetId').AsInteger := KeyId;
        OpenQueries;

        if not MyConnection.intransaction then begin
          BeginTransaction;
        end;

        if KeyID = 0 then begin
          fCleanPurchDate := 0;
          fCleanDepreciationStartDate := 0;
          qryAsset.Insert;
          SetDefaultAssetAccounts;
          qryAsset.FieldByName('Active').AsString := 'T';
          // need to know new ID
          qryAssetPost;
          qryAssetEdit;
          qryChildAssets.Close;
          qryChildAssets.ParamByName('ID').AsInteger := qryAssetAssetID.AsInteger;
          qryChildAssets.Open;

          qryParentAssetLookup.Close;
          qryParentAssetLookup.ParamByName('xID').AsInteger := qryAssetAssetID.AsInteger;
          qryParentAssetLookup.Open;

          CloseDb(qryPictures);
          qryPictures.ParamByName('AssetId').AsInteger := KeyId;
          OpenDb(qryPictures);

          qryFAPercentages.Close;
          qryFAPercentages.ParamByName('xAssetID').asInteger := KeyID;
          qryFAPercentages.Open;
          TotalsPercentages;

          // Has this form been called from the Serial List Form.
          if FromSerialNumbersForm then begin
            btnClone.Enabled := false;
            cmdNew.Enabled := false;
            chkActive.Enabled := false;
            slEntries.Clear;
            ExtractStrings(['|'], [' '], PChar(SerialNumberList.Strings[0]), slEntries);

            // First thing .. set the Asset product based on our given part.
            qryParts.Locate('PARTSID', SerialPartID, [loCaseInsensitive]);
            cboProduct.Text := qryParts.FieldByName('PartName').AsString;
            qryAssetEdit;
            qryAsset.FieldByName('PartName').AsString := qryParts.FieldByName('PartName').AsString;
            qryAsset.FieldByName('PartsID').AsInteger := SerialPartID;
            Serial.Text := slEntries.Strings[0];
            qryAsset.FieldByName('Serial').AsString := slEntries.Strings[0];
            cboClassQry.Locate('ClassName', slEntries.Strings[2], [loCaseInsensitive]);
            qryAsset.FieldByName('ClassID').AsInteger := FastFuncs.StrToInt(slEntries.Strings[3]);

            qryAsset.FieldByName('AssetName').AsString := GetPartName(SerialPartID);
            AssetName.Text := qryAsset.FieldByName('AssetName').AsString;
            qryAsset.FieldByName('AssetCondition').AsString := 'Excellent';
            Condition.Text := 'Excellent';

            qryAsset.FieldByName('Qty').AsInteger := 1;
            Qty.Value := 1;

            qry.Connection := CommonDbLib.GetSharedMyDacConnection;
            qry.ParamCheck := true;
            qry.SQL.Clear;
            qry.SQL.Add('SELECT * FROM tblpurchaseorders AS P');
            qry.SQL.Add('INNER JOIN tblpurchaselines AS PL Using(PurchaseOrderID)');
            qry.SQL.Add('WHERE PL.PurchaseLineID = :xID');
            qry.Params.ParamByName('xID').AsInteger := PurchaseLineID;
            qry.Open;

            if qry.RecordCount > 0 then begin
              qryAsset.FieldByName('PurchCost').AsFloat := qry.FieldByName('LineCostInc').AsFloat;

              qryAsset.FieldByName('PurchDate').AsDateTime := qry.FieldByName('DueDate').AsDateTime;
              cboPurchDate.DateTime := qry.FieldByName('DueDate').AsDateTime;
              qryAsset.FieldByName('DepreciationStartDate').AsDateTime := qry.FieldByName('DueDate').AsDateTime;
              cboDepreciationStartDate.DateTime := qry.FieldByName('DueDate').AsDateTime;

              cboClientLookup.Locate('Company', qry.FieldByName('SupplierName').AsString, [loCaseInsensitive]);
              qryAsset.FieldByName('SupplierName').AsString := qry.FieldByName('SupplierName').AsString;
              cboClient.Text := qry.FieldByName('SupplierName').AsString;
            end else begin
              oInfo := GetProductInfo(SerialPartID);
              qryAsset.FieldByName('PurchCost').AsFloat := GetAmountInc(oInfo.BuyPrice1, GetTaxRate(oInfo.PurchaseTaxCode));
              qryAsset.FieldByName('PurchDate').AsDateTime := Date;
              cboPurchDate.DateTime := Date;
              qryAsset.FieldByName('DepreciationStartDate').AsDateTime := Date;
              cboDepreciationStartDate.DateTime := Date;
            end;
          end;
        end else begin
          qryAssetEdit;
          fCleanPurchDate := qryAsset.FieldByName('PurchDate').AsDateTime;
          fCleanDepreciationStartDate := qryAsset.FieldByName('DepreciationStartDate').AsDateTime;
        end;

        RefreshDepreciationCalcsToMem(1);
        RefreshDepreciationCalcsToMem(2);

        PageControl1.ActivePage := TTabSheet(AssetInfo);
        pageControl1Change(nil);
        cboDepreciationOptionChange(nil);
        cboSalvageTypeChange(nil);
        cboDepreciationOptionChange(nil);
        cboSalvageTypeChange(nil);
        //##
        {Enabled The Correct Balance sheet Accounts}
        Label42.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        cboFixedAssetsAccount.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        Label41.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        cboFixedAssetsClearingAccount.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        Label44.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        cboFixedAssetsDepreciationAccount.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        Label64.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        cboFixedAssetDepreciationAccountName.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 1);
        //##
        Label49.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        cboFixedAssetAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        Label50.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        cboClearingAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        Label51.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        cboFixedAssetDepreciationAssetAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        Label56.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        cboFixedAssetDepreciationAccountName2.Enabled := (AppEnv.CompanyPrefs.DepreciationForTransactions = 2);
        CustomFieldsRefresh;
        //##
        SetControlFocus(AssetCode);
        AddPercentageDefaultClassIfEmpty;
        TotalsPercentages;
        CheckDatesDay;

      except
        on EAbort do HandleEAbortException;
        on e: ENoAccess do begin
          HandleNoAccessException(e);
          Exit;
        end;
        else raise;
      end;
    finally
      // Release our used objects.
      if Assigned(slEntries) then
        FreeandNil(slEntries);

      Processingcursor(False);
    end;
  finally
    EnableForm;
  end;
end;

function TFixedAssetGUI.IsMonthly(const DepreciationNo: integer): boolean;
begin
  Result := false;
  if (DepreciationNo = 1) then begin
    Result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Month');
  end else if (DepreciationNo = 2) then begin
    Result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Full Month');
  end;
end;

function TFixedAssetGUI.IsYearly(const DepreciationNo: integer): boolean;
begin
  Result := false;
  if (DepreciationNo = 1) then begin
    Result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Year');
  end else if (DepreciationNo = 2) then begin
    Result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Full Year');
  end;
end;

function TFixedAssetGUI.IsHalfYearly(const DepreciationNo: integer): boolean;
begin
  Result := false;
  if (DepreciationNo = 1) then begin
    Result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Half Year');
  end else if (DepreciationNo = 2) then begin
    Result := (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Half Year');
  end;
end;

function TFixedAssetGUI.IsExcludeMonthofPurchase(const DepreciationNo: integer): boolean;
begin
  Result := false;
  if (DepreciationNo = 1) then begin
    Result := (AppEnv.CompanyPrefs.MonthofPurchase1 = 'Exclude');
  end else if (DepreciationNo = 2) then begin
    Result := (AppEnv.CompanyPrefs.MonthofPurchase2 = 'Exclude');
  end;
end;

function TFixedAssetGUI.IsIncludeMonthofPurchase(const DepreciationNo: integer): boolean;
begin
  Result := false;
  if (DepreciationNo = 1) then begin
    Result := (AppEnv.CompanyPrefs.MonthofPurchase1 = 'Include');
  end else if (DepreciationNo = 2) then begin
    Result := (AppEnv.CompanyPrefs.MonthofPurchase2 = 'Include');
  end;
end;

procedure TFixedAssetGUI.cmdOkClick(Sender: TObject);
var
  qry       : TERPQuery;
(*  iX        : Integer;*)
  slSerial  : TStringList;
  (*fbForHire : Boolean ;*)
begin
  DisableForm;
  try
    //Check if Cost and Depreciation = 100
    if qryFAPercentages.State in [dsInsert, dsEdit] then qryFAPercentages.Post;
    if grdFAPercentage.ColumnByName('Cost').FooterValue <> '100.00%' then begin
      CommonLib.MessageDlgXP_Vista('Sum of Costs shoud be equal to 100', mtInformation, [mbOK], 0);
      PageControl1.ActivePage := TTabSheet(AssetInfo);
      SetControlFocus(grdFAPercentage);
      Exit;
    end;
    if grdFAPercentage.ColumnByName('Depreciation').FooterValue <> '100.00%' then begin
      CommonLib.MessageDlgXP_Vista('Sum of Depreciation shoud be equal to 100', mtInformation, [mbOK], 0);
      PageControl1.ActivePage := TTabSheet(AssetInfo);
      SetControlFocus(grdFAPercentage);
      Exit;
    end;

    if not ChkCustReqdFields then begin
        Exit;
    end;
    (*fbforHire := False;*)
    cmdOk.Enabled := false;

    { NOTE the following is OLD CODE and needs to be updated for new
           SN handling and lack of hire! }


    qry := TERPQuery.Create(nil);
    slSerial := TStringList.Create;
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Clear;
      try
        // Now we need to test if the fixed asset
        // has been made inactive.
        qry.SQL.Clear;
//        if not Empty(cboProduct.Text) then begin
//          if not Empty(Serial.Text) then begin
//            qry.SQL.Add('SELECT * FROM tblserialnumber WHERE PartsID = :xID AND SerialNumber = :xSerial');
//            qry.Params.ParamByName('xSerial').AsString := Serial.Text;
//            qry.Params.ParamByName('xID').AsInteger := GetPartID(cboProduct.Text);
//            qry.Open;
//
//
//            // Is this fixed asset still active?
//            if chkActive.Checked then begin
//              // Was the product with the serial number found?
//              fbforHire := CommonLib.MessageDlgXP_Vista('Do you wish to assign this product ''for hire''? ' , mtConfirmation , [mbYes, MbNo] , 0) = mrYes;
//              if qry.RecordCount > 0 then begin
//                // Yes
//                qry.Edit;
//                qry.FieldByName('IsFixedAsset').AsString := 'T';
//                //qry.FieldByName('ForHire').AsString := 'T';
//                if qry.FieldByName('ForHire').AsString = 'F' then
//                  qry.FieldByName('ForHire').asBoolean := fbforHire;
//                qry.Post;
//              end else begin
//                // No
//                qry.Insert;
//                qry.FieldByName('IsFixedAsset').AsString := 'T';
//                //qry.FieldByName('ForHire').AsString := 'T';
//                if qry.FieldByName('ForHire').AsString = 'F' then
//                  qry.FieldByName('ForHire').asBoolean := fbforHire;
//                qry.FieldByName('SerialNumber').AsString := Serial.Text;
//                qry.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PartsID').AsInteger;
//                qry.FieldByName('DateEntered').AsDateTime := Date;
//                qry.FieldByName('Sold').AsString := 'F';
//                qry.FieldByName('IsHired').AsString := 'F';
//                qry.FieldByName('PartName').AsString := cboProduct.Text;
//                qry.Post;
//              end;
//              // Nope not active anymore.
//            end else begin
//              if qry.RecordCount > 0 then begin
//                // Yes
//                if qry.FieldByName('IsHired').AsBoolean then begin
//                  CommonLib.MessageDlgXP_Vista('This Fixed Asset cannot be deactivated as it is currently out on hire!'#13#10#13#10 +
//                    'Please have this item returned before making inactive.', mtWarning, [mbOK], 0);
//
//                  Exit;
//                end;
//
//                qry.Edit;
//                qry.FieldByName('IsFixedAsset').AsString := 'F';
//                //qry.FieldByName('ForHire').AsString := 'F';
//                qry.Post;
//              end else begin
//                // No
//                qry.Insert;
//                qry.FieldByName('IsFixedAsset').AsString := 'F';
//                qry.FieldByName('SerialNumber').AsString := Serial.Text;
//                qry.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PartsID').AsInteger;
//                qry.FieldByName('DateEntered').AsDateTime := Date;
//                qry.FieldByName('Sold').AsString := 'F';
//                qry.FieldByName('IsHired').AsString := 'F';
//                //qry.FieldByName('ForHire').AsString := 'F';
//                qry.FieldByName('PartName').AsString := cboProduct.Text;
//                qry.Post;
//              end;
//            end;
//          end;
//        end;

        if not SaveFixedAsset then begin
          Exit;
        end;

        // Are we now to automate cloning?
//        if FromSerialNumbersForm then begin
//          if ((cboDepreciationOption.Text <> '') and (cboDepreciationOption.Text <> 'No Depreciation')) and
//            (memDepreciationCalcs1.RecordCount < 1) and (memDepreciationCalcs2.RecordCount < 1) then begin
//            CommonLib.MessageDlgXP_Vista('You need to specify your depreciation calculations - Please do so now before continueing to Save',
//              mtWarning, [mbOK], 0);
//            PageControl1.ActivePage := TTabSheet(Depreciation1);
//            Exit;
//          end;
//
//          // Activate clone procedure.
//          btnClone.Click;
//
//          // Update our serial list so that they can all be placed on hire.
//          qry.Close;
//          for iX := 0 to SerialNumberList.Count - 1 do begin
//            slSerial.Clear;
//            ExtractStrings(['|'], [' '], PChar(SerialNumberList.Strings[iX]), slSerial);
//            if fbforHire then begin
//              qry.SQL.Clear;
//              qry.SQL.Add('UPDATE tblserialnumber SET ForHire="T"');
//              qry.SQL.Add('WHERE SerialNumber = ' + QuotedStr(slSerial.Strings[0]) + ' AND PartsID = :xID');
//              qry.Params.ParamByName('xID').AsInteger := GetPartID(cboProduct.Text);
//              qry.Execute;
//            end;
//          end;
//        end;

        // Notify our list.
        Notify;

        // Close form.
        Self.Close;

      except
        on EAbort do HandleEAbortException;
        else raise;
      end;
    finally
      // Release our used allocated objects.
      if Assigned(qry) then FreeAndNil(qry);
      if Assigned(slSerial) then  FreeandNil(slSerial);
      cmdOk.Enabled := true;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TFixedAssetGUI.cmdNewClick(Sender: TObject);
begin
  try
    if SaveFixedAsset then begin
      KeyID := 0;
      FormShow(nil);
      SetControlFocus(AssetCode);
    end;

  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;


procedure TFixedAssetGUI.PageControl1Change(Sender: TObject);
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
    if (KeyID <> 0) and (Self.AccessLevel = 5) then begin
      RefreshDepreciationCalcsToMem(1);
    end;

    memDepreciationCalcs1.SortOn('Year;MonthNo', []);
    memDepreciationCalcs1.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]), [loCaseInsensitive]);
  end;

  if PageControl1.ActivePage = TTabSheet(Depreciation2) then begin
    ResetgrdDepreciationCalcs(2);
    if (KeyID <> 0) and (Self.AccessLevel = 5) then begin
      RefreshDepreciationCalcsToMem(2);
    end;

    memDepreciationCalcs2.SortOn('Year;MonthNo', []);
    memDepreciationCalcs2.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]), [loCaseInsensitive]);
  end;
end;

procedure TFixedAssetGUI.CustomFieldsRefresh;
begin
  CustomFieldRefresh('CFAssets' ,pnlCustFields);
end;
function TFixedAssetGUI.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Assets');
  if not Result then PageControl1.ActivePage := Custom_Fields;
end;
procedure TFixedAssetGUI.cboDepreciationOptionChange(Sender: TObject);
begin
  inherited;
  if cboDepreciationOption.Value <> '3' then begin
    cboDepreciationOption.Width := 229;
    SalvageFactor.Visible       := false;
    Salvage.Enabled:= true;
    cboSalvageType.Enabled:= true;
    lblSalvage.Enabled:= true;
  end else begin
    cboDepreciationOption.Width := 157;
    SalvageFactor.Visible       := true;
    Salvage.Enabled:= false;
    cboSalvageType.Enabled:= false;
    lblSalvage.Enabled:= false;
  end;
end;

procedure TFixedAssetGUI.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
(*Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmCustomFields');
  if Assigned(Form) then begin //if has acess
    with TfrmCustomFields(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;*)
end;

procedure TFixedAssetGUI.btnCalculateClick(Sender: TObject);
var
  SalvageValue: double;
begin
  DisableForm;
  try
    inherited;
    //Set UnSet Accounts
    SetDefaultAssetAccounts;

    if (qryAssetSalvageType.AsInteger = 2) then begin
      SalvageValue := qryAssetPurchCost.AsFloat * (qryAssetSalvage.AsFloat / 100); //Percent salvage
    end else begin
      SalvageValue := qryAssetSalvage.AsFloat;    //Amount salvage
    end;   

    CalculateDepreciation(memDepreciationCalcs1, 1,
    qryAssetAssetID.AsInteger,
    cboDepreciationOption.Text,
    qryAssetPurchDate.AsDateTime,
    qryAssetPurchCost.AsFloat,
    qryAssetSalvageFactor.AsFloat,
    SalvageValue,
    qryAssetLife.AsFloat,
    qryAssetPriorAccumDeprec.AsString,
    qryAssetPriorAccumDeprecAmount.AsFloat,
    qryAssetPriorAccumDeprecDate.AsString,
    qryAssetBusinessUsePercent.AsFloat,
    qryAssetDisposal.AsBoolean,
    qryAssetDisposalDate.AsDateTime);
  finally
    EnableForm;
  end;
end;

procedure TFixedAssetGUI.CheckDates;
begin
  if qryAssetDepreciationStartDate.AsDateTime < qryAssetPurchDate.AsDateTime  then begin
    CommonLib.MessageDlgXP_Vista('You Have Set The Depreciation Start Date Before The Purchase Date !' + #13 + #10 + '' + #13 + #10 +
      'The Depreciation Start Date Will Automatically be Set To The Purchase Date.', mtWarning, [mbOK], 0);
    qryAssetDepreciationStartDate.AsDateTime := qryAssetPurchDate.AsDateTime;
  end;

  if (qryAssetDepreciationStartDate.AsDateTime <= AppEnv.CompanyPrefs.ClosingDate) then begin
    CommonLib.MessageDlgXP_Vista('You Have Set The Depreciation Start Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 +
      'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' + #13 +
      #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', mtWarning, [mbOK], 0);
    qryAssetDepreciationStartDate.AsDateTime := Now;
    SetControlFocus(cboDepreciationStartDate);
  end;
  CheckDatesDay;
end;

procedure TFixedAssetGUI.CheckDatesDay;
var
  bm: TBookMark;
  firstDate, lastDate: TDateTime;
  depAmt, remainDepAmt: double;
  dateDiff: TDateTime;
  s: string;
  yrs: integer;
begin
  lblDayMatch.Caption := '';
  if DayOfTheMonth(qryAssetDepreciationStartDate.AsDateTime) <>
     DayOfTheMonth(qryAssetPurchDate.AsDateTime) then
  lblDayMatch.Caption := 'Day does not match Purchase Day';

  lblPercentInfo1.Caption := '';
  lblPercentInfo2.Caption := '';
  if qryAssetDepreciationStartDate.AsDateTime <> qryAssetPurchDate.AsDateTime then begin
    if memDepreciationCalcs1.RecordCount > 0 then begin
      firstDate := 0;
      lastDate := 0;
      depAmt := 0;
      remainDepAmt := 0;
      s := '';
      bm := memDepreciationCalcs1.GetBookmark;
      try
        memDepreciationCalcs1.DisableControls;
        try
          memDepreciationCalcs1.First;
          while not memDepreciationCalcs1.Eof do begin
            if firstDate = 0 then
              firstDate := memDepreciationCalcs1Date.AsDateTime;
            if memDepreciationCalcs1Depreciation.AsFloat > 0 then begin
              lastDate := memDepreciationCalcs1Date.AsDateTime;
              depAmt := depAmt + memDepreciationCalcs1Depreciation.AsFloat;
              if lastDate >= qryAssetDepreciationStartDate.AsDateTime then
                remainDepAmt := remainDepAmt + memDepreciationCalcs1Depreciation.AsFloat;
            end;
            memDepreciationCalcs1.Next;
          end;
          memDepreciationCalcs1.GotoBookmark(bm);
        finally
          memDepreciationCalcs1.EnableControls;
        end;
      finally
        memDepreciationCalcs1.FreeBookmark(bm);
      end;
      dateDiff := lastDate - qryAssetDepreciationStartDate.AsDateTime;
       yrs := 0;
      if dateDiff > 0 then begin
        if dateDiff > 365 then
          yrs := Trunc(dateDiff / 365);
        s:= '( ' +IntToStr(yrs) + ' Years ' + IntToStr(System.Round((dateDiff - (yrs * 365)) / 30)) + ' Months';
        if (remainDepAmt > 0) and (depAmt > 0) then
          s := s + ' ' + IntToStr(System.Round((remainDepAmt / depAmt) * 100)) + '%';
        s := s + ' )';
      end
      else begin
        s:= '( 0 Years )';
      end;
      lblPercentInfo1.Caption := s;
    end;

    if memDepreciationCalcs2.RecordCount > 0 then begin
      firstDate := 0;
      lastDate := 0;
      depAmt := 0;
      remainDepAmt := 0;
      s := '';
      bm := memDepreciationCalcs2.GetBookmark;
      try
        memDepreciationCalcs2.DisableControls;
        try
          memDepreciationCalcs2.First;
          while not memDepreciationCalcs2.Eof do begin
            if firstDate = 0 then
              firstDate := memDepreciationCalcs2Date.AsDateTime;
            if memDepreciationCalcs2Depreciation.AsFloat > 0 then begin
              lastDate := memDepreciationCalcs2Date.AsDateTime;
              depAmt := depAmt + memDepreciationCalcs2Depreciation.AsFloat;
              if lastDate >= qryAssetDepreciationStartDate.AsDateTime then
                remainDepAmt := remainDepAmt + memDepreciationCalcs2Depreciation.AsFloat;
            end;
            memDepreciationCalcs2.Next;
          end;
          memDepreciationCalcs2.GotoBookmark(bm);
        finally
          memDepreciationCalcs2.EnableControls;
        end;
      finally
        memDepreciationCalcs2.FreeBookmark(bm);
      end;
      dateDiff := lastDate - qryAssetDepreciationStartDate.AsDateTime;
       yrs := 0;
      if dateDiff > 0 then begin
        if dateDiff > 365 then
          yrs := Trunc(dateDiff / 365);
        s:= '( ' +IntToStr(yrs) + ' Years ' + IntToStr(System.Round((dateDiff - (yrs * 365)) / 30)) + ' Months';
        if (remainDepAmt > 0) and (depAmt > 0) then
          s := s + ' ' + IntToStr(System.Round((remainDepAmt / depAmt) * 100)) + '%';
        s := s + ' )';
      end
      else begin
        s:= '( 0 Years )';
      end;
      lblPercentInfo2.Caption := s;
    end;

  end;
end;

function TFixedAssetGUI.CheckDepreciationParameters: boolean;
begin
  Result := true;

  //New Asset Not Posted
  if (qryAssetAssetID.AsInteger <= 0) then begin
    Result := false;
  end;

  //No Purchase Date
  if (qryAssetPurchDate.AsDateTime <= 0) then begin
    Result := false;
  end;

  //No Purchase Cost
  if (qryAssetPurchCost.AsFloat <> 0.00) then begin
    Result := false;
  end;

  //No Depreciation Option
  if Empty(cboDepreciationOption.Text) then begin
    Result := false;
  end;

  //No Asset Prior Depreciation Date
  if qryAssetPriorAccumDeprec.AsBoolean and Empty(qryAssetPriorAccumDeprecDate.AsString) then begin
    Result := false;
  end;
end;

procedure TFixedAssetGUI.CalculateDepreciation(const MemTable: TkbmMemTable; const DepreciationNo: integer;
  const AssetID: integer; const DepreciationOption: string; const PurchDate: TDateTime;
  const PurchaseCost, SalvagePercent, SalvageValue, AssetLife: double; const UsePriorAccumDeprec: string;
  const PriorAccumDeprecAmt: double; const PriorAccumDeprecDate: string; const BusinessUsePercent: double;
  const Disposal: boolean; const DisposalDate: TDateTime);
var
  I, C, LifeCycles, Life    : integer;
  ADLife,  TempMonthStart   : integer;
  MonthStart, MonthsLeft    : integer;
  DisposalYear              : integer;
  DisposalMonth             : integer;
  DepreciationCycles        : integer;
  LifeTemp, Depreciation    : double;
  Year                      : string;
  DepreciationTotal         : double;
  DepreciableBasis          : double;
  LastDepreciationTotal     : double;
  PriorAccumDeprecMonth     : integer;
  ExitOnDisposalDate        : boolean;
  TempDate                  : TDateTime;
  TempDateDay               : word;
  tmpTempDateDay            : word;
  PurchaseDate              : TDateTime;
  PriorAccumDeprecAmount    : double;

  function DepCalcStartFinancialYearPrefSet: boolean;
  begin
    result :=
      ((DepreciationNo = 1) and SameText(AppEnv.CompanyPrefs.DepreciationCalcStart1, 'Financial Year')) or
      ((DepreciationNo = 2) and SameText(AppEnv.CompanyPrefs.DepreciationCalcStart2, 'Financial Year'));
  end;

  function DateStartForPriorAccum: TDateTime;
  var
    Month: integer;
  begin
    if DepreciationNo = 1 then begin
      // Deprec #1
      if SameText(AppEnv.CompanyPrefs.DepreciationCalcStart1, 'Financial Year') then begin
        // "Financial Year"
        Month := MonthNameToNumber(AppEnv.CompanyPrefs.FiscalYearStarts);
        if Month < 12 then result := EncodeDate(StrToInt(PriorAccumDeprecDate),Month,1)
        else result := EncodeDate(StrToInt(PriorAccumDeprecDate)+1,Month,1);
      end
      else begin
        // "Calendar Year"
        result := EncodeDate(StrToInt(PriorAccumDeprecDate)+1,1,1);
      end;
    end
    else begin
      // Deprec #2
      if SameText(AppEnv.CompanyPrefs.DepreciationCalcStart2, 'Financial Year') then begin
        // "Financial Year"
        Month := MonthNameToNumber(AppEnv.CompanyPrefs.FiscalYearStarts);
        if Month < 12 then result := EncodeDate(StrToInt(PriorAccumDeprecDate),Month,1)
        else result := EncodeDate(StrToInt(PriorAccumDeprecDate)+1,Month,1);
      end
      else begin
        // "Calendar Year"
        result := EncodeDate(StrToInt(PriorAccumDeprecDate)+1,1,1);
      end;
    end;
  end;

begin
  //Inital Setup
  if (UsePriorAccumDeprec = 'T') and Empty(PriorAccumDeprecDate) then Exit;
  PurchaseDate := PurchDate;
  PriorAccumDeprecAmount := PriorAccumDeprecAmt;
  ExitOnDisposalDate := false;
  TempDateDay := 1;
  MemTable.Close;
  MemTable.EmptyTable;
  MemTable.Open;

  if not IsMonthly(DepreciationNo) and (PurchaseDate > EncodeDate(YearOf(PurchaseDate),
    GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts), 1)) then begin
    PurchaseDate := IncYear(PurchaseDate, 1);
  end;

  if IsYearly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then begin
    PurchaseDate := IncYear(PurchaseDate, 1);
  end;

  MonthStart := 0;
  MonthsLeft := 12;
  LastDepreciationTotal := 0;
  if CheckDepreciationParameters then Exit;
  ResetgrdDepreciationCalcs(DepreciationNo);

  {Straight Line Depreciation}
  if DepreciationOption = 'Straight Line Depreciation' then begin
    if (UsePriorAccumDeprec = 'T') then begin
      // 2014-04-15 changes to use correct year start
      PurchaseDate := DateStartForPriorAccum;
      ADLife := YearOf(PurchaseDate) - YearOf(PurchDate);
      PriorAccumDeprecMonth := MonthOf(PurchaseDate);
      if IsIncludeMonthofPurchase(DepreciationNo) then PurchaseDate := IncMonth(PurchaseDate,1);

//      ADLife := FastFuncs.StrToInt(PriorAccumDeprecDate) - (YearOf(PurchaseDate));
//      PurchaseDate := IncYear(PurchaseDate, ADLife);
//      PriorAccumDeprecMonth := MonthOf(PurchaseDate);
//      if IsIncludeMonthofPurchase(DepreciationNo) then PriorAccumDeprecMonth := PriorAccumDeprecMonth - 1;
    end else begin
      ADLife := 0;
      PriorAccumDeprecAmount := 0.00;
      PriorAccumDeprecMonth := 0;
    end;
    // Life
    Life       := (system.Round(AssetLife) - ADLife);
    LifeCycles := Life;
    if IsYearly(DepreciationNo) then LifeCycles := Life - 1;
    if (UsePriorAccumDeprec = 'T') and IsMonthly(DepreciationNo) then Life := Life - 1;
    DepreciationTotal := 0.00;

    for I := 0 to LifeCycles do begin
      if IsMonthly(DepreciationNo) then begin
        //Start Month
        if (I = 0) then begin
          MonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then MonthStart := MonthStart - 1;
        end else begin
          MonthStart := 1; // MontStartBasedOnPrefs;
        end;
        //Months Left
        if (I = 0) then begin
          MonthsLeft := 12 - MonthStart;
        end else if (I = LifeCycles) then begin
          TempMonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then TempMonthStart := TempMonthStart - 1;
          MonthsLeft := 12 - TempMonthStart;
          MonthsLeft := 12 - MonthsLeft;
        end else begin
          MonthsLeft := 12;
        end;
        DepreciationCycles := MonthsLeft;
      end else begin
        DepreciationCycles := 1;
      end;

      //Year Period
      Year := IntToStr(YearOf(IncYear(PurchaseDate, I)));

      //Period's Depreciation
      if (UsePriorAccumDeprec = 'T') and IsMonthly(DepreciationNo) then begin
        if (I = LifeCycles) then begin
          Depreciation := (DivZer(((PurchaseCost - SalvageValue) - PriorAccumDeprecAmount),
            Life + (PriorAccumDeprecMonth / 12)) * (PriorAccumDeprecMonth / 12) * (BusinessUsePercent / 100));
        end else begin
          Depreciation := (DivZer(((PurchaseCost - SalvageValue) - PriorAccumDeprecAmount),
            Life + (PriorAccumDeprecMonth / 12)) * (BusinessUsePercent / 100));
        end;
      end else begin
        if IsMonthly(DepreciationNo) then begin
          if (I = 0) or (I = LifeCycles) then begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount),
              Life) * (MonthsLeft / 12) * (BusinessUsePercent / 100));
          end else begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount), Life) * (BusinessUsePercent / 100));
          end;
        end else if IsHalfYearly(DepreciationNo) then begin
          if (UsePriorAccumDeprec = 'T') then begin
            LifeTemp := Life - 0.5;
          end else begin
            LifeTemp := Life;
          end;
          if (I = 0) or (I = LifeCycles) or (Disposal and (YearOf(DisposalDate) = FastFuncs.StrToInt(Year))) then begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount),
              LifeTemp) * (1 / 2) * (BusinessUsePercent / 100));
          end else begin
            Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount),
              LifeTemp) * (BusinessUsePercent / 100));
          end;
        end else begin
          if (UsePriorAccumDeprec = 'T') then begin
            LifeTemp := Life - 1;
          end else begin
            LifeTemp := Life;
          end;
          Depreciation := (DivZer((PurchaseCost - SalvageValue - PriorAccumDeprecAmount),
            LifeTemp) * (BusinessUsePercent / 100));
        end;
      end;

      if UsePriorAccumDeprec = 'T' then begin
      // 2014-04-15 changes to use correct year start
//        if (Year = PriorAccumDeprecDate) then begin
//          DepreciationTotal := PriorAccumDeprecAmount;
//          Depreciation := 0.00;
//          DepreciationCycles := 1;
//          MonthStart := 11;
//          MonthsLeft := 12;
//        end else begin
          DepreciationTotal := DepreciationTotal + Depreciation;
//        end;
        if (I = LifeCycles) and IsMonthly(DepreciationNo) then begin
          DepreciationCycles := PriorAccumDeprecMonth;
          MonthStart := 1;
          MonthsLeft := PriorAccumDeprecMonth;
        end;
      end else begin
        DepreciationTotal := DepreciationTotal + Depreciation;
      end;

      //Calcs to MemTable
      for C := 1 to DepreciationCycles do begin
        MemTable.Insert;
        // Asset ID
        MemTable.FieldByName('AssetID').AsInteger := AssetID;
        // Year
        MemTable.FieldByName('Year').AsString := Year;
        // Month
        if IsMonthly(DepreciationNo) then begin
          if (C = 1) and (I = 0) then MonthStart := MonthStart + 1;
          MemTable.FieldByName('MonthNo').AsInteger := MonthStart;
          MonthStart := MonthStart + 1;
          MemTable.FieldByName('Month').AsString := GetMonthName(MemTable.FieldByName('MonthNo').AsInteger);
          TempDateDay := DayOf(PurchaseDate);
        end else if IsHalfYearly(DepreciationNo) then begin
          MemTable.FieldByName('MonthNo').AsInteger := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          MemTable.FieldByName('Month').AsString := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end else if IsYearly(DepreciationNo) then begin
          MemTable.FieldByName('MonthNo').AsInteger := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          MemTable.FieldByName('Month').AsString := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end;
        //Date
        tmpTempDateDay := TempDateDay;   //This For 31th Date Of Purchase to find end of each month
        while not TryEncodeDate(MemTable.FieldByName('Year').AsInteger, MemTable.FieldByName('MonthNo').AsInteger,
          tmpTempDateDay, TempDate) do begin
          tmpTempDateDay := tmpTempDateDay - 1;
        end;
        MemTable.FieldByName('Date').AsDateTime := EncodeDate(MemTable.FieldByName('Year').AsInteger,
          MemTable.FieldByName('MonthNo').AsInteger, tmpTempDateDay);

        // Depreciation
        if IsMonthly(DepreciationNo) then begin
          MemTable.FieldByName('Depreciation').AsFloat := Depreciation * (1 / MonthsLeft);
        end else begin
          MemTable.FieldByName('Depreciation').AsFloat := Depreciation;
        end;
        // Total Depreciation
        if IsMonthly(DepreciationNo) then begin
      // 2014-04-15 changes to use correct year start
//          if (UsePriorAccumDeprec = 'T') and (Year = PriorAccumDeprecDate) then begin
//            MemTable.FieldByName('TotalDepreciation').AsFloat := DepreciationTotal;
//          end else begin
            MemTable.FieldByName('TotalDepreciation').AsFloat :=
              LastDepreciationTotal + ((DepreciationTotal - LastDepreciationTotal) * (C / MonthsLeft));;
//          end;
        end else begin
          MemTable.FieldByName('TotalDepreciation').AsFloat := DepreciationTotal;
        end;

        // Book Value
        MemTable.FieldByName('BookValue').AsFloat := (PurchaseCost - MemTable.FieldByName('TotalDepreciation').AsFloat);
        MemTable.Post;

        // Disposal of Asset
        if (DepreciationNo = 1) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then DisposalMonth := DisposalMonth - 1;

          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger) then
          begin
            qryAssetEdit;
            qryAssetDisposalBookValue.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger)
            and (DisposalMonth = MemTable.FieldByName('MonthNo').AsInteger) then begin
            qryAssetEdit;
            qryAssetDisposalBookValue.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end;
        end else if (DepreciationNo = 2) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then DisposalMonth := DisposalMonth - 1;
          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger) then
          begin
            qryAssetEdit;
            qryAssetDisposalBookValue2.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec2.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger)
            and (DisposalMonth = MemTable.FieldByName('MonthNo').AsInteger) then begin
            qryAssetEdit;
            qryAssetDisposalBookValue2.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec2.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end;
        end;
      end;

      if ExitOnDisposalDate then Break;

      if IsMonthly(DepreciationNo) then begin
        LastDepreciationTotal := MemTable.FieldByName('TotalDepreciation').AsFloat;
      end;
    end;
    // Get first record.
    MemTable.First;
  end;
  {##########################}
  {Declining Balance}
  if DepreciationOption = 'Declining Balance' then begin
    if (UsePriorAccumDeprec = 'T') then begin
      // 2014-04-15 changes to use correct year start
      PurchaseDate := DateStartForPriorAccum;
      ADLife := YearOf(PurchaseDate) - YearOf(PurchDate);
      PriorAccumDeprecMonth := MonthOf(PurchaseDate);
      if IsIncludeMonthofPurchase(DepreciationNo) then PurchaseDate := IncMonth(PurchaseDate,1);

//      ADLife := FastFuncs.StrToInt(Trim(PriorAccumDeprecDate)) - YearOf(PurchaseDate);
//      PurchaseDate := IncYear(PurchaseDate, ADLife);
//      PriorAccumDeprecMonth := MonthOf(PurchaseDate);
//      if IsIncludeMonthofPurchase(DepreciationNo) then PriorAccumDeprecMonth := PriorAccumDeprecMonth - 1;
    end else begin
      ADLife := 0;
      PriorAccumDeprecAmount := 0.00;
      PriorAccumDeprecMonth := 0;
    end;
    // Life
    Life       := (system.Round(AssetLife) - ADLife);
    LifeCycles := Life;
    if IsYearly(DepreciationNo) then LifeCycles := Life - 1;
    //     If (UsePriorAccumDeprec = 'T') AND IsMonthly then Life := Life - 1;
    DepreciationTotal := 0.00;

    for I := 0 to LifeCycles do begin
      if IsMonthly(DepreciationNo) then begin
        //Start Month
        if (I = 0) then begin
          MonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then MonthStart := MonthStart - 1;
        end else begin
          MonthStart := 1; // MontStartBasedOnPrefs;
        end;
        //Months Left
        if (I = 0) then begin
          MonthsLeft := 12 - MonthStart;
        end else if (I = LifeCycles) then begin
          TempMonthStart := MonthOf(PurchaseDate);
          if IsIncludeMonthofPurchase(DepreciationNo) then TempMonthStart := TempMonthStart - 1;
          MonthsLeft := 12 - TempMonthStart;
          MonthsLeft := 12 - MonthsLeft;
        end else begin
          MonthsLeft := 12;
        end;
        DepreciationCycles := MonthsLeft;
      end else begin
        DepreciationCycles := 1;
      end;

      //Year Period
      Year := IntToStr(YearOf(IncYear(PurchaseDate, I)));
      Life := system.Round(AssetLife);

      //Period's Depreciation
      if (UsePriorAccumDeprec = 'T') and IsMonthly(DepreciationNo) then begin
        if (I = LifeCycles) then begin
          DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
          Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
            (MonthsLeft / 12) * (BusinessUsePercent / 100);
        end else begin
          DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
          Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) * (BusinessUsePercent / 100);
        end;
      end else begin
        if IsMonthly(DepreciationNo) then begin
          if (I = 0) or (I = LifeCycles) then begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) *
              (MonthsLeft / 12) * (BusinessUsePercent / 100);
          end else begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) * (BusinessUsePercent / 100);
          end;
        end else if IsHalfYearly(DepreciationNo) then begin
          if (I = 0) or (I = LifeCycles) or (Disposal and (YearOf(DisposalDate) = FastFuncs.StrToInt(Year))) then begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) * (1 / 2)
              * (BusinessUsePercent / 100);
          end else begin
            DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
            Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) * (BusinessUsePercent / 100);
          end;
        end else begin
          DepreciableBasis := (PurchaseCost - SalvageValue - DepreciationTotal);
          Depreciation := (DepreciableBasis * DivZer(1, Life) * (SalvagePercent / 100)) * (BusinessUsePercent / 100);
        end;
      end;
      if UsePriorAccumDeprec = 'T' then begin
      // 2014-04-15 changes to use correct year start
//        if (Year = PriorAccumDeprecDate) then begin
//          DepreciationTotal := PriorAccumDeprecAmount;
//          Depreciation := 0.00;
//          DepreciationCycles := 1;
//          MonthStart := 11;
//          MonthsLeft := 12;
//        end else begin
          DepreciationTotal := DepreciationTotal + Depreciation;
//        end;
        if (I = LifeCycles) and IsMonthly(DepreciationNo) then begin
          DepreciationCycles := PriorAccumDeprecMonth;
          MonthStart := 1;
          MonthsLeft := PriorAccumDeprecMonth;
        end;
      end else begin
        DepreciationTotal := DepreciationTotal + Depreciation;
      end;
      //Calcs to MemTable
      for C := 1 to DepreciationCycles do begin
        MemTable.Insert;
        // Asset ID
        MemTable.FieldByName('AssetID').AsInteger := AssetID;
        // Year
        MemTable.FieldByName('Year').AsString := Year;
        // Month
        if IsMonthly(DepreciationNo) then begin
          if (C = 1) and (I = 0) then MonthStart := MonthStart + 1;
          MemTable.FieldByName('MonthNo').AsInteger := MonthStart;
          MonthStart := MonthStart + 1;
          MemTable.FieldByName('Month').AsString := GetMonthName(MemTable.FieldByName('MonthNo').AsInteger);
          TempDateDay := DayOf(PurchaseDate);
        end else if IsHalfYearly(DepreciationNo) then begin
          MemTable.FieldByName('MonthNo').AsInteger := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          MemTable.FieldByName('Month').AsString := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end else if IsYearly(DepreciationNo) then begin
          MemTable.FieldByName('MonthNo').AsInteger := GetMonthNo(AppEnv.CompanyPrefs.FiscalYearStarts);
          MemTable.FieldByName('Month').AsString := AppEnv.CompanyPrefs.FiscalYearStarts;
          TempDateDay := 1;
        end;
        //Date
        tmpTempDateDay := TempDateDay;  //This For 31th Date Of Purchase to find end of each month
        while not TryEncodeDate(MemTable.FieldByName('Year').AsInteger, MemTable.FieldByName('MonthNo').AsInteger,
          tmpTempDateDay, TempDate) do begin
          tmpTempDateDay := tmpTempDateDay - 1;
        end;
        MemTable.FieldByName('Date').AsDateTime := EncodeDate(MemTable.FieldByName('Year').AsInteger,
          MemTable.FieldByName('MonthNo').AsInteger, tmpTempDateDay);

        // Depreciation
        if IsMonthly(DepreciationNo) then begin
          MemTable.FieldByName('Depreciation').AsFloat := Depreciation * (1 / MonthsLeft);
        end else begin
          MemTable.FieldByName('Depreciation').AsFloat := Depreciation;
        end;
        // Total Depreciation
        if IsMonthly(DepreciationNo) then begin
      // 2014-04-15 changes to use correct year start
//          if (UsePriorAccumDeprec = 'T') and (Year = PriorAccumDeprecDate) then begin
//            MemTable.FieldByName('TotalDepreciation').AsFloat := DepreciationTotal;
//          end else begin
            MemTable.FieldByName('TotalDepreciation').AsFloat :=
              LastDepreciationTotal + ((DepreciationTotal - LastDepreciationTotal) * (C / MonthsLeft));;
//          end;
        end else begin
          MemTable.FieldByName('TotalDepreciation').AsFloat := DepreciationTotal;
        end;
        // Book Value
        MemTable.FieldByName('BookValue').AsFloat := (PurchaseCost - MemTable.FieldByName('TotalDepreciation').AsFloat);
        MemTable.Post;
        // Disposal of Asset
        if (DepreciationNo = 1) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then DisposalMonth := DisposalMonth - 1;
          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger) then
          begin
            qryAssetEdit;
            qryAssetDisposalBookValue.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger)
            and (DisposalMonth = MemTable.FieldByName('MonthNo').AsInteger) then begin
            qryAssetEdit;
            qryAssetDisposalBookValue.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end;
        end else if (DepreciationNo = 2) then begin
          DisposalYear := YearOf(DisposalDate);
          if IsYearly(DepreciationNo) and IsIncludeMonthofPurchase(DepreciationNo) then DisposalYear := DisposalYear - 1;
          DisposalMonth := MonthOf(DisposalDate);
          if IsMonthly(DepreciationNo) and IsExcludeMonthofPurchase(DepreciationNo) then DisposalMonth := DisposalMonth - 1;
          if (not IsMonthly(DepreciationNo)) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger) then
          begin
            qryAssetEdit;
            qryAssetDisposalBookValue2.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec2.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end else if IsMonthly(DepreciationNo) and Disposal and (DisposalYear = MemTable.FieldByName('Year').AsInteger)
            and (DisposalMonth = MemTable.FieldByName('MonthNo').AsInteger) then begin
            qryAssetEdit;
            qryAssetDisposalBookValue2.AsFloat := MemTable.FieldByName('BookValue').AsFloat;
            qryAssetDisposalAccumDeprec2.AsFloat := MemTable.FieldByName('TotalDepreciation').AsFloat;
            ExitOnDisposalDate := true;
            Break;
          end;
        end;
      end;
      if ExitOnDisposalDate then Break;
      if IsMonthly(DepreciationNo) then begin
        LastDepreciationTotal := MemTable.FieldByName('TotalDepreciation').AsFloat;
      end;
    end;
    MemTable.First;
  end;
  {##########################}
  if MemTable.Name = 'memDepreciationCalcs1' then begin
    ResetgrdDepreciationCalcs(1);
  end else if MemTable.Name = 'memDepreciationCalcs2' then begin
    ResetgrdDepreciationCalcs(2);
  end;
  MemTable.SortOn('Year;MonthNo', []);
  MemTable.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]), [loCaseInsensitive]);
  CheckDatesDay;
 end;

procedure TFixedAssetGUI.DeleteOldDepreciationDetails(const DepreciationNo: integer; const AssetID: integer);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    if (DepreciationNo = 1) then begin
      qryTemp.Sql.Add('DELETE FROM tblfixedassetsdepreciationdetails WHERE AssetID=' + IntToStr(AssetID) + ';');
    end else if (DepreciationNo = 2) then begin
      qryTemp.Sql.Add('DELETE FROM tblfixedassetsdepreciationdetails2 WHERE AssetID=' + IntToStr(AssetID) + ';');
    end;

    // Remove all entries from depreciation details table.
    qryTemp.Execute;
  finally
    // Free our used objects.
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

procedure TFixedAssetGUI.cboSalvageTypeChange(Sender: TObject);
var
  WasEdited: boolean;
begin
  inherited;
  if (cboSalvageType.Text = 'Amount') then begin
    qryAssetSalvage.currency      := true;
    qryAssetSalvage.DisplayFormat := '';
  end else begin
    qryAssetSalvage.currency      := false;
    qryAssetSalvage.DisplayFormat := '0.00%';
    if qryAssetSalvage.AsFloat > 100.00 then begin
      CheckEditMode(qryAsset, WasEdited);
      qryAssetSalvage.AsFloat := 0.00;
      qryAssetPost;
      if WasEdited then CheckEditMode(qryAsset);
    end;
  end;
end;

procedure TFixedAssetGUI.PriorAccumDeprecClick(Sender: TObject);
begin
  inherited;
  Label32.Enabled := PriorAccumDeprec.Checked;
  PriorAccumDeprecAmount.Enabled := PriorAccumDeprec.Checked;
  Label33.Enabled := PriorAccumDeprec.Checked;
  PriorAccumDeprecDate.Enabled := PriorAccumDeprec.Checked;
end;

procedure TFixedAssetGUI.cmdNewServiceLogClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TServiceLogGUI');
    if Assigned(Form) then begin //if has acess
      with TServiceLogGUI(Form) do begin
        TServiceLogGUI(Form).PassAssetCode := qryAssetAssetCode.AsString;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;    
end;

procedure TFixedAssetGUI.DisposalofAssetClick(Sender: TObject);
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

  qryAssetPurchDateChange(nil);
end;

procedure TFixedAssetGUI.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    inherited;
    if not ChkAssetsReqdFields() then begin
      Exit;
    end;

    if not ChkAssetsReqdAccounts() then begin
      Exit;
    end;

    PostDb(qryPictures);
    SaveTransaction;

    if not MyConnection.intransaction then begin
      BeginTransaction;
    end;

    qryAssetEdit;
    sSQL := ' WHERE FA.AssetID = ' + qryAssetAssetID.AsString;
    PrintTemplateReport('Fixed Asset', sSQL, not AppEnv.Employee.ShowPreview, 1);
    qryAssetEdit;
  finally
    EnableForm;
  end;  
end;

function TFixedAssetGUI.ChkAssetsReqdFields: boolean;
var
  OldPage: TTabSheet;
begin
  OldPage := PageControl1.ActivePage;
  PageControl1.ActivePage := Custom_Fields;
  Result := ChkReqdFields('Assets');
  if Result then begin
    PageControl1.ActivePage := OldPage;
    if not Empty(AssetCode.Text) then begin
      if not Empty(AssetName.Text) then begin
        if not Empty(cboAssetType.Text) then begin
          if not Empty(cboClass.Text) then begin
            Exit;
          end else begin
            Result := false;
            CommonLib.MessageDlgXP_Vista(AppEnv.DefaultClass.ClassHeading + ' cannot be blank.', mtWarning, [mbOK], 0);
            PageControl1.ActivePage := AssetInfo;
            SetControlFocus(cboClass);
          end;
        end else begin
          Result := false;
          CommonLib.MessageDlgXP_Vista('Asset Type cannot be blank.', mtWarning, [mbOK], 0);
          PageControl1.ActivePage := AssetInfo;
          SetControlFocus(cboAssetType);
        end;
      end else begin
        Result := false;
        CommonLib.MessageDlgXP_Vista('Asset Name cannot be blank.', mtWarning, [mbOK], 0);
        PageControl1.ActivePage := AssetInfo;
        SetControlFocus(AssetName);
      end;
    end else begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Asset Code cannot be blank.', mtWarning, [mbOK], 0);
      PageControl1.ActivePage := AssetInfo;
      SetControlFocus(AssetCode);
    end;
    if qryAssetDepreciationStartDate.AsDateTime < qryAssetPurchDate.AsDateTime then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Depreciation Start Date cannot be before Purchase Date.', mtWarning, [mbOK], 0);
      PageControl1.ActivePage := AssetInfo;
      SetControlFocus(cboDepreciationStartDate);
    end;

//    Result := false;
  end;
end;

procedure TFixedAssetGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  // Convert our keycode to a character.
  cThisKey := Chr(Key);
  // Our Key shortcuts for our PageControl tabs.
  if Shift = [ssCtrl] then begin
    if cThisKey = 'A' then begin
      PageControl1.ActivePageIndex := 0;
      PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'I' then begin
      PageControl1.ActivePageIndex := 1;
      PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'O' then begin
      PageControl1.ActivePageIndex := 2;
      PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'D' then begin
      PageControl1.ActivePageIndex := 3;
      PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'L' then begin
      PageControl1.ActivePageIndex := 4;
      PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;
  end;
end;

procedure TFixedAssetGUI.grpHistoryClick(Sender: TObject);
var
//  QueryManipulationObj  : TQueryManipulationObj;
  ffrmList              : TBaseListingGUI;
//  TempShowQrySpeedNotify: boolean;
  iIndex                : integer;
begin
  ffrmList := nil;
//  TempShowQrySpeedNotify := AppEnv.Employee.ShowQuerySpeedNotification;
  inherited;
  try
//    AppEnv.Employee.ShowQuerySpeedNotification := false;
    case grpHistory.ItemIndex of
      0:
        begin
          ffrmList := ffrmList0;
          ffrmList.FilterString := 'AssetID = ' + IntToStr(KeyID);
          ffrmList.chkIgnoreDates.Checked := true;
        end;
      1:
        begin
          ffrmList := fFixedAssetREpairList;
          ffrmList.FilterString := 'AssetID = ' + IntToStr(KeyID);
        end;
    end;
    if Assigned(ffrmList) then begin
      grpHistory.Color := ffrmList.pnlHeader.Color;
      ffrmList.Parent := pnlHistory;
      ffrmList.BorderStyle := bsNone;
      ffrmList.Show;


      // Show Print & Export
      for iIndex := 0 to ffrmList.FooterPanel.ControlCount - 1 do begin
        if ffrmList.FooterPanel.Controls[iIndex] is TControl then begin
          TControl(ffrmList.FooterPanel.Controls[iIndex]).Visible := false;
        end;
      end;

      ffrmList.FooterPanel.Height := 30;
      ffrmList.cmdExport.Top := 1;
      ffrmList.cmdExport.Left := 100;
      ffrmList.cmdExport.Visible := true;
      ffrmList.cmdPrint.Top := 1;
      ffrmList.cmdPrint.Left := pnlHistory.Width - 200;
      ffrmList.cmdPrint.Visible := true;
      ffrmList.FooterPanel.Visible := true;
      ffrmList.grpFilters.Visible := true;
      ffrmList.pnlButtons.Visible := true;
      ffrmList.grdMain.PopupMenu := ffrmList.mnuFilter;
      ffrmList.grdMain.Align := alClient;
      ffrmList.lblcustomReport.Visible := False;
      ffrmList.cboCustomReports.Visible := False;

      ffrmList.lblFilter.Left := 3;
      ffrmList.cboFilter.Left := 93;
      ffrmList.lblSearchoptions.Left := 218;
      ffrmList.edtSearch.Left := 382;


    end;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;

//  AppEnv.Employee.ShowQuerySpeedNotification := TempShowQrySpeedNotify;
end;

procedure TFixedAssetGUI.SaveTransaction;
var
  OldParentID   : integer;
  AssetCalc     : double;
begin
  Processingcursor(True);
  Application.ProcessMessages;
  try
    if (MyConnection.intransaction) then begin
      try
        // Aquire the old ParentID
        if VarType(qryAssetParentID.OldValue) <> varNull then
          OldParentID := qryAssetParentID.OldValue
        else
          OldParentID:= 0;
          
        //Asset Table
        with qryAsset do try
            CheckAccounts;
            if State <> dsBrowse then begin
              Post;
            end;
          except
            raise;
          end;
        // Copy memDepreciationCalcs To qryDepreciationCalcs
        CopyMemDepreciationCalcsToTables(1);
        CopyMemDepreciationCalcsToTables(2);

        // Update the TotalChildAsset field
        if qryAsset.FieldByName('AssetID').AsInteger > -1 then begin
          //
          if (OldParentID <> 0) and (qryAsset.FieldByName('ParentID').AsInteger <> 0) then begin
            // Reallocate asset
            // Remove cost of asset from old parent
            RemoveAssetCostFromParent(OldParentID, qryAsset.FieldByName('PurchCost').AsFloat);

            // Add cost of asset to new parent
            qryAssetEdit;

            // Assign the cost of all child assets
            AssetCalc := CalculateChildAssetTotals(qryAsset.FieldByName('ParentID').AsInteger) +
              qryAsset.FieldByName('PurchCost').AsFloat;
            // Set TotalChildAsset value
            qryAssetTotalChildAsset.AsFloat := AssetCalc;

            // Set the parents TotalChildAsset value
            UpdateParentsTotalAsset(qryAsset.FieldByName('ParentID').AsInteger,
              AssetCalc);
            qryAssetPost;
          end else if (OldParentID <> 0) and (qryAsset.FieldByName('ParentID').AsInteger = 0) then begin
            // Asset now has no parent
            // Remove cost of asset from old parent
            RemoveAssetCostFromParent(OldParentID, qryAsset.FieldByName('PurchCost').AsFloat);
          end else begin
            // Process new asset
            qryAssetEdit;

            // Assign the cost of all child assets
            AssetCalc := CalculateChildAssetTotals(qryAsset.FieldByName('ParentID').AsInteger) +
              qryAsset.FieldByName('PurchCost').AsFloat;

            // Set TotalChildAsset value
            qryAssetTotalChildAsset.AsFloat := AssetCalc;

            // Set the parents TotalChildAsset value
            UpdateParentsTotalAsset(qryAsset.FieldByName('ParentID').AsInteger,
              AssetCalc);
            qryAssetPost;
          end;
        end;

        Notify;
      except
        on e: Exception do begin
          Audit.AddEntry(e, Self);
          RollbackTransaction;
          raise Exception.Create(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName);
        end;
      end;
      {and finally...commit the transaction}
      CommitTransaction;
    end;
  finally
    Processingcursor(False);
  end;
end;

procedure TFixedAssetGUI.CopyMemDepreciationCalcsToTables(const DepreciationNo: integer);
begin
  Processingcursor(True);
  try
    if (DepreciationNo = 1) then begin
      //#1
      DeleteOldDepreciationDetails(1, qryAssetAssetID.AsInteger);
      memDepreciationCalcs1.DisableControls;
      memDepreciationCalcs1.First;
      while not memDepreciationCalcs1.Eof do begin
        qryDepreciationCalcs1.Append;
        qryDepreciationCalcs1.FieldByName('AssetID').AsInteger := memDepreciationCalcs1.FieldByName('AssetID').AsInteger;
        qryDepreciationCalcs1.FieldByName('Year').AsString := memDepreciationCalcs1.FieldByName('Year').AsString;
        qryDepreciationCalcs1.FieldByName('Month').AsString := memDepreciationCalcs1.FieldByName('Month').AsString;
        qryDepreciationCalcs1.FieldByName('MonthNo').AsInteger := memDepreciationCalcs1.FieldByName('MonthNo').AsInteger;
        qryDepreciationCalcs1.FieldByName('Depreciation').AsFloat :=
          memDepreciationCalcs1.FieldByName('Depreciation').AsFloat;
        qryDepreciationCalcs1.FieldByName('TotalDepreciation').AsFloat :=
          memDepreciationCalcs1.FieldByName('TotalDepreciation').AsFloat;
        qryDepreciationCalcs1.FieldByName('BookValue').AsFloat := memDepreciationCalcs1.FieldByName('BookValue').AsFloat;
        qryDepreciationCalcs1.FieldByName('Date').AsDateTime := memDepreciationCalcs1.FieldByName('Date').AsDateTime;
        qryDepreciationCalcs1.Post;
        memDepreciationCalcs1.Next;
      end;
      memDepreciationCalcs1.EnableControls;
    end else if (DepreciationNo = 2) then begin
      //#2
      DeleteOldDepreciationDetails(2, qryAssetAssetID.AsInteger);
      memDepreciationCalcs2.DisableControls;
      memDepreciationCalcs2.First;
      while not memDepreciationCalcs2.Eof do begin
        qryDepreciationCalcs2.Append;
        qryDepreciationCalcs2.FieldByName('AssetID').AsInteger := memDepreciationCalcs2.FieldByName('AssetID').AsInteger;
        qryDepreciationCalcs2.FieldByName('Year').AsString := memDepreciationCalcs2.FieldByName('Year').AsString;
        qryDepreciationCalcs2.FieldByName('Month').AsString := memDepreciationCalcs2.FieldByName('Month').AsString;
        qryDepreciationCalcs2.FieldByName('MonthNo').AsInteger := memDepreciationCalcs2.FieldByName('MonthNo').AsInteger;
        qryDepreciationCalcs2.FieldByName('Depreciation').AsFloat :=
          memDepreciationCalcs2.FieldByName('Depreciation').AsFloat;
        qryDepreciationCalcs2.FieldByName('TotalDepreciation').AsFloat :=
          memDepreciationCalcs2.FieldByName('TotalDepreciation').AsFloat;
        qryDepreciationCalcs2.FieldByName('BookValue').AsFloat := memDepreciationCalcs2.FieldByName('BookValue').AsFloat;
        qryDepreciationCalcs2.FieldByName('Date').AsDateTime := memDepreciationCalcs2.FieldByName('Date').AsDateTime;
        qryDepreciationCalcs2.Post;
        memDepreciationCalcs2.Next;
      end;
      memDepreciationCalcs2.EnableControls;
    end;
  finally
    Processingcursor(False);
  end;
end;

procedure TFixedAssetGUI.RefreshDepreciationCalcsToMem(const DepreciationNo: integer);
begin
  if (DepreciationNo = 1) then begin
    qryDepreciationCalcs1.Close;
    qryDepreciationCalcs1.ParamByName('ID').AsInteger := qryAssetAssetID.AsInteger;
    qryDepreciationCalcs1.Open;
    //       memDepreciationCalcs1.Close;
    //       memDepreciationCalcs1.EmptyTable;
    memDepreciationCalcs1.LoadFromDataSet(qryDepreciationCalcs1, []);
    memDepreciationCalcs1.Open;
    ResetgrdDepreciationCalcs(1);
    memDepreciationCalcs1.SortOn('Year;MonthNo', []);
    memDepreciationCalcs1.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]), [loCaseInsensitive]);
  end else if (DepreciationNo = 2) then begin
    qryDepreciationCalcs2.Close;
    qryDepreciationCalcs2.ParamByName('ID').AsInteger := qryAssetAssetID.AsInteger;
    qryDepreciationCalcs2.Open;
    //       memDepreciationCalcs2.Close;
    //       memDepreciationCalcs2.EmptyTable;
    memDepreciationCalcs2.LoadFromDataSet(qryDepreciationCalcs2, []);
    memDepreciationCalcs2.Open;
    ResetgrdDepreciationCalcs(2);
    memDepreciationCalcs2.SortOn('Year;MonthNo', []);
    memDepreciationCalcs2.Locate('Year;MonthNo', VarArrayOf([YearOf(Now()), MonthOf(Now())]), [loCaseInsensitive]);
  end;
end;

procedure TFixedAssetGUI.RefreshPic(DataSet: TDataSet);
begin
  ImagesLib.RefreshDsImage(DataSet, 'Image', 'Imagetype' , ImgImages,  pnlImage , pnlPicturetype);
end;

procedure TFixedAssetGUI.cboAssetTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryAssetEdit;
  //#1
  qryAssetDepreciationOption.AsFloat := qryfixedassettypesDepreciationOption.AsFloat;
  qryAssetSalvageType.AsFloat := qryfixedassettypesSalvageType.AsFloat;
  qryAssetSalvageFactor.AsFloat := qryfixedassettypesSalvageFactor.AsFloat;
  qryAssetLife.AsFloat := qryfixedassettypesLife.AsFloat;
  qryAssetSalvage.AsFloat := qryfixedassettypesSalvage.AsFloat;
  qryAssetBusinessUsePercent.AsFloat := 100;

  //#2
  qryAssetDepreciationOption2.AsFloat := qryfixedassettypesDepreciationOption.AsFloat;
  qryAssetSalvageType2.AsFloat := qryfixedassettypesSalvageType.AsFloat;
  qryAssetSalvageFactor2.AsFloat := qryfixedassettypesSalvageFactor.AsFloat;
  qryAssetLife2.AsFloat := qryfixedassettypesLife.AsFloat;
  qryAssetSalvage2.AsFloat := qryfixedassettypesSalvage.AsFloat;
  qryAssetBusinessUsePercent2.AsFloat := 100;

  qryAssetPost;
  qryAssetEdit;
end;


procedure TFixedAssetGUI.cboPurchDateExit(Sender: TObject);
begin
  inherited;
  if (CleanPurchDate = 0) or (CleanPurchDate = qryAsset.FieldByName('PurchDate').AsDateTime) then exit;

  CheckDates;

//  if (qryAsset.FieldByName(cboPurchDate.DataField).AsDateTime <= AppEnv.CompanyPrefs.ClosingDate) then begin
//    CommonLib.MessageDlgXP_Vista('You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 +
//      'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' + #13 +
//      #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', mtWarning, [mbOK], 0);
//    qryAsset.FieldByName(cboPurchDate.DataField).AsDateTime := Now;
//    SetControlFocus(cboPurchDate);
//  end;
//  if (qryAsset.FieldByName('DepreciationStartDate').AsDateTime < qryAsset.FieldByName('PurchDate').AsDateTime) then
//    qryAsset.FieldByName('DepreciationStartDate').AsDateTime := qryAsset.FieldByName('PurchDate').AsDateTime;
end;

procedure TFixedAssetGUI.qryAssetPurchDateChange(Sender: TField);
begin
  inherited;
  if not qryAsset.Active then Exit;
  if (qryAssetPurchCost.AsCurrency <> 0.00) then begin
    if not PurchDateChangedFlag then begin
      PurchDateChangedFlag := true;
      btnCalculate.Click;
      btnCalculate2.Click;
      PurchDateChangedFlag := false;
    end;
  end;
end;

procedure TFixedAssetGUI.chkDepreciateMonthlyClick(Sender: TObject);
begin
  inherited;
  qryAssetPurchDateChange(nil);
end;

procedure TFixedAssetGUI.ResetgrdDepreciationCalcs(const DepreciationNo: integer);
begin
  if (DepreciationNo = 1) then begin
    if (AppEnv.CompanyPrefs.DepreciationCalculationConventions1 = 'Full Month') then begin
      grdDepreciationCalcs1.ColumnByName('Year').DisplayWidth := 9;
      grdDepreciationCalcs1.ColumnByName('Month').DisplayWidth := 12;
      grdDepreciationCalcs1.ColumnByName('Depreciation').DisplayWidth := 13;
      grdDepreciationCalcs1.ColumnByName('TotalDepreciation').DisplayWidth := 13;
      grdDepreciationCalcs1.ColumnByName('BookValue').DisplayWidth := 13;
    end else begin
      grdDepreciationCalcs1.RemoveField('Month');
      grdDepreciationCalcs1.ColumnByName('Year').DisplayWidth := 10;
      grdDepreciationCalcs1.ColumnByName('Depreciation').DisplayWidth := 16;
      grdDepreciationCalcs1.ColumnByName('TotalDepreciation').DisplayWidth := 16;
      grdDepreciationCalcs1.ColumnByName('BookValue').DisplayWidth := 16;
    end;
  end else if (DepreciationNo = 2) then begin
    if (AppEnv.CompanyPrefs.DepreciationCalculationConventions2 = 'Full Month') then begin
      grdDepreciationCalcs2.ColumnByName('Year').DisplayWidth := 9;
      grdDepreciationCalcs2.ColumnByName('Month').DisplayWidth := 12;
      grdDepreciationCalcs2.ColumnByName('Depreciation').DisplayWidth := 13;
      grdDepreciationCalcs2.ColumnByName('TotalDepreciation').DisplayWidth := 13;
      grdDepreciationCalcs2.ColumnByName('BookValue').DisplayWidth := 13;
    end else begin
      grdDepreciationCalcs2.RemoveField('Month');
      grdDepreciationCalcs2.ColumnByName('Year').DisplayWidth := 10;
      grdDepreciationCalcs2.ColumnByName('Depreciation').DisplayWidth := 16;
      grdDepreciationCalcs2.ColumnByName('TotalDepreciation').DisplayWidth := 16;
      grdDepreciationCalcs2.ColumnByName('BookValue').DisplayWidth := 16;
    end;
  end;
end;

procedure TFixedAssetGUI.SetDefaultAssetAccounts;
begin
  qryAssetEdit;
  {#1}
  if Empty(qryAssetFixedAssetDepreciationAccountName.AsString) then begin
    qryAssetFixedAssetDepreciationAccountName.AsString := AppEnv.CompanyPrefs.FixedAssetDepreciationExpAccount;
    qryAssetFixedAssetDepreciationAccountID.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetDepreciationExpAccount);
  end;

  if Empty(qryAssetFixedAssetCostAccountName.AsString) then begin
    qryAssetFixedAssetCostAccountName.AsString := AppEnv.CompanyPrefs.FixedAssetCostAssetAccount;
    qryAssetFixedAssetCostAccountID.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetCostAssetAccount);
  end;

  if Empty(qryAssetClearingAccountName.AsString) then begin
    qryAssetClearingAccountName.AsString := AppEnv.CompanyPrefs.FixedAssetClearingAccount;
    qryAssetClearingAccountID.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetClearingAccount);
  end;

  if Empty(qryAssetFixedAssetDepreciationAssetAccountName.AsString) then begin
    qryAssetFixedAssetDepreciationAssetAccountName.AsString := AppEnv.CompanyPrefs.FixedAssetDepreciationAssetAccount;
    qryAssetFixedAssetDepreciationAssetAccountID.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetDepreciationAssetAccount);
  end;

  {#2}
  if Empty(qryAssetFixedAssetDepreciationAccountName2.AsString) then begin
    qryAssetFixedAssetDepreciationAccountName2.AsString := AppEnv.CompanyPrefs.FixedAssetDepreciationExpAccount;
    qryAssetFixedAssetDepreciationAccountID2.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetDepreciationExpAccount);
  end;

  if Empty(qryAssetFixedAssetCostAccountName2.AsString) then begin
    qryAssetFixedAssetCostAccountName2.AsString := AppEnv.CompanyPrefs.FixedAssetCostAssetAccount;
    qryAssetFixedAssetCostAccountID2.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetCostAssetAccount);
  end;

  if Empty(qryAssetClearingAccountName2.AsString) then begin
    qryAssetClearingAccountName2.AsString := AppEnv.CompanyPrefs.FixedAssetClearingAccount;
    qryAssetClearingAccountID2.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetClearingAccount);
  end;

  if Empty(qryAssetFixedAssetDepreciationAssetAccountName2.AsString) then begin
    qryAssetFixedAssetDepreciationAssetAccountName2.AsString := AppEnv.CompanyPrefs.FixedAssetDepreciationAssetAccount;
    qryAssetFixedAssetDepreciationAssetAccountID2.AsInteger  := GetAccountID(AppEnv.CompanyPrefs.FixedAssetDepreciationAssetAccount);
  end;

  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryAssetEdit;
  qryAssetSupplierID.AsInteger := cboClientLookup.FieldByName('ClientID').AsInteger;
end;

procedure TFixedAssetGUI.btnProductBarcodeClick(Sender: TObject);
begin
  inherited;
  qryAssetEdit;
  qryAssetBARCODE.AsString := GetPartBarcode(qryAssetPARTSID.AsInteger);
end;

procedure TFixedAssetGUI.cboDepreciationOption2Change(Sender: TObject);
begin
  inherited;
  if cboDepreciationOption2.Value <> '3' then begin
    cboDepreciationOption2.Width := 229;
    SalvageFactor2.Visible       := false;
    Salvage2.Enabled:= true;
    cboSalvageType2.Enabled:= true;
    lblSalvage2.Enabled:= true;
  end else begin
    cboDepreciationOption2.Width := 157;
    SalvageFactor2.Visible       := true;
    Salvage2.Enabled:= false;
    cboSalvageType2.Enabled:= false;
    lblSalvage2.Enabled:= false;
  end;
end;

procedure TFixedAssetGUI.btnCalculate2Click(Sender: TObject);
var
  SalvageValue: double;
begin
  DisableForm;
  try
    inherited;

    //Set UnSet Accounts
    SetDefaultAssetAccounts;

    if (qryAssetSalvageType2.AsInteger = 2) then begin
      SalvageValue := qryAssetPurchCost.AsFloat * (qryAssetSalvage2.AsFloat / 100); //Percent salvage
    end else begin
      SalvageValue := qryAssetSalvage.AsFloat;    //Amount salvage
    end;


    CalculateDepreciation(memDepreciationCalcs2, 2,
    qryAssetAssetID.AsInteger,
    cboDepreciationOption2.Text,
    qryAssetPurchDate.AsDateTime,
    qryAssetPurchCost.AsFloat,
    qryAssetSalvageFactor2.AsFloat,
    SalvageValue,
    qryAssetLife2.AsFloat,
    qryAssetPriorAccumDeprec2.AsString,
    qryAssetPriorAccumDeprecAmount2.AsFloat,
    qryAssetPriorAccumDeprecDate2.AsString,
    qryAssetBusinessUsePercent2.AsFloat,
    qryAssetDisposal.AsBoolean,
    qryAssetDisposalDate2.AsDateTime);
  finally
    EnableForm;
  end;
end;

procedure TFixedAssetGUI.FormCreate(Sender: TObject);
begin
  inherited;
  lblDayMatch.Caption := '';

  if ErrorOccurred then Exit;
  ffrmList0 := TServiceLogListGUI.Create(pnlHistory);              // Service Log
  ffrmList0.chkIgnoreDates.Checked := true;
  {To Stop FindExistingComponent Finding This Instance}
  if Assigned(ffrmList0) then ffrmList0.Tag := 99;
  fFixedAssetREpairList := TfmFixedAssetRepairList.Create(pnlHistory);
  if Assigned(fFixedAssetREpairList) then fFixedAssetREpairList.Tag := 99;


  bFromSerialNumbersForm := false;
end;

procedure TFixedAssetGUI.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  MemoNotes.Lines.Text := MemoNotes.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ')' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
  qryAssetEdit;
  qryAssetNotes.AsString := MemoNotes.Lines.Text;
  MemoNotes.Update;
end;

procedure TFixedAssetGUI.btnAddPicClick(Sender: TObject);
begin
  DisableForm;
  try
    SelectPicture(TpotAssetPicture, self, self.qryPictures , qryPicturesAssetPictureId.fieldname, self.qryPicturesImage.FieldName, True, qryPicturesImagetype.FieldName, true);
  finally
    EnableForm;
    navPartPic.visible := False;
    navPartPic.visible := TRue;
    application.ProcessMessages;
  end;
end;

procedure TFixedAssetGUI.cboSalvageType2Change(Sender: TObject);
begin
  inherited;
  if (cboSalvageType2.Text = 'Amount') then begin
    qryAssetSalvage2.currency      := true;
    qryAssetSalvage2.DisplayFormat := '';
  end else begin
    qryAssetSalvage2.currency      := false;
    qryAssetSalvage2.DisplayFormat := '0.00%';
    if qryAssetSalvage2.AsFloat > 100.00 then qryAssetSalvage2.AsFloat := 0.00;
  end;
end;

procedure TFixedAssetGUI.qryAssetPARTNAMEChange(Sender: TField);
begin
  inherited;
  if not qryParts.Active then Exit;
  qryAssetEdit;
  qryAssetPARTSID.AsInteger := qryPartsPARTSID.AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetFixedAssetCostAccountNameChange(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetFixedAssetCostAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetFixedAssetCostAccountName2Change(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetFixedAssetCostAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetFixedAssetDepreciationAssetAccountNameChange(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetFixedAssetDepreciationAssetAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetFixedAssetDepreciationAssetAccountName2Change(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetFixedAssetDepreciationAssetAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetClearingAccountNameChange(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetClearingAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetAfterOpen(DataSet: TDataSet);
begin
  inherited;
  AttachmentForm;
end;

procedure TFixedAssetGUI.qryAssetAfterPost(DataSet: TDataSet);
begin
  inherited;
  if (qryAssetMsUpdateSiteCode.asString  = AppEnv.Branch.SiteCode) and (qryAssetGlobalRef.asString <> '' ) then exit;
  EditDB(qryAsset);
  try
    if qryAssetMsUpdateSiteCode.asString  <> AppEnv.Branch.SiteCode then
      qryAssetMsUpdateSiteCode.asString := AppEnv.Branch.SiteCode;
  if (qryAssetAssetId.asInteger > 0) and (qryAssetGlobalRef.asString = '') then
    qryAssetGlobalRef.asString := AppEnv.Branch.SiteCode + IntToStr(qryAssetAssetId.asInteger);
  finally
    PostDB(qryAsset);
  end;

end;

procedure TFixedAssetGUI.qryAssetClearingAccountName2Change(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetClearingAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetFixedAssetDepreciationAccountNameChange(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetFixedAssetDepreciationAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.qryAssetFixedAssetDepreciationAccountName2Change(Sender: TField);
begin
  inherited;
  if not cboAccountQry.Active then Exit;
  qryAssetEdit;
  qryAssetFixedAssetDepreciationAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  qryAssetPost;
  qryAssetEdit;
end;

procedure TFixedAssetGUI.PriorAccumDeprec2Click(Sender: TObject);
begin
  inherited;
  Label58.Enabled := PriorAccumDeprec2.Checked;
  PriorAccumDeprecAmount2.Enabled := PriorAccumDeprec2.Checked;
  Label66.Enabled := PriorAccumDeprec2.Checked;
  PriorAccumDeprecDate2.Enabled := PriorAccumDeprec2.Checked;
end;

procedure TFixedAssetGUI.CheckAccounts;
begin
  qryAssetEdit;

  if cboAccountQry.Locate('AccountName', qryAssetFixedAssetCostAccountName.AsString, [loCaseInsensitive]) then begin
    qryAssetFixedAssetCostAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetFixedAssetCostAccountID.AsInteger := 0;
  end;

  if cboAccountQry.Locate('AccountName', qryAssetFixedAssetCostAccountName2.AsString, [loCaseInsensitive]) then begin
    qryAssetFixedAssetCostAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetFixedAssetCostAccountID2.AsInteger := 0;
  end;

  if cboAccountQry.Locate('AccountName', qryAssetClearingAccountName.AsString, [loCaseInsensitive]) then begin
    qryAssetClearingAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetClearingAccountID.AsInteger := 0;
  end;

  if cboAccountQry.Locate('AccountName', qryAssetClearingAccountName2.AsString, [loCaseInsensitive]) then begin
    qryAssetClearingAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetClearingAccountID2.AsInteger := 0;
  end;

  if cboAccountQry.Locate('AccountName', qryAssetFixedAssetDepreciationAssetAccountName.AsString, [loCaseInsensitive]) then
  begin
    qryAssetFixedAssetDepreciationAssetAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetFixedAssetDepreciationAssetAccountID.AsInteger := 0;
  end;

  if cboAccountQry.Locate('AccountName', qryAssetFixedAssetDepreciationAssetAccountName2.AsString, [loCaseInsensitive]) then
  begin
    qryAssetFixedAssetDepreciationAssetAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetFixedAssetDepreciationAssetAccountID2.AsInteger := 0;
  end;

  if cboAccountQry.Locate('AccountName', qryAssetFixedAssetDepreciationAccountName.AsString, [loCaseInsensitive]) then begin
    qryAssetFixedAssetDepreciationAccountID.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetFixedAssetDepreciationAccountID.AsInteger := 0;
  end;

  if cboAccountQry.Locate('AccountName', qryAssetFixedAssetDepreciationAccountName2.AsString, [loCaseInsensitive]) then
  begin
    qryAssetFixedAssetDepreciationAccountID2.AsInteger := cboAccountQry.FieldByName('AccountID').AsInteger;
  end else begin
    qryAssetFixedAssetDepreciationAccountID2.AsInteger := 0;
  end;

  qryAssetEdit;
  qryAssetPost;
  qryAssetEdit;
end;

function TFixedAssetGUI.ChkAssetsReqdAccounts: boolean;
begin
  Result := true;
  if (AppEnv.CompanyPrefs.DepreciationForTransactions = 1) then begin
    if ((not Empty(qryAssetFixedAssetDepreciationAssetAccountName.AsString) and
      not Empty(qryAssetFixedAssetDepreciationAccountName.AsString)) or
      (Empty(qryAssetFixedAssetDepreciationAssetAccountName.AsString) and
      Empty(qryAssetFixedAssetDepreciationAccountName.AsString))) then begin
      if ((not Empty(qryAssetClearingAccountName.AsString) and not Empty(qryAssetFixedAssetCostAccountName.AsString)) or
        (Empty(qryAssetClearingAccountName.AsString) and Empty(qryAssetFixedAssetCostAccountName.AsString))) then begin
        Exit;
      end else begin
        CommonLib.MessageDlgXP_Vista('Both "Fixed Assets Cost Asset Account"' + #13#10 + ' AND "Fixed Assets Clearing Account" Must Be Entered.',
          mtWarning, [mbOK], 0);
        PageControl1.ActivePage := Depreciation1;
        SetControlFocus(cboFixedAssetsAccount);
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('Both "Fixed Assets Depreciation Asset Account"' + #13#10 +
        ' AND "Fixed Assets Depreciation Expense Account" Must Be Entered.', mtWarning, [mbOK], 0);
      PageControl1.ActivePage := Depreciation1;
      SetControlFocus(cboFixedAssetsDepreciationAccount);
    end;
  end else if (AppEnv.CompanyPrefs.DepreciationForTransactions = 2) then begin
    if ((not Empty(qryAssetFixedAssetDepreciationAssetAccountName2.AsString) and
      not Empty(qryAssetFixedAssetDepreciationAccountName2.AsString)) or
      (Empty(qryAssetFixedAssetDepreciationAssetAccountName2.AsString) and
      Empty(qryAssetFixedAssetDepreciationAccountName2.AsString))) then begin
      if ((not Empty(qryAssetClearingAccountName2.AsString) and not Empty(qryAssetFixedAssetCostAccountName2.AsString)) or
        (Empty(qryAssetClearingAccountName2.AsString) and Empty(qryAssetFixedAssetCostAccountName2.AsString))) then begin
        Exit;
      end else begin
        CommonLib.MessageDlgXP_Vista('Both "Fixed Assets Cost Asset Account"' + #13#10 + ' AND "Fixed Assets Clearing Account" Must Be Entered.',
          mtWarning, [mbOK], 0);
        PageControl1.ActivePage := Depreciation2;
        SetControlFocus(cboFixedAssetAccountName2);
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('Both "Fixed Assets Depreciation Asset Account"' + #13#10 +
        'AND "Fixed Assets Depreciation Expense Account" Must Be Entered.', mtWarning, [mbOK], 0);
      PageControl1.ActivePage := Depreciation2;
      SetControlFocus(cboFixedAssetDepreciationAssetAccountName2);
    end;
  end;
  Result := false;
end;

procedure TFixedAssetGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(ffrmList0) then
    FreeandNil(ffrmList0);
  fFixedAssetREpairList.Free;
//  if Assigned(ffrmList1) then
//    FreeandNil(ffrmList1);
//  if Assigned(ffrmList2) then
//    FreeandNil(ffrmList2);
//  if Assigned(ffrmList3) then
//    FreeandNil(ffrmList3);
  inherited;
end;

procedure TFixedAssetGUI.btnProductSerialClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    LoadSerials;//(qryAssetPARTSID.AsInteger, qryAssetClassID.AsInteger);
    dlgSerialSelect.MultiSelect := false;
    if (dlgSerialSelect.Items.Count > 0) then begin
      if dlgSerialSelect.Execute then begin
        qryAssetEdit;
        qryAssetSerial.AsString := Trim(dlgSerialSelect.SelectedItems.Text);
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('There Are No Serial Numbers For This Product On This ' + AppEnv.DefaultClass.ClassHeading, mtInformation, [mbOK], 0);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TFixedAssetGUI.btnStretchClick(Sender: TObject);
begin
  DisableForm;
  try
    ImgImages.Stretch := not(ImgImages.Stretch);
  finally
    EnableForm;
  end;
end;

procedure TFixedAssetGUI.LoadSerials;//(const PartsID, ClassID: integer);
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
end;

function TFixedAssetGUI.SaveFixedAsset: boolean;
begin
  Result := false;
  try
    if not ChkAssetsReqdFields() then begin
      Exit;
    end;

    if not ChkAssetsReqdAccounts() then begin
      Exit;
    end;

    SaveTransaction;
    Result := true;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

function TFixedAssetGUI.CloneAsset(const SerialNo: string): integer;
var
  tblClone: TERPQuery;
begin
  tblClone := TERPQuery.Create(self);
  try
    //tblClone.Clone(qryAsset);
    CloneDataSet(qryAsset, tblClone);
    tblClone.Connection := qryAsset.Connection;
    tblClone.Open;
    tblClone.Locate('AssetID', qryAssetAssetID.AsInteger, [loCaseInsensitive]);        // set to our record

    Result := CloneRecord(tblClone, 'AssetID');

    tblClone.Filtered := false;
    tblClone.Filter   := 'AssetID = ' + IntToStr(Result);
    tblClone.Filtered := true;
    tblClone.Edit;
    tblClone.FieldByName('AssetCode').AsString := tblClone.FieldByName('AssetCode').AsString + ' - ' + SerialNo;
    tblClone.FieldByName('Serial').AsString    := SerialNo;
    tblClone.FieldByName('AssetName').AsString := tblClone.FieldByName('AssetName').AsString + ' - ' + SerialNo;
    tblClone.Post;
  finally
    FreeandNil(tblClone);
  end;
end;

function TFixedAssetGUI.CloneAssetDetails(const OldID, NewID, DepreciationNo: integer): boolean;
var
  tblClone      : TERPQuery;
  iNewDetailIDs : TClonedRecords;
  i             : integer;
begin
  iNewDetailIDs := nil;
  Result := false;
  tblClone := TERPQuery.Create(self);
  tblClone.Connection := qryAsset.Connection;
  try
    tblClone.Sql.Clear;
    if (DepreciationNo = 1) then begin
      tblClone.Sql.Add('Select * From tblfixedassetsdepreciationdetails Where AssetID=' + IntToStr(OldID) + ';')
    end else if (DepreciationNo = 2) then begin
      tblClone.Sql.Add('Select * From tblfixedassetsdepreciationdetails2 Where AssetID=' + IntToStr(OldID) + ';')
    end else begin
      Exit;
    end;

    tblClone.Open;
    iNewDetailIDs := CloneRecords(TCustomMyDataSet(tblClone), 'AssetDepreciationID');
    tblClone.Close;

    with tblClone do begin
      for i := Low(iNewDetailIDs) to High(iNewDetailIDs) do begin
        Sql.Clear;

        if (DepreciationNo = 1) then begin
          tblClone.Sql.Add('Select * From tblfixedassetsdepreciationdetails Where AssetDepreciationID = ' +
            IntToStr(iNewDetailIDs[i]) + ';')
        end else if (DepreciationNo = 2) then begin
          tblClone.Sql.Add('Select * From tblfixedassetsdepreciationdetails2 Where AssetDepreciationID = ' +
            IntToStr(iNewDetailIDs[i]) + ';')
        end;

        Open;

        if not tblClone.IsEmpty then begin
          Edit;
          FieldByName('AssetID').AsInteger := NewID;
          Post;
        end;
      end;
    end;

    Result := true;
  finally
    FreeandNil(tblClone);
  end;
end;

procedure TFixedAssetGUI.actFACloneUpdate(Sender: TObject);
begin
  inherited;
  if not FromSerialNumbersForm then begin
    btnClone.Enabled := (not Empty(qryAssetPARTSID.AsString) and (qryAssetPARTSID.AsString <> '0'))
      and (not Empty(qryAssetClassID.AsString) and (qryAssetClassID.AsString <> '0'));

    btnProductSerial.Enabled := btnClone.Enabled;
  end else begin
    btnProductSerial.Enabled := false;
    btnClone.Enabled         := false;
  end;
end;

procedure TFixedAssetGUI.actFACloneExecute(Sender: TObject);
var
  I, NewID      : integer;
  slSerials     : TStringList;
  slSerialsList : TStringList;
begin
  DisableForm;
  try
    inherited;
    // If we are not coming from the Serials List Form.
    if not FromSerialNumbersForm then begin
      Application.ProcessMessages;

      LoadSerials;//(qryAssetPARTSID.AsInteger, qryAssetClassID.AsInteger);

      dlgSerialSelect.MultiSelect := true;
      Application.ProcessMessages;

      if (dlgSerialSelect.Items.Count > 0) then begin
        if dlgSerialSelect.Execute then begin
          if not SaveFixedAsset then Exit;

          Application.ProcessMessages;
          Processingcursor(True);
          Application.ProcessMessages;

          try
            for I := 0 to dlgSerialSelect.SelectedItems.Count - 1 do begin
              NewID := CloneAsset(dlgSerialSelect.SelectedItems[I]);
              Application.ProcessMessages;
              CloneAssetDetails(qryAssetAssetID.AsInteger, NewID, 1);

              Application.ProcessMessages;
              CloneAssetDetails(qryAssetAssetID.AsInteger, NewID, 2);
            end;
          finally
            Processingcursor(False);
          end;
        end else begin
          Exit;
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('There Are NO Serial Numbers for this Product on this ' + AppEnv.DefaultClass.ClassHeading,
          mtInformation, [mbOK], 0);
        Exit;
      end;
    end else begin
      slSerials     := TStringList.Create;
      slSerialsList := TStringList.Create;
      slSerialsList.Clear;
      Processingcursor(True);

      Application.ProcessMessages;

      try
        for I := 1 to SerialNumberList.Count - 1 do begin
          slSerials.Clear;
          ExtractStrings(['|'], [' '], PChar(SerialNumberList.Strings[I]), slSerials);
          slSerialsList.Add(slSerials.Strings[0]);
        end;

        // Now perform the mass clone.
        for I := 0 to slSerialsList.Count - 1 do begin
          NewID := CloneAsset(slSerialsList.Strings[I]);
          Application.ProcessMessages;
          CloneAssetDetails(qryAssetAssetID.AsInteger, NewID, 1);

          Application.ProcessMessages;
          CloneAssetDetails(qryAssetAssetID.AsInteger, NewID, 2);
        end;

      finally
        // Free our used objects.
        Processingcursor(False);
        if Assigned(slSerials) then
          FreeandNil(slSerials);
        if Assigned(slSerialsList) then
          FreeandNil(slSerialsList);
      end;
    end;

    // Notify our list.
    Notify;
    // Close form.
    Self.Close;
  finally
    EnableForm;
  end;  
end;

function TFixedAssetGUI.CalculateChildAssetTotals(KeyID: integer): double;
var
  qryTotalChildAssets: TERPQuery;
begin
  Result := 0;

  // If Parent
  if KeyID = 0 then Exit;

  // Create an instance of qryTotalChildAssets
  qryTotalChildAssets := TERPQuery.Create(nil);
  try
    // Establish a connection
    qryTotalChildAssets.Connection := CommonDbLib.GetSharedMyDacConnection;
    // Clear SQL
    qryTotalChildAssets.SQL.Clear;
    with qryTotalChildAssets do begin
      // Define the SQL statements and open the query
      Sql.Add('SELECT AssetID, SUM(tblfixedassets.PurchCost) as TotalChildAssets');
      Sql.Add('FROM tblfixedassets');
      Sql.Add('WHERE ParentID=' + QuotedStr(IntToStr(KeyID)) + '');
      Sql.Add('GROUP BY ParentID');
      Open;

      // Assign the TotalChildAssets to result
      if RecordCount > 0 then begin
        Result := FieldByName('TotalChildAssets').AsFloat;
      end;
    end;
  finally
    // Free the query allocation
    if Assigned(qryTotalChildAssets) then
      FreeandNil(qryTotalChildAssets);
  end;
end;

procedure TFixedAssetGUI.UpdateParentsTotalAsset(KeyID: integer; Value: double);
var
  qryUpDate: TERPQuery;
begin
  // Create an instance of qryTotalChildAssets
  qryUpDate := TERPQuery.Create(nil);
  try
    // Establish a connection
    qryUpDate.Connection := CommonDbLib.GetSharedMyDacConnection;

    // Clear SQL
    qryUpDate.SQL.Clear;
    with qryUpDate do begin
      // Define the SQL statements and open the query
      SQL.Add('UPDATE tblfixedassets');
      SQL.Add('SET TotalChildAsset = ' + QuotedStr(FloatToStr(Value)) + ' + PurchCost ');
      Sql.Add('WHERE AssetID=' + QuotedStr(IntToStr(KeyID)) + '');
      Try
        Execute;
      Except
        on E: EMyError do;
        on E: EMySqlException do;
        else raise;
      end;
    end;
  finally
    // Free the query allocation
    if Assigned(qryUpDate) then
      FreeandNil(qryUpDate);
  end;
end;

procedure TFixedAssetGUI.RemoveAssetCostFromParent(KeyID: integer; Value: double);
var
  qryUpDate: TERPQuery;
begin
  // Create an instance of qryTotalChildAssets
  qryUpDate := TERPQuery.Create(nil);
  try
    // Establish a connection
    qryUpDate.Connection := CommonDbLib.GetSharedMyDacConnection;

    // Clear SQL
    qryUpDate.SQL.Clear;
    with qryUpDate do begin
      // Define the SQL statements and open the query
      SQL.Add('UPDATE tblfixedassets');
      SQL.Add('SET TotalChildAsset = TotalChildAsset -' + QuotedStr(FloatToStr(Value)) + ' ');
      Sql.Add('WHERE AssetID=' + QuotedStr(IntToStr(KeyID)) + '');
      Try
        Execute;
      Except
        on E: EMyError do;
        on E: EMySqlException do;
        else raise;
      end;
    end;
  finally
    // Free the query allocation
    if Assigned(qryUpDate) then
      FreeandNil(qryUpDate);
  end;
end;

procedure TFixedAssetGUI.wwDBLookupParentAssetIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  // Ensure default of no parent is set in backend
  if wwDBLookupParentAssetID.Text = '' then qryAssetParentID.AsInteger := 0;
end;

procedure TFixedAssetGUI.qryChildAssetsNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryChildAssets.FieldByName('ParentID').AsInteger := qryAssetAssetID.AsInteger;
end;

procedure TFixedAssetGUI.qryFAPercentagesClassNameChange(Sender: TField);
begin
  inherited;
  qryFAPercentagesClassID.AsInteger := cboClassQry.FieldByName('ClassID').AsInteger;
end;

procedure TFixedAssetGUI.qryFAPercentagesNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryFAPercentagesAssetID.AsInteger := qryAssetAssetID.AsInteger;
  qryFAPercentagesActive.AsBoolean := True;
end;

procedure TFixedAssetGUI.qryPicturesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  self.qryPicturesmsUpdateSiteCode.AsString := AppEnv.Branch.SiteCode;
  self.qryPicturesAssetId.AsInteger := self.qryAssetAssetID.AsInteger;
end;

procedure TFixedAssetGUI.qryPicturesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshPic(dataset);
end;

procedure TFixedAssetGUI.qryPicturesAfterPost(DataSet: TDataSet);
begin
  inherited;
  if self.qryPicturesGlobalref.AsString = '' then begin
    EditDb(qryPictures);
    self.qryPicturesGlobalref.AsString := AppEnv.Branch.SiteCode + self.qryPicturesAssetPictureId.AsString;
    PostDb(qryPictures);
  end;
  RefreshPic(dataset);
end;

procedure TFixedAssetGUI.qryPicturesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshPic(dataset);
end;

procedure TFixedAssetGUI.qryPicturesBeforeDelete(DataSet: TDataSet);
var
  msg: string;
begin
  inherited;
  if self.qryPicturesGlobalref.AsString <> '' then begin
    TDeletedItem.AddDeleted('tblAssetPicture','TAssetPicture',qryPicturesGlobalref.AsString,qryPicturesAssetPictureId.AsInteger,qryPictures.Connection,msg,false);
  end;
end;

procedure TFixedAssetGUI.grdFAPercentageIButtonClick(Sender: TObject);
begin
  inherited;
  if qryFAPercentages.RecordCount > 0 then begin
    if (CommonLib.MessageDlgXP_Vista('Do you wish to delete current record?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      qryFAPercentages.Edit;
      qryFAPercentages.FieldByName('Active').AsBoolean := False;
      qryFAPercentages.Post;
      qryFAPercentages.Refresh;
    end;  
  end;
end;

procedure TFixedAssetGUI.TotalsPercentages;
var
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
  grdFAPercentage.ColumnByName('Depreciation').FooterValue := FloatToStrF(Depreciation,ffFixed, 15, 2) + '%';
end;

procedure TFixedAssetGUI.qryFAPercentagesAfterPost(DataSet: TDataSet);
begin
  inherited;
  TotalsPercentages;
end;

procedure TFixedAssetGUI.grdDepreciationCalcs1CalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Field.DataSet.FieldByName('Date').AsDateTime < qryAssetDepreciationStartDate.AsDateTime then
    aBrush.Color := clLtGray;
end;

procedure TFixedAssetGUI.grdFAPercentageColExit(Sender: TObject);
begin
  inherited;
  TotalsPercentages;
end;

procedure TFixedAssetGUI.AddPercentageDefaultClassIfEmpty;
begin
  if qryFAPercentages.Bof and qryFAPercentages.Eof then
  begin
    qryFAPercentages.DisableControls;
    qryFAPercentages.Insert;
    cboClassQry.Locate('ClassID', 1, []);
    qryFAPercentagesClassName.AsString := cboClassQryClassName.AsString;
    qryFAPercentagesCost.AsInteger := 100;
    qryFAPercentagesDepreciation.AsInteger := 100;
    qryFAPercentages.Post;
    qryFAPercentages.EnableControls;
  end;
end;

function TFixedAssetGUI.AttachmentForm: TfmAttachments;
begin
  If not Assigned(fAttachmentForm) then Begin
    PostDb(qryAsset);
    fAttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True, self.qryAssetAssetID.AsInteger));
    fAttachmentForm.DBConnection := MyConnection;
    fAttachmentForm.AttachObserver(Self);
    fAttachmentForm.TableName := 'tblFixedAssets';
    fAttachmentForm.TableId := self.qryAssetAssetID.AsInteger;
    fAttachmentForm.Tag := self.qryAssetAssetID.AsInteger;
    fAttachmentForm.lvAttachments.Parent := pnlAttachments;
    fAttachmentForm.lvAttachments.Align := alClient;
    fAttachmentForm.PopulateListView;
  end;
  if fAttachmentForm.TableId <> self.qryAssetAssetID.AsInteger then begin
    fAttachmentForm.TableId := self.qryAssetAssetID.AsInteger;
    fAttachmentForm.Tag := self.qryAssetAssetID.AsInteger;
  end;
  result := fAttachmentForm;
end;

procedure TFixedAssetGUI.cboDepreciationOptionCloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  if cboDepreciationOption.Value = '3' then begin
    if (qryAsset.State in [dsEdit, dsInsert]) then begin
      qryAssetSalvageFactor.AsFloat:= 200;
      qryAssetSalvage.AsFloat:= 0;
    end;
  end
end;

procedure TFixedAssetGUI.cboDepreciationStartDateExit(Sender: TObject);
begin
  inherited;
  if (CleanDepreciationStartDate = 0) or (CleanDepreciationStartDate = qryAsset.FieldByName('DepreciationStartDate').AsDateTime) then exit;

  CheckDates;
//  if (qryAsset.FieldByName(cboDepreciationStartDate.DataField).AsDateTime <= AppEnv.CompanyPrefs.ClosingDate) then begin
//    CommonLib.MessageDlgXP_Vista('You Have Set This Date Before The Closing Date !' + #13 + #10 + '' + #13 + #10 +
//      'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13 + #10 + 'OR' + #13 +
//      #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.', mtWarning, [mbOK], 0);
//    qryAsset.FieldByName(cboDepreciationStartDate.DataField).AsDateTime := Now;
//    SetControlFocus(cboDepreciationStartDate);
//  end;
//  if (qryAsset.FieldByName('DepreciationStartDate').AsDateTime < qryAsset.FieldByName('PurchDate').AsDateTime) then
//    qryAsset.FieldByName('DepreciationStartDate').AsDateTime := qryAsset.FieldByName('PurchDate').AsDateTime;
end;

procedure TFixedAssetGUI.cboDepreciationOption2CloseUp(
  Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  if cboDepreciationOption2.Value = '3' then begin
    if (qryAsset.State in [dsEdit, dsInsert]) then begin
      qryAssetSalvageFactor2.AsFloat:= 200;
      qryAssetSalvage2.AsFloat:= 0;
    end;
  end
end;

initialization
  (*
  RegisterClassOnce(TFixedAssetGUI);
  with FormFact do begin
//    RegisterMe(TFixedAssetGUI, 'TfrmFixedAssetProfitabilityList_*=AssetID');
    RegisterMe(TFixedAssetGUI, 'TReminderListGUI_*_Fixed Asset Insurance due to Expire=ID');
    RegisterMe(TFixedAssetGUI, 'TReminderListGUI_*_Fixed Asset Warranty due to Expire=ID');
    RegisterMe(TFixedAssetGUI, 'TfrmFixedAssetsDetails_*=AssetID');
    RegisterMe(TFixedAssetGUI, 'TFixedAssetsListGUI_*=AssetID');
    RegisterMe(TFixedAssetGUI, 'TAssetRegisterListGUI_*=AssetID');
    RegisterMe(TFixedAssetGUI, 'TCheckWarranty_InsurancePolicyGUI_*=AssetID');
    RegisterMe(TFixedAssetGUI, 'TTransAccountDetailsGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TBalTransListGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TToBeReconciledGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TReconListDetailFormGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TTrialBalTransListGUI_*_Fixed Asset=FixedAssetID');

    RegisterMe(TFixedAssetGUI, 'TTransactionListGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TBASTransReturnListGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TNZTransReturnListGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TVATTransReturnListGUI_*_Fixed Asset=FixedAssetID');

    RegisterMe(TFixedAssetGUI, 'TGlobalsearchGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TGeneralLedgerReportGUI_*_Fixed Asset=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TTransAccountDetailsGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TBalTransListGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TToBeReconciledGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TReconListDetailFormGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TTrialBalTransListGUI_*_Fixed Asset Depreciation=FixedAssetID');

    RegisterMe(TFixedAssetGUI, 'TTransactionListGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TBASTransReturnListGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TNZTransReturnListGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TVATTransReturnListGUI_*_Fixed Asset Depreciation=FixedAssetID');

    RegisterMe(TFixedAssetGUI, 'TGlobalsearchGUI_*_Fixed Asset Depreciation=FixedAssetID');
    RegisterMe(TFixedAssetGUI, 'TGeneralLedgerReportGUI_*_Fixed Asset Depreciation=FixedAssetID');  }
  end;
  *)
end.











