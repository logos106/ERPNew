unit frmDepositFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/08/05  1.00.01  DSP  Added drill down for a transaction type when a row is
                         double clicked.
 15/08/05  1.00.02  DSP  Reduced the width of the 'Deposited' column to remove
                         the horizontal scroll bar on the grid.
 23/08/05  1.00.03  DSP  Added restriction for 'Grouped Clients' to prevent
                         drill down.
 30/09/05  1.00.04 IJB  Modified to use new procedure
                        (PaymentsLibGUI.ShowReconciledListForm) to replace
                        procedure removed from TransLockManagementObj.
 1/11/05   1.00.05 DLS   Added RegisterClass                        
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DB, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids,
    DNMPanel, Buttons, DNMSpeedButton, Grids, BaseGrid, BaseInputForm, AdvGrid,
  wwdbdatetimepicker, wwdblook, wwcheckbox, ImgList, SelectionDialog,
  AppEvnts, MyAccess,ERPdbComponents, DBAccess, DataState, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar,
  AdvProgr, wwdbedit, MemDS, Shader, busObjBankDepost, busobjbase,
  Wwdbigrd, Wwdbgrid, ProgressDialog;

type

  TDepositSearch = record
    TransType: String;
    Date: String;
    PayMethodID: String;
    ClassName:String;
  end;

  TDepositGUI = class(TBaseInputGUI)
    Notes: TDBMemo;
    Label28: TLabel;
    Box31: TBevel;
    Label36: TLabel;
    Label44: TLabel;
    cboClassQry: TERPQuery;
    cboClassSrc: TDataSource;
    cboAccountQry: TERPQuery;
    cboAccountSrc: TDataSource;
    DSMaster: TDataSource;
    lblDeleted: TLabel;
    chkDeleted: TwwCheckBox;
    DSDetails: TDataSource;
    Box68: TBevel;
    Label80: TLabel;
    txtDepositAmount: TDBEdit;
    cboCreationDate: TwwDBDateTimePicker;
    SaleDate_Label: TLabel;
    ClassLabel: TLabel;
    cboClass: TwwDBLookupCombo;
    cboAccount: TwwDBLookupCombo;
    lblAccount: TLabel;
    txtUnDeposited: TDNMPanel;
    txtDeposited: TDNMPanel;
    imgPopup: TImageList;
    GroupCashSales: TwwCheckBox;
    lblGroupCashSales: TLabel;
    tblDepositsDetails: TERPQuery;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    tblMasterGlobalRef: TWideStringField;
    tblMasterDepositID: TAutoIncField;
    tblMasterDepositDate: TDateField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterClassID: TIntegerField;
    tblMasterClassName: TWideStringField;
    tblMasterAccountID: TIntegerField;
    tblMasterNotes: TWideStringField;
    tblMasterDeposit: TFloatField;
    tblMasterDeleted: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterReconciled: TWideStringField;
    tblPrepayments: TERPQuery;
    Label2: TLabel;
    TransNo: TDBEdit;
    btnReconciled: TDNMSpeedButton;
    SaveProgress: TAdvProgress;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tblGuiBankDeposit: TERPQuery;
    dsGuiBankDeposit: TDataSource;
    Panel2: TPanel;
    grdLines: TwwDBGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    tblGuiBankDepositTrntype: TWideStringField;
    tblGuiBankDepositPaidDate: TDateField;
    tblGuiBankDepositcompanyName: TWideStringField;
    tblGuiBankDepositAmount: TFloatField;
    tblGuiBankDepositTransactionID: TIntegerField;
    tblGuiBankDepositAccountName: TWideStringField;
    tblGuiBankDepositClassName: TWideStringField;
    tblGuiBankDepositChequeNo: TWideStringField;
    tblGuiBankDepositPaymentMethod: TWideStringField;
    tblGuiBankDepositTransID: TIntegerField;
    tblGuiBankDepositClientID: TIntegerField;
    tblGuiBankDepositPayMethodID: TIntegerField;
    tblGuiBankDepositAccountID: TIntegerField;
    tblGuiBankDepositTableName: TWideStringField;
    tblGuiBankDepositDepositID: TIntegerField;
    tblGuiBankDepositDeposited: TWideStringField;
    tblGuiBankDepositLineID: TIntegerField;
    tblGuiBankDepositID: TIntegerField;
    tblMasterDepositTot: TFloatField;
    tblMasterUnDepositTot: TFloatField;
    QryDepartmentforDeposit: TERPQuery;
    pnlDepositfromDepartment: TDNMPanel;
    chkallclasses: TCheckBox;
    cboDepositfromDepartment: TwwDBLookupCombo;
    lblChoosedepartment: TLabel;
    QryDepartmentforDepositClassID: TIntegerField;
    QryDepartmentforDepositClassName: TWideStringField;
    btnRefreshList: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    lblSearchField: TLabel;
    edtDepositSearch: TwwDBEdit;
    lblSearch: TLabel;
    btnDepositNext: TDNMSpeedButton;
    lblRefreshList: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    btnAddDate: TDNMSpeedButton;
    lblNote: TLabel;
    DNMPanel2: TDNMPanel;
    cmdNew: TDNMSpeedButton;
    cmdSave: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    btnAuto: TDNMSpeedButton;
    btnSelectAll: TDNMSpeedButton;
    btnDeselectAll: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure txtDepositAmountExit(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure NotesExit(Sender: TObject);
    procedure NotesEnter(Sender: TObject);
    procedure GroupCashSalesClick(Sender: TObject);
    procedure chkDeletedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnDeselectAllClick(Sender: TObject);
    procedure btnReconciledClick(Sender: TObject);
    procedure btnAutoClick(Sender: TObject);
    procedure btnDepositNextClick(Sender: TObject);
    procedure grdLinesDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblGuiBankDepositDEpositedChange(Sender: TField);
    procedure edtDepositSearchChange(Sender: TObject);
    procedure grdLinesColEnter(Sender: TObject);
    procedure grdLinesEnter(Sender: TObject);
    procedure grdLinesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cboDepositfromDepartmentCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnRefreshListClick(Sender: TObject);
    procedure chkallclassesClick(Sender: TObject);
    procedure pnlDepositfromDepartmentEnter(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnAddDateClick(Sender: TObject);
  private
    { Private declarations }
    BankDeposit :TBankDeposit;
    procedure AllowSave;
    procedure Print(const ID: integer);
    Procedure InitSetup;
    procedure RefreshguiLines;
    procedure NewBankdeposit(InitClassSelection:Boolean = True);
    Procedure RefreshListOptionChanged(Const value:Boolean);
    function RefreshListCaption:String;
    procedure OpenTenderAccounts;
    Procedure DoREsetFlagForDeletedTrans(Sender :TObject);
    procedure initonFormShow(InitClassSelection:Boolean = True);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function FieldsToExecludeFromsorting: String ; override;

  public
  end;

implementation

uses FastFuncs,FormFactory,  
       TransDrillDown,
     PaymentsLibGUI, CommonLib, kbmMemTable, UserLockObj, Math, Types,
     AppEnvironment, BusObjConst, DNMLib, CommonDbLib, tcTypes,
     frmTenderPrefs, DefaultClassObj, LogLib, SharedObjs, tcConst;

Const
  CAPTION_NEXT = '&Next';
  CAPTION_GO   = '&Go';
  CAPTION_PREV   = '&Previous';

  {$R *.DFM}

procedure TDepositGUI.cmdCancelClick(Sender: TObject);
begin
    Self.close;
end;
Procedure TDepositGUI.InitSetup;
begin
    lblDeleted.Visible          := KeyID<>0;
    chkDeleted.Visible          := KeyID<>0;
    GroupCashSales.Visible      := KeyID<>0;
    lblGroupCashSales.Visible   := KeyID<>0;
    cmdPrint.Enabled            := KeyID<>0;
    btnAuto.Enabled             := KeyID=0;
    btnReconciled.Visible := BankDeposit.IsDepositLocked in [ltReconciled,ltOnHoldRec];
    btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');
    if KeyID = 0 then begin
        GroupCashSales.Checked := AppEnv.CompanyPrefs.UseGroupedPOSDeposits;
        BankDeposit.GroupCashSales := GroupCashSales.Checked;
        stepProgressbar;
    end else begin
        BankDeposit.GuiBankDeposit.Calctotals;
        if not Bankdeposit.Lock then begin
            Self.Caption := self.Caption + '     {' + Bankdeposit.LockMsg +'}';
            Accesslevel  := 5;
            Bankdeposit.UserLock.UnlockAllCurrentInstance;
            txtDepositAmount.OnExit := nil;
        end;
        stepProgressbar;
        RefreshguiLines;
    end;

    //Bankdeposit.GuiBankDeposit;
    stepProgressbar;
    chkDeleted.Enabled := (AccessLevel = 1);
end;
procedure TDepositGUI.NewBankdeposit(InitClassSelection:Boolean = True);
begin
    if InitClassSelection then chkallclasses.checked := False;
    OpenDB(QryDepartmentforDeposit);

    if chkallclasses.checked =False then begin
      if (cboDepositfromDepartment.text <>'') and (QryDepartmentforDeposit.Locate('Classname' , cboDepositfromDepartment.text , [])) then
      else if QryDepartmentforDeposit.Locate('ClassID' , appenv.DefaultClass.ClassID , []) then
        cboDepositfromDepartment.Text :=QryDepartmentforDepositClassName.asString
      else chkallclasses.checked := true;
    end;
    RefreshguiLines;
end;
procedure TDepositGUI.FormShow(Sender: TObject);
begin
  inherited;
  initonFormShow;
end;
procedure TDepositGUI.initonFormShow(InitClassSelection:Boolean = True);
var
    QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    showProgressbar('Please Wait' , 10);
    try
      self.BeginTransaction;
      tblGuiBankDeposit.DisableControls;
      try
        stepProgressbar;
          BankDEposit.Load(KeyID);
          stepProgressbar;
          InitSetup;
          pnlDepositfromDepartment.Enabled := KeyId = 0;
          stepProgressbar;
          if KeyId = 0 then begin
              BankDEposit.New;
              BankDeposit.PostDb;
              NewBankdeposit(InitClassSelection);
              BankDEposit.LockTransactions;
              //BankDEposit.GuiBankDeposit;
          End else begin
              if dgEditing in  grdLines.Options then grdLines.Options := grdLines.Options-[dgEditing];
              txtDepositAmount.Readonly   := True;
              cboAccount.Readonly         := True;
              cboCreationDate.Readonly    := True;
              cboClass.Readonly           := True;
  //            TransNo.Readonly            := True;
              if BankDeposit.Deleted then
                lblDeleted.OnDblClick := DoREsetFlagForDeletedTrans;
          end;
          stepProgressbar;
          AllowSave;
          stepProgressbar;
      Finally
          tblGuiBankDeposit.EnableControls;
      end;

      ClassLabel.Caption := AppEnv.DefaultClass.ClassHeading;
      stepProgressbar;
      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      DeactivateDefaultValues(QueryNamesNotToOpen);

      stepProgressbar;
      Setlength(QueryNamesNotToOpen, 3);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      QueryNamesNotToOpen[2] := 'tblGuiBankDeposit';
      OpenQueries(QueryNamesNotToOpen);
      //BankDeposit.GuiBankDeposit.Calctotals;
    finally
      HideProgressbar;
    end;

  finally
    EnableForm;
  end;
end;

procedure TDepositGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  self.RollbackTransaction;
end;

procedure TDepositGUI.cmdSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    BankDeposit.BankDepositTotal := strValue(txtDepositAmount.text);
    if not BankDeposit.Save then Exit;
    self.CommitTransaction;
    Notify;
    Self.Close;
  finally
    EnableForm;
  end;  
end;

procedure TDepositGUI.AllowSave;
begin
    cmdNew.Enabled        := True;
    cmdSave.Enabled       := Bankdeposit.dirty;
    cmdPrint.Enabled      := true;
    btnSelectAll.Enabled  := (Bankdeposit.CountUnselected>0) and (KeyId =0);
    btnDeselectAll.Enabled:= (Bankdeposit.Countselected>0) and (KeyId =0);
end;

procedure TDepositGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    if BankDeposit.Save then begin
        BankDeposit.UserLock.UnlockAllCurrentInstance;
        self.CommitTransaction;
        self.BeginTransaction;
        Bankdeposit.New;
        KeyId := 0;
        showProgressbar('Please Wait' , 4);
        try
          InitSetup;
        finally
          HideProgressbar;
        end;
        NewBankdeposit;
        AllowSave;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TDepositGUI.txtDepositAmountExit(Sender: TObject);
begin
  inherited;
    BankDeposit.Deposit := strValue(txtDepositAmount.text);
    BankDeposit.autoSelect;

    AllowSave;
end;

procedure TDepositGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    if BankDeposit.Save then begin
//        self.CommitTransaction;
        Print(BankDeposit.Id);
//        Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TDepositGUI.Print(const ID: integer);
var
  sSQL: string;
begin
  sSQL := Format(' WHERE tblBankDeposit.DepositID = %d', [ID]);
  sSQL := sSQL + ' Order By PaymentMethod,TrnsType,PaymentDate ';
  ConnectionFormReport := Myconnection;
  PrintTemplateReport('Bank Deposit', sSQL, not AppEnv.Employee.ShowPreview, 1);
end;


procedure TDepositGUI.NotesExit(Sender: TObject);
begin
  inherited;
  if accesslevel <= 2 then begin
    //Notes.text := AddDateTime(lcdOnDepositNotes, Notes.text);
    AddDateTime(lcdOnDepositNotes, Notes);
  end;
end;
procedure TDepositGUI.btnAddDateClick(Sender: TObject);
begin
  inherited;
  if accesslevel <= 2 then begin
    //Notes.text := AddDateTime(lcdOnLoganyway, Notes.text);
    AddDateTime(lcdOnLoganyway, Notes);
  end;
end;
procedure TDepositGUI.NotesEnter(Sender: TObject);
begin
  inherited;
  with Notes do Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
end;


procedure TDepositGUI.GroupCashSalesClick(Sender: TObject);
begin
  inherited;
  BankDeposit.GroupCashSales := GroupCashSales.checked;
  //RefreshguiLines;
  initonFormShow;
end;

procedure TDepositGUI.chkDeletedClick(Sender: TObject);
begin
  inherited;
  cmdSave.Enabled := chkDeleted.Checked;
end;

procedure TDepositGUI.FormCreate(Sender: TObject);
begin
    btnAddDate.Visible :=   not(UserPreferenceOn(lcdOnDepositNotes));
    AllowGridSorting  := True;
    Bankdeposit             := TBankDeposit.create(self);
    Bankdeposit.Progressbar := SaveProgress;
    Bankdeposit.SQL         := 'Select * from tblBankDeposit';
    Bankdeposit.BusObjEvent := DoBusinessObjectEvent;
    Bankdeposit.connection  := TMydacDataconnection.create(Bankdeposit);
    Bankdeposit.connection.connection   := Self.MyConnection;
    Bankdeposit.IsTobeDeposited := True;
    inherited;

  cboAccount.Options := cboAccount.Options + [lotitles];
  cboAccount.Selected.Clear;
  cboAccount.Selected.Add(SelectedText('AccountName' , 'Account name', AppEnv.companyprefs.AccountNamecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Type'        , 'Type'        , AppEnv.companyprefs.AccountTypecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Description' , 'Description' , AppEnv.companyprefs.AccountDescriptioncolumnDropdownWidth , ''));


    {tblGuiBankDeposit is based on a temporary table and can be outside transaction}
    (*MyConnection1.Server            := MyConnection.Server;
    MyConnection1.Username          := MyConnection.Username;
    MyConnection1.Password          := MyConnection.Password;
    MyConnection1.Database          := MyConnection.Database;
    MyConnection1.Options.Compress  := MyConnection.Options.Compress;
    MyConnection1.Options.Protocol  := MyConnection.Options.Protocol;
    MyConnection1.Connected         := True;
    tblGuiBankDeposit.connection    := MyConnection1;*)
    tblGuiBankDeposit.connection    := commondbLib.GetSharedMyDacConnection;
    UserLock.Enabled := True;
end;

procedure TDepositGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TDepositGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TDepositGUI.btnSelectAllClick(Sender: TObject);
begin
  DisableForm;
  try
    BankDeposit.DepositLines;
    Bankdeposit.GuiBankDeposit.Calctotals;
    AllowSave;
  finally
    EnableForm;
  end;
end;

procedure TDepositGUI.btnDeselectAllClick(Sender: TObject);
begin
  DisableForm;
  try
    Bankdeposit.UnDepositLines;
    Bankdeposit.GuiBankDeposit.Calctotals;
    AllowSave;
  finally
    EnableForm;
  end;  
end;

procedure TDepositGUI.btnReconciledClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowReconciledListForm(tblMasterDepositID.AsInteger, 'Bank Deposit');
end;


procedure TDepositGUI.btnAutoClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
      if (CommonLib.MessageDlgXP_Vista('Do You Wish To Automatically Create "Deposits" For Tender Accounts', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
          if BankDeposit.AutoDepositTenderAccounts then begin
              Bankdeposit.New;
              KeyId := 0;
              showProgressbar('Please Wait' , 4);
              try
                InitSetup;
              finally
                HideProgressbar;
              end;
              NewbankDeposit;
              AllowSave;
          end;
   finally
    EnableForm;
  end;       
end;

procedure TDepositGUI.btnDepositNextClick(Sender: TObject);
var
//    Bookmark:TBookmark;
    (*amt :double;
    amtfound:boolean;*)
//    found:Boolean;
    fsfilter:String;
    curField :TField;
    SearchString:String;
    procedure gotoNext;
    begin
        if TDNMSpeedButton(Sender).Caption = CAPTION_NEXT  then
            BankDeposit.GuiBankDeposit.dataset.Next
        else BankDeposit.GuiBankDeposit.dataset.Prior;
    end;
begin
    SearchString := Trim(edtDepositSearch.Text);
    if TDNMSpeedButton(Sender).Caption = CAPTION_GO then TDNMSpeedButton(Sender).Caption := CAPTION_NEXT;
    curfield :=TField(grdLines.GetActiveField);
    IF grdLines.GetActiveField is TWideStringField then
       fsFilter :=CurField.Fieldname +'=' + QuotedStr(SearchString)
    else if SearchString = '' then fsFilter := CurField.Fieldname +'is null or '+CurField.Fieldname +' = 0'
    else try
      if (grdLines.GetActiveField is TDateTimeField) or (grdLines.GetActiveField is TDateField) then
         fsFilter :=CurField.Fieldname +'=' + QuotedStr(formatDateTime('yyyy-mm-dd' , strTodate(SearchString)))
      else fsFilter :=CurField.Fieldname +'=' + SearchString;
    except
      fsFilter :=CurField.Fieldname +'= 0';
    end;

    if fsFilter <> BankDeposit.GuiBankDeposit.dataset.filter then begin
      BankDeposit.GuiBankDeposit.dataset.filter := fsfilter;
      if BankDeposit.GuiBankDeposit.dataset.findfirst =False then begin
           TDNMSpeedButton(Sender).Caption := CAPTION_GO;
           BankDeposit.GuiBankDeposit.dataset.filter := '';
           if devmode then TimerMsg(lblNote, fsfilter + ' : Not found');
      end else TDNMSpeedButton(Sender).Caption :=CAPTION_NEXT;
    end else begin
      if TDNMSpeedButton(Sender).Caption = CAPTION_NEXT then begin
        if BankDeposit.GuiBankDeposit.dataset.findNext =False then
          TDNMSpeedButton(Sender).Caption := CAPTION_PREV;
      end else begin
        if BankDeposit.GuiBankDeposit.dataset.findPrior =False then
          TDNMSpeedButton(Sender).Caption := CAPTION_NEXT;
      end;
    end;

(*    inherited;
    Bookmark:= BankDeposit.GuiBankDeposit.dataset.GetBookmark;
    try
        gotoNext;
        found:=false;
        while (BankDeposit.GuiBankDeposit.dataset.Eof = False) and
              (BankDeposit.GuiBankDeposit.dataset.BOF = False) do begin
            if BankDeposit.GuiBankDeposit.Amount = amt then begin
              amtfound := True;
                Exit;
            end;
            gotoNext;
        end;
    finally
      if not amtfound then begin
        BankDeposit.GuiBankDeposit.dataset.GotoBookmark(Bookmark);
        if TDNMSpeedButton(Sender).Caption = CAPTION_NEXT then TDNMSpeedButton(Sender).Caption := CAPTION_PREV
        else if TDNMSpeedButton(Sender).Caption = CAPTION_PREV then TDNMSpeedButton(Sender).Caption := CAPTION_NEXT;
      end;
      BankDeposit.GuiBankDeposit.dataset.FreeBookmark(Bookmark);

    end;*)

    (*amt := strValue(edtDepositSearch.text);
    inherited;
    Bookmark:= BankDeposit.GuiBankDeposit.dataset.GetBookmark;
    try
        gotoNext;
        amtfound:=false;
        while (BankDeposit.GuiBankDeposit.dataset.Eof = False) and
              (BankDeposit.GuiBankDeposit.dataset.BOF = False) do begin
            if BankDeposit.GuiBankDeposit.Amount = amt then begin
              amtfound := True;
                Exit;
            end;
            gotoNext;
        end;
    finally
      if not amtfound then begin
        BankDeposit.GuiBankDeposit.dataset.GotoBookmark(Bookmark);
        if TDNMSpeedButton(Sender).Caption = CAPTION_NEXT then TDNMSpeedButton(Sender).Caption := CAPTION_PREV
        else if TDNMSpeedButton(Sender).Caption = CAPTION_PREV then TDNMSpeedButton(Sender).Caption := CAPTION_NEXT;
      end;
      BankDeposit.GuiBankDeposit.dataset.FreeBookmark(Bookmark);

    end;*)
end;

procedure TDepositGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TBankDeposit         then TBankDeposit(Sender).DataSet      := tblMaster
        else if Sender is TBankDepositLines    then TBankDepositLines(Sender).DataSet := tblDetails
        else if Sender is TGuiBankDepositdet   then // dataset is not from form , TGuiBankDepositdet is descendant of TGuiBankDeposit, so don;t delete this line 
        else if Sender is TGuiBankDeposit      then begin
            if TGuiBankDeposit(sender).ConnectionAssigned = false then begin
                TGuiBankDeposit(sender).connection := TMydacDataconnection.Create(TGuiBankDeposit(sender));
                TGuiBankDeposit(sender).connection.connection := tblGuiBankDeposit.Connection;
            end;
            TGuiBankDeposit(sender).Dataset   := tblGuiBankDeposit;
        end;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_MissingTenderAccounts) then begin
      if (CommonLib.MessageDlgXP_Vista('Tender Accounts for Auto Deposit are not selected.' +chr(13) +'Do you wish to select it now?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then begin
      end else begin
        OpenTenderAccounts;
      end;
    end;
end;
procedure TDepositGUI.DoREsetFlagForDeletedTrans(Sender: TObject);
begin
  if BankDeposit.Deleted =False then Exit;
  
  BankDeposit.ResetDepositflags;
  if BankDeposit.PostList.Count>0 then begin
  	clog('create table if not exists '+ ERPFIXTablenameforCurVersion('tbldeposits')+' like tbldeposits;'+NL+
    'insert ignore into '+ ERPFIXTablenameforCurVersion('tbldeposits')+' select * from  tbldeposits;'+NL+
    'create table if not exists '+ ERPFIXTablenameforCurVersion('tblPrePayments')+' like tblPrePayments;'+NL+
    'insert ignore into '+ ERPFIXTablenameforCurVersion('tblPrePayments')+' select * from  tblPrePayments;');
    BankDeposit.PostList.Execute;
    Logtext(BankDeposit.PostList.Queries.text);
    self.CommitTransaction;
    Notify;
    Self.Close;
  end;

end;

procedure TDepositGUI.grdLinesDblClick(Sender: TObject);
var
    TransDrillDown : TTransDrillDown;
begin
    inherited;
    TransDrillDown := TTransDrillDown.Create;
    try
        if Sysutils.SameText(BankDeposit.GuiBankDeposit.companyName,'Grouped Clients') then begin
            if (CommonLib.MessageDlgXP_Vista('Cannot retrieve detailed information on ''Grouped Clients''.'+#13+#10+'Do you wish to ungroup the grouped clients?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
                GroupCashSales.Checked := false;
                BankDeposit.GroupCashSales := False;
                RefreshguiLines;
            end
        end else TransDrillDown.Execute(BankDeposit.GuiBankDeposit.TrnType, BankDeposit.GuiBankDeposit.TransID, True);
    finally
        FreeAndNil(TransDrillDown);
    end;
end;

procedure TDepositGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    CanClose:= false;
    if BankDeposit.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes,mbNo,mbCancel], 0) of
            mrYes :    begin
                if BankDeposit.Save then begin
                     self.CommitTransaction;
                     CanClose:= true;
                end;
            end;
            mrNo  :    begin
                self.RollbackTransaction;
                BankDeposit.Dirty:= false;
                CanClose:= true;
            end;
            mrCancel : begin
                CanClose:= false;
            end;
        end;
    end  else begin
        CanClose:= true;
    end;
end;

procedure TDepositGUI.tblGuiBankDepositDEpositedChange(Sender: TField);
begin
  inherited;
  AllowSave;
end;

function TDepositGUI.FieldsToExecludeFromsorting: String;
begin
    result := inherited FieldsToExecludeFromsorting;
end;

procedure TDepositGUI.edtDepositSearchChange(Sender: TObject);
begin
  inherited;
  btnDepositNext.Caption := CAPTION_GO;
end;

procedure TDepositGUI.grdLinesColEnter(Sender: TObject);
begin
  inherited;
  lblSearchField.caption := StringReplace(TField(grdLines.GetActiveField).displaylabel, '~' , ' ', []);
end;

procedure TDepositGUI.grdLinesEnter(Sender: TObject);
begin
  inherited;
  grdLinesColEnter(Sender);
  
end;

procedure TDepositGUI.grdLinesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  If tblGUIBankDepositDeposited.asBoolean then
      ABrush.Color := $00C4FFE1;
end;

procedure TDepositGUI.cboDepositfromDepartmentCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then exit;
  inherited;
  chkallclasses.checked :=  cboDepositfromDepartment.Text = '';
  RefreshListOptionChanged(True);
end;

procedure TDepositGUI.btnRefreshListClick(Sender: TObject);
begin
  if MessageDlgXP_Vista('This will Cancel all Selections Made. Do you Want to Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  try
    self.RollbackTransaction;
    BankDeposit.Dirty:= false;
    tblGuiBankDeposit.disablecontrols;
    try
      //RefreshguiLines;
      initonFormShow(False);
    finally
      tblGuiBankDeposit.enableControls;
    end;
  finally
    self.beginTransaction;
  end;
end;

Procedure TDepositGUI.RefreshguiLines;
var
  fiListforDepartmentID:Integer;
begin
  inherited;
  if (chkallclasses.checked)  then fiListforDepartmentID := 0
  else fiListforDepartmentID := QryDepartmentforDepositClassID.asInteger;
  if BankDeposit.ListforDepartmentID <> fiListforDepartmentID then begin
    closeDB(grdLines.Datasource.Dataset);
    Processingcursor(True);
    try
      if BankDEposit.GuiTableName<>'' then begin
        DestroyUserTemporaryTable(BankDEposit.GuiTableName);
        BankDEposit.GuiTableName := '';// force to recreate the lines for the selected class
      end;
      BankDeposit.ListforDepartmentID := fiListforDepartmentID;
      BankDEposit.GuiBankDeposit;
      lblRefreshList.Caption := RefreshListCaption;
    Finally
      OpenDB(grdLines.Datasource.Dataset);
      Processingcursor(False);
      RefreshListOptionChanged(False);
    end;

  End;

end;

procedure TDepositGUI.chkallclassesClick(Sender: TObject);
begin
  inherited;
  if chkallclasses.checked then
    cboDepositfromDepartment.Text := ''
  else SetControlFocus(cboDepositfromDepartment);
  RefreshListOptionChanged(true);
end;

procedure TDepositGUI.RefreshListOptionChanged(const value: Boolean);
begin
(*if value then
  btnRefreshList.font.Color := clRed else btnRefreshList.font.color := clblack;*)
end;

function TDepositGUI.RefreshListCaption: String;
begin
  Result := DoTranslate('Entries To Be Deposited From') +' ' ;
  if (chkallclasses.checked)  then  result:= result + ' All ' +Appenv.DefaultClass.ClassHeading+'s'
  else result:= result + Quotedstr(cboDepositfromDepartment.Text) +Appenv.DefaultClass.ClassHeading;
end;

procedure TDepositGUI.pnlDepositfromDepartmentEnter(Sender: TObject);
begin
  inherited;
  if (BankDeposit.Totalamount<> 0) or (BankDeposit.DepositedTotal<>0) then begin
    SetControlFocus(grdLines);
  end;
end;
procedure TDepositGUI.OpenTenderAccounts;
var
  TenderPrefs :TComponent;
begin
  TenderPrefs :=  GetComponentByClassName('TTenderPrefsGUI' , true , self) ;
  if TenderPrefs <> nil then begin
    TTenderPrefsGUI(TenderPrefs).showModal;
  end;
end;
procedure TDepositGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenTenderAccounts;
end;

initialization
  RegisterClassOnce(TDepositGUI);
  with FormFact do begin
    RegisterMe(TDepositGUI, 'TBankAccountListGUI_*_Deposited=PaymentID');
    RegisterMe(TDepositGUI, 'TBankAccountListGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TBalTransListGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TToBeReconciledGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TReconListDetailFormGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TTrialBalTransListGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TTransactionListGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TBASTransReturnListGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TNZTransReturnListGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TVATTransReturnListGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TGlobalsearchGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TGeneralLedgerReportGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TTransAccountDetailsGUI_*_Bank Deposit=PaymentID');
    RegisterMe(TDepositGUI, 'TDepositedListGUI_*_Deposit=DepositID');
    RegisterMe(TDepositGUI, 'TCustPaymentDepositListGUI_*_Deposit=DepositID');
    RegisterMe(TDepositGUI, 'TAllTransactionGUI_*_Deposit=TransNo');
  end;
end.



