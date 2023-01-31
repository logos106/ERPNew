unit frmSplitInvoicePayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase, Grids, Wwdbigrd, Wwdbgrid, Mask, wwdbedit,
  wwdblook, BusObjSplitPayment, Buttons;

type
  TfmSplitInvoicePayment = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    QrySplitPayments: TERPQuery;
    dsSplitPayments: TDataSource;
    QrySplitPaymentsGlobalRef: TWideStringField;
    QrySplitPaymentsSplitPaymentID: TIntegerField;
    QrySplitPaymentsEmployeeID: TIntegerField;
    QrySplitPaymentsEmployee: TWideStringField;
    QrySplitPaymentsEnteredAt: TDateTimeField;
    QrySplitPaymentsSaleID: TIntegerField;
    QrySplitPaymentsPaymentDate: TDateField;
    QrySplitPaymentsAmount: TFloatField;
    QrySplitPaymentsNotes: TWideStringField;
    QrySplitPaymentlinesReferenceNo: TWideStringField;
    QrySplitPaymentsClassID: TIntegerField;
    QrySplitPaymentsAccountID: TIntegerField;
    QrySplitPaymentlinesBankAccountName: TWideStringField;
    QrySplitPaymentlinesBankAccountBSB: TWideStringField;
    QrySplitPaymentlinesBankAccountNo: TWideStringField;
    QrySplitPaymentsForeignVariationAccountID: TIntegerField;
    QrySplitPaymentsmsTimeStamp: TDateTimeField;
    QrySplitPaymentsmsUpdateSiteCode: TWideStringField;
    QrySplitPaymentsTotalApplied: TFloatField;
    QrySplitPaymentsTotalUnApplied: TFloatField;

    QrySplitMaymentLines: TERPQuery;
    dsSplitMaymentLines: TDataSource;
    QrySplitMaymentLinesGlobalRef: TWideStringField;
    QrySplitMaymentLinesSplitPaymentLineID: TIntegerField;
    QrySplitMaymentLinesSplitPaymentID: TIntegerField;
    QrySplitMaymentLinesPayMethodID: TIntegerField;
    QrySplitMaymentLinesAmount: TFloatField;
    QrySplitMaymentLinesPercentage: TFloatField;
    QrySplitMaymentLinesCardholdersName: TWideStringField;
    QrySplitMaymentLinesCreditCardNumber: TWideStringField;
    QrySplitMaymentLinesPayMethod: TWideStringField;
    QrySplitMaymentLinesCreditCardExpDate: TDateField;
    QrySplitMaymentLinesmsTimeStamp: TDateTimeField;
    QrySplitMaymentLinesmsUpdateSiteCode: TWideStringField;
    QrySplitMaymentLinesForeignCurrencyAmount: TFloatField;
    qryPayMethod: TERPQuery;
    qryVariationAccount: TERPQuery;
    cboClassQry: TERPQuery;
    cboAccountQry: TERPQuery;
    DNMPanel4: TDNMPanel;
    ClassLabel: TLabel;
    cboClass: TwwDBLookupCombo;
    Label81: TLabel;
    cboAccount: TwwDBLookupCombo;
    DNMPanel5: TDNMPanel;
    Notes: TDBMemo;
    btnAddDate: TDNMSpeedButton;
    Label28: TLabel;
    grdPayments: TwwDBGrid;
    qryPayMethodPayMethodID: TIntegerField;
    qryPayMethodIsCreditCard: TWideStringField;
    qryPayMethodPaymentMethod: TWideStringField;
    lblMsg: TLabel;
    QrySplitMaymentLinesForeignExchangeRate: TFloatField;
    QrySplitMaymentLinesForeignExchangeCode: TWideStringField;
    lblVariationAccount: TLabel;
    cboVariationAccount: TwwDBLookupCombo;
    cboPaymentMethod: TwwDBLookupCombo;
    qryForeignCurrency: TERPQuery;
    cboForeignCurrencyCode: TwwDBLookupCombo;
    pnlFC: TDNMPanel;
    DBText1: TDBText;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    pnltotals: TDNMPanel;
    lblLocalcurency: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label44: TLabel;
    Label36: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grdPaymentsIButton: TwwIButton;
    QrySplitMaymentLinesdeleted: TWideStringField;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    QrySales: TERPQuery;
    dsSales: TDataSource;
    QrySalesSaleID: TIntegerField;
    QrySalesGlobalRef: TWideStringField;
    QrySalesInvoiceDocNumber: TWideStringField;
    QrySalesOriginalNo: TWideStringField;
    QrySalesBaseNo: TWideStringField;
    QrySalesAccount: TWideStringField;
    QrySalesAccountID: TIntegerField;
    QrySalesBOID: TWideStringField;
    QrySalesCustomerName: TWideStringField;
    QrySalesClientID: TIntegerField;
    QrySalesInvoiceTo: TWideStringField;
    QrySalesShipTo: TWideStringField;
    QrySalesPickupFromID: TIntegerField;
    QrySalesPickupFrom: TWideStringField;
    QrySalesSaleDate: TDateField;
    QrySalesTotalTax: TFloatField;
    QrySalesTotalWETTax: TFloatField;
    QrySalesTotalWEGTax: TFloatField;
    QrySalesTotalAmount: TFloatField;
    QrySalesTotalAmountInc: TFloatField;
    QrySalesTotalMarkup: TFloatField;
    QrySalesTotalDiscount: TFloatField;
    QrySalesEmployeeName: TWideStringField;
    QrySalesEmployeeID: TIntegerField;
    QrySalesClassID: TIntegerField;
    QrySalesClass: TWideStringField;
    QrySalesOrderNumber: TWideStringField;
    QrySalesPONumber: TWideStringField;
    QrySalesChequeNo: TWideStringField;
    QrySalesShipDate: TDateField;
    QrySalesFutureSO: TWideStringField;
    QrySalesDueDate: TDateField;
    QrySalesConNote: TWideStringField;
    QrySalesMemo: TWideMemoField;
    QrySalesComments: TWideMemoField;
    QrySalesInvoicePrintDesc: TWideStringField;
    QrySalesPickMemo: TWideMemoField;
    QrySalesPrintHold: TWideStringField;
    QrySalesShipping: TWideStringField;
    QrySalesTerms: TWideStringField;
    QrySalesPayMethod: TWideStringField;
    QrySalesPayDueDate: TWideStringField;
    QrySalesPaid: TWideStringField;
    QrySalesBalance: TFloatField;
    QrySalesSOBalance: TFloatField;
    QrySalesPayment: TFloatField;
    QrySalesApplyFlag: TWideStringField;
    QrySalesAmountDue: TFloatField;
    QrySalesTimeOfSale: TWideStringField;
    QrySalesIsPOS: TWideStringField;
    QrySalesPOS: TWideStringField;
    QrySalesIsRefund: TWideStringField;
    QrySalesIsCashSale: TWideStringField;
    QrySalesIsInvoice: TWideStringField;
    QrySalesIsQuote: TWideStringField;
    QrySalesIsSalesOrder: TWideStringField;
    QrySalesIsVoucher: TWideStringField;
    QrySalesIsLayby: TWideStringField;
    QrySalesIsLaybyTOS: TWideStringField;
    QrySalesIsLaybyPayment: TWideStringField;
    QrySalesIsCustomerReturn: TWideStringField;
    QrySalesDeleted: TWideStringField;
    QrySalesCancelled: TWideStringField;
    QrySalesEditedFlag: TWideStringField;
    QrySalesTotalQuoteAmount: TFloatField;
    QrySalesLaybyID: TWideStringField;
    QrySalesDeposited: TWideStringField;
    QrySalesTillID: TSmallintField;
    QrySalesHoldSale: TWideStringField;
    QrySalesSaleConfirmed: TWideStringField;
    QrySalesFreezeQuoteAmount: TWideStringField;
    QrySalesConverted: TWideStringField;
    QrySalesEnteredBy: TWideStringField;
    QrySalesEnteredAt: TWideStringField;
    QrySalesCommissionPaid: TWideStringField;
    QrySalesIsManifest: TWideStringField;
    QrySalesUsedOnManifest: TWideStringField;
    QrySalesAddToManifest: TWideStringField;
    QrySalesSalesOrderGlobalRef: TWideStringField;
    QrySalesQuoteGlobalRef: TWideStringField;
    QrySalesRepairGlobalRef: TWideStringField;
    QrySalesSOProgressPaymentGlobalRef: TWideStringField;
    QrySalesSOProgressPaymentOriginalRef: TWideStringField;
    QrySalesIsBarcodePicking: TWideStringField;
    QrySalesBarcodePickingDone: TWideStringField;
    QrySalesARNotes: TWideMemoField;
    QrySalesOriginalCreationDate: TDateField;
    QrySalesQuoteStatus: TWideStringField;
    QrySalesDespatchID: TIntegerField;
    QrySalesRunID: TIntegerField;
    QrySalesRunName: TWideStringField;
    QrySalesReference: TWideStringField;
    QrySalesmsTimeStamp: TDateTimeField;
    QrySalesPOCreated: TWideStringField;
    QrySalesLastUpdated: TDateTimeField;
    QrySalesForeignExchangeCode: TWideStringField;
    QrySalesForeignExchangeRate: TFloatField;
    QrySalesForeignTotalAmount: TFloatField;
    QrySalesForeignPaidAmount: TFloatField;
    QrySalesForeignBalanceAmount: TFloatField;
    QrySalesIsGeneratedFromHire: TWideStringField;
    QrySalesBlindBalancePeriodID: TIntegerField;
    QrySalesSaleDateTime: TDateTimeField;
    QrySalesAutoSmartOrderRef: TWideStringField;
    QrySalesIsInternalOrder: TWideStringField;
    QrySalesShippingCost: TFloatField;
    QrySalescontactID: TLargeintField;
    QrySalesContactName: TWideStringField;
    QrySalesPOSPostCode: TWideStringField;
    QrySalesRepairID: TLargeintField;
    QrySalesMedtypeID: TIntegerField;
    QrySalesMedtype: TWideStringField;
    QrySalesNoOfBoxes: TLargeintField;
    QrySalesContributionAmount: TFloatField;
    QrySalesShipToID: TIntegerField;
    QrySalesSalesCategory: TWideStringField;
    QrySalesmsUpdateSiteCode: TWideStringField;
    QrySalesCustomerReturnRef: TWideStringField;
    QrySalesSOInvoiced: TWideStringField;
    QrySalesSOInvoiceRef: TWideStringField;
    QrySalesArea: TWideStringField;
    mnugrdPayments: TAdvPopupMenu;
    mnuLoadFromLastTransactionForCustomer: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnAddDateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdPaymentsIButtonClick(Sender: TObject);
    procedure grdPaymentsDblClick(Sender: TObject);
    procedure NotesExit(Sender: TObject);
    procedure NotesEnter(Sender: TObject);
    procedure mnugrdPaymentsPopup(Sender: TObject);
    Procedure LoadFromLastTransactionForCustomer(Sender:TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fisaleID: Integer;
    function SaveRecord: Boolean;
    procedure InitforFC;
    Procedure UpdateFCHistoryCallback(const Sender: TBusObj;var Abort: boolean);
    procedure Chequedetails;
    function CustomerName: String;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure UnlockRelatedTables; Override;
    procedure CommitAndNotify;Override;
  public
    SplitPayment: TSplitPayments;
    Property saleID :Integer read fisaleID write fisaleID;
  end;


implementation

uses CommonLib, BusObjConst, frmPaymentsChequeDetails, DNMLib, AppEnvironment,
  BusObjSaleBase, tcConst, ForeignExchangeObj, tcDataUtils,
  DbSharedObjectsObj, CommonDbLib;

{$R *.dfm}

procedure TfmSplitInvoicePayment.btnAddDateClick(Sender: TObject);
begin
  inherited;
  AddDateTime(lcdOnLoganyway, Notes.text , False);
end;

procedure TfmSplitInvoicePayment.Chequedetails;
begin
    if Empty(SplitPayment.Lines.BankAccountName) and Empty(SplitPayment.Lines.BankAccountBSB) and Empty(SplitPayment.Lines.BankAccountNo) and Empty(SplitPayment.Lines.ReferenceNo) then begin
        SplitPayment.Lines.BankAccountName   := SplitPayment.saleObj.Customer.BankAccountName;
        SplitPayment.Lines.BankAccountBSB    := SplitPayment.saleObj.Customer.BankAccountBSB;
        SplitPayment.Lines.BankAccountNo     := SplitPayment.saleObj.Customer.BankAccountNo;
        SplitPayment.Lines.ReferenceNo      := '';
    end;

    with TPaymentChequeDetails.Create(self) do begin
        ClientID            := SplitPayment.saleObj.Customer.ID;
        ChequeBankAccountName:= SplitPayment.Lines.BankAccountName;
        ChequeBankAccountBSB := SplitPayment.Lines.BankAccountBSB;
        ChequeBankAccountNo  := SplitPayment.Lines.BankAccountNo;
        ChequeChequeNumber   := SplitPayment.Lines.ReferenceNo;
        if ShowModal = mrOk then SplitPayment.Lines.PostDB;
    end;
end;

procedure TfmSplitInvoicePayment.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmSplitInvoicePayment.SaveRecord :Boolean;
begin
  result:= False;
  SplitPayment.PostDB;
  if not(SplitPayment.Save) then exit;
  Result:= True;

end;

procedure TfmSplitInvoicePayment.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  if not SplitPayment.MakePayments then exit;
  CommitAndNotify;
  SplitPayment.dirty := false;
  Self.Close;
end;
procedure TfmSplitInvoicePayment.CommitAndNotify;
begin
  CommitTransaction;
  Notify;
end;
procedure TfmSplitInvoicePayment.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TSplitPayments     then TSplitPayments(Sender).Dataset      := QrySplitPayments
        else if Sender is TSplitPaymentLines then TSplitPaymentLines(Sender).Dataset  := QrySplitMaymentLines
        else if Sender is TSalesBase then TSalesBase(Sender).Dataset  := QrySales;
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_PayMethod ) then begin
      if sametext(SplitPayment.Lines.PayMethod , CHEQUE) then
        if not sametext(TSplitPaymentLines(Sender).cleanpaymethod , CHEQUE) then Chequedetails;

     end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusObjEventVal_OnAfterSave  ) then begin
      if  SplitPayment.HasanyFCLine then
        if AppEnv.CompanyPrefs.UseForeignCurrencyonSales then
          if MessageDlgXP_Vista('Do you want to update the rate in "Foreign Exchange Rate" list for the selected currencies ?', mtconfirmation, [mbYes, mbNo],0) = mrYes then
            SplitPayment.Lines.iteraterecords(UpdateFCHistoryCallback);
     end;
