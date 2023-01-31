unit PreferenceLib;

interface
  uses UserLockObj , classes;

type

  TPrefLib = class(TComponent)
  Private
    fUserLock :TUserLock;
    Procedure UnLockDBPref;
    function LockDBPref(Var LockMessage:String):Boolean;
    function UserLock :TUserLock;
  Public
    constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
  end;

  Procedure UnLockPreferenceTable;
  function LockPreferenceTable(Var LockMessage:String): Boolean;
  function GetDbPrefStr(aPrefType, aName: string): string;
  procedure SetDbPrefValue(aPrefType, aName, aValue: string);

Threadvar
  fPrefLib : TPrefLib;

implementation

uses Sysutils, CommonLib, forms, dialogs, ErpDbComponents, CommonDbLib,
  PreferancesLib;

Procedure TPrefLib.UnLockDBPref;
begin
    UserLock.unLock('tbldbpreferences' , 0 , '' ) ;
end;

function TPrefLib.LockDBPref(Var LockMessage:String):Boolean;
begin
  LockMessage :='';
    REsult := UserLock.LockAll('tbldbpreferences' , '');
    if not result then begin
      if UserLock.LockInfo.UserName = '' then begin
        LockMessage :='';
      end else begin
          LockMessage :='Unable to Lock Preference.' + #13#10;
          if (UserLock.UserName <> '') and (UserLock.UserName = UserLock.LockInfo.Username) then
            LockMessage :=LockMessage+ 'You are already currently accessing this '
          else LockMessage :=LockMessage+ 'Currently the User "' + UserLock.LockInfo.Username + '" is accessing this ';
          LockMessage :=LockMessage+ #13 + #10 + ' since: ' + FormatDateTime('dd/mm hh:nn:ss', UserLock.LockInfo.TimeLocked)+'.';
      end;
    end;
end;

Procedure UnLockPreferenceTable;
begin
  if not(Assigned(fPrefLib)) then fPrefLib:= TPrefLib.create(Application);
  if not(assigned(fPrefLib)) then exit;
  fPrefLib.UnLockDBPref;
end;

function LockPreferenceTable(Var LockMessage:String):Boolean;
begin
  Result := false;
  if not(Assigned(fPrefLib)) then fPrefLib:= TPrefLib.create(Application);
  if not(assigned(fPrefLib)) then exit;
   result := fPrefLib.LockDBPref(LockMessage);
end;

function TPrefLib.UserLock :TUserLock;
begin
  if not(Assigned(fUserLock)) then fUserLock :=TUSerLock.Create(self);
  result := fUserLock;
end;

function GetDbPrefStr(aPrefType, aName: string): string;
var
  qry: TErpQuery;
begin
  qry:= TErpQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select FieldValue from tbldbpreferences');
    qry.SQL.Add('where PrefType = ' + QuotedStr(aPrefType));
    qry.SQL.Add('and Name = ' + QuotedStr(aName));
    qry.Open;
    result:= qry.FieldByName('FieldValue').AsString;
  finally
    qry.Free;
  end;
end;

procedure SetDbPrefValue(aPrefType, aName, aValue: string);
var
  cmd: TErpCommand;
begin
  cmd:= TErpCommand.Create(nil);
  try
    cmd.Connection:= CommonDbLib.GetSharedMyDacConnection;
    cmd.SQL.Add('update tbldbpreferences');
    cmd.SQL.Add('set FieldValue = ' + QuotedStr(aValue));
    cmd.SQL.Add('where PrefType = ' + QuotedStr(aPrefType));
    cmd.SQL.Add('and Name = ' + QuotedStr(aName));
    cmd.Execute;
    Preferanceslib.DoPrefAuditTrail;
  finally
    cmd.Free;
  end;
end;


{ TPrefLib }

constructor TPrefLib.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrefLib.Destroy;
begin
  Freeandnil(fUSerLock);
  inherited;
end;

initialization

end.

