unit TrialBalanceSQL;

interface

uses
  classes, ReportBaseObj, Types, ErpDBComponents, IntegerListObj;

type

  TTrialBalanceReport = class(TReportWithDateRangeBase)
  private
    fTempTableName: string;
    fStringListForSQL: TStringList;
    fAllDetartments: boolean;
    (*fDateTo: TDateTime;
    fDateFrom: TDateTime;*)
    FCFields :String;
    fReportClassName: string;
    fSelectedDepartments: TStringList;
    fAllOtherDepartments: boolean;
    fUseDateRange: boolean;
    fIncludedataPriorToClosingDate: boolean;
    fSelectedDepartmentIDs: TIntegerList;
    DoSelectedDepartmentIDsChange: boolean;
    fDepartmentFieldNames: TStringList;
    function GetSelectedDepartments: string;
    procedure SetSelectedDepartments(const Value: string);
    function GetUseDateRange: boolean;
    procedure SetUseDateRange(const Value: boolean);
    procedure DoOnSelectedDepartmentIDsChange(Sender: TObject);
  protected
//    function DepartmentSelected(const aDeptName: string): boolean;
    function YearStart: TDatetime;
    Function AllClassIds(Qry: TERPQuery):String;
  public
    AmountFieldList, AmountCaptionList: TStringDynArray;
    UsingReportTables: boolean;
    property DepartmentFieldNames: TStringList read fDepartmentFieldNames write fDepartmentFieldNames;
    constructor Create; override;
    destructor Destroy; override;
    property TempTableName: string read fTempTableName;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
    property StringListForSQL: TStringList read fStringListForSQL write fStringListForSQL;
    property ReportClassName: string read fReportClassName write fReportClassName;
    property SelectedDepartmentIDs: TIntegerList read fSelectedDepartmentIDs;
  published
    property IncludePriorClosingDate: boolean read fIncludedataPriorToClosingDate write fIncludedataPriorToClosingDate;
    property AllDepartments: boolean read fAllDetartments write fAllDetartments;
    property AllOtherDepartments: boolean read fAllOtherDepartments write fAllOtherDepartments;
    (*property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;*)
    property UseDateRange: boolean read GetUseDateRange write SetUseDateRange;
    property SelectedDepartments: string read GetSelectedDepartments write SetSelectedDepartments;
  end;


implementation

uses
  TempTableUtils, SysUtils, BusObjFCOnReport, BusObjBase, SyncReportTableObj,
  BaseListUtilsObj, tcConst, DateUtils, MySQLConst, CommonLib, DnMLib,
  StringUtils, LogLib;


const
  CreditsEx  = 'sum(IF ( CreditsEx -DebitsEx  >0.00 ,  CreditsEx-DebitsEx  ,0.00))';
  DebitsEx   = 'sum(IF ( CreditsEx -DebitsEx  <0.00 ,  DebitsEx-CreditsEx  ,0.00)) ';
  CreditsInc = 'sum(IF ( CreditsInc-DebitsInc >0.00 ,  CreditsInc-DebitsInc,0.00)) ';
  DebitsInc  = 'sum(IF ( CreditsInc-DebitsInc <0.00 ,  DebitsInc-CreditsInc,0.00)) ';

{ TTrialBalanceReport }

function TTrialBalanceReport.AllClassIds(Qry: TERPQuery): String;
begin
  result :=Qry.GroupConcat('ClassId');
end;

constructor TTrialBalanceReport.Create;
begin
  inherited;
  DoSelectedDepartmentIDsChange := true;
  fSelectedDepartmentIDs := TIntegerList.Create;
  fSelectedDepartmentIDs.OnChange := DoOnSelectedDepartmentIDsChange;
  fStringListForSQL := nil;
  UsingReportTables := false;
  fIncludedataPriorToClosingDate := false;
  fAllOtherDepartments := true;
  fUseDateRange := false;
  fReportClassName := 'TTrialBalanceGUI';
  fAllDetartments := true;
  DateTo := Date;
  DateFrom := 0;
  fTempTableName :=  UniqueTableName('TrialBalance', SharedConnection);
  fSelectedDepartments := TStringList.Create;
  fDepartmentFieldNames := nil;
