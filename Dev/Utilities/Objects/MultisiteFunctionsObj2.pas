unit MultisiteFunctionsObj2;

interface

uses Classes, SysUtils, MyAccess;

type

  TDBTableInfo = class(TStringList)
  private
    FIndex: integer;
    myQuery: TmyQuery;
    ADOQuery: TMyQuery;
    function GetFields(const aTableName: string): TStringList;
  protected
  public
    constructor Create(const MyConnection: TMyConnection);
    destructor Destroy; override;
    function FindTable(const aTableName: string): integer;      // sets Index
    function FindField(const aTableName, aFieldName: string): integer; // based on table[Index]
    function GetPrimaryKey(const aTableName: string): string;
    function IsNullableField(const aTableName, aFieldName: string): boolean;
    property Strings[Index: integer]: string read Get write Put; default;
    property Fields[const TableName: string]: TStringList read GetFields;
  end;

  // simplify adding entries to either 'tblToDo' or 'tblmsEventLog'
  TmsUtils = class
  private
    myQuery: TmyQuery;
    myCommand: TmyCommand;
    qryMsLogEvent: TmyQuery;
  public
    constructor Create(MyConnection: TMyConnection);
    destructor Destroy; override;
    procedure AddToDo(const EmployeeID: integer; const txt: string; const DueDate: TDateTime);
    function AddToDoByFormAccessRight(const FormName, txt: string; const DueDate: TDateTime): integer;
    procedure MSLogAddReceived(const siteCodeFrom, EventText: string);
    procedure MSLogAddSent(const rcdCount: integer; EventText: string);
    procedure MSLogAddConflict(const siteCodeFrom, cfTable, cfGR, cfDetail: string; const cfTimeStamp: TDateTime);
  end;

function escapeForMySQL(const s: string): string;


implementation

uses FastFuncs,ComObj, Variants, OleServer, Dialogs, StrUtils,  DB,
  CommonDbLib, AppEnvironment;


  // prepare StringFields for embedding into a MySQL-command (insert / update)
function escapeForMySQL(const s: string): string;
const
  thechar        = '\"'''#13#10#9;
  thereplacement = '\"''rnt';
var 
  i, p: integer;
begin
  Result := '';
  for i := 1 to FastFuncs.StrLength(s) do begin
    p := FastFuncs.PosEx(s[i], thechar);
    if p > 0 then Result := Result + '\' + thereplacement[p]
    else Result := Result + s[i];
  end;
end;

{ TDBTableInfo ----------------------------------------------------------------}

constructor TDBTableInfo.Create(const MyConnection: TMyConnection);
var 
  i, ix: integer;
begin
  //  liTables := TStringList.Create;
  inherited Create;
  MyConnection.GetTableNames(self);
  myQuery := TMyQuery.Create(nil);
  myQuery.Options.FlatBuffers := True;
  ADOQuery := TMyQuery.Create(nil); {Temp Fixed For MYDAC Fault (Use ADO)}
  ADOQuery.Connection := GetSharedMyDACConnection;
  myQuery.Connection := MyConnection;
  for i := 0 to Count - 1 do begin
    self.Objects[i]   := TStringList.Create;
    ADOQuery.SQL.Text := 'DESCRIBE ' + self[i] + ';';
    ADOQuery.Open;
    ADOQuery.First;
    while not ADOQuery.Eof do begin
      ix := TStringList(self.Objects[i]).Add(ADOQuery.FieldByName('Field').AsString);
      // flag primary key for quick access (see GetPrimaryKey)
      if ADOQuery.FieldByName('Key').AsString = 'PRI' then TStringList(self.Objects[i]).Objects[ix] := Pointer(1);
      // flag Nullable Field for quick access (see IsNullableField)
      if ADOQuery.FieldByName('Null').AsBoolean and (TStringList(self.Objects[i]).Objects[ix] <> Pointer(1)) then
        TStringList(self.Objects[i]).Objects[ix] := Pointer(2);
      ADOQuery.Next;
    end;
  end;
  FIndex := 0;
end;

destructor TDBTableInfo.Destroy;
var 
  i: integer;
begin
  FreeandNil(ADOQuery);
  FreeandNil(myQuery);
  for i := 0 to Count - 1 do TStringList(Objects[i]).Free;
  inherited;
end;

function TDBTableInfo.FindField(const aTableName, aFieldName: string): integer;
begin
  Result := -1;
  if Strings[Findex] <> aTablename then if not Find(aTableName, FIndex) then Exit;
  Result := TStringList(Objects[FIndex]).IndexOf(aFieldName);
end;

function TDBTableInfo.FindTable(const aTableName: string): integer;
begin
  Result := IndexOf(aTableName);
  if Result >= 0 then Findex := Result;
end;

function TDBTableInfo.GetFields(const aTableName: string): TStringList;
begin
  Result := nil;
  if Strings[Findex] <> aTablename then if not Find(aTableName, FIndex) then Exit;
  if FIndex < Count then Result := TStringList(Objects[FIndex]);
end;

function TDBTableInfo.GetPrimaryKey(const aTableName: string): string;
var 
  i: integer;
begin
  Result := '';
  if Strings[Findex] <> aTablename then if not Find(aTableName, FIndex) then Exit; // ===> EXIT;
  for i := 0 to TStringList(Objects[Findex]).Count - 1 do if TStringList(Objects[Findex]).Objects[i] = Pointer(1) then begin
      Result := TStringList(Objects[Findex]).Strings[i];
      Exit;
    end;
end;

function TDBTableInfo.IsNullableField(const aTableName, aFieldName: string): boolean;
var 
  i: integer;
