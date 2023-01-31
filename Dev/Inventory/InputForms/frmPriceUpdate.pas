unit frmPriceUpdate;

{Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/07/05  1.00.XX DMS  1. Formatted unit's source code.
                        2. Removed PopulateTemporaryTable call from events tied
                           to controls in Fixed Prices area as redundant. This
                           call is made after user pressed on Fixed Prices button.
                        3. Added check for Customer Type and Unit of Measure
                           combos values before proceeding with update.
 26/09/05 1.00.X1 AL    1. Renamed Price Update to "Data Update"
                        2. Made mor visible progress bar by adding a white square
                           as a bottom layer.
                        3. Added "All" CheckBox to ClassPanel, and changed
                           DoClassUpdate procedure.
 19/10/05 1.00.03 DLS   Added RegisterClass
 20/01/06 1.00.04 BJ    Bin/batch selection - debuged
 16/02/06 1.00.05 AL    Changed to use UOM ID instead of UOM Name
 15/09/06 1.00.07 DSP   Added in adjustment to fields PriceInc1, PriceInc2 and
                        PriceInc3 in DoPriceIncOrDec.

 }

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, BaseInputForm, AppEvnts, DB,  StdCtrls, wwdblook, ExtCtrls, DNMPanel, Buttons,
  DNMSpeedButton, ComCtrls,AdvOfficeStatusBar,  SelectionDialog, MemDS, DBAccess, MyAccess,ERPdbComponents, kbmMemTable, DataState, ProgressDialog, Menus, AdvMenus, wwcheckbox, Mask, DBCtrls, MessageConst,
  Shader, ImgList;

type 
  TPriceUpdateGUI = class(TBaseInputGUI)
    pnlVariation: TDNMPanel;
    pnlFilters: TDNMPanel;
    chkAll: TCheckBox;
    Label1: TLabel;
    Label89: TLabel;
    lblFirstCol: TLabel;
    cboFirstCol: TwwDBLookupCombo;
    lblSecondCol: TLabel;
    cboSecondCol: TwwDBLookupCombo;
    lblThirdCol: TLabel;
    cboThirdCol: TwwDBLookupCombo;
    Label4: TLabel;
    cboPartName: TwwDBLookupCombo;
    btnUpdate: TDNMSpeedButton;
    pnlOptions: TPanel;
    grpOption: TRadioGroup;
    grpType: TRadioGroup;
    tbnClose: TDNMSpeedButton;
    Label2: TLabel;
    pnlCustFilters: TDNMPanel;
    Label5: TLabel;
    chkAllCust: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    cboClientType: TwwDBLookupCombo;
    lblNotice: TLabel;
    pnlBatch: TDNMPanel;
    Label8: TLabel;
    chkExtraSell: TCheckBox;
    Label11: TLabel;
    Bevel6: TBevel;
    edtDisc1: TLabeledEdit;
    edtDisc2: TLabeledEdit;
    edtDisc3: TLabeledEdit;
    pnlSelection: TDNMPanel;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    lblInProgress: TLabel;
    lblRecCount: TLabel;
    ProgressBar: TProgressBar;
    edtAmount: TLabeledEdit;
    pnlPrice: TDNMPanel;
    pnlType: TPanel;
    grpPrice: TRadioGroup;
    pnlReOrderOptions: TDNMPanel;
    pnlCorrectExtraSell: TDNMPanel;
    Label13: TLabel;
    Label14: TLabel;
    chkCorrectExtra: TCheckBox;
    qryPartName: TERPQuery;
    qryParts: TERPQuery;
    qryFirstCol: TERPQuery;
    qryProductTypeLookup: TERPQuery;
    cboType: TwwDBLookupCombo;
    qrySecondCol: TERPQuery;
    qryThirdCol: TERPQuery;
    qryClass: TERPQuery;
    qryClientType: TERPQuery;
    tblCustomerLines: TERPQuery;
    qryExtraSell: TERPQuery;
    qrySpecPrices: TERPQuery;
    btnFixedPrice: TDNMSpeedButton;
    Label3: TLabel;
    Label15: TLabel;
    cboUOM: TwwDBLookupCombo;
    qryUOM: TERPQuery;
    chkAllClientTypes: TCheckBox;
    Label16: TLabel;
    chkAllUOM: TCheckBox;
    Label17: TLabel;
    cboClientType2: TwwDBLookupCombo;
    qryClientTypeClientTypeID: TIntegerField;
    qryClientTypeTypeName: TWideStringField;
    qryClientTypeTypeDescription: TWideStringField;
    pnlStatus: TDNMPanel;
    dtFrom: TDateTimePicker;
    Label18: TLabel;
    chkActivate: TCheckBox;
    Label19: TLabel;
    chkDeactivate: TCheckBox;
    Label20: TLabel;
    chkMain: TCheckBox;
    Label21: TLabel;
    tmrESValidate: TTimer;
    pnlClass: TDNMPanel;
    Label12: TLabel;
    lblClass: TLabel;
    cboClass: TwwDBLookupCombo;
    lblReOrderPoint: TLabel;
    lblPreferredLevel: TLabel;
    lblReOrderAmount: TLabel;
    edtReOrderPoints: TEdit;
    edtPreferredLevel: TEdit;
    edtReOrderAmount: TEdit;
    lblReOrder: TLabel;
    chkAllClass: TCheckBox;
    Label22: TLabel;
    Panel2: TPanel;
    grpBatch: TRadioGroup;
    Panel4: TPanel;
    grpBin: TRadioGroup;
    chkBatch: TCheckBox;
    Label9: TLabel;
    chkBin: TCheckBox;
    Label10: TLabel;
    pnlUnitOfMeasure: TDNMPanel;
    Label23: TLabel;
    DSUOM: TDataSource;
    Label24: TLabel;
    edMultiplier: TDBEdit;
    chkSalesDefault: TwwCheckBox;
    chkPurchDefault: TwwCheckBox;
    Label25: TLabel;
    Label26: TLabel;
    qryUOMUnitID: TIntegerField;
    qryUOMUnitName: TWideStringField;
    qryUOMMultiplier: TFloatField;
    qryUOMPartID: TIntegerField;
    qryUOMSalesDefault: TWideStringField;
    qryUOMPurchasesDefault: TWideStringField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    Label27: TLabel;
    Label28: TLabel;
    edtDesc: TDBEdit;
    qryUOMUnitDescription: TWideStringField;
    qryUOMBaseUnitName: TWideStringField;
    qrycboUnitOfMeasure: TERPQuery;
    qrycboUnitOfMeasureUnitName: TWideStringField;
    qrycboUnitOfMeasureUnitID: TAutoIncField;
    qrycboUnitOfMeasureUnitDescription: TWideStringField;
    edtUnit: TwwDBLookupCombo;
    qryUOMBaseUnitID: TIntegerField;
    qryUOMActive: TWideStringField;
    qryUOM2: TERPQuery;
    DSUOM2: TDataSource;
    Panel1: TPanel;
    grpSpecial: TRadioGroup;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel3: TDNMPanel;
    grpSelection: TRadioGroup;
    btnCustomField: TDNMSpeedButton;
    QryUOMExtraSellPrice: TERPQuery;
    IntegerField1: TIntegerField;
    StringField1: TWideStringField;
    FloatField1: TFloatField;
    IntegerField2: TIntegerField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    StringField4: TWideStringField;
    StringField5: TWideStringField;
    IntegerField3: TIntegerField;
    StringField6: TWideStringField;
    cboUOMExtraSell: TwwDBLookupCombo;
    Label29: TLabel;
    qryProductAllocation: TERPQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cboTypeEnter(Sender: TObject);
    procedure chkAllClick(Sender: TObject);
    procedure chkAllCustClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure tbnCloseClick(Sender: TObject);
    procedure cboClientTypeEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkBatchBinClick(Sender: TObject);
    procedure chkExtraSellClick(Sender: TObject);
    procedure grpSelectionClick(Sender: TObject);
    procedure qryBeforePost(DataSet: TDataSet);
    procedure cboTypeClick(Sender: TObject);
    procedure cboSecondColClick(Sender: TObject);
    procedure cboThirdColClick(Sender: TObject);
    procedure cboThirdColDropDown(Sender: TObject);
    procedure cboTypeDropDown(Sender: TObject);
    procedure cboTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure ComboBox1Enter(Sender: TObject);
    procedure cboPartNameBeforeDropDown(Sender: TObject);
    procedure cboFirstColBeforeDropDown(Sender: TObject);
    procedure cboSecondColBeforeDropDown(Sender: TObject);
    procedure grpPriceClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFixedPriceClick(Sender: TObject);
    procedure chkAllClientTypesClick(Sender: TObject);
    procedure chkAllUOMClick(Sender: TObject);
    procedure chkDeactivateClick(Sender: TObject);
    procedure chkActivateClick(Sender: TObject);
    procedure chkMainClick(Sender: TObject);
    procedure cboPartNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure tmrESValidateTimer(Sender: TObject);
    procedure cboFirstColCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure cboSecondColCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure cboThirdColCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure IntegerEditExit(Sender: TObject);
    procedure cboClientType2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure cboUOMCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkBatchClick(Sender: TObject);
    procedure chkBinClick(Sender: TObject);
    procedure edtUnitBeforeDropDown(Sender: TObject);
    procedure btnCustomFieldClick(Sender: TObject);
  private
    rValue: Double;
    FTempTablePopulated: Boolean;
    bIsCostBased: Boolean;
    bIgnoreCheck: Boolean;
    fsOriginalPartsSQL:string;
    fCustomFieldStatement:string;

    function GetClientTypeFilter: string;
    function GetFilter(TblPrefix: string = ''): string;
    function GetGroupString: string;
    function GetNewCostBasedPrice(const rCost: Currency): Currency;
    function GetNewPrice(const rOrigPrice: Currency; const bIsInc, bIsPercent: Boolean): Currency;
    function GetPartWhere: string;
    function IsAnyFilter(const pnl: TPanel): Boolean;
    function IsValidFloat(const Text: string): Boolean;
    procedure CheckFixedPricePreconditions;
    procedure ClearFilterCombos(const pnl: TPanel);
    procedure DoBatchTrack;
    procedure DoClassUpdate;
    procedure DoClassVarianceUpdate;
    procedure DoCorrectExtraSell;
    procedure DoExtraSellUpdate;
    procedure DoFixedPriceUpdate;
    procedure DoMinAboveCost;
    procedure DoMultiBin;
    procedure DoPriceAdjust;
    procedure DoPriceIncOrDec;
    procedure DoSpecAboveCost;
    procedure DoSpecUpdate;
    procedure DoUpdate;
    procedure EditSpecRecord;
    procedure FilterQryExtraSell;
    procedure SetUpdateReOrderControlsEnabled(const Value: Boolean);
    procedure DoUOMUpdate;
    function GetUOMID(const UOMName: string): Integer;
    function GetPartID(const PartName: string): Integer;
    function GetProductUOMPurchDefault(const PartID: Integer): string;
    function GetProductUOMSalesDefault(const PartID: Integer): string;
    function GerPreferredLevel: Integer;
    function GetReOrderAmount: Integer;
    function GetReOrderPoint: Integer;
    function GetTemporaryTableName: string;
    procedure ClearTemporaryTable;
    procedure CreateTemporaryTable;
    procedure DeactivateProducts;
    procedure DropTemporaryTable;
    procedure PopulateTemporaryTable;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    function HasCustomFields:Boolean;
    procedure OpenProductAllocationQry;
    function ProductHasAllocation(const ProductID: Integer): Boolean;
  public
    fsOrigProductSQL: string;
    fsOrigProductNameSQL: string;
    property IsCostBased: Boolean read bIsCostBased write bIsCostBased;
    property ReOrderPoint: Integer read GetReOrderPoint;
    property PreferredLevel: Integer read GerPreferredLevel;
    property ReOrderAmount: Integer read GetReOrderAmount;
  end;
const 
  PRICEUPDATE_TABLENAME: string = 'priceupdate';

implementation
{$R *.dfm}

uses FastFuncs,DNMExceptions,  DNMLib, AuditObj,  CommonDbLib,
  frmProductFixedPriceUpdateGUI, InventoryLib, CommonLib,
   tcDataUtils, AppEnvironment, Vista_MessageDlg,frmPriceUpdateSelection,
   UserUtilsClientObj, MAIN, dmMainGUI;

const
  GRP_INC          = 0;
  GRP_DEC          = 1;
  GRP_ABOVE        = 2;
  GRP_MIN          = 3;
  GRP_PERCENT      = 0;
  GRP_DOLLARS      = 1;
  GRP_LINE         = 0;
  (*GRP_WHOLESALE    = 1;*)
  GRP_BOTH         = (*2*)1;
  GRP_FIXED_EXTRASELL = (*3*)2;
  GRP_INCLUDE_SPEC = 0;
  GRP_EXCLUDE_SPEC = 1;
  GRP_BATCH_ON     = 1;
  GRP_BATCH_OFF    = 0;
  GRP_BIN_OFF      = 0;
  GRP_BIN_ON       = 1;
  GRP_SEL_PRICE    = 0;
  GRP_SEL_CORRECT  = 1;
  GRP_SEL_CLASS    = 2;
  GRP_SEL_CUST     = 3;
  GRP_SEL_BATCH    = 4;
  GRP_SEL_CLASSVARIANCE = 5;
  GRP_SEL_PRODUCTSTATUS = 6;
  GRP_SEL_REORDER_POINTS = 7;
  GRP_SEL_UNIT_OF_MEASURE = 8;

procedure TPriceUpdateGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin 
  Self.Enabled := false;
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TPriceUpdateGUI.FormShow(Sender: TObject);
var 
  DonotOpenQueries: array of string;
