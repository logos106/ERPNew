unit frmJournalEntry;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 01/09/05  1.00.01 DSP  Set KeyID to zero in the BtnNewClick function to clear
                        any current entries.
 12/09/05  1.00.02 ISB  Moved NewRecordAmount Due To Firing Without TaxCode
 30/09/05  1.00.03 IJB  Modified to use new procedure
                        (PaymentsLibGUI.ShowReconciledListForm) to replace
                        procedure removed from TransLockManagementObj.
 19/10/05  1.00.04 DLS  Added RegisterClass
 28/10/05  1.00.05 MV   Added EmployeeName field to generaljournaldetails.
 06/06/06  1.00.06 IJB  There was a problem with Lock Wait Timeouts as the
                        Client table was being edited by UndoAccountBalances
                        when an existing Journal was opened, added the
                        BalancePostList object to Save all balance posts to
                        whwn form is saved, also enabled UserLock for Journal.
 09/01/06  1.00.07  AL  Added SearchEngineObj usage to AccountCombo
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,   StdCtrls,
  Buttons, DNMSpeedButton, wwdbdatetimepicker, ExtCtrls, DNMPanel, wwclearbuttongroup,
  wwradiogroup, Mask, DBCtrls, Wwdbigrd, Grids, Wwdbgrid, wwdblook,
  SelectionDialog, ActnList, Menus, AdvMenus, MyAccess,ERPdbComponents, MemDS, DBAccess,
  DataState, MessageConst, BusObjGeneral, Shader,
  BusObjBase, dmGUIStylers, BusobjJournal, ImgList, ERPDbLookupCombo,
  ProgressDialog, wwcheckbox, wwdbedit;

