unit AppVarsObj;

interface

uses
  Classes;

type
  TAppVars = class(TObject)
  private
    fFileName: string;
    fDirty: boolean;
    fSaveOnChange: boolean;
    fEncryptFile: boolean;
    function GetVarByName(const varName: string): string;
    procedure SetVarByName(const varName, Value: string);
    function GetIntVar(const varName: string): integer;
    procedure SetIntVar(const varName: string; Value: integer);
    function GetFloatVar(const varName: string): double;
    procedure SetFloatVar(const varName: string; Value: double);
    function GetDateTimeVar(const varName: string): TDateTime;
    procedure SetDateTimeVar(const varName: string; Value: TDateTime);
    function GetBoolVar(const varName: string): boolean;
    procedure SetBoolVar(const varName: string; Value: boolean);
    procedure MakeDirty;
  public
    varList: TStringList;
    constructor Create;
    destructor Destroy; override;
    property FileName: string read fFileName write fFileName;
    property VarByName[const varName: string]: string read GetVarByName write SetVarByName; default;
    property IntVar[const varName: string]: integer read GetIntVar write SetIntVar;
    property FloatVar[const varName: string]: double read GetFloatVar write SetFloatVar;
    property DateTimeVar[const varName: string]: TDateTime read GetDateTimeVar write SetDateTimeVar;
    property BoolVar[const varName: string]: boolean read GetBoolVar write SetBoolVar;
    procedure SaveToFile(const aFileName: string = '');
    procedure LoadFromFile(const aFileName: string = '');
    function DeleteVar(const varName: string): boolean;
    function VarExists(const varName: string): boolean;
    property Dirty: boolean read fDirty;
    procedure SetDefault(const varName, Value: string);
    property SaveOnChange: boolean read fSaveOnChange write fSaveOnChange;
    property EncryptFile: boolean read fEncryptFile write fEncryptFile;
  end;

var
  AppVars: TAppVars;

implementation

uses
  SysUtils, Forms, windows;

const
  CryptoKey = 123;
  
procedure StrEncryptSave(const str, aFileName: string; const key: word = CryptoKey);
var
  i: Integer;
  st: TMemoryStream;
  b: byte;
begin
  st:= TMemoryStream.Create;
  try
    for i := 1 to Length(str) do begin
      b:= not( ord(str[I])-key );
      st.Write(b,1);
    end;
    st.Position:= 0;
    st.SaveToFile(aFileName);
  finally
    st.Free;
  end;
end;

function StrLoadDecrypt(const aFileName: string; const key: word = CryptoKey): string;
var
  i: Integer;
  st: TMemoryStream;
  b: byte;
begin
  result:= '';
  if not FileExists(aFileName) then exit;
  st:= TMemoryStream.Create;
  try
    st.LoadFromFile(aFileName);
    st.Position;
    for i:= 0 to st.Size-1 do begin
      st.Read(b,1);
      result:= result + char( not (b-key) );
    end;
  finally
    st.Free;
  end;
end;

constructor TAppVars.Create;
var
  initialFilePath: string;
  initialBuffer: array[0..260] of char;
begin
  inherited;
  fEncryptFile:= false;
  fSaveOnChange:= false;
  varList := TStringList.Create;
  // Default file name to same as exe with ini extension and in same directory.
  SetString(initialFilePath, initialBuffer,
                GetModuleFileName(0, initialBuffer, SizeOf(initialBuffer)));
  fFileName:= ChangeFileExt(initialFilePath,'.ini');
  fDirty := false;
end;

destructor TAppVars.Destroy;
begin
  FreeandNil(varList);
  inherited;
end;

function TAppVars.GetVarByName(const varName: string): string;
begin
  Result := varList.Values[varName];
end;

procedure TAppVars.SetVarByName(const varName, Value: string);
begin
  if varList.Values[varName] <> Value then begin
    varList.Values[varName] := Value;
    MakeDirty;
  end;
end;

function TAppVars.DeleteVar(const varName: string): boolean;
var
  x: integer;
begin
  Result := false;
  x := 0;
  while (not Result) and (x < varList.Count) do begin
    if varList.Names[x] = varName then begin
      varList.Delete(x);
      Result := true;
      MakeDirty;
    end else Inc(x);
  end;
end;

function TAppVars.VarExists(const varName: string): boolean;
var
  x: integer;
begin
  Result := false;
  x := 0;
  while (not Result) and (x < varList.Count) do begin
    if varList.Names[x] = varName then begin
      Result := true;
    end else Inc(x);
  end;
end;

function TAppVars.GetIntVar(const varName: string): integer;
var
  s: string;
begin
  s := VarByName[varName];
  if s = '' then Result := 0
  else Result           := StrToInt(s);
end;

procedure TAppVars.SetIntVar(const varName: string; Value: integer);
begin
  VarByName[varName] := IntToStr(Value);
end;

function TAppVars.GetFloatVar(const varName: string): double;
var 
  s: string;
begin
  s := VarByName[varName];
  if s = '' then Result := 0
  else Result           := StrToFloat(s);
end;

procedure TAppVars.SetFloatVar(const varName: string; Value: double);
begin
  VarByName[varName] := FloatToStr(Value);
end;

function TAppVars.GetDateTimeVar(const varName: string): TDateTime;
var
  s: string;
begin
  s := VarByName[varName];
  if s = '' then Result := 0
  else Result           := StrToDateTime(s);
end;

procedure TAppVars.SetDateTimeVar(const varName: string; Value: TDateTime);
begin
  VarByName[varName] := DateTimeToStr(Value);
end;

function TAppVars.GetBoolVar(const varName: string): boolean;
var 
  s: string;
begin
  s := VarByName[varName];
  Result := (s = 'True');
end;

procedure TAppVars.SetBoolVar(const varName: string; Value: boolean);
begin
  if Value then VarByName[varName] := 'True'
  else VarByName[varName]          := 'False';
end;

{ if varName not found or blank sets to value }
procedure TAppVars.SetDefault(const varName, Value: string);
begin
  if varList.Values[varName] = '' then begin
    varList.Values[varName] := Value;
    MakeDirty;
  end;
end;


procedure TAppVars.LoadFromFile(const aFileName: string);
begin
  if afileName <> '' then fFileName:= afileName;
  if FileExists(fFileName) then begin
    if self.fEncryptFile then begin
      VarList.CommaText:= StrLoadDecrypt(fFileName);
    end
    else begin
      varList.LoadFromFile(fFileName);
    end;
  end
  else begin
    varList.Clear;
  end;
end;

procedure TAppVars.SaveToFile(const aFileName: string);
begin
  if fileName <> '' then fFileName:= fileName;
  if self.fEncryptFile then begin
    StrEncryptSave(VarList.CommaText, fFileName);
  end
  else begin
    varList.SaveToFile(fFileName);
  end;
end;

procedure TAppVars.MakeDirty;
begin
  fDirty:= true;
  if fSaveOnChange then
    self.SaveToFile();
end;

end.

