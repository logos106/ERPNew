{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 12/10/05  1.00.00 BJ   Initial version.
}
unit BusObjBudgetImportExport;


interface

uses BusObjImportExport, db;

type
  TBusObjBudgetImportExport = class(TBusObjImportExport)
  private
    TableName: string;
    function StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
    function CreateExportTable: string;
    function CreateImportTable(const FieldNames: string): string;
  public
    procedure LoadSQL; override;
    function ImportData: boolean; override;
    destructor Destroy; override;
    procedure DeleteAll(const dataset: TDataset);
  end;

implementation

uses FastFuncs,BusObjBase, CommonDBLib, MyAccess,ERPdbComponents, SysUtils, Classes, BudgetLib, Commonlib,
     BusObjBudget, BusObjBudgetDef;


function TBusObjBudgetImportExport.ImportData: boolean;
var
  Count: integer;
  I: integer;
  ctr: integer;
  LineString: string;
  HeadingString: string;
  FieldName: string;
  FieldValue: string;
  QryBudgets: TERPQuery;
  QryAccounts: TERPQuery;
  QryJobs: TERPQuery;
  BudgetId: integer;
  Periods: integer;
  Budget: TBusObjBudget;
  BudgetName: string;
  MissingAcct: boolean;
  MissingJob: boolean;

  function getBudgetId(const BudgetName: string): integer;
  begin
    QryBudgets.First;
    if QryBudgets.Locate('Name', BudgetName, []) then Result := QryBudgets.FieldByName('BudgetId').AsInteger
    else Result := 0;
  end;

  function getAccountId(const AccountName: string): integer;
  begin
    QryAccounts.First;
    if qryAccounts.Locate('AccountName', AccountName, []) then Result := qryAccounts.FieldByName('AccountId').AsInteger
    else Result := 0;
  end;

  function getJobId(const JobName: string): integer;
  begin
    QryJobs.First;
    if QryJobs.Locate('JobName', JobName, []) then Result := QryJobs.FieldByName('ClientID').AsInteger
    else Result := 0;
  end;
  procedure SaveAndFreeBudget;
  begin
    Budget.Save;
    if Budget.BudgetSaved = false then ResultStatus.AddItem(false, rssWarning, 0,
        'Budget ' + Budget.BudgetDefinition.BudgetName +
        ' Period : ' + IntToStr(budget.budgetno) +
        ' not saved because ' + Budget.ResultStatus.Messages, false)
    else begin
      if (MissingAcct = false) and (MissingJob = false) then ResultStatus.AddItem(false, rssInfo, 0,
          'Budget :' + Budget.BudgetDefinition.BudgetName +
          ' Period : ' + IntToStr(budget.budgetno) + ' imported ok.', false)
      else ResultStatus.AddItem(false, rssInfo, 0,
          'Budget ' + Budget.BudgetDefinition.BudgetName +
          ' Period : ' + IntToStr(budget.budgetno) + ' imported - lines ignored because Accounts/Jobs were missing.', false);
    end;
    FreeAndNil(Budget);
  end;
