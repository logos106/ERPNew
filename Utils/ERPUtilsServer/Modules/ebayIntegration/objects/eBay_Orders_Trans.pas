unit eBay_Orders_Trans;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj, eBay_Orders_Trans_Buyer , eBay_Orders_Trans_item , ebay_orders_trans_taxes;


type
  Tebay_orders_trans = class(TeBayObjBase)
  private
    fBuyer: Tebay_orders_trans_buyer;
    fItem :Tebay_orders_trans_item;
    fTaxes :Tebay_orders_trans_taxes;
    function GetOrderID                                     : Integer   ;
    function GetCreatedDate                                 : TDateTime ;
    function GetDepositType                                 : string    ;
    function GetQuantityPurchased                           : Integer   ;
    function GetTransactionID                               : string    ;
    function GetBestOfferSale                               : Boolean   ;
    function GetBuyerMessage                                : string    ;
    function GetBuyerPaidStatus                             : string    ;
    function GetSellerPaidStatus                            : string    ;
    function GetTransactionSiteID                           : string    ;
    function GetPlatform_                                   : string    ;
    function GetCartID                                      : string    ;
    function GetSellerContactBuyerByEmail                   : Boolean   ;
    function GetPayPalEmailAddress                          : string    ;
    function GetPaisaPayID                                  : string    ;
    function GetBuyerCheckoutMessage                        : string    ;
    function GetBundlePurchase                              : Boolean   ;
    function GetOrderLineItemID                             : string    ;
    function GetRefundStatus                                : string    ;
    function GetCodiceFiscale                               : string    ;
    function GetIsMultiLegShipping                          : Boolean  ;
    function GetIntangibleItem                              : Boolean   ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetCreatedDate                                 (const Value: TDateTime );
    procedure SetDepositType                                 (const Value: string    );
    procedure SetQuantityPurchased                           (const Value: Integer   );
    procedure SetTransactionID                               (const Value: string    );
    procedure SetBestOfferSale                               (const Value: Boolean   );
    procedure SetBuyerMessage                                (const Value: string    );
    procedure SetBuyerPaidStatus                             (const Value: string    );
    procedure SetSellerPaidStatus                            (const Value: string    );
    procedure SetTransactionSiteID                           (const Value: string    );
    procedure SetPlatform_                                   (const Value: string    );
    procedure SetCartID                                      (const Value: string    );
    procedure SetSellerContactBuyerByEmail                   (const Value: Boolean   );
    procedure SetPayPalEmailAddress                          (const Value: string    );
    procedure SetPaisaPayID                                  (const Value: string    );
    procedure SetBuyerCheckoutMessage                        (const Value: string    );
    procedure SetBundlePurchase                              (const Value: Boolean   );
    procedure SetOrderLineItemID                             (const Value: string    );
    procedure SetRefundStatus                                (const Value: string    );
    procedure SetCodiceFiscale                               (const Value: string    );
    procedure SetIsMultiLegShipping                          (const Value: Boolean   );
    procedure SetIntangibleItem                              (const Value: Boolean   );
    function GetAmountPaid: double;
    function GetAdjustmentAmount: double;
    function GetConvertedAdjustmentAmount: double;
    function GetConvertedAmountPaid: double;
    function GetConvertedTransactionPrice: double;
    function GetTransactionPrice: double;
    function GetDutchAuctionBid: double;
    function GetTotalPrice: double;
    function GetFinalValueFee: double;
    function GetBuyerGuaranteePrice: double;
    function GetTotalTransactionPrice: double;
    function GetActualShippingCost: double;
    function GetActualHandlingCost: double;
    function GetRefundAmount: double;

    Procedure SetAmountPaid(const Value :Double);
    Procedure SetAdjustmentAmount(const Value :Double);
    Procedure SetConvertedAdjustmentAmount(const Value :Double);
    Procedure SetConvertedAmountPaid(const Value :Double);
    Procedure SetConvertedTransactionPrice(const Value :Double);
    Procedure SetTransactionPrice(const Value :Double);
    Procedure SetDutchAuctionBid(const Value :Double);
    Procedure SetTotalPrice(const Value :Double);
    Procedure SetFinalValueFee(const Value :Double);
    Procedure SetBuyerGuaranteePrice(const Value :Double);
    Procedure SetTotalTransactionPrice(const Value :Double);
    Procedure SetActualShippingCost(const Value :Double);
    Procedure SetActualHandlingCost(const Value :Double);
    Procedure SetRefundAmount(const Value :Double);

    function GetAmountPaidCurCode: String;
    function GetAdjustmentAmountCurCode: String;
    function GetConvertedAdjustmentAmountCurCode: String;
    function GetConvertedAmountPaidCurCode: String;
    function GetConvertedTransactionPriceCurCode: String;
    function GetTransactionPriceCurCode: String;
    function GetDutchAuctionBidCurCode: String;
    function GetTotalPriceCurCode: String;
    function GetFinalValueFeeCurCode: String;
    function GetBuyerGuaranteePriceCurCode: String;
    function GetTotalTransactionPriceCurCode: String;
    function GetActualShippingCostCurCode: String;
    function GetActualHandlingCostCurCode: String;
    function GetRefundAmountCurCode: String;

    Procedure SetAmountPaidCurCode(const Value :String);
    Procedure SetAdjustmentAmountCurCode(const Value :String);
    Procedure SetConvertedAdjustmentAmountCurCode(const Value :String);
    Procedure SetConvertedAmountPaidCurCode(const Value :String);
    Procedure SetConvertedTransactionPriceCurCode(const Value :String);
    Procedure SetTransactionPriceCurCode(const Value :String);
    Procedure SetDutchAuctionBidCurCode(const Value :String);
    Procedure SetTotalPriceCurCode(const Value :String);
    Procedure SetFinalValueFeeCurCode(const Value :String);
    Procedure SetBuyerGuaranteePriceCurCode(const Value :String);
    Procedure SetTotalTransactionPriceCurCode(const Value :String);
    Procedure SetActualShippingCostCurCode(const Value :String);
    Procedure SetActualHandlingCostCurCode(const Value :String);
    Procedure SetRefundAmountCurCode(const Value :String);
    Function getBuyer:Tebay_orders_trans_buyer;
    Function getItem :Tebay_orders_trans_item ;
    function GetTaxes:Tebay_orders_trans_taxes;


  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
    Property Buyer : Tebay_orders_trans_buyer read getBuyer;
    Property Item :Tebay_orders_trans_item Read getItem;
    Property Taxes :Tebay_orders_trans_taxes read getTaxes;
  published
    property OrderID                                      :Integer     read GetOrderID                                    write SetOrderID                                 ;
    property CreatedDate                                  :TDateTime   read GetCreatedDate                                write SetCreatedDate                             ;
    property DepositType                                  :string      read GetDepositType                                write SetDepositType                             ;
    property QuantityPurchased                            :Integer     read GetQuantityPurchased                          write SetQuantityPurchased                       ;
    property TransactionID                                :string      read GetTransactionID                              write SetTransactionID                           ;
    property BestOfferSale                                :Boolean     read GetBestOfferSale                              write SetBestOfferSale                           ;
    property BuyerMessage                                 :string      read GetBuyerMessage                               write SetBuyerMessage                            ;
    property BuyerPaidStatus                              :string      read GetBuyerPaidStatus                            write SetBuyerPaidStatus                         ;
    property SellerPaidStatus                             :string      read GetSellerPaidStatus                           write SetSellerPaidStatus                        ;
    property TransactionSiteID                            :string      read GetTransactionSiteID                          write SetTransactionSiteID                       ;
    property Platform_                                    :string      read GetPlatform_                                  write SetPlatform_                               ;
    property CartID                                       :string      read GetCartID                                     write SetCartID                                  ;
    property SellerContactBuyerByEmail                    :Boolean     read GetSellerContactBuyerByEmail                  write SetSellerContactBuyerByEmail               ;
    property PayPalEmailAddress                           :string      read GetPayPalEmailAddress                         write SetPayPalEmailAddress                      ;
    property PaisaPayID                                   :string      read GetPaisaPayID                                 write SetPaisaPayID                              ;
    property BuyerCheckoutMessage                         :string      read GetBuyerCheckoutMessage                       write SetBuyerCheckoutMessage                    ;
    property BundlePurchase                               :Boolean     read GetBundlePurchase                             write SetBundlePurchase                          ;
    property OrderLineItemID                              :string      read GetOrderLineItemID                            write SetOrderLineItemID                         ;
    property RefundStatus                                 :string      read GetRefundStatus                               write SetRefundStatus                            ;
    property CodiceFiscale                                :string      read GetCodiceFiscale                              write SetCodiceFiscale                           ;
    property IsMultiLegShipping                           :Boolean     read GetIsMultiLegShipping                         write SetIsMultiLegShipping                      ;
    property IntangibleItem                               :Boolean     read GetIntangibleItem                             write SetIntangibleItem                          ;
    Property AmountPaid: double read getAmountPaid Write SetAmountPaid;
    Property AdjustmentAmount: double read getAdjustmentAmount Write SetAdjustmentAmount;
    Property ConvertedAdjustmentAmount: double read getConvertedAdjustmentAmount Write SetConvertedAdjustmentAmount;
    Property ConvertedAmountPaid: double read getConvertedAmountPaid Write SetConvertedAmountPaid;
    Property ConvertedTransactionPrice: double read getConvertedTransactionPrice Write SetConvertedTransactionPrice;
    Property TransactionPrice: double read getTransactionPrice Write SetTransactionPrice;
    Property DutchAuctionBid: double read getDutchAuctionBid Write SetDutchAuctionBid;
    Property TotalPrice: double read getTotalPrice Write SetTotalPrice;
    Property FinalValueFee: double read getFinalValueFee Write SetFinalValueFee;
    Property BuyerGuaranteePrice: double read getBuyerGuaranteePrice Write SetBuyerGuaranteePrice;
    Property TotalTransactionPrice: double read getTotalTransactionPrice Write SetTotalTransactionPrice;
    Property ActualShippingCost: double read getActualShippingCost Write SetActualShippingCost;
    Property ActualHandlingCost: double read getActualHandlingCost Write SetActualHandlingCost;
    Property RefundAmount: double read getRefundAmount Write SetRefundAmount;
    Property AmountPaidCurCode: String read getAmountPaidCurCode Write SetAmountPaidCurCode;
    Property AdjustmentAmountCurCode: String read getAdjustmentAmountCurCode Write SetAdjustmentAmountCurCode;
    Property ConvertedAdjustmentAmountCurCode: String read getConvertedAdjustmentAmountCurCode Write SetConvertedAdjustmentAmountCurCode;
    Property ConvertedAmountPaidCurCode: String read getConvertedAmountPaidCurCode Write SetConvertedAmountPaidCurCode;
    Property ConvertedTransactionPriceCurCode: String read getConvertedTransactionPriceCurCode Write SetConvertedTransactionPriceCurCode;
    Property TransactionPriceCurCode: String read getTransactionPriceCurCode Write SetTransactionPriceCurCode;
    Property DutchAuctionBidCurCode: String read getDutchAuctionBidCurCode Write SetDutchAuctionBidCurCode;
    Property TotalPriceCurCode: String read getTotalPriceCurCode Write SetTotalPriceCurCode;
    Property FinalValueFeeCurCode: String read getFinalValueFeeCurCode Write SetFinalValueFeeCurCode;
    Property BuyerGuaranteePriceCurCode: String read getBuyerGuaranteePriceCurCode Write SetBuyerGuaranteePriceCurCode;
    Property TotalTransactionPriceCurCode: String read getTotalTransactionPriceCurCode Write SetTotalTransactionPriceCurCode;
    Property ActualShippingCostCurCode: String read getActualShippingCostCurCode Write SetActualShippingCostCurCode;
    Property ActualHandlingCostCurCode: String read getActualHandlingCostCurCode Write SetActualHandlingCostCurCode;
    Property RefundAmountCurCode: String read getRefundAmountCurCode Write SetRefundAmountCurCode;



