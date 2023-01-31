unit AlgaeBase;

interface

type
  TAlgae = class
  private
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

{ TAlgae }

function TAlgae.GetStep1Dose: single;
begin
  Result := 0;
end;

function TAlgae.GetStep1PartNo: string;
begin
  Result := '';
end;

function TAlgae.GetStep2Dose: single;
begin
  Result := 0;
end;

function TAlgae.GetStep2PartNo: string;
begin
  Result := '';
end;

procedure TAlgae.SetStep1Dose(const Value: single);
begin
  Step1Dose := Value;
end;

procedure TAlgae.SetStep1PartNo(const Value: string);
begin
  Step1PartNo := Value;
end;

procedure TAlgae.SetStep2Dose(const Value: single);
begin
  Step2Dose := Value;
end;

procedure TAlgae.SetStep2PartNo(const Value: string);
begin
  Step2PartNo := Value;
end;

end.
