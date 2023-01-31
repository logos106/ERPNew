{ Date    Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/06/05  1.00.01 BJ   --> Custoemr name and job name are separated and displayed as
                        2 differnet columns in the Grid. The client table is linked
                        to the Query to get the jobname as well as the customer name.
                        Company field in the client table stores the name as well as
                        the job name separated with ^, so etracting the customer
                        name from the company by searching for ^ char.
                        --> Invoice no is added into the list.

 06/07/05  1.00.02 DMS  1. Modified form's OnShow event to change assignment of
                           events for From/To date controls. Grid will be updated
                           when user either exits or closes the dropdown.

 12/07/05  1.00.03 DSP  Added 'InitialiseEditor' call to the 'FormShow' method.
 26/07/05  1.00.04 DSP  Moved 'InitialiseEditor' to before the
                        BuildSearchColumnCombo call.
 01/09/05  1.00.05 IJB  Changed edtSearchChange to avoid building filter if
                        cboFilter is blank (eg after user has clicked in check
                        box in the grid)
 12/09/05  1.00.06 BJ   Sorting functionality in the grid is implmented.
                        Only asceninding order is possible as it is using a memtable.
 19/10/05  1.00.07 DLS  Added RegisterClass
}
 
unit frmBulkPayCustomers;

interface

Uses TypesLib,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, ExtCtrls, DNMPanel, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,  Grids, Wwdbigrd, Wwdbgrid,
  StdCtrls, Buttons, DNMSpeedButton, MemDS, wwdblook, ActnList, ActnMan, Mask, DBCtrls,
  wwdbdatetimepicker, wwcheckbox, DataState, PrintDAT, frmBulkPaymentsPrintOptions,
  Menus, AdvMenus, ImgList, kbmMemBinaryStreamFormat, Shader, dmGUIStylers,
  BusObjBase, kbmMemTable, PlatformDefaultStyleActnCtrls, ProgressDialog,frmBulkPayBase;

