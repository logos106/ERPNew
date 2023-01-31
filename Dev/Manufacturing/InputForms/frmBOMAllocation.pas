unit frmBOMAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, Shader, DNMPanel, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, BusObjSales, BusObjProcTreePart, DNMSpeedButton, Mask, wwdbedit, BusObjBase,
  wwdbdatetimepicker;

type
  TfmBOMAllocation = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QryTree: TERPQuery;
    QryTreesaleId: TIntegerField;
    QryTreeSalelineID: TIntegerField;
    QryTreeTransdate :TDateTimefield;
    QryTreeCaption: TWideStringField;
    QryTreepartType: TWideStringField;
    QryTreeFromStockQty: TFloatField;
    QryTreeManufactureQty: TFloatField;
    QryTreeOnOrderQty: TFloatField;
    QryTreeproctreeID: TIntegerField;
    QryTreeProctreePartID: TIntegerField;
    QryTreeSequencedown: TIntegerField;
    QryTreelevel: TIntegerField;
    QryTreeparentID: TIntegerField;
    QryTreeInQty: TFloatField;
    QryTreeoutQty: TFloatField;
    QryTreeManufacturingQty: TFloatField;
    QryTreeManufacturedQty: TFloatField;
    QryTreeSOQty: TFloatField;
    QryTreeDoneQty: TFloatField;
    QryTreeInPQAID: TIntegerField;
    QryTreeoutPQAID: TIntegerField;
    QryTreeSOPQAID: TIntegerField;
    grdTransactions: TwwDBGrid;
    dsTree: TDataSource;
    QryTreeManufactureUOMQty: TFloatField;
    QryTreeFromStockUOMQty: TFloatField;
    QryTreeOnOrderUOMQty: TFloatField;
    QryTreeuomdetail: TWideStringField;
    QryTreeStockQty: TFloatField;
    QryTreeuomStockQty: TFloatField;
    QryTreeLineCaption: TWideStringField;
    QryTreeuomid: TIntegerField;
    QryTreeuommult: TFloatField;
    QryTreeuom: TWideStringField;
    QryTreePQAallocation: TWideStringField;
    AdvPopupMenu1: TAdvPopupMenu;
    CopyAllocationFromtheReceivedOrder1: TMenuItem;
    QryTreeBatch: TWideStringField;
    QryTreeAllocated: TWideStringField;
    QryTreeUSebins: TWideStringField;
    QryTreeSNTRacking: TWideStringField;
    QryTreeID: TIntegerField;
    QryTreeProductId: TIntegerField;
    btncancel: TDNMSpeedButton;
    btnclose: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    tblMaster: TERPQuery;
    tblMasterSaleID: TAutoIncField;
    tblMasterGlobalRef: TWideStringField;
    tblMasterInvoiceDocNumber: TWideStringField;
    tblMasterOriginalNo: TWideStringField;
    tblMasterAccount: TWideStringField;
    tblMasterCustomerName: TWideStringField;
    tblMasterInvoiceTo: TWideStringField;
    tblMasterShipTo: TWideStringField;
    tblMasterSaleDate: TDateField;
    tblMasterTotalTax: TFloatField;
    tblMasterTotalAmount: TFloatField;
    tblMasterTotalAmountInc: TFloatField;
    tblMasterTotalMarkup: TFloatField;
    tblMasterTotalDiscount: TFloatField;
    tblMasterEmployeeName: TWideStringField;
    tblMasterClass: TWideStringField;
    tblMasterOrderNumber: TWideStringField;
    tblMasterPONumber: TWideStringField;
    tblMasterShipDate: TDateField;
    tblMasterDueDate: TDateField;
    tblMasterConNote: TWideStringField;
    tblMasterInvoicePrintDesc: TWideStringField;
    tblMasterPickMemo: TWideMemoField;
    tblMasterPrintHold: TWideStringField;
    tblMasterShipping: TWideStringField;
    tblMasterTerms: TWideStringField;
    tblMasterPayMethod: TWideStringField;
    tblMasterPayDueDate: TWideStringField;
    tblMasterPaid: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterPayment: TFloatField;
    tblMasterApplyFlag: TWideStringField;
    tblMasterAmountDue: TFloatField;
    tblMasterTimeOfSale: TWideStringField;
    tblMasterPOS: TWideStringField;
    tblMasterIsCashSale: TWideStringField;
    tblMasterIsInvoice: TWideStringField;
    tblMasterIsQuote: TWideStringField;
    tblMasterIsSalesOrder: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterCancelled: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterIsRefund: TWideStringField;
    tblMasterTotalQuoteAmount: TFloatField;
    tblMasterBOID: TWideStringField;
    tblMasterClassID: TIntegerField;
    tblMasterChequeNo: TWideStringField;
    tblMasterClientID: TIntegerField;
    tblMasterAccountID: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterIsLayby: TWideStringField;
    tblMasterLaybyID: TWideStringField;
    tblMasterIsPOS: TWideStringField;
    tblMasterDeposited: TWideStringField;
    tblMasterHoldSale: TWideStringField;
    tblMasterMemo: TWideMemoField;
    tblMasterComments: TWideMemoField;
    tblMasterEnteredBy: TWideStringField;
    tblMasterEnteredAt: TWideStringField;
    tblMasterSOBalance: TFloatField;
    tblMasterFreezeQuoteAmount: TWideStringField;
    tblMasterConverted: TWideStringField;
    tblMasterIsVoucher: TWideStringField;
    tblMasterIsLaybyTOS: TWideStringField;
    tblMasterIsLaybyPayment: TWideStringField;
    tblMasterTillID: TSmallintField;
    tblMasterCommissionPaid: TWideStringField;
    tblMasterPickupFrom: TWideStringField;
    tblMasterIsManifest: TWideStringField;
    tblMasterUsedOnManifest: TWideStringField;
    tblMasterAddToManifest: TWideStringField;
    tblMasterQuoteGlobalRef: TWideStringField;
    tblMasterSalesOrderGlobalRef: TWideStringField;
    tblMasterIsBarcodePicking: TWideStringField;
    tblMasterBarcodePickingDone: TWideStringField;
    tblMasterARNotes: TWideMemoField;
    tblMasterOriginalCreationDate: TDateField;
    tblMasterQuoteStatus: TWideStringField;
    tblMasterTotalWETTax: TFloatField;
    tblMasterTotalWEGTax: TFloatField;
    tblMasterLastUpdated: TDateTimeField;
    tblMasterRepairGlobalRef: TWideStringField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignTotalAmount: TFloatField;
    tblMasterForeignPaidAmount: TFloatField;
    tblMasterForeignBalanceAmount: TFloatField;
    tblMasterBaseNo: TWideStringField;
    tblMasterSaleDateTime: TDateTimeField;
    tblMasterContactID: TLargeintField;
    tblMasterContactName: TWideStringField;
    tblMasterRepairID: TLargeintField;
    tblMasterPOCreated: TWideStringField;
    tblMasterFutureSO: TWideStringField;
    tblMasterAutoSmartOrderRef: TWideStringField;
    tblMasterIsInternalOrder: TWideStringField;
    tblMasterNoOfBoxes: TLargeIntField;
    tblMasterContributionAmount: TFloatField;
    tblMasterSOProgressPaymentGlobalRef: TWideStringField;
    tblMasterSOProgressPaymentOriginalRef: TWideStringField;
    tblMasterShipToID: TIntegerField;
    tblMasterSalesCategory: TWideStringField;
    tblDetails: TERPQuery;
    tblDetailsPartBarcode: TWideStringField;
    tblDetailsProductName: TWideStringField;
    tblDetailsUnitofMeasureSaleLines: TWideStringField;
    tblDetailsUnitofMeasureQtySold: TFloatField;
    tblDetailsUnitofMeasureShipped: TFloatField;
    tblDetailsUnitofMeasureBackorder: TFloatField;
    tblDetailsAttrib1Sale: TFloatField;
    tblDetailsAttrib2Sale: TFloatField;
    tblDetailsAttrib1SaleRate: TFloatField;
    tblDetailsSpecDescription: TWideStringField;
    tblDetailsSpecValue: TFloatField;
    tblDetailsProduct_Description: TWideStringField;
    tblDetailsProduct_Description_Memo: TWideMemoField;
    tblDetailsLineCostInc: TFloatField;
    tblDetailsLinePriceInc: TFloatField;
    tblDetailsWarrantyEndsOn: TDateField;
    tblDetailsWarrantyPeriod: TWideStringField;
    tblDetailsDiscounts: TFloatField;
    tblDetailsForeignCurrencyLinePrice: TFloatField;
    tblDetailsLineTaxCode: TWideStringField;
    tblDetailsLineTax: TFloatField;
    tblDetailsTotalLineAmountInc: TFloatField;
    tblDetailsSupplier: TWideStringField;
    tblDetailsSupplierContact: TWideStringField;
    tblDetailsSalesLinesCustField1: TWideStringField;
    tblDetailsDocketNumber: TWideStringField;
    tblDetailsSalesLinesCustField2: TWideStringField;
    tblDetailsSalesLinesCustField3: TWideStringField;
    tblDetailsSalesLinesCustField4: TWideStringField;
    tblDetailsSalesLinesCustField5: TWideStringField;
    tblDetailsSalesLinesCustField6: TWideStringField;
    tblDetailsSalesLinesCustField7: TWideStringField;
    tblDetailsSalesLinesCustField10: TWideStringField;
    tblDetailsShipDate: TDateTimeField;
    tblDetailsBaseLineno: TIntegerField;
    tblDetailsAutoSmartOrder: TWideStringField;
    tblDetailsSmartOrderCreated: TWideStringField;
    tblDetailsSalesLinesCustField9: TWideStringField;
    tblDetailsMemoLine: TWideMemoField;
    tblDetailsSalesLinesCustField8: TWideStringField;
    tblDetailsTimecostused: TWideStringField;
    tblDetailsProgresspaymentRef: TWideStringField;
    tblDetailsForeignExchangeSellCode: TWideStringField;
    tblDetailsLineCost: TFloatField;
    tblDetailsShipped: TFloatField;
    tblDetailsBackOrder: TFloatField;
    tblDetailsOrgLinePrice: TFloatField;
    tblDetailsLinePrice: TFloatField;
    tblDetailsSaleID: TIntegerField;
    tblDetailsSaleLineID: TAutoIncField;
    tblDetailsSeqNo: TIntegerField;
    tblDetailsSortId: TIntegerField;
    tblDetailsMatrixDesc: TWideMemoField;
    tblDetailsTotalLineAmount: TFloatField;
    tblDetailsQtySold: TFloatField;
    tblDetailsMatrixPrice: TFloatField;
    tblDetailsFormulaQtySoldValue1: TFloatField;
    tblDetailsFormulaQtySoldValue2: TFloatField;
    tblDetailsFormulaQtySoldValue3: TFloatField;
    tblDetailsFormulaQtySoldValue4: TFloatField;
    tblDetailsFormulaQtySoldValue5: TFloatField;
    tblDetailsFormulaQtyShippedValue1: TFloatField;
    tblDetailsFormulaQtyShippedValue2: TFloatField;
    tblDetailsFormulaQtyShippedValue3: TFloatField;
    tblDetailsFormulaQtyShippedValue4: TFloatField;
    tblDetailsFormulaQtyShippedValue5: TFloatField;
    tblDetailsFormulaQtySoldValue: TFloatField;
    tblDetailsFormulaQtyShippedValue: TFloatField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsProductGroup: TWideStringField;
    tblDetailsLineWholesalePrice: TFloatField;
    tblDetailsLineTaxRate: TFloatField;
    tblDetailsInvoiced: TWideStringField;
    tblDetailsMarkup: TFloatField;
    tblDetailsMarkupPercent: TFloatField;
    tblDetailsDiscountPercent: TFloatField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsDeleted: TWideStringField;
    tblDetailsProductID: TIntegerField;
    tblDetailsPartType: TWideStringField;
    tblDetailsRefundQty: TFloatField;
    tblDetailsLaybyID: TWideStringField;
    tblDetailsIncomeAccnt: TWideStringField;
    tblDetailsAssetAccnt: TWideStringField;
    tblDetailsCogsAccnt: TWideStringField;
    tblDetailsLastLineID: TIntegerField;
    tblDetailsUnitofMeasureMultiplier: TFloatField;
    tblDetailsForeignExchangeSellRate: TFloatField;
    tblDetailsForeignTotalLineAmount: TFloatField;
    tblDetailsArea: TWideStringField;
    tblDetailsSearchFilter: TWideStringField;
    tblDetailsSearchFilterCopy: TWideStringField;
    tblDetailsIsRelatedProduct: TWideStringField;
    tblDetailsRelatedParentProductID: TIntegerField;
    tblDetailsCostCentreId: TIntegerField;
    tblDetailsUseHedging: TWideStringField;
    tblDetailsPartSpecID: TIntegerField;
    tblDetailsCreationDate: TDateTimeField;
    tblDetailsSoldSerials: TWideMemoField;
    tblDetailsLineNotes: TWideMemoField;
    tblDetailsCustomData: TWideMemoField;
    tblDetailsUnitOfMeasureID: TIntegerField;
    tblDetailsRelatedParentLineRef: TWideStringField;
    tblDetailsRelatedProductQty: TFloatField;
    tblDetailsIsFormulaRElatedProduct: TWideStringField;
    tblDetailsFormulaID: TIntegerField;
    tblDetailsMatrixRef: TWideMemoField;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsmsUpdateSiteCode: TWideStringField;
    tblDetailsAttrib1SaleEst: TFloatField;
    tblDetailsAttrib2SaleEst: TFloatField;
    tblDetailsLastUpdated: TDateTimeField;
    tblDetailsIsQuote: TWideStringField;
    tblDetailsTreeFinalized: TWideStringField;
    tblDetailsBOMGroupedLine: TWideStringField;
    tblDetailsBOMProductionLine: TWideStringField;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    popMain: TAdvPopupMenu;
    mnuAutoAllocate: TMenuItem;
    btnAutoAllocate: TDNMSpeedButton;
    dtTransDate: TwwDBDateTimePicker;
    mnuUpdatewithcurTime: TMenuItem;
    btnPrint: TDNMSpeedButton;
    Label13: TLabel;
    edtBatch: TEdit;
    Bevel1: TBevel;
    lblMsg: TLabel;
    btnFinishedGoodLabel: TDNMSpeedButton;
    ChkChooseRpt: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdTransactionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure popMainPopup(Sender: TObject);
    procedure mnuAutoAllocateClick(Sender: TObject);
    procedure btnAutoAllocateClick(Sender: TObject);
    procedure QryTreeTransdateChange(Sender: TField);
    procedure mnuUpdatewithcurTimeClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure wwDBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure btnFinishedGoodLabelClick(Sender: TObject);
    procedure QryTreeBeforeOpen(DataSet: TDataSet);
  private
    fiSaleLineID: Integer;
    tablename :string;
    SO:TSalesOrder;
    fiSaleID: Integer;
    Allocating :Boolean;
    fsFGReportSQL:String;
    fsFGReportSelectedIds:String;

    Procedure MakeTable;
    procedure Showallocationform;
    function getSalesOrder :TsaleSOrder;
    function ProcTreePartofRec :TProcTreePart;
    procedure DobusobjEvent(const Sender: TDatasetBusObj; const EventType,      Value: string);
    function ValidateData:Boolean;
    function SAveData :Boolean ;
    function IsfullyAllocated: boolean;
    {$HINTS OFF}
    procedure SelectFromPurchaseAllocation(Sender: twwDBGrid);Overload;
    {$HINTS ON}
    procedure showBOMPurchaseAllocation(Sender: TObject);
    procedure PrintAllocation;
    procedure BeginChanges;
    procedure commitChanges;
    Procedure RollbackChanges;
    procedure SelectEntriesForfinishedGoodsPrint;
    procedure OnSelectEntriesForfinishedGoodsPrint(Sender: TwwDbGrid);
    procedure BeforeShowList(Sender: TObject);
  Protected
    function GetReportTypeID: integer; Override;

  public
    Property SaleLineID:Integer read fiSaleLineID write fiSaleLineID;
    Property SaleID:Integer read fiSaleID write fiSaleID;
    class Procedure DoAllocation (fiHeaderId, fiLineID:Integer; fSO:TSalesOrder);
    Procedure SelectfromPurchaseAllocation(fSQL:String);Overload;
    Property SalesOrder :TSalesOrder read getSalesOrder write SO;
  end;


