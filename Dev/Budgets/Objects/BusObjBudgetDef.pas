{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/10/05  1.00.00 BJ  Initial version.
}

unit BusObjBudgetDef;

interface

uses
  BusObjBase, Classes, db, MyAccess,ERPdbComponents,BudgetCommonUtils, dialogs;

type
  TBusObjBudgetClasses= class(TBusobj)
  Private
  Public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
  Protected
    function GetId: integer; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
  End;

  TBusObjBudgetDef = class(TMSBusObj)
  private
    fbBudgetClasses : TBusObj;
    fbIsUSed        : boolean;
    fdFirstDateUSed : TDateTime;
    fdLastDateUsed  : TDateTime;
    InvalidMsg      : string;
    fbBudgetSaved   : boolean;
    foBudgetNos     : TBudgetNos;
    fbCommitOnSave  : boolean;
    fiNewAccountId  : Integer;
    fbAccountAdded  : Boolean;
    fSelectedAccounts:TERPQuery;
    fsTmpTableName  : String;
    procedure SetBudgetClasses(const Value: TBusObj);
    function getBudgetClasses: TBusObj;
    procedure SetBudgetName(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetAmount1Label(const Value: string);
    procedure SetAmount2Label(const Value: string);
    procedure SetShowamount1(const Value: string);
    procedure SetshowAMount2(const Value: string);
    procedure SetActive(const Value: string);
    procedure SetEditedFlag(const Value: string);
    procedure SetStartDate(const Value: TDateTime);
    procedure SetEndDate(const Value: TDateTime);
    procedure SetInterval(const Value: integer);
    procedure SetIntPeriod(const Value: integer);

    function GetBudgetName: string;
    function GetDescription: string;
    function GetAmount1Label: string;
    function GetAmount2Label: string;
    function GetShowAmount1: string;
    function GetShowAmount2: string;
    function getActive: string;
    function getEditedFlag: string;
    function getStartDate: TDateTime;
    function GetEndDate: TDatetime;
    function GetIntPeriod: integer;
    function GetInterval: integer;
    function GetBudgetNos: TBudgetNos;
    procedure BudgetDates(BudgetNo: integer; var StartDAte, EndDate: TDateTime);
    procedure AddnewAccountCallback(const Sender: TBusObj; var Abort: boolean);
    function getIDOfLastPeriod :Integer;
    function getIDOfCurrentPeriod :Integer;
    function getIDOfFirstPeriod :Integer;
  protected
    function GetId: integer; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure New; override;
    procedure Load(const fIsReadonly:boolean =False); override;
    procedure CalcEndDate;
    function IsValidData: boolean;
    function IsBudgetNameUnique(const BId: integer; const BName: string): boolean;
    function Save: boolean; override;
    function BudgetCreated(BudgetNo: integer = 0): Integer;
    function ChangeBudget(VariationOption, VariationType: integer; VariationAmt: double): boolean;
    function CopyBudget(VariationOption, VariationType: integer; VariationAmt: double;
      const fsBudgetName, fsDescription: string; const fdStartDate: TDateTime; const fiBudgetId: integer = 0;
      const fiPeriodFrom: integer = 0; const fiPeriodTo: integer = 0): boolean;
    Function AddnewAccount(const AccountId ,fiBudgetNo :Integer) :Boolean;
    property IsUsed: boolean read fbIsUSed;
    property FirstDateUsed: TDateTime read fdFirstDateUsed;
    property LastDateUsed: TDateTime read fdLastDateUsed;
    property BudgetSaved: boolean read fbBudgetSaved;
    property BudgetNos: TBudgetNos read getBudgetnos write foBudgetNos;
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;
    property CommitOnSave: boolean read fbCommitOnSave write fbCommitOnSave;
    Property SelectedAccounts : TERPQuery Write fSelectedAccounts;
    Property TmpTableName     : String   Write fsTmpTableName;
    Property IDOfLastPeriod     : integer read getIDOfLastPeriod;
    Property IDOFCurrentPeriod  : Integer REad getIDOFCurrentPeriod;
    Property IDOFFirstPeriod  : Integer REad getIDOFFirstPeriod;
  published
    property BudgetName: string read GetBudgetName write SetBudgetName;
    property Description: string read GetDescription write setDescription;
    property Amount1Label: string read GetAmount1Label write setAmount1Label;
    property Amount2Label: string read GetAmount2Label write setAmount2Label;
    property ShowAmount1: string read GetShowAmount1 write setShowAmount1;
    property ShowAmount2: string read GetShowAmount2 write setShowAmount2;
    property Active: string read getActive write setActive;
    property EditedFlag: string read getEditedFlag write setEditedFlag;
    property StartDate: TDateTime read getStartDate write setStartDate;
    property EndDate: TDatetime read GetEndDate write setEndDate;
    property IntervalPeriod: integer read GetIntPeriod write setIntPeriod;
    property Interval: integer read GetInterval write setInterval;
    property BudgetClasses: TBusObj read getBudgetClasses write SetBudgetClasses;
  end;

procedure Register;

implementation

uses FastFuncs,SysUtils,  DateUtils, BusObjBudget, BudgetLib, Variants,
   AppEnvironment, MySQLConst, CommonLib;

constructor TBusObjBudgetDef.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbBudgetClasses := nil;
  fbCommitOnSave := true;
  fSelectedAccounts := nil;
  fsTmpTableName := '';
end;
procedure TBusObjBudgetDef.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  BudgetClasses.LoadSelect('BudgetId = ' + IntToStr(GetId));
  if Assigned(foBudgetNos) then if not foBudgetNos.IsEmpty then
    if foBudgetNos.Count > 0 then begin
      foBudgetNos.IsEmpty := True;
      foBudgetNos.Clear;
      FreeAndNil(foBudgetNos);
    end;
end;

destructor TBusObjBudgetDef.Destroy;
begin
  if Assigned(fbBudgetClasses) then fbBudgetClasses:= nil;
  
  if Assigned(foBudgetNos) then
  if not foBudgetNos.IsEmpty then
    if foBudgetNos.Count > 0 then begin
      foBudgetNos.Clear;
      FreeAndNil(foBudgetNos);
    end;
  inherited Destroy;
end;

function TBusObjBudgetDef.Save: boolean;
begin
  Result := false;
  fbBudgetSaved := false;
  if not IsValidData then Exit;

  try
    inherited Save;
    if fbCommitOnSave then Connection.CommitTransaction;
    fbBudgetSaved := true;
    Result        := true;
  except
    raise;
  end;
end;

function TBusObjBudgetDef.IsBudgetNameUnique(const BId: integer; const BName: string): boolean;
begin
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := Self.Connection.Connection;
      SQL.add('Select * from tblBudgets where name = ' + QuotedStr(bname));
      SQL.add(' and BudgetId <> ' + IntToStr(BId));
      Open;
      Result := RecordCount = 0;
    finally
      if Active then Close;
      Free;
    end;
end;

function TBusObjBudgetDef.IsValidData: boolean;
begin
  Result := false;
  InvalidMsg := '';
  if Trim(BudgetName) = '' then begin
    ResultStatus.AddItem(True,rssWarning, 0,'Budget Name should not be blank' );
    Exit;
  end;
  if not IsBudgetNameUnique(GetId, BudgetName) then begin
    ResultStatus.AddItem(True,rssWarning, 0,'Budget with the same name already exists, Budget name cannot be duplicate');
    Exit;
  end;
  if StartDate = 0 then begin
    ResultStatus.AddItem(True,rssWarning, 0,'Startdate should not be blank');
    Exit;
  end;
  if Interval = 0 then begin
    ResultStatus.AddItem(True,rssWarning, 0,'Periods should not be blank');
    Exit;
  end;
  if IntervalPeriod = 0 then begin
    ResultStatus.AddItem(True,rssWarning, 0,'Interval should not be blank');
    Exit;
  end;
  if (ShowAmount1 <> 'T') and (ShowAmount2 <> 'T') then begin
    ResultStatus.AddItem(True,rssWarning, 0,'One of the amount field should be visible');
    Exit;
  end;
  if ShowAmount1 = 'T' then if Trim(Amount1Label) = '' then begin
      ResultStatus.AddItem(True,rssWarning, 0,'Amount label should not be blank');
      Exit;
    end;
  if ShowAmount2 = 'T' then if Trim(Amount2Label) = '' then begin
      ResultStatus.AddItem(True,rssWarning, 0,'Amount label should not be blank');
      Exit;
    end;

  if fbIsUSed then if StartDate > fdFirstDateUSed then begin
        ResultStatus.AddItem(True,rssWarning, 0,'Budget record exists for ' + FormatDateTime('dd/mm/yyyy', fdFirstDateUSed) +
        Chr(13) + 'Budget start date cannot be greater than this date');
      Exit;
    end;
  if fbIsUSed then if EndDate < fdLastDateUSed then begin
      ResultStatus.AddItem(True,rssWarning, 0,'Budget record exists for ' + FormatDateTime('dd/mm/yyyy', fdLastDateUsed) +
        Chr(13) + 'Budget End date cannot be less than this date');
      Exit;
    end;
  with fbBudgetClasses.DataSet do begin
    if RecordCount = 0 then begin
      ResultStatus.AddItem(True,rssWarning, 0,'Budget should have at least one Department.');
      Exit;
    end;
    First;
    while Eof = false do begin
      if FieldByName('ACtive').AsString = 'T' then Result := true;
      Next;
    end;
    if Result = false then begin
      First;
      ResultStatus.AddItem(True,rssWarning, 0,'Budget should have at least one Department.');
      Exit;
    end;
  end;
  Result := true;
end;

procedure TBusObjBudgetDef.Load(const fIsReadonly:boolean =False);
begin
  inherited Load(fIsreadonly);
  fbIsUsed := false;
  if GetId <= 0 then Exit;

  if Assigned(fbBudgetClasses) then fbBudgetClasses.LoadSelect('BudgetId = ' + IntToStr(GetId));

  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := Self.Connection.Connection;
      SQL.Add('Select * from tblBudgetPeriods where BudgetId = ' + IntToStr(ID));
      Open;
      fbIsUsed := RecordCount > 0;
      Close;
      SQL.Clear;
      SQL.add('Select Min(StartDate) as StartDate, ');
      SQL.add(' Max(endDate) as EndDate ');
      SQL.add('from tblBudgetPeriods where BudgetId = ' + IntToStr(id));
      Open;
      if RecordCount > 0 then begin
        fdFirstDateUSed := FieldByName('StartDate').AsDateTime;
        fdLastDateUSed := FieldByName('EndDate').AsDateTime;
      end;
    finally
      if Active then Close;
      Free;
    end;
end;

procedure TBusObjBudgetDef.New;
var
  Qry: TERPQuery;
  f_ID:Integer;
begin
  if Dataset.Active = false then LoadSelect('BudgetId = 0');
  inherited New;

  fbIsUsed := false;

  if Dataset.State <> dsInsert then begin
    raise Exception.Create('Failed adding new record');
    Exit;
  end;
  with dataset do begin
    FieldByName('Name').AsString         := '';
    FieldByName('Description').AsString  := '';
    FieldByName('StartDate').AsDateTime  := Date;
    FieldByName('Active').AsString       := 'T';
    FieldByName('EditedFlag').AsString   := 'F';
    FieldByName('Amount1Label').AsString := 'Aggressive';
    FieldByName('Amount2Label').AsString := 'Conservative';
    FieldByName('ShowAmount1').AsString  := 'T';
    FieldByName('ShowAmount2').AsString  := 'T';
    Post;
    f_ID := FieldByName('BudgetId').AsInteger;
    Close;
  end;
  {Add all classes into the budget class as inactive}
  Qry := TERPQuery.Create(Self);
  Qry.Options.FlatBuffers := True;
  Qry.Connection := Self.Connection.Connection;
  Qry.SQL.Add('INSERT HIGH_PRIORITY INTO tblBudgetClass ');
  Qry.SQL.Add('(budgetId, classID , Active)');
  Qry.SQL.Add(' select ' + IntToStr(f_ID) + ' , ClassId , ' + QuotedStr('F') + '  from tblClass');
  Qry.SQL.Add(' Where Active = ''T'' Order by ClassName ');
  Qry.Execute;
  Qry.SQL.clear;
  Qry.SQL.add('update tblBudgetClass Set Active = ''T'' where budgetId = ' + IntToStr(f_ID) + ' and ClassId = ' + IntToStr(AppEnv.DefaultClass.ClassID) );
  Qry.Execute;
  LoadSelect('BudgetId = ' + IntToStr(f_ID));
  BudgetClasses.Dataset.First;
end;

function TBusObjBudgetDef.GetId: integer;
begin
  Result := getIntegerField(IDFieldName);
end;
class function TBusObjBudgetDef.GetBusObjectTablename: string;
begin
  Result := 'tblbudgets';
end;

class Function TBusObjBudgetDef.GetIDField :String ;
begin
    Result :='BudgetId';
end;

function TBusObjBudgetDef.getBudgetClasses: TBusObj;
begin
  if not Assigned(fbBudgetClasses) then begin
    fbBudgetClasses      := TBusObjBudgetClasses.Create(Self);
    fbBudgetClasses.Connection := Self.Connection;
    fbBudgetClasses.LoadSelect('BudgetId = ' + IntToStr(GetId) );
  end;
  Result := fbBudgetClasses;
end;

procedure TBusObjBudgetDef.SetBudgetClasses(const Value: TBusObj);
begin
  fbBudgetClasses := Value;
end;

procedure TBusObjBudgetDef.CalcEndDate;
begin
  if IntervalPeriod = 0 then Exit;
  if StartDate = 0 then Exit;
  if Interval = 0 then Exit;

       if IntervalPeriod = 1 then EndDate := IncDay(StartDate, Interval)
  else if IntervalPeriod = 2 then EndDate := IncWeek(StartDate, Interval)
  else if IntervalPeriod = 3 then EndDate := IncWeek(StartDate, 2 * Interval)
  else if IntervalPeriod = 4 then EndDate := IncMonth(StartDate, Interval)
  else if IntervalPeriod = 5 then EndDate := IncMonth(StartDate, 3 * Interval)
  else if IntervalPeriod = 6 then EndDate := IncMonth(StartDate, 6 * Interval)
  else if IntervalPeriod = 7 then EndDate := Incyear(StartDate, Interval);
  EndDate := IncDay(EndDate, - 1);
end;

procedure TBusObjBudgetDef.Load(Const aId: integer;const fIsReadonly:boolean =False);
begin
  LoadSelect('BudgetID = ' + IntToStr(aId), fisReadonly);
end;
function TBusObjBudgetDef.getIDOfCurrentPeriod :Integer;
var
    strSql :STring;
begin
    REsult := 0;
    strSql := 'Select BudgetPeriodID as BudgetPeriodID  from tblBudgetPeriods ';
    strSql := StrSql +' where BudgetId =' + IntToStr(Self.ID);
    strSql := StrSql +  ' and startDAte <= ' + QuotedStr(FormatDateTime(MysqlDateFormat , now));
    strSql := StrSql +  ' and endDate >= ' + QuotedStr(FormatDateTime(MysqlDateFormat , now));
    with getNewDataset(strSql) do try
        if recordcount <> 0 then REsult := fieldByname('BudgetPeriodID').asInteger;
    Finally
        Close;
        Free;
    end;
    if REsult = 0 then begin
        strSql := 'Select min(BudgetPeriodID) as BudgetPeriodID  ' ;
        strSql := StrSql +' from tblBudgetPeriods inner join tblBudgets on tblBudgetPeriods.BudgetId = tblBudgets.BudgetId ';
        strSql := StrSql +' where tblBudgets.BudgetId =' + IntToStr(Self.ID);
        strSql := StrSql +  ' and tblBudgets.startDAte >= ' + QuotedStr(FormatDateTime(MysqlDateFormat , now));
        with getNewDataset(strSql) do try
            if recordcount <> 0 then REsult := fieldByname('BudgetPeriodID').asInteger;
        Finally
            Close;
            Free;
        end;
    end;
    if REsult = 0 then begin
        strSql := 'Select max(BudgetPeriodID) as BudgetPeriodID  ' ;
        strSql := StrSql +' from tblBudgetPeriods inner join tblBudgets on tblBudgetPeriods.BudgetId = tblBudgets.BudgetId ';
        strSql := StrSql +' where tblBudgets.BudgetId =' + IntToStr(Self.ID);
        strSql := StrSql +  ' and tblBudgets.endDAte <= ' + QuotedStr(FormatDateTime(MysqlDateFormat , now));
        with getNewDataset(strSql) do try
            if recordcount <> 0 then REsult := fieldByname('BudgetPeriodID').asInteger;
        Finally
            Close;
            Free;
        end;
    end;
end;
function TBusObjBudgetDef.getIDOfFirstPeriod :Integer;
begin
    REsult := 0;
    with getNewDataset('Select MIN(BudgetPeriodID) as BudgetPeriodID  from tblBudgetPeriods where BudgetId =' + IntToStr(Self.ID)) do try
        if recordcount <> 0 then REsult := fieldByname('BudgetPeriodID').asInteger;
    Finally
        Close;
        Free;
    end;

end;

function TBusObjBudgetDef.getIDOfLastPeriod :Integer;
begin
    REsult := 0;
    with getNewDataset('Select Max(BudgetPeriodID) as BudgetPeriodID  from tblBudgetPeriods where BudgetId =' + IntToStr(Self.ID)) do try
        if recordcount <> 0 then REsult := fieldByname('BudgetPeriodID').asInteger;
    Finally
        Close;
        Free;
    end;
end;

procedure TBusObjBudgetDef.AddnewAccountCallback(const Sender: TBusObj; var Abort: boolean);
begin
    BudgetClasses.Dataset.First;
    While BudgetClasses.Dataset.Eof = False do begin
        if BudgetClasses.Dataset.FieldByname('Active').asBoolean then
            if not TBusObjBudget(Sender).BudgetPeriodLines.Locate('AccountId;ClassId' ,
                    varArrayof([fiNewAccountId ,
                        BudgetClasses.Dataset.FieldByname('classId').asInteger ])
                        , []) then begin
                TBusObjBudget(Sender).BudgetPeriodLines.Insert;
                TBusObjBudget(Sender).BudgetPeriodLines.FieldByname('BudgetId').asInteger :=TBusObjBudget(Sender).BudgetId;
                TBusObjBudget(Sender).BudgetPeriodLines.FieldByname('BudgetPeriodId').asInteger :=TBusObjBudget(Sender).ID;
                TBusObjBudget(Sender).BudgetPeriodLines.FieldByname('ClassId').asInteger :=
                    BudgetClasses.Dataset.FieldByname('ClassId').asInteger;
                TBusObjBudget(Sender).BudgetPeriodLines.FieldByname('AccountId').asInteger :=fiNewAccountId;
                TBusObjBudget(Sender).BudgetPeriodLines.FieldByname('Amount1').asFloat := 0;
                TBusObjBudget(Sender).BudgetPeriodLines.FieldByname('Amount2').asFloat := 0;
                TBusObjBudget(Sender).BudgetPeriodLines.FieldByname('Active').asBoolean := True;
                TBusObjBudget(Sender).BudgetPeriodLines.Post;
            end;
        BudgetClasses.Dataset.Next;
    end;
end;

Function TBusObjBudgetDef.AddnewAccount(const AccountId ,fiBudgetNo :Integer) :Boolean;
var
    fBudgetPeriods :TBusObjBudget;
begin
    fiNewAccountId :=AccountId;
    fbAccountAdded := True;
    fBudgetPeriods :=TBusObjBudget.Create(nil);
    Try
        fBudgetPeriods.CommitOnSave := False;
        fBudgetPeriods.Connection := Self.Connection;
        if not fBudgetPeriods.Connection.Connection.InTransaction then
            TMydacDataconnection(fBudgetPeriods.Connection).BeginTransaction;
        fBudgetPeriods.LoadSelect('BudgetId = ' + IntToStr(ID) + ' and BudgetNo <> ' + IntToStr(fiBudgetNo) );
        fBudgetPeriods.IterateRecords(AddnewAccountCallback);
    finally
        FreeandNil(fBudgetPeriods);
    end;
    Result := fbAccountAdded;
end;
procedure TBusObjBudgetDef.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.
  if (Sysutils.SameText(Sender.FieldName , 'StartDate')) or
    (Sysutils.SameText(Sender.FieldName , 'IntervalPeriod')) or
    (Sysutils.SameText(Sender.FieldName , 'IntervalDuration')) then begin
    CalcEndDate;
  end;
end;
function TBusObjBudgetDef.GetSQL: string;
begin
  Result := '';
  if fSQL = '' then fSQL := 'Select * from tblbudgets';
  if fSQL <> '' then Result := fSQL;
  if fSQLSelect <> '' then Result := Result + ' WHERE ' + fSQLSelect;
end;

procedure TBusObjBudgetDef.SetBudgetName(const Value: string);
begin
  SetStringField('Name', Value);
end;

procedure TBusObjBudgetDef.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TBusObjBudgetDef.SetAmount1Label(const Value: string);
begin
  SetStringField('Amount1Label', Value);
end;

procedure TBusObjBudgetDef.SetAmount2Label(const Value: string);
begin
  SetStringField('Amount2Label', Value);
end;

procedure TBusObjBudgetDef.SetShowamount1(const Value: string);
begin
  SetStringField('ShowAmount1', Value);
end;

procedure TBusObjBudgetDef.SetshowAMount2(const Value: string);
begin
  SetStringField('ShowAmount2', Value);
end;

procedure TBusObjBudgetDef.SetActive(const Value: string);
begin
  SetStringField('Active', Value);
end;

procedure TBusObjBudgetDef.SetEditedFlag(const Value: string);
begin
  SetStringField('EditedFlag', Value);
end;

procedure TBusObjBudgetDef.SetStartDate(const Value: TDateTime);
begin
  SetDateTimeField('StartDate', Value);
end;

procedure TBusObjBudgetDef.SetEndDate(const Value: TDateTime);
begin
  SetDateTimeField('EndDate', Value);
end;

procedure TBusObjBudgetDef.SetInterval(const Value: integer);
begin
  SetIntegerField('IntervalDuration', Value);
end;

procedure TBusObjBudgetDef.SetIntPeriod(const Value: integer);
begin
  SetIntegerField('IntervalPeriod', Value);
end;


function TBusObjBudgetDef.GetBudgetName: string;
begin
  Result := GetStringField('Name');
end;

function TBusObjBudgetDef.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TBusObjBudgetDef.GetAmount1Label: string;
begin
  Result := GetStringField('Amount1Label');
end;

function TBusObjBudgetDef.GetAmount2Label: string;
begin
  Result := GetStringField('Amount2Label');
end;

function TBusObjBudgetDef.GetShowAmount1: string;
begin
  Result := GetStringField('ShowAmount1');
end;

function TBusObjBudgetDef.GetShowAmount2: string;
begin
  Result := GetStringField('ShowAmount2');
end;

function TBusObjBudgetDef.getActive: string;
begin
  Result := GetStringField('Active');
end;

function TBusObjBudgetDef.getEditedFlag: string;
begin
  Result := GetStringField('EditedFlag');
end;

function TBusObjBudgetDef.getStartDate: TDateTime;
begin
  Result := GetDateTimeField('StartDate');
end;

function TBusObjBudgetDef.GetEndDate: TDatetime;
begin
  Result := GetDateTimeField('EndDate');
end;

function TBusObjBudgetDef.GetIntPeriod: integer;
begin
  Result := getIntegerField('IntervalPeriod');
end;

function TBusObjBudgetDef.GetInterval: integer;
begin
  Result := getIntegerField('IntervalDuration');
end;

procedure TBusObjBudgetDef.BudgetDates(BudgetNo: integer; var StartDAte, EndDate: TDateTime);
var
  fdStartDate: TDateTime;
  fdEndDate: TDateTime;
  ctr: integer;
begin
  fdStartDate := Self.StartDate;
  for ctr := 1 to Self.Interval do begin
    case Self.IntervalPeriod of
      1: fdEndDate := incDay(fdStartDate, 1);
      2: fdEndDate := incWeek(fdStartDate, 1);
      3: fdEndDate := incWeek(fdStartDate, 2);
      4: fdEndDate := IncMonth(fdStartDate, 1);
      5: fdEndDate := IncMonth(fdStartDate, 3);
      6: fdEndDate := IncMonth(fdStartDate, 6);
      else fdEndDate := incyear(fdStartDate, 1);
    end;
    fdEndDate := incDay(fdEndDate, - 1);
    if BudgetNo = ctr then begin
      StartDate := fdStartDate;
      EndDate := fdEndDate;
      Exit;
    end;
    fdStartDate := incDay(fdEndDate, 1);
  end;
end;

function TBusObjBudgetDef.getBudgetNos: TBudgetNos;
var
  fdStartDate: TDateTime;
  ctr: integer;
  Colctr: integer;
begin
  if Assigned(foBudgetNos) then
  Try
    if not foBudgetNos.IsEmpty then
        if foBudgetNos.Count > 0 then begin
            Result := foBudgetNos;
            Exit;
        end;
  Except
      // if foBudgetnos is just created and no items added , the object is assigned and the count
      // creates and exception :( the try block here kills that exception
  End;

  if (not Assigned(foBudgetNos)) or (foBudgetNos.ISEmpty) then foBudgetNos := TBudgetNos.Create;
  fdStartDate := Self.StartDate;
  for ctr := 1 to Self.Interval do begin
    foBudgetNos.add;
    colCtr := foBudgetNos.Count - 1;
    TBudgetNo(foBudgetNos.Items[ColCtr]).BudgetNo := ctr;
    TBudgetNo(foBudgetNos.Items[ColCtr]).StartDate := fdStartDate;
    case Self.IntervalPeriod of
      1: fdStartDate := incDay(fdStartDate, 1);
      2: fdStartDate := incWeek(fdStartDate, 1);
      3: fdStartDate := incWeek(fdStartDate, 2);
      4: fdStartDate := IncMonth(fdStartDate, 1);
      5: fdStartDate := IncMonth(fdStartDate, 3);
      6: fdStartDate := IncMonth(fdStartDate, 6);
      7: fdStartDate := incyear(fdStartDate, 1);
    end;
    TBudgetNo(foBudgetNos.Items[ColCtr]).EndDate         := fdStartDate - 1;
    TBudgetNo(foBudgetNos.Items[ColCtr]).BudgetRecExists := BudgetCreated(ctr)>0;
  end;
  Result := foBudgetNos;
end;

function TBusObjBudgetDef.CopyBudget(VariationOption, VariationType: integer; VariationAmt: double;
  const fsBudgetName, fsDescription: string; const fdStartDate: TDateTime; const fiBudgetId: integer = 0;
  const fiPeriodFrom: integer = 0; const fiPeriodTo: integer = 0): boolean;
var
  Budget: TBusObjBudgetDef;
  BudgetPeriodFrom: TBusObjBudget;
  BudgetPeriodTo: TBusObjBudget;
  datediff: integer;
  ctr: integer;
  fieldName: string;
  Amt: double;
  Qry: TERPQuery;
  fEndDate, fStartDate: TDateTime;
  AccountToBeCopied : Boolean;
  fbInvaliddate :Boolean;

  function IsAmtField(const FieldName: string): boolean;
  begin
    Result := false;
    if uppercase(Copy(FieldName, char_length(fieldName) - 4, 4)) = '_AMT' then
      if uppercase(Copy(FieldName, 1, 12)) <> 'ALLCLASS_AMT' then Result := true;
  end;
begin
  try
    Self.Connection.BeginTransaction;
    Qry := TERPQuery.Create(nil);
    Qry.Options.FlatBuffers := True;
    try
      Qry.Connection := Self.Connection.Connection;

      {delete the periodTo record if it already exists}
      Qry.SQL.add('Select BudgetPeriodId from tblbudgetPeriods where BudgetId = ' + IntToStr(Self.ID));
      Qry.SQl.add('and BudgetNo = ' + IntToStr(fiPeriodTO));
      Qry.Open;
      if Qry.recordcount > 0 then begin
        ctr := Qry.Fieldbyname('BudgetPeriodId').asInteger;
        Qry.Close;
        Qry.SQL.clear;
        Qry.SQL.add('Delete from tblbudgetPeriodLines where  BudgetPeriodId= ' + IntToStr(ctr));
        Qry.Execute;
        Qry.SQL.clear;
        Qry.SQL.add('Delete from TblbudgetLines where  BudgetPeriodId= ' + IntToStr(ctr));
        Qry.Execute;
        Qry.SQL.clear;
        Qry.SQL.add('Delete from tblbudgetPeriods where  BudgetPeriodId= ' + IntToStr(ctr));
        Qry.Execute;
      end;

      Qry.SQL.clear;
      Qry.SQL.add('Select BudgetPeriodId from tblBudgetPeriods where BudgetId = ' + IntToStr(Self.ID));
      if fiPeriodFrom <> 0 then Qry.SQL.add(' and BudgetNo = ' + IntToStr(fiPeriodFrom));
      Qry.Open;

      Budget := TBusObjBudgetDef.Create(Self);
      try
        Budget.Connection := Self.Connection;
        Budget.SQL := 'Select * from tblBudgets';
        Budget.CommitOnSave := false;
        if fiBudgetId = 0 then begin
          Budget.New;
          Budget.BudgetName := fsBudgetName;
          Budget.Description := fsDescription;
          Budget.StartDate := fdStartDate;
          Budget.IntervalPeriod := Self.IntervalPeriod;
          Budget.Interval := Self.Interval;
          Budget.CalcEndDate;
          Budget.ShowAmount1 := Self.ShowAmount1;
          Budget.ShowAmount2 := Self.ShowAmount2;
          Budget.Amount1Label := Self.Amount1Label;
          Budget.Amount2Label := Self.Amount2Label;

          Self.BudgetClasses.Dataset.First;
          while Self.BudgetClasses.Dataset.Eof = false do begin
            if Budget.BudgetClasses.Dataset.Locate('ClassId', Self.BudgetClasses.Dataset.FieldByName('ClassId').AsInteger, []) then
            begin
              if Budget.BudgetClasses.Dataset.State = dsBrowse then Budget.BudgetClasses.Dataset.Edit;
              Budget.BudgetClasses.Dataset.FieldByName('ACtive').AsString :=
                Self.BudgetClasses.Dataset.FieldByName('Active').AsString;
              Budget.BudgetClasses.Postdb;
            end;
            Self.BudgetClasses.Dataset.Next;
          end;
          Budget.Save;
        end else begin
          Budget.Load(fiBudgetId);
          Budget.BudgetDates(fiPeriodTo, fStartDate, fEndDate);
        end;

        while Qry.Eof = false do begin
          BudgetPeriodFrom := TBusObjBudget.Create(Self);
          BudgetPeriodTo := TBusObjBudget.Create(Self);
          try
            BudgetPeriodFrom.TableName := 'tmp_Budget_From' + GetTemporaryTableNameSuffix;
            BudgetPeriodTo.TableName := 'tmp_Budget_To' + GetTemporaryTableNameSuffix;

            BudgetPeriodTo.connection := Self.Connection;
            BudgetPeriodTo.SQL := 'Select * from tblBudgetPeriods';
            BudgetPeriodTo.New;
            BudgetPeriodTo.BudgetDefinition := Budget;
            BudgetPeriodTo.OpenLines;
            BudgetPeriodTo.CommitOnSave := false;

            BudgetPeriodFrom.connection := Self.Connection;
            BudgetPeriodFrom.SQL := 'Select * from tblBudgetPeriods';
            ctr := Qry.FieldByName('BudgetPeriodId').AsInteger;
            BudgetPeriodFrom.Load(ctr);
            BudgetPeriodFrom.BudgetDefinition := Self;
            BudgetPeriodFrom.OpenLines;
            BudgetPeriodFrom.CommitOnSave := false;
            if fiBudgetId <> 0 then dateDiff := System.Round(fStartDate - BudgetPeriodFrom.StartDate)
            else dateDiff := System.Round(Budget.StartDate - Self.StartDate);

            BudgetPeriodTo.Dataset.FieldByName('BudgetId').AsInteger := budget.Id;
            BudgetPeriodTo.Dataset.FieldByName('BudgetDate').AsDateTime := Date;
            if fiPeriodTo <> 0 then begin
              BudgetPeriodTo.Dataset.FieldByName('BudgetNo').AsInteger := fiPeriodTo;
              BudgetPeriodTo.Dataset.FieldByName('StartDate').AsDateTime := fStartDAte;
              BudgetPeriodTo.Dataset.FieldByName('EndDate').AsDateTime := fEndDate;
            end else begin
              Budget.BudgetDates(BudgetPeriodFrom.Dataset.FieldByName('BudgetNo').AsInteger, fStartDate, fEndDate);
              BudgetPeriodTo.Dataset.FieldByName('BudgetNo').AsInteger :=
                BudgetPeriodFrom.Dataset.FieldByName('BudgetNo').AsInteger;
              BudgetPeriodTo.Dataset.FieldByName('StartDate').AsDateTime := fStartDate;
              BudgetPeriodTo.Dataset.FieldByName('EndDate').AsDateTime := fEndDate;
            end;

            BudgetPeriodTo.Dataset.FieldByName('EditedFlag').AsString := 'F';
            BudgetPeriodTo.Dataset.FieldByName('Active').AsString :=
              BudgetPeriodFrom.Dataset.FieldByName('Active').AsString;
            BudgetPeriodTo.Postdb;
            BudgetPeriodFrom.FormLines.Dataset.First;

            while BudgetPeriodFrom.FormLines.Dataset.Eof = false do begin
                fbInvaliddate := False;
                if BudgetPeriodFrom.FormLines.Dataset.FieldByName('ForDate').AsBoolean = true then begin
                    dateDiff := System.Round(BudgetPeriodFrom.FormLines.Dataset.FieldByName('BudgetDate').AsDateTime - BudgetPeriodFrom.StartDate);
                    fbInvaliddate := incDay(BudgetPeriodto.StartDAte, datediff) > BudgetPeriodto.EndDate;
                End;
                if not fbInvaliddate then begin
                  AccountToBeCopied := true;
                  if Assigned(fSelectedAccounts) then
                    if fSelectedAccounts.Locate('AccountId' , BudgetPeriodFrom.FormLines.Dataset.FieldByName('AccountId').AsInteger , []) then begin
                        if fSelectedAccounts.FieldByname('RecSelected').asBoolean then begin
                            if fSelectedAccounts.FieldByname('VarType').asString = 'P' then  VariationType := 1 else VariationType := 0;
                            if fSelectedAccounts.FieldByname('IncDec').asString = 'D' then  VariationOption := 1 else VariationOption := 0;
                            Variationamt := fSelectedAccounts.FieldByname('VarAmount').asFloat;
                        end else AccountToBeCopied := False;
                    end else AccountToBeCopied := False;
                  if AccountToBeCopied then begin
                    BudgetPeriodTo.FormLines.Dataset.Append;

                    {make all the fields read-write for the internal process}
                    for ctr := 0 to BudgetPeriodTo.FormLines.Dataset.FieldCount - 1 do begin
                        FieldName := BudgetPeriodTo.FormLines.Dataset.Fields[ctr].fieldName;
                        BudgetPeriodTo.FormLines.Dataset.FindField(FieldName).ReadOnly := false;
                    end;
                    BudgetPeriodTo.FormLines.Dataset.FieldByName('AccountId').AsInteger :=
                        BudgetPeriodFrom.FormLines.Dataset.FieldByName('AccountId').AsInteger;
                    BudgetPeriodTo.FormLines.Dataset.FieldByName('AccountName').AsString :=
                        BudgetPeriodFrom.FormLines.Dataset.FieldByName('AccountName').AsString;
                    BudgetPeriodTo.FormLines.Dataset.FieldByName('JobId').AsInteger :=
                        BudgetPeriodFrom.FormLines.Dataset.FieldByName('JobId').AsInteger;
                    BudgetPeriodTo.FormLines.Dataset.FieldByName('JobName').AsString :=
                        BudgetPeriodFrom.FormLines.Dataset.FieldByName('JobName').AsString;
                    BudgetPeriodTo.FormLines.Dataset.FieldByName('ForDate').AsString :=
                        BudgetPeriodFrom.FormLines.Dataset.FieldByName('ForDate').AsString;
                    if BudgetPeriodTo.FormLines.Dataset.FieldByName('ForDate').AsBoolean = true then begin
                        BudgetPeriodTo.FormLines.Dataset.FieldByName('BudgetDate').AsDateTime :=incDay(BudgetPeriodTo.StartDate , datediff);
                    end;
                    try
                        for ctr := 0 to BudgetPeriodFrom.FormLines.Dataset.FieldCount - 1 do begin
                            FieldName := BudgetPeriodFrom.FormLines.Dataset.Fields[ctr].fieldName;
                            if isAmtfield(FieldName) then begin
                              Amt := BudgetPeriodFrom.FormLines.Dataset.FieldByName(FieldName).AsFloat;
                              if VariationOption = 0 then //increased by
                                if VariationType = 0 then //Dollars
                                  Amt := Amt + Variationamt
                                else if VariationType = 1 then //%age
                                  Amt := Amt + Amt * VariationAmt / 100;
                              if VariationOption = 1 then //decreased by
                                if VariationType = 0 then //Dollars
                                  Amt := Amt - Variationamt
                                else if VariationType = 1 then //%age
                                  Amt := Amt - Amt * VariationAmt / 100;

                              BudgetPeriodTo.FormLines.Dataset.FieldByName(FieldName).AsFloat := Amt;
                            end;
                        end;
                    Except
                        on E:Exception do begin
                            REsultstatus.AddItem(False , rssWarning , 0 , E.message);
                        end;
                    end;
                    BudgetPeriodTo.FormLines.Dataset.FieldByName('Active').AsString :=
                        BudgetPeriodFrom.FormLines.Dataset.FieldByName('Active').AsString;
                                {when the record is copied from jan to feb and if records where created for
                                30th or 31st of jan, those should be ignored. }
                    if BudgetPeriodTo.FormLines.Dataset.FieldByName('BudgetDate').AsDateTime <> 0 then
                        if BudgetPeriodTo.FormLines.Dataset.FieldByName('BudgetDate').AsDateTime > fEndDate then
                            BudgetPeriodTo.FormLines.Dataset.Cancel;

                    BudgetPeriodTo.FormLines.Postdb;
                  End;
              end;
              BudgetPeriodFrom.FormLines.Dataset.Next;
            end;
            if BudgetPeriodTo.FormLines.Dataset.RecordCount > 0 then begin
              BudgetPeriodTo.Save;
              if BudgetPeriodTo.BudgetSaved = false then begin
                Result := false;
                Exit;
              end;
            end;
          finally
            BudgetPeriodFrom.Kill;
            BudgetPeriodTo.Kill;
          end;
          Qry.Next;
        end;
      finally
        FreeAndNil(Budget);
      end;
    finally
      if Qry.Active then Qry.Close;
      FreeAndNil(qry);
    end;
    Result := true;
  except
    Result := false;
  end;
end;

function TBusObjBudgetDef.ChangeBudget(VariationOption, VariationType: integer; VariationAmt: double): boolean;
begin
try
    with TERPQuery.Create(Self) do try
        Options.FlatBuffers := True;
        Connection := Self.Connection.Connection;
        if Assigned(fSelectedAccounts) then begin
            // tblBudgetLines : Increase Dollars
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)+IFNULL(TmpTableName.VarAmount,0) ');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)+IFNULL(TmpTableName.VarAmount,0)');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            // tblBudgetLines : Increase %age
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)+IFNULL(tblBudgetLines.Conservative,0)*IFNULL(TmpTableName.VarAmount,0)/100 ');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)+IFNULL(tblBudgetLines.Aggressive,0)*IFNULL(TmpTableName.VarAmount,0)/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            // tblBudgetLines : Decrease Dollars
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)-IFNULL(TmpTableName.VarAmount,0)');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)-IFNULL(TmpTableName.VarAmount,0)');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            // tblBudgetLines : decrease Percentage
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)-IFNULL(tblBudgetLines.Conservative,0)*IFNULL(TmpTableName.VarAmount,0)/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)-IFNULL(tblBudgetLines.Aggressive,0)*IFNULL(TmpTableName.VarAmount,0)/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            // tblBudgetPeriodLines : increase Dollars
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)+IFNULL(TmpTableName.VarAmount,0) ');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)+IFNULL(TmpTableName.VarAmount,0)');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            // tblBudgetPeriodLines : Increase Percentage
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)+IFNULL(tblBudgetPeriodLines.Amount1,0)*IFNULL(TmpTableName.VarAmount,0)/100 ');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)+IFNULL(tblBudgetPeriodLines.Amount2,0)*IFNULL(TmpTableName.VarAmount,0)/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            // tblBudgetPeriodLines : Decrease dollars
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)-IFNULL(TmpTableName.VarAmount,0)');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)-IFNULL(TmpTableName.VarAmount,0)');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            // tblBudgetPeriodLines : Decrease Percentage
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)-IFNULL(tblBudgetPeriodLines.Amount1,0)*IFNULL(TmpTableName.VarAmount,0)/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)-IFNULL(tblBudgetPeriodLines.Amount2,0)*IFNULL(TmpTableName.VarAmount,0)/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
        end else begin
            Sql.add('update tblBudgetLines ');

            if VariationOption = 0 then begin //increased by
              if VariationType = 0 then begin //Dollars
                SQL.add('set Conservative = IFNULL(conservative,0) + ' + FloatToStr(VariationAmt) + '');
              end else if VariationType = 1 then begin //%age
                SQL.add('set Conservative = IFNULL(conservative,0) + IFNULL(conservative,0) *' + FloatToStr(VariationAmt) + '/100');
              end;
            end else if VariationOption = 1 then begin // decreased by
              if VariationType = 0 then begin          //Dollars
                SQL.add('set Conservative = IFNULL(conservative,0) - ' + FloatToStr(VariationAmt) + '');
              end else if VariationType = 1 then begin //%age
                SQL.add('set Conservative = conservative - conservative *' + FloatToStr(VariationAmt) + '/100');
              end;
            end;
            SQL.add('Where  BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            Sql.add('update tblBudgetLines ');
            if VariationOption = 0 then begin //increased by
              if VariationType = 0 then begin //Dollars
                SQL.add('set Aggressive   = IFNULL(Aggressive,0)   + ' + FloatToStr(VariationAmt));
              end else if VariationType = 1 then begin //%age
                SQL.add('set Aggressive   = IFNULL(Aggressive,0)   + IFNULL(Aggressive,0) *' + FloatToStr(VariationAmt) + '/100');
              end;
            end else if VariationOption = 1 then begin // decreased by
              if VariationType = 0 then begin          //Dollars
                SQL.add('set Aggressive   = IFNULL(Aggressive,0)   - ' + FloatToStr(VariationAmt));
              end else if VariationType = 1 then begin //%age
                SQL.add('set Aggressive   = IFNULL(Aggressive,0)   - IFNULL(Aggressive,0) *' + FloatToStr(VariationAmt) + '/100');
              end;
            end;

            SQL.add(' where BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            Sql.add('update tblBudgetPeriodLines ');
            if VariationOption = 0 then begin //increased by
              if VariationType = 0 then begin //Dollars
                SQL.add('set Amount1 = IFNULL(Amount1,0) + ' + FloatToStr(VariationAmt) + '');
              end else if VariationType = 1 then begin //%age
                SQL.add('set Amount1 = IFNULL(Amount1,0) + IFNULL(Amount1,0) *' + FloatToStr(VariationAmt) + '/100');
              end;
            end else if VariationOption = 1 then begin // decreased by
              if VariationType = 0 then begin          //Dollars
                SQL.add('set Amount1 = IFNULL(Amount1,0) - ' + FloatToStr(VariationAmt) + '');
              end else if VariationType = 1 then begin //%age
                SQL.add('set amount1 = IFNULL(Amount1,0) - IFNULL(Amount1,0) *' + FloatToStr(VariationAmt) + '/100');
              end;
            end;
            SQL.add(' where BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
            Sql.add('update tblBudgetPeriodLines ');
            if VariationOption = 0 then begin //increased by
              if VariationType = 0 then begin //Dollars
                SQL.add('set Amount2 = IFNULL(Amount2,0) + ' + FloatToStr(VariationAmt));
              end else if VariationType = 1 then begin //%age
                SQL.add('set Amount2 = IFNULL(Amount2,0) + IFNULL(Amount2,0) *' + FloatToStr(VariationAmt) + '/100');
              end;
            end else if VariationOption = 1 then begin // decreased by
              if VariationType = 0 then begin          //Dollars
                SQL.add('set Amount2 = IFNULL(Amount2,0) - ' + FloatToStr(VariationAmt));
              end else if VariationType = 1 then begin //%age
                SQL.add('set Amount2 = IFNULL(Amount2,0) - IFNULL(Amount2,0) *' + FloatToStr(VariationAmt) + '/100');
              end;
            end;
            SQL.add(' where BudgetId = ' + IntToStr(self.Id));
            Execute;
            SQL.clear;
        end;
        Result := true;
    finally
        if Active then Close;
        Free;
    End;
except
    Result := false;
end;
end;

function TBusObjBudgetDef.BudgetCreated(BudgetNo: integer=0): Integer;
begin
  Result:=0;
  with TERPQuery.Create(self) do try
      Options.FlatBuffers := True;
      Connection := Self.Connection.Connection;
      SQL.add('Select * from tblbudgetperiods ');
      SQL.add('where BudgetId = ' + IntToStr(Self.Id));
      if BudgetNo <> 0 then
        SQL.add(' and BudgetNo = ' + IntToStr(BudgetNo));
      SQL.add('Order by BudgetNo');
      Open;
      if recordcount >0 then
        Result := Fieldbyname('BudgetPeriodId').asInteger;
    finally
      if Active then Close;
      Free;
    end;
end;
function TBusObjBudgetClasses.GetId: integer;
begin
    REsult := getIntegerField(IDFieldName);
end;

class function TBusObjBudgetClasses.GetBusObjectTablename: string;
begin
  Result := 'tblBudgetClass';
end;

class Function TBusObjBudgetClasses.GetIDField :String ;
begin
    Result :='ID';
end;
procedure TBusObjBudgetClasses.DoFieldOnChange(Sender: TField);
begin
    inherited;
end;
function TBusObjBudgetClasses.GetSQL: string;
begin
  Result := '';
  if fSQL = '' then fSQL := 'Select * from tblBudgetClass ';
  if fSQL <> '' then Result := fSQL;
  if fSQLSelect <> '' then Result := Result + ' WHERE ' + fSQLSelect;

end;
procedure TBusObjBudgetClasses.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
    inherited;
end;


procedure Register;
begin
end;

end.