type
  TJournalEntryGUI = class(TBaseInputGUI)
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    cboDate: TwwDBDateTimePicker;
    Label1: TLabel;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    TransNo: TDBEdit;
    Label2: TLabel;
    grpTaxSelect: TwwRadioGroup;
    btnPrint: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    BtnNew: TDNMSpeedButton;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    tblMasterGlobalRef: TWideStringField;
    tblMasterGJID: TAutoIncField;
    tblMasterTransactionDate: TDateField;
    tblMasterTransactionNo: TWideStringField;
    tblMasterAmount: TFloatField;
    tblMasterTaxSelect: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsGJDID: TAutoIncField;
    tblDetailsGJID: TIntegerField;
    tblDetailsAccountName: TWideStringField;
    tblDetailsAccountID: TIntegerField;
    tblDetailsDebitAmount: TFloatField;
    tblDetailsCreditAmount: TFloatField;
    tblDetailsTaxCode: TWideStringField;
    tblDetailsTaxCodeID: TIntegerField;
    tblDetailsTaxRate: TFloatField;
    tblDetailsTaxAmount: TFloatField;
    tblDetailsClientName: TWideStringField;
    tblDetailsClientID: TIntegerField;
    tblDetailsClassName: TWideStringField;
    tblDetailsClassID: TIntegerField;
    tblDetailsReconciled: TWideStringField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsDebitAmountInc: TFloatField;
    tblDetailsCreditAmountInc: TFloatField;
    tblDetailsAccountNumber: TWideStringField;
    tblDetailsMemo: TWideStringField;
    tblDetailsEmployeeName: TWideStringField;
    tblDetailsDeleted: TWideStringField;

    lbMemTrans: TLabel;
    lsTDNMSpeedButtonActions: TActionList;
    actMemTrans: TAction;
    actMemTransAuto: TAction;
    cboAccountLinesQry: TERPQuery;
    cboTaxCodeQry: TERPQuery;
    cboClassQry: TERPQuery;
    cboClientLookup: TERPQuery;
    btnReconciled: TDNMSpeedButton;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    cboTaxCode: TERPDBLookupCombo;
    cboClass: TwwDBLookupCombo;
    cboCustomerJob: TwwDBLookupCombo;
    cboAccountline: TERPDbLookupCombo;
    cboAccountlNoLine: TERPDbLookupCombo;

    qryEmployeeLookup: TERPQuery;
    cboEmployeeLookup: TwwDBLookupCombo;
    qryEmployeeLookupEmployeeName: TWideStringField;
    cboAccountLinesQryAccountID: TIntegerField;
    cboAccountLinesQryAccountName: TWideStringField;
    cboAccountLinesQryAccountGroup: TWideStringField;
    cboAccountLinesQryAccountNumber: TWideStringField;
    cboAccountLinesQryType: TWideStringField;
    cboAccountLinesQryDescription: TWideStringField;
    cboAccountLinesQryTaxcode: TWideStringField;
    cboAccountLinesQryActive: TWideStringField;
    cboAccountLinesQryAccountTree: TWideStringField;
    cboAccountLinesQryFullAccountName: TWideStringField;
    tblMastermsTimeStamp: TDateTimeField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;

    popMemTrans: TAdvPopupMenu;
    MemorizeTransaction1: TMenuItem;
    MemorizeAutoTransaction1: TMenuItem;
    cboAccountNoLinesQry: TERPQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    IntegerField1: TIntegerField;
    WideStringField5: TWideStringField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    mnuAuditTrail: TMenuItem;
    tblDetailsEmployeeId: TIntegerField;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsAreaCode: TWideStringField;
    tblMastermsUpdateSiteCode: TWideStringField;
    tblDetailsmsUpdateSiteCode: TWideStringField;
    QryAreaCodeLk: TERPQuery;
    QryAreaCodeLkAreaCode: TWideStringField;
    QryAreaCodeLkAreaName: TWideStringField;
    cboLinesAreaCode: TwwDBLookupCombo;
    lblMsg: TLabel;
    chkApproved: TwwCheckBox;
    tblMasterApproved: TWideStringField;
    mnuCopyToClipboard: TMenuItem;
    mnuPasteFromClipboard: TMenuItem;
    tblMasterMemo: TWideStringField;
    edtMemo: TwwDBEdit;
    Label3: TLabel;
    tblDetailsLinesOrder: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actMemTransUpdate(Sender: TObject);
    procedure actMemTransExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont;
      ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure btnReconciledClick(Sender: TObject);
    procedure cboTaxCodeQryBeforeOpen(DataSet: TDataSet);
    procedure tblDetailsAccountNameChange(Sender: TField);
    procedure tblDetailsAccountNumberChange(Sender: TField);
    procedure mnuAuditTrailClick(Sender: TObject);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure mnuCopyToClipboardClick(Sender: TObject);
    procedure mnuPasteFromClipboardClick(Sender: TObject);
    procedure chkApprovedClick(Sender: TObject);

  private
    { Private declarations }
    fbCalculatingTotals: boolean;
    fbChangesMade: boolean;
    CreditEx: boolean;
    DebitEx: boolean;
    BalancePostList: TPostList;
    fLastLineId: integer;
    fInFormShow: boolean;
    fsAccountname:String;
    procedure PrintJE(const DoPrint: boolean);
    procedure DoAccountChange(Sender: TField);
    Procedure TransAuditTrialbeforeShow(Sender:TObject);
    procedure ImportFromClipBoard;
    procedure CopyToClipBoard;
    procedure ChangeToDefaultOrder(Sender: TObject);
    property InFormShow : boolean read fInFormShow write fInFormShow;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure RefreshTotals;
    procedure KeyIdChanged(const NewKeyId: integer); override;


  public
    { Public declarations }
    fbFormClosing: boolean;
    JournalEntryObj :TJournalEntry;
    Procedure locatelinefor(aAccountname:String);
  end;

implementation

uses
   DNMExceptions, FormFactory,
  Math, ChartOfAccountsListForm, frmChartOfAccountsFrm,
  CommonDbLib, frmRepeat,  PaymentsLibGUI, CommonLib,  AppEnvironment,
  FastFuncs, BaseFormForm, BusObjConst, tcConst, DNMLib, CommonFormLib,
  TransAuditTrail, ClipBrd, Types, StringUtils, clipboardLib, BusObjApprovals;

