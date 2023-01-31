unit DBBackupObj;

interface

Uses
  Classes,MyAccess, MyBackup, MyScript, MyClasses,
  AbBase,AbBrowse, AbZBrows, AbZipper, AbZipKit;

Type
  TDBBackupObj = class(TComponent)
  private
    AbZipKit: TAbZipKit;
    FBackup: TMyBackup;
    FConnection: TMyConnection;
    Query: TMyQuery;
    Script: TMyScript;
    function GetDatabase: String;
    function GetServer: String;
    procedure SetDatabase(const Value: String);
    procedure SetServer(const Value: String);
    function GetBackupPath: String;
    procedure SetBackupPath(const Value: String);
    function CreateTablesSQL(includeDrop: Boolean): String;
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    function ZipBackup(Const BackupArchiveFileName: String): Boolean;
    function UnZipBackup(Const BackupArchiveFileName: String): Boolean;
    procedure DeleteFiles(Const sPath, sMask: String);
    procedure ClearBackupDir;    
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init(Const aserver, adatabase, auser, apassword: String);
    function doBackup(Const BackupFilePath: String; Const Remove:Boolean=False): Boolean;
    function doRestore(Const BackupFileName: String): Boolean;
    function BackupExists: Boolean;
    function DBExists(Const DBName: String): Boolean;
  published
    property Active: Boolean read GetActive write SetActive;
    property Backup: TMyBackup read FBackup;
    property backupPath: String read GetBackupPath write SetBackupPath;
    property Connection: TMyConnection read FConnection;
    property server: String read GetServer write SetServer;
    property database: String read GetDatabase write SetDatabase;
  end;



implementation
uses ShellAPI,StrUtils,SysUtils,Forms,BaseDataMod, FastFuncs;

{ TDBBackupObj }

Procedure TDBBackupObj.DeleteFiles(Const sPath, sMask :String);
{Example Usage   Path = c:\Temp\  Mask=*.tmp}
Var
   SearchRec: TSearchRec;
   Found : Integer ;
   sFile : String ;
Begin
  Found:=FindFirst(sPath+sMask, faAnyFile, SearchRec);
  Try
    While (Found = 0) Do Begin
      If Not (SearchRec.Attr and faDirectory > 0) Then Begin
        sFile := SearchRec.Name ;
        DeleteFile(sPath+sFile) ;
      End ;
      Found := FindNext(SearchRec) ;
    End;
  Finally
    FindClose(SearchRec);
  End;
End;

constructor TDBBackupObj.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AbZipKit := TAbZipKit.Create(Self) ;
  FConnection := TMyConnection.Create(self);
  FConnection.LoginPrompt := False;
  FBackup := TMyBackup.Create(self);
  FBackup.Mode := bmText;
  FBackup.Local := False;
  Query := TMyQuery.Create(self);
  Query.Options.FlatBuffers := True;
  Script := TMyScript.Create(self);
  FBackup.Connection := FConnection;
  Query.Connection := FConnection;
  Script.Connection := FConnection;
end;

destructor TDBBackupObj.Destroy;
begin
  FreeAndNil(Script);
  FreeAndNil(Query);
  FreeAndNil(FBackup);
  FreeAndNil(FConnection);
  FreeAndNil(AbZipKit);
  inherited;
end;

procedure TDBBackupObj.Init(Const aserver, adatabase, auser, apassword: String);
begin
  FConnection.Server := aserver;
  FConnection.Username := auser;
  FConnection.Password := apassword;
  FConnection.Database := adatabase;
  FConnection.Port := 3306;
  FConnection.Options.Protocol :=  mpDefault;
  backupPath := ExtractFilePath(Application.ExeName) +'ErrTrackingBackup\';
  SysUtils.ForceDirectories(backupPath);
end;

procedure TDBBackupObj.ClearBackupDir;
begin
if FBackup.Path <> '' then
  begin
  ForceDirectories(FBackup.Path);
  DeleteFiles(FBackup.Path, '*.*');
  end;
end;

function TDBBackupObj.CreateTablesSQL(includeDrop: Boolean): String;
var sl: TStringList;
    i: Integer;
begin
  sl := TStringList.Create;
  try
    result := '';
    Connection.GetTableNames(sl);
    for i := 0 to sl.Count-1 do begin
      Query.SQL.Text := 'SHOW CREATE Table ' + sl[i] + ';';
      Query.Open;
      if includeDrop then
        result := result + 'DROP TABLE IF EXISTS ' + sl[i] + ';'#13#10;
      result := result + Query.FieldByname('Create Table').asString + ';'#13#10#13#10;
    end;
  finally
    sl.Free;
  end;
end;

function TDBBackupObj.doBackup(Const BackupFilePath: String; Const Remove:Boolean=False): Boolean;
var ms: TFileStream;
    sql: String;
    sqlDataBaseName: String;
