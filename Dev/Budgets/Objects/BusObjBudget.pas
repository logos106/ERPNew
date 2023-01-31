{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/09/05  1.00.00 BJ  Initial version.

    Budget Tables
    ==============
    tblBudgets          :The budget definition
    tblBudgetClass      :Has a record for all the classes for each budget
                        The active field indicates whether the class is active for the budget or not
    tblBudgetPeriod     :The budget records - Can have multile records for a budget for different period
                        eg-the budget of Jan of an yearly budget.
    tblbudgetperiodlines:Amounts for date range
    tblBudgetlines      :The day wise Amount details.
    }

unit BusObjBudget;

interface

uses
  BusObjBase, Classes, db, busObjBudgetDef, MyAccess,ERPdbComponents, BudgetCommonUtils, Dialogs;

type
  TRefreshTotals = procedure of object;

  TBusObjBudget = class;

  {class represents the records of the temporary table - all classes in one row}
  TBusObjFormLines = class(TBusObj)
  private
    InvalidMsg          : string;
    fsTableName         : string;
    foOwnerBudget       : TBusObjBudget;
    fbAmountChanged     : boolean;
    fQryClass           : TERPQuery;
    foBudget            : TBusObjBudget;
    fbApplyDatasetEvents: boolean;
    fpRefreshTotal      : TRefreshTotals;

    procedure CalcTotal;
    Function  getQryClass: TERPQuery;
    Function  getClassName(const ClassId: integer): string;
    Function  IsAmtField(const FieldName: string): boolean;
    function AmtName(const FieldName: string): String;
    Property  QryClass   : TERPQuery read getQryClass;
    function getOwnerBudget :TBusobjbudget;
    procedure ResequenceLines;
  protected
    Procedure DoFieldOnChange(Sender: TField); override;
    Function  GetId: integer; override;
    Function  DoBeforePost(Sender: TDatasetBusObj): boolean; override;
    Function  DoAfterPost(Sender: TDatasetBusObj): boolean; override;
    Function  DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetLineFields;
    function Delete:Boolean; override;
    procedure CreateTmpTable;
    function  Save          : boolean; override;
    function  IsRecBlank    : boolean;
    function  IsValidData   : boolean;
    function  OpenLines     : boolean;
    function  getBudgetLinefields: string;
    procedure CalcTotalAll;
    property TableName: string read fsTableName write fsTableName;
    property OwnerBudget: TBusObjBudget read getOwnerBudget write foOwnerBudget;
    property AmountChanged: boolean read fbAmountChanged write fbAmountChanged;
    property Budget: TBusObjBudget write foBudget;
    property ApplyDatasetEvents: boolean read fbApplyDatasetEvents write fbApplyDatasetEvents;
    property RefreshTotal: TRefreshTotals read fpRefreshTotal write fpRefreshTotal;
    procedure Load(const fIsReadonly:boolean =False); override;
  end;

  TBusObjbudgetLines = class(TBusObj)
  private
    function getBudgetPeriodId  : integer;
    function GetClassID         : integer;
    function getAccountId       : integer;
    function getAmount1         : double;
    function getAmount2         : double;
    function getEditedFlag      : string;
    function getActive          : boolean;

    procedure SetBudgetPeriodId(const Value: integer);
    procedure setClassID(const Value: integer);
    procedure SetAccountId(const Value: integer);
    procedure SetAmount1(const Value: double);
    procedure SetAmount2(const Value: double);
    procedure SetEditedFlag(const Value: string);
    procedure SetActive(const Value: boolean);
  protected
    function GetId: integer; override;
    Function  DoAfterInsert(Sender: TDatasetBusObj): boolean; override;
  public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    procedure Load(const fIsReadonly:boolean =False); override;
  published
    property BudgetPeriodId : integer read getBudgetPeriodId write setBudgetPeriodId;
    property ClassId        : integer read GetClassID        write setClassID;
    property AccountId      : integer read getAccountId      write setAccountId;
    property Amount1        : double  read getAmount1        write setAmount1;
    property Amount2        : double  read getAmount2        write setAmount2;
    property EditedFlag     : string  read getEditedFlag     write setEditedFlag;
    property Active         : boolean  read getActive         write setActive;
  end;

  TBusObjBudget = class(TMSBusObj)
  private
    fLines              : TBusObjbudgetLines;
    fQryClass           : TERPQuery;
    fformLines          : TBusObjFormLines;
    fbBudgetDef         : TBusObjBudgetDef;
    foBudgetNos         : TBudgetNos;
    fsTableName         : string;
    InvalidMsg          : string;
    foBudgetSaved       : boolean;
    fbCommitOnSave      : boolean;
    foBudgetPeriodLines : TERPQuery;
    fbApplyDatasetEvents: boolean;
    fSelectedAccounts   : TERPQuery;
    fsTmpTableName      : String;

    function  getBudgetPeriodLines  : TERPQuery;
    function  getBudgetDef          : TBusObjBudgetDef;
    function  getBudgetNos          : TBudgetNos;
    function  GetLines              : TBusObjbudgetLines;
    function  getFormLines          : TBusObjFormLines;
    function  getAmt1Label          : string;
    function  getAmt2Label          : string;
    function  getshowAmount1        : boolean;
    function  getShowAmount2        : boolean;
    function  IsHeaderValid         : boolean;
    function  getQryClass           : TERPQuery;
    function  getNextBudgetDate     : TDateTime;
    function  getBudgetId           : integer;
    function  getBudgetDate         : TDateTime;
    function  getBudgetNo           : integer;
    function  getStartDate          : TDateTime;
    function  getEndDate            : TDateTime;
    function  getActive             : boolean;
    procedure setApplyDatasetEvents(const   Value: boolean);
    procedure SetBudgetId(const             Value: integer);
    procedure SetBudgetDate(const           Value: TDateTime);
    procedure SetBudgetNo(const             Value: integer);
    procedure SetStartDate(const            Value: TDateTime);
    procedure SetEndDate(const              Value: TDateTime);
    procedure SetActive(const               Value: boolean);
    procedure SetTableName(const            Value: string);
    procedure PopulateTmpTable;
    procedure setBudgetDef(const            Value: TBusObjBudgetDef);
    procedure setLines(const                Value: TBusObjbudgetLines);
    procedure SetFormLines(const            Value: TBusObjFormLines);
  protected
    function DoAfterInsert(Sender: TDatasetBusObj)  : boolean; override;
    function GetSQL: string; override;
    Procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
  public
    FooterTotals1: array of real;
    FooterTotals2: array of real;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  LoadBudget(fiBudgetId, fiBudgetNo: integer): boolean;
    function  Save  : boolean; override;
    function  GetId : integer; override;
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    function  IsValidData: boolean;
    function  AccountnameUnique(AccId, Id, JobId: integer): boolean; overload;
    function  AccountnameUnique(AccId, Id, JobId: integer; BudgetDate: TDateTime): boolean; overload;
    function  getClassName(ClassId: integer): string;
    function  ChangePeriod(VariationOption, VariationType: integer; VariationAmt: double): boolean;
    procedure OpenLines;
    procedure CalcTotal;
    procedure Kill;
    procedure Load(Const aid: integer;const fIsReadonly:boolean =False); override;
    procedure New; override;
    procedure Load(const fIsReadonly:boolean =False); override;

    property  BudgetPeriodLines: TERPQuery read getBudgetPeriodLines;
    property ApplyDatasetEvents : boolean write SetApplyDatasetEvents;
    Property SelectedAccounts   : TERPQuery           Write fSelectedAccounts;
    property QryClass           : TERPQuery           read getQryClass;
    property CommitOnSave       : boolean            read fbCommitOnSave write fbCommitOnSave;
    Property TmpTableName       : String             Write fsTmpTableName;
    property TableName          : string             read fsTableName    write SetTableName;
    property Amt1Label          : string             read getAmt1Label;
    property Amt2Label          : string             read getAmt2Label;
    property ShowAmount1        : boolean            read getshowAmount1;
    property ShowAmount2        : boolean            read getshowAmount2;
    property BudgetSaved        : boolean            read foBudgetSaved;
    property NextBudgetDate     : TDateTime          read getNextBudgetDate;
  published
    property BudgetId   : integer   read getBudgetID    write SetBudgetID;
    property BudgetDate : TDateTime read getBudgetDate  write setBudgetDate;
    property BudgetNo   : integer   read getBudgetNo    write setBudgetNo;
    property StartDate  : TDateTime read getStartDate   write setStartDate;
    property EndDate    : TDateTime read getEndDate     write setEndDate;
    property Active     : boolean    read getActive      write setActive;

    property BudgetNos          : TBudgetNos         read getBudgetnos   write foBudgetNos;
    property BudgetDefinition   : TBusObjBudgetDef   read getBudgetDef   write setBudgetDef;
    property Lines              : TBusObjbudgetLines read GetLines       write setLines;
    property FormLines          : TBusObjFormLines   read getFormLines   write SetFormLines;
  end;


