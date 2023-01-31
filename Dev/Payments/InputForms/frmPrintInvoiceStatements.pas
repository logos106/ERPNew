unit frmPrintInvoiceStatements;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/05/05  1.00.01 BJ  'Raise exception' is changed to MessageDlg for user messages
 29/06/05  1.00.02 BJ  'Group Jobs with Customer' was searching for '^' in the
                        customer name, but the temp table has 'Customer(job) format
                        So the code changed to split the name when '(' found not '^'.
 23/09/05  1.00.02 DSP  Changed label 'Print all Outstanding Statements' to
                       'Print all Statements'.
 19/10/05  1.00.03 DLS  Added RegisterClass
 20/02/06  1.00.04 DSP  Added password to email authentication.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB, StdCtrls, ExtCtrls,
  DNMPanel, Grids, Wwdbigrd, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, SelectionDialog, kbmMemTable,
  Buttons, DNMSpeedButton, ImgList, wwdblook, wwcheckbox, kbmMemCSVStreamFormat,
  MyAccess,ERPdbComponents, MemDS, DBAccess, DataState, wwdbdatetimepicker, EmailUtils,
  Menus, AdvMenus, MyScript, DAScript, Shader, ProgressDialog;

const
  SX_DatechangeMsg = WM_USER + 125;
type

  TPrintDestination = (csNone, csPreview, csPrint, csFax, csEmail, csSMS, csSend, csExport, csPDF);

  TPrintStatement = class(TBaseInputGUI)
    dsStatements: TDataSource;
    qryStatements: TERPQuery;
    Bevel1: TBevel;
    Label3: TLabel;
    grd: TwwDBGrid;
    btnSelect: TDNMSpeedButton;
    btnUnselect: TDNMSpeedButton;
    imgPopup: TImageList;
    cboClassQry: TERPQuery;
    memExportALL: TkbmMemTable;
    kbmCSVStreamFormat1: TkbmCSVStreamFormat;
    SaveDialog1: TSaveDialog;
    qryStatement2: TERPQuery;
    dtCurDate: TwwDBDateTimePicker;
    qryStatementsSalesSum: TFloatField;
    qryStatementsPrepaysum: TFloatField;
    qryStatementsAmountdue: TFloatField;
    tabGeneral: TTabSheet;
    TabOptions: TTabSheet;
    Pagecontrol: TPageControl;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label7: TLabel;
    chkOutstandingInv: TCheckBox;
    chkincludeSOBO: TCheckBox;
    chkincludeinvoiceBO: TCheckBox;
    chkincludeSalesOrder: TCheckBox;
    Bevel3: TBevel;
    Label12: TLabel;
    chkshowPaid: TCheckBox;
    qryStatementsBOINVSum: TFloatField;
    qryStatementsBOSOSum: TFloatField;
    qryStatementstotalamountdue: TFloatField;
    Label15: TLabel;
    qryStatementsGlobalRef: TWideStringField;
    qryStatementsCompanyName: TWideStringField;
    qryStatementsTypeName: TWideStringField;
    qryStatementsJobName: TWideStringField;
    qryStatementsJobNumber: TIntegerField;
    qryStatementsSerial: TWideStringField;
    qryStatementsModel: TWideStringField;
    qryStatementsManufacture: TWideStringField;
    qryStatementsARBalance: TFloatField;
    qryStatementsAPBalance: TFloatField;
    qryStatementsBalance: TFloatField;
    qryStatementsFirstname: TWideStringField;
    qryStatementsMiddleName: TWideStringField;
    qryStatementsLastName: TWideStringField;
    qryStatementsEmail: TWideStringField;
    qryStatementsIsJob: TWideStringField;
    qryStatementsActive: TWideStringField;
    qryStatementsClientID: TLargeIntField;
    qryStatementsParentClientID: TIntegerField;
    qryStatementsParentRelatedClientID: TIntegerField;
    qryStatementsSOBalance: TFloatField;
    qryStatementsStopCredit: TWideStringField;
    qryStatementsStreet: TWideStringField;
    qryStatementsStreet2: TWideStringField;
    qryStatementsStreet3: TWideStringField;
    qryStatementsSuburb: TWideStringField;
    qryStatementsState: TWideStringField;
    qryStatementsCountry: TWideStringField;
    qryStatementsPostcode: TWideStringField;
    lblCustomfilter: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    chkGroupJobs: TCheckBox;
    chkRelatedCustomer: TCheckBox;
    chk0Balancecustomers: TCheckBox;
    chkGroupType: TCheckBox;
    Label18: TLabel;
    grpOrderOptions: TRadioGroup;
    grpbasedonoptions: TRadioGroup;
    chkBalOnDaterange: TCheckBox;
    lblBalOnDaterangehint: TLabel;
    DNMPanel3: TDNMPanel;
    btnClose: TDNMSpeedButton;
    btnReport: TDNMSpeedButton;
    btnSend: TDNMSpeedButton;
    chkChooseRpt: TCheckBox;
    Label8: TLabel;
    Bevel6: TBevel;
    DNMPanel4: TDNMPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    lblFilter: TLabel;
    edtSearch: TEdit;
    btnClear: TDNMSpeedButton;
    btnExecute: TDNMSpeedButton;
    btnAddFilter: TDNMSpeedButton;
    DNMPanel5: TDNMPanel;
    Panel4: TDNMPanel;
    lblClassTitle: TLabel;
    chkAllClass: TCheckBox;
    cboClass: TwwDBLookupCombo;
    Label1: TLabel;
    dtFrom: TwwDBDateTimePicker;
    Label2: TLabel;
    dtTo: TwwDBDateTimePicker;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnUnselectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkCurrentClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
//    procedure btnPreviewClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure btnAddFilterClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure dtToChange(Sender: TObject);
    procedure grdCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grdTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean;
      AFont: TFont; ABrush: TBrush);
    procedure chkGroupJobsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdColEnter(Sender: TObject);
    procedure qryStatementsAfterOpen(DataSet: TDataSet);
    procedure MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
    procedure chkincludeSalesOrderClick(Sender: TObject);
    procedure qryStatementsCalcFields(DataSet: TDataSet);
    procedure chk0BalancecustomersClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure chkRelatedCustomerClick(Sender: TObject);
    procedure grdDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qryStatementsBeforeOpen(DataSet: TDataSet);
    procedure chkGroupTypeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure qryStatementsBeforeClose(DataSet: TDataSet);

  private
    { Private declarations }
    ToPrevDate: TDateTime;
    flstFilter: TStringList;
    fcustomerListFilter:String;
    ClientID: integer;
    fsFax: boolean;
    SQLFINAL: String;
    ExportToFile: boolean;
    ExportStructureDone: boolean;
    FilterColumn: String;
    HIGHLIGHTLOCATE: TColor;
    bEscapeEmails: boolean;
    fsTablename:String;
    fsRTTablename :String;
    fsRTDetailTablename :String;
    fsTempTblName:String;
    xclientID :Integer;
    chkGroupJobsChecked:Boolean;
    chkRelatedCustomerChecked:Boolean;
    fsTempSalesTable: string;
    fsTempSalesLinesTable: string;
    fstblSalesSum , tablenameSalesSum:String;
    fstblPrepaySum , tablenamePrepaySum:String;
    fstblBOInvsum , tablenameBOInvsum:String;
    fstblBOSOsum , tablenameBOSOsum:String;
    ficlientId :Integer;

    procedure RefreshQuery;
    Procedure SetQryStatementFilter;
    procedure PrintStatements(const fClientID:Integer;const DoPrint, Fax, Email, ExporttoFile: boolean; const ASilent : boolean = false; const ASecret : boolean = false; const SaveasPDF:Boolean =False);
    procedure CreateStatement(AClientId : integer; const sFrom, sTo : string);
    Procedure AddtransdetailsSQL(AClientId : integer; const sFrom, sTo : string);//;OpeningBalance,OutstandingAmt,ForeignOpeningBalance ,ForeignOutstandingAmt: double);
    function GetFilterString: String;
    function GetOverDueMsg(const sTable: String): String;
    procedure EmailStatement(const ClientID: integer;  const ASilent : boolean = false; const ASecret : boolean = false);
    procedure FaxStatement(const ClientID: integer);
    procedure ExportStatement;
    procedure MakeQRY;
    function GetALLClassFilterString: String;
    procedure PrintTemplateInv(const SaleID: integer; const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: String = ''; ShowCancelPreviewBtninReportPreview :Boolean =False);
    procedure EmailInvoice(SaleID, ClientID: integer);
    procedure FaxInvoice(SaleID, ClientID: integer);
    procedure PrintTemplateRefund(const SaleID: integer; const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: String = '');
    procedure EmailRefund(SaleID, ClientID: integer);
    procedure FaxRefund(SaleID, ClientID: integer);
    function  Clients(TableAlias:String):String;
    Function SalesType :String;
    Function SalestypeBO:String;
    Function BOType :String;
    function Datetofilter :String ;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    Function IsrunningBalanceReport(Const ReportName:String):Boolean;
    Procedure Readfilter(Sender:TObject);
    procedure SetcustomerListFilter(const Value: String);
    function ClientDefaultStatement(const fClientID:Integer):String;
    procedure DobeforeExecuteScript(Sender: TObject; var SQL: string;var Omit: Boolean);
    function clientbillToAddress(TableAlias: STring): String;
    function TotalForeignAmt(const sFrom, sTo : string; iscurrent,isclosingBalance: Boolean): Double;
    function IsAllClassSelected: boolean;
    function Prepayamount(PrepayTablealias :String ='P';ResutlTupe:String ='Balance' ):String;
    function SalesBalance(salesTableAlias:String ='S'):String;

    //
    Function DaysTostatementDate:String;
    function DueDays:String;
    function getClassFilter(const fsFieldName:String):String;
    Procedure runSQL(const strSQL:String; var VarAmt :Double; fsFieldname :String; runLoop:Boolean = true);
    function TotalAmt(const sFrom, sTo : string; iscurrent:Boolean=False; isclosingBalance:Boolean = False):Double;
    procedure actPrint(Sender : TObject);
    procedure actEmail(Sender : TObject);
    procedure actPreview(Sender : TObject);
    procedure actFax(Sender : TObject);
    procedure actSMS(Sender : TObject);
//    procedure actSchedule(Sender : TObject);
    //procedure InitReportName(Sender : TObject);

    procedure actPrintReport(aDestination : TPrintDestination);
    function DoSaveTransToPDF(const fiClientID: Integer): boolean;
    function SaveTransToPDF: boolean;
    procedure InitStatementParams;

  protected
    function GetReportTypeID: integer; override;
    Procedure AfterFormShow; override;

  public
    { Public declarations }
    ARClientID :Integer;
    Property customerListFilter :String read fcustomerListFilter Write SetcustomerListFilter;
  end;

var
  PrintOrEmailFlag: integer;

implementation

uses FastFuncs,  DnMLib,
  DNMExceptions, CommonDbLib, FaxObj,
  AppEnvironment, Commonlib,systemlib,tcDataUtils, MySQLConst,
  CompanyPrefObj, GuiPrefsObj, DefaultClassObj, EmployeeObj,
  BaseListingForm, (*CustomerExpressList, *)tcTypes, tcConst, TempTableUtils,
  TemplateReportsLib, LogLib, CorrespondenceObj, DbSharedObjectsObj,
  ShellAPI, frmReportingOptions, EmailExtraUtils, CommonFormLib, frmScheduleReports,
  ProductQtyLib, ProductQtylist, CustomersForStatements, StatementsLib,
  StatementsRunnBalLib, StatementsSimpleLib;

{$R *.dfm}

{ TPrintStatement }

const
  HIGHLIGHTLOCATEDEF = $00DFFFFE; // a very light yellow rw

procedure TPrintStatement.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of String;
begin
  RealignTabControl(Pagecontrol, 1);
  Pagecontrol.ActivePage := tabGeneral;
  dtCurDate.Date := Date;
  DisableForm;
  try
    try
      if AccessLevel <> 1 then begin
        AccessLevel := 6; // all or none!!!
      end;
      inherited;
      GuiPrefs.active := TRue;

      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'qryStatements';
      QueryNamesNotToOpen[1] := 'qryStatement2';
      OpenQueries(QueryNamesNotToOpen);

      cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
      cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;
      ReadGuiPref;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;

  Pagecontrol.ActivePage := tabGeneral;
  SetControlFocus(edtSearch);