(*
    property ShippingDetails:                   ShippingDetailsType                    Index (IS_OPTN) read GetShippingDetails write SetShippingDetails stored ShippingDetails_Specified;
    property Item:                              ItemType                               Index (IS_OPTN) read GetItem write SetItem stored Item_Specified;
    property QuantityPurchased:                 Integer                                Index (IS_OPTN) read GetQuantityPurchased write SetQuantityPurchased stored QuantityPurchased_Specified;
    property Status:                            TransactionStatusType                  Index (IS_OPTN) read GetStatus write SetStatus stored Status_Specified;
    property TransactionID:                     string                                 Index (IS_OPTN) read GetTransactionID write SetTransactionID stored TransactionID_Specified;
    property VATPercent:                        TXSDecimal                             Index (IS_OPTN) read GetVATPercent write SetVATPercent stored VATPercent_Specified;
    property ExternalTransaction:               Array_Of_ExternalTransactionType       Index (IS_OPTN or IS_UNBD) read GetExternalTransaction write SetExternalTransaction stored ExternalTransaction_Specified;
    property SellingManagerProductDetails:      SellingManagerProductDetailsType       Index (IS_OPTN) read GetSellingManagerProductDetails write SetSellingManagerProductDetails stored SellingManagerProductDetails_Specified;
    property ShippingServiceSelected:           ShippingServiceOptionsType             Index (IS_OPTN) read GetShippingServiceSelected write SetShippingServiceSelected stored ShippingServiceSelected_Specified;
    property BuyerMessage:                      string                                 Index (IS_OPTN) read GetBuyerMessage write SetBuyerMessage stored BuyerMessage_Specified;
    property BuyerPaidStatus:                   PaidStatusCodeType                     Index (IS_OPTN) read GetBuyerPaidStatus write SetBuyerPaidStatus stored BuyerPaidStatus_Specified;
    property SellerPaidStatus:                  PaidStatusCodeType                     Index (IS_OPTN) read GetSellerPaidStatus write SetSellerPaidStatus stored SellerPaidStatus_Specified;
    property PaidTime:                          TXSDateime                            Index (IS_OPTN) read GetPaidTime write SetPaidTime stored PaidTime_Specified;
    property ShippedTime:                       TXSDateTime                            Index (IS_OPTN) read GetShippedTime write SetShippedTime stored ShippedTime_Specified;
    property FeedbackLeft:                      FeedbackInfoType                       Index (IS_OPTN) read GetFeedbackLeft write SetFeedbackLeft stored FeedbackLeft_Specified;
    property FeedbackReceived:                  FeedbackInfoType                       Index (IS_OPTN) read GetFeedbackReceived write SetFeedbackReceived stored FeedbackReceived_Specified;
    property ContainingOrder:                   OrderType                              Index (IS_OPTN) read GetContainingOrder write SetContainingOrder stored ContainingOrder_Specified;
    property ListingCheckoutRedirectPreference: ListingCheckoutRedirectPreferenceType  Index (IS_OPTN) read GetListingCheckoutRedirectPreference write SetListingCheckoutRedirectPreference stored ListingCheckoutRedirectPreference_Specified;
    property RefundArray:                       RefundArrayType                        Index (IS_OPTN) read GetRefundArray write SetRefundArray stored RefundArray_Specified;
    property TransactionSiteID:                 SiteCodeType                           Index (IS_OPTN) read GetTransactionSiteID write SetTransactionSiteID stored TransactionSiteID_Specified;
    property Platform_:                         TransactionPlatformCodeType            Index (IS_OPTN) read GetPlatform_ write SetPlatform_ stored Platform__Specified;
    property CartID:                            string                                 Index (IS_OPTN) read GetCartID write SetCartID stored CartID_Specified;
    property PayPalEmailAddress:                string                                 Index (IS_OPTN) read GetPayPalEmailAddress write SetPayPalEmailAddress stored PayPalEmailAddress_Specified;
    property PaisaPayID:                        string                                 Index (IS_OPTN) read GetPaisaPayID write SetPaisaPayID stored PaisaPayID_Specified;
    property Variation:                         VariationType                          Index (IS_OPTN) read GetVariation write SetVariation stored Variation_Specified;
    property BuyerCheckoutMessage:              string                                 Index (IS_OPTN) read GetBuyerCheckoutMessage write SetBuyerCheckoutMessage stored BuyerCheckoutMessage_Specified;
    property Taxes:                             TaxesType                              Index (IS_OPTN) read GetTaxes write SetTaxes stored Taxes_Specified;
    property OrderLineItemID:                   string                                 Index (IS_OPTN) read GetOrderLineItemID write SetOrderLineItemID stored OrderLineItemID_Specified;
    property PaymentHoldDetails:                PaymentHoldDetailType                  Index (IS_OPTN) read GetPaymentHoldDetails write SetPaymentHoldDetails stored PaymentHoldDetails_Specified;
    property SellerDiscounts:                   SellerDiscountsType                    Index (IS_OPTN) read GetSellerDiscounts write SetSellerDiscounts stored SellerDiscounts_Specified;
    property RefundStatus:                      string                                 Index (IS_OPTN) read GetRefundStatus write SetRefundStatus stored RefundStatus_Specified;
    property CodiceFiscale:                     string                                 Index (IS_OPTN) read GetCodiceFiscale write SetCodiceFiscale stored CodiceFiscale_Specified;
    property MultiLegShippingDetails:           MultiLegShippingDetailsType            Index (IS_OPTN) read GetMultiLegShippingDetails write SetMultiLegShippingDetails stored MultiLegShippingDetails_Specified;
    property InvoiceSentTime:                   TXSDateTime                            Index (IS_OPTN) read GetInvoiceSentTime write SetInvoiceSentTime stored InvoiceSentTime_Specified;
    property UnpaidItem:                        UnpaidItemType                         Index (IS_OPTN) read GetUnpaidItem write SetUnpaidItem stored UnpaidItem_Specified;
    property MonetaryDetails:                   PaymentsInformationType                Index (IS_OPTN) read GetMonetaryDetails write SetMonetaryDetails stored MonetaryDetails_Specified;*)
  end;


