unit frmComboTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  Grids, Wwdbigrd, Wwdbgrid, StdCtrls, wwdblook, Mask, wwdbedit, wwlocate,
  ERPDbLookupCombo, Wwdbdlg, kbmMemTable, VirtualTable;

type

  TfmComboTest = class(TBaseInputGUI)
    qryMaster: TERPQuery;
    dsMaster: TDataSource;
    qryDetail: TERPQuery;
    dsDetail: TDataSource;
    grdMain: TwwDBGrid;
    qryMasterSaleID: TIntegerField;
    qryMasterGlobalRef: TWideStringField;
    qryMasterInvoiceDocNumber: TWideStringField;
    qryMasterOriginalNo: TWideStringField;
    qryMasterBaseNo: TWideStringField;
    qryMasterAccount: TWideStringField;
    qryMasterAccountID: TIntegerField;
    qryMasterBOID: TWideStringField;
    qryMasterCustomerName: TWideStringField;
    qryMasterClientID: TIntegerField;
    qryMasterInvoiceTo: TWideStringField;
    qryMasterShipTo: TWideStringField;
    qryMasterPickupFrom: TWideStringField;
    qryMasterSaleDate: TDateField;
    qryMasterTotalTax: TFloatField;
    qryMasterTotalWETTax: TFloatField;
    qryMasterTotalWEGTax: TFloatField;
    qryMasterTotalAmount: TFloatField;
    qryMasterTotalAmountInc: TFloatField;
    qryMasterTotalMarkup: TFloatField;
    qryMasterTotalDiscount: TFloatField;
    qryMasterEmployeeName: TWideStringField;
    qryMasterEmployeeID: TIntegerField;
    qryMasterClassID: TIntegerField;
    qryMasterClass: TWideStringField;
    qryMasterOrderNumber: TWideStringField;
    qryMasterPONumber: TWideStringField;
    qryMasterChequeNo: TWideStringField;
    qryMasterShipDate: TDateField;
    qryMasterFutureSO: TWideStringField;
    qryMasterDueDate: TDateField;
    qryMasterConNote: TWideStringField;
    qryMasterMemo: TWideMemoField;
    qryMasterComments: TWideMemoField;
    qryMasterInvoicePrintDesc: TWideStringField;
    qryMasterPickMemo: TWideStringField;
    qryMasterPrintHold: TWideStringField;
    qryMasterShipping: TWideStringField;
    qryMasterTerms: TWideStringField;
    qryMasterPayMethod: TWideStringField;
    qryMasterPayDueDate: TWideStringField;
    qryMasterPaid: TWideStringField;
    qryMasterBalance: TFloatField;
    qryMasterSOBalance: TFloatField;
    qryMasterPayment: TFloatField;
    qryMasterApplyFlag: TWideStringField;
    qryMasterAmountDue: TFloatField;
    qryMasterTimeOfSale: TWideStringField;
    qryMasterIsPOS: TWideStringField;
    qryMasterPOS: TWideStringField;
    qryMasterIsRefund: TWideStringField;
    qryMasterIsCashSale: TWideStringField;
    qryMasterIsInvoice: TWideStringField;
    qryMasterIsQuote: TWideStringField;
    qryMasterIsSalesOrder: TWideStringField;
    qryMasterIsVoucher: TWideStringField;
    qryMasterIsLayby: TWideStringField;
    qryMasterIsLaybyTOS: TWideStringField;
    qryMasterIsLaybyPayment: TWideStringField;
    qryMasterDeleted: TWideStringField;
    qryMasterCancelled: TWideStringField;
    qryMasterEditedFlag: TWideStringField;
    qryMasterTotalQuoteAmount: TFloatField;
    qryMasterLaybyID: TWideStringField;
    qryMasterDeposited: TWideStringField;
    qryMasterTillID: TSmallintField;
    qryMasterTillName: TWideStringField;
    qryMasterHoldSale: TWideStringField;
    qryMasterSaleConfirmed: TWideStringField;
    qryMasterFreezeQuoteAmount: TWideStringField;
    qryMasterConverted: TWideStringField;
    qryMasterEnteredBy: TWideStringField;
    qryMasterEnteredAt: TWideStringField;
    qryMasterCommissionPaid: TWideStringField;
    qryMasterIsManifest: TWideStringField;
    qryMasterUsedOnManifest: TWideStringField;
    qryMasterAddToManifest: TWideStringField;
    qryMasterSalesOrderGlobalRef: TWideStringField;
    qryMasterQuoteGlobalRef: TWideStringField;
    qryMasterRepairGlobalRef: TWideStringField;
    qryMasterSOProgressPaymentGlobalRef: TWideStringField;
    qryMasterSOProgressPaymentOriginalRef: TWideStringField;
    qryMasterIsBarcodePicking: TWideStringField;
    qryMasterBarcodePickingDone: TWideStringField;
    qryMasterARNotes: TWideMemoField;
    qryMasterOriginalCreationDate: TDateField;
    qryMasterQuoteStatus: TWideStringField;
    qryMasterDespatchID: TIntegerField;
    qryMasterRunID: TIntegerField;
    qryMasterRunName: TWideStringField;
    qryMasterReference: TWideStringField;
    qryMastermsTimeStamp: TDateTimeField;
    qryMasterPOCreated: TWideStringField;
    qryMasterLastUpdated: TDateTimeField;
    qryMasterForeignExchangeCode: TWideStringField;
    qryMasterForeignExchangeRate: TFloatField;
    qryMasterForeignTotalAmount: TFloatField;
    qryMasterForeignPaidAmount: TFloatField;
    qryMasterForeignBalanceAmount: TFloatField;
    qryMasterIsGeneratedFromHire: TWideStringField;
    qryMasterBlindBalancePeriodID: TIntegerField;
    qryMasterSaleDateTime: TDateTimeField;
    qryMasterAutoSmartOrderRef: TWideStringField;
    qryMasterIsInternalOrder: TWideStringField;
    qryMasterShippingCost: TFloatField;
    qryMastercontactID: TLargeintField;
    qryMasterContactName: TWideStringField;
    qryMasterPOSPostCode: TWideStringField;
    qryMasterRepairID: TLargeintField;
    qryMasterMedtypeID: TIntegerField;
    qryMasterMedtype: TWideStringField;
    qryMasterNoOfBoxes: TLargeintField;
    qryDetailSaleLineID: TIntegerField;
    qryDetailSaleID: TIntegerField;
    qryDetailProductID: TIntegerField;
    qryDetailProductName: TWideStringField;
    qryDetailProduct_Description: TWideStringField;
    qryDetailLinePriceInc: TFloatField;
    qryDetailQtySold: TFloatField;
    qryDetailTotalLineAmountInc: TFloatField;
    cboClient: TERPDBLookupCombo;
    cboProduct: TERPDBLookupCombo;
    qryClientLookup: TERPQuery;
    qryPartsLookup: TERPQuery;
    Label1: TLabel;
    edtSaleDate: TwwDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtInvoiceDocNumber: TwwDBEdit;
    memLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClientNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboProductNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboClientCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryMasterCustomerNameChange(Sender: TField);
    procedure cboClientChange(Sender: TObject);
    procedure qryMasterCustomerNameSetText(Sender: TField; const Text: string);
    procedure qryMasterCustomerNameValidate(Sender: TField);
  private
    procedure CreateTempTables;
