Unit eBayLib;

Interface

Uses Typinfo, Classes, Ebaysvc, XSBuiltIns, XMLdoc, XmlIntf;

Procedure ListComponentProperties(Component: TObject; Strings: TStrings);
Procedure ShowOrder(Component: GetOrdersResponse; Strings: TStrings);
Function BooleantoStr(Const Value: Boolean): String;
Function ToBeUpdatedSalesShipment(NL:String):String;
Procedure AsXML(Component: GetOrdersResponse; Var FXMLDoc: TXMLDocument);

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ShipmentLineItemType                               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: EBayPaymentMismatchDetailsType                     );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CheckoutStatusType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CalculatedShippingRateType                         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ShippingDetailsType                                );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: FeatureEligibilityType                             );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RecoupmentPolicyConsentType                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ExtendedContactDetailsType                         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ContactHoursDetailsType                            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundArrayType                                    );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundLineType                                     );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundFundingSourceType                            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentInformationType                             );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MultiLegShippingServiceType                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ItemCompatibilityType                     );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: NameValueListArrayType                             );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ListingDetailsType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_anyURI                                    );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PictureDetailsType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentDetailsType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: LookupAttributeType                                );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: LookupAttributeArrayType                           );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ListingDesignerType                                );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ListingCheckoutRedirectPreferenceType              );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemPolicyViolationType                            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: NameValueListType                                  );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemCompatibilityType                              );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemCompatibilityListType                          );  Overload;
//Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ExternalProductIDType                              );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RequiredSellerActionArrayType                      );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MultiLegShipmentType                               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TransactionReferenceType                           );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: UserIdentityType                                   );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentTransactionType                             );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundFundingSourceArrayType                       );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundFailureReasonType                            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundLineArrayType                                );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundTransactionArrayType                         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentsInformationType                            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AddressType                                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AmountType                                         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_BuyerPaymentMethodCodeType                );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_CharacteristicsSetType                    );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_CharacteristicType                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_DiscountProfileType                       );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_EBaySubscriptionTypeCodeType              );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ExtendedProductFinderIDType               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ExternalTransactionType                   );  Overload;
//Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_GiftServicesCodeType                      );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_InternationalShippingServiceOptionsType   );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ItemBidDetailsType                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ListingEnhancementsCodeType               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_PromotedItemType                          );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_PromotionDetailsType                      );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ShipmentTrackingDetailsType               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ShippingServiceOptionsType                );  Overload;
//Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_SkypeContactOptionCodeType                );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_UserAgreementInfoType                     );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ValType                                   );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AttributeArrayType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AttributeSetArrayType                              );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BestOfferDetailsType                               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BiddingDetailsType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BiddingSummaryType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BusinessSellerDetailsType                          );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BuyerProtectionDetailsType                         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BuyerRequirementDetailsType                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BuyerType                                          );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CalculatedShippingDiscountType                     );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CategoryType                                       );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CharityAffiliationDetailsType                      );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CharityAffiliationsType                            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CharityType                                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CrossPromotionsType                                );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: DiscountPriceInfoType                              );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: DistanceType                                       );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: FlatShippingDiscountType                           );  Overload;
//Procedure AddNode(Node: IXMLNode; Nodename: String; Value: InsuranceDetailsType                               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: IntegratedMerchantCreditCardInfoType               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemType                                           );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: LabelType                                          );  Overload;
//Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MaximumBuyerPolicyViolationsType                   );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MaximumItemRequirementsType                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MaximumUnpaidItemStrikesInfoType                   );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MeasureType                                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MultiLegShippingDetailsType                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentHoldDetailType                              );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PromotionalShippingDiscountDetailsType             );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ProStoresCheckoutPreferenceType                    );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ProStoresDetailsType                               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RateTableDetailsType                               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SalesTaxType                                       );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SchedulingInfoType                                 );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SellereBayPaymentProcessConsentCodeType            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SellerExcludeShipToLocationPreferencesType         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SellerType                                         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ShippingServiceOptionsType                         );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TaxTableType                                       );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TDatetime                                          );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TopRatedSellerDetailsType                          );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TransactionArrayType                               );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TXSDateTime                                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TXSDuration                                        );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TXSTime                                            );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: UserType                                           );  Overload;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: VATDetailsType                                     );  Overload;
//Procedure AddNode(Node: IXMLNode; Nodename: String; Value: VerifiedUserRequirementsType                       );  Overload;

function AddNode(Node:IXMLNode; Nodename   :String; Value: String=''):IXMLNode; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SMSSubscriptionUserStatusCodeType              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerShippedStatusCodeType            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerSearchTypeCodeType               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerPaidStatusCodeType               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CheckoutStatusCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:WirelessCarrierIDCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RequiredSellerActionCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SMSSubscriptionErrorCodeCodeType               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UnpaidItemStatusTypeCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingRateTypeCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingTypeCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingCarrierCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingServiceCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShipmentDeliveryStatusCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShipmentStatusCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingFeatureCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MerchandizingPrefCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerGuaranteeLevelCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayoutMethodType                               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellereBayPaymentProcessStatusCodeType         ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentTypeCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FedExRateOptionCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:USPSRateOptionCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UPSRateOptionCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisplayPayNowButtonCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreItemListSortOrderCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SearchStandingStatusCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutoRelistOptionCodeType         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutoRelistTypeCodeType           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerAccountStatusCodeType                    ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RangeCodeType                                  ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DateSpecifierCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerEmailSentStatusCodeType          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutoSecondChanceOfferTypeCodeType): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerEmailTypeCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutomationPropertyTypeCodeType   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerPaisaPayPropertyTypeCodeType     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAlertTypeCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerGeneralPropertyTypeCodeType      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerDashboardAlertSeverityCodeType           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DayOfWeekCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingRegionCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EBaySubscriptionTypeCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VeROItemStatusCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MismatchTypeCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayPalAccountStatusCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreSubscriptionLevelCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreFontSizeCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MerchDisplayCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomHeaderLayoutCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreHeaderStyleCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreItemListLayoutCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreFontFaceCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureFormatCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomListingHeaderDisplayCodeType        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomPageStatusCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomListingHeaderLinkCodeType           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SummaryWindowPeriodCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UnpaidItemCaseOpenTypeCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UserIdentityCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UnpaidItemCaseStatusTypeCodeType               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:URLTypeCodeType                                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackRatingStarCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayPalAccountLevelCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayPalAccountTypeCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BusinessRoleType                               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UserStatusCodeType                             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VATStatusCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TaxTypeCodeType                                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TaxDescriptionCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SummaryFrequencyCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaidStatusCodeType                             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TransactionReferenceCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TokenStatusCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TopRatedProgramCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ReasonHideFromSearchCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BoldTitleCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BorderCodeType                                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HighlightCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerBusinessCodeType                         ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SkypeContactOptionCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:QuantityAvailableHintCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingSubtypeCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GiftIconCodeType                               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PeriodCodeType                                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:QuestionTypeCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProPackCodeType                                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HomePageFeaturedCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeaturedFirstCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeaturedPlusCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MarkUpMarkDownEventTypeCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FlatRateInsuranceRangeCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FlatShippingRateOptionCodeType                 ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingFlowCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:OrderStatusFilterCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingEnhancementsCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DescriptionReviseModeCodeType                  ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GiftServicesCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HitCounterCodeType                             ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RecommendationEngineCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SiteCodeType                                   ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CharacteristicsSearchCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionItemSelectionCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionItemPriceTypeCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerLevelCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GalleryStatusCodeType                          ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerSubscriptionLevelCodeType        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GalleryTypeCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PhotoDisplayCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureSourceCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PolicyComplianceStatusCodeType                 ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerPictureDisplayTypeCodeType       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundingSourceTypeCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundFailureCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundStatusCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StatusCodeType                                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundLineTypeCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ValueTypeCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DiscountCodeType                               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionalSaleTypeCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ValueFormatCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SelectionModeCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VariationPictureRuleCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VariationSpecificsRuleCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentMethodSearchCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PreferredLocationCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemConditionCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SimpleItemSortCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemTypeCodeType                               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SearchFlagCodeType                             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSpecificSourceCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:QuantityOperatorCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MyMessagesAlertResolutionStatusCode            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DepositTypeCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentHoldStatusCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PerformanceStatusCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentHoldReasonCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationEventStateCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationEventPropertyNameCodeType          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressTypeCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationEventTypeCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BidActionCodeType                              ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProductUseCaseCodeType                         ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerDetailLevelCodeType              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RCSPaymentStatusCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionalSaleStatusCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MessageTypeCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:OrderStatusCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SortOrderCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationRoleCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeFilterTypeCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeSortTypeCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VeROReportPacketStatusCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerSoldListingsPropertyTypeCodeType ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerSoldListingsSortTypeCodeType     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InventoryTrackingMethodCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerProductSortCodeType              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerInventoryPropertyTypeCodeType    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CombinedPaymentPeriodCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TaskStatusCodeType                             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingTypeCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RecipientRelationCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EndReasonCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DiscountReasonCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeReasonCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeExplanationCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeActivityCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SecondChanceOfferDurationCodeType              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TradingRoleCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionMethodCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StringMatchCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CountryCodeType                                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TransactionPlatformCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSortTypeCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CommentTypeCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackTypeCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingStatusCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GetAllBiddersModeCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CurrencyCodeType                               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountHistorySelectionCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountEntrySortTypeCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MessageStatusTypeCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeatureIDCodeType                              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GranularityLevelCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BestOfferStatusCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProductCreationEnabledCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentOptionsGroupEnabledCodeType             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProfileCategoryGroupCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CharityAffiliationTypeCodeType                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ClassifiedAdBestOfferEnabledCodeType           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSpecificsEnabledCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AdFormatEnabledCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ClassifiedAdPaymentMethodEnabledCodeType       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GeographicExposureCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemCompatibilityEnabledCodeType               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ConditionEnabledCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:INEscrowWorkflowTimelineCodeType               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AttributeConversionEnabledCodeType             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CombinedPaymentOptionCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SocialAddressTypeCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CharityStatusCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentStatusCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BestOfferTypeCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BidGroupItemStatusCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BidGroupStatusCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackRatingDetailCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackSummaryPeriodCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HandlingNameCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DiscountNameCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerSatisfactionStatusCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingPackageCodeType                        ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProductStateCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CalculatedShippingChargeOptionCodeType         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CalculatedShippingRateOptionCodeType           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerProtectionSourceCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerProtectionCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PricingTreatmentCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeRecordTypeCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeStateCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DescriptionTemplateCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MinimumAdvertisedPriceExposureCodeType         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeStatusCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EndOfAuctionLogoTypeCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeCreditEligibilityCodeType               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DaysCodeType                                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionSchemeCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemFormatSortFilterCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GallerySortFilterCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSortFilterCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentTransactionStatusCodeType               ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ExternalProductCodeType                        ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MyMessagesFolderOperationCodeType              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackResponseCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerPaymentMethodCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InsuranceSelectedCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CompleteStatusCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CheckoutMethodCodeType                         ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InsuranceOptionCodeType                        ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerActionCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeResolutionReasonCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DetailNameCodeType                             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BestOfferActionCodeType                        ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundReasonCodeType                           ): String; Overload;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundTypeCodeType                             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeMessageSourceCodeType                   ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SeverityCodeType                               ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ErrorClassificationCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeResolutionRecordTypeCodeType            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InvocationStatusType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DetailLevelCodeType                            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AckCodeType                                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ErrorHandlingCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:WarningLevelCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AnnouncementMessageCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccessRuleCurrentStatusCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccessRuleStatusCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressUsageCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ApplicationDeviceTypeCodeType                  ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EnableCodeType                                 ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationPayloadTypeCodeType                ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DeviceTypeCodeType                             ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountDetailEntryCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountStateCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MeasurementSystemCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerPaymentMethodCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressOwnerCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressStatusCodeType                          ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressRecordTypeCodeType                      ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AdFormatLeadStatusCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCategoryUpdateActionCodeType              ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ModifyActionCodeType                           ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AutomatedLeaveFeedbackEventCodeType            ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SetUserNotesActionCodeType                     ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureUploadPolicyCodeType                    ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureWatermarkCodeType                       ): String; Overload;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureSetCodeType                             ): String; Overload;
Function AsString(Const Prefix: String; Value: AmountType                                       ): String; Overload;
Function AsString(Const Prefix: String; Value: MeasureType                                      ): String; Overload;
Function AsString(Const Prefix: String; Value: TXSDateTime                                      ): String; Overload;
Function AsString(Const Prefix: String; Value: SalesTaxType                                     ): String; Overload;
Function AsString(Const Prefix: String; Value: Array_Of_ShippingServiceOptionsType              ): String; Overload;
Function AsString(Const Prefix: String; Value: Array_Of_InternationalShippingServiceOptionsType ): String; Overload;
Function AsString(Const Prefix: String; Value: TaxTableType                                     ): String; Overload;
//Function AsString(Const Prefix: String; Value: InsuranceDetailsType                             ): String; Overload;
Function AsString(Const Prefix: String; Value: FlatShippingDiscountType                         ): String; Overload;
Function AsString(Const Prefix: String; Value: Array_Of_DiscountProfileType                     ): String; Overload;
Function AsString(Const Prefix: String; Value: CalculatedShippingDiscountType                   ): String; Overload;
Function AsString(Const Prefix: String; Value: PromotionalShippingDiscountDetailsType           ): String; Overload;
Function AsString(Const Prefix: String; Value: SellerExcludeShipToLocationPreferencesType       ): String; Overload;
Function AsString(Const Prefix: String; Value: RateTableDetailsType                             ): String; Overload;
Function AsString(Const Prefix: String; Value: Array_Of_ShipmentTrackingDetailsType             ): String; Overload;
Function AsString(Const Prefix: String; Value: ShipmentLineItemType                             ): String; Overload;

Implementation

Uses Variants, Sysutils, eBaysvcLib;


function  AddNode(Node: IXMLNode; Nodename: String; Value: String=''):IXMLNode;
begin
  result:= node.addchild(nodename);
  result.nodevalue := Value;
end;
Function AsString(Const Prefix: String; Value: ShipmentLineItemType): String; Overload;
Var
  Ctr: Integer;
Begin
  Result := '';
  If High(Value) < 0 Then Exit;
  For Ctr  := Low(Value) To High(Value) Do Begin
    Result := Result + Chr(13) + Prefix + ' -Quantity -' + Inttostr(Value[Ctr].Quantity) + Chr(13) + Prefix + ' -CountryOfOrigin - ' + Value[Ctr].CountryOfOrigin + Chr(13) + Prefix +
      ' -Description - ' + Value[Ctr].Description + Chr(13) + Prefix + ' -ItemID - ' + Value[Ctr].ItemID + Chr(13) + Prefix + ' -TransactionID - ' + Value[Ctr].TransactionID;
  End;
End;

Function AsString(Const Prefix: String; Value: Array_Of_ShipmentTrackingDetailsType): String;
Var
  Ctr: Integer;
Begin
  Result := '';
  If High(Value) < 0 Then Exit;
  For Ctr  := Low(Value) To High(Value) Do Begin
    Result := Result + Chr(13) + Prefix + ' -ShippingCarrierUsed -' + Value[Ctr].ShippingCarrierUsed + Chr(13) + Prefix + ' -ShipmentTrackingNumber - ' + Value[Ctr].ShipmentTrackingNumber + Chr(13) +
      AsString(Prefix + ' - ShipmentLineItem - ', Value[Ctr].ShipmentLineItem);
  End;
End;

Function AsString(Const Prefix: String; Value: RateTableDetailsType): String;
Begin
  Result := Result + Chr(13) + Prefix + ' -ShippingCarrierUsed -' + Value.DomesticRateTable + Chr(13) + Prefix + ' -ShipmentTrackingNumber - ' + Value.InternationalRateTable;
End;

Function AsString(Const Prefix: String; Value: SellerExcludeShipToLocationPreferencesType): String; Overload;
Var
  Ctr: Integer;
