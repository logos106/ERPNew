{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/07/05  1.00.01 BJ   Search option for the amount.
  1/11/05  1.00.02 DLS  Added RegisterClass
}
unit ReconciliationForm;

{$I ERP.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB,  ExtCtrls, DNMPanel,
  StdCtrls, Buttons, DNMSpeedButton, Mask, wwdbedit, Wwdotdot, SelectionDialog2,
  Wwdbcomb, wwdblook, AppEvnts, AdvGrid, ComCtrls,AdvOfficeStatusBar,
  wwdbdatetimepicker, Grids, BaseGrid, wwcheckbox, JSONObject,
  ActnList, MyAccess,ERPdbComponents, DBCtrls, DBAccess, MemDS, DataState, SelectionDialog,
  Menus, AdvMenus, Shader, AdvSplitter, ImgList, AdvObj, IntegerListObj,
  ProgressDialog, contnrs, BusobjReconciliation, busobjbase , BusobjReconciliationGUILines, busObjBankDepost, busObjExpenses,
  sgcBase_Classes, sgcTCP_Classes, sgcWebSocket_Classes,
  sgcWebSocket_Classes_Indy, sgcWebSocket_Client, sgcWebSocket, CheckLst,
  AdvPanel;

type
  TStatementRecList = class;
  TStatementRecType = (srtDeposit, srtWithdrawl);

  TStatementRec = class(TObject)
  private
    fStatementRecType: TStatementRecType;
    fPayID: integer;
    fStatementLineID: integer;
    fStatementAmount: double;
    fStatementDescription: string;
    fPayLineID: integer;
    fTransactionDate: TDAteTime;
  public
    property StatementRecType: TStatementRecType read fStatementRecType write fStatementRecType;
    property PayID: integer read fPayID write fPayID;
    property PayLineID: integer read fPayLineID write fPayLineID;
    property StatementLineID: integer read fStatementLineID write fStatementLineID;
    property StatementDescription: string read fStatementDescription write fStatementDescription;
    property StatementAmount: double read fStatementAmount write fStatementAmount;
    property TransactionDate: TDAteTime read fTransactionDate write fTransactionDate;
  end;

  TStatementRecList = class(TObject)
  private
    fList: TObjectList;
    fDragRecord: TStatementRec;
    function GetCount: integer;
    function GetItem(const idx: integer): TStatementRec;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    function ItemByID(const aType: TStatementRecType; const aStatementLineID: integer): TStatementRec; overload;
    function ItemByID(const aType: TStatementRecType; const aPayID, aPayLineID: integer): TStatementRec; overload;
    property Item[const idx: integer]: TStatementRec read GetItem;
    procedure Add(aType: TStatementRecType; aPayID, aPayLineID, aStatementLineID: integer;
      aDesc: string; aAmount: double; aDate: TDateTime);
    procedure Clear;
    property DragRecord: TStatementRec read fDragRecord write fDragRecord;
  end;

  TReconciliationGUI = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlRight: TDNMPanel;
    pnlFooter: TDNMPanel;
    btnMarkAll: TDNMSpeedButton;
    btnUnMark: TDNMSpeedButton;
    btnSaveClose: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    lblTotDeposits: TLabel;
    Label2: TLabel;
    lblTotWithdrawals: TLabel;
    Label4: TLabel;
    lblDepositsAmount: TLabel;
    lblWithdrawalsAmount: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblEndBal: TLabel;
    lblClearedBal: TLabel;
    lblDiff: TLabel;
    Bevel2: TBevel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    dsRecons: TDataSource;
    qryAccount: TERPQuery;
    cboAccount: TwwDBLookupCombo;
    qryRecons: TERPQuery;
    edtOpenBal: TwwDBEdit;
    edtCloseBal: TwwDBEdit;
    edtStatement: TwwDBEdit;
    dtDate: TwwDBDateTimePicker;
    btnPrint: TDNMSpeedButton;
    btnHold: TDNMSpeedButton;
    Label3: TLabel;
    chkDeleted: TwwCheckBox;
    btnPrintReport: TDNMSpeedButton;
    ActionList1: TActionList;
    actPrint: TAction;
    Bevel3: TBevel;
    Label5: TLabel;
    txtComments: TDBMemo;
    Bevel4: TBevel;
    qryReconsGlobalRef: TWideStringField;
    qryReconsReconciliationID: TAutoIncField;
    qryReconsReconciliationDate: TDateField;
    qryReconsEmployeeID: TIntegerField;
    qryReconsClassID: TIntegerField;
    qryReconsAccountID: TIntegerField;
    qryReconsStatementNo: TWideStringField;
    qryReconsNotes: TWideStringField;
    qryReconsOpenBalance: TFloatField;
    qryReconsCloseBalance: TFloatField;
    qryReconsDeleted: TWideStringField;
    qryReconsEditedFlag: TWideStringField;
    qryReconsFinished: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel3: TDNMPanel;
    Panel1: TDNMPanel;
    Panel4: TDNMPanel;
    pnlDepositSearch: TDNMPanel;
    Label10: TLabel;
    btnDepositPrev: TDNMSpeedButton;
    btnDepositNext: TDNMSpeedButton;
    edtDepositSearch: TwwDBEdit;
    Panel2: TDNMPanel;
    pnlWithdrawalsSearch: TDNMPanel;
    Label15: TLabel;
    btnWithdrawalsPrev: TDNMSpeedButton;
    btnWithdrawalsNext: TDNMSpeedButton;
    edtWithdrawalSearch: TwwDBEdit;
    Panel5: TDNMPanel;
    AdvSplitter3: TAdvSplitter;
    chkFilterDate: TwwCheckBox;
    Label16: TLabel;
    report1n2: TAdvSplitter;
    Splitter1: TAdvSplitter;
    pnlgrdDeposits: TDNMPanel;
    pnlgrdDepositsSum: TDNMPanel;
    grdDepositsSum: TAdvStringGrid;
    grdDeposits: TAdvStringGrid;
    pnlgrdWithdrawals: TDNMPanel;
    pnlgrdWithdrawalsSum: TDNMPanel;
    grdWithdrawalsSum: TAdvStringGrid;
    grdWithdrawals: TAdvStringGrid;
    btnBankTransactions: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    btnCheque: TDNMSpeedButton;
    btnDeposit: TDNMSpeedButton;
    tblReconWithdrawalLines: TERPQuery;
    tblReconDepLines: TERPQuery;
    pnldebug: TDNMPanel;
    DNMSpeedButton6: TDNMSpeedButton;
    DNMSpeedButton7: TDNMSpeedButton;
    DNMSpeedButton8: TDNMSpeedButton;
    DNMSpeedButton9: TDNMSpeedButton;
    DNMSpeedButton10: TDNMSpeedButton;
    DNMSpeedButton11: TDNMSpeedButton;
    DNMSpeedButton12: TDNMSpeedButton;
    DNMSpeedButton13: TDNMSpeedButton;
    btnhelp: TDNMSpeedButton;
    lblRecStatus: TLabel;
    wsClient: TsgcWebSocketClient;
    GridBrush: TColorBox;
    btnStrictMatch: TDNMSpeedButton;
    btnRelaxedMatch: TDNMSpeedButton;
    bnCreateEntries: TDNMSpeedButton;
    bnRules: TDNMSpeedButton;
    SettingsGroup: TAdvPanelGroup;
    Settings: TCheckListBox;
    chkChooseRpt: TCheckBox;
    lbCreateNew: TLabel;
    procedure actPrintExecute(Sender: TObject);
    procedure actPrintUpdate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDepositNextClick(Sender: TObject);
    procedure btnHoldClick(Sender: TObject);
    procedure btnMarkAllClick(Sender: TObject);
    procedure btnPrintReportClick(Sender: TObject);
    procedure btnSaveCloseClick(Sender: TObject);
    procedure btnUnMarkClick(Sender: TObject);
    procedure btnWithdrawalsNextClick(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkDeletedClick(Sender: TObject);
    procedure edtCloseBalExit(Sender: TObject);
    procedure edtCloseBalKeyPress(Sender: TObject; var Key: char);
    procedure edtDepositSearchChange(Sender: TObject);
    procedure edtWithdrawalSearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer; var Allow: boolean);
    procedure grdDblClickCell(Sender: TObject; ARow, ACol: integer);
    procedure grdDepositsCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
    procedure grdWithdrawalsCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
    procedure AdvSplitter3Moved(Sender: TObject);
    procedure AdvSplitter3DblClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure grdDepositsGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure grdWithdrawalsGetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure dtDateExit(Sender: TObject);
    {$ifdef COMPILER_22_UP}
    procedure grdDepositsGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TAsgVAlignment);
    procedure grdWithdrawalsGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TAsgVAlignment);
    {$else}
    procedure grdDepositsGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure grdWithdrawalsGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    {$endif}
    procedure qryReconsBeforeDelete(DataSet: TDataSet);
    procedure btnChequeClick(Sender: TObject);
    procedure btnDepositClick(Sender: TObject);
    procedure cboAccountChange(Sender: TObject);
    procedure edtCloseBalDblClick(Sender: TObject);
    procedure report1n2Moved(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure grdDepositsColumnSize(Sender: TObject; ACol: Integer;
      var Allow: Boolean);
    procedure grdWithdrawalsColumnSize(Sender: TObject; ACol: Integer;
      var Allow: Boolean);
    procedure grdDepositsSumColumnSize(Sender: TObject; ACol: Integer;
      var Allow: Boolean);
    procedure grdWithdrawalsSumColumnSize(Sender: TObject; ACol: Integer;
      var Allow: Boolean);
    procedure btnBankTransactionsClick(Sender: TObject);
    procedure btnhelp1Click(Sender: TObject);
    procedure edtStatementExit(Sender: TObject);
    procedure btnSaveCloseEnter(Sender: TObject);
    procedure dtDateEnter(Sender: TObject);
    procedure tblReconDepLinesDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure DNMSpeedButton13Click(Sender: TObject);
    procedure DNMSpeedButton12Click(Sender: TObject);
    procedure DNMSpeedButton11Click(Sender: TObject);
    procedure DNMSpeedButton10Click(Sender: TObject);
    procedure DNMSpeedButton8Click(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
    procedure DNMSpeedButton6Click(Sender: TObject);
    function FullStrictMatchClick(AStatementRecType: TStatementRecType) : Boolean;
    function FullRelaxedMatchClick(AStatementRecType: TStatementRecType): Boolean;
    procedure btnStrictMatchClick(Sender: TObject);
    procedure btnRelaxedMatchClick(Sender: TObject);
    procedure bnCreateEntriesClick(Sender: TObject);
    procedure wsClientException(Connection: TsgcWSConnection; E: Exception);
    procedure wsClientMessage(Connection: TsgcWSConnection; const Text: string);
    procedure btnhelpClick(Sender: TObject);
    procedure SettingsClickCheck(Sender: TObject);
    procedure bnRulesClick(Sender: TObject);
    procedure getLastDepositAttributes;
    procedure getLastChequeAttributes;
    procedure grdDepositsButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure grdWithdrawalsButtonClick(Sender: TObject; ACol, ARow: Integer);
  private
    { Private declarations }
    OnHoldList: TSelectionDialog2;
    OnShowFinished: boolean;
    FComputeTotals : Boolean;
    gYodleeText : string;
    FirstStmtDep: Integer;
    FirstStmtWrt: Integer;
    bIsNew: boolean;  // true if this is not an existing reconciliation
    bReconciliationStarted : Boolean;
    gNextReconId : Integer;
    gLastDepFromAccount: string;
    gLastDepPaymentMethod: string;
    gLastChqAccount: string;
    TotalSumBankDep : Currency;
    TotalCountBankDep : Integer;
    TotalSumBankWrt : Currency;
    TotalCountBankWrt : Integer;
    FDontAskAgain   : Boolean;
    CommitFailed:boolean;
    str: String;
    ChequeIDList,
    DepositIDList: TIntegerList;
    SelectedDeposits,
    SelectedWithdrawals: TIntegerList;
    GridResizing:boolean;
    fsTablename:String;
    UseStatements: boolean;
    StatementRecList: TStatementRecList;
    fdCleanDate:TDate;

    checkDepositLines: TGUIReconciliationLines;

    function CheckForOnHoldID(const AccountID: integer): integer;
    function CheckIfLastReconciliation: boolean;
    function ConvertStatementDesc(AInputStatementDesc: string): string;
    function CurrentGridCellAmount(AGrid: TAdvStringGrid): double;
    function findMatchingBankRow(AStatementRecType: TStatementRecType; AStatementRec:TStatementRec; AStrict: Boolean): Integer;
    function GetDepositPaymentID(const DepositID: integer; const TrnsType: string = ''): integer;
    function GetOnHoldID: integer;
    function GetWithdrawalPaymentID(const DepositID: integer): integer;
    function GridCellAmount(AGrid: TAdvStringGrid; ARow: integer): double;
    procedure RunImportBankTransactions;
    function IsValidFloat(const sNumber: string): boolean;
    function LoadNotReconciledData(var SQLStr: string; const AccountID: integer; const CreateTempTable: boolean = false): integer;
    procedure MarkGridFromSavedTrans(ReconciliationLine:TReconciliationLineBase);//(const iID: integer; const sTblName: string; const grd: TAdvStringGrid);
    function OkToSave(const bFinished: boolean): boolean;
    function PopulateGridFromDB(ReconciliationLine:TReconciliationLineBase): boolean;
    function ProcessDelete: boolean;
    function ProcessOnHold: integer;
    function CountMarkedTrans: Integer;
    procedure InsertRule(AStatementDesc: string; APayee: string);
    function IsLightColor (AColor: TColor) : Boolean;
    function GetSum(ACol: Integer; AGrid: TAdvStringGrid) : Currency;
    procedure OrientRows(AGrid: TAdvStringGrid);
    function MoveRows(AStartRow: Integer; AFirstRow: Integer; AGrid: TAdvStringGrid; AColId: Integer) : Integer;
    function  MergeRows(AFromRow: Integer; AToRow: Integer; AGrid: TADvStringGrid) : Integer;
    function  BlankRows(ARow: Integer; AGrid: TADvStringGrid) : Integer;
    function RemovePrevRecons(const JustLines: boolean): boolean;
    function SaveRecons(const bFinished: boolean): boolean;
    procedure DisplayBalances(const bAll: boolean);
    function  MarkUnMarkAll(ACheck: Boolean; ACol: integer; AGrid: TAdvStringGrid) : Boolean;
    procedure EnableControls;
    procedure ComputeTotals;
    procedure GetBalance(const iAccountID: integer);
    procedure GetDepositLines(const iAccountID: integer; AClear: Boolean = True);
    procedure GetWithdrawalLines(const iAccountID: integer; AClear: Boolean = True);
    procedure InitGrid;
    procedure LoadTransactions(AClear: Boolean = True);
    procedure UpdateTransactions;
    procedure MatchSavedTrans;
    procedure SaveVerifyPref(Sender: TObject; Checked: boolean) ;
    procedure SearchAmount(Sender: TObject; SearchGrid: TAdvStringGrid; SearchEdit: TwwDbEdit; SearchForward: boolean = true);
    Procedure ReportInvalidReconToERP(const Value:String);
    function LoadGrid(Grid: TADvStringGrid; Qry: TERPQuery): Boolean;
    procedure CalcDeposittotal;
    procedure CalcWithDrawaltotal;
    procedure ReadguiPref;
    procedure WriteGuiPrefs;
    procedure CalcGridSelectedTotal(grd, grdSum: TAdvStringGrid);
    procedure SetGridcolwidth(Grd: TAdvStringGrid; ACol, AWidth: Integer);
    function IsStatementColumn(const aCol: integer): boolean;
    function RowForId(aGrid: TAdvStringGrid; const aPayId, aPayLineID: integer): integer;
    Function HasBankStatementItems:Boolean;
    procedure NewBusObjinstance;
    function SaveRecord: Boolean;
    procedure Openrec;
    procedure AddSelectAll(AGrid: TAdvStringGrid);
    procedure AASelectAll(AGrid: TAdvStringGrid; ASelect: Boolean);
    procedure PopulateGridFromDBcallback(const Sender: TBusObj;var Abort: boolean);
    procedure DeleterecLine(Grd: TAdvStringGrid; ARow: Integer;
      recline: TReconciliationLineBase);
    procedure SearchText(Colno: Integer; Searchvalue: String;
      SearchGrid: TAdvStringGrid);
    function AmountFromGrig(grd : TAdvStringGrid; arow: Integer): Double;
    procedure RefreshOnHoldnfinsihed;
    procedure DeleteLinesIfAfterRecondate;
    procedure ClearGrid(grd: TAdvStringGrid; AClear: Boolean = True);
    procedure InitRecObj(RecLineType:TStatementRecType);
    procedure CheckForStatementRec(Lines: TGUIReconciliationLines;RecLineType: TStatementRecType);
    procedure AddGridLine(Lines: TGUIReconciliationLines; RecLineType: TStatementRecType);
    function  FindInvoice(AAmount: Extended; AStatementDesc : string; ATxnDate: TDateTime) : Integer;
    function  FindPO(AAmount: Extended; AStatementDesc : string; ATxnDate: TDateTime) : Integer;
    //function StatementRecType(RecLineType: TStatementRecType): TStatementRecType;
  protected
    WasDeleted: boolean;
    ReconciliationObj : TReconciliation;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  const
    ReportTempTbl = 'ReconciliationReport';
    COL_OK       = 0;
    COL_DATE     = 1;
    COL_REF      = 2;
    COL_PAYEE    = 3;
    COL_NOTES    = 4;
    COL_AMOUNT_FMT = 5;
    COL_BANK_OK  = 6;
    COL_STATEMENT_DATE = 7;
    COL_STATEMENT_AMOUNT_FMT = 8;
    COL_STATEMENT_DESC = 9;
    COL_SELECT = 10;
    COL_ADD_RULE = 11;

    COL_AMOUNT   = 12;
    COL_STATEMENT_AMOUNT = 13;
    COL_PAY_ID   = 14;
    COL_PAY_LineID = 15;
    COL_CLIENT_ID = 16;
    COL_BSL_ID = 17;
    COL_RECON_ID = 18;
    COL_DEP_ID   = 19;


    CR           = #13;
    CAPTION_GO   = '&Go';
    CAPTION_NEXT = '&Next';
    MAXLOOP = 1000; // to avoid a runaway while loop
    procedure KeyIdChanged(const NewKeyId: integer); override;
    function GetReportTypeID: integer; override;
    //function NotDeleted: boolean;
    Function GetMainTablename: String; override;
    function PostRecToDB(const bFinished: boolean;const TempEndingBalance: currency; var msg: string): boolean;
    Function PostWithdrawalRecToDB(ARow:Integer; bFinished: boolean):Boolean;
    Function GetLinkedStatements(AGrid: TAdvStringGrid; AReconId: string) : string;
    Function PostDepositRecToDB(ARow:Integer;bFinished:Boolean):Boolean;
    Procedure AfterFormShow; Override;
  public
    procedure CommitTransaction; Override;
    procedure BeginTransaction; Override;
    procedure RollbackTransaction; Override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  end;



implementation

uses
  DNMExceptions,   PayCommon,
  FormFactory,  CommonDbLib, frmcustPayments, frmJournalEntry,
  frmSuppPayments, frmDepositfrm, frmDepositEntry, frmCheque, frmCustPrepayments,
  frmSuppPrepayments, StrUtils, ReconciliationFlagsObj, UserLockObj, Math,
  Types, tcDataUtils, Commonlib,systemlib,  AppEnvironment, FastFuncs,tcConst, UserLockBaseObj,
  AppDatabase,  MySQLConst, ERPErrorEmailUtils, ERPVersionConst, CommonFormLib, DocReaderObj,
  LogLib , BusObjConst, CoreEDIUtils, EmailUtilsDefaultMailClient, BusObjBankReconciliationRules, PaymentsLib;


  {$R *.dfm}


//var
  //iAccountID: integer;
  //rBalance: currency;
  //iWithdrawalCount: integer;
  //iDepositCount: integer;
  //rClearedBal: currency;
  //rDepositAmount: currency;
  //rWithdrawalAmount: currency;

procedure TReconciliationGUI.FormShow(Sender: TObject);
var
  LastRec: boolean;
begin
  DisableForm;
  UseStatements := AppEnv.CompanyPrefs.YodleeEnabled;//CheckYodleeEnabled(wsClient);

  try
    if (KeyId = 0) then begin
      if not UserLock.Lock('tblreconciliation', KeyId, 'Reconciliation') then begin
        AccessLevel := 6;
        CommonLib.MessageDlgXP_Vista('Currently the User "' + UserLock.LockInfo.Username + '" is Reconciling. Try Again Later.', mtWarning, [mbOK], 0);
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
        Exit;
      end;
    end;

    OnShowFinished := False;
    try
      //Access is Full Or None
      if AccessLevel <> 1 then AccessLevel := 6;

      inherited;
      if UseStatements then begin
         Self.Width := 1485;
      end
        else Self.width := 1040;

      //Check If ON HOLD
      KeyID := ProcessOnHold;
      if (KeyID = -1) then Exit;
      Openrec;

      qryAccount.Parambyname('AccountId').AsInteger := ReconciliationObj.AccountID;
      qryAccount.Open;

      if KeyID = 0 then begin
        Label3.Visible     := False;
        chkDeleted.Visible := False;
      end else begin
        Label3.Visible     := True;
        chkDeleted.Visible := True;
        LastRec := CheckIfLastReconciliation;
        Label3.Enabled := LastRec;
        chkDeleted.Enabled := LastRec;
      end;
      BeginTransaction;

      //InitVar;
      //InitTotals;
      InitGrid;

      if KeyID <> 0 then begin
        { On HOLD or FINISHED REC }
        bIsNew := false;
        cboAccount.ReadOnly := true;
        cboAccount.Enabled := false;

        if ReconciliationObj.Finished then begin
          { FINISHED }
          btnPrint.Enabled := true;
          btnPrintReport.Enabled := true;
          dtDate.Enabled := false;
          grdDeposits.Enabled := true;
          grdWithdrawals.Enabled := true;
          //rBalance := ReconciliationObj.OpenBalance;
          //rClearedBal := ReconciliationObj.Balance ;

          PopulateGridFromDB(ReconciliationObj.Depositlines);//( KeyID, 'tblReconciliationDepositLines', grdDeposits);
          PopulateGridFromDB(ReconciliationObj.Withdrawallines);//(KeyID, 'tblReconciliationWithdrawalLines', grdWithdrawals);

          btnMarkAllClick(Self);
          WasDeleted := ReconciliationObj.Deleted;
          try if goEditing in grdDeposits.Options     then grdDeposits.Options    := grdDeposits.Options    - [goEditing];except end;
          try if goEditing in grdWithdrawals.Options  then grdWithdrawals.Options := grdWithdrawals.Options - [goEditing];except end;
        end else begin
          { ON HOLD }
          //iOnHoldID := KeyID;
          ReconciliationObj.Edit;
          PopulateGridFromDB(ReconciliationObj.Depositlines);//( KeyID, 'tblReconciliationDepositLines', grdDeposits);
          PopulateGridFromDB(ReconciliationObj.Withdrawallines);//(KeyID, 'tblReconciliationWithdrawalLines', grdWithdrawals);

          btnMarkAllClick(Self);
          LoadTransactions(False);
          //MatchSavedTrans;
          if RemovePrevRecons(true) then begin
            ReconciliationObj.CloseBalance := 0.00;
            edtCloseBal.Text := '';
          end else begin
            CommonLib.MessageDlgXP_Vista('Selected record is being reconciled by somebody else. Try again later', mtInformation, [mbOK], 0);
            PostMessage(Self.Handle, WM_CLOSE, 0, 0);
            Exit;
          end;
        end;
        ReconciliationObj.CalcTotals;
        DisplayBalances(true);
      end else begin
        { NEW }
        bIsNew := true;
        Reconciliationobj.New;
        Reconciliationobj.ReconciliationDate := Now;
        DisplayBalances(false);
      end;

      btnWithdrawalsNext.Enabled  := Reconciliationobj.withdrawallines.count > 0;
      btnDepositNext.Enabled      := Reconciliationobj.Depositlines.count    > 0;

      OnShowFinished := true;
      ReadguiPref;

      if (ReconciliationObj.AccountID> 0) and (not ReconciliationObj.Finished) then begin
        btnCheque.Enabled:= true;
        btnDeposit.Enabled:= true;
      end
      else begin
        btnCheque.Enabled:= false;
        btnDeposit.Enabled:= false;
      end;

      dtDate.Modified := false;
      CalcDeposittotal;
      CalcWithDrawaltotal;
      If UseStatements then begin
        SetGridcolwidth(grdWithdrawals ,COL_OK ,80 );
        SetGridcolwidth(grdDeposits ,   COL_OK ,80 );
        SetGridcolwidth(grdWithdrawals ,COL_SELECT ,80 );
        SetGridcolwidth(grdDeposits ,   COL_SELECT ,80 );
        SetGridcolwidth(grdWithdrawals ,COL_ADD_RULE ,80 );
        SetGridcolwidth(grdDeposits ,   COL_ADD_RULE ,80 );
      end else begin
        SetGridcolwidth(grdWithdrawals ,COL_OK ,40 );
        SetGridcolwidth(grdDeposits ,   COL_OK ,40 );
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    RefreshOnHoldnfinsihed;
    EnableForm;
  end;
end;

procedure TReconciliationGUI.AddSelectAll(AGrid: TAdvStringGrid);
var
  i : Integer;
begin
  if not UseStatements then exit;
  if ReconciliationObj.Finished then exit;
  if AGrid.RowCount = 1 then exit;
  AGrid.AddButton(COL_SELECT, 0, 80,20,'Select All',haLeft, vaCenter);
  for i := 1 to AGrid.RowCount -1 do begin
    if AGrid.HasCheckBox(COL_OK,i) then Continue;
    if ((AGrid.HasCheckBox(COL_BANK_OK, i)) and (AGrid.Cells[COL_BANK_OK, i] = 'T')) then Continue;
    AGrid.AddCheckBox(COL_SELECT, i, false, false);
  end;
end;

procedure TReconciliationGUI.AASelectAll(AGrid: TAdvStringGrid; ASelect: Boolean);
var
  i : Integer;
begin
  if not UseStatements then exit;
  if AGrid.RowCount = 1 then exit;

  for i := 1 to AGrid.RowCount -1 do begin
    if not AGrid.HasCheckBox(COL_SELECT,i) then Continue;
    AGrid.SetCheckBoxState(COL_SELECT, i, ASelect);
  end;
end;

procedure TReconciliationGUI.InitGrid;
begin
  //if UseStatements then self.Width        := 1500 else Self.Width := 1000;

  if not devmode then  grdDeposits.HideColumn(COL_CLIENT_ID);
  if not devmode then  grdDeposits.HideColumn(COL_PAY_LineID);
  if not devmode then  grdDeposits.HideColumn(COL_PAY_ID);
  if not devmode then  grdDeposits.HideColumn(COL_DEP_ID);
  if not devmode then  grdDeposits.HideColumn(COL_AMOUNT);
  if not devmode then  grdDeposits.HideColumn(COL_RECON_ID);
  if not devmode then  grdDeposits.HideColumn(COL_BSL_ID);
  if not devmode then  grdDeposits.HideColumn(COL_STATEMENT_AMOUNT);

  grdDeposits.CheckTrue  := 'T';
  grdDeposits.CheckFalse := 'F';

  if not devmode then  grdWithDrawals.HideColumn(COL_CLIENT_ID);
  if not devmode then  grdWithDrawals.HideColumn(COL_PAY_LineID);
  if not devmode then  grdWithDrawals.HideColumn(COL_PAY_ID);
  if not devmode then  grdWithDrawals.HideColumn(COL_DEP_ID);
  if not devmode then  grdWithDrawals.HideColumn(COL_AMOUNT);
  if not devmode then  grdWithDrawals.HideColumn(COL_RECON_ID);
  if not devmode then  grdWithDrawals.HideColumn(COL_BSL_ID);
  if not devmode then  grdWithDrawals.HideColumn(COL_STATEMENT_AMOUNT);

  grdWithdrawals.CheckTrue  := 'T';
  grdWithdrawals.CheckFalse := 'F';
  if UseStatements then begin
    grdDeposits.ColumnHeaders[COL_OK]    := 'ERP Select';
    grdWithDrawals.ColumnHeaders[COL_OK] := 'ERP Select';
  end
  else begin
    grdDeposits.HideColumn(COL_STATEMENT_DATE);
    grdDeposits.HideColumn(COL_STATEMENT_AMOUNT);
    grdDeposits.HideColumn(COL_STATEMENT_DESC);
    grdDeposits.HideColumn(COL_BANK_OK);
    grdDeposits.HideColumn(COL_STATEMENT_AMOUNT_FMT);
    grdDeposits.HideColumn(COL_SELECT);
    grdDeposits.HideColumn(COL_ADD_RULE);
    grdDeposits.ColumnHeaders[COL_OK]    := 'OK';

    grdWithDrawals.HideColumn(COL_STATEMENT_DATE);
    grdWithDrawals.HideColumn(COL_STATEMENT_AMOUNT);
    grdWithDrawals.HideColumn(COL_STATEMENT_DESC);
    grdWithDrawals.HideColumn(COL_BANK_OK);
    grdWithDrawals.HideColumn(COL_STATEMENT_AMOUNT_FMT);
    grdWithDrawals.HideColumn(COL_SELECT);
    grdWithDrawals.HideColumn(COL_ADD_RULE);
    grdWithDrawals.ColumnHeaders[COL_OK] := 'OK';
  end;
//  EnableControls;
end;

procedure TReconciliationGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPrefs;
  inherited;
  dtDate.OnChange:= nil;
  CloseQueries;
  Action := caFree;
end;


function TReconciliationGUI.ProcessDelete: boolean;
begin
  str := 'ProcessDelete';
  Result := False;
  if Reconciliationobj.ProcessDelete then begin
    CommitTransaction;
    if CommitFailed then Exit;
    Notify;
    Result := True;
    Close;
  end;
end;

procedure TReconciliationGUI.SaveVerifyPref(Sender: TObject; Checked: boolean);
begin
  FDontAskAgain := Checked;
end;

function TReconciliationGUI.OkToSave(const bFinished: boolean): boolean;
begin
  Result := false;
  if ((Trim(edtCloseBal.Text) = '') and (bFinished))  then begin
    CommonLib.MessageDlgXP_Vista('You must enter a valid ending balance!',
      mtWarning, [mbOK], 0);
    SetControlFocus(edtCloseBal);
    exit;
  end;
  if not (RoundCurrency(StrValue(lblClearedBal.Caption)) = RoundCurrency(StrValue(lblEndBal.Caption))) and bFinished then
  begin
    CommonLib.MessageDlgXP_Vista('The Cleared Balance must match the Ending Balance you entered!',
      mtWarning, [mbOK], 0);
    SetControlFocus(edtCloseBal);
    exit;
  end;
  if (TotalCountBankDep = 0) and (TotalCountBankWrt =0) then //and bFinished then
  begin
    CommonLib.MessageDlgXP_Vista('No transactions have been cleared!',
      mtWarning, [mbOK], 0);
    SetControlFocus(edtCloseBal);
    exit;
  end;
  if trim(edtStatement.Text)='' then begin
    CommonLib.MessageDlgXP_Vista('You must enter a Statement Number',mtWarning, [mbOK], 0);
    Exit;
  end;
  Result := True;
  //REsult := ReconciliationObj.ValidateData;
end;
Procedure TReconciliationGUI.DeleterecLine(Grd: TAdvStringGrid;ARow:Integer;recline:TReconciliationLineBase);
begin
(*
                  if (recline.Locate('Notes;PaymentId;DepositLineID' , varArrayof([grd.Cells[COL_NOTES, ARow],grd.Cells[COL_PAY_ID, ARow],grd.Cells[COL_PAY_LineID, ARow]]), [])) then begin
                    try
                      recline.delete;
                      ReconciliationObj.CalcTotals;
                      DisplayBalances(true);
                    except
                      on E:Exception do begin
                        logtext(E.Message);
                        //recline.ExecuteSQL('Delete from ' + recline.BusObjectTableName +' where ' + recline.IDFieldName +' = '+ inttostr(recline.ID), true);
                      end;
                    end;
                  end;
*)

end;

function TReconciliationGUI.PostRecToDB(const bFinished: boolean;
  const TempEndingBalance: currency; var msg: string): boolean;
var
  i: integer;
  //ReconciliationRecord: TReconciliationInfo;
  //UpdateSQL: TStringList;
  SavePointName: string;
  cmdSavePoint: TMyCommand;
  qry: TERPQuery;
begin
      Result:= true;
      //  # 1
      Reconciliationobj.EmployeeId:= AppEnv.Employee.EmployeeID;
      Reconciliationobj.ClassID   := AppEnv.DefaultClass.ClassID;
      Reconciliationobj.Deleted   := False;
      Reconciliationobj.Finished  := bFinished;
      if not bFinished then Reconciliationobj.CloseBalance:= TempEndingBalance;
      Reconciliationobj.Postdb;
      Reconciliationobj.DepositLines.DeleteAll();
      Reconciliationobj.WithdrawalLines.DeleteAll();


      //  # 2
            with grdDeposits do begin
              for i := 1 to RowCount - 1 do begin
                if  grdDeposits.Cells[COL_OK,i] <> grdDeposits.CheckTrue then Continue;
                if ((UseStatements) and (grdDeposits.Cells[COL_RECON_ID,i] = '')) then Continue;
                PostDepositRecToDB(i,bfinished);
              end;
            end;

      //  # 3
      with grdWithdrawals do begin
            for i := 1 to RowCount - 1 do begin
              if  grdWithdrawals.Cells[COL_OK,i] <> grdWithdrawals.CheckTrue then Continue;
              if ((UseStatements) and (grdWithdrawals.Cells[COL_RECON_ID,i] = '')) then Continue;

              PostWithdrawalRecToDB(i , bFinished);
            end;
      end;
      {================================================================}

      Result := True;
end;


procedure TReconciliationGUI.btnSaveCloseClick(Sender: TObject);
  function HasTransLines: Boolean;
  begin
    Result := (Reconciliationobj.DepositLines.Count > 0) or
             (Reconciliationobj.WithdrawalLines.Count > 0)
  end;
begin
  if not SaveRecons(True) then Exit;
  Self.Close;
end;

procedure TReconciliationGUI.btnSaveCloseEnter(Sender: TObject);
begin
  inherited;
  Application.processmessages;
end;

procedure TReconciliationGUI.btnStrictMatchClick(Sender: TObject);
var
  i : integer;
begin
  inherited;
  if not UseStatements then exit;
  for i := 0 to MAXLOOP do begin  // this should be an infinite loop, but just to play safe
    if FullStrictMatchClick(srtDeposit) then break;
  end;
  for i := 0 to MAXLOOP do begin  // this should be an infinite loop, but just to play safe
    if FullStrictMatchClick(srtWithdrawl) then break;
  end;
end;

function TReconciliationGUI.FullStrictMatchClick(AStatementRecType: TStatementRecType): Boolean;
var
  i                : integer;
  ThisStatementRec : TStatementRec;
  BankRow          : integer;
begin
  inherited;
  Result := False;
  if AStatementRecType = srtDeposit then
  begin
    for i := 1 to grdDeposits.RowCount -1 do begin
      if StrToIntDef(grdDeposits.Cells[COL_BSL_ID, i],0) > 0 then
        ThisStatementRec := StatementRecList.ItemByID(srtDeposit,StrToIntDef(grdDeposits.Cells[COL_BSL_ID, i],0))
      else
        Continue;
      if ThisStatementRec = Nil     then Continue;
      if ThisStatementRec.PayID > 0 then Continue;
      BankRow := findMatchingBankRow(srtDeposit, ThisStatementRec, True);
      if BankRow >= 0 then begin
        grdDeposits.Cells[COL_OK, BankRow] := grdDeposits.CheckTrue;
        grdDeposits.Cells[COL_BANK_OK, i] := grdDeposits.CheckTrue;
        OrientRows(grdDeposits);
        Result := True;
        exit;
      end;
    end;
  end;

  if AStatementRecType = srtWithdrawl then
  begin
    for i := 0 to grdWithDrawals.RowCount -1 do begin
      if StrToIntDef(grdWithDrawals.Cells[COL_BSL_ID, i],0) > 0 then
        ThisStatementRec := StatementRecList.ItemByID(srtWithdrawl,StrToIntDef(grdWithDrawals.Cells[COL_BSL_ID, i],0))
      else
        Continue;
      if ThisStatementRec = Nil     then Continue;
      if ThisStatementRec.PayID > 0 then Continue;
      BankRow := findMatchingBankRow(srtWithdrawl, ThisStatementRec, True);
      if BankRow >= 0 then begin
        grdWithDrawals.Cells[COL_OK, BankRow] := grdDeposits.CheckTrue;
        grdWithDrawals.Cells[COL_BANK_OK, i] := grdDeposits.CheckTrue;
        OrientRows(grdWithDrawals);
        Result := True;
        exit;
      end;
    end;
  end;
  ComputeTotals;
  grdDeposits.InValidate;
  grdWithDrawals.InValidate;
  DisplayBalances(True);
  Result := True;
end;

function TReconciliationGUI.findMatchingBankRow(AStatementRecType: TStatementRecType; AStatementRec:TStatementRec; AStrict: Boolean): integer;
var
  i : integer;
  thisGrid: TAdvStringGrid;
  bAmountMatched: Boolean;
  bDateMatched: Boolean;
  bRefMatched: Boolean;
  bCustMatched: Boolean;
  sSQL: string;
  qry: TERPQuery;
begin
  Result := -1;
  if ((Settings.State[0] = cbUnchecked) and (Settings.State[1] = cbUnchecked)
            and (Settings.State[2] = cbUnchecked) and (Settings.State[3] = cbUnchecked)) then exit;
  if AStatementRecType = srtDeposit then thisGrid := grdDeposits else thisGrid := grdWithDrawals;
  for i := 1 to thisGrid.RowCount -1 do begin
    if StrToIntDef(thisGrid.Cells[COL_RECON_ID,i],0) <> 0 then Continue;
    if StrToIntDef(thisGrid.Cells[COL_DEP_ID,i],0) <= 0 then Continue;
    if thisGrid.Cells[COL_OK,i] = thisGrid.checkTrue then Continue;
    if thisGrid.Cells[COL_BANK_OK,i] = thisGrid.checkTrue then Continue;

    bAmountMatched := ((Settings.State[0] = cbUnchecked) OR (thisGrid.Floats[COL_AMOUNT,i] = AStatementRec.StatementAmount));
    bDateMatched := ((Settings.State[3] = cbUnchecked) OR (StrToDate(thisGrid.Cells[COL_DATE,i]) = AStatementRec.TransactionDate));
    bRefMatched := True; // (thisGrid.Floats[COL_NOTES,i] = AStatementRec.StatementDescription);
    bCustMatched := (Settings.State[1] = cbUnchecked); // OR (thisGrid.Cells[COL_PAYEE,i] = AStatementRec.StatementDescription));
    if Settings.State[1] = cbchecked then begin
      sSQL := 'SELECT payee FROM tblbankreconciliationrules WHERE MATCH (payee, StatementDesc) AGAINST (' +
               QuotedStr(AStatementRec.StatementDescription) + ' IN NATURAL LANGUAGE MODE) LIMIT 1';
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;
        qry.SQL.Text := sSQL;
        qry.Open;
        bCustMatched := (qry.RecordCount = 1);
        qry.Close;
      finally
        qry.Free;
      end;
    end;
    if ((bAmountMatched) and (bDateMatched) and (bRefMatched) and (bCustMatched)) then begin
       Result := i;
       Break;
    end;

//    if AStrict then begin
//      if ((thisGrid.Floats[COL_AMOUNT,i] = AStatementRec.StatementAmount) and (thisGrid.Ints[COL_PAY_ID,i] > 0)
//         and (StrToDate(thisGrid.Cells[COL_DATE,i]) = AStatementRec.TransactionDate)
//         and (thisGrid.Cells[COL_NOTES,i] = AStatementRec.StatementDescription) ) then begin
//              Result := i;
//              break;
//      end;
//    end else begin
//      if ((thisGrid.Floats[COL_AMOUNT,i] = AStatementRec.StatementAmount) and (thisGrid.Ints[COL_PAY_ID,i] > 0)) then begin
//        Result := i;
//        break;
//      end;
//    end;
  end;
end;

function TReconciliationGUI.SaveRecons(const bFinished: boolean): boolean;
var
  TempEndingBalance: currency;
  msg: string;
begin
  Result := False;

  btnSaveClose.Enabled := True;
  //if not LockselectedTrans then exit;
  // Delete
  if ProcessDelete() then Exit;

  TempEndingBalance := 0.00;
  if not bFinished then begin
    TempEndingBalance := RoundCurrency(ReconciliationObj.CloseBalance);
    ReconciliationObj.CloseBalance := RoundCurrency(ReconciliationObj.Balance);
  end;
  //ReconciliationObj.SumClearedDeposits    := TotalSumBankDep;
  //ReconciliationObj.SumClearedWithDrawals := TotalSumBankWrt;
  ReconciliationObj.CalcTotals;
  //ReconciliationObj.CloseBalance          := FloatToCurr(StrValue(edtOpenBal.Text)) + ReconciliationObj.SumClearedDeposits - ReconciliationObj.SumClearedWithDrawals;
  //ReconciliationObj.Balance               := ReconciliationObj.OpenBalance + ReconciliationObj.SumClearedDeposits - ReconciliationObj.SumClearedWithDrawals;
  if not OkToSave(bFinished) then Exit;

  if not PostRecToDB(bFinished, TempEndingBalance, msg) then Exit;

  if not Reconciliationobj.Save then Exit;

  str := 'SaveRecons';
  CommitTransaction;
  if CommitFailed then Exit;
  Result := True;
  if bFinished then begin
    // print report if required
    if CommonLib.MessageDlgXP_Vista('Would you like to Print Reconciliation Reports', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      btnPrint.Click;
      btnPrintReport.Click;
    end;
  end;
  Notify;
end;

procedure TReconciliationGUI.btnChequeClick(Sender: TObject);
var
  ChequeForm: TfmCheque;
begin
  inherited;
  ChequeForm:= TfmCheque.Create(self);
  ChequeForm.KeyID:= 0;
  ChequeForm.GLAccountId:= ReconciliationObj.AccountID;
  ChequeForm.AttachObserver(self);
  ChequeForm.FormStyle:= fsMdiChild;
end;

procedure TReconciliationGUI.btnDepositClick(Sender: TObject);
var
  DepositForm: TDepositEntryGUI;
begin
  inherited;
  DepositForm:= TDepositEntryGUI.Create(self);
  DepositForm.KeyID:= 0;
  DepositForm.GLAccountId:= ReconciliationObj.AccountID;
  DepositForm.AttachObserver(self);
  DepositForm.FormStyle:= fsMdiChild;
end;

procedure TReconciliationGUI.getLastDepositAttributes;
var
  qry: TERPQuery;
begin
//  LastID:= 0;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT tdl.AccountName, tdl.PaymentMethod FROM tblbankdeposit d INNER JOIN ');
    qry.sql.add('tblbankdepositlines tdl ON d.depositid = tdl.depositid  ');
    qry.SQL.Add('and d.Deleted = "F"');
    qry.SQL.Add('WHERE tdl.TrnsType = ''Deposit Entry'' ');
    qry.SQL.Add('ORDER BY d.depositid DESC LIMIT 1');
    qry.Open;
    gLastDepPaymentMethod := qry.FieldByName('PaymentMethod').AsString;
    gLastDepFromAccount   := qry.FieldByName('AccountName').AsString;
    qry.Close;
  finally
    qry.Free;
  end;
end;

procedure TReconciliationGUI.getLastChequeAttributes;
var
  qry: TERPQuery;
begin
//  LastID:= 0;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT t.AccountName FROM tblbankdepositlines tdl INNER JOIN ');
    qry.sql.add('tblchartofaccounts t ON t.accountid = tdl.accountid  ');
    qry.SQL.Add('and tdl.Deleted = "F"');
    qry.sql.add('where tdl.trnstype = ''Cheque'' ');
    qry.SQL.Add('ORDER BY tdl.depositid DESC LIMIT 1');
    qry.Open;
    gLastChqAccount     := qry.FieldByName('AccountName').AsString;
    qry.Close;
  finally
    qry.Free;
  end;
end;

function TReconciliationGUI.FindInvoice(AAmount: Extended; AStatementDesc: String; ATxnDate: TDateTime): Integer;
var
  qry: TERPQuery;
  sSQL: string;
  ExactClientId: Integer;
begin
  Result := -1;
  sSQL := 'SELECT ClientId as ExactClientId FROM tempclient WHERE Customer = "T" AND MATCH (Company, PrintName) AGAINST(' +
            QuotedStr(AStatementDesc) + ' IN NATURAL LANGUAGE MODE) LIMIT 1';
  qry := TERPQuery.Create(nil);
  try
    ExactClientid := -1;
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := sSQL;
    qry.Open;
    if qry.RecordCount > 0 then ExactClientId := qry.FieldByName('ExactClientId').AsInteger;
    qry.Close;
    qry.SQL.Clear;
    if ExactClientid = -1 then Exit;
    SalesOutStandingTrans(qry, 0, 'INVOICE', 0, '', '', ExactClientId, ATxnDate, AAmount);
    LogText('INVOICE qry = ' + qry.SQL.Text);
    //qry.SQL.Text  := sSQL;
    qry.Open;
    if qry.RecordCount > 0 then Result := qry.FieldByName('SaleId').AsInteger;
    qry.Close;
  finally
    qry.Free;
  end;
end;

function  TReconciliationGUI.FindPO(AAmount: Extended; AStatementDesc : string; ATxnDate: TDateTime) : Integer;
var
  qry: TERPQuery;
  sSQL: string;
  ExactClientId: Integer;
begin
  Result := -1;
  sSQL := 'SELECT ClientId as ExactClientId FROM  tempclient  WHERE Supplier = "T" AND MATCH (Company, PrintName)  AGAINST('
  +  QuotedStr(AStatementDesc) +' IN NATURAL LANGUAGE MODE) LIMIT 1';  qry:= TERPQuery.Create(nil);
  try
    ExactClientid := -1;
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text  := sSQL;
    qry.Open;
    if qry.RecordCount > 0 then ExactClientId := qry.FieldByName('ExactClientId').AsInteger;
    qry.Close;
    qry.sql.clear;
    if ExactClientid = -1 then exit;
    POOutStandingTrans(qry, '', 0, '', '', ExactClientId, ATxnDate, AAmount);
    LogText('PO Query = ' + qry.SQL.Text);
    //qry.SQL.Text  := sSQL;
    qry.Open;
    if qry.RecordCount > 0 then Result := ExactClientId; //qry.FieldByName('ClientID').AsInteger;
    qry.Close;
  finally
    qry.Free;
  end;
end;

procedure TReconciliationGUI.bnCreateEntriesClick(Sender: TObject);
var
  Bankdeposit      : TBankDeposit;
  CustPayForm      : TfmCustPayments;
  ChequeForm       : TfmCheque;
  i                : Integer;
  ThisStatementRec : TStatementRec;
  qry              : TErpQuery;
  sAccountName     : string;
  DepositForm      : TDepositEntryGUI;
  ThisState        : Boolean;
  mr               : TModalResult;
  paymentId        : Integer;
  supplierId       : Integer;
begin
  inherited;
  FirstStmtDep := 1;
  for i := FirstStmtDep to grdDeposits.RowCount - 1 do begin
    if grdDeposits.Cells[COL_RECON_ID, i] <> '' then Continue;
    if grdDeposits.Cells[COL_STATEMENT_AMOUNT_FMT, i] = '' then Continue;
    grdDeposits.getCheckBoxState(COL_SELECT, i, ThisState);
    if not ThisState then Continue;
    FirstStmtDep := i;
    //check if a customer payment is possible
    paymentId := findInvoice(StrToFloatDef(grdDeposits.Cells[COL_STATEMENT_AMOUNT, i], 0), grdDeposits.Cells[COL_STATEMENT_DESC, i],
             StrToDate(grdDeposits.Cells[COL_STATEMENT_DATE, i]));
    if PaymentId > 0 then begin
      CustPayForm:= TfmCustPayments.Create(self);
      try
        CustPayForm.AttachObserver(self);
        CustPayForm.OpenForSalesId := PaymentId;
        mr := CustPayForm.ShowModal;
      finally
        CustPayForm.Free;
      end;
    end else begin
      if (AppEnv.CompanyPrefs.RememberLastReconDeposit) and (KeyID = 0) then getLastDepositAttributes;
      DepositForm:= TDepositEntryGUI.Create(self);
      try
        DepositForm.KeyID:= 0;
        DepositForm.GLAccountId           := ReconciliationObj.AccountID;
        DepositForm.AttachObserver(self);
        DepositForm.cmdNew.Enabled := False;
        DepositForm.LineNotes    := grdDeposits.Cells[COL_STATEMENT_DESC, i];
        DepositForm.Amount       := StrToFloatDef(grdDeposits.Cells[COL_STATEMENT_AMOUNT, i],0);
        DepositForm.PayDate      := StrToDate(grdDeposits.Cells[COL_STATEMENT_DATE, i]);
        DepositForm.PaymentMethod:= gLastDepPaymentMethod;
        DepositForm.FromAccount  := gLastDepFromAccount;
        DepositForm.Notes.Text   := grdDeposits.Cells[COL_STATEMENT_DESC, i];
        DepositForm.Payee        := Copy(grdDeposits.Cells[COL_STATEMENT_DESC, i],1,20);
        mr                       := DepositForm.ShowModal;
        if mr = mrOK then  InsertRule(grdDeposits.Cells[COL_STATEMENT_DESC, i], DepositForm.Payee) ;
      finally
        DepositForm.Free;
      end;
    end;
    if mr <> mrOK then begin
       FirstStmtDep := i + 1;
       break;
    end;
  end;

  FirstStmtDep := 1;
  for i := FirstStmtDep to grdWithdrawals.RowCount -1 do begin
    if grdWithdrawals.Cells[COL_RECON_ID, i] <> '' then Continue;
    if grdWithdrawals.Cells[COL_STATEMENT_AMOUNT_FMT, i] = '' then Continue;
    grdWithdrawals.getCheckBoxState(COL_SELECT, i, ThisState);
    if not ThisState then Continue;
    FirstStmtDep := i;
    //check if a supplier payment is possible
    SupplierId := findPO(StrToFloatDef(grdWithdrawals.Cells[COL_STATEMENT_AMOUNT, i],0), grdWithdrawals.Cells[COL_STATEMENT_DESC, i],
             StrToDate(grdWithdrawals.Cells[COL_STATEMENT_DATE, i]));
    if SupplierId > 0 then begin
      with TfmSuppPayments.Create(Self) do try
          KeyID := 0;
          ExtSupplierId := SupplierId;
          Position := poScreenCenter;
          ShowModal;
        finally
          Free;
        end;
    end else begin
      if (AppEnv.CompanyPrefs.RememberLastReconDeposit) and (KeyID = 0) then getLastChequeAttributes;
      ChequeForm   := TfmCheque.Create(Self);
      try
        ChequeForm.KeyID:= 0;
        ChequeForm.GLAccountId           := ReconciliationObj.AccountID;
        ChequeForm.AttachObserver(self);
        ChequeForm.btnNext.Enabled := False;
        ChequeForm.SupplierName := grdWithdrawals.Cells[COL_STATEMENT_DESC, i];
        ChequeForm.AccountName  := gLastChqAccount;
        ChequeForm.ChequeAmount := StrToFloatDef(grdWithdrawals.Cells[COL_STATEMENT_AMOUNT, i],0);
        ChequeForm.PayDate      := StrToDate(grdWithdrawals.Cells[COL_STATEMENT_DATE, i]);
        ChequeForm.Notes        := grdWithdrawals.Cells[COL_STATEMENT_DESC, i];
        mr                      := ChequeForm.ShowModal;
        if  mr = mrOK then InsertRule(grdWithdrawals.Cells[COL_STATEMENT_DESC, i], ChequeForm.SupplierName) ;
      finally
        ChequeForm.Free;
      end;
    end;
    if mr <> mrOK then begin
       FirstStmtDep := i + 1;
       break;
    end;
  end;
  btnRelaxedMatchClick(Nil);

  grdDeposits.SetCheckBoxState(COL_SELECT, 0, False);
  btnRelaxedMatchClick(Nil);
  grdWithdrawals.SetCheckBoxState(COL_SELECT, 0, False);
end;


procedure TReconciliationGUI.bnRulesClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TReconRulesListFormGUI' , 0);
end;

function  TReconciliationGUI.MoveRows(AStartRow: Integer; AFirstRow: Integer; AGrid: TADvStringGrid; AColId: Integer) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := AStartRow to AGrid.RowCount -1 do begin
    if ((AGrid.Cells[AColId, i] = AGrid.CheckTrue) and (AGrid.Cells[COL_RECON_ID, i] = '')) then begin
       AGrid.Cells[COL_RECON_ID, i] := IntToStr(gNextReconId);
       AGrid.MoveRow(i,AFirstRow);
       Result := i+1;
       break;
    end;
  end;
end;

procedure TReconciliationGUI.OrientRows(AGrid: TAdvStringGrid);
var
  i            : Integer;
  AStartRow    : Integer;
  AFirstRow    : Integer;
  ABSLRow      : Integer;
  AStartERPRow : Integer;
  AMoveToRow   : integer;
  RemoveCount  : integer;
begin
  //first pass, bring the erp rows together
  AFirstRow    := 1;
  RemoveCount  := 0;
  AStartRow    := AFirstRow;
  gNextReconId := gNextReconId + 1;
  while (AStartRow <> -1) do begin
    AStartRow := MoveRows(AStartRow, AFirstRow, AGrid, COL_OK);
    AFirstRow := AFirstRow + 1;
  end;

  //second pass, bring the bank rows together
  AStartRow := 1;
  ABSLRow   := -1;
  AFirstRow := AFirstRow - 1;
  if AFirstRow = -1 then exit;
  while (AStartRow <> -1) do begin
    AStartRow := MoveRows(AStartRow, AFirstRow, AGrid, COL_BANK_OK);
    if AStartRow <> -1 then ABSLRow   := AStartRow;
    AFirstRow := AFirstRow + 1;
  end;

  // third pass, merge statement rows into erp rows
  AMoveToRow := 1;
  for i := 1 to AFirstRow -1 do begin
     if AGrid.Cells[COL_RECON_ID, i] = '' then Continue;
     if AGrid.Cells[COL_BANK_OK, i]  = '' then Continue;
     if AGrid.Cells[COL_BANK_OK, i]  = 'F' then Continue;

     if AGrid.Ints[COL_RECON_ID, i] = gNextReconId then begin
       MergeRows(i, AMoveToRow, AGrid);
       AGrid.RemoveCheckBox(COL_SELECT, AMoveToRow);
       AMoveToRow := AMoveToRow + 1;
     end;
  end;
  //now delete the moved rows
  for i := AMoveToRow  to AGrid.RowCount do begin
     if AGrid.Cells[COL_RECON_ID, i] = '' then Continue;
     if AGrid.Cells[COL_BANK_OK, i]  = '' then Continue;
     if AGrid.Cells[COL_BANK_OK, i]  = 'F' then Continue;
     if AGrid.Cells[COL_OK, i]       = 'T' then Continue;
     if AGrid.Ints[COL_RECON_ID, i] = gNextReconId then begin
       Inc(RemoveCount);       //AGrid.RemoveRows(i,1);
     end;
  end;
  //showmessage(Format('remove count = %d starting from %d', [RemoveCount, AMoveToRow]));
  AGrid.RemoveRows(AMoveToRow, RemoveCount);
  AGrid.InValidate;
end;

function  TReconciliationGUI.MergeRows(AFromRow: Integer; AToRow: Integer; AGrid: TADvStringGrid) : Integer;
var
  i : Integer;
begin
  Result := -1;

  With AGrid do begin
    AddCheckBox(COL_BANK_OK, AToRow, false, true);
    Cells[COL_BANK_OK, AToRow]                := Cells[COL_BANK_OK, AFromRow];
    Cells[COL_STATEMENT_DATE, AToRow]         := Cells[COL_STATEMENT_DATE, AFromRow];
    Cells[COL_STATEMENT_AMOUNT_FMT, AToRow]   := Cells[COL_STATEMENT_AMOUNT_FMT, AFromRow];
    Cells[COL_STATEMENT_DESC, AToRow]         := Cells[COL_STATEMENT_DESC, AFromRow];
    Cells[COL_STATEMENT_AMOUNT, AToRow]       := Cells[COL_STATEMENT_AMOUNT, AFromRow];
    Cells[COL_BSL_ID, AToRow]                 := Cells[COL_BSL_ID, AFromRow];
  end;
end;

function  TReconciliationGUI.BlankRows(ARow: Integer; AGrid: TADvStringGrid) : Integer;
var
  i : Integer;
begin
  Result := -1;
  With AGrid do begin
    RemoveCheckBox(COL_BANK_OK, ARow);
    RemoveCheckBox(COL_SELECT, ARow);
    Cells[COL_BANK_OK, ARow]                := '';
    Cells[COL_STATEMENT_DATE, ARow]         := '';
    Cells[COL_STATEMENT_AMOUNT_FMT, ARow]   := '';
    Cells[COL_STATEMENT_DESC, ARow]         := '';
    Cells[COL_STATEMENT_AMOUNT, ARow]       := '';
    Cells[COL_BSL_ID, ARow]                 := '';
  end;
end;


procedure TReconciliationGUI.btnBankTransactionsClick(Sender: TObject);
begin
  inherited;
  exit; //kashi for now
  if UseStatements then RunImportBankTransactions
  else begin
    AfterFormShow;
  end;
  //OpenERPListForm('TBankStatementLineListGUI');
end;

procedure TReconciliationGUI.RunImportBankTransactions;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
  JSubObject        : TJSONObject;
  JArray            : TJSONArray;
  idx               : Integer;
  idConnection      : integer;
  ProgDlg           : TProgressDialog;
  i                 : Integer;
begin
  if not UseStatements then begin
    AfterFormShow;
    exit;
  end;
  ProgDlg := TProgressDialog.Create(nil);
  try
    ProgDlg.Caption  := 'Checking CoreEDI Access';
    ProgDlg.MaxValue := 10;
    ProgDlg.Value    := 1;
    ProgDlg.TimerUpdate := true;
    ProgDlg.Execute;
    wsClient.Host       := AppEnv.CompanyPrefs.CoreEDIServiceHost;
    wsClient.Port       := AppEnv.CompanyPrefs.CoreEDIServicePort;
    try
      if ((AppEnv.CompanyPrefs.CoreEDIServiceUserName <> '') and (AppEnv.CompanyPrefs.CoreEDIServicePassword <> '')) then begin
        wsClient.Active     := True;
        sleep(1000);
      end;
      if not wsClient.Active then begin
        ProgDlg.TimerUpdate := False;
        ProgDlg.CloseDialog;
        exit;
      end;
      ProgDlg.Caption  := 'Getting Yodlee Bank Statement Download Job Parameters';
      ProgDlg.MaxValue := 10;
      ProgDlg.Value    := 1;
      ProgDlg.TimerUpdate := true;
      ProgDlg.Execute;

      sJSON       := BuildJSON('GetConnections');
      sResult     := wsClient.WriteAndWaitData(sJSON);
      JObject     := JO(sResult);
      JSubObject  := JO(JObject.S['Content']);
      JArray      := JSubObject.A['Connections'];

      for idx := 0 to JArray.Count -1 do begin
        if TJSONObject(JArray[idx]).S['ConnectingSoftware'] = 'Yodlee' then begin
           idConnection := TJSONObject(JArray[idx]).I['ConnectionId'];
           break;
        end;
      end;

      ProgDlg.Caption  := 'Downloading statements....';
      ProgDlg.MaxValue := 50;
      ProgDlg.Value    := 1;
      ProgDlg.TimerUpdate := true;
      ProgDlg.Execute;

      sResult := BuildJSON('JOB', idConnection);
      wsClient.WriteData(sResult);
      for i := 0 to 20 do begin
        if gYodleeText <> '' then ProgDlg.Caption := gYodleeText;
        ProgDlg.Value := ProgDlg.Value + 5;
        if Pos('Completed', gYodleeText) > 0 then break;
        Application.ProcessMessages;
        sleep(1000);
      end;
    except on E: Exception do begin
       ProgDlg.TimerUpdate := False;
       ProgDlg.CloseDialog;
       CommonLib.MessageDlgXP_Vista('Could not download statements from Yodlee.', mtWarning, [mbOK], 0);
       exit;
     end;
  end;
  finally
    ProgDlg.Free;
  end;
end;

procedure TReconciliationGUI.btnCancelClick(Sender: TObject);
var
  iExitResult: integer;
begin
  inherited;
  if Reconciliationobj.Dirty then begin
    iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    case iExitResult of
      mrYes: btnSaveClose.Click;
      mrNo:
        begin;
          RollbackTransaction;
          Close;
        end;
      mrCancel: Exit;
    end;
  end else begin
    RollbackTransaction;
    Self.Close;
    Exit;
  end;
end;

procedure TReconciliationGUI.btnMarkAllClick(Sender: TObject);
var
  i: integer;

begin
  DisableForm;
  FComputeTotals := False;
  //btnRelaxedMatchClick(Nil);
  try
      with grdDeposits do begin
        ProgressDialog.DoShowProgressbar(RowCount, 'Deposits' );
        try
          for i := 1 to RowCount  do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(True, COL_OK, grdDeposits) then break;
          end;
          for i := 1 to RowCount do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(True, COL_BANK_OK, grdDeposits) then break;
          end;
        finally
          ProgressDialog.doHideProgressbar;
        end;
      end;

      with grdWithdrawals do begin
        ProgressDialog.DoShowProgressbar(RowCount, 'WithDrawals' );
        try
          for i := 1 to RowCount do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(True, COL_OK, grdWithdrawals) then break;
          end;
          for i := 1 to RowCount do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(True, COL_BANK_OK, grdWithdrawals) then break;
          end;
        finally
          ProgressDialog.doHideProgressbar;
        end;
      end;
  finally
    FComputeTotals := True;
    ComputeTotals;
    DisplayBalances(True);
    EnableForm;
  end;
end;

procedure TReconciliationGUI.btnUnMarkClick(Sender: TObject);
var
  i: integer;
begin
  DisableForm;
  FComputeTotals := False;
  try
      with grdDeposits do begin
        ProgressDialog.DoShowProgressbar(RowCount, 'WithDrawals' );
        try
          for i := 1 to MAXLOOP do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(False, COL_OK, grdDeposits) then break;
          end;
          for i := 1 to MAXLOOP do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(False, COL_BANK_OK, grdDeposits) then break;
          end;
        finally
          ProgressDialog.doHideProgressbar;
        end;
      end;

      with grdWithdrawals do begin
        ProgressDialog.DoShowProgressbar(RowCount, 'Deposits' );
        try
          for i := 1 to MAXLOOP do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(False, COL_OK, grdWithdrawals) then break;
          end;
          for i := 1 to MAXLOOP do begin
            ProgressDialog.DoStepProgressbar;
            if not MarkUnMarkAll(False, COL_BANK_OK, grdWithdrawals) then break;
          end;
        finally
          ProgressDialog.doHideProgressbar;
        end;
      end;
  finally
    FComputeTotals := True;
    ComputeTotals;
    DisplayBalances(True);
    EnableForm;
  end;
end;

procedure TReconciliationGUI.GetBalance(const iAccountID: integer);
begin
  edtCloseBal.Text := '';
  Reconciliationobj.CalcOpeningBalance;
end;
procedure TReconciliationGUI.ClearGrid(grd:TAdvStringGrid; AClear: Boolean = True );
begin
  // the folowing is needed to ensure that we don't wipe the fixed row
  if not AClear then exit;
  try grd.RemoveRows(2, grd.RowCount - 2); Except end;
  try grd.Rowcount:= 1;Except end;
  try grd.ClearRows(1, 1);Except end;
  try grd.Row := 0;Except end;
end;
procedure TReconciliationGUI.InitRecObj(RecLineType:TStatementRecType);
begin
       if RecLineType = srtDeposit    then  DepositIDList.Clear
  else if RecLineType = srtWithdrawl then  ChequeIDList.Clear;

  ReconciliationObj.ListofToBeReconciled:= true;
  ReconciliationObj.FilterLinesforDate:= chkFilterDate.Checked;
  ReconciliationObj.UseStatements     := self.UseStatements ;
  ReconciliationObj.FilterLinesDate   := dtDate.Date;

       if RecLineType = srtDeposit    then Reconciliationobj.REfreshGuiDepositLines
  else if RecLineType = srtWithdrawl then  Reconciliationobj.REfreshGuiWithdrawLines;
end;


Procedure TReconciliationGUI.CheckForStatementRec(Lines:TGUIReconciliationLines;RecLineType:TStatementRecType);
begin
    With Lines do begin
          if FieldByName('SeqNo').AsInteger = 0 then begin
              if self.UseStatements then begin { a statement line record .. }
                  StatementRecList.Add(RecLineType,
                    FieldByName('DepositID').AsInteger,
                    FieldByName('DepositLineID').AsInteger,
                    FieldByName('StatementLineID').AsInteger,
                    FieldByName('StatementDescription').AsString,
                    FieldByName('StatementAmount').AsCurrency,
                    FieldByName('StatementTransactionDate').AsDateTime);
                end;
            end;
    end;
end;


procedure TReconciliationGUI.AddGridLine(Lines: TGUIReconciliationLines; RecLineType: TStatementRecType);
var
  StatementRec: TStatementRec;
  aID: integer;
  iPos: integer;
  Function grid           : TAdvStringGrid; begin   if RecLineType = srtDeposit then result := grdDeposits      else Result := grdWithdrawals     ; end;
  Function SelectedIDList : TIntegerList  ; begin   if RecLineType = srtDeposit then result := SelectedDeposits else Result := SelectedWithdrawals; end;
begin
  With Lines do begin
    with grid do begin
      if (FieldByName('SeqNo').AsInteger > 0) or (FieldByName('DepositLineID').AsInteger = 0) then begin
        RowCount := RowCount + 1;
        if FieldByName('StatementLineID').AsInteger <= 0 then begin

          AddCheckBox(COL_OK, RowCount - 1, false, true);
          Objects[COL_OK, RowCount - 1]                                                := TObject(FieldByName('PaymentID').AsInteger);
          Cells[COL_OK, RowCount - 1]                                                  := CheckFalse;
          Cells[COL_DATE, RowCount - 1]                                                := FieldByName('DepositDate').AsString;
          Cells[COL_REF, RowCount - 1]                                                 := FieldByName('ReferenceNo').AsString;
          Cells[COL_PAYEE, RowCount - 1]                                               := FieldByName('CompanyName').AsString;
          Cells[COL_NOTES, RowCount - 1]                                               := FieldByName('Notes').AsString;

        if not FieldByName('Amount').IsNull then
          Cells[COL_AMOUNT_FMT, RowCount - 1] := CurrToStrF(FieldByName('Amount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
          Cells[COL_AMOUNT, RowCount - 1]                                          := FieldByName('Amount').AsString;
        end;
        Cells[COL_PAY_ID, RowCount - 1]                                              := FieldByName('DepositID').AsString;
        Cells[COL_DEP_ID, RowCount - 1]                                              := FieldByName('DepositID').AsString;
        Cells[COL_PAY_LineID, RowCount - 1]                                          := FieldByName('DepositLineID').AsString;
        Cells[COL_CLIENT_ID, RowCount - 1]                                           := FieldByName('CusID').AsString;
        if (SelectedIDList.Count > 0) and SelectedIDList.InList(FieldByName('PaymentID').AsInteger) then begin
          Cells[COL_OK, RowCount - 1] := CheckTrue;
          OnCheckBoxClick(grid, COL_OK, RowCount - 1, true);
        end;

        if self.UseStatements then begin
          Cells[COL_STATEMENT_DATE, RowCount - 1]   := FieldByName('StatementTransactionDate').AsString;
          Cells[COL_STATEMENT_AMOUNT, RowCount - 1] := FieldByName('StatementAmount').AsString;
          Cells[COL_STATEMENT_DESC, RowCount - 1]   := ConvertStatementDesc(FieldByName('StatementDescription').AsString);
          Cells[COL_BSL_ID, RowCount - 1]           := FieldByName('StatementLineID').AsString;
          if FieldByName('StatementLineID').AsInteger > 0 then begin
            Cells[COL_STATEMENT_AMOUNT_FMT, RowCount - 1] := CurrToStrF(FieldByName('StatementAmount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
          end;
          AddCheckBox(COL_BANK_OK, RowCount - 1, false, true);
          //Objects[COL_BANK_OK, RowCount - 1]        := TObject(FieldByName('PaymentID').AsInteger);
          Cells[COL_BANK_OK, RowCount - 1]          := CheckFalse;
        end;
      end
      else begin
        { update linked statement data }
        if self.UseStatements then begin
          StatementRec := StatementRecList.ItemByID(RecLineType, FieldByName('StatementLineID').AsInteger);
          if Assigned(StatementRec) then begin
            aID := RowForId(grid, StatementRec.PayID, StatementRec.PayLineID);
            if aID > 0 then begin
              Cells[COL_STATEMENT_DATE, aID]       := DateToStr(StatementRec.TransactionDate);
              Cells[COL_STATEMENT_AMOUNT, aID]     := FloatToStr(StatementRec.StatementAmount);
              Cells[COL_STATEMENT_DESC, aID]       := ConvertStatementDesc(FieldByName('StatementDescription').AsString);
              Cells[COL_BSL_ID, aID]               := IntToStr(StatementRec.StatementLineID);
              Cells[COL_STATEMENT_AMOUNT_FMT, aID] := CurrToStrF(StatementRec.StatementAmount, ffCurrency, CurrencyRoundPlaces);
            end;
          end;
        end;
      end;

    end;
  end;
end;


procedure TReconciliationGUI.GetDepositLines(const iAccountID: integer; AClear: Boolean = True);
var
   Lines: TGUIReconciliationLines;
begin

   if AClear then ClearGrid(grdDeposits);
   InitRecObj(srtDeposit);
   Lines := ReconciliationObj.GuiDepositLines;

   with Lines do
   begin
      clog(replacestr(SQL, ':xAccountID', inttostr(ReconciliationObj.AccountID)));
      logtext('Count :' + inttostr(Count));
      ShowProgressbar(WAITMSG, Count * 2);
      try
         First;
         while not Eof do
         begin
//            if FieldByName('TransactionType').AsString = 'Cheque' then
//            begin
//               CheckForStatementRec(Lines, srtWithdrawl);
//
//               if FieldByName('SeqNo').asInteger = 7 then
//                  ChequeIDList.Add(FieldByName('PaymentID').asInteger);
//
//               AddGridLine(Lines, srtWithdrawl);
//
//            end
//            else
//            begin
               CheckForStatementRec(Lines, srtDeposit);

               if FieldByName('SeqNo').asInteger = 4 then
                  DepositIDList.Add(FieldByName('PaymentID').asInteger);

               AddGridLine(Lines, srtDeposit);
//            end;

            StepProgressbar('Loading To Be Reconciled Deposits # ' + inttostr(recno) + ' of ' +
              inttostr(Count));

            Next;
         end;
      finally
         HideProgressbar;
      end;
   end;
end;


procedure TReconciliationGUI.GetWithdrawalLines(const iAccountID: integer; AClear: Boolean = True);
var
   Lines: TGUIReconciliationLines;
begin
   if Aclear then ClearGrid(grdWithdrawals);
   InitRecObj(srtWithdrawl);
   Lines := ReconciliationObj.GuiWithdrawLines;

   with Lines do
   begin
      logtext(replacestr(SQL, ':xAccountID', inttostr(ReconciliationObj.AccountID)));
      logtext('Count :' + inttostr(Count));
      ShowProgressbar(WAITMSG, Count * 2);
      try
         First;
         while not Eof do
         begin
            CheckForStatementRec(Lines, srtWithdrawl);

            if FieldByName('SeqNo').asInteger = 7 then
               ChequeIDList.Add(FieldByName('PaymentID').asInteger);

            AddGridLine(Lines, srtWithdrawl);

            StepProgressbar('Loading To Be Reconciled Withdrawals # ' + inttostr(recno) + ' of ' +
              inttostr(Count));

            Next;
         end;
      finally
         HideProgressbar;
      end;
   end;
end;


procedure TReconciliationGUI.cboAccountChange(Sender: TObject);
begin
  inherited;
  if (ReconciliationObj.AccountID> 0) and (not ReconciliationObj.Finished) then begin
    btnCheque.Enabled:= true;
    btnDeposit.Enabled:= true;
  end
  else begin
    btnCheque.Enabled:= false;
    btnDeposit.Enabled:= false;
  end;
end;


procedure TReconciliationGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  RecID: integer;
begin
  if not Modified then Exit;
  inherited;
  //readGUIPref;
  if (FillTable.FieldByName('AccountID').OldValue <> 0) and
     (FillTable.FieldByName('AccountID').OldValue <> Null) then
    Exit;
  //Check No On HOLD For This Account Name
  RecID := CheckForOnHoldID(FillTable.FieldByName('AccountID').AsInteger);
  if RecID <> 0 then begin
    KeyID := RecID;
    CommonLib.MessageDlgXP_Vista('This Account Has A Reconciliation On HOLD.' + #13#10 +
      'You Must Complete This Before Starting The Next !', mtWarning, [mbOK], 0);
    RollbackTransaction;
    ReconciliationObj.closedb;
    CloseQueries;
    FormShow(nil);
    Exit;
  end;
  InitGrid;
  if Modified then begin
    LoadTransactions;
//    btnStrictMatchClick(Nil);
    btnRelaxedMatchClick(Nil);
  end;
end;

procedure TReconciliationGUI.CalcDeposittotal;
begin
  CalcGridSelectedTotal(grdDeposits, grdDepositsSum);
end;

procedure TReconciliationGUI.CalcWithDrawaltotal;
begin
  CalcGridSelectedTotal(grdWithdrawals ,grdWithdrawalsSum);
end;

procedure TReconciliationGUI.CalcGridSelectedTotal(grd, grdSum :TAdvStringGrid );
var
  ctr: Integer;
  s: String;
begin
  s := '';
  for ctr := grd.FixedRows to grd.RowCount-1 do begin
    if grd.Cells[COL_OK, ctr] = grd.CheckTrue then begin
      if s <> '' then s := s +' UNION ALL ';
      s:= s + 'SELECT ' + quotedstr(grd.Cells[COL_NOTES, ctr]) +' AS Notes , ' + FloatToStr(AmountFromGrig(grd, ctr)) + ' AS Amount';
    end;
  end;
  grdSum.RemoveRows(grdSum.FixedRows, grdSum.RowCount - 1);
  grdSum.ClearRows(1, 1);
  if s <> '' then begin
    With TempMyQuery do try
      SQL.Add('SELECT Notes, SUM(Amount) AS Amount FROM ( ' + s + ' ) details GROUP BY notes');
      Open;
      while EOf = False do begin
        grdSum.AddRow;
        grdSum.Cells[0, grdSum.RowCount - 1] := FieldByname('notes').AsString;
        grdSum.Cells[1, grdSum.RowCount - 1] := floatToStrF( FieldByname('Amount').AsFloat, ffCurrency, 15, 2);
        Next;
      end;
    finally
      ClosenFree;
    end;
  end;
end;

procedure TReconciliationGUI.ComputeTotals;
var
  i          : Integer;
  reconId    : string;
begin
  if not FComputeTotals then Exit;
  TotalSumBankDep   := 0;
  TotalCountBankDep := 0;
  for i := 1 to grdDeposits.RowCount - 1 do begin
    if  grdDeposits.Cells[COL_OK,i] <> grdDeposits.CheckTrue then Continue;
    if ((UseStatements) and (grdDeposits.Cells[COL_RECON_ID,i] = '')) then Continue;
    Inc(TotalCountBankDep);
    TotalSumBankDep := TotalSumBankDep + grdDeposits.Floats[COL_AMOUNT, i];
  end;

  TotalSumBankWrt   := 0;
  TotalCountBankWrt := 0;
  for i := 1 to grdWithdrawals.RowCount - 1 do begin
    if  grdWithdrawals.Cells[COL_OK,i] <> grdWithdrawals.CheckTrue then Continue;
    if ((UseStatements) and (grdWithdrawals.Cells[COL_RECON_ID,i] = '')) then Continue;
    Inc(TotalCountBankWrt);
    TotalSumBankWrt := TotalSumBankWrt + grdWithdrawals.Floats[COL_AMOUNT, i];
  end;
  CalcDeposittotal;
  CalcWithDrawaltotal;
end;

function  TReconciliationGUI.GetSum(ACol: Integer; AGrid: TAdvStringGrid) : Currency;
var
  i : Integer;
begin
  Result := 0;
  for i := 1 to  AGrid.RowCount -1 do begin
    if  ((UseStatements) and (AGrid.Cells[COL_RECON_ID,i] <> '')) then Continue;
    if ((ACol = COL_OK) and (AGrid.Cells[COL_OK,i] = 'T')) then Result := Result + (AGrid.Floats[COL_AMOUNT,i])
    else if ((ACol = COL_BANK_OK) and (AGrid.Cells[COL_BANK_OK,i] = 'T'))then Result := Result + (AGrid.Floats[COL_STATEMENT_AMOUNT,i]);
  end;
end;

procedure TReconciliationGUI.grdDepositsButtonClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  inherited;
  if Acol = COL_ADD_RULE then begin
    if grddeposits.GetButtonText(ACol, ARow) = 'Select All' then begin
      grddeposits.SetButtonText(ACol, ARow, 'Unselect All');
      AASelectAll(grdDeposits, True);
    end
    else begin
      grddeposits.SetButtonText(ACol, ARow, 'Select All');
      AASelectAll(grdDeposits, False);
    end;
  end;
end;

procedure TReconciliationGUI.grdWithdrawalsButtonClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  inherited;
  if Acol = COL_ADD_RULE then begin
    if grdWithdrawals.GetButtonText(ACol, ARow) = 'Select All' then begin
      grdWithdrawals.SetButtonText(ACol, ARow, 'Unselect All');
      AASelectAll(grdWithdrawals, True);
    end
    else begin
      grdWithdrawals.SetButtonText(ACol, ARow, 'Select All');
      AASelectAll(grdWithdrawals, False);
    end;
  end;
end;

procedure TReconciliationGUI.grdDepositsCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
var
  i          : Integer;
  reconId    : string;
  lSumERPDep : Currency;
  lSumBankDep: Currency;
  AddCount   : Integer;
  LastDepRow : integer;
  FirstDepRow: integer;
  CBState    : Boolean;
begin
  inherited;
  AddCount    := 0;
  LastDepRow  := 1;
  FirstDepRow := -1;
  if not OnShowFinished then exit;
  if not ((ACol = COL_OK) or (ACol = COL_BANK_OK)) then exit;
  if UseStatements then begin
    if State then begin
      if ((grdDeposits.Cells[COL_OK, ARow] = grdDeposits.CheckTrue) AND (grdDeposits.Cells[COL_BANK_OK, ARow] = grdDeposits.CheckTrue)) then begin
        gNextReconId := gNextReconId + 1;
        MoveRows(ARow, 1, grdDeposits, COL_OK);
      end else
      begin
        lSumERPDep  := GetSum(COL_OK, grdDeposits);
        lSumBankDep := GetSum(COL_BANK_OK, grdDeposits);
        if ((lSumERPDep = lSumBankDep) and (lSumERPDep > 0)) then begin
          OrientRows(grdDeposits);
          // add add to rule
          if Sender <> Nil then begin
            grdDeposits.AddCheckBox(COL_ADD_RULE,1, true, true);
          end;
        end;
      end;
    end
    else begin
      if grdDeposits.Cells[COL_RECON_ID,ARow] <> '' then begin
         reconId := grdDeposits.Cells[COL_RECON_ID,ARow];
         for i := 1 to grdDeposits.RowCount -1 do begin
            if grdDeposits.Cells[COL_RECON_ID,i]  = reconId then begin
               grdDeposits.Cells[COL_RECON_ID,i] := '';
               if FirstDepRow = -1 then FirstDepRow := i;
               if (grdDeposits.Cells[COL_BSL_ID,i]  <> '0')  then Inc(AddCount);
               grdDeposits.AddCheckBox(COL_SELECT,i, false, false);
               if grdDeposits.Cells[COL_OK,i]       <> '' then LastDepRow := i;
               grdDeposits.RemoveCheckBox(COL_ADD_RULE, i);
               grdDeposits.Cells[COL_ADD_RULE, i] := '';
            end;
         end;
      end;
    end;
    if not State then begin
      if ((AddCount > 0) and (FirstDepRow > 0)) then begin
        grdDeposits.InsertRows(FirstDepRow+1, 1, True);
        grdDeposits.AddCheckBox(COL_SELECT, FirstDepRow+1, false, false);
        grdDeposits.RemoveCheckBox(COL_ADD_RULE, FirstDepRow+1);
        grdDeposits.Cells[COL_ADD_RULE, FirstDepRow+1] := '';
        MergeRows(FirstDepRow, FirstDepRow + 1,grdDeposits);
        BlankRows(FirstDepRow, grdDeposits);
      end;
    end;
  end else begin
    if State then begin
      gNextReconId := gNextReconId + 1;
      grdDeposits.Cells[COL_RECON_ID,ARow]  := IntToStr(gNextReconId);
    end
    else begin
      grdDeposits.Cells[COL_RECON_ID,ARow]  := '';
    end;
  end;
  grdDeposits.InValidate;
  ComputeTotals ;
  DisplayBalances(True);
end;

procedure TReconciliationGUI.SetGridcolwidth(Grd:TAdvStringGrid; ACol, AWidth:Integer);
begin
  if GridResizing then exit;
  GridResizing:= TRue;
  Try
    grd.ColWidths[acol] := awidth;
  Finally
    GridResizing:= False;
  End;
end;

procedure TReconciliationGUI.SettingsClickCheck(Sender: TObject);
begin
  inherited;
  btnUnMarkClick(Nil);
  btnRelaxedMatchClick(Nil);
end;

procedure TReconciliationGUI.grdDepositsColumnSize(Sender: TObject;
  ACol: Integer; var Allow: Boolean);
begin
  inherited;
  SetGridcolwidth(grdWithdrawals ,Acol ,grdDeposits.colwidths[Acol] );
end;

procedure TReconciliationGUI.grdWithdrawalsCheckBoxClick(Sender: TObject; ACol, ARow: integer; State: boolean);
var
  i          : Integer;
  reconId    : string;
  lSumERPDep : Currency;
  lSumBankDep: Currency;
  AddCount   : Integer;
  LastDepRow : integer;
  FirstDepRow: integer;
  CBState    : Boolean;
begin
  inherited;
  AddCount    := 0;
  LastDepRow  := 1;
  FirstDepRow := -1;
  if not OnShowFinished then exit;
  if not ((ACol = COL_OK) or (ACol = COL_BANK_OK)) then exit;
  If UseStatements then begin
    if State then begin
      if ((grdWithdrawals.Cells[COL_OK, ARow] = grdWithdrawals.CheckTrue) AND (grdWithdrawals.Cells[COL_BANK_OK, ARow] = grdWithdrawals.CheckTrue)) then begin
        gNextReconId := gNextReconId + 1;
        MoveRows(ARow, 1, grdWithdrawals, COL_OK);
      end else
      begin
        lSumERPDep  := GetSum(COL_OK, grdWithdrawals);
        lSumBankDep := GetSum(COL_BANK_OK, grdWithdrawals);
        if ((lSumERPDep = lSumBankDep) and (lSumERPDep > 0)) then begin
          OrientRows(grdWithdrawals);
          // add add to rule
          if Sender <> Nil then begin
            grdWithdrawals.AddCheckBox(COL_ADD_RULE,1, true, true);
          end;
        end;
      end;
    end
    else begin
      if grdWithdrawals.Cells[COL_RECON_ID,ARow] <> '' then begin
         reconId := grdWithdrawals.Cells[COL_RECON_ID,ARow];
         for i := 1 to grdWithdrawals.RowCount -1 do begin
            if grdWithdrawals.Cells[COL_RECON_ID,i]  = reconId then begin
               grdWithdrawals.Cells[COL_RECON_ID,i] := '';
               if FirstDepRow = -1 then FirstDepRow := i;
               if (grdWithdrawals.Cells[COL_BSL_ID,i]  <> '0')  then Inc(AddCount);
               grdWithdrawals.AddCheckBox(COL_SELECT,i, false, false);
               if grdWithdrawals.Cells[COL_OK,i]       <> '' then LastDepRow := i;
               grdWithdrawals.RemoveCheckBox(COL_ADD_RULE, i);
               grdWithdrawals.Cells[COL_ADD_RULE, i] := '';
            end;
         end;
      end;
    end;
    if not State then begin
      if ((AddCount > 0) and (FirstDepRow > 0)) then begin
        grdWithdrawals.InsertRows(FirstDepRow+1, AddCount, True);
        grdWithdrawals.AddCheckBox(COL_SELECT, FirstDepRow+1, false, false);
        grdWithdrawals.RemoveCheckBox(COL_ADD_RULE, FirstDepRow+1);
        grdWithdrawals.Cells[COL_ADD_RULE, FirstDepRow+1] := '';
        MergeRows(FirstDepRow, FirstDepRow + 1,grdWithdrawals);
        BlankRows(FirstDepRow, grdWithdrawals);
      end;
    end;
  end else begin
    if State then begin
      gNextReconId := gNextReconId + 1;
      grdWithdrawals.Cells[COL_RECON_ID,ARow]  := IntToStr(gNextReconId);
    end
    else begin
      grdWithdrawals.Cells[COL_RECON_ID,ARow]  := '';
    end;
  end;
  grdWithdrawals.InValidate;
  ComputeTotals ;
  DisplayBalances(True);
end;

procedure TReconciliationGUI.grdWithdrawalsColumnSize(Sender: TObject;
  ACol: Integer; var Allow: Boolean);
begin
  inherited;
  SetGridcolwidth(grdDeposits, acol,grdWithdrawals.colwidths[Acol] );
end;


procedure TReconciliationGUI.DisplayBalances(const bAll: boolean);
begin
  lblEndBal.Caption := '';
  lblDiff.Caption := '';
  lblClearedBal.Caption := CurrToStrF (ReconciliationObj.OpenBalance + TotalSumBankDep - TotalSumBankWrt,
                                       ffCurrency, CurrencyRoundPlaces);
  lblTotDeposits.Caption := '0';
  lblTotWithdrawals.Caption := '0';
  lblDepositsAmount.Caption := AppEnv.RegionalOptions.CurrencySymbol+'0.00';
  lblWithdrawalsAmount.Caption := AppEnv.RegionalOptions.CurrencySymbol+'0.00';
  if bAll then begin
    lblTotDeposits.Caption       := IntToStr(TotalCountBankDep);
    lblTotWithdrawals.Caption    := IntToStr(TotalCountBankWrt);
    lblDepositsAmount.Caption    := CurrToStrF(TotalSumBankDep, ffCurrency, CurrencyRoundPlaces);
    lblWithdrawalsAmount.Caption := CurrToStrF(TotalSumBankWrt , ffCurrency, CurrencyRoundPlaces);
    if Trim(edtCloseBal.Text) <> '' then begin
      lblEndBal.Caption := CurrToStrF(FloatToCurr(StrValue(edtCloseBal.Text)),ffCurrency, CurrencyRoundPlaces);
      lblDiff.Caption := CurrToStrF(FloatToCurr(StrValue(edtCloseBal.Text))
                         - (ReconciliationObj.OpenBalance + TotalSumBankDep - TotalSumBankWrt), ffCurrency, CurrencyRoundPlaces);
    end;
  end
end;


procedure TReconciliationGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TReconciliation                 then TReconciliation(Sender).Dataset                 := qryRecons
        else if Sender is TReconciliationDepositLines     then TReconciliationDepositLines(Sender).Dataset     := tblReconDepLines
        else if Sender is TReconciliationWithdrawalLines  then TReconciliationWithdrawalLines(Sender).Dataset  := tblReconWithdrawalLines;
     end else if (Sender is TReconciliation) and (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ResStats) then begin
       RefreshOnHoldnfinsihed;
     end;

end;
Procedure TReconciliationGUI.RefreshOnHoldnfinsihed;
begin
  lblRecStatus.visible := KeyId<>0;
  if KeyId = 0 then Exit;
  if Reconciliationobj.Deleted then lblRecStatus.Caption := 'Deleted'
  else if Reconciliationobj.OnHold then lblRecStatus.Caption := 'On Hold'
  else if Reconciliationobj.Finished then lblRecStatus.Caption := 'Finished'
  else lblRecStatus.Caption := '';
  lblRecStatus.Refresh;
end;
function TReconciliationGUI.IsStatementColumn(const aCol: integer): boolean;
begin
  result :=
    (aCol = COL_STATEMENT_DATE) or
    (aCol = COL_STATEMENT_AMOUNT_FMT) or
    (aCol = COL_STATEMENT_DESC);
end;

function TReconciliationGUI.IsValidFloat(const sNumber: string): boolean;
var
  rDummy: double;
  ErrCode: integer;
begin
  Val(sNumber, rDummy, ErrCode);
  if rDummy = 0 then;
  if ErrCode = 0 then Result := true
  else Result := false;
end;

procedure TReconciliationGUI.grdCellChanging(Sender: TObject; OldRow, OldCol, NewRow, NewCol: integer; var Allow: boolean);
begin
  inherited;
  // we don't want them changing any cell other than clicking the ok button
  if ((NewCol = COL_OK) or (NewCol = COL_BANK_ok) or (NewCol = COL_SELECT) or (NewCol = COL_ADD_RULE)) then begin
    Allow := true;
  end else
  begin
    Allow := false;
  end;
end;

procedure TReconciliationGUI.edtCloseBalKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if Key = CR then begin
    SetControlFocus(grdDeposits);   // make it exit this control and forces the OnExit event
  end else begin
    lblEndBal.Caption := '';
    lblDiff.Caption   := '';
  end;
end;

procedure TReconciliationGUI.edtCloseBalDblClick(Sender: TObject);
begin
  inherited;
  if devmode then begin
    REconciliationobj.CloseBalance := Reconciliationobj.Balance ;
    REconciliationobj.PostDB;
  end;
end;

procedure TReconciliationGUI.edtCloseBalExit(Sender: TObject);
begin
  inherited;
  DisplayBalances(true);
end;

procedure TReconciliationGUI.EnableControls;
var
  i: integer;
begin
  for i := 0 to Self.ComponentCount - 1 do begin
    if (Self.Components[i] is TControl) then TControl(Self.Components[i]).Enabled := true;
  end;

  btnBankTRansactions.Enabled := false;
  bnCreateEntries.Visible     := UseStatements;
  SettingsGroup.Visible       := UseStatements;
  bnRules.Visible             := UseStatements;
end;
Procedure TReconciliationGUI.PopulateGridFromDBcallback(Const Sender: TBusObj; var Abort: boolean);
var
  grd: TAdvStringGrid;
  oldDepId: string;
begin
  if sender is TReconciliationWithdrawalLines then grd := grdWithdrawals
  else  grd := grdDeposits;
  with grd do begin
    RowCount := RowCount + 1;
    if RowCount > 2 then oldDepId := Cells[COL_PAY_ID    , RowCount - 2] else oldDepId := '';
    AddCheckBox(COL_BANK_OK, RowCount - 1, false, true);
    if ((not UseStatements) OR ((UseStatements) AND (oldDepId <> inttostr(TReconciliationLineBase(Sender).PaymentID)))) then begin
      AddCheckBox(COL_OK, RowCount - 1, false, true);
      Cells[COL_DATE      , RowCount - 1] := Formatdatetime(shortdateformat, TReconciliationLineBase(Sender).DepositDate);
      Cells[COL_REF       , RowCount - 1] := TReconciliationLineBase(Sender).Reference;
      Cells[COL_PAYEE     , RowCount - 1] := TReconciliationLineBase(Sender).Payee;
      Cells[COL_NOTES     , RowCount - 1] := TReconciliationLineBase(Sender).Notes;
      Cells[COL_AMOUNT_FMT, RowCount - 1] := CurrToStrF(TReconciliationLineBase(Sender).Amount, ffCurrency, CurrencyRoundPlaces);
      Cells[COL_AMOUNT    , RowCount - 1] := CurrToStrF(TReconciliationLineBase(Sender).Amount, ffCurrency, CurrencyRoundPlaces);
    end;
    Cells[COL_PAY_ID    , RowCount - 1] := inttostr(TReconciliationLineBase(Sender).PaymentID);
    Cells[COL_PAY_LineID, RowCount - 1] := inttostr(TReconciliationLineBase(Sender).DepositLineID);
    Cells[COL_CLIENT_ID , RowCount - 1] := inttostr(TReconciliationLineBase(Sender).ClientID);
    if TReconciliationLineBase(Sender).StatementDate = 0 then Cells[COL_STATEMENT_DATE , RowCount - 1] := ''
    else
    Cells[COL_STATEMENT_DATE , RowCount - 1] := Formatdatetime(shortdateformat, TReconciliationLineBase(Sender).StatementDate);
    if TReconciliationLineBase(Sender).StatementAmount = 0 then Cells[COL_STATEMENT_AMOUNT_FMT , RowCount - 1] := ''
    else
    Cells[COL_STATEMENT_AMOUNT_FMT , RowCount - 1] :=  CurrToStrF(TReconciliationLineBase(Sender).StatementAmount, ffCurrency, CurrencyRoundPlaces);
    Cells[COL_STATEMENT_DESC, RowCount - 1]        := ConvertStatementDesc(TReconciliationLineBase(Sender).StatementDesc);
    //Cells[COL_STATEMENT_DESC , RowCount - 1] :=  TReconciliationLineBase(Sender).StatementDesc;
    Cells[COL_STATEMENT_AMOUNT    , RowCount - 1] := CurrToStrF(TReconciliationLineBase(Sender).StatementAmount, ffCurrency, CurrencyRoundPlaces);
    Cells[COL_BSL_ID    , RowCount - 1] := inttostr(TReconciliationLineBase(Sender).StatementID);
    Cells[COL_RECON_ID   , RowCount - 1] := inttostr(TReconciliationLineBase(Sender).Id);
    //Cells[COL_DEP_ID    , RowCount - 1] := inttostr(TReconciliationLineBase(Sender).DepositID);
//    if TReconciliationLineBase(Sender).BankStatementID <> 0 then begin
//      Cells[COL_STATEMENT_DESC    , RowCount - 1] := TReconciliationLineBase(Sender).BankDescription;
//      Cells[COL_STATEMENT_DATE    , RowCount - 1] := Formatdatetime(shortdateformat, TReconciliationLineBase(Sender).BankDate);
//      Cells[COL_STATEMENT_AMOUNT_FMT    , RowCount - 1] := CurrToStrF(TReconciliationLineBase(Sender).BankAmount, ffCurrency, CurrencyRoundPlaces);
//    end;
  end;
end;



function TReconciliationGUI.PopulateGridFromDB(ReconciliationLine: TReconciliationLineBase)
  : boolean;
var
   grd: TAdvStringGrid;
begin
   Result := false;

   if ReconciliationLine is TReconciliationWithdrawalLines then
   begin
      grd := grdWithdrawals;
   end
   else
   begin
      grd := grdDeposits;
   end;


   ClearGrid(grd);
   ReconciliationLine.IterateRecords(PopulateGridFromDBcallback);
end;



Function TReconciliationGUI.LoadGrid(Grid :TADvStringGrid; Qry :TERPQuery):Boolean;
var
  StatementRec: TStatementRec;
  RecType: TStatementRecType;
  SkipRec: boolean;
begin
  REsult := False;
  ClearGrid(grid);
  if Grid = grdDeposits then RecType := srtDeposit
  else RecType := srtWithdrawl;

  With Qry do begin
    while not Eof do begin
      with grid do begin
        RowCount := recno+1;//RowCount + 1;
        SkipRec := false;
        if self.UseStatements then begin
          if FieldByName('DepositID').AsInteger > 0 then begin
            { this is a transaction line .. }
            { .. do we have a matched statment line? }
            StatementRec := StatementRecList.ItemByID(RecType,FieldByName('DepositID').AsInteger, FieldByName('DepositLineID').AsInteger);
            if Assigned(StatementRec) then begin
              { we have a linked bank statement record .. }
              Cells[COL_STATEMENT_DATE      , RowCount - 1] := DateToStr(StatementRec.TransactionDate);
              Cells[COL_STATEMENT_AMOUNT    , RowCount - 1] := FloatToStr(StatementRec.StatementAmount);
              Cells[COL_STATEMENT_AMOUNT_FMT, RowCount - 1] := CurrToStrF(StatementRec.StatementAmount, ffCurrency, CurrencyRoundPlaces);
              Cells[COL_STATEMENT_DESC      , RowCount - 1] := ConvertStatementDesc(StatementRec.StatementDescription);
              Cells[COL_BSL_ID              , RowCount - 1] := IntToStr(StatementRec.StatementLineID);
            end;
          end else begin
            { .. a statement record .. }
            StatementRec := StatementRecList.ItemByID(RecType,FieldByName('StatementLineID').AsInteger);
            if Assigned(StatementRec) and (StatementRec.PayID > 0) then begin
              { this statement line has been linked to a transaction .. so don't add it to grid }
              RowCount := RowCount - 1;
              SkipRec := true;
            end else begin
              { a statement line not linked to anything so add it ..}
              Cells[COL_STATEMENT_DATE            , RowCount - 1] := FieldByName('StatementTransactionDate').AsString;
              if FieldByName('StatementLineID').AsInteger > 0 then
                Cells[COL_STATEMENT_AMOUNT_FMT    , RowCount - 1] :=CurrToStrF(FieldByName('StatementAmount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
              Cells[COL_STATEMENT_AMOUNT          , RowCount - 1] := FieldByName('StatementAmount').AsString;
              Cells[COL_STATEMENT_DESC            , RowCount - 1] := ConvertStatementDesc(FieldByName('StatementDescription').AsString);
              Cells[COL_BSL_ID                    , RowCount - 1] := FieldByName('StatementLineID').AsString;
            end;
          end;
        end;
        if not SkipRec then begin
          AddCheckBox(COL_OK      , RowCount - 1, false, true);
          AddCheckBox(COL_BANK_OK , RowCount - 1, false, true);
          Cells[COL_DATE          , RowCount - 1] := FieldByName('DepositDate').AsString;
          Cells[COL_REF           , RowCount - 1] := FieldByName('ReferenceNo').AsString;
          Cells[COL_PAYEE         , RowCount - 1] := FieldByName('CompanyName').AsString;
          Cells[COL_NOTES         , RowCount - 1] := FieldByName('Notes').AsString;
          Cells[COL_AMOUNT_FMT    , RowCount - 1] := CurrToStrF(FieldByName('Amount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
          Cells[COL_AMOUNT        , RowCount - 1] := FieldByName('Amount').AsString;
          Cells[COL_PAY_ID        , RowCount - 1] := FieldByName('DepositID').AsString;
          Cells[COL_DEP_ID        , RowCount - 1] := FieldByName('DepositID').AsString;
          Cells[COL_PAY_LineID    , RowCount - 1] := FieldByName('DepositLineID').AsString;
          if (qry.FindField('ClientID') <> nil) then begin
              Cells[COL_CLIENT_ID , RowCount - 1] := FieldByName('ClientID').AsString;
          end else if (qry.FindField('CusID') <> nil) then begin
              Cells[COL_CLIENT_ID , RowCount - 1] := FieldByName('CusID').AsString;
          end;
          Result := true;
        end;
      end;
      Next;
    end;
  end;
end;


function TReconciliationGUI.GetReportTypeID: integer;
begin
  Result := 21;
end;


procedure TReconciliationGUI.LoadTransactions(AClear: Boolean = True);
begin
  EnableControls ;
  if  AClear then begin
    with qryAccount do begin
      filtered := false;
      filter   := 'AccountName = ' + QuotedStr(cboAccount.Text);
      filtered := true;
      if Reconciliationobj.AccountID =0 then
        CommonLib.MessageDlgXP_Vista('Account not found in table tblChartOfAccounts',
          mtWarning, [mbOK], 0);
      filtered := false;
    end;
    GetBalance(Reconciliationobj.AccountID);
    StatementRecList.Clear;
    clog('');
  end;
//  GetDepositLines(Reconciliationobj.AccountID);
  GetWithdrawalLines(Reconciliationobj.AccountID, AClear);

  GetDepositLines(Reconciliationobj.AccountID, AClear);

  dtDate.Modified := false;


  if (SelectedWithdrawals.Count > 0) or (SelectedDeposits.Count > 0) then
    DisplayBalances(true)
  else
    DisplayBalances(false);

  btnWithdrawalsNext.Enabled  := Reconciliationobj.WithdrawalLines.Count>0;
  btnDepositNext.Enabled      := Reconciliationobj.DepositLines.Count>0;
  AddSelectAll(grdDeposits);
  AddSelectAll(grdWithdrawals);
end;



procedure TReconciliationGUI.MatchSavedTrans;
begin
  ReconciliationObj.Depositlines.IterateRecords(PopulateGridFromDBcallback);
  ReconciliationObj.Withdrawallines.IterateRecords(PopulateGridFromDBcallback);
  MarkGridFromSavedTrans(ReconciliationObj.Depositlines);
  MarkGridFromSavedTrans(ReconciliationObj.Withdrawallines);
  ComputeTotals;
  DisplayBalances(True);
end;

procedure TReconciliationGUI.MarkGridFromSavedTrans(ReconciliationLine:TReconciliationLineBase);//(const iID: integer; const sTblName: string;const grd: TAdvStringGrid);
var
  grd: TAdvStringGrid;
  i:Integer;
begin
  if ReconciliationLine is TReconciliationWithdrawalLines then grd := grdWithdrawals
  else  grd := grdDeposits;

  with grd do begin
        for i := 1 to RowCount - 1 do begin
          if ReconciliationLine.Locate('PaymentId',StrToIntDef(Cells[COL_PAY_ID, i],0),[]) then begin
          //if ReconciliationLine.Locate('PaymentId;DepositID',
          //           varArrayof([Cells[COL_PAY_ID, i], Cells[COL_DEP_ID, i]]),[])  then begin
            Cells[COL_OK, i] := CheckTrue;
            if ReconciliationLine is TReconciliationDepositLines then begin
              grdDepositsCheckBoxClick(Self, COL_OK, i, true);
              grdDeposits.MoveRow(i,1);
            end else begin
              grdWithdrawalsCheckBoxClick(Self, COL_OK, i, true);
              grdWithdrawals.MoveRow(i,1);
            end;
          end;
        end;
  end;
end;

procedure TReconciliationGUI.btnHoldClick(Sender: TObject);
begin
  if SaveRecons(False) then begin
    Close;
  end;
end;

procedure TReconciliationGUI.InsertRule(AStatementDesc: String; APayee: String);
var
  newRule: TBankReconciliationRules;
begin
  if Trim(APayee)         = '' then Exit;
  if Trim(AStatementDesc) = '' then Exit;
  newRule := TBankReconciliationRules.CreateWithNewConn(nil);
  try
    newRule.LoadSelect('Payee = ' + QuotedStr(APayee) + ' AND StatementDesc = ' + QuotedStr(AStatementDesc));
    if newRule.Count = 0 then begin
      newRule.New;
      newRule.StatementDesc := AStatementDesc;
      newRule.Payee         := APayee;
      newRule.Active        := True;
      newRule.Save;
    end;
  finally
    newRule.Free;
  end;
end;


(* procedure TReconciliationGUI.InsertRule(AStatementDesc: string; APayee: string);
var
  qry: TERPQuery;
begin
  if Trim(APayee)         = '' then exit;
  if Trim(AStatementDesc) = '' then exit;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    //if Assigned(fAssignedConnection) then qry.Connection:= fAssignedConnection
    //else
    //qry.Connection := Self.GetSharedMyDAcDataconnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('INSERT INTO tblBankReconciliationRules(StatementDesc, Active, Payee) Values ( ' +
              QuotedStr(AStatementDesc) + ', ' + '"T",' + QuotedStr(APayee) + ')');
      ExecSQL;
    end;
  finally
    qry.Free;
  end;
end;
*)

function TReconciliationGUI.RemovePrevRecons(const JustLines: boolean): boolean;
var
  qry: TERPQuery;
  LI: TUserLockItem;
begin
  Result := false;
  LI := UserLock.LockEx('tblReconciliationDepositLines', KeyID, 'PreviousReconcilitations');
  if not Assigned(LI) then Exit;
  LI := UserLock.LockEx('tblReconciliationWithdrawalLines', KeyID, 'PreviousReconcilitations');
  if not Assigned(LI) then Exit;

  qry := TERPQuery.Create(Self);
  try
    qry.Connection := MyConnection;

    qry.Sql.Clear;
    qry.SQL.Add('update tblbankstatementline set ReconciliationLineID = 0');
    qry.SQL.Add('where BaseType = "CREDIT"');
    qry.SQL.Add('and ReconciliationLineID in ');
    qry.SQL.Add('(select ReconciliationLineID from tblReconciliationDepositLines where ReconciliationID = ' + IntToStr(KeyID)+ ')');
    qry.Execute;

    qry.Sql.Clear;
    qry.SQL.Add('update tblbankstatementline set ReconciliationLineID = 0');
    qry.SQL.Add('where BaseType = "DEBIT"');
    qry.SQL.Add('and ReconciliationLineID in ');
    qry.SQL.Add('(select ReconciliationLineID from tblReconciliationWithdrawalLines where ReconciliationID = ' + IntToStr(KeyID)+ ')');
    qry.Execute;


//    qry.Sql.Clear;
//    qry.SQL.Add('update tblbankdepositlines set reconciled = ''F'' ');
//    qry.SQL.Add('where DepositID in (SELECT depositid from tblbankdeposit WHERE ReconciliationLineID in ');
//    qry.SQL.Add('(select ReconciliationLineID from tblReconciliationWithdrawalLines where ReconciliationID = ' + IntToStr(KeyID)+ '))');
//    qry.Execute;
//
//    qry.Sql.Clear;
//    qry.SQL.Add('update tblbankdeposit set ReconciliationLineID = 0, reconciled = ''F'' ');
//    qry.SQL.Add('where ReconciliationLineID in ');
//    qry.SQL.Add('(select ReconciliationLineID from tblReconciliationWithdrawalLines where ReconciliationID = ' + IntToStr(KeyID)+ ')');
//    qry.Execute;
//
//
//    qry.Sql.Clear;
//    qry.SQL.Add('DELETE FROM  ');
//    qry.SQL.Add('tblReconciliationWithdrawalLines where ReconciliationID = ' + IntToStr(KeyID));
//    qry.Execute;
//
//    qry.Sql.Clear;
//    qry.SQL.Add('DELETE FROM  ');
//    qry.SQL.Add('tblReconciliationDepositLines where ReconciliationID = ' + IntToStr(KeyID));
//    qry.Execute;


    if not JustLines then begin
      ReconciliationObj.Deleted := true;
      ReconciliationObj.Finished := True;
      ReconciliationObj.PostDB;
      str := 'RemovePrevRecons';
      CommitTransaction;
      if CommitFailed then exit;
      Notify;
    end;

    Result := true;
  finally
    FreeAndNil(qry);
    UserLock.Unlock('PreviousReconcilitations');
  end;
end;

procedure TReconciliationGUI.report1n2Moved(Sender: TObject);
begin
  inherited;
  pnlgrdWithdrawalsSum.Width :=  pnlgrdDepositsSum.Width;
end;

function TReconciliationGUI.CheckForOnHoldID(const AccountID: integer): integer;
  { returns the ID of an 'on-hold' reconciliation if one exists.  Otherwise returns 0 }
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ReconciliationID,ReconciliationDate,StatementNo ');
    qry.SQL.Add('FROM tblReconciliation R');
    qry.SQL.Add('WHERE R.Deleted <> "T" AND R.Finished <> "T" AND R.AccountID>0 AND Not IsNull(R.AccountID) ');
    qry.SQL.Add('AND R.AccountID=' + IntToStr(AccountID) + ';');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      qry.First;
      Result := qry.FieldByName('ReconciliationID').AsInteger;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TReconciliationGUI.ProcessOnHold: integer;
begin
  Result := KeyID;
  if Result = 0 then begin
    Result := GetOnHoldID;
    if (Result = -1) then begin
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end;
  end;
end;

function TReconciliationGUI.GetOnHoldID: integer;
var
  qry: TERPQuery;

  function FillString(const Str: string; const StrLength: integer; const FillChar: char; const InFront: boolean): string;
  var
    FinalStr, TempStr: string;
    RequiredSpaces: integer;
  begin
    RequiredSpaces := StrLength - char_length(LeftStr(Trim(Str), StrLength));
    TempStr := StringOfChar(FillChar, RequiredSpaces);
    if InFront then begin
      FinalStr := TempStr + Trim(LeftStr(Trim(Str), StrLength));
    end else begin
      FinalStr := Trim(LeftStr(Trim(Str), StrLength)) + TempStr;
    end;
    Result := FinalStr;
  end;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT ReconciliationID,ReconciliationDate,AccountName,StatementNo ');
    qry.SQL.Add('FROM tblReconciliation R');
    qry.SQL.Add('INNER JOIN tblchartofaccounts C USING(AccountID) ');
    qry.SQL.Add('WHERE R.Finished <> "T" AND R.Deleted <> "T" AND R.AccountID>0 AND not IsNull(R.AccountID) ');
    qry.SQL.Add('Order By ReconciliationDate DESC,AccountName,StatementNo;');
    qry.Open;
    if not qry.IsEmpty then begin
      qry.First;
      OnHoldList := TSelectionDialog2.Create(Self);
      try
        OnHoldList.Dataset := qry;
        OnHoldList.ResultSelectionField := 'ReconciliationID';
        qry.FieldByName('ReconciliationID').Visible := false;
        qry.FieldByName('AccountName').DisplayWidth := 20;
        qry.FieldByName('ReconciliationDate').DisplayWidth := 20;
        qry.FieldByName('StatementNo').DisplayWidth := 20;
        OnHoldList.Width := 480;
        OnHoldList.Color := $00ECECD9;
        OnHoldList.Caption := 'On Hold Reconciliation List';
        OnHoldList.MessageFont.Size := OnHoldList.MessageFont.Size + 1;
        OnHoldList.MessageFont.Color := clMaroon;
        OnHoldList.MessageFont.Style := [fsBold];
        OnHoldList.Message := 'Select On Hold Reconciliation OR Select New To Start New Reconciliation';
        OnHoldList.Buttons := [sb_OK, sb_UserDef, sb_Cancel];
        OnHoldList.UserDefModalResult := mrIgnore;
        OnHoldList.UserDefBtnCaption := 'New';

        if OnHoldList.Execute then begin
          if OnHoldList.DialogModalResult = mrOk then Result := Trunc(StrValue(OnHoldList.SelectedItems.Text))
          else Result := 0;
        end else begin
          Result := -1;
        end;
      finally
        FreeAndNil(OnHoldList);
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TReconciliationGUI.GetDepositPaymentID(const DepositID: integer; const TrnsType: string = ''): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    if Empty(TrnsType) then begin
      qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines Where DepositID = ' + QuotedStr(IntToStr(DepositID)) + ';');
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

function TReconciliationGUI.GetMainTablename: String;
begin
  REsult := 'tblreconciliation';
end;

function TReconciliationGUI.GetWithdrawalPaymentID(const DepositID: integer): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines Where DepositID = ' + QuotedStr(IntToStr(DepositID)) + ';');
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

procedure TReconciliationGUI.chkDeletedClick(Sender: TObject);
var
  LastRec: boolean;
begin
  inherited;

  if screen.activecontrol <> sender then exit;
  if not OnShowFinished then exit;


  LastRec := CheckIfLastReconciliation;
  Label3.Enabled := LastRec;
  chkDeleted.Enabled := LastRec;
  if OnShowFinished then begin
    if (LastRec or Reconciliationobj.OnHold) then begin
      Label3.Enabled := true;
      chkDeleted.Enabled := true;
      if chkDeleted.Checked then begin
        btnSaveClose.Enabled := true;
      end else begin
        btnSaveClose.Enabled := false;
      end;
    end else begin
      Label3.Enabled := false;
      chkDeleted.Enabled := false;
      if chkDeleted.Checked then CommonLib.MessageDlgXP_Vista('Reconciliations Exist That Were Applied After This Reconciliation.      ' +
          #13 + #10 + 'You Must Delete Them First !', mtInformation, [mbOK], 0);
      qryReconsDeleted.AsBoolean := false;
    end;
  end;
end;

function TReconciliationGUI.CheckIfLastReconciliation: boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;

  if KeyID = 0 then begin  //New Rec Trap
    Result := true;
    Exit;
  end;

  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT ReconciliationID ' +
        'FROM tblReconciliation ' +
        'WHERE AccountID = :xAccountID AND Finished = "T" ' +
        'AND Deleted<>"T"  ' +
        'ORDER BY ReconciliationID desc limit 1');
      Params.ParamByName('xAccountID').AsInteger := qryReconsAccountID.AsInteger;
      Open;
      if RecordCount > 0 then begin
        //Last;
        if (qryReconsReconciliationID.AsInteger = qry.FieldByName('ReconciliationID').AsInteger) then begin
          Result := true;
        end else begin
          Result := false;
        end;
      end else begin
        Result := not(Reconciliationobj.Deleted);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TReconciliationGUI.btnPrintReportClick(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    if (LoadNotReconciledData(sSQL, qryReconsAccountID.AsInteger) > 0) then begin
      fbReportSQLSupplied := true;
      fbTemplateUsesNonFormConnection := true;
      PrintTemplateReport('Not Reconciled', sSQL, not AppEnv.Employee.ShowPreview, 1);
      fbReportSQLSupplied := false;
    end else begin
      CommonLib.MessageDlgXP_Vista('"Not Reconciled Report" is Empty. Everything appears to be Reconciled for this account.', mtInformation, [mbOK], 0);
    end;
  finally
    EnableForm;
  end;
end;

function TReconciliationGUI.MarkUnMarkAll(ACheck: Boolean; ACol: integer; AGrid: TAdvStringGrid) : Boolean;
var
  i : integer;
  sCheck: string;
  ColCheck: integer;
begin
  if ACheck then sCheck := 'T' else sCheck := 'F';
  if UseStatements then
    ColCheck := COL_RECON_ID
  else begin
    if ACol = COL_OK then ColCheck := COL_DEP_ID else ColCheck := COL_BSL_ID;
  end;
  Result := False;
  With AGrid do begin
    for i := 1 to RowCount - 1 do begin
      if Cells[ColCheck, i] = '0' then Continue;
      if ((HasCheckBox(ACol,i)) and (Cells[ACol, i] <> sCheck)) then begin
        Cells[ACol, i] := sCheck;
        Result := True;
        //if UseStatements then begin
          if AGrid = grdDeposits then grdDepositsCheckBoxClick(AGrid, ACol, i, ACheck)
          else                        grdWithDrawalsCheckBoxClick(AGrid, ACol, i, ACheck);
        //end;
        break;
      end;
    end;
  end;
  ComputeTotals;
  AGrid.InValidate;
  //grdWithDrawals.InValidate;
  DisplayBalances(True);
end;

procedure TReconciliationGUI.btnRelaxedMatchClick(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  if not UseStatements then Exit;

  FComputeTotals := False;

  ProgressDialog.DoShowProgressbar(grdDeposits.RowCount, 'Matching Deposits' );
  try
    for i := 1 to grdDeposits.RowCount do begin
      ProgressDialog.DoStepProgressbar;
      if not FullRelaxedMatchClick(srtDeposit) then break;
    end;
  finally
    ProgressDialog.doHideProgressbar;
  end;

  ProgressDialog.DoShowProgressbar(grdWithDrawals.RowCount, 'Matching Withdrawals' );
  try
    for i := 1 to grdWithDrawals.RowCount do begin
      ProgressDialog.DoStepProgressbar;
      if not FullRelaxedMatchClick(srtWithdrawl) then break;
    end;
  finally
    ProgressDialog.doHideProgressbar;
  end;

  FComputeTotals := True;

  ComputeTotals;

  grdDeposits.InValidate;
  grdWithDrawals.InValidate;

  DisplayBalances(True);
end;

function TReconciliationGUI.fullRelaxedMatchClick(AStatementRecType: TStatementRecType): Boolean;
var
  i                : integer;
  ThisStatementRec : TStatementRec;
  BankRow          : integer;
begin
  inherited;
  Result := False;
  BankRow := -1;
  if AStatementRecType = srtDeposit then begin
    for i := 1 to grdDeposits.RowCount -1 do begin
      if grdDeposits.Cells[COL_RECON_ID, i]  <> '' then Continue;
      if StrToIntDef(grdDeposits.Cells[COL_BSL_ID, i],0) > 0 then
        ThisStatementRec := StatementRecList.ItemByID(srtDeposit,StrToIntDef(grdDeposits.Cells[COL_BSL_ID, i],0))
      else
        Continue;
      if ThisStatementRec = Nil then Continue;
      if ThisStatementRec.PayID > 0 then Continue;
      BankRow := findMatchingBankRow(srtDeposit, ThisStatementRec, False);

      if BankRow >= 0 then begin
        grdDeposits.Cells[COL_OK, BankRow] := grdDeposits.CheckTrue;
        grdDeposits.Cells[COL_BANK_OK, i]  := grdDeposits.CheckTrue;
        grdDepositsCheckBoxClick(Nil,COL_BANK_OK, i, True);
        OrientRows(grdDeposits);
        Result := True;
        exit;
      end;
    end;
  end;

  if AStatementRecType = srtWithdrawl then begin
    for i := 0 to grdWithdrawals.RowCount -1 do begin
      if grdWithdrawals.Cells[COL_RECON_ID, i]  <> '' then Continue;
      if StrToIntDef(grdWithdrawals.Cells[COL_BSL_ID, i],0) > 0 then
        ThisStatementRec := StatementRecList.ItemByID(srtWithdrawl,StrToIntDef(grdWithdrawals.Cells[COL_BSL_ID, i],0))
      else
        Continue;
      if ThisStatementRec = Nil then Continue;
      if ThisStatementRec.PayID > 0 then Continue;
      BankRow := findMatchingBankRow(srtWithdrawl, ThisStatementRec, False);
      if BankRow >= 0 then begin
        grdWithdrawals.Cells[COL_OK, BankRow] := grdWithdrawals.CheckTrue;
        grdWithdrawals.Cells[COL_BANK_OK, i] := grdWithdrawals.CheckTrue;
        OrientRows(grdWithdrawals);
        Result := True;
        exit;
      end;
    end;
  end;
  Result := True;
end;

procedure TReconciliationGUI.grdDblClickCell(Sender: TObject; ARow, ACol: integer);
var
  iDepositId: integer;
  iPayID: integer;
  bOk: boolean;
  sTransType: string;
  grd: TAdvStringGrid;
  qry: TERPQuery;
  bIsAnyLines: boolean;
  //AmountDiff: double;
  SavedAccessLevel: integer;
  Ids : array of Array [1..2] of Integer;
  Procedure Storeselection;
  var
    i, x, id:Integer;
  begin
    SetLength(Ids, 0);
    if grd = nil then exit;
    With grd do begin
      for i := 1 to RowCount - 1 do begin
        if Cells[COL_OK, i] = CheckTrue then begin
          setLength(Ids,length(Ids)+1);
          x:= high(Ids);
          Ids[x ,1] := 0;
          Ids[x ,2] :=  0;
          id := StrToIntDef(Cells[COL_PAY_ID, i],0);
          Ids[x ,1] :=  id;
          id := StrToIntDef(Cells[COL_PAY_LineID, i], 0);
          Ids[x , 2] :=  ID;
        end;
      end;
    end;
  end;
  Procedure RestoreSelection;
  var
    i,ctr:Integer;
    Amt:Double;
    cnt:Integer;
  begin
    try
      if length(Ids) =0 then exit;
      if grd = nil then exit;
      amt:= 0;
      cnt:= 0;

      for i := low(ids) to high(ids) do begin
        if ids[i,1] > 0 then
          for ctr := 1 to grd.RowCount - 1 do begin
            if ids[i,2] <=0 then begin
              if (StrToIntDef(grd.Cells[COL_PAY_ID, ctr],0) = ids[i,1]) and (StrToIntDef(grd.Cells[COL_PAY_LineID, ctr],0) = 0) then begin
                Grd.Cells[COL_OK, ctr] := Grd.Checktrue;
                amt := amt +  StrToFloatDef(Grd.Cells[COL_AMOUNT, ctr],0);
                cnt := cnt+1;
                break;
              end;
            end else begin
             if (StrToIntDef(grd.Cells[COL_PAY_ID, ctr],0) = ids[i,1]) and (StrToIntDef(grd.Cells[COL_PAY_LineID, ctr],0) = ids[i,2]) then begin
                Grd.Cells[COL_OK, ctr] := Grd.Checktrue;
                amt := amt +  StrToFloatDef(Grd.Cells[COL_AMOUNT, ctr],0);
                cnt := cnt+1;
                break;
             end;
            end;
          end;
      end;
      GetBalance(Reconciliationobj.AccountID);
      DisplayBalances(True);
    finally
      Grd.SortSettings.column := -1;
    end;
  end;
begin
  inherited;
  qry:= nil;
  bOk := true;
  if Sender is TAdvStringGrid then begin
    grd := TAdvStringGrid(Sender);
    if grd.Name = 'grdDeposits' then begin
      bIsAnyLines := Reconciliationobj.GuiDepositLines.count>0;//Reconciliationobj.DepositLines.Count>0;
      qry := TERPQuery(Reconciliationobj.GuiDepositLines.dataset);
    end else if grd.Name = 'grdWithdrawals' then begin
      bIsAnyLines := Reconciliationobj.GuiWithdrawLines.count>0;//Reconciliationobj.WithdrawalLines.Count>0;
      qry := TERPQuery(Reconciliationobj.GuiWithdrawLines.dataset);
    end else begin
      bIsAnyLines := false;
    end;

    if bIsAnyLines then begin
      iDepositID := Trunc(StrValue(grd.Cells[COL_PAY_ID, ARow]));
      if iDepositID = 0 then Exit;

      sTransType := grd.Cells[COL_NOTES, ARow];

      if (sTransType = DEPOSIT_ENTRY) or (sTransType = BANK_DEPOSIT) or (sTransType = DEPOSIT_SPLIT) then begin
        iPayID := iDepositID;
      end else begin
        iPayID := GetDepositPaymentID(iDepositID, sTransType);
      end;
      StoreSelection;
      if iPayID <> 0 then begin
        SavedAccessLevel:= self.AccessLevel;
        if Sysutils.SameText(sTransType, CUSTOMER_PAYMENT) then begin
          with TfmCustPayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, SUPPLIER_PAYMENT) then begin
          with TfmSuppPayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, CUSTOMER_PREPAYMENT) then begin
          with TfmCustPrepayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, SUPPLIER_PREPAYMENT) then begin
          with TfmSuppPrepayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, JOURNAL_ENTRY) then begin
          with TJournalEntryGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              if ReconciliationObj.Finished then begin
                AccessLevel:= 5;
                SavedAccessLevel:= self.AccessLevel;
              end;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, CHEQUE) then begin
          with TfmCheque.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, CHEQUE_DEPOSIT) then begin
          with TfmCheque.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, BANK_DEPOSIT) then begin
          with TDepositGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, DEPOSIT_ENTRY) then begin
          with TDepositEntryGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, DEPOSIT_SPLIT) then begin
          with TDepositEntryGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else begin
          CommonLib.MessageDlgXP_Vista('No Information is available for this Transaction Type', mtInformation, [mbOK], 0);
          bOk := false;
        end;

        { have to restore access level here as opening forms above with self as
          owner will change this forms access level }
        self.AccessLevel:= SavedAccessLevel;


        if (bIsNew or Reconciliationobj.OnHold) and bOk then begin
          // update grid line incase they changed something (only alloed if new)
          qry.Close;
          qry.Open;
//          LoadGrid(grd, Qry);
//          RestoreSelection;
        end;
      end;
    end; // if bIsAnyLines
  end;   // if Sender is TAdvStringGrid
end;

procedure TReconciliationGUI.FormCreate(Sender: TObject);
var
  qry: TERPQuery;
  sSQL: string;
begin
  sSQL := 'DROP TABLE IF EXISTS tempClient;' +
          'CREATE TEMPORARY TABLE tempClient AS SELECT ClientId, Company, Printname, Supplier, Customer FROM tblclients WHERE Active = "T";' +
          'ALTER TABLE tempClient ADD FULLTEXT INDEX ft_idx (Company, Printname);';
  qry  := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text  := sSQL;
    qry.ExecSQL;
  finally
    qry.Close;
  end;

  pnldebug.Visible   := False;//devmode;
  FDontAskAgain      := False;
  fdCleanDate        := 0;
  UseStatements      := False;
  FComputeTotals     := True;
  FirstStmtDep       := 1;
  FirstStmtWrt       := 1;
  fsTablename        := GetUserTemporaryTableName(ReportTempTbl);
  inherited;
  NewBusObjinstance;
  GridResizing        := False;
  UserLock.Enabled    := True;
  //Panel3.Color      := Self.TabColor;
  CommitFailed        := False;
  ChequeIDList        := TIntegerList.Create;;
  DepositIDList       := TIntegerList.Create;
  SelectedDeposits    := TIntegerList.Create;
  SelectedWithdrawals := TIntegerList.Create;
  StatementRecList    := TStatementRecList.Create;
  TotalSumBankDep     := 0;
  TotalCountBankDep   := 0;
  TotalSumBankDep     := 0;
  TotalCountBankWrt   := 0;
  gNextReconId        := 10000;
end;


procedure TReconciliationGUI.actPrintExecute(Sender: TObject);
var
  TempDS: TDataset;
  sSQL, sSQL2: string;
  dSubTotal, dExpected: double;
  dWithdrawals, dDeposits, dBalance, dOSCheques, dOSDeposits: double;
begin
  DisableForm;
  try
    if chkChooseRpt.Checked then begin
      LoadReportTypes;
      if dlgReportSelect.Execute then begin
        ReportToPrint := dlgReportSelect.SelectedItems.Text;
      end;
    end else begin
      ReportToPrint := 'Reconciliation';
    end;

    LoadTemplate(false, false);
    fbReportSQLSupplied := true;
    //Totals
    dSubTotal := 0.00; //?? Not Used
    dExpected := qryReconsCloseBalance.AsFloat;

    //Totals Deposits
    tblReconDepLines.Close;
    //tblReconDepLines.ParamByName('ID').AsInteger := qryReconsReconciliationID.AsInteger;
    tblReconDepLines.Open;
    dDeposits := SumField(tblReconDepLines, 'Amount');
    tblReconDepLines.Close;
    //Totals Withdrawals
    tblReconWithdrawalLines.Close;
    //tblReconWithdrawalLines.ParamByName('ID').AsInteger := qryReconsReconciliationID.AsInteger;
    tblReconWithdrawalLines.Open;
    dWithdrawals := SumField(tblReconWithdrawalLines, 'Amount');
    tblReconWithdrawalLines.Close;

    LoadNotReconciledData(sSQL, qryReconsAccountID.AsInteger, true);
    TempDS := RetrieveDataset(fsTableName, '', - 1);
    try
      //Totals Outstanding Deposits
      FilterDataset(TempDS, 'RecType=' + QuotedStr('Deposits'));
      dOSDeposits := SumField(TempDS, 'Deposits');
      RemoveFilterDataset(TempDS);
      //Totals Outstanding Withdrawals
      FilterDataset(TempDS, 'RecType=' + QuotedStr('Withdrawals'));
      dOSCheques := SumField(TempDS, 'Withdrawal');
      RemoveFilterDataset(TempDS);
    finally
      FreeAndNil(TempDS);
      DestroyUserTemporaryTable(fsTableName);
    end;

    dBalance := dExpected + dOSDeposits - dOSCheques;

    sSQL :=
      'SELECT COA.AccountName, M.ReconciliationID, "Deposits and Other Credits" as Type, ' +
      'M.ReconciliationDate,  M.StatementNo, ' +
      'M.OpenBalance, M.CloseBalance,  S1.DepositDate, S1.Amount AS "Deposits", 0.00 AS "Withdrawl", S1.Notes, S1.Payee, ' +
      FloatToStr(dDeposits) + '+0.00 AS TotalDeposits, ' + FloatToStr(dWithdrawals) + '+0.00 AS TotalWithdrawls, ' +
      FloatToStr(dSubTotal) + '+0.00 AS SubTotal, ' + FloatToStr(dExpected) + '+0.00 AS ExpectedBalance, ' +
      FloatToStr(dBalance) + '+0.00 AS BalanceTotal, ' + FloatToStr(dOSDeposits) + '+0.00 As OutstandingDeposits, ' +
      FloatToStr(dOSCheques) + '+0.00 As OutstandingCheques ' + ',If(Finished="T","","On HOLD") as OnHold , M.Notes reconciliationnotes ' +
      'FROM tblReconciliation AS M ' + 'LEFT JOIN tblChartOfAccounts AS COA ON M.AccountID = COA.AccountID ' +
      'INNER JOIN  tblReconciliationDepositLines AS S1 ON M.ReconciliationID = S1.ReconciliationID ' +
      'WHERE M.ReconciliationID = ' + IntToStr(ReconciliationObj.ID) +
      ' UNION ALL ' + 'SELECT COA.AccountName, M.ReconciliationID, "Cheques and Payments      " as Type, M.ReconciliationDate, ' +
      'M.StatementNo, M.OpenBalance, M.CloseBalance,  S1.DepositDate, 0.00 As "Deposits", S1.Amount AS "Withdrawl", S1.Notes, S1.Payee, ' +
      FloatToStr(dDeposits) + ' AS TotalDeposits, ' + FloatToStr(dWithdrawals) + ' AS TotalWithdrawls, ' +
      FloatToStr(dSubTotal) + ' AS SubTotal, ' + FloatToStr(dExpected) + ' AS ExpectedBalance, ' +
      FloatToStr(dBalance) + '+0.00 AS BalanceTotal, ' + FloatToStr(dOSDeposits) + '+0.00 As OutstandingDeposits, ' +
      FloatToStr(dOSCheques) + '+0.00 As OutstandingCheques ' + ',If(Finished="T","","On HOLD") as OnHold , M.notes reconciliationnotes ' +
      'FROM tblReconciliation AS M ' + 'LEFT JOIN tblChartOfAccounts AS COA ON M.AccountID = COA.AccountID ' +
      'INNER JOIN  tblReconciliationWithdrawalLines AS S1 ON M.ReconciliationID = S1.ReconciliationID ' +
      'WHERE M.ReconciliationID = ' + IntToStr(ReconciliationObj.ID);

    sSQL2 := sSQL + '~|||~{COYINFO}SELECT * FROM tblcompanyinformation';

    try
      fbReportSQLSupplied := true;
      fbTemplateUsesNonFormConnection := Reconciliationobj.OnHold;
      PrintTemplateReport('Reconciliation', sSQL2, not AppEnv.Employee.ShowPreview, 1);
      fbReportSQLSupplied := false;
    finally
      fbReportSQLSupplied := true;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TReconciliationGUI.actPrintUpdate(Sender: TObject);
begin
  inherited;
  btnPrint.Enabled := (qryReconsReconciliationID.AsInteger > 0)
end;

function TReconciliationGUI.LoadNotReconciledData(var SQLStr: string; const AccountID: integer;
  const CreateTempTable: boolean = false): integer;
var
  sSQL: string;
  qry: TERPQuery;
begin
  Result := 0;
  Processingcursor(True);
  try
      qry := TERPQuery.Create(Self);
      qry.Options.FlatBuffers := True;
      try
        sSQL           := '';
        qry.Connection := CommonDbLib.GetSharedMyDacConnection;

        sSQL           :=
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits      " as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          // Other (See Below)
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' + 'ABS(Amount) as Deposits, ' +
          '0.00 as Withdrawal, ' + 'ABS(Amount) as Amount, PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyNameLines ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BDL.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BDL.Reconciled <> "T" ' +
          'AND BDL.TrnsType<>"Deposit Entry" ' + 'AND BDL.TrnsType<>"Cheque Deposit" ' +
          'AND BDL.TrnsType<>"Cheque" ' + 'AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
          'AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' + 'AND FromDeposited<>"T" ' +
          'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' + 'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' +


          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as TransType, ' +
          //Customer Prepayment
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' + 'ABS(Amount) as Deposits, ' +
          '0.00 as Withdrawal, ' + 'ABS(Amount) as Amount, ' + 'BD.DepositID as PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' and (BDL.Reconciled <> "T") ' +
          'AND (BDL.TrnsType= '+quotedstr(CUSTOMER_PREPAYMENT)+' ) ' + 'AND (ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00) ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' +
          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          //Supplier Prepayment
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' +
          'ABS(Sum(Amount)) as Deposits, ' + '0.00 as Withdrawal, ' + 'ABS(Sum(Amount)) as Amount, ' +
          'PaymentID, ' + 'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' ' + 'and (BDL.Reconciled <> "T" ) ' +
          'AND BDL.TrnsType='+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' + 'AND BD.Deleted <>"T" AND (ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00) ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' +

          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as TransType, ' +
          //Deposit Entry
          'BD.DepositID,0 as DepositLineID,DepositDate, ' + 'ABS(Deposit) as Deposits, ' +
          '0.00 as Withdrawal, ' + 'ABS(Deposit) as Amount, ' + 'BD.DepositID as PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO,tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Deposit Entry" ' + 'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By  BD.DepositID ' +

          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          //Deposit Entry Split
          'BD.DepositID,DepositLineID,DepositDate, ' + 'ABS(Amount) as Deposits, ' +
          '0.00 as Withdrawal, ' + 'ABS(Amount) as Amount, ' + 'BD.DepositID as PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BDL.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Deposit Entry" ' + 'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' +

          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits" as RecType, ' + '"Bank Deposit" as TransType, ' +
          //Bank Deposit
          'BD.DepositID,0 as DepositLineID,DepositDate, ' + 'ABS(Deposit) as Deposits, ' +
          '0.00 as Withdrawal, ' + 'ABS(Deposit) as Amount, ' + 'BD.DepositID as PaymentID, ' +
          'BD.Notes as ReferenceNo, ' + '"Bank Deposit" as Notes, ' + '"" as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' and ( BD.Reconciled <> "T") ' +
          'AND (BDL.TrnsType<>"Deposit Entry" AND BDL.TrnsType<>"Cheque Deposit" ' +
          'AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '  ) ' +
          'AND (ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00) AND FromDeposited="T" ' + 'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By  BD.DepositID ' +

          //Cheques
          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          'BD.DepositID,0 as DepositLineID,DepositDate, ' + 'ABS(Sum(Amount)) as Deposits, ' +
          '0.00 as Withdrawal, ' + 'ABS(Sum(Amount)) as Amount, ' + 'PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Cheque" ' + 'AND BD.Deleted <>"T" ' +
          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BD.DepositID ' +
          //Cheque Deposits '+
          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Deposits" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as TransType, ' +
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' + 'ABS(Sum(Amount)) as Deposits, ' +
          '0.00 as Withdrawal, ' + 'ABS(Sum(Amount)) as Amount, ' + 'PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO,tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Cheque Deposit" ' + 'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' +
          // Other (See Below)
          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Amount) as Withdrawal, ' + 'ABS(Amount) as Amount, PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BDL.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BDL.Reconciled <> "T" ' +
          'AND BDL.TrnsType<>"Deposit Entry" ' + 'AND BDL.TrnsType<>"Cheque" ' +
          'AND BDL.TrnsType<>"Cheque Deposit" ' + 'AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
          'AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' + 'AND BD.Deleted <>"T" ' +
          'AND FromDeposited<>"T" ' + 'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date) )+

          ' Group By BDL.DepositLineID ' +
          'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' + '"Bank Deposit" as TransType, ' +
          //Bank Deposit
          'BD.DepositID,0 as DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Deposit) as Withdrawal, ' + 'ABS(Deposit) as Amount, ' +
          'BD.DepositID as PaymentID, BD.Notes as ReferenceNo, ' + '"Bank Deposit" as Notes, ' +
          '"" as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' +
          'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' + 'WHERE BD.AccountID = ' +
          IntToStr(AccountID) + ' and ( BD.Reconciled <> "T") ' +
          'AND (BDL.TrnsType<>"Deposit Entry" AND BDL.TrnsType<>"Cheque" ' +
          'AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '  ) ' +
          'AND (ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00) AND FromDeposited="T" ' + 'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By  BD.DepositID ' + 'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as TransType, ' +
          //Deposit Entry
          'BD.DepositID,0 as DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Deposit) as Withdrawal, ' + 'ABS(Deposit) as Amount, ' + 'BD.DepositID as PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Deposit Entry" ' + 'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By  BD.DepositID ' + 'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          //Deposit Entry Split
          'BD.DepositID,DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Amount) as Withdrawal, ' + 'ABS(Amount) as Amount, ' + 'BD.DepositID as PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BDL.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BDL.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Deposit Entry" ' + 'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' + 'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          //Supplier Prepayment
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Sum(Amount)) as Withdrawal, ' + 'ABS(Sum(Amount)) as Amount, PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BDL.AccountID = ' + IntToStr(AccountID) + ' ' + 'and (BDL.Reconciled <> "T" ) ' +
          'AND BDL.TrnsType='+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' + 'AND BD.Deleted <>"T" AND (ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00) ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' + 'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as TransType, ' +
          //Customer Prepayment
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Deposit) as Withdrawal, ' + 'ABS(Deposit) as Amount, ' + 'BD.DepositID as PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' and (BDL.Reconciled <> "T") ' +
          'AND (BDL.TrnsType= '+quotedstr(CUSTOMER_PREPAYMENT)+' ) ' + 'AND (ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00) ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' + 'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as TransType, ' +
          //Cheques
          'BD.DepositID,0 as DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Sum(Amount)) as Withdrawal, ' + 'ABS(Sum(Amount)) as Amount, ' + 'PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Cheque" ' + 'AND BD.Deleted <>"T" ' +
          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date))+

          ' Group By BD.DepositID ' + 'UNION ALL ' +
          'Select CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, '
          + '"' + GetAccountName(AccountID) + '" as AccountName,"Withdrawals" as RecType, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as TransType, ' +
          //Cheque Deposits
          'BD.DepositID,BDL.DepositLineID,DepositDate, ' + '0.00 as Deposits, ' +
          'ABS(Sum(Amount)) as Withdrawal, ' + 'ABS(Sum(Amount)) as Amount, ' + 'PaymentID, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblCompanyInformation AS CO, tblbankdeposit BD ' + 'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(AccountID) + ' ' + 'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Cheque Deposit" ' + 'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
          'AND BD.Deleted <>"T" ' +

          'AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)) +

          ' Group By BDL.DepositLineID ' +
          'Order By RecType,TransType,DepositDate;';

        SQLStr := sSQL;

        if CreateTempTable then begin
          DestroyUserTemporaryTable(fsTableName);
          sSQL := 'CREATE TABLE `' + fsTableName + '` ' + sSQL;
          qry.SQL.Text := sSQL;
          qry.Execute;
        end else begin
          qry.SQL.Text := sSQL;
          qry.Open;
          Result := qry.RecordCount;
          qry.Close;
        end;
      finally
        FreeAndNil(qry);
      end;
  finally
    Processingcursor(False);
  end;
