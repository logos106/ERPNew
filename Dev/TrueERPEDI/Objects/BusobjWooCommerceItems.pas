unit BusobjWooCommerceItems;

interface


uses BusObjBase, DB, Classes, XMLDoc, JSONObject, XMLIntf;


type

  TOnWooCommProductCreate = Procedure (Const WooProductID :Integer; Productname:String) of Object;

  TwoocommerceproductBase = class(TMSBusObj)
  Private
    function GetWooID            : Integer   ;
    procedure SetWooID            (const Value: Integer   );
  Protected
  Public
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
  published
    property WooID             :Integer     read GetWooID           write SetWooID        ;
  end;

  TwoocommerceSubproductBase = class(TwoocommerceproductBase)
  Private
    function GetProductID            : Integer   ;
    procedure SetProductID            (const Value: Integer   );
  Protected
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  Public
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
  published
    property ProductID             :Integer     read GetProductID           write SetProductID        ;
  end;

  Twoocommerceproductmetadata = class(TwoocommerceSubproductBase)
  private
    function Getmetadatakey          : string    ;
    function Getmetadatavalue        : string    ;
    procedure Setmetadatakey          (const Value: string    );
    procedure Setmetadatavalue        (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property metadatakey           :string      read Getmetadatakey         write Setmetadatakey      ;
    property metadatavalue         :string      read Getmetadatavalue       write Setmetadatavalue    ;
  end;
  Twoocommerceproductimages = class(TwoocommerceSubproductBase)
  private
    function Getdate_created         : TDateTime ;
    function Getdate_created_gmt     : TDateTime ;
    function Getdate_modified        : TDateTime ;
    function Getdate_modified_gmt    : TDateTime ;
    function Getsrc                  : string    ;
    function GetImageName            : string    ;
    function Getalt                  : string    ;
    procedure Setdate_created         (const Value: TDateTime );
    procedure Setdate_created_gmt     (const Value: TDateTime );
    procedure Setdate_modified        (const Value: TDateTime );
    procedure Setdate_modified_gmt    (const Value: TDateTime );
    procedure Setsrc                  (const Value: string    );
    procedure SetImageName            (const Value: string    );
    procedure Setalt                  (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property date_created          :TDateTime   read Getdate_created        write Setdate_created     ;
    property date_created_gmt      :TDateTime   read Getdate_created_gmt    write Setdate_created_gmt ;
    property date_modified         :TDateTime   read Getdate_modified       write Setdate_modified    ;
    property date_modified_gmt     :TDateTime   read Getdate_modified_gmt   write Setdate_modified_gmt;
    property src                   :string      read Getsrc                 write Setsrc              ;
    property ImageName             :string      read GetImageName           write SetImageName        ;
    property alt                   :string      read Getalt                 write Setalt              ;
  end;
  TwoocommerceproductDownLoads = class(TwoocommerceSubproductBase)
  private
    function GetDownLoadName : string    ;
    function GetDownloadFile : string    ;
    procedure SetDownLoadName (const Value: string    );
    procedure SetDownloadFile (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property DownLoadName  :string      read GetDownLoadName  write SetDownLoadName     ;
    property DownloadFile  :string      read GetDownloadFile  write SetDownloadFile     ;
  end;
 Twoocommerceproductdefattribs = class(TwoocommerceSubproductBase)
  private
    function GetDefattribName         : string    ;
    procedure SetDefattribName         (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property DefattribName          :string      read GetDefattribName        write SetDefattribName     ;
  end;
  Twoocommerceproductdimension = class(TMSBusObj)
  private
    function Getlength       : string    ;
    function Getwidth        : string    ;
    function Getheight       : string    ;
    procedure Setlength       (const Value: string    );
    procedure Setwidth        (const Value: string    );
    procedure Setheight       (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property length        :string      read Getlength      write Setlength   ;
    property width         :string      read Getwidth       write Setwidth    ;
    property height        :string      read Getheight      write Setheight   ;
  end;

Twoocommerceproductcategories = class(TwoocommerceSubproductBase)
  private
    function GetcategoryName         : string    ;
    function Getslug         : string    ;
    procedure SetcategoryName         (const Value: string    );
    procedure Setslug         (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property categoryName          :string      read GetcategoryName        write SetcategoryName     ;
    property slug          :string      read Getslug        write Setslug     ;
  end;
Twoocommerceproductattribs = class(TwoocommerceSubproductBase)
  private
    function GetAttribName         : string    ;
    function Getposition     : Integer   ;
    function Getvisible      : Boolean   ;
    function Getvariation    : Boolean   ;
    procedure SetAttribName         (const Value: string    );
    procedure Setposition     (const Value: Integer   );
    procedure Setvisible      (const Value: Boolean   );
    procedure Setvariation    (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property AttribName          :string      read GetAttribName        write SetAttribName     ;
    property position      :Integer     read Getposition    write Setposition ;
    property visible       :Boolean     read Getvisible     write Setvisible  ;
    property variation     :Boolean     read Getvariation   write Setvariation;
  end;
  Twoocommerceproducttags = class(TwoocommerceSubproductBase)
  private
    function GetTagName                     : string    ;
    function Getslug                     : string    ;
    procedure SetTagName                     (const Value: string    );
    procedure Setslug                     (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property TagName                      :string      read GetTagName                    write SetTagName                 ;
    property slug                      :string      read Getslug                    write Setslug                 ;
  end;

  Twoocommerceproducts = class(TwoocommerceproductBase)
  private
    function GetProductname              : string    ;
    function Getslug                     : string    ;
    function Getpermalink                : string    ;
    function Getdate_created             : TDateTime ;
    function Getdate_created_gmt         : TDateTime ;
    function Getdate_modified            : TDateTime ;
    function Getdate_modified_gmt        : TDateTime ;
    function GetProducttype              : string    ;
    function GetProductstatus            : string    ;
    function Getfeatured                 : Boolean   ;
    function Getcatalog_visibility       : string    ;
    function Getdescription              : string    ;
    function Getshort_description        : string    ;
    function Getsku                      : string    ;
    function Getprice                    : string    ;
    function Getregular_price            : string    ;
    function Getsale_price               : string    ;
    function Getdate_on_sale_from        : TDateTime ;
    function Getdate_on_sale_from_gmt    : TDateTime ;
    function Getdate_on_sale_to          : TDateTime ;
    function Getdate_on_sale_to_gmt      : TDateTime ;
    function Getprice_html               : string    ;
    function Geton_sale                  : Boolean   ;
    function Getpurchasable              : Boolean   ;
    function Gettotal_sales              : Integer   ;
    function Getproductvirtual           : Boolean   ;
    function Getdownloadable             : Boolean   ;
    function Getdownload_limit           : Integer   ;
    function Getdownload_expiry          : Integer   ;
    function Getexternal_url             : string    ;
    function Getbutton_text              : string    ;
    function Gettax_status               : string    ;
    function Gettax_class                : string    ;
    function Getmanage_stock             : Boolean   ;
    function Getstock_quantity           : Integer   ;
    function Getstock_status             : string    ;
    function Getbackorders               : string    ;
    function Getbackorders_allowed       : Boolean   ;
    function Getbackordered              : Boolean   ;
    function Getsold_individually        : Boolean   ;
    function Getweight                   : string    ;
    function Getshipping_required        : Boolean   ;
    function Getshipping_taxable         : Boolean   ;
    function Getshipping_class           : string    ;
    function Getshipping_class_ID        : Integer   ;
    function Getreviews_allowed          : Boolean   ;
    function Getaverage_rating           : string    ;
    function Getrating_count             : Integer   ;
    function Getparent_ID                : Integer   ;
    function Getpurchase_note            : string    ;
    function Getmenu_order               : Integer   ;
    function GetERPProductId             : Integer   ;
    procedure SetProductname              (const Value: string    );
    procedure Setslug                     (const Value: string    );
    procedure Setpermalink                (const Value: string    );
    procedure Setdate_created             (const Value: TDateTime );
    procedure Setdate_created_gmt         (const Value: TDateTime );
    procedure Setdate_modified            (const Value: TDateTime );
    procedure Setdate_modified_gmt        (const Value: TDateTime );
    procedure SetProducttype              (const Value: string    );
    procedure SetProductstatus            (const Value: string    );
    procedure Setfeatured                 (const Value: Boolean   );
    procedure Setcatalog_visibility       (const Value: string    );
    procedure Setdescription              (const Value: string    );
    procedure Setshort_description        (const Value: string    );
    procedure Setsku                      (const Value: string    );
    procedure Setprice                    (const Value: string    );
    procedure Setregular_price            (const Value: string    );
    procedure Setsale_price               (const Value: string    );
    procedure Setdate_on_sale_from        (const Value: TDateTime );
    procedure Setdate_on_sale_from_gmt    (const Value: TDateTime );
    procedure Setdate_on_sale_to          (const Value: TDateTime );
    procedure Setdate_on_sale_to_gmt      (const Value: TDateTime );
    procedure Setprice_html               (const Value: string    );
    procedure Seton_sale                  (const Value: Boolean   );
    procedure Setpurchasable              (const Value: Boolean   );
    procedure Settotal_sales              (const Value: Integer   );
    procedure Setproductvirtual           (const Value: Boolean   );
    procedure Setdownloadable             (const Value: Boolean   );
    procedure Setdownload_limit           (const Value: Integer   );
    procedure Setdownload_expiry          (const Value: Integer   );
    procedure Setexternal_url             (const Value: string    );
    procedure Setbutton_text              (const Value: string    );
    procedure Settax_status               (const Value: string    );
    procedure Settax_class                (const Value: string    );
    procedure Setmanage_stock             (const Value: Boolean   );
    procedure Setstock_quantity           (const Value: Integer   );
    procedure Setstock_status             (const Value: string    );
    procedure Setbackorders               (const Value: string    );
    procedure Setbackorders_allowed       (const Value: Boolean   );
    procedure Setbackordered              (const Value: Boolean   );
    procedure Setsold_individually        (const Value: Boolean   );
    procedure Setweight                   (const Value: string    );
    procedure Setshipping_required        (const Value: Boolean   );
    procedure Setshipping_taxable         (const Value: Boolean   );
    procedure Setshipping_class           (const Value: string    );
    procedure Setshipping_class_ID        (const Value: Integer   );
    procedure Setreviews_allowed          (const Value: Boolean   );
    procedure Setaverage_rating           (const Value: string    );
    procedure Setrating_count             (const Value: Integer   );
    procedure Setparent_ID                (const Value: Integer   );
    procedure Setpurchase_note            (const Value: string    );
    procedure Setmenu_order               (const Value: Integer   );
    procedure SetERPProductId             (const Value: Integer   );

    Function Getwoocommerceproductmetadata   : Twoocommerceproductmetadata   ;
    Function Getwoocommerceproductimages     : Twoocommerceproductimages     ;
    Function GetwoocommerceproductDownLoads  : TwoocommerceproductDownLoads  ;
    Function Getwoocommerceproductdimension  : Twoocommerceproductdimension  ;
    Function Getwoocommerceproductdefattribs : Twoocommerceproductdefattribs ;
    Function Getwoocommerceproductcategories : Twoocommerceproductcategories ;
    Function Getwoocommerceproductattribs    : Twoocommerceproductattribs    ;
    Function Getwoocommerceproducttags       : Twoocommerceproducttags       ;
    function getProductDescriptionforERP: String;
    function getProductnameforERP: String;


  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class Function JsontoWooCommItems(AOwner:TComponent; const ProductJsons :String; OnWooCommProductCreate:TOnWooCommProductCreate = nil):Boolean;
    class function JsontoWooCommItem(AOwner:TComponent; aConnection : TMyDacDataConnection;const ProductJson: String;   var fiWooID:Integer;  var fsProductname:String): Boolean;Overload;
    function JsontoWooCommItem(aProductJson :TJsonObject;aWooID:Integer): Boolean;Overload;
    procedure ChecknMakeERPProduct(onCreateProduct:TNotifyEvent=nil);
    Property ProductnameforERP :String read getProductnameforERP;
    Property ProductDescriptionforERP :String read getProductDescriptionforERP;
    Function ProductSearchSQL:String;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property Productname               :string      read GetProductname             write SetProductname          ;
    property slug                      :string      read Getslug                    write Setslug                 ;
    property permalink                 :string      read Getpermalink               write Setpermalink            ;
    property date_created              :TDateTime   read Getdate_created            write Setdate_created         ;
    property date_created_gmt          :TDateTime   read Getdate_created_gmt        write Setdate_created_gmt     ;
    property date_modified             :TDateTime   read Getdate_modified           write Setdate_modified        ;
    property date_modified_gmt         :TDateTime   read Getdate_modified_gmt       write Setdate_modified_gmt    ;
    property Producttype               :string      read GetProducttype             write SetProducttype          ;
    property Productstatus             :string      read GetProductstatus           write SetProductstatus        ;
    property featured                  :Boolean     read Getfeatured                write Setfeatured             ;
    property catalog_visibility        :string      read Getcatalog_visibility      write Setcatalog_visibility   ;
    property description               :string      read Getdescription             write Setdescription          ;
    property short_description         :string      read Getshort_description       write Setshort_description    ;
    property sku                       :string      read Getsku                     write Setsku                  ;
    property price                     :string      read Getprice                   write Setprice                ;
    property regular_price             :string      read Getregular_price           write Setregular_price        ;
    property sale_price                :string      read Getsale_price              write Setsale_price           ;
    property date_on_sale_from         :TDateTime   read Getdate_on_sale_from       write Setdate_on_sale_from    ;
    property date_on_sale_from_gmt     :TDateTime   read Getdate_on_sale_from_gmt   write Setdate_on_sale_from_gmt;
    property date_on_sale_to           :TDateTime   read Getdate_on_sale_to         write Setdate_on_sale_to      ;
    property date_on_sale_to_gmt       :TDateTime   read Getdate_on_sale_to_gmt     write Setdate_on_sale_to_gmt  ;
    property price_html                :string      read Getprice_html              write Setprice_html           ;
    property on_sale                   :Boolean     read Geton_sale                 write Seton_sale              ;
    property purchasable               :Boolean     read Getpurchasable             write Setpurchasable          ;
    property total_sales               :Integer     read Gettotal_sales             write Settotal_sales          ;
    property productvirtual            :Boolean     read Getproductvirtual          write Setproductvirtual       ;
    property downloadable              :Boolean     read Getdownloadable            write Setdownloadable         ;
    property download_limit            :Integer     read Getdownload_limit          write Setdownload_limit       ;
    property download_expiry           :Integer     read Getdownload_expiry         write Setdownload_expiry      ;
    property external_url              :string      read Getexternal_url            write Setexternal_url         ;
    property button_text               :string      read Getbutton_text             write Setbutton_text          ;
    property tax_status                :string      read Gettax_status              write Settax_status           ;
    property tax_class                 :string      read Gettax_class               write Settax_class            ;
    property manage_stock              :Boolean     read Getmanage_stock            write Setmanage_stock         ;
    property stock_quantity            :Integer     read Getstock_quantity          write Setstock_quantity       ;
    property stock_status              :string      read Getstock_status            write Setstock_status         ;
    property backorders                :string      read Getbackorders              write Setbackorders           ;
    property backorders_allowed        :Boolean     read Getbackorders_allowed      write Setbackorders_allowed   ;
    property backordered               :Boolean     read Getbackordered             write Setbackordered          ;
    property sold_individually         :Boolean     read Getsold_individually       write Setsold_individually    ;
    property weight                    :string      read Getweight                  write Setweight               ;
    property shipping_required         :Boolean     read Getshipping_required       write Setshipping_required    ;
    property shipping_taxable          :Boolean     read Getshipping_taxable        write Setshipping_taxable     ;
    property shipping_class            :string      read Getshipping_class          write Setshipping_class       ;
    property shipping_class_ID         :Integer     read Getshipping_class_ID       write Setshipping_class_ID    ;
    property reviews_allowed           :Boolean     read Getreviews_allowed         write Setreviews_allowed      ;
    property average_rating            :string      read Getaverage_rating          write Setaverage_rating       ;
    property rating_count              :Integer     read Getrating_count            write Setrating_count         ;
    property parent_ID                 :Integer     read Getparent_ID               write Setparent_ID            ;
    property purchase_note             :string      read Getpurchase_note           write Setpurchase_note        ;
    property menu_order                :Integer     read Getmenu_order              write Setmenu_order           ;
    property ERPProductId              :Integer     read GetERPProductId            write SetERPProductId         ;

    property woocommerceproductmetadata   : Twoocommerceproductmetadata   read getwoocommerceproductmetadata ;
    property woocommerceproductimages     : Twoocommerceproductimages     read getwoocommerceproductimages ;
    property woocommerceproductDownLoads  : TwoocommerceproductDownLoads  read getwoocommerceproductDownLoads ;
    property woocommerceproductdimension  : Twoocommerceproductdimension  read getwoocommerceproductdimension ;
    property woocommerceproductdefattribs : Twoocommerceproductdefattribs read getwoocommerceproductdefattribs ;
    property woocommerceproductcategories : Twoocommerceproductcategories read getwoocommerceproductcategories ;
    property woocommerceproductattribs    : Twoocommerceproductattribs    read getwoocommerceproductattribs ;
    property woocommerceproducttags       : Twoocommerceproducttags       read getwoocommerceproducttags ;

  end;


implementation


uses tcDataUtils, CommonLib, sysutils, CommonDbLib, LogLib,
  DateTimeUtils, BusobjProduct, AppEnvironment;

{TwoocommerceproductBase}
function  TwoocommerceproductBase.GetWooID        : Integer   ; begin Result := GetIntegerField('WooID');end;
procedure TwoocommerceproductBase.SetWooID        (const Value: Integer   ); begin SetIntegerField('WooID'         , Value);end;
procedure    TwoocommerceproductBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
end;
procedure    TwoocommerceproductBase.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
end;

{TwoocommerceSubproductBase}
function  TwoocommerceSubproductBase.GetProductID        : Integer   ; begin Result := GetIntegerField('ProductID');end;
procedure TwoocommerceSubproductBase.SetProductID        (const Value: Integer   ); begin SetIntegerField('ProductID'         , Value);end;
procedure TwoocommerceSubproductBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProductID' ,ProductID);
end;
procedure TwoocommerceSubproductBase.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProductID' ,ProductID);
end;
function  TwoocommerceSubproductBase.DoAfterinsert(Sender:TDatasetBusObj) : Boolean;
begin
  result := inherited  DoAfterinsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is TwoocommerceProducts then
      ProductID := TwoocommerceProducts(Owner).ID;
end;
  {Twoocommerceproducts}

constructor Twoocommerceproducts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproducts';
  fSQL := 'SELECT * FROM tblwoocommerceproducts';
end;


destructor Twoocommerceproducts.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproducts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Productname');
  SetPropertyFromNode(node,'slug');
  SetPropertyFromNode(node,'permalink');
  SetDateTimePropertyFromNode(node,'date_created');
  SetDateTimePropertyFromNode(node,'date_created_gmt');
  SetDateTimePropertyFromNode(node,'date_modified');
  SetDateTimePropertyFromNode(node,'date_modified_gmt');
  SetPropertyFromNode(node,'Producttype');
  SetPropertyFromNode(node,'Productstatus');
  SetBooleanPropertyFromNode(node,'featured');
  SetPropertyFromNode(node,'catalog_visibility');
  SetPropertyFromNode(node,'description');
  SetPropertyFromNode(node,'short_description');
  SetPropertyFromNode(node,'sku');
  SetPropertyFromNode(node,'price');
  SetPropertyFromNode(node,'regular_price');
  SetPropertyFromNode(node,'sale_price');
  SetDateTimePropertyFromNode(node,'date_on_sale_from');
  SetDateTimePropertyFromNode(node,'date_on_sale_from_gmt');
  SetDateTimePropertyFromNode(node,'date_on_sale_to');
  SetDateTimePropertyFromNode(node,'date_on_sale_to_gmt');
  SetPropertyFromNode(node,'price_html');
  SetBooleanPropertyFromNode(node,'on_sale');
  SetBooleanPropertyFromNode(node,'purchasable');
  SetPropertyFromNode(node,'total_sales');
  SetBooleanPropertyFromNode(node,'productvirtual');
  SetBooleanPropertyFromNode(node,'downloadable');
  SetPropertyFromNode(node,'download_limit');
  SetPropertyFromNode(node,'download_expiry');
  SetPropertyFromNode(node,'external_url');
  SetPropertyFromNode(node,'button_text');
  SetPropertyFromNode(node,'tax_status');
  SetPropertyFromNode(node,'tax_class');
  SetBooleanPropertyFromNode(node,'manage_stock');
  SetPropertyFromNode(node,'stock_quantity');
  SetPropertyFromNode(node,'stock_status');
  SetPropertyFromNode(node,'backorders');
  SetBooleanPropertyFromNode(node,'backorders_allowed');
  SetBooleanPropertyFromNode(node,'backordered');
  SetBooleanPropertyFromNode(node,'sold_individually');
  SetPropertyFromNode(node,'weight');
  SetBooleanPropertyFromNode(node,'shipping_required');
  SetBooleanPropertyFromNode(node,'shipping_taxable');
  SetPropertyFromNode(node,'shipping_class');
  SetPropertyFromNode(node,'shipping_class_ID');
  SetBooleanPropertyFromNode(node,'reviews_allowed');
  SetPropertyFromNode(node,'average_rating');
  SetPropertyFromNode(node,'rating_count');
  SetPropertyFromNode(node,'parent_ID');
  SetPropertyFromNode(node,'purchase_note');
  SetPropertyFromNode(node,'menu_order');
  SetPropertyFromNode(node,'ERPProductId');
end;


procedure Twoocommerceproducts.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Productname' ,Productname);
  AddXMLNode(node,'slug' ,slug);
  AddXMLNode(node,'permalink' ,permalink);
  AddXMLNode(node,'date_created' ,date_created);
  AddXMLNode(node,'date_created_gmt' ,date_created_gmt);
  AddXMLNode(node,'date_modified' ,date_modified);
  AddXMLNode(node,'date_modified_gmt' ,date_modified_gmt);
  AddXMLNode(node,'Producttype' ,Producttype);
  AddXMLNode(node,'Productstatus' ,Productstatus);
  AddXMLNode(node,'featured' ,featured);
  AddXMLNode(node,'catalog_visibility' ,catalog_visibility);
  AddXMLNode(node,'description' ,description);
  AddXMLNode(node,'short_description' ,short_description);
  AddXMLNode(node,'sku' ,sku);
  AddXMLNode(node,'price' ,price);
  AddXMLNode(node,'regular_price' ,regular_price);
  AddXMLNode(node,'sale_price' ,sale_price);
  AddXMLNode(node,'date_on_sale_from' ,date_on_sale_from);
  AddXMLNode(node,'date_on_sale_from_gmt' ,date_on_sale_from_gmt);
  AddXMLNode(node,'date_on_sale_to' ,date_on_sale_to);
  AddXMLNode(node,'date_on_sale_to_gmt' ,date_on_sale_to_gmt);
  AddXMLNode(node,'price_html' ,price_html);
  AddXMLNode(node,'on_sale' ,on_sale);
  AddXMLNode(node,'purchasable' ,purchasable);
  AddXMLNode(node,'total_sales' ,total_sales);
  AddXMLNode(node,'productvirtual' ,productvirtual);
  AddXMLNode(node,'downloadable' ,downloadable);
  AddXMLNode(node,'download_limit' ,download_limit);
  AddXMLNode(node,'download_expiry' ,download_expiry);
  AddXMLNode(node,'external_url' ,external_url);
  AddXMLNode(node,'button_text' ,button_text);
  AddXMLNode(node,'tax_status' ,tax_status);
  AddXMLNode(node,'tax_class' ,tax_class);
  AddXMLNode(node,'manage_stock' ,manage_stock);
  AddXMLNode(node,'stock_quantity' ,stock_quantity);
  AddXMLNode(node,'stock_status' ,stock_status);
  AddXMLNode(node,'backorders' ,backorders);
  AddXMLNode(node,'backorders_allowed' ,backorders_allowed);
  AddXMLNode(node,'backordered' ,backordered);
  AddXMLNode(node,'sold_individually' ,sold_individually);
  AddXMLNode(node,'weight' ,weight);
  AddXMLNode(node,'shipping_required' ,shipping_required);
  AddXMLNode(node,'shipping_taxable' ,shipping_taxable);
  AddXMLNode(node,'shipping_class' ,shipping_class);
  AddXMLNode(node,'shipping_class_ID' ,shipping_class_ID);
  AddXMLNode(node,'reviews_allowed' ,reviews_allowed);
  AddXMLNode(node,'average_rating' ,average_rating);
  AddXMLNode(node,'rating_count' ,rating_count);
  AddXMLNode(node,'parent_ID' ,parent_ID);
  AddXMLNode(node,'purchase_note' ,purchase_note);
  AddXMLNode(node,'menu_order' ,menu_order);
  AddXMLNode(node,'ERPProductId' ,ERPProductId);
end;


function Twoocommerceproducts.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproducts.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproducts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


function Twoocommerceproducts.ProductSearchSQL: String;
begin
  result := 'Partname = ' + quotedstr(ProductnameforERP);
end;

procedure Twoocommerceproducts.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproducts.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproducts.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproducts.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproducts';
end;


function Twoocommerceproducts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproducts.GetProductname          : string    ; begin Result := GetStringField('Productname');end;
function  Twoocommerceproducts.Getslug                 : string    ; begin Result := GetStringField('slug');end;
function  Twoocommerceproducts.Getpermalink            : string    ; begin Result := GetStringField('permalink');end;
function  Twoocommerceproducts.Getdate_created         : TDateTime ; begin Result := GetDateTimeField('date_created');end;
function  Twoocommerceproducts.Getdate_created_gmt     : TDateTime ; begin Result := GetDateTimeField('date_created_gmt');end;
function  Twoocommerceproducts.Getdate_modified        : TDateTime ; begin Result := GetDateTimeField('date_modified');end;
function  Twoocommerceproducts.Getdate_modified_gmt    : TDateTime ; begin Result := GetDateTimeField('date_modified_gmt');end;
function  Twoocommerceproducts.GetProducttype          : string    ; begin Result := GetStringField('Producttype');end;
function  Twoocommerceproducts.GetProductstatus        : string    ; begin Result := GetStringField('Productstatus');end;
function  Twoocommerceproducts.Getfeatured             : Boolean   ; begin Result := GetBooleanField('featured');end;
function  Twoocommerceproducts.Getcatalog_visibility   : string    ; begin Result := GetStringField('catalog_visibility');end;
function  Twoocommerceproducts.Getdescription          : string    ; begin Result := GetStringField('description');end;
function  Twoocommerceproducts.Getshort_description    : string    ; begin Result := GetStringField('short_description');end;
function  Twoocommerceproducts.Getsku                  : string    ; begin Result := GetStringField('sku');end;
function  Twoocommerceproducts.Getprice                : string    ; begin Result := GetStringField('price');end;
function  Twoocommerceproducts.Getregular_price        : string    ; begin Result := GetStringField('regular_price');end;
function  Twoocommerceproducts.Getsale_price           : string    ; begin Result := GetStringField('sale_price');end;
function  Twoocommerceproducts.Getdate_on_sale_from    : TDateTime ; begin Result := GetDateTimeField('date_on_sale_from');end;
function  Twoocommerceproducts.Getdate_on_sale_from_gmt: TDateTime ; begin Result := GetDateTimeField('date_on_sale_from_gmt');end;
function  Twoocommerceproducts.Getdate_on_sale_to      : TDateTime ; begin Result := GetDateTimeField('date_on_sale_to');end;
function  Twoocommerceproducts.Getdate_on_sale_to_gmt  : TDateTime ; begin Result := GetDateTimeField('date_on_sale_to_gmt');end;
function  Twoocommerceproducts.Getprice_html           : string    ; begin Result := GetStringField('price_html');end;
function  Twoocommerceproducts.Geton_sale              : Boolean   ; begin Result := GetBooleanField('on_sale');end;
function  Twoocommerceproducts.Getpurchasable          : Boolean   ; begin Result := GetBooleanField('purchasable');end;
function  Twoocommerceproducts.Gettotal_sales          : Integer   ; begin Result := GetIntegerField('total_sales');end;
function  Twoocommerceproducts.Getproductvirtual       : Boolean   ; begin Result := GetBooleanField('productvirtual');end;
function  Twoocommerceproducts.Getdownloadable         : Boolean   ; begin Result := GetBooleanField('downloadable');end;
function  Twoocommerceproducts.Getdownload_limit       : Integer   ; begin Result := GetIntegerField('download_limit');end;
function  Twoocommerceproducts.Getdownload_expiry      : Integer   ; begin Result := GetIntegerField('download_expiry');end;
function  Twoocommerceproducts.Getexternal_url         : string    ; begin Result := GetStringField('external_url');end;
function  Twoocommerceproducts.Getbutton_text          : string    ; begin Result := GetStringField('button_text');end;
function  Twoocommerceproducts.Gettax_status           : string    ; begin Result := GetStringField('tax_status');end;
function  Twoocommerceproducts.Gettax_class            : string    ; begin Result := GetStringField('tax_class');end;
function  Twoocommerceproducts.Getmanage_stock         : Boolean   ; begin Result := GetBooleanField('manage_stock');end;
function  Twoocommerceproducts.Getstock_quantity       : Integer   ; begin Result := GetIntegerField('stock_quantity');end;
function  Twoocommerceproducts.Getstock_status         : string    ; begin Result := GetStringField('stock_status');end;
function  Twoocommerceproducts.Getbackorders           : string    ; begin Result := GetStringField('backorders');end;
function  Twoocommerceproducts.Getbackorders_allowed   : Boolean   ; begin Result := GetBooleanField('backorders_allowed');end;
function  Twoocommerceproducts.Getbackordered          : Boolean   ; begin Result := GetBooleanField('backordered');end;
function  Twoocommerceproducts.Getsold_individually    : Boolean   ; begin Result := GetBooleanField('sold_individually');end;
function  Twoocommerceproducts.Getweight               : string    ; begin Result := GetStringField('weight');end;
function  Twoocommerceproducts.Getshipping_required    : Boolean   ; begin Result := GetBooleanField('shipping_required');end;
function  Twoocommerceproducts.Getshipping_taxable     : Boolean   ; begin Result := GetBooleanField('shipping_taxable');end;
function  Twoocommerceproducts.Getshipping_class       : string    ; begin Result := GetStringField('shipping_class');end;
function  Twoocommerceproducts.Getshipping_class_ID    : Integer   ; begin Result := GetIntegerField('shipping_class_ID');end;
function  Twoocommerceproducts.Getreviews_allowed      : Boolean   ; begin Result := GetBooleanField('reviews_allowed');end;
function  Twoocommerceproducts.Getaverage_rating       : string    ; begin Result := GetStringField('average_rating');end;
function  Twoocommerceproducts.Getrating_count         : Integer   ; begin Result := GetIntegerField('rating_count');end;
function  Twoocommerceproducts.Getparent_ID            : Integer   ; begin Result := GetIntegerField('parent_ID');end;
function  Twoocommerceproducts.Getpurchase_note        : string    ; begin Result := GetStringField('purchase_note');end;
function  Twoocommerceproducts.Getmenu_order           : Integer   ; begin Result := GetIntegerField('menu_order');end;
function  Twoocommerceproducts.GetERPProductId         : Integer   ; begin Result := GetIntegerField('ERPProductId');end;
procedure Twoocommerceproducts.SetProductname          (const Value: string    ); begin SetStringField('Productname'           , Value);end;
procedure Twoocommerceproducts.Setslug                 (const Value: string    ); begin SetStringField('slug'                  , Value);end;
procedure Twoocommerceproducts.Setpermalink            (const Value: string    ); begin SetStringField('permalink'             , Value);end;
procedure Twoocommerceproducts.Setdate_created         (const Value: TDateTime ); begin SetDateTimeField('date_created'          , Value);end;
procedure Twoocommerceproducts.Setdate_created_gmt     (const Value: TDateTime ); begin SetDateTimeField('date_created_gmt'      , Value);end;
procedure Twoocommerceproducts.Setdate_modified        (const Value: TDateTime ); begin SetDateTimeField('date_modified'         , Value);end;
procedure Twoocommerceproducts.Setdate_modified_gmt    (const Value: TDateTime ); begin SetDateTimeField('date_modified_gmt'     , Value);end;
procedure Twoocommerceproducts.SetProducttype          (const Value: string    ); begin SetStringField('Producttype'           , Value);end;
procedure Twoocommerceproducts.SetProductstatus        (const Value: string    ); begin SetStringField('Productstatus'         , Value);end;
procedure Twoocommerceproducts.Setfeatured             (const Value: Boolean   ); begin SetBooleanField('featured'              , Value);end;
procedure Twoocommerceproducts.Setcatalog_visibility   (const Value: string    ); begin SetStringField('catalog_visibility'    , Value);end;
procedure Twoocommerceproducts.Setdescription          (const Value: string    ); begin SetStringField('description'           , Value);end;
procedure Twoocommerceproducts.Setshort_description    (const Value: string    ); begin SetStringField('short_description'     , Value);end;
procedure Twoocommerceproducts.Setsku                  (const Value: string    ); begin SetStringField('sku'                   , Value);end;
procedure Twoocommerceproducts.Setprice                (const Value: string    ); begin SetStringField('price'                 , Value);end;
procedure Twoocommerceproducts.Setregular_price        (const Value: string    ); begin SetStringField('regular_price'         , Value);end;
procedure Twoocommerceproducts.Setsale_price           (const Value: string    ); begin SetStringField('sale_price'            , Value);end;
procedure Twoocommerceproducts.Setdate_on_sale_from    (const Value: TDateTime ); begin SetDateTimeField('date_on_sale_from'     , Value);end;
procedure Twoocommerceproducts.Setdate_on_sale_from_gmt(const Value: TDateTime ); begin SetDateTimeField('date_on_sale_from_gmt' , Value);end;
procedure Twoocommerceproducts.Setdate_on_sale_to      (const Value: TDateTime ); begin SetDateTimeField('date_on_sale_to'       , Value);end;
procedure Twoocommerceproducts.Setdate_on_sale_to_gmt  (const Value: TDateTime ); begin SetDateTimeField('date_on_sale_to_gmt'   , Value);end;
procedure Twoocommerceproducts.Setprice_html           (const Value: string    ); begin SetStringField('price_html'            , Value);end;
procedure Twoocommerceproducts.Seton_sale              (const Value: Boolean   ); begin SetBooleanField('on_sale'               , Value);end;
procedure Twoocommerceproducts.Setpurchasable          (const Value: Boolean   ); begin SetBooleanField('purchasable'           , Value);end;
procedure Twoocommerceproducts.Settotal_sales          (const Value: Integer   ); begin SetIntegerField('total_sales'           , Value);end;
procedure Twoocommerceproducts.Setproductvirtual       (const Value: Boolean   ); begin SetBooleanField('productvirtual'        , Value);end;
procedure Twoocommerceproducts.Setdownloadable         (const Value: Boolean   ); begin SetBooleanField('downloadable'          , Value);end;
procedure Twoocommerceproducts.Setdownload_limit       (const Value: Integer   ); begin SetIntegerField('download_limit'        , Value);end;
procedure Twoocommerceproducts.Setdownload_expiry      (const Value: Integer   ); begin SetIntegerField('download_expiry'       , Value);end;
procedure Twoocommerceproducts.Setexternal_url         (const Value: string    ); begin SetStringField('external_url'          , Value);end;
procedure Twoocommerceproducts.Setbutton_text          (const Value: string    ); begin SetStringField('button_text'           , Value);end;
procedure Twoocommerceproducts.Settax_status           (const Value: string    ); begin SetStringField('tax_status'            , Value);end;
procedure Twoocommerceproducts.Settax_class            (const Value: string    ); begin SetStringField('tax_class'             , Value);end;
procedure Twoocommerceproducts.Setmanage_stock         (const Value: Boolean   ); begin SetBooleanField('manage_stock'          , Value);end;
procedure Twoocommerceproducts.Setstock_quantity       (const Value: Integer   ); begin SetIntegerField('stock_quantity'        , Value);end;
procedure Twoocommerceproducts.Setstock_status         (const Value: string    ); begin SetStringField('stock_status'          , Value);end;
procedure Twoocommerceproducts.Setbackorders           (const Value: string    ); begin SetStringField('backorders'            , Value);end;
procedure Twoocommerceproducts.Setbackorders_allowed   (const Value: Boolean   ); begin SetBooleanField('backorders_allowed'    , Value);end;
procedure Twoocommerceproducts.Setbackordered          (const Value: Boolean   ); begin SetBooleanField('backordered'           , Value);end;
procedure Twoocommerceproducts.Setsold_individually    (const Value: Boolean   ); begin SetBooleanField('sold_individually'     , Value);end;
procedure Twoocommerceproducts.Setweight               (const Value: string    ); begin SetStringField('weight'                , Value);end;
procedure Twoocommerceproducts.Setshipping_required    (const Value: Boolean   ); begin SetBooleanField('shipping_required'     , Value);end;
procedure Twoocommerceproducts.Setshipping_taxable     (const Value: Boolean   ); begin SetBooleanField('shipping_taxable'      , Value);end;
procedure Twoocommerceproducts.Setshipping_class       (const Value: string    ); begin SetStringField('shipping_class'        , Value);end;
procedure Twoocommerceproducts.Setshipping_class_ID    (const Value: Integer   ); begin SetIntegerField('shipping_class_ID'     , Value);end;
procedure Twoocommerceproducts.Setreviews_allowed      (const Value: Boolean   ); begin SetBooleanField('reviews_allowed'       , Value);end;
procedure Twoocommerceproducts.Setaverage_rating       (const Value: string    ); begin SetStringField('average_rating'        , Value);end;
procedure Twoocommerceproducts.Setrating_count         (const Value: Integer   ); begin SetIntegerField('rating_count'          , Value);end;
procedure Twoocommerceproducts.Setparent_ID            (const Value: Integer   ); begin SetIntegerField('parent_ID'             , Value);end;
procedure Twoocommerceproducts.Setpurchase_note        (const Value: string    ); begin SetStringField('purchase_note'         , Value);end;
procedure Twoocommerceproducts.Setmenu_order           (const Value: Integer   ); begin SetIntegerField('menu_order'            , Value);end;
procedure Twoocommerceproducts.SetERPProductId         (const Value: Integer   ); begin SetIntegerField('ERPProductId'          , Value);end;
Function Twoocommerceproducts.Getwoocommerceproductmetadata   : Twoocommerceproductmetadata   ; Begin Result := Twoocommerceproductmetadata   (getcontainercomponent(Twoocommerceproductmetadata    , 'ProductID = ' + inttostr(ID))); end;
Function Twoocommerceproducts.Getwoocommerceproductimages     : Twoocommerceproductimages     ; Begin Result := Twoocommerceproductimages     (getcontainercomponent(Twoocommerceproductimages      , 'ProductID = ' + inttostr(ID))); end;
Function Twoocommerceproducts.GetwoocommerceproductDownLoads  : TwoocommerceproductDownLoads  ; Begin Result := TwoocommerceproductDownLoads  (getcontainercomponent(TwoocommerceproductDownLoads   , 'ProductID = ' + inttostr(ID))); end;
Function Twoocommerceproducts.Getwoocommerceproductdimension  : Twoocommerceproductdimension  ; Begin Result := Twoocommerceproductdimension  (getcontainercomponent(Twoocommerceproductdimension   , 'ProductID = ' + inttostr(ID))); end;
Function Twoocommerceproducts.Getwoocommerceproductdefattribs : Twoocommerceproductdefattribs ; Begin Result := Twoocommerceproductdefattribs (getcontainercomponent(Twoocommerceproductdefattribs  , 'ProductID = ' + inttostr(ID))); end;
Function Twoocommerceproducts.Getwoocommerceproductcategories : Twoocommerceproductcategories ; Begin Result := Twoocommerceproductcategories (getcontainercomponent(Twoocommerceproductcategories  , 'ProductID = ' + inttostr(ID))); end;
Function Twoocommerceproducts.Getwoocommerceproductattribs    : Twoocommerceproductattribs    ; Begin Result := Twoocommerceproductattribs    (getcontainercomponent(Twoocommerceproductattribs     , 'ProductID = ' + inttostr(ID))); end;
Function Twoocommerceproducts.Getwoocommerceproducttags       : Twoocommerceproducttags       ; Begin Result := Twoocommerceproducttags       (getcontainercomponent(Twoocommerceproducttags        , 'ProductID = ' + inttostr(ID))); end;
function Twoocommerceproducts.getProductnameforERP: String;
begin
//       if Sametext(Appenv.comPanyprefs.Woocommerce_ProductNameField ,'P') then result := ProductName
//  else if Sametext(Appenv.comPanyprefs.Woocommerce_ProductNameField ,'S') then result := SKU
//  else
  REsult := ProductName;
end;
function Twoocommerceproducts.getProductDescriptionforERP: String;
begin
//       if Sametext(Appenv.comPanyprefs.woocommerce_ProductNameField ,'s') then result := ProductName
//  else if Sametext(Appenv.comPanyprefs.woocommerce_ProductNameField ,'p') then result := SKU
//  else
  REsult := sku;
end;

Class Function Twoocommerceproducts.JsontoWooCommItems(AOwner:TComponent; const ProductJsons :String; OnWooCommProductCreate:TOnWooCommProductCreate = nil):Boolean;
var
  aProductJsons: TJSONArray;
  ctr1:Integer;
  fiWooID:Integer;
  fsProductname:String;
  fConnection : TMyDacDataConnection;
begin
    result := False;
    if ProductJsons = '' then begin
      Result := True;
      Exit;
    end;

    aProductJsons:= TJSONArray.create;
    try
      fConnection := TMyDAcDataconnection.Create(AOwner);
      fConnection.Connection := GetNewMyDacConnection(AOwner);
      try
        aProductJsons.asString := ProductJsons;
        for ctr1 := 0 to aProductJsons.Count-1 do begin
          try
            fConnection.BeginTransaction;
            try
                if Twoocommerceproducts.JsontoWooCommItem(AOwner,fConnection, aProductJsons.items[ctr1].asObject.asString, fiWooId, fsProductname) then begin
                  if (fiWooID <> 0) and (Assigned(OnWooCommProductCreate)) then begin
                      OnWooCommProductCreate(fiWooID , fsProductname);
                      fConnection.CommitTransaction;
                      continue;
                  end;
                end;
                fConnection.RollbackTransaction;
            Except
              on E:Exception do begin
                fConnection.RollbackTransaction;
              end;
            end;
          Except
            on E:Exception do begin
              logtext(E.Message);
            end;
          end;

          end;
      finally
        Freeandnil (fConnection);
      end;
    finally
      aProductJsons.Free;
    end;
end;
class function Twoocommerceproducts.JsontoWooCommItem(AOwner:TComponent; aConnection : TMyDacDataConnection;const ProductJson: String;   var fiWooID:Integer;  var fsProductname:String): Boolean;
var
  awoocommerceProducts : TwoocommerceProducts;
  aProductJson :TJsonObject;
begin
  result := False;
  if ProductJson = '' then exit;
  aProductJson := JO;
  aProductJson.asString := ProductJson;
  aProductJson.IgnoreNull := True;
  fiWooID := aProductJson.I['id'];
  awoocommerceProducts := TwoocommerceProducts.Create(AOwner);
  try
    awoocommerceProducts.Connection := aConnection;
    awoocommerceProducts.Loadselect('WooID = ' + INTTOSTR(fiWooID));
    if awoocommerceProducts.JsontoWooCommItem(aProductJson,fiWooID) then begin
      result := True;
      fsProductname :=awoocommerceProducts.Productname;
    end;
  finally
    FreeandNil(awoocommerceProducts);
  end;
end;


function Twoocommerceproducts.JsontoWooCommItem(aProductJson :TJsonObject;aWooID:Integer): Boolean;
  Procedure Makedimensions(adimensions: TJSONArray);
  var
    ctr:Integer;
    adimension :TJSONObject;
  begin
    if adimensions.Count >0 then begin
      for ctr := 0 to adimensions.Count-1 do begin
        adimension :=TJSONObject(adimensions.items[ctr]);
          woocommerceproductdimension.New;
          woocommerceproductdimension.length := adimension.S['length'];
          woocommerceproductdimension.width  := adimension.S['width'];
          woocommerceproductdimension.height := adimension.S['height'];
          woocommerceproductdimension.PostDB;
      end;
    end;
  end;
  Procedure Makecategories(acategories: TJSONArray);
  var
    ctr:Integer;
    acategory :TJSONObject;
  begin
    if acategories.Count >0 then begin
      for ctr := 0 to acategories.Count-1 do begin
        acategory :=TJSONObject(acategories.items[ctr]);
        if not woocommerceproductcategories.Locate('WooID', acategory.I['Id'], []) then begin
          woocommerceproductcategories.New;
          woocommerceproductcategories.WooId       :=acategory.I['Id'];
          woocommerceproductcategories.categoryName:= acategory.S['Name'];
          woocommerceproductcategories.slug        := acategory.S['slug'];
          woocommerceproductcategories.PostDB;
        end;
      end;
    end;
  end;
  Procedure Maketags(atags: TJSONArray);
  var
    ctr:Integer;
    aTag :TJSONObject;
  begin
    if atags.Count >0 then begin
      for ctr := 0 to atags.Count-1 do begin
        aTag :=TJSONObject(atags.items[ctr]);
        if not woocommerceproducttags.Locate('WooID', aTag.I['Id'], []) then begin
          woocommerceproducttags.New;
          woocommerceproducttags.WooId       :=aTag.I['Id'];
          woocommerceproducttags.TagName:= aTag.S['Name'];
          woocommerceproducttags.slug        := aTag.S['slug'];
          woocommerceproducttags.PostDB;
        end;
      end;
    end;
  end;
  Procedure Makeimages(aimages: TJSONArray);
  var
    ctr:Integer;
    aimage :TJSONObject;
  begin
    if aimages.Count >0 then begin
      for ctr := 0 to aimages.Count-1 do begin
        aimage :=TJSONObject(aimages.items[ctr]);
        if not woocommerceproductimages.Locate('WooID', aimage.I['Id'], []) then begin
          woocommerceproductimages.New;
          woocommerceproductimages.WooId       :=aimage.I['Id'];
          try woocommerceproductimages.date_created     := ISO8601ToDateTime(aimage.S['date_created']      );Except End;
          try woocommerceproductimages.date_created_gmt := ISO8601ToDateTime(aimage.S['date_created_gmt']  );Except End;
          try woocommerceproductimages.date_modified    := ISO8601ToDateTime(aimage.S['date_modified']     );Except End;
          try woocommerceproductimages.date_modified_gmt:= ISO8601ToDateTime(aimage.S['date_modified_gmt'] );Except End;
          woocommerceproductimages.ImageName:= aimage.S['Name'];
          woocommerceproductimages.src      := aimage.S['src'];
          woocommerceproductimages.PostDB;
        end;
      end;
    end;
  end;
  Procedure Makeattributes(aattributes: TJSONArray);
  var
    ctr:Integer;
    aattribute :TJSONObject;
  begin
    if aattributes.Count >0 then begin
      for ctr := 0 to aattributes.Count-1 do begin
        aattribute :=TJSONObject(aattributes.items[ctr]);
        if not woocommerceproductattribs.Locate('WooID', aattribute.I['Id'], []) then begin
          woocommerceproductattribs.New;
          woocommerceproductattribs.WooId      := aattribute.I['Id'];
          woocommerceproductattribs.AttribName := aattribute.S['Name'];
          woocommerceproductattribs.position   := aattribute.I['position'];
          woocommerceproductattribs.visible    := aattribute.B['visible'];
          woocommerceproductattribs.variation  := aattribute.B['variation'];
          woocommerceproductattribs.PostDB;
        end;
      end;
    end;
  end;
  Procedure MakeDefattributes(aDiffattributes: TJSONArray);
  var
    ctr:Integer;
    aDiffattribute :TJSONObject;
  begin
    if aDiffattributes.Count >0 then begin
      for ctr := 0 to aDiffattributes.Count-1 do begin
        aDiffattribute :=TJSONObject(aDiffattributes.items[ctr]);
        if not woocommerceproductdefattribs.Locate('WooID', aDiffattribute.I['Id'], []) then begin
          woocommerceproductdefattribs.New;
          woocommerceproductdefattribs.WooId      :=aDiffattribute.I['Id'];
          woocommerceproductdefattribs.DefattribName := aDiffattribute.S['Name'];
          woocommerceproductdefattribs.PostDB;
        end;
      end;
    end;
  end;
  Procedure MakeMetaData(aMetaDataArray: TJSONArray);
  var
    ctr:Integer;
    aMetaData :TJSONObject;
  begin
        if aMetaDataArray.Count >0 then begin
          for ctr := 0 to aMetaDataArray.Count-1 do begin
            aMetaData :=TJSONObject(aMetaDataArray.items[ctr]);
            if not woocommerceproductMetaData.Locate('WooID', aMetaData.I['Id'], []) then begin
              woocommerceproductMetaData.New;
              woocommerceproductMetaData.WooID         := aMetaData.I['Id'];
              woocommerceproductMetaData.MetaDatakey   := aMetaData.S['key'];
              woocommerceproductMetaData.MetaDatavalue := aMetaData.S['value'];
              woocommerceproductMetaData.PostDB;
            end;
          end;
        end;
  end;

begin
    if count =0 then begin
        New;
        WooID :=aWooID;
        Productname	    := aProductJson.S['name'];
        slug	            := aProductJson.S['slug'];
        permalink	      := aProductJson.S['permalink'];

        try date_created	    := ISO8601ToDateTime(aProductJson.S['date_created']     );Except End;
        try date_created_gmt	:= ISO8601ToDateTime(aProductJson.S['date_created_gmt'] );Except End;
        try date_modified	  := ISO8601ToDateTime(aProductJson.S['date_modified']    );Except End;
        try date_modified_gmt:= ISO8601ToDateTime(aProductJson.S['date_modified_gmt']);Except End;

        Producttype	        := aProductJson.S['Producttype'];
        Productstatus	      := aProductJson.S['Productstatus'];
        featured	            := aProductJson.B['featured'];
        catalog_visibility	  := aProductJson.S['catalog_visibility'];
        description	        := aProductJson.S['description'];
        short_description	  := aProductJson.S['short_description'];
        sku	                := aProductJson.S['sku'];
        price	              := aProductJson.S['price'];
        regular_price	      := aProductJson.S['regular_price'];
        sale_price	          := aProductJson.S['sale_price'];
        try date_on_sale_from	  := ISO8601ToDateTime(aProductJson.S['date_on_sale_from'])     ;Except End;
        try date_on_sale_from_gmt:= ISO8601ToDateTime(aProductJson.S['date_on_sale_from_gmt']) ;Except End;
        try date_on_sale_to	    := ISO8601ToDateTime(aProductJson.S['date_on_sale_to'])       ;Except End;
        try date_on_sale_to_gmt	:= ISO8601ToDateTime(aProductJson.S['date_on_sale_to_gmt'])   ;Except End;
        price_html	          := aProductJson.S['price_html'];
        on_sale	            := aProductJson.B['on_sale'];
        purchasable	        := aProductJson.B['purchasable'];
        total_sales	        := aProductJson.I['total_sales'];
        productvirtual	      := aProductJson.B['productvirtual'];
        downloadable	        := aProductJson.B['downloadable'];
        download_limit	      := aProductJson.I['download_limit'];
        download_expiry	    := aProductJson.I['download_expiry'];
        external_url	        := aProductJson.S['external_url'];
        button_text	        := aProductJson.S['button_text'];
        tax_status	          := aProductJson.S['tax_status'];
        tax_class	          := aProductJson.S['tax_class'];
        manage_stock	        := aProductJson.B['manage_stock'];
        stock_quantity	      := aProductJson.I['stock_quantity'];
        stock_status	        := aProductJson.S['stock_status'];
        backorders	          := aProductJson.S['backorders'];
        backorders_allowed	  := aProductJson.B['backorders_allowed'];
        backordered	        := aProductJson.B['backordered'];
        sold_individually	  := aProductJson.B['sold_individually'];
        weight	              := aProductJson.S['weight'];
        shipping_required	  := aProductJson.B['shipping_required'];
        shipping_taxable	    := aProductJson.B['shipping_taxable'];
        shipping_class	      := aProductJson.S['shipping_class'];
        shipping_class_id	  := aProductJson.I['shipping_class_id'];
        reviews_allowed	    := aProductJson.B['reviews_allowed'];
        average_rating	      := aProductJson.S['average_rating'];
        rating_count	        := aProductJson.I['rating_count'];
        parent_id	          := aProductJson.I['parent_id'];
        purchase_note	      := aProductJson.S['purchase_note'];
        menu_order	          := aProductJson.I['menu_order'];
        postdb;
        if aProductJson.ArrayExists('dimensions')         then Makedimensions(aProductJson.A['dimensions'] );
        if aProductJson.ArrayExists('categories')         then Makecategories(aProductJson.A['categories'] );
        if aProductJson.ArrayExists('tags')               then Maketags(aProductJson.A['tags'] );
        if aProductJson.ArrayExists('images')             then Makeimages(aProductJson.A['images'] );
        if aProductJson.ArrayExists('attributes')         then Makeattributes(aProductJson.A['attributes'] );
        if aProductJson.ArrayExists('default_attributes') then MakeDefattributes(aProductJson.A['default_attributes'] );
        if aProductJson.ArrayExists('meta_data')          then MakeMetaData(aProductJson.A['meta_data'] );
    end;
    ChecknMakeERPProduct;
    Result := true;
end;
Procedure Twoocommerceproducts.ChecknMakeERPProduct(onCreateProduct:TNotifyEvent=nil);
var
  ProductSimple : TProductSimple;
begin
        ProductSimple := TProductSimple.create(nil);
        try
          with ProductSimple do begin
            connection :=Self.connection;
            LoadSelect('Partname =' + quotedstr(Self.ProductnameforERP));
            if count =0 then begin
              new;
              try Productname         := Self.ProductnameforERP;         Except end;
              try ProductPrintName    := Self.Productname;                           Except end;
              try SalesDescription    :=  Self.ProductDescriptionforERP; Except end;
              try PurchaseDescription :=  Self.ProductDescriptionforERP; Except end;
              try SellQty1Price :=  strTofloat(Self.Price);       Except on E:Exception do begin SellQty1Price :=  0; end; end;
              try PostDB; Except end;
              if Assigned(onCreateProduct) then onCreateProduct(ProductSimple);
            end;
            Self.ERPProductId := ID;
            Self.PostDB;
          end;
        finally
          Freeandnil(ProductSimple);
        end;
end;

{Twoocommerceproducttags}

constructor Twoocommerceproducttags.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproducttags';
  fSQL := 'SELECT * FROM tblwoocommerceproducttags';
end;


destructor Twoocommerceproducttags.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproducttags.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TagName');
  SetPropertyFromNode(node,'slug');
end;


procedure Twoocommerceproducttags.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TagName' ,TagName);
  AddXMLNode(node,'slug' ,slug);
end;


function Twoocommerceproducttags.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproducttags.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproducttags.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceproducttags.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproducttags.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproducttags.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproducttags.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproducttags';
end;


function Twoocommerceproducttags.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproducttags.GetTagName                 : string    ; begin Result := GetStringField('name');end;
function  Twoocommerceproducttags.Getslug                 : string    ; begin Result := GetStringField('slug');end;
procedure Twoocommerceproducttags.SetTagName                 (const Value: string    ); begin SetStringField('name'                  , Value);end;
procedure Twoocommerceproducttags.Setslug                 (const Value: string    ); begin SetStringField('slug'                  , Value);end;


{Twoocommerceproductattribs}

constructor Twoocommerceproductattribs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproductattribs';
  fSQL := 'SELECT * FROM tblwoocommerceproductattribs';
end;


destructor Twoocommerceproductattribs.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproductattribs.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'AttribName');
  SetPropertyFromNode(node,'position');
  SetBooleanPropertyFromNode(node,'visible');
  SetBooleanPropertyFromNode(node,'variation');
end;


procedure Twoocommerceproductattribs.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'AttribName' ,AttribName);
  AddXMLNode(node,'position' ,position);
  AddXMLNode(node,'visible' ,visible);
  AddXMLNode(node,'variation' ,variation);
end;


function Twoocommerceproductattribs.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproductattribs.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproductattribs.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceproductattribs.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproductattribs.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproductattribs.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproductattribs.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproductattribs';
end;


function Twoocommerceproductattribs.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproductattribs.GetAttribName     : string    ; begin Result := GetStringField('name');end;
function  Twoocommerceproductattribs.Getposition : Integer   ; begin Result := GetIntegerField('position');end;
function  Twoocommerceproductattribs.Getvisible  : Boolean   ; begin Result := GetBooleanField('visible');end;
function  Twoocommerceproductattribs.Getvariation: Boolean   ; begin Result := GetBooleanField('variation');end;
procedure Twoocommerceproductattribs.SetAttribName     (const Value: string    ); begin SetStringField('name'      , Value);end;
procedure Twoocommerceproductattribs.Setposition (const Value: Integer   ); begin SetIntegerField('position' , Value);end;
procedure Twoocommerceproductattribs.Setvisible  (const Value: Boolean   ); begin SetBooleanField('visible'   , Value);end;
procedure Twoocommerceproductattribs.Setvariation(const Value: Boolean   ); begin SetBooleanField('variation' , Value);end;


{Twoocommerceproductcategories}

constructor Twoocommerceproductcategories.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproductcategories';
  fSQL := 'SELECT * FROM tblwoocommerceproductcategories';
end;


destructor Twoocommerceproductcategories.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproductcategories.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'categoryName');
  SetPropertyFromNode(node,'slug');
end;


procedure Twoocommerceproductcategories.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'categoryName' ,categoryName);
  AddXMLNode(node,'slug' ,slug);
end;


function Twoocommerceproductcategories.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproductcategories.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproductcategories.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceproductcategories.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproductcategories.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproductcategories.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproductcategories.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproductcategories';
end;


function Twoocommerceproductcategories.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproductcategories.GetcategoryName     : string    ; begin Result := GetStringField('name');end;
function  Twoocommerceproductcategories.Getslug     : string    ; begin Result := GetStringField('slug');end;
procedure Twoocommerceproductcategories.SetcategoryName     (const Value: string    ); begin SetStringField('name'      , Value);end;
procedure Twoocommerceproductcategories.Setslug     (const Value: string    ); begin SetStringField('slug'      , Value);end;


 {Twoocommerceproductdefattribs}

constructor Twoocommerceproductdefattribs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproductdefattribs';
  fSQL := 'SELECT * FROM tblwoocommerceproductdefattribs';
end;


destructor Twoocommerceproductdefattribs.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproductdefattribs.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DefattribName');
end;


procedure Twoocommerceproductdefattribs.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DefattribName' ,DefattribName);
end;


function Twoocommerceproductdefattribs.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproductdefattribs.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproductdefattribs.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceproductdefattribs.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproductdefattribs.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproductdefattribs.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproductdefattribs.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproductdefattribs';
end;


function Twoocommerceproductdefattribs.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproductdefattribs.GetDefattribName     : string    ; begin Result := GetStringField('name');end;
procedure Twoocommerceproductdefattribs.SetDefattribName     (const Value: string    ); begin SetStringField('name'      , Value);end;


{Twoocommerceproductdimension}

constructor Twoocommerceproductdimension.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproductdimension';
  fSQL := 'SELECT * FROM tblwoocommerceproductdimension';
end;


destructor Twoocommerceproductdimension.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproductdimension.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'length');
  SetPropertyFromNode(node,'width');
  SetPropertyFromNode(node,'height');
end;


procedure Twoocommerceproductdimension.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'length' ,length);
  AddXMLNode(node,'width' ,width);
  AddXMLNode(node,'height' ,height);
end;


function Twoocommerceproductdimension.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproductdimension.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproductdimension.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceproductdimension.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproductdimension.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproductdimension.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproductdimension.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproductdimension';
end;


function Twoocommerceproductdimension.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproductdimension.Getlength   : string    ; begin Result := GetStringField('length');end;
function  Twoocommerceproductdimension.Getwidth    : string    ; begin Result := GetStringField('width');end;
function  Twoocommerceproductdimension.Getheight   : string    ; begin Result := GetStringField('height');end;
procedure Twoocommerceproductdimension.Setlength   (const Value: string    ); begin SetStringField('length'    , Value);end;
procedure Twoocommerceproductdimension.Setwidth    (const Value: string    ); begin SetStringField('width'     , Value);end;
procedure Twoocommerceproductdimension.Setheight   (const Value: string    ); begin SetStringField('height'    , Value);end;


{TwoocommerceproductDownLoads}

constructor TwoocommerceproductDownLoads.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproductDownLoads';
  fSQL := 'SELECT * FROM tblwoocommerceproductDownLoads';
end;


destructor TwoocommerceproductDownLoads.Destroy;
begin
  inherited;
end;


procedure TwoocommerceproductDownLoads.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DownLoadName');
  SetPropertyFromNode(node,'DownloadFile');
end;


procedure TwoocommerceproductDownLoads.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DownLoadName' ,DownLoadName);
  AddXMLNode(node,'DownloadFile' ,DownloadFile);
end;


function TwoocommerceproductDownLoads.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TwoocommerceproductDownLoads.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TwoocommerceproductDownLoads.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TwoocommerceproductDownLoads.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TwoocommerceproductDownLoads.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TwoocommerceproductDownLoads.GetIDField: string;
begin
  Result := 'ID'
end;


class function TwoocommerceproductDownLoads.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproductDownLoads';
end;


function TwoocommerceproductDownLoads.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TwoocommerceproductDownLoads.GetDownLoadName : string    ; begin Result := GetStringField('name');end;
function  TwoocommerceproductDownLoads.GetDownloadFile : string    ; begin Result := GetStringField('file');end;
procedure TwoocommerceproductDownLoads.SetDownLoadName (const Value: string    ); begin SetStringField('name'      , Value);end;
procedure TwoocommerceproductDownLoads.SetDownloadFile  (const Value: string    ); begin SetStringField('file'      , Value);end;


{Twoocommerceproductimages}

constructor Twoocommerceproductimages.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproductimages';
  fSQL := 'SELECT * FROM tblwoocommerceproductimages';
end;


destructor Twoocommerceproductimages.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproductimages.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'date_created');
  SetDateTimePropertyFromNode(node,'date_created_gmt');
  SetDateTimePropertyFromNode(node,'date_modified');
  SetDateTimePropertyFromNode(node,'date_modified_gmt');
  SetPropertyFromNode(node,'src');
  SetPropertyFromNode(node,'ImageName');
  SetPropertyFromNode(node,'alt');
end;


procedure Twoocommerceproductimages.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'date_created' ,date_created);
  AddXMLNode(node,'date_created_gmt' ,date_created_gmt);
  AddXMLNode(node,'date_modified' ,date_modified);
  AddXMLNode(node,'date_modified_gmt' ,date_modified_gmt);
  AddXMLNode(node,'src' ,src);
  AddXMLNode(node,'ImageName' ,ImageName);
  AddXMLNode(node,'alt' ,alt);