const
  TAX_PAID      = 'Tax Paid';
  TAX_Collected = 'Tax Collected';

{$R *.dfm}

{ TJournalEntryGUI }

procedure TJournalEntryGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fbFormClosing := true;
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TJournalEntryGUI.btnCloseClick(Sender: TObject);
var 
  iExitResult: integer;
begin
  DisableForm;
  try
    inherited;
    if fbChangesMade then begin
      iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);
      case iExitResult of
        mrYes: btnCompleted.Click;
        mrNo:
          begin;
            RollbackTransaction;
            Close;
          end;
        mrCancel: Exit;
      end;
    end else begin
      Close;
    end;
  finally
    EnableForm;
  end;
end;
procedure TJournalEntryGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is Tjournalentry then Tjournalentry(Sender).Dataset                 := tblMaster
        else if Sender is TJournalEntryLines then TJournalEntryLines(Sender).Dataset  := tblDetails;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_TotalsChanged) then begin
      RefreshTotals;
      if InFormShow  then
        exit;
{ --> }
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_LineDeleted) then begin
      TimerMsg(lblMsg , 'Line Automatically deleted as it was empty');
    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_Approved) then begin

    end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEvent_AccountName) then begin
      if (JournalEntryObj.Lines.accountId <> 0) and (JournalEntryObj.Lines.Debitamount = 0)
              and (JournalEntryObj.Lines.creditamount = 0)  and  (JournalEntryObj.Lines.taxamount = 0) then begin
          if JournalEntryObj.TotDebitAmountInc > JournalEntryObj.TotCreditAmountInc then begin
            JournalEntryObj.Lines.CreditAmountInc:= JournalEntryObj.TotDebitAmountInc - JournalEntryObj.TotCreditAmountInc;
            JournalEntryObj.Lines.OnCreditAmtIncChange;
            if JournalEntryObj.Lines.CreditAmountInc >0 then
              TimerMsg(lblMsg , 'Credit amount is automatically calculated as ' + floatTostrf(JournalEntryObj.Lines.CreditAmountInc , ffCurrency , 15,2));
      end else if JournalEntryObj.TotCreditAmountInc > JournalEntryObj.TotDebitAmountInc then begin
            JournalEntryObj.Lines.DebitAmountInc:= JournalEntryObj.TotCreditAmountInc - JournalEntryObj.TotDebitAmountInc;
            JournalEntryObj.Lines.OnDebitAmtIncChange;
            if JournalEntryObj.Lines.DebitAmountInc >0 then
              TimerMsg(lblMsg , 'Debit amount is automatically calculated as ' + floatTostrf(JournalEntryObj.Lines.DebitAmountInc , ffCurrency , 15,2));
          end;
      end;
    end;
end;

procedure TJournalEntryGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    fbAllowNotInList := true;
    InFormShow := true;

    try
      inherited;
      GuiPrefs.active := TRue;
      JournalEntryObj.Load(KeyId);
      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      OpenQueries(QueryNamesNotToOpen);

      JournalEntryObj.Connection.BeginTransaction;
      JournalEntryObj.Lines.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');
      JournalEntryObj.Lines.Dataset.Filtered:= true;

      if KeyID <> 0 then begin
        RefreshTotals;
        btnReconciled.Visible :=False;
        btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');

        if not JournalEntryObj.Lock then begin
          Self.caption :=  self.Caption + '     {' + JournalEntryObj.LockMsg +'}';
          Accesslevel  := 5;
          If Sysutils.SameText(JournalEntryObj.LockMsg,LockMsgReconcileHold) Or
              Sysutils.SameText(JournalEntryObj.LockMsg,LockMsgReconciled) then
              btnReconciled.Visible := True;
        end;

      end else begin
        JournalEntryObj.New;
        JournalEntryObj.PostDB;
        JournalEntryObj.Lines.New;
      end;

      if not AppEnv.CompanyPrefs.ShowAccountNumbers then grdTransactions.RemoveField('AccountNumber');

      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsGlobalRef.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsGJDID.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsGJID.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsAccountID.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsTaxCodeID.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsTaxRate.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsClientID.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsClassID.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsReconciled.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsEditedFlag.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsDeleted.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsEmployeeId.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsmstimestamp.FieldName);
      guiprefs.DbGridElement[grdTransactions].RemoveField(tblDetailsmsupdatesitecode.FieldName);
      grdTransactions.ColumnByName('ClassName').DisplayLabel := AppEnv.DefaultClass.ClassHeading;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    InFormShow := false;
    EnableForm;
  end;