end;

procedure TPrintStatement.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPref;

  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TPrintStatement.btnCloseClick(Sender: TObject);
begin
  inherited;

  Self.Close;
end;

procedure TPrintStatement.btnSelectClick(Sender: TObject);
begin
    grd.selectall;
end;

procedure TPrintStatement.btnSendClick(Sender: TObject);
begin
//  inherited;
  actPrintReport(csSend);
end;

procedure TPrintStatement.btnUnselectClick(Sender: TObject);
begin
  inherited;
  grd.SelectedList.Clear;
  grd.Refresh;
end;

procedure TPrintStatement.FormCreate(Sender: TObject);
begin
  ficlientId := 0;
//  showcontrolhint(btnEmail , 'Preference "Utilities->Preview Email" will Let You to Preview the Email Before Sending.'+NL+
  showcontrolhint(btnReport , 'Preference "Utilities->Preview Email" will Let You to Preview the Email Before Sending.'+NL+
                             'Turn this Preference Off if You Don''t Need to Preview it and to Send the Email Silently.'+NL) ;
  fstblSalesSum:= '';
  fstblBOInvsum:= '';
  fstblBOSOsum:= '';
  fstblPrepaySum:= '';

  tablenameSalesSum:= GetUserTemporaryTableName('SalesSum');
  tablenameBOInvsum:= GetUserTemporaryTableName('BOInvsum');
  tablenameBOSOsum:= GetUserTemporaryTableName('BOSOsum');
  tablenamePrepaySum:= GetUserTemporaryTableName('PrepaySum');


  fsTablename           := GetUserTemporaryTableName('Statements');
  fsTempTblName         := GetUserTemporaryTableName('Statementsum');
  fsRTTablename         := GetUserTemporaryTableName('StatementRT');
  fsRTDetailTablename   := GetUserTemporaryTableName('StatementRTDetail');
  fsTempSalesTable      := GetUserTemporaryTableName('StatementSales');
  fsTempSalesLinesTable := GetUserTemporaryTableName('StatementSalesLines');
  ARClientID            := -1;
  xclientID             := 0;
  chkGroupJobsChecked   :=False;
  chkRelatedCustomerChecked:=False;
  flstFilter            := TStringList.Create;
  flstFilter.Sorted     := true;
  flstFilter.Duplicates := dupError;
  customerListFilter    := '';
  dtFrom.Date           := Date - 120;
  dtTo.Date             := Date;
  if AppEnv.Employee.ListSelectionColour = 0 then begin
    HIGHLIGHTLOCATE     := HIGHLIGHTLOCATEDEF;
  end else begin
    HIGHLIGHTLOCATE     := AppEnv.Employee.ListSelectionColour;
  end;
  inherited;
  DeactivateDefaultValues;
end;

function TPrintStatement.ClientDefaultStatement(
  const fClientID: Integer): String;
begin
  Result := '';
  if fclientID = 0 then Exit;
  With TempMyQuery do try
    SQL.Add('SELECT T.TemplName '+
      ' FROM tblclients C  '+
      ' INNER JOIN tbltemplates T ON IFNULL(C.DefaultStatementTemplateId, 0) = t.templid ' +
      ' WHERE c.ClientId = ' + IntToStr(fclientID) +
      ' AND ifnull(C.DefaultStatementTemplateId ,0) <> 0');
    open;
    if RecordCount = 1 then
      Result := fieldByname('TemplName').AsString;
  finally
    if Active then Close;
    Free;
  end;
end;


procedure TPrintStatement.actEmail(Sender: TObject);
begin
//  btnPreviewClick(btnEmail);
  actPrintReport(csEmail);
end;

procedure TPrintStatement.actFax(Sender: TObject);
begin
  actPrintReport(csFax);
end;

procedure TPrintStatement.actPreview(Sender: TObject);
begin
  actPrintReport(csPreview);
end;

procedure TPrintStatement.actPrint(Sender: TObject);
begin
//  btnPreviewClick(btnPrint);
  actPrintReport(csPrint);
end;

procedure TPrintStatement.RefreshQuery;
begin
  Disableform;
  try
    if not IsFormshown then Exit;
    MakeQRY;
  finally
    Enableform;
  end;
end;

procedure TPrintStatement.chkCurrentClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TPrintStatement.PrintStatements(const fclientID:Integer; const DoPrint, Fax, Email, ExporttoFile: boolean; const ASilent : boolean = false; const ASecret : boolean = false; const SaveasPDF:Boolean =False);
var
  sFrom           : String;
  sTo             : String;
  sClassName      : String;
  QryPrintInv     : TERPQuery;
  strtype         : String;
  SavedPrintDialogPref:Boolean;
  RecipientAddress: string;
  DlgResult: word;

  function getorder(IsRunningBalance: boolean):String;
  begin
    if IsRunningBalance then begin
      if grpOrderOptions.Itemindex =0  then Result := 'saledate' else Result := 'SaleID';
    end else begin
      Result := 'SaleID';
    end;
  end;
begin
  if chkChooseRpt.Checked then
  begin
    if ReportToPrint = '' then
    begin
      LoadReportTypes;
      if dlgReportSelect.Execute then
      begin
        ReportToPrint := dlgReportSelect.SelectedItems.Text;
      end
      else
        exit;
    end;
  end
  else
  begin
    ReportToPrint := ClientDefaultStatement(fclientID);
    if ReportToPrint = '' then
      ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
  end;

  ReportToPrint:= Trim(ReportToPrint);

  sFrom := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  sTo := FormatDateTime(MysqlDateFormat, dtTo.DateTime);

  (*//Setup qryStatement2
  qryStatement2.Close;
  qryStatement2.SQL.Clear;
  qryStatement2.Connection := CommonDbLib.GetSharedMyDacConnection;*)

 //Invoices

  sClassName := cboClass.Text;
  if IsAllClassSelected then
    sClassName := 'All';

  CreateStatement(fClientId, sFrom, sTo);

  fbReportSQLSupplied := true;
  fbTemplateUsesNonFormConnection := true;
  if ExporttoFile then begin
    ExportStatement;
  end else if SaveasPDF then begin
    DoSaveTransToPDF(fClientID);
  end else if not (Fax) and not (Email) then begin
    PrintTemplateReport(ReportToPrint,SQLFINAL , DoPrint, 1);//,True, 'SaleId' , 'SL.saleId');
 end else if Fax and not (Email) then begin
    // Fax
    FaxStatement(ClientID);
  end else if not (Fax) and Email then begin
    // Email

    RecipientAddress := GetContactEmails(ClientId, 'MainContactForStatements');

    if RecipientAddress = '' then begin

      if self.IsFlag('YesToAll') then begin
        EmailStatement(ClientID);
      end
      else if self.IsFlag('NoToAll') then begin
        { do nothing }
      end
      else if self.IsFlag('PrintAll') then begin
        PrintTemplateReport(ReportToPrint,SQLFINAL , DoPrint, 1);
      end
      else begin

        if self.IsFlag('AutoSend') then
          DlgResult := CommonLib.MessageDlgXP_Vista(GetClientName(ClientID) + ' does not have an email address.' + #13 + #10 +
            'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo,mbYesToAll,mbNoToAll], 0, nil,'','',false,nil,'Print,Print All')
        else
          DlgResult := CommonLib.MessageDlgXP_Vista(GetClientName(ClientID) + ' does not have an email address.' + #13 + #10 +
            'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo,mbYesToAll,mbNoToAll], 0);

        case DlgResult of
          mrYes: EmailStatement(ClientID);
          mrNo: { do nothing };
          mrYesToAll:
            begin
              self.AddFlag('YesToAll');
              EmailStatement(ClientID);
            end;
          mrNoToAll:
            begin
              self.AddFlag('NoToAll');
            end;
          102: { Print }
            begin
              PrintTemplateReport(ReportToPrint,SQLFINAL , DoPrint, 1);
            end;
          103: { Print All }
            begin
              self.AddFlag('PrintAll');
              PrintTemplateReport(ReportToPrint,SQLFINAL , DoPrint, 1);
            end;
        end;

      end;

    end
    else begin
      { email address ok so just send }
      EmailStatement(ClientID, ASilent, ASecret);
    end;

  end;
  fbReportSQLSupplied := false;
  //###  Print Invoices  ###
  if chkOutstandingInv.Checked then begin
    qryPrintInv := TERPQuery.Create(Self);
    qryPrintInv.Options.FlatBuffers := True;
    qryPrintInv.Connection := CommonDbLib.GetSharedMyDacConnection;
    try

      if IsrunningBalanceReport(ReportToPrint) then
        qryPrintInv.SQL.Add('SELECT * FROM ' +fsRtTablename + ' WHERE Type IN ("Invoice", "Refund") ORDER BY clientID, ' + getorder(true))
      else
        qryPrintInv.SQL.Add('SELECT * FROM ' +fsTablename + ' WHERE Type IN ("Invoice", "Refund") ORDER BY clientID, ' + getorder(false));
      qryPrintInv.Open;
      qryPrintInv.First;
      SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
      try
          while not qryPrintInv.Eof do begin

            strtype := Trim(qryPrintInv.FieldByName('Type').AsString);
            if (Sysutils.SameText(strtype , 'Invoice')) and
              (qryPrintInv.FieldByName('Status').AsString <> 'Fully Paid') and
              (qryPrintInv.FieldByName('Outstanding Amount').AsFloat <> 0.00) then begin
              if (not (Fax) and (not (Email))) then begin
                ReportToPrint := '';
                PrintTemplateInv(qryPrintInv.FieldByName('SaleID').AsInteger, DoPrint, false , true , '' , True );
                ReportToPrint := '';
                if PrintTemplate.CancelPreviewAll then break;
              end else if Fax and not (Email) then begin
                // Fax
                ReportToPrint := '';
                FaxInvoice(qryPrintInv.FieldByName('SaleID').AsInteger, qryPrintInv.FieldByName('ClientID').AsInteger);
              end else if not (Fax) and Email then begin
                // Email
                ReportToPrint := '';
                EmailInvoice(qryPrintInv.FieldByName('SaleID').AsInteger, qryPrintInv.FieldByName('ClientID').AsInteger);
              end;
            end else if (Sysutils.SameText(strtype , 'Refund')) and
              (qryPrintInv.FieldByName('Status').AsString <> 'Fully Paid') and
              (qryPrintInv.FieldByName('Outstanding Amount').AsFloat <> 0.00) then begin
              if (not (Fax) and not (Email)) or not DoPrint then begin
                ReportToPrint := '';
                PrintTemplateRefund(qryPrintInv.FieldByName('SaleID').AsInteger, DoPrint, false);
                ReportToPrint := '';
              end else if Fax and not (Email) then begin
                // Fax
                ReportToPrint := '';
                FaxRefund(qryPrintInv.FieldByName('SaleID').AsInteger, qryPrintInv.FieldByName('ClientID').AsInteger);
              end else if not (Fax) and Email then begin
                // Email
                ReportToPrint := '';
                EmailRefund(qryPrintInv.FieldByName('SaleID').AsInteger, qryPrintInv.FieldByName('ClientID').AsInteger);
              end;
            end;
            AppEnv.Employee.ShowPrintDialog := False;
            qryPrintInv.Next;
          end;

      finally
        AppEnv.Employee.ShowPrintDialog:= SavedPrintDialogPref;
      end;


    finally
      FreeandNil(QryPrintInv);
    end;
  end;
  //########################
  fbTemplateUsesNonFormConnection := false;
  fbReportSQLSupplied := false; // for any other reports
end;

procedure TPrintStatement.EmailInvoice(SaleID, ClientID: integer);
var
  f: file;
  RecipientAddress, ReportType, OutGoingFileName: String;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: String;
  EmailDate: TDateTime;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  // Clear all previous params/data
  (*lblProgress.*)Label8.Caption := 'Emailing, ' + WAITMSG;
  RecipientAddress := '';
  ReportType := '';
  OutGoingFileName := '';
  RecipientAddress := ClientcontactEmailID(ClientID , ctMainContactforInvoice );
  if RecipientAddress = '' then
    if CommonLib.MessageDlgXP_Vista(GetClientName(ClientID) +
      ' does not have an email address to send to. Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
//  if RecipientAddress <> '' then begin
    try
      Corres := TCorrespondenceGui.Create;
      try

        ReportType := 'Invoice';
        // String defined here because it is easy to change when this code is applied to
        // other forms. (ie, Quote instead of Invoice etc)
        (*lblProgress.*)Label8.Visible := true;
        PrintTemplateInv(SaleID, true, true);


        (*lblProgress.*)Label8.Caption := 'Connecting...';

        (*lblProgress.*)Label8.Caption := 'Emailing, ' + WAITMSG;

        Corres.Subject := ReportType + ' #' + GetInvDocNo(SaleID) + ' for ' + GetClientName(ClientID);

        Corres.RecipientList := RecipientAddress;
        Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;
        Corres.CustomerId := ClientID;
        OutGoingFileName := getOutGoingFileName('' ,' ' + ReportType + ' #' + GetInvDocNo(SaleID)  ,'.PDF');
        AssignFile(f,  Commonlib.TempDir  + 'EmailReport.PDF');

        if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
          copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
            PChar( Commonlib.TempDir  + OutGoingFileName), false);
        end;

        Corres.AttachmentList.Add(Commonlib.TempDir  + OutGoingFileName);
        ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
        if not EmailShortSendMode(lSilent, lSecret) then
          exit;
        if Corres.Execute(lSilent, lSecret) then begin
          TransactionID := GetInvDocNo(SaleID);
          UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
          EmailDate := Now;

          // ReportType already defined at start of procedure
          TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' + GetInvDocNo(SaleID) +
            ' for ' + GetClientName(ClientID);
          qryEmailedList := TERPQuery.Create(Self);
          qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
          try
            qryEmailedList.Sql.Clear;
            qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
              TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
              EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +
              '")');
            qryEmailedList.Execute;
          finally
            DeleteFiles( Commonlib.TempDir , '*.PDF');
            FreeandNil(qryEmailedList);
          end;
        end;
        ReportToPrint := '';
        DeleteFiles( Commonlib.TempDir , '*.PDF');
        DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
        (*lblProgress.*)Label8.Visible := false;
      finally
        Corres.Free;
      end;
    except
      (*lblProgress.*)Label8.Visible := false;
    end;
//  end;
end;

procedure TPrintStatement.FaxInvoice(SaleID, ClientID: integer);
var
  Fax: TFaxObj;
  FaxNo: String;
begin
  inherited;
  FaxNo := GetClientFaxNumber(ClientID);
  if Empty(FaxNo) then begin
    CommonLib.MessageDlgXP_Vista(GetClientName(ClientID) +
      ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
      'Please Review Customer information to Add an Fax Number.', mtWarning,
      [mbOK], 0);
  end else begin
    (*lblProgress.*)Label8.Visible := true;
    (*lblProgress.*)Label8.Caption := 'Adding to Fax Spool...';
    fsFax := true;
    PrintTemplateInv(SaleID, true, true, false, 'Invoice_' +
      GetSaleGlobalRef(SaleID));
    ReportToPrint := '';
    Fax := TFaxObj.Create;
    try
      Fax.NoCoverSheet := true;
      Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
        GetClientName(ClientID), FaxNo, 'Invoice', GetSaleGlobalRef(SaleID), '',
        ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
    finally
      FreeandNil(Fax);
    end;
    (*lblProgress.*)Label8.Visible := false;
    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
  end;
end;

procedure TPrintStatement.PrintTemplateInv(const SaleID: integer; const bPrint, bSave: boolean;
  const DoClose: boolean = true; const FileName: String = ''; ShowCancelPreviewBtninReportPreview :Boolean =False);
var
  sSQL: String;
begin
  ReportToPrint := tcdatautils.GetDefaultReport(11);

  sSQL := Format(' AND d2.%s = %d', ['SaleID', SaleID]); {MainSQL}

  if Sametext(Trim(ReportToPrint) ,'Invoice Grouped') or (sametext(Trim(reporttoPrint) , 'InvoiceGroup')) then begin
    sSQL := sSQL + ' AND d3.ProductName <>"Memo Only"' +
        ' GROUP By d2.SaleID,ProductID,d3.LinePrice,d3.UnitofMeasureSaleLines;'+
        '~|||~ and SaleId = '+inttostr(SaleID);{{ShippedProducts}
  end;
   if not(Sametext(ReportToPrint, 'Invoice with details')) then
        sSQL := sSQL +'~|||~ where TTC.SaleID = ' +inttostr(SaleID) +' group by TTCL.`SubTaxCode`'+ {TaxDetails}
        '~|||~ and Trans.SaleID = ' +inttostr(SaleID) ;{ClientCustomFields}

  sSQL := sSQL + '~|||~where S.SaleId = ' + inttostr(SaleID);{EarlyPayment}
  sSQL := sSQL + '~|||~Where  S.SaleId = ' + inttostr(SaleID);{ShippingAddress}
  sSQL := sSQL + '~|||~Where  SalesId = ' + inttostr(SaleID);{ShippingDetails}

  if not bSave then begin
    PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1, nil, '', ShowCancelPreviewBtninReportPreview);
  end else begin
    if Empty(FileName) then begin
      SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF');
    end else begin
      if fsFax then begin
        SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'GraphicFile',
          FileName);
      end else begin
        SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF', FileName);
      end;
    end;
  end;
  //ReportToPrint := '';
