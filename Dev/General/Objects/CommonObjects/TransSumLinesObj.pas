unit TransSumLinesObj;

interface

uses
  contnrs;

type

  TTransLineSumRec = class
  public
    ClassId: integer;
    AmountEx: double;
    AmountInc: double;
    Discount:Double;
    Tax: double;
  end;

  TTransLineSum = class
  private
    fList: TObjectList;
    fSumAmountEx: double;
    fSumTax: double;
    fSumAmountInc: double;
    fSumTotaldiscount: double;
    function GetItemByClassId(aClassId: integer): TTransLineSumRec;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property ItemByClassId[aClassId: integer]: TTransLineSumRec read GetItemByClassId;
    procedure Add(aClassId: integer; aAmountEx, aAmountInc, aTax,aDiscount: double);
    procedure SumTotals(RoundTotals: boolean = true; RoundLines: boolean = false);
    property SumAmountEx: double read fSumAmountEx;
    property SumAmountInc: double read fSumAmountInc;
    property SumTax: double read fSumTax;
    property SumTotaldiscount: double read fSumTotaldiscount;
  end;


implementation

uses
  CommonLib, classes, tcConst;

{ TTransLineSum }

procedure TTransLineSum.Add(aClassId: integer; aAmountEx, aAmountInc,
  aTax,aDiscount: double);
var
  rec: TTransLineSumRec;
  x: integer;
begin
  rec:= nil;
  for x:= 0 to fList.Count -1 do begin
    if TTransLineSumRec(fList[x]).ClassId = aClassId then begin
      rec:= TTransLineSumRec(fList[x]);
      break;
    end;
  end;
  if not Assigned(rec) then begin
    rec:= TTransLineSumRec.Create;
    rec.ClassId:= aClassId;
    fList.Add(rec);
  end;
  rec.AmountEx:= rec.AmountEx + aAmountEx;
  rec.AmountInc:= rec.AmountInc + aAmountInc;
  rec.Discount:= rec.Discount + aDiscount;
  rec.Tax:= rec.Tax + aTax;
end;

procedure TTransLineSum.Clear;
begin
  fList.Clear;
end;

constructor TTransLineSum.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TTransLineSum.Destroy;
begin
  fList.Free;
  inherited;
end;

function TTransLineSum.GetItemByClassId(
  aClassId: integer): TTransLineSumRec;
var
  x: integer;  
begin
  result:= nil;
  for x:= 0 to fList.Count -1 do begin
    if TTransLineSumRec(fList[x]).ClassId = aClassId then begin
      result:= TTransLineSumRec(fList[x]);
      break;
    end;
  end;
end;

procedure TTransLineSum.SumTotals(RoundTotals: boolean = true; RoundLines: boolean = false);
var
  x: integer;
begin

  fSumAmountEx:= 0;
  fSumTax:= 0;
  fSumAmountInc:= 0;
  fSumTotaldiscount := 0;
  for x:= 0 to fList.Count-1 do begin
    if RoundLines then begin
      fSumAmountEx:= fSumAmountEx + Round(TTransLineSumRec(fList[x]).AmountEx,CurrencyRoundPlaces);
      fSumTotaldiscount:= fSumTotaldiscount + Round(TTransLineSumRec(fList[x]).Discount,CurrencyRoundPlaces);
      fSumTax:= fSumTax + Round(TTransLineSumRec(fList[x]).Tax,CurrencyRoundPlaces);
    end
    else begin
      fSumAmountEx:= fSumAmountEx + TTransLineSumRec(fList[x]).AmountEx;
      fSumTotaldiscount:= fSumTotaldiscount + TTransLineSumRec(fList[x]).Discount;
      fSumTax:= fSumTax + TTransLineSumRec(fList[x]).Tax;
    end;
  end;
  fSumAmountInc := fSumAmountEx + fSumTax;
  if RoundTotals then begin
    fSumAmountEx:= Round(fSumAmountEx,CurrencyRoundPlaces);
    fSumAmountInc:= Round(fSumAmountInc,CurrencyRoundPlaces);
    fSumTotaldiscount:=Round(fSumTotaldiscount,CurrencyRoundPlaces);
    fSumTax:= Round(fSumTax,CurrencyRoundPlaces);
  end;
end;

end.