end;

procedure TJournalEntryGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if AppEnv.CompanyPrefs.OneSidedJournal then JournalEntryObj.IsOneSide := True;
    if JournalEntryObj.Save then begin
        JournalEntryObj.connection.CommitTransaction;
        Notify;
        Close;
    end
    else begin
      EnableForm;
      if (JournalEntryObj.ResultStatus.GetFirstFatalStatusItem <> nil) then begin
        if JournalEntryObj.ResultStatus.GetLastFatalStatusItem.Code = BOR_Journal_ClientBlank then begin
          SetControlFocus(grdTransactions);
          grdTransactions.SetActiveField('ClientName');
        end;
      end;
      JournalEntryObj.ResultStatus.Clear;
    end;
  finally
    EnableForm;
  end;
end;

procedure TJournalEntryGUI.cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista('Customer''s Name Not in List !', mtWarning, [mbOK], 0);
  cboCustomerJob.LookupValue := '';
  SetControlFocus(cboCustomerJob);
end;

procedure TJournalEntryGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
    if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
        JournalEntryObj.Lines.Deleted := True;
        JournalEntryObj.Lines.PostDB;
    End;
End;
procedure TJournalEntryGUI.btnPreviewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PrintJE(false);
  finally
    EnableForm;
  end;  
end;

procedure TJournalEntryGUI.BtnNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if AppEnv.CompanyPrefs.OneSidedJournal then JournalEntryObj.IsOneSide := True;
    if JournalEntryObj.Save then begin
        JournalEntryObj.connection.CommitTransaction;
        Notify;
        JournalEntryObj.connection.BeginTransaction;
        JournalEntryObj.New;
        JournalEntryObj.PostDb;
        SetControlFocus(cboDate);
        fbChangesMade := false;
    end
    else
      JournalEntryObj.ResultStatus.Clear;
  finally
    EnableForm;
  end;  
end;


procedure TJournalEntryGUI.btnPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PrintJE(true);
  finally
    EnableForm;
  end;  
end;

procedure TJournalEntryGUI.PrintJE(const DoPrint: boolean);
var
    sSQL: string;
begin
    if AppEnv.CompanyPrefs.OneSidedJournal then JournalEntryObj.IsOneSide := True;
    if JournalEntryObj.Save then begin
        JournalEntryObj.connection.CommitTransaction;
        try
          Notify;
          sSQL := ' WHERE tblgeneraljournal.GJID = ' + IntToStr(JournalentryObj.ID);
          PrintTemplateReport('Journal Entry', sSQL, DoPrint, 1);
        finally
          JournalEntryObj.connection.BeginTransaction;
        end;
    end;
    JournalEntryObj.ResultStatus.Clear;

end;

