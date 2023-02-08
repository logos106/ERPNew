{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/07/05  1.00.01 BJ    Bug fixed: when a sales order is created for a quote
                         'CopytoSalesOrder', is is marked to 'Converted'
                         The quote should be marked as 'converted' only after
                         making a sale.
 14/07/05  1.00.04 BJ    Bug Fixed :When sending an email, the subject is accepted from user, but
                         the email is send with the default subject. changed to use the accepted
                         Subject.
 20/07/05  1.00.05 DSP   Re-entered grdTransactions OnTitleButtonClick event
                         which was blank.
 28/07/05  1.00.06 IJB   Added code to unlock (UserLock) on conversion
                         to Invoice etc.
 19/10/05  1.00.08 DLS   Added RegisterClass

 09/12/05  1.10.00 IJB  Rewrite form to use new Business Objects.
 03/02/06  1.10.01 IJB  Re-arranged form layout to add "Ship To" so that TNT
                        rates work (needs ship to post code to calculate rates).
 09/02/06  1.10.02 DSP  Changed HiddenFields to HideField.
 14/02/06  1.10.03  AL  Added "frm.GetEquipments;" to actRepairUpdate, without it repairs form did not show products
 20/02/06  1.10.04 DSP  Added password to email authentication.
 22/02/06  1.10.05 DSP  The ClientID in tblMaster is now assigned in the
                        cboClientCloseUp method.
 21/04/06  1.10.06 DSP  Copy quote to sales order is now handled by business
                        objects.
 15/08/06  1.00.08 BJ  ValidateClosingDate function in the basetrans form locks the records prior to closingdate,
                       RA records should not be locked as it doesn;t affect the qty, so overiding not to lock.

}


unit frmQuote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Sales, DB, StdCtrls, wwcheckbox, wwdbdatetimepicker,
  wwdblook, DBCtrls, Mask, ExtCtrls, Buttons, DNMSpeedButton, DNMPanel,
  Grids, Wwdbigrd, Wwdbgrid, ActnList, MessageInterface,
  SelectionDialog, Menus, AdvMenus, {Psock,} ImgList, AppEvnts,
  wwdbedit,  MemDS, DBAccess, MyAccess,ERPdbComponents, DataState,
  BusObjBase,DMComps, MessageConst, BusObjSales, Shader,
  ComCtrls, ProgressDialog, ERPDbLookupCombo, DNMAction, busobjrelatedSales;

