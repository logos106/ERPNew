Unit BackupManagerObj;

Interface 

Uses Forms, Windows, Messages, SysUtils, Classes, DB, DBAccess, MyClasses, MyAccess, MyBackup, MyScript;

Type
  TBackupManagerObj = Class(TComponent)
  Private
    fMsgStr: String;
    FBackup: TMyBackup;
    FConnection: TMyConnection;
    Query: TMyQuery;
    Script: TMyScript;
    Function GetDatabase: String;
    Function GetServer: String;
    Procedure SetDatabase(Const Value: String);
    Procedure SetServer(Const Value: String);
    Function GetBackupPath: String;
    Procedure SetBackupPath(Const Value: String);
    Function CreateTablesSQL(Const includeDrop: Boolean): String;
    Function GetActive: Boolean;
    Procedure SetActive(Const Value: Boolean);
    Function GetMyProtocol: TMyProtocol;
    Function WinExecAndWait(Const FileName: String): DWord;
    Procedure StartServices;
    Procedure StopServices;
    Function FilterTablesNames(Const sl: TStringList): String;
    Procedure NotToBackupTables;
  Protected
    Property Server: String Read GetServer Write SetServer;  
  Public 
    Constructor Create(AOwner: TComponent); Override;
    Destructor Destroy; Override;
    Procedure Init(Const aserver, adatabase, auser, apassword, aBackupPath: String);
    Function doBackup(Const Remove: Boolean = False; Const NoStartSrvs: Boolean = False): String;
    Function doRestore: String;
    Function doCopy(Const newDatabase: String): String;
    Function BackupExists: Boolean;
    Procedure ClearBackupDir;
    Function DBExists(Const DBName: String): Boolean;
    Function DBVersion: String;
    Function CountThreadsConnected: Integer;
    Property MsgStr: String Read fMsgStr Write fMsgStr;
  Published
    Property Active: Boolean Read GetActive Write SetActive;
    Property Backup: TMyBackup Read FBackup;
    Property backupPath: String Read GetBackupPath Write SetBackupPath;
    Property Connection: TMyConnection Read FConnection;
    Property database: String Read GetDatabase Write SetDatabase;
  End;
Procedure DeleteFiles(Const sPath, sMask: String);

Implementation 

Uses ShellAPI, StrUtils, MySQLErrors, IniFiles, frmBackupManager;

Procedure DeleteFiles(Const sPath, sMask: String);
Var 
  SearchRec: TSearchRec;
  Found: Integer;
  sFile: String;
Begin 
  Found := FindFirst(sPath + sMask, faAnyFile, SearchRec);
  Try 
    While (Found = 0) Do Begin 
      If Not (SearchRec.Attr And faDirectory > 0) Then Begin 
        sFile := SearchRec.Name;
        DeleteFile(sPath + sFile);
      End;
      Found := FindNext(SearchRec);
    End;
  Finally 
    FindClose(SearchRec);
  End;
End;

Constructor TBackupManagerObj.Create(AOwner: TComponent);
Begin 
  Inherited Create(AOwner);
  FConnection := TMyConnection.Create(self);
  FConnection.LoginPrompt := False;
  FConnection.Options.Compress := False;
  FConnection.Port := 3309;
  FBackup := TMyBackup.Create(self);
  FBackup.Mode := bmText;
  FBackup.Duplicates := bdIgnore;
  Query := TMyQuery.Create(self);
  Query.Options.FlatBuffers := True;
  Script := TMyScript.Create(self);
  Script.UseOptimization := True;
  FBackup.Connection := Connection;
  Query.Connection := Connection;
  Script.Connection := Connection;
End;

Destructor TBackupManagerObj.Destroy;
Begin 
  FreeAndNil(Script);
  FreeAndNil(Query);
  FreeAndNil(FBackup);
  FreeAndNil(FConnection);
  Inherited;
End;

Procedure TBackupManagerObj.Init(Const aserver, adatabase, auser, apassword, abackupPath: String);
Begin 
  server := aserver;
  database := adatabase;
  FConnection.Server := aserver;
  FConnection.Username := auser;
  FConnection.Password := apassword;
  FConnection.Database := adatabase;
  FConnection.Options.Protocol := GetMyProtocol;
  Try
    FConnection.Connect;
  except
    on E: EMyError do Begin

      Abort;
    end;
    on E: EMySqlException do begin
      Abort;
    end else raise;
  end;

  Query.SQL.Text := 'show global variables like "basedir";';
  Query.Open;
  backupPath := Query.Fields[1].AsString + 'FBackup\';
  Query.Close;

