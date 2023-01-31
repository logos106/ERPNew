unit ProfitAndLossSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

  TProfitAndLossReport = class(TReportWithDateRangeBase)
  private
    fTempTableName: string;
    FCFields :String;
    fIncludedataPriorToClosingDate: boolean;
    fReportClassName: string;
    fAllDetartments: boolean;
    fDetailReport: boolean;
    fAllAccounts: boolean;
    fCustomLayout: Boolean;
    fLayoutID: Integer;

    fStringListForSQL: TStringList;
    fSelectedDepartments: TStringList;
    fActiveDepartments: TERPQuery;
    fClientID: integer;
    procedure OnScriptTempError(Sender: TObject; E: Exception; SQL: string;var Action: TErrorAction);
    procedure MakeReportTable;
    function GetSelectedDepartments: string;
    procedure SetSelectedDepartments(const Value: string);
    function ActiveDepartments: TERPQuery;
    function GetRootInitial(ARootName: string) : string;

  public
    AmountFieldList, AmountCaptionList: TStringDynArray;
    QrymainSQLList: TStringList;

    constructor Create; override;
    destructor Destroy; override;
    property TempTableName: string read fTempTableName;
    function PopulateReportSQL1(SQL: TStrings; var msg: string): Boolean;
    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;
    procedure CreateSQL4Report(ASQL: TStrings; AFCR: TERPQuery);
    procedure CalculateTotals(SQL: TStrings);
    property ReportClassName: string read fReportClassName write fReportClassName;
    property StringListForSQL: TStringList read fStringListForSQL write fStringListForSQL;
    function DepartmentSelected(const aDeptName: string): boolean;
    function SubtotalUpdateSQL: String;
    procedure CleanRefresh_PL_Table; virtual;
    property ClientID: integer read fClientID write fClientID;

  published
    property IncludePriorClosingDate: boolean read fIncludedataPriorToClosingDate write fIncludedataPriorToClosingDate;
    property AllDepartments: boolean read fAllDetartments write fAllDetartments;
    property SelectedDepartments: string read GetSelectedDepartments write SetSelectedDepartments;
    property DetailReport: boolean read fDetailReport write fDetailReport;
    property AllAccounts: boolean read fAllAccounts write fAllAccounts;
    property UseCustomLayout: Boolean read fCustomLayout write fCustomLayout;
    property LayoutID: Integer read fLayoutID write fLayoutID;

  end;

implementation

uses
  TempTableUtils,BaseListUtilsObj, Report_ProfitnLoss_Obj,
  StrUtils, tcConst, TransactionsTable, AppEnvVirtualObj, AppEnvironmentVirtual, DbSharedObjectsObj, FCOnreportLib, ClipBrd, Dialogs,
  LogLib;

{ TProfitAndLossReport }

function TProfitAndLossReport.ActiveDepartments: TERPQuery;
begin
  if not Assigned(fActiveDepartments) then begin
    fActiveDepartments := TERPQuery.Create(nil);
    fActiveDepartments.Connection := SharedConnection;
    fActiveDepartments.Connection := SharedConnection;
    fActiveDepartments.SQL.Add('SELECT ClassID, ClassName FROM tblclass');
    fActiveDepartments.SQL.Add('WHERE Active = "T" AND IFNULL(ClassName , "") <> ""');
    fActiveDepartments.Open;
  end;
  result := fActiveDepartments;
end;

procedure TProfitAndLossReport.CleanRefresh_PL_Table;
var
  ReportTransactionTableObj: TProfitnLoss_Report_Obj;
  cmd: TERPCommand;
  ctr: integer;
  I: integer;
  pClass: pClassRec;

  function TransTablename(Loopno :Integer):String;
  begin
    if ctr = 1 then result := 'tbltransactions' else result := 'tbltransactionsummarydetails';
  end;

begin
  ReportTransactionTableObj := TProfitnLoss_Report_Obj.Create(True);
  try
    ReportTransactionTableObj.CleanRefresh_PL_Table(DateFrom, DateTo, TempTablename, FCFields , ClientId , IncludePriorClosingDate, APIMode);
  finally
    ReportTransactionTableObj.Free;
  end;
end;

constructor TProfitAndLossReport.Create;
begin
  inherited;
  fClientID := 0;
  fStringListForSQL := nil;
  fAllAccounts := true;
  fDetailReport := true;
  fReportClassName := 'TProfitandLossGUI';
  fIncludedataPriorToClosingDate := false;
  DateFrom := 0;
  DateTo := Date;
  fSelectedDepartments := TStringList.Create;
  fSelectedDepartments.CaseSensitive := false;
  fTempTableName :=  UniqueTableName('PnL', SharedConnection);

  fCustomLayout := false;
  fLayoutID := 0;

end;

function TProfitAndLossReport.DepartmentSelected(const aDeptName: string): boolean;
begin
  Result := fSelectedDepartments.IndexOf(aDeptName) > -1;
end;

destructor TProfitAndLossReport.Destroy;
begin
  fSelectedDepartments.Free;
  fActiveDepartments.Free;
  TempTableUtils.DestroyUserTemporaryTable(SharedConnection, TempTableName);
  inherited;
end;

function TProfitAndLossReport.GetSelectedDepartments: string;
begin
  result := fSelectedDepartments.CommaText;
end;

procedure TProfitAndLossReport.MakeReportTable;
var
  scr: TERPScript;
//  qry: TERPQuery;
  ctr :Integer;
//  AmountFields, AmountCaptions: TStringDynArray;
  FCR: TERPQuery;
begin

  scr := TERPScript.Create(nil);
  Try
    scr.Connection := SharedConnection;
    scr.OnError := OnScriptTempError;
    FCFields := '';

    { create the tempory table }
    CreateTemporyTableFromTemplate(SharedConnection, TABLE_PROFITANDLOSSREPORT, TempTableName);

    { populate the arrays .. }
    TBaseListUtils.InitFCFields(AmountFieldLIst, AmountCaptionList, fReportClassName, SharedConnection,APIMode);
    scr.SQL.Add('ALTER TABLE ' + fTempTableName );
    for ctr := low(AmountFieldList) to high(AmountFieldList) do begin
        if ctr > 0 then scr.SQL.Add(',');
        scr.SQL.Add(' ADD COLUMN `' +  AmountFieldList[ctr]  + '` Double');
    end;

//    qry := TERPQuery.Create(nil);
    FCR := DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
    try
      LoadFCPref(FCR, fReportClassName, True);// FCR.LoadFCPref(fReportClassName);
      if FCR.recordCount > 0 then begin
        while not FCR.Eof do begin
          scr.SQL.Add(',');
          for ctr := low(AmountFieldList) to high(AmountFieldList) do
              scr.SQL.Add(' ADD COLUMN  `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr]  + '` Double,');
          scr.SQL.Add(' ADD COLUMN ' + FCR.Fieldbyname('Code').AsString + '_FCRate Double');

          if FCFields <> '' then FCFields := FCFields + ',' ;
          FCFields := FCFields + FCR.Fieldbyname('Code').asString + '_FCRate';
          FCR.Next;
        end;
      end;
    finally
      DbSharedObj.ReleaseObj(FCR);
    end;

    scr.SQL.Add(';');
    scr.SQL.Add('ALTER TABLE ' + fTempTableName + ' ADD COLUMN `Accountno` VARCHAR(50);' );
    scr.Execute;
  Finally
    scr.Free;
  End;

end;

procedure TProfitAndLossReport.OnScriptTempError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
begin
  Action := eaContinue ;
end;

function TProfitAndLossReport.PopulateReportSQL1(SQL: TStrings; var msg: string): Boolean;
var
  scr: TERPScript;
  FCR: TERPQuery;
//  qryDept: TERPQuery;
//  ReportTransactionTableObj: TProfitnLoss_Report_Obj;
  ctr :Integer;

 // QrymainSQLList: TStringList;

  iSQLCounter :Integer;
  StringList4SQL :TStringList;
  tmptablename, tmpfilename: String;
  sl: TStringList;

//  useCustomLayout : Boolean;

  Procedure ReportHeader;
  begin
    if Assigned(StringListForSQL) then begin
      StringListForSQL.Clear;
      StringListForSQL.Add('{ReportHeader}Select');
      StringListForSQL.Add('CO.COMPANYNAME,');
      StringListForSQL.Add('CO.ADDRESS,');
      StringListForSQL.Add('CO.ADDRESS2,');
      StringListForSQL.Add('CO.CITY,');
      StringListForSQL.Add('CO.STATE,');
      StringListForSQL.Add('CO.POSTCODE,');
      StringListForSQL.Add('CONCAT("PHONE ",CO.PHONENUMBER) AS PHONENUMBER,');
      StringListForSQL.Add('CONCAT("FAX ",CO.FAXNUMBER) AS FAXNUMBER,');
      StringListForSQL.Add('CO.ABN , Convert(:FROMDate,Date) as FROMDate , Convert(:TODate, Date) as TODate');
      StringListForSQL.Add('From TBLCOMPANYINFORMATION AS CO');
      StringListForSQL.Add('~|||~{Repdata}');
    end;
  end;

  Procedure AddCaptions;
  begin
    if APIMode then exit;

    if FCR.recordCount <> 0 then begin
      FCR.First;
      StringList4SQL.Add(Quotedstr(Appenvvirt.str['RegionalOptions.ForeignExDefault'])  + ' as Defaultcurrency_Caption,' );
      While not FCR.eof do begin
        StringList4SQL.Add(Quotedstr(FCR.Fieldbyname('Code').asString)  + ' as `' +  FCR.Fieldbyname('Code').asString + '_Caption`,' );
        FCR.Next;
      end;
    end;
    if ActiveDepartments.RecordCount > 0 then begin
      ActiveDepartments.First;
      while not ActiveDepartments.Eof do begin
        StringList4SQL.Add(Quotedstr(ActiveDepartments.fieldByname('ClassName').asString)  + ' as `' +
          Trim(inttostr(ActiveDepartments.FieldByName('classId').asInteger)) + '_Caption`,' );
        ActiveDepartments.Next;
      end;
    end;
  end;

  Procedure AddAmountFields(Const AmountZero :Boolean = False);
  var
    ctr1: Integer;
  begin
    if AmountZero then begin
      for ctr1 := low(AmountFieldList) to high(AmountFieldList) do
        StringList4SQL.Add('0 as `' + AmountFieldList[ctr1]  + '`,');
    end else begin
      for ctr1 := low(AmountFieldList) to high(AmountFieldList) do
          StringList4SQL.Add('sum(`' + AmountFieldList[ctr1]+ '`) as `' + AmountFieldList[ctr1]  + '`,');
    end;
    if FCR.REcordCount = 0 then Exit;
    FCR.First;
    While not FCR.EOF do begin
      for ctr1 := low(AmountFieldList) to high(AmountFieldList) do
        if AmountZero then begin
          StringList4SQL.Add('0 as `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]  + '`,');
        end else begin
          StringList4SQL.Add('sum(`' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]+ '`) as `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldLIst[ctr1]  + '`,');
        end;
      FCR.Next;
    end;

  end;