implementation

uses FastFuncs,SysUtils, DAteUtils, Variants, tcDataUtils, tcConst, CommonLib,
  MySQLConst, SystemLib;



function TBusObjBudget.GetId: integer;
begin
  Result := getIntegerField(IDFieldName);
end;
class function TBusObjBudget.GetBusObjectTablename: string;
begin
  Result := 'tblBudgetPeriods';
end;

class function  TBusObjBudget.GetIdField : String;
begin
    Result :='BudgetPeriodID';
end;

function TBusObjBudget.getBudgetPeriodLines: TERPQuery;
begin
  if not Assigned(foBudgetPeriodLines) then begin
    foBudgetPeriodLines := TERPQuery.Create(Self);
    foBudgetPeriodLines.Options.FlatBuffers := True;
    foBudgetPeriodLines.Connection := Self.Connection.Connection;
    foBudgetPeriodLines.SQL.add('Select * from tblBudgetPeriodLines ');
    foBudgetPeriodLines.SQL.add('where BudgetPeriodId = ' + IntToStr(GetId));
    foBudgetPeriodLines.SQL.add(' Order by BudgetPeriodLinesId');
  end;
  if foBudgetPeriodLines.Active = false then foBudgetPeriodLines.Open;
  Result := foBudgetPeriodLines;
end;


function TBusObjBudget.getBudgetDef: TBusObjBudgetDef;
begin
  if BudgetID <> 0 then begin
    if not Assigned(fbBudgetDef) then begin
      fbBudgetDef := TBusObjBudgetDef.Create(Self);
      fbBudgetDef.SQL := 'Select * from tblBudgets';
      fbBudgetDef.LoadSelect('BudgetId = ' + IntToStr(BudgetId));
    end;
  end else fbBudgetDef := nil;
  Result := fbBudgetDef;
end;

procedure TBusObjBudget.SetTableName(const Value: string);
begin
  fsTableName := Value;
  if Tablename <> '' then
      if Assigned(fFormLines) then
        fFormLines.TableName := Value;
end;

procedure TBusObjBudget.setBudgetDef(const Value: TBusObjBudgetDef);
begin
  if Value <> fbBudgetDef then begin
    fbBudgetDef := Value; {assigning nil to this object Destroys the budgetclasses too}
    BudgetId    := Value.id;
    if Assigned(foBudgetNos) then
        if not foBudgetNos.IsEmpty then
            if foBudgetNos.Count > 0 then
              FreeandNil(foBudgetNos);
    {delete the budget nos of the old budgetdef selected.}
  end;
end;

function TBusObjBudget.getNextBudgetDate: TDateTime;
var
  Dt: TDateTime;
  dtFound: boolean;
  strSQL :STring;
begin
      strSQL := 'Select BudgetDate from ' + TableName;
      strSQL := strSql + ' where accountId = ' + IntToStr(fformLines.Dataset.FieldByName('AccountId').AsInteger);
      strSQL := strSql + ' and  JobId = ' + IntToStr(fformLines.Dataset.FieldByName('JobId').AsInteger);
      strSQL := strSql + ' and  Id <> ' + IntToStr(fformLines.Dataset.FieldByName('Id').AsInteger);
      strSQL := strSql + ' and ForDate = ''T'' Order by BudgetDate';
    With getnewDataset(strSQL, True) do try
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

function TBusObjBudget.getBudgetId: integer;
begin
  Result := GetIntegerField('BudgetId');
end;

function TBusObjBudget.getBudgetDate: TDateTime;
begin
  Result := GetDateTimeField('BudgetDate');
end;

function TBusObjBudget.getBudgetNo: integer;
begin
  Result := GetIntegerField('BudgetNo');
end;

function TBusObjBudget.getStartDate: TDateTime;
begin
  Result := GetDateTimeField('StartDate');
end;

function TBusObjBudget.getEndDate: TDateTime;
begin
  Result := GetDateTimeField('EndDate');
end;

function TBusObjBudget.getActive: boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TBusObjBudget.SetStartDate(const Value: TDateTime);
begin
  SetDateTimeField('StartDate', Value);
end;

procedure TBusObjBudget.SetEndDate(const Value: TDateTime);
begin
  SetDateTimeField('EndDate', Value);
end;

procedure TBusObjBudget.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TBusObjBudget.SetBudgetId(const Value: integer);
begin
  SetIntegerField('BudgetID', Value);
  if Value <> 0 then BudgetDefinition.Load(Value);
end;

procedure TBusObjBudget.SetBudgetDate(const Value: TDateTime);
begin
  SetDateTimeField('BudgetDate', Value);
end;

procedure TBusObjBudget.SetBudgetNo(const Value: integer);
begin
  if Value <> BudgetNo then begin
    if BudgetDefinition.BudgetCreated(Value) <> 0 then Exit;

    SetIntegerField('BudgetNo', Value);
    if BudgetNos.FindItem(Value) <> nil then begin
      Self.StartDate := BudgetNos.FindItem(Value).StartDate;
      Self.EndDate := BudgetNos.FindItem(Value).EndDate;
    end;
  end;
end;


procedure TBusObjBudget.Kill;
begin
Try
  if Assigned(foBudgetPeriodLines) then begin
    if foBudgetPeriodLines.Active then foBudgetPeriodLines.Close;
    FreeAndNil(foBudgetPeriodLines);
  end;
  if Assigned(fLines) then FreeAndNil(fLines);
  if CommitOnSave then if Assigned(fbBudgetDef) then FreeAndNil(fbBudgetDef);
  if Assigned(foBudgetNos) then
    if not foBudgetNos.IsEmpty then
        if foBudgetNos.Count > 0 then begin
            foBudgetNos.IsEmpty := True;
            foBudgetNos.Clear;
            FreeAndNil(foBudgetNos);
        end;
    if Assigned(fformLines) then
        if fFormLines.Owner = Self then
            FreeAndNil(fFormLines);
Except

end;    
end;

function TBusObjBudget.getBudgetNos: TBudgetNos;
begin
  if Self.BudgetDefinition = nil then begin
    if Assigned(foBudgetNos) then begin
      foBudgetNos.IsEmpty := True;  
      foBudgetNos.Clear;
      FreeAndNil(foBudgetNos);
    end;
    Result := nil;
    Exit;
  end;
  if Assigned(foBudgetNos) then
    Try
        if not foBudgetNos.IsEmpty then
            if foBudgetNos.Count > 0 then begin
                Result := foBudgetNos;
                Exit;
            end;
    Except
      // if foBudgetnos is just created and no items added , the object is assigned and the count
      // creates an exception :( the try block here kills that exception
    end;

  foBudgetNos := Self.BudgetDefinition.BudgetNos;
  Result := foBudgetNos;
end;

constructor TBusObjBudget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'Select * from tblBudgetPeriods';
  BudgetNos := TBudgetNos.Create;
  fLines := nil;
  fFormLines := nil;
  TableName := '';
  fbApplyDatasetEvents := false;
  fbCommitOnSave := true;
  fSelectedAccounts := nil;
  fsTmpTableName := '';
end;

destructor TBusObjBudget.Destroy;
begin
  Kill; // kills the object properties.
  if TableName <> '' then
    getnewdataset('DROP TABLE IF EXISTS ' + TableName , True);
  inherited Destroy;
end;

