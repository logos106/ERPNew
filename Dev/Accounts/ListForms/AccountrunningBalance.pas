unit AccountrunningBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, BaseListingForm, TransAccountDetailsForm, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TAccountrunningBalanceGUI = class(TBaseListingGUI)
    pnlIgnoreSummarised: TDNMPanel;
    Label2: TLabel;
    chkIgnoreSummarised: TwwCheckBox;
    qryMainSeqNo: TLargeintField;
    qryMainAccountID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainAccountType: TWideStringField;
    qryMainAccountNumber: TWideStringField;
    qryMainDate: TDateField;
    qryMainType: TWideStringField;
    qryMainOpeningBalanceEx: TFloatField;
    qryMainOpeningBalanceInc: TFloatField;
    qryMainClosingBalanceEx: TFloatField;
    qryMainClosingBalanceInc: TFloatField;
    qryMainTotalDebitEx: TFloatField;
    qryMainTotalDebitInc: TFloatField;
    qryMainTotalCreditEx: TFloatField;
    qryMainTotalCreditInc: TFloatField;
    qryMainBalance: TFloatField;
    grpFilters2: TwwRadioGroup;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure chkIgnoreSummarisedClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFilters2Click(Sender: TObject);
  private
    tablename:String;
//    procedure CreateTempTable;
    procedure DrillDownamountDetails;
    procedure InitTransAccountDetails(Sender: TObject);
    procedure MakeSQL;
  Protected
//    procedure PopulateReportTable;Override;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery; Override;

  end;

implementation

uses
  CommonDbLib, MySQLConst, CommonLib,  CommonFormLib,
  AccountRunningBalanceSQL;

{$R *.dfm}

{ TAccountrunningBalanceGUI }

procedure TAccountrunningBalanceGUI.chkIgnoreSummarisedClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol =  chkIgnoreSummarised then
    RefreshQuery;
end;

(*
procedure TAccountrunningBalanceGUI.CreateTempTable;
begin
  inherited;
  tablename := GetUserTemporaryTableName('AccountRunningbalance');
  With TempMyScript do try
    SQL.add('Drop table if exists ' + tablename+';');
    SQL.add('CREATE TABLE  ' + tablename+' (');
    SQL.add('	ID                INT(10)       NOT NULL AUTO_INCREMENT,');
    SQL.add('	AccountID         INT(10)       NULL DEFAULT 0,');
    SQL.add('	AccountName       VARCHAR(100)  NULL DEFAULT 0,');
    SQL.add('	Accounttype       VARCHAR(100)  NULL DEFAULT 0,');
    SQL.add('	AccountNumber     VARCHAR(50)  NULL DEFAULT NULL,');
    SQL.add('	OpeningBalanceEx  DOUBLE        NULL DEFAULT 0,');
    SQL.add('	OpeningBalanceInc DOUBLE        NULL DEFAULT 0,');
    SQL.add('	TotalDebitex      DOUBLE        NULL DEFAULT 0,');
    SQL.add('	TotalCreditex     DOUBLE        NULL DEFAULT 0,');
    SQL.add('	TotalDebitinc     DOUBLE        NULL DEFAULT 0,');
    SQL.add('	TotalCreditinc    DOUBLE        NULL DEFAULT 0,');
    SQL.add('	ClosingBalanceEx  DOUBLE        NULL DEFAULT 0,');
    SQL.add('	ClosingBalanceInc DOUBLE        NULL DEFAULT 0,');
    SQL.add('	Balance           DOUBLE        NULL DEFAULT 0,');
    SQL.add('	Active Enum("T","F") default "F",');
    SQL.add('	PRIMARY KEY (ID), 	INDEX AccountID (AccountID))');
    SQL.add('COLLATE=''utf8_general_ci''');
    SQL.add('ENGINE=MyISAM;');


    Execute;
  finally
    Free;
  end;
  Qrymain.SQL.clear;
  Qrymain.SQL.text :='Select * from ' +tablename;
end;
*)

procedure TAccountrunningBalanceGUI.FormCreate(Sender: TObject);
begin
//  CreateTempTable;
  inherited;
end;

