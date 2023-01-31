unit SharedAppUserListObj;

interface

uses
  ERPDBComponents, JsonObject, SyncObjs;

type
  TSharedAppUserList = class
  private
    dbConnection: TERPConnection;
    Lock: SyncObjs.TCriticalSection;
    fTempQuery: TERPQuery;
    fTempCommand: TERPCommand;
  protected
    procedure LogonLock_Lock(aAppUserId: integer; aReason: string; aDatabaseName: string);
    procedure LogonLock_Unlock(aAppUserId: integer); overload;
    procedure LogonLock_Unlock(aUserName: string; aDatabaseName: string); overload;
    procedure ClearInUseTable(const aDatabaseName, aUserName: string); overload;
//    function TempQuery: TERPQuery;
//    function TempCommand: TERPCommand;
  public
    constructor Create(aMySQLServer: string = '127.0.0.1');
    destructor Destroy; override;
    Procedure ResetDatabase(var Msg:String);
//    procedure InitialiseDatabase;
    function AddUser(var msg: string; const aUserName, aDatabaseName: string; aOrganisationKey: string = '';
      aObjectRef: integer = 0; aFirstName: string = ''; aLastName: string = ''; aMultiLogon: boolean = false;
      aSystemUser: boolean = false): boolean;
    procedure RemoveUser(aObjectRef: integer); overload;
    procedure RemoveUser(const aUserName: string; aDatabaseName: string = ''); overload;
    function LockLogon(var msg: string; const aObjectRef: integer; aDatabaseName: string; aLockReason: string; TryCount: integer = 1): boolean;  overload;
    function LockLogon(var msg: string; const aUserName, aDatabaseName, aLockReason: string; TryCount: integer = 1): boolean; overload;
    procedure UnlockLogon(aObjectRef: integer); overload;
    procedure UnlockLogon(aUserName, aDatabaseName: string); overload;
    procedure RemoveInactiveUsers(InactiveLongerThan: TDateTime);
    function UserNameList(aDatabaseName: string = ''): string;
    function ListAsJson: TJsonObject;
    function UserExists(aUserName, aDatabaseName: string): boolean;
    function DatabaseUserCount(aDatabaseName: string; ExcludeMultiLogonUsers: boolean = false; ExcludeSystemUsers: boolean = false): integer;
    function ItemByObjectRef(const aObjectRef: integer; var aUserName, aDatabaseName: string): boolean;
    procedure UpdateItemLastTime(const aObjectRef: integer);
    procedure ClearInUseTable; overload;
    function LogonLock_Locked(const aDatabaseName: string; var aReason, aUserName: string): boolean;
    procedure ClearAppUserList;
    procedure ClearLogonLock;
    class function ExLockLogon(var msg: string; const aUserName, aDatabaseName, aLockReason: string; aMySQLServer: string; TryCount: integer = 1): boolean; overload;
    class procedure ExUnlockLogon(aUserName, aDatabaseName: string; aMySQLServer: string);
    class function ExDatabaseUserCount(aDatabaseName: string; aMySQLServer: string; ExcludeMultiLogonUsers: boolean = false): integer;
    class function ExAddUser(var msg: string; const aUserName, aDatabaseName, aMySQLServer: string; aOrganisationKey: string = '';
      aFirstName: string = ''; aLastName: string = ''; aMultiLogon: boolean = false; aSystemUser: boolean = false; aObjectRef: integer = 0): boolean;
    class procedure ExRemoveUser(const aUserName, aMySQLServer: string; aDatabaseName: string = '');
    class function ExUserExists(aUserName, aDatabaseName, aMySQLServer: string): boolean;
    class procedure ExRemoveInactiveUsers(InactiveLongerThan: TDateTime; aMySQLServer: string);
    class function ExLocked(const aDatabaseName, aMySQLServer: string; var aReason, aUserName: string): boolean;
    class procedure ExClearInUseTables(aMySQLServer: string);
  end;

implementation

uses
  MySQLUtils, DbConst, SysUtils, MySQLConst, Classes, DateTimeUtils,
  ERPDbListObj, DbSharedObjectsObj;