end;


procedure TReconciliationGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTableName);
  ChequeIDList.Free;
  DepositIDList.Free;
  SelectedDeposits.Free;
  SelectedWithdrawals.Free;
  StatementRecList.Free;
  inherited;
end;

procedure TReconciliationGUI.btnDepositNextClick(Sender: TObject);
begin
  if not Empty(cboAccount.Text) then SearchAmount(Sender, grdDeposits, edtDepositSearch, true);
end;

procedure TReconciliationGUI.btnhelp1Click(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Bank Reconciliation Auto Detect Feature');
end;
procedure TReconciliationGUI.btnhelpClick(Sender: TObject);
//var
//  Bankdeposit :TBankDeposit;
//  BankWithdrawl : TCheque;
//  i           : Integer;
//  ThisStatementRec : TStatementRec;
//  qry         : TErpQuery;
//  sAccountName : string;
begin
  inherited;
//
//    BankWithdrawl := TCheque.create(Self);
//    try
//      BankWithdrawl.Connection := ReconciliationObj.Connection;
//      BankWithdrawl.Load(0);
//      BankWithdrawl.new;
//      //BankWithdrawl.PostDb;
//      showmessage(Format('amount inc = %m and cheque total = %m ', [Bankwithdrawl.TotalAmountInc, BankWithdrawl.Chequetotal]));
//      //BankWithdrawl.SilentMode := True;
//      //BankWithdrawl.PostDB;
//      BankWithdrawl.GLAccountId       := ReconciliationObj.AccountID;
//      Bankwithdrawl.SupplierName      := 'Ache Co';
//      BankWithdrawl.RefNo             := '12345678';
//      //Bankwithdrawl.TotalAmountInc := 100;
//      BankWithdrawl.Lines.New;
//      //BankWithdrawl.Lines.TotalLineAmountInc := 100;
//      showmessage(Format('amount inc = %m and cheque total = %m ', [Bankwithdrawl.TotalAmountInc, BankWithdrawl.Chequetotal]));
//      BankWithdrawl.Lines.LineCostInc        := 100;
//      //BankWithdrawl.Lines.LineCost        := 100;
//      //BankWithdrawl.Lines.LineTaxTotal       := 0;
//      showmessage(Format('amount inc = %m and cheque total = %m ', [Bankwithdrawl.TotalAmountInc, BankWithdrawl.Chequetotal]));
//      BankWithdrawl.Lines.AccountName := 'Rent';
//      BankWithdrawl.Lines.ProductDescription  := 'Something';
//      BankWithdrawl.Lines.TransDate     := Date;
//      BankWithdrawl.Chequetotal       := Bankwithdrawl.TotalAmountInc;
//      BankWithdrawl.Lines.PostDB;
//      showmessage(Format('amount inc = %m and cheque total = %m ', [Bankwithdrawl.TotalAmountInc, BankWithdrawl.Chequetotal]));
//      BankWithdrawl.Save;
//      CommitTransaction;
//    finally
//      BankWithdrawl.Free;
//    end;

end;

procedure TReconciliationGUI.SearchText(Colno:Integer; Searchvalue: String; SearchGrid: TAdvStringGrid);
var
  Row: Integer;
begin
  if SearchValue = '' then Exit;

  SearchGrid.ShowSelection := True;
  SearchGrid.SelectionRectangle := True;

  Row := SearchGrid.FixedRows - 1;
  for Row := SearchGrid.Fixedrows - 1 to SearchGrid.Rowcount - 1 do begin
    if SameText(SearchGrid.Cells[Colno, Row], Searchvalue) then begin
      SearchGrid.Row := Row;
      Exit;
    end;
  end;
end;

procedure TReconciliationGUI.SearchAmount(Sender: TObject; SearchGrid: TAdvStringGrid;
  SearchEdit: TwwDbEdit; SearchForward: boolean = true);
var
  Row: integer;
  SearchValue: double;
begin
  SearchGrid.ShowSelection := true;
  SearchGrid.SelectionRectangle := true;

  Row := SearchGrid.Row;
  SearchValue := StrValue(SearchEdit.Text);
  
  if CompareValue(CurrentGridCellAmount(SearchGrid), SearchValue) = EqualsValue then begin
    if TDNMSpeedButton(Sender).Caption = CAPTION_NEXT then begin
      if SearchForward then Inc(Row)
      else Dec(Row);
    end else TDNMSpeedButton(Sender).Caption := CAPTION_NEXT;
  end;

  while true do begin
    if (Row = (SearchGrid.FixedRows - 1)) or (Row = SearchGrid.RowCount) then Break;
    
    if CompareValue(GridCellAmount(SearchGrid, Row), SearchValue) = EqualsValue then begin // value found
      SearchGrid.Row := Row;
      TDNMSpeedButton(Sender).Caption := CAPTION_NEXT;
      Exit;
    end;
      
    if SearchForward then Inc(Row)
    else Dec(Row);
  end;  
  SearchGrid.ShowSelection := false;
  SearchGrid.SelectionRectangle := false;
  CommonLib.MessageDlgXP_Vista(SearchEdit.Text + ' value not found.', mtInformation, [mbOK], 0);
  TDNMSpeedButton(Sender).Caption := CAPTION_GO;
end;

procedure TReconciliationGUI.Splitter1Moved(Sender: TObject);
begin
  inherited;
  pnlgrdDepositsSum.Width:= pnlgrdWithdrawalsSum.Width;
end;

procedure TReconciliationGUI.tblReconDepLinesDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  inherited;
  Action := daAbort;
end;

procedure TReconciliationGUI.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
var
  ChequeForm: TfmCheque;
  DepositForm: TDepositEntryGUI;
  qry: TERPQuery;
begin
  inherited;
  if (not Cancelled) and Assigned(aObject) then begin
    if aObject is TfmCheque then begin
      ChequeForm:= TfmCheque(aObject);
      if chkFilterDate.Checked and
           (ChequeForm.ChequeObj.OrderDate > qryReconsReconciliationDate.AsDateTime) then begin
        CommonLib.MessageDlgXP_Vista('The date on the Cheque is after the selected Statement Date so it will not appear in the current Withdrawals list',mtInformation,[mbOk],0);
        exit;
      end
      else if ChequeForm.ChequeObj.GLAccountId <> qryReconsAccountID.AsInteger then begin
        CommonLib.MessageDlgXP_Vista('The Account on the Cheque does not match the selected Statement Account so it will not appear in the current Withdrawals list',mtInformation,[mbOk],0);
        exit;
      end;
      qry:= TERPQuery.Create(nil);
      try
        qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
        //Cheques
        qry.SQL.Add('SELECT 7 as Seqno,tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
          'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +                                                                                         //  Grouping
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
          'FROM tblbankdeposit  ' +
          'INNER JOIN tblbankdepositlines Using (DepositID) ' +
          'WHERE tblbankdeposit.AccountID = ' + IntToStr(qryReconsAccountID.AsInteger) + ' ' +
          'AND tblbankdeposit.Reconciled <> "T"  ' +
          'AND tblbankdepositlines.TrnsType="Cheque" ' +
          'AND tblbankdeposit.Deleted <>"T" ' +
          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ');
        if ChequeIDList.count > 0 then qry.SQL.Add('and PaymentID not in (' + ChequeIDList.CommaText + ')');
        if chkFilterDate.Checked then
          qry.SQL.Add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)));

        qry.SQL.Add('Group By tblbankdeposit.DepositID  '); //Not tblbankdepositlines.DepositLineID  Because Sum Of Cheque Header Account
        qry.SQL.Add('Order By DepositDate ');
        qry.Open;
        if Qry.REcordcount =0 then exit;
        while not qry.Eof do begin
          with grdWithdrawals, qry do begin
            ChequeIDList.Add(FieldByName('PaymentID').AsInteger);
            RowCount := RowCount + 1;
            AddCheckBox(COL_OK, RowCount - 1, false, true);
            Cells[COL_OK, RowCount - 1] := CheckFalse;
            AddCheckBox(COL_BANK_OK, RowCount - 1, false, true);
            Cells[COL_BANK_OK, RowCount - 1] := CheckFalse;
            Cells[COL_DATE, RowCount - 1] := FieldByName('DepositDate').AsString;
            Cells[COL_REF, RowCount - 1] := FieldByName('ReferenceNo').AsString;
            Cells[COL_PAYEE, RowCount - 1] := FieldByName('CompanyName').AsString;
            Cells[COL_NOTES, RowCount - 1] := FieldByName('Notes').AsString;
            Cells[COL_AMOUNT_FMT, RowCount - 1] :=
              CurrToStrF(FieldByName('Amount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
            Cells[COL_AMOUNT, RowCount - 1] := FieldByName('Amount').AsString;
            Cells[COL_PAY_ID, RowCount - 1] := FieldByName('PaymentID').AsString;
            Cells[COL_DEP_ID, RowCount - 1] := FieldByName('DepositID').AsString;
            Cells[COL_PAY_LineID, RowCount - 1] := FieldByName('DepositLineID').AsString;
            Cells[COL_CLIENT_ID, RowCount - 1] := FieldByName('CusID').AsString;
            if ChequeForm.ChequeObj.Id = FieldByName('PaymentID').AsInteger then begin
              grdWithdrawals.row := grdWithdrawals.RowCount-1;
              grdWithdrawals.ShowSelection := true;
              grdWithdrawals.SelectionRectangle := true;
            end;
          end;
          qry.Next;
        end;
      finally
        qry.Free;
      end;
    end
    else if aObject is TDepositEntryGUI then begin
      DepositForm:= TDepositEntryGUI(aObject);
      if chkFilterDate.Checked and
           (DepositForm.Bankdeposit.DepositDate > qryReconsReconciliationDate.AsDateTime) then begin
        CommonLib.MessageDlgXP_Vista('The date on the Deposit is after the selected Statement Date so it will not appear in the current Deposit list',mtInformation,[mbOk],0);
        exit;
      end
      else if DepositForm.BankDeposit.AccountId <> qryReconsAccountID.AsInteger then begin
        CommonLib.MessageDlgXP_Vista('The Account on the Deposit does not match the selected Statement Account so it will not appear in the current Deposits list',mtInformation,[mbOk],0);
        exit;
      end;
      qry:= TERPQuery.Create(nil);
      try
        qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
        //Cheques
        qry.SQL.Add('SELECT 4 as Seqno,BD.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
          'BD.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
          'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
          'FROM tblbankdeposit BD ' +
          'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
          'WHERE BD.AccountID = ' + IntToStr(qryReconsAccountID.AsInteger) + ' ' +
          'AND BD.Reconciled <> "T" ' +
          'AND BDL.TrnsType="Deposit Entry" ' +
          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
          'AND BD.Deleted <>"T"  ');

        if DepositIDList.count > 0 then qry.SQL.Add('and BD.DepositID not in (' + DepositIDList.CommaText + ')');
        if chkFilterDate.Checked then
          qry.SQL.Add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)));

        qry.SQL.Add('Group By BD.DepositID');
        qry.SQL.Add('Order By DepositDate');

        qry.Open;
        if Qry.REcordcount =0 then exit;
        while not qry.Eof do begin
          with grdDeposits, qry do begin
            DepositIDList.Add(FieldByName('PaymentID').AsInteger);
            RowCount := RowCount + 1;
            AddCheckBox(COL_OK, RowCount - 1, false, true);
            Cells[COL_OK, RowCount - 1] := CheckFalse;
            Cells[COL_DATE, RowCount - 1] := FieldByName('DepositDate').AsString;
            Cells[COL_REF, RowCount - 1] := FieldByName('ReferenceNo').AsString;
            Cells[COL_PAYEE, RowCount - 1] := FieldByName('CompanyName').AsString;
            Cells[COL_NOTES, RowCount - 1] := FieldByName('Notes').AsString;
            Cells[COL_AMOUNT_FMT, RowCount - 1] := CurrToStrF(FieldByName('Amount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
            Cells[COL_AMOUNT, RowCount - 1] := FieldByName('Amount').AsString;
            Cells[COL_PAY_ID, RowCount - 1] := FieldByName('DepositID').AsString;
            Cells[COL_DEP_ID, RowCount - 1] := FieldByName('DepositID').AsString;
            Cells[COL_PAY_LineID, RowCount - 1] := FieldByName('DepositLineID').AsString;
            Cells[COL_CLIENT_ID, RowCount - 1] := FieldByName('CusID').AsString;
            if DepositForm.Bankdeposit.Id = FieldByName('DepositID').AsInteger then begin
              grdDeposits.row := grdDeposits.RowCount-1;
            end;
          end;
          qry.Next;
        end;
      finally
        qry.Free;
      end;
    end;
  end;
//  btnStrictMatchClick(Nil);
//  btnRelaxedMatchClick(Nil);
end;

procedure TReconciliationGUI.UpdateTransactions;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    //Cheques
    qry.SQL.Add('SELECT 4 as Seqno,BD.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'BD.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,BDL.CompanyName ,"") as CompanyName ' +
      'FROM tblbankdeposit BD ' +
      'INNER JOIN tblbankdepositlines BDL Using (DepositID) ' +
      'WHERE BD.AccountID = ' + IntToStr(qryReconsAccountID.AsInteger) + ' ' +
      'AND BD.Reconciled <> "T" ' +
      'AND BDL.TrnsType="Deposit Entry" ' +
      'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
      'AND BD.Deleted <>"T"  ');

    if DepositIDList.count > 0 then qry.SQL.Add('and BD.DepositID not in (' + DepositIDList.CommaText + ')');
    if chkFilterDate.Checked then
      qry.SQL.Add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)));

    qry.SQL.Add('Group By BD.DepositID');
    qry.SQL.Add('Order By DepositDate');

    qry.Open;
    if Qry.REcordcount =0 then exit;
    while not qry.Eof do begin
      with grdDeposits, qry do begin
 //       DepositIDList.Add(FieldByName('PaymentID').AsInteger);
        RowCount := RowCount + 1;
        AddCheckBox(COL_OK, RowCount - 1, false, true);
        Cells[COL_OK, RowCount - 1] := CheckFalse;
        AddCheckBox(COL_BANK_OK, RowCount - 1, false, true);
        Cells[COL_BANK_OK, RowCount - 1] := CheckFalse;
        Cells[COL_DATE, RowCount - 1] := FieldByName('DepositDate').AsString;
        Cells[COL_REF, RowCount - 1] := FieldByName('ReferenceNo').AsString;
        Cells[COL_PAYEE, RowCount - 1] := FieldByName('CompanyName').AsString;
        Cells[COL_NOTES, RowCount - 1] := FieldByName('Notes').AsString;
        Cells[COL_AMOUNT_FMT, RowCount - 1] := CurrToStrF(FieldByName('Amount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
        Cells[COL_AMOUNT, RowCount - 1] := FieldByName('Amount').AsString;
        Cells[COL_PAY_ID, RowCount - 1] := FieldByName('PaymentID').AsString;
        Cells[COL_DEP_ID, RowCount - 1] := FieldByName('DepositID').AsString;
        Cells[COL_PAY_LineID, RowCount - 1] := FieldByName('DepositLineID').AsString;
        Cells[COL_CLIENT_ID, RowCount - 1] := FieldByName('CusID').AsString;
//        if DepositForm.Bankdeposit.Id = FieldByName('DepositID').AsInteger then begin
//          grdDeposits.row := grdDeposits.RowCount-1;
//          grdDeposits.ShowSelection := true;
//          grdDeposits.SelectionRectangle := true;
//        end;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;

  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    //Cheques
    qry.SQL.Add('SELECT 7 as Seqno,tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +                                                                                         //  Grouping
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
      'FROM tblbankdeposit  ' +
      'INNER JOIN tblbankdepositlines Using (DepositID) ' +
      'WHERE tblbankdeposit.AccountID = ' + IntToStr(qryReconsAccountID.AsInteger) + ' ' +
      'AND tblbankdeposit.Reconciled <> "T"  ' +
      'AND tblbankdepositlines.TrnsType="Cheque" ' +
      'AND tblbankdeposit.Deleted <>"T" ' +
      'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ');
    if ChequeIDList.count > 0 then qry.SQL.Add('and PaymentID not in (' + ChequeIDList.CommaText + ')');
    if chkFilterDate.Checked then
      qry.SQL.Add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate.Date)));

    qry.SQL.Add('Group By tblbankdeposit.DepositID  '); //Not tblbankdepositlines.DepositLineID  Because Sum Of Cheque Header Account
    qry.SQL.Add('Order By DepositDate ');
    qry.Open;
    if Qry.REcordcount =0 then exit;
    while not qry.Eof do begin
      with grdWithdrawals, qry do begin
        //ChequeIDList.Add(FieldByName('PaymentID').AsInteger);
        RowCount := RowCount + 1;
        AddCheckBox(COL_OK, RowCount - 1, false, true);
        Cells[COL_OK, RowCount - 1] := CheckFalse;
        AddCheckBox(COL_BANK_OK, RowCount - 1, false, true);
        Cells[COL_BANK_OK, RowCount - 1] := CheckFalse;
        Cells[COL_DATE, RowCount - 1] := FieldByName('DepositDate').AsString;
        Cells[COL_REF, RowCount - 1] := FieldByName('ReferenceNo').AsString;
        Cells[COL_PAYEE, RowCount - 1] := FieldByName('CompanyName').AsString;
        Cells[COL_NOTES, RowCount - 1] := FieldByName('Notes').AsString;
        Cells[COL_AMOUNT_FMT, RowCount - 1] :=
          CurrToStrF(FieldByName('Amount').AsCurrency, ffCurrency, CurrencyRoundPlaces);
        Cells[COL_AMOUNT, RowCount - 1] := FieldByName('Amount').AsString;
        Cells[COL_PAY_ID, RowCount - 1] := FieldByName('PaymentID').AsString;
        Cells[COL_DEP_ID, RowCount - 1] := FieldByName('DepositID').AsString;
        Cells[COL_PAY_LineID, RowCount - 1] := FieldByName('DepositLineID').AsString;
        Cells[COL_CLIENT_ID, RowCount - 1] := FieldByName('CusID').AsString;
