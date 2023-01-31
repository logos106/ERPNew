unit Walmart_PO_Lib;

interface

uses BusobjWalmartOrders, PurchaseOrderV33, classes , XMLIntf,  XMLDoc, BusObjBase,WalmartRefundObj;

  //Procedure SetWalmartXML(Const XML:String; TreePath:String; Processnode:String; onCreateOrder:TNotifyEvent);
  procedure SetWalmartOrder(const Value: String; onCreateOrder:TNotifyEvent; var nextcursor:String);
  procedure SetWalmartReturns(AOwner:Tcomponent; const Value: String; onUpdateOrder:TNotifyEvent; var nextcursor:String);
  Procedure XMLtoWalmartOrder(XMLOrder :IXMLOrder; onCreateOrder:TNotifyEvent);
  Procedure SaveWalmartRefund(AOwner:TComponent; aWalmartRefundJson:TWalmartRefundJson);
  function WalmartorderToPOXML(aOrderID:Integer; aOrderLineIDs:TStringList; Linestatus :String =''; conn : TMyDAcDataconnection=nil):IXMLOrdersListType;


implementation

uses dialogs, commonlib, sysutils,CK_DLL_Const, Xml, LogLib ,BusobjERPWalmartCommon,BusObjConst, CommonDbLib,
  Walmart_Lib, JSONObject, BusObjERPWalmartRefunds, variants;

(*Procedure SetWalmartXML(Const XML:String; TreePath:String; Processnode:String; onCreateOrder:TNotifyEvent);
var
  Doc: IXMLDocument;
  node: IXMLNode;
  st:TStringlist;
  ctr:Integer;
begin
  if XML = '' then exit;

  node := nil;
  doc:= TXMLDocument.Create(nil);
  try
    doc.LoadFromXML(XML);
    doc.Active:= true;
    if doc.childnodes.count =0 then exit;

    node := nil;
    st:= TStringlist.create;
    try
      st.delimiter := '\';
      st.delimitedText := TreePath;
      for ctr:= 0 to st.count-1 do begin
        if node = nil then
          node:= Doc.ChildNodes.FindNode(st[ctr])
        else
          node:= node.ChildNodes.FindNode(st[ctr]);
      end;
    finally
      Freeandnil(st);
    end;
    if node = nil then node := doc.childnodes.first;

    if node.childnodes.count =0 then exit;
    if node.childnodes.findnode(Processnode) = nil then exit;
    clog('');
    for ctr := 0 to node.childnodes.count -1 do begin
      if sametext(Processnode , 'order') then begin
        Logtext('=============================================================');
        Logtext(node.childnodes[ctr].XML);
        Logtext('=============================================================');
        SetWalmartOrder(node.childnodes[ctr].XML , onCreateOrder);
      end;
    end;
  finally
      doc.active := False;
      doc.XML.clear;
  end;
  end;*)
function WalmartorderToPOXML(aOrderID:Integer; aOrderLineIDs:TStringList; Linestatus :String =''; conn : TMyDAcDataconnection= nil):IXMLOrdersListType;
var
  fieldno             :Integer;
  IXMLOrderLine       :IXMLOrderLineType;
  IXMLCharge          :IXMLChargeType;
  IXMLOrderLineStatus :IXMLOrderLineStatusType;
  IXMLRefundCharge    :IXMLRefundChargeType;
  XMLOrder            :IXMLOrder;
  AWalmartOrder       :TWalmartOrders;
  //fXMLDoc: IXMLDocument;
  //XMLnode            :IXMLnode;

    XMLOrdersList : IXMLOrdersListType;
    XMLElements   : IXMLElementsType ;

  Function IsLinetoUpdate(const aID:Integer):Boolean;
  var
    i:Integer;
  begin
    result := False;
    if aOrderLineIDs.Count =0 then exit;
    for i := 0 to aOrderLineIDs.Count-1 do
      if strtoint(aOrderLineIDs[i]) = aid then begin
        result := true;
        exit;
      end;
  end;
begin
  result := nil;
  fieldno := 0;