Begin
  Result := '';
  If High(Value) < 0 Then Exit;
  For Ctr  := Low(Value) To High(Value) Do Begin
    Result := Result + Chr(13) + Prefix + ' - DiscountProfileID - ' + Value[Ctr];
  End;
End;

Function AsString(Const Prefix: String; Value: FlatShippingDiscountType): String;
Begin
  Result := Prefix + ' - DiscountName:' + enumtostr(Value.DiscountName) + Chr(13) + AsString(Prefix + ' - DiscountProfile ', Value.DiscountProfile);
End;

(*Function AsString(Const Prefix: String; Value: InsuranceDetailsType): String;
Begin

  Result := AsString(Prefix + ' - InsuranceFee:', Value.InsuranceFee) + Chr(13) + Prefix + ' - InsuranceOption ' + enumtostr(Value.InsuranceOption);
End;
*)
Function AsString(Const Prefix: String; Value: CalculatedShippingDiscountType): String; Overload;
Begin
  Result := Result + Chr(13) + Prefix + ' - DiscountName - ' + enumtostr(Value.DiscountName) + Chr(13) + AsString(Prefix + '- DiscountProfile -', Value.DiscountProfile);
End;

Function AsString(Const Prefix: String; Value: PromotionalShippingDiscountDetailsType): String;
Begin
  Result := Result + Chr(13) + Prefix + ' - DiscountName - ' + enumtostr(Value.DiscountName) + Chr(13) + AsString(Prefix + ' - ShippingCost - ', Value.ShippingCost) + Chr(13) +
    AsString(Prefix + ' - OrderAmount - ', Value.OrderAmount) + Chr(13) + Prefix + ' - ItemCount - ' + Inttostr(Value.ItemCount);
End;

Function AsString(Const Prefix: String; Value: Array_Of_DiscountProfileType): String;
Var
  Ctr: Integer;
Begin
  Result := '';
  If High(Value) < 0 Then Exit;
  For Ctr  := Low(Value) To High(Value) Do Begin
    Result := Result + Chr(13) + Prefix + ' - DiscountProfileID - ' + Value[Ctr].DiscountProfileID + Chr(13) + Prefix + ' - DiscountProfileName:   ' + Value[Ctr].DiscountProfileName + Chr(13) +
      AsString(Prefix + ' -EachAdditionalAmount -', Value[Ctr].EachAdditionalAmount) + Chr(13) + AsString(Prefix + ' -EachAdditionalAmountOff - ', Value[Ctr].EachAdditionalAmountOff) + Chr(13) +
      Prefix + ' - EachAdditionalPercentOff - ' + FloatTostr(Value[Ctr].EachAdditionalPercentOff) + Chr(13) + AsString(Prefix + ' - WeightOff - ', Value[Ctr].WeightOff) + Chr(13) + Prefix +
      ' - MappedDiscountProfileID - ' + Value[Ctr].MappedDiscountProfileID;
  End;
End;

Function AsString(Const Prefix: String; Value: TaxTableType): String;
Var
  Ctr: Integer;
Begin
  Result := '';
  If High(Value) < 0 Then Exit;
  For Ctr := Low(Value) To High(Value) Do Begin

    Result := Result + Chr(13) + Prefix + ' - JurisdictionID ' + Value[Ctr].JurisdictionID + Chr(13) + Prefix + '-ShippingService -' + FloatTostr(Value[Ctr].SalesTaxPercent) + Chr(13) + Prefix +
      '-ShippingIncludedInTax -' + BooleantoStr(Value[Ctr].ShippingIncludedInTax) + Chr(13) + Prefix + ' - JurisdictionName ' + Value[Ctr].JurisdictionName + Chr(13) + Prefix + ' - DetailVersion ' +
      Value[Ctr].DetailVersion + Chr(13) + AsString(Prefix + ' - UpdateTime ', Value[Ctr].UpdateTime);
  End;
End;

Function AsString(Const Prefix: String; Value: Array_Of_InternationalShippingServiceOptionsType): String;
Var
  Ctr, I: Integer;
Begin
  Result := '';
  If High(Value) < 0 Then Exit;
  For Ctr := Low(Value) To High(Value) Do Begin

    Result := Result + Chr(13) + Prefix + '-ShippingService -' + Value[Ctr].ShippingService + Chr(13) + AsString(Prefix + ' - ShippingServiceCost:', Value[Ctr].ShippingServiceCost) + Chr(13) +
      AsString(Prefix + ' - ShippingServiceAdditionalCost:', Value[Ctr].ShippingServiceAdditionalCost) + Chr(13) + Prefix + ' - ShippingServicePriority:' +
      Inttostr(Value[Ctr].ShippingServicePriority);
    If High(Value[Ctr].ShipToLocation) >= 0 Then
      For I := Low(Value[Ctr].ShipToLocation) To High(Value[Ctr].ShipToLocation) Do Result := Result + Prefix + ' - ShipToLocation.shiplocation :' + Value[Ctr].ShipToLocation[I];
    Result  := Result + AsString(Prefix + ' - ShippingInsuranceCost:', Value[Ctr].ShippingInsuranceCost) + Chr(13) + AsString(Prefix + ' - ImportCharge:', Value[Ctr].ImportCharge);
  End;
End;

Function AsString(Const Prefix: String; Value: Array_Of_ShippingServiceOptionsType): String;
Var
  Ctr: Integer;
Begin
  Result := '';
  If High(Value) < 0 Then Exit;
  For Ctr  := Low(Value) To High(Value) Do Begin
    Result := Result + Chr(13) +
                AsString(Prefix + '.ShippingInsuranceCost - ', Value[Ctr].ShippingInsuranceCost) + Chr(13) +
                Value[Ctr].ShippingService + Chr(13) +
                AsString(Prefix + ' - ShippingServiceCost:', Value[Ctr].ShippingServiceCost) + Chr(13) +
                AsString(Prefix + ' - ShippingServiceAdditionalCost:', Value[Ctr].ShippingServiceAdditionalCost) + Chr(13) +
                Prefix + '.ShippingServicePriority - ' + Inttostr(Value[Ctr].ShippingServicePriority) + Chr(13) +
                Prefix + '.ExpeditedService - ' + BooleantoStr(Value[Ctr].ExpeditedService) + Chr(13)+
                Prefix + '.ShippingTimeMin - ' + Inttostr(Value[Ctr].ShippingTimeMin) + Chr(13) +
                Prefix + '.ShippingTimeMax - ' + Inttostr(Value[Ctr].ShippingTimeMax) + Chr(13) +
                //AsString(Prefix + ' - ShippingSurcharge:', Value[Ctr].ShippingSurcharge) + Chr(13) +
                Prefix + '.FreeShipping - ' + BooleantoStr(Value[Ctr].FreeShipping) + Chr(13) +
                Prefix + '.LocalPickup - ' + BooleantoStr(Value[Ctr].LocalPickup) + Chr(13) +
                AsString(Prefix + ' - ImportCharge:', Value[Ctr].ImportCharge) + Chr(13);
  End;
End;

Function AsString(Const Prefix: String; Value: SalesTaxType): String;
Begin
  Result := Prefix + FloatTostr(Value.SalesTaxPercent) + Chr(13) + Prefix + Value.SalesTaxState + Chr(13) + Prefix + BooleantoStr(Value.ShippingIncludedInTax) +
    AsString(Prefix + '.SalesTaxAmount - ', Value.SalesTaxAmount);
End;

Function AsString(Const Prefix: String; Value: TXSDateTime): String; Overload;
Begin
  Result := Prefix + FormatDateTime('dd-mm-yyyy hh:nn:ss', Value.AsDatetime);
End;

Function AsString(Const Prefix: String; Value: MeasureType): String; Overload;
Begin
  Result := Prefix + Value.Text.DecimalString + Chr(13) + Prefix + Value.Unit_ + Chr(13) + Prefix + enumtostr(Value.MeasurementSystem);
End;

Function AsString(Const Prefix: String; Value: AmountType): String;
Begin
  Result := Prefix + FloatTostr(Value.Text) + Chr(13) + Prefix + enumtostr(Value.CurrencyID);
End;

Function BooleantoStr(Const Value: Boolean): String;
Begin
  If Value Then Result := 'T'
  Else Result:= 'F';
End;

Procedure AsXML(Component: GetOrdersResponse; Var FXMLDoc: TXMLDocument);
Var
  Node, Rootnode, Xnode: IXMLNode;
  Ctr                  : Integer;
Begin
  If Not Assigned(FXMLDoc) Then Begin
    FXMLDoc := TXMLDocument.Create(Nil);
  End Else Begin
    FXMLDoc.XML.Clear;
  End;
  FXMLDoc.Active := True;
  FXMLDoc.Version:= '1.0';
  FXMLDoc.Encoding    := 'UTF-8';
  Rootnode  := FXMLDoc.AddChild('eBayOrdersResponseXML');
  addnode(rootnode , 'HasMoreOrders' , Booleantostr(Component.HasMoreOrders));
  If High(Component.OrderArray) < 0 Then Exit;
  Node    := addnode(rootnode , 'Orders' , '');
  For Ctr := Low(Component.OrderArray) To High(Component.OrderArray) Do Begin
    With Component.OrderArray[Ctr] Do Begin
      Try
        Xnode:= Addnode(node , 'Order');
        addnode(xnode , 'ID',OrderID);
        addnode(xnode , 'OrderStatus' , OrderStatus);
        AddNode(Xnode, 'AdjustmentAmount', AdjustmentAmount);
        AddNode(Xnode, 'Amountpaid', AmountPaid);
        AddNode(Xnode, 'AmountSaved', AmountSaved);
        AddNode(Xnode, 'CheckStatus', CheckoutStatus);
        AddNode(Xnode, 'ShippingDetails', ShippingDetails);
        addnode(xnode , 'OrderStatus' , CreatingUserRole);
        AddNode(Xnode, 'CreatedTime', CreatedTime);
        AddNode(Xnode, 'PaymentMethods', PaymentMethods);
        addnode(xnode , 'SellerEmail' , SellerEmail);
        AddNode(Xnode, 'ShippingAddress', ShippingAddress);
        AddNode(Xnode, 'ShippingServiceSelected', ShippingServiceSelected);
        AddNode(Node, 'Subtotal', Subtotal);
        AddNode(Node, 'Total', Total);
        AddNode(Node, 'ExternalTransaction', ExternalTransaction);
        AddNode(Node, 'TransactionArray', TransactionArray);
        addnode(xnode , 'BuyerUserID' , BuyerUserID);
        Addnode(node , 'PaidTime' , PaidTime);
        Addnode(node , 'ShippedTime' , ShippedTime);
        addnode(xnode , 'IntegratedMerchantCreditCardEnabled' , booleantoStr(IntegratedMerchantCreditCardEnabled));
        addnode(xnode , 'BundlePurchase' , booleantoStr(BundlePurchase));
        addnode(xnode , 'BuyerCheckoutMessage' , BuyerCheckoutMessage);
        addnode(xnode , 'EIASToken' , EIASToken);
        addnode(xnode , 'PaymentHoldStatus' , PaymentHoldStatus);
        Addnode(node , 'PaymentHoldDetails' , PaymentHoldDetails);
        Addnode(node , 'RefundArray', RefundArray);
        Addnode(node , 'RefundAmount', RefundAmount);
        addnode(xnode , 'RefundStatus' , RefundStatus);
        addnode(xnode , 'IsMultiLegShipping' , booleantoStr(IsMultiLegShipping));
        Addnode(node , 'MultiLegShippingDetails',MultiLegShippingDetails);
        Addnode(node , 'MonetaryDetails',MonetaryDetails);


      Except
        On E: Exception Do Begin
          Addnode(node , 'Exception' , E.Message);
        End;
      End;
    End;
  End;
End;

Procedure ShowOrder(Component: GetOrdersResponse; Strings: TStrings);
Var
  Ctr: Integer;
  S  : String;
Begin
  If High(Component.OrderArray) < 0 Then Exit;
  For Ctr := Low(Component.OrderArray) To High(Component.OrderArray) Do Begin
    With Component.OrderArray[Ctr] Do Begin
      S := 'Order --- : ';
      Strings.Add(S + 'ID - ' + OrderID);
      Strings.Add(S + 'Orderstatus -' + enumtostr(OrderStatus));
      Strings.Add(S + 'AdjustmentAmount -' + FloatTostr(AdjustmentAmount.Text));
      Strings.Add(S + 'AdjustmentAmount -' + enumtostr(AdjustmentAmount.CurrencyID));

      Strings.Add(AsString(S + 'AmountPaid -', AmountPaid));
      Strings.Add(AsString(S + 'AmountSaved -', AmountSaved));

      With CheckoutStatus Do Begin
        S := S + 'checkoutstatus.';
        Strings.Add(S + 'ebaypaymentstatus -' + enumtostr(EBayPaymentStatus));
        Strings.Add(AsString(S + 'LastModifiedTime -', LastModifiedTime));

        Strings.Add(S + 'PaymentMethod -' + enumtostr(PaymentMethod));
        Strings.Add(S + 'PaymentMethod -' + enumtostr(Status));
        Strings.Add(S + 'PaymentMethod -' + BooleantoStr(IntegratedMerchantCreditCardEnabled));
        Strings.Add(S + 'Paymismatch.type -' + enumtostr(EBayPaymentMismatchDetails.MismatchType));
        Strings.Add(AsString(S + 'Paymismatch.Date -', EBayPaymentMismatchDetails.ActionRequiredBy));
        Strings.Add(AsString(S + 'Paymismatch.Date -', EBayPaymentMismatchDetails.ActionRequiredBy));
        Strings.Add(AsString(S + 'Paymismatch.Amount -', EBayPaymentMismatchDetails.MismatchAmount));
      End;

      With ShippingDetails Do Begin
        S := 'Order --- : ShippingDetails.';
        Strings.Add(S + 'AllowPaymentEdit -' + BooleantoStr(AllowPaymentEdit));
        Strings.Add(S + 'ApplyShippingDiscount -' + BooleantoStr(ApplyShippingDiscount));
        Strings.Add(S + 'GlobalShipping -' + BooleantoStr(GlobalShipping));
        With CalculatedShippingRate Do Begin
          Strings.Add(S + 'CalculatedShippingRate.OriginatingPostalCode -' + OriginatingPostalCode);
          Strings.Add(S + 'CalculatedShippingRate.MeasurementUnit -' + enumtostr(MeasurementUnit));
          //Strings.Add(AsString(S + 'CalculatedShippingRate.PackageDepth -', PackageDepth));
          //Strings.Add(AsString(S + 'CalculatedShippingRate.PackageLength -', PackageLength));
          //Strings.Add(AsString(S + 'CalculatedShippingRate.PackageWidth -', PackageWidth));
          Strings.Add(AsString(S + 'PackagingHandlingCosts -', PackagingHandlingCosts));
          Strings.Add(S + 'CalculatedShippingRate.ShippingIrregular -' + BooleantoStr(ShippingIrregular));
          //Strings.Add(S + 'CalculatedShippingRate.ShippingPackage -' + enumtostr(ShippingPackage));
          //Strings.Add(AsString(S + 'CalculatedShippingRate.WeightMajor -', WeightMajor));
          //Strings.Add(AsString(S + 'CalculatedShippingRate.WeightMinor -', WeightMinor));
          Strings.Add(AsString(S + 'CalculatedShippingRate.InternationalPackagingHandlingCosts -', InternationalPackagingHandlingCosts));
        End;
        Strings.Add(S + '.ChangePaymentInstructions -' + BooleantoStr(ChangePaymentInstructions));
        //Strings.Add(AsString(S + 'InsuranceFee -', InsuranceFee));
        //Strings.Add(S + '.InsuranceOption -' + enumtostr(InsuranceOption));
        Strings.Add(S + '.InsuranceWanted -' + BooleantoStr(InsuranceWanted));
        Strings.Add(S + '.PaymentEdited -' + BooleantoStr(PaymentEdited));
        Strings.Add(S + '.PaymentEdited -' + PaymentInstructions);
        Strings.Add(S + '.PaymentEdited -' + BooleantoStr(PaymentEdited));
        Strings.Add(AsString(S + 'SalesTax -', SalesTax));
        Strings.Add(S + '.ShippingRateErrorMessage -' + ShippingRateErrorMessage);
        Strings.Add(S + 'ShippingRateType -' + enumtostr(ShippingRateType));
        Strings.Add(AsString(S + 'ShippingServiceOptions -', ShippingServiceOptions));
        Strings.Add(AsString(S + 'InternationalShippingServiceOption -', InternationalShippingServiceOption));
        Strings.Add(S + 'ShippingType -' + enumtostr(ShippingType));
        Strings.Add(S + '.SellingManagerSalesRecordNumber -' + Inttostr(SellingManagerSalesRecordNumber));
        Strings.Add(S + '.ThirdPartyCheckout -' + BooleantoStr(ThirdPartyCheckout));
        Strings.Add(AsString(S + 'TaxTable -', TaxTable));
        Strings.Add(S + '.GetItFast -' + BooleantoStr(GetItFast));
        Strings.Add(S + '.ShippingServiceUsed -' + ShippingServiceUsed);
        Strings.Add(AsString(S + 'DefaultShippingCost -', DefaultShippingCost));
        //Strings.Add(AsString(S + 'InsuranceDetails -', InsuranceDetails));
        //Strings.Add(AsString(S + 'InternationalInsuranceDetails -', InternationalInsuranceDetails));
        Strings.Add(S + '.ShippingDiscountProfileID -' + ShippingDiscountProfileID);
        Strings.Add(AsString(S + 'FlatShippingDiscount -', FlatShippingDiscount));
        Strings.Add(AsString(S + 'CalculatedShippingDiscount -', CalculatedShippingDiscount));
        Strings.Add(S + '.PromotionalShippingDiscount -' + BooleantoStr(PromotionalShippingDiscount));
        Strings.Add(S + '.InternationalShippingDiscountProfileID -' + InternationalShippingDiscountProfileID);
        Strings.Add(AsString(S + '.InternationalFlatShippingDiscount -', InternationalFlatShippingDiscount));
        Strings.Add(AsString(S + '.InternationalCalculatedShippingDiscount -', InternationalCalculatedShippingDiscount));
        Strings.Add(S + '.InternationalPromotionalShippingDiscount -' + BooleantoStr(InternationalPromotionalShippingDiscount));
        Strings.Add(AsString(S + '.PromotionalShippingDiscountDetails -', PromotionalShippingDiscountDetails));
        Strings.Add(AsString(S + '.CODCost -', CODCost));
        Strings.Add(AsString(S + '.ExcludeShipToLocation -', ExcludeShipToLocation));
        Strings.Add(S + '.SellerExcludeShipToLocationsPreference -' + BooleantoStr(SellerExcludeShipToLocationsPreference));
        Strings.Add(AsString(S + '.ShipmentTrackingDetails -', ShipmentTrackingDetails));
        Strings.Add(AsString(S + '.RateTableDetails -', RateTableDetails));

      End;
    End;

  End;

