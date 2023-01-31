unit ErpDbUpdaterObj;

interface

uses
  LogThreadBase, LogMessageTypes, MyAccess, Classes, sysutils, MyClasses,
  DAScript, JsonObject, DbBackupObj;

type

  TDatabaseUpdateType = (dutUnknown,dutDb,dutDbTemplates,dutInnoSetup);

  TErpDbUpdater = class(TObject)
  private
    fTempPath: string;
    FLogger: TLoggerBase;
//    fPath: string;
    UpdateInfo: TJsonObject;
    Backup: TDBBackup;
    fSoftwareReleaseType: string;
    LastProgress_SubOpName: string;
    fDownloadPercent: integer;
    fOnLog: LogThreadBase.TOnLogEvent;
    fMySQLServer: string;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
//    property Path: string read fPath;
    property TempPath: string read fTempPath;
    procedure DoOnBackupProgress(Sender: TObject);
    (*function DoHelpUpdate(const aUpdateFileName: string): boolean;*)
    function DoLanguageUpdate(const aUpdateFileName: string): boolean;
    procedure DoDownloadProgress(percent: integer);
    procedure SaveUpdateToDb(UpdateName, Version, Part, Params, FileName: string);

  public
    { a list of objects representing each database to be updated }
    DatabaseList: TJsonObject;
    constructor Create(aSoftwareReleaseType, MySQLServer: string; aLogger: TLoggerBase = nil);
    destructor Destroy; override;
    property Logger: TLoggerBase read FLogger write FLogger;
    function CheckForUpdates: boolean;
    property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;


  TDbUpdater = class(TObject)
  private
    FLogger: TLoggerBase;
    UpdaterConnection: TMyConnection;

    LinesCount: Integer;
    CurrentCount: Integer;
    IgnoreError: Boolean;

    LastSQL:String;
    NoServer:Boolean;
    ErrorMessage:String;
    DBName: String;
    UpdateFile:String;
    FromTABLEVERSION: String;
    ToTABLEVERSION: String;
    TextFileStrings: TStringList;

    {Templates}
    F: TextFile;
    qryInsertRecord : TMyCommand;
    qryUpdateRecord : TMyCommand;
    TEMPLATE_UPDATE_FILE: String;
    HeaderStrings:String;
    TableString:String;
    TempFilePath:String;
    FieldVauleStrTempID:String;
    fTempDir: string;
    fOnLog: LogThreadBase.TOnLogEvent;
    fMySQLServer: string;

    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
    procedure MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);

    {SQL Update}
    function UpdateDatabaseSQL :Boolean;

    {Templates}
    function ImportTemplates :Boolean;
    procedure ExtractTemplateFiles(Const FileName, DataPath: String);
    Procedure TemplateProcessLineOfString(Const LineStr: String);
    procedure ImportRTM(Const FileName,ID:String);
    procedure CleanupTemplate;
    Function TemplateInsertRecord(Const HeaderStrings,TableString,DataStrings: String):Integer;
    Function TemplateUpdateRecord(Const HeaderStrings,TableString,DataStrings: String): Integer;
    Function TemplateInsertNow(Const SQLStr,HeaderStrings,TableString,DataStrings:String): Integer;
    Function TemplateCreateUpdateString(Const HeaderStrings,DataStrings: String): String;
    function TemplateCreateWhereString(Const DataStrings: String): String;
    Function TemplateUpdateNow(Const SQLStr:String): Boolean;
    Function LineCount(const FileName: String): integer;
    Function GetLineOfString(const I,LinesCount: Integer; Const MessageStr:String): String;
    function FieldCounter(Const TestString,Delimiter: String): Integer;
    Function TemplateModQtyDataStr(Const LineStringTemp:String): String;

   {Utils}
    function GetFileVersion (const LineString: String): String;
    procedure ExecuteSQLs(const SQLStrlst: TStringList);
    function StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;

    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function GetTempDir: string;
    property TempDir: string read GetTempDir;
  public
    constructor Create(aMySQLServer: string);
    destructor Destroy; override;
    property Logger: TLoggerBase read FLogger write FLogger;
    function UpdateDatabase(Const UpdateType: TDatabaseUpdateType; const DatabaseName, UpdatePath: String): Boolean;
    property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;

implementation

uses
  windows, ShellAPI, MyScript, db, strutils, DbConst,
  FileDownloadFuncs, UpdaterConst, JsonToObject,
  {ModuleUserUtilsObj,} ModuleConst, CipherUtils, InstallConst,
  AbUnzper, MyDump, ModuleDbUtils, UpdateStoreObj, cabfiles, dateutils,
  AppRunUtils, Math, DateTimeUtils, UtilsLib, SharedAppUserListObj, SystemLib,
  VersionUtils, FileVersion;

