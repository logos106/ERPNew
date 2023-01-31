unit TrialBalTransListForm;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, BaseInputForm, EditJust, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTrialBalTransListGUI = class(TBaseListingGUI)
    qryMainDebitsEx: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryMainDebitsInc: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainTransID: TIntegerField;
    qryMainDate: TDateField;
    qryMainType: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPaymentID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainAccountType: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainPrepaymentID: TIntegerField;
    qryMainFixedAssetID: TIntegerField;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtEx: TEditJust;
    edtInc: TEditJust;
    chkUseDateRange: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure chkUseDateRangeClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    { Private declarations }
    fsAccountName: String;
    fsclassIDs: String;
    fDateFrom: TDateTime;
    fDateTo: TDateTime;
    fbshowdataPriorToClosingDate: Boolean;
    procedure AdjustDateRangeGUI;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
  public
    { Public declarations }
    Property AccountName  :String read fsAccountName  Write fsAccountName;
    Property classIDs     :String read fsclassIDs     Write fsclassIDs;
    property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;
    Property ShowdataPriorToClosingDate :Boolean read fbshowdataPriorToClosingDate write fbshowdataPriorToClosingDate;
  end;


implementation
     
uses strUtils, DNMlib, Commonlib,Systemlib, busobjStockMovement, FastFuncs,
  BusobjStockAdjustEntry, busobjstockTransferentry, tcConst,
  BusObjSaleBase, SalesConst, tcDataUtils, AppEnvironment;

{$R *.dfm}

procedure TTrialBalTransListGUI.ReadGuipref;
begin
  dtFrom.Date := 0;
  if GuiPrefs.Node.Exists('General') then begin
    dtto.Date := strTodate(GuiPrefs.Node['General.DateTo'].AsString);
    chkUseDateRange.checked := StrToBoolean(GuiPrefs.Node['General.useDate'].AsString);
    fbDateRangeSupplied := true;
    AdjustDateRangeGUI;
  end
  else begin
    dtto.Date := Date + appenv.Employee.ListDaysFuture;
  end;
end;

procedure TTrialBalTransListGUI.RefreshQuery;
(*var
  s:String;*)
begin
  DoShowProgressbar(2, WAITMSG);
  try
    qryMain.Close;
    qryMain.Params.ParamByName('DateFrom').asDate := DateFrom;
    qryMain.Params.ParamByName('DateTo').asDate := DateTo;
    qryMain.Params.ParamByName('ShowdataPriorToClosingDate').asString := BooleanToStr(ShowdataPriorToClosingDate);
    DoStepProgressbar();
    inherited;
    DoStepProgressbar();
  finally
    DoHideProgressbar;
  end;
end;

procedure TTrialBalTransListGUI.RefreshTotals;
var
  oRecPointer: TBookmark;
  dDebitsEx, dCreditsEx: double;
  dDebitsInc, dCreditsInc: double;
