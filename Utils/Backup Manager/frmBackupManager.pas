Unit frmBackupManager;

Interface

Uses Windows, Messages, Forms, Graphics, SysUtils, TaskDialog,
  TaskDialogEx, AdvOfficeStatusBar, AdvOfficeStatusBarStylers, AbBase,
  AbBrowse, AbZBrows, AbZipper, AbZipKit, ExtCtrls, ImgList, Controls,
  AdvPanel, StdCtrls, DNMSpeedButton, AdvPageControl, ComCtrls, MyAccess, DB,
  AdvReflectionLabel, Classes, SynchedThreads, SyncObjs, BackupManagerObj;

Const
  TX_SendMemoLine = WM_User + 100;
Type
  TThreadRecord = Record
    resultString: String;
    newDBName: String;
  End;
  TBackupManagerGUI = Class(TForm)
    pnlTitle: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvReflectionLabel1: TAdvReflectionLabel;
    AdvPanel1: TAdvPanel;
    PageControl1: TAdvPageControl;
    AdvTabSheet4: TAdvTabSheet;
    Label2: TLabel;
    AdvTabSheet5: TAdvTabSheet;
    Label1: TLabel;
    AdvPanel2: TAdvPanel;
    cbDataBase: TComboBox;
    edDBPassword: TLabeledEdit;
    edDBUserName: TLabeledEdit;
    PageControl2: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    Label7: TLabel;
    AdvTabSheet2: TAdvTabSheet;
    Label10: TLabel;
    AdvTabSheet3: TAdvTabSheet;
    AdvTabSheet6: TAdvTabSheet;
    ImageList1: TImageList;
    Timer1: TTimer;
    AbZipKit: TAbZipKit;
    AdvPanel4: TAdvPanel;
    AdvPanel5: TAdvPanel;
    AdvPanel6: TAdvPanel;
    AdvPanel7: TAdvPanel;
    btnBackupAll: TDNMSpeedButton;
    lbBackup: TLabel;
    btnBackup: TDNMSpeedButton;
    lbBackupAll: TListBox;
    TablesNotToBackup: TListBox;
    Label6: TLabel;
    lbRestore: TLabel;
    cbShowAllDBs: TCheckBox;
    Label5: TLabel;
    lbArchive: TListBox;
    lbActiveThreads: TLabel;
    Label4: TLabel;
    btnRestore: TDNMSpeedButton;
    edNewDBName: TLabeledEdit;
    btnClone: TDNMSpeedButton;
    lbNewMultisite: TListBox;
    lbCreateHelp: TLabel;
    btnCreateDB: TDNMSpeedButton;
    memLog: TMemo;
    Label3: TLabel;
    Label9: TLabel;
    StatusBar: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    ProgressTimer: TTimer;
    MessageDialog: TAdvTaskDialogEx;
    btnRemove: TDNMSpeedButton;
    Bevel1: TBevel;
    Servertxt: TEdit;
    lblserver: TLabel;
    chkExcludePics: TCheckBox;
    Label8: TLabel;
    Procedure FormCreate(Sender: TObject);
    Procedure FormDestroy(Sender: TObject);
    Procedure edNewDBNameChange(Sender: TObject);
    Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Procedure btnClick(Sender: TObject);
    Procedure lbArchiveClick(Sender: TObject);
    Procedure FormShow(Sender: TObject);
    Procedure cbDataBaseDropDown(Sender: TObject);
    Procedure cbDataBaseChange(Sender: TObject);
    Procedure AutoProcess(Sender: TObject);
    Procedure btnCreateDBClick(Sender: TObject);
    Procedure lbNewMultisiteClick(Sender: TObject);
    Procedure cbShowAllDBsClick(Sender: TObject);
    Procedure edDBPasswordExit(Sender: TObject);
    Procedure btnBackupAllClick(Sender: TObject);
    procedure ProgressTimerTimer(Sender: TObject);
    procedure chkExcludePicsClick(Sender: TObject);
  Private 
    Thread: TStopStartThread;
    ThreadRecord: TThreadRecord;
    BackupManagerObj: TBackupManagerObj;
    newDatabaseName: String;
    Remove: Boolean;
    ArchivePathandFileName: String;
    Procedure doBackup(Data: Pointer);
    Procedure doRestore(Data: Pointer);
    Procedure doCopy(Data: Pointer);
    Procedure doDropDatabase(Data: Pointer);
    Function execBackup(Const ArchiveFileName: String): String;
    Function execRestore(Const ArchiveFileName: String): String;
    Function execCopy(Const newDBName: String): String;
    Function ExtractDBNameFromBackupName(Const ArchiveName: String): String;
    Procedure ShowStatus;
    Procedure AddMemoLine(Var Msg: TMessage); Message TX_SendMemoLine;

    Procedure StatusStart(Const StatusMsg:String; Const MsgColour:TColor=clNone);
    Procedure StatusStop (Const StatusMsg:String; Const MsgColour:TColor=clNone);

  Public 
  End;

