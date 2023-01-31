{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/05/05  1.00.01 BJ  when the bank details are accepted, update the customer's
                       bank details if they are empty.
                       field updated : bankaccountname, bankaccountbsb, bankaccountno
 22/06/05  1.00.02 DSP Added functionality for use with the NAB CardFast
                       payment method
 04/07/05  1.00.03 BJ  Bug fixed :When  calling from the cutomer Pre-Payment list,
                       the form breakes.
 09/08/05  1.00.04 DSP Added RegisterClass.
 12/10/05  1.00.05 AL  Moved visual components to make look like SupplierPrepaimentGUI
 11/04/06  1.00.06 BJ  Implemented userlocks
}
unit frmCustPrepayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BasePrepayment, DB, kbmMemTable,  SelectionDialog,
  AppEvnts, StdCtrls, wwcheckbox, DBCtrls, ExtCtrls, DNMPanel, Buttons, DNMSpeedButton,
  wwdbdatetimepicker, wwdblook, Mask, MemDS, DBAccess,
  MyAccess,ERPdbComponents, DataState, wwdbedit, Menus, AdvMenus, Shader,
  busobjPrepayments, ImgList, ERPDbLookupCombo, ProgressDialog, CreditCardObj;

type
  TfmCustPrepayments = class(TBasePrepaymentGUI)
    UseAccNo: TDNMSpeedButton;
    Label4: TLabel;
    lblEnteredBy: TLabel;
    Bevel4: TBevel;
    Label7: TLabel;
    tblMasterRepId: TIntegerField;
    tblMasterRepName: TWideStringField;
    Label8: TLabel;
    cboEmployeeLookup: TERPQuery;
    cboEmployee: TwwDBLookupCombo;
    cboEmployeeLookupEmployeeID: TIntegerField;
    cboEmployeeLookupEmployeeName: TWideStringField;
    lblEnteredAt: TDBText;
    lblPayamthint: TLabel;
    tblMastermsTimeStamp: TDateTimeField;
    tblMastermsUpdateSiteCode: TWideStringField;
    tblMasterChequePrinted: TWideStringField;
    btnCardPayment: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure UseAccNoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClientlookupAfterOpen(DataSet: TDataSet);
    procedure cboPaymentMethodCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdSaveClick(Sender: TObject);
    procedure cboForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cboForeignCurrencyCodeExit(Sender: TObject);
    procedure cboPaymentMethodExit(Sender: TObject);
    procedure cboClassExit(Sender: TObject);
    procedure tblMasterPayAmountChange(Sender: TField);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure tblMasterReferenceNoChange(Sender: TField);
    procedure btnPopupClick(Sender: TObject);
    procedure btnCardPaymentClick(Sender: TObject);
    procedure btnDepositClick(Sender: TObject);

  private
    { Private declarations }
//    InAccountNoMode     : boolean;
    fbPOSInitiated      : boolean;
    fiPOSClientID       : integer;
    fdPOSAmount         : currency;// set AND returned to POS
    fiPOSPayMethodID    : integer; // returned to POS
    fiPOSPrepaymentID   : integer; // returned to POS
    fbPOSPrepaymentMade : boolean;
    fsLinkToSaleRef: String;
    fsLinkToSaletype: String;
    fsLinkToSaleOriginalRef: String;
    fdsalesBalance:double;
    PaymentCard: TCreditCard;
    procedure LinktoSale;
    procedure SetLinkToSaleRef(const Value: String);
    procedure setsalesBalance(const Value: Double);
    procedure CheckCardPaymentBankAccount;
    procedure initDepositedList(Sender: TObject);
    procedure AfterDepositedList(Sender: TObject);
  Protected
    procedure AllowSave; Override;
    function SaveAndCommit: boolean; override;
    Function GetMainTablename: String; override;
    procedure KeyIdChanged(const NewKeyId: integer); override;
  public
    { Public declarations }
    CustPrePayment              : TCustPrePayments;
    Property POSInitiated       : Boolean   Read  fbPOSInitiated        Write fbPOSInitiated;
    Property POSClientID        : Integer   Read  fiPOSClientID         Write fiPOSClientID;
    Property POSAmount          : Currency  Read  fdPOSAmount           Write fdPOSAmount;      // set AND returned to POS
    Property POSPayMethodID     : integer   Read  fiPOSPayMethodID      Write fiPOSPayMethodID;  // returned to POS
    Property POSPrepaymentID    : integer   Read  fiPOSPrepaymentID     Write fiPOSPrepaymentID; // returned to POS
    Property POSPrepaymentMade  : boolean   Read  fbPOSPrepaymentMade   Write fbPOSPrepaymentMade;
    Property LinkToSaleRef      : String    Read  fsLinkToSaleRef       Write SetLinkToSaleRef;
    Property LinkToSaleOriginalRef :String read fsLinkToSaleOriginalRef write fsLinkToSaleOriginalRef;
    Property LinkToSaletype     : String    REad  fsLinkToSaletype      write fsLinkToSaletype;
    Property salesBalance       : Double    read fdsalesBalance         write setsalesBalance;

  end;

