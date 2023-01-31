unit BusObjAccountBudget;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 15/08/06  1.00.01 BJ   Dataset.... procedures are replaced with Do...Procs
                        The descendants should have Do....s which is called by Dataset.... which are
                        private in the busobjbase and
}
interface

uses MyAccess,ERPdbComponents, BusObjBase, busObjBudgetDef, Classes, ComCtrls,AdvOfficeStatusBar,db,
  BusObjGLAccount;
Function PrdDesc(stDate , edDate :TDateTime ):String;
Type
  TRefreshTotals = procedure of object;

  TBusObjAccountBudgetFormLines = Class(TMSBusObj)
  Private
    fpRefreshTotal      : TRefreshTotals;
    fiAccountID : Integer;
    fiBudgetDefId :Integer;
    fBudgetDef     : TBusObjBudgetDef;
    fsBudgetTableName :String;
    fQryClass :TERPQuery;
    fbChangingField :Boolean;
    fProgressBar: TProgressBar;
    Function FilterString :String;
    Function getBudgetDef:TBusObjbudgetDef;
    Procedure SetAccountId(Const Value :Integer);
    Procedure  SetBudgetDefId(Const Value :Integer);
    Procedure CreateBudgetTable;
    Procedure PopulateRecords;
    Function  getQryClass :TERPQuery;
    Function  IsAmtField(const FieldName: string): boolean;
    function AmtName(const FieldName: string): String;
    Function GetPeriodNo	        : Integer;
    Function GetPeriodId	        : Integer;
    Function GetPeriodDescription	: String;
    Function GetJobId	            : Integer;
    Function GetForDate	            : String;
    Function GetAllClass_Amt1	    : Double;
    Function GetAllClass_Amt2	    : Double;
    Function getStartDAte           : TDateTime ;
    Function getEndDAte             : TDateTime ;
    Function GetBudgetDate          : TDateTime ;
    Procedure setBudgetDate(Const Value           : TDateTime);
    Procedure SetPeriodNo(Const Value             : Integer);
    Procedure SetPeriodId(Const Value             : Integer);
    Procedure SetPeriodDescription	(Const Value  : String);
    Procedure SetJobId(Const Value                : Integer);
    Procedure SetForDate(Const Value              : String);
    Procedure SetAllClass_Amt1(Const Value        : Double);
    Procedure SetAllClass_Amt2(Const Value        : Double);
    Procedure SetFloatValue(const FieldName :String ; const Value :double);
    Procedure SetStartDAte(Const Value            :TDateTime);
    Procedure SetEndDAte(Const Value              :TDateTime);
    procedure CalcTotal;
    function  IsRecBlank    : boolean;
    function getProgressBar: TProgressBar;

  Protected
    Function DoAfterInsert(Sender :TDatasetBusObj ):Boolean;  Override;
    Function DoBeforePost(Sender :TDatasetBusObj ):Boolean;  Override;
    Procedure DoFieldOnChange(Sender: TField); override;
    Function DoAfterPost(Sender: TDatasetBusObj): boolean; override;
    Function DoAfterOpen(Sender :TDatasetBusObj ):Boolean;  override;
  Public
    class Function GetIDField: String; Override;
    class function GetBusObjectTablename: string; Override;
    procedure Load(const fIsReadonly:boolean =False); overload; Override;
    Property AccountID :Integer read fiAccountID write SetAccountId ;
    Property BudgetDefId:Integer read fibudgetDefId Write SetBudgetDefId;
    Property BudgetDef :TbusObjbudgetDef read getBudgetDef;
    Property BudgetTableName :String read fsBudgetTableName;
    Property QryClass :TERPQuery read getQryClass;
    property RefreshTotal: TRefreshTotals read fpRefreshTotal write fpRefreshTotal;
    property ProgressBar: TProgressBar read getProgressBar write fProgressBar;
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; Override;
    function  SaveRecs          : boolean;
    Procedure PopulateBudgetNos;
    Function GetClassName(const ClassId :Integer) :String;
    procedure CalcTotalAll;
    procedure SetLineFields;
  published
    Property PeriodNo           : Integer	Read GetPeriodNo	        Write setPeriodNo;
    Property StartDAte          : TDatetime Read getStartDAte           Write SetStartDAte;
    Property EndDAte            : TDatetime Read getEndDAte             Write SetEndDAte;
    Property PeriodId	        : Integer	Read GetPeriodId	        Write setPeriodId;
    Property PeriodDescription	: String	Read GetPeriodDescription	Write setPeriodDescription;
    Property JobId	            : Integer	Read GetJobId	            Write setJobId;
    Property BudgetDate         : TDateTime Read GetBudgetDate          Write setBudgetDate;
    Property ForDate	        : String	Read GetForDate	            Write setForDate;
    Property AllClass_Amt1	    : Double	Read GetAllClass_Amt1	    Write setAllClass_Amt1;
    Property AllClass_Amt2	    : Double	Read GetAllClass_Amt2	    Write setAllClass_Amt2;
  end;

  TBusObjAccountBudget = class(TMSBusObj)
  private
    fiAccountId :Integer;
    fibudgetDefId :Integer;
    fAccount : TAccount;
    fFormlines : TBusObjAccountBudgetFormLines;

    Function getAccount :TAccount;
    Procedure SetAccountId(Const Value :Integer);
    Procedure SetBudgetDefId(Const Value :Integer);
    Function getFormLines :TBusObjAccountBudgetFormLines;


  Public
    FooterTotals1: array of real;
    FooterTotals2: array of real;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    Property AccountID :Integer read fiAccountID write SetAccountId ;
    Property BudgetDefId:Integer read fibudgetDefId Write SetBudgetDefId;
    Property Account :TAccount read getAccount;
    Property FormLines :TBusObjAccountBudgetFormLines read getFormLines;

    Constructor Create(AOwner: TComponent); override;
    destructor Destroy; override; 
    procedure CalcTotal;
  Protected
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
  Public
    function  Save : boolean; Override;
  End;