procedure TJournalEntryGUI.FormCreate(Sender: TObject);
begin
  NamenPrintNameGridObj.AccountLookupQueryWithSearchengine(0, cboAccountlNoLine);
  NamenPrintNameGridObj.AccountLookupQueryWithSearchengine(0, cboAccountline);
  NamenPrintNameGridObj.TaxcodeLookupQueryWithSearchengine(0, cboTaxCode);

  fsAccountname:= '';
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
  UserLock.Enabled := true;
  CreditEx := true;
  DebitEx := true;
  fbFormClosing := false;
  fbChangesMade := false;
  fbCalculatingTotals := false;
  tblMaster.Connection := MyConnection;
  tblDetails.Connection := MyConnection;
  grdTransactions.LoadFromIniFile;
  BalancePostList:= TPostList.Create(self);
  BalancePostList.UserLock:= self.UserLock;
  BalancePostList.DBConnection:= self.MyConnection;

  GuiPrefs.AddFieldPair('Creditamount', 'CreditAmountInc', tblDetails);
  GuiPrefs.AddFieldPair('Debitamount', 'DebitAmountInc', tblDetails);

  JournalEntryObj := TJournalEntry.Create(Self);
  JournalEntryObj.connection := TMyDacDataconnection.Create(JournalEntryObj);
  JournalEntryObj.Connection.connection := Myconnection;
  JournalEntryObj.BusObjEvent := DoBusinessObjectEvent;

  cboTaxCode.SpcialLookupItemList.Clear;

  //chkApproved.Visible := AppEnv.CompanyPrefs.UseApprovalLevels;
  TransApprovalInit(chkApproved , ApprovalTypeJournalEntry, JournalEntryObj, 'TotDebitAmountInc',true , nil, nil, nil);
  NewMenuItem('Default Order',ChangeToDefaultOrder,False,grdTransactions.Popupmenu );
end;
procedure TJournalEntryGUI.ChangeToDefaultOrder(Sender: TObject);
begin
  inherited;
  tbldetails.IndexFieldNames:= 'LinesOrder ASC CIS;';
  if guiprefs <> nil then
    if guiprefs.Active then
      if guiprefs.DbGridElement[grdTransactions] <> nil then
        guiprefs.DbGridElement[grdTransactions].Node['IndexFieldNames'].asString := tbldetails.IndexFieldNames;
end;

