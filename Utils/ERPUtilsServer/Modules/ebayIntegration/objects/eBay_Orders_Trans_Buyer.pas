unit eBay_Orders_Trans_Buyer;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ,eBay_Orders_Trans_Buyer_Sellinfo;


type
  Tebay_orders_trans_buyer = class(TeBayObjBase)
  private
    fSellerInfo: Tebay_orders_trans_buyer_SellerInfo;
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetAboutMePage                                 : Boolean   ;
    function GetEIASToken                                   : string    ;
    function GetEmail                                       : string    ;
    function GetFeedbackScore                               : Integer   ;
    function GetUniqueNegativeFeedbackCount                 : Integer   ;
    function GetUniquePositiveFeedbackCount                 : Integer   ;
    function GetPositiveFeedbackPercent                     : Double    ;
    function GetFeedbackPrivate                             : Boolean   ;
    function GetFeedbackRatingStar                          : string    ;
    function GetIDVerified                                  : Boolean   ;
    function GeteBayGoodStanding                            : Boolean   ;
    function GetNewUser                                     : Boolean   ;
    function GetSite                                        : string    ;
    function GetStatus                                      : string    ;
    function GetUserID                                      : string    ;
    function GetUserIDChanged                               : Boolean   ;
    function GetVATStatus                                   : string    ;
    function GetBusinessRole                                : string    ;
    function GetPayPalAccountLevel                          : string    ;
    function GetPayPalAccountType                           : string    ;
    function GetPayPalAccountStatus                         : string    ;
    function GetSiteVerified                                : Boolean   ;
    function GeteBayWikiReadOnly                            : Boolean   ;
    function GetTUVLevel                                    : Integer   ;
    function GetVATID                                       : string    ;
    function GetMotorsDealer                                : Boolean   ;
    function GetSellerPaymentMethod                         : string    ;
    function GetUserAnonymized                              : Boolean   ;
    function GetUniqueNeutralFeedbackCount                  : Integer   ;
    function GetEnterpriseSeller                            : Boolean   ;
    function GetBillingEmail                                : string    ;
    function GetQualifiesForSelling                         : Boolean   ;
    function GetStaticAlias                                 : string    ;
    function GetRegistrationDate                            : TDatetime ;
    function GetUserIDLastChanged                           : TDatetime ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetAboutMePage                                 (const Value: Boolean   );
    procedure SetEIASToken                                   (const Value: string    );
    procedure SetEmail                                       (const Value: string    );
    procedure SetFeedbackScore                               (const Value: Integer   );
    procedure SetUniqueNegativeFeedbackCount                 (const Value: Integer   );
    procedure SetUniquePositiveFeedbackCount                 (const Value: Integer   );
    procedure SetPositiveFeedbackPercent                     (const Value: Double    );
    procedure SetFeedbackPrivate                             (const Value: Boolean   );
    procedure SetFeedbackRatingStar                          (const Value: string    );
    procedure SetIDVerified                                  (const Value: Boolean   );
    procedure SeteBayGoodStanding                            (const Value: Boolean   );
    procedure SetNewUser                                     (const Value: Boolean   );
    procedure SetSite                                        (const Value: string    );
    procedure SetStatus                                      (const Value: string    );
    procedure SetUserID                                      (const Value: string    );
    procedure SetUserIDChanged                               (const Value: Boolean   );
    procedure SetVATStatus                                   (const Value: string    );
    procedure SetBusinessRole                                (const Value: string    );
    procedure SetPayPalAccountLevel                          (const Value: string    );
    procedure SetPayPalAccountType                           (const Value: string    );
    procedure SetPayPalAccountStatus                         (const Value: string    );
    procedure SetSiteVerified                                (const Value: Boolean   );
    procedure SeteBayWikiReadOnly                            (const Value: Boolean   );
    procedure SetTUVLevel                                    (const Value: Integer   );
    procedure SetVATID                                       (const Value: string    );
    procedure SetMotorsDealer                                (const Value: Boolean   );
    procedure SetSellerPaymentMethod                         (const Value: string    );
    procedure SetUserAnonymized                              (const Value: Boolean   );
    procedure SetUniqueNeutralFeedbackCount                  (const Value: Integer   );
    procedure SetEnterpriseSeller                            (const Value: Boolean   );
    procedure SetBillingEmail                                (const Value: string    );
    procedure SetQualifiesForSelling                         (const Value: Boolean   );
    procedure SetStaticAlias                                 (const Value: string    );
    procedure SetRegistrationDate                            (const Value: TDateTime );
    procedure SetUserIDLastChanged                           (const Value: TDateTime );
    function GetRegistrationAddress_Name_:String;
    function GetRegistrationAddress_Street:String;
    function GetRegistrationAddress_Street1:String;
    function GetRegistrationAddress_Street2:String;
    function GetRegistrationAddress_CityName:String;
    function GetRegistrationAddress_County:String;
    function GetRegistrationAddress_StateOrProvince:String;
    function GetRegistrationAddress_Country:String;
    function GetRegistrationAddress_CountryName:String;
    function GetRegistrationAddress_Phone:String;
    function GetRegistrationAddress_PhoneCountryCode:String;
    function GetRegistrationAddress_PhoneCountryPrefix:String;
    function GetRegistrationAddress_PhoneAreaOrCityCode:String;
    function GetRegistrationAddress_PhoneLocalNumber:String;
    function GetRegistrationAddress_Phone2CountryCode:String;
    function GetRegistrationAddress_Phone2CountryPrefix:String;
    function GetRegistrationAddress_Phone2AreaOrCityCode:String;
    function GetRegistrationAddress_Phone2LocalNumber:String;
    function GetRegistrationAddress_PostalCode:String;
    function GetRegistrationAddress_AddressID:String;
    function GetRegistrationAddress_AddressOwner:String;
    function GetRegistrationAddress_AddressStatus:String;
    function GetRegistrationAddress_ExternalAddressID:String;
    function GetRegistrationAddress_InternationalName:String;
    function GetRegistrationAddress_InternationalStateAndCity:String;
    function GetRegistrationAddress_InternationalStreet:String;
    function GetRegistrationAddress_CompanyName:String;
    function GetRegistrationAddress_AddressRecordType:String;
    function GetRegistrationAddress_FirstName:String;
    function GetRegistrationAddress_LastName:String;
    function GetRegistrationAddress_Phone2:String;
    function GetRegistrationAddress_AddressUsage:String;
    function GetRegistrationAddress_ReferenceID:String;



    Procedure SetRegistrationAddress_Name_(const Value:String);
    Procedure SetRegistrationAddress_Street(const Value:String);
    Procedure SetRegistrationAddress_Street1(const Value:String);
    Procedure SetRegistrationAddress_Street2(const Value:String);
    Procedure SetRegistrationAddress_CityName(const Value:String);
    Procedure SetRegistrationAddress_County(const Value:String);
    Procedure SetRegistrationAddress_StateOrProvince(const Value:String);
    Procedure SetRegistrationAddress_Country(const Value:String);
    Procedure SetRegistrationAddress_CountryName(const Value:String);
    Procedure SetRegistrationAddress_Phone(const Value:String);
    Procedure SetRegistrationAddress_PhoneCountryCode(const Value:String);
    Procedure SetRegistrationAddress_PhoneCountryPrefix(const Value:String);
    Procedure SetRegistrationAddress_PhoneAreaOrCityCode(const Value:String);
    Procedure SetRegistrationAddress_PhoneLocalNumber(const Value:String);
    Procedure SetRegistrationAddress_Phone2CountryCode(const Value:String);
    Procedure SetRegistrationAddress_Phone2CountryPrefix(const Value:String);
    Procedure SetRegistrationAddress_Phone2AreaOrCityCode(const Value:String);
    Procedure SetRegistrationAddress_Phone2LocalNumber(const Value:String);
    Procedure SetRegistrationAddress_PostalCode(const Value:String);
    Procedure SetRegistrationAddress_AddressID(const Value:String);
    Procedure SetRegistrationAddress_AddressOwner(const Value:String);
    Procedure SetRegistrationAddress_AddressStatus(const Value:String);
    Procedure SetRegistrationAddress_ExternalAddressID(const Value:String);
    Procedure SetRegistrationAddress_InternationalName(const Value:String);
    Procedure SetRegistrationAddress_InternationalStateAndCity(const Value:String);
    Procedure SetRegistrationAddress_InternationalStreet(const Value:String);
    Procedure SetRegistrationAddress_CompanyName(const Value:String);
    Procedure SetRegistrationAddress_AddressRecordType(const Value:String);
    Procedure SetRegistrationAddress_FirstName(const Value:String);
    Procedure SetRegistrationAddress_LastName(const Value:String);
    Procedure SetRegistrationAddress_Phone2(const Value:String);
    Procedure SetRegistrationAddress_AddressUsage(const Value:String);
    Procedure SetRegistrationAddress_ReferenceID(const Value:String);
    function GetBuyer_ShippingAddres_Name_:String;
    function GetBuyer_ShippingAddres_Street:String;
    function GetBuyer_ShippingAddres_Street1:String;
    function GetBuyer_ShippingAddres_Street2:String;
    function GetBuyer_ShippingAddres_CityName:String;
    function GetBuyer_ShippingAddres_County:String;
    function GetBuyer_ShippingAddres_StateOrProvince:String;
    function GetBuyer_ShippingAddres_Country:String;
    function GetBuyer_ShippingAddres_CountryName:String;
    function GetBuyer_ShippingAddres_Phone:String;
    function GetBuyer_ShippingAddres_PhoneCountryCode:String;
    function GetBuyer_ShippingAddres_PhoneCountryPrefix:String;
    function GetBuyer_ShippingAddres_PhoneAreaOrCityCode:String;
    function GetBuyer_ShippingAddres_PhoneLocalNumber:String;
    function GetBuyer_ShippingAddres_Phone2CountryCode:String;
    function GetBuyer_ShippingAddres_Phone2CountryPrefix:String;
    function GetBuyer_ShippingAddres_Phone2AreaOrCityCode:String;
    function GetBuyer_ShippingAddres_Phone2LocalNumber:String;
    function GetBuyer_ShippingAddres_PostalCode:String;
    function GetBuyer_ShippingAddres_AddressID:String;
    function GetBuyer_ShippingAddres_AddressOwner:String;
    function GetBuyer_ShippingAddres_AddressStatus:String;
    function GetBuyer_ShippingAddres_ExternalAddressID:String;
    function GetBuyer_ShippingAddres_InternationalName:String;
    function GetBuyer_ShippingAddres_InternationalStateAndCity:String;
    function GetBuyer_ShippingAddres_InternationalStreet:String;
    function GetBuyer_ShippingAddres_CompanyName:String;
    function GetBuyer_ShippingAddres_AddressRecordType:String;
    function GetBuyer_ShippingAddres_FirstName:String;
    function GetBuyer_ShippingAddres_LastName:String;
    function GetBuyer_ShippingAddres_Phone2:String;
    function GetBuyer_ShippingAddres_AddressUsage:String;
    function GetBuyer_ShippingAddres_ReferenceID:String;



    Procedure SetBuyer_ShippingAddres_Name_(const Value:String);
    Procedure SetBuyer_ShippingAddres_Street(const Value:String);
    Procedure SetBuyer_ShippingAddres_Street1(const Value:String);
    Procedure SetBuyer_ShippingAddres_Street2(const Value:String);
    Procedure SetBuyer_ShippingAddres_CityName(const Value:String);
    Procedure SetBuyer_ShippingAddres_County(const Value:String);
    Procedure SetBuyer_ShippingAddres_StateOrProvince(const Value:String);
    Procedure SetBuyer_ShippingAddres_Country(const Value:String);
    Procedure SetBuyer_ShippingAddres_CountryName(const Value:String);
    Procedure SetBuyer_ShippingAddres_Phone(const Value:String);
    Procedure SetBuyer_ShippingAddres_PhoneCountryCode(const Value:String);
    Procedure SetBuyer_ShippingAddres_PhoneCountryPrefix(const Value:String);
    Procedure SetBuyer_ShippingAddres_PhoneAreaOrCityCode(const Value:String);
    Procedure SetBuyer_ShippingAddres_PhoneLocalNumber(const Value:String);
    Procedure SetBuyer_ShippingAddres_Phone2CountryCode(const Value:String);
    Procedure SetBuyer_ShippingAddres_Phone2CountryPrefix(const Value:String);
    Procedure SetBuyer_ShippingAddres_Phone2AreaOrCityCode(const Value:String);
    Procedure SetBuyer_ShippingAddres_Phone2LocalNumber(const Value:String);
    Procedure SetBuyer_ShippingAddres_PostalCode(const Value:String);
    Procedure SetBuyer_ShippingAddres_AddressID(const Value:String);
    Procedure SetBuyer_ShippingAddres_AddressOwner(const Value:String);
    Procedure SetBuyer_ShippingAddres_AddressStatus(const Value:String);
    Procedure SetBuyer_ShippingAddres_ExternalAddressID(const Value:String);
    Procedure SetBuyer_ShippingAddres_InternationalName(const Value:String);
    Procedure SetBuyer_ShippingAddres_InternationalStateAndCity(const Value:String);
    Procedure SetBuyer_ShippingAddres_InternationalStreet(const Value:String);
    Procedure SetBuyer_ShippingAddres_CompanyName(const Value:String);
    Procedure SetBuyer_ShippingAddres_AddressRecordType(const Value:String);
    Procedure SetBuyer_ShippingAddres_FirstName(const Value:String);
    Procedure SetBuyer_ShippingAddres_LastName(const Value:String);
    Procedure SetBuyer_ShippingAddres_Phone2(const Value:String);
    Procedure SetBuyer_ShippingAddres_AddressUsage(const Value:String);
    Procedure SetBuyer_ShippingAddres_ReferenceID(const Value:String);
    Function GetSellerInfo :Tebay_orders_trans_buyer_SellerInfo;

    (*function getOrders_Trans_Buyer_CharityAffiliations: TeBay_Orders_Trans_Buyer_CharityAffiliations;
    function getOrders_Trans_Buyer_SkypeID:TeBay_Orders_Trans_Buyer_SkypeID;
    function getOrders_Trans_Buyer_UserSub:TeBay_Orders_Trans_Buyer_UserSub;*)

  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
    Property SellerInfo : Tebay_orders_trans_buyer_SellerInfo read GetSellerInfo;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property AboutMePage                                  :Boolean     read GetAboutMePage                                write SetAboutMePage                             ;
    property EIASToken                                    :string      read GetEIASToken                                  write SetEIASToken                               ;
    property Email                                        :string      read GetEmail                                      write SetEmail                                   ;
    property FeedbackScore                                :Integer     read GetFeedbackScore                              write SetFeedbackScore                           ;
    property UniqueNegativeFeedbackCount                  :Integer     read GetUniqueNegativeFeedbackCount                write SetUniqueNegativeFeedbackCount             ;
    property UniquePositiveFeedbackCount                  :Integer     read GetUniquePositiveFeedbackCount                write SetUniquePositiveFeedbackCount             ;
    property PositiveFeedbackPercent                      :Double      read GetPositiveFeedbackPercent                    write SetPositiveFeedbackPercent                 ;
    property FeedbackPrivate                              :Boolean     read GetFeedbackPrivate                            write SetFeedbackPrivate                         ;
    property FeedbackRatingStar                           :string      read GetFeedbackRatingStar                         write SetFeedbackRatingStar                      ;
    property IDVerified                                   :Boolean     read GetIDVerified                                 write SetIDVerified                              ;
    property eBayGoodStanding                             :Boolean     read GeteBayGoodStanding                           write SeteBayGoodStanding                        ;
    property NewUser                                      :Boolean     read GetNewUser                                    write SetNewUser                                 ;
    property Site                                         :string      read GetSite                                       write SetSite                                    ;
    property Status                                       :string      read GetStatus                                     write SetStatus                                  ;
    property UserID                                       :string      read GetUserID                                     write SetUserID                                  ;
    property UserIDChanged                                :Boolean     read GetUserIDChanged                              write SetUserIDChanged                           ;
    property VATStatus                                    :string      read GetVATStatus                                  write SetVATStatus                               ;
    property BusinessRole                                 :string      read GetBusinessRole                               write SetBusinessRole                            ;
    property PayPalAccountLevel                           :string      read GetPayPalAccountLevel                         write SetPayPalAccountLevel                      ;
    property PayPalAccountType                            :string      read GetPayPalAccountType                          write SetPayPalAccountType                       ;
    property PayPalAccountStatus                          :string      read GetPayPalAccountStatus                        write SetPayPalAccountStatus                     ;
    property SiteVerified                                 :Boolean     read GetSiteVerified                               write SetSiteVerified                            ;
    property eBayWikiReadOnly                             :Boolean     read GeteBayWikiReadOnly                           write SeteBayWikiReadOnly                        ;
    property TUVLevel                                     :Integer     read GetTUVLevel                                   write SetTUVLevel                                ;
    property VATID                                        :string      read GetVATID                                      write SetVATID                                   ;
    property MotorsDealer                                 :Boolean     read GetMotorsDealer                               write SetMotorsDealer                            ;
    property SellerPaymentMethod                          :string      read GetSellerPaymentMethod                        write SetSellerPaymentMethod                     ;
    property UserAnonymized                               :Boolean     read GetUserAnonymized                             write SetUserAnonymized                          ;
    property UniqueNeutralFeedbackCount                   :Integer     read GetUniqueNeutralFeedbackCount                 write SetUniqueNeutralFeedbackCount              ;
    property EnterpriseSeller                             :Boolean     read GetEnterpriseSeller                           write SetEnterpriseSeller                        ;
    property BillingEmail                                 :string      read GetBillingEmail                               write SetBillingEmail                            ;
    property QualifiesForSelling                          :Boolean     read GetQualifiesForSelling                        write SetQualifiesForSelling                     ;
    property StaticAlias                                  :string      read GetStaticAlias                                write SetStaticAlias                             ;
    property RegistrationDate                             :TDatetime   read GetRegistrationDate                           write SetRegistrationDate                        ;
    property UserIDLastChanged                            :TDatetime   read GetUserIDLastChanged                          write SetUserIDLastChanged                        ;
    Property RegistrationAddress_Name_: String read getRegistrationAddress_Name_ Write SetRegistrationAddress_Name_;
    Property RegistrationAddress_Street: String read getRegistrationAddress_Street Write SetRegistrationAddress_Street;
    Property RegistrationAddress_Street1: String read getRegistrationAddress_Street1 Write SetRegistrationAddress_Street1;
    Property RegistrationAddress_Street2: String read getRegistrationAddress_Street2 Write SetRegistrationAddress_Street2;
    Property RegistrationAddress_CityName: String read getRegistrationAddress_CityName Write SetRegistrationAddress_CityName;
    Property RegistrationAddress_County: String read getRegistrationAddress_County Write SetRegistrationAddress_County;
    Property RegistrationAddress_StateOrProvince: String read getRegistrationAddress_StateOrProvince Write SetRegistrationAddress_StateOrProvince;
    Property RegistrationAddress_Country: String read getRegistrationAddress_Country Write SetRegistrationAddress_Country;
    Property RegistrationAddress_CountryName: String read getRegistrationAddress_CountryName Write SetRegistrationAddress_CountryName;
    Property RegistrationAddress_Phone: String read getRegistrationAddress_Phone Write SetRegistrationAddress_Phone;
    Property RegistrationAddress_PhoneCountryCode: String read getRegistrationAddress_PhoneCountryCode Write SetRegistrationAddress_PhoneCountryCode;
    Property RegistrationAddress_PhoneCountryPrefix: String read getRegistrationAddress_PhoneCountryPrefix Write SetRegistrationAddress_PhoneCountryPrefix;
    Property RegistrationAddress_PhoneAreaOrCityCode: String read getRegistrationAddress_PhoneAreaOrCityCode Write SetRegistrationAddress_PhoneAreaOrCityCode;
    Property RegistrationAddress_PhoneLocalNumber: String read getRegistrationAddress_PhoneLocalNumber Write SetRegistrationAddress_PhoneLocalNumber;
    Property RegistrationAddress_Phone2CountryCode: String read getRegistrationAddress_Phone2CountryCode Write SetRegistrationAddress_Phone2CountryCode;
    Property RegistrationAddress_Phone2CountryPrefix: String read getRegistrationAddress_Phone2CountryPrefix Write SetRegistrationAddress_Phone2CountryPrefix;
    Property RegistrationAddress_Phone2AreaOrCityCode: String read getRegistrationAddress_Phone2AreaOrCityCode Write SetRegistrationAddress_Phone2AreaOrCityCode;
    Property RegistrationAddress_Phone2LocalNumber: String read getRegistrationAddress_Phone2LocalNumber Write SetRegistrationAddress_Phone2LocalNumber;
    Property RegistrationAddress_PostalCode: String read getRegistrationAddress_PostalCode Write SetRegistrationAddress_PostalCode;
    Property RegistrationAddress_AddressID: String read getRegistrationAddress_AddressID Write SetRegistrationAddress_AddressID;
    Property RegistrationAddress_AddressOwner: String read getRegistrationAddress_AddressOwner Write SetRegistrationAddress_AddressOwner;
    Property RegistrationAddress_AddressStatus: String read getRegistrationAddress_AddressStatus Write SetRegistrationAddress_AddressStatus;
    Property RegistrationAddress_ExternalAddressID: String read getRegistrationAddress_ExternalAddressID Write SetRegistrationAddress_ExternalAddressID;
    Property RegistrationAddress_InternationalName: String read getRegistrationAddress_InternationalName Write SetRegistrationAddress_InternationalName;
    Property RegistrationAddress_InternationalStateAndCity: String read getRegistrationAddress_InternationalStateAndCity Write SetRegistrationAddress_InternationalStateAndCity;
    Property RegistrationAddress_InternationalStreet: String read getRegistrationAddress_InternationalStreet Write SetRegistrationAddress_InternationalStreet;
    Property RegistrationAddress_CompanyName: String read getRegistrationAddress_CompanyName Write SetRegistrationAddress_CompanyName;
    Property RegistrationAddress_AddressRecordType: String read getRegistrationAddress_AddressRecordType Write SetRegistrationAddress_AddressRecordType;
    Property RegistrationAddress_FirstName: String read getRegistrationAddress_FirstName Write SetRegistrationAddress_FirstName;
    Property RegistrationAddress_LastName: String read getRegistrationAddress_LastName Write SetRegistrationAddress_LastName;
    Property RegistrationAddress_Phone2: String read getRegistrationAddress_Phone2 Write SetRegistrationAddress_Phone2;
    Property RegistrationAddress_AddressUsage: String read getRegistrationAddress_AddressUsage Write SetRegistrationAddress_AddressUsage;
    Property RegistrationAddress_ReferenceID: String read getRegistrationAddress_ReferenceID Write SetRegistrationAddress_ReferenceID;
    Property Buyer_ShippingAddres_Name_: String read getBuyer_ShippingAddres_Name_ Write SetBuyer_ShippingAddres_Name_;
    Property Buyer_ShippingAddres_Street: String read getBuyer_ShippingAddres_Street Write SetBuyer_ShippingAddres_Street;
    Property Buyer_ShippingAddres_Street1: String read getBuyer_ShippingAddres_Street1 Write SetBuyer_ShippingAddres_Street1;
    Property Buyer_ShippingAddres_Street2: String read getBuyer_ShippingAddres_Street2 Write SetBuyer_ShippingAddres_Street2;
    Property Buyer_ShippingAddres_CityName: String read getBuyer_ShippingAddres_CityName Write SetBuyer_ShippingAddres_CityName;
    Property Buyer_ShippingAddres_County: String read getBuyer_ShippingAddres_County Write SetBuyer_ShippingAddres_County;
    Property Buyer_ShippingAddres_StateOrProvince: String read getBuyer_ShippingAddres_StateOrProvince Write SetBuyer_ShippingAddres_StateOrProvince;
    Property Buyer_ShippingAddres_Country: String read getBuyer_ShippingAddres_Country Write SetBuyer_ShippingAddres_Country;
    Property Buyer_ShippingAddres_CountryName: String read getBuyer_ShippingAddres_CountryName Write SetBuyer_ShippingAddres_CountryName;
    Property Buyer_ShippingAddres_Phone: String read getBuyer_ShippingAddres_Phone Write SetBuyer_ShippingAddres_Phone;
    Property Buyer_ShippingAddres_PhoneCountryCode: String read getBuyer_ShippingAddres_PhoneCountryCode Write SetBuyer_ShippingAddres_PhoneCountryCode;
    Property Buyer_ShippingAddres_PhoneCountryPrefix: String read getBuyer_ShippingAddres_PhoneCountryPrefix Write SetBuyer_ShippingAddres_PhoneCountryPrefix;
    Property Buyer_ShippingAddres_PhoneAreaOrCityCode: String read getBuyer_ShippingAddres_PhoneAreaOrCityCode Write SetBuyer_ShippingAddres_PhoneAreaOrCityCode;
    Property Buyer_ShippingAddres_PhoneLocalNumber: String read getBuyer_ShippingAddres_PhoneLocalNumber Write SetBuyer_ShippingAddres_PhoneLocalNumber;
    Property Buyer_ShippingAddres_Phone2CountryCode: String read getBuyer_ShippingAddres_Phone2CountryCode Write SetBuyer_ShippingAddres_Phone2CountryCode;
    Property Buyer_ShippingAddres_Phone2CountryPrefix: String read getBuyer_ShippingAddres_Phone2CountryPrefix Write SetBuyer_ShippingAddres_Phone2CountryPrefix;
    Property Buyer_ShippingAddres_Phone2AreaOrCityCode: String read getBuyer_ShippingAddres_Phone2AreaOrCityCode Write SetBuyer_ShippingAddres_Phone2AreaOrCityCode;
    Property Buyer_ShippingAddres_Phone2LocalNumber: String read getBuyer_ShippingAddres_Phone2LocalNumber Write SetBuyer_ShippingAddres_Phone2LocalNumber;
    Property Buyer_ShippingAddres_PostalCode: String read getBuyer_ShippingAddres_PostalCode Write SetBuyer_ShippingAddres_PostalCode;
    Property Buyer_ShippingAddres_AddressID: String read getBuyer_ShippingAddres_AddressID Write SetBuyer_ShippingAddres_AddressID;
    Property Buyer_ShippingAddres_AddressOwner: String read getBuyer_ShippingAddres_AddressOwner Write SetBuyer_ShippingAddres_AddressOwner;
    Property Buyer_ShippingAddres_AddressStatus: String read getBuyer_ShippingAddres_AddressStatus Write SetBuyer_ShippingAddres_AddressStatus;
    Property Buyer_ShippingAddres_ExternalAddressID: String read getBuyer_ShippingAddres_ExternalAddressID Write SetBuyer_ShippingAddres_ExternalAddressID;
    Property Buyer_ShippingAddres_InternationalName: String read getBuyer_ShippingAddres_InternationalName Write SetBuyer_ShippingAddres_InternationalName;
    Property Buyer_ShippingAddres_InternationalStateAndCity: String read getBuyer_ShippingAddres_InternationalStateAndCity Write SetBuyer_ShippingAddres_InternationalStateAndCity;
    Property Buyer_ShippingAddres_InternationalStreet: String read getBuyer_ShippingAddres_InternationalStreet Write SetBuyer_ShippingAddres_InternationalStreet;
    Property Buyer_ShippingAddres_CompanyName: String read getBuyer_ShippingAddres_CompanyName Write SetBuyer_ShippingAddres_CompanyName;
    Property Buyer_ShippingAddres_AddressRecordType: String read getBuyer_ShippingAddres_AddressRecordType Write SetBuyer_ShippingAddres_AddressRecordType;
    Property Buyer_ShippingAddres_FirstName: String read getBuyer_ShippingAddres_FirstName Write SetBuyer_ShippingAddres_FirstName;
    Property Buyer_ShippingAddres_LastName: String read getBuyer_ShippingAddres_LastName Write SetBuyer_ShippingAddres_LastName;
    Property Buyer_ShippingAddres_Phone2: String read getBuyer_ShippingAddres_Phone2 Write SetBuyer_ShippingAddres_Phone2;
    Property Buyer_ShippingAddres_AddressUsage: String read getBuyer_ShippingAddres_AddressUsage Write SetBuyer_ShippingAddres_AddressUsage;
    Property Buyer_ShippingAddres_ReferenceID: String read getBuyer_ShippingAddres_ReferenceID Write SetBuyer_ShippingAddres_ReferenceID;
