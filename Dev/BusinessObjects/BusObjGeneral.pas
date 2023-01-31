unit BusObjGeneral;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 21/11/05  1.00.00 IJB  Initial version.
 06/01/06  1.00.01 IJB  Modified TBalancePostList to allow its use with
                        non-business objects.
 10/08/06  1.00.02 BJ   TBalancePostList.AddAmount : checks for the existing updating item to
                        avoid duplication - search was done on entitytype and entityId
                        Added balancetype - when SO converted to invoice, entitytye(client)
                        and the entityID(ClientID) will be same but will have btSO and btAR balancetype .
 16/08/06 1.00.03 BJ    PostItems(updation of the related tables) locks the table but are released after
                        Comit.
                        lockgroupname gets its value from owner.Lockgroupname if the owner is busobj,
                        else is from the owner.classname
 11/01/07 1.00.04 BJ    TBalancePostList is changed to TPostlist
                        The object is used to post the ProductQtys as well.
                        PostItems function is changed to PostBalanceItems
                        PostQtyItems does the productQty updation
}

interface

uses
  Classes, Contnrs, DB, MyAccess,ERPdbComponents, UserLockObj, tcTypes,
  sysutils, MultiEventObj,
  MyScript, DAScript, ComCtrls(*,AdvOfficeStatusBar*);

type
  TShowProgressbar = Procedure (ProgressCount: integer; ProgressBarCaption: string; ProgressBarMessage: string = '';IsPercenage:boolean =true) of object;
  TStepProgressbar = Procedure (const ProgressBarMessage:String = '') of object;
  THideProgressbar = Procedure of object;

  TBalancePostItem = class(TObject)
  private
  public
    EntityID: integer;
    EntityType: string;
    EntityTableName: string;
    BalanceType: TBalanceType;
    Amount: double;
    constructor Create;
    destructor Destroy; override;
    function Text: string;
  end;


  TPostList = class(TComponent)
  private
    fList           : TObjectList;
    fUserLock       : TUserLock;
    fLockGroupName  : string;
    fDBConnection   : TCustomConnection;
    fQueries        : TStringList;
    (*fProgressbar    : TProgressbar;*)
    fsErrMsg        : String;
    fHideProgressbar: THideProgressbar;
    fShowProgressbar: TShowProgressbar;
    fStepProgressbar: TStepProgressbar;
    Procedure DoStepProgressbar;
    Procedure DoInitProgressbar(maxValue :Integer);
    Procedure DoHideProgressbar;
    function  GetItems(Const index: integer): TBalancePostItem;
    function  GetCount: integer;
    function  GetDBConnection: TCustomConnection;
    procedure SetDBConnection(const Value: TCustomConnection);
    function  GetUserLock: TUserLock;
    procedure SetUserLock(const Value: TUserLock);
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
    procedure MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
    Procedure getAmountQueries;
    function    RunSQLs:Boolean;
  public
    Events: TMultiEventClass;
    property    UserLock     : TUserLock         read GetUserLock       write SetUserLock;
    property    LockGroupName: string            read fLockGroupName    write fLockGroupName;
    (*Property    Progressbar  : TProgressbar      Read fProgressbar      Write fProgressbar;*)
    Property    ErrMsg       : String            read fsErrMsg          write fsErrMsg;
    property    DBConnection : TCustomConnection read GetDBConnection   write SetDBConnection;
    property    Count        : integer           read GetCount;
    Property    Queries      : TStringList       Read fQueries ;
    property    Items[Const index   : integer]   : TBalancePostItem read GetItems;
    Function    Execute:Boolean;
    constructor Create(aOwner: TComponent); override;
    Destructor  Destroy;                    override;
    procedure   Clear;
    Procedure   AddQuery(const SQLValue :String; const fEntityId :Integer=0; const fEntityTableName :String=''; IgnoreDuplicates :Boolean = True);
    procedure   AddAmount(const aEntityType, aEntityTableName: string; Const  aEntityID: integer; Const aAmount: double;
                            Const BalanceType: TBalanceType= btNormal; IgnoreDuplicates :Boolean = True);
    function Text: string;

    Property ShowProgressbar : TShowProgressbar read fShowProgressbar write fShowProgressbar;
    Property StepProgressbar : TStepProgressbar read fStepProgressbar Write fStepProgressbar;
    Property HideProgressbar : THideProgressbar read fHideProgressbar write fHideProgressbar;

  end;