implementation

uses BaseInputForm, FormFactory,
     frmCustomerFrm, CommonLib, tcDataUtils,  AppEnvironment,
     BusObjBase, tcConst, BusobjSalesPrepayments, BusObjSales,
     frmPaymentCardDetails, BusObjGLAccount, frmCardPayment, BusObjPaymethods,
  CustPrePaymentDepositList, CommonFormLib, BaseListingForm;

{$R *.dfm}

{ fmCustPrepayments }

procedure TfmCustPrepayments.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  FreeAndNil(PaymentCard);
end;

procedure TfmCustPrepayments.FormCreate(Sender: TObject);
begin
    CustPrePayment  := TCustPrePayments.Create(Self);
    PrePayment      := CustPrePayment;
    inherited;
    CustPrePayment.Connection := TMyDacDataConnection.Create(CustPrePayment);
    TMyDacDataConnection(CustPrePayment.Connection).MyDacConnection := MyConnection;
    UserLock.Enabled     := true;
    PaymentCard := nil;
end;

procedure TfmCustPrepayments.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TfmCustPrepayments.UseAccNoClick(Sender: TObject);
//var
//  TempText: string;
begin
//  DisableForm;
//  try
//    inherited;
//    TempText := cboClient.Text;
//    if not InAccountNoMode then begin
//        InAccountNoMode := true;
//        Label1.Caption  := 'Customer Account No';
//        cboClientLookup.Close;
//        cboClientLookup.SQL.Clear;
//        cboClientLookup.SQL.Add('SELECT cast(If(C.ParentRelatedClientID=0,C.ClientId,C.ParentRelatedClientID) as Decimal) as ClientID, ');
//        cboClientLookup.SQL.Add('Trim(If(C.ParentRelatedClientID=0,C.Company,C2.Company)) as Company, ');
//        cboClientLookup.SQL.Add('Sum(C.Balance) as Balance,C.PayMethodID,Trim(If(C.ParentRelatedClientID=0, C.ClientNo,C2.ClientNo)) as ClientNo,C.BankAccountName, C.BankAccountBSB, C.BankAccountNo, C.ForeignExchangeSellCode ');
//        cboClientLookup.SQL.Add('FROM tblclients C Left Join tblclients C2 On C.ParentRelatedClientID=C2.ClientID ');
//        cboClientLookup.SQL.Add('WHERE (not IsNull(C.Company) AND char_length(Trim(C.Company))>0) ');
//        cboClientLookup.SQL.Add('AND C.Active <>"F" AND C.Customer = "T" AND char_length(C.ClientNo)<>0 AND C.ClientNo<>0 ');
//        cboClientLookup.SQL.Add('and (((:SearchMode = 0) or IsNull(:SearchMode))');
//        cboClientLookup.SQL.Add('or ((:SearchMode = 1) and (If(IfNull(C.ParentRelatedClientID,0)=0,C.Company,C2.Company) LIKE Concat(:SearchValue,"%")))');
//        cboClientLookup.SQL.Add('or ((:SearchMode = 2) and (If(IfNull(C.ParentRelatedClientID,0)=0,C.Company,C2.Company) LIKE Concat("%",:SearchValue,"%"))))');
//        cboClientLookup.SQL.Add('and IfNull(:SearchValue,"") <> ""');
//        cboClientLookup.SQL.Add('GROUP BY ClientID ORDER BY C.Company;');
//        cboClientLookup.Open;
//        cboClient.Selected.Clear;
//        cboClient.Selected.Add('ClientNo' + #9 + '5' + #9 + 'Account No' + #9 + 'F' + #9);
//        cboClient.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
//        cboClient.Selected.Add('Balance' + #9 + '10' + #9 + 'Balance ('+AppEnv.RegionalOptions.CurrencySymbol+')' + #9 + 'T' + #9);
//    end else begin
//        InAccountNoMode := false;
//        Label1.Caption  := 'Customer / Job';
//        cboClientLookup.Close;
//        cboClientLookup.SQL.Clear;
//        cboClientLookup.SQL.Add('SELECT cast(If(C.ParentRelatedClientID=0,C.ClientId,C.ParentRelatedClientID) as Decimal) as ClientID, ');
//        cboClientLookup.SQL.Add('Trim(If(C.ParentRelatedClientID=0,C.Company,C2.Company)) as Company, ');
//        cboClientLookup.SQL.Add('Sum(C.Balance) as Balance,C.PayMethodID,C.ClientNo as ClientNo,C.BankAccountName, C.BankAccountBSB, C.BankAccountNo, C.ForeignExchangeSellCode ');
//        cboClientLookup.SQL.Add('FROM tblclients C Left Join tblclients C2 On C.ParentRelatedClientID=C2.ClientID ');
//        cboClientLookup.SQL.Add('WHERE (not IsNull(C.Company) AND char_length(Trim(C.Company))>0) ');
//        cboClientLookup.SQL.Add('AND C.Active <>"F" AND C.Customer = "T" ');
//        cboClientLookup.SQL.Add('GROUP BY ClientID ORDER BY C.Company;');
//        cboClientLookup.Open;
//        cboClient.Selected.Clear;
//        cboClient.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
//        cboClient.Selected.Add('Balance' + #9 + '10' + #9 + 'Balance ('+AppEnv.RegionalOptions.CurrencySymbol+')' + #9 + 'T' + #9);
//    end;
//    if cboClientLookup.Locate('ClientNo', TempText, [loCaseInsensitive]) and not Empty(TempText) then begin
//        cboClient.Text := cboClientLookup.FieldByName('Company').AsString;
//    end else begin
//        cboClient.Clear;
//        cboClient.LookupValue := '';
//        cboClient.Value := '';
//        cboClient.Text := '';
//        cboClientCloseUp(cboClient, cboClient.lookupTable, cboClient.DataSource.DataSet, true);
//    end;
//  finally
//    EnableForm;
//  end;
end;
procedure TfmCustPrepayments.AllowSave;
begin
    inherited;
    if cmdNew.Enabled then
        cmdNew.Enabled := (not (POSInitiated)) and (LinkToSaleRef ='');
