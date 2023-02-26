
unit frmSuppPayments;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 24/05/05  1.00.01 IJB  Modified to work with new version of PurchaseOrders
                        (now using new TPurchaseOrder object), changed
                        foreign currency handling.
 08/06/05  1.00.02 IJB  Modified to not re-calculate total amount when user
                        changes date if currency is AUD or balnk.
 09/06/05  1.00.03 BJ   Validations added for blank supplier name and
                        amount.
                        'Printcheque' option is enabled when the form is opened.
                        Clicking on this button will Save the record and prints
                        report.
                        NOTE: print cheque option is enabled when the payment
                        method is not cheque ????
 14/06/05  1.00.04 IJB  Removed validation on amount, amount can be zero.
 04/07/05  1.00.05 DSP  Added functionality to email the supplier payment
                        remittance slip to the supplier
 07/07/05  1.00.06 DMS  1. Formatted unit's source code.
 25/07/05  1.00.07 DMS  BUG Fixed :Currency Variation calculation for
                        foreign currency
 28/07/05  1.00.08 IJB  Modified to set payment currency same as PO, moved logic
                        to CalcForeignAmount, prevent foreign calc stuff if user
                        unticks a line.
 01/09/05  1.00.09 IJB  Added Round function to SQL in IsCurrencyVariationApplied
                        function so that MySql would perform correct comparison.
 08/08/05  1.00.10 DSP  Changed 'cheque' to 'receipt' in the dialog box to
                        confirm printing of the receipt.
 26/08/05  1.00.11 DSP  The Employee.CloseOnPrint option now requires setting
                        for the form to close after printing.
 04/10/05  1.00.11 MV   Implimentation of Foreign Currency, added new procedure
                        OnDataFieldChange for processing data field changes.
                        Also removed depricated methods from the implementation
                        of the original foreign currency requirements.
 05/10/05  1.00.12 MV   Modified ... to support a foreign currency with a credit
 17/10/05  1.00.13 MV   Added Payment reduction amount when deselecting a line
                        payment and removed declaration of unused variables.
 19/10/05  1.00.14 DLS  Added RegisterClass
 27/10/05  1.00.15 MV   Fixed SQL to support prepayment foreign currency
                        negative values.
 10/01/06  1.00.16 IJB  Modified GridSetup to show a message to user if there
                        are payment items for more than one currency for
                        selected supplier (as list will only show items for
                        currently select currency code).
 16/01/06  1.00.17 IJB  Made lots of changes to get foreign currency to work
                        correctly.
 06/02/06  1.00.18 DSP  Removed Label6 component which was being used for
                        debug display.
 20/02/06  1.00.19 DSP  Added password to email authentication.

 11/04/06  1.00.20 BJ   Locking all the transaction records when the Supplier is selected
 20/04/07  1.00.21 IJB  Changed all StrToInt and StrToFloat to StringToInt and StringToFloat,
                        fixed ambigious SupplierId field in hard coded Print Cheque SQL
                        and in Supplier Payment template.
                        }


interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DBTables, DB,
     StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids,  DNMPanel, Buttons, DNMSpeedButton,
     Grids, BaseGrid, BaseInputForm, AdvGrid, wwdbdatetimepicker, wwdblook, wwcheckbox,
     SelectionDialog, AppEvnts, wwdbedit, MyAccess,ERPdbComponents, MemDS, DBAccess, DataState,
     Wwdotdot, Wwdbcomb, Menus, AdvMenus,
     Shader, Wwdbigrd, Wwdbgrid, BusObjPayments, BusobjBase, ActnList,
     DNMAction, ImgList, AdvEdit, DBAdvEd, AdvMoneyEdit, DBAdvMoneyEdit,
  ERPDbLookupCombo, ProgressDialog, JsonObject;

const
  EARLY_SUPP_PAYMENT = WM_USER +101;