Var 
  BackupManagerGUI: TBackupManagerGUI;
  
Implementation

uses
  Dialogs;

{$R *.dfm}

{$I BackupManager.inc}

Const 
  BACKUPARCHIVE = 'C:\ERP Software\Backup\';

var
  LockMEMO: TCriticalSection;

Procedure FindInCurrentDir(Const Mask: String; Var sl: TStringList);
Var 
  sr: TSearchRec;
Begin 
  sl.Clear;
  If FindFirst(Mask, faAnyFile, sr) = 0 Then Repeat 
      sl.Add(sr.Name)
    Until FindNext(sr) <> 0;
  SysUtils.FindClose(sr);
End;

Procedure TBackupManagerGUI.FormCreate(Sender: TObject);
Begin
  {$IFNDEF DevMode}
   edDBUserName.text := 'P_One';
   edDBPassword.text := '1w$p&LD07';
   edDBUserName.Visible := False;
   edDBPassword.Visible := False;
   lblserver.Visible := False;
   Servertxt.Visible := False;
  {$ENDIF}
  Remove := False;
  Thread := TStopStartThread.Create;
  BackupManagerObj := TBackupManagerObj.Create(self);
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  ForceDirectories(BACKUPARCHIVE);
End;

Procedure TBackupManagerGUI.FormDestroy(Sender: TObject);
Begin 
  Timer1.Enabled := False;
  FreeAndNil(BackupManagerObj);
  Thread.Free;
End;

Procedure TBackupManagerGUI.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
  MessageDialog.Title := 'Warning';
  MessageDialog.Content := #13#10#9+'Abort running DB Maintenance?';
  MessageDialog.CommonButtons  := [cbYes,cbNo];
  CanClose := True;
  If ParamCount > 1 Then CanClose := MessageDialog.Execute = mrYes;
  If CanClose And Thread.Waiting Then Thread.AbortThread;
End;

Procedure TBackupManagerGUI.FormShow(Sender: TObject);
Begin 
  DeleteFiles(ExtractFilePath(Application.ExeName), '*.tmp');
  ShowStatus;
  If (ParamCount > 1) Or SameText('BACKUPALL', ParamStr(1)) Then Timer1.Enabled := True;
End;

Function TBackupManagerGUI.ExtractDBNameFromBackupName(Const ArchiveName: String): String;
Var 
  p: Integer;
Begin 
  p := Pos('.', lbArchive.Items[lbArchive.ItemIndex]);
  While (p > 1) And (ArchiveName[p] <> '_') Do Dec(p);
  Result := Copy(ArchiveName, 1, p - 1);
  if result = '' then result := 'babylon';
End;

Procedure TBackupManagerGUI.ShowStatus;
Var 
  sl: TStringList;
  selectedBackup: String;
  newDB, newMultiSite: String;
  otherThreadsConnected: Integer;
  p, i: Integer;
