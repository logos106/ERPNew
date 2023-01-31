Unit SrvMultisiteNagLib;

Interface 

Uses Classes;

Type 
  TMultisiteNoNag = Class 
  Public 
    DBName: String;
  End;
Function IsMultisiteDB(Const DBName: String): Boolean;
Function ResetMultisiteNag(Const DBName: String): Boolean;
Function StopMultisiteNag(Const InDetails: TMultisiteNoNag): Boolean;
Function IsMutisiteNagStopped(Const DBName: String): Boolean;
Function MultisiteCheckDB(Const DBName: String): String;

Implementation 

Uses SysUtils, MyAccess, SrvServiceFunctionLib;

Var 
  MutisiteNagDBList: TThreadList;

Procedure MutisiteNagDBListEmpty;
Var 
  l: TList;
Begin 
  l := MutisiteNagDBList.LockList;
  Try 
    While l.Count > 0 Do Begin 
      TMultisiteNoNag(l[0]).Free;
      l.Delete(0);
      l.Pack;
      l.Capacity := l.Count;
    End;
  Finally 
    MutisiteNagDBList.UnlockList;
  End;
End;

Function ResetMultisiteNag(Const DBName: String): Boolean;
Var 
  l: TList;
  i: Integer;
Begin 
  Result := False;
  l := MutisiteNagDBList.LockList;
  Try 
    For i := l.Count Downto 1 Do Begin 
      If SameText(Trim(TMultisiteNoNag(l[i - 1]).DBName), Trim(DBName)) Then Begin 
        TMultisiteNoNag(l[i - 1]).Free;
        l.Delete(i - 1);
        Result := True;
      End;
    End;
    l.Pack;
    l.Capacity := l.Count;
  Finally 
    MutisiteNagDBList.UnlockList;
  End;
End;

Function StopMultisiteNag(Const InDetails: TMultisiteNoNag): Boolean;
Var 
  l: TList;
Begin 
  l := MutisiteNagDBList.LockList;
  Try 
    l.Add(InDetails);
    Result := True;
  Finally 
    MutisiteNagDBList.UnlockList;
  End;
End;

Function IsMutisiteNagStopped(Const DBName: String): Boolean;
Var 
  l: TList;
  i: Integer;
Begin 
  Result := False;
  l := MutisiteNagDBList.LockList;
  Try 
    For i := l.Count Downto 1 Do Begin 
      If SameText(Trim(TMultisiteNoNag(l[i - 1]).DBName), Trim(DBName)) Then Begin 
        Result := True;
      End;
    End;
  Finally 
    MutisiteNagDBList.UnlockList;
  End;
End;

Function LastSentCheck(Const DBName: String): String;
Var 
  qryTemp: TMyQuery;
  DBConnection: TMyConnection;
Begin 
  Result := '';
  DBConnection := CreateDBConnection(Nil, DBName);
  qryTemp := TMyQuery.Create(Nil);
  Try 
    qryTemp.Options.FlatBuffers := True;
    If Not Assigned(DBConnection) Then Exit;
    qryTemp.Connection := DBConnection;
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT * FROM tblmsbackendid ');
    qryTemp.SQL.Add('WHERE `BEDefault` = "T" ');
    qryTemp.SQL.Add('AND DATE_ADD(SentStamp,INTERVAL 1 DAY) < Now();');
    qryTemp.Open;
    If qryTemp.RecordCount > 0 Then Begin 
      qryTemp.First;
      While Not qryTemp.Eof Do Begin 
        With qryTemp Do Begin 
          Result := Result + '- Your Multisite Site ' + FieldByName('SiteDesc').AsString + ' (' + FieldByName('SiteCode').AsString + ') Has Not Sent In the Last 24 hrs.' + CRLF_STR;
        End;
        qryTemp.Next;
      End;
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(qryTemp);
    FreeAndNil(DBConnection);
  End;
End;

Function LastReceivedCheck(Const DBName: String): String;
Var 
  qryTemp: TMyQuery;
  DBConnection: TMyConnection;
Begin 
  Result := '';
  DBConnection := CreateDBConnection(Nil, DBName);
  qryTemp := TMyQuery.Create(Nil);
  Try 
    qryTemp.Options.FlatBuffers := True;
    If Not Assigned(DBConnection) Then Exit;
    qryTemp.Connection := DBConnection;
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT * FROM tblmsbackendid ');
    qryTemp.SQL.Add('WHERE `BEDefault` = "F" ');
    qryTemp.SQL.Add('AND DATE_ADD(ReceivedStamp,INTERVAL 1 DAY) < Now();');
    qryTemp.Open;
    If qryTemp.RecordCount > 0 Then Begin 
      qryTemp.First;
      While Not qryTemp.Eof Do Begin 
        With qryTemp Do Begin 
          Result := Result + '- Have Not Received from Multisite Site ' + FieldByName('SiteDesc').AsString + ' (' + FieldByName('SiteCode').AsString + ') In the Last 24 hrs.' + CRLF_STR;
        End;
        qryTemp.Next;
      End;
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(DBConnection);
    FreeAndNil(qryTemp);
  End;
End;

Function IsMultisiteDB(Const DBName: String): Boolean;
Var 
  qryTemp: TMyQuery;
  DBConnection: TMyConnection;
Begin 
  Result := False;
  DBConnection := CreateDBConnection(Nil, DBName);
  qryTemp := TMyQuery.Create(Nil);
  Try 
    qryTemp.Options.FlatBuffers := True;
    If Not Assigned(DBConnection) Then Exit;
    qryTemp.Connection := DBConnection;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SHOW TABLES FROM `' + DBName + '`;');
    qryTemp.Open;
    qryTemp.Filter   := qryTemp.Fields[0].FieldName + '=' + QuotedStr('tblmsbackendid');
    qryTemp.Filtered := True;
    If qryTemp.RecordCount = 1 Then Begin 
      qryTemp.Close;
      qryTemp.Filter := '';
      qryTemp.Filtered := False;
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('SELECT * FROM `tblmsbackendid`;');
      qryTemp.Open;
      Result := (qryTemp.RecordCount > 1);
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(DBConnection);
    FreeAndNil(qryTemp);
  End;
End;

Function MultisiteCheckDB(Const DBName: String): String;
Begin 
  Result := '';
  If IsMultisiteDB(DBName) Then Begin 
    Result := LastSentCheck(DBName);
    If Not Empty(Result) Then Result := Result + CRLF_STR + LastReceivedCheck(DBName)
    Else Result := LastReceivedCheck(DBName);
  End;
End;

Initialization 
  MutisiteNagDBList := TThreadList.Create;

Finalization 
  MutisiteNagDBListEmpty;
  MutisiteNagDBList.Free;
End.
