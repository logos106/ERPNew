unit Walmart_Inventory_Lib;

interface

uses classes, busobjbase , Inventory, CK_DLLCommon_WalmartLib , CK_DLL_Const;

function WalmartOrderToUpdateInvXML(aOrderID:Integer; aOrderLineID:String; conn : TMyDAcDataconnection=nil; LoginList: TLogProc = nil):IXMLInventory;Overload;
function WalmartOrderToUpdateInvXML(const aSKU, aUOM:String; const AvailableQty : double):IXMLInventory;Overload;

implementation

uses BusobjWalmartOrders, BusobjBaseProdTrans , XMLDoc,
  CommonDbLib, sysutils, CK_DLL_WalmartLib;

function WalmartOrderToUpdateInvXML(const aSKU, aUOM:String; const AvailableQty : double):IXMLInventory;
var
  XMLInventory : IXMLInventory;
//  AWalmartOrder       :TWalmartOrders;
begin
  XMLInventory := NewXMLDocument.GetDocBinding('inventory', TXMLInventory, WALMART_TargetNameSpace ) as IXMLInventory;
  try
              XMLInventory.sku := asku;
              //XMLInventory.AvailabilityCode := 'AC'; {TODO : Walmart - possible values are AC / AA / PO}
              XMLInventory.Quantity.Unit_ := aUOM ;
              XMLInventory.Quantity.Amount := Floattostr(AvailableQty);
              XMLInventory.fulfillmentLagTime  := 1;
              //XMLInventory.Quantity.AvailableToSell := XMLInventory.Quantity.Amount;
  finally
    REsult :=  XMLInventory;
  end;
end;

function WalmartOrderToUpdateInvXML(aOrderID:Integer; aOrderLineID:String; conn : TMyDAcDataconnection=nil; LoginList: TLogProc = nil ):IXMLInventory;
var
  XMLInventory : IXMLInventory;
  AWalmartOrder       :TWalmartOrders;
  errMsg :String;
(* Function IsLineCancelled(const aID:Integer):Boolean;
  begin
    result :=  (AWalmartOrder.Lines.Id = strtoint(aOrderLineID)) and
      AWalmartOrder.Lines.LineStatuses.Locate('OrderStatus' , 'Cancelled' , []);
  end;*)
begin
  //XMLInventory := NewXMLDocument.GetDocBinding('', TXMLInventory, WALMART_Order_TargetNameSpace ) as IXMLInventory;
  try
      AWalmartOrder := TWalmartOrders.Create(nil);
      try
        if conn <> nil then AWalmartOrder.connection := conn
        else begin
          AWalmartOrder.connection := TMyDAcDataconnection.Create(AWalmartOrder);
          AWalmartOrder.connection.Connection := GetNewMyDacConnection(AWalmartOrder);
        end;
        AWalmartOrder.Load(aOrderID);
        if AWalmartOrder.count =0 then exit;
        if aOrderLineID <> '' then begin
        if AWalmartOrder.Lines.Locate('ID' , strtoint(aOrderLineID) , []) then begin
            if AWalmartOrder.Lines.LineStatuses.Locate('OrderStatus' , 'Cancelled' , []) then begin
              XMLInventory := WalmartOrderToUpdateInvXML(AWalmartOrder.Lines.sku, AWalmartOrder.Lines.UOM   , ItemStockQty(AWalmartOrder.Lines.sku , errMsg , nil)+ AWalmartOrder.Lines.QtySold);
            end;
        end;
        end else begin
          AWalmartOrder.Lines.First;
          while AWalmartOrder.Lines.EOF = false do begin
            //if AWalmartOrder.Lines.LineStatuses.Locate('OrderStatus' , 'Cancelled' , []) then begin
              XMLInventory := WalmartOrderToUpdateInvXML(AWalmartOrder.Lines.sku, AWalmartOrder.Lines.UOM   , ItemStockQty(AWalmartOrder.Lines.sku , errMsg , nil)+ AWalmartOrder.Lines.QtySold);
               { TODO :
                    Walmart - As lineIds are not passed into it, its all lines.
                    Not checking ofr the status for the time being as Cancellation for whole order at the moemnt.
                    Also the lines object's status is only updated when the 'getOrders' done next time }
              if UpdateWalmartinv(XMLInventory.SKU , XMLInventory.XML,errmsg,  LoginList) then begin
              end else begin
                      // ignore inv stock update for the time being -> not sure y not working :(
                      //break;
              end;
            //end;
            AWalmartOrder.Lines.Next;
          end;
        end;
        (*if AWalmartOrder.Lines.count> 0 then begin
          AWalmartOrder.Lines.first;
          while AWalmartOrder.Lines.eof = false do begin
            if IsLineCancelled(AWalmartOrder.Lines.Id) then begin
              XMLInventory.sku := AWalmartOrder.Lines.sku;
              XMLInventory.AvailabilityCode := 'AC'; {TODO : Walmart - possible values are AC / AA / PO}
              XMLInventory.Quantity.Unit_ := AWalmartOrder.Lines.UOM ;
              XMLInventory.Quantity.Amount := Floattostr(ItemStockQty(AWalmartOrder.Lines.sku , errMsg , nil)+ AWalmartOrder.Lines.QtySold);
              XMLInventory.Quantity.AvailableToSell := XMLInventory.Quantity.Amount;
            end;
            AWalmartOrder.Lines.Next;
          end;
        end;*)
      finally
        FreeandNil(AWalmartOrder);
      end;
  finally
    REsult :=  XMLInventory;
  end;

end;

end.