implementation

uses
  BusObjBase, BusObjDataUtils,  LogThreadLib, AppEnvironment;

{ TPostList }
Procedure TPostList.DOHideProgressbar;
begin
    if Assigned(fHideProgressbar)       then    fHideProgressbar;
end;
Procedure TPostList.DoInitProgressbar(MaxValue :Integer);
begin
    if Assigned(fShowProgressbar) then begin
        fShowProgressbar(MaxValue , 'Please Wait..Save In Progress'   , '' , False);
    end;
end;
Procedure TPostList.DoStepProgressbar;
begin
    if Assigned(fStepProgressbar) then fStepProgressbar;
end;
constructor TPostList.Create(aOwner: TComponent);
begin
  inherited;
  fDBConnection:= nil;
  fList := TObjectList.Create(true);
  Events := TMultiEventClass.Create;;
  if aOwner is TBusobj then
    fLockGroupName := TBusobj(aOwner).LockGroupName
  else
    fLockGroupName := Copy(aOwner.ClassName, 2, Length(aOwner.ClassName));
(*  fProgressbar        := nil;*)
  fQueries := TStringList.create;
end;

destructor TPostList.Destroy;
begin
  FreeandNil(fList);
  Events.Free;
  if Assigned(fQueries) then
    FreeandNil(fQueries);
  inherited;
end;

procedure TPostList.AddAmount(const aEntityType, aEntityTableName: string; Const  aEntityID: integer; Const aAmount: double;
          Const BalanceType: TBalanceType= btNormal; IgnoreDuplicates :Boolean = True);
var
  x: integer;
  found: boolean;
begin
    x:= 0;
    found := false;
    if IgnoreDuplicates then
        for x := 0 to Count - 1 do begin
            if  (Items[x].EntityType = aEntityType) and
                (Items[x].EntityID = aEntityID) and
                (Items[x].BalanceType = BalanceType) then begin
                found := true;
                Break;
            end;
        end;
  if not found then begin
    x := fList.Add(TBalancePostItem.Create);
    Items[x].EntityID := aEntityID;
    Items[x].EntityType := aEntityType;
    Items[x].EntityTableName := aEntityTableName;
    Items[x].BalanceType := BalanceType;
  end;
  Items[x].Amount := Items[x].Amount + aAmount;
end;

procedure TPostList.Clear;
begin
//  TLogger.Inst.Log('');
//  TLogger.Inst.Log('TPostList.Clear');
//  TLogger.Inst.Log(self.Text);
  if fList.count > 0 then fList.Clear;
  fQueries.Clear;
end;

function TPostList.GetCount: integer;
begin
  Result := fList.Count;
end;

function TPostList.GetItems(Const index: integer): TBalancePostItem;
begin
  Result := TBalancePostItem(fList[index]);
end;

procedure TPostList.MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
begin
(*  StepProgressbar;*)
  DoStepProgressbar;
end;

procedure TPostList.MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  if sender is TERPScript then
    TERPScript(Sender).LogLockWaittimeOut(TERPScript(Sender), E , 'Script.Execute');
 Action := eaFail;
end;
Function TPostList.Execute:Boolean;
begin
//  TLogger.Inst.Log('');
//  TLogger.Inst.Log('TPostList.Execute');
//  TLogger.Inst.Log(self.Text);
   Events.FireEvent(self,'BeforeExecute','');
   getAmountQueries;
   result := RunSQLs;
   if result then Self.Clear; // clear the list so that an accidantal call to this again will not run the queries 