type
  TQuoteGUI = class(TBaseSaleGUI)
    btnConInvoice: TDNMSpeedButton;
    btnConCashSale: TDNMSpeedButton;
    actConInvoice: TAction;
    actConCashSale: TAction;
    btnConPOS: TDNMSpeedButton;
    actConPOS: TAction;
    Label2: TLabel;
    Label6: TLabel;
    btnConSalesOrder: TDNMSpeedButton;
    actConSalesOrd: TAction;
    btnConQuote: TDNMSpeedButton;
    actConQuote: TAction;
    qryStatusChecker: TERPQuery;
    btnRepair: TDNMSpeedButton;
    actRepair: TAction;
    tblDetailsLastUpdated: TDateTimeField;
    tblDetailsIsQuote: TWideStringField;
    Label9: TLabel;
    edtReference: TwwDBEdit;
    tblMasterReference: TWideStringField;
    qryContacts: TERPQuery;
    Bevel6: TBevel;
    tblDetailsWarrantyPeriod: TWideStringField;
    tblDetailsWarrantyEndsOn: TDateField;
    lblAmountToAppearOnPrintout: TLabel;
    txtTotalQuoteAmount: TDBEdit;
    Bevel3: TBevel;
    Label4: TLabel;
    btnVariation: TDNMSpeedButton;
    actVariation: TDNMAction;
    lblconvertedtoRepairs: TLabel;
    lblConverted: TLabel;
    Bevel1: TBevel;
    bvlForeign: TBevel;
    bvlVariation: TBevel;
    tblDetailsTreeFinalized: TWideStringField;
    ERPQuery1: TERPQuery;
    WideStringField1: TWideStringField;
    AutoIncField1: TAutoIncField;
    Label3: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    tblDetailsExcludeFromSmartOrder: TWideStringField;
    tblMasterAutoSmartOrderRef: TWideStringField;
    tblMasterPOCreated: TWideStringField;
    DNMPanel1: TDNMPanel;
    chkDone: TdbCheckBox;
    procedure btnCompletedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actConInvoiceExecute(Sender: TObject);
    procedure actConCashSaleExecute(Sender: TObject);
    procedure actConSmartExecute(Sender: TObject);
    procedure actConInvoiceUpdate(Sender: TObject);
    procedure actConCashSaleUpdate(Sender: TObject);
    procedure actConPOSUpdate(Sender: TObject);
    procedure actConPOSExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtTotalQuoteAmountExit(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure actConSalesOrdUpdate(Sender: TObject);
    procedure actConSalesOrdExecute(Sender: TObject);
    procedure cboAccountChange(Sender: TObject);
    procedure cboProductXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdFaxClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure actConQuoteExecute(Sender: TObject);
    procedure actConQuoteUpdate(Sender: TObject);
    procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtTotalQuoteAmountEnter(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnPrepaymentClick(Sender: TObject);
    procedure btnFreightTNTClick(Sender: TObject);
    procedure actRepairUpdate(Sender: TObject);
    procedure actRepairExecute(Sender: TObject);
    procedure txtCustomIDDblClick(Sender: TObject);
    procedure actVariationUpdate(Sender: TObject);
    procedure actVariationExecute(Sender: TObject);
    procedure mnuconvertedToListClick(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure cboClientRExit(Sender: TObject);
    procedure doShowPrepayments(Sender: TObject);Override;
  private
//    FEmailSender: T2cEmailSender;
    iCustomerID: integer;
    bInitialiseStartup: boolean;
    fStoredTotalQuoteAmount: double;
    QtychangedforDiscontProducts:Boolean;
    procedure SetFocusToTotalQuoteAmount(var Msg: TMessage); message WM_SetFocus;
    procedure UpdateButtonActions;

    procedure HandleQuoteErrors;
    (*function CheckStatus: boolean;*)
    function SaleLineIdfilter:String;
    function ToBeApprovedNApproved(ConvertingTo:String): Boolean;
    Function ValidateForDiscontinuedProducts :Boolean;
    Procedure ValidateForDiscontinuedProductsCallback(Const Sender: TBusObj; var Abort: boolean);
    procedure initConvertingFromRef(Sender: TObject);
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintEmailSilent: boolean;
  protected
    function EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;Override;
    function GetReportTypeID: integer; override;
    procedure IsOK_to_Print(var IsOk: boolean); override;
    function ValidateClosingDate(const TransDate: TDateTime): Boolean; override;
    procedure   DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    function HasAssociatedrecords: boolean;Override;
    procedure CommitAndNotify;override;
    procedure Lockcomponents;override;
    procedure NewTransBusObjinstance;override;
    procedure SetDirty(ADirty : boolean);override;
    function Save4NewTrans: Boolean;Override;
  public
    Quote: TQuote;
    property CustomerID: integer read iCustomerID write iCustomerID;
    property InitialiseStartup: boolean read bInitialiseStartup write bInitialiseStartup;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
    function SaveSalesRecord: boolean;Override;
    procedure DoOnClientchange; override;
    //procedure SendEmailCallback(const ACommaContactEmails : string; ASilent, ASecret : boolean); override;
  published
    function InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
  end;

implementation

{$R *.dfm}
uses
  FormFactory, frmCashSale, frmSmartOrderFrm, POSScreenGUI,
  CommonDbLib,  DNMExceptions, frmSalesOrder, FaxObj,
  frmCustomerFrm, EmailExtraUtils,
   BusObjConst, CommonLib,  BaseInputForm,
  DateUtils, frmInvoice, AppEnvironment,BusObjSimpleTypes,
  FastFuncs, tcDataUtils, DNMLib, tcConst, busobjrepairs, BusobjSaleBase, tcTypes,
  CommonFormLib, QuoteConvertedSalesList, BusObjAudit, MySQLConst,
  frmReportingOptions, LogLib, CorrespondenceObj, EmailUtils,
  BusObjFeTransLines;

procedure TQuoteGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;

  try
    if SaveSalesRecord then begin
      CommitAndNotify;
      Close;
    end;
  finally
    EnableForm;
  end;
end;

function TQuoteGUI.SaleLineIdfilter: String;
var
  st:TStringList;
  ctr:Integer;
begin
  st:= tStringlist.create;
  try
    SelectedIds(grdtransactions , 'SaleLineID' , st );
    result :='';
    for ctr := 0 to st.count-1 do begin
      if result <> '' then result := result +' OR ';
      result := result +' saleLineid = ' + st[ctr];
    end;
  finally
    Freeandnil(st);
  end;
end;

procedure TQuoteGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TQuoteGUI.cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  Accept := false;
end;

procedure TQuoteGUI.actConInvoiceUpdate(Sender: TObject);
begin
  if not tblDetails.Active then Exit;
  actConInvoice.Enabled := (tblDetails.RecordCount > 0) and not (AccessLevel in [3, 5]) and (KeyID <> 0) and (Quote.RepairID = 0);
end;

procedure TQuoteGUI.actConCashSaleUpdate(Sender: TObject);
begin
  if not tblDetails.Active then Exit;
  actConCashSale.Enabled := (tblDetails.RecordCount > 0) and not (AccessLevel in [3, 5]) and (KeyID <> 0) and (Quote.repairId =0);
end;

procedure TQuoteGUI.actConCashSaleExecute(Sender: TObject);
var
  iNewID: integer;
  strMsg: string;
  frm: TCashSaleGUI;
begin
  DisableForm;
  try
    if not SaveSalesRecord then Exit;

    if not (ValidateForDiscontinuedProducts) then exit;

    if FormStillOpen('TfrmCustomer') then begin
      TfrmCustomer(FindExistingComponent('TfrmCustomer')).CloseMe;
      Application.ProcessMessages;
    end;

    if Quote.Converted then strMsg := 'Invoice/Cash Sale/Sales Order is already created for this Quote. Do you wish to create another Cash Sale for it?'
    else strMsg := 'Do you wish to Convert this Quote to a Cash Sale?';
    if CommonLib.MessageDlgXP_Vista(strMsg , mtconfirmation , [mbYes,mbNo], 0) = mrNo then  Exit;
    Quote.Connection.BeginTransaction;
    iNewID := Quote.CopyQuoteToCashSale;

    if iNewID > 0 then begin
      NewAuditTrialentry('Cash Sale Created');
          Quote.Save;
          Quote.ResultStatus.Clear;
          Quote.Connection.CommitTransaction;
          DEtachAll;
          Notify;
          frm := TCashSaleGUI(GetComponentByClassName('TCashSaleGUI'));

          if Assigned(frm) then begin
            frm.KeyID := iNewID;
            frm.FormStyle := fsMDIChild;
            frm.BringToFront;
          end;

          Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.actVariationExecute(Sender: TObject);
var
  iNewID: integer;
  strMsg: string;
  //fsFilter:String;
  MsgOption :  Word;
  s:String;
begin
  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    strMsg:='';

         if (tblDetails.RecordCount = 0)      then strMsg := 'Please Select the Products before Variation'
    else if (Quote.SalesStatus = 'Approved')  then strMsg := 'The Quote is Approved. Variations cannot be Made to Approved Quote. Please convert to Sales Order'
    else if Quote.QuoteVaried                 then strMsg := 'This Quote is already Varied'
    else if Quote.Converted                   then strMsg := 'This Quote is already Converted'
    else if (AccessLevel <>1)                 then strMsg := 'You don''t Have Rights To Vary a Quote';

    if strMsg <> '' then begin
      MessageDlgXP_Vista( strMsg, mtWarning, [mbOk] , 0);
      Exit;
    end;

  if IsclientRelatedParent(Quote.ClientID) then begin
        MessageDlgXP_Vista( 'Customer of Quote#' +inttostr(Quote.ID) +'[' +Quote.customername +'] '+
                        'is a Parent Client for Related Clients.  '+
                        'It is not Possible to Make Variation Quotes for Parent Customers'  , mtWarning, [mbOk] , 0);
        Exit;
  end ;
  if not(IsclientRelated(Quote.ClientID)) then begin
    if MessageDlgXP_Vista('Customer of '+Salebase.XMLNodename +' #' +inttostr(Salebase.ID) +' "' +Trim(Salebase.customername) +'" is not a Related Customer.  '+
                          'The Customer Has to be a Related Customer to Make Variation Quote.' +chr(13) +chr(13) +
                          'Do you wish to Select the Parent Customer for "' +Salebase.Customername +'"?' , mtconfirmation , [mbyes,mbno] ,0) = mrYes then begin
        AddRelatedclient;
        Exit;
    end else exit;
  end;
    if grdTransactions.SelectedList.count =0 then begin
      MsgOption := MessageDlgXP_Vista( 'Please select which lines you wish to copy by holding down the "Ctrl" Key and Clicking on the Lines with your mouse or Do You Wish to Copy All?', mtconfirmation, [] , 0 , nil , '' , '' , False , nil, 'All, Cancel');
      if MsgOption = 100 then grdTransactions.SelectAll;
    end else if grdTransactions.SelectedList.count =1 then begin
      MsgOption := MessageDlgXP_Vista( 'You have Selected 1 Line to copy into the Varied Quote.' +chr(13) +
                    'You can select the lines you wish to copy by holding down the "Ctrl" Key and Clicking on the Lines with your mouse.' +chr(13) +chr(13) +
                  'Do You Wish to create the ''Variation Quote'' with the ''Single Line Selected'' or ''Select All Lines''?' , mtconfirmation, [] , 0 , nil , '' , '' ,
                              False , nil, 'Create Variation With the Selected Line,Create Variation With All Lines, Cancel');
      if MsgOption = 100 then
      else if MsgOption = 101 then grdTransactions.SelectAll
      else if MsgOption = 102 then grdTransactions.unSelectAll;
    end;
    Quote.connection.CommitTransaction;
    Quote.Connection.BeginTransaction;
    if grdTransactions.SelectedList.Count = 0 then
      exit;
    ProcessingCursor;
    Try
      iNewID := Quote.MakeVariation(SaleLineIdfilter);
      (*fsfilter := quote.lines.dataset.filter;
      if quote.lines.dataset.filter <> '' then quote.lines.dataset.filter := '(' +quote.lines.dataset.filter +' ) and (' +SaleLineIdfilter+')'
      else quote.lines.dataset.filter := SaleLineIdfilter;
      quote.lines.dataset.filtered := TRue;
      try
      iNewID := Quote.MakeVariation;
      finally
        quote.lines.dataset.filter := fsfilter;
        quote.lines.dataset.filtered := quote.lines.dataset.filter<>'';
      end;*)

      if iNewID > 0 then begin
          NewAuditTrialentry('Varied to :' + inttostr(iNewId) + '(Globalref :' + TQuote.IDToggle(iNewId)+')');
          CommitTransaction;
          s:= 'Varied From :' + inttostr(Quote.ID) + '(Globalref :' + Quote.globalref+')';
          Quote.CloseDB;
          Quote.load(iNewId);
          closeDB(QryTransStatus);
          opendb(QryTransStatus);
          NewAuditTrialentry(s);
          Begintransaction;
        end;
    Finally
        ProcessingCursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.actVariationUpdate(Sender: TObject);
begin
  inherited;
  bvlVariation.hint := 'Make a Variation';
  if actVariation.visible then begin
    actVariation.Enabled := (tblDetails.RecordCount > 0) and (AccessLevel =1) and (KeyID <> 0) and (Quote.SalesStatus <> 'Approved') and (not(Quote.QuoteVaried));
    if not(actVariation.Enabled) then begin
           if (tblDetails.RecordCount = 0)      then bvlVariation.hint  := 'Please Select the Products before Variation'
      else if (Quote.SalesStatus = 'Approved')  then bvlVariation.hint  := 'The Quote is Approved. Variations cannot be Made to Approved Quote. Please Convert to Sales Order'
      else if Quote.QuoteVaried                 then bvlVariation.hint  := 'This Quote is already Varied'
      else if Quote.Converted                   then bvlVariation.hint  := 'This Quote is already Converted'
      else if KeyID =0                          then bvlVariation.hint  := 'Please Save the Quote'
      else if (AccessLevel <>1)                 then bvlVariation.hint  := 'You don''t Have Rights To Vary a Quote';
    end;
  end;
end;

procedure TQuoteGUI.actConSmartExecute(Sender: TObject);
begin
  inherited;
(*var
  iNewID: integer;
  Frm: TSmartOrderGUI;
begin
  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    CommitAndNotify;

    if not IsOkToCopyToSMart then exit;

    if not ConfirmForPOcost then exit;
    Quote.LineIdToconvert (SelectedLineIds);
    try
      iNewId                  := Quote.CopyQuoteToSmartOrder;
    finally
      Quote.CleanLineIdsToconvert;
    end;
    Frm                     := TSmartOrderGUI(GetComponentByClassName('TSmartOrderGUI'));
    Frm.KeyId               := iNewID;
    Frm.FormStyle           := fsMDIChild;
    Frm.BringToFront;
    Frm.POIDs               := Quote.POIDs;
    NewAuditTrialentry('Smart Order Created');
    Self.close;
  finally
    EnableForm;
  end;*)
end;

function TQuoteGUI.GetReportTypeID: integer;
begin
  Result := 20;
end;

procedure TQuoteGUI.actConPOSUpdate(Sender: TObject);
begin
  inherited;
  actConPOS.Enabled := (tblDetails.RecordCount > 0) and not (AccessLevel in [3, 5]) and (KeyID <> 0) and (Quote.RepairID=0);
end;

procedure TQuoteGUI.actConPOSExecute(Sender: TObject);
var
  bOk: boolean;
  Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if not SaveSalesRecord then Exit;

    if not (ValidateForDiscontinuedProducts) then exit;

    bOK := true;
    if quote.HasbinBatchProductSrProduct then begin
      CommonLib.MessageDlgXP_Vista('This Quote got Bin/Batch Product.' + chr(13) + chr(13)+
              'Cannot be sold from POS. Please create a Cashsale/Invoice', mtWarning, [mbOk] , 0);
      Exit;
    end;
    if CommonLib.MessageDlgXP_Vista('Are you sure you want to convert this Quote to a POS ' +
      #13 + #10 + 'transaction?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      if FormStillOpen('TPOSScreenForm') then begin
        if not TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).bTransComplete then begin
          CommonLib.MessageDlgXP_Vista('POS is currently in a transaction, ' +
            'wait until the POS transaction ' + #13 + #10 + 'is complete',
            mtWarning, [mbOK], 0);
          bOK := false;
        end;
      end;

      if bOK then begin
        try
          if not FormStillOpen('TPOSScreenForm') then begin  // start up POS
            Form := GetComponentByClassName('TPOSScreenForm');
            if Assigned(Form) then begin //if has acess
              with TForm(Form) do begin
                FormStyle := fsmdiChild;
                BringToFront;
              end;
            end;
          end else begin
            with TForm(FindExistingComponent('TPOSScreenForm')) do begin
              Show;
              BringToFront;
            end;
          end;

         if FormStillOpen('TPOSScreenForm') then TPOSScreenForm(FindExistingComponent('TPOSScreenForm')).QuoteID := tblMaster.FieldByName('SaleID').AsInteger;
          NewAuditTrialentry('POS Created');
          DEtachAll;
          CommitAndNotify;

          Self.Close;
        except
          on EAbort do HandleEAbortException;
          on e: Exception do else raise;
        end;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.FormShow(Sender: TObject);
var
  qryEmailedList: TERPQuery;
begin
stepProgressbar;
try

  DisableForm;
  try
    try
      inherited;
      mnuconvertedToList.Enabled := Quote.Converted;
      lblAccount.Visible   := false;
      cboAccount.Visible   := false;

      bIsFreezeQuoteAmount :=
        tblMaster.FieldByName('FreezeQuoteAmount').AsBoolean;
      if KeyID <> 0 then begin
        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Options.FlatBuffers := True;
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('SELECT * FROM tblEmailedReports WHERE  reporttype = "Quote" and TransactionID = ');
          qryEmailedList.Sql.Add(IntToStr(KeyID));

          qryEmailedList.Open;

          if qryEmailedList.FieldByName('ContactID').asinteger <> 0 then begin
            EmailContactID := qryEmailedList.FieldByName('ContactID').asinteger;
          end;
        finally
          FreeAndNil(qryEmailedList);
        end;

        // ReCalc tots for 'margin' update
      end else begin
        Quote.SalesStatus := tcDataUtils.GetSimpleTypeDefaultStr('LeadStatusType');
      end;

      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowMargin') =
        ACCESS_ALLOWED then begin

        lblMargin.Visible := true;
        lblMarginLabel.Visible := true;
        lblCost.Visible := true;
        lblCostLabel.Visible := true;
      end
      else begin
        lblMargin.Visible := false;
        lblMarginLabel.Visible := false;
        lblCost.Visible := false;
        lblCostLabel.Visible := false;
      end;


      btnConInvoice.Enabled    := not fbPaymentLock;
      btnConCashSale.Enabled   := not fbPaymentLock;
      btnConSmart.Enabled      := not fbPaymentLock;
      btnConPOS.Enabled        := not fbPaymentLock;
      btnConSalesOrder.Enabled := not fbPaymentLock;

      txtTotalQuoteAmount.Visible := AppEnv.CompanyPrefs.ShowAmountToAppearOnPrintout;
      lblAmountToAppearOnPrintout.Visible := AppEnv.CompanyPrefs.ShowAmountToAppearOnPrintout;

      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnQuoteToInvoice') <> 1 then begin
        btnConInvoice.Enabled := false;
      end else begin
        btnConInvoice.Enabled := (not fbPaymentLock and true);
      end;

      // Are we opening up with given parameters?
      if InitialiseStartup then begin
        tblMaster.Edit;
        tblMaster.FieldByName('CustomerName').AsString :=
          GetClientName(CustomerID);
        tblMaster.FieldByName('ClientID').AsInteger := CustomerID;
        cboClientR.SearchMode := TERPLookupComboSearchMode.smStartsWith;
        cboClientR.Text := GetClientName(CustomerID);
        cboClientR.F6Search;
        cboClientR.LookupTable.Locate('ClientID', CustomerID, []);
        tblMaster.Post;
        tblMaster.Edit;

        InitialiseStartup := False;
      end;
      actVariation.visible := appenv.companyPrefs.EnablequoteVariation;
      bvlVariation.visible := appenv.companyPrefs.EnablequoteVariation;


      grdTransactions.ColumnByName('Discounts').DisplayLabel := 'Discount ('+AppEnv.RegionalOptions.CurrencySymbol+')';
      UpdateButtonActions;
      Quote.Dirty := false;
      btnRepair.enabled :=Quote.RepairID= 0;
      closeDB(QryTransStatus);
      opendb(QryTransStatus);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;

  finally
    EnableForm;
  end;
finally
  CheckshiptoAccess;
  Enabledisable;
  hideProgressbar;
  ShowGridLockMsg;
  hideProgressbar;
  Lockcomponents;
end;
end;

procedure TQuoteGUI.txtTotalQuoteAmountExit(Sender: TObject);
begin
  inherited;
  if tblMaster.FieldByName('TotalQuoteAmount').AsFloat <> fStoredTotalQuoteAmount then begin
    bIsFreezeQuoteAmount := true;
    tblMaster.FieldByName('FreezeQuoteAmount').AsBoolean := true;
  end;
end;

procedure TQuoteGUI.actPreviewExecute(Sender: TObject);
begin
  if not SaveSalesRecord then Exit;

  DisableForm;
  try
    ReportToPrint := '';
    //if not SaveSalesRecord then Exit;
    CommitAndNotify;
    Try
      fbReportSQLSupplied :=   False;
      inherited;
      (*if AppEnv.Employee.CloseOnPrint then Close;*)
//      closeAfterPrint;
    except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
        end;
      end;
  finally
    self.BeginTransaction;
    EnableForm;
  end;
end;

procedure TQuoteGUI.actPrintExecute(Sender: TObject);
begin
  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    Self.CommitAndNotify;
    try

      inherited;

    except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Print failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
    end;
  finally
    EnableForm;
  end;
end;

Function  TQuoteGUI.Save4NewTrans:Boolean;
begin
  result := False;
  DisableForm;
  try
    // If user does not have access to this form don't process any further
    if ErrorOccurred then Exit;

    if Quote.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if SaveSalesRecord then begin
              CommitAndNotify;
              result := true;
            end;
          end;
        mrNo:
          begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
            result := True;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end else begin
      REsult := True;
    end;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.actConSalesOrdUpdate(Sender: TObject);
begin
  inherited;
  actConSalesOrd.Enabled := (tblDetails.RecordCount > 0) and not (AccessLevel in [3, 5]) and (KeyID <> 0) and (Quote.repairID = 0);
end;
procedure TQuoteGUI.actConSalesOrdExecute(Sender: TObject);
var

  iNewID: integer;
  strMsg: string;
  SalesOrder: TSalesOrderGUI;
  NewSmartOrderID: integer;

begin
  DisableForm;
  try
    if not SaveSalesRecord then
      Exit;

    if Quote.Customer.StopCredit and AppEnv.CompanyPrefs.PreventSalesOrderOnStopCredit then begin
        MessageDlgXP_Vista('This Customer is on Stop Credit so it is not possible to convert this Quote to a Sales Order for this customer.', mtWarning, [mbOK], 0);
        exit;
    end;


    if not ToBeApprovedNApproved('SalesOrder') then Exit;

    if not (ValidateForDiscontinuedProducts) then exit;

    NewSmartOrderID:= 0;
    if FormStillOpen('TfrmCustomer') then begin
      TfrmCustomer(FindExistingComponent('TfrmCustomer')).CloseMe;
      Application.ProcessMessages;
    end;

    if Quote.Converted then
      strMsg := 'Invoice/Cash Sale/Sales Order is already created for this Quote. Do you wish to create another Sales Order for it?'
    else
      strMsg := 'Do you wish to Convert this Quote to a Sales Order?';

    if CommonLib.MessageDlgXP_Vista(strMsg , mtconfirmation , [mbYes,mbNo], 0) = mrNo then
      Exit;

    { TODO -oIan Blakeley : Fix this so it does not pop up the form for manufactued products }

    // We need to check inventory contents
    // of what we have here on quote.
    cboClassQry.Locate('ClassName' , Quote.SaleClassName, []);
    if Quote.HasNonTreeLines and ((AppEnv.Employee.CanAutoCreateSmartOrders) or (AppEnv.Employee.OverrideAutoSmartOrders) or
       (cboClassQry.FieldByName('AutoCreateSmartOrders').AsString = 'T')) then begin
      if ShowInvVerify(true ,  NewSmartOrderID) = False then exit;
    end;

    Quote.Connection.BeginTransaction;
    iNewID := Quote.CopyQuoteToSalesOrder;

    if iNewID > 0 then begin
      NewAuditTrialentry('Sales Order Created');
      SalesOrder := TSalesOrderGUI(GetComponentByClassName('TSalesOrderGUI'));

      Quote.Save;
      Quote.ResultStatus.Clear;
      Quote.Connection.CommitTransaction;
      DEtachAll;
      Notify;

      {  we need to update the newly created smat order with the SO ID and GlobalRef}
      if NewSmartOrderID>0 then begin
        OpenSmartOrder(NewSmartOrderID, inewID, TSalesOrder.IDGlobalRefToggle(iNewID));
      end;


      if Assigned(SalesOrder) then begin

        SalesOrder.KeyID := iNewID;
        SalesOrder.FormStyle := fsMDIChild;
        SalesOrder.BringToFront;
      end;

      Close;
    end;
  finally
    EnableForm;
  end;
end;
Function TQuoteGUI.ToBeApprovedNApproved(ConvertingTo:String):Boolean;
begin
  if (SameText(ConvertingTo , 'Invoice')) then
    if  (Appenv.Companyprefs.StatustoMakeInvoice<> '') then
      if not (SameText(Appenv.Companyprefs.StatustoMakeInvoice ,Quote.SalesStatus)) then begin
          MessageDlgXP_Vista('Quote can be Converted to Invoice Only When Status is ' + Quotedstr(Appenv.Companyprefs.StatustoMakeInvoice)+'.', mtWarning , [mbok], 0) ;
          SetcontrolFocus(cboCurrentTransStatus);
          REsult := False;
          Exit;
      end;
  if (SameText(ConvertingTo , 'SalesOrder')) then
    if  (Appenv.Companyprefs.StatusToMakeSalesOrder<> '') then
      if not (SameText(Appenv.Companyprefs.StatusToMakeSalesOrder ,Quote.SalesStatus)) then begin
          MessageDlgXP_Vista('Quote can be Converted to Sales Order Only When Status is ' + Quotedstr(Appenv.Companyprefs.StatusToMakeSalesOrder)+'.', mtWarning , [mbok], 0) ;
          SetcontrolFocus(cboCurrentTransStatus);
          REsult := False;
          Exit;
      end;
  REsult := true;

  (* if Appenv.CompanyPrefs.enableQuoteVariation then
        if Quote.SalesStatus <> 'Approved' then begin
          MessageDlgXP_Vista('Quote can be Converted Only After Approval(Status).', mtWarning , [mbok], 0) ;
          REsult := False;
        end; *)
end;

procedure TQuoteGUI.actConInvoiceExecute(Sender: TObject);
var
  iNewID: integer;
  strMsg: string;
  frm: TInvoiceGUI;
begin
  DisableForm;
  try
    if not SaveSalesRecord then Exit;

    if Quote.Customer.StopCredit and AppEnv.CompanyPrefs.PreventInvoiceOnStopCredit then begin
        MessageDlgXP_Vista('This Customer is on Stop Credit so it is not possible to convert this Quote to an Invoice for this customer.', mtWarning, [mbOK], 0);
      Exit;
    end;

    if not (ValidateForDiscontinuedProducts) then Exit;

    if not ToBeApprovedNApproved('Invoice') then Exit;

    if FormStillOpen('TfrmCustomer') then begin
      TfrmCustomer(FindExistingComponent('TfrmCustomer')).CloseMe;
      Application.ProcessMessages;
    end;

    if Quote.Converted then strMsg := 'Invoice/Cash Sale/Sales Order is already created for this Quote. Do you wish to create another Invoice for it?'
    else strMsg := 'Do you wish to Convert this Quote to an Invoice?';
    if CommonLib.MessageDlgXP_Vista(strMsg, mtconfirmation, [mbYes,mbNo], 0) = mrNo then  Exit;

    Quote.Connection.BeginTransaction;
    iNewID := Quote.CopyQuoteToInvoice;

    if iNewID > 0 then begin
      NewAuditTrialentry('Invoice Created');
      Quote.Save;
      Quote.ResultStatus.Clear;
      Quote.Connection.CommitTransaction;
      DetachAll;
      Notify;
      frm := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));

      if Assigned(frm) then begin
        frm.KeyID := iNewID;
        frm.FormStyle := fsMDIChild;
        frm.BringToFront;
      end;

      Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.cboAccountChange(Sender: TObject);
begin
  inherited;
  cboAccount.Visible := false;
end;

procedure TQuoteGUI.cboClientRExit(Sender: TObject);
begin
  inherited;
  logtext(cboClientR.text);
  logtext(cboClientR.Datasource.DataSet.FieldByName(cboClientR.DataField).AsString);
end;

procedure TQuoteGUI.cboProductXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
 (*  if (modified = false) then Exit;
  if Matrixshown then exit;

  inherited;
  if Quote.Lines.ProductName = '' then Exit;
  tblDetails.Edit;
  tblDetailsUnitofMeasureQtySold.AsFloat := 1; *)
end;

function TQuoteGUI.EmailTransaction(const RecipientAddress :String ='';ASilent: boolean=True; ASecret : boolean=True): boolean;
var
  (*RecipientAddress, *)ReportType, OutGoingFileName: string;
  //RepAddress: string;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  IsOK: boolean;
  intResult: integer;
  strResult: string;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  Recipients: string;
begin
  result := False;
  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    Self.CommitAndNotify;
    try
      ReportToPrint := '';
      strResult := '';
      // Clear all previous params/data
      //RecipientAddress := '';
      //RepAddress := '';
      ReportType := '';
      OutGoingFileName := '';
      Recipients := GetContactEmails(tblMaster.FieldByName('ClientID').AsInteger, 'MainContactForQuote');
      if RecipientAddress <> '' then
        Recipients := AddEmailToList(RecipientAddress, RecipientAddress);
      //RepAddress := GetSalesCCAddresses(tblMaster.FieldByName('EmployeeID').AsInteger);
      //ASecret := false;
      //ASilent := true;
      if Recipients = '' then
        if AppEnv.CompanyPrefs.UseDefaultMailClient then
        begin
          if CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('CustomerName').AsString + ' does not have an email address.' + #13 + #10 +
            'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
          ASilent := false;
        end else begin
          if CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('CustomerName').AsString +
            ' does not have an email address to send to.' + #13 + #10 + #13 + #10 +
            'Do you wish to load the email program anyway?', mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
          ASilent := False;
        end;

      ReportType := 'Quote';
      // String defined here because it is easy to change when this code is applied to
      // other forms. (ie, Quote instead of Invoice etc)

      // Ask the user if they want to specify a new subject
      intResult := CommonLib.MessageDlgXP_Vista('You are about to Email this ' + ReportType + ' to ' +
        tblMaster.FieldByName('CustomerName').AsString + '.' + #13 + #10 + #13 + #10 +
        'Would you like to specify a subject for this email?' + #13 + #10 + #13 + #10 +
        'Please select Yes to enter new email subject line. No to use standard subject line.', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);

      if intResult = mrYes then begin
        strResult := InputBox('SUBJECT DECLARATION', 'Please specify subject for this email',
          ReportType + ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString +
          ' for ' + tblMaster.FieldByName('CustomerName').AsString);
      end else if intResult = mrNo then begin
        strResult := '';
      end else begin
        Exit;
      end;

      try
        lblEmail.Visible := true;
        lblEmailMsg.Caption := 'Emailing, ' + WAITMSG;

        // TURN OFF BUTTONS WHILE EMAIL IS BEING SENT
//        btnNext.Enabled := false;
//        btnCompleted.Enabled := false;
//        btnClose.Enabled := false;
//        btnPreview.Enabled := false;
//        btnPrint.Enabled := false;
//        cmdPrintPick.Enabled := false;
//        cmdDeliveryDocket.Enabled := false;
//        cmdEmail.Enabled := false;

        IsOK_to_Print(IsOK); //Silent Save
        if IsOK then begin
          Self.CommitAndNotify;
          inherited;
        end;

        LoadTemplate(true, true);

        Corres := TCorrespondenceGui.Create;
        try
          Corres.CorrespondenceType := ctEmail;
          Corres.DeleteAttachments := true;
          if strResult = '' then Corres.Subject := ReportType +
              ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString + ' for ' + tblMaster.FieldByName('CustomerName').AsString
          else Corres.Subject := strResult ;
          // Corres.RecipientList := RecipientAddress;
          Corres.RecipientList := Recipients;
(*          if RepAddress <> '' then
            Corres.CCList := RepAddress;*)
          Corres.CCList := GetSalesEmails;
          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

          OutGoingFileName := getOutGoingFileName('',' ' + ReportType + ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString, '.PDF');

          if not FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin;
            CommonLib.MessageDlgXP_Vista('Attachment could not be found. This is probably caused by a problem with the template. Please check the template and try again.', mtInformation , [mbOK], 0);
          end;
          if FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin;
            if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin;
              copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
                PChar( Commonlib.TempDir  + OutGoingFileName), false);
            end;
          end;
          Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
          CheckForMailAttachments(Corres);
          ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
          if ASilent and not ASecret then
            if not EmailShortSendMode(ASilent, ASecret) then
              exit;

          result := Corres.Execute(ASilent, ASecret);
        finally
          Corres.Free;
        end;

        lblEmail.Visible := false;

        TransactionID := tblMaster.FieldByName('InvoiceDocNumber').AsString;
        UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
        EmailDate := Now;

        // ReportType already defined at start of procedure
        TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' +
          tblMaster.FieldByName('InvoiceDocNumber').AsString + ' for ' + tblMaster.FieldByName('CustomerName').AsString;

        qryEmailedList := TERPQuery.Create(nil);
        qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
        try
          qryEmailedList.Sql.Clear;
          qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType,');
          qryEmailedList.SQL.Add(' TransactionDescription,ContactID,EmailAddressUsed) Values ("' +
            TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
            EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +  '", "' + IntToStr(EmailContactID) +
            '", "' + RecipientAddress + '")');
          qryEmailedList.Execute;

        finally
          FreeandNil(qryEmailedList);
        end;
      except
        lblEmail.Visible := false;
        CommonLib.MessageDlgXP_Vista('There was an error sending email', mtWarning, [mbOK], 0);

      end;
    finally
      LogEmailed(result , ReportType);
      self.BeginTransaction;
      ReportToPrint := '';
    end;
  finally
    EnableForm;
  end;
