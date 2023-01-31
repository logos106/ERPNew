unit BaseResults;

interface
  
uses classes, BaseCalcResult;

type 
  TResults = class
  private
    FVolumeReductionPerc: single;
    FTDSReduction: boolean;
    FCalciumHardnessReduction: boolean;
    FStabilizerReduction: boolean;
    FCopperReduction: boolean;
    FIoniserShutdown: boolean;
    FSaturationIndex: single;
    FNewSaturationIndex: single;
    FTestResults: TStringList;

    function GetStabilizerReduction: boolean;
    function GetTDSReduction: boolean;
    function GetVolumeReductionPerc: single;
    procedure SetStabilizerReduction(const Value: boolean);
    procedure SetTDSReduction(const Value: boolean);
    procedure SetVolumeReductionPerc(const Value: single);
    function GetTestResults(const Name: string): TCalculationResult;
    procedure SetTestResults(const Name: string; const Value: TCalculationResult);
    function GetCalciumHardnessReduction: boolean;
    procedure SetCalciumHardnessReduction(const Value: boolean);
    function GetSaturationIndex: single;
    procedure SetSaturationIndex(const Value: single);
    function GetCopperReduction: boolean;
    procedure SetCopperReduction(const Value: boolean);
    function GetIoniserShutdown: boolean;
    procedure SetIoniserShutdown(const Value: boolean);
    function GetNewSaturationIndex: single;
    procedure SetNewSaturationIndex(const Value: single);
  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure ClearNullResults;
    procedure ClearTestResults;
    function HasTestResult(const IndexName: string): boolean;
    procedure DeleteTestResult(const IndexName: string);

    property VolumeReductionPerc: single read GetVolumeReductionPerc write SetVolumeReductionPerc;
    property TDSReduction: boolean read GetTDSReduction write SetTDSReduction;
    property StabilizerReduction: boolean read GetStabilizerReduction write SetStabilizerReduction;
    property CalciumHardnessReduction: boolean read GetCalciumHardnessReduction write SetCalciumHardnessReduction;
    property CopperReduction: boolean read GetCopperReduction write SetCopperReduction;
    property IoniserShutdown: boolean read GetIoniserShutdown write SetIoniserShutdown;
    property SaturationIndex: single read GetSaturationIndex write SetSaturationIndex;
    property NewSaturationIndex: single read GetNewSaturationIndex write SetNewSaturationIndex;
    property TestResults[const Name: string]: TCalculationResult read GetTestResults write SetTestResults;
  published
  end;

implementation

uses
  SysUtils;

{ TResults }

procedure TResults.ClearNullResults;
var
  i: integer;
begin
  i := 0;
  while i <= FTestResults.Count - 1 do begin
    if Assigned(FTestResults.Objects[i]) then Inc(i)
    else FTestResults.Delete(i);
  end;
end;

procedure TResults.ClearTestResults;
begin
  while FTestResults.Count > 0 do FTestResults.Delete(0);

  FVolumeReductionPerc := 0.0;
  FTDSReduction := false;
  FCalciumHardnessReduction := false;
  FStabilizerReduction := false;
  FCopperReduction := false;
  FIoniserShutdown := false;
  FSaturationIndex := 0.0;
end;

constructor TResults.Create;
begin
  inherited;
  FTestResults := TStringList.Create;

  // initialize the variables
  FVolumeReductionPerc := 0;
  FTDSReduction := false;
  FCalciumHardnessReduction := false;
  FStabilizerReduction := false;
  FSaturationIndex := 0;
end;

procedure TResults.DeleteTestResult(const IndexName: string);
var
  i: integer;
begin
  i := FTestResults.IndexOf(IndexName);
  if Assigned(FTestResults.Objects[i]) then FTestResults.Objects[i].Free;

  FTestResults.Delete(i);
end;

destructor TResults.Destroy;
var
  i: integer;
begin
  for i := 0 to FTestResults.Count - 1 do if Assigned(FTestResults.Objects[i]) then FTestResults.Objects[i].Free;

  FTestResults.Clear;
  FreeandNil(FTestResults);
  FTestResults := nil;

  inherited;
end;

function TResults.GetCalciumHardnessReduction: boolean;
begin
  Result := FCalciumHardnessReduction;
end;

function TResults.GetCopperReduction: boolean;
begin
  Result := FCopperReduction;
end;

function TResults.GetIoniserShutdown: boolean;
begin
  Result := FIoniserShutdown;
end;

function TResults.GetNewSaturationIndex: single;
begin
  Result := FNewSaturationIndex;
end;

function TResults.GetSaturationIndex: single;
begin
  Result := FSaturationIndex;
end;

function TResults.GetStabilizerReduction: boolean;
begin
  Result := FStabilizerReduction;
end;

function TResults.GetTDSReduction: boolean;
begin
  Result := FTDSReduction;
end;

function TResults.GetTestResults(const Name: string): TCalculationResult;
var
  nPos: integer;
begin
  nPos := FTestResults.IndexOf(Name);
  if nPos <> -1 then Result := TCalculationResult(FTestResults.Objects[nPos])
  else Result := nil;
end;

function TResults.GetVolumeReductionPerc: single;
begin
  Result := FVolumeReductionPerc;
end;

function TResults.HasTestResult(const IndexName: string): boolean;
var
  i: integer;
begin
  i := FTestResults.IndexOf(IndexName);
  Result := (i <> -1);
end;

procedure TResults.SetCalciumHardnessReduction(const Value: boolean);
begin
  FCalciumHardnessReduction := Value;
end;

procedure TResults.SetCopperReduction(const Value: boolean);
begin
  FCopperReduction := Value;
end;

procedure TResults.SetIoniserShutdown(const Value: boolean);
begin
  FIoniserShutdown := Value;
end;

procedure TResults.SetNewSaturationIndex(const Value: single);
begin
  FNewSaturationIndex := Value;
end;

procedure TResults.SetSaturationIndex(const Value: single);
begin
  FSaturationIndex := Value;
end;

procedure TResults.SetStabilizerReduction(const Value: boolean);
begin
  FStabilizerReduction := Value;
end;

procedure TResults.SetTDSReduction(const Value: boolean);
begin
  FTDSReduction := Value;
end;

procedure TResults.SetTestResults(const Name: string; const Value: TCalculationResult);
var
  nPos: integer;
begin
  nPos := FTestResults.IndexOf(Name);
  if nPos <> -1 then FTestResults.Objects[nPos] := Value
  else FTestResults.AddObject(Name, Value);
end;

procedure TResults.SetVolumeReductionPerc(const Value: single);
begin
  FVolumeReductionPerc := Value;
end;

end.
