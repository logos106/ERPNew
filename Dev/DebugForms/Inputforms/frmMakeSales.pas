unit frmMakeSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Grids, Wwdbigrd, Wwdbgrid, DB, ProgressDialog, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, wwdbdatetimepicker;

type
  TfmMakeSales = class(TBaseInputGUI)
    qryClientLookup: TERPQuery;
    qryClientLookupCompany: TWideStringField;
    qryClientLookupClientId: TIntegerField;
    qryClientLookupDefaultPostAccount: TWideStringField;
    qryClientLookupDefaultPostAccountID: TIntegerField;
    qryClientLookupStreet: TWideStringField;
    qryClientLookupStreet2: TWideStringField;
    qryClientLookupStreet3: TWideStringField;
    qryClientLookupSuburb: TWideStringField;
    qryClientLookupState: TWideStringField;
    qryClientLookupCountry: TWideStringField;
    qryClientLookupPostcode: TWideStringField;
    qryClientLookupBillStreet: TWideStringField;
    qryClientLookupBillStreet2: TWideStringField;
    qryClientLookupBillStreet3: TWideStringField;
    qryClientLookupBillSuburb: TWideStringField;
    qryClientLookupBillState: TWideStringField;
    qryClientLookupBillPostcode: TWideStringField;
    qryClientLookupBillCountry: TWideStringField;
    qryClientLookupTERMS: TWideStringField;
    qryClientLookupTermsID: TIntegerField;
    qryClientLookupShippingMethod: TWideStringField;
    qryClientLookupShippingID: TIntegerField;
    qryClientLookupRepID: TIntegerField;
    qryClientLookupTaxID: TIntegerField;
    qryClientLookupPhone: TWideStringField;
    qryClientLookupFax: TWideStringField;
    qryClientLookupAltPhone: TWideStringField;
    qryClientLookupStopCredits: TWideStringField;
    qryClientLookupForcePOOnInvoice: TWideStringField;
    qryClientLookupUseInvBase: TWideStringField;
    qryClientLookupInvBaseNumber: TIntegerField;
    qryClientLookupWarrantyFinishDate: TDateTimeField;
    qryClientLookupIsJob: TWideStringField;
    cboProductQry: TERPQuery;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPartsDescription: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryLatestCostPrice: TFloatField;
    cboProductQrySNTracking: TWideStringField;
    cboProductQryActive: TWideStringField;
    cboProductQryPreferedSupp: TWideStringField;
    cboProductQryPRODUCTGROUP: TWideStringField;
    cboProductQryINCOMEACCNT: TWideStringField;
    cboProductQryASSETACCNT: TWideStringField;
    cboProductQryCOGSACCNT: TWideStringField;
    cboProductQryBARCODE: TWideStringField;
    cboProductQryPRODUCTCODE: TWideStringField;
    cboProductQryTAXCODE: TWideStringField;
    cboProductQryBatch: TWideStringField;
    cboProductQryAutoBatch: TWideStringField;
    cboProductQryMultipleBins: TWideStringField;
    cboProductQrySpecialDiscount: TWideStringField;
    cboProductQryBuyQTY1: TIntegerField;
    cboProductQryBuyQTY2: TIntegerField;
    cboProductQryBuyQTY3: TIntegerField;
    cboProductQryCOST1: TFloatField;
    cboProductQryCOST2: TFloatField;
    cboProductQryCOST3: TFloatField;
    cboProductQrySellQTY1: TIntegerField;
    cboProductQrySellQTY2: TIntegerField;
    cboProductQrySellQTY3: TIntegerField;
    cboProductQryPRICE1: TFloatField;
    cboProductQryPRICE2: TFloatField;
    cboProductQryPRICE3: TFloatField;
    cboProductQryWHOLESALEPRICE: TFloatField;
    cboProductQryEditedFlag: TWideStringField;
    cboProductQryAvgCost: TFloatField;
    cboProductQryAttrib1Sale: TFloatField;
    cboProductQryAttrib2Sale: TFloatField;
    cboProductQryAttrib1SaleRate: TFloatField;
    cboProductQryDiscontinued: TWideStringField;
    cboProductQryCUSTFLD1: TWideStringField;
    cboProductQryCUSTFLD2: TWideStringField;
    cboProductQryCUSTFLD3: TWideStringField;
    cboProductQryCUSTFLD4: TWideStringField;
    cboProductQryCUSTFLD5: TWideStringField;
    cboProductQryCUSTFLD6: TWideStringField;
    cboProductQryCUSTFLD7: TWideStringField;
    cboProductQryCUSTFLD8: TWideStringField;
    cboProductQryCUSTFLD9: TWideStringField;
    cboProductQryCUSTFLD10: TWideStringField;
    cboProductQryCUSTFLD11: TWideStringField;
    cboProductQryCUSTFLD12: TWideStringField;
    cboProductQryCUSTFLD13: TWideStringField;
    cboProductQryCUSTFLD14: TWideStringField;
    cboProductQryCUSTFLD15: TWideStringField;
    cboProductQryCUSTDATE1: TDateTimeField;
    cboProductQryCUSTDATE2: TDateTimeField;
    cboProductQryCUSTDATE3: TDateTimeField;
    Label1: TLabel;
    Label2: TLabel;
    dsProductQry: TDataSource;
    dsClientLookup: TDataSource;
    wwDBGrid1: TwwDBGrid;
    grdproducts: TwwDBGrid;
    btnMakeSales: TButton;
    cboProductQryType: TWideMemoField;
    cboProductQryManuf: TWideStringField;
    cboProductQryDept: TWideMemoField;
    ERPQuery1: TERPQuery;
    DataSource1: TDataSource;
    ERPQuery1SaleID: TIntegerField;
    ERPQuery1GlobalRef: TWideStringField;
    ERPQuery1InvoiceDocNumber: TWideStringField;
    ERPQuery1OriginalNo: TWideStringField;
    ERPQuery1BaseNo: TWideStringField;
    ERPQuery1Account: TWideStringField;
    ERPQuery1AccountID: TIntegerField;
    ERPQuery1BOID: TWideStringField;
    ERPQuery1CustomerName: TWideStringField;
    ERPQuery1ClientID: TIntegerField;
    ERPQuery1InvoiceTo: TWideStringField;
    ERPQuery1ShipTo: TWideStringField;
    ERPQuery1PickupFrom: TWideStringField;
    ERPQuery1SaleDate: TDateField;
    ERPQuery1TotalTax: TFloatField;
    ERPQuery1TotalWETTax: TFloatField;
    ERPQuery1TotalWEGTax: TFloatField;
    ERPQuery1TotalAmount: TFloatField;
    ERPQuery1TotalAmountInc: TFloatField;
    ERPQuery1TotalMarkup: TFloatField;
    ERPQuery1TotalDiscount: TFloatField;
    ERPQuery1EmployeeName: TWideStringField;
    ERPQuery1EmployeeID: TIntegerField;
    ERPQuery1ClassID: TIntegerField;
    ERPQuery1Class: TWideStringField;
    ERPQuery1OrderNumber: TWideStringField;
    ERPQuery1PONumber: TWideStringField;
    ERPQuery1ChequeNo: TWideStringField;
    ERPQuery1ShipDate: TDateField;
    ERPQuery1FutureSO: TWideStringField;
    ERPQuery1DueDate: TDateField;
    ERPQuery1ConNote: TWideStringField;
    ERPQuery1Memo: TWideMemoField;
    ERPQuery1Comments: TWideMemoField;
    ERPQuery1InvoicePrintDesc: TWideStringField;
    ERPQuery1PickMemo: TWideMemoField;
    ERPQuery1PrintHold: TWideStringField;
    ERPQuery1Shipping: TWideStringField;
    ERPQuery1Terms: TWideStringField;
    ERPQuery1PayMethod: TWideStringField;
    ERPQuery1PayDueDate: TWideStringField;
    ERPQuery1Paid: TWideStringField;
    ERPQuery1Balance: TFloatField;
    ERPQuery1SOBalance: TFloatField;
    ERPQuery1Payment: TFloatField;
    ERPQuery1ApplyFlag: TWideStringField;
    ERPQuery1AmountDue: TFloatField;
    ERPQuery1TimeOfSale: TWideStringField;
    ERPQuery1IsPOS: TWideStringField;
    ERPQuery1POS: TWideStringField;
    ERPQuery1IsRefund: TWideStringField;
    ERPQuery1IsCashSale: TWideStringField;
    ERPQuery1IsInvoice: TWideStringField;
    ERPQuery1IsQuote: TWideStringField;
    ERPQuery1IsSalesOrder: TWideStringField;
    ERPQuery1IsVoucher: TWideStringField;
    ERPQuery1IsLayby: TWideStringField;
    ERPQuery1IsLaybyTOS: TWideStringField;
    ERPQuery1IsLaybyPayment: TWideStringField;
    ERPQuery1Deleted: TWideStringField;
    ERPQuery1Cancelled: TWideStringField;
    ERPQuery1EditedFlag: TWideStringField;
    ERPQuery1TotalQuoteAmount: TFloatField;
    ERPQuery1LaybyID: TWideStringField;
    ERPQuery1Deposited: TWideStringField;
    ERPQuery1TillID: TSmallintField;
    ERPQuery1HoldSale: TWideStringField;
    ERPQuery1SaleConfirmed: TWideStringField;
    ERPQuery1FreezeQuoteAmount: TWideStringField;
    ERPQuery1Converted: TWideStringField;
    ERPQuery1EnteredBy: TWideStringField;
    ERPQuery1EnteredAt: TWideStringField;
    ERPQuery1CommissionPaid: TWideStringField;
    ERPQuery1IsManifest: TWideStringField;
    ERPQuery1UsedOnManifest: TWideStringField;
    ERPQuery1AddToManifest: TWideStringField;
    ERPQuery1SalesOrderGlobalRef: TWideStringField;
    ERPQuery1QuoteGlobalRef: TWideStringField;
    ERPQuery1RepairGlobalRef: TWideStringField;
    ERPQuery1SOProgressPaymentGlobalRef: TWideStringField;
    ERPQuery1SOProgressPaymentOriginalRef: TWideStringField;
    ERPQuery1IsBarcodePicking: TWideStringField;
    ERPQuery1BarcodePickingDone: TWideStringField;
    ERPQuery1ARNotes: TWideMemoField;
    ERPQuery1OriginalCreationDate: TDateField;
    ERPQuery1QuoteStatus: TWideStringField;
    ERPQuery1DespatchID: TIntegerField;
    ERPQuery1RunID: TIntegerField;
    ERPQuery1RunName: TWideStringField;
    ERPQuery1Reference: TWideStringField;
    ERPQuery1msTimeStamp: TDateTimeField;
    ERPQuery1POCreated: TWideStringField;
    ERPQuery1LastUpdated: TDateTimeField;
    ERPQuery1ForeignExchangeCode: TWideStringField;
    ERPQuery1ForeignExchangeRate: TFloatField;
    ERPQuery1ForeignTotalAmount: TFloatField;
    ERPQuery1ForeignPaidAmount: TFloatField;
    ERPQuery1ForeignBalanceAmount: TFloatField;
    ERPQuery1IsGeneratedFromHire: TWideStringField;
    ERPQuery1BlindBalancePeriodID: TIntegerField;
    ERPQuery1SaleDateTime: TDateTimeField;
    ERPQuery1AutoSmartOrderRef: TWideStringField;
    ERPQuery1IsInternalOrder: TWideStringField;
    ERPQuery1ShippingCost: TFloatField;
    ERPQuery1contactID: TLargeintField;
    ERPQuery1ContactName: TWideStringField;
    ERPQuery1POSPostCode: TWideStringField;
    ERPQuery1RepairID: TLargeintField;
    ERPQuery1MedtypeID: TIntegerField;
    ERPQuery1Medtype: TWideStringField;
    ERPQuery1NoOfBoxes: TLargeintField;
    ERPQuery1ContributionAmount: TFloatField;
    ERPQuery1ShipToID: TIntegerField;
    ERPQuery1SalesCategory: TWideStringField;
    ERPQuery1msUpdateSiteCode: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btnMakeSalesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjSales, BusobjCash , BusObjPOSSale, dateutils;

