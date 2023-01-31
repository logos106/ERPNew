Unit PresentListObj;

Interface 

Uses Classes, SysUtils;

Type 
  TPresent = Class 
  Public 
    EmployeeID: Integer;
    DbName: String;
    PeerIP: String;
    PeerName: String;
    lastPing: TDateTime;
    Valid: Boolean;
    Constructor Create;
  End;
  TPresentList = Class 
  Private 
    FPresentList: TThreadList;
  Public 
    Constructor Create;
    Destructor Destroy; Override;
    Procedure FindUser(Const aEmployeeID: Integer; Const adbName: String; Var PresentUser: TPresent);
    Procedure GetEntry(Const aEmployeeID: Integer; Const adbName, aPeerIP: String; Var PresentUser: TPresent); Overload;
    Procedure GetEntry(Const index: Integer; Var PresentUser: TPresent); Overload;
    Procedure Refresh(Const aEmployeeID: Integer; Const adbName, aPeerIP, aPeerName: String);
    Procedure RemoveOlderThan(Const dt: TDateTime);
    Function Count: Integer;
  End;

Implementation 

Function TPresentList.Count: Integer;
Begin 
  Result := FPresentList.LockList.Count;
  FPresentList.UnlockList;
End;

Constructor TPresentList.Create;
Begin 
  Inherited;
  FPresentList := TThreadList.Create;
End;

Destructor TPresentList.Destroy;
Var 
  l: TList;
Begin 
  l := FPresentList.LockList;
  While l.Count > 0 Do Begin 
    TPresent(l[0]).Free;
    l.Delete(0);
    l.Pack;
    l.Capacity := l.Count;
  End;
  FPresentList.UnlockList;
  FPresentList.Free;
  Inherited Destroy;
End;

Procedure TPresentList.FindUser(Const aEmployeeID: Integer; Const adbname: String; Var PresentUser: TPresent);
Var 
  l: TList;
  i: Integer;
Begin 
  l := FPresentList.LockList;
  Try 
    For i := 0 To l.Count - 1 Do Begin 
      If SameText(TPresent(l[i]).dbName, adbname) And (TPresent(l[i]).EmployeeID = aEmployeeID) Then Begin 
        If Assigned(PresentUser) Then Begin 
          PresentUser.EmployeeID := TPresent(l[i]).EmployeeID;
          PresentUser.DbName := TPresent(l[i]).DbName;
          PresentUser.PeerIP := TPresent(l[i]).PeerIP;
          PresentUser.PeerName := TPresent(l[i]).PeerName;
          PresentUser.lastPing := TPresent(l[i]).lastPing;
          PresentUser.Valid := True;
        End;
        Break;
      End;
    End;
  Finally 
    FPresentList.UnlockList;
  End;
End;

Procedure TPresentList.GetEntry(Const aEmployeeID: Integer; Const adbname, aPeerIP: String; Var PresentUser: TPresent);
Var 
  l: TList;
  i: Integer;
Begin 
  l := FPresentList.LockList;
  Try 
    For i := 0 To l.Count - 1 Do Begin 
      If SameText(TPresent(l[i]).DbName, adbname) And (TPresent(l[i]).EmployeeID = aEmployeeID) And (TPresent(l[i]).PeerIP = aPeerIP) Then Begin 
        If Assigned(PresentUser) Then Begin 
          PresentUser.EmployeeID := TPresent(l[i]).EmployeeID;
          PresentUser.DbName := TPresent(l[i]).DbName;
          PresentUser.PeerIP := TPresent(l[i]).PeerIP;
          PresentUser.PeerName := TPresent(l[i]).PeerName;
          PresentUser.lastPing := TPresent(l[i]).lastPing;
          PresentUser.Valid := True;
        End;
        Break;
      End;
    End;
  Finally 
    FPresentList.UnlockList;
  End;
End;

Procedure TPresentList.GetEntry(Const index: Integer; Var PresentUser: TPresent);
Var 
  l: TList;
Begin 
  l := FPresentList.LockList;
  Try 
    If l.Count > index Then If Assigned(PresentUser) Then Begin 
        PresentUser.EmployeeID := TPresent(l[index]).EmployeeID;
        PresentUser.DbName := TPresent(l[index]).DbName;
        PresentUser.PeerIP := TPresent(l[index]).PeerIP;
        PresentUser.PeerName := TPresent(l[index]).PeerName;
        PresentUser.lastPing := TPresent(l[index]).lastPing;
        PresentUser.Valid := True;
      End;
  Finally 
    FPresentList.UnlockList;
  End;
End;

Procedure TPresentList.Refresh(Const aEmployeeID: Integer; Const adbname, aPeerIP, aPeerName: String);
Var 
  l: TList;
  i: Integer;
  CurrentUser: TPresent;
Begin 
  CurrentUser := Nil;
  l := FPresentList.LockList;
  Try 
    For i := 0 To l.Count - 1 Do Begin 
      If SameText(TPresent(l[i]).DbName, adbname) And (TPresent(l[i]).EmployeeID = aEmployeeID) And (TPresent(l[i]).PeerIP = aPeerIP) Then Begin 
        CurrentUser := TPresent(l[i]);
        Break;
      End;
    End;
    If Assigned(CurrentUser) Then Begin 
      CurrentUser.PeerIP := aPeerIP;
      CurrentUser.PeerName := aPeerName;
      CurrentUser.lastPing := Now;
    End Else Begin 
      CurrentUser := TPresent.Create;
      CurrentUser.EmployeeID := aEmployeeID;
      CurrentUser.DbName := adbname;
      CurrentUser.PeerIP := aPeerIP;
      CurrentUser.PeerName := aPeerName;
      CurrentUser.lastPing := Now;
      l.Add(CurrentUser);
    End;
  Finally 
    FPresentList.UnlockList;
  End;
End;

Procedure TPresentList.RemoveOlderThan(Const dt: TDateTime);
Var 
  l: TList;
  i: Integer;
Begin 
  l := FPresentList.LockList;
  Try 
    For i := l.Count Downto 1 Do Begin 
      If TPresent(l[i - 1]).lastPing < dt Then Begin 
        TPresent(l[i - 1]).Free;
        l.Delete(i - 1);
        l.Pack;
        l.Capacity := l.Count;
      End;
    End;
  Finally 
    FPresentList.UnlockList;
  End;
End;

Constructor TPresent.Create;
Begin 
  Inherited;
  Self.Valid := False;
End;

End.
