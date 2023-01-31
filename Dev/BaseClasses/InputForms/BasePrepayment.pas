unit BasePrepayment;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/09/05  1.00.01 IJB  Modified to use new procedure
                        (PaymentsLibGUI.ShowReconciledListForm) to replace
                        procedure removed from TransLockManagementObj.
 13/10/05  1.00.02 AL   Moved foreign currency functionality from Descendand
                        (frmSupplierPrepaymentGUI) and fixed bugs                       
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,   StdCtrls,
  wwcheckbox, kbmMemTable, DBCtrls, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton,
  wwdbdatetimepicker, wwdblook, Mask, MyAccess,ERPdbComponents, MemDS, DBAccess,
  DataState, wwdbedit, Menus, AdvMenus, Shader, busobjPrepayments, BusObjBase,
  ImgList, ERPDbLookupCombo, ProgressDialog;

type
  TBasePrepaymentGUI = class(TBaseInputGUI)
    Box30: TBevel;
    lblPaymentDate: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label23: TLabel;
    cboPayMethod_Label: TLabel;
    Label29: TLabel;
    ClassLabel: TLabel;
    Label81: TLabel;
    txtAmount: TDBEdit;
    RefenceNo: TDBEdit;
    cboClient: TERPDBLookupCombo;
    cboCreationDate: TwwDBDateTimePicker;
    cboClass: TwwDBLookupCombo;
    cboAccount: TwwDBLookupCombo;
    cboPaymentMethod: TwwDBLookupCombo;
    txtRecordID: TDBEdit;
    btnPopup: TDNMSpeedButton;
    Notes: TDBMemo;
    Label28: TLabel;
    Bevel1: TBevel;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    tblMasterGlobalRef: TWideStringField;
    tblMasterPrePaymentID: TAutoIncField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterClientID: TIntegerField;
    tblMasterPrePaymentDate: TDateField;
    tblMasterPayAmount: TFloatField;
    tblMasterPayMethodID: TIntegerField;
    tblMasterNotes: TWideStringField;
    tblMasterReferenceNo: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterClassID: TIntegerField;
    tblMasterMasterAccountID: TIntegerField;
    tblMasterBankAccountID: TIntegerField;
    tblMasterCustomer: TWideStringField;
    tblMasterSupplier: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterReconciled: TWideStringField;
    tblMasterDepositID: TIntegerField;
    tblMasterReconciliationID: TIntegerField;
    tblMasterBankAccountName: TWideStringField;
    tblMasterBankAccountBSB: TWideStringField;
    tblMasterBankAccountNo: TWideStringField;
    tblMasterCompanyName: TWideStringField;
    tblMasterPaid: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterPayment: TFloatField;
    tblMasterDeposited: TWideStringField;
    Label5: TLabel;
    txtAvailCredit: TDBEdit;
    Label6: TLabel;
    txtApplyCredit: TDBEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    qryPayMethod: TERPQuery;
    cboAccountQry: TERPQuery;
    cboClassQry: TERPQuery;
    cboClientlookup: TERPQuery;
    btnPayments: TDNMSpeedButton;
    btnReconciled: TDNMSpeedButton;
    lblForeignCurrencyCode: TLabel;
    lblExchangeRate: TLabel;
    lblForeignAmount: TLabel;
    cboForeignCurrencyCode: TwwDBLookupCombo;
    edtExchangeRate: TwwDBEdit;
    edtForeignAmount: TwwDBEdit;
    qryBaseForeignCurrency: TERPQuery;
    qryBaseForeignCurrencyCurrencyID: TIntegerField;
    qryBaseForeignCurrencyCountry: TWideStringField;
    qryBaseForeignCurrencyCurrency: TWideStringField;
    qryBaseForeignCurrencyCode: TWideStringField;
    qryBaseForeignCurrencyBuyRate: TFloatField;
    qryBaseForeignCurrencyActive: TWideStringField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignPayAmount: TFloatField;
    tblMasterForeignPaid: TFloatField;
    tblMasterForeignBalance: TFloatField;
    tblMasterForeignPayment: TFloatField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnDeposit: TDNMSpeedButton;
    tblMasterEnteredAt: TDateTimeField;
    DNMPanel1: TDNMPanel;
    Label11: TLabel;
    lblEFT: TLabel;
    cmdPrint: TDNMSpeedButton;
    cmdSave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkDeleted: TwwCheckBox;
    cmdNew: TDNMSpeedButton;
    chkEFT: TwwCheckBox;
    procedure cmdNewClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkDeletedClick(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure btnReconciledClick(Sender: TObject);
    procedure cboForeignCurrencyCodeChange(Sender: TObject);
    procedure cboForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPopupClick(Sender: TObject);
    procedure OnLookupComboEnter(Sender: TObject);
    procedure cboPaymentMethodCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnDepositClick(Sender: TObject);
  private
    fsChequeNumber      : string;
    fsBankAccountName   : string;
    fsBankAccountBSB    : string;
    fsBankAccountNo     : string;
  Protected
    PrePayment      : TPrePayments;
    procedure AllowSave; virtual;
    Procedure AllowDelete;
    procedure Print(ID: integer);
    procedure ShowFXControls;
    procedure EnableFXControls(Enabled, ccEnabled: boolean);
    function SaveAndCommit: boolean; virtual;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure InitERPLookupCombonFields; Override;
  public
    property BankAccountName: string read fsBankAccountName write fsBankAccountName;
    property BankAccountBSB : string read fsBankAccountBSB  write fsBankAccountBSB;
    property BankAccountNo  : string read fsBankAccountNo   write fsBankAccountNo;
    property ChequeNumber   : string read fsChequeNumber    write fsChequeNumber;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);override;

  end;


