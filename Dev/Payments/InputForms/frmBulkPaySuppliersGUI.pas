unit frmBulkPaySuppliersGUI;
{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 ??/04/05  1.00.00 ???  Initial version.
 14/10/05  1.00.01 AL   1. Fixed bug in edtAmtTenderedExit procedure.
                        2. Added two fields in Grid AmountToPay, BalanceLeft
                        3. Changed calculation of amounts
                        4. Now pay "AmountToPay" instead of "AmountDue"
 19/10/05  1.00.02 DLS  Added RegisterClass
 17/01/06  1.00.03 IJB  Changed Value to AsFloat in a couple of places
                        ('Amount to pay' not setting when user clicks on Pay)

}

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, kbmMemTable, ExtCtrls, DNMPanel, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,  Grids, Wwdbigrd, Wwdbgrid,
  StdCtrls, Buttons, DNMSpeedButton, MemDS, wwdblook, ActnList, ActnMan, Mask, DBCtrls,
  wwdbdatetimepicker, wwcheckbox, DataState, frmBulkPaymentsPrintOptions,
  PrintDAT, Menus, AdvMenus, ImgList, wwdbedit, kbmMemBinaryStreamFormat, Shader,
  dmGUIStylers,busobjbase, PlatformDefaultStyleActnCtrls, ProgressDialog , frmBulkPayBase;