end;


function Twoocommerceproductimages.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproductimages.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproductimages.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceproductimages.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproductimages.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproductimages.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproductimages.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproductimages';
end;


function Twoocommerceproductimages.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproductimages.Getdate_created     : TDateTime ; begin Result := GetDateTimeField('date_created');end;
function  Twoocommerceproductimages.Getdate_created_gmt : TDateTime ; begin Result := GetDateTimeField('date_created_gmt');end;
function  Twoocommerceproductimages.Getdate_modified    : TDateTime ; begin Result := GetDateTimeField('date_modified');end;
function  Twoocommerceproductimages.Getdate_modified_gmt: TDateTime ; begin Result := GetDateTimeField('date_modified_gmt');end;
function  Twoocommerceproductimages.Getsrc              : string    ; begin Result := GetStringField('src');end;
function  Twoocommerceproductimages.GetImageName        : string    ; begin Result := GetStringField('name');end;
function  Twoocommerceproductimages.Getalt              : string    ; begin Result := GetStringField('alt');end;
procedure Twoocommerceproductimages.Setdate_created     (const Value: TDateTime ); begin SetDateTimeField('date_created'      , Value);end;
procedure Twoocommerceproductimages.Setdate_created_gmt (const Value: TDateTime ); begin SetDateTimeField('date_created_gmt' , Value);end;
procedure Twoocommerceproductimages.Setdate_modified    (const Value: TDateTime ); begin SetDateTimeField('date_modified'     , Value);end;
procedure Twoocommerceproductimages.Setdate_modified_gmt(const Value: TDateTime ); begin SetDateTimeField('date_modified_gmt' , Value);end;
procedure Twoocommerceproductimages.Setsrc              (const Value: string    ); begin SetStringField('src'               , Value);end;
procedure Twoocommerceproductimages.SetImageName        (const Value: string    ); begin SetStringField('name'              , Value);end;
procedure Twoocommerceproductimages.Setalt              (const Value: string    ); begin SetStringField('alt'               , Value);end;