function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := Source + Delim;
  S := 1;
  for L9 := 1 to PosCount - 1 do begin
    S := Pos(Delim, Src);
    if S > 0 then Delete(Src, S, Length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

function WindowsTempDir: string;
var
  acDir: array[0..255] of char;
begin
  GetTempPath(Length(acDir), acDir);
  result := StrPas(acDir);
end;

function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  result:= StringReplace(sString,sOldStr,sNewStr,[rfReplaceAll]);
end;

function GetEmployeeID(Const DBConnection: TMyConnection; Const EmployeeName,Database: String): Integer;
Var
  qryTemp:TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  try
    qryTemp.Connection := DBConnection;
    qryTemp.Sql.Add('SELECT EmployeeID FROM tblemployees WHERE Concat(FirstName," ",LastName) = ' + QuotedStr(EmployeeName) + ';');
    qryTemp.Active := True;
    If not qryTemp.IsEmpty then begin
      result:= qryTemp.FieldByName('EmployeeID').AsInteger;
    End else begin
      result:= 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTypeID(Const DBConnection: TMyConnection; Const TypeName,Database: String): Integer;
Var
  qryTemp:TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  try
    qryTemp.Connection := DBConnection;
    qryTemp.Sql.Add('SELECT TypeID FROM tbltemplatetype WHERE TypeName = '+ Quotedstr(TypeName) + ';');
    qryTemp.Active := True;
    If not qryTemp.IsEmpty then begin
      result:= qryTemp.FieldByName('TypeID').AsInteger;
    End else begin
      result:= 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetDB_Version(Const DBConnection: TMyConnection; Const Database:String): String;
Var
  qryTemp : TMyQuery;
Begin
  Result := '';
  qryTemp := TMyQuery.Create(nil);
  Try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := DBConnection;
    qryTemp.SQL.Text := 'SELECT ID,Version FROM `tblupdatedetails` Where ID=1;';
    Try
      qryTemp.Open;
    except
      Exit;
    end;
    if (qryTemp.Recordcount<>0) then
      Result := qryTemp.Fields[1].asString;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetModuleName: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

procedure DeleteFiles(const Path, Mask: String);
var
  lpFileOp : TSHFileOpStruct;
begin
  FillChar(lpFileOp, sizeof(lpFileOp), #0);
  lpFileOp.wFunc  := FO_DELETE;
  { The + #0 is required }
  lpFileOp.pFrom  := PChar(Path + Mask + #0);
  lpFileOp.pTo    := PChar(Path);
  lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
  { Perform Operation }
  if (SHFileOperation(lpFileOp) <> 0) then Exit;
end;

function ExtractFileNameEx(const FileName: string): string;
var
  I: Integer;
begin
  I := LastDelimiter('/' + PathDelim + DriveDelim, FileName);
  Result := Copy(FileName, I + 1, MaxInt);
end;



{ TDbUpdater }

procedure TDbUpdater.CleanupTemplate;
var cmd: TMyCommand;
begin
  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection := UpdaterConnection;
    cmd.Sql.Add('UPDATE tbltemplates SET DesignTimeSQLString = NULL');
    cmd.Sql.Add('WHERE DesignTimeSQLString = "x";');
    cmd.Execute;
  finally
    cmd.Free;;
  end;
end;

constructor TDbUpdater.Create(aMySQLServer: string);
begin
  fMySQLServer := aMySQLServer;
  NoServer := False;
  DBName := '';
  FromTABLEVERSION := '';
  TEMPLATE_UPDATE_FILE := '';
  UpdateFile:='';
  TextFileStrings:= TStringList.Create;
end;

destructor TDbUpdater.Destroy;
begin
  TextFileStrings.Free;
  inherited;
end;

procedure TDbUpdater.ExecuteSQLs(const SQLStrlst: TStringList);
Var
  MyScript: TMyScript;
  I: Integer;
  TestStr: String;
begin
  MyScript := TMyScript.Create(nil);
  try
    MyScript.OnError := MyScriptError;
    MyScript.BeforeExecute := MyScriptBeforeExecute;
    MyScript.Connection := UpdaterConnection;

    For I := 0 to SQLStrlst.Count -1 do Begin
      TestStr := Trim(SQLStrlst.Strings[I]);
      If (TestStr = '') then Continue;
      If SameText(TestStr[1],'#') then Begin
        SQLStrlst.Strings[I] := '';
        TestStr := '';
      end;
      If (TestStr = '') then Continue;
      If Pos(';', TestStr) > 0 then Begin
        SQLStrlst.Strings[I] := TestStr;
        Continue;
      end else Begin
//        TestStr := TestStr + ';';
        SQLStrlst.Strings[I] := TestStr;
      end;
    end;
    MyScript.SQL.TEXT := Trim(SQLStrlst.Text);
    LinesCount := MyScript.Statements.Count;
    MyScript.Execute;
//    ExcMagic.ExceptionHook.LogEnabled := True;
  finally
    MyScript.Free;
  end;
end;

procedure TDbUpdater.ExtractTemplateFiles(const FileName,
  DataPath: String);
var
  aCab: TCabFile;
begin
  aCab := TCabFile.Create(nil);
  try
    aCab.CABFile:= FileName;
    aCab.TargetPath:= DataPath;
    aCab.GetContents;
    aCab.ExtractAll;
  finally
    aCab.Free;
  end;
end;

function TDbUpdater.FieldCounter(const TestString,
  Delimiter: String): Integer;
var
 TempStr:String;
 S,Count,I:Integer;
begin
 TempStr :=TestString;
 Count:=1 ;
 for I := 1 to 200 do begin
    S := Pos(Delimiter, TempStr);
      If S > 0 Then Begin
         Delete( TempStr, S, Length(Delimiter)) ;
         Count:=Count+1;
      end else Begin
         Break ;
      End ;
 End;
 result := Count
end;

function TDbUpdater.GetFileVersion(const LineString: String): String;
Var
 ValidateStr,VersionStr :String;
begin
 Result := '0';
 ValidateStr := ExtractStrPortion(LineString,'UpdateVersion=',1);
 If ValidateStr ='#' then Begin
   VersionStr := ExtractStrPortion(LineString,'UpdateVersion=',2);
   VersionStr := Trim(VersionStr);
   Result := VersionStr;
 end;
end;

function TDbUpdater.GetLineOfString(const I, LinesCount: Integer;
  const MessageStr: String): String;
begin
  try
    Readln(F,result);
  except
    on EInOutError do result := '';
  end;
end;

function TDbUpdater.GetTempDir: string;
begin
  if fTempDir = '' then
    fTempDir:= WindowsTempDir;
  result:= fTempDir;  
end;

procedure TDbUpdater.ImportRTM(const FileName, ID: String);
var
  ms: TMemoryStream;
  qry: TMyQuery;
begin
  ms := TMemoryStream.Create;
  qry:= TMyQuery.Create(nil);
  try
    ms.LoadFromFile(FileName);
    qry.Connection := UpdaterConnection;
    qry.Sql.Add('SELECT TemplID,Report FROM tbltemplates Where TemplID='+ID+';');
    qry.Open;
    if qry.RecordCount < 1 then Exit;
    qry.First;
    qry.Edit;
    TBlobField(qry.FieldByName('Report')).LoadFromStream(ms);
    qry.Post;
    qry.Close;
  finally
    ms.Free;
    qry.Free;
  end;
end;

function TDbUpdater.ImportTemplates: Boolean;
var
  LINESTRING: String;
  I,LinesCount: Integer;
begin
  Result := False;
  If (TEMPLATE_UPDATE_FILE = '') then begin
    Exit;
  end;
  Log('    Importing report template changes - ('+ FromTABLEVERSION +')', ltInfo);
  TempFilePath := '';
  HeaderStrings := '';

  If DirectoryExists(ExtractFileDir(TEMPLATE_UPDATE_FILE)) then begin
        If FileExists(TEMPLATE_UPDATE_FILE) then begin
        //Decompress Files
        TempFilePath := TempDir + 'TemplateImport\Templates.pdi';
        try
         if not DirectoryExists(ExtractFileDir(TempFilePath)) then begin
           MkDir(ExtractFileDir(TempFilePath));
         end;
        except
        end;
        ExtractTemplateFiles(TEMPLATE_UPDATE_FILE, ExtractFileDir(TempFilePath));
       //Start Process
          Log('Import Report Template Changes - ('+ FromTABLEVERSION +')', ltInfo);
          LinesCount := LineCount(TempFilePath);
          AssignFile ( F, TempFilePath );
          try
            {$I-}
            Reset(F);
            {$I+}
            If IOResult = 0 Then;
            for I := 1 to LinesCount do Begin
              //get next Line
              LINESTRING := GetLineOfString(I,LinesCount,'Please Wait Importing Report Template Changes');
              // Process Line String
              LINESTRING := Trim(LINESTRING);
              If (LINESTRING <> '') then TemplateProcessLineOfString(LINESTRING);
            End;
          finally
            CloseFile (f);
          end;
          //Delete Temp Directory
          try
           DeleteFiles(ExtractFileDir(TempFilePath)+ '\TemplateFiles\','*.*');
           DeleteFiles(ExtractFileDir(TempFilePath)+ '\','*.*');
           if DirectoryExists(ExtractFileDir(TempFilePath)) then begin
             if DirectoryExists(ExtractFileDir(TempFilePath)) then begin
              try
               RmDir(ExtractFileDir(TempFilePath)+ '\TemplateFiles');
              except
              end;
             end;
            RmDir(ExtractFileDir(TempFilePath));
           end;
          except
          end;
          CleanupTemplate;
        end else begin
           Log('File "' + TEMPLATE_UPDATE_FILE + '" Does Not Exist !',ltError);
        end;
   end else begin
       Log('Directory "' + ExtractFileDir(TEMPLATE_UPDATE_FILE) + '" Does Not Exist !',ltError);
   end;
   Result := True;
end;

function TDbUpdater.LineCount(const FileName: String): integer;
var
  Count: Integer;
begin
  Count := 0;
  AssignFile(F,FileName);
  {$I-}
  Reset(F);
  {$I+}
  If IOResult=0 Then;
    while not eof(F) do begin
    readln(F);
    inc(Count);
    end;
   CloseFile(F);
   result:= Count;
end;

procedure TDbUpdater.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg,LogMessageType);
end;

procedure TDbUpdater.MyScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
//  ExcMagic.ExceptionHook.LogEnabled := True;
  Inc(CurrentCount);
//  TProcessUpdatesBase(Self.Owner).ShowHint('Please Wait Applying Update ..... ' + FloatToStrF(((CurrentCount/LinesCount)* 100),ffFixed,18,0) + '% Complete');
  IgnoreError := (LeftStr(SQL,1)='~');
  If IgnoreError then Begin
    SQL := RightStr(SQL, Length(SQL)-1);
//    ExcMagic.ExceptionHook.LogEnabled := False;
  end;
  Omit := SQL = '';
  LastSQL := SQL;
end;

procedure TDbUpdater.MyScriptError(Sender: TObject; E: Exception;
  SQL: String; var Action: TErrorAction);
var
  del: string;
begin
  If E is EMyError then begin
    if Pos('DELIMITER',UpperCase(Trim(SQL))) = 1 then begin
      del := Trim(Copy(Trim(SQL),10,Length(SQL)));
      TMyScript(Sender).Delimiter := del;
      NoServer := False;
      ErrorMessage:= '';
      Action := eaContinue;
    end
    else If IgnoreError then Begin
      NoServer := False;
      ErrorMessage:= '';
      Action := eaContinue;
    end else Begin
      NoServer := True;
      ErrorMessage:= e.message;
      Action := eaAbort;
    end;
  end else begin
    NoServer := True;
    Action := eaFail;
    ErrorMessage:= e.message;
  end;
end;

function TDbUpdater.StrExtStr(const HSrc, Delim: string;
  const Count: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := HSrc + Delim;
  S := 1;
  for L9 := 1 to Count - 1 do begin
    S := Pos(Delim, Src);
    if S > 0 then Delete(Src, S, Length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

function TDbUpdater.TemplateCreateUpdateString(const HeaderStrings,
  DataStrings: String): String;
var
 TempString,CreatingString:String;
 FieldCount,I:Integer;
begin
 TempString := '';
 CreatingString:='';
 FieldCount := FieldCounter(HeaderStrings,#9);

 If FieldCount= 0 then Begin
  FieldCount:= 1;
 end;

 for I := 1 to FieldCount do Begin
  TempString := '';
  TempString := TempString + ExtractStrPortion(HeaderStrings,#9,I) + '=';
  TempString := TempString + ExtractStrPortion(DataStrings,#9,I)+ ',';
  CreatingString :=CreatingString + TempString
 End;
  CreatingString := Copy(CreatingString,0,Length(CreatingString)-1);
  Result := CreatingString
end;

function TDbUpdater.TemplateCreateWhereString(
  const DataStrings: String): String;
var
  TempWhereField1, TempStr, CreatingString: string;
  Wherename, wheretype:String;
begin
  TempStr := DataStrings;
  wheretype:= ReplaceStr(StrExtStr(TempStr, #44, 2), #39, ' ');
  Wherename:= ReplaceStr(StrExtStr(TempStr, #44, 3), #39, ' ');
  TempWhereField1 :=  Wherename + ' and ' + wheretype;
  CreatingString := ' WHERE ' + TempWhereField1;
  Result := CreatingString;
end;

function TDbUpdater.TemplateInsertNow(const SQLStr, HeaderStrings,
  TableString, DataStrings: String): Integer;
Var
 ThenUpdate:Boolean;
begin
  Result := 0;
  Try
//    ExcMagic.ExceptionHook.LogEnabled := False;
    try
      ThenUpdate := False;
      qryInsertRecord.Execute;
      result := qryInsertRecord.InsertId;
    except
      on E: EMyError do ThenUpdate := True;
    end;
  Finally
//    ExcMagic.ExceptionHook.LogEnabled := True;
  end;
  If ThenUpdate then
    Result := TemplateUpdateRecord(HeaderStrings,TableString,DataStrings);
end;

function TDbUpdater.TemplateInsertRecord(const HeaderStrings,
  TableString, DataStrings: String): Integer;
Var
  SQLString:String;
  SQLString1:String;
begin
  qryInsertRecord := TMyCommand.Create(nil);
  try
    qryInsertRecord.Connection := UpdaterConnection;
    SQLString := 'INSERT INTO ' + TableString + '(' + ReplaceStr(HeaderStrings,#9,#44) + ') VALUES ';
    SQLString1 := '(' + ReplaceStr(DataStrings,#9,#44)  + ');';
    qryInsertRecord.Sql.Add(SQLString);
    qryInsertRecord.Sql.Add(SQLString1);
    REsult := TemplateInsertNow(SQLString,HeaderStrings,TableString,DataStrings);
  finally
    FreeAndNil(qryInsertRecord);
  end;
end;

function TDbUpdater.TemplateModQtyDataStr(
  const LineStringTemp: String): String;
var
 StringTemp:String;
 FieldVauleStrTypeName:String;
 FieldVauleStrTemplName:String;
 FieldVauleStrTemplateClass:String;
 FieldVauleStrEmployee:String;
 StrTypeID:String;
 StrEmployeeID:String;
begin
    StringTemp := LineStringTemp;
    FieldVauleStrTempID:= ExtractStrPortion(StringTemp,#9,1);
    FieldVauleStrTypeName:= ExtractStrPortion(StringTemp,#9,2);
    StrTypeID:= IntToStr(GetTypeID(UpdaterConnection,FieldVauleStrTypeName,DBName));
    FieldVauleStrTemplName:= ExtractStrPortion(StringTemp,#9,3);
    FieldVauleStrTemplateClass:= ExtractStrPortion(StringTemp,#9,4);
    FieldVauleStrEmployee:= ExtractStrPortion(StringTemp,#9,5);
    StrEmployeeID:= IntToStr(GetEmployeeID(UpdaterConnection,FieldVauleStrEmployee,DBName));
    StringTemp := ReplaceStr(StringTemp,
    FieldVauleStrTempID+#9+FieldVauleStrTypeName+#9+FieldVauleStrTemplName+#9+FieldVauleStrTemplateClass+#9+FieldVauleStrEmployee,
    'NULL'+#9+FieldVauleStrTypeName+#9+FieldVauleStrTemplName+#9+FieldVauleStrTemplateClass+#9+StrEmployeeID);
    StringTemp := ReplaceStr(StringTemp,'NULL'+#9+FieldVauleStrTypeName,'NULL'+#9+StrTypeID);
    StringTemp := ReplaceStr(StringTemp,#9,#34+#9+#34);
    StringTemp := #34 + StringTemp + #34;
    StringTemp := ReplaceStr(StringTemp, '"NULL"', 'NULL');
   If (StrTypeID='0') then begin
      Result:='';
   end else Begin
      Result:= StringTemp;
   end;
end;

procedure TDbUpdater.TemplateProcessLineOfString(const LineStr: String);
var
  LineString,FirstField,TypeImport,RTMFilePath:String;
  NewId :Integer;
begin
  LineString := LineStr;
  FirstField:='';
  RTMFilePath:='';
  FirstField:= ExtractStrPortion(LineString,#9,1);
  TypeImport:= ReplaceStr(FirstField,'$','');
  TypeImport:= ReplaceStr(TypeImport,'FINAL','');
       If TypeImport ='TEMPLATE'then Begin
               If FirstField='$TEMPLATE' then begin
                LineString :=  ReplaceStr(Trim(LineString),'$TEMPLATE'+#9,'');
                HeaderStrings := Trim(LineString);
                //TEMPLATE Header Mod for ID's TypeName and EmployeeName
                HeaderStrings :=  ReplaceStr(HeaderStrings,'TypeName','TypeID');
                HeaderStrings :=  ReplaceStr(HeaderStrings,'EmployeeName','EmployeeID');
                TableString := 'tbltemplates';
               end else If FirstField='TEMPLATE' then begin
                LineString :=  ReplaceStr(Trim(LineString),'TEMPLATE'+#9,'');
                //TEMPLATE Data Mod for ID's TypeName and EmployeeID
                 LineString := TemplateModQtyDataStr(LineString);
                 If (HeaderStrings <> '') and (TableString <> '') and (LineString <> '') then begin
                  NewId := TemplateInsertRecord(HeaderStrings,TableString,LineString);
                  //If not Empty(FieldVauleStrTempID) then Begin
                  if NewId <> 0 then begin
                    RTMFilePath := ExtractFileDir(TempFilePath)+ '\TemplateFiles\' + FieldVauleStrTempID + '.tcr';
                     If FileExists(RTMFilePath) then Begin
                       //ImportRTM(RTMFilePath,FieldVauleStrTempID);
                       ImportRTM(RTMFilePath, intTostr(NewId));
                     end;
                  end;
                 end;
               end else If FirstField='FINALTEMPLATE' then begin
                HeaderStrings := '';
//                Application.ProcessMessages;
               end;
        end;
end;

function TDbUpdater.TemplateUpdateNow(const SQLStr: String): Boolean;
begin
  Try
//    ExcMagic.ExceptionHook.LogEnabled := False;
    try
      result := true;
      qryUpdateRecord.Execute;
    except
      on E: EMyError do result := False;
    end;
  Finally
//    ExcMagic.ExceptionHook.LogEnabled := True;
  end;
end;

function TDbUpdater.TemplateUpdateRecord(const HeaderStrings,
  TableString, DataStrings: String): Integer;
Var
  UpdateString,SQLString,WhereString:String;
  qry: TMyQuery;
begin
  qryUpdateRecord := TMyCommand.Create(nil);
  try
    qryUpdateRecord.Connection := UpdaterConnection;
    //Convert Insert SQL String To Update SQL
    UpdateString:= TemplateCreateUpdateString(HeaderStrings,DataStrings);
    //Create Update SQL Where Clause
    SQLString := 'UPDATE ' + TableString + ' SET ' + UpdateString +';';
    //Create Update SQL Where Clause
    WhereString:= TemplateCreateWhereString(UpdateString);
    SQLString := 'UPDATE ' + TableString + ' SET ' + UpdateString + WhereString +';';
    SQLString :=REplaceStr(SQLString , 'SET TemplID=NULL,' , 'SET ');
    qryUpdateRecord.Sql.Add(SQLString);
    TemplateUpdateNow(SQLString);
    //Result := True;


    qry:= TMyQuery.Create(nil);
    try
      qry.connection := UpdaterConnection;
      qry.SQL.add('select TemplID From tblTemplates ' + WhereString);
      qry.open;
      result := qry.fieldbyname('TemplID').asInteger;
    finally
      qry.Free;
    end;
  finally
    FreeAndNil(qryUpdateRecord);
  end;
end;

function TDbUpdater.UpdateDatabase(const UpdateType: TDatabaseUpdateType;
  const DatabaseName, UpdatePath: String): Boolean;
begin
  Result := True;
  DBName := DatabaseName;
  UpdaterConnection:= TMyConnection.Create(nil);
  if fMySQLServer <> '' then
    ModuleDbUtils.InitialiseConnection(UpdaterConnection,fMySQLServer,DBName)
  else
    ModuleDbUtils.InitialiseConnection(UpdaterConnection,'127.0.0.1',DBName);
  try
    FromTABLEVERSION := GetDB_Version(UpdaterConnection,DBName);
    UpdateFile := UpdatePath;
    Case UpdateType Of
      dutDb: Begin
              TextFileStrings.LoadFromFile(UpdatePath);
              ToTABLEVERSION := GetFileVersion(TextFileStrings.Strings[0]);
              If (TextFileStrings.Count=0) then begin
                result := false;
                Log('Update SQL is Empty.',ltError);
                Exit;
              end
              else if (ToTABLEVERSION='0') then begin
                result := false;
                Log('Could not read the new Version from the update SQL.',ltError);
                Exit;
              end
              else if (FromTABLEVERSION='') then begin
                result := false;
                Log('Update "From" Version is blank.',ltError);
                Exit;
              end;
              if SameText(GetDB_Version(UpdaterConnection,DatabaseName),FromTABLEVERSION) then Begin
                If not UpdateDatabaseSQL then Begin
                  Result := false;
                  Exit;
                end;
              end;
            end;
      dutDbTemplates: Begin
                        TEMPLATE_UPDATE_FILE := UpdatePath;
                        If not ImportTemplates then Begin
                          Result := false;
                          Exit;
                        end;
                      end;
    end;
  Finally
    UpdaterConnection.Disconnect;
    FreeAndNil(UpdaterConnection);
  end;
end;

function TDbUpdater.UpdateDatabaseSQL: Boolean;
begin
  Result:=True;
  CurrentCount:=0;
  NoServer := False;
  Log('    Updating database ' + DBName + ' - ('+ FromTABLEVERSION + ' to '+ToTABLEVERSION+')', ltInfo);

  ExecuteSQLs(TextFileStrings);

  if NoServer and (CurrentCount<=1)  then begin
    Result:=False;
    Log('Error updating database while executing sql: ',ltError);
    Log(LastSQL, ltError);
    if ErrorMessage <> '' then
      Log('Error message: ' + ErrorMessage, ltError);
  end
  else if NoServer then begin
    Result:=False;
    Log('Error Occured.',ltError);
    Log(#9+'Line No.  ' + IntToStr(CurrentCount),ltError);
    Log(#9+ StringReplace(ErrorMessage,'[MySQL][ODBC 3.51 Driver]','',[rfReplaceAll]),ltError);
    Log('Error while executing sql: ',ltError);
    Log(LastSQL, ltError);
    if ErrorMessage <> '' then
      Log('Error message: ' + ErrorMessage, ltError);
  end;
end;

{ TErpDbUpdater }

constructor TErpDbUpdater.Create(aSoftwareReleaseType, MySQLServer: string; aLogger: TLoggerBase = nil);
begin
  fMySQLServer := MySQLServer;
  DatabaseList:= TJsonObject.Create;
  fLogger := aLogger;
  { Note the following will default to "Production" if softwarereleasetype is blank }
  fSoftwareReleaseType := Lowercase(aSoftwareReleaseType);
//  fPath:= ExtractFilePath(GetModuleName);
  fTempPath := WindowsTempDir;
  UpdateInfo := TJsonObject.Create;
  Backup := TDBBackup.Create;
  Backup.ServerName := MySQLServer;
  Backup.OnProgress := DoOnBackupProgress;
end;

destructor TErpDbUpdater.Destroy;
begin
  Backup.Free;
  UpdateInfo.Free;
  DatabaseList.Free;
  inherited;
end;

procedure TErpDbUpdater.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg,LogMessageType);
end;

procedure TErpDbUpdater.SaveUpdateToDb(UpdateName, Version, Part, Params, FileName: string);
var
  UpdateStore: TUpdateStore;
begin
  UpdateStore:= TUpdateStore.Create;
  try
    if fMySQLServer <> '' then
      UpdateStore.Server := fMySQLServer
    else
      UpdateStore.Server:= '127.0.0.1';
    UpdateStore.SaveUpdate(UpdateName, Version, Part, Params, FileName);
  finally
    UpdateStore.Free;
  end;
end;

function TErpDbUpdater.CheckForUpdates: boolean;
var
  dbList: TStringList;
  dbIdx: integer;
  updateIdx: integer;
  partIdx: integer;
  CurrentDatabase: string;
  CurrentVersion: string;
  CurrentDatabaseUpdateOk: boolean;
  itemList, verList, verItem, verPart: TJsonObject;
  itemIdx: integer;
  Updater: TDbUpdater;
  UpdateFilePath: string;
  UpdateFileName: string;
  installFileName: string;
  UpdateType: TDatabaseUpdateType;
  DoDbUpdates: boolean;
  UpdateBaseDir: string;
  helpUpdateFileAge, aFileAge: TDateTime;
  languageUpdateFileAge: TDateTime;
  msg: string;
  WaitMilliseconds: integer;
  installRunParams: string;
  json: TJsonObject;
  SkipBackup: boolean;
  TimeZoneOk: boolean;
  tzRec: TTimeZoneRec;
  AllDBsLocked: boolean;
  LockedDbList: TStringList;
  fFileAge: integer;
  UpdateStore: TUpdateStore;
  ERPVersion: string;
  CustomConfigVersion: string;
  NewVersion: string;
  x, y: integer;
  custList,
  custItem, cutItemVer: TJsonObject;
  custItemName: string;
const
  FiveMins = 1000 * 60 * 5;

  function LockDb(aDatabase: string; LockReason: string = 'Performing a Database Update'): boolean;
  var
    s: string;
    LockedUser, LockedReason: string;
  begin
    result:= true;
    if TSharedAppUserList.ExLocked(aDatabase,fMySQLServer,LockedReason,LockedUser) then begin
      result := false;
      Log('Could not update ' + aDatabase + ', could not lock database login: ' + LockedReason,ltWarning);
      Exit;
    end;

    if not TSharedAppUserList.ExAddUser(s,ERP_ADMIN_USER,aDatabase,fMySQLServer,'','','',false,true) then begin
      result:= false;
      Log('Could not update ' + aDatabase + ': ' + s,ltWarning);
      Exit;
    end;
    if not TSharedAppUserList.ExLockLogon(s,ERP_ADMIN_USER,aDatabase,LockReason,fMySQLServer) then begin
      result:= false;
      TSharedAppUserList.ExRemoveUser(ERP_ADMIN_USER,fMySQLServer,aDatabase);
      Log('Could not update ' + aDatabase + ', could not lock database login: ' + s,ltWarning);
    end
    else
      LockedDbList.Add(aDatabase);
  end;

  procedure UnlockDb(aDatabase: string);
  begin
    { this also unlocks user logon }
    TSharedAppUserList.ExRemoveUser(ERP_ADMIN_USER, fMySQLServer, aDatabase);
  end;

  procedure DoDecrypt(InFileName, OutFileName: string);
  var
    TryCount: integer;
  begin
    TryCount := 0;
    while true do begin
      try
        Inc(TryCount);
        CipherUtils.Decrypt(InFileName, OutFileName);
        break;
      except
        on e: exception do begin
          if TryCount < 7 then begin
            Sleep(1000 * 10);
          end
          else begin
            raise;
          end;
        end;
      end;
    end;
  end;

begin
  Result := True;
  TimeZoneOk := False;
  try
    Log('', ltInfo);
    Log('**** Update check started ****', ltInfo);
    try
      DoDbUpdates := True;

      if Trim(fSoftwareReleaseType) = '' then begin
        Result := False;
        Log('The Software Release Type is blank, unable to check for updates', ltWarning);
        Exit;
      end;

      UpdateBaseDir := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Updates\';
      if not ForceDirectories(UpdateBaseDir) then begin
        Result := False;
        Log('Could not create download directory: ' + UpdateBaseDir, ltError);
        Exit;
      end;

      if not TFileDownloader.DownloadFile(WebUpdatesURL + 'erpupdatedetails.dat',
          UpdateBaseDir + 'erpupdatedetails.dat', frReplaceIfNewer, False) then begin
        Result := False;
        Log('Could not download update information file from the internet.', ltError);
        Exit;
      end;

      EncryptedFileToJson(UpdateInfo,UpdateBaseDir + 'erpupdatedetails.dat');
      verList := UpdateInfo.O['updates'].O['erpdatabase'].O['versions'].O[fSoftwareReleaseType];
      if verList.Count = 0 then begin
        Log('No database updates found for release type : "' + fSoftwareReleaseType + '"', ltInfo);
        DoDbUpdates := False;
      end;

      UpdateFilePath := Self.TempPath + 'ErpTempUpdate\';
      if not ForceDirectories(UpdateFilePath) then begin
        Result := False;
        Log('Could not create tempory directory for update files: ' + UpdateFilePath, ltError);
        DoDbUpdates := False;
      end;

      if DoDbUpdates then begin
        if DatabaseList.A['List'].Count = 0 then begin
          { if nothing specified, get list of all databases }
          dbList := TStringList.Create;
          try
            dbList.CommaText := Backup.DatabaseList(True);
            if dbList.IndexOf('erpnewdb') >= 0 then begin
              { make sure that erpnewdb is always updated first .. }
              dbList.Delete(dbList.IndexOf('erpnewdb'));
              dbList.Insert(0, 'erpnewdb');
            end;
            for dbIdx := 0 to dbList.Count - 1 do begin
              json := JO;
              json.S['DatabaseName'] := dbList[dbIdx];
              DatabaseList.A['List'].Add(json);
            end;
          finally
            dbList.Free;
          end;
        end;

        AllDbsLocked := True;
        LockedDbList := TStringList.Create;
//
//        for dbIdx := 0 to DatabaseList.A['List'].Count - 1 do begin
//          if not LockDb(DatabaseList.A['List'].Items[dbIdx].AsObject.S['DatabaseName']) then begin
//            AllDbsLocked := false;
//            Break;
//          end;
//        end;

        try
//          if AllDBsLocked then begin
            for dbIdx := 0 to DatabaseList.A['List'].Count - 1 do begin
              if not LockDb(DatabaseList.A['List'].Items[dbIdx].AsObject.S['DatabaseName']) then Continue;

              CurrentDatabaseUpdateOk := True;
              CurrentDatabase := DatabaseList.A['List'].Items[dbIdx].AsObject.S['DatabaseName'];
              Backup.DatabaseName := CurrentDatabase;
              CurrentVersion := Backup.DatabaseVersion;
              Log('Checking: ' + CurrentDatabase + ' Ver: ' + CurrentVersion, ltInfo);
              if not TimeZoneOK then begin
                { make sure computer and MySQL time zones are the same }
                tzRec := Backup.GetTimeZoneInfo;
                if tzRec.ok then begin
                  if Math.SameValue(tzRec.TimeZone, tzRec.MySQLTimeZone, 0.006) then
                    TimeZoneOk := true
                  else begin
                    Log('Unable to check Database Time Zones as the Server and MySQL are set to different Time Zones. Please stop and restart MySQL.', ltError);
                    if tzRec.TimeZone >= 0 then
                      Log('Server Time Zone: GMT + ' + FormatDateTime('hh:nn', RoundTimeToMinutes(tzRec.TimeZone)), ltError)
                    else
                      Log('Server Time Zone: GMT - ' + FormatDateTime('hh:nn', RoundTimeToMinutes(Abs(tzRec.TimeZone))), ltError);
                    if tzRec.MySQLTimeZone >= 0 then
                      Log('MySQL Time Zone: GMT + ' + FormatDateTime('hh:nn', RoundTimeToMinutes(tzRec.MySQLTimeZone)), ltError)
                    else
                      Log('MySQL Time Zone: GMT - ' + FormatDateTime('hh:nn', RoundTimeToMinutes(Abs(tzRec.MySQLTimeZone))), ltError);
                  end;
                end
                else
                  Log('Unable to read Time Zone Information', ltWarning);
              end;
              if TimeZoneOK then begin
                tzRec := Backup.GetTimeZoneInfo;
                if tzRec.ok then begin
                  { check the database time zone }
                  Log('Checking database Time Zone ..', ltInfo);
                  if not Math.SameValue(tzRec.TimeZone, tzRec.DbTimeZone, 0.006) then begin
                    Log('Database Time Zone is different, needs updating.', ltInfo);
//                    if LockDb(CurrentDatabase,'Updating Time Zone') then begin
                      try
                        Backup.CheckAndAdjustTimeZone;
                        Log('Time Zone changed.', ltInfo);
                      finally
//                        UnlockDB(CurrentDatabase);
                      end;
//                    end;
                  end
                  else
                    Log('Time Zone Ok', ltInfo);
                end
                else
                  Log('Unable to read Time Zone Information', ltWarning);
              end;

  //            if (CurrentVersion < verList.Items[verList.Count-1].Name) and
  //               (CurrentVersion >= verList.Items[0].Name) then begin
              if (VersionUtils.VersionComp(CurrentVersion, verList.Items[verList.Count-1].Name) < 0) and
                 (VersionUtils.VersionComp(CurrentVersion, verList.Items[0].Name) >= 0) then begin
                { db needs to be updated }
//                if LockDb(CurrentDatabase) then begin
                  Log('Database: ' + CurrentDatabase + ' needs updating', ltInfo);
                  try
                    SkipBackup :=
                      (DatabaseList.A['List'].Items[dbIdx].AsObject.BooleanExists('SkipBackup') and
                      (DatabaseList.A['List'].Items[dbIdx].AsObject.B['SkipBackup'] = True));
                    { backup the db }
                    if (not SkipBackup) then begin
                      if not Backup.Backup then begin
                        Log('Backup failed, aborting update of this database.', ltError);
                        Continue;  { backup failed so go on and check next database in the list }
                      end;
                    end;
                    if DatabaseList.A['List'].Items[dbIdx].AsObject.StringExists('ArchiveFileName') then
                      Backup.BackupArchiveFileName := Backup.BackupPath + DatabaseList.A['List'].Items[dbIdx].AsObject.S['ArchiveName'];
                    try
                      { backed up ok so start updates }
                      for updateIdx := 0 to verList.Count - 1 do begin
                        { step through updates and apply them in order }
  //                      if CurrentVersion < verList.Items[updateIdx].Name then begin
                        if VersionUtils.VersionComp(CurrentVersion, verList.Items[updateIdx].Name) < 0 then begin
                          Log('Starting update to version: ' + verList.Items[updateIdx].Name, ltInfo);

                          { get update files }
                          verItem := verList.Items[updateIdx].Value.AsObject;

                          DeleteFiles(UpdateFilePath, '*.*');

                          for partIdx:= 0 to verItem.O['parts'].Count - 1 do begin
                            { step through the parts of each update }
                            if not CurrentDatabaseUpdateOk then
                              break;
                            verPart := verItem.O['parts'].Items[partIdx].Value.AsObject;
                            installFileName:= ExtractFileNameEx(verPart.S['file']);
                            { added retry functionality here for clients who have dodgy internet }
                            if not TFileDownloader.DownloadFile(WebUpdatesURL + verPart.S['file'],
                              UpdateFilePath + installFileName, frReplaceAlways, false) then begin
                              Log('Could not download new file version from the internet, file: "'+
                                verPart.S['file'] + '". Retrying in a few seconds.', ltWarning);
                              Sleep(3000);

                              if not TFileDownloader.DownloadFile(WebUpdatesURL + verPart.S['file'],
                                UpdateFilePath + installFileName, frReplaceAlways, false) then begin
                                Log('Could not download new file version from the internet, file: "'+
                                  verPart.S['file'] + '". Retrying in a few seconds.', ltWarning);
                                Sleep(3000);

                                if not TFileDownloader.DownloadFile(WebUpdatesURL + verPart.S['file'],
                                  UpdateFilePath + installFileName, frReplaceAlways, false) then begin
                                  Log('Could not download new file version from the internet, file: "'+
                                    verPart.S['file'] + '".',ltError);
                                  Result:= False;
                                  CurrentDatabaseUpdateOk := False;
                                  Break;
                                end;
                              end;
                            end;

                            try
                              { what sort of update part is this ... }
                              if verPart.S['type'] = 'db' then begin
                                UpdateFileName:= ChangeFileExt(UpdateFilePath + installFileName,'.sql');
                                UpdateType:= dutDb;
                              end
                              else if verPart.S['type'] = 'templates' then begin
                                UpdateFileName:= ChangeFileExt(UpdateFilePath + installFileName,'.ptd');
                                UpdateType:= dutDbTemplates;
                              end
                              else if verPart.S['type'] = 'innosetup' then begin
                                UpdateFileName:= ChangeFileExt(UpdateFilePath + installFileName,'.exe');
                                UpdateType:= dutInnoSetup;
                              end
                              else begin
                                Log('Unrecognised update part type "' + verPart.S['type'] + '"', ltWarning);
                                UpdateType:= dutUnknown;
                              end;
                              { decrypt file }
                              // CipherUtils.Decrypt(UpdateFilePath + installFileName, UpdateFileName);
                              DoDecrypt(UpdateFilePath + installFileName, UpdateFileName);
                              try
                                if UpdateType in [dutDb, dutDbTemplates] then begin
                                  { now do the actual updates }
                                  try
                                    Updater := TDbUpdater.Create(fMySQLServer);
                                    Updater.Logger := fLogger;
                                    Updater.OnLog := self.Log;
                                    try
                                      if not Updater.UpdateDatabase(UpdateType,CurrentDatabase,UpdateFileName) then begin
                                        CurrentDatabaseUpdateOk := False;
                                        Log('Update failed, skipping this database.',ltError);
                                        Break;
                                      end;
                                    finally
                                      Updater.Free;
                                    end;
                                  except
                                    on e: exception do begin
                                      CurrentDatabaseUpdateOk:= false;
                                      Log('Exception error while upating database with message: ' + e.Message,ltError);
                                      Break;
                                    end;
                                  end;

                                end
                                else if UpdateType = dutInnoSetup then begin

                                  { run new install and wait }
                                  Log('    Running update script: "' + UpdateFileName +'"' , ltInfo);
                                  WaitMilliseconds:= FiveMins;
                                  installRunParams:= '  /VERYSILENT';
                                  if verPart.StringExists('installpassword') then
                                    installRunParams:= installRunParams + ' /PASSWORD=' + verPart.S['installpassword'];
                                  installRunParams:= installRunParams + ' /NOCANCEL /NORESTART';
                                  if verPart.IntegerExists('waitmilliseconds') then
                                    WaitMilliseconds:= verPart.I['waitmilliseconds'];
                                  if not AppRunUtils.ExecNewProcess(UpdateFileName + installRunParams, true, WaitMilliseconds) then begin
                                    CurrentDatabaseUpdateOk:= false;
                                    Log('Update failed, timed out waiting for installer to run, skipping this database.', ltError);
                                    Break;
                                  end;

                                end;
                              finally
                                sysutils.DeleteFile(UpdateFileName);
                              end;
                            finally
                              sysutils.DeleteFile(UpdateFilePath + installFileName);
                            end;
                          end;
                          if CurrentDatabaseUpdateOk then begin
                            CurrentVersion:= verList.Items[updateIdx].Name;
                            Log('    Update finished.', ltInfo);
                          end
                          else begin
                            Log('    Update failed.', ltError);
                            break;
                          end;
                        end;
                      end;
                    except
                      on e: exception do begin
                        CurrentDatabaseUpdateOk:= false;
                        Log('Exception during update with message: ' + e.Message, ltError);
                      end;
                    end;

                    if not CurrentDatabaseUpdateOk then begin
                      if SkipBackup and (Backup.BackupArchiveFileName = '') then begin
                        Log('Update failed, please restore database from backup.', ltError);
                      end
                      else begin
                        Log('Restoring previous version', ltInfo);
                        if Backup.BackupArchiveFileName <> '' then begin
                          if not Backup.Restore(Backup.BackupArchiveFileName) then begin
                            Log('Error occured while restoring previous version backup.',ltError);
                          end;
                        end
                        else begin
                          Log('Unable to restore previous version database.', ltError);
                        end;
                      end;
                    end
                    else begin
                      Log('All updates on database: ' + CurrentDatabase + ' finished.', ltInfo);
                    end;
                  finally
//                    UnlockDb(CurrentDatabase);
                  end;
//                end;
              end
              else begin
                if CurrentVersion = verList.Items[verList.Count-1].Name then begin
                  Log('Database does not require updating.', ltInfo);
                end
                else begin
//                  result:= false;
                  Log('Current database version is outside range of available updates for release type: "' + fSoftwareReleaseType + '"',ltError);
//                  break;
                end;
              end;

              UnlockDb(LockedDbList[dbIdx]);

            end; { for }
          //end;   { dbList }
        finally
//          for dbIdx:= 0 to DatabaseList.A['List'].Count -1 do
          for dbIdx := 0 to LockedDbList.Count - 1 do
//            UnlockDb(DatabaseList.A['List'].Items[dbIdx].AsObject.S['DatabaseName']);
            UnlockDb(LockedDbList[dbIdx]);

          LockedDbList.Free;
        end;

      end; { DoDbUpdates }

      { now download latest client versions }
      Log('Checking for User updates.', ltInfo);

      verList := UpdateInfo.O['updates'].O['erp'].O['versions'].O[fSoftwareReleaseType];
      if verList.Count = 0 then begin
        Log('No user updates found for release type : "' + fSoftwareReleaseType + '"', ltInfo);
        Exit;
      end;
      { just get latest }
      updateIdx := verList.Count - 1;
      if updateIdx >= 0 then begin
        verItem := verList.Items[updateIdx].Value.AsObject;
        for partIdx := 0 to verItem.O['parts'].Count - 1 do begin
          { step through the parts }
          verPart := verItem.O['parts'].Items[partIdx].Value.AsObject;

          UpdateFileName:= UpdateBaseDir + fSoftwareReleaseType + '\' +
            StringReplace(verPart.S['file'], '/', '\', [rfReplaceAll]);
          if not ForceDirectories(ExtractFilePath(UpdateFileName)) then begin
            Log('Unable to create updates directory: ' + ExtractFilePath(UpdateFileName) ,ltError);
            Exit;
          end;

          if not FileExists(UpdateFileName) then begin
            Log('Downloading file: "'+ verPart.S['file'] + '" ...', ltInfo);
            if not TFileDownloader.DownloadFile(WebUpdatesURL + verPart.S['file'],
              UpdateFileName, frReplaceAlways,false,DoDownloadProgress) then begin
              Log('Could not download new file version from the internet, file: "'+
                verPart.S['file'] + '".', ltError);
              SysUtils.DeleteFile(UpdateFileName);
            end
            else begin
              try
                SaveUpdateToDb('erp', verList.Items[updateIdx].Name, verItem.O['parts'].Items[partIdx].Name, verPart.AsString, UpdateFileName);
              except
                on e: exception do begin
                  Log('Could not save erp update into database with error :' + e.Message ,ltError);
                  SysUtils.DeleteFile(UpdateFileName);
                end;
              end;
            end;
          end;
        end;
      end;

//      { now download latest True ERP Messages versions }
//      Log('Checking for True ERP Messages updates.', ltInfo);
//
//      verList:= UpdateInfo.O['updates'].O['TrueERPMessages'].O['versions'].O['all'];
//      if verList.Count = 0 then begin
//        Log('No True ERP Messages update found for release type : "' + 'all' + '"', ltInfo);
//        Exit;
//      end;
//      { just get latest }
//      updateIdx:= verList.Count - 1;
//      if updateIdx >= 0 then begin
//
//        verItem:= verList.Items[updateIdx].Value.AsObject;
//        for partIdx:= 0 to verItem.O['parts'].Count -1 do begin
//          { step through the parts }
//          verPart:= verItem.O['parts'].Items[partIdx].Value.AsObject;
//
//          UpdateFileName:= UpdateBaseDir + 'all' + '\' +
//            StringReplace(verPart.S['file'],'/','\',[rfReplaceAll]);
//          if not ForceDirectories(ExtractFilePath(UpdateFileName)) then begin
//            Log('Unable to create updates directory: ' + ExtractFilePath(UpdateFileName) ,ltError);
//            Exit;
//          end;
//
//          if not FileExists(UpdateFileName) then begin
//            Log('Downloading file: "'+ verPart.S['file'] + '" ...', ltInfo);
//            if not TFileDownloader.DownloadFile(WebUpdatesURL + verPart.S['file'],
//              UpdateFileName,frReplaceAlways,false,DoDownloadProgress) then begin
//              Log('Could not download new file version from the internet, file: "'+
//                verPart.S['file'] + '".',ltError);
//              SysUtils.DeleteFile(UpdateFileName);
//            end
//            else begin
//              try
//                SaveUpdateToDb('TrueERPMessages',verList.Items[updateIdx].Name,verItem.O['parts'].Items[partIdx].Name,verPart.AsString,UpdateFileName);
//              except
//                on e: exception do begin
//                  Log('Could not save erp update into database with error :' + e.Message ,ltError);
//                  SysUtils.DeleteFile(UpdateFileName);
//                end;
//              end;
//            end;
//          end;
//        end;
//      end;

      { now download latest client updater }
      Log('Checking for latest ERP Client Updater.', ltInfo);
      {$WARNINGS OFF}
      fFileAge := FileAge(UpdateBaseDir + 'ERPClientUpdater.exe');
      {$WARNINGS ON}
      if not TFileDownloader.DownloadFile(WebUpdatesURL + 'ERPClientUpdater.exe',
        UpdateBaseDir + 'ERPClientUpdater.exe',frReplaceIfNewer,false) then begin
        Log('Could not download new ERP Client Updater from the internet.', ltError);
      end
      else begin
        {$WARNINGS OFF}
        if fFileAge <> FileAge(UpdateBaseDir + 'ERPClientUpdater.exe') then begin
        {$WARNINGS ON}
          CurrentVersion := FileVersion.GetFileVersion(UpdateBaseDir + 'ERPClientUpdater.exe');
          try
            SaveUpdateToDb('ERPClientUpdater', CurrentVersion, '1', '', UpdateBaseDir + 'ERPClientUpdater.exe');
          except
            on e: exception do begin
              Log('Could not save ERP Client Updater update into database with error :' + e.Message, ltError);
              //SysUtils.DeleteFile(UpdateBaseDir + 'ERPClientUpdater.exe');
            end;
          end;
        end;
      end;

      { now download latest custom config versions }
      Log('Checking for Configuration updates.', ltInfo);
      UpdateStore := TUpdateStore.Create;
      try
        UpdateStore.Server := fMySQLServer;
        ERPVersion := UpdateStore.VersionForName('erp');
        if ERPVersion <> '' then begin
          custList:= UpdateInfo.O['updates'].O['CustomConfig'];
          for x := 0 to custList.Count - 1 do begin
            verItem := nil;
            custItem := custList.Items[x].Value.AsObject;
            custItemName := custList.Items[x].Name;

            try
              CustomConfigVersion := UpdateStore.VersionForName(custList.Items[x].Name);

              verList := custItem.O['Versions'];
              y := 0;
              if verList.Count > 0 then begin
                verItem := verList.Items[y].Value.AsObject;
              end;
              while y < verList.Count do begin
                case VersionUtils.VersionComp(verItem.S['erp_version'],ERPVersion) of
                  -1:
                    begin
                      Inc(y);
                    end;
                  0:
                    begin
                      //break;
                      { go to next one in case there is a newer module version for same ERP version  }
                      Inc(y);
                    end;
                  1:
                    begin
                      if y > 0 then dec(y);
                      verItem := verList.Items[y].Value.AsObject;
                      break;
                    end;
                end;
                if y < verList.Count then
                  verItem := verList.Items[y].Value.AsObject;
              end;

              if y >= verList.Count then
                y := verList.Count -1;
              if Assigned(verItem) then begin
                NewVersion := verList.Items[y].Name;
                if NewVersion <> CustomConfigVersion then begin

                  Log('Downloading new version for ' + custItemName, ltInfo);
                  if not TFileDownloader.DownloadFile(WebUpdatesURL + verItem.S['file'],
                    UpdateBaseDir + custItemName + '.dat',frReplaceAlways,false) then begin
                    Log('Could not download new '+custItemName+' from the internet.',ltError);
                  end
                  else begin
                    //CipherUtils.Decrypt(UpdateBaseDir + custItemName + '.dat', UpdateBaseDir + custItemName + '.exe');
                    DoDecrypt(UpdateBaseDir + custItemName + '.dat', UpdateBaseDir + custItemName + '.exe');
                    UpdateStore.SaveUpdate(custItemName,NewVersion,'1','',UpdateBaseDir + custItemName + '.exe');
                    SysUtils.DeleteFile(UpdateBaseDir + custItemName + '.dat');
                    SysUtils.DeleteFile(UpdateBaseDir + custItemName + '.exe');
                  end;
                end;
              end;
            except
              on e: exception do begin
                Log('Could not get latest version of '+custItemName+' with error :' + e.Message ,ltError);
              end;
            end;
          end;
        end;

      finally
        UpdateStore.Free;
      end;

      { now download latest languge update }
      Log('Checking for latest ERP language updates.', ltInfo);
      if FileExists(UpdateBaseDir + 'language.dat') then
        FileAge(UpdateBaseDir + 'language.dat',languageUpdateFileAge)
      else
        languageUpdateFileAge:= 0;
      if not TFileDownloader.DownloadFile(WebUpdatesURL + 'server/language/language.dat',
        UpdateBaseDir + 'language.dat',frReplaceIfNewer,false) then begin
        Log('Could not download new language update file.', ltError);
      end
      else begin
        FileAge(UpdateBaseDir + 'language.dat', aFileAge);
        if SecondSpan(languageUpdateFileAge ,aFileAge) > 5 then begin
          { we need to update the language database }
          if not DoLanguageUpdate(UpdateBaseDir + 'language.dat') then begin
            { update failed, so delete file to force update next time }
            SysUtils.DeleteFile(UpdateBaseDir + 'language.dat');
          end;
        end;
      end;

    finally
      Log('**** Update check finished ****', ltInfo);
      Log('', ltInfo);
    end;
  except
    on e: exception do begin
      Result := false;
      Log('Update failed with exception error message: ' + e.Message, ltError);
    end;
  end;
end;

procedure TErpDbUpdater.DoOnBackupProgress(Sender: TObject);
var
  s: string;
begin
  s:= '    ' + Backup.Progress.OperationName + ' - ' +
      Backup.Progress.SubOperationName;
  if (Backup.Progress.StepNo > 0) and (Backup.Progress.StepCount > 0) then
    s := s + ' ' + IntToStr(Backup.Progress.PercentDone) + '%';
  if LastProgress_SubOpName <> s then begin
    LastProgress_SubOpName:= s;
    Log('    ' + s, ltDetail);
  end;
end;

(*function TErpDbUpdater.DoHelpUpdate(
  const aUpdateFileName: string): boolean;
var
  conn: TMyConnection;
  qry: TMyQuery;
  doUpdate: boolean;
  tempzipfile: string;
  UnZip: TAbUnZipper;
  dbDump: TMyDump;
begin
  result:= true;
  try
    conn:= TMyConnection.Create(nil);
    qry:= TMyQuery.Create(nil);
    try
      doUpdate:= true;
      ModuleDbUtils.InitialiseConnection(conn,'localhost','apphelp');
      conn.Connect;
      qry.Connection:= conn;
      qry.SQL.Text:= 'select value from config where name = "AllowAutoUpdate"';
      try
        qry.Open;
        doUpdate:= Lowercase(qry.FieldByName('Value').AsString) <> 'false';
        qry.Close;
      except
        { probably only ERP head office database will have this table }
      end;
      if not doUpdate then begin
        Log('Help update is turned off on this server.', ltInfo);
        Exit;
      end;

      Log('Started update on help database.', ltInfo);
      tempzipfile:= self.TempPath + 'helptree.zip';
      SysUtils.DeleteFile(tempzipfile);
      SysUtils.DeleteFile(TempPath + HELP_SQL_FILE);
      Log('    Decrypting files ...', ltInfo);
      CipherUtils.Decrypt(aUpdateFileName, tempzipfile);
      try

        Log('    Extracting files ...', ltInfo);
        UnZip:= TAbUnZipper.Create(nil);
        try
          UnZip.BaseDirectory:= TempPath;
          UnZip.FileName:= tempzipfile;
          UnZip.ExtractFiles(HELP_SQL_FILE);
        finally
          UnZip.Free;
        end;

        Log('    Applying updates to database ...', ltInfo);
        dbDump:= TMyDump.Create(nil);
        try
          dbDump.Connection:= conn;
//          dbDump.SQL.LoadFromFile(TempPath + HELP_SQL_FILE);
//          dbDump.SQL.Insert(0,'delete from helptree;');
          dbDump.SQL.Add('delete from helptree;');
          dbDump.Restore;
          dbDump.RestoreFromFile(TempPath + HELP_SQL_FILE);

        finally
          dbDump.Free;
        end;

      finally
        SysUtils.DeleteFile(tempzipfile);
        SysUtils.DeleteFile(TempPath + HELP_SQL_FILE);
      end;
      Log('Finished update on help database.', ltInfo);


    finally
      qry.Free;
      conn.Free;
    end;
  except
    on e: exception do begin
      result:= false;
      Log('Error while applying help updates with message: ' + e.Message,ltError);
    end;
  end;
end;*)

function TErpDbUpdater.DoLanguageUpdate(const aUpdateFileName: string): boolean;
var
  conn: TMyConnection;
  qry: TMyQuery;
  doUpdate: boolean;
  tempzipfile: string;
  UnZip: TAbUnZipper;
  dbDump: TMyDump;
begin
  result:= true;
  try
    conn:= TMyConnection.Create(nil);
    qry:= TMyQuery.Create(nil);
    try
      doUpdate:= true;
      ModuleDbUtils.InitialiseConnection(conn,fMySQLServer,LANGUAGE_DATABASE);
      try
        conn.Connect;
      except
        on e: exception do begin
          result:= false;
          Log('Error connecting to language database with message: '+ e.Message, ltWarning);
          Exit;
        end;
      end;
      qry.Connection:= conn;
      qry.SQL.Text:= 'select configvalue from tblconfig where name = "AllowAutoUpdate"';
      try
        qry.Open;
        doUpdate:= Lowercase(qry.FieldByName('ConfigValue').AsString) <> 'false';
        qry.Close;
      except
        { probably only ERP head office database will have this table }
      end;
      if not doUpdate then begin
        Log('Language update is turned off on this server.', ltInfo);
        Exit;
      end;

      Log('Started update on language database.', ltInfo);
      tempzipfile:= self.TempPath + 'language.zip';
      SysUtils.DeleteFile(tempzipfile);
      SysUtils.DeleteFile(TempPath + LANGUAGE_SQL_FILE);
      Log('    Decrypting files ...', ltInfo);
      CipherUtils.Decrypt(aUpdateFileName, tempzipfile);
      try

        Log('    Extracting files ...', ltInfo);
        UnZip:= TAbUnZipper.Create(nil);
        try
          UnZip.BaseDirectory:= TempPath;
          UnZip.FileName:= tempzipfile;
          UnZip.ExtractFiles(LANGUAGE_SQL_FILE);
        finally
          UnZip.Free;
        end;

        Log('    Applying updates to database ...', ltInfo);
        dbDump:= TMyDump.Create(nil);
        try
          dbDump.Connection:= conn;
          dbDump.RestoreFromFile(TempPath + LANGUAGE_SQL_FILE);
//          dbDump.SQL.LoadFromFile(TempPath + LANGUAGE_SQL_FILE);
          dbDump.SQL.Clear;
          dbDump.SQL.Add('insert ignore into   `languagetranslation` (LanguageID ,EnglishID ,Translation) Select LanguageID ,EnglishID ,Translation from `languagetranslationlocal` where modified = "T";');
          dbDump.SQL.Add('update `languagetranslation` LT inner join `languagetranslationlocal` LTL on LT.LanguageID = LTL.LanguageID and LT.EnglishID = LTL.EnglishID  and LT.Translation = LTL.Translation  Set LTL.Modified = "F" ;');
          dbDump.SQL.Add('delete from languagetranslationlocal where modified = "F" or ifnull(Translation,"") = "";');
          dbDump.SQL.Add('update `languagetranslation` LT inner join `languagetranslationlocal` LTL on LT.LanguageID = LTL.LanguageID and LT.EnglishID = LTL.EnglishID  Set LT.Translation = LTL.Translation where LTL.Modified = "T";');
          dbDump.Restore;

        finally
          dbDump.Free;
        end;

      finally
        SysUtils.DeleteFile(tempzipfile);
        SysUtils.DeleteFile(TempPath + LANGUAGE_SQL_FILE);
      end;
      Log('Finished update on language database.', ltInfo);


    finally
      qry.Free;
      conn.Free;
    end;
  except
    on e: exception do begin
      result:= false;
      Log('Error while applying language updates with message: ' + e.Message,ltError);
    end;
  end;
end;

procedure TErpDbUpdater.DoDownloadProgress(percent: integer);
begin
  if fDownloadPercent <> percent then begin
    fDownloadPercent:= percent;
    Log('Download progress: '+ IntToStr(percent) + '%',ltDetail);
  end;
end;

end.

