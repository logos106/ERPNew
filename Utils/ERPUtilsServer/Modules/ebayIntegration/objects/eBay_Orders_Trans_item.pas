unit eBay_Orders_Trans_item;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj  , eBay_Orders_Trans_item_Skypecontact ,eBay_Orders_Trans_item_AttribSet ,
      eBay_Orders_Trans_item_GiftService, eBay_Orders_Trans_item_listingEnhanceMent , eBay_Orders_Trans_item_PaymentallowdSite,
      eBay_Orders_Trans_item_ShipToLocations, eBay_Orders_Trans_item_ItemSpecifics,eBay_Orders_Trans_item_CrossBt,
      eBay_Orders_Trans_item_AttribArr;


type
  Tebay_orders_trans_item = class(TeBayObjBase)
  private
    fSkypeContact :Tebay_orders_trans_item_skypecontactoption;
    fAttribSet :Tebay_orders_trans_item_attribsetarr;
    fGiftService :Tebay_orders_trans_item_giftservices;
    fListingEnhancement :Tebay_orders_trans_item_ListingEnhancement;
    fPaymentAllodSite :Tebay_orders_trans_item_paymentallowedsite;
    fShiptoLocations :Tebay_orders_trans_item_shiptolocations;
    fItemSpecifics :Tebay_orders_trans_item_itemspecifics;
    fCrossBT :Tebay_orders_trans_item_crossbt;
    fAttribArr :Tebay_orders_trans_item_attribarr;
    //fLookupAttribArr :Tebay_orders_trans_item_LookupAttribArr;
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetApplicationData                             : string    ;
    function GetAutoPay                                     : Boolean   ;
    function GetMotorsGermanySearchable                     : Boolean   ;
    function GetBuyerProtection                             : string    ;
    function GetCategoryMappingAllowed                      : Boolean   ;
    function GetCountry                                     : string    ;
    function GetCurrency                                    : string    ;
    function GetDescription                                 : string    ;
    function GetDescriptionReviseMode                       : string    ;
    function GetGiftIcon                                    : Integer   ;
    function GetHitCounter                                  : string    ;
    function GetItemID                                      : string    ;
    function GetListingDuration                             : string    ;
    function GetListingType                                 : string    ;
    function GetLocation                                    : string    ;
    function GetLotSize                                     : Integer   ;
    function GetPartnerCode                                 : string    ;
    function GetPartnerName                                 : string    ;
    function GetPayPalEmailAddress                          : string    ;
    function GetPrivateListing                              : Boolean   ;
    function GetQuantity                                    : Integer   ;
    function GetPrivateNotes                                : string    ;
    function GetRegionID                                    : string    ;
    function GetRelistLink                                  : Boolean   ;
    function GetSite                                        : string    ;
    function GetSubTitle                                    : string    ;
    function GetTitle                                       : string    ;
    function GetUUID                                        : string    ;
    function GetSellerVacationNote                          : string    ;
    function GetWatchCount                                  : Integer   ;
    function GetHitCount                                    : Integer   ;
    function GetDisableBuyerRequirements                    : Boolean   ;
    function GetLocationDefaulted                           : Boolean   ;
    function GetThirdPartyCheckout                          : Boolean   ;
    function GetUseTaxTable                                 : Boolean   ;
    function GetGetItFast                                   : Boolean   ;
    function GetBuyerResponsibleForShipping                 : Boolean   ;
    function GetLimitedWarrantyEligible                     : Boolean   ;
    function GeteBayNotes                                   : string    ;
    function GetQuestionCount                               : Integer   ;
    function GetRelisted                                    : Boolean   ;
    function GetQuantityAvailable                           : Integer   ;
    function GetSKU                                         : string    ;
    function GetCategoryBasedAttributesPrefill              : Boolean   ;
    function GetPostalCode                                  : string    ;
    function GetShippingTermsInDescription                  : Boolean   ;
    function GetSellerInventoryID                           : string    ;
    function GetDispatchTimeMax                             : Integer   ;
    function GetSkypeEnabled                                : Boolean   ;
    function GetSkypeID                                     : string    ;
    function GetBestOfferEnabled                            : Boolean   ;
    function GetLocalListing                                : Boolean   ;
    function GetThirdPartyCheckoutIntegration               : Boolean   ;
    function GetTotalQuestionCount                          : Integer   ;
    function GetProxyItem                                   : Boolean   ;
    function GetLeadCount                                   : Integer   ;
    function GetNewLeadCount                                : Integer   ;
    function GetGroupCategoryID                             : string    ;
    function GetBidGroupItem                                : Boolean   ;
    function GetListingSubtype2                             : string    ;
    function GetMechanicalCheckAccepted                     : Boolean   ;
    function GetUpdateSellerInfo                            : Boolean   ;
    function GetUpdateReturnPolicy                          : Boolean   ;
    function GetInventoryTrackingMethod                     : string    ;
    function GetIntegratedMerchantCreditCardEnabled         : Boolean   ;
    function GetItemCompatibilityCount                      : Integer   ;
    function GetConditionID                                 : Integer   ;
    function GetConditionDescription                        : string    ;
    function GetConditionDisplayName                        : string    ;
    function GetTaxCategory                                 : string    ;
    function GetQuantityAvailableHint                       : string    ;
    function GetQuantityThreshold                           : Integer   ;
    function GetPostCheckoutExperienceEnabled               : Boolean   ;
    function GetUseRecommendedProduct                       : Boolean   ;
    function GetSellerProvidedTitle                         : string    ;
    function GetVIN                                         : string    ;
    function GetVINLink                                     : string    ;
    function GetVRM                                         : string    ;
    function GetVRMLink                                     : string    ;
    function GetTopRatedListing                             : Boolean   ;
    function GetIsIntermediatedShippingEligible             : Boolean   ;
    function GetRelistParentID                              : Integer   ;
    function GetConditionDefinition                         : string    ;
    function GetHideFromSearch                              : Boolean   ;
    function GetReasonHideFromSearch                        : string    ;
    function GetIncludeRecommendations                      : Boolean   ;
    function GetOutOfStockControl                           : Boolean   ;
    Function GetBuyItNowPrice: Double;
    Function GetReservePrice: Double;
    Function GetStartPrice: Double;
    Function GetClassifiedAdPayPerLeadFee: Double;
    Function GetBuyerGuaranteePrice: Double;
    Function GetFloorPrice: Double;
    Function GetCeilingPrice: Double;
    Function GetBuyItNowPriceCurCode:String;
    Function GetReservePriceCurCode:String;
    Function GetStartPriceCurCode:String;
    Function GetClassifiedAdPayPerLeadFeeCurCode:String;
    Function GetBuyerGuaranteePriceCurCode:String;
    Function GetFloorPriceCurCode:String;



    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetApplicationData                             (const Value: string    );
    procedure SetAutoPay                                     (const Value: Boolean   );
    procedure SetMotorsGermanySearchable                     (const Value: Boolean   );
    procedure SetBuyerProtection                             (const Value: string    );
    procedure SetCategoryMappingAllowed                      (const Value: Boolean   );
    procedure SetCountry                                     (const Value: string    );
    procedure SetCurrency                                    (const Value: string    );
    procedure SetDescription                                 (const Value: string    );
    procedure SetDescriptionReviseMode                       (const Value: string    );
    procedure SetGiftIcon                                    (const Value: Integer   );
    procedure SetHitCounter                                  (const Value: string    );
    procedure SetItemID                                      (const Value: string    );
    procedure SetListingDuration                             (const Value: string    );
    procedure SetListingType                                 (const Value: string    );
    procedure SetLocation                                    (const Value: string    );
    procedure SetLotSize                                     (const Value: Integer   );
    procedure SetPartnerCode                                 (const Value: string    );
    procedure SetPartnerName                                 (const Value: string    );
    procedure SetPayPalEmailAddress                          (const Value: string    );
    procedure SetPrivateListing                              (const Value: Boolean   );
    procedure SetQuantity                                    (const Value: Integer   );
    procedure SetPrivateNotes                                (const Value: string    );
    procedure SetRegionID                                    (const Value: string    );
    procedure SetRelistLink                                  (const Value: Boolean   );
    procedure SetSite                                        (const Value: string    );
    procedure SetSubTitle                                    (const Value: string    );
    procedure SetTitle                                       (const Value: string    );
    procedure SetUUID                                        (const Value: string    );
    procedure SetSellerVacationNote                          (const Value: string    );
    procedure SetWatchCount                                  (const Value: Integer   );
    procedure SetHitCount                                    (const Value: Integer   );
    procedure SetDisableBuyerRequirements                    (const Value: Boolean   );
    procedure SetLocationDefaulted                           (const Value: Boolean   );
    procedure SetThirdPartyCheckout                          (const Value: Boolean   );
    procedure SetUseTaxTable                                 (const Value: Boolean   );
    procedure SetGetItFast                                   (const Value: Boolean   );
    procedure SetBuyerResponsibleForShipping                 (const Value: Boolean   );
    procedure SetLimitedWarrantyEligible                     (const Value: Boolean   );
    procedure SeteBayNotes                                   (const Value: string    );
    procedure SetQuestionCount                               (const Value: Integer   );
    procedure SetRelisted                                    (const Value: Boolean   );
    procedure SetQuantityAvailable                           (const Value: Integer   );
    procedure SetSKU                                         (const Value: string    );
    procedure SetCategoryBasedAttributesPrefill              (const Value: Boolean   );
    procedure SetPostalCode                                  (const Value: string    );
    procedure SetShippingTermsInDescription                  (const Value: Boolean   );
    procedure SetSellerInventoryID                           (const Value: string    );
    procedure SetDispatchTimeMax                             (const Value: Integer   );
    procedure SetSkypeEnabled                                (const Value: Boolean   );
    procedure SetSkypeID                                     (const Value: string    );
    procedure SetBestOfferEnabled                            (const Value: Boolean   );
    procedure SetLocalListing                                (const Value: Boolean   );
    procedure SetThirdPartyCheckoutIntegration               (const Value: Boolean   );
    procedure SetTotalQuestionCount                          (const Value: Integer   );
    procedure SetProxyItem                                   (const Value: Boolean   );
    procedure SetLeadCount                                   (const Value: Integer   );
    procedure SetNewLeadCount                                (const Value: Integer   );
    procedure SetGroupCategoryID                             (const Value: string    );
    procedure SetBidGroupItem                                (const Value: Boolean   );
    procedure SetListingSubtype2                             (const Value: string    );
    procedure SetMechanicalCheckAccepted                     (const Value: Boolean   );
    procedure SetUpdateSellerInfo                            (const Value: Boolean   );
    procedure SetUpdateReturnPolicy                          (const Value: Boolean   );
    procedure SetInventoryTrackingMethod                     (const Value: string    );
    procedure SetIntegratedMerchantCreditCardEnabled         (const Value: Boolean   );
    procedure SetItemCompatibilityCount                      (const Value: Integer   );
    procedure SetConditionID                                 (const Value: Integer   );
    procedure SetConditionDescription                        (const Value: string    );
    procedure SetConditionDisplayName                        (const Value: string    );
    procedure SetTaxCategory                                 (const Value: string    );
    procedure SetQuantityAvailableHint                       (const Value: string    );
    procedure SetQuantityThreshold                           (const Value: Integer   );
    procedure SetPostCheckoutExperienceEnabled               (const Value: Boolean   );
    procedure SetUseRecommendedProduct                       (const Value: Boolean   );
    procedure SetSellerProvidedTitle                         (const Value: string    );
    procedure SetVIN                                         (const Value: string    );
    procedure SetVINLink                                     (const Value: string    );
    procedure SetVRM                                         (const Value: string    );
    procedure SetVRMLink                                     (const Value: string    );
    procedure SetTopRatedListing                             (const Value: Boolean   );
    procedure SetIsIntermediatedShippingEligible             (const Value: Boolean   );
    procedure SetRelistParentID                              (const Value: Integer   );
    procedure SetConditionDefinition                         (const Value: string    );
    procedure SetHideFromSearch                              (const Value: Boolean   );
    procedure SetReasonHideFromSearch                        (const Value: string    );
    procedure SetIncludeRecommendations                      (const Value: Boolean   );
    procedure SetOutOfStockControl                           (const Value: Boolean   );
    Procedure SetBuyItNowPrice(const Value : Double);
    Procedure SetReservePrice(const Value : Double);
    Procedure SetStartPrice(const Value : Double);
    Procedure SetClassifiedAdPayPerLeadFee(const Value : Double);
    Procedure SetBuyerGuaranteePrice(const Value : Double);
    Procedure SetFloorPrice(const Value : Double);
    Procedure SetCeilingPrice(const Value : Double);
    Procedure SetBuyItNowPriceCurCode(const Value : String);
    Procedure SetReservePriceCurCode(const Value : String);
    Procedure SetStartPriceCurCode(const Value : String);
    Procedure SetClassifiedAdPayPerLeadFeeCurCode(const Value : String);
    Procedure SetBuyerGuaranteePriceCurCode(const Value : String);
    Procedure SetFloorPriceCurCode(const Value : String);
    Procedure SetCeilingPriceCurCode(const Value : String);
    function getSkypecontact:Tebay_orders_trans_item_skypecontactoption;
    function getAttribSet:Tebay_orders_trans_item_attribsetarr;
    function getGiftService:Tebay_orders_trans_item_giftservices;
    function getListingEnhancement:Tebay_orders_trans_item_ListingEnhancement;
    function getPaymentAllodSite:Tebay_orders_trans_item_paymentallowedsite;
    function getShiptoLocations:Tebay_orders_trans_item_shiptolocations;
    function getItemSpecifics:Tebay_orders_trans_item_itemspecifics;
    function getCrossBT:Tebay_orders_trans_item_crossbt;
    function getAttribArr:Tebay_orders_trans_item_attribarr;
    //function getLookupAttribArr:Tebay_orders_trans_item_LookupAttribArr;
    Function GetCeilingPriceCurCode:String;
    Function GetHoursToDeposit:Integer;
    Function GetDaysToFullPayment :Integer;
    Function GetDepositType :String;
    Function GetDepositAmount  :Double;
    Function GetDepositAmountCurCode :string;
    Procedure SetHoursToDeposit(const Value :Integer);
    Procedure SetDaysToFullPayment (const Value :Integer);
    Procedure SetDepositType (const Value :String);
    Procedure SetDepositAmount  (const Value :Double);
    Procedure SetDepositAmountCurCode (const Value :string);

    function GetConvertedMaxBid:double;
    function GetMaxBid:          double;
    function GetConvertedMaxBidcurcode: String;
    function GetMaxBidcurCode:          String;
    function GetQuantityBid:     Integer;
    function GetQuantityWon:     Integer;
    function GetWinning:         Boolean;
    function GetBidAssistant:    Boolean;
    Procedure SetConvertedMaxBid(const Value :double);
    Procedure SetMaxBid(const Value :          double);
    Procedure SetConvertedMaxBidcurcode(const Value : String);
    Procedure SetMaxBidcurCode(const Value :          String);
    Procedure SetQuantityBid(const Value :     Integer);
    Procedure SetQuantityWon(const Value :     Integer);
    Procedure SetWinning(const Value :         Boolean);
    Procedure SetBidAssistant(const Value :    Boolean);

    function GetCharityName:     string;
    function GetCharityNumber:   Integer;
    function GetDonationPercent: Double  ;
    function GetCharityID:       string   ;
    function GetMission:         string   ;
    function GetLogoURL:         string   ;
    function GetStatus:          String;
    function GetCharityListing:  Boolean;


    Procedure SetCharityName(const Value :     string);
    Procedure SetCharityNumber(const Value :   Integer);
    Procedure SetDonationPercent(const Value : Double);
    Procedure SetCharityID(const Value :       string);
    Procedure SetMission(const Value :         string);
    Procedure SetLogoURL(const Value :         string );
    Procedure SetStatus(const Value :        String  );
    Procedure SetCharityListing(const Value :  Boolean );


  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
    Property Skypecontact:Tebay_orders_trans_item_skypecontactoption read getSkypecontact;
    Property AttribSet:Tebay_orders_trans_item_attribsetarr read getAttribSet;
    Property GiftService:Tebay_orders_trans_item_giftservices read getGiftService;
    Property ListingEnhancement:Tebay_orders_trans_item_ListingEnhancement read getListingEnhancement;
    Property PaymentAllodSite:Tebay_orders_trans_item_paymentallowedsite read getPaymentAllodSite;
    Property ShiptoLocations:Tebay_orders_trans_item_shiptolocations read getShiptoLocations;
    Property ItemSpecifics:Tebay_orders_trans_item_itemspecifics read getItemSpecifics;
    Property CrossBT:Tebay_orders_trans_item_crossbt read getCrossBT;
    Property AttribArr:Tebay_orders_trans_item_attribarr read getAttribArr;
    //Property LookupAttribArr:Tebay_orders_trans_item_LookupAttribArr read getLookupAttribArr;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property ApplicationData                              :string      read GetApplicationData                            write SetApplicationData                         ;
    property AutoPay                                      :Boolean     read GetAutoPay                                    write SetAutoPay                                 ;
    property MotorsGermanySearchable                      :Boolean     read GetMotorsGermanySearchable                    write SetMotorsGermanySearchable                 ;
    property BuyerProtection                              :string      read GetBuyerProtection                            write SetBuyerProtection                         ;
    property CategoryMappingAllowed                       :Boolean     read GetCategoryMappingAllowed                     write SetCategoryMappingAllowed                  ;
    property Country                                      :string      read GetCountry                                    write SetCountry                                 ;
    property Currency                                     :string      read GetCurrency                                   write SetCurrency                                ;
    property Description                                  :string      read GetDescription                                write SetDescription                             ;
    property DescriptionReviseMode                        :string      read GetDescriptionReviseMode                      write SetDescriptionReviseMode                   ;
    property GiftIcon                                     :Integer     read GetGiftIcon                                   write SetGiftIcon                                ;
    property HitCounter                                   :string      read GetHitCounter                                 write SetHitCounter                              ;
    property ItemID                                       :string      read GetItemID                                     write SetItemID                                  ;
    property ListingDuration                              :string      read GetListingDuration                            write SetListingDuration                         ;
    property ListingType                                  :string      read GetListingType                                write SetListingType                             ;
    property Location                                     :string      read GetLocation                                   write SetLocation                                ;
    property LotSize                                      :Integer     read GetLotSize                                    write SetLotSize                                 ;
    property PartnerCode                                  :string      read GetPartnerCode                                write SetPartnerCode                             ;
    property PartnerName                                  :string      read GetPartnerName                                write SetPartnerName                             ;
    property PayPalEmailAddress                           :string      read GetPayPalEmailAddress                         write SetPayPalEmailAddress                      ;
    property PrivateListing                               :Boolean     read GetPrivateListing                             write SetPrivateListing                          ;
    property Quantity                                     :Integer     read GetQuantity                                   write SetQuantity                                ;
    property PrivateNotes                                 :string      read GetPrivateNotes                               write SetPrivateNotes                            ;
    property RegionID                                     :string      read GetRegionID                                   write SetRegionID                                ;
    property RelistLink                                   :Boolean     read GetRelistLink                                 write SetRelistLink                              ;
    property Site                                         :string      read GetSite                                       write SetSite                                    ;
    property SubTitle                                     :string      read GetSubTitle                                   write SetSubTitle                                ;
    property Title                                        :string      read GetTitle                                      write SetTitle                                   ;
    property UUID                                         :string      read GetUUID                                       write SetUUID                                    ;
    property SellerVacationNote                           :string      read GetSellerVacationNote                         write SetSellerVacationNote                      ;
    property WatchCount                                   :Integer     read GetWatchCount                                 write SetWatchCount                              ;
    property HitCount                                     :Integer     read GetHitCount                                   write SetHitCount                                ;
    property DisableBuyerRequirements                     :Boolean     read GetDisableBuyerRequirements                   write SetDisableBuyerRequirements                ;
    property LocationDefaulted                            :Boolean     read GetLocationDefaulted                          write SetLocationDefaulted                       ;
    property ThirdPartyCheckout                           :Boolean     read GetThirdPartyCheckout                         write SetThirdPartyCheckout                      ;
    property UseTaxTable                                  :Boolean     read GetUseTaxTable                                write SetUseTaxTable                             ;
    property GetItFast                                    :Boolean     read GetGetItFast                                  write SetGetItFast                               ;
    property BuyerResponsibleForShipping                  :Boolean     read GetBuyerResponsibleForShipping                write SetBuyerResponsibleForShipping             ;
    property LimitedWarrantyEligible                      :Boolean     read GetLimitedWarrantyEligible                    write SetLimitedWarrantyEligible                 ;
    property eBayNotes                                    :string      read GeteBayNotes                                  write SeteBayNotes                               ;
    property QuestionCount                                :Integer     read GetQuestionCount                              write SetQuestionCount                           ;
    property Relisted                                     :Boolean     read GetRelisted                                   write SetRelisted                                ;
    property QuantityAvailable                            :Integer     read GetQuantityAvailable                          write SetQuantityAvailable                       ;
    property SKU                                          :string      read GetSKU                                        write SetSKU                                     ;
    property CategoryBasedAttributesPrefill               :Boolean     read GetCategoryBasedAttributesPrefill             write SetCategoryBasedAttributesPrefill          ;
    property PostalCode                                   :string      read GetPostalCode                                 write SetPostalCode                              ;
    property ShippingTermsInDescription                   :Boolean     read GetShippingTermsInDescription                 write SetShippingTermsInDescription              ;
    property SellerInventoryID                            :string      read GetSellerInventoryID                          write SetSellerInventoryID                       ;
    property DispatchTimeMax                              :Integer     read GetDispatchTimeMax                            write SetDispatchTimeMax                         ;
    property SkypeEnabled                                 :Boolean     read GetSkypeEnabled                               write SetSkypeEnabled                            ;
    property SkypeID                                      :string      read GetSkypeID                                    write SetSkypeID                                 ;
    property BestOfferEnabled                             :Boolean     read GetBestOfferEnabled                           write SetBestOfferEnabled                        ;
    property LocalListing                                 :Boolean     read GetLocalListing                               write SetLocalListing                            ;
    property ThirdPartyCheckoutIntegration                :Boolean     read GetThirdPartyCheckoutIntegration              write SetThirdPartyCheckoutIntegration           ;
    property TotalQuestionCount                           :Integer     read GetTotalQuestionCount                         write SetTotalQuestionCount                      ;
    property ProxyItem                                    :Boolean     read GetProxyItem                                  write SetProxyItem                               ;
    property LeadCount                                    :Integer     read GetLeadCount                                  write SetLeadCount                               ;
    property NewLeadCount                                 :Integer     read GetNewLeadCount                               write SetNewLeadCount                            ;
    property GroupCategoryID                              :string      read GetGroupCategoryID                            write SetGroupCategoryID                         ;
    property BidGroupItem                                 :Boolean     read GetBidGroupItem                               write SetBidGroupItem                            ;
    property ListingSubtype2                              :string      read GetListingSubtype2                            write SetListingSubtype2                         ;
    property MechanicalCheckAccepted                      :Boolean     read GetMechanicalCheckAccepted                    write SetMechanicalCheckAccepted                 ;
    property UpdateSellerInfo                             :Boolean     read GetUpdateSellerInfo                           write SetUpdateSellerInfo                        ;
    property UpdateReturnPolicy                           :Boolean     read GetUpdateReturnPolicy                         write SetUpdateReturnPolicy                      ;
    property InventoryTrackingMethod                      :string      read GetInventoryTrackingMethod                    write SetInventoryTrackingMethod                 ;
    property IntegratedMerchantCreditCardEnabled          :Boolean     read GetIntegratedMerchantCreditCardEnabled        write SetIntegratedMerchantCreditCardEnabled     ;
    property ItemCompatibilityCount                       :Integer     read GetItemCompatibilityCount                     write SetItemCompatibilityCount                  ;
    property ConditionID                                  :Integer     read GetConditionID                                write SetConditionID                             ;
    property ConditionDescription                         :string      read GetConditionDescription                       write SetConditionDescription                    ;
    property ConditionDisplayName                         :string      read GetConditionDisplayName                       write SetConditionDisplayName                    ;
    property TaxCategory                                  :string      read GetTaxCategory                                write SetTaxCategory                             ;
    property QuantityAvailableHint                        :string      read GetQuantityAvailableHint                      write SetQuantityAvailableHint                   ;
    property QuantityThreshold                            :Integer     read GetQuantityThreshold                          write SetQuantityThreshold                       ;
    property PostCheckoutExperienceEnabled                :Boolean     read GetPostCheckoutExperienceEnabled              write SetPostCheckoutExperienceEnabled           ;
    property UseRecommendedProduct                        :Boolean     read GetUseRecommendedProduct                      write SetUseRecommendedProduct                   ;
    property SellerProvidedTitle                          :string      read GetSellerProvidedTitle                        write SetSellerProvidedTitle                     ;
    property VIN                                          :string      read GetVIN                                        write SetVIN                                     ;
    property VINLink                                      :string      read GetVINLink                                    write SetVINLink                                 ;
    property VRM                                          :string      read GetVRM                                        write SetVRM                                     ;
    property VRMLink                                      :string      read GetVRMLink                                    write SetVRMLink                                 ;
    property TopRatedListing                              :Boolean     read GetTopRatedListing                            write SetTopRatedListing                         ;
    property IsIntermediatedShippingEligible              :Boolean     read GetIsIntermediatedShippingEligible            write SetIsIntermediatedShippingEligible         ;
    property RelistParentID                               :Integer     read GetRelistParentID                             write SetRelistParentID                          ;
    property ConditionDefinition                          :string      read GetConditionDefinition                        write SetConditionDefinition                     ;
    property HideFromSearch                               :Boolean     read GetHideFromSearch                             write SetHideFromSearch                          ;
    property ReasonHideFromSearch                         :string      read GetReasonHideFromSearch                       write SetReasonHideFromSearch                    ;
    property IncludeRecommendations                       :Boolean     read GetIncludeRecommendations                     write SetIncludeRecommendations                  ;
    property OutOfStockControl                            :Boolean     read GetOutOfStockControl                          write SetOutOfStockControl                       ;
    Property BuyItNowPrice: Double read getBuyItNowPrice Write  SetBuyItNowPrice;
    Property ReservePrice: Double read getReservePrice Write  SetReservePrice;
    Property StartPrice: Double read getStartPrice Write  SetStartPrice;
    Property ClassifiedAdPayPerLeadFee: Double read getClassifiedAdPayPerLeadFee Write  SetClassifiedAdPayPerLeadFee;
    Property BuyerGuaranteePrice: Double read getBuyerGuaranteePrice Write  SetBuyerGuaranteePrice;
    Property FloorPrice: Double read getFloorPrice Write  SetFloorPrice;
    Property CeilingPrice: Double read getCeilingPrice Write  SetCeilingPrice;
    Property BuyItNowPriceCurCode:String read getBuyItNowPriceCurCode Write  SetBuyItNowPriceCurCode;
    Property ReservePriceCurCode:String read getReservePriceCurCode Write  SetReservePriceCurCode;
    Property StartPriceCurCode:String read getStartPriceCurCode Write  SetStartPriceCurCode;
    Property ClassifiedAdPayPerLeadFeeCurCode:String read getClassifiedAdPayPerLeadFeeCurCode Write  SetClassifiedAdPayPerLeadFeeCurCode;
    Property BuyerGuaranteePriceCurCode:String read getBuyerGuaranteePriceCurCode Write  SetBuyerGuaranteePriceCurCode;
    Property FloorPriceCurCode:String read getFloorPriceCurCode Write  SetFloorPriceCurCode;
    Property CeilingPriceCurCode:String read getCeilingPriceCurCode Write  SetCeilingPriceCurCode;
    Property HoursToDeposit : Integer read getHoursToDeposit write setHoursToDeposit;
    Property DaysToFullPayment : Integer read getDaysToFullPayment write setDaysToFullPayment;
    Property DepositType :String read getDepositType write setDepositType;
    Property DepositAmount  :Double read getDepositAmount write setDepositAmount;
    Property DepositAmountCurCode :String read getDepositAmountCurCode write setDepositAmountCurCode;
    Property ConvertedMaxBid   : double read getConvertedMaxBid Write SetConvertedMaxBid;
    Property MaxBid   :           double read getMaxBid Write SetMaxBid;
    Property ConvertedMaxBidcurcode   :  String read getConvertedMaxBidcurcode Write SetConvertedMaxBidcurcode;
    Property MaxBidcurCode   :           String read getMaxBidcurCode Write SetMaxBidcurCode;
    Property QuantityBid   :      Integer read getQuantityBid Write SetQuantityBid;
    Property QuantityWon   :      Integer read getQuantityWon Write SetQuantityWon;
    Property Winning   :          Boolean read getWinning Write SetWinning;
    Property BidAssistant   :     Boolean read getBidAssistant Write SetBidAssistant;
    property CharityName:     string                 read GetCharityName write SetCharityName ;
    property CharityNumber:   Integer                read GetCharityNumber write SetCharityNumber ;
    property DonationPercent: Double                 read GetDonationPercent write SetDonationPercent ;
    property CharityID:       string                 read GetCharityID write SetCharityID ;
    property Mission:         string                 read GetMission write SetMission ;
    property LogoURL:         string                 read GetLogoURL write SetLogoURL ;
    property Status:          String                 read GetStatus write SetStatus ;
    property CharityListing:  Boolean                read GetCharityListing write SetCharityListing ;



   end;