//        if ChequeForm.ChequeObj.Id = FieldByName('PaymentID').AsInteger then begin
//          grdWithdrawals.row := grdWithdrawals.RowCount-1;
//          grdWithdrawals.ShowSelection := true;
//          grdWithdrawals.SelectionRectangle := true;
//        end;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;

//  btnStrictMatchClick(Nil);
//  btnRelaxedMatchClick(Nil);
end;

procedure TReconciliationGUI.btnWithdrawalsNextClick(Sender: TObject);
begin
  if not Empty(cboAccount.Text) then SearchAmount(Sender, grdWithdrawals, edtWithdrawalSearch, true);
end;

procedure TReconciliationGUI.edtDepositSearchChange(Sender: TObject);
begin
  inherited;
  btnDepositNext.Caption := CAPTION_GO;
  grdDeposits.Row := 1;
end;

procedure TReconciliationGUI.edtStatementExit(Sender: TObject);
begin
  inherited;
  logtext(grdWithdrawals.Cells[col_ok, grdWithdrawals.RowCount - 1]);
  ReconciliationObj.StatementNo := edtStatement.Text;
  Application.ProcessMessages;
end;

procedure TReconciliationGUI.edtWithdrawalSearchChange(Sender: TObject);
begin
  inherited;
  btnWithdrawalsNext.Caption := CAPTION_GO;
  grdWithdrawals.Row := 1;
