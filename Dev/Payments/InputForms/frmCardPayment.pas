unit frmCardPayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, AdvEdit, DNMSpeedButton, Shader, DNMPanel,
  JSONObject, CardPaymentObj, BusObjBase, CreditCardObj, DbGen;

type
  TfmCardPayment = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnProcess: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label62: TLabel;
    Label22: TLabel;
    Label61: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCardholderName: TEdit;
    edtCardNumber: TEdit;
    cboCardMonth: TComboBox;
    cboCardYear: TComboBox;
    chkUsedSavedCard: TCheckBox;
    cboGateway: TComboBox;
    Bevel1: TBevel;
    Label4: TLabel;
    edtDescription: TEdit;
    edtAmount: TAdvEdit;
    Label5: TLabel;
    cboCurrencyCode: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    Label9: TLabel;
    edtBankAccount: TEdit;
    Label10: TLabel;
    edtCVC: TAdvEdit;
    edtStatusComment: TMemo;
    DNMPanel1: TDNMPanel;
    cboStatus: TComboBox;
    edtCardType: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboCurrencyCodeChange(Sender: TObject);
    procedure cboGatewayChange(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure edtCardNumberChange(Sender: TObject);
    procedure edtCardholderNameChange(Sender: TObject);
    procedure cboCardMonthChange(Sender: TObject);
    procedure cboCardYearChange(Sender: TObject);
    procedure edtCVCChange(Sender: TObject);
    procedure edtDescriptionChange(Sender: TObject);
    procedure chkUsedSavedCardClick(Sender: TObject);
    procedure edtBankAccountChange(Sender: TObject);
    procedure edtCardNumberKeyPress(Sender: TObject; var Key: Char);
    procedure edtCardNumberKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    CurrencyCodes: TJsonObject;
    PaymentObj: TBusObj;
    fPaymentID: integer;
    fPaymentClass: TBusObjClass;
    DbConn: TDbConnection;
    Dirty: boolean;
    CardNo: string;
    fClientID: integer;
    procedure SetPaymentID(const Value: integer);
    procedure SetPaymentClass(const Value: TBusObjClass);
    procedure InitPaymentClass;
    procedure FormToObj;
    function ValidateData: boolean;
    procedure ProcessPayment;
    function SaveData: boolean;
    procedure CheckAndUpdateSavedCardDetails;
  public
    CardPayment: TCardPayment;
    property ClientID: integer read fClientID;
    property PaymentClass: TBusObjClass read fPaymentClass write SetPaymentClass;
    property PaymentID: integer read fPaymentID write SetPaymentID;
    procedure ObjToForm;
  end;

function DoCardPayment(const aPaymentClass: TBusObjClass; const aPaymentId: integer;
  aAccessLevel: integer; aCard: TCreditCard = nil): boolean;


implementation

uses
  AppEnvironment, JsonToObject, BusObjPayments, ObjectStorer, CommonLib,
  BusObjPrepayments, BusObjGLAccount, BusObjCash, Character, CardStripeObj,
  CommonDbLib;

{$R *.dfm}

function DoCardPayment(const aPaymentClass: TBusObjClass; const aPaymentId: integer;
  aAccessLevel: integer; aCard: TCreditCard = nil): boolean;
var
  form: TfmCardPayment;
  msg: string;
begin
  form := TfmCardPayment.Create(nil);
  try
    form.AccessLevel := aAccessLevel;
    form.PaymentClass := aPaymentClass;
    form.PaymentID := aPaymentId;
    if Assigned(aCard) then begin
      ObjToObj(aCard, form.CardPayment.Card);
      if aCard.GatewayName <> '' then
        form.cboGateway.ItemIndex := form.cboGateway.Items.IndexOf(aCard.GatewayName);
    end;
    if form.CardPayment.Card.Number = '' then begin
      form.CardPayment.Card.LoadFromErpClient(form.ClientID,form.MyConnection.Database,form.MyConnection.Server,msg);
    end;
    form.ObjToForm;
    result := form.ShowModal = mrOK;
  finally
    form.Free;
  end;
end;


procedure TfmCardPayment.btnProcessClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;

  ProcessPayment;
end;

procedure TfmCardPayment.cboCardMonthChange(Sender: TObject);
begin
  inherited;
  if not cboCardMonth.Focused then exit;
  Dirty := true;
end;

procedure TfmCardPayment.cboCardYearChange(Sender: TObject);
begin
  inherited;
  if not cboCardYear.Focused then exit;
  Dirty := true;
end;

procedure TfmCardPayment.cboCurrencyCodeChange(Sender: TObject);
var
  obj: TJsonObject;
  msg: string;
  s: string;
begin
  inherited;
  if cboCurrencyCode.ItemIndex >= 0 then begin
    if CurrencyCodes.ObjectExists(cboCurrencyCode.Text) then begin
      obj := CurrencyCodes.O[cboCurrencyCode.Text];
      edtAmount.Precision := obj.I['decimal_digits'];
    end;
  end;
  if (cboGateway.Text <> '') and (cboCurrencyCode.Text <> '') then begin
    s := AppEnv.UtilsClient.PayGateway.BankAccountForCurrency(MyConnection.Database,cboGateway.Text,cboCurrencyCode.Text, msg);
    if s <> '' then
      edtBankAccount.Text := s
    else begin
      if msg <> '' then
        CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    end;
  end;
end;

procedure TfmCardPayment.cboGatewayChange(Sender: TObject);
var
  s, msg: string;
begin
  inherited;
  if (cboGateway.Text <> '') and (cboCurrencyCode.Text <> '') then begin
    s := AppEnv.UtilsClient.PayGateway.BankAccountForCurrency(MyConnection.Database,cboGateway.Text,cboCurrencyCode.Text, msg);
    if s <> '' then
      edtBankAccount.Text := s
    else begin
      if msg <> '' then
        CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    end;
  end;
end;

procedure TfmCardPayment.CheckAndUpdateSavedCardDetails;
var
  SavedCard: TCreditCard;
  msg: string;
begin
  if self.ClientID < 1 then exit;

  SavedCard := TCreditCard.Create;
  try
    SavedCard.LoadFromErpClient(ClientID,MyConnection.Database,MyConnection.Server,msg);
    if (CardPayment.Card.Number <> SavedCard.Number) or
       (CardPayment.Card.CardholderName <> SavedCard.CardholderName) or
       (CardPayment.Card.ExpMonth <> SavedCard.ExpMonth) or
       (CardPayment.Card.ExpYear <> SavedCard.ExpYear) or
       (CardPayment.Card.CVC <> SavedCard.CVC) then begin
      if CommonLib.MessageDlgXP_Vista('Would you like to Update the Customer Card with these Card Details?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        if not CardPayment.Card.SaveToErpClient(ClientID,MyConnection.Database,MyConnection.Server,msg) then
          CommonLib.MessageDlgXP_Vista('Could not Update Customer Card: ' + msg,mtInformation,[mbOk],0);
      end;
    end;
  finally
    SavedCard.Free;
  end;
end;

procedure TfmCardPayment.chkUsedSavedCardClick(Sender: TObject);
begin
  inherited;
  Dirty := true;
end;

procedure TfmCardPayment.edtBankAccountChange(Sender: TObject);
begin
  inherited;
  if not edtBankAccount.Focused then exit;
  Dirty := true;
end;

procedure TfmCardPayment.edtCardholderNameChange(Sender: TObject);
begin
  inherited;
  if not edtCardholderName.Focused then exit;
  Dirty := true;
end;

procedure TfmCardPayment.edtCardNumberChange(Sender: TObject);
var
  s: string;
begin
  inherited;
  if not edtCardNumber.Focused then exit;
  Dirty := true;
  s := TCreditCard.CardTypeFromNumber(edtCardNumber.Text);
  if s <> '' then
    edtCardType.Text := s;
end;

procedure TfmCardPayment.edtCardNumberKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Card : TCardStripe;
  msg: string;
  x: integer;
begin
  if Key = VK_RETURN then begin
    if TCardStripe.IsCardStripe(CardNo) then begin
      Card := TCardStripe.Create;
      try
        if Card.ScanCard(CardNo, msg) then begin
          edtCardNumber.Text := Card.CardNumber;
          edtCardHolderName.Text := Card.Name;
          cboCardMonth.ItemIndex := cboCardMonth.Items.IndexOf(Copy(Card.ExpirationDate,3,2));
          for x := 0 to cboCardYear.Items.Count -1 do begin
            if Copy(cboCardYear.Items[x],3,2) = Copy(Card.ExpirationDate,1,2) then begin
              cboCardYear.ItemIndex := x;
              break;
            end;

          end;

        end
        else
          CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOK],0);

      finally
        Card.Free;
      end;

    end
    else
      edtCardNumber.Text := CardNo;

    CardNo := '';
  end;
  inherited;
