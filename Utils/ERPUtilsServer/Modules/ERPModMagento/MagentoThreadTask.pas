// set this define is you are using Indy 10
{$define INDY100}
// set this define is you are using Indy 9
{.$define INDY90}

unit MagentoThreadTask;

interface

uses
  ServerModuleThreadTask, Classes, LogThreadBase, LogMessageTypes,
  StdCtrls, MagentoObj, JsonObject, BusObjSaleBase,
  MageDataFilter, BusObjCash, mage_v2_soap;

type

  TMagentoThreadTask = class(TServerModuleThreadTask)
  private
    fPercentDone: integer;
    fSupplierName: string;
    fProcessedStatus: string;
    fStatusToProcess: string;
    FERPDatabase: string;
    FERPPassword: string;
    FERPUser: string;
    fStoreId: string;
    fStoreURL: string;
    Mage: TMagento;
    country_id: string;
    MageSale,
    MageSaleLines: TJsonObject;
    MageBillAddress,
    MageShipAddress: TJsonObject;
    MagePayment: TJsonObject;
    MageSaleTax,
    MageSaleTaxItem: TJsonObject;
    Lines: TJsonObject;
    filter: TMageDataFilter;
    fAdminEmail: string;
    MageProduct: TJsonObject;
    MageStock: TJsonObject;
    PostResult: TJsonObject;
    fUpdateQuantities: boolean;
    fApiUser: string;
    fApiKey: string;
    fUpdateERPFromStore: boolean;
    function RequirementsOk: boolean;
    procedure SynchStore;
    function InitCountryID: boolean;
    function GetNewSalesOrders: boolean;
    function ProcessNewSalesOrder(OrderId: Integer): boolean;
    procedure CheckShippingProduct;
    procedure SendErrorEmail(Sale: TSalesBase;
      Subject, ErrorMessage: string);
    procedure UpCheckProducts;
    function DownCheckProducts: boolean;
    function DownSyncProduct(aEntityId: string): boolean;
    procedure UpSyncProduct(xrefId: integer);
    procedure UpSyncProductQty(xrefId: integer);
    procedure CheckQuantities;
    procedure CheckProductPictures;
    procedure UpSyncProductPicture(xrefId: integer);
  protected
    procedure DoWork; override;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltNone); override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property ERPDatabase: string read FERPDatabase write FERPDatabase;
    property ERPUser: string read FERPUser write FERPUser;
    property ERPPassword: string read FERPPassword write FERPPassword;
    property StoreURL: string read fStoreURL write fStoreURL;
    property StoreId: string read fStoreId write fStoreId;
    property AdminEmail: string read fAdminEmail write fAdminEmail;
    property UpdateQuantities: boolean read fUpdateQuantities write fUpdateQuantities;
    property UpdateERPFromStore: boolean read fUpdateERPFromStore write fUpdateERPFromStore;
    property ApiUser: string read fApiUser write fApiUser;
    property ApiKey: string read fApiKey write fApiKey;
  end;

(*
  Test Credit Card Numbers
  https://www.paypalobjects.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm
*)

implementation

uses
  SysUtils, LogThreadDbLib, JsonToObject, JsonRPCUtils, types, StrUtils,
  JsonRPCConst, ModuleFileNameUtils, MySQLUtils, DbSharedObjectsObj,
  XMLDoc, XMLHelperUtils, Math,
  BusObjStock, AppEnvironment, ActiveX, BusObjClient, BusObjUOM,
  EmailUtilsSimple, ERPDbComponents, CommonLib, BusObjCommon, DB, BusObjConst,
  BusObjBase, tcConst, MageUtils, MySQLConst,
  ProductQtyLib, PQALib, BusObjProductPicture, SystemLib, IdHttp, HTTPConst;

const
  Obj_SalesOrder = 'SalesOrder';
  Obj_Product = 'Product';
  Obj_ProductPicture = 'ProductPicture';
  Obj_Stock = 'Stock';
  Shipping_Product = 'Shipping';

function JsonValAsString(J: TJsonObject; Name: string): string;
var
  pair: TJSONValuePair;
begin
  result := '';
  pair := J.ItemByName[Name];
  if Assigned(pair) and (pair.ValueType <> valNull) then
    result := pair.Value.AsString;
end;

{ this mainly caters for assigning vals to null json records }
procedure SetJsonVal(J: TJsonObject; Name: string; Val: string);
var
  pair: TJSONValuePair;
begin
  pair := J.ItemByName[Name];
  if Assigned(pair) then begin
    if pair.ValueType = valString then
      pair.Value.AsString := Val
    else begin
      J.Delete(Name);
      J.S[Name] := Val;
    end;
  end
  else begin
    { not assigned }
    J.S[Name] := Val;
  end;
end;


{ TPerecorpThreadTask }


procedure TMagentoThreadTask.CheckProductPictures;
var
  qry: TERPQuery;
  qryUpdate: TERPQuery;
  MaxTime: TDateTime;
begin
  qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  qryUpdate := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  try
    AppEnv.AppDb.TransConnection.StartTransaction;
    try
      { product pictures that have been updated/ changed in erp .. }
      qry.SQL.Add('select max(ProcessTime) as MaxTime from tblshopxref');
      qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
      qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_ProductPicture));
      qry.SQL.Add('and Processed = "T"');
      qry.Open;
      MaxTime := qry.FieldByName('MaxTime').AsDateTime;
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select pp.PartPicId, pp.PartId, pp.PicType, pp.isDefault, pp.msTimeStamp, pp.ImageTypes  from tblpartspics pp');
      qry.SQL.Add('inner join tblparts p on p.PartsId = pp.PartId');
      qry.SQL.Add('inner join tblShopXRef x on x.ObjectName = ' + QuotedStr(Obj_Product) + ' and x.ERPInstId = pp.PartId');
      qry.SQL.Add('where pp.msTimeStamp > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,MaxTime)));
      qry.SQL.Add('and p.PublishOnWeb = "T"');
      qry.SQL.Add('and pp.PicType in ("GIF","JPG","JPEG","PNG")'); { types supported by Magento }
      qry.SQL.Add('order by partID');
      qry.Open;

      qryUpdate.SQL.Add('select * from tblShopXRef');
      qryUpdate.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
      qryUpdate.SQL.Add('and ObjectName = ' + QuotedStr(Obj_ProductPicture));
      qryUpdate.SQL.Add('and ERPInstId = :ERPInstId');

      while not qry.Eof do begin
//        if qry.FieldByName('isDefault').AsBoolean then begin
        if qry.FieldByName('ImageTypes').AsString <> '' then begin
          qryUpdate.ParamByName('ERPInstId').AsInteger := qry.FieldByName('PartPicId').AsInteger;
          qryUpdate.Open;
          try
            if qryUpdate.IsEmpty then begin
              qryUpdate.Insert;
              qryUpdate.FieldByName('ShopId').AsString := self.StoreId;
              qryUpdate.FieldByName('ObjectName').AsString := Obj_ProductPicture;
              qryUpdate.FieldByName('ERPInstId').AsInteger := qry.FieldByName('PartPicId').AsInteger;
            end
            else begin
              qryUpdate.Edit;
            end;
            qryUpdate.FieldByName('Processed').AsBoolean := false;
            qryUpdate.FieldByName('ProcessTime').AsDateTime := qry.FieldByName('msTimeStamp').AsDateTime;
            qryUpdate.Post;
          finally
            qryUpdate.Close;
          end;
        end;
        qry.Next;
      end;

      AppEnv.AppDb.TransConnection.Commit;


      { now process them .. }
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select * from tblshopxref');
      qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
      qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_ProductPicture));
      qry.SQL.Add('and Processed = "F"');
      qry.SQL.Add('order by ProcessTime ASC');
      qry.Open;
      while not qry.Eof do begin
        UpSyncProductPicture(qry.FieldByName('Id').AsInteger);
        qry.Next;
      end;

    except
      on e: exception do begin
        Log('Error checking ERP product pictures: ' + e.Message, ltError);
        if AppEnv.AppDb.TransConnection.InTransaction then
          AppEnv.AppDb.TransConnection.Rollback;
      end;

    end;

  finally
    DbSharedObj.ReleaseObj(qry);
    DbSharedObj.ReleaseObj(qryUpdate);
  end;
end;

procedure TMagentoThreadTask.UpCheckProducts;
var
  qry: TERPQuery;
  cmd: TERPCommand;
  MaxTime: TDateTime;
