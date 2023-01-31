unit DBBackupObj;

interface

uses
  classes, MyAccess,  AbArcTyp, OpProgressObj, LogMessageTypes, LogThreadLib,
  LogThreadBase, sysutils, MyDump, DAScript, AbUtils;

type

   TTimeZoneRec = record
     TimeZone,
     MySQLTimeZone,
     DbTimeZone: double;
     ok: boolean;
   end;

  TDBBackup = class
  private
    FDatabaseName: string;
    FServerName: string;
//    fTableList: TStringList;
    fExcludeList: TStringList;
    FBackupPath: string;
    fBackupArchiveFileName: string;
    fMsg: string;
    fVersion: string;
    CreateDbScriptIdx: integer;
    CreateDbScriptCount: integer;
    fOnProgress: TNotifyEvent;
    fActive: boolean;
    fNextProgTime: TDateTime;
    fOnLog: TOnLogEvent;
    fIncludeTransactionAndReportDataInBackup: boolean;
    fSubOpName, fDetail: string;
    fOnDatabase: TNotifyEvent;
    procedure SendProgress(const aSubOpName, aDetail: string; const aStepNo, aStepCount: int64);
    procedure SetDatabaseName(const Value: string);
    procedure SetServerName(const Value: string);
    function NewConnection: TMyConnection;
    function DoBackup(DropDatabase: boolean = false): boolean;
    function DoRestore(const aArchiveFileName: string; NewDbName: string = ''): boolean;
    function LoadDataIntoDbFromFiles(conn: TMyConnection; FileList: TStringList; TempFileDir: string; BackupType: string = ''): boolean;
    function DoClone(const NewDbName: string; MakeReadOnly: boolean = false; MakeNonERPClone: Boolean = False): boolean;
    function DoOptimise: boolean;
    procedure SetBackupPath(const Value: string);
    function PopulateTableList(list: TStringList; conn: TMyConnection): boolean;
//    function GetCreateSQL(var sqlList: TStringList; conn: TMyConnection): boolean;
//    function BackupTables(conn: TMyConnection; list: TStringList; OutDir: string; FileList: TStringList = nil): boolean;
//    function ZipFiles(const TempDir: string): boolean;
    function UnZipFiles(const aArchiveFile, aTempDir: string; var aCreateScriptName: string; aFileList: TStringList; var BackupType: string): boolean;
    function GetDbVersion(conn: TMyConnection): string;
    function DropDbIfExists(const aDatabaseName: string; conn: TMyConnection): boolean;
    function CreateDatabase(const aDatabaseName: string; conn: TMyConnection; CreateScriptName: string = ''): boolean;
    function GetTempDir: string;
    procedure CreateDbScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
    procedure DoExtractArchiveProgress(Sender: TObject; Progress: Byte; var Abort: Boolean);
    procedure DoReadArchiveProgress(Sender: TObject; Progress: Byte; var Abort: Boolean);
    procedure DoOnProcessItemFailure(Sender : TObject;
                                    Item : TAbArchiveItem;
                                    ProcessType : TAbProcessType;
                                    ErrorClass : TAbErrorClass;
                                    ErrorCode : Integer);
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    procedure DoDumpOnError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    procedure SetIncludeTransactionAndReportDataInBackup(const Value: boolean);
//    procedure BackupProgressEvent(Sender: TObject; ObjectName: string; ObjectNum: integer; ObjectCount: integer; Percent: integer);
//    procedure RestoreProgressEvent(Sender: TObject; Percent: integer);
    procedure CompressionProgressEvent(Sender: TObject; const Value, MaxValue: Int64);
    function Is64BitMySQL(Conn: TMyConnection): boolean;
    function ExtractDbNameFromArchiveName(aName: string): string;
    function DomakeReadonly(conn: TMyConnection; const NewDbName: string;MakeReadOnly: boolean): Boolean;
    function DoMakeNonERPClone(conn: TMyConnection; const NewDbName: string;MakeNonERPClone: boolean): Boolean;
    procedure Showprogress(Sender: TObject; var SQL: String; var Omit: Boolean);
    procedure IgnorencontinueOnERPScriptError(Sender: TObject; E: Exception;
      SQL: String; var Action: TErrorAction);

  public
    Progress: TOperationProgress;
    constructor Create;
    destructor Destroy; override;
    property ServerName: string read FServerName write SetServerName;
    property BackupPath: string read FBackupPath write SetBackupPath;
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property OnDatabase: TNotifyEvent read fOnDatabase write fOnDatabase;

//    property TableList: TStringList read fTableList;
    property ExcludeList: TStringList read fExcludeList;
    function Backup(FinalOperation: boolean = True): Boolean;
    function Remove: boolean;
    function DoRemovedb(conn: TMyConnection): Boolean;
    function Restore(const aArchiveFileName: string; NewDbName: string = ''): boolean;
    function Optimise: boolean;
    function Clone(const NewDbName: string; MakeReadOnly: boolean = false; MakeNonERPClone: Boolean = False): boolean;
    function DbExists(const aDatabaseName: string): boolean;
    property OnProgress: TNotifyEvent read fOnProgress write fOnProgress;
    function ArchiveList: string;
    function DatabaseList(erpOnly: boolean = true): string;
    property ResultMessage: string read fMsg;
    function DatabaseVersion: string;
    property BackupArchiveFileName: string read fBackupArchiveFileName write fBackupArchiveFileName;
    property Active: boolean read fActive write fActive;
    procedure CheckAndAdjustTimeZone;
    function GetTimeZoneInfo: TTimeZoneRec;
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    class function CleanupTempFiles: boolean;
    property IncludeTransactionAndReportDataInBackup: boolean read fIncludeTransactionAndReportDataInBackup
      write SetIncludeTransactionAndReportDataInBackup;
  end;

implementation


{ NOTE: Leave this commented out, new backup uses SQL inserts and this is
        slower than writing the tables to file! }
//{$DEFINE NewBackup}

uses
  windows, DbConst, AbZipper, AbZipKit, InstallConst,
  AbBrowse, myscript, Math, IdGlobalProtocols, Types, IOUtils, Db,
  AppRunUtils, shellapi, SystemLib, DbBackupUtils, JclCompression,
  MySqlBackupObj, MySQLUtils, StrUtils;

const
  OneMegaByte = 1024 * 1024;
  Max_Archive_Size = OneMegaByte * 512;
  Max_File_Size =    OneMegaByte * 256;

function GetModuleName: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

Procedure DeleteFiles(Const sPath, sMask: string);
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
        SysUtils.DeleteFile(sPath + sFile);
      End;
      Found := FindNext(SearchRec);
    End;
  Finally
    SysUtils.FindClose(SearchRec);
  End;
End;

function StripFileNo(s: string): string;
var
  x: integer;
begin
  x:= Pos('.',s);
  if x > 0 then
    result := Copy(s,1,x-1)
  else
    result := s;
end;

{ TDBBackup }

function TDBBackup.Backup(FinalOperation: boolean = true): boolean;
begin
  Progress.Clear;
  Progress.OperationName := 'Backing up "' + Self.FDatabaseName + '"';
  Result := doBackup;
  if Result then begin
    if FinalOperation then
      SendProgress('Done', '', 1, 1)
    else
      SendProgress('Backup Complete', '', 1, 1); { not "Done" .. somting else to follow eg restore }
  end
  else
    SendProgress('Error', fMsg, 1, 1);
end;

//procedure TDBBackup.BackupProgressEvent(Sender: TObject; ObjectName: string;
//  ObjectNum, ObjectCount, Percent: integer);
//begin
//  SendProgress('Backing up tables',ObjectName,ObjectNum, ObjectCount);
//end;

function TDBBackup.Remove: boolean;
begin
  Progress.Clear;
  Progress.OperationName:= 'Removing "' + self.FDatabaseName + '"';
  result:= doBackup(true);
  if result then
    SendProgress('Done','',1,1)
  else
    SendProgress('Error',fMsg,1,1);
end;