end;

procedure TfmCustPrepayments.FormShow(Sender: TObject);
var
  qry: TERPQuery;
begin
  DisableForm;
  try
    inherited;
    if POSInitiated then begin
        cmdNew.Enabled := False;
        if POSClientID <> 0 then begin
            PrePayment.ClientID := POSClientID;
            cboClient.Enabled   := False;
        end;
        if POSAmount <> 0 then CustPrePayment.PayAmount:= POSAmount;
    end;

    if AccessLevel < 5 then
      if tblMaster.FieldByName('EmployeeID').AsInteger = 0 then
        tblMaster.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;

    lblEnteredBy.Caption := GetEmployeeName(tblMaster.FieldByName('EmployeeID').AsInteger);

    if KeyID <> 0 then begin
      { enable buton to view linked card payment }
      try
        qry := TERPQuery.Create(nil);
        try
          qry.Connection := MyConnection;
          qry.SQL.Add('select * from tblCardPayment');
          qry.SQL.Add('where ERPTransType = ' + QuotedStr(CustPrePayment.ClassName));
          qry.SQL.Add('and ERPTransID = ' + IntToStr(KeyID));
          qry.Open;
          btnCardPayment.Visible := not qry.IsEmpty;
        finally
          qry.Free;
        end;
      except
      end;
    end;

  finally
    EnableForm;
  end;   