begin
  Result := false;
  if Strings[Findex] <> aTablename then if not Find(aTableName, FIndex) then Exit; // ===> EXIT;
  for i := 0 to TStringList(Objects[Findex]).Count - 1 do
    if (TStringList(Objects[Findex]).Objects[i] = Pointer(2)) and FastFuncs.SameText(TStringList(Objects[Findex]).Strings[i], aFieldName) then
    begin
      Result := true;
      Exit;
    end;
end;


{ TmsUtils --------------------------------------------------------------------}

constructor TmsUtils.Create(MyConnection: TMyConnection);
begin
  inherited Create;
  myQuery := TMyQuery.Create(nil);
  myQuery.Options.FlatBuffers := True;
  myQuery.Connection := MyConnection;
  myCommand := TMyCommand.Create(nil);
  myCommand.Connection := MyConnection;
  qryMsLogEvent := TMyQuery.Create(nil);
  qryMsLogEvent.Options.FlatBuffers := True;
end;


destructor TmsUtils.Destroy;
begin
  FreeandNil(qryMsLogEvent);
  FreeandNil(myQuery);
  FreeandNil(myCommand);
  inherited;  
end;


procedure TmsUtils.AddToDo(const EmployeeID: integer; const txt: string; const DueDate: TDateTime);
begin
  myCommand.SQL.Text := Format('INSERT HIGH_PRIORITY INTO tbltodo(CreatedDate, EmployeeID, Description, ToDoByDate, EditedFlag)' +
    ' VALUES("%s", "%d", "%s", "%s", "F" )', [FormatDateTime('yyyy-mm-dd', Date), EmployeeID, txt,
    FormatDateTime('yyyy-mm-dd', DueDate)]);
  myCommand.Execute;

end;


function TmsUtils.AddToDoByFormAccessRight(const FormName, txt: string; const DueDate: TDateTime): integer;
var 
  FormID: integer;
begin
  myQuery.SQL.Text := Format('SELECT FormID FROM tblforms WHERE FormName = "%s";', [FormName]);
  myQuery.Open;
  Assert(myQuery.RecordCount = 1, 'Error: Form ' + FormName + ' not found');
  FormID := myQuery.FieldByName('FormID').AsInteger;

  myQuery.Close;
  myQuery.SQL.Text := Format('SELECT EmployeeID FROM tblemployeeformsaccess ' + 'WHERE FormID = "%d";', [FormID]);
  myQuery.Open;
  Result := myQuery.RecordCount;
  myQuery.First;
  while not myQuery.Eof do begin
    AddToDo(myQuery.FieldByName('EmployeeID').AsInteger, txt, DueDate);
    myQuery.Next;
  end;
  myQuery.Close;
end;


procedure TmsUtils.MSLogAddReceived(const siteCodeFrom, eventText: string);
var
  id: integer;
begin
  myCommand.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblmseventlog( SiteCodeThis, SiteCodeFrom, ' +
    'Event, EventText, EventTimeStamp ) ' + 'VALUES("' + AppEnv.Branch.SiteCode + '", "' + siteCodeFrom +
    '", "RCVD", "' + escapeForMySQL(eventText) + '", "' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '" );';
  myCommand.Execute;
  id := myCommand.InsertId;
  myCommand.SQL.Text := 'UPDATE tblmseventlog SET GlobalRef = "' + AppEnv.Branch.SiteCode + FastFuncs.IntToStr(id) +
    '" WHERE ID = ' + FastFuncs.IntToStr(id) + ' ;';
  myCommand.Execute;
end;


procedure TmsUtils.MSLogAddSent(const rcdCount: integer; eventText: string);
var 
  id: integer;
begin
  eventText := eventText + ' RcdCount="' + FastFuncs.IntToStr(rcdCount) + '"';
  myCommand.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblmseventlog( SiteCodeThis, Event, ' + 'EventText, EventTimeStamp ) ' +
    'VALUES("' + AppEnv.Branch.SiteCode + '", "SENT", "' + escapeForMySQL(eventText) + '", "' +
    FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '" );';
  myCommand.Execute;
  id := myCommand.InsertId;
  myCommand.SQL.Text := 'UPDATE tblmseventlog SET GlobalRef = "' + AppEnv.Branch.SiteCode + FastFuncs.IntToStr(id) +
    '" WHERE ID = ' + FastFuncs.IntToStr(id) + ' ;';
  myCommand.Execute;
end;


procedure TmsUtils.MSLogAddConflict(const siteCodeFrom, cfTable, cfGR, cfDetail: string; const cfTimeStamp: TDateTime);
var 
  id: integer;
begin
  myCommand.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblmseventlog(' + 'SiteCodeThis, SiteCodeFrom, ' +
    'ConflictTable, ConflictGlobalRef, ' + 'ConflictTimeStamp, ConflictDetail, ' +
    'Event, EventText, EventTimeStamp ) ' + 'VALUES("' + AppEnv.Branch.SiteCode + '", "' + siteCodeFrom +
    '", ' + '"' + cfTable + '", "' + cfGR + '", ' + '"' + FormatDateTime('yyyy-mm-dd hh:nn:ss',
    cfTimeStamp) + '", "' + escapeForMySQL(cfDetail) + '", ' + '"CONF", "", "' + FormatDateTime('yyyy-mm-dd hh:nn:ss',
    Now) + '" );';
  myCommand.Execute;
  id := myCommand.InsertId;
  myCommand.SQL.Text := 'UPDATE tblmseventlog SET GlobalRef = "' + AppEnv.Branch.SiteCode + FastFuncs.IntToStr(id) +
    '" WHERE ID = ' + FastFuncs.IntToStr(id) + ' ;';
  myCommand.Execute;
end;

end.
