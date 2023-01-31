Unit SrvServiceFunctionLib;

Interface

Uses Windows, SyncObjs, WinSvc, Classes, MyAccess, MyClasses, MySQLErrors, MySqlVioTcp, InstallConst;

Var 
  memLogLock: TCriticalSection;
Const
  VERSION        = '7.5';
//  EXECPATH       = 'C:\ERP Software\Execs\';
  { TODO : AUTOUPDATER ?? }
  ERPPATH  = 'C:\Program Files\ERP Software\';
  AUTOUPDATEPATH = 'C:\Program Files\ERP Software\AutoUpdate\';

  MysqlServer    = 'localhost';
  MysqlUsername  = 'P_One';
  MysqlPassword  = '1w$p&LD07';
  AdvApiDLL      = 'advapi32.dll';
  SERVICE_CONFIG_FAILURE_ACTIONS = 2;
  CRLF_STR       = '{CRLF}';
Type 
  TDenyReason           = (drNone, drExpired, drLicenceReset, drNoLicence, drUnregisteredClient, drUnregisteredServer, drInvalidDate, drLoggedInAlready, drNoSlotAvailable, drDatabaseLocked);
  TChangeServiceConfig2 = Function(hService: SC_HANDLE; dwInfoLevel: DWORD; lpInfo: Pointer): BOOL;
  stdcall;
  SC_ACTION_TYPE = (SC_ACTION_NONE, SC_ACTION_RESTART, SC_ACTION_REBOOT, SC_ACTION_RUN_COMMAND);
  SC_ACTION      = Record 
    aType: SC_ACTION_TYPE;
    Delay: DWORD;
  End;
  SERVICE_FAILURE_ACTIONS = Record 
    dwResetPeriod: DWORD;
    lpRebootMsg: LPTSTR;
    lpCommand: LPTSTR;
    cActions: DWORD;
    lpsaActions: ^SC_ACTION;
  End;
Procedure RefreshMemoryUsage;
Procedure Log(Const Text: String);
Procedure FileLogMessages(Const MessageStr: String);
Function CreateDBConnection(Const Owner: TComponent; Const DatabaseName: String = ''): TMyConnection;
Function GetMachineID: String;
Function EscapeForXML(Const s: String): String;
Function EscapeForMySQL(Const s: String): String;
Function Empty(Const s: String): Boolean;
Procedure WaitForThreadClose;
Procedure RepairAndOptimizeTables;
Function SecToTime(Const Sec: Integer): String;
Function IsEmailedReports(Const DBName: String): Boolean;
Function TestDBConnectionOk(Const DBConnection: TMyConnection): Boolean;
function EXECPATH : string;

Implementation 

Uses ExcMagic, OnGuard, Controls, SysUtils, OgUtil, SrvService, MemLogLib, IniFiles;

Type 
  TTMDContext  = Array[0..279] Of Byte;
  TMD5Context  = Array[0..87] Of Byte;
  TMD5Digest   = Array[0..15] Of Byte;
  T128Bit      = Array[0..3] Of Longint;
  T256Bit      = Array[0..7] Of Longint;
  TKey         = Array[0..15] Of Byte;
  TKeyType     = (ktRandom, ktMessageDigest, ktMessageDigestCS);
  TMDContextEx = Record 
    DigestIndex: Longint;
    Digest: Array[0..255] Of Byte;
    KeyIndex: Longint;
    Case Byte Of 
      0: (KeyInts: Array[0..3] Of 
          Longint);
        1: (Key: TKey);
    End;
  TBlock2048 = Array[0..255] Of Byte;
  PCode      = ^TCode;
  TCode      = Packed Record 
      CheckValue: Word;
      Expiration: Word;
      Case Byte Of 
        0: (FirstDate: Word;
          EndDate: Word);
        1: (Days: Word;
          LastAccess: Word);
        2: (RegString: Longint);
        3: (SerialNumber: Longint);
        4: (UsageCount: Word;
          LastChange: Word);
        5: (Value: Longint);
        6: (NetIndex: Longint);
    End;

const
  MysqlPort      = 3309;
Var 
  CritLogLock: TCriticalSection;

                  
Function GetMyProtocol: TMyProtocol;
Var
  IniFile: TMemIniFile;
  ServiceFilePath: String;
  ProtocolName: String;
  Buffer: Array[0..260] Of Char;
