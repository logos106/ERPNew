unit Rounding;

interface

function RoundCurrency(const Value: double): currency;
function Round(const Value: double; places: word): double;

implementation

uses
  DecimalRounding, AppEnvironmentVirtual;

function RoundCurrency(const Value: double): currency;
begin
  Result := DecimalRoundDbl(Value, AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'], drHalfUp);
end;

function Round(const Value: double; places: word): double;
begin
  Result := DecimalRoundDbl(Value, places, drHalfUp);
end;


end.
