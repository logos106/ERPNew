Unit DisplayForm;

Interface

Uses Windows, Forms, AdvOfficeStatusBar, AdvOfficeStatusBarStylers,
  AdvPanel, DB, DBAccess, MyAccess, SelectionDialog, DNMSpeedButton,
  StdCtrls, wwcheckbox, wwdbedit, Mask, Wwdbspin, AdvReflectionLabel,
  Controls, ExtCtrls, Classes;

Type 
  TUpdateGUI = Class(TForm)
    dlgCurrentUsers: TSelectionDialog;
    MyConnection: TMyConnection;
    AdvPanel1: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel4: TBevel;
    Label12: TLabel;
    txtMem: TwwDBSpinEdit;
    TotalMem: TwwDBEdit;
    RecommendedMem: TwwDBEdit;
    chkDedicatedServer: TwwCheckBox;
    MaxMem: TwwDBEdit;
    MinMem: TwwDBEdit;
    CurrentMem: TwwDBEdit;
    AdvReflectionLabel1: TAdvReflectionLabel;
    UpdateBtn: TDNMSpeedButton;
    StatusBar: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    CloseBtn: TDNMSpeedButton;
    Procedure CloseBtnClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure chkDedicatedServerClick(Sender: TObject);
    Procedure UpdateBtnClick(Sender: TObject);
    Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
  Private 
    iTotalMemInMB: Integer;
    iMinMemInMB: Integer;
    iMaxMemInMB: Integer;
    iRecommendedMemInMB: Integer;
    iCurrentMemInMB: Integer;
    Procedure UpdateIni;
    Procedure DeleteFiles(Const Path, Mask: String);
    Procedure RefreshMemoryDisplay;
    Function GetCurrentSetting: Integer;
    Function StrValue(Const sValue: String): Double;
    Function WinExecAndWait(Const FileName: String): Longword;
    Function ExtractStrPortion(Const Source: String; Const Delim: String; Const PosCount: Integer): String;
    Function GetCurrentUsers: TStringList;
    Function GetMySQLDir: String;
  Public
  End;

Var
  UpdateGUI: TUpdateGUI;

Implementation

Uses SysUtils, IniFiles, Graphics, Dialogs, ShellAPI, FastFuncs, Registry, Vista_MessageDlg,
  InstallConst;

{$R *.dfm}

Const
  LOCALHOST: String = 'LOCALHOST';
  INIFILEVERSION: String = '7.2';

Procedure TUpdateGUI.CloseBtnClick(Sender: TObject);
Begin 
  Self.Close;
End;

Procedure TUpdateGUI.FormCreate(Sender: TObject);
Begin 
  RefreshMemoryDisplay;
End;

Procedure TUpdateGUI.chkDedicatedServerClick(Sender: TObject);
Begin 
  RefreshMemoryDisplay;
End;

Procedure TUpdateGUI.UpdateBtnClick(Sender: TObject);
Begin 
  Try 
    dlgCurrentUsers.Items.Assign(GetCurrentUsers);
    If dlgCurrentUsers.Items.Count <= 1 Then
      UpdateIni 
    Else Begin 
      dlgCurrentUsers.Caption := 'MySQL Server Configuration';
      dlgCurrentUsers.Color   := $00E3F0F2;
      dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
      dlgCurrentUsers.Execute;
    End;
  Except 
  End;  
End;

Function TUpdateGUI.GetCurrentSetting: Integer;
Var 
  MyIni: TMemIniFile;
Begin 
  MyIni := TMemIniFile.Create(GetMySQLDir+'\bin\myERP.ini');
  Try 
    Result := Trunc(StrValue(MyIni.ReadString('ERP', 'MaxMemSet', '')));
    If Result = 0 Then Result := Trunc(StrValue(MyIni.ReadString('mysqld', 'innodb_buffer_pool_size', '')));
  Finally 
    FreeAndNil(MyIni);
  End;
End;

Procedure TUpdateGUI.RefreshMemoryDisplay;
Var 
  MemStat: TMemoryStatus;