Begin 
  sl := TStringList.Create;
  Try
    If ParamCount > 1 Then Begin 
      PageControl1.ActivePageIndex := 1;
      PageControl1.Enabled := False;
    End Else Begin 
      PageControl1.ActivePageIndex := 0;
      PageControl1.Pages[1].Visible := False;
      If BackupManagerObj.Active Then cbDatabase.Text := BackupManagerObj.database;
      btnBackup.Enabled := (cbDatabase.Text > '');
      btnBackupAll.Enabled := (cbDatabase.Items.Count > 0);
      If btnBackup.Enabled Then lbBackup.Caption := Format('Click Button to backup %s database', [cbDatabase.Text])
      Else lbBackup.Caption := 'Select a database to enable backup button';
      lbActiveThreads.Visible := btnBackup.Enabled And (lbArchive.ItemIndex > -1);
      btnClone.Enabled := btnBackup.Enabled And (edNewDBName.Text <> '') And Not BackupManagerObj.DBExists(edNewDBName.Text);
      If lbArchive.ItemIndex > -1 Then selectedBackup := lbArchive.Items[lbARchive.ItemIndex];
      SetCurrentDir(BACKUPARCHIVE);
      If (BackupManagerObj.database > '') And Not cbShowAllDBs.Checked Then Begin 
        FindInCurrentDir(BackupManagerObj.database + '*_Backup*.zip', sl);
        For i := sl.Count - 1 Downto 0 Do Begin 
          p := Pos('.', sl[i]);
          While (p > 1) And (sl[i][p] <> '_') Do Dec(p);
          If p > 1 Then If Not SameText(BackupManagerObj.database, Copy(sl[i], 1, p - 1)) Then sl.Delete(i);
        End;
      End Else FindInCurrentDir('*.zip', sl);
      If BackupManagerObj.Active Then Begin 
        lbArchive.Items.Assign(sl);
        lbArchive.ItemIndex := lbArchive.Items.IndexOf(selectedBackup);
        otherThreadsConnected := 0;
        If lbActiveThreads.Visible Then Begin 
          otherThreadsConnected := BackupManagerObj.CountThreadsConnected;
          lbActiveThreads.Caption := IntToStr(otherThreadsConnected);
        End;
        btnRestore.Enabled := btnBackup.Enabled And (lbArchive.ItemIndex > -1) And (otherThreadsConnected <= 1);
        btnRestore.Caption := 'Restore';
        If btnRestore.Enabled Then Begin 
          newDB := ExtractDBNameFromBackupName(lbArchive.Items[lbArchive.ItemIndex]);
          If Not BackupManagerObj.DBExists(newDB) Then Begin 
            cbDataBase.Text := '';
            btnRestore.Caption := 'Create ' + newDB;
          End Else cbDataBase.Text := newDB;
        End;
      End;
      sl.Clear;
      If lbNewMultisite.ItemIndex > -1 Then newMultiSite := lbNewMultisite.Items[lbNewMultisite.ItemIndex];
      FindInCurrentDir('*_STARTMULTISITE.zip', sl);
      lbNewMultisite.Items.Assign(sl);
      lbNewMultisite.ItemIndex := lbNewMultisite.Items.IndexOf(newMultiSite);
      btnCreateDB.Enabled := BackupManagerObj.Active And (lbNewMultisite.ItemIndex > -1);
      If btnCreateDB.Enabled Then Begin 
        p := Pos('MSClone_', newMultisite);
        newDataBaseName := Copy(newMultisite, 1, p - 1);
        If p > 0 Then btnCreateDB.Caption := 'Create ' + newDataBaseName;
      End;
      lbCreateHelp.Visible := Not btnCreateDB.Enabled;
    End;
  Finally 
    sl.Free;
  End;
End;

Procedure TBackupManagerGUI.doBackup(Data: Pointer);
Begin 
  TThreadRecord(Data^).resultString := BackupManagerObj.doBackup(Remove);
End;

Function TBackupManagerGUI.execBackup(Const ArchiveFileName: String): String;
Var
  SentStamp: TDateTime;
  ArchiveFileNameStr: String;
Begin
  If Remove then
    StatusStart('Removing ' + BackupManagerObj.database + ' ')
  else
    StatusStart('Backing up ' + BackupManagerObj.database + ' ');
  Self.Update;
  
  ArchiveFileNameStr := ArchiveFileName;

  SentStamp := Now;
  If ArchiveFileNameStr = '' Then
    ArchiveFileNameStr := BACKUPARCHIVE + BackupManagerObj.database + '_' + BackupManagerObj.DBVersion + '_Backup' + Format('_%s', [FormatDateTime('yyyy-mm-dd_hh-nn', SentStamp)]) + '.zip'
  Else Begin 
    ArchiveFileNameStr := BACKUPARCHIVE + ArchiveFileNameStr + '.zip';
    If FileExists(ArchiveFileNameStr) Then
      DeleteFile(ArchiveFileNameStr);
  End;
  Self.Update;
  Thread.MsgWaitFor(doBackup, @ThreadRecord);
  Result := ThreadRecord.resultString;
  Self.Update;
  AbZipKit.FileName := ArchiveFileNameStr;
  AbZipKit.Password := BackupManagerObj.Connection.Password;
  AbZipKit.AddFiles(BackupManagerObj.backupPath + '*.*', faAnyFile);
  AbZipKit.CloseArchive;
  BackupManagerObj.ClearBackupDir;
  ArchivePathandFileName := ArchiveFileNameStr;

  If Remove then
    StatusStop('Remove DONE ', clGreen)
  else
    StatusStop('Backup DONE ', clGreen);
  Self.Update;
End;

Procedure TBackupManagerGUI.doCopy(Data: Pointer);
Begin 
  With TThreadRecord(Data^) Do resultString := BackupManagerObj.doCopy(NewDBName);
End;

Function TBackupManagerGUI.execCopy(Const newDBName: String): String;
Begin 
  If Not BackupManagerObj.DBExists(newDBName) Then Begin
    ThreadRecord.newDBName := newDBName;
    StatusStart('Cloning ' + BackupManagerObj.Connection.Database + ' to ' + newDBName + ' ');
    Thread.MsgWaitFor(doCopy, @ThreadRecord);
    BackupManagerObj.ClearBackupDir;
    Result := ThreadRecord.resultString;
    StatusStop('Clone DONE ', clGreen);
  End Else Begin
    Result := 'Error: DB ' + newDBName + ' already exists';
    StatusStop('Clone DONE ', clGreen);
  end;
End;

Procedure TBackupManagerGUI.doRestore(Data: Pointer);
Var 
  i, j: Integer;
  comma: String;
  tableName: String;
