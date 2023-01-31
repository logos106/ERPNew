unit BaseCalcResult;

interface

type
  TCalculationResult = class
  private
    FActualQty: single;
    FModifiedQty: single;
    FPartNo: string;

    function GetActualQty: single;
    function GetModifiedQty: single;
    function GetPartNo: string;
    procedure SetActualQty(const Value: single);
    procedure SetModifiedQty(const Value: single);
    procedure SetPartNo(const Value: string);
  protected
  public
    constructor Create;
    property PartNo: string read GetPartNo write SetPartNo;
    property ActualQty: single read GetActualQty write SetActualQty;
    property ModifiedQty: single read GetModifiedQty write SetModifiedQty;
  protected
  end;

implementation

{ TCalculationResult }
constructor TCalculationResult.Create;
begin
  inherited;
  FActualQty := 0;
  FModifiedQty := 0;
  FPartNo := '';
end;

function TCalculationResult.GetActualQty: single;
begin
  Result := FActualQty;
end;

function TCalculationResult.GetModifiedQty: single;
begin
  Result := FModifiedQty;
end;

function TCalculationResult.GetPartNo: string;
begin
  Result := FPartNo;
end;

procedure TCalculationResult.SetActualQty(const Value: single);
begin
  FActualQty := Value;
end;

procedure TCalculationResult.SetModifiedQty(const Value: single);
begin
  FModifiedQty := Value;
end;

procedure TCalculationResult.SetPartNo(const Value: string);
begin
  FPartNo := Value;
end;

end.
