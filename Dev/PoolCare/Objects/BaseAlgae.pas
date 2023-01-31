unit BaseAlgae;

interface

type
  TBaseAlgae = class
  private
    FStep1Dose: single;
    FStep1PartNo: string;
    FStep2Dose: single;
    FStep2PartNo: string;

    function GetStep1Dose: single;
    function GetStep1PartNo: string;
    function GetStep2Dose: single;
    function GetStep2PartNo: string;
    procedure SetStep1Dose(const Value: single);
    procedure SetStep1PartNo(const Value: string);
    procedure SetStep2Dose(const Value: single);
    procedure SetStep2PartNo(const Value: string);
  protected
  public
    property Step1PartNo: string read GetStep1PartNo write SetStep1PartNo;
    property Step1Dose: single read GetStep1Dose write SetStep1Dose;
    property Step2PartNo: string read GetStep2PartNo write SetStep2PartNo;
    property Step2Dose: single read GetStep2Dose write SetStep2Dose;
  published
  end;

implementation

{ TBaseAlgae }

function TBaseAlgae.GetStep1Dose: single;
begin
  Result := FStep1Dose;
end;

function TBaseAlgae.GetStep1PartNo: string;
begin
  Result := FStep1PartNo;
end;

function TBaseAlgae.GetStep2Dose: single;
begin
  Result := FStep2Dose;
end;

function TBaseAlgae.GetStep2PartNo: string;
begin
  Result := FStep2PartNo;
end;

procedure TBaseAlgae.SetStep1Dose(const Value: single);
begin
  FStep1Dose := Value;
end;

procedure TBaseAlgae.SetStep1PartNo(const Value: string);
begin
  FStep1PartNo := Value;
end;

procedure TBaseAlgae.SetStep2Dose(const Value: single);
begin
  FStep2Dose := Value;
end;

procedure TBaseAlgae.SetStep2PartNo(const Value: string);
begin
  FStep2PartNo := Value;
end;

end.