end;



procedure TPrintStatement.edtSearchChange(Sender: TObject);
var
  sFieldName: String;
begin
  sFieldName := FilterColumn;
  qryStatements.IndexFieldNames := '[' + sFieldName + '] ASC';
  dsStatements.Dataset.Locate(sFieldName, edtSearch.Text, [loCaseInsensitive,
    loPartialKey]);
end;

procedure TPrintStatement.btnAddFilterClick(Sender: TObject);
begin
  try
    flstFilter.Add('[' + grd.GetActiveField.FieldName + ']=' +
      QuotedStr(grd.GetActiveField.AsString));
  except
    on e: EStringListError do begin
      {raise Exception.Create('The value you are trying to add is already in your filter list. ' +
                             'Please try again.');}
      CommonLib.MessageDlgXP_Vista('The value you are trying to add is already in your filter list. ' +
        'Please try again.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TPrintStatement.btnExecuteClick(Sender: TObject);
begin
  SetQryStatementFilter;
end;

function TPrintStatement.GetFilterString: String;
var
  iIndex: integer;
  procedure Addfilter(Const sffilterStatement:String);
  begin
      if Result <> '' then Result := Result + ' AND ';
      Result := Result +sffilterStatement;
  end;
begin
  Result := '';
  for iIndex := 0 to flstFilter.Count - 1 do begin
    Result := Result + flstFilter.Strings[iIndex] + ' OR ' + Chr(13);
  end;
  if Result <> '' then begin
    Result := Copy(Result, 0, char_length(Result) - 5);
    Result := '(' + Result +')';
  end;
  if customerListFilter <> '' then AddFilter(customerListFilter);
  if chk0Balancecustomers.checked = False then begin
     Addfilter('totalamountdue <> 0');
  end;
end;

procedure TPrintStatement.btnClearClick(Sender: TObject);
begin
  flstFilter.Clear;
  customerListFilter:= '';
  SetQryStatementFilter;
end;

function TPrintStatement.GetReportTypeID: integer;
begin
  Result := 44;
end;

procedure TPrintStatement.dtToCloseUp(Sender: TObject);
begin
  inherited;
  if not dtTo.DroppedDown then begin
    if not (dtTo.DateTime = ToPrevDate) then begin
      PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
    end;
    ToPrevDate := dtTo.DateTime;
  end;
end;


procedure TPrintStatement.DateChange(var Message: TMessage);
begin
  RefreshQuery;
end;

procedure TPrintStatement.dtToChange(Sender: TObject);
begin
  inherited;
  if not dtTo.DroppedDown then begin
    if not (dtTo.DateTime = ToPrevDate) then begin
      PostMessage(self.Handle, SX_DatechangeMsg, 0, 0);
    end;
    ToPrevDate := dtTo.DateTime;
  end;
end;

procedure TPrintStatement.grdCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' ASC', qryStatements.IndexFieldNames) > 0 then begin
    TitleImageAttributes.ImageIndex := 0;
  end else if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' DESC', qryStatements.IndexFieldNames) > 0 then begin
    TitleImageAttributes.ImageIndex := 1;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TPrintStatement.grdTitleButtonClick(Sender: TObject; AFieldName: String);
begin
  inherited;
  if (qryStatements.FieldByName(AFieldName).FieldKind <> fkLookup) and
    (qryStatements.FieldByName(AFieldName).FieldKind <> fkCalculated) then begin
    if FastFuncs.PosEx('[' + AFieldName + ']' + ' ASC', qryStatements.IndexFieldNames) <> 0 then begin
      qryStatements.IndexFieldNames := '[' + AFieldName + ']' + ' DESC';
    end else begin
      qryStatements.IndexFieldNames := '[' + AFieldName + ']' + ' ASC';
    end;
  end;
end;

//procedure TPrintStatement.btnPreviewClick(Sender: TObject);
procedure TPrintSTatement.actPrintReport(aDestination : TPrintDestination);
var
  i: integer;
  SavedPrintDialogPref:boolean;
  ContinueResult: word;
  ClientDefaultcontactMethod:TDefaultcontactMethod;
  lSilent,
  lSecret : boolean;

  function StringtoDefaultcontactMethod(const Value:String):TDefaultcontactMethod;
  begin
    Result := dcmNone;
         if sameText(Value , 'Email') then Result := dcmEmail
    else if sameText(Value , 'Fax') then Result := dcmFax
    else if sameText(Value , 'Print') then Result := dcmPrint
    else if sameText(Value , 'Phone') then Result := dcmPhone
    else if sameText(Value , 'Mobile') then Result := dcmMobile
    else if sameText(Value , 'Visit') then Result := dcmVisit
  end;
  function toBeEmailed:Boolean;
  begin
    Result := False;