implementation


uses sysutils;



  {Tebay_orders_trans}

constructor Tebay_orders_trans.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans';
end;
{Property Functions}
function  Tebay_orders_trans.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans.GetCreatedDate                             : TDateTime ; begin Result := GetFieldValue('CreatedDate');end;
function  Tebay_orders_trans.GetDepositType                             : string    ; begin Result := GetFieldValue('DepositType');end;
function  Tebay_orders_trans.GetQuantityPurchased                       : Integer   ; begin Result := GetFieldValue('QuantityPurchased');end;
function  Tebay_orders_trans.GetTransactionID                           : string    ; begin Result := GetFieldValue('TransactionID');end;
function  Tebay_orders_trans.GetBestOfferSale                           : Boolean   ; begin Result := GetFieldValue('BestOfferSale');end;
function  Tebay_orders_trans.GetBuyerMessage                            : string    ; begin Result := GetFieldValue('BuyerMessage');end;
function  Tebay_orders_trans.GetBuyerPaidStatus                         : string    ; begin Result := GetFieldValue('BuyerPaidStatus');end;
function  Tebay_orders_trans.GetSellerPaidStatus                        : string    ; begin Result := GetFieldValue('SellerPaidStatus');end;
function  Tebay_orders_trans.GetTransactionSiteID                       : string    ; begin Result := GetFieldValue('TransactionSiteID');end;
function  Tebay_orders_trans.GetPlatform_                               : string    ; begin Result := GetFieldValue('Platform_');end;
function  Tebay_orders_trans.GetCartID                                  : string    ; begin Result := GetFieldValue('CartID');end;
function  Tebay_orders_trans.GetSellerContactBuyerByEmail               : Boolean   ; begin Result := GetFieldValue('SellerContactBuyerByEmail');end;
function  Tebay_orders_trans.GetPayPalEmailAddress                      : string    ; begin Result := GetFieldValue('PayPalEmailAddress');end;
function  Tebay_orders_trans.GetPaisaPayID                              : string    ; begin Result := GetFieldValue('PaisaPayID');end;
function  Tebay_orders_trans.GetBuyerCheckoutMessage                    : string    ; begin Result := GetFieldValue('BuyerCheckoutMessage');end;
function  Tebay_orders_trans.GetBundlePurchase                          : Boolean   ; begin Result := GetFieldValue('BundlePurchase');end;
function  Tebay_orders_trans.GetOrderLineItemID                         : string    ; begin Result := GetFieldValue('OrderLineItemID');end;
function  Tebay_orders_trans.GetRefundStatus                            : string    ; begin Result := GetFieldValue('RefundStatus');end;
function  Tebay_orders_trans.GetCodiceFiscale                           : string    ; begin Result := GetFieldValue('CodiceFiscale');end;
function  Tebay_orders_trans.GetIsMultiLegShipping                      : Boolean   ; begin Result := GetFieldValue('IsMultiLegShipping');end;
function  Tebay_orders_trans.GetIntangibleItem                          : Boolean   ; begin Result := GetFieldValue('IntangibleItem');end;
procedure Tebay_orders_trans.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans.SetCreatedDate                             (const Value: TDateTime ); begin SetFieldValue('CreatedDate'                              , Value);end;
procedure Tebay_orders_trans.SetDepositType                             (const Value: string    ); begin SetFieldValue('DepositType'                              , Value);end;
procedure Tebay_orders_trans.SetQuantityPurchased                       (const Value: Integer   ); begin SetFieldValue('QuantityPurchased'                        , Value);end;
procedure Tebay_orders_trans.SetTransactionID                           (const Value: string    ); begin SetFieldValue('TransactionID'                            , Value);end;
procedure Tebay_orders_trans.SetBestOfferSale                           (const Value: Boolean   ); begin SetFieldValue('BestOfferSale'                            , Value);end;
procedure Tebay_orders_trans.SetBuyerMessage                            (const Value: string    ); begin SetFieldValue('BuyerMessage'                             , Value);end;
procedure Tebay_orders_trans.SetBuyerPaidStatus                         (const Value: string    ); begin SetFieldValue('BuyerPaidStatus'                          , Value);end;
procedure Tebay_orders_trans.SetSellerPaidStatus                        (const Value: string    ); begin SetFieldValue('SellerPaidStatus'                         , Value);end;
procedure Tebay_orders_trans.SetTransactionSiteID                       (const Value: string    ); begin SetFieldValue('TransactionSiteID'                        , Value);end;
procedure Tebay_orders_trans.SetPlatform_                               (const Value: string    ); begin SetFieldValue('Platform_'                                , Value);end;
procedure Tebay_orders_trans.SetCartID                                  (const Value: string    ); begin SetFieldValue('CartID'                                   , Value);end;
procedure Tebay_orders_trans.SetSellerContactBuyerByEmail               (const Value: Boolean   ); begin SetFieldValue('SellerContactBuyerByEmail'                , Value);end;
procedure Tebay_orders_trans.SetPayPalEmailAddress                      (const Value: string    ); begin SetFieldValue('PayPalEmailAddress'                       , Value);end;
procedure Tebay_orders_trans.SetPaisaPayID                              (const Value: string    ); begin SetFieldValue('PaisaPayID'                               , Value);end;
procedure Tebay_orders_trans.SetBuyerCheckoutMessage                    (const Value: string    ); begin SetFieldValue('BuyerCheckoutMessage'                     , Value);end;
procedure Tebay_orders_trans.SetBundlePurchase                          (const Value: Boolean   ); begin SetFieldValue('BundlePurchase'                           , Value);end;
procedure Tebay_orders_trans.SetOrderLineItemID                         (const Value: string    ); begin SetFieldValue('OrderLineItemID'                          , Value);end;
procedure Tebay_orders_trans.SetRefundStatus                            (const Value: string    ); begin SetFieldValue('RefundStatus'                             , Value);end;
procedure Tebay_orders_trans.SetCodiceFiscale                           (const Value: string    ); begin SetFieldValue('CodiceFiscale'                            , Value);end;
procedure Tebay_orders_trans.SetIsMultiLegShipping                      (const Value: Boolean   ); begin SetFieldValue('IsMultiLegShipping'                       , Value);end;
procedure Tebay_orders_trans.SetIntangibleItem                          (const Value: Boolean   ); begin SetFieldValue('IntangibleItem'                           , Value);end;