implementation

uses CommonDbLib, CommonLib, frmAllocation, BusObjProcess, BusObjConst,
  AppEnvironment, busobjPQA, CommonFormLib, BOMPurchaseAllocation, tcConst,
   ManufactureLib, tcDataUtils, DbSharedObjectsObj, ProductQtyLib, PQALib,
  BatchBarcodeObj, TemplateReportsLib, saleslib, LogLib, BaseListingForm,
  GridLib, BOMSalesProgressReport;

{$R *.dfm}

procedure TfmBOMAllocation.BeginChanges;
begin
  if Assigned(SalesOrder) and  (SO.owner <> Self) then begin
      SO.Connection.BeginNestedTransaction;
      Exit;
  end;
  BeginTransaction;
end;

procedure TfmBOMAllocation.btnAutoAllocateClick(Sender: TObject);
var
  s1, s2:String;
begin
  inherited;
  if MessageDlgXP_Vista('This will delete all current allocation and copy the Available allocation from its received Orders. Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  s1 := TBOMPurchaseAllocationGUI.ListSQL;
  QryTree.first;
  showProgressbar(WAITMSG ,QryTree.recordcount);
  try
    While QryTree.eof = False do begin
      if (QryTreeOnOrderQty.AsFloat >0) and
                          ((Qrytreebatch.asboolean =true) OR
                           (QrytreeUsebins.asboolean =true) OR
                           (QrytreeSNTracking.asboolean =true)) then begin

          s2:= replacestr(s1, ':proctreeID' , inttostr(QryTreeProctreeId.asInteger) );
          SelectfromPurchaseAllocation(s2);
      end;
      QryTree.next;
      StepProgressbar;
    end;
  finally
    HideProgressbar;
  end;

end;

procedure TfmBOMAllocation.btncancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmBOMAllocation.btncloseClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  commitChanges;
  SalesOrder.dirty := False;
  Self.close;
end;

procedure TfmBOMAllocation.btnPrintClick(Sender: TObject);
var
  msgOption :Word;
begin
  inherited;

  msgOption := MessageDlgXP_Vista('This will Save the current allocation and print. Do you like to continue?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if msgOption  = mrCancel then exit
  else if msgOption  = mryes then begin
    if not SaveData then exit;
    commitChanges;
    SalesOrder.dirty := False;
    Printallocation;
    Self.close;
  end;

end;
procedure TfmBOMAllocation.commitChanges;
begin
  if Assigned(SalesOrder) and  (SO.owner <> Self) then begin
      SO.Connection.CommitNestedTransaction;
      Exit;
  end;
  CommitTransaction;
end;

Procedure TfmBOMAllocation.PrintAllocation;
var
  strSQL:String;
  ReportTablename :String;
begin
  inherited;
  ReportTablename := GetUserTemporaryTableName('printBOMPickingslip');
  MakeBOMPickingTable(inttostr(SaleLineID), ReportTablename);

  strSQL:= companyInfoSQL('CompanyInfo') +
            ' ~|||~{details}Select * from '+ReportTablename +' order by SeqID ';

  ReportToPrint :=tcdatautils.GetDefaultReport(GetReportTypeIDForTypeName('BOM Picking Slip'));
  if ReportToPrint = '' then ReportToPrint := 'BOM Picking Slip';
  fbReportSQLSupplied := True;
  PrintTemplateReport(ReportToPrint , StrSQL , False , 1);
  DestroyUserTemporaryTable(ReportTablename);
end;
procedure TfmBOMAllocation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmBOMAllocation.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose:= false;
  if SalesOrder.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes,mbNo,mbCancel], 0) of
      mrYes   : begin       if not SaveData then exit; commitChanges; canclose := true; end;
      mrNo    : begin      RollbackChanges;canclose := true; end;
      mrCancel:   CanClose:= false;
    end;
  end else begin
   RollbackChanges;canclose := true;
  end;
  if not CanClose then
    BeginChanges;
