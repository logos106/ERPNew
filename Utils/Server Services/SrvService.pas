Unit SrvService;

Interface 

Uses SvcMgr, Classes, SynchedThreads, IdThreadMgr, IdThreadMgrPool, IdBaseComponent, IdComponent, IdTCPServer, IdException, LbClass, Windows, WinSvc, Forms, SysUtils, IniFiles, MyAccess,
    ExcMagic, CoolTrayIcon, MiddleTier, PresentListObj, DB, DBAccess, IdAntiFreezeBase, IdAntiFreeze, MemDS;

Type
  TSrvServices = Class(TService)
    TCPServer: TIdTCPServer;
    ThreadMgr: TIdThreadMgrPool;
    AntiFreeze: TIdAntiFreeze;
    Procedure ServiceExecute(Sender: TService);
    Procedure ServiceStart(Sender: TService; Var Started: Boolean);
    Procedure ServiceAfterInstall(Sender: TService);
    Procedure TCPServerExecute(AThread: TIdPeerThread);
    Procedure TCPServerException(AThread: TIdPeerThread; AException: Exception);
    Procedure ServiceStop(Sender: TService; Var Stopped: Boolean);
    Procedure ServiceCreate(Sender: TObject);
    Procedure ServiceDestroy(Sender: TObject);
    Procedure TCPServerDisconnect(AThread: TIdPeerThread);
    Procedure TCPServerListenException(AThread: TIdListenerThread; AException: Exception);
    Procedure ServiceBeforeInstall(Sender: TService);
    Procedure ServiceBeforeUninstall(Sender: TService);
    Procedure ServiceAfterUninstall(Sender: TService);
  Private 
    lbCheckedCaption: String;
    Port: Integer;
    CurrentDatabaseName, CurrentXml: String;
    CurrentDue: TDatetime;
    IniFileName: String;
    msgResult: String[255];
    AlarmExecuting: Boolean;
    TimersEnabled: Boolean;
    StartRecover: Boolean;
    ProcessingInterval: Boolean;
    ProcessingCheckDB: Boolean;
    ProcessingRecover: Boolean;
    LastInterval: TDateTime;
    LastCheckDB: TDateTime;
    LastRecover: TDateTime;
    IntervalSec: Integer;
    CheckDBSec: Integer;
    RecoverSec: Integer;
    ProcessingClearLogs: Boolean;
    LastClearLogs: TDateTime;
    ClearLogsSec: Integer;
    Procedure IntervalTimer;
    Procedure CheckDBTimer;
    Procedure RecoverTimer;
    Procedure SetServiceFailureActions;
    Procedure SetServiceDescription;
    Procedure CheckScheduler;
    Procedure CheckEmailedReportsScheduler;
    Procedure CheckSlots;
    Procedure SetPortInDBs(Const port: Integer);
    Procedure RefreshTrayIcon;
    Procedure RefreshGUI;
    Procedure ThreadedInitiateMsg(Data: Pointer);
    Procedure TrayIconClick(Sender: TObject);
    Procedure AlarmLog(Const s: String; Const wasDone: Char; Const toTblLog: Boolean);
    Procedure GeneralTimer;
    Procedure ClearLogs;
    Procedure MultisiteCheck;
  Public 
    MemLogActive: Boolean;
    MaxLines: Integer;
    Function GetServiceController: TServiceController; Override;
  End;
Var 
  SrvServices: TSrvServices;
  PresentList: TPresentList;
  memLog: TStringList;

Implementation

Uses DateUtils, SrvServiceFunctionLib, SrvMultisiteNagLib, SrvThreadUnit, SrvServiceGUI, MemLogLib, SrvMessagesLib, LibXmlParser, InstallConst;
{$R *.DFM}

Type 
  TIndyExcFilter = Class(TInterfacedObject, IExcMagicFilter)
    Function ShowException(ExceptionObject: TObject; Title: String; ExceptionMessage: String; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): Integer;
    Function LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: Integer; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): Integer;
    Function ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: Integer; CustomInfo: TStrings): Integer;
  End;
  TDefaultExcFilter = Class(TInterfacedObject, IExcMagicFilter)
    Function ShowException(ExceptionObject: TObject; Title: String; ExceptionMessage: String; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): Integer;
    Function LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: Integer; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): Integer;
    Function ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: Integer; CustomInfo: TStrings): Integer;
  End;


Var
  IndyExcFilter: TIndyExcFilter;
  DefaultExcFilter: TDefaultExcFilter;
  initialFilePath: String;
  initialBuffer: Array[0..260] Of Char;
  memPresent: TStringList;
  memAlarmLog: TStringList;
  TrayIcon: TCoolTrayIcon;


Function TIndyExcFilter.ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: Integer; CustomInfo: TStrings): Integer;
Begin 
  Result := EXC_FILTER_STOP;
End;

Function TIndyExcFilter.LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: Integer; CallStack, Registers, CustomInfo: TStrings): Integer;
Begin 
  Result := EXC_FILTER_STOP;
