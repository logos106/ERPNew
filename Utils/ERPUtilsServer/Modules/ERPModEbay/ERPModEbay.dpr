program ERPModEbay;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ModEBay in 'ModEBay.pas',
  ServerModuleObj in '..\..\..\..\Common\ServerModules\ServerModuleObj.pas',
  ModuleComms3 in '..\..\..\..\Common\ModuleComms3.pas',
  ThreadProperty in '..\..\..\..\Common\ThreadProperty.pas',
  ServerModuleConst in '..\..\..\..\Common\ServerModules\ServerModuleConst.pas',
  ServerModuleThreadTask in '..\..\..\..\Common\ServerModules\ServerModuleThreadTask.pas',
  ModuleFileNameUtils in '..\..\..\..\Common\ModuleFileNameUtils.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  IntegerListObj in '..\..\..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  SystemLib in '..\..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  JsonRPCUtils in '..\..\JsonRPC\JsonRPCUtils.pas',
  NotificationItem in '..\NotificationItem.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  ConsoleLogObj in '..\..\..\..\Common\ConsoleLogObj.pas',
  eBayObj in '..\..\..\..\Dev\eBayIntegration\Modules\eBayObj.pas',
  ebaysvc in '..\..\..\..\Dev\eBayIntegration\Modules\ebaysvc.pas',
  eBayLib in '..\..\..\..\Dev\eBayIntegration\Modules\eBayLib.pas',
  eBay_orderresponse in '..\ebayIntegration\objects\eBay_orderresponse.pas',
  eBayBaseObj in '..\ebayIntegration\eBayBaseObj.pas',
  eBayConfig in '..\ebayIntegration\eBayConfig.pas',
  ebay_orderresponse_ordererrors in '..\ebayIntegration\objects\ebay_orderresponse_ordererrors.pas',
  eBay_orderresponse_PaginationResult in '..\ebayIntegration\objects\eBay_orderresponse_PaginationResult.pas',
  eBay_Orders in '..\ebayIntegration\objects\eBay_Orders.pas',
  eBay_Orders_CheckoutStatus in '..\ebayIntegration\objects\eBay_Orders_CheckoutStatus.pas',
  eBay_Orders_ShippingDetails in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails.pas',
  eBay_Orders_ShippingDetails_exsShipTo in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_exsShipTo.pas',
  eBay_Orders_ShippingDetails_intShipServc in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_intShipServc.pas',
  eBay_Orders_ShippingDetails_intShipServc_shiptoLoc in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_intShipServc_shiptoLoc.pas',
  eBay_Orders_ShippingDetails_SalesTax in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_SalesTax.pas',
  eBay_Orders_ShippingDetails_ShipupTrack in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_ShipupTrack.pas',
  eBay_Orders_ShippingDetails_ShipupTrack_Shipline in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_ShipupTrack_Shipline.pas',
  eBay_Orders_ShippingDetails_ShipServ in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_ShipServ.pas',
  eBay_Orders_ShippingDetails_Taxable in '..\ebayIntegration\objects\eBay_Orders_ShippingDetails_Taxable.pas',
  eBay_Orders_Paymethods in '..\ebayIntegration\objects\eBay_Orders_Paymethods.pas',
  eBay_Orders_ShippingAddress in '..\ebayIntegration\objects\eBay_Orders_ShippingAddress.pas',
  eBay_Orders_ShipServiceSel in '..\ebayIntegration\objects\eBay_Orders_ShipServiceSel.pas',
  eBay_Orders_ShipServiceSel_Cost in '..\ebayIntegration\objects\eBay_Orders_ShipServiceSel_Cost.pas',
  eBay_Orders_ExternalTransaction in '..\ebayIntegration\objects\eBay_Orders_ExternalTransaction.pas',
  eBay_Orders_Trans in '..\ebayIntegration\objects\eBay_Orders_Trans.pas',
  eBay_Orders_Trans_Buyer in '..\ebayIntegration\objects\eBay_Orders_Trans_Buyer.pas',
  eBay_Orders_Trans_Buyer_Sellinfo in '..\ebayIntegration\objects\eBay_Orders_Trans_Buyer_Sellinfo.pas',
  eBay_Orders_Trans_item in '..\ebayIntegration\objects\eBay_Orders_Trans_item.pas',
  eBay_Orders_Trans_item_Skypecontact in '..\ebayIntegration\objects\eBay_Orders_Trans_item_Skypecontact.pas',
  eBay_Orders_Trans_item_AttribSet in '..\ebayIntegration\objects\eBay_Orders_Trans_item_AttribSet.pas',
  eBay_Orders_Trans_item_GiftService in '..\ebayIntegration\objects\eBay_Orders_Trans_item_GiftService.pas',
  eBay_Orders_Trans_item_listingEnhanceMent in '..\ebayIntegration\objects\eBay_Orders_Trans_item_listingEnhanceMent.pas',
  eBay_Orders_Trans_item_PaymentallowdSite in '..\ebayIntegration\objects\eBay_Orders_Trans_item_PaymentallowdSite.pas',
  eBay_Orders_Trans_item_ShipToLocations in '..\ebayIntegration\objects\eBay_Orders_Trans_item_ShipToLocations.pas',
  eBay_Orders_Trans_item_ItemSpecifics in '..\ebayIntegration\objects\eBay_Orders_Trans_item_ItemSpecifics.pas',
  eBay_Orders_Trans_item_CrossBt in '..\ebayIntegration\objects\eBay_Orders_Trans_item_CrossBt.pas',
  eBay_Orders_Trans_item_AttribArr in '..\ebayIntegration\objects\eBay_Orders_Trans_item_AttribArr.pas',
  ebay_orders_trans_taxes in '..\ebayIntegration\objects\ebay_orders_trans_taxes.pas',
  ebay_orders_trans_taxes_taxdetails in '..\ebayIntegration\objects\ebay_orders_trans_taxes_taxdetails.pas',
  eBaysvcLib in '..\..\..\..\Dev\eBayIntegration\Modules\eBaysvcLib.pas',
  ConfigDbObj in '..\..\..\..\Common\ConfigDbObj.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  WebApiClientObj in '..\..\..\..\Common\WebApiClientObj.pas',
  WebApiConst in '..\..\..\..\Common\WebApiConst.pas',
  ModulePortObj in '..\..\..\..\Common\ModulePortObj.pas',
  DBUtils in '..\..\..\..\Common\DBUtils.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  DbGen in '..\..\..\..\Common\DbGen.pas',
  FileVersion in '..\..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  HTTPConst in '..\..\..\..\Common\HTTPConst.pas',
  ConfigReader in '..\..\..\..\Common\ConfigReader.pas',
  SimpleEncrypt in '..\..\..\..\Common\SimpleEncrypt.pas',
  AppEnvironmentVirtual in '..\UserUtils\AppEnvironmentVirtual.pas',
  AppEnvVirtualObj in '..\..\..\..\Common\AppEnvVirtualObj.pas',
  ProgressInfoObj in '..\..\..\..\Common\ProgressInfoObj.pas',
  MachineSignature in '..\UserUtils\MachineSignature.pas',
  ModuleConst in '..\ModuleConst.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  DateTimeUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  DateTimeConvert in '..\..\..\..\Common\DateTimeConvert.pas',
  utDbServerThreadTaskList in '..\..\..\..\Common\utDbServerThreadTaskList.pas';

var
  ServerModule: TModEbay;
  ConsoleLogger: TConsoleLogger;

{$R *.res}

begin
  ServerModule := TModEbay.Create;
  ConsoleLogger := TConsoleLogger.Create(ServerModule);
  try
    ServerModule.Execute;
  finally
    ServerModule.Free;
    ConsoleLogger.Free;
  end;

end.

