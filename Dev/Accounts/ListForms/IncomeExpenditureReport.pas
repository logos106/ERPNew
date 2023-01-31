unit IncomeExpenditureReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitandLossPeriodReportBase, kbmMemTable, DB, 
  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  wwdblook, Shader, DNMPanel, AdvOfficeStatusBar, DNMSpeedButton, BusObjBase,
  DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TIncomeandExpenditureGUI = class(TProfitLossPeriodBase)
    cmdconfigure: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdconfigureClick(Sender: TObject);
  private
    //SelectedIDs:String;

  Protected
    (*Procedure ReportDetails; override;*)
    (*Procedure Incomerecords(const Sender: TBusObj;var Abort: boolean);*)
    (*Procedure COGsrecords(const Sender: TBusObj;var Abort: boolean);*)
    (*Procedure Expenserecords(const Sender: TBusObj;var Abort: boolean);*)
    (*Function Othersfilter(Const sSortID:String):String;override;*)
    //Procedure ReportDetailsforTable(TempScript: TERPScript;      xTablename: STring);Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, AccountsSelectedForReports, FastFuncs, AppEnvironment,
  CompanyPrefObj, DNMLib , DateUtils, StrUtils, BaseListingForm, ReportSQLProfitAndLossPeriod;

{$R *.dfm}
procedure TIncomeandExpenditureGUI.FormCreate(Sender: TObject);
begin
  fReportSQLObj := TReportSQLIncomeandExpenditure.Create(Self);
  ReportSQLobj.employeeID := Appenv.Employee.EmployeeID;
  Tablename := ReportSQLObj.Temptablename;// 'tmp_IncomeExp_' + GetMachineIdentification(true, true, true, true);
  inherited;
  SearchMode:= smFullList;
  chkHidePercentage.checked := true;
  reportCaption := 'Income and Expenditure';
  dtFrom.Date := IncDay(AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*));
  dtto.Date := incyear(dtFrom.Date , 1);
  fbDateRangeSupplied := TRue;
end;