implementation

uses FastFuncs,CommonDbLib, Sysutils, Variants, busObjBudget, DateUtils,
  MySQLConst, CommonLib;

class function TBusObjAccountBudget.GetIDField: string;
begin
    REsult := ''; {IDField missing}
end;
class function TBusObjAccountBudget.GetBusObjectTablename: string;
begin
    REsult := ''; {BusobectTablename missing}
end;

Constructor TBusObjAccountBudget.Create(AOwner: TComponent);
begin
    inherited create(Aowner);
    fiAccountId := 0;
    fibudgetDefId := 0;
    fAccount := nil;
end;
destructor TBusObjAccountBudget.Destroy;
begin
    if assigned(fFormlines) then FreeandNil(fFormlines);
    if assigned(fAccount) then FreeandNil(fAccount);

    inherited;
end;
procedure TBusObjAccountBudget.CalcTotal;
var
  Ctr: integer;
  bm: TBookMark;
  ClassName: string;
begin
  if not Assigned(fFormLines) then Exit;
  if not Assigned(fFormLines.budgetdef) then Exit;
  if not Assigned(fFormLines.budgetdef.BudgetClasses) then Exit;
  if fFormLines.budgetdef.BudgetClasses.Dataset.RecordCount = 0 then Exit;

  fFormLines.Dataset.DisableControls;
  bm := fFormLines.Dataset.GetBookmark;
  try
    fFormLines.Dataset.First;
    FooterTotals1 := nil;
    FooterTotals2 := nil;
    while fFormLines.Dataset.Eof = false do begin
      fFormLines.Budgetdef.BudgetClasses.Dataset.First;
      ctr := 0;
      while fFormLines.Budgetdef.BudgetClasses.Dataset.Eof = false do begin
        if fFormLines.Budgetdef.BudgetClasses.Dataset.FieldByName('active').AsBoolean then begin
          if High(FooterTotals1) < ctr then begin
            Setlength(FooterTotals1, ctr + 1);
            FooterTotals1[ctr] := 0;
          end;
          if High(FooterTotals2) < ctr then begin
            Setlength(FooterTotals2, ctr + 1);
            FooterTotals2[ctr] := 0;
          end;
          ClassName := getClassName(fFormLines.Budgetdef.BudgetClasses.Dataset.FieldByName('ClassId').AsInteger);
          if fFormLines.Dataset.FindField(ClassName + '_AMT1') <> nil then
            FooterTotals1[ctr] := FooterTotals1[ctr] + fFormLines.Dataset.FieldByName(ClassName + '_AMT1').AsFloat;
          if fFormLines.Dataset.FindField(ClassName + '_AMT2') <> nil then
            FooterTotals2[ctr] := FooterTotals2[ctr] + fFormLines.Dataset.FieldByName(ClassName + '_AMT2').AsFloat;
          ctr := ctr + 1;
        end;
        fFormLines.Budgetdef.BudgetClasses.Dataset.Next;
      end;
      if High(FooterTotals1) < ctr then begin
        Setlength(FooterTotals1, ctr + 1);
        FooterTotals1[ctr] := 0;
      end;
      if High(FooterTotals2) < ctr then begin
        Setlength(FooterTotals2, ctr + 1);
        FooterTotals2[ctr] := 0;
      end;
      if fFormLines.Dataset.FindField('AllClass_AMT1') <> nil then
        FooterTotals1[ctr] := FooterTotals1[ctr] + fFormLines.Dataset.FieldByName('AllClass_Amt1').AsFloat;
      if fFormLines.Dataset.FindField('AllClass_AMT2') <> nil then
        FooterTotals2[ctr] := FooterTotals2[ctr] + fFormLines.Dataset.FieldByName('AllClass_Amt2').AsFloat;
      fFormLines.Dataset.Next;
    end;
  finally
    fFormLines.Dataset.GotoBookmark(bm);
    fFormLines.Dataset.FreeBookmark(bm);
    fFormLines.Dataset.enableControls;
  end;
end;
Procedure TBusObjAccountBudget.SetBudgetDefID(Const Value :Integer);
begin
    fibudgetDefId := Value;
    if assigned(fFormlines) then Sysutils.FreeAndNil(fFormlines);
end;
Function TBusObjAccountBudget.getFormLines :TBusObjAccountBudgetFormLines;
begin
    if (fiAccountId = 0) or (fibudgetDefId = 0 ) then begin
        if Assigned(fFormLines) then Sysutils.FreeandNil(fFormLines);
        Result := nil;
        Exit;
    end;
    if not Assigned(fFormLines) then begin
        fFormlines := TBusObjAccountBudgetFormLines.Create(self);
        if Assigned(self.Connection) then fFormLines.connection := Self.connection;
        fFormLines.AccountId := fiAccountId;
        fformLines.budgetDefId := fiBudgetDefId;
        fformLines.Load;
    end;
    Result :=fformLines;
end;

Procedure TBusObjAccountBudget.SetAccountId(Const Value :Integer);
begin
    fiAccountID := Value;
    if Assigned(fAccount) then freeandNil(fAccount);
    if assigned(fFormlines) then FreeAndNil(fFormlines);
end;

Function TBusObjAccountBudget.GetAccount :TAccount;
begin
    if fiAccountId = 0 then begin
        if Assigned(fAccount) then freeandNil(fAccount);
        Result := nil;
        Exit;
    end;

    if not Assigned(fAccount) then begin
        fAccount := TAccount.Create(Self);
        if assigned(self.connection) then fAccount.Connection := Self.Connection;
        fAccount.Load(fiAccountID);
    End;
    Result := fAccount;