function TBusObjBudget.getFormLines: TBusObjFormLines;
begin
  if not Assigned(fFormLines) then begin
    fFormLines := TBusObjFormLines.Create(self);
    if ConnectionAssigned then fFormLines.Connection := Connection;
    if Trim(TableName) <> '' then begin
      fFormLines.tablename := tablename;
      fFormLines.CreateTmpTable;
      fFormLines.SQL := 'Select * from ' + TableName; // + ' Order by AccountName';
    end;
    fFormLines.Dataset.Filter := 'Active <> ''F'' ';
    fFormLines.Dataset.Filtered := True;
  end else if not Assigned(fFormLines.Connection) then
    if ConnectionAssigned then fFormLines.Connection := Connection;
  Result := fFormLines;
end;

function TBusObjBudget.GetLines: TBusObjbudgetLines;
begin
  if not Assigned(fLines) then begin
    fLines := TBusObjbudgetLines.Create(self);
    if ConnectionAssigned then fLines.Connection := Connection;
    fLines.SQL := 'Select * from tblBudgetLines';
  end;
  Result := fLines;
  if Self.SilentMode then result.SilentMode := True;
end;

procedure TBusObjBudget.setFormLines(const Value: TBusObjFormLines);
begin
  fFormLines := Value;
  if Value <> nil then begin
    if Assigned(self.Connection) then fFormLines.connection := Self.Connection;
    fFormLines.Budget := Self;
  end;
end;

procedure TBusObjBudget.setLines(const Value: TBusObjbudgetLines);
begin
  fLines := Value;
end;

function TBusObjBudget.LoadBudget(fiBudgetId, fiBudgetNo: integer): boolean;
begin
  if Trim(SQL) = '' then SQL := 'Select * from tblBudgetPeriods';
  fSQLSelect := ' BudgetNo = ' + IntToStr(fiBudgetNo) + ' and BudgetID = ' + IntToStr(fiBudgetId);
  Load;
  Result := Dataset.RecordCount > 0;
end;

procedure TBusObjBudget.Load(Const aid: integer;const fIsReadonly:boolean =False);
begin
  if Trim(SQL) = '' then SQL := 'Select * from tblBudgetPeriods';
  fSQLSelect := ' BudgetPeriodId = ' + IntToStr(aId);
  inherited Load(fIsreadonly);
end;

procedure TBusObjBudget.Load(const fIsReadonly:boolean =False);
begin
  if Trim(SQL) = '' then SQL := 'Select * from tblBudgetPeriods';
  inherited Load(fIsREadonly);
  if GetId <= 0 then Exit;
  if dataset.recordcount > 1 then
    Lines.LoadSelect('BudgetID = ' + IntToStr(BudgetId))
  else
    Lines.LoadSelect('BudgetPeriodID = ' + IntToStr(GetId));
  if TableName <> '' then PopulateTmpTable;
end;

procedure TBusObjBudget.New;
var
    f_id:Integer;
begin
  if Dataset.Active = false then LoadSelect('BudgetPeriodID = 0');

  inherited New;

  if Dataset.State <> dsInsert then begin
    raise Exception.Create('Failed adding new record');
    Exit;
  end;
  with dataset do begin
    FieldByName('Active').AsBoolean       := true;
    FieldByName('EditedFlag').AsString   := 'F';
    FieldByName('BudgetDate').AsDateTime := Date;
    Post;
    f_ID := FieldByName('BudgetPeriodID').AsInteger;
    Close;
  end;
  LoadSelect('BudgetPeriodID = ' + IntToStr(f_ID));
  Dataset.Edit;
end;

procedure TBusObjBudget.setApplyDatasetEvents(const Value: boolean);
begin
  if Value = fbApplyDatasetEvents then Exit;
  fbApplyDatasetEvents := Value;
  if not Assigned(fFormLines) then Exit;
  fFormLines.ApplyDatasetEvents := Value;
end;

function TBusObjBudget.getClassName(ClassId: integer): string;
begin
  Result := '';
  if QryClass.Locate('ClassId', ClassId, []) then Result := QryClass.FieldByName('ClassName').AsString;
end;

procedure TBusObjBudget.PopulateTmpTable;
var
  AccID: integer;
  JobId: integer;
  BudgetDate: TDateTime;
begin
  if not Assigned(fbBudgetDef) then Exit;
  if TableName = '' then Exit;

  fbBudgetDef.BudgetClasses.DataSet.First;
      With getNewDataset('Select * from ' + TableName + ' Order by AccountName' , True) do try

      BudgetPeriodLines.First;

      AccId := 0;
      BudgetDate := 0;
      JobId := 0;
      while foBudgetPeriodLines.Eof = false do begin
        if (AccId = foBudgetPeriodLines.FieldByName('AccountID').AsInteger) and
          (BudgetDate = foBudgetPeriodLines.FieldByName('budgetDate').AsDateTime) and
          (JobId = foBudgetPeriodLines.FieldByName('JobID').AsInteger) then begin
          if not (State in [dsEdit, dsInsert]) then Edit;
          FieldByName(Trim(getClassName(foBudgetPeriodLines.FieldByName('ClassId').AsInteger)) + '_amt1').AsFloat :=
            foBudgetPeriodLines.FieldByName('Amount1').AsFloat;
          FieldByName(Trim(getClassName(foBudgetPeriodLines.FieldByName('ClassID').AsInteger)) + '_amt2').AsFloat :=
            foBudgetPeriodLines.FieldByName('Amount2').AsFloat;
          if foBudgetPeriodLines.FieldByName('Active').AsBoolean = false then FieldByName('Active').AsBoolean := false;
          foBudgetPeriodLines.Next;
        end else begin
          if State in [dsEdit, dsInsert] then Post;
          append;
          FieldByName('ForDate').AsString := foBudgetPeriodLines.FieldByName('ForDate').AsString;
          if FieldByName('ForDate').AsBoolean then FieldByName('BudgetDate').AsDateTime :=
              foBudgetPeriodLines.FieldByName('BudgetDate').AsDateTime;
          FieldByName('AccountID').AsInteger := foBudgetPeriodLines.FieldByName('AccountId').AsInteger;
          FieldByName('AccountNumber').AsString := getaccountnumber(FieldByName('AccountID').AsInteger);
          FieldByName('JobID').AsInteger := foBudgetPeriodLines.FieldByName('JobId').AsInteger;
          FieldByName('Active').AsBoolean := True;
          FieldByName('SortID').AsInteger:= foBudgetPeriodLines.FieldByName('SortId').AsInteger;
          AccId := foBudgetPeriodLines.FieldByName('AccountId').AsInteger;
          JobId := foBudgetPeriodLines.FieldByName('JobId').AsInteger;
          BudgetDate := foBudgetPeriodLines.FieldByName('budgetDate').AsDateTime;
          post;
        end;
      end;
      if State in [dsEdit, dsInsert] then Post;
      fFormlines.SetLineFields;
    finally
      if Active then Close;
      Free;
    end;
end;

function TBusObjBudget.getAmt1Label: string;
begin
  Result := '';
  if not Assigned(BudgetDefinition) then Exit;
  Result := Budgetdefinition.Amount1Label;
end;

function TBusObjBudget.getShowAmount1: boolean;
begin
  Result := false;
  if not Assigned(BudgetDefinition) then Exit;
  Result := Budgetdefinition.ShowAmount1 = 'T';
end;

function TBusObjBudget.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  if fbApplyDatasetEvents = false then begin
    Result := true;
    Exit;
  end;

  Sender.Dataset.FieldByName('Active').AsBoolean := true;
  if Assigned(BudgetDefinition) then Sender.Dataset.FieldByName('BudgetId').AsInteger := BudgetDefinition.ID;
  Result := true;
end;
Procedure TBusObjBudget.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
Try
    if Assigned(foBudgetPeriodLines) then begin
        if foBudgetPeriodLines.Active then foBudgetPeriodLines.Close;
        Freeandnil(foBudgetPeriodLines);
    end;
    if assigned(fLines) then
        if fLines.Dataset.Active then
            fLines.Dataset.close;

    if Assigned(fFormLines) then
        if fFormLines.Dataset.Active then
            fFormLines.Dataset.Close;

    if assigned(fbBudgetDef) then begin
        if fbBudgetDef.Dataset.Active then
            fbBudgetDef.Close;
        Freeandnil(fbBudgetDef);
    end;
   if Assigned(foBudgetNos) then if not foBudgetNos.IsEmpty then if foBudgetNos.Count > 0 then begin
      foBudgetNos.IsEmpty := True;
      foBudgetNos.Clear;
   end;