//    procedure DoOnLogMessageEvent(sender: TObject; msg: string);
    procedure DoOnSpecialItem(Sender: TObject; Item: string);

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib;


procedure TfmComboTest.cboClientChange(Sender: TObject);
begin
  inherited;
//  memLog.Lines.Add('cboClient.Change: ' + cboClient.Text);
end;

procedure TfmComboTest.cboClientCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
//  memLog.Lines.Add('cboClient.CloseUp: ' + cboClient.Text);
end;

procedure TfmComboTest.cboClientNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  memLog.Lines.Add('cboClientNotInList');
  ShowMessage('Client not in list');
end;

procedure TfmComboTest.cboProductNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  memLog.Lines.Add('cboProductNotInList');
  ShowMessage('Product not in list');
end;

procedure TfmComboTest.CreateTempTables;
var
  script: TERPScript;
begin
  script:= TERPScript.Create(nil);
  try
    script.Connection:= CommonDbLib.GetSharedMyDacConnection;
    script.SQL.Add('drop table if exists tmp_parts;');
    script.SQL.Add('create table tmp_parts as select * from tblparts;');
    script.SQL.Add('drop table if exists tmp_clients;');
    script.SQL.Add('create table tmp_clients as select * from tblclients;');
    script.SQL.Add('drop table if exists tmp_sales;');
    script.SQL.Add('create table tmp_sales as select * from tblsales;');
    script.SQL.Add('ALTER TABLE `tmp_sales`  CHANGE COLUMN `SaleID` `SaleID` INT(11) NOT NULL AUTO_INCREMENT FIRST,  ADD PRIMARY KEY (`SaleID`);');
    script.SQL.Add('drop table if exists tmp_saleslines;');
    script.SQL.Add('create table tmp_saleslines as select * from tblsaleslines;');
    script.SQL.Add('ALTER TABLE `tmp_saleslines`  CHANGE COLUMN `SaleLineID` `SaleLineID` INT(11) NOT NULL AUTO_INCREMENT FIRST,  ADD PRIMARY KEY (`SaleLineID`);');

    script.Execute;
  finally
    script.Free;
  end;
  qryClientLookup.ParamByName('SearchMode').AsInteger:= 1;
  qryPartsLookup.ParamByName('SearchMode').AsInteger:= 1;
  cboClient.SearchMode:= smStartsWith;
  cboProduct.SearchMode:= smStartsWith;