(*  fXMLDoc := TXMLDocument.Create(nil);
  fXMLDoc.Active := true;
    fXMLDoc.Version := XMLDocVersion;
    fXMLDoc.Encoding := XMLDocEncoding;
  //XMLOrder :=  TXMLOrder.Create;
  XMLnode:= fXMLDoc.AddChild('list');
  XMLnode.Attributes['DataVersion'] := '';
  XMLnode:= XMLnode.AddChild('elements');
  //XMLOrder:= IXMLOrder(XMLnode.AddChild('order'));*)
  XMLOrdersList := NewXMLDocument.GetDocBinding('list', TXMLOrdersListType, WALMART_Order_TargetNameSpace) as IXMLOrdersListType;
  XMLElements := XMLOrdersList.Elements;

  //XMLOrder := NewXMLDocument.GetDocBinding('order', TXMLORDER, WALMART_Order_TargetNameSpace) as IXMLOrder;
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
        XMLOrdersList.meta.TotalCount :=AWalmartOrder.Lines.count;
        XMLOrder := IXMLOrder(XMLElements.add);
        //if not AWalmartOrder.Lines.locate(AWalmartOrder.Lines.idfieldname, aorderlineid , []) then exit;
              Try fieldno := 1; XMLOrder.purchaseOrderId  := AWalmartOrder.purchaseOrderId ;      Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 2; XMLOrder.customerOrderId  := AWalmartOrder.customerOrderId ;      Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 3; XMLOrder.customerEmailId  := AWalmartOrder.customerEmailId;       Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 4; XMLOrder.orderDate        := DatetoValue(AWalmartOrder.orderDate);Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 5; XMLOrder.BuyerId          := inttoValue(AWalmartOrder.BuyerId);   Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 6; XMLOrder.Mart             := AWalmartOrder.Mart;                  Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 7; XMLOrder.IsGuest          := AWalmartOrder.IsGuest;               Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;

              Try fieldno := 8; XMLOrder.ShippingInfo.Phone := AWalmartOrder.Shippingphone;                                     Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 9; XMLOrder.ShippingInfo.EstimatedDeliveryDate := DatetoValue(AWalmartOrder.EstimatedDeliveryDate);Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 10; XMLOrder.ShippingInfo.EstimatedShipDate := Datetovalue(AWalmartOrder.EstimatedShipDate);       Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 11; XMLOrder.ShippingInfo.MethodCode:= AWalmartOrder.ShippingMethod;                               Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;

              Try fieldno := 12; XMLOrder.ShippingInfo.PostalAddress.Name       := AWalmartOrder.PostalAddressName;       Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 13; XMLOrder.ShippingInfo.PostalAddress.Address1   := AWalmartOrder.PostalAddressAddress1;   Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 14; XMLOrder.ShippingInfo.PostalAddress.Address2   := AWalmartOrder.PostalAddressAddress2;   Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 15; XMLOrder.ShippingInfo.PostalAddress.City       := AWalmartOrder.PostalAddressCity;       Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 16; XMLOrder.ShippingInfo.PostalAddress.State      := AWalmartOrder.PostalAddressState;      Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 17; XMLOrder.ShippingInfo.PostalAddress.PostalCode := AWalmartOrder.PostalAddressPostcode;   Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 18; XMLOrder.ShippingInfo.PostalAddress.Country    := AWalmartOrder.PostalAddressCountry;    Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
              Try fieldno := 19; XMLOrder.ShippingInfo.PostalAddress.AddressType:= AWalmartOrder.PostalAddressAddressType;Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;

              if AWalmartOrder.Lines.count> 0 then begin
                AWalmartOrder.Lines.first;
                while AWalmartOrder.Lines.eof = false do begin
                    IXMLOrderLine:= XMLOrder.OrderLines.Add;
                    Try fieldno := 20; IXMLOrderLine.Linenumber                         := AWalmartOrder.Lines.Linenumber;                  Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 21; IXMLOrderLine.Item.ProductName                   := AWalmartOrder.Lines.ProductName;                 Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 22; IXMLOrderLine.Item.sku                           := AWalmartOrder.Lines.sku;                         Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 23; IXMLOrderLine.OrderLineQuantity.amount           := Doubletovalue(AWalmartOrder.Lines.QtySold);      Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 24; IXMLOrderLine.OrderLineQuantity.UnitOfMeasurement:= AWalmartOrder.Lines.UOM;                         Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 25; IXMLOrderLine.statusDate                         := DatetoValue(AWalmartOrder.Lines.statusDate);     Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 28; IXMLOrderLine.OriginalCarrierMethod              := AWalmartOrder.Lines.OriginalCarrierMethod;       Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 29; IXMLOrderLine.ReferenceLineId                    := AWalmartOrder.Lines.ReferenceLineId;             Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 36; IXMLOrderLine.IntentToCancel                     := AWalmartOrder.Lines.IntentToCancel;              Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 37; IXMLOrderLine.ConfigId                           := AWalmartOrder.Lines.ConfigId;                    Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 20; IXMLOrderLine.Fulfillment.FulfillmentOption      := AWalmartOrder.Lines.FulfillmentOption;           Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 31; IXMLOrderLine.Fulfillment.ShipMethod             := AWalmartOrder.Lines.ShipMethod;                  Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 32; IXMLOrderLine.Fulfillment.StoreId                := AWalmartOrder.Lines.StoreId;                     Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 33; IXMLOrderLine.Fulfillment.OfferId                := AWalmartOrder.Lines.OfferId;                     Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 34; IXMLOrderLine.Fulfillment.PickUpDateTime         := DateToValue(AWalmartOrder.Lines.PickUpDateTime); Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                    Try fieldno := 35; IXMLOrderLine.Fulfillment.PickUpBy               := AWalmartOrder.Lines.PickUpBy;                    Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;

                    if AWalmartOrder.Lines.LineCharges.count >0 then begin
                      AWalmartOrder.Lines.LineCharges.first;
                      While AWalmartOrder.Lines.LineCharges.eof = False do begin
                        IXMLCharge := IXMLOrderLine.Charges.Add;
                        Try fieldno := 38; IXMLCharge.ChargeType             := AWalmartOrder.Lines.LineCharges.ChargeType;                     Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 39; IXMLCharge.ChargeName             := AWalmartOrder.Lines.LineCharges.ChargeName;                     Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 40; IXMLCharge.ChargeAmount.Amount    := Doubletovalue (AWalmartOrder.Lines.LineCharges.ChargeAmount );  Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 41; IXMLCharge.ChargeAmount.Currency  := AWalmartOrder.Lines.LineCharges.ChargeCurrency;                 Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 42; IXMLCharge.Tax.Taxname            := AWalmartOrder.Lines.LineCharges.Taxname;                        Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 43; IXMLCharge.Tax.TaxAmount.amount   := DoubletoValue(AWalmartOrder.Lines.LineCharges.Taxamount);       Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 44; IXMLCharge.Tax.TaxAmount.Currency := AWalmartOrder.Lines.LineCharges.TaxCurrency;                    Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        AWalmartOrder.Lines.LineCharges.next;
                      end;
                    end;

                    if AWalmartOrder.Lines.LineStatuses.count >0 then begin
                      AWalmartOrder.Lines.LineStatuses.First;
                      While AWalmartOrder.Lines.LineStatuses.EOF = False do begin
                        IXMLOrderLineStatus :=  IXMLOrderLine.OrderLineStatuses.Add;
                        if (*(aOrderLineID =AWalmartOrder.Lines.Id)*)IsLinetoUpdate(AWalmartOrder.Lines.Id) and (Linestatus<> '') then begin
                           AWalmartOrder.Lines.LineStatuses.OrderStatus := Linestatus;
                           AWalmartOrder.Lines.LineStatuses.PostDB;
                        end;
                        Try fieldno := 45; IXMLOrderLineStatus.Status                               := AWalmartOrder.Lines.LineStatuses.orderstatus;                  Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 48; IXMLOrderLineStatus.CancellationReason                   := AWalmartOrder.Lines.LineStatuses.CancellationReason;           Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 46; IXMLOrderLineStatus.StatusQuantity.UnitOfMeasurement     := AWalmartOrder.Lines.LineStatuses.UOM;                          Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 47; IXMLOrderLineStatus.StatusQuantity.amount                := doubletovalue(AWalmartOrder.Lines.LineStatuses.StatusQuantity);Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 49; IXMLOrderLineStatus.TrackingInfo.ShipDateTime            := DatetoValue(AWalmartOrder.Lines.LineStatuses.ShipDateTime);    Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 50; IXMLOrderLineStatus.TrackingInfo.CarrierName.OtherCarrier:= AWalmartOrder.Lines.LineStatuses.CarrierNameOtherCarrier;      Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 51; IXMLOrderLineStatus.TrackingInfo.CarrierName.Carrier     := AWalmartOrder.Lines.LineStatuses.CarrierNameCarrier;           Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 52; IXMLOrderLineStatus.TrackingInfo.MethodCode              := AWalmartOrder.Lines.LineStatuses.CarrierMethodCode;            Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 53; IXMLOrderLineStatus.TrackingInfo.TrackingNumber          := AWalmartOrder.Lines.LineStatuses.CarrierTrackingNumber;        Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 54; IXMLOrderLineStatus.TrackingInfo.TrackingURL             := AWalmartOrder.Lines.LineStatuses.CarrierTrackingURL;           Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        AWalmartOrder.Lines.LineStatuses.next;
                      end;
                    end;

                    if AWalmartOrder.Lines.RefundCharges.count > 0 then begin
                      AWalmartOrder.Lines.RefundCharges.First;
                      While AWalmartOrder.Lines.RefundCharges.EOF = False do begin
                        Try fieldno := 26; IXMLOrderLine.Refund.RefundID                    := InttoValue(AWalmartOrder.Lines.RefundID);        Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 27; IXMLOrderLine.Refund.RefundComments              := AWalmartOrder.Lines.RefundComments;              Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        IXMLRefundCharge :=  IXMLOrderLine.Refund.RefundCharges.Add;
                        Try fieldno := 55; IXMLRefundCharge.RefundReason                  := AWalmartOrder.Lines.RefundCharges.RefundReason;                Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 56; IXMLRefundCharge.Charge.ChargeType             := AWalmartOrder.Lines.RefundCharges.ChargeType;                  Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 57; IXMLRefundCharge.Charge.ChargeName             := AWalmartOrder.Lines.RefundCharges.ChargeName;                  Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 58; IXMLRefundCharge.Charge.ChargeAmount.Amount    := doubletovalue(AWalmartOrder.Lines.RefundCharges.ChargeAmount); Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 59; IXMLRefundCharge.Charge.ChargeAmount.Currency  := AWalmartOrder.Lines.RefundCharges.ChargeCurrency ;             Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 60; IXMLRefundCharge.Charge.Tax.TaxName            := AWalmartOrder.Lines.RefundCharges.TaxName;                     Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 61; IXMLRefundCharge.Charge.Tax.TaxAmount.Currency := AWalmartOrder.Lines.RefundCharges.Taxcurrency;                 Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        Try fieldno := 62; IXMLRefundCharge.Charge.Tax.TaxAmount.Amount   := Doubletovalue(AWalmartOrder.Lines.RefundCharges.TaxAmount );   Except  on E:Exception do begin if devmode then logtext(Floattostr(fieldno)+':' +E.message);end; end;
                        AWalmartOrder.Lines.RefundCharges.Next;
                      end;
                    end;

                  AWalmartOrder.Lines.next;
                end;
              end;
      finally
        FreeandNil(AWalmartOrder);
      end;
    finally
      result := XMLOrdersList;
    end;
end;
(*Procedure XMLtoWalmartRefundOrder(XMLReturnOrder : IXMLReturnOrder ; OnCreateOrder:TNotifyEvent);
var
    AWalmartOrder : TWalmartOrders;
begin
   AWalmartOrder := TWalmartOrders.CreateWithNewConn(nil);
    try
      AWalmartOrder.loadselect('purchaseOrderId = ' + XMLReturnOrder.returnOrderId);
      if AWalmartOrder.count = 0 then begin  {add the order if not created already}
        // the order doesn't exists, not possible to return
      end else begin

      end;
    finally

    end;
end;*)
Procedure XMLtoWalmartOrder(XMLOrder :IXMLOrder; onCreateOrder:TNotifyEvent);
var
    AWalmartOrder : TWalmartOrders;
    Ctr3,ctr4,ctr5,ctr6: Integer;
begin
    clog(XMLOrder.xml);
    AWalmartOrder := TWalmartOrders.CreateWithNewConn(nil);
    try
      AWalmartOrder.loadselect('purchaseOrderId = ' + XMLOrder.purchaseOrderId);
      if AWalmartOrder.count = 0 then begin  {add the order if not created already}
        AWalmartOrder.New;
        AWalmartOrder.SalesSource :=   'Walmart';
        Try AWalmartOrder.purchaseOrderId :=            XMLOrder.purchaseOrderId;     Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.customerOrderId :=            XMLOrder.customerOrderId;     Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.customerEmailId :=            XMLOrder.customerEmailId;     Except  on E:Exception do begin  {} end; end;

        Try AWalmartOrder.orderDate       :=  DateValue(XMLOrder.orderDate);          Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.BuyerId         :=   IntValue(XMLOrder.BuyerId);            Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.Mart            :=            XMLOrder.Mart;                Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.IsGuest         :=            XMLOrder.IsGuest;             Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.Shippingphone          :=           XMLOrder.ShippingInfo.Phone;                 Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.EstimatedDeliveryDate  := DateValue(XMLOrder.ShippingInfo.EstimatedDeliveryDate);Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.EstimatedShipDate     := DateValue(XMLOrder.ShippingInfo.EstimatedShipDate);    Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.ShippingMethod        :=           XMLOrder.ShippingInfo.MethodCode;            Except  on E:Exception do begin  {} end; end;

        Try AWalmartOrder.PostalAddressName        := XMLOrder.ShippingInfo.PostalAddress.Name;       Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.PostalAddressAddress1    := XMLOrder.ShippingInfo.PostalAddress.Address1;   Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.PostalAddressAddress2    := XMLOrder.ShippingInfo.PostalAddress.Address2;   Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.PostalAddressCity        := XMLOrder.ShippingInfo.PostalAddress.City;       Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.PostalAddressState       := XMLOrder.ShippingInfo.PostalAddress.State;      Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.PostalAddressPostcode    := XMLOrder.ShippingInfo.PostalAddress.PostalCode; Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.PostalAddressCountry     := XMLOrder.ShippingInfo.PostalAddress.Country;    Except  on E:Exception do begin  {} end; end;
        Try AWalmartOrder.PostalAddressAddressType := XMLOrder.ShippingInfo.PostalAddress.AddressType;Except  on E:Exception do begin  {} end; end;
        AWalmartOrder.PostDB;
      end;
      for Ctr3  := 0 to XMLOrder.OrderLines.count - 1 do begin
          if not AWalmartOrder.Lines.locate('Linenumber' ,  XMLOrder.OrderLines[Ctr3].Linenumber , []) then begin {create the line and its charges if not created already}
            AWalmartOrder.Lines.New;
            Try AWalmartOrder.Lines.Linenumber               :=             XMLOrder.OrderLines[Ctr3].Linenumber;                          Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.ProductName              :=             XMLOrder.OrderLines[Ctr3].Item.ProductName;                    Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.sku                      :=             XMLOrder.OrderLines[Ctr3].Item.sku;                            Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.QtySold                  := Doublevalue(XMLOrder.OrderLines[Ctr3].OrderLineQuantity.amount);           Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.UOM                      :=             XMLOrder.OrderLines[Ctr3].OrderLineQuantity.UnitOfMeasurement; Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.statusDate               :=   DateValue(XMLOrder.OrderLines[Ctr3].statusDate);                         Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.RefundID                 :=    IntValue(XMLOrder.OrderLines[Ctr3].Refund.RefundID);                    Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.RefundComments           :=             XMLOrder.OrderLines[Ctr3].Refund.RefundComments;               Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.OriginalCarrierMethod    :=             XMLOrder.OrderLines[Ctr3].OriginalCarrierMethod;               Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.ReferenceLineId          :=             XMLOrder.OrderLines[Ctr3].ReferenceLineId;                     Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.IntentToCancel           :=             XMLOrder.OrderLines[Ctr3].IntentToCancel;                      Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.ConfigId                 :=             XMLOrder.OrderLines[Ctr3].ConfigId;                            Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.FulfillmentOption        :=             XMLOrder.OrderLines[Ctr3].Fulfillment.FulfillmentOption;       Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.ShipMethod               :=             XMLOrder.OrderLines[Ctr3].Fulfillment.ShipMethod;              Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.StoreId                  :=             XMLOrder.OrderLines[Ctr3].Fulfillment.StoreId;                 Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.OfferId                  :=             XMLOrder.OrderLines[Ctr3].Fulfillment.OfferId;                 Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.PickUpDateTime           :=   DateValue(XMLOrder.OrderLines[Ctr3].Fulfillment.PickUpDateTime);         Except  on E:Exception do begin  {} end; end;
            Try AWalmartOrder.Lines.PickUpBy                 :=             XMLOrder.OrderLines[Ctr3].Fulfillment.PickUpBy;                Except  on E:Exception do begin  {} end; end;
            AWalmartOrder.Lines.PostDB;


            for ctr5 := 0 to XMLOrder.OrderLines[Ctr3].Charges.count - 1 do begin
              if AWalmartOrder.Lines.LineCharges.count < ctr5+1 then begin
                AWalmartOrder.Lines.LineCharges.New;
                Try AWalmartOrder.Lines.LineCharges.ChargeType     :=              XMLOrder.OrderLines[Ctr3].Charges[ctr5].ChargeType;             Except  on E:Exception do begin  {} end; end;
                Try AWalmartOrder.Lines.LineCharges.ChargeName     :=              XMLOrder.OrderLines[Ctr3].Charges[ctr5].ChargeName;             Except  on E:Exception do begin  {} end; end;
                Try AWalmartOrder.Lines.LineCharges.ChargeAmount   :=  Doublevalue(XMLOrder.OrderLines[Ctr3].Charges[ctr5].ChargeAmount.Amount);   Except  on E:Exception do begin  {} end; end;
                Try AWalmartOrder.Lines.LineCharges.ChargeCurrency :=              XMLOrder.OrderLines[Ctr3].Charges[ctr5].ChargeAmount.Currency;  Except  on E:Exception do begin  {} end; end;
                Try AWalmartOrder.Lines.LineCharges.Taxname        :=              XMLOrder.OrderLines[Ctr3].Charges[ctr5].Tax.Taxname;            Except  on E:Exception do begin  {} end; end;
                Try AWalmartOrder.Lines.LineCharges.Taxamount      :=  Doublevalue(XMLOrder.OrderLines[Ctr3].Charges[ctr5].Tax.TaxAmount.amount);  Except  on E:Exception do begin  {} end; end;
                Try AWalmartOrder.Lines.LineCharges.TaxCurrency    :=              XMLOrder.OrderLines[Ctr3].Charges[ctr5].Tax.TaxAmount.Currency; Except  on E:Exception do begin  {} end; end;
                AWalmartOrder.Lines.LineCharges.PostDB;
              end;
            end;
          end;

          for ctr6 := 0 to XMLOrder.OrderLines[Ctr3].OrderLineStatuses.count - 1 do begin {Order line status changes - At the moment, creating each status as differnet record,
                                                                                           but as per the xml resposne, on walmart , the record gets modified . ie: ordered/acknowledged / cancelled / shipped etc}
            if not AWalmartOrder.Lines.LineStatuses.Locate('orderstatus' , XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].Status , []) then begin
              AWalmartOrder.Lines.LineStatuses.New;
              Try AWalmartOrder.Lines.LineStatuses.orderstatus             :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].Status;                                Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.CancellationReason      :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].CancellationReason;                    Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.UOM                     :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].StatusQuantity.UnitOfMeasurement;      Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.StatusQuantity          := Doublevalue(XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].StatusQuantity.amount);                Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.ShipDateTime            :=   DateValue(XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].TrackingInfo.ShipDateTime);            Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.CarrierNameOtherCarrier :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].TrackingInfo.CarrierName.OtherCarrier; Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.CarrierNameCarrier      :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].TrackingInfo.CarrierName.Carrier;      Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.CarrierMethodCode       :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].TrackingInfo.MethodCode;               Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.CarrierTrackingNumber   :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].TrackingInfo.TrackingNumber;           Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.LineStatuses.CarrierTrackingURL      :=             XMLOrder.OrderLines[Ctr3].OrderLineStatuses[ctr6].TrackingInfo.TrackingURL;              Except  on E:Exception do begin  {} end; end;
              AWalmartOrder.Lines.LineStatuses.PostDB;
            end;
          end;

          for ctr5 := 0 to XMLOrder.OrderLines[Ctr3].Refund.RefundCharges.count - 1 do begin  {refund - check for the count to see if its already created.}
            if AWalmartOrder.Lines.RefundCharges.count < ctr5+1 then begin
              AWalmartOrder.Lines.RefundCharges.New;
              Try AWalmartOrder.Lines.RefundCharges.RefundReason  :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].RefundReason;                     Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeType    :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeType;                Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeName    :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeName ;               Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeAmount  :=  Doublevalue(XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeAmount.Amount) ;     Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeCurrency:=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeAmount.Currency ;    Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.RefundCharges.TaxName       :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.Tax.TaxName ;              Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.RefundCharges.Taxcurrency   :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.Tax.TaxAmount.Currency ;   Except  on E:Exception do begin  {} end; end;
              Try AWalmartOrder.Lines.RefundCharges.TaxAmount     :=  Doublevalue(XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.Tax.TaxAmount.Amount );    Except  on E:Exception do begin  {} end; end;
              AWalmartOrder.Lines.RefundCharges.PostDB;
            end;
          end;
        end;
        onCreateOrder(AWalmartOrder);
    finally
      Freeandnil(AWalmartOrder);
    end;