end;

procedure TfmCardPayment.edtCardNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if TCharacter.IsNumber(Key) then begin
    if CardNo <> '' then begin
      CardNo := CardNo + Key;
      Key := #0;
    end;
  end
  else begin
    if not TCharacter.IsControl(Key) then begin
      CardNo := CardNo + Key;
      Key := #0;
    end;
  end;
  inherited;
end;

procedure TfmCardPayment.edtCVCChange(Sender: TObject);
begin
  inherited;
  if not edtCVC.Focused then exit;
  Dirty := true;
end;

procedure TfmCardPayment.edtDescriptionChange(Sender: TObject);
begin
  inherited;
  if not edtDescription.Focused then exit;
  Dirty := true;
end;

procedure TfmCardPayment.FormCreate(Sender: TObject);
var
  x: integer;
  year, month, day: word;
begin
  inherited;
  fClientID := 0;
  Dirty := false;
  CardNo := '';
  DbConn := TDbConnection.Create(MyConnection);
  CardPayment :=  TCardPayment.Create;
  PaymentObj := nil;
  CurrencyCodes := JO;
  if FileExists(ExtractFilePath(Application.ExeName) + 'Common-Currency.json') then begin
    CurrencyCodes.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Common-Currency.json');
    for x := 0 to CurrencyCodes.Count -1 do begin
      cboCurrencyCode.Items.Add(CurrencyCodes.Items[x].Name);
    end;
  end;

  if cboCurrencyCode.Items.Count > 0 then
    cboCurrencyCode.ItemIndex := cboCurrencyCode.Items.IndexOf(AppEnv.RegionalOptions.ForeignExDefault);

  cboGateway.Items.CommaText := AppEnv.UtilsClient.PayGateway.EnabledGatewayList;
  if cboGateway.Items.Count > 0 then
    cboGateway.ItemIndex := 0;

  DecodeDate(now,year,month,day);
  year := year -3;
  for x := 1 to 13 do begin
    cboCardYear.Items.Add(IntToStr(year));
    Inc(year);
  end;