End;

Procedure ListComponentProperties(Component: TObject; Strings: TStrings);
Var
  Count, Size, I        : Integer;
  List                  : PPropList;
  PropInfo              : PPropInfo;
  PropOrEvent, PropValue: String;
  PropName:String;
  PropTypeName:String;
Begin
  If Component = Nil Then Exit;
  Count := GetPropList(Component.ClassInfo, TkAny, Nil);
  Size  := Count * SizeOf(Pointer);
  PropInfo:= nil;
  GetMem(List, Size);
  Try
    Count := GetPropList(Component.ClassInfo, TkAny, List);
    //PropInfo := GetPropInfo(Component,PropName);
    For I := 0 To Count - 1 Do Begin
      Try
        PropInfo:= List^[I];
        PropName := String(PropInfo^.Name);
        PropTypeName := String(PropInfo^.PropType^.Name);
        If PropInfo^.PropType^.Kind In TkMethods Then PropOrEvent := 'Event'
        Else PropOrEvent  := 'Property';
        If (Component Is GetOrdersResponse) And Sametext(PropName, 'OrderArray') Then Begin
          ShowOrder(GetOrdersResponse(Component), Strings);
        End
        Else If PropType(Component, String(PropName)) In [Tkclass] Then Begin
          Strings.Add(PropOrEvent + ':' +PropName + ':' + PropTypeName + ' = subobject');
          If Component Is Tcomponent Then ListComponentProperties(Tcomponent(Component).FindComponent(PropName), Strings);
        End Else Begin
          PropValue := VarToStr(GetPropValue(Component, PropName));
          Strings.Add(PropOrEvent + PropName + ':' + PropTypeName + ' =' + PropValue);
        End;
      Except
        On E: Exception Do Begin
          Strings.Add('Exception .....' + PropOrEvent + PropName + ':' + PropTypeName + ' =' + E.Message);
        End;
      End;
    End;
  Finally FreeMem(List);
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ShipmentLineItemType); Overload;
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      Xnode    := Node.AddChild(Nodename);
      addnode(xnode , 'Quantity',Value[Ctr].Quantity);
      addnode(xnode , 'CountryOfOrigin' , Value[Ctr].CountryOfOrigin);
      addnode(xnode , 'Description',Value[Ctr].Description);
      addnode(xnode , 'ItemID',Value[Ctr].ItemID);
      addnode(xnode , 'TransactionID',Value[Ctr].TransactionID);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: EBayPaymentMismatchDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'MismatchType' , Value.MismatchType);
    AddNode(Node, 'ActionRequiredBy', Value.ActionRequiredBy);
    AddNode(Node, 'MismatchAmount', Value.MismatchAmount);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CheckoutStatusType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'ebaypaymentstatus' , Value.EBayPaymentStatus);
    AddNode(Node, 'LastModifiedtime', Value.LastModifiedTime);
    Addnode(node , 'PaymentMethod' , Value.PaymentMethod);
    Addnode(node , 'PaymentMethod' , Value.Status);
    Addnode(node , 'PaymentMethod' , BooleantoStr(Value.IntegratedMerchantCreditCardEnabled));
    AddNode(Node, 'eBayPaymentMismatchDetails', Value.EBayPaymentMismatchDetails);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CalculatedShippingRateType); Overload;
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'OriginatingPostalCode' , Value.OriginatingPostalCode);
    Addnode(node , 'MeasurementUnit', Value.MeasurementUnit);
    //AddNode(Node, 'PackageDepth', Value.PackageDepth);
    //AddNode(Node, 'PackageLength', Value.PackageLength);
    //AddNode(Node, 'PackageWidth', Value.PackageWidth);
    AddNode(Node, 'PackagingHandlingCosts', Value.PackagingHandlingCosts);
    Addnode(node , 'ShippingIrregular' , BooleantoStr(Value.ShippingIrregular));
    //Addnode(node , 'ShippingPackage', Value.ShippingPackage);
    //AddNode(Node, 'WeightMajor', Value.WeightMajor);
    //AddNode(Node, 'WeightMinor', Value.WeightMinor);
    AddNode(Node, 'InternationalPackagingHandlingCosts', Value.InternationalPackagingHandlingCosts);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ShippingDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'AllowPaymentEdit',BooleantoStr(Value.AllowPaymentEdit));
    Addnode(node , 'ApplyShippingDiscount' , BooleantoStr(Value.ApplyShippingDiscount));
    Addnode(node , 'GlobalShipping',BooleantoStr(Value.GlobalShipping));
    AddNode(Node, 'CalculatedShippingRate', Value.CalculatedShippingRate);
    Addnode(node , 'ChangePaymentInstructions' , BooleantoStr(Value.ChangePaymentInstructions));
    //AddNode(Node, 'InsuranceFee', Value.InsuranceFee);
    //Addnode(node , 'InsuranceOption',Value.InsuranceOption);
    Addnode(node , 'InsuranceWanted',BooleantoStr(Value.InsuranceWanted));
    Addnode(node , 'PaymentEdited',BooleantoStr(Value.PaymentEdited));
    Addnode(node , 'PaymentInstructions' , Value.PaymentInstructions);
    AddNode(Node, 'SalesTax', Value.SalesTax);
    Addnode(node , 'ShippingRateErrorMessage' , Value.ShippingRateErrorMessage);
    Addnode(node , 'ShippingRateType',Value.ShippingRateType);
    AddNode(Node, 'ShippingServiceOptions', Value.ShippingServiceOptions);
    AddNode(Node, 'InternationalShippingServiceOption', Value.InternationalShippingServiceOption);
    Addnode(node , 'ShippingType',Value.ShippingType);
    Addnode(node , 'SellingManagerSalesRecordNumber' , Value.SellingManagerSalesRecordNumber);
    Addnode(node , 'ThirdPartyCheckout',BooleantoStr(Value.ThirdPartyCheckout));
    AddNode(Node, 'TaxTable', Value.TaxTable);
    Addnode(node , 'GetItFast',BooleantoStr(Value.GetItFast));
    Addnode(node , 'ShippingServiceUsed' , Value.ShippingServiceUsed);
    AddNode(Node, 'DefaultShippingCost', Value.DefaultShippingCost);
    //AddNode(Node, 'InsuranceDetails', Value.InsuranceDetails);
    //AddNode(Node, 'InternationalInsuranceDetails', Value.InternationalInsuranceDetails);
    Addnode(node , 'ShippingDiscountProfileID' , Value.ShippingDiscountProfileID);
    AddNode(Node, 'FlatShippingDiscount', Value.FlatShippingDiscount);
    AddNode(Node, 'CalculatedShippingDiscount', Value.CalculatedShippingDiscount);
    Addnode(node , 'PromotionalShippingDiscount',BooleantoStr(Value.PromotionalShippingDiscount));
    Addnode(node , 'InternationalShippingDiscountProfileID' , Value.InternationalShippingDiscountProfileID);
    AddNode(Node, 'InternationalFlatShippingDiscount', Value.InternationalFlatShippingDiscount);
    AddNode(Node, 'InternationalCalculatedShippingDiscount', Value.InternationalCalculatedShippingDiscount);
    Addnode(node , 'InternationalPromotionalShippingDiscount' , BooleantoStr(Value.InternationalPromotionalShippingDiscount));
    AddNode(Node, 'PromotionalShippingDiscountDetails', Value.PromotionalShippingDiscountDetails);
    AddNode(Node, 'CODCost', Value.CODCost);
    AddNode(Node, 'ExcludeShipToLocation', Value.ExcludeShipToLocation);
    Addnode(node , 'SellerExcludeShipToLocationsPreference' , BooleantoStr(Value.SellerExcludeShipToLocationsPreference));
    AddNode(Node, 'ShipmentTrackingDetails', Value.ShipmentTrackingDetails);
    AddNode(Node, 'RateTableDetails', Value.RateTableDetails);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: FeatureEligibilityType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'QualifiesForBuyItNow',BooleantoStr(Value.QualifiesForBuyItNow));
    Addnode(node , 'QualifiesForBuyItNowMultiple',BooleantoStr(Value.QualifiesForBuyItNowMultiple));
    Addnode(node , 'QualifiedForFixedPriceOneDayDuration' , BooleantoStr(Value.QualifiedForFixedPriceOneDayDuration));
    Addnode(node , 'QualifiesForVariations',BooleantoStr(Value.QualifiesForVariations));
    Addnode(node , 'QualifiedForAuctionOneDayDuration',BooleantoStr(Value.QualifiedForAuctionOneDayDuration));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RecoupmentPolicyConsentType); Overload;
Var
  Ctr  : Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node , Nodename, value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ExtendedContactDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    AddNode(Node, 'ContactHoursDetails', Value.ContactHoursDetails);
    Addnode(node , 'ClassifiedAdContactByEmailEnabled' , BooleantoStr(Value.ClassifiedAdContactByEmailEnabled));
    Addnode(node , 'PayPerLeadPhoneNumber',Value.PayPerLeadPhoneNumber);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ContactHoursDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Addnode(node , 'TimeZoneID',Value.TimeZoneID);
    Addnode(node , 'Hours1Days',Value.Hours1Days);
    Addnode(node , 'Hours1AnyTime' , BooleantoStr(Value.Hours1AnyTime));
    AddNode(Node, 'Hours1From', Value.Hours1From);
    AddNode(Node, 'Hours1To', Value.Hours1To);
    Addnode(node , 'Hours2Days',Value.Hours2Days);
    Addnode(node , 'Hours2AnyTime' , BooleantoStr(Value.Hours2AnyTime));
    AddNode(Node, 'Hours2From', Value.Hours2From);
    AddNode(Node, 'Hours2To', Value.Hours2To);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundArrayType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      xNode  := Node.AddChild(Nodename );
      Addnode(xnode, 'RefundFromSeller' , Value[ctr].RefundFromSeller);
      Addnode(xnode, 'TotalRefundToBuyer' , Value[ctr].TotalRefundToBuyer);
      Addnode(xnode, 'RefundTime' , Value[ctr].RefundTime);
      addnode(xnode , 'RefundID' , Value[ctr].RefundID);
      Addnode(xnode, 'RefundTransactionArray' , Value[ctr].RefundTransactionArray);
      Addnode(xnode, 'RefundAmount' , Value[ctr].RefundAmount);
      addnode(xnode , 'ExternalReferenceID' , Value[ctr].ExternalReferenceID);
      Addnode(xnode, 'RefundFailureReason' , Value[ctr].RefundFailureReason);
      Addnode(xnode, 'RefundFundingSourceArray' , Value[ctr].RefundFundingSourceArray);
      addnode(xnode , 'ExternalReferenceID' , Value[ctr].ExternalReferenceID);
      Addnode(xnode, 'RefundRequestedTime' , Value[ctr].RefundRequestedTime);
      Addnode(xnode, 'RefundCompletionTime' , Value[ctr].RefundCompletionTime);
      Addnode(xnode, 'EstimatedRefundCompletionTime' , Value[ctr].EstimatedRefundCompletionTime);
      addnode(xnode , 'SellerNoteToBuyer' , Value[ctr].SellerNoteToBuyer);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundLineType );
begin
   if Value = nil then exit;
  try
      Node  := Node.AddChild(Nodename );
      Addnode(node , 'type_' , Value.type_);
  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundFundingSourceType );
begin
   if Value = nil then exit;
  try
    Node  := Node.AddChild(Nodename );
    Addnode(node , 'RefundingSourceType' , value.RefundingSourceType);
    Addnode(node , 'AccountNumber' , value.AccountNumber);
    addnode(node , 'RefundAmount' , Value.RefundAmount);
    Addnode(node , 'SellerExternalTransactionID' , value.SellerExternalTransactionID);
    Addnode(node , 'BuyerExternalTransactionID' , value.BuyerExternalTransactionID);
  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentInformationType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(xnode , Nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MultiLegShippingServiceType );
