unit BaseDefault;

interface

uses
  MyAccess;
  
type
  TBaseDefault = class
  private
    FDecreaseDose: single;
    FDecreasePartNo: string;
    FDecreaseRslt: single;
    FIncreaseDose: single;
    FIncreasePartNo: string;
    FIncreaseRslt: single;
    FMaximum: single;
    FMinimum: single;
    FTargetValue: single;

    function GetDecreaseDose: single;
    function GetDecreasePartNo: string;
    function GetDecreaseRslt: single;
    function GetIncreaseDose: single;
    function GetIncreasePartNo: string;
    function GetIncreaseRslt: single;
    function GetMaximum: single;
    function GetMinimum: single;
    function GetTargetValue: single;
    procedure SetDecreaseDose(const Value: single);
    procedure SetDecreasePartNo(const Value: string);
    procedure SetDecreaseRslt(const Value: single);
    procedure SetIncreaseDose(const Value: single);
    procedure SetIncreasePartNo(const Value: string);
    procedure SetIncreaseRslt(const Value: single);
    procedure SetMaximum(const Value: single);
    procedure SetMinimum(const Value: single);
    procedure SetTargetValue(const Value: single);
  protected
  public
    procedure LoadFromDatabase(Const CategoryName, TestName: string);
    procedure SaveToDatabase;

    property TargetValue: single read GetTargetValue write SetTargetValue;
    property Minimum: single read GetMinimum write SetMinimum;
    property Maximum: single read GetMaximum write SetMaximum;
    property IncreasePartNo: string read GetIncreasePartNo write SetIncreasePartNo;
    property IncreaseDose: single read GetIncreaseDose write SetIncreaseDose;
    property IncreaseRslt: single read GetIncreaseRslt write SetIncreaseRslt;
    property DecreasePartNo: string read GetDecreasePartNo write SetDecreasePartNo;
    property DecreaseDose: single read GetDecreaseDose write SetDecreaseDose;
    property DecreaseRslt: single read GetDecreaseRslt write SetDecreaseRslt;
  published
  end;

implementation

uses
  CommonDbLib, SysUtils;

{ TBaseDefault }

function TBaseDefault.GetDecreaseDose: single;
begin
  Result := FDecreaseDose;
end;

function TBaseDefault.GetDecreasePartNo: string;
begin
  Result := FDecreasePartNo;
end;

function TBaseDefault.GetDecreaseRslt: single;
begin
  Result := FDecreaseRslt;
end;

function TBaseDefault.GetIncreaseDose: single;
begin
  Result := FIncreaseDose;
end;

function TBaseDefault.GetIncreasePartNo: string;
begin
  Result := FIncreasePartNo;
end;

function TBaseDefault.GetIncreaseRslt: single;
begin
  Result := FIncreaseRslt;
end;

function TBaseDefault.GetMaximum: single;
begin
  Result := FMaximum;
end;

function TBaseDefault.GetMinimum: single;
begin
  Result := FMinimum;
end;

function TBaseDefault.GetTargetValue: single;
begin
  Result := FTargetValue;
end;

procedure TBaseDefault.LoadFromDatabase(const CategoryName, TestName: string);
var
  qryTest: TMyQuery;
begin
  qryTest := TMyQuery.Create(nil);
  try
    qryTest.Options.FlatBuffers := True;
    //qryTest.Connection := fmPoolProfileTest.MyConnection;
    qryTest.Connection := GetSharedMyDacConnection;
    qryTest.SQL.Add('select dt.*');
    qryTest.SQL.Add('from tblpoolDefaultTest dt INNER JOIN tblPoolTestCategories tn ');
    qryTest.SQL.Add('ON dt.TestCategoriesID = tn.TestCategoriesID');
    qryTest.SQL.Add('and dt.name = "' + TestName + '"');
    qryTest.SQL.Add('and (tn.name = "' + CategoryName + '"');
    qryTest.SQL.Add('or tn.TestCategoriesID = ' + CategoryName + ')');

    qryTest.Open;
{    qryTest.SQL.Add('SELECT dt.DefaultTestID, dt.TestCategoriesID,');
    qryTest.SQL.Add('    dt.Name, dt.TargetValue, dt.Minimum, dt.Maximum,');
    qryTest.SQL.Add('    dt.DecreaseDose, dt.DecreaseRslt, dt.IncreaseDose, dt.IncreasePartNo,');
    qryTest.SQL.Add('    dt.IncreaseRslt, IncreaseParts.PartName as IncreasePartNo,');
    qryTest.SQL.Add('    DecreaseParts.PartName as DecreasePartNo');
    qryTest.SQL.Add('    FROM ((tblpooldefaulttest  dt INNER JOIN tblpooltestcategories  tn');
    qryTest.SQL.Add('    ON dt.TestCategoriesID = tn.TestCategoriesID) LEFT JOIN');
    qryTest.SQL.Add('    tblparts  DecreaseParts');
    qryTest.SQL.Add('    ON dt.DecreasePartID = DecreaseParts.PARTSID)');
    qryTest.SQL.Add('    LEFT JOIN tblparts AS IncreaseParts');
    qryTest.SQL.Add('    ON dt.DecreasePartID = IncreaseParts.PARTSID');
    qryTest.SQL.Add(' where  dt.name = "' + TestName + '"');
    qryTest.SQL.Add(' and tn.name = "' + CategoryName + '"');
}
    qryTest.Open;
    FDecreaseDose   := qryTest.FieldByName('DecreaseDose').AsFloat;
    FDecreasePartNo := qryTest.FieldByName('DecreasePartID').AsString;
    FDecreaseRslt   := qryTest.FieldByName('DecreaseRslt').AsFloat;
    FIncreaseDose   := qryTest.FieldByName('IncreaseDose').AsFloat;
    FIncreasePartNo := qryTest.FieldByName('IncreasePartID').AsString;
    FIncreaseRslt   := qryTest.FieldByName('IncreaseRslt').AsFloat;
    FMaximum        := qryTest.FieldByName('Maximum').AsFloat;
    FMinimum        := qryTest.FieldByName('Minimum').AsFloat;
    FTargetValue    := qryTest.FieldByName('TargetValue').AsFloat;
    qryTest.Close;

  finally
    FreeAndNil(qryTest)
  end;
end;

procedure TBaseDefault.SaveToDatabase;
begin
end;

procedure TBaseDefault.SetDecreaseDose(const Value: single);
begin
  FDecreaseDose := Value;
end;

procedure TBaseDefault.SetDecreasePartNo(const Value: string);
begin
  FDecreasePartNo := Value;
end;

procedure TBaseDefault.SetDecreaseRslt(const Value: single);
begin
  FDecreaseRslt := Value;
end;

procedure TBaseDefault.SetIncreaseDose(const Value: single);
begin
  FIncreaseDose := Value;
end;

procedure TBaseDefault.SetIncreasePartNo(const Value: string);
begin
  FIncreasePartNo := Value;
end;

procedure TBaseDefault.SetIncreaseRslt(const Value: single);
begin
  FIncreaseRslt := Value;
end;

procedure TBaseDefault.SetMaximum(const Value: single);
begin
  FMaximum := Value;
end;

procedure TBaseDefault.SetMinimum(const Value: single);
begin
  FMinimum := Value;
end;

procedure TBaseDefault.SetTargetValue(const Value: single);
begin
  FTargetValue := Value;
end;

end.