end;

function TQuoteGUI.ValidateClosingDate(const TransDate: TDateTime): Boolean;
begin
// as the qty or cost is not involved , don;t lock the record
  Result := False;
end;

function TQuoteGUI.ValidateForDiscontinuedProducts: Boolean;
begin
  QtychangedforDiscontProducts := False;
  Quote.Lines.IterateRecords(ValidateForDiscontinuedProductsCallback);
  if not QtychangedforDiscontProducts then
    Result := true
  else
    Result := MessageDlgXP_Vista('Quantity has been Changed for the Discontinued Products. Are you sure you want to save this quote and convert? ', mtConfirmation, [mbYes, mbNo], 0) = mryes;
end;

procedure TQuoteGUI.ValidateForDiscontinuedProductsCallback(const Sender: TBusObj; var Abort: boolean);
var
  Msg:String;
begin
  if (not(Sender is TQuoteLine)) or
      (not(IsInvProduct(TQuoteLine(Sender).Product.Producttype))) or {non inv product is ok}
      (TQuoteLine(Sender).QtyShipped <=0) or {no qty or -ive qty}
      (TQuoteLine(Sender).Product.IsDiscontinued =False) then {Product not discontinued}
      exit;
  if TQuoteLine(Sender).ISPartDiscontinuednQtynotEnough then begin
    QtychangedforDiscontProducts := TRue;
    msg := 'The Product ' + Salebase.Lines.Product.ProductName + ' Has Been Discontinued  and Can Only Sell the Available Quantity!'
                  + NL + NL +'Currently There is ' +  FloatToStr(Salebase.Lines.UOMQtyShipped) ;
            if Salebase.Lines.UOMMultiplier <> 1 then Msg := msg + ' ' + Salebase.Lines.UnitOfMeasure+'(' + FloatTostr(Salebase.Lines.UOMMultiplier)+') = ' + floatToStr(Salebase.Lines.QtyShipped) + ' ' +AppEnv.DefaultClass.DefaultUOM;
            Msg := msg + ' Available.';
            Msg := msg + NL + NL +'Do you wish To Select Another Product From the Alternate Product list of ' + Salebase.Lines.ProductName +
                          ' for the remaining Quanityt of '+ FloatToStr(Salebase.Lines.QtyrequiredforAlternateProduct);

    if MessageDlgXP_Vista(msg,mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      OpenAlternateProductListtoReplace;
  end;
end;

procedure TQuoteGUI.IsOK_to_Print(var IsOk: boolean);
begin
  IsOk := false;
end;

procedure TQuoteGUI.Lockcomponents;
begin
  inherited;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('ChooseTemplate-Quote') <> 1 then begin
    chkChooseRpt.Enabled := False;
    chkChooseRpt.hint :='You don''t have access to choose template';
  end else chkChooseRpt.Enabled := True;

end;

procedure TQuoteGUI.mnuconvertedToListClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselect('TQuoteConvertedSalesListGUI' , nil, initConvertingFromRef);
end;
procedure TQuoteGUI.NewTransBusObjinstance;
begin
  Freeandnil(Quote);
  Quote := TQuote.Create(Self);
  Quote.Name:= 'QuoteObj';
  Quote.DoProductallocation := DoProductallocation;
  SaleBase := Quote;
  inherited;
end;

procedure TQuoteGUI.initConvertingFromRef(Sender:TObject);
begin
  if not(Sender is TQuoteConvertedSalesListGUI) then exit;
  TQuoteConvertedSalesListGUI(Sender).ConvertingFromRef:= Quote.Globalref;
  TQuoteConvertedSalesListGUI(Sender).ConvertingFromId := Quote.ID;
end;
procedure TQuoteGUI.cmdFaxClick(Sender: TObject);
var
  Fax: TFaxObj;
  FaxNo: string;
  Faxed :Boolean;
begin
  Faxed:= False;
  DisableForm;
  try
    inherited;
    if not SaveSalesRecord then Exit;
    CommitAndNotify;
    try

      FaxNo := Quote.Customer.Faxnumber;

      if Empty(FaxNo) then begin
        CommonLib.MessageDlgXP_Vista(tblMaster.FieldByName('CustomerName').AsString +
          ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
          'Please Review Customer information to Add an Fax Number.', mtWarning,
          [mbOK], 0);
      end else begin
        lblEmail.Visible := true;
        lblEmailMsg.Caption := 'Adding to Fax Spool...';
        fsFax          := true;
        LoadTemplate(true, true, true, 'Quote_' + tblMasterGlobalRef.AsString);
        Fax := TFaxObj.Create;
        try
          Fax.AddToFaxSpool(tblMaster.FieldByName('EmployeeName').AsString,
            tblMaster.FieldByName('CustomerName').AsString, FaxNo, 'Quote',
            tblMaster.FieldByName('GlobalRef').AsString, '',
            ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
          Faxed:= true;
        finally
          FreeandNil(Fax);
        end;
        lblEmail.Visible := false;
        DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
      end;
    finally
      LogFaxed(Faxed , ReportToPrint);
      ReportToPrint:= '';
      closeAfterPrint(Faxed);
    end;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if Quote.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveSalesRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          Quote.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          btnClose.Enabled := True;
        end;
    end;
  end else begin
    RollbackTransaction;
    CanClose := true;
    Notify(false);
  end;
end;

procedure TQuoteGUI.actConQuoteExecute(Sender: TObject);
var
  iNewID: integer;
  strMsg: string;
begin
  DisableForm;
  try
    if not SaveSalesRecord then Exit;


    strMsg :='Copy quote will create a duplicate of this quote for the current Date. ';
    if Quote.Converted then
      StrMsg := strMsg + chr(13) +'This is a converted quote, but the new quote will not be converted automatically.';
    StrMsg := strMsg + chr(13) +'Do you wish to copy?' ;
    if CommonLib.MessageDlgXP_Vista( strMsg, mtconfirmation , [mbYes, mbNo] , 0) = mrNo then Exit;

    ProcessingCursor;

    Try
      iNewID := Quote.CopyQuoteToQuote;

      if iNewID > 0 then begin
        NewAuditTrialentry('Quote Created (Copied)');
          Quote.Load(TQuote(Quote.ObjInstanceToClone).ID);
          closeDB(QryTransStatus);
          opendb(QryTransStatus);
          if not MyConnection.intransaction then BeginTransaction;
          btnCompleted.Enabled := true;
          SetControlFocus(cboClientR);
        end;
    Finally
        ProcessingCursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.actConQuoteUpdate(Sender: TObject);
begin
  inherited;
  btnConQuote.Enabled := (tblDetails.RecordCount > 0) and not (AccessLevel in [3, 5]) and (KeyID <> 0);
end;

//procedure TQuoteGUI.cboStatusExit(Sender: TObject);
//begin
//  if cboStatus.Text = '' then Exit;
//  inherited;
//  cboStatusCloseUp(Sender, cboStatus.LookupTable,
//    cboStatus.DataSource.DataSet, true);
//end;

//procedure TQuoteGUI.cboStatusCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
//var
//  iResult: integer;
//  qryStatusChecker: TERPQuery;
//begin
//  if not Modified then Exit;
//  if cboStatus.Text = '' then Exit;
//  qryStatusChecker := TERPQuery.Create(Self);
//  try
//    qryStatusChecker.Connection  := CommonDbLib.GetSharedMyDacConnection;
//    qryStatusChecker.SQL.Text :=
//      'SELECT Status FROM tblquotestatus WHERE (Status = ' + QuotedStr(cboStatus.Text) + ')';
//    qryStatusChecker.Active      := true;
//    if qryStatusChecker.RecordCount < 1 then begin
//      iResult :=
//        CommonLib.MessageDlgXP_Vista('The quote status you have specified is currently not known.  Would you like to add this to the collection list?',
//        mtConfirmation, [mbOK, mbCancel], 0);
//      if iResult = mrOk then begin
//        // Insert new Status Record
//        qryStatusChecker.Edit;
//        qryStatusChecker.FieldByName('Status').AsString :=
//          cboStatus.Text;
//        qryStatusChecker.Post;
//      end;
//    end;
//  finally
//    // Free our ADO Query Component.
//    FreeandNil(qryStatusChecker);
//  end;
//  cboStatusLookup.Close;
//  cboStatusLookup.Open;
//end;

//procedure TQuoteGUI.cboStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
//begin;
//end;

//procedure TQuoteGUI.actRepairUpdate(Sender: TObject);
//begin
//  inherited;
//  btnRepair.Enabled := (tblDetails.RecordCount > 0) and not (AccessLevel in [3, 5]) and (KeyID <> 0);
//end;
//
//procedure TQuoteGUI.actRepairExecute(Sender: TObject);
//begin
//  if not convertToRepair then Exit;
//  CommitAndNotify;
//  close;
//end;

procedure TQuoteGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  inherited;
  //
end;

procedure TQuoteGUI.FormDestroy(Sender: TObject);
begin
//  FreeandNil(FEmailSender);
  //FreeAndNil(Quote);
  Quote := nil;
  self.SaleBase := nil;
  inherited;
end;

procedure TQuoteGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;
  mnuTransactionSequence.visible :=appenv.companyPrefs.EnablequoteVariation;
//  FEmailSender := T2cEmailSender.Create;
  btnAddFreight.Visible := AppEnv.CompanyPrefs.StateFreightChargeEnabled;
end;

(*procedure TQuoteGUI.SendEmailCallback(const ACommaContactEmails: string;
  ASilent, ASecret: boolean);
var
  RecipientAddress, ReportType, OutGoingFileName: string;
  RepAddress: string;
  strResult: string;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;

  sl : TStringList;
  idx : integer;
begin
  sl := TStringList.Create;
  sl.CommaText := ACommaContactEmails;
  try
    if not SaveSalesRecord then
      Exit;
    Self.CommitAndNotify;

    for idx := 0 to sl.Count - 1 do
    begin

      ReportToPrint := '';
      strResult := '';
      // Clear all previous params/data
      RecipientAddress := sl[idx];
      RepAddress := '';
      ReportType := '';
      OutGoingFileName := '';

      RepAddress := GetSalesCCAddresses(tblMaster.FieldByName('EmployeeID').AsInteger);
      ReportType := 'Quote';

        LoadTemplate(true, true);

        Corres := TCorrespondenceGui.Create;
        try
          Corres.CorrespondenceType := ctEmail;
          Corres.DeleteAttachments := true;
          if strResult = '' then Corres.Subject := ReportType +
              ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString + ' for ' + tblMaster.FieldByName('CustomerName').AsString
          else Corres.Subject := strResult ;
          Corres.RecipientList := RecipientAddress;
          if RepAddress <> '' then
            Corres.CCList := RepAddress;
          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

          OutGoingFileName := getOutGoingFileName('',' ' + ReportType + ' #' + tblMaster.FieldByName('InvoiceDocNumber').AsString, '.PDF');

          if not FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin;
            CommonLib.MessageDlgXP_Vista('Attachment could not be found. This is probably caused by a problem with the template. Please check the template and try again.', mtInformation , [mbOK], 0);
          end;

          if FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin;
            if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin;
              copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
                PChar( Commonlib.TempDir  + OutGoingFileName), false);
            end;
          end;

          Corres.AttachmentList.Add(Commonlib.TempDir + OutGoingFileName);
          CheckForMailAttachments(Corres);
          ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));

          Corres.Execute(ASilent, ASecret);
        finally
          Corres.Free;
        end;
    end;
  finally
    sl.Free;
    self.BeginTransaction;
    ReportToPrint := '';
  end;