//function TDBBackup.BackupTables(conn: TMyConnection; list: TStringList;
//  OutDir: string; FileList: TStringList = nil): boolean;
//var
//  x: integer;
//  qry, qryBigTables: TMyQuery;
//  scr: TMyScript;
//  UnixOutDir: string;
//  fileNo: integer;
//  recCount: integer;
//  IdCol: string;
//  MaxId: integer;
//  fileSize: Int64;
//  chunkSize: integer;
//  chunkCount: integer;
//  chunkFirst, chunkLast: integer;
//  fileName, fileNameUnix: string;
//  dump: TMyDump;
//  done: boolean;
//  estChunks: integer;
//
//  function FileExt(aNo: integer): string;
//  begin
//    result:= IntToStr(aNo);
//    while Length(result) < 6 do
//      result := '0' + result;
//    result := '.' + result;
//  end;
//
//begin
//  if list.Count > 0 then
//    SendProgress('Backing up tables',list[0],1,list.Count);
//  result:= true;
//  if not Active then exit;
//  try
//    UnixOutDir:= StringReplace(OutDir,'\','/',[rfReplaceAll]);
//    qry := TMyQuery.Create(nil);
//    qryBigTables := TMyQuery.Create(nil);
//    dump := TMyDump.Create(nil);
//    scr:= TMyScript.Create(nil);
//    try
//      qry.Connection:= conn;
//      scr.Connection := conn;
//      scr.SQL.Add('FLUSH TABLES;');
//      scr.SQL.Add('lock tables');
//      for x := 0 to list.Count -1 do begin
//        if x > 0 then
//          scr.SQL.Add(',' + list[x] + ' read')
//        else
//          scr.SQL.Add(list[x] + ' read')
//      end;
//      scr.SQL.Add(';');
//      scr.Execute;
//      try
//        qryBigTables.Connection:= conn;
//        dump.Connection := conn;
//        dump.Options.AddLock := false;
//        dump.Options.DisableKeys := false;
//        dump.Options.HexBlob := true; //false;
//        dump.Options.UseExtSyntax := true;
//        dump.Options.UseDelayedIns := false;
//        dump.Options.InsertType := itInsert;
//        dump.Options.GenerateHeader := false;
//        dump.Options.AddDrop := false;
//        dump.Options.QuoteNames := true;
//        dump.Options.CompleteInsert := false;
//        dump.Objects := [doData];
//
//        { NOTE: the following sql only gives a very approximate size for the
//          output file for the larger tables }
//        qryBigTables.SQL.Add('select TABLE_NAME, ');
//        qryBigTables.SQL.Add('round((data_length / 1024 / 1024 / :MbPerChunk),0) as "ChunkCount",');
//        qryBigTables.SQL.Add('round(table_rows / (data_length / 1024 / 1024 / :MbPerChunk),0) as "ChunkSize"');
//        qryBigTables.SQL.Add('from information_schema.TABLES');
//        qryBigTables.SQL.Add('where table_schema = ' + QuotedStr(conn.Database));
//        qryBigTables.SQL.Add('and TABLE_TYPE = "BASE TABLE"');
////        qryBigTables.SQL.Add('and round((data_length / 1024 / 1024 / :MbPerChunk),0) > 1');
//        qryBigTables.ParamByName('MbPerChunk').AsInteger := Trunc(Max_File_Size / OneMegabyte);
//        qryBigTables.Open;
//        for x:= 0 to list.Count -1 do begin
//          if not Active then exit;
//          if x > 0 then
//            SendProgress('Backing up tables',list[x],x+1,list.Count);
//          qry.SQL.Text:= 'select Count(*) as count,';
//          qry.SQL.Add('(SELECT COLUMN_NAME FROM information_schema.columns WHERE table_schema = "'+Conn.Database+'" AND table_name = "'+list[x]+'" and extra = "auto_increment") as IdCol,');
//          qry.SQL.Add('(SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = "'+Conn.Database+'" AND TABLE_NAME = "'+list[x]+'") as MaxId');
//
//          qry.SQL.Add('from ' + list[x]);
//          qry.Open;
//          recCount := qry.FieldByName('count').AsInteger;
//          IdCol := qry.FieldByName('IdCol').AsString;
//          MaxId := qry.FieldByName('MaxId').AsInteger;
//          qry.Close;
//
//          if recCount > 0 then begin
//            chunkCount := 0;
//            chunkSize := recCount;
//            if qryBigTables.Locate('TABLE_NAME',list[x],[loCaseInsensitive]) then begin
//              chunkCount := qryBigTables.FieldByName('ChunkCount').AsInteger;
//              chunkSize := qryBigTables.FieldByName('ChunkSize').AsInteger;
//            end;
//            if chunkCount = 0 then begin
//              chunkCount := 1;
//              chunkSize := recCount;
//            end;
//
//            repeat
//              {$IFDEF NewBackup}
//              fileNo := 0;
//              { new dump backup }
//              if chunkCount = 1 then begin
//                { dump whole table .. }
//                SendProgress('Backing up tables',list[x],x+1,list.Count);
//                fileName := OutDir + list[x] + FileExt(FileNo);
//                dump.TableNames := list[x];
//                dump.BackupToFile(fileName);
//                if Assigned(fileList) then
//                  fileList.Add(list[x] + FileExt(FileNo));
//                done := true;
//              end
//              else begin
//                { split up table }
//                chunkFirst := 1;
//                chunkLast := chunkFirst + chunkSize;
//                while chunkFirst <= MaxId  do begin
//                  SendProgress('Backing up tables (chunk ' + IntToStr(fileNo + 1) + ' of approx ' + IntToStr(chunkCount) + ')',list[x],x+1,list.Count);
//                  fileName := OutDir + list[x] + FileExt(FileNo);
//                  dump.BackupToFile(fileName,'select * from ' + list[x] + ' where  ' + IdCol + ' >= ' + IntToStr(chunkFirst) + ' and ' + IdCol + ' <= ' + IntToStr(chunkLast));
//                  if Assigned(fileList) then
//                    fileList.Add(list[x] + FileExt(FileNo));
//                  fileSize := FileSizeByName(fileName);
//                  if (fileSize > Max_File_Size) and (chunkSize > 1) then begin
//                    { delete last chunk }
//                    Log('Chunks size to large, reducing ..',ltDetail);
//                    Log('File Size: ' +IntToStr(fileSize) + ' Max File Size: ' + IntToStr(Max_File_Size),ltDetail);
//                    Log('Initial chunk size: ' + IntToStr(chunkSize) + ' Estimated chunkes: ' + IntToStr(estChunks),ltDetail);
//                    fileName := OutDir + list[x] + FileExt(FileNo);
//                    if FileExists(fileName) then begin
//                      DeleteFile(fileName);
//                      if Assigned(fileList) then
//                        fileList.Delete(fileList.IndexOf(list[x] + FileExt(FileNo)));
//                    end;
//                    { smaller chunks }
//
//                    { adjust my percentage diff less an extra 5% }
//                    chunkSize := Trunc(chunkSize * (Max_File_Size / fileSize) * 0.95);
//
//
//                    if chunkSize < 1 then
//                      chunkSize := 1;
//                    chunkLast := chunkFirst + chunkSize;
//                    estChunks := FileNo + 1 + Round((MaxId - chunkFirst) / chunkSize);
//                    Log('New chunk size: ' + IntToStr(chunkSize) + ' Estimated chunkes: ' + IntToStr(estChunks),ltDetail);
//                  end
//                  else begin
//                    FileNo := FileNo + 1;
//                    chunkFirst := chunkLast + 1;
//                    chunkLast := chunkFirst + chunkSize;
//                  end;
//                end;
//                done := true;
//              end;
//              {$Else}
//
//              { write to file backup }
//              fileNo := 0;
//              if chunkCount = 1 then begin
//                SendProgress('Backing up tables',list[x],x+1,list.Count);
//                fileNameUnix := UnixOutDir + list[x] + FileExt(fileNo);
//                fileName := OutDir + list[x] + FileExt(fileNo);
//                qry.SQL.Text:= 'select * from ' + list[x];
//                qry.SQL.Add('into outfile ' + QuotedStr(fileNameUnix));
//                qry.Execute;
//                if Assigned(fileList) then
//                  fileList.Add(list[x] + FileExt(fileNo));
//                done := true;
//              end
//              else begin
//                { split up table }
//                chunkFirst := 1;
//                chunkLast := chunkFirst + chunkSize;
//                estChunks := Round(MaxId / chunkSize);
//                while chunkFirst <= MaxId  do begin
//                  SendProgress('Backing up tables (chunk ' + IntToStr(fileNo + 1) + ' of approx ' + IntToStr(estChunks) + ')',list[x],x+1,list.Count);
//                  fileNameUnix := UnixOutDir + list[x] + FileExt(fileNo);
//                  fileName := OutDir + list[x] + FileExt(fileNo);
//                  qry.SQL.Text:= 'select * from ' + list[x];
//                  qry.SQL.Add(' where  ' + IdCol + ' >= ' + IntToStr(chunkFirst) + ' and ' + IdCol + ' <= ' + IntToStr(chunkLast));
//                  qry.SQL.Add('into outfile ' + QuotedStr(fileNameUnix));
//                  qry.Execute;
//                  if Assigned(fileList) then
//                    fileList.Add(list[x] + FileExt(fileNo));
//                  fileSize := FileSizeByName(fileName);
//                  if (fileSize > Max_File_Size) and (chunkSize > 1) then begin
//                    { delete last chunk }
//                    Log('Chunks size to large, reducing ..',ltDetail);
//                    Log('File Size: ' +IntToStr(fileSize) + ' Max File Size: ' + IntToStr(Max_File_Size),ltDetail);
//                    Log('Initial chunk size: ' + IntToStr(chunkSize) + ' Estimated chunkes: ' + IntToStr(estChunks),ltDetail);
//                    fileName := OutDir + list[x] + FileExt(FileNo);
//                    if FileExists(fileName) then begin
//                      SysUtils.DeleteFile(fileName);
//                      if Assigned(fileList) then
//                        fileList.Delete(fileList.IndexOf(list[x] + FileExt(FileNo)));
//                    end;
//                    { smaller chunks }
//
//                    { adjust my percentage diff less an extra 5% }
//                    chunkSize := Trunc(chunkSize * (Max_File_Size / fileSize) * 0.95);
//
//
//                    if chunkSize < 1 then
//                      chunkSize := 1;
//                    chunkLast := chunkFirst + chunkSize;
//                    estChunks := FileNo + 1 + Round((MaxId - chunkFirst) / chunkSize);
//                    Log('New chunk size: ' + IntToStr(chunkSize) + ' Estimated chunkes: ' + IntToStr(estChunks),ltDetail);
//                  end
//                  else begin
//                    FileNo := FileNo + 1;
//                    chunkFirst := chunkLast + 1;
//                    chunkLast := chunkFirst + chunkSize;
//                  end;
//                end;
//                done := true;
//              end;
//
//              {$ENDIF}
//
//            until done;
//          end
//          else begin
//  //          Logger.Log('No data in table ' + IntToStr(x + 1) + ' of ' + IntToStr(list.Count) + ' ' + List[x]);
//          end;
//
//        end; { table list loop }
//      finally
//        qry.SQL.Text := 'UNLOCK TABLES';
//        qry.Execute;
//      end;
//    finally
//      qry.Free;
//      qryBigTables.Free;
//      dump.Free;
//      scr.Free;
//    end;
//  except
//    on e: exception do begin
//      result:= false;
//      fmsg:= 'Failed while backing up tables for database "' + conn.Database + '" with error: ' + e.Message;
//    end;
//  end;
//end;