end;

Procedure TBusObjAccountBudget.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
    fiAccountId := 0;
    fibudgetDefId := 0;
    if Assigned(fAccount) then freeandNil(fAccount);
    if assigned(fFormlines) then FreeAndNil(fFormlines);
    inherited;
end;
function  TBusObjAccountBudget.Save          : boolean;
begin
    Connection.BeginTransaction;
    Result := FormLines.SaveRecs;
    if Result then Connection.CommitTransaction;
end;

procedure TBusObjAccountBudgetFormLines.Load(const fIsReadonly:boolean =False);
begin
    if fiAccountId = 0 then
        if fiBudgetdefId = 0 then Exit;

    fsBudgetTableName            := GetUserTemporaryTableName('Budgets');
    CreateBudgetTable;
    Self.SQL := 'Select * from ' +  fsBudgetTableName + ' Order by PeriodNo';
    inherited;//opens the recordset
    PopulateRecords;
    Self.Dataset.close;
    Self.dataset.Open;
end;
Function TBusObjAccountBudgetFormLines.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    inherited DoAfterInsert(Sender);
    REsult := True
end;
procedure TBusObjAccountBudgetFormLines.SetLineFields;
var
  ctr: integer;
begin
  with Dataset do begin
    if Dataset.Active then Dataset.Close;
    DatasetActive := true;
    {Set the display label of fields as the fields are created dynamically}
    for ctr := 0 to FieldCount - 1 do begin
      if uppercase(Copy(Fields[ctr].Fieldname, char_length(Fields[ctr].Fieldname) - 4, 5)) = '_AMT1' then begin
        TFloatField(Fields[ctr]).currency := true;
      end else if uppercase(Copy(Fields[ctr].Fieldname, char_length(Fields[ctr].Fieldname) - 4, 5)) = '_AMT2' then begin
        TFloatField(Fields[ctr]).currency := true;
      end;
    end;
    {hide ID fields}
    FindField('ID').Visible           := false;
    FindField('PEriodID').Visible    := false;
    FindField('JobID').Visible        := false;
    FindField('Active').Visible       := false;
    FindField('Jobname').Visible      := false;
    FindField('BudgetDate').DisplayWidth := 15;
    FindField('Jobname').DisplayWidth := 20;
    if FindField('AllClass_Amt1') <> nil then FindField('AllClass_Amt1').ReadOnly := true;
    if FindField('AllClass_Amt2') <> nil then FindField('AllClass_Amt2').ReadOnly := true;
  end;
end;

Function TBusObjAccountBudgetFormLines.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
    if PeriodNo = 0 then abort;
    Result := True;
end;

class Function TBusObjAccountBudgetFormLines.GetIDField :String ;
begin
    Result := 'ID';
end;

class function TBusObjAccountBudgetFormLines.GetBusObjectTablename: string;
begin
  Result := ''; //  fsBudgetTableName  ??
end;

function TBusObjAccountBudgetFormLines.DoAfterPost(Sender: TDatasetBusObj): boolean;
begin
  Result := true;
  if (Dataset.Eof) and (Dataset.Bof) then Exit;
  if IsRecBlank then Sender.Dataset.Delete;
  if Assigned(RefreshTotal) then RefreshTotal;
end;

Function TBusObjAccountBudgetFormLines.DoAfterOpen(Sender :TDatasetBusObj ):Boolean;
begin
    Inherited DoAfterOpen(Sender );
    Result := true;
end;

function TBusObjAccountBudgetFormLines.IsRecBlank: boolean;
var
  ctr: integer;
begin
  Result := true;
  with Dataset do begin
    if FieldByName('PeriodNo').AsInteger <> 0 then Result := false;
    if Result = false then Exit;
    for ctr := 0 to FieldCount - 1 do if IsAmtField(Fields[ctr].Fieldname) then
        if FieldByName(Fields[ctr].Fieldname).AsFloat <> 0 then Result := false;
  end;
end;
function TBusObjAccountBudgetFormLines.getProgressBar: TProgressBar;
begin
  if not Assigned(fProgressBar) then
  fProgressBar := TProgressBar.Create(nil);
  Result := fProgressBar;
end;

Procedure TBusObjAccountBudgetFormLines.DoFieldOnChange(Sender: TField);
    Function PeriodUnique :Boolean;
    begin
      with TERPQuery.Create(nil) do try
          Options.FlatBuffers := True;
          Connection := Self.Connection.Connection;
          SQL.add('Select * from ' + fsBudgetTableName);
          SQL.add(' where PeriodNo = ' + IntToStr(PeriodNo));
          if JObID <> 0 then
            SQL.add(' and  JobId = ' + IntToStr(JObID));
          SQL.add(' and  forDate = ' + quotedStr(ForDate));
          if budgetDAte <> 0 then
            SQL.add(' and  BudgetDAte = ' + QuotedStr(FormatDateTime(MysqlDateFormat, budgetDate)));
          SQL.add(' and  Id <> ' + IntToStr(ID));
          Open;
          REsult := REcordCount = 0;
      Finally
        if Active then close;
        Free;
      end;
    end;

    Function NextDate:TDateTime ;
    var
      Dt: TDateTime;
      dtFound: boolean;
    begin
      with TERPQuery.Create(nil) do try
          Options.FlatBuffers := True;
          Connection := Self.Connection.Connection;
          SQL.add('Select BudgetDate from ' + fsBudgetTableName);
          SQL.add(' where PeriodNo = ' + IntToStr(PeriodNo));
          if JObID <> 0 then SQL.add(' and  JobId = ' + IntToStr(JObID));
          SQL.add(' and  Id <> ' + IntToStr(ID));
          SQL.add(' and ForDate = ''T'' Order by BudgetDate');
          Open;
          dt := Self.StartDate;
          while dt <= Self.EndDate do begin
            First;
            dtFound := false;
            while Eof = false do begin
              if FieldByName('BudgetDate').AsDateTime = dt then begin
                Last;
                dt := incDay(dt, 1);
                dtFound := true;
              end else Next;
            end;
                if not dtFound then begin
              Result := dt;
              Exit;
            end;
            incDay(dt, 1);
          end;
          Result := 0;
        finally
          if Active then Close;
          Free;
        end;
    end;
    Function DateValid :Boolean;
    begin
        Result :=  (BudgetDate = 0 ) or ((BudgetDate >= StartDate) and (BudgetDate <= endDate));
    end;