begin
  ClearBackupDir;
  if not Connection.Connected then
    Connection.Open;
  sql := CreateTablesSQL(true) ;
  ms := TFileStream.Create(FBackup.Path + '\' + Database + '_DropCreateTables.sql', fmCreate );
  try
    ms.Write(sql[1], FastFuncs.StrLength(sql));
    FBackup.Backup;
  finally
    ms.Free;
    Query.SQL.Text := 'UNLOCK TABLES';
    Query.Execute;
    Query.Close;
  end;
  ZipBackup(BackupFilePath + FastFuncs.Trim(Connection.Database)
      + '_Backup' + format('_%s',[formatDateTime('yyyy-mm-dd_hh-nn',Now())])
      + '.zip');
  Result := True;
  If Remove then Begin
    try
      Connection.ExecSQL('DROP DATABASE `'+sqlDatabaseName+'`;',[]);
    except
    end;
  end;
end;

function TDBBackupObj.doRestore(Const BackupFileName: String): Boolean;
var ms: TFileStream;
    sql: String;
begin
  result := False;
  UnZipBackup(BackupFileName);
  if not Connection.Connected then
    Connection.Open;
  if FileExists( FBackup.Path + '\'+ Database + '_DropCreateTables.sql') then begin
    ms := TFileStream.Create(FBackup.Path + '\'+ Database + '_DropCreateTables.sql', fmOpenRead);
    try
      SetLength(sql, ms.Size);
      ms.Read(sql[1],ms.Size);
      Script.SQL.Text := sql;
      Script.Execute;
      FBackup.Restore;
      result := True;
    finally
      ms.Free;
    end;
  end;
end;

function TDBBackupObj.GetBackupPath: String;
begin
  result := FBackup.Path;
end;

function TDBBackupObj.GetDatabase: String;
begin
  result := Connection.Database;
end;

function TDBBackupObj.GetServer: String;
begin
  result := Connection.Server;
end;

procedure TDBBackupObj.SetBackupPath(const Value: String);
begin
  FBackup.Path := Value;
  if FBackup.Path[FastFuncs.StrLength(FBackup.Path)] <> '\' then
    backupPath := FBackup.Path + '\';
end;

procedure TDBBackupObj.SetDatabase(const Value: String);
begin
  Connection.Close;
  Connection.Database := Value;
end;

procedure TDBBackupObj.SetServer(const Value: String);
begin
  Connection.Close;
  Connection.Server := Value;
end;

function TDBBackupObj.GetActive: Boolean;
begin
  result := Connection.Connected;
end;

procedure TDBBackupObj.SetActive(const Value: Boolean);
begin
  if Value then
    Connection.Open
  else
    Connection.Close;
end;

function TDBBackupObj.BackupExists: Boolean;
begin
  result := Connection.Connected AND FileExists( FBackup.Path + '\'+ Database + '_DropCreateTables.sql');
end;

function TDBBackupObj.DBExists(Const DBName: String): Boolean;
var ls: TStringList;
begin
  ls := TStringList.Create;
  try
    Connection.GetDatabaseNames(ls);
    result := ls.IndexOf(DBName) > -1;
  finally
    ls.Free;
  end;
end;

function TDBBackupObj.UnZipBackup(const BackupArchiveFileName: String): Boolean;
var i, j: Integer;
    comma: String;
    tableName: String;
begin
  Try
    comma := '';
    for i := 0 to AbZipKit.Count - 1 do
      if FastFuncs.PosEx('.sql', AbZipKit.items[i].FileName) < 1 then    // exclude .sql file
        begin
        tableName := '';
        for j := FastFuncs.StrLength(AbZipKit.items[i].FileName) downto 1 do
          if AbZipKit.items[i].FileName[j] in ['a'..'z','A'..'Z','_','0'..'9'] then
            Insert(AbZipKit.items[i].FileName[j] ,tableName, 1)
          else if AbZipKit.items[i].FileName[j] in ['/','\'] then
            BREAK;
        FBackup.TableNames :=
          FBackup.TableNames + comma + tableName;
        if FBackup.TableNames > '' then
          comma := ',';
        end;
    ClearBackupDir;
    AbZipKit.Password := Connection.Password;
    AbZipKit.OpenArchive(BackupArchiveFileName);
    AbZipKit.BaseDirectory := FBackup.Path;
    AbZipKit.ExtractFiles('*.*');
    Result := True;
  except
    Result := False;
  end;
end;

function TDBBackupObj.ZipBackup(const BackupArchiveFileName: String): Boolean;
begin
  Try
    ForceDirectories(ExtractFilePath(BackupArchiveFileName));
    AbZipKit.FileName := BackupArchiveFileName;
    AbZipKit.Password := FConnection.Password;
    AbZipKit.AddFiles(FBackup.Path + '*.*', faAnyFile);
    AbZipKit.CloseArchive;
    ClearBackupDir;
    Result := True;
  except
    Result := False;
  end;
end;

end.
