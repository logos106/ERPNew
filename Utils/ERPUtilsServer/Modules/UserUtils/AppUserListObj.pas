unit AppUserListObj;

interface

uses
  contnrs, syncobjs, JsonObject, classes, LogThreadBase, LogMessageTypes;

type

  TAppUserItem = class(TObject)
  private
    fUserName: string;
    fTimeStamp: tDateTime;
    fUserSession: TObject;
    fDatabaseName: string;
    fLastTime: tDateTime;
    FFirstName: string;
    FLastName: string;
    fMultiLogon: boolean;
    procedure SetTimeStamp(const Value: tDateTime);
  public
    constructor Create;
    destructor Destroy; override;
    property UserName: string read fUserName write fUserName;
    property DatabaseName: string read fDatabaseName write fDatabaseName;
    property UserSession: TObject read fUserSession write fUserSession;
    property TimeStamp: tDateTime read fTimeStamp write SetTimeStamp;
    property LastTime: tDateTime read fLastTime write fLastTime;
    property FirstName: string read FFirstName write fFirstName;
    property LastName: string read FLastName write fLastName;
    property MultiLogon: boolean read fMultiLogon write fMultiLogon;
  end;

  TLogonLockRec = class(TObject)
  public
    LockedByUser: TAppUserItem;
    TimeLocked: TDateTime;
    LockReason: string;
    Locked: boolean;
    DatabaseName: string;
  end;

  TLogonLock = class(TObject)
  private
    fList: TThreadList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock(aUserItem: TAppUserItem; aReason: string; aDatabaseName: string);
    procedure Unlock(aUserItem: TAppUserItem); overload;
    procedure Unlock(aUserName: string; aDatabaseName: string); overload;
    function Locked(aDatabaseName: string; var LockRec: TLogonLockRec): boolean;
  end;

  TAppUserList = class(TObject)
  private
    fList: TObjectList;
    fLock: TCriticalSection;
    function GetItem(index: integer): TAppUserItem;
    function GetItemBySession(aUserSession: TObject): TAppUserItem;
    function GetItemByName(aUserName, aDatabase: string): TAppUserItem;
  public
    LogonLock: TLogonLock;
    Logger: TLoggerBase;
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    property Item[index: integer]: TAppUserItem read GetItem;
    property ItemBySession[aUserSession: TObject]: TAppUserItem read GetItemBySession;
    function AddUser(var msg: string; const aUserName, aDatabaseName: string;
      aUserSession: TObject; aFirstName: string = ''; aLastName: string = ''; aMultiLogon: boolean = false): TAppUserItem;
    procedure RemoveUser(aUserSession: TObject); overload;
    procedure RemoveUser(const aUserName, aDatabaseName: string); overload;
    function LockLogon(var msg: string; const aUserSession: TObject; aDatabaseName: string; aLockReason: string): boolean;  overload;
    function LockLogon(var msg: string; const aUserName, aDatabaseName, aLockReason: string): boolean; overload;
    procedure UnlockLogon(aUserSession: TObject); overload;
    procedure UnlockLogon(aUserName, aDatabaseName: string); overload;
    function UserNameList(aDatabaseName: string = ''): string;
    function DatabaseUserCount(aDatabaseName: string; ExcludeMultiLogonUsers: boolean = false): integer;
    procedure UpdateItemLastTime(aUserSession: TObject);
    function ListAsJson: TJsonObject;
    procedure RemoveInactiveUsers(InactiveLongerThan: TDateTime);
    function UserExists(aUserName, aDatabaseName: string): boolean;
  end;


implementation

uses
  ModuleUtils, sysutils, ERPDBComponents, MySQLUtils;

const
  MAX_INACTIVITY_INTERVAL = (1/24/60) * 2; { two minutes}

{ TAppUserItem }

constructor TAppUserItem.Create;
begin

end;

destructor TAppUserItem.Destroy;
begin

  inherited;
end;

procedure TAppUserItem.SetTimeStamp(const Value: tDateTime);
begin
  fTimeStamp := Value;
  fLastTime:= value;
end;

{ TAppUserList }

function TAppUserList.AddUser(var msg: string; const aUserName, aDatabaseName: string;
  aUserSession: TObject; aFirstName: string = ''; aLastName: string = '';
  aMultiLogon: boolean = false): TAppUserItem;
var
  UserItem: TAppUserItem;
  LockRec: TLogonLockRec;