end;

procedure TfmCustPrepayments.cboClientlookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(cboClientLookup.FieldByName('Balance')).currency := true;
end;

procedure TfmCustPrepayments.cboPaymentMethodCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboPaymentMethod.Text = '' then Exit;
  if cboPaymentMethod.Text = 'Cheque' then begin
    btnPopup.Click;
  end;
end;

procedure TfmCustPrepayments.cmdSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveAndCommit then begin
      notify(False);
      CustPrepayment.Dirty := false;
      self.Close;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfmCustPrepayments.cboForeignCurrencyCodeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TfmCustPrepayments.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmCustPrepayments.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfmCustPrepayments.cboForeignCurrencyCodeExit(Sender: TObject);
begin
  inherited;
  if cboForeignCurrencyCode.Text = '' then cboForeignCurrencyCode.DropDown;
end;

procedure TfmCustPrepayments.cboPaymentMethodExit(Sender: TObject);
begin
  inherited;
  if cboPaymentMethod.Text = '' then cboPaymentMethod.DropDown;
end;

procedure TfmCustPrepayments.CheckCardPaymentBankAccount;
var
  qry: TERPQuery;
begin
  if CustPrePayment.ReferenceNo = '' then begin
    CustPrePayment.ReferenceNo := 'Card Payment';
    CustPrePayment.PostDb;
    CustPrePayment.Dirty := false;
  end;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := MyConnection;
    qry.SQL.Add('select * from tblcardpayment');
    qry.SQL.Add('where ERPTransType = ' + QuotedStr(CustPrePayment.ClassName));
    qry.SQL.Add('and ERPTransID = ' + IntToStr(CustPrePayment.ID));
    qry.SQL.Add('and PaymentStatus = 1');
    qry.Open;
    if not qry.IsEmpty then begin
      if (qry.FieldByName('ERPBankAccount').AsString <> '') and
         (qry.FieldByName('ERPBankAccount').AsString <> CustPrePayment.BankAccountAccountName)  then begin

        CustPrePayment.BankAccountAccountName := qry.FieldByName('ERPBankAccount').AsString;
        CustPrePayment.PostDB;
        CustPrePayment.Dirty := false;
        CommonLib.MessageDlgXP_Vista('The Payment Bank Account has been changed to match the Bank Account used by the ' +
          qry.FieldByName('Gateway').AsString + ' Payment Gateway (' + qry.FieldByName('ERPBankAccount').AsString + ')',mtInformation,[mbOk],0);

      end;
    end;
  finally
    qry.Free;
  end;
  if Assigned(PaymentCard) and (PaymentCard.CardType <> '') then begin
    if CustPrePayment.PayMethodName <> PaymentCard.CardType then begin
      if TPaymentMethod.IDToggle(PaymentCard.CardType) > 0 then begin
        CustPrePayment.PayMethodName := PaymentCard.CardType;
        CustPrePayment.PostDB;
        CustPrePayment.Dirty := false;
        CommonLib.MessageDlgXP_Vista('The Payment Method has been changed to match the Card Type',mtInformation,[mbOk],0);
      end;
    end;
  end;
end;

procedure TfmCustPrepayments.btnCardPaymentClick(Sender: TObject);
begin
  inherited;
  if CustPrePayment.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do you want to save your changes first?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
      mrYes: if not SaveAndCommit then exit;
      mrNo: CustPrePayment.Cancel;
      mrCancel: exit;
    end;
  end;

  self.CommitTransaction;
  try
    if DoCardPayment(TCustPrePayments,CustPrePayment.ID,AccessLevel,PaymentCard) then begin
      CustPrePayment.RefreshDB;
    end
    else begin
      { delete the saved payment .. }
      self.BeginTransaction;
      CustPrePayment.Deleted := true;
      if SaveAndCommit then begin
        Close;
      end
      else begin

      end;
    end;
  finally
    self.BeginTransaction
  end;

