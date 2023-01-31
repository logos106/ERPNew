unit frmDataUpdator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, Shader, DNMPanel,BaseListingForm,
  DNMSpeedButton, wwcheckbox, wwdbdatetimepicker, wwdblook, Buttons, Wwdbigrd,
  Grids, Wwdbgrid,BusObjBase,busobjStock,busobjDataupdator , frmDU_base,
  frmDU_ExtraSellPrice, frmDU_SpecialProducts, frmDU_ExtraBuyPrice,frmDU_ExtraForeignBuyPrice,
  frmDU_ExtraForeignSellPrice ,frmDU_Product , frmDU_DeleteExtraSellPrice, frmDU_DeleteExtraBuyPrice,
  ComCtrls, frmDU_Client, BusObjClient , BusObjContact, DU_UOMMismatch, BusObjProcResource ,frmDU_ProcResource , frmDU_MiscDataUpdates , frmDU_CustomerSpecialPrice;

type
  TfmDataUpdator = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryExtraBuyPrice: TERPQuery;
    qryExtraBuyPriceExtraPartPriceID: TAutoIncField;
    qryExtraBuyPricePartsID: TIntegerField;
    qryExtraBuyPriceSupplierID: TIntegerField;
    qryExtraBuyPricePrice: TFloatField;
    qryExtraBuyPricePartName: TWideStringField;
    qryExtraBuyPriceBuy1: TIntegerField;
    qryExtraBuyPriceSupplierProductCode: TWideStringField;
    qryExtraBuyPriceSupplierProductName: TWideStringField;
    qryExtraBuyPriceUsePrice: TWideStringField;
    qryExtraBuyPriceSupplierName: TWideStringField;
    qryExtraBuyPricePrintedValue: TFloatField;
    qryExtraBuyPriceUOM: TWideStringField;
    qryExtraBuyPriceUOMID: TIntegerField;
    qryExtraBuyPriceUOMMultiplier: TFloatField;
    qryExtraBuyPriceMinimumOrderQty: TFloatField;
    QryExtraFxBuyPrice: TERPQuery;
    QryExtraFxBuyPriceForeignPriceID: TAutoIncField;
    QryExtraFxBuyPricePartsID: TIntegerField;
    QryExtraFxBuyPricePartName: TWideStringField;
    QryExtraFxBuyPriceBuy1: TIntegerField;
    QryExtraFxBuyPricePrice1: TFloatField;
    QryExtraFxBuyPriceSupplierProductCode: TWideStringField;
    QryExtraFxBuyPriceSupplierProductName: TWideStringField;
    QryExtraFxBuyPriceSupplierName: TWideStringField;
    QryExtraFxBuyPriceIsSellPrice: TWideStringField;
    QryExtraFxBuyPriceClientID: TIntegerField;
    QryExtraFxBuyPriceCurrencyId: TIntegerField;
    QryExtraFxBuyPriceCurrencyCode: TWideStringField;
    QryExtraFxBuyPriceUOM: TWideStringField;
    QryExtraFxBuyPriceUOMID: TIntegerField;
    QryExtraFxBuyPriceUOMMultiplier: TFloatField;
    qryExtraSellPrice: TERPQuery;
    qryExtraSellPricePriceID: TAutoIncField;
    qryExtraSellPriceClientTypeID: TIntegerField;
    qryExtraSellPricePartsID: TIntegerField;
    qryExtraSellPriceQtyPercent1: TFloatField;
    qryExtraSellPriceClientTypeName: TWideStringField;
    qryExtraSellPriceAllClients: TWideStringField;
    qryExtraSellPriceDateTo: TDateField;
    qryExtraSellPriceDateFrom: TDateField;
    qryExtraSellPriceTerms: TWideStringField;
    qryExtraSellPricePrice1: TFloatField;
    qryExtraSellPriceUOM: TWideStringField;
    qryExtraSellPriceUOMID: TIntegerField;
    qryExtraSellPriceUOMMultiplier: TFloatField;
    qryExtraFxSellPrice: TERPQuery;
    qryExtraFxSellPriceCode: TWideStringField;
    qryExtraFxSellPriceUOM: TWideStringField;
    qryExtraFxSellPricePrice1: TFloatField;
    qryExtraFxSellPriceForeignPriceId: TAutoIncField;
    qryExtraFxSellPricePartsId: TIntegerField;
    qryExtraFxSellPriceClientID: TIntegerField;
    qryExtraFxSellPricePartName: TWideStringField;
    qryExtraFxSellPriceBuy1: TIntegerField;
    qryExtraFxSellPriceSupplierProductCode: TWideStringField;
    qryExtraFxSellPriceSupplierProductName: TWideStringField;
    qryExtraFxSellPriceSupplierName: TWideStringField;
    qryExtraFxSellPriceIsSellPrice: TWideStringField;
    qryExtraFxSellPriceCurrencyId: TIntegerField;
    qryExtraFxSellPriceUOMID: TIntegerField;
    qryExtraFxSellPriceUOMMultiplier: TFloatField;
    qryExtraSellPriceVariationOption: TWideStringField;
    qryExtraSellPriceVariationtype: TWideStringField;
    qryExtraSellPriceVariationAmt: TFloatField;
    qryExtraFxSellPriceVariationOption: TWideStringField;
    qryExtraFxSellPriceVariationtype: TWideStringField;
    qryExtraFxSellPriceVariationAmt: TFloatField;
    qryExtraBuyPriceVariationOption: TWideStringField;
    qryExtraBuyPriceVariationtype: TWideStringField;
    qryExtraBuyPriceVariationAmt: TFloatField;
    QryExtraFxBuyPriceVariationOption: TWideStringField;
    QryExtraFxBuyPriceVariationtype: TWideStringField;
    QryExtraFxBuyPriceVariationAmt: TFloatField;
    qryExtraSellPriceDeleted: TWideStringField;
    qryExtraFxSellPriceDeleted: TWideStringField;
    qryExtraBuyPriceDeleted: TWideStringField;
    QryExtraFxBuyPriceDeleted: TWideStringField;
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    qryClientTypes: TERPQuery;
    qrySellCurrencyLookup: TERPQuery;
    qryBuyCurrencyLookup: TERPQuery;
    QryUpdateErrLog: TERPQuery;
    QryUpdateErrLogID: TIntegerField;
    QryUpdateErrLogErrObjType: TWideStringField;
    QryUpdateErrLogErrObjname: TWideStringField;
    QryUpdateErrLogErrDescription: TWideStringField;
    qryExtraSellPriceToDelete: TERPQuery;
    qryExtraSellPriceToDeletePARTNAME: TWideStringField;
    qryExtraSellPriceToDeleteTypeName: TWideStringField;
    qryExtraSellPriceToDeleteAllClients: TWideStringField;
    qryExtraSellPriceToDeleteDateFrom: TDateField;
    qryExtraSellPriceToDeleteDateTo: TDateField;
    qryExtraSellPriceToDeleteUOM: TWideStringField;
    qryExtraSellPriceToDeleteQtyPercent1: TFloatField;
    qryExtraSellPriceToDeletepartsID: TIntegerField;
    qryExtraSellPriceToDeletePriceID: TIntegerField;
    PnlDataUpdator: TDNMPanel;
    pnlbottom: TDNMPanel;
    lblViewUpdateLog: TLabel;
    btnClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    PageMain: TPageControl;
    TabSheet1: TTabSheet;
    ProductSpliter: TSplitter;
    pnlProduct: TDNMPanel;
    pnldetails: TDNMPanel;
    pnlProductMain: TDNMPanel;
    sbButtons: TScrollBox;
    pnlProductButtons: TDNMPanel;
    TabSheet2: TTabSheet;
    pnlclient: TDNMPanel;
    ClientFilter: TSplitter;
    DNMPanel1: TDNMPanel;
    pnlClientMain: TDNMPanel;
    scrClientButtons: TScrollBox;
    pnlClientButtons: TDNMPanel;
    qryExtraSellPriceExtraSellDesc: TWideStringField;
    QryProduct: TERPQuery;
    qrypartbarcodes: TERPQuery;
    qryProductBarcodeList: TERPQuery;
    qryReorder: TERPQuery;
    TabSheet3: TTabSheet;
    DNMPanel2: TDNMPanel;

    tabMiscDataUpdates: TTabSheet;
    pnlMiscDataupdate: TDNMPanel;
    pnlMiscDataupdateMain: TDNMPanel;
    splMiscDataupdate: TSplitter;
    scrMiscDataupdateButtons: TScrollBox;
    pnlMiscDataupdateButtons: TDNMPanel;

    pnlProcResMain: TDNMPanel;
    scrProcResButtons: TScrollBox;
    pnlProcResButtons: TDNMPanel;
    splProcResButtons: TSplitter;
    pnlProcRes: TDNMPanel;
    QrySpecialProducts: TERPQuery;
    QrySpecialProductsGlobalRef: TWideStringField;
    QrySpecialProductsCustomerLinesID: TIntegerField;
    QrySpecialProductsCustomerId: TIntegerField;
    QrySpecialProductsProductID: TIntegerField;
    QrySpecialProductsName: TWideStringField;
    QrySpecialProductsDescription: TWideStringField;
    QrySpecialProductsOrigPrice: TFloatField;
    QrySpecialProductsLinePrice: TFloatField;
    QrySpecialProductsEditedFlag: TWideStringField;
    QrySpecialProductsIncludeInRun: TWideStringField;
    QrySpecialProductsDateFrom: TDateField;
    QrySpecialProductsDateTo: TDateField;
    QrySpecialProductsmsTimeStamp: TDateTimeField;
    QrySpecialProductsmsUpdateSiteCode: TWideStringField;
    QrySpecialProductsUOM: TWideStringField;
    QrySpecialProductsUOMID: TIntegerField;
    QrySpecialProductsUOMMultiplier: TFloatField;
    QrySpecialProductsdeleted: TWideStringField;
    QrySpecialProductsVariationOption: TWideStringField;
    QrySpecialProductsVariationtype: TWideStringField;
    QrySpecialProductsVariationAmt: TFloatField;


    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProductSpliterMoved(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure lblViewUpdateLogClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PageMainResize(Sender: TObject);
    procedure btnAdjQtyClick(Sender: TObject);
    procedure btnAdjUOMClick(Sender: TObject);
    procedure btnUOMlistClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PageMainChange(Sender: TObject);
  private

    frmUOMMismatchlist  : TBaselistingGUI;
    frmExtraSellPrice   : TfmDU_ExtraSellPrice;
    frmSpecialProducts   : TfmDU_SpecialProducts;
    frmDeleteExtraSellPrice:TfmDU_DeleteExtraSellPrice;
    frmDeleteExtraBuyPrice: TfmDU_DeleteExtraBuyPrice;
    frmExtraFxSellPrice : TfmDU_ExtraforeignSellPrice;
    frmExtraBuyPrice    : TfmDU_ExtraBuyPrice;
    frmExtraFxBuyPrice  : TfmDU_ExtraForeignBuyPrice;

    ExtraSellPrice    : TDataupdatorExtraSellPrice;
    SpecialProducts    : TDataupdatorSpecialProducts;
	  ExtraFxSellPrice  : TDataUpdatorForeignSellPrice;
    ExtraBuyPrice     : TDataUpdatorExtraBuyPrice;
	  ExtraFxBuyPrice   : TDataUpdatorForeignBuyPrice;

    updateoption :Word;
    Idsdone:String;
    SLErrorlog:TStringlist;
    fsErrLogTablename:string;
    fdcost, fdPrice , fdspecialPrice:double;
    fDataConnection :TMyDacDataConnection;


    fsSizemode:String;
    {Product Vars}
    frmproductList      : TBaselistingGUI;
    frmProductProperties: TfmDU_Product;
    fiProductPageIndex  : Integer;
    fProducts       : TProduct;
    fsProductsinList: String;
    fsProductsSelectedInList: String;
    fbProductsleectionChanged :Boolean;
    Productfrm : TfmDU_base;
    ProductButtons :Array [1..11] of TDNMspeedbutton;

    {client Vars}
    frmClientList       : TBaselistingGUI;
    frmclientProperties : TfmDU_Client;
    frmCustomerSpecialPrices : TfmDU_CustomerSpecialPrice;
    fiClientPageIndex  : Integer;
    fClientContacts : TContact;
    fClients        : Tclient;
    fCustomers      : TCustomer;
    fsClientsinList : String;
    fsCustomersinList : String;
    fsClientcontactsinList  : String;
    fsClientsSelectedInList : String;
    fsClientcontactsSelectedInList : String;
    fsCustomersSelectedInList : String;
    fbclientSelectionChanged :Boolean;
    Clientfrm : TfmDU_base;
    ClientButtons :Array [1..1] of TDNMspeedbutton;
    {Data update Vars}
    MiscDataUpdateButtons :Array [1..1] of TDNMspeedbutton;
    frmMiscDataUpdate : TfmDU_MiscDataUpdates;
    MiscDataUpdatefrm : TfmDU_base;
    fiMiscDataUpdatePageIndex  : Integer;

    {Proc Resource Vars}
    frmProcResList      : TBaselistingGUI;
    frmProcResProperties: TfmDU_ProcResource;
    fiProcResPageIndex  : Integer;
    fProcResources  : TProcResource;
    fsProcResourcesinList   : String;
    ProcResfrm : TfmDU_base;
    ProcResButtons :Array [1..1] of TDNMspeedbutton;
    fbProcResSelectionChanged :Boolean;



    procedure OpenProductList;
    procedure OpenClientList;
    Procedure OpenUOMMismatchlist;
    procedure ProductMainbtnclick(Sender: TObject);
    procedure ClientMainbtnclick(Sender: TObject);
    function ExtraSellPriceform: TfmDU_ExtraSellPrice;
    function SpecialProductsform: TfmDU_SpecialProducts;
    Function DeleteExtraSellPriceform : TfmDU_DeleteExtraSellPrice;
    function DeleteExtraBuyPriceForm : TfmDU_DeleteExtraBuyPrice;
    function ExtraForeingSellPriceform: TfmDU_ExtraforeignSellPrice;
    function ExtraBuyPriceform: TfmDU_ExtraBuyPrice;
    function ExtraForeinBuyPriceform: TfmDU_ExtraForeignBuyPrice;
    function ProductPropertiesform : TfmDU_Product;
    Function clientPropertiesForm : TfmDU_Client;
    Function CustomerSpecialPriceForm : TfmDU_CustomerSpecialPrice;
    procedure setProductPageIndex(const Value: Integer);
    procedure setClientPageIndex(const Value: Integer);
    Procedure Readguiprefs;
    Procedure Writeguiprefs;
    function getProductSplitAt: Integer;
    function getClientSplitAt: Integer;
    procedure setProductSplitAt(const Value: Integer);
    procedure setClientSplitAt(const Value: Integer);
    Procedure CheckProducts;
    Procedure CheckClientnContacts;
    function Products: TProduct;
    function Clients :Tclient;
    function Customers :TCustomer;
    function ClientContacts :TContact;
    Procedure DoUpdate;
    Procedure DoUpdateCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ApplyExtraSellPrice(Product :TProduct);
    Procedure ApplySpecialProducts(Product :TProduct);
    Procedure ApplyExtraSellPriceToDelete(Product :TProduct);
    Procedure ApplyExtraFxSellPrice(Product :TProduct);
    procedure ApplyExtraBuyPriceToDelete(Product :TProduct);
    Procedure ApplyExtraBuyPrice(Product :TProduct);
    Procedure ApplyExtraFxBuyPrice(Product :TProduct);
    Procedure ApplyProductProperties(Product :TProduct);
    Procedure ApplyClientProperties(Clientobj :Tclient);
    Procedure ApplyContactProperties(Cotnactobj :Tcontact);
    Procedure ApplyExtraSellPriceCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ApplySpecialProductListCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ApplyExtraFxSellPriceCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ApplyExtraBuyPriceCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ApplyExtraFxBuyPriceCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ApplySpecialProductsCallback(Const Sender: TBusObj; var Abort: boolean);


    procedure LogError(const ErrObjType, ErrObjname, ErrDescription: String);
    function CreateErrLogTable: String;
    Procedure SetProductsSelectedInList(Const Value:String);
    Procedure SetclientsSelectedInList(Const Value:String);
    Procedure SetUpdatehint;
    procedure ValidateSelection;
    procedure updateReorderpoints(const Sender: TBusObj; var Abort: boolean);
    Procedure ValuesToUpdateWith;
    procedure LinkProducts(grd: twwDBGrid; Product: TProduct);
    procedure CompletedProductUpdate;
    procedure CompletedclientUpdate;
    Procedure checkclientselection(Ids, SelectedIds, category:String);
    function DataConnection :TMyDacDataConnection;
    {$HINTS OFF}
    function ProductButtonforIndex(const Value :Integer) :TDNMSpeedButton;
    function ClientButtonforIndex(const Value :Integer) :TDNMSpeedButton;
    {$HINTS ON}
    procedure ValidateClientSelection;
    procedure ValidateProductSelection;
    Function formatMobileno(fsname :String; MobileNo:String;countryname:String; fConnection :TMyConnection; Category:String):String;
    procedure DoProductUpdate;
    procedure DoclientUpdate;
    function updatingcontact: Boolean;
    function updatingSpecialPriceList: Boolean;
    function MakingContact: Boolean;
    procedure OnclientMultiSelect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure OnProductMultiSelect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    function UseRegionCountry: Boolean;
    Procedure DoconfirmImport;
    function Percentage(btn : TDNMSpeedButton) : boolean;

    Function MiscDataUpdateForm : TfmDU_MiscDataUpdates;
    procedure setMiscDataUpdatePageIndex(const Value: Integer);
    Procedure DoMiscDataUpdate;
    procedure MiscDataUpdateMainbtnclick(Sender: TObject);
    function getMiscDataUpdateSplitAt: Integer;
    procedure setMiscDataUpdateSplitAt(const Value: Integer);

    procedure OpenProcResourceList;
    Procedure ProcResMainbtnclick(Sender: TObject);
    procedure setProcResPageIndex(const Value: Integer);
    Procedure CheckProcRes;
    Procedure ApplyProcResourceProperties(ProcResourceObj :TProcResource);
    procedure CompletedProcResUpdate;
    procedure DoProcresourceUpdate;
    Function ProcresPropertiesForm : TfmDU_ProcResource;
    Function ProcResources :TProcResource;
    function getProcResSplitAt: Integer;
    procedure setProcResSplitAt(const Value: Integer);
    procedure OnProcResMultiSelect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    Procedure ValidateProcResSelection;
    procedure REfreshallPages;


  protected
    procedure DoFormSize(ChangeSize:Boolean);Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure AfterFormShow; Override;
  public
    Function Productcount:Integer;
    Function Clientcount:Integer;
    Function ProcResourcecount:Integer;
    Property ProductPageIndex :Integer read fiProductPageIndex write setProductPageIndex;
    Property ClientPageIndex :Integer read fiClientPageIndex write setClientPageIndex;
    Property MiscDataUpdatePageIndex :Integer read fiMiscDataUpdatePageIndex write setMiscDataUpdatePageIndex;
    Property ProcResPageIndex :Integer read fiProcResPageIndex write setProcResPageIndex;
    Property ProductSplitAt :Integer read getProductSplitAt write setProductSplitAt;
    Property ClientSplitAt :Integer read getClientSplitAt write setClientSplitAt;
    Property MiscDataUpdateSplitAt :Integer read getMiscDataUpdateSplitAt write setMiscDataUpdateSplitAt;
    Property ProcResSplitAt :Integer read getProcResSplitAt write setProcResSplitAt;
    Procedure SelectProduct(const ProductID:Integer);
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses CommonFormLib, ButtonsLib, CommonLib , ProductListExpressForm, BusObjConst,
  CommonDbLib, tcConst, BusobjUOM, MySQLConst, BusobjProductProperties,
  frmMessageWithList, frmMessageBase , DNMLib, ClientList, SMSUtils, tcDataUtils,
  ClientcontactList, AppEnvironment, BusObjProductClass, DbSharedObjectsObj,
  BusObjProductBarcode, DateTimeUtils, frmProcResourceList, BusObjCommon,
  SpecialProducts;

const
  ProductButtonCaptions   : Array [1..11] of String = ('Extra Buy Price', 'Extra Sell Price' ,
     'Foreign buy Price', 'Foreign Sell Price' ,
     'Product Properties' ,'Delete Extra Sell Price',
     'Delete Extra Buy Price', 'Confirm Import',
     'Adjust UOM', 'UOM List', 'Adjust Qty' ) ;
  ProductButtonhint   : Array [1..11] of String = ('Extra Buy Price', 'Extra Sell Price' ,
     'Foreign buy Price', 'Foreign Sell Price' ,
     'Product Properties' ,'Delete Extra Sell Price',
     'Delete Extra Buy Price', 'Verifying ''Extra Sell Prices'' and ''Extra Buy Prices'' are Correct',
       'Adjust UOM', 'Show List of UOM', 'Adjust Quality' ) ;
  ProductButtonVisibility : Array  [1..11] of boolean = (True,true,true,true,true , true,True, true, true, true, true) ;

  cExtraBuyPrice          = 1;
  cExtraSellPrice         = 2;
  cExtraForeinBuyPrice    = 3;
  cExtraForeingSellPrice  = 4;
  cProductProperties      = 5;
  cExtraSellPricetoDelete = 6;
  cExtraBuyPriceToDelete  = 7;
  cConfirmImport          = 8;
  cAdjustUOM              = 9;
  cUOMList                = 10;
  cAdjustQty              = 11;


  clientButtonCaptions : Array [1..3] of String =('Client Properties','Customer Special Price' , 'Customer Special Price List');
  ClientButtonVisibility : Array  [1..2] of boolean = (True, True) ;
  ClientButtonhint   : Array [1..2] of String = ('Client Properties','Customer Special Price List') ;

  cClientProperties = 1;
  cSpecialProductList = 2;

  MiscDataUpdateButtonCaptions : Array [1..1] of String =('Misc');
  MiscDataUpdateButtonVisibility : Array  [1..1] of boolean = (True) ;
  MiscDataUpdateButtonhint   : Array [1..1] of String = ('Misc Data Fix Options' ) ;
  cMiscDataUpdateProperties = 1;

  ProcResButtonCaptions : Array [1..1] of String =('Update Hourly Rate');
  ProcResButtonVisibility: Array  [1..1] of boolean = (True) ;
  ProcResButtonhint  : Array [1..1] of String = ('Update Resource hourly Rate' ) ;
  cProcResProperties = 1;





{$R *.dfm}
function TfmDataUpdator.ClientButtonforIndex(const Value: Integer): TDNMSpeedButton;
begin
  REsult:= nil;
  try
    result := clientbuttons[Value];
  Except
  end;
end;

function TfmDataUpdator.Clientcount: Integer;
begin
  result:=0;
  if assigned(frmClientList) then
    result:= frmClientList.qryMain.RecordCount;
end;
function TfmDataUpdator.ProcResourcecount: Integer;
begin
  result:=0;
  if assigned(frmProcResList) then
    result:= frmProcResList.qryMain.RecordCount;
end;
procedure TfmDataUpdator.ClientMainbtnclick(Sender: TObject);
begin
  if not(Sender is TDNMSpeedButton) then exit;
  if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ClientButtonCaptions[cClientProperties]) then begin
    if ficlientPageIndex = cClientProperties then exit;// page not changed
    if clientfrm <> nil then clientfrm.pnlMain.Visible:= False;
    ficlientPageIndex := cclientProperties;
    clientfrm:= clientPropertiesform;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ClientButtonCaptions[cSpecialProductList]) then begin
    if ficlientPageIndex = cSpecialProductList then exit;// page not changed
    if clientfrm<> nil then clientfrm.pnlMain.Visible:= False;
    ficlientPageIndex := cSpecialProductList;
    clientfrm:= SpecialProductsform;
  end;
  SetUpdatehint;
  clientfrm.pnlMain.Visible:= TRue;
  clientfrm.ShowFormHint;
  SLErrorlog.clear;
  lblViewUpdateLog.visible := False;