function Tebay_orders_trans.GetAmountPaid: double; begin Result := Getfieldvalue('AmountPaid'); end;
function Tebay_orders_trans.GetAdjustmentAmount: double; begin Result := Getfieldvalue('AdjustmentAmount'); end;
function Tebay_orders_trans.GetConvertedAdjustmentAmount: double; begin Result := Getfieldvalue('ConvertedAdjustmentAmount'); end;
function Tebay_orders_trans.GetConvertedAmountPaid: double; begin Result := Getfieldvalue('ConvertedAmountPaid'); end;
function Tebay_orders_trans.GetConvertedTransactionPrice: double; begin Result := Getfieldvalue('ConvertedTransactionPrice'); end;
function Tebay_orders_trans.GetTransactionPrice: double; begin Result := Getfieldvalue('TransactionPrice'); end;
function Tebay_orders_trans.GetDutchAuctionBid: double; begin Result := Getfieldvalue('DutchAuctionBid'); end;

function Tebay_orders_trans.GetTotalPrice: double; begin Result := Getfieldvalue('TotalPrice'); end;
function Tebay_orders_trans.GetFinalValueFee: double; begin Result := Getfieldvalue('FinalValueFee'); end;
function Tebay_orders_trans.GetBuyerGuaranteePrice: double; begin Result := Getfieldvalue('BuyerGuaranteePrice'); end;
function Tebay_orders_trans.GetTotalTransactionPrice: double; begin Result := Getfieldvalue('TotalTransactionPrice'); end;
function Tebay_orders_trans.GetActualShippingCost: double; begin Result := Getfieldvalue('ActualShippingCost'); end;
function Tebay_orders_trans.GetActualHandlingCost: double; begin Result := Getfieldvalue('ActualHandlingCost'); end;
function Tebay_orders_trans.GetRefundAmount: double; begin Result := Getfieldvalue('RefundAmount'); end;

