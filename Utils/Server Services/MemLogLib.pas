Unit MemLogLib;

Interface 

Uses WINDOWS, SyncObjs, Types, Classes, SysUtils, PsApi;

Procedure LogMemAction(Const ProcessHandle: THandle; Const ActionStr: String);
Procedure LogAction(Const ActionStr: String);
Procedure LogFile(Const ActionStr: String);

Implementation 

Uses SrvService, InstallConst;

Const
//  LOGSPATH    = 'C:\ERP Software\Logs\';
  LOGFILENAME = 'ServerServicesEventLog.log';
Var
  CritLock: TCriticalSection;

function LOGPATH : string;
begin
  Result := ERP_SERVER_LOG_DIR;
end;

Function GetProcessMemoryInKBytes(Const ProcessHandle: THandle): Integer;
Var 
  pmc: PPROCESS_MEMORY_COUNTERS;
  cb: Integer;
Begin 
  cb := SizeOf(PROCESS_MEMORY_COUNTERS);
  GetMem(pmc, cb);
  pmc^.cb := cb;
  If GetProcessMemoryInfo(ProcessHandle, pmc, cb) Then Begin 
    Result := pmc^.WorkingSetSize Shr 10;
  End Else Begin 
    Result := 0;
  End;
  FreeMem(pmc);
End;

Procedure LogMemAction(Const ProcessHandle: THandle; Const ActionStr: String);
Var 
  StrList: TStringList;
Begin 
  If Not SrvServices.MemLogActive Then Exit;
  CritLock.Acquire;
  Try 
    StrList := TStringList.Create;
    Try
      If FileExists(LOGPATH+'ServerServices.log') Then StrList.LoadFromFile(LOGPATH+'ServerServices.log');
      StrList.Add('');
      StrList.Add('Memory In Bytes' + #9 + IntToStr(GetProcessMemoryInKBytes(ProcessHandle)) + 'k' + #9 + ActionStr + #9 + DateTimeToStr(Now()));
      StrList.Add('');
      StrList.SaveToFile(LOGPATH + 'ServerServices.log');
    Finally 
      StrList.Clear;
      StrList.Free;
    End;
  Finally 
    CritLock.Release;
  End;
End;

Procedure LogAction(Const ActionStr: String);
Var 
  StrList: TStringList;
Begin 
  If Not SrvServices.MemLogActive Then Exit;
  CritLock.Acquire;
  Try 
    StrList := TStringList.Create;
    Try
      If FileExists(LOGPATH + 'ServerServices.log') Then StrList.LoadFromFile(LOGPATH+'ServerServices.log');
      StrList.Add(ActionStr + #9 + DateTimeToStr(Now()));
      StrList.SaveToFile(LOGPATH+'ServerServices.log');
    Finally 
      StrList.Clear;
      StrList.Free;
    End;
  Finally 
    CritLock.Release;
  End;
End;

Procedure LogFile(Const ActionStr: String);
Var 
  logFile: TextFile;
Begin 
  CritLock.Acquire;
  Try 
    ForceDirectories(LOGSPATH);{$I-} System.CloseFile(logFile);{$I+} If IOResult = 0 Then;
    System.AssignFile(logFile, LOGSPATH + LOGFILENAME);
    Try 
      If FileExists(LOGSPATH + LOGFILENAME) Then Begin{$I-} System.Append(logFile);{$I+} If IOResult = 0 Then;
      End Else Begin{$I-} System.Rewrite(logFile);{$I+} If IOResult <> 0 Then;
      End;
      System.Writeln(logFile, FormatDateTime('yyyy-mm-dd hh:nn ', Now), ActionStr);
      System.Flush(logFile);
    Finally 
      System.CloseFile(logFile);
    End;
  Finally 
    CritLock.Release;
  End;
End;

Initialization 
  CritLock := TCriticalSection.Create;
End.

