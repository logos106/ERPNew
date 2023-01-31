unit frmPaymentCardDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DBCtrls, DNMSpeedButton, Shader, DNMPanel,
  CreditCardObj;

type
  TfmPaymentCardDetails = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label62: TLabel;
    edtCardholderName: TEdit;
    Label22: TLabel;
    edtCardNumber: TEdit;
    Label61: TLabel;
    cboCardMonth: TComboBox;
    cboCardYear: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtCVC: TEdit;
    chkUsedSavedCard: TCheckBox;
    cboGateway: TComboBox;
    Label3: TLabel;
    edtCardType: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure chkUsedSavedCardClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtCardNumberKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCardNumberKeyPress(Sender: TObject; var Key: Char);
    procedure edtCardNumberChange(Sender: TObject);
  private
    fCard: TCreditCard;
    fClientID: integer;
    CardNo: string;
    function HideNumber(const aCardNumber: string): string;
    procedure CheckAndUpdateSavedCardDetails;
  public
    property Card: TCreditCard read fCard write fCard;
    property ClientID: integer read fClientID write fClientID;
    procedure CardToForm;
    function FormToCard(const Validate: boolean = true): boolean;
  end;

  function GetCreditCard(aCard: TCreditCard; aGatewayList: TStrings; const aClientID: integer = 0): boolean;

implementation

{$R *.dfm}

uses
  CommonLib, CardStripeObj, Character, CommonDbLib;

function GetCreditCard(aCard: TCreditCard; aGatewayList: TStrings; const aClientID: integer = 0): boolean;
var
  form: TfmPaymentCardDetails;
  msg: string;
begin
  form := TfmPaymentCardDetails.Create(nil);
  try
    form.Card := aCard;
    form.ClientID := aClientID;
    form.chkUsedSavedCard.Visible := aClientID > 0;
    form.cboGateway.Items.Assign(aGatewayList);
    if aGatewayList.Count = 1 then
      form.cboGateway.ItemIndex := 0;
    if (aCard.Number = '') and (aClientID > 0) then begin
      form.Card.LoadFromErpClient(aClientID,form.MyConnection.Database,form.MyConnection.Server,msg);
      form.chkUsedSavedCard.Checked := true;
    end;
    form.CardToForm;
    if (aGatewayList.Count = 1) then
      form.cboGateway.ItemIndex := 0;
    result := form.ShowModal = mrOk;
  finally
    form.Free;
  end;
end;

procedure TfmPaymentCardDetails.btnOKClick(Sender: TObject);
begin
  inherited;
  if FormToCard(true) then begin
    CheckAndUpdateSavedCardDetails;
    ModalResult := mrOk;
  end;
end;

procedure TfmPaymentCardDetails.CardToForm;
var
  monthStr, yearStr: string;
begin
  if Length(Card.Number) > 4 then
    edtCardNumber.Text := HideNumber(Card.Number)
  else
    edtCardNumber.Text := Card.Number;
  edtCardType.Text := Card.CardType;
  edtCardholderName.Text := Card.CardholderName;
  if Card.ExpMonth > 0 then begin
    monthStr := IntToStr(Card.ExpMonth);
    if Length(monthStr) < 2 then
      monthStr := '0' + monthStr;
    cboCardMonth.ItemIndex := cboCardMonth.Items.IndexOf(monthStr);
  end
  else
    cboCardMonth.ItemIndex := -1;
  yearStr := IntToStr(Card.ExpYear);
  cboCardYear.ItemIndex := cboCardYear.Items.IndexOf(yearStr);
  if Card.CVC <> '' then
    edtCVC.Text := Card.CVC
  else
    edtCVC.Text := '';
  cboGateway.ItemIndex := cboGateway.Items.IndexOf(Card.GatewayName);
  if cboGateway.ItemIndex < 0 then begin
    if cboGateway.Items.Count = 1 then
      cboGateway.ItemIndex := 0;
  end;

end;