End;

Function TIndyExcFilter.ShowException(ExceptionObject: TObject; Title, ExceptionMessage: String; CallStack, Registers, CustomInfo: TStrings): Integer;
Begin 
  Result := EXC_FILTER_STOP;
End;

Function TDefaultExcFilter.ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: Integer; CustomInfo: TStrings): Integer;
Const 
  DEFAULT_EXCEPTION_MSG_BRIEF: PChar = 'Exception ''%s'' in module %s at %p'#13#10'%s';
  DEFAULT_EXCEPTION_MSG_FULL: PChar  = 'Exception ''%s'' in module %s at %p'#13#10 + '%s'#13#10#13#10 + 'Module: %s, Source: %s, Line %s'#13#10 + 'Procedure: %s';
  UNKNOWN: String = 'UNKNOWN';
Begin 
  With MessageInfo Do If excDlgLocation In ExceptionHook.Options Then StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_FULL, [ExceptionObject.ClassName, miModuleName, miModuleAddress, miMessage, ExtractFileName(miSrcModule), ExtractFileName(miSrcFile), miSrcLine, miSrcProc])
  Else StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_BRIEF, [ExceptionObject.ClassName, miModuleName, miModuleAddress, miMessage]);
  Result := EXC_FILTER_CONTINUE;
End;

Function TDefaultExcFilter.LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: Integer; CallStack, Registers, CustomInfo: TStrings): Integer;
Const 
  CRLF: Word = $0A0D;
  HDRLINE    = '---------------------------';
  ADDITIONAL_TITLE: String = 'Additional info:'#13#10;
Var 
  HLog: THandle;
  S: String;
  Written: DWORD;
Begin 
  If ExceptionHook.LogFile <> '' Then Begin 
    HLog := CreateFile(PChar(ExceptionHook.LogFile), GENERIC_READ Or GENERIC_WRITE, 0, Nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    If HLog <> INVALID_HANDLE_VALUE Then Begin 
      SetFilePointer(HLog, 0, Nil, FILE_END);
      S := HDRLINE + DateTimeToStr(Now) + HDRLINE + #13#10;
      WriteFile(HLog, S[1], Length(S), Written, Nil);
      WriteFile(HLog, Buffer^, BufferSize, Written, Nil);
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, Nil);
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, Nil);
      WriteFile(HLog, PChar(CallStack.Text)^, Length(CallStack.Text), Written, Nil);
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, Nil);
      WriteFile(HLog, PChar(Registers.Text)^, Length(Registers.Text), Written, Nil);
      If Length(CustomInfo.Text) > 0 Then Begin 
        WriteFile(HLog, CRLF, SizeOf(CRLF), Written, Nil);
        WriteFile(HLog, ADDITIONAL_TITLE[1], Length(ADDITIONAL_TITLE), Written, Nil);
        WriteFile(HLog, PChar(CustomInfo.Text)^, Length(CustomInfo.Text), Written, Nil);
      End;
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, Nil);
      CloseHandle(HLog);
    End;
  End;
  Result := EXC_FILTER_CONTINUE;
End;

Function TDefaultExcFilter.ShowException(ExceptionObject: TObject; Title, ExceptionMessage: String; CallStack, Registers, CustomInfo: TStrings): Integer;
Begin 
  Writeln(ExceptionMessage);
  Writeln;
  If excDlgCallStack In ExceptionHook.Options Then Writeln(CallStack.Text);
  If excDlgRegisters In ExceptionHook.Options Then Writeln(Registers.Text);
  If excDlgCustomInfo In ExceptionHook.Options Then Writeln(CustomInfo.Text);
  Result := EXC_FILTER_CONTINUE;
End;

Procedure ServiceController(CtrlCode: DWord); Stdcall;
Begin 
  SrvServices.Controller(CtrlCode);
End;

Function TSrvServices.GetServiceController: TServiceController;
Begin 
  Result := ServiceController;
End;

Procedure TSrvServices.ServiceExecute(Sender: TService);
Begin 
  While Not Terminated Do Begin 
    SrvServices.ServiceThread.ProcessRequests(False);
    GeneralTimer;
    Application.ProcessMessages;
    Sleep(5);
  End;
End;

Procedure TSrvServices.ServiceAfterInstall(Sender: TService);
Begin 
  ExcMagic.ExceptionHook.LogEnabled := True;
//  If FileExists('C:\ERP Software\Logs\ServerServices.log') Then DeleteFile('C:\ERP Software\Logs\ServerServices.log');
  if FileExists(ERP_SERVER_LOG_DIR + 'ServerServices.log') then DeleteFile(ERP_SERVER_LOG_DIR + 'ServerServices.log');
  Try 
    SetServiceDescription;
  Except 
  End;
End;

Procedure TSrvServices.SetServiceFailureActions;
Var 
  SA: SC_ACTION;
  SFA: SERVICE_FAILURE_ACTIONS;
  SvcMgr: Integer;
  Svc: Integer;
  hLibModule: THandle;
  ChangeServiceConfig2: TChangeServiceConfig2;
