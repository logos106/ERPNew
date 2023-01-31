unit BusobjWoocommerceOrders;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  17/06/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, JSONObject, XMLIntf, BusobjWooCommerceItems;


type
  TOnWooCommOrderCreate = Procedure (Const WooOrderID :Integer) of Object;

  TWooCommerceBase= class(TMSBusObj)
    Private
    Protected
      function GetWooOrderID       : Integer   ;Virtual;
      procedure SetWooOrderID       (const Value: Integer   );Virtual;
      function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Public
      Function WooOrderIDFromOrder :Integer;
    Published
      property WooOrderID        :Integer     read GetWooOrderID      write SetWooOrderID        ;

  end;

  TWooCommerceMetaData = class(TWooCommerceBase)
  private
    function GetWooID            : Integer   ;
    function GetmetadataID       : Integer   ;
    function Getmetadatatype     : string    ;
    function Getmetadatakey      : string    ;
    function Getmetadatavalue    : string    ;
    procedure SetWooID            (const Value: Integer   );
    procedure SetmetadataID       (const Value: Integer   );
    procedure Setmetadatatype     (const Value: string    );
    procedure Setmetadatakey      (const Value: string    );
    procedure Setmetadatavalue    (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property WooID             :Integer     read GetWooID           write SetWooID        ;
    property metadataID        :Integer     read GetmetadataID      write SetmetadataID   ;
    property metadatatype      :string      read Getmetadatatype    write Setmetadatatype ;
    property metadatakey       :string      read Getmetadatakey     write Setmetadatakey  ;
    property metadatavalue     :string      read Getmetadatavalue   write Setmetadatavalue;
  end;

  TwoocommerceOrderBase= class(TWooCommerceBase)
    Private
      function getMetaData: TWooCommerceMetaData;
    Protected
      Function WooCommTypeName:String;virtual;
      function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Public
    Published
      Property Metadata : TWooCommerceMetaData read getMetaData;
  end;


  Twoocommerceordertax = class(TwoocommerceOrderBase)
  private
    function GetWooID         : Integer   ;
    function Gettotal         : Double    ;
    function Getsubtotal      : Double    ;
    function GetTaxtype       : string    ;
    procedure SetWooID         (const Value: Integer   );
    procedure Settotal         (const Value: Double    );
    procedure Setsubtotal      (const Value: Double    );
    procedure SetTaxtype       (const Value: string    );

    function Getrate_code               : string    ;
    function Getrate_ID                 : string    ;
    function GetTaxLabel                : string    ;
    function Getcompound                : Boolean   ;
    function Gettax_total               : string    ;
    function Getshipping_tax_total      : string    ;
    procedure Setrate_code               (const Value: string    );
    procedure Setrate_ID                 (const Value: string    );
    procedure SetTaxLabel                (const Value: string    );
    procedure Setcompound                (const Value: Boolean   );
    procedure Settax_total               (const Value: string    );
    procedure Setshipping_tax_total      (const Value: string    );

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  WooCommTypeName:String;Override;
    procedure SetWooOrderID    (const Value: Integer   );  override;
    function GetWooOrderID    : Integer   ;  override;
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
    property WooID          :Integer     read GetWooID        write SetWooID     ;
    property WooOrderID     :Integer     read GetWooOrderID   write SetWooOrderID;
    property total          :Double      read Gettotal        write Settotal     ;
    property subtotal       :Double      read Getsubtotal     write Setsubtotal  ;
    property Taxtype        :string      read GetTaxtype      write SetTaxtype   ;
    property rate_code                :string      read Getrate_code              write Setrate_code           ;
    property rate_ID                  :string      read Getrate_ID                write Setrate_ID             ;
    property TaxLabel                 :string      read GetTaxLabel               write SetTaxLabel            ;
    property compound                 :Boolean     read Getcompound               write Setcompound            ;
    property tax_total                :string      read Gettax_total              write Settax_total           ;
    property shipping_tax_total       :string      read Getshipping_tax_total     write Setshipping_tax_total  ;

  end;


  Twoocommerceordercoupon = class(TwoocommerceOrderBase)
  private
    function GetWooID        : Integer   ;
    function Getcode            : string    ;
    function Getdiscount        : string    ;
    function Getdiscount_tax    : string    ;
    procedure SetWooID        (const Value: Integer   );
    procedure Setcode            (const Value: string    );
    procedure Setdiscount        (const Value: string    );
    procedure Setdiscount_tax    (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function WooCommTypeName:String;Override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property WooID         :Integer     read GetWooID       write SetWooID    ;
    property code             :string      read Getcode           write Setcode        ;
    property discount         :string      read Getdiscount       write Setdiscount    ;
    property discount_tax     :string      read Getdiscount_tax   write Setdiscount_tax;

  end;
  TwoocommerceOrderTaxBase = class(TwoocommerceOrderBase)
    Private
    Protected
    Public
      function getwoocommerceordertax: Twoocommerceordertax;
    Published
      Property woocommerceordertax : Twoocommerceordertax read getwoocommerceordertax;

  end;
  Twoocommerceorderfeelines = class(TwoocommerceOrderTaxBase)
private
    function GetWooID      : Integer   ;
    function GetFeeLinesname    : string    ;
    function Gettax_class       : string    ;
    function Gettax_status      : string    ;
    function Gettotal           : string    ;
    function Gettotal_tax       : string    ;
    procedure SetWooID      (const Value: Integer   );
    procedure SetFeeLinesname    (const Value: string    );
    procedure Settax_class       (const Value: string    );
    procedure Settax_status      (const Value: string    );
    procedure Settotal           (const Value: string    );
    procedure Settotal_tax       (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function WooCommTypeName: String;Override;
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
    property WooID       :Integer     read GetWooID     write SetWooID  ;
    property FeeLinesname     :string      read GetFeeLinesname   write SetFeeLinesname;
    property tax_class        :string      read Gettax_class      write Settax_class   ;
    property tax_status       :string      read Gettax_status     write Settax_status  ;
    property total            :string      read Gettotal          write Settotal       ;
    property total_tax        :string      read Gettotal_tax      write Settotal_tax   ;
  end;

  Twoocommerceorderitems = class(TwoocommerceOrderTaxBase)
  private
    function GetWooID         : Integer   ;
    function Getitemsname       : string    ;
    function Getproduct_ID      : Integer   ;
    function Getvariation_ID    : Integer   ;
    function Getquantity        : Integer   ;
    function Gettax_class       : string   ;
    function Getsubtotal        : string    ;
    function Getsubtotal_tax    : string    ;
    function Gettotal           : string    ;
    function Gettotal_tax       : string    ;
    function Getsku             : string    ;
    function Getprice           : string    ;
    function GetERPSalesLineRef : string    ;
    procedure SetWooID         (const Value: Integer   );
    procedure Setitemsname       (const Value: string    );
    procedure Setproduct_ID      (const Value: Integer   );
    procedure Setvariation_ID    (const Value: Integer   );
    procedure Setquantity        (const Value: Integer   );
    procedure Settax_class       (const Value: string   );
    procedure Setsubtotal        (const Value: string    );
    procedure Setsubtotal_tax    (const Value: string    );
    procedure Settotal           (const Value: string    );
    procedure Settotal_tax       (const Value: string    );
    procedure Setsku             (const Value: string    );
    procedure Setprice           (const Value: string    );
    procedure SetERPSalesLineRef (const Value: string    );
    function getProductnameforERP: String;
    function getwoocommerceproduct: Twoocommerceproducts;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function WooCommTypeName:String;Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property woocommerceproduct :Twoocommerceproducts read getwoocommerceproduct;
    Property ProductnameforERP :String read getProductnameforERP;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property WooID            :Integer     read GetWooID        write SetWooID     ;
    property itemsname        :string      read Getitemsname      write Setitemsname   ;
    property product_ID       :Integer     read Getproduct_ID     write Setproduct_ID  ;
    property variation_ID     :Integer     read Getvariation_ID   write Setvariation_ID;
    property quantity         :Integer     read Getquantity       write Setquantity    ;
    property tax_class        :string     read Gettax_class      write Settax_class   ;
    property subtotal         :string      read Getsubtotal       write Setsubtotal    ;
    property subtotal_tax     :string      read Getsubtotal_tax   write Setsubtotal_tax;
    property total            :string      read Gettotal          write Settotal       ;
    property total_tax        :string      read Gettotal_tax      write Settotal_tax   ;
    property sku              :string      read Getsku            write Setsku         ;
    property price            :string      read Getprice          write Setprice       ;
    property ERPSalesLineRef  :string      read GetERPSalesLineRef  write SetERPSalesLineRef ;

  end;

Twoocommerceorderrefund = class(TwoocommerceOrderBase)
  private
    function GetWooID         : Integer   ;
    function Getreason           : string    ;
    function Gettotal            : string    ;
    procedure SetWooID         (const Value: Integer   );
    procedure Setreason           (const Value: string    );
    procedure Settotal            (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property WooID          :Integer     read GetWooID        write SetWooID     ;
    property reason            :string      read Getreason          write Setreason       ;
    property total             :string      read Gettotal           write Settotal        ;
  end;
Twoocommerceordershippinglines = class(TwoocommerceOrderTaxBase)
  private
    function GetWooID         : Integer   ;
    function Getmethod_title            : string    ;
    function Getmethod_ID               : string    ;
    function Gettotal                   : string    ;
    function Gettotal_tax               : string    ;
    procedure SetWooID         (const Value: Integer   );
    procedure Setmethod_title            (const Value: string    );
    procedure Setmethod_ID               (const Value: string    );
    procedure Settotal                   (const Value: string    );
    procedure Settotal_tax               (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function WooCommTypeName:String;Override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property WooID          :Integer     read GetWooID        write SetWooID     ;
    property method_title             :string      read Getmethod_title           write Setmethod_title        ;
    property method_ID                :string      read Getmethod_ID              write Setmethod_ID           ;
    property total                    :string      read Gettotal                  write Settotal               ;
    property total_tax                :string      read Gettotal_tax              write Settotal_tax           ;

  end;

  Twoocommerceordertaxlines = class(TwoocommerceOrderBase)
  private
    function GetWooID              : Integer   ;
    function Getrate_code               : string    ;
    function Getrate_ID                 : string    ;
    function GetTaxLabel                : string    ;
    function Getcompound                : Boolean   ;
    function Gettax_total               : string    ;
    function Getshipping_tax_total      : string    ;
    procedure SetWooID              (const Value: Integer   );
    procedure Setrate_code               (const Value: string    );
    procedure Setrate_ID                 (const Value: string    );
    procedure SetTaxLabel                (const Value: string    );
    procedure Setcompound                (const Value: Boolean   );
    procedure Settax_total               (const Value: string    );
    procedure Setshipping_tax_total      (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function WooCommTypeName:String;Override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property WooID               :Integer     read GetWooID             write SetWooID          ;
    property rate_code                :string      read Getrate_code              write Setrate_code           ;
    property rate_ID                  :string      read Getrate_ID                write Setrate_ID             ;
    property TaxLabel                 :string      read GetTaxLabel               write SetTaxLabel             ;
    property compound                 :Boolean     read Getcompound               write Setcompound            ;
    property tax_total                :string      read Gettax_total              write Settax_total           ;
    property shipping_tax_total       :string      read Getshipping_tax_total     write Setshipping_tax_total  ;

  end;
Twoocommerceorders = class(TwoocommerceOrderBase)
  private
    AllLinesOk:Boolean;
    Inv:TBusobj;
    function Getparent_ID               : Integer   ;
    function GetWooID          : Integer   ;
    function GetOrdernumber             : string    ;
    function Getorder_key               : string    ;
    function Getcreated_via             : string    ;
    function Getorderversion            : string    ;
    function Getorderstatus             : string    ;
    function Getcurrency                : string    ;
    function Getdate_created            : TDateTime ;
    function Getdate_created_gmt        : TDateTime ;
    function Getdate_modified           : TDateTime ;
    function Getdate_modified_gmt       : TDateTime ;
    function Getdiscount_total          : string    ;
    function Getdiscount_tax            : string    ;
    function Getshipping_total          : string    ;
    function Getshipping_tax            : string    ;
    function Getcart_tax                : string    ;
    function Gettotal                   : string    ;
    function Gettotal_tax               : string    ;
    function Getprices_include_tax      : Boolean   ;
    function Getcustomer_ID             : Integer   ;
    function Getcustomer_ip_address     : string    ;
    function Getcustomer_user_agent     : string    ;
    function Getcustomer_note           : string    ;
    function Getpayment_method          : string    ;
    function Getpayment_method_title    : string    ;
    function Gettransaction_ID          : string    ;
    function Getdate_paID               : TDateTime ;
    function Getdate_paid_gmt           : TDateTime ;
    function Getdate_completed          : TDateTime ;
    function Getdate_completed_gmt      : TDateTime ;
    function Getcart_hash               : string    ;
    function GetBillingfirst_name       : string    ;
    function GetBillinglast_name        : string    ;
    function GetBillingcompany          : string    ;
    function GetBillingaddress_1        : string    ;
    function GetBillingaddress_2        : string    ;
    function GetBillingcity             : string    ;
    function GetBillingstate            : string    ;
    function GetBillingpostcode         : string    ;
    function GetBillingcountry          : string    ;
    function GetBillingemail            : string    ;
    function GetBillingphone            : string    ;
    function GetShippingfirst_name      : string    ;
    function GetShippinglast_name       : string    ;
    function GetShippingcompany         : string    ;
    function GetShippingaddress_1       : string    ;
    function GetShippingaddress_2       : string    ;
    function GetShippingcity            : string    ;
    function GetShippingstate           : string    ;
    function GetShippingpostcode        : string    ;
    function GetShippingcountry         : string    ;
    function GetERPSalesREf         : string    ;
    function GetERPClientID             : Integer   ;
    procedure Setparent_ID               (const Value: Integer   );
    procedure SetWooID          (const Value: Integer   );
    procedure SetOrdernumber             (const Value: string    );
    procedure Setorder_key               (const Value: string    );
    procedure Setcreated_via             (const Value: string    );
    procedure Setorderversion            (const Value: string    );
    procedure Setorderstatus             (const Value: string    );
    procedure Setcurrency                (const Value: string    );
    procedure Setdate_created            (const Value: TDateTime );
    procedure Setdate_created_gmt        (const Value: TDateTime );
    procedure Setdate_modified           (const Value: TDateTime );
    procedure Setdate_modified_gmt       (const Value: TDateTime );
    procedure Setdiscount_total          (const Value: string    );
    procedure Setdiscount_tax            (const Value: string    );
    procedure Setshipping_total          (const Value: string    );
    procedure Setshipping_tax            (const Value: string    );
    procedure Setcart_tax                (const Value: string    );
    procedure Settotal                   (const Value: string    );
    procedure Settotal_tax               (const Value: string    );
    procedure Setprices_include_tax      (const Value: Boolean   );
    procedure Setcustomer_ID             (const Value: Integer   );
    procedure Setcustomer_ip_address     (const Value: string    );
    procedure Setcustomer_user_agent     (const Value: string    );
    procedure Setcustomer_note           (const Value: string    );
    procedure Setpayment_method          (const Value: string    );
    procedure Setpayment_method_title    (const Value: string    );
    procedure Settransaction_ID          (const Value: string    );
    procedure Setdate_paID               (const Value: TDateTime );
    procedure Setdate_paid_gmt           (const Value: TDateTime );
    procedure Setdate_completed          (const Value: TDateTime );
    procedure Setdate_completed_gmt      (const Value: TDateTime );
    procedure Setcart_hash               (const Value: string    );
    procedure SetBillingfirst_name       (const Value: string    );
    procedure SetBillinglast_name        (const Value: string    );
    procedure SetBillingcompany          (const Value: string    );
    procedure SetBillingaddress_1        (const Value: string    );
    procedure SetBillingaddress_2        (const Value: string    );
    procedure SetBillingcity             (const Value: string    );
    procedure SetBillingstate            (const Value: string    );
    procedure SetBillingpostcode         (const Value: string    );
    procedure SetBillingcountry          (const Value: string    );
    procedure SetBillingemail            (const Value: string    );
    procedure SetBillingphone            (const Value: string    );
    procedure SetShippingfirst_name      (const Value: string    );
    procedure SetShippinglast_name       (const Value: string    );
    procedure SetShippingcompany         (const Value: string    );
    procedure SetShippingaddress_1       (const Value: string    );
    procedure SetShippingaddress_2       (const Value: string    );
    procedure SetShippingcity            (const Value: string    );
    procedure SetShippingstate           (const Value: string    );
    procedure SetShippingpostcode        (const Value: string    );
    procedure SetShippingcountry         (const Value: string    );
    procedure SetERPSalesREf         (const Value: string    );
    procedure SetERPClientID             (const Value: Integer   );
    function getwoocommerceorderitems         : Twoocommerceorderitems;
    function getwoocommerceordershippinglines : Twoocommerceordershippinglines;
    function getwoocommerceorderfeelines      : Twoocommerceorderfeelines;
    function getwoocommerceordertaxlines      : Twoocommerceordertaxlines;
    function getwoocommerceordercoupon        : Twoocommerceordercoupon;
    function getwoocommerceorderrefund        : Twoocommerceorderrefund;
    function MakeCustomer: boolean;
    procedure ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure CopyWOtoInvCallback(const Sender: TBusObj; var Abort: Boolean);
    function getcompanyname: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function WooCommTypeName:String;Override;
    function GetWooOrderID       : Integer   ;Override;
    Procedure SetWooOrderID       (const Value: Integer   );Override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Class Function PutOrdersJson(AOwner:TComponent; const OrderJsons :String; OnWooCommOrderCreate:TOnWooCommOrderCreate = nil):Boolean;
    class function PutOrderJson(AOwner:TComponent; aConnection : TMyDacDataConnection;const OrderJson: String): Integer;Overload;
    function PutOrderJson(aOrderJson: TJsonObject;fiWooID:Integer): Integer;Overload;
    Function CopyWooComtoInv :Boolean;
    Property companyname:String read getcompanyname;
  published
    property parent_ID                :Integer     read Getparent_ID              write Setparent_ID           ;
    property WooID                    :Integer     read GetWooID         write SetWooID      ;
    property Ordernumber              :string      read GetOrdernumber            write SetOrdernumber         ;
    property order_key                :string      read Getorder_key              write Setorder_key           ;
    property created_via              :string      read Getcreated_via            write Setcreated_via         ;
    property orderversion             :string      read Getorderversion           write Setorderversion        ;
    property orderstatus              :string      read Getorderstatus            write Setorderstatus         ;
    property currency                 :string      read Getcurrency               write Setcurrency            ;
    property date_created             :TDateTime   read Getdate_created           write Setdate_created        ;
    property date_created_gmt         :TDateTime   read Getdate_created_gmt       write Setdate_created_gmt    ;
    property date_modified            :TDateTime   read Getdate_modified          write Setdate_modified       ;
    property date_modified_gmt        :TDateTime   read Getdate_modified_gmt      write Setdate_modified_gmt   ;
    property discount_total           :string      read Getdiscount_total         write Setdiscount_total      ;
    property discount_tax             :string      read Getdiscount_tax           write Setdiscount_tax        ;
    property shipping_total           :string      read Getshipping_total         write Setshipping_total      ;
    property shipping_tax             :string      read Getshipping_tax           write Setshipping_tax        ;
    property cart_tax                 :string      read Getcart_tax               write Setcart_tax            ;
    property total                    :string      read Gettotal                  write Settotal               ;
    property total_tax                :string      read Gettotal_tax              write Settotal_tax           ;
    property prices_include_tax       :Boolean     read Getprices_include_tax     write Setprices_include_tax  ;
    property customer_ID              :Integer     read Getcustomer_ID            write Setcustomer_ID         ;
    property customer_ip_address      :string      read Getcustomer_ip_address    write Setcustomer_ip_address ;
    property customer_user_agent      :string      read Getcustomer_user_agent    write Setcustomer_user_agent ;
    property customer_note            :string      read Getcustomer_note          write Setcustomer_note       ;
    property payment_method           :string      read Getpayment_method         write Setpayment_method      ;
    property payment_method_title     :string      read Getpayment_method_title   write Setpayment_method_title;
    property transaction_ID           :string      read Gettransaction_ID         write Settransaction_ID      ;
    property date_paID                :TDateTime   read Getdate_paID              write Setdate_paID           ;
    property date_paid_gmt            :TDateTime   read Getdate_paid_gmt          write Setdate_paid_gmt       ;
    property date_completed           :TDateTime   read Getdate_completed         write Setdate_completed      ;
    property date_completed_gmt       :TDateTime   read Getdate_completed_gmt     write Setdate_completed_gmt  ;
    property cart_hash                :string      read Getcart_hash              write Setcart_hash           ;
    property Billingfirst_name        :string      read GetBillingfirst_name      write SetBillingfirst_name   ;
    property Billinglast_name         :string      read GetBillinglast_name       write SetBillinglast_name    ;
    property Billingcompany           :string      read GetBillingcompany         write SetBillingcompany      ;
    property Billingaddress_1         :string      read GetBillingaddress_1       write SetBillingaddress_1    ;
    property Billingaddress_2         :string      read GetBillingaddress_2       write SetBillingaddress_2    ;
    property Billingcity              :string      read GetBillingcity            write SetBillingcity         ;
    property Billingstate             :string      read GetBillingstate           write SetBillingstate        ;
    property Billingpostcode          :string      read GetBillingpostcode        write SetBillingpostcode     ;
    property Billingcountry           :string      read GetBillingcountry         write SetBillingcountry      ;
    property Billingemail             :string      read GetBillingemail           write SetBillingemail        ;
    property Billingphone             :string      read GetBillingphone           write SetBillingphone        ;
    property Shippingfirst_name       :string      read GetShippingfirst_name     write SetShippingfirst_name  ;
    property Shippinglast_name        :string      read GetShippinglast_name      write SetShippinglast_name   ;
    property Shippingcompany          :string      read GetShippingcompany        write SetShippingcompany     ;
    property Shippingaddress_1        :string      read GetShippingaddress_1      write SetShippingaddress_1   ;
    property Shippingaddress_2        :string      read GetShippingaddress_2      write SetShippingaddress_2   ;
    property Shippingcity             :string      read GetShippingcity           write SetShippingcity        ;
    property Shippingstate            :string      read GetShippingstate          write SetShippingstate       ;
    property Shippingpostcode         :string      read GetShippingpostcode       write SetShippingpostcode    ;
    property Shippingcountry          :string      read GetShippingcountry        write SetShippingcountry     ;
    property ERPSalesREf          :string      read GetERPSalesREf        write SetERPSalesREf     ;
    property ERPClientID              :Integer     read GetERPClientID            write SetERPClientID         ;

    Property woocommerceorderitems         : Twoocommerceorderitems         read getwoocommerceorderitems;
    Property woocommerceordertaxlines      : Twoocommerceordertaxlines      read getwoocommerceordertaxlines;
    Property woocommerceordershippinglines : Twoocommerceordershippinglines read getwoocommerceordershippinglines;
    Property woocommerceorderfeelines      : Twoocommerceorderfeelines      read getwoocommerceorderfeelines;
    Property woocommerceordercoupon        : Twoocommerceordercoupon        read getwoocommerceordercoupon;
    Property woocommerceorderrefund        : Twoocommerceorderrefund        read getwoocommerceorderrefund;
  end;

Procedure ChecknMakeERPProduct(woocommerceitem:Twoocommerceproducts; onCreateProduct:TNotifyEvent);

implementation


uses tcDataUtils, CommonLib , sysutils, CommonDbLib, DateTimeUtils,
  LogLib, BusObjClient, tcConst, BusObjSales, BusobjProduct, BusObjConst;

  {TWooCommerceBase}
function TWooCommerceBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  WooOrderId := WooOrderIDFromOrder;
end;

function TWooCommerceBase.GetWooOrderID       : Integer   ;    begin Result := GetIntegerField('WooOrderID');end;
procedure TWooCommerceBase.SetWooOrderID       (const Value: Integer   ); begin SetIntegerField('WooOrderID'     , Value);end;
function TWooCommerceBase.WooOrderIDFromOrder: Integer;
var
  ownerobj:TComponent;
begin
  result := 0;
  if self is  Twoocommerceorders then result := ID
  else begin
    ownerobj := Owner;
    While ownerobj <> nil do begin
      if ownerobj is Twoocommerceorders then begin
        result := Twoocommerceorders(ownerobj).ID;
        Exit;
      end;
      ownerobj := ownerobj.Owner;
    end;
  end;

end;

{TWooCommerceMetaData}

constructor TWooCommerceMetaData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceordermetadata';
  fSQL := 'SELECT * FROM tblwoocommerceordermetadata';
end;


destructor TWooCommerceMetaData.Destroy;
begin
  inherited;
end;


procedure TWooCommerceMetaData.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'metadataID');
  SetPropertyFromNode(node,'metadatatype');
  SetPropertyFromNode(node,'metadatakey');
  SetPropertyFromNode(node,'metadatavalue');
end;


procedure TWooCommerceMetaData.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'metadataID' ,metadataID);
  AddXMLNode(node,'metadatatype' ,metadatatype);
  AddXMLNode(node,'metadatakey' ,metadatakey);
  AddXMLNode(node,'metadatavalue' ,metadatavalue);
end;


function TWooCommerceMetaData.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TWooCommerceMetaData.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWooCommerceMetaData.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWooCommerceMetaData.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TWooCommerceMetaData.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWooCommerceMetaData.GetIDField: string;
begin
  Result := 'ID'
end;


class function TWooCommerceMetaData.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceordermetadata';
end;


function TWooCommerceMetaData.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function TWooCommerceMetaData.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
  if Assigned(Owner) then begin
    if Owner is TwoocommerceOrderBase then begin
      metadataID         := TwoocommerceOrderBase(Owner).ID;
      metadatatype      := TwoocommerceOrderBase(Owner).WooCommTypeName;
    end;
  end;
end;


{Property Functions}
function  TWooCommerceMetaData.GetWooID        : Integer   ; begin Result := GetIntegerField('WooID');end;
function  TWooCommerceMetaData.GetmetadataID   : Integer   ; begin Result := GetIntegerField('metadataID');end;
function  TWooCommerceMetaData.Getmetadatatype : string    ; begin Result := GetStringField('metadatatype');end;
function  TWooCommerceMetaData.Getmetadatakey  : string    ; begin Result := GetStringField('metadatakey');end;
function  TWooCommerceMetaData.Getmetadatavalue: string    ; begin Result := GetStringField('metadatavalue');end;
procedure TWooCommerceMetaData.SetWooID        (const Value: Integer   ); begin SetIntegerField('WooID'         , Value);end;
procedure TWooCommerceMetaData.SetmetadataID   (const Value: Integer   ); begin SetIntegerField('metadataID'    , Value);end;
procedure TWooCommerceMetaData.Setmetadatatype (const Value: string    ); begin SetStringField('metadatatype' , Value);end;
procedure TWooCommerceMetaData.Setmetadatakey  (const Value: string    ); begin SetStringField('metadatakey'   , Value);end;
procedure TWooCommerceMetaData.Setmetadatavalue(const Value: string    ); begin SetStringField('metadatavalue' , Value);end;

{ TwoocommerceOrderBase }

function TwoocommerceOrderBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

function TwoocommerceOrderBase.getMetaData: TWooCommerceMetaData;
begin
    REsult := TWooCommerceMetaData (Getcontainercomponent(TWooCommerceMetaData , 'metadatatype =' + quotedstr(WooCommTypeName)+' and metadataid =' + inttostr(ID)));
end;

function TwoocommerceOrderBase.WooCommTypeName: String;
begin
  REsult := Classname;
end;

{Twoocommerceordertax}

constructor Twoocommerceordertax.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceordertax';
  fSQL := 'SELECT * FROM tblwoocommerceordertax';
end;


destructor Twoocommerceordertax.Destroy;
begin
  inherited;
end;


procedure Twoocommerceordertax.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'WooOrderID');
  SetPropertyFromNode(node,'total');
  SetPropertyFromNode(node,'subtotal');
  SetPropertyFromNode(node,'Taxtype');

  SetPropertyFromNode(node,'rate_code');
  SetPropertyFromNode(node,'rate_ID');
  SetPropertyFromNode(node,'TaxLabel');
  SetBooleanPropertyFromNode(node,'compound');
  SetPropertyFromNode(node,'tax_total');
  SetPropertyFromNode(node,'shipping_tax_total');

end;


procedure Twoocommerceordertax.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'WooOrderID' ,WooOrderID);
  AddXMLNode(node,'total' ,total);
  AddXMLNode(node,'subtotal' ,subtotal);
  AddXMLNode(node,'Taxtype' ,Taxtype);
  AddXMLNode(node,'rate_code' ,rate_code);
  AddXMLNode(node,'rate_ID' ,rate_ID);
  AddXMLNode(node,'TaxLabel' ,TaxLabel);
  AddXMLNode(node,'compound' ,compound);
  AddXMLNode(node,'tax_total' ,tax_total);
  AddXMLNode(node,'shipping_tax_total' ,shipping_tax_total);
end;


function Twoocommerceordertax.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceordertax.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceordertax.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceordertax.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceordertax.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceordertax.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceordertax.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceordertax';
end;


function Twoocommerceordertax.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twoocommerceordertax.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;


{Property Functions}
function  Twoocommerceordertax.GetWooID     : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceordertax.GetWooOrderID: Integer   ; begin Result := GetIntegerField('WooOrderID');end;
function  Twoocommerceordertax.Gettotal     : Double    ; begin Result := GetFloatField('total');end;
function  Twoocommerceordertax.Getsubtotal  : Double    ; begin Result := GetFloatField('subtotal');end;
function  Twoocommerceordertax.GetTaxtype   : string    ; begin Result := GetStringField('Taxtype');end;
procedure Twoocommerceordertax.SetWooID     (const Value: Integer   ); begin SetIntegerField('WooID'      , Value);end;
procedure Twoocommerceordertax.SetWooOrderID(const Value: Integer   ); begin SetIntegerField('WooOrderID' , Value);end;
procedure Twoocommerceordertax.Settotal     (const Value: Double    ); begin SetFloatField('total'      , Value);end;
procedure Twoocommerceordertax.Setsubtotal  (const Value: Double    ); begin SetFloatField('subtotal'   , Value);end;
procedure Twoocommerceordertax.SetTaxtype   (const Value: string    ); begin SetStringField('Taxtype'    , Value);end;
function  Twoocommerceordertax.Getrate_code           : string    ; begin Result := GetStringField('rate_code');end;
function  Twoocommerceordertax.Getrate_ID             : string    ; begin Result := GetStringField('rate_ID');end;
function  Twoocommerceordertax.GetTaxLabel            : string    ; begin Result := GetStringField('label');end;
function  Twoocommerceordertax.Getcompound            : Boolean   ; begin Result := GetBooleanField('compound');end;
function  Twoocommerceordertax.Gettax_total           : string    ; begin Result := GetStringField('tax_total');end;
function  Twoocommerceordertax.Getshipping_tax_total  : string    ; begin Result := GetStringField('shipping_tax_total');end;
procedure Twoocommerceordertax.Setrate_code           (const Value: string    ); begin SetStringField('rate_code'            , Value);end;
procedure Twoocommerceordertax.Setrate_ID             (const Value: string    ); begin SetStringField('rate_ID'              , Value);end;
procedure Twoocommerceordertax.SetTaxLabel            (const Value: string    ); begin SetStringField('label'                , Value);end;
procedure Twoocommerceordertax.Setcompound            (const Value: Boolean   ); begin SetBooleanField('compound'             , Value);end;
procedure Twoocommerceordertax.Settax_total           (const Value: string    ); begin SetStringField('tax_total'            , Value);end;
procedure Twoocommerceordertax.Setshipping_tax_total  (const Value: string    ); begin SetStringField('shipping_tax_total'   , Value);end;

  {Twoocommerceordercoupon}

constructor Twoocommerceordercoupon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceordercoupon';
  fSQL := 'SELECT * FROM tblwoocommerceordercoupon';
end;


destructor Twoocommerceordercoupon.Destroy;
begin
  inherited;
end;


procedure Twoocommerceordercoupon.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'code');
  SetPropertyFromNode(node,'discount');
  SetPropertyFromNode(node,'discount_tax');
end;


procedure Twoocommerceordercoupon.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'code' ,code);
  AddXMLNode(node,'discount' ,discount);
  AddXMLNode(node,'discount_tax' ,discount_tax);