end;

procedure TfmCardPayment.FormDestroy(Sender: TObject);
begin
  inherited;
  CurrencyCodes.Free;
  CardPayment.Free;
  PaymentObj.Free;
end;

procedure TfmCardPayment.FormToObj;
begin
  if Pos('#',edtCardNumber.Text) = 0 then
    CardPayment.Card.Number := edtCardNumber.Text;

  CardPayment.Card.CardType := edtCardType.Text;

  CardPayment.Card.CardholderName := edtCardholderName.Text;
  CardPayment.Card.ExpMonth := StrToIntDef(cboCardMonth.Text, 0);
  CardPayment.Card.ExpYear := StrToIntDef(cboCardYear.Text, 0);
  CardPayment.Card.CVC := edtCVC.Text;

  CardPayment.Amount := edtAmount.FloatValue;
  CardPayment.CurrencyCode := cboCurrencyCode.Text;
  CardPayment.Description := edtDescription.Text;
  CardPayment.Gateway := cboGateway.Text;
  CardPayment.ERPBankAccount := edtBAnkAccount.Text;
  Dirty := false;
end;

procedure TfmCardPayment.InitPaymentClass;
var
  qry: TERPQuery;
  TransType: string;
  BankAccountName: string;
  msg: string;
begin
  if Assigned(fPaymentClass) and (fPaymentID > 0) then begin

    FreeAndNil(PaymentObj);
    PaymentObj := fPaymentClass.CreateWithNewConn(nil);
    PaymentObj.Connection.Connection := MyConnection;
    PaymentObj.Load(fPaymentID);

    if PaymentObj is TCustPayments then begin
      TransType := PaymentObj.ClassName;  // 'CustomerPayment'
      fClientID := TCustPayments(PaymentObj).ClientID;
    end
    else if PaymentObj is TCustPrePayments then begin
      TransType := PaymentObj.ClassName;  // 'CustomerPrepayment'
      fClientID := TCustPrePayments(PaymentObj).ClientID;
    end
    else if PaymentObj is TSalesPayments then begin
      TransType := PaymentObj.ClassName;  // ''
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := MyConnection;
        qry.SQL.Add('select ClientID from tblsales');
        qry.SQL.Add('where SaleID = ' + IntToStr(TSalesPayments(PaymentObj).SaleID));
        qry.Open;
        fClientID := qry.FieldByName('ClientID').AsInteger;
      finally
        qry.Free;
      end;
    end
    else
      raise Exception.Create('Error - Unknown Payment Type');

    { do we already have an existing linked card payment .. }
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := MyConnection;
      qry.SQL.Add('select ID from tblCardPayment');
      qry.SQL.Add('where ERPTransType = "' + TransType + '"');
      qry.SQL.Add('and ERPTransID = ' + IntToStr(fPaymentID));
      qry.Open;
      if not qry.IsEmpty then begin
        { we have an existing record .. }
        self.KeyID := qry.FieldByName('ID').AsInteger;
        ObjectStorer.TObjStore.LoadObject(CardPayment,'tblCardPayment',DbConn, KeyID);
      end
      else begin
        { new payment }

        if PaymentObj is TCustPayments then begin
          CardPayment.ERPTransType := PaymentObj.Classname ; //'CustomerPayment';
          CardPayment.ERPTransID := PaymentObj.ID;
          CardPayment.CurrencyCode := TCustPayments(PaymentObj).ForeignExchangeCode;
          CardPayment.Amount := TCustPayments(PaymentObj).ForeignCurrencyAmount;
          CardPayment.ERPBankAccount := TCustPayments(PaymentObj).AccountName;
          CardPayment.Description :=  'Customer Payment ' + IntToStr(PaymentObj.ID);
        end
        else if PaymentObj is TCustPrePayments then begin
          CardPayment.ERPTransType := PaymentObj.Classname; //'CustomerPrepayment';
          CardPayment.ERPTransID := PaymentObj.ID;
          CardPayment.CurrencyCode := TCustPrePayments(PaymentObj).ForeignExchangeCode;
          CardPayment.Amount := TCustPrePayments(PaymentObj).ForeignPayAmount;
          CardPayment.ERPBankAccount := TAccount.IDToggle(TCustPrePayments(PaymentObj).BankAccountID,MyConnection);
          CardPayment.Description :=  'Customer Prepayment ' + IntToStr(PaymentObj.ID);
        end
        else if PaymentObj is TSalesPayments then begin
          CardPayment.ERPTransType := PaymentObj.ClassName;
          CardPayment.ERPTransID := PaymentObj.ID;
          CardPayment.CurrencyCode := AppEnv.RegionalOptions.ForeignExDefault;
          CardPayment.Amount := TSalesPayments(PaymentObj).Amount;
          CardPayment.ERPBankAccount := '';// TAccount.IDToggle(TCustPrePayments(PaymentObj).BankAccountID,MyConnection);
          CardPayment.Description :=  'Cash Sale ' + IntToStr(TSalesPayments(PaymentObj).SaleID) + ' ' + TSalesPayments(PaymentObj).PayMethod;
        end;

        if cboGAteway.Text <> '' then
          CardPayment.Gateway := cboGAteway.Text
        else begin
          if cboGateway.Items.Count > 0 then
            CardPayment.Gateway := cboGateway.Items[0];
        end;

        BankAccountName := '';
        if CardPayment.Gateway <> '' then
          BankAccountName :=
            AppEnv.UtilsClient.PayGateway.BankAccountForCurrency(MyConnection.Database,CardPayment.Gateway,CardPayment.CurrencyCode,msg);
        if BankAccountName <> '' then
          CardPayment.ERPBankAccount := BankAccountName;

      end;

    finally
      qry.Free;
    end;
    ObjToForm;

  end;
