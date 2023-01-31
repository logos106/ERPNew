unit WaterTest;

interface

uses
  BaseCalcResult, PoolData, BaseDefault, BaseAlgae, Math, SysUtils,
  BaseOtherDefaults, BaseMetalMSA, BaseResults;

const
  TR_ALGAESTEP1 = 'AlgaeStep1';
  TR_ALGAESTEP2 = 'AlgaeStep2';
  TR_CALCIUMHARDNESS = 'CalciumHardness';
  TR_STABILIZER = 'Stabilizer';
  TR_TOTALALKALINITY = 'TotalAlkalinity';
  TR_MSA        = 'msa';
  TR_METALSTEP1 = 'MetalStep1';
  TR_METALSTEP2 = 'MetalStep2';
  TR_SALT       = 'Salt';
  TR_TURBIDITY  = 'Turbidity';
  TR_SANITIZER  = 'Sanitizer';
  TR_PH         = 'pH';
  TR_PHOSPHATES = 'Phosphates';

type
  TWaterTest = class
  private
    RTA: double;
    RS: double;
    NewTDS: double;
    NewpH: double;
    NewCalciumHardness: double;
    NewTotalAlkalinity: double;
    IsDecreaseResult: boolean;
    pHDecreaserUsed: boolean;

    FAcidUsed: boolean;
    FShutDownIoniser: boolean;
    function GetAcidUsed: boolean;
    function GetShutDownIoniser: boolean;

    function NormalCalculation(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;
    function NormalCalculationInc(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;
      overload;
    function NormalCalculationInc(Volume: integer; ReadingValue: single; TestData: TBaseMetalMSA): TCalculationResult;
      overload;
    function NormalCalculationDec(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;
    function VolumeDropCalculation(Volume: integer; ReadingValue: single; TestData: TBaseDefault): single; overload;
    function VolumeDropCalculation(Volume: integer; ReadingValue: single; TestData: TBaseMetalMSA): single; overload;
  protected
  public
    constructor Create;
    function AlgaeStep1(Volume: integer; Algae: TBaseAlgae): TCalculationResult;
    function AlgaeStep2(Volume: integer; Algae: TBaseAlgae): TCalculationResult;
    function TotalDissolvedSolids(Readings: TPoolData; TestData: TBaseDefault): single;
    function CalciumHardness(Readings: TPoolData; TestData: TBaseDefault;
      OtherDefaults: TOtherDefaults): TCalculationResult;
    function CalciumHardnessReduction(Readings: TPoolData; TestData: TBaseDefault): single;
    function TotalAlkalinity(Readings: TPoolData; TestData: TBaseDefault;
      OtherDefaults: TOtherDefaults): TCalculationResult;
    function StabilizerReduction(Readings: TPoolData; TestData: TBaseDefault): single;
    function Stabilizer(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
    function MetalStep1(Readings: TPoolData; Metals: TBaseMetalMSA): TCalculationResult;
    function MetalStep2(Readings: TPoolData; Metals: TBaseMetalMSA): TCalculationResult;
    function MSAReduction(Readings: TPoolData; TestData: TBaseMetalMSA): single;
    function MSA(Readings: TPoolData; TestData: TBaseMetalMSA): TCalculationResult;
    function SaltWater(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
    function Turbidity(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
    function Sanitizer(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
    function pHLevel(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
    function Phosphate(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
    function LowpHLevel(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;

    function DoStabilizerTest(PoolReadings: TPoolData): boolean;
    function DoSanitizerTest(PoolReadings: TPoolData; TestData: TBaseDefault): boolean;
    function DopHLevelTest(PoolReadings: TPoolData): boolean;
    function DoLowpHLevelTest(PoolReadings: TPoolData): boolean;
    function CalculateSaturationIndex(Readings: TPoolData): single;
    function CalculateNewSaturationIndex(Readings: TPoolData; Results: TResults): single;

    property AcidUsed: boolean read GetAcidUsed;
    property ShutDownIoniser: boolean read GetShutDownIoniser;
  published
  end;

implementation

uses FastFuncs,CommonLib;

{ TWaterTest }

constructor TWaterTest.Create;
begin
  inherited; 
  IsDecreaseResult := false;
  pHDecreaserUsed := false;
  FAcidUSed := false;
  FShutdownIoniser := false;
  RTA := 0;
  RS := 0;
end;

function TWaterTest.GetAcidUsed: boolean;
begin
  Result := FAcidUsed;
end;

function TWaterTest.NormalCalculation(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    if (ReadingValue <= TestData.Minimum) then begin
      if TestData.IncreaseDose = 0 then // increase dose is not expected to be 0
        Result.ActualQty := (Volume / 10) * Abs(ReadingValue - TestData.TargetValue) * 1
      else Result.ActualQty := (Volume / 10) * Abs(ReadingValue - TestData.TargetValue) *
          (DivZer(TestData.IncreaseDose , TestData.IncreaseRslt));
      Result.PartNo := TestData.IncreasePartNo;
      IsDecreaseResult := false;
    end else if (ReadingValue >= TestData.Maximum) then begin
      if TestData.DecreaseDose = 0 then // DecreaseDose is not expected to be 0
        Result.ActualQty := (Volume / 10) * Abs(ReadingValue - TestData.TargetValue) * 1
      else Result.ActualQty := (Volume / 10) * Abs(ReadingValue - TestData.TargetValue) *
          (DivZer(TestData.DecreaseDose , TestData.DecreaseRslt));
      Result.PartNo := TestData.DecreasePartNo;
      IsDecreaseResult := true;
    end else begin
      FreeAndNil(Result);
    end;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.NormalCalculationDec(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    if (ReadingValue >= TestData.Maximum) then begin
      Result.ActualQty := (Volume / 10) * Abs(ReadingValue - TestData.TargetValue) *
        (DivZer(TestData.DecreaseDose , TestData.DecreaseRslt));
      Result.PartNo := TestData.DecreasePartNo;
      IsDecreaseResult := true;
    end else begin
      FreeAndNil(Result);
    end;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.NormalCalculationInc(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    if (ReadingValue <= TestData.Minimum) then begin
      Result.ActualQty := (Volume / 10) * Abs(ReadingValue - TestData.TargetValue) *
        (DivZer(TestData.IncreaseDose , TestData.IncreaseRslt));
      Result.PartNo := TestData.IncreasePartNo;
      IsDecreaseResult := false;
    end else begin
      FreeAndNil(Result);
    end;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.NormalCalculationInc(Volume: integer; ReadingValue: single;
  TestData: TBaseMetalMSA): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    if (ReadingValue <= TestData.Minimum) then begin
      Result.ActualQty := (Volume / 10) * Abs(ReadingValue - TestData.TargetValue) *
                (DivZer(TestData.Step2Dose , TestData.Step2Rslt));
      Result.PartNo := TestData.Step2PartNo;
      IsDecreaseResult := false;
    end else begin
      FreeAndNil(Result);
    end;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.VolumeDropCalculation(Volume: integer; ReadingValue: single; TestData: TBaseDefault): single;
begin
  Result := 0;

  if ReadingValue >= TestData.Maximum then begin
    Result := DivZer((ReadingValue - TestData.TargetValue) , ReadingValue) * 100;
  end;
end;

function TWaterTest.VolumeDropCalculation(Volume: integer; ReadingValue: single; TestData: TBaseMetalMSA): single;
begin
  Result := 0;

  if ReadingValue >= 1.0 then begin
    Result := DivZer((ReadingValue - 1.0) , ReadingValue) * 100;
  end;
end;

// public methods
function TWaterTest.AlgaeStep1(Volume: integer; Algae: TBaseAlgae): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    Result.ActualQty := (Volume / 10) * Algae.Step1Dose;
    Result.ActualQty := RoundTo(Result.ActualQty, - 2);
    Result.PartNo    := Algae.Step1PartNo;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.AlgaeStep2(Volume: integer; Algae: TBaseAlgae): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    Result.ActualQty := (Volume / 10) * Algae.Step2Dose;
    Result.ActualQty := RoundTo(Result.ActualQty, - 2);
    Result.PartNo    := Algae.Step2PartNo;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.CalculateSaturationIndex(Readings: TPoolData): single;
var
  A, B, C, D: single;
begin
  try
    A      := (log10(Readings.TDS) - 1) / 10;
    B      := -13.12 * log10(Readings.Temperature + 273) + 34.55;
    C      := log10(Readings.CalciumHardness) - 0.4;
    D      := log10(Readings.TotalAlkaline);
    Result := Readings.pH - ((9.3 + A + B) - (C + D));
    Result := RoundTo(Result, - 2);
  except
    Result := 0;
  end;
end;

function TWaterTest.CalciumHardnessReduction(Readings: TPoolData; TestData: TBaseDefault): single;
begin
  Result := VolumeDropCalculation(Readings.Volume, Readings.CalciumHardness, TestData);
  NewCalciumHardness := TestData.TargetValue;
end;

function TWaterTest.CalciumHardness(Readings: TPoolData; TestData: TBaseDefault;
  OtherDefaults: TOtherDefaults): TCalculationResult;
begin
  Result := NormalCalculationInc(Readings.Volume, Readings.CalciumHardness, TestData);
  if Assigned(Result) then begin
    Result.ModifiedQty := DivZer(Result.ActualQty , OtherDefaults.LowCalciumHardness);
    NewCalciumHardness := TestData.TargetValue;
  end;
end;

function TWaterTest.TotalAlkalinity(Readings: TPoolData; TestData: TBaseDefault;
  OtherDefaults: TOtherDefaults): TCalculationResult;
begin
  Result := NormalCalculation(Readings.Volume, Readings.TotalAlkaline, TestData);
  if Assigned(Result) then begin
    RTA := Result.ActualQty;
    NewTotalAlkalinity := TestData.TargetValue;

    // check if acid used
    if IsDecreaseResult then begin
      FAcidUsed := true;
      Result.ModifiedQty := DivZer(Result.ActualQty , OtherDefaults.HighTotalAlkalinity);
    end;
  end;
end;

function TWaterTest.Stabilizer(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
begin
  Result := NormalCalculationInc(Readings.Volume, Readings.StabilizerLvl, TestData);
end;

function TWaterTest.StabilizerReduction(Readings: TPoolData; TestData: TBaseDefault): single;
begin
  Result := VolumeDropCalculation(Readings.Volume, Readings.StabilizerLvl, TestData);
end;

function TWaterTest.TotalDissolvedSolids(Readings: TPoolData; TestData: TBaseDefault): single;
begin
  Result := VolumeDropCalculation(Readings.Volume, Readings.TDS, TestData);
  NewTDS := TestData.TargetValue;
end;

function TWaterTest.DoStabilizerTest(PoolReadings: TPoolData): boolean;
begin
  Result := ((FastFuncs.UpperCase(PoolReadings.Location) <> 'INDOOR') and (not PoolReadings.IsSpa) and
    (FastFuncs.UpperCase(PoolReadings.Sanitizer) <> 'BROMINE') and (FastFuncs.UpperCase(PoolReadings.Sanitizer) <> 'OZONE'));
end;

function TWaterTest.SaltWater(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
begin
  Result := NormalCalculation(Readings.Volume, Readings.Salt, TestData);
end;

function TWaterTest.Turbidity(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
begin
  Result := NormalCalculation(Readings.Volume, 1, TestData);
end;

function TWaterTest.Phosphate(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
begin
  Result := NormalCalculationDec(Readings.Volume, Readings.Phosphate, TestData);
end;

function TWaterTest.DoSanitizerTest(PoolReadings: TPoolData; TestData: TBaseDefault): boolean;
begin
  Result := ((PoolReadings.FreeSanitizer > (PoolReadings.TotalSanitizer + 0.5)) or
    (PoolReadings.FreeSanitizer < TestData.Minimum));
end;

function TWaterTest.Sanitizer(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
begin
  Result := NormalCalculationInc(Readings.Volume, Readings.FreeSanitizer, TestData);
  if Assigned(Result) then RS := Result.ActualQty;
end;

function TWaterTest.LowpHLevel(Volume: integer; ReadingValue: single; TestData: TBaseDefault): TCalculationResult;
begin
  Result := TCalculationResult.Create;
end;

function TWaterTest.MetalStep1(Readings: TPoolData; Metals: TBaseMetalMSA): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    Result.ActualQty := (Readings.Volume / 10) * Readings.Metals * Metals.Step1Dose;
    //result.ActualQty := RoundTo( result.ActualQty, -2 );
    Result.PartNo := Metals.Step1PartNo;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.MetalStep2(Readings: TPoolData; Metals: TBaseMetalMSA): TCalculationResult;
begin
  Result := TCalculationResult.Create;

  try
    Result.ActualQty := (Readings.Volume / 10) * Readings.Metals * Metals.Step2Dose;
    //result.ActualQty := RoundTo( result.ActualQty, -2 );
    Result.PartNo := Metals.Step2PartNo;
  except
    FreeAndNil(Result);
  end;
end;

function TWaterTest.MSAReduction(Readings: TPoolData; TestData: TBaseMetalMSA): single;
begin
  FShutdownIoniser := (Readings.Sanitizer = 'Ioniser');
  if not FShutdownIoniser then Result := VolumeDropCalculation(Readings.Volume, Readings.Metals, TestData)
  else Result := 0;
end;

function TWaterTest.MSA(Readings: TPoolData; TestData: TBaseMetalMSA): TCalculationResult;
begin
  if Readings.Metals < 1.0 then Result := NormalCalculationInc(Readings.Volume, Readings.Metals, TestData)
  else Result := nil;
end;

function TWaterTest.pHLevel(Readings: TPoolData; TestData: TBaseDefault): TCalculationResult;
begin
  Result := NormalCalculation(Readings.Volume, Readings.pH, TestData);
  if (Readings.AlkalineDemand > 0) then Result.ActualQty := Result.ActualQty + ((RS * 0.05) + (RTA * 0.02))
  else if (Readings.AlkalineDemand < 0) then Result.ActualQty := Result.ActualQty - ((RS * 0.05) + (RTA * 0.02));

  phDecreaserUsed := IsDecreaseResult;
  NewpH := TestData.TargetValue;
end;

function TWaterTest.DopHLevelTest(PoolReadings: TPoolData): boolean;
begin
  Result := not ((((RS * 0.05) + (RTA * 0.02)) = 0) and (PoolReadings.AlkalineDemand = 0));
end;

function TWaterTest.GetShutDownIoniser: boolean;
begin
  Result := FShutDownIoniser;
end;

function TWaterTest.DoLowpHLevelTest(PoolReadings: TPoolData): boolean;
begin
  Result := true;
  if phDecreaserUsed or (not FAcidUsed) or (PoolReadings.pH > 7.4) then Result := false;
end;

function TWaterTest.CalculateNewSaturationIndex(Readings: TPoolData; Results: TResults): single;
var
  A, B, C, D: single;
  TDS, CalHardness, TotalAlk, AdjPH: single;
begin
  // find any new values
  if Results.TDSReduction then TDS := NewTDS
  else TDS := Readings.TDS;

  if Results.HasTestResult(TR_CALCIUMHARDNESS) then CalHardness := NewCalciumHardness
  else CalHardness := Readings.CalciumHardness;

  if Results.HasTestResult(TR_TOTALALKALINITY) then TotalAlk := NewTotalAlkalinity
  else TotalAlk := Readings.TotalAlkaline;

  if Results.HasTestResult(TR_TOTALALKALINITY) then AdjPH := NewpH
  else AdjPH := Readings.pH;
  try
    A      := (log10(TDS) - 1) / 10;
    B      := -13.12 * log10(Readings.Temperature + 273) + 34.55;
    C      := log10(CalHardness) - 0.4;
    D      := log10(TotalAlk);
    Result := AdjPH - ((9.3 + A + B) - (C + D));
    Result := RoundTo(Result, - 2);
  except
    Result := 0;
  end;
end;

end.
