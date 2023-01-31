unit PayTaxableTotalObj;

interface

uses
  ConTnrs;

type

  TTaxAmountList = class;
  TTaxableTotalList = class;
  TTaxableTotal = class
  private
    fTaxAmount: double;
    fRateName: string;
    fID: integer;
    fAmount: double;
    fMSType: string;
    fClassId: integer;
    fTypeName: string;
    fPayLineId: integer;
    fTaxList: TTaxAmountList;
    fList: TTaxableTotalList;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: integer read fID write FID;
    property RateName: string read fRateName write fRateName;
    property TypeName: string read fTypeName write fTypeName;
    property ClassId: integer read fClassId write fClassId;
    property Amount: double read fAmount write fAmount;
    function AmountFraction: double;
    property PayLineId: integer read fPayLineId write fPayLineId;
    property MSType: string read fMSType write fMSType;
    property TaxAmount: double read fTaxAmount write fTaxAmount;
    property TaxList: TTaxAmountList read fTaxList;
    property List: TTaxableTotalList read fList write fList;
  end;

  TTaxAmount = class
  private
    fPayTaxConfigId: integer;
    fTaxAmount: double;
    fTAxType: string;
  public
    property PayTaxConfigId: integer read fPayTaxConfigId write fPayTaxConfigId;
    property TaxAmount: double read fTaxAmount write fTaxAmount;
    property TaxType: string read fTaxType write fTaxType;
  end;

  TTaxAmountList = class
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(Idx: integer): TTaxAmount;
    //function GetTaxById(aPayTaxConfigId: integer): double;
    //procedure SetTaxById(aPayTaxConfigId: integer; const Value: double);
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure Clear;
    property Item[Idx: integer]: TTaxAmount read GetItem; default;
    function AddItem(aPayTaxConfigId: integer; aAmount: double; aTaxType: string): TTaxAmount;
    //property TaxById[aPayTaxConfigId: integer]: double read GetTaxById write SetTaxById;
    function ItemByTaxConfigId(aPayTaxConfigId: integer): TTaxAmount;
    procedure RoundAll(Places: integer);
    function TotalTaxAmount: double;
  end;

  TTaxableTotalList = class
  private
    fList: TObjectList;
    fTaxList: TTaxAmountList;
    function GetItem(idx: integer): TTaxableTotal;
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Item[idx: integer]: TTaxableTotal read GetItem; default;
    function AddItem(aId: integer; aMSType: string): TTaxableTotal;
    property Count: integer read GetCount;
    function TotalAmount: double;
    property TaxList: TTaxAmountList read fTaxList;
    function TotalTaxForRateAndLineID(aRateName: string; aLineId: integer): double;
    procedure ClearAllTax;
  end;

implementation

uses
  CommonLib, SysUtils,Classes;

{ TTaxableTotal }

function TTaxableTotal.AmountFraction: double;
begin
  result := DivZer(Amount,List.TotalAmount);
end;

constructor TTaxableTotal.Create;
begin
  fTaxList := TTaxAmountList.Create;
end;

destructor TTaxableTotal.Destroy;
begin
  fTAxList.Free;
  inherited;
end;

{ TTaxableTotalList }

function TTaxableTotalList.AddItem(aId: integer; aMSType: string): TTaxableTotal;
begin
  result := TTaxableTotal.Create;
  result.ID := aId;
  result.MSType := aMSType;
  result.List := self;
  fList.Add(result);
end;

procedure TTaxableTotalList.Clear;
begin
  fList.Clear;
end;

procedure TTaxableTotalList.ClearAllTax;
var
  x: integer;
begin
  self.TaxList.Clear;
  for x := 0 to Count -1 do
    Item[x].TaxList.Clear;
end;

constructor TTaxableTotalList.Create;
begin
  fList := TObjectList.Create;
  fTaxList := TTaxAmountList.Create;
end;

destructor TTaxableTotalList.Destroy;
begin
  fList.Free;
  fTaxList.Free;
  inherited;
end;

function TTaxableTotalList.GetCount: integer;
begin
  result := fList.Count;
end;

function TTaxableTotalList.GetItem(idx: integer): TTaxableTotal;
begin
  result := TTaxableTotal(fList[idx]);
end;

function TTaxableTotalList.TotalTaxForRateAndLineID(aRateName: string;
  aLineId: integer): double;
var
  x: integer;
  taxTot: TTaxableTotal;
begin
  result := 0;
  for x := 0 to Count -1 do begin
    taxTot := Item[x];
    if SameText(taxTot.RateName, aRateName) and (taxTot.PayLineId = aLineId) then begin
      result := result + taxTot.TaxList.TotalTaxAmount;
    end;
  end;
end;

function TTaxableTotalList.TotalAmount: double;
var
  x: integer;
begin
  result := 0;
  for x := 0 to Count -1 do
    result := result + Item[x].Amount;
end;

{ TTaxAmountList }

function TTaxAmountList.AddItem(aPayTaxConfigId: integer;
  aAmount: double; aTaxType: string): TTaxAmount;
begin
  result := TTaxAmount.Create;
  result.PayTaxConfigId := aPayTaxConfigId;
  result.TaxAmount := aAmount;
  result.TaxType := aTaxType;
  fList.Add(result);
end;

procedure TTaxAmountList.Clear;
begin
  fList.Clear;
end;

constructor TTaxAmountList.Create;
begin
  fList := TObjectList.Create;
end;

destructor TTaxAmountList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TTaxAmountList.GetCount: integer;
begin
  result := fList.Count;
end;

function TTaxAmountList.GetItem(Idx: integer): TTaxAmount;
begin
  result := TTaxAmount(fList[Idx]);
end;

function TTaxAmountList.ItemByTaxConfigId(aPayTaxConfigId: integer): TTaxAmount;
var
  x: integer;
begin
  result := nil;
  for x := 0 to Count -1 do begin
    if Item[x].PayTaxConfigId = aPayTaxConfigId then begin
      result := Item[x];
      break;
    end;
  end;
end;

//function TTaxAmountList.GetTaxById(aPayTaxConfigId: integer): double;
//var
//  x: integer;
//  taRec: TTaxAmount;
//begin
//  result := 0;
//  for x := 0 to fList.Count -1 do begin
//    taRec := TTaxAmount(fList[x]);
//    if taRec.PayTaxConfigId = aPayTaxConfigId then begin
//      result := taRec.TaxAmount;
//      break;
//    end;
//  end;
//end;

procedure TTaxAmountList.RoundAll(Places: integer);
var
  x: integer;
begin
  for x := 0 to Count -1 do
    Item[x].TaxAmount := CommonLib.Round(Item[x].TaxAmount, Places);
end;

//procedure TTaxAmountList.SetTaxById(aPayTaxConfigId: integer;
//  const Value: double);
//var
//  x: integer;
//  taRec: TTaxAmount;
//begin
//  taRec := nil;
//  for x := 0 to fList.Count -1 do begin
//    if TTaxAmount(fList[x]).PayTaxConfigId = aPayTaxConfigId then begin
//      taRec := TTaxAmount(fList[x]);
//      break;
//    end;
//  end;
//  if not Assigned(taRec) then begin
//    taRec := TTaxAmount.Create;
//    taRec.PayTaxConfigId := aPayTaxConfigId;
//    fList.Add(taRec);
//  end;
//  taRec.TaxAmount := Value;
//end;

function TTaxAmountList.TotalTaxAmount: double;
var
  x: integer;
begin
  result := 0;
  for x := 0 to Count -1 do
    result := result + Item[x].TaxAmount;
end;

end.