End;

Function TBackupManagerObj.DBVersion: String;
Begin 
  Result := '';
  Try 
    Query.SQL.Text := 'Show Tables;';
    Query.Open;
    If Not Query.Locate(Query.Fields[0].FieldName, 'tblupdatedetails', [loCaseInsensitive]) Then Begin 
      Query.Close;
      Exit;
    End;
    Query.SQL.Text := 'SELECT Version FROM tblupdatedetails WHERE ID = 1';
    Query.Open;
    Result := Query.FieldByName('Version').AsString;
    Query.Close;
  Except 
    On E: EMyError Do;
    On E: EMySqlException Do;
    Else Raise;
  End;
End;

Function TBackupManagerObj.CountThreadsConnected: Integer;
Begin 
  Query.SQL.Text := 'SHOW PROCESSLIST';
  Query.Open;
  Result := 0;
  Query.First;
  While Not Query.Eof Do Begin 
    If SameText(Query.FieldByName('db').AsString, database) Then Inc(Result);
    Query.Next;
  End;
  Query.Close;
End;

Procedure TBackupManagerObj.ClearBackupDir;
Begin 
  If FBackup.Path <> '' Then Begin 
    ForceDirectories(FBackup.Path);
    DeleteFiles(FBackup.Path, '*.*');
  End;
End;

Function TBackupManagerObj.FilterTablesNames(Const sl: TStringList): String;
Var
  i: Integer;
Begin
  Result := '';
    Query.SQL.TEXT := 'Show Full Tables WHERE Table_Type="VIEW";';
    Query.Open;
    Query.First;
    While Not Query.Eof Do Begin
      i := sl.IndexOf(Query.Fields[0].AsString);
      If i>0 then sl.Delete(i);
      Query.Next;
    End;
    Query.Close;
    Result := sl.CommaText;
end;

Function TBackupManagerObj.CreateTablesSQL(Const includeDrop: Boolean): String;
Var
  sl: TStringList;
  i: Integer;
Begin 
  sl := TStringList.Create;
  Try
    Result := '';
    FConnection.GetTableNames(sl);
    For i := 0 To sl.Count - 1 Do Begin
      Query.SQL.Text := 'SHOW CREATE Table ' + sl[i] + ';';
      Query.Open;
      If includeDrop Then Result := Result + 'DROP TABLE IF EXISTS ' + sl[i] + ';'#13#10;
      Result := Result + Query.Fields[1].AsString + ';'#13#10#13#10;
    End;
  Finally
    sl.Free;
  End;
End;

Function TBackupManagerObj.doBackup(Const Remove: Boolean = False; Const NoStartSrvs: Boolean = False): String;
Var 
  ms: TFileStream;
  sql: String;
  sqlDataBaseName: String;
  cmdQuery: TMyCommand;