(*procedure TIncomeandExpenditureGUI.Incomerecords(const Sender: TBusObj;
  var Abort: boolean);
var
  IDs:String;
begin
     if not (sender is TSelectedAccountsforReports) then exit;
     if Sysutils.SameText(TSelectedAccountsforReports(Sender).Accountname, 'Others') then Exit;
     if TSelectedAccountsforReports(Sender).Accountid = 0 then Exit;
     Ids:=TSelectedAccountsforReports(Sender).AllAccountIds;
     if selectedIDS<> '' then SelectedIDs :=SelectedIDs + ',';
     SelectedIDs :=SelectedIDs + Ids;;
     with fStringListForSQL do begin
      Add('UNION ALL ');Add(AccountSummary('F', '3'   , '"INC"'       , ''                ,QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,QuotedStr(IntToStr(TSelectedAccountsforReports(Sender).AccountId )) , '"EXINC","INC"'                        , QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   , 'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , '' , Ids));
     end;
end;*)
(*procedure TIncomeandExpenditureGUI.COGsrecords(const Sender: TBusObj;
  var Abort: boolean);
var
  IDs:String;
begin
     if not (sender is TSelectedAccountsforReports) then exit;
     if Sysutils.SameText(TSelectedAccountsforReports(Sender).Accountname, 'Others') then Exit;
     if TSelectedAccountsforReports(Sender).Accountid = 0 then Exit;
     Ids:=TSelectedAccountsforReports(Sender).AllAccountIds;
     if selectedIDS<> '' then SelectedIDs :=SelectedIDs + ',';
     SelectedIDs :=SelectedIDs + Ids;;
     with fStringListForSQL do begin
      Add('UNION ALL ');Add(AccountSummary('F', '7'   , '"COGS"'      , ''                ,QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,QuotedStr(IntToStr(TSelectedAccountsforReports(Sender).AccountId )) , '"COGS"'                               , QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , '' , Ids));
     end;
end;*)

(*procedure TIncomeandExpenditureGUI.Expenserecords(const Sender: TBusObj;
  var Abort: boolean);
var
  IDs:String;
begin
     if not (sender is TSelectedAccountsforReports) then exit;
     if Sysutils.SameText(TSelectedAccountsforReports(Sender).Accountname, 'Others') then Exit;
     if TSelectedAccountsforReports(Sender).Accountid = 0 then Exit;
     Ids:=TSelectedAccountsforReports(Sender).AllAccountIds;
     if selectedIDS<> '' then SelectedIDs :=SelectedIDs + ',';
     SelectedIDs :=SelectedIDs + Ids;;
     with fStringListForSQL do begin
      Add('UNION ALL ');Add(AccountSummary('F' , '13'  , 'AccountType' , ''                ,QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,QuotedStr(IntToStr(TSelectedAccountsforReports(Sender).AccountId ))  , '"EXEXP","EXP"  '                      , QuotedStr(TSelectedAccountsforReports(Sender).Accountname)   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , '' , Ids));
     end;
end;*)

(*Procedure TIncomeandExpenditureGUI.ReportDetailsforTable(TempScript :TERPScript; xTablename:STring);
VAR
  IncomeExpenseConfigAccounts:TSelectedAccountsforReports;
  strSQL:String;
begin
strSQL := '';
try
  inherited;
        strSQL := 'insert into ' +xtablename + ' '  + BlankLine(2,'INC', 'Income' )+';';
        selectedIDS := '';
        IncomeExpenseConfigAccounts:= TIncomeConfigAccounts.NewObjInstance;
        Try
          if IncomeExpenseConfigAccounts.count > 0 then begin
            IncomeExpenseConfigAccounts.Iteraterecords(Incomerecords);
            strSQL := strSQL +'insert into ' +xtablename + ' '  + AccountSummary('F', '3.1'   , '"INC"'       , ''                ,'"Others"'   ,'0'    , '"EXINC","INC"'                  , '"INC"'   , 'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' ,  SelectedIDs)+';';
          end else begin
            strSQL := strSQL +'insert into ' +xtablename + ' '  + AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   )+';';
          end;
        finally
          FreeandNil(IncomeExpenseConfigAccounts);
        end;
        strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      )+';';
        strSQL:= strSQL+'insert into ' +xtablename + ' '  +  BlankLine( 6,'COGS', 'Cost of Goods Sold' )+';';
        selectedIDS := '';
        IncomeExpenseConfigAccounts:= TCOGSConfigAccounts.NewObjInstance;
        try
          if IncomeExpenseConfigAccounts.count > 0 then begin
            IncomeExpenseConfigAccounts.Iteraterecords(COGsrecords);
            strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('F'  , '7.1'   , '"COGS"'      , ''                ,'"Others"'   ,'0'    , '"COGS"'                         , '"COGS"'   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' ,  SelectedIDs)+';';
          end else begin
            strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   )+';';
          end;
        finally
          FreeandNil(IncomeExpenseConfigAccounts);
        end;
        strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     )+';';
        strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' )+';';
        strSQL := strSQL+'insert into ' +xtablename + ' '  + BlankLine(12,'EXP', 'Expense' )+';';
        selectedIDS := '';
        IncomeExpenseConfigAccounts := TExpenseConfigAccounts.NewObjInstance;
        try
          if IncomeExpenseConfigAccounts.count > 0 then begin
            IncomeExpenseConfigAccounts.Iteraterecords(Expenserecords);
            strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('F'  , '13.1'  , '"EXP"' , ''                ,'"Others"'   ,'0'    , '"EXEXP","EXP"  '                , '"EXP"'   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , SelectedIDs)+';';
          end else begin
            strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   )+';';
          end;
        finally
          FreeandNil(IncomeExpenseConfigAccounts);
        end;
        strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      )+';';
        strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income (Before Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';';
        amtPercent :=appenv.CompanyPrefs.IncomeTaxPercentage;
        strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('T'  , '17'  , '"IT"'        , '    Income Tax('+floatToStr(appenv.CompanyPrefs.IncomeTaxPercentage)+'%)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';';
        amtPercent := 100-appenv.CompanyPrefs.IncomeTaxPercentage;
        strSQL := strSQL+'insert into ' +xtablename + ' '  + AccountSummary('T'  , '18'  , '"NI"'        , 'Net Income(After Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder')+';';
        amtPercent :=0;

  finally
    TempScript.SQL.add(strSQL);
  end;
end;*)
(*procedure TIncomeandExpenditureGUI.ReportDetails;
VAR
  IncomeExpenseConfigAccounts:TSelectedAccountsforReports;
begin
  inherited;
      with fStringListForSQL do begin
        Add(BlankLine(2,'INC', 'Income' ));
        selectedIDS := '';
        IncomeExpenseConfigAccounts:= TIncomeConfigAccounts.NewObjInstance;
        Try
          if IncomeExpenseConfigAccounts.count > 0 then begin
            IncomeExpenseConfigAccounts.Iteraterecords(Incomerecords);
            Add('UNION ALL ');Add(AccountSummary('F', '3.1'   , '"INC"'       , ''                ,'"Others"'   ,'0'    , '"EXINC","INC"'                  , '"INC"'   , 'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' ,  SelectedIDs));
          end else begin
            Add('UNION ALL ');Add(AccountSummary('F'  , '3'   , '"INC"'       , ''                ,'Accounts'   ,'AccountID'    , '"EXINC","INC"'                        , 'Accounts'   ));
          end;
        finally
          FreeandNil(IncomeExpenseConfigAccounts);
        end;
        Add('UNION ALL ');Add(AccountSummary('F'  , '4'   , '"INC"'       , 'Total Income'    ,'""'         , '0'           , '"EXINC","INC"'                        , '"INC"'      ));
        Add('UNION ALL ');Add(BlankLine( 6,'COGS', 'Cost of Goods Sold' ));
        selectedIDS := '';
        IncomeExpenseConfigAccounts:= TCOGSConfigAccounts.NewObjInstance;
        try
          if IncomeExpenseConfigAccounts.count > 0 then begin
            IncomeExpenseConfigAccounts.Iteraterecords(COGsrecords);
            Add('UNION ALL ');Add(AccountSummary('F'  , '7.1'   , '"COGS"'      , ''                ,'"Others"'   ,'0'    , '"COGS"'                         , '"COGS"'   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' ,  SelectedIDs));
          end else begin
            Add('UNION ALL ');Add(AccountSummary('F'  , '7'   , '"COGS"'      , ''                ,'Accounts'   ,'AccountId'    , '"COGS"'                               , 'Accounts'   ));
          end;
        finally
          FreeandNil(IncomeExpenseConfigAccounts);
        end;
        Add('UNION ALL ');Add(AccountSummary('F'  , '8'   , 'Accounttype' , 'Total COGS'      ,'""'         ,'0'            , '"COGS"'                               , '"COGS"'     ));
        Add('UNION ALL ');Add(AccountSummary('T'  , '10'  , '""'          , 'Gross Profit'    ,'""'         ,'0'            , '"COGS", "EXINC","INC"'                , 'FinalOrder' ));
        Add('UNION ALL ');Add(BlankLine(12,'EXP', 'Expense' ));
        selectedIDS := '';
        IncomeExpenseConfigAccounts := TExpenseConfigAccounts.NewObjInstance;
        try
          if IncomeExpenseConfigAccounts.count > 0 then begin
            IncomeExpenseConfigAccounts.Iteraterecords(Expenserecords);
            Add('UNION ALL ');Add(AccountSummary('F'  , '13.1'  , '"EXP"' , ''                ,'"Others"'   ,'0'    , '"EXEXP","EXP"  '                , '"EXP"'   ,  'AccountSub1Order' , 'Accountsub2Order' , 'AccountSub3Order ' , '' , '"T"' , SelectedIDs));
          end else begin
            Add('UNION ALL ');Add(AccountSummary('F'  , '13'  , 'AccountType' , ''                ,'Accounts'   ,'AccountId'    , '"EXEXP","EXP"  '                      , 'Accounts'   ));
          end;
        finally
          FreeandNil(IncomeExpenseConfigAccounts);
        end;
        Add('UNION ALL ');Add(AccountSummary('F'  , '14'  , '"EXP"'       , 'Total Expenses'  ,'""'         ,'0'            , '"EXEXP","EXP" '                       , '"EXP"'      ));
        Add('UNION ALL ');Add(AccountSummary('T'  , '16'  , '"NI"'        , 'Net Income (Before Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));
        amtPercent :=appenv.CompanyPrefs.IncomeTaxPercentage;
        Add('UNION ALL ');Add(AccountSummary('T'  , '17'  , '"IT"'        , '    Income Tax('+floatToStr(appenv.CompanyPrefs.IncomeTaxPercentage)+'%)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));
        amtPercent := 100-appenv.CompanyPrefs.IncomeTaxPercentage;
        Add('UNION ALL ');Add(AccountSummary('T'  , '18'  , '"NI"'        , 'Net Income(After Tax)'      ,'""'         ,'0'            , '"EXEXP","EXP"  ,"EXINC", "INC", "COGS"' , 'FinalOrder'));
        amtPercent :=0;
      end;
end;*)



procedure TIncomeandExpenditureGUI.BitBtn1Click(Sender: TObject);
begin
{}
end;

procedure TIncomeandExpenditureGUI.cmdPrintClick(Sender: TObject);
begin
  ReportToPrint :=  'Income and Expenditure';
  inherited;

end;

procedure TIncomeandExpenditureGUI.cmdconfigureClick(Sender: TObject);
var
  Form: TComponent;
begin
  inherited;
  form := Commonlib.GetComponentByClassName('TfmSelectAccountsforReports' , True , nil );
  if not assigned(Form) then exit;
  TForm(Form).FormStyle := fsMDIChild;
  TForm(Form).bringtofront;
end;

(*function TIncomeandExpenditureGUI.Othersfilter(const sSortID: String): String;
var
  ConfigAccounts:TSelectedAccountsforReports;
begin
    if AnsiContainsText(sSortID, 'INC')  then begin
      ConfigAccounts:= TIncomeConfigAccounts.NewObjInstance;
      Try
        ConfigAccounts.Iteraterecords(Incomerecords);
        result := '(AccountType in ( "EXINC" ,"INC")) and  (accountId not in (' + SelectedIDs +'))';
      finally
        FreeandNil(ConfigAccounts);
      end;
    end else if AnsiContainsText(sSortID, 'COGS')  then begin
      ConfigAccounts:= TCOGSConfigAccounts.NewObjInstance;
      Try
        ConfigAccounts.Iteraterecords(Incomerecords);
        result := '(AccountType in ( "COGS")) and  (accountId not in (' + SelectedIDs +'))';
      finally
        FreeandNil(ConfigAccounts);
      end;
    end else if AnsiContainsText(sSortID, 'EXP')  then begin
      ConfigAccounts:= TExpenseConfigAccounts.NewObjInstance;
      Try
        ConfigAccounts.Iteraterecords(Incomerecords);
        result := '(AccountType in ( "EXEXP", "EXP")) and  (accountId not in (' + SelectedIDs +'))';
      finally
        FreeandNil(ConfigAccounts);
      end;
    end;
end;*)

initialization
  RegisterClassOnce(TIncomeandExpenditureGUI);

end.