end;

//function TTrialBalanceReport.DepartmentSelected(
//  const aDeptName: string): boolean;
//begin
//  result := fSelectedDepartments.IndexOf(aDeptName) > -1;
//end;

destructor TTrialBalanceReport.Destroy;
begin
  fSelectedDepartments.Free;
  fSelectedDepartmentIDs.Free;
  TempTableUtils.DestroyUserTemporaryTable(SharedConnection, TempTableName);
  inherited;
end;

procedure TTrialBalanceReport.DoOnSelectedDepartmentIDsChange(Sender: TObject);
begin
 if not DoSelectedDepartmentIDsChange then exit;

 fSelectedDepartments.Clear;
end;

function TTrialBalanceReport.GetSelectedDepartments: string;
var
  qry: TERPQuery;
begin
  if fSelectedDepartmentIDs.Count = 0 then begin
    result := '';
  end
  else begin
    if fSelectedDepartments.Count <> fSelectedDepartmentIDs.Count then begin
      fSelectedDepartments.Clear;
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := SharedConnection;
        qry.SQL.Add('select ClassID, ClassName from tblclass');
        qry.SQL.Add('where VlassID in (' + fSelectedDepartmentIDs.CommaText + ')');
        qry.Open;
        while not qry.eof do begin
          fSelectedDepartments.Add(qry.FieldByName('ClassName').AsString);
          qry.Next;
        end;
      finally
        qry.Free;
      end;
    end;
    result := fSelectedDepartments.CommaText;
  end;
end;

function TTrialBalanceReport.GetUseDateRange: boolean;
begin
  result := fUseDateRange;
end;

function TTrialBalanceReport.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
    SQLList :TStringList;
    ctr,i  :Integer;
    qry: TERPQuery;
    sl, sl2: TStringList;
    x: integer;
    s: string;
    strSQL: String;
    FCR: TForeignCurrencyonReport;


    Procedure ReportHeader;
    begin
        StringListForSQL.Clear;
        StringListForSQL.Add('{ReportHeader}SELECT');
        StringListForSQL.Add('CO.CompanyName,');
        StringListForSQL.Add('CO.Address,');
        StringListForSQL.Add('CO.Address2,');
        StringListForSQL.Add('CO.City,');
        StringListForSQL.Add('CO.State,');
        StringListForSQL.Add('CO.Postcode,');
        StringListForSQL.Add('Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,');
        StringListForSQL.Add('Concat("Fax ",CO.FaxNumber) AS FaxNumber,');
        StringListForSQL.Add('Concat("ABN " , CO.ABN) as ABN ,');
        if not AllDepartments then
             StringListForSQL.Add('"Selected" as ClassType,')
        else StringListForSQL.Add('"All" as ClassType,');
        StringListForSQL.Add('Concat("As of : " ,' +  QuotedStr(FormatDateTime('dddd dd-mmmm-YYYY',DateTo)) +   ') as  AsofDate');
        StringListForSQL.Add('FROM tblCompanyInformation AS CO;');
        StringListForSQL.Add('~|||~{RepData}');
    end;

    function ClassID: string;
    begin
      if APIMode then result := qry.FieldByName('ClassName').AsString
      else result := IntToStr(qry.FieldByName('ClassID').AsInteger);
    end;

    function AllDept: string;
    begin
      if APIMode then result := 'AllDept'
      else result := Inttostr(IDForAllOther);
    end;