//    if (Sender = btnSend) and ((ClientDefaultcontactMethod<=dcmEmail) or (ClientDefaultcontactMethod>=dcmPhone))  then Result:= True
//    else if Sender = btnEmail then Result := True;
    if aDestination = csEmail then
      Result := True
    else
      if (aDestination = csSend) and ((ClientDefaultcontactMethod<=dcmEmail) or (ClientDefaultcontactMethod>=dcmPhone))  then
        Result:= True;
  end;

  function toBeFaxed:Boolean;
  begin
    Result := False;
    if (aDestination = csSend) and ((ClientDefaultcontactMethod<=dcmFax) or (ClientDefaultcontactMethod>=dcmPhone))  then Result:= True
    else if aDestination = csFax then Result := True;
  end;

  function ToBePrinted:Boolean;
  begin
    Result := False;
    if (aDestination = csSend) then Result:= True
    else if aDestination = csPrint then Result := True;
  end;

  function SetupEmailMode() : boolean;
  var
    idx : integer;
    Count : integer;
  begin
    Count := 0;
    for idx := 0 to grd.SelectedList.Count - 1 do
    begin
      qryStatements.GotoBookmark(grd.SelectedList.Items[idx]);
      if (qryStatements.FieldByName('Email').AsString <> '') and toBeEmailed then
        Count := Count + 1;
    end;
    if Count = 0 then
    begin
      MessageDlgXP_Vista('Neither Of Selected Clients Has an Email Address.'#13#10'Cannot Email', mtWarning, [mbOk], 0);
      Result := false;
      exit;
    end;
    Result := EmailSilentSecret(Count, false, lSilent, lSecret);
  end;

begin
  DisableForm;
  SavedPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
  try
    if (aDestination = csSend) then
      self.AddFlag('AutoSend')
    else
      self.RemoveFlag('AutoSend');

    self.RemoveFlag('YesToAll');
    self.RemoveFlag('NoToAll');
    self.RemoveFlag('PrintAll');
 (*
    // If we have no statements to print then out we go.
    if qryStatements.RecordCount = 0 then
      Exit;

    if grd.SelectedList.Count = 0 then begin
        commonlib.MessageDlgXP_Vista('Please select the customer', mtWarning, [mbOK], 0) ;
        Exit;
    end;

    if (grd.SelectedList.Count > 1)  and toBeEmailed() then
    begin
      if CommonLib.MessageDlgXP_Vista('Email is Selected,' + NL +'All Selected Statements Will be Emailed to The Customers.'+NL+NL+'Do you Wish to Continue?',mtconfirmation,[mbyes,mbNo],0) = mrno then
        exit;
    end;

*)
    bEscapeEmails := False;

    lSilent := false;  // make compiler happy
    lSecret := false;
    if (grd.SelectedList.Count > 0) and ((aDestination = csEmail) or (aDestination = csSend)) then
    begin
      if not SetupEmailMode() then
        exit;
    end;


    DoshowProgressbar(grd.SelectedList.Count , WAITMSG);
    try
      ProgressDialogInst.top := Self.top+self.height;
      ReportToPrint := '';
      ContinueResult:= 0;
      PrintTemplate.UseEmployeeShowPrintDialogPref := AppEnv.Employee.ShowPrintDialog;
      for i := 0 to grd.SelectedList.Count - 1 do begin
        if bEscapeEmails = true then begin
          exit;
        end;
        qryStatements.GotoBookmark(grd.SelectedList.Items[i]);
        fsFax := false;
        ClientID := qryStatements.FieldByName('ClientID').AsInteger;
        ClientDefaultcontactMethod:= StringtoDefaultcontactMethod(tcdatautils.ClientdefaultContactMethod(ClientID));
{------}if (toBeEmailed) and (ClientcontactEmailID(qryStatementsClientID.asInteger , ctMainContactforStatements)<> '') then begin
              PrintStatements(ClientID,false, false, true, false, lSilent, lSecret);
{------}end else if  (toBeFaxed) and (GetClientFaxNumber(qryStatementsClientID.asInteger)<>'') then begin
          PrintStatements(ClientID,false, true, false, false);
{------}end else if  tobePrinted  then begin
          PrintStatements(ClientID,true, false, false, false);
{------}end else if  tobeEmailed  then begin
          PrintStatements(clientID,false, false, true, false, lSilent, lSecret);
{------}end else if  aDestination = csPDF then begin
          PrintStatements(clientID,false, false, False, False, lSilent, lSecret, true);
{------}end else if aDestination = csPreview then begin
          PrintStatements(ClientID, false, false, false, false);
          if (i < (grd.SelectedList.Count - 1)) and (ContinueResult <> 100) then begin
            ContinueResult:= CommonLib.MessageDlgXP_Vista('Continue?', mtConfirmation, [mbYes, mbNo, mbYesToAll], 0);
            if ContinueResult = mrNo then break;
          end;
{------}end else if aDestination = csExport then begin
          ClientID := qryStatementsClientID.AsInteger;
          PrintStatements(clientID,false, false, false, true);
{------}end;
        PrintTemplate.UseEmployeeShowPrintDialogPref := False;
      end;

      if ExportToFile then begin
        if SaveDialog1.Execute then begin
          memExportALL.SaveToFile(SaveDialog1.FileName);
          ExportToFile := false;
          ExportStructureDone := false;
        end;
      end;
    finally
        DoHideProgressbar;
    end;
  finally
    EnableForm;
    AppEnv.Employee.ShowPrintDialog := SavedPrintDialogPref;
  end;
end;

//procedure TPrintStatement.actSchedule(Sender: TObject);
//begin
//  OpenERPForm('TfmSchedulereports' , 0 , nil , initreportName);
//end;

procedure TPrintStatement.actSMS(Sender: TObject);
begin
  actPrintReport(csSMS);
end;

procedure TPrintStatement.btnReportClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
    GuiPrefs.Node['Options.confrimfileOpen'].asBoolean := true;
    // If we have no statements to print then out we go.
    if qryStatements.RecordCount = 0 then Exit;
    if grd.SelectedList.Count = 0 then begin
      commonlib.MessageDlgXP_Vista('Please select the customer', mtWarning, [mbOK], 0) ;
      Exit;
    end;

  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.Add('Preview', 'Preview Statement(s)', actPreview, true, true, true);
    OptsForm.ActionList.Add('Print', 'Print Statement(s)', actPrint, true, true, true);
    OptsForm.ActionList.Add('Email', 'Email Statement(s)', actEmail, true, true, true);
    OptsForm.ActionList.Add('SMS', 'Send Statement(s) Via SMS', actSMS, true, true,true);
    OptsForm.ActionList.Add('Save PDF', 'Save a PDF Sales Order to your computer', SaveTransToPDF, true, true);
    if GetClientFaxNumber(qryStatementsClientID.asInteger)<>'' then
      OptsForm.ActionList.Add('Fax', 'Fax Statement(s)', actFax, true, false, true)
    else
      OptsForm.ActionList.Add('Fax', 'Fax Statement(s)', actFax, true, true, true);
//    OptsForm.ActionList.Add('Schedule', 'Schedule the Statement', actSchedule, true, true, false);
    OptsForm.ShowModal;
  finally
    OptsForm.Free;
  end;
end;
function TPrintStatement.SaveTransToPDF: boolean;
begin
    actPrintReport(csPDF);
    Result := True;
end;
function TPrintStatement.DoSaveTransToPDF(Const fiClientID:Integer): boolean;
var
  filename :String;
  msgoption : Word;
begin
  inherited;
  Result:= False;
  SaveDialog1.FileName := StrToValidFileName('Statement - ' + getClientName(fiClientID) +'.PDF');
  if SaveDialog1.Execute then begin
    filename :=  SaveDialog1.FileName;
  end else begin
    Exit;
  end;
  if SaveTemplateReport(ReportToPrint, SQLFINAL, False, 'PDF', FileName) then begin
    if not(GuiPrefs.Node.Exists('Options.confrimfileOpen')) or (GuiPrefs.Node['Options.confrimfileOpen'].asBoolean) then begin
          msgoption := MessageDlgXP_Vista('The report is exported to ' + Quotedstr(FileName), mtInformation, [mbOK], 0 , nil , '' , '' , False, nil , 'Open File Location,Open File,Don''t Ask');
               if msgoption = 100 then ShellExecute(Handle, 'Open', PChar(ExtractFilePath(fileName)) , '', '', SW_SHOWNORMAL)
          else if msgoption = 101 then ShellExecute(Handle, 'Open', PChar(fileName) , '', '', SW_SHOWNORMAL)
          else if msgoption = 102 then  GuiPrefs.Node['Options.confrimfileOpen'].asBoolean := false;
          Result:= True;
    end;
  end;
end;

procedure TPrintStatement.btnSMSClick(Sender: TObject);
var
  i: integer;
  qry: TERPQuery;
  mblNumber: string;
  SL: TStringList;
begin
  DisableForm;
  try
    (*
    // If we have no statements to print then out we go.
    if qryStatements.RecordCount = 0 then Exit;
    if grd.SelectedList.Count = 0 then begin
      commonlib.MessageDlgXP_Vista('Please select the customer', mtWarning, [mbOK], 0) ;
      Exit;
    end;
    *)
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    SL := TStringList.Create;
    try
      qry.SQL.Add('select tblclients.Company, tblclients.Mobile, tblcontacts.ContactMOB from tblclients');
      qry.SQL.Add('left join tblcontacts on tblclients.ClientID = tblcontacts.ClientID and tblcontacts.IsPrimarycontact = "T"');
      qry.SQL.Add('where tblclients.clientid = :clientid');
      bEscapeEmails := False;

      DoshowProgressbar(grd.SelectedList.Count , WAITMSG);
      try
        for i := 0 to grd.SelectedList.Count - 1 do begin
          qryStatements.GotoBookmark(grd.SelectedList.Items[i]);
          ClientID := qryStatements.FieldByName('ClientID').AsInteger;
          SL.Values['#Balance#'] := FloatToStrF(qryStatementsARBalance.AsFloat, ffCurrency, 15, 2);
          SL.Values['#Company#'] := qryStatementsCompanyName.AsString;
          mblNumber := '';
          qry.ParamByName('clientid').AsInteger := ClientId;
          qry.Open;
          try
            if qry.FieldByName('ContactMob').AsString <> '' then
              mblNumber := qry.FieldByName('ContactMob').AsString
            else if qry.FieldByName('Mobile').AsString <> '' then
              mblNumber := qry.FieldByName('Mobile').AsString
            else
              mblNumber := '[Mobile for ' + qry.FieldByName('Company').AsString + ']';
          finally
            qry.Close;
          end;
          TCorrespondenceGui.SMSCustomer(mblNumber,TMailUtils.SubstituteText(AppEnv.CompanyPrefs.PrintStatementsSMSText, SL),ClientID);
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
      SL.Free;
    end;
  finally
    EnableForm;
  end;
end;

procedure TPrintStatement.EmailStatement(const ClientID: integer;  const ASilent : boolean = false; const ASecret : boolean = false);
var
  qryEmailedList: TERPCommand;
  TransactionID, UserID, TransactionDescription: String;
  EmailDate: TDateTime;
  RecipientAddress: String;
  OutGoingFileName: String;
  sBody: String;
  Corres: TCorrespondenceGui;
begin
    RecipientAddress := GetContactEmails(ClientId, 'MainContactForStatements');


    OutGoingFileName :=  Commonlib.TempDir  + getOutGoingFileName('' ,FormatDateTime(MysqlDateFormat, Now) + ' from ' +
                       replacestr(GetCompanyName , '/' , '')  ,'.PDF');
    if FileExists(OutGoingFileName) then begin
      DeleteFile(OutGoingFileName);
      Sleep(100);
    end;
    if IsrunningBalanceReport(ReportToPrint) then
      SaveTemplateReport(ReportToPrint, '{Clientdetails}' +SQLFINAL , false, 'PDF',OutGoingFileName)
    else
      SaveTemplateReport(ReportToPrint, '{Statements}' +SQLFINAL , false, 'PDF',OutGoingFileName);
    Sleep(100);
    if not FileExists(OutGoingFileName) then Begin
      CommonLib.MessageDlgXP_Vista('Attachment could not be found. This is probably caused by a problem with the template. Please check the template and try again.', mtInformation , [mbOK], 0);
      Exit;
    end;

    Label8.Caption := 'Emailing, ' + WAITMSG;
    try
      if AppEnv.Employee.UseEmpEmailAsFromAddress = True then begin
        sBody := '';
      end else begin
         sBody := 'The sender does not have an individual email address.';
      end;

      Label8.Visible := true;
      (*
      btnPrint.Enabled := false;
      btnPreview.Enabled := false;
      btnEmail.Enabled := false;
      btnClose.Enabled := false;
      btnFax.Enabled := false;
      btnSend.Enabled := false;
      *)
      btnReport.Enabled := false;

      Corres := TCorrespondenceGui.Create;
      try
        Corres.Subject := 'Statement from ' + GetCompanyName;
        Corres.RecipientList := RecipientAddress;
        Corres.CustomerId := ClientId;
        Corres.MessageText := 'This Statement has been sent to you from ' + GetCompanyName + '. ' + sBody;
        Corres.AttachmentList.Add(OutGoingFileName);
        if Corres.Execute(ASilent, ASecret) then begin
          TransactionID := 'Statement, ' + FormatDateTime(MysqlDateFormat, Now);
          UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
          EmailDate := Now;

          // ReportType already defined at start of procedure
          TransactionDescription := GetCompanyName + ' Statement for ' + GetClientName(ClientID);
          qryEmailedList := TERPCommand.Create(Self);
          qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
          try
            qryEmailedList.Sql.Clear;
            qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports ( UserID, Date, ReportType, TransactionDescription) Values (' +
              QuotedStr(UserID) + ',' + QuotedStr(FormatDateTime(MysqlDateFormat,EmailDate)) +
              ',"Statement",' + QuotedStr(TransactionDescription) + ')');
            qryEmailedList.Execute;
          finally
            FreeandNil(qryEmailedList);
          end;
        end;
      finally
        Corres.Free;
      end;

      Label8.Visible := false;
      (*
      btnPrint.Enabled := true;
      btnPreview.Enabled := true;
      btnEmail.Enabled := true;
      btnClose.Enabled := true;
      btnFax.Enabled := true;
      btnSend.Enabled := true;
      *)
      btnReport.Enabled := true;
      DeleteFiles( Commonlib.TempDir , '*.PDF');

    except
      if CommonLib.MessageDlgXP_Vista(GetClientName(ClientID) + #10 + #13 +
        'Unfortunately an error occured whilst connecting and sending this email. ' + #10 + #13 +
        'This may be an internet server error or a problem with your email setup options.' + #10 + #13 +
        'Please try again later or check configuration.' + #10 + #13 + #10 + #13 +
        'Do you want to stop emailing now?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
        begin
          Label8.Visible := false;
          (*
          btnPrint.Enabled := true;
          btnPreview.Enabled := true;
          btnEmail.Enabled := true;
          btnClose.Enabled := true;
          btnFax.Enabled := true;
          btnSend.Enabled := true;
          *)
          btnReport.Enabled := true;
          DeleteFiles( Commonlib.TempDir , '*.PDF');
          bEscapeEmails := True;
          btnUnselect.Click;
        end;
    end;
  //end;
end;

procedure TPrintStatement.FaxStatement(const ClientID: integer);
var
  Fax: TFaxObj;
  FaxNo: String;
  tmpClientName: String;
begin
  inherited;
  FaxNo := GetClientFaxNumber(qryStatements.FieldByName('ClientID').AsInteger);
  if Empty(FaxNo) then begin
    CommonLib.MessageDlgXP_Vista(qryStatements.FieldByName('Companyname').AsString +
      ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
      'Please Review Customer information to Add an Fax Number.', mtWarning,
      [mbOK], 0);
  end else begin
    Label8.Visible := true;
    Label8.Caption := 'Adding to Fax Spool...';
    fsFax          := true;
    tmpClientName  :=
      ReplaceStr(ReplaceStr(ReplaceStr(ReplaceStr(ReplaceStr(ReplaceStr
      (ReplaceStr(ReplaceStr(ReplaceStr(qryStatements.FieldByName('Companyname').AsString, '\', ''), '/', ''), ':', ''), '*', ''),
      '?', ''), '"', ''), '<', ''), '>', ''), '|', '');
    SaveTemplateReport(ReportToPrint, '{Statements}' +SQLFINAL , false,
      'GraphicFile', 'Statement_' + tmpClientName,nil); // ####
    Fax := TFaxObj.Create;
    try
      Fax.NoCoverSheet := true;
      Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
        qryStatements.FieldByName('Companyname').AsString, FaxNo, 'Statement', '', '',
        ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
    finally
      FreeandNil(Fax);
    end;
    Label8.Visible := false;
    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
  end;
end;

procedure TPrintStatement.chkAllClassClick(Sender: TObject);
begin
  inherited;
//  if IsAllClassSelected = True then begin
  if chkAllClass.Checked then
    cboClass.Enabled := False
  else begin
    cboClass.Enabled := True;
  end;
  RefreshQuery;
end;

procedure TPrintStatement.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TPrintStatement.MakeQRY;
var
  sl: TStringList;
  tmptablename1: String;
  tmpfilename1: String;
  tmptablename2: String;
  tmpfilename2: String;
  tmpfilename3: String;
  tmpfilename4: String;
  grouping: String;
begin
  sl := TStringList.Create;
  try
    sl.Add('DROP TABLE IF EXISTS ' + fsTempSalesTable + ';');
    sl.Add('CREATE TABLE ' + fsTempSalesTable);
    sl.Add('SELECT SaleId, ' + SalesBalance('tblsales') + ' AS Balance, ClientID from tblsales');
    sl.Add('WHERE tblsales.SaleDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime)));
    sl.Add('AND tblsales.ClassId IN (' + GetALLClassFilterString + ')');
    sl.Add('AND (' + SalesType + ')');
    sl.Add('AND (converted = "F" or IsInvoice = "T");');
    sl.Add('ALTER TABLE ' + fsTempSalesTable + ' ADD COLUMN `ParentClientID` INT(10) NULL;');
    sl.Add('ALTER TABLE ' + fsTempSalesTable + ' ADD COLUMN `MasterClientID` INT(10) NULL;');
    sl.Add('ALTER TABLE ' + fsTempSalesTable + ' ADD INDEX ClientIdIdx (ClientID);');
    sl.Add('ALTER TABLE ' + fsTempSalesTable + ' ADD INDEX ParentClientIDIdx (ParentClientID);');
    sl.Add('ALTER TABLE ' + fsTempSalesTable + ' ADD INDEX MasterClientIDIdx (MasterClientID);');
    tmptablename1 := Self.Classname + '1';
    tmptablename2 := Self.Classname + '2';
    sl.Add(SQLfortemptable('tblclients', 'ParentClientID', '', 'INNER JOIN ' + fsTempSalesTable + ' T on  M.ClientID = T.ClientID', tmptablename1,tmpfilename1, GetSharedMydacConnection));
    sl.Add('UPDATE ' + fsTempSalesTable + ' T inner join '+tmptablename1+' C on  T.ClientID = C.ClientID set T.ParentClientID = C.ParentClientID;');
    sl.Add(SQLfortemptable('tblrelatedclients', 'ChildClientID,MasterClientID', '', 'INNER JOIN '+fsTempSalesTable + ' T on  M.ChildClientID = T.ClientID', tmptablename2,tmpfilename2, GetSharedMydacConnection));
    sl.Add('UPDATE ' + fsTempSalesTable + ' T inner join '+tmptablename2+' RC on  T.ClientID = RC.ChildClientID set T.MasterClientID = RC.MasterClientID;');

    sl.Add('DROP TABLE IF EXISTS ' + fsTempSalesLinesTable + ';');
    sl.Add('CREATE TABLE ' + fsTempSalesLinesTable);
    sl.Add('SELECT SaleLineId, QtySold, LinePriceInc, Shipped, ClientID, BOID, IsInvoice, IsSalesOrder from tblsaleslines, tblsales');
    sl.Add('WHERE tblsaleslines.SaleID = tblsales.SaleID');
    sl.Add('AND tblsales.SaleDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.DateTime)));
    sl.Add('AND tblsales.ClassId IN (' + GetALLClassFilterString + ')');
//    sl.Add('and (' + SalesType +')');
    sl.Add('AND (converted = "F" or IsInvoice ="T");');
    sl.Add('ALTER TABLE ' + fsTempSalesLinesTable + ' ADD COLUMN `ParentClientID` INT(10) NULL;');
    sl.Add('ALTER TABLE ' + fsTempSalesLinesTable + ' ADD COLUMN `MasterClientID` INT(10) NULL;');
    sl.Add('ALTER TABLE ' + fsTempSalesLinesTable + ' ADD INDEX ClientIdIdx (ClientID);');
    sl.Add('ALTER TABLE ' + fsTempSalesLinesTable + ' ADD INDEX ParentClientIDIdx (ParentClientID);');
    sl.Add('ALTER TABLE ' + fsTempSalesLinesTable + ' ADD INDEX MasterClientIDIdx (MasterClientID);');
    (*sl.Add('update ' + fsTempSalesLinesTable + ' T inner join tblClients C on  T.ClientID = C.ClientID set T.ParentClientID = C.ParentClientID;');
    sl.Add('update ' + fsTempSalesLinesTable + ' T inner join tblrelatedclients RC on  T.ClientID = RC.ChildClientID set T.MasterClientID = RC.MasterClientID;');*)
    tmptablename1:= Self.Classname + '3';
    tmptablename2:= Self.Classname + '4';
    sl.Add(SQLfortemptable('tblclients', 'ParentClientID','' , 'inner join '+fsTempSalesLinesTable + ' T on  M.ClientID = T.ClientID', tmptablename1,tmpfilename3, GetSharedMydacConnection));
    sl.Add('UPDATE ' + fsTempSalesLinesTable + ' T inner join '+tmptablename1+' C on  T.ClientID = C.ClientID set T.ParentClientID = C.ParentClientID;');
    sl.Add(SQLfortemptable('tblrelatedclients', 'ChildClientID,MasterClientID','' , 'inner join '+fsTempSalesLinesTable + ' T on  M.ChildClientID = T.ClientID', tmptablename2,tmpfilename4, GetSharedMydacConnection));
    sl.Add('UPDATE ' + fsTempSalesLinesTable + ' T inner join '+tmptablename2+' RC on  T.ClientID = RC.ChildClientID set T.MasterClientID = RC.MasterClientID;');

    {Salessum table}
    SL.Add('DROP TABLE IF EXISTS ' + tablenameSalesSum + ';');
    SL.Add('CREATE TABLE '+ tablenameSalesSum );
    Sl.Add(' SELECT ClientId, SUM(ifnull(Balance, 0)) AS Balance ');
    SL.Add('FROM  ' + fsTempSalesTable + ' T');
    Sl.Add(' GROUP BY ClientId; ');

    {boinvsum if required}
    Sl.Add('ALTER TABLE   '+ tablenameSalesSum + ' ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`ID`),  ADD INDEX `clientId` (`clientId`);');
    if (chkincludeinvoiceBO.checked)  then begin
      SL.Add('DROP TABLE IF EXIST ' + tablenameBOInvsum + ';');
      SL.Add('Create table '+ tablenameBOInvsum +'');
      SL.Add('SELECT ClientId, sum(ifnull(QtySold,0) * ifnull(LinePriceInc,0)) as Balance');
      SL.Add('FROM  ' + fsTempSalesLinesTable + ' T ');
      SL.Add('WHERE IFNULL(shipped, 0) = 0  AND IFNULL(BOID, "") = "" and IsInvoice = "T"');
      SL.Add('GROUP BY ClientId ;');
      Sl.Add('ALTER TABLE   '+ tablenameBOInvsum + ' ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`ID`),  ADD INDEX `clientId` (`clientId`);');
    end;
    {BOSOSum if required}
    if (chkincludeSOBO.Checked) then begin
      SL.Add('DROP TABLE IF EXISTS  '+ tablenameBOSOsum +';');
      SL.Add('CREATE TABLE '+ tablenameBOSOsum +'');
      SL.Add('SELECT ClientId  ,sum(ifnull(QtySold,0) * ifnull(LinePriceInc,0)) as Balance');
      SL.Add('FROM ' + fsTempSalesLinesTable+' T ');
      SL.Add('WHERE IFNULL(shipped, 0) = 0  and ifnull(BOID, "") = "" and IsSalesOrder = "T"');
      SL.Add('GROUP BY ClientId; ');
      Sl.Add('ALTER TABLE ' + tablenameBOSOsum +' ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`ID`),  ADD INDEX `clientId` (`clientId`);');
    end;
    SL.Add('DROP TABLE IF EXISTS '+ tablenamePrepaySum +';');
    SL.Add('CREATE TABLE '+ tablenamePrepaySum );
    SL.Add('SELECT clientId,sum(ifnull(Balance, 0)) as Balance   ');
    SL.Add('FROM tblprepayments  ');
    SL.Add('WHERE Deleted = "F" ');
    sl.Add('AND ClassId in (' + GetALLClassFilterString +')');
    SL.Add('GROUP BY clientID;');
    Sl.Add('ALTER TABLE   '+ tablenamePrepaySum + ' ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`ID`),  ADD INDEX `clientId` (`clientId`);');
    DoshowProgressbar(30, WAITMSG);
    try
      clog(sl.Text);
      ExecuteSQL(sl.Text, nil, DobeforeExecuteScript);
    finally
      DoHideProgressbar;
      AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename1, '.tmp', '*.tmp'));
      AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename2, '.tmp', '*.tmp'));
      AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename3, '.tmp', '*.tmp'));
      AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename4, '.tmp', '*.tmp'));
      CommonDbLib.DestroyUserTemporaryTable(tmptablename1);
      CommonDbLib.DestroyUserTemporaryTable(tmptablename2);
    end;
  finally
    sl.Free;
  end;

  Application.ProcessMessages;
  with qryStatements do begin
    Active := false;
    try
      with SQL do begin
        Clear;
        Add('SELECT');
        Add('if(c.clientId = ' +intToStr(ARClientID)+' , C.ClientId , if(c.clientId =' + intToStr(xClientID)+', c.ClientID, 0)) as tclientID,');

        Add('C.GlobalRef as GlobalRef,');
        if chkRelatedCustomer.checked then begin
          Add('if(IfNull(c.ParentRelatedClientID,0) <> 0, SUBSTRING_INDEX(C2.Company,"^",1), SUBSTRING_INDEX(C.Company,"^",1)) as CompanyName,');
          Add('if(IfNull(c.ParentRelatedClientID,0) <> 0, IfNull(CT2.TypeName,""), IfNull(CT.TypeName,"")) as TypeName,');
          Add('Convert(IfNull(C2.ClientID,C.ClientID),unsigned) as ClientID,');
        end
        else if chkGroupJobs.Checked then begin
          Add('SUBSTRING_INDEX(C.Company,"^",1) as CompanyName,');
          Add('IfNull(CT3.TypeName,IfNull(CT.TypeName,"")) as TypeName,');
          Add('Convert(IfNull(C3.ClientID,C.ClientID),unsigned) as ClientID,');
        end
        else begin
          Add('SUBSTRING_INDEX(C.Company,"^",1) as CompanyName,');
          Add('IfNull(CT.TypeName,"") as TypeName,');
          Add('Convert(C.ClientID,unsigned) AS ClientID,');
        end;
        Add('C.StopCredit,');
        Add('C.JobName AS JobName,');
        Add('C.JobNumber AS JobNumber,');
        Add('C.SerialNumber AS "Serial #",');
        Add('C.ModelNumber AS "Model #",');
        Add('C.Manufacture AS "Manufacture",');
        Add('C.ARBalance AS "AR Balance",');
        Add('C.APBalance AS "AP Balance",');
        Add('C.Balance AS Balance,');
        Add('C.FirstName as Firstname,');
        Add('C.MiddleName AS MiddleName,');
        Add('C.LastName as LastName,');
        Add('C.Email AS Email,');
        Add('C.Street AS Street,');
        Add('C.Street2 AS Street2,');
        Add('C.Street3 AS Street3,');
        Add('C.Suburb AS Suburb,');
        Add('C.State AS State,');
        Add('C.Postcode AS Postcode,');
        Add('C.Country AS Country,');
        (*Add('C.Phone AS Phone,');
        Add('C.FaxNumber AS FaxNumber,');
        Add('C.Mobile AS Mobile,');
        Add('C.AltContact AS AltContact,');
        Add('C.AltPhone AS AltPhone,');
        Add('C.BillStreet AS BillStreet,');
        Add('C.BillStreet2 AS BillStreet2,');
        Add('C.BillStreet3 AS BillStreet3,');
        Add('C.BillSuburb AS BillSuburb,');
        Add('C.BillState AS BillState,');
        Add('C.BillPostcode AS BillPostcode,');
        Add('C.BillCountry AS BillCountry,');
        Add('C.ClientNo as AccountNo,');
        Add('C.CUSTFLD1 AS CUSTFLD1,');
        Add('C.CUSTFLD2 AS CUSTFLD2,');
        Add('C.CUSTFLD3 AS CUSTFLD3,');
        Add('C.CUSTFLD4 AS CUSTFLD4,');
        Add('C.CUSTFLD5 AS CUSTFLD5,');
        Add('C.CUSTFLD6 AS CUSTFLD6,');
        Add('C.CUSTFLD7 AS CUSTFLD7,');
        Add('C.CUSTFLD8 AS CUSTFLD8,');
        Add('C.CUSTFLD9 AS CUSTFLD9,');
        Add('C.CUSTFLD10 AS CUSTFLD10,');
        Add('C.CUSTFLD11 AS CUSTFLD11,');
        Add('C.CUSTFLD12 AS CUSTFLD12,');
        Add('C.CUSTFLD13 AS CUSTFLD13,');
        Add('C.CUSTFLD14 AS CUSTFLD14,');
        Add('C.CUSTFLD15 AS CUSTFLD15,');
        Add('C.CUSTDATE1 AS CUSTDATE1,');
        Add('C.CUSTDATE2 AS CUSTDATE2,');
        Add('C.CUSTDATE3 AS CUSTDATE3,');*)
        Add('C.IsJob AS IsJob,');
        Add('C.Active AS Active,');
  //      Add('C.ClientID AS ClientID,');
        Add('C.ParentClientID AS ParentClientID,');
        Add('C.ParentRelatedClientID AS ParentRelatedClientID,');
        (*Add('C.CreditLimit AS CreditLimit,');
        Add('C.TermsID AS TermsID,');
        Add('C.GracePeriod AS GracePeriod,');
        Add('C.PickingPriority AS PickingPriority,');
        Add('C.DefaultClass AS DefaultClass,');
        Add('C.Area AS Area,');
        Add('C.CardNumber AS CardNumber,');
        Add('C.DischargeDate AS DischargeDate,');
        Add('C.CreationDate AS CreationDate,');
        Add('C.CreditCardType AS CreditCardType,');
        Add('C.CreditCardNumber AS CreditCardNumber,');
        Add('C.CreditCardExpiryDate AS CreditCardExpiryDate,');
        Add('C.CreditCardNotes AS CreditCardNotes,');
        Add('C.ABN AS ABN,');*)
        Add('C.SOBalance AS SOBalance,');
        Add('Sum(tsales.balance) as  Salessum,');
        if (chkincludeinvoiceBO.checked)  then Add('Sum(tboinv.balance) as  BOINVSum,') else Add(' 0.0 as BOINVSum,');
        if (chkincludeSOBO.checked)       then Add('Sum(tboSO.balance) as  BOSOSum,')   else Add(' 0.0 as BOSOSum,');
        Add('Sum(tprepay.balance) as  PrepaySum');
        Add('FROM');
        Add('`tblclients` AS `C`');
        Add('Left Join tblclienttype AS CT ON C.ClientTypeID = CT.ClientTypeID');
        Add('Left Join ' + tablenameSalesSum +' tsales on tsales.ClientId = C.ClientId');
        if (chkincludeinvoiceBO.checked)  then Add('Left Join ' + tablenameBOInvsum +' tboinv on tboinv.ClientId = C.ClientId');
        if (chkincludeSOBO.checked)  then Add('Left Join ' + tablenameBOSOsum +' tboSO on tboSO.ClientId = C.ClientId');
        Add('Left Join ' + tablenamePrepaySum +' tprepay on tprepay.ClientId = C.ClientId');
        Add('Left Join tblClients C2 ON C.ParentRelatedClientID = C2.ClientID');
        Add('Left Join tblClients C3 ON C.ParentClientID = C3.ClientID');
        Add('Left Join tblclienttype AS CT2 ON C2.ClientTypeID = CT2.ClientTypeID');
        Add('Left Join tblclienttype AS CT3 ON C3.ClientTypeID = CT3.ClientTypeID');

        Add('WHERE (C.Customer = "T"  or C.IsJob = "T") AND char_length(C.Company)>0');
        if xClientId > 0 then begin
            add(' and (C.ClientId in (' + intToStr(xClientID) +') ');
            Add(' or ifnull(C.ParentclientID,0) =' + intToStr(xClientID));
            Add(' or ifnull(C.ParentRelatedclientId,0) =' + intToStr(xClientID) +')');
        end else if ARClientID > 0 then  begin
            add(' and (   C.ClientId in (' + intToStr(ARClientID) +') ');
            if  not chkGroupJobs.checked then Add(' or ifnull(C.ParentclientID,0) =' + intToStr(ARClientID) +'');
            if  not chkRelatedCustomer.checked then Add(' or ifnull(C.ParentRelatedclientId,0) =' + intToStr(ARClientID) +'');
            add(')');
        end;
  //      Add('group by TypeName,CompanyName');

        grouping := '';
        if chkGroupType.Checked then
          grouping := 'GROUP BY CT.TypeName';
        if chkGroupJobs.Checked then begin
          if grouping = '' then grouping := 'GROUP BY '
          else grouping := grouping  + ', ';
          grouping := grouping + SplitField('C', 'Company' , 1);
        end else begin
          if grouping = '' then grouping := 'GROUP BY '
          else grouping := grouping  + ', ';
          if chkRelatedCustomer.checked then
            grouping := grouping + 'CompanyName '
          else
            grouping := grouping + 'C.company ';
        end;
        Add(grouping);
        Add('ORDER BY tclientID desc, CompanyName');
      end;
    finally
      Active := True;
    end;