const
  MAX_INACTIVITY_INTERVAL = (1/24/60) * 2; { two minutes}

  tblAppUserList_SQL =
    'CREATE TABLE tblAppUserList ( ' +
    '`Id` INT(11) NOT NULL AUTO_INCREMENT, ' +
    '`UserName` VARCHAR(255) NULL DEFAULT NULL, ' +
    '`FirstName` VARCHAR(255) NULL DEFAULT NULL, ' +
    '`LastName` VARCHAR(255) NULL DEFAULT NULL, ' +
    '`DatabaseName` VARCHAR(255) NULL DEFAULT NULL, ' +
    '`OrganisationKey` VARCHAR(255) NULL DEFAULT NULL, ' +
    '`TimeStamp` DATETIME NULL DEFAULT NULL, ' +
    '`LastTime` DATETIME NULL DEFAULT NULL, ' +
    '`MultiLogon` ENUM("T","F") NULL DEFAULT NULL, ' +
    '`SystemUser` ENUM("T","F") NULL DEFAULT "F", ' +
    '`ObjRef` INT(11) NULL DEFAULT NULL,' +
    'PRIMARY KEY (`Id`)' +
    ') ' +
    'ENGINE=InnoDB COMMENT="TableVersion 2";';

  tblLogonLock_SQL =
    'CREATE TABLE tblLogonLock ( ' +
    '`Id` INT(11) NOT NULL AUTO_INCREMENT, ' +
    '`AppUserId` INT(11) NULL DEFAULT NULL, ' +
    '`TimeLocked` DATETIME NULL DEFAULT NULL, ' +
    '`LockReason` VARCHAR(255) NULL DEFAULT NULL, ' +
    '`Locked` ENUM("T","F") NULL DEFAULT NULL, ' +
    '`DatabaseName` VARCHAR(255) NULL DEFAULT NULL, ' +
    'PRIMARY KEY (`Id`), ' +
    'INDEX `AppUserIdx` (`AppUserId`) ' +
    ') ' +
    'ENGINE=InnoDB COMMENT="TableVersion 1";';


{ TSharedAppUserList }

function TSharedAppUserList.AddUser(var msg: string; const aUserName,
  aDatabaseName: string;  aOrganisationKey: string;
  aObjectRef: integer; aFirstName, aLastName: string; aMultiLogon: boolean; aSystemUSer: boolean): boolean;
var
  reason: string;
  userName: string;
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    msg := 'Unknown';
    Result := False;

    try
      { check for logon lock }
      if LogonLock_Locked(aDatabaseName, reason, userName) then begin
        if not SameText(aUserName, userName) then begin
          msg := 'Can not log on at this time: ' + reason;
          Exit;
        end;
      end;

      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('SELECT * FROM tblAppUserList');
        qry.SQL.Add('WHERE UserName = ' + QuotedStr(aUserName));
        qry.SQL.Add('AND DatabaseName = ' + QuotedStr(aDatabaseName));
        qry.SQL.Add('AND OrganisationKey = ' + QuotedStr(aOrganisationKey));
        qry.Open;

        if not aMultiLogon then begin  { allow multi logon for same user }
          if not qry.IsEmpty then begin
            if now - qry.FieldByName('LastTime').AsDateTime <= MAX_INACTIVITY_INTERVAL then begin
              { this is an active user }
              msg := 'User already logged on';
              Exit;
            end
            else begin
              { remove old "dead" user record from list then continue on to add new record }
              LogonLock_Unlock(qry.FieldByName('Id').AsInteger);
              ClearInUseTable(aDatabaseName, aUserName);
              qry.Delete;
            end;
          end;
        end;

        { just in case user crashed out and logon lock still there .. }
        LogonLock_Unlock(aUserName, aDatabaseName);

        qry.Append;
        qry.FieldByName('UserName').AsString := aUserName;
        qry.FieldByName('DatabaseName').AsString := aDatabaseName;
        qry.FieldByName('OrganisationKey').AsString := aOrganisationKey;
        qry.FieldByName('ObjRef').AsInteger := aObjectRef;
        qry.FieldByName('FirstName').AsString := aFirstName;
        qry.FieldByName('LastName').AsString := aLastName;
        qry.FieldByName('TimeStamp').AsDateTime := NowUTC;
        qry.FieldByName('MultiLogon').AsBoolean := aMultiLogon;
        qry.FieldByName('SystemUser').AsBoolean := aSystemUser;
        qry.FieldByName('LastTime').AsDateTime := Now;
        qry.Post;
        Result := True;

      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    except
      on e: exception do begin
        msg := 'Can not log in: ' + e.Message;
      end;
    end;
  finally
    Lock.Release;
  end;