Begin
  SetString(ServiceFilePath, Buffer, GetModuleFileName(0, Buffer, SizeOf(Buffer)));
  SetCurrentDir(ExtractFilePath(ServiceFilePath));
  IniFile := TMemIniFile.Create(ExtractFilePath(ServiceFilePath) + 'Protocol.ini');
  Try
    ProtocolName := IniFile.ReadString('Connections', 'Protocol', 'Default');
  Finally
    IniFile.Free;
  End;
  If SysUtils.SameText(ProtocolName, 'Default') Then Result := mpDefault
  Else If SysUtils.SameText(ProtocolName, 'TCP') Then Result := mpTCP
  Else If SysUtils.SameText(ProtocolName, 'Socket') Then Result := mpSocket
  Else If SysUtils.SameText(ProtocolName, 'Pipe') Then Result := mpPipe
  Else If SysUtils.SameText(ProtocolName, 'Memory') Then Result := mpMemory
  Else Result := mpDefault;
End;  

Function IsEmailedReports(Const DBName: String): Boolean;
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
    qryTemp.Filter   := qryTemp.Fields[0].FieldName + '=' + QuotedStr('tblemailedreportsschedule');
    qryTemp.Filtered := True;
    If qryTemp.RecordCount = 1 Then Begin 
      qryTemp.Close;
      qryTemp.Filter := '';
      qryTemp.Filtered := False;
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('SELECT * FROM tblemailedreportsschedule ');
      qryTemp.SQL.Add('WHERE (Now()>NextSend) AND Active="T";');
      qryTemp.Open;
      Result := (qryTemp.RecordCount >= 1);
    End;
    qryTemp.Close;
  Finally 
    FreeAndNil(DBConnection);
    FreeAndNil(qryTemp);
  End;
End;
  
Function SecToTime(Const Sec: Integer): String;
Var 
  tmpDateTime: TDateTime;
Begin 
  tmpDateTime := Sec / (24 * 3600);
  Result := Copy(FormatDateTime('hh:m:ss', tmpDateTime), 4, 5);
End;
    
Function Empty(Const s: String): Boolean;
Begin 
  Result := (Trim(s) = '');
End;
      
Procedure RefreshMemoryUsage;
Var 
  MainHandle: THandle;
Begin 
  MainHandle := OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
  SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
  CloseHandle(MainHandle);
End;
        
Function EscapeForMySQL(Const s: String): String;
Const 
  thechar        = '\"'''#13#10#9;
  thereplacement = '\"''rnt';
Var 
  i, p: Integer;
Begin 
  Result := '';
  For i := 1 To Length(s) Do Begin 
    p := Pos(s[i], thechar);
    If p > 0 Then Result := Result + '\' + thereplacement[p]
    Else Result := Result + s[i];
  End;
End;
          
Function TestDBConnectionOk(Const DBConnection: TMyConnection): Boolean;
Begin
  ExcMagic.ExceptionHook.LogEnabled := False;
  Try
    Result := False;
    Try
      DBConnection.Disconnect;
      DBConnection.Connect;
      Result := True;
    Except
      On E: EMyError Do Log('Connection to Mysql Failed');
      On E: EMySqlException Do Log('Connection to Mysql Failed');
      On E: SocketException Do Log('Connection to Mysql Failed');
      Else Raise;
    End;
  finally
    ExcMagic.ExceptionHook.LogEnabled := True;
  end;
End;
            
Function CreateDBConnection(Const Owner: TComponent; Const DatabaseName: String = ''): TMyConnection;
Begin 
  Result := TMyConnection.Create(Owner);
  With Result Do Begin 
    Server   := MysqlServer;
    Username := MysqlUsername;
    Port     := MysqlPort;
    Password := MysqlPassword;
    Options.Protocol := GetMyProtocol;
    If DatabaseName = '' Then Begin 
      DataBase := 'services';
    End Else Begin 
      DataBase := DatabaseName;
    End;
    LoginPrompt := False;
    If Not TestDBConnectionOk(Result) Then FreeAndNil(Result);
  End;
End;
              
Procedure FileLogMessages(Const MessageStr: String);
Var 
  StrList: TStringList;
Begin 
  CritLogLock.Acquire;
  Try 
    StrList := TStringList.Create;
    Try 
      If FileExists('C:\\ERPServices.log') Then StrList.LoadFromFile('C:\\ERPServices.log');
      StrList.Insert(0, '------------------');
      StrList.Insert(0, MessageStr);
      StrList.Insert(0, DateTimeToStr(Now()));
      StrList.Insert(0, '------------------');
      StrList.SaveToFile('C:\\ERPServices.log');
    Finally 
      StrList.Clear;
      FreeAndNil(StrList);
    End;
  Finally 
    CritLogLock.Release;
  End;
End;
                
Function EscapeForXML(Const s: String): String;
Var 
  i: Integer;
  ch: String;