end;*)

function TQuoteGUI.SendPrintEmail: boolean;
var
  msgTo: string;
begin
  msgTo := Quote.ContactEmail;
  if msgTo = '' then
    msgTo := Quote.Customer.Email;
  result := TCorrespondenceGui.EmailCustomerSale(msgTo, GetSalesEmails,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.QuotePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.QuotePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);

end;

function TQuoteGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := Quote.ContactEmail;
  if toEmail = '' then
    toEmail := Quote.Customer.Email;
  result := TCorrespondenceGui.EmailCustomerSale(toEmail, GetSalesEmails,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.QuotePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.QuotePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

function TQuoteGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.QuotePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TQuoteGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  result := true;
  toMobile := Quote.ContactMobile;
  if toMobile = '' then
    toMobile := Quote.Customer.Mobile;
  if toMobile = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.QuotePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

procedure TQuoteGUI.SetDirty(ADirty: boolean);
begin
  inherited;
  Quote.Dirty := ADirty;
end;

procedure TQuoteGUI.SetFocusToTotalQuoteAmount(var Msg: TMessage);
begin
  if txtTotalQuoteAmount.Enabled and txtTotalQuoteAmount.Visible then SetControlFocus(txtTotalQuoteAmount);
end;

procedure TQuoteGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblConverted.Visible := tblMaster.FieldByName('Converted').AsBoolean;
  lblconvertedtoRepairs.visible := Quote.RepairID<> 0;
end;

procedure TQuoteGUI.UpdateButtonActions;
begin
  actConCashSaleUpdate(nil);
  actConInvoiceUpdate(nil);
  actConSmartUpdate(nil);
  actConPOSUpdate(nil);
  actConQuoteUpdate(nil);
  actConSalesOrdUpdate(nil);
//  actRepairUpdate(nil);
end;


procedure TQuoteGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject);
begin
  if cancelled then exit;
  inherited UpdateMe(cancelled, aObject);
  (*if Cancelled then begin
    if Assigned(LastComboAccessed) then begin
      LastComboAccessed.Text := '';
      closenopendb(LastComboAccessed.LookupTable);
    end;
  end;*)