Except
    //foBudgetNos is a collection and
    //if the collection is not created, assigned(TBudgetNos) creates an exception :(
    //Kill the exception here
End;
end;
function TBusObjBudget.getQryClass: TERPQuery;
begin
  if not Assigned(fQryClass) then begin
    fQryClass := TERPQuery.Create(Self);
    fQryClass.Options.FlatBuffers := True;
    fQryClass.Connection := Self.Connection.Connection;
    fQryClass.SQL.add('Select ClassId, ClassName from tblClass');
    fQryClass.Open;
  end;
  if fQryClass.Active = false then fQryClass.Open;
  Result := fQryClass;
end;

function TBusObjBudget.getShowAmount2: boolean;
begin
  Result := false;
  if not Assigned(BudgetDefinition) then Exit;
  Result := Budgetdefinition.ShowAmount2 = 'T';
end;

function TBusObjBudget.getAmt2Label: string;
begin
  Result := '';
  if not Assigned(BudgetDefinition) then Exit;
  Result := Budgetdefinition.Amount2Label;
end;

function TBusObjBudget.IsHeaderValid: boolean;
begin
  Result := false;
  if BudgetId = 0 then begin
    InvalidMsg   := 'Budget definition should not be blank';
    Exit;
  end;
  if BudgetNo = 0 then begin
    InvalidMsg   := 'Budget no should not be blank';
    Exit;
  end;
  Result := true;
end;

{Calculates Colum wise total for the footer of the grid.
The totals are stored in a dynamic array as the number of
columns is dynamic based on the budget classes}
procedure TBusObjBudget.CalcTotal;
var
  Ctr: integer;
  bm: TBookMark;
  ClassName: string;
begin
  if not Assigned(fFormLines) then Exit;
  if not Assigned(budgetDefinition) then Exit;
  if not Assigned(BudgetDefinition.BudgetClasses) then Exit;
  if BudgetDefinition.BudgetClasses.Dataset.RecordCount = 0 then Exit;

  fFormLines.Dataset.DisableControls;
  bm := fFormLines.Dataset.GetBookmark;
  try
    fFormLines.Dataset.First;
    FooterTotals1 := nil;
    FooterTotals2 := nil;
    while fFormLines.Dataset.Eof = false do begin
      BudgetDefinition.BudgetClasses.Dataset.First;
      ctr := 0;
      while BudgetDefinition.BudgetClasses.Dataset.Eof = false do begin
        if BudgetDefinition.BudgetClasses.Dataset.FieldByName('active').AsBoolean then begin
          if High(FooterTotals1) < ctr then begin
            Setlength(FooterTotals1, ctr + 1);
            FooterTotals1[ctr] := 0;
          end;
          if High(FooterTotals2) < ctr then begin
            Setlength(FooterTotals2, ctr + 1);
            FooterTotals2[ctr] := 0;
          end;
          ClassName := getClassName(BudgetDefinition.BudgetClasses.Dataset.FieldByName('ClassId').AsInteger);
          if fFormLines.Dataset.FindField(ClassName + '_AMT1') <> nil then
            FooterTotals1[ctr] := FooterTotals1[ctr] + fFormLines.Dataset.FieldByName(ClassName + '_AMT1').AsFloat;
          if fFormLines.Dataset.FindField(ClassName + '_AMT2') <> nil then
            FooterTotals2[ctr] := FooterTotals2[ctr] + fFormLines.Dataset.FieldByName(ClassName + '_AMT2').AsFloat;
          ctr := ctr + 1;
        end;
        BudgetDefinition.BudgetClasses.Dataset.Next;
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

function TBusObjBudget.AccountnameUnique(AccId, Id, JobId: integer): boolean;
var
    strSQL:String;
begin
      strSQl := 'Select * from ' + TableName;
      strSQl := strSQL + ' Where AccountId = ' + IntToStr(AccId);
      strSQl := strSQL + ' and JobId = ' + IntToStr(JobID);
      strSQl := strSQL + ' and Active = ''T'' and ForDate = ''F'' and Id <> ' + IntToStr(ID);
    With getNewDataset(strSQL , TRue) do try
      Result := RecordCount = 0;
    finally
      if Active then Close;
      Free;
    end;
end;

function TBusObjBudget.AccountnameUnique(AccId, Id, JobID: integer; BudgetDate: TDateTime): boolean;
var
    strSQL :String;
begin
      strSQL := ' Select * from ' + TableName;
      strSQL := strSQL + ' Where AccountId = ' + IntToStr(AccId);
      strSQL := strSQL + ' and JobId = ' + IntToStr(JobId);
      strSQL := strSQL + ' and Active = ''T'' and Id <> ' + IntToStr(ID);
      strSQL := strSQL + ' and BudgetDate = ' + QuotedStr(FormatDateTime('yyyy/mm/dd', BudgetDAte));
    With getNewDataset(strSQL , TRue) do try
      Result := RecordCount = 0;
    finally
      if Active then Close;
      Free;
    end;
end;

procedure TBusObjBudget.OpenLines;
var
  QryAccounts: TERPQuery;
  qryJobs: TERPQuery;

  function getAccountName(const AccID: integer): string;
  begin
    Result := '';
    if QryAccounts.locate('AccountId', AccId, []) then Result := QryAccounts.FieldByName('AccountName').AsString;
  end;

  function getJobName(const JobId: integer): string;
  begin
    Result := '';
    if qryJobs.locate('ClientID', JobId, []) then Result := qryJobs.FieldByName('Company').AsString;
  end;
begin
  if TableName = '' then Exit;
  (*FormLines.TableName := TableName;*)
  if FormLines.OpenLines() then PopulateTmpTable;

  if not Assigned(fFormLines) then Exit;

  with fFormLines.Dataset do begin
    if RecordCount = 0 then Exit;
    QryAccounts := TERPQuery.Create(Self);
    QryAccounts.Options.FlatBuffers := True;
    QryJobs := TERPQuery.Create(Self);
    QryJobs.Options.FlatBuffers := True;
    try
      QryAccounts.Connection := Self.Connection.Connection;
      QryAccounts.SQL.add('Select AccountId , Accountname  from tblChartofAccounts ');
      QryAccounts.Open;

      QryJobs.Connection := Self.Connection.Connection;
      QryJobs.SQL.add('select ClientID   , JobNumber  , JobName, Company   from tblclients ');
      QryJobs.Open;

      First;
      while Eof = false do begin
        Edit;
        FieldByName('AccountName').AsString := getAccountName(FieldByName('AccountId').AsInteger);
        FieldByName('JobName').AsString := getJobname(FieldByName('JobId').AsInteger);
        fFormLines.CalcTotal;
        Post;
        Next;
      end;
    finally
      if QryAccounts.Active then QryAccounts.Close;
      FreeandNil(QryAccounts);

      if qryJobs.Active then qryJobs.Close;
      FreeandNil(qryJobs);
    end;
  end;
end;

function TBusObjBudget.IsValidData: boolean;

  function HasActiveLines: boolean;
  begin
    result:= false;
    fFormLines.Dataset.DisableControls;
    try
      fFormLines.Dataset.First;
      while not fFormLines.Dataset.Eof do begin
        if fFormLines.Dataset.FieldByName('Active').AsBoolean then begin
          result:= true;
          break;
        end;
        fFormLines.Dataset.Next;
      end;
    finally
      fFormLines.Dataset.EnableControls;
    end;
  end;


begin
  Result := false;
  if IsHeaderValid = false then Exit;
  if Assigned(fFormLines) then begin
    fFormLines.Postdb;
      if fFormLines.IsValidData = false then Exit;
      if not HasActiveLines then begin
        InvalidMsg := 'Detail records are not created - should have at least one record';
        Exit;
      end;
  end;
  Result := true;
end;