end;

function TReconciliationGUI.GridCellAmount(AGrid: TAdvStringGrid; ARow: integer): double;
begin
  Result := StrValue(AGrid.Cells[COL_AMOUNT, ARow]);
end;

function TReconciliationGUI.CurrentGridCellAmount(AGrid: TAdvStringGrid): double;
begin
  Result := GridCellAmount(AGrid, AGrid.Row);
end;

function TReconciliationGUI.CountMarkedTrans: Integer;
var
  i: integer;
begin
  Result := 0;
    with grdDeposits do begin
      for i := 1 to RowCount - 1 do begin
        if Cells[COL_OK, i] = CheckTrue then begin
          Result := Result+1;
        end;
      end;
    end;
    with grdWithdrawals do begin
      for i := 1 to RowCount - 1 do begin
        if Cells[COL_OK, i] = CheckTrue then begin
          Result := Result+1;
        end;
      end;
    end;
end;

procedure TReconciliationGUI.KeyIdChanged(const NewKeyId: integer);
begin
  inherited;
  if AccessLevel <> 1 then begin // either full access or no access
    AccessLevel := 6;
    CommonLib.MessageDlgXP_Vista('You Have No Access To Reconciliation Form', mtInformation, [mbOK], 0);
  end;
end;

procedure TReconciliationGUI.AdvSplitter3Moved(Sender: TObject);
begin
  inherited;
  pnlDepositSearch.Invalidate;
  Panel2.Invalidate;
  pnlWithdrawalsSearch.Invalidate;
  Panel5.Invalidate;