end;

procedure TfmCustPrepayments.btnDepositClick(Sender: TObject);
begin
  inherited;
(*  if fsmodal in formstate then
       OpenERPListFormModal('TCustPrePaymentDepositListGUI' , nil, initDepositedList)
  else OpenERPListForm('TCustPrePaymentDepositListGUI' , initDepositedList , AfterDepositedList );*)
  OpenERPListFormModal('TCustPrePaymentDepositListGUI' , nil, initDepositedList);
end;
procedure TfmCustPrepayments.initDepositedList(Sender: TObject);
begin
  if sender is TCustPrePaymentDepositListGUI then begin
    TCustPrePaymentDepositListGUI(Sender).SearchMode:= smFullList    ;
    TCustPrePaymentDepositListGUI(Sender).paymentId :=Prepayment.ID;
    TCustPrePaymentDepositListGUI(Sender).chkignoredates.Checked := True;
    TCustPrePaymentDepositListGUI(Sender).UpdateCustPrepayDepositFlag := AfterDepositedList;
  end;
end;
procedure TfmCustPrepayments.AfterDepositedList(Sender: TObject);
var
  fi:Integer;
  Function DepositMsg:String;
  begin
    if TCustPrePaymentDepositListGUI(Sender).qrymain.recordcount >0 then
      result := 'This Pre-Payment is Already Deposited.'+NL+
                'This Will Save Current Changes and will Flag as Deposited.'
    else
      result := 'This Pre-Payment is Not Deposited.'+NL+
                'This Will Save Current Changes and will Flag as not Deposited.';
  end;
begin
  if sender is TCustPrePaymentDepositListGUI then begin
    TCustPrePaymentDepositListGUI(Sender).ListActiveDeposits;
    if ((TCustPrePaymentDepositListGUI(Sender).qrymain.recordcount >0) and (CustPrePayment.deposited =False)) or
       ((TCustPrePaymentDepositListGUI(Sender).qrymain.recordcount =0) and (CustPrePayment.deposited )) then
      if (accesslevel <= 3) or CustPrePayment.userLock.lock('tblprepayments' , CustPrePayment.ID) then begin
          if MessageDlgXP_Vista(DepositMsg+NL+NL+
                                'Do you wish to continue?', mtconfirmation, [mbyes,mbno], 0) = mrno then exit;
          self.CommitTransaction;
          try
            try
              fi := CustPrePayment.Accessmanager.accesslevel;
              CustPrePayment.Accessmanager.accesslevel := 1;
              try
                CustPrePayment.Deposited := TCustPrePaymentDepositListGUI(Sender).qrymain.recordcount >0;
                CustPrePayment.PostDB;
                CustPrePayment.Dirty := False;
              finally
                CustPrePayment.Accessmanager.accesslevel := fi;
              end;
            Except
              on E:Exception do begin
                CustPrePayment.executeSQL('udpate tblprepayments set Deposited ='+
                                          quotedstr(iif(TCustPrePaymentDepositListGUI(Sender).qrymain.recordcount >0,'T','F')) +
                                          ' where PrePaymentID = ' + inttostr(CustPrePayment.ID) , True);
                MessageDlgXP_Vista('This Pre-Payment is Already Deposited, Flagging it as deposited.', mtInformation, [mbOK], 0);
              end;
            end;
          finally
            cmdsave.enabled := False;
            self.BeginTransaction
          end;
      end else begin
          MessageDlgXP_Vista('Customer Prepayment #' + inttostr(CustPrePayment.ID) +
                             ' is already Deposited.'+NL+
                             'Please Close all Forms and Open Prepayment  #' + inttostr(CustPrePayment.ID) +' from the Customer Prepayment List and Choose "Deposit".'+NL+
                             'Do You Wish To Close All Forms and Open the Customer Prepayment List ?' , mtInformation, [mbOK], 0);
      end;
  end;
end;
procedure TfmCustPrepayments.btnPopupClick(Sender: TObject);
var
  GatewayList: TStringList;
  msg: string;
