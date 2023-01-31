unit CustomerPaymentExpressList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TCustomerPaymentExpressListGUI = class(TBaseListingGUI)
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    Label1: TLabel;
    cboCustomer: TwwDBLookupCombo;
    qryMainSaleID: TIntegerField;
    qryMainType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainBalance: TFloatField;
    qryMainAmountOutstanding: TFloatField;
    qryMainForeignTotalAmount: TFloatField;
    qryMainForeignBalanceAmount: TFloatField;
    qryMainForeignAmountOutstanding: TFloatField;
    qryMainForeignExchangeCode: TWideStringField;
    qryMainForeignExchangeRate: TFloatField;
    qryMainPaid: TWideStringField;
    qryMainRefNo: TWideStringField;
    btnMakePay: TDNMSpeedButton;
    qryMainDiscount: TLargeintField;
    qryMainWithholding: TLargeintField;
    qryMainRefunding: TLargeintField;
    qryMainRefundPercent: TLargeintField;
    qryMainApply: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cboCustomerCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure btnMakePayClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
  private
    fiClientId: Integer;
    fsSelectedFXCode:String;
    fbselectingall:Boolean;
    procedure SetClientId(const Value: Integer);
    procedure ApplyTransactionSelection(Sender: TObject);
    function SelectedFXCode: String;
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
    Property ClientId :Integer read fiClientId write SetClientId;
    Procedure selectall; Override;
  end;

implementation

uses CommonDbLib, PaymentsLib, CommonLib, CommonFormLib, frmCustPayments;

{$R *.dfm}

{ TCustomerPaymentExpressListGUI }

procedure TCustomerPaymentExpressListGUI.btnMakePayClick(Sender: TObject);
begin
  inherited;
  if  SelectedRecords =0 then begin
    MessageDlgXP_vista('Please Choose the Transactions to Pay', mtWarning, [mbOK], 0);
    Exit;
  end;
  OpenERPForm('TfmCustPayments', 0,ApplyTransactionSelection);
  closewait;
end;
procedure TCustomerPaymentExpressListGUI.ApplyTransactionSelection(Sender:TObject);
begin
  if Sender is TfmCustPayments then begin
    TfmCustPayments(Sender).CustPayment.GUIMode := False;
    try
      TfmCustPayments(Sender).ChooseCustomer(clientID, cboClientLookupCompany.asString);
      //TfmCustPayments(Sender).CustPayment.ClientID := clientID;
      TfmCustPayments(Sender).ChooseForeignExchangeCode(SelectedFXCode);
      //TfmCustPayments(Sender).CustPayment.ForeignExchangeCode := SelectedFXCode;
      TfmCustPayments(Sender).ApplyTransactionSelection(grdmain);
    finally
      TfmCustPayments(Sender).CustPayment.GUIMode := TRue;
    end;
  end;
end;
procedure TCustomerPaymentExpressListGUI.cboCustomerCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  clientId := cboClientLookupclientId.asInteger;
end;

procedure TCustomerPaymentExpressListGUI.FormCreate(Sender: TObject);
begin
  fbselectingall:=false;
  fiClientId:= 0;
  Paymentslib.SalesOutStandingTrans(qrymain,clientID);
  RefreshOrignalSQL;
  inherited;
  HaveDateRangeSelection := False;
  EnableMultiSelect('Choose Transactions to Pay and Choose "Make Pay"');
end;

procedure TCustomerPaymentExpressListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if selecting then begin
      if SelectedRecords >0 then begin
        fsSelectedFXCode :=SelectedFXCode;
          Accept := (qryMainForeignExchangeCode.asString = fsSelectedFXCode) or (fsSelectedFXCode ='');
          if not accept then
              ListTimerMsg('The First Selected Trasnaction is of ' + Quotedstr(fsSelectedFXCode)+' and can only choose Transactions of the same Currency');
      end;
  end;
end;
Function TCustomerPaymentExpressListGUI.SelectedFXCode:String;
var
  bm:TBookmark;
begin
  Result := '';
  if SelectedRecords =0 then exit;
  bm := QrymainBookmark(true);
  try
    qryMain.GotoBookmark(grdMain.SelectedList[0]);
    REsult := qryMainForeignExchangeCode.asString;
  finally
    QrymaingotoBookmarknFree(bm, true);
  end;
end;
procedure TCustomerPaymentExpressListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrymain.sql.text := replacestr(qrymain.sql.text , 'ORDER BY SaleDate DESC' , '');
end;

procedure TCustomerPaymentExpressListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if not cboClientLookup.active then begin
    cboClientLookup.connection := qrymain.connection;
    cboClientLookup.open;
  end;
  if GuiPrefs.Node.Exists('Options.clientID') then begin
    cboClientLookup.locate('ClientID' , GuiPrefs.Node['Options.clientID'].asInteger , []);
    clientId := cboClientLookupclientId.asInteger;
  end else begin
    cboClientLookup.First;
  end;
end;

procedure TCustomerPaymentExpressListGUI.RefreshQuery;
begin
  closedb(qrymain);
  Paymentslib.SalesOutStandingTrans(qrymain,clientID);
  qrymain.SQL.Text := ReplaceStr(qrymain.SQL.Text , 'ORDER BY SaleID', 'ORDER BY  SaleDate Desc');
  RefreshOrignalSQL(False);
  inherited;

end;

procedure TCustomerPaymentExpressListGUI.selectall;
begin
  //inherited;
  // disable all selection , as need to validate the foreign exchange rate and class id for the Payment
  if fbselectingall then exit;
  fbselectingall:=true;
  try
        fsSelectedFXCode := SelectedFXCode;
        if fsSelectedFXCode ='' then begin
          qrymain.first;
          fsSelectedFXCode := qryMainForeignExchangeCode.asString;
        end;
        if fsSelectedFXCode = '' then exit;

        iterateprocno := 1;
        IterateRecords(True, 'Choosing Transactions of Foreign Exchange Code ' + quotedstr(fsSelectedFXCode));
  finally
    fbselectingall:=false;
  end;
end;
procedure TCustomerPaymentExpressListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
  if iterateprocno = 1 then begin
    if sametext(fsSelectedFXCode , qryMainForeignExchangeCode.asString) then
      grdmain.selectRecord;
  end;
end;
procedure TCustomerPaymentExpressListGUI.SetClientId(const Value: Integer);
begin
  fiClientId := Value;
  if cboClientLookup.locate('clientID',value, []) then cboCustomer.text :=  cboClientLookupcompany.asString;
  RefreshQuery;
end;

procedure TCustomerPaymentExpressListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainDiscount.fieldname);
  RemoveFieldfromGrid(qryMainWithholding.fieldname);
  RemoveFieldfromGrid(qryMainRefunding.fieldname);
  RemoveFieldfromGrid(qryMainRefundPercent.fieldname);
  RemoveFieldfromGrid(qryMainForeignExchangeRate.fieldname);
  RemoveFieldfromGrid(qryMainGlobalRef.fieldname);
  RemoveFieldfromGrid(qryMainEnteredBy.fieldname);
  RemoveFieldfromGrid(qryMainTotalAmountInc.fieldname);
  RemoveFieldfromGrid(qryMainForeignTotalAmount.fieldname);
  RemoveFieldfromGrid(qryMainPaid.fieldname);
  RemoveFieldfromGrid(qryMainApply.fieldname);
end;

procedure TCustomerPaymentExpressListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.clientID'].asInteger := cboClientLookupclientId.asInteger;
end;
initialization
  RegisterClassOnce(TCustomerPaymentExpressListGUI);

end.