begin
  qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  cmd := DbSharedObj.GetCommand(AppEnv.AppDb.TransConnection);
  try
    AppEnv.AppDb.TransConnection.StartTransaction;
    try
      { products that have been updated/ changed in erp .. }
      qry.SQL.Add('select max(ProcessTime) as MaxTime from tblshopxref');
      qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
      qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_Product));
      qry.Open;
      MaxTime := qry.FieldByName('MaxTime').AsDateTime;
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select * from tblparts p');
      qry.SQL.Add('inner join tblshopxref x on x.ShopId = ' + QuotedStr(self.StoreId) +
        ' and x.ObjectName = ' + QuotedStr(Obj_Product) + ' and x.ERPInstId = p.PartsId');
      qry.SQL.Add('where p.msTimeStamp > ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,MaxTime)));
      qry.Open;
      while not qry.Eof do begin
        cmd.SQL.Clear;
        cmd.SQL.Add('update tblshopxref set Processed = "F",');
        cmd.SQL.Add('ProcessTime = ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,qry.FieldByName('msTimeStamp').AsDateTime)));
        cmd.SQL.Add('where Id = ' + IntToStr(qry.FieldByName('Id').AsInteger));
        cmd.Execute;
        qry.Next;
      end;

      { products that are new in erp .. }
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select p.* from tblparts p');
      qry.SQL.Add('left join tblshopxref x on x.ShopId = ' + QuotedStr(self.StoreId) +
        ' and x.ObjectName = ' + QuotedStr(Obj_Product) + ' and x.ERPInstId = p.PartsId');
      qry.SQL.Add('where p.PublishOnWeb = "T" and IsNull(x.Id)');
      qry.Open;
      while not qry.Eof do begin
        cmd.SQL.Clear;
        cmd.SQL.Add('insert into tblshopxref (ShopId,ObjectName,ERPInstID,ProcessTime)');
        cmd.SQL.Add('values (' + QuotedStr(self.StoreId) +',' +
                                 QuotedStr(Obj_Product) + ',' +
                                 IntToStr(qry.FieldByName('PartsId').AsInteger) + ','+
                                 QuotedStr(FormatDateTime(MysqlDateTimeFormat,qry.FieldByName('msTimeStamp').AsDateTime)) +')');
        cmd.Execute;
        qry.Next;
      end;

      AppEnv.AppDb.TransConnection.Commit;

      { now process them .. }
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select * from tblshopxref');
      qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
      qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_Product));
      qry.SQL.Add('and Processed = "F"');
      qry.SQL.Add('order by ProcessTime');
      qry.Open;
      while not qry.Eof do begin
        UpSyncProduct(qry.FieldByName('Id').AsInteger);
        qry.Next;
      end;

    except
      on e: exception do begin
        Log('Error checking ERP products: ' + e.Message, ltError);
        if AppEnv.AppDb.TransConnection.InTransaction then
          AppEnv.AppDb.TransConnection.Rollback;
      end;

    end;

  finally
    DbSharedObj.ReleaseObj(qry);
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TMagentoThreadTask.CheckQuantities;
var
  qry: TERPQuery;
  cmd: TERPCommand;
  msg: string;
begin
  qry := DbSharedObj.GetQuery(AppEnv.AppDb.Connection);
  cmd := DbSharedObj.GetCommand(AppEnv.AppDb.TransConnection);
  try
   AppEnv.AppDb.TransConnection.StartTransaction;
   try
     try
       qry.SQL.Text :=
         ' Select ' + SQL4Qty(tAvailable) + ' as Qty,' +
         ' P.PartsId as ProductId,' +
         ' ss.Id as ShopStockId,' +
         ' ss.QuantityAvailable as ShopStockQty,' +
         ' sxp.ShopInstId as ShopInstId, ' +
         ' sx.Id as ShopXRefId ' +
         ' FROM ' + ProductTables(tSummary) +
         ' left join tblshopstock ss on ss.ShopId = ' + QuotedStr(self.StoreId) + ' and ss.ProductId = P.PartsId' +
         ' left join tblshopxref sx on sx.ShopId = ' + QuotedStr(self.StoreId) + ' and sx.ObjectName = ' + QuotedStr(Obj_Stock) + ' and sx.ERPInstId = P.PartsId' +
         ' left join tblshopxref sxp on sxp.ShopId = ' + QuotedStr(self.StoreId) + ' and sxp.ObjectName = ' + QuotedStr(Obj_Product) + ' and sxp.ERPInstId = P.PartsId' +
         ' Where P.PublishOnWeb = "T"' +
         ' group by P.PartsId';
       qry.Open;
       while not qry.Eof do begin
          if qry.FieldByName('ShopStockQty').AsFloat <> qry.FieldByName('Qty').AsFloat then begin
            if qry.FieldByName('ShopStockId').AsInteger  < 1 then begin
              { we don't have a tblshopstock record so create it }
              cmd.SQL.Clear;
              cmd.SQL.Add('insert into tblshopstock (ShopId, ProductId, QuantityAvailable)');
              cmd.SQL.Add('values (' + QuotedStr(self.StoreId) + ',');
              cmd.SQL.Add(IntToStr(qry.FieldByName('ProductId').AsInteger)+ ',');
              cmd.SQL.Add(FormatFloat('#0.00000', qry.FieldByName('Qty').AsFloat) + ')');
              cmd.Execute;
            end
            else begin
              { update existing record }
              cmd.SQL.Clear;
              cmd.SQL.Add('update tblshopstock set QuantityAvailable = ' + FormatFloat('#0.00000', qry.FieldByName('Qty').AsFloat));
              cmd.SQL.Add('where Id = ' + IntToStr(qry.FieldByName('ShopStockId').AsInteger));
              cmd.Execute;
            end;

            if qry.FieldByName('ShopXRefId').AsInteger  < 1 then begin
              { we don't have a tblshopxref record so add one }
              if qry.FieldByName('ShopInstId').AsInteger > 0 then begin

                cmd.SQL.Clear;
                cmd.SQL.Add('insert into tblshopxref (ShopId, ObjectName, ShopInstId, ERPInstId)');
                cmd.SQL.Add('values (' + QuotedStr(self.StoreId) + ',');
                cmd.SQL.Add(QuotedStr(Obj_Stock) + ',');
                cmd.SQL.Add(IntToStr(qry.FieldByName('ShopInstId').AsInteger)+ ',');
                cmd.SQL.Add(IntToStr(qry.FieldByName('ProductId').AsInteger)+ ')');
                cmd.Execute;
              end;
            end
            else begin
              { update existing record }
              cmd.SQL.Clear;
              cmd.SQL.Add('update tblshopxref set Processed = "F"');
              cmd.SQL.Add('where Id = ' + IntToStr(qry.FieldByName('ShopXRefId').AsInteger));
              cmd.Execute;
            end;
          end;
         qry.Next;
       end;

       AppEnv.AppDb.TransConnection.Commit;

       qry.Close;
       qry.SQL.Clear;
       qry.SQL.Add('select * from tblshopxref');
       qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
       qry.SQL.Add('and ObjectName = '  + QuotedStr(Obj_Stock));
       qry.SQL.Add('and Processed = "F"');
       qry.Open;
       while not qry.Eof do begin
         self.UpSyncProductQty(qry.FieldByName('Id').AsInteger);
         qry.Next;
       end;
     except
       on e: exception do begin
         if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
         msg := 'CheckQuantities error: ' + e.Message;
         Log(msg, ltError);
         exit;
       end;
     end;
   finally
     if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Commit;
   end;
  finally
    DbSharedObj.ReleaseObj(qry);
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TMagentoThreadTask.CheckShippingProduct;
var
  Prod: TProduct;
begin
  Prod := TProduct.CreateWithNewConn(nil);
  try
    Prod.SilentMode := true;
    Prod.LoadSelect('PartName = ' + QuotedStr(Shipping_Product));
    if Prod.Count < 1 then begin
      Prod.Connection.BeginTransaction;
      try
        Prod.New;
        Prod.ProductName := Shipping_Product;
        Prod.ProductType := 'NONINV';
        Prod.SalesDescription := Shipping_Product;
        Prod.PurchaseDescription := Shipping_Product;
        Prod.TaxCodeSales := AppEnv.RegionalOptions.TaxCodeSalesInc;
        Prod.TaxCodePurchase := AppEnv.RegionalOptions.TaxCodePurchaseInc;
        if not Prod.Save then
          raise Exception.Create('Error creating ' + Shipping_Product + ': ' + Prod.ResultStatus.Messages);
        Prod.Connection.CommitTransaction;
      except
        on e: exception do begin
          Prod.Connection.RollbackTransaction;
          raise;
        end;
      end;

    end;
  finally
    Prod.Free;
  end;
end;

constructor TMagentoThreadTask.Create;
begin
  inherited;

end;

destructor TMagentoThreadTask.Destroy;
begin
  Mage.Free;
  MageSale.Free;
  MageSaleLines.Free;
  filter.Free;
  MageBillAddress.Free;
  MageShipAddress.Free;
  MagePayment.Free;
  MageSaleTax.Free;
  MageSaleTaxItem.Free;
  Lines.Free;
  MageProduct.Free;
  PostResult.Free;
  MageStock.Free;
  inherited;
end;

function TMagentoThreadTask.DownCheckProducts: boolean;
var
  prodList: TJsonObject;
  msg: string;
  x: integer;
begin
  result := true;
  prodList := TJsonObject.Create;
  try
    if not Mage.GetData(prodList,msg,'catalog_product',0) then begin
      Log('Error getting Product List from Magento: ' + msg, ltError);
      exit;
    end;

    for x := 0 to prodList.A['items'].Count -1 do begin
      if not DownSyncProduct(prodList.A['items'].Items[x].AsObject.S['entity_id']) then
        result := false;
    end;

  finally
    prodList.Free;
  end;
end;

function TMagentoThreadTask.DownSyncProduct(aEntityId: string): boolean;
var
  msg: string;
  product: TProduct;
  price: double;
  qry: TERPQuery;
  x: integer;
  mediaArray: catalogProductImageEntityArray;
  ImageEntity: catalogProductImageEntity;
  picType: string;
  s: string;
  y: integer;
  HTTP: TIdHttp;
  stream: TMemoryStream;
  BlobStream: TStream;
  picName: string;
begin
  result := false;
  try
    try
      if not Assigned(MageProduct) then MageProduct := TJsonObject.Create;
      if not Mage.GetData(MageProduct,msg,'catalog_product',StrToInt(aEntityId)) then begin
        Log('Error getting Product from Magento: ' + msg, ltError);
        exit;
      end;

      if not SameText(MageProduct.S['entity_id'], aEntityId) then begin
        Log('Error getting Product from Magento: Cant find product for entity_id ' + aEntityId, ltError);
        exit;
      end;

      AppEnv.AppDb.TransConnection.StartTransaction;
      product := TProduct.Create(nil);
      try
        product.Connection := TMyDacDataConnection.Create(product);
        product.Connection.Connection := AppEnv.AppDb.TransConnection;
        product.SilentMode := true;
        product.LoadSelect('ProductCode = ' + QuotedStr(MageProduct.S['sku']));
        if Product.Count = 0 then begin
          Log('Product not found in ERP, adding: ' + MageProduct.S['name'], ltDetail);
          Product.New;
          Product.ProductName := MageProduct.S['name'];
          Product.PRODUCTCODE := MageProduct.S['sku'];
          Product.ProductType := 'INV';
          Product.PublishOnWeb := true;
          if JsonValAsString(MageProduct, 'description') <> '' then
            Product.SalesDescription := JsonValAsString(MageProduct, 'description')
          else
            Product.SalesDescription := JsonValAsString(MageProduct, 'short_description');
          Product.PurchaseDescription := Product.SalesDescription;

          price := StrToFloatDef(JsonValAsString(MageProduct, 'price'),0);
          Product.BuyQty1CostInc := price;
          Product.BuyQty2CostInc := price;
          Product.BuyQty3CostInc := price;

          Product.SellQty1PriceInc := price;
          Product.SellQty2PriceInc := price;
          Product.SellQty3PriceInc := price;
          if not product.Save then begin
            Log('Error creating ERP Product: ' + product.ResultStatus.Messages, ltError);
            exit;
          end;

          qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
          try
            qry.SQL.Add('select * from tblshopxref where ShopInstId = ' + QuotedStr(aEntityId));
            qry.SQL.Add('and ShopId = ' + QuotedStr(self.StoreId));
            qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_Product));
            qry.Open;
            if qry.IsEmpty then begin
              qry.Insert;
              qry.FieldByName('ShopInstId').AsString := StoreID;
              qry.FieldByName('ObjectName').AsString := Obj_Product;
              qry.FieldByName('ShopInstId').AsInteger := StrToInt(aEntityId);
              qry.FieldByName('ERPInstId').AsInteger := product.ID;
              qry.FieldByName('ProcessTime').AsDateTime := product.MsTimeStamp;
              qry.FieldByName('Processed').AsBoolean  := true;
              qry.Post;
            end;
          finally
            DbSharedObj.ReleaseObj(qry);
          end;
        end;

        { now the images }

        mediaArray := Mage.API.catalogProductAttributeMediaList(Mage.SessionId,aEntityId,self.StoreId,'');
        for x := Low(mediaArray) to High(mediaArray) do begin
          ImageEntity := mediaArray[x];
          picName := Copy(ImageEntity.file_, 6, Length(ImageEntity.file_));
          if not Product.Pictures.Locate('ImageName',picName,[loCaseInsensitive]) then begin
            { not found so downloat it from web }
            Product.Pictures.New;
            Product.Pictures.ImageName := picName;
            picType := UpperCase(ExtractFileExt(ImageEntity.file_));
            picType := Copy(picType,2,255);
            if SameText(picType, 'JPEG') then
              picType := 'JPG';
            Product.Pictures.Pictype := picType;
            s := '';
            for y := Low(ImageEntity.types) to High(ImageEntity.types) do begin
              if s <> '' then s := s + ',';
              s := s + ImageEntity.types[y];
            end;
            Product.Pictures.ImageTypes := s;

            if not Assigned(HTTP) then begin
              HTTP := TIdHttp.Create(nil);
              HTTP.Request.UserAgent := HTTPConst.TrueERPUserAgent;
            end;
            if not Assigned(stream) then
              stream := TMemoryStream.Create;
            stream.Clear;
            HTTP.Get(ImageEntity.url, stream);
            //stream.SaveToFile('c:\temp\temp.' + pictype);
            stream.Position := 0;
            Product.Pictures.EditDB;
            BlobStream := Product.Pictures.Dataset.CreateBlobStream(Product.Pictures.Dataset.FieldByName('partPic') , bmWrite);
            try
              BlobStream.CopyFrom(stream, 0);
            finally
              BlobStream.Free;
            end;
            Product.Pictures.PostDb;

            qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
            try
              qry.SQL.Add('select * from tblshopxref where ERPInstId = ' + IntToStr(Product.Pictures.ID));
              qry.SQL.Add('and ShopId = ' + QuotedStr(self.StoreId));
              qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_ProductPicture));
              qry.Open;
              if qry.IsEmpty then begin
                qry.Insert;
                qry.FieldByName('ShopInstId').AsString := StoreID;
                qry.FieldByName('ObjectName').AsString := Obj_ProductPicture;
                //qry.FieldByName('ShopInstId').AsInteger := StrToInt(aEntityId);
                qry.FieldByName('ERPInstId').AsInteger := product.Pictures.ID;
              end
              else begin
                qry.Edit;
              end;

              qry.FieldByName('ProcessTime').AsDateTime := product.MsTimeStamp;
              qry.FieldByName('Processed').AsBoolean  := true;
              qry.Post;
            finally
              DbSharedObj.ReleaseObj(qry);
            end;
          end;
        end;


      finally
        product.Free;
        HTTP.Free;
        stream.Free;
      end;

      AppEnv.AppDb.TransConnection.Commit;
      result := true;
    except
      on e: exception do begin
        Log('Error synchronising Magento product with ERP: ' + e.Message, ltError);
      end;

    end;
  finally
    if AppEnv.AppDb.TransConnection.InTransaction then
      AppEnv.AppDb.TransConnection.Rollback;
  end;