Begin 
  SvcMgr := OpenSCManager(Nil, Nil, SC_MANAGER_ALL_ACCESS);
  If (Win32MajorVersion > 4) And (Win32Platform = VER_PLATFORM_WIN32_NT) Then Begin 
    hLibModule := GetModuleHandle(PChar(advapi32));
    If hLibModule <> 0 Then Begin 
      Svc := OpenService(SvcMgr, PChar(Self.Name), SERVICE_ALL_ACCESS);
      Try @ChangeServiceConfig2 := GetProcAddress(hLibModule, 'ChangeServiceConfig2A');
        If @ChangeServiceConfig2 <> Nil Then Begin 
          SA.aType := SC_ACTION_RESTART;
          SA.Delay := 0;
          SFA.dwResetPeriod := 0;
          SFA.lpRebootMsg := Nil;
          SFA.lpCommand := Nil;
          SFA.cActions := 1;
          SFA.lpsaActions := @SA;
          SFA.lpsaActions.aType := SC_ACTION_RESTART;
          SFA.lpsaActions.Delay := 0;
          ChangeServiceConfig2(Svc, SERVICE_CONFIG_FAILURE_ACTIONS, @SFA);
        End;
      Finally 
        CloseServiceHandle(Svc);
      End;
    End;
  End;
End;

Procedure TSrvServices.SetServiceDescription;
Const 
  AdvApiDLL   = 'advapi32.dll';
  SERVICE_CONFIG_DESCRIPTION = 1;
  Description = 'Provides Support,Maintains and Manages ERP Server Databases';
Type 
  TChangeServiceConfig2 = Function(hService: SC_HANDLE; dwInfoLevel: DWORD; lpInfo: Pointer): BOOL;
  stdcall;
  TServiceDescription = Record 
    lpDescription: String;
  End;
Var 
  SvcMgr: Integer;
  Svc: Integer;
  ServiceDescription: TServiceDescription;
  hLibModule: THandle;
  ChangeServiceConfig2: TChangeServiceConfig2;
  lpServiceArgVectors: LPCTSTR;
Begin 
  SvcMgr := OpenSCManager(Nil, Nil, SC_MANAGER_ALL_ACCESS);
  If (Win32MajorVersion > 4) And (Win32Platform = VER_PLATFORM_WIN32_NT) Then Begin 
    hLibModule := GetModuleHandle(PChar(advapi32));
    If hLibModule <> 0 Then Begin 
      Svc := OpenService(SvcMgr, PChar(Self.Name), SERVICE_ALL_ACCESS);
      Try 
        WinSvc.StartService(Svc, 0, lpServiceArgVectors); @ChangeServiceConfig2 := GetProcAddress(hLibModule, 'ChangeServiceConfig2A');
        If @ChangeServiceConfig2 <> Nil Then Begin 
          ServiceDescription.lpDescription := PChar(Description);
          ChangeServiceConfig2(Svc, SERVICE_CONFIG_DESCRIPTION, @ServiceDescription);
        End;
      Finally 
        CloseServiceHandle(Svc);
      End;
    End;
  End;
End;

Procedure TSrvServices.TCPServerException(AThread: TIdPeerThread; AException: Exception);
Begin 
  ThreadMgr.ReleaseThread(AThread);
  AThread.FreeOnTerminate := True;
  AThread.Terminate;
  FileLogMessages('TCP Server Error - ' + AException.Message);
End;

Procedure TSrvServices.CheckScheduler;
Var 
  qryTemp: TMyQuery;
  DBConnection: TMyConnection;