begin
  //    ShowMessage('PopulateReportSQL');
//  Result := inherited;

  if not Assigned(StringListForSQL) then begin
    sl := TStringList.Create;
    StringListForSQL := sl;
  end else sl := nil;

  try
    FCR := DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
    try
      LoadFCPref(FCR, fReportClassName, true);
    //    ScriptMain.SQL.clear;
            if not SameText(ReportClassName,'TBalanceSheetGUI') then begin
                MakeReportTable;
                scr := TERPScript.Create(nil);
                try
                  scr.Connection := SharedConnection;
                  CleanRefresh_PL_Table;
    //                ReportTransactionTableObj := TProfitnLoss_Report_Obj.Create(True);
    //                try
    //                  ReportTransactionTableObj.CleanRefresh_PL_Table(
    //                    DateFrom, DateTo, TempTablename, FCFields , 0 , IncludePriorClosingDate, APIMode);
    //                finally
    //                  ReportTransactionTableObj.Free;
    //                end;

                  tmptablename:= TempTableUtils.UniqueTableName(fReportClassName, SharedConnection);

    {|--------------update accountnumber from the Chart of accounts table }
    {|}                scr.SQL.Add(SQLfortemptable('tblchartofaccounts', 'Accountnumber','' , 'inner join '+TempTableName + ' T on  M.AccountId = ifnull(T.AccountId,0)', tmptablename,tmpfilename, SharedConnection));
    {|}                scr.SQL.Add('update '+TempTableName +' as T inner join '+tmptablename+' C on C.AccountId = T.AccountId '+
    {|}                                    ' Set T.accountno = C.Accountnumber where ifnull(T.AccountId,0)<> 0;');
    {|}
    {|--------------update foreigncurrency fields}
    {|}                if FCR.recordCount > 0 then begin
    {|}                    FCR.first;
    {|}                    scr.SQL.Add('update ' + TempTableName  + ' set ' );
    {|}                    while FCR.Eof = False do begin
    {|}                        if not FCR.BOF then
    {|}                          scr.SQL.Add(',');
    {|}                        for ctr := low(AmountFieldList) to high(AmountFieldList) do begin
    {|}                            if ctr > low(AmountFieldList) then scr.SQL.Add(',');
    {|}                            scr.SQL.Add( '`' +FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr] + '`  = `'+ AmountFieldList[ctr] +  '` * ' + FCR.Fieldbyname('Code').asString + '_FCRate');
    {|}                        end;
    {|}
    {|}                        FCR.Next;
    {|}                    end;
    {|}                    scr.SQL.Add(';');
    {|}                end;

    {|--------------update Sub totals}
    {|}             scr.SQL.Add(SubtotalUpdateSQL);
    {|--------------Execute all update sqls}
                    DoShowProgressbar(scr.Statements.Count, 'Updating Account Number' );
                    try
                      scr.OnError := OnScriptTempError;
                      scr.Execute;
                    finally
                      dohideProgressbar();
                    end;
                finally
                  //AppEnv.UtilsClient.DeleteServerFiles(ReplaceStr(tmpfilename, '.tmp' , '*.tmp'));
                  AppEnvVirt.DeleteServerFiles(ReplaceStr(tmpfilename, '.tmp' , '*.tmp'));
                  scr.Free;
                end;
            End;

        QrymainSQLList:= TStringList.Create;
        try
          ReportHeader;

          for iSQLCounter := 1 to 2 do begin
            if iSQLCounter = 2 then StringList4SQL := StringListForSQL
            else StringList4SQL := QrymainSQLList;

            StringList4SQL.Add('SELECT 1 seqno,0 as AccountID,');
            StringList4SQL.Add('"INC" as AccountType,');
            StringList4SQL.Add('"Income" as "Account Type" , ');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('2 As FinalOrder,Space(255) as AccountHeaderOrder,');
            StringList4SQL.Add('Space(255) as AccountSub1Order,');
            StringList4SQL.Add('Space(255) as AccountSub2Order,');
            StringList4SQL.Add('Space(255) as AccountSub3Order,');

            StringList4SQL.Add('null as SubTotalInc,');
            StringList4SQL.Add('null as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');

        // Income Accounts
            if not DetailReport then begin

            end
            else begin
              StringList4SQL.Add('UNION ALL');
              StringList4SQL.Add('SELECT 2 seqno,AccountID,"INC" as AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('Accounts,');
              StringList4SQL.Add('Accountno,');
              AddCaptions;
              AddAmountFields;
              StringList4SQL.Add('3 As FinalOrder,');
              StringList4SQL.Add('AccountHeaderOrder,');
              StringList4SQL.Add('AccountSub1Order,');
              StringList4SQL.Add('AccountSub2Order,');
              StringList4SQL.Add('AccountSub3Order,');

              StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
              StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
              StringList4SQL.Add('"T" as HideTotal');
              StringList4SQL.Add('FROM ' + TempTableName + ' Where (AccountType = "EXINC" OR AccountType = "INC")');
              //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
              StringList4SQL.Add('Group By Accounts');
            end;
    // Income Accounts with zero
            if AllAccounts then begin
              StringList4SQL.Add('UNION ALL');
              StringList4SQL.Add('SELECT 3 seqno,AccountID,"INC" as AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('AccountName as Accounts,');
              StringList4SQL.Add('AccountNumber as Accountno,');
              AddCaptions;
              AddAmountFields(true);
              StringList4SQL.Add('3 As FinalOrder,');
              StringList4SQL.Add('Level1 as AccountHeaderOrder,');
              StringList4SQL.Add('Level2 as AccountSub1Order,');
              StringList4SQL.Add('Level3 as AccountSub2Order,');
              StringList4SQL.Add('Level4 as AccountSub3Order,');

              StringList4SQL.Add('0.0 as SubTotalInc,');
              StringList4SQL.Add('0.0 as SubTotalEx,');
              StringList4SQL.Add('"T" as HideTotal');
              StringList4SQL.Add('FROM tblchartofaccounts Where (AccountType = "EXINC" OR AccountType = "INC")');
              StringList4SQL.Add('and AccountId not in ');
              StringList4SQL.Add('        (select distinct AccountID from ' + TempTableName);
              //StringList4SQL.Add('        where Date Between :txtfrom AND :txtto');
              StringList4SQL.Add('        )');
            end;

    // Total Income
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 4 seqno,0 as AccountID,');
            StringList4SQL.Add('"INC" as AccountType,');
            StringList4SQL.Add('"Total Income" as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('4 As FinalOrder,');
            StringList4SQL.Add('AccountHeaderOrder,');
            StringList4SQL.Add('AccountSub1Order,');
            StringList4SQL.Add('AccountSub2Order,');
            StringList4SQL.Add('AccountSub3Order,');

            StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
            StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTableName + ' WHERE (AccountType = "EXINC" OR AccountType = "INC")');
            //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
            StringList4SQL.Add('Group By "INC"');
    // Space
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 5 seqno,0 as AccountID,');
            StringList4SQL.Add('Space(255) as AccountType,');
            StringList4SQL.Add('Space(255) as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('5 As FinalOrder,');
            StringList4SQL.Add('Space(255) as AccountHeaderOrder,');
            StringList4SQL.Add('Space(255) as AccountSub1Order,');
            StringList4SQL.Add('Space(255) as AccountSub2Order,');
            StringList4SQL.Add('Space(255) as AccountSub3Order,');

            StringList4SQL.Add('null as SubTotalInc,');
            StringList4SQL.Add('null as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
    // COGS Header
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 6 seqno,0 as AccountID,');
            StringList4SQL.Add('"COGS" as AccountType,');
            StringList4SQL.Add('"Cost of Goods Sold" as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('6 As FinalOrder,Space(255) as AccountHeaderOrder,');
            StringList4SQL.Add('Space(255) as AccountSub1Order,');
            StringList4SQL.Add('Space(255) as AccountSub2Order,');
            StringList4SQL.Add('Space(255) as AccountSub3Order,');

            StringList4SQL.Add('null as SubTotalInc,');
            StringList4SQL.Add('null as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
    // COGS Accounts
            if not DetailReport then begin

            end
            else begin
              StringList4SQL.Add('UNION ALL');
              StringList4SQL.Add('SELECT 7 seqno,AccountID,AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('Accounts,');
              StringList4SQL.Add('Accountno,');
              AddCaptions;
              AddAmountFields;
              StringList4SQL.Add('7 As FinalOrder,');
              StringList4SQL.Add('AccountHeaderOrder,');
              StringList4SQL.Add('AccountSub1Order,');
              StringList4SQL.Add('AccountSub2Order,');
              StringList4SQL.Add('AccountSub3Order,');

              StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
              StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
              StringList4SQL.Add('"T" as HideTotal');
              StringList4SQL.Add('FROM ' + TempTablename + ' WHERE (AccountType = "COGS")');
              //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
              StringList4SQL.Add('Group By Accounts');
            end;
    // COGS Accounts with zero amounts
            if AllAccounts then begin
              StringList4SQL.Add('UNION ALL');
              StringList4SQL.Add('SELECT 8 seqno,AccountID,AccountType as AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('AccountName as Accounts,');
              StringList4SQL.Add('AccountNumber as Accountno,');
              AddCaptions;
              AddAmountFields(true);
              StringList4SQL.Add('7 As FinalOrder,');
              StringList4SQL.Add('Level1 as AccountHeaderOrder,');
              StringList4SQL.Add('Level2 as AccountSub1Order,');
              StringList4SQL.Add('Level3 as AccountSub2Order,');
              StringList4SQL.Add('Level4 as AccountSub3Order,');

              StringList4SQL.Add('0.0 as SubTotalInc,');
              StringList4SQL.Add('0.0 as SubTotalEx,');
              StringList4SQL.Add('"T" as HideTotal');
              StringList4SQL.Add('FROM tblchartofaccounts WHERE (AccountType = "COGS")');
              StringList4SQL.Add('and AccountId not in ');
              StringList4SQL.Add('          (select distinct AccountID from ' + TempTablename+' ');
              //StringList4SQL.Add('          where Date Between :txtfrom AND :txtto');
              StringList4SQL.Add('          )');
            end;
    // COGS Totals
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT  9 seqno,0 as AccountID,');
            StringList4SQL.Add('"COGS" as AccountType,');
            StringList4SQL.Add('"Total COGS" as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('8 As FinalOrder,');
            StringList4SQL.Add('AccountHeaderOrder,');
            StringList4SQL.Add('AccountSub1Order,');
            StringList4SQL.Add('AccountSub2Order,');
            StringList4SQL.Add('AccountSub3Order,');

            StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
            StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTablename + ' WHERE (AccountType = "COGS")');
            //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
            StringList4SQL.Add('Group By "COGS"');
    // Space
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 10 seqno,0 as AccountID,');
            StringList4SQL.Add('Space(255) as AccountType,');
            StringList4SQL.Add('Space(255) as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('9 As FinalOrder,');
            StringList4SQL.Add('Space(255) as AccountHeaderOrder,');
            StringList4SQL.Add('Space(255) as AccountSub1Order,');
            StringList4SQL.Add('Space(255) as AccountSub2Order,');
            StringList4SQL.Add('Space(255) as AccountSub3Order,');

            StringList4SQL.Add('null as SubTotalInc,');
            StringList4SQL.Add('null as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
    // Gross Profit
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 11 seqno,0 as AccountID,');
            StringList4SQL.Add('Space(255) as AccountType,');
            StringList4SQL.Add('"Gross Profit" as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('10 As FinalOrder,');
            StringList4SQL.Add('AccountHeaderOrder,');
            StringList4SQL.Add('AccountSub1Order,');
            StringList4SQL.Add('AccountSub2Order,');
            StringList4SQL.Add('AccountSub3Order,');

            StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
            StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTablename + ' WHERE (AccountType = "COGS" OR AccountType = "EXINC" OR AccountType = "INC")');
            //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
            StringList4SQL.Add('Group By FinalOrder');

    // Space
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 12 seqno,0 as AccountID,');
            StringList4SQL.Add('Space(255) as AccountType,');
            StringList4SQL.Add('Space(255) as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('11 As FinalOrder,');
            StringList4SQL.Add('Space(255) as AccountHeaderOrder,');
            StringList4SQL.Add('Space(255) as AccountSub1Order,');
            StringList4SQL.Add('Space(255) as AccountSub2Order,');
            StringList4SQL.Add('Space(255) as AccountSub3Order,');

            StringList4SQL.Add('null as SubTotalInc,');
            StringList4SQL.Add('null as SubTotalEx,');

            StringList4SQL.Add('"T" as HideTotal');
    // Expense Header
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 13 seqno,0 as AccountID,');
            StringList4SQL.Add('"EXP" as AccountType,');
            StringList4SQL.Add('"Expense" as "Account Type" , ');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('12 As FinalOrder,');
            StringList4SQL.Add('Space(255) as AccountHeaderOrder,');
            StringList4SQL.Add('Space(255) as AccountSub1Order,');
            StringList4SQL.Add('Space(255) as AccountSub2Order,');
            StringList4SQL.Add('Space(255) as AccountSub3Order,');

            StringList4SQL.Add('null as SubTotalInc,');
            StringList4SQL.Add('null as SubTotalEx,');

            StringList4SQL.Add('"T" as HideTotal');
    // Expense Accounts
            if not DetailReport then begin

            end
            else begin
              StringList4SQL.Add('UNION ALL');
              StringList4SQL.Add('SELECT 14 seqno,AccountID,');
              StringList4SQL.Add('AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('Accounts,');
              StringList4SQL.Add('Accountno,');
              AddCaptions;
              AddAmountFields;
              StringList4SQL.Add('13 As FinalOrder,');
              StringList4SQL.Add('AccountHeaderOrder,');
              StringList4SQL.Add('AccountSub1Order,');
              StringList4SQL.Add('AccountSub2Order,');
              StringList4SQL.Add('AccountSub3Order,');

              StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
              StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
              StringList4SQL.Add('"T" as HideTotal');
              StringList4SQL.Add('FROM ' + TempTablename + ' WHERE (AccountType = "EXEXP" OR AccountType = "EXP")');
              //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
              StringList4SQL.Add('Group By Accounts');
            end;
    // Expense Accounts with zero amounts
            if AllAccounts then begin
              StringList4SQL.Add('UNION ALL');
              StringList4SQL.Add('SELECT 15 seqno,AccountID,AccountType as AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('AccountName as Accounts,');
              StringList4SQL.Add('AccountNumber as Accountno,');
              AddCaptions;
              AddAmountFields(true);
              StringList4SQL.Add('13 As FinalOrder,');
              StringList4SQL.Add('Level1 as AccountHeaderOrder,');
              StringList4SQL.Add('Level2 as AccountSub1Order,');
              StringList4SQL.Add('Level3 as AccountSub2Order,');
              StringList4SQL.Add('Level4 as AccountSub3Order,');

              StringList4SQL.Add('0.0 as SubTotalInc,');
              StringList4SQL.Add('0.0 as SubTotalEx,');
              StringList4SQL.Add('"T" as HideTotal');
              StringList4SQL.Add('FROM tblchartofaccounts WHERE (AccountType = "EXEXP" OR AccountType = "EXP")');
              StringList4SQL.Add('and AccountId not in ');
              StringList4SQL.Add('        (select distinct AccountID from '+TempTablename+' ');
              //StringList4SQL.Add('        where Date Between :txtfrom AND :txtto');
              StringList4SQL.Add('        )');
            end;

    // Expense Total
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 16 seqno,0 as AccountID,"EXP" as AccountType,');
            StringList4SQL.Add('"Total Expenses" as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('14 As FinalOrder,');
            StringList4SQL.Add('AccountHeaderOrder,');
            StringList4SQL.Add('AccountSub1Order,');
            StringList4SQL.Add('AccountSub2Order,');
            StringList4SQL.Add('AccountSub3Order,');

            StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
            StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTablename + ' WHERE (AccountType = "EXEXP" OR AccountType = "EXP")');
            //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
            StringList4SQL.Add('Group By "EXP"');
    // Space
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 17 seqno,0 as AccountID,');
            StringList4SQL.Add('Space(255) as AccountType,');
            StringList4SQL.Add('Space(255) as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('15 As FinalOrder,');
            StringList4SQL.Add('Space(255) as AccountHeaderOrder,');
            StringList4SQL.Add('Space(255) as AccountSub1Order,');
            StringList4SQL.Add('Space(255) as AccountSub2Order,');
            StringList4SQL.Add('Space(255) as AccountSub3Order,');

            StringList4SQL.Add('null as SubTotalInc,');
            StringList4SQL.Add('null as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
    // Net Income
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT 18 seqno,0 as AccountID,');
            StringList4SQL.Add('Space(255) as AccountType,');
            StringList4SQL.Add('"Net Income" as "Account Type",');
            StringList4SQL.Add('Space(255) as AccountName,');
            StringList4SQL.Add('Space(50) as AccountNo,');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('16 As FinalOrder,');
            StringList4SQL.Add('AccountHeaderOrder,');
            StringList4SQL.Add('AccountSub1Order,');
            StringList4SQL.Add('AccountSub2Order,');
            StringList4SQL.Add('AccountSub3Order,');

            StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
            StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTablename + ' WHERE  (AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS")');
            //StringList4SQL.Add('AND Date Between :txtfrom AND :txtto');
            StringList4SQL.Add('Group By FinalOrder');

    // Total Income Accounts  Totals Level1
            StringList4SQL.Add('UNION ALL');
            if not DetailReport then begin
              StringList4SQL.Add('SELECT 19 seqno,AccountID,');
              StringList4SQL.Add('AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('Level1 as AccountName,');
              StringList4SQL.Add('AccountNo,');
            end
            else begin
              StringList4SQL.Add('SELECT 19 seqno,0 as AccountID,');
              StringList4SQL.Add('AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('LEFT(Concat("Total ",Level1,Space(255)),255) as AccountName,');
              StringList4SQL.Add('Space(50) as AccountNo,');
            end;
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');
            StringList4SQL.Add('AccountHeaderOrder,');
            StringList4SQL.Add('"ZZZZZZZZZZZZ" as AccountSub1Order,');
            StringList4SQL.Add('"ZZZZZZZZZZZZ" as AccountSub2Order,');
            StringList4SQL.Add('"ZZZZZZZZZZZZ" as AccountSub3Order,');


            StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
            StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
            if not DetailReport then begin
              StringList4SQL.Add('"T" as HideTotal');
            end
            else begin
              StringList4SQL.Add('If( char_length(Max(Level2))>0 ,"T","F") as HideTotal');
//              StringList4SQL.Add('If( char_length(Max(Level1))>0 ,"T","F") as HideTotal');
            end;
            StringList4SQL.Add('FROM ' + TempTablename + '');

//                StringList4SQL.Add(' LEFT JOIN tblpnllayoutdata ON ' + TempTablename + '.AccountID = tblpnllayoutdata.AccountID ');
//                  StringList4SQL.Add( ' AND TRIM(' + TempTablename + '.AccountName) = TRIM(tblpnllayoutdata.Name) ' );

            if not DetailReport then begin
              StringList4SQL.Add('Where TotalAmountEx <> 0.00');
            end
            else begin
//              StringList4SQL.Add('Where AccountName <> LEvel1 and  char_length(Level1)>0 And TotalAmountEx<>0.00');

           //   StringList4SQL.Add('Where AccountHeaderOrder = tblpnllayoutdata.Level1Order and char_length(tblpnllayoutdata.Level1Order)>0 And TotalAmountEx<>0.00');

              StringList4SQL.Add('Where AccountHeaderOrder = Level1 and char_length(Level1)>0 And TotalAmountEx<>0.00');

            end;
            StringList4SQL.Add('');
       //
        //    StringList4SQL.Add('Group By tblpnllayoutdata.Level1Order');
            StringList4SQL.Add('Group By AccountHeaderOrder');

            if not DetailReport then begin

            end
            else begin
       // Total Income Accounts  Totals Level2
              StringList4SQL.Add('UNION ALL');
              StringList4SQL.Add('SELECT 20 seqno,0 as AccountID,');
              StringList4SQL.Add('AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('LEFT(Concat(Space(5),REPLACE(Level2,Level2,Concat("Total ",Level2,Space(255)))),255)  as AccountName,');
              StringList4SQL.Add('Space(50) as AccountNo,');
              AddCaptions;
              AddAmountFields;
              StringList4SQL.Add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');
              StringList4SQL.Add('AccountHeaderOrder,');
              StringList4SQL.Add('AccountSub1Order,');
              StringList4SQL.Add('"ZZZZZZZZZZZZ" as AccountSub2Order,');
              StringList4SQL.Add('"ZZZZZZZZZZZ" as AccountSub3Order,');

              StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
              StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
              StringList4SQL.Add('If( char_length(Max(Level3))>0 ,"T","F") as HideTotal');
//              StringList4SQL.Add('If( char_length(Max(Level2))>0 ,"T","F") as HideTotal');
              StringList4SQL.Add('FROM ' + TempTablename + '');
//              StringList4SQL.Add('Where (AccountName <> Level1) AND (AccountName<>LEvel2) AND (char_length(Level2)>0) AND TotalAmountEx<>0.00');
              StringList4SQL.Add('Where (AccountName <> Level1) AND (char_length(Level2)>0) AND TotalAmountEx<>0.00');
              StringList4SQL.Add('Group By AccountType,LEFT(Concat(Space(5),REPLACE(Level2,Level2,Concat("Total ",Level2,Space(255)))),255)');

      // Total Income Accounts  Totals Level3
              StringList4SQL.Add('Union All');
              StringList4SQL.Add('SELECT 21 seqno,0 as AccountID,');
              StringList4SQL.Add('AccountType,');
              StringList4SQL.Add('Space(255) as "Account Type",');
              StringList4SQL.Add('LEFT(Concat(Space(10),REPLACE(Level3,Level3,Concat("Total ",Level3,Space(255)))),255)  as AccountName,');
              StringList4SQL.Add('Space(50) as AccountNo,');
              AddCaptions;
              AddAmountFields;
              StringList4SQL.Add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');
              StringList4SQL.Add('AccountHeaderOrder,');
              StringList4SQL.Add('AccountSub1Order,');
              StringList4SQL.Add('AccountSub2Order,');
              StringList4SQL.Add('"ZZZZZZZZZZ" as AccountSub3Order,');

              StringList4SQL.Add('Sum(SubTotalInc) as SubTotalInc,');
              StringList4SQL.Add('Sum(SubTotalEx) as SubTotalEx,');
              StringList4SQL.Add('If( char_length(Max(Level4))>0 ,"T","F") as HideTotal');
//              StringList4SQL.Add('If( char_length(Max(Level3))>0 ,"T","F") as HideTotal');
              StringList4SQL.Add('FROM ' + TempTablename + '');
              StringList4SQL.Add('WHERE (AccountName <> Level1) And (AccountName <> Level2) And (char_length(Level3)>0) AND TotalAmountEx<>0.00');
              StringList4SQL.Add('Group By AccountType,LEFT(Concat(Space(10),REPLACE(Level3,Level3,Concat("Total ",Level3,Space(255)))),255)');
            end;

      //      StringList4SQL.Add('Order By FinalOrder,AccountHeaderOrder, AccountSub1Order,AccountSub2Order,AccountSub3Order,TotalAmountInc;');

            StringList4SQL.Add('Order By FinalOrder,AccountHeaderOrder, AccountSub1Order,AccountSub2Order,AccountSub3Order,TotalAmountInc');
          end;

          SQL.Clear;
        //    SQL.Text := QrymainSQLList.Text;
        //   Clipboard.AsText := QrymainSQLList.Text;
      //      useCustomLayout := false;

          if UseCustomLayout then begin
      //    SQL.Text := 'SELECT Layout.Name AS LayoutAccountType, Layout.Name AS LayoutAccountName, ';
             SQL.Text := 'SELECT (CASE Layout.Level1Order WHEN 0 THEN Layout.Name WHEN 10000 THEN Layout.Name ELSE "" END) AS LayoutAccountType, ';
             SQL.Text := SQL.Text  + '(CASE WHEN Layout.IsAccount = "T" AND Layout.Level3Order > 0 THEN CONCAT("              " , Layout.Name) ';
             SQL.Text := SQL.Text  + ' WHEN Layout.Level1Order = 0 OR Layout.Level1Order = 10000 THEN ""';
             SQL.Text := SQL.Text  + ' WHEN Layout.IsAccount = "T" THEN CONCAT("       " , Layout.Name)  ELSE Layout.Name END) AS LayoutAccountName, ';
             SQL.Text := SQL.Text  + ' Report.*, Layout.Level0Order, Layout.IsLevel0Total, Layout.Level1Order, Layout.IsLevel1Total, Layout.Level2Order, Layout.IsLevel2Total, Layout.Level3Order, Layout.IsLevel3Total, Layout.IsAccount ';
             SQL.Text := SQL.Text  + ' FROM (' + QrymainSQLList.Text + ') Report '
                + ' RIGHT JOIN tblpnllayoutdata Layout ON Report.AccountID = Layout.AccountID '

                + '  WHERE tblpnllayouts.LayoutID = Layout.LayoutID AND tblpnllayouts.IsCurrentLayout = "T" '

    //                + ' WHERE NOT ((Report.AccountName IS NULL OR Report.AccountName = '') AND (Report.`Account Type` IS NULL OR Report.`Account Type` = '' )) '

                + ' AND (TRIM(Report.AccountName) = TRIM(Layout.Name) '
                + ' OR TRIM(Report.`Account Type`) = TRIM(Layout.Name)) '
    //                + ' AND ((Report.AccountName IS NOT NULL AND TRIM(Report.AccountName) <> '') OR (Report.`Account Type` IS NOT NULL AND TRIM(Report.`Account Type`) <> '' )) '
                + 'ORDER BY Layout.Level0Order, Layout.IsLevel0Total,  Layout.Level1Order, Layout.IsLevel1Total, Layout.Level2Order, Layout.IsLevel2Total, Layout.Level3Order, Layout.IsLevel3Total, TotalAmountInc';

              ClipBoard.AsText := SQL.Text;
              QryMainSQLList.Text := SQL.Text;

   //           ShowMessage(' QrymainSQLList.Text ' +  QrymainSQLList.Text);


//               SQL.Text := 'SELECT DISTINCT Report.*, Layout.Level1Order, Layout.IsLevel1Total, Layout.Level2Order, Layout.IsLevel2Total, Layout.Level3Order, Layout.IsLevel3Total FROM (' + QrymainSQLList.Text + ') Report '
//                  + 'LEFT JOIN tblpnllayoutdata Layout ON Report.AccountID = Layout.AccountID '
//                  + ' AND TRIM(Report.AccountName) = TRIM(Layout.Name) '
//                  + 'Order By FinalOrder, Layout.Level1Order, Layout.IsLevel1Total, Layout.Level2Order, Layout.IsLevel2Total, Layout.Level3Order, Layout.IsLevel3Total, TotalAmountInc';

               CalculateTotals(SQL);
            end
            else
               SQL.Text := QryMainSQLList.Text + ';';

            Result := True;
            //self.RefreshOrignalSQL;
        finally
         //   if Assigned(QrymainSQLList) then FreeAndNil(QrymainSQLList);
        end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(FCR);
      end;
  finally
    sl.Free;
  end;
end;

procedure TProfitAndLossReport.CalculateTotals(SQL: TStrings);
var
  f : Integer;

  finalOrder : Integer;

  totalLevel0Amount_1Inc : Double;
  totalLevel0Amount_2Inc : Double;
  totalLevel0Amount_3Inc : Double;
  totalLevel0AmountTotalInc : Double;


  totalLevel1Amount_1Inc : Double;
  totalLevel1Amount_2Inc : Double;
  totalLevel1Amount_3Inc : Double;
  totalLevel1AmountTotalInc : Double;

  totalLevel2Amount_1Inc : Double;
  totalLevel2Amount_2Inc : Double;
  totalLevel2Amount_3Inc : Double;
  totalLevel2AmountTotalInc : Double;


  totalLevel0Amount_1Ex : Double;
  totalLevel0Amount_2Ex : Double;
  totalLevel0Amount_3Ex : Double;
  totalLevel0AmountTotalEx : Double;


  totalLevel1Amount_1Ex : Double;
  totalLevel1Amount_2Ex : Double;
  totalLevel1Amount_3Ex : Double;
  totalLevel1AmountTotalEx : Double;

  totalLevel2Amount_1Ex : Double;
  totalLevel2Amount_2Ex : Double;
  totalLevel2Amount_3Ex : Double;
  totalLevel2AmountTotalEx : Double;


    currentLevel0Order : Integer;
  nLevel0Entries :  Integer;


  currentLevel1Order : Integer;
  nLevel1Entries :  Integer;

  currentLevel2Order : Integer;
  nLevel2Entries : Integer;

  currentAmount_1Inc : Double;
  currentAmount_2Inc : Double;
  currentAmount_3Inc : Double;
  currentAmountTotalInc : Double;

  currentAmount_1Ex : Double;
  currentAmount_2Ex : Double;
  currentAmount_3Ex : Double;
  currentAmountTotalEx : Double;


  calculatingLevel1Total : Boolean;
  calculatingLevel2Total : Boolean;

  bookmark: TBookmark;

  displayFieldNames: TStringList;
  fieldsToShow : string;

  qrySaveReport : TERPQuery;
  qryIndex : TERPQuery;
  qryDeleteTotals : TERPQuery;

  qryDisplayReport : TERPQuery;

  qryLayout : TERPQuery;
  qryUpdateTotal : TERPQuery;


begin
 // inherited;

//  {$WARNINGS OFF}
//  ObjLayout := TProfitLossLayout.CreateWithNewConn(Self);
//  ObjLayout.Connection.connection := Self.MyConnection1;
//  ObjLayout.BusObjEvent := DoBusinessObjectEvent;
//  {$WARNINGS ON}

//   if ObjLayout.GetLayoutToUse = 0 then
 //     PnlSQLObj.UseCustomLayout := false
 //  else
 //     PnlSQLObj.UseCustomLayout := true;

  //  ShowMessage('CalculateTotals');

   if not UseCustomLayout then
      Exit;



       qrySaveReport := TERPQuery.Create(nil);
       qrySaveReport.Connection := SharedConnection;
 //  qrySaveReport := SharedQuery;

      //          ShowMessage(' creating table ' +  TempTableName + '_1');


   qrySaveReport.SQL.Text := 'CREATE TABLE ' + TempTableName + '_1 SELECT * FROM (' + QrymainSQLList.Text + ') Report';
  // qrySaveReport.SQL.Text := 'CREATE TABLE ' + TempTableName + '_1 SELECT * FROM (' + qryMain.SQL.Text + ') Report';
 //  qrySaveReport.SQL.Text := 'CREATE TABLE ' + PnLSQLObj.TempTableName + '_1 SELECT * FROM (' + PnLSQLObj.QrymainSQLList.Text + ') Report';
   qrySaveReport.Execute;

   Sleep(1000);



     qryIndex := TERPQuery.Create(nil);
       qryIndex.Connection := SharedConnection;
 //  qryIndex := SharedQuery;

   qryIndex.SQL.Text := 'ALTER TABLE ' + TempTableName + '_1 ADD COLUMN ReportIndex INT(11) NOT NULL DEFAULT 0 AFTER `seqno`;';
   qryIndex.Execute;


 //     Sleep(1000);

   qryIndex.SQL.Text := 'SET @i := 0 ; UPDATE ' + TempTableName + '_1 SET ReportIndex = @i := (@i + 1) WHERE 1 = 1 ;';
   qryIndex.Execute;

 //     Sleep(1000);

   qryIndex.SQL.Text := 'ALTER TABLE ' + TempTableName + '_1 ADD PRIMARY KEY(ReportIndex);';
   qryIndex.Execute;

   qryIndex.SQL.Text := 'ALTER TABLE ' + TempTableName + '_1 MODIFY COLUMN ReportIndex INT AUTO_INCREMENT';
   qryIndex.Execute;



 //  qryIndex.SQL.Text := 'ALTER TABLE ' + PnLSQLObj.TempTableName + '_1 RENAME COLUMN `Account Type` TO Account_Type';
 //  qryIndex.Execute;

        qryDeleteTotals := TERPQuery.Create(nil);
       qryDeleteTotals.Connection := SharedConnection;
  // qryDeleteTotals := SharedQuery;


        qryDeleteTotals.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `HideTotal` = "T" '
                + ' WHERE HideTotal = "F" AND (IsLevel1Total IS NULL OR IsLevel1Total = 0) '
                + ' AND (IsLevel2Total IS NULL OR IsLevel2Total = 0) '
                + ' AND (IsLevel3Total IS NULL OR IsLevel3Total = 0);';

        qryDeleteTotals.SQL.Text := 'DELETE FROM ' + TempTableName + '_1 '
                + ' WHERE HideTotal = "F" AND (IsLevel1Total IS NULL OR IsLevel1Total = 0) '
                + ' AND (IsLevel2Total IS NULL OR IsLevel2Total = 0) '
                + ' AND (IsLevel3Total IS NULL OR IsLevel3Total = 0);';

   qryDeleteTotals.Execute;


      //             ShowMessage(' deleted totals ' );



 //  Clipboard.AsText := qrySaveReport.SQL.Text;

 //  qrySaveReport.Execute;

       qryDisplayReport := TERPQuery.Create(nil);
       qryDisplayReport.Connection := SharedConnection;



  //  qryDisplayReport := SharedQuery;

     qryDisplayReport.SQL.Text := 'SELECT * FROM ' + TempTableName + '_1'
                  + ' ORDER BY Level0Order, IsLevel0Total, Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total, TotalAmountInc';


   //   ShowMessage('qryDisplayReport.SQL.Text ' + qryDisplayReport.SQL.Text);


//    qryDisplayReport.SQL.Text := 'SELECT * FROM ' + PnLSQLObj.TempTableName + '_1'
//                  + ' ORDER BY FinalOrder, Level1Order, IsLevel1Total, Level2Order, IsLevel2Total, Level3Order, IsLevel3Total, TotalAmountInc';


//   qryDisplayReport.SQL.Text := 'SELECT * FROM ' + PnLSQLObj.TempTableName + '_1 Report '
//                              + ' UNION ALL '
//                              + 'SELECT Report.* FROM ' + PnLSQLObj.TempTableName + '_1 Report '
//                              + ' RIGHT JOIN tblpnllayoutdata Layout ON Report.AccountID = Layout.AccountID '
//                              + ' AND TRIM(Report.AccountName) = TRIM(Layout.Name) '
//                              + ' AND Layout.IsNewGroup = "T" '
//
//                              ;


         qryLayout := TERPQuery.Create(nil);
       qryLayout.Connection := SharedConnection;
 //  qryLayout := SharedQuery;

      qryLayout.SQL.Text := 'SELECT Name , Level1Order , IsLevel1Total FROM tblpnllayoutdata WHERE IsNewGroup = "T"';
      qryLayout.Open;

      qryDisplayReport.Open;

       //                  ShowMessage(' qryDisplayReport opened ' );



   //    fieldNames := TStringList.Create;

   //   qryMain.GetFieldNames(fieldNames);

  //    ShowMessage(fieldNames.Text);



  //    qryDisplayReport.Last;

      while not qryLayout.EOF do
      begin



         qryDisplayReport.Locate('Level1Order', qryLayout.FieldByName('Level1Order').AsInteger, []);

         finalOrder := qryDisplayReport.FieldByName('FinalOrder').AsInteger ;

         if AnsiPos('Total', qryLayout.FieldByName('Name').AsString) > 0 then
         begin

              while qryDisplayReport.FieldByName('Level1Order').AsInteger =  qryLayout.FieldByName('Level1Order').AsInteger do
                  qryDisplayReport.Next;
         end;

         qryDisplayReport.Insert;

         qryDisplayReport.FieldByName('AccountName').AsString :=  qryLayout.FieldByName('Name').AsString;
         qryDisplayReport.FieldByName('Level1Order').AsString :=  qryLayout.FieldByName('Level1Order').AsString;
         qryDisplayReport.FieldByName('IsLevel1Total').AsString :=  qryLayout.FieldByName('IsLevel1Total').AsString;
         qryDisplayReport.FieldByName('FinalOrder').AsInteger := finalOrder;

         qryDisplayReport.Post;

         qryLayout.Next;
      end;

   // PnLSQLObj.TempTableName;


       qryUpdateTotal := TERPQuery.Create(nil);
       qryUpdateTotal.Connection := SharedConnection;
   //      qryUpdateTotal := SharedQuery;



   qryDisplayReport.First;


   totalLevel1Amount_1Inc := 0.0;
   totalLevel1Amount_2Inc := 0.0;
   totalLevel1Amount_3Inc := 0.0;
   totalLevel1AmountTotalInc := 0.0;
   totalLevel1Amount_1Ex := 0.0;
   totalLevel1Amount_2Ex := 0.0;
   totalLevel1Amount_3Ex := 0.0;
   totalLevel1AmountTotalEx := 0.0;

   while not qryDisplayReport.EOF do
   begin


      nLevel1Entries := 0;


      currentLevel0Order :=  qryDisplayReport.FieldByName('Level0Order').AsInteger;


      currentLevel1Order :=  qryDisplayReport.FieldByName('Level1Order').AsInteger;

      currentLevel2Order :=  qryDisplayReport.FieldByName('Level2Order').AsInteger;


      if  qryDisplayReport.FieldByName('IsLevel0Total').AsInteger = 1 then
      begin
         qryUpdateTotal.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             ;

          qryUpdateTotal.Execute;

        qryUpdateTotal.SQL.Text := 'SELECT SUM(1_AmountColumnInc) AS TotalLevel0Amount_1Inc ,'
                                +  ' SUM(2_AmountColumnInc) AS TotalLevel0Amount_2Inc ,'
                                +  ' SUM(3_AmountColumnInc) AS TotalLevel0Amount_3Inc ,'
                                +  ' SUM(TotalAmountInc) AS TotalLevel0AmountTotalInc ,'
                                +  ' SUM(1_AmountColumnEx) AS TotalLevel0Amount_1Ex ,'
                                +  ' SUM(2_AmountColumnEx) AS TotalLevel0Amount_2Ex ,'
                                +  ' SUM(3_AmountColumnEx) AS TotalLevel0Amount_3Ex ,'
                                +  ' SUM(TotalAmountEx) AS TotalLevel0AmountTotalEx '
                                + ' FROM ' + TempTableName + '_1 WHERE Level0Order = ' + IntToStr(currentLevel0Order)
                                + ' AND IsLevel1Total = 0 AND IsLevel2Total = 0';
         qryUpdateTotal.Open;

     //    ShowMessage('currentLevel1Order ' + IntToStr(currentLevel1Order) + '  Total ' + FloatToStr(qryUpdateTotal.FieldByName('Total').AsFloat));
         totalLevel0Amount_1Inc :=  qryUpdateTotal.FieldByName('TotalLevel0Amount_1Inc').AsFloat;
         totalLevel0Amount_2Inc :=  qryUpdateTotal.FieldByName('TotalLevel0Amount_2Inc').AsFloat;
         totalLevel0Amount_3Inc :=  qryUpdateTotal.FieldByName('TotalLevel0Amount_3Inc').AsFloat;
         totalLevel0AmountTotalInc :=  qryUpdateTotal.FieldByName('TotalLevel0AmountTotalInc').AsFloat;
         totalLevel0Amount_1Ex :=  qryUpdateTotal.FieldByName('TotalLevel0Amount_1Ex').AsFloat;
         totalLevel0Amount_2Ex :=  qryUpdateTotal.FieldByName('TotalLevel0Amount_2Ex').AsFloat;
         totalLevel0Amount_3Ex :=  qryUpdateTotal.FieldByName('TotalLevel0Amount_3Ex').AsFloat;
         totalLevel0AmountTotalEx :=  qryUpdateTotal.FieldByName('TotalLevel0AmountTotalEx').AsFloat;
         qryUpdateTotal.Close;

          qryUpdateTotal.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnInc` = ' + FloatToStr(totalLevel0Amount_1Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnInc` = ' + FloatToStr(totalLevel0Amount_2Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnInc` = ' + FloatToStr(totalLevel0Amount_3Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountInc` = ' + FloatToStr(totalLevel0AmountTotalInc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnEx` = ' + FloatToStr(totalLevel0Amount_1Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnEx` = ' + FloatToStr(totalLevel0Amount_2Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnEx` = ' + FloatToStr(totalLevel0Amount_3Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountEx` = ' + FloatToStr(totalLevel0AmountTotalEx) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'

             ;

         qryUpdateTotal.Execute;

      end;


      if  qryDisplayReport.FieldByName('IsLevel1Total').AsInteger = 1 then
      begin
         qryUpdateTotal.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             ;

          qryUpdateTotal.Execute;

        qryUpdateTotal.SQL.Text := 'SELECT SUM(1_AmountColumnInc) AS TotalLevel1Amount_1Inc ,'
                                +  ' SUM(2_AmountColumnInc) AS TotalLevel1Amount_2Inc ,'
                                +  ' SUM(3_AmountColumnInc) AS TotalLevel1Amount_3Inc ,'
                                +  ' SUM(TotalAmountInc) AS TotalLevel1AmountTotalInc ,'
                                +  ' SUM(1_AmountColumnEx) AS TotalLevel1Amount_1Ex ,'
                                +  ' SUM(2_AmountColumnEx) AS TotalLevel1Amount_2Ex ,'
                                +  ' SUM(3_AmountColumnEx) AS TotalLevel1Amount_3Ex ,'
                                +  ' SUM(TotalAmountEx) AS TotalLevel1AmountTotalEx '
                                + ' FROM ' + TempTableName + '_1 WHERE Level1Order = ' + IntToStr(currentLevel1Order)
                                + ' AND IsLevel2Total = 0';
         qryUpdateTotal.Open;

     //    ShowMessage('currentLevel1Order ' + IntToStr(currentLevel1Order) + '  Total ' + FloatToStr(qryUpdateTotal.FieldByName('Total').AsFloat));
         totalLevel1Amount_1Inc :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_1Inc').AsFloat;
         totalLevel1Amount_2Inc :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_2Inc').AsFloat;
         totalLevel1Amount_3Inc :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_3Inc').AsFloat;
         totalLevel1AmountTotalInc :=  qryUpdateTotal.FieldByName('TotalLevel1AmountTotalInc').AsFloat;
         totalLevel1Amount_1Ex :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_1Ex').AsFloat;
         totalLevel1Amount_2Ex :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_2Ex').AsFloat;
         totalLevel1Amount_3Ex :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_3Ex').AsFloat;
         totalLevel1AmountTotalEx :=  qryUpdateTotal.FieldByName('TotalLevel1AmountTotalEx').AsFloat;
         qryUpdateTotal.Close;

          qryUpdateTotal.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnInc` = ' + FloatToStr(totalLevel1Amount_1Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnInc` = ' + FloatToStr(totalLevel1Amount_2Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnInc` = ' + FloatToStr(totalLevel1Amount_3Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountInc` = ' + FloatToStr(totalLevel1AmountTotalInc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnEx` = ' + FloatToStr(totalLevel1Amount_1Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnEx` = ' + FloatToStr(totalLevel1Amount_2Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnEx` = ' + FloatToStr(totalLevel1Amount_3Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountEx` = ' + FloatToStr(totalLevel1AmountTotalEx) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'

             ;

         qryUpdateTotal.Execute;

      end;

      if  qryDisplayReport.FieldByName('IsLevel2Total').AsInteger = 1 then
      begin
         qryUpdateTotal.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountInc` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountEx` = 0 WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             ;

          qryUpdateTotal.Execute;

        qryUpdateTotal.SQL.Text := 'SELECT SUM(1_AmountColumnInc) AS TotalLevel1Amount_1Inc ,'
                                +  ' SUM(2_AmountColumnInc) AS TotalLevel1Amount_2Inc ,'
                                +  ' SUM(3_AmountColumnInc) AS TotalLevel1Amount_3Inc ,'
                                +  ' SUM(TotalAmountInc) AS TotalLevel1AmountTotalInc ,'
                                +  ' SUM(1_AmountColumnEx) AS TotalLevel1Amount_1Ex ,'
                                +  ' SUM(2_AmountColumnEx) AS TotalLevel1Amount_2Ex ,'
                                +  ' SUM(3_AmountColumnEx) AS TotalLevel1Amount_3Ex ,'
                                +  ' SUM(TotalAmountEx) AS TotalLevel1AmountTotalEx '
                                + ' FROM ' + TempTableName + '_1 WHERE Level2Order = ' + IntToStr(currentLevel2Order)
                                + ' AND Level1Order = ' + IntToStr(currentLevel1Order)
                                ;
         qryUpdateTotal.Open;

     //    ShowMessage('currentLevel1Order ' + IntToStr(currentLevel1Order) + '  Total ' + FloatToStr(qryUpdateTotal.FieldByName('Total').AsFloat));
         totalLevel1Amount_1Inc :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_1Inc').AsFloat;
         totalLevel1Amount_2Inc :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_2Inc').AsFloat;
         totalLevel1Amount_3Inc :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_3Inc').AsFloat;
         totalLevel1AmountTotalInc :=  qryUpdateTotal.FieldByName('TotalLevel1AmountTotalInc').AsFloat;
         totalLevel1Amount_1Ex :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_1Ex').AsFloat;
         totalLevel1Amount_2Ex :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_2Ex').AsFloat;
         totalLevel1Amount_3Ex :=  qryUpdateTotal.FieldByName('TotalLevel1Amount_3Ex').AsFloat;
         totalLevel1AmountTotalEx :=  qryUpdateTotal.FieldByName('TotalLevel1AmountTotalEx').AsFloat;
         qryUpdateTotal.Close;

          qryUpdateTotal.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnInc` = ' + FloatToStr(totalLevel1Amount_1Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnInc` = ' + FloatToStr(totalLevel1Amount_2Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnInc` = ' + FloatToStr(totalLevel1Amount_3Inc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountInc` = ' + FloatToStr(totalLevel1AmountTotalInc) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnEx` = ' + FloatToStr(totalLevel1Amount_1Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnEx` = ' + FloatToStr(totalLevel1Amount_2Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnEx` = ' + FloatToStr(totalLevel1Amount_3Ex) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
             + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountEx` = ' + FloatToStr(totalLevel1AmountTotalEx) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'

             ;

         qryUpdateTotal.Execute;

      end;


      qryDisplayReport.Next;

      continue;



   end;


         displayFieldNames := TStringList.Create;

      qryDisplayReport.GetFieldNames(displayFieldNames);

  //    ShowMessage('displayFieldNames ' + displayFieldNames.Text);

      for f := 0 to displayFieldNames.Count - 1 do
      begin

      if Pos(' ', displayFieldNames[f]) >0 then
          displayFieldNames[f] := '`' + displayFieldNames[f] + '`';

      end;

      qryDisplayReport.Close;


     //            qryIndex.SQL.Text := 'ALTER TABLE ' + PnLSQLObj.TempTableName + '_1 MODIFY COLUMN 1_AmountColumnInc VARCHAR(17);';
 //  qryIndex.Execute;




      qryDisplayReport.Open;


      while not  qryDisplayReport.EOF do
      begin

  //    if qryDisplayReport.FieldByName('1_AmountColumnInc') is TFloatField then
   //          (qryDisplayReport.FieldByName('1_AmountColumnInc') as TFloatField).DisplayFormat :=  '#######.00';

   //     if not (qryDisplayReport.FieldByName('1_AmountColumnInc').AsString = '') then
   //     begin
        // ShowMessage('format ' + FormatFloat('0.00', qryDisplayReport.FieldByName('1_AmountColumnInc').AsFloat));

            qryUpdateTotal.SQL.Text := 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnInc` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('1_AmountColumnInc').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
                                     + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnInc` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('2_AmountColumnInc').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
                                     + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnInc` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('3_AmountColumnInc').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
                                     + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountInc` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('TotalAmountInc').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
                                     + 'UPDATE ' + TempTableName + '_1 SET `1_AmountColumnEx` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('1_AmountColumnEx').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
                                     + 'UPDATE ' + TempTableName + '_1 SET `2_AmountColumnEx` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('2_AmountColumnEx').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
                                     + 'UPDATE ' + TempTableName + '_1 SET `3_AmountColumnEx` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('3_AmountColumnEx').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
                                     + 'UPDATE ' + TempTableName + '_1 SET `TotalAmountEx` = ' + FormatFloat('0.00', qryDisplayReport.FieldByName('TotalAmountEx').AsFloat) +' WHERE ReportIndex = ' + qryDisplayReport.FieldByName('ReportIndex').AsString + ' ;'
;

      //        ShowMessage('qryUpdateTotal.SQL.Text ' + qryUpdateTotal.SQL.Text);
       //       ClipBoard.AsText := qryUpdateTotal.SQL.Text;

             qryUpdateTotal.Execute;
    //     end;

    TFloatField(qryDisplayReport.FieldByName('1_AmountColumnInc')).DisplayFormat := '#,##0.00';


         qryDisplayReport.Next;
      end;

      qryDisplayReport.Close;



//  //         displayFieldNames.Delete(displayFieldNames.IndexOf('Account Type'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('AccountID'));
//  //      displayFieldNames.Delete(displayFieldNames.IndexOf('AccountNo'));
//
//       displayFieldNames.Delete(displayFieldNames.IndexOf('AccountType'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('ReportIndex'));
//        displayFieldNames.Delete(displayFieldNames.IndexOf('FinalOrder'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('AccountHeaderOrder'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('AccountSub1Order'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('AccountSub2Order'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('AccountSub3Order'));
//
//       displayFieldNames.Delete(displayFieldNames.IndexOf('SubTotalInc'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('SubTotalEx'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('HideTotal'));
//
//       displayFieldNames.Delete(displayFieldNames.IndexOf('Level1Order'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('IsLevel1Total'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('Level2Order'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('IsLevel2Total'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('Level3Order'));
//       displayFieldNames.Delete(displayFieldNames.IndexOf('IsLevel3Total'));
//
//       fieldsToShow :=  StringReplace(displayFieldNames.CommaText , '"', '' , [rfReplaceAll]);
//
//     //  ShowMessage(fieldsToShow);
//
//       qryDisplayReport.SQL.Text  := StringReplace(qryDisplayReport.SQL.Text, '*', fieldsToShow , []);

             Clipboard.AsText := qryDisplayReport.SQL.Text;


       SQL.Text :=  qryDisplayReport.SQL.Text;


   //  ShowMessage('Calculated Totals ' );


     //   grdMain.DataSource := dsDisplayReport;

     //   qryMain := qryDisplayReport;


    //   qryDisplayReport.Open;




    //    LabelChange;




end;

function TProfitAndLossReport.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
var
  scr: TERPScript;
  FCR: TERPQuery;
  ctr: Integer;
  QryMainSQLList: TStringList;
  iSQLCounter: Integer;
  StringList4SQL: TStringList;
  tmptablename, tmpfilename: String;
  sl: TStringList;

  procedure ReportHeader;
  begin
    if Assigned(StringListForSQL) then begin
      StringListForSQL.Clear;
      StringListForSQL.Add('{ReportHeader}Select');
      StringListForSQL.Add('CO.COMPANYNAME,');
      StringListForSQL.Add('CO.ADDRESS,');
      StringListForSQL.Add('CO.ADDRESS2,');
      StringListForSQL.Add('CO.CITY,');
      StringListForSQL.Add('CO.STATE,');
      StringListForSQL.Add('CO.POSTCODE,');
      StringListForSQL.Add('CONCAT("PHONE ",CO.PHONENUMBER) AS PHONENUMBER,');
      StringListForSQL.Add('CONCAT("FAX ",CO.FAXNUMBER) AS FAXNUMBER,');
      StringListForSQL.Add('CO.ABN , Convert(:FROMDate,Date) as FROMDate , Convert(:TODate, Date) as TODate');
      StringListForSQL.Add('From TBLCOMPANYINFORMATION AS CO');
      StringListForSQL.Add('~|||~{Repdata}');
    end;
  end;

begin
  Result := inherited;

  if not Assigned(StringListForSQL) then begin
    sl := TStringList.Create;
    StringListForSQL := sl;
  end else sl := nil;

  try
    FCR := DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));

    try
      LoadFCPref(FCR, fReportClassName, True);

      if not SameText(ReportClassName, 'TBalanceSheetGUI') then begin
        MakeReportTable;
        scr := TERPScript.Create(nil);

        try
          scr.Connection := SharedConnection;
          CleanRefresh_PL_Table;
          tmptablename := TempTableUtils.UniqueTableName(fReportClassName, SharedConnection);

    {|--------------update accountnumber from the Chart of accounts table }
    {|}             scr.SQL.Add(SQLfortemptable('tblchartofaccounts', 'Accountnumber', '', 'INNER JOIN '+TempTableName + ' T ON  M.AccountId = IFNULL(T.AccountId, 0)', tmptablename, tmpfilename, SharedConnection));
    {|}             scr.SQL.Add('UPDATE ' + TempTableName + ' AS T INNER JOIN ' + tmptablename + ' C on C.AccountId = T.AccountId '+
    {|}                                    ' SET T.accountno = C.Accountnumber WHERE IFNULL(T.AccountId,0) <> 0;');
    {|}
    {|--------------update foreigncurrency fields}
    {|}             if FCR.recordCount > 0 then begin
    {|}               FCR.First;
    {|}               scr.SQL.Add('UPDATE ' + TempTableName  + ' SET ' );
    {|}               while FCR.Eof = False do begin
    {|}                 if not FCR.BOF then
    {|}                   scr.SQL.Add(',');
    {|}                 for ctr := low(AmountFieldList) to high(AmountFieldList) do begin
    {|}                   if ctr > low(AmountFieldList) then scr.SQL.Add(',');
    {|}                     scr.SQL.Add( '`' +FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr] + '`  = `'+ AmountFieldList[ctr] +  '` * ' + FCR.Fieldbyname('Code').asString + '_FCRate');
    {|}                 end;
    {|}
    {|}                 FCR.Next;
    {|}               end;
    {|}               scr.SQL.Add(';');
    {|}             end;

    {|--------------update Sub totals}
    {|}             scr.SQL.Add(SubtotalupdateSQL);
    {|--------------Execute all update sqls}
                    DoShowProgressbar(scr.Statements.Count, 'Updating Account Number' );
                    try
                      scr.OnError := OnScriptTempError;
                      scr.Execute;
                    finally
                      dohideProgressbar();
                    end;
        finally
          //AppEnv.UtilsClient.DeleteServerFiles(ReplaceStr(tmpfilename, '.tmp' , '*.tmp'));
          AppEnvVirt.DeleteServerFiles(ReplaceStr(tmpfilename, '.tmp', '*.tmp'));
          scr.Free;
        end;
      end;

      QrymainSQLList := TStringList.Create;

      try
        ReportHeader;

        for iSQLCounter := 1 to 2 do begin
          if iSQLCounter = 2 then StringList4SQL := StringListForSQL
          else StringList4SQL := QrymainSQLList;

          // Create the SQL for the report
          CreateSQL4Report(StringList4SQL, FCR);
          if StringList4SQL.Text = '' then begin
            Result := False;
            msg := 'No such layout';
            Exit;
          end;

        end;

        SQL.Clear;
        SQL.Text := QrymainSQLList.Text;
        //self.RefreshOrignalSQL;
      finally
        if Assigned(QrymainSQLList) then FreeAndNil(QrymainSQLList);
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(FCR);
    end;
  finally
    sl.Free;
  end;
end;

procedure TProfitAndLossReport.CreateSQL4Report(ASQL: TStrings; AFCR: TERPQuery);
var
  FCR, qryTemp: TERPQuery;
  StringList4SQL :TStringList;
  sName, sPrevRootName, sPos: string;
  iMaxLevel, iLevel, iID: Integer;
  bRoot, bAccount: Boolean;
  K, seqNo: Integer;
  MyClass: TComponent;

  procedure AddCaptions;
  begin
    if APIMode then Exit;

    if FCR.recordCount <> 0 then begin
      FCR.First;
      StringList4SQL.Add(Quotedstr(Appenvvirt.str['RegionalOptions.ForeignExDefault']) + ' AS Defaultcurrency_Caption,' );
      While not FCR.EOF do begin
        StringList4SQL.Add(Quotedstr(FCR.Fieldbyname('Code').AsString) + ' AS `' + FCR.Fieldbyname('Code').AsString + '_Caption`,' );
        FCR.Next;
      end;
    end;
    if ActiveDepartments.RecordCount > 0 then begin
      ActiveDepartments.First;
      while not ActiveDepartments.EOF do begin
        StringList4SQL.Add(Quotedstr(ActiveDepartments.fieldByname('ClassName').AsString)  + ' as `' +
          Trim(inttostr(ActiveDepartments.FieldByName('ClassId').AsInteger)) + '_Caption`,' );
        ActiveDepartments.Next;
      end;
    end;
  end;

  procedure AddAmountFields(Const AmountZero: Boolean = False);
  var
    ctr1: Integer;
  begin
    if AmountZero then begin
      for ctr1 := Low(AmountFieldList) to High(AmountFieldList) do
        StringList4SQL.Add('0.0 AS `' + AmountFieldList[ctr1]  + '`,');
    end else begin
      for ctr1 := Low(AmountFieldList) to High(AmountFieldList) do
          StringList4SQL.Add('SUM(`' + AmountFieldList[ctr1]+ '`) AS `' + AmountFieldList[ctr1]  + '`,');
    end;

    if FCR.RecordCount = 0 then Exit;

    FCR.First;
    While not FCR.EOF do begin
      for ctr1 := low(AmountFieldList) to high(AmountFieldList) do
        if AmountZero then begin
          StringList4SQL.Add('0.0 AS `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]  + '`,');
        end else begin
          StringList4SQL.Add('SUM(`' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]+ '`) AS `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldLIst[ctr1]  + '`,');
        end;
      FCR.Next;
    end;

  end;

  procedure AddSpaceLine;
  var
    M: Integer;
  begin
    // Space
    Inc(seqNo);
    StringList4SQL.Add('UNION ALL');
    StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "F" AS IsRoot,');
    StringList4SQL.Add('"" AS AccountNo,');
    StringList4SQL.Add('"" AS AccountName,');
    StringList4SQL.Add('0 AS FinalOrder,');
    StringList4SQL.Add('"" AS AccountHeaderOrder,');
    StringList4SQL.Add('"" AS AccountSub1Order,');
    StringList4SQL.Add('"" AS AccountSub2Order,');
    StringList4SQL.Add('"" AS AccountSub3Order,');
    StringList4SQL.Add('"" AS AccountType,');
    for M := 1 to iMaxLevel do begin
      StringList4SQL.Add('"" AS Level' + IntToStr(M) + ',');
    end;
    StringList4SQL.Add('"" AS "Account Type",');
    AddCaptions;
    AddAmountFields(true);
    StringList4SQL.Add('null AS SubTotalInc,');
    StringList4SQL.Add('null AS SubTotalEx,');
    StringList4SQL.Add('"T" AS HideTotal');

  end;

begin
  StringList4SQL := TStringList.Create;
  try
    FCR := AFCR;
    // Fetch layout data
    qryTemp :=  DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
    with qryTemp do begin
      SQL.Clear;
      SQL.Add('SELECT MAX(LENGTH(Pos) DIV 2) AS MaxLevel FROM tblPnLLayoutData3 WHERE IsAccount="F" AND LayoutID=' + IntToStr(fLayoutID));
      Open;

      if RecordCount = 0 then Exit;

      iMaxLevel := FieldByName('MaxLevel').AsInteger;
      Close;

      SQL.Clear;
      SQL.Add('SELECT ID, Parent, Pos, `Name`, IsRoot, IsAccount FROM tblPnLLayoutData3 WHERE IsAccount="F" AND LayoutID=' + IntToStr(fLayoutID));
      SQL.Add('ORDER BY Pos');
      Open;

      if RecordCount = 0 then Exit;

      seqNo := 0;
      sPrevRootName := '';

      First;
      while not EOF do begin
        iID := FieldByName('ID').AsInteger;
        sName := FieldByName('Name').AsString;
        sPos := FieldByName('Pos').AsString;
        iLevel := Length(sPos) div 2;
        bRoot := FieldByName('IsRoot').AsBoolean;
        bAccount := FieldByName('IsAccount').AsBoolean;

        // If root
        if bRoot then begin
          if sName = 'Income' then begin
            // Income
            Inc(seqNo);
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"INC" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              //StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "' + sName + '", "") AS Level' + IntToStr(K) + ',');
              StringList4SQL.Add('"" AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Income" AS "Account Type",');
            AddCaptions;
            AddAmountFields(True);
            StringList4SQL.Add('null AS SubTotalInc,');
            StringList4SQL.Add('null AS SubTotalEx,');
            StringList4SQL.Add('"T" AS HideTotal');
          end;

          if sName = 'Cost of Goods Sold' then begin
            // Total Income
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"INC" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Total Income", "") AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Total Income" AS "Account Type",');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
            StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTableName);
            StringList4SQL.Add('WHERE AccountType = "EXINC" OR AccountType = "INC"');
            StringList4SQL.Add('GROUP BY "' + GetRootInitial(sName) + '"');

            // Space line
            AddSpaceLine;

            // Cost of Goods Sold
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"COGS" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              //StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "' + sName + '", "") AS Level' + IntToStr(K) + ',');
              StringList4SQL.Add('"" AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Cost of Goods Sold" AS "Account Type",');
            AddCaptions;
            AddAmountFields(True);
            StringList4SQL.Add('null AS SubTotalInc,');
            StringList4SQL.Add('null AS SubTotalEx,');
            StringList4SQL.Add('"T" AS HideTotal');
          end;

          if sName = 'Expense' then begin
            // Total COGS
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"COGS" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Total COGS", "") AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Total COGS" AS "Account Type",');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
            StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTableName);
            StringList4SQL.Add('WHERE (AccountType = "COGS")');
            StringList4SQL.Add('GROUP BY "COGS"');

            // Space line
            AddSpaceLine;

            // Expense
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"EXP" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              //StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "' + sName + '", "") AS Level' + IntToStr(K) + ',');
              StringList4SQL.Add('"" AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Expense" AS "Account Type",');
            AddCaptions;
            AddAmountFields(True);
            StringList4SQL.Add('null AS SubTotalInc,');
            StringList4SQL.Add('null AS SubTotalEx,');
            StringList4SQL.Add('"T" AS HideTotal');
          end;

          if sName = 'Gross Profit' then begin
            // Total Expense
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"EXP" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Total Expense", "") AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Total Expense" AS "Account Type",');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
            StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTableName);
            StringList4SQL.Add('WHERE (AccountType = "EXEXP" OR AccountType = "EXP")');
            StringList4SQL.Add('GROUP BY "EXP"');

            // Space line
            AddSpaceLine;

            // Gross Profit
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Gross Profit", "") AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Gross Profit" AS "Account Type",');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
            StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTableName);
            StringList4SQL.Add('WHERE (AccountType = "COGS" OR AccountType = "EXINC" OR AccountType = "INC")');
            StringList4SQL.Add('GROUP BY seqno');

            // Space line
            AddSpaceLine;
          end;

          if sName = 'Net Income' then begin
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            StringList4SQL.Add('"" AS AccountNo,');
            StringList4SQL.Add('"" AS AccountName,');
            StringList4SQL.Add('0 AS FinalOrder,');
            StringList4SQL.Add('"" AS AccountHeaderOrder,');
            StringList4SQL.Add('"" AS AccountSub1Order,');
            StringList4SQL.Add('"" AS AccountSub2Order,');
            StringList4SQL.Add('"" AS AccountSub3Order,');
            StringList4SQL.Add('"INC" AS AccountType,');
            for K := 1 to iMaxLevel do begin
              StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Net Income", "") AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.Add('"Net Income" AS "Account Type",');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
            StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTableName);
            StringList4SQL.Add('WHERE (AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS")');
            StringList4SQL.Add('GROUP BY seqno');
          end;

        end;

        // If group
        if not bRoot then begin
          Inc(seqNo);
          StringList4SQL.Add('UNION ALL');
          StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, T.AccountID, "F" AS IsRoot,');
          StringList4SQL.Add('"" AS AccountNo,');
          StringList4SQL.Add(QuotedStr(sName) + ' AS AccountName,');
          StringList4SQL.Add('0 AS FinalOrder,');
          StringList4SQL.Add('AccountHeaderOrder,');
          StringList4SQL.Add('AccountSub1Order,');
          StringList4SQL.Add('AccountSub2Order,');
          StringList4SQL.Add('AccountSub3Order,');
          StringList4SQL.Add('"" AS AccountType,');
          for K := 1 to iMaxLevel do begin
            StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "' + sName + '", "") AS Level' + IntToStr(K) + ',');
          end;
          StringList4SQL.Add('"" AS "Account Type",');
          AddCaptions;
          AddAmountFields;
          StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
          StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
          StringList4SQL.Add('"T" AS HideTotal');
          StringList4SQL.Add('FROM tblPnLLayoutData3 L LEFT JOIN ' + TempTableName + ' T ON L.AccountID=T.AccountID');
  //        StringList4SQL.Add('WHERE L.Parent=' + IntToStr(iID));
          StringList4SQL.Add('WHERE LEFT(L.Pos, ' + IntToStr(iLevel * 2) + ') = ' + QuotedStr(sPos));
        end;

        Next;
      end;
    end;

    DbSharedObj.ReleaseObj(qryTemp);

    ASQL.Add(StringList4SQL.Text + ';');
    LogText(ASQL.Text);

  finally
    StringList4SQL.Free;
  end;

end;

function TProfitAndLossReport.GetRootInitial(ARootName: string) : string;
begin
  if ARootName = 'Income' then Result := 'INC';
  if ARootName = 'Cost of Goods Sold' then Result := 'COGS';
  if ARootName = 'Expense' then Result := 'EXP';
end;

procedure TProfitAndLossReport.SetSelectedDepartments(const Value: string);
begin
  fSelectedDepartments.CommaText := Value;
end;

function TProfitAndLossReport.SubtotalUpdateSQL: String;
var
  SubTotalIncSQL, SubTotalExSQL: String;
begin
  Result := 'UPDATE ' + TempTableName + ' SET SubTotalInc = 0;' +
            'UPDATE ' + TempTableName + ' SET SubTotalEx  = 0;';
  if AllDepartments then Exit;
  if ActiveDepartments.Recordcount = 0 then Exit;

   ActiveDepartments.First;
   SubTotalIncSQL := '';
   SubTotalExSQL  := '';
   while ActiveDepartments.Eof = False do begin
     if Self.DepartmentSelected(ActiveDepartments.FieldByName('ClassName').AsString) then begin
//       if SubTotalIncSQL <> '' then SubTotalIncSQL := SubTotalIncSQL + ' + '; SubTotalIncSQL := SubTotalIncSQL + '`' + Trim(inttostr(ActiveDepartments.FieldByName('ClassId').AsInteger)) + '_AmountColumnInc` ';
//       if SubTotalExSQL  <> '' then SubTotalExSQL  := SubTotalExSQL  + ' + '; SubTotalExSQL  := SubTotalExSQL  + '`' + Trim(inttostr(ActiveDepartments.FieldByName('ClassId').AsInteger)) + '_AmountColumnEx`  ';
       if SubTotalIncSQL <> '' then SubTotalIncSQL := SubTotalIncSQL + ' + '; SubTotalIncSQL := SubTotalIncSQL + '`' + ActiveDepartments.FieldByName('ClassName').AsString + '_AmountColumnInc` ';
       if SubTotalExSQL  <> '' then SubTotalExSQL  := SubTotalExSQL  + ' + '; SubTotalExSQL  := SubTotalExSQL  + '`' + ActiveDepartments.FieldByName('ClassName').AsString + '_AmountColumnEx`  ';
     end;
     ActiveDepartments.Next;
   end;
   if SubTotalIncSQL <> '' then Result := Result + ' UPDATE ' + TempTableName + ' SET SubTotalInc = ' + SubTotalIncSQL+';';
   if SubTotalExSQL <> '' then Result := Result + ' UPDATE ' + TempTableName + ' SET SubTotalEx = ' + SubTotalExSQL+';';
end;

initialization
  RegisterClass(TProfitAndLossReport);

end.
