unit frmDepositEntry;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/09/05  1.00.01 IJB  Modified to use new procedure
                        (PaymentsLibGUI.ShowReconciledListForm) to replace
                        procedure removed from TransLockManagementObj.
 1/11/05   1.00.02 DLS  Added RegisterClass
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,  StdCtrls, Buttons, DNMSpeedButton, wwdbdatetimepicker,
  ExtCtrls, DNMPanel, wwclearbuttongroup, wwradiogroup, Mask, DBCtrls, Wwdbigrd, Grids,
  Wwdbgrid, wwdblook, SelectionDialog,  kbmMemTable, wwcheckbox,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, DateUtils, MemDS, Shader,
  busObjBankDepost, busobjbase, ImgList, ERPDbLookupCombo, ProgressDialog;

type
  TDepositEntryGUI = class(TBaseInputGUI)
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    cboDate: TwwDBDateTimePicker;
    Label1: TLabel;
    TransNo: TDBEdit;
    Label2: TLabel;
    pnlDetail: TDNMPanel;
    grdTransactions: TwwDBGrid;
    btnDelete: TwwIButton;
    cboClientLookup: TERPQuery;
    cboClassQry: TERPQuery;
    DSClientLookup: TDataSource;
    cboClassSrc: TDataSource;
    cboCustomerJob: TwwDBLookupCombo;
    cboAccountline: TERPDBLookupCombo;
    btnPrint: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    cboAccountQry: TERPQuery;
    cboAccountSrc: TDataSource;
    Box68: TBevel;
    lblAccount: TLabel;
    cboAccount: TwwDBLookupCombo;
    DSPaymethod: TDataSource;
    qryPayMethod: TERPQuery;
    cboPaymentMethod: TwwDBLookupCombo;
    cboClass: TwwDBLookupCombo;
    Label80: TLabel;
    txtDepositAmount: TDBEdit;
    Label28: TLabel;
    Notes: TDBMemo;
    Label36: TLabel;
    txtDeposited: TDNMPanel;
    Box31: TBevel;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    tblMasterGlobalRef: TWideStringField;
    tblMasterDepositID: TAutoIncField;
    tblMasterDepositDate: TDateField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterClassID: TIntegerField;
    tblMasterClassName: TWideStringField;
    tblMasterArea: TWideStringField;
    tblMasterAccountID: TIntegerField;
    tblMasterNotes: TWideStringField;
    tblMasterDeposit: TFloatField;
    tblMasterDeleted: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterReconciled: TWideStringField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsDepositLineID: TAutoIncField;
    tblDetailsDepositID: TIntegerField;
    tblDetailsPaymentID: TIntegerField;
    tblDetailsTrnsType: TWideStringField;
    tblDetailsCusID: TIntegerField;
    tblDetailsPayMethodID: TIntegerField;
    tblDetailsPaymentMethod: TWideStringField;
    tblDetailsPaymentDate: TDateField;
    tblDetailsCompanyName: TWideStringField;
    tblDetailsReferenceNo: TWideStringField;
    tblDetailsClassID: TIntegerField;
    tblDetailsTransClassName: TWideStringField;
    tblDetailsAccountID: TIntegerField;
    tblDetailsAccountName: TWideStringField;
    tblDetailsName: TWideStringField;
    tblDetailsAmount: TFloatField;
    tblDetailsNotes: TWideStringField;
    tblDetailsCustomer: TWideStringField;
    tblDetailsSupplier: TWideStringField;
    tblDetailsEmployee: TWideStringField;
    tblDetailsContact: TWideStringField;
    tblDetailsDeposited: TWideStringField;
    tblDetailsStatementNo: TIntegerField;
    tblDetailsFromDeposited: TWideStringField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsReconciled: TWideStringField;
    tblDetailsTransID: TIntegerField;
    Label11: TLabel;
    btnReconciled: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tblDetailsDeleted: TWideStringField;
    chkDeleted: TwwCheckBox;
    cmdNew: TDNMSpeedButton;
    qryLinesAccountLookup: TERPQuery;
    btnAddDate: TDNMSpeedButton;
    Label3: TLabel;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    mnupopup: TAdvPopupMenu;
    CalculatorF81: TMenuItem;
    lbMemTrans: TLabel;
    wwCreateRule: TwwCheckBox;
    ERPQWildCards: TERPQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure cboAccountlineNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboCustomerJobCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure tblDetailsAmountChange(Sender: TField);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure NotesExit(Sender: TObject);
    procedure NotesEnter(Sender: TObject);
    procedure btnReconciledClick(Sender: TObject);
    procedure tblDetailsAfterDelete(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure btnAddDateClick(Sender: TObject);
    procedure CalculatorF81Click(Sender: TObject);
    procedure grdTransactionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbMemTransMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cboAccountQryBeforeOpen(DataSet: TDataSet);
    procedure tblMasterAfterOpen(DataSet: TDataSet);

  private
    fGLAccountID: integer;
    fAmount: currency;
    fLineNotes: string;
    fPayDate: TDateTime;
    fFromAccount: string;
    fPaymentMethod: string;
    fPayee: string;
    { Private declarations }
    function DoubleToCurrString(const d: double): string;
    procedure Print(ID: integer; Print: boolean);
    function InvalidTotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer;
    Procedure NewDepositEntry;
    function doCalculate: Boolean;
    Procedure TransAuditTrialbeforeShow(Sender:TObject);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Bankdeposit :TBankDeposit;
    property GLAccountID: integer read fGLAccountID write fGLAccountID;
    property LineNotes: string read fLineNotes write fLineNotes;
    property PayDate: TDateTime read fPayDate write fPayDate;
    property Amount: currency read fAmount write fAmount;
    property PaymentMethod: string read FPaymentMethod write FPaymentMethod;
    property FromAccount: string read FFromAccount write FFromAccount;
    property Payee: string read FPayee write FPayee;
  end;

implementation

uses
  FormFactory,  DNMExceptions,

  PaymentsLibGUI, CommonLib, BusObjConst, DNMLib, tcTypes, tcConst, frmCalculator,
  CommonFormLib, TransAuditTrail, StringUtils, AppEnvironment, BusObjBankReconciliationRules;

{$R *.dfm}

{ TDepositEntryGUI }

procedure TDepositEntryGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
  FreeandNil(Bankdeposit);
end;


procedure TDepositEntryGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TDepositEntryGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    try
      inherited;
      wwCreateRule.Visible := AppEnv.CompanyPrefs.YodleeEnabled;
      Setlength(QueryNamesNotToOpen, 3);
      QueryNamesNotToOpen[0] := 'tblMaster';
      QueryNamesNotToOpen[1] := 'tblDetails';
      QueryNamesNotToOpen[2] := 'cboAccountQry';
      OpenQueries(QueryNamesNotToOpen);
      btnDelete.Enabled := (AccessLevel = 1);
      BankDeposit.BusObjEvent := DoBusinessObjectEvent;
      BankDeposit.Load(KeyID);
      BankDeposit.Connection.BeginTransaction;
      BankDeposit.Lines.Dataset.Filter:= 'Deleted <> ' + QuotedStr('T');
      BankDeposit.Lines.Dataset.Filtered:= true;

      btnReconciled.Visible := BankDeposit.IsDepositEntryLocked in [ltReconciled,ltOnHoldRec];
      btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');

      if KeyID <> 0 then begin
           if not (BankDeposit.lock) then begin
            Self.Caption := self.Caption + '     {' + BankDeposit.LockMsg +'}';
            Accesslevel  := 5;
            btnCompleted.Enabled := false;
        end;
        Label11.Visible := true;
        chkDeleted.Visible := true;
      end else begin
        BankDeposit.new;
        txtDeposited.Caption := DoubleToCurrString(0.00);
        Label11.Visible := false;
        chkDeleted.Visible := false;
      end;
      txtDeposited.Caption := DoubleToCurrString(Bankdeposit.Totalamount);

      Label11.Enabled := not btnReconciled.Visible;
      chkDeleted.Enabled := not btnReconciled.Visible;
      if (fGLAccountID > 0) and (KeyID = 0) then
        Bankdeposit.AccountID:= fGLAccountID;
      if (fAmount > 0) and (KeyID = 0) then begin
        Bankdeposit.Lines.Amount := fAmount;
        Bankdeposit.DepositTot := fAmount;
      end;
      if (fLineNotes <> '') and (KeyID = 0) then  begin
        Bankdeposit.Lines.Notes := fLineNotes;
        Bankdeposit.Lines.LineName := fLineNotes;
        Bankdeposit.Lines.ReferenceNo := fLineNotes;
      end;
      if (fPayDate <> 0) and (KeyID = 0) then begin
        Bankdeposit.Lines.PaymentDate := fPayDate;
        Bankdeposit.DepositDate := fPayDate;
      end;
      if (fPaymentMethod <> '') and (KeyID = 0) then begin
        Bankdeposit.Lines.PaymentMethod := fPaymentMethod;
      end;
      if (fFromAccount <> '') and (KeyID = 0) then begin
        Bankdeposit.Lines.AccountName := FFRomAccount;
      end;
      if (fPayee <> '') and (KeyID = 0) then begin
        Bankdeposit.Lines.CompanyName := Fpayee;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;   
end;
function TDepositEntryGUI.InvalidTotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer;
begin
    Result := mrNo;
    if CommonLib.MessageDlgXP_Vista(msg, Dlgtype, Buttons, 0) = mrYes then begin
        txtDepositAmount.text:= FloatToStrF(BankDeposit.BankDepositTotal,ffCurrency, 15, CurrencyRoundPlaces);
        result := mrYes;
    end;
end;
procedure TDepositEntryGUI.lbMemTransMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbRight then
    CommonFormLib.OpenErpListform('TTransAuditTrailGUI' ,TransAuditTrialbeforeShow);
end;

procedure TDepositEntryGUI.btnCompletedClick(Sender: TObject);
var
  newRule: TBankReconciliationRules;
begin
  DisableForm;
  try
    inherited;
    BankDeposit.BankDepositTotal := strValue(txtDepositAmount.text);
    if BankDeposit.Save then begin
      Self.Payee := Bankdeposit.Lines.CompanyName;
      if wwCreateRule.Checked then begin
        newRule := TBankReconciliationRules.CreateWithNewConn(Nil);
        try
          newRule.LoadSelect('Payee=' + QuotedStr(BankDeposit.Lines.CompanyName) +' and StatementDesc =' + QuotedStr(BankDeposit.Lines.ReferenceNo));
          if newRule.count=0 then begin
            newRule.New;
            newRule.StatementDesc := BankDeposit.Lines.ReferenceNo;
            newRule.Payee         := BankDeposit.Lines.CompanyName;
            newRule.Active        := True;
            newRule.Save;
          end;
        finally
          newRule.Free;
        end;
      end;

      BankDeposit.connection.CommitTransaction;
      Notify(false);
      if fsModal in FormState then
        ModalResult:= mrOK
      else
        Close;
    end;
  finally
    EnableForm;
  end;  
end;
procedure TDepositEntryGUI.cboAccountlineNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
//  CommonLib.MessageDlgXP_Vista('Account Name Not in List !', mtWarning, [mbOK], 0);
//  cboAccountline.LookupValue := '';
//  SetControlFocus(cboAccountline);
end;

procedure TDepositEntryGUI.cboAccountQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cboAccountQry.Connection := tblmaster.Connection;
  cboAccountQry.Parambyname('AccountID').asInteger := Bankdeposit.Accountid;
end;

procedure TDepositEntryGUI.cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  CommonLib.MessageDlgXP_Vista('Customer''s Name Not in List !', mtWarning, [mbOK], 0);
  cboCustomerJob.LookupValue := '';
  SetControlFocus(cboCustomerJob);
end;

procedure TDepositEntryGUI.cboCustomerJobCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  Bankdeposit.Lines.CusID := LookupTable.FieldByName('ClientID').AsInteger;
  Bankdeposit.Lines.PostDB;
end;

procedure TDepositEntryGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  Bankdeposit.Lines.ClassID := LookupTable.FieldByName('ClassID').AsInteger;
end;

procedure TDepositEntryGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      Bankdeposit.Lines.Deleted := True;
      Bankdeposit.Lines.PostDB;
    except
      {Do nothing - raise a silent exception}
    end;
  end;
end;

function TDepositEntryGUI.DoubleToCurrString(const d: double): string;
begin
  Result := CurrToStrF(FloatToCurr(d), ffCurrency, 2)
end;
procedure TDepositEntryGUI.tblDetailsAmountChange(Sender: TField);
begin
  inherited;
  txtDeposited.Caption := DoubleToCurrString(Bankdeposit.Totalamount);
end;

procedure TDepositEntryGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  opendb(cboAccountQry)
end;

procedure TDepositEntryGUI.TransAuditTrialbeforeShow(Sender: TObject);
begin
  if not(Sender is TTransAuditTrailGUI) then exit;
  TTransAuditTrailGUI(Sender).DocName        := Bankdeposit.classname;
  TTransAuditTrailGUI(Sender).DocId          := Bankdeposit.ID;
  TTransAuditTrailGUI(Sender).TransGlobalref := Bankdeposit.Globalref;
  TTransAuditTrailGUI(Sender).DocDescription := Bankdeposit.XMLNodename; //StringUtils.SeparateWords(Bankdeposit.XMLNodename);
  TTransAuditTrailGUI(Sender).Formname       := Self.Classname;
end;

procedure TDepositEntryGUI.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  BankDeposit.postdb;
  BankDeposit.lines.postdb;
  if BankDeposit.lines.count = 0 then BankDeposit.lines.new;
end;

procedure TDepositEntryGUI.grdTransactionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_f9 then
      doCalculate;
end;

procedure TDepositEntryGUI.FormCreate(Sender: TObject);
begin
  btnAddDate.Visible :=   not(UserPreferenceOn(lcdOnDepositEntryNotes));
  fGLAccountID:= 0;
    Bankdeposit :=TBankDeposit.create(self);
    Bankdeposit.connection := TMydacDataconnection.create(Bankdeposit);
    Bankdeposit.connection.connection := Self.MyConnection;
    Bankdeposit.SQL := 'Select * from tblBankDeposit';
    Bankdeposit.confirmFromGUI := InvalidTotalHandler;
    Bankdeposit.IsDepositEntry := true;
  inherited;
  tblMaster.Connection := MyConnection;
  tblDetails.Connection := MyConnection;
  MyConnection.Connected := true;

  cboAccount.Options := cboAccount.Options + [lotitles];
  cboAccount.Selected.Clear;
  cboAccount.Selected.Add(SelectedText('AccountName' , 'Account name', AppEnv.companyprefs.AccountNamecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Type'        , 'Type'        , AppEnv.companyprefs.AccountTypecolumnDropdownWidth        , ''));
  cboAccount.Selected.Add(SelectedText('Description' , 'Description' , AppEnv.companyprefs.AccountDescriptioncolumnDropdownWidth , ''));


  cboAccountline.Options := cboAccount.Options + [lotitles];
  cboAccountline.Selected.Clear;
  cboAccountline.Selected.Add(SelectedText('AccountName' , 'Account name', AppEnv.companyprefs.AccountNamecolumnDropdownWidth        , ''));
  cboAccountline.Selected.Add(SelectedText('Type'        , 'Type'        , AppEnv.companyprefs.AccountTypecolumnDropdownWidth        , ''));
  cboAccountline.Selected.Add(SelectedText('Description' , 'Description' , AppEnv.companyprefs.AccountDescriptioncolumnDropdownWidth , ''));

end;

procedure TDepositEntryGUI.btnPreviewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    BankDeposit.BankDepositTotal := tblMaster.FieldByName('Deposit').AsFloat;
    if BankDeposit.Save then begin
       BankDeposit.connection.CommitTransaction;
       Print(BankDeposit.ID, false);
       Notify(false);
       if fsModal in FormState then
         ModalResult:= mrOK
       else
         Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TDepositEntryGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TBankDeposit then TBankDeposit(Sender).Dataset                 := tblMaster
        else if Sender is TBankDepositLines then TBankDepositLines(Sender).Dataset  := tblDetails;
    end;
end;

procedure TDepositEntryGUI.Print(ID: integer; Print: boolean);
var
  sSQL: string;
begin
  sSQL := Format(' WHERE tblBankDeposit.DepositID = %d', [ID]);
  PrintTemplateReport('TDepositEntryGUI', sSQL, Print, 1);
end;

procedure TDepositEntryGUI.btnPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
     BankDeposit.BankDepositTotal := strValue(txtDepositAmount.text);
    if BankDeposit.Save then begin
       BankDeposit.connection.CommitTransaction;
       Print(BankDeposit.ID, true);
       Notify(false);
       if fsModal in FormState then
         ModalResult:= mrOK
       else
         Close;
    end;
  finally
    EnableForm;
  end;  
end;

// Adds date / time to notes when user leaves the memo.
procedure TDepositEntryGUI.NotesExit(Sender: TObject);
begin
  inherited;
    if (AccessLevel = 1) then begin
      EditDb(tblMaster);
      //Notes.text := AddDateTime(lcdOnDepositEntryNotes, Notes.text , false);
      AddDateTime(lcdOnDepositEntryNotes, Notes , false);
    end;
end;
procedure TDepositEntryGUI.btnAddDateClick(Sender: TObject);
begin
  inherited;
    if (AccessLevel = 1) then begin
      EditDb(tblMaster);
      //Notes.text := AddDateTime(lcdOnLoganyway , Notes.text , false);
      AddDateTime(lcdOnLoganyway , Notes , false);
    end;
end;

// Remove date / time if they are present.
procedure TDepositEntryGUI.NotesEnter(Sender: TObject);
begin
  inherited;
  if (AccessLevel = 1) then begin
    EditDb(tblMaster);
    with Notes do Lines.Strings[Lines.Count - 1] := StripDateTime(Lines.Strings[Lines.Count - 1]);
  end;
end;

procedure TDepositEntryGUI.btnReconciledClick(Sender: TObject);
begin
  inherited;
  PaymentsLibGUI.ShowReconciledListForm(Bankdeposit.ID, 'Deposit Entry');
end;

procedure TDepositEntryGUI.CalculatorF81Click(Sender: TObject);
begin
  inherited;
  doCalculate;
end;
function TDepositEntryGUI.doCalculate:Boolean;
var
  fd:double;fs:String;
  ActiveField: TField;
begin
  Result:= False;
  ActiveField := grdTransactions.GetActiveField;
  if not Assigned(ActiveField)        then exit;
  if not(ActiveField is TFloatfield ) then Exit;
  if ActiveField.readonly             then Exit;
  if Accesslevel >3                   then exit;
  DoCalc(fd , fs);
  result := True;
  if fd=0 then exit;
  BankDeposit.lines.editdb;
  ActiveField.asFloat := fd;
  BankDeposit.lines.PostDB;
end;

procedure TDepositEntryGUI.tblDetailsAfterDelete(DataSet: TDataSet);
begin
  inherited;
  txtDeposited.Caption := DoubleToCurrString(Bankdeposit.Totalamount);
end;

procedure TDepositEntryGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then exit;

  CanClose:= false;
  if BankDeposit.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes,mbNo,mbCancel], 0) of
      mrYes :begin
                if BankDeposit.Save then begin
                    BankDeposit.connection.CommitTransaction;
                    Notify(false);
                    CanClose:= true;
                end;
             end;
      mrNo  :begin
                RollbackTransaction;
                BankDeposit.Dirty:= false;
                CanClose:= true;
             end;
      mrCancel : begin
                CanClose:= false;
                btnClose.Enabled := True;
             end;
      end;
  end  else begin
    CanClose:= true;
  end;

end;

procedure TDepositEntryGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    inherited;
    BankDeposit.BankDepositTotal := strValue(txtDepositAmount.text);
    if not BankDeposit.Save then Exit;
    BankDeposit.connection.CommitTransaction;
    Notify(false);
  finally
    EnableForm;
  end;
  NewDepositEntry;  
end;

procedure TDepositEntryGUI.NewDepositEntry;
begin
  BankDeposit.connection.BeginTransaction;
  BankDeposit.new;
  BankDeposit.PostDB;
  BankDeposit.Lines;

  btnReconciled.Visible := BankDeposit.IsDepositEntryLocked in [ltReconciled,ltOnHoldRec];
  btnReconciled.Enabled := not(Self.owner.ClassName = 'TReconciliationGUI');

  txtDeposited.Caption := DoubleToCurrString(0.00);
  Label11.Visible := false;
  chkDeleted.Visible := false;

  txtDeposited.Caption := DoubleToCurrString(Bankdeposit.Totalamount);

  Label11.Enabled := not btnReconciled.Visible;
  chkDeleted.Enabled := not btnReconciled.Visible;
end;

initialization
  RegisterClassOnce(TDepositEntryGUI);
  with FormFact do begin
    RegisterMe(TDepositEntryGUI, 'TBankAccountListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TTransactionListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TBASTransReturnListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TNZTransReturnListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TVATTransReturnListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TGlobalsearchGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TBalTransListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TToBeReconciledGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TReconListDetailFormGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TTrialBalTransListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TTransactionListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TBASTransReturnListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TNZTransReturnListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TVATTransReturnListGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TGlobalsearchGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TGeneralLedgerReportGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TTransAccountDetailsGUI_*_Deposit Entry=PaymentID');
    RegisterMe(TDepositEntryGUI, 'TDepositedListGUI_*_Deposit Entry=DepositID');
    RegisterMe(TDepositEntryGUI, 'TCustPaymentDepositListGUI_*_Deposit Entry=DepositID');
    RegisterMe(TDepositEntryGUI, 'TAllTransactionGUI_*_Deposit Entry=TransNo');
  end;
end.
