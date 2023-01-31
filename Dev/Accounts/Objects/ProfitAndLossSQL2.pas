unit ProfitAndLossSQL2;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type

  TProfitAndLossReport2 = class(TReportWithDateRangeBase)
  private
    fTempTableName: string;
    FCFields :String;
    fIncludedataPriorToClosingDate: boolean;
    (*fDateTo: TDateTime;
    fDateFrom: TDateTime;*)
    fReportClassName: string;
//    fProgressDialog: TComponent;
    fAllDetartments: boolean;
//    fSelectedDepartmentID: integer;
    fDetailReport: boolean;
    fAllAccounts: boolean;
    fStringListForSQL: TStringList;
    fSelectedDepartments: TStringList;
    fActiveDepartments: TERPQuery;
    fClientID: integer;
    procedure OnScriptTempError(Sender: TObject; E: Exception; SQL: string;var Action: TErrorAction);
    procedure MakeReportTable;
    function GetSelectedDepartments: string;
    procedure SetSelectedDepartments(const Value: string);
//    function GetDepartmentName: string;
//    procedure SetDepartmentName(const Value: string);
    function ActiveDepartments: TERPQuery;
    function GetRootInitial(ARootName: string) : string;
  public
    AmountFieldList, AmountCaptionList: TStringDynArray;
    constructor Create; override;
    destructor Destroy; override;
    property TempTableName: string read fTempTableName;
    function PopulateReportSQL1(SQL: TStrings; var msg: string): Boolean;
    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;
    procedure CreateSQL4Report(ASQL: TStrings; AFCR: TERPQuery);

    property ReportClassName: string read fReportClassName write fReportClassName;
//    property ProgressDialog: TComponent read fProgressDialog write fProgressDialog;
    property StringListForSQL: TStringList read fStringListForSQL write fStringListForSQL;
    function DepartmentSelected(const aDeptName: string): boolean;
    function SubtotalUpdateSQL: String;
    procedure CleanRefresh_PL_Table; virtual;
    property ClientID: integer read fClientID write fClientID;
  published
    property IncludePriorClosingDate: boolean read fIncludedataPriorToClosingDate write fIncludedataPriorToClosingDate;
    (*property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;*)
    property AllDepartments: boolean read fAllDetartments write fAllDetartments;
    property SelectedDepartments: string read GetSelectedDepartments write SetSelectedDepartments;
//    property DepartmentID: integer read fSelectedDepartmentID write fSelectedDepartmentID;
//    property DepartmentName: string read GetDepartmentName write SetDepartmentName;
    property DetailReport: boolean read fDetailReport write fDetailReport;
    property AllAccounts: boolean read fAllAccounts write fAllAccounts;
  end;

implementation

uses
  TempTableUtils,BaseListUtilsObj,
  (*BusObjBase, AppEnvironment, *)Report_ProfitnLoss_Obj,
  StrUtils, (*CommonDbLib, BusObjClass, *)tcConst, TransactionsTable,
  AppEnvVirtualObj, AppEnvironmentVirtual, DbSharedObjectsObj, FCOnreportLib;

{ TProfitAndLossReport2 }

function TProfitAndLossReport2.ActiveDepartments: TERPQuery;
begin
  if not Assigned(fActiveDepartments) then begin
    fActiveDepartments := TERPQuery.Create(nil);
    fActiveDepartments.Connection := SharedConnection;
    fActiveDepartments.Connection := SharedConnection;
    fActiveDepartments.SQL.Add('select ClassID, ClassName from tblclass');
    fActiveDepartments.SQL.Add('where active = "T" and ifnull(ClassName , "") <> ""');
    fActiveDepartments.Open;
  end;
  result := fActiveDepartments;
end;

procedure TProfitAndLossReport2.CleanRefresh_PL_Table;
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
    ReportTransactionTableObj.CleanRefresh_PL_Table(
      DateFrom, DateTo, TempTablename, FCFields , ClientId , IncludePriorClosingDate, APIMode);