procedure TAccountrunningBalanceGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  DestroyUserTemporaryTable(Tablename+'_All');
  inherited;

end;

procedure TAccountrunningBalanceGUI.FormShow(Sender: TObject);
begin
  GuiPrefs.Active := True;
  GuiPrefs.AddFieldPair(QrymainOpeningBalanceInc.fieldname  ,QrymainOpeningBalanceEx.fieldname  , Qrymain);
  GuiPrefs.AddFieldPair(QrymainTotalDebitinc.FieldName      ,QrymainTotalDebitEx.FieldName      , Qrymain);
  GuiPrefs.AddFieldPair(QrymainTotalCreditinc.FieldName     ,QrymainTotalCreditEx.FieldName     , Qrymain);
  GuiPrefs.AddFieldPair(QrymainClosingBalanceInc.FieldName  ,QrymainClosingBalanceEx.FieldName  , Qrymain);
  grpFilters.ItemIndex := 2;
  inherited;
end;

procedure TAccountrunningBalanceGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainSeqNo.AsInteger = 1 then
    AFont.Style := AFont.Style + [fsBold];

end;

procedure TAccountrunningBalanceGUI.grdMainCalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  inherited;
  if (Qrymain.FindField(afieldname) is TFloatfield) and TFloatfield(Qrymain.FindField(afieldname)).currency then
      ATitleAlignment :=tacenter;
end;

procedure TAccountrunningBalanceGUI.grdMainDblClick(Sender: TObject);
begin
  if (Qrymain.FindField(ActiveFieldName) is TFloatfield) and TFloatfield(Qrymain.FindField(ActiveFieldName)).currency and (Qrymain.FindField(ActiveFieldName).asFloat <>0) then
    DrillDownamountDetails
  else inherited;
end;

procedure TAccountrunningBalanceGUI.grpFilters2Click(Sender: TObject);
begin
  if grpFilters2.ItemIndex = 0 then begin
    { summary }
    FilterString := 'SeqNo = 1'
  end
  else if grpFilters2.ItemIndex = 1 then begin
    { detail }
    FilterString := ''
  end
  else begin
    { summary }
    FilterString := 'SeqNo = 1'
  end;
  inherited;
end;

procedure TAccountrunningBalanceGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  if grpfilters.Itemindex < 0 then
    grpfilters.Itemindex := 0;
  if grpfilters.Itemindex = 0 then begin
        GuiPrefs.SwapPairdfield(QrymainOpeningBalanceInc.fieldname  ,QrymainOpeningBalanceEx.fieldname  );
        GuiPrefs.SwapPairdfield(QrymainTotalDebitinc.FieldName      ,QrymainTotalDebitEx.FieldName      );
        GuiPrefs.SwapPairdfield(QrymainTotalCreditinc.FieldName     ,QrymainTotalCreditEx.FieldName     );
        GuiPrefs.SwapPairdfield(QrymainClosingBalanceInc.FieldName  ,QrymainClosingBalanceEx.FieldName  );
  end else if grpfilters.Itemindex =1 then begin
        GuiPrefs.SwapPairdfield(QrymainOpeningBalanceEx.fieldname   ,QrymainOpeningBalanceInc.fieldname );
        GuiPrefs.SwapPairdfield(QrymainTotalDebitEx.FieldName       ,QrymainTotalDebitInc.FieldName     );
        GuiPrefs.SwapPairdfield(QrymainTotalCreditEx.FieldName      ,QrymainTotalCreditInc.FieldName    );
        GuiPrefs.SwapPairdfield(QrymainClosingBalanceEx.FieldName   ,QrymainClosingBalanceInc.FieldName );
  end else if grpfilters.Itemindex =2 then begin
        GuiPrefs.AddFieldstogether(QrymainOpeningBalanceEx.fieldname,QrymainOpeningBalanceInc.fieldname );
        GuiPrefs.AddFieldstogether(QrymainTotalDebitEx.FieldName    ,QrymainTotalDebitInc.FieldName     );
        GuiPrefs.AddFieldstogether(QrymainTotalCreditEx.FieldName   ,QrymainTotalCreditInc.FieldName    );
        GuiPrefs.AddFieldstogether(QrymainClosingBalanceEx.FieldName,QrymainClosingBalanceInc.FieldName );
  end;
