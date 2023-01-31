unit BusObjShipment;

interface
{$I ERP.inc}

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess,
  ibxezship, BusObjShippingAddress, ShipIntegrationTypes, IntegerListObj,
  ibxupsship, ERPDbComponents;

const
  ShipmentListStatus_NotProcessed = 'Not Processed';
  ShipmentListStatus_PartiallyProcessed = 'Partially Processed';
  ShipmentListStatus_Processed = 'Processed';

type

  TShipment = class;
  TShipmentList = class(TMSBusObj)
  private
    fInvalidShipmentId: integer;
    function GetDateCreated: TDateTime;
    function GetEmployeeName: string;
    function GetSaleId: integer;
    function GetSaleType: string;
    procedure SetDateCreated(const Value: TDateTime);
    procedure SetEmployeeName(const Value: string);
    procedure SetSaleId(const Value: integer);
    procedure SetSaleType(const Value: string);
    function GetShipments: TShipment;
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetSaleRefNo: string;
    procedure SetSaleRefNo(const Value: string);
    function GetStatus: string;
    procedure SetStatus(const Value: string);
  protected
    procedure DoFieldOnChange(Sender: TField); override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function GetShipAddressIdList: string;
    property InvalidShipmentId : integer read fInvalidShipmentId;
    class procedure UpdateStatus(ShipmentList: TShipmentList); overload;
    class procedure UpdateStatus(ShipmentListId: integer; Connection: TCustomMyConnection = nil); overload;
    class function ShipmentListSaleType(ShipmentListId: integer; Connection: TCustomMyConnection = nil): string;
    function Copy(SrcSale, DestSale: TMSBusObj): integer;
    procedure UpdatePackageReferences(PONumber: string);
    function ShipAll(ErrorLIst: TStringList): boolean;
    procedure ShipmentIdListForLabelType(aLabelType: TibxupsshipLabelImageTypes; IdList: TIntegerList);
    procedure AutoAllocateSales;
    function NonCanceledCount: integer;
  published
    property SaleId: integer read GetSaleId write SetSaleId;
    property SaleType: string read GetSaleType write SetSaleType;
    property SaleRefNo: string read GetSaleRefNo write SetSaleRefNo;
    property DateCreated: TDateTime read GetDateCreated write SetDateCreated;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property Status: string read GetStatus write SetStatus;
    property Active: boolean read GetActive write SetActive;
    property Shipments: TShipment read GetShipments;
  end;

  TShipmentPackage = class;
  TShipmentSaleLine = class;

  TSalesShipments = class(TMSBusObj)
  private
    function GetsaleID                      : Integer   ;
    //function GetsaleLineId                  : Integer   ;
    function GetShipmentId                  : Integer   ;
    function GetShipAddressId               : Integer   ;
    function GetShipmentListId              : Integer   ;
    function GetLabelImageType              : Integer   ;
    function GetMasterTrackingNumber        : string    ;
    function GetPackageIDCode               : string    ;
    function GetPayorAccountNumber          : string    ;
    function GetPayorCountryCode            : string    ;
    function GetPayorType                   : Integer   ;
    function GetPayorZipCode                : string    ;
    function GetProvider                    : Integer   ;
    function GetPostageProvider             : Integer   ;
    function GetRecipientFirstName          : string    ;
    function GetRecipientMiddleInitial      : string    ;
    function GetRecipientLastName           : string    ;
    function GetRecipientCompany            : string    ;
    function GetRecipientAddress1           : string    ;
    function GetRecipientAddress2           : string    ;
    function GetRecipientCity               : string    ;
    function GetRecipientState              : string    ;
    function GetRecipientZipCode            : string    ;
    function GetRecipientCountryCode        : string    ;
    function GetRecipientEmail              : string    ;
    function GetRecipientPhone              : string    ;
    function GetRecipientFax                : string    ;
    function GetRecipientAddressValID       : Boolean   ;
    function GetSenderFirstName             : string    ;
    function GetSenderMiddleInitial         : string    ;
    function GetSenderLastName              : string    ;
    function GetSenderCompany               : string    ;
    function GetSenderAddress1              : string    ;
    function GetSenderAddress2              : string    ;
    function GetSenderCity                  : string    ;
    function GetSenderState                 : string    ;
    function GetSenderZipCode               : string    ;
    function GetSenderCountryCode           : string    ;
    function GetSenderEmail                 : string    ;
    function GetSenderPhone                 : string    ;
    function GetSenderFax                   : string    ;
    function GetServiceType                 : Integer   ;
    function GetShipDate                    : TDateTime ;
    function GetDeliveryData                : TDateTime ;
    function GetShipmentSpecialServices     : Integer   ;
    function GetTotalNetCharge              : Double    ;
    function GetTotalBaseCharge             : Double    ;
    function GetTotalSurcharges             : Double    ;
    function GetTotalNetChargeNegotiated    : Double    ;
    function GetMICostCenter                : string    ;
    function GetMIPackageID                 : string    ;
    function GetEndorsement                 : Integer   ;
    function GetDropoffType                 : Integer   ;
    function GetProcessed                   : Boolean   ;
    function GetProcessedComment            : string    ;
    function GetActive                      : Boolean   ;
    procedure SetsaleID                      (const Value: Integer   );
    //procedure SetsaleLineId                  (const Value: Integer   );
    procedure SetShipmentId                  (const Value: Integer   );
    procedure SetShipAddressId               (const Value: Integer   );
    procedure SetShipmentListId              (const Value: Integer   );
    procedure SetLabelImageType              (const Value: Integer   );
    procedure SetMasterTrackingNumber        (const Value: string    );
    procedure SetPackageIDCode               (const Value: string    );
    procedure SetPayorAccountNumber          (const Value: string    );
    procedure SetPayorCountryCode            (const Value: string    );
    procedure SetPayorType                   (const Value: Integer   );
    procedure SetPayorZipCode                (const Value: string    );
    procedure SetProvider                    (const Value: Integer   );
    procedure SetPostageProvider             (const Value: Integer   );
    procedure SetRecipientFirstName          (const Value: string    );
    procedure SetRecipientMiddleInitial      (const Value: string    );
    procedure SetRecipientLastName           (const Value: string    );
    procedure SetRecipientCompany            (const Value: string    );
    procedure SetRecipientAddress1           (const Value: string    );
    procedure SetRecipientAddress2           (const Value: string    );
    procedure SetRecipientCity               (const Value: string    );
    procedure SetRecipientState              (const Value: string    );
    procedure SetRecipientZipCode            (const Value: string    );
    procedure SetRecipientCountryCode        (const Value: string    );
    procedure SetRecipientEmail              (const Value: string    );
    procedure SetRecipientPhone              (const Value: string    );
    procedure SetRecipientFax                (const Value: string    );
    procedure SetRecipientAddressValID       (const Value: Boolean   );
    procedure SetSenderFirstName             (const Value: string    );
    procedure SetSenderMiddleInitial         (const Value: string    );
    procedure SetSenderLastName              (const Value: string    );
    procedure SetSenderCompany               (const Value: string    );
    procedure SetSenderAddress1              (const Value: string    );
    procedure SetSenderAddress2              (const Value: string    );
    procedure SetSenderCity                  (const Value: string    );
    procedure SetSenderState                 (const Value: string    );
    procedure SetSenderZipCode               (const Value: string    );
    procedure SetSenderCountryCode           (const Value: string    );
    procedure SetSenderEmail                 (const Value: string    );
    procedure SetSenderPhone                 (const Value: string    );
    procedure SetSenderFax                   (const Value: string    );
    procedure SetServiceType                 (const Value: Integer   );
    procedure SetShipDate                    (const Value: TDateTime );
    procedure SetDeliveryData                (const Value: TDateTime );
    procedure SetShipmentSpecialServices     (const Value: Integer   );
    procedure SetTotalNetCharge              (const Value: Double    );
    procedure SetTotalBaseCharge             (const Value: Double    );
    procedure SetTotalSurcharges             (const Value: Double    );
    procedure SetTotalNetChargeNegotiated    (const Value: Double    );
    procedure SetMICostCenter                (const Value: string    );
    procedure SetMIPackageID                 (const Value: string    );
    procedure SetEndorsement                 (const Value: Integer   );
    procedure SetDropoffType                 (const Value: Integer   );
    procedure SetProcessed                   (const Value: Boolean   );
    procedure SetProcessedComment            (const Value: string    );
    procedure SetActive                      (const Value: Boolean   );
    function getProviderName: String;
    function GetDocumentsOnly: boolean;
    procedure SetDocumentsOnly(const Value: boolean);
    function GetBookingNumber: string;
    procedure SetBookingNumber(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Property ProviderName:String read getProviderName;
    class function ShipmentExistsForSale(aSaleID: integer): boolean;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
    property saleID                       :Integer     read GetsaleID                     write SetsaleID                  ;
    //property saleLineId                   :Integer     read GetsaleLineId                 write SetsaleLineId              ;
    property ShipmentId                   :Integer     read GetShipmentId                 write SetShipmentId              ;
    property ShipAddressId                :Integer     read GetShipAddressId              write SetShipAddressId           ;
    property ShipmentListId               :Integer     read GetShipmentListId             write SetShipmentListId          ;
    property LabelImageType               :Integer     read GetLabelImageType             write SetLabelImageType          ;
    property MasterTrackingNumber         :string      read GetMasterTrackingNumber       write SetMasterTrackingNumber    ;
    property PackageIDCode                :string      read GetPackageIDCode              write SetPackageIDCode           ;
    property PayorAccountNumber           :string      read GetPayorAccountNumber         write SetPayorAccountNumber      ;
    property PayorCountryCode             :string      read GetPayorCountryCode           write SetPayorCountryCode        ;
    property PayorType                    :Integer     read GetPayorType                  write SetPayorType               ;
    property PayorZipCode                 :string      read GetPayorZipCode               write SetPayorZipCode            ;
    property Provider                     :Integer     read GetProvider                   write SetProvider                ;
    property PostageProvider              :Integer     read GetPostageProvider            write SetPostageProvider         ;
    property RecipientFirstName           :string      read GetRecipientFirstName         write SetRecipientFirstName      ;
    property RecipientMiddleInitial       :string      read GetRecipientMiddleInitial     write SetRecipientMiddleInitial  ;
    property RecipientLastName            :string      read GetRecipientLastName          write SetRecipientLastName       ;
    property RecipientCompany             :string      read GetRecipientCompany           write SetRecipientCompany        ;
    property RecipientAddress1            :string      read GetRecipientAddress1          write SetRecipientAddress1       ;
    property RecipientAddress2            :string      read GetRecipientAddress2          write SetRecipientAddress2       ;
    property RecipientCity                :string      read GetRecipientCity              write SetRecipientCity           ;
    property RecipientState               :string      read GetRecipientState             write SetRecipientState          ;
    property RecipientZipCode             :string      read GetRecipientZipCode           write SetRecipientZipCode        ;
    property RecipientCountryCode         :string      read GetRecipientCountryCode       write SetRecipientCountryCode    ;
    property RecipientEmail               :string      read GetRecipientEmail             write SetRecipientEmail          ;
    property RecipientPhone               :string      read GetRecipientPhone             write SetRecipientPhone          ;
    property RecipientFax                 :string      read GetRecipientFax               write SetRecipientFax            ;
    property RecipientAddressValID        :Boolean     read GetRecipientAddressValID      write SetRecipientAddressValID   ;
    property SenderFirstName              :string      read GetSenderFirstName            write SetSenderFirstName         ;
    property SenderMiddleInitial          :string      read GetSenderMiddleInitial        write SetSenderMiddleInitial     ;
    property SenderLastName               :string      read GetSenderLastName             write SetSenderLastName          ;
    property SenderCompany                :string      read GetSenderCompany              write SetSenderCompany           ;
    property SenderAddress1               :string      read GetSenderAddress1             write SetSenderAddress1          ;
    property SenderAddress2               :string      read GetSenderAddress2             write SetSenderAddress2          ;
    property SenderCity                   :string      read GetSenderCity                 write SetSenderCity              ;
    property SenderState                  :string      read GetSenderState                write SetSenderState             ;
    property SenderZipCode                :string      read GetSenderZipCode              write SetSenderZipCode           ;
    property SenderCountryCode            :string      read GetSenderCountryCode          write SetSenderCountryCode       ;
    property SenderEmail                  :string      read GetSenderEmail                write SetSenderEmail             ;
    property SenderPhone                  :string      read GetSenderPhone                write SetSenderPhone             ;
    property SenderFax                    :string      read GetSenderFax                  write SetSenderFax               ;
    property ServiceType                  :Integer     read GetServiceType                write SetServiceType             ;
    property ShipDate                     :TDateTime   read GetShipDate                   write SetShipDate                ;
    property DeliveryData                 :TDateTime   read GetDeliveryData               write SetDeliveryData            ;
    property ShipmentSpecialServices      :Integer     read GetShipmentSpecialServices    write SetShipmentSpecialServices ;
    property TotalNetCharge               :Double      read GetTotalNetCharge             write SetTotalNetCharge          ;
    property TotalBaseCharge              :Double      read GetTotalBaseCharge            write SetTotalBaseCharge         ;
    property TotalSurcharges              :Double      read GetTotalSurcharges            write SetTotalSurcharges         ;
    property TotalNetChargeNegotiated     :Double      read GetTotalNetChargeNegotiated   write SetTotalNetChargeNegotiated;
    property MICostCenter                 :string      read GetMICostCenter               write SetMICostCenter            ;
    property MIPackageID                  :string      read GetMIPackageID                write SetMIPackageID             ;
    property BookingNumber: string read GetBookingNumber write SetBookingNumber;
    property Endorsement                  :Integer     read GetEndorsement                write SetEndorsement             ;
    property DropoffType                  :Integer     read GetDropoffType                write SetDropoffType             ;
    property Processed                    :Boolean     read GetProcessed                  write SetProcessed               ;
    property ProcessedComment             :string      read GetProcessedComment           write SetProcessedComment        ;
    property DocumentsOnly: boolean read GetDocumentsOnly write SetDocumentsOnly;
    property Active                       :Boolean     read GetActive                     write SetActive                  ;
  end;

  TShipment = class(TMSBusObj)
  private
    function GetLabelImageType: integer;
    function GetMasterTrackingNumber: string;
    function GetPayorAccountNumber: string;
    function GetPayorCountryCode: string;
    function GetPayorType: TibxezshipPayorTypes;
    function GetPayorZipCode: string;
    function GetProvider: TibxezshipProviders;
//    function GetReceipientAddress: string;
    function GetSaleId: integer;
//    function GetSenderAddress: string;
    function GetServiceType: TibxezshipServiceTypes;
    function GetShipAddressId: integer;
    procedure SetLabelImageType(const Value: integer);
    procedure SetMasterTrackingNumber(const Value: string);
    procedure SetPayorAccountNumber(const Value: string);
    procedure SetPayorCountryCode(const Value: string);
    procedure SetPayorType(const Value: TibxezshipPayorTypes);
    procedure SetPayorZipCode(const Value: string);
    procedure SetProvider(const Value: TibxezshipProviders);
//    procedure SetReceipientAddress(const Value: string);
//    procedure SetSenderAddress(const Value: string);
    procedure SetServiceType(const Value: TibxezshipServiceTypes);
    procedure SetShipAddressId(const Value: integer);
    function GetPackages: TShipmentPackage;
    function GetSalesLines: TShipmentSaleLine;
    function GetShippingAddress: TShippingAddress;
    function GetShipmentListId: integer;
    procedure SetShipmentListId(const Value: integer);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetShipmentList: TShipmentList;
    function GetSenderAddress1: string;
    function GetSenderAddress2: string;
    function GetSenderCity: string;
    function GetSenderCompany: string;
    function GetSenderCountryCode: string;
    function GetSenderEmail: string;
    function GetSenderFax: string;
    function GetSenderFirstName: string;
    function GetSenderInitial: string;
    function GetSenderLastName: string;
    function GetSenderPhone: string;
    function GetSenderState: string;
    function GetSenderZipCode: string;
    procedure SetSenderAddress1(const Value: string);
    procedure SetSenderAddress2(const Value: string);
    procedure SetSenderCity(const Value: string);
    procedure SetSenderCompany(const Value: string);
    procedure SetSenderCountryCode(const Value: string);
    procedure SetSenderEmail(const Value: string);
    procedure SetSenderFax(const Value: string);
    procedure SetSenderFirstName(const Value: string);
    procedure SetSenderInitial(const Value: string);
    procedure SetSenderLastName(const Value: string);
    procedure SetSenderPhone(const Value: string);
    procedure SetSenderState(const Value: string);
    procedure SetSenderZipCode(const Value: string);
    function GetRecipientAddress1: string;
    function GetRecipientAddress2: string;
    function GetRecipientCity: string;
    function GetRecipientCompany: string;
    function GetRecipientCountryCode: string;
    function GetRecipientEmail: string;
    function GetRecipientFax: string;
    function GetRecipientFirstName: string;
    function GetRecipientInitial: string;
    function GetRecipientLastName: string;
    function GetRecipientPhone: string;
    function GetRecipientState: string;
    function GetRecipientZipCode: string;
    procedure SetRecipientAddress1(const Value: string);
    procedure SetRecipientAddress2(const Value: string);
    procedure SetRecipientCity(const Value: string);
    procedure SetRecipientCompany(const Value: string);
    procedure SetRecipientCountryCode(const Value: string);
    procedure SetRecipientEmail(const Value: string);
    procedure SetRecipientFax(const Value: string);
    procedure SetRecipientFirstName(const Value: string);
    procedure SetRecipientInitial(const Value: string);
    procedure SetRecipientLastName(const Value: string);
    procedure SetRecipientPhone(const Value: string);
    procedure SetRecipientState(const Value: string);
    procedure SetRecipientZipCode(const Value: string);
    function GetRecipientAddressValid: boolean;
    procedure SetRecipientAddressValid(const Value: boolean);
    function GetProcessed: boolean;
    procedure SetProcessed(const Value: boolean);
    function GetTotalBaseCharge: double;
    function GetTotalSurcharges: double;
    procedure SetTotalBaseCharge(const Value: double);
    procedure SetTotalSurcharges(const Value: double);
    function GetShipperType: TShipperType;
    function GetSaleType: string;
    function GetTotalNetChargeNegotiated: double;
    procedure SetTotalNetChargeNegotiated(const Value: double);
    function GetEndorsement: integer;
    function GetMICostCenter: string;
    function GetMIPackageID: string;
    procedure SetEndorsement(const Value: integer);
    procedure SetMICostCenter(const Value: string);
    procedure SetMIPackageID(const Value: string);
    function GetPackageIDCode: string;
    procedure SetPackageIDCode(const Value: string);
    function GetDeliveryDate: TDateTime;
    procedure SetDeliveryDate(const Value: TDateTime);
    function GetDropoffType: integer;
    procedure SetDropoffType(const Value: integer);
    function GetPostageProvider: integer;
    procedure SetPostageProvider(const Value: integer);
    function GetProcessedComment: string;
    procedure SetProcessedComment(const Value: string);
    function GetDocumentsOnly: boolean;
    procedure SetDocumentsOnly(const Value: boolean);
    procedure DoOnGetShipmentLabelsError(Sender: TObject; ErrorCode: integer; const Description: String);
    function GetBookingNumber: string;
    procedure SetBookingNumber(const Value: string);
    procedure SetShippingDefaults;
    function GetCanceled: boolean;
    procedure SetCanceled(const Value: boolean);
  protected
    function GetTotalNetCharge: double;
    procedure SetTotalNetCharge(const Value: double);
    function GetShipmentSpecialServices: int64;
    procedure SetShipmentSpecialServices(const Value: int64);
    function GetShipDate: TDateTime;
    procedure SetShipDate(const Value: TDateTime);
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoGetShipmentLables: boolean;
    function DoCancelShipment: boolean;
    procedure SetDefaultsForProvider;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function Ship: boolean;
    function CancelShipment: boolean;
    property ShippingAddress: TShippingAddress read GetShippingAddress;
    property SaleId: integer read GetSaleId;
    property ShipmentList: TShipmentList read GetShipmentList;
    procedure PopulateRecipientAddress;
    procedure UpdateShippingAddress;
    function RecipientAddressAsSingleLine: string;
    property ShipperType: TShipperType read GetShipperType;
    property SaleType: string read GetSaleType;
    function GetSaleRefNo: string;
    function IsFedExInternational: boolean;
    procedure AddTrackingNumberToSale;
    procedure DoFieldOnChange(Sender: TField); override;
  published
    property ServiceType: TibxezshipServiceTypes read GetServiceType write SetServiceType;
    property ShipmentListId: integer read GetShipmentListId write SetShipmentListId;
    property ShipAddressId: integer read GetShipAddressId write SetShipAddressId;
    property LabelImageType: integer read GetLabelImageType write SetLabelImageType;
    property MasterTrackingNumber: string read GetMasterTrackingNumber write SetMasterTrackingNumber;
    property PackageIDCode: string read GetPackageIDCode write SetPackageIDCode;
    property PayorAccountNumber: string read GetPayorAccountNumber write SetPayorAccountNumber;
    property PayorCountryCode: string read GetPayorCountryCode write SetPayorCountryCode;
    property PayorType: TibxezshipPayorTypes read GetPayorType write SetPayorType;
    property PayorZipCode: string read GetPayorZipCode write SetPayorZipCode;
    property Provider: TibxezshipProviders read GetProvider write SetProvider;
    { PostageProvider is only for USPS - (ppNone, ppEndicia) }
    property PostageProvider: integer read GetPostageProvider write SetPostageProvider;

//    property ReceipientAddress: string read GetReceipientAddress write SetReceipientAddress;
//    property SenderAddress: string read GetSenderAddress write SetSenderAddress;

    property RecipientFirstName: string read GetRecipientFirstName write SetRecipientFirstName;
    property RecipientInitial : string read GetRecipientInitial write SetRecipientInitial;
    property RecipientLastName : string read GetRecipientLastName write SetRecipientLastName;
    property RecipientCompany : string read GetRecipientCompany write SetRecipientCompany;
    property RecipientAddress1 : string read GetRecipientAddress1 write SetRecipientAddress1;
    property RecipientAddress2 : string read GetRecipientAddress2 write SetRecipientAddress2;
    property RecipientCity : string read GetRecipientCity write SetRecipientCity;
    property RecipientState : string read GetRecipientState write SetRecipientState;
    property RecipientZipCode : string read GetRecipientZipCode write SetRecipientZipCode;
    property RecipientCountryCode : string read GetRecipientCountryCode write SetRecipientCountryCode;
    property RecipientEmail : string read GetRecipientEmail write SetRecipientEmail;
    property RecipientPhone : string read GetRecipientPhone write SetRecipientPhone;
    property RecipientFax : string read GetRecipientFax write SetRecipientFax;
    property RecipientAddressValid: boolean read GetRecipientAddressValid write SetRecipientAddressValid;

    property SenderFirstName: string read GetSenderFirstName write SetSenderFirstName;
    property SenderInitial : string read GetSenderInitial write SetSenderInitial;
    property SenderLastName : string read GetSenderLastName write SetSenderLastName;
    property SenderCompany : string read GetSenderCompany write SetSenderCompany;
    property SenderAddress1 : string read GetSenderAddress1 write SetSenderAddress1;
    property SenderAddress2 : string read GetSenderAddress2 write SetSenderAddress2;
    property SenderCity : string read GetSenderCity write SetSenderCity;
    property SenderState : string read GetSenderState write SetSenderState;
    property SenderZipCode : string read GetSenderZipCode write SetSenderZipCode;
    property SenderCountryCode : string read GetSenderCountryCode write SetSenderCountryCode;
    property SenderEmail : string read GetSenderEmail write SetSenderEmail;
    property SenderPhone : string read GetSenderPhone write SetSenderPhone;
    property SenderFax : string read GetSenderFax write SetSenderFax;


//    property ServiceType: TibxezshipServiceTypes read GetServiceType write SetServiceType;
    property ShipDate: TDateTime read GetShipDate write SetShipDate; // "FedEx,USPS,Canada Post only"
    property DeliveryDate: TDateTime read GetDeliveryDate write SetDeliveryDate; // FedEx only
    property ShipmentSpecialServices: int64 read GetShipmentSpecialServices write SetShipmentSpecialServices; //"FedEx,UPS,USPS only"
    property TotalNetCharge: double read GetTotalNetCharge write SetTotalNetCharge; // "FedEx,UPS only",
    property TotalBaseCharge: double read GetTotalBaseCharge write SetTotalBaseCharge;
    property TotalSurcharges: double read GetTotalSurcharges write SetTotalSurcharges;
    property TotalNetChargeNegotiated: double read GetTotalNetChargeNegotiated write SetTotalNetChargeNegotiated;
    property Packages: TShipmentPackage read GetPackages;
    property SalesLines: TShipmentSaleLine read GetSalesLines;

    { The following 3 properties only apply for "UPS Mail Innovation" shipments }
    property MICostCenter: string read GetMICostCenter write SetMICostCenter;
    property MIPackageID: string read GetMIPackageID write SetMIPackageID;
    property BookingNumber: string read GetBookingNumber write SetBookingNumber;
    property Endorsement: integer read GetEndorsement write SetEndorsement;

    { FedEx specific }
    property DropoffType: integer read GetDropoffType write SetDropoffType;

    property Processed: boolean read GetProcessed write SetProcessed;
    property ProcessedComment: string read GetProcessedComment write SetProcessedComment;
    property DocumentsOnly: boolean read GetDocumentsOnly write SetDocumentsOnly;
    property Active: boolean read GetActive write SetActive;
    property Canceled: boolean read GetCanceled write SetCanceled;
  end;

  TShipmentPackage = class(TMSBusObj)
  private
    function GetShipmentId: integer;
    procedure SetShipmentId(const Value: integer);
    function GetPackageWidth: integer;
    procedure SetPackageWidth(const Value: integer);
    function GetPackageWeight: string;
    procedure SetPackageWeight(const Value: string);
    function GetPackageOptNonStandardContainer: boolean;
    procedure SetPackageOptNonStandardContainer(const Value: boolean);
    function GetPackageOptAdditionalHandling: boolean;
    procedure SetPackageOptAdditionalHandling(const Value: boolean);
    function GetPackageOptAlcohol: boolean;
    function GetPackageOptAppointmentDelivery: boolean;
    function GetPackageOptCOD: boolean;
    function GetPackageOptDangerousGoods: boolean;
    function GetPackageOptDryIce: boolean;
    function GetPackageOptPriorityAlert: boolean;
    function GetPackageOptSignatureOption: boolean;
    procedure SetPackageOptAlcohol(const Value: boolean);
    procedure SetPackageOptAppointmentDelivery(const Value: boolean);
    procedure SetPackageOptCOD(const Value: boolean);
    procedure SetPackageOptDangerousGoods(const Value: boolean);
    procedure SetPackageOptDryIce(const Value: boolean);
    procedure SetPackageOptPriorityAlert(const Value: boolean);
    procedure SetPackageOptSignatureOption(const Value: boolean);
    function GetPackageReferenceByName(aName: string): string;
    procedure SetPackageReferenceByName(aName: string; const Value: string);
    function GetPackageWeightFrac: string;
    procedure SetPackageWeightFrac(const Value: string);
    function GetCommodityHarmonizedCode: string;
    function GetCommodityManufacturer: string;
    function GetCommodityNumberOfPieces: integer;
    function GetCommodityQuantity: integer;
    function GetCommodityQuantityUnit: string;
    function GetCommodityUnitPrice: double;
    function GetCommodityValue: double;
    function GetCommodityWeight: string;
    procedure SetCommodityHarmonizedCode(const Value: string);
    procedure SetCommodityManufacturer(const Value: string);
    procedure SetCommodityNumberOfPieces(const Value: integer);
    procedure SetCommodityQuantity(const Value: integer);
    procedure SetCommodityQuantityUnit(const Value: string);
    procedure SetCommodityUnitPrice(const Value: double);
    procedure SetCommodityValue(const Value: double);
    procedure SetCommodityWeight(const Value: string);
    function GetCommodityDescription: string;
    procedure SetCommodityDescription(const Value: string);
  protected
    function GetPackageBaseCharge: double;
    function GetPackageCODAmount: double;
//    function GetPackageCODLabel: string;
    function GetPackageCODType: TibxezshipPackageCODTypes;
    function GetPackageDangerousGoodsAccessible: boolean;
    function GetPackageDescription: string;
    function GetPackageHeight: integer;
    function GetPackageInsuredValue: double;
    function GetPackageLength: integer;
    function GetPackageNetCharge: double;
    function GetPackageReference: string;
    function GetPackageReturnRecpt: string;
//    function GetPackageShippingLabel: string;
    function GetPackageSignatureType: TibxezshipPackageSignatureTypes;
    function GetPackageSpecialService: integer;
    function GetPackageTotalDiscount: double;
    function GetPackageTotalSurcharges: double;
    function GetPackageTrackingNumber: string;
    function GetPackageType: TibxezshipPackageTypes;
    procedure SetPackageBaseCharge(const Value: double);
    procedure SetPackageCODAmount(const Value: double);
//    procedure SetPackageCODLabel(const Value: string);
    procedure SetPackageCODType(const Value: TibxezshipPackageCODTypes);
    procedure SetPackageDangerousGoodsAccessible(const Value: boolean);
    procedure SetPackageDescription(const Value: string);
    procedure SetPackageHeight(const Value: integer);
    procedure SetPackageInsuredValue(const Value: double);
    procedure SetPackageLength(const Value: integer);
    procedure SetPackageNetCharge(const Value: double);
    procedure SetPackageReference(const Value: string);
    procedure SetPackageReturnRecpt(const Value: string);
//    procedure SetPackageShippingLabel(const Value: string);
    procedure SetPackageSignatureType(
      const Value: TibxezshipPackageSignatureTypes);
    procedure SetPackageSpecialService(const Value: integer);
    procedure SetPackageTotalDiscount(const Value: double);
    procedure SetPackageTotalSurcharges(const Value: double);
    procedure SetPackageTrackingNumber(const Value: string);
    procedure SetPackageType(const Value: TibxezshipPackageTypes);
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender:TDatasetBusObj): boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property PackageReferenceByName[aName: string]: string read GetPackageReferenceByName write SetPackageReferenceByName;
    procedure RemovePackageReferenceByName(aName: string);
    procedure DoFieldOnChange(Sender: TField); override;
  published
    property ShipmentId: integer read GetShipmentId write SetShipmentId;
    property PackageWeight: string read GetPackageWeight write SetPackageWeight;
    property PackageWeightFrac: string read GetPackageWeightFrac write SetPackageWeightFrac;
    property PackageBaseCharge: double read GetPackageBaseCharge write SetPackageBaseCharge; // "read-only, FedEx,UPS,Canada Post only"
    property PackageCODAmount: double read GetPackageCODAmount write SetPackageCODAmount; // "FedEx,UPS only",
