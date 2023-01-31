unit Report_Balancesheet_Obj;

interface

uses ReportTransactionsTable;

type
  TBalanceSheet_Report_Obj = class(TReportTransactionTableObj)
  Private
  Protected
  Public
    Procedure CleanRefreshBalanceSheetTable(const AllClasses: boolean; const ClassIDsString: String; const ToDate: TDateTime; Const sTablename :String=''; Const FCFields :String = '');
  end;


implementation

uses controls, classes, sysutils, forms, MySQLConst, DateTimeUtils, dateutils,
  AppEnvironmentVirtual;

{ TBalanceSheet_Report_Obj }

procedure TBalanceSheet_Report_Obj.CleanRefreshBalanceSheetTable(
  const AllClasses: boolean; const ClassIDsString: String;
  const ToDate: TDateTime; const sTablename,
  FCFields: String);
var
  DebitsField: string;
  CreditsField: string;
  Save_Cursor: TCursor;
  insertSQL:String;
  dummytblInsertSQL :String;
  fstablename :String;
 Procedure SaveSQL; // populating the select SQL 4 debug purpose - populated from the SQL creating transaction table
    var
        TempSQL :TStringList;
        ctr     :Integer;
        found   :boolean;
        ii      :Integer;
    begin
        TempSQL := TStringList.Create;
        ctr     := 0;
        found   := False;
        try
            for ii := 0 to BulkSQl.count-1 do begin
                if Sysutils.SameText(BulkSQl[ii] , InsertSQL ) then begin
                    ctr := ctr+1;
                    TempSQL.Add('/*' + IntToStr(ctr) +'*/');
                    found := False;
                end else if Sysutils.SameText(BulkSQl[ii] , dummytblInsertSQL ) then begin
                    found := true;
                end else if ctr <> 0 then
                    if Sysutils.SameText(copy(Trim(BulkSQl[ii]) , 1, 11) , 'ALTER Table') then break;
                if (ctr<> 0) and (found = False) then TempSQL.Add(Trim(BulkSQl[ii]));
            end;
            ctr := 0;
            for ii := 0 to TempSQL.count-1 do
                if Sysutils.SameText(TempSQL[ii] , Trim(InsertSQL) ) then begin
                    ctr := ctr+1;
                    if ii>1 then
                        if copy(TempSQL[ii-2] , length(TempSQL[ii-2]) , 1) = ';' then
                            TempSQL[ii-2] := copy( TempSQL[ii-2] , 1, Length(TempSQL[ii-2])-1);
                    TempSQL[ii] :=  chr(13) + 'Union' + chr(13);

                    if Sysutils.SameText(copy(TempSQL[ii+1] , 1, Length('SELECT STRAIGHT_JOIN')), 'SELECT STRAIGHT_JOIN') then
                        TempSQL[ii+1] := StringReplace(TempSQL[ii+1] ,'SELECT STRAIGHT_JOIN' , 'SELECT STRAIGHT_JOIN ' + IntToStr(ctr) + ' as counter,',[rfIgnoreCase])
                    else if Sysutils.SameText(copy(TempSQL[ii+1] , 1, Length('SELECT')), 'SELECT') then
                        TempSQL[ii+1] := StringReplace(TempSQL[ii+1] ,'Select' , 'SELECT ' + IntToStr(ctr) + ' as counter,',[rfIgnoreCase]);
                end;
        finally
            FreeandNil(TempSQL);
        end;
    end;

    function Debits_Credits:String;    begin      Result := 'TRUNCATE(Sum(' + DebitsField + ')-Sum(' + CreditsField + '),4)';(*Result := 'TRUNCATE(Sum(' + DebitsField  + '-' + CreditsField + '),4)';*)    end;
    function Credits_Debits:String;    begin      Result := 'TRUNCATE(Sum(' + CreditsField + ')-Sum(' + DebitsField + '),4)';(*Result := 'TRUNCATE(Sum(' + CreditsField + '-' + DebitsField  + '),4)'; *)   end;

    Function AccountGroupName(initSpace:Integer):String;
    begin
      REsult := 'Concat(Space('+ inttostr(initSpace) +'),'+
                ' If((char_length(AccountGroupLevels)>char_length(Trans.AccountName)),'+
                        ' Concat(REPLACE(Left(AccountGroupLevels,   (char_length(AccountGroupLevels)-char_length(SUBSTRING_INDEX(AccountGroupLevels,"^",-1))-1)),"^",Char(32,92,32))," - ",Trans.AccountName),'+
                        ' Trans.AccountName)) ';
    end;