end;
procedure TfmSplitInvoicePayment.UnlockRelatedTables;
begin
  inherited;
  SplitPayment.saleobj.UnLock;
end;

procedure TfmSplitInvoicePayment.UpdateFCHistoryCallback(const Sender: TBusObj; var Abort: boolean);
var
    BuyRate, SellRate:Double;
begin
  if not(Sender is TSplitPaymentlines) then exit;
  if TSplitPaymentlines(Sender).Amount =  0 then exit;
  if TSplitPaymentlines(sender).deleted then exit;

  if (TSplitPaymentlines(sender).ForeignExchangeCode <> '')  and
              (TSplitPaymentlines(sender).ForeignExchangeCode <> AppEnv.RegionalOptions.ForeignExDefault) then begin
        With TForeignExchangeObj.Create do Try
            GetForeignExchangeRatesForDate(TSplitPaymentlines(sender).ForeignExchangeCode, SplitPayment.PaymentDate, BuyRate, SellRate);
            if TSplitPaymentlines(sender).ForeignExchangeRate <> SellRate then
                    AddForeignExchangeRateHistory(tcdatautils.getCurrencyID(TSplitPaymentlines(sender).ForeignExchangeCode),BuyRate, TSplitPaymentlines(sender).ForeignExchangeRate, SplitPayment.PaymentDate);
        finally
          Free;
        end;
  end;
