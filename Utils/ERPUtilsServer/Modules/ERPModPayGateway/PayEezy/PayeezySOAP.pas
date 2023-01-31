// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://api.globalgatewaye4.firstdata.com/transaction/v24/wsdl
//  >Import : https://api.globalgatewaye4.firstdata.com/transaction/v24/wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (11/12/2017 9:44:01 AM - - $Rev: 90173 $)
// ************************************************************************ //

unit PayeezySOAP;

interface

uses
  {$IfDef VER220}
  InvokeRegistry,
  SOAPHTTPClient,
  Types,
  XSBuiltIns
  {$Else}
  Soap.InvokeRegistry,
  Soap.SOAPHTTPClient,
  System.Types,
  Soap.XSBuiltIns
  {$endif}
  ;


const
  IS_OPTN = $0001;
  IS_UNBD = $0002;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  SoftDescriptor_Type  = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  Level3_ShipToAddress_Type = class;            { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  DynamicPricing       = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  VisaCheckout         = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  ForeignCurrencyDetails = class;               { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  MasterPass           = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  Level3_LineItem_Type = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  CheckTransaction     = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  CheckTransactionResult = class;               { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  Transaction          = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  TransactionResult    = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  Address_Type         = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  DynamicCurrency      = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  Level3_Type          = class;                 { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }
  PaypalTransactionDetails = class;             { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblCplx] }

  Array_Of_Level3_LineItem_Type = array of Level3_LineItem_Type;   { "http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes"[GblUbnd] }


  // ************************************************************************ //
  // XML       : SoftDescriptor_Type, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  SoftDescriptor_Type = class(TRemotable)
  private
    FDBAName: string;
    FDBAName_Specified: boolean;
    FStreet: string;
    FStreet_Specified: boolean;
    FCity: string;
    FCity_Specified: boolean;
    FRegion: string;
    FRegion_Specified: boolean;
    FPostalCode: string;
    FPostalCode_Specified: boolean;
    FCountryCode: string;
    FCountryCode_Specified: boolean;
    FMID: string;
    FMID_Specified: boolean;
    FMCC: string;
    FMCC_Specified: boolean;
    FMerchantContactInfo: string;
    FMerchantContactInfo_Specified: boolean;
    FMVV_MAID: string;
    FMVV_MAID_Specified: boolean;
    FAMEXMerchantPhone: string;
    FAMEXMerchantPhone_Specified: boolean;
    FAMEXMerchantEmail: string;
    FAMEXMerchantEmail_Specified: boolean;
    FPFacSubmerchantId: string;
    FPFacSubmerchantId_Specified: boolean;
    FPFacName: string;
    FPFacName_Specified: boolean;
    procedure SetDBAName(Index: Integer; const Astring: string);
    function  DBAName_Specified(Index: Integer): boolean;
    procedure SetStreet(Index: Integer; const Astring: string);
    function  Street_Specified(Index: Integer): boolean;
    procedure SetCity(Index: Integer; const Astring: string);
    function  City_Specified(Index: Integer): boolean;
    procedure SetRegion(Index: Integer; const Astring: string);
    function  Region_Specified(Index: Integer): boolean;
    procedure SetPostalCode(Index: Integer; const Astring: string);
    function  PostalCode_Specified(Index: Integer): boolean;
    procedure SetCountryCode(Index: Integer; const Astring: string);
    function  CountryCode_Specified(Index: Integer): boolean;
    procedure SetMID(Index: Integer; const Astring: string);
    function  MID_Specified(Index: Integer): boolean;
    procedure SetMCC(Index: Integer; const Astring: string);
    function  MCC_Specified(Index: Integer): boolean;
    procedure SetMerchantContactInfo(Index: Integer; const Astring: string);
    function  MerchantContactInfo_Specified(Index: Integer): boolean;
    procedure SetMVV_MAID(Index: Integer; const Astring: string);
    function  MVV_MAID_Specified(Index: Integer): boolean;
    procedure SetAMEXMerchantPhone(Index: Integer; const Astring: string);
    function  AMEXMerchantPhone_Specified(Index: Integer): boolean;
    procedure SetAMEXMerchantEmail(Index: Integer; const Astring: string);
    function  AMEXMerchantEmail_Specified(Index: Integer): boolean;
    procedure SetPFacSubmerchantId(Index: Integer; const Astring: string);
    function  PFacSubmerchantId_Specified(Index: Integer): boolean;
    procedure SetPFacName(Index: Integer; const Astring: string);
    function  PFacName_Specified(Index: Integer): boolean;
  published
    property DBAName:             string  Index (IS_OPTN) read FDBAName write SetDBAName stored DBAName_Specified;
    property Street:              string  Index (IS_OPTN) read FStreet write SetStreet stored Street_Specified;
    property City:                string  Index (IS_OPTN) read FCity write SetCity stored City_Specified;
    property Region:              string  Index (IS_OPTN) read FRegion write SetRegion stored Region_Specified;
    property PostalCode:          string  Index (IS_OPTN) read FPostalCode write SetPostalCode stored PostalCode_Specified;
    property CountryCode:         string  Index (IS_OPTN) read FCountryCode write SetCountryCode stored CountryCode_Specified;
    property MID:                 string  Index (IS_OPTN) read FMID write SetMID stored MID_Specified;
    property MCC:                 string  Index (IS_OPTN) read FMCC write SetMCC stored MCC_Specified;
    property MerchantContactInfo: string  Index (IS_OPTN) read FMerchantContactInfo write SetMerchantContactInfo stored MerchantContactInfo_Specified;
    property MVV_MAID:            string  Index (IS_OPTN) read FMVV_MAID write SetMVV_MAID stored MVV_MAID_Specified;
    property AMEXMerchantPhone:   string  Index (IS_OPTN) read FAMEXMerchantPhone write SetAMEXMerchantPhone stored AMEXMerchantPhone_Specified;
    property AMEXMerchantEmail:   string  Index (IS_OPTN) read FAMEXMerchantEmail write SetAMEXMerchantEmail stored AMEXMerchantEmail_Specified;
    property PFacSubmerchantId:   string  Index (IS_OPTN) read FPFacSubmerchantId write SetPFacSubmerchantId stored PFacSubmerchantId_Specified;
    property PFacName:            string  Index (IS_OPTN) read FPFacName write SetPFacName stored PFacName_Specified;
  end;



  // ************************************************************************ //
  // XML       : Level3_ShipToAddress_Type, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  Level3_ShipToAddress_Type = class(TRemotable)
  private
    FAddress1: string;
    FAddress1_Specified: boolean;
    FCity: string;
    FCity_Specified: boolean;
    FState: string;
    FState_Specified: boolean;
    FCountry: string;
    FCountry_Specified: boolean;
    FCustomerNumber: string;
    FCustomerNumber_Specified: boolean;
    FEmail: string;
    FEmail_Specified: boolean;
    FPhone: string;
    FPhone_Specified: boolean;
    FName_: string;
    FName__Specified: boolean;
    FZip: string;
    FZip_Specified: boolean;
    procedure SetAddress1(Index: Integer; const Astring: string);
    function  Address1_Specified(Index: Integer): boolean;
    procedure SetCity(Index: Integer; const Astring: string);
    function  City_Specified(Index: Integer): boolean;
    procedure SetState(Index: Integer; const Astring: string);
    function  State_Specified(Index: Integer): boolean;
    procedure SetCountry(Index: Integer; const Astring: string);
    function  Country_Specified(Index: Integer): boolean;
    procedure SetCustomerNumber(Index: Integer; const Astring: string);
    function  CustomerNumber_Specified(Index: Integer): boolean;
    procedure SetEmail(Index: Integer; const Astring: string);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetPhone(Index: Integer; const Astring: string);
    function  Phone_Specified(Index: Integer): boolean;
    procedure SetName_(Index: Integer; const Astring: string);
    function  Name__Specified(Index: Integer): boolean;
    procedure SetZip(Index: Integer; const Astring: string);
    function  Zip_Specified(Index: Integer): boolean;
  published
    property Address1:       string  Index (IS_OPTN) read FAddress1 write SetAddress1 stored Address1_Specified;
    property City:           string  Index (IS_OPTN) read FCity write SetCity stored City_Specified;
    property State:          string  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Country:        string  Index (IS_OPTN) read FCountry write SetCountry stored Country_Specified;
    property CustomerNumber: string  Index (IS_OPTN) read FCustomerNumber write SetCustomerNumber stored CustomerNumber_Specified;
    property Email:          string  Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property Phone:          string  Index (IS_OPTN) read FPhone write SetPhone stored Phone_Specified;
    property Name_:          string  Index (IS_OPTN) read FName_ write SetName_ stored Name__Specified;
    property Zip:            string  Index (IS_OPTN) read FZip write SetZip stored Zip_Specified;
  end;



  // ************************************************************************ //
  // XML       : DynamicPricing, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  DynamicPricing = class(TRemotable)
  private
    FOptedIn: string;
    FRateResponseSignature: string;
    FRateResponseSignature_Specified: boolean;
    procedure SetRateResponseSignature(Index: Integer; const Astring: string);
    function  RateResponseSignature_Specified(Index: Integer): boolean;
  published
    property OptedIn:               string  read FOptedIn write FOptedIn;
    property RateResponseSignature: string  Index (IS_OPTN) read FRateResponseSignature write SetRateResponseSignature stored RateResponseSignature_Specified;
  end;



  // ************************************************************************ //
  // XML       : VisaCheckout, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  VisaCheckout = class(TRemotable)
  private
    FCallID: string;
    FPromoCode: string;
    FPromoCode_Specified: boolean;
    procedure SetPromoCode(Index: Integer; const Astring: string);
    function  PromoCode_Specified(Index: Integer): boolean;
  published
    property CallID:    string  read FCallID write FCallID;
    property PromoCode: string  Index (IS_OPTN) read FPromoCode write SetPromoCode stored PromoCode_Specified;
  end;



  // ************************************************************************ //
  // XML       : ForeignCurrencyDetails, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  ForeignCurrencyDetails = class(TRemotable)
  private
    FDCCIndicator: string;
    FForeignAmount: string;
    FForeignAmount_Specified: boolean;
    FForeignCurrencyCode: string;
    FForeignCurrencyCode_Specified: boolean;
    FExchangeRate: string;
    FExchangeRate_Specified: boolean;
    FMarginRate: string;
    FMarginRate_Specified: boolean;
    FRateSource: string;
    FRateSource_Specified: boolean;
    procedure SetForeignAmount(Index: Integer; const Astring: string);
    function  ForeignAmount_Specified(Index: Integer): boolean;
    procedure SetForeignCurrencyCode(Index: Integer; const Astring: string);
    function  ForeignCurrencyCode_Specified(Index: Integer): boolean;
    procedure SetExchangeRate(Index: Integer; const Astring: string);
    function  ExchangeRate_Specified(Index: Integer): boolean;
    procedure SetMarginRate(Index: Integer; const Astring: string);
    function  MarginRate_Specified(Index: Integer): boolean;
    procedure SetRateSource(Index: Integer; const Astring: string);
    function  RateSource_Specified(Index: Integer): boolean;
  published
    property DCCIndicator:        string  read FDCCIndicator write FDCCIndicator;
    property ForeignAmount:       string  Index (IS_OPTN) read FForeignAmount write SetForeignAmount stored ForeignAmount_Specified;
    property ForeignCurrencyCode: string  Index (IS_OPTN) read FForeignCurrencyCode write SetForeignCurrencyCode stored ForeignCurrencyCode_Specified;
    property ExchangeRate:        string  Index (IS_OPTN) read FExchangeRate write SetExchangeRate stored ExchangeRate_Specified;
    property MarginRate:          string  Index (IS_OPTN) read FMarginRate write SetMarginRate stored MarginRate_Specified;
    property RateSource:          string  Index (IS_OPTN) read FRateSource write SetRateSource stored RateSource_Specified;
  end;



  // ************************************************************************ //
  // XML       : MasterPass, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  MasterPass = class(TRemotable)
  private
    FTransactionID: string;
    FWalletID: string;
    FIndicator: string;
  published
    property TransactionID: string  read FTransactionID write FTransactionID;
    property WalletID:      string  read FWalletID write FWalletID;
    property Indicator:     string  read FIndicator write FIndicator;
  end;



  // ************************************************************************ //
  // XML       : Level3_LineItem_Type, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  Level3_LineItem_Type = class(TRemotable)
  private
    FCommodityCode: string;
    FCommodityCode_Specified: boolean;
    FDescription: string;
    FDiscountAmount: string;
    FDiscountAmount_Specified: boolean;
    FDiscountIndicator: Boolean;
    FDiscountIndicator_Specified: boolean;
    FGrossNetIndicator: Boolean;
    FGrossNetIndicator_Specified: boolean;
    FLineItemTotal: string;
    FProductCode: string;
    FProductCode_Specified: boolean;
    FQuantity: string;
    FTaxAmount: string;
    FTaxAmount_Specified: boolean;
    FTaxRate: string;
    FTaxRate_Specified: boolean;
    FTaxType: string;
    FTaxType_Specified: boolean;
    FUnitCost: string;
    FUnitOfMeasure: string;
    FUnitOfMeasure_Specified: boolean;
    procedure SetCommodityCode(Index: Integer; const Astring: string);
    function  CommodityCode_Specified(Index: Integer): boolean;
    procedure SetDiscountAmount(Index: Integer; const Astring: string);
    function  DiscountAmount_Specified(Index: Integer): boolean;
    procedure SetDiscountIndicator(Index: Integer; const ABoolean: Boolean);
    function  DiscountIndicator_Specified(Index: Integer): boolean;
    procedure SetGrossNetIndicator(Index: Integer; const ABoolean: Boolean);
    function  GrossNetIndicator_Specified(Index: Integer): boolean;
    procedure SetProductCode(Index: Integer; const Astring: string);
    function  ProductCode_Specified(Index: Integer): boolean;
    procedure SetTaxAmount(Index: Integer; const Astring: string);
    function  TaxAmount_Specified(Index: Integer): boolean;
    procedure SetTaxRate(Index: Integer; const Astring: string);
    function  TaxRate_Specified(Index: Integer): boolean;
    procedure SetTaxType(Index: Integer; const Astring: string);
    function  TaxType_Specified(Index: Integer): boolean;
    procedure SetUnitOfMeasure(Index: Integer; const Astring: string);
    function  UnitOfMeasure_Specified(Index: Integer): boolean;
  published
    property CommodityCode:     string   Index (IS_OPTN) read FCommodityCode write SetCommodityCode stored CommodityCode_Specified;
    property Description:       string   read FDescription write FDescription;
    property DiscountAmount:    string   Index (IS_OPTN) read FDiscountAmount write SetDiscountAmount stored DiscountAmount_Specified;
    property DiscountIndicator: Boolean  Index (IS_OPTN) read FDiscountIndicator write SetDiscountIndicator stored DiscountIndicator_Specified;
    property GrossNetIndicator: Boolean  Index (IS_OPTN) read FGrossNetIndicator write SetGrossNetIndicator stored GrossNetIndicator_Specified;
    property LineItemTotal:     string   read FLineItemTotal write FLineItemTotal;
    property ProductCode:       string   Index (IS_OPTN) read FProductCode write SetProductCode stored ProductCode_Specified;
    property Quantity:          string   read FQuantity write FQuantity;
    property TaxAmount:         string   Index (IS_OPTN) read FTaxAmount write SetTaxAmount stored TaxAmount_Specified;
    property TaxRate:           string   Index (IS_OPTN) read FTaxRate write SetTaxRate stored TaxRate_Specified;
    property TaxType:           string   Index (IS_OPTN) read FTaxType write SetTaxType stored TaxType_Specified;
    property UnitCost:          string   read FUnitCost write FUnitCost;
    property UnitOfMeasure:     string   Index (IS_OPTN) read FUnitOfMeasure write SetUnitOfMeasure stored UnitOfMeasure_Specified;
  end;



  // ************************************************************************ //
  // XML       : CheckTransaction, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  CheckTransaction = class(TRemotable)
  private
    FExactID: string;
    FPassword: string;
    FTransaction_Type: string;
    FDollarAmount: string;
    FCheckType: string;
    FCheckType_Specified: boolean;
    FMICR: string;
    FMICR_Specified: boolean;
    FCheckNumber: string;
    FCheckNumber_Specified: boolean;
    FBankAccountNumber: string;
    FBankAccountNumber_Specified: boolean;
    FBankRoutingNumber: string;
    FBankRoutingNumber_Specified: boolean;
    FTransaction_Tag: string;
    FTransaction_Tag_Specified: boolean;
    FSplitTenderID: string;
    FSplitTenderID_Specified: boolean;
    FAuthorization_Num: string;
    FAuthorization_Num_Specified: boolean;
    FCustomerName: string;
    FCustomerName_Specified: boolean;
    FEcommerce_Flag: string;
    FEcommerce_Flag_Specified: boolean;
    FReference_No: string;
    FReference_No_Specified: boolean;
    FCustomer_Ref: string;
    FCustomer_Ref_Specified: boolean;
    FLanguage: string;
    FLanguage_Specified: boolean;
    FClient_IP: string;
    FClient_IP_Specified: boolean;
    FClient_Email: string;
    FClient_Email_Specified: boolean;
    FUser_Name: string;
    FUser_Name_Specified: boolean;
    FCustomerIDType: Int64;
    FCustomerIDType_Specified: boolean;
    FCustomerID: string;
    FCustomerID_Specified: boolean;
    FReleaseType: string;
    FReleaseType_Specified: boolean;
    FGiftCardAmount: string;
    FGiftCardAmount_Specified: boolean;
    FDateOfBirth: string;
    FDateOfBirth_Specified: boolean;
    FVIP: Boolean;
    FVIP_Specified: boolean;
    FRegistrationNo: string;
    FRegistrationNo_Specified: boolean;
    FRegistrationDate: string;
    FRegistrationDate_Specified: boolean;
    FClerkID: string;
    FClerkID_Specified: boolean;
    FDeviceID: string;
    FDeviceID_Specified: boolean;
    FAddress: Address_Type;
    FAddress_Specified: boolean;
    FTPPID: string;
    FTPPID_Specified: boolean;
    FSplitShipmentNumber: string;
    FSplitShipmentNumber_Specified: boolean;
    FSoftDescriptor: SoftDescriptor_Type;
    FSoftDescriptor_Specified: boolean;
    procedure SetCheckType(Index: Integer; const Astring: string);
    function  CheckType_Specified(Index: Integer): boolean;
    procedure SetMICR(Index: Integer; const Astring: string);
    function  MICR_Specified(Index: Integer): boolean;
    procedure SetCheckNumber(Index: Integer; const Astring: string);
    function  CheckNumber_Specified(Index: Integer): boolean;
    procedure SetBankAccountNumber(Index: Integer; const Astring: string);
    function  BankAccountNumber_Specified(Index: Integer): boolean;
    procedure SetBankRoutingNumber(Index: Integer; const Astring: string);
    function  BankRoutingNumber_Specified(Index: Integer): boolean;
    procedure SetTransaction_Tag(Index: Integer; const Astring: string);
    function  Transaction_Tag_Specified(Index: Integer): boolean;
    procedure SetSplitTenderID(Index: Integer; const Astring: string);
    function  SplitTenderID_Specified(Index: Integer): boolean;
    procedure SetAuthorization_Num(Index: Integer; const Astring: string);
    function  Authorization_Num_Specified(Index: Integer): boolean;
    procedure SetCustomerName(Index: Integer; const Astring: string);
    function  CustomerName_Specified(Index: Integer): boolean;
    procedure SetEcommerce_Flag(Index: Integer; const Astring: string);
    function  Ecommerce_Flag_Specified(Index: Integer): boolean;
    procedure SetReference_No(Index: Integer; const Astring: string);
    function  Reference_No_Specified(Index: Integer): boolean;
    procedure SetCustomer_Ref(Index: Integer; const Astring: string);
    function  Customer_Ref_Specified(Index: Integer): boolean;
    procedure SetLanguage(Index: Integer; const Astring: string);
    function  Language_Specified(Index: Integer): boolean;
    procedure SetClient_IP(Index: Integer; const Astring: string);
    function  Client_IP_Specified(Index: Integer): boolean;
    procedure SetClient_Email(Index: Integer; const Astring: string);
    function  Client_Email_Specified(Index: Integer): boolean;
    procedure SetUser_Name(Index: Integer; const Astring: string);
    function  User_Name_Specified(Index: Integer): boolean;
    procedure SetCustomerIDType(Index: Integer; const AInt64: Int64);
    function  CustomerIDType_Specified(Index: Integer): boolean;
    procedure SetCustomerID(Index: Integer; const Astring: string);
    function  CustomerID_Specified(Index: Integer): boolean;
    procedure SetReleaseType(Index: Integer; const Astring: string);
    function  ReleaseType_Specified(Index: Integer): boolean;
    procedure SetGiftCardAmount(Index: Integer; const Astring: string);
    function  GiftCardAmount_Specified(Index: Integer): boolean;
    procedure SetDateOfBirth(Index: Integer; const Astring: string);
    function  DateOfBirth_Specified(Index: Integer): boolean;
    procedure SetVIP(Index: Integer; const ABoolean: Boolean);
    function  VIP_Specified(Index: Integer): boolean;
    procedure SetRegistrationNo(Index: Integer; const Astring: string);
    function  RegistrationNo_Specified(Index: Integer): boolean;
    procedure SetRegistrationDate(Index: Integer; const Astring: string);
    function  RegistrationDate_Specified(Index: Integer): boolean;
    procedure SetClerkID(Index: Integer; const Astring: string);
    function  ClerkID_Specified(Index: Integer): boolean;
    procedure SetDeviceID(Index: Integer; const Astring: string);
    function  DeviceID_Specified(Index: Integer): boolean;
    procedure SetAddress(Index: Integer; const AAddress_Type: Address_Type);
    function  Address_Specified(Index: Integer): boolean;
    procedure SetTPPID(Index: Integer; const Astring: string);
    function  TPPID_Specified(Index: Integer): boolean;
    procedure SetSplitShipmentNumber(Index: Integer; const Astring: string);
    function  SplitShipmentNumber_Specified(Index: Integer): boolean;
    procedure SetSoftDescriptor(Index: Integer; const ASoftDescriptor_Type: SoftDescriptor_Type);
    function  SoftDescriptor_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ExactID:             string               read FExactID write FExactID;
    property Password:            string               read FPassword write FPassword;
    property Transaction_Type:    string               read FTransaction_Type write FTransaction_Type;
    property DollarAmount:        string               read FDollarAmount write FDollarAmount;
    property CheckType:           string               Index (IS_OPTN) read FCheckType write SetCheckType stored CheckType_Specified;
    property MICR:                string               Index (IS_OPTN) read FMICR write SetMICR stored MICR_Specified;
    property CheckNumber:         string               Index (IS_OPTN) read FCheckNumber write SetCheckNumber stored CheckNumber_Specified;
    property BankAccountNumber:   string               Index (IS_OPTN) read FBankAccountNumber write SetBankAccountNumber stored BankAccountNumber_Specified;
    property BankRoutingNumber:   string               Index (IS_OPTN) read FBankRoutingNumber write SetBankRoutingNumber stored BankRoutingNumber_Specified;
    property Transaction_Tag:     string               Index (IS_OPTN) read FTransaction_Tag write SetTransaction_Tag stored Transaction_Tag_Specified;
    property SplitTenderID:       string               Index (IS_OPTN) read FSplitTenderID write SetSplitTenderID stored SplitTenderID_Specified;
    property Authorization_Num:   string               Index (IS_OPTN) read FAuthorization_Num write SetAuthorization_Num stored Authorization_Num_Specified;
    property CustomerName:        string               Index (IS_OPTN) read FCustomerName write SetCustomerName stored CustomerName_Specified;
    property Ecommerce_Flag:      string               Index (IS_OPTN) read FEcommerce_Flag write SetEcommerce_Flag stored Ecommerce_Flag_Specified;
    property Reference_No:        string               Index (IS_OPTN) read FReference_No write SetReference_No stored Reference_No_Specified;
    property Customer_Ref:        string               Index (IS_OPTN) read FCustomer_Ref write SetCustomer_Ref stored Customer_Ref_Specified;
    property Language:            string               Index (IS_OPTN) read FLanguage write SetLanguage stored Language_Specified;
    property Client_IP:           string               Index (IS_OPTN) read FClient_IP write SetClient_IP stored Client_IP_Specified;
    property Client_Email:        string               Index (IS_OPTN) read FClient_Email write SetClient_Email stored Client_Email_Specified;
    property User_Name:           string               Index (IS_OPTN) read FUser_Name write SetUser_Name stored User_Name_Specified;
    property CustomerIDType:      Int64                Index (IS_OPTN) read FCustomerIDType write SetCustomerIDType stored CustomerIDType_Specified;
    property CustomerID:          string               Index (IS_OPTN) read FCustomerID write SetCustomerID stored CustomerID_Specified;
    property ReleaseType:         string               Index (IS_OPTN) read FReleaseType write SetReleaseType stored ReleaseType_Specified;
    property GiftCardAmount:      string               Index (IS_OPTN) read FGiftCardAmount write SetGiftCardAmount stored GiftCardAmount_Specified;
    property DateOfBirth:         string               Index (IS_OPTN) read FDateOfBirth write SetDateOfBirth stored DateOfBirth_Specified;
    property VIP:                 Boolean              Index (IS_OPTN) read FVIP write SetVIP stored VIP_Specified;
    property RegistrationNo:      string               Index (IS_OPTN) read FRegistrationNo write SetRegistrationNo stored RegistrationNo_Specified;
    property RegistrationDate:    string               Index (IS_OPTN) read FRegistrationDate write SetRegistrationDate stored RegistrationDate_Specified;
    property ClerkID:             string               Index (IS_OPTN) read FClerkID write SetClerkID stored ClerkID_Specified;
    property DeviceID:            string               Index (IS_OPTN) read FDeviceID write SetDeviceID stored DeviceID_Specified;
    property Address:             Address_Type         Index (IS_OPTN) read FAddress write SetAddress stored Address_Specified;
    property TPPID:               string               Index (IS_OPTN) read FTPPID write SetTPPID stored TPPID_Specified;
    property SplitShipmentNumber: string               Index (IS_OPTN) read FSplitShipmentNumber write SetSplitShipmentNumber stored SplitShipmentNumber_Specified;
    property SoftDescriptor:      SoftDescriptor_Type  Index (IS_OPTN) read FSoftDescriptor write SetSoftDescriptor stored SoftDescriptor_Specified;
  end;



  // ************************************************************************ //
  // XML       : CheckTransactionResult, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  CheckTransactionResult = class(CheckTransaction)
  private
    FTransaction_Error: Boolean;
    FTransaction_Approved: Boolean;
    FEXact_Resp_Code: string;
    FEXact_Message: string;
    FBank_Resp_Code: string;
    FBank_Resp_Code_Specified: boolean;
    FBank_Message: string;
    FBank_Message_Specified: boolean;
    FBank_Resp_Code_2: string;
    FBank_Resp_Code_2_Specified: boolean;
    FSequenceNo: string;
    FSequenceNo_Specified: boolean;
    FMerchantName: string;
    FMerchantName_Specified: boolean;
    FMerchantAddress: string;
    FMerchantAddress_Specified: boolean;
    FMerchantCity: string;
    FMerchantCity_Specified: boolean;
    FMerchantProvince: string;
    FMerchantProvince_Specified: boolean;
    FMerchantCountry: string;
    FMerchantCountry_Specified: boolean;
    FMerchantPostal: string;
    FMerchantPostal_Specified: boolean;
    FMerchantURL: string;
    FMerchantURL_Specified: boolean;
    FCTR: string;
    FCTR_Specified: boolean;
    procedure SetBank_Resp_Code(Index: Integer; const Astring: string);
    function  Bank_Resp_Code_Specified(Index: Integer): boolean;
    procedure SetBank_Message(Index: Integer; const Astring: string);
    function  Bank_Message_Specified(Index: Integer): boolean;
    procedure SetBank_Resp_Code_2(Index: Integer; const Astring: string);
    function  Bank_Resp_Code_2_Specified(Index: Integer): boolean;
    procedure SetSequenceNo(Index: Integer; const Astring: string);
    function  SequenceNo_Specified(Index: Integer): boolean;
    procedure SetMerchantName(Index: Integer; const Astring: string);
    function  MerchantName_Specified(Index: Integer): boolean;
    procedure SetMerchantAddress(Index: Integer; const Astring: string);
    function  MerchantAddress_Specified(Index: Integer): boolean;
    procedure SetMerchantCity(Index: Integer; const Astring: string);
    function  MerchantCity_Specified(Index: Integer): boolean;
    procedure SetMerchantProvince(Index: Integer; const Astring: string);
    function  MerchantProvince_Specified(Index: Integer): boolean;
    procedure SetMerchantCountry(Index: Integer; const Astring: string);
    function  MerchantCountry_Specified(Index: Integer): boolean;
    procedure SetMerchantPostal(Index: Integer; const Astring: string);
    function  MerchantPostal_Specified(Index: Integer): boolean;
    procedure SetMerchantURL(Index: Integer; const Astring: string);
    function  MerchantURL_Specified(Index: Integer): boolean;
    procedure SetCTR(Index: Integer; const Astring: string);
    function  CTR_Specified(Index: Integer): boolean;
  published
    property Transaction_Error:    Boolean  read FTransaction_Error write FTransaction_Error;
    property Transaction_Approved: Boolean  read FTransaction_Approved write FTransaction_Approved;
    property EXact_Resp_Code:      string   read FEXact_Resp_Code write FEXact_Resp_Code;
    property EXact_Message:        string   read FEXact_Message write FEXact_Message;
    property Bank_Resp_Code:       string   Index (IS_OPTN) read FBank_Resp_Code write SetBank_Resp_Code stored Bank_Resp_Code_Specified;
    property Bank_Message:         string   Index (IS_OPTN) read FBank_Message write SetBank_Message stored Bank_Message_Specified;
    property Bank_Resp_Code_2:     string   Index (IS_OPTN) read FBank_Resp_Code_2 write SetBank_Resp_Code_2 stored Bank_Resp_Code_2_Specified;
    property SequenceNo:           string   Index (IS_OPTN) read FSequenceNo write SetSequenceNo stored SequenceNo_Specified;
    property MerchantName:         string   Index (IS_OPTN) read FMerchantName write SetMerchantName stored MerchantName_Specified;
    property MerchantAddress:      string   Index (IS_OPTN) read FMerchantAddress write SetMerchantAddress stored MerchantAddress_Specified;
    property MerchantCity:         string   Index (IS_OPTN) read FMerchantCity write SetMerchantCity stored MerchantCity_Specified;
    property MerchantProvince:     string   Index (IS_OPTN) read FMerchantProvince write SetMerchantProvince stored MerchantProvince_Specified;
    property MerchantCountry:      string   Index (IS_OPTN) read FMerchantCountry write SetMerchantCountry stored MerchantCountry_Specified;
    property MerchantPostal:       string   Index (IS_OPTN) read FMerchantPostal write SetMerchantPostal stored MerchantPostal_Specified;
    property MerchantURL:          string   Index (IS_OPTN) read FMerchantURL write SetMerchantURL stored MerchantURL_Specified;
    property CTR:                  string   Index (IS_OPTN) read FCTR write SetCTR stored CTR_Specified;
  end;



  // ************************************************************************ //
  // XML       : Transaction, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  Transaction = class(TRemotable)
  private
    FExactID: string;
    FPassword: string;
    FTransaction_Type: string;
    FDollarAmount: string;
    FDollarAmount_Specified: boolean;
    FSurchargeAmount: string;
    FSurchargeAmount_Specified: boolean;
    FCard_Number: string;
    FCard_Number_Specified: boolean;
    FTransaction_Tag: string;
    FTransaction_Tag_Specified: boolean;
    FSplitTenderID: string;
    FSplitTenderID_Specified: boolean;
    FTrack1: string;
    FTrack1_Specified: boolean;
    FTrack2: string;
    FTrack2_Specified: boolean;
    FPAN: string;
    FPAN_Specified: boolean;
    FAuthorization_Num: string;
    FAuthorization_Num_Specified: boolean;
    FExpiry_Date: string;
    FExpiry_Date_Specified: boolean;
    FCardHoldersName: string;
    FCardHoldersName_Specified: boolean;
    FCVDCode: string;
    FCVDCode_Specified: boolean;
    FCVD_Presence_Ind: string;
    FCVD_Presence_Ind_Specified: boolean;
    FZipCode: string;
    FZipCode_Specified: boolean;
    FTax1Amount: string;
    FTax1Amount_Specified: boolean;
    FTax1Number: string;
    FTax1Number_Specified: boolean;
    FTax2Amount: string;
    FTax2Amount_Specified: boolean;
    FTax2Number: string;
    FTax2Number_Specified: boolean;
    FSecure_AuthRequired: string;
    FSecure_AuthRequired_Specified: boolean;
    FSecure_AuthResult: string;
    FSecure_AuthResult_Specified: boolean;
    FEcommerce_Flag: string;
    FEcommerce_Flag_Specified: boolean;
    FXID: string;
    FXID_Specified: boolean;
    FCAVV: string;
    FCAVV_Specified: boolean;
    FReference_No: string;
    FReference_No_Specified: boolean;
    FCustomer_Ref: string;
    FCustomer_Ref_Specified: boolean;
    FReference_3: string;
    FReference_3_Specified: boolean;
    FLanguage: string;
    FLanguage_Specified: boolean;
    FClient_IP: string;
    FClient_IP_Specified: boolean;
    FClient_Email: string;
    FClient_Email_Specified: boolean;
    FUser_Name: string;
    FUser_Name_Specified: boolean;
    FCurrency: string;
    FCurrency_Specified: boolean;
    FPartialRedemption: Boolean;
    FPartialRedemption_Specified: boolean;
    FLevel3: Level3_Type;
    FLevel3_Specified: boolean;
    FTransarmorToken: string;
    FTransarmorToken_Specified: boolean;
    FCardType: string;
    FCardType_Specified: boolean;
    FEAN: string;
    FEAN_Specified: boolean;
    FVirtualCard: Boolean;
    FVirtualCard_Specified: boolean;
    FCardCost: string;
    FCardCost_Specified: boolean;
    FFraudSuspected: string;
    FFraudSuspected_Specified: boolean;
    FPaypalResponse: PaypalTransactionDetails;
    FPaypalResponse_Specified: boolean;
    FSoftDescriptor: SoftDescriptor_Type;
    FSoftDescriptor_Specified: boolean;
    FAddress: Address_Type;
    FAddress_Specified: boolean;
    FTPPID: string;
    FTPPID_Specified: boolean;
    FSplitShipmentNumber: string;
    FSplitShipmentNumber_Specified: boolean;
    FAmexFraud: string;
    FAmexFraud_Specified: boolean;
    FDynamicCurrency: DynamicCurrency;
    FDynamicCurrency_Specified: boolean;
    FDynamicPricing: DynamicPricing;
    FDynamicPricing_Specified: boolean;
    FFeeAmount: string;
    FFeeAmount_Specified: boolean;
    FVisaCheckout: VisaCheckout;
    FVisaCheckout_Specified: boolean;
    FPostDate: string;
    FPostDate_Specified: boolean;
    FOtherAmount: string;
    FOtherAmount_Specified: boolean;
    FGiftDepositAvailable: string;
    FGiftDepositAvailable_Specified: boolean;
    FSpecialPayment: string;
    FSpecialPayment_Specified: boolean;
    FWalletProviderID: string;
    FWalletProviderID_Specified: boolean;
    FMasterPass: MasterPass;
    FMasterPass_Specified: boolean;
    procedure SetDollarAmount(Index: Integer; const Astring: string);
    function  DollarAmount_Specified(Index: Integer): boolean;
    procedure SetSurchargeAmount(Index: Integer; const Astring: string);
    function  SurchargeAmount_Specified(Index: Integer): boolean;
    procedure SetCard_Number(Index: Integer; const Astring: string);
    function  Card_Number_Specified(Index: Integer): boolean;
    procedure SetTransaction_Tag(Index: Integer; const Astring: string);
    function  Transaction_Tag_Specified(Index: Integer): boolean;
    procedure SetSplitTenderID(Index: Integer; const Astring: string);
    function  SplitTenderID_Specified(Index: Integer): boolean;
    procedure SetTrack1(Index: Integer; const Astring: string);
    function  Track1_Specified(Index: Integer): boolean;
    procedure SetTrack2(Index: Integer; const Astring: string);
    function  Track2_Specified(Index: Integer): boolean;
    procedure SetPAN(Index: Integer; const Astring: string);
    function  PAN_Specified(Index: Integer): boolean;
    procedure SetAuthorization_Num(Index: Integer; const Astring: string);
    function  Authorization_Num_Specified(Index: Integer): boolean;
    procedure SetExpiry_Date(Index: Integer; const Astring: string);
    function  Expiry_Date_Specified(Index: Integer): boolean;
    procedure SetCardHoldersName(Index: Integer; const Astring: string);
    function  CardHoldersName_Specified(Index: Integer): boolean;
    procedure SetCVDCode(Index: Integer; const Astring: string);
    function  CVDCode_Specified(Index: Integer): boolean;
    procedure SetCVD_Presence_Ind(Index: Integer; const Astring: string);
    function  CVD_Presence_Ind_Specified(Index: Integer): boolean;
    procedure SetZipCode(Index: Integer; const Astring: string);
    function  ZipCode_Specified(Index: Integer): boolean;
    procedure SetTax1Amount(Index: Integer; const Astring: string);
    function  Tax1Amount_Specified(Index: Integer): boolean;
    procedure SetTax1Number(Index: Integer; const Astring: string);
    function  Tax1Number_Specified(Index: Integer): boolean;
    procedure SetTax2Amount(Index: Integer; const Astring: string);
    function  Tax2Amount_Specified(Index: Integer): boolean;
    procedure SetTax2Number(Index: Integer; const Astring: string);
    function  Tax2Number_Specified(Index: Integer): boolean;
    procedure SetSecure_AuthRequired(Index: Integer; const Astring: string);
    function  Secure_AuthRequired_Specified(Index: Integer): boolean;
    procedure SetSecure_AuthResult(Index: Integer; const Astring: string);
    function  Secure_AuthResult_Specified(Index: Integer): boolean;
    procedure SetEcommerce_Flag(Index: Integer; const Astring: string);
    function  Ecommerce_Flag_Specified(Index: Integer): boolean;
    procedure SetXID(Index: Integer; const Astring: string);
    function  XID_Specified(Index: Integer): boolean;
    procedure SetCAVV(Index: Integer; const Astring: string);
    function  CAVV_Specified(Index: Integer): boolean;
    procedure SetReference_No(Index: Integer; const Astring: string);
    function  Reference_No_Specified(Index: Integer): boolean;
    procedure SetCustomer_Ref(Index: Integer; const Astring: string);
    function  Customer_Ref_Specified(Index: Integer): boolean;
    procedure SetReference_3(Index: Integer; const Astring: string);
    function  Reference_3_Specified(Index: Integer): boolean;
    procedure SetLanguage(Index: Integer; const Astring: string);
    function  Language_Specified(Index: Integer): boolean;
    procedure SetClient_IP(Index: Integer; const Astring: string);
    function  Client_IP_Specified(Index: Integer): boolean;
    procedure SetClient_Email(Index: Integer; const Astring: string);
    function  Client_Email_Specified(Index: Integer): boolean;
    procedure SetUser_Name(Index: Integer; const Astring: string);
    function  User_Name_Specified(Index: Integer): boolean;
    procedure SetCurrency(Index: Integer; const Astring: string);
    function  Currency_Specified(Index: Integer): boolean;
    procedure SetPartialRedemption(Index: Integer; const ABoolean: Boolean);
    function  PartialRedemption_Specified(Index: Integer): boolean;
    procedure SetLevel3(Index: Integer; const ALevel3_Type: Level3_Type);
    function  Level3_Specified(Index: Integer): boolean;
    procedure SetTransarmorToken(Index: Integer; const Astring: string);
    function  TransarmorToken_Specified(Index: Integer): boolean;
    procedure SetCardType(Index: Integer; const Astring: string);
    function  CardType_Specified(Index: Integer): boolean;
    procedure SetEAN(Index: Integer; const Astring: string);
    function  EAN_Specified(Index: Integer): boolean;
    procedure SetVirtualCard(Index: Integer; const ABoolean: Boolean);
    function  VirtualCard_Specified(Index: Integer): boolean;
    procedure SetCardCost(Index: Integer; const Astring: string);
    function  CardCost_Specified(Index: Integer): boolean;
    procedure SetFraudSuspected(Index: Integer; const Astring: string);
    function  FraudSuspected_Specified(Index: Integer): boolean;
    procedure SetPaypalResponse(Index: Integer; const APaypalTransactionDetails: PaypalTransactionDetails);
    function  PaypalResponse_Specified(Index: Integer): boolean;
    procedure SetSoftDescriptor(Index: Integer; const ASoftDescriptor_Type: SoftDescriptor_Type);
    function  SoftDescriptor_Specified(Index: Integer): boolean;
    procedure SetAddress(Index: Integer; const AAddress_Type: Address_Type);
    function  Address_Specified(Index: Integer): boolean;
    procedure SetTPPID(Index: Integer; const Astring: string);
    function  TPPID_Specified(Index: Integer): boolean;
    procedure SetSplitShipmentNumber(Index: Integer; const Astring: string);
    function  SplitShipmentNumber_Specified(Index: Integer): boolean;
    procedure SetAmexFraud(Index: Integer; const Astring: string);
    function  AmexFraud_Specified(Index: Integer): boolean;
    procedure SetDynamicCurrency(Index: Integer; const ADynamicCurrency: DynamicCurrency);
    function  DynamicCurrency_Specified(Index: Integer): boolean;
    procedure SetDynamicPricing(Index: Integer; const ADynamicPricing: DynamicPricing);
    function  DynamicPricing_Specified(Index: Integer): boolean;
    procedure SetFeeAmount(Index: Integer; const Astring: string);
    function  FeeAmount_Specified(Index: Integer): boolean;
    procedure SetVisaCheckout(Index: Integer; const AVisaCheckout: VisaCheckout);
    function  VisaCheckout_Specified(Index: Integer): boolean;
    procedure SetPostDate(Index: Integer; const Astring: string);
    function  PostDate_Specified(Index: Integer): boolean;
    procedure SetOtherAmount(Index: Integer; const Astring: string);
    function  OtherAmount_Specified(Index: Integer): boolean;
    procedure SetGiftDepositAvailable(Index: Integer; const Astring: string);
    function  GiftDepositAvailable_Specified(Index: Integer): boolean;
    procedure SetSpecialPayment(Index: Integer; const Astring: string);
    function  SpecialPayment_Specified(Index: Integer): boolean;
    procedure SetWalletProviderID(Index: Integer; const Astring: string);
    function  WalletProviderID_Specified(Index: Integer): boolean;
    procedure SetMasterPass(Index: Integer; const AMasterPass: MasterPass);
    function  MasterPass_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ExactID:              string                    read FExactID write FExactID;
    property Password:             string                    read FPassword write FPassword;
    property Transaction_Type:     string                    read FTransaction_Type write FTransaction_Type;
    property DollarAmount:         string                    Index (IS_OPTN) read FDollarAmount write SetDollarAmount stored DollarAmount_Specified;
    property SurchargeAmount:      string                    Index (IS_OPTN) read FSurchargeAmount write SetSurchargeAmount stored SurchargeAmount_Specified;
    property Card_Number:          string                    Index (IS_OPTN) read FCard_Number write SetCard_Number stored Card_Number_Specified;
    property Transaction_Tag:      string                    Index (IS_OPTN) read FTransaction_Tag write SetTransaction_Tag stored Transaction_Tag_Specified;
    property SplitTenderID:        string                    Index (IS_OPTN) read FSplitTenderID write SetSplitTenderID stored SplitTenderID_Specified;
    property Track1:               string                    Index (IS_OPTN) read FTrack1 write SetTrack1 stored Track1_Specified;
    property Track2:               string                    Index (IS_OPTN) read FTrack2 write SetTrack2 stored Track2_Specified;
    property PAN:                  string                    Index (IS_OPTN) read FPAN write SetPAN stored PAN_Specified;
    property Authorization_Num:    string                    Index (IS_OPTN) read FAuthorization_Num write SetAuthorization_Num stored Authorization_Num_Specified;
    property Expiry_Date:          string                    Index (IS_OPTN) read FExpiry_Date write SetExpiry_Date stored Expiry_Date_Specified;
    property CardHoldersName:      string                    Index (IS_OPTN) read FCardHoldersName write SetCardHoldersName stored CardHoldersName_Specified;
    property CVDCode:              string                    Index (IS_OPTN) read FCVDCode write SetCVDCode stored CVDCode_Specified;
    property CVD_Presence_Ind:     string                    Index (IS_OPTN) read FCVD_Presence_Ind write SetCVD_Presence_Ind stored CVD_Presence_Ind_Specified;
    property ZipCode:              string                    Index (IS_OPTN) read FZipCode write SetZipCode stored ZipCode_Specified;
    property Tax1Amount:           string                    Index (IS_OPTN) read FTax1Amount write SetTax1Amount stored Tax1Amount_Specified;
    property Tax1Number:           string                    Index (IS_OPTN) read FTax1Number write SetTax1Number stored Tax1Number_Specified;
    property Tax2Amount:           string                    Index (IS_OPTN) read FTax2Amount write SetTax2Amount stored Tax2Amount_Specified;
    property Tax2Number:           string                    Index (IS_OPTN) read FTax2Number write SetTax2Number stored Tax2Number_Specified;
    property Secure_AuthRequired:  string                    Index (IS_OPTN) read FSecure_AuthRequired write SetSecure_AuthRequired stored Secure_AuthRequired_Specified;
    property Secure_AuthResult:    string                    Index (IS_OPTN) read FSecure_AuthResult write SetSecure_AuthResult stored Secure_AuthResult_Specified;
    property Ecommerce_Flag:       string                    Index (IS_OPTN) read FEcommerce_Flag write SetEcommerce_Flag stored Ecommerce_Flag_Specified;
    property XID:                  string                    Index (IS_OPTN) read FXID write SetXID stored XID_Specified;
    property CAVV:                 string                    Index (IS_OPTN) read FCAVV write SetCAVV stored CAVV_Specified;
    property Reference_No:         string                    Index (IS_OPTN) read FReference_No write SetReference_No stored Reference_No_Specified;
    property Customer_Ref:         string                    Index (IS_OPTN) read FCustomer_Ref write SetCustomer_Ref stored Customer_Ref_Specified;
    property Reference_3:          string                    Index (IS_OPTN) read FReference_3 write SetReference_3 stored Reference_3_Specified;
    property Language:             string                    Index (IS_OPTN) read FLanguage write SetLanguage stored Language_Specified;
    property Client_IP:            string                    Index (IS_OPTN) read FClient_IP write SetClient_IP stored Client_IP_Specified;
    property Client_Email:         string                    Index (IS_OPTN) read FClient_Email write SetClient_Email stored Client_Email_Specified;
    property User_Name:            string                    Index (IS_OPTN) read FUser_Name write SetUser_Name stored User_Name_Specified;
    property Currency:             string                    Index (IS_OPTN) read FCurrency write SetCurrency stored Currency_Specified;
    property PartialRedemption:    Boolean                   Index (IS_OPTN) read FPartialRedemption write SetPartialRedemption stored PartialRedemption_Specified;
    property Level3:               Level3_Type               Index (IS_OPTN) read FLevel3 write SetLevel3 stored Level3_Specified;
    property TransarmorToken:      string                    Index (IS_OPTN) read FTransarmorToken write SetTransarmorToken stored TransarmorToken_Specified;
    property CardType:             string                    Index (IS_OPTN) read FCardType write SetCardType stored CardType_Specified;
    property EAN:                  string                    Index (IS_OPTN) read FEAN write SetEAN stored EAN_Specified;
    property VirtualCard:          Boolean                   Index (IS_OPTN) read FVirtualCard write SetVirtualCard stored VirtualCard_Specified;
    property CardCost:             string                    Index (IS_OPTN) read FCardCost write SetCardCost stored CardCost_Specified;
    property FraudSuspected:       string                    Index (IS_OPTN) read FFraudSuspected write SetFraudSuspected stored FraudSuspected_Specified;
    property PaypalResponse:       PaypalTransactionDetails  Index (IS_OPTN) read FPaypalResponse write SetPaypalResponse stored PaypalResponse_Specified;
    property SoftDescriptor:       SoftDescriptor_Type       Index (IS_OPTN) read FSoftDescriptor write SetSoftDescriptor stored SoftDescriptor_Specified;
    property Address:              Address_Type              Index (IS_OPTN) read FAddress write SetAddress stored Address_Specified;
    property TPPID:                string                    Index (IS_OPTN) read FTPPID write SetTPPID stored TPPID_Specified;
    property SplitShipmentNumber:  string                    Index (IS_OPTN) read FSplitShipmentNumber write SetSplitShipmentNumber stored SplitShipmentNumber_Specified;
    property AmexFraud:            string                    Index (IS_OPTN) read FAmexFraud write SetAmexFraud stored AmexFraud_Specified;
    property DynamicCurrency:      DynamicCurrency           Index (IS_OPTN) read FDynamicCurrency write SetDynamicCurrency stored DynamicCurrency_Specified;
    property DynamicPricing:       DynamicPricing            Index (IS_OPTN) read FDynamicPricing write SetDynamicPricing stored DynamicPricing_Specified;
    property FeeAmount:            string                    Index (IS_OPTN) read FFeeAmount write SetFeeAmount stored FeeAmount_Specified;
    property VisaCheckout:         VisaCheckout              Index (IS_OPTN) read FVisaCheckout write SetVisaCheckout stored VisaCheckout_Specified;
    property PostDate:             string                    Index (IS_OPTN) read FPostDate write SetPostDate stored PostDate_Specified;
    property OtherAmount:          string                    Index (IS_OPTN) read FOtherAmount write SetOtherAmount stored OtherAmount_Specified;
    property GiftDepositAvailable: string                    Index (IS_OPTN) read FGiftDepositAvailable write SetGiftDepositAvailable stored GiftDepositAvailable_Specified;
    property SpecialPayment:       string                    Index (IS_OPTN) read FSpecialPayment write SetSpecialPayment stored SpecialPayment_Specified;
    property WalletProviderID:     string                    Index (IS_OPTN) read FWalletProviderID write SetWalletProviderID stored WalletProviderID_Specified;
    property MasterPass:           MasterPass                Index (IS_OPTN) read FMasterPass write SetMasterPass stored MasterPass_Specified;
  end;



  // ************************************************************************ //
  // XML       : TransactionResult, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  TransactionResult = class(Transaction)
  private
    FTransaction_Error: Boolean;
    FTransaction_Approved: Boolean;
    FEXact_Resp_Code: string;
    FEXact_Message: string;
    FBank_Resp_Code: string;
    FBank_Resp_Code_Specified: boolean;
    FBank_Message: string;
    FBank_Message_Specified: boolean;
    FBank_Resp_Code_2: string;
    FBank_Resp_Code_2_Specified: boolean;
    FSequenceNo: string;
    FSequenceNo_Specified: boolean;
    FAVS: string;
    FAVS_Specified: boolean;
    FCVV2: string;
    FCVV2_Specified: boolean;
    FRetrieval_Ref_No: string;
    FRetrieval_Ref_No_Specified: boolean;
    FCAVV_Response: string;
    FCAVV_Response_Specified: boolean;
    FAmountRequested: string;
    FAmountRequested_Specified: boolean;
    FMerchantName: string;
    FMerchantName_Specified: boolean;
    FMerchantAddress: string;
    FMerchantAddress_Specified: boolean;
    FMerchantCity: string;
    FMerchantCity_Specified: boolean;
    FMerchantProvince: string;
    FMerchantProvince_Specified: boolean;
    FMerchantCountry: string;
    FMerchantCountry_Specified: boolean;
    FMerchantPostal: string;
    FMerchantPostal_Specified: boolean;
    FMerchantURL: string;
    FMerchantURL_Specified: boolean;
    FCurrentBalance: string;
    FCurrentBalance_Specified: boolean;
    FPreviousBalance: string;
    FPreviousBalance_Specified: boolean;
    FForeignCurrencyDetails: ForeignCurrencyDetails;
    FForeignCurrencyDetails_Specified: boolean;
    FCTR: string;
    FCTR_Specified: boolean;
    FValueLinkAuthCode: string;
    FValueLinkAuthCode_Specified: boolean;
    FLocalCurrencyCode: string;
    FLocalCurrencyCode_Specified: boolean;
    FPromoDetails: string;
    FPromoDetails_Specified: boolean;
    procedure SetBank_Resp_Code(Index: Integer; const Astring: string);
    function  Bank_Resp_Code_Specified(Index: Integer): boolean;
    procedure SetBank_Message(Index: Integer; const Astring: string);
    function  Bank_Message_Specified(Index: Integer): boolean;
    procedure SetBank_Resp_Code_2(Index: Integer; const Astring: string);
    function  Bank_Resp_Code_2_Specified(Index: Integer): boolean;
    procedure SetSequenceNo(Index: Integer; const Astring: string);
    function  SequenceNo_Specified(Index: Integer): boolean;
    procedure SetAVS(Index: Integer; const Astring: string);
    function  AVS_Specified(Index: Integer): boolean;
    procedure SetCVV2(Index: Integer; const Astring: string);
    function  CVV2_Specified(Index: Integer): boolean;
    procedure SetRetrieval_Ref_No(Index: Integer; const Astring: string);
    function  Retrieval_Ref_No_Specified(Index: Integer): boolean;
    procedure SetCAVV_Response(Index: Integer; const Astring: string);
    function  CAVV_Response_Specified(Index: Integer): boolean;
    procedure SetAmountRequested(Index: Integer; const Astring: string);
    function  AmountRequested_Specified(Index: Integer): boolean;
    procedure SetMerchantName(Index: Integer; const Astring: string);
    function  MerchantName_Specified(Index: Integer): boolean;
    procedure SetMerchantAddress(Index: Integer; const Astring: string);
    function  MerchantAddress_Specified(Index: Integer): boolean;
    procedure SetMerchantCity(Index: Integer; const Astring: string);
    function  MerchantCity_Specified(Index: Integer): boolean;
    procedure SetMerchantProvince(Index: Integer; const Astring: string);
    function  MerchantProvince_Specified(Index: Integer): boolean;
    procedure SetMerchantCountry(Index: Integer; const Astring: string);
    function  MerchantCountry_Specified(Index: Integer): boolean;
    procedure SetMerchantPostal(Index: Integer; const Astring: string);
    function  MerchantPostal_Specified(Index: Integer): boolean;
    procedure SetMerchantURL(Index: Integer; const Astring: string);
    function  MerchantURL_Specified(Index: Integer): boolean;
    procedure SetCurrentBalance(Index: Integer; const Astring: string);
    function  CurrentBalance_Specified(Index: Integer): boolean;
    procedure SetPreviousBalance(Index: Integer; const Astring: string);
    function  PreviousBalance_Specified(Index: Integer): boolean;
    procedure SetForeignCurrencyDetails(Index: Integer; const AForeignCurrencyDetails: ForeignCurrencyDetails);
    function  ForeignCurrencyDetails_Specified(Index: Integer): boolean;
    procedure SetCTR(Index: Integer; const Astring: string);
    function  CTR_Specified(Index: Integer): boolean;
    procedure SetValueLinkAuthCode(Index: Integer; const Astring: string);
    function  ValueLinkAuthCode_Specified(Index: Integer): boolean;
    procedure SetLocalCurrencyCode(Index: Integer; const Astring: string);
    function  LocalCurrencyCode_Specified(Index: Integer): boolean;
    procedure SetPromoDetails(Index: Integer; const Astring: string);
    function  PromoDetails_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Transaction_Error:      Boolean                 read FTransaction_Error write FTransaction_Error;
    property Transaction_Approved:   Boolean                 read FTransaction_Approved write FTransaction_Approved;
    property EXact_Resp_Code:        string                  read FEXact_Resp_Code write FEXact_Resp_Code;
    property EXact_Message:          string                  read FEXact_Message write FEXact_Message;
    property Bank_Resp_Code:         string                  Index (IS_OPTN) read FBank_Resp_Code write SetBank_Resp_Code stored Bank_Resp_Code_Specified;
    property Bank_Message:           string                  Index (IS_OPTN) read FBank_Message write SetBank_Message stored Bank_Message_Specified;
    property Bank_Resp_Code_2:       string                  Index (IS_OPTN) read FBank_Resp_Code_2 write SetBank_Resp_Code_2 stored Bank_Resp_Code_2_Specified;
    property SequenceNo:             string                  Index (IS_OPTN) read FSequenceNo write SetSequenceNo stored SequenceNo_Specified;
    property AVS:                    string                  Index (IS_OPTN) read FAVS write SetAVS stored AVS_Specified;
    property CVV2:                   string                  Index (IS_OPTN) read FCVV2 write SetCVV2 stored CVV2_Specified;
    property Retrieval_Ref_No:       string                  Index (IS_OPTN) read FRetrieval_Ref_No write SetRetrieval_Ref_No stored Retrieval_Ref_No_Specified;
    property CAVV_Response:          string                  Index (IS_OPTN) read FCAVV_Response write SetCAVV_Response stored CAVV_Response_Specified;
    property AmountRequested:        string                  Index (IS_OPTN) read FAmountRequested write SetAmountRequested stored AmountRequested_Specified;
    property MerchantName:           string                  Index (IS_OPTN) read FMerchantName write SetMerchantName stored MerchantName_Specified;
    property MerchantAddress:        string                  Index (IS_OPTN) read FMerchantAddress write SetMerchantAddress stored MerchantAddress_Specified;
    property MerchantCity:           string                  Index (IS_OPTN) read FMerchantCity write SetMerchantCity stored MerchantCity_Specified;
    property MerchantProvince:       string                  Index (IS_OPTN) read FMerchantProvince write SetMerchantProvince stored MerchantProvince_Specified;
    property MerchantCountry:        string                  Index (IS_OPTN) read FMerchantCountry write SetMerchantCountry stored MerchantCountry_Specified;
    property MerchantPostal:         string                  Index (IS_OPTN) read FMerchantPostal write SetMerchantPostal stored MerchantPostal_Specified;
    property MerchantURL:            string                  Index (IS_OPTN) read FMerchantURL write SetMerchantURL stored MerchantURL_Specified;
    property CurrentBalance:         string                  Index (IS_OPTN) read FCurrentBalance write SetCurrentBalance stored CurrentBalance_Specified;
    property PreviousBalance:        string                  Index (IS_OPTN) read FPreviousBalance write SetPreviousBalance stored PreviousBalance_Specified;
    property ForeignCurrencyDetails: ForeignCurrencyDetails  Index (IS_OPTN) read FForeignCurrencyDetails write SetForeignCurrencyDetails stored ForeignCurrencyDetails_Specified;
    property CTR:                    string                  Index (IS_OPTN) read FCTR write SetCTR stored CTR_Specified;
    property ValueLinkAuthCode:      string                  Index (IS_OPTN) read FValueLinkAuthCode write SetValueLinkAuthCode stored ValueLinkAuthCode_Specified;
    property LocalCurrencyCode:      string                  Index (IS_OPTN) read FLocalCurrencyCode write SetLocalCurrencyCode stored LocalCurrencyCode_Specified;
    property PromoDetails:           string                  Index (IS_OPTN) read FPromoDetails write SetPromoDetails stored PromoDetails_Specified;
  end;



  // ************************************************************************ //
  // XML       : Address_Type, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  Address_Type = class(TRemotable)
  private
    FAddress1: string;
    FAddress1_Specified: boolean;
    FAddress2: string;
    FAddress2_Specified: boolean;
    FCity: string;
    FCity_Specified: boolean;
    FState: string;
    FState_Specified: boolean;
    FZip: string;
    FZip_Specified: boolean;
    FCountryCode: string;
    FCountryCode_Specified: boolean;
    FPhoneNumber: string;
    FPhoneNumber_Specified: boolean;
    FPhoneType: string;
    FPhoneType_Specified: boolean;
    procedure SetAddress1(Index: Integer; const Astring: string);
    function  Address1_Specified(Index: Integer): boolean;
    procedure SetAddress2(Index: Integer; const Astring: string);
    function  Address2_Specified(Index: Integer): boolean;
    procedure SetCity(Index: Integer; const Astring: string);
    function  City_Specified(Index: Integer): boolean;
    procedure SetState(Index: Integer; const Astring: string);
    function  State_Specified(Index: Integer): boolean;
    procedure SetZip(Index: Integer; const Astring: string);
    function  Zip_Specified(Index: Integer): boolean;
    procedure SetCountryCode(Index: Integer; const Astring: string);
    function  CountryCode_Specified(Index: Integer): boolean;
    procedure SetPhoneNumber(Index: Integer; const Astring: string);
    function  PhoneNumber_Specified(Index: Integer): boolean;
    procedure SetPhoneType(Index: Integer; const Astring: string);
    function  PhoneType_Specified(Index: Integer): boolean;
  published
    property Address1:    string  Index (IS_OPTN) read FAddress1 write SetAddress1 stored Address1_Specified;
    property Address2:    string  Index (IS_OPTN) read FAddress2 write SetAddress2 stored Address2_Specified;
    property City:        string  Index (IS_OPTN) read FCity write SetCity stored City_Specified;
    property State:       string  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zip:         string  Index (IS_OPTN) read FZip write SetZip stored Zip_Specified;
    property CountryCode: string  Index (IS_OPTN) read FCountryCode write SetCountryCode stored CountryCode_Specified;
    property PhoneNumber: string  Index (IS_OPTN) read FPhoneNumber write SetPhoneNumber stored PhoneNumber_Specified;
    property PhoneType:   string  Index (IS_OPTN) read FPhoneType write SetPhoneType stored PhoneType_Specified;
  end;



  // ************************************************************************ //
  // XML       : DynamicCurrency, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  DynamicCurrency = class(TRemotable)
  private
    FOptedIn: string;
    FRateResponseSignature: string;
    FRateResponseSignature_Specified: boolean;
    procedure SetRateResponseSignature(Index: Integer; const Astring: string);
    function  RateResponseSignature_Specified(Index: Integer): boolean;
  published
    property OptedIn:               string  read FOptedIn write FOptedIn;
    property RateResponseSignature: string  Index (IS_OPTN) read FRateResponseSignature write SetRateResponseSignature stored RateResponseSignature_Specified;
  end;



  // ************************************************************************ //
  // XML       : Level3_Type, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  Level3_Type = class(TRemotable)
  private
    FTaxAmount: string;
    FTaxAmount_Specified: boolean;
    FTaxRate: string;
    FTaxRate_Specified: boolean;
    FAltTaxAmount: string;
    FAltTaxAmount_Specified: boolean;
    FAltTaxId: string;
    FAltTaxId_Specified: boolean;
    FDutyAmount: string;
    FDutyAmount_Specified: boolean;
    FFreightAmount: string;
    FFreightAmount_Specified: boolean;
    FDiscountAmount: string;
    FDiscountAmount_Specified: boolean;
    FShipFromZip: string;
    FShipFromZip_Specified: boolean;
    FShipToAddress: Level3_ShipToAddress_Type;
    FLineItem: Array_Of_Level3_LineItem_Type;
    procedure SetTaxAmount(Index: Integer; const Astring: string);
    function  TaxAmount_Specified(Index: Integer): boolean;
    procedure SetTaxRate(Index: Integer; const Astring: string);
    function  TaxRate_Specified(Index: Integer): boolean;
    procedure SetAltTaxAmount(Index: Integer; const Astring: string);
    function  AltTaxAmount_Specified(Index: Integer): boolean;
    procedure SetAltTaxId(Index: Integer; const Astring: string);
    function  AltTaxId_Specified(Index: Integer): boolean;
    procedure SetDutyAmount(Index: Integer; const Astring: string);
    function  DutyAmount_Specified(Index: Integer): boolean;
    procedure SetFreightAmount(Index: Integer; const Astring: string);
    function  FreightAmount_Specified(Index: Integer): boolean;
    procedure SetDiscountAmount(Index: Integer; const Astring: string);
    function  DiscountAmount_Specified(Index: Integer): boolean;
    procedure SetShipFromZip(Index: Integer; const Astring: string);
    function  ShipFromZip_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property TaxAmount:      string                         Index (IS_OPTN) read FTaxAmount write SetTaxAmount stored TaxAmount_Specified;
    property TaxRate:        string                         Index (IS_OPTN) read FTaxRate write SetTaxRate stored TaxRate_Specified;
    property AltTaxAmount:   string                         Index (IS_OPTN) read FAltTaxAmount write SetAltTaxAmount stored AltTaxAmount_Specified;
    property AltTaxId:       string                         Index (IS_OPTN) read FAltTaxId write SetAltTaxId stored AltTaxId_Specified;
    property DutyAmount:     string                         Index (IS_OPTN) read FDutyAmount write SetDutyAmount stored DutyAmount_Specified;
    property FreightAmount:  string                         Index (IS_OPTN) read FFreightAmount write SetFreightAmount stored FreightAmount_Specified;
    property DiscountAmount: string                         Index (IS_OPTN) read FDiscountAmount write SetDiscountAmount stored DiscountAmount_Specified;
    property ShipFromZip:    string                         Index (IS_OPTN) read FShipFromZip write SetShipFromZip stored ShipFromZip_Specified;
    property ShipToAddress:  Level3_ShipToAddress_Type      read FShipToAddress write FShipToAddress;
    property LineItem:       Array_Of_Level3_LineItem_Type  Index (IS_UNBD) read FLineItem write FLineItem;
  end;



  // ************************************************************************ //
  // XML       : PaypalTransactionDetails, global, <complexType>
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes
  // ************************************************************************ //
  PaypalTransactionDetails = class(TRemotable)
  private
    FPayerID: string;
    FPayerID_Specified: boolean;
    FGrossAmountCurrencyID: string;
    FGrossAmountCurrencyID_Specified: boolean;
    FSuccess: Boolean;
    FAuthorization: string;
    FAuthorization_Specified: boolean;
    FMessage_: string;
    FMessage__Specified: boolean;
    FCorrelationID: string;
    FCorrelationID_Specified: boolean;
    FTimestamp: string;
    FTimestamp_Specified: boolean;
    procedure SetPayerID(Index: Integer; const Astring: string);
    function  PayerID_Specified(Index: Integer): boolean;
    procedure SetGrossAmountCurrencyID(Index: Integer; const Astring: string);
    function  GrossAmountCurrencyID_Specified(Index: Integer): boolean;
    procedure SetAuthorization(Index: Integer; const Astring: string);
    function  Authorization_Specified(Index: Integer): boolean;
    procedure SetMessage_(Index: Integer; const Astring: string);
    function  Message__Specified(Index: Integer): boolean;
    procedure SetCorrelationID(Index: Integer; const Astring: string);
    function  CorrelationID_Specified(Index: Integer): boolean;
    procedure SetTimestamp(Index: Integer; const Astring: string);
    function  Timestamp_Specified(Index: Integer): boolean;
  published
    property PayerID:               string   Index (IS_OPTN) read FPayerID write SetPayerID stored PayerID_Specified;
    property GrossAmountCurrencyID: string   Index (IS_OPTN) read FGrossAmountCurrencyID write SetGrossAmountCurrencyID stored GrossAmountCurrencyID_Specified;
    property Success:               Boolean  read FSuccess write FSuccess;
    property Authorization:         string   Index (IS_OPTN) read FAuthorization write SetAuthorization stored Authorization_Specified;
    property Message_:              string   Index (IS_OPTN) read FMessage_ write SetMessage_ stored Message__Specified;
    property CorrelationID:         string   Index (IS_OPTN) read FCorrelationID write SetCorrelationID stored CorrelationID_Specified;
    property Timestamp:             string   Index (IS_OPTN) read FTimestamp write SetTimestamp stored Timestamp_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/Request
  // soapAction: http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : ServiceSoap
  // service   : Service
  // port      : ServiceSoap
  // URL       : https://api.globalgatewaye4.firstdata.com/transaction/v24
  // ************************************************************************ //
  ServiceSoap = interface(IInvokable)
  ['{0DB900A4-F3D9-010F-3658-CC6D14ACC3F9}']
    function  SendAndCommit(const SendAndCommitSource: Transaction): TransactionResult; stdcall;
    function  SendAndCommitCheck(const SendAndCommitCheckSource: CheckTransaction): CheckTransactionResult; stdcall;
    function  TransactionInfo(const TransactionInfoSource: Transaction): TransactionResult; stdcall;
    function  CheckTransactionInfo(const CheckTransactionInfoSource: CheckTransaction): CheckTransactionResult; stdcall;
  end;

function GetServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ServiceSoap;


implementation

uses
  {$IfDef VER220}
  Sysutils
  {$Else}
  System.Sysutils
  {$EndIf}
  ;

function GetServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ServiceSoap;
const
  defWSDL = 'https://api.globalgatewaye4.firstdata.com/transaction/v24/wsdl';
  defURL  = 'https://api.globalgatewaye4.firstdata.com/transaction/v24';
  defSvc  = 'Service';
  defPrt  = 'ServiceSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ServiceSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure SoftDescriptor_Type.SetDBAName(Index: Integer; const Astring: string);
begin
  FDBAName := Astring;
  FDBAName_Specified := True;
end;

function SoftDescriptor_Type.DBAName_Specified(Index: Integer): boolean;
begin
  Result := FDBAName_Specified;
end;

procedure SoftDescriptor_Type.SetStreet(Index: Integer; const Astring: string);
begin
  FStreet := Astring;
  FStreet_Specified := True;
end;

function SoftDescriptor_Type.Street_Specified(Index: Integer): boolean;
begin
  Result := FStreet_Specified;
end;

procedure SoftDescriptor_Type.SetCity(Index: Integer; const Astring: string);
begin
  FCity := Astring;
  FCity_Specified := True;
end;

function SoftDescriptor_Type.City_Specified(Index: Integer): boolean;
begin
  Result := FCity_Specified;
end;

procedure SoftDescriptor_Type.SetRegion(Index: Integer; const Astring: string);
begin
  FRegion := Astring;
  FRegion_Specified := True;
end;

function SoftDescriptor_Type.Region_Specified(Index: Integer): boolean;
begin
  Result := FRegion_Specified;
end;

procedure SoftDescriptor_Type.SetPostalCode(Index: Integer; const Astring: string);
begin
  FPostalCode := Astring;
  FPostalCode_Specified := True;
end;

function SoftDescriptor_Type.PostalCode_Specified(Index: Integer): boolean;
begin
  Result := FPostalCode_Specified;
end;

procedure SoftDescriptor_Type.SetCountryCode(Index: Integer; const Astring: string);
begin
  FCountryCode := Astring;
  FCountryCode_Specified := True;
end;

function SoftDescriptor_Type.CountryCode_Specified(Index: Integer): boolean;
begin
  Result := FCountryCode_Specified;
end;

procedure SoftDescriptor_Type.SetMID(Index: Integer; const Astring: string);
begin
  FMID := Astring;
  FMID_Specified := True;
end;

function SoftDescriptor_Type.MID_Specified(Index: Integer): boolean;
begin
  Result := FMID_Specified;
end;

procedure SoftDescriptor_Type.SetMCC(Index: Integer; const Astring: string);
begin
  FMCC := Astring;
  FMCC_Specified := True;
end;

function SoftDescriptor_Type.MCC_Specified(Index: Integer): boolean;
begin
  Result := FMCC_Specified;
end;

procedure SoftDescriptor_Type.SetMerchantContactInfo(Index: Integer; const Astring: string);
begin
  FMerchantContactInfo := Astring;
  FMerchantContactInfo_Specified := True;
end;

function SoftDescriptor_Type.MerchantContactInfo_Specified(Index: Integer): boolean;
begin
  Result := FMerchantContactInfo_Specified;
end;

procedure SoftDescriptor_Type.SetMVV_MAID(Index: Integer; const Astring: string);
begin
  FMVV_MAID := Astring;
  FMVV_MAID_Specified := True;
end;

function SoftDescriptor_Type.MVV_MAID_Specified(Index: Integer): boolean;
begin
  Result := FMVV_MAID_Specified;
end;

procedure SoftDescriptor_Type.SetAMEXMerchantPhone(Index: Integer; const Astring: string);
begin
  FAMEXMerchantPhone := Astring;
  FAMEXMerchantPhone_Specified := True;
end;

function SoftDescriptor_Type.AMEXMerchantPhone_Specified(Index: Integer): boolean;
begin
  Result := FAMEXMerchantPhone_Specified;
end;

procedure SoftDescriptor_Type.SetAMEXMerchantEmail(Index: Integer; const Astring: string);
begin
  FAMEXMerchantEmail := Astring;
  FAMEXMerchantEmail_Specified := True;
end;

function SoftDescriptor_Type.AMEXMerchantEmail_Specified(Index: Integer): boolean;
begin
  Result := FAMEXMerchantEmail_Specified;
end;

procedure SoftDescriptor_Type.SetPFacSubmerchantId(Index: Integer; const Astring: string);
begin
  FPFacSubmerchantId := Astring;
  FPFacSubmerchantId_Specified := True;
end;

function SoftDescriptor_Type.PFacSubmerchantId_Specified(Index: Integer): boolean;
begin
  Result := FPFacSubmerchantId_Specified;
end;

procedure SoftDescriptor_Type.SetPFacName(Index: Integer; const Astring: string);
begin
  FPFacName := Astring;
  FPFacName_Specified := True;
end;

function SoftDescriptor_Type.PFacName_Specified(Index: Integer): boolean;
begin
  Result := FPFacName_Specified;
end;

procedure Level3_ShipToAddress_Type.SetAddress1(Index: Integer; const Astring: string);
begin
  FAddress1 := Astring;
  FAddress1_Specified := True;
end;

function Level3_ShipToAddress_Type.Address1_Specified(Index: Integer): boolean;
begin
  Result := FAddress1_Specified;
end;

procedure Level3_ShipToAddress_Type.SetCity(Index: Integer; const Astring: string);
begin
  FCity := Astring;
  FCity_Specified := True;
end;

function Level3_ShipToAddress_Type.City_Specified(Index: Integer): boolean;
begin
  Result := FCity_Specified;
end;

procedure Level3_ShipToAddress_Type.SetState(Index: Integer; const Astring: string);
begin
  FState := Astring;
  FState_Specified := True;
end;

function Level3_ShipToAddress_Type.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure Level3_ShipToAddress_Type.SetCountry(Index: Integer; const Astring: string);
begin
  FCountry := Astring;
  FCountry_Specified := True;
end;

function Level3_ShipToAddress_Type.Country_Specified(Index: Integer): boolean;
begin
  Result := FCountry_Specified;
end;

procedure Level3_ShipToAddress_Type.SetCustomerNumber(Index: Integer; const Astring: string);
begin
  FCustomerNumber := Astring;
  FCustomerNumber_Specified := True;
end;

function Level3_ShipToAddress_Type.CustomerNumber_Specified(Index: Integer): boolean;
begin
  Result := FCustomerNumber_Specified;
end;

procedure Level3_ShipToAddress_Type.SetEmail(Index: Integer; const Astring: string);
begin
  FEmail := Astring;
  FEmail_Specified := True;
end;

function Level3_ShipToAddress_Type.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure Level3_ShipToAddress_Type.SetPhone(Index: Integer; const Astring: string);
begin
  FPhone := Astring;
  FPhone_Specified := True;
end;

function Level3_ShipToAddress_Type.Phone_Specified(Index: Integer): boolean;
begin
  Result := FPhone_Specified;
end;

procedure Level3_ShipToAddress_Type.SetName_(Index: Integer; const Astring: string);
begin
  FName_ := Astring;
  FName__Specified := True;
end;

function Level3_ShipToAddress_Type.Name__Specified(Index: Integer): boolean;
begin
  Result := FName__Specified;
end;

procedure Level3_ShipToAddress_Type.SetZip(Index: Integer; const Astring: string);
begin
  FZip := Astring;
  FZip_Specified := True;
end;

function Level3_ShipToAddress_Type.Zip_Specified(Index: Integer): boolean;
begin
  Result := FZip_Specified;
end;

procedure DynamicPricing.SetRateResponseSignature(Index: Integer; const Astring: string);
begin
  FRateResponseSignature := Astring;
  FRateResponseSignature_Specified := True;
end;

function DynamicPricing.RateResponseSignature_Specified(Index: Integer): boolean;
begin
  Result := FRateResponseSignature_Specified;
end;

procedure VisaCheckout.SetPromoCode(Index: Integer; const Astring: string);
begin
  FPromoCode := Astring;
  FPromoCode_Specified := True;
end;

function VisaCheckout.PromoCode_Specified(Index: Integer): boolean;
begin
  Result := FPromoCode_Specified;
end;

procedure ForeignCurrencyDetails.SetForeignAmount(Index: Integer; const Astring: string);
begin
  FForeignAmount := Astring;
  FForeignAmount_Specified := True;
end;

function ForeignCurrencyDetails.ForeignAmount_Specified(Index: Integer): boolean;
begin
  Result := FForeignAmount_Specified;
end;

procedure ForeignCurrencyDetails.SetForeignCurrencyCode(Index: Integer; const Astring: string);
begin
  FForeignCurrencyCode := Astring;
  FForeignCurrencyCode_Specified := True;
end;

function ForeignCurrencyDetails.ForeignCurrencyCode_Specified(Index: Integer): boolean;
begin
  Result := FForeignCurrencyCode_Specified;
end;

procedure ForeignCurrencyDetails.SetExchangeRate(Index: Integer; const Astring: string);
begin
  FExchangeRate := Astring;
  FExchangeRate_Specified := True;
end;

function ForeignCurrencyDetails.ExchangeRate_Specified(Index: Integer): boolean;
begin
  Result := FExchangeRate_Specified;
end;

procedure ForeignCurrencyDetails.SetMarginRate(Index: Integer; const Astring: string);
begin
  FMarginRate := Astring;
  FMarginRate_Specified := True;
end;

function ForeignCurrencyDetails.MarginRate_Specified(Index: Integer): boolean;
begin
  Result := FMarginRate_Specified;
end;

procedure ForeignCurrencyDetails.SetRateSource(Index: Integer; const Astring: string);
begin
  FRateSource := Astring;
  FRateSource_Specified := True;
end;

function ForeignCurrencyDetails.RateSource_Specified(Index: Integer): boolean;
begin
  Result := FRateSource_Specified;
end;

procedure Level3_LineItem_Type.SetCommodityCode(Index: Integer; const Astring: string);
begin
  FCommodityCode := Astring;
  FCommodityCode_Specified := True;
end;

function Level3_LineItem_Type.CommodityCode_Specified(Index: Integer): boolean;
begin
  Result := FCommodityCode_Specified;
end;

procedure Level3_LineItem_Type.SetDiscountAmount(Index: Integer; const Astring: string);
begin
  FDiscountAmount := Astring;
  FDiscountAmount_Specified := True;
end;

function Level3_LineItem_Type.DiscountAmount_Specified(Index: Integer): boolean;
begin
  Result := FDiscountAmount_Specified;
end;

procedure Level3_LineItem_Type.SetDiscountIndicator(Index: Integer; const ABoolean: Boolean);
begin
  FDiscountIndicator := ABoolean;
  FDiscountIndicator_Specified := True;
end;

function Level3_LineItem_Type.DiscountIndicator_Specified(Index: Integer): boolean;
begin
  Result := FDiscountIndicator_Specified;
end;

procedure Level3_LineItem_Type.SetGrossNetIndicator(Index: Integer; const ABoolean: Boolean);
begin
  FGrossNetIndicator := ABoolean;
  FGrossNetIndicator_Specified := True;
end;

function Level3_LineItem_Type.GrossNetIndicator_Specified(Index: Integer): boolean;
begin
  Result := FGrossNetIndicator_Specified;
end;

procedure Level3_LineItem_Type.SetProductCode(Index: Integer; const Astring: string);
begin
  FProductCode := Astring;
  FProductCode_Specified := True;
end;

function Level3_LineItem_Type.ProductCode_Specified(Index: Integer): boolean;
begin
  Result := FProductCode_Specified;
end;

procedure Level3_LineItem_Type.SetTaxAmount(Index: Integer; const Astring: string);
begin
  FTaxAmount := Astring;
  FTaxAmount_Specified := True;
end;

function Level3_LineItem_Type.TaxAmount_Specified(Index: Integer): boolean;
begin
  Result := FTaxAmount_Specified;
end;

procedure Level3_LineItem_Type.SetTaxRate(Index: Integer; const Astring: string);
begin
  FTaxRate := Astring;
  FTaxRate_Specified := True;
end;

function Level3_LineItem_Type.TaxRate_Specified(Index: Integer): boolean;
begin
  Result := FTaxRate_Specified;
end;

procedure Level3_LineItem_Type.SetTaxType(Index: Integer; const Astring: string);
begin
  FTaxType := Astring;
  FTaxType_Specified := True;
end;

function Level3_LineItem_Type.TaxType_Specified(Index: Integer): boolean;
begin
  Result := FTaxType_Specified;
end;

procedure Level3_LineItem_Type.SetUnitOfMeasure(Index: Integer; const Astring: string);
begin
  FUnitOfMeasure := Astring;
  FUnitOfMeasure_Specified := True;
end;

function Level3_LineItem_Type.UnitOfMeasure_Specified(Index: Integer): boolean;
begin
  Result := FUnitOfMeasure_Specified;
end;

destructor CheckTransaction.Destroy;
begin
  SysUtils.FreeAndNil(FAddress);
  SysUtils.FreeAndNil(FSoftDescriptor);
  inherited Destroy;
end;

procedure CheckTransaction.SetCheckType(Index: Integer; const Astring: string);
begin
  FCheckType := Astring;
  FCheckType_Specified := True;
end;

function CheckTransaction.CheckType_Specified(Index: Integer): boolean;
begin
  Result := FCheckType_Specified;
end;

procedure CheckTransaction.SetMICR(Index: Integer; const Astring: string);
begin
  FMICR := Astring;
  FMICR_Specified := True;
end;

function CheckTransaction.MICR_Specified(Index: Integer): boolean;
begin
  Result := FMICR_Specified;
end;

procedure CheckTransaction.SetCheckNumber(Index: Integer; const Astring: string);
begin
  FCheckNumber := Astring;
  FCheckNumber_Specified := True;
end;

function CheckTransaction.CheckNumber_Specified(Index: Integer): boolean;
begin
  Result := FCheckNumber_Specified;
end;

procedure CheckTransaction.SetBankAccountNumber(Index: Integer; const Astring: string);
begin
  FBankAccountNumber := Astring;
  FBankAccountNumber_Specified := True;
end;

function CheckTransaction.BankAccountNumber_Specified(Index: Integer): boolean;
begin
  Result := FBankAccountNumber_Specified;
end;

procedure CheckTransaction.SetBankRoutingNumber(Index: Integer; const Astring: string);
begin
  FBankRoutingNumber := Astring;
  FBankRoutingNumber_Specified := True;
end;

function CheckTransaction.BankRoutingNumber_Specified(Index: Integer): boolean;
begin
  Result := FBankRoutingNumber_Specified;
end;

procedure CheckTransaction.SetTransaction_Tag(Index: Integer; const Astring: string);
begin
  FTransaction_Tag := Astring;
  FTransaction_Tag_Specified := True;
end;

function CheckTransaction.Transaction_Tag_Specified(Index: Integer): boolean;
begin
  Result := FTransaction_Tag_Specified;
end;

procedure CheckTransaction.SetSplitTenderID(Index: Integer; const Astring: string);
begin
  FSplitTenderID := Astring;
  FSplitTenderID_Specified := True;
end;

function CheckTransaction.SplitTenderID_Specified(Index: Integer): boolean;
begin
  Result := FSplitTenderID_Specified;
end;

procedure CheckTransaction.SetAuthorization_Num(Index: Integer; const Astring: string);
begin
  FAuthorization_Num := Astring;
  FAuthorization_Num_Specified := True;
end;

function CheckTransaction.Authorization_Num_Specified(Index: Integer): boolean;
begin
  Result := FAuthorization_Num_Specified;
end;

procedure CheckTransaction.SetCustomerName(Index: Integer; const Astring: string);
begin
  FCustomerName := Astring;
  FCustomerName_Specified := True;
end;

function CheckTransaction.CustomerName_Specified(Index: Integer): boolean;
begin
  Result := FCustomerName_Specified;
end;

procedure CheckTransaction.SetEcommerce_Flag(Index: Integer; const Astring: string);
begin
  FEcommerce_Flag := Astring;
  FEcommerce_Flag_Specified := True;
end;

function CheckTransaction.Ecommerce_Flag_Specified(Index: Integer): boolean;
begin
  Result := FEcommerce_Flag_Specified;
end;

procedure CheckTransaction.SetReference_No(Index: Integer; const Astring: string);
begin
  FReference_No := Astring;
  FReference_No_Specified := True;
end;

function CheckTransaction.Reference_No_Specified(Index: Integer): boolean;
begin
  Result := FReference_No_Specified;
end;

procedure CheckTransaction.SetCustomer_Ref(Index: Integer; const Astring: string);
begin
  FCustomer_Ref := Astring;
  FCustomer_Ref_Specified := True;
end;

function CheckTransaction.Customer_Ref_Specified(Index: Integer): boolean;
begin
  Result := FCustomer_Ref_Specified;
end;

procedure CheckTransaction.SetLanguage(Index: Integer; const Astring: string);
begin
  FLanguage := Astring;
  FLanguage_Specified := True;
end;

function CheckTransaction.Language_Specified(Index: Integer): boolean;
begin
  Result := FLanguage_Specified;
end;

procedure CheckTransaction.SetClient_IP(Index: Integer; const Astring: string);
begin
  FClient_IP := Astring;
  FClient_IP_Specified := True;
end;

function CheckTransaction.Client_IP_Specified(Index: Integer): boolean;
begin
  Result := FClient_IP_Specified;
end;

procedure CheckTransaction.SetClient_Email(Index: Integer; const Astring: string);
begin
  FClient_Email := Astring;
  FClient_Email_Specified := True;
end;

function CheckTransaction.Client_Email_Specified(Index: Integer): boolean;
begin
  Result := FClient_Email_Specified;
end;

procedure CheckTransaction.SetUser_Name(Index: Integer; const Astring: string);
begin
  FUser_Name := Astring;
  FUser_Name_Specified := True;
end;

function CheckTransaction.User_Name_Specified(Index: Integer): boolean;
begin
  Result := FUser_Name_Specified;
end;

procedure CheckTransaction.SetCustomerIDType(Index: Integer; const AInt64: Int64);
begin
  FCustomerIDType := AInt64;
  FCustomerIDType_Specified := True;
end;

function CheckTransaction.CustomerIDType_Specified(Index: Integer): boolean;
begin
  Result := FCustomerIDType_Specified;
end;

procedure CheckTransaction.SetCustomerID(Index: Integer; const Astring: string);
begin
  FCustomerID := Astring;
  FCustomerID_Specified := True;
end;

function CheckTransaction.CustomerID_Specified(Index: Integer): boolean;
begin
  Result := FCustomerID_Specified;
end;

procedure CheckTransaction.SetReleaseType(Index: Integer; const Astring: string);
begin
  FReleaseType := Astring;
  FReleaseType_Specified := True;
end;

function CheckTransaction.ReleaseType_Specified(Index: Integer): boolean;
begin
  Result := FReleaseType_Specified;
end;

procedure CheckTransaction.SetGiftCardAmount(Index: Integer; const Astring: string);
begin
  FGiftCardAmount := Astring;
  FGiftCardAmount_Specified := True;
end;

function CheckTransaction.GiftCardAmount_Specified(Index: Integer): boolean;
begin
  Result := FGiftCardAmount_Specified;
end;

procedure CheckTransaction.SetDateOfBirth(Index: Integer; const Astring: string);
begin
  FDateOfBirth := Astring;
  FDateOfBirth_Specified := True;
end;

function CheckTransaction.DateOfBirth_Specified(Index: Integer): boolean;
begin
  Result := FDateOfBirth_Specified;
end;

procedure CheckTransaction.SetVIP(Index: Integer; const ABoolean: Boolean);
begin
  FVIP := ABoolean;
  FVIP_Specified := True;
end;

function CheckTransaction.VIP_Specified(Index: Integer): boolean;
begin
  Result := FVIP_Specified;
end;

procedure CheckTransaction.SetRegistrationNo(Index: Integer; const Astring: string);
begin
  FRegistrationNo := Astring;
  FRegistrationNo_Specified := True;
end;

function CheckTransaction.RegistrationNo_Specified(Index: Integer): boolean;
begin
  Result := FRegistrationNo_Specified;
end;

procedure CheckTransaction.SetRegistrationDate(Index: Integer; const Astring: string);
begin
  FRegistrationDate := Astring;
  FRegistrationDate_Specified := True;
end;

function CheckTransaction.RegistrationDate_Specified(Index: Integer): boolean;
begin
  Result := FRegistrationDate_Specified;
end;

procedure CheckTransaction.SetClerkID(Index: Integer; const Astring: string);
begin
  FClerkID := Astring;
  FClerkID_Specified := True;
end;

function CheckTransaction.ClerkID_Specified(Index: Integer): boolean;
begin
  Result := FClerkID_Specified;
end;

procedure CheckTransaction.SetDeviceID(Index: Integer; const Astring: string);
begin
  FDeviceID := Astring;
  FDeviceID_Specified := True;
end;

function CheckTransaction.DeviceID_Specified(Index: Integer): boolean;
begin
  Result := FDeviceID_Specified;
end;

procedure CheckTransaction.SetAddress(Index: Integer; const AAddress_Type: Address_Type);
begin
  FAddress := AAddress_Type;
  FAddress_Specified := True;
end;

function CheckTransaction.Address_Specified(Index: Integer): boolean;
begin
  Result := FAddress_Specified;
end;

procedure CheckTransaction.SetTPPID(Index: Integer; const Astring: string);
begin
  FTPPID := Astring;
  FTPPID_Specified := True;
end;

function CheckTransaction.TPPID_Specified(Index: Integer): boolean;
begin
  Result := FTPPID_Specified;
end;

procedure CheckTransaction.SetSplitShipmentNumber(Index: Integer; const Astring: string);
begin
  FSplitShipmentNumber := Astring;
  FSplitShipmentNumber_Specified := True;
end;

function CheckTransaction.SplitShipmentNumber_Specified(Index: Integer): boolean;
begin
  Result := FSplitShipmentNumber_Specified;
end;

procedure CheckTransaction.SetSoftDescriptor(Index: Integer; const ASoftDescriptor_Type: SoftDescriptor_Type);
begin
  FSoftDescriptor := ASoftDescriptor_Type;
  FSoftDescriptor_Specified := True;
end;

function CheckTransaction.SoftDescriptor_Specified(Index: Integer): boolean;
begin
  Result := FSoftDescriptor_Specified;
end;

procedure CheckTransactionResult.SetBank_Resp_Code(Index: Integer; const Astring: string);
begin
  FBank_Resp_Code := Astring;
  FBank_Resp_Code_Specified := True;
end;

function CheckTransactionResult.Bank_Resp_Code_Specified(Index: Integer): boolean;
begin
  Result := FBank_Resp_Code_Specified;
end;

procedure CheckTransactionResult.SetBank_Message(Index: Integer; const Astring: string);
begin
  FBank_Message := Astring;
  FBank_Message_Specified := True;
end;

function CheckTransactionResult.Bank_Message_Specified(Index: Integer): boolean;
begin
  Result := FBank_Message_Specified;
end;

procedure CheckTransactionResult.SetBank_Resp_Code_2(Index: Integer; const Astring: string);
begin
  FBank_Resp_Code_2 := Astring;
  FBank_Resp_Code_2_Specified := True;
end;

function CheckTransactionResult.Bank_Resp_Code_2_Specified(Index: Integer): boolean;
begin
  Result := FBank_Resp_Code_2_Specified;
end;

procedure CheckTransactionResult.SetSequenceNo(Index: Integer; const Astring: string);
begin
  FSequenceNo := Astring;
  FSequenceNo_Specified := True;
end;

function CheckTransactionResult.SequenceNo_Specified(Index: Integer): boolean;
begin
  Result := FSequenceNo_Specified;
end;

procedure CheckTransactionResult.SetMerchantName(Index: Integer; const Astring: string);
begin
  FMerchantName := Astring;
  FMerchantName_Specified := True;
end;

function CheckTransactionResult.MerchantName_Specified(Index: Integer): boolean;
begin
  Result := FMerchantName_Specified;
end;

procedure CheckTransactionResult.SetMerchantAddress(Index: Integer; const Astring: string);
begin
  FMerchantAddress := Astring;
  FMerchantAddress_Specified := True;
end;

function CheckTransactionResult.MerchantAddress_Specified(Index: Integer): boolean;
begin
  Result := FMerchantAddress_Specified;
end;

procedure CheckTransactionResult.SetMerchantCity(Index: Integer; const Astring: string);
begin
  FMerchantCity := Astring;
  FMerchantCity_Specified := True;
end;

function CheckTransactionResult.MerchantCity_Specified(Index: Integer): boolean;
begin
  Result := FMerchantCity_Specified;
end;

procedure CheckTransactionResult.SetMerchantProvince(Index: Integer; const Astring: string);
begin
  FMerchantProvince := Astring;
  FMerchantProvince_Specified := True;
end;

function CheckTransactionResult.MerchantProvince_Specified(Index: Integer): boolean;
begin
  Result := FMerchantProvince_Specified;
end;

procedure CheckTransactionResult.SetMerchantCountry(Index: Integer; const Astring: string);
begin
  FMerchantCountry := Astring;
  FMerchantCountry_Specified := True;
end;

function CheckTransactionResult.MerchantCountry_Specified(Index: Integer): boolean;
begin
  Result := FMerchantCountry_Specified;
end;

procedure CheckTransactionResult.SetMerchantPostal(Index: Integer; const Astring: string);
begin
  FMerchantPostal := Astring;
  FMerchantPostal_Specified := True;
end;

function CheckTransactionResult.MerchantPostal_Specified(Index: Integer): boolean;
begin
  Result := FMerchantPostal_Specified;
end;

procedure CheckTransactionResult.SetMerchantURL(Index: Integer; const Astring: string);
begin
  FMerchantURL := Astring;
  FMerchantURL_Specified := True;
end;

function CheckTransactionResult.MerchantURL_Specified(Index: Integer): boolean;
begin
  Result := FMerchantURL_Specified;
end;

procedure CheckTransactionResult.SetCTR(Index: Integer; const Astring: string);
begin
  FCTR := Astring;
  FCTR_Specified := True;
end;

function CheckTransactionResult.CTR_Specified(Index: Integer): boolean;
begin
  Result := FCTR_Specified;
end;

destructor Transaction.Destroy;
begin
  SysUtils.FreeAndNil(FLevel3);
  SysUtils.FreeAndNil(FPaypalResponse);
  SysUtils.FreeAndNil(FSoftDescriptor);
  SysUtils.FreeAndNil(FAddress);
  SysUtils.FreeAndNil(FDynamicCurrency);
  SysUtils.FreeAndNil(FDynamicPricing);
  SysUtils.FreeAndNil(FVisaCheckout);
  SysUtils.FreeAndNil(FMasterPass);
  inherited Destroy;
end;

procedure Transaction.SetDollarAmount(Index: Integer; const Astring: string);
begin
  FDollarAmount := Astring;
  FDollarAmount_Specified := True;
end;

function Transaction.DollarAmount_Specified(Index: Integer): boolean;
begin
  Result := FDollarAmount_Specified;
end;

procedure Transaction.SetSurchargeAmount(Index: Integer; const Astring: string);
begin
  FSurchargeAmount := Astring;
  FSurchargeAmount_Specified := True;
end;

function Transaction.SurchargeAmount_Specified(Index: Integer): boolean;
begin
  Result := FSurchargeAmount_Specified;
end;

procedure Transaction.SetCard_Number(Index: Integer; const Astring: string);
begin
  FCard_Number := Astring;
  FCard_Number_Specified := True;
end;

function Transaction.Card_Number_Specified(Index: Integer): boolean;
begin
  Result := FCard_Number_Specified;
end;

procedure Transaction.SetTransaction_Tag(Index: Integer; const Astring: string);
begin
  FTransaction_Tag := Astring;
  FTransaction_Tag_Specified := True;
end;

function Transaction.Transaction_Tag_Specified(Index: Integer): boolean;
begin
  Result := FTransaction_Tag_Specified;
end;

procedure Transaction.SetSplitTenderID(Index: Integer; const Astring: string);
begin
  FSplitTenderID := Astring;
  FSplitTenderID_Specified := True;
end;

function Transaction.SplitTenderID_Specified(Index: Integer): boolean;
begin
  Result := FSplitTenderID_Specified;
end;

procedure Transaction.SetTrack1(Index: Integer; const Astring: string);
begin
  FTrack1 := Astring;
  FTrack1_Specified := True;
end;

function Transaction.Track1_Specified(Index: Integer): boolean;
begin
  Result := FTrack1_Specified;
end;

procedure Transaction.SetTrack2(Index: Integer; const Astring: string);
begin
  FTrack2 := Astring;
  FTrack2_Specified := True;
end;

function Transaction.Track2_Specified(Index: Integer): boolean;
begin
  Result := FTrack2_Specified;
end;

procedure Transaction.SetPAN(Index: Integer; const Astring: string);
begin
  FPAN := Astring;
  FPAN_Specified := True;
end;

function Transaction.PAN_Specified(Index: Integer): boolean;
begin
  Result := FPAN_Specified;
end;

procedure Transaction.SetAuthorization_Num(Index: Integer; const Astring: string);
begin
  FAuthorization_Num := Astring;
  FAuthorization_Num_Specified := True;
end;

function Transaction.Authorization_Num_Specified(Index: Integer): boolean;
begin
  Result := FAuthorization_Num_Specified;
end;

procedure Transaction.SetExpiry_Date(Index: Integer; const Astring: string);
begin
  FExpiry_Date := Astring;
  FExpiry_Date_Specified := True;
end;

function Transaction.Expiry_Date_Specified(Index: Integer): boolean;
begin
  Result := FExpiry_Date_Specified;
end;

procedure Transaction.SetCardHoldersName(Index: Integer; const Astring: string);
begin
  FCardHoldersName := Astring;
  FCardHoldersName_Specified := True;
end;

function Transaction.CardHoldersName_Specified(Index: Integer): boolean;
begin
  Result := FCardHoldersName_Specified;
end;

procedure Transaction.SetCVDCode(Index: Integer; const Astring: string);
begin
  FCVDCode := Astring;
  FCVDCode_Specified := True;
end;

function Transaction.CVDCode_Specified(Index: Integer): boolean;
begin
  Result := FCVDCode_Specified;
end;

procedure Transaction.SetCVD_Presence_Ind(Index: Integer; const Astring: string);
begin
  FCVD_Presence_Ind := Astring;
  FCVD_Presence_Ind_Specified := True;
end;

function Transaction.CVD_Presence_Ind_Specified(Index: Integer): boolean;
begin
  Result := FCVD_Presence_Ind_Specified;
end;

procedure Transaction.SetZipCode(Index: Integer; const Astring: string);
begin
  FZipCode := Astring;
  FZipCode_Specified := True;
end;

function Transaction.ZipCode_Specified(Index: Integer): boolean;
begin
  Result := FZipCode_Specified;
end;

procedure Transaction.SetTax1Amount(Index: Integer; const Astring: string);
begin
  FTax1Amount := Astring;
  FTax1Amount_Specified := True;
end;

function Transaction.Tax1Amount_Specified(Index: Integer): boolean;
begin
  Result := FTax1Amount_Specified;
end;

procedure Transaction.SetTax1Number(Index: Integer; const Astring: string);
begin
  FTax1Number := Astring;
  FTax1Number_Specified := True;
end;

function Transaction.Tax1Number_Specified(Index: Integer): boolean;
begin
  Result := FTax1Number_Specified;
end;

procedure Transaction.SetTax2Amount(Index: Integer; const Astring: string);
begin
  FTax2Amount := Astring;
  FTax2Amount_Specified := True;
end;

function Transaction.Tax2Amount_Specified(Index: Integer): boolean;
begin
  Result := FTax2Amount_Specified;
end;

procedure Transaction.SetTax2Number(Index: Integer; const Astring: string);
begin
  FTax2Number := Astring;
  FTax2Number_Specified := True;
end;

function Transaction.Tax2Number_Specified(Index: Integer): boolean;
begin
  Result := FTax2Number_Specified;
end;

procedure Transaction.SetSecure_AuthRequired(Index: Integer; const Astring: string);
begin
  FSecure_AuthRequired := Astring;
  FSecure_AuthRequired_Specified := True;
end;

function Transaction.Secure_AuthRequired_Specified(Index: Integer): boolean;
begin
  Result := FSecure_AuthRequired_Specified;
end;

procedure Transaction.SetSecure_AuthResult(Index: Integer; const Astring: string);
begin
  FSecure_AuthResult := Astring;
  FSecure_AuthResult_Specified := True;
end;

function Transaction.Secure_AuthResult_Specified(Index: Integer): boolean;
begin
  Result := FSecure_AuthResult_Specified;
end;

procedure Transaction.SetEcommerce_Flag(Index: Integer; const Astring: string);
begin
  FEcommerce_Flag := Astring;
  FEcommerce_Flag_Specified := True;
end;

function Transaction.Ecommerce_Flag_Specified(Index: Integer): boolean;
begin
  Result := FEcommerce_Flag_Specified;
end;

procedure Transaction.SetXID(Index: Integer; const Astring: string);
begin
  FXID := Astring;
  FXID_Specified := True;
end;

function Transaction.XID_Specified(Index: Integer): boolean;
begin
  Result := FXID_Specified;
end;

procedure Transaction.SetCAVV(Index: Integer; const Astring: string);
begin
  FCAVV := Astring;
  FCAVV_Specified := True;
end;

function Transaction.CAVV_Specified(Index: Integer): boolean;
begin
  Result := FCAVV_Specified;
end;

procedure Transaction.SetReference_No(Index: Integer; const Astring: string);
begin
  FReference_No := Astring;
  FReference_No_Specified := True;
end;

function Transaction.Reference_No_Specified(Index: Integer): boolean;
begin
  Result := FReference_No_Specified;
end;

procedure Transaction.SetCustomer_Ref(Index: Integer; const Astring: string);
begin
  FCustomer_Ref := Astring;
  FCustomer_Ref_Specified := True;
end;

function Transaction.Customer_Ref_Specified(Index: Integer): boolean;
begin
  Result := FCustomer_Ref_Specified;
end;

procedure Transaction.SetReference_3(Index: Integer; const Astring: string);
begin
  FReference_3 := Astring;
  FReference_3_Specified := True;
end;

function Transaction.Reference_3_Specified(Index: Integer): boolean;
begin
  Result := FReference_3_Specified;
end;

procedure Transaction.SetLanguage(Index: Integer; const Astring: string);
begin
  FLanguage := Astring;
  FLanguage_Specified := True;
end;

function Transaction.Language_Specified(Index: Integer): boolean;
begin
  Result := FLanguage_Specified;
end;

procedure Transaction.SetClient_IP(Index: Integer; const Astring: string);
begin
  FClient_IP := Astring;
  FClient_IP_Specified := True;
end;

function Transaction.Client_IP_Specified(Index: Integer): boolean;
begin
  Result := FClient_IP_Specified;
end;

procedure Transaction.SetClient_Email(Index: Integer; const Astring: string);
begin
  FClient_Email := Astring;
  FClient_Email_Specified := True;
end;

function Transaction.Client_Email_Specified(Index: Integer): boolean;
begin
  Result := FClient_Email_Specified;
end;

procedure Transaction.SetUser_Name(Index: Integer; const Astring: string);
begin
  FUser_Name := Astring;
  FUser_Name_Specified := True;
end;

function Transaction.User_Name_Specified(Index: Integer): boolean;
begin
  Result := FUser_Name_Specified;
end;

procedure Transaction.SetCurrency(Index: Integer; const Astring: string);
begin
  FCurrency := Astring;
  FCurrency_Specified := True;
end;

function Transaction.Currency_Specified(Index: Integer): boolean;
begin
  Result := FCurrency_Specified;
end;

procedure Transaction.SetPartialRedemption(Index: Integer; const ABoolean: Boolean);
begin
  FPartialRedemption := ABoolean;
  FPartialRedemption_Specified := True;
end;

function Transaction.PartialRedemption_Specified(Index: Integer): boolean;
begin
  Result := FPartialRedemption_Specified;
end;

procedure Transaction.SetLevel3(Index: Integer; const ALevel3_Type: Level3_Type);
begin
  FLevel3 := ALevel3_Type;
  FLevel3_Specified := True;
end;

function Transaction.Level3_Specified(Index: Integer): boolean;
begin
  Result := FLevel3_Specified;
end;

procedure Transaction.SetTransarmorToken(Index: Integer; const Astring: string);
begin
  FTransarmorToken := Astring;
  FTransarmorToken_Specified := True;
end;

function Transaction.TransarmorToken_Specified(Index: Integer): boolean;
begin
  Result := FTransarmorToken_Specified;
end;

procedure Transaction.SetCardType(Index: Integer; const Astring: string);
begin
  FCardType := Astring;
  FCardType_Specified := True;
end;

function Transaction.CardType_Specified(Index: Integer): boolean;
begin
  Result := FCardType_Specified;
end;

procedure Transaction.SetEAN(Index: Integer; const Astring: string);
begin
  FEAN := Astring;
  FEAN_Specified := True;
end;

function Transaction.EAN_Specified(Index: Integer): boolean;
begin
  Result := FEAN_Specified;
end;

procedure Transaction.SetVirtualCard(Index: Integer; const ABoolean: Boolean);
begin
  FVirtualCard := ABoolean;
  FVirtualCard_Specified := True;
end;

function Transaction.VirtualCard_Specified(Index: Integer): boolean;
begin
  Result := FVirtualCard_Specified;
end;

procedure Transaction.SetCardCost(Index: Integer; const Astring: string);
begin
  FCardCost := Astring;
  FCardCost_Specified := True;
end;

function Transaction.CardCost_Specified(Index: Integer): boolean;
begin
  Result := FCardCost_Specified;
end;

procedure Transaction.SetFraudSuspected(Index: Integer; const Astring: string);
begin
  FFraudSuspected := Astring;
  FFraudSuspected_Specified := True;
end;

function Transaction.FraudSuspected_Specified(Index: Integer): boolean;
begin
  Result := FFraudSuspected_Specified;
end;

procedure Transaction.SetPaypalResponse(Index: Integer; const APaypalTransactionDetails: PaypalTransactionDetails);
begin
  FPaypalResponse := APaypalTransactionDetails;
  FPaypalResponse_Specified := True;
end;

function Transaction.PaypalResponse_Specified(Index: Integer): boolean;
begin
  Result := FPaypalResponse_Specified;
end;

procedure Transaction.SetSoftDescriptor(Index: Integer; const ASoftDescriptor_Type: SoftDescriptor_Type);
begin
  FSoftDescriptor := ASoftDescriptor_Type;
  FSoftDescriptor_Specified := True;
end;

function Transaction.SoftDescriptor_Specified(Index: Integer): boolean;
begin
  Result := FSoftDescriptor_Specified;
end;

procedure Transaction.SetAddress(Index: Integer; const AAddress_Type: Address_Type);
begin
  FAddress := AAddress_Type;
  FAddress_Specified := True;
end;

function Transaction.Address_Specified(Index: Integer): boolean;
begin
  Result := FAddress_Specified;
end;

procedure Transaction.SetTPPID(Index: Integer; const Astring: string);
begin
  FTPPID := Astring;
  FTPPID_Specified := True;
end;

function Transaction.TPPID_Specified(Index: Integer): boolean;
begin
  Result := FTPPID_Specified;
end;

procedure Transaction.SetSplitShipmentNumber(Index: Integer; const Astring: string);
begin
  FSplitShipmentNumber := Astring;
  FSplitShipmentNumber_Specified := True;
end;

function Transaction.SplitShipmentNumber_Specified(Index: Integer): boolean;
begin
  Result := FSplitShipmentNumber_Specified;
end;

procedure Transaction.SetAmexFraud(Index: Integer; const Astring: string);
begin
  FAmexFraud := Astring;
  FAmexFraud_Specified := True;
end;

function Transaction.AmexFraud_Specified(Index: Integer): boolean;
begin
  Result := FAmexFraud_Specified;
end;

procedure Transaction.SetDynamicCurrency(Index: Integer; const ADynamicCurrency: DynamicCurrency);
begin
  FDynamicCurrency := ADynamicCurrency;
  FDynamicCurrency_Specified := True;
end;

function Transaction.DynamicCurrency_Specified(Index: Integer): boolean;
begin
  Result := FDynamicCurrency_Specified;
end;

procedure Transaction.SetDynamicPricing(Index: Integer; const ADynamicPricing: DynamicPricing);
begin
  FDynamicPricing := ADynamicPricing;
  FDynamicPricing_Specified := True;
end;

function Transaction.DynamicPricing_Specified(Index: Integer): boolean;
begin
  Result := FDynamicPricing_Specified;
end;

procedure Transaction.SetFeeAmount(Index: Integer; const Astring: string);
begin
  FFeeAmount := Astring;
  FFeeAmount_Specified := True;
end;

function Transaction.FeeAmount_Specified(Index: Integer): boolean;
begin
  Result := FFeeAmount_Specified;
end;

procedure Transaction.SetVisaCheckout(Index: Integer; const AVisaCheckout: VisaCheckout);
begin
  FVisaCheckout := AVisaCheckout;
  FVisaCheckout_Specified := True;
end;

function Transaction.VisaCheckout_Specified(Index: Integer): boolean;
begin
  Result := FVisaCheckout_Specified;
end;

procedure Transaction.SetPostDate(Index: Integer; const Astring: string);
begin
  FPostDate := Astring;
  FPostDate_Specified := True;
end;

function Transaction.PostDate_Specified(Index: Integer): boolean;
begin
  Result := FPostDate_Specified;
end;

procedure Transaction.SetOtherAmount(Index: Integer; const Astring: string);
begin
  FOtherAmount := Astring;
  FOtherAmount_Specified := True;
end;

function Transaction.OtherAmount_Specified(Index: Integer): boolean;
begin
  Result := FOtherAmount_Specified;
end;

procedure Transaction.SetGiftDepositAvailable(Index: Integer; const Astring: string);
begin
  FGiftDepositAvailable := Astring;
  FGiftDepositAvailable_Specified := True;
end;

function Transaction.GiftDepositAvailable_Specified(Index: Integer): boolean;
begin
  Result := FGiftDepositAvailable_Specified;
end;

procedure Transaction.SetSpecialPayment(Index: Integer; const Astring: string);
begin
  FSpecialPayment := Astring;
  FSpecialPayment_Specified := True;
end;

function Transaction.SpecialPayment_Specified(Index: Integer): boolean;
begin
  Result := FSpecialPayment_Specified;
end;

procedure Transaction.SetWalletProviderID(Index: Integer; const Astring: string);
begin
  FWalletProviderID := Astring;
  FWalletProviderID_Specified := True;
end;

function Transaction.WalletProviderID_Specified(Index: Integer): boolean;
begin
  Result := FWalletProviderID_Specified;
end;

procedure Transaction.SetMasterPass(Index: Integer; const AMasterPass: MasterPass);
begin
  FMasterPass := AMasterPass;
  FMasterPass_Specified := True;
end;

function Transaction.MasterPass_Specified(Index: Integer): boolean;
begin
  Result := FMasterPass_Specified;
end;

destructor TransactionResult.Destroy;
begin
  SysUtils.FreeAndNil(FForeignCurrencyDetails);
  inherited Destroy;
end;

procedure TransactionResult.SetBank_Resp_Code(Index: Integer; const Astring: string);
begin
  FBank_Resp_Code := Astring;
  FBank_Resp_Code_Specified := True;
end;

function TransactionResult.Bank_Resp_Code_Specified(Index: Integer): boolean;
begin
  Result := FBank_Resp_Code_Specified;
end;

procedure TransactionResult.SetBank_Message(Index: Integer; const Astring: string);
begin
  FBank_Message := Astring;
  FBank_Message_Specified := True;
end;

function TransactionResult.Bank_Message_Specified(Index: Integer): boolean;
begin
  Result := FBank_Message_Specified;
end;

procedure TransactionResult.SetBank_Resp_Code_2(Index: Integer; const Astring: string);
begin
  FBank_Resp_Code_2 := Astring;
  FBank_Resp_Code_2_Specified := True;
end;

function TransactionResult.Bank_Resp_Code_2_Specified(Index: Integer): boolean;
begin
  Result := FBank_Resp_Code_2_Specified;
end;

procedure TransactionResult.SetSequenceNo(Index: Integer; const Astring: string);
begin
  FSequenceNo := Astring;
  FSequenceNo_Specified := True;
end;

function TransactionResult.SequenceNo_Specified(Index: Integer): boolean;
begin
  Result := FSequenceNo_Specified;
end;

procedure TransactionResult.SetAVS(Index: Integer; const Astring: string);
begin
  FAVS := Astring;
  FAVS_Specified := True;
end;

function TransactionResult.AVS_Specified(Index: Integer): boolean;
begin
  Result := FAVS_Specified;
end;

procedure TransactionResult.SetCVV2(Index: Integer; const Astring: string);
begin
  FCVV2 := Astring;
  FCVV2_Specified := True;
end;

function TransactionResult.CVV2_Specified(Index: Integer): boolean;
begin
  Result := FCVV2_Specified;
end;

procedure TransactionResult.SetRetrieval_Ref_No(Index: Integer; const Astring: string);
begin
  FRetrieval_Ref_No := Astring;
  FRetrieval_Ref_No_Specified := True;
end;

function TransactionResult.Retrieval_Ref_No_Specified(Index: Integer): boolean;
begin
  Result := FRetrieval_Ref_No_Specified;
end;

procedure TransactionResult.SetCAVV_Response(Index: Integer; const Astring: string);
begin
  FCAVV_Response := Astring;
  FCAVV_Response_Specified := True;
end;

function TransactionResult.CAVV_Response_Specified(Index: Integer): boolean;
begin
  Result := FCAVV_Response_Specified;
end;

procedure TransactionResult.SetAmountRequested(Index: Integer; const Astring: string);
begin
  FAmountRequested := Astring;
  FAmountRequested_Specified := True;
end;

function TransactionResult.AmountRequested_Specified(Index: Integer): boolean;
begin
  Result := FAmountRequested_Specified;
end;

procedure TransactionResult.SetMerchantName(Index: Integer; const Astring: string);
begin
  FMerchantName := Astring;
  FMerchantName_Specified := True;
end;

function TransactionResult.MerchantName_Specified(Index: Integer): boolean;
begin
  Result := FMerchantName_Specified;
end;

procedure TransactionResult.SetMerchantAddress(Index: Integer; const Astring: string);
begin
  FMerchantAddress := Astring;
  FMerchantAddress_Specified := True;
end;

function TransactionResult.MerchantAddress_Specified(Index: Integer): boolean;
begin
  Result := FMerchantAddress_Specified;
end;

procedure TransactionResult.SetMerchantCity(Index: Integer; const Astring: string);
begin
  FMerchantCity := Astring;
  FMerchantCity_Specified := True;
end;

function TransactionResult.MerchantCity_Specified(Index: Integer): boolean;
begin
  Result := FMerchantCity_Specified;
end;

procedure TransactionResult.SetMerchantProvince(Index: Integer; const Astring: string);
begin
  FMerchantProvince := Astring;
  FMerchantProvince_Specified := True;
end;

function TransactionResult.MerchantProvince_Specified(Index: Integer): boolean;
begin
  Result := FMerchantProvince_Specified;
end;

procedure TransactionResult.SetMerchantCountry(Index: Integer; const Astring: string);
begin
  FMerchantCountry := Astring;
  FMerchantCountry_Specified := True;
end;

function TransactionResult.MerchantCountry_Specified(Index: Integer): boolean;
begin
  Result := FMerchantCountry_Specified;
end;

procedure TransactionResult.SetMerchantPostal(Index: Integer; const Astring: string);
begin
  FMerchantPostal := Astring;
  FMerchantPostal_Specified := True;
end;

function TransactionResult.MerchantPostal_Specified(Index: Integer): boolean;
begin
  Result := FMerchantPostal_Specified;
end;

procedure TransactionResult.SetMerchantURL(Index: Integer; const Astring: string);
begin
  FMerchantURL := Astring;
  FMerchantURL_Specified := True;
end;

function TransactionResult.MerchantURL_Specified(Index: Integer): boolean;
begin
  Result := FMerchantURL_Specified;
end;

procedure TransactionResult.SetCurrentBalance(Index: Integer; const Astring: string);
begin
  FCurrentBalance := Astring;
  FCurrentBalance_Specified := True;
end;

function TransactionResult.CurrentBalance_Specified(Index: Integer): boolean;
begin
  Result := FCurrentBalance_Specified;
end;

procedure TransactionResult.SetPreviousBalance(Index: Integer; const Astring: string);
begin
  FPreviousBalance := Astring;
  FPreviousBalance_Specified := True;
end;

function TransactionResult.PreviousBalance_Specified(Index: Integer): boolean;
begin
  Result := FPreviousBalance_Specified;
end;

procedure TransactionResult.SetForeignCurrencyDetails(Index: Integer; const AForeignCurrencyDetails: ForeignCurrencyDetails);
begin
  FForeignCurrencyDetails := AForeignCurrencyDetails;
  FForeignCurrencyDetails_Specified := True;
end;

function TransactionResult.ForeignCurrencyDetails_Specified(Index: Integer): boolean;
begin
  Result := FForeignCurrencyDetails_Specified;
end;

procedure TransactionResult.SetCTR(Index: Integer; const Astring: string);
begin
  FCTR := Astring;
  FCTR_Specified := True;
end;

function TransactionResult.CTR_Specified(Index: Integer): boolean;
begin
  Result := FCTR_Specified;
end;

procedure TransactionResult.SetValueLinkAuthCode(Index: Integer; const Astring: string);
begin
  FValueLinkAuthCode := Astring;
  FValueLinkAuthCode_Specified := True;
end;

function TransactionResult.ValueLinkAuthCode_Specified(Index: Integer): boolean;
begin
  Result := FValueLinkAuthCode_Specified;
end;

procedure TransactionResult.SetLocalCurrencyCode(Index: Integer; const Astring: string);
begin
  FLocalCurrencyCode := Astring;
  FLocalCurrencyCode_Specified := True;
end;

function TransactionResult.LocalCurrencyCode_Specified(Index: Integer): boolean;
begin
  Result := FLocalCurrencyCode_Specified;
end;

procedure TransactionResult.SetPromoDetails(Index: Integer; const Astring: string);
begin
  FPromoDetails := Astring;
  FPromoDetails_Specified := True;
end;

function TransactionResult.PromoDetails_Specified(Index: Integer): boolean;
begin
  Result := FPromoDetails_Specified;
end;

procedure Address_Type.SetAddress1(Index: Integer; const Astring: string);
begin
  FAddress1 := Astring;
  FAddress1_Specified := True;
end;

function Address_Type.Address1_Specified(Index: Integer): boolean;
begin
  Result := FAddress1_Specified;
end;

procedure Address_Type.SetAddress2(Index: Integer; const Astring: string);
begin
  FAddress2 := Astring;
  FAddress2_Specified := True;
end;

function Address_Type.Address2_Specified(Index: Integer): boolean;
begin
  Result := FAddress2_Specified;
end;

procedure Address_Type.SetCity(Index: Integer; const Astring: string);
begin
  FCity := Astring;
  FCity_Specified := True;
end;

function Address_Type.City_Specified(Index: Integer): boolean;
begin
  Result := FCity_Specified;
end;

procedure Address_Type.SetState(Index: Integer; const Astring: string);
begin
  FState := Astring;
  FState_Specified := True;
end;

function Address_Type.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure Address_Type.SetZip(Index: Integer; const Astring: string);
begin
  FZip := Astring;
  FZip_Specified := True;
end;

function Address_Type.Zip_Specified(Index: Integer): boolean;
begin
  Result := FZip_Specified;
end;

procedure Address_Type.SetCountryCode(Index: Integer; const Astring: string);
begin
  FCountryCode := Astring;
  FCountryCode_Specified := True;
end;

function Address_Type.CountryCode_Specified(Index: Integer): boolean;
begin
  Result := FCountryCode_Specified;
end;

procedure Address_Type.SetPhoneNumber(Index: Integer; const Astring: string);
begin
  FPhoneNumber := Astring;
  FPhoneNumber_Specified := True;
end;

function Address_Type.PhoneNumber_Specified(Index: Integer): boolean;
begin
  Result := FPhoneNumber_Specified;
end;

procedure Address_Type.SetPhoneType(Index: Integer; const Astring: string);
begin
  FPhoneType := Astring;
  FPhoneType_Specified := True;
end;

function Address_Type.PhoneType_Specified(Index: Integer): boolean;
begin
  Result := FPhoneType_Specified;
end;

procedure DynamicCurrency.SetRateResponseSignature(Index: Integer; const Astring: string);
begin
  FRateResponseSignature := Astring;
  FRateResponseSignature_Specified := True;
end;

function DynamicCurrency.RateResponseSignature_Specified(Index: Integer): boolean;
begin
  Result := FRateResponseSignature_Specified;
end;

destructor Level3_Type.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FLineItem)-1 do
    SysUtils.FreeAndNil(FLineItem[I]);
  System.SetLength(FLineItem, 0);
  SysUtils.FreeAndNil(FShipToAddress);
  inherited Destroy;
end;

procedure Level3_Type.SetTaxAmount(Index: Integer; const Astring: string);
begin
  FTaxAmount := Astring;
  FTaxAmount_Specified := True;
end;

function Level3_Type.TaxAmount_Specified(Index: Integer): boolean;
begin
  Result := FTaxAmount_Specified;
end;

procedure Level3_Type.SetTaxRate(Index: Integer; const Astring: string);
begin
  FTaxRate := Astring;
  FTaxRate_Specified := True;
end;

function Level3_Type.TaxRate_Specified(Index: Integer): boolean;
begin
  Result := FTaxRate_Specified;
end;

procedure Level3_Type.SetAltTaxAmount(Index: Integer; const Astring: string);
begin
  FAltTaxAmount := Astring;
  FAltTaxAmount_Specified := True;
end;

function Level3_Type.AltTaxAmount_Specified(Index: Integer): boolean;
begin
  Result := FAltTaxAmount_Specified;
end;

procedure Level3_Type.SetAltTaxId(Index: Integer; const Astring: string);
begin
  FAltTaxId := Astring;
  FAltTaxId_Specified := True;
end;

function Level3_Type.AltTaxId_Specified(Index: Integer): boolean;
begin
  Result := FAltTaxId_Specified;
end;

procedure Level3_Type.SetDutyAmount(Index: Integer; const Astring: string);
begin
  FDutyAmount := Astring;
  FDutyAmount_Specified := True;
end;

function Level3_Type.DutyAmount_Specified(Index: Integer): boolean;
begin
  Result := FDutyAmount_Specified;
end;

procedure Level3_Type.SetFreightAmount(Index: Integer; const Astring: string);
begin
  FFreightAmount := Astring;
  FFreightAmount_Specified := True;
end;

function Level3_Type.FreightAmount_Specified(Index: Integer): boolean;
begin
  Result := FFreightAmount_Specified;
end;

procedure Level3_Type.SetDiscountAmount(Index: Integer; const Astring: string);
begin
  FDiscountAmount := Astring;
  FDiscountAmount_Specified := True;
end;

function Level3_Type.DiscountAmount_Specified(Index: Integer): boolean;
begin
  Result := FDiscountAmount_Specified;
end;

procedure Level3_Type.SetShipFromZip(Index: Integer; const Astring: string);
begin
  FShipFromZip := Astring;
  FShipFromZip_Specified := True;
end;

function Level3_Type.ShipFromZip_Specified(Index: Integer): boolean;
begin
  Result := FShipFromZip_Specified;
end;

procedure PaypalTransactionDetails.SetPayerID(Index: Integer; const Astring: string);
begin
  FPayerID := Astring;
  FPayerID_Specified := True;
end;

function PaypalTransactionDetails.PayerID_Specified(Index: Integer): boolean;
begin
  Result := FPayerID_Specified;
end;

procedure PaypalTransactionDetails.SetGrossAmountCurrencyID(Index: Integer; const Astring: string);
begin
  FGrossAmountCurrencyID := Astring;
  FGrossAmountCurrencyID_Specified := True;
end;

function PaypalTransactionDetails.GrossAmountCurrencyID_Specified(Index: Integer): boolean;
begin
  Result := FGrossAmountCurrencyID_Specified;
end;

procedure PaypalTransactionDetails.SetAuthorization(Index: Integer; const Astring: string);
begin
  FAuthorization := Astring;
  FAuthorization_Specified := True;
end;

function PaypalTransactionDetails.Authorization_Specified(Index: Integer): boolean;
begin
  Result := FAuthorization_Specified;
end;

procedure PaypalTransactionDetails.SetMessage_(Index: Integer; const Astring: string);
begin
  FMessage_ := Astring;
  FMessage__Specified := True;
end;

function PaypalTransactionDetails.Message__Specified(Index: Integer): boolean;
begin
  Result := FMessage__Specified;
end;

procedure PaypalTransactionDetails.SetCorrelationID(Index: Integer; const Astring: string);
begin
  FCorrelationID := Astring;
  FCorrelationID_Specified := True;
end;

function PaypalTransactionDetails.CorrelationID_Specified(Index: Integer): boolean;
begin
  Result := FCorrelationID_Specified;
end;

procedure PaypalTransactionDetails.SetTimestamp(Index: Integer; const Astring: string);
begin
  FTimestamp := Astring;
  FTimestamp_Specified := True;
end;

function PaypalTransactionDetails.Timestamp_Specified(Index: Integer): boolean;
begin
  Result := FTimestamp_Specified;
end;

initialization
  { ServiceSoap }
  InvRegistry.RegisterInterface(TypeInfo(ServiceSoap), 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/Request', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ServiceSoap), 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Level3_LineItem_Type), 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'Array_Of_Level3_LineItem_Type');
  RemClassRegistry.RegisterXSClass(SoftDescriptor_Type, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'SoftDescriptor_Type');
  RemClassRegistry.RegisterXSClass(Level3_ShipToAddress_Type, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'Level3_ShipToAddress_Type');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Level3_ShipToAddress_Type), 'Name_', '[ExtName="Name"]');
  RemClassRegistry.RegisterXSClass(DynamicPricing, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'DynamicPricing');
  RemClassRegistry.RegisterXSClass(VisaCheckout, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'VisaCheckout');
  RemClassRegistry.RegisterXSClass(ForeignCurrencyDetails, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'ForeignCurrencyDetails');
  RemClassRegistry.RegisterXSClass(MasterPass, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'MasterPass');
  RemClassRegistry.RegisterXSClass(Level3_LineItem_Type, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'Level3_LineItem_Type');
  RemClassRegistry.RegisterXSClass(CheckTransaction, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'CheckTransaction');
  RemClassRegistry.RegisterXSClass(CheckTransactionResult, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'CheckTransactionResult');
  RemClassRegistry.RegisterXSClass(Transaction, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'Transaction');
  RemClassRegistry.RegisterXSClass(TransactionResult, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'TransactionResult');
  RemClassRegistry.RegisterXSClass(Address_Type, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'Address_Type');
  RemClassRegistry.RegisterXSClass(DynamicCurrency, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'DynamicCurrency');
  RemClassRegistry.RegisterXSClass(Level3_Type, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'Level3_Type');
  RemClassRegistry.RegisterXSClass(PaypalTransactionDetails, 'http://secure2.e-xact.com/vplug-in/transaction/rpc-enc/encodedTypes', 'PaypalTransactionDetails');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PaypalTransactionDetails), 'Message_', '[ExtName="Message"]');

end.