end;
function TPostList.RunSQLs:Boolean;
var
  x: integer;
  SavePointName: string;

    Procedure Run(const SQL_List :TStringList);
    Var
      MyScript: TERPScript;
    begin
        MyScript := nil;
        if DBConnection is TERPConnection then begin
            MyScript := TERPScript.Create(MyScript);
            try
              MyScript.Connection := TERPConnection(DBConnection);
              (*MyScript.UseOptimization := True;*)
              MyScript.BeforeExecute := MyScriptBeforeExecute;
              MyScript.onError := MyScriptError;
              MyScript.SQL.clear;
              MyScript.SQL.Text := SQL_List.Text;
              MyScript.SQL.Insert(0,'SAVEPOINT ' + SavePointName + ';');
              MyScript.SQL.Add('RELEASE SAVEPOINT ' + SavePointName + ';');
              DoInitProgressbar(SQL_List.count);
              MyScript.Execute;
              DoHideProgressbar;
            Finally
              FreeandNil(MyScript);
            end;
        end;
    end;

    Function getTableName(const Tablename :STring):String;
    begin
        if Sysutils.SameText(Tablename , 'tblChartOfAccounts') then
            result := 'Chart Of Accounts'
        else if Sysutils.SameText(Tablename , 'tblClients') then
            result := 'Clients'
        Else REsult := tableName;
    end;

    procedure Rollback;
    var cmd: TERPCommand;
    begin
      cmd:= TERPCommand.Create(nil);
      try
        cmd.Connection:= TERPConnection(DBConnection);
        cmd.SQL.Text:= 'ROLLBACK TO SAVEPOINT ' + SavePointName;
        cmd.Execute;
      finally
        cmd.Free;
      end;
    end;

begin
  Result := true;

  if TERPConnection(DBConnection).InTransaction =False then begin
    Errmsg := 'Unable to update - connection is not within transaction';
    Raise(Exception.create(errmsg));
  end else begin
    Errmsg := '';
    for x := 0 to Count - 1 do begin
          UserLock.LockList.AddLock(Items[x].EntityTableName, Items[x].EntityID, LockGroupName);
    end;
    if not UserLock.Lock(LockGroupName) then begin
      Queries.Clear;
      Result := false;
      Errmsg :=  'Unable to update ' + getTableName(UserLock.LOCKINFO.DatasetName) + ' record as it is being updated by "' +
                  UserLock.LockInfo.UserName + '" with: ' + UserLock.LockInfo.LockingForm +
                  #13 + #10 +
                  'Record has been in use since: ' + FormatDateTime('dd/mm hh:nn:ss', UserLock.LockInfo.TimeLocked)+
                  #13 + #10 +
                  #13 + #10 +
                  'Wait for "' +UserLock.LockInfo.UserName + '" to Close "' + UserLock.LockInfo.LockingForm +'"'+
                  #13 + #10 +
                  #13 + #10 +
                  'Try Again To Check if it is Closed';
    end else try
      If Queries.count>0 then begin
        if Assigned(Owner) then
          SavePointName:= self.Owner.ClassName + IntToStr(Integer(self))
        else
          SavePointName:= self.ClassName + IntToStr(Integer(self));
        Try
          Run(Queries);
          Queries.Clear;
        Except
            on E:Exception do begin
                ErrMsg := E.Message;
                Result := false;
                Rollback;
            end;
        end;
      end;
    finally
      { everthing needs to stay locked until transaction is committed  }
//      UserLock.Unlock(LockGroupName);
    end;
  end;
  if ErrMsg <> '' then
    if Assigned(Self.Owner) then if Self.Owner is TBusobj then
        TBusobj(Self.Owner).AddResult(true, rssWarning, 1, errMsg );
end;

Procedure TPostList.AddQuery(const SQLValue :String; const fEntityId :Integer=0; const fEntityTableName :String=''; IgnoreDuplicates :Boolean = True);
var
  x: integer;
  found: boolean;
  sSQLValue :String;
begin
  found := false;
  if (fEntityTableName <> '') and (fEntityID <> 0) then begin
    if IgnoreDuplicates then
      for x := 0 to Count - 1 do begin
        if  (Items[x].EntityTableName = fEntityTableName) and
            (Items[x].EntityID = fEntityID)  then begin
          found := true;
          Break;
        end;
      end;
      if not found then begin
        x := fList.Add(TBalancePostItem.Create);
        Items[x].EntityID := fEntityID;
        Items[x].EntityTableName := fEntityTableName;
        Items[x].Balancetype := btNone;
      end;
  end;
  if SQLValue <> '' then begin
    sSQLValue := Trim(SQLValue);
    if Copy(sSQLValue , Length(sSQLValue) , 1) <> ';' then sSQLValue := sSQLValue + ';';
    Queries.add(sSQLValue);
  end;
