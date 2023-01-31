unit ImportPartsToParts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, DNMPanel,
  DBAccess, MyAccess, SelectionDialog, AppEvnts, DB, MemDS,
  StdCtrls, Buttons, DNMSpeedButton, frmPurchaseOrders, ProgressDialog, ActnList, Menus, AdvMenus,
  ImgList, DataState, wwdblook, Shader, dmGUIStylers;

type
  TfrmImportPartsToParts = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    grdParts: TwwDBGrid;
    qryTempParts: TMyQuery;
    btnTransfer: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnPurchase: TDNMSpeedButton;
    dsTempParts: TDataSource;
    btnDelete: TwwIButton;
    qryTempPartsGlobalRef: TStringField;
    qryTempPartsPARTTYPE: TStringField;
    qryTempPartsPURCHASE_DESCRIPTION: TStringField;
    qryTempPartsPRODUCTCODE: TStringField;
    qryTempPartsTAXCODE: TStringField;
    qryTempPartsPURCHTAXCODE: TStringField;
    qryTempPartsPREFEREDSUPP: TStringField;
    qryTempPartsSNTracking: TStringField;
    qryTempPartsCOST2: TFloatField;
    qryTempPartsCOST3: TFloatField;
    qryTempPartsSellQTY1: TIntegerField;
    qryTempPartsSellQTY2: TIntegerField;
    qryTempPartsSellQTY3: TIntegerField;
    qryTempPartsPRICE2: TFloatField;
    qryTempPartsPRICE3: TFloatField;
    qryTempPartsWHOLESALEPRICE: TFloatField;
    qryTempPartsSupplierProductCode: TStringField;
    qryTempPartsPARTNAME: TStringField;
    qryTempPartsPARTS_DESCRIPTION: TStringField;
    qryTempPartsCOST1: TFloatField;
    qryTempPartsPRICE1: TFloatField;
    qryTempPartsCatagory: TStringField;
    qryTempPartsPARTSID: TIntegerField;
    btnImport: TDNMSpeedButton;
    Label1: TLabel;
    btnDeleteSelected: TDNMSpeedButton;
    ActionList1: TActionList;
    actDelete: TAction;
    DNMPanel3: TDNMPanel;
    Label2: TLabel;
    edtSearch: TEdit;
    btnAddFilter: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnClear: TDNMSpeedButton;
    Label3: TLabel;
    cboFilter: TComboBox;
    pumOptions: TAdvPopupMenu;
    AddtoFilter1: TMenuItem;
    ExecuteFilter1: TMenuItem;
    ClearFilter1: TMenuItem;
    imgPopup: TImageList;
    qryTempPartsCatagory2: TStringField;
    qryTempPartsCatagory3: TStringField;
    qryTempPartsDiscountCode: TStringField;
    actTransfer: TAction;
    qryTempPartsBuyQTY2: TIntegerField;
    qryTempPartsBuyQTY3: TIntegerField;
    qryTempPartsBuyQTY1: TIntegerField;
    qryTempPartsTemplateID: TIntegerField;
    qryTempPartsClonePartID: TIntegerField;
    qryTempPartsClonePartName: TStringField;
    qryPart: TMyQuery;
    cboClonePart: TwwDBLookupCombo;
    dsClonePartList: TDataSource;
    lblCount: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblFilter: TLabel;
    procedure qryTempPartsAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnTransferClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPurchaseClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure grdPartsColEnter(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnAddFilterClick(Sender: TObject);
    procedure grdPartsCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grdPartsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure actTransferUpdate(Sender: TObject);
    procedure qryPartAfterOpen(DataSet: TDataSet);
    procedure cboClonePartNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboClonePartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    sFilter: string;
    sBaseIndexFieldNames: string;

    frmPurchaseOrder: TPurchaseGUI;
    procedure BuildSearchColumnCombo;

    property BaseIndexFieldNames: string read sBaseIndexFieldNames write sBaseIndexFieldNames;

  public
    { Public declarations }
    property PurchaseOrderForm: TPurchaseGUI read frmPurchaseOrder write frmPurchaseOrder;
    property Filter: string read sFilter write sFilter;
  end;

implementation

uses
  CommonDbLib, DNMExceptions, DNMLib,  
  frmImportExportSystemGUI, tcDataUtils, CommonLib, AppEnvironment, FastFuncs;

{$R *.dfm}

procedure TfrmImportPartsToParts.qryTempPartsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryTempParts.IndexFieldNames := QuotedStr('PARTNAME') + ' ASC CIS';
  lblCount.Caption := 'Total Records : ' + FastFuncs.IntToStr(qryTempParts.RecordCount);
end;

procedure TfrmImportPartsToParts.FormShow(Sender: TObject);
begin
  try
    inherited;

    // Open our queries.
    OpenQueries;

    // Was this form launched from the purchase order form?
    if Assigned(PurchaseOrderForm) then begin
      // Yes, activate purchase button
      btnPurchase.Enabled := true;
    end else begin
      // No, deactivate purchase button.
      btnPurchase.Enabled := false;
    end;

    // Set focus to the search field.
    SetControlFocus(edtSearch);
    // Build our search Column control contents
    BuildSearchColumnCombo;
    // Point to first item within list.
    cboFilter.ItemIndex := 0;

    grdParts.ColumnByName('Catagory').DisplayLabel  := AppEnv.DefaultClass.FirstColumn;
    grdParts.ColumnByName('Catagory2').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
    grdParts.ColumnByName('Catagory3').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;

  except
    // Exception Handler
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfrmImportPartsToParts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmImportPartsToParts.btnCancelClick(Sender: TObject);
begin
  inherited;
  if Self.FormState = [fsModal] then begin
    Self.ModalResult := mrCancel;
  end else begin
    Close;
  end;
end;

procedure TfrmImportPartsToParts.btnTransferClick(Sender: TObject);
var
  iX: integer;
  ProgressDialog: TProgressDialog;
  sGroup: string;
  qry, qry2, qryClass, qryMarkups, qryExtraSell, qryPart: TMyQuery;
  dSellPrice1, dSellPrice2, dSellPrice3, dTemp: double;
begin
  inherited;
  if qryTempParts.State in [dsEdit, dsInsert] then begin
    qryTempParts.Post;
  end;

  qryTempParts.DisableControls;

  // Test to ensure parts are valid before processing.
  for iX := 0 to grdParts.SelectedList.Count - 1 do begin
    qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);
    if (qryTempParts.FieldByName('Cost1').IsNull) or (qryTempParts.FieldByName('Price1').IsNull) then begin
      CommonLib.MessageDlgXP_Vista(
        'Before imported parts can be transfered, you need to have a Cost and Sell Price.  Please ensure that both prices have been provided and try again.',
        mtWarning, [mbOK], 0);
      grdParts.UnselectAll;
      qryTempParts.EnableControls;
      Exit;
    end;
  end;

  // Create our required components.
  qry := TMyQuery.Create(nil);
  qry2 := TMyQuery.Create(nil);
  qryPart := TMyQuery.Create(nil);
  qryMarkups := TMyQuery.Create(nil);
  qryExtraSell := TMyQuery.Create(nil);
  qryClass := TMyQuery.Create(nil);
  ProgressDialog := TProgressDialog.Create(nil);
  try
    // Setup our preference default classes.
    qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryClass.SQL.Add('SELECT ID, ClassID, ClassName FROM tblpartsclasspreferences;');
    qryClass.Open;

    qryMarkups.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryMarkups.ParamCheck := true;
    qryMarkups.SQL.Clear;
    qryMarkups.SQL.Add('SELECT * FROM tblimportexportsellmarkups WHERE TemplateID = :xID');

    qryPart.Connection := CommonDBLib.GetSharedMyDACConnection;
    qryPart.ParamCheck := true;
    qryPart.SQL.Clear;
    qryPart.SQL.Add('SELECT * FROM tblparts WHERE PartsID = :xID');

    qryExtraSell.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryExtraSell.ParamCheck := true;
    qryExtraSell.SQL.Clear;
    qryExtraSell.SQL.Add('SELECT * FROM tblextrapricesell WHERE PartsID = :xID');

    // Setup our query so we can create new Part Quantity lines.
    qry2.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry2.ParamCheck := true;
    qry2.SQL.Clear;
    qry2.SQL.Add('INSERT HIGH_PRIORITY INTO `tblpartqtylines` (ProductID, ProductName, ProductGroup, ClassID, ClassName)');
    qry2.SQL.Add('VALUES');
    qry2.SQL.Add('(:xID, :xName, :xGroup, :xClassID, :xClassName);');

    // Setup this query so we can insert our part that we are going to transfer.
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO `tblparts` (PARTTYPE, PARTNAME, PARTSDESCRIPTION, PURCHASEDESC, INCOMEACCNT, ASSETACCNT,');
    qry.SQL.Add('COGSACCNT, TAXCODE, PURCHTAXCODE, BuyQty1, BuyQty2, BuyQty3, Cost1, Cost2, Cost3,CostInc1, CostInc2, CostInc3,');
    qry.SQL.Add('SellQty1, SellQty2, SellQty3, Price1, Price2, Price3, PriceInc1, PriceInc2, PriceInc3,  ');
    qry.SQL.Add('DateCreated, DateUpdated, ProductGroup,');
    qry.SQL.Add('SpecialDiscount, SNTracking, AutoReorder, Discontinued, OnSpecial, UseHedgingFormula,');
    qry.SQL.Add('PreferedSupp, ProductComment) VALUES (');
    qry.SQL.Add(':xPartType, :xPartName, :xPartDescription, :xPurchaseDescription, :xIncomeAccount, :xAssetAccount,');
    qry.SQL.Add(':xCOGSAccount, :xTaxCode, :xPurchaseTaxCode, :xBuyQty1, :xBuyQty2, :xBuyQty3,');
    qry.SQL.Add(':xCost1, :xCost2, :xCost3, :xCostInc1, :xCostInc2, :xCostInc3, :xSellQty1, :xSellQty2, :xSellQty3, :xPrice1, :xPrice2, :xPrice3,');
    qry.SQL.Add(':xPriceInc1, :xPriceInc2, :xPriceInc3, :xDateCreated, :xDateUpdated, :xProductGroup,');
    qry.SQL.Add(':xSpecialDiscount, :xSNTracking, :xAutoReorder, :xDiscontinued, :xOnSpecial, :xUseHedging,');
    qry.SQL.Add(':xPreferedSupplier, :xComment);');

    // Activate progress status dialog.
    ProgressDialog.Caption  := 'Transferring ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := grdParts.SelectedList.Count;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := 0;
    ProgressDialog.Execute;

    // Iterate and process our selection list.
    for iX := 0 to grdParts.SelectedList.Count - 1 do begin
      qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);
      // Ensure this part has a valid name.
      if FastFuncs.Trim(qryTempParts.FieldByName('PartName').AsString) = '' then Continue;
        
      ///////////////////////////////////////////////////////
      // Transfer Import Part to our Platinum1 Parts Table
      ///////////////////////////////////////////////////////
      try
        qryMarkups.Close;
        qryMarkups.Params.ParamByName('xID').AsInteger := qryTempParts.FieldByName('TemplateID').AsInteger;
        qryMarkups.Open;

        qry.Params.ParamByName('xPartType').AsString := 'INV';
        qry.Params.paramByName('xPartName').AsString := qryTempParts.FieldByName('PartName').AsString;
        qry.Params.paramByName('xPartDescription').AsString := qryTempParts.FieldByName('Parts_Description').AsString;
        qry.Params.paramByName('xPurchaseDescription').AsString := qryTempParts.FieldByName('Parts_Description').AsString;

        if qryTempParts.FieldByName('ClonePartID').AsInteger = 0 then begin
          // Build our Group String.
          sGroup := qryTempParts.FieldByName('Catagory').AsString;
          if qryTempParts.FieldByName('Catagory2').AsString <> '' then begin
            sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory2').AsString;
            if qryTempParts.FieldByName('Catagory3').AsString <> '' then begin
              sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory3').AsString;
            end;
          end;

          qry.Params.ParamByName('xIncomeAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
          qry.Params.ParamByName('xAssetAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);
          qry.Params.ParamByName('xCOGSAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);

          qry.Params.ParamByName('xUseHedging').AsString := 'F';
          qry.Params.ParamByName('xDiscontinued').AsString := 'F';
          qry.Params.ParamByName('xAutoReorder').AsString := 'F';
          qry.Params.ParamByName('xOnSpecial').AsString := 'F';
          qry.Params.ParamByName('xSpecialDiscount').AsString := 'F';
          qry.Params.ParamByName('xSNTracking').AsString := 'F';

          qry.Params.ParamByName('xTaxCode').AsString := 'GST';
          qry.Params.ParamByName('xPurchaseTaxCode').AsString := 'NCG';
          qry.Params.ParamByName('xPreferedSupplier').AsString := '';
          qry.Params.ParamByName('xComment').AsString := '';
        end else begin
          qryPart.Params.ParamByName('xID').AsInteger := qryTempParts.FieldByName('ClonePartID').AsInteger;
          qryPart.Open;
          if qryPart.RecordCount > 0 then begin
            sGroup := qryPart.FieldByName('ProductGroup').AsString;

            // Use preset accounts.
            qry.Params.ParamByName('xIncomeAccount').AsString := qryPart.FieldByName('INCOMEACCNT').AsString;
            qry.Params.ParamByName('xAssetAccount').AsString := qryPart.FieldByName('ASSETACCNT').AsString;
            qry.Params.ParamByName('xCOGSAccount').AsString := qryPart.FieldByName('COGSACCNT').AsString;

            // Use preset options.
            qry.Params.ParamByName('xUseHedging').AsString := qryPart.FieldByName('UseHedgingFormula').AsString;
            qry.Params.ParamByName('xDiscontinued').AsString := qryPart.FieldByName('Discontinued').AsString;
            qry.Params.ParamByName('xAutoReorder').AsString := qryPart.FieldByName('AutoReorder').AsString;
            qry.Params.ParamByName('xOnSpecial').AsString := qryPart.FieldByName('OnSpecial').AsString;
            qry.Params.ParamByName('xSpecialDiscount').AsString := qryPart.FieldByName('SpecialDiscount').AsString;
            qry.Params.ParamByName('xSNTracking').AsString := qryPart.FieldByName('SNTracking').AsString;

            qry.Params.ParamByName('xTaxCode').AsString := qryPart.FieldByName('TaxCode').AsString;
            qry.Params.ParamByName('xPurchaseTaxCode').AsString := qryPart.FieldByName('PurchTaxCode').AsString;
            qry.Params.ParamByName('xComment').AsString := qryPart.FieldByName('ProductComment').AsString;
            qry.Params.ParamByName('xPreferedSupplier').AsString := qryPart.FieldByName('PREFEREDSUPP').AsString;
          end else begin
            // Build our Default Group String.
            sGroup := qryTempParts.FieldByName('Catagory').AsString;
            if qryTempParts.FieldByName('Catagory2').AsString <> '' then begin
              sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory2').AsString;
              if qryTempParts.FieldByName('Catagory3').AsString <> '' then begin
                sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory3').AsString;
              end;
            end;

            // Use default accounts.
            qry.Params.ParamByName('xIncomeAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
            qry.Params.ParamByName('xAssetAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);
            qry.Params.ParamByName('xCOGSAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);

            qry.Params.ParamByName('xUOM').AsString := 'Units';
            qry.Params.ParamByName('xUOMSales').AsString := 'Units';

            qry.Params.ParamByName('xUseHedging').AsString := 'F';
            qry.Params.ParamByName('xDiscontinued').AsString := 'F';
            qry.Params.ParamByName('xAutoReorder').AsString := 'F';
            qry.Params.ParamByName('xOnSpecial').AsString := 'F';
            qry.Params.ParamByName('xSpecialDiscount').AsString := 'F';
            qry.Params.ParamByName('xSNTracking').AsString := 'F';

            qry.Params.ParamByName('xTaxCode').AsString := 'GST';
            qry.Params.ParamByName('xPurchaseTaxCode').AsString := 'NCG';
            qry.Params.ParamByName('xPreferedSupplier').AsString := '';
            qry.Params.ParamByName('xComment').AsString := '';
          end;
        end;

        qry.Params.paramByName('xProductGroup').AsString := sGroup;

       // Is this part using a discount code?
        if (qryTempParts.FieldByName('DiscountCode').AsString = '') then begin
          // No, set defaults.
          qry.params.ParamByName('xCost1').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.params.ParamByName('xCost2').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.params.ParamByName('xCost3').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.params.ParamByName('xCostInc1').AsFloat := GetAmountInc(qryTempParts.FieldByName('Cost1').AsFloat, GetTaxRate(qry.Params.ParamByName('xTaxCode').AsString));
          qry.params.ParamByName('xCostInc2').AsFloat := qry.params.ParamByName('xCostInc1').AsFloat;
          qry.params.ParamByName('xCostInc3').AsFloat := qry.params.ParamByName('xCostInc1').AsFloat;
          qry.Params.paramByName('xBuyQty1').AsInteger := 1;
          qry.Params.paramByName('xBuyQty2').AsInteger := 1;
          qry.Params.paramByName('xBuyQty3').AsInteger := 1;
        end else begin
          // Yes, Store Settings.
          qry.params.ParamByName('xCost1').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.params.ParamByName('xCost2').AsFloat := qryTempParts.FieldByName('Cost2').AsFloat;
          qry.params.ParamByName('xCost3').AsFloat := qryTempParts.FieldByName('Cost3').AsFloat;
          qry.params.ParamByName('xCostInc1').AsFloat := GetAmountInc(qryTempParts.FieldByName('Cost1').AsFloat, GetTaxRate(qry.Params.ParamByName('xTaxCode').AsString));
          qry.params.ParamByName('xCostInc2').AsFloat := qry.params.ParamByName('xCostInc1').AsFloat;
          qry.params.ParamByName('xCostInc3').AsFloat := qry.params.ParamByName('xCostInc1').AsFloat;
          qry.Params.paramByName('xBuyQty1').AsInteger := qryTempParts.FieldByName('BuyQty1').AsInteger;
          qry.Params.paramByName('xBuyQty2').AsInteger := qryTempParts.FieldByName('BuyQty2').AsInteger;
          qry.Params.paramByName('xBuyQty3').AsInteger := qryTempParts.FieldByName('BuyQty3').AsInteger;
        end;

        qry.Params.paramByName('xSellQty1').AsInteger := 1;
        qry.Params.paramByName('xSellQty2').AsInteger := 1;
        qry.Params.paramByName('xSellQty3').AsInteger := 1;

        if qryTempParts.FieldByName('Price2').AsFloat = 0 then begin
          qry.params.ParamByName('xPrice1').AsFloat := qryTempParts.FieldByName('Price1').AsFloat;
          qry.params.ParamByName('xPrice2').AsFloat := qryTempParts.FieldByName('Price1').AsFloat;
          qry.params.ParamByName('xPrice3').AsFloat := qryTempParts.FieldByName('Price1').AsFloat;
          qry.params.ParamByName('xPriceInc1').AsFloat := GetAmountInc(qryTempParts.FieldByName('Price1').AsFloat, GetTaxRate(qry.Params.ParamByName('xTaxCode').AsString));
          qry.params.ParamByName('xPriceInc2').AsFloat := qry.params.ParamByName('xPriceInc1').AsFloat;
          qry.params.ParamByName('xPriceInc3').AsFloat := qry.params.ParamByName('xPriceInc1').AsFloat;
          dSellPrice1 := qryTempParts.FieldByName('Price1').AsFloat;
          dSellPrice2 := qryTempParts.FieldByName('Price1').AsFloat;
          dSellPrice3 := qryTempParts.FieldByName('Price1').AsFloat;
        end else begin
          qry.params.ParamByName('xPriceInc1').AsFloat := GetAmountInc(qryTempParts.FieldByName('Price1').AsFloat, GetTaxRate(qry.Params.ParamByName('xTaxCode').AsString));
          qry.params.ParamByName('xPriceInc2').AsFloat := qry.params.ParamByName('xPriceInc1').AsFloat;
          qry.params.ParamByName('xPriceInc3').AsFloat := qry.params.ParamByName('xPriceInc1').AsFloat;
          dSellPrice1 := qryTempParts.FieldByName('Price1').AsFloat;
          dSellPrice2 := qryTempParts.FieldByName('Price2').AsFloat;
          dSellPrice3 := qryTempParts.FieldByName('Price3').AsFloat;
        end;

        qry.Params.ParamByName('xDateCreated').AsDateTime := Date;
        qry.Params.ParamByName('xDateUpdated').AsDateTime := Date;
        qry.Execute;

        // Now create product quantity lines for each department
        // that is set as default.
        qryClass.First;
        while not qryClass.Eof do begin
          qry2.Params.ParamByName('xID').AsInteger := GetPartID(qryTempParts.FieldByName('PartName').AsString);
          qry2.Params.ParamByName('xName').AsString := qryTempParts.FieldByName('PartName').AsString;
          qry2.Params.ParamByName('xGroup').AsString := qryTempParts.FieldByName('Catagory').AsString;
          qry2.Params.ParamByName('xName').AsString := qryTempParts.FieldByName('PartName').AsString;
          qry2.Params.ParamByName('xClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
          qry2.Params.ParamByName('xClassName').AsString := qryClass.FieldByName('ClassName').AsString;
          qry2.Execute;

          // Fetch next default class.
          qryClass.Next;
        end;

        // Now create the extra sell price lines if any required.
        qryMarkups.Close;
        qryMarkups.Params.ParamByName('xID').AsInteger := qryTempParts.FieldByName('TemplateID').AsInteger;
        qryMarkups.Open;

        if qryMarkups.RecordCount > 0 then begin
          qryExtraSell.Close;
          qryExtraSell.Params.ParamByName('xID').AsInteger := GetPartID(qryTempParts.FieldByName('PartName').AsString);
          qryExtraSell.Open;

          while not qryExtraSell.Eof do begin
            // Delete Record.
            if qryMarkups.Locate('CustomerTypeID', qryExtraSell.FieldByName('ClientTypeID').AsInteger, [loCaseInsensitive]) then
            begin
              qryExtraSell.Delete
            end else begin
              qryExtraSell.Next;
            end;
          end;

          qryMarkups.First;
          while not qryMarkups.Eof do begin
            qryExtraSell.Insert;
            qryExtraSell.FieldByName('ClientTypeID').AsInteger := qryMarkups.FieldByName('CustomerTypeID').AsInteger;
            qryExtraSell.FieldByName('PartsID').AsInteger := GetPartID(qryTempParts.FieldByName('PartName').AsString);
            qryExtraSell.FieldByName('ExtraSellDesc').AsString := qryTempParts.FieldByName('Parts_Description').AsString;
            qryExtraSell.FieldByName('QtyPercent1').AsFloat := qryMarkups.FieldByName('PriceMarkup1').AsFloat;
            qryExtraSell.FieldByName('QtyPercent2').AsFloat := qryMarkups.FieldByName('PriceMarkup2').AsFloat;
            qryExtraSell.FieldByName('QtyPercent3').AsFloat := qryMarkups.FieldByName('PriceMarkup3').AsFloat;
            dTemp := dSellPrice1 - (dSellPrice1 * (qryMarkups.FieldByName('PriceMarkup1').AsFloat / 100.0));
            qryExtraSell.FieldByName('Price1').AsFloat := dTemp;
            dTemp := dSellPrice2 - (dSellPrice2 * (qryMarkups.FieldByName('PriceMarkup2').AsFloat / 100.0));
            qryExtraSell.FieldByName('Price2').AsFloat := dTemp;
            dTemp := dSellPrice3 - (dSellPrice3 * (qryMarkups.FieldByName('PriceMarkup3').AsFloat / 100.0));
            qryExtraSell.FieldByName('Price3').AsFloat := dTemp;
            qryExtraSell.Post;
            // Fetch next record.
            qryMarkups.Next;
          end;
        end;

      except 
      end;
      // Show progress status.
      ProgressDialog.StepIt;
    end;

    // Change Progress status dialog to state we are
    // now performing the remove operation.
    ProgressDialog.CloseDialog;
    ProgressDialog.Caption  := 'Removing Temporary Parts ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := grdParts.SelectedList.Count;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := 0;
    ProgressDialog.Execute;

    // Delete all selected entries in reverse order.
    for iX := grdParts.SelectedList.Count - 1 downto 0 do begin
      // Get selected item.
      qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);

      // Delete this temporary product.
      qryTempParts.Delete;

      // Advance Progress Status.
      ProgressDialog.StepIt;
    end;

  finally
    // Release our used allocated objects.
    if Assigned(ProgressDialog) then
      FreeAndNil(ProgressDialog);
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qry2) then
      FreeAndNil(qry2);
    if Assigned(qryPart) then
      FreeAndNil(qryPart);
    if Assigned(qryMarkups) then
      FreeAndNil(qryMarkups);
    if Assigned(qryExtraSell) then
      FreeAndNil(qryExtraSell);
    if Assigned(qryClass) then
      FreeAndNil(qryClass);
  end;

  // Restore control.
  qryTempParts.EnableControls;

  // Ensure no selections are visible.
  grdParts.UnselectAll;
end;

procedure TfrmImportPartsToParts.btnDeleteClick(Sender: TObject);
begin
  inherited;
  // Delete record.
  DeleteRecord(qryTempParts);
  lblCount.Caption := 'Total Records : ' + FastFuncs.IntToStr(qryTempParts.RecordCount);
end;

procedure TfrmImportPartsToParts.btnPurchaseClick(Sender: TObject);
var
  iX: integer;
  ProgressDialog: TProgressDialog;
  sGroup: string;
  qry, qry2, qryClass, qryMarkups, qryExtraSell, qryPart: TMyQuery;
  dSellPrice1, dSellPrice2, dSellPrice3, dTemp: double;
begin
  if not Assigned(PurchaseOrderForm) then Exit;
  if qryTempParts.State in [dsEdit, dsInsert] then begin
    qryTempParts.Post;
  end;

  // Disable all controls that are binded to this query.
  qryTempParts.DisableControls;

  // Test to ensure parts are valid before processing.
  for iX := 0 to grdParts.SelectedList.Count - 1 do begin
    qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);
    if (qryTempParts.FieldByName('Cost1').IsNull) or (qryTempParts.FieldByName('Price1').IsNull) then begin
      CommonLib.MessageDlgXP_Vista(
        'Before imported parts can be transfered, you need to have a Cost and Sell Price.  Please ensure that both prices have been provided and try again.',
        mtWarning, [mbOK], 0);
      grdParts.UnselectAll;
      qryTempParts.EnableControls;
      Exit;
    end;
  end;

  // Create our required components.
  qry := TMyQuery.Create(nil);
  qry2 := TMyQuery.Create(nil);
  qryPart := TMyQuery.Create(nil);
  qryMarkups := TMyQuery.Create(nil);
  qryExtraSell := TMyQuery.Create(nil);
  qryClass := TMyQuery.Create(nil);
  ProgressDialog := TProgressDialog.Create(nil);
  try
    // Setup our preference default classes.
    qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryClass.SQL.Add('SELECT ID, ClassID, ClassName FROM tblpartsclasspreferences;');
    qryClass.Open;
    
    // Setup our query so we can create new Part Quantity lines.
    qry2.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry2.ParamCheck := true;
    qry2.SQL.Clear;
    qry2.SQL.Add('INSERT HIGH_PRIORITY INTO `tblpartqtylines` (ProductID, ProductName, ProductGroup, ClassID, ClassName)');
    qry2.SQL.Add('VALUES');
    qry2.SQL.Add('(:xID, :xName, :xGroup, :xClassID, :xClassName);');

    qryMarkups.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryMarkups.ParamCheck := true;
    qryMarkups.SQL.Clear;
    qryMarkups.SQL.Add('SELECT * FROM tblimportexportsellmarkups WHERE TemplateID = :xID');

    qryExtraSell.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryExtraSell.ParamCheck := true;
    qryExtraSell.SQL.Clear;
    qryExtraSell.SQL.Add('SELECT * FROM tblextrapricesell WHERE PartsID = :xID');

    qryPart.Connection := CommonDBLib.GetSharedMyDACConnection;
    qryPart.ParamCheck := true;
    qryPart.SQL.Clear;
    qryPart.SQL.Add('SELECT * FROM tblparts WHERE PartsID = :xID');

    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO `tblparts` (PARTTYPE, PARTNAME, PARTSDESCRIPTION, PURCHASEDESC, INCOMEACCNT, ASSETACCNT,');
    qry.SQL.Add('COGSACCNT, TAXCODE, PURCHTAXCODE, BuyQty1, BuyQty2, BuyQty3, Cost1, Cost2, Cost3,');
    qry.SQL.Add('SellQty1, SellQty2, SellQty3, Price1, Price2, Price3, '); //UnitOfMeasure, UnitOfMeasureID, UnitOfMeasureSales, UnitOfMeasureIDSales,
    qry.SQL.Add('DateCreated, DateUpdated, ProductGroup,');
    qry.SQL.Add('SpecialDiscount, SNTracking, AutoReorder, Discontinued, OnSpecial, UseHedgingFormula,');
    qry.SQL.Add('PreferedSupp, ProductComment) VALUES (');
    qry.SQL.Add(':xPartType, :xPartName, :xPartDescription, :xPurchaseDescription, :xIncomeAccount, :xAssetAccount,');
    qry.SQL.Add(':xCOGSAccount, :xTaxCode, :xPurchaseTaxCode, :xBuyQty1, :xBuyQty2, :xBuyQty3,');
    qry.SQL.Add(':xCost1, :xCost2, :xCost3, :xSellQty1, :xSellQty2, :xSellQty3, :xPrice1, :xPrice2, :xPrice3,');
    qry.SQL.Add(':xDateCreated, :xDateUpdated, :xProductGroup,'); //:xUOM, :xUOMID, :xUOMSales, :xUOMSalesID, 
    qry.SQL.Add(':xSpecialDiscount, :xSNTracking, :xAutoReorder, :xDiscontinued, :xOnSpecial, :xUseHedging,');
    qry.SQL.Add(':xPreferedSupplier, :xComment);');

    // Activate the progress dialog.
    ProgressDialog.Caption  := 'Transferring ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := grdParts.SelectedList.Count;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := 0;
    ProgressDialog.Execute;

    ///////////////////////////////////////////////////////
    // We will first need to add these parts to our
    // main product list otherwise the purchase order
    // will not know the Parts ID and therefore show
    // nothing in the product column.
    ///////////////////////////////////////////////////////
    for iX := 0 to grdParts.SelectedList.Count - 1 do begin
      // Get next selected part.
      qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);
      // Ensure this part has a valid name.
      if FastFuncs.Trim(qryTempParts.FieldByName('PartName').AsString) = '' then Continue;

      dSellPrice1 := 0;
      dSellPrice2 := 0;
      dSellPrice3 := 0;

      ///////////////////////////////////////////////////////
      // Transfer Import Part to our Platinum1 Parts Table
      ///////////////////////////////////////////////////////
      try
        // Initialise parameters.
        if qryTempParts.FieldByName('ClonePartID').AsInteger = 0 then begin
          // Build our Group String.
          sGroup := qryTempParts.FieldByName('Catagory').AsString;
          if qryTempParts.FieldByName('Catagory2').AsString <> '' then begin
            sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory2').AsString;
            if qryTempParts.FieldByName('Catagory3').AsString <> '' then begin
              sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory3').AsString;
            end;
          end;

          qry.Params.ParamByName('xIncomeAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
          qry.Params.ParamByName('xAssetAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);
          qry.Params.ParamByName('xCOGSAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);

          qry.Params.ParamByName('xUseHedging').AsString := 'F';
          qry.Params.ParamByName('xDiscontinued').AsString := 'F';
          qry.Params.ParamByName('xAutoReorder').AsString := 'F';
          qry.Params.ParamByName('xOnSpecial').AsString := 'F';
          qry.Params.ParamByName('xSpecialDiscount').AsString := 'F';
          qry.Params.ParamByName('xSNTracking').AsString := 'F';

          qry.Params.ParamByName('xTaxCode').AsString := 'GST';
          qry.Params.ParamByName('xPurchaseTaxCode').AsString := 'NCG';
          qry.Params.ParamByName('xPreferedSupplier').AsString := PurchaseOrderForm.cboClient.Text;
          qry.Params.ParamByName('xComment').AsString := '';
        end else begin
          qryPart.Params.ParamByName('xID').AsInteger := qryTempParts.FieldByName('ClonePartID').AsInteger;
          qryPart.Open;
          if qryPart.RecordCount > 0 then begin
            sGroup := qryPart.FieldByName('ProductGroup').AsString;

            // Use Preset Unit Of Measures.
            {qry.Params.ParamByName('xUOM').AsString := qryPart.FieldByName('UnitOfMeasure').AsString;
            qry.Params.ParamByName('xUOMSales').AsString := qryPart.FieldByName('UnitOfMeasureSales').AsString;
            qry.Params.ParamByName('xUOMID').AsString := qryPart.FieldByName('UnitOfMeasureID').AsString;
            qry.Params.ParamByName('xUOMSalesID').AsString := qryPart.FieldByName('UnitOfMeasureIDSales').AsString;}

            // Use preset accounts.
            qry.Params.ParamByName('xIncomeAccount').AsString := qryPart.FieldByName('INCOMEACCNT').AsString;
            qry.Params.ParamByName('xAssetAccount').AsString := qryPart.FieldByName('ASSETACCNT').AsString;
            qry.Params.ParamByName('xCOGSAccount').AsString := qryPart.FieldByName('COGSACCNT').AsString;

            // Use preset options.
            qry.Params.ParamByName('xUseHedging').AsString := qryPart.FieldByName('UseHedgingFormula').AsString;
            qry.Params.ParamByName('xDiscontinued').AsString := qryPart.FieldByName('Discontinued').AsString;
            qry.Params.ParamByName('xAutoReorder').AsString := qryPart.FieldByName('AutoReorder').AsString;
            qry.Params.ParamByName('xOnSpecial').AsString := qryPart.FieldByName('OnSpecial').AsString;
            qry.Params.ParamByName('xSpecialDiscount').AsString := qryPart.FieldByName('SpecialDiscount').AsString;
            qry.Params.ParamByName('xSNTracking').AsString := qryPart.FieldByName('SNTracking').AsString;

            qry.Params.ParamByName('xTaxCode').AsString := qryPart.FieldByName('TaxCode').AsString;
            qry.Params.ParamByName('xPurchaseTaxCode').AsString := qryPart.FieldByName('PurchTaxCode').AsString;
            qry.Params.ParamByName('xPreferedSupplier').AsString := PurchaseOrderForm.cboClient.Text;
            qry.Params.ParamByName('xComment').AsString := qryPart.FieldByName('ProductComment').AsString;
          end else begin
            // Build our Default Group String.
            sGroup := qryTempParts.FieldByName('Catagory').AsString;
            if qryTempParts.FieldByName('Catagory2').AsString <> '' then begin
              sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory2').AsString;
              if qryTempParts.FieldByName('Catagory3').AsString <> '' then begin
                sGroup := sGroup + '^' + qryTempParts.FieldByName('Catagory3').AsString;
              end;
            end;

            // Use default accounts.
            qry.Params.ParamByName('xIncomeAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
            qry.Params.ParamByName('xAssetAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);
            qry.Params.ParamByName('xCOGSAccount').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);

            qry.Params.ParamByName('xUOM').AsString := 'Units';
            qry.Params.ParamByName('xUOMSales').AsString := 'Units';

            qry.Params.ParamByName('xUseHedging').AsString := 'F';
            qry.Params.ParamByName('xDiscontinued').AsString := 'F';
            qry.Params.ParamByName('xAutoReorder').AsString := 'F';
            qry.Params.ParamByName('xOnSpecial').AsString := 'F';
            qry.Params.ParamByName('xSpecialDiscount').AsString := 'F';
            qry.Params.ParamByName('xSNTracking').AsString := 'F';

            qry.Params.ParamByName('xTaxCode').AsString := 'GST';
            qry.Params.ParamByName('xPurchaseTaxCode').AsString := 'NCG';
            qry.Params.ParamByName('xPreferedSupplier').AsString := PurchaseOrderForm.cboClient.Text;
            qry.Params.ParamByName('xComment').AsString := '';
          end;
        end;

        qry.Params.ParamByName('xPartType').AsString := 'INV';
        qry.Params.paramByName('xProductGroup').AsString := sGroup;
        qry.Params.paramByName('xPartName').AsString := qryTempParts.FieldByName('PartName').AsString;
        qry.Params.paramByName('xPartDescription').AsString := qryTempParts.FieldByName('Parts_Description').AsString;
        qry.Params.paramByName('xPurchaseDescription').AsString := qryTempParts.FieldByName('Parts_Description').AsString;

        if (qryTempParts.FieldByName('DiscountCode').AsString = '') then begin
          qry.params.ParamByName('xCost1').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.params.ParamByName('xCost2').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.params.ParamByName('xCost3').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.Params.paramByName('xBuyQty1').AsInteger := 1;
          qry.Params.paramByName('xBuyQty2').AsInteger := 1;
          qry.Params.paramByName('xBuyQty3').AsInteger := 1;
        end else begin
          qry.params.ParamByName('xCost1').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
          qry.params.ParamByName('xCost2').AsFloat := qryTempParts.FieldByName('Cost2').AsFloat;
          qry.params.ParamByName('xCost3').AsFloat := qryTempParts.FieldByName('Cost3').AsFloat;
          qry.Params.paramByName('xBuyQty1').AsInteger := qryTempParts.FieldByName('BuyQty1').AsInteger;
          qry.Params.paramByName('xBuyQty2').AsInteger := qryTempParts.FieldByName('BuyQty2').AsInteger;
          qry.Params.paramByName('xBuyQty3').AsInteger := qryTempParts.FieldByName('BuyQty3').AsInteger;
        end;

        qry.Params.paramByName('xSellQty1').AsInteger := 1;
        qry.Params.paramByName('xSellQty2').AsInteger := 1;
        qry.Params.paramByName('xSellQty3').AsInteger := 1;

        if qryTempParts.FieldByName('Price2').AsFloat = 0 then begin
          qry.params.ParamByName('xPrice1').AsFloat := qryTempParts.FieldByName('Price1').AsFloat;
          qry.params.ParamByName('xPrice2').AsFloat := qryTempParts.FieldByName('Price1').AsFloat;
          qry.params.ParamByName('xPrice3').AsFloat := qryTempParts.FieldByName('Price1').AsFloat;
          dSellPrice1 := qryTempParts.FieldByName('Price1').AsFloat;
          dSellPrice2 := qryTempParts.FieldByName('Price1').AsFloat;
          dSellPrice3 := qryTempParts.FieldByName('Price1').AsFloat;
        end else begin
          qry.params.ParamByName('xPrice1').AsFloat := qryTempParts.FieldByName('Price1').AsFloat;
          qry.params.ParamByName('xPrice2').AsFloat := qryTempParts.FieldByName('Price2').AsFloat;
          qry.params.ParamByName('xPrice3').AsFloat := qryTempParts.FieldByName('Price3').AsFloat;
          dSellPrice1 := qryTempParts.FieldByName('Price1').AsFloat;
          dSellPrice2 := qryTempParts.FieldByName('Price2').AsFloat;
          dSellPrice3 := qryTempParts.FieldByName('Price3').AsFloat;
        end;

        qry.Params.ParamByName('xDateCreated').AsDateTime := Date;
        qry.Params.ParamByName('xDateUpdated').AsDateTime := Date;

        // Create part.
        qry.Execute;

        ///////////////////////////////////////////////////////
        // Now create product quantity lines for each department
        // that is set as default.
        ///////////////////////////////////////////////////////
        qryClass.First;
        while not qryClass.Eof do begin
          // Initialise parameters.
          qry2.Params.ParamByName('xID').AsInteger := GetPartID(qryTempParts.FieldByName('PartName').AsString);
          qry2.Params.ParamByName('xName').AsString := qryTempParts.FieldByName('PartName').AsString;
          qry2.Params.ParamByName('xGroup').AsString := qryTempParts.FieldByName('Catagory').AsString;
          qry2.Params.ParamByName('xName').AsString := qryTempParts.FieldByName('PartName').AsString;
          qry2.Params.ParamByName('xClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
          qry2.Params.ParamByName('xClassName').AsString := qryClass.FieldByName('ClassName').AsString;

          // Create Part Qty Line Record.
          qry2.Execute;

          // Fetch next default class.
          qryClass.Next;
        end;

      except 
      end;

      /////////////////////////////////////////////////////////
      // Now create the extra sell price lines if any required.
      /////////////////////////////////////////////////////////
      qryMarkups.Close;
      qryMarkups.Params.ParamByName('xID').AsInteger := qryTempParts.FieldByName('TemplateID').AsInteger;
      qryMarkups.Open;

      if qryMarkups.RecordCount > 0 then begin
        qryExtraSell.Close;
        qryExtraSell.Params.ParamByName('xID').AsInteger := GetPartID(qryTempParts.FieldByName('PartName').AsString);
        qryExtraSell.Open;

        while not qryExtraSell.Eof do begin
          // Delete Record.
          if qryMarkups.Locate('CustomerTypeID', qryExtraSell.FieldByName('ClientTypeID').AsInteger, [loCaseInsensitive]) then
          begin
            qryExtraSell.Delete
          end else begin
            qryExtraSell.Next;
          end;
        end;

        qryMarkups.First;
        while not qryMarkups.Eof do begin
          qryExtraSell.Insert;
          qryExtraSell.FieldByName('ClientTypeID').AsInteger := qryMarkups.FieldByName('CustomerTypeID').AsInteger;
          qryExtraSell.FieldByName('PartsID').AsInteger := GetPartID(qryTempParts.FieldByName('PartName').AsString);
          qryExtraSell.FieldByName('ExtraSellDesc').AsString := qryTempParts.FieldByName('Parts_Description').AsString;
          qryExtraSell.FieldByName('QtyPercent1').AsFloat := qryMarkups.FieldByName('PriceMarkup1').AsFloat;
          qryExtraSell.FieldByName('QtyPercent2').AsFloat := qryMarkups.FieldByName('PriceMarkup2').AsFloat;
          qryExtraSell.FieldByName('QtyPercent3').AsFloat := qryMarkups.FieldByName('PriceMarkup3').AsFloat;
          dTemp := dSellPrice1 - (dSellPrice1 * (qryMarkups.FieldByName('PriceMarkup1').AsFloat / 100.0));
          qryExtraSell.FieldByName('Price1').AsFloat := dTemp;
          dTemp := dSellPrice2 - (dSellPrice2 * (qryMarkups.FieldByName('PriceMarkup2').AsFloat / 100.0));
          qryExtraSell.FieldByName('Price2').AsFloat := dTemp;
          dTemp := dSellPrice3 - (dSellPrice3 * (qryMarkups.FieldByName('PriceMarkup3').AsFloat / 100.0));
          qryExtraSell.FieldByName('Price3').AsFloat := dTemp;
          qryExtraSell.Post;
          // Fetch next record.
          qryMarkups.Next;
        end;
      end;

      // Advance progress status.
      ProgressDialog.StepIt;
    end;

    // Refresh the purchase orders product list.
    PurchaseOrderForm.cboProductQry.Close;
    PurchaseOrderForm.cboProductQry.Open;
    PurchaseOrderForm.tblDetails.Last;

    ProgressDialog.CloseDialog;
    ProgressDialog.Caption  := 'Adding to Purchase Order ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := grdParts.SelectedList.Count;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := 0;
    ProgressDialog.Execute;

    for iX := 0 to grdParts.SelectedList.Count - 1 do begin
      qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);
      ///////////////////////////////////////////////////////
      // Add this part to our Purchase Order.
      ///////////////////////////////////////////////////////
      PurchaseOrderForm.tblDetails.Append;
      PurchaseOrderForm.tblDetails.FieldByName('ProductName').AsString := qryTempParts.FieldByName('PartName').AsString;
      PurchaseOrderForm.tblDetails.FieldByName('PurchaseOrderID').AsInteger :=
        PurchaseOrderForm.tblMaster.FieldByName('PurchaseOrderID').AsInteger;
      PurchaseOrderForm.cboProductXCloseUp(Self, PurchaseOrderForm.cboProductQry, PurchaseOrderForm.tblDetails, true);
      PurchaseOrderForm.tblDetails.FieldByName('SearchFilter').AsString := qryTempParts.FieldByName('PartName').AsString;
      PurchaseOrderForm.tblDetails.FieldByName('SearchFilterCopy').AsString :=
        qryTempParts.FieldByName('PartName').AsString;
      PurchaseOrderForm.tblDetails.FieldByName('ProductID').AsInteger :=
        GetPartID(qryTempParts.FieldByName('PartName').AsString);
      PurchaseOrderForm.tblDetails.FieldByName('Product_Description').AsString :=
        qryTempParts.FieldByName('Parts_Description').AsString;
      PurchaseOrderForm.tblDetails.FieldByName('LineTaxCode').AsString := 'NCG';
      PurchaseOrderForm.tblDetails.FieldByName('PartType').AsString := 'INV';
      PurchaseOrderForm.tblDetails.FieldByName('LineTaxRate').AsFloat := GetTaxRate('NCG');
      PurchaseOrderForm.tblDetails.FieldByName('INCOMEACCNT').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
      PurchaseOrderForm.tblDetails.FieldByName('ASSETACCNT').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);
      PurchaseOrderForm.tblDetails.FieldByName('COGSACCNT').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);
      PurchaseOrderForm.tblDetails.FieldByName('UnitOfMeasurePOLines').AsString := 'Units';
      PurchaseOrderForm.tblDetails.FieldByname('UnitOfMeasureId').asInteger := GetUnitOfMeasureID('Units'  , PurchaseOrderForm.tblDetails.FieldByName('ProductID').AsInteger);
      PurchaseOrderForm.tblDetails.FieldByName('ClassID').AsInteger := AppEnv.DefaultClass.ClassID;
      PurchaseOrderForm.tblDetails.FieldByName('Class').AsString := AppEnv.DefaultClass.DefaultClassName;
      PurchaseOrderForm.tblDetails.FieldByName('UseTimeCost').AsString := 'F';
      PurchaseOrderForm.tblDetails.FieldByName('UnitOfMeasureMultiplier').AsFloat := 1;
      PurchaseOrderForm.tblDetails.FieldByName('UnitOfMeasureQtySold').AsFloat := 1;
      PurchaseOrderForm.tblDetails.Edit;
//       PurchaseOrderForm.tblDetails.FieldByName('QtySold').AsFloat := 1;
      PurchaseOrderForm.tblDetails.FieldByName('LineCost').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
      PurchaseOrderForm.tblDetails.FieldByName('AvgCost').AsFloat := qryTempParts.FieldByName('Cost1').AsFloat;
      PurchaseOrderForm.tblDetails.FieldByName('LineCostInc').AsFloat := GetAmountInc(qryTempParts.FieldByName('Cost1').AsFloat, GetTaxRate('NCG'));

      // Advance progress status.
      ProgressDialog.StepIt;
    end;

    ProgressDialog.CloseDialog;
    ProgressDialog.Caption  := 'Removing Temporary Parts ...';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := grdParts.SelectedList.Count;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := 0;
    ProgressDialog.Execute;

    for iX := 0 to grdParts.SelectedList.Count - 1 do begin
      qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);
      // Delete this temporary product.
      qryTempParts.Delete;
      ProgressDialog.StepIt;
    end;

  finally
    // Release our used objects.
    if Assigned(ProgressDialog) then
      FreeAndNil(ProgressDialog);
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qry2) then
      FreeAndNil(qry2);
    if Assigned(qryPart) then
      FreeAndNil(qryPart);
    if Assigned(qryClass) then
      FreeAndNil(qryClass);
    if Assigned(qryExtraSell) then
      FreeAndNil(qryExtraSell);

    // We are now done - Close form and return to purchase order form.
    if Self.FormState = [fsModal] then begin
      Self.ModalResult := mrOk;
    end else begin
      Close;
    end;
  end;
end;

procedure TfrmImportPartsToParts.btnImportClick(Sender: TObject);
Var Form : TComponent;
begin
  Form := GetComponentByClassName('TfrmImportExportSystem');
  if Assigned(Form) then begin //if has acess
    with TfrmImportExportSystem(Form) do begin
      FormStyle := fsNormal;
      ShowModal;
    end;
  end;  

  // Refresh list.
  qryTempParts.Close;
  qryTempParts.Open;
end;

procedure TfrmImportPartsToParts.edtSearchChange(Sender: TObject);
begin
  inherited;
  if Empty(edtSearch.Text) then begin
    qryTempParts.Filtered := false;
    if sFilter <> '' then begin
      qryTempParts.Filter := sFilter;
      qryTempParts.Filtered := true;
    end else begin
      qryTempParts.Filter := '';
    end;
  end else begin
    qryTempParts.Filtered := false;
    if sFilter <> '' then begin
      qryTempParts.Filter := sFilter + ' OR ' + cboFilter.Text + ' = ' + QuotedStr(edtSearch.Text + '*');
    end else begin
      qryTempParts.Filter := cboFilter.Text + ' = ' + QuotedStr(edtSearch.Text + '*');
    end;

    qryTempParts.Filtered := true;
  end;
  // Update our Filter label.
  lblFilter.Caption := 'Filter : ' + qryTempParts.Filter;
  lblCount.Caption := 'Total Records : ' + FastFuncs.IntToStr(qryTempParts.RecordCount);
end;

procedure TfrmImportPartsToParts.actDeleteUpdate(Sender: TObject);
begin
  inherited;
  if grdParts.SelectedList.Count > 0 then begin
    btnDeleteSelected.Enabled := true;
  end else begin
    btnDeleteSelected.Enabled := false;
  end;
end;

procedure TfrmImportPartsToParts.actDeleteExecute(Sender: TObject);
var
  iX: integer;
begin
  inherited;
  // Remove all selected items going in reverse.
  for iX := grdParts.SelectedList.Count - 1 downto 0 do begin
    // Get selected record.
    qryTempParts.GotoBookmark(grdParts.SelectedList.Items[iX]);
    // Delete record.
    qryTempParts.Delete;
  end;

  grdParts.SelectedList.Clear;
  qryTempParts.First;
  lblCount.Caption := 'Total Records : ' + FastFuncs.IntToStr(qryTempParts.RecordCount);
end;

procedure TfrmImportPartsToParts.BuildSearchColumnCombo;
var
  iX: integer;
begin
  cboFilter.Items.Clear;
  for iX := 0 to grdParts.FieldCount - 1 do begin
    cboFilter.Items.Add(grdParts.Columns[iX].FieldName);
  end;
end;

procedure TfrmImportPartsToParts.btnClearClick(Sender: TObject);
begin
  inherited;
  sFilter := '';
  if not Empty(edtSearch.Text) then begin
    qryTempParts.Filtered := false;
    qryTempParts.Filter   := cboFilter.Text + ' = ' + QuotedStr(edtSearch.Text + '*');
    qryTempParts.Filtered := true;
  end else begin
    qryTempParts.Filtered := false;
  end;

  btnExecute.Enabled := false;
  btnClear.Enabled := false;
  ExecuteFilter1.Enabled := false;
  ClearFilter1.Enabled := false;
  lblFilter.Caption := qryTempParts.Filter;
  lblCount.Caption := 'Total Records : ' + FastFuncs.IntToStr(qryTempParts.RecordCount);
end;

procedure TfrmImportPartsToParts.grdPartsColEnter(Sender: TObject);
  function FindColumnItemIndex(Const Fieldname: string): integer;
  var
    iX: integer;
  begin
    Result := -1;
    for iX := 0 to cboFilter.Items.Count - 1 do begin
      if cboFilter.Items.Strings[iX] = FieldName then begin
        Result := iX;
        Exit;
      end;
    end;
  end;
begin
  inherited;
  cboFilter.ItemIndex := FindColumnItemIndex(TwwDBGrid(Sender).Columns[TwwDBGrid(Sender).GetActiveCol - 1].FieldName);
end;

procedure TfrmImportPartsToParts.btnExecuteClick(Sender: TObject);
begin
  inherited;
  // Are we using a search filter?
  if Empty(edtSearch.Text) then begin
    // No
    qryTempParts.Filtered := false;
    // Do we have a selected filter?
    if not Empty(sFilter) then begin
      // Yes, set selected filter.
      qryTempParts.Filter := sFilter;
      qryTempParts.Filtered := true;
    end;
  end else begin
    // Yes
    qryTempParts.Filtered := false;
    qryTempParts.Filter   := sFilter + ' OR ' + cboFilter.Text + ' = ' + QuotedStr(edtSearch.Text + '*');
    qryTempParts.Filtered := true;
  end;

  // Update our Filter label.
  lblFilter.Caption := 'Filter : ' + qryTempParts.Filter;
  btnExecute.Enabled := false;
  ExecuteFilter1.Enabled := false;
  lblCount.Caption := 'Total Records : ' + FastFuncs.IntToStr(qryTempParts.RecordCount);
end;

procedure TfrmImportPartsToParts.btnAddFilterClick(Sender: TObject);
begin
  inherited;
  sFilter := cboFilter.Text + ' = ' + QuotedStr(grdParts.GetActiveField.AsString);
  btnExecute.Enabled := true;
  ExecuteFilter1.Enabled := true;
  btnClear.Enabled := true;
  ClearFilter1.Enabled := true;
end;

procedure TfrmImportPartsToParts.grdPartsCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if (FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' ASC CIS;', qryTempParts.IndexFieldNames) > 0) then begin
    TitleImageAttributes.ImageIndex := 3;
  end else if FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' DESC CIS;', qryTempParts.IndexFieldNames) > 0 then begin
    TitleImageAttributes.ImageIndex := 4;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TfrmImportPartsToParts.grdPartsTitleButtonClick(Sender: TObject; AFieldName: string);
var 
  Save_Cursor: TCursor;
  tmpIndex: string;
begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if Assigned(qryTempParts.FindField(AFieldName)) then begin
      if (qryTempParts.FieldByName(AFieldName).FieldKind <> fkLookup) and
        (qryTempParts.FieldByName(AFieldName).FieldKind <> fkCalculated) and
        (qryTempParts.FieldByName(AFieldName).DataType <> ftMemo) then begin
        qryTempParts.DisableControls;
        if (FastFuncs.PosEx(QuotedStr(AFieldName) + ' ASC CIS', qryTempParts.IndexFieldNames) <> 0) then begin
          if not empty(BaseIndexFieldNames) and (FastFuncs.PosEx(QuotedStr(AFieldName), BaseIndexFieldNames) = 0) then begin
            tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BaseIndexFieldNames;
          end else begin
            tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
          end;

          qryTempParts.IndexFieldNames := tmpIndex;
        end else begin
          if not empty(BaseIndexFieldNames) and (FastFuncs.PosEx(QuotedStr(AFieldName), BaseIndexFieldNames) = 0) then begin
            tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + BaseIndexFieldNames;
          end else begin
            tmpIndex := QuotedStr(AFieldName) + ' ASC CIS;';
          end;

          try
            qryTempParts.IndexFieldNames := '';
            Application.ProcessMessages;
            qryTempParts.IndexFieldNames := tmpIndex;
          except
          end;
        end;
        qryTempParts.EnableControls;
      end;
    end;
  finally
    Screen.Cursor := Save_Cursor;
  end;
end;

procedure TfrmImportPartsToParts.actTransferUpdate(Sender: TObject);
begin
  inherited;
  if grdParts.SelectedList.Count > 0 then begin
    btnTransfer.Enabled := true;
  end else begin
    btnTransfer.Enabled := false;
  end;
end;

procedure TfrmImportPartsToParts.qryPartAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryPart.IndexFieldNames := 'PARTNAME ASC CIS';
end;

procedure TfrmImportPartsToParts.cboClonePartNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  Accept := false;
end;

procedure TfrmImportPartsToParts.cboClonePartCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboClonePart.Text = '' then Exit;
  FillTable.Edit;
  FillTable.FieldByName('ClonePartID').AsInteger := LookupTable.FieldByName('PartsID').AsInteger;
end;

procedure TfrmImportPartsToParts.FormActivate(Sender: TObject);
begin
  inherited;
  if not Self.ErrorOccurred then begin
    if qryTempParts.Active then begin
      qryTempParts.Close;
      qryTempParts.Open;
    end;
  end;
end;



initialization
  RegisterClassOnce(TfrmImportPartsToParts);
end.