end;


function Twoocommerceordercoupon.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceordercoupon.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceordercoupon.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceordercoupon.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceordercoupon.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceordercoupon.GetIDField: string;
begin
  Result := 'ID'
end;
class function Twoocommerceordercoupon.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceordercoupon';
end;


function Twoocommerceordercoupon.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function Twoocommerceordercoupon.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;

{Property Functions}
function  Twoocommerceordercoupon.GetWooID    : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceordercoupon.Getcode        : string    ; begin Result := GetStringField('code');end;
function  Twoocommerceordercoupon.Getdiscount    : string    ; begin Result := GetStringField('discount');end;
function  Twoocommerceordercoupon.Getdiscount_tax: string    ; begin Result := GetStringField('discount_tax');end;
procedure Twoocommerceordercoupon.SetWooID    (const Value: Integer   ); begin SetIntegerField('WooID'     , Value);end;
procedure Twoocommerceordercoupon.Setcode        (const Value: string    ); begin SetStringField('code'         , Value);end;
procedure Twoocommerceordercoupon.Setdiscount    (const Value: string    ); begin SetStringField('discount'     , Value);end;
procedure Twoocommerceordercoupon.Setdiscount_tax(const Value: string    ); begin SetStringField('discount_tax' , Value);end;

