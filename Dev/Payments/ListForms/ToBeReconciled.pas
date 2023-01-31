unit ToBeReconciled;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  wwcheckbox, BaseInputForm, DAScript, MyScript, CustomInputBox;

type
  TToBeReconciledGUI = class(TBaseListingGUI)
    qryMainCategory: TWideStringField;
    qryMainDepositID: TIntegerField;
    qryMainDepositLineID: TLargeintField;
    qryMainDepositDate: TDateField;
    qryMainAmount: TFloatField;
    qryMainPaymentID: TIntegerField;
    qryMainCusID: TLargeintField;
    qryMainReferenceNo: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainCompanyName: TWideStringField;
    qryAccount: TERPQuery;
    Label4: TLabel;
    cboAccount: TwwDBLookupCombo;
    lblProgress: TLabel;
    chkAllAccounts: TwwCheckBox;
    qryAccountAccountName: TWideStringField;
    qryAccountAccountID: TIntegerField;
    qryAccountAccountType: TWideStringField;
    DNMPanel1: TDNMPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtTotd: TEdit;
    edtTotw: TEdit;
    edtTotb: TEdit;
    qryMainCAmount: TFloatField;
    chkShowreconciled: TwwCheckBox;
    Label8: TLabel;
    qryMainReconciled: TWideStringField;
    qryMainAccountId: TIntegerField;
    procedure cboAccountCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboAccountEnter(Sender: TObject);
    procedure chkAllAccountsClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure Label8Click(Sender: TObject);
    procedure chkShowreconciledClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    (*function GetDepositPaymentID(const DepositID: integer; const TrnsType: string = ''): integer;*)
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
  public
    Procedure RefreshQuery;Override;
  end;

var
  ToBeReconciledGUI: TToBeReconciledGUI;

implementation

uses ReconcilitaionLib, CommonLib, FastFuncs, CommonDbLib, tcConst , tcDataUtils;

{$R *.dfm}

procedure TToBeReconciledGUI.cboAccountCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TToBeReconciledGUI.cboAccountEnter(Sender: TObject);
begin
  inherited;
  opendb(qryAccount);
  if cboAccount.text = '' then begin
    if qryAccount.RecordCount > 0 then begin
        qryAccount.first;
        cboAccount.text := qryAccountAccountName.asString;
    end;
  end;
end;

procedure TToBeReconciledGUI.RefreshQuery;
begin
  closedb(Qrymain);
  Qrymain.Sql.clear;
  if chkAllAccounts.checked then
    Qrymain.Sql.add(ReconcilitaionLib.ToBeREconciled(0,False,0 , chkShowreconciled.checked))
  else Qrymain.Sql.add(ReconcilitaionLib.ToBeREconciled(qryAccountAccountID.asInteger,False,0,chkShowreconciled.checked));
  inherited;
end;
procedure TToBeReconciledGUI.chkAllAccountsClick(Sender: TObject);
begin
  inherited;
  cboAccount.enabled :=not(chkAllAccounts.checked);
  if chkAllAccounts.checked then
  else SetControlFocus(cboAccount);
  RefreshQuery;
end;

procedure TToBeReconciledGUI.qryMainAfterOpen(DataSet: TDataSet);
var
  totd, totW, totb :double;
begin
  inherited;
  totd:=0;
  totW := 0;
  try
    if Qrymain.recordcount = 0 then exit;
    Qrymain.first;
    while Qrymain.Eof = False do begin
      if SameText(Qrymaincategory.asString , 'Deposits') then
        totd:= totD + Qrymaincamount.asfloat
       else  totW:= totW +Qrymaincamount.asfloat;
      Qrymain.next;
    end;
  Finally
      totb :=  totw - totd;
      edtTotd.Text := FloatToStrF(totd    ,ffCurrency, 15, CurrencyRoundPlaces);
      edtTotw.Text := FloatToStrF(totw    ,ffCurrency, 15, CurrencyRoundPlaces);
      edtTotb.Text := FloatToStrF(totb    ,ffCurrency, 15, CurrencyRoundPlaces);
  end;
end;

procedure TToBeReconciledGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if Sysutils.SameText(qryMainCategory.asString , 'Withdrawal') then
    qryMainCAmount.asFloat := 0-qryMainAmount.asfloat
    else qryMainCAmount.asFloat := qryMainAmount.asfloat;
end;

procedure TToBeReconciledGUI.Label8Click(Sender: TObject);
begin
  inherited;
   RefreshQuery;
end;

procedure TToBeReconciledGUI.chkShowreconciledClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TToBeReconciledGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainNotes.asString;
  inherited;
end;

(*function TToBeReconciledGUI.GetDepositPaymentID(const DepositID: integer;
  const TrnsType: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := CommonDbLib.TempMyQuery;
  try
    if Empty(TrnsType) then begin
      qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines Where PaymentID = ' + QuotedStr(IntToStr(DepositID)) + ';');
    end else begin
      qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines WHERE DepositID = ' + QuotedStr(IntToStr(DepositID)));
      qryTemp.Sql.Add(' AND TrnsType=' + QuotedStr(Trim(TrnsType)) + ';');
    end;

    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PaymentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;

end;*)

procedure TToBeReconciledGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
      (*if (qryMainNotes.asString = DEPOSIT_ENTRY) or (qryMainNotes.asString = BANK_DEPOSIT) or (qryMainNotes.asString = DEPOSIT_SPLIT) then begin
        Popupform.KeyID := qryMainPaymentID.asInteger;
      end else begin
        Popupform.KeyID := GetDepositPaymentID(qrymaindepositID.asInteger, qryMainNotes.asString);
      end;*)
      Popupform.KeyID := qryMainPaymentID.asInteger;
end;

initialization
  RegisterClassOnce(TToBeReconciledGUI);

end.