(*  if SameTExt(ReportClassName, 'TJobProfitansLossGUI') then begin
    if ClientId < 1 then exit;

    { need to add bill COGS for bills linked to this job (ClientID) }
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
      for ctr:= 1 to 2 do begin
        if (ctr=1) or (IncludePriorClosingDate)  then begin
            cmd.SQL.Add('insert into ' + TempTableName);
            cmd.SQL.Add('(AccountID,Date,AccountType,Accounts,AccountName,Level1,Level2,Level3,Level4,');
            //cmd.SQL.Add('`Default_AmountColumnEx`,`Default_AmountColumnInc`,');
          for I := 0 to ReportTransactionTableObj.LstClass.Count - 1 do begin
            pClass := ReportTransactionTableObj.LstClass.Items[I];
            cmd.SQL.Add('`' + pClass^.ClassName +'_AmountColumnEx`,');
            cmd.SQL.Add('`' + pClass^.ClassName +'_AmountColumnInc`,');
          end;

            cmd.SQL.Add('TotalAmountEx,TotalAmountInc,Ordered,');
            cmd.SQL.Add('AccountHeaderOrder, AccountSub1Order,AccountSub2Order,AccountSub3Order,FilterDate,');
            cmd.SQL.Add('FilterWeekday,FilterWeekdayNumber,FilterWeekNumber,FilterMonthNumber, FilterMonthName,FilterQuarterNumber,FilterYEAR)');
            cmd.SQL.Add('SELECT AccountID,Date,AccountType,');
            cmd.SQL.Add('IF(char_length(T.Level4)>0,Concat(Space(15),T.AccountName),IF(char_length(T.Level3)>0,Concat(Space(10),T.AccountName),IF(char_length(T.Level2)>0,Concat(Space(5),T.AccountName),Concat(Space(0),T.AccountName)))) as Accounts,');
            cmd.SQL.Add('T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');

          for I := 0 to ReportTransactionTableObj.LstClass.Count - 1 do begin
            pClass := ReportTransactionTableObj.LstClass.Items[I];
            cmd.SQL.Add('If((T.ClassID=' + inttostr(pClass.ClassID) +')  ,(CreditsEx - DebitsEx),0.00)   as "AmountEx1" ,');
            cmd.SQL.Add('If((T.ClassID=' + inttostr(pClass.ClassID) +')  ,(CreditsInc - DebitsInc),0.00)   as "AmountInc1",');
          end;

            cmd.SQL.Add('(CreditsEx - DebitsEx) as "Total Amount (Ex)" ,');
            cmd.SQL.Add('(CreditsInc - DebitsInc) as "Total Amount (Inc)" ,');
            cmd.SQL.Add('IF(char_length(T.Level3)>0,5,IF(char_length(T.Level2)>0,4, IF(char_length(T.Level1)>0,2,1))) as Ordered,');
            cmd.SQL.Add('T.Level1 as AccountHeaderOrder,');
            cmd.SQL.Add('T.Level2 as AccountSub2Order,');
            cmd.SQL.Add('T.Level3 as AccountSub2Order,');
            cmd.SQL.Add('T.Level4 as AccountSub3Order,');
            cmd.SQL.Add('Date as FilterDate,');
            cmd.SQL.Add('DAYNAME(Date) as FilterWeekday,');
            cmd.SQL.Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            cmd.SQL.Add('WEEK(Date,3)  AS FilterWeekNumber,');
            cmd.SQL.Add('MONTH(Date) as FilterMonthNumber,');
            cmd.SQL.Add('MONTHNAME(Date) as FilterMonthName,');
            cmd.SQL.Add('QUARTER(Date) AS FilterQuarterNumber,');
            cmd.SQL.Add('YEAR(Date) AS FilterYEAR');
            cmd.SQL.Add('FROM ' + TransTablename(ctr) +'  T');
            cmd.SQL.Add('inner join tblPurchaseLines PL on T.PurchaseLineID = PL.PurchaseLineID and PL.CustomerJobID = ' + IntToStr(ClientID));
            cmd.SQL.Add('Where char_length(T.AccountName)>0 AND (AccountType = "COGS")');
            if (ctr=1) and (IncludePriorClosingDate)  then cmd.SQL.Add('AND T.Type <> "Closing Date Summary"');
            cmd.SQL.Add(';');
        end;
      end;
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;*)
  finally
    ReportTransactionTableObj.Free;
  end;
end;

constructor TProfitAndLossReport2.Create;
begin
  inherited;
  fClientID := 0;
  fStringListForSQL := nil;
  fAllAccounts := true;
  fDetailReport := true;
//  fSelectedDepartmentID := 0;
//  fProgressDialog := nil;
  fReportClassName := 'TProfitandLossGUI';
  fIncludedataPriorToClosingDate := false;
  DateFrom := 0;
  DateTo := Date;
  fSelectedDepartments := TStringList.Create;
  fSelectedDepartments.CaseSensitive := false;
  fTempTableName :=  UniqueTableName('PnL', SharedConnection);
end;

function TProfitAndLossReport2.DepartmentSelected(
  const aDeptName: string): boolean;
begin
  result := fSelectedDepartments.IndexOf(aDeptName) > -1;
end;

destructor TProfitAndLossReport2.Destroy;
begin
  fSelectedDepartments.Free;
  fActiveDepartments.Free;
  TempTableUtils.DestroyUserTemporaryTable(SharedConnection, TempTableName);
  inherited;
end;

function TProfitAndLossReport2.GetSelectedDepartments: string;
begin
  result := fSelectedDepartments.CommaText;
end;

//function TProfitAndLossReport2.GetDepartmentName: string;
//begin
//  if DEpartmentID > 0 then
//    result := BusObjClass.TDeptClass.IDToggle(DepartmentID,SharedConnection)
//  else
//    result := '';
//end;

procedure TProfitAndLossReport2.MakeReportTable;
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
    scr.SQL.Add('Alter table ' + fTempTableName );
    for ctr := low(AmountFieldList) to high(AmountFieldList) do begin
        if ctr > 0 then scr.SQL.Add(',');
        scr.SQL.Add(' Add column  `' +  AmountFieldList[ctr]  + '` Double');
    end;