function TBusObjBudget.Save: boolean;
begin
  Result := false;
  foBudgetSaved := false;
  PostDB;
  if IsValidData = false then begin
    if InvalidMsg <> '' then ResultStatus.AddItem(false, rssWarning, 0, InvalidMsg);
    Exit;
  end;
  if Assigned(fFormLines) then fFormLines.Save;
  if fbCommitOnSave then Connection.CommitTransaction;
  Dirty := false;
  Lines.Dirty := False;
  foBudgetSaved := true;
  Result := true;
end;

function TBusObjBudget.GetSQL: string;
begin
  Result := '';
  if fSQL = '' then fSQL := 'Select * from tblBudgetPeriods';
  REsult := Inherited GetSQL;
end;

function TBusObjBudget.ChangePeriod(VariationOption, VariationType: integer; VariationAmt: double): boolean;
begin
  try
    with TERPQuery.Create(Self) do try
        Options.FlatBuffers := True;
        Connection := Self.Connection.Connection;
        if Assigned(fSelectedAccounts) then begin
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)+TmpTableName.VarAmount');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)+TmpTableName.VarAmount');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)+IFNULL(tblBudgetLines.Conservative,0)*TmpTableName.VarAmount/100 ');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)+IFNULL(tblBudgetLines.Aggressive,0)*TmpTableName.VarAmount/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)-TmpTableName.VarAmount');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)-TmpTableName.VarAmount');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Conservative = IFNULL(tblBudgetLines.Conservative,0)-IFNULL(tblBudgetLines.Conservative,0)*TmpTableName.VarAmount/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetLines.Aggressive = IFNULL(tblBudgetLines.Aggressive,0)-IFNULL(tblBudgetLines.Aggressive,0)*TmpTableName.VarAmount/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)+TmpTableName.VarAmount ');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)+TmpTableName.VarAmount');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId ');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)+IFNULL(tblBudgetPeriodLines.Amount1,0)*TmpTableName.VarAmount/100 ');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)+IFNULL(tblBudgetPeriodLines.Amount2,0)*TmpTableName.VarAmount/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "I"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)-TmpTableName.VarAmount');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)-TmpTableName.VarAmount');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="D"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount1 = IFNULL(tblBudgetPeriodLines.Amount1,0)-IFNULL(tblBudgetPeriodLines.Amount1,0)*TmpTableName.VarAmount/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;                              
            SQL.add('update tblBudgetPeriodLines,  '+ fsTmpTableName + ' as TmpTableName ' );
            SQL.add('Set tblBudgetPeriodLines.Amount2 = IFNULL(tblBudgetPeriodLines.Amount2,0)-IFNULL(tblBudgetPeriodLines.Amount2,0)*TmpTableName.VarAmount/100');
            SQL.add('where');
            SQL.add('TmpTableName.AccountId = tblBudgetPeriodLines.AccountId');
            SQL.add('and TmpTableName.RecSelected = "T"');
            SQL.add('and TmpTableName.IncDec = "D"');
            SQL.add('and TmpTableName.VarType ="P"');
            SQL.add('and tblBudgetPeriodLines.BudgetPeriodID = ' + IntToStr(self.Id));
            SQL.add(';');
            Execute;
            SQL.clear;
        end else begin
                Sql.add('update tblBudgetLines ');
                if VariationOption = 0 then begin //increased by
                  if VariationType = 0 then begin //Dollars
                    SQL.add('set Conservative = IFNULL(Conservative,0) + ' + FloatToStr(VariationAmt) + '');
                  end else if VariationType = 1 then begin //%age
                    SQL.add('set Conservative = IFNULL(Conservative,0) + IFNULL(Conservative,0) *' + FloatToStr(VariationAmt) + '/100');
                  end;
                end else if VariationOption = 1 then begin // decreased by
                  if VariationType = 0 then begin          //Dollars
                    SQL.add('set Conservative = IFNULL(Conservative,0) - ' + FloatToStr(VariationAmt) + '');
                  end else if VariationType = 1 then begin //%age
                    SQL.add('set Conservative = IFNULL(Conservative,0) - IFNULL(Conservative,0) *' + FloatToStr(VariationAmt) + '/100');
                  end;
                end;
                SQL.add(' where BudgetPeriodID = ' + IntToStr(self.Id));
                SQL.add(' ;');
                Execute;
            SQL.clear;
                {update Aggressive amount}
                SQL.Clear;
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
                SQL.add(' where BudgetPeriodID = ' + IntToStr(self.Id));
                SQL.add(' ;');
                Execute;
            SQL.clear;
                {update period lines - amount1}
                SQL.Clear;
                Sql.add('update tblBudgetPeriodLines ');
                if VariationOption = 0 then begin //increased by
                  if VariationType = 0 then begin //Dollars
                    SQL.add('set Amount1 = IFNULL(amount1,0) + ' + FloatToStr(VariationAmt) + '');
                  end else if VariationType = 1 then begin //%age
                    SQL.add('set Amount1 = IFNULL(amount1,0) + IFNULL(amount1,0) *' + FloatToStr(VariationAmt) + '/100');
                  end;
                end else if VariationOption = 1 then begin // decreased by
                  if VariationType = 0 then begin          //Dollars
                    SQL.add('set Amount1 = IFNULL(amount1,0) - ' + FloatToStr(VariationAmt) + '');
                  end else if VariationType = 1 then begin //%age
                    SQL.add('set amount1 = IFNULL(amount1,0) - IFNULL(amount1,0) *' + FloatToStr(VariationAmt) + '/100');
                  end;
                end;
                SQL.add(' where BudgetPeriodID = ' + IntToStr(self.Id));
                SQL.add(' ;');
                Execute;
            SQL.clear;
                {update periodlines - amount 2}
                SQL.Clear;
                Sql.add('update tblBudgetPeriodLines ');
                if VariationOption = 0 then begin //increased by
                  if VariationType = 0 then begin //Dollars
                    SQL.add('set Amount2 = IFNULL(amount2,0) + ' + FloatToStr(VariationAmt));
                  end else if VariationType = 1 then begin //%age
                    SQL.add('set Amount2 = IFNULL(amount2,0) + IFNULL(amount2,0) *' + FloatToStr(VariationAmt) + '/100');
                  end;
                end else if VariationOption = 1 then begin // decreased by
                  if VariationType = 0 then begin          //Dollars
                    SQL.add('set Amount2 = IFNULL(amount2,0) - ' + FloatToStr(VariationAmt));
                  end else if VariationType = 1 then begin //%age
                    SQL.add('set Amount2 = IFNULL(amount2,0) - IFNULL(amount2,0) *' + FloatToStr(VariationAmt) + '/100');
                  end;
                end;
                SQL.add(' where  BudgetPeriodID = ' + IntToStr(self.Id));
                SQL.add(' ;');
                Execute;
            SQL.clear;
            end;
            Result := true;
        finally
            if Active then Close;
            Free;
        end;
  except
    Result := false;
  end;
end;

//========================================================//
function TBusObjFormLines.IsAmtField(const FieldName: string): boolean;
begin
  Result := false;
  if uppercase(Copy(FieldName, char_length(fieldName) - 4, 4)) = '_AMT' then
    if uppercase(Copy(FieldName, 1, 12)) <> 'ALLCLASS_AMT' then Result := true;
end;
function TBusObjFormLines.AmtName(const FieldName: string): String;
begin
  Result := Copy(FieldName , 1 , char_length(FieldName)-1);
end;
function TBusObjFormLines.GetOwnerbudget:TBusObjBudget;
begin
    if not assigned(foOwnerBudget) then
        if Assigned(self.Owner) then
            if Self.Owner is TBusObjBudget then
                foOwnerBudget := TBusObjBudget(Self.Owner);
    Result := foOwnerBudget;
end;
function TBusObjFormLines.GetId: integer;
begin
  Result := GetIntegerField(IDFieldName);
end;
class Function TBusObjFormLines.GetIDField :String ;
begin
    Result :='ID';
end;

class function TBusObjFormLines.GetBusObjectTablename: string;
begin
  Result := '';
end;