end;

function TfmDataUpdator.clientPropertiesForm: TfmDU_Client;
begin
  if frmClientProperties  = nil then begin
    frmClientProperties := TfmDU_Client(TfmDU_Client.Makeinstance(self, pnlClientMain));
    frmClientProperties.openQueries;
  end;
  result:=frmClientProperties ;

end;
function TfmDataUpdator.CustomerSpecialPriceform: TfmDU_CustomerSpecialPrice;
begin
  if frmCustomerSpecialPrices  = nil then begin
    frmCustomerSpecialPrices := TfmDU_CustomerSpecialPrice(TfmDU_CustomerSpecialPrice.Makeinstance(self, pnlClientMain));
    frmCustomerSpecialPrices.openQueries;
  end;
  result:=frmCustomerSpecialPrices ;

end;

procedure TfmDataUpdator.ProductMainbtnclick(Sender: TObject);
begin
  if not(Sender is TDNMSpeedButton) then exit;
  if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cExtraSellPrice]) then begin
    if fiProductPageIndex = cExtraSellPrice then exit;// page not changed
    if Productfrm<> nil then Productfrm.pnlMain.Visible:= False;
    fiProductPageIndex := cExtraSellPrice;
    Productfrm:= ExtraSellPriceform;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cExtraForeingSellPrice]) then begin
    if fiProductPageIndex = cExtraForeingSellPrice then exit;// page not changed
    if Productfrm<> nil then Productfrm.pnlMain.Visible:= False;
    fiProductPageIndex := cExtraForeingSellPrice;
    Productfrm:= ExtraForeingSellPriceform;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cExtraBuyPrice]) then begin
    if fiProductPageIndex = cExtraBuyPrice then exit;// page not changed
    if Productfrm<> nil then Productfrm.pnlMain.Visible:= False;
    fiProductPageIndex := cExtraBuyPrice;
    Productfrm:= ExtraBuyPriceform;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cExtraSellPricetoDelete]) then begin
    if fiProductPageIndex = cExtraSellPricetoDelete then exit;// page not changed
    if Productfrm<> nil then Productfrm.pnlMain.Visible:= False;
    fiProductPageIndex := cExtraSellPricetoDelete;
    Productfrm:= DeleteExtraSellPriceForm;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cExtraBuyPricetoDelete]) then begin
    if fiProductPageIndex = cExtraBuyPricetoDelete then exit;// page not changed
    if Productfrm<> nil then Productfrm.pnlMain.Visible:= False;
    fiProductPageIndex := cExtraBuyPricetoDelete;
    Productfrm:= DeleteExtraBuyPriceForm;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cExtraForeinBuyPrice]) then begin
    if fiProductPageIndex = cExtraForeinBuyPrice then exit;// page not changed
    if Productfrm<> nil then Productfrm.pnlMain.Visible:= False;
    fiProductPageIndex := cExtraForeinBuyPrice;
    Productfrm:= ExtraForeinBuyPriceform;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cProductProperties]) then begin
    if fiProductPageIndex = cProductProperties then exit;// page not changed
    if Productfrm<> nil then Productfrm.pnlMain.Visible:= False;
    fiProductPageIndex := cProductProperties;
    Productfrm:= ProductPropertiesform;
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cConfirmImport]) then begin
    DoconfirmImport;
    MessageDlgXP_Vista('Prices Confirmed', mtInformation, [mbOK], 0);
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cAdjustUom]) then begin
    btnAdjUomClick(self)
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cUOMList]) then begin
    btnUOMListClick(self)
  end else if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProductButtonCaptions[cAdjustQty]) then begin
    btnAdjQtyClick(Self)
  end else begin
    Exit;
  end;
  SetUpdatehint;
  Productfrm.pnlMain.Visible:= TRue;
  Productfrm.ShowFormHint;
  SLErrorlog.clear;
  lblViewUpdateLog.visible := False;
end;
procedure TfmDataUpdator.DoconfirmImport;
var
  scr :TERPScript;
  s:String;
begin
  inherited;
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.SQL.clear;
    s:= trim(replacestr(Appenv.AppDB.TableVersion, '.' , ''));
    scr.SQL.add('create table if not Exists erpfix_uom_ci_'+s+' like tblunitsofmeasure;');
    scr.SQL.add('insert IGNORE into erpfix_uom_ci_'+s+'  Select * from tblunitsofmeasure;');

    scr.SQL.add('create table if not Exists erpfix_extrapricesell_ci_'+s+' like tblextrapricesell;');
    scr.SQL.add('insert IGNORE into erpfix_extrapricesell_ci_'+s+'  Select * from tblextrapricesell;');

    scr.SQL.add('insert ignore into tblunitsofmeasure '+
                 '(PartID , unitname ,unitDescription, Multiplier , baseUnitname , baseunitID, active , height , width , Length , weight , Volume , unitProductKeyname)  '+
                 ' select distinct EPS.PartsID,  puom.unitname , puom.unitDescription, Max(puom.Multiplier) Multiplier , puom.baseUnitname , puom.baseunitID, puom.active ,    '+
                 ' max(ifnull(puom.height,0)) height, max(ifnull(puom.width,0)) width, max(ifnull(puom.Length,0)) Length, max(ifnull(puom.weight,0)) weight, max(ifnull(puom.Volume,0)) Volume ,     '+
                 ' concat(puom.unitname, ":", p.partname) unitProductKeyname    '+
                 ' from tblextrapricesell EPS   '+
                 ' inner join tblparts P on p.partsId = EPS.PartsId Left join tblunitsofmeasure uom on    EPS.uom = uom.UnitName  and  EPS.uommultiplier = uom.Multiplier and EPS.PartsID = uom.PartID   '+
                 ' inner join tblunitsofmeasure puom on EPS.uomid = puom.UnitID and  EPS.uom = puom.UnitName  and  EPS.uommultiplier = puom.Multiplier    '+
                 ' where ifnull(uom.unitID,0)=0   group by PartsID,  puom.unitname;');

    scr.SQL.add('update tblextrapricesell EPS    '+
                 ' inner join tblunitsofmeasure uom  on EPS.uom = uom.UnitName  and  EPS.uommultiplier = uom.Multiplier and EPS.PartsID = uom.PartID Set EPS.uomID  =  uom.UnitID where EPS.uomid <> uom.UnitID ;');

    scr.SQL.add('create table if not Exists erpfix_foreignprice_ci_'+s+' like tblforeignprice;');
    scr.SQL.add('insert IGNORE into erpfix_foreignprice_ci_'+s+'  Select * from tblforeignprice;');
    scr.SQL.add('insert ignore into tblunitsofmeasure   '+
                 ' (PartID , unitname ,unitDescription, Multiplier , baseUnitname , baseunitID, active , height , width , Length , weight , Volume , unitProductKeyname)    '+
                 ' select distinct EPS.PartsID,  puom.unitname , puom.unitDescription, Max(puom.Multiplier) Multiplier , puom.baseUnitname , puom.baseunitID, puom.active ,    '+
                 ' max(ifnull(puom.height,0)) height, max(ifnull(puom.width,0)) width, max(ifnull(puom.Length,0)) Length, max(ifnull(puom.weight,0)) weight, max(ifnull(puom.Volume,0)) Volume ,     '+
                 ' concat(puom.unitname, ":", p.partname) unitProductKeyname    '+
                 ' from tblforeignprice EPS   '+
                 ' inner join tblparts P on p.partsId = EPS.PartsId Left join tblunitsofmeasure uom on EPS.uom = uom.UnitName  and  EPS.uommultiplier = uom.Multiplier and EPS.PartsID = uom.PartID   '+
                 ' inner join tblunitsofmeasure puom on EPS.uomid = puom.UnitID and  EPS.uom = puom.UnitName  and  EPS.uommultiplier = puom.Multiplier    '+
                 ' where ifnull(uom.unitID,0)=0   group by PartsID,  puom.unitname;');
    scr.SQL.add('update tblforeignprice EPS    '+
                 ' inner join tblunitsofmeasure uom  on EPS.uom = uom.UnitName  and  EPS.uommultiplier = uom.Multiplier and EPS.PartsID = uom.PartID Set EPS.uomID  =  uom.UnitID where EPS.uomid <> uom.UnitID ;');

    scr.SQL.add('create table if not Exists erpfix_extraprice_ci_'+s+' like tblextraprice;');
    scr.SQL.add('insert IGNORE into erpfix_extraprice_ci_'+s+'  Select * from tblextraprice;');
    scr.SQL.add('insert ignore into tblunitsofmeasure   '+
                 ' (PartID , unitname ,unitDescription, Multiplier , baseUnitname , baseunitID, active , height , width , Length , weight , Volume , unitProductKeyname)    '+
                 ' select distinct EPS.PartsID,  puom.unitname , puom.unitDescription, Max(puom.Multiplier) Multiplier , puom.baseUnitname , puom.baseunitID, puom.active ,    '+
                 ' max(ifnull(puom.height,0)) height, max(ifnull(puom.width,0)) width, max(ifnull(puom.Length,0)) Length, max(ifnull(puom.weight,0)) weight, max(ifnull(puom.Volume,0)) Volume ,     '+
                 ' concat(puom.unitname, ":", p.partname) unitProductKeyname    '+
                 ' from tblextraprice EPS   '+
                 ' inner join tblparts P on p.partsId = EPS.PartsId   '+
                 ' Left join tblunitsofmeasure uom on EPS.uom = uom.UnitName  and  EPS.uommultiplier = uom.Multiplier and EPS.PartsID = uom.PartID   '+
                 ' inner join tblunitsofmeasure puom on EPS.uomid = puom.UnitID and  EPS.uom = puom.UnitName  and  EPS.uommultiplier = puom.Multiplier    '+
                 ' where ifnull(uom.unitID,0)=0   group by PartsID,  puom.unitname;');
    scr.SQL.add('update ignore tblextraprice EPS   '+
                 ' inner join tblunitsofmeasure uom  on EPS.uom = uom.UnitName  and  EPS.uommultiplier = uom.Multiplier and EPS.PartsID = uom.PartID Set EPS.uomID  =  uom.UnitID where EPS.uomid <> uom.UnitID ;');
    showProgressbar(WAITMSG , 3);
    try
      DoStepProgressbar;
      scr.Execute;
    finally
      HideProgressbar;
    end;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;


end;

procedure TfmDataUpdator.DoFormSize(ChangeSize: Boolean);
begin
  if assigned(GuiPrefs) then begin
    if not GuiPrefs.Active then GuiPrefs.Active := TRue;
    GuiPrefs.Node['Options.sizeMode'].asString := fsSizemode;
    SizeMode := fsSizemode;
  end;
  inherited;
end;


function TfmDataUpdator.ExtraSellPriceform        : TfmDU_ExtraSellPrice       ;
begin
  if frmExtraSellPrice   = nil then begin
    frmExtraSellPrice  := TfmDU_ExtraSellPrice(TfmDU_ExtraSellPrice.Makeinstance       (self, pnlProductMain));
    frmExtraSellPrice.ExtraSellPrice    :=ExtraSellPrice;
    ExtraSellPrice.Load;
    frmExtraSellPrice.openQueries;
  end;
  result:=frmExtraSellPrice  ;
end;
function TfmDataUpdator.SpecialProductsform        : TfmDU_SpecialProducts       ;
begin
  if frmSpecialProducts  = nil then begin
    frmSpecialProducts := TfmDU_SpecialProducts(TfmDU_SpecialProducts.Makeinstance(self, pnlClientMain));
    SpecialProducts.Load;
    frmSpecialProducts.openQueries;
  end;
  result:=frmSpecialProducts ;

end;
function TfmDataUpdator.formatMobileno(fsname :String;MobileNo: String; countryname: String; fConnection :TMyConnection; Category:String): String;
var
  fscountryCallingCode:String;
begin
  Try
    if MobileNo = '' then exit;
    if SMSUtils.NumberHasCorrectPrefix(MobileNo, fconnection ) then
    else begin
      if NumberHasCorrectPrefix(MobileNo ,fConnection) then begin
          LogError(Category +' Properties' ,fsname , 'It has a valid mobileno - ' + MobileNo );
          Exit; // valid format and exit
      end else if NumberHasCountryCode(MobileNo, fConnection) and not(NumberHasPlusPrefix(MobileNo)) then begin
        MobileNo := '+' + MobileNo;
        LogError(Category +' Properties' ,Clients.clientname , 'Missing ''+'' in the begenning of the mobile number which is updated - ' + MobileNo);
        Exit; // validformat with the + so Exit
      end;
      if countryname = '' then exit;

      fscountryCallingCode := CountryISDCode(countryname);

      if fscountryCallingCode <> '' then begin
        if  NumberHasPlusPrefix(MobileNo) then MobileNo := replaceStr(MobileNo , '+' , '');
        if copy(MobileNo, 1,1)='0'        then MobileNo := copy(MobileNo, 2, length(MobileNo));
          MobileNo := '+' + fscountryCallingCode + MobileNo;
        end else begin
          LogError(Category +' Properties' ,Clients.clientname , 'ISD code not found for country ' + Quotedstr(countryname) );
        end;
      end;
  Finally
    REsult:= Mobileno;
  End;