Begin 
  CurrentDatabaseName := '';
  CurrentXml := '';
  CurrentDue := 0;
  DBConnection := CreateDBConnection(Self, '');
  qryTemp := TMyQuery.Create(Self);
  Try 
    qryTemp.Options.FlatBuffers := True;
    If Not Assigned(DBConnection) Then Exit;
    If msgResult > '' Then Begin 
      AlarmLog(Format('  Result:  %s', [msgResult]), 'F', False);
      msgResult := '';
      AlarmExecuting := False;
    End;
    If AlarmExecuting Then Exit;
    lbCheckedCaption := 'Checked: ' + FormatDateTime('hh:mm:ss', Now);
    With qryTemp Do Begin 
      Connection := DBConnection;
      SQL.Clear;
      SQL.Add(Format('SELECT s.ID, s.Description, s.Xml, s.LogWhenDropped, s.Due, ' + 's.LogWhenDone, s.DatabaseName, r.DropAfterMinutes, s.Mode FROM tblschedule s ' + 'LEFT JOIN tblrepeatalarms r ' + 'ON r.ID = s.repeatAlarmID WHERE s.Due <= "%s" ;', [FormatDateTime('yyyy-mm-dd hh:nn:ss', Now)]));
      Try 
        Open;
      Except 
        memAlarmLog.Add('Error in Scheduler (Old Table Version)');
      End;
      If RecordCount > 0 Then Begin 
        CurrentDatabaseName := qryTemp.FieldByName('DatabaseName').AsString;
        CurrentXml := qryTemp.FieldByName('Xml').AsString;
        CurrentDue := qryTemp.FieldByName('Due').AsDateTime;
        If FieldByName('DropAfterMinutes').AsInteger > 0 Then Begin 
          If FieldByName('Due').AsDateTime + DateUtils.OneMinute * FieldByName('DropAfterMinutes').AsInteger < Now Then Begin 
            If FieldByName('LogWhenDropped').AsString = 'T' Then Begin 
              AlarmLog(Format('Dropped %s %d', [FieldByName('Description').AsString, FieldByName('DropAfterMinutes').AsInteger]), 'F', True);
            End;
            If (Trim(qryTemp.FieldByName('Mode').AsString) = 'Daily') Then Begin 
              DBConnection.ExecSQL('UPDATE tblschedule SET Due=DATE_ADD(Due,INTERVAL 1 DAY) WHERE ID = ' + qryTemp.FieldByName('ID').AsString, []);
              Exit;
            End Else If (Trim(qryTemp.FieldByName('Mode').AsString) = 'Weekly') Then Begin 
              DBConnection.ExecSQL('UPDATE tblschedule SET Due=DATE_ADD(Due,INTERVAL 7 DAY) WHERE ID = ' + qryTemp.FieldByName('ID').AsString, []);
              Exit;
            End Else Begin 
              DBConnection.ExecSQL('DELETE FROM tblschedule WHERE ID = ' + qryTemp.FieldByName('ID').AsString, []);
              Exit;
            End;
          End;
        End;
        RunInThread(ThreadedInitiateMsg, @msgResult);
        If (Pos(CurrentXml, 'EXEC') > 0) Then Begin 
          AlarmExecuting := True;
          StartRecover := True;
          LastRecover := Now();
        End;
        If FieldByName('LogWhenDone').AsString = 'T' Then Begin 
          AlarmLog(Format('Started: %s', [FieldByName('Description').AsString]), 'T', True)
        End;
        If (Trim(qryTemp.FieldByName('Mode').AsString) = 'Daily') Then Begin 
          DBConnection.ExecSQL('UPDATE tblschedule SET Due=DATE_ADD(Due,INTERVAL 1 DAY) WHERE ID = ' + qryTemp.FieldByName('ID').AsString, []);
        End Else If (Trim(qryTemp.FieldByName('Mode').AsString) = 'Weekly') Then Begin 
          DBConnection.ExecSQL('UPDATE tblschedule SET Due=DATE_ADD(Due,INTERVAL 7 DAY) WHERE ID = ' + qryTemp.FieldByName('ID').AsString, []);
        End Else Begin 
          DBConnection.ExecSQL('DELETE FROM tblschedule WHERE ID = ' + qryTemp.FieldByName('ID').AsString, []);
        End;
      End;
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(DBConnection);
    FreeAndNil(qryTemp);
  End;
End;

Procedure TSrvServices.CheckSlots;
Var 
  i: Integer;
  xml: String;
  qryTemp: TMyQuery;
  LbBlowfish: TLbBlowfish;
  DBConnection: TMyConnection;
  CurrentUser: TPresent;
Begin 
  DBConnection := CreateDBConnection(Self, '');
  qryTemp := TMyQuery.Create(Self);
  LbBlowfish := TLbBlowfish.Create(Self);
  Try 
    qryTemp.Options.FlatBuffers := True;
    If Not Assigned(DBConnection) Then Exit;
    qryTemp.Connection := DBConnection;
    qryTemp.SQL.Text   := 'SELECT * FROM tblclientslots WHERE userID > ""';
    qryTemp.Open;
    qryTemp.First;
    While Not qryTemp.Eof Do Begin 
      CurrentUser := TPresent.Create;
      Try 
        PresentList.FindUser(qryTemp.FieldByName('UserID').AsInteger, qryTemp.FieldByName('DBName').AsString, CurrentUser);
        If Not CurrentUser.Valid Then Begin 
          qryTemp.Edit;
          qryTemp.FieldByName('MachineID').AsString := '';
          qryTemp.FieldByName('MachineName').AsString := '';
          qryTemp.FieldByName('DBName').AsString := '';
          qryTemp.FieldByName('userid').AsString := '';
          xml := '<ClientSlot machineid="' + '' + '" machinename="' + '' + '" dbname="' + '' + '" userid="' + '' + '"/>';
          qryTemp.FieldByName('Data').AsString := LbBlowfish.EncryptString(xml);
          qryTemp.Post;
        End;
      Finally 
        CurrentUser.Free;
      End;
      qryTemp.Next;
    End;
    For i := 0 To PresentList.Count - 1 Do Begin 
      CurrentUser := TPresent.Create;
      Try 
        Presentlist.GetEntry(i, CurrentUser);
        If CurrentUser.Valid Then Begin 
          qryTemp.SQL.Text := Format('SELECT userID, DBName, LastActive FROM tblclientSlots WHERE ' + 'userID = "%d" AND dbName = "%s";', [CurrentUser.EmployeeId, CurrentUser.DBName]);
          qryTemp.Open;
          If qryTemp.RecordCount = 0 Then Begin 
            qryTemp.SQL.Text := 'SELECT * FROM tblClientSlots WHERE isNull(userid) or userid = "";';
            qryTemp.Open;
            If qryTemp.RecordCount > 0 Then Begin 
              qryTemp.Edit;
              qryTemp.FieldByName('userid').AsInteger := CurrentUser.EmployeeID;
              qryTemp.FieldByName('dbName').AsString := CurrentUser.dbName;
              qryTemp.FieldByName('MachineName').AsString := '*';
              qryTemp.FieldByName('MachineID').AsString := '*';
              xml := '<ClientSlot machineid="' + '*' + '" machinename="' + '*' + '" dbname="' + CurrentUser.dbName + '" userid="' + IntToStr(CurrentUser.EmployeeID) + '"/>';
              qryTemp.FieldByName('Data').AsString := LbBlowfish.EncryptString(xml);
              qryTemp.Post;
            End;
          End Else Begin 
            qryTemp.Edit;
            qryTemp.FieldByName('LastActive').AsDateTime := CurrentUser.lastPing;
            qryTemp.Post;
          End;
        End;
      Finally 
        CurrentUser.Free;
      End;
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(qryTemp);
    FreeAndNil(LbBlowfish);
    FreeAndNil(DBConnection);
  End;