end;

procedure TSharedAppUserList.ClearInUseTable(const aDatabaseName,
  aUserName: string);
var
  conn: TERPConnection;
  cmd: TERPCommand;
  dbList: TStringList;
begin
  try
    { first make sure db still exists .. may have been removed }
    dbList := TStringList.Create;
    try
      dbConnection.GetDatabaseNames(dbList);
      if dbList.IndexOf(aDatabaseName) < 0 then
        Exit;   { gone so exit }
    finally
      dbList.Free;
    end;

    conn := TERPConnection.Create(nil);
    cmd := TERPCommand.Create(nil);
    try
      SetConnectionProps(conn, self.dbConnection); //  aDatabaseName, );
      conn.Database := aDatabaseName;
      conn.Connect;
      cmd.Connection := conn;
      cmd.SQL.Add('DELETE FROM tblInUse');
      cmd.SQL.Add('WHERE UserName = ' + QuotedStr(aUserName));
      cmd.Execute;
    finally
      cmd.Free;
      conn.Free;
    end;
  except

  end;
end;

procedure TSharedAppUserList.ClearAppUserList;
begin
  dbConnection.ExecSQL('TRUNCATE tblAppUserList', []);
end;

procedure TSharedAppUserList.ClearInUseTable;
var
  cmd: TERPCommand;
  dbList: ERPDbListObj.TERPDbList;
begin
  try
    dbList := ERPDbListObj.TERPDbList.Create(dbConnection.Server);
    cmd := DbSharedObj.GetCommand(dbConnection);
    try
      if dbList.First then begin
        cmd.SQL.Clear;
        cmd.SQL.Text := 'TRUNCATE tblinuse';
        repeat
          cmd.Connection := dbList.Connection;
          cmd.Execute;
        until not dbList.Next;
      end;
    finally
      DbSharedObj.ReleaseObj(cmd);
      dbList.Free;
    end;
  except

  end;
end;

procedure TSharedAppUserList.ClearLogonLock;
begin
  dbConnection.ExecSQL('TRUNCATE tblLogonLock', []);
end;

constructor TSharedAppUserList.Create(aMySQLServer: string);
var
  sl: TStringList;
  dbList: TStringList;
begin
  Lock := SyncObjs.TCriticalSection.Create;
  dbConnection := TERPConnection.Create(nil);
  fTempQuery := nil;
  fTempCommand := nil;

  SetConnectionProps(dbConnection, DbConst.MYSQL_DATABASE, aMySQLServer);
  dbConnection.Connect;
  dbList := TStringList.Create;
  try
    dbConnection.GetDatabaseNames(dbList);
    if dbList.IndexOf(SERVICES_DATABASE) < 0 then begin
      dbConnection.ExecSQL('create database ' + SERVICES_DATABASE,[]);
    end;
  finally
    dbList.Free;
  end;
  dbConnection.Disconnect;
  dbConnection.Database := SERVICES_DATABASE;

  sl := TStringList.Create;
  try
    dbConnection.GetTableNames(sl);
//    if (sl.IndexOf('tblappuserlist') < 0) or (sl.IndexOf('tbllogonlock') < 0) then
//      InitialiseDatabase;
    if (sl.IndexOf('tblappuserlist') < 0) then
      dbConnection.ExecSQL(tblAppUserList_SQL,[])
    else
      CheckUpdateTable('tblappuserlist', tblAppUserList_SQL, dbConnection);

    if (sl.IndexOf('tbllogonlock') < 0) then
      dbConnection.ExecSQL(tblLogonLock_SQL,[])
    else
      CheckUpdateTable('tbllogonlock', tblLogonLock_SQL, dbConnection);

  finally
    sl.Free;
  end;
end;

function TSharedAppUserList.DatabaseUserCount(aDatabaseName: string;
  ExcludeMultiLogonUsers: boolean; ExcludeSystemUsers: boolean): integer;
var
  qry: TERPQuery;