end;
Procedure TPostList.getAmountQueries;
var
  x: integer;
  strSQL :STring;
    Function UpdateAccountsSQL(Const TableName: string; Const TableID: integer; Const Value: double; Const BalanceType: TBalanceType):String;
    var
        sql: string;
    begin
        SQL := '';
        if (BalanceType = btSO) then sql :=
          ' UPDATE ' + TableName + ' SET SOBalance = SOBalance + ' + FloatToStr(Value) +
          ', msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode) +
          ' WHERE ' + GetTablePrimaryKeyName(TableName) + ' = ' + IntToStr(TableID)
        else if (BalanceType = btAR) then sql :=
          ' UPDATE ' + TableName + ' SET Balance = Balance + ' + FloatToStr(Value) +
          ' , ARBalance = ARBalance + ' + FloatToStr(Value) +
          ', msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode) +
          ' WHERE ' + GetTablePrimaryKeyName(TableName) + ' = ' + IntToStr(TableID)
        else if (BalanceType = btAP) then sql :=
          ' UPDATE ' + TableName + ' SET Balance = Balance - ' + FloatToStr(Value) +
          ' , APBalance = APBalance + ' + FloatToStr(Value) +
          ', msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode) +
          ' WHERE ' + GetTablePrimaryKeyName(TableName) + ' = ' + IntToStr(TableID)
        else if (BalanceType = btNormal) then  sql :=
          ' UPDATE ' + TableName + ' SET Balance = Balance + ' + FloatToStr(Value) +
          ', msUpdateSiteCode = ' + QuotedStr(AppEnv.Branch.SiteCode) +
          ' WHERE ' + GetTablePrimaryKeyName(TableName) + ' = ' + IntToStr(TableID);
        REsult := SQL;
    End;
begin
      for x := 0 to count - 1 do begin
        strSQL := UpdateAccountsSQL(Items[x].EntityTableName, Items[x].EntityID,Items[x].Amount, Items[x].BalanceType);
        if strSQL <> '' then AddQuery(strSQL ,Items[x].EntityID ,Items[x].EntityTableName , False );
      end;
end;


function TPostList.GetDBConnection: TCustomConnection;
begin
  if Assigned(fDBConnection) then
    result:= fDBConnection
  else if Owner is TBusObj then
    result:= TBUsObj(Owner).Connection.DBConnection
  else
    result:= nil;
end;

procedure TPostList.SetDBConnection(const Value: TCustomConnection);
begin
  fDBConnection:= Value;
end;

function TPostList.GetUserLock: TUserLock;
begin
  if Assigned(fUserLock) then
    result:= fUserLock
  else if Owner is TBusObj then
    result:= TBusObj(Owner).UserLock
  else
    result:= nil;
end;

procedure TPostList.SetUserLock(const Value: TUserLock);
begin
  fUserLock:= Value;
end;
function TPostList.Text: string;
var
  x: integer;
begin
  result:= 'TPosList, Owner = ';
  if Assigned(Owner) then
    result:= result + Owner.ClassName
  else
    result:= result + 'nil';
  result:= result + #13#10 + '  Items:';
  for x:= 0 to Count -1 do
    result:= result + #13#10 + '    ' + TBalancePostItem(Items[x]).Text;
  result:= result + #13#10 + '  Queries:';
  for x:= 0 to fQueries.Count -1 do
    result:= result + #13#10 + '    ' + fQueries[x];


end;

{ TBalancePostItem }

constructor TBalancePostItem.Create;
begin
  inherited;
  EntityID := 0;
  EntityType := '';
  EntityTableName := '';
  Amount := 0;
end;

destructor TBalancePostItem.Destroy;
begin
  inherited;
end;

function TBalancePostItem.Text: string;
begin
  result:=
  'EntityID = ' + IntToStr(EntityID) + ', ' +
  'EntityType = ' + EntityType + ', ' +
  'EntityTableName = ' + EntityTableName + ', ' +
  'BalanceType = ' + IntToStr(Ord(BalanceType)) + ', ' +
  'Amount = ' + FloatToStr(Amount);
end;

end.