end;

procedure TMagentoThreadTask.DoWork;
begin
  inherited;
  JsonToObj(Params,Self);
  SynchStore;
end;

function TMagentoThreadTask.GetNewSalesOrders: boolean;
var
  qry: TERPQuery;
//  cmd: TERPCommand;
  MaxMageTime: TDateTime;
  SOList, item: TJsonObject;
  filter: TMageDataFilter;
  msg: string;
  x: integer;
begin
  result := false;
  Log('Checking for new Magento Sales Orders ..', ltInfo);
  qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
//  cmd := DbSharedObj.GetCommand(AppEnv.AppDb.TransConnection);
  try
    qry.SQL.Add('select Max(ShopUpdatedTime) as MaxShopUpdatedTime from tblshopxref');
    qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
    qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_SalesOrder));
    qry.Open;
    MaxMageTime := qry.FieldByName('MaxShopUpdatedTime').AsDateTime;
    qry.Close;

    SOList := JO;
    try
      Mage.Filter.Clear;
      { all new sales orders }
      Mage.Filter.GreaterThan('updated_at',MaxMageTime);
      Mage.Filter.Fields.Add('entity_id');
      Mage.Filter.Fields.Add('updated_at');
//      Mage.Filter.Null('ext_order_id');
      if Mage.GetData(SOList,msg,'sales_order') then begin
        result := true;
//        SOList.SaveToFile('c:\temp\SOList.json');
        { save the new order numbers into a list for processing }

        AppEnv.AppDb.TransConnection.StartTransaction;
        try
          //cmd.SQL.Add('Insert ignore into tblshopxref');
          //cmd.SQL.Add('(ShopId,ObjectName,ShopInstId)');
          //cmd.SQL.Add('values ('+QuotedStr(self.StoreId)+','+QuotedStr(Obj_SalesOrder)+',:ShopInstId)');
          qry.SQL.Clear;
          qry.SQL.Add('select * from tblshopxref');
          qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
          qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_SalesOrder));
          qry.SQL.Add('and ShopInstId = :ShopInstId');

          for x := 0 to SOList.A['items'].Count -1 do begin
            item := SOList.A['items'].Items[x].AsObject;
            if item.DT['updated_at'] <= MaxMageTime then
              continue;  { make sure we dont process old ones }

            //cmd.ParamByName('ShopInstId').AsInteger := SOList.A['items'].Items[x].AsObject.ItemByName['entity_id'].Value.AsInteger;
            //cmd.Execute;
            qry.ParamByName('ShopInstId').AsInteger := item.ItemByName['entity_id'].Value.AsInteger;
            qry.Open;
            try
              if qry.IsEmpty then begin
                qry.Insert;
                qry.FieldByName('ShopId').AsInteger := StrToInt(StoreID);
                qry.FieldByName('ObjectName').AsString := Obj_SalesOrder;
                qry.FieldByName('ShopInstId').AsInteger := item.ItemByName['entity_id'].Value.AsInteger;
                qry.FieldByName('ShopUpdatedTime').AsDateTime := item.DT['updated_at'];
                qry.FieldByName('Processed').AsBoolean := False;
                qry.Post;
              end
              else begin
                qry.Edit;
                qry.FieldByName('ShopUpdatedTime').AsDateTime := item.DT['updated_at'];
                qry.FieldByName('Processed').AsBoolean := False;
                qry.Post;
              end;
            finally
              qry.Close;
            end;
          end;
          AppEnv.AppDb.TransConnection.Commit;
        except
          on e: exception do begin
            AppEnv.AppDb.TransConnection.Rollback;
            Log('Error getting list of new Order Numbers from Magento: ' + e.Message, ltError);
            exit;
          end;
        end;

        qry.SQL.Clear;
        qry.SQL.Add('select ShopInstId from tblshopxref');
        qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
        qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_SalesOrder));
        qry.SQL.Add('and Processed = "F"');
        qry.SQL.Add('order by ShopInstId ASC');
        qry.Open;

        while not qry.Eof do begin
          ProcessNewSalesOrder(qry.FieldByName('ShopInstId').AsInteger);
          qry.Next;
        end;

        result := true;
      end
      else begin
        Log('Error checking for new Magento Sales Orders: ' + msg,ltError);
      end;

    finally
      SOList.Free;
    end;


  finally
    Log('Finished checking for new Magento Sales Orders.', ltInfo);
    DbSharedObj.ReleaseObj(qry);