begin
  DisableForm;
  try
    try
      if AccessLevel <> 1 then AccessLevel := 6;
      inherited;

      fsOriginalPartsSQL := qryParts.SQL.Text;
      Label4.Caption       := AppEnv.DefaultClass.PartColumn;
      lblFirstCol.Caption  := AppEnv.DefaultClass.FirstColumn;
      lblSecondCol.Caption := AppEnv.DefaultClass.SecondColumn;
      lblThirdCol.Caption  := AppEnv.DefaultClass.ThirdColumn;
      grpSelectionClick(Sender);
      chkAll.Checked     := false;
      bIgnoreCheck       := false;
      chkAllCust.Checked := false;
      Setlength(DonotOpenQueries, 9);
      DonotOpenQueries[0] := 'qrySpecPrices';
      DonotOpenQueries[1] := 'qryProductTypeLookup';
      DonotOpenQueries[2] := 'qryFirstCol';
      DonotOpenQueries[3] := 'qrySecondCol';
      DonotOpenQueries[4] := 'qryThirdCol';
      DonotOpenQueries[5] := 'qryPartName';
      DonotOpenQueries[6] := 'qryParts';
      DonotOpenQueries[7] := 'qryExtraSell';
      DonotOpenQueries[8] := 'tblCustomerLines';
      OpenQueries(DonotOpenQueries);
      grpSelection.Items[GRP_SEL_CLASS] := 'Add to ' + lblClass.Caption;
      if bIsCostBased then begin
        pnlVariation.Visible := false;
        pnlBatch.Visible := false;
        grpSelection.ItemIndex := GRP_SEL_PRICE;
        chkAll.Checked := true;
        grpSpecial.ItemIndex := GRP_INCLUDE_SPEC;
        lblNotice.Visible := true;
        lblNotice.Caption :=
          'NOTE: Price change will be based on a minimum above COST of ' + FloatToStrF(AppEnv.CompanyPrefs.MinAboveCost * 100.0, ffGeneral, 5, 2) + ' %'#13 +
          '        All Products && Special Prices selected will be Updated';
        edtAmount.Text := FloatToStrF(AppEnv.CompanyPrefs.MinAboveCost * 100.0, ffGeneral, 5, 2);
      end;
      CreateTemporaryTable;
      grpSelectionClick(nil);
      label3.Enabled         := false;
      label15.Enabled        := false;
      label16.Enabled        := false;
      label17.Enabled        := false;
      btnFixedPrice.Enabled  := false;
      cboUOM.Enabled         := false;
      cboClientType2.Enabled := false;
      chkAllClientTypes.Enabled := false;
      chkAllUOM.Enabled      := false;
      chkMain.Enabled        := false;
      Label21.Enabled        := false;


      SetUpdateReOrderControlsEnabled(false);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TPriceUpdateGUI.cboTypeEnter(Sender: TObject);
begin 
  inherited;
  ClearFilterCombos(pnlFilters);
  chkAll.Checked := false;
end;

procedure TPriceUpdateGUI.ClearFilterCombos(const pnl: TPanel);
var 
  i: Integer;
begin 
  for i := 0 to pnl.ControlCount - 1 do begin 
    if pnl.Controls[i] is TwwDBLookupCombo then begin 
      TwwDBLookupCombo(pnl.Controls[i]).Text := '';
    end;
  end;
end;

procedure TPriceUpdateGUI.chkAllClick(Sender: TObject);
begin 
  inherited;
  ClearFilterCombos(pnlFilters);
  if chkAll.Checked then begin 
    Label4.Enabled       := false;
    cboPartName.Enabled  := false;
    lblFirstCol.Enabled  := false;
    cboFirstCol.Enabled  := false;
    lblSecondCol.Enabled := false;
    cboSecondCol.Enabled := false;
    Label89.Enabled      := false;
    cboType.Enabled      := false;
    lblThirdCol.Enabled  := false;
    cboThirdCol.Enabled  := false;
  end else begin 
    Label4.Enabled       := true;
    cboPartName.Enabled  := true;
    lblFirstCol.Enabled  := true;
    cboFirstCol.Enabled  := true;
    lblSecondCol.Enabled := true;
    cboSecondCol.Enabled := true;
    Label89.Enabled      := true;
    cboType.Enabled      := true;
    lblThirdCol.Enabled  := true;
    cboThirdCol.Enabled  :=
      true;
  end;
  tmrESValidate.Enabled := true;
end;

procedure TPriceUpdateGUI.chkAllCustClick(Sender: TObject);
begin 
  inherited;
  if chkAllCust.Checked then begin 
    ClearFilterCombos(pnlCustFilters);
    Label7.Enabled        :=
      false;
    cboClientType.Enabled := false;
  end else begin 
    Label7.Enabled        := true;
    cboClientType.Enabled := true;
  end;
end;

function TPriceUpdateGUI.GetProductUOMPurchDefault(const PartID: Integer): string;
var 
  qry: TERPQuery;
begin 
  qry := TERPQuery.Create(Self);
  try 
    qry.Connection := MyConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblunitsofmeasure WHERE PartID = ');
    qry.SQL.Add(IntToStr(PartID));
    qry.SQL.Add(' AND PurchasesDefault = ');
    qry.SQL.Add(QuotedStr('T'));
    qry.Open;
    if qry.RecordCount < 0 then begin 
      Result := qry.FieldByName('UnitName').AsString;
    end else begin 
      Result := '0';
    end;
  finally 
    FreeAndNil(qry);
  end;
end;

function TPriceUpdateGUI.GetProductUOMSalesDefault(const PartID: Integer): string;
var 
  qry: TERPQuery;
begin 
  qry := TERPQuery.Create(Self);
  try 
    qry.Connection := MyConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblunitsofmeasure WHERE PartID = ');
    qry.SQL.Add(IntToStr(PartID));
    qry.SQL.Add(' AND SalesDefault = ');
    qry.SQL.Add(QuotedStr('T'));
    qry.Open;
    if qry.RecordCount > 0 then begin 
      Result := qry.FieldByName('UnitName').AsString;
    end else begin 
      Result := '0';
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPriceUpdateGUI.btnUpdateClick(Sender: TObject);
var
  bIsProdSelected, bIsProdVarn, bIsSpecPrices, bIsExtraSell, bIsBatchSelected, bIsBinSelected, bIsPriceVarnSelected, bIsCustSelected, bIsClassSelected,
  bisCorrectExtraSellSelected, bIsClassVariance, bIsProductStatus, bFixedSellPrices: Boolean;
  iCode: Integer;
  SavedCursor: TCursor;
  qry: TERPQuery;
  sTempFilter: string;
  iPartID: Integer;
  msg: string;