{Twoocommerceproductmetadata}

constructor Twoocommerceproductmetadata.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceproductmetadata';
  fSQL := 'SELECT * FROM tblwoocommerceproductmetadata';
end;


destructor Twoocommerceproductmetadata.Destroy;
begin
  inherited;
end;


procedure Twoocommerceproductmetadata.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'metadatakey');
  SetPropertyFromNode(node,'metadatavalue');
end;


procedure Twoocommerceproductmetadata.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'metadatakey' ,metadatakey);
  AddXMLNode(node,'metadatavalue' ,metadatavalue);
end;


function Twoocommerceproductmetadata.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceproductmetadata.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceproductmetadata.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceproductmetadata.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceproductmetadata.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceproductmetadata.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceproductmetadata.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceproductmetadata';
end;


function Twoocommerceproductmetadata.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceproductmetadata.Getmetadatakey      : string    ; begin Result := GetStringField('metadatakey');end;
function  Twoocommerceproductmetadata.Getmetadatavalue    : string    ; begin Result := GetStringField('metadatavalue');end;
procedure Twoocommerceproductmetadata.Setmetadatakey      (const Value: string    ); begin SetStringField('metadatakey'       , Value);end;
procedure Twoocommerceproductmetadata.Setmetadatavalue    (const Value: string    ); begin SetStringField('metadatavalue'     , Value);end;


initialization
  RegisterClass(Twoocommerceproducts);
  RegisterClass(Twoocommerceproductmetadata);
  RegisterClass(Twoocommerceproductimages);
  RegisterClass(TwoocommerceproductDownLoads);
  RegisterClass(Twoocommerceproductdimension);
  RegisterClass(Twoocommerceproductdefattribs);
  RegisterClass(Twoocommerceproductcategories);
  RegisterClass(Twoocommerceproductattribs);
  RegisterClass(Twoocommerceproducttags);


end.