//    qry := TERPQuery.Create(nil);

    FCR :=  DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
    try
      LoadFCPref(FCR, fReportClassName, true);// FCR.LoadFCPref(fReportClassName);
      if FCR.recordCount > 0 then begin
        while not FCR.Eof do begin
          scr.SQL.Add(',');
          for ctr := low(AmountFieldList) to high(AmountFieldList) do
              scr.SQL.Add(' Add column  `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr]  + '` Double,');
          scr.SQL.Add(' Add column  ' + FCR.Fieldbyname('Code').asString + '_FCRate Double');

          if FCFields <> '' then FCFields := FCFields + ',' ;
          FCFields := FCFields + FCR.Fieldbyname('Code').asString + '_FCRate';
          FCR.Next;
        end;
      end;
    finally
      DbSharedObj.ReleaseObj(FCR);
    end;

    scr.SQL.Add(';');
    scr.SQL.Add('Alter table ' + fTempTableName +' Add column  `Accountno` varchar(50);' );
    scr.Execute;
  Finally
    scr.Free;
  End;

end;

procedure TProfitAndLossReport2.OnScriptTempError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  Action := eaContinue ;
end;

function TProfitAndLossReport2.PopulateReportSQL1(SQL: TStrings; var msg: string): Boolean;
var
  scr: TERPScript;
  FCR: TERPQuery;
//  qryDept: TERPQuery;
//  ReportTransactionTableObj: TProfitnLoss_Report_Obj;
  ctr :Integer;
  QrymainSQLList: TStringList;
  iSQLCounter :Integer;
  StringList4SQL :TStringList;
  tmptablename, tmpfilename: String;
  sl: TStringList;

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
      StringList4SQL.add(Quotedstr(Appenvvirt.str['RegionalOptions.ForeignExDefault'])  + ' as Defaultcurrency_Caption,' );
      While not FCR.eof do begin
        StringList4SQL.add(Quotedstr(FCR.Fieldbyname('Code').asString)  + ' as `' +  FCR.Fieldbyname('Code').asString + '_Caption`,' );
        FCR.Next;
      end;
    end;
    if ActiveDepartments.RecordCount > 0 then begin
      ActiveDepartments.First;
      while not ActiveDepartments.Eof do begin
        StringList4SQL.add(Quotedstr(ActiveDepartments.fieldByname('ClassName').asString)  + ' as `' +
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
        StringList4SQL.add('0 as `' + AmountFieldList[ctr1]  + '`,');
    end else begin
      for ctr1 := low(AmountFieldList) to high(AmountFieldList) do
          StringList4SQL.add('sum(`' + AmountFieldList[ctr1]+ '`) as `' + AmountFieldList[ctr1]  + '`,');
    end;
    if FCR.REcordCount = 0 then Exit;
    FCR.First;
    While not FCR.EOF do begin
      for ctr1 := low(AmountFieldList) to high(AmountFieldList) do
        if AmountZero then begin
          StringList4SQL.add('0 as `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]  + '`,');
        end else begin
          StringList4SQL.add('sum(`' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]+ '`) as `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldLIst[ctr1]  + '`,');
        end;
      FCR.Next;
    end;

  end;

begin
  result := False;

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
                Try
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
    {|}                    scr.SQL.add(';');
    {|}                end;

    {|--------------update Sub totals}
    {|}                scr.SQL.add(SubtotalupdateSQL);
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
                if iSQLCounter=2 then StringList4SQL := StringListForSQL
                else StringList4SQL := QrymainSQLList;
                StringList4SQL.add('SELECT 1 seqno,0 as AccountID,');
                StringList4SQL.add('"INC" as AccountType,');
                StringList4SQL.add('"Income" as "Account Type" , ');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields(true);
                StringList4SQL.add('2 As FinalOrder,Space(255) as AccountHeaderOrder,');
                StringList4SQL.add('Space(255) as AccountSub1Order,');
                StringList4SQL.add('Space(255) as AccountSub2Order,');
                StringList4SQL.add('Space(255) as AccountSub3Order,');

                StringList4SQL.add('null as SubTotalInc,');
                StringList4SQL.add('null as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');


        // Income Accounts
                if not DetailReport then begin

                end
                else begin
                  StringList4SQL.add('UNION ALL');
                  StringList4SQL.add('SELECT 2 seqno,AccountID,"INC" as AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('Accounts,');
                  StringList4SQL.add('Accountno,');
                  AddCaptions;
                  AddAmountFields;
                  StringList4SQL.add('3 As FinalOrder,');
                  StringList4SQL.add('AccountHeaderOrder,');
                  StringList4SQL.add('AccountSub1Order,');
                  StringList4SQL.add('AccountSub2Order,');
                  StringList4SQL.add('AccountSub3Order,');

                  StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                  StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                  StringList4SQL.add('"T" as HideTotal');
                  StringList4SQL.add('FROM ' + TempTableName + ' Where (AccountType = "EXINC" OR AccountType = "INC")');
                  //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                  StringList4SQL.add('Group By Accounts');
                end;
        // Income Accounts with zero
                if AllAccounts then begin
                  StringList4SQL.add('UNION ALL');
                  StringList4SQL.add('SELECT 3 seqno,AccountID,"INC" as AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('AccountName as Accounts,');
                  StringList4SQL.add('AccountNumber as Accountno,');
                  AddCaptions;
                  AddAmountFields(true);
                  StringList4SQL.add('3 As FinalOrder,');
                  StringList4SQL.add('Level1 as AccountHeaderOrder,');
                  StringList4SQL.add('Level2 as AccountSub1Order,');
                  StringList4SQL.add('Level3 as AccountSub2Order,');
                  StringList4SQL.add('Level4 as AccountSub3Order,');

                  StringList4SQL.add('0.0 as SubTotalInc,');
                  StringList4SQL.add('0.0 as SubTotalEx,');
                  StringList4SQL.add('"T" as HideTotal');
                  StringList4SQL.add('FROM tblchartofaccounts Where (AccountType = "EXINC" OR AccountType = "INC")');
                  StringList4SQL.add('and AccountId not in ');
                  StringList4SQL.add('        (select distinct AccountID from '+TempTableName);
                  //StringList4SQL.add('        where Date Between :txtfrom AND :txtto');
                  StringList4SQL.add('        )');
                end;

        // Total Income
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 4 seqno,0 as AccountID,');
                StringList4SQL.add('"INC" as AccountType,');
                StringList4SQL.add('"Total Income" as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields;
                StringList4SQL.add('4 As FinalOrder,');
                StringList4SQL.add('AccountHeaderOrder,');
                StringList4SQL.add('AccountSub1Order,');
                StringList4SQL.add('AccountSub2Order,');
                StringList4SQL.add('AccountSub3Order,');

                StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
                StringList4SQL.add('FROM ' + TempTableName + ' Where (AccountType = "EXINC" OR AccountType = "INC")');
                //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                StringList4SQL.add('Group By "INC"');
        // Space
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 5 seqno,0 as AccountID,');
                StringList4SQL.add('Space(255) as AccountType,');
                StringList4SQL.add('Space(255) as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields(true);
                StringList4SQL.add('5 As FinalOrder,');
                StringList4SQL.add('Space(255) as AccountHeaderOrder,');
                StringList4SQL.add('Space(255) as AccountSub1Order,');
                StringList4SQL.add('Space(255) as AccountSub2Order,');
                StringList4SQL.add('Space(255) as AccountSub3Order,');

                StringList4SQL.add('null as SubTotalInc,');
                StringList4SQL.add('null as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
        // COGS Header
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 6 seqno,0 as AccountID,');
                StringList4SQL.add('"COGS" as AccountType,');
                StringList4SQL.add('"Cost of Goods Sold" as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields(true);
                StringList4SQL.add('6 As FinalOrder,Space(255) as AccountHeaderOrder,');
                StringList4SQL.add('Space(255) as AccountSub1Order,');
                StringList4SQL.add('Space(255) as AccountSub2Order,');
                StringList4SQL.add('Space(255) as AccountSub3Order,');

                StringList4SQL.add('null as SubTotalInc,');
                StringList4SQL.add('null as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
        // COGS Accounts
                if not DetailReport then begin

                end
                else begin
                  StringList4SQL.add('UNION ALL');
                  StringList4SQL.add('SELECT 7 seqno,AccountID,AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('Accounts,');
                  StringList4SQL.add('Accountno,');
                  AddCaptions;
                  AddAmountFields;
                  StringList4SQL.add('7 As FinalOrder,');
                  StringList4SQL.add('AccountHeaderOrder,');
                  StringList4SQL.add('AccountSub1Order,');
                  StringList4SQL.add('AccountSub2Order,');
                  StringList4SQL.add('AccountSub3Order,');

                  StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                  StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                  StringList4SQL.add('"T" as HideTotal');
                  StringList4SQL.add('FROM ' + TempTablename + ' Where (AccountType = "COGS")');
                  //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                  StringList4SQL.add('Group By Accounts');
                end;
        // COGS Accounts with zero amounts
                if AllAccounts then begin
                  StringList4SQL.add('UNION ALL');
                  StringList4SQL.add('SELECT 8 seqno,AccountID,AccountType as AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('AccountName as Accounts,');
                  StringList4SQL.add('AccountNumber as Accountno,');
                  AddCaptions;
                  AddAmountFields(true);
                  StringList4SQL.add('7 As FinalOrder,');
                  StringList4SQL.add('Level1 as AccountHeaderOrder,');
                  StringList4SQL.add('Level2 as AccountSub1Order,');
                  StringList4SQL.add('Level3 as AccountSub2Order,');
                  StringList4SQL.add('Level4 as AccountSub3Order,');

                  StringList4SQL.add('0.0 as SubTotalInc,');
                  StringList4SQL.add('0.0 as SubTotalEx,');
                  StringList4SQL.add('"T" as HideTotal');
                  StringList4SQL.add('FROM tblchartofaccounts Where (AccountType = "COGS")');
                  StringList4SQL.add('and AccountId not in ');
                  StringList4SQL.add('          (select distinct AccountID from '+TempTablename+' ');
                  //StringList4SQL.add('          where Date Between :txtfrom AND :txtto');
                  StringList4SQL.add('          )');
                end;

        // COGS Totals
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT  9 seqno,0 as AccountID,');
                StringList4SQL.add('"COGS" as AccountType,');
                StringList4SQL.add('"Total COGS" as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields;
                StringList4SQL.add('8 As FinalOrder,');
                StringList4SQL.add('AccountHeaderOrder,');
                StringList4SQL.add('AccountSub1Order,');
                StringList4SQL.add('AccountSub2Order,');
                StringList4SQL.add('AccountSub3Order,');

                StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
                StringList4SQL.add('FROM ' + TempTablename + ' Where (AccountType = "COGS")');
                //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                StringList4SQL.add('Group By "COGS"');
        // Space
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 10 seqno,0 as AccountID,');
                StringList4SQL.add('Space(255) as AccountType,');
                StringList4SQL.add('Space(255) as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields(true);
                StringList4SQL.add('9 As FinalOrder,');
                StringList4SQL.add('Space(255) as AccountHeaderOrder,');
                StringList4SQL.add('Space(255) as AccountSub1Order,');
                StringList4SQL.add('Space(255) as AccountSub2Order,');
                StringList4SQL.add('Space(255) as AccountSub3Order,');

                StringList4SQL.add('null as SubTotalInc,');
                StringList4SQL.add('null as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
        // Gross Profit
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 11 seqno,0 as AccountID,');
                StringList4SQL.add('Space(255) as AccountType,');
                StringList4SQL.add('"Gross Profit" as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields;
                StringList4SQL.add('10 As FinalOrder,');
                StringList4SQL.add('AccountHeaderOrder,');
                StringList4SQL.add('AccountSub1Order,');
                StringList4SQL.add('AccountSub2Order,');
                StringList4SQL.add('AccountSub3Order,');

                StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
                StringList4SQL.add('FROM ' + TempTablename + ' Where (AccountType = "COGS" OR AccountType = "EXINC" OR AccountType = "INC")');
                //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                StringList4SQL.add('Group By FinalOrder');

        // Space
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 12 seqno,0 as AccountID,');
                StringList4SQL.add('Space(255) as AccountType,');
                StringList4SQL.add('Space(255) as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields(true);
                StringList4SQL.add('11 As FinalOrder,');
                StringList4SQL.add('Space(255) as AccountHeaderOrder,');
                StringList4SQL.add('Space(255) as AccountSub1Order,');
                StringList4SQL.add('Space(255) as AccountSub2Order,');
                StringList4SQL.add('Space(255) as AccountSub3Order,');

                StringList4SQL.add('null as SubTotalInc,');
                StringList4SQL.add('null as SubTotalEx,');

                StringList4SQL.add('"T" as HideTotal');
        // Expense Header
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 13 seqno,0 as AccountID,');
                StringList4SQL.add('"EXP" as AccountType,');
                StringList4SQL.add('"Expense" as "Account Type" , ');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields(true);
                StringList4SQL.add('12 As FinalOrder,');
                StringList4SQL.add('Space(255) as AccountHeaderOrder,');
                StringList4SQL.add('Space(255) as AccountSub1Order,');
                StringList4SQL.add('Space(255) as AccountSub2Order,');
                StringList4SQL.add('Space(255) as AccountSub3Order,');

                StringList4SQL.add('null as SubTotalInc,');
                StringList4SQL.add('null as SubTotalEx,');

                StringList4SQL.add('"T" as HideTotal');
        // Expense Accounts
                if not DetailReport then begin

                end
                else begin
                  StringList4SQL.add('UNION ALL');
                  StringList4SQL.add('SELECT 14 seqno,AccountID,');
                  StringList4SQL.add('AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('Accounts,');
                  StringList4SQL.add('Accountno,');
                  AddCaptions;
                  AddAmountFields;
                  StringList4SQL.add('13 As FinalOrder,');
                  StringList4SQL.add('AccountHeaderOrder,');
                  StringList4SQL.add('AccountSub1Order,');
                  StringList4SQL.add('AccountSub2Order,');
                  StringList4SQL.add('AccountSub3Order,');

                  StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                  StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                  StringList4SQL.add('"T" as HideTotal');
                  StringList4SQL.add('FROM ' + TempTablename + ' Where (AccountType = "EXEXP" OR AccountType = "EXP")');
                  //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                  StringList4SQL.add('Group By Accounts');
                end;
        // Expense Accounts with zero amounts
                if AllAccounts then begin
                  StringList4SQL.add('UNION ALL');
                  StringList4SQL.add('SELECT 15 seqno,AccountID,AccountType as AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('AccountName as Accounts,');
                  StringList4SQL.add('AccountNumber as Accountno,');
                  AddCaptions;
                  AddAmountFields(true);
                  StringList4SQL.add('13 As FinalOrder,');
                  StringList4SQL.add('Level1 as AccountHeaderOrder,');
                  StringList4SQL.add('Level2 as AccountSub1Order,');
                  StringList4SQL.add('Level3 as AccountSub2Order,');
                  StringList4SQL.add('Level4 as AccountSub3Order,');

                  StringList4SQL.add('0.0 as SubTotalInc,');
                  StringList4SQL.add('0.0 as SubTotalEx,');
                  StringList4SQL.add('"T" as HideTotal');
                  StringList4SQL.add('FROM tblchartofaccounts Where (AccountType = "EXEXP" OR AccountType = "EXP")');
                  StringList4SQL.add('and AccountId not in ');
                  StringList4SQL.add('        (select distinct AccountID from '+TempTablename+' ');
                  //StringList4SQL.add('        where Date Between :txtfrom AND :txtto');
                  StringList4SQL.add('        )');
                end;

        // Expense Total
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 16 seqno,0 as AccountID,"EXP" as AccountType,');
                StringList4SQL.add('"Total Expenses" as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields;
                StringList4SQL.add('14 As FinalOrder,');
                StringList4SQL.add('AccountHeaderOrder,');
                StringList4SQL.add('AccountSub1Order,');
                StringList4SQL.add('AccountSub2Order,');
                StringList4SQL.add('AccountSub3Order,');

                StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
                StringList4SQL.add('FROM ' + TempTablename + ' Where (AccountType = "EXEXP" OR AccountType = "EXP")');
                //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                StringList4SQL.add('Group By "EXP"');
        // Space
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 17 seqno,0 as AccountID,');
                StringList4SQL.add('Space(255) as AccountType,');
                StringList4SQL.add('Space(255) as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields(true);
                StringList4SQL.add('15 As FinalOrder,');
                StringList4SQL.add('Space(255) as AccountHeaderOrder,');
                StringList4SQL.add('Space(255) as AccountSub1Order,');
                StringList4SQL.add('Space(255) as AccountSub2Order,');
                StringList4SQL.add('Space(255) as AccountSub3Order,');

                StringList4SQL.add('null as SubTotalInc,');
                StringList4SQL.add('null as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
        // Net Income
                StringList4SQL.add('UNION ALL');
                StringList4SQL.add('SELECT 18 seqno,0 as AccountID,');
                StringList4SQL.add('Space(255) as AccountType,');
                StringList4SQL.add('"Net Income" as "Account Type",');
                StringList4SQL.add('Space(255) as AccountName,');
                StringList4SQL.add('Space(50) as AccountNo,');
                AddCaptions;
                AddAmountFields;
                StringList4SQL.add('16 As FinalOrder,');
                StringList4SQL.add('AccountHeaderOrder,');
                StringList4SQL.add('AccountSub1Order,');
                StringList4SQL.add('AccountSub2Order,');
                StringList4SQL.add('AccountSub3Order,');

                StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                StringList4SQL.add('"T" as HideTotal');
                StringList4SQL.add('FROM ' + TempTablename + ' Where  (AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS")');
                //StringList4SQL.add('AND Date Between :txtfrom AND :txtto');
                StringList4SQL.add('Group By FinalOrder');

        // Total Income Accounts  Totals Level1
                StringList4SQL.add('UNION ALL');
                if not DetailReport then begin
                  StringList4SQL.add('SELECT 19 seqno,AccountID,');
                  StringList4SQL.add('AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('Level1 as AccountName,');
                  StringList4SQL.add('AccountNo,');
                end
                else begin
                  StringList4SQL.add('SELECT 19 seqno,0 as AccountID,');
                  StringList4SQL.add('AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('LEFT(Concat("Total ",Level1,Space(255)),255) as AccountName,');
                  StringList4SQL.add('Space(50) as AccountNo,');
                end;
                AddCaptions;
                AddAmountFields;
                StringList4SQL.add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');
                StringList4SQL.add('AccountHeaderOrder,');
                StringList4SQL.add('"ZZZZZZZZZZZZ" as AccountSub1Order,');
                StringList4SQL.add('"ZZZZZZZZZZZZ" as AccountSub2Order,');
                StringList4SQL.add('"ZZZZZZZZZZZZ" as AccountSub3Order,');


                StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                if not DetailReport then begin
                  StringList4SQL.add('"T" as HideTotal');
                end
                else begin
                  StringList4SQL.add('If( char_length(Max(Level2))>0 ,"T","F") as HideTotal');
    //              StringList4SQL.add('If( char_length(Max(Level1))>0 ,"T","F") as HideTotal');
                end;
                StringList4SQL.add('FROM ' + TempTablename + '');
                if not DetailReport then begin
                  StringList4SQL.add('Where TotalAmountEx <> 0.00');
                end
                else begin
    //              StringList4SQL.add('Where AccountName <> LEvel1 and  char_length(Level1)>0 And TotalAmountEx<>0.00');
                  StringList4SQL.add('Where AccountHeaderOrder = Level1 and char_length(Level1)>0 And TotalAmountEx<>0.00');
                end;
                StringList4SQL.add('');
                StringList4SQL.add('Group By AccountHeaderOrder');
                if not DetailReport then begin

                end
                else begin
           // Total Income Accounts  Totals Level2
                  StringList4SQL.add('UNION ALL');
                  StringList4SQL.add('SELECT 20 seqno,0 as AccountID,');
                  StringList4SQL.add('AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('LEFT(Concat(Space(5),REPLACE(Level2,Level2,Concat("Total ",Level2,Space(255)))),255)  as AccountName,');
                  StringList4SQL.add('Space(50) as AccountNo,');
                  AddCaptions;
                  AddAmountFields;
                  StringList4SQL.add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');
                  StringList4SQL.add('AccountHeaderOrder,');
                  StringList4SQL.add('AccountSub1Order,');
                  StringList4SQL.add('"ZZZZZZZZZZZZ" as AccountSub2Order,');
                  StringList4SQL.add('"ZZZZZZZZZZZ" as AccountSub3Order,');

                  StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                  StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                  StringList4SQL.add('If( char_length(Max(Level3))>0 ,"T","F") as HideTotal');
    //              StringList4SQL.add('If( char_length(Max(Level2))>0 ,"T","F") as HideTotal');
                  StringList4SQL.add('FROM ' + TempTablename + '');
    //              StringList4SQL.add('Where (AccountName <> Level1) AND (AccountName<>LEvel2) AND (char_length(Level2)>0) AND TotalAmountEx<>0.00');
                  StringList4SQL.add('Where (AccountName <> Level1) AND (char_length(Level2)>0) AND TotalAmountEx<>0.00');
                  StringList4SQL.add('Group By AccountType,LEFT(Concat(Space(5),REPLACE(Level2,Level2,Concat("Total ",Level2,Space(255)))),255)');

          // Total Income Accounts  Totals Level3
                  StringList4SQL.add('Union All');
                  StringList4SQL.add('SELECT 21 seqno,0 as AccountID,');
                  StringList4SQL.add('AccountType,');
                  StringList4SQL.add('Space(255) as "Account Type",');
                  StringList4SQL.add('LEFT(Concat(Space(10),REPLACE(Level3,Level3,Concat("Total ",Level3,Space(255)))),255)  as AccountName,');
                  StringList4SQL.add('Space(50) as AccountNo,');
                  AddCaptions;
                  AddAmountFields;
                  StringList4SQL.add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');
                  StringList4SQL.add('AccountHeaderOrder,');
                  StringList4SQL.add('AccountSub1Order,');
                  StringList4SQL.add('AccountSub2Order,');
                  StringList4SQL.add('"ZZZZZZZZZZ" as AccountSub3Order,');

                  StringList4SQL.add('Sum(SubTotalInc) as SubTotalInc,');
                  StringList4SQL.add('Sum(SubTotalEx) as SubTotalEx,');
                  StringList4SQL.add('If( char_length(Max(Level4))>0 ,"T","F") as HideTotal');
    //              StringList4SQL.add('If( char_length(Max(Level3))>0 ,"T","F") as HideTotal');
                  StringList4SQL.add('FROM ' + TempTablename + '');
                  StringList4SQL.add('Where (AccountName <> Level1) And (AccountName <> Level2) And (char_length(Level3)>0) AND TotalAmountEx<>0.00');
                  StringList4SQL.add('Group By AccountType,LEFT(Concat(Space(10),REPLACE(Level3,Level3,Concat("Total ",Level3,Space(255)))),255)');
                end;
                StringList4SQL.add('Order By FinalOrder,AccountHeaderOrder, AccountSub1Order,AccountSub2Order,AccountSub3Order,TotalAmountInc;');
            End;
            SQl.clear;
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

function TProfitAndLossReport2.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  scr: TERPScript;
  FCR : TERPQuery;
//  qryDept: TERPQuery;
//  ReportTransactionTableObj: TProfitnLoss_Report_Obj;
  ctr :Integer;
  QrymainSQLList: TStringList;
  iSQLCounter :Integer;
  StringList4SQL :TStringList;
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
      LoadFCPref(FCR, fReportClassName, true);

    //    ScriptMain.SQL.clear;
      if not SameText(ReportClassName,'TBalanceSheetGUI') then begin
        MakeReportTable;
        scr := TERPScript.Create(nil);

        Try
          scr.Connection := SharedConnection;
          CleanRefresh_PL_Table;
  //                ReportTransactionTableObj := TProfitnLoss_Report_Obj.Create(True);
  //                try
  //                  ReportTransactionTableObj.CleanRefresh_PL_Table(
  //                    DateFrom, DateTo, TempTablename, FCFields , 0 , IncludePriorClosingDate, APIMode);
  //                finally
  //                  ReportTransactionTableObj.Free;
  //                end;

          tmptablename := TempTableUtils.UniqueTableName(fReportClassName, SharedConnection);

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
    {|}                    scr.SQL.add(';');
    {|}                end;

    {|--------------update Sub totals}
    {|}                scr.SQL.add(SubtotalupdateSQL);
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
      end;

      QrymainSQLList:= TStringList.Create;

      try
        ReportHeader;

        for iSQLCounter := 1 to 2 do begin
          if iSQLCounter=2 then StringList4SQL := StringListForSQL
          else StringList4SQL := QrymainSQLList;

          // Create ths SQL for the report
          CreateSQL4Report(StringList4SQL, FCR);
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

procedure TProfitAndLossReport2.CreateSQL4Report(ASQL: TStrings; AFCR: TERPQuery);
var
  FCR, qryTemp : TERPQuery;
  StringList4SQL :TStringList;
  sName, sPrevRootName, sPos : string;
  iMaxLevel, iLevel, iID : Integer;
  bRoot, bAccount : Boolean;
  K, seqNo : Integer;

  procedure AddCaptions;
  begin
    if APIMode then exit;

    if FCR.recordCount <> 0 then begin
      FCR.First;
      StringList4SQL.add(Quotedstr(Appenvvirt.str['RegionalOptions.ForeignExDefault'])  + ' as Defaultcurrency_Caption,' );
      While not FCR.EOF do begin
        StringList4SQL.add(Quotedstr(FCR.Fieldbyname('Code').asString)  + ' as `' +  FCR.Fieldbyname('Code').asString + '_Caption`,' );
        FCR.Next;
      end;
    end;
    if ActiveDepartments.RecordCount > 0 then begin
      ActiveDepartments.First;
      while not ActiveDepartments.EOF do begin
        StringList4SQL.add(Quotedstr(ActiveDepartments.fieldByname('ClassName').asString)  + ' as `' +
          Trim(inttostr(ActiveDepartments.FieldByName('classId').asInteger)) + '_Caption`,' );
        ActiveDepartments.Next;
      end;
    end;
  end;

  procedure AddAmountFields(Const AmountZero :Boolean = False);
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
          StringList4SQL.add('0.0 AS `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]  + '`,');
        end else begin
          StringList4SQL.add('SUM(`' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldList[ctr1]+ '`) AS `' + FCR.Fieldbyname('Code').asString + '_' + AmountFieldLIst[ctr1]  + '`,');
        end;
      FCR.Next;
    end;

  end;

begin

  StringList4SQL := TStringList.Create;
  FCR := AFCR;

  // Fetch layout data
  qryTemp :=  DbSharedObjectsObj.DbSharedObj.GetQuery(TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));

  with qryTemp do begin
    SQL.Clear;
    SQL.Add('SELECT (MAX(LENGTH(ld.Pos)) DIV 2) AS MaxLevel FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ls.DefaultLayout="T" AND ld.IsAccount="F"');
    Open;
    iMaxLevel := FieldByName('MaxLevel').AsInteger;
    Close;

    SQL.Clear;
    SQL.Add('SELECT ld.* FROM tblPnLLayoutData ld');
    SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
    SQL.Add('WHERE ls.DefaultLayout="T" AND ld.IsAccount="F"');
    SQL.Add('ORDER BY Pos');
    Open;

    if RecordCount = 0 then Exit;

    seqNo := 1;
    sPrevRootName := '';

    First;
    while not EOF do begin
      iID := FieldByName('ID').AsInteger;
      sName := FieldByName('Name').AsString;
      sPos := FieldByName('Pos').AsString;
      iLevel := Length(FieldByName('Pos').AsString) div 2;
      bRoot := FieldByName('IsRoot').AsBoolean;
      bAccount := FieldByName('IsAccount').AsBoolean;

      // If root
      if bRoot then begin
        if seqNo > 1 then begin
          // Total for the previous root
          if sPrevRootName = 'Cost of Sales' then sPrevRootName := GetRootInitial(sPrevRootName);

          StringList4SQL.add('UNION ALL');
          StringList4SQL.add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
          for K := 1 to iMaxLevel do begin
            StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Total ' + sPrevRootName + '", "") AS Level' + IntToStr(K) + ',');
          end;
          StringList4SQL.add('"Total ' + sPrevRootName + '" AS "Account Type",');
          AddCaptions;
          AddAmountFields;
          StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
          StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
          StringList4SQL.Add('"T" as HideTotal');
          StringList4SQL.Add('FROM ' + TempTableName);
          if sPrevRootName = 'COGS' then
            StringList4SQL.Add('WHERE (AccountType = "COGS")')
          else
            StringList4SQL.Add('WHERE (AccountType = "EX' + GetRootInitial(sPrevRootName) + '" OR AccountType = "' + GetRootInitial(sPrevRootName) + '")');
          StringList4SQL.Add('GROUP BY "' + GetRootInitial(sPrevRootName) + '"');

          // Space
          Inc(seqNo);
          StringList4SQL.Add('UNION ALL');
          StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "F" AS IsRoot,');
          for K := 1 to iMaxLevel do begin
            StringList4SQL.Add('"" AS Level' + IntToStr(K) + ',');
          end;
          StringList4SQL.add('"" AS "Account Type",');
          AddCaptions;
          AddAmountFields(true);
          StringList4SQL.Add('null AS SubTotalInc,');
          StringList4SQL.Add('null AS SubTotalEx,');
          StringList4SQL.Add('"T" AS HideTotal');

          // Add 'Gross Profit'
          if sPrevRootName = 'COGS' then begin
            StringList4SQL.add('UNION ALL');
            StringList4SQL.add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
            for K := 1 to iMaxLevel do begin
              StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Gross Profit", "") AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.add('"Gross Profit" AS "Account Type",');
            AddCaptions;
            AddAmountFields;
            StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
            StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
            StringList4SQL.Add('"T" as HideTotal');
            StringList4SQL.Add('FROM ' + TempTableName);
            StringList4SQL.add('WHERE (AccountType = "COGS" OR AccountType = "EXINC" OR AccountType = "INC")');
            StringList4SQL.Add('GROUP BY "' + GetRootInitial(sPrevRootName) + '"');

            // Space
            Inc(seqNo);
            StringList4SQL.Add('UNION ALL');
            StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "F" AS IsRoot,');
            for K := 1 to iMaxLevel do begin
              StringList4SQL.Add('"" AS Level' + IntToStr(K) + ',');
            end;
            StringList4SQL.add('"" AS "Account Type",');
            AddCaptions;
            AddAmountFields(true);
            StringList4SQL.Add('null AS SubTotalInc,');
            StringList4SQL.Add('null AS SubTotalEx,');
            StringList4SQL.Add('"T" AS HideTotal');
          end;

          StringList4SQL.Add('UNION ALL');
        end;

        // Current root
        StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
        for K := 1 to iMaxLevel do begin
          StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "' + sName + '", "") AS Level' + IntToStr(K) + ',');
        end;
        StringList4SQL.add(QuotedStr(sName) + ' AS "Account Type",');
        AddCaptions;
        AddAmountFields(True);
        StringList4SQL.Add('null AS SubTotalInc,');
        StringList4SQL.Add('null AS SubTotalEx,');
        StringList4SQL.Add('"T" AS HideTotal');

        sPrevRootName := sName;

        // Space
        Inc(seqNo);
        StringList4SQL.Add('UNION ALL');
        StringList4SQL.Add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "F" AS IsRoot,');
        for K := 1 to iMaxLevel do begin
          StringList4SQL.Add('"" AS Level' + IntToStr(K) + ',');
        end;
        StringList4SQL.add('"" AS "Account Type",');
        AddCaptions;
        AddAmountFields(True);
        StringList4SQL.Add('null AS SubTotalInc,');
        StringList4SQL.Add('null AS SubTotalEx,');
        StringList4SQL.Add('"T" AS HideTotal');

        // Net income
        if sName = 'Expense' then begin
          Inc(seqNo);
          StringList4SQL.Add('UNION ALL');
          StringList4SQL.add('SELECT ' + IntToStr(seqNo) + ' AS seqno, 0 AS AccountID, "T" AS IsRoot,');
          for K := 1 to iMaxLevel do begin
            StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "Net Income", "") AS Level' + IntToStr(K) + ',');
          end;
          StringList4SQL.add('"Net Income" AS "Account Type",');
          AddCaptions;
          AddAmountFields;
          StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
          StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
          StringList4SQL.Add('"T" as HideTotal');
          StringList4SQL.Add('FROM ' + TempTableName);
          StringList4SQL.add('WHERE (AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS")');
          StringList4SQL.Add('GROUP BY "' + GetRootInitial(sName) + '"');
        end;
      end;

      // If group
      if not bRoot then begin
        StringList4SQL.add('UNION ALL');
        StringList4SQL.add('SELECT ' + IntToStr(seqNo) + ' AS seqno, T.AccountID, "F" AS IsRoot,');
        for K := 1 to iMaxLevel do begin
          StringList4SQL.Add('IF(' + IntToStr(K) + ' = ' + IntToStr(iLevel) + ', "' + sName + '", "") AS Level' + IntToStr(K) + ',');
        end;
        StringList4SQL.Add(QuotedStr(sName) + ' AS "Account Type",');
        AddCaptions;
        AddAmountFields;
        StringList4SQL.Add('SUM(SubTotalInc) AS SubTotalInc,');
        StringList4SQL.Add('SUM(SubTotalEx) AS SubTotalEx,');
        StringList4SQL.Add('"T" AS HideTotal');
        StringList4SQL.Add('FROM tblPnLLayoutData ld');
        StringList4SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
        StringList4SQL.Add('LEFT JOIN ' + TempTableName + ' t ON ld.AccountID=T.AccountID');
        StringList4SQL.Add('WHERE ls.DefaultLayout="T" AND IsAccount="F"');
//        StringList4SQL.add('WHERE L.Parent=' + IntToStr(iID));
        StringList4SQL.add('AND Left(ld.Pos, ' + IntToStr(iLevel * 2) + ') = ' + QuotedStr(sPos));
      end;

      Inc(seqNo);
      Next;
    end;
  end;

  DbSharedObj.ReleaseObj(qryTemp);

  ASQL.Add(StringList4SQL.Text);
  FreeAndNil(StringList4SQL);

end;

function TProfitAndLossReport2.GetRootInitial(ARootName: string) : string;
begin
  if ARootName = 'Income' then Result := 'INC';
  if ARootName = 'Cost of Sales' then Result := 'COGS';
  if ARootName = 'Expense' then Result := 'EXP';
end;

//procedure TProfitAndLossReport2.SetDepartmentName(const Value: string);
//begin
//  if Value <> '' then
//    DepartmentID := BusObjClass.TDeptClass.IDToggle(Value,SharedConnection)
//  else
//    DepartmentID := 0;
//end;

procedure TProfitAndLossReport2.SetSelectedDepartments(const Value: string);
begin
  fSelectedDepartments.CommaText := Value;
end;

function TProfitAndLossReport2.SubtotalUpdateSQL: String;
var
  SubTotalIncSQL , SubTotalExSQL :String;
begin
  REsult := 'Update ' + TempTableName + ' Set SubTotalInc = 0;' +
            'Update ' + TempTableName + ' Set SubTotalEx  = 0;';
  if AllDepartments then exit;
  if ActiveDepartments.recordcount =0 then exit;

   ActiveDepartments.First;
   SubTotalIncSQL := '';
   SubTotalExSQL  := '';
   while ActiveDepartments.Eof = False do begin
       if  self.DepartmentSelected(ActiveDepartments.fieldByname('ClassName').AsString) then begin
         if SubTotalIncSQL <> '' then SubTotalIncSQL := SubTotalIncSQL + ' + '; SubTotalIncSQL := SubTotalIncSQL + '`' + Trim(inttostr(ActiveDepartments.FieldByName('classId').asInteger)) + '_AmountColumnInc`  ';
         if SubTotalExSQL  <> '' then SubTotalExSQL  := SubTotalExSQL  + ' + '; SubTotalExSQL  := SubTotalExSQL  + '`' + Trim(inttostr(ActiveDepartments.FieldByName('classId').asInteger)) + '_AmountColumnEx`  ';
       End;
       ActiveDepartments.Next;
   end;
   if SubTotalIncSQL <> '' then REsult := Result + '  Update ' + TempTableName + ' Set SubTotalInc = ' + SubTotalIncSQL+';';
   if SubTotalExSQL <> '' then REsult := Result + '  Update ' + TempTableName + ' Set SubTotalEx = ' + SubTotalExSQL+';';
end;

initialization
  RegisterClass(TProfitAndLossReport2);

end.