begin
  if AppEnv.UtilsClient.PayGateway.Installed then begin
    if (CustPrePayment.PayMethodName <> '') and CustPrePayment.PaymentMethod.IsCreditCard then begin
      GatewayList := TStringList.Create;
      try
        GatewayList.CommaText := AppEnv.UtilsClient.PayGateway.EnabledGatewayList;

        if GatewayList.Count > 0 then begin
          if not Assigned(PaymentCard) then
            PaymentCard := TCreditCard.Create;
          if GetCreditCard(PaymentCard,GatewayList,CustPrePayment.ClientID) then begin
            { we now have card details for payment .. }
            if CustPrePayment.ReferenceNo = '' then
              CustPrePayment.ReferenceNo := 'Card Payment';

            if PaymentCard.CardType <> '' then begin
              if CustPrePayment.PayMethodName <> PaymentCard.CardType then begin
                if TPaymentMethod.IDToggle(PaymentCard.CardType) > 0 then
                  CustPrePayment.PayMethodName := PaymentCard.CardType;
              end;
            end;

            BankAccountName := AppEnv.UtilsClient.PayGateway.BankAccountForCurrency(MyConnection.Database,PaymentCard.GatewayName,CustPrePayment.ForeignExchangeCode,msg);
            if BankAccountName <> '' then begin
              CustPrePayment.BankAccountID := TAccount.IDToggle(BankAccountName);
            end
            else begin
              FreeAndNil(PaymentCard);
              CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
            end;
            exit;
          end
          else begin
            FreeAndNil(PaymentCard);
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('There are currently no Payment Gateways enabled to handle this payment.',mtInformation,[mbOk],0);
        end;
      finally
        GatewayList.Free;
      end;
      exit;
    end
    else
      FreeAndNil(PaymentCard);
  end;
  inherited;
end;

procedure TfmCustPrepayments.cboClassExit(Sender: TObject);
begin
  inherited;
  if cboClass.Text = '' then cboClass.DropDown;
end;

function TfmCustPrepayments.SaveAndCommit: boolean;
var
  ProcessCardPayment: boolean;
begin
  result:= false;
  if FormStillOpen('TfrmCustomer') then begin
    TFrmCustomer(FindExistingComponent('TfrmCustomer')).CloseMe;
    Application.ProcessMessages;
  end;
  if (not CustPrePayment.Dirty) or CustPrePayment.Save then begin
    LinktoSale;
    if POSInitiated then begin
        POSPrepaymentMade   := True;
        POSAmount           := PrePayment.PayAmount;
        POSPayMethodID      := PrePayment.PayMethodID;
        POSPrepaymentID     := PrePayment.ID;
    end;
    CustPrePayment.connection.CommitTransaction;
    result:= true;

    ProcessCardPayment := false;

    if (not CustPrePayment.Deleted) then begin
      if Assigned(PaymentCard) then begin
        ProcessCardPayment := true;
      end
      else if AppEnv.UtilsClient.PayGateway.Installed and
        (CustPrePayment.PayMethodName <> '') and CustPrePayment.PaymentMethod.IsCreditCard and
        (AppEnv.UtilsClient.PayGateway.EnabledGatewayList <> '') then begin
        ProcessCardPayment := true;
      end;
      if ProcessCardPayment then begin
        { process the CC payment through the gaateway }
        if DoCardPayment(TCustPrePayments,CustPrePayment.ID,AccessLevel,PaymentCard) then begin
          { check bank account .. }
          CheckCardPaymentBankAccount;
        end
        else begin
          { card payment failed so delete the pre-payment }
          self.BeginTransaction;
          CustPrePayment.Deleted := true;
          CustPrePayment.Save;
          self.CommitTransaction;
        end;
      end;
    end;

  end;
end;

procedure TfmCustPrepayments.SetLinkToSaleRef(const Value: String);
begin
  fsLinkToSaleRef := Value;
  if cmdNew.Enabled then cmdNew.Enabled := (fsLinkToSaleRef ='');
  if not(cboClient.readonly) and (cboClient.text<> '') and (CustPrePayment.ClientID<>0) then cboClient.readonly :=(fsLinkToSaleRef <>'');
end;