(*
    property CharityAffiliations:         CharityAffiliationsType                     Index (IS_OPTN) read GetCharityAffiliations write SetCharityAffiliations stored CharityAffiliations_Specified;
    property UserSubscription:            Array_Of_EBaySubscriptionTypeCodeType       Index (IS_OPTN or IS_UNBD) read GetUserSubscription write SetUserSubscription stored UserSubscription_Specified;
    property SkypeID:                     SellerExcludeShipToLocationPreferencesType  Index (IS_OPTN or IS_UNBD) read GetSkypeID write SetSkypeID stored SkypeID_Specified;
    property BiddingSummary:              BiddingSummaryType                          Index (IS_OPTN) read GetBiddingSummary write SetBiddingSummary stored BiddingSummary_Specified;
*)
  end;


implementation


uses sysutils;



  {Tebay_orders_trans_buyer}

constructor Tebay_orders_trans_buyer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_buyer';
end;

{Property Functions}
function  Tebay_orders_trans_buyer.GetOrderID                                 : Integer   ; begin Result := GEtfieldValue('OrderID');end;
function  Tebay_orders_trans_buyer.GetOrders_Trans_Id                         : Integer   ; begin Result := GEtfieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_buyer.GetAboutMePage                             : Boolean   ; begin Result := GEtfieldValue('AboutMePage');end;
function  Tebay_orders_trans_buyer.GetEIASToken                               : string    ; begin Result := GEtfieldValue('EIASToken');end;
function  Tebay_orders_trans_buyer.GetEmail                                   : string    ; begin Result := GEtfieldValue('Email');end;
function  Tebay_orders_trans_buyer.GetFeedbackScore                           : Integer   ; begin Result := GEtfieldValue('FeedbackScore');end;
function  Tebay_orders_trans_buyer.GetUniqueNegativeFeedbackCount             : Integer   ; begin Result := GEtfieldValue('UniqueNegativeFeedbackCount');end;
function  Tebay_orders_trans_buyer.GetUniquePositiveFeedbackCount             : Integer   ; begin Result := GEtfieldValue('UniquePositiveFeedbackCount');end;
function  Tebay_orders_trans_buyer.GetPositiveFeedbackPercent                 : Double    ; begin Result := GEtfieldValue('PositiveFeedbackPercent');end;
function  Tebay_orders_trans_buyer.GetFeedbackPrivate                         : Boolean   ; begin Result := GEtfieldValue('FeedbackPrivate');end;
function  Tebay_orders_trans_buyer.GetFeedbackRatingStar                      : string    ; begin Result := GEtfieldValue('FeedbackRatingStar');end;
function  Tebay_orders_trans_buyer.GetIDVerified                              : Boolean   ; begin Result := GEtfieldValue('IDVerified');end;
function  Tebay_orders_trans_buyer.GeteBayGoodStanding                        : Boolean   ; begin Result := GEtfieldValue('eBayGoodStanding');end;
function  Tebay_orders_trans_buyer.GetNewUser                                 : Boolean   ; begin Result := GEtfieldValue('NewUser');end;
function  Tebay_orders_trans_buyer.GetSite                                    : string    ; begin Result := GEtfieldValue('Site');end;
function  Tebay_orders_trans_buyer.GetStatus                                  : string    ; begin Result := GEtfieldValue('Status');end;
function  Tebay_orders_trans_buyer.GetUserID                                  : string    ; begin Result := GEtfieldValue('UserID');end;
function  Tebay_orders_trans_buyer.GetUserIDChanged                           : Boolean   ; begin Result := GEtfieldValue('UserIDChanged');end;
function  Tebay_orders_trans_buyer.GetVATStatus                               : string    ; begin Result := GEtfieldValue('VATStatus');end;
function  Tebay_orders_trans_buyer.GetBusinessRole                            : string    ; begin Result := GEtfieldValue('BusinessRole');end;
function  Tebay_orders_trans_buyer.GetPayPalAccountLevel                      : string    ; begin Result := GEtfieldValue('PayPalAccountLevel');end;
function  Tebay_orders_trans_buyer.GetPayPalAccountType                       : string    ; begin Result := GEtfieldValue('PayPalAccountType');end;
function  Tebay_orders_trans_buyer.GetPayPalAccountStatus                     : string    ; begin Result := GEtfieldValue('PayPalAccountStatus');end;
function  Tebay_orders_trans_buyer.GetSiteVerified                            : Boolean   ; begin Result := GEtfieldValue('SiteVerified');end;
function  Tebay_orders_trans_buyer.GeteBayWikiReadOnly                        : Boolean   ; begin Result := GEtfieldValue('eBayWikiReadOnly');end;
function  Tebay_orders_trans_buyer.GetTUVLevel                                : Integer   ; begin Result := GEtfieldValue('TUVLevel');end;
function  Tebay_orders_trans_buyer.GetVATID                                   : string    ; begin Result := GEtfieldValue('VATID');end;
function  Tebay_orders_trans_buyer.GetMotorsDealer                            : Boolean   ; begin Result := GEtfieldValue('MotorsDealer');end;
function Tebay_orders_trans_buyer.GetSellerInfo: Tebay_orders_trans_buyer_SellerInfo;
begin
  if (fSellerInfo = nil) then begin
    fSellerInfo:= Tebay_orders_trans_buyer_SellerInfo.Create(self, 'tblebay_orders_trans_buyer_sellerinfo', 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(ID));
  end;
  fSellerInfo.SQLWhere := 'OrderId  =' + inttostr(orderID)+ ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+' and Orders_Trans_buyer_Id = ' + inttostr(ID);
  fSellerInfo.Dataset;
  result:= fSellerInfo;