Begin
  BackupManagerObj.Backup.TableNames:= '';
  comma := '';
  For i := 0 To AbZipKit.Count - 1 Do If Pos('.sql', AbZipKit.Items[i].FileName) < 1 Then Begin
      tableName := '';
      For j := Length(AbZipKit.Items[i].FileName) Downto 1 Do If AbZipKit.Items[i].FileName[j] In ['a'..'z', 'A'..'Z', '_', '0'..'9'] Then Insert(AbZipKit.Items[i].FileName[j], tableName, 1)
      Else If AbZipKit.Items[i].FileName[j] In ['/', '\'] Then Break;
      BackupManagerObj.Backup.TableNames := BackupManagerObj.Backup.TableNames + comma + tableName;
      If BackupManagerObj.Backup.TableNames > '' Then comma := ',';
    End;
  AbZipKit.ExtractFiles('*.*');
  TThreadRecord(Data^).resultString := BackupManagerObj.doRestore;
End;

Function TBackupManagerGUI.execRestore(Const archiveFileName: String): String;
Var 
  qry: TMyQuery;
  sl: TStringList;
Begin
  StatusStart('Restoring ' + BackupManagerObj.Connection.Database + ' ');
  BackupManagerObj.ClearBackupDir;
  AbZipKit.Password := BackupManagerObj.Connection.Password;
  AbZipKit.OpenArchive(BACKUPARCHIVE + archiveFileName);
  AbZipKit.BaseDirectory := BackupManagerObj.backupPath;
  Thread.MsgWaitFor(doRestore, @ThreadRecord);
  Result := ThreadRecord.resultString;
  BackupManagerObj.ClearBackupDir;
  If Result = 'OK' Then Begin
    sl  := TStringList.Create;
    qry := TMyQuery.Create(Nil);
    qry.Options.FlatBuffers := True;
    qry.Connection := BackupManagerObj.Connection;
    Try
      BackupManagerObj.Connection.GetTableNames(sl);
      If sl.IndexOf('tblmseventlog') > -1 Then Begin 
        qry.SQL.Text := 'SELECT SiteCode FROM tblmsbackendid WHERE BEDefault = "T";';
        qry.Open;
        If qry.RecordCount = 1 Then BackupManagerObj.Connection.ExecSQL('INSERT HIGH_PRIORITY INTO tblmseventlog(' + 'SiteCodeThis, Event, EventText) ' + 'VALUES("' + qry.FieldByName('SiteCode').AsString + '", "RSTR", ' + '"' + archiveFileName + '") ;', []);
      End;
    Finally 
      qry.Free;
      sl.Free;
    End;
    StatusStop('Restore DONE ', clGreen)
  End Else
    StatusStop('ERROR (' + Result + ') Restore ' + BackupManagerObj.Connection.Database, clRed);

End;

Procedure TBackupManagerGUI.doDropDatabase(Data: Pointer);
Var 
  dbName: String;
  cmd: TMyCommand;
Begin 
  dbName := ExtractDBNameFromBackupName(lbArchive.Items[lbArchive.ItemIndex]);
  BackupManagerObj.Connection.Disconnect;
  BackupManagerObj.Connection.Database := 'mysql';
  BackupManagerObj.Connection.Open;
  If BackupManagerObj.Connection.Connected Then Begin 
    cmd := TMyCommand.Create(self);
    Try 
      cmd.Connection := BackupManagerObj.Connection;
      cmd.SQL.Text := 'Use `' + dbname + '`;';
      cmd.Execute;
      cmd.SQL.Text := 'FLUSH TABLES';
      cmd.Execute;
      While cmd.Executing Do Begin 
        Sleep(100);
        Application.ProcessMessages;
      End;
      cmd.SQL.Text := 'Use `mysql`;';
      cmd.Execute;
      cmd.SQL.Text := 'DROP DATABASE `' + dbname + '`;';
      cmd.Execute;
      While cmd.Executing Do Begin 
        Sleep(100);
        Application.ProcessMessages;
      End;
    Finally 
      FreeAndNil(cmd);
    End;
  End;
End;

Procedure TBackupManagerGUI.btnClick(Sender: TObject);
Var
  dbName: String;
Begin
  Try
    If Sender = btnBackup Then Begin
      PageControl1.Enabled := False;
      execBackup('');
    End Else If Sender = btnRestore Then Begin
      dbName := ExtractDBNameFromBackupName(lbArchive.Items[lbArchive.ItemIndex]);
      PageControl1.Enabled := False;
      If BackupManagerObj.DBExists(dbName) Then Begin
        MessageDialog.Title := 'Warning';
        MessageDialog.Content := #13#10#9+'OVERWRITE Database ' + dbName + ' ?';
        MessageDialog.CommonButtons  := [cbYes,cbNo];
        If MessageDialog.Execute <> mrYes Then Exit;
        StatusStart('Dropping ' + dbName + ' ');
        Thread.MsgWaitFor(doDropDatabase, Nil);
      End;
      BackupManagerObj.Connection.ExecSQL('CREATE DATABASE ' + dbname + ';', []);
      BackupManagerObj.database := dbName;
      BackupManagerObj.Active := True;
      execRestore(lbArchive.Items[lbArchive.ItemIndex]);
    End Else If Sender = btnClone Then Begin
      PageControl1.Enabled := False;
      execCopy(edNewDBName.Text);
    End Else If Sender = btnRemove Then Begin
      PageControl1.Enabled := False;
        If BackupManagerObj.DBExists(cbDataBase.Text) Then Begin
          MessageDialog.Title := 'Warning';
          MessageDialog.Content := #13#10#9+'REMOVE Database "' + cbDataBase.Text + '" ?';
          MessageDialog.CommonButtons  := [cbYes,cbNo];
          If MessageDialog.Execute <> mrYes Then Exit;
           Remove := True;
          Try
            execBackup('');
           Finally
            Remove := False;
          End;
        End;
      End;
  Finally
    PageControl1.Enabled := True;
    Screen.Cursor        := crDefault;
    ShowStatus;
  End;
End;

Procedure TBackupManagerGUI.btnBackupAllClick(Sender: TObject);
Var 
  i: Integer;
Begin 
  If cbDataBase.Items.Count > 0 Then Begin 
    lbBackupAll.Clear;
    lbBackupAll.Visible := True;
    For i := 0 To cbDataBase.Items.Count - 1 Do Begin 
      BackupManagerObj.database := cbDataBase.Items[i];
      BackupManagerObj.Active := True;
      If BackupManagerObj.DBVersion > '' Then lbBackupAll.Items.Add(BackupManagerObj.database);
    End;
    Self.Update;
    For i := 0 To lbBackupAll.Items.Count - 1 Do Begin
      BackupManagerObj.database := lbBackupAll.Items[i];
      BackupManagerObj.Active := True;
      If BackupManagerObj.DBVersion > '' Then Begin 
        lbBackupAll.ItemIndex := i;
        execBackup('');
        Sleep(1000);
      End;
    End;
    lbBackupAll.Visible := False;
  End Else;
End;

Procedure TBackupManagerGUI.btnCreateDBClick(Sender: TObject);
Var 
  resultStr: String;
  Procedure AdjustGlobalRefAndID;
  Var 
    slTables: TStringList;
    qry: TMyQuery;
    i: Integer;
    pk: String;
    maxRefId: Cardinal;
    BranchCode: String;
  Begin 
    slTables := TStringList.Create;
    qry := TMyQuery.Create(Nil);
    qry.Options.FlatBuffers := True;
    Try 
      qry.Connection := BackupManagerObj.Connection;
      qry.SQL.Text   := 'SELECT SiteCode FROM tblmsbackendid WHERE BEDefault = "T";';
      qry.Open;
      If qry.RecordCount = 1 Then BranchCode := qry.FieldByName('SiteCode').AsString 
      Else Raise Exception.Create('No Multisite Default Branch in DB');
      BackupManagerObj.Connection.GetTableNames(slTables);
      For i := 0 To slTables.Count - 1 Do Begin 
        qry.SQL.Text := 'SHOW COLUMNS FROM ' + slTables[i];
        qry.Open;
        If qry.Locate('Field', 'GlobalRef', [loCaseInsensitive]) Then Begin 
          qry.SQL.Text := Format('SHOW INDEX FROM %s', [slTables[i]]);
          qry.Open;
          If (qry.RecordCount > 0) And (qry.Locate('Key_name', 'PRIMARY', [])) Then Begin 
            pk := qry.FieldByName('Column_name').AsString;
            qry.SQL.Text := Format('SELECT MAX( CONVERT( MID(GlobalRef, %d), UNSIGNED)) ' + 'as MaxRefID from %s WHERE MID(GlobalRef, 1, %d) = "%s"', [Length(BranchCode) + 1, slTables[i], Length(BranchCode), BranchCode]);
            qry.Open;
            If qry.RecordCount = 1 Then Begin 
              maxRefId := qry.FieldByName('MaxRefId').AsInteger;
              If maxRefId > 0 Then Begin 
                qry.SQL.Text := Format('INSERT HIGH_PRIORITY %s SET %s = %d', [slTables[i], pk, maxRefId]);
                Try 
                  qry.Execute;
                  While qry.Executing Do Begin 
                    Sleep(100);
                    Application.ProcessMessages;
                  End;
                  If qry.RowsAffected = 1 Then Begin 
                    qry.SQL.Text := Format('DELETE FROM %s WHERE %s = %d', [slTables[i], pk, maxRefId]);
                    qry.Execute;
                    While qry.Executing Do Begin 
                      Sleep(100);
                      Application.ProcessMessages;
                    End;
                  End;
                Except 
                  On Exception Do;
                End;
              End;
            End;
          End;
        End;
      End;
    Finally 
      slTables.Free;
    End;
  End;
Begin 
  If BackupManagerObj.DBExists(NewDatabaseName) Then Begin
    MessageDialog.Title := 'Warning';
    MessageDialog.Content := #13#10#9+'OVERWRITE database ' + newDataBaseName;
    MessageDialog.CommonButtons  := [cbYes,cbNo];
    If MessageDialog.Execute <> mrYes Then Exit;
    StatusStart('Dropping Database');
    Try
      BackupManagerObj.Connection.ExecSQL('DROP DATABASE ' + newDataBaseName + ';', []);
    Finally
      StatusStop('Dropped Database', clGreen);
    End;
  End;
  StatusStart('CREATE DATABASE ' + newDatabaseName);
  Try 
    BackupManagerObj.Connection.ExecSQL('CREATE DATABASE ' + newDatabaseName + ';', []);
    BackupManagerObj.Connection.Close;
    BackupManagerObj.Connection.Database := newDatabaseName;
    BackupManagerObj.Connection.Open;
  Finally
    StatusStop('Created Database', clGreen);
  End;
  StatusStart('Restoring ' + newDatabaseName);
  Try 
    resultStr := execRestore(lbNewMultisite.Items[lbNewMultisite.ItemIndex]);
    If resultStr = 'OK' Then AdjustGlobalRefAndID;
  Finally 
    Screen.Cursor := crDefault;
    ShowStatus;
  End;
End;

Procedure TBackupManagerGUI.cbDataBaseDropDown(Sender: TObject);
Var 
  i: Integer;
Begin 
  BackupManagerObj.Init('localhost', '', edDBUserName.Text, edDBPassword.Text, 'C:\mysql\backup');
  If BackupManagerObj.Active Then BackupManagerObj.Connection.GetDatabaseNames(cbDataBase.Items);
  For i := cbDataBase.Items.Count - 1 Downto 0 Do Begin 
    BackupManagerObj.database := cbDataBase.Items[i];
    BackupManagerObj.Active   := True;
    If BackupManagerObj.DBVersion = '' Then cbDataBase.Items.Delete(i);
  End;
End;

Procedure TBackupManagerGUI.cbDataBaseChange(Sender: TObject);
Begin 
  BackupManagerObj.database := cbDataBase.Text;
  BackupManagerObj.Active := True;
  ShowStatus;
End;

Procedure TBackupManagerGUI.edNewDBNameChange(Sender: TObject);
Begin
  ShowStatus;
End;

Procedure TBackupManagerGUI.lbArchiveClick(Sender: TObject);
Begin 
  lbArchive.Selected[lbArchive.ItemIndex] := True;
  ShowStatus;
End;

Procedure TBackupManagerGUI.AutoProcess(Sender: TObject);
Var 
  success: Boolean;
  CallerThreadID: Integer;
  slResult: TStringList;
  Procedure doBackupAll;
  Begin 
    edDBUserName.Visible := False;
    edDBPassword.Visible := False;
    cbDataBase.Visible := False;
    Label1.Visible := False;
    edDBUserName.Text := 'P_One';
    edDBPassword.Text := '1w$p&LD07';
    edDBPasswordExit(Nil);
    Self.Enabled := False;
    If btnBackupAll.Enabled Then btnBackupAll.Click;
  End;

  Function doBackup: Boolean;
  Var 
    archiveFileName: String;
  Begin 
    Result := False;
    Try 
      BackupManagerObj.Init('localhost', ParamStr(2), ParamStr(3), '1w$p&LD07', 'C:\mysql\backup');
      BackupManagerObj.Active := True;
      memLog.Lines.Add('BACKUP ' + ParamStr(2) + ' IN PROGRESS');
      If (ParamCount > 4) And (ParamStr(ParamCount - 1) <> '1w$p&LD07') Then archiveFileName := ParamStr(ParamCount - 1)
      Else archiveFileName := '';
      If BackupManagerObj.Active And (execBackup(archiveFileName) = 'OK') Then Begin
        memLog.Lines.Add('BACKUP ' + ParamStr(2) + ' OK');
        Result := True;
      End Else memLog.Lines.Add('BACKUP ' + ParamStr(2) + ' ERROR !');
    Except 
      On E: Exception Do Begin 
        memLog.Lines.Add('EXCEPTION ' + E.Message + ' in doBackup');
        Exit;
      End;
    End;
  End;

  Function doRemove: Boolean;
  Var 
    archiveFileName: String;
  Begin 
    Result := False;
    Try 
      BackupManagerObj.Init('localhost', ParamStr(2), ParamStr(3), ParamStr(4), 'C:\mysql\backup');
      BackupManagerObj.Active := True;
      memLog.Lines.Add('REMOVE ' + ParamStr(2) + ' IN PROGRESS');
      If ParamCount > 5 Then archiveFileName := ParamStr(5)
      Else archiveFileName := '';
      Remove := True;
      Try
        If BackupManagerObj.Active And (execBackup(archiveFileName) = 'OK') Then Begin
          memLog.Lines.Add('REMOVE ' + ParamStr(2) + ' OK');
          Result := True;
        End Else memLog.Lines.Add('REMOVE ' + ParamStr(2) + ' ERROR !');
      finally
        Remove := False;
      end;
    Except 
      On E: Exception Do Begin 
        memLog.Lines.Add('EXCEPTION ' + E.Message + ' in doBackup');
        Exit;
      End;
    End;
  End;

  Function doRestore: Boolean;
  Begin 
    Result := False;
    Try
      BackupManagerObj.Init('localhost', ParamStr(2), ParamStr(3), ParamStr(4), 'C:\mysql\backup');
      BackupManagerObj.Active := True;
      memLog.Lines.Add('RESTORE ' + ParamStr(2) + ' IN PROGRESS');
      If BackupManagerObj.Active And (execRestore(ParamStr(5)) = 'OK') Then Begin
        memLog.Lines.Add('RESTORE ' + ParamStr(2) + ' OK');
        Result := True;
      End Else memLog.Lines.Add('RESTORE ' + ParamStr(2) + ' ERROR !');
    Except 
      On E: Exception Do Begin 
        memLog.Lines.Add('EXCEPTION ' + E.Message + ' in doRestore');
        Exit;
      End;
    End;
  End;
  Function doClone: Boolean;
  Begin 
    Result := False;
    Try 
      BackupManagerObj.Init('localhost', ParamStr(2), ParamStr(3), ParamStr(4), 'C:\mysql\backup');
      BackupManagerObj.Active := True;
      memLog.Lines.Add('CLONE ' + ParamStr(2) + ' IN PROGRESS');
      If BackupManagerObj.Active And (execCopy(ParamStr(5)) = 'OK') Then Begin
        memLog.Lines.Add('CLONE ' + ParamStr(2) + ' OK');
        Result := True;
      End Else memLog.Lines.Add('CLONE ' + ParamStr(2) + ' ERROR !');
    Except 
      On E: Exception Do Begin{$WARN SYMBOL_PLATFORM OFF} memLog.Lines.Add('EXCEPTION ' + E.Message + ' in doClone ' + String(CmdLine));
        Exit;
      End;
    End;
  End;
  Function doNewDB: Boolean;
  Begin 
    Result := False;
    Try 
      BackupManagerObj.Init('localhost', ParamStr(2), ParamStr(3), ParamStr(4), 'C:\mysql\backup');
      BackupManagerObj.Active := True;
      memLog.Lines.Add('CREATE DB ' + ParamStr(5) + ' IN PROGRESS');
      If BackupManagerObj.Active And (execCopy(ParamStr(5)) = 'OK') Then Begin 
        memLog.Lines.Add('CREATE DB ' + ParamStr(5) + ' OK');
        Result := True;
      End Else memLog.Lines.Add('CREATE DB ' + ParamStr(5) + ' ERROR !');
    Except 
      On E: Exception Do Begin{$WARN SYMBOL_PLATFORM OFF} memLog.Lines.Add('EXCEPTION ' + E.Message + ' in doNewDB ' + String(CmdLine));
        Exit;
      End;
    End;
  End;
  Function doListArchive(sl: TStringList): Boolean;
  Var 
    db: String;
    sltmp: TStringList;
    i, p: Integer;
  Begin 
    db := '*';
    Result := False;
    sltmp := TStringList.Create;
    Try 
      Try 
        memLog.Lines.Add('ListArchive ' + ParamStr(2) + ' IN PROGRESS');
        SetCurrentDir(BACKUPARCHIVE);
        If ParamCount > 2 Then db := ParamStr(2);
        FindInCurrentDir(db + '*_Backup*.zip', sl);
        For i := sl.Count - 1 Downto 0 Do Begin 
          p := Pos('.', sl[i]);
          While (p > 1) And (sl[i][p] <> '_') Do Dec(p);
          If p > 1 Then If Not SameText(db, Copy(sl[i], 1, p - 1)) Then sl.Delete(i);
        End;
        memLog.Lines.Add('ListArchive sl: ' + sl.Text);
        FindInCurrentDir('*STARTMULTISITE.zip', sltmp);
        memLog.Lines.Add('ListArchive sl: ' + sltmp.Text);
        For i := 0 To sltmp.Count - 1 Do sl.Add(sltmp.Strings[i]);
        Result := True;
      Except 
        On E: Exception Do Begin 
          memLog.Lines.Add('EXCEPTION ' + E.Message + ' in doListArchive ' + String(CmdLine));
          Exit;
        End;
      End;
    Finally 
      sltmp.Free;
    End;
  End;
Var 
  t: Cardinal;
Begin 
  slResult := TStringList.Create;
  Screen.Cursor := crHourGlass;
  StatusStart('');
  Try
    CallerThreadID := StrToIntDef(ParamStr(ParamCount), 0);
    Timer1.Enabled := False;
    Application.BringToFront;
    If SameText('BACKUP', ParamStr(1)) Then
      success := doBackup
    Else If SameText('RESTORE', ParamStr(1)) Then
      success := doRestore
    Else If SameText('CLONE', ParamStr(1)) Then
      success := doClone
    Else If SameText('CREATEDB', ParamStr(1)) Then
      success := doNewDB
    Else If SameText('REMOVE', ParamStr(1)) Then
      success := doRemove
    Else If SameText('LISTARCHIVE', ParamStr(1)) Then
      success := doListArchive(slResult)
    Else If SameText('BACKUPALL', ParamStr(1)) Then Begin 
      doBackupall;
      Close;
      Exit;
    End Else success := False;
    If success Then Begin 
      slResult.Insert(0, 'OK ' + ParamStr(1) + ' ' + ParamStr(2));
      If SameText('BACKUP', ParamStr(1)) Then slResult.Insert(1, ArchivePathandFileName);
    End Else Begin 
      slResult.Insert(0, 'Error ' + ParamStr(1) + ' ' + ParamStr(2));
      t := GetTickCount;
      While GetTickCount - 10000 < t Do Application.ProcessMessages;
    End;
    SetCurrentDir(ExtractFilePath(ParamStr(0)));
    slResult.SaveToFile('Result' + IntToStr(CallerThreadID) + '.tmp');
    OnCloseQuery := Nil;
    Close;
  Finally 
    Remove := False;
    slResult.Free;
    Screen.Cursor        := crDefault;
    StatusStop('');
  End;
End;

Procedure TBackupManagerGUI.lbNewMultisiteClick(Sender: TObject);
Begin 
  lbNewMultisite.Selected[lbNewMultisite.ItemIndex] := True;
  ShowStatus;
End;

Procedure TBackupManagerGUI.cbShowAllDBsClick(Sender: TObject);
Begin 
  ShowStatus;
End;

Procedure TBackupManagerGUI.edDBPasswordExit(Sender: TObject);
Begin 
  cbDataBaseDropDown(Nil);
  ShowStatus;
End;

Procedure TBackupManagerGUI.AddMemoLine(Var Msg: TMessage);
Begin 
  LockMEMO.Acquire;
  Try 
    memLog.Lines.BeginUpdate;
    memLog.Lines.Add(BackupManagerObj.MsgStr);
    memLog.Lines.EndUpdate;
  Finally 
    LockMEMO.Release;
  End;
End;

procedure TBackupManagerGUI.StatusStart(const StatusMsg: String; const MsgColour: TColor);
begin
  If StatusMsg<>'' then
    StatusBar.Panels[1].Text := StatusMsg
  else
    StatusBar.Panels[1].Text := 'Idle';

  StatusBar.Panels[2].Progress.Position := 0;
  StatusBar.Panels[2].Enabled := True;
end;

procedure TBackupManagerGUI.StatusStop(const StatusMsg: String; const MsgColour: TColor);
begin
  If StatusMsg<>'' then
    StatusBar.Panels[1].Text := StatusMsg
  else
    StatusBar.Panels[1].Text := 'Idle';
  StatusBar.Panels[2].Progress.Position := 0;
  StatusBar.Panels[2].Enabled := False;
end;

procedure TBackupManagerGUI.ProgressTimerTimer(Sender: TObject);
begin
  If StatusBar.Panels[2].Enabled then begin
    If StatusBar.Panels[2].Progress.Position >= 100 then
      StatusBar.Panels[2].Progress.Position := 0;
    StatusBar.Panels[2].StepIt;
  end;
end;

procedure TBackupManagerGUI.chkExcludePicsClick(Sender: TObject);
  function itemExists(itemtext :String ):Integer;
    var
      ctr:Integer;
  begin
    result := -1;
    for ctr := 0 to  TablesNotToBackup.Items.Count-1 do
      if SameText(TablesNotToBackup.items[ctr] , itemtext) then begin
          result := ctr;
          break;
      end;
  end;
var
  xctr:Integer;
begin
  xctr:= itemExists('tblpartspics');

  if chkExcludePics.checked then begin
    if xctr= -1 then TablesNotToBackup.Items.add('tblpartspics');
  end else begin
    if xctr<> -1 then TablesNotToBackup.Items.Delete(xctr);
  end;
end;

Initialization
  LockMEMO := TCriticalSection.Create;
Finalization 
  LockMEMO.Free;
End.