end;

function TQuoteGUI.SaveSalesRecord: Boolean;
begin
  Result := true;

  lblProcessMessage.Caption := 'Saving....';
  lblProcessMessage.visible := true;
  Try
    SetControlFocus(btnCompleted);

    if AccessLevel >= 5 then
    begin
      Quote.CancelDB;
      Quote.Dirty := False;
      Exit;
    end;

    Quote.PostDB;

    if Quote.Dirty then begin
      Quote.ResultStatus.Clear;
        if Quote.Save then begin
          Quote.Dirty := false;
        end else begin
          Result := false;
          HandleQuoteErrors;
        end;
    end;
  Finally
    Quote.ResultStatus.Clear;
      lblProcessMessage.Visible := false;
      (*if result then TfmSalesEquipmentProduct.ShowProductswithnoEquipment(Quote);*)
  end;
end;

procedure TQuoteGUI.CommitAndNotify;
var
  MsgObj: TMsgObj;
begin
  CommitTransaction;
  AfterCommit; // virtual method used in decendants
  Notify;

  MsgObj := TMsgObj.Create;
  MsgObj.SetAddress('TfmMarketingLead', 'QuoteSaved');
  MsgObj.IntValue := Quote.ClientID;
  fMsgHandler.Send(MsgObj);
end;