begin
  dDebitsEx := 0;
  dCreditsEx := 0;
  dDebitsInc := 0;
  dCreditsInc := 0;
  qryMain.DisableControls;
  oRecPointer := qryMain.GetBookmark;
  Try
    qryMain.First;
    while not qryMain.Eof do begin
      dDebitsEx   := dDebitsEx + qryMain.FieldByName('Debits (Ex)').AsFloat;
      dCreditsEx  := dCreditsEx + qryMain.FieldByName('Credits (Ex)').AsFloat;
      dDebitsInc  := dDebitsInc + qryMain.FieldByName('Debits (Inc)').AsFloat;
      dCreditsInc := dCreditsInc + qryMain.FieldByName('Credits (Inc)').AsFloat;
      qryMain.Next;
    end;
  Finally
    qryMain.GoToBookmark(oRecPointer);
    qryMain.FreeBookmark(oRecPointer);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('Debits (Ex)').FooterValue := FloatToStrF(dDebitsEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Credits (Ex)').FooterValue := FloatToStrF(dCreditsEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Debits (Inc)').FooterValue := FloatToStrF(dDebitsInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Credits (Inc)').FooterValue := FloatToStrF(dCreditsInc, ffCurrency, 15, CurrencyRoundPlaces);
  edtEx.text  := FloatToStrF(dCreditsEx  - dDebitsEx , ffCurrency, 15, CurrencyRoundPlaces);
  edtInc.text := FloatToStrF(dCreditsInc - dDebitsInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TTrialBalTransListGUI.WriteGuiPref;
begin
  GuiPrefs.Node['General.Datefrom'].AsString := DatetoStr(dtFrom.Date);
  GuiPrefs.Node['General.DateTo'].AsString := DatetoStr(dtto.Date);
  GuiPrefs.Node['General.usedate'].AsString := BooleanToStr(chkUseDateRange.checked);
end;

procedure TTrialBalTransListGUI.FormShow(Sender: TObject);
begin
  {$IFDEF DevMode}
  {$ELSE}
  GuiPrefs.DbGridElement[grdMain].RemoveFields('SaleID,PurchaseOrderID,PaymentID,AccountID,TransID,FixedAssetID,PrePaymentID,');
  {$ENDIF}

  if (AccountName<>'') or (classIDs <>'') then begin
    if Qrymain.Active then Qrymain.Close;
    Qrymain.SQL.clear;

    Qrymain.SQL.add('SELECT TransID, Date, Type,GlobalRef as "Global #", SaleID, ');
    Qrymain.SQL.add('PurchaseOrderID, PaymentID,PrepaymentID,FixedAssetID,AccountID,');
    Qrymain.SQL.add('AccountName as "Account Name", ');
    Qrymain.SQL.add('AccountType as "Account Type", ');
    Qrymain.SQL.add('DebitsEx as "Debits (Ex)", ');
    Qrymain.SQL.add('CreditsEx as "Credits (Ex)", ');
    Qrymain.SQL.add('DebitsInc as "Debits (Inc)", ');
    Qrymain.SQL.add('CreditsInc as "Credits (Inc)" ');
    Qrymain.SQL.add('FROM tblTransactions  Trans ');
    Qrymain.SQL.add('WHERE NOT(Trans.AccountType in ("EXEXP" ,"EXINC" , "EXP" ,"INC" ,"COGS")) ');
    if AccountName<> '' then Qrymain.SQL.add('AND (AccountName = ' + QuotedStr(AccountName) + ') ' );
    if classIDs   <> '' then Qrymain.SQL.add('AND ClassID Like ' + QuotedStr(classids));
    Qrymain.SQL.add('AND Trans.Date Between :DateFrom AND :DateTo ');
    Qrymain.SQL.add('AND  (:ShowdataPriorToClosingDate ="F" or TRans.Type <> "Closing Date Summary")');

    Qrymain.SQL.add('UNION ALL ');
    Qrymain.SQL.add('SELECT TransID, Date, Type,GlobalRef as "Global #", SaleID, ');
    Qrymain.SQL.add('PurchaseOrderID, PaymentID,PrepaymentID,FixedAssetID,AccountID,');
    Qrymain.SQL.add('AccountName as "Account Name", ');
    Qrymain.SQL.add('AccountType as "Account Type", ');
    Qrymain.SQL.add('DebitsEx as "Debits (Ex)", ');
    Qrymain.SQL.add('CreditsEx as "Credits (Ex)", ');
    Qrymain.SQL.add('DebitsInc as "Debits (Inc)", ');
    Qrymain.SQL.add('CreditsInc as "Credits (Inc)" ');
    Qrymain.SQL.add('FROM tblTransactions  Trans ');
    Qrymain.SQL.add('WHERE (Trans.AccountType in( "EXEXP" ,"EXINC" ,"EXP" ,"INC" ,"COGS")) ');
    if AccountName<> '' then Qrymain.SQL.add('AND (AccountName = ' + QuotedStr(AccountName) + ') ' );
    if classIDs   <> '' then Qrymain.SQL.add('AND ClassID Like ' + QuotedStr(classids));
    Qrymain.SQL.add('AND Trans.Date Between :DateFrom AND :Dateto ');
    Qrymain.SQL.add('AND  (:ShowdataPriorToClosingDate ="F" or TRans.Type <> "Closing Date Summary")');

    Qrymain.SQL.add('UNION ALL ');
    Qrymain.SQL.add('SELECT TransID, Date, Type,GlobalRef as "Global #", SaleID, ');
    Qrymain.SQL.add('PurchaseOrderID, PaymentID,PrepaymentID,FixedAssetID,AccountID,');
    Qrymain.SQL.add('AccountName as "Account Name", ');
    Qrymain.SQL.add('AccountType as "Account Type", ');
    Qrymain.SQL.add('DebitsEx as "Debits (Ex)", ');
    Qrymain.SQL.add('CreditsEx as "Credits (Ex)", ');
    Qrymain.SQL.add('DebitsInc as "Debits (Inc)", ');
    Qrymain.SQL.add('CreditsInc as "Credits (Inc)" ');
    Qrymain.SQL.add('FROM tbltransactionsummarydetails  Trans ');
    Qrymain.SQL.add('WHERE NOT(Trans.AccountType in ("EXEXP" ,"EXINC" , "EXP" ,"INC" ,"COGS")) ');
    if AccountName<> '' then Qrymain.SQL.add('AND (AccountName = ' + QuotedStr(AccountName) + ') ' );
    if classIDs   <> '' then Qrymain.SQL.add('AND ClassID Like ' + QuotedStr(classids));
    Qrymain.SQL.add('AND Trans.Date Between :DateFrom AND :DateTo ');
    Qrymain.SQL.add('AND :ShowdataPriorToClosingDate ="T"');

    Qrymain.SQL.add('UNION ALL ');
    Qrymain.SQL.add('SELECT TransID, Date, Type,GlobalRef as "Global #", SaleID, ');
    Qrymain.SQL.add('PurchaseOrderID, PaymentID,PrepaymentID,FixedAssetID,AccountID,');
    Qrymain.SQL.add('AccountName as "Account Name", ');
    Qrymain.SQL.add('AccountType as "Account Type", ');
    Qrymain.SQL.add('DebitsEx as "Debits (Ex)", ');
    Qrymain.SQL.add('CreditsEx as "Credits (Ex)", ');
    Qrymain.SQL.add('DebitsInc as "Debits (Inc)", ');
    Qrymain.SQL.add('CreditsInc as "Credits (Inc)" ');
    Qrymain.SQL.add('FROM tbltransactionsummarydetails  Trans ');
    Qrymain.SQL.add('WHERE (Trans.AccountType in( "EXEXP" ,"EXINC" ,"EXP" ,"INC" ,"COGS")) ');
    if AccountName<> '' then Qrymain.SQL.add('AND (AccountName = ' + QuotedStr(AccountName) + ') ' );
    if classIDs   <> '' then Qrymain.SQL.add('AND ClassID Like ' + QuotedStr(classids));
    Qrymain.SQL.add('AND Trans.Date Between :DateFrom AND :Dateto ');
    Qrymain.SQL.add('AND :ShowdataPriorToClosingDate ="T"');



    Qrymain.SQL.text :=ChangeQuery(Qrymain.SQL.text);
  end;
  RefreshOrignalSQL;
    inherited;
  AdjustDateRangeGUI;
end;

procedure TTrialBalTransListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  HideZeroValueInNumberfield(State,Field, Afont,Abrush);
end;

procedure TTrialBalTransListGUI.grdMainDblClick(Sender: TObject);
begin

       if (Sysutils.SameText(qryMainType.asString , TStockTransferEntry.Transtype)) then SubsequentID := Chr(95) + TransferType(QrymainSaleID.asInteger)  +  qryMain.Fields.FieldByName('Type').AsString
  else if (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))   then SubsequentID := Chr(95) + AdjustType(QrymainSaleID.asInteger)    +  qryMain.Fields.FieldByName('Type').AsString
  else SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;

  if SameText(qryMain.Fields.FieldByName('Type').AsString,'Cash Sale') then begin
    case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end;
  inherited;
end;

procedure TTrialBalTransListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMainType.asString , TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := (*TStockMovement.TransactionID(*)QrymainSaleID.asInteger(*)*);
  end;
  if Popupform.KeyId = 0 then inherited;

end;

procedure TTrialBalTransListGUI.chkUseDateRangeClick(Sender: TObject);
begin
  inherited;
  if not isFormshown then exit;

  AdjustDateRangeGUI;
  RefreshQuery;

end;
procedure TTrialBalTransListGUI.AdjustDateRangeGUI;
begin
  if chkUseDateRange.checked then begin
    dtFrom.visible := true;
    lblFrom.visible := true;
    cboDateRange.visible := true;
    lblTo.Caption := 'To';
    if dtFrom.Date = 0 then dtFrom.Date := incmonth(now, -1);
    chkUseDateRange.left := cboDateRange.left -chkUseDateRange.width -2;
  end  else begin
    dtFrom.visible := False;
    lblFrom.visible := False;
    cboDateRange.visible := False;
    lblTo.Caption := 'As Of';
    chkUseDateRange.left := dtTo.Left + dtTo.width - chkUseDateRange.width;
  end;
end;

procedure TTrialBalTransListGUI.FormCreate(Sender: TObject);
begin
  NonSearchMode:= true;
  inherited;
  fsAccountName :='';
  fsclassIDs    :='';

end;

initialization
  RegisterClassOnce(TTrialBalTransListGUI);
end.