end;

procedure TReconciliationGUI.AdvSplitter3DblClick(Sender: TObject);
begin
  inherited;
  If Panel1.Height > 23 then
    Panel1.Height := 23
  else
    Panel1.Height := Panel3.Height - 30;
end;

procedure TReconciliationGUI.FormPaint(Sender: TObject);
begin
  inherited;
  pnlDepositSearch.Invalidate;
  Panel2.Invalidate;
  pnlWithdrawalsSearch.Invalidate;
  Panel5.Invalidate;
end;

function TReconciliationGUI.IsLightColor (AColor: TColor) : Boolean;
begin
  AColor := colortorgb(AColor);
  result := HiByte((AColor and $ff) * 77 + ((AColor and $ff00) shr 8) * 151
  + ((AColor and $ff0000) shr 16)* 28)>128;
end;

procedure TReconciliationGUI.grdDepositsGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  inherited;
  if ARow = 0 then exit;
  ABrush.Color := clWindow;
  if grdDeposits.Cells[COL_RECON_ID, ARow] <> '' then begin
    ABrush.Color := $00C4FFE1; // clInfoBk; // GridBrush.Colors[StrToIntDef(grdDeposits.Cells[COL_RECON_ID, ARow], 1)];
    //if IsLightColor (ABrush.Color) then AFont.Color := clBlack else AFont.Color := clWhite;
    exit;
  end;

  if (not UseStatements) then begin
    if grdDeposits.Cells[COL_OK, ARow] = 'T' then begin
      ABrush.Color := $00C4FFE1; // GridBrush.Colors[StrToIntDef(grdDeposits.Cells[COL_RECON_ID, ARow], 1)];
      //if IsLightColor (ABrush.Color) then AFont.Color := clBlack else AFont.Color := clWhite;
      exit;
    end;

    if grdDeposits.Cells[COL_BANK_OK, ARow] = 'T' then begin
      ABrush.Color := $00C4FFE1; // GridBrush.Colors[StrToIntDef(grdDeposits.Cells[COL_RECON_ID, ARow], 1)];
      //if IsLightColor (ABrush.Color) then AFont.Color := clBlack else AFont.Color := clWhite;
      exit;
    end;
  end;

  if ((COL_STATEMENT_DATE = ACol) or (COL_STATEMENT_AMOUNT_FMT = ACol) or (COL_STATEMENT_DESC = ACol) or (COL_BANK_OK = ACol)) then begin
    AFont.Color := clBlue;
    AFont.Style := [fsItalic];
  end;