begin
  fDoingRefresh:= true;
  try
    if sTablename = '' then fstablename := 'tblbalancesheet' else fstablename := sTablename;

    DebitsField  := 'DebitsEx';
    CreditsField := 'CreditsEx';


    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      with BulkSQL do begin
        Clear;

        Add('Truncate ' + fstablename + ';');

        dummytblInsertSQL := 'INSERT HIGH_PRIORITY INTO ' + fstablename + ' (Seqno, SortID,AccountName,AccountType,Column1,Column2,Column3,Column4,Column5 )';
        insertSQL     := 'INSERT HIGH_PRIORITY INTO ' + fstablename + ' (Seqno, SortID,AccountName,AccountType,Column1,Column2,Column3,Column4,Column5 ';
        if FCFields <> '' then insertSQL := insertSQl +',' + FCFields;
        insertSQL := insertSQl +')';

        Add(dummytblInsertSQL);
        Add('SELECT ');
        Add('1,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('"ASSETS" as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        Add('From DUAL;');

        Add(dummytblInsertSQL);
        Add('SELECT ');
        Add('2, 0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(5),"Current Assets") as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        Add('From DUAL;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('6,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(10),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "BANK") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');


        Add(InsertSQL);
        Add('SELECT ');
        Add('7,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(15) +' as Column1, ');
        Add(Debits_Credits +'  AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "BANK") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName  having column2 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('8,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(10),"Total"," ",AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Debits_Credits +'    AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "BANK") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('9,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(10),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "AR") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('10,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(15) +' as Column1, ');
        Add(Debits_Credits +'  AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "AR") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having column2 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('11,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(10),"Total"," ",AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Debits_Credits +'  AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType =  "AR") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('12,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(10),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "OCASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('13, 0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(15) +' as Column1, ');
        Add(Debits_Credits +'  AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "OCASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having column2 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('14,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(10),"Total"," ",AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Debits_Credits +'  AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType =  "OCASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('15,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"Total Current Assets" as AccountType, ');
        Add('Concat(Space(5),"Total Current Assets") as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add(Debits_Credits +'  AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "AR" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('16,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(5),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "FIXASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('17,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(15) +' as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Debits_Credits +'  AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "FIXASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having Column3 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('18,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(5),"Total"," ",AccDesc) AS Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add(Debits_Credits +'  AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "FIXASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('19,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(10),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "OASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('20,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(15) +' as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Debits_Credits +'  AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "OASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having Column3 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('21,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(10),"Total"," ",AccDesc) AS Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add(Debits_Credits +'  AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "OASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('22,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"TOTAL ASSETS" as AccountType, ');
        Add('"TOTAL ASSETS" as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add(Debits_Credits +'  AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "AR" OR Trans.AccountType = "BANK" OR Trans.AccountType = "OCASSET" OR Trans.AccountType = "OASSET")  ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('23,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"TOTAL ASSETS" as AccountType, ');
        Add('"TOTAL ASSETS" as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add(Debits_Credits +'  AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "FIXASSET") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(dummytblInsertSQL);
        Add('SELECT ');
        Add('3,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('"" as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        Add('From DUAL;');

        Add(dummytblInsertSQL);
        Add('SELECT ');
        Add('4,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('"LIABILITIES & EQUITY" as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        Add('From DUAL;');

        Add(dummytblInsertSQL);
        Add('SELECT ');
        Add('5,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(5),"Liabilities") as Column2, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        Add('From DUAL;');

        Add(dummytblInsertSQL);
        Add('SELECT ');
        Add('6,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(10),"Current Liabilities") as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        Add('From DUAL;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('24,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(15),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "CCARD") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('25,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(15) +' as Column1, ');
        Add(Credits_Debits +'   AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "CCARD") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having column2 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('26,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(15),"Total"," ",AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Credits_Debits +'   AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "CCARD") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('27,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(15),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "AP") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('28,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(20) +' as Column1, ');
        Add(Credits_Debits +'   AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "AP") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having column2 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('29,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(15),"Total"," ",AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Credits_Debits +'   AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "AP") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('30,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(15),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "OCLIAB") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('31,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(20) +' as Column1, ');
        Add(Credits_Debits +'   AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "OCLIAB") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having column2 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('32,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('Concat("Total"," ",AccDesc) as AccountType, ');
        Add('Concat(Space(15),"Total"," ",AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Credits_Debits +'   AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "OCLIAB") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('33,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"Total Current Liabilities" as AccountType, ');
        Add('Concat(Space(10),"Total Current Liabilities") as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('IF((Trans.AccountType = "CCARD"),'+ Debits_Credits +' ,'+ Credits_Debits +'   ) AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "AP" OR Trans.AccountType = "OCLIAB" OR Trans.AccountType = "CCARD") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('34,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(15),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "LTLIAB") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('35,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(20) +' as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Credits_Debits +'   AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "LTLIAB") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having Column3 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('36,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"Total Long Term Liability" as AccountType, ');
        Add('Concat(Space(15),"Total Long Term Liability") as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add(Credits_Debits +'   AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (AccountType = "LTLIAB") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('37,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(15),AccDesc) as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('INNER JOIN tblacctypedesc on AccType = Trans.AccountType ');
        Add('WHERE (Trans.AccountType = "EQUITY") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('38,0 as SortID,  ');
        Add('Trans.AccountName as AccountName, ');
        Add('Trans.AccountType as AccountType, ');
        Add(AccountGroupName(20) +' as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Credits_Debits +'   AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (Trans.AccountType = "EQUITY") AND (AccountName<>"Retained Earnings") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By Column1,Trans.AccountName having Column3 <>0;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('39,0 as SortID,  ');
        Add('"Retained Earnings" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(20),"Retained Earnings") as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Credits_Debits +'   AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('Where ((AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") ');
        Add('OR (AccountName="Retained Earnings")) ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, IncDay(DateTimeUtils.FiscalYearStart(ToDate, AppEnvVirt.Str['CompanyPrefs.FiscalYearStarts']), - 1))) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('40,0 as SortID,  ');
        Add('"Profit&Loss" as AccountName, ');
        Add('"" as AccountType, ');
        Add('Concat(Space(20),"Net Income") as Column1, ');
        Add('0.00 AS Column2, ');
        Add(Credits_Debits +'   AS Column3, ');
        Add('0.00 AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('Where (AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") ');
        (*Add('Where ((AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") ');
        Add('OR (AccountName="Retained Earnings")) ');*)
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date Between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, DateTimeUtils.FiscalYearStart(todate, AppEnvVirt.Str['CompanyPrefs.FiscalYearStarts']))) + ' AND ' +
                                  QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID; ');

        Add(InsertSQL);
        Add('SELECT ');
        Add('41,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"Total Capital / Equity" as AccountType, ');
        Add('Concat(Space(15),"Total Capital / Equity") as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add(Credits_Debits +'   AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID;');

        Add(InsertSQL);
        Add('SELECT ');
        Add('42,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"Total Capital / Equity" as AccountType, ');
        Add('Concat(Space(15),"Total Capital / Equity") as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add(Credits_Debits +'   AS Column4, ');
        Add('0.00 AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('WHERE (AccountType = "EQUITY")');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID; ');

        Add(InsertSQL);
        Add('SELECT ');
        Add('43,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"TOTAL LIABILITIES & EQUITY" as AccountType, ');
        Add('"TOTAL LIABILITIES & EQUITY" as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add(Credits_Debits +'   AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('Where (AccountType = "EXEXP" OR AccountType = "EXINC" OR AccountType = "EXP" OR AccountType = "INC" OR AccountType = "COGS") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID; ');

        Add(InsertSQL);
        Add('SELECT ');
        Add('44,0 as SortID,  ');
        Add('"" as AccountName, ');
        Add('"TOTAL LIABILITIES & EQUITY" as AccountType, ');
        Add('"TOTAL LIABILITIES & EQUITY" as Column1, ');
        Add('0.00 AS Column2, ');
        Add('0.00 AS Column3, ');
        Add('0.00 AS Column4, ');
        Add(Credits_Debits +'   AS Column5 ');
        if FCFields <> '' then Add(',' + StringReplace('Trans.' + FCFields , ',' , ',Trans.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions as Trans ');
        Add('Where (AccountType = "AP" OR AccountType = "OCLIAB" OR AccountType = "EQUITY" OR Trans.AccountType = "CCARD" OR Trans.AccountType = "LTLIAB") ');
        if not AllClasses then Add('AND (' + ClassIDsString + ') ');
        Add('AND Date <= ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, ToDate)) + ' ');
        Add('Group By SortID; ');

        Add('UPDATE ' + fstablename + ' SET Column2= Null WHERE Round(Column2,' + intTostr(fTotalsRoundPlaces)+')=0.000; ');
        Add('UPDATE ' + fstablename + ' SET Column3= Null WHERE Round(Column3,' + intTostr(fTotalsRoundPlaces)+')=0.000; ');
        Add('UPDATE ' + fstablename + ' SET Column4= Null WHERE Round(Column4,' + intTostr(fTotalsRoundPlaces)+')=0.000; ');
        Add('UPDATE ' + fstablename + ' SET Column5= Null WHERE Round(Column5,' + intTostr(fTotalsRoundPlaces)+')=0.000; ');

        Add('UPDATE ' + fstablename + ' INNER JOIN tblchartofaccounts COA Using(AccountName) SET ' + fstablename + '.AccountNumber=COA.AccountNumber ');
        Add('WHERE char_length(' + fstablename + '.AccountName)<>0 AND char_length(COA.AccountNumber)<>0;');
      end;

      ExecuteBulkSQL;
    finally
      Screen.Cursor := Save_Cursor;
      Application.ProcessMessages
    end;
  finally
    fDoingRefresh:= false;
  end;
end;
end.