begin
//  Logger.Log('Inst: ' + IntToStr(INteger(Self)) + ' AddUser - User: ' + aUserName + ' Database: ' + aDatabaseName + ' Session: ' + IntToStr(Integer(aUserSession)), ltDetail);
  result:= nil;
  { just in case user crashed out and logon lock still there .. }
  UnlockLogon(aUserName, aDatabaseName);

  { check for logon lock }
  if LogonLock.Locked(aDatabaseName, LockRec) then begin
    msg:= 'Can not log on at this time: ' + LockRec.LockReason;
//    Logger.Log('    Can not log on at this time: ' + LockRec.LockReason, ltDetail);
    exit;
  end;

  if not aMultiLogon then begin  { allow multi logon for same user }
    UserItem:= GetItemByName(aUserName, aDatabaseName);
    if Assigned(UserItem) then begin
      if (now - UserItem.LastTime) <= MAX_INACTIVITY_INTERVAL then begin
        { this is an active user }
        msg:= 'User already logged on';
//        Logger.Log('    User already logged on', ltDetail);
        exit;
      end
      else begin
        { remove old "dead" user record from list then continue on to add new record }
        self.RemoveUser(UserItem.UserSession);
//        Logger.Log('    Old session, removing user', ltDetail);
      end;
    end;
  end;

  result:= TAppUserItem.Create;
  result.UserName:= aUserName;
  result.DatabaseName:= aDatabaseName;
  result.UserSession:= aUserSession;
  result.TimeStamp:= NowUTC;
  result.FirstName:= aFirstName;
  result.LastName:= aLastName;
  result.MultiLogon:= aMultiLogon;
  result.LastTime:= now;
  fList.Add(result);
//  Logger.Log('    Users: ' + UserNameList,ltDetail);
end;

constructor TAppUserList.Create;
begin
  fList:= TObjectList.Create(true);
  fLock:= TCriticalSection.Create;
  LogonLock:= TLogonLock.Create;
end;

function TAppUserList.DatabaseUserCount(aDatabaseName: string; ExcludeMultiLogonUsers: boolean = false): integer;
var
  x: integer;
  LastUserName: string;
begin
  result:= 0;
  LastUserName:= '';
  for x:= 0 to fList.count-1 do begin
    if (aDatabaseName = '') or (Lowercase(Item[x].DatabaseName) = Lowercase(aDatabaseName)) then begin
      if (Lowercase(Item[x].UserName) <> LastUserName) and ((not ExcludeMultiLogonUsers) or (ExcludeMultiLogonUsers and (not Item[x].MultiLogon))) then begin
        Inc(result);
        LastUserName:= Lowercase(Item[x].UserName);
      end;
    end;
  end;
end;

destructor TAppUserList.Destroy;
begin
//  while fList.Count > 0 do begin
//    fList.Objects[0].Free;
//    fList.Delete(0);
//  end;
  fList.Free;
  fLock.Free;
  LogonLock.Free;
  inherited;
end;

function TAppUserList.GetItem(index: integer): TAppUserItem;
begin
  result:= TAppUserItem(fList[index]);
end;

function TAppUserList.GetItemBySession(
  aUserSession: TObject): TAppUserItem;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to fList.Count -1 do begin
    if Item[x].UserSession = aUserSession then begin
      result:= Item[x];
      break;
    end;
  end;
end;

function TAppUserList.GetItemByName(aUserName, aDatabase: string): TAppUserItem;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to fList.Count -1 do begin
    if (Item[x].UserName = aUserName) and (Item[x].DatabaseName = aDatabase) then begin
      result:= Item[x];
      break;
    end;
  end;
end;

procedure TAppUserList.Lock;
begin
  fLock.Acquire;
end;

function TAppUserList.LockLogon(var msg: string;
  const aUserSession: TObject; aDatabaseName: string; aLockReason: string): boolean;
var
  LockRec: TLogonLockRec;
  AppUserItem: TAppUserItem;
begin
//  Logger.Log('Inst: ' + IntToStr(INteger(Self)) + ' LockLogon - Database: ' + aDatabaseName + ' Session: ' + IntToStr(Integer(aUserSession)) + ' Reason: ' + aLockReason, ltDetail);
  if LogonLock.Locked(aDatabaseName, LockRec) then begin
    result:= false;
    msg:= 'Logon is locked by ' + LockRec.LockedByUser.UserName +
      ' for reason: ' + LockRec.LockReason;