begin
    if fbChangingField then Exit;
    fbChangingField := True;
    Try
        if (uppercase(Sender.FieldName) = uppercase('PeriodNo')) then begin
            StartDate := BudgetDef.BudgetNos.FindItem(Sender.Value).StartDate;
            EndDate := BudgetDef.BudgetNos.FindItem(Sender.Value).EndDate;
        end else if (uppercase(Sender.FieldName) = uppercase('BudgetDate'))  then begin
            if ForDate = 'F' then ForDate := 'T';
            if not DateValid then
                if  nextDate = 0 then Dataset.Cancel
                else    BudgetDate := nextDate;
            if budgetDAte = 0 then ForDate := 'F';
        end;
        if (uppercase(Sender.FieldName) = uppercase('ForDate')) then
            if ForDate <> 'T' then
                BudgetDAte := 0
            else
                if BudgetDate = 0 then BudgetDate := nextDate;

        if (uppercase(Sender.FieldName) = uppercase('PeriodDescription')) or
            (uppercase(Sender.FieldName) = uppercase('PeriodNo')) or
            (uppercase(Sender.FieldName) = uppercase('ForDate')) or
            (uppercase(Sender.FieldName) = uppercase('BudgetDate')) or
            (uppercase(Sender.FieldName) = uppercase('JobName')) then begin
            if PeriodUnique then Exit;  
            Fordate := 'T';
            if  nextDate = 0 then Dataset.Cancel
            else    BudgetDate := nextDate;
        end;
        if IsAmtfield(Sender.FieldName) then CalcTotal;

    Finally
        fbChangingField := false;
    end;

end;
Function  TBusObjAccountBudgetFormLines.getQryClass :TERPQuery;
begin
    if not assigned(fQryClass) then begin
        fQryClass := TERPQuery.Create(nil);
        fQryClass.Options.FlatBuffers := True;
        fQryClass.Connection := GetSharedMyDacConnection;
        fQryClass.SQL.add( 'Select * from tblclass');
        fQryClass.Open;
    end;
    Result :=fQryClass;
end;
Function TBusObjAccountBudgetFormLines.GetClassName(Const ClassId :Integer) :String;
begin
    Result := '';
    if QryClass.Locate('ClassId' , ClassId , []) then Result := qryClass.FieldByname('ClasSName').asString;
end;
Procedure TBusObjAccountBudgetFormLines.PopulateRecords;
var
    Qry :TERPQuery;
begin
    fbChangingField := True;
    Qry := TERPQuery.Create(self);
    Qry.Options.FlatBuffers := True;
    Try
        Qry.Connection := GetSharedMyDacConnection;
        Qry.SQL.add('Select distinct Periods.BudgetPeriodID, Periods.BudgetNo, Periods.StartDate , Periods.EndDate , ');
        Qry.SQL.add('concat( DATE_FORMAT(Periods.StartDate, "%d-%m-%Y") , " TO " , DATE_FORMAT(Periods.EndDate, "%d-%m-%Y") )  as PeriodDesc, ');
        Qry.SQL.add('PeriodLines.JobId,  PeriodLines.Budgetdate, PeriodLines.ForDate , PeriodLines.ClassId, Amount1, Amount2 ');
        Qry.SQL.add('from tblbudgetPeriods Periods ');
        Qry.SQL.add('inner join  tblbudgetperiodlines PeriodLines on Periods.BudgetPeriodId = PeriodLines.BudgetperiodId ');
        Qry.SQL.add('where  Periods.BudgetId = ' + IntToStr(fiBudgetDefID));
        Qry.SQL.add('and PeriodLines.AccountId  = ' + IntToStr(fiAccountID) );
        Qry.open;
        if Qry.RecordCount > 0 then begin
            Qry.first;
            While Qry.Eof = False do begin
                if Self.Dataset.Locate('PeriodId;JobId;ForDate;BudgetDate' ,
                        vararrayOf([Qry.fieldByname('BudgetPeriodID').asInteger ,
                                    Qry.fieldByname('JobId').asInteger ,
                                    Qry.fieldByname('ForDate').asString,
                                    Qry.fINDFIELD('BudgetDAte').asDateTime]), []) = False then begin
                    Self.New;
                    Self.PeriodId :=Qry.fieldByname('BudgetPeriodID').asInteger ;
                    Self.PeriodNo :=Qry.fieldByname('BudgetNo').asInteger;
                    Self.JobId :=Qry.fieldByname('JobId').asInteger ;
                    Self.ForDate :=Qry.fieldByname('ForDate').AsString ;
                    Self.BudgetDate :=Qry.fieldByname('BudgetDAte').asDatetime ;
                    Self.StartDAte := Qry.FieldByname('StartDate').asDateTime;
                    Self.EndDAte := Qry.FieldByname('EndDate').asDateTime;
                    Self.PeriodDescription :=Qry.fieldByname('PeriodDesc').AsString ;
                end;
                if Qry.fieldByname('Amount1').asFloat <> 0 then
                    Self.SetFloatValue(getclassName(Qry.fieldByname('ClassId').asInteger)+'_Amt1' , Qry.fieldByname('Amount1').asFloat);
                if Qry.fieldByname('Amount2').asFloat <> 0 then
                    Self.SetFloatValue(getclassName(Qry.fieldByname('ClassId').asInteger)+'_Amt2' , Qry.fieldByname('Amount2').asFloat);
                Self.Save;
                Qry.Next;
            end;
        end;
    finally
        if Qry.Active then Qry.close;
        FreeandNil(Qry);
        fbChangingField := False;
        Dataset.First;
    end;