begin
  result := 0;
  Lock.Acquire;
  try
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('SELECT COUNT(Distinct UserName) AS UserCount FROM tblAppUserList');
        if aDatabaseName <> '' then
          qry.SQL.Add('WHERE DatabaseName = ' + QuotedStr(aDatabaseName));

        if ExcludeSystemUsers then begin
          if Pos('WHERE', qry.SQL.Text) > 0 then
            qry.SQL.Add('AND SystemUser <> "T"')
          else
            qry.SQL.Add('WHERE SystemUser <> "T"');
        end;

        if ExcludeMultiLogonUsers then begin
          if Pos('WHERE', qry.SQL.Text) > 0 then
            qry.SQL.Add('AND MultiLogon = "F"')
          else
            qry.SQL.Add('WHERE MultiLogon = "F"');
        end;

        qry.Open;
        result := qry.FieldByName('UserCount').AsInteger;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

destructor TSharedAppUserList.Destroy;
begin
  dbConnection.Free;
  fTempQuery.Free;
  fTempCommand.Free;
  Lock.Free;
  inherited;
end;

class function TSharedAppUserList.ExLocked(const aDatabaseName, aMySQLServer: string;
  var aReason, aUserName: string): boolean;
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    result:= AppUserList.LogonLock_Locked(aDatabaseName, aReason, aUserName);
  finally
    AppUserList.Free;
  end;
end;

class function TSharedAppUserList.ExLockLogon(var msg: string; const aUserName,
  aDatabaseName, aLockReason: string; aMySQLServer: string; TryCount: integer): boolean;
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    result:= AppUserList.LockLogon(msg, aUserName, aDatabaseName, aLockReason, TryCount);
  finally
    AppUserList.Free;
  end;
end;

class procedure TSharedAppUserList.ExRemoveInactiveUsers(
  InactiveLongerThan: TDateTime; aMySQLServer: string);
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    AppUserList.RemoveInactiveUsers(InactiveLongerThan);
  finally
    AppUserList.Free;
  end;
end;

class procedure TSharedAppUserList.ExRemoveUser(const aUserName, aMySQLServer: string;
  aDatabaseName: string);
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    AppUserList.RemoveUser(aUserName, aDatabaseName);
  finally
    AppUserList.Free;
  end;
end;

class procedure TSharedAppUserList.ExUnlockLogon(aUserName,
  aDatabaseName: string; aMySQLServer: string);
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    AppUserList.UnlockLogon(aUserName, aDatabaseName);
  finally
    AppUserList.Free;
  end;
end;

class function TSharedAppUserList.ExUserExists(aUserName,
  aDatabaseName, aMySQLServer: string): boolean;
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    result := AppUserList.UserExists(aUserName, aDatabaseName);
  finally
    AppUserList.Free;
  end;
end;

class function TSharedAppUserList.ExAddUser(var msg: string; const aUserName,
  aDatabaseName, aMySQLServer: string; aOrganisationKey: string; aFirstName, aLastName: string;
  aMultiLogon: boolean; aSystemUser: boolean; aObjectRef: integer): boolean;
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    result := AppUserList.AddUser(msg, aUserName, aDatabaseName, aOrganisationKey, aObjectRef, aFirstName, aLastName, aMultiLogon, aSystemUser);
  finally
    AppUserList.Free;
  end;
end;

class procedure TSharedAppUserList.ExClearInUseTables(aMySQLServer: string);
begin
  with TSharedAppUserList.Create(aMySQLServer) do begin
    try
      ClearInUseTable;
    finally
      Free;
    end;
  end;
end;

class function TSharedAppUserList.ExDatabaseUserCount(aDatabaseName: string;
  aMySQLServer: string;
  ExcludeMultiLogonUsers: boolean): integer;
var
  AppUserList: TSharedAppUserList;
begin
  AppUserList := TSharedAppUserList.Create(aMySQLServer);
  try
    result:= AppUserList.DatabaseUserCount(aDatabaseName, ExcludeMultiLogonUsers);
  finally
    AppUserList.Free;
  end;
end;
Procedure TSharedAppUserList.ResetDatabase(var Msg:String);
var
  cmd: TERPCommand;
  dbList: ERPDbListObj.TERPDbList;
begin
  msg := 'Resetting Databases';
  try
    dbList := ERPDbListObj.TERPDbList.Create(dbConnection.Server);
    cmd := DbSharedObj.GetCommand(dbConnection);
    try
      if dbList.First then begin
        cmd.SQL.Clear;
        cmd.SQL.text := 'update tbldbpreferences Set Fieldvalue ="F" where name = "BatchUpdateInProgress"';
        repeat
          cmd.Connection := dbList.Connection;
          Msg := Msg +chr(13) +chr(10) +cmd.Connection.Database;
          try
            cmd.Execute;
            Msg :=Msg +': BatchUpdateInProgress '
          except
            on E:Exception do begin
              Msg :=Msg +': BatchUpdateInProgress Error -> ' + E.message;
            end;
          end;
        until not dbList.Next;
      end;
    finally
      DbSharedObj.ReleaseObj(cmd);
      dbList.Free;
    end;
  except

  end;