//    property PackageCODLabel: string read GetPackageCODLabel write SetPackageCODLabel; // "read-only, FedEx only"
    property PackageCODType: TibxezshipPackageCODTypes read GetPackageCODType write SetPackageCODType; // "FedEx,UPS only",
    property PackageDangerousGoodsAccessible: boolean read GetPackageDangerousGoodsAccessible write SetPackageDangerousGoodsAccessible; // "FedEx only",
    property PackageDescription: string read GetPackageDescription write SetPackageDescription; // "FedEx,UPS only",
    property PackageHeight: integer read GetPackageHeight write SetPackageHeight;
    property PackageInsuredValue: double read GetPackageInsuredValue write SetPackageInsuredValue;
    property PackageLength: integer read GetPackageLength write SetPackageLength;
    property PackageWidth: integer read GetPackageWidth write SetPackageWidth;
    property PackageNetCharge: double read GetPackageNetCharge write SetPackageNetCharge;
    property PackageType: TibxezshipPackageTypes read GetPackageType write SetPackageType;
    property PackageReference: string read GetPackageReference write SetPackageReference;
    property PackageReturnRecpt: string read GetPackageReturnRecpt write SetPackageReturnRecpt; // "UPS only",
//    property PackageShippingLabel: string read GetPackageShippingLabel write SetPackageShippingLabel; // "read-only",
    property PackageSignatureType: TibxezshipPackageSignatureTypes read GetPackageSignatureType write SetPackageSignatureType; // "FedEx,UPS,USPS only",