end;

Procedure TAccountrunningBalanceGUI.InitTransAccountDetails(Sender:TObject);
begin
  if not(Sender is TTransAccountDetailsGUI) then exit;
  if Sametext(ActiveFieldname , QrymainOpeningbalanceEx.FieldName) or
     Sametext(ActiveFieldname , QrymainOpeningbalanceInc.FieldName) then begin
      TTransAccountDetailsGUI(Sender).ToDate    := filterDateFrom;
      TTransAccountDetailsGUI(Sender).FromDate  := 0;
  end else   if Sametext(ActiveFieldname , QrymainclosingbalanceEx.FieldName) or
     Sametext(ActiveFieldname , QrymainClosingbalanceInc.FieldName) then begin
      TTransAccountDetailsGUI(Sender).ToDate    := filterDateto;
      TTransAccountDetailsGUI(Sender).FromDate  := 0;
  end else begin
      TTransAccountDetailsGUI(Sender).ToDate    := filterDateto;
      TTransAccountDetailsGUI(Sender).FromDate  := FilterDateFrom;
  end;
  TTransAccountDetailsGUI(Sender).qryMain.SQL.Add('AND AccountID = ' + qryMainAccountID.AsString + ' Group by TransID;');
  TTransAccountDetailsGUI(Sender).WhereString := 'AND (AccountID = ' + qryMainAccountID.AsString + ' )';
  TTransAccountDetailsGUI(Sender).chkIncludehistory.Checked := self.chkIgnoreSummarised.Checked;
end;

procedure TAccountrunningBalanceGUI.MakeSQL;
var
//  sl: TStringList;
//  dFromStr, dToStr: string;
  AccountRunningBalanceReport: TAccountRunningBalanceReport;
  msg: string;
begin
  AccountRunningBalanceReport := TAccountRunningBalanceReport.Create;
  try
    AccountRunningBalanceReport.DateFrom := FilterDateFrom;
    AccountRunningBalanceReport.DateTo := FilterDateTo;
    AccountRunningBalanceReport.IgnoreSummarised := chkIgnoreSummarised.Checked;
    if not AccountRunningBalanceReport.PopulateReportSQL(qryMain.SQL,msg) then begin
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    end;
    self.RefreshOrignalSQL();
  finally
    AccountRunningBalanceReport.Free;
  end;