end;
//procedure TSharedAppUserList.InitialiseDatabase;
//var
//  script: TERPScript;
//begin
//  script := TERPScript.Create(nil);
//  try
//    script.Connection := dbConnection;
//    script.SQL.Add('drop table if exists tblLogonLock;');
//
//    script.SQL.Add('create table tblLogonLock (');
//    script.SQL.Add('Id int(11) not null AUTO_INCREMENT,');
//    script.SQL.Add('AppUserId int(11) null,');
//    script.SQL.Add('TimeLocked DateTime null,');
//    script.SQL.Add('LockReason varchar(255) null,');
//    script.SQL.Add('Locked ENUM("T","F") null,');
//    script.SQL.Add('DatabaseName varchar(255) null,');
//    script.SQL.Add('PRIMARY KEY (Id),');
//    script.SQL.Add('INDEX AppUserIdx (AppUserId)');
//    script.SQL.Add(') ENGINE = InnoDB;');
//
//    script.SQL.Add('drop table if exists tblAppUserList;');
//
//    script.SQL.Add('create table tblAppUserList (');
//    script.SQL.Add('Id int(11) not null AUTO_INCREMENT,');
//    script.SQL.Add('UserName varchar(255) null,');
//    script.SQL.Add('FirstName varchar(255) null,');
//    script.SQL.Add('LastName varchar(255) null,');
//    script.SQL.Add('DatabaseName varchar(255) null,');
//    script.SQL.Add('OrganisationKey varchar(255) null,');
//    script.SQL.Add('TimeStamp DateTime null,');
//    script.SQL.Add('LastTime DateTime null,');
//    script.SQL.Add('MultiLogon ENUM("T","F") null,');
//    script.SQL.Add('ObjRef int(11),');
//    script.SQL.Add('PRIMARY KEY (Id)');
//    script.SQL.Add(') ENGINE = InnoDB;');
//
//    script.Execute;
//  finally
//    script.Free;
//  end;
//end;

function TSharedAppUserList.ItemByObjectRef(const aObjectRef: integer;
  var aUserName, aDatabaseName: string): boolean;
var
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    result:= false;
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('SELECT * FROM tblAppUserList');
        qry.SQL.Add('WHERE ObjRef = ' + IntToStr(aObjectRef));
        qry.Open;
        if not qry.IsEmpty then begin
          result:= true;
          aUserName := qry.FieldByName('UserName').AsString;
          aDatabaseName := qry.FieldByName('DatabaseName').AsString;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

function TSharedAppUserList.LockLogon(var msg: string;
  const aObjectRef: integer; aDatabaseName, aLockReason: string; TryCount: integer): boolean;
var
  reason: string;
  userName: string;
  qry: TERPQuery;
  s: string;
  fiuserId :Integer;
  x: integer;
begin
  x := 0;
  repeat
    result := true;
    Lock.Acquire;
    try
      try
        if LogonLock_Locked(aDatabaseName, reason, userName) then begin
          result:= false;
          msg:= 'Logon is locked by ' + userName +
            ' for reason: ' + reason;
        end
        else begin
          qry := DbSharedObj.GetQuery(dbConnection);
          try
            qry.SQL.Clear;
            qry.SQL.Add('SELECT * FROM tblAppUserList');
            qry.SQL.Add('WHERE ObjRef = ' + IntToStr(aObjectRef));
            qry.Open;
            if not qry.IsEmpty then begin
              fiuserId  := qry.FieldByName('Id').AsInteger;
              qry.Close;
              qry.SQL.Clear;
              qry.SQL.Add('SELECT * FROM tblAppUserList');
              qry.SQL.Add('WHERE ObjRef <> ' + IntToStr(aObjectRef));
              qry.SQL.Add('AND DatabaseName = ' + QuotedStr(aDatabaseName));
              qry.Open;
              if not qry.IsEmpty then begin
                while not qry.EOF do begin
                  if s <> '' then s := s + ', ';
                  s := s + qry.FieldByName('UserName').AsString;
                  qry.Next;
                end;
                result := false;
                msg := 'The following user(s) are using the database: ' + s;
                //exit;
              end
              else begin
                LogonLock_Lock(fiuserId , aLockReason, aDatabaseName);
                result := true;
              end;
            end
            else begin
              result := false;
              msg := 'Could not find user session';
            end;
          finally
            DbSharedObj.ReleaseObj(qry);
          end;
        end;
      Except
        on E:Exception do begin
          msg := 'Could not Lock Logon: ' + E.Message;
        end;
      end;
    finally
      Lock.Release;
    end;
    Inc(x);
    if not result then
      sleep(1000);
  until result or (x >= TryCount);
