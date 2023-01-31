unit frmSelectAccountsForReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls,
  Shader, DNMPanel, frmSelectAccountsForReportsAccount, Grids, Wwdbigrd,
  Wwdbgrid, MemDS, AccountsSelectedForReports, BusObjBase, DNMSpeedButton, Mask,
  wwdbedit, Buttons, ProgressDialog;

type
  TfmSelectAccountsforReports = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlBottom: TDNMPanel;
    qryExpAccount: TERPQuery;
    qryIncomeAccount: TERPQuery;
    qryCOGSAccount: TERPQuery;
    pnldetails: TDNMPanel;
    pnlExp: TDNMPanel;
    pnlCogs: TDNMPanel;
    pnlIncome: TDNMPanel;
    qryExpAccountGlobalref: TWideStringField;
    qryExpAccountID: TIntegerField;
    qryExpAccountAccounttypeID: TIntegerField;
    qryExpAccountAccountType: TWideStringField;
    qryExpAccountAccountId: TIntegerField;
    qryExpAccountAccountname: TWideStringField;
    qryCOGSAccountGlobalref: TWideStringField;
    qryCOGSAccountID: TIntegerField;
    qryCOGSAccountAccounttypeID: TIntegerField;
    qryCOGSAccountAccountType: TWideStringField;
    qryCOGSAccountAccountId: TIntegerField;
    qryCOGSAccountAccountname: TWideStringField;
    qryIncomeAccountGlobalref: TWideStringField;
    qryIncomeAccountID: TIntegerField;
    qryIncomeAccountAccounttypeID: TIntegerField;
    qryIncomeAccountAccountType: TWideStringField;
    qryIncomeAccountAccountId: TIntegerField;
    qryIncomeAccountAccountname: TWideStringField;
    dsExpAccount: TDataSource;
    dsCOGSAccount: TDataSource;
    dsIncomeAccount: TDataSource;
    QryCompanyInfo: TERPQuery;
    dsCompanyInfo: TDataSource;
    QryCompanyInfoIncomeBudget: TFloatField;
    QryCompanyInfoCOGSBudget: TFloatField;
    QryCompanyInfoExpenseBudget: TFloatField;
    b1: TBevel;
    b2: TBevel;
    b5: TBevel;
    grdExp: TwwDBGrid;
    grdcogs: TwwDBGrid;
    grdincome: TwwDBGrid;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    lblIncome: TLabel;
    IncomeBudget: TwwDBEdit;
    cogsbudget: TwwDBEdit;
    expbudget: TwwDBEdit;
    QryCompanyInfoSetUpID: TIntegerField;
    b4: TBevel;
    b3: TBevel;
    pnlAsset: TDNMPanel;
    grdAsset: TwwDBGrid;
    pnlLiability: TDNMPanel;
    grdLiability: TwwDBGrid;
    Label4: TLabel;
    Label5: TLabel;
    QryAssetAccount: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField3: TWideStringField;
    IntegerField3: TIntegerField;
    dsAssetAccount: TDataSource;
    qryLiabilityAccount: TERPQuery;
    StringField4: TWideStringField;
    StringField5: TWideStringField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField6: TWideStringField;
    IntegerField6: TIntegerField;
    dsLiabilityAccount: TDataSource;
    assetBudget: TwwDBEdit;
    liabilitybudget: TwwDBEdit;
    QryCompanyInfoAssetBudget: TFloatField;
    QryCompanyInfoLiabilitybudget: TFloatField;
    cmdCancel: TDNMSpeedButton;
    cmdsave: TDNMSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    grdincomeIButton: TwwIButton;
    grdcogsIButton: TwwIButton;
    grdExpIButton: TwwIButton;
    grdAssetIButton: TwwIButton;
    grdLiabilityIButton: TwwIButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdExpDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    incomeaccounts , ExpenseAccounts,COGSAccounts, assetAccounts,LiabilityAccounts  :TfmSelectAccountsForReportsAccount;

    incomeaccount   :TIncomeConfigAccounts;
    ExpenseAccount  :TExpenseConfigAccounts;
    COGSAccount     :TCOGSConfigAccounts ;
    assetAccount    :TAssetConfigAccounts;
    LiabilityAccount:TLiabilityConfigAccounts;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
  end;

implementation

uses CommonLib, BaseFormForm;