//    SQL.SaveToFile('c:\temp\temp.sql');
  end;
  SetQryStatementFilter;
end;

(*procedure TPrintStatement.InitReportName(Sender: TObject);
begin
  TfmSchedulereports(Sender).ERPFormName := 'TPrintStatement';
end;*)


function TPrintStatement.GetALLClassFilterString: String;
var
  FilterStr: String;
begin
  FilterStr := '';

  InitStatementParams;
  if IsAllClassselected  then begin
    If not cboClassQry.Active then cboClassQry.Open;
    cboClassQry.First;
    While cboClassQry.Eof = False do begin
      if FilterStr <> '' then FilterStr := FilterStr + ',';
      FilterStr := FilterStr + cboClassQry.FieldByName('ClassID').AsString;
      cboClassQry.Next;
    end;
  end else begin
      FilterStr := cboClassQry.FieldByName('ClassID').AsString;
  end;
  Result := FilterStr; // Copy(FilterStr, 0, char_length(FilterStr) - 14);
end;

procedure TPrintStatement.grdCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if qryStatementsStopCredit.AsBoolean then begin
    AFont.Color := clRed;
  end;

  if (edtSearch.Text <> '') then begin
    if not (gdSelected in State) and not Empty(FilterColumn) and
      (FastFuncs.PosEx(uppercase(edtSearch.Text),
      uppercase(qryStatements.FieldByName(FilterColumn).AsString)) = 1) then begin
      ABrush.Color := HIGHLIGHTLOCATE;
    end;
  end;
  if xClientId <> 0 then
    if qryStatementsClientID.asInteger = xclientId then Afont.Color := ClRed;
  if ARclientID <> 0 then
    if qryStatementsClientID.asInteger = ARclientID then Afont.Color := ClRed;