Procedure Tebay_orders_trans.SetAmountPaid(const Value :Double); begin SetFieldValue('AmountPaid', Value); end;
Procedure Tebay_orders_trans.SetAdjustmentAmount(const Value :Double); begin SetFieldValue('AdjustmentAmount', Value); end;
Procedure Tebay_orders_trans.SetConvertedAdjustmentAmount(const Value :Double); begin SetFieldValue('ConvertedAdjustmentAmount', Value); end;
Procedure Tebay_orders_trans.SetConvertedAmountPaid(const Value :Double); begin SetFieldValue('ConvertedAmountPaid', Value); end;
Procedure Tebay_orders_trans.SetConvertedTransactionPrice(const Value :Double); begin SetFieldValue('ConvertedTransactionPrice', Value); end;
Procedure Tebay_orders_trans.SetTransactionPrice(const Value :Double); begin SetFieldValue('TransactionPrice', Value); end;
Procedure Tebay_orders_trans.SetDutchAuctionBid(const Value :Double); begin SetFieldValue('DutchAuctionBid', Value); end;
Procedure Tebay_orders_trans.SetTotalPrice(const Value :Double); begin SetFieldValue('TotalPrice', Value); end;
Procedure Tebay_orders_trans.SetFinalValueFee(const Value :Double); begin SetFieldValue('FinalValueFee', Value); end;
Procedure Tebay_orders_trans.SetBuyerGuaranteePrice(const Value :Double); begin SetFieldValue('BuyerGuaranteePrice', Value); end;
Procedure Tebay_orders_trans.SetTotalTransactionPrice(const Value :Double); begin SetFieldValue('TotalTransactionPrice', Value); end;
Procedure Tebay_orders_trans.SetActualShippingCost(const Value :Double); begin SetFieldValue('ActualShippingCost', Value); end;
Procedure Tebay_orders_trans.SetActualHandlingCost(const Value :Double); begin SetFieldValue('ActualHandlingCost', Value); end;
Procedure Tebay_orders_trans.SetRefundAmount(const Value :Double); begin SetFieldValue('RefundAmount', Value); end;