end;

Procedure TBusObjAccountBudgetFormLines.PopulateBudgetNos;
var
    i :Integer;
begin
    fbChangingField := True;
    Try
        if not Self.Budgetdef.BudgetNos.IsEmpty then
            ProgressBar.Max := Self.Budgetdef.BudgetNos.Count+1
        else ProgressBar.Max := 1;
        ProgressBar.Position := 1;
        if not Self.Budgetdef.BudgetNos.IsEmpty then
        For i := 0 to Self.Budgetdef.BudgetNos.Count - 1 do begin
            ProgressBar.StepIt;
            if not Self.Dataset.locate('PeriodNo' ,Self.Budgetdef.BudgetNos[i].BudgetNo , []) then begin
                Self.New;
                Self.PeriodNo :=Self.Budgetdef.BudgetNos[i].BudgetNo;
                Self.StartDate := Self.Budgetdef.BudgetNos[i].StartDate;
                Self.EndDate := Self.Budgetdef.BudgetNos[i].EndDate;
                Self.PeriodDescription :=PrdDesc(Self.Budgetdef.BudgetNos[i].StartDate ,
                    Self.Budgetdef.BudgetNos[i].EndDate);
                Self.Save;
            end;
        end;
    Finally
        fbChangingField := False;
        if Assigned(RefreshTotal) then RefreshTotal;
    end;
end;

Procedure TBusObjAccountBudgetFormLines.CreateBudgetTable;
var
    Qry :TERPQuery;
    strClassName:String;

begin
    Qry := TERPQuery.Create(self);
    Qry.Options.FlatBuffers := True;
    Try
        Qry.Connection := GetSharedMyDacConnection;
        Qry.SQL.add('Drop table if exists ' + fsBudgetTableName);
        Qry.Execute;

        Qry.SQL.clear;
        Qry.SQL.add('CREATE TABLE ' + fsBudgetTableName);
        Qry.SQL.add('(ID INT AUTO_INCREMENT, ');
        Qry.SQL.add('PeriodNo INT,  ');
        Qry.SQL.add('PeriodID INT,  ');
        Qry.SQL.add('StartDate DateTime,  ');
        Qry.SQL.add('EndDate Datetime,  ');
        Qry.SQL.add('BudgetDate Datetime,  ');
        Qry.SQL.add('PeriodDescription VARCHAR (50),  ');
        Qry.SQL.add('JobId INT,  ');
        Qry.SQL.add('JobName varchar(50),  ');
        Qry.SQL.add('ForDate ENUM (''T'',''F'') DEFAULT ''F'',  ');
        BudgetDef.BudgetClasses.Dataset.First;
        BudgetDef.BudgetClasses.Dataset.filter := 'Active = ''T'' ';
        BudgetDef.BudgetClasses.Dataset.Filtered := True;
        while BudgetDef.BudgetClasses.Dataset.Eof = false do begin
            strClassName := getClassName(BudgetDef.BudgetClasses.Dataset.FieldByName('ClassID').AsInteger);
            Qry.SQL.add('`' + Trim(strClassName) + '_amt1` double, ');
            Qry.SQL.add('`' + Trim(strClassName) + '_amt2` double,');
            Budgetdef.BudgetClasses.Dataset.Next;
        end;
        Qry.SQL.add('`AllClass_Amt1` double,');
        Qry.SQL.add('`AllClass_Amt2` double,');
        Qry.SQL.add('Active varchar(1),');
        Qry.SQL.add('PRIMARY KEY(ID))  TYPE = MyISAM');
        Qry.Execute;

    finally
        if Qry.Active then close;
        FreeandNil(Qry)
    end;
end;

Function TBusObjAccountBudgetFormLines.FilterString :String;
var
    strClassName :String;
begin
    Result := '';
    BudgetDef.BudgetClasses.Dataset.first;
    BudgetDef.BudgetClasses.Dataset.filter := 'Active = ''T'' ';
    BudgetDef.BudgetClasses.Dataset.Filtered := True;
    while BudgetDef.BudgetClasses.Dataset.Eof = false do begin
        strClassName := getclassName(BudgetDef.BudgetClasses.Dataset.FieldByName('ClassId').asInteger);
        if REsult <> '' then Result := Result +' OR ';
        Result := Result + '([' + strClassName + '_amt1] <> 0  and [' + strClassName + '_amt1] <> null ) ';
        Result := Result +' OR ';
        Result := Result + '([' + strClassName + '_amt1] <> 0  and [' + strClassName + '_amt1] <> null ) ';
        Budgetdef.BudgetClasses.Dataset.Next;
    end;
end;

Function TBusObjAccountBudgetFormLines.getBudgetDef:TBusObjbudgetDef;
begin
    if fiBudgetDefId = 0 then begin
        if Assigned(fbudgetDef) then FreeandNil(fBudgetDEf);
        Result := nil;
        Exit;
    end;
    if not Assigned(fBudGetDef) then begin
        fBudgetDef := TBusObjBudgetDef.Create(Self);
        if assigned(self.connection) then fBudgetDef.Connection := Self.Connection;
        fBudgetDef.Load(fibudgetDefId);
    end;
    Result := fBudgetDef;