procedure TfmPaymentCardDetails.CheckAndUpdateSavedCardDetails;
var
  SavedCard: TCreditCard;
  msg: string;
begin
  if self.ClientID < 1 then exit;

  SavedCard := TCreditCard.Create;
  try
    SavedCard.LoadFromErpClient(ClientID,MyConnection.Database,MyConnection.Server,msg);
    if (Card.Number <> SavedCard.Number) or
       (Card.CardholderName <> SavedCard.CardholderName) or
       (Card.ExpMonth <> SavedCard.ExpMonth) or
       (Card.ExpYear <> SavedCard.ExpYear) or
       (Card.CVC <> SavedCard.CVC) then begin
      if CommonLib.MessageDlgXP_Vista('Would you like to Update the Customer Card with these Card Details?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        if not Card.SaveToErpClient(ClientID,MyConnection.Database,MyConnection.Server,msg) then
          CommonLib.MessageDlgXP_Vista('Could not Update Customer Card: ' + msg,mtInformation,[mbOk],0);
      end;
    end;
  finally
    SavedCard.Free;
  end;
end;

procedure TfmPaymentCardDetails.chkUsedSavedCardClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if not chkUsedSavedCard.Focused then exit;

  if TCheckBox(Sender).Checked then begin
    if not Card.LoadFromErpClient(ClientID,MyConnection.Database,MyConnection.Server,msg) then
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    CardToForm;
  end;
end;

procedure TfmPaymentCardDetails.edtCardNumberChange(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := TCreditCard.CardTypeFromNumber(edtCardNumber.Text);
  if s <> '' then
    edtCardType.Text := s;
end;

procedure TfmPaymentCardDetails.edtCardNumberKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

procedure TfmPaymentCardDetails.edtCardNumberKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfmPaymentCardDetails.FormCreate(Sender: TObject);
var
  year, month, day: word;
  x: integer;
begin
  inherited;
  CardNo := '';
  DecodeDate(now,year,month,day);
  year := year -3;
  for x := 1 to 13 do begin
    cboCardYear.Items.Add(IntToStr(year));
    Inc(year);
  end;
end;

function TfmPaymentCardDetails.FormToCard(const Validate: boolean): boolean;
var
  cardNum: string;
begin
  result := true;
  if Pos('#',edtCardNumber.Text) = 0 then
    cardNum := StringReplace(edtCardNumber.Text,' ','',[rfReplaceAll])
  else
    cardNum := Card.Number;
  if Validate then begin
    if Length(cardNum) < 13 then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('Card number is to short.',mtInformation,[mbOK],0);
      exit;
    end;
    if cboCardMonth.Text = '' then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('Card expiry month is missing.',mtInformation,[mbOK],0);
      exit;
    end;
    if cboCardYear.Text = '' then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('Card expiry year is missing.',mtInformation,[mbOK],0);
      exit;
    end;
    if (edtCVC.Text <> '') and (StrToIntDef(edtCVC.Text,0) =0)  then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('Card CVC number is invalid.',mtInformation,[mbOK],0);
      exit;
    end;
    if cboGateway.Text = '' then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('Gatway is missing.',mtInformation,[mbOK],0);
      exit;
    end;
  end;
  Card.Number := cardNum;
  Card.CardType := edtCardType.Text;
  Card.ExpYear := StrToInt(cboCardYear.Text);
  Card.ExpMonth := StrToInt(cboCardMonth.Text);
  Card.CVC := edtCVC.Text;
  Card.CardholderName := edtCardHolderName.Text;
  Card.GatewayName := cboGateway.Text;
end;

function TfmPaymentCardDetails.HideNumber(const aCardNumber: string): string;
var
  i, x: integer;
begin
  result := '';
  x:= 1;
  for I := Length(aCardNumber) downto 1 do begin
    if x <= 4 then result := aCardNumber[i] + result
    else result := '#' + result;
    Inc(x);
  end;
end;

end.
