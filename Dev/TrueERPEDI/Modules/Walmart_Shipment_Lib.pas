unit Walmart_Shipment_Lib;

interface

Uses BusobjWalmartOrders, BusObjSales, ShipConfirmRequestV33, classes , busobjbase;

function WalmartorderToShiplXML(aOrderID:Integer; aOrderLineIDs:TStringList; Cancelreason :String ; conn : TMyDAcDataconnection=nil):IXMLOrderShipment;
function WalmartOrderhasshipmentinfo(aOrderID:Integer; conn : TMyDAcDataconnection=nil):Boolean;
Function ERPOrder(AWalmartOrder :TWalmartOrders) :TSalesorder;

implementation

uses CK_DLL_Const , sysutils,XMLDoc,
  CommonDbLib, Walmart_Lib, CommonLib, ShipIntegrationTypes;

function WalmartOrderhasshipmentinfo(aOrderID:Integer; conn : TMyDAcDataconnection=nil):Boolean;
var
  AWalmartOrder       :TWalmartOrders;
begin
  Result := False;
      AWalmartOrder := TWalmartOrders.Create(nil);
      try
        if conn <> nil then AWalmartOrder.connection := conn
        else begin
          AWalmartOrder.connection := TMyDAcDataconnection.Create(AWalmartOrder);
          AWalmartOrder.connection.Connection := GetNewMyDacConnection(AWalmartOrder);
        end;
        AWalmartOrder.Load(aOrderID);
        if AWalmartOrder.count =0 then exit;

        with ERPOrder(AWalmartOrder) do try
(*          result := (count =1) and (SalesShippingDetails.ShipDate<>0) and
                    ((SalesShippingDetails.CarrierName <> '' ) or  (SalesShippingDetails.OtherCarrier<>'')) and
                    (SalesShippingDetails.MethodCode<>'') and
                    (SalesShippingDetails.TrackingNumber<>'') and
                    (SalesShippingDetails.TrackingURL<>'') ;*)
          result := (count =1);
          if result then result := (SalesShipments.ShipDate<>0) or (Shipdate <>0) ; // takes salesorders shipdate if shipment shipdate is 0
          if result then result := (SalesShipments.ProviderName <> '' )  ;
          if result then result := (SalesShipments.MasterTrackingNumber<>'');
(*          {orders with lines more than 1, should have asn details}
          if result then
            result := (AWalmartOrder.lines.count =1) or
              ((SalesShippingDetails.PackageASN<>'') and (SalesShippingDetails.PalletASN<>''));*)
        finally
          Free;
        end;
      finally
        FreeandNil(AWalmartOrder);
      end;
end;
Function ERPOrder(AWalmartOrder       :TWalmartOrders) :TSalesorder;
begin
    REsult := TSalesOrder.Create(nil);
    REsult.connection :=AWalmartOrder.connection;
    if AWalmartOrder.ERPSalesRef = '' then REsult.Load(0)
    else Result.loadSelect('Globalref =' +quotedstr(AWalmartOrder.ERPSalesRef));
end;

function WalmartorderToShiplXML(aOrderID:Integer; aOrderLineIDs:TStringList; Cancelreason :String ; conn : TMyDAcDataconnection=nil):IXMLOrderShipment;
var
  XMLOrderShipment : IXMLOrderShipment;
  aOrderLine : IXMLShippingLineType;
  aXMLShipLineStatus: IXMLShipLineStatusType;
  AWalmartOrder       :TWalmartOrders;

  Function IsLinetoShip(const aID:Integer):Boolean;
  var
    i:Integer;
  begin
    result := True;
(*    Exit;
    {To-Do Walmart all lines are shipped when shipped the order -
    should be able to select lines and create BO for the rest , should be dealt with later}

    result := False;
    if devmode then begin
      result := True;
      exit;
    end;*)
    if aOrderLineIDs = nil then exit;
    if aOrderLineIDs.Count =0 then exit;
    for i := 0 to aOrderLineIDs.Count-1 do
      if strtoint(aOrderLineIDs[i]) = aid then begin
        result := not (AWalmartOrder.Lines.LineStatuses.Locate('OrderStatus' , 'Shipped' , [])); // if already cancelled, its not possible to cancel again
        exit;
      end;
    result := False;
  end;
  function TrackingURL(Const Trackno:String):String;
  begin
    if sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.Carrier , 'fedEx') or
       sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.OtherCarrier , 'fedEx') then
          Result := 'https://www.fedex.com/apps/fedextrack/?action=track&trackingnumber=' + trim(Trackno)
    else if sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.Carrier , 'UPS') or
            sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.OtherCarrier , 'UPS') then
                Result := 'https://www.ups.com/track'
    else if sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.Carrier , 'US Postal Service') or
            sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.OtherCarrier , 'US Postal Service') or
            sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.Carrier , 'USPS') or
            sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.OtherCarrier , 'USPS') then
                Result := 'https://tools.usps.com/go/TrackConfirmAction_input'
    else if sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.Carrier , 'Canada Post') or
            sametext(aXMLShipLineStatus.TrackingInfo.CarrierName.OtherCarrier , 'Canada Post') then
                Result := 'https://www.canadapost.ca/trackweb/en#/home'
    else Result := 'https://www.fedex.com/apps/fedextrack/?action=track&trackingnumber=' + trim(Trackno);

  end;
