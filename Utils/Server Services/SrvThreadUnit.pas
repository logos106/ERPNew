Unit SrvThreadUnit;

{$INCLUDE ServerServices.inc}

Interface 

Uses IdTCPServer, Classes, LibXmlParser, MyAccess, LbClass, Windows, kbmMemTable, kbmMemBinaryStreamFormat, Variants;

Type 
  TServicesThread = Class(TComponent)
  Private 
    FThreadID: Integer;
    FStream: TMemoryStream;
    FPeerIP: String;
    Procedure doFileTransfer(Const parms: TStringList);
    Procedure doQuery(Const parms: TStringList);
    Procedure doExec(Const parms: TStringList);
    Procedure doXML(Const parms: TStringList);
    Procedure doXPresent(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXAlert(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXFlashAlert(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXPopupAlert(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXUserTerminate(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXExec(Const XmlParser: TXmlParser);
    Procedure doXLogin(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXLockLogin(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXUnLockLogin(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXStopMultisiteNag(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXResetMultisiteNag(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doXMultisiteCheck(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doGetServerMID(Const slResultExec: TStringList);
    Procedure doGetLicence(Const slResultExec: TStringList);
    Procedure doSetLicence(Const XmlParserOrg: TXmlParser; Const slResultExec: TStringList);
    Procedure doSlotAvailable(Const XmlParserOrg: TXmlParser; Const slResultExec: TStringList);
    Procedure ResetLicence(Var SlotAvailable: Integer; Var LicenceReset: Boolean);
    Procedure Decode(Const tblServerLicence, tblClientSlots: TMyTable; Var SlotAvailable: Integer; Var DateBeforeLastLogin: Boolean; Var licenceReset: Boolean; Const LbBlowfish: TLbBlowfish);
    Function VerifyData(Const tblServerLicence, tblClientSlots: TMyTable; Const LbBlowfish: TLbBlowfish): Boolean;
    Procedure Encode(Const Reset: Boolean; Const CompanyName: String; Const tblServerLicence, tblClientSlots: TMyTable; Const LbBlowfish: TLbBlowfish);
    Procedure AddClient(Const ID: Integer; Const tblClientSlots: TMyTable; Const LbBlowfish: TLbBlowfish);
    Function IsLoggedIn(Const userid, dbname: String; Const tblClientSlots: TMyTable): Boolean;
    Function SetClient(Const mName, mid, userid, dbname: String; Const SlotAvailable: Integer; Const LbBlowfish: TLbBlowfish; Const tblClientSlots: TMyTable): Boolean;
    Procedure doSendEmailedReports(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doBatchUpdate(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
    Procedure doVerify(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
  Public 
    Procedure doRun(Const ThreadID: Integer; Const SentBuffer, PeerIP: String; Var MemStream: TMemoryStream);
  End;

Implementation 

Uses SynchedThreads, SysUtils, SrvServiceFunctionLib, SrvLockLoginLib, SrvMultisiteNagLib, SrvService, PresentListObj, MemLogLib, SrvMessagesLib, DateUtils;

Procedure TServicesThread.doExec(Const parms: TStringList);
Var 
  p: Integer;
  resultFileName, Prog, ProgParms: String;
  ServiceFilePath, Path: String;
  partParms: String;
  slResultExec: TStringList;
  Buffer: Array[0..260] Of Char;
Begin 
  slResultExec := TStringList.Create;
  Try 
    Prog      := ExtractFileName(parms.Values['Prog']);
    ProgParms := parms.Values['Parms'] + ' ' + IntToStr(FThreadID);
    If SameText(Prog, 'ERP.exe') Then Begin 
      Path := ERPPATH 
    End Else Begin 
      Path := EXECPATH;
    End;
    SetString(ServiceFilePath, Buffer, GetModuleFileName(0, Buffer, SizeOf(Buffer)));
    SetCurrentDir(ExtractFilePath(ServiceFilePath));
    If FileExists(Path + prog) Then Begin 
      partparms := '';
      p := Pos(' ', ProgParms);
      If p > 0 Then partParms := Copy(ProgParms, 1, p);
      log('         ' + prog + ' ' + partParms);
      MsgWaitForSingleObject(SpawnProcess('"' + Path + prog + '" ' + ProgParms).hProcess);
      resultFileName := EXECPATH + 'Result' + IntToStr(FThreadID) + '.tmp';
      If FileExists(resultFileName) Then Begin 
        slResultExec.LoadFromFile(resultFileName);
        If Copy(slResultExec[0], 1, 2) = 'OK' Then Begin 
          Log(prog + ' OK')
        End Else Begin 
          Log(prog + ' Error');
          DeleteFile(resultFileName);
        End;
      End;
    End Else Begin 
      slResultExec.Text := 'Error File: ' + Path + prog + ' not found';
    End;
    slResultExec.SaveToStream(FStream);
  Finally 
    slResultExec.Clear;
    FreeAndNil(slResultExec);
  End;
End;

Procedure TServicesThread.doFileTransfer(Const parms: TStringList);
Begin 
  If FileExists(parms[1]) Then FStream.LoadFromFile(parms[1]);
End;

Procedure TServicesThread.doGetLicence(Const slResultExec: TStringList);
Var 
  res: String;
  tblServerLicence: TMyTable;
  DBConnection: TMyConnection;
Begin 
  res := '';
  tblServerLicence := TMyTable.Create(Self);
  DBConnection := CreateDBConnection(Self, '');
  Try 
    If Not Assigned(DBConnection) Then Exit;
    With tblServerLicence Do Begin 
      Connection := DBConnection;
      Tablename := 'tblServerLicence';
      Open;
      First;
      res := tblServerLicence.FieldByName('Data').AsString;
      Close;
    End;
    slResultExec.Add('<LICENCE servermid="' + GetMachineID + '" code="' + res + '"/>');
  Finally 
    FreeAndNil(tblServerLicence);
    FreeAndNil(DBConnection);
  End;
End;

Procedure TServicesThread.doGetServerMID(Const slResultExec: TStringList);
Begin 
  slResultExec.Add('<SERVERMID mid="' + GetMachineId + '"/>');
End;

Procedure TServicesThread.doQuery(Const parms: TStringList);
Var 
  MyQuery: TMyQuery;
  MyConnection: TMyConnection;
  mt: TkbmMemTable;
  fmt: TkbmBinaryStreamFormat;
Begin 
  MyQuery := TMyQuery.Create(Self);
  MyConnection := TMyConnection.Create(Self);
  mt := TkbmMemTable.Create(Self);
  fmt := TkbmBinaryStreamFormat.Create(Self);
  Try 
    MyQuery.Options.FlatBuffers := True;
    mt.DefaultFormat := fmt;
    mt.EmptyTable;
    MyConnection.database := parms.Values['DB'];
    MyConnection.userName := parms.Values['DBUser'];
    MyConnection.passWord := parms.Values['DBPW'];
    If Not SrvServiceFunctionLib.TestDBConnectionOk(MyConnection) Then Exit;
    If MyConnection.Connected Then Begin
      MyQuery.Connection := MyConnection;
      MyQuery.SQL.Clear;
      MyQuery.SQL.Text := parms.Values['SQL'];
      MyQuery.Open;
      mt.LoadFromDataSet(MyQuery, [mtcpoStructure, mtcpoOnlyActiveFields, mtcpoProperties]);
      MyQuery.Close;
      MyConnection.Disconnect;
      mt.Active := True;
      mt.SaveToStream(FStream);
      mt.EmptyTable;
      mt.Close;
    End;
    MyConnection.Disconnect;
  Finally 
    mt.EmptyTable;
    FreeAndNil(MyQuery);
    FreeAndNil(MyConnection);
    FreeAndNil(mt);
    FreeAndNil(Fmt);
  End;
End;

Procedure TServicesThread.doRun(Const ThreadID: Integer; Const SentBuffer, PeerIP: String; Var MemStream: TMemoryStream);
Var 
  parms, slResultExec: TStringList;
Begin 
  FStream := MemStream;
  FThreadID := ThreadID;
  FPeerIP := PeerIP;
  slResultExec := TStringList.Create;
  parms := TStringList.Create;
  Try 
    Try 
      parms.Clear;
      parms.Text := SentBuffer;
      If SameText(parms[0], 'QUERY') Then Begin 
        MemLogLib.LogAction('QUERY');
        Log(FPeerIP + ' ' + parms[0] + ' ' + parms[1]);
        doQuery(parms);
      End Else If SameText(Parms[0], 'EXEC') Then Begin 
        MemLogLib.LogAction('EXEC');
        Log(FPeerIP + ' ' + parms[0] + ' ' + parms[1]);
        doExec(parms);
      End Else If SameText(Parms[0], 'FILETRANSFER') Then Begin 
        MemLogLib.LogAction('FILETRANSFER');
        Log(FPeerIP + ' ' + parms[0] + ' ' + parms[1]);
        doFileTransfer(parms);
      End Else If SameText(Parms[0], 'SHOWLOG') Then Begin 
        MemLogLib.LogAction('SHOWLOG');
        memLog.SaveToStream(FStream);
      End Else If SameText(Parms[0], 'PING') Then Begin 
        MemLogLib.LogAction('PING');
        slResultExec.Add('OK ' + FormatDateTime('yyyymmdd hhnnss', Now));
        slResultExec.SaveToStream(FStream);
      End Else If SameText(Parms[0], 'XML') Then Begin 
        MemLogLib.LogAction('XML');
        parms.Delete(0);
        doXML(parms);
      End;
    Except 
      On E: Exception Do Begin 
        slResultExec.Add('Services Error: ' + E.Message);
        slResultExec.SaveToStream(FStream);
      End;
    End;
  Finally 
    slResultExec.Clear;
    parms.Clear;
    slResultExec.Free;
    parms.Free;
  End;
End;

Procedure TServicesThread.doSetLicence(Const XmlParserOrg: TXmlParser; Const slResultExec: TStringList);
Var 
  receivedLicence: String;
  receivedLicenceDecoded: String;
  mid, mn, expires, begins, licence, noClientSlots, ClientID, CompanyName, LicenceID, noMultiSites, xml: String;
  begDate, expDate: TDateTime;
  XMLParser: TXMLParser;
  LbBlowfish: TLbBlowfish;
  i: Integer;
  tblClientSlots: TMyTable;
  tblServerLicence: TMyTable;
  DBConnection: TMyConnection;
  resultString: String;
Begin 
  mid := '';
  mn := '';
  begins := '';
  expires := '';
  licence := '';
  noClientSlots := '';
  ClientID := '';
  CompanyName := '';
  LicenceID := '';
  receivedLicence := XmlParserOrg.CurAttr.Value('code');
  If receivedLicence > '' Then Begin 
    tblClientSlots   := TMyTable.Create(Self);
    tblServerLicence := TMyTable.Create(Self);
    DBConnection     := CreateDBConnection(Self, '');
    LbBlowfish       := TLbBlowfish.Create(Self);
    XMLParser        := TXMLParser.Create;
    Try 
      If Not Assigned(DBConnection) Then Exit;
      With tblServerLicence Do Begin 
        Connection := DBConnection;
        Tablename := 'tblServerLicence'
      End;
      With tblClientSlots Do Begin 
        Connection := DBConnection;
        Tablename := 'tblClientSlots';
      End;
      LbBlowfish.GenerateKey(GetMachineID + GetMachineID);
      receivedLicenceDecoded := LbBlowfish.DecryptString(receivedLicence);
      With XMLParser Do Begin 
        Clear;
        LoadFromBuffer(@receivedLicenceDecoded[1]);
        If Scan And (CurPartType = ptEmptyTag) And SameText(CurName, 'Licence') Then Begin 
          mid := CurAttr.Value('machineid');
          begins := CurAttr.Value('begins');
          expires := CurAttr.Value('expires');
          licence := CurAttr.Value('licence');
          noClientSlots := CurAttr.Value('noclientslots');
          ClientID := CurAttr.Value('clientid');
          LicenceID := CurAttr.Value('licenceid');
          companyName := CurAttr.Value('companyname');
          noMultiSites := CurAttr.Value('nomultisites');
        End;
      End;
      If Length(expires) = 10 Then Begin 
        expDate := EncodeDate(StrToInt(Copy(expires, 1, 4)), StrToInt(Copy(expires, 6, 2)), StrToInt(Copy(expires, 9, 2)));
        If expDate > Date Then Begin 
          If Length(begins) = 10 Then Begin 
            begDate := EncodeDate(StrToInt(Copy(begins, 1, 4)), StrToInt(Copy(begins, 6, 2)), StrToInt(Copy(begins, 9, 2)))
          End Else Begin 
            begDate := 0.0;
          End;
          tblServerLicence.EmptyTable;
          tblServerLicence.Open;
          tblServerLicence.Append;
          tblServerLicence.FieldByName('Data').AsString := receivedLicence;
          tblServerLicence.FieldByName('MachineID').AsString := mid;
          tblServerLicence.FieldByName('Begins').AsDateTime := begDate;
          tblServerLicence.FieldByName('Expires').AsDateTime := expDate;
          tblServerLicence.FieldByName('Licence').AsString := licence;
          tblServerLicence.FieldByName('noClientSlots').AsString := noClientSlots;
          tblServerLicence.FieldByName('ClientID').AsString := ClientID;
          tblServerLicence.FieldByName('LicenceID').AsString := LicenceID;
          tblServerLicence.FieldByName('CompanyName').AsString := companyName;
          tblServerLicence.FieldByName('NoMultisites').AsString := noMultiSites;
          tblServerLicence.Post;
          tblServerLicence.Close;
          tblClientSlots.EmptyTable;
          tblClientSlots.Open;
          For i := 1 To StrToIntDef(noClientSlots, 1) Do Begin 
            tblClientSlots.Append;
            tblClientSlots.FieldByName('MachineID').AsString := '';
            tblClientSlots.FieldByName('MachineName').AsString := '';
            tblClientSlots.FieldByName('DBName').AsString := '';
            tblClientSlots.FieldByName('userID').AsString := '';
            xml := '<ClientSlot machineid="" machinename="" dbname="" userid=""/>';
            tblClientSlots.FieldByName('Data').AsString := LbBlowfish.EncryptString(xml);
            tblClientSlots.Post;
          End;
          tblClientSlots.Close;
          resultString := Format('<SETLICENCE result="OK" expires="%s" noclients="%s"/>', [FormatDateTime('yyyy.mm.dd', expDate), noClientSlots]);
        End Else Begin 
          resultString := '<SETLICENCE result="Error"/>';
        End;
      End Else Begin 
        resultString := '<SETLICENCE result="Error"/>';
      End;
      slResultExec.Add(resultString);
    Finally 
      FreeAndNil(tblClientSlots);
      FreeAndNil(tblServerLicence);
      FreeAndNil(DBConnection);
      XmlParser.Clear;
      FreeAndNil(XmlParser);
      FreeAndNil(LbBlowfish);
    End;
  End;
End;

Procedure TServicesThread.doXExec(Const XmlParser: TXmlParser);
Var 
  p: Integer;
  resultFileName, Prog, ProgParms: String;
  Path: String;
  partParms: String;
  slResultExec: TStringList;
Begin 
  slResultExec := TStringList.Create;
  Try 
    Prog      := XmlParser.CurAttr.Value('program');
    ProgParms := XmlParser.CurAttr.Value('params') + ' ' + IntToStr(FThreadID);
    If SameText(Prog, 'ERP.exe') Then Begin
      Path := ERPPATH
    End Else If SameText(Prog, 'AutoUpdate.exe') Then Begin 
      Path := AUTOUPDATEPATH 
    End Else Begin 
      Path := EXECPATH;
    End;
    SetCurrentDir(Path);
    If FileExists(Path + prog) Then Begin 
      partparms := '';
      p := Pos(' ', ProgParms);
      If p > 0 Then partParms := Copy(ProgParms, 1, p);
      log('         ' + prog + ' ' + partParms);
      MsgWaitForSingleObject(SpawnProcess('"' + Path + prog + '" ' + ProgParms).hProcess);
      resultFileName := EXECPATH + 'Result' + IntToStr(FThreadID) + '.tmp';
      If FileExists(resultFileName) Then Begin 
        slResultExec.LoadFromFile(resultFileName);
        If Copy(slResultExec[0], 1, 2) = 'OK' Then Begin 
          Log(prog + ' OK');
        End Else Begin 
          Log(prog + ' Error');
        End;
        DeleteFile(resultFileName);
      End;
    End Else Begin 
      slResultExec.Text := 'Error File: ' + Path + prog + ' not found';
    End;
    slResultExec.SaveToStream(FStream);
  Finally 
    FreeAndNil(slResultExec);
  End;
End;

Procedure TServicesThread.doXAlert(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  i: Integer;
  ResultString: String;
  NewMessage: TMessage;
  CurrentUser: TPresent;
Begin 
  For i := 0 To PresentList.Count - 1 Do Begin 
    CurrentUser := TPresent.Create;
    Try 
      PresentList.GetEntry(i, CurrentUser);
      If CurrentUser.Valid Then Begin 
        If SameText(CurrentUser.DbName, XmlParser.CurAttr.Value('dbname')) Then Begin 
          NewMessage := TMessage.Create;
          NewMessage.EmployeeID := CurrentUser.Employeeid;
          NewMessage.DBName := XmlParser.CurAttr.Value('dbname');
          NewMessage.msgType := mtNormal;
          NewMessage.HeaderMsg := '';
          NewMessage.Msg := XmlParser.CurAttr.Value('msg');
          SrvMessagesLib.AddMessageToQueue(NewMessage);
        End;
      End;
    Finally 
      CurrentUser.Free;
    End;
  End;
  ResultString := 'Popup Alert Queued.';
  slResultExec.Add(ResultString);
  Log(ResultString);
End;

Procedure TServicesThread.doXFlashAlert(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  i: Integer;
  ResultString: String;
  NewMessage: TMessage;
  CurrentUser: TPresent;
Begin 
  For i := 0 To PresentList.Count - 1 Do Begin 
    CurrentUser := TPresent.Create;
    Try 
      PresentList.GetEntry(i, CurrentUser);
      If CurrentUser.Valid Then Begin 
        If SameText(CurrentUser.DbName, XmlParser.CurAttr.Value('dbname')) Then Begin 
          NewMessage := TMessage.Create;
          NewMessage.EmployeeID := CurrentUser.Employeeid;
          NewMessage.DBName := XmlParser.CurAttr.Value('dbname');
          NewMessage.msgType := mtFlash;
          NewMessage.HeaderMsg := '';
          NewMessage.Msg := XmlParser.CurAttr.Value('msg');
          SrvMessagesLib.AddMessageToQueue(NewMessage);
        End;
      End;
    Finally 
      CurrentUser.Free;
    End;
  End;
  ResultString := 'Flash Alert Queued.';
  slResultExec.Add(ResultString);
  Log(ResultString);
End;

Procedure TServicesThread.doXPopupAlert(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  i: Integer;
  ResultString: String;
  NewMessage: TMessage;
  CurrentUser: TPresent;
Begin 
  For i := 0 To PresentList.Count - 1 Do Begin 
    CurrentUser := TPresent.Create;
    Try 
      PresentList.GetEntry(i, CurrentUser);
      If CurrentUser.Valid Then Begin 
        If SameText(CurrentUser.DbName, XmlParser.CurAttr.Value('dbname')) Then Begin 
          NewMessage := TMessage.Create;
          NewMessage.EmployeeID := CurrentUser.Employeeid;
          NewMessage.DBName := XmlParser.CurAttr.Value('dbname');
          NewMessage.msgType := mtPopUp;
          NewMessage.HeaderMsg := XmlParser.CurAttr.Value('hmsg');
          NewMessage.Msg := XmlParser.CurAttr.Value('msg');
          SrvMessagesLib.AddMessageToQueue(NewMessage);
        End;
      End;
    Finally 
      CurrentUser.Free;
    End;
  End;
  ResultString := 'Popup Alert Queued.';
  slResultExec.Add(ResultString);
  Log(ResultString);
End;

Procedure TServicesThread.doXUnLockLogin(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  res: String;
Begin 
  res := 'Error';
  Try 
    If SrvLockLoginLib.UnLockLogin(XmlParser.CurAttr.Value('dbname')) Then res := 'OK';
  Finally 
    slResultExec.Add(res);
  End;
End;

Procedure TServicesThread.doXLockLogin(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  res: String;
  LockLoginDetails: TLockLoginDetails;
Begin 
  res := 'Error';
  Try 
    LockLoginDetails          := TLockLoginDetails.Create;
    LockLoginDetails.UserID   := StrToIntDef(XmlParser.CurAttr.Value('userid'), 0);
    LockLoginDetails.UserName := XmlParser.CurAttr.Value('username');
    LockLoginDetails.DBName   := XmlParser.CurAttr.Value('dbname');
    LockLoginDetails.Reason   := XmlParser.CurAttr.Value('reason');
    LockLoginDetails.UseRemoveTime := False;
    If SrvLockLoginLib.LockLogin(LockLoginDetails) Then res := 'OK';
  Finally 
    slResultExec.Add(res);
  End;
End;

Procedure TServicesThread.doXLogin(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  res: String;
  tblClientSlots: TMyTable;
  DBConnection: TMyConnection;
Begin 
  res := 'Error';
  tblClientSlots := TMyTable.Create(Self);
  DBConnection := CreateDBConnection(Self, '');
  Try 
    If Not Assigned(DBConnection) Then Exit;
    With tblClientSlots Do Begin 
      Connection := DBConnection;
      Tablename := 'tblClientSlots';
      Open;
      If Locate('userID; DBName', VarArrayOf([XmlParser.CurAttr.Value('userid'), XmlParser.CurAttr.Value('dbname')]), []) Then Begin 
        Edit;
        tblClientSlots.FieldByName('LastActive').AsDateTime := Now();
        Post;
        res := 'OK';
      End;
      Close;
    End;
    slResultExec.Add(res);
  Finally 
    FreeAndNil(tblClientSlots);
    FreeAndNil(DBConnection);
  End;
End;

Procedure TServicesThread.doXML(Const parms: TStringList);
Var 
  StrBuffer: PChar;
  XmlParser: TXmlParser;
  slResultExec: TStringList;
Begin 
  slResultExec := TStringList.Create;
  XmlParser := TXmlParser.Create;
  Try 
    With XmlParser Do Begin 
      StrBuffer := parms.GetText;
      Try 
        LoadFromBuffer(StrBuffer);
      Finally 
        StrDispose(StrBuffer);
      End;
      Normalize := False;
      StartScan;
      If Scan And (CurPartType = ptStartTag) And SameText(CurName, 'ERPMsg') Then Begin 
        While Scan Do If (CurPartType = ptStartTag) Or (CurPartType = ptEmptyTag) Then Begin 
            If SameText(CurName, 'PRESENT') Then Begin 
              MemLogLib.LogAction('XML - PRESENT');
              doXPresent(XmlParser, slResultExec);
            End Else If SameText(CurName, 'ALERT') Then Begin 
              MemLogLib.LogAction('XML - ALERT');
              doXAlert(XmlParser, slResultExec);
            End Else If SameText(CurName, 'FLASHALERT') Then Begin 
              MemLogLib.LogAction('XML - FLASHALERT');
              doXFlashAlert(XmlParser, slResultExec);
            End Else If SameText(CurName, 'POPUPALERT') Then Begin 
              MemLogLib.LogAction('XML - POPUPALERT');
              doXPopupAlert(XmlParser, slResultExec);
            End Else If SameText(CurName, 'EXEC') Then Begin 
              MemLogLib.LogAction('XML - EXEC');
              doXExec(XmlParser);
            End Else If SameText(CurName, 'TERMINATEUSERS') Then Begin 
              MemLogLib.LogAction('XML - TERMINATEUSERS');
              doXUserTerminate(XmlParser, slResultExec);
            End Else If SameText(CurName, 'LOGIN') Then Begin 
              MemLogLib.LogAction('XML - LOGIN');
              doXLogin(XmlParser, slResultExec);
            End Else If SameText(CurName, 'LOCKLOGIN') Then Begin 
              MemLogLib.LogAction('XML - LOCKLOGIN');
              doXLockLogin(XmlParser, slResultExec);
            End Else If SameText(CurName, 'UNLOCKLOGIN') Then Begin 
              MemLogLib.LogAction('XML - UNLOCKLOGIN');
              doXUnLockLogin(XmlParser, slResultExec);
            End Else If SameText(CurName, 'STOPMULTISITENAG') Then Begin 
              MemLogLib.LogAction('XML - STOPMULTISITENAG');
              doXStopMultisiteNag(XmlParser, slResultExec);
            End Else If SameText(CurName, 'RESETMULTISITENAG') Then Begin 
              MemLogLib.LogAction('XML - RESETMULTISITENAG');
              doXResetMultisiteNag(XmlParser, slResultExec);
            End Else If SameText(CurName, 'MULTISITECHECK') Then Begin 
              MemLogLib.LogAction('XML - MULTISITECHECK');
              doXMultisiteCheck(XmlParser, slResultExec);
            End Else If SameText(CurName, 'SLOTAVAILABLE') Then Begin 
              MemLogLib.LogAction('XML - SLOTAVAILABLE');
              doSlotAvailable(XmlParser, slResultExec);
            End Else If SameText(CurName, 'GETSERVERMID') Then Begin 
              MemLogLib.LogAction('XML - GETSERVERMID');
              doGetServerMid(slResultExec);
            End Else If SameText(CurName, 'GETLICENCE') Then Begin 
              MemLogLib.LogAction('XML - GETLICENCE');
              doGetLicence(slResultExec);
            End Else If SameText(CurName, 'SETLICENCE') Then Begin 
              MemLogLib.LogAction('XML - SETLICENCE');
              doSetLicence(XmlParser, slResultExec);
            End Else If SameText(CurName, 'VERIFY') Then Begin 
              MemLogLib.LogAction('XML - VERIFY');
              doVerify(XmlParser, slResultExec);
            End Else If SameText(CurName, 'BATCH') Then Begin 
              MemLogLib.LogAction('XML - BATCH');
              doBatchUpdate(XmlParser, slResultExec);
            End Else If SameText(CurName, 'EMAILEDREPORTS') Then Begin 
              MemLogLib.LogAction('XML - EMAILEDREPORTS');
              doSendEmailedReports(XmlParser, slResultExec);
            End Else Begin 
              MemLogLib.LogAction('XML - Invalid');
              slResultExec.Text := FPeerIP + ' Error: Invalid XML Msg: ' + CurName + ' ServerVersion: ' + VERSION;
              Log(slResultExec.Text);
            End;
          End;
      End;
    End;
    slResultExec.SaveToStream(FStream);
  Finally 
    XmlParser.Clear;
    XmlParser.Free;
    slResultExec.Clear;
    slResultExec.Free;
  End;
End;

Procedure TServicesThread.doXPresent(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  MsgTypeString, ResultString: String;
  i: Integer;
  CurrentUser: TPresent;
  CurrentUserMessage: TMessage;
  XMLType: String;
Begin 
  With XmlParser Do Begin 
    PresentList.Refresh(StrToIntDef(CurAttr.Value('employeeid'), 0), CurAttr.Value('dbname'), FPeerIP, CurAttr.Value('pcname'));
    ResultString := '';
    For i := 0 To PresentList.Count - 1 Do Begin 
      CurrentUser := TPresent.Create;
      Try 
        PresentList.GetEntry(i, CurrentUser);
        If CurrentUser.Valid Then Begin 
          With CurrentUser Do ResultString := ResultString + '<CLIENT ' + 'peerip="' + PeerIP + '" ' + 'peername="' + PeerName + '" ' + 'employeeid="' + IntToStr(Employeeid) + '" ' + 'dbname="' + DbName + '" ' + '></CLIENT>';
        End;
      Finally 
        CurrentUser.Free;
      End;
    End;
    CurrentUserMessage := TMessage.Create;
    Try 
      SrvMessagesLib.GetNextMessageInQueue(StrToIntDef(CurAttr.Value('employeeid'), 0), CurAttr.Value('dbname'), CurrentUserMessage);
      If CurrentUserMessage.Valid Then Begin 
        Case CurrentUserMessage.msgType Of 
          mtNormal:
          Begin 
            XMLType := 'ALERT';
            MsgTypeString := '';
          End;
          mtFlash:
          Begin 
            XMLType := 'ALERT';
            MsgTypeString := ' flash="True"';
          End;
          mtPopUp:
          Begin 
            XMLType := 'ALERT';
            MsgTypeString := ' popup="True"';
          End;
          mtTerminate:
          Begin 
            XMLType := 'TERMINATEUSERS';
            MsgTypeString := ' ' + CurrentUserMessage.ExtraXML;
          End;
          mtVerify:
          Begin 
            XMLType := 'VERIFY';
            MsgTypeString := '';
          End;
          mtBatchUpdate:
          Begin 
            XMLType := 'BATCHUPDATE';
            MsgTypeString := '';
          End;
          mtEmailedReports:
          Begin 
            XMLType := 'EMAILEDREPORTS';
            MsgTypeString := '';
          End;
        End;
        ResultString := ResultString + '<' + XMLType + ' msg="' + CurrentUserMessage.Msg + '" hmsg="' + CurrentUserMessage.HeaderMsg + '"' + MsgTypeString + '></' + XMLType + '>';
        SrvMessagesLib.RemoveMessageFromQueue(CurrentUserMessage);
        Log('Msg sent to: ' + CurrentUserMessage.DbName + ' ' + IntToStr(CurrentUserMessage.EmployeeID));
      End;
    Finally 
      CurrentUserMessage.Free;
    End;
    slResultExec.Add(ResultString);
  End;
End;

Procedure TServicesThread.doSlotAvailable(Const XmlParserOrg: TXmlParser; Const slResultExec: TStringList);
Var 
  mid, mname: String;
  companyName: String;
  userid: String;
  dbname: String;
  licenceReset: Boolean;
  DateBeforeLastLogin: Boolean;
  slotAvailable: Integer;
  attrReset, attrReset2: String;
  denyReason: TDenyReason;
  LbBlowfish: TLbBlowfish;
  tblClientSlots: TMyTable;
  tblServerLicence: TMyTable;
  DBConnection: TMyConnection;
  resultString: String;
  LockLoginDetails: TLockLoginDetails;
Begin 
  resultString := '';
  licenceReset := False;
  slResultExec.Clear;
  tblClientSlots := TMyTable.Create(Self);
  tblServerLicence := TMyTable.Create(Self);
  DBConnection := CreateDBConnection(Self, '');
  LbBlowfish := TLbBlowfish.Create(Self);
  Try 
    If Not Assigned(DBConnection) Then Exit;
    With tblServerLicence Do Begin 
      Connection := DBConnection;
      Tablename := 'tblServerLicence';
      Open;
    End;
    With tblClientSlots Do Begin 
      Connection := DBConnection;
      Tablename := 'tblClientSlots';
      Open;
    End;
    LbBlowfish.GenerateKey(GetMachineID + GetMachineID);
    mid         := XmlParserOrg.CurAttr.Value('machineid');
    mname       := XmlParserOrg.CurAttr.Value('machinename');
    companyName := XmlParserOrg.CurAttr.Value('companyname');
    userid      := XmlParserOrg.CurAttr.Value('userid');
    dbname      := XmlParserOrg.CurAttr.Value('dbname');
    Decode(tblServerLicence, tblClientSlots, SlotAvailable, DateBeforeLastLogin, licenceReset, LbBlowfish);
    If licenceReset Then Encode(True, companyName, tblServerLicence, tblClientSlots, LbBlowfish);
    attrReset        := ' expires="' + FormatDateTime('yyyy-mm-dd', tblServerLicence.FieldByName('Expires').AsDateTime) + '" licence="' + tblServerLicence.FieldByName('Licence').AsString + '" noclientslots="' + tblServerLicence.FieldByName('NoClientSlots').AsString + '" serverid="' + tblServerLicence.FieldByName('MachineId').AsString + '" servicesversion="' + VERSION + '"';
    DenyReason       := drNone;
{$IFNDEF DevMode}
    LockLoginDetails := TLockLoginDetails.Create;
    Try 
      LockLoginDetails.DBName := dbname;
      If SrvLockLoginLib.IsDBLoginLocked(LockLoginDetails) Then Begin 
        DenyReason := drDatabaseLocked;
      End Else If licenceReset And (tblServerLicence.RecordCount > 0) Then Begin 
        DenyReason := drLicenceReset 
      End Else If tblServerLicence.FieldByName('Licence').AsString = '' Then Begin 
        DenyReason := drNoLicence 
      End Else If tblServerLicence.FieldByName('MachineId').AsString <> GetMachineID Then Begin 
        DenyReason := drUnregisteredServer 
      End Else If tblServerLicence.FieldByName('Expires').AsDateTime < Date Then Begin 
        DenyReason := drExpired 
      End Else If DateBeforeLastLogin Then Begin 
        DenyReason := drInvalidDate 
      End Else If IsLoggedIn(userid, dbname, tblClientSlots) Then Begin 
        DenyReason := drLoggedInAlready 
      End Else If Not SetClient(mName, mid, userid, dbname, SlotAvailable, LbBlowfish, tblClientSlots) Then Begin 
        DenyReason := drNoSlotAvailable;
      End;
      If DenyReason <> drNone Then Case DenyReason Of 
          drExpired: attrReset2 := ' conflict="Licence Expired"';
          drInvalidDate: attrReset2 := ' conflict="Machinedate Invalid"';
          drUnregisteredServer: attrReset2 := ' conflict="Unregistered Server"';
          drNoLicence: attrReset2 := ' conflict="No Licence"';
          drLoggedInAlready: attrReset2 := ' conflict="Logged in already (Wait a minute after logout)"';
          drNoSlotAvailable: attrReset2 := ' conflict="No Slot Available"';
          drLicenceReset: attrReset2 := ' conflict="Licence reset"';
          drDatabaseLocked: attrReset2 := ' conflict="' + LockLoginDetails.UserName + ' is ' + LockLoginDetails.Reason + '"';
        End;
    Finally 
      LockLoginDetails.Free;
    End;
{$ENDIF}
    If DenyReason In [drNone, drLicenceReset] Then Begin
      attrReset := attrReset + attrReset2;
      resultString := '<SLOTAVAILABLE permission="Granted"' + attrReset + '/>';
    End Else Begin 
      attrReset := attrReset + attrReset2;
      resultString := '<SLOTAVAILABLE permission="Denied"' + attrReset + '/>';
    End;
    slResultExec.Add(resultString);
    Log(resultString + ' (' + mname + ')');
  Finally 
    FreeAndNil(tblClientSlots);
    FreeAndNil(tblServerLicence);
    FreeAndNil(DBConnection);
    FreeAndNil(LbBlowfish);
  End;
End;

Procedure TServicesThread.ResetLicence(Var SlotAvailable: Integer; Var LicenceReset: Boolean);
Begin 
  SlotAvailable := 1;
  LicenceReset := True;
End;

Procedure TServicesThread.Decode(Const tblServerLicence, tblClientSlots: TMyTable; Var SlotAvailable: Integer; Var DateBeforeLastLogin: Boolean; Var licenceReset: Boolean; Const LbBlowfish: TLbBlowfish);
Begin 
  SlotAvailable := 0;
  If tblServerLicence.RecordCount = 0 Then Begin 
    ResetLicence(SlotAvailable, LicenceReset);
    Exit;
  End;
  tblServerLicence.First;
  If Not VerifyData(tblServerLicence, tblClientSlots, LbBlowfish) Then Begin 
    ResetLicence(SlotAvailable, LicenceReset);
    Exit;
  End;
  DateBeforeLastLogin := False;
  tblClientSlots.First;
  While Not tblClientSlots.Eof Do Begin 
    If (tblClientSlots.FieldByName('LastActive').AsDateTime > Now) Or (Date < tblServerLicence.FieldByName('Begins').AsDateTime - 1) Then DateBeforeLastLogin := True;
    If (tblClientSlots.FieldByName('MachineName').AsString + tblClientSlots.FieldByName('MachineID').AsString = '') And (slotAvailable = 0) Then slotAvailable := tblClientSlots.FieldByName('ID').AsInteger;
    tblClientSlots.Next;
  End;
End;

Function TServicesThread.VerifyData(Const tblServerLicence, tblClientSlots: TMyTable; Const LbBlowfish: TLbBlowfish): Boolean;
Var 
  Data: String;
  XMLParser: TXMLParser;
Begin 
  Result := False;
  XMLParser := TXMLParser.Create;
  Try 
    If tblServerLicence.RecordCount = 0 Then Begin 
      Result := True;
      Exit;
    End;
    tblServerLicence.First;
    Data := LbBlowfish.DecryptString(tblServerLicence.FieldByName('Data').AsString);
    XMLParser.SetBuffer(@Data[1]);
    XMLParser.StartScan;
    While XMLParser.Scan Do If (XMLParser.CurPartType = ptStartTag) Or (XMLParser.CurPartType = ptEmptyTag) Then If SameText(XMLParser.CurName, 'Licence') Then If (XMLParser.CurAttr.Value('licence') = tblServerLicence.FieldByName('Licence').AsString) And (XMLParser.CurAttr.Value('licenceid') = tblServerLicence.FieldByName('LicenceID').AsString) And (XMLParser.CurAttr.Value('begins') = FormatDateTime('yyyy-mm-dd', tblServerLicence.FieldByName('Begins').AsDateTime)) And (XMLParser.CurAttr.Value('expires') = FormatDateTime('yyyy-mm-dd', tblServerLicence.FieldByName('Expires').AsDateTime)) And (XMLParser.CurAttr.Value('machineid') = tblServerLicence.FieldByName('MachineID').AsString) And (XMLParser.CurAttr.Value('noclientslots') = tblServerLicence.FieldByName('NoClientSlots').AsString) And (XMLParser.CurAttr.Value('nomultisites') = tblServerLicence.FieldByName('NoMultiSites').AsString) And (XMLParser.CurAttr.Value('clientid') = tblServerLicence.FieldByName('ClientID').AsString) Then Begin 
            If tblClientSlots.RecordCount = tblServerLicence.FieldByName('NoClientSlots').AsInteger Then Begin 
              tblClientSlots.First;
              While Not tblClientSlots.Eof Do Begin 
                If tblClientSlots.FieldByName('Data').AsString = '' Then Exit;
                Data := LbBlowfish.DecryptString(tblClientSlots.FieldByName('Data').AsString);
                XMLParser.Clear;
                XMLParser.SetBuffer(@Data[1]);
                XMLParser.StartScan;
                While XMLParser.Scan Do If (XMLParser.CurPartType = ptStartTag) Or (XMLParser.CurPartType = ptEmptyTag) Then If SameText(XMLParser.CurName, 'ClientSlot') Then If (XMLParser.CurAttr.Value('machineid') = tblClientSlots.FieldByName('MachineID').AsString) And (XMLParser.CurAttr.Value('machinename') = tblClientSlots.FieldByName('MachineName').AsString) And (XMLParser.CurAttr.Value('userid') = tblClientSlots.FieldByName('userID').AsString) And (XMLParser.CurAttr.Value('dbname') = tblClientSlots.FieldByName('DBName').AsString) Then Break 
                    Else Exit;
                tblClientSlots.Next;
              End;
              Result := True;
              Exit;
            End;
          End;
  Finally 
    XmlParser.Clear;
    FreeAndNil(XmlParser);
  End;
End;

Procedure TServicesThread.Encode(Const Reset: Boolean; Const CompanyName: String; Const tblServerLicence, tblClientSlots: TMyTable; Const LbBlowfish: TLbBlowfish);
Var 
  xml: String;
Begin 
  If Reset Then Begin 
    With tblServerLicence Do Begin 
      Close;
      EmptyTable;
      Open;
      Append;
      xml := '<Licence machineid="' + GetMachineID + '" begins="' + FormatDateTime('yyyy-mm-dd', Date) + '" expires="' + FormatDateTime('yyyy-mm-dd', Date + 2) + '" companyname="' + EscapeForXML(companyName) + '" clientid="' + '" licence="' + 'Install' + '" licenceid="' + '" noclientslots="1' + '" nomultisites="1' + '"/>';
      FieldByName('Data').AsString := LbBlowfish.EncryptString(xml);
      FieldByName('MachineID').AsString := GetMachineID;
      FieldByName('begins').AsDateTime := Date;
      FieldByName('expires').AsDateTime := Date + 2;
      FieldByName('companyname').AsString := companyName;
      FieldByName('clientid').AsString := '';
      FieldByName('licence').AsString := 'Install';
      FieldByName('licenceid').AsString := '';
      FieldByName('noclientslots').AsString := '1';
      FieldByName('nomultisites').AsString := '1';
      Post;
    End;
    tblClientSlots.Close;
    tblClientSlots.EmptyTable;
    tblClientSlots.Open;
    AddClient(1, tblClientSlots, LbBlowfish);
  End;
End;

Procedure TServicesThread.AddClient(Const ID: Integer; Const tblClientSlots: TMyTable; Const LbBlowfish: TLbBlowfish);
Var 
  xml: String;
Begin 
  With tblClientSlots Do Begin 
    If Not Locate('ID', ID, []) Then Begin 
      Insert;
      FieldByName('ID').AsInteger := ID;
      FieldByName('MachineID').AsString := '';
      FieldByName('MachineName').AsString := '';
      FieldByName('DBName').AsString := '';
      FieldByName('userid').AsString := '';
      xml := '<ClientSlot machineid="' + '' + '" machinename="' + '' + '" dbname="' + '' + '" userid="' + '' + '"/>';
      FieldByName('Data').AsString := LbBlowfish.EncryptString(xml);
      Post;
    End;
  End;
End;

Function TServicesThread.IsLoggedIn(Const userid, dbname: String; Const tblClientSlots: TMyTable): Boolean;
Begin 
  Result := tblClientSlots.Locate('UserID;DBName', VarArrayOf([userid, dbname]), []);
End;

Function TServicesThread.SetClient(Const mName, mid, userid, dbname: String; Const SlotAvailable: Integer; Const LbBlowfish: TLbBlowfish; Const tblClientSlots: TMyTable): Boolean;
Var 
  xml: String;
Begin 
  Result := slotAvailable > 0;
  If Result Then Begin 
    With tblClientSlots Do Begin 
      If Locate('ID', slotAvailable, []) Then Begin 
        Edit;
        FieldByName('MachineID').AsString := mid;
        FieldByName('MachineName').AsString := mname;
        FieldByName('DBName').AsString := dbname;
        FieldByName('userid').AsString := userid;
        xml := '<ClientSlot machineid="' + mid + '" machinename="' + mname + '" dbname="' + dbname + '" userid="' + userid + '"/>';
        FieldByName('Data').AsString := LbBlowfish.EncryptString(xml);
        Post;
      End;
    End;
  End;
End;

Procedure TServicesThread.doXResetMultisiteNag(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  res: String;
Begin 
  res := 'Error';
  Try 
    If SrvMultisiteNagLib.ResetMultisiteNag(XmlParser.CurAttr.Value('dbname')) Then res := 'OK';
  Finally 
    slResultExec.Add(res);
  End;
End;

Procedure TServicesThread.doXStopMultisiteNag(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  res: String;
  MultisiteNag: TMultisiteNoNag;
Begin 
  res := 'Error';
  Try 
    MultisiteNag        := TMultisiteNoNag.Create;
    MultisiteNag.DBName := XmlParser.CurAttr.Value('dbname');
    If SrvMultisiteNagLib.StopMultisiteNag(MultisiteNag) Then res := 'OK';
  Finally 
    slResultExec.Add(res);
  End;
End;

Procedure TServicesThread.doXMultisiteCheck(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  testStr, msgStr, requestXml: String;
Begin 
  Try 
    msgStr := SrvMultisiteNagLib.MultisiteCheckDB(XmlParser.CurAttr.Value('dbname'));
    If Empty(msgStr) Then testStr := 'pass'
    Else testStr := 'fail';
    requestXml := '<ERPMsg><MULTISITERESULT' + ' result="' + testStr + '" msg="' + msgStr + '" hmsg="Multisite Synchronisation Alert' + '"/></ERPMsg>';
  Finally
    slResultExec.Add(requestXml);
  End;
End;

Procedure TServicesThread.doXUserTerminate(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  i: Integer;
  ResultString: String;
  NewMessage: TMessage;
  CurrentUser: TPresent;
  LockLoginDetails: TLockLoginDetails;
Begin 
  LockLoginDetails := TLockLoginDetails.Create;
  LockLoginDetails.UserID := StrToIntDef(XmlParser.CurAttr.Value('userid'), 0);
  LockLoginDetails.UserName := XmlParser.CurAttr.Value('username');
  LockLoginDetails.DBName := XmlParser.CurAttr.Value('dbname');
  LockLoginDetails.Reason := XmlParser.CurAttr.Value('reason');
  LockLoginDetails.UseRemoveTime := True;
  LockLoginDetails.RemoveTime := IncSecond(Now(), StrToIntDef(XmlParser.CurAttr.Value('delayloginsec'), 0) + StrToIntDef(XmlParser.CurAttr.Value('terminatewaitsec'), 0));
  SrvLockLoginLib.LockLogin(LockLoginDetails);
  For i := 0 To PresentList.Count - 1 Do Begin 
    CurrentUser := TPresent.Create;
    Try 
      PresentList.GetEntry(i, CurrentUser);
      If CurrentUser.Valid Then Begin 
        If SameText(CurrentUser.DbName, XmlParser.CurAttr.Value('dbname')) Then Begin 
          If CurrentUser.Employeeid <> StrToIntDef(XmlParser.CurAttr.Value('excludeuserid'), 0) Then Begin 
            NewMessage := TMessage.Create;
            NewMessage.EmployeeID := CurrentUser.Employeeid;
            NewMessage.DBName := XmlParser.CurAttr.Value('dbname');
            NewMessage.msgType := mtTerminate;
            NewMessage.HeaderMsg := 'Terminate Users';
            NewMessage.Msg := 'This ERP User Will Be Terminated in ' + SecToTime(StrToIntDef(XmlParser.CurAttr.Value('terminatewaitsec'), 0));
            NewMessage.ExtraXML := 'terminatewaitsec="' + XmlParser.CurAttr.Value('terminatewaitsec') + '"';
            SrvMessagesLib.AddMessageToQueue(NewMessage);
          End;
        End;
      End;
    Finally 
      CurrentUser.Free;
    End;
  End;
  ResultString := 'User Terminate Queued.';
  slResultExec.Add(ResultString);
  Log(ResultString);
End;

Procedure TServicesThread.doBatchUpdate(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  ResultString: String;
  NewMessage: TMessage;
  CurrentUser: TPresent;
Begin 
  CurrentUser := TPresent.Create;
  Try 
    PresentList.GetEntry(0, CurrentUser);
    If CurrentUser.Valid Then Begin 
      If SameText(CurrentUser.DbName, XmlParser.CurAttr.Value('dbname')) Then Begin 
        NewMessage := TMessage.Create;
        NewMessage.EmployeeID := -1;
        NewMessage.DBName := XmlParser.CurAttr.Value('dbname');
        NewMessage.msgType := mtBatchUpdate;
        NewMessage.HeaderMsg := 'Batch Update';
        SrvMessagesLib.AddMessageToQueue(NewMessage);
      End;
    End;
  Finally 
    CurrentUser.Free;
  End;
  ResultString := 'Batch Update Queued';
  slResultExec.Add(ResultString);
  Log(ResultString);
End;

Procedure TServicesThread.doSendEmailedReports(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  ResultString: String;
  NewMessage: TMessage;
  CurrentUser: TPresent;
Begin 
  CurrentUser := TPresent.Create;
  Try 
    PresentList.GetEntry(0, CurrentUser);
    If CurrentUser.Valid Then Begin 
      If SameText(CurrentUser.DbName, XmlParser.CurAttr.Value('dbname')) Then Begin 
        NewMessage := TMessage.Create;
        NewMessage.EmployeeID := -1;
        NewMessage.DBName := XmlParser.CurAttr.Value('dbname');
        NewMessage.msgType := mtEmailedReports;
        NewMessage.HeaderMsg := 'Send Emailed Reports';
        SrvMessagesLib.AddMessageToQueue(NewMessage);
      End;
    End;
  Finally 
    CurrentUser.Free;
  End;
  ResultString := 'Send Emailed Reports';
  slResultExec.Add(ResultString);
  Log(ResultString);
End;

Procedure TServicesThread.doVerify(Const XmlParser: TXmlParser; Const slResultExec: TStringList);
Var 
  ResultString: String;
  NewMessage: TMessage;
  CurrentUser: TPresent;
Begin 
  CurrentUser := TPresent.Create;
  Try 
    PresentList.GetEntry(0, CurrentUser);
    If CurrentUser.Valid Then Begin 
      If SameText(CurrentUser.DbName, XmlParser.CurAttr.Value('dbname')) Then Begin 
        NewMessage := TMessage.Create;
        NewMessage.EmployeeID := -1;
        NewMessage.DBName := XmlParser.CurAttr.Value('dbname');
        NewMessage.msgType := mtVerify;
        NewMessage.HeaderMsg := 'Verify & Fix';
        SrvMessagesLib.AddMessageToQueue(NewMessage);
      End;
    End;
  Finally 
    CurrentUser.Free;
  End;
  ResultString := 'Verify & Fix';
  slResultExec.Add(ResultString);
  Log(ResultString);
End;

End.