//   Logger.Log('    ' + msg,ltDetail);
  end
  else begin
    AppUserItem := GetItemBySession(aUserSession);
    if Assigned(AppUserItem) then begin
      LogonLock.Lock(AppUserItem,aLockReason, aDatabaseName);
      result:= true;
    end
    else begin
      result := false;
      msg := 'Could find user session';
//      Logger.Log('    ' + msg,ltDetail);
    end;
  end;
end;

function TAppUserList.LockLogon(var msg: string; const aUserName, aDatabaseName,
  aLockReason: string): boolean;
var
  LockRec: TLogonLockRec;
  AppUserItem: TAppUserItem;
begin
//  Logger.Log('Inst: ' + IntToStr(INteger(Self)) + ' LockLogon - UserName: ' + aUserName + ' Database: ' + aDatabaseName + ' Reason: ' + aLockReason, ltDetail);
  if LogonLock.Locked(aDatabaseName, LockRec) then begin
    result:= false;
    msg:= 'Logon is locked by ' + LockRec.LockedByUser.UserName +
      ' for reason: ' + LockRec.LockReason;
//   Logger.Log('    ' + msg,ltDetail);
  end
  else begin
    AppUserItem := GetItemByName(aUserName, aDatabaseName);
    if Assigned(AppUserItem) then begin
      LogonLock.Lock(AppUserItem,aLockReason, aDatabaseName);
      result:= true;
    end
    else begin
      result := false;
      msg := 'Could find user session';
//      Logger.Log('    ' + msg,ltDetail);
    end;
  end;
end;

procedure TAppUserList.RemoveUser(aUserSession: TObject);
var
  x: integer;
  user: TAppUserItem;
  conn: TERPConnection;
  cmd: TERPCommand;
begin
//  Logger.Log('Inst: ' + IntToStr(INteger(Self)) + ' RemoveUser - Session: ' + IntToStr(Integer(aUserSession)),ltDetail);
  for x:= 0 to fList.Count -1 do begin
    user:= Item[x];
    if user.UserSession = aUserSession then begin
      LogonLock.Unlock(user);
      if user.DatabaseName <> '' then begin
        conn:= TERPConnection.Create(nil);
        cmd:= TERPCommand.Create(nil);
        try
          try
            SetConnectionProps(Conn,user.DatabaseName);
            Conn.Connect;
            cmd.Connection:= Conn;
            cmd.SQL.Add('delete from tblInUse');
            cmd.SQL.Add('where UserName = ' + QuotedStr(user.UserName));
            cmd.Execute;
          except
          end;
        finally
          cmd.Free;
          conn.Free;
        end;
      end;
      fList.Delete(x);
      break;
    end;
  end;
//  Logger.Log('    Users: ' + UserNameList,ltDetail);
end;

procedure TAppUserList.RemoveInactiveUsers(InactiveLongerThan: TDateTime);
var
  x: integer;
begin
  x:= 0;
  while x < fList.Count do begin
    if (Item[x].LastTime + InactiveLongerThan) < now then begin
//      Logger.Log('Removing inactive user - UserName: ' + Item[x].UserName + ' Database: ' + Item[x].DatabaseName,ltDetail);
      LogonLock.Unlock(Item[x]);
      fList.Delete(x);
//      Logger.Log('    Users: ' + UserNameList,ltDetail);
    end
    else
      Inc(x);
  end;
end;

procedure TAppUserList.RemoveUser(const aUserName, aDatabaseName: string);
var
  x: integer;
begin
//  Logger.Log('Inst: ' + IntToStr(INteger(Self)) + ' RemoveUser - UserName: ' + aUserName + ' Database: ' + aDatabaseName,ltDetail);
  for x:= 0 to fList.Count -1 do begin
    if (Item[x].UserName = aUserName) and (Item[x].DatabaseName = aDatabaseName) then begin
      LogonLock.Unlock(Item[x]);
      fList.Delete(x);
      break;
    end;
  end;
//  Logger.Log('    Users: ' + UserNameList,ltDetail);
end;

procedure TAppUserList.Unlock;
begin
  fLock.Release;
end;

procedure TAppUserList.UnlockLogon(aUserSession: TObject);
begin
  LogonLock.Unlock(self.GetItemBySession(aUserSession));
end;

