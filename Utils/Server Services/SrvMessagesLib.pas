Unit SrvMessagesLib;

Interface 

Uses Classes;

Type 
  TMessageType = (mtNormal, mtFlash, mtPopUp, mtTerminate, mtVerify, mtBatchUpdate, mtEmailedReports);
  TMessage     = Class 
  Public 
    ID: ShortString;
    EmployeeID: Integer;
    DBName: String;
    msgType: TMessageType;
    HeaderMsg: String;
    Msg: String;
    ExtraXML: String;
    Valid: Boolean;
  End;
Procedure GetNextMessageInQueue(Const aEmployeeID: Integer; Const aDBName: String; Var aMessage: TMessage);
Procedure AddMessageToQueue(Const aUserMessage: TMessage);
Procedure RemoveMessageFromQueue(Const aUserMessage: TMessage);
Procedure MessageListEmpty;

Implementation 

Uses SysUtils;

Var 
  MessageList: TThreadList;

Procedure GetNextMessageInQueue(Const aEmployeeID: Integer; Const aDBName: String; Var aMessage: TMessage);
Var 
  l: TList;
  i: Integer;
Begin 
  l := MessageList.LockList;
  Try 
    If Assigned(aMessage) Then Begin 
      For i := 0 To l.Count - 1 Do Begin 
        If SameText(Trim(TMessage(l[i]).DBName), Trim(aDBName)) And ((TMessage(l[i]).EmployeeID = aEmployeeID) Or (TMessage(l[i]).EmployeeID = -1)) Then Begin 
          aMessage.ID := TMessage(l[i]).ID;
          aMessage.EmployeeID := TMessage(l[i]).EmployeeID;
          aMessage.DbName := TMessage(l[i]).DbName;
          aMessage.HeaderMsg := TMessage(l[i]).HeaderMsg;
          aMessage.msgType := TMessage(l[i]).msgType;
          aMessage.Msg := TMessage(l[i]).Msg;
          aMessage.ExtraXML := TMessage(l[i]).ExtraXML;
          aMessage.Valid := True;
          Break;
        End;
      End;
    End;
  Finally 
    MessageList.UnlockList;
  End;
End;

Procedure AddMessageToQueue(Const aUserMessage: TMessage);
Var 
  l: TList;
Begin 
  l := MessageList.LockList;
  Try 
    Randomize;
    aUserMessage.ID    := FormatDateTime('yyyymmddhhnnsszzz', Now()) + FloatToStr(Random);
    aUserMessage.Valid := False;
    l.Add(aUserMessage);
  Finally 
    MessageList.UnlockList;
  End;
End;

Procedure RemoveMessageFromQueue(Const aUserMessage: TMessage);
Var 
  l: TList;
  i: Integer;
Begin 
  l := MessageList.LockList;
  Try 
    For i := 0 To l.Count - 1 Do Begin 
      If SameText(TMessage(l[i]).ID, aUserMessage.ID) Then Begin 
        TMessage(l[i]).Free;
        l.Delete(i);
        Break;
      End;
    End;
    l.Pack;
    l.Capacity := l.Count;
  Finally 
    MessageList.UnlockList;
  End;
End;

Procedure MessageListEmpty;
Var 
  l: TList;
Begin 
  l := MessageList.LockList;
  Try 
    While l.Count > 0 Do Begin 
      TMessage(l[0]).Free;
      l.Delete(0);
      l.Pack;
      l.Capacity := l.Count;
    End;
  Finally 
    MessageList.UnlockList;
  End;
End;

Initialization 
  MessageList := TThreadList.Create;

Finalization 
  MessageListEmpty;
  MessageList.Free;
End.