end;

procedure TfmCardPayment.ObjToForm;
var
  s: string;
  CtlReadOnly: boolean;
begin
  CtlReadOnly := (CardPayment.PaymentStatus = Ord(cpsProcessed)) or (AccessLevel = 5);
  edtCardNumber.Text := CardPayment.Card.HiddenNumber;
  edtCardNumber.ReadOnly := CtlReadOnly;
  edtCardType.Text := CardPayment.Card.CardType;

  edtCardholderName.Text := CardPayment.Card.CardholderName;
  edtCardholderName.ReadOnly := CtlReadOnly;

  if CardPayment.Card.ExpMonth > 0 then begin
    s := IntToStr(CardPayment.Card.ExpMonth);
    while Length(s) < 2 do
      s := '0' + s;
    cboCardMonth.ItemIndex := cboCardMonth.Items.IndexOf(s);
  end;
  cboCardMonth.Enabled := not CtlReadOnly;

  if CardPayment.Card.ExpYear > 0 then
    cboCardYear.ItemIndex := cboCardYear.Items.IndexOf(IntToStr(CardPayment.Card.ExpYear));
  cboCardYear.Enabled := not CtlReadOnly;

  if CardPayment.Card.CVC <> '' then
    edtCVC.Text := CardPayment.Card.CVC;
  edtCVC.ReadOnly := CtlReadOnly;

  edtAmount.FloatValue := CardPayment.Amount;
  cboCurrencyCode.ItemIndex := cboCurrencyCode.Items.IndexOf(CardPayment.CurrencyCode);
  if cboCurrencyCode.ItemIndex > -1 then
    cboCurrencyCode.Enabled := false
  else
    cboCurrencyCode.Enabled := not CtlReadOnly;

  edtDescription.Text := CardPayment.Description;
  edtDescription.ReadOnly := CtlReadOnly;

  cboGateway.ItemIndex := cboGateway.Items.IndexOf(CardPayment.Gateway);
  cboGateway.Enabled := not CtlReadOnly;

  cboStatus.ItemIndex := CardPayment.PaymentStatus;
  edtStatusComment.Text := CardPayment.StatusComment;
  case CardPayment.PaymentStatus of
    0: cboStatus.Font.Color := clBlack;  { None }
    1: cboStatus.Font.Color := clGreen;  { Processed }
    2: cboStatus.Font.Color := clRed;    { Failed }
  end;


  edtBankAccount.Text := CardPayment.ERPBankAccount;

  btnProcess.Enabled := not CtlReadOnly;