procedure TJournalEntryGUI.RefreshTotals;
begin
  grdTransactions.ColumnByName('DebitAmount').FooterValue       := FloatToStrF(JournalEntryObj.TotDebitAmount       ,ffCurrency, 15, 5);
  grdTransactions.ColumnByName('CreditAmount').FooterValue      := FloatToStrF(JournalEntryObj.TotCreditAmount      ,ffCurrency, 15, 5);
  grdTransactions.ColumnByName('DebitAmountInc').FooterValue    := FloatToStrF(JournalEntryObj.TotDebitAmountInc    ,ffCurrency, 15, CurrencyRoundPlaces);
  grdTransactions.ColumnByName('CreditAmountInc').FooterValue   := FloatToStrF(JournalEntryObj.TotCreditAmountInc   ,ffCurrency, 15, CurrencyRoundPlaces);
  grdTransactions.ColumnByName('TaxAmount').FooterValue         := FloatToStrF(JournalEntryObj.TotTaxAmount         ,ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TJournalEntryGUI.actMemTransExecute(Sender: TObject);
begin
  if fbFormClosing then Exit;
  If Sysutils.SameText(JournalEntryObj.LockMsg,LockMsgReconcileHold) Or
    Sysutils.SameText(JournalEntryObj.LockMsg,LockMsgReconciled) then begin
    MessageDlgXP_Vista('This Journal has been reconciled so can not be memorised.',
        mtInformation, [mbOk], 0);
    exit;
  end;
  DoMemoriseTrans(JournalentryObj.ID ,   0 , sender = actMemTransAuto , TitleLabel.Caption);
  if qryMemTrans.RecordCount > 0 then self.JournalentryObj.Dirty:= true;
end;

procedure TJournalEntryGUI.actMemTransUpdate(Sender: TObject);
begin
  if fbFormClosing then Exit;
  if not tblDetails.Active then Exit;
  if not tblMaster.Active then Exit;
  actMemTrans.Enabled := (tblDetails.RecordCount > 0) and (tblMaster.State <> dsInsert);
  actMemTransAuto.Enabled := actMemTrans.Enabled;
end;



procedure TJournalEntryGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if not btnClose.Enabled then begin
    CommonLib.MessageDlgXP_Vista('You Cannot Cancel this Conversion. You must Click ''Save''', mtWarning, [mbOK], 0);
    CanClose := false;
    Exit;
  end;
end;

procedure TJournalEntryGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if (Key = vk_insert) and (Screen.activecontrol = grdTransactions) then begin
    JournalEntryObj.LineInserting := true;
  end;
  if (Key <> VK_RETURN) or (KEY <> VK_TAB) or (KEY <> VK_DOWN) or (Key <> VK_UP) or
    (Key <> VK_LEFT) or (Key <> VK_RIGHT) or (Key <> VK_HOME) or ((Key < VK_F1) and (Key > VK_F24)) then begin
    fbChangesMade := true;
  end;
  if key = VK_ESCAPE then Begin
    Key := 0;
    btnCloseClick(Sender);
  end else inherited;
end;

procedure TJournalEntryGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  if fbFormClosing then Exit;
  inherited;
  if AFieldName = 'CreditAmount' then begin
    SwapPairdField(tbldetails ,grdTransactions ,'CreditAmount' , 'CreditAmountInc');
    CancelGridSort := true;
    Self.RefreshTotals;
  end else if AFieldName = 'CreditAmountInc' then begin
    SwapPairdField(tbldetails ,grdTransactions ,'CreditAmountinc' , 'CreditAmount');
    CancelGridSort := true;
    Self.RefreshTotals;
  end else if AFieldName = 'DebitAmount' then begin
    SwapPairdField(tbldetails ,grdTransactions ,'DebitAmount' , 'DebitAmountInc');
    CancelGridSort := true;
    Self.RefreshTotals;
  end else if AFieldName = 'DebitAmountInc' then begin
    SwapPairdField(tbldetails ,grdTransactions ,'DebitAmountInc' , 'DebitAmount');
    CancelGridSort := true;
    Self.RefreshTotals;
  end;
end;

procedure TJournalEntryGUI.ImportFromClipBoard;
begin
  if AccessLevel > 2 then exit;
  ClipBoardtoQry(tbldetails);
(*var
  Buff: string;
  lines, line, header: TStringDynArray;
  x,y: integer;
  field: TField;
begin
  if AccessLevel > 2 then exit;
  Buff:= Clipboard.asText;
  if Buff = '' then Exit;
  lines := StringUtils.SplitString(Buff,#13#10);
  header := StringUtils.SplitString(lines[Low(lines)],#9);
  tblDetails.Last;
  for x := Low(Lines) +1 to High(lines) do begin
    line := nil;
    line := StringUtils.SplitString(lines[x],#9);
    if length(line) <= 1 then continue;

    tblDetails.Append;
    for y := Low(header) to High(header) do begin
      field := tblDetails.FindField(StripQuotes(header[y]));
      if Assigned(field) and (StripQuotes(line[y]) <> '') and (StripQuotes(line[y]) <> '0') then begin
        try
          EditDb(tblDetails);
          field.AsString := StripQuotes(line[y]);
        except
          on e: exception do begin
            CommonLib.MessageDlgXP_Vista('Error setting value: ' + e.Message, mtWarning, [mbOK], 0);
          end;
        end;
      end;
    end;
    PostDb(tblDetails);
  end;*)
end;

procedure TJournalEntryGUI.grdTransactionsCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if devmode then
    if JournalEntryObj.Lines.LineAmountsValid =False then ABrush.Color := GridColhighLightRed;

  if fsAccountname <> '' then
    if JournalEntryObj.Lines.Accountname = fsAccountname then ABrush.Color := GridColhighLightGreen;
end;

procedure TJournalEntryGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; AFieldName: string;
  AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  if fbFormClosing then Exit;
  inherited;
  if ((AFieldName = 'DebitAmount') or (AFieldName = 'DebitAmountInc') or (AFieldName = 'CreditAmount') or
    (AFieldName = 'CreditAmountInc')) then begin
    ABrush.Color := clBtnFace;
  end;
end;

procedure TJournalEntryGUI.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
       if sametext(TField(grdTransactions.GetActiveField).FieldName , tblDetailsCreditAmountInc.FieldName) then JournalEntryObj.Lines.OnCreditAmtIncChange
  else if sametext(TField(grdTransactions.GetActiveField).FieldName , tblDetailsDebitAmountInc.FieldName) then JournalEntryObj.Lines.OnDebitAmtIncChange;
end;

procedure TJournalEntryGUI.btnReconciledClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowReconciledListForm(JournalentryObj.ID, 'Journal Entry');
end;

procedure TJournalEntryGUI.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;
end;

procedure TJournalEntryGUI.locatelinefor(aAccountname: String);
begin
  SortGrid(tblDetailsAccountName.fieldname , grdTransactions);
  fsAccountname := aAccountname;
end;

procedure TJournalEntryGUI.mnuAuditTrailClick(Sender: TObject);
begin
  inherited;
  if JournalEntryObj.Id =0 then exit;
  CommonFormLib.OpenErpListform('TTransAuditTrailGUI' ,TransAuditTrialbeforeShow);
end;

procedure TJournalEntryGUI.mnuCopyToClipboardClick(Sender: TObject);
begin
  inherited;
  CopyToClipBoard;
end;

procedure TJournalEntryGUI.mnuPasteFromClipboardClick(Sender: TObject);
begin
  inherited;
  ImportFromClipBoard;
end;

procedure TJournalEntryGUI.cboTaxCodeQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboTaxCodeQry.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TJournalEntryGUI.chkApprovedClick(Sender: TObject);
begin
(*  if TwwCheckBox(Sender).Focused then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsBoolean := TwwCheckBox(Sender).Checked;*)
end;

procedure TJournalEntryGUI.CopyToClipBoard;
begin
  QryToClipBoard(tbldetails);
(*var
  Buff: String;
  bm: TBookmark;
  x: integer;
  s: string;

  function DateToString(aDate: TDateTime): string;
  begin
    result := '';
    if aDate = 0 then exit;
    result := DateToStr(aDate);
  end;

begin
  Buff := '';
  for x := 0 to tblDetails.Fields.Count -1 do begin
    if tblDetails.Fields[x].Visible then begin
      if Buff <> '' then Buff := Buff + #9;
      Buff := Buff + '"' + tblDetails.Fields[x].FieldName + '"';
    end;
  end;

  bm := tblDetails.GetBookmark;
  try
    tblDetails.DisableControls;
    try
      tblDetails.First;
      while not tblDetails.EOF do begin
        s := '';
        for x := 0 to tblDetails.Fields.Count -1 do begin
          if tblDetails.Fields[x].Visible then begin
            if s <> '' then s := s + #9;
            s := s + '"' + tblDetails.Fields[x].AsString + '"';
          end;
        end;
        Buff := Buff + #13#10 + s;
        tblDetails.Next;
      end;
      tblDetails.GotoBookmark(bm);
    finally
      tblDetails.EnableControls;
    end;
  finally
    tblDetails.FreeBookmark(bm);
  end;

  Clipboard.asText:= Buff;*)
end;

procedure TJournalEntryGUI.TransAuditTrialbeforeShow(Sender: TObject);
begin
  if not(Sender is TTransAuditTrailGUI) then exit;
  TTransAuditTrailGUI(Sender).DocName        := JournalEntryObj.classname;
  TTransAuditTrailGUI(Sender).DocId          := JournalEntryObj.ID;
  TTransAuditTrailGUI(Sender).TransGlobalref := JournalEntryObj.Globalref;
  TTransAuditTrailGUI(Sender).DocDescription := JournalEntryObj.XMLNodename;
  TTransAuditTrailGUI(Sender).Formname       := Self.Classname;
end;

procedure TJournalEntryGUI.tblDetailsAccountNameChange(Sender: TField);
begin
  inherited;
  DoAccountChange(Sender);
end;

procedure TJournalEntryGUI.tblDetailsAccountNumberChange(Sender: TField);
begin
  inherited;
  DoAccountChange(Sender);
end;

procedure TJournalEntryGUI.DoAccountChange(Sender: TField);
var
  SaveDoFieldChange: boolean;
begin
  if fLastLineId <> self.tblDetailsGJDID.AsInteger then begin
    fLastLineId := self.tblDetailsGJDID.AsInteger;
    if (Sender.DataSet.RecordCount > 1) and (Sender.DataSet.RecNo = Sender.DataSet.RecordCount) then begin
      SaveDoFieldChange:= JournalEntryObj.Lines.DoFieldChange;
      JournalEntryObj.Lines.DoFieldChange:= true;
      try
        EditDb(tblDetails);
        tblDetailsCreditAmount.AsFloat:= 0;
        EditDb(tblDetails);
        tblDetailsDebitAmount.AsFloat:= 0;
        { first time we have selected account for last line ... set amount }
        if self.tblDetailsTaxRate.AsFloat > 0 then begin
          { account with tax ... }
          if JournalEntryObj.TotDebitAmountInc > JournalEntryObj.TotCreditAmountInc then begin
            EditDb(tblDetails);
            tblDetailsCreditAmountInc.AsFloat:=
              (JournalEntryObj.TotDebitAmountInc - JournalEntryObj.TotCreditAmountInc);
          end
          else if JournalEntryObj.TotDebitAmountInc < JournalEntryObj.TotCreditAmountInc then begin
            EditDb(tblDetails);
            tblDetailsDebitAmountInc.AsFloat:=
              (JournalEntryObj.TotCreditAmountInc - JournalEntryObj.TotDebitAmountInc);
          end;
        end
        else begin
          { no tax ... }
          if JournalEntryObj.TotDebitAmountInc > JournalEntryObj.TotCreditAmountInc then begin
            EditDb(tblDetails);
            tblDetailsCreditAmount.AsFloat:=
              (JournalEntryObj.TotDebitAmountInc - JournalEntryObj.TotCreditAmountInc);
          end
          else if JournalEntryObj.TotDebitAmountInc < JournalEntryObj.TotCreditAmountInc then begin
            EditDb(tblDetails);
            tblDetailsDebitAmount.AsFloat:=
              (JournalEntryObj.TotCreditAmountInc - JournalEntryObj.TotDebitAmountInc);
          end;
        end;
      finally
        JournalEntryObj.Lines.DoFieldChange:= SaveDoFieldChange;
      end;
    end;
  end;
end;

initialization
  RegisterClassOnce(TJournalEntryGUI);
  with FormFact do begin
    RegisterMe(TJournalEntryGUI, 'TMemTransListGUI_*_TJournalEntryGUI=TransID');
    RegisterMe(TJournalEntryGUI, 'TJournalListGui_*=GJID');
    RegisterMe(TJournalEntryGUI, 'TJournalEnrtiesGUI_*=GJID');
    RegisterMe(TJournalEntryGUI, 'TBalTransListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TInventoryAssetVsStockStautsGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TToBeReconciledGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TReconListDetailFormGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TTrialBalTransListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TTransactionListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TBASTransReturnListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TNZTransReturnListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TVATTransReturnListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TGlobalsearchGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TTransAccountDetailsGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TBankAccountListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TGeneralLedgerReportGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TCashBasisDetailsGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TAllTransactionGUI_*_Journal Entry=TransNo');
    RegisterMe(TJournalEntryGUI, 'TAccountsPayListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TAccountsReceiveListGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TAccountsReceiveListDebugGUI_*_Journal Entry=SaleID');
    RegisterMe(TJournalEntryGUI, 'TMemTransListGUI_*_Journal Entry=TransID');
    RegisterMe(TJournalEntryGUI, 'TPnLEmployeereportGUI_*_Journal Entry=TransID');
    RegisterMe(TJournalEntryGUI, 'TJobProfitabilityforCustomerGUI_*_Journal entry=SaleID');

  end;
end.