End;

Procedure TSrvServices.AlarmLog(Const s: String; Const wasDone: Char; Const toTblLog: Boolean);
Var 
  sql: String;
  DBConnection: TMyConnection;
Begin 
  DBConnection := CreateDBConnection(Self, '');
  Try 
    If Not Assigned(DBConnection) Then Exit;
    memAlarmLog.Add(FormatDateTime('yyyy-mm-dd hh:mm ', Now) + s);
    If toTblLog Then Begin 
      sql := 'INSERT tbllog SET ' + 'DatabaseName="' + CurrentDatabaseName + '", ' + 'Xml="' + escapeForMySql(CurrentXml) + '", ' + 'Due="' + FormatDateTime('yyyy-mm-dd hh:nn:ss', CurrentDue) + '", ' + 'WasDone="' + wasDone + '", ' + 'Event="' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '"; ';
      DBConnection.ExecSQL(sql, []);
    End;
  Finally 
    FreeAndNil(DBConnection);
  End;
End;

Procedure TSrvServices.TCPServerExecute(AThread: TIdPeerThread);
Var 
  ServicesThread: TServicesThread;
  Stream: TMemoryStream;
Begin 
  AThread.FreeOnTerminate := True;
  If Not AThread.Terminated And AThread.Connection.Connected Then Begin 
    Stream := TMemoryStream.Create;
    Try 
      ServicesThread := TServicesThread.Create(Nil);
      Try 
        ServicesThread.doRun(AThread.ThreadID, AThread.Connection.CurrentReadBuffer, AThread.Connection.Socket.Binding.PeerIP, Stream);
      Finally 
        ServicesThread.Free;
      End;
      Stream.Position := 0;
      AThread.Connection.WriteStream(Stream);
      Stream.Clear;
    Finally 
      Stream.Free;
    End;
    AThread.Connection.Disconnect;
  End;
End;

Procedure TSrvServices.SetPortInDBs(Const port: Integer);
Var 
  lsDBs, lsTables: TStringList;
  dbIx: Integer;
  FormConnection: TMyConnection;
  FormQuery: TMyQuery;
Begin 
  lsDBs := TStringList.Create;
  lsTables := TStringList.Create;
  FormConnection := CreateDBConnection(Self, '');
  FormQuery := TMyQuery.Create(Self);
  Try 
    FormQuery.Options.FlatBuffers := True;
    If Not Assigned(FormConnection) Then Exit;
    FormQuery.Connection := FormConnection;
    FormConnection.Open;
    If FormConnection.Connected Then Begin 
      FormConnection.GetDatabaseNames(lsDBs);
      For dbIx := 0 To lsDBs.Count - 1 Do Begin 
        FormConnection.Database := lsDBs[dbIx];
        FormConnection.GetTableNames(lsTables);
        If lsTables.IndexOf('tblupdatedetails') > -1 Then Begin 
          FormQuery.Close;
          FormQuery.SQL.Clear;
          FormQuery.SQL.Add('SELECT * FROM tblupdatedetails WHERE ID = 1;');
          FormQuery.Open;
          If FormQuery.RecordCount > 0 Then Begin 
            If FormQuery.FindField('ServicesPortNo') <> Nil Then Begin 
              Try 
                FormQuery.Edit;
                FormQuery.FieldByName('ServicesPortNo').AsInteger := Port;
                FormQuery.Post;
              Except 
              End;
            End;
          End;
          FormQuery.Close;
        End;
      End;
      FormConnection.Disconnect;
    End;
  Finally 
    lsDBs.Clear;
    lsTables.Clear;
    FreeAndNil(lsDBs);
    FreeAndNil(lsTables);
    FreeAndNil(FormConnection);
    FreeAndNil(FormQuery);
  End;