procedure TDBBackup.CheckAndAdjustTimeZone;
var
  Conn: TMyConnection;
  cmd: TMyCommand;
  qry: TMyQuery;
  adjTime: double;
  sl: TStringList;
  x: integer;
  tzRec: TTimeZoneRec;
begin
  tzRec := self.GetTimeZoneInfo;
  if not tzRec.ok then
    exit;
  if not SameValue(tzRec.TimeZone, tzRec.MySQLTimeZone, 0.006) then begin
    { Computer and MySQL time zones do not match }
    exit;
  end;
  if not SameValue(tzRec.TimeZone, tzRec.DbTimeZone, 0.006) then begin
    { need to update the database }

    Conn := self.NewConnection;
    cmd := TMyCommand.Create(nil);
    qry := TMyQuery.Create(nil);
    try
      cmd.Connection := Conn;
      qry.Connection := Conn;
      adjTime := tzRec.TimeZone - tzRec.DbTimeZone;
      if not Math.IsZero(adjTime,0.0007) then begin
        sl:= TStringList.Create;
        try
          Conn.GetTableNames(sl);
           for x := 0 to sl.Count -1 do begin
             SendProgress('Changing time zone',sl[x],x+1,sl.Count);
             { ony update tables that contain this field .. }
             qry.SQL.Text := 'describe ' + sl[x] + ' msTimeStamp';
             qry.Open;
             try
               if not qry.IsEmpty then begin
                 { .. and skip VIEWS .. }
                 qry.Close;
                 qry.SQL.Text := 'show full tables like ' + QuotedStr(sl[x]);
                 qry.Open;
                 if not SameText(qry.FieldByName('Table_type').AsString,'VIEW') then begin
                   if adjTime >= 0 then
                     cmd.SQL.Text := 'update ' + sl[x] + ' set msTimeStamp = AddTime(msTimeStamp,"' + FormatDateTime('hh:nn',adjTime) + '")'
                   else
                     cmd.SQL.Text := 'update ' + sl[x] + ' set msTimeStamp = SubTime(msTimeStamp,"' + FormatDateTime('hh:nn',Abs(adjTime)) + '")';
                   try
                     cmd.Execute;
                   except
                     on e: exception do begin
                     end;
                   end;
                 end;
               end;
             finally
               qry.Close;
             end;
          end;
        finally
          sl.Free;
        end;
        cmd.SQL.Text := 'update tblUpdateDetails set TimeZone = Time_To_Sec(TimeDiff(current_timestamp(),utc_timestamp())) / (24*60*60)';
        cmd.Execute;
      end;
    finally
      cmd.Free;
      qry.Free;
      Conn.Free;
    end;
    SendProgress('Changing time zone','Done',1,1);
  end;
end;

class function TDBBackup.CleanupTempFiles: boolean;
var
  tempPath: string;
  sr : TSearchRec;
  sl: TStringList;
  x: integer;
