unit BactchReceiveObj;

interface

uses
  BusObjOrders;

type

  TBatchReceive = class(TObject)
  private
    fPurchaseOrder: TPurchaseOrder;
    fShowMessages: boolean;
  public
    constructor Create(aPO: TPurchaseOrder);
    destructor Destroy; override;
    property PurchaseOrder: TPurchaseOrder read fPurchaseOrder write fPurchaseOrder;
    property ShowMessages: boolean read fShowMessages write fShowMessages;
    function ReceiveBatch(aBatchNo: string): boolean;
  end;

implementation

uses
  DB, SysUtils;

{ TBatchReceive }

constructor TBatchReceive.Create(aPO: TPurchaseOrder);
begin
  fPurchaseOrder := aPO;
  fShowMessages := true;
end;

destructor TBatchReceive.Destroy;
begin

  inherited;
end;

function TBatchReceive.ReceiveBatch(aBatchNo: string): boolean;
var
  bm: TBookmark;
  qty: double;
  DoFieldChangewhenDisabled: boolean;
begin
  result := false;
  if not Assigned(PurchaseOrder) then exit;
  PurchaseOrder.Lines.Dataset.DisableControls;
  try
    bm := PurchaseOrder.Lines.Dataset.GetBookmark;
    try
      DoFieldChangewhenDisabled := PurchaseOrder.Lines.DoFieldChangewhenDisabled;
      PurchaseOrder.Lines.DoFieldChangewhenDisabled := true;
      PurchaseOrder.Lines.Dataset.First;
      try
        while not PurchaseOrder.Lines.Dataset.Eof do begin
          PurchaseOrder.Lines.PQA.PQABatch.First;
          while not PurchaseOrder.Lines.PQA.PQABatch.EOF do begin
            if SameText(PurchaseOrder.Lines.PQA.PQABatch.BatchNo, aBatchNo) then begin
              result := true;
              if (PurchaseOrder.Lines.PQA.PQABatch.BOUOMQty <= PurchaseOrder.Lines.UOMQtyBackOrder) then
                qty := PurchaseOrder.Lines.PQA.PQABatch.BOUOMQty
              else
                qty := PurchaseOrder.Lines.UOMQtyBackOrder;
              PurchaseOrder.Lines.UOMQtyShipped := PurchaseOrder.Lines.UOMQtyShipped + qty;
              PurchaseOrder.Lines.PQA.PQABatch.UOMQty := PurchaseOrder.Lines.PQA.PQABatch.UOMQty + qty;
              PurchaseOrder.Lines.PQA.PQABatch.BOUOMQty := PurchaseOrder.Lines.PQA.PQABatch.BOUOMQty - qty;
              PurchaseOrder.Lines.PQA.PQABatch.PostDb;
              exit;
            end;
            PurchaseOrder.Lines.PQA.PQABatch.Next;
          end;
          PurchaseOrder.Lines.Dataset.Next;
        end;
      finally
        PurchaseOrder.Lines.DoFieldChangewhenDisabled := DoFieldChangewhenDisabled;
      end;
      PurchaseOrder.Lines.Dataset.GotoBookmark(bm);
    finally
      PurchaseOrder.Lines.Dataset.FreeBookmark(bm);
    end;
  finally
    PurchaseOrder.Lines.Dataset.EnableControls;
  end;

end;

end.