{$R *.dfm}
procedure TfmSelectAccountsforReports.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
       if sender is TIncomeConfigAccounts     then TIncomeConfigAccounts(Sender).dataset    := qryIncomeAccount
  else if sender is TExpenseConfigAccounts    then TExpenseConfigAccounts(Sender).dataset   := qryExpAccount
  else if sender is TCOGSConfigAccounts       then TCOGSConfigAccounts(Sender).dataset      := qryCOGSAccount
  else if sender is TLiabilityConfigAccounts  then TLiabilityConfigAccounts(Sender).dataset := qryLiabilityAccount
  else if sender is TAssetConfigAccounts      then TAssetConfigAccounts(Sender).dataset     := QryAssetAccount;
end;

procedure TfmSelectAccountsforReports.FormCreate(Sender: TObject);
  Function newconfigform(AParent:TDnmPanel ; AccountObj : TSelectedAccountsforReports; fsaccounttype:STring):TfmSelectAccountsforReportsAccount;
  begin
    result                    := TfmSelectAccountsforReportsAccount.instanceforAccountType(fsaccounttype , nil);
    result.Tree.Parent := AParent;
    (*result.Align              := alClient;
    result.visible            := True;*)
    result.SelectedAccounts   := AccountObj ;;
    result.Qryacc.connection  := MyConnection;
    result.RefreshTree;
  end;
  function  NewconfigObj(Classtype :TPersistentClass):TSelectedAccountsforReports;
  begin
    REsult := TSelectedAccountsforReports(getcomponentbyClasstype(ClassType, true , Self));
    result.busobjevent := DoBusinessObjectEvent;
    result.connection  := TMyDacDataConnection.create(result) ;
    result.connection.connection  := MyConnection;
  end;
begin
  inherited;
  fbTabSettingEnabled := False;
  incomeaccount     := TIncomeConfigAccounts(NewconfigObj(TIncomeConfigAccounts));
  ExpenseAccount    := TExpenseConfigAccounts(NewconfigObj(TExpenseConfigAccounts));
  COGSAccount       := TCOGSConfigAccounts(NewconfigObj(TCOGSConfigAccounts));
  assetAccount      := TAssetConfigAccounts(NewconfigObj(TAssetConfigAccounts));
  LiabilityAccount  := TLiabilityConfigAccounts(NewconfigObj(TLiabilityConfigAccounts));

  incomeaccount.name    := 'incomeaccount';
  ExpenseAccount.name   := 'ExpenseAccount';
  COGSAccount.name      := 'COGSAccount';
  assetAccount.name     := 'assetAccount';
  LiabilityAccount.name := 'LiabilityAccount';

  incomeaccounts    := newconfigform(pnlIncome    , incomeAccount     , QuotedStr('INC'));
  ExpenseAccounts   := newconfigform(pnlExp       , ExpenseAccount    , QuotedStr('EXP'));
  COGSAccounts      := newconfigform(pnlCogs      , COGSAccount       , QuotedStr('COGS'));
  assetAccounts     := newconfigform(pnlAsset     , assetAccount      , Quotedstr('FIXASSET')+',' +Quotedstr('OCASSET')+',' +Quotedstr('EQUITY')+',' +Quotedstr('OASSET'));
  LiabilityAccounts := newconfigform(pnlLiability , LiabilityAccount  , Quotedstr('OCLIAB')+',' +Quotedstr('LTLIAB')+',' +Quotedstr('CCARD'));

end;

procedure TfmSelectAccountsforReports.FormDestroy(Sender: TObject);
begin
  UserLock.UnLock('tblcompanyinformation' , QryCompanyInfoSetUpID.asInteger , 'AccountBudgetforReport');

  incomeaccounts.Parent := nil;
  ExpenseAccounts.Parent := nil;
  COGSAccounts.Parent := nil;
  AssetAccounts.Parent := nil;
  LiabilityAccounts.Parent := nil;

  CloseDB(incomeaccounts.Qryacc);
  CloseDB(ExpenseAccounts.Qryacc);
  CloseDB(COGSAccounts.Qryacc);
  CloseDB(AssetAccounts.Qryacc);
  CloseDB(LiabilityAccounts.Qryacc);

  incomeaccounts.Qryacc.connection := nil;
  ExpenseAccounts.Qryacc.connection := nil;
  COGSAccounts.Qryacc.connection := nil;
  AssetAccounts.Qryacc.connection := nil;
  LiabilityAccounts.Qryacc.connection := nil;

  incomeaccounts.SelectedAccounts:= nil;
  ExpenseAccounts.SelectedAccounts:= nil;
  COGSAccounts.SelectedAccounts:= nil;
  assetAccounts.SelectedAccounts:= nil;
  LiabilityAccounts.SelectedAccounts:= nil;

  Freeandnil(incomeaccounts);
  Freeandnil(ExpenseAccounts);
  Freeandnil(COGSAccounts);
  Freeandnil(assetAccounts);
  Freeandnil(LiabilityAccounts);

  Freeandnil(incomeaccount);
  Freeandnil(ExpenseAccount);
  Freeandnil(COGSAccount);
  Freeandnil(assetAccount);
  Freeandnil(LiabilityAccount);


  inherited;