begin
    result := inherited;
    FCFields := '';
    SQLList := TStringList.Create;
    qry := TERPQuery.Create(nil);
    FCR := TForeignCurrencyonReport.Create(nil);
    if not Assigned(StringListForSQL) then begin
      sl := TStringList.Create;
      StringListForSQL := sl;
    end
    else
      sl := nil;
    if not Assigned(DepartmentFieldNames) then begin
      sl2 := TStringList.Create;
      DepartmentFieldNames := sl2;
    end
    else
      sl2 := nil;
    try
      ReportHeader;
      SQLList.add(TempTableUtils.CreateUserTemporaryTableSQL(fTempTableName,'tmp_TrialBalance'));

      qry.Connection := SharedConnection;

      FCR.Connection := TMyDacDataConnection.Create(FCR);
      FCR.Connection.Connection := SharedConnection;
      FCR.LoadFCPref(fReportClassName);

        if FCR.Count > 0 then begin
        TBaseListUtils.InitFCFields(AmountFieldList,AmountCaptionList,fReportClassName,SharedConnection,APIMode);
          FCR.First;
          while FCR.Eof = False do begin
              SQLList.add('Alter table ' + TempTableName + ' Add column  `' + FCR.Code + '_FCRate` Double,');
              for ctr := low(AmountFieldList) to high(AmountFieldList) do begin
                  if ctr > 0 then SQLList.add(',');
                  SQLList.add('Add column  `' + FCR.Code + '_' + AmountFieldList[ctr] + '` Double' );
              end;
              SQLList.add(';');
              if FCFields <> '' then FCFields := FCFields + ',' ;
              FCFields := FCFields + FCR.Code + '_FCRate';
              FCR.Next;
            end;
        end;
        DepartmentFieldNames.Clear;
        if (not AllDepartments) and (fSelectedDepartmentIds.Count > 0) then begin
          qry.SQL.Text := 'select ClassName, ClassID from tblclass where ClassId in (' + self.SelectedDepartmentIds.CommaText + ')';
          qry.Open;
          while not qry.Eof do begin
            SQLList.add('Alter table ' + TempTablename + ' Add column `' + ClassID + '_CreditsEx` Double,');
            SQLList.add(                               ' Add column `' + ClassID + '_DebitsEx` Double,');
            SQLList.add(                               ' Add column `' + ClassID + '_CreditsInc` Double,');
            SQLList.add(                               ' Add column `' + ClassID + '_DebitsInc` Double;');
            DepartmentFieldNames.Add(ClassID + '_CreditsEx');
            DepartmentFieldNames.Add(ClassID + '_DebitsEx');
            DepartmentFieldNames.Add(ClassID + '_CreditsInc');
            DepartmentFieldNames.Add(ClassID + '_DebitsInc');
            qry.Next;
          end;
          if AllOtherDepartments then begin
            SQLList.add('Alter table ' + TempTablename + ' Add column `' + AllDept + '_CreditsEx` Double,');
            SQLList.add(                               ' Add column `' + AllDept + '_DebitsEx` Double,');
            SQLList.add(                               ' Add column `' + AllDept + '_CreditsInc` Double,');
            SQLList.add(                               ' Add column `' + AllDept + '_DebitsInc` Double;');
            DepartmentFieldNames.Add(AllDept + '_CreditsEx');
            DepartmentFieldNames.Add(AllDept + '_DebitsEx');
            DepartmentFieldNames.Add(AllDept + '_CreditsInc');
            DepartmentFieldNames.Add(AllDept + '_DebitsInc');
          end;
        end;

        SQLList.Add('/*');
        if UseDateRange then begin
          SQLList.Add('Date Range Selected');
          SQLList.Add('From date '+ FormatDateTime(FormatSettings.ShortDateFormat , DateFrom));
          SQLList.Add('To date '+ FormatDateTime(FormatSettings.ShortDateFormat , DateTo));
        end else begin
          SQLList.Add('Date Range NOT Selected');
          SQLList.Add('To date '+ FormatDateTime(FormatSettings.ShortDateFormat , DateTo));
        end;
        SQLList.Add('Year Start '+ FormatDateTime(FormatSettings.ShortDateFormat , Yearstart));
        SQLList.Add('*/');
        SQLList.Add('truncate ' + TempTablename +';');
        SQLList.add('insert into ' + TempTablename );
        SQLList.add('(AccountName, AccountNameOnly , AccountNumber , CreditsEx , DebitsEx , CreditsInc , DebitsInc ,');
        if (not AllDepartments) and (fSelectedDepartmentIds.Count > 0) then
          SQLList.add(DepartmentFieldNames.CommaText + ',');
        SQLList.add('TransID , SortID , SortOrder , Account');
        if FcFields <> '' then SQLList.add(', ' + FCFields);
        SQLList.add(') Select AccountName, AccountNameOnly , AccountNumber , '+
            CreditsEx + ' as CreditsEx ,'+
            DebitsEx  + ' as DebitsEx  ,'+
            CreditsInc+ ' as CreditsInc,'+
            DebitsInc + ' as DebitsInc ,');
        (*                    'Sum(CreditsEx) , '+
                              'sum(DebitsEx) , '+
                              'Sum(CreditsInc) , '+
                              'sum(DebitsInc) ,');*)
        if (not AllDEpartments) and (fSelectedDepartmentIds.Count > 0) then begin
          s:= '';
          for x := 0 to DepartmentFieldNames.Count -1 do
            s:= s + ' SUM(' + DepartmentFieldNames[x] + '),';
          SQLList.add(s);
        end;
        SQLList.add('TransID , SortID , SortOrder , Account');
        if FcFields <> '' then SQLList.add(', ' + FCFields);
        SQLList.add(' from (');

        for i := 1 to 2 do begin
          if ( i = 1) or (IncludePriorClosingDate) then begin
{--------------- : 1}
            strSQL:= '';
            strSQL := strSQL +' SELECT';
            strSQL := strSQL +' SUBSTRING(If((char_length(AccountGroup)>0),Concat(AccountGroup," - ",Trans.AccountName),Trans.AccountName),1,255) as AccountName,';
            strSQL := strSQL +'Trans.AccountName as AccountNameOnly,';
            strSQL := strSQL +'tblchartofaccounts.AccountNumber as AccountNumber,';
            strSQL := strSQL +CreditsEx + ' as CreditsEx ,';
            strSQL := strSQL +DebitsEx  + ' as DebitsEx  ,';
            strSQL := strSQL +CreditsInc+ ' as CreditsInc,';
            strSQL := strSQL +DebitsInc + ' as DebitsInc ,';

            if (not AllDepartments) and (fSelectedDepartmentIds.Count > 0) then begin
              qry.First;
              while not qry.Eof do begin
                strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) >0.00)    ,  (Sum(CreditsEx -DebitsEx))  ,0.00),0.00) as `' + ClassID + '_CreditsEx`,';
                strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) <0.00 )   ,  (Sum(DebitsEx  -CreditsEx)) ,0.00),0.00) as `' + ClassID + '_DebitsEx`,';
                strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) >0.00 ) ,  (Sum(CreditsInc-DebitsInc)) ,0.00),0.00) as `' + ClassID + '_CreditsInc`,';
                strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) <0.00 ) ,  (Sum(DebitsInc -CreditsInc)),0.00),0.00) as `' + ClassID + '_DebitsInc`,';
                qry.Next;
              end;
              if AllOtherDepartments then begin
                strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsEx  +',0)  as `' + AllDept + '_CreditsEx` ,';
                strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsEx   +',0)  as `' + AllDept + '_DebitsEx`  ,';
                strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsInc +',0)  as `' + AllDept + '_CreditsInc`,';
                strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsInc  +',0)  as `' + AllDept + '_DebitsInc` ,';
              end;
            end;
            strSQL := strSQL +'TransID as TransId,';
            strSQL := strSQL +'0 as SortID,';
            strSQL := strSQL +'SortOrder as SortOrder,';
            strSQL := strSQL +'Trans.AccountName as Account ';
            if FcFields <> '' then strSQL := strSQL +', ' + FCFields;
            if i = 1 then strSQL := strSQL +' FROM tbltransactions as Trans' else strSQL := strSQL +' FROM tbltransactionsummarydetails as Trans';
            strSQL := strSQL +' INNER JOIN tblchartofaccounts Using(AccountID)';
            strSQL := strSQL +' INNER JOIN tblacctypedesc ON tblacctypedesc.AccType=Trans.AccountType';
            strSQL := strSQL +' Where  NOT(Trans.AccountType = "EXEXP" OR Trans.AccountType = "EXINC" OR Trans.AccountType = "EXP" OR Trans.AccountType = "INC" OR Trans.AccountType = "COGS")';
            if UseDateRange then
                 strSQL := strSQL +' AND Date Between  ' + Quotedstr(Formatdatetime(MysqlDateFormat , DateFrom)) + '  AND ' + Quotedstr(formatDatetime(MysqlDateFormat , DateTo))
            else strSQL := strSQL +' AND Date <=  ' + Quotedstr(formatDatetime(MysqlDateFormat , DateTo));
            if (i=1) and (IncludePriorClosingDate)  then strSQL := strSQL +' AND Trans.Type <> "Closing Date Summary" AND Trans.Seqno <100  ';
            strSQL := strSQL +' Group By Trans.AccountName';
            if not AllDepartments then strSQL := strSQL +',ClassID';
            SQLList.add(iif(i = 2, ' UNION ALL ' , '') + strSQL);
{--------------- : 2}
            if UseDateRange and (DateTo < yearstart) then
            {this section not applicable if the todate selected is less than the financial year start}
            else begin
              strSQL:=  '';
              strSQL := strSQL +' UNION ALL';
              strSQL := strSQL +' SELECT';
              strSQL := strSQL +' SUBSTRING(If((char_length(AccountGroup)>0),Concat(AccountGroup," - ",Trans.AccountName),Trans.AccountName),1,255) as AccountName,';
              strSQL := strSQL +'Trans.AccountName as AccountNameOnly  ,';
              strSQL := strSQL +'tblchartofaccounts.AccountNumber as AccountNumber  ,';
              strSQL := strSQL +CreditsEx + ' as CreditsEx ,';
              strSQL := strSQL +DebitsEx  + ' as DebitsEx  ,';
              strSQL := strSQL +CreditsInc+ ' as CreditsInc,';
              strSQL := strSQL +DebitsInc + ' as DebitsInc ,';

              if (not AllDepartments) and (fSelectedDepartmentIds.Count > 0) then begin
                qry.First;
                while not qry.Eof do begin
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) >0.00)    ,  (Sum(CreditsEx -DebitsEx))  ,0.00),0.00) as `' + ClassID + '_CreditsEx`,';
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) <0.00 )   ,  (Sum(DebitsEx  -CreditsEx)) ,0.00),0.00) as `' + ClassID + '_DebitsEx`,';
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) >0.00 ) ,  (Sum(CreditsInc-DebitsInc)) ,0.00),0.00) as `' + ClassID + '_CreditsInc`,';
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) <0.00 ) ,  (Sum(DebitsInc -CreditsInc)),0.00),0.00) as `' + ClassID + '_DebitsInc`,';
                  qry.Next;
                end;
                if AllOtherDepartments then begin
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsEx  +',0)  as `' + AllDept + '_CreditsEx` ,';
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsEx   +',0)  as `' + AllDept + '_DebitsEx`  ,';
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsInc +',0)  as `' + AllDept + '_CreditsInc`,';
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsInc  +',0)  as `' + AllDept + '_DebitsInc` ,';
                end;
              end;
              strSQL := strSQL +'TransID as TransID  ,';
              strSQL := strSQL +'0 as SortID  ,';
              strSQL := strSQL +'SortOrder as SortOrder  ,';
              strSQL := strSQL +'Trans.AccountName as Account';
              if FcFields <> '' then strSQL := strSQL +', ' + FCFields;
              if i = 1 then strSQL := strSQL +' FROM tbltransactions as Trans' else strSQL := strSQL +' FROM tbltransactionsummarydetails as Trans';
              strSQL := strSQL +' INNER JOIN tblchartofaccounts Using(AccountID)';
              strSQL := strSQL +' INNER JOIN tblacctypedesc ON tblacctypedesc.AccType=Trans.AccountType';
              strSQL := strSQL +' WHERE (Trans.AccountType = "EXEXP" OR Trans.AccountType = "EXINC" OR Trans.AccountType = "EXP" OR Trans.AccountType = "INC" OR Trans.AccountType = "COGS")';

              if UseDateRange then begin
                if DateFrom < yearstart then
                       strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , yearstart     )) +' AND Date <=' + Quotedstr(formatDatetime(MysqlDateFormat , DateTo))
                else   strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , DateFrom)) +' AND Date <=' + Quotedstr(formatDatetime(MysqlDateFormat , DateTo));
              end else strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , yearstart     )) +' AND Date <=' + Quotedstr(formatDatetime(MysqlDateFormat , DateTo));
                     //strSQL := strSQL +' AND Date <=  ' + Quotedstr(formatDatetime(MysqlDateFormat , FilterDateTo  )) +' AND Date >=' + Quotedstr(formatDatetime(MysqlDateFormat , yearstart));

              if (i=1) and (IncludePriorClosingDate)  then strSQL := strSQL +' AND Trans.Type <> "Closing Date Summary" AND Trans.Seqno <100  ';
              strSQL := strSQL +' Group By Trans.AccountName';
              if not AllDepartments then
                strSQL := strSQL +',ClassID';
              SQLList.add(strSQL);
            end;
{--------------- : 3}
            if UseDateRange and (DateFrom > yearstart) then
              {this section not applicable if the from date selected is > finanacial year start}
            else begin
              strSQL:= '';
              strSQL := strSQL +' UNION ALL';
              strSQL := strSQL +' SELECT';
              strSQL := strSQL +' "Retained Earnings" as AccountName,';
              strSQL := strSQL +'"Retained Earnings" as AccountNameOnly  ,';
              strSQL := strSQL +'"" as AccountNumber  ,';
              strSQL := strSQL +CreditsEx + ' as CreditsEx ,';
              strSQL := strSQL +DebitsEx  + ' as DebitsEx  ,';
              strSQL := strSQL +CreditsInc+ ' as CreditsInc,';
              strSQL := strSQL +DebitsInc + ' as DebitsInc ,';

              if (not AllDepartments) and (fSelectedDepartmentIds.Count > 0) then begin
                qry.First;
                while not qry.Eof do begin
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) >0.00)    ,  (Sum(CreditsEx -DebitsEx))  ,0.00),0.00) as `' + ClassID + '_CreditsEx`,';
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsEx-DebitsEx) <0.00 )   ,  (Sum(DebitsEx  -CreditsEx)) ,0.00),0.00) as `' + ClassID + '_DebitsEx`,';
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) >0.00 ) ,  (Sum(CreditsInc-DebitsInc)) ,0.00),0.00) as `' + ClassID + '_CreditsInc`,';
                  strSQL := strSQL +'if(ClassID = ' + IntToStr(qry.FieldByName('ClassId').AsInteger) + ', IF ( ( Sum(CreditsInc-DebitsInc) <0.00 ) ,  (Sum(DebitsInc -CreditsInc)),0.00),0.00) as `' + ClassID + '_DebitsInc`,';
                  qry.Next;
                end;
                if AllOtherDepartments then begin
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsEx  +',0)  as `' + AllDept + '_CreditsEx` ,';
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsEx   +',0)  as `' + AllDept + '_DebitsEx`  ,';
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + CreditsInc +',0)  as `' + AllDept + '_CreditsInc`,';
                  strSQL := strSQL +'if(not(ClassID in (' + AllClassIds(Qry) + ')), ' + DebitsInc  +',0)  as `' + AllDept + '_DebitsInc` ,';
                end;
              end;
              strSQL := strSQL +'TransID as TransID  ,';
              strSQL := strSQL +'0 as SortID,';
              strSQL := strSQL +'SortOrder as SortOrder  ,';
              strSQL := strSQL +'"Retained Earnings" as Account';
              if FcFields <> '' then strSQL := strSQL +', ' + FCFields;
              if i = 1 then strSQL := strSQL +' FROM tbltransactions as Trans' else strSQL := strSQL +' FROM tbltransactionsummarydetails as Trans';
              strSQL := strSQL +' INNER JOIN tblchartofaccounts Using(AccountID)';
              strSQL := strSQL +' INNER JOIN tblacctypedesc ON tblacctypedesc.AccType=Trans.AccountType';
              strSQL := strSQL +' WHERE (Trans.AccountType = "EXEXP" OR Trans.AccountType = "EXINC" OR Trans.AccountType = "EXP" OR Trans.AccountType = "INC" OR Trans.AccountType = "COGS")';
              if UseDateRange then begin
                   strSQL := strSQL +' AND Date >=  ' + Quotedstr(Formatdatetime(MysqlDateFormat , DateFrom)) +
                                '  AND date < ' + Quotedstr(formatDatetime(MysqlDateFormat , yearstart))
              end else strSQL := strSQL +' AND Date <  ' + Quotedstr(formatDatetime(MysqlDateFormat , yearstart));

              if (i=1) and (IncludePriorClosingDate)  then strSQL := strSQL +' AND Trans.Type <> "Closing Date Summary" AND Trans.Seqno <100  ';
              strSQL := strSQL +' Group By SortID';
              if not AllDepartments then strSQL := strSQL +',ClassID';
            SQLList.add(strSQL);
            end;
          end;
        end;
        SQLList.add('ORDER BY SortOrder) as TransDetails ');
        SQLList.add(' Group by AccountName, AccountNameOnly , AccountNumber /*, TransID , SortID , SortOrder , Account */ ORDER BY SortOrder ;');
        if FCR.Count > 0 then begin
            FCR.First;
            while FCR.Eof = False do begin
                for ctr := low(AmountfieldList) to high(AmountfieldList) do
                    SQLList.add('update ' +TempTableName + ' set ' +  FCR.Code + '_' + amountfieldList[ctr] + '  = ' + AmountfieldList[ctr] + ' * ' + FCR.Code + '_FCRate;' );
                FCR.Next;
            end;
        end;
        with TERPScript.Create(nil) do try
          Connection := SharedConnection;
          //clog(SQLList.text);
          SQL.add(SyncReportObj.ChangeQuery(SQLList.text, usingReportTables));
          clog(SQL.text);
          Execute;
        finally
          Free;
        end;
    finally
        FreeandNil(SQLList);
        qry.Free;
        FCR.Free;
        sl.Free;
        sl2.Free;
    end;
    StringListForSQL.Add('select * ' );
    StringListForSQL.Add(' from ' + TempTableName);
    if Assigned(SQL) then
      SQL.Text := 'select * from ' + TempTableName + ' order by AccountName';