end;

function  Tebay_orders_trans_buyer.GetSellerPaymentMethod                     : string    ; begin Result := GEtfieldValue('SellerPaymentMethod');end;
function  Tebay_orders_trans_buyer.GetUserAnonymized                          : Boolean   ; begin Result := GEtfieldValue('UserAnonymized');end;
function  Tebay_orders_trans_buyer.GetUniqueNeutralFeedbackCount              : Integer   ; begin Result := GEtfieldValue('UniqueNeutralFeedbackCount');end;
function  Tebay_orders_trans_buyer.GetEnterpriseSeller                        : Boolean   ; begin Result := GEtfieldValue('EnterpriseSeller');end;
function  Tebay_orders_trans_buyer.GetBillingEmail                            : string    ; begin Result := GEtfieldValue('BillingEmail');end;
function  Tebay_orders_trans_buyer.GetQualifiesForSelling                     : Boolean   ; begin Result := GEtfieldValue('QualifiesForSelling');end;
function  Tebay_orders_trans_buyer.GetStaticAlias                             : string    ; begin Result := GEtfieldValue('StaticAlias');end;
function  Tebay_orders_trans_buyer.GetRegistrationDate                        : TDatetime ; begin Result := GEtfieldValue('RegistrationDate');end;
function  Tebay_orders_trans_buyer.GetUserIDLastChanged                       : TDatetime ; begin Result := GEtfieldValue('UserIDLastChanged');end;
procedure Tebay_orders_trans_buyer.SetOrderID                                 (const Value: Integer    ); begin SEtfieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_buyer.SetOrders_Trans_Id                         (const Value: Integer   ); begin SEtfieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_buyer.SetAboutMePage                             (const Value: Boolean   ); begin SEtfieldValue('AboutMePage'                              , Value);end;
procedure Tebay_orders_trans_buyer.SetEIASToken                               (const Value: string    ); begin SEtfieldValue('EIASToken'                                , Value);end;
procedure Tebay_orders_trans_buyer.SetEmail                                   (const Value: string    ); begin SEtfieldValue('Email'                                    , Value);end;
procedure Tebay_orders_trans_buyer.SetFeedbackScore                           (const Value: Integer   ); begin SEtfieldValue('FeedbackScore'                            , Value);end;
procedure Tebay_orders_trans_buyer.SetUniqueNegativeFeedbackCount             (const Value: Integer   ); begin SEtfieldValue('UniqueNegativeFeedbackCount'              , Value);end;
procedure Tebay_orders_trans_buyer.SetUniquePositiveFeedbackCount             (const Value: Integer   ); begin SEtfieldValue('UniquePositiveFeedbackCount'              , Value);end;
procedure Tebay_orders_trans_buyer.SetPositiveFeedbackPercent                 (const Value: Double    ); begin SEtfieldValue('PositiveFeedbackPercent'                  , Value);end;
procedure Tebay_orders_trans_buyer.SetFeedbackPrivate                         (const Value: Boolean   ); begin SEtfieldValue('FeedbackPrivate'                          , Value);end;
procedure Tebay_orders_trans_buyer.SetFeedbackRatingStar                      (const Value: string    ); begin SEtfieldValue('FeedbackRatingStar'                       , Value);end;
procedure Tebay_orders_trans_buyer.SetIDVerified                              (const Value: Boolean   ); begin SEtfieldValue('IDVerified'                               , Value);end;
procedure Tebay_orders_trans_buyer.SeteBayGoodStanding                        (const Value: Boolean   ); begin SEtfieldValue('eBayGoodStanding'                         , Value);end;
procedure Tebay_orders_trans_buyer.SetNewUser                                 (const Value: Boolean   ); begin SEtfieldValue('NewUser'                                  , Value);end;
procedure Tebay_orders_trans_buyer.SetSite                                    (const Value: string    ); begin SEtfieldValue('Site'                                     , Value);end;
procedure Tebay_orders_trans_buyer.SetStatus                                  (const Value: string    ); begin SEtfieldValue('Status'                                   , Value);end;
procedure Tebay_orders_trans_buyer.SetUserID                                  (const Value: string    ); begin SEtfieldValue('UserID'                                   , Value);end;
procedure Tebay_orders_trans_buyer.SetUserIDChanged                           (const Value: Boolean   ); begin SEtfieldValue('UserIDChanged'                            , Value);end;
procedure Tebay_orders_trans_buyer.SetVATStatus                               (const Value: string    ); begin SEtfieldValue('VATStatus'                                , Value);end;
procedure Tebay_orders_trans_buyer.SetBusinessRole                            (const Value: string    ); begin SEtfieldValue('BusinessRole'                             , Value);end;
procedure Tebay_orders_trans_buyer.SetPayPalAccountLevel                      (const Value: string    ); begin SEtfieldValue('PayPalAccountLevel'                       , Value);end;
procedure Tebay_orders_trans_buyer.SetPayPalAccountType                       (const Value: string    ); begin SEtfieldValue('PayPalAccountType'                        , Value);end;
procedure Tebay_orders_trans_buyer.SetPayPalAccountStatus                     (const Value: string    ); begin SEtfieldValue('PayPalAccountStatus'                      , Value);end;
procedure Tebay_orders_trans_buyer.SetSiteVerified                            (const Value: Boolean   ); begin SEtfieldValue('SiteVerified'                             , Value);end;
procedure Tebay_orders_trans_buyer.SeteBayWikiReadOnly                        (const Value: Boolean   ); begin SEtfieldValue('eBayWikiReadOnly'                         , Value);end;
procedure Tebay_orders_trans_buyer.SetTUVLevel                                (const Value: Integer   ); begin SEtfieldValue('TUVLevel'                                 , Value);end;
procedure Tebay_orders_trans_buyer.SetVATID                                   (const Value: string    ); begin SEtfieldValue('VATID'                                    , Value);end;
procedure Tebay_orders_trans_buyer.SetMotorsDealer                            (const Value: Boolean   ); begin SEtfieldValue('MotorsDealer'                             , Value);end;
procedure Tebay_orders_trans_buyer.SetSellerPaymentMethod                     (const Value: string    ); begin SEtfieldValue('SellerPaymentMethod'                      , Value);end;
procedure Tebay_orders_trans_buyer.SetUserAnonymized                          (const Value: Boolean   ); begin SEtfieldValue('UserAnonymized'                           , Value);end;
procedure Tebay_orders_trans_buyer.SetUniqueNeutralFeedbackCount              (const Value: Integer   ); begin SEtfieldValue('UniqueNeutralFeedbackCount'               , Value);end;
procedure Tebay_orders_trans_buyer.SetEnterpriseSeller                        (const Value: Boolean   ); begin SEtfieldValue('EnterpriseSeller'                         , Value);end;
procedure Tebay_orders_trans_buyer.SetBillingEmail                            (const Value: string    ); begin SEtfieldValue('BillingEmail'                             , Value);end;
procedure Tebay_orders_trans_buyer.SetQualifiesForSelling                     (const Value: Boolean   ); begin SEtfieldValue('QualifiesForSelling'                      , Value);end;
procedure Tebay_orders_trans_buyer.SetStaticAlias                             (const Value: string    ); begin SEtfieldValue('StaticAlias'                              , Value);end;
procedure Tebay_orders_trans_buyer.SetRegistrationDate                        (const Value: TDateTime ); begin SEtfieldValue('RegistrationDate'                         , Value);end;
procedure Tebay_orders_trans_buyer.SetUserIDLastChanged                       (const Value: TDateTime ); begin SEtfieldValue('UserIDLastChanged'                        , Value);end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Name_:String ; begin result := GetFieldValue('RegistrationAddress_Name_'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Street:String ; begin result := GetFieldValue('RegistrationAddress_Street'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Street1:String ; begin result := GetFieldValue('RegistrationAddress_Street1'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Street2:String ; begin result := GetFieldValue('RegistrationAddress_Street2'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_CityName:String ; begin result := GetFieldValue('RegistrationAddress_CityName'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_County:String ; begin result := GetFieldValue('RegistrationAddress_County'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_StateOrProvince:String ; begin result := GetFieldValue('RegistrationAddress_StateOrProvince'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Country:String ; begin result := GetFieldValue('RegistrationAddress_Country'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_CountryName:String ; begin result := GetFieldValue('RegistrationAddress_CountryName'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Phone:String ; begin result := GetFieldValue('RegistrationAddress_Phone'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_PhoneCountryCode:String ; begin result := GetFieldValue('RegistrationAddress_PhoneCountryCode'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_PhoneCountryPrefix:String ; begin result := GetFieldValue('RegistrationAddress_PhoneCountryPrefix'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_PhoneAreaOrCityCode:String ; begin result := GetFieldValue('RegistrationAddress_PhoneAreaOrCityCode'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_PhoneLocalNumber:String ; begin result := GetFieldValue('RegistrationAddress_PhoneLocalNumber'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Phone2CountryCode:String ; begin result := GetFieldValue('RegistrationAddress_Phone2CountryCode'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Phone2CountryPrefix:String ; begin result := GetFieldValue('RegistrationAddress_Phone2CountryPrefix'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Phone2AreaOrCityCode:String ; begin result := GetFieldValue('RegistrationAddress_Phone2AreaOrCityCode'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Phone2LocalNumber:String ; begin result := GetFieldValue('RegistrationAddress_Phone2LocalNumber'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_PostalCode:String ; begin result := GetFieldValue('RegistrationAddress_PostalCode'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_AddressID:String ; begin result := GetFieldValue('RegistrationAddress_AddressID'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_AddressOwner:String ; begin result := GetFieldValue('RegistrationAddress_AddressOwner'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_AddressStatus:String ; begin result := GetFieldValue('RegistrationAddress_AddressStatus'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_ExternalAddressID:String ; begin result := GetFieldValue('RegistrationAddress_ExternalAddressID'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_InternationalName:String ; begin result := GetFieldValue('RegistrationAddress_InternationalName'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_InternationalStateAndCity:String ; begin result := GetFieldValue('RegistrationAddress_InternationalStateAndCity'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_InternationalStreet:String ; begin result := GetFieldValue('RegistrationAddress_InternationalStreet'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_CompanyName:String ; begin result := GetFieldValue('RegistrationAddress_CompanyName'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_AddressRecordType:String ; begin result := GetFieldValue('RegistrationAddress_AddressRecordType'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_FirstName:String ; begin result := GetFieldValue('RegistrationAddress_FirstName'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_LastName:String ; begin result := GetFieldValue('RegistrationAddress_LastName'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_Phone2:String ; begin result := GetFieldValue('RegistrationAddress_Phone2'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_AddressUsage:String ; begin result := GetFieldValue('RegistrationAddress_AddressUsage'); end;
Function Tebay_orders_trans_buyer.GEtRegistrationAddress_ReferenceID:String ; begin result := GetFieldValue('RegistrationAddress_ReferenceID'); end;



Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Name_(Const Value:String); begin SetFieldValue('RegistrationAddress_Name_', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Street(Const Value:String); begin SetFieldValue('RegistrationAddress_Street', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Street1(Const Value:String); begin SetFieldValue('RegistrationAddress_Street1', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Street2(Const Value:String); begin SetFieldValue('RegistrationAddress_Street2', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_CityName(Const Value:String); begin SetFieldValue('RegistrationAddress_CityName', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_County(Const Value:String); begin SetFieldValue('RegistrationAddress_County', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_StateOrProvince(Const Value:String); begin SetFieldValue('RegistrationAddress_StateOrProvince', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Country(Const Value:String); begin SetFieldValue('RegistrationAddress_Country', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_CountryName(Const Value:String); begin SetFieldValue('RegistrationAddress_CountryName', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Phone(Const Value:String); begin SetFieldValue('RegistrationAddress_Phone', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_PhoneCountryCode(Const Value:String); begin SetFieldValue('RegistrationAddress_PhoneCountryCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_PhoneCountryPrefix(Const Value:String); begin SetFieldValue('RegistrationAddress_PhoneCountryPrefix', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_PhoneAreaOrCityCode(Const Value:String); begin SetFieldValue('RegistrationAddress_PhoneAreaOrCityCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_PhoneLocalNumber(Const Value:String); begin SetFieldValue('RegistrationAddress_PhoneLocalNumber', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Phone2CountryCode(Const Value:String); begin SetFieldValue('RegistrationAddress_Phone2CountryCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Phone2CountryPrefix(Const Value:String); begin SetFieldValue('RegistrationAddress_Phone2CountryPrefix', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Phone2AreaOrCityCode(Const Value:String); begin SetFieldValue('RegistrationAddress_Phone2AreaOrCityCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Phone2LocalNumber(Const Value:String); begin SetFieldValue('RegistrationAddress_Phone2LocalNumber', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_PostalCode(Const Value:String); begin SetFieldValue('RegistrationAddress_PostalCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_AddressID(Const Value:String); begin SetFieldValue('RegistrationAddress_AddressID', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_AddressOwner(Const Value:String); begin SetFieldValue('RegistrationAddress_AddressOwner', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_AddressStatus(Const Value:String); begin SetFieldValue('RegistrationAddress_AddressStatus', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_ExternalAddressID(Const Value:String); begin SetFieldValue('RegistrationAddress_ExternalAddressID', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_InternationalName(Const Value:String); begin SetFieldValue('RegistrationAddress_InternationalName', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_InternationalStateAndCity(Const Value:String); begin SetFieldValue('RegistrationAddress_InternationalStateAndCity', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_InternationalStreet(Const Value:String); begin SetFieldValue('RegistrationAddress_InternationalStreet', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_CompanyName(Const Value:String); begin SetFieldValue('RegistrationAddress_CompanyName', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_AddressRecordType(Const Value:String); begin SetFieldValue('RegistrationAddress_AddressRecordType', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_FirstName(Const Value:String); begin SetFieldValue('RegistrationAddress_FirstName', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_LastName(Const Value:String); begin SetFieldValue('RegistrationAddress_LastName', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_Phone2(Const Value:String); begin SetFieldValue('RegistrationAddress_Phone2', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_AddressUsage(Const Value:String); begin SetFieldValue('RegistrationAddress_AddressUsage', Value); end;
Procedure Tebay_orders_trans_buyer.SetRegistrationAddress_ReferenceID(Const Value:String); begin SetFieldValue('RegistrationAddress_ReferenceID', Value); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Name_:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Name_'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Street:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Street'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Street1:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Street1'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Street2:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Street2'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_CityName:String ; begin result := GetFieldValue('Buyer_ShippingAddres_CityName'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_County:String ; begin result := GetFieldValue('Buyer_ShippingAddres_County'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_StateOrProvince:String ; begin result := GetFieldValue('Buyer_ShippingAddres_StateOrProvince'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Country:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Country'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_CountryName:String ; begin result := GetFieldValue('Buyer_ShippingAddres_CountryName'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Phone:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Phone'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_PhoneCountryCode:String ; begin result := GetFieldValue('Buyer_ShippingAddres_PhoneCountryCode'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_PhoneCountryPrefix:String ; begin result := GetFieldValue('Buyer_ShippingAddres_PhoneCountryPrefix'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_PhoneAreaOrCityCode:String ; begin result := GetFieldValue('Buyer_ShippingAddres_PhoneAreaOrCityCode'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_PhoneLocalNumber:String ; begin result := GetFieldValue('Buyer_ShippingAddres_PhoneLocalNumber'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Phone2CountryCode:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Phone2CountryCode'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Phone2CountryPrefix:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Phone2CountryPrefix'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Phone2AreaOrCityCode:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Phone2AreaOrCityCode'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Phone2LocalNumber:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Phone2LocalNumber'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_PostalCode:String ; begin result := GetFieldValue('Buyer_ShippingAddres_PostalCode'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_AddressID:String ; begin result := GetFieldValue('Buyer_ShippingAddres_AddressID'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_AddressOwner:String ; begin result := GetFieldValue('Buyer_ShippingAddres_AddressOwner'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_AddressStatus:String ; begin result := GetFieldValue('Buyer_ShippingAddres_AddressStatus'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_ExternalAddressID:String ; begin result := GetFieldValue('Buyer_ShippingAddres_ExternalAddressID'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_InternationalName:String ; begin result := GetFieldValue('Buyer_ShippingAddres_InternationalName'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_InternationalStateAndCity:String ; begin result := GetFieldValue('Buyer_ShippingAddres_InternationalStateAndCity'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_InternationalStreet:String ; begin result := GetFieldValue('Buyer_ShippingAddres_InternationalStreet'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_CompanyName:String ; begin result := GetFieldValue('Buyer_ShippingAddres_CompanyName'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_AddressRecordType:String ; begin result := GetFieldValue('Buyer_ShippingAddres_AddressRecordType'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_FirstName:String ; begin result := GetFieldValue('Buyer_ShippingAddres_FirstName'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_LastName:String ; begin result := GetFieldValue('Buyer_ShippingAddres_LastName'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_Phone2:String ; begin result := GetFieldValue('Buyer_ShippingAddres_Phone2'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_AddressUsage:String ; begin result := GetFieldValue('Buyer_ShippingAddres_AddressUsage'); end;
Function Tebay_orders_trans_buyer.GEtBuyer_ShippingAddres_ReferenceID:String ; begin result := GetFieldValue('Buyer_ShippingAddres_ReferenceID'); end;



Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Name_(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Name_', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Street(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Street', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Street1(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Street1', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Street2(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Street2', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_CityName(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_CityName', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_County(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_County', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_StateOrProvince(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_StateOrProvince', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Country(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Country', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_CountryName(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_CountryName', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Phone(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Phone', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_PhoneCountryCode(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_PhoneCountryCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_PhoneCountryPrefix(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_PhoneCountryPrefix', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_PhoneAreaOrCityCode(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_PhoneAreaOrCityCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_PhoneLocalNumber(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_PhoneLocalNumber', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Phone2CountryCode(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Phone2CountryCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Phone2CountryPrefix(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Phone2CountryPrefix', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Phone2AreaOrCityCode(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Phone2AreaOrCityCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Phone2LocalNumber(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Phone2LocalNumber', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_PostalCode(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_PostalCode', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_AddressID(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_AddressID', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_AddressOwner(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_AddressOwner', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_AddressStatus(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_AddressStatus', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_ExternalAddressID(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_ExternalAddressID', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_InternationalName(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_InternationalName', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_InternationalStateAndCity(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_InternationalStateAndCity', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_InternationalStreet(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_InternationalStreet', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_CompanyName(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_CompanyName', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_AddressRecordType(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_AddressRecordType', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_FirstName(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_FirstName', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_LastName(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_LastName', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_Phone2(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_Phone2', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_AddressUsage(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_AddressUsage', Value); end;
Procedure Tebay_orders_trans_buyer.SetBuyer_ShippingAddres_ReferenceID(Const Value:String); begin SetFieldValue('Buyer_ShippingAddres_ReferenceID', Value); end;


(*function TeBay_Orders_Trans_Buyer.getOrders_Trans_Buyer_CharityAffiliations: TeBay_Orders_Trans_Buyer_CharityAffiliations;begin       Result := TeBay_Orders_Trans_Buyer_CharityAffiliations(getcontainercomponent(TeBay_Orders_Trans_Buyer_CharityAffiliations , 'Orders_Trans_Buyer_ID =  '+ IntToStr(ID) , true , true));end;
function TeBay_Orders_Trans_Buyer.getOrders_Trans_Buyer_SkypeID:TeBay_Orders_Trans_Buyer_SkypeID;begin       Result := TeBay_Orders_Trans_Buyer_SkypeID(getcontainercomponent(TeBay_Orders_Trans_Buyer_SkypeID , 'Orders_Trans_Buyer_ID =  '+ IntToStr(ID) , true , true));end;
function TeBay_Orders_Trans_Buyer.getOrders_Trans_Buyer_UserSub:TeBay_Orders_Trans_Buyer_UserSub;begin       Result := TeBay_Orders_Trans_Buyer_UserSub(getcontainercomponent(TeBay_Orders_Trans_Buyer_UserSub , 'Orders_Trans_Buyer_ID =  '+ IntToStr(ID) , true , true));end;*)


initialization
  RegisterClass(Tebay_orders_trans_buyer);


end.
