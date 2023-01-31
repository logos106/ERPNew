unit frmPaymentsChequeDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, DNMPanel, StdCtrls,
  Mask, wwdbedit, Buttons, DNMSpeedButton, SelectionDialog, AppEvnts, DB,  DBAccess,
  MyAccess,ERPdbComponents, DBCtrls, DataState, Menus, AdvMenus, Shader, MemDS, wwdblook,
  ImgList, ProgressDialog;

type
  TPaymentChequeDetails = class(TBaseInputGUI)
    cmdClose: TDNMSpeedButton;
    edtBankAccNo: TwwDBEdit;
    Label12: TLabel;
    edtBankAccBSB: TwwDBEdit;
    lblBSB: TLabel;
    edtBankAccName: TwwDBEdit;
    Label10: TLabel;
    Bevel1: TBevel;
    BitBtn1: TDNMSpeedButton;
    Label29: TLabel;
    edtChequeNo: TwwDBEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboBankCode: TwwDBLookupCombo;
    Label1: TLabel;
    qryBankCodes: TERPQuery;
    DSBankCodes: TDataSource;
    lblbsbmask: TLabel;
    lblAccountnomask: TLabel;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    tblMasterClientID: TIntegerField;
    tblMasterBankAccountNo: TWideStringField;
    tblMasterBankAccountName: TWideStringField;
    tblMasterBankAccountBSB: TWideStringField;
    tblMasterBankCode: TWideStringField;
    tblMasterChequeno: TWideStringField;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBankAccNameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBankAccNoExit(Sender: TObject);
    procedure edtBankAccNameEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);

  private
    { Private declarations }
    modified : boolean;
    fiClientID: integer;
    SaveAccountName: string;
    SaveBSB: string;
    SaveAccountNo: string;
    SaveBankCode: string;
    Formshown:Boolean;
    fsTablename :String;
    function ValidateData: boolean;
    procedure setClientID(const Value: integer);
    procedure setChequeBankAccountBSB(const Value: string);
    procedure setChequeBankAccountName(const Value: string);
    procedure setChequeBankAccountNo(const Value: string);
    procedure setChequeChequeNumber(const Value: string);
  public
    { Public declarations }
    property ClientID : integer read fiClientID write setClientID;

    property ChequeBankAccountName: string write setChequeBankAccountName;
    property ChequeBankAccountBSB : string write setChequeBankAccountBSB;
    property ChequeBankAccountNo  : string write setChequeBankAccountNo;
    property ChequeChequeNumber   : string write setChequeChequeNumber;


  end;

implementation

uses
  frmCustPrepayments, frmSuppPrepayments, frmcustPayments,tcDataUtils,
  CommonDbLib, POSScreenGUI, CommonLib, FastFuncs, BasePrepayment, tcConst,
  AppEnvironment, tcTypes, frmSplitInvoicePayment, BusObjClient;

{$R *.dfm}

{ TPaymentChequeDetails }

procedure TPaymentChequeDetails.cmdCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TPaymentChequeDetails.FormCreate(Sender: TObject);
begin
  fsTablename :=CreateUserTemporaryTable('tmp_chequeDetails');
  if tblMaster.active then tblMaster.close;
  tblMaster.SQL.Clear;
  tblMaster.SQL.add('Select * from ' +fstablename );
  fbIgnoreAccessLevels := true;
  inherited;
  modified := false;
  Formshown := False;
end;

procedure TPaymentChequeDetails.FormDestroy(Sender: TObject);
begin
  inherited;
  DestroyUserTemporaryTable(fsTablename);
end;

procedure TPaymentChequeDetails.BitBtn1Click(Sender: TObject);
Var
  //qry : TERPQuery;
  clientObj:Tclient;
function FormName :String;
begin
    result := Owner.Classname;
    if Owner is TfmCustPayments then Result := 'Customer Payment'
    else if owner is TfmCustPrepayments then  Result := CUSTOMER_PREPAYMENT
    else if Owner is TfmSuppPrepayments then Result := 'Supplier Prepayment'
    else if Owner is TPOSScreenForm then   Result := 'POS';