end;

Procedure TReconciliationGUI.AfterFormShow;
var
  MsgOption : Word;
  sMessage  : string;
begin
  inherited;
  MsgOption := mrOk;
  if FDontAskAgain then exit;
  if not UseStatements then begin
     MsgOption := CommonLib.MessageDlgXP_Vista('You have not signed up for Yodlee (Bank Integration) yet.' + NL + NL +
                  'Please contact ERP to enable Yodlee (Bank Integration) as it is free to sign up and use.',mtinformation,[MBOK],0,
                      nil   {Owner},
                      ''    {Instruction},
                      'Don''t ask again'    {VerifyText},
                      false {VerifyChecked},
                      SaveVerifyPref   {OnVerifyClick},
                      'Sign Up'    {CustomButtonsStr},
                      ''    {Soundfilename},
                      400     {MsgBoxWidth}
                      );
     if MsgOption = 100 then begin
      Processingcursor(true);
      try
        sMessage := Appenv.CompanyInfo.Companyname + ' would like to sign up for Yodlee (Bank Integration). ' + NL + NL +
                    'Our company details are listed as under: ' + NL + NL +
                    '    Company     :' + Appenv.CompanyInfo.Companyname + NL +
                    '    Phone       :' + Appenv.CompanyInfo.Phonenumber + NL +
                    '    Email       :' + Appenv.CompanyInfo.Email + NL +
                    '    Server      :' + GetSharedMyDacConnection.Server + NL +
                    '    Datase      :' + GetSharedMyDacConnection.Database + NL +
                    '    Version     :' + TABLE_VERSION + NL +
                    '    CoreEDI.Username     :' + AppEnv.CompanyPrefs.CoreEDIUSerName + NL +
                    '    CoreEDI.Password     :' + AppEnv.CompanyPrefs.CoreEDIPassword;

        sMessage := sMessage + NL + NL +
                    'With warm regards' + NL + NL +
                    Appenv.CompanyInfo.ContactName;

        EmailUtilsDefaultMailClient.SendMail('accounts@vs1cloud.com', 'Yodlee (Bank Integration) Sign-up', sMessage);
      finally
        Processingcursor(false);
      end;

    end;
  end;
