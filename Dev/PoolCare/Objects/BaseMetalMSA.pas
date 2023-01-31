unit BaseMetalMSA;

interface

uses
  MyAccess;
  
type
  TBaseMetalMSA = class
  private
    FMaximum: single;
    FMinimum: single;
    FStep1Dose: single;
    FStep1PartNo: string;
    FStep1Rslt: single;
    FStep2Dose: single;
    FStep2PartNo: string;
    FStep2Rslt: single;
    FTargetValue: integer;

    function GetMaximum: single;
    function GetMinimum: single;
    function GetStep1Dose: single;
    function GetStep1PartNo: string;
    function GetStep1Rslt: single;
    function GetStep2Dose: single;
    function GetStep2PartNo: string;
    function GetStep2Rslt: single;
    function GetTargetValue: integer;
    procedure SetMaximum(const Value: single);
    procedure SetMinimum(const Value: single);
    procedure SetStep1Dose(const Value: single);
    procedure SetStep1PartNo(const Value: string);
    procedure SetStep1Rslt(const Value: single);
    procedure SetStep2Dose(const Value: single);
    procedure SetStep2PartNo(const Value: string);
    procedure SetStep2Rslt(const Value: single);
    procedure SetTargetValue(const Value: integer);
  protected
  public
    constructor Create;
    procedure LoadFromDatabase(const CategoryName, TestName: string);
    procedure SaveToDatabase;
    property TargetValue: integer read GetTargetValue write SetTargetValue;
    property Minimum: single read GetMinimum write SetMinimum;
    property Maximum: single read GetMaximum write SetMaximum;
    property Step1PartNo: string read GetStep1PartNo write SetStep1PartNo;
    property Step1Dose: single read GetStep1Dose write SetStep1Dose;
    property Step1Rslt: single read GetStep1Rslt write SetStep1Rslt;
    property Step2PartNo: string read GetStep2PartNo write SetStep2PartNo;
    property Step2Dose: single read GetStep2Dose write SetStep2Dose;
    property Step2Rslt: single read GetStep2Rslt write SetStep2Rslt;
  published
  end;

implementation

uses CommonDbLib, SysUtils;

{ TBaseMetalMSA }

constructor TBaseMetalMSA.Create;
begin
  inherited;
  FTargetValue := 0;
  FMinimum := -1;
  FMaximum := -2;
  FStep1PartNo := 'EMPTY';
  FStep1Dose := -1;
  FStep1Rslt := -1;
  FStep2PartNo := 'EMPTY';
  FStep2Dose := -1;
  FStep2Rslt := -1;
end;

function TBaseMetalMSA.GetMaximum: single;
begin
  Result := FMaximum;
end;

function TBaseMetalMSA.GetMinimum: single;
begin
  Result := FMinimum;
end;

function TBaseMetalMSA.GetStep1Dose: single;
begin
  Result := FStep1Dose;
end;

function TBaseMetalMSA.GetStep1PartNo: string;
begin
  Result := FStep1PartNo;
end;

function TBaseMetalMSA.GetStep1Rslt: single;
begin
  Result := FStep1Rslt;
end;

function TBaseMetalMSA.GetStep2Dose: single;
begin
  Result := FStep2Dose;
end;

function TBaseMetalMSA.GetStep2PartNo: string;
begin
  Result := FStep2PartNo;
end;

function TBaseMetalMSA.GetStep2Rslt: single;
begin
  Result := FStep2Rslt;
end;

function TBaseMetalMSA.GetTargetValue: integer;
begin
  Result := FTargetValue;
end;

procedure TBaseMetalMSA.LoadFromDatabase(const CategoryName, TestName: string);
var
  qryTest: TMyQuery;
begin
  inherited;
  qryTest := TMyQuery.Create(nil);
  try
    qryTest.Options.FlatBuffers := True;
    //qryTest.Connection := fmPoolProfileTest.MyConnection;
    qryTest.Connection := GetSharedMyDacConnection;

    qryTest.SQL.Add('select mmt.*');
    qryTest.SQL.Add('from tblMetalMSATest mmt INNER JOIN tblPoolTestCategories tn ');
    qryTest.SQL.Add('ON mmt.TestCategoriesID = tn.TestCategoriesID');
    qryTest.SQL.Add('WHERE  mmt.name = "' + TestName + '"');
    qryTest.SQL.Add('and tn.name = "' + CategoryName + '"');

    qryTest.Open;
    FStep1Dose   := qryTest.FieldByName('Step1Dose').AsFloat;
    FStep1PartNo := qryTest.FieldByName('Step1PartNo').AsString;
    FStep1Rslt   := qryTest.FieldByName('Step1Rslt').AsFloat;
    FStep2Dose   := qryTest.FieldByName('Step2Dose').AsFloat;
    FStep2PartNo := qryTest.FieldByName('Step2PartNo').AsString;
    FStep2Rslt   := qryTest.FieldByName('Step2Rslt').AsFloat;
    FMaximum     := qryTest.FieldByName('Maximum').AsFloat;
    FMinimum     := qryTest.FieldByName('Minimum').AsFloat;
    FTargetValue := qryTest.FieldByName('TargetValue').AsInteger;

    qryTest.Close;
  finally
    FreeAndNil(qryTest)
  end;
end;

procedure TBaseMetalMSA.SaveToDatabase;
begin
end;

procedure TBaseMetalMSA.SetMaximum(const Value: single);
begin
  FMaximum := Value;
end;

procedure TBaseMetalMSA.SetMinimum(const Value: single);
begin
  FMinimum := Value;
end;

procedure TBaseMetalMSA.SetStep1Dose(const Value: single);
begin
  FStep1Dose := Value;
end;

procedure TBaseMetalMSA.SetStep1PartNo(const Value: string);
begin
  FStep1PartNo := Value;
end;

procedure TBaseMetalMSA.SetStep1Rslt(const Value: single);
begin
  FStep1Rslt := Value;
end;

procedure TBaseMetalMSA.SetStep2Dose(const Value: single);
begin
  FStep2Dose := Value;
end;

procedure TBaseMetalMSA.SetStep2PartNo(const Value: string);
begin
  FStep2PartNo := Value;
end;

procedure TBaseMetalMSA.SetStep2Rslt(const Value: single);
begin
  FStep2Rslt := Value;
end;

procedure TBaseMetalMSA.SetTargetValue(const Value: integer);
begin
  FTargetValue := Value;
end;

end.