type
  TfmSuppPayments = class(TBaseInputGUI)
    Notes: TDBMemo;
    Label28: TLabel;
    Label2: TLabel;
    txtAmount: TDBEdit;
    Label3: TLabel;
    Label1: TLabel;
    txtBalance: TDBEdit;
    Label5: TLabel;
    Label23: TLabel;
    cboPayMethod_Label: TLabel;
    RefenceNo: TDBEdit;
    Label29: TLabel;
    Box30: TBevel;
    Box31: TBevel;
    txtUnapplied: TDBEdit;
    Label36: TLabel;
    txtApplied: TDBEdit;
    Label44: TLabel;
    ClassLabel: TLabel;
    Box60: TBevel;
    Label81: TLabel;
    DSMaster: TDataSource;
    cboClient: TERPDBLookupCombo;
    cboCreationDate: TwwDBDateTimePicker;
    cboClass: TwwDBLookupCombo;
    cboAccount: TwwDBLookupCombo;
    cboPaymentMethod: TwwDBLookupCombo;
    txtRecordID: TDBEdit;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    tblPODetails: TERPQuery;
    tblMasterGlobalRef: TWideStringField;
    tblMasterPaymentID: TAutoIncField;
    tblMasterPaymentNo: TIntegerField;
    tblMasterClassID: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterSupplierID: TIntegerField;
    tblMasterInvoiceRefNo: TWideStringField;
    tblMasterAccountID: TIntegerField;
    tblMasterPaymentDate: TDateField;
    tblMasterAmount: TFloatField;
    tblMasterPayMethodID: TIntegerField;
    tblMasterNotes: TWideStringField;
    tblMasterReferenceNo: TWideStringField;
    tblMasterCardholdersName: TWideStringField;
    tblMasterCreditCardNumber: TWideStringField;
    tblMasterCreditCardExpDate: TDateTimeField;
    tblMasterPrintFlag: TWideStringField;
    tblMasterPrintedBy: TIntegerField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterCustomer: TWideStringField;
    tblMasterSupplier: TWideStringField;
    tblMasterEmployee: TWideStringField;
    tblMasterContact: TWideStringField;
    tblMasterCheque: TWideStringField;
    tblMasterSupplierPayment: TWideStringField;
    tblMasterCompanyName: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterReconciled: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterCredit: TFloatField;
    tblMasterUnApplied: TFloatField;
    tblMasterApplied: TFloatField;
    tblMasterAppliedCredits: TWideStringField;
    tblMasterReconciliationID: TIntegerField;
    tblMasterFinished: TWideStringField;
    tblMasterStatement: TIntegerField;
    tblMasterMSReceived: TWideStringField;
    tblPODetailsPurchaseOrderID: TAutoIncField;
    tblPODetailsGlobalRef: TWideStringField;
    tblPODetailsPurchaseOrderNumber: TWideStringField;
    tblPODetailsOriginalNo: TWideStringField;
    tblPODetailsAccount: TWideStringField;
    tblPODetailsAccountID: TIntegerField;
    tblPODetailsBOID: TWideStringField;
    tblPODetailsSupplierName: TWideStringField;
    tblPODetailsClientID: TIntegerField;
    tblPODetailsOrderTo: TWideStringField;
    tblPODetailsShipTo: TWideStringField;
    tblPODetailsOrderDate: TDateField;
    tblPODetailsTotalTax: TFloatField;
    tblPODetailsTotalAmount: TFloatField;
    tblPODetailsTotalAmountInc: TFloatField;
    tblPODetailsEmployeeName: TWideStringField;
    tblPODetailsEmployeeID: TIntegerField;
    tblPODetailsInvoiceNumber: TWideStringField;
    tblPODetailsRefNo: TWideStringField;
    tblPODetailsETADate: TDateField;
    tblPODetailsDueDate: TDateField;
    tblPODetailsComments: TWideStringField;
    tblPODetailsSalesComments: TWideStringField;
    tblPODetailsShipping: TWideStringField;
    tblPODetailsTerms: TWideStringField;
    tblPODetailsPrintFlag: TWideStringField;
    tblPODetailsPrintedBy: TWideStringField;
    tblPODetailsPaid: TWideStringField;
    tblPODetailsBalance: TFloatField;
    tblPODetailsPayment: TFloatField;
    tblPODetailsApplyFlag: TWideStringField;
    tblPODetailsAmountDue: TFloatField;
    tblPODetailsPayMethod: TIntegerField;
    tblPODetailsIsPO: TWideStringField;
    tblPODetailsIsRA: TWideStringField;
    tblPODetailsIsBill: TWideStringField;
    tblPODetailsIsCredit: TWideStringField;
    tblPODetailsIsCheque: TWideStringField;
    tblPODetailsIsPOCredit: TWideStringField;
    tblPODetailsDeleted: TWideStringField;
    tblPODetailsEditedFlag: TWideStringField;
    tblPODetailsInvoiceDate: TDateField;
    tblPODetailsEnteredBy: TWideStringField;
    tblPODetailsEnteredAt: TWideStringField;
    tblPODetailsConNote: TWideStringField;
    cboForeignCurrencyCode: TwwDBLookupCombo;
    Label4: TLabel;
    lblCurrencyAmount: TLabel;
    Bevel2: TBevel;
    ForeignAmount: TDBEdit;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignCurrencyAmount: TFloatField;
    tblMasterBankAccountName: TWideStringField;
    tblMasterBankAccountBSB: TWideStringField;
    tblMasterBankAccountNo: TWideStringField;
    tblPrepayments: TERPQuery;
    UseAccNo: TDNMSpeedButton;
    cboClientlookup: TERPQuery;
    cboClassQry: TERPQuery;
    cboAccountQry: TERPQuery;
    qryPayMethod: TERPQuery;
    qryForeignCurrency: TERPQuery;
    btnReconciled: TDNMSpeedButton;
    lblEmail: TLabel;
    edtVariationAmount: TwwDBEdit;
    lblVariationAccount: TLabel;
    lblVariationAmount: TLabel;
    edtExchangeRate: TwwDBEdit;
    lblExchangeRate: TLabel;
    tblMasterForeignVariationAccountID: TIntegerField;
    tblMasterForeignVariationAmount: TFloatField;
    tblMastermsTimeStamp: TDateTimeField;
    qryVariationAccount: TERPQuery;
    tblMasterForeignVariationAccountName: TWideStringField;
    cboVariationAccount: TwwDBLookupCombo;
    Bevel3: TBevel;
    Label10: TLabel;
    txtForeignApplied: TDBEdit;
    Label12: TLabel;
    txtForeignUnapplied: TDBEdit;
    tblMasterForeignUnApplied: TFloatField;
    tblMasterForeignApplied: TFloatField;
    tblPODetailsSeqNo: TIntegerField;
    tblPODetailsCustPONumber: TWideStringField;
    tblPODetailsLastUpdated: TDateTimeField;
    tblPODetailsForeignExchangeCode: TWideStringField;
    tblPODetailsForeignExchangeRate: TFloatField;
    tblPODetailsForeignTotalAmount: TFloatField;
    tblPODetailsForeignPaidAmount: TFloatField;
    tblPODetailsForeignBalanceAmount: TFloatField;
    tblPODetailsmsTimeStamp: TDateTimeField;
    tblPODetailsBaseNo: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel2: TPanel;
    grdPayments: TwwDBGrid;
    dsGuiDetails: TDataSource;
    tblGuiDetails: TERPQuery;
    tblGuiDetailsID: TIntegerField;
    tblGuiDetailsType: TWideStringField;
    tblGuiDetailsSupplierName: TWideStringField;
    tblGuiDetailsOrderDate: TDateField;
    tblGuiDetailsInvoiceDate: TDateField;
    tblGuiDetailsInvoiceNumber: TWideStringField;
    tblGuiDetailsGlobalRef: TWideStringField;
    tblGuiDetailsComments: TWideStringField;
    tblGuiDetailsPurchaseOrderNumber: TWideStringField;
    tblGuiDetailsOriginalAmount: TFloatField;
    tblGuiDetailsBalance: TFloatField;
    tblGuiDetailsPaid: TWideStringField;
    tblGuiDetailsPayment: TFloatField;
    tblGuiDetailsAmountOutStanding: TFloatField;
    tblGuiDetailsPurchaseOrderID: TIntegerField;
    tblGuiDetailsForeignExchangeCode: TWideStringField;
    tblGuiDetailsForeignExchangeRate: TFloatField;
    tblGuiDetailsForeignOriginalAmt: TFloatField;
    tblGuiDetailsForeignBalanceAmount: TFloatField;
    tblGuiDetailsForeignPayment: TFloatField;
    tblGuiDetailsDiscount: TFloatField;
    tblGuiDetailsForeignAmountOutstanding: TFloatField;
    tblGuiDetailsPaidInFull: TWideStringField;
    tblGuiDetailsApply: TWideStringField;
    tblGuiDetailsRefNo: TWideStringField;
    ActionList: TActionList;
    actSave: TDNMAction;
    actNew: TDNMAction;
    actPrintcheque: TDNMAction;
    actEmail: TDNMAction;
    actCancel: TDNMAction;
    actPrintreceipt: TAction;
    tblGuiDetailsEnteredBy: TWideStringField;
    cboClientlookupCompany: TWideStringField;
    cboClientlookupClientId: TIntegerField;
    cboClientlookupBalance: TFloatField;
    imgPopup: TImageList;
    Bevel1: TBevel;
    lblEnteredHead: TLabel;
    lblEnteredAtHead: TLabel;
    lblEnteredBy: TDBText;
    lblEnteredAt: TDBText;
    qryEmployeeLookup: TERPQuery;
    tblMasterEnteredBy: TWideStringField;
    cboClientlookupClientNo: TWideStringField;
    btnContacts: TDNMSpeedButton;
    tblGuiDetailsDateCalculated: TWideStringField;
    tblMasterEnteredAt: TDateTimeField;
    lblMinus: TLabel;
    lblEqual: TLabel;
    lblVariation: TLabel;
    txtVariationAmount2: TwwDBEdit;
    lblApplied: TLabel;
    txtApplied2: TwwDBEdit;
    imgGrigMessage: TImage;
    lblPOOnlyApprovedTransInSuppPayment: TLabel;
    tblMasterChequePrinted: TWideStringField;
    btnAddDate: TDNMSpeedButton;
    tblMasterClientPrintName: TWideStringField;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    actApplyDiscount: TDNMAction;
    pnlContractorPayment: TDNMPanel;
    Label6: TLabel;
    chkContractorPayment: TwwCheckBox;
    tblMastermsUpdateSiteCode: TWideStringField;
    tblMasterContractorPayment: TWideStringField;
    tblGuiDetailsIsEarlyPaymentDiscount: TWideStringField;
    tblGuiDetailsRefunding: TFloatField;
    tblGuiDetailsRefundPercent: TFloatField;
    lblDisableCalc: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    lblDeleted: TLabel;
    lblEFT: TLabel;
    cmdPrint: TDNMSpeedButton;
    cmdSave: TDNMSpeedButton;
    chkDeleted: TwwCheckBox;
    cmdNew: TDNMSpeedButton;
    btnPrintCheque: TDNMSpeedButton;
    chkEFT: TwwCheckBox;
    btnEmail: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    btnSelectall: TDNMSpeedButton;
    btnApply: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintAndEmailClick(Sender: TObject);
    procedure Print(const ID: integer; const EmailReport: boolean);
    procedure PrintCheque(ID: integer);
    procedure btnPrintChequeClick(Sender: TObject);
    procedure NotesExit(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkEFTClick(Sender: TObject);
    procedure UseAccNoClick(Sender: TObject);
    procedure cboClientlookupAfterOpen(DataSet: TDataSet);
    procedure btnReconciledClick(Sender: TObject);
    procedure cboCreationDateChange(Sender: TObject);
    procedure cboForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClientlookupBeforeOpen(DataSet: TDataSet);
    procedure actSaveUpdate(Sender: TObject);
    procedure actPrintchequeUpdate(Sender: TObject);
    procedure actPrintreceiptUpdate(Sender: TObject);
    procedure actEmailUpdate(Sender: TObject);
    procedure actCancelUpdate(Sender: TObject);
    procedure actNewUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSaveExecute(Sender: TObject);
    procedure cboAccountQryBeforeOpen(DataSet: TDataSet);
    procedure actCancelExecute(Sender: TObject);
    procedure grdPaymentsDblClick(Sender: TObject);
    procedure grdPaymentsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cboForeignCurrencyCodeChange(Sender: TObject);
    procedure txtAppliedEnter(Sender: TObject);
    procedure txtAmountChange(Sender: TObject);
    procedure btnContactsClick(Sender: TObject);
    procedure ForeignAmountChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure tblGuiDetailsCalcFields(DataSet: TDataSet);
    procedure btnSelectallClick(Sender: TObject);
    procedure grdPaymentsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure btnAddDateClick(Sender: TObject);
    procedure cboCreationDateExit(Sender: TObject);
    procedure actApplyDiscountExecute(Sender: TObject);
    procedure actApplyDiscountUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lblDisableCalcClick(Sender: TObject);
    procedure tblGuiDetailsAfterOpen(DataSet: TDataSet);
  private
    InAccountNoMode: boolean;
    fExtSupplierId : Integer;
    UserChangedPaymentAmount: boolean;
    GrdPaymentJson: TJsonObject;
    (*procedure SaveTransaction;*)
    procedure ManipulateRequiredControls;
    Procedure ManipulateFCControls;
    (*function GetCurrentExchangeRate: double;*)
    procedure CloseFormAndPaymentList;
    procedure SendReportEmail;
    Procedure ChangeDisplayLabel;
    procedure ArrangeColWidth;
    Procedure GetEFTDetails;
    procedure SetForeignFieldDisplayFormat;
    //Procedure UpdateFromContact(const value :Tdataset);
    function SaveData: boolean;
    procedure SetGridAccess;
    Procedure ApplyCallback(Const Sender: TBusObj; var Abort: Boolean);
    procedure DoEarlyPayment; overload;
    procedure DoEarlyPayment(var Msg: TMessage); overload; message EARLY_SUPP_PAYMENT;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function GetReportTypeID: integer; override;
    Procedure InitGuiPrefsReadonlyFields;Override;
    Procedure InitERPLookupCombonFields; Override;
  public
    SuppPayment: TSuppPayments;
    property ExtSupplierId   : Integer read fExtSupplierId  write fExtSupplierId;

  end;

implementation

uses FastFuncs,FormFactory,
      StrUtils,  TransPaymentList, frmPurchaseOrders,
     frmBill, frmCredit, frmSuppPrepayments, frmSupplier,
     frmChartOfAccountsFrm, CommonLib, PaymentsLibGUI, tcDataUtils, tcConst, tcTypes,
     BaseClassFuncs, AppEnvironment, BusObjConst,ContactSelectorFrm,
  BusObjClient, DNMLib, MySQLConst, BusObjCurrency, Math, CommonDbLib,
  frmDelayMessageDlg, Variants, chequeLib, CorrespondenceObj, BusObjContact,
  SystemLib, EmailExtraUtils, TimedHint;

{$R *.DFM}

var
  LastActiveControl: TWinControl = nil;


procedure TfmSuppPayments.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  msg: string;
  json, rec: TJsonObject;

  function SavedRec: TJsonObject;
  var
    idx: integer;
  begin
    result := nil;
    for idx := 0 to GrdPaymentJson.A['Lines'].Count -1 do begin
      if (GrdPaymentJson.A['Lines'][idx].AsObject.S['TransType'] = SuppPayment.GUILines.TransType) and
         (GrdPaymentJson.A['Lines'][idx].AsObject.I['TransID'] = SuppPayment.GUILines.TransID) then begin
        result := GrdPaymentJson.A['Lines'][idx].AsObject;
        break;
      end;
    end;
  end;

begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSuppPayments              then TSuppPayments(Sender).DataSet          := tblMaster
        else if Sender is TSuppPaymentLines     then TSuppPaymentLines(Sender).DataSet      := tblDetails
        else if Sender is TGuiSuppPaymentLines  then TGuiSuppPaymentLines(Sender).DataSet   := tblguiDetails;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusobjEventVal_AddToEFT) then begin
      chkEFT.Checked := SuppPayment.AddToEFT;
    end
    else if (Eventtype = BusObjEvent_Change) then begin
      if Value = BusobjEventVal_PurchaseDiscountApplied then
        grdPayments.ColumnByName('Discount').Readonly := true // once discount applied, can't apply again
      else if (Value = BusObjEvent_TotalsChanged) then begin
        if not UserChangedPaymentAmount then begin
          try
            if SuppPayment.IsFCSelected then begin
              SuppPayment.ForeigncurrencyAmount:= SuppPayment.ForeignApplied;

              grdPayments.Invalidate;
              imgGridWatermark.Picture:= imgGrigMessage.Picture;
              grdPayments.OnBeforePaint :=GridBeforePaint;
            end
            else begin
              SuppPayment.Amount:= SuppPayment.Applied;

            end;
          finally
            UserChangedPaymentAmount:= false;
          end;
        end;
      end else if (Value = BusobjEventVal_ClientUserLockFail) then begin
        msg:= 'User ' + Sender.UserLock.LockInfo.UserName +
          ' is processing payments for this supplier.' + #13#10 + #13#10 +
          'In use since ' + FormatDateTime('hh:nn:ss dd:mm:yyyy',Sender.UserLock.LockInfo.TimeLocked);
        DelayMessageDlg(msg, mtInformation, [mbOk], 0)
      end else if (Value = BusObjEventVal_ClientID) then begin
        ManipulateRequiredControls;
        UserChangedPaymentAmount:= false;
      end else if value = BusObjEvent_PaymentRefno then begin
        if AppEnv.AccessLevels.GetEmployeeAccessLevel('CanAlterRefinsupPayment')<> 1 then
          if (not VarIsNull(tblMasterReferenceNo.OldValue)) and (tblMasterReferenceNo.OldValue <>  '') then begin
            MessageDlgXP_vista('You don''t have access to change ''Reference  No'' on a Supplier Payment', mtWarning, [mbOK], 0);
            SuppPayment.ReferenceNo :=tblMasterReferenceNo.OldValue ;
          end;
      end;
    end

    else if (Eventtype = BusobjEvent_Event) then begin
      if (Value = BusObjEventVal_BeforeRefreshGuiLines) then begin
        if GrdPaymentJson.I['ClientID'] <> SuppPayment.ClientID then begin
          { new client .. clear lines from previous client }
          GrdPaymentJson.Clear;
        end
        else begin
          { save the status of the lines for this client before they ar refreshed }
          GrdPaymentJson.Clear;
          GrdPaymentJson.I['ClientID'] := SuppPayment.ClientID;
          SuppPayment.GUILines.First;
          while not SuppPayment.GUILines.EOF do begin
            with GrdPaymentJson.A['Lines'].AddObject do begin
              S['TransType'] := SuppPayment.GUILines.TransType;
              I['TransID'] := SuppPayment.GUILines.TransID;
              B['Applied'] := SuppPayment.GUILines.Applied;
              F['Payment'] := SuppPayment.GUILines.Payment;
            end;
            SuppPayment.GUILines.Next;
          end;
        end;

      end
      else if (Value = BusObjEventVal_AfterRefreshGuiLines) then begin

        if SuppPayment.GUILines.Count > 0 then begin
          json := JO;
          try
            { reinstate selections plus add any new refunds created .. }
            json.I['ClientID'] := SuppPayment.ClientID;
            SuppPayment.GUILines.First;
            while not SuppPayment.GUILines.EOF do begin
              { build a new list .. }
              with json.A['Lines'].AddObject do begin
                S['TransType'] := SuppPayment.GUILines.TransType;
                I['TransID'] := SuppPayment.GUILines.TransID;
                B['Applied'] := SuppPayment.GUILines.Applied;
                F['Payment'] := SuppPayment.GUILines.Payment;
              end;

              { only do this if we have some saved lines }
              if (GrdPaymentJson.A['Lines'].Count > 0) and (GrdPaymentJson.I['ClientID'] = SuppPayment.ClientID) then begin


                rec := SavedRec;
                if Assigned(rec) then begin
                  if rec.B['Applied'] then begin
                    SuppPayment.GUILines.Applied := true;
                    if SuppPayment.GUILines.Payment > rec.F['Payment'] then
                      SuppPayment.GUILines.Payment := rec.F['Payment'];
                  end;
                end
                else begin
                  { if its a new refund .. select it }
                  if SameText(SuppPayment.GUILines.TransType,'Credit') then
                    SuppPayment.GUILines.Applied := true;

                end;
              end;
              SuppPayment.GUILines.Next;
            end;
          finally
            GrdPaymentJson.Assign(json);
            json.Free;
          end;
        end;
      end;
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_CalculationsDisabled) then begin
        lblDisableCalc.visible := SuppPayment.GUILines.count > appenv.CompanyPrefs.suppPayLinesToDisableCalcs;
    end;