end;

function TfmDataUpdator.DataConnection: TMyDacDataConnection;
begin
  if fDataConnection = nil then begin
    fDataConnection :=TMyDacDataConnection.Create(Self);
    fDataConnection.Connection:= Self.MyConnection;
  end;
  result:= fDataConnection;
end;

function TfmDataUpdator.DeleteExtraBuyPriceForm: TfmDU_DeleteExtraBuyPrice;
begin
  if frmDeleteExtraBuyPrice = nil then begin
    frmDeleteExtraBuyPrice   := TfmDU_DeleteExtraBuyPrice(TfmDU_DeleteExtraBuyPrice.Makeinstance(self, pnlProductMain));
  end;
  result:=frmDeleteExtraBuyPrice;
end;

Function TfmDataUpdator.DeleteExtraSellPriceForm :TfmDU_DeleteExtraSellPrice;
begin
  if frmDeleteExtraSellPrice    = nil then begin
    frmDeleteExtraSellPrice   := TfmDU_DeleteExtraSellPrice(TfmDU_DeleteExtraSellPrice.Makeinstance        (self, pnlProductMain));
  end;
  result:=frmDeleteExtraSellPrice   ;
end;
function TfmDataUpdator.ExtraForeingSellPriceform : TfmDU_ExtraforeignSellPrice;
begin
  if frmExtraFxSellPrice = nil then begin
    frmExtraFxSellPrice:= TfmDU_ExtraforeignSellPrice(TfmDU_ExtraforeignSellPrice.Makeinstance(self, pnlProductMain));
    frmExtraFxSellPrice.ExtraFxSellPrice := ExtraFxSellPrice;
    ExtraFxSellPrice.Load;
    frmExtraFxSellPrice.OpenQueries;
  end;
  result:=frmExtraFxSellPrice;
end;
function TfmDataUpdator.ExtraBuyPriceform         : TfmDU_ExtraBuyPrice        ;
begin
  if frmExtraBuyPrice    = nil then begin
    frmExtraBuyPrice   := TfmDU_ExtraBuyPrice(TfmDU_ExtraBuyPrice.Makeinstance        (self, pnlProductMain));
    frmExtraBuyPrice.ExtraBuyPrice := ExtraBuyPrice;
    ExtraBuyPrice.Load;
    frmExtraBuyPrice.openQueries;
  end;
  result:=frmExtraBuyPrice   ;
end;
function TfmDataUpdator.ExtraForeinBuyPriceform   : TfmDU_ExtraForeignBuyPrice;
begin
  if frmExtraFxBuyPrice  = nil then begin
    frmExtraFxBuyPrice := TfmDU_ExtraForeignBuyPrice(TfmDU_ExtraForeignBuyPrice.Makeinstance(self, pnlProductMain));
    frmExtraFxBuyPrice.ExtraFxBuyPrice := ExtraFxBuyPrice;
    ExtraFxBuyPrice.load;
    frmExtraFxBuyPrice.openQueries;
  end;
  result:=frmExtraFxBuyPrice ;
end;

procedure TfmDataUpdator.btnCloseClick(Sender: TObject);
begin
  inherited;
  fsSizemode := 'N';
  Self.Close;
end;

procedure TfmDataUpdator.btnCompletedClick(Sender: TObject);
begin

  if pagemain.tabindex =0 then begin
          frmproductList.qryMain.DisableControls;
          try
            CompletedProductUpdate;
          finally frmproductList.qryMain.EnableControls; end;
  end else if pagemain.tabindex =1 then begin
          frmClientList.qryMain.DisableControls;
          try
            CompletedclientUpdate;
          finally frmClientList.qryMain.EnableControls; end;
  end else if pagemain.tabindex =2 then begin
          frmUOMMismatchlist.qryMain.DisableControls;
          try
            DoMiscDataUpdate;
          finally frmUOMMismatchlist.qryMain.EnableControls; end;
  end else if pagemain.tabindex =3 then begin
          frmProcResList.qryMain.DisableControls;
          try
            CompletedProcResUpdate;
          finally frmProcResList.qryMain.EnableControls; end;
  end;