begin
  result := false;
  tempPath := ExtractFilePath(GetModuleName) + 'temp_backup_files\';
  sl := TStringList.Create;
  try
    try
      if FindFirst(IncludeTrailingPathDelimiter(tempPath) + '*.*', faDirectory, sr) < 0 then
        Exit
      else
       repeat
{$Warnings Off}
         if ((sr.Attr and faDirectory <> 0) AND (sr.Name <> '.') AND (sr.Name <> '..')) then
           if (FileDateToDateTime(sr.Time) < (now -1)) then
             sl.Add(IncludeTrailingPathDelimiter(tempPath) + sr.Name) ;
{$Warnings On}
       until FindNext(sr) <> 0;
    finally
      SysUtils.FindClose(sr) ;
    end;

    for x := 0 to sl.Count-1 do begin
      result := true;
      DeleteFiles(sl[x] + '\', '*.*');
      RemoveDir(sl[x]);
    end;

  finally
    sl.Free;
  end;

end;

function TDBBackup.Clone(const NewDbName: string; MakeReadOnly: boolean = false; MakeNonERPClone: Boolean = False): boolean;
begin
  Progress.Clear;
  Progress.OperationName:= 'Cloning "' + Self.FDatabaseName + '" to "' + NewDbName + '"';
  Result := doClone(NewDbName, MakeReadOnly, MakeNonERPClone);
  if Result then
    SendProgress('Done', '', 1, 1)
  else
    SendProgress('Error', fMsg, 1, 1);
end;

procedure TDBBackup.CompressionProgressEvent(Sender: TObject; const Value,
  MaxValue: Int64);
begin
  SendProgress(fSubOpName,fDetail,Value,MaxValue);
end;

constructor TDBBackup.Create;
begin
//  fIncludeTransactionAndReportDataInBackup := true;
  fActive:= true;
  Progress:= TOperationProgress.Create;
//  fTableList:= TStringList.Create;
  fExcludeList:= TStringList.Create;
//  fExcludeList.CommaText:= 'tmp_*';
  IncludeTransactionAndReportDataInBackup := true;
  fBackupArchiveFileName:= '';
  FBackupPath:= ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR;
  ForceDirectories(FBackupPath);
  FServerName:= '127.0.0.1';
end;

function TDBBackup.CreateDatabase(const aDatabaseName: string;
  conn: TMyConnection; CreateScriptName: string = ''): boolean;
var
  cmd: TMyCommand;
  script: TMyScript;
begin
  SendProgress('Creating database structure','Preparing',1,1);
  result:= true;
  if not Active then exit;

  try
    cmd:= TMyCommand.Create(nil);
    try
      cmd.Connection:= conn;
      cmd.SQL.Text:= 'CREATE DATABASE ' + aDatabaseName + ';';
      cmd.Execute;
    finally
      cmd.Free;
    end;

    if CreateScriptName <> '' then begin
      conn.Disconnect;
      conn.Database:= aDatabaseName;
      conn.Connect;
      script:= TMyScript.Create(nil);
      try
        script.Connection:= conn;
        script.BeforeExecute:= CreateDbScriptBeforeExecute;
        script.SQL.LoadFromFile(CreateScriptName);
        CreateDbScriptIdx:= 0;
        CreateDbScriptCount:= script.Statements.Count;
        script.Execute;
      finally
        script.Free;
      end;
    end;
  except
    on e: exception do begin
      fmsg:= 'Failed to create database "' + aDatabaseName + '" with error: ' + e.Message;
    end;
  end;
end;

procedure TDBBackup.CreateDbScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  Inc(CreateDbScriptIdx);
  SendProgress('Creating database structure','Creating tables',CreateDbScriptIdx,CreateDbScriptCount);
  if not Active then begin
    Omit := true;
    TMyScript(Sender).BreakExec;
  end;
end;

function TDBBackup.DbExists(const aDatabaseName: string): boolean;
var
  conn: TMyConnection;
  sl: TStringList;
begin
  conn:= self.NewConnection;
  sl:= TStringList.Create;
  try
    conn.Database:= MYSQL_DATABASE;
    conn.Connect;
    conn.GetDatabaseNames(sl);
    result:= sl.IndexOf(aDatabaseName) > -1;
  finally
    conn.Free;
    sl.Free;
  end;
end;

destructor TDBBackup.Destroy;
begin
//  fTableList.Free;
  fExcludeList.Free;
  Progress.Free;
  inherited;
end;

procedure TDBBackup.DoReadArchiveProgress(Sender: TObject; Progress: Byte;
  var Abort: Boolean);
begin
  SendProgress('Opening archive file','',Progress,100);
end;

procedure TDBBackup.DoExtractArchiveProgress(Sender: TObject;
  Progress: Byte; var Abort: Boolean);
begin
  SendProgress('Extracting data from archive','',Progress,100);
end;

procedure TDBBackup.DoOnProcessItemFailure(Sender: TObject;
  Item: TAbArchiveItem; ProcessType: TAbProcessType; ErrorClass: TAbErrorClass;
  ErrorCode: Integer);
begin
  raise Exception.Create('Error extracting item from zip file: ' + TAbZipKit(Sender).FileName + ' for item: ' + Item.DiskFileName);
end;

function TDBBackup.DoOptimise: boolean;
var
  conn: TMyConnection;
  qry: TMyQuery;
  tblList: TStringList;
  x: integer;
begin
  SendProgress('Preparing','',1,1);
  result:= true;
  if not Active then exit;
  try
    conn:= NewConnection;
    qry:= TMyQuery.Create(nil);
    try
      conn.Connect;
      qry.Connection:= conn;
      try
        tblList:= TStringList.Create;
        try
//          if fTableList.Count > 0 then
//            tblList.Assign(fTableList)
//          else begin
            if not PopulateTableList(tblList,conn) then begin
              result:= false;
              exit;
            end;
//          end;

          for x:= 0 to tblList.Count -1 do begin
            if not Active then exit;
            SendProgress('Optimising tables',tblList[x],x+1,tblList.Count);
            qry.SQL.Text:= 'REPAIR TABLE `' + tblList[x] + '`;';
            qry.Execute;
          end;

        finally
          tblList.Free;
        end;

        conn.Disconnect;
      finally
        qry.Free;
        Conn.Free;
      end;
    finally
    end;
  except
    on e: exception do begin
      result:= false;
      fmsg:= 'Failed to optimise database "' + DatabaseName + '" with error: ' + e.Message;
    end;
  end;
end;

function TDBBackup.DoBackup(DropDatabase: boolean = false): boolean;
var
  conn: TMyConnection;
  qry: TMyQuery;
  TempDir: string;
//  sl, tblList: TStringList;
//  dbName: string;
//  Is64BitMySQL: boolean;
//  dump: TMyDump;
  backupFileName: string;
  archiveclass: TJclCompressArchiveClass;
  archive: TJclCompressArchive;
  MySqlBackup: TMySqlBackup;
  dt: TDateTime;
//  archive: TJclPpmdDecompressArchive;
begin
  Result := true;
  dt := Now;
  backupFileName := '';
  SendProgress('Preparing','',1,1);
  if not Active then Exit;
  try
    tempDir := GetTempDir;
    conn := NewConnection;

    qry := TMyQuery.Create(nil);
    try
      conn.Connect;
      qry.Connection := conn;

      fVersion := self.GetDbVersion(conn);
      qry.SQL.Text := 'FLUSH TABLES';
      qry.Execute;

      backupFileName := TDbBackupUtils.AddBackupNameSuffix(FBackupPath + self.DatabaseName,fVersion) + '.sql';

      MySqlBackup := TMySqlBackup.Create(ServerName);
      try
        MySqlBackup.OnSendProgress := SendProgress;
        MySqlBackup.OnLog := Log;
        if not MySqlBackup.BackupDb(conn.Database, backupFileName) then begin
          Result := false;
          Exit;
        end;
      finally
        MySqlBackup.Free;
      end;

(*

//      if Is64BitMySQL(Conn) then begin
        { 64 Bit MySQL Version }
        dump := TMyDump.Create(nil);
        try
//          qry.SQL.Add('lock tables');
//          qry.Execute;
          try
            dump.Connection := conn;
            dump.OnError := DoDumpOnError;
            dump.OnBackupProgress := BackupProgressEvent;
            dump.Options.AddLock := false;
            dump.Options.DisableKeys := false;
            dump.Options.HexBlob := true;
            dump.Options.UseExtSyntax := true;
            dump.Options.UseDelayedIns := false;
            dump.Options.InsertType := itInsert;
            dump.Options.GenerateHeader := false;
            dump.Options.AddDrop := false;
            dump.Options.QuoteNames := true;
            dump.Options.CompleteInsert := false;
//            dump.Options.CommitBatchSize := 20;
            dump.Options.CommitBatchSize := 100;
            dump.Options.DisableKeys := true;
            dump.Objects := [doTables, doViews, doData];
            backupFileName := TDbBackupUtils.AddBackupNameSuffix(FBackupPath + self.DatabaseName,fVersion) + '.sql';
            dump.BackupToFile(backupFileName);
          finally
//            qry.SQL.Add('unlock tables');
//            qry.Execute;
          end;
          { now zip it up .. }

*)
          self.fBackupArchiveFileName := ChangeFileExt(backupFileName,'.7z');
          fSubOpName := 'Adding data to Archive';
          fDetail := '';
          archiveclass := TJcl7zCompressArchive;
          archive := archiveclass.Create(fBackupArchiveFileName);
          try
            archive.OnProgress := CompressionProgressEvent;
            archive.Password := DbConst.SYSDB_PASS;
            TJcl7zCompressArchive(archive).SetCompressionLevel(3);
            archive.AddFile(ExtractFileName(backupFileName),backupFileName);
            archive.Compress;
          finally
            archive.Free;
          end;
          SendProgress('Backup','Done',1,1);

(*
        finally
          dump.Free;
        end;
*)

//      end
(*
      else begin
        { 32 Bit MySQL Version }
        if not ForceDirectories(tempDir) then begin
          result:= false;
          fmsg:= 'Failed to backup database "' + conn.Database +
            '", unable to create tempory directory: "' + tempDir + '"';
          exit;
        end;


        DeleteFiles(tempDir, '*.*');
        sl:= TStringList.Create;
        try
          if self.GetCreateSQL(sl,conn) then begin
            sl.SaveToFile(tempDir + conn.Database + '_DropCreateTables.sql');
          end
          else begin
            result:= false;
            exit;
          end;
        finally
          sl.Free;
        end;
        if not Active then
          exit;
        tblList:= TStringList.Create;
        try
//          if fTableList.Count > 0 then
//            tblList.Assign(fTableList)
//          else begin
            if not PopulateTableList(tblList,conn) then begin
              result:= false;
              exit;
            end;
//          end;
          if not self.BackupTables(conn,tblList,TempDir) then begin
            result:= false;
            exit;
          end;

          if not ZipFiles(TempDir) then begin
            result:= false;
            exit;
          end;

        finally
          tblList.Free;
        end;
        DeleteFiles(tempDir, '*.*');
        RemoveDir(TempDir);
      end;
*)
      (*if DropDatabase then begin
        dbName:= conn.Database;
        conn.Disconnect;
        conn.Database:= MYSQL_DATABASE;
        conn.Connect;
        if not DropDbIfExists(dbName,conn) then begin
          result:= false;
          // exit;
        end;
      end;*)
      if DropDatabase then begin
        REsult := DoRemovedb(Conn);
      end;

      conn.Disconnect;
    finally
      qry.Free;
      Conn.Free;
      if backupFileName <> '' then
        SysUtils.DeleteFile(backupFileName);
      Log('Backup time ' + FormatDateTime('hh:nn:ss',now-dt),ltInfo);
    end;
  except
    on e: exception do begin
      result:= false;
      fmsg:= 'Failed to backup database "' + DatabaseName + '" with error: ' + e.Message;
    end;
  end;
end;

function TDBBackup.DoRemovedb(conn: TMyConnection):Boolean;
var
  fconn: TMyConnection;
  dt :TDatetime;
begin
  fconn := nil;
  dt:= now;
  try
    try
      if conn = nil then fconn:= NewConnection else fconn := conn;
      if fconn.connected then fconn.Disconnect;
      fconn.Database:= MYSQL_DATABASE;
      fconn.Connect;
      SendProgress('Removing ' + Databasename,'',1,1);
      if not DropDbIfExists(Databasename,fconn) then begin
              result:= false;
              SendProgress('Removing ' + Databasename,'Failed',1,1);
              exit;
      end;
      SendProgress('Removed ' + Databasename,'',1,1);
      REsult := True;
      if fconn <> conn then if fconn.connected then fconn.Disconnect;
    finally
      if fconn <> conn then fconn.Free;
      Log('Remove time ' + FormatDateTime('hh:nn:ss',now-dt),ltInfo);
    end;
  except
    on e: exception do begin
      result:= false;
      fmsg:= 'Failed to backup database "' + DatabaseName + '" with error: ' + e.Message;
    end;
  end;
  if result then
    SendProgress('Done','',1,1)
  else
    SendProgress('Error',fMsg,1,1);
end;
Function TDBBackup.DomakeReadonly(conn: TMyConnection;const NewDbName: string; MakeReadOnly: boolean ):Boolean;
var
  script : TMyScript;
begin
  if not MakeReadOnly then exit;
  script := TMyScript.Create(nil);
  try
    script.Connection := conn;
    script.BeforeExecute := CreateDbScriptBeforeExecute;
    script.SQL.Text := 'Update ' + NewDbName + '.tblemployeeformsaccess Set Access =6;';
    script.Execute;
  finally
    script.Free;
  end;
end;
procedure TDBBackup.IgnorencontinueOnERPScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  Action := eaContinue;
end;
Function TDBBackup.DoMakeNonERPClone(conn: TMyConnection;const NewDbName: string; MakeNonERPClone: boolean):Boolean;
var
  fsNonERPClone_User, fsNonERPClone_Password:String;
  Query : TMyQuery;
  script : TMyScript;
begin
  if not MakeNonERPClone then
    exit;
  SendProgress('Convert To NonERP Database ','',1,1);
  Query := TMyQuery.Create(nil);
  try
    Query.Connection := conn;
    Query.SQL.Text := 'Select fieldvalue from tbldbpreferences where name = "NonERPClone_User"';
    Query.Open;
    fsNonERPClone_User := trim(Query.FieldByName('fieldvalue').AsString);
    if fsNonERPClone_User = '' then
      fsNonERPClone_User := 'TrueERP';
    Query.Close;

    Query.SQL.Text := 'Select fieldvalue from tbldbpreferences where name = "NonERPClone_Password"';
    Query.Open;
    fsNonERPClone_Password := trim(Query.FieldByName('fieldvalue').AsString);
    if fsNonERPClone_Password = '' then
      fsNonERPClone_Password := 'TrueERP';
    Query.Close;

    script := TMyScript.Create(nil);
    try
      script.Connection := conn;
      script.BeforeExecute := CreateDbScriptBeforeExecute;
      script.onError := IgnorencontinueOnERPScriptError;

      {chnage and rename updatedetails and employee access - this is to avoid using the new database in ERP}
      script.SQL.Add('ALTER TABLE  ' + NewDbName + '.tblupdatedetails	DROP COLUMN GlobalRef,	'+
                                                                    ' DROP COLUMN ID,		'+
                                                                    ' DROP COLUMN Current,	'+
                                                                    ' DROP COLUMN Changes,	'+
                                                                    ' DROP COLUMN CreatedDate,	'+
                                                                    ' DROP COLUMN EditedFlag,	'+
                                                                    ' DROP COLUMN msTimeStamp,	'+
                                                                    ' DROP COLUMN msUpdateSiteCode;');
      script.SQL.Add('RENAME table  ' + NewDbName + '.tblupdatedetails TO  '      + NewDbName +'.tblERP_VersionnDetails;');
      script.SQL.Add('RENAME table  ' + NewDbName + '.tblemployeeformsaccess TO  '+ NewDbName +'.tblNonERP_Access;');
      script.SQL.Add('ALTER TABLE  ' + NewDbName + '.tblERP_VersionnDetails	ADD COLUMN DateCreated TIMESTAMP NULL DEFAULT current_TIMESTAMP() ON UPDATE current_TIMESTAMP();');

      {apply new User }
      script.SQL.Add('USE ' + NewDbName + ';');
      script.SQL.Add('DROP PROCEDURE IF EXISTS drop_user_if_exists;');
      script.SQL.Add('DELIMITER $$');
      script.SQL.Add('CREATE PROCEDURE drop_user_if_exists()');
      script.SQL.Add('BEGIN');
      script.SQL.Add('  DECLARE foo BIGINT DEFAULT 0 ;');
      script.SQL.Add('  SELECT COUNT(*) INTO foo');
      script.SQL.Add('   FROM mysql.user');
      script.SQL.Add('      WHERE User = "' + fsNonERPClone_User + '" and Host = "localhost";');
      script.SQL.Add('   IF foo > 0 THEN');
      script.SQL.Add('         DROP USER "' + fsNonERPClone_Password + '"@"localhost" ;');
      script.SQL.Add('  END IF;');
      script.SQL.Add('END ;$$');
      script.SQL.Add('DELIMITER ;');
      script.SQL.Add('CALL drop_user_if_exists() ;');
      script.SQL.Add('DROP PROCEDURE IF EXISTS drop_user_if_exists ;');

      script.SQL.Add('CREATE USER ' + QuotedStr(fsNonERPClone_User) + '@' + QuotedStr('%') +
        ' IDENTIFIED BY ' + QuotedStr(fsNonERPClone_Password) + ';');
      script.SQL.Add('GRANT ALL ON ' + NewDbName + '.* TO ' + QuotedStr(fsNonERPClone_User) + ';');

      script.SQL.Add('Drop table if Exists ' + NewDbName + '.debuginfo;');
      script.SQL.Add('Drop table if Exists ' + NewDbName + '.debuglog;');
      script.SQL.Add('Drop table if Exists ' + NewDbName + '.debuglogdetails;');

      {remove all ERP fix tables}
      Query.Sql.text := 'SHOW TABLES like ''ERPFix_%'';' ;
      Query.Open;
      if Query.recordcount >0 then begin
        Query.First;
        While Query.EOF =False do begin
          script.SQL.Add('Drop table if Exists ' + NewDbName + '.'+Query.fields[0].asString +';');
          Query.Next;
        end;
      end;

      {remove all temp tables}
      Query.Sql.text := 'SHOW TABLES like ''tmp_%'';' ;
      Query.Open;
      if Query.recordcount >0 then begin
        Query.First;
        While Query.EOF =False do begin
          script.SQL.Add('Drop table if Exists ' + NewDbName + '.'+Query.fields[0].asString +';');
          Query.Next;
        end;
      end;

      {remove all temp tables}
      Query.Sql.text := 'SHOW TABLES like ''rpt_%'';' ;
      Query.Open;
      if Query.recordcount >0 then begin
        Query.First;
        While Query.EOF =False do begin
          script.SQL.Add('Drop table if Exists ' + NewDbName + '.'+Query.fields[0].asString +';');
          Query.Next;
        end;
      end;
      script.BeforeExecute := Showprogress;
      script.Execute;
      SendProgress('Server :' + Conn.Server,'',1,1);
      SendProgress('Port :' + inttostr(SERVER_PORT),'',1,1);
      SendProgress('DatabaseName : '+NewDbName,'',1,1);
      SendProgress('UserName : '+fsNonERPClone_User,'',1,1);
      SendProgress('Password : '+fsNonERPClone_Password,'',1,1);
      SendProgress('Check "tblERP_VersionnDetails.Version" for ERP Version and ','',1,1);
      SendProgress('       "tblERP_VersionnDetails.DateCreated" for the date that the database is created','',1,1);


    finally
      script.Free;
    end;
  finally
    Query.Free;
  end;
end;
procedure TDBBackup.Showprogress(Sender: TObject; var SQL: String; var Omit: Boolean);
begin
(*  if (Pos( '/*',sql)>0) and (Pos( '*/',sql)>0) then
      SendProgress( replacestr(replacestr(copy(sql, 1, pos('*/',sql)+2), '/*',''),'*/','') ,'',1,1);*)
end;
function TDBBackup.DoClone(const NewDbName: string; MakeReadOnly: boolean = false; MakeNonERPClone: Boolean = False): boolean;
var
  conn: TMyConnection;
  qry: TMyQuery;
  tempDir: string;
//  sl, tblList, fileList: TStringList;
//  dump: TMyDump;
  MySqlBackup: TMySqlBackup;
  backupFileName: string;
  fVer: string;
  script : TMyScript;
begin
  SendProgress('Preparing', '', 1, 1);
  result := True;
  if not Active then exit;
  try
    tempDir := GetTempDir;
    conn := NewConnection;
    qry := TMyQuery.Create(nil);
    try
      conn.Connect;
      qry.Connection := conn;
      if not ForceDirectories(tempDir) then begin
        Result := false;
        fmsg := 'Failed to clone database "' + NewDbName +
          '", unable to create tempory directory: "' + tempDir + '"';
        Exit;
      end;
      DeleteFiles(tempDir, '*.*');
      if not Active then
        exit;
//      sl:= TStringList.Create;
//      try
//        if self.GetCreateSQL(sl,conn) then begin
//          sl.SaveToFile(tempDir + NewDbName + '_DropCreateTables.sql');
//        end
//        else begin
//          result:= false;
//          exit;
//        end;
//      finally
//        sl.Free;
//      end;
      fVer := Self.GetDbVersion(conn);
      qry.SQL.Text:= 'FLUSH TABLES';
      qry.Execute;
      if not Active then
        Exit;

      backupFileName := TDbBackupUtils.AddBackupNameSuffix(tempDir + self.DatabaseName,fVer) + '.sql';
      MySqlBackup := TMySqlBackup.Create(ServerName);
      try
        MySqlBackup.OnSendProgress := SendProgress;
        MySqlBackup.OnLog := Log;
        if not MySqlBackup.BackupDb(conn.Database,backupFileName) then begin
          Result := false;
          Exit;
        end;
        if not MySqlBackup.RestoreDb(NewDbName,backupFileName) then begin
          Result := false;
          Exit;
        end;
        DoMakeReadonly(conn, NewDBName,MakeReadonly);
        DoMakeNonERPClone(conn, NewDBName,MakeNonERPClone);
        SendProgress('Clone To NonERP Database Complete','',1,1);

      finally
        MySqlBackup.Free;
      end;

(*
      dump := TMyDump.Create(nil);
      try
        dump.Connection := conn;
        dump.OnError := DoDumpOnError;
        dump.OnBackupProgress := BackupProgressEvent;
        dump.Options.AddLock := false;
        dump.Options.DisableKeys := false;
        dump.Options.HexBlob := true;
        dump.Options.UseExtSyntax := true;
        dump.Options.UseDelayedIns := false;
        dump.Options.InsertType := itInsert;
        dump.Options.GenerateHeader := false;
        dump.Options.AddDrop := false;
        dump.Options.QuoteNames := true;
        dump.Options.CompleteInsert := false;
        if conn.Database <> 'erpnewdb' then
          dump.Options.CommitBatchSize := 40;
        dump.Objects := [doTables, doViews, doData];
        backupFileName := TDbBackupUtils.AddBackupNameSuffix(tempDir + self.DatabaseName,fVer) + '.sql';
        dump.BackupToFile(backupFileName);

        if not DropDbIfExists(NewDbName,conn) then begin
          result:= false;
          exit;
        end;
        qry.SQL.Text := 'create database ' + NewDbName;
        qry.Execute;

        conn.Disconnect;
        conn.Database:= NewDbName;
        conn.Connect;

        dump.OnRestoreProgress := RestoreProgressEvent;
        dump.RestoreFromFile(backupFileName);

      finally
        dump.Free;
      end;

*)

//      tblList:= TStringList.Create;
//      fileList := TStringList.Create;
//      try
//        if not PopulateTableList(tblList,conn) then begin
//          result:= false;
//          exit;
//        end;
//        if not self.BackupTables(conn,tblList,TempDir,fileList) then begin
//          result:= false;
//          exit;
//        end;
//
//        if not DropDbIfExists(NewDbName,conn) then begin
//          result:= false;
//          exit;
//        end;
//        if not CreateDatabase(NewDbName,conn,tempDir + NewDbName + '_DropCreateTables.sql') then begin
//          result:= false;
//          exit;
//        end;
//
//        conn.Disconnect;
//        conn.Database:= NewDbName;

//        conn.Connect;
//
//        result := LoadDataIntoDbFromFiles(conn,fileList,tempDir);
//
//      finally
//        tblList.Free;
//        fileList.Free;
//      end;
    finally
      qry.Free;
      Conn.Free;
      DeleteFiles(tempDir, '*.*');
      RemoveDir(tempDir);
    end;
  except
    on e: exception do begin
      Result := false;
      fmsg := 'Failed to clone database "' + NewDbName + '" with error: ' + e.Message;
    end;
  end;
end;

procedure TDBBackup.DoDumpOnError(Sender: TObject; E: Exception; SQL: string;
  var Action: TErrorAction);
begin
  Action := eaContinue;
  Log('Error while restoring: ' + E.Message,ltError);
end;

function TableLockList(ArcFileList: TStringList): string;
var
 sl: TStringList;
 i: integer;
 str: string;
begin
  result := '';
  sl := TStringList.Create;
  try
    sl.Duplicates := dupIgnore;
    sl.Sorted := false;
    sl.CaseSensitive := false;
    for I := 0 to ArcFileList.Count -1 do begin
      str := StripFileNo(ArcFileList[i]);
      if sl.IndexOf(str) < 0 then
        sl.Add(str);
    end;
    for I := 0 to SL.Count -1 do begin
      if I > 0 then result := result + ',';
      result := result + SL[i] + ' WRITE';
    end;
  finally
    sl.Free;
  end;
end;

function TDBBackup.DoRestore(const aArchiveFileName: string; NewDbName: string = ''): boolean;
var
  conn: TMyConnection;
  tempDir, dbName: string;
  CreateScriptName: string;
  ArcFileList: TStringList;
  BackupType: string;
//  dump: TMyDump;
  archiveclass: TJclDecompressArchiveClass;
  archive: TJclDecompressArchive;
  sl: TStringList;
  x: integer;
  MySqlBackup: TMySqlBackup;
  sqlFileName, s: string;
  dt: TDateTime;
begin
  SendProgress('Preparing','',1,1);
  result:= true;
  dt := now;
  if not Active then exit;
  try
    if not FileExists(aArchiveFileName) then begin
      result:= false;
      fmsg:= 'Restore failed, backup file not found: "' + aArchiveFileName + '"';
      exit;
    end;

    conn:= self.NewConnection;
    sl := TStringList.Create;
    try
      conn.Database:= MYSQL_DATABASE;
      conn.Connect;
      if SameText(ExtractFileExt(aArchiveFileName),'.7z') then begin

        if NewDbName <> '' then
          dbName:= NewDbName
        else
          dbName:= ExtractDbNameFromArchiveName(aArchiveFileName);
        if not DropDbIfExists(dbName,conn) then begin
          result:= false;
          exit;
        end;

        { now zip it up .. }
        fSubOpName := 'Extracting data from Archive';
        fDetail := '';
        archiveclass := GetArchiveFormats.FindDecompressFormat(aArchiveFileName);
        if not Assigned(archiveclass) then begin
          result:= false;
          fmsg:= 'Restore failed for file "' + aArchiveFileName +
            '", file format not supported.';
          exit;
        end;
//        if not (archive is TJclSevenZipDecompressArchive) then begin
//          result:= false;
//          fmsg:= 'Restore failed for file "' + aArchiveFileName +
//            '", not a 7Zip format file.';
//          exit;
//        end;

        sqlFileName := '';
        archive := archiveclass.Create(aArchiveFileName);
        try
          archive.OnProgress := CompressionProgressEvent;
          archive.Password := DbConst.SYSDB_PASS;
          archive.ListFiles;
          for x := 0 to archive.ItemCount -1 do begin
            s := ExtractFilePath(aArchiveFileName) + archive.Items[x].PackedName;
            if SameText(ExtractFileExt(s),'.sql') then
              sqlFileName := s;
            sl.Add(s);
          end;
          archive.ExtractAll(ExtractFilePath(aArchiveFileName));
        finally
          archive.Free;
        end;

        if sqlFileName = '' then begin
          result := false;
          fmsg:= 'Restore failed for file "' + aArchiveFileName +
            '", file does not contain a True ERP Backup.';
          exit;
        end;

        MySqlBackup := TMySqlBackup.Create(ServerName);
        try
          MySqlBackup.OnSendProgress := SendProgress;
          MySqlBackup.OnLog := Log;
          if not MySqlBackup.RestoreDb(dbName,sqlFileName) then begin
            result := false;
            exit;
          end;
        finally
          MySqlBackup.Free;
        end;


(*
        conn.ExecSQL('create database ' + dbName,[]);
        conn.Disconnect;
        conn.Database := dbName;
        conn.Connect;

        dump := TMyDump.Create(nil);
        try
          dump.Connection := conn;
          dump.OnError := DoDumpOnError;
          dump.OnRestoreProgress := RestoreProgressEvent;
          dump.Options.AddLock := false;
          dump.Options.DisableKeys := false;
          dump.Options.HexBlob := true;
          dump.Options.UseExtSyntax := true;
          dump.Options.UseDelayedIns := false;
          dump.Options.InsertType := itInsert;
          dump.Options.GenerateHeader := false;
          dump.Options.AddDrop := false;
          dump.Options.QuoteNames := true;
          dump.Options.CompleteInsert := false;
          dump.Objects := [doTables, doViews, doData];
          dump.RestoreFromFile(ChangeFileExt(aArchiveFileName,'.sql'));

        finally
          dump.Free;
        end;
*)

      end
      else begin
        { older multiple zip type backup }
        if Is64BitMySQL(conn) then begin
          { does not work with 64bit MySQL }
          result:= false;
          fmsg:= 'Restore failed for file "' + aArchiveFileName +
            '", file format not supported for 64bit MySQL Server (should be .7z file).';
          exit;
        end;

        tempDir:= GetTempDir;
        if not ForceDirectories(tempDir) then begin
          result:= false;
          fmsg:= 'Restore failed for file "' + aArchiveFileName +
            '", unable to create tempory directory: "' + tempDir + '"';
          exit;
        end;
        try
          ArcFileList:= TStringList.Create;
          try

            DeleteFiles(tempDir, '*.*');
            if not UnZipFiles(aArchiveFileName, tempDir, CreateScriptName, ArcFileList, BackupType) then begin
              result:= false;
              exit;
            end;
            try
              if CreateScriptName = '' then begin
                fmsg:= 'Restore failed for file "' + aArchiveFileName +
                '", database SQL create script not found';
                result:= false;
                exit;
              end;
              if NewDbName <> '' then
                dbName:= NewDbName
              else
                dbName:= Copy(CreateScriptName,1,Pos('_DropCreateTables.sql',CreateScriptName)-1);
              if not DropDbIfExists(dbName,conn) then begin
                result:= false;
                exit;
              end;
              if not CreateDatabase(dbName,conn,tempDir + CreateScriptName) then begin
                result:= false;
                exit;
              end;

              conn.Disconnect;
              conn.Database:= dbName;
              conn.Connect;

              result := LoadDataIntoDbFromFiles(conn,ArcFileList,TempDir,BackupType);

            finally
              DeleteFiles(tempDir, '*.*');
            end;
          finally
            ArcFileList.Free;
          end;
        finally
          RemoveDir(tempDir);
        end;

      end;
    finally
      for x := 0 to sl.Count -1 do
        SysUtils.DeleteFile(sl[x]);
      Conn.Free;
      sl.Free;
      Log('Restor time ' + FormatDateTime('hh:nn:ss',now-dt),ltInfo);
    end;
except
    on e: exception do begin
      result:= false;
      fmsg:= 'Restore failed for file "' + aArchiveFileName + '" with error: ' + e.Message;
    end;
  end;
end;

function TDBBackup.LoadDataIntoDbFromFiles(conn: TMyConnection;
  FileList: TStringList; TempFileDir, BackupType: string): boolean;
var
  cmd: TMyCommand;
  dump: TMyDump;
  UnixTempDir: string;
  tblName: string;
  x: integer;
begin
  result := false;
  cmd:= TMyCommand.Create(nil);
  dump := TMyDump.Create(nil);
  try
    cmd.Connection:= conn;
//    conn.ExecSQL('set character_set_client = "utf8", character_set_connection = "utf8", character_set_results = "utf8"',[]);
    dump.Connection := conn;
    dump.OnError := DoDumpOnError;
    dump.Options.AddLock := false;
    dump.Options.DisableKeys := false;
    dump.Options.HexBlob := true; //false;
    dump.Options.UseExtSyntax := false;
    dump.Options.UseDelayedIns := false;
    dump.Options.InsertType := itInsert;
    dump.Options.GenerateHeader := false;
    dump.Options.AddDrop := false;
    dump.Options.QuoteNames := true;
    dump.Options.CompleteInsert := false;
    dump.Objects := [doData];
    UnixTempDir:= StringReplace(TempFileDir,'\','/',[rfReplaceAll]);
    tblName:= '';
    cmd.SQL.Text := 'FLUSH TABLES';
    cmd.Execute;
    cmd.SQL.Text := 'LOCK TABLES ' + TableLockList(FileList);
    cmd.Execute;
    try
      try
        for x:= 0 to FileList.Count -1 do begin
          if not Active then exit;
          tblName:= StripFileNo(FileList[x]);
          SendProgress('Loading data into tables',tblName,x+1,FileList.Count);
          if BackupType = 'SQLInsert' then begin
            Log('Restoring .. ' + FileList[x],ltDetail);
            dump.RestoreFromFile(TempFileDir + FileList[x]);
          end
          else begin
            cmd.SQL.Text:= 'LOAD DATA INFILE ' + QuotedStr(UnixTempDir + FileList[x]) +
              ' IGNORE INTO TABLE ' + tblName;
            if tblName <> 'tblpassword' then
              cmd.SQL.Add('character set "utf8";')
            else
              cmd.SQL.Add(';');
            cmd.Execute;
          end;
        end;
        result := true;
      except
        on e: exception do begin
          raise Exception.Create(e.ClassName +  ' Error loading table: ' + tblName + ': ' + e.Message);
        end;
      end;
    finally
      cmd.SQL.Text := 'UNLOCK TABLES';
      cmd.Execute;
    end;
  finally
    cmd.Free;
    dump.Free;
  end;

end;



procedure TDBBackup.Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
begin
  if Assigned(fOnLog) then
    fOnLog(msg,LogMessageType);
end;

function TDBBackup.DropDbIfExists(const aDatabaseName: string;
  conn: TMyConnection): boolean;
var
  cmd: TMyCommand;
begin
  SendProgress('Checking/Dropping existing database','',1,2);
  result:= true;
  if not Active then exit;
  try
    cmd:= TMyCommand.Create(nil);
    try
      cmd.Connection:= conn;
      cmd.SQL.Text:= 'DROP DATABASE IF EXISTS `' + aDatabaseName + '`;';
      cmd.Execute;
    finally
      cmd.Free;
    end;
  except
    on e: exception do begin
      result:= false;
      fmsg:= 'Failed while removing database "' + aDatabaseName + '" with error: ' + e.Message;
    end;
  end;
end;

function TDBBackup.ExtractDbNameFromArchiveName(aName: string): string;
var
  x: integer;
begin
  { eg usa_sample_company_15.5.6.0_Backup_2016-07-14_09-55.7z }
  result := ExtractFileName(aName);
  result := Copy(result,1,Pos('backup',Lowercase(result))-1);
  x := Length(result) -1;
//  while CharInSet(result[x],['_','.','0'..'9']) do
  while result[x] <> '_' do
    dec(x);
  result := Copy(result,1,x-1);
end;

//function TDBBackup.GetCreateSQL(var sqlList: TStringList; conn: TMyConnection): boolean;
//var
//  sl: TStringList;
//  x: integer;
//  qry: TMyQuery;
//begin
//  result:= true;
//  if not Active then exit;
//  sqlList.Clear;
//  try
//    sl:= TStringList.Create;
//    qry:= TMyQuery.Create(nil);
//    try
//      qry.Connection:= conn;
//      conn.GetTableNames(sl);
//      if sl.Count > 0 then
//        SendProgress('Reading database structure','',1,sl.Count);
//      for x:= 0 to sl.Count -1 do begin
//        if not Active then exit;
//        if x > 0 then
//          SendProgress('Reading database structure','',x+1,sl.Count);
//        qry.Close;
//        qry.SQL.Text := 'SHOW CREATE TABLE ' + sl[x] + ';';
//        qry.Open;
//        sqlList.Add('DROP ' + qry.Fields[0].FieldName + ' IF EXISTS ' + sl[x] + ';');
//        sqlList.Add(qry.Fields[1].AsString + ';');
//      end;
//    finally
//      sl.Free;
//      qry.Free;
//    end;
//  except
//    on e: exception do begin
//      result:= false;
//      fmsg:= 'Failed to get database creation SQL for "' + conn.Database + '" with error: ' + e.Message;
//    end;
//  end;
//end;

function TDBBackup.GetDbVersion(conn: TMyConnection): string;
var
  qry: TMyQuery;
begin
  Result := '';
  if not Active then exit;
  try
    qry := TMyQuery.Create(nil);
    try
      qry.Connection := conn;
      qry.SQL.Text := 'Show Tables like "tblupdatedetails";';
      qry.Open;
      if qry.IsEmpty then
        Exit;
      qry.Close;
      qry.SQL.Text := 'SELECT Version FROM tblupdatedetails WHERE ID = 1';
      qry.Open;
      Result := qry.FieldByName('Version').AsString;
    finally
      qry.Free;
    end;
  except
  end;
end;

function TDBBackup.GetTempDir: string;
begin
  result:= ExtractFilePath(GetModuleName) + 'temp_backup_files\' + IntToStr(Integer(self)) + '\';
end;

function TDBBackup.GetTimeZoneInfo: TTimeZoneRec;
var
  Conn: TMyConnection;
  qry: TMyQuery;
  TimeZone: TTimeZoneInformation;
begin
  result.ok := true;
  try
    GetTimeZoneInformation(TimeZone);
    result.TimeZone :=  -TimeZone.Bias * (1/24/60);
    Conn:= self.NewConnection;
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection := Conn;
      qry.SQL.Text := 'select Time_To_Sec(TimeDiff(current_timestamp(),utc_timestamp())) / (24*60*60) as TimeZone from Dual';
      qry.Open;
      result.MySQLTimeZone := qry.FieldByName('TimeZone').AsFloat;
      qry.Close;
      qry.SQL.Text := 'select * from tblUpdateDetails';
      qry.Open;
      result.DbTimeZone := qry.FieldByName('TimeZone').AsFloat;
      qry.Close;
    finally
      qry.Free;
      Conn.Free;
    end;
  except
    result.ok := false;
  end;
end;

function TDBBackup.Is64BitMySQL(Conn: TMyConnection): boolean;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := Conn;
    qry.SQL.Text := 'show variables like "version_compile_machine";';
    qry.Open;
    result := SameText(qry.FieldByName('Value').AsString,'x86_64');
    { 32 bit will return ia32 }
  finally
    qry.Free;
  end;
end;

function TDBBackup.NewConnection: TMyConnection;
begin
  result:= TMyConnection.Create(nil);
  result.LoginPrompt:= false;
  result.Port:= SERVER_PORT;
  result.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  result.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
  result.Username:= SYSDB_USER;
  result.Password:= SYSDB_PASS;
  result.Server:= fServerName;
  result.Database:= fDatabaseName;
end;

function TDBBackup.Optimise: boolean;
begin
  Progress.Clear;
  Progress.OperationName:= 'Optimising "' + self.FDatabaseName + '"';
  result:= doOptimise;
  if result then
    SendProgress('Done','',1,1)
  else
    SendProgress('Error',fMsg,1,1);
end;

function TDBBackup.PopulateTableList(list: TStringList; conn: TMyConnection): boolean;
var
  excludeIndex: integer;
  posPartTable, x: Integer;
  partName: string;

  procedure RemoveViews;
  var
    qry: TMyQuery;
    viewIndex: integer;
  begin
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= conn;
      qry.SQL.TEXT := 'Show Full Tables WHERE Table_Type="VIEW";';
      qry.Open;
      while not qry.Eof Do Begin
        viewIndex := list.IndexOf(qry.Fields[0].AsString);
        if viewIndex > 0 then list.Delete(viewIndex);
        qry.Next;
      end;
    finally
      qry.Free;
    end;
  end;

begin
  result:= true;
  if not Active then exit;
  try
    conn.GetTableNames(list);
    RemoveViews;
    for excludeIndex:= 0 to fExcludeList.Count -1 do begin
      posPartTable := Pos('*', fExcludeList[excludeIndex]);
      if posPartTable > 1 then begin
        partName:= Lowercase(Copy(fExcludeList[excludeIndex],1,posPartTable -1));
        for x:= list.Count -1 downto 0 do begin
          if Pos(partName,list[x]) = 1 then
            list.Delete(x);
        end;
      end
      else begin
        x:= list.IndexOf(fExcludeList[excludeIndex]);
        if x > -1 then
          list.Delete(x);
      end;
    end;
  except
    on e: exception do begin
      result:= false;
      fmsg:= 'Failed to get list of database tables for "' + conn.Database + '" with error: ' + e.Message;
    end;
  end;
end;

function TDBBackup.Restore(const aArchiveFileName: string; NewDbName: string = ''): boolean;
begin
  Progress.Clear;
  fSubOpName := '';
  fDetail := '';
  Progress.OperationName:= 'Restoring "' + self.FDatabaseName + '"';
  result:= DoRestore(aArchiveFileName,NewDbName);
  if result then
    SendProgress('Done','',1,1)
  else
    SendProgress('Error',fMsg,1,1);
end;

//procedure TDBBackup.RestoreProgressEvent(Sender: TObject; Percent: integer);
//begin
//  SendProgress('Restoring tables','',Percent, 100);
//end;

procedure TDBBackup.SendProgress(const aSubOpName, aDetail: string;
  const aStepNo, aStepCount: int64);
var
  dtl: string;
  Percent: integer;
  SendProgress: boolean;
const
  OneSec = (1/24/60/60);
begin
  if Assigned(fOnProgress) then begin
    SendProgress := false;
    dtl := aDetail;
    if (aStepNo <> 0) and (aStepCount <> 0) then
      Percent := Trunc((aStepNo / aStepCount) * 100)
    else
      Percent := 0;
    if aStepNo = 1 then begin
      fNextProgTime := now;
    end;
    if (Percent = 100) then SendProgress := true                { always show 100% }
    else if (now >= fNextProgTime) then SendProgress := true    { send if more thab x time has passed }
    else if (Frac(Percent /10) = 0) then SendProgress := true;  { send 10% steps as a minimum }
    if not SendProgress then
      exit;

    fNextProgTime := now + (5 * OneSec);
    if aStepCount > 1 then begin
      { change message to % done .. }
      dtl := aSubOpName + ' ' + IntToStr(Percent) + '% Done';
    end;

    Progress.SubOperationName:= aSubOpName;
    Progress.Detail:= dtl; //aDetail;
    Progress.StepNo:= aStepNo;
    Progress.StepCount:= aStepCount;
    fOnProgress(self);
  end;
end;

procedure TDBBackup.SetBackupPath(const Value: string);
begin
  FBackupPath := Value;
  If FBackupPath[Length(FBackupPath)] <> '\' then
    fBackupPath := FBackupPath + '\';
end;

procedure TDBBackup.SetDatabaseName(const Value: string);
begin
  FDatabaseName := Value;
  if Assigned(fOnDatabase) then fOnDatabase(self);
end;

procedure TDBBackup.SetIncludeTransactionAndReportDataInBackup(
  const Value: boolean);
begin
  fIncludeTransactionAndReportDataInBackup := Value;
  if value then
    fExcludeList.CommaText:=
      'tmp_*'
  else
    fExcludeList.CommaText:=
      'tmp_*,tbltransactions,tbltransactionsummary,tbltransactionsummarydetails,rpt_*';
end;

procedure TDBBackup.SetServerName(const Value: string);
begin
  FServerName := Value;
end;

function TDBBackup.UnZipFiles(const aArchiveFile,
  aTempDir: string; var aCreateScriptName: string; aFileList: TStringList; var BackupType: string): boolean;
var
  AbZipKit: TAbZipKit;
  x, i: integer;
  s: string;
  infFile: string;
  arcCount: integer;
  arcName, arcNameTemp: string;
begin
  fBackupArchiveFileName := aArchiveFile;
  result:= true;
  BackupType := '';
  if not Active then exit;
  try
    AbZipKit:= TAbZipKit.Create(nil);
    try
      AbZipKit.OnArchiveProgress:= DoReadArchiveProgress;
      AbZipKit.OnProcessItemFailure := DoOnProcessItemFailure;
      AbZipKit.StoreOptions := [soStripDrive,soStripPath,soRemoveDots];
      AbZipKit.BaseDirectory:= aTempDir;
      AbZipKit.Password := SYSDB_PASS;
      AbZipKit.OpenArchive(aArchiveFile);
      infFile := '';
      for x:= 0 to AbZipKit.Count -1 do begin
        if not Active then exit;
        s:= Trim(AbZipKit.Items[x].FileName);
        SendProgress('Reading table list from archive',s,x+1,AbZipKit.Count);
        if s <> '' then begin
          if pos('.sql',s) > 0 then
            aCreateScriptName:= s
          else if pos('info.txt',s) > 0 then
            infFile := s
          else
            aFileList.Add(s);
        end;
      end;
      AbZipKit.OnArchiveProgress:= DoExtractArchiveProgress;
      AbZipKit.ExtractFiles('*.*');
      AbZipKit.CloseArchive;
      arcCount := 1;
      if infFile <> '' then begin
        with TStringList.Create do begin
          LoadFromFile(aTempDir + infFile);
          arcCount := StrToIntDef(Values['ArchiveCount'],1);
          BackupType := Values['BackupType'];
          free;
        end;
      end;
      if arcCount > 1 then begin
        { make sure the other archives exist }
        for i := 1 to arcCount -1 do begin
          if not FileExists(ChangeFileExt(aArchiveFile,'.z' + IntToStr(i))) then begin
            result := false;
            fmsg := 'Could not find one of this backups group of archive files: ' + ChangeFileExt(aArchiveFile,'.z' + IntToStr(i));
            exit;
          end;
        end;
        { extract the data from the rest of the archives in the list }
        for i := 1 to arcCount -1 do begin
          arcName := ChangeFileExt(aArchiveFile,'.z' + IntToStr(i));
          SendProgress('Reading table list from archive ' + IntToStr(i+1) + ' of ' + IntToStr(arcCount),arcName,i+1,arcCount);
          arcNameTemp := ChangeFileExt(arcName,'_' + IntToStr(i) + '.zip');
          CopyFileTo(arcName, arcNameTemp);
          try
            AbZipKit.OpenArchive(arcNameTemp);
            for x:= 0 to AbZipKit.Count -1 do begin
              if not Active then exit;
              s:= Trim(AbZipKit.Items[x].FileName);
              SendProgress('Reading table list from archive',s,i+1,AbZipKit.Count);
              aFileList.Add(s);
            end;
            AbZipKit.ExtractFiles('*.*');
            AbZipKit.CloseArchive;
          finally
            SysUtils.DeleteFile(arcNameTemp);
          end;
        end;
      end;

    finally
      AbZipKit.Free;
    end;
  except
    on e: exception do begin
      result:= false;
      fmsg:= 'Failed to unzip backup archive file "' + aArchiveFile + '" with error: ' + e.Message;
    end;
  end;
end;

//function TDBBackup.ZipFiles(const TempDir: string): boolean;
//var
//  ver: string;
//  AbZipKit: TAbZipKit;
//  fileList: TStringDynArray;
//  arcCount: integer;
//  x: Integer;
//  s: string;
//  zipSize: integer;
//  zipFileName: string;
//
//  function FileSize: integer;
//  var i: integer;
//  begin
//    i := 1;
//    repeat
//      result := FileSizeByName(zipFileName);
//      if result = 0 then begin
//        inc(i);
//        sleep(5);
//      end;
//    until (result > 0) or (i >= 100) ;
//
//  end;
//
//begin
//  result:= true;
//  if not Active then exit;
//  try
//    if fVersion = '' then
//      ver:= ''
//    else
//      ver:= fVersion + '_';
//
////    fBackupArchiveFileName:= FBackupPath + self.DatabaseName + '_' + ver + 'Backup' + Format('_%s', [FormatDateTime('yyyy-mm-dd_hh-nn', now)]) + '.zip';
//    fBackupArchiveFileName := TDbBackupUtils.AddBackupNameSuffix(FBackupPath + self.DatabaseName,fVersion) + '.zip';
//    AbZipKit:= TAbZipKit.Create(nil);
//    try
//
//      { get a list of files }
//      fileList := IOUtils.TDirectory.GetFiles(TempDir);
//      AbZipKit.StoreOptions := [soStripDrive,soStripPath,soRemoveDots];
//      AbZipKit.Password := SYSDB_PASS;
//      zipFileName := fBackupArchiveFileName;
//      AbZipKit.FileName := zipFileName;
//      arcCount:= 0;
//      zipSize := 0;
//      AbZipKit.AddFiles(TempDir + '*.sql', faAnyFile);
//      for x := Low(fileList) to High(fileList) do begin
//        if High(fileList) > 0 then
//          SendProgress('Adding data to archive','',Trunc(((x+1) / High(fileList)) * 100 ),100);
//
//        if Pos('.sql',fileList[x]) = 0 then begin
//          AbZipKit.AddFiles(fileList[x], faAnyFile);
//          zipSize := zipSize + FileSizeByName(fileList[x]);
////          if zipSize > (Max_Archive_Size * 2) then begin
//          if zipSize > Max_Archive_Size then begin
//
//            AbZipKit.CloseArchive;
//            if FileSize < (Max_Archive_Size * 0.8) then begin
//              AbZipKit.OpenArchive(zipFileName);
//            end
//            else begin
//              zipSize := 0;
//              Inc(arcCount);
//              s := IntToStr(arcCount);
//              zipFileName := ChangeFileExt(fBackupArchiveFileName,'_' + IntToStr(arcCount) + '.zip');
//              AbZipKit.FileName := zipFileName;
//            end;
//          end;
//        end;
//      end;
//      AbZipKit.CloseArchive;
//      for x := 1 to arcCount do begin
//        s:= IntToStr(x);
//        RenameFile(ChangeFileExt(fBackupArchiveFileName,'_' + IntToStr(x) + '.zip'), ChangeFileExt(fBackupArchiveFileName,'.z'+s));
//      end;
//      with TStringList.Create do begin
//        Values['ArchiveCount'] := IntToStr(arcCount + 1);
//        {$IFDEF NewBackup}
//        Values['BackupType'] := 'SQLInsert';
//        {$ENDIF}
//        SaveToFile(TempDir + 'info.txt');
//        free;
//      end;
//
//      AbZipKit.FileName := fBackupArchiveFileName;
//      AbZipKit.AddFiles(TempDir + 'info.txt', faAnyFile);
//      AbZipKit.CloseArchive;
//      if arcCount > 0 then begin
//        with TStringList.Create do begin
//          { NOTE: do not change the format of this line, it is used in Off Site Backup/Restore }
//          Text:= 'This backup consists of ' + IntToStr(arcCount+ 1) + ' archive file(s).';
//          SaveToFile(ChangeFileExt(fBackupArchiveFileName,'.txt'));
//          Free;
//        end;
//      end;
//
//
//    finally
//      AbZipKit.Free;
//    end;
//  except
//    on e: exception do begin
//      result:= false;
//      fmsg:= 'Failed to create backup archive file "' + fBackupArchiveFileName + '" with error: ' + e.Message;
//    end;
//  end;
//end;

{ return a comma seperated list of backup archive files }
function TDBBackup.ArchiveList: string;
var
  sr: TSearchRec;
  sl: TStringList;
begin
  sl:= TStringList.Create;
  try
    if FindFirst(BackupPath + '*.zip', faAnyFile, sr) = 0  then begin
      repeat
        sl.Add(sr.Name);
      until FindNext(sr) <> 0;
    end;
    if FindFirst(BackupPath + '*.7z', faAnyFile, sr) = 0  then begin
      repeat
        sl.Add(sr.Name);
      until FindNext(sr) <> 0;
    end;
    sl.Sort;
    result:= sl.CommaText;
  finally
    sl.Free;
  end;
end;

function TDBBackup.DatabaseList(erpOnly: boolean): string;
var
  sl: TStringList;
  conn: TMyConnection;
  qry: TMyQuery;
  x: integer;

  function IsERPDatabase(aDbName: string): boolean;
  begin
    result:= false;
    conn.Database:= aDbName;
    conn.Connect;
    qry.SQL.Text:= 'show tables';
    qry.Open;
    if qry.RecordCount > 300 then begin
      qry.Close;
      qry.SQL.Text:= 'show tables like "tblupdatedetails"';
      qry.Open;
      if not qry.IsEmpty then
        result:= true;
    end;
    qry.Close;
    conn.Disconnect;
  end;

begin
  result := '';
  if not Active then exit;
  try
    sl := TStringList.Create;
    conn := self.NewConnection;
    qry := TMyQuery.Create(nil);
    try
      qry.Connection := conn;
      conn.Database := MYSQL_DATABASE;
      MySQLUtils.SetConnectionServer(conn, Self.ServerName);
      conn.Connect;
      conn.GetDatabaseNames(sl);
      conn.Disconnect;
      if erpOnly then begin
        x := 0;
        while x < sl.Count do begin
          if IsERPDatabase(sl[x]) then
            Inc(x)
          else
            sl.Delete(x);
        end;
      end;
      Result := sl.CommaText;
    finally
      sl.Free;
      qry.Free;
      conn.Free;
    end;
  except
  end;
end;

function TDBBackup.DatabaseVersion: string;
var
  conn: TMyConnection;
begin
  conn:= Self.NewConnection;
  try
    Conn.Connect;
    Result := GetDbVersion(Conn);
  finally
    conn.Free;
  end;
end;

end.