procedure TBusObjFormLines.DoFieldOnChange(Sender: TField);
begin
  InvalidMsg := '';
    {data for the line is populated from the tables when the object is loaded.
    This code should be executed when the user changes the recordpointer}
  if fbApplyDatasetEvents = false then Exit;

  {Changing the amount field calcualtes the rowwise total}
  if IsAmtField(Sender.FieldName) then begin
    CalcTotal;
    fbAmountChanged := true;
    Exit;
  end;
  if (uppercase(Sender.FieldName) = uppercase('AccountId')) then begin
      Dataset.fieldbyname('AccountNumber').asString := GetAccountNumber(Sender.Value);
  end;
  {for the range the account name can be selected only once }
  if uppercase(Sender.FieldName) = uppercase('ForDate') then begin
    if not RawMode then begin
      if not foOwnerBudget.AccountnameUnique(Dataset.FieldByName('AccountId').AsInteger,
        Dataset.FieldByName('Id').AsInteger,
        Dataset.FieldByName('JobID').AsInteger) then begin
        EditDB;
        Dataset.FieldByName('ForDate').AsBoolean := true;
      end;

      if Dataset.FieldByName('ForDate').AsBoolean = false then begin
        Dataset.Findfield('BudgetDate').ReadOnly := false;
        EditDB;
        Dataset.Findfield('BudgetDate').AsVariant := null;
      end;
      Dataset.Findfield('BudgetDate').ReadOnly :=  False;
      EditDB;
      if Dataset.FieldByName('ForDate').AsBoolean <> True then
          Dataset.Findfield('BudgetDate').AsVariant := null
      else
          if Dataset.Findfield('BudgetDate').AsDateTime = 0 then
              Dataset.Findfield('BudgetDate').AsDateTime := foOwnerBudget.getNextBudgetDate;
      Dataset.Findfield('BudgetDate').ReadOnly :=
        Dataset.FieldByName('ForDate').AsBoolean = false;
      Exit;
    end;
  end;
  if (uppercase(Sender.FieldName) = uppercase('AccountName')) or
    (uppercase(Sender.FieldName) = uppercase('AccountId')) or
    (uppercase(Sender.FieldName) = uppercase('JobId')) or
    (uppercase(Sender.FieldName) = uppercase('JobName')) then begin
    if not RawMode then begin
      if Dataset.FieldByName('ForDate').AsString = 'T' then begin
        if foOwnerBudget.AccountnameUnique(Dataset.FieldByName('AccountId').AsInteger,
          Dataset.FieldByName('Id').AsInteger,
          Dataset.FieldByName('JobID').AsInteger,
          Dataset.FieldByName('BudgetDate').AsDateTime) then Exit;
      end else if foOwnerBudget.AccountnameUnique(Dataset.FieldByName('AccountId').AsInteger,
        Dataset.FieldByName('Id').AsInteger,
        Dataset.FieldByName('JobID').AsInteger) then Exit;

      EditDB;
      Dataset.FieldByName('ForDate').AsBoolean := true;
      Dataset.Findfield('BudgetDate').ReadOnly := false;
      if Assigned(foOwnerBudget) then
          if foOwnerBudget.getNextBudgetDate <> 0 then begin
              EditDB;
              Dataset.FieldByName('BudgetDate').AsDateTime := foOwnerBudget.getNextBudgetDate;
          end else Dataset.Cancel;
      Exit;
    end;
  end;
end;

procedure TBusObjFormLines.CalcTotal;
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
    if FindField('AllClass_Amt1') <> nil then FieldByName('AllClass_Amt1').AsFloat := Amt1;
    if FindField('AllClass_Amt1') <> nil then FindField('AllClass_Amt1').ReadOnly := true;

    if FindField('AllClass_Amt2') <> nil then FindField('AllClass_Amt2').ReadOnly := false;
    if FindField('AllClass_Amt2') <> nil then FieldByName('AllClass_Amt2').AsFloat := Amt2;
    if FindField('AllClass_Amt2') <> nil then FindField('AllClass_Amt2').ReadOnly := true;
  end;
end;

function TBusObjFormLines.IsRecBlank: boolean;
var
  ctr: integer;
begin
  Result := true;
  with Dataset do begin
    if FieldByName('AccountID').AsInteger <> 0 then Result := false;
    if Result = false then Exit;

    for ctr := 0 to FieldCount - 1 do if IsAmtField(Fields[ctr].Fieldname) then
        if FieldByName(Fields[ctr].Fieldname).AsFloat <> 0 then Result := false;
  end;
end;

function TBusObjFormLines.IsValidData: boolean;
begin
  Result := false;
  {Blank record is deleted at after post.}
  if not IsRecBlank then if DataSet.FieldByName('AccountID').AsInteger = 0 then begin
      InvalidMsg := 'Account should not be blank';
      Exit;
    end;
  if Dataset.FieldByName('ForDate').AsBoolean then begin
    if (Dataset.FieldByName('BudgetDate').AsDateTime < foOwnerBudget.Dataset.FieldByName('StartDate').AsDateTime) or
      (Dataset.FieldByName('BudgetDate').AsDateTime > foOwnerBudget.Dataset.FieldByName('EndDate').AsDateTime) then begin
      InvalidMsg := 'Budget date should be within the period of the selected Budget number (' +
        FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, OwnerBudget.Dataset.FieldByName('StartDate').AsDateTime) + ' to ' +
        FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, OwnerBudget.Dataset.FieldByName('EndDate').AsDateTime) + ')';
      Exit;
    end;
    if not foOwnerBudget.AccountnameUnique(Dataset.FieldByName('AccountId').AsInteger,
      Dataset.FieldByName('Id').AsInteger, 
      Dataset.FieldByName('JobID').AsInteger,
      Dataset.FieldByName('BudgetDate').AsDateTime) then begin
      InvalidMsg := 'Record for this date already exists';
      Exit;
    end;
  end;
  Result := true;
end;

function TBusObjFormLines.OpenLines: boolean;
begin
  Result := false;
  if TableName = '' then Exit;
  CreateTmpTable;
  if Dataset.Active then Dataset.Close;
  SQL := 'Select ' + getBudgetLinefields() + ' from ' + TableName; // + ' Order by AccountName';
  DatasetActive := true;
  Dataset.Filter := 'Active <> ''F'' ';
  Dataset.Filtered := True;
  SetLineFields;
  Result := true;
end;

procedure TBusObjFormLines.SetLineFields;
var
  ctr: integer;
begin
  with Dataset do begin
    if Dataset.Active then Dataset.Close;
    DatasetActive := true;
    {Set the display label of fields as the fields are created dynamically}
    for ctr := 0 to FieldCount - 1 do begin
      if uppercase(Fields[ctr].Fieldname) = 'ACCOUNTNAME' then Fields[ctr].Displaylabel := 'Account Name'
      else if uppercase(Fields[ctr].Fieldname) = 'FORDATE' then Fields[ctr].Displaylabel := 'For Date'
      else if uppercase(Fields[ctr].Fieldname) = 'BUDGETDATE' then Fields[ctr].Displaylabel := 'Budget Date'
      else if uppercase(Fields[ctr].Fieldname) = 'JOBNAME' then Fields[ctr].Displaylabel := 'Job Name'
      else if uppercase(Copy(Fields[ctr].Fieldname, char_length(Fields[ctr].Fieldname) - 4, 5)) = '_AMT1' then begin
        if uppercase(Fields[ctr].Fieldname) = 'ALLCLASS_AMT1' then
            Fields[ctr].Displaylabel := 'All class~' + OwnerBudget.Amt1Label
        else
            Fields[ctr].Displaylabel := Copy(Fields[ctr].Fieldname, 1, char_length(Fields[ctr].Fieldname) - 5) +
                '~' + OwnerBudget.Amt1Label;
        TFloatField(Fields[ctr]).currency := true;
      end else if uppercase(Copy(Fields[ctr].Fieldname, char_length(Fields[ctr].Fieldname) - 4, 5)) = '_AMT2' then begin
        if uppercase(Fields[ctr].Fieldname) = 'ALLCLASS_AMT2' then
            Fields[ctr].Displaylabel := 'All Class~' + OwnerBudget.Amt2Label
        else
            Fields[ctr].Displaylabel := Copy(Fields[ctr].Fieldname, 1, char_length(Fields[ctr].Fieldname) - 5) +
                '~' + OwnerBudget.Amt2Label;
        TFloatField(Fields[ctr]).currency := true;
      end;
    end;
    {hide ID fields}
    FindField('ID').Visible           := false;
    FindField('AccountID').Visible    := false;
    FindField('JobID').Visible        := false;
    FindField('Active').Visible       := false;
    FindField('Jobname').Visible      := false;
    FindField('Accountname').DisplayWidth := 30;
    FindField('BudgetDate').DisplayWidth := 15;
    FindField('Jobname').DisplayWidth := 20;
    if FindField('AllClass_Amt1') <> nil then FindField('AllClass_Amt1').ReadOnly := true;
    if FindField('AllClass_Amt2') <> nil then FindField('AllClass_Amt2').ReadOnly := true;
    if RecordCount = 0 then Exit;
  end;
