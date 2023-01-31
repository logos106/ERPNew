unit Walmart_Cancel_Lib;

interface

uses CancelRequestV33, classes, busobjbase;

function WalmartorderToCancelXML(aOrderID:Integer; aOrderLineIDs:TStringList; Cancelreason :String ; conn : TMyDAcDataconnection=nil):IXMLOrderCancellation;

implementation

uses XMLIntf,  BusobjWalmartOrders, CK_DLL_Const, xmlDoc,CommonDBLib, sysutils,
  CommonLib, tcConst;


function WalmartorderToCancelXML(aOrderID:Integer; aOrderLineIDs:TStringList; Cancelreason :String ; conn : TMyDAcDataconnection=nil):IXMLOrderCancellation;
var
  XMLOrderCancellation : IXMLOrderCancellation;
  AWalmartOrder       :TWalmartOrders;
  IXMLCancelLine : IXMLCancelLineType;
  IXMLCancelLineStatus : IXMLCancelLineStatusType;
  Function IsLinetoCancel(const aID:Integer):Boolean;
  var
    i:Integer;
  begin
    result := False;
    if aOrderLineIDs = nil then begin
      result := True;
      Exit;
    end;
    if aOrderLineIDs.Count =0 then exit;
    if devmode then begin
      REsult := True;
      Exit;
    end;
    for i := 0 to aOrderLineIDs.Count-1 do
      if strtoint(aOrderLineIDs[i]) = aid then begin
        result := not (AWalmartOrder.Lines.LineStatuses.Locate('OrderStatus' , 'Cancelled' , [])); // if already cancelled, its not possible to cancel again
        exit;
      end;
  end;
begin
  { TODO : At the moment cancellation is whole quantity. It should be possible to cancel partially as well}
  XMLOrderCancellation := NewXMLDocument.GetDocBinding('orderCancellation', TXMLOrderCancellation, WALMART_Order_TargetNameSpace ) as IXMLOrderCancellation;
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
        if AWalmartOrder.Lines.count> 0 then begin
          AWalmartOrder.Lines.first;
          while AWalmartOrder.Lines.eof = false do begin
            if IsLinetoCancel(AWalmartOrder.Lines.Id) then begin
              IXMLCancelLine := XMLOrderCancellation.OrderLines.Add;
              IXMLCancelLine.LineNumber := AWalmartOrder.Lines.Linenumber;
              IXMLCancelLineStatus := IXMLCancelLine.OrderLineStatuses.Add;
              IXMLCancelLineStatus.Status := WalmartOrderStatus_Cancelled;
              if Cancelreason <> '' then IXMLCancelLineStatus.CancellationReason:= Cancelreason;
              IXMLCancelLineStatus.StatusQuantity.UnitOfMeasurement := AWalmartOrder.Lines.UOM;
              IXMLCancelLineStatus.StatusQuantity.Amount := Floattostr(AWalmartOrder.Lines.QtySold);
              {connection passed to the function is within transaction.
              Will be committed only when the POSt to walmart is successfull}
              AWalmartOrder.Lines.WalmartOrderStatus.New;
              AWalmartOrder.Lines.WalmartOrderStatus.Status := WalmartOrderStatus_Cancelled;
              //AWalmartOrder.Lines.WalmartOrderStatus.StatusQuantity :=AWalmartOrder.Lines.QtySold;
              //if Cancelreason <> '' then AWalmartOrder.Lines.WalmartOrderStatus.CancellationReason := Cancelreason;
              //AWalmartOrder.Lines.WalmartOrderStatus.UOM :=AWalmartOrder.Lines.UOM;
              AWalmartOrder.Lines.WalmartOrderStatus.Synched := True;
              AWalmartOrder.Lines.WalmartOrderStatus.PostDB;
              //IXMLCancelLineStatusType
            end;
            AWalmartOrder.Lines.Next;
          end;
        end;
      finally
        FreeandNil(AWalmartOrder);
      end;
  finally
    REsult :=  XMLOrderCancellation;
  end;
end;

end.