end;
Procedure SaveWalmartRefund(AOwner:TComponent; aWalmartRefundJson:TWalmartRefundJson);
var
  ctr1, ctr2, ctr3, ctr4:Integer;
  aWalmartOrder :TWalmartOrders;
  awalmartrefund : Twalmartrefunds;
begin
  if aWalmartRefundJson.ReturnOrdersJson = '' then exit;
  if  aWalmartRefundJson.returnOrdersCount =0 then exit;
  awalmartrefund := Twalmartrefunds.CreateWithNewConn(AOwner);
  try
    for ctr1 := 0 to aWalmartRefundJson.returnOrdersCount -1 do begin
      awalmartrefund.loadselect('returnOrderId=' + quotedstr(aWalmartRefundJson.returnOrders[ctr1].returnOrderId));
      if (awalmartrefund.count>0) and (awalmartrefund.locate('returnOrderId;customerOrderId;returnByDate' , varArrayOf([aWalmartRefundJson.returnOrders[ctr1].returnOrderId,
                                                                                          aWalmartRefundJson.returnOrders[ctr1].customerOrderId,
                                                                                          aWalmartRefundJson.returnOrders[ctr1].returnByDate]) , [])) then else begin
        awalmartrefund.new;
        awalmartrefund.returnOrderId := aWalmartRefundJson.returnOrders[ctr1].returnOrderId;
        awalmartrefund.customerEmailId := aWalmartRefundJson.returnOrders[ctr1].customerEmailId;
        awalmartrefund.CustomerFirstName := aWalmartRefundJson.returnOrders[ctr1].Customername.firstname;
        awalmartrefund.CustomerLastName := aWalmartRefundJson.returnOrders[ctr1].Customername.Lastname;
        awalmartrefund.customerOrderId := aWalmartRefundJson.returnOrders[ctr1].customerOrderId;
        awalmartrefund.returnOrderDate := aWalmartRefundJson.returnOrders[ctr1].returnOrderDate;
        awalmartrefund.returnByDate := aWalmartRefundJson.returnOrders[ctr1].returnByDate;
        awalmartrefund.totalRefundAmount := aWalmartRefundJson.returnOrders[ctr1].totalRefundAmount.currencyAmount;
        if isnumeric(aWalmartRefundJson.returnOrders[ctr1].totalRefundAmount.currencyUnit) then
          awalmartrefund.totalRefundAmountCurrecny := StrToFloat(aWalmartRefundJson.returnOrders[ctr1].totalRefundAmount.currencyUnit);
        awalmartrefund.PostDB;
        if aWalmartRefundJson.returnOrders[ctr1].returnLineGroupsCount  >0 then
          for ctr2 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnLineGroupsCount -1 do begin
            awalmartrefund.walmartrefundlinegroups.new;
            awalmartrefund.walmartrefundlinegroups.groupNo := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].groupNo;
            awalmartrefund.walmartrefundlinegroups.returnExpectedFlag := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].returnExpectedFlag;
            awalmartrefund.walmartrefundlinegroups.PostDB;
            if aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].returnLinesCount >0 then
              for ctr3 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].returnLinesCount -1 do begin
                awalmartrefund.walmartrefundlinegroups.walmartrefundgrouplines.New;
                awalmartrefund.walmartrefundlinegroups.walmartrefundgrouplines.returnOrderLineNumber := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].returnLines[ctr3].returnOrderLineNumber;
                awalmartrefund.walmartrefundlinegroups.walmartrefundgrouplines.postdb;
              end;
            if aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labelsCount >0 then
              for ctr3 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labelsCount -1 do begin
                awalmartrefund.walmartrefundlinegroups.walmartrefundgrouplines.New;
                awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.labelImageURL := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labels[ctr3].labelImageURL;
                awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.postdb;
                if aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labels[ctr3].carrierInfoListCount >0 then
                  for ctr4 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labels[ctr3].carrierInfoListCount-1 do begin
                    awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.walmartrefundlinegroupcarrierinfo.New;
                    awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.walmartrefundlinegroupcarrierinfo.carrierId := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labels[ctr3].carrierInfoList[ctr4].carrierId;
                    awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.walmartrefundlinegroupcarrierinfo.carrierName := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labels[ctr3].carrierInfoList[ctr4].carrierName;
                    awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.walmartrefundlinegroupcarrierinfo.serviceType := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labels[ctr3].carrierInfoList[ctr4].serviceType;
                    awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.walmartrefundlinegroupcarrierinfo.trackingNo := aWalmartRefundJson.returnOrders[ctr1].returnLineGroups[ctr2].labels[ctr3].carrierInfoList[ctr4].trackingNo;
                    awalmartrefund.walmartrefundlinegroups.walmartrefundlinegrouplabels.walmartrefundlinegroupcarrierinfo.PostDB;

                  end;
              end;
          end;
        if aWalmartRefundJson.returnOrders[ctr1].returnOrderLinesCount >0 then
          for ctr2 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLinesCount-1 do begin
            awalmartrefund.walmartrefundlines.new;
            awalmartrefund.walmartrefundlines.returnOrderLineNumber := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnOrderLineNumber;
            awalmartrefund.walmartrefundlines.salesOrderLineNumber := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].salesOrderLineNumber;
            awalmartrefund.walmartrefundlines.returnReason := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnReason;
            awalmartrefund.walmartrefundlines.purchaseOrderId := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].purchaseOrderId;
            awalmartrefund.walmartrefundlines.purchaseOrderLineNumber := inttostr(aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].purchaseOrderLineNumber);
            awalmartrefund.walmartrefundlines.sku := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].Item.sku;
            awalmartrefund.walmartrefundlines.productName := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].Item.productName;
            awalmartrefund.walmartrefundlines.itemWeightUOM := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].Item.itemweight.unitOfMeasure;
            awalmartrefund.walmartrefundlines.itemWeightUOMValue := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].Item.itemweight.measurementValue;
            awalmartrefund.walmartrefundlines.Postdb;
            // chages
            if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].chargesCount >0 then
              for ctr3 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].chargesCount-1 do begin
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.new;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.chargeCategory            := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].chargeCategory;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.chargeName                := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].chargeName;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.chargePerUnitAmt          := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].chargePerUnit.currencyAmount;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.chargePerUnitCurrency     := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].chargePerUnit.currencyUnit;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.isDiscount                := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].isDiscount;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.isBillable                := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].isBillable;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.postdb;
                if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].taxCount >0 then
                  for ctr4 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].taxCount-1 do begin
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargetax.taxName                   := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].tax[ctr4].taxName;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargetax.excessTax                 := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].tax[ctr4].excessTax.currencyAmount;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargetax.excessTaxCurrency         := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].tax[ctr4].excessTax.currencyUnit;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargetax.taxPerUnit                := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].tax[ctr4].taxPerUnit.currencyAmount;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargetax.taxPerUnitCurrency        := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].tax[ctr4].taxPerUnit.currencyUnit;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargetax.PostDB;
                  end;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.excessCharge          := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].excessCharge.currencyAmount;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.excessChargecurrency     := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].excessCharge.currencyUnit;
                awalmartrefund.walmartrefundlines.walmartrefundlinecharges.PostDB;
                if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].referencesCount >0 then
                  for ctr4 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].referencesCount-1 do begin
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargereferences.New;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargereferences.referencename             := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].references[ctr4].refname;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargereferences.referenceValue            := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].charges[ctr3].references[ctr4].refValue;
                    awalmartrefund.walmartrefundlines.walmartrefundlinecharges.walmartrefundlinechargereferences.PostDB;
                  end;
              end;
            awalmartrefund.walmartrefundlines.unitPrice := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].unitPrice.currencyAmount;
            awalmartrefund.walmartrefundlines.unitPriceCurrency := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].unitPrice.currencyUnit;
            awalmartrefund.walmartrefundlines.Postdb;
            if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].chargeTotalsCount > 0 then
              for ctr3 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].chargeTotalsCount-1 do begin
                awalmartrefund.walmartrefundlines.walmartrefundlinechargestotals.New;
                awalmartrefund.walmartrefundlines.walmartrefundlinechargestotals.chargeTotalsname          := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].chargeTotals[ctr3].ChargeTotalName;
                awalmartrefund.walmartrefundlines.walmartrefundlinechargestotals.chargeTotalsValue         := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].chargeTotals[ctr3].ChargetotalValue.currencyAmount;
                awalmartrefund.walmartrefundlines.walmartrefundlinechargestotals.chargeTotalsCurrency      := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].chargeTotals[ctr3].ChargetotalValue.currencyUnit;
                awalmartrefund.walmartrefundlines.walmartrefundlinechargestotals.PostDB;
              end;
            awalmartrefund.walmartrefundlines.cancellableQty := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].cancellableQty;
            awalmartrefund.walmartrefundlines.quantityuom := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].quantity.unitOfMeasure;
            awalmartrefund.walmartrefundlines.quantity := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].quantity.measurementValue;
            awalmartrefund.walmartrefundlines.returnExpectedFlag := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnExpectedFlag;
            awalmartrefund.walmartrefundlines.isFastReplacement := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].isFastReplacement;
            awalmartrefund.walmartrefundlines.isKeepIt := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].isKeepIt;
            awalmartrefund.walmartrefundlines.lastItem := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].lastItem;
            awalmartrefund.walmartrefundlines.refundedQty := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].refundedQty;
            awalmartrefund.walmartrefundlines.rechargeableQty := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].rechargeableQty;
            awalmartrefund.walmartrefundlines.Postdb;
            if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetailCount > 0 then
              for ctr3:= 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetailCount-1 do begin
                awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.sequenceNo                  := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].sequenceNo;
                awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.eventTag                    := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].eventTag  ;
                awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.eventDescription            := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].eventDescription;
                awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.eventTime                   := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].eventTime;
                if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].referencesCount >0 then
                  for ctr4 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].referencesCount -1 do begin
                    awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.walmartrefundlinetrackingdetailref.New;
                    awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.walmartrefundlinetrackingdetailref.refname :=aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].references[ctr4].refname;
                    awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.walmartrefundlinetrackingdetailref.refValue :=aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnTrackingDetail[ctr3].references[ctr4].refValue;
                    awalmartrefund.walmartrefundlines.walmartrefundlinetrackingdetail.walmartrefundlinetrackingdetailref.PostDB;
                  end;
              end;
            awalmartrefund.walmartrefundlines.status := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].status;
            awalmartrefund.walmartrefundlines.statusTime := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].statusTime;
            awalmartrefund.walmartrefundlines.refundChannel := aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].refundChannel;
            awalmartrefund.walmartrefundlines.Postdb;
            //returnChannel
          end;
          awalmartrefund.returnChannelName :=  aWalmartRefundJson.returnOrders[ctr1].returnChannel.channelName;
          awalmartrefund.PostDB;
      end;
    end;
  finally
    freeandnil(awalmartrefund);
  end;

 (*Twalmartrefunds                                   = Class;
  |---Twalmartrefundlinegroups                    = Class;
    |---Twalmartrefundgrouplines                  = Class;
    |---Twalmartrefundlinegrouplabels             = Class;
      |-------Twalmartrefundlinegroupcarrierinfo  = Class;
  |---Twalmartrefundlines                         = Class;
    |-----Twalmartrefundlinecharges               = Class;
      |-------Twalmartrefundlinechargetax         = Class;
      |-------Twalmartrefundlinechargereferences  = Class;
    |-----Twalmartrefundlinechargestotals         = Class;
    |-----Twalmartrefundlinetrackingdetail        = Class;
      |-------Twalmartrefundlinetrackingdetailref = Class;*)

