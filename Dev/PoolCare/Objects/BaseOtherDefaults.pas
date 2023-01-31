unit BaseOtherDefaults;

interface

uses
  MyAccess;
  
type
  TOtherDefaults = class
  private
    FDoseVariation: single;
    FHighTotalAlkalinity: single;
    FLowCalciumHardness: single;

    function GetDoseVariation: single;
    function GetHighTotalAlkalinity: single;
    function GetLowCalciumHardness: single;
    procedure SetDoseVariation(const Value: single);
    procedure SetHighTotalAlkalinity(const Value: single);
    procedure SetLowCalciumHardness(const Value: single);
  protected
  public
    procedure LoadFromDatabase;
    procedure SaveToDatabase;

    property LowCalciumHardness: single read GetLowCalciumHardness write SetLowCalciumHardness;
    property HighTotalAlkalinity: single read GetHighTotalAlkalinity write SetHighTotalAlkalinity;
    property DoseVariation: single read GetDoseVariation write SetDoseVariation;
  published
  end;

implementation

uses
  CommonDbLib, SysUtils;

{ TOtherDefaults }

function TOtherDefaults.GetDoseVariation: single;
begin
  Result := FDoseVariation;
end;

function TOtherDefaults.GetHighTotalAlkalinity: single;
begin
  Result := FHighTotalAlkalinity;
end;

function TOtherDefaults.GetLowCalciumHardness: single;
begin
  Result := FLowCalciumHardness;
end;

procedure TOtherDefaults.LoadFromDatabase;
var
  qryTest: TMyQuery;
begin
  qryTest := TMyQuery.Create(nil);
  try
    qryTest.Options.FlatBuffers := True;
    //qryTest.Connection := fmPoolProfileTest.MyConnection;
    qryTest.Connection := GetSharedMyDacConnection;
    qryTest.SQL.Add('select *');
    qryTest.SQL.Add('from tblPoolOtherDefaults');

    qryTest.Open;
    FDoseVariation       := qryTest.FieldByName('DoseVariation').AsFloat;
    FHighTotalAlkalinity := qryTest.FieldByName('HighTotalAlkalinity').AsFloat;
    FLowCalciumHardness  := qryTest.FieldByName('LowCalciumHardness').AsFloat;

    qryTest.Close;
  finally
    FreeAndNil(qryTest)
  end;
end;

procedure TOtherDefaults.SaveToDatabase;
begin
end;

procedure TOtherDefaults.SetDoseVariation(const Value: single);
begin
  FDoseVariation := Value;
end;

procedure TOtherDefaults.SetHighTotalAlkalinity(const Value: single);
begin
  FHighTotalAlkalinity := Value;
end;

procedure TOtherDefaults.SetLowCalciumHardness(const Value: single);
begin
  FLowCalciumHardness := Value;
end;

end.