begin
   if Value = nil then exit;
  try
	  Node  := Node.AddChild(Nodename );
    addnode(node, 'ShippingService' , Value.ShippingService);
    addnode(node, 'TotalShippingCost' , Value.TotalShippingCost);
  Except
    on E: Exception do begin
      addnode(node, 'Exception',E.message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ItemCompatibilityType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node                                := Node.AddChild(Nodename + 's');
    For Ctr                             := Low(Value) To High(Value) Do Begin
      addnode(xnode , Nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Node.AddChild('Exception').NodeValue := E.Message;
    End;
  End;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: NameValueListArrayType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node                                := Node.AddChild(Nodename + 's');
    For Ctr                             := Low(Value) To High(Value) Do Begin
      addnode(xnode , Nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Node.AddChild('Exception').NodeValue := E.Message;
    End;
  End;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ListingDetailsType );
begin
   if Value = nil then exit;
  try
    Node                                := Node.AddChild(Nodename );
    Addnode(node , 'Adult', BooleanToStr(Value.Adult));
    Addnode(node , 'BindingAuction', BooleanToStr(Value.BindingAuction));
    Addnode(node , 'CheckoutEnabled', BooleanToStr(Value.CheckoutEnabled));
    Addnode(node , 'ConvertedBuyItNowPrice', Value.ConvertedBuyItNowPrice);
    Addnode(node , 'ConvertedStartPrice', Value.ConvertedStartPrice);
    Addnode(node , 'ConvertedReservePrice', Value.ConvertedReservePrice);
    Addnode(node , 'HasReservePrice', BooleanToStr(Value.HasReservePrice));
    Addnode(node , 'RelistedItemID', Value.RelistedItemID);
    Addnode(node , 'SecondChanceOriginalItemID', Value.SecondChanceOriginalItemID);
    Addnode(node , 'StartTime', Value.StartTime);
    Addnode(node , 'EndTime', Value.EndTime);
    Addnode(node , 'ViewItemURL', Value.ViewItemURL);
    Addnode(node , 'HasUnansweredQuestions', BooleanToStr(Value.HasUnansweredQuestions));
    Addnode(node , 'HasPublicMessages', BooleanToStr(Value.HasPublicMessages));
    Addnode(node , 'BuyItNowAvailable', BooleanToStr(Value.BuyItNowAvailable));
    Addnode(node , 'SellerBusinessType', Value.SellerBusinessType);
    Addnode(node , 'MinimumBestOfferPrice', Value.MinimumBestOfferPrice);
    Addnode(node , 'MinimumBestOfferMessage', Value.MinimumBestOfferMessage);
    Addnode(node , 'LocalListingDistance', Value.LocalListingDistance);
    Addnode(node , 'TCROriginalItemID', Value.TCROriginalItemID);
    Addnode(node , 'ViewItemURLForNaturalSearch', Value.ViewItemURLForNaturalSearch);
    Addnode(node , 'PayPerLeadEnabled', BooleanToStr(Value.PayPerLeadEnabled));
    Addnode(node , 'BestOfferAutoAcceptPrice', Value.BestOfferAutoAcceptPrice);
    Addnode(node , 'EndingReason', Value.EndingReason);

  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_anyURI );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node                                := Node.AddChild(Nodename + 's');
    For Ctr                             := Low(Value) To High(Value) Do Begin
      addnode(xnode , Nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Node.AddChild('Exception').NodeValue := E.Message;
    End;
  End;
end;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PictureDetailsType );
begin
   if Value = nil then exit;
  try
	Node                                := Node.AddChild(Nodename );
    Addnode(node , 'GalleryType' , Value.GalleryType);
      //Addnode(node , 'GalleryURL' , Value.GalleryURL);
      Addnode(node , 'PhotoDisplay' , Value.PhotoDisplay);
      Addnode(node , 'PictureURL' , Value.PictureURL);
      Addnode(node , 'PictureSource' , Value.PictureSource);
      //Addnode(node , 'GalleryDuration' , Value.GalleryDuration);
      Addnode(node , 'GalleryStatus' , Value.GalleryStatus);
      Addnode(node , 'GalleryErrorInfo' , Value.GalleryErrorInfo);
      Addnode(node , 'ExternalPictureURL' , Value.ExternalPictureURL);

  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;


Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentDetailsType );
begin
   if Value = nil then exit;
  try
Node                                := Node.AddChild(Nodename );
  Addnode(node , 'HoursToDeposit' , inttostr(Value.HoursToDeposit));
    Addnode(node , 'DaysToFullPayment' , inttostr(Value.DaysToFullPayment));
    Addnode(node , 'DepositAmount' , Value.DepositAmount);
    Addnode(node , 'DepositType' , Value.DepositType);
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;


Procedure AddNode(Node: IXMLNode; Nodename: String; Value: LookupAttributeType );
begin
   if Value = nil then exit;
  try
    Node := Node.AddChild(Nodename );
    Addnode(node , 'Name_' , Value.Name_);
    Addnode(node , 'Value' , Value.Value);
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;


Procedure AddNode(Node: IXMLNode; Nodename: String; Value: LookupAttributeArrayType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node                                := Node.AddChild(Nodename + 's');
    For Ctr                             := Low(Value) To High(Value) Do Begin
      addnode(xnode , Nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Node.AddChild('Exception').NodeValue := E.Message;
    End;
  End;
end;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ListingDesignerType );
begin
   if Value = nil then exit;
  try
Node                                := Node.AddChild(Nodename );
  Addnode(node , 'LayoutID' , inttostr(Value.LayoutID));
    Addnode(node , 'OptimalPictureSize' , BooleanToStr(Value.OptimalPictureSize));
    Addnode(node , 'ThemeID' , inttostr(Value.ThemeID));
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ListingCheckoutRedirectPreferenceType );
begin
   if Value = nil then exit;
  try
Node                                := Node.AddChild(Nodename );
  Addnode(node , 'ProStoresStoreName' , Value.ProStoresStoreName);
    Addnode(node , 'SellerThirdPartyUsername' , Value.SellerThirdPartyUsername);
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemPolicyViolationType );
begin
   if Value = nil then exit;
  try
Node                                := Node.AddChild(Nodename );
      Addnode(node , 'PolicyID' , inttostr(Value.PolicyID));
        Addnode(node , 'PolicyText' , Value.PolicyText);
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;

end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: NameValueListType );
begin
   if Value = nil then exit;
  try
Node                                := Node.AddChild(Nodename );
      Addnode(node , 'Name_' , Value.Name_);
        Addnode(node , 'Value' , Value.Value);
        Addnode(node , 'Source' , Value.Source);
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;


Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemCompatibilityType );
begin
   if Value = nil then exit;
  try
  Node                                := Node.AddChild(Nodename );
  Addnode(node , 'Delete' , BooleantoStr(Value.Delete));
    Addnode(node , 'NameValueList' , Value.NameValueList);
    Addnode(node , 'CompatibilityNotes' , Value.CompatibilityNotes);
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;


Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemCompatibilityListType );
begin
   if Value = nil then exit;
  try
Node                                := Node.AddChild(Nodename );
  Addnode(node , 'Compatibility' , Value.Compatibility);
    Addnode(node , 'ReplaceAll' , BooleantoStr(Value.ReplaceAll));
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;

(*Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ExternalProductIDType );
begin
   if Value = nil then exit;
  try
Node                                := Node.AddChild(Nodename );
    Addnode(node , 'Value' , Value.Value );
    Addnode(node , 'ReturnSearchResultOnDuplicates' , BooleanToStr(Value.ReturnSearchResultOnDuplicates ));
    Addnode(node , 'Type_' , Value.Type_ );
    Addnode(node , 'AlternateValue' , Value.AlternateValue );
  Except
    on E: Exception do begin
      node.AddChild('Exception').NodeValue := E.message;
    end;
  end;
end;*)

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RequiredSellerActionArrayType );
Var
  Ctr  : Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node , Nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      addnode(node, 'Exception',E.Message);
    End;
  End;
end;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MultiLegShipmentType );
begin
   if Value = nil then exit;
  try
  Node  := Node.AddChild(Nodename );
    addnode(node, 'ShippingServiceDetails' , Value.ShippingServiceDetails);
    addnode(node, 'ShipToAddress' , Value.ShipToAddress);
    addnode(node, 'ShippingTimeMin' , inttostr(Value.ShippingTimeMin));
    addnode(node, 'ShippingTimeMax' , inttostr(Value.ShippingTimeMax));
  Except
    on E: Exception do begin
      addnode(node, 'Exception',E.Message);
    end;
  end;
end;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TransactionReferenceType );
begin
   if Value = nil then exit;
  try
  Node  := Node.AddChild(Nodename );
    addnode(node, 'Text' , Value.Text);
    addnode(node, 'type_' , Value.type_);
  Except
    on E: Exception do begin
      addnode(node, 'Exception',E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: UserIdentityType );
begin
   if Value = nil then exit;
  try
  Node  := Node.AddChild(Nodename );
    addnode(node, 'Text' , Value.Text);
    addnode(node, 'type_' , Value.type_);
  Except
    on E: Exception do begin
      addnode(node, 'Exception',E.Message);
    end;
  end;
end;


Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentTransactionType );
begin
   if Value = nil then exit;
  try
  Node  := Node.AddChild(Nodename );
    addnode(node , 'PaymentStatus' , value.PaymentStatus);
    addnode(node , 'Payer' , Value.Payer);
    addnode(node , 'Payee' , Value.Payee);
    addnode(node , 'PaymentTime' , Value.PaymentTime);
    addnode(node , 'PaymentAmount' , Value.PaymentAmount);
    addnode(node , 'ReferenceID' , Value.ReferenceID);
    addnode(node , 'FeeOrCreditAmount' , Value.FeeOrCreditAmount);



  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;


Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundFundingSourceArrayType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(xnode , Nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundFailureReasonType );
begin
   if Value = nil then exit;
  try
    Node  := Node.AddChild(Nodename );
    Addnode(node , 'RefundFailureCode' , Value.RefundFailureCode);
  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundLineArrayType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(xnode , nodename, Value[ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RefundTransactionArrayType );
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      xNode  := Node.AddChild(Nodename );
      addnode(xnode , 'OrderID' , value[ctr].OrderID);
      addnode(xnode , 'ItemID' , value[ctr].ItemID);
      addnode(xnode , 'TransactionID' , value[ctr].TransactionID);
      Addnode(xnode , 'RefundLineArray' , Value[ctr].RefundLineArray);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
end;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentsInformationType );
begin
   if Value = nil then exit;
  try
    Addnode(node , 'Payments' , value.Payments );
  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MultiLegShippingDetailsType );
begin
   if Value = nil then exit;
  try
    Addnode(node , 'SellerShipmentToLogisticsProvider' , Value.SellerShipmentToLogisticsProvider);
    Addnode(node , 'LogisticsProviderShipmentToBuyer' , Value.LogisticsProviderShipmentToBuyer);
  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PaymentHoldDetailType );
begin
   if Value = nil then exit;
  try
    Addnode(node , 'ExpectedReleaseDate' , Value.ExpectedReleaseDate);
    addnode(node, 'RequiredSellerActionArray' , Value.RequiredSellerActionArray);
    Addnode(node , 'NumOfReqSellerActions' , inttostr(Value.NumOfReqSellerActions));
    Addnode(node , 'PaymentHoldReason' , Value.PaymentHoldReason);

  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TDatetime);
begin
   if Value = 0 then exit;
  try
    addnode(node, nodename,FormatDateTime('dd-mm-yyyy hh:nn:ss' , Value));
  Except
    on E: Exception do begin
      Addnode(node , 'Exception' , E.Message);
    end;
  end;
end;
Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TXSTime);
Begin
  If Value = Nil Then Exit;
  Try
    AddNode(Node, 'AsTime', Value.AsTime);
    Addnode(node , 'FractionalSeconds',FloatTostr(Value.FractionalSeconds));
    Addnode(node , 'Hour',FloatTostr(Value.Hour));
    Addnode(node , 'HourOffset',Inttostr(Value.HourOffset));
    Addnode(node , 'Millisecond',FloatTostr(Value.Millisecond));
    Addnode(node , 'Minute',FloatTostr(Value.Minute));
    Addnode(node , 'MinuteOffset',Inttostr(Value.MinuteOffset));
    Addnode(node , 'Second',FloatTostr(Value.Second));
    Addnode(node , 'UseZeroMilliseconds' , BooleantoStr(Value.UseZeroMilliseconds));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: DistanceType);
Begin
  If Value = Nil Then Exit;
  Try
    Node   := Node.AddChild(Nodename);
    Addnode(node , 'DistanceMeasurement' , Inttostr(Value.DistanceMeasurement));
    Addnode(node , 'DistanceUnit' , Value.DistanceUnit);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;

End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: DiscountPriceInfoType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    AddNode(Node, 'OriginalRetailPrice', Value.OriginalRetailPrice);
    AddNode(Node, 'MinimumAdvertisedPrice', Value.MinimumAdvertisedPrice);
    Addnode(node , 'MinimumAdvertisedPriceExposure' , Value.MinimumAdvertisedPriceExposure);
    Addnode(node , 'PricingTreatment',Value.PricingTreatment);
    Addnode(node , 'SoldOneBay',BooleantoStr(Value.SoldOneBay));
    Addnode(node , 'SoldOffeBay',BooleantoStr(Value.SoldOffeBay));
    AddNode(Node, 'MadeForOutletComparisonPrice', Value.MadeForOutletComparisonPrice);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TXSDuration);
Begin
  If Value = Nil Then Exit;
  Try
    Node  := Node.AddChild(Nodename);
    Addnode(node , 'Year',Inttostr(Value.Year));
    Addnode(node , 'Month',Inttostr(Value.Month));
    Addnode(node , 'Day',Inttostr(Value.Day));
    Addnode(node , 'Hour',Inttostr(Value.Hour));
    Addnode(node , 'Minute',Inttostr(Value.Minute));
    Addnode(node , 'Second',Inttostr(Value.Second));
    Addnode(node , 'DecimalSecond' , FloatTostr(Value.DecimalSecond));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_PromotionDetailsType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      AddNode(Xnode, 'PromotionPrice', Value[Ctr].PromotionPrice);
      addnode(xnode , 'PromotionPriceType' , Value[Ctr].PromotionPriceType);
      addnode(xnode , 'BidCount',Inttostr(Value[Ctr].BidCount));
      AddNode(Xnode, 'ConvertedPromotionPrice', Value[Ctr].ConvertedPromotionPrice);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_PromotedItemType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      Addnode(node , 'ItemID',Value[Ctr].ItemID);
      Addnode(node , 'PictureURL',Value[Ctr].PictureURL);
      Addnode(node , 'Position',Inttostr(Value[Ctr].Position));
      Addnode(node , 'SelectionType' , Value[Ctr].SelectionType);
      Addnode(node , 'Title',Value[Ctr].Title);
      Addnode(node , 'ListingType',Value[Ctr].ListingType);
      AddNode(Xnode, 'PromotionDetails', Value[Ctr].PromotionDetails);
      AddNode(Xnode, 'TimeLeft', Value[Ctr].TimeLeft);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CrossPromotionsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'SellerID',Value.SellerID);
    Addnode(node , 'StoreName',Value.StoreName);
    Addnode(node , 'ShippingDiscount' , BooleantoStr(Value.ShippingDiscount));
    Addnode(node , 'ItemID',Value.ItemID);
    Addnode(node , 'PrimaryScheme',Value.PrimaryScheme);
    Addnode(node , 'PromotionMethod',Value.PromotionMethod);
    AddNode(Node, 'PromotedItem', Value.PromotedItem);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CharityType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'CharityName',Value.CharityName);
    Addnode(node , 'CharityID',Value.CharityID);
    Addnode(node , 'Mission',Value.Mission);
    Addnode(node , 'LogoURL',Value.LogoURL);
    Addnode(node , 'CharityNumber',Inttostr(Value.CharityNumber));
    Addnode(node , 'DonationPercent' , FloatTostr(Value.DonationPercent));
    Addnode(node , 'Status',Value.Status);
    Addnode(node , 'CharityListing',BooleantoStr(Value.CharityListing));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: LabelType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'visible' , BooleantoStr(Value.Visible));
    Addnode(node , 'Name_',Value.Name_);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_CharacteristicType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);

      addnode(xnode , 'AttributeID',Inttostr(Value[Ctr].AttributeID));
      addnode(xnode , 'DateFormat',Value[Ctr].DateFormat);
      addnode(xnode , 'DisplaySequence' , Value[Ctr].DisplaySequence);
      addnode(xnode , 'DisplayUOM',Value[Ctr].DisplayUOM);
      AddNode(Xnode, 'Label_', Value[Ctr].Label_);
      addnode(xnode , 'SortOrder' , Value[Ctr].SortOrder);
      AddNode(Xnode, 'ValueList', Value[Ctr].ValueList);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_CharacteristicsSetType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node := Node.AddChild(Nodename + 's');
    For Ctr   := Low(Value) To High(Value) Do Begin
      Xnode   := Node.AddChild(Nodename);
      addnode(xnode , 'Name_',Value[Ctr].Name_);
      addnode(xnode , 'AttributeSetID',Inttostr(Value[Ctr].AttributeSetID));
      addnode(xnode , 'AttributeSetVersion' , Value[Ctr].AttributeSetVersion);
      AddNode(Xnode, 'Characteristics', Value[Ctr].Characteristics);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ExtendedProductFinderIDType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      Xnode    := Node.AddChild(Nodename);
      addnode(xnode , 'ProductFinderID',Inttostr(Value[Ctr].ProductFinderID));
      addnode(xnode , 'ProductFinderBuySide' , BooleantoStr(Value[Ctr].ProductFinderBuySide));
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CategoryType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'BestOfferEnabled' , BooleantoStr(Value.BestOfferEnabled));
    Addnode(node , 'AutoPayEnabled',BooleantoStr(Value.AutoPayEnabled));
    Addnode(node , 'B2BVATEnabled',BooleantoStr(Value.B2BVATEnabled));
    Addnode(node , 'CatalogEnabled',BooleantoStr(Value.CatalogEnabled));
    Addnode(node , 'CategoryID',Value.CategoryID);
    Addnode(node , 'CategoryLevel',Inttostr(Value.CategoryLevel));
    Addnode(node , 'CategoryName',Value.CategoryName);
    AddNode(Node, 'CategoryParentID', Value.CategoryParentID);
    AddNode(Node, 'CategoryParentName', Value.CategoryParentName);
    Addnode(node , 'ProductSearchPageAvailable' , BooleantoStr(Value.ProductSearchPageAvailable));
    AddNode(Node, 'ProductFinderIDs', Value.ProductFinderIDs);
    AddNode(Node, 'CharacteristicsSets', Value.CharacteristicsSets);
    Addnode(node , 'Expired',BooleantoStr(Value.Expired));
    Addnode(node , 'IntlAutosFixedCat',BooleantoStr(Value.IntlAutosFixedCat));
    Addnode(node , 'LeafCategory',BooleantoStr(Value.LeafCategory));
    Addnode(node , 'Virtual_',BooleantoStr(Value.Virtual_));
    Addnode(node , 'NumOfItems',Inttostr(Value.NumOfItems));
    Addnode(node , 'SellerGuaranteeEligible' , BooleantoStr(Value.SellerGuaranteeEligible));
    Addnode(node , 'ORPA',BooleantoStr(Value.ORPA));
    Addnode(node , 'ORRA',BooleantoStr(Value.ORRA));
    Addnode(node , 'LSD',BooleantoStr(Value.LSD));
    Addnode(node , 'Keywords',Value.Keywords);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