end;


procedure TPrintStatement.chkGroupJobsClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol <> chkGroupJobs then exit;
  if chkGroupJobs.Checked then begin
    chkRelatedCustomer.Checked := false;
    chkGroupType.Checked := false;
  end;
  if qryStatements.Active then begin
    RefreshQuery;
    grd.SelectedList.Clear;
    grd.Refresh;
  end;
end;

procedure TPrintStatement.chkGroupTypeClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol <> chkGroupType then exit;
  if chkGroupType.Checked then begin
    chkGroupJobs.Checked := false;
    chkRelatedCustomer.Checked := false;
  end;
  if qryStatements.Active then begin
    RefreshQuery;
    grd.SelectedList.Clear;
    grd.Refresh;
  end;
end;

procedure TPrintStatement.FormDestroy(Sender: TObject);
begin
  flstFilter.Clear;
  FreeandNil(flstFilter);
  CommonDbLib.DestroyUserTemporaryTable(fsTempTblName);
  CommonDbLib.DestroyUserTemporaryTable(fsTablename);
  CommonDbLib.DestroyUserTemporaryTable(fsRTTablename);
  CommonDbLib.DestroyUserTemporaryTable(fsRTDetailTablename);
  CommonDbLib.DestroyUserTemporaryTable(fsTempSalesTable);
  CommonDbLib.DestroyUserTemporaryTable(fsTempSalesLinesTable);
  CommonDbLib.DestroyUserTemporaryTable(tablenameSalesSum);
  CommonDbLib.DestroyUserTemporaryTable(tablenameBOInvsum);
  CommonDbLib.DestroyUserTemporaryTable(tablenameBOSOsum);
  CommonDbLib.DestroyUserTemporaryTable(tablenamePrepaySum);
  inherited;