(*
  dFromStr := Quotedstr(Formatdatetime(mysqlDateTimeFormat, FilterDateFrom));
  dToStr := Quotedstr(Formatdatetime(mysqlDateTimeFormat, FilterDateTo));
  sl := TStringList.Create;
  try
    sl.Add('select 2 as SeqNo, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Date, Type,');
    sl.Add('Null as OpeningBalanceEx,');
    sl.Add('Null as OpeningBalanceInc,');
    sl.Add('Null as ClosingBalanceEx,');
    sl.Add('Null as ClosingBalanceInc,');
    sl.Add('DebitsEx as TotalDebitEx,');
    sl.Add('DebitsInc as TotalDebitInc,');
    sl.Add('CreditsEx as TotalCreditEx,');
    sl.Add('CreditsInc as TotalCreditInc,');
    sl.Add('If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx) as Balance');
    sl.Add('from tbltransactions as Trans');
    sl.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
    sl.Add('where Trans.Date between ' + dFromStr + ' and ' + dToStr);
    if not chkIgnoreSummarised.Checked then begin
      sl.Add('union all');
      sl.Add('select 2 as SeqNo, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Date, Type,');
      sl.Add('Null as OpeningBalanceEx,');
      sl.Add('Null as OpeningBalanceInc,');
      sl.Add('Null as ClosingBalanceEx,');
      sl.Add('Null as ClosingBalanceInc,');
      sl.Add('DebitsEx as TotalDebitEx,');
      sl.Add('DebitsInc as TotalDebitInc,');
      sl.Add('CreditsEx as TotalCreditEx,');
      sl.Add('CreditsInc as TotalCreditInc,');
      sl.Add('If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx) as Balance');
      sl.Add('from tbltransactionsummarydetails as Trans');
      sl.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
      sl.Add('where Trans.Date between ' + dFromStr + ' and ' + dToStr);
    end;
    sl.Add('union all');

    sl.Add('select SeqNo, AccountID, AccountName, AccountType, AccountNumber, Date, Type,');
    sl.Add('Sum(OpeningBalanceEx) as OpeningBalanceEx,');
    sl.Add('Sum(OpeningBalanceInc) as OpeningBalanceInc,');
    sl.Add('Sum(ClosingBalanceEx) as ClosingBalanceEx,');
    sl.Add('Sum(ClosingBalanceInc) as ClosingBalanceInc,');
    sl.Add('Sum(TotalDebitEx) as TotalDebitEx,');
    sl.Add('Sum(TotalDebitInc) as TotalDebitInc,');
    sl.Add('Sum(TotalCreditEx) as TotalCreditEx,');
    sl.Add('Sum(TotalCreditInc) as TotalCreditInc,');
    sl.Add('Sum(Balance) as Balance');
    sl.Add('from ( ');
    sl.Add('select 1 as SeqNo, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Cast(0 as DATE) as Date, Null as Type,');
    sl.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as OpeningBalanceEx,');
    sl.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as OpeningBalanceInc,');
    sl.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as ClosingBalanceEx,');
    sl.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as ClosingBalanceInc,');
    sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsEx, 0.0) as TotalDebitEx,');
    sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsInc, 0.0) as TotalDebitInc,');
    sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsEx, 0.0) as TotalCreditEx,');
    sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsInc, 0.0) as TotalCreditInc,');
    sl.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as Balance');
    sl.Add('from tbltransactions as Trans');
    sl.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
    if not chkIgnoreSummarised.Checked then begin
      sl.Add('union all');
      sl.Add('select 1 as SeqNo, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Cast(0 as DATE) as Date, Null as Type,');
      sl.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as OpeningBalanceEx,');
      sl.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as OpeningBalanceInc,');
      sl.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as ClosingBalanceEx,');
      sl.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as ClosingBalanceInc,');
      sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsEx, 0.0) as TotalDebitEx,');
      sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsInc, 0.0) as TotalDebitInc,');
      sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsEx, 0.0) as TotalCreditEx,');
      sl.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsInc, 0.0) as TotalCreditInc,');
      sl.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as Balance');
      sl.Add('from tbltransactionsummarydetails as Trans');
      sl.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
    end;
    sl.Add(') as T Group By T.AccountID');
    sl.Add('Order By AccountName, SeqNo, Date');
    qryMain.SQL.Assign(sl);
    self.RefreshOrignalSQL();
  finally
    sl.Free;
  end;
*)
end;

Procedure TAccountrunningBalanceGUI.DrillDownamountDetails;
begin
  OpenERPListForm('TTransAccountDetailsGUI' , InitTransAccountDetails);
end;