end;

procedure TfmSuppPayments.DoEarlyPayment;
begin
  PostMessage(self.Handle, EARLY_SUPP_PAYMENT, 0,0)
end;

procedure TfmSuppPayments.DoEarlyPayment(var Msg: TMessage);
begin
  TGuiSuppPaymentLines(SuppPayment.GuiLines).PostDB;
  TGuiSuppPaymentLines(SuppPayment.GuiLines).EarlyPayment;
  grdPayments.RefreshDisplay;
end;

procedure TfmSuppPayments.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen : array of String;
  s: string;
begin
  DisableForm;
  try
    inherited;
    BeginTransaction;
    ClassLabel.Caption := AppEnv.DefaultClass.ClassHeading;
    s := grdPayments.Selected.Text;
    SuppPayment.Load(KeyID);
    if KeyID = 0 then
      SuppPayment.New;
    grdPayments.Selected.Text := s;
    Setlength(QueryNamesNotToOpen, 3);
    QueryNamesNotToOpen[0]  := 'tblMaster';
    QueryNamesNotToOpen[1]  := 'tblDetails';
    QueryNamesNotToOpen[2]  := 'tblGuiDetails';
    OpenQueries(QueryNamesNotToOpen);

    chkEFT.Checked := AppEnv.CompanyPrefs.PaymentsAddToEFT and (KeyID = 0);
    if Supppayment.LockMsg <> '' then begin
        Self.Caption := Self.Caption + '     {' + Supppayment.LockMsg + '}';
        Accesslevel  := 5;
    end;

//    if AppEnv.Employee.UseClientAccountNoOnPayments then UseAccNo.Click;
    SetControlFocus(cboClient);
    ManipulateRequiredControls;
    InAccountNoMode := False;
    SuppPayment.Dirty := False;
    UserChangedPaymentAmount := False;
    tblMasterEnteredAt.DisplayFormat := FormatSettings.ShortDateformat;
    if fExtSupplierId > 0 then begin
      tblMaster.FieldByName('SupplierId').AsInteger := fExtSupplierId;
      SuppPayment.Dirty := True;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmSuppPayments.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    inherited;
    Action := caFree;
end;

procedure TfmSuppPayments.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    if SuppPayment.Dirty and (not SaveData) then exit;
    SuppPayment.userLock.UnlockAllCurrentInstance;
    cboClientlookup.Close;
    cboClientlookup.Open;
    SuppPayment.connection.CommitTransaction;
    SuppPayment.Connection.BeginTransaction;
    SuppPayment.New;
    SuppPayment.GuiLines;
    KeyId:= 0;
    ManipulateRequiredControls;
    SetControlFocus(cboClient);
    UserChangedPaymentAmount:= false;
    grdPayments.ColumnByName('Discount').Readonly := False;
  finally
    EnableForm;
  end;
  SetControlFocus(cboClient);