{  for ctr1 := 0 to aWalmartRefundJson.returnOrdersCount -1 do begin
    if aWalmartRefundJson.returnOrders[ctr1].customerOrderId = '' then continue;
    aWalmartOrder := TWalmartOrders.CreateWithNewConn(AOwner);
    try
      aWalmartOrder.loadSelect('customerOrderId = ' + quotedstr(aWalmartRefundJson.returnOrders[ctr1].customerOrderId));
      if aWalmartOrder.count =0 then continue;
      if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines.count =0 then continue;
      for ctr2 := 0 to aWalmartRefundJson.returnOrders[ctr1].returnOrderLines.count-1 do begin

        if aWalmartOrder.Lines.Locate('Linenumber' ,aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].purchaseOrderLineNumber , []) then begin
          if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].Status ='COMPLETED' then begin
            if aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].quantity.measurementValue <> 0 then begin

(*              AWalmartOrder.Lines.RefundCharges.New;
              Try AWalmartOrder.Lines.RefundCharges.RefundReason  :=              aWalmartRefundJson.returnOrders[ctr1].returnOrderLines[ctr2].returnReason;                     Except  on E:Exception do begin   end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeType    :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeType;                Except  on E:Exception do begin   end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeName    :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeName ;               Except  on E:Exception do begin   end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeAmount  :=  Doublevalue(XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeAmount.Amount) ;     Except  on E:Exception do begin   end; end;
              Try AWalmartOrder.Lines.RefundCharges.ChargeCurrency:=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.ChargeAmount.Currency ;    Except  on E:Exception do begin   end; end;
              Try AWalmartOrder.Lines.RefundCharges.TaxName       :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.Tax.TaxName ;              Except  on E:Exception do begin   end; end;
              Try AWalmartOrder.Lines.RefundCharges.Taxcurrency   :=              XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.Tax.TaxAmount.Currency ;   Except  on E:Exception do begin   end; end;
              Try AWalmartOrder.Lines.RefundCharges.TaxAmount     :=  Doublevalue(XMLOrder.OrderLines[Ctr3].Refund.RefundCharges[ctr5].Charge.Tax.TaxAmount.Amount );    Except  on E:Exception do begin   end; end;
              AWalmartOrder.Lines.RefundCharges.PostDB;*)


            end;
          end;
        end;
      end;

    finally
      Freeandnil(aWalmartOrder);
    end;
  end;   }