begin
  if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Data Update') then begin
    try

      DisableForm;
      try
        SavedCursor := Screen.Cursor;
        tbnClose.Enabled := false;
        btnUpdate.Enabled := false;
        qry := TERPQuery.Create(nil);
        try
          Screen.Cursor := crHourGlass;
          inherited;
          if (grpSelection.ItemIndex = GRP_SEL_UNIT_OF_MEASURE) then begin
            (*if (cboOldUOM.Text = '') or (cboUOMreplacewith.Text = '') then *)
              if (edtUnit.Text = '') then begin
                CommonLib.MessageDlgXP_Vista('Please select Unit of Measure first', mtInformation, [mbOK], 0);
                Exit;
              end;
            if (edtUnit.Text <> '') then begin
              if chkSalesDefault.Checked then begin
                iPartID := GetPartID(cboPartName.Text);
                if (GetProductUOMSalesDefault(iPartID) <> '0') and (GetProductUOMSalesDefault(iPartID) <> edtUnit.Text) then begin
                  CommonLib.MessageDlgXP_Vista('Product already has ' + QuotedStr(GetProductUOMSalesDefault(iPartID)) +
                    ' as the Sales default.' + #13 + #10 + 'To change, edit ' + QuotedStr(GetProductUOMSalesDefault(iPartID)) + ' first,', mtWarning, [mbOK], 0);
                  Exit;
                end;
              end;
              if chkPurchDefault.Checked then begin
                iPartID := GetPartID(cboPartName.Text);
                if (GetProductUOMPurchDefault(iPartID) <> '0') and (GetProductUOMPurchDefault(iPartID) <> edtUnit.Text) then begin
                  CommonLib.MessageDlgXP_Vista('Product already has ' + QuotedStr(GetProductUOMPurchDefault(iPartID)) + ' as the Purchases default.' + #13 + #10 + 'To change, edit ' +
                    QuotedStr(GetProductUOMPurchDefault(iPartID)) + ' first,', mtWarning, [mbOK], 0);
                  Exit;
                end;
              end;
              qryParts.Close;
              qryParts.Filtered := false;

              qryParts.SQL.Clear;
              qryParts.SQL.Text := fsOriginalPartsSQL;

              if not chkAll.Checked then begin
                qryParts.FilterSQL := GetFilter;
      //          qryParts.Filtered := true;
              end;
              qryParts.Open;
              if not qryParts.IsEmpty then begin
                if CommonLib.MessageDlgXP_Vista('This Product to Unit Of Measure will change ' +
                  IntToStr(qryParts.RecordCount) + ' Records. OK?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                  DoUOMUpdate;
                end;
              end else begin
                CommonLib.MessageDlgXP_Vista('No Parts Found to Update', mtConfirmation, [mbOK], 0);
              end;
            end;
          end;
          if (grpSelection.ItemIndex = GRP_SEL_REORDER_POINTS) then begin
            if (cboClass.Text = '') then begin
              CommonLib.MessageDlgXP_Vista(Format('Please select %s first', [lblClass.Caption]), mtInformation, [mbOK], 0);
              if cboClass.CanFocus then SetControlFocus(cboClass);
              Exit;
            end;
            SetReOrderDataForClass(cboClass.Text,GetFilter('tblParts'), ReOrderPoint, PreferredLevel, ReOrderAmount);
            Vista_MessageDlg.MessageDlgXP_Vista('All Possible Updates Completed !', mtInformation, [mbOK], 0);
            Exit;
          end;
          bIsProdSelected      := chkAll.Checked or IsAnyFilter(pnlFilters);
          bIsBatchSelected     := chkBatch.Checked;
          bIsBinSelected       := chkBin.Checked;
          bIsPriceVarnSelected := (grpSelection.ItemIndex = GRP_SEL_PRICE);
          bIsCustSelected      := (grpSelection.ItemIndex = GRP_SEL_CUST);
          bIsClassSelected     := (grpSelection.ItemIndex = GRP_SEL_CLASS);
          bIsCorrectExtraSellSelected := (grpSelection.ItemIndex = GRP_SEL_CORRECT);
          bIsClassVariance     := (grpSelection.ItemIndex = GRP_SEL_CLASSVARIANCE);
          bFixedSellPrices     := (grpPrice.ItemIndex = GRP_FIXED_EXTRASELL) and (grpPrice.Enabled);
          bIsProductStatus     := (grpSelection.ItemIndex = GRP_SEL_PRODUCTSTATUS);
          bIsProdVarn          := bIsPriceVarnSelected or chkBatch.Checked or chkBin.Checked or chkCorrectExtra.Checked;
          bIsSpecPrices        := bIsCustSelected and (not chkExtraSell.Checked) and (grpSpecial.ItemIndex = GRP_INCLUDE_SPEC);
          bIsExtraSell         := bIsCustSelected and chkExtraSell.Checked;
          Val(edtAmount.Text, rValue, iCode);
          if not bIsProdSelected then begin
            CommonLib.MessageDlgXP_Vista('You must select ''All'' or a DropDown box from within the Product Section', mtWarning, [mbOK], 0);
            Exit;
          end;
          if bIsProductStatus then DeactivateProducts
          else if bFixedSellPrices then begin
            qry.Connection :=
              CommonDbLib.GetSharedMyDacConnection;
            qry.SQL.Clear;
            qry.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '`');
            qry.Open;
            if qry.RecordCount < 1 then begin
              CommonLib.MessageDlgXP_Vista('It appears there is no fixed price data to process - Aborted!', mtWarning, [mbOK], 0);
              Exit;
            end;
            qryParts.Close;
            if chkMain.Checked then if CommonLib.MessageDlgXP_Vista('You are about to set all base sell prices for all products that relate to the ' +
                'given specified product information.  Are you sure you want to proceed with this operation?', mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;
            DoFixedPriceUpdate;
          end else if bIsBatchSelected and (grpBatch.ItemIndex = -1) then begin
            CommonLib.MessageDlgXP_Vista('You have selected Batch Tracking but have not chosen an option.', mtWarning, [mbOK], 0);
          end else if bIsBinSelected and (grpBin.ItemIndex = -1) then begin
            CommonLib.MessageDlgXP_Vista('You have selected Multi Bin but have not chosen an option.', mtWarning, [mbOK], 0);
          end else if bIsCorrectExtraSellSelected and (not
            chkCorrectExtra.Checked) then begin
            CommonLib.MessageDlgXP_Vista('You must select the "Correct Extra Sell Price" check box', mtWarning, [mbOK], 0);
          end else if (bIsClassSelected or bIsClassVariance) and not (chkAllClass.Checked or IsAnyFilter(pnlClass)) then begin
            CommonLib.MessageDlgXP_Vista('You must select ''All'' or ' + lblClass.Caption + ' in Add products section', mtWarning, [mbOK], 0);
          end else if bIsCustSelected and not (chkAllCust.Checked or
            IsAnyFilter(pnlCustFilters)) then begin
            CommonLib.MessageDlgXP_Vista('You must select ''All'' or Customer Type in Customer section', mtWarning, [mbOK], 0);
          end else if bIsExtraSell and not (IsValidFloat(edtDisc1.Text) (*and
            IsValidFloat(edtDisc2.Text) and IsValidFloat(edtDisc3.Text)*)) then begin
            CommonLib.MessageDlgXP_Vista('Invalid number(s) in the Extra Sell Discount edit boxes.', mtWarning, [mbOK], 0);
            SetControlFocus(edtDisc1);
          end else if ((iCode <> 0) or (rValue = 0.0)) and bIsPriceVarnSelected then begin
            CommonLib.MessageDlgXP_Vista('Zero or Invalid Variation amount entered.', mtWarning, [mbOK], 0);
            SetControlFocus(edtAmount);
          end else begin
            if chkBin.Checked and (grpBin.ItemIndex = GRP_BIN_ON) then if chkAll.Checked then InventoryLib.SetUseBinsForAllProducts(true)
              else InventoryLib.SetUseBinsForProduct(Self.KeyID, true);
            if bIsProdVarn then begin
              if qryParts.RecordCount = 0 then begin
                qryParts.Close;
                if (qryParts.SQL.Strings[qryParts.SQL.Count - 1]) = 'LIMIT 0' then begin
                  qryParts.SQL.Delete(qryParts.SQL.Count - 1);
                end;
              end;
              qryParts.Filtered := false;
              if not chkAll.Checked then begin
                qryParts.Close;
                if (qryParts.SQL.Strings[qryParts.SQL.Count - 1]) = 'LIMIT 0' then begin
                  qryParts.SQL.Delete(qryParts.SQL.Count - 1);
                end;
                if ((qryParts.SQL.Strings[qryParts.SQL.Count - 1]) <> 'Having ' + GetFilter()) then qryParts.SQL.Add('Having ' + GetFilter());
                qryParts.Open;
              end else begin
                if not qryParts.Active then begin
                  qryParts.Active := true;
                end;
              end;
              if not qryParts.IsEmpty then begin
                if CommonLib.MessageDlgXP_Vista('This Product Update will change ' + IntToStr(qryParts.RecordCount) +
                  ' Records. OK?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                  DoUpdate;
                end;
                qryParts.Close;
                if ((qryParts.SQL.Strings[qryParts.SQL.Count - 1]) = 'Having ' + GetFilter()) then begin
                  qryParts.SQL.Delete(qryParts.SQL.Count - 1);
                end;
              end else begin
                CommonLib.MessageDlgXP_Vista('No Part Records Found to Update', mtConfirmation, [mbOK], 0);
              end;
            end else if bIsSpecPrices then begin
              qrySpecPrices.Open;
              qrySpecPrices.Filtered := false;
              qrySpecPrices.Filter := GetClientTypeFilter;
              qrySpecPrices.Filtered := true;
              if not qrySpecPrices.IsEmpty then begin
                if CommonLib.MessageDlgXP_Vista('This Special Price Update will change ' + IntToStr(qrySpecPrices.RecordCount) + ' Records. OK?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                  DoSpecUpdate;
                end;
              end else begin
                CommonLib.MessageDlgXP_Vista('No Special Price Records Found to Update', mtConfirmation, [mbOK], 0);
              end;
            end else if bIsExtraSell then begin
              if not qryParts.Active then begin
                qryParts.Active := true;
              end;
              sTempFilter := GetFilter;
              if sTempFilter <> '' then begin
      //          qryParts.Filtered := false;
                qryParts.FilterSQL := sTempFilter;
      //          qryParts.Filtered := true;
              end;
              if not qryExtraSell.Active then begin
                qryExtraSell.Active := true;
              end;
              if not qryParts.IsEmpty then begin
                if CommonLib.MessageDlgXP_Vista('This Extra Sell Price Update will change ' + IntToStr(qryParts.RecordCount) + ' Records. OK?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                  DoExtraSellUpdate;
                end;
              end else begin
                CommonLib.MessageDlgXP_Vista('No Parts Found to Update', mtConfirmation, [mbOK], 0);
              end;
            end else if bIsClassSelected then begin
              if not qryParts.Active then begin
                qryParts.Active := true;
              end;
              qryParts.Filtered := false;
              qryParts.FilterSQL:= '';
              if not chkAll.Checked then begin
                qryParts.FilterSQL := GetFilter;
      //          qryParts.Filtered := true;
              end;
              if not qryParts.IsEmpty then begin
                if CommonLib.MessageDlgXP_Vista('This Product to ' + lblClass.Caption + ' will change ' + IntToStr(qryParts.RecordCount) + ' Records. OK?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                  DoClassUpdate;
                end;
              end else begin
                CommonLib.MessageDlgXP_Vista('No Parts Found to Update', mtConfirmation, [mbOK], 0);
              end;
            end else if bIsClassVariance then begin
              qryParts.Filtered := false;
              qryParts.FilterSQL := '';
              if not qryParts.Active then begin
                qryParts.Active := true;
              end;
              if not chkAll.Checked then begin
                qryParts.FilterSQL := GetFilter;
      //          qryParts.Filtered := true;
              end;
              if not qryParts.IsEmpty then begin
                if CommonLib.MessageDlgXP_Vista('This Product in ' + lblClass.Caption + ' will change ' + IntToStr(qryParts.RecordCount) + ' Records. OK?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then DoClassVarianceUpdate;
              end else CommonLib.MessageDlgXP_Vista('No Parts Found to Update', mtConfirmation, [mbOK], 0);
            end else CommonLib.MessageDlgXP_Vista('No Parts Found to Update', mtConfirmation, [mbOK], 0);
          end;
        finally
          if Assigned(qry) then FreeAndNil(qry);
          tbnClose.Enabled  := true;
          btnUpdate.Enabled := true;
          Screen.Cursor     := SavedCursor;
        end;
      finally
        EnableForm;
      end;

    finally
      AppEnv.UtilsClient.UnlockLogon;
    end;
  end
  else begin
    if msg = USERS_IN_SYSTEM_MESSAGE then begin
      MainForm.GetCurrentUserCount;
      dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Data Update';
      dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
      dtmMainGUI.dlgCurrentUsers.Execute;
    end
    else begin
      MessageDlgXP_Vista('Unable to Update Data, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
    end;
  end;



end;


function TPriceUpdateGUI.GetFilter(TblPrefix: string = ''): string;
var
  prefix: string;
begin
  Result := '';
  prefix:= TblPrefix;
  if prefix <> '' then
    prefix:= prefix + '.';
  if not Empty(cboType.Text) then begin
    Result := 'PARTTYPE = ' + QuotedStr(cboType.LookupValue);
  end;
  if not Empty(cboFirstCol.Text) then begin
    if Result = '' then begin
      result:= SplitField(TblPrefix,'ProductGroup',1) + ' = ' + QuotedStr(cboFirstCol.Text);
    end else begin
      Result := Result + ' AND ' + SplitField(TblPrefix,'ProductGroup',1) + ' = ' + QuotedStr(cboFirstCol.Text);
    end;
  end; //else
  if not Empty(cboSecondCol.Text) then begin
    if Result = '' then begin
      result:= SplitField(TblPrefix,'ProductGroup',2) + ' = ' + QuotedStr(cboSecondCol.Text);
    end else begin
      Result := Result + ' AND ' + SplitField(TblPrefix,'ProductGroup',2) + ' = ' + QuotedStr(cboSecondCol.Text);
    end;
  end;// else
  if not Empty(cboThirdCol.Text) then begin
    if Result = '' then begin
      result:= SplitField(TblPrefix,'ProductGroup',3) + ' = ' + QuotedStr(cboThirdCol.Text);
    end else begin
      Result := Result + ' AND ' + SplitField(TblPrefix,'ProductGroup',3) + ' = ' + QuotedStr(cboThirdCol.Text);
    end;
  end;// else
  if not Empty(cboPartName.Text) then begin
    if Result = '' then begin
      Result := prefix + 'PartsID = ' + cboPartName.LookupValue;
    end else begin
      Result := Result + ' AND ' + prefix + 'PartsID = ' + cboPartName.LookupValue;
    end;
  end;
  if fCustomFieldStatement <> '' then Result := Result + ' AND ' + fCustomFieldStatement;
end;

function TPriceUpdateGUI.GetClientTypeFilter: string;
begin
  Result := GetFilter;
  if not Empty(cboClientType.Text) then begin
    if not Empty(Result) then begin
      Result := Result + ' AND ';
    end;
    Result := 'ClientTypeID = ' + cboClientType.LookupValue;
  end;
end;

function TPriceUpdateGUI.IsAnyFilter(const pnl: TPanel): Boolean;
var
  i: Integer;
begin 
  Result := false;
  for i := 0 to pnl.ControlCount - 1 do begin 
    if pnl.Controls[i] is TwwDBLookupCombo then begin 
      if not Empty(TwwDBLookupCombo(pnl.Controls[i]).Text) then begin 
        Result := true;
      end;
    end;
  end;
end;

procedure TPriceUpdateGUI.DoUpdate;
var 
  SavedCursor: TCursor;
begin 
  lblInProgress.Caption := 'In Progress .... Please Wait';
  lblInProgress.Visible := true;
  lblRecCount.Visible := false;
  ProgressBar.Max := qryParts.RecordCount;
  ProgressBar.Position := ProgressBar.Min;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try 
    try 
      BeginTransaction;
      qryParts.First;
      OpenProductAllocationQry;
      while not qryParts.Eof do begin
        qryParts.Edit;
        if bIsCostBased then begin
          DoMinAboveCost;
        end else if grpSelection.ItemIndex = GRP_SEL_PRICE then begin
          DoPriceAdjust;
        end else if grpSelection.ItemIndex = GRP_SEL_CORRECT then begin
          DoCorrectExtraSell;
        end else begin
          if chkBatch.Checked then begin
            DoBatchTrack;
          end;
          if chkBin.Checked then begin 
            DoMultiBin;
          end;
        end;
        ProgressBar.StepIt;
        Application.ProcessMessages;
        qryParts.Next;
      end;
      CommitTransaction;
      Vista_MessageDlg.MessageDlgXP_Vista('All Possible Updates Completed !', mtInformation, [mbOK], 0);
    except 
      on 
      e: Exception do begin 
        Audit.AddEntry(e, Self);
        RollbackTransaction;
        raise;
      end;
    end;
  finally 
    Screen.Cursor         := SavedCursor;
    lblInProgress.Visible := false;
  end;
  lblRecCount.Caption := IntToStr(qryParts.RecordCount) + ' Records Updated';
  lblRecCount.Visible := true;
end;
Procedure TPriceUpdateGUI.OpenProductAllocationQry;
var
  s:String;
begin
  s:= qryparts.GroupConcat('PartsID');
  if s='' then s:='0';
  closeDb(qryProductAllocation);
  qryProductAllocation.SQL.Clear;
  qryProductAllocation.SQL.Add('Select pqa.ProductID , count(pqad.PQADetailID) allocations');
  qryProductAllocation.SQL.Add('from tblpqa pqa inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid');
  qryProductAllocation.SQL.Add('where pqa.ProductID in (' + s +')');
  qryProductAllocation.SQL.Add('group by pqa.ProductID ');
  qryProductAllocation.Open;
end;
procedure TPriceUpdateGUI.DoExtraSellUpdate;
var
  SavedCursor: TCursor;
  qryClientTypes: TERPQuery;

begin
  if cboUOMExtraSell.text <> '' then
    QryUOMExtraSellPrice.Locate('Unitname' , cboUOMExtraSell.text , []);
  lblInProgress.Caption :=
    'In Progress .... Extra Sell Update';
  lblInProgress.Visible := true;
  lblRecCount.Visible := false;
  ProgressBar.Max := qryParts.RecordCount;
  ProgressBar.Position := ProgressBar.Min;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  qryClientTypes := TERPQuery.Create(nil);
  try 
    qryClientTypes.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryClientTypes.SQL.Clear;
    qryClientTypes.SQL.Add('SELECT * FROM tblclienttype');
    qryClientTypes.Open;
    try 
      BeginTransaction;
      qryParts.First;
      while not qryParts.Eof do begin 
        FilterQryExtraSell;
        if qryExtraSell.RecordCount > 0 then begin 
          if chkExtraSell.Checked then begin 
            if chkAllCust.Checked then begin 
              while not qryExtraSell.Eof do begin 
                qryExtraSell.Delete;
              end;
              qryClientTypes.First;
              while not qryClientTypes.Eof do begin 
                qryExtraSell.Insert;
                qryExtraSell.FieldByName('ClientTypeID').AsInteger := qryClientTypes.FieldByName('ClientTypeID').AsInteger;
                qryExtraSell.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PARTSID').AsInteger;
                qryExtraSell.FieldByName('QTYPercent1').AsFloat := StrToFloat(edtDisc1.Text);
                if cboUOMExtraSell.text <> '' then begin
                  qryExtraSell.fieldbyname('UOM').asString := QryUOMExtraSellPrice.fieldbyname('UnitName').asString;
                  qryExtraSell.fieldbyname('UOMID').asInteger:= QryUOMExtraSellPrice.fieldbyname('UnitID').asInteger;
                  qryExtraSell.fieldbyname('UOMMultiplier').asfloat:= QryUOMExtraSellPrice.fieldbyname('Multiplier').asfloat;
                end;
                qryExtraSell.FieldByName('Price1').AsFloat := qryParts.FieldByName('Price1').AsFloat * (StrToFloat(edtDisc1.Text) / 100.0);
                (*qryExtraSell.FieldByName('QTYPercent2').AsFloat := StrToFloat(edtDisc2.Text);
                qryExtraSell.FieldByName('Price2').AsFloat := qryParts.FieldByName('Price2').AsFloat * (StrToFloat(edtDisc2.Text) / 100.0);
                qryExtraSell.FieldByName('QTYPercent3').AsFloat := StrToFloat(edtDisc3.Text);
                qryExtraSell.FieldByName('Price3').AsFloat := qryParts.FieldByName('Price3').AsFloat * (StrToFloat(edtDisc3.Text) / 100.0);*)
                qryExtraSell.Post;
                qryClientTypes.Next;
              end;
            end else begin
              qryExtraSell.Edit;
              qryExtraSell.FieldByName('ClientTypeID').AsInteger := FastFuncs.StrToInt(cboClientType.LookupValue);
              qryExtraSell.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PARTSID').AsInteger;
              qryExtraSell.FieldByName('QTYPercent1').AsFloat := StrToFloat(edtDisc1.Text);
              if cboUOMExtraSell.text <> '' then begin
                  qryExtraSell.fieldbyname('UOM').asString := QryUOMExtraSellPrice.fieldbyname('UnitName').asString;
                  qryExtraSell.fieldbyname('UOMID').asInteger:= QryUOMExtraSellPrice.fieldbyname('UnitID').asInteger;
                  qryExtraSell.fieldbyname('UOMMultiplier').asfloat:= QryUOMExtraSellPrice.fieldbyname('Multiplier').asfloat;
              end;
              qryExtraSell.FieldByName('Price1').AsFloat := qryParts.FieldByName('Price1').AsFloat * (StrToFloat(edtDisc1.Text) / 100.0);
              (*qryExtraSell.FieldByName('QTYPercent2').AsFloat := StrToFloat(edtDisc2.Text);
              qryExtraSell.FieldByName('Price2').AsFloat := qryParts.FieldByName('Price2').AsFloat * (StrToFloat(edtDisc2.Text) / 100.0);
              qryExtraSell.FieldByName('QTYPercent3').AsFloat := StrToFloat(edtDisc3.Text);
              qryExtraSell.FieldByName('Price3').AsFloat := qryParts.FieldByName('Price3').AsFloat * (StrToFloat(edtDisc3.Text) / 100.0);*)
              qryExtraSell.Post;
              qryClientTypes.Next;
            end;
          end else begin
            qryExtraSell.Edit;
            qryExtraSell.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PARTSID').AsInteger;
            qryExtraSell.FieldByName('QTYPercent1').AsFloat := StrToFloat(edtDisc1.Text);
            if cboUOMExtraSell.text <> '' then begin
                  qryExtraSell.fieldbyname('UOM').asString := QryUOMExtraSellPrice.fieldbyname('UnitName').asString;
                  qryExtraSell.fieldbyname('UOMID').asInteger:= QryUOMExtraSellPrice.fieldbyname('UnitID').asInteger;
                  qryExtraSell.fieldbyname('UOMMultiplier').asfloat:= QryUOMExtraSellPrice.fieldbyname('Multiplier').asfloat;
            end;
            qryExtraSell.FieldByName('Price1').AsFloat := qryParts.FieldByName('Price1').AsFloat * (StrToFloat(edtDisc1.Text) / 100.0);
            (*qryExtraSell.FieldByName('QTYPercent2').AsFloat := StrToFloat(edtDisc2.Text);
            qryExtraSell.FieldByName('Price2').AsFloat := qryParts.FieldByName('Price2').AsFloat * (StrToFloat(edtDisc2.Text) / 100.0);
            qryExtraSell.FieldByName('QTYPercent3').AsFloat := StrToFloat(edtDisc3.Text);
            qryExtraSell.FieldByName('Price3').AsFloat := qryParts.FieldByName('Price3').AsFloat * (StrToFloat(edtDisc3.Text) / 100.0);*)
            qryExtraSell.Post;
          end;
        end else begin 
          if chkExtraSell.Checked then begin 
            if chkAllCust.Checked then begin 
              qryClientTypes.First;
              while not qryClientTypes.Eof do begin
                qryExtraSell.Insert;
                qryExtraSell.FieldByName('ClientTypeID').AsInteger := qryClientTypes.FieldByName('ClientTypeID').AsInteger;
                qryExtraSell.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PARTSID').AsInteger;
                qryExtraSell.FieldByName('QTYPercent1').AsFloat := StrToFloat(edtDisc1.Text);
                if cboUOMExtraSell.text <> '' then begin
                  qryExtraSell.fieldbyname('UOM').asString := QryUOMExtraSellPrice.fieldbyname('UnitName').asString;
                  qryExtraSell.fieldbyname('UOMID').asInteger:= QryUOMExtraSellPrice.fieldbyname('UnitID').asInteger;
                  qryExtraSell.fieldbyname('UOMMultiplier').asfloat:= QryUOMExtraSellPrice.fieldbyname('Multiplier').asfloat;
                end;
                qryExtraSell.FieldByName('Price1').AsFloat := qryParts.FieldByName('Price1').AsFloat * (StrToFloat(edtDisc1.Text) / 100.0);
                (*qryExtraSell.FieldByName('QTYPercent2').AsFloat := StrToFloat(edtDisc2.Text);
                qryExtraSell.FieldByName('Price2').AsFloat := qryParts.FieldByName('Price2').AsFloat * (StrToFloat(edtDisc2.Text) / 100.0);
                qryExtraSell.FieldByName('QTYPercent3').AsFloat := StrToFloat(edtDisc3.Text);
                qryExtraSell.FieldByName('Price3').AsFloat := qryParts.FieldByName('Price3').AsFloat * (StrToFloat(edtDisc3.Text) / 100.0);*)
                qryExtraSell.Post;
                qryClientTypes.Next;
              end;
            end else begin
              qryExtraSell.Insert;
              qryExtraSell.FieldByName('ClientTypeID').AsInteger := FastFuncs.StrToInt(cboClientType.LookupValue);
              qryExtraSell.FieldByName('PartsID').AsInteger := qryParts.FieldByName('PARTSID').AsInteger;
              qryExtraSell.FieldByName('QTYPercent1').AsFloat := StrToFloat(edtDisc1.Text);
              if cboUOMExtraSell.text <> '' then begin
                  qryExtraSell.fieldbyname('UOM').asString := QryUOMExtraSellPrice.fieldbyname('UnitName').asString;
                  qryExtraSell.fieldbyname('UOMID').asInteger:= QryUOMExtraSellPrice.fieldbyname('UnitID').asInteger;
                  qryExtraSell.fieldbyname('UOMMultiplier').asfloat:= QryUOMExtraSellPrice.fieldbyname('Multiplier').asfloat;
              end;
              qryExtraSell.FieldByName('Price1').AsFloat := qryParts.FieldByName('Price1').AsFloat * (StrToFloat(edtDisc1.Text) / 100.0);
              (*qryExtraSell.FieldByName('QTYPercent2').AsFloat := StrToFloat(edtDisc2.Text);
              qryExtraSell.FieldByName('Price2').AsFloat := qryParts.FieldByName('Price2').AsFloat * (StrToFloat(edtDisc2.Text) / 100.0);
              qryExtraSell.FieldByName('QTYPercent3').AsFloat := StrToFloat(edtDisc3.Text);
              qryExtraSell.FieldByName('Price3').AsFloat := qryParts.FieldByName('Price3').AsFloat * (StrToFloat(edtDisc3.Text) / 100.0);*)
              qryExtraSell.Post;
            end;
          end;
        end;
        ProgressBar.StepIt;
        Application.ProcessMessages;
        qryParts.Next;
      end;
      CommitTransaction;
      Vista_MessageDlg.MessageDlgXP_Vista('All Possible Updates Completed !', mtInformation, [mbOK], 0);
    except 
      on e: Exception do begin 
        Audit.AddEntry(e, Self);
        RollbackTransaction;
        raise;
      end;
    end;
  finally 
    if Assigned(qryClientTypes) then
      FreeAndNil(qryClientTypes);
    Screen.Cursor         := SavedCursor;
    lblInProgress.Visible := false;
  end;
  lblRecCount.Caption := IntToStr(qryParts.RecordCount) + ' Records Updated';
  lblRecCount.Visible := true;
end;

function TPriceUpdateGUI.GetUOMID(const UOMName: string): Integer;
var 
  qry: TERPQuery;
begin 
  qry := TERPQuery.Create(Self);
  try 
    with qry do begin 
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('SELECT * FROM tblunitsofmeasure WHERE UnitName = ');
      SQL.Add(QuotedStr(UOMName));
      Open;
      Result := FieldByName('BaseUnitID').AsInteger;
    end;
  finally
    FreeAndNil(qry);
  end;
end;
procedure TPriceUpdateGUI.DoUOMUpdate;
var 
  SavedCursor: TCursor;
  qry: TERPCommand;
  sSalesDefault, sPODefault: string;
begin 
  lblInProgress.Caption := 'In Progress ..Product Unit of Measure.';
  lblInProgress.Visible := true;
  lblRecCount.Visible := false;
  ProgressBar.Max := qryParts.RecordCount;
  ProgressBar.Position := ProgressBar.Min;
  qry := TERPCommand.Create(Self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  qry := TERPCommand.Create(Self);
  try 
    sSalesDefault  := 'F';
    sPODefault     := 'F';
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    if chkSalesDefault.Checked then sSalesDefault := 'T';
    if chkPurchDefault.Checked then sPODefault := 'T';
    qryParts.First;
    while not qryParts.Eof do begin 
      if not qryUOM2.Active then qryUOM2.Open;
      if qryUOM2.Locate('PartID;UnitName', VarArrayOf([IntToStr(qryParts.FieldByName('PartsID').AsInteger), edtUnit.Text]), [loCaseInsensitive]) then begin
        with qryUOM2 do begin 
          Edit;
          FieldByName('UnitName').AsString := edtUnit.Text;
          FieldByName('UnitDescription').AsString := edtDesc.Text;
          FieldByName('Multiplier').AsInteger := FastFuncs.StrToInt(edMultiplier.Text);
          FieldByName('BaseUnitName').AsString := cboUnitOfMeasure.Text;
          FieldByName('BaseUnitID').AsInteger := GetUOMID(edtUnit.Text);
          FieldByName('Active').AsString := 'T';
          FieldByName('SalesDefault').AsString := sSalesDefault;
          FieldByName('PurchasesDefault').AsString := sPODefault;
          Post;
        end;
      end else begin 
        with qry do begin 
          Sql.Clear;
          Sql.Add('INSERT tblunitsofmeasure ' + '(UnitName, ' + 'UnitDescription, ' + 'Multiplier, ' + 'BaseUnitName, ' + 'BaseUnitID, ' + 'Active, ' + 'PartID, ' + 'SalesDefault, ' +
            'PurchasesDefault) ' + 'VALUES ' + '(' + QuotedStr(edtUnit.Text) + ', ' + QuotedStr(edtDesc.Text) + ', ' + edMultiplier.Text + ', ' + QuotedStr(cboUnitOfMeasure.Text)
            + ', ' + IntToStr(GetUOMID(edtUnit.Text)) + ', ' +
            QuotedStr('T') + ', ' + qryParts.FieldByName('PartsID').AsString + ', ' + QuotedStr(sSalesDefault) + ', ' + QuotedStr(sPODefault) + ')');
          Execute;
        end;
      end;
      ProgressBar.StepIt;
      Application.ProcessMessages;
      qryParts.Next;
    end;
    CommitTransaction;
    Vista_MessageDlg.MessageDlgXP_Vista('All Possible Updates Completed !', mtInformation, [mbOK], 0);
  finally 
    FreeAndNil(qry);
    Screen.Cursor         := SavedCursor;
    lblInProgress.Visible := false;
  end;
end;

procedure TPriceUpdateGUI.DoClassUpdate;
var 
  SavedCursor: TCursor;
  qry: TERPCommand;
  procedure DoUpdateParams(const inClassId: Integer; const inClassName: string);
  begin
    try
      with qry.Params do begin
        ParamByName('xProductID').AsInteger := qryParts.FieldByName('PARTSID').AsInteger;
        ParamByName('xProductName').AsString := qryParts.FieldByName('PARTNAME').AsString;
        ParamByName('xProductGroup').AsString := qryParts.FieldByName('PRODUCTGROUP').AsString;
        ParamByName('xClassID').AsInteger := inClassId;
        ParamByName('xClassName').AsString := inClassName;
      end;
      qry.Execute;
    except 
      on e: Exception do begin 
        if not (FastFuncs.PosEx('duplicate', FastFuncs.LowerCase(e.Message)) > 0) then begin 
          raise;
        end;
      end;
    end;
  end;
begin 
  lblInProgress.Caption := 'In Progress .... ' + grpSelection.Items[GRP_SEL_CLASS];
  lblInProgress.Visible := true;
  lblRecCount.Visible := false;
  ProgressBar.Max := qryParts.RecordCount;
  ProgressBar.Position := ProgressBar.Min;
  qry := TERPCommand.Create(Self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try 
    try 
      qryParts.First;
      with qry do begin
        Sql.Clear;
        Sql.Add('INSERT tblproductClasses ' + '(ProductID, ' + 'ProductName, ' + 'ProductGroup, ' + 'ClassID, ' + 'ClassName) ' + 'VALUES ' + '(:xProductID, ' + ':xProductName, ' +
          ':xProductGroup, ' + ':xClassID, ' + ':xClassName);');
      end;
      qryClass.DisableControls;
      while not qryParts.Eof do begin 
        if chkAllClass.Checked then begin 
          qryClass.First;
          while not qryClass.Eof do begin 
            DoUpdateParams(cboClass.LookupTable.FieldByName('ClassID').AsInteger, cboClass.LookupTable.FieldByName('ClassName').AsString);
            qryClass.Next;
          end;
        end else DoUpdateParams(cboClass.LookupTable.FieldByName('ClassID').AsInteger, cboClass.LookupTable.FieldByName('ClassName').AsString);
        ProgressBar.StepIt;
        Application.ProcessMessages;
        qryParts.Next;
      end;
      qryClass.EnableControls;
      CommitTransaction;
      Vista_MessageDlg.MessageDlgXP_Vista('All Possible Updates Completed !', mtInformation, [mbOK], 0);
    except 
      on e: Exception do begin 
        Audit.AddEntry(e, Self);
        RollbackTransaction;
        raise;
      end;
    end;
  finally 
    FreeAndNil(qry);
    Screen.Cursor         := SavedCursor;
    lblInProgress.Visible := false;
  end;
  lblRecCount.Caption := IntToStr(qryParts.RecordCount) + ' Records Updated';
  lblRecCount.Visible := true;
end;

procedure TPriceUpdateGUI.DoSpecUpdate;
var 
  SavedCursor: TCursor;
begin 
  lblInProgress.Caption := 'In Progress .... Special Prices';
  lblInProgress.Visible := true;
  lblRecCount.Visible := false;
  ProgressBar.Max := qrySpecPrices.RecordCount;
  ProgressBar.Position := ProgressBar.Min;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try 
    try 
      BeginTransaction;
      qrySpecPrices.First;
      while not qrySpecPrices.Eof do begin 
        if bIsCostBased then begin
          DoSpecAboveCost;
        end else begin 
          EditSpecRecord;
        end;
        ProgressBar.StepIt;
        Application.ProcessMessages;
        qrySpecPrices.Next;
      end;
      CommitTransaction;
      Vista_MessageDlg.MessageDlgXP_Vista('All Possible Updates Completed !', mtInformation, [mbOK], 0);
    except 
      on e: Exception do begin 
        Audit.AddEntry(e, Self);
        RollbackTransaction;
        raise;
      end;
    end;
  finally 
    Screen.Cursor         := SavedCursor;
    lblInProgress.Visible := false;
  end;
  lblRecCount.Caption := IntToStr(qrySpecPrices.RecordCount) + ' Records Updated';
  lblRecCount.Visible := true;
end;

procedure TPriceUpdateGUI.DoPriceAdjust;
begin 
  case grpOption.ItemIndex of 
    GRP_INC: DoPriceIncOrDec;
    GRP_DEC: DoPriceIncOrDec;
  end;
end;
function TPriceUpdateGUI.ProductHasAllocation(const ProductID:Integer):Boolean;
begin
  result := (qryProductAllocation.Locate('ProductID' , ProductID, [])) and (qryProductAllocation.fieldByname('allocations').asInteger <> 0);
end;

procedure TPriceUpdateGUI.DoBatchTrack;
begin
  if IsInvProduct(qryParts.FieldByName('PARTTYPE').AsString) then begin
    if (not(ProductHasAllocation(qryParts.FieldByName('PartsID').AsInteger))) then begin
      if grpBatch.ItemIndex in [1, 2] then begin
        qryParts.FieldByName('Batch').AsString := 'T';
        if grpBatch.ItemIndex = 1 then qryParts.FieldByName('autobatch').AsString := 'T'
        else qryParts.FieldByName('autobatch').AsString := 'F';
      end else if grpBatch.ItemIndex = 0 then begin
        qryParts.FieldByName('Batch').AsString := 'F';
        qryParts.FieldByName('autobatch').AsString := 'F';
      end;
    end else begin
      if (grpBatch.ItemIndex in [1, 2]) and (qryParts.FieldByName('Batch').AsString='T') then begin
        if grpBatch.ItemIndex = 1 then qryParts.FieldByName('autobatch').AsString := 'T'
        else qryParts.FieldByName('autobatch').AsString := 'F';
      end;
    end;
  end else begin
    qryParts.FieldByName('Batch').AsString     := 'F';
    qryParts.FieldByName('autobatch').AsString := 'F';
  end;
end;

procedure TPriceUpdateGUI.DoMultiBin;
begin 
  if IsInvProduct(qryParts.FieldByName('PARTTYPE').AsString) then begin
    if (not(ProductHasAllocation(qryParts.FieldByName('PartsID').AsInteger))) then begin
      if grpBin.ItemIndex in [1, 2] then begin
        qryParts.FieldByName('MultipleBins').AsString := 'T';
        if grpBin.ItemIndex = 1 then qryParts.FieldByName('autobin').AsString := 'T'
        else qryParts.FieldByName('autobin').AsString := 'F';
      end else if grpBin.ItemIndex = 0 then begin
        qryParts.FieldByName('MultipleBins').AsString := 'F';
        qryParts.FieldByName('autobin').AsString := 'F';
      end;
    end else begin
      if (grpBin.ItemIndex in [1, 2]) and (qryParts.FieldByName('MultipleBins').AsString='T') then begin
        if grpBin.ItemIndex = 1 then qryParts.FieldByName('autobin').AsString := 'T'
        else qryParts.FieldByName('autobin').AsString := 'F';
      end;
    end;
  end else begin 
    qryParts.FieldByName('MultipleBins').AsString := 'F';
    qryParts.FieldByName('autobin').AsString      := 'F';
  end;
end;

procedure TPriceUpdateGUI.DoPriceIncOrDec;
begin
  if (grpPrice.ItemIndex = GRP_LINE) or (grpPrice.ItemIndex = GRP_BOTH) then begin
    qryParts.FieldByName('Price1').AsCurrency    :=
      GetNewPrice(qryParts.FieldByName('Price1').AsCurrency, grpOption.ItemIndex = GRP_INC, grpType.ItemIndex = GRP_PERCENT);
    qryParts.FieldByName('Price2').AsCurrency    := GetNewPrice(qryParts.FieldByName('Price2').AsCurrency, grpOption.ItemIndex = GRP_INC, grpType.ItemIndex = GRP_PERCENT);
    qryParts.FieldByName('Price3').AsCurrency    := GetNewPrice(qryParts.FieldByName('Price3').AsCurrency, grpOption.ItemIndex = GRP_INC, grpType.ItemIndex = GRP_PERCENT);
    qryParts.FieldByName('PriceInc1').AsCurrency := GetAmountInc(qryParts.FieldByName('Price1').AsCurrency, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
    qryParts.FieldByName('PriceInc2').AsCurrency := GetAmountInc(qryParts.FieldByName('Price2').AsCurrency, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
    qryParts.FieldByName('PriceInc3').AsCurrency :=
      GetAmountInc(qryParts.FieldByName('Price3').AsCurrency, GetTaxRate(qryParts.FieldByName('TaxCode').AsString));
  end;
  if (*(grpPrice.ItemIndex = GRP_WHOLESALE) or *)(grpPrice.ItemIndex = GRP_BOTH) then begin
    qryParts.FieldByName('WholesalePrice').AsCurrency := GetNewPrice(qryParts.FieldByName('WholeSalePrice').AsCurrency, grpOption.ItemIndex = GRP_INC, grpType.ItemIndex = GRP_PERCENT);
  end;
end;

procedure TPriceUpdateGUI.DoCorrectExtraSell;
begin 
  if qryParts.FieldByName('SellQTY2').AsCurrency < qryParts.FieldByName('SellQTY1').AsCurrency then begin 
    qryParts.FieldByName('SellQTY2').AsCurrency := qryParts.FieldByName('SellQTY1').AsCurrency;
  end;
  if qryParts.FieldByName('SellQTY3').AsCurrency < qryParts.FieldByName('SellQTY2').AsCurrency then begin 
    qryParts.FieldByName('SellQTY3').AsCurrency := qryParts.FieldByName('SellQTY2').AsCurrency;
  end;
  if qryParts.FieldByName('Price2').AsCurrency < qryParts.FieldByName('Price1').AsCurrency then begin 
    qryParts.FieldByName('Price2').AsCurrency := qryParts.FieldByName('Price1').AsCurrency;
  end;
  if qryParts.FieldByName('Price3').AsCurrency < qryParts.FieldByName('Price2').AsCurrency then begin 
    qryParts.FieldByName('Price3').AsCurrency := qryParts.FieldByName('Price2').AsCurrency;
  end;
  if qryParts.FieldByName('BuyQTY2').AsCurrency < qryParts.FieldByName('BuyQTY1').AsCurrency then begin 
    qryParts.FieldByName('BuyQTY2').AsCurrency := qryParts.FieldByName('BuyQTY1').AsCurrency;
  end;
  if qryParts.FieldByName('BuyQTY3').AsCurrency < qryParts.FieldByName('BuyQTY2').AsCurrency then begin 
    qryParts.FieldByName('BuyQTY3').AsCurrency := qryParts.FieldByName('BuyQTY2').AsCurrency;
  end;
  if qryParts.FieldByName('COST2').AsCurrency < qryParts.FieldByName('COST1').AsCurrency then begin 
    qryParts.FieldByName('COST2').AsCurrency := qryParts.FieldByName('COST1').AsCurrency;
  end;
  if qryParts.FieldByName('COST3').AsCurrency < qryParts.FieldByName('COST2').AsCurrency then begin 
    qryParts.FieldByName('COST3').AsCurrency := qryParts.FieldByName('COST2').AsCurrency;
  end;
end;

function TPriceUpdateGUI.GetNewCostBasedPrice(const rCost: Currency): Currency;
begin 
  Result := -1;
  if rCost > 0.009 then begin 
    Result := GetNewPrice(rCost, true, grpType.ItemIndex = GRP_PERCENT);
  end;
end;

procedure TPriceUpdateGUI.DoMinAboveCost;
var 
  rNewPrice: Currency;
begin 
  rNewPrice := GetNewCostBasedPrice(qryParts.FieldByName('Cost1').AsCurrency);
  if (grpPrice.ItemIndex = GRP_LINE) or (grpPrice.ItemIndex = GRP_BOTH) then begin
    if rNewPrice > qryParts.FieldByName('Price1').AsCurrency then begin 
      qryParts.FieldByName('Price1').AsCurrency := rNewPrice;
    end;
    if rNewPrice > qryParts.FieldByName('Price2').AsCurrency then begin 
      qryParts.FieldByName('Price2').AsCurrency := rNewPrice;
    end;
    if rNewPrice > qryParts.FieldByName('Price3').AsCurrency then begin 
      qryParts.FieldByName('Price3').AsCurrency := rNewPrice;
    end;
    qryParts.FieldByName('PriceInc1').AsCurrency := GetAmountInc(qryParts.FieldByName('Price1').AsCurrency, GetTaxRate(qryParts.FieldByName('TAXCODE').AsString));
    qryParts.FieldByName('PriceInc2').AsCurrency := GetAmountInc(qryParts.FieldByName('Price2').AsCurrency, GetTaxRate(qryParts.FieldByName('TAXCODE').AsString));
    qryParts.FieldByName('PriceInc3').AsCurrency := GetAmountInc(qryParts.FieldByName('Price3').AsCurrency, GetTaxRate(qryParts.FieldByName('TAXCODE').AsString));
  end;
  if (*(grpPrice.ItemIndex = GRP_WHOLESALE) or*) (grpPrice.ItemIndex = GRP_BOTH) then begin
    if rNewPrice > qryParts.FieldByName('WholesalePrice').AsCurrency then begin 
      qryParts.FieldByName('WholesalePrice').AsCurrency := rNewPrice;
    end;
  end;
end;

procedure TPriceUpdateGUI.DoSpecAboveCost;
var 
  rNewPrice: Currency;
begin 
  tblCustomerLines.Open;
  rNewPrice :=
    GetNewCostBasedPrice(qrySpecPrices.FieldByName('Cost1').AsCurrency);
  if rNewPrice > qrySpecPrices.FieldByName('LinePrice').AsCurrency then begin 
    tblCustomerLines.Filtered := false;
    tblCustomerLines.Filter   :=
      'CustomerLinesID = ' + IntToStr(qrySpecPrices.FieldByName('CustomerLinesID').AsInteger);
    tblCustomerLines.Filtered := true;
    tblCustomerLines.Edit;
    tblCustomerLines.FieldByName('LinePrice').AsCurrency :=
      rNewPrice;
    tblCustomerLines.Post;
  end;
end;

procedure TPriceUpdateGUI.EditSpecRecord;
begin 
  tblCustomerLines.Open;
  tblCustomerLines.Filtered := false;
  tblCustomerLines.Filter := 'CustomerLinesID = ' + IntToStr(qrySpecPrices.FieldByName('CustomerLinesID').AsInteger);
  tblCustomerLines.Filtered := true;
  tblCustomerLines.Edit;
  tblCustomerLines.FieldByName('LinePrice').AsCurrency := GetNewPrice(tblCustomerLines.FieldByName('LinePrice').AsCurrency, grpOption.ItemIndex = GRP_INC, grpType.ItemIndex = GRP_PERCENT);
  tblCustomerLines.Post;
end;

function TPriceUpdateGUI.GetNewPrice(const rOrigPrice: Currency; const bIsInc, bIsPercent: Boolean): Currency;
var 
  iSign: Integer;
begin 
  Result := 0.0;
  if rOrigPrice >= 0.0 then begin
    if bIsInc then begin
      iSign := 1;
    end else begin
      iSign := -1;
    end;
    if bIsPercent then begin
      Result := rOrigPrice * (1 + iSign * rValue / 100.0);
    end else begin 
      Result := rOrigPrice + iSign * rValue;
    end;
    if Result <= 0.0 then Result := 0.0;
  end;
end;

procedure TPriceUpdateGUI.tbnCloseClick(Sender: TObject);
begin 
  inherited;
  Self.Close;
end;

procedure TPriceUpdateGUI.cboClientTypeEnter(Sender: TObject);
begin 
  inherited;
  chkAllCust.Checked := false;
end;

procedure TPriceUpdateGUI.FormCreate(Sender: TObject);
begin 
  inherited;
  bIsCostBased := false;
  CreateTemporaryTable;
  ChangeCurrencyNameinRAdioGroup(grpType);
end;

procedure TPriceUpdateGUI.chkBatchBinClick(Sender: TObject);
begin 
  inherited;
  if not bIgnoreCheck then begin 
    if Sender is TCheckBox then begin 
      if TCheckBox(Sender) = chkBatch then begin 
        grpBatch.Enabled := chkBatch.Checked;
      end else if TCheckBox(Sender) = chkBin then begin 
        grpBin.Enabled := chkBin.Checked;
      end;
    end;
  end;
end;

procedure TPriceUpdateGUI.chkExtraSellClick(Sender: TObject);
begin 
  inherited;
  grpSpecial.Enabled := not chkExtraSell.Checked;
end;

function TPriceUpdateGUI.IsValidFloat(const Text: string): Boolean;
var 
  rDummy: Double;
  iCode: Integer;
begin 
  Val(Text, rDummy, iCode);
  if rDummy <> 0 then;
  Result := (iCode = 0);
end;

procedure TPriceUpdateGUI.FilterQryExtraSell;
begin 
  qryExtraSell.Filtered := false;
  if chkAllCust.Checked then begin 
    qryExtraSell.Filter := 'PartsID = ' + qryParts.FieldByName('PARTSID').AsString;
  end else begin 
    qryExtraSell.Filter := 'PartsID = ' + qryParts.FieldByName('PARTSID').AsString + ' AND ' + 'ClientTypeID = ' + cboClientType.LookupValue;
  end;
  if cbouomExtraSell.text <> '' then
    qryExtraSell.Filter := qryExtraSell.Filter + ' and UOMID = ' + IntToStr(QryUOMExtraSellPrice.fieldbyname('UnitID').asInteger)
  else qryExtraSell.Filter := qryExtraSell.Filter + ' and UOMID = 0'; 
  qryExtraSell.Filtered := true;
end;

procedure TPriceUpdateGUI.grpSelectionClick(Sender: TObject);
begin 
  EnablePanel(pnlCustFilters, true, true);
  EnablePanel(pnlVariation, true);
  EnablePanel(pnlPrice, false);
  EnablePanel(pnlCorrectExtraSell, false);
  EnablePanel(pnlBatch, false, false);
  EnablePanel(pnlClass, false);
  EnablePanel(pnlStatus, false);
  
  grpType.Enabled := true;
  btnUpdate.Enabled := true;
  EnablePanel(pnlUnitOfMeasure, false);
  case grpSelection.ItemIndex of 
    GRP_SEL_CUST:
      begin 
        EnablePanel(pnlCustFilters, true, true);
        chkAll.Enabled := true;
      end;
    GRP_SEL_CLASS:
      begin 
        EnablePanel(pnlClass, true);
        chkAll.Enabled := true;
        chkAllClass.Checked := false;
      end;
    GRP_SEL_CORRECT:
      begin 
        EnablePanel(pnlCorrectExtraSell, true);
        chkAll.Enabled := true;
      end;
    GRP_SEL_PRICE:
      begin 
        EnablePanel(pnlPrice, true);
        grpPriceClick(Sender);
        chkAllCust.Enabled := true;
        chkAllCustClick(Sender);
        chkAll.Enabled := true;
      end;
    GRP_SEL_BATCH:
      begin 
        EnablePanel(pnlBatch, true, false);
        chkAll.Enabled := true;
      end;
    GRP_SEL_CLASSVARIANCE:
      begin 
        EnablePanel(pnlClass, true);
        grpType.ItemIndex := 0;
        grpType.Enabled := false;
        chkAll.Enabled := true;
        chkAllClass.Checked := false;
      end;
    GRP_SEL_PRODUCTSTATUS:
      begin 
        dtFrom.DateTime := Date;
        EnablePanel(pnlStatus, true);
        chkAll.Checked := true;
        chkAllClick(Sender);
        chkAll.Enabled := false;
        EnablePanel(pnlCustFilters, false);
        EnablePanel(pnlVariation, false);
        EnablePanel(pnlBatch, false);
      end;
    GRP_SEL_UNIT_OF_MEASURE:
      begin 
        if qryUOM2.Active then qryUOM2.Close;
        EnablePanel(pnlUnitOfMeasure, true);
        
      end;
    GRP_SEL_REORDER_POINTS: SetUpdateReOrderControlsEnabled(true);
  end;
end;

procedure TPriceUpdateGUI.qryBeforePost(DataSet: TDataSet);
begin 
  inherited;
  try 
    if (DataSet.Name = 'qryParts') then begin 
      DataSet.FieldByName('DateUpdated').AsDateTime := Now;
    end;
    DataSet.FieldByName('EditedFlag').AsString := 'T';
  except;
  end 
end;

procedure TPriceUpdateGUI.DoClassVarianceUpdate;
var 
  SavedCursor: TCursor;
  qry: TERPCommand;
  bIsInc: Boolean;
  iCode, iSign: Integer;
  VariationAmount: Double;
begin 
  lblInProgress.Caption := 'In Progress .... ' + grpSelection.Items[GRP_SEL_CLASSVARIANCE];
  lblInProgress.Visible := true;
  lblRecCount.Visible := false;
  ProgressBar.Max := qryParts.RecordCount;
  ProgressBar.Position :=
    ProgressBar.Min;
  qry := TERPCommand.Create(self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try 
    try 
      qryParts.First;
      while not qryParts.Eof do begin 
        qry.Sql.Clear;
        qry.Sql.Add('UPDATE tblproductclasses SET ClassPriceVariance=ClassPriceVariance+:xClassPriceVariance WHERE ClassID=:xClassID AND ProductID=:xProductID;');
        bIsInc := (grpOption.ItemIndex = GRP_INC);
        if bIsInc then begin 
          iSign := 1;
        end else begin 
          iSign := -1;
        end;{$R-} Val(edtAmount.Text, rValue, iCode);
        VariationAmount := iSign * rValue;
        with qry.Params do begin 
          ParamByName('xClassPriceVariance').AsFloat := VariationAmount;
          ParamByName('xProductID').AsInteger := qryParts.FieldByName('PARTSID').AsInteger;
          ParamByName('xClassID').AsString := cboClass.LookupValue;
        end;
        try 
          qry.Execute;
        except 
        end;
        ProgressBar.StepIt;
        Application.ProcessMessages;
        qryParts.Next;
      end;
    except 
      on e: Exception do begin 
        Audit.AddEntry(e, Self);
        RollbackTransaction;
        raise;
      end;
    end;
  finally 
    FreeAndNil(qry);
    Screen.Cursor         :=
      SavedCursor;
    lblInProgress.Visible := false;
  end;
  lblRecCount.Caption := IntToStr(qryParts.RecordCount) + ' Records Updated';
  lblRecCount.Visible := true;
end;

procedure TPriceUpdateGUI.cboTypeClick(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Screen.Cursor;
  try 
    Screen.Cursor := crHourGlass;
  finally 
    Screen.Cursor := SavedCursor;
    if Sender.ClassName <> 'TEdit' then begin 
      SetControlFocus(cboType);
      cboType.DropDown;
    end;
  end;
end;

procedure TPriceUpdateGUI.cboSecondColClick(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Screen.Cursor;
  try 
    Screen.Cursor := crHourGlass;
    if not 
      qrySecondCol.Active then begin 
      qrySecondCol.Open;
    end;
  finally 
    Screen.Cursor := SavedCursor;
    SetControlFocus(cboSecondCol);
    cboSecondCol.DropDown;
  end;
end;

procedure TPriceUpdateGUI.cboThirdColClick(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Screen.Cursor;
  try 
    Screen.Cursor := crHourGlass;
    if not qryThirdCol.Active then begin 
      qryThirdCol.Open;
    end;
  finally 
    Screen.Cursor := SavedCursor;
    SetControlFocus(cboThirdCol);
    cboThirdCol.DropDown;
  end;
end;

procedure TPriceUpdateGUI.cboThirdColDropDown(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Screen.Cursor;
  try 
    Screen.Cursor := crHourGlass;
    if not qryThirdCol.Active then begin 
      qryThirdCol.Open;
    end;
  finally 
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TPriceUpdateGUI.cboTypeDropDown(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Screen.Cursor;
  try 
    Screen.Cursor := crHourGlass;
    if not qryProductTypeLookup.Active then begin 
      qryProductTypeLookup.Open;
    end;
  finally 
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TPriceUpdateGUI.cboTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin 
  if not Modified then Exit;
  inherited;
  chkAll.Checked := false;
  tmrESValidate.Enabled := true;
end;

procedure TPriceUpdateGUI.ComboBox1Enter(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Screen.Cursor;
  try 
    Screen.Cursor := crHourGlass;
    if not qryProductTypeLookup.Active then begin 
      qryProductTypeLookup.Open;
    end;
  finally 
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TPriceUpdateGUI.cboPartNameBeforeDropDown(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  if not 
    qryPartName.Active then begin 
    SavedCursor   := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    qryPartName.Open;
    Screen.Cursor := SavedCursor;
  end;
  chkAll.Checked := false;
end;

procedure TPriceUpdateGUI.cboFirstColBeforeDropDown(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Self.Cursor;
  Screen.Cursor := crHourGlass;
  if not qryFirstCol.Active then begin 
    qryFirstCol.Open;
  end;
  Screen.Cursor := SavedCursor;
end;

procedure TPriceUpdateGUI.cboSecondColBeforeDropDown(Sender: TObject);
var 
  SavedCursor: TCursor;
begin 
  inherited;
  SavedCursor := Self.Cursor;
  Screen.Cursor := crHourGlass;
  if not qrySecondCol.Active then begin 
    qrySecondCol.Close;
    qrySecondCol.Open;
  end;
  Screen.Cursor := SavedCursor;
end;

procedure TPriceUpdateGUI.grpPriceClick(Sender: TObject);
begin 
  inherited;
  case grpPrice.ItemIndex of
    GRP_LINE, (*GRP_WHOLESALE, *)GRP_BOTH :
    (*0..2:*)
      begin
        btnFixedPrice.Enabled := false;
        label3.Enabled := false;
        label15.Enabled := false;
        label16.Enabled := false;
        label17.Enabled := false;
        chkAllClientTypes.Enabled := false;
        chkAllUOM.Enabled :=
          false;
        chkMain.Enabled := false;
        Label21.Enabled := false;
        btnFixedPrice.Enabled := false;
        cboUOM.Enabled := false;
        cboClientType2.Enabled := false;
        cboUOM.Text := '';
        cboClientType2.Text := '';
        btnUpdate.Enabled := true;
      end;
    GRP_FIXED_EXTRASELL:
      begin
        label3.Enabled := true;
        label15.Enabled := true;
        btnFixedPrice.Enabled := true;
        btnFixedPrice.Enabled := true;
        cboUOM.Enabled := true;
        cboClientType2.Enabled := true;
        label16.Enabled := true;
        label17.Enabled :=
          true;
        chkAllClientTypes.Enabled := true;
        chkAllUOM.Enabled := true;
        chkMain.Enabled := true;
        Label21.Enabled := true;
        cboUOM.Text := qryUOM.FieldByName('UnitName').AsString;
        cboClientType2.Text := qryClientType.FieldByName('TypeName').AsString;
        if Sender = grpPrice then tmrESValidate.Enabled := true;
      end;
    else btnFixedPrice.Enabled := false;
      label3.Enabled := false;
      label15.Enabled := false;
      btnFixedPrice.Enabled := false;
      cboUOM.Enabled := false;
      cboClientType2.Enabled := false;
      label16.Enabled := false;
      label17.Enabled := false;
      chkMain.Enabled := false;
      Label21.Enabled := false;
      chkAllClientTypes.Enabled := false;
      chkAllUOM.Enabled :=
        false;
      cboUOM.Text := '';
      cboClientType2.Text := '';
      DropTemporaryTable;
      btnUpdate.Enabled := true;
  end;
end;

procedure TPriceUpdateGUI.ClearTemporaryTable;
var 
  qry: TERPQuery;
begin 
  qry := TERPQuery.Create(nil);
  try 
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + GetTemporaryTableName + '` WHERE ID <> 0;');
    qry.Execute;
  finally 
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TPriceUpdateGUI.CreateTemporaryTable;
var 
  qry: TERPQuery;
begin 
  DropTemporaryTable;
  qry := TERPQuery.Create(nil);
  try 
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQl.Add('CREATE TABLE IF NOT EXISTS `' + GetTemporaryTableName + '`');
    qry.SQL.Add('(`ID` INT(11) NOT NULL AUTO_INCREMENT, `ClientTypeID` ');
    qry.SQL.Add('INT (11) DEFAULT ''0'', `ClientType` VARCHAR (255), ');
    qry.SQL.Add('`UOMID` INT (11) DEFAULT ''0'', `UOMName` VARCHAR (255),');
    qry.SQL.Add('`QtyPercent1` DOUBLE DEFAULT ''0'', `Price1Ex` DOUBLE DEFAULT ''0'',');
    (*qry.SQL.Add('`QtyPercent2` DOUBLE DEFAULT ''0'', `Price2Ex` DOUBLE DEFAULT ''0'',');
    qry.SQL.Add('`QtyPercent3` DOUBLE DEFAULT ''0'', `Price3Ex` DOUBLE DEFAULT ''0'',');*)
    qry.SQL.Add('`Price1Inc` DOUBLE DEFAULT ''0'', ');
    (*qry.SQL.Add('`Price2Inc` DOUBLE DEFAULT ''0'',');
    qry.SQL.Add('`Price3Inc` DOUBLE DEFAULT ''0'',');*)
    qry.SQL.Add('PRIMARY KEY(`ID`))  TYPE = MyISAM;');
    qry.Execute;
  finally 
    if Assigned(qry) then FreeAndNil(qry);
    FTempTablePopulated := false;
  end;
end;

procedure TPriceUpdateGUI.DropTemporaryTable;
var 
  qry: TERPQuery;
begin 
  qry := TERPQuery.Create(nil);
  try 
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetTemporaryTableName +
      '`;');
    qry.Execute;
  finally 
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TPriceUpdateGUI.GetTemporaryTableName: string;
begin 
  Result := GetUserTemporaryTableName(PRICEUPDATE_TABLENAME)
end;

procedure TPriceUpdateGUI.FormDestroy(Sender: TObject);
begin 
  DropTemporaryTable;
  inherited;
end;

procedure TPriceUpdateGUI.btnFixedPriceClick(Sender: TObject);
var 
  frm: TfrmProductFixedPrice;
begin 
  inherited;
  CheckFixedPricePreconditions;
  PopulateTemporaryTable;
  frm := TfrmProductFixedPrice(GetComponentByClassName('TfrmProductFixedPrice'));
  if Assigned(frm) then begin 
    with frm do begin 
      FormStyle := fsNormal;
      if chkMain.Checked then begin 
        frm.MainSellPriceMode := true;
        frm.Height := 200;
      end;
      frm.TempTableName := GetTemporaryTableName;
      if not chkAllClientTypes.Checked then begin 
        frm.ClientType := cboClientType2.Text;
      end else begin 
        frm.ClientType := 'ALL';
      end;
      if not chkAllUOM.Checked then begin 
        frm.UOM := cboUOM.Text;
      end else begin 
        frm.UOM := 'ALL';
      end;
      ShowModal;
    end;
  end;
end;

procedure TPriceUpdateGUI.chkAllClientTypesClick(Sender: TObject);
begin 
  inherited;
  if (grpPrice.ItemIndex <> GRP_FIXED_EXTRASELL) then Exit;
  Label3.Enabled := not chkAllClientTypes.Checked;
  cboClientType2.Enabled := not chkAllClientTypes.Checked;
end;

procedure TPriceUpdateGUI.chkAllUOMClick(Sender: TObject);
begin 
  inherited;
  if (grpPrice.ItemIndex <> GRP_FIXED_EXTRASELL) then Exit;
  Label15.Enabled := not chkAllUOM.Checked;
  cboUOM.Enabled := not chkAllUOM.Checked;
end;

procedure TPriceUpdateGUI.PopulateTemporaryTable;
var 
  qry, qry2: TERPQuery;
  sWhere: string;
  dValue: Double;
  ProgressDialog: TProgressDialog;
begin 
  if FTempTablePopulated then Exit;
  qry := TERPQuery.Create(nil);
  qry2 := TERPQuery.Create(nil);
  ProgressDialog := TProgressDialog.Create(nil);
  try 
    ClearTemporaryTable;
    qry.Connection  := CommonDbLib.GetSharedMyDacConnection;
    qry2.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck  := true;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO `' + GetTemporaryTableName + '`');
    qry.SQL.Add('(UOMID, UOMName, ClientTypeID, ClientType)');
    qry.SQL.Add('SELECT');
    qry.SQL.Add('UOM.UnitID, UOM.UnitName, CT.ClientTypeID, CT.TypeName');
    qry.SQL.Add('FROM tblunitsofmeasure AS UOM, tblclienttype AS CT');
    if (not chkAllClientTypes.Checked) or (not chkAllUOM.Checked) then begin 
      sWhere := '';
      if (not chkAllClientTypes.Checked) then if sWhere = '' then sWhere := 'CT.TypeName = ' + QuotedStr(cboClientType2.Text)
        else sWhere := sWhere + ' AND (CT.TypeName = ' + QuotedStr(cboClientType2.Text);
      if (not 
        chkAllUOM.Checked) then if sWhere = '' then sWhere := 'UOM.UnitID = ' + qryUOM.FieldByName('UnitID').AsString 
        else sWhere := sWhere + ' AND UOM.UnitID = ' + qryUOM.FieldByName('UnitID').AsString;
      qry.SQL.Add('WHERE ' + sWhere);
    end;
    qry.Execute;
    qry.SQL.Clear;
    qry.SQL.Add('FLUSH QUERY CACHE;');
    qry.Execute;
    qry.SQL.Clear;
    if not chkMain.Checked then begin 
      qry.SQL.Add('SELECT PEXTRA.* , PEXTRA.Price1 as Price2, PEXTRA.Price1 as Price3');
      qry.SQL.Add('FROM tblextrapricesell as PEXTRA , tblParts as P ');
      sWhere := GetPartWhere;
      if sWhere <> '' then begin 
        qry.SQL.Add(' WHERE PEXTRA.PartsId = P.PartsId and PEXTRA.Active="T"  ');
        qry.SQL.Add(' AND P.ACTIVE = "T" AND ' + sWhere);
      end;
      qry.SQL.Add('GROUP BY ClientTypeID;');
    end else begin 
      qry.SQL.Add('SELECT Price1, Price2, Price3');
      qry.SQL.Add('FROM tblparts AS P');
      sWhere := GetPartWhere;
      if sWhere <> '' then qry.SQL.Add('WHERE Active="T" AND ' + sWhere);
      qry.SQL.Add('LIMIT 1;');
    end;
    qry.Open;
    if qry.RecordCount > 0 then begin 
      qry2.SQL.Clear;
      if not chkMain.Checked then qry2.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '`')
      else qry2.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '` LIMIT 1;');
      qry2.Open;
      ProgressDialog.Caption := 'Scanning Prices ...';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := qry2.RecordCount;
      ProgressDialog.Step := 1;
      ProgressDialog.Value := 0;
      ProgressDialog.Execute;
      while not qry2.Eof do begin 
        if not chkMain.Checked then begin 
          if qry.Locate('ClientTypeID', qry2.FieldByName('ClientTypeID').AsInteger, [loCaseInsensitive]) then begin 
            qry2.Edit;
            qry2.FieldByName('Price1Ex').AsFloat := qry.FieldByName('Price1').AsFloat;
            (*qry2.FieldByName('Price2Ex').AsFloat := qry.FieldByName('Price2').AsFloat;
            qry2.FieldByName('Price3Ex').AsFloat := qry.FieldByName('Price3').AsFloat;*)
            dValue := GetAmountInc(qry.FieldByName('Price1').AsFloat, GetTaxRate('GST'));
            qry2.FieldByName('Price1Inc').AsFloat := dValue;
            (*dValue := GetAmountInc(qry.FieldByName('Price2').AsFloat, GetTaxRate('GST'));
            qry2.FieldByName('Price2Inc').AsFloat := dValue;
            dValue := GetAmountInc(qry.FieldByName('Price3').AsFloat, GetTaxRate('GST'));
            qry2.FieldByName('Price3Inc').AsFloat := dValue;*)
            qry2.Post;
          end;
        end else begin 
          qry2.Edit;
          qry2.FieldByName('Price1Ex').AsFloat := qry.FieldByName('Price1').AsFloat;
          (*qry2.FieldByName('Price2Ex').AsFloat := qry.FieldByName('Price2').AsFloat;
          qry2.FieldByName('Price3Ex').AsFloat := qry.FieldByName('Price3').AsFloat;*)
          dValue := GetAmountInc(qry.FieldByName('Price1').AsFloat, GetTaxRate('GST'));
          qry2.FieldByName('Price1Inc').AsFloat := dValue;
          (*dValue := GetAmountInc(qry.FieldByName('Price2').AsFloat, GetTaxRate('GST'));
          qry2.FieldByName('Price2Inc').AsFloat := dValue;
          dValue :=GetAmountInc(qry.FieldByName('Price3').AsFloat, GetTaxRate('GST'));
          qry2.FieldByName('Price3Inc').AsFloat := dValue;*)
          qry2.Post;
        end;
        ProgressDialog.StepIt;
        qry2.Next;
      end;
    end;
  finally 
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qry2) then
      FreeAndNil(qry2);
    if Assigned(ProgressDialog) then
      FreeAndNil(ProgressDialog);
    FTempTablePopulated := true;
  end;
end;

procedure TPriceUpdateGUI.DoFixedPriceUpdate;
var 
  qryTempTable: TERPQuery;
  qryUpdate, qryUpdate2: TERPCommand;
  SavedCursor: TCursor;
  sWhere: string;
  sOrigWhere: string;
  iCount: Integer;
begin 
  lblInProgress.Caption := 'In Progress .. Fixed Prices';
  lblInProgress.Visible := true;
  lblRecCount.Visible := false;
  SavedCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  qryTempTable := TERPQuery.Create(nil);
  qryUpdate := TERPCommand.Create(nil);
  qryUpdate2 := TERPCommand.Create(nil);
  try 
    qryTempTable.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTempTable.SQL.Clear;
    if not chkMain.Checked then qryTempTable.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '`;')
    else qryTempTable.SQL.Add('SELECT * FROM `' +
        GetTemporaryTableName + '` LIMIT 1;');
    qryTempTable.Open;
    qryUpdate.Connection  := MyConnection;
    qryUpdate2.Connection := MyConnection;
    ProgressBar.Max       := qryTempTable.RecordCount;
    ProgressBar.Position  := ProgressBar.Min;
    Application.ProcessMessages;
    sOrigWhere := GetPartWhere;
    iCount     := 0;
    try 
      BeginTransaction;
      qryTempTable.First;
      while not qryTempTable.Eof do begin 
        qryUpdate.SQL.Clear;
        if not chkMain.Checked then begin 
          qryUpdate.SQL.Add('UPDATE `tblextrapricesell` AS EPS');
          qryUpdate.SQL.Add('INNER JOIN tblparts AS P Using(PartsID)');
          sWhere := '(EPS.ClientTypeID = ' + qryTempTable.FieldByName('ClientTypeID').AsString + ')';
          qryUpdate.SQL.Add('SET EPS.Price1 = :xPrice1, ');
          (*qryUpdate.SQL.Add('EPS.Price2 = :xPrice2, EPS.Price3 = :xPrice3,');*)
          qryUpdate.SQL.Add('EPS.QtyPercent1 = 100.00 - ((:xPrice1a / P.Price1) * 100.00),');
          (*qryUpdate.SQL.Add('EPS.QtyPercent2 = 100.00 - ((:xPrice2a / P.Price2) * 100.00),');
          qryUpdate.SQL.Add('EPS.QtyPercent3 = 100.00 - ((:xPrice3a / P.Price3) * 100.00),');*)
          qryUpdate.SQL.Add('EPS.msTimeStamp = EPS.msTimeStamp');
          if not Empty(sWhere) then begin 
            if not Empty(sOrigWhere) then begin 
              qryUpdate.SQL.Add('WHERE ' + sOrigWhere + ' AND ' + sWhere);
            end else begin 
              qryUpdate.SQL.Add('WHERE ' +
                sWhere);
            end;
          end;
          qryUpdate.Params.ParamByName('xPrice1').AsFloat := qryTempTable.FieldByName('Price1Ex').AsFloat;
          qryUpdate.Params.ParamByName('xPrice1a').AsFloat := qryTempTable.FieldByName('Price1Ex').AsFloat;
          (*qryUpdate.Params.ParamByName('xPrice2').AsFloat := qryTempTable.FieldByName('Price2Ex').AsFloat;
          qryUpdate.Params.ParamByName('xPrice2a').AsFloat := qryTempTable.FieldByName('Price2Ex').AsFloat;
          qryUpdate.Params.ParamByName('xPrice3').AsFloat := qryTempTable.FieldByName('Price3Ex').AsFloat;
          qryUpdate.Params.ParamByName('xPrice3a').AsFloat := qryTempTable.FieldByName('Price3Ex').AsFloat;*)
          qryUpdate.Execute;
        end else begin
          qryUpdate.SQL.Add('UPDATE `tblparts` AS P');
          qryUpdate.SQL.Add('SET P.Price1 = :xPrice1, P.Price2 = :xPrice2, P.Price3 = :xPrice3,');
          qryUpdate.SQL.Add('P.msTimeStamp = P.msTimeStamp');
          if not chkAll.Checked then begin 
            sWhere := GetPartWhere;
            if sWhere <> '' then begin 
              qryUpdate.SQL.Add('WHERE Active="T" AND ' + sWhere);
            end;
          end;
          qryUpdate.Params.ParamByName('xPrice1').AsFloat := qryTempTable.FieldByName('Price1Ex').AsFloat;
          qryUpdate.Params.ParamByName('xPrice2').AsFloat := qryTempTable.FieldByName('Price1Ex').AsFloat;(*qryTempTable.FieldByName('Price2Ex').AsFloat;*)
          qryUpdate.Params.ParamByName('xPrice3').AsFloat := qryTempTable.FieldByName('Price1Ex').AsFloat;(*qryTempTable.FieldByName('Price3Ex').AsFloat;*)
          qryUpdate.Execute;
          qryUpdate2.SQL.Add('UPDATE `tblextrapricesell` AS EPS');
          qryUpdate2.SQL.Add('INNER JOIN tblparts AS P Using(PartsID)');
          qryUpdate2.SQL.Add('SET EPS.Price1 = (:xPrice1a - (:xPrice1 * (EPS.QtyPercent1 / 100))),');
          (*qryUpdate2.SQL.Add('EPS.Price2 = (:xPrice2a - (:xPrice2 * (EPS.QtyPercent2 / 100))),');
          qryUpdate2.SQL.Add('EPS.Price3 = (:xPrice3a - (:xPrice3 * (EPS.QtyPercent3 / 100))),');*)
          qryUpdate2.SQL.Add('EPS.msTimeStamp = EPS.msTimeStamp');
          if not chkAll.Checked then begin 
            sWhere := GetPartWhere;
            if sWhere <> '' then begin 
              qryUpdate2.SQL.Add('WHERE EPS.Active="T" AND ' + sWhere);
            end;
          end;
          qryUpdate2.Params.ParamByName('xPrice1').AsFloat := qryTempTable.FieldByName('Price1Ex').AsFloat;
          qryUpdate2.Params.ParamByName('xPrice1a').AsFloat := qryTempTable.FieldByName('Price1Ex').AsFloat;
          (*qryUpdate2.Params.ParamByName('xPrice2').AsFloat := qryTempTable.FieldByName('Price2Ex').AsFloat;
          qryUpdate2.Params.ParamByName('xPrice2a').AsFloat := qryTempTable.FieldByName('Price2Ex').AsFloat;
          qryUpdate2.Params.ParamByName('xPrice3').AsFloat := qryTempTable.FieldByName('Price3Ex').AsFloat;
          qryUpdate2.Params.ParamByName('xPrice3a').AsFloat := qryTempTable.FieldByName('Price3Ex').AsFloat;*)
          qryUpdate2.Execute;
        end;
        if qryUpdate.RowsAffected > -1 then begin 
          iCount := iCount + qryUpdate.RowsAffected;
        end;
        ProgressBar.StepIt;
        Application.ProcessMessages;
        qryTempTable.Next;
      end;
      CommitTransaction;
      Vista_MessageDlg.MessageDlgXP_Vista('All Possible Updates Completed !', mtInformation, [mbOK], 0);
    except 
      on e: Exception do begin 
        Audit.AddEntry(e, Self);
        RollbackTransaction;
      end;
    end;
  finally 
    if Assigned(qryTempTable) then
      FreeAndNil(qryTempTable);
    if Assigned(qryUpdate) then
      FreeAndNil(qryUpdate);
    if Assigned(qryUpdate2) then
      FreeAndNil(qryUpdate2);
    Screen.Cursor         := SavedCursor;
    lblInProgress.Caption := '    Operation Completed!';
  end;
  lblRecCount.Caption := IntToStr(iCount) + ' Records Updated';
  lblRecCount.Visible := true;
end;

procedure TPriceUpdateGUI.DeactivateProducts;
var 
  qryUsed, qryPartslist, qryUpdate: TERPQuery;
  sState: string;
  iCount: Integer;
begin 
  qryUsed := TERPQuery.Create(nil);
  qryUpdate := TERPQuery.Create(nil);
  qryPartslist := TERPQuery.Create(nil);
  try 
    if chkDeactivate.Checked then begin 
      lblInProgress.Caption := 'In Progress, Deactivating Products';
    end else begin 
      lblInProgress.Caption := 'In Progress, Activating Products';
    end;
    Application.ProcessMessages;
    CommonLib.MessageDlgXP_Vista('Please be advised that this function can possibly take over ' +
      '10 minutes for those who have alot invoices and purchase orders.'#13#10#13#10 + 'If other users are still using ERP then you should have them all log out now before continueing with this operation.',
      mtWarning, [mbOK], 0);
    lblInProgress.Visible   := true;
    lblRecCount.Visible     := false;
    qryPartsList.Connection := GetSharedMyDACConnection;
    qryUsed.Connection      := GetSharedMyDACConnection;
    qryUpdate.Connection    :=
      GetSharedMyDACConnection;
    if chkActivate.Checked then sState := 'T'
    else sState := 'F';
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE tblparts SET Active = ' + QuotedStr(sState) + ' WHERE PartsID = :xID');
    if chkDeactivate.Checked then begin 
      qryPartslist.SQL.Clear;
      qryPartsList.SQL.Add('SELECT PartsID, PARTNAME FROM tblparts;');
      qryPartsList.Open;
      qryUsed.ParamCheck := true;
      qryUsed.SQL.Clear;
      qryUsed.SQL.Add('SELECT');
      qryUsed.SQL.Add('P.PARTNAME, P.PartsID');
      qryUsed.SQL.Add('FROM tblparts P');
      qryUsed.SQL.Add('INNER JOIN tblsaleslines SL on SL.ProductID = P.PartsID');
      qryUsed.SQL.Add('INNER JOIN tblsales S on S.SaleID = SL.SaleID');
      qryUsed.SQL.Add('WHERE S.SaleDate > :xDate1');
      qryUsed.SQL.Add('UNION ');
      qryUsed.SQL.Add('SELECT');
      qryUsed.SQL.Add('P.PARTNAME, P.PartsID');
      qryUsed.SQL.Add('FROM tblparts P');
      qryUsed.SQL.Add('INNER JOIN tblpurchaselines PL on PL.ProductID = P.PartsID');
      qryUsed.SQL.Add('INNER JOIN tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID');
      qryUsed.SQL.Add('WHERE PO.OrderDate > :xDate2');
      qryUsed.SQL.Add('GROUP BY P.PARTNAME');
      qryUsed.Params.ParamByName('xDate1').AsDateTime := dtFrom.DateTime;
      qryUsed.Params.ParamByName('xDate2').AsDateTime := dtFrom.DateTime;
      qryUsed.Open;
      ProgressBar.Max := qryPartslist.RecordCount - 1;
      ProgressBar.Position := 0;
      ProgressBar.Min := 0;
      iCount := 0;
      while not qryPartslist.Eof do begin 
        if not qryUsed.Locate('PartsID',
          qryPartsList.FieldByName('PartsID').AsInteger, [loCaseInsensitive]) then begin 
          try 
            qryUpdate.Params.ParamByName('xID').AsInteger := qryPartsList.FieldByName('PartsID').AsInteger;
            qryUpdate.Execute;
            Inc(iCount);
          except 
          end;
        end;
        qryPartsList.Next;
        ProgressBar.StepIt;
        Application.ProcessMessages;
      end;
      lblRecCount.Caption := IntToStr(iCount) + ' Record(s) Updated';
      lblRecCount.Visible := true;
      lblInProgress.Caption :=
        'Operation Complete!';
    end else if chkActivate.Checked then begin 
      qryPartslist.SQL.Clear;
      qryPartsList.SQL.Add('SELECT PartsID, PARTNAME FROM tblparts;');
      qryPartsList.Open;
      ProgressBar.Max := qryPartslist.RecordCount - 1;
      ProgressBar.Position := 0;
      ProgressBar.Min := 0;
      iCount := 0;
      while not qryPartslist.Eof do begin 
        try 
          qryUpdate.Params.ParamByName('xID').AsInteger := qryPartsList.FieldByName('PartsID').AsInteger;
          qryUpdate.Execute;
          Inc(iCount);
        except 
        end;
        ProgressBar.StepIt;
        qryPartsList.Next;
        Application.ProcessMessages;
      end;
      lblRecCount.Caption := IntToStr(iCount) + ' Record(s) Updated';
      lblRecCount.Visible := true;
      lblInProgress.Caption := 'Operation Complete!';
      ProgressBar.Max := 100;
      ProgressBar.Position := 100;
    end else begin 
      CommonLib.MessageDlgXP_Vista('You must either specify to Activate or Deactivate parts that are not used after ' + DateToStr(dtFrom.DateTime), mtWarning, [mbOK], 0);
    end;
  finally 
    if Assigned(qryUsed) then
      FreeAndNil(qryUsed);
    if Assigned(qryPartslist) then
      FreeAndNil(qryPartslist);
  end;
end;

function TPriceUpdateGUI.GetGroupString: string;
begin 
  Result := '';
  if not Empty(cboFirstCol.Text) then begin 
    Result := cboFirstCol.Text;
    if not Empty(cboSecondCol.Text) then begin 
      Result := Result + '^' + cboSecondCol.Text;
    end else begin 
      if not Empty(cboThirdCol.Text) then begin 
        Result := Result + '^%';
      end;
    end;
    if not Empty(cboThirdCol.Text) then begin 
      Result := Result + '^' + cboThirdCol.Text;
    end;
  end else if not Empty(cboSecondCol.Text) then begin 
    if Result = '' then begin 
      Result := '%^' + cboSecondCol.Text;
    end;
    if not Empty(cboThirdCol.Text) then begin 
      if Result = '' then begin 
        Result := '%^%^' + cboThirdCol.Text;
      end else begin 
        Result := Result + '^' + cboThirdCol.Text;
      end;
    end else begin 
      if not empty(Result) then begin 
        Result := Result + '%';
      end;
    end;
  end else if not Empty(cboThirdCol.Text) then begin 
    if Result = '' then begin 
      Result := '%^%^' + cboThirdCol.Text;
    end else begin 
      Result :=
        Result + '^' + cboThirdCol.Text;
    end;
  end;
  if Result <> '' then if not Assigned(StrPos(Pchar(Result), '%')) then begin
    Result := Result + '%';
  end;
end;

function TPriceUpdateGUI.GetPartWhere: string;
var 
  sProductGroup: string;
begin 
  Result := '';
  if not Empty(cboType.Text) then begin 
    Result := 'P.PARTTYPE = ' + QuotedStr(cboType.LookupValue);
  end;
  if not Empty(cboPartName.Text) then begin 
    if Result = '' then begin 
      Result :=
        'P.PartsID = ' + cboPartName.LookupValue;
    end else begin 
      Result := Result + ' AND P.PartsID = ' + cboPartName.LookupValue;
    end;
  end;
  sProductGroup := GetGroupString;
  if not Empty(sProductGroup) then begin 
    if Result =
      '' then begin 
      Result := 'P.ProductGroup LIKE ' + QuotedStr(sProductGroup);
    end else begin 
      Result := Result + ' AND P.ProductGroup LIKE ' + QuotedStr(sProductGroup);
    end;
  end;
end;

procedure TPriceUpdateGUI.chkDeactivateClick(Sender: TObject);
begin 
  inherited;
  if chkDeactivate.Checked then begin 
    chkActivate.Checked := false;
    dtFrom.Enabled      := true;
  end;
end;

procedure TPriceUpdateGUI.chkActivateClick(Sender: TObject);
begin 
  inherited;
  if chkActivate.Checked then begin 
    chkDeactivate.Checked := false;
    dtFrom.Enabled        := false;
  end;
end;

procedure TPriceUpdateGUI.chkMainClick(Sender: TObject);
begin 
  inherited;
  Label3.Enabled := not chkMain.Checked;
  cboClientType2.Enabled := not chkMain.Checked;
  chkAllClientTypes.Enabled := not chkMain.Checked;
  Label16.Enabled := not chkMain.Checked;
  Label15.Enabled := not chkMain.Checked;
  cboUOM.Enabled := not chkMain.Checked;
  chkAllUOM.Enabled := not chkMain.Checked;
  Label17.Enabled := not chkMain.Checked;
  if chkMain.Checked then FTempTablePopulated := false;
end;

procedure TPriceUpdateGUI.cboPartNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin 
  if not Modified then Exit;
  inherited;
  if qryUOM2.Active then qryUOM2.Close;
  edtUnit.Text := '';
  Application.ProcessMessages;
  tmrESValidate.Enabled := true;
end;

function TPriceUpdateGUI.GetPartID(const PartName: string): Integer;
var 
  qry: TERPQuery;
begin 
  qry := TERPQuery.Create(self);
  try 
    qry.Connection := GetSharedMyDACConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblparts WHERE PartName = ');
    qry.SQL.Add(QuotedStr(PartName));
    qry.Open;
    Result := qry.FieldByName('PartsID').AsInteger;
  finally 
    FreeAndNil(qry);
  end;
end;

procedure TPriceUpdateGUI.tmrESValidateTimer(Sender: TObject);
begin 
  inherited;
  if grpPrice.ItemIndex = GRP_FIXED_EXTRASELL then begin 
    if (chkAll.Checked) or (cboType.Text <> '') or (cboPartName.Text <> '') then begin 
      Label3.Enabled := false;
      cboClientType2.Enabled := false;
      chkAllClientTypes.Enabled := false;
      Label16.Enabled := false;
      Label15.Enabled := false;
      cboUOM.Enabled := false;
      chkMain.Enabled := false;
      Label21.Enabled := false;
      Label17.Enabled := false;
      chkAllUOM.Enabled := false;
      btnFixedPrice.Enabled := false;
      btnUpdate.Enabled := false;
    end else begin 
      grpPrice.Enabled := true;
      grpPriceClick(Sender);
      chkAllClientTypesClick(Sender);
      chkMainClick(Sender);
      chkAllUOMClick(Sender);
      btnUpdate.Enabled := true;
    end;
  end else begin 
    if not btnUpdate.Enabled then btnUpdate.Enabled := true;
  end;
  Application.ProcessMessages;
  tmrESValidate.Enabled := false;
end;

procedure TPriceUpdateGUI.cboFirstColCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin 
  if not Modified then Exit;
  inherited;
  if cboFirstCol.Text <> '' then begin 
    if grpPrice.ItemIndex = GRP_FIXED_EXTRASELL then begin 
      PopulateTemporaryTable;
    end;
  end;
end;

procedure TPriceUpdateGUI.cboSecondColCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin 
  if not 
    Modified then Exit;
  inherited;
  if cboSecondCol.Text <> '' then begin 
    if grpPrice.ItemIndex = GRP_FIXED_EXTRASELL then begin 
      PopulateTemporaryTable;
    end;
  end;
end;

procedure TPriceUpdateGUI.cboThirdColCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin 
  if not Modified then Exit;
  inherited;
  if cboThirdCol.Text <> '' then begin 
    if grpPrice.ItemIndex = GRP_FIXED_EXTRASELL then begin 
      PopulateTemporaryTable;
    end;
  end;
end;

procedure TPriceUpdateGUI.IntegerEditExit(Sender: TObject);
begin 
  if not (Sender is TEdit) then Exit;
  try 
    FastFuncs.StrToInt(TEdit(Sender).Text);
  except 
    CommonLib.MessageDlgXP_Vista('Please enter whole number', mtInformation, [mbOK], 0);
    with Sender as TEdit do begin 
      Text := '0';
      if CanFocus then SetFocus;
    end;
  end;
end;

function TPriceUpdateGUI.GerPreferredLevel: Integer;
begin 
  Result :=
    StrToIntDef(edtPreferredLevel.Text, 0);
end;

function TPriceUpdateGUI.GetReOrderAmount: Integer;
begin 
  Result := StrToIntDef(edtReOrderAmount.Text, 0);
end;

function TPriceUpdateGUI.GetReOrderPoint: Integer;
begin 
  Result := StrToIntDef(edtReOrderPoints.Text, 0);
end;

procedure TPriceUpdateGUI.SetUpdateReOrderControlsEnabled(const Value: Boolean);
begin 
  EnablePanel(pnlClass, Value);
  If Value then Begin
    chkAllClass.Enabled := False;
    Label22.Enabled := False;
  end;
  pnlReOrderOptions.Enabled := Value;
  lblReOrder.Enabled := Value;
  lblReOrderPoint.Enabled := Value;
  lblPreferredLevel.Enabled := Value;
  lblReOrderAmount.Enabled := Value;
  edtReOrderPoints.Enabled := Value;
  edtPreferredLevel.Enabled := Value;
  edtReOrderAmount.Enabled := Value;
end;

procedure TPriceUpdateGUI.CheckFixedPricePreconditions;
begin 
  if not chkAllClientTypes.Checked then if (cboClientType2.Text = '') then begin 
      if chkMain.Checked then Exit;
      CommonLib.MessageDlgXP_Vista('Please select Customer Type first.', mtInformation, [mbOK], 0);
      SetControlFocus(cboClientType2);
      Abort;
    end;
  if not chkAllUOM.Checked then if (cboUOM.Text = '') then begin 
      if chkMain.Checked then Exit;
      CommonLib.MessageDlgXP_Vista('Please select Customer Type first.', mtInformation, [mbOK], 0);
      SetControlFocus(cboUOM);
      Abort;
    end;
end;

procedure TPriceUpdateGUI.cboClientType2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin 
  if not Modified then Exit;
  inherited;
  if Modified then FTempTablePopulated := false;
end;

procedure TPriceUpdateGUI.cboUOMCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
begin 
  if not Modified then Exit;
  inherited;
  FTempTablePopulated := false;
end;

procedure TPriceUpdateGUI.chkAllClassClick(Sender: TObject);
begin 
  inherited;
  ClearFilterCombos(pnlClass);
  if chkAllClass.Checked then begin 
    Label12.Enabled  := false;
    lblClass.Enabled := false;
    cboClass.Enabled := false;
  end else begin 
    Label12.Enabled  := true;
    lblClass.Enabled := true;
    cboClass.Enabled := true;
  end;
end;

procedure TPriceUpdateGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin 
  inherited;
  CanClose := tbnClose.Enabled;
end;

procedure TPriceUpdateGUI.chkBatchClick(Sender: TObject);
begin 
  inherited;
  grpBatch.Enabled := chkBatch.Checked;
end;

procedure TPriceUpdateGUI.chkBinClick(Sender: TObject);
begin 
  inherited;
  grpBin.Enabled := chkBin.Checked;
end;

procedure TPriceUpdateGUI.edtUnitBeforeDropDown(Sender: TObject);
begin 
  inherited;
  if not qryUOM2.Active then qryUOM2.Open;
end;

procedure TPriceUpdateGUI.PerformStartup(var Msg: TMessage);
begin
  IsCostBased := true;
end;

procedure TPriceUpdateGUI.btnCustomFieldClick(Sender: TObject);

begin
  inherited;
  fCustomFieldStatement := '';
  if HasCustomFields then DoBuildPriceUpdateSelection(fCustomFieldStatement); 
end;

function TPriceUpdateGUI.HasCustomFields:Boolean;
var
  i:integer;
  sTempFieldName,sTempLabelName:string;
  bFieldFound:Boolean;
  qry:TERPQuery;
begin
  inherited;
  Result := True;
  qry := CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('SELECT');
    qry.SQL.Add('CFLabel1,CFProduct1,CFLabel2,CFProduct2,CFLabel3, CFProduct3,');
    qry.SQL.Add('CFLabel4, CFProduct4,CFLabel5,CFProduct5, CFLabel6, CFProduct6,');
    qry.SQL.Add('CFLabel7, CFProduct7,  CFLabel8,CFProduct8,  CFLabel9, CFProduct9,');
    qry.SQL.Add('CFLabel10, CFProduct10, CFLabel11,CFProduct11, CFLabel12, CFProduct12,');
    qry.SQL.Add('CFLabel13, CFProduct13,  CFLabel14,CFProduct14,  CFLabel15, CFProduct15,');
    qry.SQL.Add('CFLabel16, CFlabel17,CFIsCombo1, CFIsCombo2, CFIsCombo3, CFIsCombo4, CFIsCombo5,');
    qry.SQL.Add('CFLabel18, CFProduct16, CFProduct17, CFProduct18,CFIsCombo6, CFIsCombo7, CFIsCombo8,');
    qry.SQL.Add(' CFIsCombo9, CFIsCombo10,CFIsCombo11, CFIsCombo12, CFIsCombo13, CFIsCombo14, CFIsCombo15');
    qry.SQL.Add('FROM tblcustomfields;');

    qry.Open;    
    qry.First;
    bFieldFound := False;
    for i := 0 to 15 do begin
      sTempFieldName := 'CFProduct' + IntToStr(i + 1);
      sTempLabelName := 'CFLabel' + IntToStr(i + 1);
      if qry.FieldByName(sTempFieldName).AsString = 'T' then begin
        bFieldFound := True;
      end;
    end;
    if not bFieldFound then begin
      CommonLib.MessageDlgXP_Vista('No Custom Fields found for Products.', mtInformation, [mbOK], 0);
      Result := False;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

initialization
  RegisterClassOnce(TPriceUpdateGUI);
end.