begin
  { TODO : At the moment cancellation is whole quantity. It should be possible to cancel partially as well}
  XMLOrderShipment := NewXMLDocument.GetDocBinding('orderShipment', TXMLOrderShipment, WALMART_Order_TargetNameSpace ) as IXMLOrderShipment;
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
            if IsLinetoShip(AWalmartOrder.Lines.Id) then begin
              aOrderLine:= XMLOrderShipment.OrderLines.add;
              aOrderLine.LineNumber := AWalmartOrder.Lines.Linenumber;
              aXMLShipLineStatus := aOrderLine.OrderLineStatuses.add;
              aXMLShipLineStatus.status := 'Shipped';
              aXMLShipLineStatus.StatusQuantity.UnitOfMeasurement := AWalmartOrder.Lines.UOM;
              aXMLShipLineStatus.StatusQuantity.Amount:= Floattostr(AWalmartOrder.Lines.QtySold);

              {TODO : Walmart : not cattered for back order sales orders at the moment - so details are taken from the Sales Order  }
              with ERPOrder(AWalmartOrder) do try
                if count =1 then begin


(*                    aXMLShipLineStatus.Asn.packageASN := SalesShippingDetails.packageASN;
                    aXMLShipLineStatus.Asn.palletASN := SalesShippingDetails.palletASN;*)

(*                    aXMLShipLineStatus.TrackingInfo.ShipDateTime        := DatetoValue(SalesShippingDetails.ShipDate);
                    if SalesShippingDetails.CarrierName <> '' then
                      aXMLShipLineStatus.TrackingInfo.CarrierName.Carrier := SalesShippingDetails.CarrierName
                    else aXMLShipLineStatus.TrackingInfo.CarrierName.OtherCarrier :=  SalesShippingDetails.OtherCarrier;
                    aXMLShipLineStatus.TrackingInfo.MethodCode          := SalesShippingDetails.MethodCode;
                    aXMLShipLineStatus.TrackingInfo.TrackingNumber      := SalesShippingDetails.TrackingNumber;
                    aXMLShipLineStatus.TrackingInfo.TrackingURL         := SalesShippingDetails.TrackingURL;*)

                    if SalesShipments.ShipDate <> 0 then
                         aXMLShipLineStatus.TrackingInfo.ShipDateTime        := DatetoValue(SalesShipments.ShipDate)
                    else aXMLShipLineStatus.TrackingInfo.ShipDateTime        := DatetoValue(ShipDate);
                    aXMLShipLineStatus.TrackingInfo.CarrierName.Carrier := SalesShipments.ProviderName;
                    { TODO : Walmart - Methodcode hard coded as its required field for the API -
                    For Walmart, the shipping method can be one of the following: Standard, Express, Oneday, or Freight }
                    aXMLShipLineStatus.TrackingInfo.MethodCode          := ServiceTypetoWalmartmethodCode(SalesShipments.Provider , SalesShipments.Servicetype);//'Standard';

                    aXMLShipLineStatus.TrackingInfo.TrackingNumber      := SalesShipments.MasterTrackingNumber;
                    aXMLShipLineStatus.TrackingInfo.TrackingURL         := TrackingURL(SalesShipments.MasterTrackingNumber);{ TODO : Walmart - TrackingURL hard coded as its required field for the API }
                end;
              finally
                Free;
              end;
              (*{connection passed to the function is within transaction.
              Will be committed only when the POSt to walmart is successfull}
              //WalmartOrderStatus should be updated, but I think that gets updated after conversion
              // LineStatusea object should be updated from Walmart site
              AWalmartOrder.Lines.LineStatusea.New;
              AWalmartOrder.Lines.LineStatuses.OrderStatus := 'Shipped';
              AWalmartOrder.Lines.LineStatuses.StatusQuantity :=AWalmartOrder.Lines.QtySold;
              AWalmartOrder.Lines.LineStatuses.UOM :=AWalmartOrder.Lines.UOM;
              AWalmartOrder.Lines.LineStatuses.PostDB;
              //IXMLCancelLineStatusType*)
            end;
            AWalmartOrder.Lines.Next;
          end;
        end;
      finally
        FreeandNil(AWalmartOrder);
      end;
  finally
    Result :=  XMLOrderShipment;
  end;
end;

end.