End;

Procedure TSrvServices.ThreadedInitiateMsg(Data: Pointer);
Var 
  MTClient: TMTClient;
  stream: TMemoryStream;
  msgResultp: PChar;
  size: Integer;
Begin 
  msgResultp := Data;
  MTClient := TMTClient.Create(Self);
  Try 
    With MTClient Do Begin 
      DB := CurrentDatabaseName;
      dbUserName := MysqlUsername;
      DBPassWord := MysqlPassword;
      Host := MysqlServer;
      Stream := TMemoryStream.Create;
      Try 
        Execute(['XML', '<ERPMsg>' + CurrentXml + '</ERPMsg>'], Stream);
        If Stream.Size > 0 Then Begin 
          size := Stream.Size;
          If size > 254 Then size := 255;
          Stream.Read(msgResultp[1], size);
          msgResultp[0] := Chr(Byte(size));
        End;
      Finally 
        Stream.Clear;
        FreeAndNil(Stream);
      End;
    End;
  Finally 
    FreeAndNil(MTClient);
  End;
End;

Procedure TSrvServices.RefreshTrayIcon;
Begin 
  With TrayIcon Do Begin 
    Icon.Assign(Application.Icon);
    OnClick     := TrayIconClick;
    IconVisible := True;
    Hint        := 'ERP Server Services';
  End;
End;

Procedure TSrvServices.ServiceStop(Sender: TService; Var Stopped: Boolean);
Var 
  MyIniFile: TMemIniFile;
Begin 
  TimersEnabled := False;
  SetPortInDBs(0);
  MyIniFile := TMemIniFile.Create(IniFileName);
  Try 
    MyIniFile.WriteInteger('TCP', 'Port', Port);
    MyIniFile.WriteInteger('Log', 'MaxLines', MaxLines);
    MyIniFile.WriteBool('Log', 'MemLog', MemLogActive);
    MyIniFile.UpdateFile;
  Finally 
    MyIniFile.Free;
  End;
  TCPServer.Active := False;
  SrvServiceFunctionLib.RepairAndOptimizeTables;
  WaitForThreadClose;
  FileLogMessages('Stopped');
End;

Procedure TSrvServices.ServiceStart(Sender: TService; Var Started: Boolean);
Var 
  MyIniFile: TMemIniFile;
  ServiceFilePath: String;
  Buffer: Array[0..260] Of Char;
Begin 
  TimersEnabled := False;
  msgResult := '';
  AlarmExecuting := False;
  Try 
    SetServiceFailureActions;
  Except 
  End;
  SetString(ServiceFilePath, Buffer, GetModuleFileName(0, Buffer, SizeOf(Buffer)));
  IniFileName := ChangeFileExt(ServiceFilePath, '.ini');
  SetCurrentDir(ExtractFilePath(ServiceFilePath));
  MyIniFile := TMemIniFile.Create(ExtractFilePath(IniFileName));
  Try 
    Port         := MyIniFile.ReadInteger('TCP', 'Port', 3310);
    MaxLines     := MyIniFile.ReadInteger('Log', 'MaxLines', 100);
    MemLogActive := MyIniFile.ReadBool('Log', 'MemLog', False);
  Finally 
    MyIniFile.Free;
  End;
  SetPortInDBs(Port);
  TCPServer.DefaultPort := Port;
  TCPServer.ThreadMgr.ThreadPriority := tpHigher;
  TCPServer.Active := True;
  ProcessingInterval := False;
  ProcessingCheckDB := False;
  ProcessingRecover := False;
  StartRecover := False;
  ProcessingClearLogs := False;
  IntervalSec := 10;
  CheckDBSec := 15;
  RecoverSec := 600;
  ClearLogsSec := 300;
  LastRecover := Now();
  LastInterval := IncHour(Now(), - 1);
  LastCheckDB := IncHour(Now(), - 1);
  LastClearLogs := IncHour(Now(), - 1);
  FileLogMessages('Started');
  RefreshTrayIcon;
  TimersEnabled := True;
  WaitForThreadClose;
  RefreshMemoryUsage;
End;

Procedure TSrvServices.TrayIconClick(Sender: TObject);
Begin 
  If Not Assigned(ServerServicesGUI) Then Begin 
    ServerServicesGUI := TServerServicesGUI.Create(Self);
    With ServerServicesGUI Do Begin 
      Show;
      BringToFront;
    End;
    RefreshGUI;
  End Else Begin 
    ServerServicesGUI.Close;
  End;
End;

Procedure TSrvServices.ServiceCreate(Sender: TObject);
Begin 
  Application.Title := 'ERP Server Services';
  DisplayName := 'ERP Server Services';
