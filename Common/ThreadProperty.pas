unit ThreadProperty;

interface

uses
  SyncObjs;

type

  TThreadProperty = class
  private
    Lock: TCriticalSection;
    fValue: string;
    function GetAsBoolean: boolean;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    procedure SetAsBoolean(const Value: boolean);
    procedure SetAsFloat(const Value: double);
    procedure SetAsInteger(const Value: integer);
  public
    constructor Create(aDefaultValue: string = '');
    destructor Destroy; override;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsString: string read fValue write fValue;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsDateTime: double read GetAsFloat write SetAsFloat;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
  end;


implementation

uses
  SysUtils;

{ TThreadProperty }

constructor TThreadProperty.Create(aDefaultValue: string = '');
begin
  Lock := TCriticalSection.Create;
  fValue := aDefaultValue;
end;

destructor TThreadProperty.Destroy;
begin
  Lock.Free;
  inherited;
end;

function TThreadProperty.GetAsBoolean: boolean;
begin
  Lock.Acquire;
  try
    result := SameText(fValue, 'true');
  finally
    Lock.Release;
  end;
end;

function TThreadProperty.GetAsFloat: double;
begin
  result:= 0;
  Lock.Acquire;
  try
    if fValue <> '' then
      result := StrToFloat(fValue);
  finally
    Lock.Release;
  end;
end;

function TThreadProperty.GetAsInteger: integer;
begin
  result:= 0;
  Lock.Acquire;
  try
    if fValue <> '' then
      result := StrToInt(fValue);
  finally
    Lock.Release;
  end;
end;

procedure TThreadProperty.SetAsBoolean(const Value: boolean);
begin
  Lock.Acquire;
  try
    if Value then fValue := 'true'
    else fValue := 'false';
  finally
    Lock.Release;
  end;
end;

procedure TThreadProperty.SetAsFloat(const Value: double);
begin
  Lock.Acquire;
  try
    fValue := FloatToStr(Value);
  finally
    Lock.Release;
  end;
end;

procedure TThreadProperty.SetAsInteger(const Value: integer);
begin
  Lock.Acquire;
  try
    fValue := IntToStr(Value);
  finally
    Lock.Release;
  end;
end;


end.