{TwoocommerceOrderTaxBase}
Function  TwoocommerceOrderTaxBase.getwoocommerceordertax : Twoocommerceordertax;
begin
  REsult := Twoocommerceordertax (Getcontainercomponent(Twoocommerceordertax , 'TaxType =' + quotedstr(WooCommTypeName)+' and Wooid =' + inttostr(ID)));
end;

  {Twoocommerceorderfeelines}

constructor Twoocommerceorderfeelines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceorderfeelines';
  fSQL := 'SELECT * FROM tblwoocommerceorderfeelines';
end;


destructor Twoocommerceorderfeelines.Destroy;
begin
  inherited;
end;


procedure Twoocommerceorderfeelines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'FeeLinesname');
  SetPropertyFromNode(node,'tax_class');
  SetPropertyFromNode(node,'tax_status');
  SetPropertyFromNode(node,'total');
  SetPropertyFromNode(node,'total_tax');
end;


procedure Twoocommerceorderfeelines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'FeeLinesname' ,FeeLinesname);
  AddXMLNode(node,'tax_class' ,tax_class);
  AddXMLNode(node,'tax_status' ,tax_status);
  AddXMLNode(node,'total' ,total);
  AddXMLNode(node,'total_tax' ,total_tax);
end;


function Twoocommerceorderfeelines.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceorderfeelines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceorderfeelines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceorderfeelines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceorderfeelines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceorderfeelines.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceorderfeelines.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceorderfeelines';
end;


function Twoocommerceorderfeelines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twoocommerceorderfeelines.GetWooID  : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceorderfeelines.GetFeeLinesname: string    ; begin Result := GetStringField('FeeLinesname');end;
function  Twoocommerceorderfeelines.Gettax_class   : string    ; begin Result := GetStringField('tax_class');end;
function  Twoocommerceorderfeelines.Gettax_status  : string    ; begin Result := GetStringField('tax_status');end;
function  Twoocommerceorderfeelines.Gettotal       : string    ; begin Result := GetStringField('total');end;
function  Twoocommerceorderfeelines.Gettotal_tax   : string    ; begin Result := GetStringField('total_tax');end;
procedure Twoocommerceorderfeelines.SetWooID  (const Value: Integer   ); begin SetIntegerField('WooID'   , Value);end;
procedure Twoocommerceorderfeelines.SetFeeLinesname(const Value: string    ); begin SetStringField('FeeLinesname' , Value);end;
procedure Twoocommerceorderfeelines.Settax_class   (const Value: string    ); begin SetStringField('tax_class'    , Value);end;
procedure Twoocommerceorderfeelines.Settax_status  (const Value: string    ); begin SetStringField('tax_status'   , Value);end;
procedure Twoocommerceorderfeelines.Settotal       (const Value: string    ); begin SetStringField('total'        , Value);end;
procedure Twoocommerceorderfeelines.Settotal_tax   (const Value: string    ); begin SetStringField('total_tax'    , Value);end;
  {Twoocommerceorderitems}

constructor Twoocommerceorderitems.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceorderitems';
  fSQL := 'SELECT * FROM tblwoocommerceorderitems';
end;


destructor Twoocommerceorderitems.Destroy;
begin
  inherited;
end;


procedure Twoocommerceorderitems.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'itemsname');
  SetPropertyFromNode(node,'product_ID');
  SetPropertyFromNode(node,'variation_ID');
  SetPropertyFromNode(node,'quantity');
  SetPropertyFromNode(node,'tax_class');
  SetPropertyFromNode(node,'subtotal');
  SetPropertyFromNode(node,'subtotal_tax');
  SetPropertyFromNode(node,'total');
  SetPropertyFromNode(node,'total_tax');
  SetPropertyFromNode(node,'sku');
  SetPropertyFromNode(node,'price');
  SetPropertyFromNode(node,'ERPSalesLineRef');
end;


procedure Twoocommerceorderitems.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'itemsname' ,itemsname);
  AddXMLNode(node,'product_ID' ,product_ID);
  AddXMLNode(node,'variation_ID' ,variation_ID);
  AddXMLNode(node,'quantity' ,quantity);
  AddXMLNode(node,'tax_class' ,tax_class);
  AddXMLNode(node,'subtotal' ,subtotal);
  AddXMLNode(node,'subtotal_tax' ,subtotal_tax);
  AddXMLNode(node,'total' ,total);
  AddXMLNode(node,'total_tax' ,total_tax);
  AddXMLNode(node,'sku' ,sku);
  AddXMLNode(node,'price' ,price);
  AddXMLNode(node,'ERPSalesLineRef' ,ERPSalesLineRef);
end;


function Twoocommerceorderitems.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Trim(itemsname) = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Invalid Product Name - It is Blank', true);
    Exit;
  end;

  Result := True;
end;