end;
Procedure TBusObjAccountBudgetFormLines.SetBudgetDefID(Const Value :Integer);
begin
    fibudgetDefId := Value;
    if Assigned(fBudgetDef) then FreeandNil(fBudgetDef);
    if Assigned(fQryClass) then begin
        if fQryClass.active then fQryClass.Close;
        FreeandNil(fQryClass);
    end;
end;

Procedure TBusObjAccountBudgetFormLines.SetAccountId(Const Value :Integer);
begin
    fiAccountID := Value;
end;
Destructor TBusObjAccountBudgetFormLines.Destroy;
begin
    if assigned(fBudgetDef) then freeandNil(fBudgetDef);
    inherited;
end;
Constructor TBusObjAccountBudgetFormLines.Create(AOwner: TComponent);
begin
    inherited create(Aowner);
    fiAccountId         := 0;
    fibudgetDefId       := 0;
    fsBudgetTableName   := '';
    fBudgetDef          := nil;
    fbChangingField     := False;
    if Assigned(fQryClass) then begin
        if fQryClass.Active then fQryClass.Close;
        fQryClass           := nil;
    end;
end;

function TBusObjAccountBudgetFormLines.SaveRecs: boolean;
var
  QrySQL                : TERPQuery;
  BudgetPeriod          : TBusObjBudget;
  ctr                   : integer;
  AmtFields             : array of array of String ;
  FieldFound            : Boolean;
  Col                   : Integer;
  tblBudgetLines        : TStringList;
  tblbudgetperiodlines  : TStringList;
  strSQl                : String;
  Classes               : Array of String;
  ClassID               : Array of Integer;
  noOfDays              : Integer;
  dStartDate            : TDateTime;
  dEndDate              : TDateTime;
  FieldCtr              : Integer;
  FirstREc              : boolean;

    Procedure  LoadClassArray;
        var arrayLoop :Integer;
    begin
        qryclass.first;
        arrayLoop := 0;
        while qryclass.eof = False do begin
            arrayLoop := arrayLoop+1;
            Setlength(Classes, arrayLoop);
            Setlength(ClassID, arrayLoop);
            Classes[arrayLoop-1] :=qryclass.FieldByname('ClassName').asString;
            ClassID[arrayLoop-1] :=qryclass.FieldByname('ClassID').asInteger;
            qryclass.Next;
        end;
    end;

    function GetClassID(Const FieldName: string): integer;
    var
       arrayLoop :Integer;
       tmpFieldName: string;
    begin
        REsult := 0;
        tmpFieldName := Copy(FieldName, 1, char_length(fieldName) - 5);
        For arrayLoop := Low(classes) to high(Classes) do
            if classes[arrayLoop] = tmpFieldName then begin
                Result := ClassId[arrayLoop];
                Exit;
            End;
    end;