(*Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MaximumBuyerPolicyViolationsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'Count',Inttostr(Value.Count));
    Addnode(node , 'Period' , Value.Period);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;*)

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MaximumUnpaidItemStrikesInfoType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'Count',Inttostr(Value.Count));
    Addnode(node , 'Period' , Value.Period);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

(*Procedure AddNode(Node: IXMLNode; Nodename: String; Value: VerifiedUserRequirementsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'VerifiedUser',BooleantoStr(Value.VerifiedUser));
    Addnode(node , 'MinimumFeedbackScore' , Inttostr(Value.MinimumFeedbackScore));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;*)

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MaximumItemRequirementsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'MaximumItemCount',Inttostr(Value.MaximumItemCount));
    Addnode(node , 'MinimumFeedbackScore' , Inttostr(Value.MinimumFeedbackScore));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BuyerRequirementDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'ShipToRegistrationCountry' , BooleantoStr(Value.ShipToRegistrationCountry));
    Addnode(node , 'ZeroFeedbackScore',BooleantoStr(Value.ZeroFeedbackScore));
    //Addnode(node , 'MinimumFeedbackScore',Inttostr(Value.MinimumFeedbackScore));
    AddNode(Node, 'MaximumItemRequirements', Value.MaximumItemRequirements);
    //Addnode(node , 'LinkedPayPalAccount' , BooleantoStr(Value.LinkedPayPalAccount));
    //AddNode(Node, 'VerifiedUserRequirements', Value.VerifiedUserRequirements);
    AddNode(Node, 'MaximumUnpaidItemStrikesInfo', Value.MaximumUnpaidItemStrikesInfo);
    //AddNode(Node, 'MaximumBuyerPolicyViolations', Value.MaximumBuyerPolicyViolations);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BuyerProtectionDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'BuyerProtectionSource' , Value.BuyerProtectionSource);
    Addnode(node , 'BuyerProtectionStatus' , Value.BuyerProtectionStatus);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: VATDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'BusinessSeller',BooleantoStr(Value.BusinessSeller));
    Addnode(node , 'RestrictedToBusiness' , BooleantoStr(Value.RestrictedToBusiness));
    Addnode(node , 'VATPercent',FloatTostr(Value.VATPercent));
    Addnode(node , 'VATSite',Value.VATSite);
    Addnode(node , 'VATID',Value.VATID);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BusinessSellerDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    AddNode(Node, 'Address', Value.Address);
    Addnode(node , 'Fax',Value.Fax);
    Addnode(node , 'Email',Value.Email);
    Addnode(node , 'AdditionalContactInformation' , Value.AdditionalContactInformation);
    Addnode(node , 'TradeRegistrationNumber',Value.TradeRegistrationNumber);
    Addnode(node , 'LegalInvoice',BooleantoStr(Value.LegalInvoice));
    Addnode(node , 'TermsAndConditions',Value.TermsAndConditions);
    AddNode(Node, 'VATDetails', Value.VATDetails);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BiddingDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    AddNode(Node, 'ConvertedMaxBid', Value.ConvertedMaxBid);
    AddNode(Node, 'MaxBid', Value.MaxBid);
    Addnode(node , 'QuantityBid',Inttostr(Value.QuantityBid));
    Addnode(node , 'QuantityWon',Inttostr(Value.QuantityWon));
    Addnode(node , 'Winning',BooleantoStr(Value.Winning));
    Addnode(node , 'BidAssistant' , BooleantoStr(Value.BidAssistant));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BestOfferDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'BestOfferCount',Inttostr(Value.BestOfferCount));
    Addnode(node , 'BestOfferEnabled' , BooleantoStr(Value.BestOfferEnabled));
    AddNode(Node, 'BestOffer', Value.BestOffer);
    Addnode(node , 'BestOfferStatus' , Value.BestOfferStatus);
    Addnode(node , 'BestOfferType',Value.BestOfferType);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AttributeSetArrayType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node := Node.AddChild(Nodename + 's');
    For Ctr   := Low(Value) To High(Value) Do Begin
      Xnode   := Node.AddChild(Nodename);
      addnode(xnode , 'attributeSetID',Inttostr(Value[Ctr].AttributeSetID));
      addnode(xnode , 'attributeSetVersion' , Value[Ctr].AttributeSetVersion);
      AddNode(Xnode, 'Attribute', Value[Ctr].Attribute);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ValType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      addnode(xnode , 'ValueID',Inttostr(Value[Ctr].ValueID));
      addnode(xnode , 'ValueLiteral' , Value[Ctr].ValueLiteral);
      AddNode(Xnode, 'SuggestedValueLiteral', Value[Ctr].SuggestedValueLiteral);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AttributeArrayType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node := Node.AddChild(Nodename + 's');
    For Ctr   := Low(Value) To High(Value) Do Begin
      Xnode   := Node.AddChild(Nodename);
      addnode(xnode , 'attributeID',Inttostr(Value[Ctr].AttributeID));
      addnode(xnode , 'attributeLabel' , Value[Ctr].AttributeLabel);
      AddNode(Xnode, 'Value', Value[Ctr].Value);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

(*Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_SkypeContactOptionCodeType); Overload;
Var
  Ctr  : Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node, Nodename,Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;*)

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ListingEnhancementsCodeType);
Var
  Ctr  : Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node, Nodename,Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

(*Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_GiftServicesCodeType);
Var
  Ctr  : Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node, Nodename,Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;*)

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ItemType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'AutoPay',BooleantoStr(Value.AutoPay));
    //Addnode(node , 'MotorsGermanySearchable',BooleantoStr(Value.MotorsGermanySearchable));
    Addnode(node , 'CategoryMappingAllowed',BooleantoStr(Value.CategoryMappingAllowed));
    Addnode(node , 'PrivateListing',BooleantoStr(Value.PrivateListing));
    Addnode(node , 'RelistLink',BooleantoStr(Value.RelistLink));
    Addnode(node , 'DisableBuyerRequirements',BooleantoStr(Value.DisableBuyerRequirements));
    Addnode(node , 'LocationDefaulted',BooleantoStr(Value.LocationDefaulted));
    //Addnode(node , 'ThirdPartyCheckout',BooleantoStr(Value.ThirdPartyCheckout));
    Addnode(node , 'UseTaxTable',BooleantoStr(Value.UseTaxTable));
    Addnode(node , 'GetItFast',BooleantoStr(Value.GetItFast));
    Addnode(node , 'BuyerResponsibleForShipping',BooleantoStr(Value.BuyerResponsibleForShipping));
    Addnode(node , 'LimitedWarrantyEligible',BooleantoStr(Value.LimitedWarrantyEligible));
    Addnode(node , 'Relisted',BooleantoStr(Value.Relisted));
    //Addnode(node , 'CategoryBasedAttributesPrefill',BooleantoStr(Value.CategoryBasedAttributesPrefill));
    //Addnode(node , 'ShippingTermsInDescription',BooleantoStr(Value.ShippingTermsInDescription));
    //Addnode(node , 'SkypeEnabled',BooleantoStr(Value.SkypeEnabled));
    Addnode(node , 'BestOfferEnabled',BooleantoStr(Value.BestOfferEnabled));
    Addnode(node , 'LocalListing',BooleantoStr(Value.LocalListing));
    //Addnode(node , 'ThirdPartyCheckoutIntegration',BooleantoStr(Value.ThirdPartyCheckoutIntegration));
    Addnode(node , 'ProxyItem',BooleantoStr(Value.ProxyItem));
    Addnode(node , 'BidGroupItem',BooleantoStr(Value.BidGroupItem));
    Addnode(node , 'MechanicalCheckAccepted',BooleantoStr(Value.MechanicalCheckAccepted));
    Addnode(node , 'UpdateSellerInfo',BooleantoStr(Value.UpdateSellerInfo));
    Addnode(node , 'UpdateReturnPolicy',BooleantoStr(Value.UpdateReturnPolicy));
    Addnode(node , 'IntegratedMerchantCreditCardEnabled' , BooleantoStr(Value.IntegratedMerchantCreditCardEnabled));
    //Addnode(node , 'PostCheckoutExperienceEnabled',BooleantoStr(Value.PostCheckoutExperienceEnabled));
    //Addnode(node , 'UseRecommendedProduct',BooleantoStr(Value.UseRecommendedProduct));
    Addnode(node , 'TopRatedListing',BooleantoStr(Value.TopRatedListing));
    Addnode(node , 'IsIntermediatedShippingEligible',BooleantoStr(Value.IsIntermediatedShippingEligible));
    Addnode(node , 'HideFromSearch',BooleantoStr(Value.HideFromSearch));
    Addnode(node , 'IncludeRecommendations',BooleantoStr(Value.IncludeRecommendations));
    //Addnode(node , 'OutOfStockControl',BooleantoStr(Value.OutOfStockControl));
    Addnode(node , 'WatchCount',Inttostr(Value.WatchCount));
    Addnode(node , 'HitCount',Inttostr(Value.HitCount));
    Addnode(node , 'QuestionCount',Inttostr(Value.QuestionCount));
    Addnode(node , 'TotalQuestionCount',Inttostr(Value.TotalQuestionCount));
    Addnode(node , 'RelistParentID',Inttostr(Value.RelistParentID));
    //Addnode(node , 'GiftIcon',Inttostr(Value.GiftIcon));
    Addnode(node , 'LotSize',Inttostr(Value.LotSize));
    Addnode(node , 'Quantity',Inttostr(Value.Quantity));
    Addnode(node , 'QuantityAvailable',Inttostr(Value.QuantityAvailable));
    Addnode(node , 'DispatchTimeMax',Inttostr(Value.DispatchTimeMax));
    Addnode(node , 'LeadCount',Inttostr(Value.LeadCount));
    Addnode(node , 'NewLeadCount',Inttostr(Value.NewLeadCount));
    Addnode(node , 'ItemCompatibilityCount',Inttostr(Value.ItemCompatibilityCount));
    Addnode(node , 'ConditionID',Inttostr(Value.ConditionID));
    Addnode(node , 'QuantityThreshold',Inttostr(Value.QuantityThreshold));
    Addnode(node , 'ApplicationData',Value.ApplicationData);
    Addnode(node , 'Description',Value.Description);
    Addnode(node , 'ListingDuration',Value.ListingDuration);
    Addnode(node , 'Location',Value.Location);
    Addnode(node , 'PartnerCode',Value.PartnerCode);
    Addnode(node , 'PartnerName',Value.PartnerName);
    Addnode(node , 'PayPalEmailAddress',Value.PayPalEmailAddress);
    Addnode(node , 'PrivateNotes',Value.PrivateNotes);
    Addnode(node , 'RegionID',Value.RegionID);
    Addnode(node , 'SubTitle',Value.SubTitle);
    Addnode(node , 'Title',Value.Title);
    Addnode(node , 'SellerVacationNote',Value.SellerVacationNote);
    Addnode(node , 'eBayNotes',Value.EBayNotes);
    Addnode(node , 'PostalCode',Value.PostalCode);
    //Addnode(node , 'SellerInventoryID',Value.SellerInventoryID);
    //Addnode(node , 'SkypeID',Value.SkypeID);
    Addnode(node , 'GroupCategoryID',Value.GroupCategoryID);
    Addnode(node , 'ConditionDescription',Value.ConditionDescription);
    Addnode(node , 'ConditionDisplayName',Value.ConditionDisplayName);
    Addnode(node , 'TaxCategory',Value.TaxCategory);
    Addnode(node , 'SellerProvidedTitle',Value.SellerProvidedTitle);
    Addnode(node , 'VIN',Value.VIN);
    Addnode(node , 'VINLink',Value.VINLink);
    Addnode(node , 'VRM',Value.VRM);
    Addnode(node , 'VRMLink',Value.VRMLink);
    Addnode(node , 'ConditionDefinition',Value.ConditionDefinition);
    AddNode(Node, 'SellerContactDetails', Value.SellerContactDetails);
    AddNode(Node, 'BuyItNowPrice', Value.BuyItNowPrice);
    AddNode(Node, 'ReservePrice', Value.ReservePrice);
    AddNode(Node, 'StartPrice', Value.StartPrice);
    AddNode(Node, 'ClassifiedAdPayPerLeadFee', Value.ClassifiedAdPayPerLeadFee);
    AddNode(Node, 'BuyerGuaranteePrice', Value.BuyerGuaranteePrice);
    AddNode(Node, 'FloorPrice', Value.FloorPrice);
    AddNode(Node, 'CeilingPrice', Value.CeilingPrice);
    AddNode(Node, 'PaymentMethods', Value.PaymentMethods);
    //AddNode(Node, 'GiftServices', Value.GiftServices);
    AddNode(Node, 'ListingEnhancement', Value.ListingEnhancement);
    //AddNode(Node, 'SkypeContactOption', Value.SkypeContactOption);
    AddNode(Node, 'AttributeArray', Value.AttributeArray);
    AddNode(Node, 'AttributeSetArray', Value.AttributeSetArray);
    AddNode(Node, 'BestOfferDetails', Value.BestOfferDetails);
    AddNode(Node, 'BiddingDetails', Value.BiddingDetails);
    AddNode(Node, 'BusinessSellerDetails', Value.BusinessSellerDetails);
    Addnode(node , 'BuyerProtection' , Value.BuyerProtection);
    AddNode(Node, 'ApplyBuyerProtection', Value.ApplyBuyerProtection);
    AddNode(Node, 'BuyerRequirementDetails', Value.BuyerRequirementDetails);
    AddNode(Node, 'PrimaryCategory', Value.PrimaryCategory);
    AddNode(Node, 'SecondaryCategory', Value.SecondaryCategory);
    AddNode(Node, 'FreeAddedCategory', Value.FreeAddedCategory);
    AddNode(Node, 'Charity', Value.Charity);
    Addnode(node , 'Country' , Value.Country);
    AddNode(Node, 'CrossPromotion', Value.CrossPromotion);
    Addnode(node , 'Country',Value.Currency);
    Addnode(node , 'DescriptionReviseMode' , Value.DescriptionReviseMode);
    AddNode(Node, 'DiscountPriceInfo', Value.DiscountPriceInfo);
    AddNode(Node, 'Distance', Value.Distance);
    AddNode(Node, 'ExtendedSellerContactDetails', Value.ExtendedSellerContactDetails);
      //Addnode(node, 'ExternalProductID', Value.ExternalProductID);
      Addnode(node, 'HitCounter', Value.HitCounter);
      Addnode(node, 'PaymentAllowedSite', Value.PaymentAllowedSite);
      Addnode(node, 'InventoryTrackingMethod', Value.InventoryTrackingMethod);
      Addnode(node, 'ItemCompatibilityList', Value.ItemCompatibilityList);
      Addnode(node, 'ItemID', Value.ItemID);
      Addnode(node, 'ItemPolicyViolation', Value.ItemPolicyViolation);
      //Addnode(node, 'ListingCheckoutRedirectPreference', Value.ListingCheckoutRedirectPreference);
      Addnode(node, 'ListingDesigner', Value.ListingDesigner);
      Addnode(node, 'ListingDetails', Value.ListingDetails);
      Addnode(node, 'ListingSubtype2', Value.ListingSubtype2);
      Addnode(node, 'ListingType', Value.ListingType);
      Addnode(node, 'LookupAttributeArray', Value.LookupAttributeArray);
      Addnode(node, 'ItemSpecifics', Value.ItemSpecifics);
      Addnode(node, 'PaymentDetails', Value.PaymentDetails);
      Addnode(node, 'PictureDetails', Value.PictureDetails);
      (*Addnode(node, 'ProductListingDetails', Value.ProductListingDetails);
      Addnode(node, 'QuantityAvailableHint', Value.QuantityAvailableHint);
      Addnode(node, 'QuantityInfo', Value.QuantityInfo);
      Addnode(node, 'QuantityRestrictionPerBuyer', Value.QuantityRestrictionPerBuyer);
      Addnode(node, 'ReasonHideFromSearch', Value.ReasonHideFromSearch);
      Addnode(node, 'ReturnPolicy', Value.ReturnPolicy);
      Addnode(node, 'ReviseStatus', Value.ReviseStatus);
      Addnode(node, 'SearchDetails', Value.SearchDetails);
      Addnode(node, 'ShipToLocations', Value.ShipToLocations);
      Addnode(node, 'CrossBorderTrade', Value.CrossBorderTrade);
      Addnode(node, 'SellerProfiles', Value.SellerProfiles);
      Addnode(node, 'SellingStatus', Value.SellingStatus);
      Addnode(node, 'ShippingPackageDetails', Value.ShippingPackageDetails);
      Addnode(node, 'ShippingDetails', Value.ShippingDetails);
      Addnode(node, 'Site', Value.Site);
      Addnode(node, 'SKU', Value.SKU);
      Addnode(node, 'Storefront', Value.Storefront);
      Addnode(node, 'ScheduleTime', Value.ScheduleTime);
      Addnode(node, 'TimeLeft', Value.TimeLeft);
      Addnode(node, 'UnitInfo', Value.UnitInfo);
      Addnode(node, 'Seller', Value.Seller);
      Addnode(node, 'UUID', Value.UUID);
      Addnode(node, 'Variations', Value.Variations);
      Addnode(node, 'VATDetails', Value.VATDetails);*)
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ItemBidDetailsType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      addnode(xnode , 'ItemID', Value[Ctr].ItemID);
      addnode(xnode , 'CategoryID' , Value[Ctr].CategoryID);
      addnode(xnode , 'BidCount',Inttostr(Value[Ctr].BidCount));
      addnode(xnode , 'SellerID', Value[Ctr].SellerID);
      AddNode(Xnode, 'LastBidTime', Value[Ctr].LastBidTime);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BiddingSummaryType); Overload;
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'SummaryDays',Inttostr(Value.SummaryDays));
    Addnode(node , 'TotalBids',Inttostr(Value.TotalBids));
    Addnode(node , 'BidActivityWithSeller',Inttostr(Value.BidActivityWithSeller));
    Addnode(node , 'BidsToUniqueSellers',Inttostr(Value.BidsToUniqueSellers));
    Addnode(node , 'BidsToUniqueCategories' , Inttostr(Value.BidsToUniqueCategories));
    Addnode(node , 'BidsToUniqueCategories' , Inttostr(Value.BidsToUniqueCategories));
    AddNode(Node, 'ItemBidDetails', Value.ItemBidDetails);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_EBaySubscriptionTypeCodeType);