end;


procedure TReconciliationGUI.BeginTransaction;
begin
  Reconciliationobj.connection.BeginTransaction;
end;

function TReconciliationGUI.HasBankStatementItems:Boolean;
var
  ctr:Integer;
begin
  Result := False;
  if not(UseStatements) then exit;

      {check in deposits if any raw is bank statement entry}
      for ctr:= 1 to grdDeposits.RowCount -1 do begin
        if (StrToIntDef(grdDeposits.Cells[COL_BSL_ID,ctr],0) > 0) then begin
          Result := True;
          Exit;
        end;
      end;

      {check in withdrawal if any raw is bank statement entry}
      for ctr:= 1 to grdWithdrawals.RowCount -1 do begin
        if (StrToIntDef(grdWithdrawals.Cells[COL_BSL_ID,ctr],0) > 0) then begin
          Result := True;
          Exit;
        end;
      end;
end;

procedure TReconciliationGUI.grdDepositsSumColumnSize(Sender: TObject;
  ACol: Integer; var Allow: Boolean);
begin
  inherited;
  SetGridcolwidth(grdWithdrawalsSum, ACol,grdDepositsSum.colwidths[Acol]);
  //grdWithdrawalsSum.colwidths[Acol] := grdDepositsSum.colwidths[Acol];
end;

procedure TReconciliationGUI.grdWithdrawalsGetCellColor(Sender: TObject;
  ARow, ACol: Integer; AState: TGridDrawState; ABrush: TBrush;
  AFont: TFont);
begin
  inherited;
  if ARow =0 then exit;
  ABrush.Color := clWindow;

  if grdWithdrawals.Cells[COL_RECON_ID, ARow] <> '' then begin
    ABrush.Color := $00C4FFE1; // clInfoBk; // GridBrush.Colors[StrToIntDef(grdDeposits.Cells[COL_RECON_ID, ARow], 1)];
    //if IsLightColor (ABrush.Color) then AFont.Color := clBlack else AFont.Color := clWhite;
    exit;
  end;

  if (not UseStatements) then begin
    if grdWithdrawals.Cells[COL_OK, ARow] = 'T' then begin
      ABrush.Color := $00C4FFE1; // GridBrush.Colors[StrToIntDef(grdDeposits.Cells[COL_RECON_ID, ARow], 1)];
      //if IsLightColor (ABrush.Color) then AFont.Color := clBlack else AFont.Color := clWhite;
      exit;
    end;
//
    if grdWithdrawals.Cells[COL_BANK_OK, ARow] = 'T' then begin
      ABrush.Color := $00C4FFE1; // GridBrush.Colors[StrToIntDef(grdDeposits.Cells[COL_RECON_ID, ARow], 1)];
      //if IsLightColor (ABrush.Color) then AFont.Color := clBlack else AFont.Color := clWhite;
      exit;
    end;
  end;

  if ((COL_STATEMENT_DATE = ACol) or (COL_STATEMENT_AMOUNT_FMT = ACol) or (COL_STATEMENT_DESC = ACol) or (COL_BANK_OK = ACol)) then begin
    AFont.Color := clBlue;
    AFont.Style := [fsItalic];
  end;
