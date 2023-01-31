unit BusObjERPWalmartRefunds;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  06/04/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type

  Twalmartrefunds                                   = Class;
  {|---}Twalmartrefundlinegroups                    = Class;
  {  |---}Twalmartrefundgrouplines                  = Class;
  {  |---}Twalmartrefundlinegrouplabels             = Class;
  {    |-------}Twalmartrefundlinegroupcarrierinfo  = Class;
  {|---}Twalmartrefundlines                         = Class;
  {  |-----}Twalmartrefundlinecharges               = Class;
  {    |-------}Twalmartrefundlinechargetax         = Class;
  {    |-------}Twalmartrefundlinechargereferences  = Class;
  {  |-----}Twalmartrefundlinechargestotals         = Class;
  {  |-----}Twalmartrefundlinetrackingdetail        = Class;
  {    |-------}Twalmartrefundlinetrackingdetailref = Class;







  Twalmartrefunds = class(TMSBusObj)
  private
    function GetreturnOrderId                : string    ;
    function GetcustomerEmailId              : string    ;
    function GetCustomerFirstName            : string    ;
    function GetCustomerLastName             : string    ;
    function GetcustomerOrderId              : string    ;
    function GetreturnOrderDate              : string    ;
    function GetreturnByDate                 : string    ;
    function GettotalRefundAmount            : Double    ;
    function GettotalRefundAmountCurrecny    : Double    ;
    function GetreturnChannelName            : string    ;
    procedure SetreturnOrderId                (const Value: string    );
    procedure SetcustomerEmailId              (const Value: string    );
    procedure SetCustomerFirstName            (const Value: string    );
    procedure SetCustomerLastName             (const Value: string    );
    procedure SetcustomerOrderId              (const Value: string    );
    procedure SetreturnOrderDate              (const Value: string    );
    procedure SetreturnByDate                 (const Value: string    );
    procedure SettotalRefundAmount            (const Value: Double    );
    procedure SettotalRefundAmountCurrecny    (const Value: Double    );
    procedure SetreturnChannelName           (const Value: string    );
    function getwalmartrefundlinegroups: Twalmartrefundlinegroups;
    function getwalmartrefundlines: Twalmartrefundlines;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property returnOrderId                 :string      read GetreturnOrderId               write SetreturnOrderId            ;
    property customerEmailId               :string      read GetcustomerEmailId             write SetcustomerEmailId          ;
    property CustomerFirstName             :string      read GetCustomerFirstName           write SetCustomerFirstName        ;
    property CustomerLastName              :string      read GetCustomerLastName            write SetCustomerLastName         ;
    property customerOrderId               :string      read GetcustomerOrderId             write SetcustomerOrderId          ;
    property returnOrderDate               :string      read GetreturnOrderDate             write SetreturnOrderDate          ;
    property returnByDate                  :string      read GetreturnByDate                write SetreturnByDate             ;
    property totalRefundAmount             :Double      read GettotalRefundAmount           write SettotalRefundAmount        ;
    property totalRefundAmountCurrecny     :Double      read GettotalRefundAmountCurrecny   write SettotalRefundAmountCurrecny;
    property returnChannelName             :string      read GetreturnChannelName           write SetreturnChannelName        ;
    Property walmartrefundlinegroups : Twalmartrefundlinegroups read getwalmartrefundlinegroups;
    Property walmartrefundlines : Twalmartrefundlines read getwalmartrefundlines;
  end;

  Twalmartrefundgrouplines = class(TMSBusObj)
  private
    function GetRefundID                 : Integer   ;
    function GetRefundLinegroupID        : Integer   ;
    function GetreturnOrderLineNumber    : Integer   ;
    procedure SetRefundID                 (const Value: Integer   );
    procedure SetRefundLinegroupID        (const Value: Integer   );
    procedure SetreturnOrderLineNumber    (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundID                  :Integer     read GetRefundID                write SetRefundID             ;
    property RefundLinegroupID         :Integer     read GetRefundLinegroupID       write SetRefundLinegroupID    ;
    property returnOrderLineNumber     :Integer     read GetreturnOrderLineNumber   write SetreturnOrderLineNumber;
  end;
Twalmartrefundlinechargereferences = class(TMSBusObj)
  private
    function GetRefundId                 : Integer   ;
    function GetRefundLineID             : Integer   ;
    function GetRefundLineChargeID       : Integer   ;
    function Getreferencename            : string    ;
    function GetreferenceValue           : string    ;
    procedure SetRefundId                 (const Value: Integer   );
    procedure SetRefundLineID             (const Value: Integer   );
    procedure SetRefundLineChargeID       (const Value: Integer   );
    procedure Setreferencename            (const Value: string    );
    procedure SetreferenceValue           (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundId                  :Integer     read GetRefundId                write SetRefundId             ;
    property RefundLineID              :Integer     read GetRefundLineID            write SetRefundLineID         ;
    property RefundLineChargeID        :Integer     read GetRefundLineChargeID      write SetRefundLineChargeID   ;
    property referencename             :string      read Getreferencename           write Setreferencename        ;
    property referenceValue            :string      read GetreferenceValue          write SetreferenceValue       ;
  end;
  Twalmartrefundlinecharges = class(TMSBusObj)
  private
    function GetRefundId                 : Integer   ;
    function GetRefundLineID             : Integer   ;
    function GetchargeCategory           : string    ;
    function GetchargeName               : string    ;
    function GetchargePerUnitAmt         : Double    ;
    function GetexcessCharge             : Double    ;
    function GetchargePerUnitCurrency    : string    ;
    function GetexcessChargecurrency    : string    ;
    function GetisDiscount               : Boolean   ;
    function GetisBillable               : Boolean   ;
    procedure SetRefundId                 (const Value: Integer   );
    procedure SetRefundLineID             (const Value: Integer   );
    procedure SetchargeCategory           (const Value: string    );
    procedure SetchargeName               (const Value: string    );
    procedure SetchargePerUnitAmt         (const Value: Double    );
    procedure SetexcessCharge         (const Value: Double    );
    procedure SetchargePerUnitCurrency    (const Value: string    );
    procedure SetexcessChargecurrency    (const Value: string    );
    procedure SetisDiscount               (const Value: Boolean   );
    procedure SetisBillable               (const Value: Boolean   );
    function getwalmartrefundlinechargetax: Twalmartrefundlinechargetax;
    function getwalmartrefundlinechargereferences: Twalmartrefundlinechargereferences;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundId                  :Integer     read GetRefundId                write SetRefundId             ;
    property RefundLineID              :Integer     read GetRefundLineID            write SetRefundLineID         ;
    property chargeCategory            :string      read GetchargeCategory          write SetchargeCategory       ;
    property chargeName                :string      read GetchargeName              write SetchargeName           ;
    property chargePerUnitAmt          :Double      read GetchargePerUnitAmt        write SetchargePerUnitAmt     ;
    property excessCharge          :Double      read GetexcessCharge        write SetexcessCharge     ;
    property chargePerUnitCurrency     :string      read GetchargePerUnitCurrency   write SetchargePerUnitCurrency;
    property excessChargecurrency     :string      read GetexcessChargecurrency   write SetexcessChargecurrency;
    property isDiscount                :Boolean     read GetisDiscount              write SetisDiscount           ;
    property isBillable                :Boolean     read GetisBillable              write SetisBillable           ;
    Property walmartrefundlinechargetax :Twalmartrefundlinechargetax read getwalmartrefundlinechargetax;
    Property walmartrefundlinechargereferences :Twalmartrefundlinechargereferences read getwalmartrefundlinechargereferences;
  end;
  Twalmartrefundlinechargestotals = class(TMSBusObj)
  private
    function GetRefundId                 : Integer   ;
    function GetRefundLineID             : Integer   ;
    function GetchargeTotalsname         : string    ;
    function GetchargeTotalsValue        : Double    ;
    function GetchargeTotalsCurrency     : string    ;
    procedure SetRefundId                 (const Value: Integer   );
    procedure SetRefundLineID             (const Value: Integer   );
    procedure SetchargeTotalsname         (const Value: string    );
    procedure SetchargeTotalsValue        (const Value: Double    );
    procedure SetchargeTotalsCurrency     (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundId                  :Integer     read GetRefundId                write SetRefundId             ;
    property RefundLineID              :Integer     read GetRefundLineID            write SetRefundLineID         ;
    property chargeTotalsname          :string      read GetchargeTotalsname        write SetchargeTotalsname     ;
    property chargeTotalsValue         :Double      read GetchargeTotalsValue       write SetchargeTotalsValue    ;
    property chargeTotalsCurrency      :string      read GetchargeTotalsCurrency    write SetchargeTotalsCurrency ;
  end;
  Twalmartrefundlinechargetax = class(TMSBusObj)
  private
    function GetRefundId                 : Integer   ;
    function GetRefundLineID             : Integer   ;
    function GetRefundLineChargeID       : Integer   ;
    function GettaxName                  : string    ;
    function GetexcessTax                : Double    ;
    function GetexcessTaxCurrency        : string    ;
    function GettaxPerUnit               : Double    ;
    function GettaxPerUnitCurrency       : string    ;
    function GettaxId                    : string    ;
    function GetglobalTaxCode            : string    ;
    procedure SetRefundId                 (const Value: Integer   );
    procedure SetRefundLineID             (const Value: Integer   );
    procedure SetRefundLineChargeID       (const Value: Integer   );
    procedure SettaxName                  (const Value: string    );
    procedure SetexcessTax                (const Value: Double    );
    procedure SetexcessTaxCurrency        (const Value: string    );
    procedure SettaxPerUnit               (const Value: Double    );
    procedure SettaxPerUnitCurrency       (const Value: string    );
    procedure SettaxId                    (const Value: string    );
    procedure SetglobalTaxCode            (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundId                  :Integer     read GetRefundId                write SetRefundId             ;
    property RefundLineID              :Integer     read GetRefundLineID            write SetRefundLineID         ;
    property RefundLineChargeID        :Integer     read GetRefundLineChargeID      write SetRefundLineChargeID   ;
    property taxName                   :string      read GettaxName                 write SettaxName              ;
    property excessTax                 :Double      read GetexcessTax               write SetexcessTax            ;
    property excessTaxCurrency         :string      read GetexcessTaxCurrency       write SetexcessTaxCurrency    ;
    property taxPerUnit                :Double      read GettaxPerUnit              write SettaxPerUnit           ;
    property taxPerUnitCurrency        :string      read GettaxPerUnitCurrency      write SettaxPerUnitCurrency   ;
    property taxId                     :string      read GettaxId                   write SettaxId                ;
    property globalTaxCode             :string      read GetglobalTaxCode           write SetglobalTaxCode        ;
  end;
  Twalmartrefundlinegroupcarrierinfo = class(TMSBusObj)
  private
    function GetRefundID                  : Integer   ;
    function GetRefundLinegroupID         : Integer   ;
    function GetRefundLinegroupLabelID    : Integer   ;
    function GetcarrierId                 : string    ;
    function GetcarrierName               : string    ;
    function GetserviceType               : string    ;
    function GettrackingNo                : string    ;
    procedure SetRefundID                  (const Value: Integer   );
    procedure SetRefundLinegroupID         (const Value: Integer   );
    procedure SetRefundLinegroupLabelID    (const Value: Integer   );
    procedure SetcarrierId                 (const Value: string    );
    procedure SetcarrierName               (const Value: string    );
    procedure SetserviceType               (const Value: string    );
    procedure SettrackingNo                (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundID                   :Integer     read GetRefundID                 write SetRefundID              ;
    property RefundLinegroupID          :Integer     read GetRefundLinegroupID        write SetRefundLinegroupID     ;
    property RefundLinegroupLabelID     :Integer     read GetRefundLinegroupLabelID   write SetRefundLinegroupLabelID;
    property carrierId                  :string      read GetcarrierId                write SetcarrierId             ;
    property carrierName                :string      read GetcarrierName              write SetcarrierName           ;
    property serviceType                :string      read GetserviceType              write SetserviceType           ;
    property trackingNo                 :string      read GettrackingNo               write SettrackingNo            ;
  end;
  Twalmartrefundlinegrouplabels = class(TMSBusObj)
  private
    function GetRefundID                  : Integer   ;
    function GetRefundLinegroupID         : Integer   ;
    function GetlabelImageURL             : string    ;
    procedure SetRefundID                  (const Value: Integer   );
    procedure SetRefundLinegroupID         (const Value: Integer   );
    procedure SetlabelImageURL             (const Value: string    );
    function getwalmartrefundlinegroupcarrierinfo: Twalmartrefundlinegroupcarrierinfo;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundID                   :Integer     read GetRefundID                 write SetRefundID              ;
    property RefundLinegroupID          :Integer     read GetRefundLinegroupID        write SetRefundLinegroupID     ;
    property labelImageURL              :string      read GetlabelImageURL            write SetlabelImageURL         ;
    Property walmartrefundlinegroupcarrierinfo : Twalmartrefundlinegroupcarrierinfo read getwalmartrefundlinegroupcarrierinfo;
  end;
  Twalmartrefundlinegroups = class(TMSBusObj)
  private
    function GetRefundID                  : Integer   ;
    function GetgroupNo                   : Integer   ;
    function GetreturnExpectedFlag        : Boolean   ;
    procedure SetRefundID                  (const Value: Integer   );
    procedure SetgroupNo                   (const Value: Integer   );
    procedure SetreturnExpectedFlag        (const Value: Boolean   );
    function getwalmartrefundgrouplines: Twalmartrefundgrouplines;
    function getwalmartrefundlinegrouplabels: Twalmartrefundlinegrouplabels;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundID                   :Integer     read GetRefundID                 write SetRefundID              ;
    property groupNo                    :Integer     read GetgroupNo                  write SetgroupNo               ;
    property returnExpectedFlag         :Boolean     read GetreturnExpectedFlag       write SetreturnExpectedFlag    ;
    Property walmartrefundgrouplines  : Twalmartrefundgrouplines read getwalmartrefundgrouplines;
    Property walmartrefundlinegrouplabels  : Twalmartrefundlinegrouplabels read getwalmartrefundlinegrouplabels;
  end;
Twalmartrefundlines = class(TMSBusObj)
  private
    function GetRefundId                   : Integer   ;
    function GetreturnOrderLineNumber      : Integer   ;
    function GetsalesOrderLineNumber       : Integer   ;
    function GetreturnReason               : string    ;
    function GetpurchaseOrderId            : string    ;
    function GetpurchaseOrderLineNumber    : string    ;
    function Getsku                        : string    ;
    function GetproductName                : string    ;
    function GetitemWeightUOM              : string    ;
    function GetitemWeightUOMValue         : Double    ;
    function GetunitPrice                  : Double    ;
    function GetunitPriceCurrency          : string    ;
    function GetcancellableQty             : Double    ;
    function Getquantityuom                : string    ;
    function Getquantity                   : Double    ;
    function GetreturnExpectedFlag         : Boolean   ;
    function GetisFastReplacement          : Boolean   ;
    function GetisKeepIt                   : Boolean   ;
    function GetlastItem                   : Boolean   ;
    function GetrefundedQty                : Double    ;
    function GetrechargeableQty            : Double    ;
    function Getstatus                     : string    ;
    function GetstatusTime                 : string    ;
    function GetrefundChannel              : string    ;
    function GetERPRefundRef               : string    ;
    procedure SetRefundId                   (const Value: Integer   );
    procedure SetreturnOrderLineNumber      (const Value: Integer   );
    procedure SetsalesOrderLineNumber       (const Value: Integer   );
    procedure SetreturnReason               (const Value: string    );
    procedure SetpurchaseOrderId            (const Value: string    );
    procedure SetpurchaseOrderLineNumber    (const Value: string    );
    procedure Setsku                        (const Value: string    );
    procedure SetproductName                (const Value: string    );
    procedure SetitemWeightUOM              (const Value: string    );
    procedure SetitemWeightUOMValue         (const Value: Double    );
    procedure SetunitPrice                  (const Value: Double    );
    procedure SetunitPriceCurrency          (const Value: string    );
    procedure SetcancellableQty             (const Value: Double    );
    procedure Setquantityuom                (const Value: string    );
    procedure Setquantity                   (const Value: Double    );
    procedure SetreturnExpectedFlag         (const Value: Boolean   );
    procedure SetisFastReplacement          (const Value: Boolean   );
    procedure SetisKeepIt                   (const Value: Boolean   );
    procedure SetlastItem                   (const Value: Boolean   );
    procedure SetrefundedQty                (const Value: Double    );
    procedure SetrechargeableQty            (const Value: Double    );
    procedure Setstatus                     (const Value: string    );
    procedure SetstatusTime                 (const Value: string    );
    procedure SetrefundChannel              (const Value: string    );
    procedure SetERPRefundRef               (const Value: string    );
    function getwalmartrefundlinecharges: Twalmartrefundlinecharges;
    function getwalmartrefundlinechargestotals: Twalmartrefundlinechargestotals;
    function getwalmartrefundlinetrackingdetail: Twalmartrefundlinetrackingdetail;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Function MakeERPREfund :Boolean;
  published
    property RefundId                    :Integer     read GetRefundId                  write SetRefundId               ;
    property returnOrderLineNumber       :Integer     read GetreturnOrderLineNumber     write SetreturnOrderLineNumber  ;
    property salesOrderLineNumber        :Integer     read GetsalesOrderLineNumber      write SetsalesOrderLineNumber   ;
    property returnReason                :string      read GetreturnReason              write SetreturnReason           ;
    property purchaseOrderId             :string      read GetpurchaseOrderId           write SetpurchaseOrderId        ;
    property purchaseOrderLineNumber     :string      read GetpurchaseOrderLineNumber   write SetpurchaseOrderLineNumber;
    property sku                         :string      read Getsku                       write Setsku                    ;
    property productName                 :string      read GetproductName               write SetproductName            ;
    property itemWeightUOM               :string      read GetitemWeightUOM             write SetitemWeightUOM          ;
    property itemWeightUOMValue          :Double      read GetitemWeightUOMValue        write SetitemWeightUOMValue     ;
    property unitPrice                   :Double      read GetunitPrice                 write SetunitPrice              ;
    property unitPriceCurrency           :string      read GetunitPriceCurrency         write SetunitPriceCurrency      ;
    property cancellableQty              :Double      read GetcancellableQty            write SetcancellableQty         ;
    property quantityuom                 :string      read Getquantityuom               write Setquantityuom            ;
    property quantity                    :Double      read Getquantity                  write Setquantity               ;
    property returnExpectedFlag          :Boolean     read GetreturnExpectedFlag        write SetreturnExpectedFlag     ;
    property isFastReplacement           :Boolean     read GetisFastReplacement         write SetisFastReplacement      ;
    property isKeepIt                    :Boolean     read GetisKeepIt                  write SetisKeepIt               ;
    property lastItem                    :Boolean     read GetlastItem                  write SetlastItem               ;
    property refundedQty                 :Double      read GetrefundedQty               write SetrefundedQty            ;
    property rechargeableQty             :Double      read GetrechargeableQty           write SetrechargeableQty        ;
    property status                      :string      read Getstatus                    write Setstatus                 ;
    property statusTime                  :string      read GetstatusTime                write SetstatusTime             ;
    property refundChannel               :string      read GetrefundChannel             write SetrefundChannel          ;
    property ERPRefundRef                :string      read GetERPRefundRef              write SetERPRefundRef           ;
    Property walmartrefundlinecharges :Twalmartrefundlinecharges read getwalmartrefundlinecharges;
    Property walmartrefundlinechargestotals :Twalmartrefundlinechargestotals read getwalmartrefundlinechargestotals;
    Property walmartrefundlinetrackingdetail :Twalmartrefundlinetrackingdetail read getwalmartrefundlinetrackingdetail;
  end;
Twalmartrefundlinetrackingdetail = class(TMSBusObj)
  private
    function GetRefundId                   : Integer   ;
    function GetRefundLineID               : Integer   ;
    function GetsequenceNo                 : Integer   ;
    function GeteventTag                   : string    ;
    function GeteventDescription           : string    ;
    function GeteventTime                  : string    ;
    procedure SetRefundId                   (const Value: Integer   );
    procedure SetRefundLineID               (const Value: Integer   );
    procedure SetsequenceNo                 (const Value: Integer   );
    procedure SeteventTag                   (const Value: string    );
    procedure SeteventDescription           (const Value: string    );
    procedure SeteventTime                  (const Value: string    );
    function getwalmartrefundlinetrackingdetailref: Twalmartrefundlinetrackingdetailref;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundId                    :Integer     read GetRefundId                  write SetRefundId               ;
    property RefundLineID                :Integer     read GetRefundLineID              write SetRefundLineID           ;
    property sequenceNo                  :Integer     read GetsequenceNo                write SetsequenceNo             ;
    property eventTag                    :string      read GeteventTag                  write SeteventTag               ;
    property eventDescription            :string      read GeteventDescription          write SeteventDescription       ;
    property eventTime                   :string      read GeteventTime                 write SeteventTime              ;
    Property walmartrefundlinetrackingdetailref : Twalmartrefundlinetrackingdetailref read getwalmartrefundlinetrackingdetailref;
  end;
Twalmartrefundlinetrackingdetailref = class(TMSBusObj)
  private
    function GetRefundId                   : Integer   ;
    function GetRefundLineID               : Integer   ;
    function GetTrackingDetail             : Integer   ;
    function Getrefname                    : string    ;
    function GetrefValue                   : string    ;
    procedure SetRefundId                   (const Value: Integer   );
    procedure SetRefundLineID               (const Value: Integer   );
    procedure SetTrackingDetail             (const Value: Integer   );
    procedure Setrefname                    (const Value: string    );
    procedure SetrefValue                   (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterinsert(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property RefundId                    :Integer     read GetRefundId                  write SetRefundId               ;
    property RefundLineID                :Integer     read GetRefundLineID              write SetRefundLineID           ;
    property TrackingDetail              :Integer     read GetTrackingDetail            write SetTrackingDetail         ;
    property refname                     :string      read Getrefname                   write Setrefname                ;
    property refValue                    :string      read GetrefValue                  write SetrefValue               ;
  end;

implementation


uses tcDataUtils, CommonLib , sysutils, BusobjCash, BusObjSales,
  DbSharedObjectsObj , ERPdbComponents, BusObjTaxCodes, CommonDbLib;



  {Twalmartrefundgrouplines}

constructor Twalmartrefundgrouplines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundgrouplines';
  fSQL := 'SELECT * FROM tblwalmartrefundgrouplines';
end;


destructor Twalmartrefundgrouplines.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundgrouplines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundID');
  SetPropertyFromNode(node,'RefundLinegroupID');
  SetPropertyFromNode(node,'returnOrderLineNumber');
end;


procedure Twalmartrefundgrouplines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundID' ,RefundID);
  AddXMLNode(node,'RefundLinegroupID' ,RefundLinegroupID);
  AddXMLNode(node,'returnOrderLineNumber' ,returnOrderLineNumber);
end;


function Twalmartrefundgrouplines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundgrouplines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundgrouplines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundgrouplines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundgrouplines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefundgrouplines.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundgrouplines.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundgrouplines';
end;


function Twalmartrefundgrouplines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundgrouplines.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlinegroups then begin
      RefundId := Twalmartrefundlinegroups(Owner).RefundId;
      RefundLinegroupID := Twalmartrefundlinegroups(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundgrouplines.GetRefundID             : Integer   ; begin Result := GetIntegerField('RefundID');end;
function  Twalmartrefundgrouplines.GetRefundLinegroupID    : Integer   ; begin Result := GetIntegerField('RefundLinegroupID');end;
function  Twalmartrefundgrouplines.GetreturnOrderLineNumber: Integer   ; begin Result := GetIntegerField('returnOrderLineNumber');end;
procedure Twalmartrefundgrouplines.SetRefundID             (const Value: Integer   ); begin SetIntegerField('RefundID'              , Value);end;
procedure Twalmartrefundgrouplines.SetRefundLinegroupID    (const Value: Integer   ); begin SetIntegerField('RefundLinegroupID'     , Value);end;
procedure Twalmartrefundgrouplines.SetreturnOrderLineNumber(const Value: Integer   ); begin SetIntegerField('returnOrderLineNumber' , Value);end;


{Twalmartrefundlinechargereferences}

constructor Twalmartrefundlinechargereferences.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinechargereferences';
  fSQL := 'SELECT * FROM tblwalmartrefundlinechargereferences';
end;


destructor Twalmartrefundlinechargereferences.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinechargereferences.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundId');
  SetPropertyFromNode(node,'RefundLineID');
  SetPropertyFromNode(node,'RefundLineChargeID');
  SetPropertyFromNode(node,'referencename');
  SetPropertyFromNode(node,'referenceValue');
end;


procedure Twalmartrefundlinechargereferences.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'RefundLineID' ,RefundLineID);
  AddXMLNode(node,'RefundLineChargeID' ,RefundLineChargeID);
  AddXMLNode(node,'referencename' ,referencename);
  AddXMLNode(node,'referenceValue' ,referenceValue);
end;


function Twalmartrefundlinechargereferences.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinechargereferences.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinechargereferences.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinechargereferences.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinechargereferences.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefundlinechargereferences.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinechargereferences.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinechargereferences';
end;


function Twalmartrefundlinechargereferences.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinechargereferences.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlinechargetax then begin
      RefundId := Twalmartrefundlinechargetax(Owner).RefundId;
      RefundLineID := Twalmartrefundlinechargetax(Owner).RefundLineID;
      RefundLineChargeID := Twalmartrefundlinechargetax(Owner).RefundLineID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinechargereferences.GetRefundId             : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  Twalmartrefundlinechargereferences.GetRefundLineID         : Integer   ; begin Result := GetIntegerField('RefundLineID');end;
function  Twalmartrefundlinechargereferences.GetRefundLineChargeID   : Integer   ; begin Result := GetIntegerField('RefundLineChargeID');end;
function  Twalmartrefundlinechargereferences.Getreferencename        : string    ; begin Result := GetStringField('referencename');end;
function  Twalmartrefundlinechargereferences.GetreferenceValue       : string    ; begin Result := GetStringField('referenceValue');end;
procedure Twalmartrefundlinechargereferences.SetRefundId             (const Value: Integer   ); begin SetIntegerField('RefundId'              , Value);end;
procedure Twalmartrefundlinechargereferences.SetRefundLineID         (const Value: Integer   ); begin SetIntegerField('RefundLineID'          , Value);end;
procedure Twalmartrefundlinechargereferences.SetRefundLineChargeID   (const Value: Integer   ); begin SetIntegerField('RefundLineChargeID'    , Value);end;
procedure Twalmartrefundlinechargereferences.Setreferencename        (const Value: string    ); begin SetStringField('referencename'         , Value);end;
procedure Twalmartrefundlinechargereferences.SetreferenceValue       (const Value: string    ); begin SetStringField('referenceValue'        , Value);end;


  {Twalmartrefundlinecharges}

constructor Twalmartrefundlinecharges.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinecharges';
  fSQL := 'SELECT * FROM tblwalmartrefundlinecharges';
end;


destructor Twalmartrefundlinecharges.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinecharges.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundId');
  SetPropertyFromNode(node,'RefundLineID');
  SetPropertyFromNode(node,'chargeCategory');
  SetPropertyFromNode(node,'chargeName');
  SetPropertyFromNode(node,'chargePerUnitAmt');
  SetPropertyFromNode(node,'excessCharge');
  SetPropertyFromNode(node,'chargePerUnitCurrency');
  SetPropertyFromNode(node,'excessChargecurrency');
  SetBooleanPropertyFromNode(node,'isDiscount');
  SetBooleanPropertyFromNode(node,'isBillable');
end;


procedure Twalmartrefundlinecharges.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'RefundLineID' ,RefundLineID);
  AddXMLNode(node,'chargeCategory' ,chargeCategory);
  AddXMLNode(node,'chargeName' ,chargeName);
  AddXMLNode(node,'chargePerUnitAmt' ,chargePerUnitAmt);
  AddXMLNode(node,'excessCharge' ,excessCharge);
  AddXMLNode(node,'chargePerUnitCurrency' ,chargePerUnitCurrency);
  AddXMLNode(node,'excessChargecurrency' ,excessChargecurrency);
  AddXMLNode(node,'isDiscount' ,isDiscount);
  AddXMLNode(node,'isBillable' ,isBillable);
end;


function Twalmartrefundlinecharges.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinecharges.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinecharges.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinecharges.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinecharges.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function Twalmartrefundlinecharges.getwalmartrefundlinechargetax: Twalmartrefundlinechargetax;
begin
  result := Twalmartrefundlinechargetax(GetContainerComponent(Twalmartrefundlinechargetax ,'RefundLineChargeID = ' + IntToStr(ID) ));
end;
function Twalmartrefundlinecharges.getwalmartrefundlinechargereferences: Twalmartrefundlinechargereferences;
begin
  result := Twalmartrefundlinechargereferences(GetContainerComponent(Twalmartrefundlinechargereferences ,'RefundLineChargeID = ' + IntToStr(ID) ));
end;

class function Twalmartrefundlinecharges.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinecharges.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinecharges';
end;


function Twalmartrefundlinecharges.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinecharges.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlines then begin
      RefundId := Twalmartrefundlines(Owner).RefundId;
      RefundLineID := Twalmartrefundlines(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinecharges.GetRefundId             : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  Twalmartrefundlinecharges.GetRefundLineID         : Integer   ; begin Result := GetIntegerField('RefundLineID');end;
function  Twalmartrefundlinecharges.GetchargeCategory       : string    ; begin Result := GetStringField('chargeCategory');end;
function  Twalmartrefundlinecharges.GetchargeName           : string    ; begin Result := GetStringField('chargeName');end;
function  Twalmartrefundlinecharges.GetchargePerUnitAmt     : Double    ; begin Result := GetFloatField('chargePerUnitAmt');end;
function  Twalmartrefundlinecharges.GetexcessCharge     : Double    ; begin Result := GetFloatField('excessCharge');end;
function  Twalmartrefundlinecharges.GetchargePerUnitCurrency: string    ; begin Result := GetStringField('chargePerUnitCurrency');end;
function  Twalmartrefundlinecharges.GetexcessChargecurrency: string    ; begin Result := GetStringField('excessChargecurrency');end;
function  Twalmartrefundlinecharges.GetisDiscount           : Boolean   ; begin Result := GetBooleanField('isDiscount');end;
function  Twalmartrefundlinecharges.GetisBillable           : Boolean   ; begin Result := GetBooleanField('isBillable');end;
procedure Twalmartrefundlinecharges.SetRefundId             (const Value: Integer   ); begin SetIntegerField('RefundId'              , Value);end;
procedure Twalmartrefundlinecharges.SetRefundLineID         (const Value: Integer   ); begin SetIntegerField('RefundLineID'          , Value);end;
procedure Twalmartrefundlinecharges.SetchargeCategory       (const Value: string    ); begin SetStringField('chargeCategory'        , Value);end;
procedure Twalmartrefundlinecharges.SetchargeName           (const Value: string    ); begin SetStringField('chargeName'            , Value);end;
procedure Twalmartrefundlinecharges.SetchargePerUnitAmt     (const Value: Double    ); begin SetFloatField('chargePerUnitAmt'      , Value);end;
procedure Twalmartrefundlinecharges.SetexcessCharge     (const Value: Double    ); begin SetFloatField('excessCharge'      , Value);end;
procedure Twalmartrefundlinecharges.SetchargePerUnitCurrency(const Value: string    ); begin SetStringField('chargePerUnitCurrency' , Value);end;
procedure Twalmartrefundlinecharges.SetexcessChargecurrency(const Value: string    ); begin SetStringField('excessChargecurrency' , Value);end;
procedure Twalmartrefundlinecharges.SetisDiscount           (const Value: Boolean   ); begin SetBooleanField('isDiscount'            , Value);end;
procedure Twalmartrefundlinecharges.SetisBillable           (const Value: Boolean   ); begin SetBooleanField('isBillable'            , Value);end;


  {Twalmartrefundlinechargestotals}

constructor Twalmartrefundlinechargestotals.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinechargestotals';
  fSQL := 'SELECT * FROM tblwalmartrefundlinechargestotals';
end;


destructor Twalmartrefundlinechargestotals.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinechargestotals.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundId');
  SetPropertyFromNode(node,'RefundLineID');
  SetPropertyFromNode(node,'chargeTotalsname');
  SetPropertyFromNode(node,'chargeTotalsValue');
  SetPropertyFromNode(node,'chargeTotalsCurrency');
end;


procedure Twalmartrefundlinechargestotals.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'RefundLineID' ,RefundLineID);
  AddXMLNode(node,'chargeTotalsname' ,chargeTotalsname);
  AddXMLNode(node,'chargeTotalsValue' ,chargeTotalsValue);
  AddXMLNode(node,'chargeTotalsCurrency' ,chargeTotalsCurrency);
end;


function Twalmartrefundlinechargestotals.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinechargestotals.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinechargestotals.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinechargestotals.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinechargestotals.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefundlinechargestotals.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinechargestotals.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinechargestotals';
end;


function Twalmartrefundlinechargestotals.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinechargestotals.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlines then begin
      RefundId := Twalmartrefundlines(Owner).RefundId;
      RefundLineID := Twalmartrefundlines(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinechargestotals.GetRefundId             : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  Twalmartrefundlinechargestotals.GetRefundLineID         : Integer   ; begin Result := GetIntegerField('RefundLineID');end;
function  Twalmartrefundlinechargestotals.GetchargeTotalsname     : string    ; begin Result := GetStringField('chargeTotalsname');end;
function  Twalmartrefundlinechargestotals.GetchargeTotalsValue    : Double    ; begin Result := GetFloatField('chargeTotalsValue');end;
function  Twalmartrefundlinechargestotals.GetchargeTotalsCurrency : string    ; begin Result := GetStringField('chargeTotalsCurrency');end;
procedure Twalmartrefundlinechargestotals.SetRefundId             (const Value: Integer   ); begin SetIntegerField('RefundId'              , Value);end;
procedure Twalmartrefundlinechargestotals.SetRefundLineID         (const Value: Integer   ); begin SetIntegerField('RefundLineID'          , Value);end;
procedure Twalmartrefundlinechargestotals.SetchargeTotalsname     (const Value: string    ); begin SetStringField('chargeTotalsname'      , Value);end;
procedure Twalmartrefundlinechargestotals.SetchargeTotalsValue    (const Value: Double    ); begin SetFloatField('chargeTotalsValue'     , Value);end;
procedure Twalmartrefundlinechargestotals.SetchargeTotalsCurrency (const Value: string    ); begin SetStringField('chargeTotalsCurrency' , Value);end;


{Twalmartrefundlinechargetax}

constructor Twalmartrefundlinechargetax.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinechargetax';
  fSQL := 'SELECT * FROM tblwalmartrefundlinechargetax';
end;


destructor Twalmartrefundlinechargetax.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinechargetax.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundId');
  SetPropertyFromNode(node,'RefundLineID');
  SetPropertyFromNode(node,'RefundLineChargeID');
  SetPropertyFromNode(node,'taxName');
  SetPropertyFromNode(node,'excessTax');
  SetPropertyFromNode(node,'excessTaxCurrency');
  SetPropertyFromNode(node,'taxPerUnit');
  SetPropertyFromNode(node,'taxPerUnitCurrency');
  SetPropertyFromNode(node,'taxId');
  SetPropertyFromNode(node,'globalTaxCode');
end;


procedure Twalmartrefundlinechargetax.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'RefundLineID' ,RefundLineID);
  AddXMLNode(node,'RefundLineChargeID' ,RefundLineChargeID);
  AddXMLNode(node,'taxName' ,taxName);
  AddXMLNode(node,'excessTax' ,excessTax);
  AddXMLNode(node,'excessTaxCurrency' ,excessTaxCurrency);
  AddXMLNode(node,'taxPerUnit' ,taxPerUnit);
  AddXMLNode(node,'taxPerUnitCurrency' ,taxPerUnitCurrency);
  AddXMLNode(node,'taxId' ,taxId);
  AddXMLNode(node,'globalTaxCode' ,globalTaxCode);
end;


function Twalmartrefundlinechargetax.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinechargetax.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinechargetax.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinechargetax.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinechargetax.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefundlinechargetax.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinechargetax.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinechargetax';
end;


function Twalmartrefundlinechargetax.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinechargetax.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlinecharges then begin
      RefundId := Twalmartrefundlinecharges(Owner).RefundId;
      RefundLineID := Twalmartrefundlinecharges(Owner).RefundLineID;
      RefundLineChargeID := Twalmartrefundlinecharges(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinechargetax.GetRefundId             : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  Twalmartrefundlinechargetax.GetRefundLineID         : Integer   ; begin Result := GetIntegerField('RefundLineID');end;
function  Twalmartrefundlinechargetax.GetRefundLineChargeID   : Integer   ; begin Result := GetIntegerField('RefundLineChargeID');end;
function  Twalmartrefundlinechargetax.GettaxName              : string    ; begin Result := GetStringField('taxName');end;
function  Twalmartrefundlinechargetax.GetexcessTax            : Double    ; begin Result := GetFloatField('excessTax');end;
function  Twalmartrefundlinechargetax.GetexcessTaxCurrency    : string    ; begin Result := GetStringField('excessTaxCurrency');end;
function  Twalmartrefundlinechargetax.GettaxPerUnit           : Double    ; begin Result := GetFloatField('taxPerUnit');end;
function  Twalmartrefundlinechargetax.GettaxPerUnitCurrency   : string    ; begin Result := GetStringField('taxPerUnitCurrency');end;
function  Twalmartrefundlinechargetax.GettaxId                : string    ; begin Result := GetStringField('taxId');end;
function  Twalmartrefundlinechargetax.GetglobalTaxCode        : string    ; begin Result := GetStringField('globalTaxCode');end;
procedure Twalmartrefundlinechargetax.SetRefundId             (const Value: Integer   ); begin SetIntegerField('RefundId'              , Value);end;
procedure Twalmartrefundlinechargetax.SetRefundLineID         (const Value: Integer   ); begin SetIntegerField('RefundLineID'          , Value);end;
procedure Twalmartrefundlinechargetax.SetRefundLineChargeID   (const Value: Integer   ); begin SetIntegerField('RefundLineChargeID'    , Value);end;
procedure Twalmartrefundlinechargetax.SettaxName              (const Value: string    ); begin SetStringField('taxName'               , Value);end;
procedure Twalmartrefundlinechargetax.SetexcessTax            (const Value: Double    ); begin SetFloatField('excessTax'             , Value);end;
procedure Twalmartrefundlinechargetax.SetexcessTaxCurrency    (const Value: string    ); begin SetStringField('excessTaxCurrency'     , Value);end;
procedure Twalmartrefundlinechargetax.SettaxPerUnit           (const Value: Double    ); begin SetFloatField('taxPerUnit'            , Value);end;
procedure Twalmartrefundlinechargetax.SettaxPerUnitCurrency   (const Value: string    ); begin SetStringField('taxPerUnitCurrency'    , Value);end;
procedure Twalmartrefundlinechargetax.SettaxId                (const Value: string    ); begin SetStringField('taxId'                 , Value);end;
procedure Twalmartrefundlinechargetax.SetglobalTaxCode        (const Value: string    ); begin SetStringField('globalTaxCode'         , Value);end;


{Twalmartrefundlinegroupcarrierinfo}

constructor Twalmartrefundlinegroupcarrierinfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinegroupcarrierinfo';
  fSQL := 'SELECT * FROM tblwalmartrefundlinegroupcarrierinfo';
end;


destructor Twalmartrefundlinegroupcarrierinfo.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinegroupcarrierinfo.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundID');
  SetPropertyFromNode(node,'RefundLinegroupID');
  SetPropertyFromNode(node,'RefundLinegroupLabelID');
  SetPropertyFromNode(node,'carrierId');
  SetPropertyFromNode(node,'carrierName');
  SetPropertyFromNode(node,'serviceType');
  SetPropertyFromNode(node,'trackingNo');
end;


procedure Twalmartrefundlinegroupcarrierinfo.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundID' ,RefundID);
  AddXMLNode(node,'RefundLinegroupID' ,RefundLinegroupID);
  AddXMLNode(node,'RefundLinegroupLabelID' ,RefundLinegroupLabelID);
  AddXMLNode(node,'carrierId' ,carrierId);
  AddXMLNode(node,'carrierName' ,carrierName);
  AddXMLNode(node,'serviceType' ,serviceType);
  AddXMLNode(node,'trackingNo' ,trackingNo);
end;


function Twalmartrefundlinegroupcarrierinfo.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinegroupcarrierinfo.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinegroupcarrierinfo.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinegroupcarrierinfo.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinegroupcarrierinfo.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefundlinegroupcarrierinfo.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinegroupcarrierinfo.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinegroupcarrierinfo';
end;


function Twalmartrefundlinegroupcarrierinfo.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinegroupcarrierinfo.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlinegrouplabels then begin
      RefundId := Twalmartrefundlinegrouplabels(Owner).RefundId;
      RefundLinegroupID := Twalmartrefundlinegrouplabels(Owner).RefundLinegroupID;
      RefundLinegroupLabelID := Twalmartrefundlinegrouplabels(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinegroupcarrierinfo.GetRefundID              : Integer   ; begin Result := GetIntegerField('RefundID');end;
function  Twalmartrefundlinegroupcarrierinfo.GetRefundLinegroupID     : Integer   ; begin Result := GetIntegerField('RefundLinegroupID');end;
function  Twalmartrefundlinegroupcarrierinfo.GetRefundLinegroupLabelID: Integer   ; begin Result := GetIntegerField('RefundLinegroupLabelID');end;
function  Twalmartrefundlinegroupcarrierinfo.GetcarrierId             : string    ; begin Result := GetStringField('carrierId');end;
function  Twalmartrefundlinegroupcarrierinfo.GetcarrierName           : string    ; begin Result := GetStringField('carrierName');end;
function  Twalmartrefundlinegroupcarrierinfo.GetserviceType           : string    ; begin Result := GetStringField('serviceType');end;
function  Twalmartrefundlinegroupcarrierinfo.GettrackingNo            : string    ; begin Result := GetStringField('trackingNo');end;
procedure Twalmartrefundlinegroupcarrierinfo.SetRefundID              (const Value: Integer   ); begin SetIntegerField('RefundID'               , Value);end;
procedure Twalmartrefundlinegroupcarrierinfo.SetRefundLinegroupID     (const Value: Integer   ); begin SetIntegerField('RefundLinegroupID'      , Value);end;
procedure Twalmartrefundlinegroupcarrierinfo.SetRefundLinegroupLabelID(const Value: Integer   ); begin SetIntegerField('RefundLinegroupLabelID' , Value);end;
procedure Twalmartrefundlinegroupcarrierinfo.SetcarrierId             (const Value: string    ); begin SetStringField('carrierId'              , Value);end;
procedure Twalmartrefundlinegroupcarrierinfo.SetcarrierName           (const Value: string    ); begin SetStringField('carrierName'            , Value);end;
procedure Twalmartrefundlinegroupcarrierinfo.SetserviceType           (const Value: string    ); begin SetStringField('serviceType'            , Value);end;
procedure Twalmartrefundlinegroupcarrierinfo.SettrackingNo            (const Value: string    ); begin SetStringField('trackingNo'             , Value);end;


{Twalmartrefundlinegrouplabels}

constructor Twalmartrefundlinegrouplabels.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinegrouplabels';
  fSQL := 'SELECT * FROM tblwalmartrefundlinegrouplabels';
end;


destructor Twalmartrefundlinegrouplabels.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinegrouplabels.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundID');
  SetPropertyFromNode(node,'RefundLinegroupID');
  SetPropertyFromNode(node,'labelImageURL');
end;


procedure Twalmartrefundlinegrouplabels.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundID' ,RefundID);
  AddXMLNode(node,'RefundLinegroupID' ,RefundLinegroupID);
  AddXMLNode(node,'labelImageURL' ,labelImageURL);
end;


function Twalmartrefundlinegrouplabels.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinegrouplabels.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinegrouplabels.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinegrouplabels.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinegrouplabels.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function Twalmartrefundlinegrouplabels.getwalmartrefundlinegroupcarrierinfo: Twalmartrefundlinegroupcarrierinfo;
begin
  result := Twalmartrefundlinegroupcarrierinfo(GetContainerComponent(Twalmartrefundlinegroupcarrierinfo ,'RefundLinegroupLabelID = ' + IntToStr(ID) ));
end;

class function Twalmartrefundlinegrouplabels.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinegrouplabels.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinegrouplabels';
end;


function Twalmartrefundlinegrouplabels.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinegrouplabels.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlinegroups then begin
      RefundId := Twalmartrefundlinegroups(Owner).RefundId;
      RefundLinegroupID := Twalmartrefundlinegroups(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinegrouplabels.GetRefundID              : Integer   ; begin Result := GetIntegerField('RefundID');end;
function  Twalmartrefundlinegrouplabels.GetRefundLinegroupID     : Integer   ; begin Result := GetIntegerField('RefundLinegroupID');end;
function  Twalmartrefundlinegrouplabels.GetlabelImageURL         : string    ; begin Result := GetStringField('labelImageURL');end;
procedure Twalmartrefundlinegrouplabels.SetRefundID              (const Value: Integer   ); begin SetIntegerField('RefundID'               , Value);end;
procedure Twalmartrefundlinegrouplabels.SetRefundLinegroupID     (const Value: Integer   ); begin SetIntegerField('RefundLinegroupID'      , Value);end;
procedure Twalmartrefundlinegrouplabels.SetlabelImageURL         (const Value: string    ); begin SetStringField('labelImageURL'          , Value);end;


{Twalmartrefundlinegroups}

constructor Twalmartrefundlinegroups.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinegroups';
  fSQL := 'SELECT * FROM tblwalmartrefundlinegroups';
end;


destructor Twalmartrefundlinegroups.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinegroups.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundID');
  SetPropertyFromNode(node,'groupNo');
  SetBooleanPropertyFromNode(node,'returnExpectedFlag');
end;


procedure Twalmartrefundlinegroups.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundID' ,RefundID);
  AddXMLNode(node,'groupNo' ,groupNo);
  AddXMLNode(node,'returnExpectedFlag' ,returnExpectedFlag);
end;


function Twalmartrefundlinegroups.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinegroups.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinegroups.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinegroups.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinegroups.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function Twalmartrefundlinegroups.getwalmartrefundgrouplines: Twalmartrefundgrouplines;
begin
  result := Twalmartrefundgrouplines(GetContainerComponent(Twalmartrefundgrouplines ,'RefundLinegroupID = ' + IntToStr(ID) ));
end;
function Twalmartrefundlinegroups.getwalmartrefundlinegrouplabels: Twalmartrefundlinegrouplabels;
begin
  result := Twalmartrefundlinegrouplabels(GetContainerComponent(Twalmartrefundlinegrouplabels ,'RefundLinegroupID = ' + IntToStr(ID) ));
end;

class function Twalmartrefundlinegroups.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinegroups.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinegroups';
end;


function Twalmartrefundlinegroups.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinegroups.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is TWalmartRefunds then begin
      RefundId := Twalmartrefunds(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinegroups.GetRefundID              : Integer   ; begin Result := GetIntegerField('RefundID');end;
function  Twalmartrefundlinegroups.GetgroupNo               : Integer   ; begin Result := GetIntegerField('groupNo');end;
function  Twalmartrefundlinegroups.GetreturnExpectedFlag    : Boolean   ; begin Result := GetBooleanField('returnExpectedFlag');end;
procedure Twalmartrefundlinegroups.SetRefundID              (const Value: Integer   ); begin SetIntegerField('RefundID'               , Value);end;
procedure Twalmartrefundlinegroups.SetgroupNo               (const Value: Integer   ); begin SetIntegerField('groupNo'                , Value);end;
procedure Twalmartrefundlinegroups.SetreturnExpectedFlag    (const Value: Boolean   ); begin SetBooleanField('returnExpectedFlag'     , Value);end;


{Twalmartrefundlines}

constructor Twalmartrefundlines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlines';
  fSQL := 'SELECT * FROM tblwalmartrefundlines';
end;


destructor Twalmartrefundlines.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundId');
  SetPropertyFromNode(node,'returnOrderLineNumber');
  SetPropertyFromNode(node,'salesOrderLineNumber');
  SetPropertyFromNode(node,'returnReason');
  SetPropertyFromNode(node,'purchaseOrderId');
  SetPropertyFromNode(node,'purchaseOrderLineNumber');
  SetPropertyFromNode(node,'sku');
  SetPropertyFromNode(node,'productName');
  SetPropertyFromNode(node,'itemWeightUOM');
  SetPropertyFromNode(node,'itemWeightUOMValue');
  SetPropertyFromNode(node,'unitPrice');
  SetPropertyFromNode(node,'unitPriceCurrency');
  SetPropertyFromNode(node,'cancellableQty');
  SetPropertyFromNode(node,'quantityuom');
  SetPropertyFromNode(node,'quantity');
  SetBooleanPropertyFromNode(node,'returnExpectedFlag');
  SetBooleanPropertyFromNode(node,'isFastReplacement');
  SetBooleanPropertyFromNode(node,'isKeepIt');
  SetBooleanPropertyFromNode(node,'lastItem');
  SetPropertyFromNode(node,'refundedQty');
  SetPropertyFromNode(node,'rechargeableQty');
  SetPropertyFromNode(node,'status');
  SetPropertyFromNode(node,'statusTime');
  SetPropertyFromNode(node,'refundChannel');
  SetPropertyFromNode(node,'ERPRefundRef');
end;


function Twalmartrefundlines.MakeERPREfund: Boolean;
var
  RefundObj :TRefundSale;
  qry: TERPQuery;
  inv:TInvoice;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
        Qry.SQL.text :='select '+
                    ' Inv.saleId, InvSL.saleLineId, '+
                    ' SL.productname, '+
                    ' WRCT.chargeTotalsname as RefundChargeName, '+
                    ' WRCT.chargeTotalsValue as RefundChargeAmount , '+
                    ' WRCT.chargeTotalsCurrency as ChargeCurrency, '+
                    ' WRCTX.chargeTotalsCurrency as TaxCurrency, '+
                    ' WRCTX.chargeTotalsValue as TaxAmount, '+
                    ' WRLCT.taxName as taxName  , '+
                    ' SL.UnitofMeasureSaleLines , '+
                    ' SL.UnitofMeasureShipped '+
                    ' from tblwalmartorders WO '+
                    ' inner join tblwalmartorderlines WOL on WO.OrderId = WOL.OrderId '+
                    ' inner join tblwalmartrefunds WR on WO.customerOrderId = WR.customerOrderId '+
                    ' inner join tblwalmartrefundlines WRL on WR.ID = WRL.RefundId and WRL.salesOrderLineNumber = WOL.Linenumber and WRL.ID = '+ inttostr(ID) +
                    ' inner join tblsaleslines SL on SL.GlobalRef = WOL.ERPSalesLineRef '+
                    ' inner join tblsales S on SL.SaleID = S.SaleID '+
                    ' inner join tblsales Inv on S.GlobalRef = Inv.SalesOrderGlobalRef '+
                    ' inner join tblsaleslines InvSL on InvSL.SaleID = Inv.SaleID and InvSL.ProductID = SL.ProductID and InvSL.SeqNo = SL.SeqNo '+
                    ' inner join tblwalmartrefundlinechargestotals WRCT on WRCT.RefundLineID = WRL.ID and WRCT.chargeTotalsname = "lineTotal" '+
                    ' left join tblwalmartrefundlinechargestotals WRCTX on WRCTX.RefundLineID = WRL.ID and WRCTX.chargeTotalsname = "lineTotalTaxes" '+
                    ' left join  tblwalmartrefundlinechargetax WRLCT on  WRLCT.RefundLineID= WRL.ID';

    Qry.Open;
    if Qry.recordcount >0 then begin

        RefundObj := TRefundSale.CreateWithNewConn(nil);
        Inv :=TInvoice.Create(RefundObj);
        try
            Inv.Connection := RefundObj.Connection;
            Inv.Load(Qry.FieldByName('SaleID').AsInteger);
            if (Inv.Count>0) and (Inv.Lines.Locate('SaleLineID' , Qry.FieldByName('SalelineId').AsInteger , [])) then begin
              RefundObj.Connection.beginTransaction;
              RefundObj.Load(0);
              RefundObj.New;
              RefundObj.ClientId := Inv.ClientID;
              if RefundObj.ForeignExchangeCode ='' then RefundObj.ForeignExchangeCode := Qry.fieldByname('ChargeCurrency').AsString;
              if RefundObj.ForeignExchangeCode ='' then RefundObj.ForeignExchangeCode := Qry.fieldByname('TaxCurrency').AsString;
              RefundObj.PostDB;

              RefundObj.Lines.New;
              RefundObj.Lines.productname := Qry.fieldByname('ProductName').AsString;
              if Qry.fieldByname('taxName').asString <> '' then
                if TTaxCode.IDToggle(Qry.fieldByname('taxName').asString ,True,TTaxCode) >0 then
                  RefundObj.Lines.LineTaxCode :=Qry.fieldByname('taxName').asString;


              RefundObj.Lines.UnitOfMeasure    := Qry.fieldByname('UnitofMeasureSaleLines').asString;
              RefundObj.Lines.RefundQty:= Qry.fieldByname('UnitofMeasureShipped').asFloat;

              (*if sametext(Qry.fieldByname('Chargetype').AsString, 'PRODUCT') then
                    RefundObj.Lines.linepriceinc :=Qry.fieldByname('ChargeAmount').AsFloat
              else  RefundObj.Lines.TotalLineAmountinc:=Qry.fieldByname('ChargeAmount').AsFloat;*)
              RefundObj.Lines.TotalLineAmountinc:=Qry.fieldByname('RefundChargeAmount').AsFloat;

              RefundObj.Lines.AllowTaxinput := true;  // the tax is not accepted otherwise , and gets recalculated
              try
                RefundObj.Lines.LineTaxTotal :=Qry.fieldByname('TaxAmount').asFloat;
              finally
                RefundObj.Lines.AllowTaxinput := False;
              end;

              RefundObj.Lines.RefundedSalesLineID := Inv.Lines.ID;
              RefundObj.Lines.PostDB;
              Inv.Lines.PQA.CopyAllocation(RefundObj.Lines.PQA.ID, false);
              RefundObj.Lines.PostDB;
              if RefundObj.Save then begin
                ERPRefundRef :=RefundObj.Globalref;
                PostDB;
                RefundObj.Connection.CommitTransaction;
                result := True;
                Exit;
              end;
            end;
            RefundObj.Connection.RollbackTransaction;
        finally
          Freeandnil(RefundObj);
        end;
      end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure Twalmartrefundlines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'returnOrderLineNumber' ,returnOrderLineNumber);
  AddXMLNode(node,'salesOrderLineNumber' ,salesOrderLineNumber);
  AddXMLNode(node,'returnReason' ,returnReason);
  AddXMLNode(node,'purchaseOrderId' ,purchaseOrderId);
  AddXMLNode(node,'purchaseOrderLineNumber' ,purchaseOrderLineNumber);
  AddXMLNode(node,'sku' ,sku);
  AddXMLNode(node,'productName' ,productName);
  AddXMLNode(node,'itemWeightUOM' ,itemWeightUOM);
  AddXMLNode(node,'itemWeightUOMValue' ,itemWeightUOMValue);
  AddXMLNode(node,'unitPrice' ,unitPrice);
  AddXMLNode(node,'unitPriceCurrency' ,unitPriceCurrency);
  AddXMLNode(node,'cancellableQty' ,cancellableQty);
  AddXMLNode(node,'quantityuom' ,quantityuom);
  AddXMLNode(node,'quantity' ,quantity);
  AddXMLNode(node,'returnExpectedFlag' ,returnExpectedFlag);
  AddXMLNode(node,'isFastReplacement' ,isFastReplacement);
  AddXMLNode(node,'isKeepIt' ,isKeepIt);
  AddXMLNode(node,'lastItem' ,lastItem);
  AddXMLNode(node,'refundedQty' ,refundedQty);
  AddXMLNode(node,'rechargeableQty' ,rechargeableQty);
  AddXMLNode(node,'status' ,status);
  AddXMLNode(node,'statusTime' ,statusTime);
  AddXMLNode(node,'refundChannel' ,refundChannel);
  AddXMLNode(node,'ERPRefundRef' ,ERPRefundRef);
end;


function Twalmartrefundlines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefundlines.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlines.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlines';
end;


function Twalmartrefundlines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlines.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is TWalmartRefunds then begin
      RefundId := Twalmartrefunds(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlines.GetRefundId               : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  Twalmartrefundlines.GetreturnOrderLineNumber  : Integer   ; begin Result := GetIntegerField('returnOrderLineNumber');end;
function  Twalmartrefundlines.GetsalesOrderLineNumber   : Integer   ; begin Result := GetIntegerField('salesOrderLineNumber');end;
function  Twalmartrefundlines.GetreturnReason           : string    ; begin Result := GetStringField('returnReason');end;
function  Twalmartrefundlines.GetpurchaseOrderId        : string    ; begin Result := GetStringField('purchaseOrderId');end;
function  Twalmartrefundlines.GetpurchaseOrderLineNumber: string    ; begin Result := GetStringField('purchaseOrderLineNumber');end;
function  Twalmartrefundlines.Getsku                    : string    ; begin Result := GetStringField('sku');end;
function  Twalmartrefundlines.GetproductName            : string    ; begin Result := GetStringField('productName');end;
function  Twalmartrefundlines.GetitemWeightUOM          : string    ; begin Result := GetStringField('itemWeightUOM');end;
function  Twalmartrefundlines.GetitemWeightUOMValue     : Double    ; begin Result := GetFloatField('itemWeightUOMValue');end;
function  Twalmartrefundlines.GetunitPrice              : Double    ; begin Result := GetFloatField('unitPrice');end;
function  Twalmartrefundlines.GetunitPriceCurrency      : string    ; begin Result := GetStringField('unitPriceCurrency');end;
function  Twalmartrefundlines.GetcancellableQty         : Double    ; begin Result := GetFloatField('cancellableQty');end;
function  Twalmartrefundlines.Getquantityuom            : string    ; begin Result := GetStringField('quantityuom');end;
function  Twalmartrefundlines.Getquantity               : Double    ; begin Result := GetFloatField('quantity');end;
function  Twalmartrefundlines.GetreturnExpectedFlag     : Boolean   ; begin Result := GetBooleanField('returnExpectedFlag');end;
function  Twalmartrefundlines.GetisFastReplacement      : Boolean   ; begin Result := GetBooleanField('isFastReplacement');end;
function  Twalmartrefundlines.GetisKeepIt               : Boolean   ; begin Result := GetBooleanField('isKeepIt');end;
function  Twalmartrefundlines.GetlastItem               : Boolean   ; begin Result := GetBooleanField('lastItem');end;
function  Twalmartrefundlines.GetrefundedQty            : Double    ; begin Result := GetFloatField('refundedQty');end;
function  Twalmartrefundlines.GetrechargeableQty        : Double    ; begin Result := GetFloatField('rechargeableQty');end;
function  Twalmartrefundlines.Getstatus                 : string    ; begin Result := GetStringField('status');end;
function  Twalmartrefundlines.GetstatusTime             : string    ; begin Result := GetStringField('statusTime');end;
function  Twalmartrefundlines.GetrefundChannel          : string    ; begin Result := GetStringField('refundChannel');end;
function  Twalmartrefundlines.GetERPRefundRef           : string    ; begin Result := GetStringField('ERPRefundRef');end;
procedure Twalmartrefundlines.SetRefundId               (const Value: Integer   ); begin SetIntegerField('RefundId'                , Value);end;
procedure Twalmartrefundlines.SetreturnOrderLineNumber  (const Value: Integer   ); begin SetIntegerField('returnOrderLineNumber'   , Value);end;
procedure Twalmartrefundlines.SetsalesOrderLineNumber   (const Value: Integer   ); begin SetIntegerField('salesOrderLineNumber'    , Value);end;
procedure Twalmartrefundlines.SetreturnReason           (const Value: string    ); begin SetStringField('returnReason'            , Value);end;
procedure Twalmartrefundlines.SetpurchaseOrderId        (const Value: string    ); begin SetStringField('purchaseOrderId'         , Value);end;
procedure Twalmartrefundlines.SetpurchaseOrderLineNumber(const Value: string    ); begin SetStringField('purchaseOrderLineNumber' , Value);end;
procedure Twalmartrefundlines.Setsku                    (const Value: string    ); begin SetStringField('sku'                     , Value);end;
procedure Twalmartrefundlines.SetproductName            (const Value: string    ); begin SetStringField('productName'             , Value);end;
procedure Twalmartrefundlines.SetitemWeightUOM          (const Value: string    ); begin SetStringField('itemWeightUOM'           , Value);end;
procedure Twalmartrefundlines.SetitemWeightUOMValue     (const Value: Double    ); begin SetFloatField('itemWeightUOMValue'      , Value);end;
procedure Twalmartrefundlines.SetunitPrice              (const Value: Double    ); begin SetFloatField('unitPrice'               , Value);end;
procedure Twalmartrefundlines.SetunitPriceCurrency      (const Value: string    ); begin SetStringField('unitPriceCurrency'       , Value);end;
procedure Twalmartrefundlines.SetcancellableQty         (const Value: Double    ); begin SetFloatField('cancellableQty'          , Value);end;
procedure Twalmartrefundlines.Setquantityuom            (const Value: string    ); begin SetStringField('quantityuom'             , Value);end;
procedure Twalmartrefundlines.Setquantity               (const Value: Double    ); begin SetFloatField('quantity'                , Value);end;
procedure Twalmartrefundlines.SetreturnExpectedFlag     (const Value: Boolean   ); begin SetBooleanField('returnExpectedFlag'      , Value);end;
procedure Twalmartrefundlines.SetisFastReplacement      (const Value: Boolean   ); begin SetBooleanField('isFastReplacement'       , Value);end;
procedure Twalmartrefundlines.SetisKeepIt               (const Value: Boolean   ); begin SetBooleanField('isKeepIt'                , Value);end;
procedure Twalmartrefundlines.SetlastItem               (const Value: Boolean   ); begin SetBooleanField('lastItem'                , Value);end;
procedure Twalmartrefundlines.SetrefundedQty            (const Value: Double    ); begin SetFloatField('refundedQty'             , Value);end;
procedure Twalmartrefundlines.SetrechargeableQty        (const Value: Double    ); begin SetFloatField('rechargeableQty'         , Value);end;
procedure Twalmartrefundlines.Setstatus                 (const Value: string    ); begin SetStringField('status'                  , Value);end;
procedure Twalmartrefundlines.SetstatusTime             (const Value: string    ); begin SetStringField('statusTime'              , Value);end;
procedure Twalmartrefundlines.SetrefundChannel          (const Value: string    ); begin SetStringField('refundChannel'           , Value);end;
procedure Twalmartrefundlines.SetERPRefundRef           (const Value: string    ); begin SetStringField('ERPRefundRef'            , Value);end;
function Twalmartrefundlines.getwalmartrefundlinecharges: Twalmartrefundlinecharges;
begin
  result := Twalmartrefundlinecharges(GetContainerComponent(Twalmartrefundlinecharges ,'RefundLineID = ' + IntToStr(ID) ));
end;
function Twalmartrefundlines.getwalmartrefundlinechargestotals: Twalmartrefundlinechargestotals;
begin
  result := Twalmartrefundlinechargestotals(GetContainerComponent(Twalmartrefundlinechargestotals ,'RefundLineID = ' + IntToStr(ID) ));
end;
function Twalmartrefundlines.getwalmartrefundlinetrackingdetail: Twalmartrefundlinetrackingdetail;
begin
  result := Twalmartrefundlinetrackingdetail(GetContainerComponent(Twalmartrefundlinetrackingdetail ,'RefundLineID = ' + IntToStr(ID) ));
end;


{Twalmartrefundlinetrackingdetail}

constructor Twalmartrefundlinetrackingdetail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinetrackingdetail';
  fSQL := 'SELECT * FROM tblwalmartrefundlinetrackingdetail';
end;


destructor Twalmartrefundlinetrackingdetail.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinetrackingdetail.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundId');
  SetPropertyFromNode(node,'RefundLineID');
  SetPropertyFromNode(node,'sequenceNo');
  SetPropertyFromNode(node,'eventTag');
  SetPropertyFromNode(node,'eventDescription');
  SetPropertyFromNode(node,'eventTime');
end;


procedure Twalmartrefundlinetrackingdetail.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'RefundLineID' ,RefundLineID);
  AddXMLNode(node,'sequenceNo' ,sequenceNo);
  AddXMLNode(node,'eventTag' ,eventTag);
  AddXMLNode(node,'eventDescription' ,eventDescription);
  AddXMLNode(node,'eventTime' ,eventTime);
end;


function Twalmartrefundlinetrackingdetail.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinetrackingdetail.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinetrackingdetail.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinetrackingdetail.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinetrackingdetail.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function Twalmartrefundlinetrackingdetail.getwalmartrefundlinetrackingdetailref: Twalmartrefundlinetrackingdetailref;
begin
  result := Twalmartrefundlinetrackingdetailref(GetContainerComponent(Twalmartrefundlinetrackingdetailref ,'TrackingDetail = ' + IntToStr(ID) ));
end;

class function Twalmartrefundlinetrackingdetail.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinetrackingdetail.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinetrackingdetail';
end;


function Twalmartrefundlinetrackingdetail.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinetrackingdetail.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlines then begin
      RefundId := Twalmartrefundlines(Owner).RefundId;
      RefundLineID := Twalmartrefundlines(Owner).ID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinetrackingdetail.GetRefundId               : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  Twalmartrefundlinetrackingdetail.GetRefundLineID           : Integer   ; begin Result := GetIntegerField('RefundLineID');end;
function  Twalmartrefundlinetrackingdetail.GetsequenceNo             : Integer   ; begin Result := GetIntegerField('sequenceNo');end;
function  Twalmartrefundlinetrackingdetail.GeteventTag               : string    ; begin Result := GetStringField('eventTag');end;
function  Twalmartrefundlinetrackingdetail.GeteventDescription       : string    ; begin Result := GetStringField('eventDescription');end;
function  Twalmartrefundlinetrackingdetail.GeteventTime              : string    ; begin Result := GetStringField('eventTime');end;
procedure Twalmartrefundlinetrackingdetail.SetRefundId               (const Value: Integer   ); begin SetIntegerField('RefundId'                , Value);end;
procedure Twalmartrefundlinetrackingdetail.SetRefundLineID           (const Value: Integer   ); begin SetIntegerField('RefundLineID'            , Value);end;
procedure Twalmartrefundlinetrackingdetail.SetsequenceNo             (const Value: Integer   ); begin SetIntegerField('sequenceNo'              , Value);end;
procedure Twalmartrefundlinetrackingdetail.SeteventTag               (const Value: string    ); begin SetStringField('eventTag'                , Value);end;
procedure Twalmartrefundlinetrackingdetail.SeteventDescription       (const Value: string    ); begin SetStringField('eventDescription'        , Value);end;
procedure Twalmartrefundlinetrackingdetail.SeteventTime              (const Value: string    ); begin SetStringField('eventTime'               , Value);end;


{Twalmartrefundlinetrackingdetailref}

constructor Twalmartrefundlinetrackingdetailref.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefundlinetrackingdetailref';
  fSQL := 'SELECT * FROM tblwalmartrefundlinetrackingdetailref';
end;


destructor Twalmartrefundlinetrackingdetailref.Destroy;
begin
  inherited;
end;


procedure Twalmartrefundlinetrackingdetailref.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'RefundId');
  SetPropertyFromNode(node,'RefundLineID');
  SetPropertyFromNode(node,'TrackingDetail');
  SetPropertyFromNode(node,'refname');
  SetPropertyFromNode(node,'refValue');
end;


procedure Twalmartrefundlinetrackingdetailref.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'RefundLineID' ,RefundLineID);
  AddXMLNode(node,'TrackingDetail' ,TrackingDetail);
  AddXMLNode(node,'refname' ,refname);
  AddXMLNode(node,'refValue' ,refValue);
end;


function Twalmartrefundlinetrackingdetailref.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefundlinetrackingdetailref.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefundlinetrackingdetailref.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefundlinetrackingdetailref.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefundlinetrackingdetailref.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefundlinetrackingdetailref.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefundlinetrackingdetailref.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefundlinetrackingdetailref';
end;


function Twalmartrefundlinetrackingdetailref.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefundlinetrackingdetailref.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
  if not result then Exit;
  if assigned(Owner) then
    if owner is Twalmartrefundlinetrackingdetail then begin
      RefundId := Twalmartrefundlinetrackingdetail(Owner).RefundId;
      RefundLineID := Twalmartrefundlinetrackingdetail(Owner).RefundLineID;
      TrackingDetail := Twalmartrefundlinetrackingdetail(Owner).RefundLineID;
    end;
end;


{Property Functions}
function  Twalmartrefundlinetrackingdetailref.GetRefundId               : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  Twalmartrefundlinetrackingdetailref.GetRefundLineID           : Integer   ; begin Result := GetIntegerField('RefundLineID');end;
function  Twalmartrefundlinetrackingdetailref.GetTrackingDetail         : Integer   ; begin Result := GetIntegerField('TrackingDetail');end;
function  Twalmartrefundlinetrackingdetailref.Getrefname                : string    ; begin Result := GetStringField('refname');end;
function  Twalmartrefundlinetrackingdetailref.GetrefValue               : string    ; begin Result := GetStringField('refValue');end;
procedure Twalmartrefundlinetrackingdetailref.SetRefundId               (const Value: Integer   ); begin SetIntegerField('RefundId'                , Value);end;
procedure Twalmartrefundlinetrackingdetailref.SetRefundLineID           (const Value: Integer   ); begin SetIntegerField('RefundLineID'            , Value);end;
procedure Twalmartrefundlinetrackingdetailref.SetTrackingDetail         (const Value: Integer   ); begin SetIntegerField('TrackingDetail'          , Value);end;
procedure Twalmartrefundlinetrackingdetailref.Setrefname                (const Value: string    ); begin SetStringField('refname'                 , Value);end;
procedure Twalmartrefundlinetrackingdetailref.SetrefValue               (const Value: string    ); begin SetStringField('refValue'                , Value);end;


{Twalmartrefunds}

constructor Twalmartrefunds.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartrefunds';
  fSQL := 'SELECT * FROM tblwalmartrefunds';
end;


destructor Twalmartrefunds.Destroy;
begin
  inherited;
end;


procedure Twalmartrefunds.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'returnOrderId');
  SetPropertyFromNode(node,'customerEmailId');
  SetPropertyFromNode(node,'CustomerFirstName');
  SetPropertyFromNode(node,'CustomerLastName');
  SetPropertyFromNode(node,'customerOrderId');
  SetPropertyFromNode(node,'returnOrderDate');
  SetPropertyFromNode(node,'returnByDate');
  SetPropertyFromNode(node,'totalRefundAmount');
  SetPropertyFromNode(node,'totalRefundAmountCurrecny');
  SetPropertyFromNode(node,'returnChannelName');
end;


procedure Twalmartrefunds.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'returnOrderId' ,returnOrderId);
  AddXMLNode(node,'customerEmailId' ,customerEmailId);
  AddXMLNode(node,'CustomerFirstName' ,CustomerFirstName);
  AddXMLNode(node,'CustomerLastName' ,CustomerLastName);
  AddXMLNode(node,'customerOrderId' ,customerOrderId);
  AddXMLNode(node,'returnOrderDate' ,returnOrderDate);
  AddXMLNode(node,'returnByDate' ,returnByDate);
  AddXMLNode(node,'totalRefundAmount' ,totalRefundAmount);
  AddXMLNode(node,'totalRefundAmountCurrecny' ,totalRefundAmountCurrecny);
  AddXMLNode(node,'returnChannelName' ,returnChannelName);
end;


function Twalmartrefunds.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartrefunds.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartrefunds.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartrefunds.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartrefunds.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartrefunds.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartrefunds.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartrefunds';
end;


function Twalmartrefunds.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function Twalmartrefunds.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
end;


{Property Functions}
function  Twalmartrefunds.GetreturnOrderId            : string    ; begin Result := GetStringField('returnOrderId');end;
function  Twalmartrefunds.GetcustomerEmailId          : string    ; begin Result := GetStringField('customerEmailId');end;
function  Twalmartrefunds.GetCustomerFirstName        : string    ; begin Result := GetStringField('CustomerFirstName');end;
function  Twalmartrefunds.GetCustomerLastName         : string    ; begin Result := GetStringField('CustomerLastName');end;
function  Twalmartrefunds.GetcustomerOrderId          : string    ; begin Result := GetStringField('customerOrderId');end;
function  Twalmartrefunds.GetreturnOrderDate          : string    ; begin Result := GetStringField('returnOrderDate');end;
function  Twalmartrefunds.GetreturnByDate             : string    ; begin Result := GetStringField('returnByDate');end;
function  Twalmartrefunds.GettotalRefundAmount        : Double    ; begin Result := GetFloatField('totalRefundAmount');end;
function  Twalmartrefunds.GettotalRefundAmountCurrecny: Double    ; begin Result := GetFloatField('totalRefundAmountCurrecny');end;
function  Twalmartrefunds.GetreturnChannelName        : string    ; begin Result := GetStringField('returnChannelName');end;
procedure Twalmartrefunds.SetreturnOrderId            (const Value: string    ); begin SetStringField('returnOrderId'             , Value);end;
procedure Twalmartrefunds.SetcustomerEmailId          (const Value: string    ); begin SetStringField('customerEmailId'           , Value);end;
procedure Twalmartrefunds.SetCustomerFirstName        (const Value: string    ); begin SetStringField('CustomerFirstName'         , Value);end;
procedure Twalmartrefunds.SetCustomerLastName         (const Value: string    ); begin SetStringField('CustomerLastName'          , Value);end;
procedure Twalmartrefunds.SetcustomerOrderId          (const Value: string    ); begin SetStringField('customerOrderId'           , Value);end;
procedure Twalmartrefunds.SetreturnOrderDate          (const Value: string    ); begin SetStringField('returnOrderDate'           , Value);end;
procedure Twalmartrefunds.SetreturnByDate             (const Value: string    ); begin SetStringField('returnByDate'              , Value);end;
procedure Twalmartrefunds.SettotalRefundAmount        (const Value: Double    ); begin SetFloatField('totalRefundAmount'         , Value);end;
procedure Twalmartrefunds.SettotalRefundAmountCurrecny(const Value: Double    ); begin SetFloatField('totalRefundAmountCurrecny' , Value);end;
procedure Twalmartrefunds.SetreturnChannelName          (const Value: string    ); begin SetStringField('returnChannelName'           , Value);end;
function Twalmartrefunds.getwalmartrefundlinegroups: Twalmartrefundlinegroups;
begin
  result := Twalmartrefundlinegroups(GetContainerComponent(Twalmartrefundlinegroups ,'RefundID = ' + IntToStr(ID) ));
end;
function Twalmartrefunds.getwalmartrefundlines: Twalmartrefundlines;
begin
  result := Twalmartrefundlines(GetContainerComponent(Twalmartrefundlines ,'RefundId = ' + IntToStr(ID) ));
end;


initialization
  RegisterClass(Twalmartrefunds);
  RegisterClass(Twalmartrefundlinetrackingdetailref);
  RegisterClass(Twalmartrefundlinetrackingdetail);
  RegisterClass(Twalmartrefundlines);
  RegisterClass(Twalmartrefundlinegroups);
  RegisterClass(Twalmartrefundlinegrouplabels);
  RegisterClass(Twalmartrefundlinegroupcarrierinfo);
  RegisterClass(Twalmartrefundlinechargetax);
  RegisterClass(Twalmartrefundlinechargestotals);
  RegisterClass(Twalmartrefundlinecharges);
  RegisterClass(Twalmartrefundlinechargereferences);
  RegisterClass(Twalmartrefundgrouplines);


end.