implementation

uses Sysutils;





  {Tebay_orders_trans_item}

constructor Tebay_orders_trans_item.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_item';
end;

{Property Functions}
function  Tebay_orders_trans_item.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_item.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_item.GetApplicationData                         : string    ; begin Result := GetFieldValue('ApplicationData');end;
function  Tebay_orders_trans_item.GetAutoPay                                 : Boolean   ; begin Result := GetFieldValue('AutoPay');end;
function  Tebay_orders_trans_item.GetMotorsGermanySearchable                 : Boolean   ; begin Result := GetFieldValue('MotorsGermanySearchable');end;
function  Tebay_orders_trans_item.GetBuyerProtection                         : string    ; begin Result := GetFieldValue('BuyerProtection');end;
function  Tebay_orders_trans_item.GetCategoryMappingAllowed                  : Boolean   ; begin Result := GetFieldValue('CategoryMappingAllowed');end;
function  Tebay_orders_trans_item.GetCountry                                 : string    ; begin Result := GetFieldValue('Country');end;
function  Tebay_orders_trans_item.GetCurrency                                : string    ; begin Result := GetFieldValue('Currency');end;
function  Tebay_orders_trans_item.GetDescription                             : string    ; begin Result := GetFieldValue('Description');end;
function  Tebay_orders_trans_item.GetDescriptionReviseMode                   : string    ; begin Result := GetFieldValue('DescriptionReviseMode');end;
function  Tebay_orders_trans_item.GetGiftIcon                                : Integer   ; begin Result := GetFieldValue('GiftIcon');end;
function  Tebay_orders_trans_item.GetHitCounter                              : string    ; begin Result := GetFieldValue('HitCounter');end;
function  Tebay_orders_trans_item.GetItemID                                  : string    ; begin Result := GetFieldValue('ItemID');end;
function  Tebay_orders_trans_item.GetListingDuration                         : string    ; begin Result := GetFieldValue('ListingDuration');end;
function  Tebay_orders_trans_item.GetListingType                             : string    ; begin Result := GetFieldValue('ListingType');end;
function  Tebay_orders_trans_item.GetLocation                                : string    ; begin Result := GetFieldValue('Location');end;
function  Tebay_orders_trans_item.GetLotSize                                 : Integer   ; begin Result := GetFieldValue('LotSize');end;
function  Tebay_orders_trans_item.GetPartnerCode                             : string    ; begin Result := GetFieldValue('PartnerCode');end;
function  Tebay_orders_trans_item.GetPartnerName                             : string    ; begin Result := GetFieldValue('PartnerName');end;
function  Tebay_orders_trans_item.GetPayPalEmailAddress                      : string    ; begin Result := GetFieldValue('PayPalEmailAddress');end;
function  Tebay_orders_trans_item.GetPrivateListing                          : Boolean   ; begin Result := GetFieldValue('PrivateListing');end;
function  Tebay_orders_trans_item.GetQuantity                                : Integer   ; begin Result := GetFieldValue('Quantity');end;
function  Tebay_orders_trans_item.GetPrivateNotes                            : string    ; begin Result := GetFieldValue('PrivateNotes');end;
function  Tebay_orders_trans_item.GetRegionID                                : string    ; begin Result := GetFieldValue('RegionID');end;
function  Tebay_orders_trans_item.GetRelistLink                              : Boolean   ; begin Result := GetFieldValue('RelistLink');end;
function  Tebay_orders_trans_item.GetSite                                    : string    ; begin Result := GetFieldValue('Site');end;
function  Tebay_orders_trans_item.GetSubTitle                                : string    ; begin Result := GetFieldValue('SubTitle');end;
function  Tebay_orders_trans_item.GetTitle                                   : string    ; begin Result := GetFieldValue('Title');end;
function  Tebay_orders_trans_item.GetUUID                                    : string    ; begin Result := GetFieldValue('UUID');end;
function  Tebay_orders_trans_item.GetSellerVacationNote                      : string    ; begin Result := GetFieldValue('SellerVacationNote');end;
function  Tebay_orders_trans_item.GetWatchCount                              : Integer   ; begin Result := GetFieldValue('WatchCount');end;
function  Tebay_orders_trans_item.GetHitCount                                : Integer   ; begin Result := GetFieldValue('HitCount');end;
function  Tebay_orders_trans_item.GetDisableBuyerRequirements                : Boolean   ; begin Result := GetFieldValue('DisableBuyerRequirements');end;
function  Tebay_orders_trans_item.GetLocationDefaulted                       : Boolean   ; begin Result := GetFieldValue('LocationDefaulted');end;
function  Tebay_orders_trans_item.GetThirdPartyCheckout                      : Boolean   ; begin Result := GetFieldValue('ThirdPartyCheckout');end;
function  Tebay_orders_trans_item.GetUseTaxTable                             : Boolean   ; begin Result := GetFieldValue('UseTaxTable');end;
function  Tebay_orders_trans_item.GetGetItFast                               : Boolean   ; begin Result := GetFieldValue('GetItFast');end;
function  Tebay_orders_trans_item.GetBuyerResponsibleForShipping             : Boolean   ; begin Result := GetFieldValue('BuyerResponsibleForShipping');end;
function  Tebay_orders_trans_item.GetLimitedWarrantyEligible                 : Boolean   ; begin Result := GetFieldValue('LimitedWarrantyEligible');end;
function  Tebay_orders_trans_item.GeteBayNotes                               : string    ; begin Result := GetFieldValue('eBayNotes');end;
function  Tebay_orders_trans_item.GetQuestionCount                           : Integer   ; begin Result := GetFieldValue('QuestionCount');end;
function  Tebay_orders_trans_item.GetRelisted                                : Boolean   ; begin Result := GetFieldValue('Relisted');end;
function  Tebay_orders_trans_item.GetQuantityAvailable                       : Integer   ; begin Result := GetFieldValue('QuantityAvailable');end;
function  Tebay_orders_trans_item.GetSKU                                     : string    ; begin Result := GetFieldValue('SKU');end;
function Tebay_orders_trans_item.getSkypecontact: Tebay_orders_trans_item_skypecontactoption;
begin
  if (fSkypecontact = nil) then begin
    fSkypecontact:= Tebay_orders_trans_item_skypecontactoption.Create(self, 'tblebay_orders_trans_item_skypecontactoption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fSkypecontact.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fSkypecontact.Dataset;
  result:= fSkypecontact;
end;
function Tebay_orders_trans_item.getAttribSet: Tebay_orders_trans_item_attribsetarr;
begin
  if (fAttribSet = nil) then begin
    fAttribSet:= Tebay_orders_trans_item_attribsetarr.Create(self, 'tblebay_orders_trans_item_attributeset',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fAttribSet.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fAttribSet.Dataset;
  result:= fAttribSet;
end;
function Tebay_orders_trans_item.getGiftService: Tebay_orders_trans_item_giftservices;
begin
  if (fGiftService = nil) then begin
    fGiftService:= Tebay_orders_trans_item_giftservices.Create(self, 'tblebay_orders_trans_item_GiftServiceoption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fGiftService.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fGiftService.Dataset;
  result:= fGiftService;
end;
function Tebay_orders_trans_item.getListingEnhancement: Tebay_orders_trans_item_ListingEnhancement;
begin
  if (fListingEnhancement = nil) then begin
    fListingEnhancement:= Tebay_orders_trans_item_ListingEnhancement.Create(self, 'tblebay_orders_trans_item_ListingEnhancementoption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fListingEnhancement.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fListingEnhancement.Dataset;
  result:= fListingEnhancement;
end;
function Tebay_orders_trans_item.getPaymentAllodSite: Tebay_orders_trans_item_paymentallowedsite;
begin
  if (fPaymentAllodSite = nil) then begin
    fPaymentAllodSite:= Tebay_orders_trans_item_paymentallowedsite.Create(self, 'tblebay_orders_trans_item_PaymentAllodSiteoption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fPaymentAllodSite.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fPaymentAllodSite.Dataset;
  result:= fPaymentAllodSite;
end;
function Tebay_orders_trans_item.getShiptoLocations: Tebay_orders_trans_item_shiptolocations;
begin
  if (fShiptoLocations = nil) then begin
    fShiptoLocations:= Tebay_orders_trans_item_shiptolocations.Create(self, 'tblebay_orders_trans_item_ShiptoLocationsoption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fShiptoLocations.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fShiptoLocations.Dataset;
  result:= fShiptoLocations;
end;
function Tebay_orders_trans_item.getItemSpecifics: Tebay_orders_trans_item_itemspecifics;
begin
  if (fItemSpecifics = nil) then begin
    fItemSpecifics:= Tebay_orders_trans_item_itemspecifics.Create(self, 'tblebay_orders_trans_item_ItemSpecificsoption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fItemSpecifics.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fItemSpecifics.Dataset;
  result:= fItemSpecifics;
end;
function Tebay_orders_trans_item.getCrossBT: Tebay_orders_trans_item_crossbt;
begin
  if (fCrossBT = nil) then begin
    fCrossBT:= Tebay_orders_trans_item_crossbt.Create(self, 'tblebay_orders_trans_item_CrossBToption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fCrossBT.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fCrossBT.Dataset;
  result:= fCrossBT;
end;
function Tebay_orders_trans_item.getAttribArr: Tebay_orders_trans_item_attribarr;
begin
  if (fAttribArr = nil) then begin
    fAttribArr:= Tebay_orders_trans_item_attribarr.Create(self, 'tblebay_orders_trans_item_AttribArroption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fAttribArr.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fAttribArr.Dataset;
  result:= fAttribArr;
end;

(*function Tebay_orders_trans_item.getLookupAttribArr: Tebay_orders_trans_item_LookupAttribArr;
begin
  if (fLookupAttribArr = nil) then begin
    fLookupAttribArr:= Tebay_orders_trans_item_LookupAttribArr.Create(self, 'tblebay_orders_trans_item_LookupAttribArroption',
                  'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID));
  end;
  fLookupAttribArr.SQLWhere := 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(Orders_Trans_Id)+ ' and Orders_Trans_Item_Id =' + inttostr(ID);
  fLookupAttribArr.Dataset;
  result:= fLookupAttribArr;
end;*)

function  Tebay_orders_trans_item.GetCategoryBasedAttributesPrefill          : Boolean   ; begin Result := GetFieldValue('CategoryBasedAttributesPrefill');end;
function  Tebay_orders_trans_item.GetPostalCode                              : string    ; begin Result := GetFieldValue('PostalCode');end;
function  Tebay_orders_trans_item.GetShippingTermsInDescription              : Boolean   ; begin Result := GetFieldValue('ShippingTermsInDescription');end;
function  Tebay_orders_trans_item.GetSellerInventoryID                       : string    ; begin Result := GetFieldValue('SellerInventoryID');end;
function  Tebay_orders_trans_item.GetDispatchTimeMax                         : Integer   ; begin Result := GetFieldValue('DispatchTimeMax');end;
function  Tebay_orders_trans_item.GetSkypeEnabled                            : Boolean   ; begin Result := GetFieldValue('SkypeEnabled');end;
function  Tebay_orders_trans_item.GetSkypeID                                 : string    ; begin Result := GetFieldValue('SkypeID');end;
function  Tebay_orders_trans_item.GetBestOfferEnabled                        : Boolean   ; begin Result := GetFieldValue('BestOfferEnabled');end;
function  Tebay_orders_trans_item.GetLocalListing                            : Boolean   ; begin Result := GetFieldValue('LocalListing');end;
function  Tebay_orders_trans_item.GetThirdPartyCheckoutIntegration           : Boolean   ; begin Result := GetFieldValue('ThirdPartyCheckoutIntegration');end;
function  Tebay_orders_trans_item.GetTotalQuestionCount                      : Integer   ; begin Result := GetFieldValue('TotalQuestionCount');end;
function  Tebay_orders_trans_item.GetProxyItem                               : Boolean   ; begin Result := GetFieldValue('ProxyItem');end;
function  Tebay_orders_trans_item.GetLeadCount                               : Integer   ; begin Result := GetFieldValue('LeadCount');end;
function  Tebay_orders_trans_item.GetNewLeadCount                            : Integer   ; begin Result := GetFieldValue('NewLeadCount');end;
function  Tebay_orders_trans_item.GetGroupCategoryID                         : string    ; begin Result := GetFieldValue('GroupCategoryID');end;
function  Tebay_orders_trans_item.GetBidGroupItem                            : Boolean   ; begin Result := GetFieldValue('BidGroupItem');end;
function  Tebay_orders_trans_item.GetListingSubtype2                         : string    ; begin Result := GetFieldValue('ListingSubtype2');end;
function  Tebay_orders_trans_item.GetMechanicalCheckAccepted                 : Boolean   ; begin Result := GetFieldValue('MechanicalCheckAccepted');end;
function  Tebay_orders_trans_item.GetUpdateSellerInfo                        : Boolean   ; begin Result := GetFieldValue('UpdateSellerInfo');end;
function  Tebay_orders_trans_item.GetUpdateReturnPolicy                      : Boolean   ; begin Result := GetFieldValue('UpdateReturnPolicy');end;
function  Tebay_orders_trans_item.GetInventoryTrackingMethod                 : string    ; begin Result := GetFieldValue('InventoryTrackingMethod');end;
function  Tebay_orders_trans_item.GetIntegratedMerchantCreditCardEnabled     : Boolean   ; begin Result := GetFieldValue('IntegratedMerchantCreditCardEnabled');end;
function  Tebay_orders_trans_item.GetItemCompatibilityCount                  : Integer   ; begin Result := GetFieldValue('ItemCompatibilityCount');end;
function  Tebay_orders_trans_item.GetConditionID                             : Integer   ; begin Result := GetFieldValue('ConditionID');end;
function  Tebay_orders_trans_item.GetConditionDescription                    : string    ; begin Result := GetFieldValue('ConditionDescription');end;
function  Tebay_orders_trans_item.GetConditionDisplayName                    : string    ; begin Result := GetFieldValue('ConditionDisplayName');end;
function  Tebay_orders_trans_item.GetTaxCategory                             : string    ; begin Result := GetFieldValue('TaxCategory');end;
function  Tebay_orders_trans_item.GetQuantityAvailableHint                   : string    ; begin Result := GetFieldValue('QuantityAvailableHint');end;
function  Tebay_orders_trans_item.GetQuantityThreshold                       : Integer   ; begin Result := GetFieldValue('QuantityThreshold');end;
function  Tebay_orders_trans_item.GetPostCheckoutExperienceEnabled           : Boolean   ; begin Result := GetFieldValue('PostCheckoutExperienceEnabled');end;
function  Tebay_orders_trans_item.GetUseRecommendedProduct                   : Boolean   ; begin Result := GetFieldValue('UseRecommendedProduct');end;
function  Tebay_orders_trans_item.GetSellerProvidedTitle                     : string    ; begin Result := GetFieldValue('SellerProvidedTitle');end;
function  Tebay_orders_trans_item.GetVIN                                     : string    ; begin Result := GetFieldValue('VIN');end;
function  Tebay_orders_trans_item.GetVINLink                                 : string    ; begin Result := GetFieldValue('VINLink');end;
function  Tebay_orders_trans_item.GetVRM                                     : string    ; begin Result := GetFieldValue('VRM');end;
function  Tebay_orders_trans_item.GetVRMLink                                 : string    ; begin Result := GetFieldValue('VRMLink');end;
function  Tebay_orders_trans_item.GetTopRatedListing                         : Boolean   ; begin Result := GetFieldValue('TopRatedListing');end;
function  Tebay_orders_trans_item.GetIsIntermediatedShippingEligible         : Boolean   ; begin Result := GetFieldValue('IsIntermediatedShippingEligible');end;
function  Tebay_orders_trans_item.GetRelistParentID                          : Integer   ; begin Result := GetFieldValue('RelistParentID');end;
function  Tebay_orders_trans_item.GetConditionDefinition                     : string    ; begin Result := GetFieldValue('ConditionDefinition');end;
function  Tebay_orders_trans_item.GetHideFromSearch                          : Boolean   ; begin Result := GetFieldValue('HideFromSearch');end;
function  Tebay_orders_trans_item.GetReasonHideFromSearch                    : string    ; begin Result := GetFieldValue('ReasonHideFromSearch');end;
function  Tebay_orders_trans_item.GetIncludeRecommendations                  : Boolean   ; begin Result := GetFieldValue('IncludeRecommendations');end;
function  Tebay_orders_trans_item.GetOutOfStockControl                       : Boolean   ; begin Result := GetFieldValue('OutOfStockControl');end;
Function Tebay_orders_trans_item.GetBuyItNowPrice: Double;begin result := GetfieldValue('BuyItNowPrice'); end;
Function Tebay_orders_trans_item.GetReservePrice: Double;begin result := GetfieldValue('ReservePrice'); end;
Function Tebay_orders_trans_item.GetStartPrice: Double;begin result := GetfieldValue('StartPrice'); end;
Function Tebay_orders_trans_item.GetClassifiedAdPayPerLeadFee: Double;begin result := GetfieldValue('ClassifiedAdPayPerLeadFee'); end;
Function Tebay_orders_trans_item.GetBuyerGuaranteePrice: Double;begin result := GetfieldValue('BuyerGuaranteePrice'); end;
Function Tebay_orders_trans_item.GetFloorPrice: Double;begin result := GetfieldValue('FloorPrice'); end;
Function Tebay_orders_trans_item.GetCeilingPrice: Double;begin result := GetfieldValue('CeilingPrice'); end;
Function Tebay_orders_trans_item.GetBuyItNowPriceCurCode:String;begin result := GetfieldValue('BuyItNowPriceCurCode'); end;
Function Tebay_orders_trans_item.GetReservePriceCurCode:String;begin result := GetfieldValue('ReservePriceCurCode'); end;
Function Tebay_orders_trans_item.GetStartPriceCurCode:String;begin result := GetfieldValue('StartPriceCurCode'); end;
Function Tebay_orders_trans_item.GetClassifiedAdPayPerLeadFeeCurCode:String;begin result := GetfieldValue('ClassifiedAdPayPerLeadFeeCurCode'); end;
Function Tebay_orders_trans_item.GetBuyerGuaranteePriceCurCode:String;begin result := GetfieldValue('BuyerGuaranteePriceCurCode'); end;
Function Tebay_orders_trans_item.GetFloorPriceCurCode:String;begin result := GetfieldValue('FloorPriceCurCode'); end;
Function Tebay_orders_trans_item.GetCeilingPriceCurCode:String;begin result := GetfieldValue('CeilingPriceCurCode'); end;
procedure Tebay_orders_trans_item.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_item.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_item.SetApplicationData                         (const Value: string    ); begin SetFieldValue('ApplicationData'                          , Value);end;
procedure Tebay_orders_trans_item.SetAutoPay                                 (const Value: Boolean   ); begin SetFieldValue('AutoPay'                                  , Value);end;
procedure Tebay_orders_trans_item.SetMotorsGermanySearchable                 (const Value: Boolean   ); begin SetFieldValue('MotorsGermanySearchable'                  , Value);end;
procedure Tebay_orders_trans_item.SetBuyerProtection                         (const Value: string    ); begin SetFieldValue('BuyerProtection'                          , Value);end;
procedure Tebay_orders_trans_item.SetCategoryMappingAllowed                  (const Value: Boolean   ); begin SetFieldValue('CategoryMappingAllowed'                   , Value);end;
procedure Tebay_orders_trans_item.SetCountry                                 (const Value: string    ); begin SetFieldValue('Country'                                  , Value);end;
procedure Tebay_orders_trans_item.SetCurrency                                (const Value: string    ); begin SetFieldValue('Currency'                                 , Value);end;
procedure Tebay_orders_trans_item.SetDescription                             (const Value: string    ); begin SetFieldValue('Description'                              , Value);end;
procedure Tebay_orders_trans_item.SetDescriptionReviseMode                   (const Value: string    ); begin SetFieldValue('DescriptionReviseMode'                    , Value);end;
procedure Tebay_orders_trans_item.SetGiftIcon                                (const Value: Integer   ); begin SetFieldValue('GiftIcon'                                 , Value);end;
procedure Tebay_orders_trans_item.SetHitCounter                              (const Value: string    ); begin SetFieldValue('HitCounter'                               , Value);end;
procedure Tebay_orders_trans_item.SetItemID                                  (const Value: string    ); begin SetFieldValue('ItemID'                                   , Value);end;
procedure Tebay_orders_trans_item.SetListingDuration                         (const Value: string    ); begin SetFieldValue('ListingDuration'                          , Value);end;
procedure Tebay_orders_trans_item.SetListingType                             (const Value: string    ); begin SetFieldValue('ListingType'                              , Value);end;
procedure Tebay_orders_trans_item.SetLocation                                (const Value: string    ); begin SetFieldValue('Location'                                 , Value);end;
procedure Tebay_orders_trans_item.SetLotSize                                 (const Value: Integer   ); begin SetFieldValue('LotSize'                                  , Value);end;
procedure Tebay_orders_trans_item.SetPartnerCode                             (const Value: string    ); begin SetFieldValue('PartnerCode'                              , Value);end;
procedure Tebay_orders_trans_item.SetPartnerName                             (const Value: string    ); begin SetFieldValue('PartnerName'                              , Value);end;
procedure Tebay_orders_trans_item.SetPayPalEmailAddress                      (const Value: string    ); begin SetFieldValue('PayPalEmailAddress'                       , Value);end;
procedure Tebay_orders_trans_item.SetPrivateListing                          (const Value: Boolean   ); begin SetFieldValue('PrivateListing'                           , Value);end;
procedure Tebay_orders_trans_item.SetQuantity                                (const Value: Integer   ); begin SetFieldValue('Quantity'                                 , Value);end;
procedure Tebay_orders_trans_item.SetPrivateNotes                            (const Value: string    ); begin SetFieldValue('PrivateNotes'                             , Value);end;
procedure Tebay_orders_trans_item.SetRegionID                                (const Value: string    ); begin SetFieldValue('RegionID'                                 , Value);end;
procedure Tebay_orders_trans_item.SetRelistLink                              (const Value: Boolean   ); begin SetFieldValue('RelistLink'                               , Value);end;
procedure Tebay_orders_trans_item.SetSite                                    (const Value: string    ); begin SetFieldValue('Site'                                     , Value);end;
procedure Tebay_orders_trans_item.SetSubTitle                                (const Value: string    ); begin SetFieldValue('SubTitle'                                 , Value);end;
procedure Tebay_orders_trans_item.SetTitle                                   (const Value: string    ); begin SetFieldValue('Title'                                    , Value);end;
procedure Tebay_orders_trans_item.SetUUID                                    (const Value: string    ); begin SetFieldValue('UUID'                                     , Value);end;
procedure Tebay_orders_trans_item.SetSellerVacationNote                      (const Value: string    ); begin SetFieldValue('SellerVacationNote'                       , Value);end;
procedure Tebay_orders_trans_item.SetWatchCount                              (const Value: Integer   ); begin SetFieldValue('WatchCount'                               , Value);end;
procedure Tebay_orders_trans_item.SetHitCount                                (const Value: Integer   ); begin SetFieldValue('HitCount'                                 , Value);end;
procedure Tebay_orders_trans_item.SetDisableBuyerRequirements                (const Value: Boolean   ); begin SetFieldValue('DisableBuyerRequirements'                 , Value);end;
procedure Tebay_orders_trans_item.SetLocationDefaulted                       (const Value: Boolean   ); begin SetFieldValue('LocationDefaulted'                        , Value);end;
procedure Tebay_orders_trans_item.SetThirdPartyCheckout                      (const Value: Boolean   ); begin SetFieldValue('ThirdPartyCheckout'                       , Value);end;
procedure Tebay_orders_trans_item.SetUseTaxTable                             (const Value: Boolean   ); begin SetFieldValue('UseTaxTable'                              , Value);end;
procedure Tebay_orders_trans_item.SetGetItFast                               (const Value: Boolean   ); begin SetFieldValue('GetItFast'                                , Value);end;
procedure Tebay_orders_trans_item.SetBuyerResponsibleForShipping             (const Value: Boolean   ); begin SetFieldValue('BuyerResponsibleForShipping'              , Value);end;
procedure Tebay_orders_trans_item.SetLimitedWarrantyEligible                 (const Value: Boolean   ); begin SetFieldValue('LimitedWarrantyEligible'                  , Value);end;
procedure Tebay_orders_trans_item.SeteBayNotes                               (const Value: string    ); begin SetFieldValue('eBayNotes'                                , Value);end;
procedure Tebay_orders_trans_item.SetQuestionCount                           (const Value: Integer   ); begin SetFieldValue('QuestionCount'                            , Value);end;
procedure Tebay_orders_trans_item.SetRelisted                                (const Value: Boolean   ); begin SetFieldValue('Relisted'                                 , Value);end;
procedure Tebay_orders_trans_item.SetQuantityAvailable                       (const Value: Integer   ); begin SetFieldValue('QuantityAvailable'                        , Value);end;
procedure Tebay_orders_trans_item.SetSKU                                     (const Value: string    ); begin SetFieldValue('SKU'                                      , Value);end;
procedure Tebay_orders_trans_item.SetCategoryBasedAttributesPrefill          (const Value: Boolean   ); begin SetFieldValue('CategoryBasedAttributesPrefill'           , Value);end;
procedure Tebay_orders_trans_item.SetPostalCode                              (const Value: string    ); begin SetFieldValue('PostalCode'                               , Value);end;
procedure Tebay_orders_trans_item.SetShippingTermsInDescription              (const Value: Boolean   ); begin SetFieldValue('ShippingTermsInDescription'               , Value);end;
procedure Tebay_orders_trans_item.SetSellerInventoryID                       (const Value: string    ); begin SetFieldValue('SellerInventoryID'                        , Value);end;
procedure Tebay_orders_trans_item.SetDispatchTimeMax                         (const Value: Integer   ); begin SetFieldValue('DispatchTimeMax'                          , Value);end;
procedure Tebay_orders_trans_item.SetSkypeEnabled                            (const Value: Boolean   ); begin SetFieldValue('SkypeEnabled'                             , Value);end;
procedure Tebay_orders_trans_item.SetSkypeID                                 (const Value: string    ); begin SetFieldValue('SkypeID'                                  , Value);end;
procedure Tebay_orders_trans_item.SetBestOfferEnabled                        (const Value: Boolean   ); begin SetFieldValue('BestOfferEnabled'                         , Value);end;
procedure Tebay_orders_trans_item.SetLocalListing                            (const Value: Boolean   ); begin SetFieldValue('LocalListing'                             , Value);end;
procedure Tebay_orders_trans_item.SetThirdPartyCheckoutIntegration           (const Value: Boolean   ); begin SetFieldValue('ThirdPartyCheckoutIntegration'            , Value);end;
procedure Tebay_orders_trans_item.SetTotalQuestionCount                      (const Value: Integer   ); begin SetFieldValue('TotalQuestionCount'                       , Value);end;
procedure Tebay_orders_trans_item.SetProxyItem                               (const Value: Boolean   ); begin SetFieldValue('ProxyItem'                                , Value);end;
procedure Tebay_orders_trans_item.SetLeadCount                               (const Value: Integer   ); begin SetFieldValue('LeadCount'                                , Value);end;
procedure Tebay_orders_trans_item.SetNewLeadCount                            (const Value: Integer   ); begin SetFieldValue('NewLeadCount'                             , Value);end;
procedure Tebay_orders_trans_item.SetGroupCategoryID                         (const Value: string    ); begin SetFieldValue('GroupCategoryID'                          , Value);end;
procedure Tebay_orders_trans_item.SetBidGroupItem                            (const Value: Boolean   ); begin SetFieldValue('BidGroupItem'                             , Value);end;
procedure Tebay_orders_trans_item.SetListingSubtype2                         (const Value: string    ); begin SetFieldValue('ListingSubtype2'                          , Value);end;
procedure Tebay_orders_trans_item.SetMechanicalCheckAccepted                 (const Value: Boolean   ); begin SetFieldValue('MechanicalCheckAccepted'                  , Value);end;
procedure Tebay_orders_trans_item.SetUpdateSellerInfo                        (const Value: Boolean   ); begin SetFieldValue('UpdateSellerInfo'                         , Value);end;
procedure Tebay_orders_trans_item.SetUpdateReturnPolicy                      (const Value: Boolean   ); begin SetFieldValue('UpdateReturnPolicy'                       , Value);end;
procedure Tebay_orders_trans_item.SetInventoryTrackingMethod                 (const Value: string    ); begin SetFieldValue('InventoryTrackingMethod'                  , Value);end;
procedure Tebay_orders_trans_item.SetIntegratedMerchantCreditCardEnabled     (const Value: Boolean   ); begin SetFieldValue('IntegratedMerchantCreditCardEnabled'      , Value);end;
procedure Tebay_orders_trans_item.SetItemCompatibilityCount                  (const Value: Integer   ); begin SetFieldValue('ItemCompatibilityCount'                   , Value);end;
procedure Tebay_orders_trans_item.SetConditionID                             (const Value: Integer   ); begin SetFieldValue('ConditionID'                              , Value);end;
procedure Tebay_orders_trans_item.SetConditionDescription                    (const Value: string    ); begin SetFieldValue('ConditionDescription'                     , Value);end;
procedure Tebay_orders_trans_item.SetConditionDisplayName                    (const Value: string    ); begin SetFieldValue('ConditionDisplayName'                     , Value);end;
procedure Tebay_orders_trans_item.SetTaxCategory                             (const Value: string    ); begin SetFieldValue('TaxCategory'                              , Value);end;
procedure Tebay_orders_trans_item.SetQuantityAvailableHint                   (const Value: string    ); begin SetFieldValue('QuantityAvailableHint'                    , Value);end;
procedure Tebay_orders_trans_item.SetQuantityThreshold                       (const Value: Integer   ); begin SetFieldValue('QuantityThreshold'                        , Value);end;
procedure Tebay_orders_trans_item.SetPostCheckoutExperienceEnabled           (const Value: Boolean   ); begin SetFieldValue('PostCheckoutExperienceEnabled'            , Value);end;
procedure Tebay_orders_trans_item.SetUseRecommendedProduct                   (const Value: Boolean   ); begin SetFieldValue('UseRecommendedProduct'                    , Value);end;
procedure Tebay_orders_trans_item.SetSellerProvidedTitle                     (const Value: string    ); begin SetFieldValue('SellerProvidedTitle'                      , Value);end;
procedure Tebay_orders_trans_item.SetVIN                                     (const Value: string    ); begin SetFieldValue('VIN'                                      , Value);end;
procedure Tebay_orders_trans_item.SetVINLink                                 (const Value: string    ); begin SetFieldValue('VINLink'                                  , Value);end;
procedure Tebay_orders_trans_item.SetVRM                                     (const Value: string    ); begin SetFieldValue('VRM'                                      , Value);end;
procedure Tebay_orders_trans_item.SetVRMLink                                 (const Value: string    ); begin SetFieldValue('VRMLink'                                  , Value);end;
procedure Tebay_orders_trans_item.SetTopRatedListing                         (const Value: Boolean   ); begin SetFieldValue('TopRatedListing'                          , Value);end;
procedure Tebay_orders_trans_item.SetIsIntermediatedShippingEligible         (const Value: Boolean   ); begin SetFieldValue('IsIntermediatedShippingEligible'          , Value);end;
procedure Tebay_orders_trans_item.SetRelistParentID                          (const Value: Integer   ); begin SetFieldValue('RelistParentID'                           , Value);end;
procedure Tebay_orders_trans_item.SetConditionDefinition                     (const Value: string    ); begin SetFieldValue('ConditionDefinition'                      , Value);end;
procedure Tebay_orders_trans_item.SetHideFromSearch                          (const Value: boolean   ); begin SetFieldValue('HideFromSearch'                           , Value);end;
procedure Tebay_orders_trans_item.SetReasonHideFromSearch                    (const Value: string    ); begin SetFieldValue('ReasonHideFromSearch'                     , Value);end;
procedure Tebay_orders_trans_item.SetIncludeRecommendations                  (const Value: Boolean   ); begin SetFieldValue('IncludeRecommendations'                   , Value);end;
procedure Tebay_orders_trans_item.SetOutOfStockControl                       (const Value: Boolean   ); begin SetFieldValue('OutOfStockControl'                        , Value);end;
Procedure Tebay_orders_trans_item.SetBuyItNowPrice(const Value : Double);begin setFieldValue('BuyItNowPrice', Value); end;
Procedure Tebay_orders_trans_item.SetReservePrice(const Value : Double);begin setFieldValue('ReservePrice', Value); end;
Procedure Tebay_orders_trans_item.SetStartPrice(const Value : Double);begin setFieldValue('StartPrice', Value); end;
Procedure Tebay_orders_trans_item.SetClassifiedAdPayPerLeadFee(const Value : Double);begin setFieldValue('ClassifiedAdPayPerLeadFee', Value); end;
Procedure Tebay_orders_trans_item.SetBuyerGuaranteePrice(const Value : Double);begin setFieldValue('BuyerGuaranteePrice', Value); end;
Procedure Tebay_orders_trans_item.SetFloorPrice(const Value : Double);begin setFieldValue('FloorPrice', Value); end;
Procedure Tebay_orders_trans_item.SetCeilingPrice(const Value : Double);begin setFieldValue('CeilingPrice', Value); end;
Procedure Tebay_orders_trans_item.SetBuyItNowPriceCurCode(const Value : String);begin setFieldValue('BuyItNowPriceCurCode', Value); end;
Procedure Tebay_orders_trans_item.SetReservePriceCurCode(const Value : String);begin setFieldValue('ReservePriceCurCode', Value); end;
Procedure Tebay_orders_trans_item.SetStartPriceCurCode(const Value : String);begin setFieldValue('StartPriceCurCode', Value); end;
Procedure Tebay_orders_trans_item.SetClassifiedAdPayPerLeadFeeCurCode(const Value : String);begin setFieldValue('ClassifiedAdPayPerLeadFeeCurCode', Value); end;
Procedure Tebay_orders_trans_item.SetBuyerGuaranteePriceCurCode(const Value : String);begin setFieldValue('BuyerGuaranteePriceCurCode', Value); end;
Procedure Tebay_orders_trans_item.SetFloorPriceCurCode(const Value : String);begin setFieldValue('FloorPriceCurCode', Value); end;
Procedure Tebay_orders_trans_item.SetCeilingPriceCurCode(const Value : String);begin setFieldValue('CeilingPriceCurCode', Value); end;
Function Tebay_orders_trans_item.GetHoursToDeposit:Integer;begin result := GetFieldValue('HoursToDeposit');end;
Function Tebay_orders_trans_item.GetDaysToFullPayment :Integer;begin result := GetFieldValue('DaysToFullPayment');end;
Function Tebay_orders_trans_item.GetDepositType :String;begin result := GetFieldValue('DepositType');end;
Function Tebay_orders_trans_item.GetDepositAmount  :Double;begin result := GetFieldValue('DepositAmount');end;
Function Tebay_orders_trans_item.GetDepositAmountCurCode :string;begin result := GetFieldValue('DepositAmountCurCode');end;
Procedure Tebay_orders_trans_item.SetHoursToDeposit(const Value :Integer);begin SetFieldValue('HoursToDeposit', Value);end;
Procedure Tebay_orders_trans_item.SetDaysToFullPayment (const Value :Integer);begin SetFieldValue('DaysToFullPayment', Value);end;
Procedure Tebay_orders_trans_item.SetDepositType (const Value :String);begin SetFieldValue('DepositType', Value);end;
Procedure Tebay_orders_trans_item.SetDepositAmount  (const Value :Double);begin SetFieldValue('DepositAmount', Value);end;
Procedure Tebay_orders_trans_item.SetDepositAmountCurCode (const Value :string);begin SetFieldValue('DepositAmountCurCode', Value);end;
Function Tebay_orders_trans_item.GetConvertedMaxBid   : double; begin result := GetfieldValue('ConvertedMaxBid'); end;
Function Tebay_orders_trans_item.GetMaxBid   :           double; begin result := GetfieldValue('MaxBid'); end;
Function Tebay_orders_trans_item.GetConvertedMaxBidcurcode   :  String; begin result := GetfieldValue('ConvertedMaxBidcurcode'); end;
Function Tebay_orders_trans_item.GetMaxBidcurCode   :           String; begin result := GetfieldValue('MaxBidcurCode'); end;
Function Tebay_orders_trans_item.GetQuantityBid   :      Integer; begin result := GetfieldValue('QuantityBid'); end;
Function Tebay_orders_trans_item.GetQuantityWon   :      Integer; begin result := GetfieldValue('QuantityWon'); end;
Function Tebay_orders_trans_item.GetWinning   :          Boolean; begin result := GetfieldValue('Winning'); end;
Function Tebay_orders_trans_item.GetBidAssistant   :     Boolean; begin result := GetfieldValue('BidAssistant'); end;

Procedure  Tebay_orders_trans_item.SetConvertedMaxBid(const Value :double); begin SetfieldValue('ConvertedMaxBid', Value ); end;
Procedure  Tebay_orders_trans_item.SetMaxBid(const Value :          double); begin SetfieldValue('MaxBid', Value ); end;
Procedure  Tebay_orders_trans_item.SetConvertedMaxBidcurcode(const Value : String); begin SetfieldValue('ConvertedMaxBidcurcode', Value ); end;
Procedure  Tebay_orders_trans_item.SetMaxBidcurCode(const Value :          String); begin SetfieldValue('MaxBidcurCode', Value ); end;
Procedure  Tebay_orders_trans_item.SetQuantityBid(const Value :     Integer); begin SetfieldValue('QuantityBid', Value ); end;
Procedure  Tebay_orders_trans_item.SetQuantityWon(const Value :     Integer); begin SetfieldValue('QuantityWon', Value ); end;
Procedure  Tebay_orders_trans_item.SetWinning(const Value :         Boolean); begin SetfieldValue('Winning', Value ); end;
Procedure  Tebay_orders_trans_item.SetBidAssistant(const Value :    Boolean); begin SetfieldValue('BidAssistant', Value ); end;

Function Tebay_orders_trans_item.GetCharityName:     string ; begin result := GetFieldValue('CharityName');end ;
Function Tebay_orders_trans_item.GetCharityNumber:   Integer; begin result := GetFieldValue('CharityNumber');end ;
Function Tebay_orders_trans_item.GetDonationPercent: Double ; begin result := GetFieldValue('DonationPercent');end ;
Function Tebay_orders_trans_item.GetCharityID:       string ; begin result := GetFieldValue('CharityID');end ;
Function Tebay_orders_trans_item.GetMission:         string ; begin result := GetFieldValue('Mission');end ;
Function Tebay_orders_trans_item.GetLogoURL:         string ; begin result := GetFieldValue('LogoURL');end ;
Function Tebay_orders_trans_item.GetStatus:          String ; begin result := GetFieldValue('Status');end ;
Function Tebay_orders_trans_item.GetCharityListing:  Boolean; begin result := GetFieldValue('CharityListing');end ;


Procedure  Tebay_orders_trans_item.SetCharityName(const Value :      string  ); begin setFieldValue('CharityName', Value);end;
Procedure  Tebay_orders_trans_item.SetCharityNumber(const Value :    Integer ); begin setFieldValue('CharityNumber', Value);end;
Procedure  Tebay_orders_trans_item.SetDonationPercent(const Value :  Double); begin setFieldValue('DonationPercent', Value);end;
Procedure  Tebay_orders_trans_item.SetCharityID(const Value :        string  ); begin setFieldValue('CharityID', Value);end;
Procedure  Tebay_orders_trans_item.SetMission(const Value :          string  ); begin setFieldValue('Mission', Value);end;
Procedure  Tebay_orders_trans_item.SetLogoURL(const Value :          string  ); begin setFieldValue('LogoURL', Value);end;
Procedure  Tebay_orders_trans_item.SetStatus(const Value :           String  ); begin setFieldValue('Status', Value);end;
Procedure  Tebay_orders_trans_item.SetCharityListing(const Value :   Boolean ); begin setFieldValue('CharityListing', Value);end;

initialization
  RegisterClass(Tebay_orders_trans_item);


end.