function Tebay_orders_trans.GetAmountPaidCurCode: String; begin Result := Getfieldvalue('AmountPaidCurCode'); end;
function Tebay_orders_trans.GetAdjustmentAmountCurCode: String; begin Result := Getfieldvalue('AdjustmentAmountCurCode'); end;
function Tebay_orders_trans.GetConvertedAdjustmentAmountCurCode: String; begin Result := Getfieldvalue('ConvertedAdjustmentAmountCurCode'); end;
function Tebay_orders_trans.GetConvertedAmountPaidCurCode: String; begin Result := Getfieldvalue('ConvertedAmountPaidCurCode'); end;
function Tebay_orders_trans.GetConvertedTransactionPriceCurCode: String; begin Result := Getfieldvalue('ConvertedTransactionPriceCurCode'); end;
function Tebay_orders_trans.GetTransactionPriceCurCode: String; begin Result := Getfieldvalue('TransactionPriceCurCode'); end;
function Tebay_orders_trans.GetDutchAuctionBidCurCode: String; begin Result := Getfieldvalue('DutchAuctionBidCurCode'); end;
function Tebay_orders_trans.GetTotalPriceCurCode: String; begin Result := Getfieldvalue('TotalPriceCurCode'); end;
function Tebay_orders_trans.GetFinalValueFeeCurCode: String; begin Result := Getfieldvalue('FinalValueFeeCurCode'); end;
function Tebay_orders_trans.GetBuyerGuaranteePriceCurCode: String; begin Result := Getfieldvalue('BuyerGuaranteePriceCurCode'); end;
function Tebay_orders_trans.GetTotalTransactionPriceCurCode: String; begin Result := Getfieldvalue('TotalTransactionPriceCurCode'); end;
function Tebay_orders_trans.GetActualShippingCostCurCode: String; begin Result := Getfieldvalue('ActualShippingCostCurCode'); end;
function Tebay_orders_trans.GetActualHandlingCostCurCode: String; begin Result := Getfieldvalue('ActualHandlingCostCurCode'); end;
function Tebay_orders_trans.GetRefundAmountCurCode: String; begin Result := Getfieldvalue('RefundAmountCurCode'); end;
Procedure Tebay_orders_trans.SetAmountPaidCurCode(const Value :String); begin SetFieldValue('AmountPaidCurCode', Value); end;
Procedure Tebay_orders_trans.SetAdjustmentAmountCurCode(const Value :String); begin SetFieldValue('AdjustmentAmountCurCode', Value); end;
Procedure Tebay_orders_trans.SetConvertedAdjustmentAmountCurCode(const Value :String); begin SetFieldValue('ConvertedAdjustmentAmountCurCode', Value); end;
Procedure Tebay_orders_trans.SetConvertedAmountPaidCurCode(const Value :String); begin SetFieldValue('ConvertedAmountPaidCurCode', Value); end;
Procedure Tebay_orders_trans.SetConvertedTransactionPriceCurCode(const Value :String); begin SetFieldValue('ConvertedTransactionPriceCurCode', Value); end;
Procedure Tebay_orders_trans.SetTransactionPriceCurCode(const Value :String); begin SetFieldValue('TransactionPriceCurCode', Value); end;
Procedure Tebay_orders_trans.SetDutchAuctionBidCurCode(const Value :String); begin SetFieldValue('DutchAuctionBidCurCode', Value); end;
Procedure Tebay_orders_trans.SetTotalPriceCurCode(const Value :String); begin SetFieldValue('TotalPriceCurCode', Value); end;
Procedure Tebay_orders_trans.SetFinalValueFeeCurCode(const Value :String); begin SetFieldValue('FinalValueFeeCurCode', Value); end;
Procedure Tebay_orders_trans.SetBuyerGuaranteePriceCurCode(const Value :String); begin SetFieldValue('BuyerGuaranteePriceCurCode', Value); end;
Procedure Tebay_orders_trans.SetTotalTransactionPriceCurCode(const Value :String); begin SetFieldValue('TotalTransactionPriceCurCode', Value); end;
Procedure Tebay_orders_trans.SetActualShippingCostCurCode(const Value :String); begin SetFieldValue('ActualShippingCostCurCode', Value); end;
Procedure Tebay_orders_trans.SetActualHandlingCostCurCode(const Value :String); begin SetFieldValue('ActualHandlingCostCurCode', Value); end;
Procedure Tebay_orders_trans.SetRefundAmountCurCode(const Value :String); begin SetFieldValue('RefundAmountCurCode', Value); end;