function Twoocommerceorderitems.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceorderitems.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceorderitems.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceorderitems.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceorderitems.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceorderitems.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceorderitems';
end;


function Twoocommerceorderitems.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function Twoocommerceorderitems.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;


{Property Functions}
function  Twoocommerceorderitems.GetWooID     : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceorderitems.Getitemsname   : string    ; begin Result := GetStringField('itemsname');end;
function  Twoocommerceorderitems.Getproduct_ID  : Integer   ; begin Result := GetIntegerField('product_ID');end;
function  Twoocommerceorderitems.Getvariation_ID: Integer   ; begin Result := GetIntegerField('variation_ID');end;
function  Twoocommerceorderitems.Getquantity    : Integer   ; begin Result := GetIntegerField('quantity');end;
function  Twoocommerceorderitems.Gettax_class   : string   ; begin Result := GetstringField('tax_class');end;
function  Twoocommerceorderitems.Getsubtotal    : string    ; begin Result := GetStringField('subtotal');end;
function  Twoocommerceorderitems.Getsubtotal_tax: string    ; begin Result := GetStringField('subtotal_tax');end;
function  Twoocommerceorderitems.Gettotal       : string    ; begin Result := GetStringField('total');end;
function  Twoocommerceorderitems.Gettotal_tax   : string    ; begin Result := GetStringField('total_tax');end;
function  Twoocommerceorderitems.Getsku         : string    ; begin Result := GetStringField('sku');end;
function  Twoocommerceorderitems.Getprice       : string    ; begin Result := GetStringField('price');end;
function  Twoocommerceorderitems.GetERPSalesLineRef: string ; begin Result := GetStringField('ERPSalesLineRef');end;
procedure Twoocommerceorderitems.SetWooID     (const Value: Integer   ); begin SetIntegerField('WooID'      , Value);end;
procedure Twoocommerceorderitems.Setitemsname   (const Value: string    ); begin SetStringField('itemsname'    , Value);end;
procedure Twoocommerceorderitems.Setproduct_ID  (const Value: Integer   ); begin SetIntegerField('product_ID'   , Value);end;
procedure Twoocommerceorderitems.Setvariation_ID(const Value: Integer   ); begin SetIntegerField('variation_ID' , Value);end;
procedure Twoocommerceorderitems.Setquantity    (const Value: Integer   ); begin SetIntegerField('quantity'     , Value);end;
procedure Twoocommerceorderitems.Settax_class   (const Value: string   ); begin SetstringField('tax_class'    , Value);end;
procedure Twoocommerceorderitems.Setsubtotal    (const Value: string    ); begin SetStringField('subtotal'     , Value);end;
procedure Twoocommerceorderitems.Setsubtotal_tax(const Value: string    ); begin SetStringField('subtotal_tax' , Value);end;
procedure Twoocommerceorderitems.Settotal       (const Value: string    ); begin SetStringField('total'        , Value);end;
procedure Twoocommerceorderitems.Settotal_tax   (const Value: string    ); begin SetStringField('total_tax'    , Value);end;
procedure Twoocommerceorderitems.Setsku         (const Value: string    ); begin SetStringField('sku'          , Value);end;
procedure Twoocommerceorderitems.Setprice       (const Value: string    ); begin SetStringField('price'        , Value);end;
procedure Twoocommerceorderitems.SetERPSalesLineRef(const Value: string ); begin SetStringField('ERPSalesLineRef', Value);end;
function Twoocommerceorderitems.getProductnameforERP: String;
begin
  result := woocommerceproduct.ProductnameforERP;
end;

function Twoocommerceorderitems.getwoocommerceproduct: Twoocommerceproducts;
begin
  Result := Twoocommerceproducts(Getcontainercomponent(Twoocommerceproducts , 'ProductName = '+ quotedstr(itemsname)));
  if (itemsname<> '') and (Result.count =0) then begin
    REsult.New;
    REsult.ProductName := itemsname;
    REsult.SKU := SKU;
    REsult.PostDB;
  end;
  ChecknMakeERPProduct(result , nil);
end;
Procedure ChecknMakeERPProduct(woocommerceitem:Twoocommerceproducts; onCreateProduct:TNotifyEvent);
begin
 woocommerceitem.ChecknMakeERPProduct(onCreateProduct);
 woocommerceitem.connection.CommitTransaction;
(*var
  ProductSimple : TProductSimple;
begin
        ProductSimple := TProductSimple.create(nil);
        try
          with ProductSimple do begin
            connection :=woocommerceitem.connection;
            LoadSelect(woocommerceitem.ProductSearchSQL);
            if count =0 then begin
              new;
              try Productname         := woocommerceitem.ProductnameforERP;         Except end;
              try ProductPrintName    := Productname;                               Except end;
              try SalesDescription    := woocommerceitem.ProductDescriptionforERP;  Except end;
              try PurchaseDescription := woocommerceitem.ProductDescriptionforERP;  Except end;
              try SellQty1Price :=  strTofloat(woocommerceitem.Price);              Except on E:Exception do begin SellQty1Price :=  0; end; end;
              try PostDB; Except end;
              if Assigned(onCreateProduct) then onCreateProduct(ProductSimple);
            end;
            woocommerceitem.ERPProductId := ID;
            woocommerceitem.PostDB;
          end;
        finally
          Freeandnil(ProductSimple);
        end;
        woocommerceitem.connection.CommitTransaction;*)
end;


{Twoocommerceorderrefund}

constructor Twoocommerceorderrefund.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceorderrefund';
  fSQL := 'SELECT * FROM tblwoocommerceorderrefund';
end;


destructor Twoocommerceorderrefund.Destroy;
begin
  inherited;
end;


procedure Twoocommerceorderrefund.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'reason');
  SetPropertyFromNode(node,'total');
end;


procedure Twoocommerceorderrefund.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'reason' ,reason);
  AddXMLNode(node,'total' ,total);
end;


function Twoocommerceorderrefund.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceorderrefund.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceorderrefund.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceorderrefund.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceorderrefund.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceorderrefund.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twoocommerceorderrefund.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceorderrefund';
end;


function Twoocommerceorderrefund.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function Twoocommerceorderrefund.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;


{Property Functions}
function  Twoocommerceorderrefund.GetWooID     : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceorderrefund.Getreason       : string    ; begin Result := GetStringField('reason');end;
function  Twoocommerceorderrefund.Gettotal        : string    ; begin Result := GetStringField('total');end;
procedure Twoocommerceorderrefund.SetWooID     (const Value: Integer   ); begin SetIntegerField('WooID'      , Value);end;
procedure Twoocommerceorderrefund.Setreason       (const Value: string    ); begin SetStringField('reason'        , Value);end;
procedure Twoocommerceorderrefund.Settotal        (const Value: string    ); begin SetStringField('total'         , Value);end;



{Twoocommerceordershippinglines}

constructor Twoocommerceordershippinglines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceordershippinglines';
  fSQL := 'SELECT * FROM tblwoocommerceordershippinglines';
end;


destructor Twoocommerceordershippinglines.Destroy;
begin
  inherited;
end;


procedure Twoocommerceordershippinglines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'method_title');
  SetPropertyFromNode(node,'method_ID');
  SetPropertyFromNode(node,'total');
  SetPropertyFromNode(node,'total_tax');
end;


procedure Twoocommerceordershippinglines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'method_title' ,method_title);
  AddXMLNode(node,'method_ID' ,method_ID);
  AddXMLNode(node,'total' ,total);
  AddXMLNode(node,'total_tax' ,total_tax);
end;


function Twoocommerceordershippinglines.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceordershippinglines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceordershippinglines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceordershippinglines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceordershippinglines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceordershippinglines.GetIDField: string;
begin
  Result := 'ID'
end;



class function Twoocommerceordershippinglines.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceordershippinglines';
end;


function Twoocommerceordershippinglines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function Twoocommerceordershippinglines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;


{Property Functions}
function  Twoocommerceordershippinglines.GetWooID     : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceordershippinglines.Getmethod_title        : string    ; begin Result := GetStringField('method_title');end;
function  Twoocommerceordershippinglines.Getmethod_ID           : string    ; begin Result := GetStringField('method_ID');end;
function  Twoocommerceordershippinglines.Gettotal               : string    ; begin Result := GetStringField('total');end;
function  Twoocommerceordershippinglines.Gettotal_tax           : string    ; begin Result := GetStringField('total_tax');end;
procedure Twoocommerceordershippinglines.SetWooID     (const Value: Integer   ); begin SetIntegerField('WooID'      , Value);end;
procedure Twoocommerceordershippinglines.Setmethod_title        (const Value: string    ); begin SetStringField('method_title'         , Value);end;
procedure Twoocommerceordershippinglines.Setmethod_ID           (const Value: string    ); begin SetStringField('method_ID'            , Value);end;
procedure Twoocommerceordershippinglines.Settotal               (const Value: string    ); begin SetStringField('total'                , Value);end;
procedure Twoocommerceordershippinglines.Settotal_tax           (const Value: string    ); begin SetStringField('total_tax'            , Value);end;



{Twoocommerceordertaxlines}

constructor Twoocommerceordertaxlines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceordertaxlines';
  fSQL := 'SELECT * FROM tblwoocommerceordertaxlines';
end;


destructor Twoocommerceordertaxlines.Destroy;
begin
  inherited;
end;


procedure Twoocommerceordertaxlines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'rate_code');
  SetPropertyFromNode(node,'rate_ID');
  SetPropertyFromNode(node,'TaxLabel');
  SetBooleanPropertyFromNode(node,'compound');
  SetPropertyFromNode(node,'tax_total');
  SetPropertyFromNode(node,'shipping_tax_total');
end;


procedure Twoocommerceordertaxlines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'rate_code' ,rate_code);
  AddXMLNode(node,'rate_ID' ,rate_ID);
  AddXMLNode(node,'TaxLabel' ,TaxLabel);
  AddXMLNode(node,'compound' ,compound);
  AddXMLNode(node,'tax_total' ,tax_total);
  AddXMLNode(node,'shipping_tax_total' ,shipping_tax_total);
end;


function Twoocommerceordertaxlines.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function Twoocommerceordertaxlines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceordertaxlines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twoocommerceordertaxlines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceordertaxlines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceordertaxlines.GetIDField: string;
begin
  Result := 'ID'
end;



class function Twoocommerceordertaxlines.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceordertaxlines';
end;

function Twoocommerceordertaxlines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function Twoocommerceordertaxlines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;


{Property Functions}
function  Twoocommerceordertaxlines.GetWooID          : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceordertaxlines.Getrate_code           : string    ; begin Result := GetStringField('rate_code');end;
function  Twoocommerceordertaxlines.Getrate_ID             : string    ; begin Result := GetStringField('rate_ID');end;
function  Twoocommerceordertaxlines.GetTaxLabel            : string    ; begin Result := GetStringField('label');end;
function  Twoocommerceordertaxlines.Getcompound            : Boolean   ; begin Result := GetBooleanField('compound');end;
function  Twoocommerceordertaxlines.Gettax_total           : string    ; begin Result := GetStringField('tax_total');end;
function  Twoocommerceordertaxlines.Getshipping_tax_total  : string    ; begin Result := GetStringField('shipping_tax_total');end;
procedure Twoocommerceordertaxlines.SetWooID          (const Value: Integer   ); begin SetIntegerField('WooID'           , Value);end;
procedure Twoocommerceordertaxlines.Setrate_code           (const Value: string    ); begin SetStringField('rate_code'            , Value);end;
procedure Twoocommerceordertaxlines.Setrate_ID             (const Value: string    ); begin SetStringField('rate_ID'              , Value);end;
procedure Twoocommerceordertaxlines.SetTaxLabel            (const Value: string    ); begin SetStringField('label'                , Value);end;
procedure Twoocommerceordertaxlines.Setcompound            (const Value: Boolean   ); begin SetBooleanField('compound'             , Value);end;
procedure Twoocommerceordertaxlines.Settax_total           (const Value: string    ); begin SetStringField('tax_total'            , Value);end;
procedure Twoocommerceordertaxlines.Setshipping_tax_total  (const Value: string    ); begin SetStringField('shipping_tax_total'   , Value);end;

function Twoocommerceorderfeelines.WooCommTypeName      : String;begin  Result := 'FeeLines'      ;end;
function Twoocommerceorderitems.WooCommTypeName         : String;begin  Result := 'line_items'    ;end;
function Twoocommerceorders.WooCommTypeName             : String;begin  Result := 'Order'         ;end;
function Twoocommerceordershippinglines.WooCommTypeName : String;begin  Result := 'shipping_lines';end;
function Twoocommerceordertax.WooCommTypeName           : String;begin  Result := 'Taxes'         ;end;
function Twoocommerceordertaxlines.WooCommTypeName      : String;begin  Result := 'tax_lines '    ;end;
function Twoocommerceordercoupon.WooCommTypeName        : String;begin  Result := 'CoupenLines'   ;end;

 {Twoocommerceorders}