Var
  Ctr  : Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node, Nodename,Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CharityAffiliationsType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      Xnode    := Node.AddChild(Nodename);
      addnode(xnode , 'Text',Value[Ctr].Text);
      addnode(xnode , 'type_' , Value[Ctr].Type_);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TopRatedSellerDetailsType);
Var
  Ctr  : Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node, Nodename, Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_UserAgreementInfoType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node := Node.AddChild(Nodename + 's');
    For Ctr   := Low(Value) To High(Value) Do Begin
      Xnode   := Node.AddChild(Nodename);
      Addnode(node , 'Site',Value[Ctr].Site);
      Addnode(node , 'SellereBayPaymentProcessStatus' , Value[Ctr].SellereBayPaymentProcessStatus);

      AddNode(Node, 'AcceptedTime', Value[Ctr].AcceptedTime);
      AddNode(Node, 'SellereBayPaymentProcessEnableTime', Value[Ctr].SellereBayPaymentProcessEnableTime);
      Addnode(node , 'UserAgreementURL' , Value[Ctr].UserAgreementURL);

    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SellereBayPaymentProcessConsentCodeType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'PayoutMethodSet' , BooleantoStr(Value.PayoutMethodSet));
    Addnode(node , 'PayoutMethod',Value.PayoutMethod);
    AddNode(Node, 'UserAgreementInfo', Value.UserAgreementInfo);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SchedulingInfoType);
Begin
  If Value = Nil Then Exit;
  Try
    Node   := Node.AddChild(Nodename);
    Addnode(node , 'MaxScheduledMinutes' , Inttostr(Value.MaxScheduledMinutes));
    Addnode(node , 'MinScheduledMinutes' , Inttostr(Value.MinScheduledMinutes));
    Addnode(node , 'MaxScheduledItems',Inttostr(Value.MaxScheduledItems));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ProStoresDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node   := Node.AddChild(Nodename);
    Addnode(node , 'SellerThirdPartyUsername' , Value.SellerThirdPartyUsername);
    Addnode(node , 'StoreName',Value.StoreName);
    Addnode(node , 'Status',Value.Status);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ProStoresCheckoutPreferenceType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'CheckoutRedirectProStores' , BooleantoStr(Value.CheckoutRedirectProStores));
    AddNode(Node, 'ProStoresDetails', Value.ProStoresDetails);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: IntegratedMerchantCreditCardInfoType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      addnode(xnode , 'SiteCodeType' , Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CharityAffiliationDetailsType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node := Node.AddChild(Nodename + 's');
    For Ctr   := Low(Value) To High(Value) Do Begin
      Xnode   := Node.AddChild(Nodename);
      Addnode(node , 'CharityID',Value[Ctr].CharityID);
      Addnode(node , 'AffiliationType' , Value[Ctr].AffiliationType);
      AddNode(Node, 'LastUsedTime', Value[Ctr].LastUsedTime);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SellerType);
Begin
  If Value = Nil Then Exit;
  Try
    Node   := Node.AddChild(Nodename);
    Addnode(node , 'AllowPaymentEdit',BooleantoStr(Value.AllowPaymentEdit));
    Addnode(node , 'CheckoutEnabled',BooleantoStr(Value.CheckoutEnabled));
    Addnode(node , 'CIPBankAccountStored',BooleantoStr(Value.CIPBankAccountStored));
    Addnode(node , 'GoodStanding',BooleantoStr(Value.GoodStanding));
    Addnode(node , 'QualifiesForB2BVAT',BooleantoStr(Value.QualifiesForB2BVAT));
    Addnode(node , 'StoreOwner',BooleantoStr(Value.StoreOwner));
    Addnode(node , 'RegisteredBusinessSeller' , BooleantoStr(Value.RegisteredBusinessSeller));
    Addnode(node , 'CharityRegistered',BooleantoStr(Value.CharityRegistered));
    Addnode(node , 'SafePaymentExempt',BooleantoStr(Value.SafePaymentExempt));
    Addnode(node , 'TopRatedSeller',BooleantoStr(Value.TopRatedSeller));
    Addnode(node , 'DomesticRateTable',BooleantoStr(Value.DomesticRateTable));
    Addnode(node , 'InternationalRateTable',BooleantoStr(Value.InternationalRateTable));
    Addnode(node , 'StoreURL',Value.StoreURL);
    Addnode(node , 'TransactionPercent',FloatTostr(Value.TransactionPercent));
    AddNode(Node, 'SellerPaymentAddress', Value.SellerPaymentAddress);
    AddNode(Node, 'CharityAffiliationDetails', Value.CharityAffiliationDetails);
    Addnode(node , 'BillingCurrency' , Value.BillingCurrency);
    AddNode(Node, 'FeatureEligibility', Value.FeatureEligibility);
    Addnode(node , 'PaisaPayStatus',Inttostr(Value.PaisaPayStatus));
    Addnode(node , 'PaisaPayEscrowEMIStatus' , Inttostr(Value.PaisaPayEscrowEMIStatus));
    AddNode(Node, 'IntegratedMerchantCreditCardInfo', Value.IntegratedMerchantCreditCardInfo);
    Addnode(node , 'MerchandizingPref' , Value.MerchandizingPref);
    AddNode(Node, 'ProStoresPreference', Value.ProStoresPreference);
    AddNode(Node, 'RecoupmentPolicyConsent', Value.RecoupmentPolicyConsent);
    AddNode(Node, 'SchedulingInfo', Value.SchedulingInfo);
    Addnode(node , 'SellerBusinessType' , Value.SellerBusinessType);
    AddNode(Node, 'SellereBayPaymentProcessConsent', Value.SellereBayPaymentProcessConsent);
    Addnode(node , 'SellereBayPaymentProcessStatus' , Value.SellereBayPaymentProcessStatus);
    Addnode(node , 'SellerGuaranteeLevel',Value.SellerGuaranteeLevel);
    Addnode(node , 'SellerLevel',Value.SellerLevel);
    Addnode(node , 'PaymentMethod',Value.PaymentMethod);
    Addnode(node , 'StoreSite',Value.StoreSite);
    AddNode(Node, 'TopRatedSellerDetails', Value.TopRatedSellerDetails);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: BuyerType);
Begin
  If Value = Nil Then Exit;
  Node := Node.AddChild(Nodename);
  AddNode(Node, 'ShippingAddress', Value.ShippingAddress);
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: UserType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'AboutMePage',BooleantoStr(Value.AboutMePage));
    Addnode(node , 'EIASToken',Value.EIASToken);
    Addnode(node , 'Email',Value.Email);
    Addnode(node , 'FeedbackScore',Inttostr(Value.FeedbackScore));
    Addnode(node , 'UniqueNegativeFeedbackCount' , Inttostr(Value.UniqueNegativeFeedbackCount));
    Addnode(node , 'UniquePositiveFeedbackCount' , Inttostr(Value.UniquePositiveFeedbackCount));
    Addnode(node , 'PositiveFeedbackPercent',FloatTostr(Value.PositiveFeedbackPercent));
    Addnode(node , 'FeedbackPrivate',BooleantoStr(Value.FeedbackPrivate));
    Addnode(node , 'FeedbackRatingStar',Value.FeedbackRatingStar);
    Addnode(node , 'IDVerified',BooleantoStr(Value.IDVerified));
    Addnode(node , 'eBayGoodStanding',BooleantoStr(Value.EBayGoodStanding));
    Addnode(node , 'NewUser',BooleantoStr(Value.NewUser));
    AddNode(Node, 'RegistrationAddress', Value.RegistrationAddress);
    AddNode(Node, 'RegistrationDate', Value.RegistrationDate);
    Addnode(node , 'Site',Value.Site);
    Addnode(node , 'Status',Value.Status);
    Addnode(node , 'UserID',Value.UserID);
    Addnode(node , 'UserIDChanged' , BooleantoStr(Value.UserIDChanged));
    AddNode(Node, 'UserIDLastChanged', Value.UserIDLastChanged);
    Addnode(node , 'VATStatus' , Value.VATStatus);
    AddNode(Node, 'BuyerInfo', Value.BuyerInfo);
    AddNode(Node, 'SellerInfo', Value.SellerInfo);
    Addnode(node , 'BusinessRole' , Value.BusinessRole);
    AddNode(Node, 'CharityAffiliations', Value.CharityAffiliations);
    Addnode(node , 'PayPalAccountLevel',Value.PayPalAccountLevel);
    Addnode(node , 'PayPalAccountType',Value.PayPalAccountType);
    Addnode(node , 'PayPalAccountStatus' , Value.PayPalAccountStatus);
    AddNode(Node, 'UserSubscription', Value.UserSubscription);
    Addnode(node , 'SiteVerified' , BooleantoStr(Value.SiteVerified));
    AddNode(Node, 'SkypeID', Value.SkypeID);
    Addnode(node , 'eBayWikiReadOnly',BooleantoStr(Value.EBayWikiReadOnly));
    Addnode(node , 'TUVLevel', Inttostr(Value.TUVLevel));
    Addnode(node , 'VATID',Value.VATID);
    //Addnode(node , 'MotorsDealer',BooleantoStr(Value.MotorsDealer));
    Addnode(node , 'SellerPaymentMethod' , Value.SellerPaymentMethod);
    AddNode(Node, 'BiddingSummary', Value.BiddingSummary);
    Addnode(node , 'UserAnonymized',BooleantoStr(Value.UserAnonymized));
    Addnode(node , 'UniqueNeutralFeedbackCount' , Inttostr(Value.UniqueNeutralFeedbackCount));
    Addnode(node , 'EnterpriseSeller',BooleantoStr(Value.EnterpriseSeller));
    Addnode(node , 'BillingEmail',Value.BillingEmail);
    Addnode(node , 'QualifiesForSelling',BooleantoStr(Value.QualifiesForSelling));
    Addnode(node , 'StaticAlias',Value.StaticAlias);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;