begin
    tblBudgetLines:=TStringList.Create;
    tblbudgetperiodlines:=TStringList.Create;
    qrySQL := TERPQuery.Create(Self);
    qrySQL.Options.FlatBuffers := True;
    try
        qrySQL.Connection := Self.Connection.Connection;
        qrySQL.SQL.add('Delete from tblBudgetPeriodLines ');
        qrySQL.SQL.add('where BudgetId = ');
        qrySQL.SQL.add(IntToStr(fibudgetDefID));
        qrySQL.SQL.add('And AccountID = ');
        qrySQL.SQL.add(IntToStr(fiAccountId));
        qrySQL.Execute;
        qrySQL.SQL.Clear;

        qrySQL.SQL.add('Delete from tblBudgetLines ');
        qrySQL.SQL.add('where BudgetId = ');
        qrySQL.SQL.add(IntToStr(fibudgetDefID));
        qrySQL.SQL.add('And AccountID = ');
        qrySQL.SQL.add(IntToStr(fiAccountId));
        qrySQL.Execute;
        qrySQL.SQL.Clear;

        Self.Dataset.Filter := FilterString;
        Self.Dataset.Filtered := True;
        Self.Dataset.First;

        LoadClassArray;
        with Dataset do begin
            First;
            Setlength(AmtFields , 2);
            Col := 0;
            for FieldCtr := 0 to FieldCount - 1 do begin
                if IsAmtField(Fields[FieldCtr].Fieldname) then begin
                    FieldFound := False;
                    for ctr := low(AmtFields[0]) to high(AmtFields[0]) do
                        if FastFuncs.PosEx(AmtName(Fields[FieldCtr].Fieldname) , AmtFields[0,ctr]) <> 0 then begin
                            AmtFields[1,ctr] :=Fields[FieldCtr].Fieldname;
                            FieldFound:= True;
                        end;
                    if FieldFound = False then begin
                        Col := Col +1;
                        Setlength(AmtFields[0] , col);
                        Setlength(AmtFields[1] , col);
                        AmtFields[0,Col-1] := '';
                        AmtFields[1,Col-1] := '';
                        AmtFields[0,Col-1] :=Fields[FieldCtr].Fieldname;
                    end;
                 end;
            end;
            tblBudgetLines.add('INSERT HIGH_PRIORITY INTO tblBudgetLines (ClassId,AccountId, JobId, Date, BudgetId, BudgetPeriodID, Fordate, Conservative, Aggressive, Active)  values ');
            tblbudgetperiodlines.add('INSERT HIGH_PRIORITY INTO tblbudgetperiodlines (BudgetPeriodId, BudgetID, ClassId,AccountId, jobID, ForDate, BudgetDate, Amount1, Amount2, Active) Values');
            FirstREc := True;

            if Assigned(fProgressBar) then begin
                fProgressBar.Max := Self.Dataset.RecordCount;
                fProgressBar.Min := 1;
                fProgressBar.Position := 0;
            end;

            while Self.Dataset.Eof = false do begin
                if Assigned(fProgressBar) then fProgressBar.StepIt;
                BudgetPeriod := TBusObjBudget.Create(Self);
                BudgetPeriod.Connection := self.Connection;
                BudgetPeriod.CommitOnSave := False;
                Try
                    BudgetPeriod.LoadSelect('BudgetNo = ' + IntToStr(PeriodNo) + ' and BudgetId = ' + IntToStr(fiBudgetDefId));
                    if BudgetPeriod.Dataset.recordcount = 0 then begin
                        BudgetPeriod.New;
                        BudgetPeriod.BudgetId := fibudgetDefID;
                        BudgetPeriod.BudgetDate := DateOf(Now);
                        BudgetPeriod.BudgetNo := PeriodNo;
                        BudgetPeriod.StartDate := StartDate;
                        BudgetPeriod.EndDate := EndDate;
                        BudgetPeriod.Save;
                    end;
                    if PeriodId <> BudgetPeriod.ID then begin
                        PeriodId := BudgetPeriod.ID;
                        Save;
                    end;

                    for ctr := low(AmtFields[0]) to high(AmtFields[0]) do begin
                        strSql := '(' + IntToStr(PeriodId) +  ',' +
                                    IntToStr(fiBudgetdefID) + ',' +
                                    IntToStr(GetClassID(AmtFields[0,ctr])) +',' +
                                    IntToStr(fiAccountId) +',' +
                                    IntToStr(Dataset.FieldByName('JobId').AsInteger) +',' +
                                    quotedStr(Dataset.FieldByName('ForDate').asString)  ;
                        if FieldByName('ForDate').asString = 'F' then
                            strSql := strSql + ',null'
                        else strSql := strSql + ',' + quotedStr(FormatDatetime(MysqlDateFormat , Dataset.FieldByName('BudgetDate').AsDateTime));
                        if AmtFields[0,ctr] <> '' then
                                strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[0,ctr]).AsFloat )
                        else strSql := strSql + ',0';
                        if AmtFields[1,ctr] <> '' then
                                strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[1,ctr]).AsFloat )
                        else strSql := strSql + ',0';
                        strSql := strSql + ',' + QuotedStr('T') +')';
                        if (not FirstREc) or (ctr<> 0) then tblbudgetperiodlines.add(',');
                        tblbudgetperiodlines.add(strSQL);
                    end;

                    if Dataset.fieldbyname('Fordate').asBoolean then begin
                        dStartDate :=FieldByName('budgetDate').AsDateTime;
                        dEndDate :=FieldByName('budgetDate').AsDateTime;
                    end else begin
                        dStartDate :=DateOf(BudgetPeriod.StartDAte);
                        dEndDate :=DateOf(BudgetPeriod.EndDate);
                    end;
                    noOfDays := DaysBetween( DateOf(dStartDate) , DateOf(dEndDate) ) + 1;

                    while dStartDate <= dEndDate do begin
                        for ctr := low(AmtFields[0]) to high(AmtFields[0]) do begin
                            StrSQl := '('+ IntToStr(GetClassID(AmtFields[0,ctr])) + ',' +
                                       IntToStr(fiAccountId) +',' +
                                       IntToStr(Dataset.FieldByName('JobId').AsInteger) +',' +
                                       QuotedStr(FormatDateTime(MysqlDateFormat , dStartDate)) +',' +
                                       IntToStr(fiBudgetDefID) +',' +
                                       IntToStr(PeriodId) + ',' +
                                       QuotedStr(Dataset.FieldByname('ForDate').asString);
                            if AmtFields[0,ctr] <> '' then begin
                                    strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[0,ctr]).AsFloat / noOfDays);
                            end else strSql := strSql + ',0';

                            if AmtFields[1,ctr] <> '' then begin
                                    strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[1,ctr]).AsFloat / noOfDays);
                            end else strSql := strSql + ',0';

                            strSql := strSql + ',' + QuotedStr('T') +')';
                            if (not FirstREc) or (ctr<> 0) then tblBudgetLines.add(',');
                            tblBudgetLines.add(strSQL);
                            FirstREc:= False;
                        end;
                        dStartDate := incDay(dStartDate);
                    end;
                Finally
                    FreeandNil(BudgetPeriod);
                End;
                Next;
            end;
            qrySQL.SQL.clear;
            qrySQL.SQL.Text := tblBudgetLines.Text;
            qrySQL.Execute;
            qrySQL.SQL.clear;
            qrySQL.SQL.text := tblbudgetperiodlines.text;
            qrySQL.Execute;
        end;
        Result := true;
    finally
        FreeandNil(qrySQL);
        if Assigned(budgetPeriod)       then FreeandNil(budgetPeriod);
        if Assigned(tblBudgetLines)       then FreeandNil(tblBudgetLines);
        if Assigned(tblbudgetperiodlines)       then FreeandNil(tblbudgetperiodlines);

    end;
end;

Function TBusObjAccountBudgetFormLines.GetPeriodNo	        : Integer;
begin
    Result := getIntegerField('PeriodNo');
end;
Function TBusObjAccountBudgetFormLines.GetPeriodId	        : Integer;
begin
    Result := getIntegerField('PeriodId');
end;
Function TBusObjAccountBudgetFormLines.GetPeriodDescription	: String;
begin
    Result := getStringField('PeriodDescription');
end;
Function TBusObjAccountBudgetFormLines.GetJobId	            : Integer;
begin
    Result := getIntegerField('JobId');
end;
Function TBusObjAccountBudgetFormLines.GetForDate	            : String;
begin
    Result := getStringField('ForDate');
    if Result = '' then Result := 'F' ;
end;
Function TBusObjAccountBudgetFormLines.GetAllClass_Amt1	    : Double;
begin
    Result := getFloatField('AllClass_Amt1');
