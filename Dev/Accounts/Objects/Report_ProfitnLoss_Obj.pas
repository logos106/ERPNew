unit Report_ProfitnLoss_Obj;

interface

uses TransactionsTable, ReportTransactionsTable, classes;

type
  TProfitnLoss_Report_Obj = class(TReportTransactionTableObj)
  Private
  Protected
  Public
    Procedure CleanRefresh_PL_Table(
      DateFrom, DateTo:Tdatetime; Const sTablename :String = '';
      Const FCFields:String = '';
      clientID: Integer = 0; IncludeSummary :Boolean = False;
      UseDeptName: boolean = false);
  end;

implementation

uses Controls, tcConst, forms, sysutils, MySQLConst;

{ TProfitnLoss_Report_Obj }

procedure TProfitnLoss_Report_Obj.CleanRefresh_PL_Table(
  DateFrom, DateTo: Tdatetime; const sTablename, FCFields: String;
  clientID: Integer; IncludeSummary: Boolean; UseDeptName: boolean);
var
  InsertSQL: string;
  pClass: pClassRec;
  ctr, I, ClassCount: integer;
  DebitsField: string;
  CreditsField: string;
  DebitsIncField: string;
  CreditsIncField: string;
  TempClassString: string;
  Save_Cursor: TCursor;
  fsTablename :String;

  function AccountHeaders:String;  begin
    Result := Firstcolumn('A')  +' as AccountHeaderOrder,'+
      Secondcolumn('A') +' as AccountSub1Order,'+
      Thirdcolumn('A')  +' as AccountSub2Order,'+
      forthcolumn('A')  +' as AccountSub3Order';
  end;

  function Transtablename(Const loopno:Integer):String;
  begin
    if loopno = 1 then result := 'tbltransactions' else result := 'tbltransactionsummarydetails';
  end;