end;
procedure SetWalmartReturns(AOwner:Tcomponent; const Value: String; onUpdateOrder:TNotifyEvent; var nextcursor:String);
var
  WalmartRefundJson :TWalmartRefundJson;
begin
  WalmartRefundJson := TWalmartRefundJson(Jo);
  try
    WalmartRefundJson.ReturnOrdersJson := Value;
    SaveWalmartRefund(AOwner, WalmartRefundJson);
  finally
    WalmartRefundJson.Free;
  end;
(*var
  XMLReturnOrder      : IXMLReturnOrder;
  XMLReturnOrders      : IXMLReturnOrders;
  ctr1          : Integer;
begin

  XMLReturnOrders := LoadXMLData(Value).GetDocBinding('', TXMLReturnOrders, WALMART_Order_TargetNameSpace) as IXMLReturnOrders;
  try  nextcursor:= XMLReturnOrders.meta.nextcursor; except on E:EXception do begin {} end; end;
  try
    if  XMLReturnOrders.count >0 then begin
      for Ctr1  := 0 to XMLReturnOrders.count - 1 do begin
        XMLReturnOrder :=XMLReturnOrders.ReturnOrder[ctr1];
        if XMLReturnOrder.returnOrderId = '' then begin
          MessageDlgXP_vista('Invalid Order', mtWarning, [mbOK], 0);
          //Exit;
          continue;
        end;
        XMLtoWalmartRefundOrder(XMLReturnOrder , nil);
      end;
    end;
  finally
    XMLReturnOrders := nil;
  end;*)