Function Twoocommerceorders.MakeCustomer:boolean;
var
  aClient : TClient;
begin
  result := False;
  aClient := TClient.create(self);
  try

    aClient.Connection := self.Connection;

    {exisitng company with the same name}
    if ERPClientID = 0 then begin
      aClient.loadselect('Company = ' +  quotedstr(companyname));
      if aClient.count >0 then begin
        if aClient.iscustomer = False then begin
          aClient.iscustomer := True;
          aClient.PostDB;
        end;
        ERPClientID :=aClient.ID;
        PostDB;
        Result := True;
        Exit;
      end;
    end;

    {search for cleintID}
    aClient.load(ERPClientID);
    if (aClient.count= 1) then begin
        if aClient.iscustomer = False then begin
          aClient.iscustomer := True;
          aClient.PostDB;
        end;
        Result := True;
        Exit;
    end;

    Connection.beginnestedTransaction;
    try
        aClient.New;
        aClient.ClientName := companyname;
        aClient.PrintName := companyname;

        if Shippingcompany    <> '' then aClient.ClientName  := Shippingcompany     else if Billingcompany     <> '' then aClient.ClientName :=Billingcompany;
        if Shippingfirst_name <> '' then aClient.firstname   := Shippingfirst_name  else if Billingfirst_name  <> '' then aClient.firstname  :=Billingfirst_name;
        if ShippingLast_Name  <> '' then aClient.LastName    := ShippingLast_Name   else if BillingLast_Name   <> '' then aClient.LastName   :=BillingLast_Name;
        if Shippingaddress_1  <> '' then aClient.Street      := Shippingaddress_1   else if Billingaddress_1   <> '' then aClient.Street     :=Billingaddress_1;
        if Shippingaddress_2  <> '' then aClient.Street2     := Shippingaddress_2   else if Billingaddress_2   <> '' then aClient.Street2    :=Billingaddress_2;
        if Shippingcity       <> '' then aClient.Suburb      := Shippingcity        else if Billingcity        <> '' then aClient.Suburb     :=Billingcity;
        if Shippingstate      <> '' then aClient.state       := Shippingstate       else if Billingstate       <> '' then aClient.state      :=Billingstate;
        if Shippingpostcode   <> '' then aClient.postcode    := Shippingpostcode    else if Billingpostcode    <> '' then aClient.postcode   :=Billingpostcode;
        if Shippingcountry    <> '' then aClient.country     := Shippingcountry     else if Billingcountry     <> '' then aClient.country    :=Billingcountry;

        if Billingemail       <> '' then aClient.email       := Billingemail;
        if Billingphone       <> '' then aClient.Phone       := Billingphone;
        if Billingaddress_1   <> '' then aClient.BillStreet  := Billingaddress_1   ;
        if Billingaddress_2   <> '' then aClient.BillStreet2 := Billingaddress_2   ;
        if Billingcity        <> '' then aClient.BillSuburb  := Billingcity        ;
        if Billingstate       <> '' then aClient.Billstate   := Billingstate       ;
        if Billingpostcode    <> '' then aClient.Billpostcode:= Billingpostcode    ;
        if Billingcountry     <> '' then aClient.Billcountry := Billingcountry     ;

        if aClient.firstname = '' then  aClient.firstname:= aClient.ClientName ;
        if aClient.LastName  = '' then  aClient.LastName := '.';
        aClient.MedTypeID   := tcdatautils.getMediatype('WooCommerce');
        aClient.IsCustomer  := True;
        aClient.PostDB;

        aClient.Contacts.New;
        aClient.Contacts.ContactTitle      := aClient.Title;
        aClient.Contacts.ContactFirstName  := aClient.FirstName;
        aClient.Contacts.ContactSurName    := aClient.LastName;
        aClient.Contacts.ContactMOB        := aClient.Mobile;
        aClient.Contacts.jobtitle          := aClient.JobTitle;
        aClient.Contacts.ContactEmail      := aClient.Email;
        aClient.Contacts.Company           := Trim(aClient.FirstName + ' ' + aClient.LastName);
        aClient.Contacts.ISPrimaryContact  := True;
        aClient.Contacts.ContactPH         := aClient.Phone;
        aClient.Contacts.ContactFax        := aClient.FaxNumber;
        aClient.Contacts.ContactAltPH      := aClient.AltPhone;
        aClient.Contacts.ContactAddress    := aClient.Street;
        aClient.Contacts.ContactAddress2   := aClient.Street2;
        aClient.Contacts.ContactAddress3   := aClient.Street3;
        aClient.Contacts.ContactCity       := aClient.Suburb;
        aClient.Contacts.ContactState      := aClient.State;
        aClient.Contacts.ContactPcode      := aClient.Postcode;
        aClient.Contacts.Contactcountry    := aClient.Country;
        aClient.Contacts.TeamviewerID      := aClient.TeamviewerID;
        aClient.Contacts.Active            := True;
        aClient.Contacts.PostDB;
        if aclient.save then begin
          ERPClientID := aClient.ID;
          PostDB;
          Connection.CommitnestedTransaction;
          result := True;
        end else Connection.RollbacknestedTransaction;
      Except
        on E:Exception do begin
          Connection.RollbacknestedTransaction;
        end;
      end;
  finally
    Freeandnil(aclient);
  end;
end;
function Twoocommerceorders.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

(*  if woocommerceorderitems.count =0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'This Order Doesn''t have any Items in it.  It is not possible to create an ERP Order', true);
    Exit;
  end;*)


  if (trim(companyname) = '')  then begin
    Resultstatus.AddItem(False , rssError , 0,  'This Order Has Incomplete Customer Information', true);
    Exit;
  end;

  AllLinesOk := True;
  woocommerceorderitems.iteraterecords(ValidateDataCallback);
  Result := AllLinesOk ;
end;
Procedure Twoocommerceorders.ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);

begin
  if sender = woocommerceorderitems then
    if not woocommerceorderitems.ValidateData then begin
      AllLinesOk:= False;
      Abort := TRue;
    end;
end;

function Twoocommerceorders.CopyWooComtoInv: Boolean;
  function InvObj:TInvoice;
  begin
    result := nil;
    if assigned(Inv) then
      Result := TInvoice(Inv);
  end;
begin
  Result := False;
  if count =0 then exit;
  //if  woocommerceorderitems.count =0 then exit;

  if ERPSalesRef <> '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'ERP order is already created for this Order.' +NL+
                                                'WooCommerce Order #' + inttostr(WooID) +NL+
                                                'ERP Sales Ref #' + ERPSalesRef , true );
    Exit;
  end;

  if not ValidateData then begin
    exit;
  end;

  Connection.BeginTransaction;
  try
    if not MakeCustomer then begin
      Connection.RollbackTransaction;
      REsult := False;
      Exit;
    end;


  if ERPClientID =0 then begin
      Connection.RollbackTransaction;
      REsult := False;
      Exit;
  end;

  Inv:= TBusobj(TInvoice.Create(self));
  try
    InvObj.connection := Self.connection;
    InvObj.Load(0);
    try
        InvObj.SilentMode := True;
        InvObj.New;
        InvObj.CustomerID := ERPClientID;
        InvObj.saleDate        := date_created;
        InvObj.isinternalorder := False;
        InvObj.postdb;

        woocommerceorderitems.IterateRecords(CopyWOtoInvCallback); // the NOT cancelled lines will be copied into the invoice
        if InvObj.Lines.count =0 then begin
          InvObj.Deleted := True;
          InvObj.Comments := InvObj.Comments + NL +
                     ' WooCommerce Invoice Deleted as there was no Products in the Order' ;
          InvObj.PostDB;
        end;
        if not InvObj.Save then begin
          SendEvent(BusObjEvent_Error,BusObjEventVal_convertToinvoice, InvObj);
          InvObj.connection.RollbackTransaction;
          Exit;
        end;
        ERPSalesRef := InvObj.Globalref;
        PostDB;
        SendEvent(BusobjEvent_Event,BusObjEventVal_convertToinvoice, InvObj);
        if not InvObj.PayInvoice(Payment_method_Title , Date_paid) then
          Resultstatus.AddItem(False , rssError , 0,  'Payment Creation for WooCommerce Order #' + inttostr(WooID) +                                                'Failed', true )
        else  SendEvent(BusobjEvent_Event,BusObjEvent_CustPayCreatedForInvoice, InvObj);

        InvObj.connection.CommitTransaction;
        Result := True;
    Except
      on E:Exception do begin
        InvObj.connection.RollbackTransaction;
      end;
    end;
  finally
    Freeandnil(Inv);
  end;
  Except
    on E:Exception do begin
      Connection.RollbackTransaction;
    end;
  end;

end;

Procedure Twoocommerceorders.CopyWOtoInvCallback(Const Sender: TBusObj; Var Abort: Boolean);
function InvObj:TInvoice;
begin
  result := nil;
  if assigned(Inv) then
    Result := TInvoice(Inv);
end;
begin
  if not (Sender is  Twoocommerceorderitems) then exit;
  InvObj.Lines.New;
  InvObj.Lines.ProductName:= Twoocommerceorderitems(Sender).ProductnameforERP;

  InvObj.Lines.UOMQtySold:= Twoocommerceorderitems(Sender).quantity;
  InvObj.Lines.UOMQtyShipped:= Twoocommerceorderitems(Sender).quantity;


  InvObj.Lines.AllowTaxinput := true;  // the tax is not accepted otherwise , and gets recalculated
  try
    if Twoocommerceorderitems(Sender).tax_class <> '' then InvObj.Lines.LineTaxCode    := Twoocommerceorderitems(Sender).tax_class;

    try InvObj.Lines.lineprice      := strTofloat(Twoocommerceorderitems(Sender).price);Except  end;
    try InvObj.Lines.TotalLineAmount:= strTofloat(Twoocommerceorderitems(Sender).total);Except  end;
    try InvObj.Lines.LineTaxTotal   := strTofloat(Twoocommerceorderitems(Sender).total_tax);Except  end;
  finally
    InvObj.Lines.AllowTaxinput := False;
  end;
  InvObj.Lines.PostDB;
  Twoocommerceorderitems(Sender).ERPSalesLineRef :=InvObj.Lines.Globalref;
  Twoocommerceorderitems(Sender).PostDB;

end;
constructor Twoocommerceorders.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'woocommerceorders';
  fSQL := 'SELECT * FROM tblwoocommerceorders';
end;


destructor Twoocommerceorders.Destroy;
begin
  inherited;
end;


procedure Twoocommerceorders.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'parent_ID');
  SetPropertyFromNode(node,'WooID');
  SetPropertyFromNode(node,'Ordernumber');
  SetPropertyFromNode(node,'order_key');
  SetPropertyFromNode(node,'created_via');
  SetPropertyFromNode(node,'orderversion');
  SetPropertyFromNode(node,'orderstatus');
  SetPropertyFromNode(node,'currency');
  SetDateTimePropertyFromNode(node,'date_created');
  SetDateTimePropertyFromNode(node,'date_created_gmt');
  SetDateTimePropertyFromNode(node,'date_modified');
  SetDateTimePropertyFromNode(node,'date_modified_gmt');
  SetPropertyFromNode(node,'discount_total');
  SetPropertyFromNode(node,'discount_tax');
  SetPropertyFromNode(node,'shipping_total');
  SetPropertyFromNode(node,'shipping_tax');
  SetPropertyFromNode(node,'cart_tax');
  SetPropertyFromNode(node,'total');
  SetPropertyFromNode(node,'total_tax');
  SetBooleanPropertyFromNode(node,'prices_include_tax');
  SetPropertyFromNode(node,'customer_ID');
  SetPropertyFromNode(node,'customer_ip_address');
  SetPropertyFromNode(node,'customer_user_agent');
  SetPropertyFromNode(node,'customer_note');
  SetPropertyFromNode(node,'payment_method');
  SetPropertyFromNode(node,'payment_method_title');
  SetPropertyFromNode(node,'transaction_ID');
  SetDateTimePropertyFromNode(node,'date_paID');
  SetDateTimePropertyFromNode(node,'date_paid_gmt');
  SetDateTimePropertyFromNode(node,'date_completed');
  SetDateTimePropertyFromNode(node,'date_completed_gmt');
  SetPropertyFromNode(node,'cart_hash');
  SetPropertyFromNode(node,'Billingfirst_name');
  SetPropertyFromNode(node,'Billinglast_name');
  SetPropertyFromNode(node,'Billingcompany');
  SetPropertyFromNode(node,'Billingaddress_1');
  SetPropertyFromNode(node,'Billingaddress_2');
  SetPropertyFromNode(node,'Billingcity');
  SetPropertyFromNode(node,'Billingstate');
  SetPropertyFromNode(node,'Billingpostcode');
  SetPropertyFromNode(node,'Billingcountry');
  SetPropertyFromNode(node,'Billingemail');
  SetPropertyFromNode(node,'Billingphone');
  SetPropertyFromNode(node,'Shippingfirst_name');
  SetPropertyFromNode(node,'Shippinglast_name');
  SetPropertyFromNode(node,'Shippingcompany');
  SetPropertyFromNode(node,'Shippingaddress_1');
  SetPropertyFromNode(node,'Shippingaddress_2');
  SetPropertyFromNode(node,'Shippingcity');
  SetPropertyFromNode(node,'Shippingstate');
  SetPropertyFromNode(node,'Shippingpostcode');
  SetPropertyFromNode(node,'Shippingcountry');
  SetPropertyFromNode(node,'ERPSalesREf');
  SetPropertyFromNode(node,'ERPClientID');