end;


Procedure TfmSuppPayments.GetEFTDetails;
var
  SupForm: TfmSupplier;
  COAForm: TfrmChartOfAccounts;
begin
    inherited;
    if SuppPayment.ClientInvalid4EFT then begin
        SupForm := TfmSupplier(GetComponentByClassName('TfmSupplier'));
        if Assigned(SupForm) then
            with  SupForm do begin
                KeyId       := SuppPayment.ClientID;
                SupForm.AttachObserver(Self);
                FormStyle   := fsMDIChild;
                BringToFront;
                SupForm.Update;
                TabCtl20.ActivePageIndex := 2;
                SupForm.Update;
                SetControlFocus(edtBankAccName);
            end;
    end;

    if SuppPayment.BankAccountInvalid4EFT then begin
        COAForm := TfrmChartOfAccounts(GetComponentByClassName('TfrmChartOfAccounts'));
        if Assigned(COAForm) then
            with  COAForm do begin
                AttachObserver(Self);
                KeyId       := SuppPayment.AccountID;
                COAForm.AttachObserver(Self);
                FormStyle   := fsMDIChild;
                BringToFront;
                COAForm.Update;
                COAForm.Update;
                if edtBankAccName.Enabled = false then edtBankAccName.Enabled := true;
                SetControlFocus(edtBankAccName);
            end;
    end;
end;
Procedure TfmSuppPayments.ChangeDisplayLabel;
var
    DC, FC :String;
    Procedure ChangeLabel(Const DCFieldName,FCFieldName , GroupName :String);
    begin
        if not SuppPayment.isfcSelected then begin
            if DCFieldName <> '' then begin
                if tblGuiDetails.Findfield(DCFieldName)            <> nil then begin
                    grdPayments.ColumnByName(DCFieldName).DisplayLabel  := groupname;
                    grdPayments.ColumnByName(DCFieldName).Groupname     := '';
                end;
            end;
            if FCFieldName <> '' then
                if tblGuiDetails.Findfield(FCFieldName)        <> nil then
                    grdPayments.RemoveField(FCFieldname);
        end else begin
            if DCFieldName <> '' then
                if tblGuiDetails.Findfield(DCFieldName)            <> nil then begin
                    grdPayments.ColumnByName(DCFieldName).DisplayLabel  := DC;
                    grdPayments.ColumnByName(DCFieldName).GroupName     := AnsiReplaceStr(groupname , '~' , ' ');
                    grdPayments.ColumnByName(DCFieldName).DisplayWidth  := 10;
                end;
            if FCFieldName <> '' then
                if tblGuiDetails.Findfield(FCFieldName)        <> nil then begin
                    grdPayments.AddField(FCFieldname);
                    grdPayments.ColumnByName(FCFieldName).DisplayLabel  := FC;
                    grdPayments.ColumnByName(FCFieldName).GroupName     := AnsiReplaceStr(groupname , '~' , ' ');
                    grdPayments.ColumnByName(FCFieldName).DisplayWidth  := 10;
                    grdPayments.ColumnByName(FCFieldName).Index:= grdPayments.ColumnByName(DCFieldName).Index+1;
                end;
        End;
    end;
begin
    FC := 'Foreign';
    DC := AppEnv.RegionalOptions.ForeignExDefault;
    ChangeLabel('OriginalAmount','ForeignOriginalAmt','Original~Amount');
    ChangeLabel('AmountOutstanding','ForeignAmountOutstanding','Outstanding~Amount');
    ChangeLabel('Payment','ForeignPayment','Payment~Amount');
    ChangeLabel('Balance','ForeignBalanceAmount','Amount~Due');
    FC := 'Foreign~Exchange Rate';ChangeLabel('','ForeignExchangeRate','');
    grdPayments.ColumnByName('ForeignPayment').ReadOnly := not(SuppPayment.IsFCSelected);
    ArrangeColWidth;
end;
procedure TfmSuppPayments.ApplyCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if (AccessLevel = 5) or (KeyID  <> 0) or (SuppPayment.GUILines.TransID = 0) then
    grdPayments.Options   := grdPayments.Options - [dgEditing]
  else
    grdPayments.Options   := grdPayments.Options + [dgEditing];
end;

procedure TfmSuppPayments.ArrangeColWidth;
var
    ctr:Integer;
    TotColwidth:Integer;
begin
    grdPayments.columnbyname('Type').DisplayWidth                    := 15;
    grdPayments.columnbyname('OrderDate').DisplayWidth               := 9;
    grdPayments.columnbyname('PurchaseOrderNumber').DisplayWidth     := 9;
    grdPayments.columnbyname('InvoiceDate').DisplayWidth             := 9;
    grdPayments.columnbyname('InvoiceNumber').DisplayWidth           := 9;
    grdPayments.columnbyname('OriginalAmount').DisplayWidth          := 12;
    grdPayments.columnbyname('ForeignOriginalAmt').DisplayWidth      := 12;
    grdPayments.columnbyname('Balance').DisplayWidth                 := 12;
    grdPayments.columnbyname('ForeignBalanceAmount').DisplayWidth    := 12;
    grdPayments.columnbyname('Payment').DisplayWidth                 := 12;
    grdPayments.columnbyname('ForeignPayment').DisplayWidth          := 12;
    grdPayments.columnbyname('Apply').DisplayWidth                   := 8;
    grdPayments.columnbyname('AmountOutstanding').DisplayWidth       := 12;
    grdPayments.columnbyname('ForeignAmountOutstanding').DisplayWidth:= 12;
    grdPayments.columnbyname('Discount').DisplayWidth                := 8;
    grdPayments.columnbyname('Withholding').DisplayWidth             := 8;
    grdPayments.columnbyname('ForeignExchangeRate').DisplayWidth     := 8;
    grdPayments.columnbyname('RefNo').DisplayWidth                   := 10;
    grdPayments.columnbyname('Comments').DisplayWidth                := 30;

    if Supppayment.ISFCSelected then Exit;

    TotColwidth := 0;
    for ctr := 0 to grdPayments.GetColCount-1 do
            TotColwidth:= TotColwidth + grdPayments.columnbyname(grdPayments.columns[ctr].FieldName).DisplayWidth ;
    if TotColwidth < 128 then
      while TotColwidth <> 128 do
        for ctr := 0 to grdPayments.GetColCount-1 do begin
          if TotColwidth < 128 then begin
            grdPayments.columnbyname(grdPayments.columns[ctr].FieldName).DisplayWidth := grdPayments.columnbyname(grdPayments.columns[ctr].FieldName).DisplayWidth +1;
            TotColwidth:= TotColwidth + 1;
          end;
    end;
end;

procedure TfmSuppPayments.FormCreate(Sender: TObject);
begin
  GrdPaymentJson := JO;
  btnAddDate.Visible :=   not(UserPreferenceOn(lcdOnSuppPayNotes));
  AllowCustomiseGrid := True;
  ShowCustomisemenu:= False;
  lblPOOnlyApprovedTransInSuppPayment.Visible := Appenv.CompanyPrefs.UseApprovalLevels and appenv.CompanyPrefs.POOnlyApprovedTransInSuppPayment;
  AllowGridSorting  := True;
  SuppPayment                     := TSuppPayments.Create(Self);
  SuppPayment.BusObjEvent         := DoBusinessObjectEvent;
  SuppPayment.ChangeDisplayLabel  := ChangeDisplayLabel;
  SuppPayment.DoEarlyPayment      := DoEarlyPayment;
  SuppPayment.GUIMode := True;
  inherited;
    lblDisableCalc.visible := False;
  SuppPayment.ConfirmFromGUI := ConfirmFromGUI;
  SuppPayment.Connection := TMyDacDataConnection.Create(SuppPayment);
  TMyDacDataConnection(SuppPayment.Connection).MyDacConnection := MyConnection;
  SuppPayment.GetEFTDetails   := GetEFTDetails;

  tblMaster.Connection      := MyConnection;
  tblDetails.Connection     := MyConnection;
  tblGuiDetails.Connection  := MyConnection;
  tblPODetails.Connection   := MyConnection;
  cboClient.Selected.Text   := Commonlib.ReplaceStr(cboClient.Selected.Text,'$',AppEnv.RegionalOptions.CurrencySymbol);
end;

procedure TfmSuppPayments.FormDestroy(Sender: TObject);
begin
  inherited;
  GrdPaymentJson.Free;
end;