implementation
  
uses FastFuncs, DNMExceptions, 
  TransPaymentList, PaymentsLibGUI,
  CommonLib,AppEnvironment, BusObjConst, frmPaymentsChequeDetails, tcConst,
  frmSuppPrepayments, frmCustPrepayments;

  {$R *.dfm}

procedure TBasePrepaymentGUI.cmdNewClick(Sender: TObject);
begin
    if not SaveAndCommit then Exit;
    PrePayment.UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser; //Binny -UnlockAllCurrentUser removes locking from other forms are well
    cboClientlookup.Close;
    cboClientlookup.Open;
    PrePayment.connection.BeginTransaction;
    PrePayment.New;
    KeyID := 0;
    cboClient.Enabled := True;
    btnReconciled.Visible   := PrePayment.IsPrepaymentReconciled;
    btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');
    if (PrePayment is TCustPrePayments) then
      btnDeposit.Visible := TCustPrePayments(PrePayment).IsPrepaymentDeposited;
    btnPayments.Visible := PrePayment.IsPrepaymentApplied;
    AllowSave;
    SetControlFocus(cboClient);

    try
        ProcessingCursor(True);
        cboClientLookup.Active := False;
        cboClientLookup.Active := True;
    finally
        ProcessingCursor(False);
    end;
  ShowFXControls;
end;

procedure TBasePrepaymentGUI.cmdCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TBasePrepaymentGUI.cmdPrintClick(Sender: TObject);
begin
  inherited;
  if not SaveAndCommit then Exit;
  Print(PrePayment.Id);
  Self.Close;
end;