end;


procedure Twoocommerceorders.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'parent_ID' ,parent_ID);
  AddXMLNode(node,'WooID' ,WooID);
  AddXMLNode(node,'Ordernumber' ,Ordernumber);
  AddXMLNode(node,'order_key' ,order_key);
  AddXMLNode(node,'created_via' ,created_via);
  AddXMLNode(node,'orderversion' ,orderversion);
  AddXMLNode(node,'orderstatus' ,orderstatus);
  AddXMLNode(node,'currency' ,currency);
  AddXMLNode(node,'date_created' ,date_created);
  AddXMLNode(node,'date_created_gmt' ,date_created_gmt);
  AddXMLNode(node,'date_modified' ,date_modified);
  AddXMLNode(node,'date_modified_gmt' ,date_modified_gmt);
  AddXMLNode(node,'discount_total' ,discount_total);
  AddXMLNode(node,'discount_tax' ,discount_tax);
  AddXMLNode(node,'shipping_total' ,shipping_total);
  AddXMLNode(node,'shipping_tax' ,shipping_tax);
  AddXMLNode(node,'cart_tax' ,cart_tax);
  AddXMLNode(node,'total' ,total);
  AddXMLNode(node,'total_tax' ,total_tax);
  AddXMLNode(node,'prices_include_tax' ,prices_include_tax);
  AddXMLNode(node,'customer_ID' ,customer_ID);
  AddXMLNode(node,'customer_ip_address' ,customer_ip_address);
  AddXMLNode(node,'customer_user_agent' ,customer_user_agent);
  AddXMLNode(node,'customer_note' ,customer_note);
  AddXMLNode(node,'payment_method' ,payment_method);
  AddXMLNode(node,'payment_method_title' ,payment_method_title);
  AddXMLNode(node,'transaction_ID' ,transaction_ID);
  AddXMLNode(node,'date_paID' ,date_paID);
  AddXMLNode(node,'date_paid_gmt' ,date_paid_gmt);
  AddXMLNode(node,'date_completed' ,date_completed);
  AddXMLNode(node,'date_completed_gmt' ,date_completed_gmt);
  AddXMLNode(node,'cart_hash' ,cart_hash);
  AddXMLNode(node,'Billingfirst_name' ,Billingfirst_name);
  AddXMLNode(node,'Billinglast_name' ,Billinglast_name);
  AddXMLNode(node,'Billingcompany' ,Billingcompany);
  AddXMLNode(node,'Billingaddress_1' ,Billingaddress_1);
  AddXMLNode(node,'Billingaddress_2' ,Billingaddress_2);
  AddXMLNode(node,'Billingcity' ,Billingcity);
  AddXMLNode(node,'Billingstate' ,Billingstate);
  AddXMLNode(node,'Billingpostcode' ,Billingpostcode);
  AddXMLNode(node,'Billingcountry' ,Billingcountry);
  AddXMLNode(node,'Billingemail' ,Billingemail);
  AddXMLNode(node,'Billingphone' ,Billingphone);
  AddXMLNode(node,'Shippingfirst_name' ,Shippingfirst_name);
  AddXMLNode(node,'Shippinglast_name' ,Shippinglast_name);
  AddXMLNode(node,'Shippingcompany' ,Shippingcompany);
  AddXMLNode(node,'Shippingaddress_1' ,Shippingaddress_1);
  AddXMLNode(node,'Shippingaddress_2' ,Shippingaddress_2);
  AddXMLNode(node,'Shippingcity' ,Shippingcity);
  AddXMLNode(node,'Shippingstate' ,Shippingstate);
  AddXMLNode(node,'Shippingpostcode' ,Shippingpostcode);
  AddXMLNode(node,'Shippingcountry' ,Shippingcountry);
  AddXMLNode(node,'ERPSalesREf' ,ERPSalesREf);
  AddXMLNode(node,'ERPClientID' ,ERPClientID);
end;



function Twoocommerceorders.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twoocommerceorders.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;



procedure Twoocommerceorders.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twoocommerceorders.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twoocommerceorders.GetIDField: string;
begin
  Result := 'ID'
end;



class function Twoocommerceorders.GetBusObjectTablename: string;
begin
  Result:= 'tblwoocommerceorders';
end;


function Twoocommerceorders.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not Result then Exit;
end;
function Twoocommerceorders.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then Exit;
end;


{Property Functions}
function  Twoocommerceorders.Getparent_ID           : Integer   ; begin Result := GetIntegerField('parent_ID');end;
function  Twoocommerceorders.GetWooID      : Integer   ; begin Result := GetIntegerField('WooID');end;
function  Twoocommerceorders.GetOrdernumber         : string    ; begin Result := GetStringField('Ordernumber');end;
function  Twoocommerceorders.Getorder_key           : string    ; begin Result := GetStringField('order_key');end;
function  Twoocommerceorders.Getcreated_via         : string    ; begin Result := GetStringField('created_via');end;
function  Twoocommerceorders.Getorderversion        : string    ; begin Result := GetStringField('orderversion');end;
function  Twoocommerceorders.Getorderstatus         : string    ; begin Result := GetStringField('orderstatus');end;
function  Twoocommerceorders.Getcurrency            : string    ; begin Result := GetStringField('currency');end;
function  Twoocommerceorders.Getdate_created        : TDateTime ; begin Result := GetDateTimeField('date_created');end;
function  Twoocommerceorders.Getdate_created_gmt    : TDateTime ; begin Result := GetDateTimeField('date_created_gmt');end;
function  Twoocommerceorders.Getdate_modified       : TDateTime ; begin Result := GetDateTimeField('date_modified');end;
function  Twoocommerceorders.Getdate_modified_gmt   : TDateTime ; begin Result := GetDateTimeField('date_modified_gmt');end;
function  Twoocommerceorders.Getdiscount_total      : string    ; begin Result := GetStringField('discount_total');end;
function  Twoocommerceorders.Getdiscount_tax        : string    ; begin Result := GetStringField('discount_tax');end;
function  Twoocommerceorders.Getshipping_total      : string    ; begin Result := GetStringField('shipping_total');end;
function  Twoocommerceorders.Getshipping_tax        : string    ; begin Result := GetStringField('shipping_tax');end;
function  Twoocommerceorders.Getcart_tax            : string    ; begin Result := GetStringField('cart_tax');end;
function  Twoocommerceorders.Gettotal               : string    ; begin Result := GetStringField('total');end;
function  Twoocommerceorders.Gettotal_tax           : string    ; begin Result := GetStringField('total_tax');end;
function  Twoocommerceorders.Getprices_include_tax  : Boolean   ; begin Result := GetBooleanField('prices_include_tax');end;
function  Twoocommerceorders.Getcustomer_ID         : Integer   ; begin Result := GetIntegerField('customer_ID');end;
function  Twoocommerceorders.Getcustomer_ip_address : string    ; begin Result := GetStringField('customer_ip_address');end;
function  Twoocommerceorders.Getcustomer_user_agent : string    ; begin Result := GetStringField('customer_user_agent');end;
function  Twoocommerceorders.Getcustomer_note       : string    ; begin Result := GetStringField('customer_note');end;
function  Twoocommerceorders.Getpayment_method      : string    ; begin Result := GetStringField('payment_method');end;
function  Twoocommerceorders.Getpayment_method_title: string    ; begin Result := GetStringField('payment_method_title');end;
function  Twoocommerceorders.Gettransaction_ID      : string    ; begin Result := GetStringField('transaction_ID');end;
function  Twoocommerceorders.Getdate_paID           : TDateTime ; begin Result := GetDateTimeField('date_paID');end;
function  Twoocommerceorders.Getdate_paid_gmt       : TDateTime ; begin Result := GetDateTimeField('date_paid_gmt');end;
function  Twoocommerceorders.Getdate_completed      : TDateTime ; begin Result := GetDateTimeField('date_completed');end;
function  Twoocommerceorders.Getdate_completed_gmt  : TDateTime ; begin Result := GetDateTimeField('date_completed_gmt');end;
function  Twoocommerceorders.Getcart_hash           : string    ; begin Result := GetStringField('cart_hash');end;
function  Twoocommerceorders.GetBillingfirst_name   : string    ; begin Result := GetStringField('Billingfirst_name');end;
function  Twoocommerceorders.GetBillinglast_name    : string    ; begin Result := GetStringField('Billinglast_name');end;
function  Twoocommerceorders.GetBillingcompany      : string    ; begin Result := GetStringField('Billingcompany');end;
function  Twoocommerceorders.GetBillingaddress_1    : string    ; begin Result := GetStringField('Billingaddress_1');end;
function  Twoocommerceorders.GetBillingaddress_2    : string    ; begin Result := GetStringField('Billingaddress_2');end;
function  Twoocommerceorders.GetBillingcity         : string    ; begin Result := GetStringField('Billingcity');end;
function  Twoocommerceorders.GetBillingstate        : string    ; begin Result := GetStringField('Billingstate');end;
function  Twoocommerceorders.GetBillingpostcode     : string    ; begin Result := GetStringField('Billingpostcode');end;
function  Twoocommerceorders.GetBillingcountry      : string    ; begin Result := GetStringField('Billingcountry');end;
function  Twoocommerceorders.GetBillingemail        : string    ; begin Result := GetStringField('Billingemail');end;
function  Twoocommerceorders.GetBillingphone        : string    ; begin Result := GetStringField('Billingphone');end;
function  Twoocommerceorders.GetShippingfirst_name  : string    ; begin Result := GetStringField('Shippingfirst_name');end;
function  Twoocommerceorders.GetShippinglast_name   : string    ; begin Result := GetStringField('Shippinglast_name');end;
function  Twoocommerceorders.GetShippingcompany     : string    ; begin Result := GetStringField('Shippingcompany');end;
function  Twoocommerceorders.GetShippingaddress_1   : string    ; begin Result := GetStringField('Shippingaddress_1');end;
function  Twoocommerceorders.GetShippingaddress_2   : string    ; begin Result := GetStringField('Shippingaddress_2');end;
function  Twoocommerceorders.GetShippingcity        : string    ; begin Result := GetStringField('Shippingcity');end;
function  Twoocommerceorders.GetShippingstate       : string    ; begin Result := GetStringField('Shippingstate');end;
function  Twoocommerceorders.GetShippingpostcode    : string    ; begin Result := GetStringField('Shippingpostcode');end;
function  Twoocommerceorders.GetShippingcountry     : string    ; begin Result := GetStringField('Shippingcountry');end;
function  Twoocommerceorders.GetERPSalesREf     : string    ; begin Result := GetStringField('ERPSalesREf');end;
function  Twoocommerceorders.GetERPClientID         : Integer   ; begin Result := GetIntegerField('ERPClientID');end;
procedure Twoocommerceorders.Setparent_ID           (const Value: Integer   ); begin SetIntegerField('parent_ID'            , Value);end;
procedure Twoocommerceorders.SetWooID      (const Value: Integer   ); begin SetIntegerField('WooID'       , Value);end;
procedure Twoocommerceorders.SetOrdernumber         (const Value: string    ); begin SetStringField('Ordernumber'          , Value);end;
procedure Twoocommerceorders.Setorder_key           (const Value: string    ); begin SetStringField('order_key'            , Value);end;
procedure Twoocommerceorders.Setcreated_via         (const Value: string    ); begin SetStringField('created_via'          , Value);end;
procedure Twoocommerceorders.Setorderversion        (const Value: string    ); begin SetStringField('orderversion'         , Value);end;
procedure Twoocommerceorders.Setorderstatus         (const Value: string    ); begin SetStringField('orderstatus'          , Value);end;
procedure Twoocommerceorders.Setcurrency            (const Value: string    ); begin SetStringField('currency'             , Value);end;
procedure Twoocommerceorders.Setdate_created        (const Value: TDateTime ); begin SetDateTimeField('date_created'         , Value);end;
procedure Twoocommerceorders.Setdate_created_gmt    (const Value: TDateTime ); begin SetDateTimeField('date_created_gmt'     , Value);end;
procedure Twoocommerceorders.Setdate_modified       (const Value: TDateTime ); begin SetDateTimeField('date_modified'        , Value);end;
procedure Twoocommerceorders.Setdate_modified_gmt   (const Value: TDateTime ); begin SetDateTimeField('date_modified_gmt'    , Value);end;
procedure Twoocommerceorders.Setdiscount_total      (const Value: string    ); begin SetStringField('discount_total'       , Value);end;
procedure Twoocommerceorders.Setdiscount_tax        (const Value: string    ); begin SetStringField('discount_tax'         , Value);end;
procedure Twoocommerceorders.Setshipping_total      (const Value: string    ); begin SetStringField('shipping_total'       , Value);end;
procedure Twoocommerceorders.Setshipping_tax        (const Value: string    ); begin SetStringField('shipping_tax'         , Value);end;
procedure Twoocommerceorders.Setcart_tax            (const Value: string    ); begin SetStringField('cart_tax'             , Value);end;
procedure Twoocommerceorders.Settotal               (const Value: string    ); begin SetStringField('total'                , Value);end;
procedure Twoocommerceorders.Settotal_tax           (const Value: string    ); begin SetStringField('total_tax'            , Value);end;
procedure Twoocommerceorders.Setprices_include_tax  (const Value: Boolean   ); begin SetBooleanField('prices_include_tax'   , Value);end;
procedure Twoocommerceorders.Setcustomer_ID         (const Value: Integer   ); begin SetIntegerField('customer_ID'          , Value);end;
procedure Twoocommerceorders.Setcustomer_ip_address (const Value: string    ); begin SetStringField('customer_ip_address' , Value);end;
procedure Twoocommerceorders.Setcustomer_user_agent (const Value: string    ); begin SetStringField('customer_user_agent' , Value);end;
procedure Twoocommerceorders.Setcustomer_note       (const Value: string    ); begin SetStringField('customer_note'        , Value);end;
procedure Twoocommerceorders.Setpayment_method      (const Value: string    ); begin SetStringField('payment_method'       , Value);end;
procedure Twoocommerceorders.Setpayment_method_title(const Value: string    ); begin SetStringField('payment_method_title' , Value);end;
procedure Twoocommerceorders.Settransaction_ID      (const Value: string    ); begin SetStringField('transaction_ID'       , Value);end;
procedure Twoocommerceorders.Setdate_paID           (const Value: TDateTime ); begin SetDateTimeField('date_paID'            , Value);end;
procedure Twoocommerceorders.Setdate_paid_gmt       (const Value: TDateTime ); begin SetDateTimeField('date_paid_gmt'        , Value);end;
procedure Twoocommerceorders.Setdate_completed      (const Value: TDateTime ); begin SetDateTimeField('date_completed'       , Value);end;
procedure Twoocommerceorders.Setdate_completed_gmt  (const Value: TDateTime ); begin SetDateTimeField('date_completed_gmt'   , Value);end;
procedure Twoocommerceorders.Setcart_hash           (const Value: string    ); begin SetStringField('cart_hash'            , Value);end;
procedure Twoocommerceorders.SetBillingfirst_name   (const Value: string    ); begin SetStringField('Billingfirst_name'    , Value);end;
procedure Twoocommerceorders.SetBillinglast_name    (const Value: string    ); begin SetStringField('Billinglast_name'     , Value);end;
procedure Twoocommerceorders.SetBillingcompany      (const Value: string    ); begin SetStringField('Billingcompany'       , Value);end;
procedure Twoocommerceorders.SetBillingaddress_1    (const Value: string    ); begin SetStringField('Billingaddress_1'     , Value);end;
procedure Twoocommerceorders.SetBillingaddress_2    (const Value: string    ); begin SetStringField('Billingaddress_2'     , Value);end;
procedure Twoocommerceorders.SetBillingcity         (const Value: string    ); begin SetStringField('Billingcity'          , Value);end;
procedure Twoocommerceorders.SetBillingstate        (const Value: string    ); begin SetStringField('Billingstate'         , Value);end;
procedure Twoocommerceorders.SetBillingpostcode     (const Value: string    ); begin SetStringField('Billingpostcode'      , Value);end;
procedure Twoocommerceorders.SetBillingcountry      (const Value: string    ); begin SetStringField('Billingcountry'       , Value);end;
procedure Twoocommerceorders.SetBillingemail        (const Value: string    ); begin SetStringField('Billingemail'         , Value);end;
procedure Twoocommerceorders.SetBillingphone        (const Value: string    ); begin SetStringField('Billingphone'         , Value);end;
procedure Twoocommerceorders.SetShippingfirst_name  (const Value: string    ); begin SetStringField('Shippingfirst_name'   , Value);end;
procedure Twoocommerceorders.SetShippinglast_name   (const Value: string    ); begin SetStringField('Shippinglast_name'    , Value);end;
procedure Twoocommerceorders.SetShippingcompany     (const Value: string    ); begin SetStringField('Shippingcompany'      , Value);end;
procedure Twoocommerceorders.SetShippingaddress_1   (const Value: string    ); begin SetStringField('Shippingaddress_1'    , Value);end;
procedure Twoocommerceorders.SetShippingaddress_2   (const Value: string    ); begin SetStringField('Shippingaddress_2'    , Value);end;
procedure Twoocommerceorders.SetShippingcity        (const Value: string    ); begin SetStringField('Shippingcity'         , Value);end;
procedure Twoocommerceorders.SetShippingstate       (const Value: string    ); begin SetStringField('Shippingstate'        , Value);end;
procedure Twoocommerceorders.SetShippingpostcode    (const Value: string    ); begin SetStringField('Shippingpostcode'     , Value);end;
procedure Twoocommerceorders.SetShippingcountry     (const Value: string    ); begin SetStringField('Shippingcountry'      , Value);end;
procedure Twoocommerceorders.SetERPSalesREf     (const Value: string    ); begin SetStringField('ERPSalesREf'      , Value);end;
procedure Twoocommerceorders.SetWooOrderID          (const Value: Integer   ); begin end;
procedure Twoocommerceorders.SetERPClientID         (const Value: Integer   ); begin SetIntegerField('ERPClientID'          , Value);end;
function Twoocommerceorders.getcompanyname: String;
begin
  if trim(Shippingcompany) <> '' then result := trim(Shippingcompany)
  else if trim(Billingcompany) <> '' then result := trim(Billingcompany)
  else if (trim(Shippingfirst_name) <> '') or (trim(Shippinglast_name) <> '') then result := trim((trim(Shippingfirst_name)) +' ' + (trim(Shippinglast_name) ))
  else if (trim(Billingfirst_name ) <> '') or (trim(Billinglast_name ) <> '') then result := trim((trim(Billingfirst_name )) +' ' + (trim(Billinglast_name) ))
  else result := '';
