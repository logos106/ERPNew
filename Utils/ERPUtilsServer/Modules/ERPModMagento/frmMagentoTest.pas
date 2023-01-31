unit frmMagentoTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LogThreadLib, MagentoObj;

type
  TfmMagentoTest = class(TForm)
    memLog: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btnGetTest: TButton;
    btnGetSalesOrder: TButton;
    btnGetSOList: TButton;
    btnPaymentMethods: TButton;
    btnGetProduct: TButton;
    btAttributeSets: TButton;
    btnEntityType: TButton;
    btnGetImage: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnGetTestClick(Sender: TObject);
    procedure btnGetSalesOrderClick(Sender: TObject);
    procedure btnGetSOListClick(Sender: TObject);
    procedure btnPaymentMethodsClick(Sender: TObject);
    procedure btnGetProductClick(Sender: TObject);
    procedure btAttributeSetsClick(Sender: TObject);
    procedure btnEntityTypeClick(Sender: TObject);
    procedure btnGetImageClick(Sender: TObject);
  private
    Logger: TLogger;
    Magento: TMagento;
    procedure Log(const Msg: string);
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
  public
    { Public declarations }
  end;

var
  fmMagentoTest: TfmMagentoTest;

implementation

uses
  {magento_v2_soap} mage_v2_soap, JsonToObject, JsonObject, JsonObjectUtils, IdHttp,
  MageDataFilter;

{$R *.dfm}

procedure TfmMagentoTest.btAttributeSetsClick(Sender: TObject);
var
  msg: string;
  json: TJsonObject;
begin
  json := JO;
  try
    if Magento.GetData(json,msg,'eav_entity_attribute_set',0,nil) then begin
      Log(json.AsString);
    end
    else begin
      Log('Error: ' + msg);
      exit;
    end;

  finally
    json.Free;
  end;

end;

procedure TfmMagentoTest.btnEntityTypeClick(Sender: TObject);
var
  msg: string;
  json: TJsonObject;
begin
  json := JO;
  try
    if Magento.GetData(json,msg,'eav_entity_type',0,nil) then begin
      Log(json.AsString);
    end
    else begin
      Log('Error: ' + msg);
      exit;
    end;

  finally
    json.Free;
  end;
end;

procedure TfmMagentoTest.btnGetImageClick(Sender: TObject);
var
  msg: string;
  json: TJsonObject;
  api: Mage_Api_Model_Server_V2_HandlerPortType;
  fSessionId: string;
begin
//  json := JO;
//  try
//    if Magento.GetData(json,msg,'catalog_image',0,nil) then begin
//      Log(json.AsString);
//    end
//    else begin
//      Log('Error: ' + msg);
//      exit;
//    end;
//
//  finally
//    json.Free;
//  end;
  api := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://192.168.1.200/magento/api/v2_soap');
  fSessionId := api.login('Ian', '1Rooster');
//  api.catalog
end;

procedure TfmMagentoTest.btnGetProductClick(Sender: TObject);
var
  msg: string;
  json: TJsonObject;
  filter: TMageDataFilter;
  entity_id: integer;