end;

procedure TReconciliationGUI.grdWithdrawalsSumColumnSize(Sender: TObject;
  ACol: Integer; var Allow: Boolean);
begin
  inherited;
  SetGridcolwidth(grdDepositsSum, ACol,grdWithdrawalsSum.colwidths[Acol]);
end;

procedure TReconciliationGUI.dtDateEnter(Sender: TObject);
begin
  inherited;
  fdCleanDate:= Reconciliationobj.ReconciliationDate;
end;
Procedure TReconciliationGUI.DeleteLinesIfAfterRecondate;
var
  i:Integer;
begin
      with grdDeposits do begin
        for i := 1 to RowCount - 1 do begin
          if (Cells[COL_OK, i] = CheckTrue) and (StrToDate(Cells[COL_DATE, i])> dtDate.Date) then begin
            Cells[COL_OK, i] := CheckFalse;
            grdDepositsCheckBoxClick(grdDeposits, COL_OK, i, false);
          end;
        end;
      end;
      with grdWithdrawals do begin
        for i := 1 to RowCount - 1 do begin
          if (Cells[COL_OK, i] = CheckTrue) and (StrToDate(Cells[COL_DATE, i])> dtDate.Date) then begin
            Cells[COL_OK, i] := CheckFalse;
            grdWithdrawalsCheckBoxClick(grdWithdrawals, COL_OK, i, false);
          end;
        end;
      end;
end;


procedure TReconciliationGUI.dtDateExit(Sender: TObject);
var
  x: integer;
begin
  inherited;
  if fdCleanDate = dtDate.Date then exit;// date is not changed
  if (fdCleanDate > dtDate.Date) then DeleteLinesIfAfterRecondate;

  fdCleanDate:= Reconciliationobj.ReconciliationDate;
  if (dtDate.Date > Date)  then begin
    CommonLib.MessageDlgXP_Vista('Future dates can not be selected', mtInformation, [mbOK], 0);
    if qryRecons.State in [dsEdit,dsInsert] then qryReconsReconciliationDate.AsDateTime:= Date;
    InitGrid;
    LoadTransactions;
    MatchSavedTrans;
    Exit;
  end;
  ClearGrid(grdWithdrawals);
  ClearGrid(grdDeposits);
  if cboAccount.Text <> '' then begin
    if Reconciliationobj.OnHold then begin
      InitGrid;
      LoadTransactions;
      if UseStatements then btnRelaxedMatchClick(Nil)
      else MatchSavedTrans;
//    btnStrictMatchClick(Nil);
    end else begin
      SelectedDeposits.Clear;
      for x:= 1 to grdDeposits.RowCount -1 do begin
        if (grdDeposits.Cells[COL_OK, x] = grdDeposits.CheckTrue) then
          SelectedDeposits.Add(Integer(grdDeposits.Objects[COL_OK, x]));
      end;

      SelectedWithdrawals.Clear;
      for x:= 1 to grdWithdrawals.RowCount -1 do begin
        if (grdWithdrawals.Cells[COL_OK, x] = grdWithdrawals.CheckTrue) then
          SelectedWithdrawals.Add(Integer(grdWithdrawals.Objects[COL_OK, x]));
      end;
      cboAccountCloseUp(cboAccount, cboAccount.LookupTable, cboAccount.DataSource.dataset, true);
    end;
  end

end;

{$ifdef COMPILER_22_UP}
procedure TReconciliationGUI.grdDepositsGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TAsgVAlignment);
{$else}
procedure TReconciliationGUI.grdDepositsGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
{$endif}
begin
  inherited;
  if ((ACol = COL_AMOUNT_FMT) or (ACol = COL_STATEMENT_AMOUNT) or (ACol = COL_STATEMENT_AMOUNT_FMT)) then
    HAlign:= taRightJustify
  else if ((ACol = COL_OK) or (ACol = COL_BANK_OK) or (ACol = COL_SELECT) or (ACol = COL_ADD_RULE)) then
    HAlign := taCenter
  else
    HAlign:= taLeftJustify;
end;

{$ifdef COMPILER_22_UP}
procedure TReconciliationGUI.grdWithdrawalsGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TAsgVAlignment);
{$else}
procedure TReconciliationGUI.grdWithdrawalsGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
{$endif}
begin
  inherited;
  if ((ACol = COL_AMOUNT_FMT) or (ACol = COL_STATEMENT_AMOUNT) or (ACol = COL_STATEMENT_AMOUNT_FMT)) then
    HAlign:= taRightJustify
  else if ((ACol = COL_OK) or (ACol = COL_BANK_OK) or (ACol = COL_SELECT) or (ACol = COL_ADD_RULE)) then
    HAlign := taCenter
  else
    HAlign:= taLeftJustify;
end;

procedure TReconciliationGUI.CommitTransaction;
begin
  Reconciliationobj.connection.CommitTransaction;
end;

procedure TReconciliationGUI.ReportInvalidReconToERP(const Value:String);
var
  x:string;
begin
  ProgressDialog.DoShowProgressbar(2 , 'Reconciliation is Invalid, Please Wait While Sending Report to ERP.' + chr(13) +chr(13) +'Please Contact ERP for Details' );
  try
    CommitFailed := True;
    ProgressDialog.DoStepProgressbar;
    x:= SendEmailtoErp( 'Invalid Reconciliation Posting',
                '    Company     :' +appenv.CompanyInfo.Companyname          +chr(13) +
                '    Server      :' +GetSharedMyDacConnection.Server  +chr(13) +
                '    Datase      :' +GetSharedMyDacConnection.Database+chr(13) +
                '    Version     :' +TABLE_VERSION+chr(13) +
                '    ID          :' + IntToStr(qryReconsReconciliationID.asInteger) +chr(13)+
                '    Description :' +Value +chr(13) +
                '    Failed From :' +str,
                'sendemail');
   if x<> '' then begin
      CommonLib.MessageDlgXP_Vista('Sending Report to ERP Failed.  Error Log :' + x+'.  Please Contact ERP with Details' , mtwarning, [mbok] , 0);
   end;
  finally
      ProgressDialog.doHideProgressbar;
  end;

end;

procedure TReconciliationGUI.RollbackTransaction;
begin
  Reconciliationobj.connection.RollbackTransaction;
end;

function TReconciliationGUI.RowForId(aGrid: TAdvStringGrid; const aPayId,
  aPayLineID: integer): integer;
var
  x: integer;
begin
  result := -1;
  for x := 1 to aGrid.RowCount -1 do begin
    if (StrToIntDef(aGrid.Cells[COL_PAY_ID, x],0) = aPayId) and (StrToIntDef(aGrid.Cells[COL_PAY_LineID, x],0) = aPayLineId) then begin
      result := x;
      exit;
    end;
  end;
end;

procedure TReconciliationGUI.qryReconsBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ReportInvalidReconToERP('deleting header'+chr(13) + 'Header.count ='+IntToStr(Reconciliationobj.Count) +
                              '   Deposit Lines.count ='+IntToStr(Reconciliationobj.depositlines.count) +
                              '   withdrawal Lines.count ='+IntToStr(Reconciliationobj.Withdrawallines.Count));
end;





procedure TReconciliationGUI.ReadguiPref;
var
  ctr:Integer;
  ctrmax: Integer;
begin
  ActivateGuiPrefs(True);
  FDontAskAgain := StrToBoolean(GuiPrefs.Node['Options.YodleeDontAskAgain'].AsString);
  if GuiPrefs.Node['Options.Deposit.SubTotalWidth'].asInteger    <> 0 then begin pnlgrdDepositsSum.Width     := GuiPrefs.Node['Options.Deposit.SubTotalWidth'].asInteger   ;end;
  if GuiPrefs.Node['Options.WithDrawal.SubTotalWidth'].asInteger <> 0 then begin pnlgrdWithdrawalsSum.Width  := GuiPrefs.Node['Options.WithDrawal.SubTotalWidth'].asInteger;end;
  if StrToBoolean(GuiPrefs.Node['Options.Maximised'].AsString)  then WindowState := wsMaximized;
  //defaults
  Settings.State[0]           := TCheckBoxState.cbChecked;
  Settings.State[1]           := TCheckBoxState.cbUnChecked;
  Settings.State[2]           := TCheckBoxState.cbUnChecked;
  Settings.State[3]           := TCheckBoxState.cbChecked;

  if GuiPrefs.Node['Options.Settings.Amount'].AsBoolean then Settings.State[0]   := cbChecked else Settings.State[0]   := cbUnChecked;
  if GuiPrefs.Node['Options.Settings.Customer'].AsBoolean then Settings.State[1] := cbChecked else Settings.State[1]   := cbUnChecked;
  if GuiPrefs.Node['Options.Settings.Ref'].AsBoolean then Settings.State[2]      := cbChecked else Settings.State[2]   := cbUnChecked;
  if GuiPrefs.Node['Options.Settings.Date'].AsBoolean then Settings.State[3]     := cbChecked else Settings.State[3]   := cbUnChecked;
  if UseStatements then ctrMax := 11 else ctrMax := 6;
  for ctr:= 1 to ctrMax do begin
    if GuiPrefs.Node['Options.Deposit.MainGrid.colwidth'    + trim(inttostr(ctr))].AsInteger > 0 then begin
      SetGridcolwidth(grdDeposits, ctr-1,GuiPrefs.Node['Options.Deposit.MainGrid.colwidth'    + trim(inttostr(ctr))].AsInteger);
    end ;
    if GuiPrefs.Node['Options.WithDrawal.MainGrid.colwidth' + trim(inttostr(ctr))].AsInteger > 0 then begin
      SetGridcolwidth(grdWithdrawals, ctr-1,GuiPrefs.Node['Options.WithDrawal.MainGrid.colwidth'    + trim(inttostr(ctr))].AsInteger);
    end ;
  end;

  for ctr:= 1 to 2 do begin
    if GuiPrefs.Node['Options.Deposit.SubTotalGrid.colwidth'    + trim(inttostr(ctr))].AsInteger > 0 then begin
      SetGridcolwidth(grdDepositssum, ctr-1,GuiPrefs.Node['Options.Deposit.SubTotalGrid.colwidth'    + trim(inttostr(ctr))].AsInteger);
    end ;
    if GuiPrefs.Node['Options.WithDrawal.SubTotalGrid.colwidth' + trim(inttostr(ctr))].AsInteger > 0 then begin
      SetGridcolwidth(grdWithdrawalssum, ctr-1,GuiPrefs.Node['Options.WithDrawal.SubTotalGrid.colwidth'    + trim(inttostr(ctr))].AsInteger);
    end ;
  end;
end;
procedure TReconciliationGUI.WriteGuiPrefs;
var
  ctr:Integer;
  ctrmax: Integer;
begin
  GuiPrefs.Node['Options.YodleeDontAskAgain'].AsString        := BooleanToStr(FDontAskAgain);
  GuiPrefs.Node['Options.Maximised'].AsString                 := BooleanToStr(WindowState=wsMaximized );
  GuiPrefs.Node['Options.Deposit.SubTotalWidth'].AsInteger    := pnlgrdDepositsSum.Width ;
  GuiPrefs.Node['Options.WithDrawal.SubTotalWidth'].AsInteger := pnlgrdWithdrawalsSum.Width ;


  GuiPrefs.Node['Options.Settings.Amount'].AsBoolean          := (Settings.State[0] = cbChecked);
  GuiPrefs.Node['Options.Settings.Customer'].AsBoolean        := (Settings.State[1] = cbChecked);
  GuiPrefs.Node['Options.Settings.Ref'].AsBoolean             := (Settings.State[2] = cbChecked);
  GuiPrefs.Node['Options.Settings.Date'].AsBoolean            := (Settings.State[3] = cbChecked);
  if UseStatements then ctrMax := 11 else ctrMax := 6;
  for ctr:= 1 to ctrmax do begin
    GuiPrefs.Node['Options.Deposit.MainGrid.colwidth'    + trim(inttostr(ctr))].AsInteger := grdDeposits.ColWidths[ctr-1];
    GuiPrefs.Node['Options.WithDrawal.MainGrid.colwidth' + trim(inttostr(ctr))].AsInteger :=  grdWithdrawals.ColWidths[ctr-1];
  end;
  for ctr:= 1 to 2 do begin
    GuiPrefs.Node['Options.Deposit.SubTotalGrid.colwidth'    + trim(inttostr(ctr))].AsInteger := grdDepositssum.ColWidths[ctr-1];
    GuiPrefs.Node['Options.WithDrawal.SubTotalGrid.colwidth' + trim(inttostr(ctr))].AsInteger := grdWithdrawalssum.ColWidths[ctr-1];
  end;
end;

procedure TReconciliationGUI.wsClientException(Connection: TsgcWSConnection;
  E: Exception);
begin
  inherited;
  showmessage(E.Message);
  raise Exception.Create('Yodlee Error');
end;

procedure TReconciliationGUI.wsClientMessage(Connection: TsgcWSConnection;
  const Text: string);
var
  JSONResp: TJSONObject;
begin
  inherited;
  JSONResp := JO(Text);
  if JSONResp.B['Error'] then gYodleeText := 'Error : ' + JSONResp.S['ErrorMessage'] else
                              gYodleeText := JSONResp.S['ErrorMessage'];
end;

{ TStatementRecList }

procedure TStatementRecList.Add(aType: TStatementRecType; aPayID, aPayLineID,
  aStatementLineID: integer; aDesc: string; aAmount: double; aDate: TDateTime);
var
  rec: TStatementRec;
begin
  rec := TStatementRec.Create;
  rec.StatementRecType := aType;
  rec.PayID := aPayID;
  rec.PayLineID := aPayLineID;
  rec.StatementLineID := aStatementLineID;
  rec.StatementDescription := aDesc;
  rec.StatementAmount := aAmount;
  rec.TransactionDate := aDate;
  fList.Add(rec);
end;

procedure TStatementRecList.Clear;
begin
  fList.Clear;
end;

constructor TStatementRecList.Create;
begin
  fList := TObjectList.Create;
end;

destructor TStatementRecList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TStatementRecList.GetCount: integer;
begin
  result := fList.Count;
end;

function TStatementRecList.GetItem(const idx: integer): TStatementRec;
begin
  result := TStatementRec(fList[idx]);
end;

function TStatementRecList.ItemByID(const aType: TStatementRecType; const aPayID,
  aPayLineID: integer): TStatementRec;
var
  x: integer;
begin
  result := nil;
  for x := 0 to Count -1 do begin
    if (Item[x].StatementRecType = aType) and (Item[x].PayID = aPayID) and (Item[x].PayLineID = aPayLineID) then begin
      result := Item[x];
      exit;
    end;
  end;
end;

function TStatementRecList.ItemByID(const aType: TStatementRecType;
  const aStatementLineID: integer): TStatementRec;
var
  x: integer;
begin
  result := nil;
  for x := 0 to Count -1 do begin
    if (Item[x].StatementRecType = aType) and (Item[x].StatementLineID = aStatementLineID) then begin
      result := Item[x];
      exit;
    end;
  end;
end;

procedure TReconciliationGUI.NewBusObjinstance;
begin
  ReconciliationObj := TReconciliation.CreateWithNewConn(Self);
  ReconciliationObj.Connection.connection := Self.MyConnection;
  ReconciliationObj.BusObjEvent := DoBusinessObjectEvent;
end;

Function TReconciliationGUI.SaveRecord :Boolean;
begin
  result:= False;
  ReconciliationObj.PostDB;
  if not(ReconciliationObj.Save) then exit;
  Result:= True;
end;

procedure TReconciliationGUI.Openrec;
begin
  ReconciliationObj.Load(KeyID);
  ReconciliationObj.connection.BeginTransaction;
  if ReconciliationObj.count = 0 then
    ReconciliationObj.New;
  ReconciliationObj.Dirty := False;
  if keyid <> 0 then begin
    ReconciliationObj.Withdrawallines;
    ReconciliationObj.DepositLines;
    //ReconciliationObj.TestDelete;
  end;
end;

procedure TReconciliationGUI.DNMSpeedButton6Click(Sender: TObject);begin  SearchText(COL_REF, '1679564 / 2679564', grdWithdrawals);end;
procedure TReconciliationGUI.DNMSpeedButton7Click(Sender: TObject);begin  SearchText(COL_REF, '2892550', grdWithdrawals);end;
procedure TReconciliationGUI.DNMSpeedButton8Click(Sender: TObject);begin  SearchText(COL_REF, '2582779 / 1582778', grdWithdrawals);end;
procedure TReconciliationGUI.DNMSpeedButton10Click(Sender: TObject);begin  SearchText(COL_REF, '1766069 / 2766069', grdDeposits);end;
procedure TReconciliationGUI.DNMSpeedButton11Click(Sender: TObject);begin  SearchText(COL_REF, '1449181_Xfer to Anz Bus', grdDeposits);end;
procedure TReconciliationGUI.DNMSpeedButton12Click(Sender: TObject);begin  SearchText(COL_REF, '2798515 / 1798514', grdDeposits);end;
procedure TReconciliationGUI.DNMSpeedButton13Click(Sender: TObject);begin  SearchText(COL_REF, '1136851', grdDeposits);end;

function TReconciliationGUI.AmountFromGrig(grd :TAdvStringGrid ;arow:Integer):Double;
begin
  result := StrCurrToDouble(grd.Cells[COL_AMOUNT, aRow]);
end;

Function TReconciliationGUI.PostDepositRecToDB(ARow:Integer;bFinished:Boolean):Boolean;
var
  ThisState: Boolean;
begin
  With Reconciliationobj.DepositLines do begin
    logtext('PostDepositRecToDB.before :' + inttostr(Count));
    try
      with grdDeposits do begin
        if Cells[COL_OK, ARow] = CheckTrue then begin
          Connection.BeginNestedTransaction;
          try
              if not(Locate('Notes;PaymentId;DepositLineID' , varArrayof([Cells[COL_NOTES, ARow],Cells[COL_PAY_ID, ARow],Cells[COL_PAY_LineID, ARow]]), [])) then begin
                New;
                PaymentId     := StrToIntDef(Cells[COL_PAY_ID, ARow],0);
                DepositLineID := StrToIntDef(Cells[COL_PAY_LineID, ARow],0);
                ClientID      := Trunc(StrValue(Cells[COL_CLIENT_ID, ARow]));
                Reference     := Cells[COL_REF, ARow];
                DepositDate   := StrToDate(Cells[COL_DATE, ARow]);
                AccountId     := Reconciliationobj.AccountID;
                //Amount        := RoundCurrency(StrToCurr(Cells[COL_AMOUNT, ARow]));
                Amount        := RoundCurrency(AmountFromGrig(grdDeposits, ARow));
                Notes         := Cells[COL_NOTES, ARow];
                Payee         := Cells[COL_PAYEE, ARow];
                Postdb;
                REsult        :=  True;
              end;

              if UseStatements then begin
                 LinkedBSLIds   := GetLinkedStatements(grdDeposits, Cells[COL_RECON_ID, ARow]);
                 UpdateBSL;
              end;

              Deposited     := bFinished;
              Reconciled    := bFinished;
              //Postdb;
              getCheckBoxState(COL_ADD_RULE, ARow, ThisState);
              if ((UseStatements) and (ThisState)) then
                 InsertRule(Cells[COL_STATEMENT_DESC, ARow], Cells[COL_PAYEE, ARow]) ;
              if Locktrans then Connection.CommitNestedTransaction
              else Connection.RollbackNestedTransaction;

          Except
            on E:Exception do begin
              Connection.RollbackNestedTransaction;
            end;
          end;
        end else begin
          DeleterecLine(grdDeposits, ARow, Reconciliationobj.DepositLines);
          Result := True;
        end;
      end;
    finally
      logtext('PostDepositRecToDB.After:' + inttostr(Count));
    end;
  end;
end;
(*
Procedure TReconciliationGUI.DeleterecLine(Grd: TAdvStringGrid;ARow:Integer;recline:TReconciliationLineBase);
begin
                  if (recline.Locate('Notes;PaymentId;DepositLineID' ,
                  varArrayof([grd.Cells[COL_NOTES, ARow],grd.Cells[COL_PAY_ID, ARow],grd.Cells[COL_PAY_LineID, ARow]]), [])) then begin
                    try
                      recline.delete;
                      ReconciliationObj.CalcTotals;
                      DisplayBalances(true);
                    except
                      on E:Exception do begin
                        logtext(E.Message);
                        //recline.ExecuteSQL('Delete from ' + recline.BusObjectTableName +' where ' + recline.IDFieldName +' = '+ inttostr(recline.ID), true);
                      end;
                    end;
                  end;

end;  *)
function TReconciliationGUI.GetLinkedStatements(AGrid: TAdvStringGrid; AReconId: string) : string;
var
  i     : Integer;
begin
  Result := '-1';
  for i := 0 to AGrid.Rowcount -1 do begin
//    if ((AGrid.Cells[COL_RECON_ID, i] = AReconId) or (AGrid.Cells[COL_RECON_ID, i] = AGrid.Cells[COL_BSL_ID, i])) then
    if AGrid.Cells[COL_RECON_ID, i] = AReconId then
       Result := Result + ',' + AGrid.Cells[COL_BSL_ID, i] ;
  end;
end;

Function TReconciliationGUI.PostWithdrawalRecToDB(ARow:Integer; bFinished: boolean):Boolean;
var
  ThisState: Boolean;
begin
  With Reconciliationobj.WithdrawalLines do begin
    logtext('PostWithdrawalRecToDB.before :' + inttostr(Count));
    try
    with grdWithdrawals do begin
      if Cells[COL_OK, ARow] = CheckTrue then begin
        Connection.BeginNestedTransaction;
        try
          if not(Locate('Notes;PaymentId;DepositLineID' , varArrayof([Cells[COL_NOTES, ARow],Cells[COL_PAY_ID, ARow],Cells[COL_PAY_LineID, ARow]]), [])) then begin
            New;
            ReconciliationId  := ReconciliationObj.ID;
            PaymentId         := StrToIntDef(Cells[COL_PAY_ID, ARow],0);
            DepositLineID     := StrToIntDef(Cells[COL_PAY_LineID, ARow],0);
            ClientID          := Trunc(StrValue(Cells[COL_CLIENT_ID, ARow]));
            Reference         := Cells[COL_REF, ARow];
            DepositDate       := StrToDate(Cells[COL_DATE, ARow]);
            AccountId         := Reconciliationobj.AccountID;
            //Amount            := RoundCurrency(StrToCurr(Cells[COL_AMOUNT, ARow]));
            Amount            := RoundCurrency(AmountFromGrig(grdWithdrawals, ARow));
            Notes             := Cells[COL_NOTES, ARow];
            Payee             := Cells[COL_PAYEE, ARow];
            Postdb;
            REsult := True;
          end;
          if UseStatements then begin
             LinkedBSLIds   := GetLinkedStatements(grdWithdrawals, Cells[COL_RECON_ID, ARow]);
             UpdateBSL;
          end;

          Deposited         := bFinished;
          Reconciled        := bFinished;
          getCheckBoxState(COL_ADD_RULE, ARow, ThisState);
          if ((UseStatements) and (ThisState)) then
            InsertRule(Cells[COL_STATEMENT_DESC, ARow], Cells[COL_PAYEE, ARow]) ;

          if Locktrans then Connection.CommitNestedTransaction
          else Connection.RollbackNestedTransaction;
        Except
          on E:Exception do begin
            Connection.RollbackNestedTransaction;
          end;
        end;
      end else begin
        DeleterecLine(grdWithdrawals, ARow, Reconciliationobj.WithdrawalLines);
        REsult := true;
      end;
    end;
    finally
      logtext('PostWithdrawalRecToDB.After :' + inttostr(Count));
    end;
  end;
end;

function TReconciliationGUI.ConvertStatementDesc(AInputStatementDesc: string): string;
var
  iPos : integer;
begin
  Result := Trim(StringReplace(AInputStatementDesc, 'DEPOSIT', '', [rfIgnoreCase]));
  Result := Trim(StringReplace(Result, 'WITHDRAWAL', '', [rfIgnoreCase]));
  iPos := Pos('XXX',Result);
  if iPos > 0 then Result  := Copy(Result, iPos, Length(Result) - iPos);
end;

end.