end;

function TBusObjFormLines.getQryClass: TERPQuery;
begin
  if not Assigned(fQryClass) then begin
    fQryClass := TERPQuery.Create(Self);
    fQryClass.Options.FlatBuffers := True;
    fQryClass.Connection := Self.Connection.Connection;
    fQryClass.SQL.add('Select ClassId, ClassName from tblClass');
    fQryClass.Open;
  end;
  if fQryClass.Active = false then fQryClass.Open;
  Result := fQryClass;
end;

procedure TBusObjFormLines.CreateTmpTable;
var
  strClassname: string;
  strSQL :STring;
begin
  if TableName = '' then Exit;
  strSql:= 'DROP TABLE IF EXISTS ' + TableName;
  getNewDataset(strSQL);
    strSql:= 'CREATE TABLE IF NOT EXISTS ' + TableName + ' (';
    strSql:= STRsql + ' ID int(10) NOT NULL auto_increment,';
    strSql:= STRsql +' AccountId int(10) , ';
    strSql:= STRsql +' AccountNumber varchar(100) , ';
    strSql:= STRsql +' AccountName varchar(100) , ';
    strSql:= STRsql +' JobId int(10) , ';
    strSql:= STRsql +' JobName varchar(100) , ';
    strSql:= STRsql +' BudgetDate DateTime , ';
    strSql:= STRsql +' ForDate ENUM(''T'',''F'')  DEFAULT "F", ';
     QryClass.First;
      while QryClass.Eof = false do begin
        strClassName := QryClass.FieldByName('ClassName').AsString;
        strSql:= STRsql +' `' + Trim(strClassName) + '_amt1` double, ';
        strSql:= STRsql +' `' + Trim(strClassName) + '_amt2` double,';
        QryClass.Next;
      end;
  strSql:= STRsql +' `AllClass_Amt1` double,';
  strSql:= STRsql +' `AllClass_Amt2` double,';
  strSql:= STRsql +' Active ENUM(''T'',''F'')  DEFAULT "T",';
  strSql:= STRsql +' SortID Int(10),';
  strSql:= STRsql +' PRIMARY KEY  (ID) ';
  strSql:= STRsql +'  ) ENGINE=InnoDB';
  getNewDataset(strSQL);
end;

procedure TBusObjFormLines.CalcTotalAll;
begin
    Dataset.First;
    while Dataset.eof = False do begin
        CalcTotal;
        Dataset.next;
    end;
end;
function TBusObjFormLines.getBudgetLinefields: string;
begin
  Result := '';
  Result := 'ID, AccountId, AccountName ,Accountnumber, JobId, JobName, ForDate, BudgetDate, ';
  if Assigned(OwnerBudget) then begin
    if Assigned(OwnerBudget.BudgetDefinition) then begin
      OwnerBudget.BudgetDefinition.BudgetClasses.Dataset.First;
      with OwnerBudget.BudgetDefinition.BudgetClasses.Dataset do begin
        while Eof = false do begin
          if FieldByName('Active').AsBoolean then begin
            if OwnerBudget.ShowAmount1 then Result := Result + '`' + getClassName(FieldByName('ClassId').AsInteger) +
                '_Amt1`,';
            if OwnerBudget.ShowAmount2 then Result := Result + '`' + getClassName(FieldByName('ClassId').AsInteger) +
                '_Amt2`,';
          end;
          Next;
        end;
      end;
    end;
    if OwnerBudget.ShowAmount1 then Result := Result + '`AllClass_Amt1` , ';
    if OwnerBudget.ShowAmount2 then Result := Result + '`AllClass_Amt2` , ';
  end;
  Result := Result + 'Active, SortID ';
end;

function TBusObjFormLines.Save: boolean;
var
  qrySQL                : TERPQuery;
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
  dEndDate              : TDAtetime;
  FieldCtr              : Integer;
  FirstREc              : boolean;

Procedure  LoadClassArray;
    var
        arrayLoop :Integer;
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
  function GetClassID(FieldName: string): integer;
    var
        arrayLoop :Integer;
  begin
    REsult := 0;
    FieldName := Copy(FieldName, 1, char_length(fieldName) - 5);
    For arrayLoop := Low(classes) to high(Classes) do
        if classes[arrayLoop] = FieldName then begin
            Result := ClassId[arrayLoop];
            Exit;
        End;
  end;
begin
  result:= true;
  tblBudgetLines:=TStringList.Create;
  tblbudgetperiodlines:=TStringList.Create;
  qrySQL := TERPQuery.Create(Self);
  qrySQL.Options.FlatBuffers := True;
  try
    qrySQL.Connection := Self.Connection.Connection;
    qrySQL.SQL.add('Delete from tblBudgetPeriodLines ');
    qrySQL.SQL.add('where BudgetPeriodId = ');
    qrySQL.SQL.add(IntToStr(OwnerBudget.GetId));
    qrySQL.Execute;
    qrySQL.SQL.Clear;

    qrySQL.Connection := Self.Connection.Connection;
    qrySQL.SQL.add('Delete from tblBudgetLines ');
    qrySQL.SQL.add('where BudgetPeriodId = ');
    qrySQL.SQL.add(IntToStr(OwnerBudget.GetId));
    qrySQL.Execute;
    LoadClassArray;
    with Dataset do begin
      First;
      if eof then
        exit;
      Setlength(AmtFields , 2);
      Col := 0;
      for FieldCtr := 0 to FieldCount - 1 do  begin
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
      tblBudgetLines.add('INSERT HIGH_PRIORITY INTO tblBudgetLines (ClassId,AccountId, JobId, Date, BudgetId, BudgetPeriodID, Fordate, Aggressive, Conservative, Active)  values ');
      tblbudgetperiodlines.add('INSERT HIGH_PRIORITY INTO tblbudgetperiodlines (BudgetPeriodId, BudgetID, ClassId,AccountId, jobID, ForDate, BudgetDate, Amount1, Amount2, Active, SortID) Values');
      FirstREc := True;
      while Eof = false do begin
        {tblbudgetperiodlines}
        for ctr := low(AmtFields[0]) to high(AmtFields[0]) do begin
            strSql := '(' + IntToStr(foOwnerBudget.GetId) +  ',' +
                            IntToStr(foOwnerBudget.BudgetDefinition.Id) + ',' +
                            IntToStr(GetClassID(AmtFields[0,ctr])) +',' +
                            IntToStr(Dataset.FieldByName('AccountId').AsInteger) +',' +
                            IntToStr(Dataset.FieldByName('JobId').AsInteger) +',' +
                            quotedStr(FieldByName('ForDate').asString)  ;
            if FieldByName('ForDate').asString = 'F' then
                strSql := strSql + ',null'
            else strSql := strSql + ',' + quotedStr(FormatDatetime(MysqlDateFormat , FieldByName('BudgetDate').AsDateTime));
            if AmtFields[0,ctr] <> '' then
                    strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[0,ctr]).AsFloat )
            else strSql := strSql + ',0';
            if AmtFields[1,ctr] <> '' then
                    strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[1,ctr]).AsFloat )
            else strSql := strSql + ',0';
            strSql := strSql + ',' + QuotedStr(BooleanToStr(Dataset.FieldByName('Active').AsBoolean));
            strSql := strSql + ',' + IntToStr(Dataset.FieldByName('SortID').AsInteger) +')';
            if (not FirstREc) or (ctr<> 0) then tblbudgetperiodlines.add(',');
            tblbudgetperiodlines.add(strSQL);
        end;
         {budgetLines}
         if Dataset.fieldbyname('Fordate').asBoolean then begin
            dStartDate :=FieldByName('budgetDate').AsDateTime;
            dEndDate :=FieldByName('budgetDate').AsDateTime;
         end else begin
            dStartDate :=DateOf(foOwnerBudget.StartDAte);
            dEndDate :=DateOf(foOwnerBudget.EndDate);
         end;
        noOfDays := DaysBetween( DateOf(dStartDate) , DateOf(dEndDate) ) + 1;

        while dStartDate <=  dendDate do begin
            for ctr := low(AmtFields[0]) to high(AmtFields[0]) do begin
                StrSQl := '('+ IntToStr(GetClassID(AmtFields[0,ctr])) + ',' +
                           IntToStr(Dataset.FieldByName('AccountId').AsInteger) +',' +
                           IntToStr(Dataset.FieldByName('JobId').AsInteger) +',' +
                           QuotedStr(FormatDateTime(MysqlDateFormat , dStartDate)) +',' +
                           IntToStr(foOwnerBudget.BudgetId) +',' +
                           IntToStr(foOwnerBudget.GetId) + ',' +
                           QuotedStr(Dataset.fieldbyname('Fordate').asString);
                if AmtFields[0,ctr] <> '' then
                    strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[0,ctr]).AsFloat / noOfDays)
                else strSql := strSql + ',0';
                if AmtFields[1,ctr] <> '' then
                    strSql := strSql + ',' + FloatToStr(Dataset.FieldByName(AmtFields[1,ctr]).AsFloat / noOfDays)
                else strSql := strSql + ',0';
                strSql := strSql + ',' + QuotedStr(BooleanToStr(Dataset.FieldByName('Active').AsBoolean)) +')';
                if (not FirstREc) or (ctr<> 0) then tblBudgetLines.add(',');
                tblBudgetLines.add(strSQL);
                FirstREc:= False;
            end;
            dStartDate := incDay(dStartDate);
        end;

        Next;
      end;
    end;
    qrySQL.SQL.clear;
    qrySQL.SQL.Text:= tblBudgetLines.Text;
    qrySQL.Execute;
    qrySQL.SQL.clear;
    qrySQL.SQL.Text := tblbudgetperiodlines.Text;
    qrySQL.Execute;
    Result := true;
  finally
    FreeandNil(qrySQL);
    if Assigned(tblBudgetLines)       then FreeandNil(tblBudgetLines);
    if Assigned(tblbudgetperiodlines)       then FreeandNil(tblbudgetperiodlines);
  end;
