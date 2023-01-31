unit ProgressInfoObj;

interface

uses
  classes;

type

  TProgressInfoClass = class of TProgressInfo;

  TProgressInfo = class(TPersistent)
  private
    fMessage: string;
    fCaption: string;
    fMinValue: integer;
    fMaxValue: integer;
    fStep: integer;
    fValue: integer;
    fShowPercent: boolean;
    fActive: boolean;
    function GetShowPercent: boolean;
    procedure SetShowPercent(const Value: boolean);
  protected
    function GetCaption: string; virtual;
    function GetMaxValue: integer;  virtual;
    function GetMessage: string; virtual;
    function GetMinValue: integer; virtual;
    function GetStep: integer; virtual;
    function GetValue: integer; virtual;
    procedure SetCaption(const Value: string); virtual;
    procedure SetMaxValue(const Value: integer); virtual;
    procedure SetMessage(const Value: string); virtual;
    procedure SetMinValue(const Value: integer); virtual;
    procedure SetStep(const Value: integer); virtual;
    procedure SetValue(const Value: integer); virtual;
  public
    constructor Create;
    property Message: string read GetMessage write SetMessage;
    property Caption: string read GetCaption write SetCaption;
    property MinValue: integer read GetMinValue write SetMinValue default 0;
    property MaxValue: integer read GetMaxValue write SetMaxValue default 100;
    property Step: integer read GetStep write SetStep default 10;
    property Value: integer read GetValue write SetValue default 0;
    property ShowPercent: boolean read GetShowPercent write SetShowPercent default True;
    procedure Execute; virtual;
    procedure StepIt; virtual;
    procedure CloseDialog; virtual;
  end;

implementation

{ TProgressInfo }

procedure TProgressInfo.CloseDialog;
begin
  fActive := false;
end;

constructor TProgressInfo.Create;
begin
  inherited;
  fActive := false;
  fCaption := 'Progress';
  fMessage := 'Working...';
  fMinValue := 0;
  fMaxValue := 100;
  fValue := 0;
  fStep := 5;
end;

procedure TProgressInfo.Execute;
begin
  fActive:= true;
end;

function TProgressInfo.GetCaption: string;
begin
  result := fCaption;
end;

function TProgressInfo.GetMaxValue: integer;
begin
  result:= fMaxValue;
end;

function TProgressInfo.GetMessage: string;
begin
  result := fMessage;
end;

function TProgressInfo.GetMinValue: integer;
begin
  result:= fMinValue;
end;

function TProgressInfo.GetShowPercent: boolean;
begin
  result := fShowPercent;
end;

function TProgressInfo.GetStep: integer;
begin
  result := fStep;
end;

function TProgressInfo.GetValue: integer;
begin
  result := fValue;
end;

procedure TProgressInfo.SetCaption(const Value: string);
begin
  fCaption := Value;
end;

procedure TProgressInfo.SetMaxValue(const Value: integer);
begin
  fMaxValue := Value;
end;

procedure TProgressInfo.SetMessage(const Value: string);
begin
  fMessage:= Value;
end;

procedure TProgressInfo.SetMinValue(const Value: integer);
begin
  fMinValue:= Value;
end;

procedure TProgressInfo.SetShowPercent(const Value: boolean);
begin
  fShowPercent := Value;
end;

procedure TProgressInfo.SetStep(const Value: integer);
begin
  fStep := Value;
end;

procedure TProgressInfo.SetValue(const Value: integer);
begin
  fValue :=  Value;
end;

procedure TProgressInfo.StepIt;
begin
  Inc(fValue,fStep);
  if fValue > fMaxValue then
    fValue := fMaxValue;
end;

end.
