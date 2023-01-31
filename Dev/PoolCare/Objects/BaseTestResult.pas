unit BaseTestResult;

interface

type
  TTestResult = class
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
    property PartNo: string read GetPartNo write SetPartNo;
    property ActualQty: single read GetActualQty write SetActualQty;
    property ModifiedQty: single read GetModifiedQty write SetModifiedQty;
  protected
  end;

implementation

{ TTestResult }

function TTestResult.GetActualQty: single;
begin
  Result := FActualQty;
end;

function TTestResult.GetModifiedQty: single;
begin
  Result := FModifiedQty;
end;

function TTestResult.GetPartNo: string;
begin
  Result := FPartNo;
end;

procedure TTestResult.SetActualQty(const Value: single);
begin
  FActualQty := Value;
end;

procedure TTestResult.SetModifiedQty(const Value: single);
begin
  FModifiedQty := Value;
end;

procedure TTestResult.SetPartNo(const Value: string);
begin
  FPartNo := Value;
end;

end.