end;

procedure TPrintStatement.ExportStatement;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add(SQLFINAL);
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      ExportToFile := true;
      if ExportStructureDone then begin
        memExportALL.LoadFromDataSet(qryTemp, [mtcpoAppend]);
      end else begin
        ExportStructureDone := true;
        memExportALL.Close;
        memExportALL.EmptyTable;
        memExportALL.LoadFromDataSet(qryTemp, [mtcpoStructure,
          mtcpoProperties]);
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPrintStatement.CreateStatement(AClientId: Integer; const sFrom, sTo: String);
var
  SQLList : TSTringList;
  sOverdueMsg     : String;
  RunningTotal : Double;
  sClassName : string;
  //ForeignOpeningBalance,
  //ForeignOutstandingAmt : double;
  //OpeningBalanceRewardPoints,
  //ClosingBalanceRewardPoints : double;
  //OpeningBalance: double;
  //OutstandingAmt : double;
begin
  if Empty(ReportToPrint) then begin
   ReportToPrint := tcdatautils.GetDefaultReport(GetReportTypeID);
   if ReportToPrint = '' then ReportToPrint := 'Statements';
  end;

  sClassName := cboClass.Text;
  if IsAllClassSelected then
    sClassName := 'All';

  //ForeignOpeningBalance := TotalForeignAmt(sFrom, sTo, False, False);
  //ForeignOutstandingAmt := TotalForeignAmt(sFrom, sTo, true, true);
  //OpeningBalanceRewardPoints := AvailableRewardPoints(ClientID , dtFrom.DateTime);
  //ClosingBalanceRewardPoints := AvailableRewardPoints(ClientID , dtTo.DateTime);
  //OpeningBalance          := TotalAmt(sFrom, sTo, false, false);
  //OutstandingAmt          := TotalAmt(sFrom, sTo, true, true);
  InitStatementParams;
  if IsrunningBalanceReport(ReportToPrint) then begin
    StatementsRunnBalLib.CreateRunningBalanceStatement(SQLFinal);
  end else begin
    StatementsSimpleLib.CreateStatement(SQLFinal);
  end;

  AddtransdetailsSQL(clientID, sfrom, sto );//, OpeningBalance,OutstandingAmt,ForeignOpeningBalance ,ForeignOutstandingAmt);
end;

procedure TPrintStatement.InitStatementParams;
begin
  sparams.fsRTTablename       := fsRTTablename;
  sparams.fsRTDetailTablename := fsRTDetailTablename	;
  sparams.fsTablename         := fsTablename;
  sparams.fsTempTblName       := fsTempTblName;
  sparams.BalOnDaterange      := chkBalOnDaterange.checked;
  sparams.CurDate             := dtCurDate.Date;
  sparams.includeSalesOrder   := chkincludeSalesOrder.checked;
  sparams.includeinvoiceBO    := chkincludeinvoiceBO.checked;
  sparams.includeSOBO         := chkincludeSOBO.checked;
  sparams.basedonoptionsIndex := grpbasedonoptions.ItemIndex;
  sparams.ReportDateFrom      := dtfrom.DateTime;
  sparams.ReportDateTo        := dtTo.DateTime;
  sparams.ClientID            := ClientID;
  sparams.GroupJobs           := chkGroupJobs.Checked;
  sparams.RelatedCustomer     := chkRelatedCustomer.Checked;
  sparams.showPaid            := chkshowPaid.checked;
  sparams.AllClass            := chkAllClass.checked;
  sparams.SelectedClass       := cboClass.Text;
  //SParams.ClassID             := cboClassQry.FieldByName('ClassID').asInteger;
  sparams.OrderOptionsIndex   := grpOrderOptions.itemindex;
  sparams.ReportClassname     := Self.classname;
end;

Procedure TPrintStatement.AddtransdetailsSQL(AClientId : integer; const sFrom, sTo : string);//;OpeningBalance,OutstandingAmt,ForeignOpeningBalance ,ForeignOutstandingAmt: double);
var
  s:String;
  x:Integer;
begin
  if not(TemplateContainsSection('TransList',self.ReportToPrint,x))  then Exit;
  PopulateTransDetails;
  s:= 'Select * from    '+ fsRTDetailTablename;
  AddSQLPortion(SQLfinal , x , s);
end;

procedure TPrintStatement.AfterFormShow;
begin
  inherited;
  RefreshQuery;
end;


function TPrintStatement.getClassFilter(const fsFieldName: String): String;
begin
  if not IsAllClassSelected then
    Result := ' AND ' + fsfieldname + ' = ' + cboClassQry.FieldByName('ClassID').AsString
  else
    Result := '';
end;

procedure TPrintStatement.grdColEnter(Sender: TObject);
begin
  inherited;
  FilterColumn := TwwDBGrid(Sender).GetActiveField.FieldName;
  if (FilterColumn = 'AmountDue') then FilterColumn := 'Companyname';
  lblFilter.Caption := 'Search by ' + TwwDBGrid(Sender).ColumnByName(FilterColumn).DisplayLabel;
end;

procedure TPrintStatement.qryStatementsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if ficlientId <> 0 then qryStatements.Locate('ClientID' , ficlientId , []);
  grd.SelectedList.Clear;

  FilterColumn := 'Companyname';
  DoHideProgressbar;
end;

procedure TPrintStatement.qryStatementsBeforeClose(DataSet: TDataSet);
begin
  inherited;
  ficlientId := qryStatementsClientID.asInteger;
end;

procedure TPrintStatement.qryStatementsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  DoShowProgressbar(3, 'Opening Statement...');
  DoStepProgressbar;
end;

procedure TPrintStatement.MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  Action := eaContinue;
end;

procedure TPrintStatement.EmailRefund(SaleID, ClientID: integer);
var
  f: file;
  RecipientAddress, ReportType, OutGoingFileName: String;
  qryEmailedList: TERPQuery;
  TransactionID, UserID, TransactionDescription: String;
  EmailDate: TDateTime;
  ReportAttachmentfiles:String;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
begin
  // Clear all previous params/data
  (*lblProgress.*)Label8.Caption := 'Emailing, ' + WAITMSG;
  RecipientAddress := '';
  ReportType := '';
  OutGoingFileName := '';

  RecipientAddress := ClientcontactEmailID(ClientID , ctMainContactforRefund);

  if RecipientAddress = '' then
    if CommonLib.MessageDlgXP_Vista(GetClientName(ClientID) +
      ' does not have an email address to send to. Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
//  if RecipientAddress <> '' then begin
    try
      Corres := TCorrespondenceGui.Create;
      try

        ReportType := 'Refund';
        // String defined here because it is easy to change when this code is applied to
        // other forms. (ie, Quote instead of Invoice etc)
        (*lblProgress.*)Label8.Visible := true;
        PrintTemplateRefund(SaleID, true, true);

        (*lblProgress.*)Label8.Caption := 'Connecting...';

        (*lblProgress.*)Label8.Caption := 'Emailing, ' + WAITMSG;

        Corres.Subject := ReportType + ' #' + GetInvDocNo(SaleID) + ' for ' + GetClientName(ClientID);
        Corres.RecipientList := RecipientAddress;
        Corres.CustomerId := ClientID;
        Corres.MessageText := 'This report email has been sent to you from ' + GetCompanyName;

        OutGoingFileName := getOutGoingFileName('' ,' ' + ReportType + ' #' + GetInvDocNo(SaleID) , '.PDF');
        AssignFile(f,  Commonlib.TempDir  + 'EmailReport.PDF');

        if not FileExists( Commonlib.TempDir  + OutGoingFileName) then begin
          copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),
            PChar( Commonlib.TempDir  + OutGoingFileName), false);
        end;

        Corres.AttachmentList.Add(Commonlib.TempDir  + OutGoingFileName);
        ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(REportToPrint));
        if not EmailShortSendMode(lSilent, lSecret) then
          exit;

        // finally shoot the email
        if Corres.Execute(lSilent, lSecret) then begin

          TransactionID := GetInvDocNo(SaleID);
          UserID := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
          EmailDate := Now;

          // ReportType already defined at start of procedure
          TransactionDescription := GetCompanyName + ' ' + ReportType + ' #' + GetInvDocNo(SaleID) + ' for ' + GetClientName(ClientID);
          qryEmailedList := TERPQuery.Create(Self);
          qryEmailedList.Connection := CommonDbLib.GetSharedMyDacConnection;
          try
            qryEmailedList.Sql.Clear;
            qryEmailedList.Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription) Values ("' +
              TransactionID + '","' + UserID + '", "' + FormatDateTime(MysqlDateFormat,
              EmailDate) + '", "' + ReportType + '", "' + TransactionDescription +
              '")');
            qryEmailedList.Execute;
          finally
            FreeandNil(qryEmailedList);
          end;
        end;

        ReportToPrint := '';
        DeleteFiles( Commonlib.TempDir , '*.PDF');
        DeleteMultipleFiles(Commonlib.TempDir , ReportAttachmentfiles);
        (*lblProgress.*)Label8.Visible := false;
      finally
        Corres.Free;
      end;
    except
      (*lblProgress.*)Label8.Visible := false;
    end;
//  end;
end;

procedure TPrintStatement.FaxRefund(SaleID, ClientID: integer);
var
  Fax: TFaxObj;
  FaxNo: String;
begin
  inherited;
  FaxNo := GetClientFaxNumber(ClientID);
  if Empty(FaxNo) then begin
    CommonLib.MessageDlgXP_Vista(GetClientName(ClientID) +
      ' does not have an Fax Number to Send to.' + #13 + #10 + #13 + #10 +
      'Please Review Customer information to Add an Fax Number.', mtWarning,
      [mbOK], 0);
  end else begin
    (*lblProgress.*)Label8.Visible := true;
    (*lblProgress.*)Label8.Caption := 'Adding to Fax Spool...';
    fsFax := true;
    PrintTemplateRefund(SaleID, true, true, false, 'Refund_' + GetSaleGlobalRef(SaleID));
    ReportToPrint := '';
    Fax := TFaxObj.Create;
    try
      Fax.NoCoverSheet := true;
      Fax.AddToFaxSpool(AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName,
        GetClientName(ClientID), FaxNo, 'Refund', GetSaleGlobalRef(SaleID), '',
        ExtractFilePath(ParamStr(0)) + 'IMG0001.BMP', Now());
    finally
      FreeandNil(Fax);
    end;
    (*lblProgress.*)Label8.Visible := false;
    DeleteFiles(ExtractFilePath(ParamStr(0)), '*.BMP');
  end;
end;

procedure TPrintStatement.PrintTemplateRefund(const SaleID: integer; const bPrint, bSave, DoClose: boolean; const FileName: String);
var
  sSQL: String;
begin
  ReportToPrint := tcdatautils.GetDefaultReport(22);
  Try
    sSQL := Format(' AND d2.%s = %d', ['SaleID', SaleID]);

    if not bSave then begin
      PrintTemplateReport(ReportToPrint, sSQL, bPrint, 1);
    end else begin
      if Empty(FileName) then begin
        SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF');
      end else begin
        if fsFax then begin
          SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'GraphicFile',
            FileName);
        end else begin
          SaveTemplateReport(ReportToPrint, sSQL, bPrint, 'PDF', FileName);
        end;
      end;
    end;
  finally
    //ReportToPrint := '';
  end;
end;

procedure TPrintStatement.chkincludeSalesOrderClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TPrintStatement.qryStatementsCalcFields(DataSet: TDataSet);
begin
  inherited;
  Dataset.fieldByname('AmountDue').asFloat  :=Dataset.fieldByname('Salessum').asFloat - Dataset.fieldByname('PrepaySum').asFloat;
  Dataset.fieldByname('totalamountdue').asFloat  :=Dataset.fieldByname('Salessum').asFloat - Dataset.fieldByname('PrepaySum').asFloat+
                                              Dataset.fieldByname('BOInvsum').asFloat - Dataset.fieldByname('BOSOSum').asFloat;
end;