end;

procedure TTrialBalanceReport.SetSelectedDepartments(const Value: string);
begin
  fSelectedDepartments.CommaText := Value;
  DoSelectedDepartmentIDsChange := false;
  try
    fSelectedDepartmentIDs.Clear;
    if fSelectedDepartments.Count > 0 then begin
      AllDepartments := False;
      (*qry := TERPQuery.Create(nil);
      try
        qry.Connection := SharedConnection;
        qry.SQL.Add('select ClassID, ClassName from tblclass');
        qry.SQL.Add('where ClassName in (' + StringUtils.QuotedCommaText(fSelectedDepartments) + ')');
        qry.Open;
        while not qry.Eof do begin
          fSelectedDepartmentIDs.Add(qry.FieldByName('ClassID').AsInteger);
          qry.Next;
        end;
      finally
        qry.Free;
      end;*)
      fSelectedDepartmentIDs.CommaText := ClassnamesTOIds(fSelectedDepartments.CommaText);
    end;
  finally
    DoSelectedDepartmentIDsChange := true;
  end;
end;

procedure TTrialBalanceReport.SetUseDateRange(const Value: boolean);
begin
  fUseDateRange := Value;
end;

function TTrialBalanceReport.YearStart: TDatetime;
begin
  result := DateOf(GetCurrentFiscalYearStart(DateTo));
end;

initialization
  RegisterClass(TTrialBalanceReport);

end.