procedure TfmSuppPayments.cmdPrintAndEmailClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;

    if SuppPayment.Dirty then begin
        if CommonLib.MessageDlgXP_Vista('Printing the receipt/sending the Email will Save the current payment record. ' + Chr(13) + 'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
            Exit;
        if not self.SaveData then exit;
    end;
    try
      CloseFormAndPaymentList;
      Print(SuppPayment.ID, (TDNMAction(Sender) = actEmail));
      (*if  AppEnv.Employee.CloseOnPrint then Self.Close;*)
      CloseAfterPrint;
      KeyID := SuppPayment.ID;
      SuppPayment.Dirty := false;
      FormShow(self);
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

procedure TfmSuppPayments.Print(const ID: integer; const EmailReport: boolean);
var
  sSQL: string;
  Reportname :String;
begin
    Reportname:= GetDefaultTemplate(GetReportTypeID);
    if Reportname = '' then Reportname:= SuppPayment.TransType; //'Supplier Payment';

    sSQL := ' WHERE W.PaymentID = ' + IntToStr(ID);
    if EmailReport then begin
        SaveTemplateReport(Reportname, sSQL, false, 'PDF');
        SendReportEmail;
    end else begin
        PrintTemplateReport(Reportname, sSQL, not AppEnv.Employee.ShowPreview, 1)
    end;
end;

procedure TfmSuppPayments.btnPrintChequeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if SuppPayment. dirty then begin
        if CommonLib.MessageDlgXP_Vista('Printing the Cheque will Save the Current Payment Record. ' + Chr(13) + 'Do you Want to Continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
            Exit;
      if not self.SaveData then exit;
    end;
    Try
      SuppPayment.connection.BeginTransaction;
      try
        PrintCheque(SuppPayment.ID);
        SuppPayment.Connection.CommitTransaction;
      Except
        SuppPayment.Connection.RollbackTransaction;
      end;
      CloseAfterPrint;

      KeyID := SuppPayment.ID;
      SuppPayment.Dirty := false;
      FormShow(self);
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

procedure TfmSuppPayments.PrintCheque(ID: integer);
var
  ssql:String;
begin
  ssql:= chequeLib.SupplierPaychequeSQL(ID, SuppPayment.Amount, SuppPayment.ForeigncurrencyAmount);
//  with TStringList.Create do begin
//    text := ssql;
//    savetofile('c:\temp\temp.sql');
//    free;
//  end;
(*var
  sSQL: string;
  sMoney: string;
begin
  sMoney := CurrToStrF(SuppPayment.Amount, ffCurrency, 2);
  sMoney := FastFuncs.RightStr(sMoney, char_length(sMoney) - 1);
  sMoney := '**' + sMoney;
  sSQL := '{CompanyInfo}Select * , Concat(Address," ",Address2," ",City," ",tblCompanyInformation.State," ",tblCompanyInformation.Postcode) AS CompanyAddress from tblCompanyInformation '+
          ' ~|||~{TransDet} ' +'Select ' + quotedstr(MoneyWords(SuppPayment.Amount)) +' as AmountInWords, ' + quotedstr(sMoney) +' as DisplayAmount, ' + 'tblCompanyInformation.CompanyName, ' + 'Concat(Address," ",Address2," ",City," ",tblCompanyInformation.State," ",tblCompanyInformation.Postcode) AS CompanyAddress, ' +
          ' Concat("Phone ",PhoneNumber," Fax ",tblCompanyInformation.FaxNumber) AS PhoneFax, ' +
          ' Concat("ABN ",tblCompanyInformation.ABN) AS ABN, ' + 'tblWithdrawal.PaymentID,tblWithdrawal.SupplierID,Amount,tblWithdrawal.PayMethodID,ReferenceNo, ' +
          ' PaymentDate,  OpeningBalance,ClosingBalance,tblWithdrawal.ClassID,tblWithdrawal.AccountID, ' +
          ' Applied,UnApplied,tblWithdrawal.Notes,  TrnType,tblWithdrawalLines.OrderDate,PONo,OriginalAmount,tblWithdrawalLines.AmountDue, ' +
          ' AmountOutstanding,  tblWithdrawalLines.AmountDue-tblWithdrawalLines.AmountOutstanding AS AmountPaid,PaidInFull,  POID, ' +
          ' Company,AccountName,ClassName,tblPaymentMethods.Name AS PayMethod, ' +
          ' CONCAT_WS(" ",C.Title,C.FirstName,C.LastName) as ClientContactName,  C.Company as ClientCompany,C.Street as ClientStreet,C.Street2 as ClientStreet2,C.Suburb as ClientSuburb, ' +
          ' C.State as ClientState,C.Country as ClientCountry,C.Postcode as ClientPostcode,  C.BillStreet as ClientBillStreet,C.BillStreet2 as ClientBillStreet2,C.BillSuburb as ClientBillSuburb, ' +
          ' C.BillState as ClientBillState,C.BillCountry as ClientBillCountry,C.BillPostcode as ClientBillPostcode, ' + 'CONCAT_WS(" ",C.Suburb,C.State,C.Postcode) as ClientLocation, ' +
          ' CONCAT_WS(" ",C.BillSuburb,C.BillState,C.BillPostcode) as ClientBillLocation, ' +
          ' C.PHONE,C.FAXNumber,C.JobName,InvoiceNumber,tblWithdrawal.ForeignExchangeRate,tblWithdrawal.ForeignExchangeCode,ForeignCurrencyAmount ' +
          ' FROM tblCompanyInformation,tblWithdrawal ' +
          ' LEFT JOIN tblWithdrawalLines  ON tblWithdrawal.PaymentID=tblWithdrawalLines.PaymentID ' +
          ' LEFT JOIN tblClients C ON tblWithdrawal.SupplierID=C.ClientID ' +
          ' LEFT JOIN tblClass  ON tblWithdrawal.ClassID=tblClass.ClassID ' +
          ' LEFT JOIN tblChartOfAccounts  ON tblWithdrawal.AccountID=tblChartOfAccounts.AccountID ' +
          ' LEFT JOIN tblPaymentMethods  ON tblWithdrawal.PayMethodID=tblPaymentMethods.PayMethodID ' +
          ' LEFT JOIN tblpurchaseorders  ON tblWithdrawalLines.POID=tblpurchaseorders.PurchaseOrderID ' +
          ' WHERE tblWithdrawal.PaymentID = '+ inttostr(ID);*)
  fbReportSQLSupplied := true;
  PrintTemplateReport(TemplateToPrint('Supplier Payment Cheque' , chkChooseRpt.checked), sSQL, not(AppEnv.Employee.ShowPreview) and not(devmode), 1);
  SuppPayment.ChequePrinted := True;
  SuppPayment.PostDB;
  SuppPayment.Dirty := false;
  fbReportSQLSupplied := false;
end;

procedure TfmSuppPayments.NotesExit(Sender: TObject);
begin
  inherited;
  if accesslevel <= 2 then begin
    //Notes.text := AddDateTime(lcdOnSuppPayNotes, Notes.text);
    AddDateTime(lcdOnSuppPayNotes, Notes);
  end;
end;
procedure TfmSuppPayments.btnAddDateClick(Sender: TObject);
begin
  inherited;
  if accesslevel <= 2 then begin
    //Notes.text := AddDateTime(lcdOnLoganyway, Notes.text);
    AddDateTime(lcdOnLoganyway, Notes);
  end;
end;

procedure TfmSuppPayments.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then
    Exit;
  inherited;
  chkEFTClick(nil);
end;

procedure TfmSuppPayments.chkEFTClick(Sender: TObject);
begin
    SuppPayment.AddToEFT := chkEFT.Checked;
end;


procedure TfmSuppPayments.CloseFormAndPaymentList;
var
    TransPaymentList: TComponent;
begin
    Try
        TransPaymentList := GetBaseListingByClassNameNoCreate('TTransPaymentListGUI');
        if Assigned(TransPaymentList) then begin
            if (TransPaymentList.Owner.ClassName = 'TPurchaseGUI') then begin
                TTransPaymentListGUI(TransPaymentList).Close;
                if FormStillOpen('TPurchaseGUI') then
                    TPurchaseGUI(TransPaymentList.Owner).Close;
                while (FindExistingComponent('TPurchaseGUI')<>nil) do Begin
                    Application.ProcessMessages;
                    Sleep(0);
                end;
                Exit;
            end;
            if (TransPaymentList.Owner.ClassName = 'TBillGUI') then begin
                TTransPaymentListGUI(TransPaymentList).Close;
                if FormStillOpen('TBillGUI') then
                    TBillGUI(TransPaymentList.Owner).Close;
                while (FindExistingComponent('TBillGUI')<>nil) do Begin
                    Application.ProcessMessages;
                    Sleep(0);
                end;
                Exit;
            end;
            if (TransPaymentList.Owner.ClassName = 'TCreditGUI') then begin
                TTransPaymentListGUI(TransPaymentList).Close;
                if FormStillOpen('TCreditGUI') then
                    TCreditGUI(TransPaymentList.Owner).Close;
                while (FindExistingComponent('TCreditGUI')<>nil) do Begin
                    Application.ProcessMessages;
                    Sleep(0);
                end;
                Exit;
            end;
            if (TransPaymentList.Owner.ClassName = 'TfmSuppPrepayments') then begin
                TTransPaymentListGUI(TransPaymentList).Close;
                if FormStillOpen('TfmSuppPrepayments') then
                    TfmSuppPrepayments(TransPaymentList.Owner).Close;
                while (FindExistingComponent('TfmSuppPrepayments')<>nil) do Begin
                    Application.ProcessMessages;
                    Sleep(0);
                end;
                Exit;
            end;
        end;
    finally
        Application.ProcessMessages;
    end;
end;

procedure TfmSuppPayments.UseAccNoClick(Sender: TObject);
//var
//    TempText: string;
//    Searchfield :String;
//    Displayfield:String;

begin
//  DisableForm;
//  try
//    inherited;
//    TempText := cboClient.Text;
//    cboClientLookup.Close;
//    if not InAccountNoMode then begin
//        Label1.Caption :='Supplier Account No';
//        cboclientLookUp.SQL.text := AnsiReplaceStr(cboclientLookUp.SQL.text , 'GROUP BY Company' ,'AND ifnull(tblclients.ClientNo,"") <> "" GROUP BY Company');
//        Searchfield := 'company';
//        Displayfield:= 'clientNo';
//    end else begin
//        Label1.Caption := 'Supplier';
//        cboclientLookUp.SQL.text := AnsiReplaceStr(cboclientLookUp.SQL.text , 'AND ifnull(tblclients.ClientNo,"") <> "" GROUP BY Company' , 'GROUP BY Company');
//        Searchfield := 'clientNo';
//        Displayfield:= 'company';
//    end;
//    cboClientLookup.Open;
//    if not InAccountNoMode then
//         cboClient.Selected.Insert(0,'ClientNo' + #9 + '5' + #9 + 'Account No' + #9 + 'F' + #9)
//    else cboClient.Selected.Delete(0);
//
//    if cboClientLookup.Locate(Searchfield, TempText, [loCaseInsensitive]) and not Empty(TempText) then begin
//          cboClient.Text := cboClientLookup.FieldByName(Displayfield).AsString;
//    end else begin
//          cboClient.Clear;
//          cboClient.LookupValue := '';
//          cboClient.Value := '';
//          cboClient.Text := '';
//          cboClientCloseUp(cboClient, cboClient.lookupTable, cboClient.DataSource.DataSet, true);
//    end;
//    InAccountNoMode := not(InAccountNoMode);
//  finally
//    EnableForm;
//  end;
end;

function TfmSuppPayments.GetReportTypeID: integer;
begin
  Result := 27;
end;

procedure TfmSuppPayments.cboClientlookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(cboClientLookup.FieldByName('Balance')).currency := true;
end;

procedure TfmSuppPayments.btnReconciledClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowReconciledListForm(SuppPayment.ID, SuppPayment.TransType(*'Supplier Payment'*));
end;

procedure TfmSuppPayments.cboCreationDateChange(Sender: TObject);
begin
  inherited;
               if not (EmployeeHasAccess('AllowFutureDateinSupplierPayment')) and (cbocreationdate.date >date) then begin cbocreationdate.date := date; ShowTimedHint(cbocreationdate ,  'You Do not Have Access to Create Payments for Future Date.' +NL +'Date is Set back to Current Date' +NL, true );
      end else if not (EmployeeHasAccess('AllowPastDateinSupplierPayment'  )) and (cbocreationdate.date <date) then begin cbocreationdate.date := date; ShowTimedHint(cbocreationdate ,  'You Do not Have Access to Create Payments for Past Date.'+NL +'Date is Set back to Current Date'  +NL , true );
      end;
  (*if not (tblMaster.State in [dsEdit, dsInsert]) then
    Exit;
  if (tblMasterForeignExchangeCode.AsString <> AppEnv.RegionalOptions.ForeignExDefault) and (tblMasterForeignExchangeCode.AsString <> '') then begin
    tblMasterForeignExchangeRate.AsFloat := GetCurrentExchangeRate;
    tblMasterAmount.AsFloat := CommonLib.ForeignToLocal(tblMasterForeignCurrencyAmount.AsFloat, tblMasterForeignExchangeRate.AsFloat, 2);
  end;*)
end;

procedure TfmSuppPayments.cboCreationDateExit(Sender: TObject);
begin
  inherited;
  Hidehint(Sender);
end;

procedure TfmSuppPayments.SendReportEmail;
var
  UserID, TransactionDescription: string;
  EmailDate: TDateTime;
  SupplierName: string;
  PaymentNumber: string;
  strSQL:String;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
  Recipients: string;

  Procedure EnableEmailLabel(Enableflag:Boolean = True);
  begin
    lblEmail.Visible        := Enableflag;
    if Enableflag then      lblEmail.Update;
  end;

begin
  inherited;

  if not SuppPayment.Valid4Email then  exit;
  Corres := TCorrespondenceGui.Create;
  try
    Recipients := GetContactEmails(SuppPayment.ClientID, 'MainContactForSupplierPayment');
    Corres.RecipientList := Recipients;

    lSilent := Recipients <> '';
    SupplierName := SuppPayment.CompanyName;
    PaymentNumber := IntToStr(SuppPayment.PaymentNo);
    try
      lblEmail.Caption := 'Emailing, ' + WAITMSG;
      EnableEmailLabel(true);
        try
          Corres.Subject := 'Supplier Payment' + ' #' + PaymentNumber + ' for ' + SupplierName;
          Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
          Corres.AttachmentList.Add(SystemLib.WinTempDir + 'EmailReport.PDF');  //Corres.AttachmentList.Add(getOutGoingFileName('',' ' + SuppPayment.TransType + ' #' + PaymentNumber, '.PDF'));
          Corres.SupplierId := SuppPayment.ClientID;
          if lSilent and not EmailShortSendMode(lSilent, lSecret) then
            exit;

          if Corres.Execute(lSilent, lSecret) then begin
            UserID                          := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
            EmailDate                       := Now;
            TransactionDescription          := GetCompanyName + ' ' + SuppPayment.TransType + ' #' + PaymentNumber + ' for ' + SupplierName;
            strSQL := 'INSERT HIGH_PRIORITY INTO tblEmailedReports ' +
                    '(TransactionID, UserID, Date, ReportType, TransactionDescription)  ' +
                    'Values (' + QuotedStr(PaymentNumber) + ',' +
                    QuotedStr(UserID) + ',' +
                    QuotedStr(FormatDateTime(MysqlDateFormat,EmailDate)) + ',' +
                    QuotedStr(SuppPayment.TransType) + ',' +
                    QuotedStr(TransactionDescription) + ')';
            SuppPayment.GetNewDataSet(strSQL);
          end;
          DeleteFiles( Commonlib.TempDir , '*.PDF');
        finally
            EnableEmailLabel(false);
        end;
    except
        CommonLib.MessageDlgXP_Vista('There was an error sending the email', mtWarning, [mbOK], 0);
    end;
  finally
    Corres.Free;
  end;
end;


Procedure TfmSuppPayments.ManipulateFCControls;
begin
    ForeignAmount.Enabled       := SuppPayment.IsFCSelected;
    lblCurrencyAmount.Visible   := SuppPayment.ISFCSelected;
    ForeignAmount.Visible       := SuppPayment.ISFCSelected;
    lblExchangeRate.Visible     := SuppPayment.ISFCSelected;
    edtExchangeRate.Visible     := SuppPayment.ISFCSelected;
    lblVariationAmount.Visible  := SuppPayment.ISFCSelected;
    edtVariationAmount.Visible  := SuppPayment.ISFCSelected;
    lblVariationAccount.Visible := SuppPayment.ISFCSelected;
    cboVariationAccount.Visible := SuppPayment.ISFCSelected;
    lblMinus.Visible            := SuppPayment.ISFCSelected;
    lblVariation.Visible        := SuppPayment.ISFCSelected;
    lblApplied.Visible          := SuppPayment.ISFCSelected;
    lblEqual.Visible            := SuppPayment.ISFCSelected;
    txtVariationAmount2.Visible := SuppPayment.ISFCSelected;
    txtApplied2.Visible         := SuppPayment.ISFCSelected;
end;

procedure TfmSuppPayments.ManipulateRequiredControls;
var
    x:Integer;
begin
    ManipulateFCControls;
    SetForeignFieldDisplayFormat;
    chkDeleted.visible            := KeyID <> 0;
    lblDeleted.visible            := KeyID <> 0;
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAddToEFT') <> 1 then begin
        lblEFT.Visible := false;
        chkEFT.Visible := false;
    end else begin
        lblEFT.Visible := TRue;
        chkEFT.Visible := True;
    end;

    for x := 0 to ComponentCount - 1 do begin
        if Components[x] is TwwDBLookupCombo    then TwwDBLookupCombo(Components[x]).Enabled     := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TDBEdit             then TDBEdit(Components[x]).Enabled              := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TwwDBEdit           then TwwDBEdit(Components[x]).Enabled            := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TwwDBDateTimePicker then TwwDBDateTimePicker(Components[x]).Enabled  := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TwwCheckBox         then TwwCheckBox(Components[x]).Enabled          := (AccessLevel < 5) AND (KeyID  = 0);
        if Components[x] is TDNMSpeedButton     then
            if not (Assigned(TDNMSpeedButton(Components[x]).Action)) then
                TDNMSpeedButton(Components[x]).Enabled      := (AccessLevel < 5) AND (KeyID  = 0);
    end;
    RefenceNo.enabled := (Accesslevel =1);
    txtVariationAmount2.Enabled:= false;
    txtApplied2.Enabled:= false;
    btnReconciled.Visible         := SuppPayment.PaymentOnHold or SuppPayment.PaymentReconciled;
    btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');

    if chkEFT.Visible then chkEft.enabled := Accesslevel <5;

    chkDeleted.Enabled          := (KeyID <> 0) and (AccessLevel < 5);
    lblDeleted.Enabled          := (KeyID <> 0) and (AccessLevel < 5);
    edtVariationAmount.enabled  := False;
    txtBalance.enabled          := False;
    txtRecordID.enabled         := False;
    txtForeignApplied.enabled   := False;
    txtForeignUnapplied.enabled := False;
    txtApplied.enabled          := False;
    txtUnApplied.enabled        := False;
    if (KeyID = 0) then begin
        cboForeignCurrencyCode.Enabled  := (AccessLevel < 5) AND (SuppPayment.UseFC)     ;
        ForeignAmount.Enabled           := (AccessLevel < 5) AND (ForeignAmount.Visible) AND (SuppPayment.UseFC) ;
    end;
    Notes.Enabled                       := accesslevel < 5;
    btnAddDate.Enabled                  := (accesslevel < 5) ;
    SetGridAccess;
end;

procedure TfmSuppPayments.SetGridAccess;
begin
    if (AccessLevel = 5) or (KeyID  <> 0) or (self.SuppPayment.GUILines.TransID = 0) then
        grdPayments.Options   := grdPayments.Options - [dgEditing]
    else
        grdPayments.Options   := grdPayments.Options + [dgEditing];

end;


procedure TfmSuppPayments.cboForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then
    Exit;
  inherited;
  SuppPayment.GuiLines;
  ManipulateRequiredControls;
end;

procedure TfmSuppPayments.cboClientlookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  //cboClientlookup.Params.ParamByName('xClientID').asInteger := SuppPayment.clientID;

end;

procedure TfmSuppPayments.actSaveUpdate(Sender: TObject);
begin
  inherited;
    actSave.Enabled := (SuppPayment.dirty)  and
    (((SuppPayment.IsFCSelected) and SameValue(SuppPayment.ForeignApplied,SuppPayment.ForeigncurrencyAmount, 0.00001))
        or
    ((not(SuppPayment.IsFCSelected)) and SameValue(SuppPayment.Applied,SuppPayment.Amount,0.00001)));

    If not actSave.Enabled then
      actSave.Enabled := (KeyID<>0) and (not SuppPayment.Deleted) and chkDeleted.Checked;
end;

procedure TfmSuppPayments.actPrintchequeUpdate(Sender: TObject);
begin
  inherited;
    actPrintcheque.Enabled := (KeyID<> 0) or (SuppPayment.dirty);
end;

procedure TfmSuppPayments.actPrintreceiptUpdate(Sender: TObject);
begin
  inherited;
    actPrintreceipt.Enabled := (KeyID<> 0) or (SuppPayment.dirty);
end;

procedure TfmSuppPayments.actEmailUpdate(Sender: TObject);
begin
  inherited;
    actEmail.Enabled := (KeyID<> 0) or (SuppPayment.dirty);
end;

procedure TfmSuppPayments.actCancelUpdate(Sender: TObject);
begin
  inherited;
    actCancel.Enabled := true;
end;

procedure TfmSuppPayments.actNewUpdate(Sender: TObject);
begin
  inherited;
    actNew.Enabled := True;
end;

procedure TfmSuppPayments.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    if not suppPayment.Dirty then begin
        canclose := True;
        Notify(false);
        Exit;
    end;
    case CommonLib.MessageDlgXP_Vista('Do you wish to keep these changes you have made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
        begin
          if SaveData then begin
            Notify;
            CanClose := True;
          end else Canclose := False;
        end;
      mrNo:
        begin
          RollbackTransaction;
          suppPayment.Dirty := false;
          CanClose := True;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
end;

procedure TfmSuppPayments.actSaveExecute(Sender: TObject);
begin
  DisableForm;
  try
    if SaveData then
      Self.Close;
  finally
    EnableForm;
  end;
end;

procedure TfmSuppPayments.cboAccountQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    cboAccountQry.Params.ParamByName('CurrentID').AsInteger := SuppPayment.AccountID;
end;

procedure TfmSuppPayments.actApplyDiscountExecute(Sender: TObject);
var
  msg: string;
begin
  DisableForm;
  try
    inherited;
    if not SuppPayment.AddDiscountToOrder(msg) then
      CommonLib.MessageDlgXP_Vista(msg, mtInformation, [mbOk], 0);
  finally
    EnableForm;
  end;
end;

procedure TfmSuppPayments.actApplyDiscountUpdate(Sender: TObject);
begin
  inherited;
  actapplyDiscount.Enabled := (SuppPayment.TotalDiscount <> 0) or (SuppPayment.TotalRefunding <> 0);
end;

procedure TfmSuppPayments.actCancelExecute(Sender: TObject);
begin
  inherited;
    Self.Close;
end;

procedure TfmSuppPayments.grdPaymentsDblClick(Sender: TObject);
var
    TransForm :TBaseInputGUI;
    CurrId: integer;
    doRefresh: boolean;
begin
  inherited;
    doRefresh := true;
    if (SuppPayment.GUILines.TransID = 0)  Then Exit;
    SuppPayment.userLock.unLock('tblClients', SuppPayment.clientID, SuppPayment.LockGroupname);
    CurrId:= tblGuiDetailsID.AsInteger;
    try

        if Sysutils.SameText(SuppPayment.GuiLines.TransType, 'Prepayment') then begin
            SuppPayment.userLock.UnLock('tblPrePayments' , SuppPayment.GuiLines.TransID , SuppPayment.LockGroupname);
            try
              if FormStillOpen('TfmSuppPrepayments') then begin
                TransForm:= TBaseInputGUI(GetComponentByClassName('TfmSuppPrepayments'));
                TransForm.CloseMe;
                Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
              end;
              TransForm := TBaseInputGUI(GetComponentByClassName('TfmSuppPrepayments'));
              TransForm.KeyId :=SuppPayment.GuiLines.TransID;
              TransForm.showmodal;
              Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
            finally
              SuppPayment.userLock.Lock('tblPrePayments' , SuppPayment.GuiLines.TransID , SuppPayment.LockGroupname);
            end;
        end else begin
            SuppPayment.userLock.unLock('tblpurchaseorders' , SuppPayment.GuiLines.TransID , SuppPayment.LockGroupname);
            try
                if Sysutils.SameText(SuppPayment.GuiLines.TransType , POType) then begin
                    if FormStillOpen('TPurchaseGUI') then begin
                      TransForm:= TBaseInputGUI(GetComponentByClassName('TPurchaseGUI'));
                      TransForm.CloseMe;
                      Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                    end;
                    if not FormStillOpen('TPurchaseGUI') then begin
                      if SuppPayment.UpdatedPOList.InList(SuppPayment.GuiLines.TransID) then begin
                        MessageDlgXP_Vista('This Purchase Order has been updated (discount applied) so can not be opened untill payment has been saved.', mtInformation, [mbOK], 0);
                        doRefresh:= false;
                      end
                      else begin
                        TransForm:= TBaseInputGUI(GetComponentByClassName('TPurchaseGUI'));
                        TransForm.KeyId :=SuppPayment.GuiLines.TransID;
                        TransForm.Showmodal;
                        Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                      end;
                    end;
                end else if Sysutils.SameText(SuppPayment.GuiLines.TransType , RAType) then begin
                    if FormStillOpen('TReturnAGUI') then begin
                      TransForm:= TBaseInputGUI(GetComponentByClassName('TReturnAGUI'));
                      TransForm.CloseMe;
                      Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                    end;
                    TransForm:= TBaseInputGUI(GetComponentByClassName('TReturnAGUI'));
                    TransForm.KeyId :=SuppPayment.GuiLines.TransID;
                    TransForm.showmodal;
                    Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                end else if Sysutils.SameText(SuppPayment.GuiLines.TransType , CreditType) then begin
                    if FormStillOpen('TCreditGUI') then begin
                      TransForm:= TBaseInputGUI(GetComponentByClassName('TCreditGUI'));
                      TransForm.CloseMe;
                      Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                    end;
                    TransForm:= TBaseInputGUI(GetComponentByClassName('TCreditGUI'));
                    TransForm.KeyId :=SuppPayment.GuiLines.TransID;
                    TransForm.Showmodal;
                    Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                end else if Sysutils.SameText(SuppPayment.GuiLines.TransType , Billtype) then begin
                    if FormStillOpen('TBillGUI') then begin
                      TransForm:= TBaseInputGUI(GetComponentByClassName('TBillGUI'));
                      TransForm.CloseMe;
                      Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                    end;
                    if not FormStillOpen('TBillGUI') then begin
                      if SuppPayment.UpdatedPOList.InList(SuppPayment.GuiLines.TransID) then begin
                        MessageDlgXP_Vista('This Bill has been updated (discount applied) so can not be opened untill payment has been saved.', mtInformation, [mbOK], 0);
                        doRefresh:= false;
                      end
                      else begin
                        TransForm:= TBaseInputGUI(GetComponentByClassName('TBillGUI'));
                        TransForm.KeyId :=SuppPayment.GuiLines.TransID;
                        TransForm.Showmodal;
                        Application.ProcessMessages;//Don't remove it , needs to Destroy the transform before finally
                      end;
                    end;
                end;
            finally
                SuppPayment.userLock.Lock('tblpurchaseorders' , SuppPayment.GuiLines.TransID , SuppPayment.LockGroupname);
            end;
        end;
        tblGuiDetails.Locate('ID',CurrId,[]);
    finally
        SuppPayment.userLock.Lock('tblClients', SuppPayment.clientID, SuppPayment.LockGroupname);
        if doRefresh and (KeyID=0) then
          SuppPayment.RefreshguiLines;
    end;
end;

procedure TfmSuppPayments.grdPaymentsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  inherited;
  if AFieldName = 'Apply' then begin
      if devmode then begin
        SuppPayment.GUILines.DoFieldChangewhenDisabled:= true;
        try
          SuppPayment.GUILines.IterateRecords(ApplyCallback);
        finally
            SuppPayment.GUILines.DoFieldChangewhenDisabled:= False;
        end;
      end;
  end;
end;

procedure TfmSuppPayments.InitERPLookupCombonFields;
begin
  inherited;
  if tblmaster.active then
       NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(SuppPayment.clientId,  cboClient,True, False, False, False, true, 'ClientPrintName' , nil, true)
  else NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(0,  cboClient,True, False, False, False, true, 'ClientPrintName' , nil, true);
end;

procedure TfmSuppPayments.InitGuiPrefsReadonlyFields;
begin
  inherited;
  guiprefs.AddreadonlyField('OrderDate', tblguiDetails);
  guiprefs.AddreadonlyField('Type', tblguiDetails);
  guiprefs.AddreadonlyField('PurchaseOrderNumber', tblguiDetails);
  guiprefs.AddreadonlyField('RefNo', tblguiDetails);
  guiprefs.AddreadonlyField('AmountOutStanding', tblguiDetails);
  guiprefs.AddreadonlyField('ForeignAmountOutstanding', tblguiDetails);
  guiprefs.AddreadonlyField('ForeignExchangeRate', tblguiDetails);
  guiprefs.AddreadonlyField('InvoiceNumber', tblguiDetails);
  guiprefs.AddreadonlyField('OriginalAmount', tblguiDetails);
  guiprefs.AddreadonlyField('ForeignOriginalAmt', tblguiDetails);
  guiprefs.AddreadonlyField('Balance', tblguiDetails);
  guiprefs.AddreadonlyField('ForeignBalanceAmount', tblguiDetails);
  guiprefs.AddreadonlyField('EnteredBy', tblguiDetails);
end;

procedure TfmSuppPayments.lblDisableCalcClick(Sender: TObject);
begin
  inherited;
  SuppPayment.CalcTotals;
end;

procedure TfmSuppPayments.grdPaymentsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
    inherited;
    if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
    if SuppPayment.GUILines.ForeignExchangeCode = SuppPayment.ForeignExchangeCode then
        Afont.color := clblack
    else afont.color := clgray;

    If tblGuiDetailsApply.asBoolean then
      ABrush.Color := $00C4FFE1;
    if field = self.tblGuiDetailsForeignPayment then
      AFont.Color := clPurple;
end;

procedure TfmSuppPayments.SetForeignFieldDisplayFormat;
var
  fmt: string;
begin
  fmt:= TCurrency.CurrencySymbolForCode(self.SuppPayment.ForeignExchangeCode, self.MyConnection);
  fmt:= fmt + '#,##0.00';
  if tblPODetails.Active then begin
    tblPODetailsForeignTotalAmount.DisplayFormat:= fmt;
    tblPODetailsForeignPaidAmount.DisplayFormat:= fmt;
    tblPODetailsForeignBalanceAmount.DisplayFormat:= fmt;
  end;
  if tblGuiDetails.Active then begin
    tblGuiDetailsForeignOriginalAmt.DisplayFormat:= fmt;
    tblGuiDetailsForeignBalanceAmount.DisplayFormat:= fmt;
    tblGuiDetailsForeignPayment.DisplayFormat:= fmt;
    tblGuiDetailsForeignAmountOutstanding.DisplayFormat:= fmt;
  end;
  if tblMaster.Active then begin
    tblMasterForeignCurrencyAmount.DisplayFormat:= fmt;
    tblMasterForeignApplied.DisplayFormat:= fmt;
    tblMasterForeignUnApplied.DisplayFormat:= fmt;
  end;
end;

procedure TfmSuppPayments.cboForeignCurrencyCodeChange(Sender: TObject);
begin
  inherited;
  SetForeignFieldDisplayFormat;
end;

procedure TfmSuppPayments.txtAppliedEnter(Sender: TObject);
begin
  abort;
  inherited;

end;

procedure TfmSuppPayments.txtAmountChange(Sender: TObject);
begin
  inherited;
  if Assigned(LastActiveControl) and (LastActiveControl = txtAmount) then
    UserChangedPaymentAmount:= true;
  if txtAmount.Text = '' then
    txtAmount.Text:= '0';
end;


procedure TfmSuppPayments.btnContactsClick(Sender: TObject);
begin
  // this component is made invisible ????? so no click event
  // use the contact list insted of 'TfrmContactSelector' form if needed
end;

procedure TfmSuppPayments.ForeignAmountChange(Sender: TObject);
begin
  inherited;
  if Assigned(LastActiveControl) and (LastActiveControl = ForeignAmount) then
    UserChangedPaymentAmount:= true;
end;

procedure TfmSuppPayments.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  LastActiveControl:= self.ActiveControl;
end;

(*procedure TfmSuppPayments.UpdateFromContact(const value: Tdataset);
begin
//
end;*)

procedure TfmSuppPayments.tblGuiDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblDisableCalc.visible := SuppPayment.GUILines.count > appenv.CompanyPrefs.SuppPayLinesToDisableCalcs;
end;

procedure TfmSuppPayments.tblGuiDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if (tblGuiDetailsType.AsString = 'Bill') or (tblGuiDetailsType.AsString = 'Prepayment') then
    tblGuiDetailsDateCalculated.AsString := 'N/A'
  else if tblGuiDetailsInvoiceDate.AsDateTime = 0 then
    tblGuiDetailsDateCalculated.AsString := 'N/A'
  else
    tblGuiDetailsDateCalculated.AsString := FormatDateTime('dd/mm/yyyy',tblGuiDetailsInvoiceDate.AsDateTime);
end;

function TfmSuppPayments.SaveData: boolean;
var
  msg: string;
begin
  Result := False;
  if lblDisableCalc.visible then lblDisableCalcClick(lblDisableCalc);
  if (SuppPayment.Amount < 0)  then begin
    if MessageDlgXP_Vista('The payment amount is a negative value, ' +
      'do you wish to Save this payment anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
  end;

  if (SuppPayment.TotalDiscount <> 0) or (SuppPayment.TotalRefunding <> 0) then begin
    if commonlib.MessageDlgXP_Vista('Do you wish to apply the Discounts/Refund? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      if not SuppPayment.AddDiscountToOrder(msg) then
        CommonLib.MessageDlgXP_Vista(msg, mtInformation, [mbOk], 0);
    end;
    Exit;
  end;

  If (KeyID <> 0) and SuppPayment.AddToEFT and not SuppPayment.Deleted then Begin
    SuppPayment.CreateABARecord;
    Result := True;
  end else Begin
    SuppPayment.UpdateFCHistory;
    if SuppPayment.Save then begin
      SuppPayment.Connection.CommitTransaction;
      Result := True;
    end;
  end;
end;

procedure TfmSuppPayments.btnSelectallClick(Sender: TObject);
var
  bm: TBookmark;
begin
  inherited;
  bm:= tblGuiDetails.GetBookmark;
  try
    tblGuiDetails.First;
    while not tblGuiDetails.EOF do begin
      EditDb(tblGuiDetails);
      tblGuiDetails.FieldByName('Apply').AsBoolean:= true;
      PostDb(tblGuiDetails);
      tblGuiDetails.Next;
    end;
  finally
    tblGuiDetails.GotoBookmark(bm);
  end;
end;

initialization
  RegisterClassOnce(TfmSuppPayments);
  with FormFact do begin
    RegisterMe(TfmSuppPayments, 'TSuppPaymentListGUI_*=PaymentID');
    RegisterMe(TfmSuppPayments, 'TBankAccountListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TBalTransListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TCashProfitandLossGUI_*_Supplier Payment=PaymentId');
    RegisterMe(TfmSuppPayments, 'TToBeReconciledGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TReconListDetailFormGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TTrialBalTransListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TTransactionListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TBASTransReturnListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TNZTransReturnListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TVATTransReturnListGUI_*_Supplier Payment=PaymentID');

    RegisterMe(TfmSuppPayments, 'TTransactionListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TBASTransReturnListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TNZTransReturnListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TVATTransReturnListGUI_*_Supplier Payment=PaymentID');

    RegisterMe(TfmSuppPayments, 'TGlobalsearchGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TGlobalsearchGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TTransAccountDetailsGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TGeneralLedgerReportGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TSupplierStatementGUI_*_Supplier Payment=PurchaseOrderID');
    RegisterMe(TfmSuppPayments, 'TTransPaymentListGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TTransPaymentListGUI_*_Supplier Prepayment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TCashBasisDetailsGUI_*_Supplier Payment=PaymentID');
    RegisterMe(TfmSuppPayments, 'TAllTransactionGUI_*_Suppliler Payment=TransNo');
    RegisterMe(TfmSuppPayments, 'TPrintchequesGUI_*_Payment=TRansID');
    RegisterMe(TfmSuppPayments, 'TPaymentListGUI_*_'+SUPPLIER_PAYMENT+'=PaymentID');
  end;
end.