(*
procedure TAccountrunningBalanceGUI.PopulateReportTable;
var
  st:TStringlist;
begin
  inherited;
  ST:= TStringlist.Create;
  try
    ST.add('truncate table ' + tablename +';');
    ST.add('insert into ' + tablename +' (AccountID, AccountName,AccountType,AccountNumber, ACtive ) Select Distinct AccountID, accountname, AccountType, AccountNumber, Active from tblchartofaccounts;');
    ST.add('Drop table if exists ' + tablename +'_All;');
    ST.add('Create table  ' + tablename +'_All');
	  ST.add('SELECT 1 as Seqno, Date ,AccountID , ifnull(DebitsEx,0) as  DebitsEx, ifnull(CreditsEx,0) as  CreditsEx, ifnull(DebitsInc,0) as  DebitsInc, ifnull(CreditsInc,0) as CreditsInc FROM tblTransactions               Trans  ');
    if chkIgnoreSummarised.Checked then
      ST.Add('where Type <> "Closing Date Summary"');
    ST.add('UNION ALL ');
    ST.add('SELECT 2 as Seqno, Date ,AccountID , ifnull(DebitsEx,0) as  DebitsEx, ifnull(CreditsEx,0) as  CreditsEx, ifnull(DebitsInc,0) as  DebitsInc, ifnull(CreditsInc,0) as CreditsInc FROM tbltransactionsummarydetails  Trans  ;');
    ST.add(' ALTER TABLE ' + tablename +'_All 	ADD COLUMN `ID` INT NOT NULL AUTO_INCREMENT FIRST, 	ADD PRIMARY KEY (`ID`), 	ADD INDEX `Date` (`Date`),    	ADD INDEX `AccountID` (`AccountID`);');
    ST.add('Update ' +Tablename +' T  Set  OpeningBalanceEx  = (Select  If(AccountType="CCARD" OR AccountType = "EQUITY" OR AccountType = "INC"  OR AccountType = "OCLIAB",Sum(CreditsEx-DebitsEx),Sum(DebitsEx-CreditsEx))     from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date <  ' + Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateFrom))+');');
    ST.add('Update ' +Tablename +' T  Set  OpeningBalanceInc = (Select  If(AccountType="CCARD" OR AccountType = "EQUITY" OR AccountType = "INC"  OR AccountType = "OCLIAB",Sum(CreditsInc-DebitsInc),Sum(DebitsInc-CreditsInc)) from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date <  ' + Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateFrom))+');');
    ST.add('Update ' +Tablename +' T  Set  ClosingBalanceEx  = (Select  If(AccountType="CCARD" OR AccountType = "EQUITY" OR AccountType = "INC"  OR AccountType = "OCLIAB",Sum(CreditsEx-DebitsEx),Sum(DebitsEx-CreditsEx))     from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date <= ' + Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateTo  ))+');');
    ST.add('Update ' +Tablename +' T  Set  ClosingBalanceInc = (Select  If(AccountType="CCARD" OR AccountType = "EQUITY" OR AccountType = "INC"  OR AccountType = "OCLIAB",Sum(CreditsInc-DebitsInc),Sum(DebitsInc-CreditsInc)) from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date <= ' + Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateTo  ))+');');
    ST.add('Update ' +Tablename +' T  Set  TotalDebitex  = (Select  Sum(DebitsEx)   from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date >= ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateFrom))+' and Date < ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateTo)) +');');
    ST.add('Update ' +Tablename +' T  Set  TotalDebitInc = (Select  Sum(DebitsInc)  from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date >= ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateFrom))+' and Date < ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateTo)) +');');
    ST.add('Update ' +Tablename +' T  Set  TotalCreditex = (Select  Sum(CreditsEx)  from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date >= ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateFrom))+' and Date < ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateTo)) +');');
    ST.add('Update ' +Tablename +' T  Set  TotalCreditInc= (Select  Sum(CreditsInc) from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date >= ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateFrom))+' and Date < ' +Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateTo)) +');');
    ST.add('Update ' +Tablename +' T  Set  Balance = (Select If(AccountType="CCARD" OR AccountType = "EQUITY" OR AccountType = "INC"  OR AccountType = "OCLIAB",Sum(CreditsEx-DebitsEx),Sum(DebitsEx-CreditsEx))   from ' + tablename +'_All T_All where  T.accountId = T_All.accountID   and Date <= ' + Quotedstr(Formatdatetime(mysqlDateTimeFormat , FilterDateTo  ))+');');
    ExecuteSQLwithProgress(St.text);
  finally
    FreeandNil(ST);
  end;
end;
*)

procedure TAccountrunningBalanceGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  grpFilters2.ItemIndex := GuiPrefs.Node['grpFilters2.ItemIndex'].asInteger;
end;

procedure TAccountrunningBalanceGUI.RefreshQuery;
begin
  //PopulateReportTable;
  qryMain.Close;
  MakeSQL;
  inherited;
end;

procedure TAccountrunningBalanceGUI.SetGridColumns;
begin
  inherited;
  //RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainAccountID.fieldname);
  if not devmode then
    RemoveFieldfromGrid(qryMainBalance.fieldname); // field for tesing only

end;

procedure TAccountrunningBalanceGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpFilters2.ItemIndex'].asInteger := grpFilters2.ItemIndex;
end;

initialization
  RegisterClassOnce(TAccountrunningBalanceGUI);

end.