procedure TBasePrepaymentGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  try
    inherited;
    ClassLabel.Caption       := AppEnv.DefaultClass.ClassHeading;
    MyConnection.Connected := True;

    PrePayment.Connection.BeginTransaction;

    PrePayment.Load(KeyID);

    if KeyID <> 0 then begin
        Label11.Visible   := True;
        chkDeleted.Visible:= True;
        if not (PrePayment.lock) then begin
            Self.Caption            := self.Caption + '     {' + PrePayment.LockMsg +'}';
            Accesslevel             := 5;
            cmdSave.Enabled         := False;
            cboPaymentMethod.Enabled:= False;
            cboCreationDate.Enabled := False;
            txtAmount.Enabled       := False;
            cboClass.Enabled        := False;
            cboAccount.Enabled      := False;
            Label11.Enabled         := False;
            chkDeleted.Enabled      := False;
        end else begin
            cboPaymentMethod.Enabled:= True;
            cboCreationDate.Enabled := True;
            txtAmount.Enabled       := True;
            cboClass.Enabled        := True;
            cboAccount.Enabled      := True;
            Label11.Enabled         := True;
            cmdSave.Enabled         := True;
            chkDeleted.Enabled      := (AccessLevel = 1) and (not(Prepayment.CleanDeleted));
        end;
      btnReconciled.Visible   := PrePayment.IsPrepaymentReconciled OR PrePayment.IsPrepaymentonHold;
      btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');

      if (PrePayment is TCustPrePayments) then
        btnDeposit.Visible := TCustPrePayments(PrePayment).IsPrepaymentDeposited;
      btnPayments.Visible := PrePayment.IsPrepaymentApplied;

      cmdPrint.Enabled  := True;
      cboClient.Enabled := False;
    end else begin
      PrePayment.New;
      cboClient.Enabled := True;
    end;

    cboAccountQry.Params.ParamByName('CurrentID').AsInteger := Prepayment.BankAccountID;
    //Maybe Inactive
    Setlength(QueryNamesNotToOpen,1);
    QueryNamesNotToOpen[0] := 'tblMaster';
    OpenQueries;
    AllowSave;
    SetControlFocus(cboClient);
    tblMasterEnteredAt.DisplayFormat := FormatSettings.ShortDateformat;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TBasePrepaymentGUI.InitERPLookupCombonFields;
begin
  inherited;
  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(
    tblMasterClientID.AsInteger,
    cboClient,
    (self is TfmSuppPrepayments) ,
    (self is TfmCustPrepayments) ,
     False, (self is TfmCustPrepayments) ,
    true, 'ClientPrintName' , nil , true);
end;

procedure TBasePrepaymentGUI.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
    if not Modified then Exit;
    inherited;
    AllowSave;
    ShowFXControls;
end;

procedure TBasePrepaymentGUI.AllowSave;
begin
  cmdSave.Enabled  := (AccessLevel < 5);// and (StrValue(txtAmount.Text) = 0);
  cmdNew.Enabled  := cmdSave.Enabled;
  AllowDelete;
end;

procedure TBasePrepaymentGUI.Print(ID: integer);
var
  sSQL: string;
  sTemplateName: string;
begin

  if Self.ClassName = 'TfmCustPrepayments' then begin
    sSQL := Format('~|||~ AND PP.PrePaymentID = %d', [ID]);
    sTemplateName := 'Customer PrePayment';
  end else if Self.ClassName = 'TfmSuppPrepayments' then begin
    sSQL := Format('~|||~ AND tblprepayments.PrePaymentID = %d', [ID]);
    sTemplateName := 'Supplier Prepayment';
  end;
  PrintTemplateReport(sTemplateName, sSQL, not AppEnv.Employee.ShowPreview, 1);
end;

procedure TBasePrepaymentGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RemoveFlag('FirstSupplierPrepaymentShow');
end;

Procedure TBasePrepaymentGUI.AllowDelete;
begin
    if chkDeleted.Enabled then
        chkDeleted.Enabled := Prepayment.Payment = 0.00;
end;

procedure TBasePrepaymentGUI.chkDeletedClick(Sender: TObject);
begin
  inherited;
  cmdSave.Enabled := (chkDeleted.Checked );
end;

procedure TBasePrepaymentGUI.btnPaymentsClick(Sender: TObject);
var
  TempSQL           : string;
  TransPaymentList  : TComponent;