begin
  fDoingRefresh:= true;
  try
    DebitsField     := 'DebitsEx';
    CreditsField    := 'CreditsEx';
    DebitsIncField  := 'DebitsInc';
    CreditsIncField := 'CreditsInc';

    if sTablename = '' then fstablename := TABLE_PROFITANDLOSSREPORT
    else fstablename := sTablename;

    GetClasses(nil, False);;
    ClassCount := fLstClass.Count;

    InsertSQL :=
      'INSERT HIGH_PRIORITY INTO ' + fsTablename + '  (AccountID,Date,AccountType,Description,Accounts,Account_Type,AccountName,Level1,Level2,Level3,Level4,' ;
       for I := 0 to ClassCount - 1 do begin
          pClass := fLstClass.Items[I];
          if UseDeptName then begin
            InsertSQL := InsertSQL +'`' + trim(pClass^.ClassName) + '_AmountColumnEx`,';
            InsertSQL := InsertSQL +'`' + trim(pClass^.ClassName) + '_AmountColumnInc`,';
          end
          else begin
            InsertSQL := InsertSQL +'`' + trim(inttostr(pClass^.ClassID)) + '_AmountColumnEx`,';
            InsertSQL := InsertSQL +'`' + trim(inttostr(pClass^.ClassID)) + '_AmountColumnInc`,';
          end;
       end;
       InsertSQL := InsertSQL +'TotalAmountEx,TotalAmountInc,Ordered,AccountHeaderOrder, ' +
                      'AccountSub1Order,AccountSub2Order,AccountSub3Order,FilterDate, ' +
                      'FilterWeekday,FilterWeekdayNumber,FilterWeekNumber,FilterMonthNumber, ' +
                      'FilterMonthName,FilterQuarterNumber,FilterYEAR';
    if FCFields <> '' then   InsertSQL := InsertSQL +',' + FCFields;
    InsertSQL := InsertSQL + ')';
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      with BulkSQL do begin
        Clear;
        Add('TRUNCATE ' + fsTablename + ' ;');

        for ctr:= 1 to 2 do begin
          if (ctr = 1) or (IncludeSummary) then begin
            Add(InsertSQL);
            Add('SELECT AccountID,Date,AccountType, "" as "Decription" ,');
            Add('IF(char_length(Level4)>0,Concat(Space(15),AccountName),' +
                    'IF(char_length(Level3)>0,Concat(Space(10),AccountName),' + 'IF(char_length(Level2)>0,Concat(Space(5),AccountName),' +
                    'Concat(Space(0),AccountName)))) as Accounts,');
            Add('"" as "Account Type",AccountName,Level1,Level2,Level3,Level4,');

            for I := 0 to ClassCount - 1 do begin
              pClass := fLstClass.Items[I];
              TempClassString := '';
              TempClassString := 'ClassID=' + IntToStr(pClass^.ClassID);
              TempClassString := '(' + TempClassString + ')';
              Add('If(' + TempClassString + '  ,(' + CreditsField + ' - ' + DebitsField + '),0.00)   as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('If(' + TempClassString + '  ,(' + CreditsIncField + ' - ' +
                DebitsIncField + '),0.00)   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('(' + CreditsField + ' - ' + DebitsField + ') as "Total Amount (Ex)" , ');
            Add('(' + CreditsIncField + ' - ' + DebitsIncField + ') as "Total Amount (Inc)",');
            Add('IF(char_length(Level1)>0,5,IF(char_length(Level2)>0,4, IF(char_length(Level3)>0,2,1))) as Ordered,');
            Add('Level1 as AccountHeaderOrder, ');
            Add('Level2 as AccountSub2Order, ');
            Add('Level3 as AccountSub2Order, ');
            Add('Level4 as AccountSub3Order, ');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(AccountName)>0 AND (AccountType = "EXINC" OR AccountType = "INC")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" , ');
            Add('IF(char_length(T.Level1)>0,T.Level1,T.AccountName) as Accounts, ');
            Add('"" as "Account Type",A.AccountName,T.Level1,T.Level2,T.Level3,T.Level4, ');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('1 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level1 ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level1)>0 And char_length(T.AccountName)>0 AND  (T.AccountType = "EXINC" OR T.AccountType = "INC")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level2)>0,Concat(Space(5),T.Level2),Concat(Space(5),T.AccountName)) as Accounts,');
            Add('"" as "Account Type",A.AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' +
                IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('2 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level2 ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level2)>0 And char_length(T.AccountName)>0 AND (A.AccountType = "EXINC" OR A.AccountType = "INC")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level3)>0,Concat(Space(10),T.Level3),Concat(Space(10),T.AccountName)) as Accounts,');
            Add('"" as "Account Type",T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' +
                IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('4 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level3 ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level3)>0 And char_length(T.AccountName)>0 AND (A.AccountType = "EXINC" OR A.AccountType = "INC")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT AccountID,Date,AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level4)>0,Concat(Space(15),AccountName),' + 'IF(char_length(T.Level3)>0,Concat(Space(10),AccountName),' + 'IF(char_length(T.Level2)>0,Concat(Space(5),AccountName),' +
              'Concat(Space(0),AccountName)))) as Accounts,');
            Add('"" as "Account Type",AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
            for I := 0 to ClassCount - 1 do begin
              pClass := fLstClass.Items[I];
              TempClassString := '';
              TempClassString := 'ClassID=' + IntToStr(pClass^.ClassID);
              TempClassString := '(' + TempClassString + ')';
              Add('If(' + TempClassString + '  ,(' + CreditsField + ' - ' + DebitsField + '),0.00)   as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('If(' + TempClassString + '  ,(' +
                CreditsIncField + ' - ' + DebitsIncField + '),0.00)   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('(' + CreditsField + ' - ' + DebitsField + ') as "Total Amount (Ex)" ,');
            Add('(' + CreditsIncField + ' - ' + DebitsIncField + ') as "Total Amount (Inc)" ,');
            Add('IF(char_length(T.Level3)>0,5,IF(char_length(T.Level2)>0,4, IF(char_length(T.Level1)>0,2,1))) as Ordered,');
            Add('T.Level1 as AccountHeaderOrder, ');
            Add('T.Level2 as AccountSub2Order, ');
            Add('T.Level3 as AccountSub2Order, ');
            Add('T.Level4 as AccountSub3Order, ');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + '  T ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(AccountName)>0 AND (AccountType = "COGS")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level1)>0,T.Level1,T.AccountName) as Accounts,');
            Add('"" as "Account Type",T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('1 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level1  ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level1)>0 And char_length(T.AccountName)>0 AND  (A.AccountType = "COGS")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level2)>0,Concat(Space(5),T.Level2),Concat(Space(5),T.AccountName)) as Accounts,');
            Add('"" as "Account Type",T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('2 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level2');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level2)>0 And char_length(T.AccountName)>0 AND (A.AccountType = "COGS")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add('; ');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level3)>0,Concat(Space(10),T.Level3),Concat(Space(10),T.AccountName)) as Accounts,');
            Add('"" as "Account Type",T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('4 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level3 ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level3)>0 And char_length(T.AccountName)>0 AND (A.AccountType = "COGS")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add('; ');

            Add(InsertSQL);
            Add('SELECT AccountID,Date,AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level4)>0,Concat(Space(15),AccountName),' + 'IF(char_length(T.Level3)>0,Concat(Space(10),AccountName),' + 'IF(char_length(T.Level2)>0,Concat(Space(5),AccountName),' +
              'Concat(Space(0),AccountName)))) as Accounts,');
            Add('"" as "Account Type",AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
            for I := 0 to ClassCount - 1 do begin
              pClass := fLstClass.Items[I];
              TempClassString := '';
              TempClassString := 'ClassID=' + IntToStr(pClass^.ClassID);
              TempClassString := '(' + TempClassString + ')';
              Add('If(' + TempClassString + '  ,(' + CreditsField + ' - ' + DebitsField + '),0.00)   as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('If(' + TempClassString + '  ,(' +
                CreditsIncField + ' - ' + DebitsIncField + '),0.00)   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('(' + CreditsField + ' - ' + DebitsField + ') as "Total Amount (Ex)" ,');
            Add('(' + CreditsIncField + ' - ' + DebitsIncField + ') as "Total Amount (Inc)",');
            Add('IF(char_length(T.Level3)>0,5,IF(char_length(T.Level2)>0,4, IF(char_length(T.Level1)>0,2,1))) as Ordered,');
            Add('T.Level1 as AccountHeaderOrder, ');
            Add('T.Level2 as AccountSub2Order, ');
            Add('T.Level3 as AccountSub2Order, ');
            Add('T.Level4 as AccountSub3Order, ');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(AccountName)>0 AND (AccountType = "EXEXP" OR AccountType = "EXP")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level1)>0,T.Level1,T.AccountName) as Accounts,');
            Add('"" as "Account Type",T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4, ');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('1 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level1 AND T.AccountType<>"FIXASSET" ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level1)>0 And char_length(T.AccountName)>0 AND  (A.AccountType = "EXEXP" OR A.AccountType = "EXP")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add(';');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level2)>0,Concat(Space(5),T.Level2),Concat(Space(5),T.AccountName)) as Accounts,');
            Add('"" as "Account Type",T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4, ');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('2 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level2 AND T.AccountType<>"FIXASSET" ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level2)>0 And char_length(T.AccountName)>0 AND (A.AccountType = "EXEXP" OR A.AccountType = "EXP")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add('; ');

            Add(InsertSQL);
            Add('SELECT A.AccountID,Date,A.AccountType, "" as "Decription" ,');
            Add('IF(char_length(T.Level3)>0,Concat(Space(10),T.Level3),Concat(Space(10),T.AccountName)) as Accounts,');
            Add('"" as "Account Type",T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4, ');
            for I := 0 to (ClassCount - 1) do begin
              Add('0.00  as "AmountEx' + IntToStr(I + 1) + '" ,');
              Add('0.00   as "AmountInc' + IntToStr(I + 1) + '",');
            end;
            Add('0.00 as "Total Amount (Ex)" , ');
            Add('0.00 as "Total Amount (Inc)",');
            Add('4 as Ordered,');
            Add(AccountHeaders+',');
            Add('Date as FilterDate,');
            Add('DAYNAME(Date) as FilterWeekday,');
            Add('WEEKDAY(Date) as FilterWeekdayNumber,');
            Add('WEEK(Date,3)  AS FilterWeekNumber,');
            Add('MONTH(Date) as FilterMonthNumber,');
            Add('MONTHNAME(Date) as FilterMonthName,');
            Add('QUARTER(Date) AS FilterQuarterNumber,');
            Add('YEAR(Date) AS FilterYEAR ');
            if FCFields <> '' then Add(',' + FCFields);
            Add('FROM ' + Transtablename(ctr) + ' T  ');
            Add('INNER JOIN tblchartofaccounts A on A.AccountName = T.Level3 AND T.AccountType<>"FIXASSET" ');
            Add('Where Date between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateFrom))+ ' and ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dateto)) + ' ');
            Add('and char_length(T.Level3)>0 And char_length(T.AccountName)>0 AND (A.AccountType = "EXEXP" OR A.AccountType = "EXP")');
            if clientID > 0 then Add('AND ClientID = ' + inttostr(ClientID));
            if (ctr= 1) and (includesummary ) then Add(' and Type <> "Closing Date Summary"');
            Add('; ');
          end;
        end;
      end;
      ExecuteBulkSQL;
    finally
      ClearClasses;
      ClearFCs;
      Screen.Cursor := Save_Cursor;
    end;
  finally
    fDoingRefresh:= false;
  end;
end;

end.