procedure TfmCustPrepayments.setsalesBalance(const Value: Double);
begin
  fdsalesBalance := Value;
  if (CustPrePayment.PayAmount = 0) and (Value <>0) then begin
    CustPrePayment.PayAmount := Value;
    TimerMsg(lblPayamthint, FloatTostrF(Value,ffCurrency , 15,2) +' is the balance to be paid for this Sale which is automatically set to the Prepayment amount. Please change it if different', 10);
    Setcontrolfocus(txtAmount);
  end;
end;

Procedure TfmCustPrepayments.LinktoSale;
var
  Invoice :TInvoice;
  (*CustPayments :TCustPayments;*)
  (*fdPayment, *)fdInvoiceBalance:Double;
begin
  if LinkToSaleRef <> '' then begin
    With TSalesPrepayments.Create(Self) do try
      Connection := CustPrePayment.Connection;
      Load(0);
      New;
      SalesRef := LinkToSaleRef;
      SalesOriginalRef := LinkToSaleOriginalRef;
      PrepayRef := CustPrePayment.globalref;
      IsQuote := LinkToSaletype = 'Q';
      IsSalesOrder := LinkToSaletype = 'S';
      IsInvoice := LinkToSaletype = 'I';
      PostDB;
    finally
      Free;
    end;
    if (LinkToSaletype = 'I') then begin
      if Appenv.AccessLevels.GetEmployeeAccessLevel('TCustPayments') >3 then begin
        MessageDlgXP_Vista('You don''t have enough access to create a customer payment. This Prepayment will not be applied to the Invoice', mtWarning, [mbOK], 0);
      end else begin
        Invoice := TInvoice.Create(CustPrePayment);
        try
          Invoice.Connection :=CustPrePayment.Connection;
          Invoice.LoadSelect('globalref =  ' +quotedstr(LinkToSaleRef));
          if      (Invoice.count =1) and (Invoice.TotalBalance >0) and (Invoice.ForeignExchangeCode =CustPrePayment.ForeignExchangeCode) then begin
            fdInvoiceBalance:=Invoice.TotalBalance ;
            CustPrePayment.ApplyTOInvoice(Invoice.ID, fdInvoiceBalance);
            (*if Invoice.Lock then try*)
              (*CustPayments :=TCustPayments.Create(CustPrePayment);
              try
                CustPayments.Connection :=CustPrePayment.Connection;
                CustPayments.Load(0);
                CustPayments.connection.BeginNestedTransaction;
                try
                  CustPayments.New;

                  CustPayments.ClientID := Invoice.ClientId;
                  CustPayments.Customer := True;
                  CustPayments.ForeignExchangeCode :=CustPrePayment.ForeignExchangeCode;
                  CustPayments.ForeignExchangeRate :=CustPrePayment.ForeignExchangeRate;
                  CustPayments.PaymentDate :=Date;
                  CustPayments.PayMethodID:=CustPrePayment.PayMethodID;
                  CustPayments.ReferenceNo :=CustPrePayment.ReferenceNo;
                  CustPayments.ClassID :=CustPrePayment.ClassID;
                  CustPayments.BankAccountName :=CustPrePayment.BankAccountName;
                  CustPayments.BankAccountNo :=CustPrePayment.BankAccountNo;
                  CustPayments.PostDB;
                  CustPayments.GUILines;
                  if CustPayments.GUILines.Locate('Type;SaleID' , vararrayof(['Invoice' , invoice.id]), []) then begin
                    CustPayments.GUILines.Applied := TRue;
                    if custPrepayment.Balance >Invoice.TotalBalance then
                        CustPayments.GUILines.Payment :=Invoice.TotalBalance
                    else CustPayments.GUILines.Payment := custPrepayment.Balance;
                    fdPayment:=CustPayments.GUILines.Payment;
                    CustPayments.GUILines.PostDb;
                  end;
                  if CustPayments.GUILines.Locate('Type;SaleID' , vararrayof(['Prepayment' , CustPrePayment.id]), []) then begin
                    CustPayments.GUILines.Applied := TRue;
                    CustPayments.GUILines.Payment :=0-fdPayment;
                    CustPayments.GUILines.PostDB;
                  end;
                  CustPayments.CalcTotals;
                  if not CustPayments.Save then begin
                    CustPayments.Connection.RollbackNestedTransaction;
                    Exit;
                  end;
                  CustPayments.Connection.CommitNestedTransaction;
                Except
                  on E:Exception do begin
                    MessageDlgXP_Vista('Linking the prepayment to invoice Failed.'+NL+NL+E.Message, mtWarning, [mbOK], 0);
                    CustPayments.Connection.RollbackNestedTransaction;
                  end;
                end;
              finally
                Freeandnil(CustPayments);
              end;*)
        (*    finally
              Invoice.UnLock;
            end;*)
          end;
        finally
          FreeandNil(Invoice);
        end;
      end;
    end;
  end;