begin
  inherited;

    if (Self.ClassName = 'TfmCustPrepayments') then begin
        TempSQL:= 'SELECT ' + Quotedstr(CUSTOMER_PAYMENT) +' as DblClickType , Concat_ws("",PaymentNo) as "Receipt No",' +
                  ' PaymentDate as "Payment Date",Payment as "Payment Amount", ' +
                  ' ReferenceNo as "Reference No",tbldepositline.PaymentID ' +
                  ' FROM tbldeposits INNER JOIN tbldepositline Using(PaymentID) ' +
                  ' WHERE CustomerPayment="T" AND tbldeposits.Customer="T" ' +
                  ' AND Deleted="F" AND TrnType="Prepayment" ' +
                  ' AND PrePaymentID=' + IntToStr(Prepayment.ID) +
                  ' ORDER BY PaymentDate DESC;';
    end else if (Self.ClassName = 'TfmSuppPrepayments') then begin
        TempSQL:= 'SELECT  ' + Quotedstr(SUPPLIER_PAYMENT) +' as DblClickType , Concat_ws("",PaymentNo) as "Receipt No",' +
                  ' PaymentDate as "Payment Date",Payment as "Payment Amount", ' +
                  ' ReferenceNo as "Reference No",tblwithdrawallines.PaymentID ' +
                  ' FROM  tblwithdrawal INNER JOIN tblwithdrawallines Using(PaymentID) ' +
                  ' WHERE SupplierPayment="T" AND tblwithdrawal.Supplier="T" ' +
                  ' AND Deleted="F" AND TrnType="Prepayment" ' +
                  ' AND PrePaymentID=' + IntToStr(Prepayment.ID) +
                  ' ORDER BY PaymentDate DESC;';
    end else begin
        Exit;
    end;

    if FormStillOpen('TTransPaymentListGUI') then begin
        TransPaymentList := FindExistingComponent('TTransPaymentListGUI');
        if Assigned(TransPaymentList) then TTransPaymentListGUI(TransPaymentList).Close;
    end  else begin
        TransPaymentList := GetComponentByClassName('TTransPaymentListGUI');
        if Assigned(TransPaymentList) then begin
            TTransPaymentListGUI(TransPaymentList).qryMain.SQL.Text := TempSQL;
            TTransPaymentListGUI(TransPaymentList).RefreshOrignalSQL;
            //TTransPaymentListGUI(TransPaymentList).DblClickType := PrePayment.Transtype;
            TTransPaymentListGUI(TransPaymentList).FormStyle := fsMDIChild;
        end;
    end;
end;

procedure TBasePrepaymentGUI.btnReconciledClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowReconciledListForm(Prepayment.ID, Prepayment.Transtype);
end;

procedure TBasePrepaymentGUI.ShowFXControls;//(Visible, ccVisible: boolean);
begin

  if PrePayment.ForeignExchangeCode = AppEnv.RegionalOptions.ForeignExDefault then begin
    edtExchangeRate.Enabled         := False;
    edtForeignAmount.Enabled        := False;
    cboForeignCurrencyCode.Enabled  := AppEnv.CompanyPrefs.UseForeignCurrencyonPO;
    edtExchangeRate.Enabled         := False;
    lblForeignAmount.Visible        := False;
    edtForeignAmount.Visible        := False;
  end else begin
    cboForeignCurrencyCode.Enabled  := True;
    edtExchangeRate.Enabled         := True;
    edtForeignAmount.Enabled        := True;
    edtExchangeRate.Enabled         := True;
    lblForeignAmount.Visible        := True;
    edtForeignAmount.Visible        := True;
  end;

end;

procedure TBasePrepaymentGUI.EnableFXControls(Enabled, ccEnabled: boolean);
begin
  cboForeignCurrencyCode.Enabled := ccEnabled;
  edtExchangeRate.Enabled := Enabled;
  edtForeignAmount.Enabled := Enabled;
end;

procedure TBasePrepaymentGUI.cboForeignCurrencyCodeChange(Sender: TObject);
begin
  inherited;
  ShowFXControls;
end;

procedure TBasePrepaymentGUI.cboForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  cboForeignCurrencyCodeChange(nil);
end;