Begin 
  StopServices;
  Try 
    Result := 'Error';
    ClearBackupDir;
    If Not FConnection.Connected Then FConnection.Open;
    sql      := CreateTablesSQL(True);
    sqlDatabaseName := StringReplace(Database, 'MSClone', '', [rfIgnoreCase]);
    cmdQuery := TMyCommand.Create(Nil);
    ms       := TFileStream.Create(FBackup.Path + '\' + sqlDatabaseName + '_DropCreateTables.sql', fmCreate);
    Try 
      Query.SQL.Text := 'FLUSH TABLES';
      Query.Execute;
      While Query.Executing Do Begin 
        Sleep(100);
        Application.ProcessMessages;
      End;
      ms.Write(sql[1], Length(sql));
      NotToBackupTables;
      FBackup.Backup;
      Result := 'OK';
    Finally 
      ms.Free;
      Query.SQL.Text := 'UNLOCK TABLES';
      Query.Execute;
      While Query.Executing Do Begin 
        Sleep(100);
        Application.ProcessMessages;
      End;
      Query.Close;
    End;
    If Remove Then Begin 
      Try 
        FConnection.Close;
        FConnection.Database := 'mysql';
        FConnection.Open;
        cmdQuery.Connection := Connection;
        cmdQuery.SQL.Add('DROP DATABASE `' + sqlDatabaseName + '`;');
        cmdQuery.Execute;
        While cmdQuery.Executing Do Begin 
          Sleep(100);
          Application.ProcessMessages;
        End;
        FConnection.Close;
        FConnection.Database := sqlDatabaseName;
      Except 
      End;
    End;
  Finally
    If Not NoStartSrvs Then StartServices;
  End;
End;

Function TBackupManagerObj.doCopy(Const newDatabase: String): String;
Var 
  ms: TFileStream;
  origDB, sql: String;
Begin 
  Try 
    origDB := FConnection.Database;
    If Not FConnection.Connected Then FConnection.Open;
    If doBackup(False, True) = 'OK' Then Begin 
      Result := 'Error';
      If FileExists(FBackup.Path + '\' + Database + '_DropCreateTables.sql') Then Begin
        FConnection.ExecSQL('CREATE DATABASE ' + newDatabase + ';', []);
        FConnection.Close;
        FConnection.Database := newDatabase;
        FConnection.Open;
        ms := TFileStream.Create(FBackup.Path + '\' + origDB + '_DropCreateTables.sql', fmOpenRead);
        Try 
          SetLength(sql, ms.Size);
          ms.Read(sql[1], ms.Size);
          Script.SQL.Text := sql;
          Script.Execute;
          FBackup.Restore;
          Result := 'OK';
        Finally 
          ms.Free;
          FConnection.Close;
          FConnection.Database := origDB;
        End;
      End;
    End;
  Finally 
    StartServices;
  End;
End;

Function TBackupManagerObj.doRestore: String;
Var 
  ms: TFileStream;
  dbName, sql: String;
  cmdQuery: TMyCommand;
Begin 
  StopServices;
  Try 
    Result := 'Error';
    If Not FConnection.Connected Then FConnection.Open;
    If FileExists(FBackup.Path + '\' + Database + '_DropCreateTables.sql') Then Begin 
      cmdQuery := TMyCommand.Create(Nil);
      ms := TFileStream.Create(FBackup.Path + '\' + Database + '_DropCreateTables.sql', fmOpenRead);
      Try 
        If DBExists(Database) Then Begin 
          dbName := Database;
          FConnection.Disconnect;
          FConnection.Database := 'mysql';
          FConnection.Open;
          cmdQuery.Connection := FConnection;
          cmdQuery.SQL.Text := 'DROP DATABASE `' + dbName + '`;';
          cmdQuery.Execute;
          While cmdQuery.Executing Do Begin 
            Sleep(100);
            Application.ProcessMessages;
          End;
          Sleep(1000);
        End;
        SetLength(sql, ms.Size);
        ms.Read(sql[1], ms.Size);
        cmdQuery.SQL.Text := 'CREATE DATABASE `' + dbName + '`;';
        cmdQuery.Execute;
        While cmdQuery.Executing Do Begin 
          Sleep(100);
          Application.ProcessMessages;
        End;
        Sleep(1000);
        FConnection.Disconnect;
        FConnection.Database := dbName;
        Database := dbName;
        FConnection.Open;
        Script.SQL.Text := sql;
        Script.Execute;
        FBackup.Restore;
        Result := 'OK';
      Finally 
        ms.Free;
      End;
    End;
  Finally 
    StartServices;
  End;
End;

Function TBackupManagerObj.GetBackupPath: String;
Begin 
  Result := FBackup.Path;
End;

Function TBackupManagerObj.GetDatabase: String;
Begin 
  Result := FConnection.Database;
End;

Function TBackupManagerObj.GetServer: String;
Begin 
  Result := FConnection.Server;
End;

Procedure TBackupManagerObj.SetBackupPath(Const Value: String);
Begin 
  FBackup.Path := Value;
  If FBackup.Path[Length(FBackup.Path)] <> '\' Then backupPath := FBackup.Path + '\';
End;

Procedure TBackupManagerObj.SetDatabase(Const Value: String);
Begin 
  FConnection.Close;
  FConnection.Database := Value;
End;

Procedure TBackupManagerObj.SetServer(Const Value: String);
Begin 
  FConnection.Close;
  FConnection.Server := Value;
End;

Function TBackupManagerObj.GetActive: Boolean;
Begin 
  Result := FConnection.Connected;
End;

Procedure TBackupManagerObj.SetActive(Const Value: Boolean);
Begin 
  If Value Then FConnection.Open 
  Else FConnection.Close;
End;

Function TBackupManagerObj.BackupExists: Boolean;
Begin 
  Result := FConnection.Connected And FileExists(FBackup.Path + '\' + Database + '_DropCreateTables.sql');
End;

Function TBackupManagerObj.DBExists(Const DBName: String): Boolean;
Var 
  ls: TStringList;
Begin 
  ls := TStringList.Create;
  Try 
    FConnection.GetDatabaseNames(ls);
    Result := ls.IndexOf(DBName) > -1;
  Finally 
    ls.Free;
  End;
End;

Function TBackupManagerObj.GetMyProtocol: TMyProtocol;
Var 
  IniFile: TMemIniFile;
  ProtocolName: String;
Begin 
  IniFile := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + 'Protocol.ini');
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

Function TBackupManagerObj.WinExecAndWait(Const FileName: String): DWord;
Var 
  zAppName: Array[0..512] Of Char;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  Procedure WaitFor(processHandle: THandle);
  Var 
    msg: TMsg;
    ret: DWORD;
  Begin 
    Repeat 
      ret := MsgWaitForMultipleObjects(1, processHandle, False, INFINITE, QS_PAINT Or QS_SENDMESSAGE);
      If ret = WAIT_FAILED Then Exit;
      If ret = (WAIT_OBJECT_0 + 1) Then Begin 
        While PeekMessage(msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) Do DispatchMessage(msg);
      End;
    Until ret = WAIT_OBJECT_0;
  End;
Begin 
  StrPCopy(zAppName, FileName);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;
  If Not CreateProcess(Nil, zAppName, Nil, Nil, False, CREATE_NEW_CONSOLE Or NORMAL_PRIORITY_CLASS, Nil, Nil, StartupInfo, ProcessInfo) Then Result := DWORD(-1)
  Else Begin 
    Waitfor(ProcessInfo.hProcess);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  End;
End;

Procedure TBackupManagerObj.StartServices;
Var 
  IniFile: TMemIniFile;
  ServiceName: String;
  Count: Integer;
  Done: Boolean;
Begin 
  Count := 0;
  Done := False;
  IniFile := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + 'Protocol.ini');
  Try 
    While Not Done Do Begin 
      ServiceName := IniFile.ReadString('Services', 'Service' + IntToStr(Count), '');
      If (ServiceName = '') Then Begin 
        Done := True;
        Continue;
      End;
      Inc(Count);
      fMsgStr := 'Starting ' + ServiceName;
      PostMessage(TForm(Self.Owner).Handle, TX_SendMemoLine, 0, 0);
      WinExecAndWait('Net Start ' + ServiceName);
      fMsgStr := 'Started ' + ServiceName;
      PostMessage(TForm(Self.Owner).Handle, TX_SendMemoLine, 0, 0);
    End;
  Finally 
    IniFile.Free;
  End;
End;

Procedure TBackupManagerObj.StopServices;
Var 
  IniFile: TMemIniFile;
  ServiceName: String;
  Count: Integer;
  Done: Boolean;
Begin 
  Count := 0;
  Done := False;
  IniFile := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + 'Protocol.ini');
  Try 
    While Not Done Do Begin 
      ServiceName := IniFile.ReadString('Services', 'Service' + IntToStr(Count), '');
      If (ServiceName = '') Then Begin 
        Done := True;
        Continue;
      End;
      Inc(Count);
      fMsgStr := 'Stopping ' + ServiceName;
      PostMessage(TForm(Self.Owner).Handle, TX_SendMemoLine, 0, 0);
      WinExecAndWait('Net Stop ' + ServiceName);
      fMsgStr := 'Stopped ' + ServiceName;
      PostMessage(TForm(Self.Owner).Handle, TX_SendMemoLine, 0, 0);
    End;
  Finally 
    IniFile.Free;
  End;
End;

Procedure TBackupManagerObj.NotToBackupTables;
var
  slTableNames: TStringList;
  posPartTable: Integer;
  i, ix: Integer;
begin
  FBackup.TableNames := '';
  If BackupManagerGUI.TablesNotToBackup.Items.Count > 0 Then Begin
    slTableNames := TStringList.Create;
    Try 
      If Not FConnection.Connected Then FConnection.Open;
      FConnection.GetTableNames(slTableNames);
      For i := 0 To BackupManagerGUI.TablesNotToBackup.Count - 1 Do Begin 
        posPartTable := Pos('*', BackupManagerGUI.TablesNotToBackup.Items[i]);
        If posPartTable > 1 Then Begin 
          For ix := slTableNames.Count - 1 Downto 0 Do If (Length(slTableNames[ix]) >= posPartTable) And SameText(Copy(BackupManagerGUI.TablesNotToBackup.Items[i], 1, posPartTable - 1), Copy(slTableNames[ix], 1, posPartTable - 1)) Then slTableNames.Delete(ix);
        End Else Begin 
          ix := slTableNames.IndexOf(BackupManagerGUI.TablesNotToBackup.Items[i]);
          If ix > -1 Then slTableNames.Delete(ix);
        End
      End;
      FBackup.TableNames := FilterTablesNames(slTableNames);
    Finally 
      slTableNames.Free;
    End;
  End;
end;

End.