end;


Class function Twoocommerceorders.PutOrdersJson(AOwner:TComponent; const OrderJsons: String; OnWooCommOrderCreate:TOnWooCommOrderCreate = nil): Boolean;
var
  aOrderJsons: TJSONArray;
  ctr1:Integer;
  fiWooID:Integer;
  fConnection : TMyDacDataConnection;
begin
    result := False;
    if OrderJsons = '' then begin
      Result := True;
      Exit;
    end;

    aOrderJsons:= TJSONArray.create;
    try
      fConnection := TMyDAcDataconnection.Create(AOwner);
      fConnection.Connection := GetNewMyDacConnection(AOwner);
      try
        aOrderJsons.asString := OrderJsons;
        for ctr1 := 0 to aOrderJsons.Count-1 do begin
            fConnection.BeginTransaction;
            try
                fiWooID := Twoocommerceorders.PutOrderJson(AOwner,fConnection, aOrderJsons.items[ctr1].asObject.asString);
                if (fiWooID <> 0) and (Assigned(OnWooCommOrderCreate)) then begin
                    OnWooCommOrderCreate(fiWooID );
                      fConnection.CommitTransaction;
                      continue;
                end;
                fConnection.RollbackTransaction;
              Except
                on E:Exception do begin
                  logtext(E.Message);
                  fConnection.RollbackTransaction;
                end;
              end;
          end;
      finally
        Freeandnil (fConnection);
      end;
    finally
      aOrderJsons.Free;
    end;
end;
Class function Twoocommerceorders.PutOrderJson(AOwner:TComponent; aConnection : TMyDacDataConnection;const OrderJson: String): Integer;
var
  aOrderJson: TJsonObject;
  fiWooID:Integer;
  awoocommerceorders :Twoocommerceorders;
begin
  Result := 0;
  if OrderJson = '' then exit;
  aOrderJson := JO;
  aOrderJson.asString := OrderJson;
  fiWooID := aOrderJson.I['id'];
  awoocommerceorders := Twoocommerceorders.Create(AOwner);
  try
    awoocommerceorders.Connection := aConnection;
    awoocommerceorders.Loadselect('WooID = ' + INTTOSTR(fiWooID));
    if awoocommerceorders.count >0 then exit;
    result := awoocommerceorders.PutOrderJson(aOrderJson , fiWooID)
finally
    FreeandNil(awoocommerceorders);
  end;
end;