end;

Procedure TfmSplitInvoicePayment.InitforFC;
const
  FCAmtEntry = 'ForeignCurrencyAmount'#9'20'#9'Foreign Amount';
var
  s:String;
begin
        s:= SplitPayment.foreignCurrencySymbol +'###,###,##,##0.'+ReplicateStr('0', CurrencyDecimalPlaces(SplitPayment.saleobj.ForeignExchangeCode));
        QrySalesForeignTotalAmount.DisplayFormat  := s;
        QrySalesForeignPaidAmount.DisplayFormat   := s;
        QrySalesForeignBalanceAmount.DisplayFormat:= s;

        pnlFC.Visible := not(sametext(QrysalesForeignExchangeCode.AsString , Appenv.RegionalOptions.ForeignExDefault));
        lblLocalcurency.Caption :=Appenv.RegionalOptions.ForeignExDefault;
        btnAddDate.Left := Notes.left + Notes.width - btnAddDate.width;
        QrySplitMaymentLinesAmount.DisplayLabel :='Amount in ' + Appenv.RegionalOptions.ForeignExDefault;

end;
procedure TfmSplitInvoicePayment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSplitInvoicePayment.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if SplitPayment.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          SplitPayment.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmSplitInvoicePayment.FormCreate(Sender: TObject);
begin
  inherited;
  {$WARNINGS OFF}
  SplitPayment := TSplitPayments.CreateWithNewConn(Self);
  SplitPayment.Connection.connection := Self.MyConnection;
  SplitPayment.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
  fbTabSettingEnabled := False;
  btnAddDate.Visible :=   not(UserPreferenceOn(lcdOnCustPayComments));