End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TransactionArrayType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      AddNode(Xnode, 'AmountPaid', Value[Ctr].AmountPaid);
      AddNode(Xnode, 'AdjustmentAmount', Value[Ctr].AdjustmentAmount);
      AddNode(Xnode, 'ConvertedAdjustmentAmount', Value[Ctr].ConvertedAdjustmentAmount);
      AddNode(Xnode, 'Buyer', Value[Ctr].Buyer);
      AddNode(Xnode, 'ShippingDetails', Value[Ctr].ShippingDetails);
      AddNode(Xnode, 'ConvertedAmountPaid', Value[Ctr].ConvertedAmountPaid);
      AddNode(Xnode, 'ConvertedTransactionPrice', Value[Ctr].ConvertedTransactionPrice);
      AddNode(Xnode, 'CreatedDate', Value[Ctr].CreatedDate);
      addnode(xnode , 'DepositType' , Value[Ctr].DepositType);
      AddNode(Xnode, 'Item', Value[Ctr].Item);
      addnode(xnode , 'QuantityPurchased' , Value[Ctr].QuantityPurchased);
      (* Addnode(xnode , 'Status' , Value[ctr].Status);
        addnode(xnode , 'TransactionID' , value[ctr].TransactionID;
        Addnode(xnode , 'TransactionPrice' , Value[ctr].TransactionPrice);
        addnode(xnode , 'BestOfferSale' , BooleanToStr(value[ctr].BestOfferSale);
        addnode(xnode , 'VATPercent' , Floattostr(value[ctr].VATPercent);
        Addnode(xnode , 'ExternalTransaction' , Value[ctr].ExternalTransaction);
        Addnode(xnode , 'SellingManagerProductDetails' , Value[ctr].SellingManagerProductDetails);
        Addnode(xnode , 'ShippingServiceSelected' , Value[ctr].ShippingServiceSelected);
        addnode(xnode , 'BuyerMessage' , value[ctr].BuyerMessage;
        Addnode(xnode , 'DutchAuctionBid' , Value[ctr].DutchAuctionBid);
        Addnode(xnode , 'BuyerPaidStatus' , Value[ctr].BuyerPaidStatus);
        Addnode(xnode , 'SellerPaidStatus' , Value[ctr].SellerPaidStatus);
        Addnode(xnode , 'PaidTime' , Value[ctr].PaidTime);
        Addnode(xnode , 'ShippedTime' , Value[ctr].ShippedTime);
        Addnode(xnode , 'TotalPrice' , Value[ctr].TotalPrice);
        Addnode(xnode , 'FeedbackLeft' , Value[ctr].FeedbackLeft);
        Addnode(xnode , 'FeedbackReceived' , Value[ctr].FeedbackReceived);
        Addnode(xnode , 'ContainingOrder' , Value[ctr].ContainingOrder);
        Addnode(xnode , 'FinalValueFee' , Value[ctr].FinalValueFee);
        Addnode(xnode , 'ListingCheckoutRedirectPreference' , Value[ctr].ListingCheckoutRedirectPreference);
        Addnode(xnode , 'RefundArray' , Value[ctr].RefundArray);
        Addnode(xnode , 'TransactionSiteID' , Value[ctr].TransactionSiteID);
        Addnode(xnode , 'Platform_' , Value[ctr].Platform_);
        addnode(xnode , 'CartID' , value[ctr].CartID;
        addnode(xnode , 'SellerContactBuyerByEmail' , BooleantoStr(value[ctr].SellerContactBuyerByEmail);
        addnode(xnode , 'PayPalEmailAddress' , value[ctr].PayPalEmailAddress;
        addnode(xnode , 'PaisaPayID' , value[ctr].PaisaPayID;
        Addnode(xnode , 'BuyerGuaranteePrice' , Value[ctr].BuyerGuaranteePrice);
        Addnode(xnode , 'Variation' , Value[ctr].Variation);
        addnode(xnode , 'BuyerCheckoutMessage' , value[ctr].BuyerCheckoutMessage;
        Addnode(xnode , 'TotalTransactionPrice' , Value[ctr].TotalTransactionPrice);
        Addnode(xnode , 'Taxes' , Value[ctr].Taxes);
        addnode(xnode , 'BundlePurchase' , BooleanToStr(value[ctr].BundlePurchase);
        Addnode(xnode , 'ActualShippingCost' , Value[ctr].ActualShippingCost);
        Addnode(xnode , 'ActualHandlingCost' , Value[ctr].ActualHandlingCost);
        addnode(xnode , 'OrderLineItemID' , value[ctr].OrderLineItemID;
        Addnode(xnode , 'PaymentHoldDetails' , Value[ctr].PaymentHoldDetails);
        Addnode(xnode , 'SellerDiscounts' , Value[ctr].SellerDiscounts);
        Addnode(xnode , 'RefundAmount' , Value[ctr].RefundAmount);
        addnode(xnode , 'RefundStatus' , value[ctr].RefundStatus;
        addnode(xnode , 'CodiceFiscale' , value[ctr].CodiceFiscale;
        addnode(xnode , 'IsMultiLegShipping' , BooleantoStr(value[ctr].IsMultiLegShipping);
        Addnode(xnode , 'MultiLegShippingDetails' , Value[ctr].MultiLegShippingDetails);
        Addnode(xnode , 'InvoiceSentTime' , Value[ctr].InvoiceSentTime);
        Addnode(xnode , 'UnpaidItem' , Value[ctr].UnpaidItem);
        addnode(xnode , 'IntangibleItem' , BooleantoStr(value[ctr].IntangibleItem);
        Addnode(xnode , 'MonetaryDetails' , Value[ctr].MonetaryDetails); *)
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ExternalTransactionType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node   := Node.AddChild(Nodename + 's');
    For Ctr:= Low(Value) To High(Value) Do Begin
      Xnode:= Node.AddChild(Nodename);
      addnode(xnode , 'ExternalTransactionID' , Value[Ctr].ExternalTransactionID);
      AddNode(Xnode, 'ExternalTransactionTime', Value[Ctr].ExternalTransactionTime);
      AddNode(Xnode, 'FeeOrCreditAmount', Value[Ctr].FeeOrCreditAmount);
      AddNode(Xnode, 'PaymentOrRefundAmount', Value[Ctr].PaymentOrRefundAmount);
      (* addnode(xnode, 'ExternalTransactionStatus' , Value[ctr].ExternalTransactionStatus); *)
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: ShippingServiceOptionsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    AddNode(Node, 'ShippingInsuranceCost', Value.ShippingInsuranceCost);
    Addnode(node , 'ShippingService' , Value.ShippingService);
    AddNode(Node, 'ShippingServiceCost', Value.ShippingServiceCost);
    AddNode(Node, 'ShippingServiceAdditionalCost', Value.ShippingServiceAdditionalCost);
    Addnode(node , 'ShippingServicePriority' , Inttostr(Value.ShippingServicePriority));
    Addnode(node , 'ExpeditedService',BooleantoStr(Value.ExpeditedService));
    Addnode(node , 'ShippingTimeMin',Inttostr(Value.ShippingTimeMin));
    Addnode(node , 'ShippingTimeMax',Inttostr(Value.ShippingTimeMax));
    //Addnode(node , 'ShippingSurcharge',Value.ShippingSurcharge);
    Addnode(node , 'FreeShipping',BooleanToStr(Value.FreeShipping));
    Addnode(node , 'LocalPickup',BooleanToStr(Value.LocalPickup));
    Addnode(node , 'ImportCharge',Value.ImportCharge);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;

End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AddressType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'Name_',Value.Name_);
    Addnode(node , 'Street',Value.Street);
    Addnode(node , 'Street1',Value.Street1);
    Addnode(node , 'Street2',Value.Street2);
    Addnode(node , 'CityName',Value.Cityname);
    Addnode(node , 'County',Value.Country);
    Addnode(node , 'StateOrProvince',Value.StateOrProvince);
    Addnode(node , 'Country', Value.Country);
    Addnode(node , 'CountryName',Value.CountryName);
    Addnode(node , 'Phone',Value.Phone);
    Addnode(node , 'PhoneCountryCode',Value.PhoneCountryCode);
    Addnode(node , 'PhoneCountryPrefix',Value.PhoneCountryPrefix);
    Addnode(node , 'PhoneAreaOrCityCode',Value.PhoneAreaOrCityCode);
    Addnode(node , 'PhoneLocalNumber',Value.PhoneLocalNumber);
    //Addnode(node , 'Phone2CountryCode',Value.Phone2CountryCode);
    //Addnode(node , 'Phone2CountryPrefix',Value.Phone2CountryPrefix);
    //Addnode(node , 'Phone2AreaOrCityCode',Value.Phone2AreaOrCityCode);
    //Addnode(node , 'Phone2LocalNumber',Value.Phone2LocalNumber);
    Addnode(node , 'PostalCode',Value.PostalCode);
    Addnode(node , 'AddressID',Value.AddressID);
    Addnode(node , 'AddressOwner',Value.AddressOwner);
    Addnode(node , 'AddressStatus',Value.AddressStatus);
    Addnode(node , 'ExternalAddressID',Value.ExternalAddressID);
    Addnode(node , 'InternationalName',Value.InternationalName);
    Addnode(node , 'InternationalStateAndCity' , Value.InternationalStateAndCity);
    Addnode(node , 'InternationalStreet',Value.InternationalStreet);
    Addnode(node , 'CompanyName',Value.CompanyName);
    Addnode(node , 'AddressRecordType',Value.AddressRecordType);
    Addnode(node , 'FirstName',Value.FirstName);
    Addnode(node , 'LastName',Value.LastName);
    Addnode(node , 'Phone2',Value.Phone2);
    Addnode(node , 'AddressUsage',Value.AddressUsage);
    Addnode(node , 'ReferenceID',Value.ReferenceID);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;

End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_BuyerPaymentMethodCodeType);
Var
  Ctr: Integer;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node  := Node.AddChild(Nodename + 's');
    For Ctr    := Low(Value) To High(Value) Do Begin
      addnode(node, Nodename,Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ShipmentTrackingDetailsType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      addnode(xnode , 'ShippingCarrierUsed',Value[Ctr].ShippingCarrierUsed);
      addnode(xnode , 'ShipmentTrackingNumber' , Value[Ctr].ShipmentTrackingNumber);
      AddNode(Xnode, 'ShipLineItem', Value[Ctr].ShipmentLineItem);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: RateTableDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'ShippingCarrierUsed',Value.DomesticRateTable);
    Addnode(node , 'ShipmentTrackingNumber' , Value.InternationalRateTable);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SellerExcludeShipToLocationPreferencesType); Overload;
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      addnode(xnode , 'DiscountProfileID' , Value[Ctr]);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: FlatShippingDiscountType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'DiscountName' , Value.DiscountName);
    AddNode(Node, 'DiscountProfile', Value.DiscountProfile);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

(*Procedure AddNode(Node: IXMLNode; Nodename: String; Value: InsuranceDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    AddNode(Node, 'InsuranceFee', Value.InsuranceFee);
    Addnode(node , 'InsuranceOption ' , Value.InsuranceOption);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;*)

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: CalculatedShippingDiscountType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'DiscountName' , Value.DiscountName);
    AddNode(Node, 'DiscountProfile', Value.DiscountProfile);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: PromotionalShippingDiscountDetailsType);
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'DiscountName' , Value.DiscountName);
    AddNode(Node, 'ShippingCost', Value.ShippingCost);
    AddNode(Node, 'OrderAmount', Value.OrderAmount);
    Addnode(node , 'ItemCount' , Value.ItemCount);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_DiscountProfileType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);

      addnode(xnode , 'DiscountProfileID',Value[Ctr].DiscountProfileID);
      addnode(xnode , 'DiscountProfileName' , Value[Ctr].DiscountProfileName);
      AddNode(Xnode, 'EachAdditionalAmount', Value[Ctr].EachAdditionalAmount);
      AddNode(Xnode, 'EachAdditionalAmountOff', Value[Ctr].EachAdditionalAmountOff);
      addnode(xnode , 'EachAdditionalPercentOff' , FloatTostr(Value[Ctr].EachAdditionalPercentOff));
      AddNode(Xnode, 'WeightOff', Value[Ctr].WeightOff);
      addnode(xnode , 'MappedDiscountProfileID' , Value[Ctr].MappedDiscountProfileID);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TaxTableType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);

      addnode(xnode , 'JurisdictionID',Value[Ctr].JurisdictionID);
      addnode(xnode , 'ShippingService',FloatTostr(Value[Ctr].SalesTaxPercent));
      addnode(xnode , 'ShippingIncludedInTax' , BooleantoStr(Value[Ctr].ShippingIncludedInTax));
      addnode(xnode , 'JurisdictionName', Value[Ctr].JurisdictionName);
      addnode(xnode , 'DetailVersion' , Value[Ctr].DetailVersion);
      AddNode(Xnode, 'UpdateTime', Value[Ctr].UpdateTime);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_InternationalShippingServiceOptionsType);
Var
  Ctr, I: Integer;
  Xnode : IXMLNode;
  Ynode : IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      addnode(xnode , 'ShippingService', Value[Ctr].ShippingService);
      AddNode(Xnode, 'ShippingServiceCost', Value[Ctr].ShippingServiceCost);
      AddNode(Xnode, 'ShippingServiceAdditionalCost', Value[Ctr].ShippingServiceAdditionalCost);
      addnode(xnode , 'ShippingServicePriority' , Value[Ctr].ShippingServicePriority);
      If High(Value[Ctr].ShipToLocation) >= 0 Then Begin
        Ynode := addnode(xnode , 'ShipLocations');
        For I := Low(Value[Ctr].ShipToLocation) To High(Value[Ctr].ShipToLocation) Do
          Addnode(node , 'shiplocation' , Value[Ctr].ShipToLocation[I]);
      End;
      AddNode(Xnode, 'ShippingInsuranceCost', Value[Ctr].ShippingInsuranceCost);
      AddNode(Xnode, 'ImportCharge', Value[Ctr].ImportCharge);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: Array_Of_ShippingServiceOptionsType);
Var
  Ctr  : Integer;
  Xnode: IXMLNode;
Begin
  If Value = Nil Then Exit;
  Try
    If High(Value) < 0 Then Exit;
    Node    := Node.AddChild(Nodename + 's');
    For Ctr := Low(Value) To High(Value) Do Begin
      Xnode := Node.AddChild(Nodename);
      AddNode(Xnode, 'ShippingInsuranceCost', Value[Ctr].ShippingInsuranceCost);
      addnode(xnode , 'shippingService' , Value[Ctr].ShippingService);
      AddNode(Xnode, 'ShippingServiceCost', Value[Ctr].ShippingServiceCost);
      AddNode(Xnode, 'ShippingServiceAdditionalCost', Value[Ctr].ShippingServiceAdditionalCost);
      addnode(xnode , 'ShippingServicePriority' , Value[Ctr].ShippingServicePriority);
      addnode(xnode , 'ExpeditedService',BooleantoStr(Value[Ctr].ExpeditedService));
      addnode(xnode , 'ShippingTimeMin', Value[Ctr].ShippingTimeMin);
      addnode(xnode , 'ShippingTimeMax', Value[Ctr].ShippingTimeMax);
      //AddNode(Xnode, 'ShippingSurcharge', Value[Ctr].ShippingSurcharge);
      addnode(xnode , 'FreeShipping' , BooleantoStr(Value[Ctr].FreeShipping));
      addnode(xnode , 'LocalPickup',BooleantoStr(Value[Ctr].LocalPickup));
      AddNode(Xnode, 'ImportCharge', Value[Ctr].ImportCharge);
    End;
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: SalesTaxType);
Begin
  If Value = Nil Then Exit;
  Try
    Node:= Node.AddChild(Nodename);
    Addnode(node , 'SalesTaxPercent',FloatTostr(Value.SalesTaxPercent));
    Addnode(node , 'SalesTaxrate',Value.SalesTaxState);
    Addnode(node , 'shippingIncludedinTax' , BooleantoStr(Value.ShippingIncludedInTax));
    AddNode(Node, 'SalesTaxAmount', Value.SalesTaxAmount);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: TXSDateTime); Overload;
Begin
  If Value = Nil Then Exit;
  Try
    Node   := Node.AddChild(Nodename);
    Addnode(node , 'Date' , FormatDateTime('dd-mm-yyyy hh:nn:ss', Value.AsDatetime));
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: MeasureType); Overload;
Begin
  If Value = Nil Then Exit;
  Try
    Node := Node.AddChild(Nodename);
    Addnode(node , 'Value',Value.Text.DecimalString);
    Addnode(node , 'unit',Value.Unit_);
    Addnode(node , 'MeasurementSystem' , Value.MeasurementSystem);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;

Procedure AddNode(Node: IXMLNode; Nodename: String; Value: AmountType);
Begin
  If Value = Nil Then Exit;
  Try
    Node    := Node.AddChild(Nodename);
    Addnode(node , 'Amount',FloatTostr(Value.Text));
    Addnode(node , 'CurrencyID' , Value.CurrencyID);
  Except
    On E: Exception Do Begin
      Addnode(node , 'Exception' , E.Message);
    End;
  End;
End;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SMSSubscriptionUserStatusCodeType              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerShippedStatusCodeType            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerSearchTypeCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerPaidStatusCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CheckoutStatusCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:WirelessCarrierIDCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RequiredSellerActionCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SMSSubscriptionErrorCodeCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UnpaidItemStatusTypeCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingRateTypeCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingTypeCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingCarrierCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingServiceCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShipmentDeliveryStatusCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShipmentStatusCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingFeatureCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MerchandizingPrefCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerGuaranteeLevelCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayoutMethodType                               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellereBayPaymentProcessStatusCodeType         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentTypeCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FedExRateOptionCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:USPSRateOptionCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UPSRateOptionCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisplayPayNowButtonCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreItemListSortOrderCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SearchStandingStatusCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutoRelistOptionCodeType         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutoRelistTypeCodeType           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerAccountStatusCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RangeCodeType                                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DateSpecifierCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerEmailSentStatusCodeType          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutoSecondChanceOfferTypeCodeType): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerEmailTypeCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAutomationPropertyTypeCodeType   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerPaisaPayPropertyTypeCodeType     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerAlertTypeCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerGeneralPropertyTypeCodeType      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerDashboardAlertSeverityCodeType           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DayOfWeekCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingRegionCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EBaySubscriptionTypeCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VeROItemStatusCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MismatchTypeCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayPalAccountStatusCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreSubscriptionLevelCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreFontSizeCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MerchDisplayCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomHeaderLayoutCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreHeaderStyleCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreItemListLayoutCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreFontFaceCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureFormatCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomListingHeaderDisplayCodeType        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomPageStatusCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCustomListingHeaderLinkCodeType           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SummaryWindowPeriodCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UnpaidItemCaseOpenTypeCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UserIdentityCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UnpaidItemCaseStatusTypeCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:URLTypeCodeType                                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackRatingStarCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayPalAccountLevelCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PayPalAccountTypeCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BusinessRoleType                               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:UserStatusCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VATStatusCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TaxTypeCodeType                                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TaxDescriptionCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SummaryFrequencyCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaidStatusCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TransactionReferenceCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TokenStatusCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TopRatedProgramCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ReasonHideFromSearchCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BoldTitleCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BorderCodeType                                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HighlightCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerBusinessCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SkypeContactOptionCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:QuantityAvailableHintCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingSubtypeCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GiftIconCodeType                               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PeriodCodeType                                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:QuestionTypeCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProPackCodeType                                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HomePageFeaturedCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeaturedFirstCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeaturedPlusCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MarkUpMarkDownEventTypeCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FlatRateInsuranceRangeCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FlatShippingRateOptionCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingFlowCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:OrderStatusFilterCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingEnhancementsCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DescriptionReviseModeCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GiftServicesCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HitCounterCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RecommendationEngineCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SiteCodeType                                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CharacteristicsSearchCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionItemSelectionCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionItemPriceTypeCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerLevelCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GalleryStatusCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerSubscriptionLevelCodeType        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GalleryTypeCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PhotoDisplayCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureSourceCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PolicyComplianceStatusCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerPictureDisplayTypeCodeType       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundingSourceTypeCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundFailureCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundStatusCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StatusCodeType                                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundLineTypeCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ValueTypeCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DiscountCodeType                               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionalSaleTypeCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ValueFormatCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SelectionModeCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VariationPictureRuleCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VariationSpecificsRuleCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentMethodSearchCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PreferredLocationCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemConditionCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SimpleItemSortCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemTypeCodeType                               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SearchFlagCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSpecificSourceCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:QuantityOperatorCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MyMessagesAlertResolutionStatusCode            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DepositTypeCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentHoldStatusCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PerformanceStatusCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentHoldReasonCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationEventStateCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationEventPropertyNameCodeType          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressTypeCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationEventTypeCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BidActionCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProductUseCaseCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerDetailLevelCodeType              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RCSPaymentStatusCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionalSaleStatusCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MessageTypeCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:OrderStatusCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SortOrderCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationRoleCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeFilterTypeCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeSortTypeCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:VeROReportPacketStatusCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerSoldListingsPropertyTypeCodeType ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerSoldListingsSortTypeCodeType     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InventoryTrackingMethodCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerProductSortCodeType              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellingManagerInventoryPropertyTypeCodeType    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CombinedPaymentPeriodCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TaskStatusCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingTypeCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RecipientRelationCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EndReasonCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DiscountReasonCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeReasonCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeExplanationCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeActivityCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SecondChanceOfferDurationCodeType              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TradingRoleCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionMethodCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StringMatchCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CountryCodeType                                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:TransactionPlatformCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSortTypeCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CommentTypeCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackTypeCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ListingStatusCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GetAllBiddersModeCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CurrencyCodeType                               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountHistorySelectionCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountEntrySortTypeCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MessageStatusTypeCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeatureIDCodeType                              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GranularityLevelCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BestOfferStatusCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProductCreationEnabledCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentOptionsGroupEnabledCodeType             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProfileCategoryGroupCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CharityAffiliationTypeCodeType                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ClassifiedAdBestOfferEnabledCodeType           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSpecificsEnabledCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AdFormatEnabledCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ClassifiedAdPaymentMethodEnabledCodeType       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GeographicExposureCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemCompatibilityEnabledCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ConditionEnabledCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:INEscrowWorkflowTimelineCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AttributeConversionEnabledCodeType             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CombinedPaymentOptionCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SocialAddressTypeCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CharityStatusCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentStatusCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BestOfferTypeCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BidGroupItemStatusCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BidGroupStatusCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackRatingDetailCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackSummaryPeriodCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:HandlingNameCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DiscountNameCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerSatisfactionStatusCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ShippingPackageCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ProductStateCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CalculatedShippingChargeOptionCodeType         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CalculatedShippingRateOptionCodeType           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerProtectionSourceCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerProtectionCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PricingTreatmentCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeRecordTypeCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeStateCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DescriptionTemplateCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MinimumAdvertisedPriceExposureCodeType         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeStatusCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EndOfAuctionLogoTypeCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeCreditEligibilityCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DaysCodeType                                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PromotionSchemeCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemFormatSortFilterCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:GallerySortFilterCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ItemSortFilterCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PaymentTransactionStatusCodeType               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ExternalProductCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MyMessagesFolderOperationCodeType              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:FeedbackResponseCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BuyerPaymentMethodCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InsuranceSelectedCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CompleteStatusCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:CheckoutMethodCodeType                         ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InsuranceOptionCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureManagerActionCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeResolutionReasonCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DetailNameCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:BestOfferActionCodeType                        ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundReasonCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
//Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:RefundTypeCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeMessageSourceCodeType                   ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SeverityCodeType                               ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ErrorClassificationCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DisputeResolutionRecordTypeCodeType            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:InvocationStatusType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DetailLevelCodeType                            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AckCodeType                                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ErrorHandlingCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:WarningLevelCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AnnouncementMessageCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccessRuleCurrentStatusCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccessRuleStatusCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressUsageCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ApplicationDeviceTypeCodeType                  ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:EnableCodeType                                 ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:NotificationPayloadTypeCodeType                ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:DeviceTypeCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountDetailEntryCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AccountStateCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:MeasurementSystemCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SellerPaymentMethodCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressOwnerCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressStatusCodeType                          ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AddressRecordTypeCodeType                      ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AdFormatLeadStatusCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:StoreCategoryUpdateActionCodeType              ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:ModifyActionCodeType                           ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:AutomatedLeaveFeedbackEventCodeType            ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:SetUserNotesActionCodeType                     ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureUploadPolicyCodeType                    ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureWatermarkCodeType                       ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function Addnode(node:IXMLNode; nodeCaption:String;Const Value:PictureSetCodeType                             ): String;  begin addnode(node , nodecaption , enumtostr(value)); end;
Function ToBeUpdatedSalesShipment(NL:String):String;
begin
  Result := ' SELECT  '+NL+
            ' EBS.OrderID                            AS OrderID, '                  +NL+
            ' S.clientId                             AS ClientId,  '                +NL+
            ' S.InvoiceDocNumber                     AS Saleno,  '                  +NL+
            ' S.SaleId                               AS SaleId,  '                  +NL+
            ' S.Customername                         AS CustomerName,  '            +NL+
            ' S.ClientPrintName                      AS PrintName,  '               +NL+
            ' S.totalAmountinc                       AS TotalAmountinc,  '          +NL+
            ' S.TotalTax                             AS TotalTax,  '                +NL+
            ' S.totalAmount                          AS TotalAmount,  '             +NL+
            ' S.Payment                              AS Payment,  '                 +NL+
            ' S.balance                              AS Balance,  '                 +NL+
            ' S.SaleDate                             AS SaleDate,  '                +NL+
            ' S.Converted                            AS Converted,  '               +NL+
            ' S.futureSo                             AS futureSo,  '                +NL+
            ' S.QuoteStatus                          AS SaleStatus,  '              +NL+
            ' S.ShipDate                             AS Saleshipdate,  '            +NL+
            ' S.HoldSale                             AS held,  '                    +NL+
            ' S.PONumber                             AS PONumber,  '                +NL+
            ' S.terms                                AS terms,  '                   +NL+
            ' S.Comments                             AS Comments,  '                +NL+
            ' S.Class                                AS ClassName,  '               +NL+
            ' S.dueDate                              AS dueDate,  '                 +NL+
            ' S.Payment                              AS Payment,  '                 +NL+
            ' S.ForeignExchangeCode                  AS ForeignExchangeCode,  '     +NL+
            ' ReplaceNewLine(S.ShipTo,"")            AS ShipTo ,  '                 +NL+
            ' If(IsNull(S.ClientSignature),"F","T")  AS HasSignature ,  '           +NL+
            ' SHP.ShipmentId                         AS ShipmentId,  '              +NL+
            ' SHP.ShipAddressId                      AS ShipAddressId,  '           +NL+
            ' SHP.MasterTrackingNumber               AS MasterTrackingNumber,  '    +NL+
            ' SHP.PackageIDCode                      AS PackageIDCode,  '           +NL+
            ' SHP.PayorAccountNumber                 AS PayorAccountNumber,  '      +NL+
            ' SHP.PayorCountryCode                   AS PayorCountryCode,  '        +NL+
            ' SHP.PayorType                          AS PayorType,  '               +NL+
            ' SHP.PayorZipCode                       AS PayorZipCode,  '            +NL+
            ' SHP.Provider                           AS Provider,  '                +NL+
            ' SHP.PostageProvider                    AS PostageProvider,  '         +NL+
            ' SHP.RecipientFirstName                 AS RecipientFirstName,  '      +NL+
            ' SHP.RecipientMiddleInitial             AS RecipientMiddleInitial,  '  +NL+
            ' SHP.RecipientLastName                  AS RecipientLastName,  '       +NL+
            ' SHP.RecipientCompany                   AS RecipientCompany,  '        +NL+
            ' SHP.RecipientAddress1                  AS RecipientAddress1,  '       +NL+
            ' SHP.RecipientAddress2                  AS RecipientAddress2,  '       +NL+
            ' SHP.RecipientCity                      AS RecipientCity,  '           +NL+
            ' SHP.RecipientState                     AS RecipientState,  '          +NL+
            ' SHP.RecipientZipCode                   AS RecipientZipCode,  '        +NL+
            ' SHP.RecipientCountryCode               AS RecipientCountryCode,  '    +NL+
            ' SHP.RecipientEmail                     AS RecipientEmail,  '          +NL+
            ' SHP.RecipientPhone                     AS RecipientPhone,  '          +NL+
            ' SHP.RecipientFax                       AS RecipientFax,  '            +NL+
            ' SHP.RecipientAddressValid              AS RecipientAddressValid,  '   +NL+
            ' SHP.SenderFirstName                    AS SenderFirstName,  '         +NL+
            ' SHP.SenderMiddleInitial                AS SenderMiddleInitial,  '     +NL+
            ' SHP.SenderLastName                     AS SenderLastName,  '          +NL+
            ' SHP.SenderCompany                      AS SenderCompany,  '           +NL+
            ' SHP.SenderAddress1                     AS SenderAddress1,  '          +NL+
            ' SHP.SenderAddress2                     AS SenderAddress2,  '          +NL+
            ' SHP.SenderCity                         AS SenderCity,  '              +NL+
            ' SHP.SenderState                        AS SenderState,  '             +NL+
            ' SHP.SenderZipCode                      AS SenderZipCode,  '           +NL+
            ' SHP.SenderCountryCode                  AS SenderCountryCode,  '       +NL+
            ' SHP.SenderEmail                        AS SenderEmail,  '             +NL+
            ' SHP.SenderPhone                        AS SenderPhone,  '             +NL+
            ' SHP.SenderFax                          AS SenderFax,  '               +NL+
            ' SHP.ServiceType                        AS ServiceType,  '             +NL+
            ' SHP.ShipDate                           AS ShipDate,  '                +NL+
            ' SHP.DeliveryData                       AS DeliveryData,  '            +NL+
            ' SHP.ShipmentSpecialServices            AS ShipmentSpecialServices,  ' +NL+
            ' SHP.TotalNetCharge                     AS TotalNetCharge,  '          +NL+
            ' SHP.TotalBaseCharge                    AS TotalBaseCharge,  '         +NL+
            ' SHP.TotalSurcharges                    AS TotalSurcharges,  '         +NL+
            ' SHP.TotalNetChargeNegotiated           AS TotalNetChargeNegotiated,  '+NL+
            ' SHP.MICostCenter                       AS MICostCenter,  '            +NL+
            ' SHP.MIPackageID                        AS MIPackageID,  '             +NL+
            ' SHP.BookingNumber                      AS BookingNumber,  '           +NL+
            ' SHP.Endorsement                        AS Endorsement,  '             +NL+
            ' SHP.DropoffType                        AS DropoffType,  '             +NL+
            ' SHP.Processed                          AS Processed,  '               +NL+
            ' SHP.ProcessedComment                   AS ProcessedComment,  '        +NL+
            ' SHP.DocumentsOnly                      AS DocumentsOnly,  '           +NL+
            ' SHP.Active                             AS ShipmentActive,  '          +NL+
            ' SPML.SaleType                          AS SaleType,  '                +NL+
            ' SPML.SaleRefNo                         AS SaleRefNo,  '               +NL+
            ' SPML.DateCreated                       AS DateCreated,  '             +NL+
            ' SPML.EmployeeName                      AS EmployeeName,  '            +NL+
            ' SPML.Active                            AS ShiplistActive,  '          +NL+
            ' SPML.Status                            AS STATUS,  '                  +NL+
            ' TSSL.UOMQty                            AS ShipQty,  '                 +NL+
            ' EBST.TransactionID							       AS TransactionID, '            +NL+
            ' EBST.OrderLineItemID						       AS OrderLineItemID, '          +NL+
            ' EBSTI.ItemID									         AS ItemID, '                   +NL+
            ' EBSTI.SKU   									         AS SKU, '                      +NL+
            ' EBSTI.ListingType 						         AS ListingType '               +NL+
            ' FROM tblSales S  ' +NL+
            ' INNER JOIN tblebay_orders       EBS  ON S.saleId = EBS.SalesOrderId  and S.IsSalesOrder= "T" AND (S.IsCashSale="F" OR S.IsLayByTOS= "T")  '+NL+
            ' INNER JOIN tblebay_orders_trans EBST ON EBS.ID = EBST.OrderID ' +NL+
            ' INNER JOIN tblebay_orders_trans_item EBSTI ON EBST.ID = EBSTI.Orders_Trans_Id ' +NL+
            ' INNER JOIN tblshipmentlist      SPML ON S.saleId =  SPML.SaleID  ' +NL+
            ' INNER JOIN tblShipment	        SHP	 ON SPML.ShipmentListId=SHP.shipmentListID  ' +NL+
            ' INNER JOIN tblshipmentsaleline  TSSL ON SHP.ShipmentId = TSSL.ShipmentId AND TSSL.UOMQty<>0  ' +NL+
            ' Where s.quotestatus <> "Complete"   ' +
            ' AND S.quotestatus <> "Cancelled"    ' +NL+
            ' and  s.deleted ="F"    ' +NL+
            ' AND (SPML.mstimestamp >= :DateFrom OR TSSL.mstimestamp >= :DateFrom )' +NL+
            ' ORDER BY if (SHP.mstimestamp<TSSL.mstimestamp , SHP.mstimestamp , TSSL.mstimestamp ) ';

end;
End.
