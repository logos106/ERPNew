unit Walmart_Item_Lib;

interface

uses BusobjWalmartItems, ItemResponse , classes;

procedure SetWalmartItems(const Value: String; onCreateProduct:TNotifyEvent);
Procedure XMLtoWalmartItem(aItem:IXMLItemResponse; onCreateProduct:TNotifyEvent);
Procedure ChecknMakeERPProduct(walmartitem:Twalmartitems; onCreateProduct:TNotifyEvent= nil);
Function WalmartProductUnits:String;


implementation

uses  CK_DLL_Const, XMLDoc, sysutils, BusobjProduct,
      CommonLib, Dialogs;

Function WalmartProductUnits:String;
begin
   result :=  Quotedstr('Ounce')+',' +
              Quotedstr('Fluid Ounce')+',' +
              Quotedstr('Yard')+',' +
              Quotedstr('Square Foot')+',' +
              Quotedstr('Cubit Foot')+',' +
              Quotedstr('Foot')+',' +
              Quotedstr('Inch')+',' +
              Quotedstr('Pound')+',' +
              Quotedstr('Each');

end;
Procedure XMLtoWalmartItem(aItem:IXMLItemResponse; onCreateProduct:TNotifyEvent);
var
  walmartitem : Twalmartitems;
begin
    walmartitem := Twalmartitems.CreateWithNewConn(nil);
    try
      walmartitem.connection.begintransaction;
      try
        walmartitem.loadselect('SKU = ' + quotedstr(aItem.SKU));
        if walmartitem.count = 0 then begin
            walmartitem.New;
            walmartitem.Mart                         := aItem.Mart                       ;
            walmartitem.Sku                          := aItem.Sku                        ;
            walmartitem.WpID                         := aItem.WpID                       ;
            walmartitem.Upc                          := aItem.Upc                        ;
            walmartitem.Gtin                         := aItem.Gtin                       ;
            walmartitem.ProductName                  := aItem.ProductName                ;
            walmartitem.Shelf                        := aItem.Shelf                      ;
            walmartitem.ProductType                  := aItem.ProductType                ;
            walmartitem.Price_Currency               := aItem.Price.Currency             ;
            walmartitem.Price_Amount                 := aItem.Price.Amount               ;
            walmartitem.PublishedStatus              := aItem.PublishedStatus            ;
            walmartitem.NameValueAttributes_Name     := aItem.AdditionalAttributes.Name   ;
            walmartitem.NameValueAttributes_Type     := aItem.AdditionalAttributes.Type_  ;
            if Assigned(onCreateProduct) then onCreateProduct(walmartitem);
            if not walmartitem.Save then begin
              walmartitem.connection.RollbackTransaction;
              Exit;
            end;
        end;
        (*ProductSimple := TProductSimple.create(nil);
        try
          with ProductSimple do begin
            connection :=walmartitem.connection;
            LoadSelect(walmartitem.ProductSearchSQL);
            if count =0 then begin
              new;
              Productname := walmartitem.ProductnameforERP;
              ProductPrintName := Productname;
              try SellQty1Price :=  strTofloat(walmartitem.Price_Amount); Except on E:Exception do begin SellQty1Price :=  0; end; end;
              PostDB;
              if Assigned(onCreateProduct) then onCreateProduct(ProductSimple);
            end;
            walmartitem.ERPProductId := ID;
            walmartitem.PostDB;
          end;
        finally
          Freeandnil(ProductSimple);
        end;
        walmartitem.connection.CommitTransaction;*)
        ChecknMakeERPProduct(walmartitem, onCreateProduct);
      Except
        on E:EXception do begin
          walmartitem.connection.RollbackTransaction;
          Exit;
        end;
      end;
    finally
      Freeandnil(walmartitem);
    end;
end;
Procedure ChecknMakeERPProduct(walmartitem:Twalmartitems; onCreateProduct:TNotifyEvent = nil);
begin
 walmartitem.ChecknMakeERPProduct(onCreateProduct);
 walmartitem.connection.CommitTransaction;
(*var
  ProductSimple : TProductSimple;
begin
ProductSimple := TProductSimple.create(nil);
        try
          with ProductSimple do begin
            connection :=walmartitem.connection;
            LoadSelect(walmartitem.ProductSearchSQL);
            if count =0 then begin
              new;
              try Productname         := walmartitem.ProductnameforERP;         Except end;
              try ProductPrintName    := Productname;                           Except end;
              try SalesDescription    :=  walmartitem.ProductDescriptionforERP; Except end;
              try PurchaseDescription :=  walmartitem.ProductDescriptionforERP; Except end;
              try SellQty1Price :=  strTofloat(walmartitem.Price_Amount);       Except on E:Exception do begin SellQty1Price :=  0; end; end;
              try PostDB; Except end;
              if Assigned(onCreateProduct) then onCreateProduct(ProductSimple);
            end;
            walmartitem.ERPProductId := ID;
            walmartitem.PostDB;
          end;
        finally
          Freeandnil(ProductSimple);
        end;
        walmartitem.connection.CommitTransaction;*)
end;

procedure SetWalmartItems(const Value: String; onCreateProduct:TNotifyEvent);
var
  XMLItemsList : IXMLItemResponses;
  XMLItemResponseList : IXMLItemResponseList;
  ctr:Integer;
  aItem:IXMLItemResponse;
begin
    XMLItemsList := LoadXMLData(Value).GetDocBinding('ItemResponses', TXMLItemResponses, WALMART_TargetNameSpace) as IXMLItemResponses;
  XMLItemResponseList := XMLItemsList.ItemResponse;
  for ctr:= 0 to XMLItemResponseList.Count -1 do begin
    aItem :=XMLItemResponseList.items[ctr];
(*    if aItem.Productname = '' then begin
      MessageDlgXP_vista('Invalid Product - Productname is blank', mtWarning, [mbOK], 0);
      Continue;
    end;*)
    XMLtoWalmartItem(aitem, onCreateProduct);
  end;

end;


end.