end;
Function TBusObjAccountBudgetFormLines.GetAllClass_Amt2	    : Double;
begin
    Result := getFloatField('AllClass_Amt2');
end;
Function TBusObjAccountBudgetFormLines.getStartDAte           : TDateTime ;
begin
    Result := getDateTimefield('StartDAte');
end;
Function TBusObjAccountBudgetFormLines.getEndDAte             : TDateTime ;
begin
    Result := getDateTimefield('EndDate');
end;
Function TBusObjAccountBudgetFormLines.GetBudgetDate          : TDateTime ;
begin
    Result := getDateTimefield('BudgetDate');
end;

Procedure TBusObjAccountBudgetFormLines.setBudgetDate(Const Value           : TDateTime);
begin
    SetDatetimeField('BudgetDate', Value);
end;

Procedure  TBusObjAccountBudgetFormLines.SetPeriodNo(Const Value             : Integer);
begin
    SetIntegerField('PeriodNo', Value);
end;
Procedure  TBusObjAccountBudgetFormLines.SetPeriodId(Const Value             : Integer);
begin
    SetIntegerField('PeriodId', Value);
end;
Procedure  TBusObjAccountBudgetFormLines.SetPeriodDescription(Const Value    : String);
begin
    SetStringField('PeriodDescription', Value);
end;
Procedure  TBusObjAccountBudgetFormLines.SetJobId(Const Value                : Integer);
begin
    SetIntegerField('JobId', Value);
end;
Procedure  TBusObjAccountBudgetFormLines.SetForDate(Const Value              : String);
begin
    SetStringField('ForDate', Value);
end;
Procedure  TBusObjAccountBudgetFormLines.SetAllClass_Amt1(Const Value        : Double);
begin
    SetFloatField('AllClass_Amt1', Value);
end;
Procedure  TBusObjAccountBudgetFormLines.SetAllClass_Amt2(Const Value        : Double);
begin
    SetFloatField('AllClass_Amt2', Value);
end;
Procedure TBusObjAccountBudgetFormLines.SetFloatValue(Const FieldName :String; Const Value :double);
begin
    SetFloatField(FieldName, Value);
end;
Procedure TBusObjAccountBudgetFormLines.SetStartDAte(Const Value            :TDateTime);
begin
    SetDateTimeField('StartDAte', Value);
end;
Procedure TBusObjAccountBudgetFormLines.SetEndDAte(Const Value              :TDateTime);
begin
    SetDateTimeField('EndDate', Value);
end;
procedure TBusObjAccountBudgetFormLines.CalcTotalAll;
begin
    ProgressBar.Max := Dataset.RecordCount;
    ProgressBar.Position := 1;
    Dataset.First;
    while Dataset.eof = False do begin
        ProgressBar.StepIt;
        CalcTotal;
        Dataset.next;
    end;
end;

function TBusObjAccountBudgetFormLines.IsAmtField(Const FieldName: string): boolean;
begin
  Result := false;
  if uppercase(Copy(FieldName, char_length(fieldName) - 4, 4)) = '_AMT' then
    if uppercase(Copy(FieldName, 1, 12)) <> 'ALLCLASS_AMT' then Result := true;
end;

function TBusObjAccountBudgetFormLines.AmtName(Const FieldName: string): String;
begin
  Result := Copy(FieldName , 1 , char_length(FieldName)-1);
end;

procedure TBusObjAccountBudgetFormLines.CalcTotal;
var
  Amt1, amt2: double;
  ctr: integer;
begin
  if not DatasetAssigned then Exit;

  if Dataset.RecordCount = 0 then if Dataset.State <> dsInsert then Exit;
  amt1 := 0;
  amt2 := 0;
  with Dataset do begin
    for ctr := 0 to FieldCount - 1 do begin
      if uppercase(Copy(Fields[ctr].Fieldname, char_length(Fields[ctr].Fieldname) - 4, 5)) = '_AMT1' then
        if uppercase(Copy(Fields[ctr].Fieldname, 1, 12)) <> uppercase('Allclass_amt') then
          Amt1 := amt1 + FieldByName(Fields[ctr].Fieldname).AsFloat;
      if uppercase(Copy(Fields[ctr].Fieldname, char_length(Fields[ctr].Fieldname) - 4, 5)) = '_AMT2' then
        if uppercase(Copy(Fields[ctr].Fieldname, 1, 12)) <> uppercase('Allclass_amt') then
          Amt2 := amt2 + FieldByName(Fields[ctr].Fieldname).AsFloat;
    end;
    if State in [dsEdit, dsInsert] then else Edit;
    if FindField('AllClass_Amt1') <> nil then FindField('AllClass_Amt1').ReadOnly := false;
    if Amt1 = 0 then        FindField('AllClass_Amt1').AsVariant := null
    else    if FindField('AllClass_Amt1') <> nil then FieldByName('AllClass_Amt1').AsFloat := Amt1;
    if FindField('AllClass_Amt1') <> nil then FindField('AllClass_Amt1').ReadOnly := true;

    if FindField('AllClass_Amt2') <> nil then FindField('AllClass_Amt2').ReadOnly := false;
    if Amt2 = 0 then        FindField('AllClass_Amt2').AsVariant := null
    else    if FindField('AllClass_Amt2') <> nil then FieldByName('AllClass_Amt2').AsFloat := Amt2;
    if FindField('AllClass_Amt2') <> nil then FindField('AllClass_Amt2').ReadOnly := true;
    if State in [dsEdit, dsInsert] then Post;
  end;
end;
Function PrdDesc(stDate , edDate :TDateTime ):String;
begin
    Result := FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat , StDate ) + ' TO ' + FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat , edDate);
end;

end.