End;

Procedure TSrvServices.ServiceDestroy(Sender: TObject);
Begin 
  If Assigned(ServerServicesGUI) Then FreeAndNil(ServerServicesGUI);
End;

Procedure TSrvServices.RefreshGUI;
Begin 
  memLogLock.Acquire;
  Try 
    If Assigned(ServerServicesGUI) Then Begin 
      MemLogLib.LogAction('RefreshGUI');
      ServerServicesGUI.memLog.Lines.Text := memLog.Text;
      ServerServicesGUI.memPresent.Lines.Text := memPresent.Text;
      ServerServicesGUI.memAlarmLog.Lines.Text := memAlarmLog.Text;
      ServerServicesGUI.lbChecked.Caption := lbCheckedCaption;
    End;
  Finally 
    memLogLock.Release;
  End;
End;

Procedure TSrvServices.RecoverTimer;
Begin 
  ProcessingRecover := True;
  Try 
    MemLogLib.LogAction('RecoverTimer');
    StartRecover   := False;
    AlarmExecuting := False;
    AlarmLog('Recovered - (no result from last exec)', 'F', True);
  Finally 
    ProcessingRecover := False;
  End;
End;

Procedure TSrvServices.CheckDBTimer;
Begin 
  ProcessingCheckDB := True;
  Try 
    MemLogLib.LogAction('CheckDBTimer');
    CheckScheduler;
    RefreshGUI;
  Finally 
    ProcessingCheckDB := False;
  End;
End;

Procedure TSrvServices.IntervalTimer;
Var 
  i: Integer;
  CurrentUser: TPresent;
Begin 
  ProcessingInterval := True;
  Try 
    MemLogLib.LogAction('IntervalTimer');
    CheckSlots;
    PresentList.RemoveOlderThan(IncSecond(Now(), - 30));
    memPresent.Clear;
    For i := 0 To PresentList.Count - 1 Do Begin 
      CurrentUser := TPresent.Create;
      Try 
        PresentList.GetEntry(i, CurrentUser);
        If CurrentUser.Valid Then Begin 
          With CurrentUser Do Begin 
            memPresent.Add(Format('%s(%s)   %s %d', [PeerName, PeerIP, DbName, EmployeeID]));
          End;
        End;
      Finally 
        CurrentUser.Free;
      End;
    End;
  Finally 
    ProcessingInterval := False;
  End;
End;

Procedure TSrvServices.ClearLogs;
Begin 
  ProcessingClearLogs := True;
  Try 
    memLogLock.Acquire;
    Try 
      MemLogLib.LogAction('ClearLogs');
      memLog.Clear;
      memAlarmLog.Clear;
    Finally 
      memLogLock.Release;
    End;
  Finally 
    ProcessingClearLogs := False;
  End;
End;

Procedure TSrvServices.TCPServerDisconnect(AThread: TIdPeerThread);
Begin 
  ThreadMgr.ReleaseThread(AThread);
  AThread.FreeOnTerminate := True;
  AThread.Terminate;
End;

Procedure TSrvServices.GeneralTimer;
Begin 
  If TimersEnabled Then Begin 
    If (Trunc(SecondSpan(Now(), LastInterval)) >= IntervalSec) Then Begin 
      If Not ProcessingInterval Then IntervalTimer;
      LastInterval := Now();
      MemLogLib.LogMemAction(GetCurrentProcess(), 'MemCheck');
      RefreshGUI;
    End;
    If (Trunc(SecondSpan(Now(), LastCheckDB)) >= CheckDBSec) Then Begin 
      If Not ProcessingCheckDB Then Begin 
        CheckDBTimer;
        CheckEmailedReportsScheduler;
      End;
      LastCheckDB := Now();
      MemLogLib.LogMemAction(GetCurrentProcess(), 'MemCheck');
    End;
    If (Trunc(SecondSpan(Now(), LastClearLogs)) >= ClearLogsSec) Then Begin 
      If Not ProcessingClearLogs Then Begin 
        ClearLogs;
        SrvMessagesLib.MessageListEmpty;
        RefreshMemoryUsage;
        MultisiteCheck;
      End;
      LastClearLogs := Now();
      MemLogLib.LogMemAction(GetCurrentProcess(), 'MemCheck');
    End;
    If StartRecover And (Trunc(SecondSpan(Now(), LastRecover)) >= RecoverSec) Then Begin 
      If Not ProcessingRecover Then RecoverTimer;
      LastRecover := Now();
    End;
  End;
End;

Procedure TSrvServices.CheckEmailedReportsScheduler;
Var 
  qryTemp: TMyQuery;
  DBConnection: TMyConnection;
  tmpDBName: String;
