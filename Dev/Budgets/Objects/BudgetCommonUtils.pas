unit BudgetCommonUtils;

interface

uses
  Classes;

type
  TBudgetNo = class(TCollectionItem)
  private
    fiBudgetNo: integer;
    fdStartDate: TDatetime;
    fdEndDate: TDatetime;
    fbBudgetRecExists: boolean;
  public
    property BudgetNo: integer read fiBudgetNo write fiBudgetNo;
    property StartDate: TDatetime read fdStartDate write fdStartDate;
    property EndDate: TDatetime read fdEndDate write fdEndDate;
    property BudgetRecExists: boolean read fbBudgetRecExists write fbBudgetRecExists;
  end;
  TBudgetNos = class(TCollection)
  private
    function GetItem(const Index: integer): TBudgetNo;
    procedure SetItem(const Index: integer; Value: TBudgetNo);
  public
    IsEmpty : Boolean;
    function Add: TBudgetNo;
    property Items[const Index: integer]: TBudgetNo read GetItem write SetItem; default;
    function FindItem(const fiBudgetNo: integer): TBudgetNo;
    constructor Create;
  end;

implementation

function TBudgetNos.GetItem(const Index: integer): TBudgetNo;
begin
  Result := TBudgetNo(inherited GetItem(Index));
end;

procedure TBudgetNos.SetItem(const Index: integer; Value: TBudgetNo);
begin
  inherited SetItem(Index, Value);
end;

function TBudgetNos.Add: TBudgetNo;
begin
  Result := TBudgetNo(inherited Add);
  IsEmpty:= False;
end;
constructor TBudgetNos.Create;
begin
  inherited Create(TBudgetNo);
  IsEmpty := True;
end;
function TBudgetNos.FindItem(const fiBudgetNo: integer): TBudgetNo;
var
  ctr: integer;
begin
  Result := nil;
  for Ctr := 0 to Count - 1 do if Items[ctr].Budgetno = fiBudgetNo then Result := Items[ctr];
end;

end.