function Twoocommerceorders.PutOrderJson(aOrderJson: TJsonObject;fiWooID:Integer): Integer;

  Procedure MakeMetaData(aMetaDataArray: TJSONArray; aWooCommerceMetaData:TWooCommerceMetaData);
  var
    ctr:Integer;
    aMetaData :TJSONObject;
  begin
        if aMetaDataArray.Count >0 then begin
          for ctr := 0 to aMetaDataArray.Count-1 do begin
            aMetaData :=TJSONObject(aMetaDataArray.items[ctr]);
            if not aWooCommerceMetaData.Locate('WooID', aMetaData.I['Id'], []) then begin
              aWooCommerceMetaData.New;
              aWooCommerceMetaData.WooID         := aMetaData.I['Id'];
              aWooCommerceMetaData.MetaDatakey   := aMetaData.S['key'];
              aWooCommerceMetaData.MetaDatavalue := aMetaData.S['value'];
              aWooCommerceMetaData.PostDB;
            end;
          end;
        end;
  end;
  Procedure MakelineItemTax(aLineItemTaxArray: TJSONArray; awoocommerceordertax:Twoocommerceordertax);
  var
    ctr:Integer;
    aTaxItem :TJSONObject;
  begin
        if aLineItemTaxArray.Count >0 then begin
          for ctr := 0 to aLineItemTaxArray.Count-1 do begin
            aTaxItem :=TJSONObject(aLineItemTaxArray.items[ctr]);
            if not awoocommerceordertax.locate('WooID', aTaxItem.I['Id'], []) then begin
              awoocommerceordertax.New;
              awoocommerceordertax.WooID        := aTaxItem.I['Id'];
              awoocommerceordertax.subtotal     := aTaxItem.F['subtotal'];
              awoocommerceordertax.total        := aTaxItem.F['total'];
              awoocommerceordertax.PostDB;
              if aTaxItem.ArrayExists('meta_data') then
                MakeMetaData(aTaxItem.A['meta_data'] ,awoocommerceordertax.Metadata);

            end;
          end;
        end;
  end;
  Procedure MakelineItem(aLineItemArray: TJSONArray);
  var
    ctr:Integer;
    aLineItem :TJSONObject;
  begin
        if aLineItemArray.Count >0 then begin
          for ctr := 0 to aLineItemArray.Count-1 do begin
            aLineItem :=TJSONObject(aLineItemArray.items[ctr]);
            if not woocommerceorderitems.locate('WooID', aLineItem.I['Id'], []) then begin
              woocommerceorderitems.New;
              woocommerceorderitems.WooID        := aLineItem.I['Id'];
              woocommerceorderitems.itemsname    := aLineItem.S['name'];
              woocommerceorderitems.product_id   := aLineItem.I['product_id'];
              woocommerceorderitems.variation_id := aLineItem.I['variation_id'];
              woocommerceorderitems.quantity     := aLineItem.I['quantity'];
              woocommerceorderitems.tax_class    := aLineItem.S['tax_class'];
              woocommerceorderitems.subtotal     := aLineItem.S['subtotal'];
              woocommerceorderitems.subtotal_tax := aLineItem.S['subtotal_tax'];
              woocommerceorderitems.total        := aLineItem.S['total'];
              woocommerceorderitems.total_tax    := aLineItem.S['total_tax'];
              woocommerceorderitems.sku          := aLineItem.S['sku'];
              woocommerceorderitems.price        := Floattostr(aLineItem.F['price']);
              woocommerceorderitems.PostDB;
              if aLineItem.ArrayExists('taxes') then
                MakelineItemTax(aLineItem.A['taxes'] , woocommerceorderitems.woocommerceordertax);

              if aLineItem.ArrayExists('meta_data') then
                MakeMetaData(aLineItem.A['meta_data'],woocommerceorderitems.Metadata);

            end;
          end;
        end;
  end;


  Procedure MakeTaxLine(aTaxLineArray: TJSONArray);
  var
    ctr:Integer;
    aTaxLine :TJSONObject;
  begin
        if aTaxLineArray.Count >0 then begin
          for ctr := 0 to aTaxLineArray.Count-1 do begin
            aTaxLine :=TJSONObject(aTaxLineArray.items[ctr]);
            if not woocommerceordertaxlines.locate('WooID', aTaxLine.I['Id'], []) then begin
              woocommerceordertaxlines.New;
              woocommerceordertaxlines.WooID             := aTaxLine.I['Id'];
              woocommerceordertaxlines.rate_code         := aTaxLine.S['rate_code'];
              woocommerceordertaxlines.rate_id           := aTaxLine.S['rate_id'];
              woocommerceordertaxlines.Taxlabel          := aTaxLine.S['label'];
              woocommerceordertaxlines.compound          := aTaxLine.B['compound'];
              woocommerceordertaxlines.tax_total         := aTaxLine.S['tax_total'];
              woocommerceordertaxlines.shipping_tax_total:= aTaxLine.S['shipping_tax_total'];
              woocommerceordertaxlines.postDB;
              if aTaxLine.ArrayExists('meta_data') then
                MakeMetaData(aTaxLine.A['meta_data'] , woocommerceordertaxlines.Metadata);
            end;
          end;
        end;
  end;

  Procedure Makeshipping_lines(ashippinglinesArray: TJSONArray);
  var
    ctr:Integer;
    ashippinglines :TJSONObject;
  begin
        if ashippinglinesArray.Count >0 then begin
          for ctr := 0 to ashippinglinesArray.Count-1 do begin
            ashippinglines :=TJSONObject(ashippinglinesArray.items[ctr]);
            if not woocommerceordershippinglines.locate('WooID', ashippinglines.I['Id'], []) then begin
              woocommerceordershippinglines.New;
              woocommerceordershippinglines.WooID        := ashippinglines.I['Id'];
              woocommerceordershippinglines.method_title	:= ashippinglines.S['method_title'];
              woocommerceordershippinglines.method_id	  := ashippinglines.S['method_id'];
              woocommerceordershippinglines.total	      := ashippinglines.S['total'];
              woocommerceordershippinglines.total_tax	  := ashippinglines.S['total_tax'];
              woocommerceordershippinglines.PostDB;

              if ashippinglines.ArrayExists('meta_data') then
                MakeMetaData(ashippinglines.A['meta_data'] , woocommerceordershippinglines.Metadata);

              if ashippinglines.ArrayExists('taxes') then
                MakelineItemTax(ashippinglines.A['taxes'] , woocommerceordershippinglines.woocommerceordertax);

            end;
          end;
        end;
  end;

  Procedure MakeFee_lines(aFeeLinesArray: TJSONArray);
  var
    ctr:Integer;
    aFeeLines :TJSONObject;
  begin
        if aFeeLinesArray.Count >0 then begin
          for ctr := 0 to aFeeLinesArray.Count-1 do begin
            aFeeLines :=TJSONObject(aFeeLinesArray.items[ctr]);
            if not woocommerceorderFeeLines.locate('WooID', aFeeLines.I['Id'], []) then begin
              woocommerceorderFeeLines.New;
              woocommerceorderFeeLines.WooID       := aFeeLines.I['Id'];


              woocommerceorderFeeLines.FeeLinesname:= aFeeLines.S['FeeLinesname'];
              woocommerceorderFeeLines.tax_class	  := aFeeLines.S['tax_class'];
              woocommerceorderFeeLines.tax_status	:= aFeeLines.S['tax_status'];
              woocommerceorderFeeLines.total	      := aFeeLines.S['total'];
              woocommerceorderFeeLines.total_tax	  := aFeeLines.S['total_tax'];
              woocommerceorderFeeLines.PostDB;

              if aFeeLines.ArrayExists('meta_data') then
                MakeMetaData(aFeeLines.A['meta_data'] , woocommerceorderFeeLines.Metadata);

              if aFeeLines.ArrayExists('taxes') then
                MakelineItemTax(aFeeLines.A['taxes'] , woocommerceorderFeeLines.woocommerceordertax);

            end;
          end;
        end;
  end;

  Procedure Makecoupon_lines(acouponlinesArray: TJSONArray);
  var
    ctr:Integer;
    acouponlines :TJSONObject;
  begin
        if acouponlinesArray.Count >0 then begin
          for ctr := 0 to acouponlinesArray.Count-1 do begin
            acouponlines :=TJSONObject(acouponlinesArray.items[ctr]);
            if not WoocommerceOrderCoupon.locate('WooID', acouponlines.I['Id'], []) then begin
              WoocommerceOrderCoupon.New;
              WoocommerceOrderCoupon.WooID       := acouponlines.I['Id'];
              WoocommerceOrderCoupon.code        := acouponlines.S['code'];
              WoocommerceOrderCoupon.discount	  := acouponlines.S['discount'];
              WoocommerceOrderCoupon.discount_tax:= acouponlines.S['discount_tax'];
              WoocommerceOrderCoupon.PostDB;

              if acouponlines.ArrayExists('meta_data') then
                MakeMetaData(acouponlines.A['meta_data'] , WoocommerceOrderCoupon.Metadata);

            end;
          end;
        end;
  end;

  Procedure Makerefunds(arefundsArray: TJSONArray);
  var
    ctr:Integer;
    arefunds :TJSONObject;
  begin
        if arefundsArray.Count >0 then begin
          for ctr := 0 to arefundsArray.Count-1 do begin
            arefunds :=TJSONObject(arefundsArray.items[ctr]);
            if not woocommerceorderrefund.locate('WooID', arefunds.I['Id'], []) then begin
              woocommerceorderrefund.New;
              woocommerceorderrefund.WooID   := arefunds.I['Id'];
              woocommerceorderrefund.reason  := arefunds.S['reason'];
              woocommerceorderrefund.total	  := arefunds.S['total'];
              woocommerceorderrefund.PostDB;
            end;
          end;
        end;
  end;

begin
(*  Result := 0;
  if OrderJson = '' then exit;
  aOrderJson := JO;
  aOrderJson.asString := OrderJson;
  fiWooID := aOrderJson.I['id'];
  awoocommerceorders := Twoocommerceorders.Create(AOwner);
  try
    Connection := aConnection;
    Loadselect('WooID = ' + INTTOSTR(fiWooID));*)
    if count =0 then begin
      New;
      WooID :=fiWooID;
      parent_id      := aOrderJson.I['parent_id'];
      Ordernumber    := aOrderJson.S['number'];
      order_key      := aOrderJson.S['order_key'];
      created_via    := aOrderJson.S['order_key'];
      orderversion   := aOrderJson.S['version'];
      orderstatus    := aOrderJson.S['status'];
      currency       := aOrderJson.S['currency'];

      try date_created     := ISO8601ToDateTime(aOrderJson.S['date_created']);Except End;
      try date_created_gmt := ISO8601ToDateTime(aOrderJson.S['date_created_gmt']);Except End;
      try date_modified    := ISO8601ToDateTime(aOrderJson.S['date_modified']);Except End;
      try date_modified_gmt:= ISO8601ToDateTime(aOrderJson.S['date_modified_gmt']);Except End;

      discount_total := aOrderJson.S['discount_total'];
      discount_tax   := aOrderJson.S['discount_tax'];
      shipping_total := aOrderJson.S['shipping_total'];
      shipping_tax   := aOrderJson.S['shipping_tax'];
      cart_tax       := aOrderJson.S['cart_tax'];
      total          := aOrderJson.S['total'];
      total_tax      := aOrderJson.S['total_tax'];

      prices_include_tax := aOrderJson.B['prices_include_tax'];

      customer_id        := aOrderJson.I['customer_id'];

      customer_ip_address:= aOrderJson.S['customer_ip_address'];
      customer_user_agent:= aOrderJson.S['customer_user_agent'];
      customer_note      := aOrderJson.S['customer_note'];

      if aOrderJson.ObjectExists('billing') then begin
        Billingfirst_name        := aOrderJson.O['billing'].S['first_name'];
        Billinglast_name         := aOrderJson.O['billing'].S['last_name'];
        Billingcompany           := aOrderJson.O['billing'].S['company'];
        Billingaddress_1         := aOrderJson.O['billing'].S['address_1'];
        Billingaddress_2         := aOrderJson.O['billing'].S['address_2'];
        Billingcity              := aOrderJson.O['billing'].S['city'];
        Billingstate             := aOrderJson.O['billing'].S['state'];
        Billingpostcode          := aOrderJson.O['billing'].S['postcode'];
        Billingcountry           := aOrderJson.O['billing'].S['country'];
        Billingemail             := aOrderJson.O['billing'].S['email'];
        Billingphone             := aOrderJson.O['billing'].S['phone'];
      end;

      if aOrderJson.ObjectExists('shipping') then begin
        shippingfirst_name        := aOrderJson.O['shipping'].S['first_name'];
        shippinglast_name         := aOrderJson.O['shipping'].S['last_name'];
        shippingcompany           := aOrderJson.O['shipping'].S['company'];
        shippingaddress_1         := aOrderJson.O['shipping'].S['address_1'];
        shippingaddress_2         := aOrderJson.O['shipping'].S['address_2'];
        shippingcity              := aOrderJson.O['shipping'].S['city'];
        shippingstate             := aOrderJson.O['shipping'].S['state'];
        shippingpostcode          := aOrderJson.O['shipping'].S['postcode'];
        shippingcountry           := aOrderJson.O['shipping'].S['country'];
      end;
      payment_method       := aOrderJson.S['payment_method'];
      payment_method_title := aOrderJson.S['payment_method_title'];
      transaction_id       := aOrderJson.S['transaction_id'];
      try date_paid          := ISO8601ToDateTime(aOrderJson.S['date_paid']);          Except End;
      try date_paid_gmt      := ISO8601ToDateTime(aOrderJson.S['date_paid_gmt']);      Except End;
      try date_completed     := ISO8601ToDateTime(aOrderJson.S['date_completed']);     Except End;
      try date_completed_gmt := ISO8601ToDateTime(aOrderJson.S['date_completed_gmt']); Except End;
      cart_hash:= aOrderJson.S['cart_hash'];
      PostDB;

      if aOrderJson.ArrayExists('meta_data')      then MakeMetaData(aOrderJson.A['meta_data'] , Metadata);
      if aOrderJson.ArrayExists('line_items')     then MakelineItem(aOrderJson.A['line_items']);
      if aOrderJson.ArrayExists('tax_lines')      then MakeTaxLine(aOrderJson.A['tax_lines']);
      if aOrderJson.ArrayExists('shipping_lines') then Makeshipping_lines(aOrderJson.A['shipping_lines']);
      if aOrderJson.ArrayExists('fee_lines')      then Makefee_lines(aOrderJson.A['fee_lines']);
      if aOrderJson.ArrayExists('coupon_lines')   then Makecoupon_lines(aOrderJson.A['coupon_lines']);
      if aOrderJson.ArrayExists('refunds')        then Makerefunds(aOrderJson.A['refunds']);

    end;

    Result := ID;
end;

function Twoocommerceorders.getwoocommerceorderitems        : Twoocommerceorderitems        ;begin  Result := Twoocommerceorderitems        (Getcontainercomponent(Twoocommerceorderitems         , 'WooOrderID = ' + inttostr(ID)));end;
function Twoocommerceorders.getwoocommerceordershippinglines: Twoocommerceordershippinglines;begin  Result := Twoocommerceordershippinglines(Getcontainercomponent(Twoocommerceordershippinglines , 'WooOrderID = ' + inttostr(ID)));end;
function Twoocommerceorders.getwoocommerceorderfeelines     : Twoocommerceorderfeelines     ;begin  Result := Twoocommerceorderfeelines     (Getcontainercomponent(Twoocommerceorderfeelines      , 'WooOrderID = ' + inttostr(ID)));end;
function Twoocommerceorders.getwoocommerceordertaxlines     : Twoocommerceordertaxlines     ;begin  Result := Twoocommerceordertaxlines     (Getcontainercomponent(Twoocommerceordertaxlines      , 'WooOrderID = ' + inttostr(ID)));end;
function Twoocommerceorders.getwoocommerceordercoupon       : Twoocommerceordercoupon       ;begin  Result := Twoocommerceordercoupon       (Getcontainercomponent(Twoocommerceordercoupon        , 'WooOrderID = ' + inttostr(ID)));end;
function Twoocommerceorders.getwoocommerceorderrefund       : Twoocommerceorderrefund       ;begin  Result := Twoocommerceorderrefund       (Getcontainercomponent(Twoocommerceorderrefund        , 'WooOrderID = ' + inttostr(ID)));end;
function Twoocommerceorders.GetWooOrderID                   : Integer                       ;begin  Result := ID; end;

initialization
  RegisterClass(Twoocommerceordertaxlines);
  RegisterClass(Twoocommerceordertax);
  RegisterClass(Twoocommerceordershippinglines);
  RegisterClass(Twoocommerceorders);
  RegisterClass(Twoocommerceorderrefund);
  RegisterClass(TWooCommerceMetaData);
  RegisterClass(Twoocommerceorderitems);
  RegisterClass(Twoocommerceorderfeelines);
  RegisterClass(Twoocommerceordercoupon);
end.