begin
  LogExists := false;
  try
    Result := false;
    ResultStatus.IgnoreduplicateMsg := true;
    {Inherited does the validations like checking for the existance file to be imported etc.}
    if not inherited ImportData then Exit;

    TableName := 'tmp_Budget_Import' + GetTemporaryTableNameSuffix;

    LabelMsg.Caption := 'Please Wait Loading Data ..... 0%';
    LabelMsg.Visible := true;
    ProgressBar.Min := 0;
    ProgressBar.Max := LineCount;
    ProgressBar.Position := 0;
    Count       := LineCount;
    QryBudgets  := TERPQuery.Create(nil);
    QryBudgets.Options.FlatBuffers := True;
    QryAccounts := TERPQuery.Create(nil);
    QryAccounts.Options.FlatBuffers := True;
    Qryjobs     := TERPQuery.Create(nil);
    Qryjobs.Options.FlatBuffers := True;
    (*Budget := TBusObjBudget.Create(nil);*)
    with TERPQuery.Create(nil) do try
        Options.FlatBuffers := True;
        Connection := getsharedMydacConnection;
        QryBudgets.Connection := getsharedMydacConnection;
        QryAccounts.Connection := getsharedMydacConnection;
        QryJobs.Connection := getsharedMydacConnection;

        {lookup queries}
        QryBudgets.Sql.add('Select BudgetId, Name from tblBudgets');
        QryBudgets.Open;
        QryAccounts.SQL.add('Select AccountId , Accountname  from tblChartofAccounts ');
        QryAccounts.Open;
        QryJobs.SQL.add('select ClientID   , JobNumber  , JobName from tblclients where isJob = ''T'' ');
        QryJobs.Open;

        {heading }
        GetLineOfString;                 // to ignore the special note line
        HeadingString := GetLineOfString; // header line
        HeadingString := ReplaceStr(HeadingString, 'TBusObjBudgetImportExport' + #9, '');
        HeadingString := ReplaceStr(HeadingString, #39, '');
        HeadingString := ReplaceStr(HeadingString, #9, #39 + #44 + #39);
        HeadingString := #39 + HeadingString + #39;

        {create a temporary table,Header line is used to define the structure}
        CreateImportTable(HeadingString);
        SQL.add('Select * from ' + TableName + ' Order by Name , Period ');
        Open;
        {transfer data from tcd fiel into the temporary table to
        sort it on budget and period }
        for I := 2 to Count do begin // loop for all lines from the tcd file
          LineString := GetLineOfString;
          LineString := ReplaceStr(LineString, 'BUDGETINFO' + #9, '');
          LineString := ReplaceStr(LineString, #39, '');
          LineString := ReplaceStr(LineString, #9, #39 + #44 + #39);
          LineString := #39 + LineString + #39;
          if (Copy(Trim(uppercase(replacestr(LineString, '''', ''))), 1, 5) <> 'FINAL') and
            (Copy(Trim(uppercase(replacestr(LineString, '''', ''))), 1, 7) <> 'NOTE : ') and
            (Trim(replaceStr(LineString, '''', '')) <> '') then begin
            Insert;
            for ctr := 0 to FieldCounter(HeadingString) do begin
              FieldName := ReplaceStr(uppercase(StrExtStr(HeadingString, ',', ctr)), '''', '');
              FieldValue := ReplaceStr(StrExtStr(LineString, ',', ctr), '''', '');
              if FieldValue <> '' then begin
                if (FieldName = 'NAME') or (FieldName = 'DESCRIPTION') or
                  (FieldName = 'ACCOUNTNAME') or (FieldName = 'JOBNAME') then FieldByName(FieldName).AsString := FieldValue;
                if (FieldName = 'BUDGETSTARTDATE') or (FieldName = 'BUDGETENDDATE') or
                  (FieldName = 'ACTUALDATE') or (FieldName = 'PERIODSTART') or
                  (FieldName = 'PERIODEND') then FieldByName(FieldName).AsDateTime := MysqlDateStrToDate(FieldValue);
                if (FieldName = 'PERIODS') then FieldByName('Periods').AsInteger := PeriodValue(FieldValue);
                if (FieldName = 'PERIOD') then FieldByName('Period').AsInteger := FastFuncs.StrToInt(FieldValue);
                if IsAmtField(FieldNAme) then FieldByName(FieldName).AsFloat := StrToFloat(FieldValue);
              end;
            end;
            FieldByName('BudgetId').AsInteger := getBudgetId(FieldByName('Name').AsString);
            if FieldByName('BudgetId').AsInteger = 0 then begin
                        {only existing budgets periods can be imported. So filterout all the new budgets.
                        changes in the budget definition is ignored. }
              ResultStatus.AddItem(false, rssWarning, 0, 'Budget ' + FieldByName('Name').AsString +
                ' is not found in the system, the budget is ignored', false);
              Cancel;
            end else Post;
          end;
        end;

        if RecordCount = 0 then Exit;

        BudgetId := 0;
        Periods := 0;
        {close and open teh query to get the reocrds inthe order }
        Close;
        Open;
        First;
        while Eof = false do begin
          ProgressBar.Position := ProgressBar.Position + 1;
          {the object can handle one budget (all its periods) at a time}
          if (BudgetId <> FieldByName('BudgetID').AsInteger) or
            (Periods <> FieldByName('Period').AsInteger) then begin
            if Assigned(Budget) then begin
              SaveandFreeBudget;
            end;
            Budget := TBusObjBudget.Create(nil);
            BudgetID := FieldByName('BudgetId').AsInteger;
            Periods := FieldByName('Period').AsInteger;
            Budget.TableName := 'tmp_Budget' + GetTemporaryTableNameSuffix + '1';
            Budget.CommitOnSave := true;
            MissingAcct := false;
            MissingJob := false;

            {check whether the record already exists or not}
            if Budget.LoadBudget(BudgetId, Periods) then begin
              BudgetName := Budget.BudgetDefinition.BudgetName;
              Budget.OpenLines;
              Budget.FormLines.OwnerBudget := Budget;
              DeleteAll(Budget.FormLines.Dataset);
            end else begin
              Budget.New;
              Budget.OpenLines;
              Budget.FormLines.OwnerBudget := Budget;
              Budget.BudgetId := BudgetId;
              Budget.BudgetNo := Periods;
            end;

            Budget.FormLines.Dataset.Close;
            TERPQuery(Budget.FormLines.Dataset).SQL.Clear;
            TERPQuery(Budget.FormLines.Dataset).SQL.add('Select * from ' + Budget.TableName);
            TERPQuery(Budget.FormLines.Dataset).Open;
            for i := 0 to Budget.FormLines.Dataset.FieldCount - 1 do begin
              FieldName := Budget.FormLines.Dataset.Fields[i].fieldName;
              Budget.FormLines.Dataset.FindField(FieldName).ReadOnly := false;
            end;
          end else begin
            Budget.FormLines.Dataset.Insert;
            Budget.FormLines.Dataset.FieldByName('AccountID').AsInteger :=
              getAccountId(FieldByName('AccountNAme').AsString);
            if Budget.FormLines.Dataset.FieldByName('AccountID').AsInteger = 0 then begin
              ResultStatus.AddItem(false, rssWarning, 0, 'Budget ' + Budget.BudgetDefinition.BudgetName +
                ' Period : ' + IntToStr(budget.budgetno) + ' - Accountname ' +
                FieldByName('AccountName').AsString + ' is not found in the system, the line is ignored', false);
              MissingAcct := true;
              Budget.FormLines.Dataset.Cancel;
            end else begin
              Budget.FormLines.Dataset.FieldByName('JobId').AsInteger := GetJobId(FieldByName('JobName').AsString);
              if (Budget.FormLines.Dataset.FieldByName('JobId').AsInteger = 0) and
                (FieldByName('JobName').AsString <> '') then begin
                ResultStatus.AddItem(false, rssWarning, 0, 'Budget ' + Budget.BudgetDefinition.BudgetName +
                  ' Period : ' + IntToStr(budget.budgetno) + '- jobName' + FieldByName('JobName').AsString +
                  ' is not found in the system, the line is ignored', false);
                MissingJob := true;
                Budget.FormLines.Dataset.Cancel;
              end else begin
                Budget.FormLines.Dataset.FieldByName('AccountName').AsString := FieldByName('AccountName').AsString;
                Budget.FormLines.Dataset.FieldByName('JobName').AsString := FieldByName('JobName').AsString;
                Budget.FormLines.Dataset.FieldByName('ForDate').AsBoolean := FieldByName('ActualDate').AsDateTime <> 0;
                if FieldByName('ActualDate').AsDateTime <> 0 then
                  Budget.FormLines.Dataset.FieldByName('BudgetDate').AsDateTime := FieldByName('ActualDate').AsDateTime;
                for i := 0 to Fieldcount - 1 do {update amount fields}
                  if IsAmtField(Fields[i].FieldName) then if FieldByName(Fields[i].FieldName).AsFloat <> 0 then
                      Budget.FormLines.Dataset.FieldByName(Fields[i].FieldName).AsFloat := FieldByName(Fields[i].FieldName).AsFloat;
                Budget.FormLines.Postdb;
              end;
            end;
            Next;
          end;
        end;
        {Save the budget for the last group}
        if Assigned(Budget) then SaveandFreeBudget;

        ProgressBar.Position := ProgressBar.Max;

      finally
        if Active then Close;
        if QryBudgets.Active then QryBudgets.Close;
        if QryAccounts.Active then QryAccounts.Close;
        if QryJobs.Active then QryJobs.Close;
        if Assigned(Budget) then FreeandNil(Budget);
        Free;
        FreeandNil(QryBudgets);
        FreeandNil(QryAccounts);
        FreeandNil(QryJobs);
        CloseImportExportFile;
      end;
  finally
    Logexists := ResultStatus.Count > 0;
  end;
  Result := true;
end;


procedure TBusObjBudgetImportExport.DeleteAll(const dataset: TDataset);
begin
  Dataset.First;
  while Dataset.Eof = false do begin
    Dataset.Delete;
    Dataset.First;
  end;
  inherited;  
end;

procedure TBusObjBudgetImportExport.LoadSQL;
var
  Budget: TBusObjBudget;
  BudgetFormLines: TBusObjFormLines;
  Qry: TERPQuery;
  BudgetName: string;
  i: integer;
begin
    {Budget need a temporary table to be created because
    The records of the same classes should be displayed as columns not records}
  TableName := CreateExportTable;
  Qry := TERPQuery.Create(nil);
  Qry.Options.FlatBuffers := True;
  try
    Qry.Connection := GetSharedMyDacConnection;

    Qry.SQL.add('Select * from ' + TableName);
    Qry.Open;
    with TERPQuery.Create(nil) do try
        {loop for all butget periods}
        Options.FlatBuffers := True;
        Connection := GetSharedMyDacConnection;
        Sql.add('Select BudgetPeriodId from tblbudgetPeriods where Active = ''T'' and not  isnull(BudgetID)  ');
        Open;
        First;
        while Eof = false do begin
                {for each Period the object is populated which creates the
                temporary table and the data from the object's temporary table
                is moved into another local temporary table which should be
                deleted after export.}
          Budget := TBusObjBudget.Create(nil);
          BudgetFormLines :=TBusObjFormLines.Create(nil);
          try
            Budget.Load(FieldByName('BudgetPeriodId').AsInteger);
            Budget.TableName := 'tmp_Budget' + GetTemporaryTableNameSuffix;
            BudgetName := Budget.BudgetDefinition.BudgetName;
            BudgetFormLines.connection := budget.Connection;
            Budget.FormLines := BudgetFormLines;
            BudgetFormLines.TableName:= Budget.TableName;
            Budget.FormLines.OpenLines;
            Budget.OpenLines;
            Budget.FormLines.OwnerBudget := Budget;
            Budget.FormLines.First;
            while Budget.FormLines.Eof = false do begin
              Qry.Insert;
              Qry.FieldByName('Name').AsString := Budget.BudgetDefinition.BudgetName;
              Qry.FieldByName('Description').AsString := Budget.BudgetDefinition.Description;
              Qry.FieldByName('BudgetStartDate').AsDateTime := Budget.BudgetDefinition.StartDate;
              Qry.FieldByName('BudgetEndDate').AsDateTime := Budget.BudgetDefinition.EndDate;
              Qry.FieldByName('Periods').AsString := PeriodName(Budget.BudgetDefinition.IntervalPeriod);
              Qry.FieldByName('ActualDate').AsDateTime := Budget.FormLines.DataSet.FieldByName('BudgetDate').AsDateTime;
              Qry.FieldByName('Period').AsInteger := Budget.BudgetNo;
              Qry.FieldByName('PeriodStart').AsDateTime := Budget.StartDate;
              Qry.FieldByName('PeriodEnd').AsDateTime := Budget.EndDate;
              Qry.FieldByName('AccountName').AsString := Budget.FormLines.Dataset.FieldByName('AccountName').AsString;
              Qry.FieldByName('JobName').AsString := Budget.FormLines.Dataset.FieldByName('JobName').AsString;
              Qry.FieldByName('SortId').AsInteger := Budget.FormLines.Dataset.FieldByName('SortId').AsInteger;
              for I := 0 to Budget.formLines.DataSet.FieldCount - 1 do
                if IsAmtField(Budget.formLines.DataSet.Fields[i].FieldName) then
                  Qry.FieldByName(Budget.formLines.DataSet.Fields[i].FieldName).AsFloat :=
                    Budget.FormLines.Dataset.FieldByName(Budget.formLines.DataSet.Fields[i].FieldName).AsFloat;
              Qry.Post;
              Budget.FormLines.Next;
            end;
          finally
            with TERPQuery.Create(nil) do try
                Options.FlatBuffers := True;
                connection := getsharedMyDacConnection;
                SQL.add('Drop table if Exists ' + Budget.tableName);
                FreeandNil(Budget);
                Execute;
              finally
                Free;
              end;
          end;
          Next;
        end;
      finally
        if Active then Close;
        Free;
      end;
    Specialnote := 'Note : Changes made to budget information in the first 6 columns will be ignored while importing.';
    HeaderLine  := 'TBusObjBudgetImportExport';
    for i := 0 to Qry.Fieldcount - 1 do begin
      HeaderLine := HeaderLine + ',' + Qry.Fields[i].FieldName;
    end;
  finally
    if Qry.Active then Qry.Close;
    FreeAndNil(qry);
  end;

  FooterLine := 'FINALBUDGETINFO';
  with  IOQry do begin
    Connection := GetSharedMyDacConnection;
    SQL.add('Select * from ' + TableName);
    Open;
  end;
end;

function TBusObjBudgetImportExport.StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := HSrc + Delim;
  S := 1;
  for L9 := 1 to Count - 1 do begin
    S := FastFuncs.PosEx(Delim, Src);
    if S > 0 then Delete(Src, S, char_length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := FastFuncs.PosEx(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

function TBusObjBudgetImportExport.CreateImportTable(const FieldNames: string): string;
var
  i: integer;
begin
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := getSharedMyDacConnection;
      TableName := 'tmp_Budget_Import' + GetTemporaryTableNameSuffix;

      SQL.add('DROP Table if Exists ' + TableName);
      Execute;
      SQL.Clear;
      SQL.add('Create Table ' + TableName + '(');
      SQL.add('Name               varchar(100),');
      SQL.add('Description        VarChar(100),');
      SQL.add('BudgetStartDate	Date,');
      SQL.add('BudgetEndDate	    Date ,');
      SQL.add('Periods	        integer,');
      SQL.add('ActualDate	        Date ,');
      SQL.add('Period	            int,');
      SQL.add('PeriodStart	    Date,');
      SQL.add('PeriodEnd	        Date,');
      SQL.add('AccountName	    VarChar(100),');
      SQL.add('JobName            VarChar(100), ');
      SQL.add('SortId            Int(10), ');
      for I := 0 to FieldCounter(FieldNames) do if IsAmtField(ReplaceStr(StrExtStr(FieldNames, ',', I), '''', '')) then
          SQL.add('`' +ReplaceStr(StrExtStr(FieldNames, ',', I), '''', '') + '` Double, ');
      SQL.add('BudgetId   int ) ENGINE=InnoDB;');

      Execute;

      Result := TableName;
    finally
      if Active then Close;
      Free;
    end;
end;

function TBusObjBudgetImportExport.CreateExportTable: string;
var
  TableName: string;
  strSql: string;
begin
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := GetSharedMyDacConnection;
      TableName := 'tmp_Budget_Export' + GetTemporaryTableNameSuffix;
      Sql.add('Drop table if Exists ' + TableName);
      Execute;

      Sql.Clear;
      Sql.add('Select ClassId, ClassName from tblClass');
      Open;

      strSql := 'CREATE TABLE ' + TableName + ' (' + ' Name 				varchar(100),' +
        ' Description 	    varchar(100),' + ' BudgetStartDate   DateTime    ,' + ' BudgetEndDate		DateTime    ,' +
        ' Periods           varchar(20) ,' + ' Period            int         ,' + ' PeriodStart       dateTime    ,' +
        ' PeriodEnd         datetime    ,' + ' ActualDate        DateTime    ,' + ' AccountName       varchar(100),' +
        ' JobName           varchar(100), SortId int(10)';
      First;
      while Eof = false do begin
        strSql := strSql + ',' + '`' + FieldByName('ClassName').AsString + '_Amt1` Double';
        strSql := strSql + ',' + '`' + FieldByName('ClassName').AsString + '_Amt2` Double';
        Next;
      end;
      strSql := StrSql + ' ) ENGINE=MYISAM;';

      Close;
      SQL.Clear;
      SQL.add(strSql);
      Execute;
      Result := TableName;
    finally
      if Active then Close;
      Free;
    end;
end;

destructor TBusObjBudgetImportExport.Destroy;
begin
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := GetSharedMyDacConnection;
      if Trim(TableName) <> '' then begin
        SQL.add('Drop table if Exists ' + TableName);
        Execute;
      end;
    finally
      if Active then Close;
      Free;
    end;
  inherited;    
end;

initialization
  RegisterClassOnce(TBusObjBudgetImportExport);
end.