end;

function TSharedAppUserList.ListAsJson: TJsonObject;
var
  sub: TJsonObject;
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    result:= TJsonObject.Create;
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblAppUserList');
        qry.Open;
        while not qry.Eof do begin
          sub:= result.O[IntToStr(result.Count)];

          sub.S['username']:= qry.FieldByName('UserName').AsString;
          sub.S['databasename']:= qry.FieldByName('DatabaseName').AsString;
          sub.S['firstname']:= qry.FieldByName('FirstName').AsString;
          sub.S['lastname']:= qry.FieldByName('LastName').AsString;

          qry.Next;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

function TSharedAppUserList.LockLogon(var msg: string; const aUserName,
  aDatabaseName, aLockReason: string; TryCount: integer): boolean;
var
  reason: string;
  userName: string;
  qry: TERPQuery;
  s: string;
  fiUserID:Integer;
  x: integer;
begin
  x:= 0;
  repeat
    result := true;
    Lock.Acquire;
    try
      try
        if LogonLock_Locked(aDatabaseName, reason, userName) then begin
          result:= false;
          msg:= 'Logon is locked by ' + userName +
            ' for reason: ' + reason;
        end
        else begin
          qry := DbSharedObj.GetQuery(dbConnection);
          try
            qry.SQL.Clear;
            qry.SQL.Add('select * from tblAppUserList');
            qry.SQL.Add('where UserName = ' + QuotedStr(aUserName));
            qry.SQL.Add('and DatabaseName = ' + QuotedStr(aDatabaseName));
            qry.Open;
            if not qry.IsEmpty then begin
              fiuserId  := qry.FieldByName('Id').AsInteger;
              qry.Close;
              qry.SQL.Clear;
              qry.SQL.Add('select * from tblAppUserList');
              qry.SQL.Add('where UserName <> ' + QuotedStr(aUserName));
              qry.SQL.Add('and DatabaseName = ' + QuotedStr(aDatabaseName));
              qry.Open;
              if not qry.IsEmpty then begin
                while not qry.EOF do begin
                  if s <> '' then s := s + ', ';
                  s := s + qry.FieldByName('UserName').AsString;
                  qry.Next;
                end;
                result := false;
                msg := 'The following user(s) are using the database: ' + s;
                //exit;
              end
              else begin
                LogonLock_Lock(fiuserId, aLockReason, aDatabaseName);
                result := true;
              end;
            end
            else begin
              result := false;
              msg := 'Could not find user record for database: ' + aDatabaseName;
            end;
          finally
            DbSharedObj.ReleaseObj(qry);
          end;
        end;
      except
        on e: exception do begin
          msg := 'Could not Lock Logon: ' + e.Message;
        end;
      end;
    finally
      Lock.Release;
    end;
    Inc(x);
    if not result then
      sleep(1000);
  until result or (x >= TryCount);
end;

procedure TSharedAppUserList.LogonLock_Lock(aAppUserId: integer; aReason,
  aDatabaseName: string);
var
  cmd: TERPCommand;