{$R *.dfm}

procedure TfmMakeSales.btnMakeSalesClick(Sender: TObject);
var
  Inv :TInvoice;
  CS:TCashSale;
  POS:TPOSCashsale;
  x:Integer;
  dt:TDateTime;
  ctr:Integer;
begin
  inherited;
  Inv := TInvoice.CreateWithNewConn(Self);   CS:= TCashSale.Create(Self);  POS:= TPOSCashsale.Create(Self);

  CS.Connection := Inv.connection;   POS.Connection := Inv.connection;

  Inv.SilentMode:= True; CS.SilentMode:= True;  POS.SilentMode:= True;

   CS.Load(0);   POS.Load(0);
  dt:= IncHour(date , -12);
  ctr:= 1;
  DoShowProgressbar(24 , 'please wait' , '');
  try
    While dt < IncHour(Date,12) do begin
      Inv.Load(0);
      Inv.connection.BeginTransaction;
      try
        Inv.New;
        Inv.CustomerName := qryClientLookupCompany.AsString;
        Inv.DueDate := dt;
        Inv.SaleDate := Dt;
        Inv.ShipDate := dt;
        Inv.SaleDateTime := dt;
        Inv.PostDB;

        for x:= 0 to grdproducts.SelectedList.Count - 1 do begin
          cboProductQry.GotoBookmark(grdproducts.SelectedList.Items[x]);
          Inv.Lines.New;
          Inv.Lines.Productname :=cboProductQryPARTNAME.AsString;
          Inv.Lines.Qtysold := ctr;
          Inv.Lines.QtyShipped := ctr+1;
          Inv.Lines.PostDB;
        end;
        Inv.DueDate := dt;
        Inv.SaleDate := Dt;
        Inv.ShipDate := dt;
        Inv.SaleDateTime := dt;
        Inv.PostDB;
        Inv.Save;
        Inv.Connection.CommitTransaction;
        Inv.closeDB;
      Except
        on E:Exception do begin
          Inv.connection.RollbackTransaction;
        end;
      end;
      ctr:= ctr+1;
      dt:= IncMinute(dt, 10);
      CS.Load(0);
      CS.connection.BeginTransaction;
      try
        CS.New;
        CS.CustomerName := qryClientLookupCompany.AsString;
        CS.DueDate := dt;
        CS.SaleDate := Dt;
        CS.ShipDate := dt;
        CS.SaleDateTime := dt;
        CS.PostDB;

        for x:= 0 to grdproducts.SelectedList.Count - 1 do begin
          cboProductQry.GotoBookmark(grdproducts.SelectedList.Items[x]);
          CS.Lines.New;
          CS.Lines.Productname :=cboProductQryPARTNAME.AsString;
          CS.Lines.Qtysold := ctr;
          CS.Lines.QtyShipped := ctr+1;
          CS.Lines.PostDB;
        end;
        CS.DueDate := dt;
        CS.SaleDate := Dt;
        CS.ShipDate := dt;
        CS.SaleDateTime := dt;
        CS.PostDB;
        CS.Save;
        CS.Connection.CommitTransaction;
        CS.closeDB;
      Except
        on E:Exception do begin
          CS.connection.RollbackTransaction;
        end;
      end;
      ctr:= ctr+1;
      dt:= IncMinute(dt, 10);
      POS.Load(0);
      POS.connection.BeginTransaction;
      try
        POS.New;
        POS.CustomerName := qryClientLookupCompany.AsString;
        POS.DueDate := dt;
        POS.SaleDate := Dt;
        POS.ShipDate := dt;
        POS.SaleDateTime := dt;
        POS.PostDB;

        for x:= 0 to grdproducts.SelectedList.Count - 1 do begin
          cboProductQry.GotoBookmark(grdproducts.SelectedList.Items[x]);
          POS.Lines.New;
          POS.Lines.Productname :=cboProductQryPARTNAME.AsString;
          POS.Lines.Qtysold := ctr;
          POS.Lines.QtyShipped := ctr+1;
          POS.Lines.PostDB;
        end;
        POS.DueDate := dt;
        POS.SaleDate := Dt;
        POS.ShipDate := dt;
        POS.SaleDateTime := dt;
        POS.PostDB;
        POS.Save;
        POS.Connection.CommitTransaction;
        POS.closeDB;
      Except
        on E:Exception do begin
          POS.connection.RollbackTransaction;
        end;
      end;

      ctr:= ctr+1;
      dt:= IncMinute(dt, 20);
      DoStepProgressbar(FormatDateTime('hh:nn:ss' , dt));
    end;

  finally
    dohideprogressbar;
  end;

end;

procedure TfmMakeSales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := Cafree;
end;

procedure TfmMakeSales.FormShow(Sender: TObject);
begin
  inherited;
  openQueries;
end;

initialization
  RegisterClassOnce(TfmMakeSales);

end.