Begin 
  MemStat.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MemStat);
  iTotalMemInMB := Trunc(MemStat.dwTotalPhys / 1000000);
  iMinMemInMB := 64;
  iMaxMemInMB := Trunc(iTotalMemInMB * 0.50);
  If chkDedicatedServer.Checked Then iRecommendedMemInMB := Trunc(iTotalMemInMB * 0.40)
  Else iRecommendedMemInMB := Trunc(iTotalMemInMB * 0.20);
  If iRecommendedMemInMB < iMinMemInMB Then iRecommendedMemInMB := iMinMemInMB;
  If iRecommendedMemInMB > iMaxMemInMB Then iRecommendedMemInMB := iMaxMemInMB;
  iCurrentMemInMB := GetCurrentSetting;
  txtMem.MinValue := iMinMemInMB;
  txtMem.MaxValue := iMaxMemInMB;
  TotalMem.Text := FormatFloat('###,###,##0.##MB', iTotalMemInMB);
  MinMem.Text := FormatFloat('###,###,##0.##MB', iMinMemInMB);
  MaxMem.Text := FormatFloat('###,###,##0.##MB', iMaxMemInMB);
  RecommendedMem.Text := FormatFloat('###,###,##0.##MB', iRecommendedMemInMB);
  CurrentMem.Text := FormatFloat('###,###,##0.##MB', iCurrentMemInMB);
  txtMem.Value := iRecommendedMemInMB;
End;

Function TUpdateGUI.StrValue(Const sValue: String): Double;
Var 
  sTemp: String;
  bIsNeg: Boolean;
  i: Integer;
Begin 
  bIsNeg := (Pos('-', sValue) > 0) Or (Pos('(', sValue) > 0);
  sTemp := '';
  For i := 1 To Length(sValue) Do If sValue[i] In ['0'..'9', DecimalSeparator] Then sTemp := sTemp + sValue[i];
  If sTemp = '' Then sTemp := '0';
  If bIsNeg Then sTemp := '-' + sTemp;
  Try 
    Result := StrToFloat(sTemp);
  Except 
    Result := 0.00;
  End;
End;

Procedure TUpdateGUI.UpdateIni;
Var 
  MyIni: TMemIniFile;
  iMaxMemSet: Integer;
  iInnoBuffer: Integer;
  iLogfile: Integer;
  iKeyBuffer: Integer;
  TempStrList: TStringList;

  Procedure AddExtraToIni(Const StringList: TStringList; Const Value:String);
  begin
    StringList.CaseSensitive := false;
    If StringList.IndexOf(Value)<0 then
      StringList.Insert(StringList.IndexOf('[mysqld]')+1,Value);
  end;