type
  TfrmBulkPaySuppliers = class(TfmBulkPayBase)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    Label1: TLabel;
    edtAmtTendered: TEdit;
    Label2: TLabel;
    edtBalance: TEdit;
    Label3: TLabel;
    edtRunningBalance: TEdit;
    qryMainGlobalRef: TWideStringField;
    qryMainID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainType: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainDueDate: TDateField;
    qryMainPONumber: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainInvoiceDate: TDateField;
    qryMainName: TWideStringField;
    qryMainOriginalAmount: TFloatField;
    qryMainAmountDue: TFloatField;
    qryMainTransAmount: TFloatField;
    qryMainTransPayment: TFloatField;
    qryMainTransBalance: TFloatField;
    qryMainCurrent: TFloatField;
    qryMainDSDesigner30Days: TFloatField;
    qryMainDSDesigner60Days: TFloatField;
    qryMainDSDesigner90Days: TFloatField;
    qryMainDSDesigner120Days: TFloatField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainTransID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainEditedFlag: TWideStringField;
    qryMainPay: TWideStringField;
    Label4: TLabel;
    cboBasis: TComboBox;
    Label81: TLabel;
    cboAccount: TwwDBLookupCombo;
    ActionManager1: TActionManager;
    actPay: TAction;
    cboAccountQry: TERPQuery;
    cboPayMethod_Label: TLabel;
    cboPaymentMethod: TwwDBLookupCombo;
    qryPayMethod: TERPQuery;
    lblTo: TLabel;
    lblFrom: TLabel;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    IgnoreDates: TCheckBox;
    Label5: TLabel;
    cboClassQry: TERPQuery;
    chkAddToEFT: TwwCheckBox;
    Label7: TLabel;
    imgPopup: TImageList;
    pumOptions: TAdvPopupMenu;
    AddtoFilter1: TMenuItem;
    ExecuteFilter1: TMenuItem;
    ClearFilter1: TMenuItem;
    Label8: TLabel;
    cboFilter: TComboBox;
    Label9: TLabel;
    edtSearch: TEdit;
    btnAddFilter: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnClearFilter: TDNMSpeedButton;
    Bevel1: TBevel;
    edtBankBalance: TwwDBEdit;
    dsAccountQry: TDataSource;
    cboAccountQryGlobalRef: TWideStringField;
    cboAccountQryAccountID: TIntegerField;
    cboAccountQryAccountName: TWideStringField;
    cboAccountQryAccountType: TWideStringField;
    cboAccountQryBalance: TFloatField;
    cboAccountQryDescription: TWideStringField;
    cboAccountQryAccountNumber: TWideStringField;
    cboAccountQryTaxcode: TWideStringField;
    cboAccountQryBankNumber: TWideStringField;
    cboAccountQryExtra: TWideStringField;
    cboAccountQryActive: TWideStringField;
    cboAccountQryEditedFlag: TWideStringField;
    cboAccountQryClass: TWideStringField;
    cboAccountQryAllClasses: TWideStringField;
    cboAccountQryOpeningBalance: TFloatField;
    cboAccountQryDebits: TFloatField;
    cboAccountQryCredits: TFloatField;
    cboAccountQryClosingBalance: TFloatField;
    cboAccountQryAccountGroup: TWideStringField;
    cboAccountQryBankAccountName: TWideStringField;
    cboAccountQryLevel1: TWideStringField;
    cboAccountQryLevel2: TWideStringField;
    cboAccountQryLevel3: TWideStringField;
    cboAccountQryLevel4: TWideStringField;
    cboAccountQryRequired: TWideStringField;
    cboAccountQryBankCode: TWideStringField;
    cboAccountQryAPCANo: TWideStringField;
    cboAccountQryBSB: TWideStringField;
    cboAccountQryIncludeBalanceRecord: TWideStringField;
    cboAccountQryBankAccountNumber: TWideStringField;
    cboAccountQryIncludeNetTotal: TWideStringField;
    cboAccountQryIncludeCreditTotal: TWideStringField;
    cboAccountQryIncludeDebitTotal: TWideStringField;
    cboAccountQryType: TWideStringField;
    chkAllPayments: TwwCheckBox;
    Label10: TLabel;
    PaymentDate: TwwDBDateTimePicker;
    Label11: TLabel;
    kbmBinaryStreamFormat: TkbmBinaryStreamFormat;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboAccountQryLastChequeNo: TIntegerField;
    cboAccountQryUseLastChequeNo: TWideStringField;
    DNMPanel5: TDNMPanel;
    grdmain: TwwDBGrid;
    qryMainAmountToPay: TFloatField;
    qryMainBalanceLeft: TFloatField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainAPNotes: TWideMemoField;
    qryMainForeignExchangecode: TWideStringField;
    qryMainForeignExchangeRate: TFloatField;
    lblClassTitle: TLabel;
    cboClass: TwwDBLookupCombo;
    Label6: TLabel;
    chkAllClass: TwwCheckBox;
    Label12: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtAmtTenderedKeyPress(Sender: TObject; var Key: char);
    procedure edtAmtTenderedExit(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure actPayUpdate(Sender: TObject);
    procedure PerformSuggestion;
    procedure IgnoreDatesClick(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure dtFromChange(Sender: TObject);
    procedure edtAmtTenderedEnter(Sender: TObject);
    procedure cboBasisCloseUp(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure edtSearchChange(Sender: TObject);
    procedure btnAddFilterClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnClearFilterClick(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboPaymentMethodCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkAllPaymentsClick(Sender: TObject);
    procedure PaymentDateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPayExecute(Sender: TObject);
    procedure qryMainPayChange(Sender: TField);
    procedure grdmainColEnter(Sender: TObject);
    procedure grdmainCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grdmainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure qryMainAmountToPayChange(Sender: TField);
    procedure grdmainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdmainDblClick(Sender: TObject);
    procedure edtAmtTenderedDblClick(Sender: TObject);
    procedure dtToExit(Sender: TObject);
    procedure dtFromExit(Sender: TObject);
  private
    fbShowamtMsg:Boolean;
    fbGettingAPBalances : boolean;
    fbCalcRunning       : boolean;
    oPrintOptions       : TPrintOptions;
    PrevDateTo          : TDateTime;
    PrevDateFrom        : TDateTime;
    FormshowDone        : boolean;
    fsTablename         : String;
    Reportname          : String;
    fsSortColumnName    : string;
    fsColumnOrderMode   : string;
    fWarningAcked       : boolean;
    DoingPayChange: boolean;
    chequeno:String;
    HIGHLIGHTLOCATE: TColor;
    procedure DoGetAPBalances;
    procedure PrintScreenReport(SelectedOnly: boolean = false;DoEmail :Boolean =False; SQLWhere :String = ''; ClientName :String =''; ClientEmail :String = '';
      const aSilent : boolean = false; const aSecret : boolean = false);

    procedure InitialiseEditor;
    procedure BuildSearchColumnCombo;
    Procedure PrintReceipts(Const Sender: TBusObj; var Abort: Boolean);
    Procedure EmailTemplateReport;Overload;
    {$HINTS OFF}
    Procedure EmailTemplateReport(Const Sender: TBusObj; var Abort: Boolean);Overload;
    {$HINTS ON}
    Procedure Printcheques(Const Sender: TBusObj; var Abort: Boolean);

    procedure OpensupPayment(const IDS: string);
    procedure DoClosingDateREfresh(Const AfterPayCreated:boolean = False);
  Protected
    Procedure DoDeSelectall;Override;
    Procedure DoSelectAll;Override;
    procedure CalcBalance;Override;
    procedure DoCalculateRunningBalance;Override;

  public
  end;


implementation

uses
  DNMExceptions, Report_AP_Obj,
  CommonLib,  DateUtils,
  FastFuncs, AppEnvironment,commondbLib, BusObjPayments, DNMLib,
  tcDataUtils, MySQLConst, BusObjClient, BusObjGLAccount, TransactionsTable,
  CommonFormLib, tcConst, EmailExtraUtils, DbSharedObjectsObj, chequeLib;

{$R *.dfm}

const
  HIGHLIGHTLOCATEDEF = $00FFC891; // a very light Blue

{ TfrmBulkPaySuppliers }
Procedure TfrmBulkPaySuppliers.DoDeSelectall;
begin
    if Qrymain.fieldByname('Pay').AsBoolean then   begin
        EditQrymain;
        Qrymain.fieldByname('Pay').AsBoolean  := False;
        PostQrymain;
    end;
end;
Procedure TfrmBulkPaySuppliers.DoSelectAll;
begin
    if not(Qrymain.fieldByname('Pay').AsBoolean) then begin
      if Sysutils.SameText(qryMainForeignExchangecode.asString , appenv.RegionalOptions.ForeignExDefault) then begin
        EditQrymain;
        Qrymain.fieldByname('Pay').AsBoolean  := True;
        PostQrymain;
      end;
    end;
end;


procedure TfrmBulkPaySuppliers.FormCreate(Sender: TObject);
begin
  fsTablename           := commondbLib.CreateUserTemporaryTable('tmp_tblaccountspayable' , '_BulkAP');
  inherited;
  FormshowDone          := false;
  fbGettingAPBalances   := false;
  fbCalcRunning         := false;
  dAmtTendered          := 0;
  sFilter               := '';
  sBaseIndexFieldNames  := '';
  fbShowamtMsg:=False;
  DoingPayChange := false;
  if AppEnv.Employee.ListSelectionColour = 0 then begin
    HIGHLIGHTLOCATE := HIGHLIGHTLOCATEDEF;
  end else begin
    HIGHLIGHTLOCATE := AppEnv.Employee.ListSelectionColour;
  end;
end;

procedure TfrmBulkPaySuppliers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;
Procedure TfrmBulkPaySuppliers.DoClosingDateREfresh(Const AfterPayCreated:boolean = False);
var
  TransactionTableObj: TTransactionTableObj;
  s:String;
begin
  s:= 'Batch Transaction Last Updated on ' + FormatDateTime(FormatSettings.ShortDateformat +'," at " hh:mm AM/PM', AppEnv.CompanyPrefs.TransactionTableLastUpdated)+',' +
      ' and running a "Batch Update" may take several minutes.'+NL +NL;
  if AfterPayCreated then s:= s +'Do you wish to update list now or wait for next "Batch Update" to refresh the list?'
                     else s:= s +'Do you wish to update list now?';
  if MessageDlgXP_Vista(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
  TransactionTableObj := TTransactionTableObj.Create(False);
  try
    TransactionTableObj.CleanRefreshTrnsTable(true, false, true,true);
  finally
    FreeandNil(TransactionTableObj);
  end;
end;

end;
procedure TfrmBulkPaySuppliers.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;

begin
  DisableForm;
  try
    try
        inherited;
        doclosingDateRefresh;
        dtFrom.DateTime  := Date() - AppEnv.Employee.ListDaysPast;
        dtFrom.OnChange  := dtFromChange;
        dtTo.OnChange    := dtToChange;
        dtFrom.OnCloseUp := dtFromChange;
        dtTo.OnCloseUp   := dtToChange;
        dtTo.DateTime    := Date() + AppEnv.Employee.ListDaysFuture;
        PaymentDate.Date := Date();

        Setlength(QueryNamesNotToOpen, 1);
        QueryNamesNotToOpen[0] := 'qryMain';
        OpenQueries(QueryNamesNotToOpen);

        btnAddFilter.Enabled := true;
        AddToFilter1.Enabled := true;

        chkAddToEFT.Checked := AppEnv.PayPrefs.AddToEFT;
        InitialiseEditor;
        BuildSearchColumnCombo;
        cboFilter.ItemIndex := 0;
        FormshowDone := true;
    except
        // Handle these known exceptions.
        on EAbort do HandleEAbortException;
        on e: ENoAccess do begin
                HandleNoAccessException(e);
                Exit;
            end;
        else raise;
    end;
  finally
    EnableForm;
  end;  
end;
procedure TfrmBulkPaySuppliers.CalcBalance;
begin
    dSelected := dSelected + Qrymain.FieldByName('AmountToPay').AsCurrency;
end;
procedure TfrmBulkPaySuppliers.DoCalculateRunningBalance;
begin
    dSelected :=0;
    IterateQrymain(CalcBalance, 'Pay =''T'' ' , 'Calculating Balance');

    if cboBasis.Text <> 'Manual' then begin
        edtAmtTendered.Text := FloatToStrF(dSelected, ffCurrency, 15, CurrencyRoundPlaces);
        AmountTendered := dSelected;
    end;

    dBalance       := AmountTendered - dSelected;
    RunningBalance := dBalance;

    edtBalance.Text        := FloatToStrF(dSelected, ffCurrency, 15, CurrencyRoundPlaces);
    edtRunningBalance.Text := FloatToStrF(RunningBalance, ffCurrency, 15, CurrencyRoundPlaces);
    SelectedBalance        := dSelected;

end;

procedure TfrmBulkPaySuppliers.edtAmtTenderedKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if ((Key <> '.') and (Key <> #8) and (Key <> '-') and ((Key < '0') or (Key > '9'))) then begin
    Key := #0;
  end;
end;

procedure TfrmBulkPaySuppliers.edtAmtTenderedExit(Sender: TObject);
var
  dX: double;
  edtBox: TEdit;
  sTemp: string;
begin
  edtBox := TEdit(Sender);
  sTemp := StringReplace(EdtBox.Text, AppEnv.RegionalOptions.CurrencySymbol, '', [rfReplaceAll,rfIgnoreCase]);
  sTemp := StringReplace(sTemp, ',', '', [rfReplaceAll,rfIgnoreCase]);

  if sTemp = '' then sTemp := '0'; // AL 14.10.05

  inherited;

  try
    dX := StrToFloat(sTemp);
  except
    edtBox.Text    := AppEnv.RegionalOptions.CurrencySymbol+'0.00';
    AmountTendered := 0;
    Exit;
  end;

  edtBox.Text := FloatToStrF(dX, ffCurrency, 15, CurrencyRoundPlaces);
  if edtBox.Name = 'edtAmtTendered' then begin
    AmountTendered := dX;
      CalculateRunningBalance;
  end;
end;

procedure TfrmBulkPaySuppliers.bbCancelClick(Sender: TObject);
begin
  inherited;
  if Self.FormState = [fsModal] then begin
    Self.ModalResult := mrCancel;
  end else begin
    Close;
  end;
end;

procedure TfrmBulkPaySuppliers.btnSelectAllClick(Sender: TObject);
begin
  fbShowamtMsg:= false;
  try
    IterateQrymain(SelectAll , '' , 'Selecting All');
  finally
      if fbShowamtMsg then
        MessageDlgXP_Vista('Batch Update is not up to date and the ''Amount To Pay'''' shown here are not accurate. Please run "Batch Update" for the accurate amount. This will Remove any selections and reload the whole screen.', mtWarning, [mbOK], 0);
      CalculateRunningBalance;
  end;
end;

procedure TfrmBulkPaySuppliers.btnClearClick(Sender: TObject);
begin
    try
      IterateQrymain(DeSelectall , '', 'De-Selecting All');
    finally
      CalculateRunningBalance;
    end;
end;

procedure TfrmBulkPaySuppliers.actPayUpdate(Sender: TObject);
begin
  inherited;
  if (AmountTendered <= 0) or (SelectedBalance <> AmountTendered) or
    (cboPaymentMethod.Text = '') then begin
    bbOk.Enabled := false;
  end else begin
    bbOk.Enabled := true;
  end;
end;
procedure TfrmBulkPaySuppliers.PerformSuggestion;
var
 strFilter :String;
begin
  try
    inherited;
    if Sysutils.SameText(cboBasis.Text , 'Manual') then Exit;
    try
      IterateQrymain(DeSelectall , '' , 'De-Selecting All');
    finally
      CalculateRunningBalance;
    end;

    if Sysutils.SameText(cboBasis.Text , 'All Overdue') then begin
        if IgnoreDates.Checked then begin
            strFilter := 'DueDate <= ' + Quotedstr(FormatDatetime( MysqlDateFormat , Date));
        end else begin
            strFilter := 'DueDate <= ' + Quotedstr(FormatDatetime( MysqlDateFormat , dtTo.Date));
        end;
    end else if Sysutils.SameText(cboBasis.Text , 'Over 120 Days') then begin
        strFilter := '[120Days] <> 0';
    end else if Sysutils.SameText(cboBasis.Text , 'Over 90 Days') then begin
        strFilter := '[90Days] <> 0 or [120Days] <> 0';
    end else if Sysutils.SameText(cboBasis.Text , 'Over 60 Days') then begin
        strFilter := '[60Days] <> 0 or [90Days] <> 0 or [120Days] <> 0';
    end else if Sysutils.SameText(cboBasis.Text , 'Over 30 Days') then begin
        strFilter := '[30Days] <> 0 or [60Days] <> 0 or [90Days] <> 0 or [120Days] <> 0';
    end else if Sysutils.SameText(cboBasis.Text , 'Less than 30 Days' ) then begin
        strFilter := '[Current] <> 0';
    end;
    try
      IterateQrymain(Selectall, strFilter , 'Selecting All');
      if fbShowamtMsg then
        MessageDlgXP_Vista('Batch Update is not up to date and the ''Amount To Pay'''' shown here are not accurate. Please run "Batch Update" for the accurate amount. This will Remove any selections and reload the whole screen.', mtWarning, [mbOK], 0);
    finally
      fbShowamtMsg:= False;
    end;
    CalculateRunningBalance;
  except
    on e: exception do begin
      ShowMessage('Exception: ' + e.Message);

    end;

  end;
end;

procedure TfrmBulkPaySuppliers.DoGetAPBalances;
var
  AP_Report_Obj: TAP_Report_Obj;
  strSQL :STring;
  qrySource, qryDest: TERPQuery;
begin
  if fbGettingAPBalances then Exit;
  fbGettingAPBalances := true;
  AP_Report_Obj := TAP_Report_Obj.Create(False);
  try
    if IgnoreDates.Checked then begin
      if not cboClass.Enabled then begin
        AP_Report_Obj.CleanRefresh_AP_Table(True,Now(), 0, true,-1,false,fsTablename);
      end else begin
        cboClassQry.Locate('ClassName', cboClass.Text, [loCaseInsensitive]);
        AP_Report_Obj.CleanRefresh_AP_Table(True,Now(), cboClassQry.FieldByName('ClassID').AsInteger, false,-1,false,fsTablename);
      end;
    end else begin
      if not cboClass.Enabled then begin
        AP_Report_Obj.CleanRefresh_AP_Table(False, dtTo.DateTime, 0, true,-1,false,fsTablename);
      end else begin
        cboClassQry.Locate('ClassName', cboClass.Text, [loCaseInsensitive]);
        AP_Report_Obj.CleanRefresh_AP_Table(False ,dtTo.DateTime, cboClassQry.FieldByName('ClassID').AsInteger, false,-1,false,fsTablename);
      end;
    end;


    { The following is to avoid lock wait timeouts if another user is editing
      a purchase order. NOTE: MySQL 5.1 probably resolves these issues so we
      could revert to the update/select sql above. }
    strSQL :=
        ' select TAP.Id, TAP.Type, ' +
        ' if(ifnull(PO.ForeignExchangeCode,"") = "",'+quotedstr(uppercase(Appenv.RegionalOptions.ForeignExDefault))+',  PO.ForeignExchangeCode ) as ForeignExchangeCode, ' +
        ' if(ifnull(PO.ForeignExchangeRate,0) = 0 , 1, PO.ForeignExchangeRate) as ForeignExchangeRate ' +
        ' from ' +fstablename + ' as TAP ' +
        ' Inner Join tblpurchaseorders AS PO ON TAP.PurchaseOrderID = PO.PurchaseOrderID ' +
        ' where (TAP.type = "PO" OR TAP.type = "Bill" OR TAP.type = "Credit") ' +
        ' having ForeignExchangeCode <>'+quotedstr(uppercase(Appenv.RegionalOptions.ForeignExDefault))+' '+
        ' union all ' +
        ' select TAP.Id, TAP.Type, ' +
        ' if(ifnull(PP.ForeignExchangeCode,"") = "",'+quotedstr(uppercase(Appenv.RegionalOptions.ForeignExDefault))+',  PP.ForeignExchangeCode ) as ForeignExchangeCode, ' +
        ' if(ifnull(PP.ForeignExchangeRate,0) = 0 , 1, PP.ForeignExchangeRate) as ForeignExchangeRate ' +
        ' from ' +fstablename + ' as TAP ' +
        ' Inner Join tblPrepayments AS PP ON TAP.PurchaseOrderID = PP.PrePaymentId '+
        ' where  TAP.type = "Supplier Prepayment"'+
        ' having ForeignExchangeCode <>'+quotedstr(uppercase(Appenv.RegionalOptions.ForeignExDefault));

     qrySource:= DbSharedObjectsObj.DbSharedObj.GetQuery(Myconnection);
     qryDest:= DbSharedObjectsObj.DbSharedObj.GetQuery(Myconnection);
     try
       qrySource.SQL.Text:= strSQL;
       qrySource.Open;
       if qrySource.recordcount >0 then begin
           qryDest.SQL.Text:= 'select * from ' + fstablename+
                               ' WHERE IFNULL(ForeignExchangeCode,""'(*+quotedstr(uppercase(Appenv.RegionalOptions.ForeignExDefault))*)+')<> '+quotedstr(uppercase(Appenv.RegionalOptions.ForeignExDefault));
           qryDest.Open;
           if qryDest.recordcount >0 then begin
               ShowProgressbar('Checking for Foreign Currency' ,qryDest.recordcount);
               try
                 while not qryDest.Eof do begin
                  StepProgressbar(inttostr(qryDest.recno)+' of ' + inttostr(qryDest.recordcount));
                   if qrySource.Locate('ID',qryDest.FieldByName('ID').asString,[]) then begin
                     qryDest.Edit;
                     qryDest.FieldByName('ForeignExchangeCode').AsString := qrySource.FieldByName('ForeignExchangeCode').AsString;
                     qryDest.FieldByName('ForeignExchangeRate').AsFloat :=  qrySource.FieldByName('ForeignExchangeRate').AsFloat;
                     qryDest.Post;
                   end else if trim(qryDest.FieldByName('ForeignExchangeCode').AsString)='' then begin
                     qryDest.Edit;
                     qryDest.FieldByName('ForeignExchangeCode').AsString := Appenv.RegionalOptions.ForeignExDefault;
                     qryDest.FieldByName('ForeignExchangeRate').AsFloat :=  1;
                     qryDest.Post;
                   end else if qryDest.FieldByName('ForeignExchangeRate').AsFloat = 0 then begin
                     qryDest.Edit;
                     qryDest.FieldByName('ForeignExchangeRate').AsFloat :=  1;
                     qryDest.Post;
                   end;
                   qryDest.Next;
                 end;
               finally
                HideProgressbar;
               end;
           end;
       end;
     finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qrySource);
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryDest);
     end;
  finally
    // Release our used objects.
    if Assigned(AP_Report_Obj) then
      FreeAndNil(AP_Report_Obj);
    fbGettingAPBalances := false;
  end;
end;

procedure TfrmBulkPaySuppliers.IgnoreDatesClick(Sender: TObject);
begin
  inherited;
  if IgnoreDates.Checked then begin
    lblFrom.Enabled := false;
    lblTo.Enabled   := false;
    dtFrom.Enabled  := false;
    dtTo.Enabled    := false;
  end else begin
    lblFrom.Enabled := true;
    lblTo.Enabled   := true;
    dtFrom.Enabled  := true;
    dtTo.Enabled    := true;
  end;

  InitialiseEditor;
end;

procedure TfrmBulkPaySuppliers.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;

  if Empty(cboClass.Text) then begin
    cboClass.Text := cboClassQry.FieldByName('ClassName').AsString;
  end;

  InitialiseEditor;
end;

procedure TfrmBulkPaySuppliers.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  InitialiseEditor;
end;

procedure TfrmBulkPaySuppliers.InitialiseEditor;
var
  cmd: TErpCommand;
  tmpName: string;
begin
  try
    cmd := TErpCommand.Create(nil);
    try
      cmd.Connection:= qryMain.Connection;
      tmpName := 'tmp_BPS_Sel' + GetTemporaryTableNameSuffix;
      cmd.SQL.Add('drop table if exists ' + tmpName);
      cmd.Execute;

      cmd.SQL.Clear;
      cmd.SQL.Add('create table ' + tmpName);
      cmd.SQL.Add('select * from ' + fsTablename + ' where Pay = "T"');
      cmd.Execute;

      DoGetAPBalances;

      qryMain.Close;
      qryMain.SQL.Clear;
      qryMain.SQL.Add('SELECT tp.*,');
      qryMain.SQL.Add('if(IsNull(tblpurchaseorders.purchaseorderID),"T",tblpurchaseorders.approved) as Approved,');
      qryMain.SQL.Add('if(IsNull(tblpurchaseorders.purchaseorderID), - tblprepayments.PayAmount, tblpurchaseorders.TotalAmountInc) as TransAmount,');
      qryMain.SQL.Add('if(IsNull(tblpurchaseorders.purchaseorderID), - tblprepayments.Payment, tblpurchaseorders.Payment) as TransPayment,');
      qryMain.SQL.Add('if(IsNull(tblpurchaseorders.purchaseorderID), - tblprepayments.Balance, tblpurchaseorders.Balance) as TransBalance');
(*      qryMain.SQL.Add(
        'if(IsNull(tblpurchaseorders.purchaseorderID), - tblprepayments.PayAmount, tblpurchaseorders.TotalAmountInc) - ' +
        'if(IsNull(tblpurchaseorders.purchaseorderID), - tblprepayments.Payment, tblpurchaseorders.Payment) as TransBalance');*)
      qryMain.SQL.Add('FROM `'+fsTablename+'` AS tp ');
      qryMain.SQL.Add('left JOIN tblpurchaseorders ON tp.PurchaseOrderId = tblpurchaseorders.purchaseorderID and tp.Type <> "Supplier Prepayment"');
      qryMain.SQL.Add('left join tblprepayments on tp.PurchaseOrderId = tblprepayments.PrePaymentID and tp.Type = "Supplier Prepayment"');
      if (cboPaymentMethod.Text<>'')  AND (chkAllPayments.checked=false) then
        qryMain.SQL.Add('inner join tblClients tc on tc.ClientId=tp.clientid');
      qryMain.SQL.Add('WHERE tp.AmountDue <> 0');
      if (cboPaymentMethod.Text<>'')  AND (chkAllPayments.checked=false) then begin
        qryMain.SQL.Add('and tc.PayMethodID = '+cboPaymentMethod.LookupValue);
      end;

      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + fsTablename + ', ' +  tmpName);
      cmd.SQL.Add('set ' + fsTablename + '.Pay = "T",');
      cmd.SQL.Add(fsTablename + '.AmountToPay = ' + tmpName + '.AmountToPay,');
      cmd.SQL.Add(fsTablename + '.BalanceLeft = ' + tmpName + '.BalanceLeft');
      cmd.SQL.Add('where ' + fsTablename + '.PONUMBER = ' + tmpName + '.PONUMBER');
      cmd.SQL.Add('and ' + fsTablename + '.INVOICENUMBER = ' + tmpName + '.INVOICENUMBER');
      cmd.SQL.Add('and ' + fsTablename + '.PURCHASEORDERID = ' + tmpName + '.PURCHASEORDERID');
      cmd.SQL.Add('and ' + fsTablename + '.CLIENTID = ' + tmpName + '.CLIENTID');
      cmd.SQL.Add('and ' + fsTablename + '.TRANSID = ' + tmpName + '.TRANSID');
      cmd.Execute;

      cmd.SQL.Clear;
      cmd.SQL.Add('drop table if exists ' + tmpName);
      cmd.Execute;

      qryMain.Open;
      CalculateRunningBalance;
    finally
      cmd.Free;
    end;
  finally
    PrevDateTo := dtFrom.DateTime;
    PrevDateFrom := dtFrom.DateTime;
  end;
end;

procedure TfrmBulkPaySuppliers.edtAmtTenderedDblClick(Sender: TObject);
begin
  inherited;
  edtAmtTendered.text := edtBalance.text;
end;

procedure TfrmBulkPaySuppliers.edtAmtTenderedEnter(Sender: TObject);
begin
  inherited;
  if AmountTendered <> 0 then begin
    edtAmtTendered.Text := FloatToStr(AmountTendered);
    edtAmtTendered.SelectAll;
  end else begin
    edtAmtTendered.Text := '';
  end;
end;

procedure TfrmBulkPaySuppliers.PrintScreenReport(SelectedOnly: boolean = false;DoEmail :Boolean =False; SQLWhere :String = ''; ClientName :String =''; ClientEmail :String = '';
     const aSilent : boolean = false; const aSecret : boolean = false);
var
  sSQL: string;
begin
  inherited;
  fbTemplateUsesNonFormConnection := false;
  sSQL := '';
  fbReportSQLSupplied := true;

  sSQL := sSQL + '{CoyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ", ';
  sSQL := sSQL + 'CO.PhoneNumber) AS PhoneNumber, Concat("Fax ", CO.FaxNumber) AS FaxNumber, CO.ABN ';
  sSQL := sSQL + 'FROM tblCompanyInformation AS CO ';
  sSQL := sSQL + '~|||~{AccountsPayable}';
  sSQL := sSQL + 'SELECT tp.* FROM `'+fsTablename+'` AS tp ';
  if (cboPaymentMethod.Text<>'') AND (chkAllPayments.checked=false) then begin
    sSQL := sSQL + 'INNER JOIN tblClients AS tc ON tc.ClientID=tp.ClientID ';
  end;
  if SelectedOnly then begin
      sSQL := sSQL + 'WHERE PAY = "T" ';
  end else begin
    if sFilter = '' then begin
      sSQL := sSQL + 'WHERE AmountDue <> 0 ';
    end else begin
      sSQL := sSQL + 'WHERE AmountDue <> 0 AND ' + sFilter;
    end;
    if (cboPaymentMethod.Text<>'') AND (chkAllPayments.checked=false)  then begin
      sSQL := sSQL + 'AND  tc.PayMethodID='+cboPaymentMethod.LookupValue;
    end;
  end;

  if SQLWhere <> '' then sSQL := sSQL + ' and ' +SQLWhere;

  sSQL := sSQL + ' ORDER BY SupplierName;';
  if DoEmail then begin
      EmailReport(KeyID, ClientName ,ClientEmail , 'Bulk Pay Suppliers' , 'Bulk Pay Suppliers' , sSQL , True , False, true, ASilent, aSecret);
  end else begin
    PrintTemplateReport('Bulk Pay Suppliers', sSQL, not AppEnv.Employee.ShowPreview, 1);
  end;
  fbReportSQLSupplied := false;
end;

procedure TfrmBulkPaySuppliers.cboBasisCloseUp(Sender: TObject);
begin
  inherited;
  PerformSuggestion;
end;

procedure TfrmBulkPaySuppliers.btnPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PrintScreenReport;
  finally
    EnableForm;
  end;  
end;

procedure TfrmBulkPaySuppliers.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'SupplierName ASC CIS';
end;

procedure TfrmBulkPaySuppliers.BuildSearchColumnCombo;
var
  iX: integer;
begin
    cboFilter.Items.Clear;
    for iX := 0 to grdmain.FieldCount - 1 do begin
        if (Sysutils.SameText(grdmain.Columns[iX].FieldName , 'AmountDue')) OR
           (Sysutils.SameText(grdmain.Columns[iX].FieldName , 'Current')) OR
           (Sysutils.SameText(grdmain.Columns[iX].FieldName , 'Pay')) OR
           (Sysutils.SameText(grdmain.Columns[iX].FieldName , '30Days')) OR
           (Sysutils.SameText(grdmain.Columns[iX].FieldName , '60Days')) OR
           (Sysutils.SameText(grdmain.Columns[iX].FieldName , '90Days')) OR
           (Sysutils.SameText(grdmain.Columns[iX].FieldName , '120Days')) then
        else cboFilter.Items.Add(grdmain.Columns[iX].FieldName);
    end;
    Try
        cboFilter.ItemIndex := 0;
    except
    end;
end;

procedure TfrmBulkPaySuppliers.edtSearchChange(Sender: TObject);
var
  sFieldName:String;
  tmpIndex: string;
begin
  if (edtSearch.Text <> '') and (cboFilter.Text <> '') then begin
    sFieldName := cboFilter.Text; //  TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).fieldname;
    if dsMain.DataSet.FindField(sFieldName) <> nil then begin
      try
        if not empty(BaseIndexFieldNames) and (QuotedStr(sFieldName) + ' ASC CIS' <> BaseIndexFieldNames) then begin
          tmpIndex := QuotedStr(sFieldName) + ' ASC CIS; ' + BaseIndexFieldNames;
        end
        else begin
          tmpIndex := QuotedStr(sFieldName) + ' ASC CIS;';
        end;
        try
          qryMain.IndexFieldNames := '';
          //Application.ProcessMessages;
          qryMain.IndexFieldNames := tmpIndex;
        except
        end;
        dsMain.DataSet.Locate(sFieldName, ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', ''), [loCaseInsensitive, loPartialKey]);
      except
      end;
    end;
  end;

end;

procedure TfrmBulkPaySuppliers.EmailTemplateReport;
var
  POIds:String;
  qry : TERPQuery;
  lCount : integer;
  lSecret, lSilent : boolean;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);;
  try
    qry.SQL.Add('Select Distinct PurchaseOrderID from ' +fstablename +' where Pay ="T"');
    qry.open;
    POIds := qry.groupconcat('PurchaseOrderID');
    if POIds = '' then
      exit;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('Select Distinct C.ClientID, C.company, C.Email from ' +fstablename +' T  inner join tblClients C on C.clientId = T.ClientID where T.purchaseOrderID in (' + POIDS +')');
    qry.open;
    if qry.recordcount =0 then
      exit;

    lCount := CheckEmailAddresses(qry, 'Supplier', 'Company', 'Email');
    if lCount = 0 then
      exit;
    if not EmailSilentSecret(lCount, false, lSilent, lSecret) then
      exit;
    qry.First;
    While not qry.eof do
    begin
      PrintScreenReport(True , True, 'PurchaseOrderID in (' + POIds+') and ClientID = ' + qry.Fieldbyname('clientId').asString, qry.Fieldbyname('Company').AsString , qry.FieldByname('Email').AsString, lSilent, lSecret);
      qry.Next;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TfrmBulkPaySuppliers.btnAddFilterClick(Sender: TObject);
begin
  inherited;
  sFilter := cboFilter.Text + ' = ' + QuotedStr(grdmain.GetActiveField.AsString);
  btnExecute.Enabled := true;
  btnClearFilter.Enabled := true;
  ClearFilter1.Enabled := true;
  ExecuteFilter1.Enabled := true;
end;

procedure TfrmBulkPaySuppliers.btnExecuteClick(Sender: TObject);
begin
    if Empty(edtSearch.Text) then begin
        qrymain.Filtered    := false;
        if not Empty(sFilter) then begin
            qrymain.Filter  := sFilter;
            qrymain.Filtered:= true;
        end;
    end else begin
        qrymain.Filtered    := false;
        Try
            qrymain.Filter  := sFilter + ' OR ' + cboFilter.Text + ' = ' + QuotedStr(edtSearch.Text + '*');
            qrymain.Filtered:= true;
        except
        end;
    end;
    if Qrymain.Filtered then
      ShowFilter(filtercaption + qrymain.Filter)
    else
      ShowFilter(filtercaption);
    btnExecute.Enabled      := false;
    ExecuteFilter1.Enabled  := false;
end;

procedure TfrmBulkPaySuppliers.btnClearFilterClick(Sender: TObject);
begin
    sFilter := '';
    if not Empty(edtSearch.Text) then begin
        Qrymain.Filtered := false;
        try
            Qrymain.Filter   := cboFilter.Text + ' = ' + QuotedStr(edtSearch.Text + '*');
            Qrymain.Filtered := true;
        except
        end;
    end else begin
        Qrymain.Filtered := false;
    end;

    btnExecute.Enabled := false;
    btnClearFilter.Enabled := false;
    ExecuteFilter1.Enabled := false;
    ClearFilter1.Enabled := false;
    if Qrymain.Filtered then
      ShowFilter(Qrymain.Filter)
    else
      ShowFilter(filtercaption);
end;

procedure TfrmBulkPaySuppliers.dtToChange(Sender: TObject);
begin
  inherited;
(*  if not FormshowDone then Exit;
  if not dtTo.DroppedDown then begin
    if not (dtTo.DateTime = PrevDateTo) then begin
      InitialiseEditor;
    end;
    PrevDateTo := dtFrom.DateTime;
  end;*)
end;

procedure TfrmBulkPaySuppliers.dtToExit(Sender: TObject);
begin
  inherited;
  if not FormshowDone then Exit;
  if not (dtTo.DateTime = PrevDateTo) then begin
    InitialiseEditor;
  end;
end;

procedure TfrmBulkPaySuppliers.dtFromChange(Sender: TObject);
begin
  inherited;
(*  if not FormshowDone then Exit;
  if not dtFrom.DroppedDown then begin
    if not (dtFrom.DateTime = PrevDateFrom) then begin
      InitialiseEditor;
    end;
    PrevDateFrom := dtFrom.DateTime;
  end;*)
end;

procedure TfrmBulkPaySuppliers.dtFromExit(Sender: TObject);
begin
  inherited;
  if not FormshowDone then Exit;
  if not (dtFrom.DateTime = PrevDateFrom) then begin
    InitialiseEditor;
  end;
end;

procedure TfrmBulkPaySuppliers.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
    if not Modified then Exit;
    inherited;
    if (edtBankBalance.DataField = '') and (cboAccount.Text <> '') then
        edtBankBalance.DataField := 'Balance';
end;

procedure TfrmBulkPaySuppliers.cboPaymentMethodCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  //InitialiseEditor;
end;

procedure TfrmBulkPaySuppliers.chkAllPaymentsClick(Sender: TObject);
begin
  inherited;
  if chkAllPayments.Checked = true then begin
    cboPaymentMethod.Enabled := false;
    btnClearFilterClick(Sender);
  end else begin
    cboPaymentMethod.enabled := true;
  end;
  if cboPaymentMethod.Text<>'' then InitialiseEditor;
end;


procedure TfrmBulkPaySuppliers.PaymentDateChange(Sender: TObject);
begin
  inherited;
//  IterateQrymain(DeSelectall);
end;

procedure TfrmBulkPaySuppliers.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TfrmBulkPaySuppliers.actPayExecute(Sender: TObject);
var
    SuppPay :TsuppPayments;
    frmPO: TfrmPrintOptionsGUI;
    strSQL:String;
    IDs:String;
    GLAccount :TAccount;
    PaySupplier  :TSupplier;
    BankAccID:Integer;
    Payclass:String;
begin
    inherited;
    Qrymain.DisableControls;
    If cboAccount.Text <> '' then
      BankAccID := cboAccount.LookupTable.FieldByName(cboAccount.LookupField).AsInteger
    else
      BankAccID := 0;

    GLAccount := TAccount.Create(nil) ;
    PaySupplier := TSupplier.Create(nil);
    try
        Qrymain.filter := 'Pay = ''T'' ';
        Qrymain.filtered := True;
        if Qrymain.recordcount = 0 then exit;

        If chkAddToEFT.Checked then begin
          If cboAccount.Text <> '' then Begin
            GLAccount.load(cboAccount.LookupTable.FieldByName(cboAccount.LookupField).AsInteger);
            if not GLAccount.ValidEFTAccount then begin
              CommonLib.MessageDlgXP_Vista('This Bank Account ['+GLAccount.AccountName+'] does not have all the Required Bank Account' + chr(13) +
                                           'Details to use Electronic Funds Transfer !', mtWarning, [mbOK], 0);
              Exit;
            end;
          end;

          Qrymain.First;
          While not Qrymain.Eof do Begin
            PaySupplier.load(qryMainClientID.asInteger);
            if not PaySupplier.ValidEFTSupplier then begin
              CommonLib.MessageDlgXP_Vista('This Supplier ['+PaySupplier.clientName+'] does not have all the Required Bank Account' + chr(13) +
                                           'Details to use Electronic Funds Transfer !', mtWarning, [mbOK], 0);
              Exit;
            end;
            Qrymain.Next;
          end;
        end;

        try
            chequeno:= GetNextSequenceNumber(SEQ_LAST_CHEQUENO);
            frmPO         := TfrmPrintOptionsGUI(GetComponentByClassName('TfrmPrintOptionsGUI'));
            if Assigned(frmPO) then begin //if has acess
                frmPO.ViaBulkCustomerPayments := False;
                oPrintOptions.startingchequeNo :=chequeno;
                frmPO.Results := @oPrintOptions;
                frmPO.ShowModal;
                if oPrintOptions.cheques  then chequeno:=oPrintOptions.startingchequeNo else chequeno:='';
                if oPrintOptions.Screen then begin
                    PrintScreenReport(true);
                end;

            end;
        finally
         //   FreeandNil(frmPO);
        end;

        SuppPay := TsuppPayments.create(self);
        try
            Supppay.AddToEFT := chkAddToEFT.checked;
            Supppay.connection := TMydacDataconnection.create(SuppPay);
            Supppay.connection.connection := MyConnection;
            strSQL := 'select ClientID, AmountToPay as Amount ,' +  IntToStr(Appenv.DefaultClass.ClassID)+
                        ' as ClassId , Type, PurchaseOrderId as TransID from ' + fsTablename +
                ' where pay = "T" ' +
                ' order by clientID';
            if chkAllClass.checked then
              Payclass := appenv.DefaultClass.DefaultClassName
            else
              Payclass := cboClass.text;

            if SuppPay.DoBulkPay(strSQL, cboPaymentMethod.Text,Payclass, PaymentDate.date,BankAccID , chequeno) then begin
                SuppPay.UserLock.UnlockAllCurrentInstance;
                IDs := SuppPay.BulkPaymentIDs;
                if IDs = '' then exit;

                OpensupPayment(Ids);
                Ids := 'PaymentId = ' + IDs;
                IDs := StringReplace(Ids , ',' , ' Or PaymentId = ', [rfReplaceAll,rfIgnoreCase] );
                SuppPay.LoadSelect(Ids);
                if SuppPay.count = 0 then
                  exit;

                Reportname:= GetDefaultTemplate(GetReportTypeID); if Reportname = '' then Reportname:= SuppPay.TransType; //'Supplier Payment';
                if oPrintOptions.Email    then SuppPay.IterateRecords(EmailTemplateReport);
                if oPrintOptions.Receipts then SuppPay.IterateRecords(PrintReceipts);
                if oPrintOptions.Cheques  then SuppPay.IterateRecords(Printcheques);
                if oPrintOptions.Screen   then SuppPay.IterateRecords(PrintReceipts);

                DoClosingDateREfresh(True);
                Self.Close;
            end;
        Finally
            FreeAndNil(SuppPay);
        end;
    finally
      GLAccount.Free;
      PaySupplier.Free;
      Qrymain.filtered := False;
      Qrymain.EnableControls;
    end;
end;
Procedure TfrmBulkPaySuppliers.EmailTemplateReport(Const Sender: TBusObj; var Abort: Boolean);
var
  sSQL: string;
begin
    sSQL := ' WHERE W.PaymentID = ' + IntToStr(TSuppPayments(Sender).ID);
    EmailReport(TSuppPayments(Sender).ID , TSuppPayments(Sender).Client.ClientName , TSuppPayments(Sender).Client.Email , reportname , reportname , sSql, False, True);
end;
Procedure TfrmBulkPaySuppliers.PrintReceipts(Const Sender: TBusObj; var Abort: Boolean);
var
  sSQL: string;
begin
    sSQL := ' WHERE W.PaymentID = ' + IntToStr(TSuppPayments(Sender).ID);
    PrintTemplateReport(Reportname, sSQL, not AppEnv.Employee.ShowPreview, 1)
end;
Procedure TfrmbulkPaySuppliers.OpensupPayment(const IDS:string);
var
  st:TstringList;
  ctr:Integer;
begin
  st:= TStringlist.Create;
  try
    st.CommaText:=Ids;
    if st.Count =0 then exit;
    if MessageDlgXP_Vista(inttostr(st.count) +' Supplier Payment records are Created. Do you wish to see these Payment Record(s)', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      for ctr:= 0 to st.Count - 1 do begin
        OpenERPFormModal('TfmSuppPayments' , strtoint(st[ctr]), nil);
        if ctr < st.Count-1 then
          if MessageDlgXP_Vista(inttostr(st.count-1-ctr) +' More supplier payment record(s) . Do you wish to continue?', mtConfirmation, [mbYes, mbCancel], 0) = mrCancel then break;
      end;
  finally
    FreeAndnil(St);
  end;
end;
Procedure TfrmBulkPaySuppliers.Printcheques(Const Sender: TBusObj; var Abort: Boolean);
var
  sSQL: string;
  sMoney: string;
begin
    with TSuppPayments(Sender) do begin
        sMoney := CurrToStrF(Amount, ffCurrency, 2);
        sMoney := FastFuncs.RightStr(sMoney, char_length(sMoney) - 1);
        sMoney := '**' + sMoney;
        (*sSQL := '{CompanyInfo}Select * , Concat(Address," ",Address2," ",City," ",tblCompanyInformation.State," ",tblCompanyInformation.Postcode) AS CompanyAddress from tblCompanyInformation   ' +
                '~|||~{TransDet} Select ' + QuotedStr(MoneyWords(Amount)) +' as AmountInWords, ' +
                quotedStr(sMoney) + ' as DisplayAmount, ' +
                'CI.CompanyName, ' +
                'Concat(Address," ",Address2," ",City," ",CI.State," ",CI.Postcode) AS CompanyAddress, ' +
                'Concat("Phone? ",PhoneNumber," Fax? ",CI.FaxNumber) AS PhoneFax, ' +
                'Concat("ABN? ",CI.ABN) AS ABN, ' +
                'W.PaymentID,W.SupplierID,Amount, ' +
                'W.PayMethodID,ReferenceNo, ' +
                'PaymentDate,  OpeningBalance,ClosingBalance,W.ClassID, ' +
                'W.AccountID, ' + 'Applied,UnApplied,W.Notes,   ' +
                'TrnType,WL.OrderDate,PONo,OriginalAmount, ' +
                'WL.AmountDue, AmountOutstanding,   ' +
                'WL.AmountDue-WL.AmountOutstanding AS AmountPaid, ' +
                'PaidInFull,  POID, ' + 'Company,AccountName,ClassName,PM.Name AS PayMethod, ' +
                'CONCAT_WS(" ",C.Title,C.FirstName,C.LastName) as ClientContactName,   ' +
                'C.Company as ClientCompany,C.Street as ClientStreet,C.Street2 as ClientStreet2, ' +
                'C.Suburb as ClientSuburb, C.State as ClientState,C.Country as ClientCountry, ' +
                'C.Postcode as ClientPostcode,  C.BillStreet as ClientBillStreet, ' +
                'C.BillStreet2 as ClientBillStreet2,C.BillSuburb as ClientBillSuburb, ' +
                'C.BillState as ClientBillState,C.BillCountry as ClientBillCountry, ' +
                'C.BillPostcode as ClientBillPostcode, ' + 'CONCAT_WS(" ",C.Suburb,C.State,C.Postcode) as ClientLocation, ' +
                'CONCAT_WS(" ",C.BillSuburb,C.BillState,C.BillPostcode) as ClientBillLocation, ' +
                'C.PHONE,C.FAXNumber,C.JobName,InvoiceNumber,W.ForeignExchangeRate, ' +
                'W.ForeignExchangeCode,ForeignCurrencyAmount ' +
                'FROM tblCompanyInformation as CI,tblWithdrawal W ' +
                'LEFT JOIN tblWithdrawalLines WL ON W.PaymentID=WL.PaymentID ' +
                'LEFT JOIN tblClients C ON W.SupplierID=C.ClientID ' +
                'LEFT JOIN tblClass  ON W.ClassID=tblClass.ClassID ' +
                'LEFT JOIN tblChartOfAccounts COA ON W.AccountID=COA.AccountID ' +
                'LEFT JOIN tblPaymentMethods PM  ON W.PayMethodID=PM.PayMethodID ' +
                'LEFT JOIN tblpurchaseorders  ON WL.POID=tblpurchaseorders.PurchaseOrderID ' +
                'WHERE W.PaymentID = ' + IntToStr(ID);*)
        sSQL:= chequeLib.SupplierPaychequeSQL(ID, Amount, ForeigncurrencyAmount);
        fbReportSQLSupplied := true;
        PrintTemplateReport(TemplateToPrint('Supplier Payment Cheque' , chkChooseRpt.checked), sSQL, not AppEnv.Employee.ShowPreview, 1, nil, '' , True);
        fbReportSQLSupplied := false;
        if PrintTemplate.CancelPreviewAll then Abort := True;
    End;
end;
procedure TfrmBulkPaySuppliers.qryMainPayChange(Sender: TField);
var
  option:Word;
begin
  if DoingPayChange then exit;
  DoingPayChange := true;
  try
    inherited;
      if (qryMainPay.asBoolean) then
          if  (DateUtils.CompareDate(PaymentDate.Date,QrymainInvoiceDate.asDateTime)=-1) then Begin
              EditQrymain;
              qryMainPay.asBoolean := False;
              CommonLib.MessageDlgXP_Vista('Payment Cannot Pay Transaction Before It Existed !', mtWarning, [mbOK], 0);
          end else if not (Sysutils.SameText(qryMainForeignExchangecode.asString , appenv.RegionalOptions.ForeignExDefault)) then begin
              EditQrymain;
              qryMainPay.asBoolean := False;
              if fWarningAcked  then
              else begin
                Option := CommonLib.MessageDlgXP_Vista('Payment Cannot Pay Transaction using Foreign currency('+
                                          qryMainForeignExchangecode.asString +')',
                                          mtWarning, [mbOK], 0,nil,'','',False,nil,'OK to All');

                if Option = 100 then fWarningAcked := True
                else fWarningAcked := False;
              end;
          end;



    if qryMainPay.asBoolean then begin
      if qryMain.FieldByName('AmountToPay').AsFloat = 0 then begin
        EditQrymain;
        if qryMain.FieldByName('AmountDue').AsFloat <> qryMainTransBalance.asfloat then
          if fbSelectingAll then fbShowamtMsg := TRue
          else
            MessageDlgXP_Vista('Batch Update is not up to date and the ''amount To Pay'''' shown here are not accurate. Please run "Batch Update" for the accurate amount', mtWarning, [mbOK], 0);
        EditQrymain;
        qryMain.FieldByName('AmountToPay').AsFloat := qryMainTransBalance.AsFloat;
        EditQrymain;
        qryMainPay.asBoolean := qryMain.FieldByName('AmountToPay').AsFloat <> 0;
      end;
    end  else begin
      EditQrymain;
      qryMain.FieldByName('AmountToPay').asFloat := 0;
    end;
      CalculateRunningBalance;
  finally
    DoingPayChange := false;
  end;
end;

procedure TfrmBulkPaySuppliers.grdmainColEnter(Sender: TObject);
var
  iIndex: integer;
  s:String;
begin
  try
    iIndex := -1;
    s:=TwwDBGrid(Sender).GetActiveField.FieldName;
    if s<> '' then
    //iIndex := cboFilter.Items.IndexOf(TwwDBGrid(Sender).datasource.dataset.FieldByName(s).DisplayLabel);
    if s<> '' then iIndex := cboFilter.Items.IndexOf(s);
    if iIndex <> -1 then cboFilter.ItemIndex := iIndex;
  except
  end;
end;

procedure TfrmBulkPaySuppliers.grdmainDblClick(Sender: TObject);
begin
  inherited;
  if SameText(qryMainType.AsString,'Bill') then begin
    OpenERPForm('TBillGUI', qryMainPONumber.AsInteger, nil, nil, false, true, true);
  end
  else if SameText(qryMainType.AsString,'Credit') then begin
    OpenERPForm('TCreditGUI', qryMainPONumber.AsInteger, nil, nil, false, true, true);
  end
  else if SameText(qryMainType.AsString,'PO') then begin
    OpenERPForm('TPurchaseGUI', qryMainPONumber.AsInteger, nil, nil, false, true, true);
  end
  else if SameText(qryMainType.AsString,'Supplier Prepayment') then begin
    OpenERPForm('TfmSuppPrepayments', qryMainPONumber.AsInteger, nil, nil, false, true, true);
  end
  else if SameText(qryMainType.AsString,'Supplier Payment') then begin
    OpenERPForm('TfmSuppPayments', qryMainPONumber.AsInteger, nil, nil, false, true, true);
  end
end;

procedure TfrmBulkPaySuppliers.grdmainCalcTitleImage(Sender: TObject;
  Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if (FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' ASC CIS;', qryMain.IndexFieldNames) > 0) or
    (FastFuncs.PosEx(Field.FieldName + ' ASC CIS;', qryMain.IndexFieldNames) > 0) then begin
    TitleImageAttributes.ImageIndex := 3;
  end else if (FastFuncs.PosEx(QuotedStr(Field.FieldName) + ' DESC CIS;', qryMain.IndexFieldNames) > 0) or
    (FastFuncs.PosEx(Field.FieldName + ' DESC CIS;', qryMain.IndexFieldNames) > 0) then begin
    TitleImageAttributes.ImageIndex := 4;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;

end;

procedure TfrmBulkPaySuppliers.grdmainTitleButtonClick(Sender: TObject;
  AFieldName: String);
var
  tmpIndex: string;
  slColumnSortOrder: TStringList;

  function IsFieldNameInBaseFieldIndexes(Const sFieldIndexPattern: string): boolean;
  var
    iX: integer;
  begin
    Result := false;
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      if FastFuncs.PosEx(sFieldIndexPattern, slColumnSortOrder.Strings[iX]) <> 0 then begin
        Result := true;
        Exit;
      end;
    end;
  end;

  function BuildBaseIndexes: string;
  var
    iX: integer;
  begin
    Result := '';
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      if iX = 0 then Result := slColumnSortOrder.Strings[0]
      else Result := Result + '; ' + slColumnSortOrder.Strings[iX];
    end;
  end;

  procedure ChangeFieldSortOrder(Const sFieldName, sNewOrder: string);
  var
    iX: integer;
    Buffer: array[0..255] of char;
    Field: array[0..255] of char;
  begin
    StrPCopy(Field, sFieldName);
    StrLower(Field);
    for iX := 0 to slColumnSortOrder.Count - 1 do begin
      StrPCopy(Buffer, slColumnSortOrder.Strings[iX]);
      StrLower(Buffer);
      if FastFuncs.PosEx(string(Field), string(Buffer)) <> 0 then begin
        // We do this twice to ensure no matter what it is it will update
        // to the new requested search order.
        slColumnSortOrder.Strings[iX] := StringReplace(slColumnSortOrder.Strings[iX], ' ASC ', sNewOrder, [rfReplaceAll,rfIgnoreCase]);
        slColumnSortOrder.Strings[iX] := StringReplace(slColumnSortOrder.Strings[iX], ' DESC ', sNewOrder, [rfReplaceAll,rfIgnoreCase]);
        Exit;
      end;
    end;
  end;
begin
  Processingcursor(True);
  try
  slColumnSortOrder := TStringList.Create;
  slColumnSortOrder.Clear;
  if fsSortColumnName <> AFieldName then begin
    qryMain.IndexFieldNames := BaseIndexFieldNames;
    fsColumnOrderMode       := 'ASC';
  end;

  if qryMain.IndexFieldNames <> '' then begin
    ExtractStrings([';'], [' '], PChar(qryMain.IndexFieldNames), slColumnSortOrder);
  end;

  try
    if qryMain.FindField(AFieldName) <> nil then begin
      if (qryMain.FieldByName(AFieldName).FieldKind <> fkLookup) and
        (qryMain.FieldByName(AFieldName).FieldKind <> fkCalculated) and
        (qryMain.FieldByName(AFieldName).DataType <> ftMemo) and
        (qryMain.FieldByName(AFieldName).DataType <> ftWideMemo) then begin
        qryMain.DisableControls;

        if (IsFieldNameInBaseFieldIndexes(QuotedStr(AFieldName) + ' ASC CIS')) or
          (IsFieldNameInBaseFieldIndexes(AFieldName + ' ASC CIS')) then begin
          ChangeFieldSortOrder(AFieldName, ' DESC ');
          if (slColumnSortOrder.Count > 0) then begin
            if not (IsFieldNameInBaseFieldIndexes(AFieldName)) then begin
              if not SwapBaseIndex then begin
                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BuildBaseIndexes + ';';
              end else begin
                tmpIndex := BuildBaseIndexes + '; ' + QuotedStr(AFieldName) + ' DESC CIS;';
              end;
            end else begin
              tmpIndex := BuildBaseIndexes + ';';
            end;
          end else begin
            if not Empty(SecondaryIndex) then begin
              tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + SecondaryIndex + ' DESC CIS;';
            end else begin
              tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
            end;
          end;

          fsColumnOrderMode := 'DESC';
          fsSortColumnName := AFieldName;

          try
            qryMain.IndexFieldNames := '';
            qryMain.IndexFieldNames := tmpIndex;
          except
          end;
        end else begin
          if (fsColumnOrderMode = '') or (fsColumnOrderMode = 'ASC') then begin
            if (slColumnSortOrder.Count > 0) then begin
              if not (IsFieldNameInBaseFieldIndexes(AFieldName)) then begin
                if not SwapBaseIndex then begin
                  tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + BuildBaseIndexes + ';';
                end else begin
                  tmpIndex := BuildBaseIndexes + '; ' + QuotedStr(AFieldName) + ' DESC CIS;';
                end;
              end else begin
                ChangeFieldSortOrder(AFieldName, ' DESC ');
                tmpIndex := BuildBaseIndexes + ';';
              end;
            end else begin
              if not Empty(SecondaryIndex) then begin
                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS; ' + SecondaryIndex + ' DESC CIS;';
              end else begin
                tmpIndex := QuotedStr(AFieldName) + ' DESC CIS;';
              end;
            end;
            fsColumnOrderMode := 'DESC';
          end else begin
            if (fsColumnOrderMode = 'DESC') then begin
              if (slColumnSortOrder.Count > 0) then begin
                if not (IsFieldNameInBaseFieldIndexes(AFieldName)) then begin
                  if not SwapBaseIndex then begin
                    tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + BuildBaseIndexes + ';';
                  end else begin
                    tmpIndex := BuildBaseIndexes + '; ' + QuotedStr(AFieldName) + ' ASC CIS;';
                  end;
                end else begin
                  ChangeFieldSortOrder(AFieldName, ' ASC ');
                  tmpIndex := BuildBaseIndexes + ';';
                end;
              end else begin
                if not Empty(SecondaryIndex) then begin
                  tmpIndex := QuotedStr(AFieldName) + ' ASC CIS; ' + SecondaryIndex + ' ASC CIS;';
                end else begin
                  tmpIndex := QuotedStr(AFieldName) + ' ASC CIS;';
                end;
              end;
              fsColumnOrderMode := 'ASC';
            end;
          end;

          fsSortColumnName := AFieldName;

          try
            qryMain.IndexFieldNames := '';
            qryMain.IndexFieldNames := tmpIndex;

          except
          end;
        end;

        qryMain.EnableControls;
      end;
    end;

  finally
    // Release our used objects.
    if Assigned(slColumnSortOrder) then FreeAndNil(slColumnSortOrder);
    // Restore previous screen cursor.
  end;
  finally
    Processingcursor(False);
  end;
end;

procedure TfrmBulkPaySuppliers.qryMainAmountToPayChange(Sender: TField);
begin
  inherited;
  EditQrymain;
  { somthing in following code was causing stack overflow for one user on one machine
    for one client!! }
  try
    if (qryMain.FieldByName('AmountToPay').AsFloat > qryMainTransBalance.asfloat) and (qryMain.FieldByName('AmountToPay').AsFloat<>0) then begin
      if qryMain.FieldByName('AmountDue').AsFloat > qryMainTransBalance.asfloat then
        if fbSelectingAll then fbShowamtMsg := TRue
        else
          MessageDlgXP_Vista('Batch Update is not up to date and the ''Amount To Pay'''' shown here are not accurate. Please run "Batch Update" for the accurate amount. This will Remove any selections and reload the whole screen.', mtWarning, [mbOK], 0);
      EditQrymain;qryMain.FieldByName('AmountToPay').AsFloat := qryMainTransBalance.AsFloat;
      EditQrymain;qryMainPay.asBoolean := qryMain.FieldByName('AmountToPay').AsFloat <> 0;
    end;
  except

  end;
    EditQrymain;
    if QrymainAmountToPay.AsFloat <> 0  then begin
        QrymainBalanceLeft.AsFloat := QrymainAmountDue.AsFloat - QrymainAmountToPay.AsFloat;
    end
    else QrymainBalanceLeft.asFloat := 0;
      CalculateRunningBalance;
end;

procedure TfrmBulkPaySuppliers.grdmainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  sFieldName: string;
  srchField: TField;
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Sysutils.SameText(qryMainForeignExchangecode.asString, appenv.RegionalOptions.ForeignExDefault) then
    AFont.Color := clBlack
  else
    AFont.Color := clGray;

  sFieldName := cboFilter.Text; //  TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).fieldname;
  srchField := dsMain.DataSet.FindField(sFieldName);
  if srchField <> nil then begin
    if (not empty(cboFilter.Text)) and (cboFilter.ItemIndex >= 0) and (not(gdSelected in State) or not TwwDbGrid(Sender).Focused) then begin
      try
        if (FastFuncs.PosEx(uppercase(ReplaceStr(ReplaceStr(edtSearch.Text, '%', ''), '*', '')), uppercase(srchField.asString)) = 1) then begin
          ABrush.Color := HIGHLIGHTLOCATE; // AppEnv.Employee.ListSelectionColour;;
        end;
      except
      end;
    end;
  end;
  if qryMainPay.AsBoolean then begin
    if ABrush.Color <> HIGHLIGHTLOCATE then
      ABrush.Color := $00C4FFE1;

  end;

end;

initialization
  RegisterClassOnce(TfrmBulkPaySuppliers);
end.
