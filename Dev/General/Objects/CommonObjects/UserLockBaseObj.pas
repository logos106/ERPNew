unit UserLockBaseObj;

interface
uses
  Classes, MyAccess;

type

  TUserLockItem = class(TCollectionItem)
  private
    FDatasetName: string;
    FKeyID: integer;
    FLockID: integer;
    FIsLocked: boolean;
    FLockGroup: string;
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property DatasetName: string read FDatasetName write FDatasetName;
    property KeyId: integer read FKeyID write FKeyID;
    property IsLocked: boolean read FIsLocked write FIsLocked;
    property LockID: integer read FLockID write FLockID;
    property LockGroup: string read FLockGroup write FLockGroup;
  end;

  TUserLockCollection = class(TCollection)
  private
  protected
  public
    constructor Create(ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    function AddLock(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string = ''): TUserLockItem;
    procedure Remove(aLockItem: TUserLockItem);
  end;

  TLockInfo = record
    LockClassName,
    DatasetName,
    UserName: string;
    GroupName: string;
    LockingForm: string;
    KeyID: integer;
    TimeLocked: TDateTime;
  end;

  TUserLockBase = class(TComponent)
  private
    FEnabled: boolean;
    FLockList: TUserLockCollection;
    FLockOwnerClassName: string;
    FLockOwnerUserName: string;
    FIgnoreClassnameinLock:Boolean;
    qry: TMyQuery;
    cmd: TMyCommand;
    FLockInfo: TLockInfo;
    fConnection: TMyConnection;
    fUserName: string;
    fOnUnlockItem: TNotifyEvent;
    fbAllowDuplicateLockFromSameForm: Boolean;
    fsDuplicateLockGroupName :String;
    procedure ClearLockInfo;
    function GetLockMessage: string;
    procedure SetEnabled(const Value: boolean);
    procedure SetConnection(const Value: TMyConnection);
    //function LogDetails: String;


  protected
    function GetUserName: string; virtual;
    procedure SetUserName(const Value: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property LockInfo: TLockInfo read FLockInfo;
    property LockList: TUserLockCollection read FLockList;
    property LockOwnerClassName: string read FLockOwnerClassName write FLockOwnerClassName;
    property LockOwnerUserName: string read FLockOwnerUserName write FLockOwnerUserName;
    function LockItem(Item: TUserLockItem): boolean;
    function IsLocked(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string = ''): boolean;
    function IsLockedbyOtherUser(const ADatasetName: string;      const AKeyID: integer; const ALockGroup: string): boolean;
    procedure UnLockItem(Item: TUserLockItem; DeleteifCreatedAfter:TDateTime=0);
    function Lock(const LockGroup: string = ''): boolean; overload;
    function Lock(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string = ''): boolean; overload;
    function LockAll(const ADatasetName: string; const ALockGroup: string = ''): boolean;
    function LockEx(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string = ''): TUserLockItem;
    procedure Unlock(const LockGroup: string = '');overload;
    Procedure UnLock(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string = ''; aClassname:String ='');overload;
    procedure UnlockAllCurrentUser;
    procedure UnlockAllCurrentInstance;
   { WARNING .. there may be Web API users with locks in this table }
    procedure UnlockAllUsers;
    property LockMessage: string read GetLockMessage;
    property Enabled: boolean read FEnabled write SetEnabled;
    Property IgnoreClassnameinLock :Boolean read fIgnoreClassnameinLock write fIgnoreClassnameinLock;
    property Connection: TMyConnection read fConnection write SetConnection;
    property UserName: string read GetUserName write SetUserName;
    property OnUnlockItem: TNotifyEvent read fOnUnlockItem write fOnUnlockItem;
    Property AllowDuplicateLockFromSameForm :Boolean read fbAllowDuplicateLockFromSameForm write fbAllowDuplicateLockFromSameForm;
    Property DuplicateLockGroupName :String read fsDuplicateLockGroupName write fsDuplicateLockGroupName;
  end;
  function CustomiseLockMessage(const Msg:String; st1, st2:Array of String):String;
implementation

uses
  SysUtils, MySQLConst, LogThreadLib(*, LogLib*);

  //------------------------------------------------------------------------------
  { TUserLockItem }
function CustomiseLockMessage(const Msg:String; st1, st2:Array of String):String;
var
  ctr:Integer;
begin
  result := Msg;
  if length(st1)=0 then exit;
  if length(st1) <> length(st2) then exit;
  for ctr := low(st1) to high(st1) do
    //result := replacestr(result, st1[ctr], st2[ctr]);
    result := StringReplace(result, st1[ctr], st2[ctr],[rfReplaceAll,rfIgnoreCase]);
end;
constructor TUserLockItem.Create(Collection: TCollection);
begin
  inherited;
end;

destructor TUserLockItem.Destroy;
begin
  inherited;
end;

  //------------------------------------------------------------------------------
  { TUserLockCollection }

function TUserLockCollection.AddLock(const ADatasetName: string; const AKeyID: integer;
  const ALockGroup: string = ''): TUserLockItem;
begin
  Result := TUserLockItem(self.Add);
  Result.DatasetName := ADatasetName;
  Result.KeyId := AKeyID;
  Result.LockGroup := ALockGroup;
  Result.IsLocked := false;
  Result.LockID := 0;
end;

constructor TUserLockCollection.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
end;

destructor TUserLockCollection.Destroy;
begin
  inherited;
end;

procedure TUserLockCollection.Remove(aLockItem: TUserLockItem);
begin
  Delete(aLockItem.index);
end;

  //------------------------------------------------------------------------------
  { TUserLock }
constructor TUserLockBase.Create(AOwner: TComponent);
begin
  inherited;
  //logtext(LogDetails+',,' +  'Create');
  AllowDuplicateLockFromSameForm := False;
  DuplicateLockGroupName  := '';
//  {$IFDEF APPNAME_ERP}
//    fConnection:= CommonDbLib.GetSharedMyDacConnection;
//  {$ENDIF}
  qry := TMyQuery.Create(self);
  cmd := TMyCommand.Create(self);
  qry.Connection := Connection;
  cmd.Connection := Connection;
  FLockList := TUserLockCollection.Create(TUserLockItem);
  FEnabled := true;


  FLockOwnerClassName := '';
  FLockOwnerUserName := '';
//  {$IFDEF APPNAME_ERP}
//    if Assigned(Owner) then begin
//      // default to class name of owner form
//      FLockOwnerClassName := Owner.ClassName;
//    end;
//    if Assigned(AppEnv.AppDb) AND AppEnv.AppDb.Connection.Connected then
//      FLockOwnerUserName := AppEnv.Employee.LogonName;
//  {$ENDIF}

  ClearLockInfo;
  fIgnoreClassnameinLock := False;
end;

destructor TUserLockBase.Destroy;
begin
  //logtext(LogDetails+',,' +  'Destroy');
  Unlock;
  UnlockAllCurrentInstance;
  FreeAndNil(FLockList);
  inherited;
end;
(*function TUserLockBase.LogDetails:String;
begin
  result := inttostr(integer(Self))+',' ;
  if assigned(Owner) then REsult :=REsult +Owner.classname+',' + inttostr(Integer(Owner))+',' + inttostr(Integer(Self))+',' else result := result +',,';
end;*)
function TUserLockBase.LockItem(Item: TUserLockItem): boolean;
begin
  //logtext(LogDetails+Item.DatasetName+','+  inttostr(Item.KeyID)+',Lockitem');
  Result := true;
  qry.Connection := Connection;
  cmd.Connection := Connection;
  if not Enabled then Exit
  else if self.LockOwnerUserName = '' then begin
    raise Exception.Create('No username has been specified for setting user locks.');
  end else if Item.IsLocked then Exit;

  // Does anybody else have this ID locked for this Dataset OR form Class
  qry.SQL.Text := 'SELECT * FROM tblinuse ';
  if Item.KeyID <> 0 then qry.SQL.add('WHERE (KeyId = 0 or  KeyId = ' + IntToStr(Item.KeyID)+')')
  else qry.SQL.add('WHERE (KeyId = 0 or  KeyId <>0 )');
  
  if Item.DatasetName <> '' then qry.SQL.Add('AND UPPER(DatasetName) = ' + QuotedStr(uppercase(Item.DatasetName)))
  else qry.SQL.Add('AND UPPER(ClassName) = ' + QuotedStr(uppercase(self.LockOwnerClassName)));
  if AllowDuplicateLockFromSameForm then qry.SQL.Add('AND not ( UPPER(ClassName) = ' + QuotedStr(uppercase(self.LockOwnerClassName)) +' and GroupName = ' + quotedstr(DuplicateLockGroupName)+')');
  qry.Open;
  if qry.IsEmpty then begin
    // then lock it
    qry.Close;
    cmd.SQL.Text   := 'INSERT HIGH_PRIORITY INTO tblinuse SET' +
      ' Instance = ' + IntToStr(integer(Self)) + ',' +
      ' UserName = ' + QuotedStr(self.FLockOwnerUserName) + ',' +
      ' ClassName = ' + QuotedStr(Self.FLockOwnerClassName) + ',' +
      ' DatasetName = ' + QuotedStr(Item.DatasetName) +',' +
      ' GroupName = ' + QuotedStr(Item.LockGroup) + ',' +
      ' KeyID = ' + IntToStr(Item.KeyID) +',' +
      ' TimeEntered = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, Now));
    cmd.Execute;
    Item.LockID := cmd.InsertId;
//    TLogger.Inst.Log('TUserLockBase.LockItem - Locked: ' + IntToStr(Item.LockID));
    Result      := true;
  end else begin
    if (Sysutils.SameText(qry.FieldByName('UserName').AsString , self.FLockOwnerUserName)) and
      ((Sysutils.SameText(qry.FieldByName('ClassName').AsString , Self.FLockOwnerClassName)) or (IgnoreClassnameinLock)) and
      ((qry.FieldByName('Instance').AsInteger = integer(Self)) or IgnoreClassnameinLock) and
      (Sysutils.SameText(qry.FieldByName('DatasetName').AsString , Item.DatasetName)) and
      (Sysutils.SameText(qry.FieldByName('GroupName').AsString , Item.LockGroup)) then begin
      // we are trying to lock somthing we have already locked ... do nothing
    end else begin // get details of who has it open
      Result := false;
      FLockInfo.LockClassName := qry.FieldByName('ClassName').AsString;
      FLockInfo.DatasetName := qry.FieldByName('DatasetName').AsString;
      FLockInfo.UserName := qry.FieldByName('UserName').AsString;
      FLockInfo.TimeLocked := qry.FieldByName('TimeEntered').AsDateTime;
      FLockInfo.GroupName := qry.FieldByName('GroupName').AsString;

      if Item.KeyID = 0 then
        FLockInfo.KeyID := Qry.fieldbyname('keyID').asinteger
      else
        FLockInfo.KeyID := Item.KeyID;

      if FLockInfo.GroupName <> '' then
        FLockInfo.LockingForm := FLockInfo.GroupName
      else
        FLockInfo.LockingForm := FLockInfo.LockClassName;
    end;
  end;
  qry.Close;
  Item.IsLocked := Result;
end;

procedure TUserLockBase.UnLockItem(Item: TUserLockItem; DeleteifCreatedAfter:TDateTime=0);
begin
  if not Enabled then Exit;
  if (Item.LockID > 0) then begin
//    cmd.SQL.Text   := 'DELETE FROM tblinuse WHERE' + ' ID = ' + IntToStr(Item.LockID);
//    cmd.Execute;
//    TLogger.Inst.Log('TUserLockBase.UnLockItem - Unlocked: ' + IntToStr(Item.LockID));
    qry.SQL.Text:= 'select * from tblinuse WHERE' + ' ID = ' + IntToStr(Item.LockID);
    if DeleteifCreatedAfter <> 0 then QRy.SQL.Add(' and mstimeStamp >= ' + Quotedstr(formatDateTime(MysqlDateTimeFormat , DeleteifCreatedAfter)));
    qry.Open;
    Qry.First;
    while not qry.eof do begin
      try
        qry.Delete;
        Item.IsLocked := false;
        Item.LockID := 0;
      except
        on e: exception do begin
          qry.Next;
        end;
      end;
    end;
  end;
  //  LockList.Delete(Item.Index);
(*  Item.IsLocked := false;
  Item.LockID := 0;*)
end;

procedure TUserLockBase.ClearLockInfo;
begin
  FLockInfo.LockClassName := '';
  FLockInfo.DatasetName := '';
  FLockInfo.UserName := '';
  FLockInfo.LockingForm := '';
  FLockInfo.KeyID := 0;
  FLockInfo.TimeLocked := 0;
end;

function TUserLockBase.Lock(const LockGroup: string = ''): boolean;
var
  x, y: integer;
  tm:tDatetime;
begin
  Result := true;
  if not Enabled then Exit;
  ClearLockInfo;
  tm := now;
  for x := 0 to self.LockList.Count - 1 do begin
    if (LockGroup = '') or Sysutils.SameText(LockGroup, TUserLockItem(LockList.Items[x]).LockGroup) then begin
      Result := LockItem(TUserLockItem(LockList.Items[x]));
      if not Result then begin
        //UnlockAllCurrentInstance;
        if x>0 then
          for y := 0 to x-1 do
            UnLockItem(TUserLockItem(LockList.Items[y]), tm);{unlock the ones locked here. Since the records allready locked by the same object is ignored here, unlocking should also ignore them, hence checking if locked after the time}
        Break;
      end;
    end;
  end;
end;
Procedure TUserLockBase.UnLock(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string = ''; aClassname:String ='');
var
  x: integer;
begin
  if not Enabled then Exit;
  x := 0;
  while x < self.LockList.Count do begin
    if ((Sysutils.SameText(ALockGroup, TUserLockItem(LockList.Items[x]).LockGroup)) and
        (Sysutils.SameText(TUserLockItem(LockList.Items[x]).DatasetName , ADatasetName)) and
        (TUserLockItem(LockList.Items[x]).KeyId = AKeyID) ) and
        ((aClassname = '') or ((sametext(aClassname , LockOwnerClassname))  and (AllowDuplicateLockFromSameForm) )) then begin
      self.UnLockItem(TUserLockItem(LockList.Items[x]));
      self.LockList.Remove(TUserLockItem(LockList.Items[x]));
      Exit;
    end else Inc(x);
  end;
end;
procedure TUserLockBase.Unlock(const LockGroup: string = '');
var
  x: integer;
begin
  if not Enabled then Exit;
  x := 0;
  while x < self.LockList.Count do begin
    if (LockGroup = '') or Sysutils.SameText(LockGroup, TUserLockItem(LockList.Items[x]).LockGroup) then begin
      self.UnLockItem(TUserLockItem(LockList.Items[x]));
      self.LockList.Remove(TUserLockItem(LockList.Items[x]));
      if Assigned(fOnUnlockItem) then
        fOnUnlockItem(self);
    end else Inc(x);
  end;
end;

function TUserLockBase.GetLockMessage: string;
var
  s: string;
  function WholetableLocked:String; begin result := '';if  FLockInfo.KeyId = 0 then REsult := '(Whole Table Locked)';end;
begin
  if FLockInfo.UserName = '' then begin
    Result := '';
  end else begin
    Result := 'Unable to update data.' + #13#10;
    
    s:= 'Currently the User "' + FLockInfo.Username + '" is accessing this record ' +WholetableLocked+
        ' with: ' + FLockInfo.LockingForm+ '!';

    if (UserName <> '') and (UserName = FLockInfo.Username) then
      s := 'You are currently accessing this record ' + WholetableLocked+' with: ' + FLockInfo.LockingForm + '!';

    result:= Result + s;
    Result := Result + #13 + #10 + 'Record has been in use since: ' + FormatDateTime('dd/mm hh:nn:ss', FLockInfo.TimeLocked);
  end;
end;

procedure TUserLockBase.UnlockAllCurrentUser;
begin
  if not Enabled then Exit
  else if FLockOwnerUserName = '' then Exit;
  cmd.SQL.Text := 'DELETE FROM tblinuse WHERE' + ' Username = ' + QuotedStr(FLockOwnerUserName);
  cmd.Execute;
  while LockList.Count > 0 do begin
    LockList.Delete(0);
  end;
end;

procedure TUserLockBase.UnlockAllCurrentInstance;
begin
  if not Enabled then Exit;

  if cmd.Connection = nil then Exit;
  
  cmd.SQL.Text := 'DELETE FROM tblinuse WHERE Instance = ' + IntToStr(integer(Self));
  cmd.Execute;
  while LockList.Count > 0 do begin
    LockList.Delete(0);
  end;
end;

{ WARNING .. there may be Web API users with locks in this table }
procedure TUserLockBase.UnlockAllUsers;
begin
  cmd.SQL.Text := 'truncate table tblinuse';
  cmd.Execute;
  while LockList.Count > 0 do begin
    LockList.Delete(0);
  end;
end;

procedure TUserLockBase.SetConnection(const Value: TMyConnection);
begin
  fConnection := Value;
  qry.Connection:= fConnection;
  cmd.Connection:= fConnection;
end;

procedure TUserLockBase.SetEnabled(const Value: boolean);
var
  x: integer;
  ActiveLocks: boolean;
begin
  if Value = false then begin
    ActiveLocks := false;
    for x := 0 to self.LockList.Count - 1 do begin
      if TUserLockItem(LockList.Items[x]).IsLocked then begin
        ActiveLocks := true;
        Break;
      end;
    end;
    if not ActiveLocks then begin
      FEnabled := Value;
    end else begin
      raise Exception.Create('Can not disable lock object while user records are locked.');
    end;
  end else begin
    FEnabled := Value;
  end;
end;
function TUserLockBase.LockAll(const ADatasetName: string; const ALockGroup: string = ''): boolean;
var
  LockItem: TUserLockItem;
begin
  LockItem := LockList.AddLock(ADatasetName, 0, ALockGroup  );
  Result := Self.LockItem(LockItem);
  if not Result then LockList.Delete(LockList.Count - 1);
end;


function TUserLockBase.Lock(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string): boolean;
var
  LockItem: TUserLockItem;
begin
  LockItem := LockList.AddLock(ADatasetName, AKeyId, ALockGroup );
  Result := Self.LockItem(LockItem);
  if not Result then LockList.Delete(LockList.Count - 1);
end;

function TUserLockBase.LockEx(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string): TUserLockItem;
begin
  Result := nil;
  if Lock(ADatasetName, AKeyID, ALockGroup) then Result := TUserLockItem(LockList.Items[LockList.Count - 1]);
end;

function TUserLockBase.IsLocked(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string): boolean;
begin
  Result := false;
  if not Enabled then Exit
  else if self.LockOwnerUserName = '' then begin
    raise Exception.Create('No username has been specified for setting user locks.');
  end;

  // Does anybody else have this ID locked for this Dataset OR form Class
  qry.SQL.Text := 'SELECT * FROM tblinuse WHERE' + ' KeyId = ' + IntToStr(AKeyID);
  if ADatasetName <> '' then qry.SQL.Add('AND UPPER(DatasetName) = ' + QuotedStr(uppercase(ADatasetName)))
  else qry.SQL.Add('AND UPPER(ClassName) = ' + QuotedStr(uppercase(self.LockOwnerClassName)));
  qry.Open;
  if qry.IsEmpty then begin
    Result := false;
  end else begin
    Result := true;
    if (qry.FieldByName('UserName').AsString = self.FLockOwnerUserName) and
      (qry.FieldByName('ClassName').AsString = Self.FLockOwnerClassName) and
      (qry.FieldByName('DatasetName').AsString = ADatasetName) and
      (qry.FieldByName('GroupName').AsString = ALockGroup) then begin
      // we are trying to lock somthing we have already locked ... do nothing
    end else begin // get details of who has it open

      FLockInfo.LockClassName := qry.FieldByName('ClassName').AsString;
      FLockInfo.DatasetName := qry.FieldByName('DatasetName').AsString;
      FLockInfo.UserName := qry.FieldByName('UserName').AsString;
      FLockInfo.TimeLocked := qry.FieldByName('TimeEntered').AsDateTime;
      FLockInfo.GroupName := qry.FieldByName('GroupName').AsString;
      FLockInfo.KeyID := AKeyID;
      if FLockInfo.GroupName <> '' then FLockInfo.LockingForm := FLockInfo.GroupName
      else FLockInfo.LockingForm := FLockInfo.LockClassName;
    end;
  end;
  qry.Close;
end;

function TUserLockBase.IsLockedbyOtherUser(const ADatasetName: string; const AKeyID: integer; const ALockGroup: string): boolean;
begin
  Result := false;
  if not Enabled then Exit
  else if self.LockOwnerUserName = '' then begin
    raise Exception.Create('No username has been specified for setting user locks.');
  end;

  // Does anybody else have this ID locked for this Dataset OR form Class
  qry.SQL.Text := 'SELECT * FROM tblinuse WHERE' + ' KeyId = ' + IntToStr(AKeyID);
  if ADatasetName <> '' then qry.SQL.Add('AND UPPER(DatasetName) = ' + QuotedStr(uppercase(ADatasetName)))
  else qry.SQL.Add('AND UPPER(ClassName) = ' + QuotedStr(uppercase(self.LockOwnerClassName)));
  qry.Open;
  if qry.IsEmpty then begin
  end else begin
    if (qry.FieldByName('UserName').AsString = self.FLockOwnerUserName) and
      (qry.FieldByName('ClassName').AsString = Self.FLockOwnerClassName) and
      (qry.FieldByName('DatasetName').AsString = ADatasetName) and
      (qry.FieldByName('GroupName').AsString = ALockGroup) then begin
      // we are trying to lock somthing we have already locked ... do nothing
    end else begin // get details of who has it open
      Result := true;
      FLockInfo.LockClassName := qry.FieldByName('ClassName').AsString;
      FLockInfo.DatasetName := qry.FieldByName('DatasetName').AsString;
      FLockInfo.UserName := qry.FieldByName('UserName').AsString;
      FLockInfo.TimeLocked := qry.FieldByName('TimeEntered').AsDateTime;
      FLockInfo.GroupName := qry.FieldByName('GroupName').AsString;
      FLockInfo.KeyID := AKeyID;
      if FLockInfo.GroupName <> '' then FLockInfo.LockingForm := FLockInfo.GroupName
      else FLockInfo.LockingForm := FLockInfo.LockClassName;
    end;
  end;
  qry.Close;
end;

function TUserLockBase.GetUserName: string;
begin
  Result := fUserName;
end;

procedure TUserLockBase.SetUserName(const Value: string);
begin
  fUserName:= Value;
end;
end.