end;
begin
  inherited;
  if modified then begin

    if not ValidateData then
      exit;

    if Owner is TfmCustPayments then begin
      TfmCustPayments(Owner).BankAccountName := edtBankAccName.Text;
      TfmCustPayments(Owner).BankAccountBSB  := edtBankAccBSB.Text;
      TfmCustPayments(Owner).BankAccountNo   := edtBankAccNo.Text;
      TfmCustPayments(Owner).ChequeNumber    := edtChequeNo.Text;
    end else if owner is TBasePrepaymentGUI then begin
      TBasePrepaymentGUI(Owner).BankAccountName := edtBankAccName.Text;
      TBasePrepaymentGUI(Owner).BankAccountBSB  := edtBankAccBSB.Text;
      TBasePrepaymentGUI(Owner).BankAccountNo   := edtBankAccNo.Text;
      TBasePrepaymentGUI(Owner).ChequeNumber    := edtChequeNo.Text;
    end else if Owner is TPOSScreenForm then begin
      TPOSScreenForm(Owner).BankAccountName := edtBankAccName.Text;
      TPOSScreenForm(Owner).BankAccountBSB  := edtBankAccBSB.Text;
      TPOSScreenForm(Owner).BankAccountNo   := edtBankAccNo.Text;
      TPOSScreenForm(Owner).ChequeNumber    := edtChequeNo.Text;
    end else if Owner is TfmSplitInvoicePayment then begin
      TfmSplitInvoicePayment(Owner).SplitPayment.Lines.BankAccountName := edtBankAccName.Text;
      TfmSplitInvoicePayment(Owner).SplitPayment.Lines.BankAccountBSB  := edtBankAccBSB.Text;
      TfmSplitInvoicePayment(Owner).SplitPayment.Lines.BankAccountNo   := edtBankAccNo.Text;
      TfmSplitInvoicePayment(Owner).SplitPayment.Lines.ReferenceNo     := edtChequeNo.Text;
    end;


    if (SaveAccountName <> edtBankAccname.text) or (SaveBSB <> edtBankAccBSB.Text) or
      (SaveAccountNo <> edtBankAccNo.Text) or (SaveBankCode <> cboBankCode.Text) then begin
      Try
        if (CommonLib.MessageDlgXP_Vista('Do you wish to update customer bank details?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
          if Owner is TfmCustPayments then begin
            clientObj :=TfmCustPayments(Owner).CustPayment.client;
            (*TfmCustPayments(Owner).CustPayment.client.BankAccountNo := edtBankAccNo.Text;
            TfmCustPayments(Owner).CustPayment.client.BankAccountName := edtBankAccName.Text;
            TfmCustPayments(Owner).CustPayment.client.BankAccountBSB := edtBankAccBSB.Text;
            if appenv.RegionalOptions.RegionType = rAust then
              TfmCustPayments(Owner).CustPayment.client.BankCode := cboBankCode.Text;
            TfmCustPayments(Owner).CustPayment.client.PostDb;*)
          end else if Owner is TfmSplitInvoicePayment then begin
            clientObj :=TfmSplitInvoicePayment(Owner).SplitPayment.saleobj.Customer;
            (*TfmSplitInvoicePayment(Owner).SplitPayment.Invoiceobj.Customer.BankAccountNo := edtBankAccNo.Text;
            TfmSplitInvoicePayment(Owner).SplitPayment.Invoiceobj.Customer.BankAccountName := edtBankAccName.Text;
            TfmSplitInvoicePayment(Owner).SplitPayment.Invoiceobj.Customer.BankAccountBSB := edtBankAccBSB.Text;
            if appenv.RegionalOptions.RegionType = rAust then TfmSplitInvoicePayment(Owner).SplitPayment.Invoiceobj.Customer.BankCode := cboBankCode.Text;
            TfmSplitInvoicePayment(Owner).SplitPayment.Invoiceobj.Customer.PostDb;*)
          end else if owner is TfmCustPrepayments then begin
            clientObj := TfmCustPrepayments(Owner).CustPrePayment.client;
            (*TfmCustPrepayments(Owner).CustPrePayment.client.BankAccountNo := edtBankAccNo.Text;
            TfmCustPrepayments(Owner).CustPrePayment.client.BankAccountName := edtBankAccName.Text;
            TfmCustPrepayments(Owner).CustPrePayment.client.BankAccountBSB := edtBankAccBSB.Text;
            if appenv.RegionalOptions.RegionType = rAust then
              TfmCustPrepayments(Owner).CustPrePayment.client.BankCode := cboBankCode.Text;
            TfmCustPrepayments(Owner).CustPrePayment.client.PostDb;*)
          end else begin
            clientObj := Tclient.CreateWithNewConn(Self);
            clientObj.connection.connection :=self.MyConnection;
            clientObj.Load(ClientID);
            if not(clientObj.Lock) then begin
              CommonLib.MessageDlgXP_Vista('Unable to update customer bank account details at this time:' +
                #13#10 + #13#10 + clientObj.Userlock.LockMessage, mtInformation, [mbOK],0);
              Freeandnil(clientObj);
            end;
            (*Userlock.Enabled:= true;
            if Userlock.Lock('tblclients' , clientId, 'Update Customer Bank Details') then begin
              qry := TERPQuery.Create(nil);
              try
                qry.Connection := self.MyConnection;//  GetSharedMyDacConnection;
                self.BeginTransaction;
                try
                  qry.Sql.Clear;
                  qry.Sql.Add('Update tblclients  set BankAccountNo = ' + QuotedStr(edtBankAccNo.Text) + ', ');
                  qry.Sql.Add('   BankAccountName = ' + QuotedStr(edtBankAccName.Text) + ', ');
                  qry.Sql.Add('   BankAccountBSB = ' + QuotedStr(edtBankAccBSB.Text) );
                  if appenv.RegionalOptions.RegionType = rAust then qry.Sql.Add(',   BankCode = ' + QuotedStr(cboBankCode.Text));
                  qry.Sql.Add(' where tblclients.ClientId =  ' + IntToStr(ClientID));
                  qry.Execute;
                  self.CommitTransaction;
                except
                  self.RollbackTransaction;
                  raise;
                end;
              finally
                qry.Free;
              end;
            end
            else begin
              CommonLib.MessageDlgXP_Vista('Unable to update customer bank account details at this time:' +
                #13#10 + #13#10 + Userlock.LockMessage, mtInformation, [mbOK],0);
            end;*)
          end;
        end;
        if Assigned(clientObj) then begin
          if Assigned(ClientObj.Owner) and (ClientObj.owner =Self) then ClientObj.connection.beginTransaction;
          ClientObj.BankAccountNo   := edtBankAccNo.Text;
          ClientObj.BankAccountName := edtBankAccName.Text;
          ClientObj.BankAccountBSB  := edtBankAccBSB.Text;
          if appenv.RegionalOptions.RegionType = rAust then ClientObj.BankCode      := cboBankCode.Text;
          ClientObj.PostDb;
          if Assigned(ClientObj.Owner) and (ClientObj.owner =Self) then begin
            ClientObj.connection.CommitTransaction;
            Freeandnil(ClientObj);
          end;
        end;
      Finally

      End;
    end;
  end;

  ModalResult := mrOk;
end;

procedure TPaymentChequeDetails.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TPaymentChequeDetails.edtBankAccNameChange(Sender: TObject);
begin
  inherited;
  modified := true;
end;

procedure TPaymentChequeDetails.FormShow(Sender: TObject);

begin
  DisableForm;
  try
    inherited;
    postDB(tblMaster);
    editDB(tblMaster);
    lblbsbmask.caption        := NumberMaskTocaption(TField(tblmasterBankAccountBSB).EditMask);
    lblAccountnomask.caption  := NumberMaskTocaption(TField(tblmasterBankAccountNo).EditMask );
    if not qryBankCodes.Active then qryBankCodes.Open;
    cboBankCode.Text := tcDataUtils.GetClientBankCode(ClientID);
    {Save current bank account details}
    SaveAccountName:= edtBankAccname.text;
    SaveBSB:= edtBankAccBSB.Text;
    SaveAccountNo:= edtBankAccNo.Text;
    SaveBankCode:= cboBankCode.Text;
  finally
    EnableForm;
  end;
end;

procedure TPaymentChequeDetails.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TPaymentChequeDetails.setChequeBankAccountBSB(const Value: string);begin  if Value <> '' then tblMasterBankAccountBSB.asString := Value;end;
procedure TPaymentChequeDetails.setChequeBankAccountName(const Value: string);begin if Value <> '' then  tblmasterBankAccountName.asString := Value;end;
procedure TPaymentChequeDetails.setChequeBankAccountNo(const Value: string);begin  if Value <> '' then tblmasterBankAccountno.asString := Value;end;
procedure TPaymentChequeDetails.setChequeChequeNumber(const Value: string);begin if Value <> '' then tblMasterChequeno.asString := Value;end;

procedure TPaymentChequeDetails.setClientID(const Value: integer);
begin
  fiClientID := Value;
  if not tblMaster.active then tblMaster.open;
  With tempmyquery do try
    SQL.add('select ClientID,  BankAccountNo,BankAccountName,BankAccountBSB,BankCode,space(255) as Chequeno from tblclients where clientId = ' + inttostr(Value)) ;
    Open;
    tblMaster.append;
    tblMasterBankAccountNo.asString := fieldbyname('BankAccountNo').asString;
    tblMasterBankAccountName.asString  :=  fieldbyname('BankAccountName').asString;
    tblMasterBankAccountBSB.asString  :=  fieldbyname('BankAccountBSB').asString;
    tblMasterBankCode.asString  :=  fieldbyname('BankCode').asString;
    tblMasterChequeno.asString  := '';
    postDB(tblMaster);
    editDB(tblMaster);
  finally
    closenFree;
  end;
end;


function TPaymentChequeDetails.ValidateData: boolean;
begin
  result:= true;
  if Trim(edtBankAccName.Text) = '' then begin
    result:= false;
    CommonLib.MessageDlgXP_Vista('Please enter a Bank Account Name',mtInformation,[mbOk],0);
    edtBankAccName.SetFocus;
    exit;
  end
  else if Trim(edtChequeNo.Text) = '' then begin
    result:= false;
    CommonLib.MessageDlgXP_Vista('Please enter a Cheque Number',mtInformation,[mbOk],0);
    edtChequeNo.SetFocus;
    exit;
  end
  else if (cboBankCode.Text = '') and (appenv.RegionalOptions.RegionType = rAust) then begin
    result:= false;
    CommonLib.MessageDlgXP_Vista('Please select a Bank Code',mtInformation,[mbOk],0);
    cboBankCode.SetFocus;
    exit;
  end;
end;

procedure TPaymentChequeDetails.edtBankAccNoExit(Sender: TObject);
begin
  inherited;
  if edtBankAccNo.Text <> '' then begin
    while char_length(edtBankAccNo.Text) < char_length(edtBankAccNo.Picture.PictureMask) do begin
      edtBankAccNo.Text:= '0' + edtBankAccNo.Text;
    end;
  end;
end;

procedure TPaymentChequeDetails.edtBankAccNameEnter(Sender: TObject);
begin
  inherited;
  if Formshown then exit;
  if Trim(edtBankAccName.text) = '' then SetControlFocus(edtBankAccName)
  else if Trim(edtBankAccBSB.text) = '' then SetControlFocus(edtBankAccBSB)
  else if Trim(edtBankAccNo.text) = '' then SetControlFocus(edtBankAccNo)
  else if Trim(edtChequeNo.text) = '' then SetControlFocus(edtChequeNo)
  else if Trim(cboBankCode.text) = '' then SetControlFocus(cboBankCode);
  Formshown := True;

end;

initialization
  RegisterClassOnce(TPaymentChequeDetails);

end.