end;
procedure SetWalmartOrder(const Value: String; onCreateOrder:TNotifyEvent; var nextcursor:String);
var
  XMLOrdersList : IXMLOrdersListType;
  XMLElements   : IXMLElementsType ;
  XMLOrder      : IXMLOrder;
  ctr1          : Integer;
begin

  XMLOrdersList := LoadXMLData(Value).GetDocBinding('list', TXMLOrdersListType, WALMART_Order_TargetNameSpace) as IXMLOrdersListType;
  try  nextcursor:= XMLOrdersList.meta.nextcursor; except on E:EXception do begin {} end; end;
  //XMLOrder := LoadXMLData(Value).GetDocBinding('order', TXMLORDER, WALMART_Order_TargetNameSpace) as IXMLOrder;
  try
    if  XMLOrdersList.Elements.count >0 then begin
      XMLElements :=XMLOrdersList.Elements;
      for Ctr1  := 0 to XMLElements.count - 1 do begin
        XMLOrder :=XMLElements.Order[ctr1];
        if XMLOrder.purchaseOrderId = '' then begin
          MessageDlgXP_vista('Invalid Order', mtWarning, [mbOK], 0);
          //Exit;
          continue;
        end;
        XMLtoWalmartOrder(XMLOrder , OnCreateOrder);
      end;
    end;
  finally
    XMLElements := nil;
  end;
end;

end.