procedure TPrintStatement.ReadGuipref;
begin
  AddFlag('LoadingGuiPrefs');
  try
    if GuiPrefs.Node.Exists('Options') then begin
      chkincludeSalesOrder.checked:= StrToBoolean(GuiPrefs.Node['Options.SalesOrder'].AsString);
      chkincludeinvoiceBO.checked := StrToBoolean(GuiPrefs.Node['Options.InvoiceBO'].AsString);
      chkincludeSOBO.checked      := StrToBoolean(GuiPrefs.Node['Options.SalesOrderBO'].AsString);
      chkOutstandingInv.checked   := StrToBoolean(GuiPrefs.Node['Options.PrintInvoices'].AsString);
      chkshowPaid.checked         := StrToBoolean(GuiPrefs.Node['Options.ShowPaid'].AsString);
      chkBalOnDaterange.checked   := StrToBoolean(GuiPrefs.Node['Options.BalOnDaterange'].AsString);
      (*optsaleDate.Checked         := GuiPrefs.Node['Options.SatementBasedOn'].AsString    = 'SaleDate' ;
      optduedate.Checked          := GuiPrefs.Node['Options.SatementBasedOn'].AsString    = 'Duedate' ;*)
      (*OptID.Checked               := GuiPrefs.Node['Options.PrintsalesInOrderOf'].AsString= 'ID' ;
      OptSalesDate.Checked        := GuiPrefs.Node['Options.PrintsalesInOrderOf'].AsString= 'SalesDate' ;
      Optdaysoutstanding.Checked  := GuiPrefs.Node['Options.PrintsalesInOrderOf'].AsString= 'DaysOutstanding' ;*)
      grpOrderOptions.itemindex     := GuiPrefs.Node['Options.Orderbyindex'].asInteger;
      grpbasedonoptions.itemindex   := GuiPrefs.Node['Options.Basedonindex'].asInteger;
    end else begin
      chkincludeSalesOrder.checked:= False;
      chkincludeinvoiceBO.checked := False;
      chkincludeSOBO.checked      := False;
      chkOutstandingInv.checked   := False;
      chkshowPaid.checked         := False;
      chkBalOnDaterange.checked   := False;
      (*optsaleDate.Checked         := True;
      optduedate.Checked          := False;*)
      (*OptID.Checked               := True;
      OptSalesDate.Checked        := False;
      Optdaysoutstanding.Checked  := False;*)
      grpOrderOptions.itemindex     := 0;
      grpbasedonoptions.itemindex   := 0;
    end;

    if GuiPrefs.Node.Exists('General') then begin
      chkChooseRpt.checked        := StrToBoolean(GuiPrefs.Node['General.ChooseTemplate'].AsString);
      chkGroupJobs.checked        := StrToBoolean(GuiPrefs.Node['General.GroupJobsWithCustomer'].AsString);
      chk0Balancecustomers.checked:= StrToBoolean(GuiPrefs.Node['General.ShowCustomersWithNobalance'].AsString);
      chkRelatedCustomer.checked  := StrToBoolean(GuiPrefs.Node['General.GroupRelatedCustomer'].AsString);
      chkGroupType.checked        := StrToBoolean(GuiPrefs.Node['General.GroupType'].AsString);
      cboClass.Text               := GuiPrefs.Node['General.DepartmentName'].AsString;
      chkAllClass.checked         := StrToBoolean(GuiPrefs.Node['General.AllDepartment'].AsString);
      dtFrom.Date                 := strTodate(GuiPrefs.Node['General.Datefrom'].AsString);
      dtto.Date                   := strTodate(GuiPrefs.Node['General.DateTo'].AsString);
      customerListFilter          := GuiPrefs.Node['General.customerListFilter'].AsString;
    end else begin
      chkChooseRpt.checked        := False;
      chkGroupJobs.checked        := False;
      chkRelatedCustomer.checked  := False;
      chk0Balancecustomers.checked:= False;
      cboClass.TExt               := Appenv.DefaultClass.DefaultClassName;
      chkAllClass.checked         := False;
      chkGroupType.checked        := False;
      dtFrom.Date                 := Date - appenv.Employee.ListDaysPast;
      dtTo.Date                   := Date + appenv.Employee.ListDaysFuture;
      customerListFilter          :='';
    end;
  finally
    RemoveFlag('LoadingGuiPrefs');
  end;
  Application.processmessages;
end;

procedure TPrintStatement.WriteGuiPref;
begin
  GuiPrefs.Node['Options.SalesOrder'].AsString      := BooleanToStr(chkincludeSalesOrder.checked);
  GuiPrefs.Node['Options.InvoiceBO'].AsString       := BooleanToStr(chkincludeinvoiceBO.checked);
  GuiPrefs.Node['Options.SalesOrderBO'].AsString    := BooleanToStr(chkincludeSOBO.checked);
  GuiPrefs.Node['Options.PrintInvoices'].AsString   := BooleanToStr(chkOutstandingInv.checked);
  GuiPrefs.Node['Options.ShowPaid'].AsString        := BooleanToStr(chkshowPaid.checked);
  GuiPrefs.Node['Options.BalOnDaterange'].AsString  := BooleanToStr(chkBalOnDaterange.checked);

(*  if optsaleDate.checked then GuiPrefs.Node['Options.SatementBasedOn'].AsString := 'SaleDate'
                         else GuiPrefs.Node['Options.SatementBasedOn'].AsString := 'Duedate';*)

(*       if OptID.checked        then  GuiPrefs.Node['Options.PrintsalesInOrderOf'].AsString := 'ID'
  else if OptSalesDate.checked then GuiPrefs.Node['Options.PrintsalesInOrderOf'].AsString := 'SalesDate'
                               else GuiPrefs.Node['Options.PrintsalesInOrderOf'].AsString := 'DaysOutstanding';*)
  GuiPrefs.Node['Options.Orderbyindex'].asInteger := grpOrderOptions.itemindex;
  GuiPrefs.Node['Options.Basedonindex'].asInteger := grpbasedonoptions.itemindex;
  GuiPrefs.Node['General.ChooseTemplate'].AsString            := BooleanToStr(chkChooseRpt.checked);
  GuiPrefs.Node['General.GroupJobsWithCustomer'].AsString     := booleanToStr(chkGroupJobs.checked);
  GuiPrefs.Node['General.GroupType'].AsString                 := booleanToStr(chkGroupType.checked);
  GuiPrefs.Node['General.GroupRelatedCustomer'].AsString      := booleanToStr(chkRelatedCustomer.checked);
  GuiPrefs.Node['General.ShowCustomersWithNobalance'].AsString:= booleanToStr(chk0Balancecustomers.checked);
  GuiPrefs.Node['General.AllDepartment'].AsString             := BooleanToStr(IsAllClassSelected);
  GuiPrefs.Node['General.DepartmentName'].AsString            := cboClass.TExt;
  GuiPrefs.Node['General.Datefrom'].AsString                  := DatetoStr(dtFrom.Date);
  GuiPrefs.Node['General.DateTo'].AsString                    := Datetostr(dtto.Date);
  GuiPrefs.Node['General.customerListFilter'].AsString        := customerListFilter;
end;

procedure TPrintStatement.chk0BalancecustomersClick(Sender: TObject);
begin
  inherited;
  SetQryStatementFilter;
end;


procedure TPrintStatement.SetQryStatementFilter;
begin
  qryStatements.Filter   := GetFilterString;
  qryStatements.Filtered := qryStatements.Filter<>'';
end;

function TPrintStatement.IsrunningBalanceReport(const ReportName: String): Boolean;
begin
  Result := Pos(uppercase('Statement(Running Balance)') , upperCase(ReportName)) <> 0;
end;


procedure TPrintStatement.Readfilter(Sender: TObject);
begin
  if Sender is TBaseListingGUI then begin
    if customerListFilter<>   TBaseListingGUI(Sender).Qrymain.Filter then begin
      customerListFilter:=  TBaseListingGUI(Sender).Qrymain.Filter;
      RefreshQuery;
    end;
  end;
end;



procedure TPrintStatement.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  TCustomersForStatementsGUI.ListForfilter('', Readfilter);
end;

procedure TPrintStatement.DobeforeExecuteScript(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  DoStepProgressbar;
end;

procedure TPrintStatement.SetcustomerListFilter(const Value: String);
begin
  fcustomerListFilter := Value;
  if Value ='' then
    lblCustomfilter.Caption := 'No custom Filter Selected'
  else
  lblCustomfilter.Caption := replaceStr(replaceStr(Value, '[' , ''),']' , '');;
end;

procedure TPrintStatement.chkRelatedCustomerClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol <> chkRelatedCustomer then exit;
  if chkRelatedCustomer.Checked then begin
    chkGroupJobs.Checked := false;
    chkGroupType.Checked := false;
  end;
  if qryStatements.Active then begin
    RefreshQuery;
    grd.SelectedList.Clear;
    grd.Refresh;
  end;

end;

procedure TPrintStatement.grdDblClick(Sender: TObject);
begin
  inherited;

  if xclientId = 0 then begin
    chkGroupJobsChecked       :=chkGroupJobs.Checked;
    chkRelatedCustomerChecked :=chkRelatedCustomer.checked;
  end;
  xclientId                 :=qryStatementsClientID.asInteger;
  chkGroupJobs.Checked      :=False;
  chkRelatedCustomer.checked:=False;
  RefreshQuery;
end;

procedure TPrintStatement.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
if (key = VK_BACK) and (Screen.activecontrol = grd) then
  if xclientId <> 0 then begin
      xclientID := 0;
      chkGroupJobs.Checked:= chkGroupJobsChecked;
      chkRelatedCustomer.checked := chkRelatedCustomerChecked;
      RefreshQuery;
  end;
end;

procedure TPrintStatement.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(Pagecontrol, 1);
end;
function TPrintStatement.SalesBalance(salesTableAlias:String ='S'):String;
begin
  Result := StatementsLib.SalesBalance(salesTableAlias);
end;
function TPrintStatement.DaysTostatementDate: String;
begin
  Result := StatementsLib.DaysTostatementDate;
end;
function TPrintStatement.DueDays: String;
begin
  Result := StatementsLib.DueDays;
end;
Function TPrintStatement.SalesType :String;
begin
    Result:= StatementsLib.SalesType;
end;
function TPrintStatement.SalestypeBO: String;
begin
    Result:= StatementsLib.SalestypeBO;
end;
function TPrintStatement.Datetofilter :String ;
begin
    Result:= StatementsLib.Datetofilter;
end;
function TPrintStatement.Clients(TableAlias:String):String;
begin
    Result := StatementsLib.Clients(TableAlias);
end;

function TPrintStatement.IsAllClassSelected: Boolean;
begin
  Result := StatementsLib.IsAllClassSelected;
end;

Function TPrintStatement.BOType :String;
begin
    Result:=StatementsLib.BOType;
end;
function TPrintStatement.Prepayamount(PrepayTablealias :String ='P';ResutlTupe:String ='Balance' ):String;
begin
  Result := StatementsLib.Prepayamount(PrepayTablealias,ResutlTupe);
end;
function TPrintStatement.TotalAmt(const sFrom, sTo : string; iscurrent, isclosingBalance: Boolean) : Double;
begin
  REsult := StatementsLib.TotalAmt(sFrom, sTo,iscurrent, isclosingBalance);
end;
procedure TPrintStatement.runSQL(const strSQL: String; var VarAmt: Double;fsFieldname: String; runLoop: Boolean);
begin
    StatementsLib.runSQL(strSQL,VarAmt,fsFieldname,runLoop);
end;
function TPrintStatement.GetOverDueMsg(const sTable: String): String;
begin
  REsult := StatementsLib.GetOverDueMsg(sTable);
end;
Function TPrintStatement.clientbillToAddress(TableAlias:STring):String;
begin
  REsult := StatementsLib.clientbillToAddress(TableAlias);
end;
function TPrintStatement.TotalForeignAmt(const sFrom, sTo : string; iscurrent,isclosingBalance: Boolean): Double;
begin
  Result := StatementsLib.TotalForeignAmt(sFrom, sTo,iscurrent,isclosingBalance);
end;
initialization
  RegisterClassOnce(TPrintStatement);
end.


