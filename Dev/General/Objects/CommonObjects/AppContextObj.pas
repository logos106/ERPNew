unit AppContextObj;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 25/05/05  1.00.01 BJ  'Raise exception' is changed to MessageDlg for user messages

interface

uses
  Classes;

type
  TAppVars = class(TObject)
  private
    //fFileName: string;
    fDirty: boolean;
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

  public
    varList: TStringList;
    constructor Create;
    destructor Destroy; override;
    property VarByName[const varName: string]: string read GetVarByName write SetVarByName; default;
    property IntVar[const varName: string]: integer read GetIntVar write SetIntVar;
    property FloatVar[const varName: string]: double read GetFloatVar write SetFloatVar;
    property DateTimeVar[const varName: string]: TDateTime read GetDateTimeVar write SetDateTimeVar;
    property BoolVar[const varName: string]: boolean read GetBoolVar write SetBoolVar;
    function DeleteVar(const varName: string): boolean;
    function VarExists(const varName: string): boolean;
    property Dirty: boolean read fDirty;
    procedure SetDefault(const varName, Value: string);
  end;

  TAppContext = class(TObject)
  private
    fFileName: string;
    ContextList: TStringList;
    function GetContextByName(const ContextName: string): TAppVars;
    //procedure SetContextByName(ContextName: string; value: TAppVars);
    function GetDirty: boolean;

  public
    constructor Create;
    destructor Destroy; override;
    //property ContextByName[varName: string]: TAppVars read GetContextByName write SetContextByName; default;
    property ContextByName[const varName: string]: TAppVars read GetContextByName; default;
    property FileName: string read fFileName write fFileName;
    procedure SaveToFile(const FileName: string = '');
    procedure LoadFromFile(const FileName: string = '');
    function DeleteContext(const ContextName: string): boolean;
    function ContextExists(const ContextName: string): boolean;
    property Dirty: boolean read GetDirty;
  end;

  function NewWebHelpentry: Boolean;

var
  AppContext: TAppContext;

implementation

uses
  Sysutils, Forms, Dialogs, CommonLib;

constructor TAppVars.Create;
begin
  inherited;
  varList := TStringList.Create;
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
    fDirty := true;
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
      fDirty := true;
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
    fDirty := true;
  end;
end;

// ---------- TAppContext ------------------------------------------------------

constructor TAppContext.Create;
begin
  inherited;
  ContextList := TStringList.Create;
  // Default file name to same as exe  + '_Context' with ini extension and in same directory.
  fFileName := Copy(Application.ExeName, 1, char_length(Application.ExeName) - 4) + '_Context' + '.ini';
end;

destructor TAppContext.Destroy;
begin
  while ContextList.Count > 0 do begin
    ContextList.Objects[0].Free;
    ContextList.Delete(0);
  end;
  FreeandNil(ContextList);
  inherited;
end;

function TAppContext.GetContextByName(const ContextName: string): TAppVars;
var
  x: integer;
  newVars: TAppVars;
begin
  x := ContextList.IndexOf(ContextName);
  if x > -1 then Result := TAppVars(ContextList.Objects[x])
  else begin
    newVars := TAppVars.Create;
    ContextList.AddObject(ContextName, newVars);
    Result := newVars;
  end;
end;

  //procedure TAppContext.SetContextByName(ContextName: string; value: TAppVars);
  //begin
  //
  //end;

procedure TAppContext.SaveToFile(const FileName: string = '');
var
  SL: TStringList;
  x: integer;
begin
  SL := TStringList.Create;
  try
    for x := 0 to ContextList.Count - 1 do SL.Add(ContextList.Strings[x] + '=' +
        TAppVars(ContextList.Objects[x]).varList.CommaText);

    if FileName <> '' then begin
      fFileName := FileName;
      SL.SaveToFile(FileName);
    end else if fFileName <> '' then begin
      SL.SaveToFile(fFileName);
    end else //raise Exception.Create('Could not Save AppContext, no filename specified');
      CommonLib.MessageDlgXP_Vista('Could not Save AppContext, no filename specified', mtWarning, [mbOK], 0);
  finally
    FreeandNil(SL);
  end;
end;

procedure TAppContext.LoadFromFile(const FileName: string = '');
var
  SL: TStringList;
  x: integer;
  newVars: TAppVars;
begin
  while ContextList.Count > 0 do begin
    ContextList.Objects[0].Free;
    ContextList.Delete(0);
  end;
  SL := TStringList.Create;
  try
    if FileName <> '' then begin
      fFileName := FileName;
      if FileExists(FileName) then begin
        SL.LoadFromFile(FileName);
      end;
    end else if fFileName <> '' then begin
      if FileExists(fFileName) then begin
        SL.LoadFromFile(fFileName);
      end;
    end;

    for x := 0 to SL.Count - 1 do begin
      newVars := TAppVars.Create;
      newVars.varList.CommaText := SL.Values[SL.Names[x]];
      ContextList.AddObject(SL.Names[x], newVars);
    end;
  finally
    if Assigned(SL) then
      FreeandNil(SL);
  end;
end;

function TAppContext.DeleteContext(const ContextName: string): boolean;
var
  x: integer;
begin
  Result := false;
  try
    x := ContextList.IndexOf(ContextName);
    if x > -1 then begin
      ContextList.Objects[x].Free;
      ContextList.Delete(x);
    end;
  except
    Result := true;
  end;
end;

function TAppContext.ContextExists(const ContextName: string): boolean;
begin
  Result := (ContextList.IndexOf(ContextName) > -1);
end;

function TAppContext.GetDirty: boolean;
var 
  x: integer;
begin
  Result := false;
  for x := 0 to ContextList.Count - 1 do begin
    if TAppVars(ContextList.Objects[x]).Dirty then begin
      Result := true;
      Break;
    end;
  end;
end;
function NewWebHelpentry: Boolean;
begin
  Result := False;
    if AppContext.ContextExists('WebHelpEntry') then
        if AppContext['WebHelpEntry'].VarExists('NewWebHelpEntry') then
            if AppContext['WebHelpEntry'].VarExists('NewWebHelpEntry') then
                Result := AppContext['WebHelpEntry'].VarByname['NewWebHelpEntry'] = 'T';
  AppContext['WebHelpEntry'].VarByname['NewWebHelpEntry']:= 'F';
end;

initialization
  AppContext := TAppContext.Create;
finalization
  FreeandNil(AppContext);
end.