end;

procedure TfmCardPayment.ProcessPayment;
var
  msg: string;
  dlg: TProgressDialog;
begin

  { commit so server process can load current data .. }
  self.CommitTransaction;
  dlg := TProgressDialog.Create(nil);
  try

    { send to server .. }
    dlg.TimerUpdate := true;
    dlg.Caption := 'Processing Payment ..';
    dlg.Execute;
    if AppEnv.UtilsClient.PayGateway.ProcessPayment(MyConnection.Database,CardPayment.ID,msg) then begin
      dlg.CloseDialog;
      CommonLib.MessageDlgXP_Vista('Payment was Successful.',mtInformation,[mbOk],0);
      ModalResult := mrOk;
    end
    else begin
      ObjectStorer.TObjStore.LoadObject(CardPayment,TCardPayment.TableName,DbConn,CardPayment.ID);
      self.ObjToForm;
      dlg.CloseDialog;
      CommonLib.MessageDlgXP_Vista('Payment Failed: ' + msg,mtInformation,[mbOk],0);
    end;

  finally
    self.BeginTransaction;
    dlg.Free;
  end;
end;

function TfmCardPayment.SaveData: boolean;
begin
  if Dirty then
    self.FormToObj;
  result := ValidateData;
  if not result then exit;
  CheckAndUpdateSavedCardDetails;

  { save the data .. }
  ObjectStorer.TObjStore.SaveObject(CardPayment,TCardPayment.TableName,DbConn);

  if (CardPayment.RefID = '') then begin
    CardPayment.RefID := IntToStr(CardPayment.ID);
    ObjectStorer.TObjStore.SaveObject(CardPayment,TCardPayment.TableName,DbConn);
  end;

end;

procedure TfmCardPayment.SetPaymentClass(const Value: TBusObjClass);
begin
  fPaymentClass := Value;
  InitPaymentClass;
end;

procedure TfmCardPayment.SetPaymentID(const Value: integer);
begin
  fPaymentID := Value;
  InitPaymentClass;
end;

function TfmCardPayment.ValidateData: boolean;
begin
  result := false;
  if Length(edtCardNumber.Text) < 13 then begin
    CommonLib.MessageDlgXP_Vista('Card number is not long enough',mtInformation,[mbOK],0);
    exit;
  end;
  if cboCardMonth.ItemIndex < 0 then begin
    CommonLib.MessageDlgXP_Vista('Please select the card expiry month.',mtInformation,[mbOK],0);
    exit;
  end;
  if cboCardYear.ItemIndex < 0 then begin
    CommonLib.MessageDlgXP_Vista('Please select the card expiry year.',mtInformation,[mbOK],0);
    exit;
  end;
  if edtAmount.FloatValue = 0 then begin
    CommonLib.MessageDlgXP_Vista('Can not process payments for Zero Amounts.',mtInformation,[mbOK],0);
    exit;
  end;
  if edtDescription.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter a Description for this Payment.',mtInformation,[mbOK],0);
    exit;
  end;
  if cboGateway.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please select a Gatway for Processing this Payment.',mtInformation,[mbOK],0);
    exit;
  end;
  result := true;
end;

end.
