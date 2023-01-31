unit BusObjPartQty;

(*
  The following tables are used to track quantities of products:
    tblProductQtyAllocation  Tracks in/out qty for all transactions (Inv, PO etc)
    tblPartQtyLine           Varous current balances per product
    tblProductBinQty         Balance per Bin
    tblProductBatchQty       Balance per Batch
    tblSerialNumber          List of all serial numbers and their status
    tblReservedSerialNos     Temp lock list of serial numbers used by current GUI

*)

interface

uses
  Classes, BusObjNDSBase;

type

  TPartQtyBase = class(TMSBusObjNDS)
  private
    FActive: boolean;
    FUOMMultiplier: double;
    FQty: double;
    FUOMQty: double;
    FTransId: integer;
    FBatchId: integer;
    FBinId: integer;
    FUOMId: integer;
    FPartsId: integer;
    FTransLineId: integer;
    FClassId: integer;
    FSerialNumbers: string;
    FTransType: string;
    FStock_In_Out: string;
    FUOM: string;
    FCreationDate: TDateTime;
    fCleanQty: double;
    procedure SetActive(const Value: boolean);
    procedure SetBatchId(const Value: integer);
    procedure SetBinId(const Value: integer);
    procedure SetClassId(const Value: integer);
    procedure SetCreationDate(const Value: TDateTime);
    procedure SetPartsId(const Value: integer);
    procedure SetQty(const Value: double);
    procedure SetSerialNumbers(const Value: string);
    procedure SetStock_In_Out(const Value: string);
    procedure SetTransId(const Value: integer);
    procedure SetTransLineId(const Value: integer);
    procedure SetTransType(const Value: string);
    procedure SetUOM(const Value: string);
    procedure SetUOMId(const Value: integer);
    procedure SetUOMMultiplier(const Value: double);
    procedure SetUOMQty(const Value: double);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property CleanQty: double read fCleanQty write fCleanQty;
  published
    property ClassId: integer read FClassId write SetClassId;
    property BatchId: integer read FBatchId write SetBatchId;
    property BinId: integer read FBinId write SetBinId;
    property PartsId: integer read FPartsId write SetPartsId;
    property TransId: integer read FTransId write SetTransId;
    property TransLineId: integer read FTransLineId write SetTransLineId;
    property TransType: string read FTransType write SetTransType;
    property Stock_In_Out: string read FStock_In_Out write SetStock_In_Out;
    property Qty: double read FQty write SetQty;
    property CreationDate: TDateTime read FCreationDate write SetCreationDate;
    property UOM: string read FUOM write SetUOM;
    property UOMMultiplier: double read FUOMMultiplier write SetUOMMultiplier;
    property UOMQty: double read FUOMQty write SetUOMQty;
    property UOMId: integer read FUOMId write SetUOMId;
    property Active: boolean read FActive write SetActive;
    property SerialNumbers: string read FSerialNumbers write SetSerialNumbers;
  end;

  TPartQty = class(TPartQtyBase)
  private
    fBinBatchList: TBusObjNDSList;
    procedure LoadBinBatchList(const aTransId, aTransLineId: integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BinBatchList: TBusObjNDSList read fBinBatchList;
    procedure Load(const aTransId, aTransLineId: integer); overload;
    procedure Load; override;
    procedure Load(Const aId: integer); override;
  published
    property ClassId;
    property PartsId;
    property TransId;
    property TransLineId;
    property TransType;
    property Stock_In_Out;
    property Qty;
    property CreationDate;
    property UOM;
    property UOMMultiplier;
    property UOMQty;
    property UOMId;
    property Active;
    property SerialNumbers;
  end;

  TPartQtyBinBatch = class(TPartQtyBase)
  published
    property BatchId;
    property BinId;
    property Active;
    property SerialNumbers;
  end;

implementation

uses
  FastFuncs;

{ TPartQtyBase }

constructor TPartQtyBase.Create(AOwner: TComponent);
begin
  inherited;
  fIdFieldName:= 'Id';
  fBusObjectTableName:= 'tblProductQtyAllocation';
end;

procedure TPartQtyBase.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TPartQtyBase.SetBatchId(const Value: integer);
begin
  FBatchId := Value;
end;

procedure TPartQtyBase.SetBinId(const Value: integer);
begin
  FBinId := Value;
end;

procedure TPartQtyBase.SetClassId(const Value: integer);
begin
  FClassId := Value;
end;

procedure TPartQtyBase.SetCreationDate(const Value: TDateTime);
begin
  FCreationDate := Value;
end;

procedure TPartQtyBase.SetPartsId(const Value: integer);
begin
  FPartsId := Value;
end;

procedure TPartQtyBase.SetQty(const Value: double);
begin
  FQty := Value;
end;

procedure TPartQtyBase.SetSerialNumbers(const Value: string);
begin
  FSerialNumbers := Value;
end;

procedure TPartQtyBase.SetStock_In_Out(const Value: string);
begin
  FStock_In_Out := Value;
end;

procedure TPartQtyBase.SetTransId(const Value: integer);
begin
  FTransId := Value;
end;

procedure TPartQtyBase.SetTransLineId(const Value: integer);
begin
  FTransLineId := Value;
end;

procedure TPartQtyBase.SetTransType(const Value: string);
begin
  FTransType := Value;
end;

procedure TPartQtyBase.SetUOM(const Value: string);
begin
  FUOM := Value;
end;

procedure TPartQtyBase.SetUOMId(const Value: integer);
begin
  FUOMId := Value;
end;

procedure TPartQtyBase.SetUOMMultiplier(const Value: double);
begin
  FUOMMultiplier := Value;
end;

procedure TPartQtyBase.SetUOMQty(const Value: double);
begin
  FUOMQty := Value;
end;

{ TPartQty }

constructor TPartQty.Create(AOwner: TComponent);
begin
  inherited;
  fBinBatchList:= TBusObjNDSList.Create(self);
  fBinBatchList.ItemClassName:= 'TPartQtyBinBatch';
  fBinBatchList.LoadSql:= '';
end;

destructor TPartQty.Destroy;
begin

  inherited;
end;

procedure TPartQty.Load(const aTransId, aTransLineId: integer);
begin
  LoadSelect('TransId = ' + FastFuncs.IntToStr(aTransId) +
    ' and TransLineId = ' + FastFuncs.IntToStr(aTransLineId) +
    ' and BatchId = 0 and BinId = 0');
  fCleanQty:= self.Qty;
  LoadBinBatchList(aTransId, aTransLineId);
end;

procedure TPartQty.Load;
begin
  if (self.TransId > 0) and (self.TransLineId > 0) then begin
    LoadSelect('TransId = ' + FastFuncs.IntToStr(TransId) +
      ' and TransLineId = ' + FastFuncs.IntToStr(TransLineId) +
      ' and BatchId = 0 and BinId = 0');
  end
  else
    inherited;

  fCleanQty:= self.Qty;
  LoadBinBatchList(self.TransId, self.TransLineId);
  self.Dirty:= false;
end;

procedure TPartQty.Load(const aId: integer);
begin
  inherited;
  fCleanQty:= self.Qty;
  LoadBinBatchList(self.TransId, self.TransLineId);
  self.Dirty:= false;
end;

procedure TPartQty.LoadBinBatchList(const aTransId, aTransLineId: integer);
var
  x: integer;
begin
  fBinBatchList.Clear();
  fBinBatchList.LoadSql:= 'select * from ' + self.BusObjectTableName +
    ' where TransId = ' + FastFuncs.IntToStr(aTransId) +
    ' and aTransLineIdId = ' + FastFuncs.IntToStr(aTransLineId) +
    ' and (BinId > 0 or BatchId > 0)';
  Storer.LoadList(fBinBatchList);
  for x:= 0 to fBinBatchList.Count -1 do
    TPartQtyBinBatch(fBinBatchList.Item[x]).CleanQty:=
      TPartQtyBinBatch(fBinBatchList.Item[x]).Qty;
end;

end.