end;
procedure TfmDataUpdator.CompletedclientUpdate;
begin
try
      ValidateSelection;
      if ClientPageIndex = cClientProperties then begin
        if  updatingcontact then begin
          CheckClientnContacts;
          checkclientselection(fsClientcontactsinList, fsClientContactsSelectedInList, 'Contact');
          if MessageDlgXP_Vista('You are about to update the ' + inttostr(clientcontacts.count) +' selected Contacts for the selections made which has Mobile number and country name.' +NL+
                           'Data entered in any other page will not be processed.'+NL +   NL+
                           'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mrNo then exit;
         end else if not(updatingcontact) or  MakingContact then begin
            CheckClientnContacts;
            checkclientselection(fsClientsinList, fsClientsSelectedInList, 'Clients');
          if MessageDlgXP_Vista('You are about to update the ' + inttostr(Clients.count) +' selected Clients for the selections made which has Mobile number and country name.' +NL+
                           'Data entered in any other page will not be processed.'+NL + NL+
                           'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mrNo then exit;
         end;
        DoUpdate;

      end else if ClientPageIndex = cSpecialProductList then begin
        if updatingSpecialPriceList then begin
          if SpecialProducts.Count =0 then Exit;
          if MessageDlgXP_Vista('You are about to create/update ' + inttostr(SpecialProducts.Count) +' ''Customers Special Prices'' for ' + inttostr(Customers.count) +' Selected Customers.' +NL+
                             'Data entered in any other page will not be processed.'+NL+
                             'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then
            DoUpdate;
        end;
      end;
finally
      Clients.userlock.UnlockAllCurrentInstance;
      Customers.userlock.UnlockAllCurrentInstance;
end;
end;
Procedure TfmDataUpdator.DoUpdate;
begin
  showProgressbar(WAITMSG , Products.Count , False );
  try
    SLErrorlog.clear;
    try
      SLErrorlog.Add('Truncate '+ fsErrLogTablename+';');
      BeginTransaction;
      try
        Idsdone:='';
        ValidateSelection;
        if  PageMain.TabIndex=0 then begin
            DoProductUpdate;
        end else if PageMain.TabIndex=1 then begin
            DoclientUpdate;
        end else if PageMain.TabIndex=3 then begin
            DoProcresourceUpdate;
        end;
      Except
        on E:Exception do begin
          RollbackTransaction;
          MessageDlgXP_Vista('Update Failed'+NL+NL+E.message, mtWarning, [mbOK], 0);
        end;
      end;
    finally
      ExecuteSQL(SLErrorlog.Text);
      closeDb(QryUpdateErrLog);
      openDB(QryUpdateErrLog);
      lblViewUpdateLog.Visible :=SLErrorlog.count>1;
      if SLErrorlog.count >1 then
        if MessageDlgXP_Vista('Update Finished with Errors', mtWarning, [mbok], 0 ,nil, '' , '' , False,nil, lblViewUpdateLog.Caption  ) = 100 then lblViewUpdateLogclick(lblViewUpdateLog) else
      else MessageDlg('Update Finished ', mtInformation, [mbOK], 0);
    end;
  finally
    HideProgressbar;
  end;
end;
Procedure TfmDataUpdator.ValidateSelection;
begin
  if   PageMain.TabIndex=0 then begin
    ValidateProductSelection;
  end else if   PageMain.TabIndex=1 then begin
    ValidateClientSelection;
  end else if   PageMain.TabIndex=2 then begin
    // Misc Data Updates
  end else if   PageMain.TabIndex=3 then begin
    ValidateProcResSelection;
  end;
end;
Procedure TfmDataUpdator.ValidateClientSelection;
begin
  if fiClientPageIndex = cClientProperties  then begin
    if  Clientfrm is TfmDU_Client then begin
      if TfmDU_Client(Clientfrm).chkClient.Checked then begin
        if  (UseRegionCountry) then TclientcontactListGUI(frmClientList).DoSelectOnlyWithMobileno
        else if (TfmDU_Client(Clientfrm).optclient.ItemIndex = 0) then TclientcontactListGUI(frmClientList).DoSelectOnlyWithcountrynMobileno
        else  TclientcontactListGUI(frmClientList).DoSelectOnlyWithBillcountrynMobileno;
        CheckClientnContacts; // reinit the selection
      end;
      if TfmDU_Client(Clientfrm).chkUpdatecontacts.checked then begin
        CheckClientnContacts;
        TclientcontactListGUI(frmClientList).DoSelectOnlycontactMobileno;
      end else if TfmDU_Client(Clientfrm).chkMakecontact.checked then begin
        CheckClientnContacts;
        TclientcontactListGUI(frmClientList).DoSelectClientsWithNocontact;
      end;
      end;
  end else if fiClientPageIndex = cSpecialProductList  then begin
      if Clientfrm is TfmDU_SpecialProducts then begin
          CheckClientnContacts;
      end;
  end;
end;
procedure TfmDataUpdator.CompletedProductUpdate;
var
  Msg:String;
begin
  inherited;
  try
    Msg:= '';
    try
      ExtraSellPrice.PostDb;
      SpecialProducts.PostDb;
      ExtraFxSellPrice.PostDb;
      ExtraBuyPrice.PostDb;
      ExtraFxBuyPrice.PostDb;

      if ProductPageIndex = cExtraSellPricetoDelete then  begin
        SetProductsSelectedInList(frmDeleteExtraSellPrice.ProductsSelected);
      end;

      CheckProducts;
      if fsProductsinList = '' then begin
        Msg:= 'Please Select the Products for the update';
        Exit;
      end;
      if fsProductsSelectedInList = '' then begin
        updateoption:= MessageDlgXP_Vista('Since you haven''t selected any products in the list, would you like to update all products?', mtConfirmation,[], 0 ,nil , '' , '' , False , nil , 'All Products, Cancel');
        if updateoption = 101 then exit;
      end;
      if (fsProductsSelectedInList <> '') and not(sametext(fsProductsSelectedInList , fsProductsinList)) and (ProductPageIndex <> cExtraSellPricetoDelete) then begin
        updateoption:= MessageDlgXP_Vista('Do you like to update all products or the selected Products', mtConfirmation, [], 0 ,nil , '' , '' , False , nil , 'All Products,Selected Products, Cancel');
        if updateoption = 102 then exit;
      end;
      if ProductPageIndex = cExtraSellPrice then begin
        if ExtraSellPrice.Count =0 then begin
          Msg:= 'Create Entries for Extra Sell price';
          Exit;
        end;
        if MessageDlgXP_Vista('You are about to create/update ' + inttostr(ExtraSellPrice.Count) +' ''Extra Sell Price entries'' for ' + inttostr(Products.count) +' selected products.' +NL+
                           'Data entered in any other page will not be processed.'+NL+
                           'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then
          DoUpdate;
      
      end else if ProductPageIndex = cExtraSellPriceToDelete then begin
        if frmDeleteExtraSellPrice.grdmain.SelectedList.Count =0 then begin
          Msg:= 'Select Entries of Extra Sell price to delete';
          Exit;
        end;
        if MessageDlgXP_Vista('You are about to Delete ' + inttostr(frmDeleteExtraSellPrice.grdmain.SelectedList.Count) +' ''Extra Sell Price entries''.' +NL+
                           'Data entered in any other page will not be processed.'+NL+
                           'Are you sure to Delete these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then
          DoUpdate;
      end else if ProductPageIndex = cExtraForeingSellPrice then begin
        if ExtraFxSellPrice.Count =0 then begin
          Msg:= 'Create Entries for Foreign Extra Sell price';
          Exit;
        end;
        if MessageDlgXP_Vista('You are about to create/update ' + inttostr(ExtraFxSellPrice.Count) +' ''Foreign Extra Sell Price'' entries for ' + inttostr(Products.count) +' selected products.' +NL+
                           'Data entered in any other page will not be processed.'+NL +
                           'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then

        DoUpdate;
      end else if ProductPageIndex = cExtraBuyPrice then begin
        if ExtrabuyPrice.Count =0 then begin
          Msg:= 'Create Entries for Extra Buy price';
          Exit;
        end;
        if MessageDlgXP_Vista('You are about to create/update ' + inttostr(ExtrabuyPrice.Count) +' ''Extra Buy Price entries'' for ' + inttostr(Products.count) +' selected products.' +NL+
                           'Data entered in any other page will not be processed.'+NL +
                           'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then
        DoUpdate;
      end else if ProductPageIndex = cExtraBuyPriceToDelete then begin
        if frmDeleteExtraBuyPrice.grdmain.SelectedList.Count =0 then begin
          Msg:= 'Select Entries of Extra Buy price to delete';
          Exit;
        end;
        if MessageDlgXP_Vista('You are about to Delete ' + inttostr(frmDeleteExtraBuyPrice.grdmain.SelectedList.Count) +' ''Extra Buy Price entries''.' +NL+
                           'Data entered in any other page will not be processed.'+NL+
                           'Are you sure to Delete these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then
          DoUpdate;
      end else if ProductPageIndex = cExtraForeinBuyPrice then begin
        if ExtraFxBuyPrice.Count =0 then begin
          Msg:= 'Create Entries for Extra Foreign Buy price';
          Exit;
        end;
        if MessageDlgXP_Vista('You are about to create/update ' + inttostr(ExtraFxBuyPrice.Count) +' ''Foreign Extra Buy Price entries'' for ' + inttostr(Products.count) +' selected products.' +NL+
                           'Data entered in any other page will not be processed.'+NL +
                           'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then
        DoUpdate;
      end else if ProductPageIndex = cProductProperties then begin
        if MessageDlgXP_Vista('You are about to update the ' + inttostr(Products.count) +' selected products for the selections made here.' +NL+
                           'Data entered in any other page will not be processed.'+NL +
                           'Are you sure to update/create these?' , mtconfirmation , [mbyes,mbno] , 0) = mryes then
        DoUpdate;
      end;
    finally
      if (trim(Msg)<> '') then begin
        MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
        if assigned(Productfrm) then Setcontrolfocus(Productfrm);
      end else begin
        MessageDlgXP_Vista('Data Update finished', mtWarning, [mbOK], 0);
      end;
    end;
  finally
    Products.userlock.UnlockAllCurrentInstance;
  end;
end;

function TfmDataUpdator.ClientContacts :TContact;
var
  ssql:String;
begin
  if fsClientcontactsinList         = '' then fsClientcontactsinList        := '0';
  if fsClientcontactsSelectedInList = '' then fsClientcontactsSelectedInList:= '0';
  if fsCustomersSelectedInList       = '' then fsCustomersSelectedInList      := '0';

  if not Assigned(fClientContacts) then begin
      fClientContacts := Tcontact.Create(self);
      fClientContacts.Connection := DataConnection;
      fClientContacts.DoFieldChangewhenDisabled := True; // iterate records disables the control and doesn't fire dofield onchange
  end;

  if updateoption =100 then  {all Clientcontacts in the list}
    if fsClientsinList ='%' then ssql := ' ContactID like ''%'' '
    else ssql := ' ContactID in (' + fsClientsinList +')'
  else {Selected Clients in the list}
    ssql:=  ' contactID in (' + fsClientcontactsSelectedInList +')';

  if SameText(fClientContacts.SQLSelect , ssql) and (fClientContacts.datasetAssigned) and (fClientContacts.dataset.Active) then
  else fClientContacts.LoadSelect(ssql);

  Result:=fClientContacts;

end;
function TfmDataUpdator.Clients: Tclient;
var
  ssql:String;
begin
  if fsClientsinList ='' then fsClientsinList :=  '0';
  if fsClientsSelectedInList = '' then fsClientsSelectedInList := '0';
  if not Assigned(fClients) then begin
      fClients := TClient.Create(self);
      fClients.Connection := DataConnection;
      fClients.DoFieldChangewhenDisabled := True; // iterate records disables the control and doesn't fire dofield onchange
  end;
  if updateoption =100 then  {all Clients in the list}
    if fsClientsinList ='%' then ssql := ' ClientID like ''%'''
    else ssql := ' ClientID in (' + fsClientsinList +')'
  else {Selected Clients in the list}
    ssql:=  ' ClientID in (' + fsClientsSelectedInList +')';

  if SameText(fClients.SQLSelect , ssql) and (fClients.datasetAssigned) and (fClients.dataset.Active) then
  else fClients.LoadSelect(ssql);

  Result:=fClients;

end;
function TfmDataUpdator.Customers: TCustomer;
var
  ssql:String;
begin
  if fsCustomersinList ='' then fsCustomersinList :=  '0';
  if fsCustomersSelectedInList = '' then fsCustomersSelectedInList := '0';
  if not Assigned(fCustomers) then begin
      fCustomers := TCustomer.Create(self);
      fCustomers.Connection := DataConnection;
      fCustomers.DoFieldChangewhenDisabled := True; // iterate records disables the control and doesn't fire dofield onchange
  end;
  if updateoption =100 then
    if fsCustomersinList ='%' then ssql := ' ClientID like ''%'''
    else ssql := ' ClientID in (' + fsCustomersinList +')'
  else {Selected Clients in the list}
    ssql:=  ' ClientID in (' + fsCustomersSelectedInList +')';

  if SameText(fCustomers.SQLSelect , ssql) and (fCustomers.datasetAssigned) and (fCustomers.dataset.Active) then
  else fCustomers.LoadSelect(ssql);

  Result:=fCustomers;

end;

function TfmDataUpdator.updatingSpecialPriceList :Boolean ;
begin
  REsult:= False;
  if pagemain.tabindex =1 then
    if ClientPageIndex = cSpecialProductList then
      if assigned(Clientfrm) then
        if Clientfrm is TfmDU_SpecialProducts then
          result := true;
end;
function TfmDataUpdator.updatingcontact :Boolean ;
begin
  REsult:= False;
  if pagemain.tabindex =1 then
    if ClientPageIndex = cClientProperties then
      if assigned(Clientfrm) then
        if Clientfrm is TfmDU_Client then
          result := TfmDU_Client(Clientfrm).chkUpdatecontacts.checked;
end;
function TfmDataUpdator.MakingContact :Boolean ;
begin
  REsult:= False;
  if pagemain.tabindex =1 then
    if ClientPageIndex = cClientProperties then
      if assigned(Clientfrm) then
        if Clientfrm is TfmDU_Client then
          result := TfmDU_Client(Clientfrm).chkMakecontact.checked;
end;


Procedure TfmDataUpdator.checkclientselection(Ids, SelectedIds, category:String);
begin
        if Ids = '' then begin
                MessageDlgXP_Vista('Please Select the ' + Category +' for the update', mtInformation , [mbok],0);
                Exit;
        end;
        if  (sametext(SelectedIds , Ids)) then
                updateoption := 100
        else if SelectedIds = '' then begin
                updateoption:= MessageDlgXP_Vista('Since you haven''t selected any ' + Category +' in the list, would you like to update all ' + Category +'?', mtConfirmation,[], 0 ,nil , '' , '' , False , nil , 'All ' + Category +', Cancel');
                if updateoption = 101 then exit;
        end else begin
                updateoption := 0;
        end;
end;

procedure TfmDataUpdator.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TDataupdatorExtraSellPrice    then TDataupdatorExtraSellPrice(Sender).Dataset   :=QryExtraSellPrice
    else if Sender is TDataupdatorSpecialProducts   then TDataupdatorSpecialProducts(Sender).Dataset  :=QrySpecialProducts
    else if Sender is TDataUpdatorForeignSellPrice  then TDataUpdatorForeignSellPrice(Sender).Dataset :=QryExtraFxSellPrice
    else if Sender is TDataUpdatorExtraBuyPrice     then TDataUpdatorExtraBuyPrice(Sender).Dataset    :=qryExtraBuyPrice
    else if Sender is TDataUpdatorForeignBuyPrice   then TDataUpdatorForeignBuyPrice(Sender).Dataset  :=QryExtraFxBuyPrice
    else if Sender is TProduct                then TProduct(Sender).Dataset               := QryProduct
    else if Sender is TProductBarcode               then TProductBarcode(Sender).Dataset              := qrypartbarcodes
    else if Sender is TProductBarcodeList           then TProductBarcodeList(Sender).Dataset          := qryProductBarcodeList;

  end;
end;
constructor TfmDataUpdator.Create(AOwner: TComponent);
begin
  inherited;
end;

Function  TFmDataUpdator.CreateErrLogTable:String;
begin
  result:= commondblib.GetUserTemporaryTableName('errlog');
  With TempMyScript do try
    SQL.Add('drop table if exists '+result+';');
    SQL.Add('CREATE TABLE `'+result+'` ('+
                ' `ID` INT(10) NOT NULL AUTO_INCREMENT,'+
                ' `ErrObjType` VARCHAR(100) NULL,'+
                ' `ErrObjname` VARCHAR(255) NULL,'+
                ' `ErrDescription` VARCHAR(255) NULL,'+
                ' PRIMARY KEY (`ID`)'+
                ')  ENGINE=MyISAM;');
    Execute;
  finally
    Free;
  end;
end;
procedure TfmDataUpdator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Writeguiprefs;
  inherited;
  frmExtraSellPrice:= nil;
  frmSpecialProducts:= nil;
  frmDeleteExtraSellPrice:= nil;
  frmExtraFxSellPrice:= nil;
  frmExtraBuyPrice:= nil;
  frmExtraFxBuyPrice:= nil;
  action := CaFree;
end;
procedure TfmDataUpdator.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  fsSizemode := 'N';
end;

procedure TfmDataUpdator.FormCreate(Sender: TObject);
begin
  frmClientProperties:= nil;
  frmUOMMismatchlist := nil;
  frmProcResList := nil;
  fbclientSelectionChanged:= True;
  fbProductsleectionChanged :=True;
  WindowState := wsMaximized;
  fDataConnection := nil;
  fiProductPageIndex:= -1;
  fiClientPageIndex:= -1;
  SLErrorlog:=TStringlist.Create;
  fsErrLogTablename := CreateErrLogTable;
  QryUpdateErrLog.SQL.Text := 'Select * from ' +fsErrLogTablename+' order by ErrObjType,ErrObjname';
  fProducts:= nil;
  Productfrm:= nil;
  fiProductPageIndex:=0;
  fiClientPageIndex:=0;

  ExtraSellPrice    := TDataupdatorExtraSellPrice.Create(Self)  ;  ExtraSellPrice.Connection  := DataConnection;  ExtraSellPrice.BusObjEvent  := DoBusinessObjectEvent;
  SpecialProducts   := TDataupdatorSpecialProducts.Create(Self) ;  SpecialProducts.Connection := DataConnection;  SpecialProducts.BusObjEvent := DoBusinessObjectEvent;
	ExtraFxSellPrice  := TDataUpdatorForeignSellPrice.Create(Self);  ExtraFxSellPrice.Connection:= DataConnection;  ExtraFxSellPrice.BusObjEvent:= DoBusinessObjectEvent;
  ExtraBuyPrice     := TDataUpdatorExtraBuyPrice.Create(Self)   ;  ExtraBuyPrice.Connection   := DataConnection;  ExtraBuyPrice.BusObjEvent   := DoBusinessObjectEvent;
	ExtraFxBuyPrice   := TDataUpdatorForeignBuyPrice.Create(Self) ;  ExtraFxBuyPrice.Connection := DataConnection;  ExtraFxBuyPrice.BusObjEvent := DoBusinessObjectEvent;
  qryExtraSellPrice.SQL.Text  := 'Select * from ' + ExtraSellPrice.Tablename;
  qrySpecialProducts.SQL.Text := 'Select * from ' + SpecialProducts.Tablename;
  qryExtraFxSellPrice.SQL.Text:= 'Select * from ' + ExtraFxSellPrice.Tablename;
  qryExtraBuyPrice.SQL.Text   := 'Select * from ' + ExtraBuyPrice.Tablename;
  QryExtraFxBuyPrice.SQL.Text := 'Select * from ' + ExtraFxBuyPrice.Tablename;
  fsSizemode := 'M';
  inherited;
  pagemain.tabindex := 0;
end;

procedure TfmDataUpdator.FormDestroy(Sender: TObject);
begin
      Freeandnil(frmExtraSellPrice);
      Freeandnil(frmSpecialProducts);
      Freeandnil(frmDeleteExtraSellPrice);
      Freeandnil(frmExtraFxSellPrice);
      Freeandnil(frmExtraBuyPrice);
      Freeandnil(frmExtraFxBuyPrice);
      Freeandnil(SLErrorlog);
      if assigned(ExtraSellPrice) then CommonDbLib.DestroyUserTemporaryTable(ExtraSellPrice.Tablename);
      if assigned(SpecialProducts) then CommonDbLib.DestroyUserTemporaryTable(SpecialProducts.Tablename);
      if assigned(ExtraFxSellPrice) then CommonDbLib.DestroyUserTemporaryTable(ExtraFxSellPrice.Tablename);
      if assigned(ExtraBuyPrice) then CommonDbLib.DestroyUserTemporaryTable(ExtraBuyPrice.Tablename);
      if assigned(ExtraFxBuyPrice) then CommonDbLib.DestroyUserTemporaryTable(ExtraFxBuyPrice.Tablename);
      CommonDbLib.DestroyUserTemporaryTable(fsErrLogTablename);
      Freeandnil(frmproductList);
      Freeandnil(frmClientList);
      Freeandnil(frmProcResList);
      Freeandnil(frmUOMMismatchlist);
      Freeandnil(ExtraSellPrice);
      Freeandnil(SpecialProducts);
      Freeandnil(ExtraFxSellPrice);
      Freeandnil(ExtraBuyPrice);
      Freeandnil(ExtraFxBuyPrice);
      Freeandnil(fProducts);
      Freeandnil(fClients);
      Freeandnil(fClientContacts);
  try
    inherited;
  Except
    // kill excpetion
  end;
end;

procedure TfmDataUpdator.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PageMain, 1);
end;

procedure TfmDataUpdator.FormShow(Sender: TObject);
var
  i:Integer;
begin
  DoshowProgressbar(10 , WAITMSG);
  try
    inherited; DoStepProgressbar;
    OpenclientList      ;DoStepProgressbar('Searching for Clients')   ;Application.ProcessMessages;
    OpenProductList     ;DoStepProgressbar('Searching for Products')  ;Application.ProcessMessages;
    OpenProcResourceList;DoStepProgressbar('Searching for Resources') ;Application.ProcessMessages;
    OpenUOMMismatchlist ;DoStepProgressbar('Searching for UOM')       ;Application.ProcessMessages;
    try
      openQueries;
    Except
      on E:Exception do begin
        MessageDlgXP_Vista(E.Message , mtWarning , [mbok],0);
      end;
    end;
    DoStepProgressbar;
    AddButtons(Self, pnlProductButtons    , ProductButtonCaptions   , ProductButtonVisibility   , ProductButtonhint   ,ProductMainbtnclick    , ProductButtons    , 7, 148, 28, 5, 'Productbutton'  );
    AddButtons(Self, pnlClientButtons     , ClientButtonCaptions    , ClientButtonVisibility    , ClientButtonhint    ,ClientMainbtnclick     , ClientButtons     , 7, 148, 28, 5, 'Clientbutton'  );
    AddButtons(Self, pnlMiscDataUpdateButtons , MiscDataUpdateButtonCaptions, MiscDataUpdateButtonVisibility, MiscDataUpdateButtonhint,MiscDataUpdateMainbtnclick , MiscDataUpdateButtons , 7, 148, 28, 5, 'MiscDataUpdatebutton'  );
    AddButtons(Self, pnlProcResButtons    , ProcResButtonCaptions    , ProcResButtonVisibility    , ProcResButtonhint    ,ProcResMainbtnclick     , ProcResButtons     , 7, 148, 28, 5, 'ProcResbutton'  );
    DoStepProgressbar;
    GuiPrefs.Active := True;
    DoStepProgressbar;
    Readguiprefs;
    DoStepProgressbar;
    btnCompleted.showhint := True;
    RealignTabControl(PageMain, 1);
  finally
    DohideProgressbar;
  end;
end;

Procedure TfmDataUpdator.REfreshallPages;
var
  fi, ctr:Integer;
begin
showProgressbar('Refreshing All Pages' , PageMain.PageCount);
try
    fi:= PageMain.activepageindex;
    try
      for ctr := 0 to PageMain.PageCount  -1 do begin
        PageMain.activepageindex := ctr;
        StepProgressbar;
      end;
    finally
      if PageMain.activepageindex <> fi then PageMain.activepageindex:= fi;
    end;
finally
  HideProgressbar;
end;
end;
function TfmDataUpdator.getProductSplitAt: Integer;
begin
  result:= ProductSpliter.top;
end;
function TfmDataUpdator.getClientSplitAt: Integer;
begin
  result:= ClientFilter.top;
end;

procedure TfmDataUpdator.ProductSpliterMoved(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  for ctr:= 0 to ComponentCount-1 do begin
    if components[ctr] is TDNMSpeedButton then
      TDNMSpeedButton(components[ctr]).Invalidate;
  end;
end;

procedure TfmDataUpdator.lblViewUpdateLogClick(Sender: TObject);
begin
  inherited;
  InitMsgParams;
  PopupMsgParams.Msgcaption   := 'Search Result' ;
  PopupMsgParams.Msgds        := QryUpdateErrLog;
  PopupMsgParams.fieldnames   := 'ErrObjtype,ErrObjname,ErrDescription';
  PopupMsgParams.displayLabels:= 'type,Name,Description';
  PopupMsgParams.Custombuttons:= 'Ok';
  PopupMsgParams.Msg1         := 'Update Failed in the following';
  PopupMsgParams.MsgWidth     := 1006;
  PopupMsgParams.MsgHeight    := 500;
  PopupMsgParams.Displaywidths:= '110,110,700';
  PopupMsgParams.Msgcaption   := 'Update Error Log';
  TfmMessageWithList.MsgDlg;
end;

procedure TfmDataUpdator.OnclientMultiSelect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  fbclientSelectionChanged:= True;
end;

procedure TfmDataUpdator.OnProductMultiSelect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  fbProductsleectionChanged :=True;
end;

procedure TfmDataUpdator.OpenClientList;
begin
    CreateHistorylistform('TclientcontactListGUI' ,Self, frmClientList);
    frmClientList.OnGidMultiselect := OnclientMultiSelect;
    frmClientList.EnableMultiselect('Please Select client(s) to be updated');
    frmClientList.Parent := pnlClient;
    frmClientList.borderstyle := bsNone;
    frmClientList.Show;
    with TclientcontactListGUI(frmClientList) do begin
      grdMain.PopupMenu          := mnuFilter;
    end;

end;
procedure TfmDataUpdator.OpenProductList;
begin
    CreateHistorylistform('TProductListExpressGUI' ,Self, frmproductList);
    frmproductList.OnGidMultiselect := OnProductMultiSelect;
    frmproductList.Parent := pnlProduct;
    frmproductList.EnableMultiselect('Please Select Product(s) to be updated');
    frmproductList.borderstyle := bsNone;
    frmproductList.DisablePopupmenuinPanel:= False;
    frmproductList.Show;
    with TProductListExpressGUI(frmproductList) do begin
      grdMain.PopupMenu          := mnuFilter;
    end;
end;

procedure TfmDataUpdator.OpenUOMMismatchlist;
begin
  if frmUOMMismatchlist = nil  then begin
    CreateHistorylistform('TDU_UOMMismatchGUI' ,Self, frmUOMMismatchlist);
    frmUOMMismatchlist.Parent := pnlMiscDataUpdate;
    frmUOMMismatchlist.borderstyle := bsNone;
    frmUOMMismatchlist.DisablePopupmenuinPanel:= False;
    frmUOMMismatchlist.Show;
    with TDU_UOMMismatchGUI(frmUOMMismatchlist) do begin
      grdMain.PopupMenu          := mnuFilter;
    end;
  end;
end;



function TfmDataUpdator.ProductButtonforIndex(const Value: Integer): TDNMSpeedButton;
begin
  REsult:= nil;
  try
    result := Productbuttons[Value];
  Except
  end;

end;

function TfmDataUpdator.Productcount: Integer;
begin
  result:=0;
  if assigned(frmproductList) then
    result:= frmproductList.qryMain.RecordCount;
end;

function TfmDataUpdator.ProductPropertiesform: TfmDU_Product;
begin
  if frmProductProperties  = nil then begin
    frmProductProperties := TfmDU_Product(TfmDU_Product.Makeinstance(self, pnlProductMain));
    frmProductProperties.openQueries;
  end;
  result:=frmProductProperties ;
end;

procedure TfmDataUpdator.CheckClientnContacts;
begin
  showProgressbar(WAITMSG , 4);
  try
    if assigned(frmClientList) then begin
      if fbclientSelectionChanged then begin
        fsClientsinList         := '%';
        fsClientsSelectedInList := frmClientList.SelectedIDs('ClientID' , True);StepProgressbar;
        fsClientcontactsinList  := '%';
        fsClientcontactsSelectedInList:= frmClientList.SelectedIDs('ContactID' , True);
        fsCustomersinList         := '%';
        fsCustomersSelectedInList:= frmClientList.SelectedIDs('CustomerId' , True);
        fbclientSelectionChanged:= False;
      end;
    end;
  finally
    HideProgressbar;
  end;

end;

Procedure TfmDataUpdator.CheckProducts;
begin
showProgressbar(WAITMSG , 2);
try
  if assigned(frmproductList) then begin
    if fbProductsleectionChanged  then begin
      fsProductsinList := frmproductList.Ids('PartsID' , True);
      StepProgressbar;
      fsProductsSelectedInList:= frmproductList.SelectedIDs('PartsID' , True);
      fbProductsleectionChanged := False;
    end;
  end;
finally
  HideProgressbar;
end;
end;

procedure TfmDataUpdator.setProductPageIndex(const Value: Integer);
var
  cmp:Tcomponent;
begin
  cmp:= Findcomponent('ProductButton'+ inttostr(Value));
  if Assigned(cmp) and (cmp is TDNMSpeedButton) then
    ProductMainbtnclick(cmp);
  fiProductPageIndex := Value;
end;
procedure TfmDataUpdator.setClientPageIndex(const Value: Integer);
var
  cmp:Tcomponent;
begin
  cmp:= Findcomponent('ClientButton'+ inttostr(Value));
  if Assigned(cmp) and (cmp is TDNMSpeedButton) then
    clientMainbtnclick(cmp);
  fiClientPageIndex := Value;
end;

procedure TfmDataUpdator.SetClientsSelectedInList(const Value: String);
var
  st:TStringlist;
  ctr:Integer;
begin
  if value = '' then exit;
  if frmClientList = nil then exit;
  try
    st:= TStringlist.Create;
    try
      st.CommaText := Value;
      if st.Count =0 then exit;
      for ctr:= 0 to st.Count-1 do begin
        if isinteger(st[ctr]) then begin
          if frmClientList.qryMain.Locate('ClientID' ,strToInt(st[ctr]) , [] ) then
            frmClientList.grdMain.SelectRecord;
        end;
      end;
    finally
      FreeandNil(st);
    end;
  Except
  end;
end;

procedure TfmDataUpdator.SetProductsSelectedInList(const Value: String);
var
  st:TStringlist;
  ctr:Integer;
begin
  if value = '' then exit;
  if frmproductList = nil then exit;
  st:= TStringlist.Create;
  try
    st.CommaText := Value;
    if st.Count =0 then exit;
    for ctr:= 0 to st.Count-1 do begin
      if isinteger(st[ctr]) then begin
        if frmproductList.qryMain.Locate('PArtsID' ,strToInt(st[ctr]) , [] ) then
          frmproductList.grdMain.SelectRecord;
      end;
    end;
  finally
    FreeandNil(st);
  end;

end;

procedure TfmDataUpdator.setProductSplitAt(const Value: Integer);
var
  iValue:Integer;
begin
  iValue:= Value;
  if(iValue>400) then ivalue:= 400 else if iValue< 150 then iValue:= 150;
  pnlProduct.height := iValue;
end;
procedure TfmDataUpdator.setClientSplitAt(const Value: Integer);
var
  iValue:Integer;
begin
  iValue:= Value;
  if(iValue>400) then ivalue:= 400 else if iValue< 150 then iValue:= 150;
  pnlclient.height := iValue;
end;

procedure TfmDataUpdator.SetUpdatehint;
begin
  btnCompleted.hint := '';
  if PageMain.tabindex =0 then begin
    if fiProductPageIndex = cExtraSellPrice then begin
      btnCompleted.hint := 'This will apply all the ''Extra Sell Price entries'' you create for the products you select in the grid.' ;
    end else if fiProductPageIndex = cExtraSellPricetoDelete then begin
      btnCompleted.hint := 'This will delete the ''Extra Sell Price entries'' you have selected .' ;
    end else if fiProductPageIndex = cExtraForeingSellPrice then begin
      btnCompleted.hint := 'This will  apply all the ''Foreign Extra Sell Price entries'' for the products you select in the grid.' ;
    end else if fiProductPageIndex = cExtraBuyPrice then begin
      btnCompleted.hint := 'This will  apply all the ''Extra Buy Price entries'' for the products you select in the grid.' ;
    end else if fiProductPageIndex = cExtraForeinBuyPrice then begin
      btnCompleted.hint := 'This will  apply all the ''Foreign Extra Buy Price entries'' for the products you select in the grid.' ;
    end else if fiProductPageIndex = cProductProperties then begin
      btnCompleted.hint := 'This will update the products you select in the grid with the selections made here.' ;
    end;
  end else begin
    if fiClientPageIndex = cClientProperties then begin
      btnCompleted.hint := 'This will update the mobile phone of the Clients you select in the grid with its country''s ISD Code.' ;
    end else if fiClientPageIndex = cSpecialProductList then begin
      btnCompleted.hint := 'This will apply all the ''Customer''s Special Price'' you create for the products you select in the grid.' ;
    end;
  end;
  btnCompleted.hint := btnCompleted.hint  +NL+
                      'Data entered in any other page(s) will not be processed.'+NL;
end;

procedure TfmDataUpdator.PageMainChange(Sender: TObject);
begin
  inherited;
  if pagemain.activepage = tabMiscDataUpdates then OpenUOMMismatchlist;
end;

procedure TfmDataUpdator.PageMainResize(Sender: TObject);
begin
  inherited;
//  RealignTabControl(PageMain, 1);
end;

function TfmDataUpdator.Percentage(btn: TDNMSpeedButton): boolean;
begin
    Result := pos('%', btn.Caption) > 0;
end;

procedure TfmDataUpdator.Readguiprefs;
begin
  if GuiPrefs.Node['General.ProductSplitAt'].asInteger <> 0 then ProductSplitAt:= GuiPrefs.Node['General.ProductSplitAt'].asInteger;
  if GuiPrefs.Node['General.ClientSplitAt'].asInteger <> 0 then ClientSplitAt:= GuiPrefs.Node['General.ClientSplitAt'].asInteger;
  if GuiPrefs.Node['General.MiscDataUpdateSplitAt'].asInteger <> 0 then MiscDataUpdateSplitAt:= GuiPrefs.Node['General.MiscDataUpdateSplitAt'].asInteger;
  if GuiPrefs.Node['General.ProcResSplitAt'].asInteger <> 0 then ProcResSplitAt:= GuiPrefs.Node['General.ProcResSplitAt'].asInteger;
  if GuiPrefs.Node['General.ProductPageIndex'].asInteger =0 then ProductPageIndex:= 1
  else  begin
    ProductPageIndex:= -1;
    ProductPageIndex:= GuiPrefs.Node['General.ProductPageIndex'].asInteger;
  end;
  if GuiPrefs.Node['General.ClientPageIndex'].asInteger =0 then ClientPageIndex:= 1
  else  begin
    ClientPageIndex:= -1;
    ClientPageIndex:= GuiPrefs.Node['General.ClientPageIndex'].asInteger;
  end;

  if GuiPrefs.Node['General.TabIndex'].asInteger =2 then PageMain.TabIndex := 0
  else PageMain.TabIndex := GuiPrefs.Node['General.TabIndex'].asInteger;

  SetProductsSelectedInList(GuiPrefs.Node['General.ProductsSelected'].asString);
  SetclientsSelectedInList(GuiPrefs.Node['General.clientsSelected'].asString);
end;

procedure TfmDataUpdator.SelectProduct(const ProductID: Integer);
begin
  SetProductsSelectedInList(inttostr(ProductID));
end;

procedure TfmDataUpdator.Writeguiprefs;
begin
  GuiPrefs.Node['General.ProductPageIndex'].asInteger:= ProductPageIndex;
  GuiPrefs.Node['General.ClientPageIndex'].asInteger:= ClientPageIndex;
  GuiPrefs.Node['General.ProductSplitAt'].asInteger:= ProductSplitAt;
  GuiPrefs.Node['General.ClientSplitAt'].asInteger:= ClientSplitAt;
  GuiPrefs.Node['General.MiscDataUpdateSplitAt'].asInteger:= MiscDataUpdateSplitAt;
  GuiPrefs.Node['General.ProcResSplitAt'].asInteger:= ProcResSplitAt;
  GuiPrefs.Node['General.TabIndex'].asInteger:= PageMain.TabIndex;
  CheckProducts;
  GuiPrefs.Node['General.ProductsSelected'].asString := fsProductsSelectedInList;
  GuiPrefs.Node['General.ClientsSelected'].asString := fsClientsSelectedInList;
end;
function TfmDataUpdator.Products:TProduct;
var
  ssql:String;
begin
  if fsProductsinList ='' then fsProductsinList :=  '0';
  if fsProductsSelectedInList = '' then fsProductsSelectedInList := '0';
  if not Assigned(fProducts) then begin
      fProducts := TProduct.Create(self);
      fProducts.Connection := DataConnection;
      fProducts.DoFieldChangewhenDisabled := True; // iterate records disables the control and doesn't fire dofield onchange
      fProducts.BusObjEvent := DoBusinessObjectEvent;
      fProducts.IgnoreBarcodeUpdate := True;
  end;
  if updateoption =100 then  {all products in the list}
    ssql := ' partsId in (' + fsProductsinList +')'
  else {Selected products in the list}
    ssql:=  ' partsId in (' + fsProductsSelectedInList +')';

  if SameText(fProducts.SQLSelect , ssql) and (fProducts.datasetAssigned) and (fProducts.dataset.Active) then
  else fProducts.LoadSelect(ssql);

  Result:=fProducts;
end;


Procedure TfmDataUpdator.ValidateProductSelection;
var
  UOMID :Integer;
begin
  if fiProductPageIndex = cProductProperties then begin
    if assigned(Productfrm) and (Productfrm is TfmDU_Product) then begin
      With TfmDU_Product(Productfrm) do begin
        ValuesToUpdateWith;
        if chkcost.checked then begin
          if fdCost=0 then begin
            LogError('Selection','Update Cost' , 'the cost to update with is 0');
            chkcost.checked  := False;
          end else if (optcostOption.ItemIndex =-1) then begin
            LogError('Selection','Update Cost' , '''Increase By'' or ''Decrease By'' is not selected');
            chkcost.checked  := False;
          end else if (optcosttype.ItemIndex =-1) then begin
            LogError('Selection','Update Cost' , '''Percentage'' or ''Amount'' is not selected');
            chkcost.checked  := False;
          end;
        end;

        if chkPrice.checked then begin
          if fdPrice=0 then begin
            LogError('Selection','Update Price' , 'the Price to update with is 0');
            chkPrice.checked  := False;
          end else if (optPriceOption.ItemIndex =-1) then begin
            LogError('Selection','Update Price' , '''Increase By'' or ''Decrease By'' is not selected');
            chkPrice.checked  := False;
          end else if (optPricetype.ItemIndex =-1) then begin
            LogError('Selection','Update Price' , '''Percentage'' or ''Amount'' is not selected');
            chkPrice.checked  := False;
          end else if (OptPriceBasedon.ItemIndex =-1) then begin
            LogError('Selection','Update Price' , '''Update based on'' is not selected');
            chkPrice.checked  := False;
          end else if (OptPriceBasedon.ItemIndex =0) and (optpriceOption.itemindex = 2) then begin
            LogError('Selection','Update Price' , 'Chosen to update the product Price based on the cost but option ''Amount'' selected');
            chkPrice.checked  := False;
          end;
        end;

        if chkbatch.Checked then begin
          if  optBatch.ItemIndex = -1 then begin
            LogError('Selection','Update Batch Tracking' , 'Allocation is not selected');
            chkbatch.checked  := False;
          end;
        end;

        if chkbin.Checked then begin
          if  optBin.ItemIndex = -1 then begin
            LogError('Selection','Update Bin Tracking' , 'Allocation is not selected');
            chkbin.checked  := False;
          end;
        end;
        if chkSN.Checked then begin
          if  optSN.ItemIndex = -1 then begin
            LogError('Selection','Update SN Tracking' , 'Allocation is not selected');
            chkSN.checked  := False;
          end;
        end;

        if chkUOM.Checked then begin
          if edtUnit.Text = '' then begin
            LogError('Selection','Update Unit of Measure' , 'Please Select the unit');
            chkUOM.checked  := False;
          end else if (edMultiplier.Text ='') or not(ISnumeric(edMultiplier.Text)) then begin
            LogError('Selection','Update Unit of Measure' , 'Please Select the Multiplier');
            chkUOM.checked  := False;
          end else if (strToInt(edMultiplier.Text)>1) and (cboUnitOfMeasure.Text ='') then begin
            LogError('Selection','Update Unit of Measure' , 'Please Select the Base unit');
            chkUOM.checked  := False;
          end;
          if (chkSalesDefault.Checked) or (chkPurchDefault.Checked) then
            if not Products.userlock.LockAll('tblunitsofmeasure' , Self.Caption ) then begin
              LogError('Selection','Update Unit of Measure' , 'Unable to lock UOM List and whole Should be Locked to Change The Defaults.');
              chkSalesDefault.Checked:= False;
              chkPurchDefault.Checked := False;
            end;
          UOMID := TUnitOfMeasure.CreateNewUOM(Products, 0,edtUnit.Text,strtoint(edMultiplier.Text) , edtDesc.Text, cboUnitOfMeasure.Text, Products.Connection );
          if UOMID =0 then begin
              LogError('Selection','Update Unit of Measure' , 'Unable to create UOM');
              chkUOM.Checked := False;
          end;
        end;
      end;    {with product form}
    end;      {is Productfrm assigned and Productfrm is product form}
  end;        {is Product page}
end;

procedure TfmDataUpdator.ValuesToUpdateWith;
var
  fdValue:double;
  fiCode:Integer;
begin
  if pagemain.tabindex =0 then begin
    if Productfrm <> nil then
      if Productfrm is TfmDU_Product then
        With TfmDU_Product(Productfrm) do begin
          try
            Val(edtcostAmt.Text     , fdValue, fiCode);      fdcost        := fdValue;
            Val(edtPriceAmt.Text    , fdValue, fiCode);      fdPrice       := fdValue;
          Except
          end;
        end;
  end;

  if pagemain.tabindex =1 then begin
    if Clientfrm <> nil then
      if Clientfrm is TfmDU_CustomerSpecialPrice then
        With TfmDU_CustomerSpecialPrice(Clientfrm) do begin
          try
            Val(edtupdateSpecialPrice.Text     , fdValue, fiCode);      fdspecialPrice        := fdValue;
          Except
          end;
        end;
  end;
end;
Procedure TfmDataUpdator.DoProductUpdate;
begin
          showProgressbar('Updating ' + inttostr(Products.Count)+' Product(s)' , Products.Count);
          try
              Products.IterateRecords(DoUpdateCallback);
          finally
             HideProgressbar;
          end;
         CommitTransaction;
          Products.UserLock.UnlockAllCurrentInstance;
         if Idsdone <> '' then begin
                   if ProductPageIndex = cExtraSellPrice         then begin ExtraSellPrice.loadSelect(ExtraSellPrice.IDfieldname     +' in (' +idsdone+')' ); ExtraSellPrice.DeleteAll   ;ExtraSellPrice.LoadSelect('');
          end else if ProductPageIndex = cExtraForeingSellPrice  then begin ExtraFxSellPrice.loadSelect(ExtraFxSellPrice.IDfieldname +' in (' +idsdone+')' ); ExtraFxSellPrice.DeleteAll ;ExtraFxSellPrice.LoadSelect('');
          end else if ProductPageIndex = cExtraBuyPrice          then begin ExtraBuyPrice.loadSelect(ExtraBuyPrice.IDfieldname       +' in (' +idsdone+')' ); ExtraBuyPrice.DeleteAll    ;ExtraBuyPrice.LoadSelect('');
          end else if ProductPageIndex = cExtraForeinBuyPrice    then begin ExtraFxBuyPrice.loadSelect(ExtraFxBuyPrice.IDfieldname   +' in (' +idsdone+')' ); ExtraFxBuyPrice.DeleteAll  ;ExtraFxBuyPrice.LoadSelect('');
          end else if ProductPageIndex = cExtraSellPriceToDelete then begin qryExtraSellPriceToDelete.close; qryExtraSellPriceToDelete.open;
          end;
         end;
end;
Procedure TfmDataUpdator.DoclientUpdate;
begin
        showProgressbar('Updating Client' , clients.Count);
        try
          if updatingcontact then begin
               clientcontacts.IterateRecords(DoUpdateCallback);
          end else if ClientPageIndex = cSpecialProductList        then begin
            if trim(idsdone) <> '' then begin
              SpecialProducts.loadSelect(SpecialProducts.IDfieldname   +' in (' +idsdone+')' );
              SpecialProducts.DeleteAll  ;
            end;
            SpecialProducts.LoadSelect('');
            Customers.IterateRecords(DoUpdateCallback);
          end else if not(updatingcontact) Or MakingContact then begin
              clients.IterateRecords(DoUpdateCallback);
          end;

        finally
            HideProgressbar;
        end;
        CommitTransaction;
        clients.UserLock.UnlockAllCurrentInstance;
         if ficlientPageIndex = cClientProperties then begin
            if Idsdone <> '' then begin
                TclientcontactListGUI(frmClientList).grdMain.UnselectAll;
                TclientcontactListGUI(frmClientList).RefreshQuery ;
                SetclientsSelectedInList(fsClientsSelectedInList);
            end;
         end;
end;

Procedure TfmDataUpdator.LogError(const ErrObjType,ErrObjname,ErrDescription:String);
begin
  SLErrorlog.Add('insert into ' + fsErrLogTablename+' (ErrObjType,ErrObjname,ErrDescription) values (' + Quotedstr(ErrObjType) +','+ Quotedstr(ErrObjname)+','+Quotedstr(replacestr(ErrDescription, '\' , '\\'))+');');
end;
Procedure TfmDataUpdator.DoUpdateCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if not Sender.UserLock.Lock(Sender.GetBusObjectTablename , Sender.ID, 'Data Updator') then begin
    LogError(Sender.XMLNodename , Sender.IDToggle(Sender.ID),  Sender.UserLock.LockMessage);
    exit;
  end;

  Sender.Connection.BeginNestedTransaction;
  try
      if Sender is TProduct then begin
        stepProgressbar(TProduct(Sender).ProductName);
                 if ProductPageIndex = cExtraSellPrice         then begin ApplyExtraSellPrice(TProduct(Sender));
        end else if ProductPageIndex = cExtraForeingSellPrice  then begin ApplyExtraFxSellPrice(TProduct(Sender));
        end else if ProductPageIndex = cExtraBuyPrice          then begin ApplyExtraBuyPrice(TProduct(Sender));
        end else if ProductPageIndex = cExtraForeinBuyPrice    then begin ApplyExtraFxBuyPrice(TProduct(Sender));
        end else if ProductPageIndex = cProductProperties      then begin ApplyProductProperties(TProduct(Sender));
        end else if ProductPageIndex = cExtraSellPriceToDelete then begin ApplyExtraSellPriceToDelete(TProduct(Sender));
        end else if ProductPageIndex = cExtraBuyPriceToDelete  then begin ApplyExtraBuyPriceToDelete(TProduct(Sender));
        end;
      end else if (Sender is tClient)  then begin
          stepProgressbar(TClient(Sender).ClientName);
          if ClientPageIndex = cClientProperties         then begin
            if not(updatingcontact) then ApplyClientProperties(TClient(Sender));
            if Makingcontact then TClient(Sender).DoMakePrimaryContact;
          end else if ClientPageIndex = cSpecialProductList        then begin
            ApplySpecialProducts(TProduct(Sender));
          end;
      end else if  (Sender is Tcontact) then begin
          stepProgressbar;
          if ClientPageIndex = cClientProperties         then ApplycontactProperties(Tcontact(Sender));
      end else if  (Sender is TProcResource) then begin
          stepProgressbar;
          if ProcResPageIndex = cProcResProperties then ApplyProcResourceProperties(TProcResource(Sender));
      end;
      Sender.Connection.CommitNestedTransaction;
  Except
      on E:Exception do begin
        Sender.Connection.RollbackNestedTransaction;
        MessageDlgXP_Vista('Update Failed for ' +Sender.XMLNodeName+' :' +Sender.IDToggle(Sender.ID) + NL+NL + E.message, mtWarning, [mbOK], 0);
      end;
  end;
end;

Procedure TfmDataUpdator.LinkProducts(grd :twwDBGrid; Product:TProduct);
var
  i: integer;
begin
    if grd.SelectedList.Count > 0 then begin
      for i := 0 to grd.SelectedList.Count - 1 do begin
        grd.Datasource.Dataset.GoToBookmark(grd.SelectedList.Items[i]);
        if Product.productclass.Locate('ClassID' , grd.Datasource.Dataset.fieldbyname('classId').asInteger , []) = False then begin
          Product.ProductClass.New;
          Product.productclass.DeptID :=grd.Datasource.Dataset.fieldbyname('classId').asInteger ;
          Product.productclass.ProductId :=Product.ID;
          Product.productclass.PostDb;
        end;
      end;
    end;

end;
Procedure TfmDataUpdator.ApplyProductProperties(Product :TProduct);
var
  Msg:String;
  UOMID:Integer;
  fd :Double;
begin
  if  Productfrm is TfmDU_Product then begin
    ValuesToUpdateWith;
    With TfmDU_Product(Productfrm) do begin
{update cost}
      if chkcost.Checked then begin
          if (optcostOption.itemindex =0) and (optcosttype.itemindex=0) then begin
            if (Products.BuyQty1Cost=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Cost to increase by percentage and Cost1 =0') else Products.BuyQty1Cost := Products.BuyQty1Cost  + (Products.BuyQty1Cost *fdCost/100);
            if (Products.BuyQty2Cost=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Cost to increase by percentage and Cost2 =0') else Products.BuyQty2Cost := Products.BuyQty2Cost  + (Products.BuyQty2Cost *fdCost/100);
            if (Products.BuyQty3Cost=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Cost to increase by percentage and Cost3 =0') else Products.BuyQty3Cost := Products.BuyQty3Cost  + (Products.BuyQty3Cost *fdCost/100);
          end else if (optcostOption.itemindex =1) and (optcosttype.itemindex=0) then begin
            if (Products.BuyQty1Cost=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Cost to decrease by percentage and Cost1 =0') else Products.BuyQty1Cost := Products.BuyQty1Cost  - (Products.BuyQty1Cost *fdCost/100);
            if (Products.BuyQty2Cost=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Cost to decrease by percentage and Cost2 =0') else Products.BuyQty2Cost := Products.BuyQty2Cost  - (Products.BuyQty2Cost *fdCost/100);
            if (Products.BuyQty3Cost=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Cost to decrease by percentage and Cost3 =0') else Products.BuyQty3Cost := Products.BuyQty3Cost  - (Products.BuyQty3Cost *fdCost/100);
          end else if (optcostOption.itemindex =0) and (optcosttype.itemindex=1) then begin
            Products.BuyQty1Cost := Products.BuyQty1Cost  + fdCost;
            Products.BuyQty2Cost := Products.BuyQty2Cost  + fdCost;
            Products.BuyQty3Cost := Products.BuyQty3Cost  + fdCost;
          end else if (optcostOption.itemindex =1) and (optcosttype.itemindex=1) then begin
            Products.BuyQty1Cost := Products.BuyQty1Cost  - fdCost;
            Products.BuyQty2Cost := Products.BuyQty2Cost  - fdCost;
            Products.BuyQty3Cost := Products.BuyQty3Cost  - fdCost;
          end else if (optcostOption.itemindex =2) then begin
            Products.BuyQty1Cost :=   fdCost;
            Products.BuyQty2Cost :=   fdCost;
            Products.BuyQty3Cost :=   fdCost;
          end;
      end;
{update Price}
      if chkprice.Checked then begin
          if OptPriceBasedon.ItemIndex = 0 then begin
            fd := Products.BuyQty1Cost;
            if (fd=0) and  (optpriceOption.itemindex =0) and (optPricetype.itemindex=0) then begin
                LogError('Product',Product.ProductName , 'Chosen to update the product Price based on the cost to increase by percentage and Cost1 =0');
            end else if (fd=0) and  (optpriceOption.itemindex =1) and (optPricetype.itemindex=0) then begin
                LogError('Product',Product.ProductName , 'Chosen to update the product Price based on the cost to decrease by percentage and Cost1 =0');
            end else if optpriceOption.ItemIndex = 2 then begin
              LogError('Product',Product.ProductName , 'Chosen to update the product Price based on the cost to increase/decrease and option ''Amount'' selected');
            end else begin
                       if (optpriceOption.itemindex =0) and (optPricetype.itemindex=0) then begin {inc Perc}
                          fd:= fd + fd* fdprice/100;
              end else if (optpriceOption.itemindex =1) and (optPricetype.itemindex=0) then begin {dec Prec}
                          fd:= fd - fd* fdprice/100;
              end else if (optpriceOption.itemindex =0) and (optPricetype.itemindex=1) then begin {inc doll}
                          fd:= fd + fdprice;
              end else if (optpriceOption.itemindex =1) and (optPricetype.itemindex=1) then begin {dec doll}
                          fd:= fd - fdprice;
              end;
              Products.SellQty1Price := fd;
              Products.SellQty2Price := fd;
              Products.SellQty3Price := fd;
            end;
          end else if OptPriceBasedon.ItemIndex =1 then begin
              if (optpriceOption.itemindex =0) and (optPricetype.itemindex=0) then begin
                if (Products.SellQty1Price=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Price to increase by percentage and Price1 =0') else Products.SellQty1Price := Products.SellQty1Price  + (Products.SellQty1Price *fdPrice/100);
                if (Products.SellQty2Price=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Price to increase by percentage and Price2 =0') else Products.SellQty2Price := Products.SellQty2Price  + (Products.SellQty2Price *fdPrice/100);
                if (Products.SellQty3Price=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Price to increase by percentage and Price3 =0') else Products.SellQty3Price := Products.SellQty3Price  + (Products.SellQty3Price *fdPrice/100);
              end else if (optpriceOption.itemindex =1) and (optPricetype.itemindex=0) then begin
                if (Products.SellQty1Price=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Price to decrease by percentage and Price1 =0') else Products.SellQty1Price := Products.SellQty1Price  - (Products.SellQty1Price *fdPrice/100);
                if (Products.SellQty2Price=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Price to decrease by percentage and Price2 =0') else Products.SellQty2Price := Products.SellQty2Price  - (Products.SellQty2Price *fdPrice/100);
                if (Products.SellQty3Price=0) then LogError('Product',Product.ProductName , 'Chosen to update the product Price to decrease by percentage and Price3 =0') else Products.SellQty3Price := Products.SellQty3Price  - (Products.SellQty3Price *fdPrice/100);
              end else  if (optpriceOption.itemindex =0) and (optPricetype.itemindex=1) then begin
                  Products.SellQty1Price := Products.SellQty1Price  + fdPrice;
                  Products.SellQty2Price := Products.SellQty2Price  + fdPrice;
                  Products.SellQty3Price := Products.SellQty3Price  + fdPrice;
              end else if (optpriceOption.itemindex =1) and (optPricetype.itemindex=1) then begin
                  Products.SellQty1Price := Products.SellQty1Price  - fdPrice;
                  Products.SellQty2Price := Products.SellQty2Price  - fdPrice;
                  Products.SellQty3Price := Products.SellQty3Price  - fdPrice;
              end else if (optpriceOption.itemindex =2) then begin
                  Products.SellQty1Price := fdPrice;
                  Products.SellQty2Price := fdPrice;
                  Products.SellQty3Price := fdPrice;
              end;
          end;
      end;
{update bin batch sn}
      if chkbatch.Checked or chkbin.Checked or chkSn.Checked  then begin
        if not Products.ValidateAllocation(Msg, (chkbatch.Checked and (optBatch.itemindex =0) ) or
                                                (chkbin.Checked and (optbin.itemindex =0) ) OR
                                                (chksn.Checked and (optSN.itemindex =0) ) ) then begin
           LogError('Product',Product.ProductName , Msg);
        end else begin
          if chkbatch.Checked  then begin
            Products.Batch :=  optBatch.ItemIndex <> 0;
            if optBatch.ItemIndex <> 0 then
              Product.AutoAllocBatch :=optBatch.ItemIndex=1;
          end;
          if chkbin.Checked  then begin
            Products.MultipleBins:=  optbin.ItemIndex <> 0;
            if optbin.ItemIndex <> 0 then
              Product.Autoallocbin :=optbin.ItemIndex=1;
          end;
          if chksn.Checked then
            Products.SnTracking := optSN.ItemIndex<>0;
        end;
      end;
{Update Product Active}
    if chkActive.checked then begin
      if (OptActive.ItemIndex=1) and (Products.TotalStockQty<> 0) then begin
        LogError('Product',Product.ProductName , 'Can''t Be Made Inactive.  There is Stock or Transactions Outstanding !');
      end else begin
       Products.Active := OptActive.ItemIndex=0;
      end;
    end;

{Update Product Cost with purchase cost}
    if chkUpdateWithPurchaseCost.checked then begin
      Products.CostUpdateFromPurchase := OptUpdateWithPurchaseCost.ItemIndex = 1;
    end;


{Preferred supplier}
  if chkPreferedSupplier.Checked then begin
    if cboSupp.Text <> '' then
      Products.PreferedSupplierName :=cboSupp.text;
  end;
{departments}
  if chkClasses.checked then begin
     LinkProducts(grdClasses , Products);
  end;
{Reorder point}
  if chkAdjustReorderPoints.Checked then
     Products.ProductClass.IterateRecords(updateReorderpoints);
{Unit of measure}
    if chkUOM.Checked then begin
        UOMID := TUnitOfMeasure.CreateNewUOM(Products, Products.ID,edtUnit.Text,strtoint(edMultiplier.Text) , edtDesc.Text, cboUnitOfMeasure.text, Products.Connection );
        if UOMID = 0 then begin
          LogError('Product',Product.ProductName , 'Failted to create Unit of Meassure ' + Quotedstr(edtUnit.Text+' for product '+quotedstr(Products.ProductName)));
        end else begin
          if chkSalesDefault.Checked then begin
             Products.ExecuteSQL(' update tblunitsofmeasure Set SalesDefault ="F" where ifnull(PartId,0)=' +inttostr(Products.ID) +' and unitID <> ' + inttostr(UOMID)+';' +
                                 ' update tblunitsofmeasure Set SalesDefault ="T" where ifnull(PartId,0)=' +inttostr(Products.ID) +' and unitID = ' + inttostr(UOMID)+';', true );

          end;
          if chkPurchDefault.Checked then begin
             Products.ExecuteSQL(' update tblunitsofmeasure Set PurchasesDefault ="F" where ifnull(PartId,0)=' +inttostr(Products.ID) +' and unitID <> ' + inttostr(UOMID)+';' +
                                 ' update tblunitsofmeasure Set PurchasesDefault ="T" where ifnull(PartId,0)=' +inttostr(Products.ID) +' and unitID = ' + inttostr(UOMID)+';', true );
          end;
        end;
      end;
    end;
    Product.PostDB;
  end;
end;

Procedure TfmDataUpdator.updateReorderpoints(Const Sender: TBusObj; var Abort: boolean);

  function MonthsList : string;
  var
    idx : integer;
  begin
    Result := '';
    for idx := 1 to TfmDU_Product(Productfrm).cbMonth.Items.Count - 1 do
      if TfmDU_Product(Productfrm).cbMonth.Checked[idx] then
        if Result = '' then
          Result := '"' + csMonths[idx - 1] + '"'
        else
          Result := Result + ',"' + csMonths[idx - 1] + '"';
    if Result <> '' then
      Result := ' and OrderMonth in (' + Result + ')';

  end;

  function CreatePoint(AValue : double; aMode : boolean; aExt : double; ARounding : integer) : double;
  var
    newMod : double;
  begin
    if aMode then   // %
      Result := AValue * (1 + aExt/100)
    else
      Result := aExt;

    if ARounding <> 0 then
    begin
      newMod := (trunc(Result) mod ARounding) + Frac(Result);
      Result := Result - newMod;
      if (ARounding > 0) and (NewMod > 0) then
        Result := Result + ARounding;
    end;
 end;

begin
  if not(Sender is TProductClass) then exit;

  With TfmDU_Product(Productfrm) do
  begin

    if (spReorderPoint.Value = 0) and Percentage(btnReorderPoint) and
     (spPreferredLevel.Value = 0) and Percentage(btnPreferredLevel) and
     (spReorderAmount.Value = 0) and Percentage(btnReorderAmount) and
     (not (chkDoRound.Checked) and (csRounding[cbRounding.ItemIndex]<>0)) then
     exit;

    qryReorder.Close;
    qryReorder.SQL.Text := Format('select * from tblReorderPoints where ProductId=%d and ClassId=%d', [TProductClass(Sender).ProductId, TProductClass(Sender).DeptId]);
    if not chkAllMonths.Checked then
      qryReorder.SQL.Add(MonthsList);

    qryReorder.Open;

    try

      if qryReorder.RecordCount = 0 then
        exit;
      qryReorder.First;
      while not qryReorder.Eof do
      begin
        qryReorder.Edit;
        if (spReorderPoint.Value <> 0) or (chkDoRound.Checked) then
          qryReorder.FieldByName('ReorderPoint').asFloat := CreatePoint(qryReorder.FieldByName('ReorderPoint').asFloat , Percentage(btnReorderPoint), spReorderPoint.Value, integer(chkDoRound.Checked) * csRounding[cbRounding.ItemIndex]);
        if (spPreferredLevel.Value <> 0) or (chkDoRound.Checked) then
          qryReorder.FieldByName('PreferredLevel').asFloat := CreatePoint(qryReorder.FieldByName('PreferredLevel').asFloat , Percentage(btnPreferredLevel), spPreferredLevel.Value, integer(chkDoRound.Checked) * csRounding[cbRounding.ItemIndex]);
        if (spReorderAmount.Value <> 0) or (chkDoRound.Checked) then
          qryReorder.FieldByName('ReOrderAmount').asFloat := CreatePoint(qryReorder.FieldByName('ReOrderAmount').asFloat, Percentage(btnReorderAmount), spReorderAmount.Value, integer(chkDoRound.Checked) * csRounding[cbRounding.ItemIndex]);
        qryReorder.Next;
      end;
    finally
      qryReorder.Close;
    end;
  end;
end;

Procedure TfmDataUpdator.ApplyExtraSellPriceToDelete(Product :TProduct);
var
  s:STring;
  fsfilter:String;
begin
  s:= frmDeleteExtraSellPrice.EntriesSelected(Product.Id);
  if s<> '' then begin
    s:= 'PriceId = ' + replacestr(s , ',' , ' Or PriceId = ' );
    try
      fsfilter:=trim(Product.ExtraSellPrice.filter);
      if fsFilter <> '' then s:= '(' + fsfilter +') and (' + s +')';
      Product.ExtraSellPrice.Filter := s;
      Product.ExtraSellPrice.Filtered:= TRue;
      if Idsdone <> '' then Idsdone := Idsdone +',';
      Idsdone := Idsdone +Product.ExtraSellPrice.AllIds;
      Product.ExtraSellPrice.DeleteAll;
    finally
      Product.ExtraSellPrice.Filter:= fsfilter;
      Product.ExtraSellPrice.Filtered:= fsfilter <> '';
    end;
  end;
end;
Procedure TfmDataUpdator.ApplyExtraSellPrice(Product :TProduct)    ;
begin
  if  Productfrm is TfmDU_ExtraSellPrice then begin
    if TfmDU_ExtraSellPrice(Productfrm).optLockExtraSellPrice.ItemIndex <> 2 then
      Product.LockExtraSell := TfmDU_ExtraSellPrice(Productfrm).optLockExtraSellPrice.ItemIndex=0;
    if TfmDU_ExtraSellPrice(Productfrm).optExtraSellPriceOverrides.ItemIndex <> 2 then
      Product.ExtraSellPriceOverridesAllDiscounts := TfmDU_ExtraSellPrice(Productfrm).optExtraSellPriceOverrides.ItemIndex=0;
    Product.PostDB;
  end;
  ExtraSellPrice.IterateRecords   (ApplyExtraSellPriceCallback  );
end;
Procedure TfmDataUpdator.ApplySpecialProducts(Product :TProduct)    ;
begin
  if  Clientfrm is TfmDU_SpecialProducts then begin
    SpecialProducts.IterateRecords   (ApplySpecialProductListCallback  );
  end;
end;
Procedure TfmDataUpdator.ApplyExtraFxSellPrice(Product :TProduct)  ;
begin
    ExtraFxSellPrice.IterateRecords (ApplyExtraFxSellPriceCallback);
end;
Function TfmDataUpdator.UseRegionCountry:Boolean;
begin
  REsult:= False;
  if  Clientfrm is TfmDU_Client then
    result := TfmDU_Client(Clientfrm).chkUseRegionCountry.Checked;
end;
procedure TfmDataUpdator.AfterFormShow;
begin
  inherited;
  REfreshallPages;
end;

procedure TfmDataUpdator.ApplyClientProperties(Clientobj :Tclient);
var
  aPhoneNumber :String;
  Countryname:String;
begin
  if  Clientfrm is TfmDU_Client then begin
    With TfmDU_Client(Clientfrm) do begin
      if chkClient.Checked then begin
          Countryname:= '';
               if (optclient.ItemIndex =0) and (trim(Clientobj.Country)     <>'')  then  Countryname:= trim(Clientobj.Country)
          else if (optclient.ItemIndex =1) and (trim(Clientobj.Billcountry) <>'')  then  Countryname:= trim(Clientobj.Billcountry)
          else if (optclient.ItemIndex =0) and (trim(Clientobj.Country)     = '')  then  LogError('Client Properties' ,Clientobj.clientname ,'Country name missing' )
          else if (optclient.ItemIndex =1) and (trim(Clientobj.Billcountry) = '')  then  LogError('Client Properties' ,Clientobj.clientname ,'Bill country name missing' );

          if Countryname = '' then
            if (UseRegionCountry )  then  Countryname:= trim(Appenv.RegionalOptions.CountryName);

        if Countryname = '' then exit;

        aPhoneNumber:=formatMobileno(Clientobj.ClientName, Clientobj.Mobile , Countryname , TMyConnection(Clientobj.Connection.Connection), 'Client');
        if (aPhoneNumber = Clientobj.Mobile) and  (UseRegionCountry) then
          aPhoneNumber:=formatMobileno(Clientobj.ClientName, Clientobj.Mobile , trim(Appenv.RegionalOptions.CountryName) , TMyConnection(Clientobj.Connection.Connection), 'Client');

        if aPhoneNumber <> Clientobj.Mobile then begin
          Clientobj.Mobile := aPhoneNumber;
          Clientobj.PostDb;
          if Idsdone <> '' then Idsdone := Idsdone +',';
          Idsdone := Idsdone +inttostr(Clientobj.ID);
          LogError('Client Properties' ,Clientobj.clientname , 'Mobile number updated with the country code ' + Quotedstr(aPhoneNumber) );
        end;
      end;
    end;
  end else if  Clientfrm is TfmDU_CustomerSpecialPrice then begin
    with TfmDU_CustomerSpecialPrice(Clientfrm) do begin
      if  chkupdateSpecialPrice.Checked then begin
          Clientobj.SpecialProducts.Iteraterecords(ApplySpecialProductsCallback);
      end;
    end;
  end;
end;

Procedure TfmDataUpdator.ApplySpecialProductsCallback(Const Sender: TBusObj; var Abort: boolean);
var
  fdValue:double;
  fiCode:Integer;
begin
  if not(sender is TSpecialProducts) then exit;

  if  Clientfrm is TfmDU_CustomerSpecialPrice then begin
    With TfmDU_CustomerSpecialPrice(Clientfrm) do begin
        Val(edtupdateSpecialPrice.Text     , fdValue, fiCode); fdspecialPrice :=fdValue;
        if chkupdateSpecialPrice.Checked then begin
          if (OptupdateSpecialPriceOption.itemindex =0) and (OptupdateSpecialPricetype.itemindex=0) then begin
            if (TSpecialProducts(Sender).LinePrice=0) then else TSpecialProducts(Sender).LinePrice := TSpecialProducts(Sender).LinePrice  + (TSpecialProducts(Sender).LinePrice *fdspecialPrice/100);
          end else if (OptupdateSpecialPriceOption.itemindex =1) and (OptupdateSpecialPricetype.itemindex=0) then begin
            if (TSpecialProducts(Sender).LinePrice=0) then else TSpecialProducts(Sender).LinePrice := TSpecialProducts(Sender).LinePrice  - (TSpecialProducts(Sender).LinePrice *fdspecialPrice/100);
          end else if (OptupdateSpecialPriceOption.itemindex =0) and (OptupdateSpecialPricetype.itemindex=1) then begin
            TSpecialProducts(Sender).LinePrice := TSpecialProducts(Sender).LinePrice  + fdspecialPrice;
          end else if (OptupdateSpecialPriceOption.itemindex =1) and (OptupdateSpecialPricetype.itemindex=1) then begin
            TSpecialProducts(Sender).LinePrice := TSpecialProducts(Sender).LinePrice  - fdspecialPrice;
          end else if (OptupdateSpecialPriceOption.itemindex =2) then begin
            TSpecialProducts(Sender).LinePrice :=   fdspecialPrice;
          end;
        end;
    end;
  end;
end;
procedure TfmDataUpdator.ApplyContactProperties(Cotnactobj: Tcontact);
var
  aPhoneNumber:String;
begin
  if  Clientfrm is TfmDU_Client then begin
    With TfmDU_Client(Clientfrm) do begin
      if chkUpdatecontacts.Checked then begin
        aPhoneNumber:=formatMobileno(Cotnactobj.contactfullname,  Cotnactobj.ContactMOB , Cotnactobj.ContactCountry , TMyConnection(Cotnactobj.Connection.Connection), 'Contact');
        if (aPhoneNumber = Cotnactobj.ContactMOB ) and  (UseRegionCountry) then
          aPhoneNumber:=formatMobileno(Cotnactobj.contactfullname,  Cotnactobj.ContactMOB , trim(Appenv.RegionalOptions.CountryName) , TMyConnection(Cotnactobj.Connection.Connection), 'Contact');

        if aPhoneNumber <> Cotnactobj.ContactMOB then begin
          Cotnactobj.ContactMOB := aPhoneNumber;
          Cotnactobj.PostDb;
          if Idsdone <> '' then Idsdone := Idsdone +',';
          Idsdone := Idsdone +inttostr(Cotnactobj.ID);
          LogError('Contact Properties' ,Cotnactobj.contactfullname , 'Mobile number updated with the country code ' + Quotedstr(aPhoneNumber) );
        end;
      end else if chkMakecontact.Checked then begin

      end;
    end;
  end;
end;

Procedure TfmDataUpdator.ApplyExtraBuyPrice(Product :TProduct)     ;
begin
    ExtraBuyPrice.IterateRecords    (ApplyExtraBuyPricecallback   );
end;
Procedure TfmDataUpdator.ApplyExtraFxBuyPrice(Product :TProduct)   ;
begin
    ExtraFxBuyPrice.IterateRecords  (ApplyExtraFxBuyPriceCallback );
end;

Procedure TfmDataUpdator.ApplyExtraSellPriceCallback(Const Sender: TBusObj; var Abort: boolean);
var
  UOMID:Integer;
  extrasellpriceID:Integer;
begin
  if not(sender is TDataupdatorExtraSellPrice) then exit;

  if TDataupdatorExtraSellPrice(sender).ValidateData =False then begin
    LogError('Extra Sell Price' , KeyString ,TDataupdatorExtraSellPrice(sender).ResultStatus.GetLastFatalStatusItem.Message);
    exit;
  end;
  if Idsdone <> '' then Idsdone := Idsdone +',';
  Idsdone := Idsdone + inttostr(TDataupdatorExtraSellPrice(sender).ID);

  UOMID := 0;
  if TDataupdatorExtraSellPrice(sender).UOMName <> '' then begin
    UOMID := TUnitOfMeasure.CreateNewUOM(TDataupdatorExtraSellPrice(Sender), Products.ID,TDataupdatorExtraSellPrice(sender).UOMName, TDataupdatorExtraSellPrice(sender).Connection );
    if UOMID = 0 then begin
      LogError('Extra Sell Price' , KeyString ,'Failted to create Unit of Meassure ' + Quotedstr(TDataupdatorExtraSellPrice(sender).UOMName)+' for product '+quotedstr(Products.ProductName) );
      exit;
    end;
  end;

  extrasellpriceID:= TProductExtraSellPrice.ExtraSellID(TDataupdatorExtraSellPrice(sender).Terms, 0, TDataupdatorExtraSellPrice(sender).ClientTypeID, Products.Id, UOMID, TDataupdatorExtraSellPrice(sender).DateFrom, TDataupdatorExtraSellPrice(sender).DateTo, TDataupdatorExtraSellPrice(sender).AllClients, TDataupdatorExtraSellPrice(sender).Connection.Connection) ;
  With Products.getNewdataset('Select * from tblExtraPriceSell ' +
          ' where   ((ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorExtraSellPrice(sender).DateFrom)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorExtraSellPrice(sender).DateFrom)) +' ) '+
          ' Or       (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorExtraSellPrice(sender).DateTo)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorExtraSellPrice(sender).DateTo)) +'  )'+
          ' Or       (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') >=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorExtraSellPrice(sender).DateFrom)) +'  and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')<=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorExtraSellPrice(sender).DateTo)) +'  ))'+
          ' and       ifnull(UOMID,0)= '+IntToStr(UOMID) +
          ' and       ifnull(ClienttypeID,0)='+IntToStr(TDataupdatorExtraSellPrice(sender).ClientTypeID) +
          ' and       ifnull(PartsID,0)='+IntToStr(Products.ID)+
          '  and PriceID <> '+ inttostr(extrasellpriceID), true) do try

      if recordcount>0 then begin
        LogError('Extra Sell Price' , KeyString ,'An Extra Sell Price already exists for this product with these settings' );
        exit;
      end;
  finally
    if active then close;
  end;

  if extrasellpriceID =0 then begin
    if TDataupdatorExtraSellPrice(sender).VariationOption <> 'U' then begin
      exit; // increase or decrease is only for the existing records
    end;
    Products.ExtraSellPrice.New;
    Products.ExtraSellPrice.ClientTypeID := TDataupdatorExtraSellPrice(sender).ClientTypeID;
    Products.ExtraSellPrice.ProductId    := Products.ID;
    Products.ExtraSellPrice.UOMID        := Uomid;
    Products.ExtraSellPrice.DateFrom     := TDataupdatorExtraSellPrice(sender).DateFrom;
    Products.ExtraSellPrice.DateTo       := TDataupdatorExtraSellPrice(sender).DateTo;
    Products.ExtraSellPrice.AllClients   := TDataupdatorExtraSellPrice(sender).AllClients;
  end else begin
    Products.ExtraSellPrice.locate(Products.ExtraSellPrice.IDFieldName , extrasellpriceID , []);
  end;

  if TDataupdatorExtraSellPrice(sender).VariationOption = 'U' then begin
    if TDataupdatorExtraSellPrice(sender).QtyPercent1 <> 0 then
          Products.ExtraSellPrice.QtyPercent1 := TDataupdatorExtraSellPrice(sender).QtyPercent1
    else  Products.ExtraSellPrice.Price1 := TDataupdatorExtraSellPrice(sender).Price1;
    Products.ExtraSellPrice.ExtraSellDescription := TDataupdatorExtraSellPrice(sender).ExtraSellDescription;
  end else if TDataupdatorExtraSellPrice(sender).VariationOption = 'I' then begin
    if TDataupdatorExtraSellPrice(sender).Variationtype ='P' then begin
      Products.ExtraSellPrice.QtyPercent1 := Products.ExtraSellPrice.QtyPercent1 + TDataupdatorExtraSellPrice(sender).VariationAmt;
      if Products.ExtraSellPrice.QtyPercent1 >100 then Products.ExtraSellPrice.QtyPercent1:= 100;
      if Products.ExtraSellPrice.QtyPercent1 <0 then Products.ExtraSellPrice.QtyPercent1:= 0;
    end else begin
      Products.ExtraSellPrice.Price1 := Products.ExtraSellPrice.Price1 - TDataupdatorExtraSellPrice(sender).VariationAmt;
      if Products.ExtraSellPrice.Price1 <0 then Products.ExtraSellPrice.Price1 := 0;
    end;
  end else if TDataupdatorExtraSellPrice(sender).VariationOption = 'D' then begin
    if TDataupdatorExtraSellPrice(sender).Variationtype ='P' then begin
      Products.ExtraSellPrice.QtyPercent1 := Products.ExtraSellPrice.QtyPercent1 - TDataupdatorExtraSellPrice(sender).VariationAmt;
      if Products.ExtraSellPrice.QtyPercent1 >100 then Products.ExtraSellPrice.QtyPercent1:= 100;
      if Products.ExtraSellPrice.QtyPercent1 <0 then Products.ExtraSellPrice.QtyPercent1:= 0;
    end else begin
      Products.ExtraSellPrice.Price1 := Products.ExtraSellPrice.Price1  + TDataupdatorExtraSellPrice(sender).VariationAmt;
      if Products.ExtraSellPrice.Price1 <0 then Products.ExtraSellPrice.Price1 := 0;
    end;
  end;
  Products.ExtraSellPrice.ExtraSellDescription := TDataupdatorExtraSellPrice(sender).ExtraSellDescription;
  Products.ExtraSellPrice.PostDB;
end;
Procedure TfmDataUpdator.ApplySpecialProductListCallback(Const Sender: TBusObj; var Abort: boolean);
var
  UOMID:Integer;
  SpecialProductsID:Integer;
begin
  if not(sender is TDataupdatorSpecialProducts) then exit;

  if TDataupdatorSpecialProducts(sender).ValidateData =False then begin
    try LogError('Special Product Price' , KeyString ,TDataupdatorSpecialProducts(sender).ResultStatus.GetLastFatalStatusItem.Message); Except end;
    exit;
  end;
  if Idsdone <> '' then Idsdone := Idsdone +',';
  Idsdone := Idsdone + inttostr(TDataupdatorSpecialProducts(sender).ID);

  UOMID := 0;
  if TDataupdatorSpecialProducts(sender).uom <> '' then begin
    UOMID := TUnitOfMeasure.CreateNewUOM(TDataupdatorSpecialProducts(Sender), Products.ID,TDataupdatorSpecialProducts(sender).UOM, TDataupdatorSpecialProducts(sender).Connection );
    if UOMID = 0 then begin
      LogError('Extra Sell Price' , KeyString ,'Failted to create Unit of Meassure ' + Quotedstr(TDataupdatorSpecialProducts(sender).UOM)+' for product '+quotedstr(Products.ProductName) );
      exit;
    end;
  end;

  SpecialProductsID:= TSpecialProducts.SepcialPriceID(0, Customers.ID,
                                                                  TDataupdatorSpecialProducts(sender).ProductId ,
                                                                  TDataupdatorSpecialProducts(sender).UOMID ,
                                                                  TDataupdatorSpecialProducts(sender).DateFrom,
                                                                  TDataupdatorSpecialProducts(sender).DateTo,
                                                                  TDataupdatorSpecialProducts(sender).Connection.Connection) ;

    With Products.getNewdataset('Select * from tblCustomerLines  where CustomerLinesID <> ' + IntToStr(SpecialProductsID)+
                                ' and CustomerId = ' + IntToStr(Customers.ID)+
                                ' and ProductID = ' + IntToStr(TDataupdatorSpecialProducts(sender).ProductID)+
                                ' and UOMID = '     + IntToStr(TDataupdatorSpecialProducts(sender).UOMId)+
                                ' and ((ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorSpecialProducts(sender).DateFrom)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorSpecialProducts(sender).DateFrom)) +' ) '+
                                '    Or (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorSpecialProducts(sender).DateTo)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorSpecialProducts(sender).DateTo)) +'  )'+
                                '    Or (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') >=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorSpecialProducts(sender).DateFrom)) +'  and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')<=' + QuotedStr(FormatDateTime(MysqlDateFormat , TDataupdatorSpecialProducts(sender).DateTo)) +'  ))' ,
                    true) do try
         if recordcount>0 then begin
                LogError('Customer''s Special Price' , KeyString ,'A Customer''s Special Price already exists for this Customer/Product with these settings' );
                exit;
         end;
          finally
            if active then close;
          end;

  if SpecialProductsID =0 then begin
    if TDataupdatorSpecialProducts(sender).VariationOption <> 'U' then begin //update
      exit; // increase or decrease is only for the existing records
    end;
    Clients.SpecialProducts.New;
    Clients.SpecialProducts.CustomerID:= Customers.ID;
    Clients.SpecialProducts.ProductNAme := TDataupdatorSpecialProducts(sender).ProductNAme;
    Clients.SpecialProducts.UOMID        := Uomid;
    if TDataupdatorSpecialProducts(sender).DateFrom <> 0 then Clients.SpecialProducts.DateFrom     := TDataupdatorSpecialProducts(sender).DateFrom;
    if TDataupdatorSpecialProducts(sender).DateTo <> 0 then Clients.SpecialProducts.DateTo       := TDataupdatorSpecialProducts(sender).DateTo;

  end else begin
    Clients.SpecialProducts.locate(Clients.SpecialProducts.IDFieldName , SpecialProductsID , []);
  end;

  if TDataupdatorSpecialProducts(sender).VariationOption = 'U' then begin
    Clients.SpecialProducts.LinePrice := TDataupdatorSpecialProducts(sender).LinePrice;
  end else if TDataupdatorSpecialProducts(sender).VariationOption = 'I' then begin
    if TDataupdatorSpecialProducts(sender).Variationtype ='P' then begin
      Clients.SpecialProducts.LinePrice := Clients.SpecialProducts.LinePrice + Clients.SpecialProducts.LinePrice * TDataupdatorSpecialProducts(sender).VariationAmt/100;
    end else begin
      Clients.SpecialProducts.LinePrice := Clients.SpecialProducts.LinePrice + TDataupdatorSpecialProducts(sender).VariationAmt;
    end;
  end else if TDataupdatorSpecialProducts(sender).VariationOption = 'D' then begin
        if TDataupdatorSpecialProducts(sender).Variationtype ='P' then begin
      Clients.SpecialProducts.LinePrice := Clients.SpecialProducts.LinePrice - Clients.SpecialProducts.LinePrice * TDataupdatorSpecialProducts(sender).VariationAmt/100;
    end else begin
      Clients.SpecialProducts.LinePrice := Clients.SpecialProducts.LinePrice - TDataupdatorSpecialProducts(sender).VariationAmt;
    end;
    if Clients.SpecialProducts.LinePrice <0 then Clients.SpecialProducts.LinePrice := 0;
  end;
  Clients.SpecialProducts.PostDB;
end;
Procedure TfmDataUpdator.ApplyExtraFxSellPriceCallback(Const Sender: TBusObj; var Abort: boolean);
var
  UOMID:Integer;
begin
  if not(sender is TDataUpdatorForeignSellPrice) then exit;

  if TDataUpdatorForeignSellPrice(sender).ValidateData =False then begin
    LogError('Extra Sell Price(Fx)' , KeyString ,TDataUpdatorForeignSellPrice(sender).ResultStatus.GetLastFatalStatusItem.Message);
    exit;
  end;
  if Idsdone <> '' then Idsdone := Idsdone +',';
  Idsdone := Idsdone + inttostr(TDataUpdatorForeignSellPrice(sender).ID);

  UOMID := 0;
  if TDataUpdatorForeignSellPrice(sender).UOMName <> '' then begin
    UOMID := TUnitOfMeasure.CreateNewUOM(TDataUpdatorForeignSellPrice(Sender), Products.ID,TDataUpdatorForeignSellPrice(sender).UOMName, TDataUpdatorForeignSellPrice(sender).Connection );
    if UOMID = 0 then begin
      LogError('Extra Sell Price(Fx)' , KeyString ,'Failted to create Unit of Meassure ' + Quotedstr(TDataUpdatorForeignSellPrice(sender).UOMName)+' for product '+quotedstr(Products.ProductName) );
      exit;
    end;
  end;

  if Products.ForeignPriceSell.Locate('ClientID;ISSellprice;CurrencyID;UOMID;Buy1' , vararrayof([TDataUpdatorForeignSellPrice(sender).ClientID,'T',TDataUpdatorForeignSellPrice(sender).CurrencyId,UOMID,TDataUpdatorForeignSellPrice(sender).Qty1]) , []) then begin
  end else begin
    if TDataUpdatorForeignSellPrice(sender).VariationOption <> 'U' then begin
      exit; // increase or decrease is only for the existing records
    end;
    Products.ForeignPriceSell.New;
    Products.ForeignPriceSell.ProductID:= Products.ID;
    Products.ForeignPriceSell.ClientID:= TDataUpdatorForeignSellPrice(sender).ClientID;
    Products.ForeignPriceSell.IsSellprice := true;
    Products.ForeignPriceSell.CurrencyID:= TDataUpdatorForeignSellPrice(sender).CurrencyID;
    Products.ForeignPriceSell.ProductName := Products.Productname;
    Products.ForeignPriceSell.UOMID:= uomid;
    Products.ForeignPriceSell.Qty1 := TDataUpdatorForeignSellPrice(sender).Qty1;
  end;
  if TDataupdatorExtraSellPrice(sender).VariationOption = 'U' then begin
    Products.ForeignPriceSell.Price1:=TDataUpdatorForeignSellPrice(sender).Price1;
  end else if TDataupdatorExtraSellPrice(sender).VariationOption = 'I' then begin
    if TDataupdatorExtraSellPrice(sender).Variationtype ='P' then begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 +  (Products.ForeignPriceSell.Price1* TDataupdatorExtraSellPrice(sender).VariationAmt/100);
    end else begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 + TDataupdatorExtraSellPrice(sender).VariationAmt;
    end;
    if Products.ForeignPriceSell.Price1 <0 then Products.ForeignPriceSell.Price1 := 0;
  end else if TDataupdatorExtraSellPrice(sender).VariationOption = 'D' then begin
    if TDataupdatorExtraSellPrice(sender).Variationtype ='P' then begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 -  (Products.ForeignPriceSell.Price1* TDataupdatorExtraSellPrice(sender).VariationAmt/100);
    end else begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 - TDataupdatorExtraSellPrice(sender).VariationAmt;
    end;
    if Products.ForeignPriceSell.Price1 <0 then Products.ForeignPriceSell.Price1 := 0;
  end;
  Products.ForeignPriceSell.PostDB;
end;

Procedure TfmDataUpdator.ApplyExtraFxBuyPriceCallback(Const Sender: TBusObj; var Abort: boolean);
var
  UOMID:Integer;
begin
  if not(sender is TDataUpdatorForeignBuyPrice) then exit;

  if TDataUpdatorForeignBuyPrice(sender).ValidateData =False then begin
    LogError('Extra Sell Buy(Fx)' , KeyString ,TDataUpdatorForeignBuyPrice(sender).ResultStatus.GetLastFatalStatusItem.Message);
    exit;
  end;
  if Idsdone <> '' then Idsdone := Idsdone +',';
  Idsdone := Idsdone + inttostr(TDataUpdatorForeignBuyPrice(sender).ID);

  UOMID := 0;
  if TDataUpdatorForeignBuyPrice(sender).UOMName <> '' then begin
    UOMID := TUnitOfMeasure.CreateNewUOM(TDataUpdatorForeignBuyPrice(Sender), Products.ID,TDataUpdatorForeignBuyPrice(sender).UOMName, TDataUpdatorForeignBuyPrice(sender).Connection );
    if UOMID = 0 then begin
      LogError('Extra Sell Buy(Fx)' , KeyString ,'Failted to create Unit of Meassure ' + Quotedstr(TDataUpdatorForeignBuyPrice(sender).UOMName)+' for product '+quotedstr(Products.ProductName) );
      exit;
    end;
  end;

  if Products.ForeignPriceSell.Locate('ClientID;ISSellprice;CurrencyID;UOMID;Buy1' , vararrayof([TDataUpdatorForeignBuyPrice(sender).ClientID,'F',TDataUpdatorForeignBuyPrice(sender).CurrencyId,UOMID,TDataUpdatorForeignBuyPrice(sender).Qty1]) , []) then begin
  end else begin
    if TDataUpdatorForeignBuyPrice(sender).VariationOption <> 'U' then begin
      exit; // increase or decrease is only for the existing records
    end;
    Products.ForeignPriceSell.New;
    Products.ForeignPriceSell.ProductID:= Products.ID;
    Products.ForeignPriceSell.ClientID:= TDataUpdatorForeignBuyPrice(sender).ClientID;
    Products.ForeignPriceSell.IsSellprice := False;
    Products.ForeignPriceSell.CurrencyID:= TDataUpdatorForeignBuyPrice(sender).CurrencyID;
    Products.ForeignPriceSell.ProductName := Products.Productname;
    Products.ForeignPriceSell.UOMID:= uomid;
    Products.ForeignPriceSell.Qty1 := TDataUpdatorForeignBuyPrice(sender).Qty1;
  end;
  if TDataUpdatorForeignBuyPrice(sender).VariationOption = 'U' then begin
    Products.ForeignPriceSell.Price1:=TDataUpdatorForeignBuyPrice(sender).Price1;
  end else if TDataUpdatorForeignBuyPrice(sender).VariationOption = 'I' then begin
    if TDataUpdatorForeignBuyPrice(sender).Variationtype ='P' then begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 +  (Products.ForeignPriceSell.Price1* TDataUpdatorForeignBuyPrice(sender).VariationAmt/100);
    end else begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 + TDataUpdatorForeignBuyPrice(sender).VariationAmt;
    end;
    if Products.ForeignPriceSell.Price1 <0 then Products.ForeignPriceSell.Price1 := 0;
  end else if TDataUpdatorForeignBuyPrice(sender).VariationOption = 'D' then begin
    if TDataUpdatorForeignBuyPrice(sender).Variationtype ='P' then begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 -  (Products.ForeignPriceSell.Price1* TDataUpdatorForeignBuyPrice(sender).VariationAmt/100);
    end else begin
      Products.ForeignPriceSell.Price1 := Products.ForeignPriceSell.Price1 - TDataUpdatorForeignBuyPrice(sender).VariationAmt;
    end;
    if Products.ForeignPriceSell.Price1 <0 then Products.ForeignPriceSell.Price1 := 0;
  end;
  Products.ForeignPriceSell.PostDB;
end;

Procedure TfmDataUpdator.ApplyExtraBuyPriceCallback(Const Sender: TBusObj; var Abort: boolean);
var
  UOMID:Integer;
begin
  if not(sender is TDataUpdatorExtraBuyPrice) then exit;

  if TDataUpdatorExtraBuyPrice(sender).ValidateData =False then begin
    LogError('Extra Sell Buy' , KeyString ,TDataUpdatorExtraBuyPrice(sender).ResultStatus.GetLastFatalStatusItem.Message);
    exit;
  end;
  if Idsdone <> '' then Idsdone := Idsdone +',';
  Idsdone := Idsdone + inttostr(TDataUpdatorExtraBuyPrice(sender).ID);

  UOMID := 0;
  if TDataUpdatorExtraBuyPrice(sender).UOMName <> '' then begin
    UOMID := TUnitOfMeasure.CreateNewUOM(TDataUpdatorExtraBuyPrice(Sender), Products.ID,TDataUpdatorExtraBuyPrice(sender).UOMName, TDataUpdatorExtraBuyPrice(sender).Connection );
    if UOMID = 0 then begin
      LogError('Extra Sell Buy' , KeyString ,'Failted to create Unit of Meassure ' + Quotedstr(TDataUpdatorForeignBuyPrice(sender).UOMName)+' for product '+quotedstr(Products.ProductName) );
      exit;
    end;
  end;

  if Products.ExtraBuyPrice.Locate('SupplierID;UOMID;buy1' , vararrayof([TDataUpdatorExtraBuyPrice(sender).SupplierId,UOMID,TDataUpdatorExtraBuyPrice(sender).BuyQty1]) , []) then begin
  end else begin
    if TDataUpdatorExtraBuyPrice(sender).VariationOption <> 'U' then begin
      exit; // increase or decrease is only for the existing records
    end;
    Products.ExtraBuyPrice.New;
    Products.ExtraBuyPrice.ProductID:= Products.ID;
    Products.ExtraBuyPrice.ProductName:= Products.ProductName;
    Products.ExtraBuyPrice.SupplierId:= TDataUpdatorExtraBuyPrice(sender).SupplierID;
    Products.ExtraBuyPrice.UsePrice:= TDataUpdatorExtraBuyPrice(sender).UsePrice;
    Products.ExtraBuyPrice.UOMID:= UOMID;
    Products.ExtraBuyPrice.MinimumOrderQty := TDataUpdatorExtraBuyPrice(sender).MinimumOrderQty;
    Products.ExtraBuyPrice.PrintedValue1 := TDataUpdatorExtraBuyPrice(sender).PrintedValue1;
  end;
  if TDataUpdatorExtraBuyPrice(sender).VariationOption = 'U' then begin
    Products.ExtraBuyPrice.BuyQty1Price:=TDataUpdatorExtraBuyPrice(sender).BuyQty1Price;
  end else if TDataUpdatorExtraBuyPrice(sender).VariationOption = 'I' then begin
    if TDataUpdatorExtraBuyPrice(sender).Variationtype ='P' then begin
      Products.ExtraBuyPrice.BuyQty1Price := Products.ExtraBuyPrice.BuyQty1Price +  (Products.ExtraBuyPrice.BuyQty1Price* TDataUpdatorExtraBuyPrice(sender).VariationAmt/100);
    end else begin
      Products.ExtraBuyPrice.BuyQty1Price := Products.ExtraBuyPrice.BuyQty1Price + TDataUpdatorExtraBuyPrice(sender).VariationAmt;
    end;
    if Products.ExtraBuyPrice.BuyQty1Price <0 then Products.ExtraBuyPrice.BuyQty1Price := 0;
  end else if TDataUpdatorExtraBuyPrice(sender).VariationOption = 'D' then begin
    if TDataUpdatorExtraBuyPrice(sender).Variationtype ='P' then begin
      Products.ExtraBuyPrice.BuyQty1Price := Products.ExtraBuyPrice.BuyQty1Price -  (Products.ExtraBuyPrice.BuyQty1Price* TDataUpdatorExtraBuyPrice(sender).VariationAmt/100);
    end else begin
      Products.ExtraBuyPrice.BuyQty1Price := Products.ExtraBuyPrice.BuyQty1Price - TDataUpdatorExtraBuyPrice(sender).VariationAmt;
    end;
    if Products.ExtraBuyPrice.BuyQty1Price <0 then Products.ExtraBuyPrice.BuyQty1Price := 0;
  end;
  Products.ExtraBuyPrice.PostDB;

end;

procedure TfmDataUpdator.ApplyExtraBuyPriceToDelete(Product: TProduct);
var
  s:STring;
  fsfilter:String;
begin
  s:= frmDeleteExtraBuyPrice.EntriesSelected(Product.Id);
  if s<> '' then begin
    s:= 'ExtraPartPriceId = ' + replacestr(s , ',' , ' Or ExtraPartPriceId = ' );
    try
      fsfilter:=trim(Product.ExtraBuyPrice.filter);
      if fsFilter <> '' then s:= '(' + fsfilter +') and (' + s +')';
      Product.ExtraBuyPrice.Filter := s;
      Product.ExtraBuyPrice.Filtered:= TRue;
      if Idsdone <> '' then Idsdone := Idsdone +',';
      Idsdone := Idsdone +Product.ExtraBuyPrice.AllIds;
      Product.ExtraBuyPrice.DeleteAll;
    finally
      Product.ExtraBuyPrice.Filter:= fsfilter;
      Product.ExtraBuyPrice.Filtered:= fsfilter <> '';
    end;
  end;
end;

procedure TfmDataUpdator.btnAdjQtyClick(Sender: TObject);begin  inherited;  try fsSizemode:= 'N';DoFormSize(False);OpenERPForm('TFmProductQtyAdjOptions' , 0);  closeWait;except end;  end;
procedure TfmDataUpdator.btnAdjUOMClick(Sender: TObject);begin  inherited;  try fsSizemode:= 'N';DoFormSize(False);OpenERPForm('TfmAdjustUOM'            , 0);  closeWait;except end; end;
procedure TfmDataUpdator.btnUOMlistClick(Sender: TObject);begin inherited;  try fsSizemode:= 'N';DoFormSize(False);OpenErpListform('TUOMListGUI'            );  closeWait;except end; end;

function TfmDataUpdator.MiscDataUpdateForm: TfmDU_MiscDataUpdates;
begin
  if frmMiscDataUpdate  = nil then begin
    frmMiscDataUpdate := TfmDU_MiscDataUpdates(TfmDU_MiscDataUpdates.Makeinstance(self, pnlMiscDataupdateMain));
    frmMiscDataUpdate.openQueries;
  end;
  result:=frmMiscDataUpdate ;
end;
procedure TfmDataUpdator.setMiscDataUpdatePageIndex(const Value: Integer);
var
  cmp:Tcomponent;
begin
  cmp:= Findcomponent('MiscDataUpdatebutton'+ inttostr(Value));
  if Assigned(cmp) and (cmp is TDNMSpeedButton) then
    MiscDataUpdateMainbtnclick(cmp);
  fiMiscDataUpdatePageIndex := Value;
end;
procedure TfmDataUpdator.DoMiscDataUpdate;
begin
  if frmUOMMismatchlist = nil then exit;
  TDU_UOMMismatchGUI(frmUOMMismatchlist).UOMMismatchFix;
end;
procedure TfmDataUpdator.MiscDataUpdateMainbtnclick(Sender: TObject);
begin
  inherited;
  if not(Sender is TDNMSpeedButton) then exit;
  if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , MiscDataUpdateButtonCaptions[cMiscDataUpdateProperties]) then begin
    if fiMiscDataUpdatePageIndex = cMiscDataUpdateProperties then exit;// page not changed
    if MiscDataUpdatefrm <> nil then MiscDataUpdatefrm.pnlMain.Visible:= False;
    fiMiscDataUpdatePageIndex := cMiscDataUpdateProperties;
    MiscDataUpdatefrm:= MiscDataUpdateForm;
  end;
  SetUpdatehint;
  MiscDataUpdatefrm.pnlMain.Visible:= TRue;
  MiscDataUpdatefrm.ShowFormHint;
  SLErrorlog.clear;
  lblViewUpdateLog.visible := False;
end;
function TfmDataUpdator.getMiscDataUpdateSplitAt: Integer;
begin
  result:= splMiscDataUpdate.top;
end;
procedure TfmDataUpdator.setMiscDataUpdateSplitAt(const Value: Integer);
var
  iValue:Integer;
begin
  iValue:= Value;
  if(iValue>400) then ivalue:= 400 else if iValue< 150 then iValue:= 150;
  pnlMiscdataUpdate.height := iValue;
end;
{Proc resource}
procedure TfmDataUpdator.OpenProcResourceList;
begin
  if frmProcResList = nil then begin
    CreateHistorylistform('TfmProcResourceList' ,Self, frmProcResList);
    frmProcResList.OnGidMultiselect := OnProcResMultiSelect;
    frmProcResList.EnableMultiselect('Please Select Resource(s) to be updated');
    frmProcResList.Parent := pnlProcRes;
    frmProcResList.borderstyle := bsNone;
    TfmProcResourceList(frmProcResList).grpExtraFilters.itemindex := 0;
    TfmProcResourceList(frmProcResList).grpExtraFilters.visible := false;
    TfmProcResourceList(frmProcResList).grpFilters.itemindex := 2;
    frmProcResList.grpFilters.visible := false;

    frmProcResList.Show;
    with TfmProcResourceList(frmProcResList) do begin
      grdMain.PopupMenu          := mnuFilter;
    end;
 end;
end;
Procedure TfmDataUpdator.ProcResMainbtnclick(Sender: TObject);
begin
  if not(Sender is TDNMSpeedButton) then exit;

  if Sametext(EnglishCaption(TDNMSpeedButton(Sender)) , ProcResButtonCaptions[cProcResProperties]) then begin
    if fiProcResPageIndex = cProcResProperties then exit;// page not changed
    if ProcResfrm <> nil then ProcResfrm.pnlMain.Visible:= False;
    fiProcResPageIndex := cProcResProperties;
    ProcResfrm:= ProcResPropertiesform;
  end;
  SetUpdatehint;
  ProcResfrm.pnlMain.Visible:= TRue;
  ProcResfrm.ShowFormHint;
  SLErrorlog.clear;
  lblViewUpdateLog.visible := False;

end;
procedure TfmDataUpdator.setProcResPageIndex(const Value: Integer);
var
  cmp:Tcomponent;
begin
  cmp:= Findcomponent('ProcResButton'+ inttostr(Value));
  if Assigned(cmp) and (cmp is TDNMSpeedButton) then
    ProcResMainbtnclick(cmp);
  fiProcResPageIndex := Value;
end;
Procedure TfmDataUpdator.CheckProcRes;
begin
  showProgressbar(WAITMSG , 4);
  try
    if assigned(frmProcResList) then begin
      if fbProcResSelectionChanged then begin
        fsProcResourcesinList         := '%';
        fsProcResourcesinList := frmProcResList.SelectedIDs('ProcResourceId' , True);StepProgressbar;
        fbProcResSelectionChanged:= False;
      end;
    end;
  finally
    HideProgressbar;
  end;

end;
Procedure TfmDataUpdator.ApplyProcResourceProperties(ProcResourceObj :TProcResource);
begin
  if ProcResfrm is TfmDU_ProcResource then begin
    if TfmDU_ProcResource(ProcResfrm).chkupdateHourlyRate.checked then
       ProcResourceObj.HourlyLabourRate := TfmDU_ProcResource(ProcResfrm).HourlyRate
    else if TfmDU_ProcResource(ProcResfrm).chkMakeRate0.checked then
      ProcResourceObj.HourlyLabourRate := 0
    else exit;
    ProcResourceObj.Postdb;
  end;
end;
procedure TfmDataUpdator.CompletedProcResUpdate;
begin
      ValidateSelection;
      if ProcResPageIndex = cProcResProperties then begin
          CheckProcRes;
          if MessageDlgXP_Vista('You are about to update the ' + inttostr(ProcResources.count) +' selected Resources'' Hourly Rate to ' + FloatToStrf(ProcresPropertiesForm.HourlyRate, ffGeneral,15,2)+'.' +NL+
                           'Data entered in any other page will not be processed.'+NL +
                           'Are you sure to update these?' , mtconfirmation , [mbyes,mbno] , 0) = mrNo then exit;
        DoUpdate;
      end;
end;

Procedure TfmDataUpdator.DoProcresourceUpdate;
begin
    ProcResources.IterateRecords(DoUpdateCallback);
    CommitTransaction;
    ProcResources.UserLock.UnlockAllCurrentInstance;

end;
function TfmDataUpdator.ProcResPropertiesForm: TfmDU_ProcResource;
begin
  if frmProcResProperties  = nil then begin
    frmProcResProperties := TfmDU_ProcResource(TfmDU_ProcResource.Makeinstance(self, pnlProcResMain));
    frmProcResProperties.openQueries;
  end;
  result:=frmProcResProperties ;
end;
Function TfmDataUpdator.ProcResources :TProcResource;
var
  ssql:String;
begin
  if fsProcResourcesinList ='' then fsProcResourcesinList :=  '0';
  if not Assigned(fProcResources) then begin
      fProcResources := TProcResource.Create(self);
      fProcResources.Connection := DataConnection;
      fProcResources.DoFieldChangewhenDisabled := True; // iterate records disables the control and doesn't fire dofield onchange
  end;
  if updateoption =100 then  {all Clients in the list}
    if fsProcResourcesinList ='%' then ssql := ' ProcResourceId like ''%'''
    else ssql := ' ProcResourceId in (' + fsProcResourcesinList +')'
  else {Selected Clients in the list}
    ssql:=  ' ProcResourceId in (' + fsProcResourcesinList +')';

  if SameText(fProcResources.SQLSelect , ssql) and (fProcResources.datasetAssigned) and (fProcResources.dataset.Active) then
  else fProcResources.LoadSelect(ssql);

  Result:=fProcResources;

end;
function TfmDataUpdator.getProcResSplitAt: Integer;
begin
  result:= splProcResButtons.top;
end;
procedure TfmDataUpdator.setProcResSplitAt(const Value: Integer);
var
  iValue:Integer;
begin
  iValue:= Value;
  if(iValue>400) then ivalue:= 400 else if iValue< 150 then iValue:= 150;
  pnlProcRes.height := iValue;
end;
procedure TfmDataUpdator.OnProcResMultiSelect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  fbProcResSelectionChanged :=True;
end;
Procedure TfmDataUpdator.ValidateProcResSelection;
begin
  if fiProcResPageIndex = cProcResProperties then begin
    if assigned(ProcResfrm) and (ProcResfrm is TfmDU_ProcResource) then begin
      With TfmDU_ProcResource(ProcResfrm) do begin
        if chkMakeRate0.checked then
        else if chkupdateHourlyRate.checked then begin
          if HourlyRate=0 then begin
            LogError('Selection','Update Hourly Rate' , 'The Rate to update with is 0');
            chkupdateHourlyRate.checked  := False;
          end;
        end;
      end;
    end;
  end;


end;


initialization
  RegisterClassOnce(TfmDataUpdator);
end.

