unit ReconListDetailForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  wwcheckbox, BaseInputForm;

type
  TReconListDetailFormGUI = class(TBaseListingGUI)
    Label6: TLabel;
    cboAccount: TwwDBLookupCombo;
    lblProgress: TLabel;
    chkAllAccounts: TwwCheckBox;
    qryAccount: TERPQuery;
    qryAccountAccountName: TWideStringField;
    qryAccountAccountID: TIntegerField;
    qryAccountAccountType: TWideStringField;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    edtTotd: TEdit;
    Label5: TLabel;
    edtTotw: TEdit;
    Label7: TLabel;
    edtTotb: TEdit;
    qryMaindetails: TLargeintField;
    qryMainCategory: TWideStringField;
    qryMainReconciliationLineID: TLargeintField;
    qryMainPaymentID: TLargeintField;
    qryMainReference: TWideStringField;
    qryMainPayee: TWideStringField;
    qryMainDepositDate: TDateField;
    qryMainAmount: TFloatField;
    qryMainNotes: TWideStringField;
    qryMainDeposited: TWideStringField;
    qryMainReconciled: TWideStringField;
    qryMainDepositLineID: TLargeintField;
    qryMainClientID: TLargeintField;
    qryMaincompany: TWideStringField;
    qryMainReconciliationID: TIntegerField;
    qryMainRAccountId: TIntegerField;
    qryMaincAmount: TFloatField;
    btnHidetotals: TDNMSpeedButton;
    qryMainAccountName: TWideStringField;
    qryMainAccountID: TIntegerField;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboAccountEnter(Sender: TObject);
    procedure chkAllAccountsClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnHidetotalsClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
  private
    Hidetotals:Boolean;
    Procedure FilterQrymain;
    function GetDepositPaymentID(const DepositID: integer; const TrnsType: string = ''): integer;
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    Procedure SetGridColumns;override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, FastFuncs, tcConst, CommonDbLib;

{$R *.dfm}
procedure TReconListDetailFormGUI.qryMainAfterOpen(DataSet: TDataSet);
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
      if qryMaindetails.asInteger = 2 then
        if SameText(Qrymaincategory.asString , 'Deposits') then
          totd:= totD + Qrymainamount.asfloat
         else  totW:= totW +Qrymainamount.asfloat;
      Qrymain.next;
    end;
  Finally
      totb :=   totw- totd;
      edtTotd.Text := FloatToStrF(totd    ,ffCurrency, 15, CurrencyRoundPlaces);
      edtTotw.Text := FloatToStrF(totw    ,ffCurrency, 15, CurrencyRoundPlaces);
      edtTotb.Text := FloatToStrF(totb    ,ffCurrency, 15, CurrencyRoundPlaces);
  end;

end;

procedure TReconListDetailFormGUI.cboAccountCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  chkAllAccounts.checked := (cboAccount.text = '');
  FilterQrymain;
end;

procedure TReconListDetailFormGUI.cboAccountEnter(Sender: TObject);
begin
  inherited;
  opendb(qryAccount);
  if cboAccount.text = '' then begin
    if qryAccount.RecordCount > 0 then begin
        qryAccount.first;
        cboAccount.text := qryAccountAccountName.asString;
        FilterQrymain;
    end;
  end;
  
end;

procedure TReconListDetailFormGUI.chkAllAccountsClick(Sender: TObject);
begin
  inherited;
  cboAccount.enabled :=not(chkAllAccounts.checked);
  if chkAllAccounts.checked then
  else SetControlFocus(cboAccount);
  FilterQrymain;
end;

procedure TReconListDetailFormGUI.RefreshQuery;
begin
  inherited;
end;

procedure TReconListDetailFormGUI.FilterQrymain;
begin
  GroupFilterString := '';
  if chkAllAccounts.checked then GroupFilterString := '' else GroupFilterString := 'RAccountId = ' +InttoStr(qryAccountAccountID.asInteger);

  if Hidetotals then begin
    if GroupFilterString  <> '' then GroupFilterString  := GroupFilterString  +' and ';
    GroupFilterString  := GroupFilterString  + ' Details <>1';
  end;
  inherited grpFiltersClick(grpFilters);
end;

procedure TReconListDetailFormGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if QrymainDEtails.asInteger = 1 then begin
      if (Sysutils.SameText(Field.fieldname , 'Category')) or
      (Sysutils.SameText(Field.fieldname , 'ReconciliationID')) or
      (Sysutils.SameText(Field.fieldname , 'Accountname')) or
        (Sysutils.SameText(Field.fieldname , 'CAmount')) then
          AFont.color := clred
        else AFont.Color := Abrush.color;
  end;
end;

procedure TReconListDetailFormGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if Sysutils.SameText(qryMainCategory.asString , 'Withdrawals') then
    qryMainCAmount.asFloat := 0-qryMainAmount.asfloat
    else qryMainCAmount.asFloat := qryMainAmount.asfloat;

end;

procedure TReconListDetailFormGUI.btnHidetotalsClick(Sender: TObject);
begin
  inherited;
  if SameText(btnHidetotals.Caption , 'Hide totals') then begin
    btnHidetotals.Caption := 'Show Totals';
    Hidetotals:= TRue;
  end else begin
    btnHidetotals.Caption := 'Hide Totals';
    Hidetotals := False;
  end;
  FilterQrymain;
end;


procedure TReconListDetailFormGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainNotes.asString;
  inherited;
end;

procedure TReconListDetailFormGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  (*Popupform.KeyID := qryMainPaymentID.asInteger;*)
  if (qryMainNotes.asString = DEPOSIT_ENTRY) or (qryMainNotes.asString = BANK_DEPOSIT) or (qryMainNotes.asString = DEPOSIT_SPLIT) then begin
        Popupform.KeyID := qryMainPaymentID.asInteger;
      end else begin
        Popupform.KeyID := GetDepositPaymentID(qryMainPaymentID.asInteger, qryMainNotes.asString);
  end;
end;

function TReconListDetailFormGUI.GetDepositPaymentID(
  const DepositID: integer; const TrnsType: string): integer;
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

end;


procedure TReconListDetailFormGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Hidetotals := false;
end;

procedure TReconListDetailFormGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('AccountID');
  RemoveFieldfromGrid('RAccountID');
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('ReconciliationlineID');
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('Amount');
end;

initialization
  RegisterClassOnce(TReconListDetailFormGUI);
end.