begin
  try
    cmd := DbSharedObj.GetCommand(dbConnection);
    try
      cmd.SQL.Clear;
      cmd.SQL.Add('INSERT INTO tblLogonLock set');
      cmd.SQL.Add('AppUserID = ' + IntToStr(aAppUserId));
      cmd.SQL.Add(',LockReason = ' + QuotedStr(aReason));
      cmd.SQL.Add(',DatabaseName = ' + QuotedStr(aDatabaseName));
      cmd.SQL.Add(',TimeLocked = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, NowUTC)));
      cmd.SQL.Add(',Locked = "T"');
      cmd.Execute;
    finally
      DbSharedObj.ReleaseObj(cmd);
    end;
  except

  end;
end;

function TSharedAppUserList.LogonLock_Locked(const aDatabaseName: string;
  var aReason, aUserName: string): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  try
    qry := DbSharedObj.GetQuery(dbConnection);
    try
      qry.SQL.Clear;
      qry.SQL.Add('SELECT L.LockReason, IFNULL(A.UserName, "") AS UserName');
      qry.SQL.Add('FROM tblLogonLock L LEFT JOIN tblAppUserList A ON L.AppUserId = A.Id');
      qry.SQL.Add('WHERE L.DatabaseName = ""');
      qry.SQL.Add('OR L.DatabaseName = ' + QuotedStr(aDatabaseName));
      qry.Open;
      if not qry.IsEmpty then begin
        Result := true;
        aReason := qry.FieldByName('LockReason').AsString;
        aUserName := qry.FieldByName('UserName').AsString;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  except

  end;
end;

procedure TSharedAppUserList.LogonLock_Unlock(aAppUserId: integer);
var
  cmd: TERPCommand;
begin
  try
    cmd := DbSharedObj.GetCommand(dbConnection);
    try
      cmd.SQL.Clear;
      cmd.SQL.Add('DELETE FROM tblLogonLock');
      cmd.SQL.Add('WHERE AppUserId = ' + IntToStr(aAppUserId));
      cmd.Execute;
    finally
      DbSharedObj.ReleaseObj(cmd);
    end;
  except

  end;
end;

procedure TSharedAppUserList.LogonLock_Unlock(aUserName, aDatabaseName: string);
var
//  cmd: TERPCommand;
  qry: TERPQuery;
begin
  try
//    cmd := TempCommand;
    qry := DbSharedObj.GetQuery(dbConnection);
    try
      qry.SQL.Clear;
      qry.SQL.Add('SELECT Id FROM tblAppUserList WHERE UserName = ' + QuotedStr(aUserName));
      qry.SQL.Add('AND DatabaseName = ' + QuotedStr(aDatabaseName));
      qry.Open;
      while not qry.Eof do begin
        LogonLock_Unlock(qry.FieldByName('Id').AsInteger);
        qry.Next;
      end;

//      cmd.SQL.Clear;
//      cmd.SQL.Add('delete from tblLogonLock');
//      cmd.SQL.Add('where AppUserId in (select Id from tblAppUserList where UserName = ' + QuotedStr(aUserName)+ ')');
//      cmd.SQL.Add('and DatabaseName = ' + QuotedStr(aDatabaseName));
//      cmd.Execute;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  except

  end;
end;

procedure TSharedAppUserList.RemoveUser(aObjectRef: integer);
var
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblAppUserList');
        qry.SQL.Add('where ObjRef = ' + IntToStr(aObjectRef));
        qry.Open;
        while not qry.IsEmpty do begin
          ClearInUseTable(qry.FieldByName('DatabaseName').AsString, qry.FieldByName('UserName').AsString);
          { remove any locks this user has }
          self.LogonLock_Unlock(qry.FieldByName('Id').AsInteger);
          qry.Delete;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

procedure TSharedAppUserList.RemoveInactiveUsers(InactiveLongerThan: TDateTime);
var
  cmd: TERPCommand;
begin
  Lock.Acquire;
  try
    try
      cmd := DbSharedObj.GetCommand(dbConnection);
      try
        cmd.SQL.Clear;
        cmd.SQL.Add('DELETE FROM tblAppUserList');
        cmd.SQL.Add('WHERE LastTime < ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,now - InactiveLongerThan)));
        cmd.Execute;
        cmd.SQL.Clear;
        cmd.SQL.Add('DELETE FROM tblLogonLock');
        cmd.SQL.Add('WHERE NOT tblLogonLock.AppUserID IN (SELECT tblAppUserList.Id FROM tblAppUserList)');
        cmd.Execute;
      finally
        DbSharedObj.ReleaseObj(cmd);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

procedure TSharedAppUserList.RemoveUser(const aUserName: string;
  aDatabaseName: string);
var
  cmd: TERPCommand;
begin
  Lock.Acquire;
  try
    try
      cmd := DbSharedObj.GetCommand(dbConnection);
      try
        cmd.SQL.Clear;
        cmd.SQL.Add('DELETE FROM tblAppUserList');
        cmd.SQL.Add('WHERE UserName = ' + QuotedStr(aUserName));
        if aDatabaseName <> '' then
          cmd.SQL.Add('AND DatabaseName = ' + QuotedStr(aDatabaseName));
        cmd.Execute;

        self.ClearInUseTable(aDatabaseName, aUserName);

        { remove any locks }
        cmd.SQL.Clear;
        cmd.SQL.Add('DELETE FROM tblLogonLock');
        cmd.SQL.Add('WHERE NOT tblLogonLock.AppUserID IN (SELECT tblAppUserList.Id FROM tblAppUserList)');
        cmd.Execute;
      finally
        DbSharedObj.ReleaseObj(cmd);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

//function TSharedAppUserList.TempCommand: TERPCommand;
//begin
//  if not Assigned(fTempCommand) then begin
//    fTempCommand := TERPCommand.Create(nil);
//    fTempCommand.Connection := self.dbConnection;
//  end;
//  result := fTempCommand;
//end;

//function TSharedAppUserList.TempQuery: TERPQuery;
//begin
//  if Not Assigned(fTempQuery) then begin
//    fTempQuery := TERPQuery.Create(nil);
//    fTempQuery.Connection := self.dbConnection;
//  end;
//  if fTempQuery.Connection <> self.dbConnection then
//    fTempQuery.Connection := self.dbConnection;
//  result := fTempQuery;
//end;

procedure TSharedAppUserList.UnlockLogon(aObjectRef: integer);
var
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblAppUserList');
        qry.SQL.Add('where ObjRef = ' + IntToStr(aObjectRef));
        qry.Open;
        if not qry.IsEmpty then begin
          LogonLock_Unlock(qry.FieldByName('Id').AsInteger);
        end;
      finally
        qry.Close;
        DbSharedObj.ReleaseObj(qry);
      end;
    except
    end;
  finally
    Lock.Release;
  end;
end;

procedure TSharedAppUserList.UnlockLogon(aUserName, aDatabaseName: string);
var
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblAppUserList');
        qry.SQL.Add('where UserName = ' + QuotedStr(aUserName));
        qry.SQL.Add('and DatabaseName = ' + QuotedStr(aDatabaseName));
        qry.Open;
        if not qry.IsEmpty then begin
          LogonLock_Unlock(qry.FieldByName('Id').AsInteger);
        end;
      finally
        qry.Close;
        DbSharedObj.ReleaseObj(qry);
      end;
    except
    end;
  finally
    Lock.Release;
  end;
end;

procedure TSharedAppUserList.UpdateItemLastTime(const aObjectRef: integer);
var
  cmd: TERPCommand;
begin
  Lock.Acquire;
  try
    try
      cmd := DbSharedObj.GetCommand(dbConnection);
      try
        cmd.SQL.Clear;
        cmd.SQL.Add('update tblAppUserList');
        cmd.SQL.Add('set LastTime = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,now)));
        cmd.SQL.Add('where ObjRef = ' + IntToStr(aObjectRef));
        cmd.Execute;
      finally
        DbSharedObj.ReleaseObj(cmd);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

function TSharedAppUserList.UserExists(aUserName,
  aDatabaseName: string): boolean;
var
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    result:= false;
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblAppUserList');
        qry.SQL.Add('where UserName = ' + QuotedStr(aUserName));
        qry.SQL.Add('and DatabaseName = ' + QuotedStr(aDatabaseName));
        qry.Open;
        if not qry.IsEmpty then begin
          result := true;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

function TSharedAppUserList.UserNameList(aDatabaseName: string): string;
var
  qry: TERPQuery;
begin
  Lock.Acquire;
  try
    result := '';
    try
      qry := DbSharedObj.GetQuery(dbConnection);
      try
        qry.SQL.Clear;
        qry.SQL.Add('select * from tblAppUserList');
        if aDatabaseName <> '' then begin
          qry.SQL.Add('where DatabaseName = ' + QuotedStr(aDatabaseName));
          qry.SQL.Add('or DatabaseName = ""');
        end;
        qry.Open;
        if not qry.IsEmpty then begin
          while not qry.Eof do begin
            if result <> '' then result:= result + ',';
            result := result + '"' + qry.FieldByName('UserName').AsString + '"';
            qry.Next;
          end;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
    except

    end;
  finally
    Lock.Release;
  end;
end;

end.
