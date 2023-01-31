unit INIFileObj;

interface

Uses Classes;

type
  TinifileObj = class(TComponent)
  private
    {General}
    fMySQLServer :String;
    fMode :String;
    fExcludeDBList :TStringList;
    {Email}
    fTryForDays :String;
    {Fax}
    fComport :String;
    fFaxName :String;
    procedure LoadValue(const Name: string; var Value: String); Overload;
    procedure StoreValue(const Name: string; const Value: String); Overload;
    procedure LoadValue(const Name: string; var Value: TStringList); Overload;
    procedure StoreValue(const Name: string; const Value: TStringList); Overload;
    function GetINI_Value(const Name: string): string;
    procedure SetINI_Value(const Name: string; const Value: string);
  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
    procedure Load;
    procedure Save;
   {General}
    Property MySQLServer :String Read fMySQLServer Write fMySQLServer;
    Property Mode :String Read fMode Write fMode;
    Property ExcludeDBList:TStringList Read fExcludeDBList Write fExcludeDBList;
    {Email}
    Property TryForDays :String Read fTryForDays Write fTryForDays;
    {Fax}
    Property Comport :String Read fComport Write fComport;
    Property FaxName :String Read fFaxName Write fFaxName;

  end;

implementation

Uses Forms, SysUtils, SyncObjs, IniFiles, FileCipherObj, EmailFaxServerLib,
  FastFuncs;

Var
  LockAllThreads: TCriticalSection;

{ TinifileObj }

constructor TinifileObj.Create(AOwner: TComponent);
begin
  inherited;
  fExcludeDBList := TStringList.Create;
  fExcludeDBList.Delimiter := '|';
  Load;
end;

destructor TinifileObj.Destroy;
begin
  FreeAndNil(fExcludeDBList);
  inherited;
end;


function TinifileObj.GetINI_Value(const Name: string): string;
var
  MyIniFile: TMemIniFile;
  InMem,OutMem: TMemoryStream;
  FileCipher: TFileCipherObj;
begin
  LockAllThreads.Acquire;
  Try
    InMem := TMemoryStream.Create;
    OutMem := TMemoryStream.Create;
    FileCipher := TFileCipherObj.Create(nil);
    try
      If SysUtils.FileExists(ExtractFilePath(Application.ExeName)+INI_FileName) then
        InMem.LoadFromFile(ExtractFilePath(Application.ExeName)+INI_FileName);
      InMem.Position := 0;
      If InMem.Size >0 then
        FileCipher.Decrypt(InMem,OutMem);
      OutMem.Position := 0;
      OutMem.SaveToFile(TempDir + INI_FileName);
    finally
      FreeAndNil(InMem);
      FreeAndNil(OutMem);
      FreeAndNil(FileCipher);
    end;
    MyIniFile := TMemIniFile.Create(TempDir + INI_FileName);
    try
      Result := MyIniFile.ReadString('Setup', Name, '');
    finally
      FreeAndNil(MyIniFile);
    end;
    SysUtils.DeleteFile(TempDir + INI_FileName);
  finally
    LockAllThreads.Release;
  end;
end;

procedure TinifileObj.SetINI_Value(const Name, Value: string);
var
  MyIniFile: TMemIniFile;
  InMem,OutMem: TMemoryStream;
  FileCipher: TFileCipherObj;
begin
  LockAllThreads.Acquire;
  Try
    InMem := TMemoryStream.Create;
    OutMem := TMemoryStream.Create;
    FileCipher := TFileCipherObj.Create(nil);
    try
      If SysUtils.FileExists(ExtractFilePath(Application.ExeName)+INI_FileName) then
        InMem.LoadFromFile(ExtractFilePath(Application.ExeName)+INI_FileName);
      InMem.Position := 0;
      If InMem.Size >0 then
        FileCipher.Decrypt(InMem,OutMem);
      OutMem.Position := 0;
      OutMem.SaveToFile(TempDir + INI_FileName);
    finally
      FreeAndNil(InMem);
      FreeAndNil(OutMem);
      FreeAndNil(FileCipher);
    end;
    MyIniFile := TMemIniFile.Create(TempDir + INI_FileName);
    try
      MyIniFile.WriteString('Setup', Name, Value);
      MyIniFile.UpdateFile;
    finally
      FreeAndNil(MyIniFile);
    end;
    InMem := TMemoryStream.Create;
    OutMem := TMemoryStream.Create;
    FileCipher := TFileCipherObj.Create(nil);
    try
      InMem.LoadFromFile(TempDir + INI_FileName);
      InMem.Position := 0;
      FileCipher.Encrypt(InMem,OutMem);
      OutMem.Position := 0;
      OutMem.SaveToFile(ExtractFilePath(Application.ExeName)+INI_FileName);
    finally
      FreeAndNil(InMem);
      FreeAndNil(OutMem);
      FreeAndNil(FileCipher);
    end;
    SysUtils.DeleteFile(TempDir + INI_FileName);
  finally
    LockAllThreads.Release;
  end;
end;

procedure TinifileObj.Load;
begin
  {General}
  LoadValue('MySQLServer',fMySQLServer);
  If Empty(fMySQLServer) then fMySQLServer := 'localhost';
  LoadValue('Mode',fMode);
  If Empty(fMode) then fMode := 'None';
  LoadValue('ExcludeDBList',fExcludeDBList);
  {Email}
  LoadValue('TryForDays',fTryForDays);
  If Empty(fTryForDays) then fTryForDays := '2';
  {Fax}
  LoadValue('Comport',fComport);
  If Empty(fComport) then fComport := '3';
  LoadValue('FaxName',fFaxName);
  If Empty(fFaxName) then fFaxName := 'CompanyFax';
end;

procedure TinifileObj.Save;
begin
  {General}
  StoreValue('MySQLServer',fMySQLServer);
  StoreValue('Mode',fMode);
  StoreValue('ExcludeDBList',fExcludeDBList);
  {Email}
  StoreValue('TryForDays',fTryForDays);
  {Fax}
  StoreValue('Comport',fComport);
  StoreValue('FaxName',fFaxName);
end;

procedure TinifileObj.LoadValue(const Name: string; var Value: TStringList);
Var
  tmpStr: String;
begin
  tmpStr := GetINI_Value(Name);
  Value.Clear;
  Value.Delimiter := '|';  
  Value.DelimitedText := tmpStr;
end;

procedure TinifileObj.StoreValue(const Name: string; const Value: TStringList);
Var
  tmpStr: String;
begin
  Value.Delimiter := '|';
  tmpStr := Value.DelimitedText;
  SetINI_Value(Name, tmpStr);
end;

procedure TinifileObj.LoadValue(const Name: string; var Value: String);
begin
  Value := GetINI_Value(Name)
end;

procedure TinifileObj.StoreValue(const Name, Value: String);
begin
  SetINI_Value(Name, Value);
end;

initialization
  LockAllThreads := TCriticalSection.Create;
finalization
  LockAllThreads.Free;
end.