begin
  entity_id := 0;
  json := JO;
  filter := TMageDataFilter.Create;
  try

    //filter.Equal('product_id',IntToStr(2));
    //filter.FormatOutput := false;
    filter.Fields.Add('product_id');
    if Magento.GetData(json,msg,'cataloginventory_stock_item',0) then begin
      Log(json.AsString);
    end
    else begin
      Log('Error: ' + msg);
      exit;
    end;

    Log(#13#10 + '--------------------------------------------------------------------------------');

    filter.Clear;
    filter.Equal('sku','Cube iwork 11');
//    filter.Fields.Add('*');
    if Magento.GetData(json,msg,'catalog_product',0,filter) then begin
      Log(json.AsString);
      entity_id := json.A['items'].Items[0].AsObject.ItemByName['entity_id'].Value.AsInteger;
    end
    else begin
      Log('Error: ' + msg);
      exit;
    end;

    Log(#13#10 + '--------------------------------------------------------------------------------');

    if Magento.GetData(json,msg,'catalog_product',entity_id) then begin
      Log(json.AsString);
    end
    else begin
      Log('Error: ' + msg);
      exit;
    end;

    Log(#13#10 + '--------------------------------------------------------------------------------');

    filter.Clear;
    filter.Equal('product_id',IntToStr(entity_id));
    //filter.FormatOutput := false;
    if Magento.GetData(json,msg,'cataloginventory_stock_item',0,filter) then begin
      Log(json.AsString);
    end
    else begin
      Log('Error: ' + msg);
      exit;
    end;

    Log(#13#10 + '--------------------------------------------------------------------------------');

    if Magento.GetData(json,msg,'catalog_product',6) then begin
      Log(json.AsString);
      //entity_id := json.A['items'].Items[0].AsObject.ItemByName['entity_id'].Value.AsInteger;
    end
    else begin
      Log('Error: ' + msg);
      exit;
    end;
  finally
    json.Free;
    filter.Free;
  end;
end;

procedure TfmMagentoTest.btnGetSalesOrderClick(Sender: TObject);
var
//  stream: TStringStream;
  msg: string;
  json, o: TJsonObject;
  filter: TMageDataFilter;
begin
//  stream := TStringStream.Create;
  json := JO;
  filter := TMageDataFilter.Create;
  try
//    filter.Fields.Add('*');
//    if Magento.GetData(stream,msg,1,'catalog_product',0,filter) then begin
//    filter.Fields.Add('*');
    if Magento.GetData(json,msg,'sales_order',2) then begin
//      stream.Position := 0;
      //Log('Result:');
      //Log(stream.DataString);
      try
//        json.ReadFromStream(stream);
        Log(json.AsString);
      except
//        stream.Position := 0;
//        Log(stream.DataString);
      end;
    end
    else begin
      Log('Error: ' + msg);
    end;
//    stream.Clear;
    filter.Clear;
    o := JO('{"field":"order_id","filter":{"eq":16}}');
    o.FormatOutput := false;
    filter.A['filters'].Add(o);
    if Magento.GetData(json,msg,'sales_order_item',0,filter) then begin
//      stream.Position := 0;
      //Log('Result:');
      //Log(stream.DataString);
      try
//        json.ReadFromStream(stream);
        Log(json.AsString);
      except
//        stream.Position := 0;
//        Log(stream.DataString);
      end;
    end
    else begin
      Log('Error: ' + msg);
    end;


  finally
    json.Free;
//    stream.Free;
  end;
end;

procedure TfmMagentoTest.btnGetSOListClick(Sender: TObject);
var
  msg: string;
  json, o: TJsonObject;
  filter: TMageDataFilter;
begin
  json := JO;
  filter := TMageDataFilter.Create;
  try
    filter.Fields.Add('entity_id');
    filter.Fields.Add('state');
    filter.Fields.Add('status');
    if Magento.GetData(json,msg,'sales_order',0,filter) then begin
      Log(Json.AsString)
    end
    else
      Log(msg);
  finally
    json.Free;
    filter.Free;
  end;
end;

procedure TfmMagentoTest.btnGetTestClick(Sender: TObject);
var
//  stream: TStringStream;
  msg: string;
  json: TJsonObject;
  filter: TMageDataFilter;
begin
//  stream := TStringStream.Create;
  json := JO;
  filter := TMageDataFilter.Create;
  try
//    filter.Fields.Add('*');
//    if Magento.GetData(stream,msg,1,'catalog_product',0,filter) then begin
//    filter.Fields.Add('*');
    if Magento.GetData(json,msg,'core_store') then begin
//      stream.Position := 0;
      //Log('Result:');
      //Log(stream.DataString);
      try
//        json.ReadFromStream(stream);
        Log(json.AsString);
      except
//        stream.Position := 0;
//        Log(stream.DataString);
      end;


    end
    else begin
      Log('Error: ' + msg);

    end;


  finally
    json.Free;
//    stream.Free;
  end;
end;

(*
$myfile = fopen("output.xml", "w");
fwrite($myfile, $xmlString);
fclose($myfile);
*)

procedure TfmMagentoTest.Button1Click(Sender: TObject);
var
  Magento: Mage_Api_Model_Server_V2_HandlerPortType;
  me: magentoInfoEntity;
  prodList: catalogProductEntityArray;
  sesId: string;
  x: integer;
  dt: TDateTime;
  sl: storeEntityArray;
  imageList: catalogProductImageEntityArray;
  cpie: catalogProductImageEntity;
  cpe: catalogProductReturnEntity;
  s: string;
  json: TJsonObject;
  fileName: string;
begin
  try
//    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://192.168.1.200/magento/api/v2_soap');
//    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://sample.trueerp.com/api/v2_soap');
//    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://jenny.erpeu.com/magento/api/v2_soap/');
//    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://101.0.116.100/magento/api/v2_soap/');
//    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://dev.trueerp.com/api/v2_soap/');
//    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://192.168.1.201/index.php/api/v2_soap/');
    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://101.0.121.140/index.php/api/v2_soap/');



    //    Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://192.168.1.200/magento/api/v2_soap/?wsdl=1');
  //  Magento := GetMage_Api_Model_Server_V2_HandlerPortType(false, 'http://192.168.1.200/magento/api/?wsdl');
  //  sesId := Magento.login('admin','1Rooster');
//    sesId := Magento.login('apiuser','1Rooster');
//    sesId := Magento.login('apiuser','password1');
//    sesId := Magento.login('apiuser','password1');
    sesId := Magento.login('apiuser','u4mrCV5k');
    try
      Log('Session ID: ' + sesId);
      json:= JO;
      try
        me := Magento.magentoInfo(sesId);
        Log('Magento Version: ' + me.magento_version);
        Log('Magento Edition: ' + me.magento_edition);
        sl := Magento.storeList(sesId);
        for x := Low(sl) to High(sl) do begin
          ObjToJson(sl[x],json);
          Log(sl[x].ClassName + #13#10 + JsonToStrFormat(json));

//          Log('store_id: ' + IntToStr(sl[x].store_id) + '   code: ' +sl[x].code + '   website_id: ' + IntToStr(sl[x].website_id) +
//          '   group_id: ' + IntToStr(sl[x].group_id)  + '   name_: ' + sl[x].name_  + '   sort_order: ' +  IntToStr(sl[x].sort_order) + '   is_active: ' +  IntToStr(sl[x].is_active));
        end;
        exit;
        imageList := Magento.catalogProductAttributeMediaList(sesId,'6','','');
        for x := Low(imageList) to High(imageList) do begin
          Log('--------------------- Image ' + IntToStr(x+1) + ' -----------------------------------');
          ObjToJson(imageList[x],json);
          Log(imageList[x].ClassName + #13#10 + JsonToStrFormat(json));
          fileName := imageList[x].file_;
          //Log('file_: ' + imageList[x].file_);
          //Log('label_: ' + imageList[x].label_ );
          //Log('position_: ' + imageList[x].position);
          //Log('exclude: ' + imageList[x].exclude);
  //        Log('file_: ' + imageList[x].file_);

        end;
//        cpie :=  Magento.catalogProductAttributeMediaInfo(sesId, '6', fileName, '', '');
//        ObjToJson(cpie,json);
//        Log(cpie.ClassName + #13#10 + JsonToStrFormat(json));

        cpe := Magento.catalogProductInfo(SesId,'6','',nil,'');
        Log('');
//        Log('sku: ' + cpe.sku);
//        Log('set_: ' + cpe.set_);
//        Log('type_: ' + cpe.type_);
//        s:= '';
//        for x := Low(cpe.categories) to High(cpe.categories) do
//          s:= s + cpe.categories[x] + ',';
//        Log('categories: ' + s);
//        s:= '';
//        for x := Low(cpe.websites) to High(cpe.websites) do
//          s:= s + cpe.websites[x] + ',';
//        Log('websites: ' + s);
//        Log('created_at: ' + cpe.created_at);
//        Log('updated_at: ' + cpe.updated_at );
//        Log('type_id: ' + cpe.type_id );
//        Log('name_: ' + cpe.name_ );
//        Log('description: ' + cpe.description );
//        Log('short_description: ' + cpe.short_description );
//        Log('weigth: ' + cpe.weight );
//        Log('status: ' + cpe.status );
//        Log('url_key: ' + cpe.url_key );
//        Log('url_path: ' + cpe.url_path );
//        Log('visability: ' + cpe.visibility );

        ObjToJson(cpe,json);
        Log(cpe.ClassName + #13#10 + JsonToStrFormat(json));

      finally
        cpe.Free;
        json.Free;
      end;

//      dt:= now;
//      prodList := Magento.catalogProductList(sesId,nil,'');
//      memLog.Lines.Add('Products found: ' + IntToStr(Length(prodLIst)) + ' Time: ' + FormatDateTime('hh:nn.zzz',now-dt));
//      for x := Low(prodList) to High(prodList) do begin
//        memLog.Lines.Add(prodList[x].name_);
//      end;
    finally
      Magento.endSession(sesId);
      //prodList.Free;
      Magento := nil;
    end;
  except
    on e: exception do begin
      memLog.Lines.Add(e.ClassName);
      memLog.Lines.Add(e.Message);
    end;
  end;
end;

procedure TfmMagentoTest.Button2Click(Sender: TObject);
var
  msg: string;
begin
  Log('========== Starting Synch ==========');
//  Magento.SynchAttributeSets(msg);
//  Magento.SynchProductsToStore(msg);
  Log('========== Synch Finished ==========');
end;


(*
 // magento delete example
$id = 3;
$model = Mage::getModel('mynews/mynews');
try {
		$model->setId($id)->delete();
		echo "Data deleted successfully.";

	} catch (Exception $e){
		echo $e->getMessage();
}

*)

procedure TfmMagentoTest.Button3Click(Sender: TObject);
var
  http: TIdHttp;
  stream: TStringStream;
  s: string;
begin
  http := TIdHttp.Create(nil);
  stream := TStringStream.Create;
  try
    http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    stream.WriteString('data={"class_name":"Taxable Goods xxx","class_type":"PRODUCT"}');
    stream.Position := 0;
    http.Request.ContentType := 'application/x-www-form-urlencoded';
    //s:= http.Post('http://192.99.179.64/magento/test.php/somthingelse/1',stream);
    //http://192.168.1.200/magento
    Log('tax_class List..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_class');
    Log(s);
    Log('tax_class Item..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_class/2');
    Log(s);
    Log('tax_calculation List..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation');
    Log(s);
    Log('tax_calculation Item..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation/145');
    Log(s);
    Log('tax_calculation_rate List..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation_rate');
    Log(s);
    Log('tax_calculation_rate Item..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation_rate/7');
    Log(s);

    Log('tax_calculation_rate_title List..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation_rate_title');
    Log(s);
    Log('tax_calculation_rate_title Item..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation_rate_title/7');
    Log(s);

    Log('tax_calculation_rule List..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation_rule');
    Log(s);
    Log('tax_calculation_rule Item..');
    s:= http.Get('http://192.168.1.200/magento/erpapi.php/1/tax_calculation_rule/4');
    Log(s);

//    s:= http.Post('http://192.99.179.64/magento/erpapi.php/1/tax_class',stream);
//    Log(s);

  finally
    http.Free;
    stream.Free;
  end;

end;

procedure TfmMagentoTest.btnPaymentMethodsClick(Sender: TObject);
var
  json, o: TJsonObject;
//  filter: TMageDataFilter;
  msg: string;
begin
  json := JO;
//  filter := TMageDataFilter.Create;
  try
//    filter.Fields.Add('entity_id');
//    filter.Fields.Add('state');
//    filter.Fields.Add('status');
    if Magento.GetData(json,msg,'payment_config',0,nil) then begin
      Log(Json.AsString)
    end
    else
      Log(msg);
  finally
    json.Free;
//    filter.Free;
  end;
end;

procedure TfmMagentoTest.DoLogEvent(Sender: TObject; const Event,
  Value: string);
begin
  memLog.Lines.Add(Value);
end;

procedure TfmMagentoTest.FormCreate(Sender: TObject);
begin
  Logger := TLogger.Inst;
  Logger.LogAllTypes;
  Logger.Events.AddMultiEvent(DoLogEvent);
  Magento := TMagento.Create;
//  Magento.Config.StoreURL := 'http://192.99.179.64/magento/';
//  Magento.Config.StoreId := '1';
//  Magento.Config.MagentoUserName := 'admin';
//  Magento.Config.MagentoKey := 'pHWnPQxz2gZ44Pc';
//  Magento.Config.ERPDatabase := 'my_shop';
//  Magento.OnLogEvent := Logger.Log;
  Magento.StoreId := 1;
  Magento.StoreURL := 'http://101.0.121.140/';
end;

procedure TfmMagentoTest.FormDestroy(Sender: TObject);
begin
  Magento.Free;
end;

procedure TfmMagentoTest.Log(const Msg: string);
begin
  Logger.Log(Msg);
//  memLog.Lines.Add(Msg);
end;

end.