end;

procedure TfmBOMAllocation.FormCreate(Sender: TObject);
begin
  SO := nil;
  inherited;
  Allocating:= False;
  tablename := commondblib.GetUserTemporaryTableName('BOMAllocation');
  QryTree.SQL.text :='Select * from ' + tablename +' where nodeSelected = "T"';
  SalelineID := 0;
  SaleID := 0;
  ShowControlhint(edtBatch , 'These Batch-Product Barcodes can be printed from '+NL+
                             ' -> Purchase Order : Right Click on the line and Choose "Print Barcode" (Template type : Batch Barcode(PO) )'+NL+
                             ' -> ' + Quotedstr(AppEnv.AccessLevels.GetFormDescription('TProductBatchesGUI'))+' : "Batch Barcodes" - (Template type : Batch Barcode).'+NL+NL+
                              'Please note that these barcodes are different from the Product Barcode.' +NL);
end;

procedure TfmBOMAllocation.FormShow(Sender: TObject);
begin
  inherited;
  Userlock.enabled := True;
  if Assigned(SalesOrder) and (So.owner = self) then
    if (not(Userlock.Lock('tblsales' ,saleID , Self.Caption))) then begin
      MessageDlgXP_Vista(replaceStr(Userlock.lockMessage , 'Unable to update data.' , 'Unable to do ''Bin / Batch / Serial No'' Allocation for Sales Order #' + inttostr(saleID ) +'.'), mtWarning, [mbOK], 0);
      Accesslevel := 5;
      Self.caption := TitleLabel.caption +'   (Read Only)';
      btnclose.enabled := False;
      btnAutoAllocate.enabled := False;
    end;
  MakeTable;
  BeginChanges;
end;

function TfmBOMAllocation.GetReportTypeID: integer;
begin
  REsult := TemplateTypeID('Finished Good Label');
end;

procedure TfmBOMAllocation.grdTransactionsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  aProcTreePartofRec :TProcTreePart;
begin
  inherited;
  if Allocating then exit;
  if not sametext(QryTreepartType.asString, 'INV') and
      (Field is TFloatfield) then begin
      Afont.Color := Abrush.Color;
  end else if (Sametext(Field.Fieldname , QryTreeManufactureUOMQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeFromStockUOMQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeOnOrderUOMQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeInQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeoutQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeManufacturedQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeManufacturingQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeSOQty.FieldName) or
     Sametext(Field.Fieldname , QryTreeDoneQty.FieldName) ) and
     (field.AsFloat =0) then begin
      Afont.Color := Abrush.Color;
  end else if (Qrytreebatch.asboolean =False) and
     (QrytreeUsebins.asboolean =False) and
     (QrytreeSNTracking.asboolean =False) then begin
      AFont.color := clGray;
  end else begin
  try
    aProcTreePartofRec := ProcTreePartofRec;
    if Sametext(Field.FieldName ,'PQAallocation') then
      if (QryTreeProductId.asInteger > 0) and (QryTreebatch.asboolean or QryTreeusebins.asBoolean or QryTreeSNtracking.asBoolean) and
        Assigned(aProcTreePartofRec) then
        With aProcTreePartofRec do begin
               if (Appenv.CompanyPrefs.IndicateifBatchAllocated) and (PQABatches.Count  > 0)  then ABrush.Color := Appenv.CompanyPrefs.BatchAllocationColour
          else if (Appenv.CompanyPrefs.IndicateifBinAllocated  ) and (PQABins.Count     > 0)  then ABrush.Color := Appenv.CompanyPrefs.BinAllocationColour
          else if (Appenv.CompanyPrefs.IndicateifSNAllocated   ) and (PQASNs.Count      > 0)  then ABrush.Color := Appenv.CompanyPrefs.SNAllocationColour;
        end;
  Except
    // kill the exception if not PQAitem
  end;
  end;
end;
procedure TfmBOMAllocation.BeforeShowList(Sender: TObject);
begin
  if sender is TBOMSalesProgressReportGUI then begin
    TBOMSalesProgressReportGUI(Sender).SaleLineId :=QryTreeSalelineID.asInteger;
    TBOMSalesProgressReportGUI(Sender).ProctreeId :=QryTreeproctreeID.asInteger;
  end;
end;
procedure TfmBOMAllocation.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
       if   sametext(ActiveFieldName(grdTransactions) , QryTreePQAallocation.fieldname) then begin
            Showallocationform;
  end else if ( sametext(ActiveFieldName(grdTransactions) , QryTreeOutQty.fieldname) or
            sametext(ActiveFieldName(grdTransactions) , QryTreeinQty.fieldname)  or
             sametext(ActiveFieldName(grdTransactions) , QryTreeManufacturedQty.fieldname) or
             sametext(ActiveFieldName(grdTransactions) , QryTreeManufacturingQty.fieldname) or
            sametext(ActiveFieldName(grdTransactions) , QryTreeDoneQty.fieldname)) and
          ( (QryTreeOutQty.asFloat      <> 0) OR
            (QryTreeinQty.asfloat       <> 0) OR
            (QryTreeManufacturedQty.asFloat      <> 0) OR
            (QryTreeManufacturingQty.asFloat      <> 0) OR
            ((QryTreeDoneQty.asFloat <> 0) and  (QryTreeDoneQty.asFloat<> QryTreeManufactureuomqty.asFloat)))  then OpenERPListFormModal('TBOMSalesProgressReportGUI' , nil, BeforeShowList);
end;

procedure TfmBOMAllocation.grdTransactionsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Showallocationform;
end;

procedure TfmBOMAllocation.MakeTable;
var
  s:String;
  TempFile:String;