function Tebay_orders_trans.getBuyer: Tebay_orders_trans_buyer;
begin
  if (fBuyer = nil) then begin
    fBuyer:= Tebay_orders_trans_buyer.Create(self, 'tblebay_orders_trans_buyer', 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(ID));
  end;
  fBuyer.SQLWhere := 'OrderId  =' + inttostr(orderID)+ ' and Orders_Trans_Id =' + inttostr(ID);
  fBuyer.Dataset;
  result:= fBuyer;
end;
function Tebay_orders_trans.getitem: Tebay_orders_trans_item;
begin
  if (fItem = nil) then begin
    fItem:= Tebay_orders_trans_item.Create(self, 'tblebay_orders_trans_item', 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(ID));
  end;
  fItem.SQLWhere := 'OrderId  =' + inttostr(orderID)+ ' and Orders_Trans_Id =' + inttostr(ID);
  fItem.Dataset;
  result:= fItem;
end;
function Tebay_orders_trans.GetTaxes: Tebay_orders_trans_taxes;
begin
  if (fTaxes = nil) then begin
    fTaxes:= Tebay_orders_trans_taxes.Create(self, 'tblebay_orders_trans_taxes', 'OrderId =' + inttostr(OrderID) + ' and Orders_Trans_Id =' + inttostr(ID));
  end;
  fTaxes.SQLWhere := 'OrderId  =' + inttostr(orderID)+ ' and Orders_Trans_Id =' + inttostr(ID);
  fTaxes.Dataset;
  result:= fTaxes;
end;

initialization
  RegisterClass(Tebay_orders_trans);


end.
