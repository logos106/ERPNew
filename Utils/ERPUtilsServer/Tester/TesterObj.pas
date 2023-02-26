unit TesterObj;

interface

uses
  Classes, JsonObject, Contnrs;

type

  TTestStatus = (tssUntested, tssTesting, tssPass, tssFail, tssWarn);

  TTestStep = class;
  TTestStepEvent = procedure (Step: TTestStep) of object;

  TTestStep = class
  private
    fStepNumber: integer;
  protected
    fStringList: TStringList;
    fCaption: string;
    fStatus: TTestStatus;
    fOnTestStepStart: TTestStepEvent;
    fOnTestStepFinish: TTestStepEvent;
    fOnStatusChange: TTestStepEvent;
    procedure AddDetail(s: string; indent: integer = 0);
    procedure DoTest(context: TJsonObject); virtual; abstract;
    procedure SetStatus(aStatus: TTestStatus);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure Test(context: TJsonObject);
    property Status: TTestStatus read fStatus;
    property Caption: string read fCaption;
    property Details: TStringList read fStringList;
    property StepNumber: integer read fStepNumber write fStepNumber;
    property OnTestStepStart: TTestStepEvent read fOnTestStepStart write fOnTestStepStart;
    property OnTestStepFinish: TTestStepEvent read fOnTestStepFinish write fOnTestStepFinish;
    property OnStatusChange: TTestStepEvent read fOnStatusChange write fOnStatusChange;
  end;

  TTestList = class
  private
    fList: TObjectList;
    fOnTestStepStart: TTestStepEvent;
    fOnTestStepFinish: TTestStepEvent;
    fStatus: TTestStatus;
    function GetCount: integer;
    function GetItem(index: integer): TTestStep;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset;
    procedure Test(context: TJsonObject);
    property Status: TTestStatus read fStatus;
    property Item[index: integer]: TTestStep read GetItem;
    property Count: integer read GetCount;
    property OnTestStepStart: TTestStepEvent read fOnTestStepStart write fOnTestStepStart;
    property OnTestStepFinish: TTestStepEvent read fOnTestStepFinish write fOnTestStepFinish;
    procedure AddTest(Test: TTestStep);
  end;

implementation

uses
  SysUtils, forms;

{ TTestStep }

procedure TTestStep.AddDetail(s: string; indent: integer = 0);
var
  sl: TStringList;
  x: integer;

  function GetIndent: string;
  var i : integer;
  begin
    result := '';
    for i := 1 to indent do
      result:= ' ' + result;
  end;

begin
  if s = '' then
    fStringLIst.Add('')
  else begin
    sl := TStringList.Create;
    try
      sl.Text := s; //Trim(s);
      for x := 0 to sl.Count -1 do
        fStringList.Add(GetIndent + sl[x]);
    finally
      sl.Free;
    end;
  end;
end;

constructor TTestStep.Create;
begin
  fStringList := TStringList.Create;
  Reset;
end;

destructor TTestStep.Destroy;
begin
  fStringList.Free;
  inherited;
end;

procedure TTestStep.Reset;
begin
  fStringList.Clear;
  fStringList.Add('No further information available.');
  SetStatus(tssUntested);
end;

procedure TTestStep.SetStatus(aStatus: TTestStatus);
begin
  fStatus:= aStatus;
  if Assigned(fOnStatusChange) then
    fOnStatusChange(self);
end;

procedure TTestStep.Test(context: TJsonObject);
begin
  fStringList.Clear;
  SetStatus(tssTesting);

  if assigned(fOnTestStepStart) then begin
    fOnTestStepStart(self);
    Application.ProcessMessages;
  end;

  DoTest(context);

  if assigned(fOnTestStepFinish) then begin
    fOnTestStepFinish(self);
    Application.ProcessMessages;
  end;
end;

{ TTestList }

procedure TTestList.AddTest(Test: TTestStep);
var
  StepNo: integer;
begin
  StepNo:= fList.Add(Test) + 1;
  Test.StepNumber := StepNo;
end;

constructor TTestList.Create;
begin
  fList := TObjectList.Create;
end;

destructor TTestList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TTestList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TTestList.GetItem(index: integer): TTestStep;
begin
  result := TTestStep(fList[index]);
end;

procedure TTestList.Reset;
var
  x: integer;
begin
  for x:= 0 to Count -1 do
    Item[x].Reset;
  fStatus := tssUntested;
end;

procedure TTestList.Test(context: TJsonObject);
var
  x: integer;
  t: TTestStep;
  result: TTestStatus;
  ctx: TJsonObject;
begin
  fStatus := tssTesting;
  result := tssPass;
  if Assigned(context) then
    ctx:= context
  else
    ctx:= JO;

  for x:= 0 to Count - 1 do begin
    t := Item[x];
    if assigned(fOnTestStepStart) then
      fOnTestStepStart(t);
    t.Test(ctx);
    if t.Status <> tssPass then
      result := tssFail;
    if assigned(fOnTestStepFinish) then
      fOnTestStepFinish(t);
  end;
  if not Assigned(context) then
    ctx.Free;
  fStatus := result;
end;


end.
