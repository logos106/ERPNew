Unit SrvLockLoginLib;

Interface 

Uses Classes;

Type 
  TLockLoginDetails = Class 
  Public 
    UserID: Integer;
    UserName: String;
    DBName: String;
    Reason: String;
    UseRemoveTime: Boolean;
    RemoveTime: TDateTime;
  End;
Function LockLogin(Const InDetails: TLockLoginDetails): Boolean;
Function UnLockLogin(Const DBName: String): Boolean;
Function IsDBLoginLocked(Var InOutDetails: TLockLoginDetails): Boolean;


Implementation 

Uses SysUtils;

Var 
  LockDBList: TThreadList;

Procedure LockDBListEmpty;
Var 
  l: TList;
Begin 
  l := LockDBList.LockList;
  Try 
    While l.Count > 0 Do Begin 
      TLockLoginDetails(l[0]).Free;
      l.Delete(0);
      l.Pack;
      l.Capacity := l.Count;
    End;
  Finally 
    LockDBList.UnlockList;
  End;
End;

Function LockLogin(Const InDetails: TLockLoginDetails): Boolean;
Var 
  l: TList;
Begin 
  l := LockDBList.LockList;
  Try 
    l.Add(InDetails);
    Result := True;
  Finally 
    LockDBList.UnlockList;
  End;
End;

Function UnLockLogin(Const DBName: String): Boolean;
Var 
  l: TList;
  i: Integer;
Begin 
  Result := False;
  l := LockDBList.LockList;
  Try 
    For i := l.Count Downto 1 Do Begin 
      If SameText(Trim(TLockLoginDetails(l[i - 1]).DBName), Trim(DBName)) Then Begin 
        TLockLoginDetails(l[i - 1]).Free;
        l.Delete(i - 1);
        l.Pack;
        l.Capacity := l.Count;
        Result := True;
      End;
    End;
  Finally 
    LockDBList.UnlockList;
  End;
End;

Procedure CheckRemoveTimeLock;
Var 
  l: TList;
  i: Integer;
Begin 
  l := LockDBList.LockList;
  Try 
    For i := l.Count Downto 1 Do Begin 
      If TLockLoginDetails(l[i - 1]).UseRemoveTime Then Begin 
        If (Now() > TLockLoginDetails(l[i - 1]).RemoveTime) Then Begin 
          TLockLoginDetails(l[i - 1]).Free;
          l.Delete(i - 1);
          l.Pack;
          l.Capacity := l.Count;
        End;
      End;
    End;
  Finally 
    LockDBList.UnlockList;
  End;
End;

Function IsDBLoginLocked(Var InOutDetails: TLockLoginDetails): Boolean;
Var 
  l: TList;
  i: Integer;
Begin 
  Result := False;
  CheckRemoveTimeLock;
  l := LockDBList.LockList;
  Try 
    For i := l.Count Downto 1 Do Begin 
      If SameText(Trim(TLockLoginDetails(l[i - 1]).DBName), Trim(InOutDetails.DBName)) Then Begin 
        InOutDetails.UserID := TLockLoginDetails(l[i - 1]).UserID;
        InOutDetails.UserName := TLockLoginDetails(l[i - 1]).UserName;
        InOutDetails.Reason := TLockLoginDetails(l[i - 1]).Reason;
        Result := True;
      End;
    End;
  Finally 
    LockDBList.UnlockList;
  End;
End;



Initialization 
  LockDBList := TThreadList.Create;
Finalization
  LockDBListEmpty;
  LockDBList.Free;
End.