procedure TQuoteGUI.HandleQuoteErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := Quote.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_Sales_Warn_CreditExceeded:;
      BOR_Sales_Warn_TermsExceeded:;
      BOR_Sales_Err_InvalidDepartment: SetControlFocus(cboClass);
      BOR_Sales_InvalidPONumber: SetControlFocus(txtPONumber);
    end;
  end;
end;


function TQuoteGUI.HasAssociatedrecords: boolean;
begin
  REsult := True;
  if Quote.RelatedSales.count <=1 then begin
    MessageDlgXP_Vista('Quote # ' +IntToStr(Quote.ID) +' Has No Other Quotes Associated with it' , mtInformation , [mbok],0);
    REsult := False;
  end;
end;

procedure TQuoteGUI.txtCustomIDDblClick(Sender: TObject);
begin
  if not (appenv.companyPrefs.EnablequoteVariation) then exit;
  inherited;
end;

procedure TQuoteGUI.txtTotalQuoteAmountEnter(Sender: TObject);
begin
  inherited;
  fStoredTotalQuoteAmount := tblMaster.FieldByName('TotalQuoteAmount').AsFloat;
end;

function TQuoteGUI.InitialiseCustomerID(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  InitialiseStartup := True;
  CustomerID := MsgObj.IntValue;
  Result := True;
end;

(*function TQuoteGUI.CheckStatus: boolean;
var    {Quotes use the same status types as Leads: both from tblsimpletypes}
  LeadStatus:TLeadStatusType;
  iResult :integer;
begin
  result:= true;
  LeadStatus := TLeadStatusType.Create(self);
  try
    LeadStatus.LoadSelect('Name = ' + QuotedStr(cboCurrentTransStatus.Text));
    if LeadStatus.Count = 0 then begin
      iResult := CommonLib.MessageDlgXP_Vista('The quote status you have specified is currently not known.  Would you like to add this to the collection list?',
        mtConfirmation, [mbOK, mbCancel], 0);
      if iResult = mrOk then begin
        LeadStatus.New;
        LeadStatus.TypeName := cboCurrentTransStatus.Text;
        LeadStatus.PostDb;

        qryLeadStatus.Close;
        qryLeadStatus.Open;
      end
      else
        result:= false;
    end;
  except

  end;
end;
*)
procedure TQuoteGUI.btnCloseClick(Sender: TObject);
begin

  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;


procedure TQuoteGUI.actRepairUpdate(Sender: TObject);
begin
  inherited;
  btnRepair.Enabled := (tblDetails.RecordCount > 0) and not (AccessLevel in [3, 5]) and (KeyID <> 0);
end;
procedure TQuoteGUI.actRepairExecute(Sender: TObject);
begin
  if not convertToRepair then Exit;
  NewAuditTrialentry('Repair Created');
  DEtachAll;
  CommitAndNotify;
  close;
end;

procedure TQuoteGUI.btnPDFClick(Sender: TObject);
begin
  DisableForm;
  try
    if not SaveSalesRecord then Exit;
    CommitAndNotify;
    Try
      fbReportSQLSupplied :=   False;
      inherited;
      (*if AppEnv.Employee.CloseOnPrint then Close;*)
        CloseAfterPrint;
      except
        on E:Exception do begin
            commonlib.MessageDlgXP_Vista('Export to PDF failed.' +CHR(13) +CHR(13) + E.Message , mtWarning, [mbok] , 0);
            self.BeginTransaction;
        end;
      end;
  finally
    EnableForm;
  end;

end;

procedure TQuoteGUI.btnPrepaymentClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.btnPreviewClick(Sender: TObject);
begin
  actPreviewExecute(nil);
  CloseAfterPrint;
end;

procedure TQuoteGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled, DoClose: boolean;
begin
  if not SaveSalesRecord then Exit;
  Self.CommitAndNotify;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print', 'Print a Quote',actPrintExecute, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a Quote', self.actPreviewExecute, true, true);
    OptsForm.ActionList.Add('Save PDF', 'Save a PDF Quote to your computer', SaveTransToPDF, true, true);

    OptsForm.ActionList.AddDivider('Email' ,'Email to the Customer and CC to Employees Tracking Sales Emails');
    OptsForm.ActionList.Add('Email Quote', 'Email a copy of the Quote', DoEmailTransaction, true, true);
    OptsForm.ActionList.Add('Email Silently', 'Email a copy of the Quote Silently', DoEmailTransactionSilentnSecret, true, true);
    OptsForm.ActionList.Add('Email Quote (Edit)', 'Edit Email Message Before Sending, With a Copy of the Quote', DoEmailTransactionnonsilent, true, true);
    if AppEnv.CompanyPrefs.EnableQuotePrintEmail and ((Quote.ContactEmail <> '') or (Quote.Customer.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Quote', self.SendPrintEmailSilent, true, true);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Quote', self.SendPrintEmail, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Quote', self.SendPrintEmailSilent, true, false);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Quote', self.SendPrintEmail, true, false);
    end;
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Quote', self.SendPrintEmail, true, true);

    OptsForm.ActionList.AddDivider('SMS');


    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableQuotePrintSMS and
       ((Quote.ContactMobile <> '') or (Quote.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    DoClose := OptsForm.CloseWhenDone;
  finally
    OptsForm.Release;
  end;
  CloseAfterPrint(DoClose);
end;

procedure TQuoteGUI.btnFreightTNTClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TQuoteGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TFESalesLines then TFESalesLines(Sender).Dataset                           := tblFESalesLines
        else if Sender is TFESaleslinesRelatedPrs then TFESaleslinesRelatedPrs(Sender).Dataset  := tblFESaleslinesRelatedPrs;
    end;
end;

procedure TQuoteGUI.DoOnClientchange;
begin
  inherited;
  if cboViaQry.Active and (cboVia.LookupValue = '') then begin
    cboViaQry.Locate('ShippingMethod', 'Client Arranged', [loCaseInsensitive]);
    cboVia.LookupValue := 'Client Arranged';
  end;
  RefreshProductQry;
end;

procedure TQuoteGUI.doShowPrepayments(Sender: TObject);
begin
  inherited;
  OpenPrepaylist;
end;

initialization
  RegisterClassOnce(TQuoteGUI);
  with FormFact do begin

    RegisterMe(TQuoteGUI, 'TQuoteListExpressGUI_*=SaleID');
    RegisterMe(TQuoteGUI, 'TQuoteListGUI_*=SaleID');
    RegisterMe(TQuoteGUI, 'TfmQuoteJobList_*=SaleID');
    RegisterMe(TQuoteGUI, 'TQuoteListExpressGUI_*=SaleID');
    RegisterMe(TQuoteGUI, 'TGlobalsearchGUI_*_QUOTE=SaleID');
    RegisterMe(TQuoteGUI, 'TSaleconvertedToListGUI_*_QUOTE=SaleID');
    RegisterMe(TQuoteGUI, 'TRepairsList_QuoteGlobalRef=QuoteGlobalRef');
    RegisterMe(TQuoteGUI, 'TRepairInvoiceListGUI_QuoteGlobalRef=QuoteGlobalRef');
    RegisterMe(TQuoteGUI, 'TRepairListParts_QuoteGlobalRef=QuoteGlobalRef');
    RegisterMe(TQuoteGUI, 'TRepairListTimesheet_QuoteGlobalRef=QuoteGlobalRef');
    RegisterMe(TQuoteGUI, 'TRepairListEquipment_QuoteGlobalRef=QuoteGlobalRef');
    RegisterMe(TQuoteGUI, 'TQuoteDetailsReport_*=SaleID');
(*    RegisterMe(TQuoteGUI, 'TRemindersListGUI_*_Quote=ID');*)
    RegisterMe(TQuoteGUI, 'TReminderListGUI_*_Quote=ID');
    RegisterMe(TQuoteGUI, 'TMemTransListGUI_*_TQuoteGUI=TransID');
    RegisterMe(TQuoteGUI, 'TEmailedReportsList_*_Quote=Transaction');
    RegisterMe(TQuoteGUI, 'TSalesOrderListGUI_ConvertFromQuote=ConvertFromQuote');
    RegisterMe(TQuoteGUI, 'TInvoiceListGUI_ConvertFromQuote_Invoice=ConvertFromQuote');
    RegisterMe(TQuoteGUI, 'TFaxSpoolListingGUI_TransGlobal_Quote=TransGlobal');
    RegisterMe(TQuoteGUI, 'TFaxSpoolListingGUI_TransType_Quote=TransGlobal');
    RegisterMe(TQuoteGUI, 'TBackOrdersListGUI_ConvertFromQuote=SaleID');
    RegisterMe(TQuoteGUI, 'TJobProfitabilityGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TJobProfitabilityforCustomerGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TRepairProfitabilityGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TSoldProductsReport_*_quote=SaleID');
    RegisterMe(TQuoteGUI, 'TfmMarketingLead_*_Quote=ActionID');
    RegisterMe(TQuoteGUI, 'TAllTransactionGUI_*_Quote=TransNo');
    RegisterMe(TQuoteGUI, 'TBackOrderPurchaseListGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TMemTransListGUI_*_Quote=TransID');
    RegisterMe(TQuoteGUI, 'TTransactionswith0QtyGUI_*_Quote=TrasnsId');
    RegisterMe(TQuoteGUI, 'TSalesTotalAmountMisMatchGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TNumberSequenceListGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TTransactionSequenceGUI_*_QUOTE=TransID');
    RegisterMe(TQuoteGUI, 'TSalesPrepaymentsGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TBOMSalesListGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TProcesseswithNotimeGUI_*_Quote=SaleID');
    RegisterMe(TQuoteGUI, 'TIncomingOrdersList_*_Quote=SaleId');
    //RegisterMe(TQuoteGUI, 'TSalesAnalysisGraphDrilldownSalesGUI_*_Quote=SaleID');

  end;

end.


