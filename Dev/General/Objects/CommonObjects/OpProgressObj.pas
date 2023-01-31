unit OpProgressObj;

interface

uses
  classes;

type
  TOperationProgress = class(TPersistent)
  private
    FStepCount: int64;
    FStepNo: int64;
    FOperationName: string;
    FDetail: string;
    FSubOperationName: string;
    FTimeStart: TDateTime;
    FTimeEnd: TDateTime;
    FTimeLast: TDateTime;
  public
    constructor Create;
    procedure Clear;
  published
    property OperationName: string read FOperationName write FOperationName;
    property SubOperationName: string read FSubOperationName write FSubOperationName;
    property Detail: string read FDetail write FDetail;
    property StepNo: int64 read FStepNo write FStepNo;
    property StepCount: int64 read FStepCount write FStepCount;
    property TimeStart: TDateTime read FTimeStart write FTimeStart;
    property TimeEnd: TDateTime read FTimeEnd write FTimeEnd;
    property TimeLast: TDateTime read FTimeLast write FTimeLast;
    function PercentDone: integer;
  end;


implementation

{ TOperationProgress }

procedure TOperationProgress.Clear;
begin
  self.OperationName:= 'None';
  self.SubOperationName:= '';
  self.Detail:= '';
  self.StepNo:= 0;
  self.StepCount:= 0;
  self.TimeStart:= 0;
  self.TimeEnd:= 0;
  self.TimeLast:= 0;
end;

constructor TOperationProgress.Create;
begin
  Clear;
end;

function TOperationProgress.PercentDone: integer;
begin
  result := 0;
  if (StepNo > 0) and (StepCount > 0) then
    result := Round((StepNo / StepCount) * 100);
end;

end.