end;

procedure TfmSelectAccountsforReports.grdExpDblClick(Sender: TObject);
var
  s:String;
begin
  inherited;
    {for the indicator buttons }
    if sender is TwwIButton then
      if TwwIButton(Sender).parent is TwwDBGrid then
        Sender :=TwwDBGrid(TwwIButton(Sender).parent);

    if sender is TwwDBGrid then begin
      if TwwDBGrid(Sender).datasource.Dataset.recordcount = 0 then exit;
      s:= 'Do you wish to remove ' + TwwDBGrid(Sender).datasource.Dataset.fieldByname('Accountname').asString +'?';
      if CommonLib.MessageDlgXP_Vista(s , mtConfirmation , [mbYes, mbNo] , 0) = mrYes then begin

      TwwDBGrid(Sender).datasource.Dataset.Delete;
      TwwDBGrid(Sender).refresh;
           if Sender = grdExp       then ExpenseAccounts.refreshTree
      else if sender = grdcogs      then COGSAccounts.refreshtree
      else if sender = grdAsset     then assetAccounts.refreshtree
      else if sender = grdincome    then incomeaccounts.refreshtree
      else if sender = grdLiability then LiabilityAccounts.refreshtree;
    end;
  end;
end;

procedure TfmSelectAccountsforReports.FormShow(Sender: TObject);
var
  companyinfoLocked:Boolean;
begin
  inherited;
  incomeaccount.Load;
  ExpenseAccount.Load;
  COGSAccount.Load;
  assetAccount.Load;
  LiabilityAccount.Load;
  opendb(QryCompanyInfo);
  companyinfoLocked:= UserLock.Lock('tblcompanyinformation' , QryCompanyInfoSetUpID.asInteger , 'AccountBudgetforReport');
  liabilitybudget.Readonly := not (companyinfoLocked);
  assetBudget.Readonly     := not (companyinfoLocked);
  cogsbudget.Readonly      := not (companyinfoLocked);
  expbudget.Readonly       := not (companyinfoLocked);
  IncomeBudget.Readonly    := not (companyinfoLocked);

  BeginTransaction;
end;

procedure TfmSelectAccountsforReports.cmdSaveClick(Sender: TObject);
begin
  inherited;
  PostDB(QryCompanyInfo);
  incomeaccount.PostDB;
  ExpenseAccount.PostDB;
  COGSAccount.PostDB;
  assetAccount.PostDB;
  LiabilityAccount.PostDB;
  CommitTransaction;
  incomeaccount.dirty   := False;
  ExpenseAccount.dirty  := False;
  COGSAccount.dirty     := False;
  assetAccount.dirty    := False;
  LiabilityAccount.dirty:= False;
  Self.close;
end;

procedure TfmSelectAccountsforReports.cmdCancelClick(Sender: TObject);
begin
  inherited;
  self.close;
end;

procedure TfmSelectAccountsforReports.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ExitResult: Word;
begin
  inherited;
  if (incomeaccount.dirty) or (ExpenseAccount.dirty) or (COGSAccount.dirty) or (assetAccount.dirty) or (LiabilityAccount.dirty)  then begin
    ExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
    case ExitResult of
        mrYes   : CommitTransaction;
        mrNo    : RollbackTransaction;
        mrCancel: CanClose:= False;
    end;
  end;
end;

procedure TfmSelectAccountsforReports.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;


initialization
  RegisterClassOnce(TfmSelectAccountsforReports);
end.