type
  TfrmBulkReceiveCustomersGUI = class(TfmBulkPayBase)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    lblTo: TLabel;
    lblFrom: TLabel;
    Label5: TLabel;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    IgnoreDates: TCheckBox;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cboPayMethod_Label: TLabel;
    edtAmtTendered: TEdit;
    edtBalance: TEdit;
    edtRunningBalance: TEdit;
    cboBasis: TComboBox;
    cboPaymentMethod: TwwDBLookupCombo;
    DNMPanel4: TDNMPanel;
    ActionManager1: TActionManager;
    actPay: TAction;
    cboClassQry: TERPQuery;
    qryPayMethod: TERPQuery;
    qryMainCustomerName: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainType: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainDueDate: TDateField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainName: TWideStringField;
    qryMainTransactionName: TWideStringField;
    qryMainOriginalAmount: TFloatField;
    qryMainAmountDue: TFloatField;
    qryMainCurrent: TFloatField;
    qryMainDSDesigner17Days: TFloatField;
    qryMainDSDesigner714Days: TFloatField;
    qryMainDSDesigner1421Days: TFloatField;
    qryMainDSDesigner21Days: TFloatField;
    qryMainDSDesigner130Days: TFloatField;
    qryMainDSDesigner3060Days: TFloatField;
    qryMainDSDesigner6090Days: TFloatField;
    qryMainDSDesigner90Days: TFloatField;
    qryMainSaleID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainTransID: TIntegerField;
    qryMainClassID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainParentClientID: TIntegerField;
    qryMainReceipt: TWideStringField;
    Label7: TLabel;
    cboReceiveClass: TwwDBLookupCombo;
    qryClass: TERPQuery;
    qryMainID: TIntegerField;
    Label8: TLabel;
    cboFilter: TComboBox;
    Label9: TLabel;
    edtSearch: TEdit;
    btnAddFilter: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnClearFilter: TDNMSpeedButton;
    imgPopup: TImageList;
    pumOptions: TAdvPopupMenu;
    AddtoFilter1: TMenuItem;
    ExecuteFilter1: TMenuItem;
    ClearFilter1: TMenuItem;
    Bevel1: TBevel;
    qryMainCompany: TWideStringField;
    qryMainJobName: TWideStringField;
    PaymentDate: TwwDBDateTimePicker;
    Label10: TLabel;
    kbmBinaryStreamFormat: TkbmBinaryStreamFormat;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel5: TDNMPanel;
    grdmain: TwwDBGrid;
    qryMainForeignExchangecode: TWideStringField;
    qryMainForeignExchangeRate: TFloatField;
    lblClassTitle: TLabel;
    cboClass: TwwDBLookupCombo;
    Label6: TLabel;
    chkAllClass: TwwCheckBox;
    qryMainAmountToPay: TFloatField;
    qryMainBalanceLeft: TFloatField;
    procedure DateRangeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure IgnoreDatesClick(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure edtAmtTenderedEnter(Sender: TObject);
    procedure edtAmtTenderedKeyPress(Sender: TObject; var Key: char);
    procedure edtAmtTenderedExit(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure actPayUpdate(Sender: TObject);
    procedure cboBasisCloseUp(Sender: TObject);
    procedure btnAddFilterClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure btnClearFilterClick(Sender: TObject);
    procedure PaymentDateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPayExecute(Sender: TObject);
    procedure qryMainReceiptChange(Sender: TField);
    procedure grdmainTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure grdmainCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grdmainColEnter(Sender: TObject);
    procedure grdmainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdmainDblClick(Sender: TObject);
    procedure qryMainAmountToPayChange(Sender: TField);
  private
    { Private declarations }
    oPrintOptions       : TPrintOptions;
    fbGettingARBalances : boolean;
    fbCalcRunning       : boolean;
    fsTablename         : String;
    dSelected           : Double;
    dOutstanding        : Double;
    dReceived           : double;
    fsSortColumnName    : string;
    fsColumnOrderMode   : string;
    procedure BuildSearchColumnCombo;
    procedure DoGetARBalances;
    procedure InitialiseEditor;
    procedure PerformSuggestion;
    procedure PrintScreenReport;
    procedure calctotals;
  Protected
    procedure DoCalculateRunningBalance;Override;
    Procedure DoDeSelectall;Override;
    Procedure DoSelectAll;Override;
    procedure Calcbalance;Override;
  public
    { Public declarations }
  end;

implementation

uses
  DNMExceptions, Report_AR_Obj,
  CommonDbLib, CommonLib,
  DateUtils,FastFuncs, AppEnvironment, BusObjPayments, MySQLConst,
  tcConst, CommonFormLib, DbSharedObjectsObj, LogLib;

{$R *.dfm}

procedure TfrmBulkReceiveCustomersGUI.DateRangeChange(Sender: TObject);
begin
  if Sender is TwwDBDateTimePicker then begin
    if TwwDBDateTimePicker(Sender).Modified then InitialiseEditor;
  end else 
    InitialiseEditor;
end;

procedure TfrmBulkReceiveCustomersGUI.FormCreate(Sender: TObject);
begin
  fsTablename := commondbLib.CreateUserTemporaryTable('tmp_tblaccountsreceivable' , '_BulkAR');
  inherited;
  if Self.ErrorOccurred then Exit;
  fbGettingARBalances := false;
  fbCalcRunning := false;
  dAmtTendered := 0;
end;

procedure TfrmBulkReceiveCustomersGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;

begin
  DisableForm;
  try
    try
        inherited;
        dtFrom.OnExit    := DateRangeChange;
        dtFrom.OnCloseUp := DateRangeChange;
        dtFrom.DateTime  := Date() - AppEnv.Employee.ListDaysPast;

        dtTo.OnExit      := DateRangeChange;
        dtTo.OnCloseUp   := DateRangeChange;
        dtTo.DateTime    := Date() + AppEnv.Employee.ListDaysFuture;
        PaymentDate.Date := Date();

        Setlength(QueryNamesNotToOpen, 1);
        QueryNamesNotToOpen[0] := 'qryMain';
        OpenQueries(QueryNamesNotToOpen);

        InitialiseEditor;

        BuildSearchColumnCombo;
        cboFilter.ItemIndex  := 0;
        btnAddFilter.Enabled := true;
        AddToFilter1.Enabled := true;

    except
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

procedure TfrmBulkReceiveCustomersGUI.BuildSearchColumnCombo;
var
  iX: integer;
begin
  cboFilter.Items.Clear;
    for iX := 0 to grdMain.FieldCount - 1 do
        if  (Sysutils.SameText(grdMain.Columns[iX].FieldName , 'AmountDue')) OR
            (Sysutils.SameText(grdMain.Columns[iX].FieldName , 'Current'  )) OR
            (Sysutils.SameText(grdMain.Columns[iX].FieldName , '1-30Days' )) OR
            (Sysutils.SameText(grdMain.Columns[iX].FieldName , '30-60Days')) OR
            (Sysutils.SameText(grdMain.Columns[iX].FieldName , '60-90Days')) OR
            (Sysutils.SameText(grdMain.Columns[iX].FieldName , '>90Days'  )) OR
            (Sysutils.SameText(grdMain.Columns[iX].FieldName , 'Receipt'  )) then
        else cboFilter.Items.Add(grdMain.Columns[iX].FieldName);

    Try
        cboFilter.ItemIndex := 0;
    except
    end;  
end;

procedure TfrmBulkReceiveCustomersGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
end;
procedure TfrmBulkReceiveCustomersGUI.Calcbalance;
begin
    if qryMainReceipt.asboolean then
        dSelected := dSelected + qryMainAmountToPay.asFloat;
end;
procedure TfrmBulkReceiveCustomersGUI.DoCalculateRunningBalance;
var
  dBalance : double;
begin
    dSelected := 0;
    IterateQrymain(CalcBalance , '' , 'Calculating Balance');

    if cboBasis.Text <> 'Manual' then begin
      edtAmtTendered.Text   := FloatToStrF(dSelected, ffCurrency, 15, CurrencyRoundPlaces);
      AmountTendered        := dSelected;
    end;

    dBalance                := AmountTendered - dSelected;
    RunningBalance          := dBalance;
    edtBalance.Text         := FloatToStrF(dSelected, ffCurrency, 15, CurrencyRoundPlaces);
    edtRunningBalance.Text  := FloatToStrF(RunningBalance, ffCurrency, 15, CurrencyRoundPlaces);
    SelectedBalance         := dSelected;
end;

procedure TfrmBulkReceiveCustomersGUI.DoGetARBalances;
var
  AR_Report_Obj: TAR_Report_Obj;
  StrSQL :String;
  scr :TERPScript;
  fstemptablename :STring;
begin
  if fbGettingARBalances then Exit;
  fbGettingARBalances := true;
  AR_Report_Obj := TAR_Report_Obj.Create(False);
  try
    if IgnoreDates.Checked then begin
      if not cboClass.Enabled then begin
        AR_Report_Obj.CleanRefresh_AR_Table(True,Now(), 0, true,-1,false,fsTablename);
      end else begin
        cboClassQry.Locate('ClassName', cboClass.Text, [loCaseInsensitive]);
        AR_Report_Obj.CleanRefresh_AR_Table(True,Now(), cboClassQry.FieldByName('ClassID').AsInteger, false,-1,false,fsTablename);
      end;
    end else begin
      if not cboClass.Enabled then begin
        AR_Report_Obj.CleanRefresh_AR_Table(False, dtTo.DateTime, 0, true,-1,false,fsTablename);
      end else begin
        cboClassQry.Locate('ClassName', cboClass.Text, [loCaseInsensitive]);
        AR_Report_Obj.CleanRefresh_AR_Table(False,dtTo.DateTime, cboClassQry.FieldByName('ClassID').AsInteger, false,-1,false,fsTablename);
      end;
    end;
    fstemptablename :=  commondblib.GetUserTemporaryTableName('BPC');
    strSQL :=   ' Drop Table if exists '+ fstemptablename +';' +
                ' create Table '+ fstemptablename +
                          ' select S.saleID ,S.ForeignExchangeCode , S.ForeignExchangeRate' +
                          ' from tblsales S ' +
                          ' inner join '+ fsTablename +' T on T.saleId = S.saleID ' +
                          ' Where T.type <> "'+CUSTOMER_PREPAYMENT+'";'+
                ' update ' + fsTablename +' AS TAR  '+
                ' Inner Join  '+ fstemptablename +' 		 AS Sales 	ON TAR.SaleID = Sales.SaleID  '+
                ' set TAR.ForeignExchangecode = if(ifnull(Sales.ForeignExchangeCode,"") = "",' + QuotedStr(Appenv.RegionalOptions.ForeignExDefault)+ ',Sales.ForeignExchangeCode ) ,  '+
                ' TAR.ForeignExchangeRate =  if(ifnull(Sales.ForeignExchangeRate,0) = 0 , 1, Sales.ForeignExchangeRate)  '+
                ' where TAR.type <> "'+CUSTOMER_PREPAYMENT+'"; '+

                ' Drop Table if exists '+ fstemptablename +';' +

                ' create Table '+ fstemptablename +
                          ' select PP.PrePaymentId ,PP.ForeignExchangeCode , PP.ForeignExchangeRate ' +
                          ' from tblPrepayments PP  ' +
                          ' inner join '+ fsTablename +' T on T.saleId = PP.PrePaymentId  ' +
                          ' Where T.type = "'+CUSTOMER_PREPAYMENT+'";'+
                ' update ' + fsTablename +' AS TAR   '+
                ' Inner Join '+ fstemptablename +' AS PP 	ON TAR.SaleID = PP.PrePaymentId '+
                ' set TAR.ForeignExchangecode = if(ifnull(PP.ForeignExchangeCode,"") = "" , ' + QuotedStr(Appenv.RegionalOptions.ForeignExDefault)+ ' ,PP.ForeignExchangeCode )	 ,  '+
                ' TAR.ForeignExchangeRate =  if(ifnull(PP.ForeignExchangeRate,0 )    = 0 , 1, PP.ForeignExchangeRate)      '+
                ' where TAR.type = "'+CUSTOMER_PREPAYMENT+'";' +
                ' Drop Table if exists '+ fstemptablename +';' ;

    scr := DbSharedObj.GetScript(Myconnection);
    try
      scr.SQL.Text := strSQL;
      scr.Execute;
    finally
      DbSharedObj.ReleaseObj(scr);
    end;

  finally
    // Release our used objects.
    if Assigned(AR_Report_Obj) then
      FreeAndNil(AR_Report_Obj);
    fbGettingARBalances := false;
  end;
end;

procedure TfrmBulkReceiveCustomersGUI.InitialiseEditor;
begin
  DoGetARBalances;

  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT A.*, SUBSTRING(B.Company, 1, ');
  qryMain.SQL.Add(' if(POSITION("^" IN B.Company)>0 ,POSITION("^" IN B.Company)-1 , char_length(B.Company) )) as Company , ');
  qryMain.SQL.Add('  B.JobName FROM ' +fsTablename);
  qryMain.SQL.Add(' AS A INNER JOIN  tblClients  as B ON B.ClientID = A.ClientID ');
  qryMain.SQL.Add(' WHERE A.AmountDue <> 0');
  qryMain.Open;
end;

procedure TfrmBulkReceiveCustomersGUI.bbCancelClick(Sender: TObject);
begin
  inherited;
  if Self.FormState = [fsModal] then begin
    Self.ModalResult := mrCancel;
  end else begin
    Close;
  end;
end;
Procedure TFrmBulkReceiveCustomersGui.DoDeSelectall;
begin
    if Qrymain.fieldByname('Receipt').AsBoolean then   begin
        EditQrymain;
        Qrymain.fieldByname('Receipt').AsBoolean  := False;
        PostQrymain;
    end;
end;
Procedure TfrmBulkReceiveCustomersGUI.DoSelectAll;
begin
    if not(Qrymain.fieldByname('Receipt').AsBoolean) then begin
      if Sysutils.SameText(qryMainForeignExchangecode.asString , appenv.RegionalOptions.ForeignExDefault) then begin
        EditQrymain;
        Qrymain.fieldByname('Receipt').AsBoolean  := True;
        PostQrymain;
      end;  
    end;
end;
procedure TfrmBulkReceiveCustomersGUI.btnClearClick(Sender: TObject);
begin
  inherited;
    IterateQrymain(DeSelectall, '' , 'De-Selecting All');
    logtext('btnClearClick');
    CalculateRunningBalance;
end;
procedure TfrmBulkReceiveCustomersGUI.btnSelectAllClick(Sender: TObject);
begin
    IterateQrymain(SelectAll ,'' , 'Selecting All');
    logtext('btnSelectAllClick');
    CalculateRunningBalance;
end;

procedure TfrmBulkReceiveCustomersGUI.IgnoreDatesClick(Sender: TObject);
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

procedure TfrmBulkReceiveCustomersGUI.chkAllClassClick(Sender: TObject);
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

procedure TfrmBulkReceiveCustomersGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  InitialiseEditor;
end;

procedure TfrmBulkReceiveCustomersGUI.edtAmtTenderedEnter(Sender: TObject);
begin
  inherited;
  if AmountTendered <> 0 then begin
    edtAmtTendered.Text := FloatToStr(AmountTendered);
    edtAmtTendered.SelectAll;
  end else begin
    edtAmtTendered.Text := '';
  end;
end;

procedure TfrmBulkReceiveCustomersGUI.edtAmtTenderedKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  // Ensure the user only presses valid keys.
  if ((Key <> '.') and (Key <> #8) and (Key <> '-') and ((Key < '0') or (Key > '9'))) then begin
    Key := #0;
  end;
end;

procedure TfrmBulkReceiveCustomersGUI.edtAmtTenderedExit(Sender: TObject);
var
  dX: double;
  edtBox: TEdit;
  sTemp: string;
begin
  edtBox := TEdit(Sender);
  sTemp := StringReplace(EdtBox.Text, AppEnv.RegionalOptions.CurrencySymbol, '', [rfReplaceAll,rfIgnoreCase]);
  sTemp := StringReplace(sTemp, ',', '', [rfReplaceAll,rfIgnoreCase]);

  if sTemp = '' then sTemp := '0'; 
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
    Logtext('edtAmtTenderedExit');
    CalculateRunningBalance;
  end;
end;

procedure TfrmBulkReceiveCustomersGUI.btnPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PrintScreenReport;
  finally
    EnableForm;
  end;  
end;
procedure TfrmBulkReceiveCustomersGUI.calctotals;
begin
    if Qrymain.FieldByName('Receipt').AsBoolean then begin
      dReceived := dReceived + Qrymain.FieldByName('AmountDue').AsFloat;
    end else begin
      dOutstanding := dOutstanding + Qrymain.FieldByName('AmountDue').AsFloat;
    end;
end;
procedure TfrmBulkReceiveCustomersGUI.PrintScreenReport;
var
  sSQL: string;
begin
  inherited;
  dOutstanding := 0;
  dReceived := 0;
  IterateQrymain(calctotals , '' , 'Calculating Totals');
  fbTemplateUsesNonFormConnection := false;
  sSQL := '';
  fbReportSQLSupplied := true;

  sSQL := sSQL + '{CoyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ", ';
  sSQL := sSQL + 'CO.PhoneNumber) AS PhoneNumber, Concat("Fax ", CO.FaxNumber) AS FaxNumber, CO.ABN ';
  sSQL := sSQL + 'FROM tblCompanyInformation AS CO ';
  sSQL := sSQL + '~|||~{AccountsReceivable}';
  sSQL := sSQL + 'SELECT *, ' + FloatToStrF(dOutstanding, ffFixed, 15, 2) + ' AS Outstanding, ' +
    FloatToStrF(dReceived, ffFixed, 15, 2) + ' AS TotalReceived ';
  sSQL := sSQL + 'FROM `' + fsTablename + '` ';
  if sFilter = '' then begin
    sSQL := sSQL + 'WHERE AmountDue <> 0 ';
  end else begin
    sSQL := sSQL + 'WHERE AmountDue <> 0 AND ' + sFilter;
  end;

  sSQL := sSQL + 'ORDER BY CustomerName;';

  PrintTemplateReport(TemplateToPrint('Receive Bulk Customer Payments' , chkChooseRpt.checked),  sSQL, true, 1);
  fbReportSQLSupplied := false;
end;

procedure TfrmBulkReceiveCustomersGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'CustomerName ASC CIS';
end;


procedure TfrmBulkReceiveCustomersGUI.qryMainAmountToPayChange(Sender: TField);
begin
  inherited;
  EditQrymain;
  if QrymainAmountToPay.AsFloat <> 0  then
      QrymainBalanceLeft.AsFloat := QrymainAmountDue.AsFloat - QrymainAmountToPay.AsFloat
  else QrymainBalanceLeft.asFloat := 0;
  Logtext('qryMainAmountToPayChange');
  CalculateRunningBalance;
end;

procedure TfrmBulkReceiveCustomersGUI.actPayUpdate(Sender: TObject);
begin
  if (SelectedBalance <> AmountTendered) or (cboPaymentMethod.Text = '') then begin
    bbOk.Enabled := false;
  end else begin
    bbOk.Enabled := true;
  end;
end;

procedure TfrmBulkReceiveCustomersGUI.cboBasisCloseUp(Sender: TObject);
begin
  inherited;
  if cboBasis.Text = '' then Exit;
  PerformSuggestion;
end;

procedure TfrmBulkReceiveCustomersGUI.PerformSuggestion;
var
  strFilter :String;
begin
    inherited;
    if Sysutils.SameText(cboBasis.Text , 'Manual') then Exit;

    IterateQrymain(DeSelectall , '' , 'De-Selecting All');

    if Sysutils.SameText(cboBasis.Text , 'All Overdue') then begin
        if IgnoreDates.Checked then begin
            strFilter := '[DueDate] <= ' + Quotedstr(FormatDatetime( MysqlDateFormat , Date));
        end else begin
            strFilter := '[DueDate] <= ' + Quotedstr(FormatDatetime( MysqlDateFormat , dtTo.Date));
        end;
    end else if Sysutils.SameText(cboBasis.Text , 'All Current') then begin
        strFilter := '[Current] <> 0 ';
    end else if Sysutils.SameText(cboBasis.Text , 'Over 90 Days') then begin
        strFilter := '[>90Days] <> 0 ';
    end else if Sysutils.SameText(cboBasis.Text , 'Over 60 Days') then begin
        strFilter := '[>90Days] <> 0  or [60-90Days] <> 0';
    end else if Sysutils.SameText(cboBasis.Text , 'Over 30 Days') then begin
        strFilter := '[>90Days] <> 0  or [60-90Days] <> 0 or [30-60Days] <> 0';
    end else if Sysutils.SameText(cboBasis.Text , 'Over 1-30 Days') then begin
        strFilter := '[1-30Days] <> 0';
    end;
    IterateQrymain(Selectall, strFilter , 'Selecting All');
    Logtext('PerformSuggestion');
    CalculateRunningBalance;

end;

procedure TfrmBulkReceiveCustomersGUI.btnAddFilterClick(Sender: TObject);
begin
  inherited;
  sFilter := cboFilter.Text + ' = ' +  QuotedStr(grdmain.GetActiveField.AsString) ;
  btnExecute.Enabled := true;
  btnClearFilter.Enabled := true;
  ClearFilter1.Enabled := true;
  ExecuteFilter1.Enabled := true;
end;

procedure TfrmBulkReceiveCustomersGUI.btnExecuteClick(Sender: TObject);
begin
  inherited;
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
    ShowFilter(filtercaption + qrymain.Filter);
    btnExecute.Enabled      := false;
    ExecuteFilter1.Enabled  := false;
end;

procedure TfrmBulkReceiveCustomersGUI.edtSearchChange(Sender: TObject);
var
  sFieldName: string;
  tmpIndex: string;
begin
    inherited;
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

procedure TfrmBulkReceiveCustomersGUI.btnClearFilterClick(Sender: TObject);
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


procedure TfrmBulkReceiveCustomersGUI.PaymentDateChange(Sender: TObject);
begin
  inherited;
  IterateQrymain(DeSelectall , '' , 'De-Selecting All');
end;

procedure TfrmBulkReceiveCustomersGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;
end;

procedure TfrmBulkReceiveCustomersGUI.actPayExecute(Sender: TObject);
var
    CustPay :TCustPayments;
    frmPO: TfrmPrintOptionsGUI;
    strSQL:String;
begin
    inherited;
    if Qrymain.Recordcount = 0 then exit;

    try
        frmPO         := TfrmPrintOptionsGUI(GetComponentByClassName('TfrmPrintOptionsGUI'));
        if Assigned(frmPO) then begin //if has acess
            frmPO.ViaBulkCustomerPayments := true;
            frmPO.Results := @oPrintOptions;
            frmPO.ShowModal;
            if oPrintOptions.Screen then begin
                PrintScreenReport;
            end;
        end;
    finally
        FreeandNil(frmPO);
    end;
    CustPay := TCustPayments.create(self);
    try
        CustPay.connection :=  tMydacDataconnection.create(CustPay);
        CustPay.Connection.Connection := Self.MyConnection;
        strSQL := 'select ClientID, AmountToPay as Amount, classID, Type, SaleId as TransID from ' + fsTablename +
            ' where Receipt = "T" ' +
            ' order by classId , clientID';
        if CustPay.DoBulkPay(strSQL, cboPaymentMethod.Text,cboReceiveClass.text , PaymentDate.date,0 ) then Self.Close;
    Finally
        FreeAndNil(CustPay);
    end;
end;

procedure TfrmBulkReceiveCustomersGUI.qryMainReceiptChange(Sender: TField);
begin
  inherited;
  if (qryMainReceipt.AsBoolean) then
  if  (DateUtils.CompareDate(PaymentDate.Date,QrymainSaleDate.asDateTime)=-1) then Begin
    qryMainReceipt.AsBoolean := False;
    CommonLib.MessageDlgXP_Vista('Payment Cannot Pay Transaction Before It Existed !', mtWarning, [mbOK], 0);
    exit;
  end
  else if not (Sysutils.SameText(qryMainForeignExchangecode.asString , appenv.RegionalOptions.ForeignExDefault)) then begin
    EditQrymain;
    qryMainReceipt.asBoolean := False;
    CommonLib.MessageDlgXP_Vista('Payment Cannot Pay Transaction using Foreign currency('+
                                    qryMainForeignExchangecode.asString +')',
                                    mtWarning, [mbOK], 0);
   exit;
  end;
  if qryMainReceipt.asBoolean then begin
    if qryMain.FieldByName('AmountToPay').AsFloat = 0 then begin
        EditQrymain;
      qryMain.FieldByName('AmountToPay').AsFloat := qryMain.FieldByName('AmountDue').AsFloat;
    end;
  end
  else begin
    EditQrymain;
    qryMain.FieldByName('AmountToPay').asFloat := 0;
  end;
  Logtext('qryMainReceiptChange');
  CalculateRunningBalance;
end;

procedure TfrmBulkReceiveCustomersGUI.grdmainTitleButtonClick(
  Sender: TObject; AFieldName: String);
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
        (qryMain.FieldByName(AFieldName).DataType <> ftWideMemo) and
        (qryMain.FieldByName(AFieldName).DataType <> ftMemo) then begin
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

procedure TfrmBulkReceiveCustomersGUI.grdmainCalcTitleImage(
  Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
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

procedure TfrmBulkReceiveCustomersGUI.grdmainColEnter(Sender: TObject);
var
  iIndex: integer;
  s:String;
begin
  try
    iIndex := -1;
    s:=TwwDBGrid(Sender).GetActiveField.FieldName;
    if s<> '' then iIndex := cboFilter.Items.IndexOf(s);
    if iIndex <> -1 then cboFilter.ItemIndex := iIndex;
  except
  end;

end;

procedure TfrmBulkReceiveCustomersGUI.grdmainDblClick(Sender: TObject);
begin
  inherited;
  if SameText(qryMainType.AsString,'Invoice') then begin
    OpenERPForm('TInvoiceGUI', qryMainInvoiceNumber.AsInteger, nil, nil, false, true, true);
  end
  else if SameText(qryMainType.AsString,'Refund') then begin
    OpenERPForm('TRefundGUI', qryMainInvoiceNumber.AsInteger, nil, nil, false, true, true);
  end
  else if SameText(qryMainType.AsString,'Customer Payment') then begin
    OpenERPForm('TfmCustPayments', qryMainInvoiceNumber.AsInteger, nil, nil, false, true, true);
  end
  else if SameText(qryMainType.AsString,'Customer Prepayment') then begin
    OpenERPForm('TfmCustPrepayments', qryMainInvoiceNumber.AsInteger, nil, nil, false, true, true);
  end
end;

procedure TfrmBulkReceiveCustomersGUI.grdmainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
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
          ABrush.Color := AppEnv.Employee.ListSelectionColour;;
        end;
      except
      end;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmBulkReceiveCustomersGUI);
end.