//    property UPSDeliveryConfirmation: boolean read GetUPSDeliveryConfirmation write SetUPSDeliveryConfirmation;
    property PackageSpecialService: integer read GetPackageSpecialService write SetPackageSpecialService; // "FedEx, UPS only",
    property PackageTotalDiscount: double read GetPackageTotalDiscount write SetPackageTotalDiscount; // "read-only, FedEx only",
    property PackageTotalSurcharges: double read GetPackageTotalSurcharges write SetPackageTotalSurcharges; // "read-only, FedEx only",
    property PackageTrackingNumber: string read GetPackageTrackingNumber write SetPackageTrackingNumber; // "read-only",
    { Special Service Flags using Calculated Fields }
    property PackageOptNonStandardContainer: boolean read GetPackageOptNonStandardContainer write SetPackageOptNonStandardContainer;
    property PackageOptAdditionalHandling: boolean read GetPackageOptAdditionalHandling write SetPackageOptAdditionalHandling;
    property PackageOptAppointmentDelivery: boolean read GetPackageOptAppointmentDelivery write SetPackageOptAppointmentDelivery;
    property PackageOptDangerousGoods: boolean read GetPackageOptDangerousGoods write SetPackageOptDangerousGoods;
    property PackageOptDryIce: boolean read GetPackageOptDryIce write SetPackageOptDryIce;
    property PackageOptPriorityAlert: boolean read GetPackageOptPriorityAlert write SetPackageOptPriorityAlert;
    property PackageOptCOD: boolean read GetPackageOptCOD write SetPackageOptCOD;
    property PackageOptSignatureOption: boolean read GetPackageOptSignatureOption write SetPackageOptSignatureOption;
    property PackageOptAlcohol: boolean read GetPackageOptAlcohol write SetPackageOptAlcohol;

    property CommodityDescription: string read GetCommodityDescription write SetCommodityDescription;
    property CommodityHarmonizedCode: string read GetCommodityHarmonizedCode write SetCommodityHarmonizedCode;
    property CommodityManufacturer: string read GetCommodityManufacturer write SetCommodityManufacturer;
    property CommodityNumberOfPieces: integer read GetCommodityNumberOfPieces write SetCommodityNumberOfPieces;
    property CommodityQuantity: integer read GetCommodityQuantity write SetCommodityQuantity;
    property CommodityQuantityUnit: string read GetCommodityQuantityUnit write SetCommodityQuantityUnit;
    property CommodityUnitPrice: double read GetCommodityUnitPrice write SetCommodityUnitPrice;
    property CommodityValue: double read GetCommodityValue write SetCommodityValue;
    property CommodityWeight: string read GetCommodityWeight write SetCommodityWeight;
  end;

  TShipmentSaleLine = class(TMSBusObj)
  private
    function GetShipmentId: integer;
    function GetUOMQty: double;
    procedure SetShipmentId(const Value: integer);
    procedure SetUOMQty(const Value: double);
    function GetSaleLineId: integer;
    procedure SetSaleLineId(const Value: integer);
    procedure DoUpdatePakageValues;
    function DefaultWeight: double;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
  published
    property ShipmentId: integer read GetShipmentId write SetShipmentId;
    property SaleLineId: integer read GetSaleLineId write SetSaleLineId;
    property UOMQty: double read GetUOMQty write SetUOMQty;
  end;

  { takes a comma seperated list of Id's and returns newly created table name }
  function PrepareLabelTempTable(ShipmentListIdList, ShipmentIdList: string; TransConnection: TERPConnection = nil): string;

implementation

uses
  sysutils, BusObjSaleBase, SalesConst, AppEnvironment,
  BusObjCountries, PersonNameObj, tcTypes, CommonLib,
  SystemLib, CommonDbLib, Variants, StrUtils, Types, ShipIntegrationUtils,
  BusObjSales, XMLHelperUtils, XMLToBusObj, DbSharedObjectsObj, DateTimeUtils,
  TempTableUtils, ProgressDialog, FlipReverseRotateLibrary, Graphics, GIFImg,
  GdiPlus, Windows
  ,ibxFedExShip
  ,ibxfedexshipintl
  ,ibxUSPSShip, IntegrationPrefsLib;

  { takes a comma seperated list of Id's and returns newly created table name }
function PrepareLabelTempTable(ShipmentListIdList, ShipmentIdList: string; TransConnection: TERPConnection = nil): string;
var
  qry: TERPQuery;
  dlg: TProgressDialog;
  origBitmap,
  newBitmap: Graphics.TBitmap;
  gifImage: TGIFImage;
  stream: TStream;
  FileStream: TFileStream;
  tempDir: string;
  Bitmap: IGPBitmap;
begin
//  result := UniqueTableName('tmp_tblshipmentprint');
//  CreateTemporyTableFromTemplate(CommonDbLib.GetSharedMyDacConnection, 'tmp_tblshipmentprint', result);
  result := CreateUserTemporaryTable(CommonDbLib.GetSharedMyDacConnection,'tmp_tblshipmentprint','','MyISAM',TransConnection);
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('insert into ' + result);
    qry.SQL.Add('(Provider, LabelFormat, ShipmentListId, ShipmentId, ShipmentPackageId, PackageShippingLabel)');
    qry.SQL.Add('(select case tblshipment.Provider when 0 then "FedEx" when 1 then "UPS" when 2 then "USPS" when 3 then "Canada Post" end,');
    qry.SQL.Add('case tblshipment.Provider');
    qry.SQL.Add('when 0 then case IfNull(tblshipment.LabelImageType,0) when 0 then "PDF" when 1 then "PNG" when 2 then "Eltron" when 3 then "Zebra" when 4 then "UniMark" else "None" end');
    qry.SQL.Add('when 1 then case IfNull(tblshipment.LabelImageType,0) when 0 then "GIF" when 1 then "EPL" when 2 then "SPL" when 3 then "ZPL" when 4 then "Star" else "None" end');
    qry.SQL.Add('when 2 then case IfNull(tblshipment.LabelImageType,0) when 0 then "None" when 1 then "TIF" when 2 then "JPG" when 3 then "PDF" when 4 then "GIF" when 5 then "EPL" when 6 then "PNG" when 7 then "ZPL" else "None" end');
    qry.SQL.Add('when 3 then "None"');
    qry.SQL.Add('end,');
    qry.SQL.Add('tblshipment.ShipmentListId,');
    qry.SQL.Add('tblshipment.ShipmentId,');
    qry.SQL.Add('tblshipmentpackage.ShipmentPackageId,');
    qry.SQL.Add('tblshipmentpackage.PackageShippingLabel');
    qry.SQL.Add('from tblshipment, tblshipmentpackage');
    if ShipmentListIdList <> '' then
      qry.SQL.Add('where tblshipment.ShipmentListId in (' + ShipmentListIdList + ')')
    else
      qry.SQL.Add('where tblshipment.ShipmentId in (' + ShipmentIdList + ')');
    qry.SQL.Add('and tblshipment.ShipmentId = tblshipmentpackage.ShipmentId');
    qry.SQL.Add('and tblshipment.Active = "T")');
    qry.Execute;

    { rotate the image }
    qry.SQL.Text := 'select * from ' + result;
    qry.Open;
    origBitmap := Graphics.TBitmap.Create;
    gifImage := TGIFImage.Create;
    dlg := TProgressDialog.Create(nil);
    try
      dlg.Caption := 'Prepairing Lables';
      dlg.Step := 1;
      dlg.MaxValue := qry.RecordCount;
      dlg.Execute;
      while not qry.Eof do begin
        dlg.StepIt;
        if qry.FieldByName('LabelFormat').AsString = 'TIF' then  begin
          { convert to GIF }
          try
            qry.Edit;
            stream := qry.CreateBlobStream(qry.FieldByName('PackageShippingLabel'),bmReadWrite);
            try
              tempDir := GetAppTempDir + '\PackageShippingLabel\';
              ForceDirectories(tempDir);
              SysUtils.DeleteFile(tempDir + 'temp.tif');
              FileStream := TFileStream.Create(tempDir + 'temp.tif',fmCreate);
              FileStream.CopyFrom(stream,0);
              FileStream.Free;

              Bitmap:= TGPBitmap.Create(tempDir + 'temp.tif');
              Bitmap.Save(tempDir + 'temp.GIF',TGPImageFormat.GIF); // Gif);
              Bitmap := nil;

              FileStream := TFileStream.Create(tempDir + 'temp.GIF',fmOpenRead);
              stream.Position := 0;
              stream.CopyFrom(FileStream,0);
              FileStream.Free;

              qry.FieldByName('LabelFormat').AsString := 'GIF';
              qry.Post;
            finally
              stream.Free;
            end;
          finally

          end;
        end
        else if qry.FieldByName('LabelFormat').AsString = 'GIF' then  begin
          qry.Edit;
          stream := qry.CreateBlobStream(qry.FieldByName('PackageShippingLabel'),bmReadWrite);
          try
            gifImage.LoadFromStream(stream);
            origBitmap.Assign(gifImage);
            origBitmap.PixelFormat := pf24bit;
            newBitmap := FlipReverseRotateLibrary.RotateScanline90(270,origBitmap);
            try
              gifImage.Assign(newBitmap);
            finally
              newBitmap.Free;
            end;
            stream.Position := 0;
            gifImage.SaveToStream(stream);
            qry.Post;
          finally
            stream.Free;
          end;
        end;
        qry.Next;
      end;
    finally
      origBitmap.Free;
      gifImage.Free;
      dlg.Free;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;



function FormatWeightString(Weight: string): string;
begin
  result := Trim(Weight);
  if result = '' then result := '0';
  if Pos('.',result) =0 then
    result := result + '.0';
end;


{ TShipmentList }

procedure TShipmentList.AutoAllocateSales;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := Connection.Connection;
    qry.SQL.Add('select (UnitOfMeasureShipped div ' + IntToStr(Shipments.Count) + ') as UOMQty,');
    qry.SQL.Add('SaleLineId');
    qry.SQL.Add('from tblsaleslines');
    qry.SQL.Add('where SaleId = ' + IntToStr(SaleId));
    qry.Open;
    Shipments.First;
    while not Shipments.EOF do begin
      qry.First;
      while not qry.Eof do begin
        Shipments.SalesLines.New;
        Shipments.SalesLines.SaleLineId := qry.FieldByName('SaleLineId').AsInteger;
        Shipments.SalesLines.UOMQty := qry.FieldByName('UOMQty').AsFloat;
        Shipments.SalesLines.PostDb;
        qry.Next;
      end;
      Shipments.PostDb;
      Shipments.Next;
    end;
  finally
    qry.Free;
  end;
end;

function TShipmentList.Copy(SrcSale, DestSale: TMSBusObj): integer;
var
  NewShipList: TShipmentList;
begin
  NewShipList := TShipmentList.Create(nil);
  try
    NewShipList.Connection := self.Connection;
    NewShipList.Load(0);
    NewShipList.SilentMode := true;
    CopyObjRec('SaleId', TSalesBase(DestSale).SaleId, NewShipList);
    Shipments.First;
    while not Shipments.EOF do begin
      NewShipList.Shipments.New;
      NewShipList.Shipments.DoFieldChange := false;
      Shipments.CopyObjRec('ShipmentListId', NewShipList.ID, NewShipList.Shipments);
      NewShipList.Shipments.ServiceType := Shipments.ServiceType;
      NewShipList.Shipments.PostDb;

      Shipments.Packages.First;
      while not Shipments.Packages.EOF do begin
        NewShipList.Shipments.Packages.New;
        NewShipList.Shipments.Packages.DoFieldChange := false;
        Shipments.Packages.CopyObjRec('ShipmentId', NewShipList.Shipments.ID, NewShipList.Shipments.Packages);
        try
          NewShipList.Shipments.Packages.PostDb;
        Except
          // Pakage posting is aborted when its empty
        end;
        Shipments.Packages.Next;
      end;

      Shipments.SalesLines;
      while not Shipments.SalesLines.EOF do begin
        NewShipList.Shipments.SalesLines.New;
        NewShipList.Shipments.SalesLines.DoFieldChange := false;
        Shipments.SalesLines.CopyObjRec('ShipmentId', NewShipList.Shipments.ID, NewShipList.Shipments.SalesLines);
        { update sale line id's }
        if TSalesBase(SrcSale).Lines.Dataset.Locate('SaleLineId', Shipments.SalesLines.SaleLineId, []) then begin
          if TSalesBase(DestSale).Lines.Dataset.Locate('ProductID;SeqNo',VarArrayOf([TSalesBase(SrcSale).Lines.ProductID, TSalesBase(SrcSale).Lines.SeqNo]),[]) then begin
            NewShipList.Shipments.SalesLines.SaleLineId := TSalesBase(DestSale).Lines.ID;
          end
          else begin
            { ignore }
          end;
        end
        else begin
          { ignore }
        end;

        NewShipList.Shipments.SalesLines.PostDb;
        Shipments.SalesLines.Next;
      end;

      Shipments.Next;
    end;
    NewShipList.SaleRefNo := TSalesBase(DestSale).DocNumber;
    if (DestSale is TInvoice) then
      NewShipList.SaleType := 'Invoice'
    else if (DestSale is TSalesOrder) then
      NewShipList.SaleType := 'Sales Order';
    NewShipList.PostDb;
    NewShipList.UpdatePackageReferences(TSalesBase(SrcSale).CustPONumber);
  finally
    result := NewShipList.ID;
    NewShipList.Free;
  end;
end;

constructor TShipmentList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fInvalidShipmentId := 0;
  fBusObjectTypeDescription:= 'Shipment List';
  fSQL := 'SELECT * FROM tblShipmentList';
end;

destructor TShipmentList.Destroy;
begin

  inherited;
end;

function TShipmentList.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  DateCreated := now;
  EmployeeName := AppEnv.Employee.EmployeeName;
end;

procedure TShipmentList.DoFieldOnChange(Sender: TField);
var
  qry: TERPQuery;
  PONum: string;
begin
  inherited;
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if (Sysutils.SameText(Sender.FieldName, 'SaleId')) then begin
    case TSalesBase.GetSaleType(SaleId,Connection.Connection) of
      stNone: SaleType := 'None';
      stInvoice: SaleType := 'Invoice';
      stCashsale: SaleType := 'Cash Sale';
      stSalesOrder: SaleType := 'Sales Order';
      stPOS: SaleType := 'POS';
      stPOSLayby: SaleType := 'POS Layby';
      stPOSLaybyPayment: SaleType := 'POS Layby Payment';
      stQuote: SaleType := 'Quote';
      stPOSCashSale: SaleType := 'POS Cash Sale';
      stCustomerReturn: SaleType := 'Customer Return';
    end;
    qry:= TempQry;
    qry.SQL.Text := 'select InvoiceDocNumber, PONumber from tblSales where SaleId = ' + IntToStr(SaleId);
    qry.Open;
    self.SaleRefNo := qry.FieldByName('InvoiceDocNumber').AsString;
    PONum := qry.FieldByName('PONumber').AsString;
    qry.Close;
    UpdatePackageReferences(PONum);
  end;
end;

function TShipmentList.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

class function TShipmentList.GetBusObjectTablename: string;
begin
  result := 'tblShipmentList';
end;

function TShipmentList.GetDateCreated: TDateTime;
begin
  result := GetDateTimeField('DateCreated');
end;

function TShipmentList.GetEmployeeName: string;
begin
  result := GetStringField('EmployeeName');
end;

class function TShipmentList.GetIDField: string;
begin
  result := 'ShipmentListId';
end;

function TShipmentList.GetSaleId: integer;
begin
  result := GetIntegerField('SaleId');
end;

function TShipmentList.GetSaleRefNo: string;
begin
  result := GetStringField('SaleRefNo');
end;

function TShipmentList.GetSaleType: string;
begin
  result := GetStringField('SaleType');
end;

function TShipmentList.GetShipAddressIdList: string;
begin
  result := '';
  Shipments.Dataset.DisableControls;
  try
    Shipments.First;
    while not Shipments.EOF do begin
      if Shipments.Active and (not Shipments.Canceled) then  begin
        if result <> '' then result := result + ',';
        result := result + IntToStr(Shipments.ShipAddressId);
      end;
      Shipments.Next;
    end;
  finally
    Shipments.Dataset.EnableControls;
  end;
end;

function TShipmentList.GetShipments: TShipment;
begin
  result := TShipment(self.getContainerComponent(TShipment,'ShipmentListId = ' + IntToStr(ID) + ' and Active = "T"'));
end;

function TShipmentList.GetStatus: string;
begin
  result := GetStringField('Status');
end;

procedure TShipmentList.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  XMLToBusObj.XMLToObj(node, self);
//  SetPropertyFromNode(Node, 'SaleId');
//  SetPropertyFromNode(Node, 'SaleType');
//  SetPropertyFromNode(Node, 'SaleRefNo');
//  SetDateTimePropertyFromNode(Node, 'DateCreated');
//  SetPropertyFromNode(Node, 'EmployeeName');
//  SetPropertyFromNode(Node, 'Status');
//  SetBooleanPropertyFromNode(Node, 'Active');
end;

function TShipmentList.NonCanceledCount: integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.Add('SELECT COUNT(*) as NonCanceledCount');
    qry.SQL.Add('from tblshipment where ShipmentListID = ' + IntToStr(ID));
    qry.SQL.Add('and Active = "T"');
    qry.SQL.Add('and Canceled = "F"');
    qry.Open;
    result := qry.FieldByName('NonCanceledCount').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TShipmentList.Save: Boolean;
begin
  resultStatus.Clear;
  fInvalidShipmentId := 0;
  result := inherited;
  if not result then exit;
  result := ValidateData;
  if not result then exit;
  Shipments.Dataset.DisableControls;
  try
    Shipments.First;
    while not Shipments.EOF do begin
      if not Shipments.Save then begin
        result := false;
        fInvalidShipmentId := Shipments.ID;
        exit;
      end;
      Shipments.Next;
    end;
  finally
    Shipments.Dataset.EnableControls;
  end;

end;

procedure TShipmentList.SaveToXMLNode(const node: IXMLNode);
var
  shipmentsNode, shipmentNode: IXMLNode;
begin
  inherited;
  XMLToBusObj.ObjToXML(self, node);

  shipmentsNode := Node.AddChild('Shipments');
  if Shipments.Count = 0 then exit;

  Shipments.Dataset.DisableControls;
  try
    Shipments.First;
    while not Shipments.EOF do begin
      shipmentNode := shipmentsNode.AddChild('Shipment');
      Shipments.SaveToXMLNode(shipmentNode);
      Shipments.Next;
    end;
  finally
    Shipments.Dataset.EnableControls;
  end;

end;

procedure TShipmentList.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TShipmentList.SetDateCreated(const Value: TDateTime);
begin
  SetDateTimeField('DateCreated', Value);
end;

procedure TShipmentList.SetEmployeeName(const Value: string);
begin
  SetStringField('EmployeeName', Value);
end;

procedure TShipmentList.SetSaleId(const Value: integer);
begin
  SetIntegerField('SaleId', Value);
end;

procedure TShipmentList.SetSaleRefNo(const Value: string);
begin
  SetStringField('SaleRefNo', Value);
end;

procedure TShipmentList.SetSaleType(const Value: string);
begin
  SetStringField('SaleType', Value);
end;

procedure TShipmentList.SetStatus(const Value: string);
begin
  SetStringField('Status', Value);
end;

function TShipmentList.ShipAll(ErrorLIst: TStringList): boolean;
begin
  result := true;
  Shipments.Dataset.DisableControls;
  try
    Shipments.First;
    while not Shipments.EOF do begin
      if not Shipments.Processed then begin
        if not Shipments.Ship then begin
          result := false;
          if ErrorList.Count > 0 then
            ErrorList.Add('');
          ErrorList.Add(Shipments.RecipientAddressAsSingleLine);
          ErrorList.Add(Shipments.ResultStatus.Messages);
        end;
      end;
      Shipments.Next;
    end;
  finally
    Shipments.Dataset.EnableControls;
  end;
  self.UpdateStatus(Self);
end;

procedure TShipmentList.ShipmentIdListForLabelType(
  aLabelType: TibxupsshipLabelImageTypes; IdList: TIntegerList);
begin
  Shipments.Dataset.DisableControls;
  try
    Shipments.First;
    while not Shipments.EOF do begin
      if Ord(aLabelType) = Shipments.LabelImageType then
        IdList.Add(Shipments.ID);
      Shipments.Next;
    end;
  finally
    Shipments.Dataset.EnableControls;
  end;
end;

class function TShipmentList.ShipmentListSaleType(ShipmentListId: integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select SaleType from tblshipmentlist where ShipmentListId = ' + IntToStr(ShipmentListId);
    qry.Open;
    result := qry.FieldByName('SaleType').AsString;
  finally
    qry.Free;
  end;
end;

procedure TShipmentList.UpdatePackageReferences(PONumber: string);
begin
  Shipments.Dataset.DisableControls;
  try
    Shipments.First;
    while not Shipments.EOF do begin
      if not Shipments.Processed then begin
        Shipments.Packages.Dataset.DisableControls;
        try
          Shipments.Packages.First;
          while not Shipments.Packages.EOF do begin
            Shipments.Packages.RemovePackageReferenceByName('IN');
            Shipments.Packages.RemovePackageReferenceByName('TN');
            Shipments.Packages.RemovePackageReferenceByName('PO');
            case Shipments.ShipperType of
              spNone:;
              spFedEx:
                begin
                  Shipments.Packages.PackageReferenceByName['IN'] := self.SaleRefNo; { invoice number }
                  if PONumber <> '' then
                    Shipments.Packages.PackageReferenceByName['PO'] := PONumber;
                end;
              spUPS,
              spUSPS,
              spCanadaPost:
                begin
                  Shipments.Packages.PackageReferenceByName['TN'] := self.SaleRefNo;   { transaction refrence number }
                  if PONumber <> '' then
                    Shipments.Packages.PackageReferenceByName['PO'] := PONumber;
                end;
              spTNT:;
            end;
            Shipments.Packages.Next;
          end;

        finally
          Shipments.Packages.Dataset.EnableControls;
        end;
      end;
      Shipments.Next;
    end;
  finally
    Shipments.Dataset.EnableControls;
  end;
end;

class procedure TShipmentList.UpdateStatus(ShipmentListId: integer;
  Connection: TCustomMyConnection);
var
  qry: TERPQuery;
  Status: string;
begin
  status := ShipmentListStatus_NotProcessed;
  qry := TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Count(*) as TotalShipments,');
    qry.SQL.Add('(select Count(*) from tblshipment where tblshipment.Active = "T" and Processed = "T" and tblshipment.ShipmentListId = '+IntToStr(ShipmentListId)+') as ProcessedShipments');
    qry.SQL.Add('from tblshipment');
    qry.SQL.Add('where tblshipment.Active = "T"');
    qry.SQL.Add('and tblshipment.ShipmentListId = ' + IntToStr(ShipmentListId));
    qry.Open;
    if qry.FieldByName('TotalShipments').AsInteger > 0 then begin
      if qry.FieldByName('ProcessedShipments').AsInteger = qry.FieldByName('TotalShipments').AsInteger then
        status := ShipmentListStatus_Processed
      else if qry.FieldByName('ProcessedShipments').AsInteger > 0 then
        status := ShipmentListStatus_PartiallyProcessed;
    end;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('update tblshipmentlist set Status = ' + QuotedStr(status));
    qry.SQL.Add('where ShipmentListId = ' + IntToStr(ShipmentListId));
    qry.Execute;
  finally
    qry.Free;
  end;
end;

class procedure TShipmentList.UpdateStatus(ShipmentList: TShipmentList);
var
  ProcessedCount,
  UnprocessedCount: integer;
begin
  ProcessedCount := 0;
  UnprocessedCount := 0;
  ShipmentList.Shipments.Dataset.DisableControls;
  try
    ShipmentList.Shipments.Dataset.First;
    while not ShipmentList.Shipments.EOF do begin
      if ShipmentList.Shipments.Processed then begin
        Inc(ProcessedCount);
      end
      else begin
        Inc(UnprocessedCount);
      end;
      ShipmentList.Shipments.Next;
    end;
    if ProcessedCount = 0 then
      ShipmentList.Status := ShipmentListStatus_NotProcessed
    else if UnprocessedCount = 0 then
      ShipmentList.Status := ShipmentListStatus_Processed
    else
      ShipmentList.Status := ShipmentListStatus_PartiallyProcessed;
  finally
    ShipmentList.Shipments.Dataset.EnableControls;
  end;
end;

function TShipmentList.ValidateData: Boolean;
begin
  result := inherited;
end;

{ TShipment }

procedure TShipment.AddTrackingNumberToSale;
var
  qry: TERPQuery;
  sl: TStringList;
  I: integer;
  TrackPos: integer;
  s: string;
  TrackNoUpdated: boolean;
begin
  TrackNoUpdated := false;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := self.Connection.Connection;
    qry.SQL.Add('select tblsales.SaleID, tblsales.Comments from tblsales');
    qry.SQL.Add('inner join tblshipmentlist on tblshipmentlist.SaleID = tblSales.SaleId');
    qry.SQL.Add('where ShipmentListId = ' + IntToStr(self.ShipmentListId));
    qry.Open;
    if qry.IsEmpty then exit;
    sl := TStringList.Create;
    s := '';
    try
      sl.Text := qry.FieldByName('Comments').AsString;
      TrackPos := -1;
      for I := 0 to sl.Count -1 do begin
        if Pos('tracking number', Trim(Lowercase(sl[I]))) > -1 then begin
          TrackPos := I;
          s := sl[I];
          s := Trim(ReplaceStr(Lowercase(s), 'tracking number', ''));
          break;
        end;
      end;
      if PackageIDCode <> '' then begin
        if Pos(PackageIDCode, s) = 0 then begin
          TrackNoUpdated := true;
          if s <> '' then s := s + ',';
          s := s + PackageIDCode;
        end;
      end
      else if MasterTrackingNumber <> '' then begin
        if Pos(MasterTrackingNumber, s) = 0 then begin
          TrackNoUpdated := true;
          if s <> '' then s := s + ',';
          s := s + MasterTrackingNumber;
        end;
      end;
      if Canceled then begin
        s := s + ' Canceled';
        TrackNoUpdated := true;
      end;
      if TrackNoUpdated then begin
        if TrackPos >= 0 then
          sl[TrackPos] := 'Tracking Number ' + ShipProviderList[Ord(Provider)].Name + ' ' + s
        else
          sl.Add('Tracking Number ' + ShipProviderList[Ord(Provider)].Name + ' ' + s);
        qry.Edit;
        qry.FieldByName('Comments').AsString := sl.Text;
        qry.Post;
      end;
    finally
      sl.Free;
    end;
  finally
    qry.Free;
  end;
end;

function TShipment.CancelShipment: boolean;
begin
  PostDb;
  result := false;
  ResultStatus.Clear;
  if not self.Processed then begin
    AddResult(false, rssWarning, 0, 'Shipment not processed yet so can not be canceled.');
    exit;
  end;

  case Provider of
    pFedEx:
      begin
        if self.MasterTrackingNumber = '' then begin
          AddResult(false, rssWarning, 0, 'Master Tracking Number is missing.');
          exit;
        end;
      end;
    pUPS:
      begin
        if self.MasterTrackingNumber = '' then begin
          AddResult(false, rssWarning, 0, 'Master Tracking Number is missing.');
          exit;
        end;
      end;
    pUSPS:
      begin
        AddResult(false, rssWarning, 0, 'Shipment cancelation not supported for USPS');
        exit;
      end;
  end;

  result := DoCancelShipment;
  if result then
    Canceled := true;

  AddTrackingNumberToSale;
  PostDb;
end;

constructor TShipment.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Shipment';
  fSQL := 'SELECT * FROM tblShipment';
end;

destructor TShipment.Destroy;
begin

  inherited;
end;

function TShipment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;

  function FindCountryCode: string;
  begin
    result := '';
    if Trim(AppEnv.CompanyInfo.Country) <> '' then begin
      if Length(Trim(AppEnv.CompanyInfo.Country)) = 2 then begin
        result := Trim(AppEnv.CompanyInfo.Country);
        exit;
      end;
      { get country code from country name }
      result := TCountries.ShortCodeForCountry(Trim(AppEnv.CompanyInfo.Country));
    end;
    if result = '' then begin
      if Length(AppEnv.RegionalOptions.RegionAbbreviation) = 2 then
        result := AppEnv.RegionalOptions.RegionAbbreviation
      else
        result := TCountries.ShortCodeForCode(AppEnv.RegionalOptions.RegionAbbreviation);
    end;
  end;

begin
  result := inherited;
  if Assigned(Owner) and (Owner is TShipmentList) then begin
    ShipmentListId := TShipmentList(Owner).ID;
    SetShippingDefaults;
  end;

  { get default Sender details }
  SenderFirstName := AppEnv.CompanyInfo.Firstname;
  SenderInitial := '';
  SenderLastName := AppEnv.CompanyInfo.LastName;
  SenderCompany := AppEnv.CompanyInfo.CompanyName;
  SenderAddress1 := AppEnv.CompanyInfo.Address;
  SenderAddress2 := AppEnv.CompanyInfo.Address2;
  if AppEnv.CompanyInfo.Address3 <> '' then begin
    if SenderAddress2 <> '' then SenderAddress2 := SenderAddress2 + ' ';
    SenderAddress2 := SenderAddress2 + AppEnv.CompanyInfo.Address3;
  end;
  SenderCity := AppEnv.CompanyInfo.City;
  SenderState := AppEnv.CompanyInfo.State;
  SenderZipCode := AppEnv.CompanyInfo.Postcode;
  SenderCountryCode := FindCountryCode;
  SenderPhone := AppEnv.CompanyInfo.PhoneNumber;
  SenderFax := AppEnv.CompanyInfo.FaxNumber;
  SenderEmail := AppEnv.CompanyInfo.Email;

//  PayorType := ibxezship.ptSender;
end;

function TShipment.DoCancelShipment: boolean;
var
  upsShip: TibxUPSShip;
  FedExShip: TibxFedExShip;
  FedExShipIntl: TibxFedExShipIntl;
  uspsShip: TibxUSPSShip;
//  TotalNetCharge: double;

  x: integer;
  Err: TShipperError;
  msg: string;
  tempLabelFile: string;
  USPSPICNumber: string;
  doc: IXMLDocument;

  procedure CheckForErrors(XmlStr: string);
  var
    sl: TStringList;
    I: integer;
    env, body, fault, faultString, detail: IXMLNode;
  begin
    sl := TStringList.Create;
    doc := TXMLDocument.Create(nil);
    try
      sl.Text := XmlStr;
      sl.Insert(0,'<?xml version="1.0"?><data>');
      sl.Add('</data>');
      doc.LoadFromXML(sl.Text);
      doc.Active := true;
      for I := 0 to doc.DocumentElement.ChildNodes.Count -1 do begin
        env := doc.DocumentElement.ChildNodes[I];
        if SameText(env.NodeName, 'SOAP-ENV:Envelope') then begin
          body := env.ChildNodes.FindNode('SOAP-ENV:Body');
          if Assigned(body) then begin
            fault := body.ChildNodes.FindNode('SOAP-ENV:Fault');
            if Assigned(fault) then begin
              faultString := XMLHelperUtils.GetNode(fault,'faultstring'); //   fault.ChildNodes.FindNode('faultstring');
              if Assigned(faultString) and SameText(faultString.NodeValue, 'Fault') then begin
                detail := XMLHelperUtils.GetNode(fault,'detail');
                if Assigned(detail) then begin
                  raise Exception.Create(detail.ChildValues['desc']);
                end;
              end;
            end;
          end;
        end;
      end;

    finally
      doc := nil;
      sl.Free;
    end;
  end;

begin
  result := true;
  ProcessedComment := '';

  if Provider = pFedEx then begin
    if IsFedExInternational then begin
      { Intenational }
      FedExShipIntl := TibxFedExShipIntl.Create(nil);
      try
        try

          FedExShipIntl.FedExDeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
          FedExShipIntl.FedExAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
          FedExShipIntl.FedExMeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
          FedExShipIntl.FedExPassword := AppEnv.CompanyPrefs.FedExConfig.Password;
          FedExShipIntl.FedExServer := AppEnv.CompanyPrefs.FedExConfig.Server;

          { use TLS 1.2 }
          FedExShipIntl.Config('SSLEnabledProtocols=3072');

          FedExShipIntl.CancelShipment(self.MasterTrackingNumber, 0);

          CheckForErrors(FedExShipIntl.Config('RawResponse'));

        except
          on e: exception do begin
            result := false;
            Err := TShipperError.Create(e);
            try
              msg := 'Error canceling shipment';
              if Err.ErrorDesc <> '' then
                msg := msg + ' with message: ' +  Err.ErrorDesc;
            finally
              Err.Free;
            end;
            AddResult(false,rssWarning,0,msg);
            ProcessedComment := msg;
            exit;
          end;
        end;
      finally
        FedExShipIntl.Free;
      end;
      exit;
    end;


    { else Domestic }
    FedExShip := TibxFedExShip.Create(nil);
    try
      try

        FedExShip.FedExDeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
        FedExShip.FedExAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
        FedExShip.FedExMeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
        FedExShip.FedExPassword := AppEnv.CompanyPrefs.FedExConfig.Password;
        FedExShip.FedExServer := AppEnv.CompanyPrefs.FedExConfig.Server;


        { use TLS 1.2 }
        FedExShip.Config('SSLEnabledProtocols=3072');

        FedExShip.CancelShipment(Self.MasterTrackingNumber, 0);

      except
        on e: exception do begin
          result := false;
          Err := TShipperError.Create(e);
          try
            msg := 'Error canceling shipment';
            if Err.ErrorDesc <> '' then
              msg := msg + ' with message: ' +  Err.ErrorDesc;
          finally
            Err.Free;
          end;
          AddResult(false,rssWarning,0,msg);
          ProcessedComment := msg;
          exit;
        end;
      end;
    finally
      FedExShip.Free;
    end;
    exit;
  end;
  if Provider = pUPS then begin
    upsShip := TibxUPSShip.Create(nil);
    try
      try
        { use TLS 1.2 }
        upsShip.Config('SSLEnabledProtocols=3072');

        upsShip.UPSAccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
        upsShip.UPSAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
        upsShip.UPSUserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
        upsShip.UPSPassword := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
        if AppEnv.CompanyPrefs.UPSConfig.TestMode then
          upsShip.UPSServer := 'https://wwwcie.ups.com/ups.app/xml/Void'
        else
          upsShip.UPSServer := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/Void';

        upsShip.CancelShipment(Self.MasterTrackingNumber);

        { get returned data }
        self.ProcessedComment := upsShip.ShipmentVoidStatus; { somthing returned here if cancel successful }

      except
        on e: exception do begin
          result := false;
          Err := TShipperError.Create(e);
          try
            msg := 'Error canceling shipment';
            if Err.ErrorDesc <> '' then
              msg := msg + ' with message: ' +  Err.ErrorDesc;
          finally
            Err.Free;
          end;
          AddResult(false,rssWarning,0,msg);
          ProcessedComment := msg;
          exit;
        end;
      end;

    finally
      upsShip.Free;
    end;
    exit;
  end;

  if Provider = pUSPS then begin
    { not supported }
//    uspsShip := TibxUSPSShip.Create(nil);
//    try
//      try
//
//        uspsShip.PostageProvider := TibxuspsshipPostageProviders(PostageProvider);
//
//        uspsShip.USPSUserId := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
//        uspsShip.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
//        uspsShip.USPSServer := AppEnv.CompanyPrefs.USPSConfig.ShipServer;
//
//        if uspsShip.PostageProvider = ppEndicia then begin
//          uspsShip.USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.EndiciaAccountNumber;
//          uspsShip.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.EndiciaPassword;
//          uspsShip.TransactionId := IntToStr(self.SaleId);
//          uspsShip.Config('EndiciaTestMode=' + IntToStr(AppEnv.CompanyPrefs.USPSConfig.EndiciaTestMode));
//        end
//        else if uspsShip.PostageProvider = ppStamps then begin
//          uspsShip.USPSUserId := AppEnv.CompanyPrefs.USPSConfig.StampsUserID;
//          uspsShip.USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.StampsAccountNumber;
//          uspsShip.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.StampsPassword;
//          uspsShip.USPSServer := AppEnv.CompanyPrefs.USPSConfig.StampsServer;
//          uspsShip.Config('StampsTestMode=' + IntToStr(AppEnv.CompanyPrefs.USPSConfig.StampsTestMode));
//        end;
//
//        if CommonLib.DevMode  then
//          uspsShip.Config('Certify=true'); // test mode
//
//        { ---- Header ---- }
//        uspsShip.ServiceType := TibxuspsshipServiceTypes(ServiceType);
//        uspsShip.LabelImageType := TibxuspsshipLabelImageTypes(LabelImageType);
//
//        if Trunc(ShipDate) > 0 then
//          uspsShip.ShipDate := FormatDateTime('mm/dd/yyyy',ShipDate);
//
//        { ---- Sender ---- }
//        uspsShip.SenderFirstName := SenderFirstName;
//        uspsShip.SenderMiddleInitial := SenderInitial;
//        uspsShip.SenderLastName := SenderLastName;
//        uspsShip.SenderCompany := SenderCompany;
//        uspsShip.SenderAddress1 := SenderAddress1;
//        uspsShip.SenderAddress2 := SenderAddress2;
//        uspsShip.SenderCity := SenderCity;
//        uspsShip.SenderState := SenderState;
//        uspsShip.SenderZipCode := SenderZipCode;
//        uspsShip.SenderEmail := SenderEmail;
//        uspsShip.SenderPhone := SenderPhone;
//        uspsShip.SenderFax := SenderFax;
//
//
//        uspsShip.CancelPickup();
//
//        { get returned data }
//
//
//      except
//        on e: exception do begin
//          result := false;
//          Err := TShipperError.Create(e);
//          try
//            msg := 'Error canceling pickup';
//            if Err.ErrorDesc <> '' then
//              msg := msg + ' with message: ' +  Err.ErrorDesc;
//          finally
//            Err.Free;
//          end;
//          AddResult(false,rssWarning,0,msg);
//          ProcessedComment := msg;
//          exit;
//        end;
//      end;
//
//    finally
//      uspsShip.Free;
//    end;
//    exit;
  end;
end;

procedure TShipment.DoFieldOnChange(Sender: TField);
var
  qry: TERPQuery;
begin
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if (Sysutils.SameText(Sender.FieldName, 'Active')) then begin
    if not Active then begin
      SalesLines.DeleteAll;
      Packages.DeleteAll
    end;
  end
  else if (Sysutils.SameText(Sender.FieldName, 'Provider')) then begin
    SetDefaultsForProvider;
  end
  else if (Sysutils.SameText(Sender.FieldName, 'ShipAddressId')) then begin
    { populate recipient address }
    PopulateRecipientAddress;
  end
  else if (Sysutils.SameText(Sender.FieldName, 'ShippingListId')) then begin
    SetShippingDefaults;
  end;
end;

(*
  For info on UPS Mail Innovation see:
  http://www.nsoftware.com/kb/xml/04101401.rst
*)

function TShipment.DoGetShipmentLables: boolean;
var
  upsShip: TibxUPSShip;
  FedExShip: TibxFedExShip;
  FedExShipIntl: TibxFedExShipIntl;
  uspsShip: TibxUSPSShip;
//  TotalNetCharge: double;

  x: integer;
  Err: TShipperError;
  msg: string;
  tempLabelFile: string;
  USPSPICNumber: string;
  doc: IXMLDocument;

  procedure CheckForErrors(XmlStr: string);
  var
    sl: TStringList;
    I: integer;
    env, body, fault, faultString, detail: IXMLNode;
  begin
    sl := TStringList.Create;
    doc := TXMLDocument.Create(nil);
    try
      sl.Text := XmlStr;
      sl.Insert(0,'<?xml version="1.0"?><data>');
      sl.Add('</data>');
      doc.LoadFromXML(sl.Text);
      doc.Active := true;
      for I := 0 to doc.DocumentElement.ChildNodes.Count -1 do begin
        env := doc.DocumentElement.ChildNodes[I];
        if SameText(env.NodeName, 'SOAP-ENV:Envelope') then begin
          body := env.ChildNodes.FindNode('SOAP-ENV:Body');
          if Assigned(body) then begin
            fault := body.ChildNodes.FindNode('SOAP-ENV:Fault');
            if Assigned(fault) then begin
              faultString := XMLHelperUtils.GetNode(fault,'faultstring'); //   fault.ChildNodes.FindNode('faultstring');
              if Assigned(faultString) and SameText(faultString.NodeValue, 'Fault') then begin
                detail := XMLHelperUtils.GetNode(fault,'detail');
                if Assigned(detail) then begin
                  raise Exception.Create(detail.ChildValues['desc']);
                end;
              end;
            end;
          end;
        end;
      end;
    finally
      doc := nil;
      sl.Free;
    end;
  end;
  Function inttoUSPSPostageProvider(Const Value:Integer): TibxuspsshipPostageProviders;
  begin
         if Value = 0 then result := ppNone
    else if Value = 1 then result := ppEndicia
    else if Value = 2 then result := ppStamps
    else result := ppNone;
  end;
  function CanValidateAddress: boolean;
  var msg: string;
  begin
    { if user does not have a usps account but has STAMPS or Endicia don't try and validate address using USPS }
    result := true;
    if (self.Provider = pUSPS) and (self.PostageProvider >= 0) then begin
      if not AppEnv.CompanyPrefs.USPSConfig.Validate(msg , inttoUSPSPostageProvider(self.PostageProvider)) then
        result := false;
    end;
  end;

begin
  result := true;
  ProcessedComment := '';
  { validate address first if need be }
  if (not self.RecipientAddressValid) and CanValidateAddress then begin
    if not ShipIntegrationUtils.ValidateAddress(msg,RecipientAddress1,RecipientAddress2,'',
      RecipientCity,RecipientState,RecipientZipCode,RecipientCountryCode,nil,ShipperType) then begin
      result := false;
      ProcessedComment := 'Recipient address validation failed. ' + msg;
      AddResult(false,rssWarning,0,'Recipient address validation failed.' +#13#10 +#13#10 + msg);
      exit;
    end;
  end;

  if Provider = pFedEx then begin
    if IsFedExInternational then begin
      { Intenational }
      FedExShipIntl := TibxFedExShipIntl.Create(nil);
      try
        try
//          FedExShipIntl.OnError := DoOnGetShipmentLabelsError;
          if DocumentsOnly then
            FedExShipIntl.Config('Documents=True')
          else
            FedExShipIntl.Config('Documents=False');

          FedExShipIntl.FedExDeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
          FedExShipIntl.FedExAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
          FedExShipIntl.FedExMeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
          FedExShipIntl.FedExPassword := AppEnv.CompanyPrefs.FedExConfig.Password;
          FedExShipIntl.FedExServer := AppEnv.CompanyPrefs.FedExConfig.Server;

          if AppEnv.RegionalOptions.RegionType = rUSA then begin
            FedExShipIntl.Config('WeightUnit=LB');
            FedExShipIntl.Config('SizeUnit=IN');
          end
          else begin
            FedExShipIntl.Config('WeightUnit=KG');
            FedExShipIntl.Config('SizeUnit=CM');
          end;

          FedExShipIntl.Config('BookingNumber=' + BookingNumber);

          { ---- Header ---- }
          //FedExShip.TotalWeight := '1';
          //FedExShip.InsuredValue := '0.00';
          FedExShipIntl.ShipmentSpecialServices := ShipmentSpecialServices;
          FedExShipIntl.ServiceType := TibxfedexshipintlServiceTypes(ServiceType);
          FedExShipIntl.DropoffType := TibxfedexshipintlDropoffTypes(DropoffType);
          FedExShipIntl.LabelImageType := TibxfedexshipintlLabelImageTypes(LabelImageType);
          FedExShipIntl.PayorType := TibxfedexshipintlPayorTypes(PayorType);
          if PayorAccountNumber <> '' then begin
            FedExShipIntl.PayorAccountNumber := PayorAccountNumber;
            FedExShipIntl.PayorCountryCode := PayorZipCode;
          end
          else
            FedExShipIntl.PayorAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;

          ShipDate := now;

          FedExShipIntl.ShipDate := FormatDateTime('yyyy-mm-dd',ShipDate);

          { ---- Sender ---- }
          FedExShipIntl.SenderFirstName := SenderFirstName;
          FedExShipIntl.SenderMiddleInitial := SenderInitial;
          FedExShipIntl.SenderLastName := SenderLastName;
          FedExShipIntl.SenderCompany := SenderCompany;
          FedExShipIntl.SenderAddress1 := SenderAddress1;
          FedExShipIntl.SenderAddress2 := SenderAddress2;
          FedExShipIntl.SenderCity := SenderCity;
          FedExShipIntl.SenderState := SenderState;
          FedExShipIntl.SenderZipCode := SenderZipCode;
          FedExShipIntl.SenderCountryCode := TCountries.ShortCodeForCountry(SenderCountryCode);
          FedExShipIntl.SenderEmail := SenderEmail;
          FedExShipIntl.SenderPhone := SenderPhone;
          FedExShipIntl.SenderFax := SenderFax;

          { ---- Recipient ---- }
          FedExShipIntl.RecipientFirstName := RecipientFirstName;
          FedExShipIntl.RecipientMiddleInitial := RecipientInitial;
          FedExShipIntl.RecipientLastName := RecipientLastName;
          FedExShipIntl.RecipientCompany := RecipientCompany;
          FedExShipIntl.RecipientAddress1 := RecipientAddress1;
          FedExShipIntl.RecipientAddress2 := RecipientAddress2;
          FedExShipIntl.RecipientCity := RecipientCity;
          FedExShipIntl.RecipientState := RecipientState;
          FedExShipIntl.RecipientZipCode := RecipientZipCode;
          FedExShipIntl.RecipientCountryCode := TCountries.ShortCodeForCountry(RecipientCountryCode);
          FedExShipIntl.RecipientEmail := RecipientEmail;
          FedExShipIntl.RecipientPhone := RecipientPhone;
          FedExShipIntl.RecipientFax := RecipientFax;

          { ---- Packages ---- }
          tempLabelFile := SystemLib.GetAppTempDir + '\FedEx_Ship_Label_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz_',now);
          FedExShipIntl.PackageCount := Packages.Count;
          Packages.Dataset.DisableControls;
          try
            Packages.First;
            FedExShipIntl.PackageCount := Packages.Count;
            FedExShipIntl.CommodityCount := Packages.Count;
            while not Packages.EOF do begin
              x := Packages.Dataset.RecNo -1;
              FedExShipIntl.PackageCODAmount[x] := FormatFloat('#0.00', Packages.PackageCODAmount);
              FedExShipIntl.PackageCODType[x] := TibxfedexshipintlPackageCODTypes(Packages.PackageCODType);
              FedExShipIntl.PackageCODFile[X] := SystemLib.GetAppTempDir + '\FedEx_COD_Label_' + IntToStr(x) + '.' + FedExImageTypeToExtStr(LabelImageType);
              FedExShipIntl.PackageDangerousGoodsAccessible[x] := Packages.PackageDangerousGoodsAccessible;
             { Including PackageDescription in the request is producing an error so leave out for now }
              //FedExShip.PackageDescription[x] := Packages.PackageDescription; // ####################
              FedExShipIntl.PackageHeight[x] := Packages.PackageHeight;
              FedExShipIntl.PackageInsuredValue[x] :=  FormatFloat('#0.00',Packages.PackageInsuredValue);
              FedExShipIntl.PackageLength[x] := Packages.PackageLength;
              FedExShipIntl.PackageReference[x] := Packages.PackageReference;
              FedExShipIntl.PackageShippingLabelFile[x] := tempLabelFile + IntToStr(x) + '.' + FedExImageTypeToExtStr(LabelImageType);
              FedExShipIntl.PackageSignatureType[x] := TibxfedexshipintlPackageSignatureTypes(Packages.PackageSignatureType);
              FedExShipIntl.PackageSpecialServices[x] := Packages.PackageSpecialService;
              FedExShipIntl.PackageType[x] := TibxfedexshipintlPackageTypes(Packages.PackageType);
              FedExShipIntl.PackageWeight[x] := FormatWeightString(Packages.PackageWeight);
              FedExShipIntl.PackageWidth[x] := Packages.PackageWidth;

              FedExShipIntl.CommodityDescription[x] := Packages.CommodityDescription;
              FedExShipIntl.CommodityHarmonizedCode[x] := Packages.CommodityHarmonizedCode;
              FedExShipIntl.CommodityManufacturer[x] := Packages.CommodityManufacturer;
              FedExShipIntl.CommodityNumberOfPieces[x] := Packages.CommodityNumberOfPieces;
              FedExShipIntl.CommodityQuantity[x] := Packages.CommodityQuantity;
              FedExShipIntl.CommodityQuantityUnit[x] := Packages.CommodityQuantityUnit;
              FedExShipIntl.CommodityUnitPrice[x] := FloatToStr(Packages.CommodityUnitPrice);
              FedExShipIntl.CommodityValue[x] := FloatToStr(Packages.CommodityValue);
              FedExShipIntl.CommodityWeight[x] := Packages.CommodityWeight;


              Packages.Next;
            end;
          finally
            Packages.Dataset.EnableControls;
          end;

          { use TLS 1.2 }
          FedExShipIntl.Config('SSLEnabledProtocols=3072');

          FedExShipIntl.GetShipmentLabels;

          CheckForErrors(FedExShipIntl.Config('RawResponse'));
//          with TStringList.Create do begin
//            Text := FedExShipIntl.Config('RawResponse');
//            SavetoFile('c:\temp\temp.xml');
//            Free;
//          end;


          { get returned data }
          MasterTrackingNumber := FedExShipIntl.MasterTrackingNumber;
          DeliveryDate :=  StrToDateTimeFmt('yyyy-mm-dd', FedExShipIntl.DeliveryDate);
          TotalNetCharge := StrToFloatDef(FedExShipIntl.TotalNetCharge, 0);

          Packages.Dataset.DisableControls;
          try
            Packages.First;
            while not Packages.EOF do begin
              x := Packages.Dataset.RecNo -1;
  //            if (x = 0) and (MasterTrackingNumber = '') then
  //              MasterTrackingNumber := FedExShip.PackageTrackingNumber[x];
              Packages.PackageTrackingNumber := FedExShipIntl.PackageTrackingNumber[x];
              Packages.PackageNetCharge := StrToFloatDef(FedExShipIntl.PackageNetCharge[x], 0);
              Packages.PackageBaseCharge := StrToFloatDef(FedExShipIntl.PackageBaseCharge[x], 0);
              Packages.PackageTotalDiscount := StrToFloatDef(FedExShipIntl.PackageTotalDiscount[x], 0);
              Packages.PackageTotalSurcharges := StrToFloatDef(FedExShipIntl.PackageTotalSurcharges[x], 0);

              { get labels }
  //            Packages.PackageShippingLabel := upsShip.PackageShippingLabel[x];

              Packages.EditDb;
              if FileExists(FedExShipIntl.PackageShippingLabelFile[x]) then
                TBlobField(Packages.Dataset.FieldByName('PackageShippingLabel')).LoadFromFile(FedExShipIntl.PackageShippingLabelFile[x]);
              if FileExists(FedExShipIntl.PackageCODFile[x]) then
                TBlobField(Packages.Dataset.FieldByName('PackageCODLabel')).LoadFromFile(FedExShipIntl.PackageCODFile[x]);

              try
                Packages.PostDb;
              Except
                // Pakage posting is aborted when its empty
              end;

              Packages.Next;
            end;

          finally
            Packages.Dataset.EnableControls;
          end;

        except
          on e: exception do begin
            result := false;
            Err := TShipperError.Create(e);
            try
              msg := 'Error requesting label generation';
              if Err.ErrorDesc <> '' then
                msg := msg + ' with message: ' +  Err.ErrorDesc;
            finally
              Err.Free;
            end;
            AddResult(false,rssWarning,0,msg);
            ProcessedComment := msg;
            exit;
          end;
        end;
      finally
        FedExShipIntl.Free;
      end;
      exit;
    end;


    { else Domestic }
    FedExShip := TibxFedExShip.Create(nil);
    try
      try
//        if DocumentsOnly then
//          FedExShip.Config('Documents=True')
//        else
//          FedExShip.Config('Documents=False');

        FedExShip.FedExDeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
        FedExShip.FedExAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
        FedExShip.FedExMeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
        FedExShip.FedExPassword := AppEnv.CompanyPrefs.FedExConfig.Password;
        FedExShip.FedExServer := AppEnv.CompanyPrefs.FedExConfig.Server;

        if AppEnv.RegionalOptions.RegionType = rUSA then begin
          FedExShip.Config('WeightUnit=LB');
          FedExShip.Config('SizeUnit=IN');
        end
        else begin
          FedExShip.Config('WeightUnit=KG');
          FedExShip.Config('SizeUnit=CM');
        end;

        { ---- Header ---- }
        //FedExShip.TotalWeight := '1';
        //FedExShip.InsuredValue := '0.00';
        FedExShip.ShipmentSpecialServices := ShipmentSpecialServices;
        FedExShip.ServiceType := TibxfedexshipServiceTypes(ServiceType);
        FedExShip.DropoffType := TibxfedexshipDropoffTypes(DropoffType);
        FedExShip.LabelImageType := TibxfedexshipLabelImageTypes(LabelImageType);
        FedExShip.PayorType := TibxfedexshipPayorTypes(PayorType);
        if PayorAccountNumber <> '' then begin
          FedExShip.PayorAccountNumber := PayorAccountNumber;
          FedExShip.PayorCountryCode := PayorZipCode;
        end
        else
          FedExShip.PayorAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;

        ShipDate := now;

        FedExShip.ShipDate := FormatDateTime('yyyy-mm-dd',ShipDate);

        { ---- Sender ---- }
        FedExShip.SenderFirstName := SenderFirstName;
        FedExShip.SenderMiddleInitial := SenderInitial;
        FedExShip.SenderLastName := SenderLastName;
        FedExShip.SenderCompany := SenderCompany;
        FedExShip.SenderAddress1 := SenderAddress1;
        FedExShip.SenderAddress2 := SenderAddress2;
        FedExShip.SenderCity := SenderCity;
        FedExShip.SenderState := SenderState;
        FedExShip.SenderZipCode := SenderZipCode;
        FedExShip.SenderCountryCode := TCountries.ShortCodeForCountry(SenderCountryCode);
        FedExShip.SenderEmail := SenderEmail;
        FedExShip.SenderPhone := SenderPhone;
        FedExShip.SenderFax := SenderFax;

        { ---- Recipient ---- }
        FedExShip.RecipientFirstName := RecipientFirstName;
        FedExShip.RecipientMiddleInitial := RecipientInitial;
        FedExShip.RecipientLastName := RecipientLastName;
        FedExShip.RecipientCompany := RecipientCompany;
        FedExShip.RecipientAddress1 := RecipientAddress1;
        FedExShip.RecipientAddress2 := RecipientAddress2;
        FedExShip.RecipientCity := RecipientCity;
        FedExShip.RecipientState := RecipientState;
        FedExShip.RecipientZipCode := RecipientZipCode;
        FedExShip.RecipientCountryCode := TCountries.ShortCodeForCountry(RecipientCountryCode);
        FedExShip.RecipientEmail := RecipientEmail;
        FedExShip.RecipientPhone := RecipientPhone;
        FedExShip.RecipientFax := RecipientFax;

        { ---- Packages ---- }
        tempLabelFile := SystemLib.GetAppTempDir + '\FedEx_Ship_Label_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz_',now);
        FedExShip.PackageCount := Packages.Count;
        Packages.Dataset.DisableControls;
        try
          Packages.First;
          FedExShip.PackageCount := Packages.Count;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
            FedExShip.PackageCODAmount[x] := FormatFloat('#0.00', Packages.PackageCODAmount);
            FedExShip.PackageCODType[x] := TibxfedexshipPackageCODTypes(Packages.PackageCODType);
            FedExShip.PackageCODFile[X] := SystemLib.GetAppTempDir + '\FedEx_COD_Label_' + IntToStr(x) + '.' + FedExImageTypeToExtStr(LabelImageType);
            FedExShip.PackageDangerousGoodsAccessible[x] := Packages.PackageDangerousGoodsAccessible;
           { Including PackageDescription in the request is producing an error so leave out for now }
            //FedExShip.PackageDescription[x] := Packages.PackageDescription; // ####################
            FedExShip.PackageHeight[x] := Packages.PackageHeight;
            FedExShip.PackageInsuredValue[x] :=  FormatFloat('#0.00',Packages.PackageInsuredValue);
            FedExShip.PackageLength[x] := Packages.PackageLength;
            FedExShip.PackageReference[x] := Packages.PackageReference;
            FedExShip.PackageShippingLabelFile[x] := tempLabelFile + IntToStr(x) + '.' + FedExImageTypeToExtStr(LabelImageType);
            FedExShip.PackageSignatureType[x] := TibxfedexshipPackageSignatureTypes(Packages.PackageSignatureType);
            FedExShip.PackageSpecialServices[x] := Packages.PackageSpecialService;
            FedExShip.PackageType[x] := TibxFedExshipPackageTypes(Packages.PackageType);
            FedExShip.PackageWeight[x] := FormatWeightString(Packages.PackageWeight);
            FedExShip.PackageWidth[x] := Packages.PackageWidth;
            Packages.Next;
          end;
        finally
          Packages.Dataset.EnableControls;
        end;

        { use TLS 1.2 }
        FedExShip.Config('SSLEnabledProtocols=3072');

        FedExShip.GetShipmentLabels;
        CheckForErrors(FedExShip.Config('RawResponse'));

        { get returned data }
        MasterTrackingNumber := FedExShip.MasterTrackingNumber;
        DeliveryDate :=  StrToDateTimeFmt('yyyy-mm-dd', FedExShip.DeliveryDate);
        TotalNetCharge := StrToFloatDef(FedExShip.TotalNetCharge, 0);

        Packages.Dataset.DisableControls;
        try
          Packages.First;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
//            if (x = 0) and (MasterTrackingNumber = '') then
//              MasterTrackingNumber := FedExShip.PackageTrackingNumber[x];
            Packages.PackageTrackingNumber := FedExShip.PackageTrackingNumber[x];
            Packages.PackageNetCharge := StrToFloatDef(FedExShip.PackageNetCharge[x], 0);
            Packages.PackageBaseCharge := StrToFloatDef(FedExShip.PackageBaseCharge[x], 0);
            Packages.PackageTotalDiscount := StrToFloatDef(FedExShip.PackageTotalDiscount[x], 0);
            Packages.PackageTotalSurcharges := StrToFloatDef(FedExShip.PackageTotalSurcharges[x], 0);

            { get labels }
//            Packages.PackageShippingLabel := upsShip.PackageShippingLabel[x];

            Packages.EditDb;
            if FileExists(FedExShip.PackageShippingLabelFile[x]) then
              TBlobField(Packages.Dataset.FieldByName('PackageShippingLabel')).LoadFromFile(FedExShip.PackageShippingLabelFile[x]);
            if FileExists(FedExShip.PackageCODFile[x]) then
              TBlobField(Packages.Dataset.FieldByName('PackageCODLabel')).LoadFromFile(FedExShip.PackageCODFile[x]);

            try
              Packages.PostDb;
            Except
              // Pakage posting is aborted when its empty
            end;

            Packages.Next;
          end;

        finally
          Packages.Dataset.EnableControls;
        end;

      except
        on e: exception do begin
          result := false;
          Err := TShipperError.Create(e);
          try
            msg := 'Error requesting label generation';
            if Err.ErrorDesc <> '' then
              msg := msg + ' with message: ' +  Err.ErrorDesc;
          finally
            Err.Free;
          end;
          AddResult(false,rssWarning,0,msg);
          ProcessedComment := msg;
          exit;
        end;
      end;
    finally
      FedExShip.Free;
    end;
    exit;
  end;
  if Provider = pUPS then begin
    upsShip := TibxUPSShip.Create(nil);
    try
      try
        { use TLS 1.2 }
        upsShip.Config('SSLEnabledProtocols=3072');

//        if DocumentsOnly then
//          upsShip.Config('Documents=True')
//        else
//          upsShip.Config('Documents=False');

        upsShip.UPSAccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
        upsShip.UPSAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
        upsShip.UPSUserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
        upsShip.UPSPassword := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
        if AppEnv.CompanyPrefs.UPSConfig.TestMode then
          upsShip.UPSServer := AppEnv.CompanyPrefs.UPSConfig.TestURL + '/Ship'
        else
          upsShip.UPSServer := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/Ship';

        if AppEnv.RegionalOptions.RegionType = rUSA then
          upsShip.Config('WeightUnit=LBS')   { NOTE: us domestic shipments only }
        else
          upsShip.Config('WeightUnit=KGS');


        ShipDate := now; //FormatDateTime('yyyy-mm-dd',now);

        { ---- Header ---- }
        upsShip.ServiceType := TibxupsshipServiceTypes(ServiceType);
        upsShip.LabelImageType := TibxupsshipLabelImageTypes(LabelImageType);
        upsShip.PayorType := TibxupsshipPayorTypes(PayorType);
        if PayorAccountNumber <> '' then begin
          upsShip.PayorAccountNumber := PayorAccountNumber;
          upsShip.PayorZipCode := PayorZipCode;
        end
        else
          upsShip.PayorAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;

        if IsUPSMailInnovations(ServiceType) then begin
          upsShip.Config('MICostCenter=' + self.MICostCenter);
          upsShip.Config('MIPackageID='+  self.MIPackageID);
          upsShip.Config('USPSEndorsement='+  IntToStr(self.Endorsement));

        end;

        upsShip.ShipDate := FormatDateTime('yyyy-mm-dd',ShipDate);

        { ---- Sender ---- }
        upsShip.SenderFirstName := SenderFirstName;
        upsShip.SenderMiddleInitial := SenderInitial;
        upsShip.SenderLastName := SenderLastName;
        upsShip.SenderCompany := SenderCompany;
        upsShip.SenderAddress1 := SenderAddress1;
        upsShip.SenderAddress2 := SenderAddress2;
        upsShip.SenderCity := SenderCity;
        upsShip.SenderState := SenderState;
        upsShip.SenderZipCode := SenderZipCode;
        upsShip.SenderCountryCode := TCountries.ShortCodeForCountry(SenderCountryCode);
        upsShip.SenderEmail := SenderEmail;
        upsShip.SenderPhone := SenderPhone;
        upsShip.SenderFax := SenderFax;

        { ---- Recipient ---- }
        upsShip.RecipientFirstName := RecipientFirstName;
        upsShip.RecipientMiddleInitial := RecipientInitial;
        upsShip.RecipientLastName := RecipientLastName;
        upsShip.RecipientCompany := RecipientCompany;
        upsShip.RecipientAddress1 := RecipientAddress1;
        upsShip.RecipientAddress2 := RecipientAddress2;
        upsShip.RecipientCity := RecipientCity;
        upsShip.RecipientState := RecipientState;
        upsShip.RecipientZipCode := RecipientZipCode;
        upsShip.RecipientCountryCode := TCountries.ShortCodeForCountry(RecipientCountryCode);
        upsShip.RecipientEmail := RecipientEmail;
        upsShip.RecipientPhone := RecipientPhone;
        upsShip.RecipientFax := RecipientFax;
        if self.RecipientAddressValid then
//          upsShip.Config('RequestOption=nonvalidate');
          upsShip.Config('RequestOption=1');

        { ---- Packages ---- }
        tempLabelFile := SystemLib.GetAppTempDir + '\UPS_Ship_Label_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz_',now);
        upsShip.PackageCount := Packages.Count;
        Packages.Dataset.DisableControls;
        try
          Packages.First;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
            upsShip.PackageWeight[x] := Packages.PackageWeight;
            upsShip.PackageCODAmount[x] := FormatFloat('#0.00', Packages.PackageCODAmount);
            upsShip.PackageCODType[x] := TibxupsshipPackageCODTypes(Packages.PackageCODType);
            upsShip.PackageDescription[x] := Packages.PackageDescription;
            upsShip.PackageSignatureType[x] := TibxupsshipPackageSignatureTypes(Packages.PackageSignatureType);
            upsShip.PackageSpecialServices[x] := Packages.PackageSpecialService;
            upsShip.PackageHeight[x] := Packages.PackageHeight;
            upsShip.PackageLength[x] := Packages.PackageLength;
            upsShip.PackageWidth[x] := Packages.PackageWidth;
            upsShip.PackageInsuredValue[x] :=  FormatFloat('#0.00',Packages.PackageInsuredValue);
//            upsShip.PackageNetCharge[x] := Packages.PackageNetCharge;
            upsShip.PackageType[x] := TibxupsshipPackageTypes(Packages.PackageType);

            if not IsUPSMailInnovations(ServiceType) then
              upsShip.PackageReference[x] := Packages.PackageReference;
            upsShip.PackageShippingLabelFile[x] := tempLabelFile + IntToStr(x) + '.' + UPSImageTypeToStr(TibxupsshipLabelImageTypes(LabelImageType));

            Packages.Next;
          end;

        finally
          Packages.Dataset.EnableControls;
        end;

        upsShip.GetShipmentLabels;

        { get returned data }

        MasterTrackingNumber := upsShip.MasterTrackingNumber;
        TotalNetCharge := StrToFloatDef(upsShip.TotalNetCharge, 0);
        TotalBaseCharge := StrToFloatDef(upsShip.TotalBaseCharge,0);
        TotalSurcharges := StrToFloatDef(upsShip.TotalSurcharges,0);
        { fixed in latest component version }
        TotalNetChargeNegotiated := StrToFloatDef(upsShip.Config('AccountTotalNetCharge'), 0);

        { if this is a Mail Inovations shipment we need to return the USPSPICNumber }
        doc := TXMLDocument.Create(nil);
        try
          doc.LoadFromXML(upsShip.Config('RawResponse'));
          doc.Active := true;
          USPSPICNumber :=
            GetNodeVal(doc.DocumentElement,'soapenv:Body.ship:ShipmentResponse.ship:ShipmentResults.ship:PackageResults.ship:USPSPICNumber');
          PackageIDCode := USPSPICNumber;
        finally
          doc := nil;
        end;
(*
        with tstringlist.Create do begin
          text := upsShip.Config('RawRequest');
          savetofile('c:\temp\RawRequest.xml');
          free;
        end;

        with tstringlist.Create do begin
          text := upsShip.Config('RawResponse');
          savetofile('c:\temp\RawResponse.xml');
          free;
        end;
*)

        Packages.Dataset.DisableControls;
        try
          Packages.First;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
            Packages.PackageTrackingNumber := upsShip.PackageTrackingNumber[x];
            Packages.PackageTotalSurcharges := StrToFloatDef(upsShip.PackageTotalSurcharges[x],0);
            { get labels }
//            Packages.PackageShippingLabel := upsShip.PackageShippingLabel[x];

            Packages.EditDb;
            TBlobField(Packages.Dataset.FieldByName('PackageShippingLabel')).LoadFromFile(tempLabelFile + IntToStr(x) + '.' + UPSImageTypeToStr(TibxupsshipLabelImageTypes(LabelImageType)));

            try
              Packages.PostDb;
            Except
              // Pakage posting is aborted when its empty
            end;
            Packages.Next;
          end;

        finally
          Packages.Dataset.EnableControls;
        end;

      except
        on e: exception do begin

//          with tstringlist.Create do begin
//            text := upsShip.Config('RawRequest');
//            savetofile('c:\temp\RawRequest.xml');
//            free;
//          end;

          result := false;
          Err := TShipperError.Create(e);
          try
            msg := 'Error requesting label generation';
            if Err.ErrorDesc <> '' then
              msg := msg + ' with message: ' +  Err.ErrorDesc;
          finally
            Err.Free;
          end;
          AddResult(false,rssWarning,0,msg);
          ProcessedComment := msg;
          exit;
        end;
      end;

    finally
      upsShip.Free;
    end;
    exit;
  end;

  if Provider = pUSPS then begin
    uspsShip := TibxUSPSShip.Create(nil);
    try
      try
//        if DocumentsOnly then
//          uspsShip.Config('Documents=True')
//        else
//          uspsShip.Config('Documents=False');

        uspsShip.PostageProvider := TibxuspsshipPostageProviders(PostageProvider);

        uspsShip.USPSUserId := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
        uspsShip.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
        uspsShip.USPSServer := AppEnv.CompanyPrefs.USPSConfig.ShipServer;
        if trim(uspsShip.USPSUserId) ='' then begin
          uspsShip.USPSUserId    := TestUSPSUserID;
          uspsShip.USPSPassword  := TestUSPSPassword;
          uspsShip.USPSServer    := TestShipServer;
        end;

        (*if uspsShip.PostageProvider = ppEndicia then begin
          uspsShip.USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.EndiciaAccountNumber;
//          uspsShip.CustomerId := AppEnv.CompanyPrefs.USPSConfig.CustomerID;
          uspsShip.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.EndiciaPassword;
          uspsShip.TransactionId := IntToStr(self.SaleId);
          uspsShip.Config('EndiciaTestMode=' + IntToStr(AppEnv.CompanyPrefs.USPSConfig.EndiciaTestMode));
        end
        else if uspsShip.PostageProvider = ppStamps then begin
          uspsShip.USPSUserId := AppEnv.CompanyPrefs.USPSConfig.StampsUserID;
          uspsShip.USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.StampsAccountNumber;
          uspsShip.USPSPassword := AppEnv.CompanyPrefs.USPSConfig.StampsPassword;
          uspsShip.USPSServer := AppEnv.CompanyPrefs.USPSConfig.StampsServer;
          uspsShip.Config('StampsTestMode=' + IntToStr(AppEnv.CompanyPrefs.USPSConfig.StampsTestMode));
        end;*)

        if AppEnv.CompanyPrefs.USPSConfig.StampsTestMode > 0 then
          uspsShip.Config('Certify=true'); // test mode

        { ---- Header ---- }
        uspsShip.ServiceType := TibxuspsshipServiceTypes(ServiceType);
        uspsShip.LabelImageType := TibxuspsshipLabelImageTypes(LabelImageType);

        if Trunc(ShipDate) > 0 then
          //uspsShip.ShipDate := FormatDateTime('mm/dd/yyyy',ShipDate);
          uspsShip.ShipDate := FormatDateTime('yyyyMMdd',ShipDate);

        { ---- Sender ---- }
        uspsShip.SenderFirstName := SenderFirstName;
        uspsShip.SenderMiddleInitial := SenderInitial;
        uspsShip.SenderLastName := SenderLastName;
        uspsShip.SenderCompany := SenderCompany;
        uspsShip.SenderAddress1 := SenderAddress1;
        uspsShip.SenderAddress2 := SenderAddress2;
        uspsShip.SenderCity := SenderCity;
        uspsShip.SenderState := SenderState;
        uspsShip.SenderZipCode := SenderZipCode;
        uspsShip.SenderEmail := SenderEmail;
        uspsShip.SenderPhone := SenderPhone;
        uspsShip.SenderFax := SenderFax;

        { ---- Recipient ---- }
        uspsShip.RecipientFirstName := RecipientFirstName;
        uspsShip.RecipientMiddleInitial := RecipientInitial;
        uspsShip.RecipientLastName := RecipientLastName;
        uspsShip.RecipientCompany := RecipientCompany;
        uspsShip.RecipientAddress1 := RecipientAddress1;
        uspsShip.RecipientAddress2 := RecipientAddress2;
        uspsShip.RecipientCity := RecipientCity;
        uspsShip.RecipientState := RecipientState;
        uspsShip.RecipientZipCode := RecipientZipCode;
        uspsShip.RecipientEmail := RecipientEmail;
        uspsShip.RecipientPhone := RecipientPhone;
        uspsShip.RecipientFax := RecipientFax;

        { ---- Packages ---- }
        tempLabelFile := SystemLib.GetAppTempDir + '\USPS_Ship_Label_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz_',now);
        uspsShip.PackageCount := Packages.Count;
        Packages.Dataset.DisableControls;
        try
          Packages.First;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
            if uspsShip.PostageProvider = ppEndicia then begin
              // "N.N" format - in ounces
              uspsShip.PackageWeight[x] := FloattoStr((StrtoFloatDef(Packages.PackageWeight,0) * 16) + StrtoFloatDef(Packages.PackageWeightFrac,0));
            end
            else begin
              // "N lbs N oz" format
              uspsShip.PackageWeight[x] := Packages.PackageWeight + ' lbs ' + FloatToStr(StrtoFloatDef(Packages.PackageWeightFrac,0)) + ' oz';
            end;

            uspsShip.PackageDescription[x] := Packages.PackageDescription;
            uspsShip.PackageSignatureType[x] := TibxuspsshipPackageSignatureTypes(Packages.PackageSignatureType);
            uspsShip.PackageHeight[x] := Packages.PackageHeight;
            uspsShip.PackageLength[x] := Packages.PackageLength;
            uspsShip.PackageWidth[x] := Packages.PackageWidth;
            uspsShip.PackageInsuredValue[x] :=  FormatFloat('#0.00',Packages.PackageInsuredValue);
            uspsShip.PackageType[x] := TibxuspsshipPackageTypes(Packages.PackageType);

            if uspsShip.LabelImageType <> sitNone then
              uspsShip.PackageShippingLabelFile[x] := tempLabelFile + IntToStr(x) + '.' + USPSImageTypeToStr(LabelImageType);

            Packages.Next;
          end;

        finally
          Packages.Dataset.EnableControls;
        end;

        try
          uspsShip.GetPackageLabel;
      except
        on e: exception do begin
          result := false;
          Err := TShipperError.Create(e);
          try
            msg := 'Error requesting label generation';
            if Err.ErrorDesc <> '' then
              msg := msg + ' with message: ' +  Err.ErrorDesc;
          finally
            Err.Free;
          end;
          AddResult(false,rssWarning,0,msg);
          ProcessedComment := msg;
          exit;
        end;
      end;

        { get returned data }

        if uspsShip.PostageProvider = ppEndicia then
          ShipDate := StrToDateTimeFmt('dd/mm/yyy', uspsShip.ShipDate);
(*
        with tstringlist.Create do begin
          text := upsShip.Config('RawRequest');
          savetofile('c:\temp\RawRequest.xml');
          free;
        end;

        with tstringlist.Create do begin
          text := upsShip.Config('RawResponse');
          savetofile('c:\temp\RawResponse.xml');
          free;
        end;
*)
        TotalNetCharge := 0;
        Packages.Dataset.DisableControls;
        try
          Packages.First;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
            Packages.PackageTrackingNumber := uspsShip.PackageTrackingNumber[x];
//            if x = 0 then
//              MasterTrackingNumber := Packages.PackageTrackingNumber;
            Packages.PackageNetCharge := StrToFloatDef(uspsShip.PackageNetCharge[x],0);
            TotalNetCharge := TotalNetCharge + Packages.PackageNetCharge;
            { get labels }
            Packages.EditDb;
            TBlobField(Packages.Dataset.FieldByName('PackageShippingLabel')).LoadFromFile(tempLabelFile + IntToStr(x) + '.' + USPSImageTypeToStr(LabelImageType));
            try
              Packages.PostDb;
            Except
              // Pakage posting is aborted when its empty
            end;
            Packages.Next;
          end;

        finally
          Packages.Dataset.EnableControls;
        end;

        self.TotalNetCharge := TotalNetCharge;

      except
        on e: exception do begin

//          with tstringlist.Create do begin
//            text := upsShip.Config('RawRequest');
//            savetofile('c:\temp\RawRequest.xml');
//            free;
//          end;

          result := false;
          Err := TShipperError.Create(e);
          try
            msg := 'Error requesting label generation';
            if Err.ErrorDesc <> '' then
              msg := msg + ' with message: ' +  Err.ErrorDesc;
          finally
            Err.Free;
          end;
          AddResult(false,rssWarning,0,msg);
          ProcessedComment := msg;
          exit;
        end;
      end;

    finally
      uspsShip.Free;
    end;
    exit;
  end;


(*
  if Provider = pUPS then begin
    upsShip := TibxUPSShip.Create(nil);
    try
      try
        upsShip.UPSAccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
        upsShip.UPSAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
        upsShip.UPSUserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
        upsShip.UPSPassword := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
        upsShip.UPSServer := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/Ship';

        if AppEnv.RegionalOptions.RegionType = rUSA then
          upsShip.Config('WeightUnit=LBS')   { NOTE: us domestic shipments only }
        else
          upsShip.Config('WeightUnit=KGS');


        ShipDate := now; //FormatDateTime('yyyy-mm-dd',now);

        { ---- Header ---- }
        upsShip.ServiceType := TibxupsshipServiceTypes(ServiceType);
        upsShip.LabelImageType := TibxupsshipLabelImageTypes(LabelImageType);
        upsShip.PayorType := TibxupsshipPayorTypes(PayorType);
        if PayorAccountNumber <> '' then begin
          upsShip.PayorAccountNumber := PayorAccountNumber;
          upsShip.PayorZipCode := PayorZipCode;
        end
        else
          upsShip.PayorAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;

        if IsUPSMailInnovations(ServiceType) then begin
          upsShip.Config('MICostCenter=' + self.MICostCenter);
          upsShip.Config('MIPackageID='+  self.MIPackageID);
          upsShip.Config('USPSEndorsement='+  IntToStr(self.Endorsement));

        end;

        upsShip.ShipDate := FormatDateTime('yyyy-mm-dd',ShipDate);

        { ---- Sender ---- }
        upsShip.SenderFirstName := SenderFirstName;
        upsShip.SenderMiddleInitial := SenderInitial;
        upsShip.SenderLastName := SenderLastName;
        upsShip.SenderCompany := SenderCompany;
        upsShip.SenderAddress1 := SenderAddress1;
        upsShip.SenderAddress2 := SenderAddress2;
        upsShip.SenderCity := SenderCity;
        upsShip.SenderState := SenderState;
        upsShip.SenderZipCode := SenderZipCode;
        upsShip.SenderCountryCode := SenderCountryCode;
        upsShip.SenderEmail := SenderEmail;
        upsShip.SenderPhone := SenderPhone;
        upsShip.SenderFax := SenderFax;

        { ---- Recipient ---- }
        upsShip.RecipientFirstName := RecipientFirstName;
        upsShip.RecipientMiddleInitial := RecipientInitial;
        upsShip.RecipientLastName := RecipientLastName;
        upsShip.RecipientCompany := RecipientCompany;
        upsShip.RecipientAddress1 := RecipientAddress1;
        upsShip.RecipientAddress2 := RecipientAddress2;
        upsShip.RecipientCity := RecipientCity;
        upsShip.RecipientState := RecipientState;
        upsShip.RecipientZipCode := RecipientZipCode;
        upsShip.RecipientCountryCode := RecipientCountryCode;
        upsShip.RecipientEmail := RecipientEmail;
        upsShip.RecipientPhone := RecipientPhone;
        upsShip.RecipientFax := RecipientFax;
        if self.RecipientAddressValid then
//          upsShip.Config('RequestOption=nonvalidate');
          upsShip.Config('RequestOption=1');

        { ---- Packages ---- }
        tempLabelFile := SystemLib.GetAppTempDir + '\UPS_Ship_Label_' + FormatDateTime('yyyy-mm-dd_hh-nn-ss-zzz_',now);
        upsShip.PackageCount := Packages.Count;
        Packages.Dataset.DisableControls;
        try
          Packages.First;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
            upsShip.PackageWeight[x] := Packages.PackageWeight;
            upsShip.PackageCODAmount[x] := FormatFloat('#0.00', Packages.PackageCODAmount);
            upsShip.PackageCODType[x] := TibxupsshipPackageCODTypes(Packages.PackageCODType);
            upsShip.PackageDescription[x] := Packages.PackageDescription;
            upsShip.PackageSignatureType[x] := TibxupsshipPackageSignatureTypes(Packages.PackageSignatureType);
            upsShip.PackageSpecialServices[x] := Packages.PackageSpecialService;
            upsShip.PackageHeight[x] := Packages.PackageHeight;
            upsShip.PackageLength[x] := Packages.PackageLength;
            upsShip.PackageWidth[x] := Packages.PackageWidth;
            upsShip.PackageInsuredValue[x] :=  FormatFloat('#0.00',Packages.PackageInsuredValue);
//            upsShip.PackageNetCharge[x] := Packages.PackageNetCharge;
            upsShip.PackageType[x] := TibxupsshipPackageTypes(Packages.PackageType);

            if not IsUPSMailInnovations(ServiceType) then
              upsShip.PackageReference[x] := Packages.PackageReference;
            upsShip.PackageShippingLabelFile[x] := tempLabelFile + IntToStr(x) + '.' + UPSImageTypeToStr(TibxupsshipLabelImageTypes(LabelImageType));

            Packages.Next;
          end;

        finally
          Packages.Dataset.EnableControls;
        end;

        upsShip.GetShipmentLabels;

        { get returned data }

        MasterTrackingNumber := upsShip.MasterTrackingNumber;
        TotalNetCharge := StrToFloatDef(upsShip.TotalNetCharge, 0);
        TotalBaseCharge := StrToFloatDef(upsShip.TotalBaseCharge,0);
        TotalSurcharges := StrToFloatDef(upsShip.TotalSurcharges,0);
        { fixed in latest component version }
        TotalNetChargeNegotiated := StrToFloatDef(upsShip.Config('AccountTotalNetCharge'), 0);

        { if this is a Mail Inovations shipment we need to return the USPSPICNumber }
        doc := TXMLDocument.Create(nil);
        try
          doc.LoadFromXML(upsShip.Config('RawResponse'));
          doc.Active := true;
          USPSPICNumber :=
            GetNodeVal(doc.DocumentElement,'soapenv:Body.ship:ShipmentResponse.ship:ShipmentResults.ship:PackageResults.ship:USPSPICNumber');
          PackageIDCode := USPSPICNumber;
        finally
          doc := nil;
        end;

//        with tstringlist.Create do begin
//          text := upsShip.Config('RawRequest');
//          savetofile('c:\temp\RawRequest.xml');
//          free;
//        end;
//
//        with tstringlist.Create do begin
//          text := upsShip.Config('RawResponse');
//          savetofile('c:\temp\RawResponse.xml');
//          free;
//        end;

        Packages.Dataset.DisableControls;
        try
          Packages.First;
          while not Packages.EOF do begin
            x := Packages.Dataset.RecNo -1;
            Packages.PackageTrackingNumber := upsShip.PackageTrackingNumber[x];
            Packages.PackageTotalSurcharges := StrToFloatDef(upsShip.PackageTotalSurcharges[x],0);
            { get labels }
//            Packages.PackageShippingLabel := upsShip.PackageShippingLabel[x];

            Packages.EditDb;
            TBlobField(Packages.Dataset.FieldByName('PackageShippingLabel')).LoadFromFile(tempLabelFile + IntToStr(x) + '.' + UPSImageTypeToStr(TibxupsshipLabelImageTypes(LabelImageType)));

            try
              Packages.PostDb;
            Except
              // Pakage posting is aborted when its empty
            end;
            Packages.Next;
          end;

        finally
          Packages.Dataset.EnableControls;
        end;

      except
        on e: exception do begin

//          with tstringlist.Create do begin
//            text := upsShip.Config('RawRequest');
//            savetofile('c:\temp\RawRequest.xml');
//            free;
//          end;

          result := false;
          Err := TShipperError.Create(e);
          try
            msg := 'Error requesting label generation';
            if Err.ErrorDesc <> '' then
              msg := msg + ' with message: ' +  Err.ErrorDesc;
          finally
            Err.Free;
          end;
          AddResult(false,rssWarning,0,msg);
          ProcessedComment := msg;
          exit;
        end;
      end;

    finally
      upsShip.Free;
    end;
  end;
*)
end;

procedure TShipment.DoOnGetShipmentLabelsError(Sender: TObject;
  ErrorCode: integer; const Description: String);
begin
  raise Exception.Create(Description);
end;

function TShipment.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

function TShipment.GetBookingNumber: string;
begin
  result := GetStringField('BookingNumber');
end;

class function TShipment.GetBusObjectTablename: string;
begin
  result := 'tblShipment';
end;

function TShipment.GetCanceled: boolean;
begin
  result := GetBooleanField('Canceled');
end;

function TShipment.GetDeliveryDate: TDateTime;
begin
  result := GetDateTimeField('DeliveryDate');
end;

function TShipment.GetDocumentsOnly: boolean;
begin
  result := GetBooleanField('DocumentsOnly');
end;

function TShipment.GetDropoffType: integer;
begin
  result := GetIntegerField('DropoffType')
end;

function TShipment.GetEndorsement: integer;
begin
  result := GetIntegerField('Endorsement');
end;

class function TShipment.GetIDField: string;
begin
  result := 'ShipmentId';
end;

function TShipment.GetLabelImageType: integer;
begin
  result := GetIntegerField('LabelImageType');
end;

function TShipment.GetMasterTrackingNumber: string;
begin
  result := GetStringField('MasterTrackingNumber');
end;

function TShipment.GetMICostCenter: string;
begin
  result := GetStringField('MICostCenter');
end;

function TShipment.GetMIPackageID: string;
begin
  result := GetStringField('MIPackageID');
end;

function TShipment.GetPackageIDCode: string;
begin
  result := GetStringField('PackageIDCode');
end;

function TShipment.GetPackages: TShipmentPackage;
begin
  result := TShipmentPackage(self.getContainerComponent(TShipmentPackage,'ShipmentId = ' + IntToStr(Id)));
end;

function TShipment.GetPayorAccountNumber: string;
begin
  result := GetStringField('PayorAccountNumber');
end;

function TShipment.GetPayorCountryCode: string;
begin
  result := GetStringField('PayorCountryCode');
end;

function TShipment.GetPayorType: TibxezshipPayorTypes;
begin
  result := TibxezshipPayorTypes(GetIntegerField('PayorType'));
end;

function TShipment.GetPayorZipCode: string;
begin
  result := GetStringField('PayorZipCode');
end;

function TShipment.GetPostageProvider: integer;
begin
  result := GetIntegerField('PostageProvider');
end;

function TShipment.GetProcessed: boolean;
begin
  result := GetBooleanField('Processed');
end;

function TShipment.GetProcessedComment: string;
begin
  result := GetStringField('ProcessedComment');
end;

function TShipment.GetProvider: TibxezshipProviders;
begin
  result := TibxezshipProviders(GetIntegerField('Provider'));
end;

//function TShipment.GetReceipientAddress: string;
//begin
//  result := GetStringField('ReceipientAddress');
//end;

function TShipment.GetRecipientAddress1: string;
begin
  result := GetStringField('RecipientAddress1');
end;

function TShipment.GetRecipientAddress2: string;
begin
  result := GetStringField('RecipientAddress2');
end;

function TShipment.GetRecipientAddressValid: boolean;
begin
  result := GetBooleanField('RecipientAddressValid');
end;

function TShipment.GetRecipientCity: string;
begin
  result := GetStringField('RecipientCity');
end;

function TShipment.GetRecipientCompany: string;
begin
  result := GetStringField('RecipientCompany');
end;

function TShipment.GetRecipientCountryCode: string;
begin
  result := GetStringField('RecipientCountryCode');
end;

function TShipment.GetRecipientEmail: string;
begin
  result := GetStringField('RecipientEmail');
end;

function TShipment.GetRecipientFax: string;
begin
  result := GetStringField('RecipientFax');
end;

function TShipment.GetRecipientFirstName: string;
begin
  result := GetStringField('RecipientFirstName');
end;

function TShipment.GetRecipientInitial: string;
begin
  result := GetStringField('RecipientInitial');
end;

function TShipment.GetRecipientLastName: string;
begin
  result := GetStringField('RecipientLastName');
end;

function TShipment.GetRecipientPhone: string;
begin
  result := GetStringField('RecipientPhone');
end;

function TShipment.GetRecipientState: string;
begin
  result := GetStringField('RecipientState');
end;

function TShipment.GetRecipientZipCode: string;
begin
  result := GetStringField('RecipientZipCode');
end;

function TShipment.GetSaleId: integer;
var
  qry: TERPQuery;
begin
  if Assigned(Owner) and (Owner is TShipmentList) then
    result := TShipmentList(Owner).SaleId
  else begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := self.Connection.Connection;
      qry.SQL.Add('select * from tblshipmentlist');
      qry.SQL.Add('where ShipmentListId = ' + IntToStr(self.ShipmentListId));
      qry.Open;
      result := qry.FieldByName('SaleId').AsInteger;
    finally
      qry.Free;
    end;
  end;
end;

function TShipment.GetSaleRefNo: string;
var
  qry: TERPQuery;
begin
  if Assigned(Owner) and (Owner is TShipmentList) then
    result := TShipmentList(Owner).SaleRefNo
  else begin
    qry := DbSharedObj.GetQuery(self.Connection.Connection);
    try
      qry.SQL.Add('select tblsaleslines.SaleId from');
      qry.SQL.Add('tblsaleslines, tblshipmentsaleline');
      qry.SQL.Add('where tblshipmentsaleline.ShipmentID = ' + IntToStr(self.ID));
      qry.SQL.Add('and tblshipmentsaleline.SaleLineID = tblsaleslines.SaleLineId');
      qry.Open;
      result := IntToStr(qry.FieldByName('SaleId').AsInteger);
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;
end;

function TShipment.GetSalesLines: TShipmentSaleLine;
begin
  result := TShipmentSaleLine(self.getContainerComponent(TShipmentSaleLine, 'ShipmentId = ' + IntToStr(Id)));
end;

function TShipment.GetSaleType: string;
begin
  if Assigned(ShipmentList) then
    result := ShipmentList.SaleType
  else
    result := TShipmentList.ShipmentListSaleType(ShipmentListId);
end;

//function TShipment.GetSenderAddress: string;
//begin
//  result := GetStringField('SenderAddress');
//end;

function TShipment.GetSenderAddress1: string;
begin
  result := GetStringField('SenderAddress1');
end;

function TShipment.GetSenderAddress2: string;
begin
  result := GetStringField('SenderAddress2');
end;

function TShipment.GetSenderCity: string;
begin
  result := GetStringField('SenderCity');
end;

function TShipment.GetSenderCompany: string;
begin
  result := GetStringField('SenderCompany');
end;

function TShipment.GetSenderCountryCode: string;
begin
  result := GetStringField('SenderCountryCode');
end;

function TShipment.GetSenderEmail: string;
begin
  result := GetStringField('SenderEmail');
end;

function TShipment.GetSenderFax: string;
begin
  result := GetStringField('SenderFax');
end;

function TShipment.GetSenderFirstName: string;
begin
  result := GetStringField('SenderFirstName');
end;

function TShipment.GetSenderInitial: string;
begin
  result := GetStringField('SenderInitial');
end;

function TShipment.GetSenderLastName: string;
begin
  result := GetStringField('SenderLastName');
end;

function TShipment.GetSenderPhone: string;
begin
  result := GetStringField('SenderPhone');
end;

function TShipment.GetSenderState: string;
begin
  result := GetStringField('SenderState');
end;

function TShipment.GetSenderZipCode: string;
begin
  result := GetStringField('SenderZipCode');
end;

function TShipment.GetServiceType: TibxezshipServiceTypes;
begin
  result := TibxezshipServiceTypes(GetIntegerField('ServiceType'));
end;

function TShipment.GetShipAddressId: integer;
begin
  result := GetIntegerField('ShipAddressId');
end;

function TShipment.GetShipmentList: TShipmentList;
begin
  result := nil;
  if Assigned(Owner) and (Owner is TShipmentList) then
    result := TShipmentList(Owner);
end;

function TShipment.GetShipmentListId: integer;
begin
  result := GetIntegerField('ShipmentListId');
end;

function TShipment.GetShipmentSpecialServices: int64;
begin
  result := GetLargeintField('ShipmentSpecialServices');
end;

function TShipment.GetShipperType: TShipperType;
begin
  case Provider of
    pFedEx: result := spFedEx;
    pUPS: result := spUPS;
    pUSPS: result := spUSPS;
    pCanadaPost: result := spCanadaPost;
    else result:= spNone;
  end;
end;

function TShipment.GetShippingAddress: TShippingAddress;
begin
  result := TShippingAddress(self.getContainerComponent(TShippingAddress, 'ShipAddressId = ' + IntToStr(self.ShipAddressId)));
end;

function TShipment.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  if not inherited Save then exit;

  self.SalesLines.Dataset.DisableControls;
  try
    SalesLines.First;
    while not SalesLines.EOF do begin
      if not SalesLines.Save then
        exit;
      SalesLines.Next;
    end;
  finally
    self.SalesLines.Dataset.EnableControls;
  end;

  self.Packages.Dataset.DisableControls;
  try
    Packages.First;
    while not Packages.EOF do begin
      if not Packages.Save then
        exit;
      Packages.Next;
    end;
  finally
    self.Packages.Dataset.EnableControls;
  end;

  result := true;
end;

procedure TShipment.SaveToXMLNode(const node: IXMLNode);
var
  listNode, itemNode: IXMLNode;
begin
  inherited;
  XMLToBusObj.ObjToXML(self, node);

  listNode := Node.AddChild('Packages');
  if Packages.Count > 0 then begin
    Packages.Dataset.DisableControls;
    try
      Packages.First;
      while not Packages.EOF do begin
        itemNode := listNode.AddChild('Package');
        Packages.SaveToXMLNode(itemNode);
        Packages.Next;
      end;
    finally
      Packages.Dataset.EnableControls;
    end;
  end;

  listNode := Node.AddChild('SalesLines');
  if SalesLines.Count > 0 then begin
    SalesLines.Dataset.DisableControls;
    try
      SalesLines.First;
      while not SalesLines.EOF do begin
        itemNode := listNode.AddChild('SalesLine');
        SalesLines.SaveToXMLNode(itemNode);
        SalesLines.Next;
      end;
    finally
      SalesLines.Dataset.EnableControls;
    end;
  end;

end;

procedure TShipment.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TShipment.SetBookingNumber(const Value: string);
begin
  SetStringField('BookingNumber', Value);
end;

procedure TShipment.SetCanceled(const Value: boolean);
begin
  SetBooleanField('Canceled', Value);
end;

procedure TShipment.SetDefaultsForProvider;
begin
  case self.Provider of
    pFedEx:
      begin
        LabelImageType := 1; { PNG }
      end;
    pUPS:
      begin
        LabelImageType := 0; { GIF };
      end;
    pUSPS:
      begin
        LabelImageType := 6; { PNG }
      end;
    pCanadaPost:
      begin
        { not used ? }
      end;
  end;
end;

procedure TShipment.SetDeliveryDate(const Value: TDateTime);
begin
  SetDateTimeField('DeliveryDate', Value);
end;

procedure TShipment.SetDocumentsOnly(const Value: boolean);
begin
  SetBooleanField('DocumentsOnly', Value);
end;

procedure TShipment.SetDropoffType(const Value: integer);
begin
  SetIntegerField('DropoffType', Value);
end;

procedure TShipment.SetEndorsement(const Value: integer);
begin
  SetIntegerField('Endorsement', Value);
end;

procedure TShipment.SetLabelImageType(const Value: integer);
begin
  SetIntegerField('LabelImageType', Value);
end;

procedure TShipment.SetMasterTrackingNumber(const Value: string);
begin
  SetStringField('MasterTrackingNumber', Value);
end;

procedure TShipment.SetMICostCenter(const Value: string);
begin
  SetStringField('MICostCenter', Value);
end;

procedure TShipment.SetMIPackageID(const Value: string);
begin
  SetStringField('MIPackageID', Value);
end;

procedure TShipment.SetPackageIDCode(const Value: string);
begin
  SetStringField('PackageIDCode', Value);
end;

procedure TShipment.SetPayorAccountNumber(const Value: string);
begin
  SetStringField('PayorAccountNumber', Value);
end;

procedure TShipment.SetPayorCountryCode(const Value: string);
begin
  SetStringField('PayorCountryCode', Value);
end;

procedure TShipment.SetPayorType(const Value: TibxezshipPayorTypes);
begin
  SetIntegerField('PayorType', Ord(Value));
end;

procedure TShipment.SetPayorZipCode(const Value: string);
begin
  SetStringField('PayorZipCode', Value);
end;

procedure TShipment.SetPostageProvider(const Value: integer);
begin
  SetIntegerField('PostageProvider', Value);
end;

procedure TShipment.SetProcessed(const Value: boolean);
begin
  SetBooleanField('Processed', Value);
end;

procedure TShipment.SetProcessedComment(const Value: string);
begin
  SetStringField('ProcessedComment', Value);
end;

procedure TShipment.SetProvider(const Value: TibxezshipProviders);
begin
  SetIntegerField('Provider', Ord(Value));
  SetDefaultsForProvider;
end;

//procedure TShipment.SetReceipientAddress(const Value: string);
//begin
//  SetStringField('ReceipientAddress', Value);
//end;

procedure TShipment.SetRecipientAddress1(const Value: string);
begin
  SetStringField('RecipientAddress1', Value);
end;

procedure TShipment.SetRecipientAddress2(const Value: string);
begin
  SetStringField('RecipientAddress2', Value);
end;

procedure TShipment.SetRecipientAddressValid(const Value: boolean);
begin
  SetBooleanField('RecipientAddressValid', Value);
end;

procedure TShipment.SetRecipientCity(const Value: string);
begin
  SetStringField('RecipientCity', Value);
end;

procedure TShipment.SetRecipientCompany(const Value: string);
begin
  SetStringField('RecipientCompany', Value);
end;

procedure TShipment.SetRecipientCountryCode(const Value: string);
begin
  SetStringField('RecipientCountryCode', Value);
end;

procedure TShipment.SetRecipientEmail(const Value: string);
begin
  SetStringField('RecipientEmail', Value);
end;

procedure TShipment.SetRecipientFax(const Value: string);
begin
  SetStringField('RecipientFax', Value);
end;

procedure TShipment.SetRecipientFirstName(const Value: string);
begin
  SetStringField('RecipientFirstName', Value);
end;

procedure TShipment.SetRecipientInitial(const Value: string);
begin
  SetStringField('RecipientInitial', Value);
end;

procedure TShipment.SetRecipientLastName(const Value: string);
begin
  SetStringField('RecipientLastName', Value);
end;

procedure TShipment.SetRecipientPhone(const Value: string);
begin
  SetStringField('RecipientPhone', Value);
end;

procedure TShipment.SetRecipientState(const Value: string);
begin
  SetStringField('RecipientState', Value);
end;

procedure TShipment.SetRecipientZipCode(const Value: string);
begin
  SetStringField('RecipientZipCode', Value);
end;

//procedure TShipment.SetSenderAddress(const Value: string);
//begin
//  SetStringField('SenderAddress', Value);
//end;

procedure TShipment.SetSenderAddress1(const Value: string);
begin
  SetStringField('SenderAddress1', Value);
end;

procedure TShipment.SetSenderAddress2(const Value: string);
begin
  SetStringField('SenderAddress2', Value);
end;

procedure TShipment.SetSenderCity(const Value: string);
begin
  SetStringField('SenderCity', Value);
end;

procedure TShipment.SetSenderCompany(const Value: string);
begin
  SetStringField('SenderCompany', Value);
end;

procedure TShipment.SetSenderCountryCode(const Value: string);
begin
  SetStringField('SenderCountryCode', Value);
end;

procedure TShipment.SetSenderEmail(const Value: string);
begin
  SetStringField('SenderEmail', Value);
end;

procedure TShipment.SetSenderFax(const Value: string);
begin
  SetStringField('SenderFax', Value);
end;

procedure TShipment.SetSenderFirstName(const Value: string);
begin
  SetStringField('SenderFirstName', Value);
end;

procedure TShipment.SetSenderInitial(const Value: string);
begin
  SetStringField('SenderInitial', Value);
end;

procedure TShipment.SetSenderLastName(const Value: string);
begin
  SetStringField('SenderLastName', Value);
end;

procedure TShipment.SetSenderPhone(const Value: string);
begin
  SetStringField('SenderPhone', Value);
end;

procedure TShipment.SetSenderState(const Value: string);
begin
  SetStringField('SenderState', Value);
end;

procedure TShipment.SetSenderZipCode(const Value: string);
begin
  SetStringField('SenderZipCode', Value);
end;

procedure TShipment.SetServiceType(const Value: TibxezshipServiceTypes);
begin
  SetIntegerField('ServiceType', Ord(Value));
end;

procedure TShipment.SetShipAddressId(const Value: integer);
begin
  SetIntegerField('ShipAddressId', Value);
end;

procedure TShipment.SetShipmentListId(const Value: integer);
begin
  SetIntegerField('ShipmentListId', Value)
end;

procedure TShipment.SetShipmentSpecialServices(const Value: int64);
begin
  SetLargeintField('ShipmentSpecialServices', Value);
end;

procedure TShipment.SetShippingDefaults;
var
  qry: TERPQuery;
begin
  qry := self.TempQry(
    'select c.ClientPaysShippment, c.ClientShipperAccountNo, S.shipdate ' +
    ' from tblClients c ' +
    ' inner join tblsales s on s.ClientID = c.ClientID ' +
    ' inner join tblShipmentList sl on sl.SaleID = s.SaleID ' +
    ' where sl.ShipmentListId = ' + IntToStr(self.ShipmentListId));
  try
    qry.Open;
    shipdate := qry.FieldByName('shipdate').asDateTime;
    if qry.FieldByName('ClientShipperAccountNo').AsString <> '' then begin
      if qry.FieldByName('ClientPaysShippment').AsBoolean then begin
        PayorType := ibxezship.ptRecipient;
        PayorAccountNumber := qry.FieldByName('ClientShipperAccountNo').AsString;
      end;
    end;
  finally
    qry.Free;
  end;
end;

function TShipment.ValidateData: Boolean;
begin
  result := false;
  if not inherited ValidateData then exit;

  if (SenderCompany = '') and ((SenderFirstName = '') or (SenderLastName = '')) then begin
    AddResult(false,rssWarning,0,'The Sender details must include a Company name and/or Sender First Name and Sender LastName');
    exit;
  end;
  if (RecipientCompany = '') and ((RecipientFirstName = '') or (RecipientLastName = '')) then begin
    AddResult(false,rssWarning,0,'The Recipient details must include a Company name and/or Sender First Name and Sender LastName');
    exit;
  end;
//  if (Length(SenderAddress1) + Length(SenderAddress2)) > 35 then begin
//    AddResult(false,rssWarning,0,'The combined length of the Sender Address 1 and Address 2 fields must be no greater than 35 characters');
//    exit;
//  end;
//  if (Length(RecipientAddress1) + Length(RecipientAddress2)) > 35 then begin
//    AddResult(false,rssWarning,0,'The combined length of the Recipient Address 1 and Address 2 fields must be no greater than 35 characters');
//    exit;
//  end;
  if SenderCity = '' then begin
    AddResult(false,rssWarning,0,'The Sender City is blank');
    exit;
  end;
  if RecipientCity = '' then begin
    AddResult(false,rssWarning,0,'The Recipient City is blank');
    exit;
  end;
  if SameText(SenderCountryCode,'US') or SameText(SenderCountryCode,'CA') or SameText(SenderCountryCode,'AU') then begin
    if SenderState = '' then begin
      AddResult(false,rssWarning,0,'The Sender State is blank');
      exit;
    end;
  end;
  if SameText(RecipientCountryCode,'US') or SameText(RecipientCountryCode,'CA') or SameText(SenderCountryCode,'AU') then begin
    if RecipientState = '' then begin
      AddResult(false,rssWarning,0,'The Recipient State is blank');
      exit;
    end;
  end;
  if SenderZipCode = '' then begin
    AddResult(false,rssWarning,0,'The Sender Zip/Post Code is blank');
    exit;
  end;
  if RecipientZipCode = '' then begin
    AddResult(false,rssWarning,0,'The Recipient Zip/Post Code is blank');
    exit;
  end;
  if SenderPhone = '' then begin
    AddResult(false,rssWarning,0,'The Sender Phone Number is blank');
    exit;
  end;
  if Length(SenderPhone) > 15 then begin
    AddResult(false,rssWarning,0,'The Sender Phone Number length is greater than the maximum length of 15');
    exit;
  end;
//  if RecipientPhone = '' then begin
//    AddResult(false,rssWarning,0,'The Recipient Phone Number is blank');
//    exit;
//  end;
  if Length(RecipientPhone) > 15 then begin
    AddResult(false,rssWarning,0,'The Recipient Phone Number length is greater than the maximum length of 15');
    exit;
  end;



  if self.Provider = pFedEx then begin

  end
  else if self.Provider = pUPS then begin


  end
  else if self.Provider = pUSPS then begin

  end
  else if self.Provider = pCanadaPost then begin

  end;


  result := true;
end;

function TShipment.GetTotalBaseCharge: double;
begin
  result := GetFloatField('TotalBaseCharge');
end;

function TShipment.GetTotalNetCharge: double;
begin
  result := GetFloatField('TotalNetCharge');
end;

function TShipment.GetTotalNetChargeNegotiated: double;
begin
  result := GetFloatField('TotalNetChargeNegotiated');
end;

function TShipment.GetTotalSurcharges: double;
begin
  result := GetFloatField('TotalSurcharges');
end;

function TShipment.IsFedExInternational: boolean;
begin
  result := false;
  if Provider = pFedEx then begin
    if TibxfedexshipServiceTypes(ServiceType) in [TibxfedexshipServiceTypes.stFedExInternationalPriority,
                                                  TibxfedexshipServiceTypes.stFedExInternationalEconomy,
                                                  TibxfedexshipServiceTypes.stFedExInternationalFirst,
                                                  TibxfedexshipServiceTypes.stFedExInternationalPriorityFreight,
                                                  TibxfedexshipServiceTypes.stFedExInternationalEconomyFreight,
                                                  TibxfedexshipServiceTypes.stFedExEuropeFirstInternationalPriority,
                                                  TibxfedexshipServiceTypes.stFedExInternationalGround ]  then begin
      result := true;
    end;
  end;
end;

procedure TShipment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  XMLToBusObj.XMLToObj(node, self);
end;

procedure TShipment.PopulateRecipientAddress;
var
  Person: TPersonName;

  function FindCountryCode: string;
  begin
    result := '';
    if Trim(ShippingAddress.ShipCountry) <> '' then begin
      if Length(Trim(ShippingAddress.ShipCountry)) = 2 then begin
        result := Trim(ShippingAddress.ShipCountry);
        exit;
      end;
      { else get country code from country name }
      result := TCountries.ShortCodeForCountry(Trim(ShippingAddress.ShipCountry));
    end;
    if result = '' then begin
      { resort to region }
      if Length(AppEnv.RegionalOptions.RegionAbbreviation) = 2 then
        result := AppEnv.RegionalOptions.RegionAbbreviation
      else
        result := TCountries.ShortCodeForCode(AppEnv.RegionalOptions.RegionAbbreviation);
    end;
  end;

begin
  if Trim(ShippingAddress.ContactName) <> '' then begin
    Person := TPersonName.Create(ShippingAddress.ContactName);
    try
      RecipientFirstName := Person.FirstName;
      if Person.MiddleName <> '' then
        RecipientInitial := Person.MiddleName[1]
      else
        RecipientInitial := '';
      RecipientLastName := Person.LastName;
    finally
      Person.Free;
    end;
  end;
  RecipientCompany := ShippingAddress.CompanyName;
  RecipientAddress1 := ShippingAddress.ShipAddress;
  if ShippingAddress.ShipAddress1 <> '' then begin
    RecipientAddress2 := ShippingAddress.ShipAddress1;
    if ShippingAddress.ShipAddress2 <> '' then
      RecipientAddress2 := RecipientAddress2 + ' ' + ShippingAddress.ShipAddress2;
  end
  else
    RecipientAddress2 := '';
  RecipientCity := ShippingAddress.ShipCity;
  RecipientState := ShippingAddress.ShipState;
  RecipientZipCode := ShippingAddress.ShipPostCode;

  RecipientCountryCode := FindCountryCode;

  RecipientEmail := ShippingAddress.Email;
  RecipientPhone := ShippingAddress.Phone;
  RecipientFax := ShippingAddress.Fax;
  RecipientAddressValid := ShippingAddress.AddressValidated;
end;

function TShipment.RecipientAddressAsSingleLine: string;
var
  s: string;

  procedure Add(str: string);
  begin
    if str <> '' then begin
      if s <> '' then s := s + ' ';
      s := s + str;
    end;
  end;

begin
  s:= '';
  Add(RecipientFirstName);
  Add(RecipientInitial);
  Add(RecipientLastName);
  Add(RecipientCompany);
  Add(RecipientAddress1);
  Add(RecipientAddress2);
  Add(RecipientCity);
  Add(RecipientState);
  Add(RecipientZipCode);
  Add(RecipientCountryCode);
  result := s;
end;

procedure TShipment.SetTotalBaseCharge(const Value: double);
begin
  SetFloatField('TotalBaseCharge', Value);
end;

procedure TShipment.SetTotalNetCharge(const Value: double);
begin
  SetFloatField('TotalNetCharge', Value);
end;

procedure TShipment.SetTotalNetChargeNegotiated(const Value: double);
begin
  SetFloatField('TotalNetChargeNegotiated', value);
end;

procedure TShipment.SetTotalSurcharges(const Value: double);
begin
  SetFloatField('TotalSurcharges', Value);
end;

function TShipment.Ship: boolean;
//var
//  Ship: TibxEzShip;
//  Err: TShipperError;
//  msg: string;
//  x: integer;
begin
  PostDb;
  result := false;
  ResultStatus.Clear;
  if self.Processed then begin
    AddResult(false, rssWarning, 0, 'Shipment has already been processed');
    exit;
  end;

  if not Save then
    exit;

  if AppEnv.CompanyPrefs.UPSConfig.LastServerID = '' then begin
    AppEnv.CompanyPrefs.UPSConfig.LastServerID := AppEnv.ServerID;
    AppEnv.CompanyPrefs.UPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
  end;
  if AppEnv.CompanyPrefs.FedExConfig.LastServerID = '' then begin
    AppEnv.CompanyPrefs.FedExConfig.LastServerID := AppEnv.ServerID;
    AppEnv.CompanyPrefs.FedExConfig.Save(CommonDbLib.GetSharedMyDacConnection);
  end;
  if AppEnv.CompanyPrefs.USPSConfig.LastServerID = '' then begin
    AppEnv.CompanyPrefs.USPSConfig.LastServerID := AppEnv.ServerID;
    AppEnv.CompanyPrefs.USPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
  end;

  case Provider of
    pFedEx:
      begin
        if (not AppEnv.CompanyPrefs.FedExConfig.FedExEnabled) or (AppEnv.CompanyPrefs.FedExConfig.LastServerID <> AppEnv.ServerID) then begin
          ProcessedComment := 'FedEx Shipping is disabled in Preferences';
          AddResult(false, rssWarning, 0, ProcessedComment);
          exit;
        end;
        if not DoGetShipmentLables then exit;
      end;
    pUPS:
      begin
        if (not AppEnv.CompanyPrefs.UPSConfig.UPSEnabled) or (AppEnv.CompanyPrefs.UPSConfig.LastServerID <> AppEnv.ServerID) then begin
          ProcessedComment := 'UPS Shipping is disabled in Preferences';
          AddResult(false, rssWarning, 0, ProcessedComment);
          exit;
        end;
        if not DoGetShipmentLables then exit;
      end;
    pUSPS:
      begin
        if (not AppEnv.CompanyPrefs.USPSConfig.USPSEnabled) or (AppEnv.CompanyPrefs.USPSConfig.LastServerID <> AppEnv.ServerID) then begin
          ProcessedComment := 'USPS Shipping is disabled in Preferences';
          AddResult(false, rssWarning, 0, ProcessedComment);
          exit;
        end;
        if not DoGetShipmentLables then
          exit
        else
          Processed := true;
      end;
    //pCanadaPost: ;
    else begin
      ProcessedComment := 'This Provider Type is not supported.';
      AddResult(false,rssWarning,0, ProcessedComment);
      exit;
    end;
  end;

  Processed := true;
  PostDb;
  if Assigned(ShipmentList) then
    ShipmentList.UpdateStatus(ShipmentList)
  else
    TShipmentList.UpdateStatus(self.ShipmentListId, Connection.Connection);
  AddTrackingNumberToSale;
  result := true;
end;

procedure TShipment.UpdateShippingAddress;
var
  s: string;
begin
  if ShippingAddress.Count = 0 then exit;
  { update shipping address from RecipientAddress }
  ShippingAddress.ShipAddress := RecipientAddress1;
  ShippingAddress.ShipAddress1 := RecipientAddress2;
  ShippingAddress.ShipAddress2 := '';
  ShippingAddress.ShipCity := RecipientCity;
  ShippingAddress.ShipState := RecipientState;
  ShippingAddress.ShipPostCode := RecipientZipCode;
  if RecipientCountryCode <> '' then begin
    s := TCountries.CountryForShortCode(RecipientCountryCode);
    if s <> '' then
      ShippingAddress.ShipCountry := s;
  end;
end;

function TShipment.GetShipDate: TDateTime;
begin
  result := GetDateTimeField('ShipDate');
end;

procedure TShipment.SetShipDate(const Value: TDateTime);
begin
  SetDateTimeField('ShipDate', Value);
end;

(*
{ TUPSShipment }

constructor TUPSShipment.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'UPS Shipment';
end;

function TUPSShipment.GetPackageLines: TUPSShipmentPackage;
begin
  result := TUPSShipmentPackage(getContainerComponent(TUPSShipmentPackage,'ShipmentId = ' + IntToStr(Id)));
end;
*)

{ TShipmentPackage }

constructor TShipmentPackage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Shipment Package';
  fSQL := 'SELECT * FROM tblShipmentPackage';
end;

destructor TShipmentPackage.Destroy;
begin

  inherited;
end;

function TShipmentPackage.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TShipment) then begin
    self.ShipmentId := TShipment(Owner).ID;
    { sale reference }
    if TShipment(Owner).Provider = pUPS then begin
      if Assigned(TShipment(Owner).Owner) and (TShipment(Owner).Owner is TShipmentList) and (TShipmentList(TShipment(Owner).Owner).SaleRefNo <> '') then
        PackageReference := 'TN:' + TShipmentList(TShipment(Owner).Owner).SaleRefNo;
      if IsUPSMailInnovations(TShipment(Owner).ServiceType) then
        self.PackageSignatureType := TibxezshipPackageSignatureTypes.stUSPSDeliveryConfirmation;

    end;

    if TShipment(Owner).Provider = pFedEx then begin
      if Assigned(TShipment(Owner).Owner) and (TShipment(Owner).Owner is TShipmentList) and (TShipmentList(TShipment(Owner).Owner).SaleRefNo <> '') then
        PackageReference := 'IN:' + TShipmentList(TShipment(Owner).Owner).SaleRefNo;

    end
    else if TShipment(Owner).Provider = pUSPS then begin
      PackageWeightFrac := '0';
    end;

  end;
  PackageCODType := ibxezship.codtpAny;
  PackageCODAmount := 0;
  PackageWeight := '0';
end;

function TShipmentPackage.DoBeforePost(Sender: TDatasetBusObj): boolean;
begin
  result := inherited;
  if (self.PackageType = TibxezshipTPackagingType.ptNone) and
     (StrToFloatDef(self.PackageWeight,0) = 0) and
     (StrToFloatDef(self.PackageWeightFrac,0) = 0) and
     (self.PackageHeight = 0) and
     (self.PackageLength = 0) and
     (self.PackageWidth = 0) and
     (self.PackageDescription = '') and
     (TShipment(owner).SalesLines.count = 0) then begin
    Cancel;
    Abort;
  end;

end;

procedure TShipmentPackage.DoFieldOnChange(Sender: TField);
begin
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if (Sysutils.SameText(Sender.FieldName, 'PackageCODAmount')) then begin

  end;
end;

class function TShipmentPackage.GetBusObjectTablename: string;
begin
  result := 'tblShipmentPackage';
end;

function TShipmentPackage.GetCommodityDescription: string;
begin
  result := GetStringField('CommodityDescription');
end;

function TShipmentPackage.GetCommodityHarmonizedCode: string;
begin
  result := GetStringField('CommodityHarmonizedCode');
end;

function TShipmentPackage.GetCommodityManufacturer: string;
begin
  result := GetStringField('CommodityManufacturer');
end;

function TShipmentPackage.GetCommodityNumberOfPieces: integer;
begin
  result := GetIntegerField('CommodityNumberOfPieces');
end;

function TShipmentPackage.GetCommodityQuantity: integer;
begin
  result := GetIntegerField('CommodityQuantity');
end;

function TShipmentPackage.GetCommodityQuantityUnit: string;
begin
  result := GetStringField('CommodityQuantityUnit');
end;

function TShipmentPackage.GetCommodityUnitPrice: double;
begin
  result := GetFloatField('CommodityUnitPrice');
end;

function TShipmentPackage.GetCommodityValue: double;
begin
  result := GetFloatField('CommodityValue');
end;

function TShipmentPackage.GetCommodityWeight: string;
begin
  result := GetStringField('CommodityWeight');
end;

class function TShipmentPackage.GetIDField: string;
begin
  result := 'ShipmentPackageId';
end;

function TShipmentPackage.GetPackageBaseCharge: double;
begin
  result := GetFloatField('PackageBaseCharge');
end;

function TShipmentPackage.GetPackageCODAmount: double;
begin
  result := GetFloatField('GetPackageCODAmount');
end;

//function TShipmentPackage.GetPackageCODLabel: string;
//begin
//  result := GetStringField('PackageCODLabel');
//end;

function TShipmentPackage.GetPackageCODType: TibxezshipPackageCODTypes;
begin
  result := TibxezshipPackageCODTypes(GetIntegerField('PackageCODType'));
end;

function TShipmentPackage.GetPackageDangerousGoodsAccessible: boolean;
begin
  result := GetBooleanField('PackageDangerousGoodsAccessible');
end;

function TShipmentPackage.GetPackageDescription: string;
begin
  result := GetStringField('PackageDescription');
end;

function TShipmentPackage.GetPackageHeight: integer;
begin
  result := GetIntegerField('PackageHeight');
end;

function TShipmentPackage.GetPackageInsuredValue: double;
begin
  result := GetFloatField('PackageInsuredValue');
end;

function TShipmentPackage.GetPackageLength: integer;
begin
  result := GetIntegerField('PackageLength');
end;

function TShipmentPackage.GetPackageNetCharge: double;
begin
  result := GetFloatField('PackageNetCharge');
end;

function TShipmentPackage.GetPackageOptAdditionalHandling: boolean;
begin
  result := OptAdditionalHandlingBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptAlcohol: boolean;
begin
  result := OptAlcoholBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptAppointmentDelivery: boolean;
begin
  result := OptAppointmentDeliveryBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptCOD: boolean;
begin
  result := OptCODBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptDangerousGoods: boolean;
begin
  result := OptDangerousGoodsBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptDryIce: boolean;
begin
  result := OptDryIceBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptNonStandardContainer: boolean;
begin
  result := OptNonStandardContainerBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptPriorityAlert: boolean;
begin
  result := OptPriorityAlertBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageOptSignatureOption: boolean;
begin
  result := OptSignatureOptionBit in TIntegerSet(PackageSpecialService);
end;

function TShipmentPackage.GetPackageReference: string;
begin
  result := GetStringField('PackageReference');
end;

function TShipmentPackage.GetPackageReferenceByName(aName: string): string;
var
  list, pair: TStringDynArray;
  x: integer;
begin
  result := '';
  list := SplitString(PackageReference, ';');
  for x := Low(list) to High(list) do begin
    if Pos(LowerCase(aName), Trim(LowerCase(list[x]))) = 1 then begin
      pair := SplitString(Trim(list[x]), ':');
      if High(pair) = 1 then
        result := pair[1];
      exit;
    end;
  end;
end;

function TShipmentPackage.GetPackageReturnRecpt: string;
begin
  result := GetStringField('PackageReturnRecpt');
end;

//function TShipmentPackage.GetPackageShippingLabel: string;
//begin
//  result := GetStringField('PackageShippingLabel');
//end;

function TShipmentPackage.GetPackageSignatureType: TibxezshipPackageSignatureTypes;
begin
  result := TibxezshipPackageSignatureTypes(GetIntegerField('PackageSignatureType'));
end;

function TShipmentPackage.GetPackageSpecialService: integer;
begin
  result := GetIntegerField('PackageSpecialService');
end;

function TShipmentPackage.GetPackageTotalDiscount: double;
begin
  result := GetFloatField('PackageTotalDiscount');
end;

function TShipmentPackage.GetPackageTotalSurcharges: double;
begin
  result := GetFloatField('PackageTotalSurcharges');
end;

function TShipmentPackage.GetPackageTrackingNumber: string;
begin
  result := GetStringField('PackageTrackingNumber');
end;

function TShipmentPackage.GetPackageType: TibxezshipPackageTypes;
begin
  result := TibxezshipPackageTypes(GetIntegerField('PackageType'));
end;

function TShipmentPackage.GetPackageWeight: string;
begin
  result := GetStringField('PackageWeight');
end;

function TShipmentPackage.GetPackageWeightFrac: string;
begin
  result := GetStringField('PackageWeightFrac');
end;

function TShipmentPackage.GetPackageWidth: integer;
begin
  result := GetIntegerField('PackageWidth');
end;

function TShipmentPackage.GetShipmentId: integer;
begin
  result := GetIntegerField('ShipmentId');
end;

procedure TShipmentPackage.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  XMLToBusObj.XMLToObj(node, self);
end;

procedure TShipmentPackage.RemovePackageReferenceByName(aName: string);
var
  list : TStringDynArray;
  x: integer;
  s: string;
begin
  s := '';
  list := SplitString(PackageReference, ';');
  for x := Low(list) to High(list) do begin
    if Pos(LowerCase(aName), Trim(LowerCase(list[x]))) = 1 then begin
      { leave this out }
    end
    else begin
      if s <> '' then s := s + ';';
      s := s + list[x];
    end;
  end;
end;

function TShipmentPackage.Save: Boolean;
begin
  PostDb;
  result := false;
  if not inherited then exit;
  if not ValidateData then exit;
  result := true;
end;

procedure TShipmentPackage.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  XMLToBusObj.ObjToXML(self, node);
end;

function TShipmentPackage.ValidateData: Boolean;
begin
  result := false;
  if not inherited then exit;
  if Trim(PackageWeight) = '' then begin
    AddResult(false,rssWarning,0,'Package weight is missing');
    exit;
  end;
  result := true;
end;

procedure TShipmentPackage.SetCommodityDescription(const Value: string);
begin
  SetStringField('CommodityDescription', Value);
end;

procedure TShipmentPackage.SetCommodityHarmonizedCode(const Value: string);
begin
  SetStringField('CommodityHarmonizedCode', Value);
end;

procedure TShipmentPackage.SetCommodityManufacturer(const Value: string);
begin
  SetStringField('CommodityManufacturer', Value);
end;

procedure TShipmentPackage.SetCommodityNumberOfPieces(const Value: integer);
begin
  SetIntegerField('CommodityNumberOfPieces', Value);
end;

procedure TShipmentPackage.SetCommodityQuantity(const Value: integer);
begin
  SetIntegerField('CommodityQuantity', Value);
end;

procedure TShipmentPackage.SetCommodityQuantityUnit(const Value: string);
begin
  SetStringField('CommodityQuantityUnit', Value);
end;

procedure TShipmentPackage.SetCommodityUnitPrice(const Value: double);
begin
  SetFloatField('CommodityUnitPrice', Value);
end;

procedure TShipmentPackage.SetCommodityValue(const Value: double);
begin
  SetFloatField('CommodityValue', Value);
end;

procedure TShipmentPackage.SetCommodityWeight(const Value: string);
begin
  SetStringField('CommodityWeight', Value);
end;

procedure TShipmentPackage.SetPackageBaseCharge(const Value: double);
begin
  SetFloatField('PackageBaseCharge', Value);
end;

procedure TShipmentPackage.SetPackageCODAmount(const Value: double);
begin
  SetFloatField('PackageCODAmount', Value);
end;

//procedure TShipmentPackage.SetPackageCODLabel(const Value: string);
//begin
//  SetStringField('PackageCODLabel', Value);
//end;

procedure TShipmentPackage.SetPackageCODType(
  const Value: TibxezshipPackageCODTypes);
begin
  SetIntegerField('PackageCODType', Ord(Value));
end;

procedure TShipmentPackage.SetPackageDangerousGoodsAccessible(
  const Value: boolean);
begin
  SetBooleanField('PackageDangerousGoodsAccessible', Value);
end;

procedure TShipmentPackage.SetPackageDescription(const Value: string);
begin
  SetStringField('PackageDescription', Value);
end;

procedure TShipmentPackage.SetPackageHeight(const Value: integer);
begin
  SetIntegerField('PackageHeight', Value);
end;

procedure TShipmentPackage.SetPackageInsuredValue(const Value: double);
begin
  SetFloatField('PackageInsuredValue', Value);
end;

procedure TShipmentPackage.SetPackageLength(const Value: integer);
begin
  SetIntegerField('PackageLength', Value);
end;

procedure TShipmentPackage.SetPackageNetCharge(const Value: double);
begin
  SetFloatField('PackageNetCharge', Value);
end;

procedure TShipmentPackage.SetPackageOptAdditionalHandling(
  const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptAdditionalHandlingBit)
  else
    Exclude(TIntegerSet(pss), OptAdditionalHandlingBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptAlcohol(const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptAlcoholBit)
  else
    Exclude(TIntegerSet(pss), OptAlcoholBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptAppointmentDelivery(
  const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptAppointmentDeliveryBit)
  else
    Exclude(TIntegerSet(pss), OptAppointmentDeliveryBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptCOD(const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptCODBit)
  else
    Exclude(TIntegerSet(pss), OptCODBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptDangerousGoods(const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptDangerousGoodsBit)
  else
    Exclude(TIntegerSet(pss), OptDangerousGoodsBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptDryIce(const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptDryIceBit)
  else
    Exclude(TIntegerSet(pss), OptDryIceBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptNonStandardContainer(
  const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptNonStandardContainerBit)
  else
    Exclude(TIntegerSet(pss), OptNonStandardContainerBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptPriorityAlert(const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptPriorityAlertBit)
  else
    Exclude(TIntegerSet(pss), OptPriorityAlertBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageOptSignatureOption(const Value: boolean);
var
  pss: integer;
begin
  pss := PackageSpecialService;
  if Value then
    Include(TIntegerSet(pss), OptSignatureOptionBit)
  else
    Exclude(TIntegerSet(pss), OptSignatureOptionBit);
  PackageSpecialService := pss;
end;

procedure TShipmentPackage.SetPackageReference(const Value: string);
begin
  SetStringField('PackageReference', Value);
end;

procedure TShipmentPackage.SetPackageReferenceByName(aName: string;
  const Value: string);
var
  list: TStringDynArray;
  x: integer;
  found: boolean;
  s: string;
begin
  found := false;
  list := SplitString(PackageReference, ';');
  for x := Low(list) to High(list) do begin
    if Pos(LowerCase(aName), Trim(LowerCase(list[x]))) = 1 then begin
      list[x] := aName + ':' + Value;
      found := true;
    end;
  end;
  s := '';
  for x := Low(list) to High(list) do begin
    if x > 0 then s := s + ';';
    s := s + list[x];
  end;
  if not found then begin
    if s <> '' then s := s + ';';
    s := s + aName + ':' + Value;
  end;
  PackageReference := s;
end;

procedure TShipmentPackage.SetPackageReturnRecpt(const Value: string);
begin
  SetStringField('PackageReturnRecpt', Value);
end;

//procedure TShipmentPackage.SetPackageShippingLabel(const Value: string);
//begin
//  SetStringField('PackageShippingLabel', Value);
//end;

procedure TShipmentPackage.SetPackageSignatureType(
  const Value: TibxezshipPackageSignatureTypes);
begin
  SetIntegerField('PackageSignatureType', Ord(Value));
end;

procedure TShipmentPackage.SetPackageSpecialService(const Value: integer);
begin
  SetIntegerField('PackageSpecialService', Value);
end;

procedure TShipmentPackage.SetPackageTotalDiscount(const Value: double);
begin
  SetFloatField('PackageTotalDiscount', Value);
end;

procedure TShipmentPackage.SetPackageTotalSurcharges(const Value: double);
begin
  SetFloatField('PackageTotalSurcharges', Value);
end;

procedure TShipmentPackage.SetPackageTrackingNumber(const Value: string);
begin
  SetStringField('PackageTrackingNumber', Value);
end;

procedure TShipmentPackage.SetPackageType(
  const Value: TibxezshipPackageTypes);
begin
  SetIntegerField('PackageType', Ord(Value));
end;


procedure TShipmentPackage.SetPackageWeight(const Value: string);
begin
  SetStringField('PackageWeight', Value);
end;

procedure TShipmentPackage.SetPackageWeightFrac(const Value: string);
begin
  SetStringField('PackageWeightFrac',Value);
end;

procedure TShipmentPackage.SetPackageWidth(const Value: integer);
begin
  SetIntegerField('PackageWidth', Value);
end;

procedure TShipmentPackage.SetShipmentId(const Value: integer);
begin
  SetIntegerField('ShipmentId', Value);
end;

{ TShipmentSaleLine }

constructor TShipmentSaleLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Shipment Sale Line';
  fSQL := 'SELECT * FROM tblShipmentSaleLine';
end;

function TShipmentSaleLine.DefaultWeight: double;
begin
  result := 0;
  if Assigned(Owner) and (Owner is TShipment) then begin
    case TShipment(Owner).ShipperType of
      spNone:;
      spFedEx: result := AppEnv.CompanyPrefs.FedExConfig.DefaultWeight;
      spUPS: result := AppEnv.CompanyPrefs.UPSConfig.DefaultWeight;
      spUSPS: result := AppEnv.CompanyPrefs.USPSConfig.DefaultWeight;
      spCanadaPost:;
      spTNT:;
    end;
  end;
end;

destructor TShipmentSaleLine.Destroy;
begin

  inherited;
end;

function TShipmentSaleLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TShipment) then
    self.ShipmentId := TShipment(Owner).ID;
end;

procedure TShipmentSaleLine.DoFieldOnChange(Sender: TField);
begin
   if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit; // we are only interested in data fields.
  inherited;
  if (Sysutils.SameText(Sender.FieldName, 'UOMQty')) then begin
    { try and populate Package Weight and Dimension data }
    DoUpdatePakageValues;
  end;
end;

procedure TShipmentSaleLine.DoUpdatePakageValues;
var
  totalWeight: double;
  qry: TERPQuery;
  val, divisor: double;
begin
  if (not Assigned(Owner)) or (not (Owner is TShipment)) then exit;
  if TShipment(Owner).Packages.Count > 1 then exit;

  PostDb;
  totalWeight := 0;
  qry := TempQry;
  qry.SQL.Clear;
  qry.SQL.Add('select');
  qry.SQL.Add('tblshipmentsaleline.UOMQty as UOMQty,');
  qry.SQL.Add('tblshipmentsaleline.UOMQty * tblunitsofmeasure.Weight as LineWeight,');
  qry.SQL.Add('tblunitsofmeasure.Width,');
  qry.SQL.Add('tblunitsofmeasure.Length,');
  qry.SQL.Add('tblunitsofmeasure.Height');
  qry.SQL.Add('from tblshipmentsaleline, tblsaleslines, tblunitsofmeasure');
  qry.SQL.Add('where tblshipmentsaleline.ShipmentId = ' + IntToStr(TShipment(Owner).ID));
  qry.SQL.Add('and tblshipmentsaleline.SaleLineId = tblsaleslines.SaleLineID');
  qry.SQL.Add('and tblsaleslines.UnitOfMeasureID = tblunitsofmeasure.UnitID');
  qry.Open;
  while not qry.Eof do begin
    totalWeight := totalWeight + qry.FieldByName('LineWeight').AsFloat;
    qry.Next;
  end;
  if totalWeight > 0 then
    TShipment(Owner).Packages.PackageWeight := FloatToStr(totalWeight)
  else
    TShipment(Owner).Packages.PackageWeight := FloatToStr(DefaultWeight);

  { convert UOM mm's to CM's }
  if (qry.RecordCount = 1) then begin
    if AppEnv.RegionalOptions.RegionType = rUSA then
      divisor := 25.4 // mm to inches
    else
      divisor := 10;  // mm to cm
    if (qry.FieldByName('Width').AsFloat <> 0) then begin
      val := qry.FieldByName('Width').AsFloat / divisor;
      if Frac(val) > 0 then val := val + 1;
      TShipment(Owner).Packages.PackageWidth := Trunc(val);
    end;
    if (qry.FieldByName('Length').AsFloat <> 0) then begin
      val := qry.FieldByName('Length').AsFloat / divisor;
      if Frac(val) > 0 then val := val + 1;
      TShipment(Owner).Packages.PackageLength := Trunc(val);
    end;
    if (qry.FieldByName('Height').AsFloat <> 0) then begin
      val := qry.FieldByName('Height').AsFloat / divisor;
      if Frac(val) > 0 then val := val + 1;
      TShipment(Owner).Packages.PackageHeight := Trunc(val);
    end;
  end;

  try
    TShipment(Owner).Packages.PostDb;
  Except
    // Pakage posting is aborted when its empty
  end;

  qry.Close;
end;

class function TShipmentSaleLine.GetBusObjectTablename: string;
begin
  result := 'tblShipmentSaleLine';
end;

class function TShipmentSaleLine.GetIDField: string;
begin
  result := 'ShipmentSaleLineId';
end;

function TShipmentSaleLine.GetSaleLineId: integer;
begin
  result := GetIntegerField('SaleLineId');
end;

function TShipmentSaleLine.GetShipmentId: integer;
begin
  result := GetIntegerField('ShipmentId');
end;

function TShipmentSaleLine.GetUOMQty: double;
begin
  result := GetFloatField('UOMQty');
end;

procedure TShipmentSaleLine.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  XMLToBusObj.XMLToObj(node, self);
end;

function TShipmentSaleLine.Save: Boolean;
begin
  result := inherited;
end;

procedure TShipmentSaleLine.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TShipmentSaleLine.SetSaleLineId(const Value: integer);
begin
  SetIntegerField('SaleLineId', Value);
end;

procedure TShipmentSaleLine.SetShipmentId(const Value: integer);
begin
  SetIntegerField('ShipmentId', Value);
end;

procedure TShipmentSaleLine.SetUOMQty(const Value: double);
begin
  SetFloatField('UOMQty', Value);
end;

function TShipmentSaleLine.ValidateData: Boolean;
begin
  result := false;
  if ShipmentId = 0 then begin
    AddResult(false,rssWarning,0,'Shipment Id is blank');
    exit;
  end;
  if SaleLineId = 0 then begin
    AddResult(false,rssWarning,0,'Sale Line Id is blank');
    exit;
  end;
  result := true;
end;
  {TSalesShipments}

constructor TSalesShipments.Create(AOwner: TComponent);
begin
  {this is a readonly object linking to sales to get salesId and saleslineId}
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesShipments';
(*  fSQL := 'select  SL.saleID, SL.saleLineId, SH.* '+
          ' from tblsaleslines SL  '+
          ' inner join tblshipmentsaleline SS on SL.SaleLineID = SS.SaleLineId  '+
          ' inner join tblShipment SH on SS.ShipmentId = SH.ShipmentId';*)
  fSQL := 'select '+
          ' SL.SaleID , '+
          ' sh.* '+
          ' from tblShipmentList SL '+
          ' inner join tblShipment SH on SL.ShipmentListId = SH.ShipmentListId ';
  fbIsReadonly:= True;
end;


destructor TSalesShipments.Destroy;
begin
  inherited;
end;


procedure TSalesShipments.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'saleID');
  //SetPropertyFromNode(node,'saleLineId');
  SetPropertyFromNode(node,'ShipmentId');
  SetPropertyFromNode(node,'ShipAddressId');
  SetPropertyFromNode(node,'ShipmentListId');
  SetPropertyFromNode(node,'LabelImageType');
  SetPropertyFromNode(node,'MasterTrackingNumber');
  SetPropertyFromNode(node,'PackageIDCode');
  SetPropertyFromNode(node,'PayorAccountNumber');
  SetPropertyFromNode(node,'PayorCountryCode');
  SetPropertyFromNode(node,'PayorType');
  SetPropertyFromNode(node,'PayorZipCode');
  SetPropertyFromNode(node,'Provider');
  SetPropertyFromNode(node,'PostageProvider');
  SetPropertyFromNode(node,'RecipientFirstName');
  SetPropertyFromNode(node,'RecipientMiddleInitial');
  SetPropertyFromNode(node,'RecipientLastName');
  SetPropertyFromNode(node,'RecipientCompany');
  SetPropertyFromNode(node,'RecipientAddress1');
  SetPropertyFromNode(node,'RecipientAddress2');
  SetPropertyFromNode(node,'RecipientCity');
  SetPropertyFromNode(node,'RecipientState');
  SetPropertyFromNode(node,'RecipientZipCode');
  SetPropertyFromNode(node,'RecipientCountryCode');
  SetPropertyFromNode(node,'RecipientEmail');
  SetPropertyFromNode(node,'RecipientPhone');
  SetPropertyFromNode(node,'RecipientFax');
  SetBooleanPropertyFromNode(node,'RecipientAddressValID');
  SetPropertyFromNode(node,'SenderFirstName');
  SetPropertyFromNode(node,'SenderMiddleInitial');
  SetPropertyFromNode(node,'SenderLastName');
  SetPropertyFromNode(node,'SenderCompany');
  SetPropertyFromNode(node,'SenderAddress1');
  SetPropertyFromNode(node,'SenderAddress2');
  SetPropertyFromNode(node,'SenderCity');
  SetPropertyFromNode(node,'SenderState');
  SetPropertyFromNode(node,'SenderZipCode');
  SetPropertyFromNode(node,'SenderCountryCode');
  SetPropertyFromNode(node,'SenderEmail');
  SetPropertyFromNode(node,'SenderPhone');
  SetPropertyFromNode(node,'SenderFax');
  SetPropertyFromNode(node,'ServiceType');
  SetDateTimePropertyFromNode(node,'ShipDate');
  SetDateTimePropertyFromNode(node,'DeliveryData');
  SetPropertyFromNode(node,'ShipmentSpecialServices');
  SetPropertyFromNode(node,'TotalNetCharge');
  SetPropertyFromNode(node,'TotalBaseCharge');
  SetPropertyFromNode(node,'TotalSurcharges');
  SetPropertyFromNode(node,'TotalNetChargeNegotiated');
  SetPropertyFromNode(node,'MICostCenter');
  SetPropertyFromNode(node,'MIPackageID');
  SetPropertyFromNode(node,'Endorsement');
  SetPropertyFromNode(node,'DropoffType');
  SetBooleanPropertyFromNode(node,'Processed');
  SetPropertyFromNode(node,'ProcessedComment');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TSalesShipments.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'saleID' ,saleID);
  //AddXMLNode(node,'saleLineId' ,saleLineId);
  AddXMLNode(node,'ShipmentId' ,ShipmentId);
  AddXMLNode(node,'ShipAddressId' ,ShipAddressId);
  AddXMLNode(node,'ShipmentListId' ,ShipmentListId);
  AddXMLNode(node,'LabelImageType' ,LabelImageType);
  AddXMLNode(node,'MasterTrackingNumber' ,MasterTrackingNumber);
  AddXMLNode(node,'PackageIDCode' ,PackageIDCode);
  AddXMLNode(node,'PayorAccountNumber' ,PayorAccountNumber);
  AddXMLNode(node,'PayorCountryCode' ,PayorCountryCode);
  AddXMLNode(node,'PayorType' ,PayorType);
  AddXMLNode(node,'PayorZipCode' ,PayorZipCode);
  AddXMLNode(node,'Provider' ,Provider);
  AddXMLNode(node,'PostageProvider' ,PostageProvider);
  AddXMLNode(node,'RecipientFirstName' ,RecipientFirstName);
  AddXMLNode(node,'RecipientMiddleInitial' ,RecipientMiddleInitial);
  AddXMLNode(node,'RecipientLastName' ,RecipientLastName);
  AddXMLNode(node,'RecipientCompany' ,RecipientCompany);
  AddXMLNode(node,'RecipientAddress1' ,RecipientAddress1);
  AddXMLNode(node,'RecipientAddress2' ,RecipientAddress2);
  AddXMLNode(node,'RecipientCity' ,RecipientCity);
  AddXMLNode(node,'RecipientState' ,RecipientState);
  AddXMLNode(node,'RecipientZipCode' ,RecipientZipCode);
  AddXMLNode(node,'RecipientCountryCode' ,RecipientCountryCode);
  AddXMLNode(node,'RecipientEmail' ,RecipientEmail);
  AddXMLNode(node,'RecipientPhone' ,RecipientPhone);
  AddXMLNode(node,'RecipientFax' ,RecipientFax);
  AddXMLNode(node,'RecipientAddressValID' ,RecipientAddressValID);
  AddXMLNode(node,'SenderFirstName' ,SenderFirstName);
  AddXMLNode(node,'SenderMiddleInitial' ,SenderMiddleInitial);
  AddXMLNode(node,'SenderLastName' ,SenderLastName);
  AddXMLNode(node,'SenderCompany' ,SenderCompany);
  AddXMLNode(node,'SenderAddress1' ,SenderAddress1);
  AddXMLNode(node,'SenderAddress2' ,SenderAddress2);
  AddXMLNode(node,'SenderCity' ,SenderCity);
  AddXMLNode(node,'SenderState' ,SenderState);
  AddXMLNode(node,'SenderZipCode' ,SenderZipCode);
  AddXMLNode(node,'SenderCountryCode' ,SenderCountryCode);
  AddXMLNode(node,'SenderEmail' ,SenderEmail);
  AddXMLNode(node,'SenderPhone' ,SenderPhone);
  AddXMLNode(node,'SenderFax' ,SenderFax);
  AddXMLNode(node,'ServiceType' ,ServiceType);
  AddXMLNode(node,'ShipDate' ,ShipDate);
  AddXMLNode(node,'DeliveryData' ,DeliveryData);
  AddXMLNode(node,'ShipmentSpecialServices' ,ShipmentSpecialServices);
  AddXMLNode(node,'TotalNetCharge' ,TotalNetCharge);
  AddXMLNode(node,'TotalBaseCharge' ,TotalBaseCharge);
  AddXMLNode(node,'TotalSurcharges' ,TotalSurcharges);
  AddXMLNode(node,'TotalNetChargeNegotiated' ,TotalNetChargeNegotiated);
  AddXMLNode(node,'MICostCenter' ,MICostCenter);
  AddXMLNode(node,'MIPackageID' ,MIPackageID);
  AddXMLNode(node,'Endorsement' ,Endorsement);
  AddXMLNode(node,'DropoffType' ,DropoffType);
  AddXMLNode(node,'Processed' ,Processed);
  AddXMLNode(node,'ProcessedComment' ,ProcessedComment);
  AddXMLNode(node,'Active' ,Active);
end;


function TSalesShipments.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TSalesShipments.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesShipments.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesShipments.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TSalesShipments.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesShipments.GetIDField: string;
begin
  Result := 'ID'
end;


function TSalesShipments.GetBookingNumber: string;
begin
  result := GetStringField('BookingNumber');
end;

class function TSalesShipments.GetBusObjectTablename: string;
begin
  Result:= 'tbltblshipmentsaleline';
end;


function TSalesShipments.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TSalesShipments.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;
function TSalesShipments.getProviderName: String;
begin
  try
    result := ShipProviderList[Provider].Name;
  Except
    on E:Exception do begin
      result := ShipProviderList[0].Name;
    end;
  end;
end;

{Property Functions}
function  TSalesShipments.GetsaleID                  : Integer   ; begin Result := GetIntegerField('saleID');end;
//function  TSalesShipments.GetsaleLineId              : Integer   ; begin Result := GetIntegerField('saleLineId');end;
function  TSalesShipments.GetShipmentId              : Integer   ; begin Result := GetIntegerField('ShipmentId');end;
function  TSalesShipments.GetShipAddressId           : Integer   ; begin Result := GetIntegerField('ShipAddressId');end;
function  TSalesShipments.GetShipmentListId          : Integer   ; begin Result := GetIntegerField('ShipmentListId');end;
function  TSalesShipments.GetLabelImageType          : Integer   ; begin Result := GetIntegerField('LabelImageType');end;
function  TSalesShipments.GetMasterTrackingNumber    : string    ; begin Result := GetStringField('MasterTrackingNumber');end;
function  TSalesShipments.GetPackageIDCode           : string    ; begin Result := GetStringField('PackageIDCode');end;
function  TSalesShipments.GetPayorAccountNumber      : string    ; begin Result := GetStringField('PayorAccountNumber');end;
function  TSalesShipments.GetPayorCountryCode        : string    ; begin Result := GetStringField('PayorCountryCode');end;
function  TSalesShipments.GetPayorType               : Integer   ; begin Result := GetIntegerField('PayorType');end;
function  TSalesShipments.GetPayorZipCode            : string    ; begin Result := GetStringField('PayorZipCode');end;
function  TSalesShipments.GetProvider                : Integer   ; begin Result := GetIntegerField('Provider');end;
function  TSalesShipments.GetPostageProvider         : Integer   ; begin Result := GetIntegerField('PostageProvider');end;
function  TSalesShipments.GetRecipientFirstName      : string    ; begin Result := GetStringField('RecipientFirstName');end;
function  TSalesShipments.GetRecipientMiddleInitial  : string    ; begin Result := GetStringField('RecipientMiddleInitial');end;
function  TSalesShipments.GetRecipientLastName       : string    ; begin Result := GetStringField('RecipientLastName');end;
function  TSalesShipments.GetRecipientCompany        : string    ; begin Result := GetStringField('RecipientCompany');end;
function  TSalesShipments.GetRecipientAddress1       : string    ; begin Result := GetStringField('RecipientAddress1');end;
function  TSalesShipments.GetRecipientAddress2       : string    ; begin Result := GetStringField('RecipientAddress2');end;
function  TSalesShipments.GetRecipientCity           : string    ; begin Result := GetStringField('RecipientCity');end;
function  TSalesShipments.GetRecipientState          : string    ; begin Result := GetStringField('RecipientState');end;
function  TSalesShipments.GetRecipientZipCode        : string    ; begin Result := GetStringField('RecipientZipCode');end;
function  TSalesShipments.GetRecipientCountryCode    : string    ; begin Result := GetStringField('RecipientCountryCode');end;
function  TSalesShipments.GetRecipientEmail          : string    ; begin Result := GetStringField('RecipientEmail');end;
function  TSalesShipments.GetRecipientPhone          : string    ; begin Result := GetStringField('RecipientPhone');end;
function  TSalesShipments.GetRecipientFax            : string    ; begin Result := GetStringField('RecipientFax');end;
function  TSalesShipments.GetRecipientAddressValID   : Boolean   ; begin Result := GetBooleanField('RecipientAddressValID');end;
function  TSalesShipments.GetSenderFirstName         : string    ; begin Result := GetStringField('SenderFirstName');end;
function  TSalesShipments.GetSenderMiddleInitial     : string    ; begin Result := GetStringField('SenderMiddleInitial');end;
function  TSalesShipments.GetSenderLastName          : string    ; begin Result := GetStringField('SenderLastName');end;
function  TSalesShipments.GetSenderCompany           : string    ; begin Result := GetStringField('SenderCompany');end;
function  TSalesShipments.GetSenderAddress1          : string    ; begin Result := GetStringField('SenderAddress1');end;
function  TSalesShipments.GetSenderAddress2          : string    ; begin Result := GetStringField('SenderAddress2');end;
function  TSalesShipments.GetSenderCity              : string    ; begin Result := GetStringField('SenderCity');end;
function  TSalesShipments.GetSenderState             : string    ; begin Result := GetStringField('SenderState');end;
function  TSalesShipments.GetSenderZipCode           : string    ; begin Result := GetStringField('SenderZipCode');end;
function  TSalesShipments.GetSenderCountryCode       : string    ; begin Result := GetStringField('SenderCountryCode');end;
function  TSalesShipments.GetSenderEmail             : string    ; begin Result := GetStringField('SenderEmail');end;
function  TSalesShipments.GetSenderPhone             : string    ; begin Result := GetStringField('SenderPhone');end;
function  TSalesShipments.GetSenderFax               : string    ; begin Result := GetStringField('SenderFax');end;
function  TSalesShipments.GetServiceType             : Integer   ; begin Result := GetIntegerField('ServiceType');end;
function  TSalesShipments.GetShipDate                : TDateTime ; begin Result := GetDateTimeField('ShipDate');end;
function  TSalesShipments.GetDeliveryData            : TDateTime ; begin Result := GetDateTimeField('DeliveryData');end;
function TSalesShipments.GetDocumentsOnly: boolean;
begin
  result := GetBooleanField('DocumentsOnly');
end;

function  TSalesShipments.GetShipmentSpecialServices : Integer   ; begin Result := GetIntegerField('ShipmentSpecialServices');end;
function  TSalesShipments.GetTotalNetCharge          : Double    ; begin Result := GetFloatField('TotalNetCharge');end;
function  TSalesShipments.GetTotalBaseCharge         : Double    ; begin Result := GetFloatField('TotalBaseCharge');end;
function  TSalesShipments.GetTotalSurcharges         : Double    ; begin Result := GetFloatField('TotalSurcharges');end;
function  TSalesShipments.GetTotalNetChargeNegotiated: Double    ; begin Result := GetFloatField('TotalNetChargeNegotiated');end;
function  TSalesShipments.GetMICostCenter            : string    ; begin Result := GetStringField('MICostCenter');end;
function  TSalesShipments.GetMIPackageID             : string    ; begin Result := GetStringField('MIPackageID');end;
function  TSalesShipments.GetEndorsement             : Integer   ; begin Result := GetIntegerField('Endorsement');end;
function  TSalesShipments.GetDropoffType             : Integer   ; begin Result := GetIntegerField('DropoffType');end;
function  TSalesShipments.GetProcessed               : Boolean   ; begin Result := GetBooleanField('Processed');end;
function  TSalesShipments.GetProcessedComment        : string    ; begin Result := GetStringField('ProcessedComment');end;
function  TSalesShipments.GetActive                  : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TSalesShipments.SetsaleID                  (const Value: Integer   ); begin SetIntegerField('saleID'                   , Value);end;
//procedure TSalesShipments.SetsaleLineId              (const Value: Integer   ); begin SetIntegerField('saleLineId'               , Value);end;
procedure TSalesShipments.SetShipmentId              (const Value: Integer   ); begin SetIntegerField('ShipmentId'               , Value);end;
procedure TSalesShipments.SetShipAddressId           (const Value: Integer   ); begin SetIntegerField('ShipAddressId'            , Value);end;
procedure TSalesShipments.SetShipmentListId          (const Value: Integer   ); begin SetIntegerField('ShipmentListId'           , Value);end;
procedure TSalesShipments.SetLabelImageType          (const Value: Integer   ); begin SetIntegerField('LabelImageType'           , Value);end;
procedure TSalesShipments.SetMasterTrackingNumber    (const Value: string    ); begin SetStringField('MasterTrackingNumber'     , Value);end;
procedure TSalesShipments.SetPackageIDCode           (const Value: string    ); begin SetStringField('PackageIDCode'            , Value);end;
procedure TSalesShipments.SetPayorAccountNumber      (const Value: string    ); begin SetStringField('PayorAccountNumber'       , Value);end;
procedure TSalesShipments.SetPayorCountryCode        (const Value: string    ); begin SetStringField('PayorCountryCode'         , Value);end;
procedure TSalesShipments.SetPayorType               (const Value: Integer   ); begin SetIntegerField('PayorType'                , Value);end;
procedure TSalesShipments.SetPayorZipCode            (const Value: string    ); begin SetStringField('PayorZipCode'             , Value);end;
procedure TSalesShipments.SetProvider                (const Value: Integer   ); begin SetIntegerField('Provider'                 , Value);end;
procedure TSalesShipments.SetPostageProvider         (const Value: Integer   ); begin SetIntegerField('PostageProvider'          , Value);end;
procedure TSalesShipments.SetRecipientFirstName      (const Value: string    ); begin SetStringField('RecipientFirstName'       , Value);end;
procedure TSalesShipments.SetRecipientMiddleInitial  (const Value: string    ); begin SetStringField('RecipientMiddleInitial'   , Value);end;
procedure TSalesShipments.SetRecipientLastName       (const Value: string    ); begin SetStringField('RecipientLastName'        , Value);end;
procedure TSalesShipments.SetRecipientCompany        (const Value: string    ); begin SetStringField('RecipientCompany'         , Value);end;
procedure TSalesShipments.SetRecipientAddress1       (const Value: string    ); begin SetStringField('RecipientAddress1'        , Value);end;
procedure TSalesShipments.SetRecipientAddress2       (const Value: string    ); begin SetStringField('RecipientAddress2'        , Value);end;
procedure TSalesShipments.SetRecipientCity           (const Value: string    ); begin SetStringField('RecipientCity'            , Value);end;
procedure TSalesShipments.SetRecipientState          (const Value: string    ); begin SetStringField('RecipientState'           , Value);end;
procedure TSalesShipments.SetRecipientZipCode        (const Value: string    ); begin SetStringField('RecipientZipCode'         , Value);end;
procedure TSalesShipments.SetRecipientCountryCode    (const Value: string    ); begin SetStringField('RecipientCountryCode'     , Value);end;
procedure TSalesShipments.SetRecipientEmail          (const Value: string    ); begin SetStringField('RecipientEmail'           , Value);end;
procedure TSalesShipments.SetRecipientPhone          (const Value: string    ); begin SetStringField('RecipientPhone'           , Value);end;
procedure TSalesShipments.SetRecipientFax            (const Value: string    ); begin SetStringField('RecipientFax'             , Value);end;
procedure TSalesShipments.SetRecipientAddressValID   (const Value: Boolean   ); begin SetBooleanField('RecipientAddressValID'    , Value);end;
procedure TSalesShipments.SetSenderFirstName         (const Value: string    ); begin SetStringField('SenderFirstName'          , Value);end;
procedure TSalesShipments.SetSenderMiddleInitial     (const Value: string    ); begin SetStringField('SenderMiddleInitial'      , Value);end;
procedure TSalesShipments.SetSenderLastName          (const Value: string    ); begin SetStringField('SenderLastName'           , Value);end;
procedure TSalesShipments.SetSenderCompany           (const Value: string    ); begin SetStringField('SenderCompany'            , Value);end;
procedure TSalesShipments.SetSenderAddress1          (const Value: string    ); begin SetStringField('SenderAddress1'           , Value);end;
procedure TSalesShipments.SetSenderAddress2          (const Value: string    ); begin SetStringField('SenderAddress2'           , Value);end;
procedure TSalesShipments.SetSenderCity              (const Value: string    ); begin SetStringField('SenderCity'               , Value);end;
procedure TSalesShipments.SetSenderState             (const Value: string    ); begin SetStringField('SenderState'              , Value);end;
procedure TSalesShipments.SetSenderZipCode           (const Value: string    ); begin SetStringField('SenderZipCode'            , Value);end;
procedure TSalesShipments.SetSenderCountryCode       (const Value: string    ); begin SetStringField('SenderCountryCode'        , Value);end;
procedure TSalesShipments.SetSenderEmail             (const Value: string    ); begin SetStringField('SenderEmail'              , Value);end;
procedure TSalesShipments.SetSenderPhone             (const Value: string    ); begin SetStringField('SenderPhone'              , Value);end;
procedure TSalesShipments.SetSenderFax               (const Value: string    ); begin SetStringField('SenderFax'                , Value);end;
procedure TSalesShipments.SetServiceType             (const Value: Integer   ); begin SetIntegerField('ServiceType'              , Value);end;
procedure TSalesShipments.SetShipDate                (const Value: TDateTime ); begin SetDateTimeField('ShipDate'                 , Value);end;
procedure TSalesShipments.SetDeliveryData            (const Value: TDateTime ); begin SetDateTimeField('DeliveryData'             , Value);end;
procedure TSalesShipments.SetDocumentsOnly(const Value: boolean);
begin
  SetBooleanField('DocumentsOnly', Value);
end;

procedure TSalesShipments.SetShipmentSpecialServices (const Value: Integer   ); begin SetIntegerField('ShipmentSpecialServices' , Value);end;
procedure TSalesShipments.SetTotalNetCharge          (const Value: Double    ); begin SetFloatField('TotalNetCharge'           , Value);end;
procedure TSalesShipments.SetTotalBaseCharge         (const Value: Double    ); begin SetFloatField('TotalBaseCharge'          , Value);end;
procedure TSalesShipments.SetTotalSurcharges         (const Value: Double    ); begin SetFloatField('TotalSurcharges'          , Value);end;

class function TSalesShipments.ShipmentExistsForSale(aSaleID: integer): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select count(*) as ShipCount');
    qry.SQL.Add('from tblshipmentlist sl');
    qry.SQL.Add('inner join tblShipment s on s.ShipmentLIstId = sl.ShipmentLIstId and s.Active = "T" and s.Canceled = "F"');
    qry.SQL.Add('where sl.SaleID = ' + IntToStr(aSaleID));
    qry.SQL.Add('and sl.Active = "T"');
    qry.Open;
    qry.Open;
    result := qry.FieldByName('ShipCount').AsInteger > 0;
  finally
    qry.Free;
  end;
end;

procedure TSalesShipments.SetTotalNetChargeNegotiated(const Value: Double    ); begin SetFloatField('TotalNetChargeNegotiated' , Value);end;
procedure TSalesShipments.SetMICostCenter            (const Value: string    ); begin SetStringField('MICostCenter'             , Value);end;
procedure TSalesShipments.SetMIPackageID             (const Value: string    ); begin SetStringField('MIPackageID'              , Value);end;
procedure TSalesShipments.SetEndorsement             (const Value: Integer   ); begin SetIntegerField('Endorsement'              , Value);end;
procedure TSalesShipments.SetDropoffType             (const Value: Integer   ); begin SetIntegerField('DropoffType'              , Value);end;
procedure TSalesShipments.SetProcessed               (const Value: Boolean   ); begin SetBooleanField('Processed'                , Value);end;
procedure TSalesShipments.SetProcessedComment        (const Value: string    ); begin SetStringField('ProcessedComment'         , Value);end;
procedure TSalesShipments.SetActive                  (const Value: Boolean   ); begin SetBooleanField('Active'                   , Value);end;


procedure TSalesShipments.SetBookingNumber(const Value: string);
begin
  SetStringField('BookingNumber', Value);
end;

initialization
  classes.RegisterClass(TSalesShipments);
end.