end;
procedure TfmCustPrepayments.tblMasterPayAmountChange(Sender: TField);
begin
  inherited;
  if Abs(Sender.AsFloat) - Abs(Round(Sender.AsFloat,CurrencyRoundPlaces)) > 0 then begin
    CommonLib.MessageDlgXP_Vista('Invalid value for ' + Sender.DisplayLabel +
      ': ' + Sender.AsString, mtInformation, [mbOK], 0);
    Abort;
  end;
end;

procedure TfmCustPrepayments.cboEmployeeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  CustPrePayment.RepId := cboEmployeeLookupEmployeeID.asInteger;
  CustPrePayment.Repname := cboEmployeeLookupEmployeeName.asString;
end;

function TfmCustPrepayments.GetMainTablename: String;
begin
  result:= 'tblPrePayments';
end;

procedure TfmCustPrepayments.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;
  // override to prevent default behaviour - DO NOT REMOVE THIS.
end;

procedure TfmCustPrepayments.tblMasterReferenceNoChange(Sender: TField);
var
  aCompany: string;
  aDate: TDateTime;
  aPayAmount: double;
  newRef: string;
begin
  inherited;
  if CustPrePayment.ReferenceNoExists(aCompany,aDate,aPayAmount) then begin
    newRef:= Sender.AsString + '(' + tblMasterPrePaymentID.AsString + ')';
    CommonLib.MessageDlgXP_Vista('The reference number has already been used for: '  +
      #13#10 +
      aCompany  + ' ' + FormatDateTime('dd/mm/yyyy',aDate) + ' ' +
      FloatToStrF(aPayAmount, ffCurrency, 15, CurrencyRoundPlaces) + #13#10 + #13#10 +
      'Reference number will be changed to: ' + newref, mtInformation, [mbOK], 0);
    Sender.AsString:= newRef;
  end;
end;

initialization
  RegisterClassOnce(TfmCustPrepayments);

  with FormFact do begin
    RegisterMe(TfmCustPrepayments, 'TCustPrepaymentListGUI_*=ReceiptNo');
    RegisterMe(TfmCustPrepayments, 'TStatementListGUI_*_Prepayment=Receipt #');
    RegisterMe(TfmCustPrepayments, 'TAccountsReceiveListGUI_*_Customer Prepayment=SaleID');
    RegisterMe(TfmCustPrepayments, 'TBankAccountListGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TBalTransListGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TToBeReconciledGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TReconListDetailFormGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TTrialBalTransListGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TTransactionListGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TBASTransReturnListGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TNZTransReturnListGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TVATTransReturnListGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TGlobalsearchGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TTransAccountDetailsGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TCustomerBalanceDetailGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TGeneralLedgerReportGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TCustomerBalanceDetailGUI_*_Customer Prepayment=PrepaymentID');
    RegisterMe(TfmCustPrepayments, 'TAllTransactionGUI_*_Customer Prepayment=TransNo');
    RegisterMe(TfmCustPrepayments, 'TSalesPrepaymentsGUI_*_Customer Prepayment=PrePaymentID');
    RegisterMe(TfmCustPrepayments, 'TTransPaymentListGUI_*_Customer Prepayment=PaymentID');
    RegisterMe(TfmCustPrepayments, 'TPaymentListGUI_*_'+CUSTOMER_PREPAYMENT+'=PaymentID');

  end;
end.