end;

//procedure TfmComboTest.DoOnLogMessageEvent(sender: TObject; msg: string);
//begin
//  memLog.Lines.Add(msg);
//end;

procedure TfmComboTest.DoOnSpecialItem(Sender: TObject; Item: string);
begin
  //memLog.Lines.Add(TComponent(Sender).Name + '.OnSpecialItem  ' + Item);
  ShowMessage(TComponent(Sender).Name + '.OnSpecialItem  ' + Item);
end;

procedure TfmComboTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmComboTest.FormCreate(Sender: TObject);
begin
  inherited;
  self.fbTabSettingEnabled:= false;
  CreateTempTables;
  cboClient.AutoDropDown:= true;
  cboProduct.AutoDropDown:= true;
//  cboClient.OnLogMessage:= DoOnLogMessageEvent;
//  cboProduct.OnLogMessage:= DoOnLogMessageEvent;
  cboClient.OnSpecialItem:= DoOnSpecialItem;
  cboProduct.OnSpecialItem:= DoOnSpecialItem;

//  grdMain.KeyOptions:= [dgEnterToTab,dgAllowInsert];

end;

procedure TfmComboTest.FormShow(Sender: TObject);
begin
  inherited;


  qryPartsLookup.Open;
  qryClientLookup.Open;
  qryMaster.ParamByName('SaleID').AsInteger:= 0;
  qryMaster.Open;
  qryMaster.Insert;
  qryMaster.Post;

  qryMaster.ParamByName('SaleID').AsInteger:= qryMaster.InsertId;
  qryMaster.Open;
  qryMaster.Edit;

  qryDetail.ParamByName('SaleID').AsInteger:= qryMaster.InsertId;
  qryDetail.Open;
  self.qryMasterInvoiceDocNumber.AsInteger:= qryMaster.InsertId;

  cboClient.SetFocus;
//  cboClient.Text:= '[Create New]';
end;

procedure TfmComboTest.qryMasterCustomerNameChange(Sender: TField);
begin
  memLog.Lines.Add('Field Data Changed "' + Sender.FieldName + '": "' + sender.AsString + '"');
  inherited;

end;

procedure TfmComboTest.qryMasterCustomerNameSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  //
//  if VarIsNull(Sender.OldValue) then
//    memLog.Lines.Add('Set text - New Text: ' + Text +  '  Old Value: ' + '')
//  else
//    memLog.Lines.Add('Set text - New Text: ' + Text +  '  Old Value: ' + Sender.OldValue);

  sender.AsString:= Text;

end;

procedure TfmComboTest.qryMasterCustomerNameValidate(Sender: TField);
begin
//  if VarIsNull(Sender.OldValue) then
//    memLog.Lines.Add('Validate - New Value: ' + Sender.AsString +  '  Old Value: ' + '')
//  else
//    memLog.Lines.Add('Validate - New Text: ' + SEnder.AsString +  '  Old Value: ' + Sender.OldValue);
  inherited;

end;

initialization
  Registerclass(TfmComboTest);

end.