begin
  Qrytree.DisableControls;
  try
    closeDB(Qrytree);
    try
      TempFile := GetTemporaryFileName(Self.ClassName );
      With tempmyscript do try
        SQL.add('Drop table if exists ' + tablename +';');
        SQL.add('CREATE TABLE ' + tablename +' (');
        SQL.add(' ID                INT(11)       NOT NULL AUTO_INCREMENT,');
        SQL.add('	SaleID            INT(11)       NULL DEFAULT 0,');
        SQL.add('	SalelineID        INT(11)       NULL DEFAULT 0,');
        SQL.add('	Transdate         DateTime      NULL DEFAULT NULL,');
        SQL.add('	ParentID          INT(11)       NULL DEFAULT 0,');
        SQL.add('	ProctreeID        INT(11)       NULL DEFAULT 0,');
        SQL.add('	ProctreePartID    INT(11)       NULL DEFAULT 0,');
        SQL.add('	ProductID         INT(11)       NULL DEFAULT 0,');
        SQL.add('	partType          VARCHAR(20)   NULL DEFAULT "",');
        SQL.add('	Sequencedown      INT(11)       NULL DEFAULT 0,');
        SQL.add('	Level             INT(11)       NULL DEFAULT 0,');
        SQL.add('	Caption           VARCHAR(255)  NULL DEFAULT "",');
        SQL.add('	LineCaption       VARCHAR(255)  NULL DEFAULT "",');
        SQL.add('	FromStockQty      DOUBLE        NULL DEFAULT 0,');
        SQL.add('	ManufactureQty    DOUBLE        NULL DEFAULT 0,');
        SQL.add('	OnOrderQty        DOUBLE        NULL DEFAULT 0,');
        SQL.add('	StockQty          DOUBLE        NULL DEFAULT 0,');
        SQL.add('	OutPQAID          INT(11)       NULL DEFAULT 0,');
        SQL.add('	OutQty            DOUBLE        NULL DEFAULT 0,');
        SQL.add('	InPQAID           INT(11)       NULL DEFAULT 0,');
        SQL.add('	InQty             DOUBLE        NULL DEFAULT 0,');
        SQL.add('	SOPQAID           INT(11)       NULL DEFAULT 0,');
        SQL.add('	SOQty             DOUBLE        NULL DEFAULT 0,');
        SQL.add('	DoneQty           DOUBLE        NULL DEFAULT 0,');
        SQL.add('	uomid             INT(11)       NULL DEFAULT 0,');
        SQL.add('	uommult           DOUBLE        NULL DEFAULT 0,');
        SQL.add('	uom               VARCHAR(100)  NULL DEFAULT "", ');
        SQL.add('	uomDetail         VARCHAR(150)  NULL DEFAULT "", ');
        SQL.add('	ManufactureUOMQty DOUBLE        NULL DEFAULT 0,');
        SQL.add('	FromStockUOMQty   DOUBLE        NULL DEFAULT 0,');
        SQL.add('	OnOrderUOMQty     DOUBLE        NULL DEFAULT 0, ');
        SQL.add('	uomStockQty       DOUBLE        NULL DEFAULT 0,');
        SQL.add('	PQAallocation     VARCHAR(1)    NULL DEFAULT "+", ');
        SQL.add('	inputType         VARCHAR(30)   NULL DEFAULT "+", ');
        SQL.add('	selected          ENUM("T","F")      DEFAULT "F", ');
        SQL.add('	nodeselected      ENUM("T","F")      DEFAULT "F", ');
        SQL.add('	Allocated         ENUM("T","F")      DEFAULT "F", ');
        SQL.add('	Batch             ENUM("T","F")      DEFAULT "F", ');
        SQL.add('	USebins           ENUM("T","F")      DEFAULT "F", ');
        SQL.add('	SNTRacking        ENUM("T","F")      DEFAULT "F", ');
        SQL.add('	ManufacturedQty   DOUBLE        NULL DEFAULT 0,');
        SQL.add('	ManufacturingQty  DOUBLE        NULL DEFAULT 0,');
        SQL.add('	PRIMARY KEY (ID)');
        SQL.add(')');
        SQL.add('COLLATE="utf8_general_ci"');
        SQL.add('ENGINE=MyISAM;');
        clog(SQL.text);
        Execute;
        SQL.clear;
        Connection := SalesOrder.Connection.Connection;

        (*SQL.add('insert into ' +tablename +' (saleId, SalelineID, Caption, LineCaption,  ' +
                  ' FromStockQty, ManufactureQty, OnOrderQty , ' +
                  ' proctreeID ,ProductID , Sequencedown, level, parentID, ' +
                  ' uomid, uommult, uom , uomDetail , ' +
                  ' ManufactureUOMQty , FromStockUOMQty , OnOrderUOMQty, selected , inputType)' +
                  ' Select SL.saleId, SL.SalelineID, PT.Caption, ' +
                  ' Convert(TreeNodeCaption(Level, caption ) , char(255)) as Linecaption, ' +
                  ' PT.FromStockQty, PT.ManufactureQty, PT.OnOrderQty , PT.proctreeID , PT.partsID, PT.Sequencedown, PT.level,PT.parentID , ' +
                  ' PT.treepartuomid , PT.treepartuommultiplier , PT.treepartuom , ' +
                  ' concat(PT.treepartuom  , " (" , PT.treepartuommultiplier , ")") as uomdetail, ' +
                  ' PT.ManufactureUOMQty , PT.FromStockUOMQty , Pt.OnOrderUOMQty, PT.Selected , PT.inputType'+
                  ' from tblsaleslines SL' +
                  ' inner join tblProctree PT on SL.SaleLineID = PT.masterId and PT.mastertype <> "mtProduct"' +
                  ' where SL.SaleLineID = '+ inttostr(SaleLineID) +';');*)
(*        SQL.add('LOAD DATA INFILE  "'+ TempFile +'" '+
                'INTO TABLE ' + tablename +' CHARACTER SET  UTF8 '     +
                '('+'saleId, SalelineID, Caption, LineCaption,  ' +
                  ' FromStockQty, ManufactureQty, OnOrderQty , ' +
                  ' proctreeID ,ProductID , Sequencedown, level, parentID, ' +
                  ' uomid, uommult, uom , uomDetail , ' +
                  ' ManufactureUOMQty , FromStockUOMQty , OnOrderUOMQty, selected , inputType' +');');*)
        SQL.Add(CreateTemporaryTableusingfile(Tablename ,
                  'Select SL.saleId, SL.SalelineID, PT.Caption, ' +
                                ' Convert(TreeNodeCaption(Level, caption ),char(255)) as Linecaption, ' +
                                ' PT.FromStockQty, PT.ManufactureQty, PT.OnOrderQty , PT.proctreeID , PT.partsID, PT.Sequencedown, PT.level,PT.parentID , ' +
                                ' PT.treepartuomid , PT.treepartuommultiplier , PT.treepartuom , ' +
                                ' concat(PT.treepartuom  , " (" , PT.treepartuommultiplier , ")") as uomdetail, ' +
                                ' PT.ManufactureUOMQty , PT.FromStockUOMQty , Pt.OnOrderUOMQty, PT.Selected , PT.inputType, 	PT.ManufacturedQty ,	PT.ManufacturingQty '+
                                ' from tblsaleslines SL' +
                                ' inner join tblProctree PT on SL.SaleLineID = PT.masterId and PT.mastertype <> "mtProduct"' +
                                ' where SL.SaleLineID = '+ inttostr(SaleLineID) ,
                    'saleId, SalelineID, Caption, LineCaption,FromStockQty, ManufactureQty, OnOrderQty , ' +
                                ' proctreeID ,ProductID , Sequencedown, level, parentID, ' +
                                ' uomid, uommult, uom , uomDetail , ' +
                                ' ManufactureUOMQty , FromStockUOMQty , OnOrderUOMQty, selected , inputType, 	ManufacturedQty ,	ManufacturingQty ',
                    Tablename , TempFile ));

        SQL.add('update ' +tablename +'  T Set StockQty = FromStockQty +OnOrderQty ;' );
        SQL.add('update ' +tablename +'  T Set uomStockQty = FromStockUOMQty +OnOrderUOMQty ;' );
        SQL.add('update ' +tablename +'  T ' +
                  ' inner join `tblproctreepart`        AS PTP  on PTP.proctreeID = T.proctreeID  ' +
                  ' Set T.ProctreePartID = PTP.ProctreePartID;') ;
        SQL.add('update ' +tablename +'  T ' +
                  ' inner join `tblproctreepart`        AS PTP  on PTP.proctreeID = T.proctreeID  ' +
                  //' inner join tblpqa PQA on PTP.ProcTreePartId = PQA.TransLineID           and PQA.TRanstype = "TProcTreePart"  and PQA.Alloctype ="OUT" ' +
                  ' inner join tblpqa PQA on PTP.ProcTreePartId = PQA.TransLineID           and PQA.TRanstype = "TProcTreePart"  ' +
                  ' Set T.outQty = PQa.UOMQty , T.OutPQAID = PQA.PQAID , T.Transdate = PQA.transdate;') ;
        //SQL.add('update ' +tablename +'  T  Set outQty = round(outQty,5);');

        SQL.add('update ' +tablename +'  T ' +
                  ' inner join `tblproctreepart`        AS PTP  on PTP.proctreeID = T.proctreeID  ' +
                  //' inner join tblpqa PQA on PTP.ProcTreePartId = PQA.TransLineID           and PQA.TRanstype in ( "TProcTreePart" , "TProcTreePartIN" ,  "TProcTreePartINDONE" ) and PQA.Alloctype ="IN" ' +
                  ' inner join tblpqa PQA on PTP.ProcTreePartId = PQA.TransLineID           and PQA.TRanstype in ( "TProcTreePartIN" ,  "TProcTreePartINDONE" ) ' +
                  ' Set T.InQty = PQa.UOMQty , T.inPQAID = PQA.PQAID, T.Transdate = PQA.transdate;');
        //SQL.add('update ' +tablename +'  T  Set InQty = round(InQty,5);');

        SQL.add('update ' +tablename +'  T ' +
                  ' inner join tblpqa PQA on PQA.TRanstype = "TSalesorderLine"  and PQA.transId = T.saleID and PQA.translineId = T.saleLineID  and T.parentID=0  ' +
                  ' Set T.SOQty = PQa.UOMQty , T.SOPQAID = PQA.PQAID , T.Transdate = PQA.transdate;');
        //SQL.add('update ' +tablename +'  T  Set SOQty = round(SOQty,5);');

        SQL.add('update ' +tablename +'  T  Set DoneQty = ManufactureUOMQty - INQty where ifnull(ManufactureUOMQty,0)<> 0;' );
        SQL.add('update ' +tablename +'  T  Set DoneQty = (FromStockUOMQty+ onorderuomqty) - OutQty where ifnull(ManufactureUOMQty,0)= 0;' );
        //SQL.add('update ' +tablename +'  T  Set DoneQty = round(DoneQty,5);');


        SQL.add('update ' + tablename +'   T  ' +
                  ' inner join tblparts P on P.partsId = T.ProductId ' +
                  ' Set T.PartType = P.partType, ' +
                  ' T.batch = P.batch , ' +
                  ' T.usebins = P.MultipleBins , ' +
                  ' T.snTracking = P.SNTracking;');

        logtext(SQL.text);
        Execute;
      finally
        Free;
      end;
      ChecknUpdateInTreeNodesSelected(Tablename  , 'nodeselected', TERPConnection(SalesOrder.Connection.Connection));
      With tempMyquery(TERPConnection(SalesOrder.Connection.Connection)) do try
        SQL.text := 'Select ID from ' +tablename +'  where ifnull(fromstockQty,0)=0 and ifnull(OnOrderQty,0)=0 and proctreeId not in (Select parentId from ' +tablename +' )';
        open;
        s:= Groupconcat('ID');
        close;
        if s<> '' then begin
          SQL.text := 'update ' +tablename +' set  nodeselected ="F" where Id in (' + s + ')';
          execute;
        end;
      finally
        closenFree;
      end;
    finally
      opendb(Qrytree);
      AppEnv.UtilsClient.DeleteServerFile(TempFile);
    end;
  finally
    Qrytree.EnableControls;
  end;