procedure TAppUserList.UnlockLogon(aUserName, aDatabaseName: string);
begin
  LogonLock.Unlock(aUserName, aDatabaseName);
end;

function TAppUserList.UserExists(aUserName, aDatabaseName: string): boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to fList.Count -1 do begin
    if SameText(Item[x].UserName,aUserName) and SameText(Item[x].DatabaseName,aDatabaseName) then begin
      result := true;
      break;
    end;
  end;
end;

function TAppUserList.UserNameList(aDatabaseName: string = ''): string;
var
  x: integer;
begin
  result:= '';
  for x:= 0 to fList.Count -1 do begin
    if (aDatabaseName = '') or (Lowercase(aDatabaseName) = Lowercase(Item[x].DatabaseName)) then begin
      if result <> '' then result:= result + ',';
      result:= result + '"' + Item[x].UserName + '"';
    end;
  end;
end;

procedure TAppUserList.UpdateItemLastTime(aUserSession: TObject);
var
  UserItem: TAppUserItem;
begin
  UserItem:= GetItemBySession(aUserSession);
  if Assigned(UserItem) then
    UserItem.LastTime:= now;
end;

function TAppUserList.ListAsJson: TJsonObject;
var
  x: integer;
  itm: TAppUserItem;
  sub: TJsonObject;
begin
  result:= TJsonObject.Create;
  for x:= 0 to self.fList.Count-1 do begin
    itm:= self.Item[x];
    sub:= result.O[IntToStr(x)];
    sub.S['username']:= itm.UserName;
    sub.S['databasename']:= itm.DatabaseName;
    sub.S['firstname']:= itm.FirstName;
    sub.S['lastname']:= itm.LastName;
  end;
end;

{ TLogonLock }

constructor TLogonLock.Create;
begin
  fList:= TThreadList.Create;
end;

destructor TLogonLock.Destroy;
var
  lst: TList;
begin
  lst := fList.LockList;
  try
    while lst.Count > 0 do begin
      TLogonLockRec(lst[0]).Free;
      lst.Delete(0);
    end;
  finally
    fList.UnlockList;
  end;
  fList.Free;
  inherited;
end;

//function TLogonLock.GetItem(index: integer): TLogonLockRec;
//begin
//  result:= TLogonLockRec(fList[index]);
//end;

procedure TLogonLock.Lock(aUserItem: TAppUserItem; aReason: string; aDatabaseName: string);
var
  new: TLogonLockRec;
begin
  new:= TLogonLockRec.Create;
  new.LockedByUser:= aUserItem;
  new.TimeLocked:= NowUTC;
  new.LockReason:= aReason;
  new.DatabaseName:= aDatabaseName;
  new.Locked:= true;
  fList.Add(new);
end;

function TLogonLock.Locked(aDatabaseName: string; var LockRec: TLogonLockRec): boolean;
var
  x: integer;
  lst: TList;
begin
  result:= false;
  lst := fList.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      if (TLogonLockRec(lst[x]).DatabaseName = '') or
         (Lowercase(TLogonLockRec(lst[x]).DatabaseName) = Lowercase(aDatabaseName)) then begin
        LockRec:= TLogonLockRec(lst[x]);
        result:= true;
        break;
      end;
    end;
  finally
    fList.UnlockList;
  end;
end;

procedure TLogonLock.Unlock(aUserName, aDatabaseName: string);
var
  x: integer;
  lst: TList;
  Item: TLogonLockRec;
begin
  lst := fList.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      item := TLogonLockRec(lst[x]);
      if (Assigned(Item.LockedByUser) and (Lowercase(Item.LockedByUser.UserName) = Lowercase(aUserName))) and
         (Lowercase(Item.DatabaseName) = Lowercase(aDatabaseName)) then begin
        Item.Free;
        lst.Delete(x);
        break;
      end;
    end;
  finally
    fList.UnlockList;
  end;
end;

procedure TLogonLock.Unlock(aUserItem: TAppUserItem);
var
  x: integer;
  lst: TList;
  Item: TLogonLockRec;
begin
  lst := fList.LockList;
  try
  for x:= 0 to lst.Count -1 do begin
    Item := TLogonLockRec(lst[x]);
    if Item.LockedByUser = aUserItem then begin
      Item.Free;
      lst.Delete(x);
      break;
    end;
  end;
  finally
    fList.UnlockList;
  end;
end;

end.