procedure TBasePrepaymentGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Prepayment.busobjEvent    := DoBusinessObjectEvent;
  Prepayment.ConfirmFromGUI := ConfirmFromGUI;
  cboClient.Selected.Text   := Commonlib.ReplaceStr(cboClient.Selected.Text,'$',AppEnv.RegionalOptions.CurrencySymbol);
end;
procedure TBasePrepaymentGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
      if Sender is TPrePayments         then TPrePayments(Sender).DataSet     := tblMaster;
  end
  else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ClientID) then begin
   // if cboClient then
    

  end;

end;

procedure TBasePrepaymentGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if Prepayment.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if SaveAndCommit then begin
            notify(False);
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          Prepayment.Connection.RollbackTransaction;
          Prepayment.Dirty := false;
          CanClose := true;
          notify(True);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;
end;

procedure TBasePrepaymentGUI.btnPopupClick(Sender: TObject);
begin
    inherited;
    BankAccountName     := PrePayment.BankAccountName;
    BankAccountBSB      := PrePayment.BankAccountBSB;
    BankAccountNo       := PrePayment.BankAccountNo;
    ChequeNumber        := PrePayment.ReferenceNo;

    if Empty(fsBankAccountName) and Empty(fsBankAccountBSB) and Empty(fsBankAccountNo) and Empty(fsChequeNumber) then begin
        BankAccountName := PrePayment.Client.BankAccountName; //   cboClientlookup.FieldByName('BankAccountName').AsString;
        BankAccountBSB  := PrePayment.Client.BankAccountBSB; // cboClientlookup.FieldByName('BankAccountBSB').AsString;;
        BankAccountNo   := PrePayment.Client.BankAccountNo; // cboClientlookup.FieldByName('BankAccountNo').AsString;;
        ChequeNumber    := '';
    end;
    with TPaymentChequeDetails.Create(self) do begin
        ClientID := cboClientLookup.FieldByName('ClientID').AsInteger;
        ChequeBankAccountName:= PrePayment.BankAccountName;
        ChequeBankAccountBSB := PrePayment.BankAccountBSB;
        ChequeBankAccountNo  := PrePayment.BankAccountNo;
        ChequeChequeNumber   := PrePayment.ReferenceNo;



        if (ShowModal = mrOk) then begin
            PrePayment.BankAccountName  := BankAccountName;
            PrePayment.BankAccountBSB   := BankAccountBSB;
            PrePayment.BankAccountNo    := BankAccountNo;
            PrePayment.ReferenceNo      := ChequeNumber;
            PrePayment.PostDB;
            cboClientlookup.Refresh;
        end;
    end;
end;
procedure TBasePrepaymentGUI.UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);
begin
  if not Cancelled then  begin
    if Sysutils.SameText(fLastComboAccessed.name, 'cboClientlookup') then begin
        if Assigned(fLastComboAccessed) then     begin
            {this is to keep showing the value when lookup form opened by double clicking on the component}
            TERPQuery(fLastComboAccessed.LookupTable).RefreshREcord;
            TERPQuery(PrePayment.Client.Dataset).RefreshREcord;//used for validations
        end;
    end;
    if Sysutils.SameText(fLastComboAccessed.name, 'cboAccount') then begin
        if PrePayment is TSuppPrePayments then
            TSuppPrePayments(Prepayment).GLAccount.Dataset.RefreshRecord;
    end;
  end;
end;
procedure TBasePrepaymentGUI.OnLookupComboEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TBasePrepaymentGUI.cboPaymentMethodCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
    if Prepayment.PayMethodID = 0 then
        cboPaymentMethod.text := '';
end;

procedure TBasePrepaymentGUI.btnDepositClick(Sender: TObject);
begin
  inherited;
  //PaymentsLibGUI.ShowDepositedListForm(Prepayment.ID,'Prepayment');
end;

function TBasePrepaymentGUI.SaveAndCommit: boolean;
begin
  result:= false;
  if (not self.PrePayment.Dirty) or PrePayment.Save then begin
    PrePayment.Connection.CommitTransaction;
    result:= true;
  end;  
end;

end.