end;

function TBusObjFormLines.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
    {data for the line is populated from the tables when the object is loaded.
    This code should be executed when the user creates the record, not when
    the program populates the data in the temporary table}
  if (fbApplyDatasetEvents = false) or (Sender.Dataset.FieldByName('Active').AsBoolean = false) then begin
    Result := true;
    Exit;
  end;

  if IsValidData = false then begin
    if InvalidMsg <> '' then ResultStatus.AddItem(false, rssWarning, 0, InvalidMsg);
    Result := false;
    Abort;
    Exit;
  end;

  Result := true;
end;

function TBusObjFormLines.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
    {data for the line is populated from the tables when the object is loaded.
    This code should be executed when the user creates the record}
  if fbApplyDatasetEvents = false then begin
    Result := true;
    Exit;
  end;
  Sender.Dataset.FieldByName('Active').AsBoolean := true;
  Sender.Dataset.FieldByName('ForDate').AsString := 'F';
  Sender.Dataset.FieldByName('JobId').AsInteger := 0;
  Sender.Dataset.FieldByName('Jobname').AsString := '';
  Sender.Dataset.Findfield('BudgetDate').ReadOnly := true;

  AmountChanged := true;
  Result := true;
end;

procedure TBusObjFormLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  Dataset.Findfield('BudgetDate').ReadOnly :=
    Dataset.FieldByName('ForDate').AsBoolean = false;
end;


function TBusObjFormLines.DoAfterPost(Sender: TDatasetBusObj): boolean;
begin
  Result := true;
    {data for the line is populated from the tables when the object is loaded.
    This code should be executed when the user creates the record}
  if fbApplyDatasetEvents = false then Exit;

    {if the last record is deleted
    deletion is set Active to False so in after post}
  if (Dataset.Eof) and (Dataset.Bof) then Exit;

  if IsRecBlank then Sender.Dataset.Delete;

  if not AmountChanged then Exit;

  if Assigned(RefreshTotal) then RefreshTotal;
  if Sender.FieldByName('SortID').AsInteger < 1 then begin
    ResequenceLines;
  end;
end;

function TBusObjFormLines.getClassName(const ClassId: integer): string;
begin
  Result := '';
  if QryClass.Locate('ClassId', ClassId, []) then Result := QryClass.FieldByName('ClassName').AsString;
end;

function TBusObjFormLines.Delete:Boolean;
begin
  Result := True;
  if DataSet.State = dsInsert then Dataset.Cancel
  else begin
    EditDB;
    Dataset.FieldByName('Active').AsBoolean := false;
    PostDB;
  end;
end;


destructor TBusObjFormLines.Destroy;
begin
  OwnerBudget := nil;
  inherited Destroy;
end;

constructor TBusObjFormLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fbApplyDatasetEvents := false;
end;

function TBusObjbudgetLines.getBudgetPeriodId: integer;
begin
  Result := GetIntegerField('BudgetPeriodId');
end;

function TBusObjbudgetLines.GetClassID: integer;
begin
  Result := GetIntegerField('ClassId');
end;

function TBusObjbudgetLines.getAccountId: integer;
begin
  Result := GetIntegerField('AccountId');
end;

function TBusObjbudgetLines.getAmount2: double;
begin
  Result := GetFloatField('Conservative');
end;

function TBusObjbudgetLines.getAmount1: double;
begin
  Result := GetFloatField('Aggressive');
end;

function TBusObjbudgetLines.getEditedFlag: string;
begin
  Result := GetStringField('EditedFlag');
end;

function TBusObjbudgetLines.getActive: boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TBusObjbudgetLines.SetBudgetPeriodId(const Value: integer);
begin
  SetIntegerField('BudgetPeriodId', Value);
end;

procedure TBusObjbudgetLines.setClassID(const Value: integer);
begin
  SetIntegerField('ClassId', Value);
end;

procedure TBusObjbudgetLines.SetAccountId(const Value: integer);
begin
  SetIntegerField('AccountId', Value);
end;

procedure TBusObjbudgetLines.SetAmount1(const Value: double);
begin
  SetFloatField('Aggressive', Value);
end;

procedure TBusObjbudgetLines.SetAmount2(const Value: double);
begin
  SetFloatField('conservative', Value);
end;

procedure TBusObjbudgetLines.SetEditedFlag(const Value: string);
begin
  SetStringField('EditedFlag', Value);
end;

procedure TBusObjbudgetLines.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;


function TBusObjbudgetLines.GetId: integer;
begin
  Result := getIntegerField(IDFieldName);
end;
class function TBusObjbudgetLines.GetBusObjectTablename: string;
begin
  Result := 'tblBudgetLines';
end;

class Function TBusObjbudgetLines.GetIDField :String ;
begin
    Result :='BudgetLineId';
end;
procedure TBusObjbudgetLines.Load(const fIsReadonly:boolean =False);
begin
  if Trim(SQL) = '' then SQL := 'Select * from tblBudgetLines';
  inherited Load(fIsReadonly);
end;

function TBusObjbudgetLines.DoAfterInsert(Sender: TDatasetBusObj): boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

procedure TBusObjFormLines.ResequenceLines;
var
  BM: TBookmark;
  x: integer;
begin
  BM:= Dataset.GetBookmark;
  try
    Dataset.First;
    x:= 1;
    while not Dataset.Eof do begin
      if Dataset.FieldByName('SortId').AsInteger <> x then begin
        EditDB;
        Dataset.FieldByName('SortId').AsInteger:= x;
        PostDB;
      end;
      Inc(x);
      Dataset.Next;
    end;
    Dataset.GotoBookmark(BM);
  finally
    Dataset.FreeBookmark(BM);
  end;
end;

procedure TBusObjFormLines.Load(const fIsReadonly:boolean =False);
begin
  SQLOrder:= 'SortID';
  inherited;

end;

end.