end;
function TfmBOMAllocation.IsfullyAllocated:boolean;
var
  fbsilentMode:Boolean;
begin
  Result:= true;
  if (Qrytreebatch.asboolean =False) and (QrytreeUsebins.asboolean =False) and (QrytreeSNTracking.asboolean =False) then exit;

  With ProcTreePartofRec.PQA do begin
    fbsilentMode:=silentMode;
    silentMode:= True;
    try
      if not ValidateAllocation or (Warnmsg <> '') or (Errmsg <> '' ) then begin
        REsult := False;
        Exit;
      end;
      if Qty - TotalAllocated <> 0 then begin
        REsult := False;
        Exit;
      end;
    finally
      silentMode:= fbSilentMode;
    end;
  end;
end;
procedure TfmBOMAllocation.showBOMPurchaseAllocation(Sender: TObject);
begin
     if not (Sender is TBOMPurchaseAllocationGUI) then exit;
     TBOMPurchaseAllocationGUI(Sender).ProctreeId := QryTreeproctreeID.AsInteger;
end;
procedure TfmBOMAllocation.SelectFromPurchaseAllocation(Sender: twwDBGrid);
var
  s1, s2:String;
begin
  if not(Sender.Owner  is TBOMPurchaseAllocationGUI) then exit;
  s2:= TBOMPurchaseAllocationGUI(Sender.Owner).SelectedIDs('PQADetailID' , true);
  if s2 = '' then exit;

  if MessageDlgXP_Vista('This will delete all current allocation and copy the Available allocation from its received Orders. Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  s1:= TERPQuery(Sender.DataSource.DataSet).SQL.Text;
  s1:= replaceStr(s1 , ':ProctreeID' , inttostr(TERPQuery(Sender.DataSource.DataSet).parambyname('ProctreeID').AsInteger));
  SelectfromPurchaseAllocation('Select * from (' + s1 +') as Data where PQADetailID in (' +s2 +')');
end;
Procedure TfmBOMAllocation.SelectfromPurchaseAllocation(fSQL:String);
var
  fPQA:TPQA;
  batchref, binref:String;
  fdQty :Double;
  fdTotalAllocated:double;


  function addBatch(Batch:TPQABatch; batchno:String; expirydate:TDateTime):String;
  begin
    if not BAtch.Locate('Value;ExpiryDate' , vararrayof([batchno,ExpiryDAte]), []) then
      if (ExpiryDAte <> 0) or not (BAtch.Locate('Value;ExpiryDate' , vararrayof([batchno,NULL]), [])) then begin
            BAtch.New;
            BAtch.Batchno := batchno;
            if ExpiryDAte <> 0 then BAtch.ExpiryDate :=ExpiryDAte;
            BAtch.PostDB;
      end;
    result := BAtch.globalref;
  end;
  function Addbin(bins:TPQABins; parentREf:String; binID:Integer):String;
  begin
    if not bins.Locate('ParentREf;binId' , VarArrayof([parentREf, binID]), []) then begin
      bins.New;
      bins.ParentRef := parentRef;
      bins.BinID := binID;
      bins.PostDb;
    end;
    result:= bins.GlobalRef;
  end;
  function AddSn(SNs:TPQASN; Parentref:String; SN:String):boolean;
  begin
    REsult:= False;
    if not Sns.Locate('ParentREf;Value' , Vararrayof([parentref, sn]) , []) then begin
      Sns.New;
      sns.ParentRef := parentRef;
      SNs.SerialNumber := SN;
      Sns.PostDb;
      REsult:= True;
    end;
  end;
  Procedure AddQty(PQADetails :TPQADetails ; Qty:Double);
  begin
    if PQADetails is TPQASN then PQADetails.UOMQty := Qty
    else PQADetails.UOMQty := PQADetails.UOMQty + Qty;
    PQADetails.PostDb;
  end;
begin
  with ProcTreePartofRec do if IsSubNodeParent then fPQA:= SubNodeManufcaturePQA else fPQA:= PQa;

  with fPQA do
         if Product.Batch         then PQABatch.Deleteall
    else if Product.Multiplebins  then PQABins.Deleteall
    else if Product.SnTracking    then PQASN.Deleteall;

  with tempMyquery(TERPConnection(SalesOrder.Connection.Connection)) do try
    SQL.Text := fSQL;
    open;
    if recordcount =0 then exit;
    first;
    fdTotalAllocated := fpqa.TotalAllocated;
    while (eof = False) and (fPQa.Qty - fdTotalAllocated<>0) do begin
      if Fieldbyname('Pqatype').asString = fieldByname('ProductType').aSString then begin
        fdQty := fPQa.Qty - fdTotalAllocated;
        if fieldbyname('batchno').AsString <> '' then begin{===============================================================Batch}
            batchref := Addbatch(fPQA.PQABatch, fieldbyname('batchno').AsString , fieldbyname('expirydate').AsDateTime);
            if Fieldbyname('binlocation').AsString <> '' then begin{=======================================================batch - bin }
                binref := Addbin(fPQA.PQABatch.PQABins , batchref, fieldByname('binID').AsInteger);
                if fieldByname('Serialno').AsString <> '' then begin{======================================================batch - bin - sn}
                    if Addsn(fPQA.PQABatch.PQABins.PQASN , binref,fieldbyname('Serialno').AsString) then begin
                        fdQty := 1;
                        AddQty(fPQA.PQABatch.PQABins.PQASN , fdQty);
                        AddQty(fPQA.PQABatch.PQABins , fdQty);
                        AddQty(fPQA.PQABatch , fdQty);
                    end else fdQty := 0;
                end else begin{============================================================================================batch - bin - nosn}
                    if fdQty > fieldbyname('uombinqty').AsFloat then fdQty := fieldbyname('uombinqty').AsFloat;
                    AddQty(fPQA.PQABatch.PQABins , fdQty);
                    AddQty(fPQA.PQABatch , fdQty);
                end;
            end else if fieldByname('Serialno').AsString <> '' then begin{=================================================batch - sn}
                if Addsn(fPQA.PQABatch.PQASN ,batchref,  fieldbyname('Serialno').AsString) then begin
                    fdQty := 1;
                    AddQty(fPQA.PQABatch.PQASN , fdQty);
                    AddQty(fPQA.PQABatch , fdQty);
                end else fdQty := 0;
            end else begin{================================================================================================batch}
                if fdQty > fieldbyname('uombatchqty').AsFloat then fdQty := fieldbyname('uombatchqty').AsFloat;
                AddQty(fPQA.PQABatch , fdQty);
            end;
        end else if Fieldbyname('binlocation').AsString <> '' then begin{==================================================bin}
            binref := Addbin(fPQA.PQABins ,'', fieldByname('binID').AsInteger);
            if fieldByname('Serialno').AsString <> '' then begin{==========================================================bin - sn}
                if Addsn(fPQA.PQABins.PQASN , binref , fieldbyname('Serialno').AsString) then begin
                    fdQty := 1;
                    AddQty(fPQA.PQABins.PQASN , fdQty);
                    AddQty(fPQA.PQABins , fdQty);
                end else fdQty := 0;
            end else begin
                if fdQty > fieldbyname('uombinqty').AsFloat then fdQty := fieldbyname('uombinqty').AsFloat;
                AddQty(fPQA.PQABins , fdQty);
            end;
        end else if fieldByname('Serialno').AsString <> '' then begin{===================================================-sn}
            if Addsn(fPQA.PQASN , '',fieldbyname('Serialno').AsString) then begin
              fdQty := 1;
              AddQty(fPQA.PQASN , fdQty);
            end else fdQty := 0;
        end;
        if fdQty <> 0 then begin
          if fPQa.TransDate < now then begin
            fPQa.TransDate := now;
            fPQa.PostDB;
          end;
        end;
        fdTotalAllocated := fdTotalAllocated + fdQty;
      end;
      Next;
    end;
  finally
    if active then close;
    Free;
  end;
end;

procedure TfmBOMAllocation.mnuAutoAllocateClick(Sender: TObject);
(*var
  s:String;
  fPQA , ProcTreePartPQA :TPQA;
  fdQtytoAllocate:Double;*)
begin
  inherited;
  if IsfullyAllocated then exit;
  OpenERPListFormultiselectModal('TBOMPurchaseAllocationGUI' , showBOMPurchaseAllocation , SelectFromPurchaseAllocation);

  (*With TempMyQuery do try
    SQL.Add('select POL.purchaselineID from tblpurchaselines  POL where proctreeId  = ' + inttostr(QrytreeproctreeID.AsInteger)+' and POL.unitofmeasureID = ' + inttostr(QryTreeuomid.AsInteger));
    open;
    s:= GroupConcat('purchaselineID');
  finally
    closenFree;
  end;
  if s= '' then exit;

  fPQA:= TPQA.Create(Self);
  fPQA.Connection := SalesOrder.Connection;
  fPQA.LoadSelect('TransLineId in (' + s +') and Transtype = "TPurchaseOrderLine"');
  if fPQA.count = 0 then begin
    MessageDlgXP_Vista('Good not Received / not allocated', mtWarning, [mbOK], 0);
    exit;
  end;
  with ProcTreePartofRec do begin
        if IsSubNodeParent then ProcTreePartPQA := SubNodeManufcaturePQA else ProcTreePartPQA:= PQa;
         if QryTreeBatch.AsBoolean      then fdQtytoAllocate := ProcTreePartPQA.UOMQty - ProcTreePartPQA.PQABAtch.TotalAllocated
    else if QryTreeUSebins.AsBoolean    then fdQtytoAllocate := ProcTreePartPQA.UOMQty - ProcTreePartPQA.PQABins.TotalAllocated
    else if QryTreeSNTRacking.AsBoolean then fdQtytoAllocate := ProcTreePartPQA.UOMQty - ProcTreePartPQA.PQASN.TotalAllocated;

    if fdQtytoAllocate <=0 then exit;
    fPQa.First;
    While fdQtytoAllocate >0 do begin
               if QryTreeBatch.AsBoolean      then begin
                  fPQA.PQABatch.First;
                  While fPQA.PQABatch.EOf = False do begin
                    if not ProcTreePartPQA.PQABatch.Locate('Value;ExpiryDate' ,vararrayof([fPQA.PQABatch.Batchno, fPQA.PQABatch.ExpiryDate]) , [] ) then begin
                      ProcTreePartPQA.PQABatch.New;
                      ProcTreePartPQA.PQABatch.Batchno :=fPQA.PQABatch.Batchno;
                      ProcTreePartPQA.PQABatch.ExpiryDate :=fPQA.PQABatch.ExpiryDate;
                      ProcTreePartPQA.PQABatch.PostDB;
                    end;
                    if  ProcTreePartPQA.PQABatch.UOMQty < fPQA.PQABatch.UOMQty then begin

                    end;
                    fPQA.PQABatch.Next;
                  end;
      end else if QryTreeUSebins.AsBoolean    then begin
      end else if QryTreeSNTRacking.AsBoolean then begin
      end;
    end;
  end;*)

end;

procedure TfmBOMAllocation.mnuUpdatewithcurTimeClick(Sender: TObject);
begin
  inherited;
  editDB(QryTree);
  QryTreeTransdate.AsDateTime := now;
  PostDB(QryTree);
end;

procedure TfmBOMAllocation.popMainPopup(Sender: TObject);
begin
  inherited;
  mnuAutoAllocate.enabled := (QryTreeOnOrderQty.AsFloat >0) and
                        ((Qrytreebatch.asboolean =true) OR
                         (QrytreeUsebins.asboolean =true) OR
                         (QrytreeSNTracking.asboolean =true));
  mnuUpdatewithcurTime.Visible := sametext(grdTransactions.GetActiveField.FieldName , qrytreeTransdate.FieldName);
end;

function TfmBOMAllocation.ProcTreePartofRec: TProcTreePart;
var
  node: TProcTreeNode;
begin
  result:= nil;
  if Salesorder.Lines.Tree.Locate(QryTreeProctreeID.AsInteger , node) then
    result := node.ProcTreePart;
end;
procedure TfmBOMAllocation.QryTreeBeforeOpen(DataSet: TDataSet);
var
  ctr:Integer;
begin
  inherited;
  for ctr := 0 to qrytree.fieldcount -1 do
    if qrytree.fields[ctr] is TFloatfield then
      TFloatfield(qrytree.fields[ctr]).DisplayFormat := '##########0.00';
end;

procedure TfmBOMAllocation.QryTreeTransdateChange(Sender: TField);
begin
  inherited;
  if (screen.activecontrol = grdTransactions) or (Screen.activecontrol = dtTransDate) then begin
    With ProcTreePartofRec do begin
            if IsSubNodeParent then begin
              SubNodeManufcaturePQA.transDate := QrytreeTransDate.asDateTime;
              SubNodeManufcaturePQA.PostDB;
              PQA.transDate := QrytreeTransDate.asDateTime;
              PQA.PostDB;
            end else begin
              PQA.transDate := QrytreeTransDate.asDateTime;
              PQA.PostDB;
            end;
    end;
  end;
end;

procedure TfmBOMAllocation.RollbackChanges;
begin
  if Assigned(SalesOrder) and  (SO.owner <> Self) then begin
      SO.Connection.RollbackNestedTransaction;
      Exit;
  end;
  RollbackTransaction;

end;
procedure TfmBOMAllocation.SelectEntriesForfinishedGoodsPrint;
begin
              TBaseListingGUI.MakeaList(Self ,fsFGReportSQL  + '  Order by batchno , binlocation, binnumber, serialnumber ', true ,'Choose Allocation to Print',
                            SelectedText('Batchno','No',15, 'Batch')+NL+
                            SelectedText('ExpiryDate','Expiry Date',15, 'Batch')+NL+
                            SelectedText('BinLocation','Location',15, 'Bin')+NL+
                            SelectedText('BinNumber','Number',15, 'Bin')+NL+
                            SelectedText('SerialNumber','Serial~Number',15), nil, nil , OnSelectEntriesForfinishedGoodsPrint , true , TERPConnection(SalesOrder.Connection.Connection));
end;
procedure TfmBOMAllocation.OnSelectEntriesForfinishedGoodsPrint(Sender: TwwDbGrid) ;
var
  i:Integer;
begin
  fsFGReportSelectedIds:= '';
  try
    if Sender.SelectedList.Count =0 then exit;

    showProgressbar('Choose Allocation to Print', Sender.SelectedList.Count);
    try
          if Sender.SelectedList.Count > 0 then begin
            for i := 0 to Sender.SelectedList.Count - 1 do begin
              Sender.datasource.Dataset.GoToBookmark(Sender.SelectedList.Items[i]);
                       if Sender.datasource.Dataset.fieldbyname('SNID').AsInteger     <> 0 then begin if fsFGReportSelectedIds<> '' then fsFGReportSelectedIds := fsFGReportSelectedIds +' or '; fsFGReportSelectedIds:= fsFGReportSelectedIds + ' ( SNID = ' + inttostr(Sender.datasource.Dataset.fieldbyname('SNID').AsInteger    )+')';
              end else if Sender.datasource.Dataset.fieldbyname('binId').AsInteger    <> 0 then begin if fsFGReportSelectedIds<> '' then fsFGReportSelectedIds := fsFGReportSelectedIds +' or '; fsFGReportSelectedIds:= fsFGReportSelectedIds + ' ( BinID = ' + inttostr(Sender.datasource.Dataset.fieldbyname('binId').AsInteger  )+')';
              end else if Sender.datasource.Dataset.fieldbyname('BatchID').AsInteger  <> 0 then begin if fsFGReportSelectedIds<> '' then fsFGReportSelectedIds := fsFGReportSelectedIds +' Or '; fsFGReportSelectedIds:= fsFGReportSelectedIds + ' (BatchID = ' +inttostr(Sender.datasource.Dataset.fieldbyname('BatchID').AsInteger)+')';
              end;
            end;
          end;
    finally
      HideProgressbar;
    end;
  finally
    //if fsFGReportSelectedIds<> '' then fsFGReportSQL := fsFGReportSQL + ' having ' + fsFGReportSelectedIds;
  end;
end;

procedure TfmBOMAllocation.btnFinishedGoodLabelClick(Sender: TObject);
begin
  inherited;


  (*fsFGReportSQL := 'Select ' +
            '  s.SaleId , S.CustomerName , S.saleDate , SL.SaleLineID , SL.ProductName , concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as UOM, ' +
            '  SL.QtySold, SL.UnitofMeasureQtySold, ' +
            '  SL.Shipped, SL.UnitofMeasureShipped , ' +
            '  SL.BackOrder, SL.UnitofMeasureBackorder, ' +
            '  PQABatch.Value as Batchno, PQABatch.ExpiryDate, PQABatch.TruckLoadNo , ' +
            '  PBin.binLocation , PBin.BinNumber, PQASN.value as Serialnumber ' +
            '  From tblsales S ' +
            '  inner join tblsaleslines SL on S.SaleId = SL.saleId '+
            TransTables(tDetailswithSno , 'SL' , 'SaleID' , 'SaleLineID' , SalesTransTypes)+
            ' where SL.saleLineId = '+ inttostr (SaleLineID);*)
  if SalesOrder.dirty  then begin
    if MessageDlgXP_Vista('This will save the current changes. Do you Wish to Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    if not SaveData then exit;
  end;
  commitChanges;
  SalesOrder.dirty := False;
  try
    fsFGReportSelectedIds := '';
    fsFGReportSQL:= (*SalesDispatchBarcodeSQL*)SalesDispatchBarcodeSQLWithoutcompanyInfo(inttostr(saleID) , inttostr(saleLineID) , '' , '',  tDetailswithSno);
    clog(fsFGReportSQL);

    SelectEntriesForfinishedGoodsPrint;
    if fsFGReportSelectedIds = '' then begin // if nothing selected
      exit;
    end;
    fsFGReportSQL := companyInfoSQL('CompanyInfo') + ' ~|||~ {Details}' +  fsFGReportSQL + '  having ' + fsFGReportSelectedIds + ' Order by batchno , binlocation, binnumber, serialnumber ';
    PrintTemplate.ReportSQLSupplied := TRue;
    (*if (ReportToPrint ='') and (ChkChooseRpt.checked = False) then
    if (ReportToPrint ='') or (ChkChooseRpt.checked) then ReportToPrint := TemplateReportName[true , ''];*)
    ReportToPrint := TemplateReportName[ChkChooseRpt.checked , ''];
    if ReportToPrint = '' then exit;

    PrintTemplate.PrintTemplateReport(ReportToPrint, fsFGReportSQL, not(devmode) and not (AppEnv.Employee.ShowPreview), 1 , SalesOrder.Connection.Connection);
  finally
    BeginChanges;
  end;

end;

class procedure TfmBOMAllocation.DoAllocation(fiHeaderId, fiLineID: Integer; fSO:TSalesOrder);
begin
  if SalesProductPartiallyShipped(fiLineID) then begin
                  MessageDlgXP_Vista('This product is being partially/fully shipped.'+NL+
                                     'It is not possible to do allocation from here.'+NL+NL+
                                     'Do the Partial Shipment for Doing Allocation.', mtInformation, [mbOK], 0);
                  Exit;
  end;

  with TfmBOMAllocation(getcomponentbyclassname('TfmBOMAllocation',true , nil, false)) do try
    SaleId := fiHeaderID;
    SaleLineID:= filineId;
    SalesOrder := fSO;
    showmodal;
  finally
    free;
  end;
end;

procedure TfmBOMAllocation.DobusobjEvent(Const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
          if Sender is TSalesorder     then TSalesorder(Sender).Dataset := tblMAster
     else if Sender is TSalesorderline then TSalesorder(Sender).Dataset := tbldetails;
  end;
end;

function TfmBOMAllocation.GetSalesOrder: TsaleSOrder;
begin
  If SO = nil then begin
    SO:=TSalesOrder.create(Self);
    SO.Connection := TMyDacDataConnection.Create(SO);
    SO.Connection.Connection := Self.MyConnection;
    SO.busobjEvent := DobusobjEvent ;
    SO.Load(SaleID);
    SO.Lines.Locate('SalelineID' , SaleLineID , []);
    SO.Lines.InstantiateTree; // don't need other lines
    SO.Lines.Tree.ProcTreePart;
  end;
  Result := SO;
end;

function TfmBOMAllocation.SAveData: Boolean;
begin
  Result := False;
  if not Validatedata then exit;
  result:= True;
end;

Procedure TfmBOMAllocation.Showallocationform;
var
    fsFieldname :STring;
    pqaID:Integer;
    aProcTreePartofRec :TProcTreePart;
begin
  if allocating then exit;
  if accesslevel = 5 then exit;
  Allocating := True;
  try
    fsFieldname := grdTransactions.GetActiveField.Fieldname;
    aProcTreePartofRec := ProcTreePartofRec;
    if Assigned(aProcTreePartofRec) and Sysutils.SameText(fsFieldname , 'PQAallocation') then begin
        //if (QryTreeOutQty.asfloat <> 0) or (QryTreeinQty.asFloat <> 0) then begin
        if (QryTreeManufacturedQty.asfloat <> 0) or (QryTreeManufacturingQty.asFloat <> 0) then begin
          if MessageDlgXP_Vista('Partial/Progress Build Started, Its not possible to do the Allocation.'+NL+
                                'Please Complete the build in the Partial/Progress Build Screen, Not Here.' +NL+NL+
                                'Do you wish to See the Partial/Progress Build Allocation for ' + Qrytreecaption.asString +'?' , mtconfirmation , [mbyes, mbNo], 0) = mryes then
                OpenERPListFormModal('TBOMSalesProgressReportGUI' , nil, BeforeShowList);
          Exit;
        end;
      With aProcTreePartofRec do begin
        Self.EditDb(Qrytree);
        QrytreePQAAllocation.AsString := '-';
        try
            if IsSubNodeParent then begin
              PQAID:= PQA.ID;
              if TfmAllocation.DoBinBatchform(SubNodeManufcaturePQA, self) then begin
                if SubNodeManufcaturePQA.TransDate < now then begin
                  SubNodeManufcaturePQA.TransDate := now;
                  SubNodeManufcaturePQA.PostDB;
                end;
                SubNodeManufcaturePQA.CopyAllocation(pqaId , false);
                salesorder.Dirty := True;
              end;
            end else begin
              if TfmAllocation.DoBinBatchform(PQA, self) then begin
                if PQA.TransDate < now then begin
                  PQA.TransDate := now;
                  PQA.PostDB;
                end;
                if IsRootNode then begin
                  PQAID:= SalesOrder.Lines.PQA.ID;
                  PQA.CopyAllocation(PQAID, false);
                  SalesOrder.Lines.PQA.PQABatch.RefreshDB;
                  SalesOrder.Lines.PQA.DoAfterAllocate;
                end;
                salesorder.Dirty := True;
              end;
            end;
        Finally
            QrytreePQAAllocation.AsString := '+';
            QrytreeAllocated.AsBoolean := True;
            Self.PostDb(Qrytree);
        End
      end;
    end;
  finally
    allocating := False;
  end;
end;

function TfmBOMAllocation.ValidateData: Boolean;
begin
  result:= False;
  QryTree.First;
  while QryTree.Eof = False do begin
    if QryTreeAllocated.AsBoolean then begin
      with ProcTreePartofRec do begin
        if IsSubNodeParent then begin
            if not SubNodeManufcaturePQA.Validatedata then exit;
            if not PQA.ValidateData then exit;
          end else begin
            if not PQa.ValidateData then exit;
            if IsRootNode then if not SalesOrder.Lines.PQA.ValidateData then exit;
          end;
      end;
    end;
    QryTree.Next;
  end;
  result:= TRue;
end;

procedure TfmBOMAllocation.wwDBEdit2KeyPress(Sender: TObject; var Key: Char);
var
  aProcTreePartofRec :TProcTreePart;
  Flag:Boolean;
  fdQty,fdAllocatedQty:Double;
  fdQtyReqd:Double;
  ProductBatchBarcode : TProductBatchBarcode;
  bm:TBookmark;
  fsTablename:String;
  QryStock:TERPQuery;


  Function BatchAvailableQty(ProductID:Integer;Batchno:String):Double;
  var
    scr:TERPScript;
  begin
      {create table outside transaction}
      scr := DbSharedObj.GetScript(GetSharedMyDacConnection(*Qrystock.Connection*));
      try
        scr.SQL.Text := 'Drop table if exists '+fsTablename +';' +
                  'Create table '+ fstablename +' ' + SQL4ProductAvailableQty((*Date*)0 , '' , tDetails , -1, -1 , Batchno , 0, '', '' ,'' , tAvailable,'','', 0, true , true );
        scr.Execute;
      finally
        DbSharedObj.ReleaseObj(Scr);
      end;

      {insert within transaction}
      scr := DbSharedObj.GetScript(Salesorder.connection.Connection);
      try
        scr.SQL.Text := 'delete from '+fsTablename +';' +
                  'insert ignore into '+ fstablename +' ' + SQL4ProductAvailableQty((*Date*)0 , '' , tDetails , ProductID, SaleSOrder.SaleClassId , Batchno , 0, '', '' ,'' , tAvailable,'','', 0, true , true )+' having qty >0;';
        scr.Execute;
      finally
        DbSharedObj.ReleaseObj(Scr);
      end;


      CloseDB(QryStock);
      QryStock.SQL.Text := 'select * from '+ fsTablename;
      QryStock.open;
      REsult := 0;
      if QryStock.RecordCount =0 then exit;
      QryStock.first;
      While QryStock.eof = False do begin
        result := result + QryStock.fieldbyname('Qty').AsFloat;
        QryStock.Next;
      end;
  end;
  Function BatchnUOMAvailableQty(UOM:String):Double;
  var
    fd:Double;
  begin
      fd:= fdQtyReqd;
      REsult := 0;
      if QryStock.RecordCount =0 then exit;
      QryStock.first;
      While (QryStock.eof = False) and (fd>0) do begin
        if sametext(QryStock.fieldbyname('uom').AsString , uom) then begin
          if QryStock.fieldbyname('Qty').AsFloat < fd then begin
            result := result + QryStock.fieldbyname('Qty').AsFloat;
            fd:= fd-QryStock.fieldbyname('Qty').AsFloat;
          end else begin
            result := result + fd;
            fd:= 0;
          end;
        end;
        QryStock.Next;
      end;
  end;
begin
  inherited;
  If Key = #13 then begin
    fdAllocatedQty := -1;
    try
    ProductBatchBarcode := TProductBatchBarcode.Create;
    try
      ProductBatchBarcode.Barcode := Trim(edtBatch.Text);
      if not ProductBatchBarcode.IsBarCodeValid then begin
        MessageDlgXP_Vista(ProductBatchBarcode.BarcodevalidationMsg+NL+NL+edtBatch.hint + NL+NL+
                                'Please make sure the Field selected in these templates for the barcode is ' + Quotedstr('ProductIDnBatchnumber')+'.' , mtWarning, [mbOK], 0);
        Exit;
      end;

      fsTablename := commondblib.GetUserTemporaryTableName('BatchAvailableQty');
      QryStock := DbSharedObj.GetQuery(Qrytree.Connection);
      try
        fdQty :=BatchAvailableQty(ProductBatchBarcode.ProductID, ProductBatchBarcode.Batchno);
        if fdQty <=0 then begin
            TimerMsg(lblMsg , getProduct(ProductBatchBarcode.ProductID) + ' - No Qty available for this produt / batch in ' + SalesOrder.SaleClassName  + ' ' + Appenv.DefaultClass.ClassHeading+'.' );
            Exit;
        end;

          Flag := False;
          fdAllocatedQty :=0;
          bm:=QryTree.getBookmark;
          try
              While (QryTree.eof = False) (*and (fdQty>0) *)do begin
                aProcTreePartofRec := ProcTreePartofRec;
                if not(Assigned(aProcTreePartofRec)) or (aProcTreePartofRec.ProductId <> ProductBatchBarcode.ProductId) or (aProcTreePartofRec.isRootNode) or (aProcTreePartofRec.FromStockUOMQty+ aProcTreePartofRec.OnOrderUOMQty =0) or (aProcTreePartofRec.FromStockUOMQty + aProcTreePartofRec.OnOrderUOMQty- aProcTreePartofRec.PQA.TotalBatchQty<=0 ) then begin
                  if not(Flag) then QryTree.First else QryTree.Next;
                  Flag := TRue;
                end else begin
                    fdQtyReqd :=aProcTreePartofRec.FromStockUOMQty + aProcTreePartofRec.OnOrderUOMQty - aProcTreePartofRec.PQA.TotalBatchQty;
                    fdQty := BatchnUOMAvailableQty(aProcTreePartofRec.UnitOfMeasure  );
                    if fdQty >0 then begin
                      QryStock.First;
                      While (QryStock.Eof = False) and (fdQtyReqd >0) do begin
                        if sametext(QryStock.fieldbyname('uom').AsString , aProcTreePartofRec.UnitOfMeasure ) then begin
                          if QryStock.fieldbyname('Qty').AsFloat <= fdQtyReqd then fdQty := QryStock.fieldbyname('Qty').AsFloat else fdQty := fdQtyReqd;
                          if fdQty >0 then begin
                            aProcTreePartofRec.PQA.PQABatch.New;
                            aProcTreePartofRec.PQA.PQABatch.batchno := ProductBatchBarcode.batchno;
                            aProcTreePartofRec.PQA.PQABatch.Qty :=fdQty;
                            aProcTreePartofRec.PQA.PQABatch.postDB;
                            salesorder.Dirty := True;
                            EditDb(Qrytree);
                            QrytreeAllocated.AsBoolean := True;
                            Self.PostDb(Qrytree);
                            editDB(QryStock);
                            QryStock.fieldbyname('Qty').AsFloat :=QryStock.fieldbyname('Qty').AsFloat - fdQty;
                            PostDB(QryStock);
                            fdQtyReqd := fdQtyReqd - fdQty;
                          end;
                        end;
                        QryStock.Next;
                      end;
                    end;
                    QryTree.Next;
                    (*fdQtyReqd :=aProcTreePartofRec.FromStockUOMQty + aProcTreePartofRec.OnOrderUOMQty - aProcTreePartofRec.PQA.TotalBatchQty;
                    fdQty := BatchnUOMAvailableQty(aProcTreePartofRec.UnitOfMeasure  );
                    if fdQty >0 then begin
                        if fdQty < fdQtyReqd then fdQtyReqd := fdQty;
                        aProcTreePartofRec.PQA.PQABatch.New;
                        aProcTreePartofRec.PQA.PQABatch.batchno := ProductBatchBarcode.batchno;
                        aProcTreePartofRec.PQA.PQABatch.Qty :=fdQtyReqd; fdAllocatedQty := fdAllocatedQty +aProcTreePartofRec.PQA.PQABatch.uomqty;
                        //fdQty := fdQty - fdQtyReqd;
                        aProcTreePartofRec.PQA.PQABatch.postDB;
                        salesorder.Dirty := True;
                        EditDb(Qrytree);
                        QrytreeAllocated.AsBoolean := True;
                        Self.PostDb(Qrytree);
                    end else begin
                      QryTree.Next;
                    end;*)
                end;
              end;
          finally
            QryTree.gotobookmark(bm);
            QryTree.FreeBookmark(bm);
          end;
      finally
         DbSharedObj.ReleaseObj(QryStock);
         commondblib.DestroyUserTemporaryTable(fsTablename);
      end;
    finally
      if fdAllocatedQty =0 then  TimerMsg(lblMsg , getProduct(ProductBatchBarcode.ProductID) + ' - Nothing found to be allocated / Batch has no available Qty to Allocate.' )
      else if fdAllocatedQty>0 then TimerMsg(lblMsg ,floattostr(fdAllocatedQty)+' Batches allocated for ' + getProduct(ProductBatchBarcode.ProductID) + '.' );
      freeandnil(ProductBatchBarcode);
    end;
    finally
      Key := #0;
      edtBatch.text:= '';
      SetControlfocus(edtBatch);
    end;
  End;

end;

initialization
  RegisterClassOnce(TfmBOMAllocation);

end.