Begin 
  CurrentDatabaseName := '';
  CurrentXml := '';
  msgResult := '';
  DBConnection := CreateDBConnection(Self, '');
  qryTemp := TMyQuery.Create(Self);
  AlarmExecuting := True;
  Try 
    qryTemp.Options.FlatBuffers := True;
    If Not Assigned(DBConnection) Then Exit;
    qryTemp.Connection := DBConnection;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SHOW DATABASES');
    qryTemp.Open;
    If qryTemp.RecordCount > 0 Then Begin 
      qryTemp.First;
      While Not qryTemp.Eof Do Begin 
        tmpDBName := Trim(qryTemp.Fields[0].AsString);
        If IsEmailedReports(tmpDBName) Then Begin 
          CurrentDatabaseName := tmpDBName;
          CurrentXml := '<EMAILEDREPORTS dbname="' + Trim(tmpDBName) + '"/>';
          RunInThread(ThreadedInitiateMsg, @msgResult);
        End;
        qryTemp.Next;
      End;
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(DBConnection);
    FreeAndNil(qryTemp);
    AlarmExecuting := False;
  End;
End;

Procedure TSrvServices.MultisiteCheck;
Var 
  qryTemp: TMyQuery;
  DBConnection: TMyConnection;
  tmpDBName: String;
  msgStr: String;
Begin 
  CurrentDatabaseName := '';
  CurrentXml := '';
  msgResult := '';
  DBConnection := CreateDBConnection(Self, '');
  qryTemp := TMyQuery.Create(Self);
  qryTemp.Options.FlatBuffers := True;
  AlarmExecuting := True;
  Try 
    If Not Assigned(DBConnection) Then Exit;
    qryTemp.Connection := DBConnection;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SHOW DATABASES');
    qryTemp.Open;
    If qryTemp.RecordCount > 0 Then Begin 
      qryTemp.First;
      While Not qryTemp.Eof Do Begin 
        tmpDBName := Trim(qryTemp.Fields[0].AsString);
        If SrvMultisiteNagLib.IsMultisiteDB(tmpDBName) Then Begin 
          msgStr := MultisiteCheckDB(tmpDBName);
          If Not Empty(msgStr) Then Begin 
            CurrentDatabaseName := tmpDBName;
            CurrentXml := '<POPUPALERT dbname="' + Trim(tmpDBName) + '" msg="' + msgStr + '" hmsg="Multisite Synchronisation Alert"/>';
            If Not SrvMultisiteNagLib.IsMutisiteNagStopped(tmpDBName) Then Begin 
              RunInThread(ThreadedInitiateMsg, @msgResult);
            End;
          End;
        End;
        qryTemp.Next;
      End;
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(DBConnection);
    FreeAndNil(qryTemp);
    AlarmExecuting := False;
  End;
End;

Procedure TSrvServices.TCPServerListenException(AThread: TIdListenerThread; AException: Exception);
Begin 
  AThread.FreeOnTerminate := True;
  AThread.Terminate;
  FileLogMessages('TCP Server On Listen Error - ' + AException.Message);
End;

Procedure TSrvServices.ServiceBeforeInstall(Sender: TService);
Begin 
  ExcMagic.ExceptionHook.LogEnabled := False;
End;

Procedure TSrvServices.ServiceBeforeUninstall(Sender: TService);
Begin 
  ExcMagic.ExceptionHook.LogEnabled := False;
End;

Procedure TSrvServices.ServiceAfterUninstall(Sender: TService);
Begin 
  ExcMagic.ExceptionHook.LogEnabled := True;
End;

Initialization 
  TrayIcon := TCoolTrayIcon.Create(Nil);
  IndyExcFilter := TIndyExcFilter.Create;
  DefaultExcFilter := TDefaultExcFilter.Create;
  ExcMagic.ExceptionHook.Enabled := True;
  SetString(initialFilePath, initialBuffer, GetModuleFileName(0, initialBuffer, SizeOf(initialBuffer)));
  ExcMagic.ExceptionHook.LogFile := ExtractFilePath(initialFilePath) + 'Exceptions.log';
  ExcMagic.ExceptionHook.LogHandled := True;
  ExcMagic.ExceptionHook.LogEnabled := True;
  ExcMagic.ExceptionHook.Options := ExcMagic.ExceptionHook.Options - [excShowDialog];
  ExcMagic.ExceptionHook.RegisterExceptionFilter(Exception, DefaultExcFilter, False);
  ExcMagic.ExceptionHook.EnableExceptionFilter(DefaultExcFilter, True);
  ExcMagic.ExceptionHook.RegisterExceptionFilter(EIdConnClosedGracefully, IndyExcFilter, True);
  ExcMagic.ExceptionHook.EnableExceptionFilter(IndyExcFilter, True);
  PresentList := TPresentList.Create;
  memPresent := TStringList.Create;
  memLog := TStringList.Create;
  memAlarmLog := TStringList.Create;
Finalization 
  FreeAndNil(TrayIcon);
  FreeAndNil(PresentList);
  memPresent.Clear;
  memLog.Clear;
  memAlarmLog.Clear;
  FreeAndNil(memPresent);
  FreeAndNil(memLog);
  FreeAndNil(memAlarmLog);
End.