end;
procedure TfmSplitInvoicePayment.FormDestroy(Sender: TObject);
begin
  FreeandNil(SplitPayment);
  inherited;

end;

Function TfmSplitInvoicePayment.CustomerName:String;
var
  Qry : TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  With Qry do try
    closedb(qry);
    SQL.text := 'SELECT customerName FROM tblsales WHERE saleId = ' + inttostr(SaleID);
    opendb(Qry);
    qry.fieldbyname('customerName').asString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;
procedure TfmSplitInvoicePayment.LoadFromLastTransactionForCustomer(Sender:TObject);
var
  Qry : TERPQuery;
  ficlientID:Integer;
  fiSplitPaymentID :Integer;
begin
  Qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  With Qry do try

    {get list of paymethods of the same client}
    {clientId of the sale}
    closedb(qry);
    SQL.text := 'SELECT clientID FROM tblsales WHERE saleId = ' + inttostr(SaleID);
    opendb(Qry);
    ficlientID:= qry.fieldbyname('clientID').asInteger;

    {latest Splitpayment of the customer}
    closedb(qry);
    SQL.text := 'select Max(SplitPaymentID) as SplitPaymentID '+
                ' from tblsplitpayments  MSPL  '+
                ' INNER JOIN tblsales S ON MSPL.SaleID = S.saleID  '+
                ' AND s.clientId  ='+ inttostr(fiClientID);
    opendb(Qry);
    fiSplitPaymentID:= qry.fieldbyname('SplitPaymentID').asInteger;

    if fiSplitPaymentID =0 then exit;

    closedb(qry);
    SQL.text := 'select distinct SPL.Paymethod, SPL.foreignexchangecode  '+
                    ' from tblsplitpaymentlines SPL    '+
                    ' where ifnull(SPL.foreignexchangecode,"") = ' + Quotedstr(SplitPayment.saleobj.ForeignExchangeCode) +' and SPL.SplitPaymentID =' + inttostr(fiSplitPaymentID);
    open;
    if recordcount =0 then exit;
    First;
    while Eof = False do begin
      SplitPayment.Lines.New;
      SplitPayment.Lines.foreignexchangecode := fieldbyname('foreignexchangecode').asString;
      SplitPayment.Lines.paymethod := fieldbyname('Paymethod').asString;
      SplitPayment.Lines.PostDB;
      Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TfmSplitInvoicePayment.mnugrdPaymentsPopup(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmSplitInvoicePayment.NotesEnter(Sender: TObject);
begin
  inherited;
  with Notes do Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
end;

procedure TfmSplitInvoicePayment.NotesExit(Sender: TObject);
begin
  inherited;
    AddDateTime(lcdOnCustPayComments, Notes , False);
end;

procedure TfmSplitInvoicePayment.FormShow(Sender: TObject);
begin
  inherited;
  SplitPayment.Load(KeyID);
  SplitPayment.connection.BeginTransaction;

  openQueries;
  if accesslevel <= 3 then begin
    if SplitPayment.count=0 then begin
      SplitPayment.new;
      if saleId <> 0 then begin
        SplitPayment.saleId := saleId;
        SplitPayment.PostDB;
        SplitPayment.SaleObj;
      end;
    end;
    if SplitPayment.Lines.Count =0 then begin
      SplitPayment.Lines.New;
    end  else SplitPayment.Lines.First;
  end;
  SplitPayment.Lines;
  setcontrolfocus(grdPayments);
  grdPayments.SetActiveField(QrySplitMaymentLinesForeignCurrencyAmount.fieldname);
  mnuLoadFromLastTransactionForCustomer.caption :='Load From Last Transaction For '+CustomerName;
  if sametext(SplitPayment.Saleobj.ForeignExchangeCode , AppEnv.RegionalOptions.ForeignExDefault) then begin
    guiprefs.AddreadonlyField('ForeignExchangeRate', SplitPayment.Lines.dataset);
    guiprefs.AddreadonlyField('ForeignCurrencyAmount', SplitPayment.Lines.dataset);
    grdPayments.ColumnByName('ForeignExchangeRate').ReadOnly := true;
    grdPayments.ColumnByName('ForeignCurrencyAmount').ReadOnly := true;
    TimerMsg(lblMsg , 'Sales Currency is the Default Currecny (' + AppEnv.RegionalOptions.ForeignExDefault +'). Foreign Exchange Rate and Amount are Readonly');
  end;
  InitforFC;
  if accesslevel < 5 then
    if not SplitPayment.saleobj.Lock then Accesslevel := 5;
end;

procedure TfmSplitInvoicePayment.grdPaymentsDblClick(Sender: TObject);
begin
  inherited;
  if (grdPayments.GetActiveField = QrySplitMaymentLinesPayMethod) then
      if sametext(SplitPayment.Lines.PayMethod , CHEQUE) then
        chequedetails;
end;

procedure TfmSplitInvoicePayment.grdPaymentsIButtonClick(Sender: TObject);
begin
  inherited;
  SplitPayment.Lines.deleted := true;
  SplitPayment.Lines.postdb;
end;

initialization
  RegisterClassOnce(TfmSplitInvoicePayment);

end.