Begin 
  StatusBar.Panels[1].Progress.Position := 0;
  StatusBar.Panels[1].Enabled := True;
  UpdateBtn.Enabled := False;
  CloseBtn.Enabled := False;
  Screen.Cursor := crHourGlass;
  Try 
    MyIni := TMemIniFile.Create(GetMySQLDir+'\bin\myERP.ini');
    Try 
      MyIni.WriteString('ERP', 'ServerConfiguration', INIFILEVERSION);
      MyIni.WriteString('mysqld', 'port', '3309');
      MyIni.WriteString('mysqld', 'default-storage-engine', 'INNODB');
      MyIni.WriteString('mysqld', 'sql-mode', '"STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"');
      MyIni.WriteString('mysqld', 'max_connections', '800');
      MyIni.WriteString('mysqld', 'max_allowed_packet', '1GB');
      MyIni.WriteString('mysqld', 'table_cache', '512');
      MyIni.WriteString('mysqld', 'net_buffer_length', '2K');
      MyIni.WriteString('mysqld', 'thread_stack', '64K');
      MyIni.WriteString('mysqld', 'thread_cache_size', '38');
      MyIni.WriteString('mysqld', 'thread_concurrency', '8');
      MyIni.WriteString('mysqld', 'tmp_table_size', '20M');
      MyIni.WriteString('mysqld', 'query_cache_size', '16M');
      MyIni.WriteString('mysqld', 'join_buffer_size', '2M');
      MyIni.WriteString('mysqld', 'read_buffer_size', '2M');
      MyIni.WriteString('mysqld', 'read_rnd_buffer_size', '8M');
      MyIni.WriteString('mysqld', 'myisam_sort_buffer_size', '64M');
      MyIni.WriteString('mysqld', 'myisam_max_sort_file_size', '100G');
      MyIni.WriteString('mysqld', 'myisam_max_extra_sort_file_size', '100G');
      MyIni.WriteString('mysqld', 'sort_buffer_size', '4M');

      MyIni.WriteString('mysqld', 'innodb_additional_mem_pool_size', '20M');
      MyIni.WriteString('mysqld', 'innodb_flush_log_at_trx_commit', '1');
      MyIni.WriteString('mysqld', 'innodb_log_buffer_size', '8M');
      MyIni.WriteString('mysqld', 'innodb_file_io_threads', '8');
      MyIni.WriteString('mysqld', 'innodb_thread_concurrency', '8');
      MyIni.WriteString('mysqld', 'innodb_lock_wait_timeout', '10');
      MyIni.WriteString('mysqld', 'innodb_open_files', '600');
      MyIni.WriteString('mysqld', 'innodb_locks_unsafe_for_binlog', '1');


      iMaxMemSet := Trunc(txtMem.Value);
      MyIni.WriteString('ERP', 'MaxMemSet', IntToStr(iMaxMemSet) + 'M');
      iKeyBuffer := (iMaxMemSet Div 5) Div 2;
      iInnoBuffer := Trunc((iMaxMemSet * 0.80) - iKeyBuffer);
      iLogfile := iInnoBuffer Div 4;
      MyIni.WriteString('mysqld', 'key_buffer_size', IntToStr(iKeyBuffer) + 'M');
      MyIni.WriteString('mysqld', 'innodb_buffer_pool_size', IntToStr(iInnoBuffer) + 'M');
      MyIni.WriteString('mysqld', 'innodb_log_file_size', IntToStr(iLogfile) + 'M');

      TempStrList := TStringList.Create;
      Try
        MyIni.GetStrings(TempStrList);
        AddExtraToIni(TempStrList,'innodb_file_per_table');
        AddExtraToIni(TempStrList,'skip-merge');
        AddExtraToIni(TempStrList,'skip-name-resolve');
        AddExtraToIni(TempStrList,'skip-ndbcluster');
        AddExtraToIni(TempStrList,'skip-bdb');
        AddExtraToIni(TempStrList,'skip-host-cache');
        AddExtraToIni(TempStrList,'skip-external-locking');
        AddExtraToIni(TempStrList,'skip-locking');
        MyIni.SetStrings(TempStrList);
      Finally 
        FreeAndNil(TempStrList);
      End;
      MyIni.UpdateFile;
    Finally 
      FreeAndNil(MyIni);
    End;
    StatusBar.Panels[1].StepIt;
    WinExecAndWait('net Stop ' + MySQL_ERP_SERVICE); //MySQL_ERP');
    StatusBar.Panels[1].StepIt;
    Sleep(1500);
    DeleteFiles(GetMySQLDir+'\data\', 'ib_*.*');
    DeleteFiles(GetMySQLDir+'\data\', '*.err');
    StatusBar.Panels[1].StepIt;
    WinExecAndWait('net Start ' + MySQL_ERP_SERVICE); //MySQL_ERP');
    Sleep(1500);
    StatusBar.Panels[1].StepIt;
    // Flush Log
    Self.MyConnection.Disconnect;
    Self.MyConnection.Connect;
    Self.MyConnection.ExecSQL('FLUSH Logs;',[]);
    Sleep(1500);
    // DeleteFiles(GetMySQLDir+'\data\', '*.err-old');
    iCurrentMemInMB := GetCurrentSetting;
    CurrentMem.Text := FormatFloat('###,###,##0.##MB', iCurrentMemInMB);
  Finally 
    UpdateBtn.Enabled := True;
    CloseBtn.Enabled  := True;
    Screen.Cursor     := crDefault;
    StatusBar.Panels[1].Enabled := False;
    StatusBar.Panels[1].Progress.Position := 0;
  End;
End;

Function TUpdateGUI.WinExecAndWait(Const FileName: String): Longword;
Var 
  zAppName: Array[0..512] Of Char;
  zCurDir: Array[0..255] Of Char;
  WorkDir: String;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  dwResult: dword;
Begin 
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;
  If Not CreateProcess(Nil, zAppName, Nil, Nil, False, CREATE_NEW_CONSOLE Or NORMAL_PRIORITY_CLASS, Nil, Nil, StartupInfo, ProcessInfo) Then Result := WAIT_FAILED 
  Else Begin 
    While True Do Begin 
      Application.ProcessMessages;
      dwResult := WaitforSingleObject(ProcessInfo.hProcess, 1000);
      If dwResult = WAIT_OBJECT_0 Then Begin 
        GetExitCodeProcess(ProcessInfo.hProcess, Result);
        CloseHandle(ProcessInfo.hProcess);
        CloseHandle(ProcessInfo.hThread);
        Break;
      End;
    End;
  End;
End;

Procedure TUpdateGUI.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin 
  If Self.ModalResult <> mrCancel Then CanClose := False;
End;

Function TUpdateGUI.ExtractStrPortion(Const Source, Delim: String; Const PosCount: Integer): String;
Var 
  S: Integer;
  E: Integer;
  L9: Integer;
  Src: String;
Begin 
  Src := Source + Delim;
  S := 1;
  For L9 := 1 To PosCount - 1 Do Begin 
    S := Pos(Delim, Src);
    If S > 0 Then Delete(Src, S, Length(Delim))
    Else Break;
  End;
  Result := '';
  If S > 0 Then Begin 
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  End;
End;

Function TUpdateGUI.GetMySQLDir: String;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly('\SOFTWARE\ERP Software\ERP\MySQL Server') then  begin
      Result := Reg.ReadString('InstallPath');
      Reg.CloseKey;
    end;                        
  finally
    Reg.Free;
  end;
end;

Function TUpdateGUI.GetCurrentUsers: TStringList;
Var
  oData: TMyQuery;
  sUser: String;
Begin
  oData := TMyQuery.Create(Nil);
  Result := TStringList.Create;
  Try
    Result.Sorted     := True;
    Result.Duplicates := dupIgnore;
    With oData Do Begin
      Connection := Self.MyConnection;
      SQL.Text := 'Show ProcessList;';
      Try 
        Open;
      Except
        MessageDlgXP_Vista('Can''t Connect To Server', mtWarning, [mbOK], 0);
        Exit;
      End;
    End;
    oData.First;
    While Not oData.Eof Do Begin
      sUser := UpperCase(ExtractStrPortion(ExtractStrPortion(oData.FieldByName('Host').AsString, ':', 1), '.', 1));
      If sUser = LOCALHOST Then Begin 
        sUser := 'ERP SERVER';
      End;
      If Not SameText(UpperCase(oData.FieldByName('DB').AsString), 'services') Then Result.Add(sUser);
      oData.Next;
    End;
  Finally
    oData.Free;
  End;
End;

Procedure TUpdateGUI.DeleteFiles(Const Path, Mask: String);
Var 
  lpFileOp: TSHFileOpStruct;
Begin 
  FillChar(lpFileOp, SizeOf(lpFileOp), #0);
  lpFileOp.wFunc := FO_DELETE;
  lpFileOp.pFrom := PChar(Path + Mask + #0);
  lpFileOp.pTo := PChar(Path);
  lpFileOp.fFlags := FOF_NOCONFIRMATION Or FOF_FILESONLY Or FOF_SILENT;
  If (SHFileOperation(lpFileOp) <> 0) Then Exit;
End;

End.