//    DbSharedObj.ReleaseObj(cmd);
  end;
end;

function TMagentoThreadTask.InitCountryID: boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  try
    qry.SQL.Add('select tblcountries.Shortcountrycode as country_id from tblregionaloptions');
    qry.SQL.Add('left join tblcountries on tblcountries.CountryId = tblregionaloptions.CountryID');
    qry.SQL.Add('where tblregionaloptions.RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
    qry.Open;
    country_id := qry.FieldByName('country_id').AsString;
    result:= country_id <> '';
    if not result then
      Log('Unable to determin Country Code (Magento country_id) for region ' + AppEnv.RegionalOptions.Region, ltError)
    else
      Log('Country ID set to: ' + country_id, ltDetail);

  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TMagentoThreadTask.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  inherited;
  self.ProgressTime := now;
end;

function TMagentoThreadTask.ProcessNewSalesOrder(OrderId: Integer): boolean;
var
  msg: string;
  o: TJsonObject;
  x, y: integer;
  line, MageSaleLine: TJsonObject;
  CashSale: TCashSale;
  s: string;
  qry: TERPQuery;
  qryPart: TERPQuery;
  qryTax: TERPQuery;
  code: string;
  shippingInc: double;
  SaleId: integer;
  status: string;


  function FormatAddress(J: TJsonObject): string;
  var
    s: string;
  begin
    result := JsonValAsString(J,'firstname');
    if JsonValAsString(J,'lastname') <> '' then begin
      if result <> '' then result := result + ' ';
      result := result + JsonValAsString(J,'lastname');
    end;
    s:= JsonValAsString(J,'company');
    if s <> '' then begin
      if result <> '' then result := result + #13#10;
      result := result + s;
    end;
    s := JsonValAsString(J,'street');
    if s <> '' then begin
      if result <> '' then result := result + #13#10;
      result := result + s;
    end;
    s := JsonValAsString(J,'city');
    if s <> '' then begin
      if result <> '' then result := result + #13#10;
      result := result + s;
    end;
    s := JsonValAsString(J,'region');
    if JsonValAsString(J,'postcode') <> '' then begin
      if s <> '' then s := s + ' ';
      s := s + JsonValAsString(J,'postcode');
    end;
    if s <> '' then begin
      if result <> '' then result := result + #13#10;
      result := result + s;
    end;
  end;

begin
  result := false;
  Log('Processing Magento Sale ' + IntToStr(OrderId),ltDetail);

  if not Assigned(MageSale) then  MageSale := JO;
  if not Assigned(MagePayment) then MagePayment := JO;

  { get sale header .. }
  if not Mage.GetData(MageSale,msg,'sales_order',OrderId) then begin
    Log('Error getting Sales Order from Magento: ' + msg, ltError);
    exit;
  end;
//  MageSale.SaveToFile('c:\temp\MageSale.json');

  status := JsonValAsString(MageSale, 'status');
//  if (not SameText(status, 'pending')) or (not SameText(status, 'canceled')) then begin
//    Log('Skipping Order with status: ' + JsonValAsString(MageSale, 'status'), ltDetail);
//    result := true;
//    exit;
//  end;

  if not Assigned(MageSaleLines) then
    MageSaleLines := JO
  else
    MageSaleLines.Clear;

  if not Assigned(filter) then
    filter := TMageDataFilter.Create
  else
    filter.Clear;

  if not Assigned(MageBillAddress) then MageBillAddress := JO;
  if not Assigned(MageShipAddress) then MageShipAddress := JO;

  if not Mage.GetData(MageBillAddress,msg,'sales_order_address',StrToInt(MageSale.S['billing_address_id']) ) then begin
    Log('Error getting Sales Order Billing Address from Magento: ' + msg, ltError);
    exit;
  end;
//  MageBillAddress.SaveToFile('c:\temp\BillingAddress.json');


//  Log('Customer Name: ' + MageSale.S['customer_firstname'] + ' ' + MageSale.S['customer_lastname'],ltDetail);
//  Log('Customer Email: ' + MageSale.S['customer_email'],ltDetail);
//  Log('Created: ' + MageSale.S['created_at'], ltDetail);
//  Log('Order Total Inc Tax: ' + MageSale.S['subtotal_incl_tax'],ltDetail);
//  Log('Shipping Inc Tax: ' + MageSale.S['shipping_incl_tax'],ltDetail);

  if not Mage.GetData(MageBillAddress,msg,'sales_order_address',StrToInt(MageSale.S['billing_address_id']) ) then begin
    Log('Error getting Sales Order Billing Address from Magento: ' + msg, ltError);
    exit;
  end;
//  MageBillAddress.SaveToFile('c:\temp\BillingAddress.json');

  if not Mage.GetData(MageShipAddress,msg,'sales_order_address',StrToInt(MageSale.S['shipping_address_id']) ) then begin
    Log('Error getting Sales Order Shipping Address from Magento: ' + msg, ltError);
    exit;
  end;
//  MageShipAddress.SaveToFile('c:\temp\ShippingAddress.json');

  { get sale payment .. }
  if not Mage.GetData(MagePayment,msg,'sales_order_payment',OrderId) then begin
    Log('Error getting Sales Order Payment from Magento: ' + msg, ltError);
    exit;
  end;
//  MagePayment.SaveToFile('c:\temp\MagePayment.json');

//  Log('Payment:',ltDetail);
//  Log('    Amount: ' + MagePayment.S['amount_ordered'],ltDetail);
//  Log('    Mthod: ' + MagePayment.S['method'],ltDetail);
//  if MagePayment.S['cc_type'] <> '' then
//  Log('    Card Type: ' + MagePayment.S['cc_type'],ltDetail);

//  Log('Bill Address:',ltDetail);
//  Log('    ' + MageBillAddress.S['firstname'] + ' ' + MageBillAddress.S['lastname'],ltDetail);
//  Log('    Ph ' + MageBillAddress.S['telephone'],ltDetail);
//  Log('    ' + MageBillAddress.S['street'],ltDetail);
//  Log('    ' + MageBillAddress.S['city'],ltDetail);
//  Log('    ' + MageBillAddress.S['region'],ltDetail);
//  Log('    ' + MageBillAddress.S['postcode'],ltDetail);

//  Log('Ship Address:',ltDetail);
//  Log('    ' + MageShipAddress.S['firstname'] + ' ' + MageBillAddress.S['lastname'],ltDetail);
//  Log('    Ph ' + MageShipAddress.S['telephone'],ltDetail);
//  Log('    ' + MageShipAddress.S['street'],ltDetail);
//  Log('    ' + MageShipAddress.S['city'],ltDetail);
//  Log('    ' + MageShipAddress.S['region'],ltDetail);
//  Log('    ' + MageShipAddress.S['postcode'],ltDetail);

  filter.Clear;
  o := JO('{"field":"order_id","filter":{"eq":'+IntToStr(OrderId)+'}}');
  o.FormatOutput := false;
  filter.A['filters'].Add(o);
  { get sale lines .. }
  if not Mage.GetData(MageSaleLines,msg,'sales_order_item',0,filter) then begin
    Log('Error getting Sales Order Lines from Magento: ' + msg, ltError);
    exit;
  end;

  if not Assigned(Lines) then
    lines := JO
  else
    Lines.Clear;
  try
//    MageSaleLines.SaveToFile('c:\temp\Magento\SalesLInes_' + FormatDateTime('yymmdd-hhnnsszzz',now)+ '.json');
    for x := 0 to MageSaleLines.A['items'].Count -1 do begin
      { there may be more than one line per order line ..
        depending on product type, check if line has a parent_item_id }
      MageSaleLine := MageSaleLines.A['items'].Items[x].AsObject;
      if StrToIntDef(JsonValAsString(MageSaleLine,'order_id'),0) <> OrderId then
        continue;

      o := nil;
      if MageSaleLine.ItemByName['parent_item_id'].Value.IsTypeNull then begin
        { a new line .. }
        o := JO;
        o.S['item_id'] := MageSaleLine.S['item_id'];
        o.S['sku'] := MageSaleLine.S['sku'];
        o.S['name'] := MageSaleLine.S['name'];

        lines.A['items'].Add(o);
      end
      else begin
        { ref to another line .. }
        for y := 0 to lines.A['items'].Count -1 do begin
          if lines.A['items'].Items[y].AsObject.S['item_id'] = MageSaleLine.S['parent_item_id'] then begin
            o := lines.A['items'].Items[y].AsObject;
            break;
          end;
        end;
      end;
      { now update/get line data }

      if StrToFloatDef(MageSaleLine.S['qty_ordered'],0) <> 0 then
        o.S['qty_ordered'] := FloatToStr(StrToFloatDef(MageSaleLine.S['qty_ordered'],0));
      if StrToFloatDef(MageSaleLine.S['tax_percent'],0) <> 0 then
        o.S['tax_percent'] := FloatToStr(StrToFloatDef(MageSaleLine.S['tax_percent'],0));
      if StrToFloatDef(MageSaleLine.S['tax_amount'],0) <> 0 then
        o.S['tax_amount'] := FloatToStr(StrToFloatDef(MageSaleLine.S['tax_amount'],0));
      if StrToFloatDef(MageSaleLine.S['price_incl_tax'],0) <> 0 then
        o.S['price_incl_tax'] := FloatToStr(StrToFloatDef(MageSaleLine.S['price_incl_tax'],0));
      if StrToFloatDef(MageSaleLine.S['row_total_incl_tax'],0) <> 0 then
        o.S['row_total_incl_tax'] := FloatToStr(StrToFloatDef(MageSaleLine.S['row_total_incl_tax'],0));


    end;

    { get line tax data.. }
    if not Assigned(MageSaleTax) then MageSaleTax := JO;
    if not Assigned(MageSaleTaxItem) then MageSaleTaxItem := JO;
    for x := 0 to lines.A['items'].Count -1 do begin
      line := lines.A['items'].Items[x].AsObject;
      filter.Clear;
      o := JO('{"field":"item_id","filter":{"eq":'+ line.S['item_id'] +'}}');
      o.FormatOutput := false;
      filter.A['filters'].Add(o);
      if not Mage.GetData(MageSaleTaxItem,msg,'tax_sales_order_tax_item',0,filter) then begin
        Log('Error getting Sales Order Tax Item from Magento: ' + msg, ltError);
        exit;
      end;
      if not Mage.GetData(MageSaleTax,msg,'tax_sales_order_tax',StrToIntDef(MageSaleTaxItem.S['tax_id'],0)) then begin
        Log('Error getting Sales Order Tax from Magento: ' + msg, ltError);
        exit;
      end;
      line.O['tax'].Assign(MageSaleTax);

    end;


    { get line tax info }
//    Log(lines.AsString,ltDetail);
//    Lines.SaveToFile('c:\temp\Lines.json');

    { process the order ... }
    qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
    qryPart := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
    qryTax := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
    try

      qry.SQL.Add('select * from tblshopxref');
      qry.SQL.Add('where ShopId = ' + QuotedStr(self.StoreId));
      qry.SQL.Add('and ObjectName = ' + QuotedStr(Obj_SalesOrder));
      qry.SQL.Add('and ShopInstId = ' + IntToStr(OrderId));
      qry.Open;
      SaleId := qry.FieldByName('ERPInstId').AsInteger;

      qryTax.SQL.Text := 'select Name from tblTaxCodes where RegionId = ' + IntToStr(Appenv.RegionalOptions.ID);
      qryTax.Open;

      AppEnv.AppDb.TransConnection.StartTransaction;
      try
        CashSale := TCashSale.Create(nil);
        try
          CashSale.Connection := TMyDacDataConnection.Create(CashSale);
          CashSale.Connection.Connection := AppEnv.AppDb.TransConnection;
          if SaleID > 0 then begin
            { existing sale so update it }
            CashSale.Load(SaleID);
            CashSale.Comments := Status + ' ' +
              DateTimeToStr(MageSale.DT['updated_at']) + #13#10 + CashSale.Comments;

          end
          else if (not SameText(status, 'canceled')) then begin
            { new sale .. }
            CashSale.Load(0);
            CashSale.New;

            { Header .. }
            CashSale.CustomerName := CLIENT_CASH;
            CashSale.Comments := 'Cart Sale #: ' + JsonValAsString(MageSale,'increment_id') + #13#10 +
              Status + ' ' + DateTimeToStr(MageSale.DT['updated_at']);
            CashSale.InvoiceToDesc := FormatAddress(MageBillAddress);
            s := FormatAddress(MageShipAddress);
            if (s <> '') and (s <> CashSale.InvoiceToDesc) then
              CashSale.Comments := CashSale.Comments + #13#10 + 'Ship to:' + #13#10 + s;

            { Lines .. }
            for x := 0 to lines.A['items'].Count -1 do begin
              line := lines.A['items'].Items[x].AsObject;
              CashSale.Lines.New;
              CashSale.Lines.ProductID := TProduct.IdForProductCode(JsonValAsString(line,'sku'));
              if CashSale.Lines.ProductID < 1 then begin
                { we don't have this product in ERP! }
                msg := 'Error processing Magento Order ' + IntToStr(OrderId) +
                  ': ERP Product not found for sku "' + JsonValAsString(line,'sku') + '"';
                Log(msg,ltError);
                if (now - qry.FieldByName('ProcessTime').AsDateTime) >= 1 then
                  SendErrorEmail(CashSale,'Error processing Magento Order',msg);
                exit;
              end;
              { find the line tax type .. }
              if line.O['tax'].A['items'].Count > 0 then begin
                code := JsonValAsString(line.O['tax'].A['items'].Items[0].AsObject,'code');
                if code <> '' then begin
                  qryTax.First;
                  while not qryTax.Eof do begin
                    if Pos(Lowercase(qryTax.FieldByName('Name').asString),Lowercase(code)) > 0 then begin
                      CashSale.Lines.LineTaxCode := qryTax.FieldByName('Name').asString;
                      break;
                    end;
                    qryTax.Next;
                  end;
                end;
              end;
  //            CashSale.Lines.LinePriceInc := StrToFloatDef(JsonValAsString(line,'price_incl_tax'));
              CashSale.Lines.QtyShipped := StrToFloatDef(JsonValAsString(line,'qty_ordered'),0);
              CashSale.Lines.TotalLineAmountInc := StrToFloatDef(JsonValAsString(line,'row_total_incl_tax'),0);
              CashSale.Lines.PostDb;
            end;

            ShippingInc := StrToFloatDef(JsonValAsString(MageSale,'shipping_incl_tax'),0);
            if ShippingInc <> 0 then begin
              CheckShippingProduct;
              CashSale.Lines.New;
              CashSale.Lines.ProductName := Shipping_Product;
              CashSale.Lines.ProductDescription := Shipping_Product + ' ' + JsonValAsString(MageSale,'shipping_description');
              CashSale.Lines.QtyShipped := 1;
              CashSale.Lines.TotalLineAmountInc := ShippingInc;
              CashSale.Lines.PostDb;
            end;

            if not Math.SameValue(CashSale.TotalAmountInc, StrToFloatDef(JsonValAsString(MageSale,'grand_total'),0),0.00001) then begin
              msg := 'Error processing Magento Order ' + IntToStr(OrderId) +
                ': ERP Cash Sale Total ' + FloatToStr(CashSale.TotalAmountInc) +
                ' does not match Magento Order total ' + JsonValAsString(MageSale,'grand_total');
              Log(msg,ltError);
              if (now - qry.FieldByName('ProcessTime').AsDateTime) >= 1 then
                SendErrorEmail(CashSale,'Error processing Magento Order',msg);
              exit;
            end;

            { payments }
            if CashSale.SalesPayments.Count = 0 then
              CashSale.SalesPayments.New;
            CashSale.SalesPayments.PayMethod := MagePaymentMethodToCashSalePaymentMethod(JsonValAsString(MagePayment,'method'));
            CashSale.SalesPayments.Amount := StrToFloatDef(JsonValAsString(MagePayment,'method'),0);
            if CashSale.SalesPayments.PayMethod = '' then begin
              msg:= 'Error processing Magento Order ' + IntToStr(OrderId) +
                ' Magento payment method "'+JsonValAsString(MagePayment,'method')+'" invalid for ERP Cash Sale.';
              Log(msg, ltError);
              if (now - qry.FieldByName('ProcessTime').AsDateTime) >= 1 then
                SendErrorEmail(CashSale,'Error processing Magento Order',msg);
              exit;
            end;
          end;

          if (CashSale.Id > 0) and (not CashSale.Save) then begin
            msg := 'Error processing Magento Order ' + IntToStr(OrderId) +
              ': ' + CashSale.ResultStatus.Messages;
            Log(msg, ltError);
            if (now - qry.FieldByName('ProcessTime').AsDateTime) >= 1 then
              SendErrorEmail(CashSale,'Error processing Magento Order',msg);
            exit;
          end;

          SaleId := CashSale.ID;
          qry.Edit;
          qry.FieldByName('Processed').AsBoolean := true;
          qry.FieldByName('ShopUpdatedTime').AsDateTime := MageSale.DT['updated_at'];
          qry.Post;
          AppEnv.AppDb.TransConnection.Commit;
          Log('Sales Order ' + IntToStr(SaleId) + ' created/updated in ERP.', ltDetail);
          SendErrorEmail(CashSale,'Success Processing Magento Order','');
        finally;
          CashSale.Free;
          if AppEnv.AppDb.TransConnection.InTransaction then
            AppEnv.AppDb.TransConnection.Rollback;

        end;
      except
        on e: exception do begin
          if AppEnv.AppDb.TransConnection.InTransaction then
            AppEnv.AppDb.TransConnection.Rollback;
          msg := 'Error processing Magento Order ' + IntToStr(OrderId) +
            ': ' + e.Message;
          Log(msg, ltError);
          SendErrorEmail(CashSale,'Error processing Magento Order',msg);
        end;
      end;

    finally
      if AppEnv.AppDb.TransConnection.InTransaction then
        AppEnv.AppDb.TransConnection.Rollback;
      try
        AppEnv.AppDb.TransConnection.StartTransaction;
        qry.Edit;
        if (now - qry.FieldByName('ProcessTime').AsDateTime) >= 1 then
          qry.FieldByName('ProcessTime').AsDateTime := now;
        qry.FieldByName('ERPInstId').AsInteger := SaleId;
        qry.Post;
        AppEnv.AppDb.TransConnection.Commit;
      except
      end;
      DbSharedObj.ReleaseObj(qry);
      DbSharedObj.ReleaseObj(qryPart);
      DbSharedObj.ReleaseObj(qryTax);
    end;


  finally
//    lines.Free;
  end;

  result := true;
end;

function TMagentoThreadTask.RequirementsOk: boolean;
begin
  result := false;
  if Self.ERPDatabase = '' then begin
    Log('There is no ERP Database selected.',ltError);
    exit;
  end;
  if ERPUser = '' then begin
    Log('There is no ERP User Name specified.',ltError);
    exit;
  end;
  if ERPPassword = '' then begin
    Log('There is no ERP User Password specified.',ltError);
    exit;
  end;
  if StoreID = '' then begin
    Log('There is no Magento Store ID specified.',ltError);
    exit;
  end;
  if StoreURL = '' then begin
    Log('There is no Magento Store URL specified.',ltError);
    exit;
  end;


  result := true;
end;


procedure TMagentoThreadTask.SendErrorEmail(Sale: TSalesBase; Subject,
  ErrorMessage: string);
var
  s: string;
  x: integer;
  o: TJsonObject;

  function FormatMoney(val: double): string; overload;
  begin
    result:= FormatFloat('###,###,###,###,##0.00###;-###,###,###,###,##0.00###',val);
  end;

  function FormatMoney(val: string): string; overload;
  begin
    result := FormatMoney(StrToFloatDef(val,0));
  end;

begin
  s:=
    '<P>' + ErrorMessage + '</P>' + #13#10 +
    '<H2>Magento Order No ' + JsonValAsString(MageSale,'entity_id') +'</H2>' + #13#10 +
    '<table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +

    '  <tr>' + #13#10 +
    '    <th align="left">Order # ' + JsonValAsString(MageSale,'increment_id') +'</th>' + #13#10 +
    '  </tr>' + #13#10 +

    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr><td width="80">Customer</td><td>'+JsonValAsString(MageSale,'customer_firstname')+' '+JsonValAsString(MageSale,'customer_lastname')+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Order Date</td><td>'+JsonValAsString(MageSale,'created_at')+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Order Status</td><td>'+JsonValAsString(MageSale,'status')+'</td></tr>' + #13#10 +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +

    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr>' + #13#10 +
    '        <th align="Left">Billing Address</th>' + #13#10 +
    '        <th align="Left">Shipping Address</th>' + #13#10 +
    '      </tr>' + #13#10 +
    '      <tr>' + #13#10 +
    '        <td>' + #13#10 +
    '          <table cellspacing="0" cellpadding="10" border="0" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageBillAddress,'firstname')+' '+JsonValAsString(MageBillAddress,'lastname')+'</td></tr>' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageBillAddress,'street')+'</td></tr>' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageBillAddress,'city')+'</td></tr>' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageBillAddress,'region')+' '+JsonValAsString(MageBillAddress,'postcode')+'</td></tr>' + #13#10 +
    '          </table>' + #13#10 +
    '        </td>' + #13#10 +
    '        <td>' + #13#10 +
    '          <table cellspacing="0" cellpadding="10" border="0" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageShipAddress,'firstname')+' '+JsonValAsString(MageShipAddress,'lastname')+'</td></tr>' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageShipAddress,'street')+'</td></tr>' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageShipAddress,'city')+'</td></tr>' + #13#10 +
    '            <tr><td>'+JsonValAsString(MageShipAddress,'region')+' '+JsonValAsString(MageShipAddress,'postcode')+'</td></tr>' + #13#10 +
    '          </table>' + #13#10 +
    '        </td>' + #13#10 +
    '      </tr>' + #13#10 +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +

    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr>' + #13#10 +
    '        <th align="Left">Payment Information</th>' + #13#10 +
    '        <th align="Left">Shipping & Handling Information</th>' + #13#10 +
    '      </tr>' + #13#10 +
    '      <tr>' + #13#10 +
    '        <td>' + #13#10 +
    '          <table cellspacing="0" cellpadding="10" border="0" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '            <tr><td width="80">Method</td><td>'+JsonValAsString(MagePayment,'method')+'</td></tr>' + #13#10 +
    '            <tr><td width="80">Card Type</td><td>'+JsonValAsString(MagePayment,'cc_type')+'</td></tr>' + #13#10 +
    '            <tr><td width="80">Amount</td><td>'+FormatMoney(JsonValAsString(MagePayment,'amount_ordered'))+'</td></tr>' + #13#10 +
    '          </table>' + #13#10 +
    '        </td>' + #13#10 +
    '        <td>' + #13#10 +
    '          <table cellspacing="0" cellpadding="10" border="0" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '            <tr><td width="80">Description</td><td>'+JsonValAsString(MageSale,'shipping_description')+'</td></tr>' + #13#10 +
    '            <tr><td width="80">Total Inc</td><td>'+FormatMoney(JsonValAsString(MageSale,'shipping_incl_tax'))+'</td></tr>' + #13#10 +
    '          </table>' + #13#10 +
    '        </td>' + #13#10 +
    '      </tr>' + #13#10 +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +

    '  <tr>' + #13#10 +
    '    <th align="left"><b>Lines</b></th>' + #13#10 +
    '  </tr>' + #13#10 +
    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr>' + #13#10 +
    '        <th>SKU</th> <th>Name</th> <th>Price Inc</th> <th>Qty</th> <th>Tax%</th> <th>Tax Amt</th> <th>Total Inc</th>' +#13#10 +
    '      </tr>' + #13#10;
  for x := 0 to Lines.A['items'].Count -1 do begin
    o := Lines.A['items'].Items[x].AsObject;
    s := s +
      '<tr>' +
      '<td>'+JsonValAsString(o,'sku')+'</td>'+
      '<td>'+JsonValAsString(o,'name')+'</td>'+
      '<td>'+FormatMoney(JsonValAsString(o,'price_incl_tax'))+'</td>'+
      '<td>'+JsonValAsString(o,'qty_ordered')+'</td>'+
      '<td>'+JsonValAsString(o,'tax_percent')+'</td>'+
      '<td>'+FormatMoney(JsonValAsString(o,'tax_amount'))+'</td>'+
      '<td>'+FormatMoney(JsonValAsString(o,'row_total_incl_tax'))+'</td>'+
      '</tr>' + #13#10;
  end;
  s := s +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +

    '  <tr>' + #13#10 +
    '    <th align="left"><b>Order Totals</b></th>' + #13#10 +
    '  </tr>' + #13#10 +
    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr><td width="80">Total Ex</td><td>'+FormatMoney(JsonValAsString(MageSale,'subtotal'))+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Tax</td><td>'+FormatMoney(JsonValAsString(MageSale,'tax_amount'))+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Shipping Inc</td><td>'+FormatMoney(JsonValAsString(MageSale,'shipping_incl_tax'))+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Total Inc</td><td>'+FormatMoney(JsonValAsString(MageSale,'grand_total'))+'</td></tr>' + #13#10 +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +
    '</table></br>';

  if not Assigned(Sale) then begin
    s:= s +
      '<H2>ERP Sale not created.</H2>' + #13#10;
  end
  else begin
    s:= s +
      '<H2>ERP '+Sale.XMLNodeName+'</H2>' + #13#10 +
    '<table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +

    '  <tr>' + #13#10 +
    '    <th align="left">Cash Sale # ' + Sale.DocNumber +'</th>' + #13#10 +
    '  </tr>' + #13#10 +

    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr><td width="80">Customer</td><td>'+Sale.CustomerName+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Date</td><td>'+DateToStr(Sale.SaleDate)+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Department</td><td>'+Sale.SaleClassName+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Payment Method</td><td>'+Sale.PayMethod+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Reference No</td><td>'+Sale.ChequeNumber+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Employee</td><td>'+Sale.EmployeeName+'</td></tr>' + #13#10 +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +
    '  <tr>' + #13#10 +
    '    <th align="left"><b>Lines</b></th>' + #13#10 +
    '  </tr>' + #13#10 +
    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr>' + #13#10 +
    '        <th>Name</th> <th>Description</th> <th>UOM Qty</th> <th>UOM</th> <th>Qty</th> <th>Tax Code</th> <th>Tax%</th> <th>Tax Amt</th> <th>Amount Inc</th> <th>Total Inc</th>' +#13#10 +
    '      </tr>' + #13#10;
  Sale.Lines.First;
  while not Sale.Lines.EOF do begin
    s := s +
      '<tr>' +
      '<td>'+Sale.Lines.ProductName+'</td>'+
      '<td>'+Sale.Lines.ProductDescription+'</td>'+
      '<td>'+FloatToStr(Sale.Lines.UOMQtySold)+'</td>'+
      '<td>'+Sale.Lines.UnitOfMeasure+'</td>'+
      '<td>'+FloatToStr(Sale.Lines.QtyShipped)+'</td>'+
      '<td>'+Sale.Lines.LineTaxCode+'</td>'+
      '<td>'+FloatToStr(Sale.Lines.LineTaxRate * 10)+'</td>'+
      '<td>'+FormatMoney(Sale.Lines.LineTaxTotal)+'</td>'+
      '<td>'+FormatMoney(Sale.Lines.LinePriceInc)+'</td>'+
      '<td>'+FormatMoney(Sale.Lines.TotalLineAmountInc)+'</td>'+
      '</tr>' + #13#10;
    Sale.Lines.Next;
  end;

  s := s + #13#10 +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +
    '  <tr>' + #13#10 +
    '    <th align="left"><b>Order Totals</b></th>' + #13#10 +
    '  </tr>' + #13#10 +
    '  <tr>' + #13#10 +
    '    <table cellspacing="0" cellpadding="10" border="1" style="width:100%; border-collapse:collapse;">' + #13#10 +
    '      <tr><td width="80">Comments</td><td>'+StringReplace(Sale.Comments,#13#10,'</br>',[rfReplaceAll])+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Total Ex</td><td>'+FormatMoney(Sale.TotalAmount)+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Tax</td><td>'+FormatMoney(Sale.TotalTax)+'</td></tr>' + #13#10 +
    '      <tr><td width="80">Total Inc</td><td>'+FormatMoney(Sale.TotalAmountInc)+'</td></tr>' + #13#10 +
    '    </table>' + #13#10 +
    '  </tr>' + #13#10 +
    '</table></br>';
  end;
  EmailUtilsSimple.SendEmail(self.AdminEmail,Subject,s,true,true);
end;

procedure TMagentoThreadTask.SynchStore;
var
  msg: string;
  store: StoreEntity;
begin
  Log('Starting synch with Magento Store ..',ltInfo);
  if not self.RequirementsOk then exit;

  CoInitialize(nil);
  try
    try
      AppEnv.AppDb.Database := ERPDatabase;
      AppEnv.AppDb.ConnectUser(ERPUser, ERPPassword);
    except
      on eusr: exception do begin
        Log('Error connecting to ERP: ' + eusr.Message,ltError);
        exit;
      end;
    end;
    try
      if not AppEnv.UtilsClient.ConnectUser(msg,'localhost',ERPDatabase,ERPUser,'','',true) then begin
        Log('Could not connect to ERP. ' + msg,ltError);
        exit;
      end;
      try
        if not InitCountryID then exit;

        if not Assigned(Mage) then begin
          Mage := TMagento.Create;
          Mage.OnLogEvent := self.Log;
        end;
        Mage.StoreURL := self.StoreURL;
        Mage.StoreId := StrToInt(StoreId);
        Mage.ApiUser := ApiUser;
        Mage.ApiKey := ApiKey;

        try
          Mage.API;
          Log('Magento session Id: ' + Mage.SessionId,ltDetail);
          store := Mage.API.storeInfo(Mage.SessionId,StoreID);
          Log('Started synch on story: '  + store.name_, ltDetail);
  //        Log('Started synch on story: '  + Mage.Api.storeInfo(Mage.SessionId,StoreID).name_, ltDetail);
        except
          on e: exception do begin
            Mage.SessionId := '';
            store := Mage.API.storeInfo(Mage.SessionId,StoreID);
            Log('Started synch on story: '  + store.name_, ltDetail);
  //          Log('Started synch on story: '  + Mage.Api.storeInfo(Mage.SessionId,StoreID).name_, ltDetail);
          end;
        end;

        //if params.B['GetStoreDataNowClicked'] then begin
        if UpdateERPFromStore then begin
          { reverse synch to add products and pictures from store to erp }
          if not DownCheckProducts then exit;

        end
        else begin
          { normal synch }

          UpCheckProducts;
          CheckProductPictures;

          GetNewSalesOrders;

          if self.UpdateQuantities then
            CheckQuantities;

        end;
      finally
        AppEnv.UtilsClient.RemoveUser(ERPUser, ERPDatabase);
      end;
    finally
      AppEnv.AppDb.TransConnection.Disconnect;
      AppEnv.AppDb.Connection.Disconnect;
    end;
  finally
    CoUninitialize;
  end;

  Log('Finished synch with Magento Store.',ltInfo);
end;

procedure TMagentoThreadTask.UpSyncProduct(xrefId: integer);
var
  qryXRef: TERPQuery;
  product: TProductWeb;
  msg: string;
begin
  qryXRef := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  product := TProductWeb.Create(nil);
  try
    product.SilentMode := true;
    qryXRef.SQL.Text := 'select * from tblshopxref where Id = ' + IntToStr(xrefId);
    qryXRef.Open;
    product.Connection := TMyDacDataConnection.Create(product);
    product.Connection.Connection := AppEnv.AppDb.Connection;

    if not Assigned(MageProduct) then MageProduct := TJsonObject.Create;
    if not Assigned(filter) then filter := TMageDataFilter.Create;

    try
      AppEnv.AppDb.TransConnection.StartTransaction;
      try
        Product.Load(qryXRef.FieldByName('ERPInstId').AsInteger);

        if qryXRef.FieldByName('ShopInstId').AsInteger < 1 then begin
          { we dont have product in Magento yet .. }
          { check product does not allready exist for sku }

          filter.Clear;
          filter.Equal('sku',Product.ProductCode);
          if not Mage.GetData(MageProduct,msg,'catalog_product',0,filter) then begin
            Log('Error getting Product from Magento: ' + msg, ltError);
            exit;
          end;
          if MageProduct.A['items'].Count > 0 then begin
            qryXRef.Edit;
            qryXRef.FieldByName('ShopInstId').AsInteger :=
              MageProduct.A['items'].Items[0].AsObject.ItemByName['entity_id'].Value.AsInteger;
            qryXRef.Post;
          end
          else begin
            { create it }
            MageProduct.Clear;
            MageProduct.S['sku'] := Product.ProductCode;
            MageProduct.S['name'] := Product.ProductName;
            MageProduct.S['attribute_set_id'] := Mage.DefaultProductAttributeSetId;
            MageProduct.S['short_description'] := Product.SalesDescription;
            MageProduct.S['description'] := Product.SalesDescription;
            if Product.Active and (not Product.IsDiscontinued) then MageProduct.S['status'] := '1'
            else MageProduct.S['status'] := '0';
            MageProduct.S['visibility'] := '4';
            MageProduct.S['price'] := FloatToStr(Product.SellQty1Price);
            MageProduct.S['type_id'] := 'simple';
            MageProduct.S['tax_class_id'] := '2'; { Taxable Goods }
            if Product.UOMList.LocateByID(Product.UOMSalesID) then begin
              SetJsonVal(MageProduct, 'weight', FloatToStr(Product.UOMList.Weight));
            end;
            MageProduct.S['is_in_stock'] := '1';

            if not Assigned(PostResult) then PostResult := TJsonObject.Create;

            if not Mage.PostData(MageProduct,PostResult,msg,'catalog_product') then begin
              msg := 'Error creating product ('+Product.ProductName+') in Magento: ' + msg;
              Log(msg,ltError);
              if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
            end
            else begin
              qryXRef.Edit;
              qryXRef.FieldByName('ShopInstId').AsInteger :=
                PostResult.ItemByName['entity_id'].Value.AsInteger;
              qryXRef.FieldByName('ProcessTime').AsDateTime := Product.MsTimeStamp;
              qryXRef.FieldByName('Processed').AsBoolean := true;
              qryXRef.Post;
            end;
            exit;
          end;
        end;

        if not Mage.GetData(MageProduct,msg,'catalog_product',qryXRef.FieldByName('ShopInstId').AsInteger) then begin
          Log('Error getting Product from Magento: ' + msg, ltError);
          exit;
        end;

        if StrToIntDef(MageProduct.S['entity_id'],0) <> qryXRef.FieldByName('ShopInstId').AsInteger then begin
          { not found in shop, mayme deleted from shop }
          { zero out shop id, and will be created in Magento next pass }
          qryXRef.Edit;
          qryXRef.FieldByName('ShopInstId').AsInteger := 0;
          qryXRef.Post;
          msg := 'Product (' + Product.Name + ') not found in Magento (may have been deleted)';
          Log(msg,ltWarning);
          if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Commit;
          exit;
        end;

        { update magento product .. }
        SetJsonVal(MageProduct, 'short_description', Product.SalesDescription);
        SetJsonVal(MageProduct, 'description', Product.SalesDescription);

        SetJsonVal(MageProduct, 'price', FloatToStr(Product.SellQty1Price));
        if Product.Active and (not Product.IsDiscontinued) then SetJsonVal(MageProduct, 'status', '1')
        else SetJsonVal(MageProduct, 'status', '0');
        if Product.UOMList.LocateByID(Product.UOMSalesID) then begin
          SetJsonVal(MageProduct, 'weight', FloatToStr(Product.UOMList.Weight));
        end;



        if not Assigned(PostResult) then PostResult := TJsonObject.Create;
        if not Mage.PostData(MageProduct,PostResult,msg,'catalog_product',qryXRef.FieldByName('ShopInstId').AsInteger) then begin
          msg := 'Error updating product ('+Product.ProductName+') in Magento: ' + msg;
          Log(msg,ltError);
          if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
          exit;
        end
        else begin
          qryXRef.Edit;
          qryXRef.FieldByName('ProcessTime').AsDateTime := Product.MsTimeStamp;
          qryXRef.FieldByName('Processed').AsBoolean := true;
          qryXRef.Post;
        end;

      finally
        if AppEnv.AppDb.TransConnection.InTransaction then
          AppEnv.AppDb.TransConnection.Commit;
      end;


    except
      on E: exception do begin
        if AppEnv.AppDb.TransConnection.InTransaction then
          AppEnv.AppDb.TransConnection.Rollback;
        msg := 'Error while updating product: ' + e.Message;
        Log(msg, ltError);
      end;
    end;

  finally
    DbSharedObj.ReleaseObj(qryXRef);
    Product.Free;
  end;

end;

procedure TMagentoThreadTask.UpSyncProductPicture(xrefId: integer);
var
  qryXRef: TERPQuery;
  qry: TERPQuery;
  msg: string;
  MageProductId: integer;
  imageList: catalogProductImageEntityArray;
  x: integer;
  newImage: catalogProductAttributeMediaCreateEntity;
  fileEnt: catalogProductImageFileEntity;
  ProductPicture: TProductPicture;
  imgTypes: ArrayOfString;
  s: string;
begin
  qryXRef := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  try
    qryXRef.SQL.Text := 'select * from tblshopxref where Id = ' + IntToStr(xrefId);
    qryXRef.Open;
    { we need the magento product id .. }
    qry.SQL.Add('select x.ShopInstId as ShopInstId from tblpartspics pp');
    qry.SQL.Add('inner join tblshopxref x on');
    qry.SQL.Add('x.ShopId = ' + QuotedStr(self.StoreId));
    qry.SQL.Add('and x.ObjectName = ' + QuotedStr(Obj_Product));
    qry.SQL.Add('and x.ERPInstId = pp.partID');
    qry.SQL.Add('where pp.partPicId = ' + IntToStr(qryXRef.FieldByName('ERPInstId').AsInteger));
    qry.Open;
    MageProductId := qry.FieldByName('ShopInstId').AsInteger;
    qry.Close;
    if MageProductId = 0 then exit;


    AppEnv.AppDb.TransConnection.StartTransaction;
    try
      try

      { delete and shop existing pictures .. }
      imageList := Mage.API.catalogProductAttributeMediaList(Mage.SessionId,IntToStr(MageProductId),IntToStr(Mage.StoreId),'');
      for x := Low(imageList) to High(imageList) do begin
        Mage.API.catalogProductAttributeMediaRemove(Mage.SessionId,IntToStr(MageProductId),imageList[x].file_,'');
      end;

      // http://www.demacmedia.com/magento-commerce/upserting-product-images-via-magento-api/

      ProductPicture := TProductPicture.CreateWithSharedConn(nil);
      fileEnt := catalogProductImageFileEntity.Create;
      newImage := catalogProductAttributeMediaCreateEntity.Create;
      try
        ProductPicture.Load(qryXRef.FieldByName('ERPInstId').AsInteger);
        if SameText(ProductPicture.Pictype,'JPG') then
          fileEnt.mime := 'image/jpeg'
        else
          fileEnt.mime := 'image/' + Lowercase(ProductPicture.Pictype);
        fileEnt.name_ := ProductPicture.ImageName; //  StrToValidFileName(ProductPicture.ProductName + '_' + IntToStr(ProductPicture.Id)) + '.' + ProductPicture.Pictype;
        fileEnt.content := ProductPicture.MIMEEncodedPicture;

        newImage.exclude := '0';
        newImage.label_ := ProductPicture.ProductName;
        newImage.position := '0';
        SetLength(imgTypes,3);
        imgTypes[0] := 'image';
        imgTypes[1] := 'small_image';
        imgTypes[2] := 'thumbnail';
        newImage.types := imgTypes;
        newImage.file_ := fileEnt;

        s := Mage.API.catalogProductAttributeMediaCreate(Mage.SessionId,IntToStr(MageProductId),newImage,IntToStr(Mage.StoreId),'');
        Log('Created image: ' + s, ltDetail);

      finally
        ProductPicture.Free;
        newImage.Free;
        //fileEnt.Free;
      end;

      qryXRef.Edit;
      qryXRef.FieldByName('Processed').AsBoolean := true;
      qryXRef.Post;


      except
        on e: exception do begin
          if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
          msg := 'Error sending product picture to Magento: ' + e.Message;
          Log(msg, ltError);
          exit;
        end;
      end;
    finally
      if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Commit;
    end;

  finally
    DbSharedObj.ReleaseObj(qryXRef);
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TMagentoThreadTask.UpSyncProductQty(xrefId: integer);
var
  qryXRef: TERPQuery;
  qry: TERPQuery;
  msg: string;
  StockItemId: string;
//  J: TJsonObject;
  newStock: TJsonObject;
begin
  qryXRef := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  qry := DbSharedObj.GetQuery(AppEnv.AppDb.TransConnection);
  try
    qryXRef.SQL.Text := 'select * from tblshopxref where Id = ' + IntToStr(xrefId);
    qryXRef.Open;
    qry.SQL.Text := 'select * from tblshopstock where ProductId = ' + IntToStr(qryXRef.FieldByName('ERPInstId').AsInteger);
    qry.Open;

    if qryXRef.FieldByName('ShopInstId').AsInteger < 1 then
      exit; { ignore products that are not in shop }

    AppEnv.AppDb.TransConnection.StartTransaction;
    try
      try
        StockItemId := Mage.StockItemIdForProductId(qryXRef.FieldByName('ShopInstId').AsInteger);
        if StockItemId = '' then begin
          if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
          msg := 'Could not find Stock Item Id for shop Product Id ' + qryXRef.FieldByName('ShopInstId').AsString;
          Log(msg, ltError);
          exit;
        end;

//        if not Assigned(MageStock) then MageStock := TJsonObject.Create;
//        if not Mage.GetData(MageStock,msg,'cataloginventory_stock_item',StrToInt(StockItemId)) then begin
//          if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
//          Log('Error getting Product Stock from Magento: ' + msg, ltError);
//          exit;
//        end;

//        if MageStock.A['items'].Count <> 1 then begin
//          if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
//          Log('Error getting Product Stock from Magento: Item count returned = ' + IntToStr(MageStock.A['items'].Count), ltError);
//          exit;
//        end;
//
//        J := MageStock.A['items'].Items[0].AsObject;

//        SetJsonVal(J,'qty',FormatFloat('#0.00000',qry.FieldByName('QuantityAvailable').AsFloat));
//        if Frac(qry.FieldByName('QuantityAvailable').AsFloat) <> 0 then
//          SetJsonVal(J,'is_qty_decimal','1')
//        else
//          SetJsonVal(J,'is_qty_decimal','0');
//        if Frac(qry.FieldByName('QuantityAvailable').AsFloat) > 0 then
//          SetJsonVal(J,'is_in_stock','1')
//        else
//          SetJsonVal(J,'is_in_stock','0');

        if not Assigned(PostResult) then PostResult := TJsonObject.Create;

        newStock := TJsonObject.Create;
        try
          newStock.S['item_id'] := StockItemId;
          newStock.S['product_id'] := IntToStr(qryXRef.FieldByName('ShopInstId').AsInteger);
          newStock.S['qty'] := FormatFloat('#0.00000',qry.FieldByName('QuantityAvailable').AsFloat);
          if Frac(qry.FieldByName('QuantityAvailable').AsFloat) <> 0 then
            newStock.S['is_qty_decimal'] := '1'
          else
            newStock.S['is_qty_decimal'] := '0';
          if qry.FieldByName('QuantityAvailable').AsFloat > 0 then
            newStock.S['is_in_stock'] := '1'
          else
            newStock.S['is_in_stock'] := '0';



          if not Mage.PostData(newStock,PostResult,msg,'cataloginventory_stock_item',StrToInt(StockItemId)) then begin
            msg := 'Error updating product stock in Magento: ' + msg;
            Log(msg,ltError);
            if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
            exit;
          end
          else begin
            qryXRef.Edit;
            qryXRef.FieldByName('ProcessTime').AsDateTime := now;
            qryXRef.FieldByName('Processed').AsBoolean := true;
            qryXRef.Post;
          end;
        finally
          newStock.Free;
        end;

      except
        on e: exception do begin
          if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Rollback;
          msg := 'Error sending product stock quantity to Magento: ' + e.Message;
          Log(msg, ltError);
          exit;
        end;
      end;
    finally
      if AppEnv.AppDb.TransConnection.InTransaction then AppEnv.AppDb.TransConnection.Commit;
    end;

  finally
    DbSharedObj.ReleaseObj(qryXRef);
    DbSharedObj.ReleaseObj(qry);
  end;
end;

end.