Begin 
  For i := 1 To Length(s) Do Begin 
    Case s[i] Of 
      '&': ch := '&amp;';
      '<': ch := '&lt;';
      '>': ch := '&gt;';
      '''': ch := '&apos;';
      '"': ch := '&quot;';
      Else ch := s[i];
    End;
    Result := Result + ch;
  End;
End;
                  
Procedure Log(Const Text: String);
Begin 
  memLogLock.Acquire;
  Try 
    If Text > '' Then Begin 
      While (memLog.Count > SrvServices.MaxLines) Do Begin 
        memLog.Delete(0);
      End;
      If memLog.Count = SrvServices.MaxLines Then memLog.Strings[0] := '....Deleted.....';
      memLog.Add(FormatDateTime('yyyy-mm-dd hh:nn', Now) + ' ' + Text);
      MemLogLib.LogFile(Text);
    End;
  Finally 
    memLogLock.Release;
  End;
End;
                  
Function GetMachineId: String;
Var 
  InfoSet: TEsMachineInfoSet;
  MachineID: Longint;
Begin 
  InfoSet := [];
  InfoSet := InfoSet + [midDrives];
  MachineID := OnGuard.CreateMachineID(InfoSet);
  Result := BufferToHex(MachineID, SizeOf(MachineID));
End;
                  
Procedure WaitForThreadClose;
Var 
  I: Integer;
Begin 
  I := 0;
  While (I <= 5) Do Begin 
    SrvServices.ServiceThread.ProcessRequests(False);
    Sleep(500);
    Inc(I);
  End;
End;
                  
Function ChangeTableType(Const TableName, TableType: String; Const DBConnection: TMyConnection): Boolean;
Var 
  qryTemp: TMyCommand;
Begin 
  qryTemp := TMyCommand.Create(Nil);
  qryTemp.Connection := DBConnection;
  Try 
    With qryTemp Do Try 
        sql.Clear;
        sql.Add('ALTER TABLE `' + TableName + '` TYPE = ' + TableType + ';');
        Execute;
        Result := True;
      Finally 
        qryTemp.Free;
      End;
  Except 
    Result := False;
  End;
End;
                  
Function OptimizeTable(Const TableName: String; Const DBConnection: TMyConnection): Boolean;
Var 
  qryTemp: TMyCommand;
Begin 
  qryTemp := TMyCommand.Create(Nil);
  qryTemp.Connection := DBConnection;
  Try 
    With qryTemp Do Try 
        sql.Clear;
        sql.Add('OPTIMIZE TABLE `' + Trim(TableName) + '`;');
        Execute;
        Result := True;
      Finally 
        qryTemp.Free;
      End;
  Except 
    Result := False;
  End;
End;
                  
Function RepairTable(Const TableName: String; Const DBConnection: TMyConnection): Boolean;
Var 
  qryTemp: TMyCommand;
Begin 
  qryTemp := TMyCommand.Create(Nil);
  qryTemp.Connection := DBConnection;
  Try 
    With qryTemp Do Try 
        SQL.Clear;
        sql.Add('REPAIR TABLE `' + Trim(TableName) + '`;');
        Execute;
        Result := True;
      Finally 
        qryTemp.Free;
      End;
  Except 
    Result := False;
  End;
End;
                  
Procedure RepairAndOptimizeTables;
Var 
  DBTables: TStringList;
  DBConnection: TMyConnection;
  I: Integer;
Begin 
  DBConnection := CreateDBConnection(Nil, '');
  DBTables := TStringList.Create;
  Try 
    If Not Assigned(DBConnection) Then Exit;
    DBTables.Clear;
    DBConnection.Database := 'services';
    DBConnection.Connect;
    DBConnection.GetTableNames(DBTables);
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.RepairTable(DBTables[I], DBConnection);
    End;
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.ChangeTableType(DBTables[I], 'MyISAM', DBConnection);
    End;
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.OptimizeTable(DBTables[I], DBConnection);
    End;
    DBTables.Clear;
    DBConnection.Database := 'mysql';
    DBConnection.Connect;
    DBConnection.GetTableNames(DBTables);
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.RepairTable(DBTables[I], DBConnection);
    End;
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.ChangeTableType(DBTables[I], 'MyISAM', DBConnection);
    End;
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.OptimizeTable(DBTables[I], DBConnection);
    End;
    DBTables.Clear;
    DBConnection.Database := 'pbxmonitor';
    DBConnection.Connect;
    DBConnection.GetTableNames(DBTables);
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.RepairTable(DBTables[I], DBConnection);
    End;
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.ChangeTableType(DBTables[I], 'MyISAM', DBConnection);
    End;
    For I := 0 To DBTables.Count - 1 Do Begin 
      SrvServiceFunctionLib.OptimizeTable(DBTables[I], DBConnection);
    End;
  Finally 
    FreeAndNil(DBConnection);
    FreeAndNil(DBTables);
  End;
End;

function EXECPATH : string;
begin
  Result := ERP_SERVER_ROOT_DIR + 'Execs\';
end;

Initialization
  CritLogLock := TCriticalSection.Create;
  memLogLock := TCriticalSection.Create;
End.

