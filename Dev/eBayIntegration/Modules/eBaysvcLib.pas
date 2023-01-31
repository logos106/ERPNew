Unit eBaysvcLib;

Interface

Uses Typinfo, Classes, Ebaysvc, XSBuiltIns, XMLdoc, XmlIntf;
{enumToStr}
Function enumToStr(Const Value: SMSSubscriptionUserStatusCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerShippedStatusCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerSearchTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerPaidStatusCodeType): String; Overload;
Function enumToStr(Const Value: CheckoutStatusCodeType): String; Overload;
Function enumToStr(Const Value: WirelessCarrierIDCodeType): String; Overload;
Function enumToStr(Const Value: RequiredSellerActionCodeType): String; Overload;
Function enumToStr(Const Value: SMSSubscriptionErrorCodeCodeType): String; Overload;
Function enumToStr(Const Value: UnpaidItemStatusTypeCodeType): String; Overload;
Function enumToStr(Const Value: ShippingRateTypeCodeType): String; Overload;
Function enumToStr(Const Value: ShippingTypeCodeType): String; Overload;
Function enumToStr(Const Value: ShippingCarrierCodeType): String; Overload;
Function enumToStr(Const Value: ShippingServiceCodeType): String; Overload;
Function enumToStr(Const Value: ShipmentDeliveryStatusCodeType): String; Overload;
Function enumToStr(Const Value: ShipmentStatusCodeType): String; Overload;
Function enumToStr(Const Value: ShippingFeatureCodeType): String; Overload;
Function enumToStr(Const Value: MerchandizingPrefCodeType): String; Overload;
Function enumToStr(Const Value: SellerGuaranteeLevelCodeType): String; Overload;
Function enumToStr(Const Value: PayoutMethodType): String; Overload;
Function enumToStr(Const Value: SellereBayPaymentProcessStatusCodeType): String; Overload;
//Function enumToStr(Const Value: PaymentTypeCodeType): String; Overload;
Function enumToStr(Const Value: FedExRateOptionCodeType): String; Overload;
Function enumToStr(Const Value: USPSRateOptionCodeType): String; Overload;
Function enumToStr(Const Value: UPSRateOptionCodeType): String; Overload;
Function enumToStr(Const Value: DisplayPayNowButtonCodeType): String; Overload;
Function enumToStr(Const Value: StoreItemListSortOrderCodeType): String; Overload;
Function enumToStr(Const Value: SearchStandingStatusCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerAutoRelistOptionCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerAutoRelistTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellerAccountStatusCodeType): String; Overload;
//Function enumToStr(Const Value: RangeCodeType): String; Overload;
//Function enumToStr(Const Value: DateSpecifierCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerEmailSentStatusCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerAutoSecondChanceOfferTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerEmailTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerAutomationPropertyTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerPaisaPayPropertyTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerAlertTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerGeneralPropertyTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellerDashboardAlertSeverityCodeType): String; Overload;
Function enumToStr(Const Value: DayOfWeekCodeType): String; Overload;
Function enumToStr(Const Value: ShippingRegionCodeType): String; Overload;
Function enumToStr(Const Value: EBaySubscriptionTypeCodeType): String; Overload;
Function enumToStr(Const Value: VeROItemStatusCodeType): String; Overload;
Function enumToStr(Const Value: MismatchTypeCodeType): String; Overload;
Function enumToStr(Const Value: PayPalAccountStatusCodeType): String; Overload;
Function enumToStr(Const Value: StoreSubscriptionLevelCodeType): String; Overload;
Function enumToStr(Const Value: StoreFontSizeCodeType): String; Overload;
Function enumToStr(Const Value: MerchDisplayCodeType): String; Overload;
Function enumToStr(Const Value: StoreCustomHeaderLayoutCodeType): String; Overload;
Function enumToStr(Const Value: StoreHeaderStyleCodeType): String; Overload;
Function enumToStr(Const Value: StoreItemListLayoutCodeType): String; Overload;
Function enumToStr(Const Value: StoreFontFaceCodeType): String; Overload;
Function enumToStr(Const Value: PictureFormatCodeType): String; Overload;
Function enumToStr(Const Value: StoreCustomListingHeaderDisplayCodeType): String; Overload;
Function enumToStr(Const Value: StoreCustomPageStatusCodeType): String; Overload;
Function enumToStr(Const Value: StoreCustomListingHeaderLinkCodeType): String; Overload;
Function enumToStr(Const Value: SummaryWindowPeriodCodeType): String; Overload;
Function enumToStr(Const Value: UnpaidItemCaseOpenTypeCodeType): String; Overload;
Function enumToStr(Const Value: UserIdentityCodeType): String; Overload;
Function enumToStr(Const Value: UnpaidItemCaseStatusTypeCodeType): String; Overload;
Function enumToStr(Const Value: URLTypeCodeType): String; Overload;
Function enumToStr(Const Value: FeedbackRatingStarCodeType): String; Overload;
Function enumToStr(Const Value: PayPalAccountLevelCodeType): String; Overload;
Function enumToStr(Const Value: PayPalAccountTypeCodeType): String; Overload;
Function enumToStr(Const Value: BusinessRoleType): String; Overload;
Function enumToStr(Const Value: UserStatusCodeType): String; Overload;
Function enumToStr(Const Value: VATStatusCodeType): String; Overload;
Function enumToStr(Const Value: TaxTypeCodeType): String; Overload;
Function enumToStr(Const Value: TaxDescriptionCodeType): String; Overload;
Function enumToStr(Const Value: SummaryFrequencyCodeType): String; Overload;
Function enumToStr(Const Value: PaidStatusCodeType): String; Overload;
Function enumToStr(Const Value: TransactionReferenceCodeType): String; Overload;
Function enumToStr(Const Value: TokenStatusCodeType): String; Overload;
Function enumToStr(Const Value: TopRatedProgramCodeType): String; Overload;
Function enumToStr(Const Value: ReasonHideFromSearchCodeType): String; Overload;
Function enumToStr(Const Value: BoldTitleCodeType): String; Overload;
Function enumToStr(Const Value: BorderCodeType): String; Overload;
Function enumToStr(Const Value: HighlightCodeType): String; Overload;
Function enumToStr(Const Value: SellerBusinessCodeType): String; Overload;
//Function enumToStr(Const Value: SkypeContactOptionCodeType): String; Overload;
Function enumToStr(Const Value: QuantityAvailableHintCodeType): String; Overload;
Function enumToStr(Const Value: ListingSubtypeCodeType): String; Overload;
Function enumToStr(Const Value: GiftIconCodeType): String; Overload;
Function enumToStr(Const Value: PeriodCodeType): String; Overload;
Function enumToStr(Const Value: QuestionTypeCodeType): String; Overload;
Function enumToStr(Const Value: ProPackCodeType): String; Overload;
Function enumToStr(Const Value: HomePageFeaturedCodeType): String; Overload;
Function enumToStr(Const Value: FeaturedFirstCodeType): String; Overload;
Function enumToStr(Const Value: FeaturedPlusCodeType): String; Overload;
Function enumToStr(Const Value: MarkUpMarkDownEventTypeCodeType): String; Overload;
Function enumToStr(Const Value: FlatRateInsuranceRangeCodeType): String; Overload;
Function enumToStr(Const Value: FlatShippingRateOptionCodeType): String; Overload;
//Function enumToStr(Const Value: ListingFlowCodeType): String; Overload;
Function enumToStr(Const Value: OrderStatusFilterCodeType): String; Overload;
Function enumToStr(Const Value: ListingEnhancementsCodeType): String; Overload;
Function enumToStr(Const Value: DescriptionReviseModeCodeType): String; Overload;
//Function enumToStr(Const Value: GiftServicesCodeType): String; Overload;
Function enumToStr(Const Value: HitCounterCodeType): String; Overload;
//Function enumToStr(Const Value: RecommendationEngineCodeType): String; Overload;
Function enumToStr(Const Value: SiteCodeType): String; Overload;
//Function enumToStr(Const Value: CharacteristicsSearchCodeType): String; Overload;
Function enumToStr(Const Value: PromotionItemSelectionCodeType): String; Overload;
Function enumToStr(Const Value: PromotionItemPriceTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellerLevelCodeType): String; Overload;
Function enumToStr(Const Value: GalleryStatusCodeType): String; Overload;
//Function enumToStr(Const Value: PictureManagerSubscriptionLevelCodeType): String; Overload;
Function enumToStr(Const Value: GalleryTypeCodeType): String; Overload;
Function enumToStr(Const Value: PhotoDisplayCodeType): String; Overload;
Function enumToStr(Const Value: PictureSourceCodeType): String; Overload;
Function enumToStr(Const Value: PolicyComplianceStatusCodeType): String; Overload;
//Function enumToStr(Const Value: PictureManagerPictureDisplayTypeCodeType): String; Overload;
Function enumToStr(Const Value: RefundingSourceTypeCodeType): String; Overload;
Function enumToStr(Const Value: RefundFailureCodeType): String; Overload;
Function enumToStr(Const Value: RefundStatusCodeType): String; Overload;
Function enumToStr(Const Value: StatusCodeType): String; Overload;
Function enumToStr(Const Value: RefundLineTypeCodeType): String; Overload;
Function enumToStr(Const Value: ValueTypeCodeType): String; Overload;
Function enumToStr(Const Value: DiscountCodeType): String; Overload;
Function enumToStr(Const Value: PromotionalSaleTypeCodeType): String; Overload;
Function enumToStr(Const Value: ValueFormatCodeType): String; Overload;
Function enumToStr(Const Value: SelectionModeCodeType): String; Overload;
Function enumToStr(Const Value: VariationPictureRuleCodeType): String; Overload;
Function enumToStr(Const Value: VariationSpecificsRuleCodeType): String; Overload;
Function enumToStr(Const Value: PaymentMethodSearchCodeType): String; Overload;
Function enumToStr(Const Value: PreferredLocationCodeType): String; Overload;
Function enumToStr(Const Value: ItemConditionCodeType): String; Overload;
Function enumToStr(Const Value: SimpleItemSortCodeType): String; Overload;
Function enumToStr(Const Value: ItemTypeCodeType): String; Overload;
Function enumToStr(Const Value: SearchFlagCodeType): String; Overload;
Function enumToStr(Const Value: ItemSpecificSourceCodeType): String; Overload;
Function enumToStr(Const Value: QuantityOperatorCodeType): String; Overload;
Function enumToStr(Const Value: MyMessagesAlertResolutionStatusCode): String; Overload;
Function enumToStr(Const Value: DepositTypeCodeType): String; Overload;
Function enumToStr(Const Value: PaymentHoldStatusCodeType): String; Overload;
Function enumToStr(Const Value: PerformanceStatusCodeType): String; Overload;
Function enumToStr(Const Value: PaymentHoldReasonCodeType): String; Overload;
Function enumToStr(Const Value: NotificationEventStateCodeType): String; Overload;
Function enumToStr(Const Value: NotificationEventPropertyNameCodeType): String; Overload;
Function enumToStr(Const Value: AddressTypeCodeType): String; Overload;
Function enumToStr(Const Value: NotificationEventTypeCodeType): String; Overload;
Function enumToStr(Const Value: BidActionCodeType): String; Overload;
//Function enumToStr(Const Value: ProductUseCaseCodeType): String; Overload;
//Function enumToStr(Const Value: PictureManagerDetailLevelCodeType): String; Overload;
Function enumToStr(Const Value: RCSPaymentStatusCodeType): String; Overload;
Function enumToStr(Const Value: PromotionalSaleStatusCodeType): String; Overload;
Function enumToStr(Const Value: MessageTypeCodeType): String; Overload;
Function enumToStr(Const Value: OrderStatusCodeType): String; Overload;
Function enumToStr(Const Value: SortOrderCodeType): String; Overload;
Function enumToStr(Const Value: NotificationRoleCodeType): String; Overload;
Function enumToStr(Const Value: DisputeFilterTypeCodeType): String; Overload;
Function enumToStr(Const Value: DisputeSortTypeCodeType): String; Overload;
Function enumToStr(Const Value: VeROReportPacketStatusCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerSoldListingsPropertyTypeCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerSoldListingsSortTypeCodeType): String; Overload;
Function enumToStr(Const Value: InventoryTrackingMethodCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerProductSortCodeType): String; Overload;
Function enumToStr(Const Value: SellingManagerInventoryPropertyTypeCodeType): String; Overload;
Function enumToStr(Const Value: CombinedPaymentPeriodCodeType): String; Overload;
Function enumToStr(Const Value: TaskStatusCodeType): String; Overload;
Function enumToStr(Const Value: ListingTypeCodeType): String; Overload;
Function enumToStr(Const Value: RecipientRelationCodeType): String; Overload;
Function enumToStr(Const Value: EndReasonCodeType): String; Overload;
Function enumToStr(Const Value: DiscountReasonCodeType): String; Overload;
Function enumToStr(Const Value: DisputeReasonCodeType): String; Overload;
Function enumToStr(Const Value: DisputeExplanationCodeType): String; Overload;
Function enumToStr(Const Value: DisputeActivityCodeType): String; Overload;
Function enumToStr(Const Value: SecondChanceOfferDurationCodeType): String; Overload;
Function enumToStr(Const Value: TradingRoleCodeType): String; Overload;
Function enumToStr(Const Value: PromotionMethodCodeType): String; Overload;
Function enumToStr(Const Value: StringMatchCodeType): String; Overload;
Function enumToStr(Const Value: CountryCodeType): String; Overload;
Function enumToStr(Const Value: TransactionPlatformCodeType): String; Overload;
Function enumToStr(Const Value: ItemSortTypeCodeType): String; Overload;
Function enumToStr(Const Value: CommentTypeCodeType): String; Overload;
Function enumToStr(Const Value: FeedbackTypeCodeType): String; Overload;
Function enumToStr(Const Value: ListingStatusCodeType): String; Overload;
Function enumToStr(Const Value: GetAllBiddersModeCodeType): String; Overload;
Function enumToStr(Const Value: CurrencyCodeType): String; Overload;
Function enumToStr(Const Value: AccountHistorySelectionCodeType): String; Overload;
Function enumToStr(Const Value: AccountEntrySortTypeCodeType): String; Overload;
Function enumToStr(Const Value: MessageStatusTypeCodeType): String; Overload;
Function enumToStr(Const Value: FeatureIDCodeType): String; Overload;
Function enumToStr(Const Value: GranularityLevelCodeType): String; Overload;
Function enumToStr(Const Value: BestOfferStatusCodeType): String; Overload;
Function enumToStr(Const Value: ProductCreationEnabledCodeType): String; Overload;
Function enumToStr(Const Value: PaymentOptionsGroupEnabledCodeType): String; Overload;
Function enumToStr(Const Value: ProfileCategoryGroupCodeType): String; Overload;
Function enumToStr(Const Value: CharityAffiliationTypeCodeType): String; Overload;
Function enumToStr(Const Value: ClassifiedAdBestOfferEnabledCodeType): String; Overload;
Function enumToStr(Const Value: ItemSpecificsEnabledCodeType): String; Overload;
Function enumToStr(Const Value: AdFormatEnabledCodeType): String; Overload;
Function enumToStr(Const Value: ClassifiedAdPaymentMethodEnabledCodeType): String; Overload;
Function enumToStr(Const Value: GeographicExposureCodeType): String; Overload;
Function enumToStr(Const Value: ItemCompatibilityEnabledCodeType): String; Overload;
Function enumToStr(Const Value: ConditionEnabledCodeType): String; Overload;
Function enumToStr(Const Value: INEscrowWorkflowTimelineCodeType): String; Overload;
Function enumToStr(Const Value: AttributeConversionEnabledCodeType): String; Overload;
Function enumToStr(Const Value: CombinedPaymentOptionCodeType): String; Overload;
Function enumToStr(Const Value: SocialAddressTypeCodeType): String; Overload;
Function enumToStr(Const Value: CharityStatusCodeType): String; Overload;
Function enumToStr(Const Value: PaymentStatusCodeType): String; Overload;
Function enumToStr(Const Value: BestOfferTypeCodeType): String; Overload;
Function enumToStr(Const Value: BidGroupItemStatusCodeType): String; Overload;
Function enumToStr(Const Value: BidGroupStatusCodeType): String; Overload;
Function enumToStr(Const Value: FeedbackRatingDetailCodeType): String; Overload;
Function enumToStr(Const Value: FeedbackSummaryPeriodCodeType): String; Overload;
Function enumToStr(Const Value: HandlingNameCodeType): String; Overload;
Function enumToStr(Const Value: DiscountNameCodeType): String; Overload;
Function enumToStr(Const Value: BuyerSatisfactionStatusCodeType): String; Overload;
Function enumToStr(Const Value: ShippingPackageCodeType): String; Overload;
//Function enumToStr(Const Value: ProductStateCodeType): String; Overload;
Function enumToStr(Const Value: CalculatedShippingChargeOptionCodeType): String; Overload;
Function enumToStr(Const Value: CalculatedShippingRateOptionCodeType): String; Overload;
Function enumToStr(Const Value: BuyerProtectionSourceCodeType): String; Overload;
Function enumToStr(Const Value: BuyerProtectionCodeType): String; Overload;
Function enumToStr(Const Value: PricingTreatmentCodeType): String; Overload;
Function enumToStr(Const Value: DisputeRecordTypeCodeType): String; Overload;
Function enumToStr(Const Value: DisputeStateCodeType): String; Overload;
Function enumToStr(Const Value: DescriptionTemplateCodeType): String; Overload;
Function enumToStr(Const Value: MinimumAdvertisedPriceExposureCodeType): String; Overload;
Function enumToStr(Const Value: DisputeStatusCodeType): String; Overload;
Function enumToStr(Const Value: EndOfAuctionLogoTypeCodeType): String; Overload;
Function enumToStr(Const Value: DisputeCreditEligibilityCodeType): String; Overload;
Function enumToStr(Const Value: DaysCodeType): String; Overload;
Function enumToStr(Const Value: PromotionSchemeCodeType): String; Overload;
Function enumToStr(Const Value: ItemFormatSortFilterCodeType): String; Overload;
Function enumToStr(Const Value: GallerySortFilterCodeType): String; Overload;
Function enumToStr(Const Value: ItemSortFilterCodeType): String; Overload;
Function enumToStr(Const Value: PaymentTransactionStatusCodeType): String; Overload;
//Function enumToStr(Const Value: ExternalProductCodeType): String; Overload;
Function enumToStr(Const Value: MyMessagesFolderOperationCodeType): String; Overload;
Function enumToStr(Const Value: FeedbackResponseCodeType): String; Overload;
Function enumToStr(Const Value: BuyerPaymentMethodCodeType): String; Overload;
Function enumToStr(Const Value: InsuranceSelectedCodeType): String; Overload;
Function enumToStr(Const Value: CompleteStatusCodeType): String; Overload;
Function enumToStr(Const Value: CheckoutMethodCodeType): String; Overload;
Function enumToStr(Const Value: InsuranceOptionCodeType): String; Overload;
//Function enumToStr(Const Value: PictureManagerActionCodeType): String; Overload;
Function enumToStr(Const Value: DisputeResolutionReasonCodeType): String; Overload;
Function enumToStr(Const Value: DetailNameCodeType): String; Overload;
Function enumToStr(Const Value: BestOfferActionCodeType): String; Overload;
//Function enumToStr(Const Value: RefundReasonCodeType): String; Overload;
//Function enumToStr(Const Value: RefundTypeCodeType): String; Overload;
Function enumToStr(Const Value: DisputeMessageSourceCodeType): String; Overload;
Function enumToStr(Const Value: SeverityCodeType): String; Overload;
Function enumToStr(Const Value: ErrorClassificationCodeType): String; Overload;
Function enumToStr(Const Value: DisputeResolutionRecordTypeCodeType): String; Overload;
Function enumToStr(Const Value: InvocationStatusType): String; Overload;
Function enumToStr(Const Value: DetailLevelCodeType): String; Overload;
Function enumToStr(Const Value: AckCodeType): String; Overload;
Function enumToStr(Const Value: ErrorHandlingCodeType): String; Overload;
Function enumToStr(Const Value: WarningLevelCodeType): String; Overload;
Function enumToStr(Const Value: AnnouncementMessageCodeType): String; Overload;
Function enumToStr(Const Value: AccessRuleCurrentStatusCodeType): String; Overload;
Function enumToStr(Const Value: AccessRuleStatusCodeType): String; Overload;
Function enumToStr(Const Value: AddressUsageCodeType): String; Overload;
Function enumToStr(Const Value: ApplicationDeviceTypeCodeType): String; Overload;
Function enumToStr(Const Value: EnableCodeType): String; Overload;
Function enumToStr(Const Value: NotificationPayloadTypeCodeType): String; Overload;
Function enumToStr(Const Value: DeviceTypeCodeType): String; Overload;
Function enumToStr(Const Value: AccountDetailEntryCodeType): String; Overload;
Function enumToStr(Const Value: AccountStateCodeType): String; Overload;
Function enumToStr(Const Value: MeasurementSystemCodeType): String; Overload;
Function enumToStr(Const Value: SellerPaymentMethodCodeType): String; Overload;
Function enumToStr(Const Value: AddressOwnerCodeType): String; Overload;
Function enumToStr(Const Value: AddressStatusCodeType): String; Overload;
Function enumToStr(Const Value: AddressRecordTypeCodeType): String; Overload;
Function enumToStr(Const Value: AdFormatLeadStatusCodeType): String; Overload;
Function enumToStr(Const Value: StoreCategoryUpdateActionCodeType): String; Overload;
Function enumToStr(Const Value: ModifyActionCodeType): String; Overload;
Function enumToStr(Const Value: AutomatedLeaveFeedbackEventCodeType): String; Overload;
Function enumToStr(Const Value: SetUserNotesActionCodeType): String; Overload;
Function enumToStr(Const Value: PictureUploadPolicyCodeType): String; Overload;
Function enumToStr(Const Value: PictureWatermarkCodeType): String; Overload;
Function enumToStr(Const Value: PictureSetCodeType): String; Overload;
{StrToEnum}
Procedure StrToEnum(Const Value: String; Var Data : SMSSubscriptionUserStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerShippedStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerSearchTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerPaidStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CheckoutStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : WirelessCarrierIDCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : RequiredSellerActionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SMSSubscriptionErrorCodeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : UnpaidItemStatusTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShippingRateTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShippingTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShippingCarrierCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShippingServiceCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShipmentDeliveryStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShipmentStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShippingFeatureCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MerchandizingPrefCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellerGuaranteeLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PayoutMethodType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellereBayPaymentProcessStatusCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : PaymentTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FedExRateOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : USPSRateOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : UPSRateOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisplayPayNowButtonCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreItemListSortOrderCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SearchStandingStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerAutoRelistOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerAutoRelistTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellerAccountStatusCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : RangeCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : DateSpecifierCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerEmailSentStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerAutoSecondChanceOfferTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerEmailTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerAutomationPropertyTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerPaisaPayPropertyTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerAlertTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerGeneralPropertyTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellerDashboardAlertSeverityCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DayOfWeekCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShippingRegionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : EBaySubscriptionTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : VeROItemStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MismatchTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PayPalAccountStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreSubscriptionLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreFontSizeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MerchDisplayCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreCustomHeaderLayoutCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreHeaderStyleCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreItemListLayoutCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreFontFaceCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PictureFormatCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreCustomListingHeaderDisplayCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreCustomPageStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreCustomListingHeaderLinkCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SummaryWindowPeriodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : UnpaidItemCaseOpenTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : UserIdentityCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : UnpaidItemCaseStatusTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : URLTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeedbackRatingStarCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PayPalAccountLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PayPalAccountTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BusinessRoleType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : UserStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : VATStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TaxTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TaxDescriptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SummaryFrequencyCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PaidStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TransactionReferenceCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TokenStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TopRatedProgramCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ReasonHideFromSearchCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BoldTitleCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BorderCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : HighlightCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellerBusinessCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : SkypeContactOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : QuantityAvailableHintCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ListingSubtypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : GiftIconCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PeriodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : QuestionTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ProPackCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : HomePageFeaturedCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeaturedFirstCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeaturedPlusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MarkUpMarkDownEventTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FlatRateInsuranceRangeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FlatShippingRateOptionCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : ListingFlowCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : OrderStatusFilterCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ListingEnhancementsCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DescriptionReviseModeCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : GiftServicesCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : HitCounterCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : RecommendationEngineCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SiteCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : CharacteristicsSearchCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PromotionItemSelectionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PromotionItemPriceTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellerLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : GalleryStatusCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : PictureManagerSubscriptionLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : GalleryTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PhotoDisplayCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PictureSourceCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PolicyComplianceStatusCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : PictureManagerPictureDisplayTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : RefundingSourceTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : RefundFailureCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : RefundStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : RefundLineTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ValueTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DiscountCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PromotionalSaleTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ValueFormatCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SelectionModeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : VariationPictureRuleCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : VariationSpecificsRuleCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PaymentMethodSearchCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PreferredLocationCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemConditionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SimpleItemSortCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SearchFlagCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemSpecificSourceCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : QuantityOperatorCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MyMessagesAlertResolutionStatusCode); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DepositTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PaymentHoldStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PerformanceStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PaymentHoldReasonCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : NotificationEventStateCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : NotificationEventPropertyNameCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AddressTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : NotificationEventTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BidActionCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : ProductUseCaseCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : PictureManagerDetailLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : RCSPaymentStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PromotionalSaleStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MessageTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : OrderStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SortOrderCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : NotificationRoleCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeFilterTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeSortTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : VeROReportPacketStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerSoldListingsPropertyTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerSoldListingsSortTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : InventoryTrackingMethodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerProductSortCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellingManagerInventoryPropertyTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CombinedPaymentPeriodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TaskStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ListingTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : RecipientRelationCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : EndReasonCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DiscountReasonCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeReasonCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeExplanationCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeActivityCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SecondChanceOfferDurationCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TradingRoleCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PromotionMethodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StringMatchCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CountryCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : TransactionPlatformCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemSortTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CommentTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeedbackTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ListingStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : GetAllBiddersModeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CurrencyCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AccountHistorySelectionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AccountEntrySortTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MessageStatusTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeatureIDCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : GranularityLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BestOfferStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ProductCreationEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PaymentOptionsGroupEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ProfileCategoryGroupCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CharityAffiliationTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ClassifiedAdBestOfferEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemSpecificsEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AdFormatEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ClassifiedAdPaymentMethodEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : GeographicExposureCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemCompatibilityEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ConditionEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : INEscrowWorkflowTimelineCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AttributeConversionEnabledCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CombinedPaymentOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SocialAddressTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CharityStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PaymentStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BestOfferTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BidGroupItemStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BidGroupStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeedbackRatingDetailCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeedbackSummaryPeriodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : HandlingNameCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DiscountNameCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BuyerSatisfactionStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ShippingPackageCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : ProductStateCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CalculatedShippingChargeOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CalculatedShippingRateOptionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BuyerProtectionSourceCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BuyerProtectionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PricingTreatmentCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeRecordTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeStateCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DescriptionTemplateCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MinimumAdvertisedPriceExposureCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : EndOfAuctionLogoTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeCreditEligibilityCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DaysCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PromotionSchemeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemFormatSortFilterCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : GallerySortFilterCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ItemSortFilterCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PaymentTransactionStatusCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : ExternalProductCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MyMessagesFolderOperationCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : FeedbackResponseCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BuyerPaymentMethodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : InsuranceSelectedCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CompleteStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : CheckoutMethodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : InsuranceOptionCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : PictureManagerActionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeResolutionReasonCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DetailNameCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : BestOfferActionCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : RefundReasonCodeType); Overload;
//Procedure StrToEnum(Const Value: String; Var Data : RefundTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeMessageSourceCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SeverityCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ErrorClassificationCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DisputeResolutionRecordTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : InvocationStatusType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DetailLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AckCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ErrorHandlingCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : WarningLevelCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AnnouncementMessageCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AccessRuleCurrentStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AccessRuleStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AddressUsageCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ApplicationDeviceTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : EnableCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : NotificationPayloadTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : DeviceTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AccountDetailEntryCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AccountStateCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : MeasurementSystemCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SellerPaymentMethodCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AddressOwnerCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AddressStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AddressRecordTypeCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AdFormatLeadStatusCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : StoreCategoryUpdateActionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : ModifyActionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : AutomatedLeaveFeedbackEventCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : SetUserNotesActionCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PictureUploadPolicyCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PictureWatermarkCodeType); Overload;
Procedure StrToEnum(Const Value: String; Var Data : PictureSetCodeType); Overload;

function ProviderTypeToStr(aProvider: Integer): string;

Implementation
{enumToStr}
Function enumToStr(Const Value: SMSSubscriptionUserStatusCodeType): String;
Begin
       If Value =SMSSubscriptionUserStatusCodeType.Registered Then Result        := 'Registered'
  Else If Value = SMSSubscriptionUserStatusCodeType.Unregistered  Then Result :=  'Unregistered'
  Else If Value = SMSSubscriptionUserStatusCodeType.Pending Then Result      := 'Pending'
  Else If Value = SMSSubscriptionUserStatusCodeType.Failed Then Result       := 'Failed'
  Else Result                                                                := '';
End;

Function enumToStr(Const Value: SellingManagerShippedStatusCodeType): String;
Begin
       If Value =SellingManagerShippedStatusCodeType.Shipped Then Result        := 'Shipped'
  Else If Value = SellingManagerShippedStatusCodeType.Unshipped  Then Result :=  'Unshipped'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: SellingManagerSearchTypeCodeType): String;
Begin
       If Value =SellingManagerSearchTypeCodeType.BuyerUserID Then Result        := 'BuyerUserID'
  Else If Value = SellingManagerSearchTypeCodeType.BuyerEmail Then Result    := 'BuyerEmail'
  Else If Value = SellingManagerSearchTypeCodeType.BuyerFullName  Then Result :=  'BuyerFullName'
  Else If Value = SellingManagerSearchTypeCodeType.ItemID Then Result        := 'ItemID'
  Else If Value = SellingManagerSearchTypeCodeType.Title Then Result         := 'Title'
  Else If Value = SellingManagerSearchTypeCodeType.ProductID Then Result     := 'ProductID'
  Else If Value = SellingManagerSearchTypeCodeType.ProductName Then Result   := 'ProductName'
  Else If Value = SellingManagerSearchTypeCodeType.CustomLabel Then Result   := 'CustomLabel'
  Else If Value = SellingManagerSearchTypeCodeType.SaleRecordID Then Result  := 'SaleRecordID'
  Else Result                                                                := '';
End;

Function enumToStr(Const Value: SellingManagerPaidStatusCodeType): String;
Begin
       If Value =SellingManagerPaidStatusCodeType.Paid Then Result               := 'Paid'
  Else If Value = SellingManagerPaidStatusCodeType.PartiallyPaid  Then Result :=  'PartiallyPaid'
  Else If Value = SellingManagerPaidStatusCodeType.Unpaid Then Result        := 'Unpaid'
  Else If Value = SellingManagerPaidStatusCodeType.Pending Then Result       := 'Pending'
  Else If Value = SellingManagerPaidStatusCodeType.Refunded Then Result      := 'Refunded'
  Else Result                                                                := '';
End;

Function enumToStr(Const Value: CheckoutStatusCodeType): String;
Begin
       If Value =CheckoutStatusCodeType.CheckoutComplete Then Result        := 'CheckoutComplete'
  Else If Value = CheckoutStatusCodeType.CheckoutIncomplete  Then Result :=  'CheckoutIncomplete'
  Else If Value = CheckoutStatusCodeType.BuyerRequestsTotal  Then Result :=  'BuyerRequestsTotal'
  Else If Value = CheckoutStatusCodeType.SellerResponded Then Result    := 'SellerResponded'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: WirelessCarrierIDCodeType): String;
Begin
       If Value =WirelessCarrierIDCodeType.Cingular Then Result            := 'Cingular'
  Else If Value = WirelessCarrierIDCodeType.TMobile Then Result        := 'TMobile'
  Else If Value = WirelessCarrierIDCodeType.Sprint Then Result         := 'Sprint'
  Else If Value = WirelessCarrierIDCodeType.Nextel Then Result         := 'Nextel'
  Else If Value = WirelessCarrierIDCodeType.Verizon Then Result        := 'Verizon'
  Else If Value = WirelessCarrierIDCodeType.CincinnatiBell  Then Result :=  'CincinnatiBell'
  Else If Value = WirelessCarrierIDCodeType.Dobson Then Result         := 'Dobson'
  Else If Value = WirelessCarrierIDCodeType.Alltel Then Result         := 'Alltel'
  Else If Value = WirelessCarrierIDCodeType.Leap Then Result           := 'Leap'
  Else If Value = WirelessCarrierIDCodeType.USCellular Then Result     := 'USCellular'
  Else If Value = WirelessCarrierIDCodeType.Movistar Then Result       := 'Movistar'
  Else If Value = WirelessCarrierIDCodeType.Amena Then Result          := 'Amena'
  Else If Value = WirelessCarrierIDCodeType.Vodafone Then Result       := 'Vodafone'
  Else If Value = WirelessCarrierIDCodeType.ATT Then Result            := 'ATT'
  Else If Value = WirelessCarrierIDCodeType.CustomCode Then Result     := 'CustomCode'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: RequiredSellerActionCodeType): String;
Begin
       If Value =RequiredSellerActionCodeType.ResolveeBPCase Then Result               := 'ResolveeBPCase'
  Else If Value = RequiredSellerActionCodeType.MarkAsShipped Then Result           := 'MarkAsShipped'
  Else If Value = RequiredSellerActionCodeType.ContacteBayCS Then Result           := 'ContacteBayCS'
  Else If Value = RequiredSellerActionCodeType.ResolvePPPIcase Then Result         := 'ResolvePPPIcase'
  Else If Value = RequiredSellerActionCodeType.SetupPayoutMethod Then Result       := 'SetupPayoutMethod'
  Else If Value = RequiredSellerActionCodeType.UpdatePayoutMethod Then Result      := 'UpdatePayoutMethod'
  Else If Value = RequiredSellerActionCodeType.None Then Result                    := 'None'
  Else If Value = RequiredSellerActionCodeType.UploadTrackingInfo Then Result      := 'UploadTrackingInfo'
  Else If Value = RequiredSellerActionCodeType.ResolveBuyerMessageInr Then Result  := 'ResolveBuyerMessageInr'
  Else If Value = RequiredSellerActionCodeType.ResolveBuyerMessageSnad  Then Result :=  'ResolveBuyerMessageSnad'
  Else If Value = RequiredSellerActionCodeType.CustomCode Then Result              := 'CustomCode'
  Else If Value = RequiredSellerActionCodeType.ResolveReturn Then Result           := 'ResolveReturn'
  Else Result                                                                      := '';
End;

Function enumToStr(Const Value: SMSSubscriptionErrorCodeCodeType): String;
Begin
       If Value =SMSSubscriptionErrorCodeCodeType.SMSAggregatorNotAvailable Then Result        := 'SMSAggregatorNotAvailable'
  Else If Value = SMSSubscriptionErrorCodeCodeType.PhoneNumberInvalid Then Result          := 'PhoneNumberInvalid'
  Else If Value = SMSSubscriptionErrorCodeCodeType.PhoneNumberChanged Then Result          := 'PhoneNumberChanged'
  Else If Value = SMSSubscriptionErrorCodeCodeType.PhoneNumberCarrierChanged Then Result   := 'PhoneNumberCarrierChanged'
  Else If Value = SMSSubscriptionErrorCodeCodeType.UserRequestedUnregistration  Then Result :=  'UserRequestedUnregistration'
  Else Result                                                                              := '';
End;

Function enumToStr(Const Value: UnpaidItemStatusTypeCodeType): String;
Begin
       If Value =UnpaidItemStatusTypeCodeType.FinalValueFeeDenied Then Result         := 'FinalValueFeeDenied'
  Else If Value = UnpaidItemStatusTypeCodeType.FinalValueFeeCredited Then Result  := 'FinalValueFeeCredited'
  Else If Value = UnpaidItemStatusTypeCodeType.FinalValueFeeEligible Then Result  := 'FinalValueFeeEligible'
  Else If Value = UnpaidItemStatusTypeCodeType.AwaitingSellerResponse  Then Result :=  'AwaitingSellerResponse'
  Else If Value = UnpaidItemStatusTypeCodeType.AwaitingBuyerResponse Then Result  := 'AwaitingBuyerResponse'
  Else If Value = UnpaidItemStatusTypeCodeType.UnpaidItemFiled Then Result        := 'UnpaidItemFiled'
  Else If Value = UnpaidItemStatusTypeCodeType.UnpaidItemEligible Then Result     := 'UnpaidItemEligible'
  Else Result                                                                     := '';
End;

Function enumToStr(Const Value: ShippingRateTypeCodeType): String;
Begin
       If Value =ShippingRateTypeCodeType.OnDemand Then Result          := 'OnDemand'
  Else If Value = ShippingRateTypeCodeType.DailyPickup Then Result  := 'DailyPickup'
  Else If Value = ShippingRateTypeCodeType.StandardList  Then Result :=  'StandardList'
  Else If Value = ShippingRateTypeCodeType.Counter Then Result      := 'Counter'
  Else If Value = ShippingRateTypeCodeType.Discounted Then Result   := 'Discounted'
  Else Result                                                       := '';
End;

Function enumToStr(Const Value: ShippingTypeCodeType): String;
Begin
       If Value =ShippingTypeCodeType.Flat Then Result                                     := 'Flat'
  Else If Value = ShippingTypeCodeType.Calculated Then Result                          := 'Calculated'
  Else If Value = ShippingTypeCodeType.Freight Then Result                             := 'Freight'
  Else If Value = ShippingTypeCodeType.Free Then Result                                := 'Free'
  Else If Value = ShippingTypeCodeType.NotSpecified Then Result                        := 'NotSpecified'
  Else If Value = ShippingTypeCodeType.FlatDomesticCalculatedInternational  Then Result := 'FlatDomesticCalculatedInternational'
  Else If Value = ShippingTypeCodeType.CalculatedDomesticFlatInternational  Then Result := 'CalculatedDomesticFlatInternational'
  Else If Value = ShippingTypeCodeType.FreightFlat Then Result                         := 'FreightFlat'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: ShippingCarrierCodeType): String;
Begin
       If Value =ShippingCarrierCodeType.UPS Then Result                              := 'UPS'
  Else If Value = ShippingCarrierCodeType.USPS Then Result                        := 'USPS'
  Else If Value = ShippingCarrierCodeType.FedEx Then Result                       := 'FedEx'
  Else If Value = ShippingCarrierCodeType.DeutschePost Then Result                := 'DeutschePost'
  Else If Value = ShippingCarrierCodeType.DHL Then Result                         := 'DHL'
  Else If Value = ShippingCarrierCodeType.Hermes Then Result                      := 'Hermes'
  Else If Value = ShippingCarrierCodeType.ILoxx Then Result                       := 'iLoxx'
  Else If Value = ShippingCarrierCodeType.Other Then Result                       := 'Other'
  Else If Value = ShippingCarrierCodeType.ColiposteDomestic Then Result           := 'ColiposteDomestic'
  Else If Value = ShippingCarrierCodeType.ColiposteInternational Then Result      := 'ColiposteInternational'
  Else If Value = ShippingCarrierCodeType.Chronopost Then Result                  := 'Chronopost'
  Else If Value = ShippingCarrierCodeType.Correos Then Result                     := 'Correos'
  Else If Value = ShippingCarrierCodeType.Seur Then Result                        := 'Seur'
  Else If Value = ShippingCarrierCodeType.Nacex Then Result                       := 'Nacex'
(*  Else If Value = ShippingCarrierCodeType.GlobalShipping_MultiCarrier  Then Result := 'GlobalShipping_MultiCarrier'
  Else If Value = ShippingCarrierCodeType.CustomCode Then Result                  := 'CustomCode'*)
  Else Result                                                                     := '';
End;

Function enumToStr(Const Value: ShippingServiceCodeType): String;
Begin
       If Value =ShippingServiceCodeType.UPSGround Then Result                                                := 'UPSGround'
  Else If Value = ShippingServiceCodeType.UPS3rdDay Then Result                                           := 'UPS3rdDay'
  Else If Value = ShippingServiceCodeType.UPS2ndDay Then Result                                           := 'UPS2ndDay'
  Else If Value = ShippingServiceCodeType.UPSNextDay Then Result                                          := 'UPSNextDay'
  Else If Value = ShippingServiceCodeType.USPSPriority Then Result                                        := 'USPSPriority'
  Else If Value = ShippingServiceCodeType.USPSParcel Then Result                                          := 'USPSParcel'
  Else If Value = ShippingServiceCodeType.USPSStandardPost Then Result                                    := 'USPSStandardPost'
  Else If Value = ShippingServiceCodeType.USPSMedia Then Result                                           := 'USPSMedia'
  Else If Value = ShippingServiceCodeType.USPSFirstClass Then Result                                      := 'USPSFirstClass'
  Else If Value = ShippingServiceCodeType.ShippingMethodStandard Then Result                              := 'ShippingMethodStandard'
  Else If Value = ShippingServiceCodeType.ShippingMethodExpress Then Result                               := 'ShippingMethodExpress'
  Else If Value = ShippingServiceCodeType.USPSExpressMail Then Result                                     := 'USPSExpressMail'
  Else If Value = ShippingServiceCodeType.UPSNextDayAir Then Result                                       := 'UPSNextDayAir'
  Else If Value = ShippingServiceCodeType.UPS2DayAirAM Then Result                                        := 'UPS2DayAirAM'
  Else If Value = ShippingServiceCodeType.USPSExpressMailFlatRateEnvelope Then Result                     := 'USPSExpressMailFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSExpressMailPaddedFlatRateEnvelope Then Result               := 'USPSExpressMailPaddedFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailFlatRateEnvelope Then Result                    := 'USPSPriorityMailFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailSmallFlatRateBox Then Result                    := 'USPSPriorityMailSmallFlatRateBox'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailFlatRateBox Then Result                         := 'USPSPriorityMailFlatRateBox'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailLargeFlatRateBox Then Result                    := 'USPSPriorityMailLargeFlatRateBox'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailPaddedFlatRateEnvelope Then Result              := 'USPSPriorityMailPaddedFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailLegalFlatRateEnvelope Then Result               := 'USPSPriorityMailLegalFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSExpressMailLegalFlatRateEnvelope Then Result                := 'USPSExpressMailLegalFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailRegionalBoxA Then Result                        := 'USPSPriorityMailRegionalBoxA'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailRegionalBoxB Then Result                        := 'USPSPriorityMailRegionalBoxB'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailRegionalBoxC Then Result                        := 'USPSPriorityMailRegionalBoxC'
  Else If Value = ShippingServiceCodeType.USPSExpressMailFlatRateBox Then Result                          := 'USPSExpressMailFlatRateBox'
  Else If Value = ShippingServiceCodeType.Other Then Result                                               := 'Other'
  Else If Value = ShippingServiceCodeType.LocalDelivery Then Result                                       := 'LocalDelivery'
  Else If Value = ShippingServiceCodeType.NotSelected Then Result                                         := 'NotSelected'
  Else If Value = ShippingServiceCodeType.InternationalNotSelected Then Result                            := 'InternationalNotSelected'
  Else If Value = ShippingServiceCodeType.StandardInternational Then Result                               := 'StandardInternational'
  Else If Value = ShippingServiceCodeType.ExpeditedInternational Then Result                              := 'ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.USPSGlobalExpress Then Result                                   := 'USPSGlobalExpress'
  Else If Value = ShippingServiceCodeType.USPSGlobalPriority Then Result                                  := 'USPSGlobalPriority'
  Else If Value = ShippingServiceCodeType.USPSEconomyParcel Then Result                                   := 'USPSEconomyParcel'
  Else If Value = ShippingServiceCodeType.USPSEconomyLetter Then Result                                   := 'USPSEconomyLetter'
  Else If Value = ShippingServiceCodeType.USPSAirmailLetter Then Result                                   := 'USPSAirmailLetter'
  Else If Value = ShippingServiceCodeType.USPSAirmailParcel Then Result                                   := 'USPSAirmailParcel'
  Else If Value = ShippingServiceCodeType.UPSWorldWideExpressPlus Then Result                             := 'UPSWorldWideExpressPlus'
  Else If Value = ShippingServiceCodeType.UPSWorldWideExpress Then Result                                 := 'UPSWorldWideExpress'
  Else If Value = ShippingServiceCodeType.UPSWorldWideExpedited Then Result                               := 'UPSWorldWideExpedited'
  Else If Value = ShippingServiceCodeType.UPSWorldwideSaver Then Result                                   := 'UPSWorldwideSaver'
  Else If Value = ShippingServiceCodeType.UPSStandardToCanada Then Result                                 := 'UPSStandardToCanada'
  Else If Value = ShippingServiceCodeType.USPSExpressMailInternationalFlatRateEnvelope Then Result        := 'USPSExpressMailInternationalFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSExpressMailInternationalPaddedFlatRateEnvelope Then Result  := 'USPSExpressMailInternationalPaddedFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailInternationalFlatRateEnvelope Then Result       := 'USPSPriorityMailInternationalFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailInternationalSmallFlatRateBox Then Result       := 'USPSPriorityMailInternationalSmallFlatRateBox'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailInternationalFlatRateBox Then Result            := 'USPSPriorityMailInternationalFlatRateBox'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailInternationalLargeFlatRateBox Then Result       := 'USPSPriorityMailInternationalLargeFlatRateBox'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailInternationalPaddedFlatRateEnvelope  Then Result := 'USPSPriorityMailInternationalPaddedFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailInternationalLegalFlatRateEnvelope Then Result  := 'USPSPriorityMailInternationalLegalFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSExpressMailInternationalLegalFlatRateEnvelope Then Result   := 'USPSExpressMailInternationalLegalFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSExpressMailInternationalFlatRateBox Then Result             := 'USPSExpressMailInternationalFlatRateBox'
  Else If Value = ShippingServiceCodeType.OtherInternational Then Result                                  := 'OtherInternational'
  Else If Value = ShippingServiceCodeType.AT_StandardDispatch Then Result                                 := 'AT_StandardDispatch'
  Else If Value = ShippingServiceCodeType.AT_InsuredDispatch Then Result                                  := 'AT_InsuredDispatch'
  Else If Value = ShippingServiceCodeType.AT_Writing Then Result                                          := 'AT_Writing'
  Else If Value = ShippingServiceCodeType.AT_COD Then Result                                              := 'AT_COD'
  Else If Value = ShippingServiceCodeType.AT_ExpressOrCourier Then Result                                 := 'AT_ExpressOrCourier'
  Else If Value = ShippingServiceCodeType.AT_InsuredExpressOrCourier Then Result                          := 'AT_InsuredExpressOrCourier'
  Else If Value = ShippingServiceCodeType.AT_SpecialDispatch Then Result                                  := 'AT_SpecialDispatch'
  Else If Value = ShippingServiceCodeType.AT_InsuredSpecialDispatch Then Result                           := 'AT_InsuredSpecialDispatch'
  Else If Value = ShippingServiceCodeType.AT_Sonstige Then Result                                         := 'AT_Sonstige'
  Else If Value = ShippingServiceCodeType.AT_UnversicherterVersandInternational Then Result               := 'AT_UnversicherterVersandInternational'
  Else If Value = ShippingServiceCodeType.AT_VersicherterVersandInternational Then Result                 := 'AT_VersicherterVersandInternational'
  Else If Value = ShippingServiceCodeType.AT_SonstigerVersandInternational Then Result                    := 'AT_SonstigerVersandInternational'
  Else If Value = ShippingServiceCodeType.AT_UnversicherterExpressVersandInternational Then Result        := 'AT_UnversicherterExpressVersandInternational'
  Else If Value = ShippingServiceCodeType.AT_VersicherterExpressVersandInternational Then Result          := 'AT_VersicherterExpressVersandInternational'
  Else If Value = ShippingServiceCodeType.AT_EconomyDeliveryFromAbroad Then Result                        := 'AT_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.AT_StandardDeliveryFromAbroad Then Result                       := 'AT_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.AT_ExpressDeliveryFromAbroad Then Result                        := 'AT_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.AT_TrackedDeliveryFromAbroad Then Result                        := 'AT_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.AU_Regular Then Result                                          := 'AU_Regular'
  Else If Value = ShippingServiceCodeType.AU_Express Then Result                                          := 'AU_Express'
  Else If Value = ShippingServiceCodeType.AU_Registered Then Result                                       := 'AU_Registered'
  Else If Value = ShippingServiceCodeType.AU_Courier Then Result                                          := 'AU_Courier'
  Else If Value = ShippingServiceCodeType.AU_Other Then Result                                            := 'AU_Other'
  Else If Value = ShippingServiceCodeType.AU_EMSInternationalCourierParcels Then Result                   := 'AU_EMSInternationalCourierParcels'
  Else If Value = ShippingServiceCodeType.AU_EMSInternationalCourierDocuments Then Result                 := 'AU_EMSInternationalCourierDocuments'
  Else If Value = ShippingServiceCodeType.AU_ExpressPostInternationalDocuments Then Result                := 'AU_ExpressPostInternationalDocuments'
  Else If Value = ShippingServiceCodeType.AU_AirMailInternational Then Result                             := 'AU_AirMailInternational'
  Else If Value = ShippingServiceCodeType.AU_EconomyAirInternational Then Result                          := 'AU_EconomyAirInternational'
  Else If Value = ShippingServiceCodeType.AU_SeaMailInternational Then Result                             := 'AU_SeaMailInternational'
  Else If Value = ShippingServiceCodeType.AU_StandardInternational Then Result                            := 'AU_StandardInternational'
  Else If Value = ShippingServiceCodeType.AU_ExpeditedInternational Then Result                           := 'AU_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.AU_OtherInternational Then Result                               := 'AU_OtherInternational'
  Else If Value = ShippingServiceCodeType.AU_AusPostRegisteredPostInternationalPaddedBag1kg Then Result   := 'AU_AusPostRegisteredPostInternationalPaddedBag1kg'
  Else If Value = ShippingServiceCodeType.AU_AusPostRegisteredPostInternationalPaddedBag500g Then Result  := 'AU_AusPostRegisteredPostInternationalPaddedBag500g'
  Else If Value = ShippingServiceCodeType.AU_AusPostRegisteredPostInternationalParcel Then Result         := 'AU_AusPostRegisteredPostInternationalParcel'
  Else If Value = ShippingServiceCodeType.AU_ExpeditedDeliveryFromOutsideAU Then Result                   := 'AU_ExpeditedDeliveryFromOutsideAU'
  Else If Value = ShippingServiceCodeType.AU_EconomyDeliveryFromOutsideAU Then Result                     := 'AU_EconomyDeliveryFromOutsideAU'
  Else If Value = ShippingServiceCodeType.AU_StandardDeliveryFromOutsideAU Then Result                    := 'AU_StandardDeliveryFromOutsideAU'
  Else If Value = ShippingServiceCodeType.AU_AustralianAirExpressMetro15kg Then Result                    := 'AU_AustralianAirExpressMetro15kg'
  Else If Value = ShippingServiceCodeType.AU_AustralianAirExpressFlatRate5kg Then Result                  := 'AU_AustralianAirExpressFlatRate5kg'
  Else If Value = ShippingServiceCodeType.AU_AustralianAirExpressFlatRate3kg Then Result                  := 'AU_AustralianAirExpressFlatRate3kg'
  Else If Value = ShippingServiceCodeType.AU_AustralianAirExpressFlatRate1kg Then Result                  := 'AU_AustralianAirExpressFlatRate1kg'
  Else If Value = ShippingServiceCodeType.AU_ExpressDelivery Then Result                                  := 'AU_ExpressDelivery'
  Else If Value = ShippingServiceCodeType.AU_StandardDelivery Then Result                                 := 'AU_StandardDelivery'
  Else If Value = ShippingServiceCodeType.AU_eBayAusPost3kgFlatRateSatchel Then Result                    := 'AU_eBayAusPost3kgFlatRateSatchel'
  Else If Value = ShippingServiceCodeType.AU_eBayAusPost500gFlatRateSatchel Then Result                   := 'AU_eBayAusPost500gFlatRateSatchel'
  Else If Value = ShippingServiceCodeType.AU_Freight Then Result                                          := 'AU_Freight'
  Else If Value = ShippingServiceCodeType.BEFR_StandardDelivery Then Result                               := 'BEFR_StandardDelivery'
  Else If Value = ShippingServiceCodeType.BEFR_PriorityDelivery Then Result                               := 'BEFR_PriorityDelivery'
  Else If Value = ShippingServiceCodeType.BEFR_ParcelPost Then Result                                     := 'BEFR_ParcelPost'
  Else If Value = ShippingServiceCodeType.BEFR_RegisteredMail Then Result                                 := 'BEFR_RegisteredMail'
  Else If Value = ShippingServiceCodeType.BEFR_Other Then Result                                          := 'BEFR_Other'
  Else If Value = ShippingServiceCodeType.BEFR_DePostInternational Then Result                            := 'BEFR_DePostInternational'
  Else If Value = ShippingServiceCodeType.BEFR_UPSInternational Then Result                               := 'BEFR_UPSInternational'
  Else If Value = ShippingServiceCodeType.BEFR_FedExInternational Then Result                             := 'BEFR_FedExInternational'
  Else If Value = ShippingServiceCodeType.BEFR_DHLInternational Then Result                               := 'BEFR_DHLInternational'
  Else If Value = ShippingServiceCodeType.BEFR_TPGPostTNTInternational Then Result                        := 'BEFR_TPGPostTNTInternational'
  Else If Value = ShippingServiceCodeType.BEFR_StandardInternational Then Result                          := 'BEFR_StandardInternational'
  Else If Value = ShippingServiceCodeType.BEFR_ExpeditedInternational Then Result                         := 'BEFR_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.BEFR_OtherInternational Then Result                             := 'BEFR_OtherInternational'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteInternational Then Result                           := 'BEFR_LaPosteInternational'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteStandardShipping Then Result                        := 'BEFR_LaPosteStandardShipping'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteCertifiedShipping Then Result                       := 'BEFR_LaPosteCertifiedShipping'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteTaxipostLLS Then Result                             := 'BEFR_LaPosteTaxipostLLS'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteTaxipost24h Then Result                             := 'BEFR_LaPosteTaxipost24h'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteTaxipostSecur Then Result                           := 'BEFR_LaPosteTaxipostSecur'
  Else If Value = ShippingServiceCodeType.BEFR_PostInternationalStandard Then Result                      := 'BEFR_PostInternationalStandard'
  Else If Value = ShippingServiceCodeType.BEFR_PostInternationalRegistered Then Result                    := 'BEFR_PostInternationalRegistered'
  Else If Value = ShippingServiceCodeType.BEFR_TNTInternational Then Result                               := 'BEFR_TNTInternational'
  Else If Value = ShippingServiceCodeType.BEFR_EconomyDeliveryFromAbroad Then Result                      := 'BEFR_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.BEFR_StandardDeliveryFromAbroad Then Result                     := 'BEFR_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.BEFR_ExpressDeliveryFromAbroad Then Result                      := 'BEFR_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.BEFR_TrackedDeliveryFromAbroad Then Result                      := 'BEFR_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.BENL_StandardDelivery Then Result                               := 'BENL_StandardDelivery'
  Else If Value = ShippingServiceCodeType.BENL_PriorityDelivery Then Result                               := 'BENL_PriorityDelivery'
  Else If Value = ShippingServiceCodeType.BENL_ParcelPost Then Result                                     := 'BENL_ParcelPost'
  Else If Value = ShippingServiceCodeType.BENL_RegisteredMail Then Result                                 := 'BENL_RegisteredMail'
  Else If Value = ShippingServiceCodeType.BENL_Other Then Result                                          := 'BENL_Other'
  Else If Value = ShippingServiceCodeType.BENL_DePostInternational Then Result                            := 'BENL_DePostInternational'
  Else If Value = ShippingServiceCodeType.BENL_UPSInternational Then Result                               := 'BENL_UPSInternational'
  Else If Value = ShippingServiceCodeType.BENL_FedExInternational Then Result                             := 'BENL_FedExInternational'
  Else If Value = ShippingServiceCodeType.BENL_DHLInternational Then Result                               := 'BENL_DHLInternational'
  Else If Value = ShippingServiceCodeType.BENL_TPGPostTNTInternational Then Result                        := 'BENL_TPGPostTNTInternational'
  Else If Value = ShippingServiceCodeType.BENL_StandardInternational Then Result                          := 'BENL_StandardInternational'
  Else If Value = ShippingServiceCodeType.BENL_ExpeditedInternational Then Result                         := 'BENL_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.BENL_OtherInternational Then Result                             := 'BENL_OtherInternational'
  Else If Value = ShippingServiceCodeType.BENL_LaPosteInternational Then Result                           := 'BENL_LaPosteInternational'
  Else If Value = ShippingServiceCodeType.BENL_DePostStandardShipping Then Result                         := 'BENL_DePostStandardShipping'
  Else If Value = ShippingServiceCodeType.BENL_DePostCertifiedShipping Then Result                        := 'BENL_DePostCertifiedShipping'
  Else If Value = ShippingServiceCodeType.BENL_DePostTaxipostLLS Then Result                              := 'BENL_DePostTaxipostLLS'
  Else If Value = ShippingServiceCodeType.BENL_DePostTaxipost24h Then Result                              := 'BENL_DePostTaxipost24h'
  Else If Value = ShippingServiceCodeType.BENL_DePostTaxipostSecur Then Result                            := 'BENL_DePostTaxipostSecur'
  Else If Value = ShippingServiceCodeType.BENL_OtherShippingMethods Then Result                           := 'BENL_OtherShippingMethods'
  Else If Value = ShippingServiceCodeType.BENL_PostInternationalStandard Then Result                      := 'BENL_PostInternationalStandard'
  Else If Value = ShippingServiceCodeType.BENL_PostInternationalRegistered Then Result                    := 'BENL_PostInternationalRegistered'
  Else If Value = ShippingServiceCodeType.BENL_TNTInternational Then Result                               := 'BENL_TNTInternational'
  Else If Value = ShippingServiceCodeType.BENL_EconomyDeliveryFromAbroad Then Result                      := 'BENL_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.BENL_StandardDeliveryFromAbroad Then Result                     := 'BENL_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.BENL_ExpressDeliveryFromAbroad Then Result                      := 'BENL_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.BENL_TrackedDeliveryFromAbroad Then Result                      := 'BENL_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.CA_StandardDelivery Then Result                                 := 'CA_StandardDelivery'
  Else If Value = ShippingServiceCodeType.CA_ExpeditedDelivery Then Result                                := 'CA_ExpeditedDelivery'
  Else If Value = ShippingServiceCodeType.CA_PostLettermail Then Result                                   := 'CA_PostLettermail'
  Else If Value = ShippingServiceCodeType.CA_PostRegularParcel Then Result                                := 'CA_PostRegularParcel'
  Else If Value = ShippingServiceCodeType.CA_PostExpeditedParcel Then Result                              := 'CA_PostExpeditedParcel'
  Else If Value = ShippingServiceCodeType.CA_PostXpresspost Then Result                                   := 'CA_PostXpresspost'
  Else If Value = ShippingServiceCodeType.CA_PostPriorityCourier Then Result                              := 'CA_PostPriorityCourier'
  Else If Value = ShippingServiceCodeType.CanadaPostExpeditedFlatRateBox Then Result                      := 'CanadaPostExpeditedFlatRateBox'
  Else If Value = ShippingServiceCodeType.CA_PostExpeditedFlatRateBox Then Result                         := 'CA_PostExpeditedFlatRateBox'
  Else If Value = ShippingServiceCodeType.CA_StandardInternational Then Result                            := 'CA_StandardInternational'
  Else If Value = ShippingServiceCodeType.CA_ExpeditedInternational Then Result                           := 'CA_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.CA_OtherInternational Then Result                               := 'CA_OtherInternational'
  Else If Value = ShippingServiceCodeType.CA_PostExpeditedParcelUSA Then Result                           := 'CA_PostExpeditedParcelUSA'
  Else If Value = ShippingServiceCodeType.CA_PostSmallPacketsUSA Then Result                              := 'CA_PostSmallPacketsUSA'
  Else If Value = ShippingServiceCodeType.CA_PostXpresspostUSA Then Result                                := 'CA_PostXpresspostUSA'
  Else If Value = ShippingServiceCodeType.CA_PostXpresspostInternational Then Result                      := 'CA_PostXpresspostInternational'
  Else If Value = ShippingServiceCodeType.CA_PostInternationalParcelSurface Then Result                   := 'CA_PostInternationalParcelSurface'
  Else If Value = ShippingServiceCodeType.CA_PostInternationalParcelAir Then Result                       := 'CA_PostInternationalParcelAir'
  Else If Value = ShippingServiceCodeType.CA_SmallPacketsInternational Then Result                        := 'CA_SmallPacketsInternational'
  Else If Value = ShippingServiceCodeType.CA_PurolatorInternational Then Result                           := 'CA_PurolatorInternational'
  Else If Value = ShippingServiceCodeType.CA_PostSmallPacketsUSAGround Then Result                        := 'CA_PostSmallPacketsUSAGround'
  Else If Value = ShippingServiceCodeType.CA_PostSmallPacketsUSAAir Then Result                           := 'CA_PostSmallPacketsUSAAir'
  Else If Value = ShippingServiceCodeType.CA_SmallPacketsInternationalGround Then Result                  := 'CA_SmallPacketsInternationalGround'
  Else If Value = ShippingServiceCodeType.CA_SmallPacketsInternationalAir Then Result                     := 'CA_SmallPacketsInternationalAir'
  Else If Value = ShippingServiceCodeType.CA_PostUSALetterPost Then Result                                := 'CA_PostUSALetterPost'
  Else If Value = ShippingServiceCodeType.CA_PostInternationalLetterPost Then Result                      := 'CA_PostInternationalLetterPost'
  Else If Value = ShippingServiceCodeType.CA_PostExpeditedFlatRateBoxUSA Then Result                      := 'CA_PostExpeditedFlatRateBoxUSA'
  Else If Value = ShippingServiceCodeType.CA_UPSExpressCanada Then Result                                 := 'CA_UPSExpressCanada'
  Else If Value = ShippingServiceCodeType.CA_UPSExpressSaverCanada Then Result                            := 'CA_UPSExpressSaverCanada'
  Else If Value = ShippingServiceCodeType.CA_UPSExpeditedCanada Then Result                               := 'CA_UPSExpeditedCanada'
  Else If Value = ShippingServiceCodeType.CA_UPSStandardCanada Then Result                                := 'CA_UPSStandardCanada'
  Else If Value = ShippingServiceCodeType.CA_UPSExpressUnitedStates Then Result                           := 'CA_UPSExpressUnitedStates'
  Else If Value = ShippingServiceCodeType.CA_UPSExpeditedUnitedStates Then Result                         := 'CA_UPSExpeditedUnitedStates'
  Else If Value = ShippingServiceCodeType.CA_UPS3DaySelectUnitedStates Then Result                        := 'CA_UPS3DaySelectUnitedStates'
  Else If Value = ShippingServiceCodeType.CA_UPSStandardUnitedStates Then Result                          := 'CA_UPSStandardUnitedStates'
  Else If Value = ShippingServiceCodeType.CA_UPSWorldWideExpress Then Result                              := 'CA_UPSWorldWideExpress'
  Else If Value = ShippingServiceCodeType.CA_UPSWorldWideExpedited Then Result                            := 'CA_UPSWorldWideExpedited'
  Else If Value = ShippingServiceCodeType.CA_PriorityWorldwide Then Result                                := 'CA_PriorityWorldwide'
  Else If Value = ShippingServiceCodeType.CanadaPostExpeditedFlatRateBoxUSA Then Result                   := 'CanadaPostExpeditedFlatRateBoxUSA'
  Else If Value = ShippingServiceCodeType.CA_PostTrackedPacketsUSA Then Result                            := 'CA_PostTrackedPacketsUSA'
  Else If Value = ShippingServiceCodeType.CA_PostTrackedPacketsInternational Then Result                  := 'CA_PostTrackedPacketsInternational'
  Else If Value = ShippingServiceCodeType.CA_Freight Then Result                                          := 'CA_Freight'
  Else If Value = ShippingServiceCodeType.CH_StandardDispatchAPost Then Result                            := 'CH_StandardDispatchAPost'
  Else If Value = ShippingServiceCodeType.CH_StandardDispatchBPost Then Result                            := 'CH_StandardDispatchBPost'
  Else If Value = ShippingServiceCodeType.CH_InsuredDispatch Then Result                                  := 'CH_InsuredDispatch'
  Else If Value = ShippingServiceCodeType.CH_Writing Then Result                                          := 'CH_Writing'
  Else If Value = ShippingServiceCodeType.CH_COD Then Result                                              := 'CH_COD'
  Else If Value = ShippingServiceCodeType.CH_ExpressOrCourier Then Result                                 := 'CH_ExpressOrCourier'
  Else If Value = ShippingServiceCodeType.CH_InsuredExpressOrCourier Then Result                          := 'CH_InsuredExpressOrCourier'
  Else If Value = ShippingServiceCodeType.CH_SpecialDispatch Then Result                                  := 'CH_SpecialDispatch'
  Else If Value = ShippingServiceCodeType.CH_InsuredSpecialDispatch Then Result                           := 'CH_InsuredSpecialDispatch'
  Else If Value = ShippingServiceCodeType.CH_Sonstige Then Result                                         := 'CH_Sonstige'
  Else If Value = ShippingServiceCodeType.CH_SonstigerVersandInternational Then Result                    := 'CH_SonstigerVersandInternational'
  Else If Value = ShippingServiceCodeType.CH_EconomySendungenInternational Then Result                    := 'CH_EconomySendungenInternational'
  Else If Value = ShippingServiceCodeType.CH_PrioritySendungenInternational Then Result                   := 'CH_PrioritySendungenInternational'
  Else If Value = ShippingServiceCodeType.CH_UrgentSendungenInternational Then Result                     := 'CH_UrgentSendungenInternational'
  Else If Value = ShippingServiceCodeType.CH_EconomyDeliveryFromAbroad Then Result                        := 'CH_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.CH_StandardDeliveryFromAbroad Then Result                       := 'CH_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.CH_ExpressDeliveryFromAbroad Then Result                        := 'CH_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.CH_TrackedDeliveryFromAbroad Then Result                        := 'CH_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.CN_PersonalDelivery Then Result                                 := 'CN_PersonalDelivery'
  Else If Value = ShippingServiceCodeType.CN_RegularPackage Then Result                                   := 'CN_RegularPackage'
  Else If Value = ShippingServiceCodeType.CN_DeliveryCompanyExpress Then Result                           := 'CN_DeliveryCompanyExpress'
  Else If Value = ShippingServiceCodeType.CN_PostOfficeExpress Then Result                                := 'CN_PostOfficeExpress'
  Else If Value = ShippingServiceCodeType.CN_Others Then Result                                           := 'CN_Others'
  Else If Value = ShippingServiceCodeType.CN_FastPostOffice Then Result                                   := 'CN_FastPostOffice'
  Else If Value = ShippingServiceCodeType.CN_ExpressDeliverySameCity Then Result                          := 'CN_ExpressDeliverySameCity'
  Else If Value = ShippingServiceCodeType.CN_ExpressDeliveryOtherCities Then Result                       := 'CN_ExpressDeliveryOtherCities'
  Else If Value = ShippingServiceCodeType.CN_StandardInternational Then Result                            := 'CN_StandardInternational'
  Else If Value = ShippingServiceCodeType.CN_ExpeditedInternational Then Result                           := 'CN_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.CN_OtherInternational Then Result                               := 'CN_OtherInternational'
  Else If Value = ShippingServiceCodeType.CN_CODInternational Then Result                                 := 'CN_CODInternational'
  Else If Value = ShippingServiceCodeType.CN_StandardMailingInternational Then Result                     := 'CN_StandardMailingInternational'
  Else If Value = ShippingServiceCodeType.CN_RegularLogisticsInternational Then Result                    := 'CN_RegularLogisticsInternational'
  Else If Value = ShippingServiceCodeType.CN_EMSInternational Then Result                                 := 'CN_EMSInternational'
  Else If Value = ShippingServiceCodeType.CN_OthersInternational Then Result                              := 'CN_OthersInternational'
  Else If Value = ShippingServiceCodeType.DE_StandardDispatch Then Result                                 := 'DE_StandardDispatch'
  Else If Value = ShippingServiceCodeType.DE_InsuredDispatch Then Result                                  := 'DE_InsuredDispatch'
  Else If Value = ShippingServiceCodeType.DE_Writing Then Result                                          := 'DE_Writing'
  Else If Value = ShippingServiceCodeType.DE_COD Then Result                                              := 'DE_COD'
  Else If Value = ShippingServiceCodeType.DE_ExpressOrCourier Then Result                                 := 'DE_ExpressOrCourier'
  Else If Value = ShippingServiceCodeType.DE_InsuredExpressOrCourier Then Result                          := 'DE_InsuredExpressOrCourier'
  Else If Value = ShippingServiceCodeType.DE_SpecialDispatch Then Result                                  := 'DE_SpecialDispatch'
  Else If Value = ShippingServiceCodeType.DE_InsuredSpecialDispatch Then Result                           := 'DE_InsuredSpecialDispatch'
  Else If Value = ShippingServiceCodeType.DE_UnversicherterVersand Then Result                            := 'DE_UnversicherterVersand'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostBrief Then Result                                := 'DE_DeutschePostBrief'
  Else If Value = ShippingServiceCodeType.DE_eBayDHLPaket24x7 Then Result                                 := 'DE_eBayDHLPaket24x7'
  Else If Value = ShippingServiceCodeType.DE_DHLPostpaket Then Result                                     := 'DE_DHLPostpaket'
  Else If Value = ShippingServiceCodeType.DE_DHLPackchen Then Result                                      := 'DE_DHLPackchen'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostWarensendung Then Result                         := 'DE_DeutschePostWarensendung'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostBuchersendung Then Result                        := 'DE_DeutschePostBuchersendung'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketUnversichert Then Result                          := 'DE_HermesPaketUnversichert'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketVersichert Then Result                            := 'DE_HermesPaketVersichert'
  Else If Value = ShippingServiceCodeType.DE_IloxxTransportXXL Then Result                                := 'DE_IloxxTransportXXL'
  Else If Value = ShippingServiceCodeType.DE_IloxxUbernachtExpress Then Result                            := 'DE_IloxxUbernachtExpress'
  Else If Value = ShippingServiceCodeType.DE_IloxxStandard Then Result                                    := 'DE_IloxxStandard'
  Else If Value = ShippingServiceCodeType.DE_Sonstige Then Result                                         := 'DE_Sonstige'
  Else If Value = ShippingServiceCodeType.DE_UnversicherterVersandInternational Then Result               := 'DE_UnversicherterVersandInternational'
  Else If Value = ShippingServiceCodeType.DE_VersicherterVersandInternational Then Result                 := 'DE_VersicherterVersandInternational'
  Else If Value = ShippingServiceCodeType.DE_DHLPostpaketInternational Then Result                        := 'DE_DHLPostpaketInternational'
  Else If Value = ShippingServiceCodeType.DE_DHLPackchenInternational Then Result                         := 'DE_DHLPackchenInternational'
  Else If Value = ShippingServiceCodeType.DE_SonstigerVersandInternational Then Result                    := 'DE_SonstigerVersandInternational'
  Else If Value = ShippingServiceCodeType.DE_UnversicherterExpressVersandInternational Then Result        := 'DE_UnversicherterExpressVersandInternational'
  Else If Value = ShippingServiceCodeType.DE_VersicherterExpressVersandInternational Then Result          := 'DE_VersicherterExpressVersandInternational'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostBriefLandInternational Then Result               := 'DE_DeutschePostBriefLandInternational'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostBriefLuftInternational Then Result               := 'DE_DeutschePostBriefLuftInternational'
  Else If Value = ShippingServiceCodeType.DE_IloxxEuropaInternational Then Result                         := 'DE_IloxxEuropaInternational'
  Else If Value = ShippingServiceCodeType.DE_IloxxWorldWideInternational Then Result                      := 'DE_IloxxWorldWideInternational'
  Else If Value = ShippingServiceCodeType.DE_Paket Then Result                                            := 'DE_Paket'
  Else If Value = ShippingServiceCodeType.DE_Express Then Result                                          := 'DE_Express'
  Else If Value = ShippingServiceCodeType.DE_DHLPaket Then Result                                         := 'DE_DHLPaket'
  Else If Value = ShippingServiceCodeType.DE_DPBuecherWarensendung Then Result                            := 'DE_DPBuecherWarensendung'
  Else If Value = ShippingServiceCodeType.DE_HermesPaket Then Result                                      := 'DE_HermesPaket'
  Else If Value = ShippingServiceCodeType.DE_IloxxTransport Then Result                                   := 'DE_IloxxTransport'
  Else If Value = ShippingServiceCodeType.DE_SonstigeDomestic Then Result                                 := 'DE_SonstigeDomestic'
  Else If Value = ShippingServiceCodeType.DE_Einschreiben Then Result                                     := 'DE_Einschreiben'
  Else If Value = ShippingServiceCodeType.DE_Nachname Then Result                                         := 'DE_Nachname'
  Else If Value = ShippingServiceCodeType.DE_SpecialDelivery Then Result                                  := 'DE_SpecialDelivery'
  Else If Value = ShippingServiceCodeType.DE_UPS Then Result                                              := 'DE_UPS'
  Else If Value = ShippingServiceCodeType.DE_DPD Then Result                                              := 'DE_DPD'
  Else If Value = ShippingServiceCodeType.DE_GLS Then Result                                              := 'DE_GLS'
  Else If Value = ShippingServiceCodeType.DE_PaketInternational Then Result                               := 'DE_PaketInternational'
  Else If Value = ShippingServiceCodeType.DE_DHLPaketInternational Then Result                            := 'DE_DHLPaketInternational'
  Else If Value = ShippingServiceCodeType.DE_SonstigeInternational Then Result                            := 'DE_SonstigeInternational'
  Else If Value = ShippingServiceCodeType.DE_ExpressInternational Then Result                             := 'DE_ExpressInternational'
  Else If Value = ShippingServiceCodeType.DE_DPBriefInternational Then Result                             := 'DE_DPBriefInternational'
  Else If Value = ShippingServiceCodeType.DE_IloxxTransportInternational Then Result                      := 'DE_IloxxTransportInternational'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketInternational Then Result                         := 'DE_HermesPaketInternational'
  Else If Value = ShippingServiceCodeType.DE_UPSInternational Then Result                                 := 'DE_UPSInternational'
  Else If Value = ShippingServiceCodeType.DE_DPDInternational Then Result                                 := 'DE_DPDInternational'
  Else If Value = ShippingServiceCodeType.DE_GLSInternational Then Result                                 := 'DE_GLSInternational'
  Else If Value = ShippingServiceCodeType.DE_eBayHermesPaketShop2ShopKaeufer Then Result                  := 'DE_eBayHermesPaketShop2ShopKaeufer'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketShop2ShopKaeufer Then Result                      := 'DE_HermesPaketShop2ShopKaeufer'
  Else If Value = ShippingServiceCodeType.DE_eBayHermesPaketShop2Shop Then Result                         := 'DE_eBayHermesPaketShop2Shop'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketShop2Shop Then Result                             := 'DE_HermesPaketShop2Shop'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketSperrgut Then Result                              := 'DE_HermesPaketSperrgut'
  Else If Value = ShippingServiceCodeType.DE_eBayHermesPaketSperrgutShop2Shop Then Result                 := 'DE_eBayHermesPaketSperrgutShop2Shop'
  Else If Value = ShippingServiceCodeType.DE_DHLPaeckchenPackstation Then Result                          := 'DE_DHLPaeckchenPackstation'
  Else If Value = ShippingServiceCodeType.DE_DHLPaketPackstation Then Result                              := 'DE_DHLPaketPackstation'
  Else If Value = ShippingServiceCodeType.DE_eBayDHLPaeckchen Then Result                                 := 'DE_eBayDHLPaeckchen'
  Else If Value = ShippingServiceCodeType.DE_DHLStarPaeckchen Then Result                                 := 'DE_DHLStarPaeckchen'
  Else If Value = ShippingServiceCodeType.DE_TrackedDeliveryFromAbroad Then Result                        := 'DE_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.ES_CartasNacionalesHasta20 Then Result                          := 'ES_CartasNacionalesHasta20'
  Else If Value = ShippingServiceCodeType.ES_CartasNacionalesDeMas20 Then Result                          := 'ES_CartasNacionalesDeMas20'
  Else If Value = ShippingServiceCodeType.ES_CartasInternacionalesHasta20 Then Result                     := 'ES_CartasInternacionalesHasta20'
  Else If Value = ShippingServiceCodeType.ES_CartasInternacionalesDeMas20 Then Result                     := 'ES_CartasInternacionalesDeMas20'
  Else If Value = ShippingServiceCodeType.ES_PaqueteAzulHasta2kg Then Result                              := 'ES_PaqueteAzulHasta2kg'
  Else If Value = ShippingServiceCodeType.ES_PaqueteAzulDeMas2kg Then Result                              := 'ES_PaqueteAzulDeMas2kg'
  Else If Value = ShippingServiceCodeType.ES_PaqueteInternacionalEconomico Then Result                    := 'ES_PaqueteInternacionalEconomico'
  Else If Value = ShippingServiceCodeType.ES_Urgente Then Result                                          := 'ES_Urgente'
  Else If Value = ShippingServiceCodeType.ES_Otros Then Result                                            := 'ES_Otros'
  Else If Value = ShippingServiceCodeType.ES_StandardInternational Then Result                            := 'ES_StandardInternational'
  Else If Value = ShippingServiceCodeType.ES_ExpeditedInternational Then Result                           := 'ES_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.ES_OtherInternational Then Result                               := 'ES_OtherInternational'
  Else If Value = ShippingServiceCodeType.ES_CartasPostalInternational Then Result                        := 'ES_CartasPostalInternational'
  Else If Value = ShippingServiceCodeType.ES_EmsPostalExpressInternational Then Result                    := 'ES_EmsPostalExpressInternational'
  Else If Value = ShippingServiceCodeType.ES_EconomyPacketInternational Then Result                       := 'ES_EconomyPacketInternational'
  Else If Value = ShippingServiceCodeType.ES_EconomyDeliveryFromAbroad Then Result                        := 'ES_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.ES_StandardDeliveryFromAbroad Then Result                       := 'ES_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.ES_ExpressDeliveryFromAbroad Then Result                        := 'ES_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.ES_TrackedDeliveryFromAbroad Then Result                        := 'ES_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.ES_ENTREGA_KIALA_8KG Then Result                                := 'ES_ENTREGA_KIALA_8KG'
  Else If Value = ShippingServiceCodeType.FR_ChronoposteInternationalClassic Then Result                  := 'FR_ChronoposteInternationalClassic'
  Else If Value = ShippingServiceCodeType.FR_ColiposteColissimoDirect Then Result                         := 'FR_ColiposteColissimoDirect'
  Else If Value = ShippingServiceCodeType.FR_DHLExpressEuropack Then Result                               := 'FR_DHLExpressEuropack'
  Else If Value = ShippingServiceCodeType.FR_UPSStandard Then Result                                      := 'FR_UPSStandard'
  Else If Value = ShippingServiceCodeType.FR_PostOfficeLetter Then Result                                 := 'FR_PostOfficeLetter'
  Else If Value = ShippingServiceCodeType.FR_PostOfficeLetterFollowed Then Result                         := 'FR_PostOfficeLetterFollowed'
  Else If Value = ShippingServiceCodeType.FR_PostOfficeLetterRecommended Then Result                      := 'FR_PostOfficeLetterRecommended'
  Else If Value = ShippingServiceCodeType.FR_ColiposteColissimo Then Result                               := 'FR_ColiposteColissimo'
  Else If Value = ShippingServiceCodeType.FR_ColiposteColissimoRecommended Then Result                    := 'FR_ColiposteColissimoRecommended'
  Else If Value = ShippingServiceCodeType.FR_UPSStandardAgainstRefund Then Result                         := 'FR_UPSStandardAgainstRefund'
  Else If Value = ShippingServiceCodeType.FR_Autre Then Result                                            := 'FR_Autre'
  Else If Value = ShippingServiceCodeType.FR_Ecopli Then Result                                           := 'FR_Ecopli'
  Else If Value = ShippingServiceCodeType.FR_Colieco Then Result                                          := 'FR_Colieco'
  Else If Value = ShippingServiceCodeType.FR_AuteModeDenvoiDeColis Then Result                            := 'FR_AuteModeDenvoiDeColis'
  Else If Value = ShippingServiceCodeType.FR_RemiseEnMainPropre Then Result                               := 'FR_RemiseEnMainPropre'
  Else If Value = ShippingServiceCodeType.FR_StandardInternational Then Result                            := 'FR_StandardInternational'
  Else If Value = ShippingServiceCodeType.FR_ExpeditedInternational Then Result                           := 'FR_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.FR_OtherInternational Then Result                               := 'FR_OtherInternational'
  Else If Value = ShippingServiceCodeType.FR_LaPosteInternationalPriorityCourier Then Result              := 'FR_LaPosteInternationalPriorityCourier'
  Else If Value = ShippingServiceCodeType.FR_LaPosteInternationalEconomyCourier Then Result               := 'FR_LaPosteInternationalEconomyCourier'
  Else If Value = ShippingServiceCodeType.FR_LaPosteColissimoInternational Then Result                    := 'FR_LaPosteColissimoInternational'
  Else If Value = ShippingServiceCodeType.FR_LaPosteColisEconomiqueInternational Then Result              := 'FR_LaPosteColisEconomiqueInternational'
  Else If Value = ShippingServiceCodeType.FR_LaPosteColissimoEmballageInternational Then Result           := 'FR_LaPosteColissimoEmballageInternational'
  Else If Value = ShippingServiceCodeType.FR_ChronopostClassicInternational Then Result                   := 'FR_ChronopostClassicInternational'
  Else If Value = ShippingServiceCodeType.FR_ChronopostPremiumInternational Then Result                   := 'FR_ChronopostPremiumInternational'
  Else If Value = ShippingServiceCodeType.FR_UPSStandardInternational Then Result                         := 'FR_UPSStandardInternational'
  Else If Value = ShippingServiceCodeType.FR_UPSExpressInternational Then Result                          := 'FR_UPSExpressInternational'
  Else If Value = ShippingServiceCodeType.FR_DHLInternational Then Result                                 := 'FR_DHLInternational'
  Else If Value = ShippingServiceCodeType.FR_LaPosteLetterMax Then Result                                 := 'FR_LaPosteLetterMax'
  Else If Value = ShippingServiceCodeType.FR_KIALA_DELIVERY Then Result                                   := 'FR_KIALA_DELIVERY'
  Else If Value = ShippingServiceCodeType.FR_TrackedDeliveryFromAbroad Then Result                        := 'FR_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.IN_Regular Then Result                                          := 'IN_Regular'
  Else If Value = ShippingServiceCodeType.IN_Express Then Result                                          := 'IN_Express'
  Else If Value = ShippingServiceCodeType.IN_NationalCOD Then Result                                      := 'IN_NationalCOD'
  Else If Value = ShippingServiceCodeType.IN_Courier Then Result                                          := 'IN_Courier'
  Else If Value = ShippingServiceCodeType.IN_LocalCOD Then Result                                         := 'IN_LocalCOD'
  Else If Value = ShippingServiceCodeType.IN_StandardInternational Then Result                            := 'IN_StandardInternational'
  Else If Value = ShippingServiceCodeType.IN_ExpeditedInternational Then Result                           := 'IN_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.IN_OtherInternational Then Result                               := 'IN_OtherInternational'
  Else If Value = ShippingServiceCodeType.IN_FlatRateCOD Then Result                                      := 'IN_FlatRateCOD'
  Else If Value = ShippingServiceCodeType.IN_BuyerPicksUpAndPays Then Result                              := 'IN_BuyerPicksUpAndPays'
  Else If Value = ShippingServiceCodeType.IT_RegularMail Then Result                                      := 'IT_RegularMail'
  Else If Value = ShippingServiceCodeType.IT_PriorityMail Then Result                                     := 'IT_PriorityMail'
  Else If Value = ShippingServiceCodeType.IT_MailRegisteredLetter Then Result                             := 'IT_MailRegisteredLetter'
  Else If Value = ShippingServiceCodeType.IT_MailRegisteredLetterWithMark Then Result                     := 'IT_MailRegisteredLetterWithMark'
  Else If Value = ShippingServiceCodeType.IT_InsuredMail Then Result                                      := 'IT_InsuredMail'
  Else If Value = ShippingServiceCodeType.IT_QuickMail Then Result                                        := 'IT_QuickMail'
  Else If Value = ShippingServiceCodeType.IT_RegularPackage Then Result                                   := 'IT_RegularPackage'
  Else If Value = ShippingServiceCodeType.IT_QuickPackage1 Then Result                                    := 'IT_QuickPackage1'
  Else If Value = ShippingServiceCodeType.IT_QuickPackage3 Then Result                                    := 'IT_QuickPackage3'
  Else If Value = ShippingServiceCodeType.IT_ExpressCourier Then Result                                   := 'IT_ExpressCourier'
  Else If Value = ShippingServiceCodeType.IT_ExpressPackageMaxi Then Result                               := 'IT_ExpressPackageMaxi'
  Else If Value = ShippingServiceCodeType.IT_StandardInternational Then Result                            := 'IT_StandardInternational'
  Else If Value = ShippingServiceCodeType.IT_ExpeditedInternational Then Result                           := 'IT_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.IT_OtherInternational Then Result                               := 'IT_OtherInternational'
  Else If Value = ShippingServiceCodeType.IT_TrackedDeliveryFromAbroad Then Result                        := 'IT_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.NL_StandardDelivery Then Result                                 := 'NL_StandardDelivery'
  Else If Value = ShippingServiceCodeType.NL_ParcelPost Then Result                                       := 'NL_ParcelPost'
  Else If Value = ShippingServiceCodeType.NL_RegisteredMail Then Result                                   := 'NL_RegisteredMail'
  Else If Value = ShippingServiceCodeType.NL_Other Then Result                                            := 'NL_Other'
  Else If Value = ShippingServiceCodeType.NL_TPGPostTNTInternational Then Result                          := 'NL_TPGPostTNTInternational'
  Else If Value = ShippingServiceCodeType.NL_UPSInternational Then Result                                 := 'NL_UPSInternational'
  Else If Value = ShippingServiceCodeType.NL_FedExInternational Then Result                               := 'NL_FedExInternational'
  Else If Value = ShippingServiceCodeType.NL_DHLInternational Then Result                                 := 'NL_DHLInternational'
  Else If Value = ShippingServiceCodeType.NL_DPDGBRInternational Then Result                              := 'NL_DPDGBRInternational'
  Else If Value = ShippingServiceCodeType.NL_GLSBusinessInternational Then Result                         := 'NL_GLSBusinessInternational'
  Else If Value = ShippingServiceCodeType.NL_StandardInternational Then Result                            := 'NL_StandardInternational'
  Else If Value = ShippingServiceCodeType.NL_ExpeditedInternational Then Result                           := 'NL_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.NL_OtherInternational Then Result                               := 'NL_OtherInternational'
  Else If Value = ShippingServiceCodeType.NL_EconomyDeliveryFromAbroad Then Result                        := 'NL_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.NL_StandardDeliveryFromAbroad Then Result                       := 'NL_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.NL_ExpressDeliveryFromAbroad Then Result                        := 'NL_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.NL_TrackedDeliveryFromAbroad Then Result                        := 'NL_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.TW_RegisteredMail Then Result                                   := 'TW_RegisteredMail'
  Else If Value = ShippingServiceCodeType.TW_UnregisteredMail Then Result                                 := 'TW_UnregisteredMail'
  Else If Value = ShippingServiceCodeType.TW_COD Then Result                                              := 'TW_COD'
  Else If Value = ShippingServiceCodeType.TW_DwellingMatchPost Then Result                                := 'TW_DwellingMatchPost'
  Else If Value = ShippingServiceCodeType.TW_DwellingMatchCOD Then Result                                 := 'TW_DwellingMatchCOD'
  Else If Value = ShippingServiceCodeType.TW_SelfPickup Then Result                                       := 'TW_SelfPickup'
  Else If Value = ShippingServiceCodeType.TW_ParcelPost Then Result                                       := 'TW_ParcelPost'
  Else If Value = ShippingServiceCodeType.TW_ExpressMail Then Result                                      := 'TW_ExpressMail'
  Else If Value = ShippingServiceCodeType.TW_Other Then Result                                            := 'TW_Other'
  Else If Value = ShippingServiceCodeType.TW_CPInternationalLetterPost Then Result                        := 'TW_CPInternationalLetterPost'
  Else If Value = ShippingServiceCodeType.TW_CPInternationalParcelPost Then Result                        := 'TW_CPInternationalParcelPost'
  Else If Value = ShippingServiceCodeType.TW_CPInternationalRegisteredLetterPost Then Result              := 'TW_CPInternationalRegisteredLetterPost'
  Else If Value = ShippingServiceCodeType.TW_CPInternationalRegisteredParcelPost Then Result              := 'TW_CPInternationalRegisteredParcelPost'
  Else If Value = ShippingServiceCodeType.TW_CPInternationalEMS Then Result                               := 'TW_CPInternationalEMS'
  Else If Value = ShippingServiceCodeType.TW_CPInternationalOceanShippingParcel Then Result               := 'TW_CPInternationalOceanShippingParcel'
  Else If Value = ShippingServiceCodeType.TW_FedExInternationalPriority Then Result                       := 'TW_FedExInternationalPriority'
  Else If Value = ShippingServiceCodeType.TW_FedExInternationalEconomy Then Result                        := 'TW_FedExInternationalEconomy'
  Else If Value = ShippingServiceCodeType.TW_UPSWorldwideExpedited Then Result                            := 'TW_UPSWorldwideExpedited'
  Else If Value = ShippingServiceCodeType.TW_UPSWorldwideExpress Then Result                              := 'TW_UPSWorldwideExpress'
  Else If Value = ShippingServiceCodeType.TW_UPSWorldwideExpressPlus Then Result                          := 'TW_UPSWorldwideExpressPlus'
  Else If Value = ShippingServiceCodeType.TW_OtherInternational Then Result                               := 'TW_OtherInternational'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailFirstClassStandard Then Result                      := 'UK_RoyalMailFirstClassStandard'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailSecondClassStandard Then Result                     := 'UK_RoyalMailSecondClassStandard'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailFirstClassRecorded Then Result                      := 'UK_RoyalMailFirstClassRecorded'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailSecondClassRecorded Then Result                     := 'UK_RoyalMailSecondClassRecorded'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailSpecialDelivery Then Result                         := 'UK_RoyalMailSpecialDelivery'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailStandardParcel Then Result                          := 'UK_RoyalMailStandardParcel'
  Else If Value = ShippingServiceCodeType.UK_Parcelforce24 Then Result                                    := 'UK_Parcelforce24'
  Else If Value = ShippingServiceCodeType.UK_Parcelforce48 Then Result                                    := 'UK_Parcelforce48'
  Else If Value = ShippingServiceCodeType.UK_OtherCourier Then Result                                     := 'UK_OtherCourier'
  Else If Value = ShippingServiceCodeType.UK_myHermesDoorToDoorService Then Result                        := 'UK_myHermesDoorToDoorService'
  Else If Value = ShippingServiceCodeType.UK_CollectDropAtStoreDeliveryToDoor Then Result                 := 'UK_CollectDropAtStoreDeliveryToDoor'
  Else If Value = ShippingServiceCodeType.UK_SellersStandardRate Then Result                              := 'UK_SellersStandardRate'
  Else If Value = ShippingServiceCodeType.UK_CollectInPerson Then Result                                  := 'UK_CollectInPerson'
  Else If Value = ShippingServiceCodeType.UK_SellersStandardInternationalRate Then Result                 := 'UK_SellersStandardInternationalRate'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailAirmailInternational Then Result                    := 'UK_RoyalMailAirmailInternational'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailAirsureInternational Then Result                    := 'UK_RoyalMailAirsureInternational'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailSurfaceMailInternational Then Result                := 'UK_RoyalMailSurfaceMailInternational'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailInternationalSignedFor Then Result                  := 'UK_RoyalMailInternationalSignedFor'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailHMForcesMailInternational Then Result               := 'UK_RoyalMailHMForcesMailInternational'
  Else If Value = ShippingServiceCodeType.UK_ParcelForceInternationalDatapost Then Result                 := 'UK_ParcelForceInternationalDatapost'
  Else If Value = ShippingServiceCodeType.UK_ParcelForceIreland24International Then Result                := 'UK_ParcelForceIreland24International'
  Else If Value = ShippingServiceCodeType.UK_ParcelForceEuro48International Then Result                   := 'UK_ParcelForceEuro48International'
  Else If Value = ShippingServiceCodeType.UK_ParcelForceInternationalScheduled Then Result                := 'UK_ParcelForceInternationalScheduled'
  Else If Value = ShippingServiceCodeType.UK_OtherCourierOrDeliveryInternational Then Result              := 'UK_OtherCourierOrDeliveryInternational'
  Else If Value = ShippingServiceCodeType.UK_CollectInPersonInternational Then Result                     := 'UK_CollectInPersonInternational'
  Else If Value = ShippingServiceCodeType.UK_ParcelForceIntlExpress Then Result                           := 'UK_ParcelForceIntlExpress'
  Else If Value = ShippingServiceCodeType.UK_ParcelForceIntlValue Then Result                             := 'UK_ParcelForceIntlValue'
  Else If Value = ShippingServiceCodeType.UK_ParcelForceIntlEconomy Then Result                           := 'UK_ParcelForceIntlEconomy'
  Else If Value = ShippingServiceCodeType.UK_TrackedDeliveryFromAbroad Then Result                        := 'UK_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.UK_IntlTrackedPostage Then Result                               := 'UK_IntlTrackedPostage'
  Else If Value = ShippingServiceCodeType.IE_SellersStandardRate Then Result                              := 'IE_SellersStandardRate'
  Else If Value = ShippingServiceCodeType.IE_FirstClassLetterService Then Result                          := 'IE_FirstClassLetterService'
  Else If Value = ShippingServiceCodeType.IE_SwiftPostNational Then Result                                := 'IE_SwiftPostNational'
  Else If Value = ShippingServiceCodeType.IE_RegisteredPost Then Result                                   := 'IE_RegisteredPost'
  Else If Value = ShippingServiceCodeType.IE_EMSSDSCourier Then Result                                    := 'IE_EMSSDSCourier'
  Else If Value = ShippingServiceCodeType.IE_EconomySDSCourier Then Result                                := 'IE_EconomySDSCourier'
  Else If Value = ShippingServiceCodeType.IE_OtherCourier Then Result                                     := 'IE_OtherCourier'
  Else If Value = ShippingServiceCodeType.IE_CollectionInPerson Then Result                               := 'IE_CollectionInPerson'
  Else If Value = ShippingServiceCodeType.IE_SellersStandardRateInternational Then Result                 := 'IE_SellersStandardRateInternational'
  Else If Value = ShippingServiceCodeType.IE_InternationalEconomyService Then Result                      := 'IE_InternationalEconomyService'
  Else If Value = ShippingServiceCodeType.IE_InternationalPriorityService Then Result                     := 'IE_InternationalPriorityService'
  Else If Value = ShippingServiceCodeType.IE_SwiftPostExpressInternational Then Result                    := 'IE_SwiftPostExpressInternational'
  Else If Value = ShippingServiceCodeType.IE_SwiftPostInternational Then Result                           := 'IE_SwiftPostInternational'
  Else If Value = ShippingServiceCodeType.IE_EMSSDSCourierInternational Then Result                       := 'IE_EMSSDSCourierInternational'
  Else If Value = ShippingServiceCodeType.IE_EconomySDSCourierInternational Then Result                   := 'IE_EconomySDSCourierInternational'
  Else If Value = ShippingServiceCodeType.IE_OtherCourierInternational Then Result                        := 'IE_OtherCourierInternational'
  Else If Value = ShippingServiceCodeType.IE_CollectionInPersonInternational Then Result                  := 'IE_CollectionInPersonInternational'
  Else If Value = ShippingServiceCodeType.IE_EconomyDeliveryFromAbroad Then Result                        := 'IE_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.IE_StandardDeliveryFromAbroad Then Result                       := 'IE_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.IE_ExpressDeliveryFromAbroad Then Result                        := 'IE_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.IE_TrackedDeliveryFromAbroad Then Result                        := 'IE_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.PL_DomesticRegular Then Result                                  := 'PL_DomesticRegular'
  Else If Value = ShippingServiceCodeType.PL_DomesticSpecial Then Result                                  := 'PL_DomesticSpecial'
  Else If Value = ShippingServiceCodeType.PL_EconomyDeliveryFromAbroad Then Result                        := 'PL_EconomyDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.PL_StandardDeliveryFromAbroad Then Result                       := 'PL_StandardDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.PL_ExpressDeliveryFromAbroad Then Result                        := 'PL_ExpressDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.PL_TrackedDeliveryFromAbroad Then Result                        := 'PL_TrackedDeliveryFromAbroad'
  Else If Value = ShippingServiceCodeType.FreightShipping Then Result                                     := 'FreightShipping'
  Else If Value = ShippingServiceCodeType.FreightOtherShipping Then Result                                := 'FreightOtherShipping'
  Else If Value = ShippingServiceCodeType.Freight Then Result                                             := 'Freight'
  Else If Value = ShippingServiceCodeType.FreightShippingInternational Then Result                        := 'FreightShippingInternational'
  Else If Value = ShippingServiceCodeType.USPSGround Then Result                                          := 'USPSGround'
  Else If Value = ShippingServiceCodeType.ShippingMethodOvernight Then Result                             := 'ShippingMethodOvernight'
  Else If Value = ShippingServiceCodeType.CustomCode Then Result                                          := 'CustomCode'
  Else If Value = ShippingServiceCodeType.USPSPriorityFlatRateEnvelope Then Result                        := 'USPSPriorityFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.USPSPriorityFlatRateBox Then Result                             := 'USPSPriorityFlatRateBox'
  Else If Value = ShippingServiceCodeType.USPSGlobalPrioritySmallEnvelope Then Result                     := 'USPSGlobalPrioritySmallEnvelope'
  Else If Value = ShippingServiceCodeType.USPSGlobalPriorityLargeEnvelope Then Result                     := 'USPSGlobalPriorityLargeEnvelope'
  Else If Value = ShippingServiceCodeType.USPSExpressFlatRateEnvelope Then Result                         := 'USPSExpressFlatRateEnvelope'
  Else If Value = ShippingServiceCodeType.UPSWorldWideExpressBox10kg Then Result                          := 'UPSWorldWideExpressBox10kg'
  Else If Value = ShippingServiceCodeType.UPSWorldWideExpressBox25kg Then Result                          := 'UPSWorldWideExpressBox25kg'
  Else If Value = ShippingServiceCodeType.UPSWorldWideExpressPlusBox10kg Then Result                      := 'UPSWorldWideExpressPlusBox10kg'
  Else If Value = ShippingServiceCodeType.UPSWorldWideExpressPlusBox25kg Then Result                      := 'UPSWorldWideExpressPlusBox25kg'
  Else If Value = ShippingServiceCodeType.HK_LocalPickUpOnly Then Result                                  := 'HK_LocalPickUpOnly'
  Else If Value = ShippingServiceCodeType.HK_LocalCourier Then Result                                     := 'HK_LocalCourier'
  Else If Value = ShippingServiceCodeType.HK_DomesticRegularShipping Then Result                          := 'HK_DomesticRegularShipping'
  Else If Value = ShippingServiceCodeType.HK_DomesticSpecialShipping Then Result                          := 'HK_DomesticSpecialShipping'
  Else If Value = ShippingServiceCodeType.HK_InternationalRegularShipping Then Result                     := 'HK_InternationalRegularShipping'
  Else If Value = ShippingServiceCodeType.HK_InternationalSpecialShipping Then Result                     := 'HK_InternationalSpecialShipping'
  Else If Value = ShippingServiceCodeType.SG_LocalPickUpOnly Then Result                                  := 'SG_LocalPickUpOnly'
  Else If Value = ShippingServiceCodeType.SG_LocalCourier Then Result                                     := 'SG_LocalCourier'
  Else If Value = ShippingServiceCodeType.SG_DomesticStandardMail Then Result                             := 'SG_DomesticStandardMail'
  Else If Value = ShippingServiceCodeType.SG_DomesticNonStandardMail Then Result                          := 'SG_DomesticNonStandardMail'
  Else If Value = ShippingServiceCodeType.SG_DomesticSpeedpostIslandwide Then Result                      := 'SG_DomesticSpeedpostIslandwide'
  Else If Value = ShippingServiceCodeType.SG_InternationalStandardMail Then Result                        := 'SG_InternationalStandardMail'
  Else If Value = ShippingServiceCodeType.SG_InternationalExpressMailService Then Result                  := 'SG_InternationalExpressMailService'
  Else If Value = ShippingServiceCodeType.SG_InternationalCourier Then Result                             := 'SG_InternationalCourier'
  Else If Value = ShippingServiceCodeType.BENL_DePostZendingNONPRIOR Then Result                          := 'BENL_DePostZendingNONPRIOR'
  Else If Value = ShippingServiceCodeType.BENL_DePostZendingPRIOR Then Result                             := 'BENL_DePostZendingPRIOR'
  Else If Value = ShippingServiceCodeType.BENL_DePostZendingAangetekend Then Result                       := 'BENL_DePostZendingAangetekend'
  Else If Value = ShippingServiceCodeType.BENL_KilopostPakje Then Result                                  := 'BENL_KilopostPakje'
  Else If Value = ShippingServiceCodeType.BENL_Taxipost Then Result                                       := 'BENL_Taxipost'
  Else If Value = ShippingServiceCodeType.BENL_KialaAfhaalpunt Then Result                                := 'BENL_KialaAfhaalpunt'
  Else If Value = ShippingServiceCodeType.BENL_VasteKostenStandaardVerzending Then Result                 := 'BENL_VasteKostenStandaardVerzending'
  Else If Value = ShippingServiceCodeType.BENL_VasteKostenVersneldeVerzending Then Result                 := 'BENL_VasteKostenVersneldeVerzending'
  Else If Value = ShippingServiceCodeType.BENL_VerzekerdeVerzending Then Result                           := 'BENL_VerzekerdeVerzending'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteEnvoiNONPRIOR Then Result                           := 'BEFR_LaPosteEnvoiNONPRIOR'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteEnvoiPRIOR Then Result                              := 'BEFR_LaPosteEnvoiPRIOR'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteEnvoiRecommande Then Result                         := 'BEFR_LaPosteEnvoiRecommande'
  Else If Value = ShippingServiceCodeType.BEFR_PaquetKilopost Then Result                                 := 'BEFR_PaquetKilopost'
  Else If Value = ShippingServiceCodeType.BEFR_Taxipost Then Result                                       := 'BEFR_Taxipost'
  Else If Value = ShippingServiceCodeType.BEFR_PointRetraitKiala Then Result                              := 'BEFR_PointRetraitKiala'
  Else If Value = ShippingServiceCodeType.BEFR_LivraisonStandardPrixforFaitaire Then Result               := 'BEFR_LivraisonStandardPrixforFaitaire'
  Else If Value = ShippingServiceCodeType.BEFR_LivraisonExpressPrixforFaitaire Then Result                := 'BEFR_LivraisonExpressPrixforFaitaire'
  Else If Value = ShippingServiceCodeType.BEFR_LivraisonSecurise Then Result                              := 'BEFR_LivraisonSecurise'
  Else If Value = ShippingServiceCodeType.BENL_DePostZendingPRIORInternational Then Result                := 'BENL_DePostZendingPRIORInternational'
  Else If Value = ShippingServiceCodeType.BENL_DePostZendingNONPRIORInternational Then Result             := 'BENL_DePostZendingNONPRIORInternational'
  Else If Value = ShippingServiceCodeType.BENL_DePostZendingAangetekendInternational Then Result          := 'BENL_DePostZendingAangetekendInternational'
  Else If Value = ShippingServiceCodeType.BENL_KilopostPakjeInternational Then Result                     := 'BENL_KilopostPakjeInternational'
  Else If Value = ShippingServiceCodeType.BENL_TaxipostExpressverzending Then Result                      := 'BENL_TaxipostExpressverzending'
  Else If Value = ShippingServiceCodeType.BENL_VerzekerdeVerzendingInternational Then Result              := 'BENL_VerzekerdeVerzendingInternational'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteenvoiePRIOR Then Result                             := 'BEFR_LaPosteenvoiePRIOR'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteenvoieNONPRIOR Then Result                          := 'BEFR_LaPosteenvoieNONPRIOR'
  Else If Value = ShippingServiceCodeType.BEFR_LaPosteenvoieRecommande Then Result                        := 'BEFR_LaPosteenvoieRecommande'
  Else If Value = ShippingServiceCodeType.BEFR_PaquetKilopostInternationale Then Result                   := 'BEFR_PaquetKilopostInternationale'
  Else If Value = ShippingServiceCodeType.BEFR_ExpressTaxipost Then Result                                := 'BEFR_ExpressTaxipost'
  Else If Value = ShippingServiceCodeType.BEFR_LivraisonStandardInternationalePrixforFaitaire  Then Result := 'BEFR_LivraisonStandardInternationalePrixforFaitaire'
  Else If Value = ShippingServiceCodeType.BEFR_LivraisonExpressInternationalePrixforFaitaire Then Result  := 'BEFR_LivraisonExpressInternationalePrixforFaitaire'
  Else If Value = ShippingServiceCodeType.BEFR_LivraisonSecuriseInternational Then Result                 := 'BEFR_LivraisonSecuriseInternational'
  Else If Value = ShippingServiceCodeType.FR_Chronopost Then Result                                       := 'FR_Chronopost'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailSpecialDeliveryNextDay Then Result                  := 'UK_RoyalMailSpecialDeliveryNextDay'
  Else If Value = ShippingServiceCodeType.CA_PostLightPacketInternational Then Result                     := 'CA_PostLightPacketInternational'
  Else If Value = ShippingServiceCodeType.CA_PostLightPacketUSA Then Result                               := 'CA_PostLightPacketUSA'
  Else If Value = ShippingServiceCodeType.PL_DHLInternational Then Result                                 := 'PL_DHLInternational'
  Else If Value = ShippingServiceCodeType.PL_InternationalRegular Then Result                             := 'PL_InternationalRegular'
  Else If Value = ShippingServiceCodeType.PL_InternationalSpecial Then Result                             := 'PL_InternationalSpecial'
  Else If Value = ShippingServiceCodeType.PL_UPSInternational Then Result                                 := 'PL_UPSInternational'
  Else If Value = ShippingServiceCodeType.CAFR_StandardDelivery Then Result                               := 'CAFR_StandardDelivery'
  Else If Value = ShippingServiceCodeType.CAFR_ExpeditedDelivery Then Result                              := 'CAFR_ExpeditedDelivery'
  Else If Value = ShippingServiceCodeType.CAFR_PostLettermail Then Result                                 := 'CAFR_PostLettermail'
  Else If Value = ShippingServiceCodeType.CAFR_PostRegularParcel Then Result                              := 'CAFR_PostRegularParcel'
  Else If Value = ShippingServiceCodeType.CAFR_PostExpeditedParcel Then Result                            := 'CAFR_PostExpeditedParcel'
  Else If Value = ShippingServiceCodeType.CAFR_PostXpresspost Then Result                                 := 'CAFR_PostXpresspost'
  Else If Value = ShippingServiceCodeType.CAFR_PostPriorityCourier Then Result                            := 'CAFR_PostPriorityCourier'
  Else If Value = ShippingServiceCodeType.CAFR_StandardInternational Then Result                          := 'CAFR_StandardInternational'
  Else If Value = ShippingServiceCodeType.CAFR_ExpeditedInternational Then Result                         := 'CAFR_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.CAFR_OtherInternational Then Result                             := 'CAFR_OtherInternational'
  Else If Value = ShippingServiceCodeType.CAFR_PostExpeditedParcelUSA Then Result                         := 'CAFR_PostExpeditedParcelUSA'
  Else If Value = ShippingServiceCodeType.CAFR_PostSmallPacketsUSA Then Result                            := 'CAFR_PostSmallPacketsUSA'
  Else If Value = ShippingServiceCodeType.CAFR_PostXpresspostUSA Then Result                              := 'CAFR_PostXpresspostUSA'
  Else If Value = ShippingServiceCodeType.CAFR_PostXpresspostInternational Then Result                    := 'CAFR_PostXpresspostInternational'
  Else If Value = ShippingServiceCodeType.CAFR_PostInternationalParcelSurface Then Result                 := 'CAFR_PostInternationalParcelSurface'
  Else If Value = ShippingServiceCodeType.CAFR_PostInternationalParcelAir Then Result                     := 'CAFR_PostInternationalParcelAir'
  Else If Value = ShippingServiceCodeType.CAFR_SmallPacketsInternational Then Result                      := 'CAFR_SmallPacketsInternational'
  Else If Value = ShippingServiceCodeType.CAFR_PurolatorInternational Then Result                         := 'CAFR_PurolatorInternational'
  Else If Value = ShippingServiceCodeType.CAFR_PostSmallPacketsUSAGround Then Result                      := 'CAFR_PostSmallPacketsUSAGround'
  Else If Value = ShippingServiceCodeType.CAFR_PostSmallPacketsUSAAir Then Result                         := 'CAFR_PostSmallPacketsUSAAir'
  Else If Value = ShippingServiceCodeType.CAFR_SmallPacketsInternationalGround Then Result                := 'CAFR_SmallPacketsInternationalGround'
  Else If Value = ShippingServiceCodeType.CAFR_SmallPacketsInternationalAir Then Result                   := 'CAFR_SmallPacketsInternationalAir'
  Else If Value = ShippingServiceCodeType.CAFR_PostUSALetterPost Then Result                              := 'CAFR_PostUSALetterPost'
  Else If Value = ShippingServiceCodeType.CAFR_PostInternationalLetterPost Then Result                    := 'CAFR_PostInternationalLetterPost'
  Else If Value = ShippingServiceCodeType.CAFR_UPSExpressCanada Then Result                               := 'CAFR_UPSExpressCanada'
  Else If Value = ShippingServiceCodeType.CAFR_UPSExpressSaverCanada Then Result                          := 'CAFR_UPSExpressSaverCanada'
  Else If Value = ShippingServiceCodeType.CAFR_UPSExpeditedCanada Then Result                             := 'CAFR_UPSExpeditedCanada'
  Else If Value = ShippingServiceCodeType.CAFR_UPSStandardCanada Then Result                              := 'CAFR_UPSStandardCanada'
  Else If Value = ShippingServiceCodeType.CAFR_UPSExpressUnitedStates Then Result                         := 'CAFR_UPSExpressUnitedStates'
  Else If Value = ShippingServiceCodeType.CAFR_UPSExpeditedUnitedStates Then Result                       := 'CAFR_UPSExpeditedUnitedStates'
  Else If Value = ShippingServiceCodeType.CAFR_UPS3DaySelectUnitedStates Then Result                      := 'CAFR_UPS3DaySelectUnitedStates'
  Else If Value = ShippingServiceCodeType.CAFR_UPSStandardUnitedStates Then Result                        := 'CAFR_UPSStandardUnitedStates'
  Else If Value = ShippingServiceCodeType.CAFR_UPSWorldWideExpress Then Result                            := 'CAFR_UPSWorldWideExpress'
  Else If Value = ShippingServiceCodeType.CAFR_UPSWorldWideExpedited Then Result                          := 'CAFR_UPSWorldWideExpedited'
  Else If Value = ShippingServiceCodeType.UK_RoyalMailSpecialDelivery9am Then Result                      := 'UK_RoyalMailSpecialDelivery9am'
  Else If Value = ShippingServiceCodeType.USPSFirstClassMailInternational Then Result                     := 'USPSFirstClassMailInternational'
  Else If Value = ShippingServiceCodeType.USPSPriorityMailInternational Then Result                       := 'USPSPriorityMailInternational'
  Else If Value = ShippingServiceCodeType.USPSExpressMailInternational Then Result                        := 'USPSExpressMailInternational'
  Else If Value = ShippingServiceCodeType.CH_StandardInternational Then Result                            := 'CH_StandardInternational'
  Else If Value = ShippingServiceCodeType.CH_ExpeditedInternational Then Result                           := 'CH_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.CH_SonstigerVersandSieheArtikelbeschreibung Then Result         := 'CH_SonstigerVersandSieheArtikelbeschreibung'
  Else If Value = ShippingServiceCodeType.TW_StandardInternationalFixedRate Then Result                   := 'TW_StandardInternationalFixedRate'
  Else If Value = ShippingServiceCodeType.TW_ExpeditedInternationalFixedRate Then Result                  := 'TW_ExpeditedInternationalFixedRate'
  Else If Value = ShippingServiceCodeType.USPSGlobalExpressGuaranteed Then Result                         := 'USPSGlobalExpressGuaranteed'
  Else If Value = ShippingServiceCodeType.AU_RegularWithInsurance Then Result                             := 'AU_RegularWithInsurance'
  Else If Value = ShippingServiceCodeType.AU_ExpressWithInsurance Then Result                             := 'AU_ExpressWithInsurance'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostWarensendungInternational Then Result            := 'DE_DeutschePostWarensendungInternational'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostByendung Then Result                             := 'DE_DeutschePostByendung'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketUnversichertInternational Then Result             := 'DE_HermesPaketUnversichertInternational'
  Else If Value = ShippingServiceCodeType.DE_HermesPaketVersichertInternational Then Result               := 'DE_HermesPaketVersichertInternational'
  Else If Value = ShippingServiceCodeType.DE_iLoxxTransportXXLInternational Then Result                   := 'DE_iLoxxTransportXXLInternational'
  Else If Value = ShippingServiceCodeType.DE_iLoxxUbernachtExpressInternational Then Result               := 'DE_iLoxxUbernachtExpressInternational'
  Else If Value = ShippingServiceCodeType.DE_iLoxxStandardInternational Then Result                       := 'DE_iLoxxStandardInternational'
  Else If Value = ShippingServiceCodeType.DE_StandardInternational Then Result                            := 'DE_StandardInternational'
  Else If Value = ShippingServiceCodeType.DE_ExpeditedInternational Then Result                           := 'DE_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostBriefIntlEcon Then Result                        := 'DE_DeutschePostBriefIntlEcon'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostBriefIntlPri Then Result                         := 'DE_DeutschePostBriefIntlPri'
  Else If Value = ShippingServiceCodeType.AT_BitteTreffenSieEineAuswahl Then Result                       := 'AT_BitteTreffenSieEineAuswahl'
  Else If Value = ShippingServiceCodeType.AT_EinschreibenVersandInklEinschreibengebuhr Then Result        := 'AT_EinschreibenVersandInklEinschreibengebuhr'
  Else If Value = ShippingServiceCodeType.AT_NachnahmeVersandInklNachnahmegebuhr Then Result              := 'AT_NachnahmeVersandInklNachnahmegebuhr'
  Else If Value = ShippingServiceCodeType.AT_ExpressOrCourierInternational Then Result                    := 'AT_ExpressOrCourierInternational'
  Else If Value = ShippingServiceCodeType.AT_InsuredExpressOrCourierInternational Then Result             := 'AT_InsuredExpressOrCourierInternational'
  Else If Value = ShippingServiceCodeType.AT_SpecialDispatchInternational Then Result                     := 'AT_SpecialDispatchInternational'
  Else If Value = ShippingServiceCodeType.AT_InsuredSpecialDispatchInternational Then Result              := 'AT_InsuredSpecialDispatchInternational'
  Else If Value = ShippingServiceCodeType.AT_StandardInternational Then Result                            := 'AT_StandardInternational'
  Else If Value = ShippingServiceCodeType.AT_ExpeditedInternational Then Result                           := 'AT_ExpeditedInternational'
  Else If Value = ShippingServiceCodeType.AT_OtherInternationalShipping Then Result                       := 'AT_OtherInternationalShipping'
  Else If Value = ShippingServiceCodeType.CH_BitteTreffenSieEineAuswahl Then Result                       := 'CH_BitteTreffenSieEineAuswahl'
  Else If Value = ShippingServiceCodeType.CH_UnversicherterVersand Then Result                            := 'CH_UnversicherterVersand'
  Else If Value = ShippingServiceCodeType.CH_VersicherterVersand Then Result                              := 'CH_VersicherterVersand'
  Else If Value = ShippingServiceCodeType.CH_EinschreibenVersandInklEinschreibengebuhr Then Result        := 'CH_EinschreibenVersandInklEinschreibengebuhr'
  Else If Value = ShippingServiceCodeType.CH_NachnahmeVersandInklNachnahmegebuhr Then Result              := 'CH_NachnahmeVersandInklNachnahmegebuhr'
  Else If Value = ShippingServiceCodeType.CH_ExpressOrCourierInternational Then Result                    := 'CH_ExpressOrCourierInternational'
  Else If Value = ShippingServiceCodeType.CH_InsuredExpressOrCourierInternational Then Result             := 'CH_InsuredExpressOrCourierInternational'
  Else If Value = ShippingServiceCodeType.CH_SonderversandZBSperrgutKFZ Then Result                       := 'CH_SonderversandZBSperrgutKFZ'
  Else If Value = ShippingServiceCodeType.CH_VersicherterSonderversandZBSperrgutKFZ Then Result           := 'CH_VersicherterSonderversandZBSperrgutKFZ'
  Else If Value = ShippingServiceCodeType.CH_StandardversandAPostPriority Then Result                     := 'CH_StandardversandAPostPriority'
  Else If Value = ShippingServiceCodeType.CH_StandardversandBPostEconomy Then Result                      := 'CH_StandardversandBPostEconomy'
  Else If Value = ShippingServiceCodeType.DE_BitteTreffenSieEineAuswahl Then Result                       := 'DE_BitteTreffenSieEineAuswahl'
  Else If Value = ShippingServiceCodeType.DE_EinschreibenVersandInklEinschreibengebuhr Then Result        := 'DE_EinschreibenVersandInklEinschreibengebuhr'
  Else If Value = ShippingServiceCodeType.DE_NachnahmeVersandInklNachnahmegebuhr Then Result              := 'DE_NachnahmeVersandInklNachnahmegebuhr'
  Else If Value = ShippingServiceCodeType.DE_ExpressOrCourierInternational Then Result                    := 'DE_ExpressOrCourierInternational'
  Else If Value = ShippingServiceCodeType.DE_InsuredExpressOrCourierInternational Then Result             := 'DE_InsuredExpressOrCourierInternational'
  Else If Value = ShippingServiceCodeType.DE_SonderversandZBMobelKFZ Then Result                          := 'DE_SonderversandZBMobelKFZ'
  Else If Value = ShippingServiceCodeType.DE_VersicherterSonderversandZBMobelKFZ Then Result              := 'DE_VersicherterSonderversandZBMobelKFZ'
  Else If Value = ShippingServiceCodeType.DE_DeutschePostBriefInternational Then Result                   := 'DE_DeutschePostBriefInternational'
  Else If Value = ShippingServiceCodeType.IE_StandardInternationalFlatRatePostage Then Result             := 'IE_StandardInternationalFlatRatePostage'
  Else If Value = ShippingServiceCodeType.IE_ExpeditedInternationalFlatRatePostage Then Result            := 'IE_ExpeditedInternationalFlatRatePostage'
  Else If Value = ShippingServiceCodeType.IE_OtherInternationalPostage Then Result                        := 'IE_OtherInternationalPostage'
  Else If Value = ShippingServiceCodeType.UK_StandardInternationalFlatRatePostage Then Result             := 'UK_StandardInternationalFlatRatePostage'
  Else If Value = ShippingServiceCodeType.UK_ExpeditedInternationalFlatRatePostage Then Result            := 'UK_ExpeditedInternationalFlatRatePostage'
  Else If Value = ShippingServiceCodeType.UK_OtherInternationalPostage Then Result                        := 'UK_OtherInternationalPostage'
  Else If Value = ShippingServiceCodeType.FR_ChronopostChronoRelais Then Result                           := 'FR_ChronopostChronoRelais'
  Else If Value = ShippingServiceCodeType.FR_Chrono10 Then Result                                         := 'FR_Chrono10'
  Else If Value = ShippingServiceCodeType.FR_Chrono13 Then Result                                         := 'FR_Chrono13'
  Else If Value = ShippingServiceCodeType.FR_Chrono18 Then Result                                         := 'FR_Chrono18'
  Else If Value = ShippingServiceCodeType.FR_ChronopostExpressInternational Then Result                   := 'FR_ChronopostExpressInternational'
  Else If Value = ShippingServiceCodeType.Pickup Then Result                                              := 'Pickup'
  Else If Value = ShippingServiceCodeType.Delivery Then Result                                            := 'Delivery'
  Else If Value = ShippingServiceCodeType.CA_Pickup Then Result                                           := 'CA_Pickup'
  Else If Value = ShippingServiceCodeType.DE_Pickup Then Result                                           := 'DE_Pickup'
  Else If Value = ShippingServiceCodeType.AU_Pickup Then Result                                           := 'AU_Pickup'
  Else If Value = ShippingServiceCodeType.AU_SmallParcels Then Result                                     := 'AU_SmallParcels'
  Else If Value = ShippingServiceCodeType.AU_SmallParcelWithTracking Then Result                          := 'AU_SmallParcelWithTracking'
  Else If Value = ShippingServiceCodeType.AU_SmallParcelWithTrackingAndSignature Then Result              := 'AU_SmallParcelWithTrackingAndSignature'
  Else If Value = ShippingServiceCodeType.AU_RegularParcelWithTracking Then Result                        := 'AU_RegularParcelWithTracking'
  Else If Value = ShippingServiceCodeType.AU_RegularParcelWithTrackingAndSignature Then Result            := 'AU_RegularParcelWithTrackingAndSignature'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostSatchel5kg Then Result                     := 'AU_PrePaidExpressPostSatchel5kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidParcelPostSatchels500g Then Result                    := 'AU_PrePaidParcelPostSatchels500g'
  Else If Value = ShippingServiceCodeType.AU_PrePaidParcelPostSatchels3kg Then Result                     := 'AU_PrePaidParcelPostSatchels3kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidParcelPostSatchels5kg Then Result                     := 'AU_PrePaidParcelPostSatchels5kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostSatchel500g Then Result                    := 'AU_PrePaidExpressPostSatchel500g'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostSatchel3kg Then Result                     := 'AU_PrePaidExpressPostSatchel3kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostPlatinum500g Then Result                   := 'AU_PrePaidExpressPostPlatinum500g'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostPlatinum3kg Then Result                    := 'AU_PrePaidExpressPostPlatinum3kg'
  Else If Value = ShippingServiceCodeType.AU_ExpressCourierInternational Then Result                      := 'AU_ExpressCourierInternational'
  Else If Value = ShippingServiceCodeType.AU_ExpressPostInternational Then Result                         := 'AU_ExpressPostInternational'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostInternationalEnvelopeC5 Then Result        := 'AU_PrePaidExpressPostInternationalEnvelopeC5'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostInternationalEnvelopeB4 Then Result        := 'AU_PrePaidExpressPostInternationalEnvelopeB4'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostInternationalSatchels2kg Then Result       := 'AU_PrePaidExpressPostInternationalSatchels2kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostInternationalSatchels3kg Then Result       := 'AU_PrePaidExpressPostInternationalSatchels3kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostInternationalBox5kg Then Result            := 'AU_PrePaidExpressPostInternationalBox5kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostInternationalBox10kg Then Result           := 'AU_PrePaidExpressPostInternationalBox10kg'
  Else If Value = ShippingServiceCodeType.AU_PrePaidExpressPostInternationalBox20kg Then Result           := 'AU_PrePaidExpressPostInternationalBox20kg'
  Else If Value = ShippingServiceCodeType.AU_RegisteredParcelPost Then Result                             := 'AU_RegisteredParcelPost'
  Else If Value = ShippingServiceCodeType.AU_RegisteredSmallParcel Then Result                            := 'AU_RegisteredSmallParcel'
  Else If Value = ShippingServiceCodeType.AU_RegisteredParcelPostPrepaidSatchel500g Then Result           := 'AU_RegisteredParcelPostPrepaidSatchel500g'
  Else If Value = ShippingServiceCodeType.AU_RegisteredParcelPostPrepaidSatchel3kg Then Result            := 'AU_RegisteredParcelPostPrepaidSatchel3kg'
  Else If Value = ShippingServiceCodeType.AU_RegisteredParcelPostPrepaidSatchel5kg Then Result            := 'AU_RegisteredParcelPostPrepaidSatchel5kg'
  Else If Value = ShippingServiceCodeType.AU_ExpressPostSatchel500g Then Result                           := 'AU_ExpressPostSatchel500g'
  Else If Value = ShippingServiceCodeType.AU_ExpressPostSatchel3kg Then Result                            := 'AU_ExpressPostSatchel3kg'
  Else If Value = ShippingServiceCodeType.FR_Pickup Then Result                                           := 'FR_Pickup'
  Else If Value = ShippingServiceCodeType.AT_Pickup Then Result                                           := 'AT_Pickup'
  Else If Value = ShippingServiceCodeType.BENL_Pickup Then Result                                         := 'BENL_Pickup'
  Else If Value = ShippingServiceCodeType.BEFR_Pickup Then Result                                         := 'BEFR_Pickup'
  Else If Value = ShippingServiceCodeType.CH_Pickup Then Result                                           := 'CH_Pickup'
  Else If Value = ShippingServiceCodeType.IT_Pickup Then Result                                           := 'IT_Pickup'
  Else If Value = ShippingServiceCodeType.NL_Pickup Then Result                                           := 'NL_Pickup'
  Else If Value = ShippingServiceCodeType.PL_Pickup Then Result                                           := 'PL_Pickup'
  Else If Value = ShippingServiceCodeType.ES_Pickup Then Result                                           := 'ES_Pickup'
  Else If Value = ShippingServiceCodeType.SG_Delivery Then Result                                         := 'SG_Delivery'
  Else If Value = ShippingServiceCodeType.UK_OtherCourier24 Then Result                                   := 'UK_OtherCourier24'
  Else If Value = ShippingServiceCodeType.UK_OtherCourier48 Then Result                                   := 'UK_OtherCourier48'
  Else If Value = ShippingServiceCodeType.UK_OtherCourier3Days Then Result                                := 'UK_OtherCourier3Days'
  Else If Value = ShippingServiceCodeType.UK_OtherCourier5Days Then Result                                := 'UK_OtherCourier5Days'
  Else If Value = ShippingServiceCodeType.Courier Then Result                                             := 'Courier'
  Else If Value = ShippingServiceCodeType.FedExPriorityOvernight Then Result                              := 'FedExPriorityOvernight'
  Else If Value = ShippingServiceCodeType.FedExStandardOvernight Then Result                              := 'FedExStandardOvernight'
  Else If Value = ShippingServiceCodeType.FedEx2Day Then Result                                           := 'FedEx2Day'
  Else If Value = ShippingServiceCodeType.FedExGround Then Result                                         := 'FedExGround'
  Else If Value = ShippingServiceCodeType.FedExHomeDelivery Then Result                                   := 'FedExHomeDelivery'
  Else If Value = ShippingServiceCodeType.FedExExpressSaver Then Result                                   := 'FedExExpressSaver'
  Else If Value = ShippingServiceCodeType.FedExGroundDisabled Then Result                                 := 'FedExGroundDisabled'
  Else If Value = ShippingServiceCodeType.FedExHomeDeliveryDisabled Then Result                           := 'FedExHomeDeliveryDisabled'
  Else If Value = ShippingServiceCodeType.FedExInternationalFirst Then Result                             := 'FedExInternationalFirst'
  Else If Value = ShippingServiceCodeType.FedExInternationalPriority Then Result                          := 'FedExInternationalPriority'
  Else If Value = ShippingServiceCodeType.FedExInternationalEconomy Then Result                           := 'FedExInternationalEconomy'
  Else If Value = ShippingServiceCodeType.FedExInternationalGround Then Result                            := 'FedExInternationalGround'
  Else If Value = ShippingServiceCodeType.EconomyShippingFromOutsideUS Then Result                        := 'EconomyShippingFromOutsideUS'
  Else If Value = ShippingServiceCodeType.ExpeditedShippingFromOutsideUS Then Result                      := 'ExpeditedShippingFromOutsideUS'
  Else If Value = ShippingServiceCodeType.StandardShippingFromOutsideUS Then Result                       := 'StandardShippingFromOutsideUS'
  Else If Value = ShippingServiceCodeType.UK_EconomyShippingFromOutside Then Result                       := 'UK_EconomyShippingFromOutside'
  Else If Value = ShippingServiceCodeType.UK_ExpeditedShippingFromOutside Then Result                     := 'UK_ExpeditedShippingFromOutside'
  Else If Value = ShippingServiceCodeType.UK_StandardShippingFromOutside Then Result                      := 'UK_StandardShippingFromOutside'
  Else If Value = ShippingServiceCodeType.DE_SparversandAusDemAusland Then Result                         := 'DE_SparversandAusDemAusland'
  Else If Value = ShippingServiceCodeType.DE_StandardversandAusDemAusland Then Result                     := 'DE_StandardversandAusDemAusland'
  Else If Value = ShippingServiceCodeType.DE_ExpressversandAusDemAusland Then Result                      := 'DE_ExpressversandAusDemAusland'
  Else If Value = ShippingServiceCodeType.DE_DHL2KGPaket Then Result                                      := 'DE_DHL2KGPaket'
  Else If Value = ShippingServiceCodeType.InternationalPriorityShipping Then Result                       := 'InternationalPriorityShipping'
  Else If Value = ShippingServiceCodeType.SameDayShipping Then Result                                     := 'SameDayShipping'
  Else Result                                                                                             := '';
End;

Function enumToStr(Const Value: ShipmentDeliveryStatusCodeType): String;
Begin
       If Value =ShipmentDeliveryStatusCodeType.Created Then Result           := 'Created'
  Else If Value = ShipmentDeliveryStatusCodeType.DroppedOff Then Result   := 'DroppedOff'
  Else If Value = ShipmentDeliveryStatusCodeType.InTransit Then Result    := 'InTransit'
  Else If Value = ShipmentDeliveryStatusCodeType.Delivered Then Result    := 'Delivered'
  Else If Value = ShipmentDeliveryStatusCodeType.Returned Then Result     := 'Returned'
  Else If Value = ShipmentDeliveryStatusCodeType.Canceled Then Result     := 'Canceled'
  Else If Value = ShipmentDeliveryStatusCodeType.LabelPrinted  Then Result := 'LabelPrinted'
  Else If Value = ShipmentDeliveryStatusCodeType.Unconfirmed Then Result  := 'Unconfirmed'
  Else If Value = ShipmentDeliveryStatusCodeType.Unknown Then Result      := 'Unknown'
  Else If Value = ShipmentDeliveryStatusCodeType.Error Then Result        := 'Error'
  Else If Value = ShipmentDeliveryStatusCodeType.CustomCode Then Result   := 'CustomCode'
  Else Result                                                             := '';
End;

Function enumToStr(Const Value: ShipmentStatusCodeType): String;
Begin
       If Value =ShipmentStatusCodeType.Active Then Result        := 'Active'
  Else If Value = ShipmentStatusCodeType.Canceled  Then Result := 'Canceled'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: ShippingFeatureCodeType): String;
Begin
       If Value =ShippingFeatureCodeType.DeliveryConfirmation Then Result       := 'DeliveryConfirmation'
  Else If Value = ShippingFeatureCodeType.SignatureConfirmation  Then Result := 'SignatureConfirmation'
  Else If Value = ShippingFeatureCodeType.StealthPostage Then Result        := 'StealthPostage'
  Else If Value = ShippingFeatureCodeType.SaturdayDelivery Then Result      := 'SaturdayDelivery'
  Else If Value = ShippingFeatureCodeType.Other Then Result                 := 'Other'
  Else If Value = ShippingFeatureCodeType.NotDefined Then Result            := 'NotDefined'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: MerchandizingPrefCodeType): String;
Begin
       If Value =MerchandizingPrefCodeType.OptIn Then Result       := 'OptIn'
  Else If Value = MerchandizingPrefCodeType.OptOut  Then Result := 'OptOut'
  Else Result                                                  := '';
End;

Function enumToStr(Const Value: SellerGuaranteeLevelCodeType): String;
Begin
       If Value =SellerGuaranteeLevelCodeType.NotEligible Then Result  := 'NotEligible'
  Else If Value = SellerGuaranteeLevelCodeType.Regular  Then Result := 'Regular'
  Else If Value = SellerGuaranteeLevelCodeType.Premium  Then Result := 'Premium'
  Else If Value = SellerGuaranteeLevelCodeType.Ultra Then Result   := 'Ultra'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: PayoutMethodType): String;
Begin
       If Value =PayoutMethodType.PAYPAL Then Result   := 'PAYPAL'
  Else If Value = PayoutMethodType.EFT  Then Result := 'EFT'
  Else Result                                      := '';
End;

Function enumToStr(Const Value: SellereBayPaymentProcessStatusCodeType): String;
Begin
       If Value =SellereBayPaymentProcessStatusCodeType.AcceptedUA Then Result                     := 'AcceptedUA'
  Else If Value = SellereBayPaymentProcessStatusCodeType.MustAcceptUA Then Result              := 'MustAcceptUA'
  Else If Value = SellereBayPaymentProcessStatusCodeType.EBayPaymentProcessEnabled  Then Result := 'eBayPaymentProcessEnabled'
  Else Result                                                                                  := '';
End;

(*Function enumToStr(Const Value: PaymentTypeCodeType): String;
Begin
       If Value =PaymentTypeCodeType.Sale Then Result                     := 'Sale'
  Else If Value = PaymentTypeCodeType.Refund Then Result              := 'Refund'
  Else If Value = PaymentTypeCodeType.SellerDeniedPayment  Then Result := 'SellerDeniedPayment'
  Else If Value = PaymentTypeCodeType.AdminReversal Then Result       := 'AdminReversal'
  Else If Value = PaymentTypeCodeType.AllOther Then Result            := 'AllOther'
  Else If Value = PaymentTypeCodeType.RentalExtension Then Result     := 'RentalExtension'
  Else If Value = PaymentTypeCodeType.RentalBuyout Then Result        := 'RentalBuyout'
  Else Result                                                         := '';
End;*)

Function enumToStr(Const Value: FedExRateOptionCodeType): String;
Begin
       If Value =FedExRateOptionCodeType.FedExStandardList Then Result    := 'FedExStandardList'
  Else If Value = FedExRateOptionCodeType.FedExCounter Then Result    := 'FedExCounter'
  Else If Value = FedExRateOptionCodeType.FedExDiscounted  Then Result := 'FedExDiscounted'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: USPSRateOptionCodeType): String;
Begin
       If Value =USPSRateOptionCodeType.USPSDiscounted Then Result  := 'USPSDiscounted'
  Else If Value = USPSRateOptionCodeType.USPSRetail  Then Result := 'USPSRetail'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: UPSRateOptionCodeType): String;
Begin
       If Value =UPSRateOptionCodeType.UPSDailyRates Then Result         := 'UPSDailyRates'
  Else If Value = UPSRateOptionCodeType.UPSOnDemandRates  Then Result := 'UPSOnDemandRates'
  Else Result                                                        := '';
End;

Function enumToStr(Const Value: DisplayPayNowButtonCodeType): String;
Begin
       If Value =DisplayPayNowButtonCodeType.ShowPayNowButtonForAllPaymentMethods  Then Result := 'ShowPayNowButtonForAllPaymentMethods'
  Else If Value = DisplayPayNowButtonCodeType.ShowPayNowButtonForPayPalOnly Then Result   := 'ShowPayNowButtonForPayPalOnly'
  Else Result                                                                             := '';
End;

Function enumToStr(Const Value: StoreItemListSortOrderCodeType): String;
Begin
       If Value =StoreItemListSortOrderCodeType.EndingFirst Then Result                    := 'EndingFirst'
  Else If Value = StoreItemListSortOrderCodeType.NewlyListed Then Result               := 'NewlyListed'
  Else If Value = StoreItemListSortOrderCodeType.LowestPriced Then Result              := 'LowestPriced'
  Else If Value = StoreItemListSortOrderCodeType.HighestPriced Then Result             := 'HighestPriced'
  Else If Value = StoreItemListSortOrderCodeType.LowestPricedPlusShipping Then Result  := 'LowestPricedPlusShipping'
  Else If Value = StoreItemListSortOrderCodeType.HighestPricedPlusShipping  Then Result := 'HighestPricedPlusShipping'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: SearchStandingStatusCodeType): String;
Begin
       If Value =SearchStandingStatusCodeType.Raised Then Result        := 'Raised'
  Else If Value = SearchStandingStatusCodeType.Standard  Then Result := 'Standard'
  Else If Value = SearchStandingStatusCodeType.Lowered Then Result  := 'Lowered'
  Else Result                                                       := '';
End;

Function enumToStr(Const Value: SellingManagerAutoRelistOptionCodeType): String;
Begin
       If Value =SellingManagerAutoRelistOptionCodeType.RelistImmediately Then Result              := 'RelistImmediately'
  Else If Value = SellingManagerAutoRelistOptionCodeType.RelistAfterDaysHours Then Result      := 'RelistAfterDaysHours'
  Else If Value = SellingManagerAutoRelistOptionCodeType.RelistAtSpecificTimeOfDay  Then Result := 'RelistAtSpecificTimeOfDay'
  Else Result                                                                                  := '';
End;

Function enumToStr(Const Value: SellingManagerAutoRelistTypeCodeType): String;
Begin
       If Value =SellingManagerAutoRelistTypeCodeType.RelistOnceIfNotSold Then Result              := 'RelistOnceIfNotSold'
  Else If Value = SellingManagerAutoRelistTypeCodeType.RelistContinuouslyUntilSold  Then Result := 'RelistContinuouslyUntilSold'
  Else If Value = SellingManagerAutoRelistTypeCodeType.RelistContinuously Then Result          := 'RelistContinuously'
  Else Result                                                                                  := '';
End;

Function enumToStr(Const Value: SellerAccountStatusCodeType): String;
Begin
       If Value =SellerAccountStatusCodeType.Current Then Result      := 'Current'
  Else If Value = SellerAccountStatusCodeType.PastDue  Then Result := 'PastDue'
  Else If Value = SellerAccountStatusCodeType.OnHold Then Result  := 'OnHold'
  Else Result                                                     := '';
End;

(*Function enumToStr(Const Value: RangeCodeType): String;
Begin
       If Value =RangeCodeType.High_ Then Result     := 'High_'
  Else If Value = RangeCodeType.Low_  Then Result := 'Low_'
  Else Result                                    := '';
End;*)

(*Function enumToStr(Const Value: DateSpecifierCodeType): String;
Begin
       If Value =DateSpecifierCodeType.M Then Result      := 'M'
  Else If Value = DateSpecifierCodeType.D  Then Result := 'D'
  Else If Value = DateSpecifierCodeType.Y  Then Result := 'Y'
  Else Result                                         := '';
End;*)

Function enumToStr(Const Value: SellingManagerEmailSentStatusCodeType): String;
Begin
       If Value =SellingManagerEmailSentStatusCodeType.Successful Then Result   := 'Successful'
  Else If Value = SellingManagerEmailSentStatusCodeType.Failed Then Result  := 'Failed'
  Else If Value = SellingManagerEmailSentStatusCodeType.Pending  Then Result := 'Pending'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: SellingManagerAutoSecondChanceOfferTypeCodeType): String;
Begin
       If Value =SellingManagerAutoSecondChanceOfferTypeCodeType.BidsGreaterThanAmount Then Result                  := 'BidsGreaterThanAmount'
  Else If Value = SellingManagerAutoSecondChanceOfferTypeCodeType.BidsGreaterThanCostPlusAmount Then Result     := 'BidsGreaterThanCostPlusAmount'
  Else If Value = SellingManagerAutoSecondChanceOfferTypeCodeType.BidsGreaterThanCostPlusPercentage  Then Result := 'BidsGreaterThanCostPlusPercentage'
  Else Result                                                                                                   := '';
End;

Function enumToStr(Const Value: SellingManagerEmailTypeCodeType): String;
Begin
       If Value =SellingManagerEmailTypeCodeType.ManualEntry Then Result                         := 'ManualEntry'
  Else If Value = SellingManagerEmailTypeCodeType.WinningBuyerEmail Then Result              := 'WinningBuyerEmail'
  Else If Value = SellingManagerEmailTypeCodeType.PaymentReminderEmail Then Result           := 'PaymentReminderEmail'
  Else If Value = SellingManagerEmailTypeCodeType.PaymentReceivedEmail Then Result           := 'PaymentReceivedEmail'
  Else If Value = SellingManagerEmailTypeCodeType.RequestForShippingAddressEmail  Then Result := 'RequestForShippingAddressEmail'
  Else If Value = SellingManagerEmailTypeCodeType.FeedbackReminderEmail Then Result          := 'FeedbackReminderEmail'
  Else If Value = SellingManagerEmailTypeCodeType.ShipmentSentEmail Then Result              := 'ShipmentSentEmail'
  Else If Value = SellingManagerEmailTypeCodeType.PersonalizedEmail Then Result              := 'PersonalizedEmail'
  Else If Value = SellingManagerEmailTypeCodeType.InvoiceNotification Then Result            := 'InvoiceNotification'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate1 Then Result           := 'CustomEmailTemplate1'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate2 Then Result           := 'CustomEmailTemplate2'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate3 Then Result           := 'CustomEmailTemplate3'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate4 Then Result           := 'CustomEmailTemplate4'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate5 Then Result           := 'CustomEmailTemplate5'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate6 Then Result           := 'CustomEmailTemplate6'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate7 Then Result           := 'CustomEmailTemplate7'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate8 Then Result           := 'CustomEmailTemplate8'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate9 Then Result           := 'CustomEmailTemplate9'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate10 Then Result          := 'CustomEmailTemplate10'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate11 Then Result          := 'CustomEmailTemplate11'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate12 Then Result          := 'CustomEmailTemplate12'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate13 Then Result          := 'CustomEmailTemplate13'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate14 Then Result          := 'CustomEmailTemplate14'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate15 Then Result          := 'CustomEmailTemplate15'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate16 Then Result          := 'CustomEmailTemplate16'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate17 Then Result          := 'CustomEmailTemplate17'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate18 Then Result          := 'CustomEmailTemplate18'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate19 Then Result          := 'CustomEmailTemplate19'
  Else If Value = SellingManagerEmailTypeCodeType.CustomEmailTemplate20 Then Result          := 'CustomEmailTemplate20'
  Else If Value = SellingManagerEmailTypeCodeType.CustomCode Then Result                     := 'CustomCode'
  Else Result                                                                                := '';
End;

Function enumToStr(Const Value: SellingManagerAutomationPropertyTypeCodeType): String;
Begin
       If Value =SellingManagerAutomationPropertyTypeCodeType.ItemListFailedAutomationRules Then Result                 := 'ItemListFailedAutomationRules'
  Else If Value = SellingManagerAutomationPropertyTypeCodeType.ItemRelistFailedAutomationRules Then Result          := 'ItemRelistFailedAutomationRules'
  Else If Value = SellingManagerAutomationPropertyTypeCodeType.ItemListFailedSecondChanceOfferAutoRules  Then Result := 'ItemListFailedSecondChanceOfferAutoRules'
  Else Result                                                                                                       := '';
End;

Function enumToStr(Const Value: SellingManagerPaisaPayPropertyTypeCodeType): String;
Begin
       If Value =SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayAwaitingShipment Then Result                  := 'PaisaPayAwaitingShipment'
  Else If Value = SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayTimeExtensionRequestDeclined  Then Result := 'PaisaPayTimeExtensionRequestDeclined'
  Else If Value = SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayPendingReceived Then Result              := 'PaisaPayPendingReceived'
  Else If Value = SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayRefundInitiated Then Result              := 'PaisaPayRefundInitiated'
  Else If Value = SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayTimeExtensionRequested Then Result       := 'PaisaPayTimeExtensionRequested'
  Else Result                                                                                                 := '';
End;

Function enumToStr(Const Value: SellingManagerAlertTypeCodeType): String;
Begin
       If Value =SellingManagerAlertTypeCodeType.Sold Then Result            := 'Sold'
  Else If Value = SellingManagerAlertTypeCodeType.Inventory Then Result  := 'Inventory'
  Else If Value = SellingManagerAlertTypeCodeType.Automation  Then Result := 'Automation'
  Else If Value = SellingManagerAlertTypeCodeType.PaisaPay Then Result   := 'PaisaPay'
  Else If Value = SellingManagerAlertTypeCodeType.General Then Result    := 'General'
  Else Result                                                            := '';
End;

Function enumToStr(Const Value: SellingManagerGeneralPropertyTypeCodeType): String;
Begin
       If Value =SellingManagerGeneralPropertyTypeCodeType.NegativeFeedbackReceived  Then Result := 'NegativeFeedbackReceived'
  Else If Value = SellingManagerGeneralPropertyTypeCodeType.UnpaidItemDispute Then Result   := 'UnpaidItemDispute'
  Else If Value = SellingManagerGeneralPropertyTypeCodeType.BadEmailTemplate Then Result    := 'BadEmailTemplate'
  Else Result                                                                               := '';
End;

Function enumToStr(Const Value: SellerDashboardAlertSeverityCodeType): String;
Begin
       If Value =SellerDashboardAlertSeverityCodeType.Informational Then Result      := 'Informational'
  Else If Value = SellerDashboardAlertSeverityCodeType.Warning Then Result       := 'Warning'
  Else If Value = SellerDashboardAlertSeverityCodeType.StrongWarning  Then Result := 'StrongWarning'
  Else Result                                                                    := '';
End;

Function enumToStr(Const Value: DayOfWeekCodeType): String;
Begin
       If Value =DayOfWeekCodeType.Sunday Then Result         := 'Sunday'
  Else If Value = DayOfWeekCodeType.Monday Then Result    := 'Monday'
  Else If Value = DayOfWeekCodeType.Tuesday Then Result   := 'Tuesday'
  Else If Value = DayOfWeekCodeType.Wednesday  Then Result := 'Wednesday'
  Else If Value = DayOfWeekCodeType.Thursday Then Result  := 'Thursday'
  Else If Value = DayOfWeekCodeType.Friday Then Result    := 'Friday'
  Else If Value = DayOfWeekCodeType.Saturday Then Result  := 'Saturday'
  Else Result                                             := '';
End;

Function enumToStr(Const Value: ShippingRegionCodeType): String;
Begin
       If Value =ShippingRegionCodeType.Africa Then Result             := 'Africa'
  Else If Value = ShippingRegionCodeType.Asia Then Result          := 'Asia'
  Else If Value = ShippingRegionCodeType.Caribbean Then Result     := 'Caribbean'
  Else If Value = ShippingRegionCodeType.Europe Then Result        := 'Europe'
  Else If Value = ShippingRegionCodeType.LatinAmerica Then Result  := 'LatinAmerica'
  Else If Value = ShippingRegionCodeType.MiddleEast Then Result    := 'MiddleEast'
  Else If Value = ShippingRegionCodeType.NorthAmerica Then Result  := 'NorthAmerica'
  Else If Value = ShippingRegionCodeType.Oceania Then Result       := 'Oceania'
  Else If Value = ShippingRegionCodeType.SouthAmerica Then Result  := 'SouthAmerica'
  Else If Value = ShippingRegionCodeType.EuropeanUnion  Then Result := 'EuropeanUnion'
  Else If Value = ShippingRegionCodeType.WillNotShip Then Result   := 'WillNotShip'
  Else If Value = ShippingRegionCodeType.Worldwide Then Result     := 'Worldwide'
  Else If Value = ShippingRegionCodeType.Americas Then Result      := 'Americas'
  Else If Value = ShippingRegionCodeType.None Then Result          := 'None'
  Else If Value = ShippingRegionCodeType.CustomCode Then Result    := 'CustomCode'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: EBaySubscriptionTypeCodeType): String;
Begin
       If Value =EBaySubscriptionTypeCodeType.SellerAssistant Then Result           := 'SellerAssistant'
  Else If Value = EBaySubscriptionTypeCodeType.SellerAssistantPro Then Result   := 'SellerAssistantPro'
  Else If Value = EBaySubscriptionTypeCodeType.EBayStoreBasic Then Result       := 'EBayStoreBasic'
  Else If Value = EBaySubscriptionTypeCodeType.EBayStoreFeatured Then Result    := 'EBayStoreFeatured'
  Else If Value = EBaySubscriptionTypeCodeType.EBayStoreAnchor Then Result      := 'EBayStoreAnchor'
  Else If Value = EBaySubscriptionTypeCodeType.SellingManager Then Result       := 'SellingManager'
  Else If Value = EBaySubscriptionTypeCodeType.SellingManagerPro Then Result    := 'SellingManagerPro'
  Else If Value = EBaySubscriptionTypeCodeType.PictureManagerLevel1  Then Result := 'PictureManagerLevel1'
  Else If Value = EBaySubscriptionTypeCodeType.PictureManagerLevel2  Then Result := 'PictureManagerLevel2'
  Else If Value = EBaySubscriptionTypeCodeType.PictureManagerLevel3  Then Result := 'PictureManagerLevel3'
  Else If Value = EBaySubscriptionTypeCodeType.PictureManagerLevel4  Then Result := 'PictureManagerLevel4'
  Else If Value = EBaySubscriptionTypeCodeType.PictureManagerLevel5  Then Result := 'PictureManagerLevel5'
  Else If Value = EBaySubscriptionTypeCodeType.PictureManagerLevel6  Then Result := 'PictureManagerLevel6'
  Else If Value = EBaySubscriptionTypeCodeType.PictureManagerLevel7  Then Result := 'PictureManagerLevel7'
  Else If Value = EBaySubscriptionTypeCodeType.SellerReportsBasic Then Result   := 'SellerReportsBasic'
  Else If Value = EBaySubscriptionTypeCodeType.SellerReportsPlus Then Result    := 'SellerReportsPlus'
  Else If Value = EBaySubscriptionTypeCodeType.FileExchange Then Result         := 'FileExchange'
  Else If Value = EBaySubscriptionTypeCodeType.LocalMarketSpecialty  Then Result := 'LocalMarketSpecialty'
  Else If Value = EBaySubscriptionTypeCodeType.LocalMarketRegular Then Result   := 'LocalMarketRegular'
  Else If Value = EBaySubscriptionTypeCodeType.LocalMarketPremium Then Result   := 'LocalMarketPremium'
  Else If Value = EBaySubscriptionTypeCodeType.CustomCode Then Result           := 'CustomCode'
  Else Result                                                                   := '';
End;

Function enumToStr(Const Value: VeROItemStatusCodeType): String;
Begin
       If Value =VeROItemStatusCodeType.Received Then Result                   := 'Received'
  Else If Value = VeROItemStatusCodeType.Submitted Then Result             := 'Submitted'
  Else If Value = VeROItemStatusCodeType.Removed Then Result               := 'Removed'
  Else If Value = VeROItemStatusCodeType.SubmissionFailed Then Result      := 'SubmissionFailed'
  Else If Value = VeROItemStatusCodeType.ClarificationRequired  Then Result := 'ClarificationRequired'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: MismatchTypeCodeType): String;
Begin
       If Value =MismatchTypeCodeType.OverPayment Then Result       := 'OverPayment'
  Else If Value = MismatchTypeCodeType.UnderPayment  Then Result := 'UnderPayment'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: PayPalAccountStatusCodeType): String;
Begin
       If Value =PayPalAccountStatusCodeType.Active Then Result              := 'Active'
  Else If Value = PayPalAccountStatusCodeType.Closed Then Result         := 'Closed'
  Else If Value = PayPalAccountStatusCodeType.HighRestricted  Then Result := 'HighRestricted'
  Else If Value = PayPalAccountStatusCodeType.LowRestricted Then Result  := 'LowRestricted'
  Else If Value = PayPalAccountStatusCodeType.Locked Then Result         := 'Locked'
  Else If Value = PayPalAccountStatusCodeType.CustomCode Then Result     := 'CustomCode'
  Else If Value = PayPalAccountStatusCodeType.WireOff Then Result        := 'WireOff'
  Else If Value = PayPalAccountStatusCodeType.Unknown Then Result        := 'Unknown'
  Else Result                                                            := '';
End;

Function enumToStr(Const Value: StoreSubscriptionLevelCodeType): String;
Begin
       If Value =StoreSubscriptionLevelCodeType.Close Then Result         := 'Close'
  Else If Value = StoreSubscriptionLevelCodeType.Basic Then Result    := 'Basic'
  Else If Value = StoreSubscriptionLevelCodeType.Featured  Then Result := 'Featured'
  Else If Value = StoreSubscriptionLevelCodeType.Anchor Then Result   := 'Anchor'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: StoreFontSizeCodeType): String;
Begin
       If Value =StoreFontSizeCodeType.XXS Then Result      := 'XXS'
  Else If Value = StoreFontSizeCodeType.XS Then Result  := 'XS'
  Else If Value = StoreFontSizeCodeType.S Then Result   := 'S'
  Else If Value = StoreFontSizeCodeType.M Then Result   := 'M'
  Else If Value = StoreFontSizeCodeType.L Then Result   := 'L'
  Else If Value = StoreFontSizeCodeType.XL Then Result  := 'XL'
  Else If Value = StoreFontSizeCodeType.XXL  Then Result := 'XXL'
  Else Result                                           := '';
End;

Function enumToStr(Const Value: MerchDisplayCodeType): String;
Begin
       If Value =MerchDisplayCodeType.DefaultTheme Then Result    := 'DefaultTheme'
  Else If Value = MerchDisplayCodeType.StoreTheme  Then Result := 'StoreTheme'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: StoreCustomHeaderLayoutCodeType): String;
Begin
       If Value =StoreCustomHeaderLayoutCodeType.NoHeader Then Result               := 'NoHeader'
  Else If Value = StoreCustomHeaderLayoutCodeType.CustomHeaderShown  Then Result := 'CustomHeaderShown'
  Else Result                                                                   := '';
End;

Function enumToStr(Const Value: StoreHeaderStyleCodeType): String;
Begin
       If Value =StoreHeaderStyleCodeType.Full Then Result           := 'Full'
  Else If Value = StoreHeaderStyleCodeType.Minimized  Then Result := 'Minimized'
  Else Result                                                    := '';
End;

Function enumToStr(Const Value: StoreItemListLayoutCodeType): String;
Begin
       If Value =StoreItemListLayoutCodeType.ListView Then Result         := 'ListView'
  Else If Value = StoreItemListLayoutCodeType.GalleryView  Then Result := 'GalleryView'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: StoreFontFaceCodeType): String;
Begin
       If Value =StoreFontFaceCodeType.Arial Then Result        := 'Arial'
  Else If Value = StoreFontFaceCodeType.Courier  Then Result := 'Courier'
  Else If Value = StoreFontFaceCodeType.Times Then Result   := 'Times'
  Else If Value = StoreFontFaceCodeType.Verdana  Then Result := 'Verdana'
  Else Result                                               := '';
End;

Function enumToStr(Const Value: PictureFormatCodeType): String;
Begin
       If Value =PictureFormatCodeType.JPG Then Result      := 'JPG'
  Else If Value = PictureFormatCodeType.GIF  Then Result := 'GIF'
  Else Result                                           := '';
End;

Function enumToStr(Const Value: StoreCustomListingHeaderDisplayCodeType): String;
Begin
       If Value =StoreCustomListingHeaderDisplayCodeType.None Then Result                          := 'None'
  Else If Value = StoreCustomListingHeaderDisplayCodeType.Full Then Result                     := 'Full'
  Else If Value = StoreCustomListingHeaderDisplayCodeType.FullAndLeftNavigationBar  Then Result := 'FullAndLeftNavigationBar'
  Else Result                                                                                  := '';
End;

Function enumToStr(Const Value: StoreCustomPageStatusCodeType): String;
Begin
       If Value =StoreCustomPageStatusCodeType.Active Then Result        := 'Active'
  Else If Value = StoreCustomPageStatusCodeType.Delete Then Result   := 'Delete'
  Else If Value = StoreCustomPageStatusCodeType.Inactive  Then Result := 'Inactive'
  Else Result                                                        := '';
End;

Function enumToStr(Const Value: StoreCustomListingHeaderLinkCodeType): String;
Begin
       If Value =StoreCustomListingHeaderLinkCodeType.None Then Result                := 'None'
  Else If Value = StoreCustomListingHeaderLinkCodeType.AboutMePage Then Result    := 'AboutMePage'
  Else If Value = StoreCustomListingHeaderLinkCodeType.CustomPage Then Result     := 'CustomPage'
  Else If Value = StoreCustomListingHeaderLinkCodeType.CustomCategory  Then Result := 'CustomCategory'
  Else Result                                                                     := '';
End;

Function enumToStr(Const Value: SummaryWindowPeriodCodeType): String;
Begin
       If Value =SummaryWindowPeriodCodeType.Last24Hours Then Result       := 'Last24Hours'
  Else If Value = SummaryWindowPeriodCodeType.Last7Days Then Result    := 'Last7Days'
  Else If Value = SummaryWindowPeriodCodeType.Last31Days Then Result   := 'Last31Days'
  Else If Value = SummaryWindowPeriodCodeType.CurrentWeek Then Result  := 'CurrentWeek'
  Else If Value = SummaryWindowPeriodCodeType.LastWeek Then Result     := 'LastWeek'
  Else If Value = SummaryWindowPeriodCodeType.CurrentMonth  Then Result := 'CurrentMonth'
  Else If Value = SummaryWindowPeriodCodeType.LastMonth Then Result    := 'LastMonth'
  Else If Value = SummaryWindowPeriodCodeType.Last60Days Then Result   := 'Last60Days'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: UnpaidItemCaseOpenTypeCodeType): String;
Begin
       If Value =UnpaidItemCaseOpenTypeCodeType.Auto Then Result        := 'Auto'
  Else If Value = UnpaidItemCaseOpenTypeCodeType.Manual  Then Result := 'Manual'
  Else Result                                                       := '';
End;

Function enumToStr(Const Value: UserIdentityCodeType): String;
Begin
       If Value =UserIdentityCodeType.EBayUser Then Result         := 'eBayUser'
  Else If Value = UserIdentityCodeType.EBayPartner  Then Result := 'eBayPartner'
  Else Result                                                  := '';
End;

Function enumToStr(Const Value: UnpaidItemCaseStatusTypeCodeType): String;
Begin
       If Value =UnpaidItemCaseStatusTypeCodeType.Open Then Result                      := 'Open'
  Else If Value = UnpaidItemCaseStatusTypeCodeType.ClosedWithPayment Then Result    := 'ClosedWithPayment'
  Else If Value = UnpaidItemCaseStatusTypeCodeType.ClosedWithoutPayment  Then Result := 'ClosedWithoutPayment'
  Else Result                                                                       := '';
End;

Function enumToStr(Const Value: URLTypeCodeType): String;
Begin
       If Value =URLTypeCodeType.ViewItemURL Then Result            := 'ViewItemURL'
  Else If Value = URLTypeCodeType.ViewUserURL Then Result       := 'ViewUserURL'
  Else If Value = URLTypeCodeType.MyeBayURL Then Result         := 'MyeBayURL'
  Else If Value = URLTypeCodeType.MyeBayBiddingURL Then Result  := 'MyeBayBiddingURL'
  Else If Value = URLTypeCodeType.MyeBayNotWonURL Then Result   := 'MyeBayNotWonURL'
  Else If Value = URLTypeCodeType.MyeBayWonURL Then Result      := 'MyeBayWonURL'
  Else If Value = URLTypeCodeType.MyeBayWatchingURL  Then Result := 'MyeBayWatchingURL'
  Else If Value = URLTypeCodeType.EBayStoreURL Then Result      := 'eBayStoreURL'
  Else If Value = URLTypeCodeType.SmallLogoURL Then Result      := 'SmallLogoURL'
  Else If Value = URLTypeCodeType.MediumLogoURL Then Result     := 'MediumLogoURL'
  Else If Value = URLTypeCodeType.LargeLogoURL Then Result      := 'LargeLogoURL'
  Else If Value = URLTypeCodeType.CustomCode Then Result        := 'CustomCode'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: FeedbackRatingStarCodeType): String;
Begin
       If Value =FeedbackRatingStarCodeType.None Then Result                   := 'None'
  Else If Value = FeedbackRatingStarCodeType.Yellow Then Result            := 'Yellow'
  Else If Value = FeedbackRatingStarCodeType.Blue Then Result              := 'Blue'
  Else If Value = FeedbackRatingStarCodeType.Turquoise Then Result         := 'Turquoise'
  Else If Value = FeedbackRatingStarCodeType.Purple Then Result            := 'Purple'
  Else If Value = FeedbackRatingStarCodeType.Red Then Result               := 'Red'
  Else If Value = FeedbackRatingStarCodeType.Green Then Result             := 'Green'
  Else If Value = FeedbackRatingStarCodeType.YellowShooting Then Result    := 'YellowShooting'
  Else If Value = FeedbackRatingStarCodeType.TurquoiseShooting  Then Result := 'TurquoiseShooting'
  Else If Value = FeedbackRatingStarCodeType.PurpleShooting Then Result    := 'PurpleShooting'
  Else If Value = FeedbackRatingStarCodeType.RedShooting Then Result       := 'RedShooting'
  Else If Value = FeedbackRatingStarCodeType.GreenShooting Then Result     := 'GreenShooting'
  Else If Value = FeedbackRatingStarCodeType.SilverShooting Then Result    := 'SilverShooting'
  Else If Value = FeedbackRatingStarCodeType.CustomCode Then Result        := 'CustomCode'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: PayPalAccountLevelCodeType): String;
Begin
       If Value =PayPalAccountLevelCodeType.Unverified Then Result                   := 'Unverified'
  Else If Value = PayPalAccountLevelCodeType.InternationalUnverified  Then Result := 'InternationalUnverified'
  Else If Value = PayPalAccountLevelCodeType.Verified Then Result                := 'Verified'
  Else If Value = PayPalAccountLevelCodeType.InternationalVerified Then Result   := 'InternationalVerified'
  Else If Value = PayPalAccountLevelCodeType.Trusted Then Result                 := 'Trusted'
  Else If Value = PayPalAccountLevelCodeType.Unknown Then Result                 := 'Unknown'
  Else If Value = PayPalAccountLevelCodeType.Invalid Then Result                 := 'Invalid'
  Else Result                                                                    := '';
End;

Function enumToStr(Const Value: PayPalAccountTypeCodeType): String;
Begin
       If Value =PayPalAccountTypeCodeType.Personal Then Result      := 'Personal'
  Else If Value = PayPalAccountTypeCodeType.Premier Then Result  := 'Premier'
  Else If Value = PayPalAccountTypeCodeType.Business  Then Result := 'Business'
  Else If Value = PayPalAccountTypeCodeType.Unknown Then Result  := 'Unknown'
  Else If Value = PayPalAccountTypeCodeType.Invalid Then Result  := 'Invalid'
  Else Result                                                    := '';
End;

Function enumToStr(Const Value: BusinessRoleType): String;
Begin
       If Value =BusinessRoleType.Shopper  Then Result := 'Shopper'
  Else Result                                     := '';
End;

Function enumToStr(Const Value: UserStatusCodeType): String;
Begin
       If Value =UserStatusCodeType.Unknown Then Result                        := 'Unknown'
  Else If Value = UserStatusCodeType.Suspended Then Result                 := 'Suspended'
  Else If Value = UserStatusCodeType.Confirmed Then Result                 := 'Confirmed'
  Else If Value = UserStatusCodeType.Unconfirmed Then Result               := 'Unconfirmed'
  Else If Value = UserStatusCodeType.Ghost Then Result                     := 'Ghost'
  Else If Value = UserStatusCodeType.InMaintenance Then Result             := 'InMaintenance'
  Else If Value = UserStatusCodeType.Deleted Then Result                   := 'Deleted'
  Else If Value = UserStatusCodeType.CreditCardVerify Then Result          := 'CreditCardVerify'
  Else If Value = UserStatusCodeType.AccountOnHold Then Result             := 'AccountOnHold'
  Else If Value = UserStatusCodeType.Merged Then Result                    := 'Merged'
  Else If Value = UserStatusCodeType.RegistrationCodeMailOut Then Result   := 'RegistrationCodeMailOut'
  Else If Value = UserStatusCodeType.TermPending Then Result               := 'TermPending'
  Else If Value = UserStatusCodeType.UnconfirmedHalfOptIn Then Result      := 'UnconfirmedHalfOptIn'
  Else If Value = UserStatusCodeType.CreditCardVerifyHalfOptIn  Then Result := 'CreditCardVerifyHalfOptIn'
  Else If Value = UserStatusCodeType.UnconfirmedPassport Then Result       := 'UnconfirmedPassport'
  Else If Value = UserStatusCodeType.CreditCardVerifyPassport Then Result  := 'CreditCardVerifyPassport'
  Else If Value = UserStatusCodeType.UnconfirmedExpress Then Result        := 'UnconfirmedExpress'
  Else If Value = UserStatusCodeType.Guest Then Result                     := 'Guest'
  Else If Value = UserStatusCodeType.CustomCode Then Result                := 'CustomCode'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: VATStatusCodeType): String;
Begin
       If Value =VATStatusCodeType.NoVATTax Then Result       := 'NoVATTax'
  Else If Value = VATStatusCodeType.VATTax Then Result    := 'VATTax'
  Else If Value = VATStatusCodeType.VATExempt  Then Result := 'VATExempt'
  Else Result                                             := '';
End;

Function enumToStr(Const Value: TaxTypeCodeType): String;
Begin
       If Value =TaxTypeCodeType.SalesTax Then Result               := 'SalesTax'
  Else If Value = TaxTypeCodeType.WasteRecyclingFee  Then Result := 'WasteRecyclingFee'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: TaxDescriptionCodeType): String;
Begin
       If Value =TaxDescriptionCodeType.SalesTax Then Result                         := 'SalesTax'
  Else If Value = TaxDescriptionCodeType.ElectronicWasteRecyclingFee  Then Result := 'ElectronicWasteRecyclingFee'
  Else If Value = TaxDescriptionCodeType.TireRecyclingFee Then Result            := 'TireRecyclingFee'
  Else Result                                                                    := '';
End;

Function enumToStr(Const Value: SummaryFrequencyCodeType): String;
Begin
       If Value =SummaryFrequencyCodeType.EverySunday Then Result         := 'EverySunday'
  Else If Value = SummaryFrequencyCodeType.EveryMonday Then Result    := 'EveryMonday'
  Else If Value = SummaryFrequencyCodeType.EveryTuesday Then Result   := 'EveryTuesday'
  Else If Value = SummaryFrequencyCodeType.EveryWednesday  Then Result := 'EveryWednesday'
  Else If Value = SummaryFrequencyCodeType.EveryThursday Then Result  := 'EveryThursday'
  Else If Value = SummaryFrequencyCodeType.EveryFriday Then Result    := 'EveryFriday'
  Else If Value = SummaryFrequencyCodeType.EverySaturday Then Result  := 'EverySaturday'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn1st Then Result   := 'MonthlyOn1st'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn2nd Then Result   := 'MonthlyOn2nd'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn3rd Then Result   := 'MonthlyOn3rd'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn4th Then Result   := 'MonthlyOn4th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn5th Then Result   := 'MonthlyOn5th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn6th Then Result   := 'MonthlyOn6th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn7th Then Result   := 'MonthlyOn7th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn8th Then Result   := 'MonthlyOn8th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn9th Then Result   := 'MonthlyOn9th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn10th Then Result  := 'MonthlyOn10th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn11th Then Result  := 'MonthlyOn11th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn12th Then Result  := 'MonthlyOn12th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn13th Then Result  := 'MonthlyOn13th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn14th Then Result  := 'MonthlyOn14th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn15th Then Result  := 'MonthlyOn15th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn16th Then Result  := 'MonthlyOn16th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn17th Then Result  := 'MonthlyOn17th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn18th Then Result  := 'MonthlyOn18th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn19th Then Result  := 'MonthlyOn19th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn20th Then Result  := 'MonthlyOn20th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn21st Then Result  := 'MonthlyOn21st'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn22nd Then Result  := 'MonthlyOn22nd'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn23rd Then Result  := 'MonthlyOn23rd'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn24th Then Result  := 'MonthlyOn24th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn25th Then Result  := 'MonthlyOn25th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn26th Then Result  := 'MonthlyOn26th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn27th Then Result  := 'MonthlyOn27th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn28th Then Result  := 'MonthlyOn28th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn29th Then Result  := 'MonthlyOn29th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn30th Then Result  := 'MonthlyOn30th'
  Else If Value = SummaryFrequencyCodeType.MonthlyOn31st Then Result  := 'MonthlyOn31st'
  Else If Value = SummaryFrequencyCodeType.Every31Days Then Result    := 'Every31Days'
  Else If Value = SummaryFrequencyCodeType.Every60Days Then Result    := 'Every60Days'
  Else If Value = SummaryFrequencyCodeType.CustomCode Then Result     := 'CustomCode'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: PaidStatusCodeType): String;
Begin
       If Value =PaidStatusCodeType.NotPaid Then Result                               := 'NotPaid'
  Else If Value = PaidStatusCodeType.BuyerHasNotCompletedCheckout Then Result     := 'BuyerHasNotCompletedCheckout'
  Else If Value = PaidStatusCodeType.PaymentPendingWithPayPal Then Result         := 'PaymentPendingWithPayPal'
  Else If Value = PaidStatusCodeType.PaidWithPayPal Then Result                   := 'PaidWithPayPal'
  Else If Value = PaidStatusCodeType.MarkedAsPaid Then Result                     := 'MarkedAsPaid'
  Else If Value = PaidStatusCodeType.PaymentPendingWithEscrow Then Result         := 'PaymentPendingWithEscrow'
  Else If Value = PaidStatusCodeType.PaidWithEscrow Then Result                   := 'PaidWithEscrow'
  Else If Value = PaidStatusCodeType.EscrowPaymentCancelled Then Result           := 'EscrowPaymentCancelled'
  Else If Value = PaidStatusCodeType.PaymentPendingWithPaisaPay Then Result       := 'PaymentPendingWithPaisaPay'
  Else If Value = PaidStatusCodeType.PaidWithPaisaPay Then Result                 := 'PaidWithPaisaPay'
  Else If Value = PaidStatusCodeType.PaymentPending Then Result                   := 'PaymentPending'
  Else If Value = PaidStatusCodeType.PaymentPendingWithPaisaPayEscrow  Then Result := 'PaymentPendingWithPaisaPayEscrow'
  Else If Value = PaidStatusCodeType.PaidWithPaisaPayEscrow Then Result           := 'PaidWithPaisaPayEscrow'
  Else If Value = PaidStatusCodeType.PaisaPayNotPaid Then Result                  := 'PaisaPayNotPaid'
  Else If Value = PaidStatusCodeType.Refunded Then Result                         := 'Refunded'
  Else If Value = PaidStatusCodeType.WaitingForCODPayment Then Result             := 'WaitingForCODPayment'
  Else If Value = PaidStatusCodeType.PaidCOD Then Result                          := 'PaidCOD'
  Else If Value = PaidStatusCodeType.CustomCode Then Result                       := 'CustomCode'
  Else If Value = PaidStatusCodeType.Paid Then Result                             := 'Paid'
  Else Result                                                                     := '';
End;

Function enumToStr(Const Value: TransactionReferenceCodeType): String;
Begin
       If Value =TransactionReferenceCodeType.ExternalTransactionID  Then Result := 'ExternalTransactionID'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: TokenStatusCodeType): String;
Begin
       If Value =TokenStatusCodeType.Active Then Result             := 'Active'
  Else If Value = TokenStatusCodeType.Expired Then Result       := 'Expired'
  Else If Value = TokenStatusCodeType.RevokedByeBay  Then Result := 'RevokedByeBay'
  Else If Value = TokenStatusCodeType.RevokedByUser  Then Result := 'RevokedByUser'
  Else If Value = TokenStatusCodeType.RevokedByApp Then Result  := 'RevokedByApp'
  Else If Value = TokenStatusCodeType.Invalid Then Result       := 'Invalid'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: TopRatedProgramCodeType): String;
Begin
       If Value =TopRatedProgramCodeType.US Then Result          := 'US'
  Else If Value = TopRatedProgramCodeType.UK Then Result     := 'UK'
  Else If Value = TopRatedProgramCodeType.DE Then Result     := 'DE'
  Else If Value = TopRatedProgramCodeType.Global  Then Result := 'Global'
  Else Result                                                := '';
End;

Function enumToStr(Const Value: ReasonHideFromSearchCodeType): String;
Begin
       If Value =ReasonHideFromSearchCodeType.DuplicateListing  Then Result := 'DuplicateListing'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: BoldTitleCodeType): String;
Begin
       If Value =BoldTitleCodeType.Enabled Then Result       := 'Enabled'
  Else If Value = BoldTitleCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                            := '';
End;

Function enumToStr(Const Value: BorderCodeType): String;
Begin
       If Value =BorderCodeType.Enabled Then Result       := 'Enabled'
  Else If Value = BorderCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                         := '';
End;

Function enumToStr(Const Value: HighlightCodeType): String;
Begin
       If Value =HighlightCodeType.Enabled Then Result       := 'Enabled'
  Else If Value = HighlightCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                            := '';
End;

Function enumToStr(Const Value: SellerBusinessCodeType): String;
Begin
       If Value =SellerBusinessCodeType.Undefined Then Result       := 'Undefined'
  Else If Value = SellerBusinessCodeType.Private_ Then Result   := 'Private_'
  Else If Value = SellerBusinessCodeType.Commercial  Then Result := 'Commercial'
  Else Result                                                   := '';
End;

(*Function enumToStr(Const Value: SkypeContactOptionCodeType): String;
Begin
       If Value =SkypeContactOptionCodeType.Chat Then Result       := 'Chat'
  Else If Value = SkypeContactOptionCodeType.Voice  Then Result := 'Voice'
  Else Result                                                  := '';
End;*)

Function enumToStr(Const Value: QuantityAvailableHintCodeType): String;
Begin
       If Value =QuantityAvailableHintCodeType.Limited Then Result       := 'Limited'
  Else If Value = QuantityAvailableHintCodeType.MoreThan  Then Result := 'MoreThan'
  Else Result                                                        := '';
End;

Function enumToStr(Const Value: ListingSubtypeCodeType): String;
Begin
       If Value =ListingSubtypeCodeType.ClassifiedAd Then Result                  := 'ClassifiedAd'
  Else If Value = ListingSubtypeCodeType.LocalMarketBestOfferOnly  Then Result := 'LocalMarketBestOfferOnly'
  Else Result                                                                 := '';
End;

Function enumToStr(Const Value: GiftIconCodeType): String;
Begin
       If Value =GiftIconCodeType.Enabled Then Result       := 'Enabled'
  Else If Value = GiftIconCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                           := '';
End;

Function enumToStr(Const Value: PeriodCodeType): String;
Begin
       If Value =PeriodCodeType.Days_1 Then Result        := 'Days_1'
  Else If Value = PeriodCodeType.Days_30 Then Result  := 'Days_30'
  Else If Value = PeriodCodeType.Days_180  Then Result := 'Days_180'
  Else If Value = PeriodCodeType.Days_360  Then Result := 'Days_360'
  Else If Value = PeriodCodeType.Days_540  Then Result := 'Days_540'
  Else Result                                         := '';
End;

Function enumToStr(Const Value: QuestionTypeCodeType): String;
Begin
       If Value =QuestionTypeCodeType.General Then Result                   := 'General'
  Else If Value = QuestionTypeCodeType.Shipping Then Result             := 'Shipping'
  Else If Value = QuestionTypeCodeType.Payment Then Result              := 'Payment'
  Else If Value = QuestionTypeCodeType.MultipleItemShipping  Then Result := 'MultipleItemShipping'
  Else If Value = QuestionTypeCodeType.CustomizedSubject Then Result    := 'CustomizedSubject'
  Else If Value = QuestionTypeCodeType.None Then Result                 := 'None'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: ProPackCodeType): String;
Begin
       If Value =ProPackCodeType.Enabled Then Result                 := 'Enabled'
  Else If Value = ProPackCodeType.Disabled Then Result           := 'Disabled'
  Else If Value = ProPackCodeType.PowerSellerOnly Then Result    := 'PowerSellerOnly'
  Else If Value = ProPackCodeType.TopRatedSellerOnly  Then Result := 'TopRatedSellerOnly'
  Else Result                                                    := '';
End;

Function enumToStr(Const Value: HomePageFeaturedCodeType): String;
Begin
       If Value =HomePageFeaturedCodeType.Enabled Then Result       := 'Enabled'
  Else If Value = HomePageFeaturedCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: FeaturedFirstCodeType): String;
Begin
       If Value =FeaturedFirstCodeType.Enabled Then Result                 := 'Enabled'
  Else If Value = FeaturedFirstCodeType.Disabled Then Result           := 'Disabled'
  Else If Value = FeaturedFirstCodeType.PowerSellerOnly Then Result    := 'PowerSellerOnly'
  Else If Value = FeaturedFirstCodeType.TopRatedSellerOnly  Then Result := 'TopRatedSellerOnly'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: FeaturedPlusCodeType): String;
Begin
       If Value =FeaturedPlusCodeType.Enabled Then Result                 := 'Enabled'
  Else If Value = FeaturedPlusCodeType.Disabled Then Result           := 'Disabled'
  Else If Value = FeaturedPlusCodeType.PowerSellerOnly Then Result    := 'PowerSellerOnly'
  Else If Value = FeaturedPlusCodeType.TopRatedSellerOnly  Then Result := 'TopRatedSellerOnly'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: MarkUpMarkDownEventTypeCodeType): String;
Begin
       If Value =MarkUpMarkDownEventTypeCodeType.MarkUp Then Result        := 'MarkUp'
  Else If Value = MarkUpMarkDownEventTypeCodeType.MarkDown  Then Result := 'MarkDown'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: FlatRateInsuranceRangeCodeType): String;
Begin
       If Value =FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange1 Then Result      := 'FlatRateInsuranceRange1'
  Else If Value = FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange2  Then Result := 'FlatRateInsuranceRange2'
  Else If Value = FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange3  Then Result := 'FlatRateInsuranceRange3'
  Else If Value = FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange4  Then Result := 'FlatRateInsuranceRange4'
  Else If Value = FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange5  Then Result := 'FlatRateInsuranceRange5'
  Else If Value = FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange6  Then Result := 'FlatRateInsuranceRange6'
  Else Result                                                                        := '';
End;

Function enumToStr(Const Value: FlatShippingRateOptionCodeType): String;
Begin
       If Value =FlatShippingRateOptionCodeType.ChargeAmountForEachAdditionalItem Then Result       := 'ChargeAmountForEachAdditionalItem'
  Else If Value = FlatShippingRateOptionCodeType.DeductAmountFromEachAdditionalItem  Then Result := 'DeductAmountFromEachAdditionalItem'
  Else If Value = FlatShippingRateOptionCodeType.ShipAdditionalItemsFree Then Result            := 'ShipAdditionalItemsFree'
  Else Result                                                                                   := '';
End;

(*Function enumToStr(Const Value: ListingFlowCodeType): String;
Begin
       If Value =ListingFlowCodeType.AddItem Then Result         := 'AddItem'
  Else If Value = ListingFlowCodeType.ReviseItem  Then Result := 'ReviseItem'
  Else If Value = ListingFlowCodeType.RelistItem  Then Result := 'RelistItem'
  Else Result                                                := '';
End;*)

Function enumToStr(Const Value: OrderStatusFilterCodeType): String;
Begin
       If Value =OrderStatusFilterCodeType.All Then Result                   := 'All'
  Else If Value = OrderStatusFilterCodeType.AwaitingPayment Then Result  := 'AwaitingPayment'
  Else If Value = OrderStatusFilterCodeType.AwaitingShipment  Then Result := 'AwaitingShipment'
  Else If Value = OrderStatusFilterCodeType.PaidAndShipped Then Result   := 'PaidAndShipped'
  Else Result                                                            := '';
End;

Function enumToStr(Const Value: ListingEnhancementsCodeType): String;
Begin
       If Value =ListingEnhancementsCodeType.Border Then Result                      := 'Border'
  Else If Value = ListingEnhancementsCodeType.BoldTitle Then Result              := 'BoldTitle'
  Else If Value = ListingEnhancementsCodeType.Featured Then Result               := 'Featured'
  Else If Value = ListingEnhancementsCodeType.Highlight Then Result              := 'Highlight'
  Else If Value = ListingEnhancementsCodeType.HomePageFeatured Then Result       := 'HomePageFeatured'
  Else If Value = ListingEnhancementsCodeType.ProPackBundle Then Result          := 'ProPackBundle'
  Else If Value = ListingEnhancementsCodeType.BasicUpgradePackBundle  Then Result := 'BasicUpgradePackBundle'
  Else If Value = ListingEnhancementsCodeType.ValuePackBundle Then Result        := 'ValuePackBundle'
  Else If Value = ListingEnhancementsCodeType.ProPackPlusBundle Then Result      := 'ProPackPlusBundle'
  Else Result                                                                    := '';
End;

Function enumToStr(Const Value: DescriptionReviseModeCodeType): String;
Begin
       If Value =DescriptionReviseModeCodeType.Replace Then Result      := 'Replace'
  Else If Value = DescriptionReviseModeCodeType.Prepend  Then Result := 'Prepend'
  Else If Value = DescriptionReviseModeCodeType.Append Then Result  := 'Append'
  Else Result                                                       := '';
End;

(*Function enumToStr(Const Value: GiftServicesCodeType): String;
Begin
       If Value =GiftServicesCodeType.GiftExpressShipping Then Result      := 'GiftExpressShipping'
  Else If Value = GiftServicesCodeType.GiftShipToRecipient  Then Result := 'GiftShipToRecipient'
  Else If Value = GiftServicesCodeType.GiftWrap Then Result            := 'GiftWrap'
  Else Result                                                          := '';
End;*)

Function enumToStr(Const Value: HitCounterCodeType): String;
Begin
       If Value =HitCounterCodeType.NoHitCounter Then Result      := 'NoHitCounter'
  Else If Value = HitCounterCodeType.HonestyStyle  Then Result := 'HonestyStyle'
  Else If Value = HitCounterCodeType.GreenLED Then Result     := 'GreenLED'
  Else If Value = HitCounterCodeType.Hidden Then Result       := 'Hidden'
  Else If Value = HitCounterCodeType.BasicStyle Then Result   := 'BasicStyle'
  Else If Value = HitCounterCodeType.RetroStyle Then Result   := 'RetroStyle'
  Else If Value = HitCounterCodeType.HiddenStyle Then Result  := 'HiddenStyle'
  Else Result                                                 := '';
End;

(*Function enumToStr(Const Value: RecommendationEngineCodeType): String;
Begin
       If Value =RecommendationEngineCodeType.ListingAnalyzer Then Result          := 'ListingAnalyzer'
  Else If Value = RecommendationEngineCodeType.SIFFTAS Then Result             := 'SIFFTAS'
  Else If Value = RecommendationEngineCodeType.ProductPricing Then Result      := 'ProductPricing'
  Else If Value = RecommendationEngineCodeType.CustomCode Then Result          := 'CustomCode'
  Else If Value = RecommendationEngineCodeType.SuggestedAttributes  Then Result := 'SuggestedAttributes'
  Else Result                                                                  := '';
End;*)

Function enumToStr(Const Value: SiteCodeType): String;
Begin
       If Value =SiteCodeType.US Then Result                  := 'US'
  Else If Value = SiteCodeType.Canada Then Result         := 'Canada'
  Else If Value = SiteCodeType.UK Then Result             := 'UK'
  Else If Value = SiteCodeType.Australia Then Result      := 'Australia'
  Else If Value = SiteCodeType.Austria Then Result        := 'Austria'
  Else If Value = SiteCodeType.Belgium_French  Then Result := 'Belgium_French'
  Else If Value = SiteCodeType.France Then Result         := 'France'
  Else If Value = SiteCodeType.Germany Then Result        := 'Germany'
  Else If Value = SiteCodeType.Italy Then Result          := 'Italy'
  Else If Value = SiteCodeType.Belgium_Dutch Then Result  := 'Belgium_Dutch'
  Else If Value = SiteCodeType.Netherlands Then Result    := 'Netherlands'
  Else If Value = SiteCodeType.Spain Then Result          := 'Spain'
  Else If Value = SiteCodeType.Switzerland Then Result    := 'Switzerland'
  Else If Value = SiteCodeType.Taiwan Then Result         := 'Taiwan'
  Else If Value = SiteCodeType.EBayMotors Then Result     := 'eBayMotors'
  Else If Value = SiteCodeType.HongKong Then Result       := 'HongKong'
  Else If Value = SiteCodeType.Singapore Then Result      := 'Singapore'
  Else If Value = SiteCodeType.India Then Result          := 'India'
  Else If Value = SiteCodeType.China Then Result          := 'China'
  Else If Value = SiteCodeType.Ireland Then Result        := 'Ireland'
  Else If Value = SiteCodeType.Malaysia Then Result       := 'Malaysia'
  Else If Value = SiteCodeType.Philippines Then Result    := 'Philippines'
  Else If Value = SiteCodeType.Poland Then Result         := 'Poland'
  Else If Value = SiteCodeType.Sweden Then Result         := 'Sweden'
  Else If Value = SiteCodeType.CustomCode Then Result     := 'CustomCode'
  Else If Value = SiteCodeType.CanadaFrench Then Result   := 'CanadaFrench'
  Else Result                                             := '';
End;

(*Function enumToStr(Const Value: CharacteristicsSearchCodeType): String;
Begin
       If Value =CharacteristicsSearchCodeType.Single_ Then Result    := 'Single_'
  Else If Value = CharacteristicsSearchCodeType.Multi  Then Result := 'Multi'
  Else Result                                                     := '';
End;*)

Function enumToStr(Const Value: PromotionItemSelectionCodeType): String;
Begin
       If Value =PromotionItemSelectionCodeType.Manual Then Result         := 'Manual'
  Else If Value = PromotionItemSelectionCodeType.Automatic  Then Result := 'Automatic'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: PromotionItemPriceTypeCodeType): String;
Begin
       If Value =PromotionItemPriceTypeCodeType.AuctionPrice Then Result            := 'AuctionPrice'
  Else If Value = PromotionItemPriceTypeCodeType.BuyItNowPrice Then Result      := 'BuyItNowPrice'
  Else If Value = PromotionItemPriceTypeCodeType.BestOfferOnlyPrice  Then Result := 'BestOfferOnlyPrice'
  Else If Value = PromotionItemPriceTypeCodeType.ClassifiedAdPrice Then Result  := 'ClassifiedAdPrice'
  Else Result                                                                   := '';
End;

Function enumToStr(Const Value: SellerLevelCodeType): String;
Begin
       If Value =SellerLevelCodeType.Bronze Then Result        := 'Bronze'
  Else If Value = SellerLevelCodeType.Silver Then Result   := 'Silver'
  Else If Value = SellerLevelCodeType.Gold Then Result     := 'Gold'
  Else If Value = SellerLevelCodeType.Platinum  Then Result := 'Platinum'
  Else If Value = SellerLevelCodeType.Titanium  Then Result := 'Titanium'
  Else If Value = SellerLevelCodeType.None Then Result     := 'None'
  Else Result                                              := '';
End;

Function enumToStr(Const Value: GalleryStatusCodeType): String;
Begin
       If Value =GalleryStatusCodeType.Success Then Result                   := 'Success'
  Else If Value = GalleryStatusCodeType.Pending Then Result              := 'Pending'
  Else If Value = GalleryStatusCodeType.InvalidUrl Then Result           := 'InvalidUrl'
  Else If Value = GalleryStatusCodeType.InvalidProtocol Then Result      := 'InvalidProtocol'
  Else If Value = GalleryStatusCodeType.InvalidFile Then Result          := 'InvalidFile'
  Else If Value = GalleryStatusCodeType.ServerDown Then Result           := 'ServerDown'
  Else If Value = GalleryStatusCodeType.ImageNonExistent Then Result     := 'ImageNonExistent'
  Else If Value = GalleryStatusCodeType.ImageReadTimeOut Then Result     := 'ImageReadTimeOut'
  Else If Value = GalleryStatusCodeType.InvalidFileFormat Then Result    := 'InvalidFileFormat'
  Else If Value = GalleryStatusCodeType.ImageProcessingError  Then Result := 'ImageProcessingError'
  Else If Value = GalleryStatusCodeType.CustomCode Then Result           := 'CustomCode'
  Else Result                                                            := '';
End;

(*Function enumToStr(Const Value: PictureManagerSubscriptionLevelCodeType): String;
Begin
       If Value =PictureManagerSubscriptionLevelCodeType.Free Then Result        := 'Free'
  Else If Value = PictureManagerSubscriptionLevelCodeType.Level1  Then Result := 'Level1'
  Else If Value = PictureManagerSubscriptionLevelCodeType.Level2  Then Result := 'Level2'
  Else If Value = PictureManagerSubscriptionLevelCodeType.Level3  Then Result := 'Level3'
  Else If Value = PictureManagerSubscriptionLevelCodeType.Level4  Then Result := 'Level4'
  Else Result                                                                := '';
End;*)

Function enumToStr(Const Value: GalleryTypeCodeType): String;
Begin
       If Value =GalleryTypeCodeType.None Then Result          := 'None'
  Else If Value = GalleryTypeCodeType.Featured  Then Result := 'Featured'
  Else If Value = GalleryTypeCodeType.Gallery Then Result  := 'Gallery'
  Else If Value = GalleryTypeCodeType.Plus Then Result     := 'Plus'
  Else Result                                              := '';
End;

Function enumToStr(Const Value: PhotoDisplayCodeType): String;
Begin
       If Value =PhotoDisplayCodeType.None Then Result                         := 'None'
  Else If Value = PhotoDisplayCodeType.SlideShow Then Result               := 'SlideShow'
  Else If Value = PhotoDisplayCodeType.SuperSize Then Result               := 'SuperSize'
  Else If Value = PhotoDisplayCodeType.PicturePack Then Result             := 'PicturePack'
  Else If Value = PhotoDisplayCodeType.SiteHostedPictureShow Then Result   := 'SiteHostedPictureShow'
  Else If Value = PhotoDisplayCodeType.VendorHostedPictureShow  Then Result := 'VendorHostedPictureShow'
  Else If Value = PhotoDisplayCodeType.SuperSizePictureShow Then Result    := 'SuperSizePictureShow'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: PictureSourceCodeType): String;
Begin
       If Value =PictureSourceCodeType.EPS Then Result                 := 'EPS'
  Else If Value = PictureSourceCodeType.PictureManager  Then Result := 'PictureManager'
  Else If Value = PictureSourceCodeType.Vendor Then Result         := 'Vendor'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: PolicyComplianceStatusCodeType): String;
Begin
       If Value =PolicyComplianceStatusCodeType.Good Then Result         := 'Good'
  Else If Value = PolicyComplianceStatusCodeType.Fair Then Result    := 'Fair'
  Else If Value = PolicyComplianceStatusCodeType.Poor Then Result    := 'Poor'
  Else If Value = PolicyComplianceStatusCodeType.Failing  Then Result := 'Failing'
  Else Result                                                        := '';
End;

(*Function enumToStr(Const Value: PictureManagerPictureDisplayTypeCodeType): String;
Begin
       If Value =PictureManagerPictureDisplayTypeCodeType.Thumbnail Then Result      := 'Thumbnail'
  Else If Value = PictureManagerPictureDisplayTypeCodeType.BIBO Then Result      := 'BIBO'
  Else If Value = PictureManagerPictureDisplayTypeCodeType.Standard Then Result  := 'Standard'
  Else If Value = PictureManagerPictureDisplayTypeCodeType.Large Then Result     := 'Large'
  Else If Value = PictureManagerPictureDisplayTypeCodeType.Supersize  Then Result := 'Supersize'
  Else If Value = PictureManagerPictureDisplayTypeCodeType.Original Then Result  := 'Original'
  Else Result                                                                    := '';
End;*)

Function enumToStr(Const Value: RefundingSourceTypeCodeType): String;
Begin
       If Value =RefundingSourceTypeCodeType.ScheduledPayout Then Result  := 'ScheduledPayout'
  Else If Value = RefundingSourceTypeCodeType.Paypal Then Result      := 'Paypal'
  Else If Value = RefundingSourceTypeCodeType.BankAccount  Then Result := 'BankAccount'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: RefundFailureCodeType): String;
Begin
       If Value =RefundFailureCodeType.PaypalBillingAgreementCanceled Then Result     := 'PaypalBillingAgreementCanceled'
  Else If Value = RefundFailureCodeType.PaypalRiskDeclinesTransaction  Then Result := 'PaypalRiskDeclinesTransaction'
  Else Result                                                                     := '';
End;

Function enumToStr(Const Value: RefundStatusCodeType): String;
Begin
       If Value =RefundStatusCodeType.Successful Then Result   := 'Successful'
  Else If Value = RefundStatusCodeType.Pending  Then Result := 'Pending'
  Else If Value = RefundStatusCodeType.Failed Then Result  := 'Failed'
  Else Result                                              := '';
End;

Function enumToStr(Const Value: StatusCodeType): String;
Begin
       If Value =StatusCodeType.Active Then Result        := 'Active'
  Else If Value = StatusCodeType.Inactive  Then Result := 'Inactive'
  Else Result                                         := '';
End;

Function enumToStr(Const Value: RefundLineTypeCodeType): String;
Begin
       If Value =RefundLineTypeCodeType.PurchasePrice Then Result      := 'PurchasePrice'
  Else If Value = RefundLineTypeCodeType.ShippingPrice  Then Result := 'ShippingPrice'
  Else If Value = RefundLineTypeCodeType.Additional Then Result    := 'Additional'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: ValueTypeCodeType): String;
Begin
       If Value =ValueTypeCodeType.Decimal Then Result   := 'Decimal'
  Else If Value = ValueTypeCodeType.Text  Then Result := 'Text'
  Else If Value = ValueTypeCodeType.ISBN  Then Result := 'ISBN'
  Else If Value = ValueTypeCodeType.UPC Then Result  := 'UPC'
  Else If Value = ValueTypeCodeType.EAN Then Result  := 'EAN'
  Else If Value = ValueTypeCodeType.Date  Then Result := 'Date'
  Else Result                                        := '';
End;

Function enumToStr(Const Value: DiscountCodeType): String;
Begin
       If Value =DiscountCodeType.Percentage  Then Result := 'Percentage'
  Else If Value = DiscountCodeType.Price  Then Result := 'Price'
  Else Result                                        := '';
End;

Function enumToStr(Const Value: PromotionalSaleTypeCodeType): String;
Begin
       If Value =PromotionalSaleTypeCodeType.PriceDiscountOnly Then Result                 := 'PriceDiscountOnly'
  Else If Value = PromotionalSaleTypeCodeType.FreeShippingOnly Then Result             := 'FreeShippingOnly'
  Else If Value = PromotionalSaleTypeCodeType.PriceDiscountAndFreeShipping  Then Result := 'PriceDiscountAndFreeShipping'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: ValueFormatCodeType): String;
Begin
       If Value =ValueFormatCodeType.FullDate Then Result         := 'FullDate'
  Else If Value = ValueFormatCodeType.PartialDate  Then Result := 'PartialDate'
  Else If Value = ValueFormatCodeType.Year Then Result        := 'Year'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: SelectionModeCodeType): String;
Begin
       If Value =SelectionModeCodeType.Automatic Then Result          := 'Automatic'
  Else If Value = SelectionModeCodeType.Manual Then Result        := 'Manual'
  Else If Value = SelectionModeCodeType.Prefilled Then Result     := 'Prefilled'
  Else If Value = SelectionModeCodeType.SelectionOnly  Then Result := 'SelectionOnly'
  Else If Value = SelectionModeCodeType.FreeText Then Result      := 'FreeText'
  Else Result                                                     := '';
End;

Function enumToStr(Const Value: VariationPictureRuleCodeType): String;
Begin
       If Value =VariationPictureRuleCodeType.Required Then Result      := 'Required'
  Else If Value = VariationPictureRuleCodeType.Enabled Then Result  := 'Enabled'
  Else If Value = VariationPictureRuleCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                                       := '';
End;

Function enumToStr(Const Value: VariationSpecificsRuleCodeType): String;
Begin
       If Value =VariationSpecificsRuleCodeType.Enabled Then Result       := 'Enabled'
  Else If Value = VariationSpecificsRuleCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: PaymentMethodSearchCodeType): String;
Begin
       If Value =PaymentMethodSearchCodeType.PayPal Then Result                := 'PayPal'
  Else If Value = PaymentMethodSearchCodeType.PaisaPay Then Result         := 'PaisaPay'
  Else If Value = PaymentMethodSearchCodeType.PayPalOrPaisaPay  Then Result := 'PayPalOrPaisaPay'
  Else If Value = PaymentMethodSearchCodeType.CustomCode Then Result       := 'CustomCode'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: PreferredLocationCodeType): String;
Begin
       If Value =PreferredLocationCodeType.ListedInCurrencyImplied Then Result        := 'ListedInCurrencyImplied'
  Else If Value = PreferredLocationCodeType.LocatedInCountryImplied Then Result   := 'LocatedInCountryImplied'
  Else If Value = PreferredLocationCodeType.AvailableInCountryImplied  Then Result := 'AvailableInCountryImplied'
  Else If Value = PreferredLocationCodeType.SiteImplied Then Result               := 'SiteImplied'
  Else If Value = PreferredLocationCodeType.BelgiumListing Then Result            := 'BelgiumListing'
  Else Result                                                                     := '';
End;

Function enumToStr(Const Value: ItemConditionCodeType): String;
Begin
       If Value =ItemConditionCodeType.New Then Result       := 'New'
  Else If Value = ItemConditionCodeType.Used  Then Result := 'Used'
  Else Result                                            := '';
End;

Function enumToStr(Const Value: SimpleItemSortCodeType): String;
Begin
       If Value =SimpleItemSortCodeType.BestMatch Then Result                   := 'BestMatch'
  Else If Value = SimpleItemSortCodeType.CustomCode Then Result             := 'CustomCode'
  Else If Value = SimpleItemSortCodeType.EndTime Then Result                := 'EndTime'
  Else If Value = SimpleItemSortCodeType.BidCount Then Result               := 'BidCount'
  Else If Value = SimpleItemSortCodeType.Country Then Result                := 'Country'
  Else If Value = SimpleItemSortCodeType.CurrentBid Then Result             := 'CurrentBid'
  Else If Value = SimpleItemSortCodeType.Distance Then Result               := 'Distance'
  Else If Value = SimpleItemSortCodeType.StartDate Then Result              := 'StartDate'
  Else If Value = SimpleItemSortCodeType.BestMatchCategoryGroup  Then Result := 'BestMatchCategoryGroup'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: ItemTypeCodeType): String;
Begin
       If Value =ItemTypeCodeType.AuctionItemsOnly Then Result                     := 'AuctionItemsOnly'
  Else If Value = ItemTypeCodeType.FixedPricedItem Then Result                 := 'FixedPricedItem'
  Else If Value = ItemTypeCodeType.AllItems Then Result                        := 'AllItems'
  Else If Value = ItemTypeCodeType.StoreInventoryOnly Then Result              := 'StoreInventoryOnly'
  Else If Value = ItemTypeCodeType.FixedPriceExcludeStoreInventory  Then Result := 'FixedPriceExcludeStoreInventory'
  Else If Value = ItemTypeCodeType.ExcludeStoreInventory Then Result           := 'ExcludeStoreInventory'
  Else If Value = ItemTypeCodeType.AllItemTypes Then Result                    := 'AllItemTypes'
  Else If Value = ItemTypeCodeType.AllFixedPriceItemTypes Then Result          := 'AllFixedPriceItemTypes'
  Else If Value = ItemTypeCodeType.CustomCode Then Result                      := 'CustomCode'
  Else If Value = ItemTypeCodeType.ClassifiedItemsOnly Then Result             := 'ClassifiedItemsOnly'
  Else If Value = ItemTypeCodeType.AdFormat Then Result                        := 'AdFormat'
  Else Result                                                                  := '';
End;

Function enumToStr(Const Value: SearchFlagCodeType): String;
Begin
       If Value =SearchFlagCodeType.Charity Then Result                     := 'Charity'
  Else If Value = SearchFlagCodeType.Gift Then Result                   := 'Gift'
  Else If Value = SearchFlagCodeType.NowAndNew Then Result              := 'NowAndNew'
  Else If Value = SearchFlagCodeType.LocalSearch Then Result            := 'LocalSearch'
  Else If Value = SearchFlagCodeType.FreeShipping Then Result           := 'FreeShipping'
  Else If Value = SearchFlagCodeType.Gallery Then Result                := 'Gallery'
  Else If Value = SearchFlagCodeType.Picture Then Result                := 'Picture'
  Else If Value = SearchFlagCodeType.GetItFast Then Result              := 'GetItFast'
  Else If Value = SearchFlagCodeType.Lot Then Result                    := 'Lot'
  Else If Value = SearchFlagCodeType.GermanMotorsSearchable  Then Result := 'GermanMotorsSearchable'
  Else If Value = SearchFlagCodeType.WorldOfGood Then Result            := 'WorldOfGood'
  Else If Value = SearchFlagCodeType.DigitalDelivery Then Result        := 'DigitalDelivery'
  Else If Value = SearchFlagCodeType.CustomCode Then Result             := 'CustomCode'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: ItemSpecificSourceCodeType): String;
Begin
       If Value =ItemSpecificSourceCodeType.ItemSpecific Then Result   := 'ItemSpecific'
  Else If Value = ItemSpecificSourceCodeType.Attribute  Then Result := 'Attribute'
  Else If Value = ItemSpecificSourceCodeType.Product Then Result   := 'Product'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: QuantityOperatorCodeType): String;
Begin
       If Value =QuantityOperatorCodeType.LessThan Then Result                := 'LessThan'
  Else If Value = QuantityOperatorCodeType.LessThanOrEqual Then Result    := 'LessThanOrEqual'
  Else If Value = QuantityOperatorCodeType.Equal Then Result              := 'Equal'
  Else If Value = QuantityOperatorCodeType.GreaterThan Then Result        := 'GreaterThan'
  Else If Value = QuantityOperatorCodeType.GreaterThanOrEqual  Then Result := 'GreaterThanOrEqual'
  Else Result                                                             := '';
End;

Function enumToStr(Const Value: MyMessagesAlertResolutionStatusCode): String;
Begin
       If Value =MyMessagesAlertResolutionStatusCode.Unresolved Then Result                    := 'Unresolved'
  Else If Value = MyMessagesAlertResolutionStatusCode.ResolvedByAutoResolution  Then Result := 'ResolvedByAutoResolution'
  Else If Value = MyMessagesAlertResolutionStatusCode.ResolvedByUser Then Result           := 'ResolvedByUser'
  Else Result                                                                              := '';
End;

Function enumToStr(Const Value: DepositTypeCodeType): String;
Begin
       If Value =DepositTypeCodeType.None Then Result             := 'None'
  Else If Value = DepositTypeCodeType.OtherMethod  Then Result := 'OtherMethod'
  Else If Value = DepositTypeCodeType.FastDeposit  Then Result := 'FastDeposit'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: PaymentHoldStatusCodeType): String;
Begin
       If Value =PaymentHoldStatusCodeType.PaymentReview Then Result         := 'PaymentReview'
  Else If Value = PaymentHoldStatusCodeType.MerchantHold Then Result     := 'MerchantHold'
  Else If Value = PaymentHoldStatusCodeType.Released Then Result         := 'Released'
  Else If Value = PaymentHoldStatusCodeType.None Then Result             := 'None'
  Else If Value = PaymentHoldStatusCodeType.NewSellerHold Then Result    := 'NewSellerHold'
  Else If Value = PaymentHoldStatusCodeType.PaymentHold Then Result      := 'PaymentHold'
  Else If Value = PaymentHoldStatusCodeType.ReleasePending Then Result   := 'ReleasePending'
  Else If Value = PaymentHoldStatusCodeType.ReleaseConfirmed  Then Result := 'ReleaseConfirmed'
  Else If Value = PaymentHoldStatusCodeType.ReleaseFailed Then Result    := 'ReleaseFailed'
  Else Result                                                            := '';
End;

Function enumToStr(Const Value: PerformanceStatusCodeType): String;
Begin
       If Value =PerformanceStatusCodeType.TopRated Then Result           := 'TopRated'
  Else If Value = PerformanceStatusCodeType.AboveStandard  Then Result := 'AboveStandard'
  Else If Value = PerformanceStatusCodeType.Standard Then Result      := 'Standard'
  Else If Value = PerformanceStatusCodeType.BelowStandard  Then Result := 'BelowStandard'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: PaymentHoldReasonCodeType): String;
Begin
       If Value =PaymentHoldReasonCodeType.NewSeller Then Result                         := 'NewSeller'
  Else If Value = PaymentHoldReasonCodeType.BelowStandardSeller Then Result          := 'BelowStandardSeller'
  Else If Value = PaymentHoldReasonCodeType.EbpCaseOpen Then Result                  := 'EbpCaseOpen'
  Else If Value = PaymentHoldReasonCodeType.ReinstatementAfterSuspension  Then Result := 'ReinstatementAfterSuspension'
  Else If Value = PaymentHoldReasonCodeType.CasualSeller Then Result                 := 'CasualSeller'
  Else If Value = PaymentHoldReasonCodeType.NewPaypalAccountAdded Then Result        := 'NewPaypalAccountAdded'
  Else If Value = PaymentHoldReasonCodeType.NotAvailable Then Result                 := 'NotAvailable'
  Else If Value = PaymentHoldReasonCodeType.SellerIsOnBlackList Then Result          := 'SellerIsOnBlackList'
  Else If Value = PaymentHoldReasonCodeType.Other Then Result                        := 'Other'
  Else If Value = PaymentHoldReasonCodeType.None Then Result                         := 'None'
  Else If Value = PaymentHoldReasonCodeType.CustomCode Then Result                   := 'CustomCode'
  Else Result                                                                        := '';
End;

Function enumToStr(Const Value: NotificationEventStateCodeType): String;
Begin
       If Value =NotificationEventStateCodeType.New Then Result                    := 'New'
  Else If Value = NotificationEventStateCodeType.Failed Then Result            := 'Failed'
  Else If Value = NotificationEventStateCodeType.MarkedDown Then Result        := 'MarkedDown'
  Else If Value = NotificationEventStateCodeType.Pending Then Result           := 'Pending'
  Else If Value = NotificationEventStateCodeType.FailedPending Then Result     := 'FailedPending'
  Else If Value = NotificationEventStateCodeType.MarkedDownPending  Then Result := 'MarkedDownPending'
  Else If Value = NotificationEventStateCodeType.Delivered Then Result         := 'Delivered'
  Else If Value = NotificationEventStateCodeType.Undeliverable Then Result     := 'Undeliverable'
  Else If Value = NotificationEventStateCodeType.Rejected Then Result          := 'Rejected'
  Else If Value = NotificationEventStateCodeType.Canceled Then Result          := 'Canceled'
  Else If Value = NotificationEventStateCodeType.CustomCode Then Result        := 'CustomCode'
  Else Result                                                                  := '';
End;

Function enumToStr(Const Value: NotificationEventPropertyNameCodeType): String;
Begin
       If Value =NotificationEventPropertyNameCodeType.TimeLeft  Then Result := 'TimeLeft'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: AddressTypeCodeType): String;
Begin
       If Value =AddressTypeCodeType.Contact Then Result         := 'Contact'
  Else If Value = AddressTypeCodeType.Registered  Then Result := 'Registered'
  Else Result                                                := '';
End;

Function enumToStr(Const Value: NotificationEventTypeCodeType): String;
Begin
       If Value =NotificationEventTypeCodeType.None Then Result                                     := 'None'
  Else If Value = NotificationEventTypeCodeType.OutBid Then Result                              := 'OutBid'
  Else If Value = NotificationEventTypeCodeType.EndOfAuction Then Result                        := 'EndOfAuction'
  Else If Value = NotificationEventTypeCodeType.AuctionCheckoutComplete Then Result             := 'AuctionCheckoutComplete'
  Else If Value = NotificationEventTypeCodeType.CheckoutBuyerRequestsTotal Then Result          := 'CheckoutBuyerRequestsTotal'
  Else If Value = NotificationEventTypeCodeType.Feedback Then Result                            := 'Feedback'
  Else If Value = NotificationEventTypeCodeType.FeedbackForSeller Then Result                   := 'FeedbackForSeller'
  Else If Value = NotificationEventTypeCodeType.FixedPriceTransaction Then Result               := 'FixedPriceTransaction'
  Else If Value = NotificationEventTypeCodeType.SecondChanceOffer Then Result                   := 'SecondChanceOffer'
  Else If Value = NotificationEventTypeCodeType.AskSellerQuestion Then Result                   := 'AskSellerQuestion'
  Else If Value = NotificationEventTypeCodeType.ItemListed Then Result                          := 'ItemListed'
  Else If Value = NotificationEventTypeCodeType.ItemRevised Then Result                         := 'ItemRevised'
  Else If Value = NotificationEventTypeCodeType.BuyerResponseDispute Then Result                := 'BuyerResponseDispute'
  Else If Value = NotificationEventTypeCodeType.SellerOpenedDispute Then Result                 := 'SellerOpenedDispute'
  Else If Value = NotificationEventTypeCodeType.SellerRespondedToDispute Then Result            := 'SellerRespondedToDispute'
  Else If Value = NotificationEventTypeCodeType.SellerClosedDispute Then Result                 := 'SellerClosedDispute'
  Else If Value = NotificationEventTypeCodeType.BestOffer Then Result                           := 'BestOffer'
  Else If Value = NotificationEventTypeCodeType.MyMessagesAlertHeader Then Result               := 'MyMessagesAlertHeader'
  Else If Value = NotificationEventTypeCodeType.MyMessagesAlert Then Result                     := 'MyMessagesAlert'
  Else If Value = NotificationEventTypeCodeType.MyMessageseBayMessageHeader Then Result         := 'MyMessageseBayMessageHeader'
  Else If Value = NotificationEventTypeCodeType.MyMessageseBayMessage Then Result               := 'MyMessageseBayMessage'
  Else If Value = NotificationEventTypeCodeType.MyMessagesM2MMessageHeader Then Result          := 'MyMessagesM2MMessageHeader'
  Else If Value = NotificationEventTypeCodeType.MyMessagesM2MMessage Then Result                := 'MyMessagesM2MMessage'
  Else If Value = NotificationEventTypeCodeType.INRBuyerOpenedDispute Then Result               := 'INRBuyerOpenedDispute'
  Else If Value = NotificationEventTypeCodeType.INRBuyerRespondedToDispute Then Result          := 'INRBuyerRespondedToDispute'
  Else If Value = NotificationEventTypeCodeType.INRBuyerClosedDispute Then Result               := 'INRBuyerClosedDispute'
  Else If Value = NotificationEventTypeCodeType.INRSellerRespondedToDispute Then Result         := 'INRSellerRespondedToDispute'
  Else If Value = NotificationEventTypeCodeType.Checkout Then Result                            := 'Checkout'
  Else If Value = NotificationEventTypeCodeType.WatchedItemEndingSoon Then Result               := 'WatchedItemEndingSoon'
  Else If Value = NotificationEventTypeCodeType.ItemClosed Then Result                          := 'ItemClosed'
  Else If Value = NotificationEventTypeCodeType.ItemSuspended Then Result                       := 'ItemSuspended'
  Else If Value = NotificationEventTypeCodeType.ItemSold Then Result                            := 'ItemSold'
  Else If Value = NotificationEventTypeCodeType.ItemExtended Then Result                        := 'ItemExtended'
  Else If Value = NotificationEventTypeCodeType.UserIDChanged Then Result                       := 'UserIDChanged'
  Else If Value = NotificationEventTypeCodeType.EmailAddressChanged Then Result                 := 'EmailAddressChanged'
  Else If Value = NotificationEventTypeCodeType.PasswordChanged Then Result                     := 'PasswordChanged'
  Else If Value = NotificationEventTypeCodeType.PasswordHintChanged Then Result                 := 'PasswordHintChanged'
  Else If Value = NotificationEventTypeCodeType.PaymentDetailChanged Then Result                := 'PaymentDetailChanged'
  Else If Value = NotificationEventTypeCodeType.AccountSuspended Then Result                    := 'AccountSuspended'
  Else If Value = NotificationEventTypeCodeType.AccountSummary Then Result                      := 'AccountSummary'
  Else If Value = NotificationEventTypeCodeType.ThirdPartyCartCheckout Then Result              := 'ThirdPartyCartCheckout'
  Else If Value = NotificationEventTypeCodeType.ItemRevisedAddCharity Then Result               := 'ItemRevisedAddCharity'
  Else If Value = NotificationEventTypeCodeType.ItemAddedToWatchList Then Result                := 'ItemAddedToWatchList'
  Else If Value = NotificationEventTypeCodeType.ItemRemovedFromWatchList Then Result            := 'ItemRemovedFromWatchList'
  Else If Value = NotificationEventTypeCodeType.ItemAddedToBidGroup Then Result                 := 'ItemAddedToBidGroup'
  Else If Value = NotificationEventTypeCodeType.ItemRemovedFromBidGroup Then Result             := 'ItemRemovedFromBidGroup'
  Else If Value = NotificationEventTypeCodeType.FeedbackLeft Then Result                        := 'FeedbackLeft'
  Else If Value = NotificationEventTypeCodeType.FeedbackReceived Then Result                    := 'FeedbackReceived'
  Else If Value = NotificationEventTypeCodeType.FeedbackStarChanged Then Result                 := 'FeedbackStarChanged'
  Else If Value = NotificationEventTypeCodeType.BidPlaced Then Result                           := 'BidPlaced'
  Else If Value = NotificationEventTypeCodeType.BidReceived Then Result                         := 'BidReceived'
  Else If Value = NotificationEventTypeCodeType.ItemWon Then Result                             := 'ItemWon'
  Else If Value = NotificationEventTypeCodeType.ItemLost Then Result                            := 'ItemLost'
  Else If Value = NotificationEventTypeCodeType.ItemUnsold Then Result                          := 'ItemUnsold'
  Else If Value = NotificationEventTypeCodeType.CounterOfferReceived Then Result                := 'CounterOfferReceived'
  Else If Value = NotificationEventTypeCodeType.BestOfferDeclined Then Result                   := 'BestOfferDeclined'
  Else If Value = NotificationEventTypeCodeType.BestOfferPlaced Then Result                     := 'BestOfferPlaced'
  Else If Value = NotificationEventTypeCodeType.AddToWatchList Then Result                      := 'AddToWatchList'
  Else If Value = NotificationEventTypeCodeType.PlaceOffer Then Result                          := 'PlaceOffer'
  Else If Value = NotificationEventTypeCodeType.RemoveFromWatchList Then Result                 := 'RemoveFromWatchList'
  Else If Value = NotificationEventTypeCodeType.AddToBidGroup Then Result                       := 'AddToBidGroup'
  Else If Value = NotificationEventTypeCodeType.RemoveFromBidGroup Then Result                  := 'RemoveFromBidGroup'
  Else If Value = NotificationEventTypeCodeType.ItemsCanceled Then Result                       := 'ItemsCanceled'
  Else If Value = NotificationEventTypeCodeType.TokenRevocation Then Result                     := 'TokenRevocation'
  Else If Value = NotificationEventTypeCodeType.BulkDataExchangeJobCompleted Then Result        := 'BulkDataExchangeJobCompleted'
  Else If Value = NotificationEventTypeCodeType.CustomCode Then Result                          := 'CustomCode'
  Else If Value = NotificationEventTypeCodeType.ItemMarkedShipped Then Result                   := 'ItemMarkedShipped'
  Else If Value = NotificationEventTypeCodeType.ItemMarkedPaid Then Result                      := 'ItemMarkedPaid'
  Else If Value = NotificationEventTypeCodeType.EBPMyResponseDue Then Result                    := 'EBPMyResponseDue'
  Else If Value = NotificationEventTypeCodeType.EBPOtherPartyResponseDue Then Result            := 'EBPOtherPartyResponseDue'
  Else If Value = NotificationEventTypeCodeType.EBPEscalatedCase Then Result                    := 'EBPEscalatedCase'
  Else If Value = NotificationEventTypeCodeType.EBPAppealedCase Then Result                     := 'EBPAppealedCase'
  Else If Value = NotificationEventTypeCodeType.EBPMyPaymentDue Then Result                     := 'EBPMyPaymentDue'
  Else If Value = NotificationEventTypeCodeType.EBPPaymentDone Then Result                      := 'EBPPaymentDone'
  Else If Value = NotificationEventTypeCodeType.EBPClosedAppeal Then Result                     := 'EBPClosedAppeal'
  Else If Value = NotificationEventTypeCodeType.EBPClosedCase Then Result                       := 'EBPClosedCase'
  Else If Value = NotificationEventTypeCodeType.MyMessagesHighPriorityMessage Then Result       := 'MyMessagesHighPriorityMessage'
  Else If Value = NotificationEventTypeCodeType.MyMessagesHighPriorityMessageHeader  Then Result := 'MyMessagesHighPriorityMessageHeader'
  Else If Value = NotificationEventTypeCodeType.EBPOnHoldCase Then Result                       := 'EBPOnHoldCase'
  Else If Value = NotificationEventTypeCodeType.ReadyToShip Then Result                         := 'ReadyToShip'
  Else If Value = NotificationEventTypeCodeType.ReadyForPayout Then Result                      := 'ReadyForPayout'
  Else If Value = NotificationEventTypeCodeType.BidItemEndingSoon Then Result                   := 'BidItemEndingSoon'
  Else If Value = NotificationEventTypeCodeType.ShoppingCartItemEndingSoon Then Result          := 'ShoppingCartItemEndingSoon'
  Else If Value = NotificationEventTypeCodeType.ReturnCreated Then Result                       := 'ReturnCreated'
  Else If Value = NotificationEventTypeCodeType.ReturnWaitingForSellerInfo Then Result          := 'ReturnWaitingForSellerInfo'
  Else If Value = NotificationEventTypeCodeType.ReturnSellerInfoOverdue Then Result             := 'ReturnSellerInfoOverdue'
  Else If Value = NotificationEventTypeCodeType.ReturnShipped Then Result                       := 'ReturnShipped'
  Else If Value = NotificationEventTypeCodeType.ReturnDelivered Then Result                     := 'ReturnDelivered'
  Else If Value = NotificationEventTypeCodeType.ReturnRefundOverdue Then Result                 := 'ReturnRefundOverdue'
  Else If Value = NotificationEventTypeCodeType.ReturnClosed Then Result                        := 'ReturnClosed'
  Else If Value = NotificationEventTypeCodeType.ReturnEscalated Then Result                     := 'ReturnEscalated'
  Else If Value = NotificationEventTypeCodeType.UnmatchedPaymentReceived Then Result            := 'UnmatchedPaymentReceived'
  Else If Value = NotificationEventTypeCodeType.RefundSuccess Then Result                       := 'RefundSuccess'
  Else If Value = NotificationEventTypeCodeType.RefundFailure Then Result                       := 'RefundFailure'
  Else Result                                                                                   := '';
End;

Function enumToStr(Const Value: BidActionCodeType): String;
Begin
       If Value =BidActionCodeType.Unknown Then Result             := 'Unknown'
  Else If Value = BidActionCodeType.Bid Then Result            := 'Bid'
  Else If Value = BidActionCodeType.NotUsed Then Result        := 'NotUsed'
  Else If Value = BidActionCodeType.Retraction Then Result     := 'Retraction'
  Else If Value = BidActionCodeType.AutoRetraction  Then Result := 'AutoRetraction'
  Else If Value = BidActionCodeType.Cancelled Then Result      := 'Cancelled'
  Else If Value = BidActionCodeType.AutoCancel Then Result     := 'AutoCancel'
  Else If Value = BidActionCodeType.Absentee Then Result       := 'Absentee'
  Else If Value = BidActionCodeType.BuyItNow Then Result       := 'BuyItNow'
  Else If Value = BidActionCodeType.Purchase Then Result       := 'Purchase'
  Else If Value = BidActionCodeType.CustomCode Then Result     := 'CustomCode'
  Else If Value = BidActionCodeType.Offer Then Result          := 'Offer'
  Else If Value = BidActionCodeType.Counter Then Result        := 'Counter'
  Else If Value = BidActionCodeType.Accept Then Result         := 'Accept'
  Else If Value = BidActionCodeType.Decline Then Result        := 'Decline'
  Else Result                                                  := '';
End;

(*Function enumToStr(Const Value: ProductUseCaseCodeType): String;
Begin
       If Value =ProductUseCaseCodeType.AddItem Then Result         := 'AddItem'
  Else If Value = ProductUseCaseCodeType.ReviseItem  Then Result := 'ReviseItem'
  Else If Value = ProductUseCaseCodeType.RelistItem  Then Result := 'RelistItem'
  Else Result                                                   := '';
End;*)

(*Function enumToStr(Const Value: PictureManagerDetailLevelCodeType): String;
Begin
       If Value =PictureManagerDetailLevelCodeType.ReturnAll Then Result               := 'ReturnAll'
  Else If Value = PictureManagerDetailLevelCodeType.ReturnSubscription  Then Result := 'ReturnSubscription'
  Else If Value = PictureManagerDetailLevelCodeType.ReturnPicture Then Result      := 'ReturnPicture'
  Else Result                                                                      := '';
End;*)

Function enumToStr(Const Value: RCSPaymentStatusCodeType): String;
Begin
       If Value =RCSPaymentStatusCodeType.Canceled Then Result     := 'Canceled'
  Else If Value = RCSPaymentStatusCodeType.Paid Then Result    := 'Paid'
  Else If Value = RCSPaymentStatusCodeType.Pending  Then Result := 'Pending'
  Else Result                                                  := '';
End;

Function enumToStr(Const Value: PromotionalSaleStatusCodeType): String;
Begin
       If Value =PromotionalSaleStatusCodeType.Active Then Result          := 'Active'
  Else If Value = PromotionalSaleStatusCodeType.Scheduled Then Result  := 'Scheduled'
  Else If Value = PromotionalSaleStatusCodeType.Processing  Then Result := 'Processing'
  Else If Value = PromotionalSaleStatusCodeType.Inactive Then Result   := 'Inactive'
  Else If Value = PromotionalSaleStatusCodeType.Deleted Then Result    := 'Deleted'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: MessageTypeCodeType): String;
Begin
       If Value =MessageTypeCodeType.AskSellerQuestion Then Result                       := 'AskSellerQuestion'
  Else If Value = MessageTypeCodeType.ResponseToASQQuestion Then Result              := 'ResponseToASQQuestion'
  Else If Value = MessageTypeCodeType.ContactEbayMember Then Result                  := 'ContactEbayMember'
  Else If Value = MessageTypeCodeType.ContactTransactionPartner Then Result          := 'ContactTransactionPartner'
  Else If Value = MessageTypeCodeType.ResponseToContacteBayMember Then Result        := 'ResponseToContacteBayMember'
  Else If Value = MessageTypeCodeType.ContacteBayMemberViaCommunityLink Then Result  := 'ContacteBayMemberViaCommunityLink'
  Else If Value = MessageTypeCodeType.CustomCode Then Result                         := 'CustomCode'
  Else If Value = MessageTypeCodeType.All Then Result                                := 'All'
  Else If Value = MessageTypeCodeType.ContactMyBidder Then Result                    := 'ContactMyBidder'
  Else If Value = MessageTypeCodeType.ContacteBayMemberViaAnonymousEmail  Then Result := 'ContacteBayMemberViaAnonymousEmail'
  Else If Value = MessageTypeCodeType.ClassifiedsContactSeller Then Result           := 'ClassifiedsContactSeller'
  Else If Value = MessageTypeCodeType.ClassifiedsBestOffer Then Result               := 'ClassifiedsBestOffer'
  Else Result                                                                        := '';
End;

Function enumToStr(Const Value: OrderStatusCodeType): String;
Begin
       If Value =OrderStatusCodeType.Active Then Result             := 'Active'
  Else If Value = OrderStatusCodeType.Inactive Then Result      := 'Inactive'
  Else If Value = OrderStatusCodeType.Completed Then Result     := 'Completed'
  Else If Value = OrderStatusCodeType.Cancelled Then Result     := 'Cancelled'
  Else If Value = OrderStatusCodeType.Shipped Then Result       := 'Shipped'
  Else If Value = OrderStatusCodeType.Default_ Then Result      := 'Default_'
  Else If Value = OrderStatusCodeType.Authenticated  Then Result := 'Authenticated'
  Else If Value = OrderStatusCodeType.InProcess Then Result     := 'InProcess'
  Else If Value = OrderStatusCodeType.Invalid Then Result       := 'Invalid'
  Else If Value = OrderStatusCodeType.CustomCode Then Result    := 'CustomCode'
  Else If Value = OrderStatusCodeType.All Then Result           := 'All'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: SortOrderCodeType): String;
Begin
       If Value =SortOrderCodeType.Ascending Then Result       := 'Ascending'
  Else If Value = SortOrderCodeType.Descending  Then Result := 'Descending'
  Else Result                                              := '';
End;

Function enumToStr(Const Value: NotificationRoleCodeType): String;
Begin
       If Value =NotificationRoleCodeType.Application_ Then Result  := 'Application_'
  Else If Value = NotificationRoleCodeType.User Then Result     := 'User'
  Else If Value = NotificationRoleCodeType.UserData  Then Result := 'UserData'
  Else If Value = NotificationRoleCodeType.Event Then Result    := 'Event'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: DisputeFilterTypeCodeType): String;
Begin
       If Value =DisputeFilterTypeCodeType.AllInvolvedDisputes Then Result                     := 'AllInvolvedDisputes'
  Else If Value = DisputeFilterTypeCodeType.DisputesAwaitingMyResponse Then Result         := 'DisputesAwaitingMyResponse'
  Else If Value = DisputeFilterTypeCodeType.DisputesAwaitingOtherPartyResponse  Then Result := 'DisputesAwaitingOtherPartyResponse'
  Else If Value = DisputeFilterTypeCodeType.AllInvolvedClosedDisputes Then Result          := 'AllInvolvedClosedDisputes'
  Else If Value = DisputeFilterTypeCodeType.EligibleForCredit Then Result                  := 'EligibleForCredit'
  Else If Value = DisputeFilterTypeCodeType.UnpaidItemDisputes Then Result                 := 'UnpaidItemDisputes'
  Else If Value = DisputeFilterTypeCodeType.ItemNotReceivedDisputes Then Result            := 'ItemNotReceivedDisputes'
  Else Result                                                                              := '';
End;

Function enumToStr(Const Value: DisputeSortTypeCodeType): String;
Begin
       If Value =DisputeSortTypeCodeType.None Then Result                                    := 'None'
  Else If Value = DisputeSortTypeCodeType.DisputeCreatedTimeAscending Then Result        := 'DisputeCreatedTimeAscending'
  Else If Value = DisputeSortTypeCodeType.DisputeCreatedTimeDescending Then Result       := 'DisputeCreatedTimeDescending'
  Else If Value = DisputeSortTypeCodeType.DisputeStatusAscending Then Result             := 'DisputeStatusAscending'
  Else If Value = DisputeSortTypeCodeType.DisputeStatusDescending Then Result            := 'DisputeStatusDescending'
  Else If Value = DisputeSortTypeCodeType.DisputeCreditEligibilityAscending Then Result  := 'DisputeCreditEligibilityAscending'
  Else If Value = DisputeSortTypeCodeType.DisputeCreditEligibilityDescending  Then Result := 'DisputeCreditEligibilityDescending'
  Else Result                                                                            := '';
End;

Function enumToStr(Const Value: VeROReportPacketStatusCodeType): String;
Begin
       If Value =VeROReportPacketStatusCodeType.Received Then Result       := 'Received'
  Else If Value = VeROReportPacketStatusCodeType.InProcess  Then Result := 'InProcess'
  Else If Value = VeROReportPacketStatusCodeType.Processed  Then Result := 'Processed'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: SellingManagerSoldListingsPropertyTypeCodeType): String;
Begin
       If Value =SellingManagerSoldListingsPropertyTypeCodeType.NotPaidNotShipped Then Result                         := 'NotPaidNotShipped'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PaidNotShipped Then Result                       := 'PaidNotShipped'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PrintShippingLabel Then Result                   := 'PrintShippingLabel'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PaidShipped Then Result                          := 'PaidShipped'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PaidNoFeedback Then Result                       := 'PaidNoFeedback'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PaymentReminderSendError Then Result             := 'PaymentReminderSendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PaymentReceivedNotificationSendError  Then Result := 'PaymentReceivedNotificationSendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.RequestForShippingAddressSendError Then Result   := 'RequestForShippingAddressSendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.ShippingNotificationSendError Then Result        := 'ShippingNotificationSendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PersonalizedEmailsSendError Then Result          := 'PersonalizedEmailsSendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.WinningBuyerNotificationSendError Then Result    := 'WinningBuyerNotificationSendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.FeeCreditRequest Then Result                     := 'FeeCreditRequest'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PayPalPayment Then Result                        := 'PayPalPayment'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.FeedbackMessageNotSent Then Result               := 'FeedbackMessageNotSent'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.FeedbackReminderSendError Then Result            := 'FeedbackReminderSendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.NotShipped Then Result                           := 'NotShipped'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.UnpaidItemReminder Then Result                   := 'UnpaidItemReminder'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EscrowCancelled Then Result                      := 'EscrowCancelled'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EscrowCompleted Then Result                      := 'EscrowCompleted'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EscrowInitiated Then Result                      := 'EscrowInitiated'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EscrowManageRefund Then Result                   := 'EscrowManageRefund'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EscrowReleasePayment Then Result                 := 'EscrowReleasePayment'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EscrowShipToBuyer Then Result                    := 'EscrowShipToBuyer'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EscrowSoldAll Then Result                        := 'EscrowSoldAll'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.ShippedAndAwaitingFeedback Then Result           := 'ShippedAndAwaitingFeedback'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.InternationalSale Then Result                    := 'InternationalSale'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.EBayGivingWorksDonationOwed Then Result          := 'eBayGivingWorksDonationOwed'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PaymentOverDue Then Result                       := 'PaymentOverDue'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.PadiWithPaisaPayEscrow Then Result               := 'PadiWithPaisaPayEscrow'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate1SendError Then Result        := 'CustomEmailTemplate1SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate2SendError Then Result        := 'CustomEmailTemplate2SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate3SendError Then Result        := 'CustomEmailTemplate3SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate4SendError Then Result        := 'CustomEmailTemplate4SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate5SendError Then Result        := 'CustomEmailTemplate5SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate6SendError Then Result        := 'CustomEmailTemplate6SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate7SendError Then Result        := 'CustomEmailTemplate7SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate8SendError Then Result        := 'CustomEmailTemplate8SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate9SendError Then Result        := 'CustomEmailTemplate9SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate10SendError Then Result       := 'CustomEmailTemplate10SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate11SendError Then Result       := 'CustomEmailTemplate11SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate12SendError Then Result       := 'CustomEmailTemplate12SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate13SendError Then Result       := 'CustomEmailTemplate13SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate14SendError Then Result       := 'CustomEmailTemplate14SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate15SendError Then Result       := 'CustomEmailTemplate15SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate16SendError Then Result       := 'CustomEmailTemplate16SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate17SendError Then Result       := 'CustomEmailTemplate17SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate18SendError Then Result       := 'CustomEmailTemplate18SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate19SendError Then Result       := 'CustomEmailTemplate19SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate20SendError Then Result       := 'CustomEmailTemplate20SendError'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.ResponseRequiredForReturnCase Then Result        := 'ResponseRequiredForReturnCase'
  Else If Value = SellingManagerSoldListingsPropertyTypeCodeType.CustomCode Then Result                           := 'CustomCode'
  Else Result                                                                                                     := '';
End;

Function enumToStr(Const Value: SellingManagerSoldListingsSortTypeCodeType): String;
Begin
       If Value =SellingManagerSoldListingsSortTypeCodeType.SalesRecordID Then Result         := 'SalesRecordID'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.BuyerEmail Then Result       := 'BuyerEmail'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.SaleFormat Then Result       := 'SaleFormat'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.CustomLabel Then Result      := 'CustomLabel'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.TotalPrice Then Result       := 'TotalPrice'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.SaleDate Then Result         := 'SaleDate'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.PaidDate Then Result         := 'PaidDate'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.EmailsSent Then Result       := 'EmailsSent'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.CheckoutState Then Result    := 'CheckoutState'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.PaidState Then Result        := 'PaidState'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.ShippedState Then Result     := 'ShippedState'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.FeedbackLeft Then Result     := 'FeedbackLeft'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.FeedbackReceived  Then Result := 'FeedbackReceived'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.ShippedDate Then Result      := 'ShippedDate'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.BuyerPostalCode Then Result  := 'BuyerPostalCode'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.DaysSinceSale Then Result    := 'DaysSinceSale'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.StartPrice Then Result       := 'StartPrice'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.ReservePrice Then Result     := 'ReservePrice'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.SoldOn Then Result           := 'SoldOn'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.ShippingCost Then Result     := 'ShippingCost'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.ListedOn Then Result         := 'ListedOn'
  Else If Value = SellingManagerSoldListingsSortTypeCodeType.CustomCode Then Result       := 'CustomCode'
  Else Result                                                                             := '';
End;

Function enumToStr(Const Value: InventoryTrackingMethodCodeType): String;
Begin
       If Value =InventoryTrackingMethodCodeType.ItemID Then Result   := 'ItemID'
  Else If Value = InventoryTrackingMethodCodeType.SKU  Then Result := 'SKU'
  Else Result                                                     := '';
End;

Function enumToStr(Const Value: SellingManagerProductSortCodeType): String;
Begin
       If Value =SellingManagerProductSortCodeType.ActiveQuantity Then Result         := 'ActiveQuantity'
  Else If Value = SellingManagerProductSortCodeType.AvailableToList Then Result   := 'AvailableToList'
  Else If Value = SellingManagerProductSortCodeType.AveragePrice Then Result      := 'AveragePrice'
  Else If Value = SellingManagerProductSortCodeType.AverageUnitCost Then Result   := 'AverageUnitCost'
  Else If Value = SellingManagerProductSortCodeType.CustomLabel Then Result       := 'CustomLabel'
  Else If Value = SellingManagerProductSortCodeType.ProductName Then Result       := 'ProductName'
  Else If Value = SellingManagerProductSortCodeType.LastSubmittedDate  Then Result := 'LastSubmittedDate'
  Else If Value = SellingManagerProductSortCodeType.ScheduledQuantity  Then Result := 'ScheduledQuantity'
  Else If Value = SellingManagerProductSortCodeType.SoldQuantity Then Result      := 'SoldQuantity'
  Else If Value = SellingManagerProductSortCodeType.SuccessPercent Then Result    := 'SuccessPercent'
  Else If Value = SellingManagerProductSortCodeType.UnsoldQuantity Then Result    := 'UnsoldQuantity'
  Else If Value = SellingManagerProductSortCodeType.FolderName Then Result        := 'FolderName'
  Else If Value = SellingManagerProductSortCodeType.CustomCode Then Result        := 'CustomCode'
  Else Result                                                                     := '';
End;

Function enumToStr(Const Value: SellingManagerInventoryPropertyTypeCodeType): String;
Begin
       If Value =SellingManagerInventoryPropertyTypeCodeType.ProductsOutOfStock Then Result   := 'ProductsOutOfStock'
  Else If Value = SellingManagerInventoryPropertyTypeCodeType.Active Then Result          := 'Active'
  Else If Value = SellingManagerInventoryPropertyTypeCodeType.InActive Then Result        := 'InActive'
  Else If Value = SellingManagerInventoryPropertyTypeCodeType.LowStock Then Result        := 'LowStock'
  Else If Value = SellingManagerInventoryPropertyTypeCodeType.WithListings Then Result    := 'WithListings'
  Else If Value = SellingManagerInventoryPropertyTypeCodeType.WithoutListings  Then Result := 'WithoutListings'
  Else Result                                                                             := '';
End;

Function enumToStr(Const Value: CombinedPaymentPeriodCodeType): String;
Begin
       If Value =CombinedPaymentPeriodCodeType.Days_3 Then Result          := 'Days_3'
  Else If Value = CombinedPaymentPeriodCodeType.Days_5 Then Result     := 'Days_5'
  Else If Value = CombinedPaymentPeriodCodeType.Days_7 Then Result     := 'Days_7'
  Else If Value = CombinedPaymentPeriodCodeType.Days_14 Then Result    := 'Days_14'
  Else If Value = CombinedPaymentPeriodCodeType.Days_30 Then Result    := 'Days_30'
  Else If Value = CombinedPaymentPeriodCodeType.Ineligible  Then Result := 'Ineligible'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: TaskStatusCodeType): String;
Begin
       If Value =TaskStatusCodeType.Pending Then Result         := 'Pending'
  Else If Value = TaskStatusCodeType.InProgress  Then Result := 'InProgress'
  Else If Value = TaskStatusCodeType.Complete Then Result   := 'Complete'
  Else If Value = TaskStatusCodeType.Failed Then Result     := 'Failed'
  Else Result                                               := '';
End;

Function enumToStr(Const Value: ListingTypeCodeType): String;
Begin
       If Value =ListingTypeCodeType.Unknown Then Result               := 'Unknown'
  Else If Value = ListingTypeCodeType.Chinese Then Result          := 'Chinese'
  Else If Value = ListingTypeCodeType.Dutch Then Result            := 'Dutch'
  Else If Value = ListingTypeCodeType.Live Then Result             := 'Live'
  Else If Value = ListingTypeCodeType.Auction Then Result          := 'Auction'
  Else If Value = ListingTypeCodeType.AdType Then Result           := 'AdType'
  Else If Value = ListingTypeCodeType.StoresFixedPrice  Then Result := 'StoresFixedPrice'
  Else If Value = ListingTypeCodeType.PersonalOffer Then Result    := 'PersonalOffer'
  Else If Value = ListingTypeCodeType.FixedPriceItem Then Result   := 'FixedPriceItem'
  Else If Value = ListingTypeCodeType.Half Then Result             := 'Half'
  Else If Value = ListingTypeCodeType.LeadGeneration Then Result   := 'LeadGeneration'
  Else If Value = ListingTypeCodeType.Express Then Result          := 'Express'
  Else If Value = ListingTypeCodeType.Shopping Then Result         := 'Shopping'
  Else If Value = ListingTypeCodeType.CustomCode Then Result       := 'CustomCode'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: RecipientRelationCodeType): String;
Begin
       If Value =RecipientRelationCodeType._1 Then Result      := '_1'
  Else If Value = RecipientRelationCodeType._2  Then Result := '_2'
  Else If Value = RecipientRelationCodeType._3  Then Result := '_3'
  Else If Value = RecipientRelationCodeType._4  Then Result := '_4'
  Else Result                                              := '';
End;

Function enumToStr(Const Value: EndReasonCodeType): String;
Begin
       If Value =EndReasonCodeType.LostOrBroken Then Result           := 'LostOrBroken'
  Else If Value = EndReasonCodeType.NotAvailable Then Result      := 'NotAvailable'
  Else If Value = EndReasonCodeType.Incorrect Then Result         := 'Incorrect'
  Else If Value = EndReasonCodeType.OtherListingError  Then Result := 'OtherListingError'
  Else If Value = EndReasonCodeType.CustomCode Then Result        := 'CustomCode'
  Else If Value = EndReasonCodeType.SellToHighBidder Then Result  := 'SellToHighBidder'
  Else Result                                                     := '';
End;

Function enumToStr(Const Value: DiscountReasonCodeType): String;
Begin
       If Value =DiscountReasonCodeType.SpecialOffer Then Result   := 'SpecialOffer'
  Else If Value = DiscountReasonCodeType.Promotion  Then Result := 'Promotion'
  Else Result                                                  := '';
End;

Function enumToStr(Const Value: DisputeReasonCodeType): String;
Begin
       If Value =DisputeReasonCodeType.BuyerHasNotPaid Then Result                  := 'BuyerHasNotPaid'
  Else If Value = DisputeReasonCodeType.TransactionMutuallyCanceled  Then Result := 'TransactionMutuallyCanceled'
  Else If Value = DisputeReasonCodeType.ItemNotReceived Then Result             := 'ItemNotReceived'
  Else If Value = DisputeReasonCodeType.SignificantlyNotAsDescribed  Then Result := 'SignificantlyNotAsDescribed'
  Else If Value = DisputeReasonCodeType.NoRefund Then Result                    := 'NoRefund'
  Else If Value = DisputeReasonCodeType.ReturnPolicyUnpaidItem Then Result      := 'ReturnPolicyUnpaidItem'
  Else Result                                                                   := '';
End;

Function enumToStr(Const Value: DisputeExplanationCodeType): String;
Begin
       If Value =DisputeExplanationCodeType.BuyerHasNotResponded Then Result                  := 'BuyerHasNotResponded'
  Else If Value = DisputeExplanationCodeType.BuyerRefusedToPay Then Result                := 'BuyerRefusedToPay'
  Else If Value = DisputeExplanationCodeType.BuyerNotClearedToPay Then Result             := 'BuyerNotClearedToPay'
  Else If Value = DisputeExplanationCodeType.BuyerReturnedItemForRefund Then Result       := 'BuyerReturnedItemForRefund'
  Else If Value = DisputeExplanationCodeType.UnableToResolveTerms Then Result             := 'UnableToResolveTerms'
  Else If Value = DisputeExplanationCodeType.BuyerNoLongerWantsItem Then Result           := 'BuyerNoLongerWantsItem'
  Else If Value = DisputeExplanationCodeType.BuyerPurchasingMistake Then Result           := 'BuyerPurchasingMistake'
  Else If Value = DisputeExplanationCodeType.ShipCountryNotSupported Then Result          := 'ShipCountryNotSupported'
  Else If Value = DisputeExplanationCodeType.ShippingAddressNotConfirmed Then Result      := 'ShippingAddressNotConfirmed'
  Else If Value = DisputeExplanationCodeType.PaymentMethodNotSupported Then Result        := 'PaymentMethodNotSupported'
  Else If Value = DisputeExplanationCodeType.BuyerNoLongerRegistered Then Result          := 'BuyerNoLongerRegistered'
  Else If Value = DisputeExplanationCodeType.OtherExplanation Then Result                 := 'OtherExplanation'
  Else If Value = DisputeExplanationCodeType.Unspecified Then Result                      := 'Unspecified'
  Else If Value = DisputeExplanationCodeType.UPIAssistance Then Result                    := 'UPIAssistance'
  Else If Value = DisputeExplanationCodeType.BuyerPaymentNotReceivedOrCleared  Then Result := 'BuyerPaymentNotReceivedOrCleared'
  Else If Value = DisputeExplanationCodeType.SellerDoesntShipToCountry Then Result        := 'SellerDoesntShipToCountry'
  Else If Value = DisputeExplanationCodeType.BuyerNotPaid Then Result                     := 'BuyerNotPaid'
  Else If Value = DisputeExplanationCodeType.UPIAssistanceDisabled Then Result            := 'UPIAssistanceDisabled'
  Else If Value = DisputeExplanationCodeType.SellerRanOutOfStock Then Result              := 'SellerRanOutOfStock'
  Else If Value = DisputeExplanationCodeType.CustomCode Then Result                       := 'CustomCode'
  Else Result                                                                             := '';
End;

Function enumToStr(Const Value: DisputeActivityCodeType): String;
Begin
       If Value =DisputeActivityCodeType.SellerAddInformation Then Result                  := 'SellerAddInformation'
  Else If Value = DisputeActivityCodeType.SellerCompletedTransaction Then Result       := 'SellerCompletedTransaction'
  Else If Value = DisputeActivityCodeType.CameToAgreementNeedFVFCredit Then Result     := 'CameToAgreementNeedFVFCredit'
  Else If Value = DisputeActivityCodeType.SellerEndCommunication Then Result           := 'SellerEndCommunication'
  Else If Value = DisputeActivityCodeType.MutualAgreementOrNoBuyerResponse  Then Result := 'MutualAgreementOrNoBuyerResponse'
  Else If Value = DisputeActivityCodeType.SellerOffersRefund Then Result               := 'SellerOffersRefund'
  Else If Value = DisputeActivityCodeType.SellerShippedItem Then Result                := 'SellerShippedItem'
  Else If Value = DisputeActivityCodeType.SellerComment Then Result                    := 'SellerComment'
  Else If Value = DisputeActivityCodeType.SellerPaymentNotReceived Then Result         := 'SellerPaymentNotReceived'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: SecondChanceOfferDurationCodeType): String;
Begin
       If Value =SecondChanceOfferDurationCodeType.Days_1 Then Result      := 'Days_1'
  Else If Value = SecondChanceOfferDurationCodeType.Days_3  Then Result := 'Days_3'
  Else If Value = SecondChanceOfferDurationCodeType.Days_5  Then Result := 'Days_5'
  Else If Value = SecondChanceOfferDurationCodeType.Days_7  Then Result := 'Days_7'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: TradingRoleCodeType): String;
Begin
       If Value =TradingRoleCodeType.Buyer Then Result       := 'Buyer'
  Else If Value = TradingRoleCodeType.Seller  Then Result := 'Seller'
  Else Result                                            := '';
End;

Function enumToStr(Const Value: PromotionMethodCodeType): String;
Begin
       If Value =PromotionMethodCodeType.CrossSell Then Result   := 'CrossSell'
  Else If Value = PromotionMethodCodeType.UpSell  Then Result := 'UpSell'
  Else Result                                                := '';
End;

Function enumToStr(Const Value: StringMatchCodeType): String;
Begin
       If Value =StringMatchCodeType.CustomCode Then Result      := 'CustomCode'
  Else If Value = StringMatchCodeType.StartsWith  Then Result := 'StartsWith'
  Else Result                                                := '';
End;

Function enumToStr(Const Value: CountryCodeType): String;
Begin
       If Value =CountryCodeType.AF Then Result              := 'AF'
  Else If Value = CountryCodeType.AL Then Result         := 'AL'
  Else If Value = CountryCodeType.DZ Then Result         := 'DZ'
  Else If Value = CountryCodeType.AS_ Then Result        := 'AS_'
  Else If Value = CountryCodeType.AD Then Result         := 'AD'
  Else If Value = CountryCodeType.AO Then Result         := 'AO'
  Else If Value = CountryCodeType.AI Then Result         := 'AI'
  Else If Value = CountryCodeType.AQ Then Result         := 'AQ'
  Else If Value = CountryCodeType.AG Then Result         := 'AG'
  Else If Value = CountryCodeType.AR Then Result         := 'AR'
  Else If Value = CountryCodeType.AM Then Result         := 'AM'
  Else If Value = CountryCodeType.AW Then Result         := 'AW'
  Else If Value = CountryCodeType.AU Then Result         := 'AU'
  Else If Value = CountryCodeType.AT Then Result         := 'AT'
  Else If Value = CountryCodeType.AZ Then Result         := 'AZ'
  Else If Value = CountryCodeType.BS Then Result         := 'BS'
  Else If Value = CountryCodeType.BH Then Result         := 'BH'
  Else If Value = CountryCodeType.BD Then Result         := 'BD'
  Else If Value = CountryCodeType.BB Then Result         := 'BB'
  Else If Value = CountryCodeType.BY Then Result         := 'BY'
  Else If Value = CountryCodeType.BE Then Result         := 'BE'
  Else If Value = CountryCodeType.BZ Then Result         := 'BZ'
  Else If Value = CountryCodeType.BJ Then Result         := 'BJ'
  Else If Value = CountryCodeType.BM Then Result         := 'BM'
  Else If Value = CountryCodeType.BT Then Result         := 'BT'
  Else If Value = CountryCodeType.BO Then Result         := 'BO'
  Else If Value = CountryCodeType.BA Then Result         := 'BA'
  Else If Value = CountryCodeType.BW Then Result         := 'BW'
  Else If Value = CountryCodeType.BV Then Result         := 'BV'
  Else If Value = CountryCodeType.BR Then Result         := 'BR'
  Else If Value = CountryCodeType.IO Then Result         := 'IO'
  Else If Value = CountryCodeType.BN Then Result         := 'BN'
  Else If Value = CountryCodeType.BG Then Result         := 'BG'
  Else If Value = CountryCodeType.BF Then Result         := 'BF'
  Else If Value = CountryCodeType.BI Then Result         := 'BI'
  Else If Value = CountryCodeType.KH Then Result         := 'KH'
  Else If Value = CountryCodeType.CM Then Result         := 'CM'
  Else If Value = CountryCodeType.CA Then Result         := 'CA'
  Else If Value = CountryCodeType.CV Then Result         := 'CV'
  Else If Value = CountryCodeType.KY Then Result         := 'KY'
  Else If Value = CountryCodeType.CF Then Result         := 'CF'
  Else If Value = CountryCodeType.TD Then Result         := 'TD'
  Else If Value = CountryCodeType.CL Then Result         := 'CL'
  Else If Value = CountryCodeType.CN Then Result         := 'CN'
  Else If Value = CountryCodeType.CX Then Result         := 'CX'
  Else If Value = CountryCodeType.CC Then Result         := 'CC'
  Else If Value = CountryCodeType.CO Then Result         := 'CO'
  Else If Value = CountryCodeType.KM Then Result         := 'KM'
  Else If Value = CountryCodeType.CG Then Result         := 'CG'
  Else If Value = CountryCodeType.CD Then Result         := 'CD'
  Else If Value = CountryCodeType.CK Then Result         := 'CK'
  Else If Value = CountryCodeType.CR Then Result         := 'CR'
  Else If Value = CountryCodeType.CI Then Result         := 'CI'
  Else If Value = CountryCodeType.HR Then Result         := 'HR'
  Else If Value = CountryCodeType.CU Then Result         := 'CU'
  Else If Value = CountryCodeType.CY Then Result         := 'CY'
  Else If Value = CountryCodeType.CZ Then Result         := 'CZ'
  Else If Value = CountryCodeType.DK Then Result         := 'DK'
  Else If Value = CountryCodeType.DJ Then Result         := 'DJ'
  Else If Value = CountryCodeType.DM Then Result         := 'DM'
  Else If Value = CountryCodeType.DO_ Then Result        := 'DO_'
  Else If Value = CountryCodeType.TP Then Result         := 'TP'
  Else If Value = CountryCodeType.EC Then Result         := 'EC'
  Else If Value = CountryCodeType.EG Then Result         := 'EG'
  Else If Value = CountryCodeType.SV Then Result         := 'SV'
  Else If Value = CountryCodeType.GQ Then Result         := 'GQ'
  Else If Value = CountryCodeType.ER Then Result         := 'ER'
  Else If Value = CountryCodeType.EE Then Result         := 'EE'
  Else If Value = CountryCodeType.ET Then Result         := 'ET'
  Else If Value = CountryCodeType.FK Then Result         := 'FK'
  Else If Value = CountryCodeType.FO Then Result         := 'FO'
  Else If Value = CountryCodeType.FJ Then Result         := 'FJ'
  Else If Value = CountryCodeType.FI Then Result         := 'FI'
  Else If Value = CountryCodeType.FR Then Result         := 'FR'
  Else If Value = CountryCodeType.GF Then Result         := 'GF'
  Else If Value = CountryCodeType.PF Then Result         := 'PF'
  Else If Value = CountryCodeType.TF Then Result         := 'TF'
  Else If Value = CountryCodeType.GA Then Result         := 'GA'
  Else If Value = CountryCodeType.GM Then Result         := 'GM'
  Else If Value = CountryCodeType.GE Then Result         := 'GE'
  Else If Value = CountryCodeType.DE Then Result         := 'DE'
  Else If Value = CountryCodeType.GH Then Result         := 'GH'
  Else If Value = CountryCodeType.GI Then Result         := 'GI'
  Else If Value = CountryCodeType.GR Then Result         := 'GR'
  Else If Value = CountryCodeType.GL Then Result         := 'GL'
  Else If Value = CountryCodeType.GD Then Result         := 'GD'
  Else If Value = CountryCodeType.GP Then Result         := 'GP'
  Else If Value = CountryCodeType.GU Then Result         := 'GU'
  Else If Value = CountryCodeType.GT Then Result         := 'GT'
  Else If Value = CountryCodeType.GN Then Result         := 'GN'
  Else If Value = CountryCodeType.GW Then Result         := 'GW'
  Else If Value = CountryCodeType.GY Then Result         := 'GY'
  Else If Value = CountryCodeType.HT Then Result         := 'HT'
  Else If Value = CountryCodeType.HM Then Result         := 'HM'
  Else If Value = CountryCodeType.VA Then Result         := 'VA'
  Else If Value = CountryCodeType.HN Then Result         := 'HN'
  Else If Value = CountryCodeType.HK Then Result         := 'HK'
  Else If Value = CountryCodeType.HU Then Result         := 'HU'
  Else If Value = CountryCodeType.IS_ Then Result        := 'IS_'
  Else If Value = CountryCodeType.IN_ Then Result        := 'IN_'
  Else If Value = CountryCodeType.ID Then Result         := 'ID'
  Else If Value = CountryCodeType.IR Then Result         := 'IR'
  Else If Value = CountryCodeType.IQ Then Result         := 'IQ'
  Else If Value = CountryCodeType.IE Then Result         := 'IE'
  Else If Value = CountryCodeType.IL Then Result         := 'IL'
  Else If Value = CountryCodeType.IT Then Result         := 'IT'
  Else If Value = CountryCodeType.JM Then Result         := 'JM'
  Else If Value = CountryCodeType.JP Then Result         := 'JP'
  Else If Value = CountryCodeType.JO Then Result         := 'JO'
  Else If Value = CountryCodeType.KZ Then Result         := 'KZ'
  Else If Value = CountryCodeType.KE Then Result         := 'KE'
  Else If Value = CountryCodeType.KI Then Result         := 'KI'
  Else If Value = CountryCodeType.KP Then Result         := 'KP'
  Else If Value = CountryCodeType.KR Then Result         := 'KR'
  Else If Value = CountryCodeType.KW Then Result         := 'KW'
  Else If Value = CountryCodeType.KG Then Result         := 'KG'
  Else If Value = CountryCodeType.LA Then Result         := 'LA'
  Else If Value = CountryCodeType.LV Then Result         := 'LV'
  Else If Value = CountryCodeType.LB Then Result         := 'LB'
  Else If Value = CountryCodeType.LS Then Result         := 'LS'
  Else If Value = CountryCodeType.LR Then Result         := 'LR'
  Else If Value = CountryCodeType.LY Then Result         := 'LY'
  Else If Value = CountryCodeType.LI Then Result         := 'LI'
  Else If Value = CountryCodeType.LT Then Result         := 'LT'
  Else If Value = CountryCodeType.LU Then Result         := 'LU'
  Else If Value = CountryCodeType.MO Then Result         := 'MO'
  Else If Value = CountryCodeType.MK Then Result         := 'MK'
  Else If Value = CountryCodeType.MG Then Result         := 'MG'
  Else If Value = CountryCodeType.MW Then Result         := 'MW'
  Else If Value = CountryCodeType.MY Then Result         := 'MY'
  Else If Value = CountryCodeType.MV Then Result         := 'MV'
  Else If Value = CountryCodeType.ML Then Result         := 'ML'
  Else If Value = CountryCodeType.MT Then Result         := 'MT'
  Else If Value = CountryCodeType.MH Then Result         := 'MH'
  Else If Value = CountryCodeType.MQ Then Result         := 'MQ'
  Else If Value = CountryCodeType.MR Then Result         := 'MR'
  Else If Value = CountryCodeType.MU Then Result         := 'MU'
  Else If Value = CountryCodeType.YT Then Result         := 'YT'
  Else If Value = CountryCodeType.MX Then Result         := 'MX'
  Else If Value = CountryCodeType.FM Then Result         := 'FM'
  Else If Value = CountryCodeType.MD Then Result         := 'MD'
  Else If Value = CountryCodeType.MC Then Result         := 'MC'
  Else If Value = CountryCodeType.MN Then Result         := 'MN'
  Else If Value = CountryCodeType.MS Then Result         := 'MS'
  Else If Value = CountryCodeType.MA Then Result         := 'MA'
  Else If Value = CountryCodeType.MZ Then Result         := 'MZ'
  Else If Value = CountryCodeType.MM Then Result         := 'MM'
  Else If Value = CountryCodeType.NA Then Result         := 'NA'
  Else If Value = CountryCodeType.NR Then Result         := 'NR'
  Else If Value = CountryCodeType.NP Then Result         := 'NP'
  Else If Value = CountryCodeType.NL Then Result         := 'NL'
  Else If Value = CountryCodeType.AN Then Result         := 'AN'
  Else If Value = CountryCodeType.NC Then Result         := 'NC'
  Else If Value = CountryCodeType.NZ Then Result         := 'NZ'
  Else If Value = CountryCodeType.NI Then Result         := 'NI'
  Else If Value = CountryCodeType.NE Then Result         := 'NE'
  Else If Value = CountryCodeType.NG Then Result         := 'NG'
  Else If Value = CountryCodeType.NU Then Result         := 'NU'
  Else If Value = CountryCodeType.NF Then Result         := 'NF'
  Else If Value = CountryCodeType.MP Then Result         := 'MP'
  Else If Value = CountryCodeType.NO Then Result         := 'NO'
  Else If Value = CountryCodeType.OM Then Result         := 'OM'
  Else If Value = CountryCodeType.PK Then Result         := 'PK'
  Else If Value = CountryCodeType.PW Then Result         := 'PW'
  Else If Value = CountryCodeType.PS Then Result         := 'PS'
  Else If Value = CountryCodeType.PA Then Result         := 'PA'
  Else If Value = CountryCodeType.PG Then Result         := 'PG'
  Else If Value = CountryCodeType.PY Then Result         := 'PY'
  Else If Value = CountryCodeType.PE Then Result         := 'PE'
  Else If Value = CountryCodeType.PH Then Result         := 'PH'
  Else If Value = CountryCodeType.PN Then Result         := 'PN'
  Else If Value = CountryCodeType.PL Then Result         := 'PL'
  Else If Value = CountryCodeType.PT Then Result         := 'PT'
  Else If Value = CountryCodeType.PR Then Result         := 'PR'
  Else If Value = CountryCodeType.QA Then Result         := 'QA'
  Else If Value = CountryCodeType.RE Then Result         := 'RE'
  Else If Value = CountryCodeType.RO Then Result         := 'RO'
  Else If Value = CountryCodeType.RU Then Result         := 'RU'
  Else If Value = CountryCodeType.RW Then Result         := 'RW'
  Else If Value = CountryCodeType.SH Then Result         := 'SH'
  Else If Value = CountryCodeType.KN Then Result         := 'KN'
  Else If Value = CountryCodeType.LC Then Result         := 'LC'
  Else If Value = CountryCodeType.PM Then Result         := 'PM'
  Else If Value = CountryCodeType.VC Then Result         := 'VC'
  Else If Value = CountryCodeType.WS Then Result         := 'WS'
  Else If Value = CountryCodeType.SM Then Result         := 'SM'
  Else If Value = CountryCodeType.ST Then Result         := 'ST'
  Else If Value = CountryCodeType.SA Then Result         := 'SA'
  Else If Value = CountryCodeType.SN Then Result         := 'SN'
  Else If Value = CountryCodeType.SC Then Result         := 'SC'
  Else If Value = CountryCodeType.SL Then Result         := 'SL'
  Else If Value = CountryCodeType.SG Then Result         := 'SG'
  Else If Value = CountryCodeType.SK Then Result         := 'SK'
  Else If Value = CountryCodeType.SI Then Result         := 'SI'
  Else If Value = CountryCodeType.SB Then Result         := 'SB'
  Else If Value = CountryCodeType.SO Then Result         := 'SO'
  Else If Value = CountryCodeType.ZA Then Result         := 'ZA'
  Else If Value = CountryCodeType.GS Then Result         := 'GS'
  Else If Value = CountryCodeType.ES Then Result         := 'ES'
  Else If Value = CountryCodeType.LK Then Result         := 'LK'
  Else If Value = CountryCodeType.SD Then Result         := 'SD'
  Else If Value = CountryCodeType.SR Then Result         := 'SR'
  Else If Value = CountryCodeType.SJ Then Result         := 'SJ'
  Else If Value = CountryCodeType.SZ Then Result         := 'SZ'
  Else If Value = CountryCodeType.SE Then Result         := 'SE'
  Else If Value = CountryCodeType.CH Then Result         := 'CH'
  Else If Value = CountryCodeType.SY Then Result         := 'SY'
  Else If Value = CountryCodeType.TW Then Result         := 'TW'
  Else If Value = CountryCodeType.TJ Then Result         := 'TJ'
  Else If Value = CountryCodeType.TZ Then Result         := 'TZ'
  Else If Value = CountryCodeType.TH Then Result         := 'TH'
  Else If Value = CountryCodeType.TG Then Result         := 'TG'
  Else If Value = CountryCodeType.TK Then Result         := 'TK'
  Else If Value = CountryCodeType.TO_ Then Result        := 'TO_'
  Else If Value = CountryCodeType.TT Then Result         := 'TT'
  Else If Value = CountryCodeType.TN Then Result         := 'TN'
  Else If Value = CountryCodeType.TR Then Result         := 'TR'
  Else If Value = CountryCodeType.TM Then Result         := 'TM'
  Else If Value = CountryCodeType.TC Then Result         := 'TC'
  Else If Value = CountryCodeType.TV Then Result         := 'TV'
  Else If Value = CountryCodeType.UG Then Result         := 'UG'
  Else If Value = CountryCodeType.UA Then Result         := 'UA'
  Else If Value = CountryCodeType.AE Then Result         := 'AE'
  Else If Value = CountryCodeType.GB Then Result         := 'GB'
  Else If Value = CountryCodeType.US Then Result         := 'US'
  Else If Value = CountryCodeType.UM Then Result         := 'UM'
  Else If Value = CountryCodeType.UY Then Result         := 'UY'
  Else If Value = CountryCodeType.UZ Then Result         := 'UZ'
  Else If Value = CountryCodeType.VU Then Result         := 'VU'
  Else If Value = CountryCodeType.VE Then Result         := 'VE'
  Else If Value = CountryCodeType.VN Then Result         := 'VN'
  Else If Value = CountryCodeType.VG Then Result         := 'VG'
  Else If Value = CountryCodeType.VI Then Result         := 'VI'
  Else If Value = CountryCodeType.WF Then Result         := 'WF'
  Else If Value = CountryCodeType.EH Then Result         := 'EH'
  Else If Value = CountryCodeType.YE Then Result         := 'YE'
  Else If Value = CountryCodeType.YU Then Result         := 'YU'
  Else If Value = CountryCodeType.ZM Then Result         := 'ZM'
  Else If Value = CountryCodeType.ZW Then Result         := 'ZW'
  Else If Value = CountryCodeType.AA Then Result         := 'AA'
  Else If Value = CountryCodeType.QM Then Result         := 'QM'
  Else If Value = CountryCodeType.QN Then Result         := 'QN'
  Else If Value = CountryCodeType.QO Then Result         := 'QO'
  Else If Value = CountryCodeType.QP Then Result         := 'QP'
  Else If Value = CountryCodeType.JE Then Result         := 'JE'
  Else If Value = CountryCodeType.GG Then Result         := 'GG'
  Else If Value = CountryCodeType.ZZ Then Result         := 'ZZ'
  Else If Value = CountryCodeType.RS Then Result         := 'RS'
  Else If Value = CountryCodeType.ME Then Result         := 'ME'
  Else If Value = CountryCodeType.CustomCode  Then Result := 'CustomCode'
  Else Result                                            := '';
End;

Function enumToStr(Const Value: TransactionPlatformCodeType): String;
Begin
       If Value =TransactionPlatformCodeType.EBay Then Result             := 'eBay'
  Else If Value = TransactionPlatformCodeType.Express Then Result     := 'Express'
  Else If Value = TransactionPlatformCodeType.Half Then Result        := 'Half'
  Else If Value = TransactionPlatformCodeType.Shopping Then Result    := 'Shopping'
  Else If Value = TransactionPlatformCodeType.WorldOfGood  Then Result := 'WorldOfGood'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: ItemSortTypeCodeType): String;
Begin
       If Value =ItemSortTypeCodeType.ItemID Then Result                                   := 'ItemID'
  Else If Value = ItemSortTypeCodeType.Price Then Result                               := 'Price'
  Else If Value = ItemSortTypeCodeType.StartPrice Then Result                          := 'StartPrice'
  Else If Value = ItemSortTypeCodeType.Title Then Result                               := 'Title'
  Else If Value = ItemSortTypeCodeType.BidCount Then Result                            := 'BidCount'
  Else If Value = ItemSortTypeCodeType.Quantity Then Result                            := 'Quantity'
  Else If Value = ItemSortTypeCodeType.StartTime Then Result                           := 'StartTime'
  Else If Value = ItemSortTypeCodeType.EndTime Then Result                             := 'EndTime'
  Else If Value = ItemSortTypeCodeType.SellerUserID Then Result                        := 'SellerUserID'
  Else If Value = ItemSortTypeCodeType.TimeLeft Then Result                            := 'TimeLeft'
  Else If Value = ItemSortTypeCodeType.ListingDuration Then Result                     := 'ListingDuration'
  Else If Value = ItemSortTypeCodeType.ListingType Then Result                         := 'ListingType'
  Else If Value = ItemSortTypeCodeType.CurrentPrice Then Result                        := 'CurrentPrice'
  Else If Value = ItemSortTypeCodeType.ReservePrice Then Result                        := 'ReservePrice'
  Else If Value = ItemSortTypeCodeType.MaxBid Then Result                              := 'MaxBid'
  Else If Value = ItemSortTypeCodeType.BidderCount Then Result                         := 'BidderCount'
  Else If Value = ItemSortTypeCodeType.HighBidderUserID Then Result                    := 'HighBidderUserID'
  Else If Value = ItemSortTypeCodeType.BuyerUserID Then Result                         := 'BuyerUserID'
  Else If Value = ItemSortTypeCodeType.BuyerPostalCode Then Result                     := 'BuyerPostalCode'
  Else If Value = ItemSortTypeCodeType.BuyerEmail Then Result                          := 'BuyerEmail'
  Else If Value = ItemSortTypeCodeType.SellerEmail Then Result                         := 'SellerEmail'
  Else If Value = ItemSortTypeCodeType.TotalPrice Then Result                          := 'TotalPrice'
  Else If Value = ItemSortTypeCodeType.WatchCount Then Result                          := 'WatchCount'
  Else If Value = ItemSortTypeCodeType.BestOfferCount Then Result                      := 'BestOfferCount'
  Else If Value = ItemSortTypeCodeType.QuestionCount Then Result                       := 'QuestionCount'
  Else If Value = ItemSortTypeCodeType.ShippingServiceCost Then Result                 := 'ShippingServiceCost'
  Else If Value = ItemSortTypeCodeType.FeedbackReceived Then Result                    := 'FeedbackReceived'
  Else If Value = ItemSortTypeCodeType.FeedbackLeft Then Result                        := 'FeedbackLeft'
  Else If Value = ItemSortTypeCodeType.UserID Then Result                              := 'UserID'
  Else If Value = ItemSortTypeCodeType.QuantitySold Then Result                        := 'QuantitySold'
  Else If Value = ItemSortTypeCodeType.BestOffer Then Result                           := 'BestOffer'
  Else If Value = ItemSortTypeCodeType.QuantityAvailable Then Result                   := 'QuantityAvailable'
  Else If Value = ItemSortTypeCodeType.QuantityPurchased Then Result                   := 'QuantityPurchased'
  Else If Value = ItemSortTypeCodeType.WonPlatform Then Result                         := 'WonPlatform'
  Else If Value = ItemSortTypeCodeType.SoldPlatform Then Result                        := 'SoldPlatform'
  Else If Value = ItemSortTypeCodeType.ListingDurationDescending Then Result           := 'ListingDurationDescending'
  Else If Value = ItemSortTypeCodeType.ListingTypeDescending Then Result               := 'ListingTypeDescending'
  Else If Value = ItemSortTypeCodeType.CurrentPriceDescending Then Result              := 'CurrentPriceDescending'
  Else If Value = ItemSortTypeCodeType.ReservePriceDescending Then Result              := 'ReservePriceDescending'
  Else If Value = ItemSortTypeCodeType.MaxBidDescending Then Result                    := 'MaxBidDescending'
  Else If Value = ItemSortTypeCodeType.BidderCountDescending Then Result               := 'BidderCountDescending'
  Else If Value = ItemSortTypeCodeType.HighBidderUserIDDescending Then Result          := 'HighBidderUserIDDescending'
  Else If Value = ItemSortTypeCodeType.BuyerUserIDDescending Then Result               := 'BuyerUserIDDescending'
  Else If Value = ItemSortTypeCodeType.BuyerPostalCodeDescending Then Result           := 'BuyerPostalCodeDescending'
  Else If Value = ItemSortTypeCodeType.BuyerEmailDescending Then Result                := 'BuyerEmailDescending'
  Else If Value = ItemSortTypeCodeType.SellerEmailDescending Then Result               := 'SellerEmailDescending'
  Else If Value = ItemSortTypeCodeType.TotalPriceDescending Then Result                := 'TotalPriceDescending'
  Else If Value = ItemSortTypeCodeType.WatchCountDescending Then Result                := 'WatchCountDescending'
  Else If Value = ItemSortTypeCodeType.QuestionCountDescending Then Result             := 'QuestionCountDescending'
  Else If Value = ItemSortTypeCodeType.ShippingServiceCostDescending Then Result       := 'ShippingServiceCostDescending'
  Else If Value = ItemSortTypeCodeType.FeedbackReceivedDescending Then Result          := 'FeedbackReceivedDescending'
  Else If Value = ItemSortTypeCodeType.FeedbackLeftDescending Then Result              := 'FeedbackLeftDescending'
  Else If Value = ItemSortTypeCodeType.UserIDDescending Then Result                    := 'UserIDDescending'
  Else If Value = ItemSortTypeCodeType.QuantitySoldDescending Then Result              := 'QuantitySoldDescending'
  Else If Value = ItemSortTypeCodeType.BestOfferCountDescending Then Result            := 'BestOfferCountDescending'
  Else If Value = ItemSortTypeCodeType.QuantityAvailableDescending Then Result         := 'QuantityAvailableDescending'
  Else If Value = ItemSortTypeCodeType.QuantityPurchasedDescending Then Result         := 'QuantityPurchasedDescending'
  Else If Value = ItemSortTypeCodeType.BestOfferDescending Then Result                 := 'BestOfferDescending'
  Else If Value = ItemSortTypeCodeType.ItemIDDescending Then Result                    := 'ItemIDDescending'
  Else If Value = ItemSortTypeCodeType.PriceDescending Then Result                     := 'PriceDescending'
  Else If Value = ItemSortTypeCodeType.StartPriceDescending Then Result                := 'StartPriceDescending'
  Else If Value = ItemSortTypeCodeType.TitleDescending Then Result                     := 'TitleDescending'
  Else If Value = ItemSortTypeCodeType.BidCountDescending Then Result                  := 'BidCountDescending'
  Else If Value = ItemSortTypeCodeType.QuantityDescending Then Result                  := 'QuantityDescending'
  Else If Value = ItemSortTypeCodeType.StartTimeDescending Then Result                 := 'StartTimeDescending'
  Else If Value = ItemSortTypeCodeType.EndTimeDescending Then Result                   := 'EndTimeDescending'
  Else If Value = ItemSortTypeCodeType.SellerUserIDDescending Then Result              := 'SellerUserIDDescending'
  Else If Value = ItemSortTypeCodeType.TimeLeftDescending Then Result                  := 'TimeLeftDescending'
  Else If Value = ItemSortTypeCodeType.WonPlatformDescending Then Result               := 'WonPlatformDescending'
  Else If Value = ItemSortTypeCodeType.SoldPlatformDescending Then Result              := 'SoldPlatformDescending'
  Else If Value = ItemSortTypeCodeType.LeadCount Then Result                           := 'LeadCount'
  Else If Value = ItemSortTypeCodeType.NewLeadCount Then Result                        := 'NewLeadCount'
  Else If Value = ItemSortTypeCodeType.LeadCountDescending Then Result                 := 'LeadCountDescending'
  Else If Value = ItemSortTypeCodeType.NewLeadCountDescending Then Result              := 'NewLeadCountDescending'
  Else If Value = ItemSortTypeCodeType.ClassifiedAdPayPerLeadFee Then Result           := 'ClassifiedAdPayPerLeadFee'
  Else If Value = ItemSortTypeCodeType.ClassifiedAdPayPerLeadFeeDescending  Then Result := 'ClassifiedAdPayPerLeadFeeDescending'
  Else If Value = ItemSortTypeCodeType.CustomCode Then Result                          := 'CustomCode'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: CommentTypeCodeType): String;
Begin
       If Value =CommentTypeCodeType.Positive Then Result                    := 'Positive'
  Else If Value = CommentTypeCodeType.Neutral Then Result                := 'Neutral'
  Else If Value = CommentTypeCodeType.Negative Then Result               := 'Negative'
  Else If Value = CommentTypeCodeType.Withdrawn Then Result              := 'Withdrawn'
  Else If Value = CommentTypeCodeType.IndependentlyWithdrawn  Then Result := 'IndependentlyWithdrawn'
  Else Result                                                            := '';
End;

Function enumToStr(Const Value: FeedbackTypeCodeType): String;
Begin
       If Value =FeedbackTypeCodeType.FeedbackReceivedAsSeller Then Result     := 'FeedbackReceivedAsSeller'
  Else If Value = FeedbackTypeCodeType.FeedbackReceivedAsBuyer  Then Result := 'FeedbackReceivedAsBuyer'
  Else If Value = FeedbackTypeCodeType.FeedbackReceived Then Result        := 'FeedbackReceived'
  Else If Value = FeedbackTypeCodeType.FeedbackLeft Then Result            := 'FeedbackLeft'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: ListingStatusCodeType): String;
Begin
       If Value =ListingStatusCodeType.Active Then Result          := 'Active'
  Else If Value = ListingStatusCodeType.Ended Then Result      := 'Ended'
  Else If Value = ListingStatusCodeType.Completed Then Result  := 'Completed'
  Else If Value = ListingStatusCodeType.CustomCode  Then Result := 'CustomCode'
  Else Result                                                  := '';
End;

Function enumToStr(Const Value: GetAllBiddersModeCodeType): String;
Begin
       If Value =GetAllBiddersModeCodeType.ViewAll Then Result                               := 'ViewAll'
  Else If Value = GetAllBiddersModeCodeType.EndedListing Then Result                     := 'EndedListing'
  Else If Value = GetAllBiddersModeCodeType.SecondChanceEligibleEndedListing  Then Result := 'SecondChanceEligibleEndedListing'
  Else Result                                                                            := '';
End;

Function enumToStr(Const Value: CurrencyCodeType): String;
Begin
       If Value =CurrencyCodeType.AFA Then Result             := 'AFA'
  Else If Value = CurrencyCodeType.ALL Then Result        := 'ALL'
  Else If Value = CurrencyCodeType.DZD Then Result        := 'DZD'
  Else If Value = CurrencyCodeType.ADP Then Result        := 'ADP'
  Else If Value = CurrencyCodeType.AOA Then Result        := 'AOA'
  Else If Value = CurrencyCodeType.ARS Then Result        := 'ARS'
  Else If Value = CurrencyCodeType.AMD Then Result        := 'AMD'
  Else If Value = CurrencyCodeType.AWG Then Result        := 'AWG'
  Else If Value = CurrencyCodeType.AZM Then Result        := 'AZM'
  Else If Value = CurrencyCodeType.BSD Then Result        := 'BSD'
  Else If Value = CurrencyCodeType.BHD Then Result        := 'BHD'
  Else If Value = CurrencyCodeType.BDT Then Result        := 'BDT'
  Else If Value = CurrencyCodeType.BBD Then Result        := 'BBD'
  Else If Value = CurrencyCodeType.BYR Then Result        := 'BYR'
  Else If Value = CurrencyCodeType.BZD Then Result        := 'BZD'
  Else If Value = CurrencyCodeType.BMD Then Result        := 'BMD'
  Else If Value = CurrencyCodeType.BTN Then Result        := 'BTN'
  Else If Value = CurrencyCodeType.INR Then Result        := 'INR'
  Else If Value = CurrencyCodeType.BOV Then Result        := 'BOV'
  Else If Value = CurrencyCodeType.BOB Then Result        := 'BOB'
  Else If Value = CurrencyCodeType.BAM Then Result        := 'BAM'
  Else If Value = CurrencyCodeType.BWP Then Result        := 'BWP'
  Else If Value = CurrencyCodeType.BRL Then Result        := 'BRL'
  Else If Value = CurrencyCodeType.BND Then Result        := 'BND'
  Else If Value = CurrencyCodeType.BGL Then Result        := 'BGL'
  Else If Value = CurrencyCodeType.BGN Then Result        := 'BGN'
  Else If Value = CurrencyCodeType.BIF Then Result        := 'BIF'
  Else If Value = CurrencyCodeType.KHR Then Result        := 'KHR'
  Else If Value = CurrencyCodeType.CAD Then Result        := 'CAD'
  Else If Value = CurrencyCodeType.CVE Then Result        := 'CVE'
  Else If Value = CurrencyCodeType.KYD Then Result        := 'KYD'
  Else If Value = CurrencyCodeType.XAF Then Result        := 'XAF'
  Else If Value = CurrencyCodeType.CLF Then Result        := 'CLF'
  Else If Value = CurrencyCodeType.CLP Then Result        := 'CLP'
  Else If Value = CurrencyCodeType.CNY Then Result        := 'CNY'
  Else If Value = CurrencyCodeType.COP Then Result        := 'COP'
  Else If Value = CurrencyCodeType.KMF Then Result        := 'KMF'
  Else If Value = CurrencyCodeType.CDF Then Result        := 'CDF'
  Else If Value = CurrencyCodeType.CRC Then Result        := 'CRC'
  Else If Value = CurrencyCodeType.HRK Then Result        := 'HRK'
  Else If Value = CurrencyCodeType.CUP Then Result        := 'CUP'
  Else If Value = CurrencyCodeType.CYP Then Result        := 'CYP'
  Else If Value = CurrencyCodeType.CZK Then Result        := 'CZK'
  Else If Value = CurrencyCodeType.DKK Then Result        := 'DKK'
  Else If Value = CurrencyCodeType.DJF Then Result        := 'DJF'
  Else If Value = CurrencyCodeType.DOP Then Result        := 'DOP'
  Else If Value = CurrencyCodeType.TPE Then Result        := 'TPE'
  Else If Value = CurrencyCodeType.ECV Then Result        := 'ECV'
  Else If Value = CurrencyCodeType.ECS Then Result        := 'ECS'
  Else If Value = CurrencyCodeType.EGP Then Result        := 'EGP'
  Else If Value = CurrencyCodeType.SVC Then Result        := 'SVC'
  Else If Value = CurrencyCodeType.ERN Then Result        := 'ERN'
  Else If Value = CurrencyCodeType.EEK Then Result        := 'EEK'
  Else If Value = CurrencyCodeType.ETB Then Result        := 'ETB'
  Else If Value = CurrencyCodeType.FKP Then Result        := 'FKP'
  Else If Value = CurrencyCodeType.FJD Then Result        := 'FJD'
  Else If Value = CurrencyCodeType.GMD Then Result        := 'GMD'
  Else If Value = CurrencyCodeType.GEL Then Result        := 'GEL'
  Else If Value = CurrencyCodeType.GHC Then Result        := 'GHC'
  Else If Value = CurrencyCodeType.GIP Then Result        := 'GIP'
  Else If Value = CurrencyCodeType.GTQ Then Result        := 'GTQ'
  Else If Value = CurrencyCodeType.GNF Then Result        := 'GNF'
  Else If Value = CurrencyCodeType.GWP Then Result        := 'GWP'
  Else If Value = CurrencyCodeType.GYD Then Result        := 'GYD'
  Else If Value = CurrencyCodeType.HTG Then Result        := 'HTG'
  Else If Value = CurrencyCodeType.HNL Then Result        := 'HNL'
  Else If Value = CurrencyCodeType.HKD Then Result        := 'HKD'
  Else If Value = CurrencyCodeType.HUF Then Result        := 'HUF'
  Else If Value = CurrencyCodeType.ISK Then Result        := 'ISK'
  Else If Value = CurrencyCodeType.IDR Then Result        := 'IDR'
  Else If Value = CurrencyCodeType.IRR Then Result        := 'IRR'
  Else If Value = CurrencyCodeType.IQD Then Result        := 'IQD'
  Else If Value = CurrencyCodeType.ILS Then Result        := 'ILS'
  Else If Value = CurrencyCodeType.JMD Then Result        := 'JMD'
  Else If Value = CurrencyCodeType.JPY Then Result        := 'JPY'
  Else If Value = CurrencyCodeType.JOD Then Result        := 'JOD'
  Else If Value = CurrencyCodeType.KZT Then Result        := 'KZT'
  Else If Value = CurrencyCodeType.KES Then Result        := 'KES'
  Else If Value = CurrencyCodeType.AUD Then Result        := 'AUD'
  Else If Value = CurrencyCodeType.KPW Then Result        := 'KPW'
  Else If Value = CurrencyCodeType.KRW Then Result        := 'KRW'
  Else If Value = CurrencyCodeType.KWD Then Result        := 'KWD'
  Else If Value = CurrencyCodeType.KGS Then Result        := 'KGS'
  Else If Value = CurrencyCodeType.LAK Then Result        := 'LAK'
  Else If Value = CurrencyCodeType.LVL Then Result        := 'LVL'
  Else If Value = CurrencyCodeType.LBP Then Result        := 'LBP'
  Else If Value = CurrencyCodeType.LSL Then Result        := 'LSL'
  Else If Value = CurrencyCodeType.LRD Then Result        := 'LRD'
  Else If Value = CurrencyCodeType.LYD Then Result        := 'LYD'
  Else If Value = CurrencyCodeType.CHF Then Result        := 'CHF'
  Else If Value = CurrencyCodeType.LTL Then Result        := 'LTL'
  Else If Value = CurrencyCodeType.MOP Then Result        := 'MOP'
  Else If Value = CurrencyCodeType.MKD Then Result        := 'MKD'
  Else If Value = CurrencyCodeType.MGF Then Result        := 'MGF'
  Else If Value = CurrencyCodeType.MWK Then Result        := 'MWK'
  Else If Value = CurrencyCodeType.MYR Then Result        := 'MYR'
  Else If Value = CurrencyCodeType.MVR Then Result        := 'MVR'
  Else If Value = CurrencyCodeType.MTL Then Result        := 'MTL'
  Else If Value = CurrencyCodeType.EUR Then Result        := 'EUR'
  Else If Value = CurrencyCodeType.MRO Then Result        := 'MRO'
  Else If Value = CurrencyCodeType.MUR Then Result        := 'MUR'
  Else If Value = CurrencyCodeType.MXN Then Result        := 'MXN'
  Else If Value = CurrencyCodeType.MXV Then Result        := 'MXV'
  Else If Value = CurrencyCodeType.MDL Then Result        := 'MDL'
  Else If Value = CurrencyCodeType.MNT Then Result        := 'MNT'
  Else If Value = CurrencyCodeType.XCD Then Result        := 'XCD'
  Else If Value = CurrencyCodeType.MZM Then Result        := 'MZM'
  Else If Value = CurrencyCodeType.MMK Then Result        := 'MMK'
  Else If Value = CurrencyCodeType.ZAR Then Result        := 'ZAR'
  Else If Value = CurrencyCodeType.NAD Then Result        := 'NAD'
  Else If Value = CurrencyCodeType.NPR Then Result        := 'NPR'
  Else If Value = CurrencyCodeType.ANG Then Result        := 'ANG'
  Else If Value = CurrencyCodeType.XPF Then Result        := 'XPF'
  Else If Value = CurrencyCodeType.NZD Then Result        := 'NZD'
  Else If Value = CurrencyCodeType.NIO Then Result        := 'NIO'
  Else If Value = CurrencyCodeType.NGN Then Result        := 'NGN'
  Else If Value = CurrencyCodeType.NOK Then Result        := 'NOK'
  Else If Value = CurrencyCodeType.OMR Then Result        := 'OMR'
  Else If Value = CurrencyCodeType.PKR Then Result        := 'PKR'
  Else If Value = CurrencyCodeType.PAB Then Result        := 'PAB'
  Else If Value = CurrencyCodeType.PGK Then Result        := 'PGK'
  Else If Value = CurrencyCodeType.PYG Then Result        := 'PYG'
  Else If Value = CurrencyCodeType.PEN Then Result        := 'PEN'
  Else If Value = CurrencyCodeType.PHP Then Result        := 'PHP'
  Else If Value = CurrencyCodeType.PLN Then Result        := 'PLN'
  Else If Value = CurrencyCodeType.USD Then Result        := 'USD'
  Else If Value = CurrencyCodeType.QAR Then Result        := 'QAR'
  Else If Value = CurrencyCodeType.ROL Then Result        := 'ROL'
  Else If Value = CurrencyCodeType.RUB Then Result        := 'RUB'
  Else If Value = CurrencyCodeType.RUR Then Result        := 'RUR'
  Else If Value = CurrencyCodeType.RWF Then Result        := 'RWF'
  Else If Value = CurrencyCodeType.SHP Then Result        := 'SHP'
  Else If Value = CurrencyCodeType.WST Then Result        := 'WST'
  Else If Value = CurrencyCodeType.STD Then Result        := 'STD'
  Else If Value = CurrencyCodeType.SAR Then Result        := 'SAR'
  Else If Value = CurrencyCodeType.SCR Then Result        := 'SCR'
  Else If Value = CurrencyCodeType.SLL Then Result        := 'SLL'
  Else If Value = CurrencyCodeType.SGD Then Result        := 'SGD'
  Else If Value = CurrencyCodeType.SKK Then Result        := 'SKK'
  Else If Value = CurrencyCodeType.SIT Then Result        := 'SIT'
  Else If Value = CurrencyCodeType.SBD Then Result        := 'SBD'
  Else If Value = CurrencyCodeType.SOS Then Result        := 'SOS'
  Else If Value = CurrencyCodeType.LKR Then Result        := 'LKR'
  Else If Value = CurrencyCodeType.SDD Then Result        := 'SDD'
  Else If Value = CurrencyCodeType.SRG Then Result        := 'SRG'
  Else If Value = CurrencyCodeType.SZL Then Result        := 'SZL'
  Else If Value = CurrencyCodeType.SEK Then Result        := 'SEK'
  Else If Value = CurrencyCodeType.SYP Then Result        := 'SYP'
  Else If Value = CurrencyCodeType.TWD Then Result        := 'TWD'
  Else If Value = CurrencyCodeType.TJS Then Result        := 'TJS'
  Else If Value = CurrencyCodeType.TZS Then Result        := 'TZS'
  Else If Value = CurrencyCodeType.THB Then Result        := 'THB'
  Else If Value = CurrencyCodeType.XOF Then Result        := 'XOF'
  Else If Value = CurrencyCodeType.TOP Then Result        := 'TOP'
  Else If Value = CurrencyCodeType.TTD Then Result        := 'TTD'
  Else If Value = CurrencyCodeType.TND Then Result        := 'TND'
  Else If Value = CurrencyCodeType.TRL Then Result        := 'TRL'
  Else If Value = CurrencyCodeType.TMM Then Result        := 'TMM'
  Else If Value = CurrencyCodeType.UGX Then Result        := 'UGX'
  Else If Value = CurrencyCodeType.UAH Then Result        := 'UAH'
  Else If Value = CurrencyCodeType.AED Then Result        := 'AED'
  Else If Value = CurrencyCodeType.GBP Then Result        := 'GBP'
  Else If Value = CurrencyCodeType.USS Then Result        := 'USS'
  Else If Value = CurrencyCodeType.USN Then Result        := 'USN'
  Else If Value = CurrencyCodeType.UYU Then Result        := 'UYU'
  Else If Value = CurrencyCodeType.UZS Then Result        := 'UZS'
  Else If Value = CurrencyCodeType.VUV Then Result        := 'VUV'
  Else If Value = CurrencyCodeType.VEB Then Result        := 'VEB'
  Else If Value = CurrencyCodeType.VND Then Result        := 'VND'
  Else If Value = CurrencyCodeType.MAD Then Result        := 'MAD'
  Else If Value = CurrencyCodeType.YER Then Result        := 'YER'
  Else If Value = CurrencyCodeType.YUM Then Result        := 'YUM'
  Else If Value = CurrencyCodeType.ZMK Then Result        := 'ZMK'
  Else If Value = CurrencyCodeType.ZWD Then Result        := 'ZWD'
  Else If Value = CurrencyCodeType.ATS Then Result        := 'ATS'
  Else If Value = CurrencyCodeType.CustomCode  Then Result := 'CustomCode'
  Else Result                                             := '';
End;

Function enumToStr(Const Value: AccountHistorySelectionCodeType): String;
Begin
       If Value =AccountHistorySelectionCodeType.LastInvoice Then Result                := 'LastInvoice'
  Else If Value = AccountHistorySelectionCodeType.SpecifiedInvoice Then Result      := 'SpecifiedInvoice'
  Else If Value = AccountHistorySelectionCodeType.BetweenSpecifiedDates  Then Result := 'BetweenSpecifiedDates'
  Else Result                                                                       := '';
End;

Function enumToStr(Const Value: AccountEntrySortTypeCodeType): String;
Begin
       If Value =AccountEntrySortTypeCodeType.None Then Result                                   := 'None'
  Else If Value = AccountEntrySortTypeCodeType.AccountEntryCreatedTimeAscending Then Result  := 'AccountEntryCreatedTimeAscending'
  Else If Value = AccountEntrySortTypeCodeType.AccountEntryCreatedTimeDescending  Then Result := 'AccountEntryCreatedTimeDescending'
  Else If Value = AccountEntrySortTypeCodeType.AccountEntryItemNumberAscending Then Result   := 'AccountEntryItemNumberAscending'
  Else If Value = AccountEntrySortTypeCodeType.AccountEntryItemNumberDescending Then Result  := 'AccountEntryItemNumberDescending'
  Else If Value = AccountEntrySortTypeCodeType.AccountEntryFeeTypeAscending Then Result      := 'AccountEntryFeeTypeAscending'
  Else If Value = AccountEntrySortTypeCodeType.AccountEntryFeeTypeDescending Then Result     := 'AccountEntryFeeTypeDescending'
  Else Result                                                                                := '';
End;

Function enumToStr(Const Value: MessageStatusTypeCodeType): String;
Begin
       If Value =MessageStatusTypeCodeType.Answered Then Result        := 'Answered'
  Else If Value = MessageStatusTypeCodeType.Unanswered  Then Result := 'Unanswered'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: FeatureIDCodeType): String;
Begin
       If Value =FeatureIDCodeType.ListingDurations Then Result                               := 'ListingDurations'
  Else If Value = FeatureIDCodeType.BestOfferEnabled Then Result                          := 'BestOfferEnabled'
  Else If Value = FeatureIDCodeType.DutchBINEnabled Then Result                           := 'DutchBINEnabled'
  Else If Value = FeatureIDCodeType.ShippingTermsRequired Then Result                     := 'ShippingTermsRequired'
  Else If Value = FeatureIDCodeType.UserConsentRequired Then Result                       := 'UserConsentRequired'
  Else If Value = FeatureIDCodeType.HomePageFeaturedEnabled Then Result                   := 'HomePageFeaturedEnabled'
  Else If Value = FeatureIDCodeType.AdFormatEnabled Then Result                           := 'AdFormatEnabled'
  Else If Value = FeatureIDCodeType.DigitalDeliveryEnabled Then Result                    := 'DigitalDeliveryEnabled'
  Else If Value = FeatureIDCodeType.BestOfferCounterEnabled Then Result                   := 'BestOfferCounterEnabled'
  Else If Value = FeatureIDCodeType.BestOfferAutoDeclineEnabled Then Result               := 'BestOfferAutoDeclineEnabled'
  Else If Value = FeatureIDCodeType.ProPack Then Result                                   := 'ProPack'
  Else If Value = FeatureIDCodeType.BasicUpgradePack Then Result                          := 'BasicUpgradePack'
  Else If Value = FeatureIDCodeType.ValuePack Then Result                                 := 'ValuePack'
  Else If Value = FeatureIDCodeType.ProPackPlus Then Result                               := 'ProPackPlus'
  Else If Value = FeatureIDCodeType.LocalMarketSpecialitySubscription Then Result         := 'LocalMarketSpecialitySubscription'
  Else If Value = FeatureIDCodeType.LocalMarketRegularSubscription Then Result            := 'LocalMarketRegularSubscription'
  Else If Value = FeatureIDCodeType.LocalMarketPremiumSubscription Then Result            := 'LocalMarketPremiumSubscription'
  Else If Value = FeatureIDCodeType.LocalMarketNonSubscription Then Result                := 'LocalMarketNonSubscription'
  Else If Value = FeatureIDCodeType.ExpressEnabled Then Result                            := 'ExpressEnabled'
  Else If Value = FeatureIDCodeType.ExpressPicturesRequired Then Result                   := 'ExpressPicturesRequired'
  Else If Value = FeatureIDCodeType.ExpressConditionRequired Then Result                  := 'ExpressConditionRequired'
  Else If Value = FeatureIDCodeType.SellerContactDetailsEnabled Then Result               := 'SellerContactDetailsEnabled'
  Else If Value = FeatureIDCodeType.CustomCode Then Result                                := 'CustomCode'
  Else If Value = FeatureIDCodeType.MinimumReservePrice Then Result                       := 'MinimumReservePrice'
  Else If Value = FeatureIDCodeType.TransactionConfirmationRequestEnabled Then Result     := 'TransactionConfirmationRequestEnabled'
  Else If Value = FeatureIDCodeType.StoreInventoryEnabled Then Result                     := 'StoreInventoryEnabled'
  Else If Value = FeatureIDCodeType.LocalListingDistances Then Result                     := 'LocalListingDistances'
  Else If Value = FeatureIDCodeType.SkypeMeTransactionalEnabled Then Result               := 'SkypeMeTransactionalEnabled'
  Else If Value = FeatureIDCodeType.SkypeMeNonTransactionalEnabled Then Result            := 'SkypeMeNonTransactionalEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdPaymentMethodEnabled Then Result          := 'ClassifiedAdPaymentMethodEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdShippingMethodEnabled Then Result         := 'ClassifiedAdShippingMethodEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdBestOfferEnabled Then Result              := 'ClassifiedAdBestOfferEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdCounterOfferEnabled Then Result           := 'ClassifiedAdCounterOfferEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdAutoDeclineEnabled Then Result            := 'ClassifiedAdAutoDeclineEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdContactByEmailEnabled Then Result         := 'ClassifiedAdContactByEmailEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdContactByPhoneEnabled Then Result         := 'ClassifiedAdContactByPhoneEnabled'
  Else If Value = FeatureIDCodeType.SafePaymentRequired Then Result                       := 'SafePaymentRequired'
  Else If Value = FeatureIDCodeType.MaximumBestOffersAllowed Then Result                  := 'MaximumBestOffersAllowed'
  Else If Value = FeatureIDCodeType.ClassifiedAdMaximumBestOffersAllowed Then Result      := 'ClassifiedAdMaximumBestOffersAllowed'
  Else If Value = FeatureIDCodeType.ClassifiedAdContactByEmailAvailable Then Result       := 'ClassifiedAdContactByEmailAvailable'
  Else If Value = FeatureIDCodeType.ClassifiedAdPayPerLeadEnabled Then Result             := 'ClassifiedAdPayPerLeadEnabled'
  Else If Value = FeatureIDCodeType.ItemSpecificsEnabled Then Result                      := 'ItemSpecificsEnabled'
  Else If Value = FeatureIDCodeType.PaisaPayFullEscrowEnabled Then Result                 := 'PaisaPayFullEscrowEnabled'
  Else If Value = FeatureIDCodeType.ISBNIdentifierEnabled Then Result                     := 'ISBNIdentifierEnabled'
  Else If Value = FeatureIDCodeType.UPCIdentifierEnabled Then Result                      := 'UPCIdentifierEnabled'
  Else If Value = FeatureIDCodeType.EANIdentifierEnabled Then Result                      := 'EANIdentifierEnabled'
  Else If Value = FeatureIDCodeType.BrandMPNIdentifierEnabled Then Result                 := 'BrandMPNIdentifierEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdAutoAcceptEnabled Then Result             := 'ClassifiedAdAutoAcceptEnabled'
  Else If Value = FeatureIDCodeType.BestOfferAutoAcceptEnabled Then Result                := 'BestOfferAutoAcceptEnabled'
  Else If Value = FeatureIDCodeType.CrossBorderTradeEnabled Then Result                   := 'CrossBorderTradeEnabled'
  Else If Value = FeatureIDCodeType.PayPalBuyerProtectionEnabled Then Result              := 'PayPalBuyerProtectionEnabled'
  Else If Value = FeatureIDCodeType.BuyerGuaranteeEnabled Then Result                     := 'BuyerGuaranteeEnabled'
  Else If Value = FeatureIDCodeType.INEscrowWorkflowTimeline Then Result                  := 'INEscrowWorkflowTimeline'
  Else If Value = FeatureIDCodeType.CombinedFixedPriceTreatment Then Result               := 'CombinedFixedPriceTreatment'
  Else If Value = FeatureIDCodeType.GalleryFeaturedDurations Then Result                  := 'GalleryFeaturedDurations'
  Else If Value = FeatureIDCodeType.PayPalRequired Then Result                            := 'PayPalRequired'
  Else If Value = FeatureIDCodeType.EBayMotorsProAdFormatEnabled Then Result              := 'eBayMotorsProAdFormatEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProContactByPhoneEnabled Then Result        := 'eBayMotorsProContactByPhoneEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProContactByAddressEnabled Then Result      := 'eBayMotorsProContactByAddressEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProCompanyNameEnabled Then Result           := 'eBayMotorsProCompanyNameEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProContactByEmailEnabled Then Result        := 'eBayMotorsProContactByEmailEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProBestOfferEnabled Then Result             := 'eBayMotorsProBestOfferEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProAutoAcceptEnabled Then Result            := 'eBayMotorsProAutoAcceptEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProAutoDeclineEnabled Then Result           := 'eBayMotorsProAutoDeclineEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProPaymentMethodCheckOutEnabled  Then Result := 'eBayMotorsProPaymentMethodCheckOutEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProShippingMethodEnabled Then Result        := 'eBayMotorsProShippingMethodEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProCounterOfferEnabled Then Result          := 'eBayMotorsProCounterOfferEnabled'
  Else If Value = FeatureIDCodeType.EBayMotorsProSellerContactDetailsEnabled Then Result  := 'eBayMotorsProSellerContactDetailsEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketAdFormatEnabled Then Result                := 'LocalMarketAdFormatEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketContactByPhoneEnabled Then Result          := 'LocalMarketContactByPhoneEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketContactByAddressEnabled Then Result        := 'LocalMarketContactByAddressEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketCompanyNameEnabled Then Result             := 'LocalMarketCompanyNameEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketContactByEmailEnabled Then Result          := 'LocalMarketContactByEmailEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketBestOfferEnabled Then Result               := 'LocalMarketBestOfferEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketAutoAcceptEnabled Then Result              := 'LocalMarketAutoAcceptEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketAutoDeclineEnabled Then Result             := 'LocalMarketAutoDeclineEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketPaymentMethodCheckOutEnabled Then Result   := 'LocalMarketPaymentMethodCheckOutEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketShippingMethodEnabled Then Result          := 'LocalMarketShippingMethodEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketCounterOfferEnabled Then Result            := 'LocalMarketCounterOfferEnabled'
  Else If Value = FeatureIDCodeType.LocalMarketSellerContactDetailsEnabled Then Result    := 'LocalMarketSellerContactDetailsEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdContactByAddressEnabled Then Result       := 'ClassifiedAdContactByAddressEnabled'
  Else If Value = FeatureIDCodeType.ClassifiedAdCompanyNameEnabled Then Result            := 'ClassifiedAdCompanyNameEnabled'
  Else If Value = FeatureIDCodeType.SpecialitySubscription Then Result                    := 'SpecialitySubscription'
  Else If Value = FeatureIDCodeType.RegularSubscription Then Result                       := 'RegularSubscription'
  Else If Value = FeatureIDCodeType.PremiumSubscription Then Result                       := 'PremiumSubscription'
  Else If Value = FeatureIDCodeType.NonSubscription Then Result                           := 'NonSubscription'
  Else If Value = FeatureIDCodeType.IntangibleEnabled Then Result                         := 'IntangibleEnabled'
  Else If Value = FeatureIDCodeType.PayPalRequiredForStoreOwner Then Result               := 'PayPalRequiredForStoreOwner'
  Else If Value = FeatureIDCodeType.ReviseQuantityAllowed Then Result                     := 'ReviseQuantityAllowed'
  Else If Value = FeatureIDCodeType.RevisePriceAllowed Then Result                        := 'RevisePriceAllowed'
  Else If Value = FeatureIDCodeType.StoreOwnerExtendedListingDurationsEnabled  Then Result := 'StoreOwnerExtendedListingDurationsEnabled'
  Else If Value = FeatureIDCodeType.StoreOwnerExtendedListingDurations Then Result        := 'StoreOwnerExtendedListingDurations'
  Else If Value = FeatureIDCodeType.ReturnPolicyEnabled Then Result                       := 'ReturnPolicyEnabled'
  Else If Value = FeatureIDCodeType.HandlingTimeEnabled Then Result                       := 'HandlingTimeEnabled'
  Else If Value = FeatureIDCodeType.PaymentMethods Then Result                            := 'PaymentMethods'
  Else If Value = FeatureIDCodeType.MaxFlatShippingCost Then Result                       := 'MaxFlatShippingCost'
  Else If Value = FeatureIDCodeType.MaxFlatShippingCostCBTExempt Then Result              := 'MaxFlatShippingCostCBTExempt'
  Else If Value = FeatureIDCodeType.Group1MaxFlatShippingCost Then Result                 := 'Group1MaxFlatShippingCost'
  Else If Value = FeatureIDCodeType.Group2MaxFlatShippingCost Then Result                 := 'Group2MaxFlatShippingCost'
  Else If Value = FeatureIDCodeType.Group3MaxFlatShippingCost Then Result                 := 'Group3MaxFlatShippingCost'
  Else If Value = FeatureIDCodeType.VariationsEnabled Then Result                         := 'VariationsEnabled'
  Else If Value = FeatureIDCodeType.AttributeConversionEnabled Then Result                := 'AttributeConversionEnabled'
  Else If Value = FeatureIDCodeType.FreeGalleryPlusEnabled Then Result                    := 'FreeGalleryPlusEnabled'
  Else If Value = FeatureIDCodeType.FreePicturePackEnabled Then Result                    := 'FreePicturePackEnabled'
  Else If Value = FeatureIDCodeType.CompatibilityEnabled Then Result                      := 'CompatibilityEnabled'
  Else If Value = FeatureIDCodeType.MinCompatibleApplications Then Result                 := 'MinCompatibleApplications'
  Else If Value = FeatureIDCodeType.MaxCompatibleApplications Then Result                 := 'MaxCompatibleApplications'
  Else If Value = FeatureIDCodeType.ConditionEnabled Then Result                          := 'ConditionEnabled'
  Else If Value = FeatureIDCodeType.ConditionValues Then Result                           := 'ConditionValues'
  Else If Value = FeatureIDCodeType.ValueCategory Then Result                             := 'ValueCategory'
  Else If Value = FeatureIDCodeType.ProductCreationEnabled Then Result                    := 'ProductCreationEnabled'
  Else If Value = FeatureIDCodeType.MaxGranularFitmentCount Then Result                   := 'MaxGranularFitmentCount'
  Else If Value = FeatureIDCodeType.CompatibleVehicleType Then Result                     := 'CompatibleVehicleType'
  Else If Value = FeatureIDCodeType.PaymentOptionsGroup Then Result                       := 'PaymentOptionsGroup'
  Else If Value = FeatureIDCodeType.ShippingProfileCategoryGroup Then Result              := 'ShippingProfileCategoryGroup'
  Else If Value = FeatureIDCodeType.PaymentProfileCategoryGroup Then Result               := 'PaymentProfileCategoryGroup'
  Else If Value = FeatureIDCodeType.ReturnPolicyProfileCategoryGroup Then Result          := 'ReturnPolicyProfileCategoryGroup'
  Else If Value = FeatureIDCodeType.VINSupported Then Result                              := 'VINSupported'
  Else If Value = FeatureIDCodeType.VRMSupported Then Result                              := 'VRMSupported'
  Else If Value = FeatureIDCodeType.SellerProvidedTitleSupported Then Result              := 'SellerProvidedTitleSupported'
  Else If Value = FeatureIDCodeType.DepositSupported Then Result                          := 'DepositSupported'
  Else If Value = FeatureIDCodeType.GlobalShippingEnabled Then Result                     := 'GlobalShippingEnabled'
  Else If Value = FeatureIDCodeType.AdditionalCompatibilityEnabled Then Result            := 'AdditionalCompatibilityEnabled'
  Else Result                                                                             := '';
End;

Function enumToStr(Const Value: GranularityLevelCodeType): String;
Begin
       If Value =GranularityLevelCodeType.Coarse Then Result      := 'Coarse'
  Else If Value = GranularityLevelCodeType.Fine Then Result   := 'Fine'
  Else If Value = GranularityLevelCodeType.Medium  Then Result := 'Medium'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: BestOfferStatusCodeType): String;
Begin
       If Value =BestOfferStatusCodeType.Pending Then Result                       := 'Pending'
  Else If Value = BestOfferStatusCodeType.Accepted Then Result                 := 'Accepted'
  Else If Value = BestOfferStatusCodeType.Declined Then Result                 := 'Declined'
  Else If Value = BestOfferStatusCodeType.Expired Then Result                  := 'Expired'
  Else If Value = BestOfferStatusCodeType.Retracted Then Result                := 'Retracted'
  Else If Value = BestOfferStatusCodeType.AdminEnded Then Result               := 'AdminEnded'
  Else If Value = BestOfferStatusCodeType.Active Then Result                   := 'Active'
  Else If Value = BestOfferStatusCodeType.Countered Then Result                := 'Countered'
  Else If Value = BestOfferStatusCodeType.All Then Result                      := 'All'
  Else If Value = BestOfferStatusCodeType.PendingBuyerPayment Then Result      := 'PendingBuyerPayment'
  Else If Value = BestOfferStatusCodeType.PendingBuyerConfirmation  Then Result := 'PendingBuyerConfirmation'
  Else If Value = BestOfferStatusCodeType.CustomCode Then Result               := 'CustomCode'
  Else Result                                                                  := '';
End;

Function enumToStr(Const Value: ProductCreationEnabledCodeType): String;
Begin
       If Value =ProductCreationEnabledCodeType.Disabled Then Result      := 'Disabled'
  Else If Value = ProductCreationEnabledCodeType.Enabled Then Result  := 'Enabled'
  Else If Value = ProductCreationEnabledCodeType.Required  Then Result := 'Required'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: PaymentOptionsGroupEnabledCodeType): String;
Begin
       If Value =PaymentOptionsGroupEnabledCodeType.EBayPaymentProcessEnabled Then Result       := 'eBayPaymentProcessEnabled'
  Else If Value = PaymentOptionsGroupEnabledCodeType.NonStandardPaymentsEnabled  Then Result := 'NonStandardPaymentsEnabled'
  Else If Value = PaymentOptionsGroupEnabledCodeType.EBayPaymentProcessExcluded  Then Result := 'eBayPaymentProcessExcluded'
  Else Result                                                                               := '';
End;

Function enumToStr(Const Value: ProfileCategoryGroupCodeType): String;
Begin
       If Value =ProfileCategoryGroupCodeType.Inherit Then Result   := 'Inherit'
  Else If Value = ProfileCategoryGroupCodeType.None  Then Result := 'None'
  Else If Value = ProfileCategoryGroupCodeType.ALL Then Result  := 'ALL'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: CharityAffiliationTypeCodeType): String;
Begin
       If Value =CharityAffiliationTypeCodeType.Community Then Result   := 'Community'
  Else If Value = CharityAffiliationTypeCodeType.Direct  Then Result := 'Direct'
  Else If Value = CharityAffiliationTypeCodeType.Remove  Then Result := 'Remove'
  Else Result                                                       := '';
End;

Function enumToStr(Const Value: ClassifiedAdBestOfferEnabledCodeType): String;
Begin
       If Value =ClassifiedAdBestOfferEnabledCodeType.Disabled Then Result      := 'Disabled'
  Else If Value = ClassifiedAdBestOfferEnabledCodeType.Enabled Then Result  := 'Enabled'
  Else If Value = ClassifiedAdBestOfferEnabledCodeType.Required  Then Result := 'Required'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: ItemSpecificsEnabledCodeType): String;
Begin
       If Value =ItemSpecificsEnabledCodeType.Disabled Then Result     := 'Disabled'
  Else If Value = ItemSpecificsEnabledCodeType.Enabled  Then Result := 'Enabled'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: AdFormatEnabledCodeType): String;
Begin
       If Value =AdFormatEnabledCodeType.Disabled Then Result                      := 'Disabled'
  Else If Value = AdFormatEnabledCodeType.Enabled Then Result                  := 'Enabled'
  Else If Value = AdFormatEnabledCodeType.Only Then Result                     := 'Only'
  Else If Value = AdFormatEnabledCodeType.ClassifiedAdEnabled Then Result      := 'ClassifiedAdEnabled'
  Else If Value = AdFormatEnabledCodeType.ClassifiedAdOnly Then Result         := 'ClassifiedAdOnly'
  Else If Value = AdFormatEnabledCodeType.LocalMarketBestOfferOnly  Then Result := 'LocalMarketBestOfferOnly'
  Else Result                                                                  := '';
End;

Function enumToStr(Const Value: ClassifiedAdPaymentMethodEnabledCodeType): String;
Begin
       If Value =ClassifiedAdPaymentMethodEnabledCodeType.EnabledWithCheckout Then Result         := 'EnabledWithCheckout'
  Else If Value = ClassifiedAdPaymentMethodEnabledCodeType.EnabledWithoutCheckout  Then Result := 'EnabledWithoutCheckout'
  Else If Value = ClassifiedAdPaymentMethodEnabledCodeType.NotSupported Then Result           := 'NotSupported'
  Else Result                                                                                 := '';
End;

Function enumToStr(Const Value: GeographicExposureCodeType): String;
Begin
       If Value =GeographicExposureCodeType.National Then Result           := 'National'
  Else If Value = GeographicExposureCodeType.LocalOnly Then Result     := 'LocalOnly'
  Else If Value = GeographicExposureCodeType.LocalOptional  Then Result := 'LocalOptional'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: ItemCompatibilityEnabledCodeType): String;
Begin
       If Value =ItemCompatibilityEnabledCodeType.Disabled Then Result             := 'Disabled'
  Else If Value = ItemCompatibilityEnabledCodeType.ByApplication Then Result   := 'ByApplication'
  Else If Value = ItemCompatibilityEnabledCodeType.BySpecification  Then Result := 'BySpecification'
  Else Result                                                                  := '';
End;

Function enumToStr(Const Value: ConditionEnabledCodeType): String;
Begin
       If Value =ConditionEnabledCodeType.Disabled Then Result      := 'Disabled'
  Else If Value = ConditionEnabledCodeType.Enabled Then Result  := 'Enabled'
  Else If Value = ConditionEnabledCodeType.Required  Then Result := 'Required'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: INEscrowWorkflowTimelineCodeType): String;
Begin
       If Value =INEscrowWorkflowTimelineCodeType.Default_ Then Result       := 'Default_'
  Else If Value = INEscrowWorkflowTimelineCodeType.WorkflowA  Then Result := 'WorkflowA'
  Else If Value = INEscrowWorkflowTimelineCodeType.WorkflowB  Then Result := 'WorkflowB'
  Else Result                                                            := '';
End;

Function enumToStr(Const Value: AttributeConversionEnabledCodeType): String;
Begin
       If Value =AttributeConversionEnabledCodeType.NotApplicable  Then Result := 'NotApplicable'
  Else If Value = AttributeConversionEnabledCodeType.Enabled Then Result  := 'Enabled'
  Else If Value = AttributeConversionEnabledCodeType.Disabled  Then Result := 'Disabled'
  Else Result                                                             := '';
End;

Function enumToStr(Const Value: CombinedPaymentOptionCodeType): String;
Begin
       If Value =CombinedPaymentOptionCodeType.NoCombinedPayment Then Result         := 'NoCombinedPayment'
  Else If Value = CombinedPaymentOptionCodeType.DiscountSpecified Then Result    := 'DiscountSpecified'
  Else If Value = CombinedPaymentOptionCodeType.SpecifyDiscountLater  Then Result := 'SpecifyDiscountLater'
  Else Result                                                                    := '';
End;

Function enumToStr(Const Value: SocialAddressTypeCodeType): String;
Begin
       If Value =SocialAddressTypeCodeType.Facebook Then Result        := 'Facebook'
  Else If Value = SocialAddressTypeCodeType.Twitter Then Result    := 'Twitter'
  Else If Value = SocialAddressTypeCodeType.Linkedin Then Result   := 'Linkedin'
  Else If Value = SocialAddressTypeCodeType.GooglePlus  Then Result := 'GooglePlus'
  Else If Value = SocialAddressTypeCodeType.Myspace Then Result    := 'Myspace'
  Else If Value = SocialAddressTypeCodeType.Orkut Then Result      := 'Orkut'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: CharityStatusCodeType): String;
Begin
       If Value =CharityStatusCodeType.Valid Then Result              := 'Valid'
  Else If Value = CharityStatusCodeType.NoLongerValid  Then Result := 'NoLongerValid'
  Else Result                                                     := '';
End;

Function enumToStr(Const Value: PaymentStatusCodeType): String;
Begin
       If Value =PaymentStatusCodeType.NoPaymentFailure Then Result                        := 'NoPaymentFailure'
  Else If Value = PaymentStatusCodeType.BuyerECheckBounced Then Result                 := 'BuyerECheckBounced'
  Else If Value = PaymentStatusCodeType.BuyerCreditCardFailed Then Result              := 'BuyerCreditCardFailed'
  Else If Value = PaymentStatusCodeType.BuyerFailedPaymentReportedBySeller  Then Result := 'BuyerFailedPaymentReportedBySeller'
  Else If Value = PaymentStatusCodeType.PayPalPaymentInProcess Then Result             := 'PayPalPaymentInProcess'
  Else If Value = PaymentStatusCodeType.PaymentInProcess Then Result                   := 'PaymentInProcess'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: BestOfferTypeCodeType): String;
Begin
       If Value =BestOfferTypeCodeType.BuyerBestOffer Then Result          := 'BuyerBestOffer'
  Else If Value = BestOfferTypeCodeType.BuyerCounterOffer Then Result  := 'BuyerCounterOffer'
  Else If Value = BestOfferTypeCodeType.SellerCounterOffer  Then Result := 'SellerCounterOffer'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: BidGroupItemStatusCodeType): String;
Begin
       If Value =BidGroupItemStatusCodeType.CurrentBid Then Result       := 'CurrentBid'
  Else If Value = BidGroupItemStatusCodeType.Cancelled Then Result   := 'Cancelled'
  Else If Value = BidGroupItemStatusCodeType.Pending Then Result     := 'Pending'
  Else If Value = BidGroupItemStatusCodeType.Skipped Then Result     := 'Skipped'
  Else If Value = BidGroupItemStatusCodeType.Ended Then Result       := 'Ended'
  Else If Value = BidGroupItemStatusCodeType.Won Then Result         := 'Won'
  Else If Value = BidGroupItemStatusCodeType.GroupClosed  Then Result := 'GroupClosed'
  Else Result                                                        := '';
End;

Function enumToStr(Const Value: BidGroupStatusCodeType): String;
Begin
       If Value =BidGroupStatusCodeType.Open Then Result        := 'Open'
  Else If Value = BidGroupStatusCodeType.Closed  Then Result := 'Closed'
  Else Result                                               := '';
End;

Function enumToStr(Const Value: FeedbackRatingDetailCodeType): String;
Begin
       If Value =FeedbackRatingDetailCodeType.ItemAsDescribed Then Result                 := 'ItemAsDescribed'
  Else If Value = FeedbackRatingDetailCodeType.Communication Then Result              := 'Communication'
  Else If Value = FeedbackRatingDetailCodeType.ShippingTime Then Result               := 'ShippingTime'
  Else If Value = FeedbackRatingDetailCodeType.ShippingAndHandlingCharges  Then Result := 'ShippingAndHandlingCharges'
  Else Result                                                                         := '';
End;

Function enumToStr(Const Value: FeedbackSummaryPeriodCodeType): String;
Begin
       If Value =FeedbackSummaryPeriodCodeType.ThirtyDays Then Result         := 'ThirtyDays'
  Else If Value = FeedbackSummaryPeriodCodeType.FiftyTwoWeeks  Then Result := 'FiftyTwoWeeks'
  Else Result                                                             := '';
End;

Function enumToStr(Const Value: HandlingNameCodeType): String;
Begin
       If Value =HandlingNameCodeType.EachAdditionalAmount Then Result          := 'EachAdditionalAmount'
  Else If Value = HandlingNameCodeType.EachAdditionalAmountOff Then Result  := 'EachAdditionalAmountOff'
  Else If Value = HandlingNameCodeType.EachAdditionalPercentOff  Then Result := 'EachAdditionalPercentOff'
  Else If Value = HandlingNameCodeType.IndividualHandlingFee Then Result    := 'IndividualHandlingFee'
  Else If Value = HandlingNameCodeType.CombinedHandlingFee Then Result      := 'CombinedHandlingFee'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: DiscountNameCodeType): String;
Begin
       If Value =DiscountNameCodeType.EachAdditionalAmount Then Result             := 'EachAdditionalAmount'
  Else If Value = DiscountNameCodeType.EachAdditionalAmountOff Then Result     := 'EachAdditionalAmountOff'
  Else If Value = DiscountNameCodeType.EachAdditionalPercentOff Then Result    := 'EachAdditionalPercentOff'
  Else If Value = DiscountNameCodeType.IndividualItemWeight Then Result        := 'IndividualItemWeight'
  Else If Value = DiscountNameCodeType.CombinedItemWeight Then Result          := 'CombinedItemWeight'
  Else If Value = DiscountNameCodeType.WeightOff Then Result                   := 'WeightOff'
  Else If Value = DiscountNameCodeType.ShippingCostXForAmountY Then Result     := 'ShippingCostXForAmountY'
  Else If Value = DiscountNameCodeType.ShippingCostXForItemCountN Then Result  := 'ShippingCostXForItemCountN'
  Else If Value = DiscountNameCodeType.MaximumShippingCostPerOrder  Then Result := 'MaximumShippingCostPerOrder'
  Else Result                                                                  := '';
End;

Function enumToStr(Const Value: BuyerSatisfactionStatusCodeType): String;
Begin
       If Value =BuyerSatisfactionStatusCodeType.Excellent Then Result         := 'Excellent'
  Else If Value = BuyerSatisfactionStatusCodeType.Good Then Result         := 'Good'
  Else If Value = BuyerSatisfactionStatusCodeType.NeedsWork Then Result    := 'NeedsWork'
  Else If Value = BuyerSatisfactionStatusCodeType.Poor Then Result         := 'Poor'
  Else If Value = BuyerSatisfactionStatusCodeType.VeryPoor Then Result     := 'VeryPoor'
  Else If Value = BuyerSatisfactionStatusCodeType.Unacceptable  Then Result := 'Unacceptable'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: ShippingPackageCodeType): String;
Begin
       If Value =ShippingPackageCodeType.None Then Result                              := 'None'
  Else If Value = ShippingPackageCodeType.Letter Then Result                       := 'Letter'
  Else If Value = ShippingPackageCodeType.LargeEnvelope Then Result                := 'LargeEnvelope'
  Else If Value = ShippingPackageCodeType.USPSLargePack Then Result                := 'USPSLargePack'
  Else If Value = ShippingPackageCodeType.VeryLargePack Then Result                := 'VeryLargePack'
  Else If Value = ShippingPackageCodeType.ExtraLargePack Then Result               := 'ExtraLargePack'
  Else If Value = ShippingPackageCodeType.UPSLetter Then Result                    := 'UPSLetter'
  Else If Value = ShippingPackageCodeType.USPSFlatRateEnvelope Then Result         := 'USPSFlatRateEnvelope'
  Else If Value = ShippingPackageCodeType.PackageThickEnvelope Then Result         := 'PackageThickEnvelope'
  Else If Value = ShippingPackageCodeType.Roll Then Result                         := 'Roll'
  Else If Value = ShippingPackageCodeType.Europallet Then Result                   := 'Europallet'
  Else If Value = ShippingPackageCodeType.OneWayPallet Then Result                 := 'OneWayPallet'
  Else If Value = ShippingPackageCodeType.BulkyGoods Then Result                   := 'BulkyGoods'
  Else If Value = ShippingPackageCodeType.Furniture Then Result                    := 'Furniture'
  Else If Value = ShippingPackageCodeType.Cars Then Result                         := 'Cars'
  Else If Value = ShippingPackageCodeType.Motorbikes Then Result                   := 'Motorbikes'
  Else If Value = ShippingPackageCodeType.Caravan Then Result                      := 'Caravan'
  Else If Value = ShippingPackageCodeType.IndustryVehicles Then Result             := 'IndustryVehicles'
  Else If Value = ShippingPackageCodeType.ParcelOrPaddedEnvelope Then Result       := 'ParcelOrPaddedEnvelope'
  Else If Value = ShippingPackageCodeType.SmallCanadaPostBox Then Result           := 'SmallCanadaPostBox'
  Else If Value = ShippingPackageCodeType.MediumCanadaPostBox Then Result          := 'MediumCanadaPostBox'
  Else If Value = ShippingPackageCodeType.LargeCanadaPostBox Then Result           := 'LargeCanadaPostBox'
  Else If Value = ShippingPackageCodeType.SmallCanadaPostBubbleMailer Then Result  := 'SmallCanadaPostBubbleMailer'
  Else If Value = ShippingPackageCodeType.MediumCanadaPostBubbleMailer  Then Result := 'MediumCanadaPostBubbleMailer'
  Else If Value = ShippingPackageCodeType.LargeCanadaPostBubbleMailer Then Result  := 'LargeCanadaPostBubbleMailer'
  Else If Value = ShippingPackageCodeType.PaddedBags Then Result                   := 'PaddedBags'
  Else If Value = ShippingPackageCodeType.ToughBags Then Result                    := 'ToughBags'
  Else If Value = ShippingPackageCodeType.ExpandableToughBags Then Result          := 'ExpandableToughBags'
  Else If Value = ShippingPackageCodeType.MailingBoxes Then Result                 := 'MailingBoxes'
  Else If Value = ShippingPackageCodeType.Winepak Then Result                      := 'Winepak'
  Else If Value = ShippingPackageCodeType.CustomCode Then Result                   := 'CustomCode'
  Else Result                                                                      := '';
End;

(*Function enumToStr(Const Value: ProductStateCodeType): String;
Begin
       If Value =ProductStateCodeType.Update Then Result               := 'Update'
  Else If Value = ProductStateCodeType.UpdateMajor Then Result     := 'UpdateMajor'
  Else If Value = ProductStateCodeType.UpdateNoDetails  Then Result := 'UpdateNoDetails'
  Else If Value = ProductStateCodeType.Merge Then Result           := 'Merge'
  Else If Value = ProductStateCodeType.Delete Then Result          := 'Delete'
  Else Result                                                      := '';
End;*)

Function enumToStr(Const Value: CalculatedShippingChargeOptionCodeType): String;
Begin
       If Value =CalculatedShippingChargeOptionCodeType.ChargeEachItem Then Result         := 'ChargeEachItem'
  Else If Value = CalculatedShippingChargeOptionCodeType.ChargeEntireOrder  Then Result := 'ChargeEntireOrder'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: CalculatedShippingRateOptionCodeType): String;
Begin
       If Value =CalculatedShippingRateOptionCodeType.CombinedItemWeight Then Result        := 'CombinedItemWeight'
  Else If Value = CalculatedShippingRateOptionCodeType.IndividualItemWeight  Then Result := 'IndividualItemWeight'
  Else Result                                                                           := '';
End;

Function enumToStr(Const Value: BuyerProtectionSourceCodeType): String;
Begin
       If Value =BuyerProtectionSourceCodeType.EBay Then Result        := 'eBay'
  Else If Value = BuyerProtectionSourceCodeType.PayPal  Then Result := 'PayPal'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: BuyerProtectionCodeType): String;
Begin
       If Value =BuyerProtectionCodeType.ItemIneligible Then Result            := 'ItemIneligible'
  Else If Value = BuyerProtectionCodeType.ItemEligible Then Result         := 'ItemEligible'
  Else If Value = BuyerProtectionCodeType.ItemMarkedIneligible  Then Result := 'ItemMarkedIneligible'
  Else If Value = BuyerProtectionCodeType.ItemMarkedEligible Then Result   := 'ItemMarkedEligible'
  Else If Value = BuyerProtectionCodeType.NoCoverage Then Result           := 'NoCoverage'
  Else Result                                                              := '';
End;

Function enumToStr(Const Value: PricingTreatmentCodeType): String;
Begin
       If Value =PricingTreatmentCodeType.STP Then Result       := 'STP'
  Else If Value = PricingTreatmentCodeType.MAP Then Result  := 'MAP'
  Else If Value = PricingTreatmentCodeType.None  Then Result := 'None'
  Else If Value = PricingTreatmentCodeType.MFO Then Result  := 'MFO'
  Else Result                                               := '';
End;

Function enumToStr(Const Value: DisputeRecordTypeCodeType): String;
Begin
       If Value =DisputeRecordTypeCodeType.UnpaidItem Then Result           := 'UnpaidItem'
  Else If Value = DisputeRecordTypeCodeType.ItemNotReceived  Then Result := 'ItemNotReceived'
  Else If Value = DisputeRecordTypeCodeType.HalfDispute Then Result     := 'HalfDispute'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: DisputeStateCodeType): String;
Begin
       If Value =DisputeStateCodeType.Locked Then Result                                         := 'Locked'
  Else If Value = DisputeStateCodeType.Closed Then Result                                    := 'Closed'
  Else If Value = DisputeStateCodeType.BuyerFirstResponsePayOption Then Result               := 'BuyerFirstResponsePayOption'
  Else If Value = DisputeStateCodeType.BuyerFirstResponseNoPayOption Then Result             := 'BuyerFirstResponseNoPayOption'
  Else If Value = DisputeStateCodeType.BuyerFirstResponsePayOptionLateResponse Then Result   := 'BuyerFirstResponsePayOptionLateResponse'
  Else If Value = DisputeStateCodeType.BuyerFirstResponseNoPayOptionLateResponse  Then Result := 'BuyerFirstResponseNoPayOptionLateResponse'
  Else If Value = DisputeStateCodeType.MutualCommunicationPayOption Then Result              := 'MutualCommunicationPayOption'
  Else If Value = DisputeStateCodeType.MutualCommunicationNoPayOption Then Result            := 'MutualCommunicationNoPayOption'
  Else If Value = DisputeStateCodeType.PendingResolve Then Result                            := 'PendingResolve'
  Else If Value = DisputeStateCodeType.MutualWithdrawalAgreement Then Result                 := 'MutualWithdrawalAgreement'
  Else If Value = DisputeStateCodeType.MutualWithdrawalAgreementLate Then Result             := 'MutualWithdrawalAgreementLate'
  Else If Value = DisputeStateCodeType.NotReceivedNoSellerResponse Then Result               := 'NotReceivedNoSellerResponse'
  Else If Value = DisputeStateCodeType.NotAsDescribedNoSellerResponse Then Result            := 'NotAsDescribedNoSellerResponse'
  Else If Value = DisputeStateCodeType.NotReceivedMutualCommunication Then Result            := 'NotReceivedMutualCommunication'
  Else If Value = DisputeStateCodeType.NotAsDescribedMutualCommunication Then Result         := 'NotAsDescribedMutualCommunication'
  Else If Value = DisputeStateCodeType.MutualAgreementOrBuyerReturningItem Then Result       := 'MutualAgreementOrBuyerReturningItem'
  Else If Value = DisputeStateCodeType.ClaimOpened Then Result                               := 'ClaimOpened'
  Else If Value = DisputeStateCodeType.NoDocumentation Then Result                           := 'NoDocumentation'
  Else If Value = DisputeStateCodeType.ClaimClosed Then Result                               := 'ClaimClosed'
  Else If Value = DisputeStateCodeType.ClaimDenied Then Result                               := 'ClaimDenied'
  Else If Value = DisputeStateCodeType.ClaimPending Then Result                              := 'ClaimPending'
  Else If Value = DisputeStateCodeType.ClaimPaymentPending Then Result                       := 'ClaimPaymentPending'
  Else If Value = DisputeStateCodeType.ClaimPaid Then Result                                 := 'ClaimPaid'
  Else If Value = DisputeStateCodeType.ClaimResolved Then Result                             := 'ClaimResolved'
  Else If Value = DisputeStateCodeType.ClaimSubmitted Then Result                            := 'ClaimSubmitted'
  Else If Value = DisputeStateCodeType.UnpaidItemOpen Then Result                            := 'UnpaidItemOpen'
  Else If Value = DisputeStateCodeType.UPIAssistanceDisabledByeBay Then Result               := 'UPIAssistanceDisabledByeBay'
  Else If Value = DisputeStateCodeType.UPIAssistanceDisabledBySeller Then Result             := 'UPIAssistanceDisabledBySeller'
  Else If Value = DisputeStateCodeType.CustomCode Then Result                                := 'CustomCode'
  Else Result                                                                                := '';
End;

Function enumToStr(Const Value: DescriptionTemplateCodeType): String;
Begin
       If Value =DescriptionTemplateCodeType.Layout Then Result     := 'Layout'
  Else If Value = DescriptionTemplateCodeType.Theme  Then Result := 'Theme'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: MinimumAdvertisedPriceExposureCodeType): String;
Begin
       If Value =MinimumAdvertisedPriceExposureCodeType.PreCheckout Then Result         := 'PreCheckout'
  Else If Value = MinimumAdvertisedPriceExposureCodeType.DuringCheckout  Then Result := 'DuringCheckout'
  Else If Value = MinimumAdvertisedPriceExposureCodeType.None Then Result           := 'None'
  Else Result                                                                       := '';
End;

Function enumToStr(Const Value: DisputeStatusCodeType): String;
Begin
       If Value =DisputeStatusCodeType.Closed Then Result                                  := 'Closed'
  Else If Value = DisputeStatusCodeType.WaitingForSellerResponse Then Result           := 'WaitingForSellerResponse'
  Else If Value = DisputeStatusCodeType.WaitingForBuyerResponse Then Result            := 'WaitingForBuyerResponse'
  Else If Value = DisputeStatusCodeType.ClosedFVFCreditStrike Then Result              := 'ClosedFVFCreditStrike'
  Else If Value = DisputeStatusCodeType.ClosedNoFVFCreditStrike Then Result            := 'ClosedNoFVFCreditStrike'
  Else If Value = DisputeStatusCodeType.ClosedFVFCreditNoStrike Then Result            := 'ClosedFVFCreditNoStrike'
  Else If Value = DisputeStatusCodeType.ClosedNoFVFCreditNoStrike Then Result          := 'ClosedNoFVFCreditNoStrike'
  Else If Value = DisputeStatusCodeType.StrikeAppealedAfterClosing Then Result         := 'StrikeAppealedAfterClosing'
  Else If Value = DisputeStatusCodeType.FVFCreditReversedAfterClosing Then Result      := 'FVFCreditReversedAfterClosing'
  Else If Value = DisputeStatusCodeType.StrikeAppealedAndFVFCreditReversed  Then Result := 'StrikeAppealedAndFVFCreditReversed'
  Else If Value = DisputeStatusCodeType.ClaimOpened Then Result                        := 'ClaimOpened'
  Else If Value = DisputeStatusCodeType.NoDocumentation Then Result                    := 'NoDocumentation'
  Else If Value = DisputeStatusCodeType.ClaimClosed Then Result                        := 'ClaimClosed'
  Else If Value = DisputeStatusCodeType.ClaimDenied Then Result                        := 'ClaimDenied'
  Else If Value = DisputeStatusCodeType.ClaimInProcess Then Result                     := 'ClaimInProcess'
  Else If Value = DisputeStatusCodeType.ClaimApproved Then Result                      := 'ClaimApproved'
  Else If Value = DisputeStatusCodeType.ClaimPaid Then Result                          := 'ClaimPaid'
  Else If Value = DisputeStatusCodeType.ClaimResolved Then Result                      := 'ClaimResolved'
  Else If Value = DisputeStatusCodeType.ClaimSubmitted Then Result                     := 'ClaimSubmitted'
  Else If Value = DisputeStatusCodeType.UnpaidItemOpened Then Result                   := 'UnpaidItemOpened'
  Else If Value = DisputeStatusCodeType.CustomCode Then Result                         := 'CustomCode'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: EndOfAuctionLogoTypeCodeType): String;
Begin
       If Value =EndOfAuctionLogoTypeCodeType.WinningBidderNotice  Then Result := 'WinningBidderNotice'
  Else If Value = EndOfAuctionLogoTypeCodeType.Store Then Result          := 'Store'
  Else If Value = EndOfAuctionLogoTypeCodeType.Customized Then Result     := 'Customized'
  Else If Value = EndOfAuctionLogoTypeCodeType.CustomCode Then Result     := 'CustomCode'
  Else Result                                                             := '';
End;

Function enumToStr(Const Value: DisputeCreditEligibilityCodeType): String;
Begin
       If Value =DisputeCreditEligibilityCodeType.InEligible Then Result    := 'InEligible'
  Else If Value = DisputeCreditEligibilityCodeType.Eligible  Then Result := 'Eligible'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: DaysCodeType): String;
Begin
       If Value =DaysCodeType.None Then Result          := 'None'
  Else If Value = DaysCodeType.EveryDay  Then Result := 'EveryDay'
  Else If Value = DaysCodeType.Weekdays  Then Result := 'Weekdays'
  Else If Value = DaysCodeType.Weekends  Then Result := 'Weekends'
  Else Result                                       := '';
End;

Function enumToStr(Const Value: PromotionSchemeCodeType): String;
Begin
       If Value =PromotionSchemeCodeType.ItemToItem Then Result                 := 'ItemToItem'
  Else If Value = PromotionSchemeCodeType.ItemToStoreCat Then Result        := 'ItemToStoreCat'
  Else If Value = PromotionSchemeCodeType.StoreToStoreCat Then Result       := 'StoreToStoreCat'
  Else If Value = PromotionSchemeCodeType.ItemToDefaultRule Then Result     := 'ItemToDefaultRule'
  Else If Value = PromotionSchemeCodeType.DefaultRule Then Result           := 'DefaultRule'
  Else If Value = PromotionSchemeCodeType.CategoryProximity Then Result     := 'CategoryProximity'
  Else If Value = PromotionSchemeCodeType.RelatedCategoryRule Then Result   := 'RelatedCategoryRule'
  Else If Value = PromotionSchemeCodeType.DefaultUpSellLogic Then Result    := 'DefaultUpSellLogic'
  Else If Value = PromotionSchemeCodeType.DefaultCrossSellLogic  Then Result := 'DefaultCrossSellLogic'
  Else Result                                                               := '';
End;

Function enumToStr(Const Value: ItemFormatSortFilterCodeType): String;
Begin
       If Value =ItemFormatSortFilterCodeType.ShowAnyItems Then Result               := 'ShowAnyItems'
  Else If Value = ItemFormatSortFilterCodeType.ShowItemsWithBINFirst  Then Result := 'ShowItemsWithBINFirst'
  Else If Value = ItemFormatSortFilterCodeType.ShowOnlyItemsWithBIN Then Result  := 'ShowOnlyItemsWithBIN'
  Else If Value = ItemFormatSortFilterCodeType.ShowOnlyStoreItems Then Result    := 'ShowOnlyStoreItems'
  Else Result                                                                    := '';
End;

Function enumToStr(Const Value: GallerySortFilterCodeType): String;
Begin
       If Value =GallerySortFilterCodeType.ShowAnyItems Then Result                         := 'ShowAnyItems'
  Else If Value = GallerySortFilterCodeType.ShowItemsWithGalleryImagesFirst  Then Result := 'ShowItemsWithGalleryImagesFirst'
  Else If Value = GallerySortFilterCodeType.ShowOnlyItemsWithGalleryImages Then Result  := 'ShowOnlyItemsWithGalleryImages'
  Else Result                                                                           := '';
End;

Function enumToStr(Const Value: ItemSortFilterCodeType): String;
Begin
       If Value =ItemSortFilterCodeType.EndingLast Then Result            := 'EndingLast'
  Else If Value = ItemSortFilterCodeType.EndingSoonest Then Result    := 'EndingSoonest'
  Else If Value = ItemSortFilterCodeType.HighestPrice Then Result     := 'HighestPrice'
  Else If Value = ItemSortFilterCodeType.LowestPrice Then Result      := 'LowestPrice'
  Else If Value = ItemSortFilterCodeType.NewlyListed Then Result      := 'NewlyListed'
  Else If Value = ItemSortFilterCodeType.RandomlySelected  Then Result := 'RandomlySelected'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: PaymentTransactionStatusCodeType): String;
Begin
       If Value =PaymentTransactionStatusCodeType.Failed Then Result         := 'Failed'
  Else If Value = PaymentTransactionStatusCodeType.Succeeded  Then Result := 'Succeeded'
  Else If Value = PaymentTransactionStatusCodeType.Pending Then Result   := 'Pending'
  Else Result                                                            := '';
End;

(*Function enumToStr(Const Value: ExternalProductCodeType): String;
Begin
       If Value =ExternalProductCodeType.ISBN Then Result           := 'ISBN'
  Else If Value = ExternalProductCodeType.UPC Then Result       := 'UPC'
  Else If Value = ExternalProductCodeType.ProductID  Then Result := 'ProductID'
  Else If Value = ExternalProductCodeType.EAN Then Result       := 'EAN'
  Else If Value = ExternalProductCodeType.Keywords Then Result  := 'Keywords'
  Else If Value = ExternalProductCodeType.MPN Then Result       := 'MPN'
  Else Result                                                   := '';
End;*)

Function enumToStr(Const Value: MyMessagesFolderOperationCodeType): String;
Begin
       If Value =MyMessagesFolderOperationCodeType.Display Then Result     := 'Display'
  Else If Value = MyMessagesFolderOperationCodeType.Rename  Then Result := 'Rename'
  Else If Value = MyMessagesFolderOperationCodeType.Remove  Then Result := 'Remove'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: FeedbackResponseCodeType): String;
Begin
       If Value =FeedbackResponseCodeType.Reply Then Result         := 'Reply'
  Else If Value = FeedbackResponseCodeType.FollowUp  Then Result := 'FollowUp'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: BuyerPaymentMethodCodeType): String;
Begin
       If Value =BuyerPaymentMethodCodeType.None Then Result                              := 'None'
  Else If Value = BuyerPaymentMethodCodeType.MOCC Then Result                         := 'MOCC'
  Else If Value = BuyerPaymentMethodCodeType.AmEx Then Result                         := 'AmEx'
  Else If Value = BuyerPaymentMethodCodeType.PaymentSeeDescription Then Result        := 'PaymentSeeDescription'
  Else If Value = BuyerPaymentMethodCodeType.CCAccepted Then Result                   := 'CCAccepted'
  Else If Value = BuyerPaymentMethodCodeType.PersonalCheck Then Result                := 'PersonalCheck'
  Else If Value = BuyerPaymentMethodCodeType.COD Then Result                          := 'COD'
  Else If Value = BuyerPaymentMethodCodeType.VisaMC Then Result                       := 'VisaMC'
  Else If Value = BuyerPaymentMethodCodeType.PaisaPayAccepted Then Result             := 'PaisaPayAccepted'
  Else If Value = BuyerPaymentMethodCodeType.Other Then Result                        := 'Other'
  Else If Value = BuyerPaymentMethodCodeType.PayPal Then Result                       := 'PayPal'
  Else If Value = BuyerPaymentMethodCodeType.Discover Then Result                     := 'Discover'
  Else If Value = BuyerPaymentMethodCodeType.CashOnPickup Then Result                 := 'CashOnPickup'
  Else If Value = BuyerPaymentMethodCodeType.MoneyXferAccepted Then Result            := 'MoneyXferAccepted'
  Else If Value = BuyerPaymentMethodCodeType.MoneyXferAcceptedInCheckout Then Result  := 'MoneyXferAcceptedInCheckout'
  Else If Value = BuyerPaymentMethodCodeType.OtherOnlinePayments Then Result          := 'OtherOnlinePayments'
  Else If Value = BuyerPaymentMethodCodeType.Escrow Then Result                       := 'Escrow'
  Else If Value = BuyerPaymentMethodCodeType.PrePayDelivery Then Result               := 'PrePayDelivery'
  Else If Value = BuyerPaymentMethodCodeType.CODPrePayDelivery Then Result            := 'CODPrePayDelivery'
  Else If Value = BuyerPaymentMethodCodeType.PostalTransfer Then Result               := 'PostalTransfer'
  Else If Value = BuyerPaymentMethodCodeType.CustomCode Then Result                   := 'CustomCode'
  Else If Value = BuyerPaymentMethodCodeType.LoanCheck Then Result                    := 'LoanCheck'
  Else If Value = BuyerPaymentMethodCodeType.CashInPerson Then Result                 := 'CashInPerson'
  Else If Value = BuyerPaymentMethodCodeType.ELV Then Result                          := 'ELV'
  Else If Value = BuyerPaymentMethodCodeType.PaisaPayEscrow Then Result               := 'PaisaPayEscrow'
  Else If Value = BuyerPaymentMethodCodeType.PaisaPayEscrowEMI Then Result            := 'PaisaPayEscrowEMI'
  Else If Value = BuyerPaymentMethodCodeType.IntegratedMerchantCreditCard  Then Result := 'IntegratedMerchantCreditCard'
  Else If Value = BuyerPaymentMethodCodeType.Moneybookers Then Result                 := 'Moneybookers'
  Else If Value = BuyerPaymentMethodCodeType.Paymate Then Result                      := 'Paymate'
  Else If Value = BuyerPaymentMethodCodeType.ProPay Then Result                       := 'ProPay'
  Else If Value = BuyerPaymentMethodCodeType.PayOnPickup Then Result                  := 'PayOnPickup'
  Else If Value = BuyerPaymentMethodCodeType.Diners Then Result                       := 'Diners'
  Else If Value = BuyerPaymentMethodCodeType.StandardPayment Then Result              := 'StandardPayment'
  Else Result                                                                         := '';
End;

Function enumToStr(Const Value: InsuranceSelectedCodeType): String;
Begin
       If Value =InsuranceSelectedCodeType.NotOffered Then Result                      := 'NotOffered'
  Else If Value = InsuranceSelectedCodeType.OfferedNotSelected Then Result         := 'OfferedNotSelected'
  Else If Value = InsuranceSelectedCodeType.OfferedSelected Then Result            := 'OfferedSelected'
  Else If Value = InsuranceSelectedCodeType.Required Then Result                   := 'Required'
  Else If Value = InsuranceSelectedCodeType.IncludedInShippingHandling  Then Result := 'IncludedInShippingHandling'
  Else Result                                                                      := '';
End;

Function enumToStr(Const Value: CompleteStatusCodeType): String;
Begin
       If Value =CompleteStatusCodeType.Incomplete Then Result    := 'Incomplete'
  Else If Value = CompleteStatusCodeType.Complete  Then Result := 'Complete'
  Else If Value = CompleteStatusCodeType.Pending Then Result  := 'Pending'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: CheckoutMethodCodeType): String;
Begin
       If Value =CheckoutMethodCodeType.Other Then Result                   := 'Other'
  Else If Value = CheckoutMethodCodeType.ThirdPartyCheckout  Then Result := 'ThirdPartyCheckout'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: InsuranceOptionCodeType): String;
Begin
       If Value =InsuranceOptionCodeType.Optional Then Result                        := 'Optional'
  Else If Value = InsuranceOptionCodeType.Required Then Result                   := 'Required'
  Else If Value = InsuranceOptionCodeType.NotOffered Then Result                 := 'NotOffered'
  Else If Value = InsuranceOptionCodeType.IncludedInShippingHandling  Then Result := 'IncludedInShippingHandling'
  Else If Value = InsuranceOptionCodeType.NotOfferedOnSite Then Result           := 'NotOfferedOnSite'
  Else Result                                                                    := '';
End;

(*Function enumToStr(Const Value: PictureManagerActionCodeType): String;
Begin
       If Value =PictureManagerActionCodeType.Add Then Result         := 'Add'
  Else If Value = PictureManagerActionCodeType.Delete  Then Result := 'Delete'
  Else If Value = PictureManagerActionCodeType.Rename  Then Result := 'Rename'
  Else If Value = PictureManagerActionCodeType.Move Then Result   := 'Move'
  Else If Value = PictureManagerActionCodeType.Change  Then Result := 'Change'
  Else Result                                                     := '';
End;*)

Function enumToStr(Const Value: DisputeResolutionReasonCodeType): String;
Begin
       If Value =DisputeResolutionReasonCodeType.Unresolved Then Result                    := 'Unresolved'
  Else If Value = DisputeResolutionReasonCodeType.ProofOfPayment Then Result           := 'ProofOfPayment'
  Else If Value = DisputeResolutionReasonCodeType.ComputerTechnicalProblem  Then Result := 'ComputerTechnicalProblem'
  Else If Value = DisputeResolutionReasonCodeType.NoContact Then Result                := 'NoContact'
  Else If Value = DisputeResolutionReasonCodeType.FamilyEmergency Then Result          := 'FamilyEmergency'
  Else If Value = DisputeResolutionReasonCodeType.ProofGivenInFeedback Then Result     := 'ProofGivenInFeedback'
  Else If Value = DisputeResolutionReasonCodeType.FirstInfraction Then Result          := 'FirstInfraction'
  Else If Value = DisputeResolutionReasonCodeType.CameToAgreement Then Result          := 'CameToAgreement'
  Else If Value = DisputeResolutionReasonCodeType.ItemReturned Then Result             := 'ItemReturned'
  Else If Value = DisputeResolutionReasonCodeType.BuyerPaidAuctionFees Then Result     := 'BuyerPaidAuctionFees'
  Else If Value = DisputeResolutionReasonCodeType.SellerReceivedPayment Then Result    := 'SellerReceivedPayment'
  Else If Value = DisputeResolutionReasonCodeType.OtherResolution Then Result          := 'OtherResolution'
  Else If Value = DisputeResolutionReasonCodeType.ClaimPaid Then Result                := 'ClaimPaid'
  Else If Value = DisputeResolutionReasonCodeType.CustomCode Then Result               := 'CustomCode'
  Else Result                                                                          := '';
End;

Function enumToStr(Const Value: DetailNameCodeType): String;
Begin
       If Value =DetailNameCodeType.CountryDetails Then Result                      := 'CountryDetails'
  Else If Value = DetailNameCodeType.CurrencyDetails Then Result                := 'CurrencyDetails'
  Else If Value = DetailNameCodeType.PaymentOptionDetails Then Result           := 'PaymentOptionDetails'
  Else If Value = DetailNameCodeType.RegionDetails Then Result                  := 'RegionDetails'
  Else If Value = DetailNameCodeType.ShippingLocationDetails Then Result        := 'ShippingLocationDetails'
  Else If Value = DetailNameCodeType.ShippingServiceDetails Then Result         := 'ShippingServiceDetails'
  Else If Value = DetailNameCodeType.SiteDetails Then Result                    := 'SiteDetails'
  Else If Value = DetailNameCodeType.TaxJurisdiction Then Result                := 'TaxJurisdiction'
  Else If Value = DetailNameCodeType.URLDetails Then Result                     := 'URLDetails'
  Else If Value = DetailNameCodeType.TimeZoneDetails Then Result                := 'TimeZoneDetails'
  Else If Value = DetailNameCodeType.RegionOfOriginDetails Then Result          := 'RegionOfOriginDetails'
  Else If Value = DetailNameCodeType.DispatchTimeMaxDetails Then Result         := 'DispatchTimeMaxDetails'
  Else If Value = DetailNameCodeType.ItemSpecificDetails Then Result            := 'ItemSpecificDetails'
  Else If Value = DetailNameCodeType.UnitOfMeasurementDetails Then Result       := 'UnitOfMeasurementDetails'
  Else If Value = DetailNameCodeType.ShippingPackageDetails Then Result         := 'ShippingPackageDetails'
  Else If Value = DetailNameCodeType.CustomCode Then Result                     := 'CustomCode'
  Else If Value = DetailNameCodeType.ShippingCarrierDetails Then Result         := 'ShippingCarrierDetails'
  Else If Value = DetailNameCodeType.ListingStartPriceDetails Then Result       := 'ListingStartPriceDetails'
  Else If Value = DetailNameCodeType.ReturnPolicyDetails Then Result            := 'ReturnPolicyDetails'
  Else If Value = DetailNameCodeType.BuyerRequirementDetails Then Result        := 'BuyerRequirementDetails'
  Else If Value = DetailNameCodeType.ListingFeatureDetails Then Result          := 'ListingFeatureDetails'
  Else If Value = DetailNameCodeType.VariationDetails Then Result               := 'VariationDetails'
  Else If Value = DetailNameCodeType.ExcludeShippingLocationDetails  Then Result := 'ExcludeShippingLocationDetails'
  Else If Value = DetailNameCodeType.RecoupmentPolicyDetails Then Result        := 'RecoupmentPolicyDetails'
  Else If Value = DetailNameCodeType.ShippingCategoryDetails Then Result        := 'ShippingCategoryDetails'
  Else Result                                                                   := '';
End;

Function enumToStr(Const Value: BestOfferActionCodeType): String;
Begin
       If Value =BestOfferActionCodeType.Accept Then Result       := 'Accept'
  Else If Value = BestOfferActionCodeType.Decline  Then Result := 'Decline'
  Else If Value = BestOfferActionCodeType.Counter  Then Result := 'Counter'
  Else Result                                                 := '';
End;

(*Function enumToStr(Const Value: RefundReasonCodeType): String;
Begin
       If Value =RefundReasonCodeType.CannotShipProduct Then Result     := 'CannotShipProduct'
  Else If Value = RefundReasonCodeType.WrongItemShipped  Then Result := 'WrongItemShipped'
  Else If Value = RefundReasonCodeType.ItemBadQuality Then Result   := 'ItemBadQuality'
  Else If Value = RefundReasonCodeType.ItemDamaged Then Result      := 'ItemDamaged'
  Else If Value = RefundReasonCodeType.BuyerRemorse Then Result     := 'BuyerRemorse'
  Else If Value = RefundReasonCodeType.Other Then Result            := 'Other'
  Else Result                                                       := '';
End;*)

(*Function enumToStr(Const Value: RefundTypeCodeType): String;
Begin
       If Value =RefundTypeCodeType.Full Then Result                  := 'Full'
  Else If Value = RefundTypeCodeType.FullPlusShipping  Then Result := 'FullPlusShipping'
  Else If Value = RefundTypeCodeType.CustomOrPartial Then Result  := 'CustomOrPartial'
  Else Result                                                     := '';
End;*)

Function enumToStr(Const Value: DisputeMessageSourceCodeType): String;
Begin
       If Value =DisputeMessageSourceCodeType.Buyer Then Result       := 'Buyer'
  Else If Value = DisputeMessageSourceCodeType.Seller  Then Result := 'Seller'
  Else If Value = DisputeMessageSourceCodeType.EBay Then Result   := 'eBay'
  Else Result                                                     := '';
End;

Function enumToStr(Const Value: SeverityCodeType): String;
Begin
       If Value =SeverityCodeType.Warning Then Result    := 'Warning'
  Else If Value = SeverityCodeType.Error  Then Result := 'Error'
  Else Result                                        := '';
End;

Function enumToStr(Const Value: ErrorClassificationCodeType): String;
Begin
       If Value =ErrorClassificationCodeType.RequestError Then Result     := 'RequestError'
  Else If Value = ErrorClassificationCodeType.SystemError  Then Result := 'SystemError'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: DisputeResolutionRecordTypeCodeType): String;
Begin
       If Value =DisputeResolutionRecordTypeCodeType.StrikeBuyer Then Result                        := 'StrikeBuyer'
  Else If Value = DisputeResolutionRecordTypeCodeType.SuspendBuyer Then Result                  := 'SuspendBuyer'
  Else If Value = DisputeResolutionRecordTypeCodeType.RestrictBuyer Then Result                 := 'RestrictBuyer'
  Else If Value = DisputeResolutionRecordTypeCodeType.FVFCredit Then Result                     := 'FVFCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.InsertionFeeCredit Then Result            := 'InsertionFeeCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.AppealBuyerStrike Then Result             := 'AppealBuyerStrike'
  Else If Value = DisputeResolutionRecordTypeCodeType.UnsuspendBuyer Then Result                := 'UnsuspendBuyer'
  Else If Value = DisputeResolutionRecordTypeCodeType.UnrestrictBuyer Then Result               := 'UnrestrictBuyer'
  Else If Value = DisputeResolutionRecordTypeCodeType.ReverseFVFCredit Then Result              := 'ReverseFVFCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.ReverseInsertionFeeCredit Then Result     := 'ReverseInsertionFeeCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.GenerateCSTicketForSuspend Then Result    := 'GenerateCSTicketForSuspend'
  Else If Value = DisputeResolutionRecordTypeCodeType.FVFCreditNotGranted Then Result           := 'FVFCreditNotGranted'
  Else If Value = DisputeResolutionRecordTypeCodeType.ItemNotReceivedClaimFiled Then Result     := 'ItemNotReceivedClaimFiled'
  Else If Value = DisputeResolutionRecordTypeCodeType.UnpaidItemRelisted Then Result            := 'UnpaidItemRelisted'
  Else If Value = DisputeResolutionRecordTypeCodeType.UnpaidItemRevised Then Result             := 'UnpaidItemRevised'
  Else If Value = DisputeResolutionRecordTypeCodeType.FVFOnShippingCredit Then Result           := 'FVFOnShippingCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.FVFOnShippingCreditNotGranted  Then Result := 'FVFOnShippingCreditNotGranted'
  Else If Value = DisputeResolutionRecordTypeCodeType.ReverseFVFOnShippingCredit Then Result    := 'ReverseFVFOnShippingCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.FeatureFeeCredit Then Result              := 'FeatureFeeCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.FeatureFeeNotCredit Then Result           := 'FeatureFeeNotCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.ReverseFeatureFeeCredit Then Result       := 'ReverseFeatureFeeCredit'
  Else If Value = DisputeResolutionRecordTypeCodeType.CustomCode Then Result                    := 'CustomCode'
  Else Result                                                                                   := '';
End;

Function enumToStr(Const Value: InvocationStatusType): String;
Begin
       If Value =InvocationStatusType.InProgress Then Result   := 'InProgress'
  Else If Value = InvocationStatusType.Success  Then Result := 'Success'
  Else If Value = InvocationStatusType.Failure  Then Result := 'Failure'
  Else Result                                              := '';
End;

Function enumToStr(Const Value: DetailLevelCodeType): String;
Begin
       If Value =DetailLevelCodeType.ReturnAll Then Result                  := 'ReturnAll'
  Else If Value = DetailLevelCodeType.ItemReturnDescription  Then Result := 'ItemReturnDescription'
  Else If Value = DetailLevelCodeType.ItemReturnAttributes Then Result  := 'ItemReturnAttributes'
  Else If Value = DetailLevelCodeType.ItemReturnCategories Then Result  := 'ItemReturnCategories'
  Else If Value = DetailLevelCodeType.ReturnSummary Then Result         := 'ReturnSummary'
  Else If Value = DetailLevelCodeType.ReturnHeaders Then Result         := 'ReturnHeaders'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: AckCodeType): String;
Begin
       If Value =AckCodeType.Success Then Result             := 'Success'
  Else If Value = AckCodeType.Failure Then Result        := 'Failure'
  Else If Value = AckCodeType.Warning Then Result        := 'Warning'
  Else If Value = AckCodeType.PartialFailure  Then Result := 'PartialFailure'
  Else Result                                            := '';
End;

Function enumToStr(Const Value: ErrorHandlingCodeType): String;
Begin
       If Value =ErrorHandlingCodeType.Legacy Then Result            := 'Legacy'
  Else If Value = ErrorHandlingCodeType.BestEffort Then Result   := 'BestEffort'
  Else If Value = ErrorHandlingCodeType.AllOrNothing  Then Result := 'AllOrNothing'
  Else Result                                                    := '';
End;

Function enumToStr(Const Value: WarningLevelCodeType): String;
Begin
       If Value =WarningLevelCodeType.Low_  Then Result := 'Low_'
  Else Result                                      := '';
End;

Function enumToStr(Const Value: AnnouncementMessageCodeType): String;
Begin
       If Value =AnnouncementMessageCodeType.None Then Result                       := 'None'
  Else If Value = AnnouncementMessageCodeType.Deprecation Then Result           := 'Deprecation'
  Else If Value = AnnouncementMessageCodeType.Mapping Then Result               := 'Mapping'
  Else If Value = AnnouncementMessageCodeType.DeprecationAndMapping  Then Result := 'DeprecationAndMapping'
  Else Result                                                                   := '';
End;

Function enumToStr(Const Value: AccessRuleCurrentStatusCodeType): String;
Begin
       If Value =AccessRuleCurrentStatusCodeType.NotSet Then Result                         := 'NotSet'
  Else If Value = AccessRuleCurrentStatusCodeType.HourlyLimitExceeded Then Result       := 'HourlyLimitExceeded'
  Else If Value = AccessRuleCurrentStatusCodeType.DailyLimitExceeded Then Result        := 'DailyLimitExceeded'
  Else If Value = AccessRuleCurrentStatusCodeType.PeriodicLimitExceeded Then Result     := 'PeriodicLimitExceeded'
  Else If Value = AccessRuleCurrentStatusCodeType.HourlySoftLimitExceeded Then Result   := 'HourlySoftLimitExceeded'
  Else If Value = AccessRuleCurrentStatusCodeType.DailySoftLimitExceeded Then Result    := 'DailySoftLimitExceeded'
  Else If Value = AccessRuleCurrentStatusCodeType.PeriodicSoftLimitExceeded  Then Result := 'PeriodicSoftLimitExceeded'
  Else Result                                                                           := '';
End;

Function enumToStr(Const Value: AccessRuleStatusCodeType): String;
Begin
       If Value =AccessRuleStatusCodeType.RuleOff Then Result                 := 'RuleOff'
  Else If Value = AccessRuleStatusCodeType.RuleOn Then Result             := 'RuleOn'
  Else If Value = AccessRuleStatusCodeType.ApplicationBlocked  Then Result := 'ApplicationBlocked'
  Else Result                                                             := '';
End;

Function enumToStr(Const Value: AddressUsageCodeType): String;
Begin
       If Value =AddressUsageCodeType.DefaultShipping  Then Result := 'DefaultShipping'
  Else If Value = AddressUsageCodeType.Shipping Then Result   := 'Shipping'
  Else If Value = AddressUsageCodeType.Invalid Then Result    := 'Invalid'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: ApplicationDeviceTypeCodeType): String;
Begin
       If Value =ApplicationDeviceTypeCodeType.Browser Then Result          := 'Browser'
  Else If Value = ApplicationDeviceTypeCodeType.Wireless Then Result    := 'Wireless'
  Else If Value = ApplicationDeviceTypeCodeType.Desktop Then Result     := 'Desktop'
  Else If Value = ApplicationDeviceTypeCodeType.SetTopTVBox  Then Result := 'SetTopTVBox'
  Else Result                                                           := '';
End;

Function enumToStr(Const Value: EnableCodeType): String;
Begin
       If Value =EnableCodeType.Enable Then Result       := 'Enable'
  Else If Value = EnableCodeType.Disable  Then Result := 'Disable'
  Else Result                                        := '';
End;

Function enumToStr(Const Value: NotificationPayloadTypeCodeType): String;
Begin
       If Value =NotificationPayloadTypeCodeType.EBLSchemaSOAP  Then Result := 'eBLSchemaSOAP'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: DeviceTypeCodeType): String;
Begin
       If Value =DeviceTypeCodeType.Platform_ Then Result         := 'Platform_'
  Else If Value = DeviceTypeCodeType.SMS Then Result          := 'SMS'
  Else If Value = DeviceTypeCodeType.ClientAlerts  Then Result := 'ClientAlerts'
  Else Result                                                 := '';
End;

Function enumToStr(Const Value: AccountDetailEntryCodeType): String;
Begin
       If Value =AccountDetailEntryCodeType.Unknown Then Result                                              := 'Unknown'
  Else If Value = AccountDetailEntryCodeType.FeeInsertion Then Result                                    := 'FeeInsertion'
  Else If Value = AccountDetailEntryCodeType.FeeBold Then Result                                         := 'FeeBold'
  Else If Value = AccountDetailEntryCodeType.FeeFeatured Then Result                                     := 'FeeFeatured'
  Else If Value = AccountDetailEntryCodeType.FeeCategoryFeatured Then Result                             := 'FeeCategoryFeatured'
  Else If Value = AccountDetailEntryCodeType.FeeFinalValue Then Result                                   := 'FeeFinalValue'
  Else If Value = AccountDetailEntryCodeType.PaymentCheck Then Result                                    := 'PaymentCheck'
  Else If Value = AccountDetailEntryCodeType.PaymentCC Then Result                                       := 'PaymentCC'
  Else If Value = AccountDetailEntryCodeType.CreditCourtesy Then Result                                  := 'CreditCourtesy'
  Else If Value = AccountDetailEntryCodeType.CreditNoSale Then Result                                    := 'CreditNoSale'
  Else If Value = AccountDetailEntryCodeType.CreditPartialSale Then Result                               := 'CreditPartialSale'
  Else If Value = AccountDetailEntryCodeType.RefundCC Then Result                                        := 'RefundCC'
  Else If Value = AccountDetailEntryCodeType.RefundCheck Then Result                                     := 'RefundCheck'
  Else If Value = AccountDetailEntryCodeType.FinanceCharge Then Result                                   := 'FinanceCharge'
  Else If Value = AccountDetailEntryCodeType.AWDebit Then Result                                         := 'AWDebit'
  Else If Value = AccountDetailEntryCodeType.AWCredit Then Result                                        := 'AWCredit'
  Else If Value = AccountDetailEntryCodeType.AWMemo Then Result                                          := 'AWMemo'
  Else If Value = AccountDetailEntryCodeType.CreditDuplicateListing Then Result                          := 'CreditDuplicateListing'
  Else If Value = AccountDetailEntryCodeType.FeePartialSale Then Result                                  := 'FeePartialSale'
  Else If Value = AccountDetailEntryCodeType.PaymentElectronicTransferReversal Then Result               := 'PaymentElectronicTransferReversal'
  Else If Value = AccountDetailEntryCodeType.PaymentCCOnce Then Result                                   := 'PaymentCCOnce'
  Else If Value = AccountDetailEntryCodeType.FeeReturnedCheck Then Result                                := 'FeeReturnedCheck'
  Else If Value = AccountDetailEntryCodeType.FeeRedepositCheck Then Result                               := 'FeeRedepositCheck'
  Else If Value = AccountDetailEntryCodeType.PaymentCash Then Result                                     := 'PaymentCash'
  Else If Value = AccountDetailEntryCodeType.CreditInsertion Then Result                                 := 'CreditInsertion'
  Else If Value = AccountDetailEntryCodeType.CreditBold Then Result                                      := 'CreditBold'
  Else If Value = AccountDetailEntryCodeType.CreditFeatured Then Result                                  := 'CreditFeatured'
  Else If Value = AccountDetailEntryCodeType.CreditCategoryFeatured Then Result                          := 'CreditCategoryFeatured'
  Else If Value = AccountDetailEntryCodeType.CreditFinalValue Then Result                                := 'CreditFinalValue'
  Else If Value = AccountDetailEntryCodeType.FeeNSFCheck Then Result                                     := 'FeeNSFCheck'
  Else If Value = AccountDetailEntryCodeType.FeeReturnCheckClose Then Result                             := 'FeeReturnCheckClose'
  Else If Value = AccountDetailEntryCodeType.Memo Then Result                                            := 'Memo'
  Else If Value = AccountDetailEntryCodeType.PaymentMoneyOrder Then Result                               := 'PaymentMoneyOrder'
  Else If Value = AccountDetailEntryCodeType.CreditCardOnFile Then Result                                := 'CreditCardOnFile'
  Else If Value = AccountDetailEntryCodeType.CreditCardNotOnFile Then Result                             := 'CreditCardNotOnFile'
  Else If Value = AccountDetailEntryCodeType.Invoiced Then Result                                        := 'Invoiced'
  Else If Value = AccountDetailEntryCodeType.InvoicedCreditCard Then Result                              := 'InvoicedCreditCard'
  Else If Value = AccountDetailEntryCodeType.CreditTransferFrom Then Result                              := 'CreditTransferFrom'
  Else If Value = AccountDetailEntryCodeType.DebitTransferTo Then Result                                 := 'DebitTransferTo'
  Else If Value = AccountDetailEntryCodeType.InvoiceCreditBalance Then Result                            := 'InvoiceCreditBalance'
  Else If Value = AccountDetailEntryCodeType.EBayDebit Then Result                                       := 'eBayDebit'
  Else If Value = AccountDetailEntryCodeType.EBayCredit Then Result                                      := 'eBayCredit'
  Else If Value = AccountDetailEntryCodeType.PromotionalCredit Then Result                               := 'PromotionalCredit'
  Else If Value = AccountDetailEntryCodeType.CCNotOnFilePerCustReq Then Result                           := 'CCNotOnFilePerCustReq'
  Else If Value = AccountDetailEntryCodeType.CreditInsertionFee Then Result                              := 'CreditInsertionFee'
  Else If Value = AccountDetailEntryCodeType.CCPaymentRejected Then Result                               := 'CCPaymentRejected'
  Else If Value = AccountDetailEntryCodeType.FeeGiftIcon Then Result                                     := 'FeeGiftIcon'
  Else If Value = AccountDetailEntryCodeType.CreditGiftIcon Then Result                                  := 'CreditGiftIcon'
  Else If Value = AccountDetailEntryCodeType.FeeGallery Then Result                                      := 'FeeGallery'
  Else If Value = AccountDetailEntryCodeType.FeeFeaturedGallery Then Result                              := 'FeeFeaturedGallery'
  Else If Value = AccountDetailEntryCodeType.CreditGallery Then Result                                   := 'CreditGallery'
  Else If Value = AccountDetailEntryCodeType.CreditFeaturedGallery Then Result                           := 'CreditFeaturedGallery'
  Else If Value = AccountDetailEntryCodeType.ItemMoveFee Then Result                                     := 'ItemMoveFee'
  Else If Value = AccountDetailEntryCodeType.OutageCredit Then Result                                    := 'OutageCredit'
  Else If Value = AccountDetailEntryCodeType.CreditPSA Then Result                                       := 'CreditPSA'
  Else If Value = AccountDetailEntryCodeType.CreditPCGS Then Result                                      := 'CreditPCGS'
  Else If Value = AccountDetailEntryCodeType.FeeReserve Then Result                                      := 'FeeReserve'
  Else If Value = AccountDetailEntryCodeType.CreditReserve Then Result                                   := 'CreditReserve'
  Else If Value = AccountDetailEntryCodeType.EBayVISACredit Then Result                                  := 'eBayVISACredit'
  Else If Value = AccountDetailEntryCodeType.BBAdminCredit Then Result                                   := 'BBAdminCredit'
  Else If Value = AccountDetailEntryCodeType.BBAdminDebit Then Result                                    := 'BBAdminDebit'
  Else If Value = AccountDetailEntryCodeType.ReferrerCredit Then Result                                  := 'ReferrerCredit'
  Else If Value = AccountDetailEntryCodeType.ReferrerDebit Then Result                                   := 'ReferrerDebit'
  Else If Value = AccountDetailEntryCodeType.SwitchCurrency Then Result                                  := 'SwitchCurrency'
  Else If Value = AccountDetailEntryCodeType.PaymentGiftCertificate Then Result                          := 'PaymentGiftCertificate'
  Else If Value = AccountDetailEntryCodeType.PaymentWireTransfer Then Result                             := 'PaymentWireTransfer'
  Else If Value = AccountDetailEntryCodeType.PaymentHomeBanking Then Result                              := 'PaymentHomeBanking'
  Else If Value = AccountDetailEntryCodeType.PaymentElectronicTransfer Then Result                       := 'PaymentElectronicTransfer'
  Else If Value = AccountDetailEntryCodeType.PaymentAdjustmentCredit Then Result                         := 'PaymentAdjustmentCredit'
  Else If Value = AccountDetailEntryCodeType.PaymentAdjustmentDebit Then Result                          := 'PaymentAdjustmentDebit'
  Else If Value = AccountDetailEntryCodeType.Chargeoff Then Result                                       := 'Chargeoff'
  Else If Value = AccountDetailEntryCodeType.ChargeoffRecovery Then Result                               := 'ChargeoffRecovery'
  Else If Value = AccountDetailEntryCodeType.ChargeoffBankruptcy Then Result                             := 'ChargeoffBankruptcy'
  Else If Value = AccountDetailEntryCodeType.ChargeoffSuspended Then Result                              := 'ChargeoffSuspended'
  Else If Value = AccountDetailEntryCodeType.ChargeoffDeceased Then Result                               := 'ChargeoffDeceased'
  Else If Value = AccountDetailEntryCodeType.ChargeoffOther Then Result                                  := 'ChargeoffOther'
  Else If Value = AccountDetailEntryCodeType.ChargeoffWacko Then Result                                  := 'ChargeoffWacko'
  Else If Value = AccountDetailEntryCodeType.FinanceChargeReversal Then Result                           := 'FinanceChargeReversal'
  Else If Value = AccountDetailEntryCodeType.FVFCreditReversal Then Result                               := 'FVFCreditReversal'
  Else If Value = AccountDetailEntryCodeType.ForeignFundsConvert Then Result                             := 'ForeignFundsConvert'
  Else If Value = AccountDetailEntryCodeType.ForeignFundsCheckReversal Then Result                       := 'ForeignFundsCheckReversal'
  Else If Value = AccountDetailEntryCodeType.EOMRestriction Then Result                                  := 'EOMRestriction'
  Else If Value = AccountDetailEntryCodeType.AllFeesCredit Then Result                                   := 'AllFeesCredit'
  Else If Value = AccountDetailEntryCodeType.SetOnHold Then Result                                       := 'SetOnHold'
  Else If Value = AccountDetailEntryCodeType.RevertUserState Then Result                                 := 'RevertUserState'
  Else If Value = AccountDetailEntryCodeType.DirectDebitOnFile Then Result                               := 'DirectDebitOnFile'
  Else If Value = AccountDetailEntryCodeType.DirectDebitNotOnFile Then Result                            := 'DirectDebitNotOnFile'
  Else If Value = AccountDetailEntryCodeType.PaymentDirectDebit Then Result                              := 'PaymentDirectDebit'
  Else If Value = AccountDetailEntryCodeType.DirectDebitReversal Then Result                             := 'DirectDebitReversal'
  Else If Value = AccountDetailEntryCodeType.DirectDebitReturnedItem Then Result                         := 'DirectDebitReturnedItem'
  Else If Value = AccountDetailEntryCodeType.FeeHighlight Then Result                                    := 'FeeHighlight'
  Else If Value = AccountDetailEntryCodeType.CreditHighlight Then Result                                 := 'CreditHighlight'
  Else If Value = AccountDetailEntryCodeType.BulkUserSuspension Then Result                              := 'BulkUserSuspension'
  Else If Value = AccountDetailEntryCodeType.FeeRealEstate30DaysListing Then Result                      := 'FeeRealEstate30DaysListing'
  Else If Value = AccountDetailEntryCodeType.CreditRealEstate30DaysListing Then Result                   := 'CreditRealEstate30DaysListing'
  Else If Value = AccountDetailEntryCodeType.TradingLimitOverrideOn Then Result                          := 'TradingLimitOverrideOn'
  Else If Value = AccountDetailEntryCodeType.TradingLimitOverrideOff Then Result                         := 'TradingLimitOverrideOff'
  Else If Value = AccountDetailEntryCodeType.EquifaxRealtimeFee Then Result                              := 'EquifaxRealtimeFee'
  Else If Value = AccountDetailEntryCodeType.CreditEquifaxRealtimeFee Then Result                        := 'CreditEquifaxRealtimeFee'
  Else If Value = AccountDetailEntryCodeType.PaymentEquifaxDebit Then Result                             := 'PaymentEquifaxDebit'
  Else If Value = AccountDetailEntryCodeType.PaymentEquifaxCredit Then Result                            := 'PaymentEquifaxCredit'
  Else If Value = AccountDetailEntryCodeType.Merged Then Result                                          := 'Merged'
  Else If Value = AccountDetailEntryCodeType.AutoTraderOn Then Result                                    := 'AutoTraderOn'
  Else If Value = AccountDetailEntryCodeType.AutoTraderOff Then Result                                   := 'AutoTraderOff'
  Else If Value = AccountDetailEntryCodeType.PaperInvoiceOn Then Result                                  := 'PaperInvoiceOn'
  Else If Value = AccountDetailEntryCodeType.PaperInvoiceOff Then Result                                 := 'PaperInvoiceOff'
  Else If Value = AccountDetailEntryCodeType.AccountStateSwitch Then Result                              := 'AccountStateSwitch'
  Else If Value = AccountDetailEntryCodeType.FVFCreditReversalAutomatic Then Result                      := 'FVFCreditReversalAutomatic'
  Else If Value = AccountDetailEntryCodeType.CreditSoftOutage Then Result                                := 'CreditSoftOutage'
  Else If Value = AccountDetailEntryCodeType.LACatalogFee Then Result                                    := 'LACatalogFee'
  Else If Value = AccountDetailEntryCodeType.LAExtraItem Then Result                                     := 'LAExtraItem'
  Else If Value = AccountDetailEntryCodeType.LACatalogItemFeeRefund Then Result                          := 'LACatalogItemFeeRefund'
  Else If Value = AccountDetailEntryCodeType.LACatalogInsertionRefund Then Result                        := 'LACatalogInsertionRefund'
  Else If Value = AccountDetailEntryCodeType.LAFinalValueFee Then Result                                 := 'LAFinalValueFee'
  Else If Value = AccountDetailEntryCodeType.LAFinalValueFeeRefund Then Result                           := 'LAFinalValueFeeRefund'
  Else If Value = AccountDetailEntryCodeType.LABuyerPremiumPercentageFee Then Result                     := 'LABuyerPremiumPercentageFee'
  Else If Value = AccountDetailEntryCodeType.LABuyerPremiumPercentageFeeRefund Then Result               := 'LABuyerPremiumPercentageFeeRefund'
  Else If Value = AccountDetailEntryCodeType.LAAudioVideoFee Then Result                                 := 'LAAudioVideoFee'
  Else If Value = AccountDetailEntryCodeType.LAAudioVideoFeeRefund Then Result                           := 'LAAudioVideoFeeRefund'
  Else If Value = AccountDetailEntryCodeType.FeeIPIXPhoto Then Result                                    := 'FeeIPIXPhoto'
  Else If Value = AccountDetailEntryCodeType.FeeIPIXSlideShow Then Result                                := 'FeeIPIXSlideShow'
  Else If Value = AccountDetailEntryCodeType.CreditIPIXPhoto Then Result                                 := 'CreditIPIXPhoto'
  Else If Value = AccountDetailEntryCodeType.CreditIPIXSlideShow Then Result                             := 'CreditIPIXSlideShow'
  Else If Value = AccountDetailEntryCodeType.FeeTenDayAuction Then Result                                := 'FeeTenDayAuction'
  Else If Value = AccountDetailEntryCodeType.CreditTenDayAuction Then Result                             := 'CreditTenDayAuction'
  Else If Value = AccountDetailEntryCodeType.TemporaryCredit Then Result                                 := 'TemporaryCredit'
  Else If Value = AccountDetailEntryCodeType.TemporaryCreditReversal Then Result                         := 'TemporaryCreditReversal'
  Else If Value = AccountDetailEntryCodeType.SubscriptionAABasic Then Result                             := 'SubscriptionAABasic'
  Else If Value = AccountDetailEntryCodeType.SubscriptionAAPro Then Result                               := 'SubscriptionAAPro'
  Else If Value = AccountDetailEntryCodeType.CreditAABasic Then Result                                   := 'CreditAABasic'
  Else If Value = AccountDetailEntryCodeType.CreditAAPro Then Result                                     := 'CreditAAPro'
  Else If Value = AccountDetailEntryCodeType.FeeLargePicture Then Result                                 := 'FeeLargePicture'
  Else If Value = AccountDetailEntryCodeType.CreditLargePicture Then Result                              := 'CreditLargePicture'
  Else If Value = AccountDetailEntryCodeType.FeePicturePack Then Result                                  := 'FeePicturePack'
  Else If Value = AccountDetailEntryCodeType.CreditPicturePackPartial Then Result                        := 'CreditPicturePackPartial'
  Else If Value = AccountDetailEntryCodeType.CreditPicturePackFull Then Result                           := 'CreditPicturePackFull'
  Else If Value = AccountDetailEntryCodeType.SubscriptioneBayStores Then Result                          := 'SubscriptioneBayStores'
  Else If Value = AccountDetailEntryCodeType.CrediteBayStores Then Result                                := 'CrediteBayStores'
  Else If Value = AccountDetailEntryCodeType.FeeInsertionFixedPrice Then Result                          := 'FeeInsertionFixedPrice'
  Else If Value = AccountDetailEntryCodeType.CreditInsertionFixedPrice Then Result                       := 'CreditInsertionFixedPrice'
  Else If Value = AccountDetailEntryCodeType.FeeFinalValueFixedPrice Then Result                         := 'FeeFinalValueFixedPrice'
  Else If Value = AccountDetailEntryCodeType.CreditFinalValueFixedPrice Then Result                      := 'CreditFinalValueFixedPrice'
  Else If Value = AccountDetailEntryCodeType.ElectronicInvoiceOn Then Result                             := 'ElectronicInvoiceOn'
  Else If Value = AccountDetailEntryCodeType.ElectronicInvoiceOff Then Result                            := 'ElectronicInvoiceOff'
  Else If Value = AccountDetailEntryCodeType.FlagDDDDPending Then Result                                 := 'FlagDDDDPending'
  Else If Value = AccountDetailEntryCodeType.FlagDDPaymentConfirmed Then Result                          := 'FlagDDPaymentConfirmed'
  Else If Value = AccountDetailEntryCodeType.FixedPriceDurationFee Then Result                           := 'FixedPriceDurationFee'
  Else If Value = AccountDetailEntryCodeType.FixedPriceDurationCredit Then Result                        := 'FixedPriceDurationCredit'
  Else If Value = AccountDetailEntryCodeType.BuyItNowFee Then Result                                     := 'BuyItNowFee'
  Else If Value = AccountDetailEntryCodeType.BuyItNowCredit Then Result                                  := 'BuyItNowCredit'
  Else If Value = AccountDetailEntryCodeType.FeeSchedule Then Result                                     := 'FeeSchedule'
  Else If Value = AccountDetailEntryCodeType.CreditSchedule Then Result                                  := 'CreditSchedule'
  Else If Value = AccountDetailEntryCodeType.SubscriptionSMBasic Then Result                             := 'SubscriptionSMBasic'
  Else If Value = AccountDetailEntryCodeType.SubscriptionSMBasicPro Then Result                          := 'SubscriptionSMBasicPro'
  Else If Value = AccountDetailEntryCodeType.CreditSMBasic Then Result                                   := 'CreditSMBasic'
  Else If Value = AccountDetailEntryCodeType.CreditSMBasicPro Then Result                                := 'CreditSMBasicPro'
  Else If Value = AccountDetailEntryCodeType.StoresGTCFee Then Result                                    := 'StoresGTCFee'
  Else If Value = AccountDetailEntryCodeType.StoresGTCCredit Then Result                                 := 'StoresGTCCredit'
  Else If Value = AccountDetailEntryCodeType.ListingDesignerFee Then Result                              := 'ListingDesignerFee'
  Else If Value = AccountDetailEntryCodeType.ListingDesignerCredit Then Result                           := 'ListingDesignerCredit'
  Else If Value = AccountDetailEntryCodeType.ExtendedAuctionFee Then Result                              := 'ExtendedAuctionFee'
  Else If Value = AccountDetailEntryCodeType.ExtendedAcutionCredit Then Result                           := 'ExtendedAcutionCredit'
  Else If Value = AccountDetailEntryCodeType.PayPalOTPSucc Then Result                                   := 'PayPalOTPSucc'
  Else If Value = AccountDetailEntryCodeType.PayPalOTPPend Then Result                                   := 'PayPalOTPPend'
  Else If Value = AccountDetailEntryCodeType.PayPalFailed Then Result                                    := 'PayPalFailed'
  Else If Value = AccountDetailEntryCodeType.PayPalChargeBack Then Result                                := 'PayPalChargeBack'
  Else If Value = AccountDetailEntryCodeType.ChargeBack Then Result                                      := 'ChargeBack'
  Else If Value = AccountDetailEntryCodeType.ChargeBackReversal Then Result                              := 'ChargeBackReversal'
  Else If Value = AccountDetailEntryCodeType.PayPalRefund Then Result                                    := 'PayPalRefund'
  Else If Value = AccountDetailEntryCodeType.BonusPointsAddition Then Result                             := 'BonusPointsAddition'
  Else If Value = AccountDetailEntryCodeType.BonusPointsReduction Then Result                            := 'BonusPointsReduction'
  Else If Value = AccountDetailEntryCodeType.BonusPointsPaymentAutomatic Then Result                     := 'BonusPointsPaymentAutomatic'
  Else If Value = AccountDetailEntryCodeType.BonusPointsPaymentManual Then Result                        := 'BonusPointsPaymentManual'
  Else If Value = AccountDetailEntryCodeType.BonusPointsPaymentReversal Then Result                      := 'BonusPointsPaymentReversal'
  Else If Value = AccountDetailEntryCodeType.BonusPointsCashPayout Then Result                           := 'BonusPointsCashPayout'
  Else If Value = AccountDetailEntryCodeType.VATCredit Then Result                                       := 'VATCredit'
  Else If Value = AccountDetailEntryCodeType.VATDebit Then Result                                        := 'VATDebit'
  Else If Value = AccountDetailEntryCodeType.VATStatusChangePending Then Result                          := 'VATStatusChangePending'
  Else If Value = AccountDetailEntryCodeType.VATStatusChangeApproved Then Result                         := 'VATStatusChangeApproved'
  Else If Value = AccountDetailEntryCodeType.VATStatusChange_Denied Then Result                          := 'VATStatusChange_Denied'
  Else If Value = AccountDetailEntryCodeType.VATStatusDeletedByCSR Then Result                           := 'VATStatusDeletedByCSR'
  Else If Value = AccountDetailEntryCodeType.VATStatusDeletedByUser Then Result                          := 'VATStatusDeletedByUser'
  Else If Value = AccountDetailEntryCodeType.SMProListingDesignerFee Then Result                         := 'SMProListingDesignerFee'
  Else If Value = AccountDetailEntryCodeType.SMProListingDesignerCredit Then Result                      := 'SMProListingDesignerCredit'
  Else If Value = AccountDetailEntryCodeType.StoresSuccessfulListingFee Then Result                      := 'StoresSuccessfulListingFee'
  Else If Value = AccountDetailEntryCodeType.StoresSuccessfulListingFeeCredit Then Result                := 'StoresSuccessfulListingFeeCredit'
  Else If Value = AccountDetailEntryCodeType.StoresReferralFee Then Result                               := 'StoresReferralFee'
  Else If Value = AccountDetailEntryCodeType.StoresReferralCredit Then Result                            := 'StoresReferralCredit'
  Else If Value = AccountDetailEntryCodeType.SubtitleFee Then Result                                     := 'SubtitleFee'
  Else If Value = AccountDetailEntryCodeType.SubtitleFeeCredit Then Result                               := 'SubtitleFeeCredit'
  Else If Value = AccountDetailEntryCodeType.EBayStoreInventorySubscriptionCredit Then Result            := 'eBayStoreInventorySubscriptionCredit'
  Else If Value = AccountDetailEntryCodeType.AutoPmntReqExempt Then Result                               := 'AutoPmntReqExempt'
  Else If Value = AccountDetailEntryCodeType.AutoPmntReqRein Then Result                                 := 'AutoPmntReqRein'
  Else If Value = AccountDetailEntryCodeType.PictureManagerSubscriptionFee Then Result                   := 'PictureManagerSubscriptionFee'
  Else If Value = AccountDetailEntryCodeType.PictureManagerSubscriptionFeeCredit Then Result             := 'PictureManagerSubscriptionFeeCredit'
  Else If Value = AccountDetailEntryCodeType.SellerReportsBasicFee Then Result                           := 'SellerReportsBasicFee'
  Else If Value = AccountDetailEntryCodeType.SellerReportsBasicCredit Then Result                        := 'SellerReportsBasicCredit'
  Else If Value = AccountDetailEntryCodeType.SellerReportsPlusFee Then Result                            := 'SellerReportsPlusFee'
  Else If Value = AccountDetailEntryCodeType.SellerReportsPlusCredit Then Result                         := 'SellerReportsPlusCredit'
  Else If Value = AccountDetailEntryCodeType.PaypalOnFile Then Result                                    := 'PaypalOnFile'
  Else If Value = AccountDetailEntryCodeType.PaypalOnFileByCSR Then Result                               := 'PaypalOnFileByCSR'
  Else If Value = AccountDetailEntryCodeType.PaypalOffFile Then Result                                   := 'PaypalOffFile'
  Else If Value = AccountDetailEntryCodeType.BorderFee Then Result                                       := 'BorderFee'
  Else If Value = AccountDetailEntryCodeType.BorderFeeCredit Then Result                                 := 'BorderFeeCredit'
  Else If Value = AccountDetailEntryCodeType.FeeSearchableMobileDE Then Result                           := 'FeeSearchableMobileDE'
  Else If Value = AccountDetailEntryCodeType.SalesReportsPlusFee Then Result                             := 'SalesReportsPlusFee'
  Else If Value = AccountDetailEntryCodeType.SalesReportsPlusCredit Then Result                          := 'SalesReportsPlusCredit'
  Else If Value = AccountDetailEntryCodeType.CreditSearchableMobileDE Then Result                        := 'CreditSearchableMobileDE'
  Else If Value = AccountDetailEntryCodeType.EmailMarketingFee Then Result                               := 'EmailMarketingFee'
  Else If Value = AccountDetailEntryCodeType.EmailMarketingCredit Then Result                            := 'EmailMarketingCredit'
  Else If Value = AccountDetailEntryCodeType.FeePictureShow Then Result                                  := 'FeePictureShow'
  Else If Value = AccountDetailEntryCodeType.CreditPictureShow Then Result                               := 'CreditPictureShow'
  Else If Value = AccountDetailEntryCodeType.ProPackBundleFee Then Result                                := 'ProPackBundleFee'
  Else If Value = AccountDetailEntryCodeType.ProPackBundleFeeCredit Then Result                          := 'ProPackBundleFeeCredit'
  Else If Value = AccountDetailEntryCodeType.BasicUpgradePackBundleFee Then Result                       := 'BasicUpgradePackBundleFee'
  Else If Value = AccountDetailEntryCodeType.BasicUpgradePackBundleFeeCredit Then Result                 := 'BasicUpgradePackBundleFeeCredit'
  Else If Value = AccountDetailEntryCodeType.ValuePackBundleFee Then Result                              := 'ValuePackBundleFee'
  Else If Value = AccountDetailEntryCodeType.ValuePackBundleFeeCredit Then Result                        := 'ValuePackBundleFeeCredit'
  Else If Value = AccountDetailEntryCodeType.ProPackPlusBundleFee Then Result                            := 'ProPackPlusBundleFee'
  Else If Value = AccountDetailEntryCodeType.ProPackPlusBundleFeeCredit Then Result                      := 'ProPackPlusBundleFeeCredit'
  Else If Value = AccountDetailEntryCodeType.FinalEntry Then Result                                      := 'FinalEntry'
  Else If Value = AccountDetailEntryCodeType.CustomCode Then Result                                      := 'CustomCode'
  Else If Value = AccountDetailEntryCodeType.ExtendedDurationFee Then Result                             := 'ExtendedDurationFee'
  Else If Value = AccountDetailEntryCodeType.ExtendedDurationFeeCredit Then Result                       := 'ExtendedDurationFeeCredit'
  Else If Value = AccountDetailEntryCodeType.InternationalListingFee Then Result                         := 'InternationalListingFee'
  Else If Value = AccountDetailEntryCodeType.InternationalListingCredit Then Result                      := 'InternationalListingCredit'
  Else If Value = AccountDetailEntryCodeType.MarketplaceResearchExpiredSubscriptionFee Then Result       := 'MarketplaceResearchExpiredSubscriptionFee'
  Else If Value = AccountDetailEntryCodeType.MarketplaceResearchExpiredSubscriptionFeeCredit  Then Result := 'MarketplaceResearchExpiredSubscriptionFeeCredit'
  Else If Value = AccountDetailEntryCodeType.MarketplaceResearchBasicSubscriptionFee Then Result         := 'MarketplaceResearchBasicSubscriptionFee'
  Else If Value = AccountDetailEntryCodeType.MarketplaceResearchBasicSubscriptionFeeCredit Then Result   := 'MarketplaceResearchBasicSubscriptionFeeCredit'
  Else If Value = AccountDetailEntryCodeType.MarketplaceResearchProSubscriptionFee Then Result           := 'MarketplaceResearchProSubscriptionFee'
  Else If Value = AccountDetailEntryCodeType.BasicBundleFee Then Result                                  := 'BasicBundleFee'
  Else If Value = AccountDetailEntryCodeType.BasicBundleFeeCredit Then Result                            := 'BasicBundleFeeCredit'
  Else If Value = AccountDetailEntryCodeType.MarketplaceResearchProSubscriptionFeeCredit Then Result     := 'MarketplaceResearchProSubscriptionFeeCredit'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalSubscriptionFee Then Result                     := 'VehicleLocalSubscriptionFee'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalSubscriptionFeeCredit Then Result               := 'VehicleLocalSubscriptionFeeCredit'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalInsertionFee Then Result                        := 'VehicleLocalInsertionFee'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalInsertionFeeCredit Then Result                  := 'VehicleLocalInsertionFeeCredit'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalFinalValueFee Then Result                       := 'VehicleLocalFinalValueFee'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalFinalValueFeeCredit Then Result                 := 'VehicleLocalFinalValueFeeCredit'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalGTCFee Then Result                              := 'VehicleLocalGTCFee'
  Else If Value = AccountDetailEntryCodeType.VehicleLocalGTCFeeCredit Then Result                        := 'VehicleLocalGTCFeeCredit'
  Else If Value = AccountDetailEntryCodeType.EBayMotorsProFee Then Result                                := 'eBayMotorsProFee'
  Else If Value = AccountDetailEntryCodeType.CrediteBayMotorsProFee Then Result                          := 'CrediteBayMotorsProFee'
  Else If Value = AccountDetailEntryCodeType.EBayMotorsProFeatureFee Then Result                         := 'eBayMotorsProFeatureFee'
  Else If Value = AccountDetailEntryCodeType.CrediteBayMotorsProFeatureFee Then Result                   := 'CrediteBayMotorsProFeatureFee'
  Else If Value = AccountDetailEntryCodeType.FeeGalleryPlus Then Result                                  := 'FeeGalleryPlus'
  Else If Value = AccountDetailEntryCodeType.CreditGalleryPlus Then Result                               := 'CreditGalleryPlus'
  Else If Value = AccountDetailEntryCodeType.PrivateListing Then Result                                  := 'PrivateListing'
  Else If Value = AccountDetailEntryCodeType.CreditPrivateListing Then Result                            := 'CreditPrivateListing'
  Else If Value = AccountDetailEntryCodeType.ImmoProFee Then Result                                      := 'ImmoProFee'
  Else If Value = AccountDetailEntryCodeType.CreditImmoProFee Then Result                                := 'CreditImmoProFee'
  Else If Value = AccountDetailEntryCodeType.ImmoProFeatureFee Then Result                               := 'ImmoProFeatureFee'
  Else If Value = AccountDetailEntryCodeType.CreditImmoProFeatureFee Then Result                         := 'CreditImmoProFeatureFee'
  Else If Value = AccountDetailEntryCodeType.RealEstateProFee Then Result                                := 'RealEstateProFee'
  Else If Value = AccountDetailEntryCodeType.CreditRealEstateProFee Then Result                          := 'CreditRealEstateProFee'
  Else If Value = AccountDetailEntryCodeType.RealEstateProFeatureFee Then Result                         := 'RealEstateProFeatureFee'
  Else If Value = AccountDetailEntryCodeType.CreditRealEstateProFeatureFee Then Result                   := 'CreditRealEstateProFeatureFee'
  Else If Value = AccountDetailEntryCodeType.Discount Then Result                                        := 'Discount'
  Else If Value = AccountDetailEntryCodeType.CreditFinalValueShipping Then Result                        := 'CreditFinalValueShipping'
  Else If Value = AccountDetailEntryCodeType.FeeFinalValueShipping Then Result                           := 'FeeFinalValueShipping'
  Else If Value = AccountDetailEntryCodeType.FeeReturnShipping Then Result                               := 'FeeReturnShipping'
  Else If Value = AccountDetailEntryCodeType.CreditReturnShipping Then Result                            := 'CreditReturnShipping'
  Else If Value = AccountDetailEntryCodeType.FeeGlobalShippingProgram Then Result                        := 'FeeGlobalShippingProgram'
  Else If Value = AccountDetailEntryCodeType.CreditGlobalShippingProgram Then Result                     := 'CreditGlobalShippingProgram'
  Else If Value = AccountDetailEntryCodeType.FeeAuctionEndEarly Then Result                              := 'FeeAuctionEndEarly'
  Else If Value = AccountDetailEntryCodeType.CreditAuctionEndEarly Then Result                           := 'CreditAuctionEndEarly'
  Else If Value = AccountDetailEntryCodeType.FeeFedExShippingLabel Then Result                           := 'FeeFedExShippingLabel'
  Else If Value = AccountDetailEntryCodeType.CreditFedExShippingLabel Then Result                        := 'CreditFedExShippingLabel'
  Else If Value = AccountDetailEntryCodeType.FeeReturnRefund Then Result                                 := 'FeeReturnRefund'
  Else If Value = AccountDetailEntryCodeType.CreditReturnRefund Then Result                              := 'CreditReturnRefund'
  Else If Value = AccountDetailEntryCodeType.FeeStoresSubscriptionEarlyTermination Then Result           := 'FeeStoresSubscriptionEarlyTermination'
  Else If Value = AccountDetailEntryCodeType.CreditStoresSubscriptionEarlyTermination Then Result        := 'CreditStoresSubscriptionEarlyTermination'
  Else Result                                                                                            := '';
End;

Function enumToStr(Const Value: AccountStateCodeType): String;
Begin
       If Value =AccountStateCodeType.Active Then Result        := 'Active'
  Else If Value = AccountStateCodeType.Pending Then Result  := 'Pending'
  Else If Value = AccountStateCodeType.Inactive  Then Result := 'Inactive'
  Else Result                                               := '';
End;

Function enumToStr(Const Value: MeasurementSystemCodeType): String;
Begin
       If Value =MeasurementSystemCodeType.English  Then Result := 'English'
  Else Result                                              := '';
End;

Function enumToStr(Const Value: SellerPaymentMethodCodeType): String;
Begin
       If Value =SellerPaymentMethodCodeType.NothingOnFile Then Result                           := 'NothingOnFile'
  Else If Value = SellerPaymentMethodCodeType.CreditCard Then Result                         := 'CreditCard'
  Else If Value = SellerPaymentMethodCodeType.PayPal Then Result                             := 'PayPal'
  Else If Value = SellerPaymentMethodCodeType.DirectDebit Then Result                        := 'DirectDebit'
  Else If Value = SellerPaymentMethodCodeType.DirectDebitPendingSignatureMandate  Then Result := 'DirectDebitPendingSignatureMandate'
  Else If Value = SellerPaymentMethodCodeType.EBayDirectPay Then Result                      := 'eBayDirectPay'
  Else If Value = SellerPaymentMethodCodeType.CustomCode Then Result                         := 'CustomCode'
  Else Result                                                                                := '';
End;

Function enumToStr(Const Value: AddressOwnerCodeType): String;
Begin
       If Value =AddressOwnerCodeType.PayPal Then Result    := 'PayPal'
  Else If Value = AddressOwnerCodeType.EBay  Then Result := 'eBay'
  Else Result                                           := '';
End;

Function enumToStr(Const Value: AddressStatusCodeType): String;
Begin
       If Value =AddressStatusCodeType.None Then Result             := 'None'
  Else If Value = AddressStatusCodeType.Confirmed Then Result   := 'Confirmed'
  Else If Value = AddressStatusCodeType.Unconfirmed  Then Result := 'Unconfirmed'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: AddressRecordTypeCodeType): String;
Begin
       If Value =AddressRecordTypeCodeType.Residential Then Result   := 'Residential'
  Else If Value = AddressRecordTypeCodeType.Business  Then Result := 'Business'
  Else Result                                                    := '';
End;

Function enumToStr(Const Value: AdFormatLeadStatusCodeType): String;
Begin
       If Value =AdFormatLeadStatusCodeType.New Then Result            := 'New'
  Else If Value = AdFormatLeadStatusCodeType.Responded  Then Result := 'Responded'
  Else Result                                                      := '';
End;

Function enumToStr(Const Value: StoreCategoryUpdateActionCodeType): String;
Begin
       If Value =StoreCategoryUpdateActionCodeType.Add Then Result         := 'Add'
  Else If Value = StoreCategoryUpdateActionCodeType.Delete  Then Result := 'Delete'
  Else If Value = StoreCategoryUpdateActionCodeType.Move Then Result   := 'Move'
  Else If Value = StoreCategoryUpdateActionCodeType.Rename  Then Result := 'Rename'
  Else Result                                                          := '';
End;

Function enumToStr(Const Value: ModifyActionCodeType): String;
Begin
       If Value =ModifyActionCodeType.Add Then Result         := 'Add'
  Else If Value = ModifyActionCodeType.Delete  Then Result := 'Delete'
  Else If Value = ModifyActionCodeType.Update  Then Result := 'Update'
  Else Result                                             := '';
End;

Function enumToStr(Const Value: AutomatedLeaveFeedbackEventCodeType): String;
Begin
       If Value =AutomatedLeaveFeedbackEventCodeType.PositiveFeedbackReceived  Then Result := 'PositiveFeedbackReceived'
  Else If Value = AutomatedLeaveFeedbackEventCodeType.PaymentReceived Then Result     := 'PaymentReceived'
  Else If Value = AutomatedLeaveFeedbackEventCodeType.None Then Result                := 'None'
  Else Result                                                                         := '';
End;

Function enumToStr(Const Value: SetUserNotesActionCodeType): String;
Begin
       If Value =SetUserNotesActionCodeType.AddOrUpdate  Then Result := 'AddOrUpdate'
  Else If Value = SetUserNotesActionCodeType.Delete  Then Result := 'Delete'
  Else Result                                                   := '';
End;

Function enumToStr(Const Value: PictureUploadPolicyCodeType): String;
Begin
       If Value =PictureUploadPolicyCodeType.Add Then Result              := 'Add'
  Else If Value = PictureUploadPolicyCodeType.ClearAndAdd  Then Result := 'ClearAndAdd'
  Else Result                                                         := '';
End;

Function enumToStr(Const Value: PictureWatermarkCodeType): String;
Begin
       If Value =PictureWatermarkCodeType.User Then Result      := 'User'
  Else If Value = PictureWatermarkCodeType.Icon  Then Result := 'Icon'
  Else Result                                               := '';
End;

Function enumToStr(Const Value: PictureSetCodeType): String;
Begin
       If Value =PictureSetCodeType.Standard Then Result       := 'Standard'
  Else If Value = PictureSetCodeType.Supersize  Then Result := 'Supersize'
  Else If Value = PictureSetCodeType.Large Then Result     := 'Large'
  Else Result                                              := '';
End;
{StrToEnum}
Procedure StrToEnum(Const Value: String ; Var Data : SMSSubscriptionUserStatusCodeType);
Begin
  		 If Value = 'Registered'	 Then Data :=  	 SMSSubscriptionUserStatusCodeType.Registered
  Else If Value = 'Unregistered'	 Then Data :=  	 SMSSubscriptionUserStatusCodeType.Unregistered
  Else If Value = 'Pending'	 Then Data :=  	 SMSSubscriptionUserStatusCodeType.Pending
  Else If Value = 'Failed'	 Then Data :=  	 SMSSubscriptionUserStatusCodeType.Failed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerShippedStatusCodeType);
Begin
       If Value ='Shipped'	 Then Data :=  	 SellingManagerShippedStatusCodeType.Shipped
  Else If Value = 'Unshipped'	 Then Data :=  	 SellingManagerShippedStatusCodeType.Unshipped
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerSearchTypeCodeType);
Begin
       If Value ='BuyerUserID'	 Then Data :=  	 SellingManagerSearchTypeCodeType.BuyerUserID
  Else If Value = 'BuyerEmail'	 Then Data :=  	 SellingManagerSearchTypeCodeType.BuyerEmail
  Else If Value = 'BuyerFullName'	 Then Data :=  	 SellingManagerSearchTypeCodeType.BuyerFullName
  Else If Value = 'ItemID'	 Then Data :=  	 SellingManagerSearchTypeCodeType.ItemID
  Else If Value = 'Title'	 Then Data :=  	 SellingManagerSearchTypeCodeType.Title
  Else If Value = 'ProductID'	 Then Data :=  	 SellingManagerSearchTypeCodeType.ProductID
  Else If Value = 'ProductName'	 Then Data :=  	 SellingManagerSearchTypeCodeType.ProductName
  Else If Value = 'CustomLabel'	 Then Data :=  	 SellingManagerSearchTypeCodeType.CustomLabel
  Else If Value = 'SaleRecordID'	 Then Data :=  	 SellingManagerSearchTypeCodeType.SaleRecordID
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerPaidStatusCodeType);
Begin
       If Value ='Paid'	 Then Data :=  	 SellingManagerPaidStatusCodeType.Paid
  Else If Value = 'PartiallyPaid'	 Then Data :=  	 SellingManagerPaidStatusCodeType.PartiallyPaid
  Else If Value = 'Unpaid'	 Then Data :=  	 SellingManagerPaidStatusCodeType.Unpaid
  Else If Value = 'Pending'	 Then Data :=  	 SellingManagerPaidStatusCodeType.Pending
  Else If Value = 'Refunded'	 Then Data :=  	 SellingManagerPaidStatusCodeType.Refunded
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CheckoutStatusCodeType);
Begin
       If Value ='CheckoutComplete'	 Then Data :=  	 CheckoutStatusCodeType.CheckoutComplete
  Else If Value = 'CheckoutIncomplete'	 Then Data :=  	 CheckoutStatusCodeType.CheckoutIncomplete
  Else If Value = 'BuyerRequestsTotal'	 Then Data :=  	 CheckoutStatusCodeType.BuyerRequestsTotal
  Else If Value = 'SellerResponded'	 Then Data :=  	 CheckoutStatusCodeType.SellerResponded
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : WirelessCarrierIDCodeType);
Begin
       If Value ='Cingular'	 Then Data :=  	 WirelessCarrierIDCodeType.Cingular
  Else If Value = 'TMobile'	 Then Data :=  	 WirelessCarrierIDCodeType.TMobile
  Else If Value = 'Sprint'	 Then Data :=  	 WirelessCarrierIDCodeType.Sprint
  Else If Value = 'Nextel'	 Then Data :=  	 WirelessCarrierIDCodeType.Nextel
  Else If Value = 'Verizon'	 Then Data :=  	 WirelessCarrierIDCodeType.Verizon
  Else If Value = 'CincinnatiBell'	 Then Data :=  	 WirelessCarrierIDCodeType.CincinnatiBell
  Else If Value = 'Dobson'	 Then Data :=  	 WirelessCarrierIDCodeType.Dobson
  Else If Value = 'Alltel'	 Then Data :=  	 WirelessCarrierIDCodeType.Alltel
  Else If Value = 'Leap'	 Then Data :=  	 WirelessCarrierIDCodeType.Leap
  Else If Value = 'USCellular'	 Then Data :=  	 WirelessCarrierIDCodeType.USCellular
  Else If Value = 'Movistar'	 Then Data :=  	 WirelessCarrierIDCodeType.Movistar
  Else If Value = 'Amena'	 Then Data :=  	 WirelessCarrierIDCodeType.Amena
  Else If Value = 'Vodafone'	 Then Data :=  	 WirelessCarrierIDCodeType.Vodafone
  Else If Value = 'ATT'	 Then Data :=  	 WirelessCarrierIDCodeType.ATT
  Else If Value = 'CustomCode'	 Then Data :=  	 WirelessCarrierIDCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : RequiredSellerActionCodeType);
Begin
       If Value ='ResolveeBPCase'	 Then Data :=  	 RequiredSellerActionCodeType.ResolveeBPCase
  Else If Value = 'MarkAsShipped'	 Then Data :=  	 RequiredSellerActionCodeType.MarkAsShipped
  Else If Value = 'ContacteBayCS'	 Then Data :=  	 RequiredSellerActionCodeType.ContacteBayCS
  Else If Value = 'ResolvePPPIcase'	 Then Data :=  	 RequiredSellerActionCodeType.ResolvePPPIcase
  Else If Value = 'SetupPayoutMethod'	 Then Data :=  	 RequiredSellerActionCodeType.SetupPayoutMethod
  Else If Value = 'UpdatePayoutMethod'	 Then Data :=  	 RequiredSellerActionCodeType.UpdatePayoutMethod
  Else If Value = 'None'	 Then Data :=  	 RequiredSellerActionCodeType.None
  Else If Value = 'UploadTrackingInfo'	 Then Data :=  	 RequiredSellerActionCodeType.UploadTrackingInfo
  Else If Value = 'ResolveBuyerMessageInr'	 Then Data :=  	 RequiredSellerActionCodeType.ResolveBuyerMessageInr
  Else If Value = 'ResolveBuyerMessageSnad'	 Then Data :=  	 RequiredSellerActionCodeType.ResolveBuyerMessageSnad
  Else If Value = 'CustomCode'	 Then Data :=  	 RequiredSellerActionCodeType.CustomCode
  Else If Value = 'ResolveReturn'	 Then Data :=  	 RequiredSellerActionCodeType.ResolveReturn
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SMSSubscriptionErrorCodeCodeType);
Begin
       If Value ='SMSAggregatorNotAvailable'	 Then Data :=  	 SMSSubscriptionErrorCodeCodeType.SMSAggregatorNotAvailable
  Else If Value = 'PhoneNumberInvalid'	 Then Data :=  	 SMSSubscriptionErrorCodeCodeType.PhoneNumberInvalid
  Else If Value = 'PhoneNumberChanged'	 Then Data :=  	 SMSSubscriptionErrorCodeCodeType.PhoneNumberChanged
  Else If Value = 'PhoneNumberCarrierChanged'	 Then Data :=  	 SMSSubscriptionErrorCodeCodeType.PhoneNumberCarrierChanged
  Else If Value = 'UserRequestedUnregistration'	 Then Data :=  	 SMSSubscriptionErrorCodeCodeType.UserRequestedUnregistration
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : UnpaidItemStatusTypeCodeType);
Begin
       If Value ='FinalValueFeeDenied'	 Then Data :=  	 UnpaidItemStatusTypeCodeType.FinalValueFeeDenied
  Else If Value = 'FinalValueFeeCredited'	 Then Data :=  	 UnpaidItemStatusTypeCodeType.FinalValueFeeCredited
  Else If Value = 'FinalValueFeeEligible'	 Then Data :=  	 UnpaidItemStatusTypeCodeType.FinalValueFeeEligible
  Else If Value = 'AwaitingSellerResponse'	 Then Data :=  	 UnpaidItemStatusTypeCodeType.AwaitingSellerResponse
  Else If Value = 'AwaitingBuyerResponse'	 Then Data :=  	 UnpaidItemStatusTypeCodeType.AwaitingBuyerResponse
  Else If Value = 'UnpaidItemFiled'	 Then Data :=  	 UnpaidItemStatusTypeCodeType.UnpaidItemFiled
  Else If Value = 'UnpaidItemEligible'	 Then Data :=  	 UnpaidItemStatusTypeCodeType.UnpaidItemEligible
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShippingRateTypeCodeType);
Begin
       If Value ='OnDemand'	 Then Data :=  	 ShippingRateTypeCodeType.OnDemand
  Else If Value = 'DailyPickup'	 Then Data :=  	 ShippingRateTypeCodeType.DailyPickup
  Else If Value = 'StandardList'	 Then Data :=  	 ShippingRateTypeCodeType.StandardList
  Else If Value = 'Counter'	 Then Data :=  	 ShippingRateTypeCodeType.Counter
  Else If Value = 'Discounted'	 Then Data :=  	 ShippingRateTypeCodeType.Discounted
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShippingTypeCodeType);
Begin
       If Value ='Flat'	 Then Data :=  	 ShippingTypeCodeType.Flat
  Else If Value = 'Calculated'	 Then Data :=  	 ShippingTypeCodeType.Calculated
  Else If Value = 'Freight'	 Then Data :=  	 ShippingTypeCodeType.Freight
  Else If Value = 'Free'	 Then Data :=  	 ShippingTypeCodeType.Free
  Else If Value = 'NotSpecified'	 Then Data :=  	 ShippingTypeCodeType.NotSpecified
  Else If Value = 'FlatDomesticCalculatedInternational'	 Then Data :=  	 ShippingTypeCodeType.FlatDomesticCalculatedInternational
  Else If Value = 'CalculatedDomesticFlatInternational'	 Then Data :=  	 ShippingTypeCodeType.CalculatedDomesticFlatInternational
  Else If Value = 'FreightFlat'	 Then Data :=  	 ShippingTypeCodeType.FreightFlat
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShippingCarrierCodeType);
Begin
       If Value ='UPS'	 Then Data :=  	 ShippingCarrierCodeType.UPS
  Else If Value = 'USPS'	 Then Data :=  	 ShippingCarrierCodeType.USPS
  Else If Value = 'FedEx'	 Then Data :=  	 ShippingCarrierCodeType.FedEx
  Else If Value = 'DeutschePost'	 Then Data :=  	 ShippingCarrierCodeType.DeutschePost
  Else If Value = 'DHL'	 Then Data :=  	 ShippingCarrierCodeType.DHL
  Else If Value = 'Hermes'	 Then Data :=  	 ShippingCarrierCodeType.Hermes
  Else If Value = 'iLoxx'	 Then Data :=  	 ShippingCarrierCodeType.ILoxx
  Else If Value = 'Other'	 Then Data :=  	 ShippingCarrierCodeType.Other
  Else If Value = 'ColiposteDomestic'	 Then Data :=  	 ShippingCarrierCodeType.ColiposteDomestic
  Else If Value = 'ColiposteInternational'	 Then Data :=  	 ShippingCarrierCodeType.ColiposteInternational
  Else If Value = 'Chronopost'	 Then Data :=  	 ShippingCarrierCodeType.Chronopost
  Else If Value = 'Correos'	 Then Data :=  	 ShippingCarrierCodeType.Correos
  Else If Value = 'Seur'	 Then Data :=  	 ShippingCarrierCodeType.Seur
  Else If Value = 'Nacex'	 Then Data :=  	 ShippingCarrierCodeType.Nacex
(*  Else If Value = 'GlobalShipping_MultiCarrier'	 Then Data :=  	 ShippingCarrierCodeType.GlobalShipping_MultiCarrier
  Else If Value = 'CustomCode'	 Then Data :=  	 ShippingCarrierCodeType.CustomCode*)
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShippingServiceCodeType);
Begin
       If Value ='UPSGround'	 Then Data :=  	 ShippingServiceCodeType.UPSGround
  Else If Value = 'UPS3rdDay'	 Then Data :=  	 ShippingServiceCodeType.UPS3rdDay
  Else If Value = 'UPS2ndDay'	 Then Data :=  	 ShippingServiceCodeType.UPS2ndDay
  Else If Value = 'UPSNextDay'	 Then Data :=  	 ShippingServiceCodeType.UPSNextDay
  Else If Value = 'USPSPriority'	 Then Data :=  	 ShippingServiceCodeType.USPSPriority
  Else If Value = 'USPSParcel'	 Then Data :=  	 ShippingServiceCodeType.USPSParcel
  Else If Value = 'USPSStandardPost'	 Then Data :=  	 ShippingServiceCodeType.USPSStandardPost
  Else If Value = 'USPSMedia'	 Then Data :=  	 ShippingServiceCodeType.USPSMedia
  Else If Value = 'USPSFirstClass'	 Then Data :=  	 ShippingServiceCodeType.USPSFirstClass
  Else If Value = 'ShippingMethodStandard'	 Then Data :=  	 ShippingServiceCodeType.ShippingMethodStandard
  Else If Value = 'ShippingMethodExpress'	 Then Data :=  	 ShippingServiceCodeType.ShippingMethodExpress
  Else If Value = 'USPSExpressMail'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMail
  Else If Value = 'UPSNextDayAir'	 Then Data :=  	 ShippingServiceCodeType.UPSNextDayAir
  Else If Value = 'UPS2DayAirAM'	 Then Data :=  	 ShippingServiceCodeType.UPS2DayAirAM
  Else If Value = 'USPSExpressMailFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailFlatRateEnvelope
  Else If Value = 'USPSExpressMailPaddedFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailPaddedFlatRateEnvelope
  Else If Value = 'USPSPriorityMailFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailFlatRateEnvelope
  Else If Value = 'USPSPriorityMailSmallFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailSmallFlatRateBox
  Else If Value = 'USPSPriorityMailFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailFlatRateBox
  Else If Value = 'USPSPriorityMailLargeFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailLargeFlatRateBox
  Else If Value = 'USPSPriorityMailPaddedFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailPaddedFlatRateEnvelope
  Else If Value = 'USPSPriorityMailLegalFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailLegalFlatRateEnvelope
  Else If Value = 'USPSExpressMailLegalFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailLegalFlatRateEnvelope
  Else If Value = 'USPSPriorityMailRegionalBoxA'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailRegionalBoxA
  Else If Value = 'USPSPriorityMailRegionalBoxB'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailRegionalBoxB
  Else If Value = 'USPSPriorityMailRegionalBoxC'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailRegionalBoxC
  Else If Value = 'USPSExpressMailFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailFlatRateBox
  Else If Value = 'Other'	 Then Data :=  	 ShippingServiceCodeType.Other
  Else If Value = 'LocalDelivery'	 Then Data :=  	 ShippingServiceCodeType.LocalDelivery
  Else If Value = 'NotSelected'	 Then Data :=  	 ShippingServiceCodeType.NotSelected
  Else If Value = 'InternationalNotSelected'	 Then Data :=  	 ShippingServiceCodeType.InternationalNotSelected
  Else If Value = 'StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.StandardInternational
  Else If Value = 'ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.ExpeditedInternational
  Else If Value = 'USPSGlobalExpress'	 Then Data :=  	 ShippingServiceCodeType.USPSGlobalExpress
  Else If Value = 'USPSGlobalPriority'	 Then Data :=  	 ShippingServiceCodeType.USPSGlobalPriority
  Else If Value = 'USPSEconomyParcel'	 Then Data :=  	 ShippingServiceCodeType.USPSEconomyParcel
  Else If Value = 'USPSEconomyLetter'	 Then Data :=  	 ShippingServiceCodeType.USPSEconomyLetter
  Else If Value = 'USPSAirmailLetter'	 Then Data :=  	 ShippingServiceCodeType.USPSAirmailLetter
  Else If Value = 'USPSAirmailParcel'	 Then Data :=  	 ShippingServiceCodeType.USPSAirmailParcel
  Else If Value = 'UPSWorldWideExpressPlus'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldWideExpressPlus
  Else If Value = 'UPSWorldWideExpress'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldWideExpress
  Else If Value = 'UPSWorldWideExpedited'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldWideExpedited
  Else If Value = 'UPSWorldwideSaver'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldwideSaver
  Else If Value = 'UPSStandardToCanada'	 Then Data :=  	 ShippingServiceCodeType.UPSStandardToCanada
  Else If Value = 'USPSExpressMailInternationalFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailInternationalFlatRateEnvelope
  Else If Value = 'USPSExpressMailInternationalPaddedFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailInternationalPaddedFlatRateEnvelope
  Else If Value = 'USPSPriorityMailInternationalFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailInternationalFlatRateEnvelope
  Else If Value = 'USPSPriorityMailInternationalSmallFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailInternationalSmallFlatRateBox
  Else If Value = 'USPSPriorityMailInternationalFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailInternationalFlatRateBox
  Else If Value = 'USPSPriorityMailInternationalLargeFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailInternationalLargeFlatRateBox
  Else If Value = 'USPSPriorityMailInternationalPaddedFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailInternationalPaddedFlatRateEnvelope
  Else If Value = 'USPSPriorityMailInternationalLegalFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailInternationalLegalFlatRateEnvelope
  Else If Value = 'USPSExpressMailInternationalLegalFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailInternationalLegalFlatRateEnvelope
  Else If Value = 'USPSExpressMailInternationalFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailInternationalFlatRateBox
  Else If Value = 'OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.OtherInternational
  Else If Value = 'AT_StandardDispatch'	 Then Data :=  	 ShippingServiceCodeType.AT_StandardDispatch
  Else If Value = 'AT_InsuredDispatch'	 Then Data :=  	 ShippingServiceCodeType.AT_InsuredDispatch
  Else If Value = 'AT_Writing'	 Then Data :=  	 ShippingServiceCodeType.AT_Writing
  Else If Value = 'AT_COD'	 Then Data :=  	 ShippingServiceCodeType.AT_COD
  Else If Value = 'AT_ExpressOrCourier'	 Then Data :=  	 ShippingServiceCodeType.AT_ExpressOrCourier
  Else If Value = 'AT_InsuredExpressOrCourier'	 Then Data :=  	 ShippingServiceCodeType.AT_InsuredExpressOrCourier
  Else If Value = 'AT_SpecialDispatch'	 Then Data :=  	 ShippingServiceCodeType.AT_SpecialDispatch
  Else If Value = 'AT_InsuredSpecialDispatch'	 Then Data :=  	 ShippingServiceCodeType.AT_InsuredSpecialDispatch
  Else If Value = 'AT_Sonstige'	 Then Data :=  	 ShippingServiceCodeType.AT_Sonstige
  Else If Value = 'AT_UnversicherterVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_UnversicherterVersandInternational
  Else If Value = 'AT_VersicherterVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_VersicherterVersandInternational
  Else If Value = 'AT_SonstigerVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_SonstigerVersandInternational
  Else If Value = 'AT_UnversicherterExpressVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_UnversicherterExpressVersandInternational
  Else If Value = 'AT_VersicherterExpressVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_VersicherterExpressVersandInternational
  Else If Value = 'AT_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.AT_EconomyDeliveryFromAbroad
  Else If Value = 'AT_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.AT_StandardDeliveryFromAbroad
  Else If Value = 'AT_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.AT_ExpressDeliveryFromAbroad
  Else If Value = 'AT_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.AT_TrackedDeliveryFromAbroad
  Else If Value = 'AU_Regular'	 Then Data :=  	 ShippingServiceCodeType.AU_Regular
  Else If Value = 'AU_Express'	 Then Data :=  	 ShippingServiceCodeType.AU_Express
  Else If Value = 'AU_Registered'	 Then Data :=  	 ShippingServiceCodeType.AU_Registered
  Else If Value = 'AU_Courier'	 Then Data :=  	 ShippingServiceCodeType.AU_Courier
  Else If Value = 'AU_Other'	 Then Data :=  	 ShippingServiceCodeType.AU_Other
  Else If Value = 'AU_EMSInternationalCourierParcels'	 Then Data :=  	 ShippingServiceCodeType.AU_EMSInternationalCourierParcels
  Else If Value = 'AU_EMSInternationalCourierDocuments'	 Then Data :=  	 ShippingServiceCodeType.AU_EMSInternationalCourierDocuments
  Else If Value = 'AU_ExpressPostInternationalDocuments'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpressPostInternationalDocuments
  Else If Value = 'AU_AirMailInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_AirMailInternational
  Else If Value = 'AU_EconomyAirInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_EconomyAirInternational
  Else If Value = 'AU_SeaMailInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_SeaMailInternational
  Else If Value = 'AU_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_StandardInternational
  Else If Value = 'AU_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpeditedInternational
  Else If Value = 'AU_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_OtherInternational
  Else If Value = 'AU_AusPostRegisteredPostInternationalPaddedBag1kg'	 Then Data :=  	 ShippingServiceCodeType.AU_AusPostRegisteredPostInternationalPaddedBag1kg
  Else If Value = 'AU_AusPostRegisteredPostInternationalPaddedBag500g'	 Then Data :=  	 ShippingServiceCodeType.AU_AusPostRegisteredPostInternationalPaddedBag500g
  Else If Value = 'AU_AusPostRegisteredPostInternationalParcel'	 Then Data :=  	 ShippingServiceCodeType.AU_AusPostRegisteredPostInternationalParcel
  Else If Value = 'AU_ExpeditedDeliveryFromOutsideAU'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpeditedDeliveryFromOutsideAU
  Else If Value = 'AU_EconomyDeliveryFromOutsideAU'	 Then Data :=  	 ShippingServiceCodeType.AU_EconomyDeliveryFromOutsideAU
  Else If Value = 'AU_StandardDeliveryFromOutsideAU'	 Then Data :=  	 ShippingServiceCodeType.AU_StandardDeliveryFromOutsideAU
  Else If Value = 'AU_AustralianAirExpressMetro15kg'	 Then Data :=  	 ShippingServiceCodeType.AU_AustralianAirExpressMetro15kg
  Else If Value = 'AU_AustralianAirExpressFlatRate5kg'	 Then Data :=  	 ShippingServiceCodeType.AU_AustralianAirExpressFlatRate5kg
  Else If Value = 'AU_AustralianAirExpressFlatRate3kg'	 Then Data :=  	 ShippingServiceCodeType.AU_AustralianAirExpressFlatRate3kg
  Else If Value = 'AU_AustralianAirExpressFlatRate1kg'	 Then Data :=  	 ShippingServiceCodeType.AU_AustralianAirExpressFlatRate1kg
  Else If Value = 'AU_ExpressDelivery'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpressDelivery
  Else If Value = 'AU_StandardDelivery'	 Then Data :=  	 ShippingServiceCodeType.AU_StandardDelivery
  Else If Value = 'AU_eBayAusPost3kgFlatRateSatchel'	 Then Data :=  	 ShippingServiceCodeType.AU_eBayAusPost3kgFlatRateSatchel
  Else If Value = 'AU_eBayAusPost500gFlatRateSatchel'	 Then Data :=  	 ShippingServiceCodeType.AU_eBayAusPost500gFlatRateSatchel
  Else If Value = 'AU_Freight'	 Then Data :=  	 ShippingServiceCodeType.AU_Freight
  Else If Value = 'BEFR_StandardDelivery'	 Then Data :=  	 ShippingServiceCodeType.BEFR_StandardDelivery
  Else If Value = 'BEFR_PriorityDelivery'	 Then Data :=  	 ShippingServiceCodeType.BEFR_PriorityDelivery
  Else If Value = 'BEFR_ParcelPost'	 Then Data :=  	 ShippingServiceCodeType.BEFR_ParcelPost
  Else If Value = 'BEFR_RegisteredMail'	 Then Data :=  	 ShippingServiceCodeType.BEFR_RegisteredMail
  Else If Value = 'BEFR_Other'	 Then Data :=  	 ShippingServiceCodeType.BEFR_Other
  Else If Value = 'BEFR_DePostInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_DePostInternational
  Else If Value = 'BEFR_UPSInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_UPSInternational
  Else If Value = 'BEFR_FedExInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_FedExInternational
  Else If Value = 'BEFR_DHLInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_DHLInternational
  Else If Value = 'BEFR_TPGPostTNTInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_TPGPostTNTInternational
  Else If Value = 'BEFR_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_StandardInternational
  Else If Value = 'BEFR_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_ExpeditedInternational
  Else If Value = 'BEFR_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_OtherInternational
  Else If Value = 'BEFR_LaPosteInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteInternational
  Else If Value = 'BEFR_LaPosteStandardShipping'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteStandardShipping
  Else If Value = 'BEFR_LaPosteCertifiedShipping'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteCertifiedShipping
  Else If Value = 'BEFR_LaPosteTaxipostLLS'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteTaxipostLLS
  Else If Value = 'BEFR_LaPosteTaxipost24h'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteTaxipost24h
  Else If Value = 'BEFR_LaPosteTaxipostSecur'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteTaxipostSecur
  Else If Value = 'BEFR_PostInternationalStandard'	 Then Data :=  	 ShippingServiceCodeType.BEFR_PostInternationalStandard
  Else If Value = 'BEFR_PostInternationalRegistered'	 Then Data :=  	 ShippingServiceCodeType.BEFR_PostInternationalRegistered
  Else If Value = 'BEFR_TNTInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_TNTInternational
  Else If Value = 'BEFR_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BEFR_EconomyDeliveryFromAbroad
  Else If Value = 'BEFR_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BEFR_StandardDeliveryFromAbroad
  Else If Value = 'BEFR_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BEFR_ExpressDeliveryFromAbroad
  Else If Value = 'BEFR_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BEFR_TrackedDeliveryFromAbroad
  Else If Value = 'BENL_StandardDelivery'	 Then Data :=  	 ShippingServiceCodeType.BENL_StandardDelivery
  Else If Value = 'BENL_PriorityDelivery'	 Then Data :=  	 ShippingServiceCodeType.BENL_PriorityDelivery
  Else If Value = 'BENL_ParcelPost'	 Then Data :=  	 ShippingServiceCodeType.BENL_ParcelPost
  Else If Value = 'BENL_RegisteredMail'	 Then Data :=  	 ShippingServiceCodeType.BENL_RegisteredMail
  Else If Value = 'BENL_Other'	 Then Data :=  	 ShippingServiceCodeType.BENL_Other
  Else If Value = 'BENL_DePostInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostInternational
  Else If Value = 'BENL_UPSInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_UPSInternational
  Else If Value = 'BENL_FedExInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_FedExInternational
  Else If Value = 'BENL_DHLInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_DHLInternational
  Else If Value = 'BENL_TPGPostTNTInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_TPGPostTNTInternational
  Else If Value = 'BENL_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_StandardInternational
  Else If Value = 'BENL_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_ExpeditedInternational
  Else If Value = 'BENL_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_OtherInternational
  Else If Value = 'BENL_LaPosteInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_LaPosteInternational
  Else If Value = 'BENL_DePostStandardShipping'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostStandardShipping
  Else If Value = 'BENL_DePostCertifiedShipping'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostCertifiedShipping
  Else If Value = 'BENL_DePostTaxipostLLS'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostTaxipostLLS
  Else If Value = 'BENL_DePostTaxipost24h'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostTaxipost24h
  Else If Value = 'BENL_DePostTaxipostSecur'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostTaxipostSecur
  Else If Value = 'BENL_OtherShippingMethods'	 Then Data :=  	 ShippingServiceCodeType.BENL_OtherShippingMethods
  Else If Value = 'BENL_PostInternationalStandard'	 Then Data :=  	 ShippingServiceCodeType.BENL_PostInternationalStandard
  Else If Value = 'BENL_PostInternationalRegistered'	 Then Data :=  	 ShippingServiceCodeType.BENL_PostInternationalRegistered
  Else If Value = 'BENL_TNTInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_TNTInternational
  Else If Value = 'BENL_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BENL_EconomyDeliveryFromAbroad
  Else If Value = 'BENL_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BENL_StandardDeliveryFromAbroad
  Else If Value = 'BENL_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BENL_ExpressDeliveryFromAbroad
  Else If Value = 'BENL_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.BENL_TrackedDeliveryFromAbroad
  Else If Value = 'CA_StandardDelivery'	 Then Data :=  	 ShippingServiceCodeType.CA_StandardDelivery
  Else If Value = 'CA_ExpeditedDelivery'	 Then Data :=  	 ShippingServiceCodeType.CA_ExpeditedDelivery
  Else If Value = 'CA_PostLettermail'	 Then Data :=  	 ShippingServiceCodeType.CA_PostLettermail
  Else If Value = 'CA_PostRegularParcel'	 Then Data :=  	 ShippingServiceCodeType.CA_PostRegularParcel
  Else If Value = 'CA_PostExpeditedParcel'	 Then Data :=  	 ShippingServiceCodeType.CA_PostExpeditedParcel
  Else If Value = 'CA_PostXpresspost'	 Then Data :=  	 ShippingServiceCodeType.CA_PostXpresspost
  Else If Value = 'CA_PostPriorityCourier'	 Then Data :=  	 ShippingServiceCodeType.CA_PostPriorityCourier
  Else If Value = 'CanadaPostExpeditedFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.CanadaPostExpeditedFlatRateBox
  Else If Value = 'CA_PostExpeditedFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.CA_PostExpeditedFlatRateBox
  Else If Value = 'CA_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_StandardInternational
  Else If Value = 'CA_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_ExpeditedInternational
  Else If Value = 'CA_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_OtherInternational
  Else If Value = 'CA_PostExpeditedParcelUSA'	 Then Data :=  	 ShippingServiceCodeType.CA_PostExpeditedParcelUSA
  Else If Value = 'CA_PostSmallPacketsUSA'	 Then Data :=  	 ShippingServiceCodeType.CA_PostSmallPacketsUSA
  Else If Value = 'CA_PostXpresspostUSA'	 Then Data :=  	 ShippingServiceCodeType.CA_PostXpresspostUSA
  Else If Value = 'CA_PostXpresspostInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_PostXpresspostInternational
  Else If Value = 'CA_PostInternationalParcelSurface'	 Then Data :=  	 ShippingServiceCodeType.CA_PostInternationalParcelSurface
  Else If Value = 'CA_PostInternationalParcelAir'	 Then Data :=  	 ShippingServiceCodeType.CA_PostInternationalParcelAir
  Else If Value = 'CA_SmallPacketsInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_SmallPacketsInternational
  Else If Value = 'CA_PurolatorInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_PurolatorInternational
  Else If Value = 'CA_PostSmallPacketsUSAGround'	 Then Data :=  	 ShippingServiceCodeType.CA_PostSmallPacketsUSAGround
  Else If Value = 'CA_PostSmallPacketsUSAAir'	 Then Data :=  	 ShippingServiceCodeType.CA_PostSmallPacketsUSAAir
  Else If Value = 'CA_SmallPacketsInternationalGround'	 Then Data :=  	 ShippingServiceCodeType.CA_SmallPacketsInternationalGround
  Else If Value = 'CA_SmallPacketsInternationalAir'	 Then Data :=  	 ShippingServiceCodeType.CA_SmallPacketsInternationalAir
  Else If Value = 'CA_PostUSALetterPost'	 Then Data :=  	 ShippingServiceCodeType.CA_PostUSALetterPost
  Else If Value = 'CA_PostInternationalLetterPost'	 Then Data :=  	 ShippingServiceCodeType.CA_PostInternationalLetterPost
  Else If Value = 'CA_PostExpeditedFlatRateBoxUSA'	 Then Data :=  	 ShippingServiceCodeType.CA_PostExpeditedFlatRateBoxUSA
  Else If Value = 'CA_UPSExpressCanada'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSExpressCanada
  Else If Value = 'CA_UPSExpressSaverCanada'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSExpressSaverCanada
  Else If Value = 'CA_UPSExpeditedCanada'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSExpeditedCanada
  Else If Value = 'CA_UPSStandardCanada'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSStandardCanada
  Else If Value = 'CA_UPSExpressUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSExpressUnitedStates
  Else If Value = 'CA_UPSExpeditedUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSExpeditedUnitedStates
  Else If Value = 'CA_UPS3DaySelectUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CA_UPS3DaySelectUnitedStates
  Else If Value = 'CA_UPSStandardUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSStandardUnitedStates
  Else If Value = 'CA_UPSWorldWideExpress'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSWorldWideExpress
  Else If Value = 'CA_UPSWorldWideExpedited'	 Then Data :=  	 ShippingServiceCodeType.CA_UPSWorldWideExpedited
  Else If Value = 'CA_PriorityWorldwide'	 Then Data :=  	 ShippingServiceCodeType.CA_PriorityWorldwide
  Else If Value = 'CanadaPostExpeditedFlatRateBoxUSA'	 Then Data :=  	 ShippingServiceCodeType.CanadaPostExpeditedFlatRateBoxUSA
  Else If Value = 'CA_PostTrackedPacketsUSA'	 Then Data :=  	 ShippingServiceCodeType.CA_PostTrackedPacketsUSA
  Else If Value = 'CA_PostTrackedPacketsInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_PostTrackedPacketsInternational
  Else If Value = 'CA_Freight'	 Then Data :=  	 ShippingServiceCodeType.CA_Freight
  Else If Value = 'CH_StandardDispatchAPost'	 Then Data :=  	 ShippingServiceCodeType.CH_StandardDispatchAPost
  Else If Value = 'CH_StandardDispatchBPost'	 Then Data :=  	 ShippingServiceCodeType.CH_StandardDispatchBPost
  Else If Value = 'CH_InsuredDispatch'	 Then Data :=  	 ShippingServiceCodeType.CH_InsuredDispatch
  Else If Value = 'CH_Writing'	 Then Data :=  	 ShippingServiceCodeType.CH_Writing
  Else If Value = 'CH_COD'	 Then Data :=  	 ShippingServiceCodeType.CH_COD
  Else If Value = 'CH_ExpressOrCourier'	 Then Data :=  	 ShippingServiceCodeType.CH_ExpressOrCourier
  Else If Value = 'CH_InsuredExpressOrCourier'	 Then Data :=  	 ShippingServiceCodeType.CH_InsuredExpressOrCourier
  Else If Value = 'CH_SpecialDispatch'	 Then Data :=  	 ShippingServiceCodeType.CH_SpecialDispatch
  Else If Value = 'CH_InsuredSpecialDispatch'	 Then Data :=  	 ShippingServiceCodeType.CH_InsuredSpecialDispatch
  Else If Value = 'CH_Sonstige'	 Then Data :=  	 ShippingServiceCodeType.CH_Sonstige
  Else If Value = 'CH_SonstigerVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_SonstigerVersandInternational
  Else If Value = 'CH_EconomySendungenInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_EconomySendungenInternational
  Else If Value = 'CH_PrioritySendungenInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_PrioritySendungenInternational
  Else If Value = 'CH_UrgentSendungenInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_UrgentSendungenInternational
  Else If Value = 'CH_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.CH_EconomyDeliveryFromAbroad
  Else If Value = 'CH_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.CH_StandardDeliveryFromAbroad
  Else If Value = 'CH_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.CH_ExpressDeliveryFromAbroad
  Else If Value = 'CH_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.CH_TrackedDeliveryFromAbroad
  Else If Value = 'CN_PersonalDelivery'	 Then Data :=  	 ShippingServiceCodeType.CN_PersonalDelivery
  Else If Value = 'CN_RegularPackage'	 Then Data :=  	 ShippingServiceCodeType.CN_RegularPackage
  Else If Value = 'CN_DeliveryCompanyExpress'	 Then Data :=  	 ShippingServiceCodeType.CN_DeliveryCompanyExpress
  Else If Value = 'CN_PostOfficeExpress'	 Then Data :=  	 ShippingServiceCodeType.CN_PostOfficeExpress
  Else If Value = 'CN_Others'	 Then Data :=  	 ShippingServiceCodeType.CN_Others
  Else If Value = 'CN_FastPostOffice'	 Then Data :=  	 ShippingServiceCodeType.CN_FastPostOffice
  Else If Value = 'CN_ExpressDeliverySameCity'	 Then Data :=  	 ShippingServiceCodeType.CN_ExpressDeliverySameCity
  Else If Value = 'CN_ExpressDeliveryOtherCities'	 Then Data :=  	 ShippingServiceCodeType.CN_ExpressDeliveryOtherCities
  Else If Value = 'CN_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_StandardInternational
  Else If Value = 'CN_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_ExpeditedInternational
  Else If Value = 'CN_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_OtherInternational
  Else If Value = 'CN_CODInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_CODInternational
  Else If Value = 'CN_StandardMailingInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_StandardMailingInternational
  Else If Value = 'CN_RegularLogisticsInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_RegularLogisticsInternational
  Else If Value = 'CN_EMSInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_EMSInternational
  Else If Value = 'CN_OthersInternational'	 Then Data :=  	 ShippingServiceCodeType.CN_OthersInternational
  Else If Value = 'DE_StandardDispatch'	 Then Data :=  	 ShippingServiceCodeType.DE_StandardDispatch
  Else If Value = 'DE_InsuredDispatch'	 Then Data :=  	 ShippingServiceCodeType.DE_InsuredDispatch
  Else If Value = 'DE_Writing'	 Then Data :=  	 ShippingServiceCodeType.DE_Writing
  Else If Value = 'DE_COD'	 Then Data :=  	 ShippingServiceCodeType.DE_COD
  Else If Value = 'DE_ExpressOrCourier'	 Then Data :=  	 ShippingServiceCodeType.DE_ExpressOrCourier
  Else If Value = 'DE_InsuredExpressOrCourier'	 Then Data :=  	 ShippingServiceCodeType.DE_InsuredExpressOrCourier
  Else If Value = 'DE_SpecialDispatch'	 Then Data :=  	 ShippingServiceCodeType.DE_SpecialDispatch
  Else If Value = 'DE_InsuredSpecialDispatch'	 Then Data :=  	 ShippingServiceCodeType.DE_InsuredSpecialDispatch
  Else If Value = 'DE_UnversicherterVersand'	 Then Data :=  	 ShippingServiceCodeType.DE_UnversicherterVersand
  Else If Value = 'DE_DeutschePostBrief'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostBrief
  Else If Value = 'DE_eBayDHLPaket24x7'	 Then Data :=  	 ShippingServiceCodeType.DE_eBayDHLPaket24x7
  Else If Value = 'DE_DHLPostpaket'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPostpaket
  Else If Value = 'DE_DHLPackchen'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPackchen
  Else If Value = 'DE_DeutschePostWarensendung'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostWarensendung
  Else If Value = 'DE_DeutschePostBuchersendung'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostBuchersendung
  Else If Value = 'DE_HermesPaketUnversichert'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketUnversichert
  Else If Value = 'DE_HermesPaketVersichert'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketVersichert
  Else If Value = 'DE_IloxxTransportXXL'	 Then Data :=  	 ShippingServiceCodeType.DE_IloxxTransportXXL
  Else If Value = 'DE_IloxxUbernachtExpress'	 Then Data :=  	 ShippingServiceCodeType.DE_IloxxUbernachtExpress
  Else If Value = 'DE_IloxxStandard'	 Then Data :=  	 ShippingServiceCodeType.DE_IloxxStandard
  Else If Value = 'DE_Sonstige'	 Then Data :=  	 ShippingServiceCodeType.DE_Sonstige
  Else If Value = 'DE_UnversicherterVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_UnversicherterVersandInternational
  Else If Value = 'DE_VersicherterVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_VersicherterVersandInternational
  Else If Value = 'DE_DHLPostpaketInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPostpaketInternational
  Else If Value = 'DE_DHLPackchenInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPackchenInternational
  Else If Value = 'DE_SonstigerVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_SonstigerVersandInternational
  Else If Value = 'DE_UnversicherterExpressVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_UnversicherterExpressVersandInternational
  Else If Value = 'DE_VersicherterExpressVersandInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_VersicherterExpressVersandInternational
  Else If Value = 'DE_DeutschePostBriefLandInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostBriefLandInternational
  Else If Value = 'DE_DeutschePostBriefLuftInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostBriefLuftInternational
  Else If Value = 'DE_IloxxEuropaInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_IloxxEuropaInternational
  Else If Value = 'DE_IloxxWorldWideInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_IloxxWorldWideInternational
  Else If Value = 'DE_Paket'	 Then Data :=  	 ShippingServiceCodeType.DE_Paket
  Else If Value = 'DE_Express'	 Then Data :=  	 ShippingServiceCodeType.DE_Express
  Else If Value = 'DE_DHLPaket'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPaket
  Else If Value = 'DE_DPBuecherWarensendung'	 Then Data :=  	 ShippingServiceCodeType.DE_DPBuecherWarensendung
  Else If Value = 'DE_HermesPaket'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaket
  Else If Value = 'DE_IloxxTransport'	 Then Data :=  	 ShippingServiceCodeType.DE_IloxxTransport
  Else If Value = 'DE_SonstigeDomestic'	 Then Data :=  	 ShippingServiceCodeType.DE_SonstigeDomestic
  Else If Value = 'DE_Einschreiben'	 Then Data :=  	 ShippingServiceCodeType.DE_Einschreiben
  Else If Value = 'DE_Nachname'	 Then Data :=  	 ShippingServiceCodeType.DE_Nachname
  Else If Value = 'DE_SpecialDelivery'	 Then Data :=  	 ShippingServiceCodeType.DE_SpecialDelivery
  Else If Value = 'DE_UPS'	 Then Data :=  	 ShippingServiceCodeType.DE_UPS
  Else If Value = 'DE_DPD'	 Then Data :=  	 ShippingServiceCodeType.DE_DPD
  Else If Value = 'DE_GLS'	 Then Data :=  	 ShippingServiceCodeType.DE_GLS
  Else If Value = 'DE_PaketInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_PaketInternational
  Else If Value = 'DE_DHLPaketInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPaketInternational
  Else If Value = 'DE_SonstigeInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_SonstigeInternational
  Else If Value = 'DE_ExpressInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_ExpressInternational
  Else If Value = 'DE_DPBriefInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DPBriefInternational
  Else If Value = 'DE_IloxxTransportInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_IloxxTransportInternational
  Else If Value = 'DE_HermesPaketInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketInternational
  Else If Value = 'DE_UPSInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_UPSInternational
  Else If Value = 'DE_DPDInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DPDInternational
  Else If Value = 'DE_GLSInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_GLSInternational
  Else If Value = 'DE_eBayHermesPaketShop2ShopKaeufer'	 Then Data :=  	 ShippingServiceCodeType.DE_eBayHermesPaketShop2ShopKaeufer
  Else If Value = 'DE_HermesPaketShop2ShopKaeufer'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketShop2ShopKaeufer
  Else If Value = 'DE_eBayHermesPaketShop2Shop'	 Then Data :=  	 ShippingServiceCodeType.DE_eBayHermesPaketShop2Shop
  Else If Value = 'DE_HermesPaketShop2Shop'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketShop2Shop
  Else If Value = 'DE_HermesPaketSperrgut'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketSperrgut
  Else If Value = 'DE_eBayHermesPaketSperrgutShop2Shop'	 Then Data :=  	 ShippingServiceCodeType.DE_eBayHermesPaketSperrgutShop2Shop
  Else If Value = 'DE_DHLPaeckchenPackstation'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPaeckchenPackstation
  Else If Value = 'DE_DHLPaketPackstation'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLPaketPackstation
  Else If Value = 'DE_eBayDHLPaeckchen'	 Then Data :=  	 ShippingServiceCodeType.DE_eBayDHLPaeckchen
  Else If Value = 'DE_DHLStarPaeckchen'	 Then Data :=  	 ShippingServiceCodeType.DE_DHLStarPaeckchen
  Else If Value = 'DE_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.DE_TrackedDeliveryFromAbroad
  Else If Value = 'ES_CartasNacionalesHasta20'	 Then Data :=  	 ShippingServiceCodeType.ES_CartasNacionalesHasta20
  Else If Value = 'ES_CartasNacionalesDeMas20'	 Then Data :=  	 ShippingServiceCodeType.ES_CartasNacionalesDeMas20
  Else If Value = 'ES_CartasInternacionalesHasta20'	 Then Data :=  	 ShippingServiceCodeType.ES_CartasInternacionalesHasta20
  Else If Value = 'ES_CartasInternacionalesDeMas20'	 Then Data :=  	 ShippingServiceCodeType.ES_CartasInternacionalesDeMas20
  Else If Value = 'ES_PaqueteAzulHasta2kg'	 Then Data :=  	 ShippingServiceCodeType.ES_PaqueteAzulHasta2kg
  Else If Value = 'ES_PaqueteAzulDeMas2kg'	 Then Data :=  	 ShippingServiceCodeType.ES_PaqueteAzulDeMas2kg
  Else If Value = 'ES_PaqueteInternacionalEconomico'	 Then Data :=  	 ShippingServiceCodeType.ES_PaqueteInternacionalEconomico
  Else If Value = 'ES_Urgente'	 Then Data :=  	 ShippingServiceCodeType.ES_Urgente
  Else If Value = 'ES_Otros'	 Then Data :=  	 ShippingServiceCodeType.ES_Otros
  Else If Value = 'ES_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.ES_StandardInternational
  Else If Value = 'ES_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.ES_ExpeditedInternational
  Else If Value = 'ES_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.ES_OtherInternational
  Else If Value = 'ES_CartasPostalInternational'	 Then Data :=  	 ShippingServiceCodeType.ES_CartasPostalInternational
  Else If Value = 'ES_EmsPostalExpressInternational'	 Then Data :=  	 ShippingServiceCodeType.ES_EmsPostalExpressInternational
  Else If Value = 'ES_EconomyPacketInternational'	 Then Data :=  	 ShippingServiceCodeType.ES_EconomyPacketInternational
  Else If Value = 'ES_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.ES_EconomyDeliveryFromAbroad
  Else If Value = 'ES_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.ES_StandardDeliveryFromAbroad
  Else If Value = 'ES_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.ES_ExpressDeliveryFromAbroad
  Else If Value = 'ES_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.ES_TrackedDeliveryFromAbroad
  Else If Value = 'ES_ENTREGA_KIALA_8KG'	 Then Data :=  	 ShippingServiceCodeType.ES_ENTREGA_KIALA_8KG
  Else If Value = 'FR_ChronoposteInternationalClassic'	 Then Data :=  	 ShippingServiceCodeType.FR_ChronoposteInternationalClassic
  Else If Value = 'FR_ColiposteColissimoDirect'	 Then Data :=  	 ShippingServiceCodeType.FR_ColiposteColissimoDirect
  Else If Value = 'FR_DHLExpressEuropack'	 Then Data :=  	 ShippingServiceCodeType.FR_DHLExpressEuropack
  Else If Value = 'FR_UPSStandard'	 Then Data :=  	 ShippingServiceCodeType.FR_UPSStandard
  Else If Value = 'FR_PostOfficeLetter'	 Then Data :=  	 ShippingServiceCodeType.FR_PostOfficeLetter
  Else If Value = 'FR_PostOfficeLetterFollowed'	 Then Data :=  	 ShippingServiceCodeType.FR_PostOfficeLetterFollowed
  Else If Value = 'FR_PostOfficeLetterRecommended'	 Then Data :=  	 ShippingServiceCodeType.FR_PostOfficeLetterRecommended
  Else If Value = 'FR_ColiposteColissimo'	 Then Data :=  	 ShippingServiceCodeType.FR_ColiposteColissimo
  Else If Value = 'FR_ColiposteColissimoRecommended'	 Then Data :=  	 ShippingServiceCodeType.FR_ColiposteColissimoRecommended
  Else If Value = 'FR_UPSStandardAgainstRefund'	 Then Data :=  	 ShippingServiceCodeType.FR_UPSStandardAgainstRefund
  Else If Value = 'FR_Autre'	 Then Data :=  	 ShippingServiceCodeType.FR_Autre
  Else If Value = 'FR_Ecopli'	 Then Data :=  	 ShippingServiceCodeType.FR_Ecopli
  Else If Value = 'FR_Colieco'	 Then Data :=  	 ShippingServiceCodeType.FR_Colieco
  Else If Value = 'FR_AuteModeDenvoiDeColis'	 Then Data :=  	 ShippingServiceCodeType.FR_AuteModeDenvoiDeColis
  Else If Value = 'FR_RemiseEnMainPropre'	 Then Data :=  	 ShippingServiceCodeType.FR_RemiseEnMainPropre
  Else If Value = 'FR_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_StandardInternational
  Else If Value = 'FR_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_ExpeditedInternational
  Else If Value = 'FR_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_OtherInternational
  Else If Value = 'FR_LaPosteInternationalPriorityCourier'	 Then Data :=  	 ShippingServiceCodeType.FR_LaPosteInternationalPriorityCourier
  Else If Value = 'FR_LaPosteInternationalEconomyCourier'	 Then Data :=  	 ShippingServiceCodeType.FR_LaPosteInternationalEconomyCourier
  Else If Value = 'FR_LaPosteColissimoInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_LaPosteColissimoInternational
  Else If Value = 'FR_LaPosteColisEconomiqueInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_LaPosteColisEconomiqueInternational
  Else If Value = 'FR_LaPosteColissimoEmballageInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_LaPosteColissimoEmballageInternational
  Else If Value = 'FR_ChronopostClassicInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_ChronopostClassicInternational
  Else If Value = 'FR_ChronopostPremiumInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_ChronopostPremiumInternational
  Else If Value = 'FR_UPSStandardInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_UPSStandardInternational
  Else If Value = 'FR_UPSExpressInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_UPSExpressInternational
  Else If Value = 'FR_DHLInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_DHLInternational
  Else If Value = 'FR_LaPosteLetterMax'	 Then Data :=  	 ShippingServiceCodeType.FR_LaPosteLetterMax
  Else If Value = 'FR_KIALA_DELIVERY'	 Then Data :=  	 ShippingServiceCodeType.FR_KIALA_DELIVERY
  Else If Value = 'FR_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.FR_TrackedDeliveryFromAbroad
  Else If Value = 'IN_Regular'	 Then Data :=  	 ShippingServiceCodeType.IN_Regular
  Else If Value = 'IN_Express'	 Then Data :=  	 ShippingServiceCodeType.IN_Express
  Else If Value = 'IN_NationalCOD'	 Then Data :=  	 ShippingServiceCodeType.IN_NationalCOD
  Else If Value = 'IN_Courier'	 Then Data :=  	 ShippingServiceCodeType.IN_Courier
  Else If Value = 'IN_LocalCOD'	 Then Data :=  	 ShippingServiceCodeType.IN_LocalCOD
  Else If Value = 'IN_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.IN_StandardInternational
  Else If Value = 'IN_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.IN_ExpeditedInternational
  Else If Value = 'IN_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.IN_OtherInternational
  Else If Value = 'IN_FlatRateCOD'	 Then Data :=  	 ShippingServiceCodeType.IN_FlatRateCOD
  Else If Value = 'IN_BuyerPicksUpAndPays'	 Then Data :=  	 ShippingServiceCodeType.IN_BuyerPicksUpAndPays
  Else If Value = 'IT_RegularMail'	 Then Data :=  	 ShippingServiceCodeType.IT_RegularMail
  Else If Value = 'IT_PriorityMail'	 Then Data :=  	 ShippingServiceCodeType.IT_PriorityMail
  Else If Value = 'IT_MailRegisteredLetter'	 Then Data :=  	 ShippingServiceCodeType.IT_MailRegisteredLetter
  Else If Value = 'IT_MailRegisteredLetterWithMark'	 Then Data :=  	 ShippingServiceCodeType.IT_MailRegisteredLetterWithMark
  Else If Value = 'IT_InsuredMail'	 Then Data :=  	 ShippingServiceCodeType.IT_InsuredMail
  Else If Value = 'IT_QuickMail'	 Then Data :=  	 ShippingServiceCodeType.IT_QuickMail
  Else If Value = 'IT_RegularPackage'	 Then Data :=  	 ShippingServiceCodeType.IT_RegularPackage
  Else If Value = 'IT_QuickPackage1'	 Then Data :=  	 ShippingServiceCodeType.IT_QuickPackage1
  Else If Value = 'IT_QuickPackage3'	 Then Data :=  	 ShippingServiceCodeType.IT_QuickPackage3
  Else If Value = 'IT_ExpressCourier'	 Then Data :=  	 ShippingServiceCodeType.IT_ExpressCourier
  Else If Value = 'IT_ExpressPackageMaxi'	 Then Data :=  	 ShippingServiceCodeType.IT_ExpressPackageMaxi
  Else If Value = 'IT_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.IT_StandardInternational
  Else If Value = 'IT_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.IT_ExpeditedInternational
  Else If Value = 'IT_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.IT_OtherInternational
  Else If Value = 'IT_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.IT_TrackedDeliveryFromAbroad
  Else If Value = 'NL_StandardDelivery'	 Then Data :=  	 ShippingServiceCodeType.NL_StandardDelivery
  Else If Value = 'NL_ParcelPost'	 Then Data :=  	 ShippingServiceCodeType.NL_ParcelPost
  Else If Value = 'NL_RegisteredMail'	 Then Data :=  	 ShippingServiceCodeType.NL_RegisteredMail
  Else If Value = 'NL_Other'	 Then Data :=  	 ShippingServiceCodeType.NL_Other
  Else If Value = 'NL_TPGPostTNTInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_TPGPostTNTInternational
  Else If Value = 'NL_UPSInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_UPSInternational
  Else If Value = 'NL_FedExInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_FedExInternational
  Else If Value = 'NL_DHLInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_DHLInternational
  Else If Value = 'NL_DPDGBRInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_DPDGBRInternational
  Else If Value = 'NL_GLSBusinessInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_GLSBusinessInternational
  Else If Value = 'NL_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_StandardInternational
  Else If Value = 'NL_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_ExpeditedInternational
  Else If Value = 'NL_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.NL_OtherInternational
  Else If Value = 'NL_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.NL_EconomyDeliveryFromAbroad
  Else If Value = 'NL_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.NL_StandardDeliveryFromAbroad
  Else If Value = 'NL_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.NL_ExpressDeliveryFromAbroad
  Else If Value = 'NL_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.NL_TrackedDeliveryFromAbroad
  Else If Value = 'TW_RegisteredMail'	 Then Data :=  	 ShippingServiceCodeType.TW_RegisteredMail
  Else If Value = 'TW_UnregisteredMail'	 Then Data :=  	 ShippingServiceCodeType.TW_UnregisteredMail
  Else If Value = 'TW_COD'	 Then Data :=  	 ShippingServiceCodeType.TW_COD
  Else If Value = 'TW_DwellingMatchPost'	 Then Data :=  	 ShippingServiceCodeType.TW_DwellingMatchPost
  Else If Value = 'TW_DwellingMatchCOD'	 Then Data :=  	 ShippingServiceCodeType.TW_DwellingMatchCOD
  Else If Value = 'TW_SelfPickup'	 Then Data :=  	 ShippingServiceCodeType.TW_SelfPickup
  Else If Value = 'TW_ParcelPost'	 Then Data :=  	 ShippingServiceCodeType.TW_ParcelPost
  Else If Value = 'TW_ExpressMail'	 Then Data :=  	 ShippingServiceCodeType.TW_ExpressMail
  Else If Value = 'TW_Other'	 Then Data :=  	 ShippingServiceCodeType.TW_Other
  Else If Value = 'TW_CPInternationalLetterPost'	 Then Data :=  	 ShippingServiceCodeType.TW_CPInternationalLetterPost
  Else If Value = 'TW_CPInternationalParcelPost'	 Then Data :=  	 ShippingServiceCodeType.TW_CPInternationalParcelPost
  Else If Value = 'TW_CPInternationalRegisteredLetterPost'	 Then Data :=  	 ShippingServiceCodeType.TW_CPInternationalRegisteredLetterPost
  Else If Value = 'TW_CPInternationalRegisteredParcelPost'	 Then Data :=  	 ShippingServiceCodeType.TW_CPInternationalRegisteredParcelPost
  Else If Value = 'TW_CPInternationalEMS'	 Then Data :=  	 ShippingServiceCodeType.TW_CPInternationalEMS
  Else If Value = 'TW_CPInternationalOceanShippingParcel'	 Then Data :=  	 ShippingServiceCodeType.TW_CPInternationalOceanShippingParcel
  Else If Value = 'TW_FedExInternationalPriority'	 Then Data :=  	 ShippingServiceCodeType.TW_FedExInternationalPriority
  Else If Value = 'TW_FedExInternationalEconomy'	 Then Data :=  	 ShippingServiceCodeType.TW_FedExInternationalEconomy
  Else If Value = 'TW_UPSWorldwideExpedited'	 Then Data :=  	 ShippingServiceCodeType.TW_UPSWorldwideExpedited
  Else If Value = 'TW_UPSWorldwideExpress'	 Then Data :=  	 ShippingServiceCodeType.TW_UPSWorldwideExpress
  Else If Value = 'TW_UPSWorldwideExpressPlus'	 Then Data :=  	 ShippingServiceCodeType.TW_UPSWorldwideExpressPlus
  Else If Value = 'TW_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.TW_OtherInternational
  Else If Value = 'UK_RoyalMailFirstClassStandard'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailFirstClassStandard
  Else If Value = 'UK_RoyalMailSecondClassStandard'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailSecondClassStandard
  Else If Value = 'UK_RoyalMailFirstClassRecorded'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailFirstClassRecorded
  Else If Value = 'UK_RoyalMailSecondClassRecorded'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailSecondClassRecorded
  Else If Value = 'UK_RoyalMailSpecialDelivery'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailSpecialDelivery
  Else If Value = 'UK_RoyalMailStandardParcel'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailStandardParcel
  Else If Value = 'UK_Parcelforce24'	 Then Data :=  	 ShippingServiceCodeType.UK_Parcelforce24
  Else If Value = 'UK_Parcelforce48'	 Then Data :=  	 ShippingServiceCodeType.UK_Parcelforce48
  Else If Value = 'UK_OtherCourier'	 Then Data :=  	 ShippingServiceCodeType.UK_OtherCourier
  Else If Value = 'UK_myHermesDoorToDoorService'	 Then Data :=  	 ShippingServiceCodeType.UK_myHermesDoorToDoorService
  Else If Value = 'UK_CollectDropAtStoreDeliveryToDoor'	 Then Data :=  	 ShippingServiceCodeType.UK_CollectDropAtStoreDeliveryToDoor
  Else If Value = 'UK_SellersStandardRate'	 Then Data :=  	 ShippingServiceCodeType.UK_SellersStandardRate
  Else If Value = 'UK_CollectInPerson'	 Then Data :=  	 ShippingServiceCodeType.UK_CollectInPerson
  Else If Value = 'UK_SellersStandardInternationalRate'	 Then Data :=  	 ShippingServiceCodeType.UK_SellersStandardInternationalRate
  Else If Value = 'UK_RoyalMailAirmailInternational'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailAirmailInternational
  Else If Value = 'UK_RoyalMailAirsureInternational'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailAirsureInternational
  Else If Value = 'UK_RoyalMailSurfaceMailInternational'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailSurfaceMailInternational
  Else If Value = 'UK_RoyalMailInternationalSignedFor'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailInternationalSignedFor
  Else If Value = 'UK_RoyalMailHMForcesMailInternational'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailHMForcesMailInternational
  Else If Value = 'UK_ParcelForceInternationalDatapost'	 Then Data :=  	 ShippingServiceCodeType.UK_ParcelForceInternationalDatapost
  Else If Value = 'UK_ParcelForceIreland24International'	 Then Data :=  	 ShippingServiceCodeType.UK_ParcelForceIreland24International
  Else If Value = 'UK_ParcelForceEuro48International'	 Then Data :=  	 ShippingServiceCodeType.UK_ParcelForceEuro48International
  Else If Value = 'UK_ParcelForceInternationalScheduled'	 Then Data :=  	 ShippingServiceCodeType.UK_ParcelForceInternationalScheduled
  Else If Value = 'UK_OtherCourierOrDeliveryInternational'	 Then Data :=  	 ShippingServiceCodeType.UK_OtherCourierOrDeliveryInternational
  Else If Value = 'UK_CollectInPersonInternational'	 Then Data :=  	 ShippingServiceCodeType.UK_CollectInPersonInternational
  Else If Value = 'UK_ParcelForceIntlExpress'	 Then Data :=  	 ShippingServiceCodeType.UK_ParcelForceIntlExpress
  Else If Value = 'UK_ParcelForceIntlValue'	 Then Data :=  	 ShippingServiceCodeType.UK_ParcelForceIntlValue
  Else If Value = 'UK_ParcelForceIntlEconomy'	 Then Data :=  	 ShippingServiceCodeType.UK_ParcelForceIntlEconomy
  Else If Value = 'UK_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.UK_TrackedDeliveryFromAbroad
  Else If Value = 'UK_IntlTrackedPostage'	 Then Data :=  	 ShippingServiceCodeType.UK_IntlTrackedPostage
  Else If Value = 'IE_SellersStandardRate'	 Then Data :=  	 ShippingServiceCodeType.IE_SellersStandardRate
  Else If Value = 'IE_FirstClassLetterService'	 Then Data :=  	 ShippingServiceCodeType.IE_FirstClassLetterService
  Else If Value = 'IE_SwiftPostNational'	 Then Data :=  	 ShippingServiceCodeType.IE_SwiftPostNational
  Else If Value = 'IE_RegisteredPost'	 Then Data :=  	 ShippingServiceCodeType.IE_RegisteredPost
  Else If Value = 'IE_EMSSDSCourier'	 Then Data :=  	 ShippingServiceCodeType.IE_EMSSDSCourier
  Else If Value = 'IE_EconomySDSCourier'	 Then Data :=  	 ShippingServiceCodeType.IE_EconomySDSCourier
  Else If Value = 'IE_OtherCourier'	 Then Data :=  	 ShippingServiceCodeType.IE_OtherCourier
  Else If Value = 'IE_CollectionInPerson'	 Then Data :=  	 ShippingServiceCodeType.IE_CollectionInPerson
  Else If Value = 'IE_SellersStandardRateInternational'	 Then Data :=  	 ShippingServiceCodeType.IE_SellersStandardRateInternational
  Else If Value = 'IE_InternationalEconomyService'	 Then Data :=  	 ShippingServiceCodeType.IE_InternationalEconomyService
  Else If Value = 'IE_InternationalPriorityService'	 Then Data :=  	 ShippingServiceCodeType.IE_InternationalPriorityService
  Else If Value = 'IE_SwiftPostExpressInternational'	 Then Data :=  	 ShippingServiceCodeType.IE_SwiftPostExpressInternational
  Else If Value = 'IE_SwiftPostInternational'	 Then Data :=  	 ShippingServiceCodeType.IE_SwiftPostInternational
  Else If Value = 'IE_EMSSDSCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.IE_EMSSDSCourierInternational
  Else If Value = 'IE_EconomySDSCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.IE_EconomySDSCourierInternational
  Else If Value = 'IE_OtherCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.IE_OtherCourierInternational
  Else If Value = 'IE_CollectionInPersonInternational'	 Then Data :=  	 ShippingServiceCodeType.IE_CollectionInPersonInternational
  Else If Value = 'IE_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.IE_EconomyDeliveryFromAbroad
  Else If Value = 'IE_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.IE_StandardDeliveryFromAbroad
  Else If Value = 'IE_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.IE_ExpressDeliveryFromAbroad
  Else If Value = 'IE_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.IE_TrackedDeliveryFromAbroad
  Else If Value = 'PL_DomesticRegular'	 Then Data :=  	 ShippingServiceCodeType.PL_DomesticRegular
  Else If Value = 'PL_DomesticSpecial'	 Then Data :=  	 ShippingServiceCodeType.PL_DomesticSpecial
  Else If Value = 'PL_EconomyDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.PL_EconomyDeliveryFromAbroad
  Else If Value = 'PL_StandardDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.PL_StandardDeliveryFromAbroad
  Else If Value = 'PL_ExpressDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.PL_ExpressDeliveryFromAbroad
  Else If Value = 'PL_TrackedDeliveryFromAbroad'	 Then Data :=  	 ShippingServiceCodeType.PL_TrackedDeliveryFromAbroad
  Else If Value = 'FreightShipping'	 Then Data :=  	 ShippingServiceCodeType.FreightShipping
  Else If Value = 'FreightOtherShipping'	 Then Data :=  	 ShippingServiceCodeType.FreightOtherShipping
  Else If Value = 'Freight'	 Then Data :=  	 ShippingServiceCodeType.Freight
  Else If Value = 'FreightShippingInternational'	 Then Data :=  	 ShippingServiceCodeType.FreightShippingInternational
  Else If Value = 'USPSGround'	 Then Data :=  	 ShippingServiceCodeType.USPSGround
  Else If Value = 'ShippingMethodOvernight'	 Then Data :=  	 ShippingServiceCodeType.ShippingMethodOvernight
  Else If Value = 'CustomCode'	 Then Data :=  	 ShippingServiceCodeType.CustomCode
  Else If Value = 'USPSPriorityFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityFlatRateEnvelope
  Else If Value = 'USPSPriorityFlatRateBox'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityFlatRateBox
  Else If Value = 'USPSGlobalPrioritySmallEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSGlobalPrioritySmallEnvelope
  Else If Value = 'USPSGlobalPriorityLargeEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSGlobalPriorityLargeEnvelope
  Else If Value = 'USPSExpressFlatRateEnvelope'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressFlatRateEnvelope
  Else If Value = 'UPSWorldWideExpressBox10kg'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldWideExpressBox10kg
  Else If Value = 'UPSWorldWideExpressBox25kg'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldWideExpressBox25kg
  Else If Value = 'UPSWorldWideExpressPlusBox10kg'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldWideExpressPlusBox10kg
  Else If Value = 'UPSWorldWideExpressPlusBox25kg'	 Then Data :=  	 ShippingServiceCodeType.UPSWorldWideExpressPlusBox25kg
  Else If Value = 'HK_LocalPickUpOnly'	 Then Data :=  	 ShippingServiceCodeType.HK_LocalPickUpOnly
  Else If Value = 'HK_LocalCourier'	 Then Data :=  	 ShippingServiceCodeType.HK_LocalCourier
  Else If Value = 'HK_DomesticRegularShipping'	 Then Data :=  	 ShippingServiceCodeType.HK_DomesticRegularShipping
  Else If Value = 'HK_DomesticSpecialShipping'	 Then Data :=  	 ShippingServiceCodeType.HK_DomesticSpecialShipping
  Else If Value = 'HK_InternationalRegularShipping'	 Then Data :=  	 ShippingServiceCodeType.HK_InternationalRegularShipping
  Else If Value = 'HK_InternationalSpecialShipping'	 Then Data :=  	 ShippingServiceCodeType.HK_InternationalSpecialShipping
  Else If Value = 'SG_LocalPickUpOnly'	 Then Data :=  	 ShippingServiceCodeType.SG_LocalPickUpOnly
  Else If Value = 'SG_LocalCourier'	 Then Data :=  	 ShippingServiceCodeType.SG_LocalCourier
  Else If Value = 'SG_DomesticStandardMail'	 Then Data :=  	 ShippingServiceCodeType.SG_DomesticStandardMail
  Else If Value = 'SG_DomesticNonStandardMail'	 Then Data :=  	 ShippingServiceCodeType.SG_DomesticNonStandardMail
  Else If Value = 'SG_DomesticSpeedpostIslandwide'	 Then Data :=  	 ShippingServiceCodeType.SG_DomesticSpeedpostIslandwide
  Else If Value = 'SG_InternationalStandardMail'	 Then Data :=  	 ShippingServiceCodeType.SG_InternationalStandardMail
  Else If Value = 'SG_InternationalExpressMailService'	 Then Data :=  	 ShippingServiceCodeType.SG_InternationalExpressMailService
  Else If Value = 'SG_InternationalCourier'	 Then Data :=  	 ShippingServiceCodeType.SG_InternationalCourier
  Else If Value = 'BENL_DePostZendingNONPRIOR'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostZendingNONPRIOR
  Else If Value = 'BENL_DePostZendingPRIOR'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostZendingPRIOR
  Else If Value = 'BENL_DePostZendingAangetekend'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostZendingAangetekend
  Else If Value = 'BENL_KilopostPakje'	 Then Data :=  	 ShippingServiceCodeType.BENL_KilopostPakje
  Else If Value = 'BENL_Taxipost'	 Then Data :=  	 ShippingServiceCodeType.BENL_Taxipost
  Else If Value = 'BENL_KialaAfhaalpunt'	 Then Data :=  	 ShippingServiceCodeType.BENL_KialaAfhaalpunt
  Else If Value = 'BENL_VasteKostenStandaardVerzending'	 Then Data :=  	 ShippingServiceCodeType.BENL_VasteKostenStandaardVerzending
  Else If Value = 'BENL_VasteKostenVersneldeVerzending'	 Then Data :=  	 ShippingServiceCodeType.BENL_VasteKostenVersneldeVerzending
  Else If Value = 'BENL_VerzekerdeVerzending'	 Then Data :=  	 ShippingServiceCodeType.BENL_VerzekerdeVerzending
  Else If Value = 'BEFR_LaPosteEnvoiNONPRIOR'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteEnvoiNONPRIOR
  Else If Value = 'BEFR_LaPosteEnvoiPRIOR'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteEnvoiPRIOR
  Else If Value = 'BEFR_LaPosteEnvoiRecommande'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteEnvoiRecommande
  Else If Value = 'BEFR_PaquetKilopost'	 Then Data :=  	 ShippingServiceCodeType.BEFR_PaquetKilopost
  Else If Value = 'BEFR_Taxipost'	 Then Data :=  	 ShippingServiceCodeType.BEFR_Taxipost
  Else If Value = 'BEFR_PointRetraitKiala'	 Then Data :=  	 ShippingServiceCodeType.BEFR_PointRetraitKiala
  Else If Value = 'BEFR_LivraisonStandardPrixforFaitaire'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LivraisonStandardPrixforFaitaire
  Else If Value = 'BEFR_LivraisonExpressPrixforFaitaire'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LivraisonExpressPrixforFaitaire
  Else If Value = 'BEFR_LivraisonSecurise'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LivraisonSecurise
  Else If Value = 'BENL_DePostZendingPRIORInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostZendingPRIORInternational
  Else If Value = 'BENL_DePostZendingNONPRIORInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostZendingNONPRIORInternational
  Else If Value = 'BENL_DePostZendingAangetekendInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_DePostZendingAangetekendInternational
  Else If Value = 'BENL_KilopostPakjeInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_KilopostPakjeInternational
  Else If Value = 'BENL_TaxipostExpressverzending'	 Then Data :=  	 ShippingServiceCodeType.BENL_TaxipostExpressverzending
  Else If Value = 'BENL_VerzekerdeVerzendingInternational'	 Then Data :=  	 ShippingServiceCodeType.BENL_VerzekerdeVerzendingInternational
  Else If Value = 'BEFR_LaPosteenvoiePRIOR'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteenvoiePRIOR
  Else If Value = 'BEFR_LaPosteenvoieNONPRIOR'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteenvoieNONPRIOR
  Else If Value = 'BEFR_LaPosteenvoieRecommande'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LaPosteenvoieRecommande
  Else If Value = 'BEFR_PaquetKilopostInternationale'	 Then Data :=  	 ShippingServiceCodeType.BEFR_PaquetKilopostInternationale
  Else If Value = 'BEFR_ExpressTaxipost'	 Then Data :=  	 ShippingServiceCodeType.BEFR_ExpressTaxipost
  Else If Value = 'BEFR_LivraisonStandardInternationalePrixforFaitaire'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LivraisonStandardInternationalePrixforFaitaire
  Else If Value = 'BEFR_LivraisonExpressInternationalePrixforFaitaire'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LivraisonExpressInternationalePrixforFaitaire
  Else If Value = 'BEFR_LivraisonSecuriseInternational'	 Then Data :=  	 ShippingServiceCodeType.BEFR_LivraisonSecuriseInternational
  Else If Value = 'FR_Chronopost'	 Then Data :=  	 ShippingServiceCodeType.FR_Chronopost
  Else If Value = 'UK_RoyalMailSpecialDeliveryNextDay'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailSpecialDeliveryNextDay
  Else If Value = 'CA_PostLightPacketInternational'	 Then Data :=  	 ShippingServiceCodeType.CA_PostLightPacketInternational
  Else If Value = 'CA_PostLightPacketUSA'	 Then Data :=  	 ShippingServiceCodeType.CA_PostLightPacketUSA
  Else If Value = 'PL_DHLInternational'	 Then Data :=  	 ShippingServiceCodeType.PL_DHLInternational
  Else If Value = 'PL_InternationalRegular'	 Then Data :=  	 ShippingServiceCodeType.PL_InternationalRegular
  Else If Value = 'PL_InternationalSpecial'	 Then Data :=  	 ShippingServiceCodeType.PL_InternationalSpecial
  Else If Value = 'PL_UPSInternational'	 Then Data :=  	 ShippingServiceCodeType.PL_UPSInternational
  Else If Value = 'CAFR_StandardDelivery'	 Then Data :=  	 ShippingServiceCodeType.CAFR_StandardDelivery
  Else If Value = 'CAFR_ExpeditedDelivery'	 Then Data :=  	 ShippingServiceCodeType.CAFR_ExpeditedDelivery
  Else If Value = 'CAFR_PostLettermail'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostLettermail
  Else If Value = 'CAFR_PostRegularParcel'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostRegularParcel
  Else If Value = 'CAFR_PostExpeditedParcel'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostExpeditedParcel
  Else If Value = 'CAFR_PostXpresspost'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostXpresspost
  Else If Value = 'CAFR_PostPriorityCourier'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostPriorityCourier
  Else If Value = 'CAFR_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.CAFR_StandardInternational
  Else If Value = 'CAFR_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.CAFR_ExpeditedInternational
  Else If Value = 'CAFR_OtherInternational'	 Then Data :=  	 ShippingServiceCodeType.CAFR_OtherInternational
  Else If Value = 'CAFR_PostExpeditedParcelUSA'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostExpeditedParcelUSA
  Else If Value = 'CAFR_PostSmallPacketsUSA'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostSmallPacketsUSA
  Else If Value = 'CAFR_PostXpresspostUSA'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostXpresspostUSA
  Else If Value = 'CAFR_PostXpresspostInternational'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostXpresspostInternational
  Else If Value = 'CAFR_PostInternationalParcelSurface'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostInternationalParcelSurface
  Else If Value = 'CAFR_PostInternationalParcelAir'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostInternationalParcelAir
  Else If Value = 'CAFR_SmallPacketsInternational'	 Then Data :=  	 ShippingServiceCodeType.CAFR_SmallPacketsInternational
  Else If Value = 'CAFR_PurolatorInternational'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PurolatorInternational
  Else If Value = 'CAFR_PostSmallPacketsUSAGround'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostSmallPacketsUSAGround
  Else If Value = 'CAFR_PostSmallPacketsUSAAir'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostSmallPacketsUSAAir
  Else If Value = 'CAFR_SmallPacketsInternationalGround'	 Then Data :=  	 ShippingServiceCodeType.CAFR_SmallPacketsInternationalGround
  Else If Value = 'CAFR_SmallPacketsInternationalAir'	 Then Data :=  	 ShippingServiceCodeType.CAFR_SmallPacketsInternationalAir
  Else If Value = 'CAFR_PostUSALetterPost'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostUSALetterPost
  Else If Value = 'CAFR_PostInternationalLetterPost'	 Then Data :=  	 ShippingServiceCodeType.CAFR_PostInternationalLetterPost
  Else If Value = 'CAFR_UPSExpressCanada'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSExpressCanada
  Else If Value = 'CAFR_UPSExpressSaverCanada'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSExpressSaverCanada
  Else If Value = 'CAFR_UPSExpeditedCanada'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSExpeditedCanada
  Else If Value = 'CAFR_UPSStandardCanada'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSStandardCanada
  Else If Value = 'CAFR_UPSExpressUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSExpressUnitedStates
  Else If Value = 'CAFR_UPSExpeditedUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSExpeditedUnitedStates
  Else If Value = 'CAFR_UPS3DaySelectUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPS3DaySelectUnitedStates
  Else If Value = 'CAFR_UPSStandardUnitedStates'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSStandardUnitedStates
  Else If Value = 'CAFR_UPSWorldWideExpress'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSWorldWideExpress
  Else If Value = 'CAFR_UPSWorldWideExpedited'	 Then Data :=  	 ShippingServiceCodeType.CAFR_UPSWorldWideExpedited
  Else If Value = 'UK_RoyalMailSpecialDelivery9am'	 Then Data :=  	 ShippingServiceCodeType.UK_RoyalMailSpecialDelivery9am
  Else If Value = 'USPSFirstClassMailInternational'	 Then Data :=  	 ShippingServiceCodeType.USPSFirstClassMailInternational
  Else If Value = 'USPSPriorityMailInternational'	 Then Data :=  	 ShippingServiceCodeType.USPSPriorityMailInternational
  Else If Value = 'USPSExpressMailInternational'	 Then Data :=  	 ShippingServiceCodeType.USPSExpressMailInternational
  Else If Value = 'CH_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_StandardInternational
  Else If Value = 'CH_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_ExpeditedInternational
  Else If Value = 'CH_SonstigerVersandSieheArtikelbeschreibung'	 Then Data :=  	 ShippingServiceCodeType.CH_SonstigerVersandSieheArtikelbeschreibung
  Else If Value = 'TW_StandardInternationalFixedRate'	 Then Data :=  	 ShippingServiceCodeType.TW_StandardInternationalFixedRate
  Else If Value = 'TW_ExpeditedInternationalFixedRate'	 Then Data :=  	 ShippingServiceCodeType.TW_ExpeditedInternationalFixedRate
  Else If Value = 'USPSGlobalExpressGuaranteed'	 Then Data :=  	 ShippingServiceCodeType.USPSGlobalExpressGuaranteed
  Else If Value = 'AU_RegularWithInsurance'	 Then Data :=  	 ShippingServiceCodeType.AU_RegularWithInsurance
  Else If Value = 'AU_ExpressWithInsurance'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpressWithInsurance
  Else If Value = 'DE_DeutschePostWarensendungInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostWarensendungInternational
  Else If Value = 'DE_DeutschePostByendung'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostByendung
  Else If Value = 'DE_HermesPaketUnversichertInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketUnversichertInternational
  Else If Value = 'DE_HermesPaketVersichertInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_HermesPaketVersichertInternational
  Else If Value = 'DE_iLoxxTransportXXLInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_iLoxxTransportXXLInternational
  Else If Value = 'DE_iLoxxUbernachtExpressInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_iLoxxUbernachtExpressInternational
  Else If Value = 'DE_iLoxxStandardInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_iLoxxStandardInternational
  Else If Value = 'DE_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_StandardInternational
  Else If Value = 'DE_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_ExpeditedInternational
  Else If Value = 'DE_DeutschePostBriefIntlEcon'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostBriefIntlEcon
  Else If Value = 'DE_DeutschePostBriefIntlPri'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostBriefIntlPri
  Else If Value = 'AT_BitteTreffenSieEineAuswahl'	 Then Data :=  	 ShippingServiceCodeType.AT_BitteTreffenSieEineAuswahl
  Else If Value = 'AT_EinschreibenVersandInklEinschreibengebuhr'	 Then Data :=  	 ShippingServiceCodeType.AT_EinschreibenVersandInklEinschreibengebuhr
  Else If Value = 'AT_NachnahmeVersandInklNachnahmegebuhr'	 Then Data :=  	 ShippingServiceCodeType.AT_NachnahmeVersandInklNachnahmegebuhr
  Else If Value = 'AT_ExpressOrCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_ExpressOrCourierInternational
  Else If Value = 'AT_InsuredExpressOrCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_InsuredExpressOrCourierInternational
  Else If Value = 'AT_SpecialDispatchInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_SpecialDispatchInternational
  Else If Value = 'AT_InsuredSpecialDispatchInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_InsuredSpecialDispatchInternational
  Else If Value = 'AT_StandardInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_StandardInternational
  Else If Value = 'AT_ExpeditedInternational'	 Then Data :=  	 ShippingServiceCodeType.AT_ExpeditedInternational
  Else If Value = 'AT_OtherInternationalShipping'	 Then Data :=  	 ShippingServiceCodeType.AT_OtherInternationalShipping
  Else If Value = 'CH_BitteTreffenSieEineAuswahl'	 Then Data :=  	 ShippingServiceCodeType.CH_BitteTreffenSieEineAuswahl
  Else If Value = 'CH_UnversicherterVersand'	 Then Data :=  	 ShippingServiceCodeType.CH_UnversicherterVersand
  Else If Value = 'CH_VersicherterVersand'	 Then Data :=  	 ShippingServiceCodeType.CH_VersicherterVersand
  Else If Value = 'CH_EinschreibenVersandInklEinschreibengebuhr'	 Then Data :=  	 ShippingServiceCodeType.CH_EinschreibenVersandInklEinschreibengebuhr
  Else If Value = 'CH_NachnahmeVersandInklNachnahmegebuhr'	 Then Data :=  	 ShippingServiceCodeType.CH_NachnahmeVersandInklNachnahmegebuhr
  Else If Value = 'CH_ExpressOrCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_ExpressOrCourierInternational
  Else If Value = 'CH_InsuredExpressOrCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.CH_InsuredExpressOrCourierInternational
  Else If Value = 'CH_SonderversandZBSperrgutKFZ'	 Then Data :=  	 ShippingServiceCodeType.CH_SonderversandZBSperrgutKFZ
  Else If Value = 'CH_VersicherterSonderversandZBSperrgutKFZ'	 Then Data :=  	 ShippingServiceCodeType.CH_VersicherterSonderversandZBSperrgutKFZ
  Else If Value = 'CH_StandardversandAPostPriority'	 Then Data :=  	 ShippingServiceCodeType.CH_StandardversandAPostPriority
  Else If Value = 'CH_StandardversandBPostEconomy'	 Then Data :=  	 ShippingServiceCodeType.CH_StandardversandBPostEconomy
  Else If Value = 'DE_BitteTreffenSieEineAuswahl'	 Then Data :=  	 ShippingServiceCodeType.DE_BitteTreffenSieEineAuswahl
  Else If Value = 'DE_EinschreibenVersandInklEinschreibengebuhr'	 Then Data :=  	 ShippingServiceCodeType.DE_EinschreibenVersandInklEinschreibengebuhr
  Else If Value = 'DE_NachnahmeVersandInklNachnahmegebuhr'	 Then Data :=  	 ShippingServiceCodeType.DE_NachnahmeVersandInklNachnahmegebuhr
  Else If Value = 'DE_ExpressOrCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_ExpressOrCourierInternational
  Else If Value = 'DE_InsuredExpressOrCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_InsuredExpressOrCourierInternational
  Else If Value = 'DE_SonderversandZBMobelKFZ'	 Then Data :=  	 ShippingServiceCodeType.DE_SonderversandZBMobelKFZ
  Else If Value = 'DE_VersicherterSonderversandZBMobelKFZ'	 Then Data :=  	 ShippingServiceCodeType.DE_VersicherterSonderversandZBMobelKFZ
  Else If Value = 'DE_DeutschePostBriefInternational'	 Then Data :=  	 ShippingServiceCodeType.DE_DeutschePostBriefInternational
  Else If Value = 'IE_StandardInternationalFlatRatePostage'	 Then Data :=  	 ShippingServiceCodeType.IE_StandardInternationalFlatRatePostage
  Else If Value = 'IE_ExpeditedInternationalFlatRatePostage'	 Then Data :=  	 ShippingServiceCodeType.IE_ExpeditedInternationalFlatRatePostage
  Else If Value = 'IE_OtherInternationalPostage'	 Then Data :=  	 ShippingServiceCodeType.IE_OtherInternationalPostage
  Else If Value = 'UK_StandardInternationalFlatRatePostage'	 Then Data :=  	 ShippingServiceCodeType.UK_StandardInternationalFlatRatePostage
  Else If Value = 'UK_ExpeditedInternationalFlatRatePostage'	 Then Data :=  	 ShippingServiceCodeType.UK_ExpeditedInternationalFlatRatePostage
  Else If Value = 'UK_OtherInternationalPostage'	 Then Data :=  	 ShippingServiceCodeType.UK_OtherInternationalPostage
  Else If Value = 'FR_ChronopostChronoRelais'	 Then Data :=  	 ShippingServiceCodeType.FR_ChronopostChronoRelais
  Else If Value = 'FR_Chrono10'	 Then Data :=  	 ShippingServiceCodeType.FR_Chrono10
  Else If Value = 'FR_Chrono13'	 Then Data :=  	 ShippingServiceCodeType.FR_Chrono13
  Else If Value = 'FR_Chrono18'	 Then Data :=  	 ShippingServiceCodeType.FR_Chrono18
  Else If Value = 'FR_ChronopostExpressInternational'	 Then Data :=  	 ShippingServiceCodeType.FR_ChronopostExpressInternational
  Else If Value = 'Pickup'	 Then Data :=  	 ShippingServiceCodeType.Pickup
  Else If Value = 'Delivery'	 Then Data :=  	 ShippingServiceCodeType.Delivery
  Else If Value = 'CA_Pickup'	 Then Data :=  	 ShippingServiceCodeType.CA_Pickup
  Else If Value = 'DE_Pickup'	 Then Data :=  	 ShippingServiceCodeType.DE_Pickup
  Else If Value = 'AU_Pickup'	 Then Data :=  	 ShippingServiceCodeType.AU_Pickup
  Else If Value = 'AU_SmallParcels'	 Then Data :=  	 ShippingServiceCodeType.AU_SmallParcels
  Else If Value = 'AU_SmallParcelWithTracking'	 Then Data :=  	 ShippingServiceCodeType.AU_SmallParcelWithTracking
  Else If Value = 'AU_SmallParcelWithTrackingAndSignature'	 Then Data :=  	 ShippingServiceCodeType.AU_SmallParcelWithTrackingAndSignature
  Else If Value = 'AU_RegularParcelWithTracking'	 Then Data :=  	 ShippingServiceCodeType.AU_RegularParcelWithTracking
  Else If Value = 'AU_RegularParcelWithTrackingAndSignature'	 Then Data :=  	 ShippingServiceCodeType.AU_RegularParcelWithTrackingAndSignature
  Else If Value = 'AU_PrePaidExpressPostSatchel5kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostSatchel5kg
  Else If Value = 'AU_PrePaidParcelPostSatchels500g'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidParcelPostSatchels500g
  Else If Value = 'AU_PrePaidParcelPostSatchels3kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidParcelPostSatchels3kg
  Else If Value = 'AU_PrePaidParcelPostSatchels5kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidParcelPostSatchels5kg
  Else If Value = 'AU_PrePaidExpressPostSatchel500g'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostSatchel500g
  Else If Value = 'AU_PrePaidExpressPostSatchel3kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostSatchel3kg
  Else If Value = 'AU_PrePaidExpressPostPlatinum500g'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostPlatinum500g
  Else If Value = 'AU_PrePaidExpressPostPlatinum3kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostPlatinum3kg
  Else If Value = 'AU_ExpressCourierInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpressCourierInternational
  Else If Value = 'AU_ExpressPostInternational'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpressPostInternational
  Else If Value = 'AU_PrePaidExpressPostInternationalEnvelopeC5'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostInternationalEnvelopeC5
  Else If Value = 'AU_PrePaidExpressPostInternationalEnvelopeB4'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostInternationalEnvelopeB4
  Else If Value = 'AU_PrePaidExpressPostInternationalSatchels2kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostInternationalSatchels2kg
  Else If Value = 'AU_PrePaidExpressPostInternationalSatchels3kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostInternationalSatchels3kg
  Else If Value = 'AU_PrePaidExpressPostInternationalBox5kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostInternationalBox5kg
  Else If Value = 'AU_PrePaidExpressPostInternationalBox10kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostInternationalBox10kg
  Else If Value = 'AU_PrePaidExpressPostInternationalBox20kg'	 Then Data :=  	 ShippingServiceCodeType.AU_PrePaidExpressPostInternationalBox20kg
  Else If Value = 'AU_RegisteredParcelPost'	 Then Data :=  	 ShippingServiceCodeType.AU_RegisteredParcelPost
  Else If Value = 'AU_RegisteredSmallParcel'	 Then Data :=  	 ShippingServiceCodeType.AU_RegisteredSmallParcel
  Else If Value = 'AU_RegisteredParcelPostPrepaidSatchel500g'	 Then Data :=  	 ShippingServiceCodeType.AU_RegisteredParcelPostPrepaidSatchel500g
  Else If Value = 'AU_RegisteredParcelPostPrepaidSatchel3kg'	 Then Data :=  	 ShippingServiceCodeType.AU_RegisteredParcelPostPrepaidSatchel3kg
  Else If Value = 'AU_RegisteredParcelPostPrepaidSatchel5kg'	 Then Data :=  	 ShippingServiceCodeType.AU_RegisteredParcelPostPrepaidSatchel5kg
  Else If Value = 'AU_ExpressPostSatchel500g'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpressPostSatchel500g
  Else If Value = 'AU_ExpressPostSatchel3kg'	 Then Data :=  	 ShippingServiceCodeType.AU_ExpressPostSatchel3kg
  Else If Value = 'FR_Pickup'	 Then Data :=  	 ShippingServiceCodeType.FR_Pickup
  Else If Value = 'AT_Pickup'	 Then Data :=  	 ShippingServiceCodeType.AT_Pickup
  Else If Value = 'BENL_Pickup'	 Then Data :=  	 ShippingServiceCodeType.BENL_Pickup
  Else If Value = 'BEFR_Pickup'	 Then Data :=  	 ShippingServiceCodeType.BEFR_Pickup
  Else If Value = 'CH_Pickup'	 Then Data :=  	 ShippingServiceCodeType.CH_Pickup
  Else If Value = 'IT_Pickup'	 Then Data :=  	 ShippingServiceCodeType.IT_Pickup
  Else If Value = 'NL_Pickup'	 Then Data :=  	 ShippingServiceCodeType.NL_Pickup
  Else If Value = 'PL_Pickup'	 Then Data :=  	 ShippingServiceCodeType.PL_Pickup
  Else If Value = 'ES_Pickup'	 Then Data :=  	 ShippingServiceCodeType.ES_Pickup
  Else If Value = 'SG_Delivery'	 Then Data :=  	 ShippingServiceCodeType.SG_Delivery
  Else If Value = 'UK_OtherCourier24'	 Then Data :=  	 ShippingServiceCodeType.UK_OtherCourier24
  Else If Value = 'UK_OtherCourier48'	 Then Data :=  	 ShippingServiceCodeType.UK_OtherCourier48
  Else If Value = 'UK_OtherCourier3Days'	 Then Data :=  	 ShippingServiceCodeType.UK_OtherCourier3Days
  Else If Value = 'UK_OtherCourier5Days'	 Then Data :=  	 ShippingServiceCodeType.UK_OtherCourier5Days
  Else If Value = 'Courier'	 Then Data :=  	 ShippingServiceCodeType.Courier
  Else If Value = 'FedExPriorityOvernight'	 Then Data :=  	 ShippingServiceCodeType.FedExPriorityOvernight
  Else If Value = 'FedExStandardOvernight'	 Then Data :=  	 ShippingServiceCodeType.FedExStandardOvernight
  Else If Value = 'FedEx2Day'	 Then Data :=  	 ShippingServiceCodeType.FedEx2Day
  Else If Value = 'FedExGround'	 Then Data :=  	 ShippingServiceCodeType.FedExGround
  Else If Value = 'FedExHomeDelivery'	 Then Data :=  	 ShippingServiceCodeType.FedExHomeDelivery
  Else If Value = 'FedExExpressSaver'	 Then Data :=  	 ShippingServiceCodeType.FedExExpressSaver
  Else If Value = 'FedExGroundDisabled'	 Then Data :=  	 ShippingServiceCodeType.FedExGroundDisabled
  Else If Value = 'FedExHomeDeliveryDisabled'	 Then Data :=  	 ShippingServiceCodeType.FedExHomeDeliveryDisabled
  Else If Value = 'FedExInternationalFirst'	 Then Data :=  	 ShippingServiceCodeType.FedExInternationalFirst
  Else If Value = 'FedExInternationalPriority'	 Then Data :=  	 ShippingServiceCodeType.FedExInternationalPriority
  Else If Value = 'FedExInternationalEconomy'	 Then Data :=  	 ShippingServiceCodeType.FedExInternationalEconomy
  Else If Value = 'FedExInternationalGround'	 Then Data :=  	 ShippingServiceCodeType.FedExInternationalGround
  Else If Value = 'EconomyShippingFromOutsideUS'	 Then Data :=  	 ShippingServiceCodeType.EconomyShippingFromOutsideUS
  Else If Value = 'ExpeditedShippingFromOutsideUS'	 Then Data :=  	 ShippingServiceCodeType.ExpeditedShippingFromOutsideUS
  Else If Value = 'StandardShippingFromOutsideUS'	 Then Data :=  	 ShippingServiceCodeType.StandardShippingFromOutsideUS
  Else If Value = 'UK_EconomyShippingFromOutside'	 Then Data :=  	 ShippingServiceCodeType.UK_EconomyShippingFromOutside
  Else If Value = 'UK_ExpeditedShippingFromOutside'	 Then Data :=  	 ShippingServiceCodeType.UK_ExpeditedShippingFromOutside
  Else If Value = 'UK_StandardShippingFromOutside'	 Then Data :=  	 ShippingServiceCodeType.UK_StandardShippingFromOutside
  Else If Value = 'DE_SparversandAusDemAusland'	 Then Data :=  	 ShippingServiceCodeType.DE_SparversandAusDemAusland
  Else If Value = 'DE_StandardversandAusDemAusland'	 Then Data :=  	 ShippingServiceCodeType.DE_StandardversandAusDemAusland
  Else If Value = 'DE_ExpressversandAusDemAusland'	 Then Data :=  	 ShippingServiceCodeType.DE_ExpressversandAusDemAusland
  Else If Value = 'DE_DHL2KGPaket'	 Then Data :=  	 ShippingServiceCodeType.DE_DHL2KGPaket
  Else If Value = 'InternationalPriorityShipping'	 Then Data :=  	 ShippingServiceCodeType.InternationalPriorityShipping
  Else If Value = 'SameDayShipping'	 Then Data :=  	 ShippingServiceCodeType.SameDayShipping
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShipmentDeliveryStatusCodeType);
Begin
       If Value ='Created'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.Created
  Else If Value = 'DroppedOff'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.DroppedOff
  Else If Value = 'InTransit'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.InTransit
  Else If Value = 'Delivered'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.Delivered
  Else If Value = 'Returned'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.Returned
  Else If Value = 'Canceled'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.Canceled
  Else If Value = 'LabelPrinted'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.LabelPrinted
  Else If Value = 'Unconfirmed'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.Unconfirmed
  Else If Value = 'Unknown'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.Unknown
  Else If Value = 'Error'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.Error
  Else If Value = 'CustomCode'	 Then Data :=  	 ShipmentDeliveryStatusCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShipmentStatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 ShipmentStatusCodeType.Active
  Else If Value = 'Canceled'	 Then Data :=  	 ShipmentStatusCodeType.Canceled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShippingFeatureCodeType);
Begin
       If Value ='DeliveryConfirmation'	 Then Data :=  	 ShippingFeatureCodeType.DeliveryConfirmation
  Else If Value = 'SignatureConfirmation'	 Then Data :=  	 ShippingFeatureCodeType.SignatureConfirmation
  Else If Value = 'StealthPostage'	 Then Data :=  	 ShippingFeatureCodeType.StealthPostage
  Else If Value = 'SaturdayDelivery'	 Then Data :=  	 ShippingFeatureCodeType.SaturdayDelivery
  Else If Value = 'Other'	 Then Data :=  	 ShippingFeatureCodeType.Other
  Else If Value = 'NotDefined'	 Then Data :=  	 ShippingFeatureCodeType.NotDefined
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MerchandizingPrefCodeType);
Begin
       If Value ='OptIn'	 Then Data :=  	 MerchandizingPrefCodeType.OptIn
  Else If Value = 'OptOut'	 Then Data :=  	 MerchandizingPrefCodeType.OptOut
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellerGuaranteeLevelCodeType);
Begin
       If Value ='NotEligible'	 Then Data :=  	 SellerGuaranteeLevelCodeType.NotEligible
  Else If Value = 'Regular'	 Then Data :=  	 SellerGuaranteeLevelCodeType.Regular
  Else If Value = 'Premium'	 Then Data :=  	 SellerGuaranteeLevelCodeType.Premium
  Else If Value = 'Ultra'	 Then Data :=  	 SellerGuaranteeLevelCodeType.Ultra
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PayoutMethodType);
Begin
       If Value ='PAYPAL'	 Then Data :=  	 PayoutMethodType.PAYPAL
  Else If Value = 'EFT'	 Then Data :=  	 PayoutMethodType.EFT
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellereBayPaymentProcessStatusCodeType);
Begin
       If Value ='AcceptedUA'	 Then Data :=  	 SellereBayPaymentProcessStatusCodeType.AcceptedUA
  Else If Value = 'MustAcceptUA'	 Then Data :=  	 SellereBayPaymentProcessStatusCodeType.MustAcceptUA
  Else If Value = 'eBayPaymentProcessEnabled'	 Then Data :=  	 SellereBayPaymentProcessStatusCodeType.EBayPaymentProcessEnabled
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : PaymentTypeCodeType);
Begin
       If Value ='Sale'	 Then Data :=  	 PaymentTypeCodeType.Sale
  Else If Value = 'Refund'	 Then Data :=  	 PaymentTypeCodeType.Refund
  Else If Value = 'SellerDeniedPayment'	 Then Data :=  	 PaymentTypeCodeType.SellerDeniedPayment
  Else If Value = 'AdminReversal'	 Then Data :=  	 PaymentTypeCodeType.AdminReversal
  Else If Value = 'AllOther'	 Then Data :=  	 PaymentTypeCodeType.AllOther
  Else If Value = 'RentalExtension'	 Then Data :=  	 PaymentTypeCodeType.RentalExtension
  Else If Value = 'RentalBuyout'	 Then Data :=  	 PaymentTypeCodeType.RentalBuyout
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : FedExRateOptionCodeType);
Begin
       If Value ='FedExStandardList'	 Then Data :=  	 FedExRateOptionCodeType.FedExStandardList
  Else If Value = 'FedExCounter'	 Then Data :=  	 FedExRateOptionCodeType.FedExCounter
  Else If Value = 'FedExDiscounted'	 Then Data :=  	 FedExRateOptionCodeType.FedExDiscounted
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : USPSRateOptionCodeType);
Begin
       If Value ='USPSDiscounted'	 Then Data :=  	 USPSRateOptionCodeType.USPSDiscounted
  Else If Value = 'USPSRetail'	 Then Data :=  	 USPSRateOptionCodeType.USPSRetail
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : UPSRateOptionCodeType);
Begin
       If Value ='UPSDailyRates'	 Then Data :=  	 UPSRateOptionCodeType.UPSDailyRates
  Else If Value = 'UPSOnDemandRates'	 Then Data :=  	 UPSRateOptionCodeType.UPSOnDemandRates
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisplayPayNowButtonCodeType);
Begin
       If Value ='ShowPayNowButtonForAllPaymentMethods'	 Then Data :=  	 DisplayPayNowButtonCodeType.ShowPayNowButtonForAllPaymentMethods
  Else If Value = 'ShowPayNowButtonForPayPalOnly'	 Then Data :=  	 DisplayPayNowButtonCodeType.ShowPayNowButtonForPayPalOnly
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreItemListSortOrderCodeType);
Begin
       If Value ='EndingFirst'	 Then Data :=  	 StoreItemListSortOrderCodeType.EndingFirst
  Else If Value = 'NewlyListed'	 Then Data :=  	 StoreItemListSortOrderCodeType.NewlyListed
  Else If Value = 'LowestPriced'	 Then Data :=  	 StoreItemListSortOrderCodeType.LowestPriced
  Else If Value = 'HighestPriced'	 Then Data :=  	 StoreItemListSortOrderCodeType.HighestPriced
  Else If Value = 'LowestPricedPlusShipping'	 Then Data :=  	 StoreItemListSortOrderCodeType.LowestPricedPlusShipping
  Else If Value = 'HighestPricedPlusShipping'	 Then Data :=  	 StoreItemListSortOrderCodeType.HighestPricedPlusShipping
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SearchStandingStatusCodeType);
Begin
       If Value ='Raised'	 Then Data :=  	 SearchStandingStatusCodeType.Raised
  Else If Value = 'Standard'	 Then Data :=  	 SearchStandingStatusCodeType.Standard
  Else If Value = 'Lowered'	 Then Data :=  	 SearchStandingStatusCodeType.Lowered
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerAutoRelistOptionCodeType);
Begin
       If Value ='RelistImmediately'	 Then Data :=  	 SellingManagerAutoRelistOptionCodeType.RelistImmediately
  Else If Value = 'RelistAfterDaysHours'	 Then Data :=  	 SellingManagerAutoRelistOptionCodeType.RelistAfterDaysHours
  Else If Value = 'RelistAtSpecificTimeOfDay'	 Then Data :=  	 SellingManagerAutoRelistOptionCodeType.RelistAtSpecificTimeOfDay
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerAutoRelistTypeCodeType);
Begin
       If Value ='RelistOnceIfNotSold'	 Then Data :=  	 SellingManagerAutoRelistTypeCodeType.RelistOnceIfNotSold
  Else If Value = 'RelistContinuouslyUntilSold'	 Then Data :=  	 SellingManagerAutoRelistTypeCodeType.RelistContinuouslyUntilSold
  Else If Value = 'RelistContinuously'	 Then Data :=  	 SellingManagerAutoRelistTypeCodeType.RelistContinuously
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellerAccountStatusCodeType);
Begin
       If Value ='Current'	 Then Data :=  	 SellerAccountStatusCodeType.Current
  Else If Value = 'PastDue'	 Then Data :=  	 SellerAccountStatusCodeType.PastDue
  Else If Value = 'OnHold'	 Then Data :=  	 SellerAccountStatusCodeType.OnHold
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : RangeCodeType);
Begin
       If Value ='High_'	 Then Data :=  	 RangeCodeType.High_
  Else If Value = 'Low_'	 Then Data :=  	 RangeCodeType.Low_
  {Else Result  := 	 ''};
End;*)

(*Procedure StrToEnum(Const Value: String ; Var Data : DateSpecifierCodeType);
Begin
       If Value ='M'	 Then Data :=  	 DateSpecifierCodeType.M
  Else If Value = 'D'	 Then Data :=  	 DateSpecifierCodeType.D
  Else If Value = 'Y'	 Then Data :=  	 DateSpecifierCodeType.Y
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerEmailSentStatusCodeType);
Begin
       If Value ='Successful'	 Then Data :=  	 SellingManagerEmailSentStatusCodeType.Successful
  Else If Value = 'Failed'	 Then Data :=  	 SellingManagerEmailSentStatusCodeType.Failed
  Else If Value = 'Pending'	 Then Data :=  	 SellingManagerEmailSentStatusCodeType.Pending
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerAutoSecondChanceOfferTypeCodeType);
Begin
       If Value ='BidsGreaterThanAmount'	 Then Data :=  	 SellingManagerAutoSecondChanceOfferTypeCodeType.BidsGreaterThanAmount
  Else If Value = 'BidsGreaterThanCostPlusAmount'	 Then Data :=  	 SellingManagerAutoSecondChanceOfferTypeCodeType.BidsGreaterThanCostPlusAmount
  Else If Value = 'BidsGreaterThanCostPlusPercentage'	 Then Data :=  	 SellingManagerAutoSecondChanceOfferTypeCodeType.BidsGreaterThanCostPlusPercentage
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerEmailTypeCodeType);
Begin
       If Value ='ManualEntry'	 Then Data :=  	 SellingManagerEmailTypeCodeType.ManualEntry
  Else If Value = 'WinningBuyerEmail'	 Then Data :=  	 SellingManagerEmailTypeCodeType.WinningBuyerEmail
  Else If Value = 'PaymentReminderEmail'	 Then Data :=  	 SellingManagerEmailTypeCodeType.PaymentReminderEmail
  Else If Value = 'PaymentReceivedEmail'	 Then Data :=  	 SellingManagerEmailTypeCodeType.PaymentReceivedEmail
  Else If Value = 'RequestForShippingAddressEmail'	 Then Data :=  	 SellingManagerEmailTypeCodeType.RequestForShippingAddressEmail
  Else If Value = 'FeedbackReminderEmail'	 Then Data :=  	 SellingManagerEmailTypeCodeType.FeedbackReminderEmail
  Else If Value = 'ShipmentSentEmail'	 Then Data :=  	 SellingManagerEmailTypeCodeType.ShipmentSentEmail
  Else If Value = 'PersonalizedEmail'	 Then Data :=  	 SellingManagerEmailTypeCodeType.PersonalizedEmail
  Else If Value = 'InvoiceNotification'	 Then Data :=  	 SellingManagerEmailTypeCodeType.InvoiceNotification
  Else If Value = 'CustomEmailTemplate1'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate1
  Else If Value = 'CustomEmailTemplate2'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate2
  Else If Value = 'CustomEmailTemplate3'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate3
  Else If Value = 'CustomEmailTemplate4'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate4
  Else If Value = 'CustomEmailTemplate5'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate5
  Else If Value = 'CustomEmailTemplate6'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate6
  Else If Value = 'CustomEmailTemplate7'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate7
  Else If Value = 'CustomEmailTemplate8'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate8
  Else If Value = 'CustomEmailTemplate9'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate9
  Else If Value = 'CustomEmailTemplate10'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate10
  Else If Value = 'CustomEmailTemplate11'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate11
  Else If Value = 'CustomEmailTemplate12'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate12
  Else If Value = 'CustomEmailTemplate13'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate13
  Else If Value = 'CustomEmailTemplate14'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate14
  Else If Value = 'CustomEmailTemplate15'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate15
  Else If Value = 'CustomEmailTemplate16'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate16
  Else If Value = 'CustomEmailTemplate17'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate17
  Else If Value = 'CustomEmailTemplate18'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate18
  Else If Value = 'CustomEmailTemplate19'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate19
  Else If Value = 'CustomEmailTemplate20'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomEmailTemplate20
  Else If Value = 'CustomCode'	 Then Data :=  	 SellingManagerEmailTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerAutomationPropertyTypeCodeType);
Begin
       If Value ='ItemListFailedAutomationRules'	 Then Data :=  	 SellingManagerAutomationPropertyTypeCodeType.ItemListFailedAutomationRules
  Else If Value = 'ItemRelistFailedAutomationRules'	 Then Data :=  	 SellingManagerAutomationPropertyTypeCodeType.ItemRelistFailedAutomationRules
  Else If Value = 'ItemListFailedSecondChanceOfferAutoRules'	 Then Data :=  	 SellingManagerAutomationPropertyTypeCodeType.ItemListFailedSecondChanceOfferAutoRules
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerPaisaPayPropertyTypeCodeType);
Begin
       If Value ='PaisaPayAwaitingShipment'	 Then Data :=  	 SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayAwaitingShipment
  Else If Value = 'PaisaPayTimeExtensionRequestDeclined'	 Then Data :=  	 SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayTimeExtensionRequestDeclined
  Else If Value = 'PaisaPayPendingReceived'	 Then Data :=  	 SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayPendingReceived
  Else If Value = 'PaisaPayRefundInitiated'	 Then Data :=  	 SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayRefundInitiated
  Else If Value = 'PaisaPayTimeExtensionRequested'	 Then Data :=  	 SellingManagerPaisaPayPropertyTypeCodeType.PaisaPayTimeExtensionRequested
  {Else Data :=   	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerAlertTypeCodeType);
Begin
       If Value ='Sold'	 Then Data :=  	 SellingManagerAlertTypeCodeType.Sold
  Else If Value = 'Inventory'	 Then Data :=  	 SellingManagerAlertTypeCodeType.Inventory
  Else If Value = 'Automation'	 Then Data :=  	 SellingManagerAlertTypeCodeType.Automation
  Else If Value = 'PaisaPay'	 Then Data :=  	 SellingManagerAlertTypeCodeType.PaisaPay
  Else If Value = 'General'	 Then Data :=  	 SellingManagerAlertTypeCodeType.General
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerGeneralPropertyTypeCodeType);
Begin
       If Value ='NegativeFeedbackReceived'	 Then Data :=  	 SellingManagerGeneralPropertyTypeCodeType.NegativeFeedbackReceived
  Else If Value = 'UnpaidItemDispute'	 Then Data :=  	 SellingManagerGeneralPropertyTypeCodeType.UnpaidItemDispute
  Else If Value = 'BadEmailTemplate'	 Then Data :=  	 SellingManagerGeneralPropertyTypeCodeType.BadEmailTemplate
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellerDashboardAlertSeverityCodeType);
Begin
       If Value ='Informational'	 Then Data :=  	 SellerDashboardAlertSeverityCodeType.Informational
  Else If Value = 'Warning'	 Then Data :=  	 SellerDashboardAlertSeverityCodeType.Warning
  Else If Value = 'StrongWarning'	 Then Data :=  	 SellerDashboardAlertSeverityCodeType.StrongWarning
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DayOfWeekCodeType);
Begin
       If Value ='Sunday'	 Then Data :=  	 DayOfWeekCodeType.Sunday
  Else If Value = 'Monday'	 Then Data :=  	 DayOfWeekCodeType.Monday
  Else If Value = 'Tuesday'	 Then Data :=  	 DayOfWeekCodeType.Tuesday
  Else If Value = 'Wednesday'	 Then Data :=  	 DayOfWeekCodeType.Wednesday
  Else If Value = 'Thursday'	 Then Data :=  	 DayOfWeekCodeType.Thursday
  Else If Value = 'Friday'	 Then Data :=  	 DayOfWeekCodeType.Friday
  Else If Value = 'Saturday'	 Then Data :=  	 DayOfWeekCodeType.Saturday
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShippingRegionCodeType);
Begin
       If Value ='Africa'	 Then Data :=  	 ShippingRegionCodeType.Africa
  Else If Value = 'Asia'	 Then Data :=  	 ShippingRegionCodeType.Asia
  Else If Value = 'Caribbean'	 Then Data :=  	 ShippingRegionCodeType.Caribbean
  Else If Value = 'Europe'	 Then Data :=  	 ShippingRegionCodeType.Europe
  Else If Value = 'LatinAmerica'	 Then Data :=  	 ShippingRegionCodeType.LatinAmerica
  Else If Value = 'MiddleEast'	 Then Data :=  	 ShippingRegionCodeType.MiddleEast
  Else If Value = 'NorthAmerica'	 Then Data :=  	 ShippingRegionCodeType.NorthAmerica
  Else If Value = 'Oceania'	 Then Data :=  	 ShippingRegionCodeType.Oceania
  Else If Value = 'SouthAmerica'	 Then Data :=  	 ShippingRegionCodeType.SouthAmerica
  Else If Value = 'EuropeanUnion'	 Then Data :=  	 ShippingRegionCodeType.EuropeanUnion
  Else If Value = 'WillNotShip'	 Then Data :=  	 ShippingRegionCodeType.WillNotShip
  Else If Value = 'Worldwide'	 Then Data :=  	 ShippingRegionCodeType.Worldwide
  Else If Value = 'Americas'	 Then Data :=  	 ShippingRegionCodeType.Americas
  Else If Value = 'None'	 Then Data :=  	 ShippingRegionCodeType.None
  Else If Value = 'CustomCode'	 Then Data :=  	 ShippingRegionCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : EBaySubscriptionTypeCodeType);
Begin
       If Value ='SellerAssistant'	 Then Data :=  	 EBaySubscriptionTypeCodeType.SellerAssistant
  Else If Value = 'SellerAssistantPro'	 Then Data :=  	 EBaySubscriptionTypeCodeType.SellerAssistantPro
  Else If Value = 'EBayStoreBasic'	 Then Data :=  	 EBaySubscriptionTypeCodeType.EBayStoreBasic
  Else If Value = 'EBayStoreFeatured'	 Then Data :=  	 EBaySubscriptionTypeCodeType.EBayStoreFeatured
  Else If Value = 'EBayStoreAnchor'	 Then Data :=  	 EBaySubscriptionTypeCodeType.EBayStoreAnchor
  Else If Value = 'SellingManager'	 Then Data :=  	 EBaySubscriptionTypeCodeType.SellingManager
  Else If Value = 'SellingManagerPro'	 Then Data :=  	 EBaySubscriptionTypeCodeType.SellingManagerPro
  Else If Value = 'PictureManagerLevel1'	 Then Data :=  	 EBaySubscriptionTypeCodeType.PictureManagerLevel1
  Else If Value = 'PictureManagerLevel2'	 Then Data :=  	 EBaySubscriptionTypeCodeType.PictureManagerLevel2
  Else If Value = 'PictureManagerLevel3'	 Then Data :=  	 EBaySubscriptionTypeCodeType.PictureManagerLevel3
  Else If Value = 'PictureManagerLevel4'	 Then Data :=  	 EBaySubscriptionTypeCodeType.PictureManagerLevel4
  Else If Value = 'PictureManagerLevel5'	 Then Data :=  	 EBaySubscriptionTypeCodeType.PictureManagerLevel5
  Else If Value = 'PictureManagerLevel6'	 Then Data :=  	 EBaySubscriptionTypeCodeType.PictureManagerLevel6
  Else If Value = 'PictureManagerLevel7'	 Then Data :=  	 EBaySubscriptionTypeCodeType.PictureManagerLevel7
  Else If Value = 'SellerReportsBasic'	 Then Data :=  	 EBaySubscriptionTypeCodeType.SellerReportsBasic
  Else If Value = 'SellerReportsPlus'	 Then Data :=  	 EBaySubscriptionTypeCodeType.SellerReportsPlus
  Else If Value = 'FileExchange'	 Then Data :=  	 EBaySubscriptionTypeCodeType.FileExchange
  Else If Value = 'LocalMarketSpecialty'	 Then Data :=  	 EBaySubscriptionTypeCodeType.LocalMarketSpecialty
  Else If Value = 'LocalMarketRegular'	 Then Data :=  	 EBaySubscriptionTypeCodeType.LocalMarketRegular
  Else If Value = 'LocalMarketPremium'	 Then Data :=  	 EBaySubscriptionTypeCodeType.LocalMarketPremium
  Else If Value = 'CustomCode'	 Then Data :=  	 EBaySubscriptionTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : VeROItemStatusCodeType);
Begin
       If Value ='Received'	 Then Data :=  	 VeROItemStatusCodeType.Received
  Else If Value = 'Submitted'	 Then Data :=  	 VeROItemStatusCodeType.Submitted
  Else If Value = 'Removed'	 Then Data :=  	 VeROItemStatusCodeType.Removed
  Else If Value = 'SubmissionFailed'	 Then Data :=  	 VeROItemStatusCodeType.SubmissionFailed
  Else If Value = 'ClarificationRequired'	 Then Data :=  	 VeROItemStatusCodeType.ClarificationRequired
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MismatchTypeCodeType);
Begin
       If Value ='OverPayment'	 Then Data :=  	 MismatchTypeCodeType.OverPayment
  Else If Value = 'UnderPayment'	 Then Data :=  	 MismatchTypeCodeType.UnderPayment
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PayPalAccountStatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 PayPalAccountStatusCodeType.Active
  Else If Value = 'Closed'	 Then Data :=  	 PayPalAccountStatusCodeType.Closed
  Else If Value = 'HighRestricted'	 Then Data :=  	 PayPalAccountStatusCodeType.HighRestricted
  Else If Value = 'LowRestricted'	 Then Data :=  	 PayPalAccountStatusCodeType.LowRestricted
  Else If Value = 'Locked'	 Then Data :=  	 PayPalAccountStatusCodeType.Locked
  Else If Value = 'CustomCode'	 Then Data :=  	 PayPalAccountStatusCodeType.CustomCode
  Else If Value = 'WireOff'	 Then Data :=  	 PayPalAccountStatusCodeType.WireOff
  Else If Value = 'Unknown'	 Then Data :=  	 PayPalAccountStatusCodeType.Unknown
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreSubscriptionLevelCodeType);
Begin
       If Value ='Close'	 Then Data :=  	 StoreSubscriptionLevelCodeType.Close
  Else If Value = 'Basic'	 Then Data :=  	 StoreSubscriptionLevelCodeType.Basic
  Else If Value = 'Featured'	 Then Data :=  	 StoreSubscriptionLevelCodeType.Featured
  Else If Value = 'Anchor'	 Then Data :=  	 StoreSubscriptionLevelCodeType.Anchor
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreFontSizeCodeType);
Begin
       If Value ='XXS'	 Then Data :=  	 StoreFontSizeCodeType.XXS
  Else If Value = 'XS'	 Then Data :=  	 StoreFontSizeCodeType.XS
  Else If Value = 'S'	 Then Data :=  	 StoreFontSizeCodeType.S
  Else If Value = 'M'	 Then Data :=  	 StoreFontSizeCodeType.M
  Else If Value = 'L'	 Then Data :=  	 StoreFontSizeCodeType.L
  Else If Value = 'XL'	 Then Data :=  	 StoreFontSizeCodeType.XL
  Else If Value = 'XXL'	 Then Data :=  	 StoreFontSizeCodeType.XXL
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MerchDisplayCodeType);
Begin
       If Value ='DefaultTheme'	 Then Data :=  	 MerchDisplayCodeType.DefaultTheme
  Else If Value = 'StoreTheme'	 Then Data :=  	 MerchDisplayCodeType.StoreTheme
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreCustomHeaderLayoutCodeType);
Begin
       If Value ='NoHeader'	 Then Data :=  	 StoreCustomHeaderLayoutCodeType.NoHeader
  Else If Value = 'CustomHeaderShown'	 Then Data :=  	 StoreCustomHeaderLayoutCodeType.CustomHeaderShown
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreHeaderStyleCodeType);
Begin
       If Value ='Full'	 Then Data :=  	 StoreHeaderStyleCodeType.Full
  Else If Value = 'Minimized'	 Then Data :=  	 StoreHeaderStyleCodeType.Minimized
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreItemListLayoutCodeType);
Begin
       If Value ='ListView'	 Then Data :=  	 StoreItemListLayoutCodeType.ListView
  Else If Value = 'GalleryView'	 Then Data :=  	 StoreItemListLayoutCodeType.GalleryView
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreFontFaceCodeType);
Begin
       If Value ='Arial'	 Then Data :=  	 StoreFontFaceCodeType.Arial
  Else If Value = 'Courier'	 Then Data :=  	 StoreFontFaceCodeType.Courier
  Else If Value = 'Times'	 Then Data :=  	 StoreFontFaceCodeType.Times
  Else If Value = 'Verdana'	 Then Data :=  	 StoreFontFaceCodeType.Verdana
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PictureFormatCodeType);
Begin
       If Value ='JPG'	 Then Data :=  	 PictureFormatCodeType.JPG
  Else If Value = 'GIF'	 Then Data :=  	 PictureFormatCodeType.GIF
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreCustomListingHeaderDisplayCodeType);
Begin
       If Value ='None'	 Then Data :=  	 StoreCustomListingHeaderDisplayCodeType.None
  Else If Value = 'Full'	 Then Data :=  	 StoreCustomListingHeaderDisplayCodeType.Full
  Else If Value = 'FullAndLeftNavigationBar'	 Then Data :=  	 StoreCustomListingHeaderDisplayCodeType.FullAndLeftNavigationBar
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreCustomPageStatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 StoreCustomPageStatusCodeType.Active
  Else If Value = 'Delete'	 Then Data :=  	 StoreCustomPageStatusCodeType.Delete
  Else If Value = 'Inactive'	 Then Data :=  	 StoreCustomPageStatusCodeType.Inactive
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreCustomListingHeaderLinkCodeType);
Begin
       If Value ='None'	 Then Data :=  	 StoreCustomListingHeaderLinkCodeType.None
  Else If Value = 'AboutMePage'	 Then Data :=  	 StoreCustomListingHeaderLinkCodeType.AboutMePage
  Else If Value = 'CustomPage'	 Then Data :=  	 StoreCustomListingHeaderLinkCodeType.CustomPage
  Else If Value = 'CustomCategory'	 Then Data :=  	 StoreCustomListingHeaderLinkCodeType.CustomCategory
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SummaryWindowPeriodCodeType);
Begin
       If Value ='Last24Hours'	 Then Data :=  	 SummaryWindowPeriodCodeType.Last24Hours
  Else If Value = 'Last7Days'	 Then Data :=  	 SummaryWindowPeriodCodeType.Last7Days
  Else If Value = 'Last31Days'	 Then Data :=  	 SummaryWindowPeriodCodeType.Last31Days
  Else If Value = 'CurrentWeek'	 Then Data :=  	 SummaryWindowPeriodCodeType.CurrentWeek
  Else If Value = 'LastWeek'	 Then Data :=  	 SummaryWindowPeriodCodeType.LastWeek
  Else If Value = 'CurrentMonth'	 Then Data :=  	 SummaryWindowPeriodCodeType.CurrentMonth
  Else If Value = 'LastMonth'	 Then Data :=  	 SummaryWindowPeriodCodeType.LastMonth
  Else If Value = 'Last60Days'	 Then Data :=  	 SummaryWindowPeriodCodeType.Last60Days
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : UnpaidItemCaseOpenTypeCodeType);
Begin
       If Value ='Auto'	 Then Data :=  	 UnpaidItemCaseOpenTypeCodeType.Auto
  Else If Value = 'Manual'	 Then Data :=  	 UnpaidItemCaseOpenTypeCodeType.Manual
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : UserIdentityCodeType);
Begin
       If Value ='eBayUser'	 Then Data :=  	 UserIdentityCodeType.EBayUser
  Else If Value = 'eBayPartner'	 Then Data :=  	 UserIdentityCodeType.EBayPartner
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : UnpaidItemCaseStatusTypeCodeType);
Begin
       If Value ='Open'	 Then Data :=  	 UnpaidItemCaseStatusTypeCodeType.Open
  Else If Value = 'ClosedWithPayment'	 Then Data :=  	 UnpaidItemCaseStatusTypeCodeType.ClosedWithPayment
  Else If Value = 'ClosedWithoutPayment'	 Then Data :=  	 UnpaidItemCaseStatusTypeCodeType.ClosedWithoutPayment
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : URLTypeCodeType);
Begin
       If Value ='ViewItemURL'	 Then Data :=  	 URLTypeCodeType.ViewItemURL
  Else If Value = 'ViewUserURL'	 Then Data :=  	 URLTypeCodeType.ViewUserURL
  Else If Value = 'MyeBayURL'	 Then Data :=  	 URLTypeCodeType.MyeBayURL
  Else If Value = 'MyeBayBiddingURL'	 Then Data :=  	 URLTypeCodeType.MyeBayBiddingURL
  Else If Value = 'MyeBayNotWonURL'	 Then Data :=  	 URLTypeCodeType.MyeBayNotWonURL
  Else If Value = 'MyeBayWonURL'	 Then Data :=  	 URLTypeCodeType.MyeBayWonURL
  Else If Value = 'MyeBayWatchingURL'	 Then Data :=  	 URLTypeCodeType.MyeBayWatchingURL
  Else If Value = 'eBayStoreURL'	 Then Data :=  	 URLTypeCodeType.EBayStoreURL
  Else If Value = 'SmallLogoURL'	 Then Data :=  	 URLTypeCodeType.SmallLogoURL
  Else If Value = 'MediumLogoURL'	 Then Data :=  	 URLTypeCodeType.MediumLogoURL
  Else If Value = 'LargeLogoURL'	 Then Data :=  	 URLTypeCodeType.LargeLogoURL
  Else If Value = 'CustomCode'	 Then Data :=  	 URLTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeedbackRatingStarCodeType);
Begin
       If Value ='None'	 Then Data :=  	 FeedbackRatingStarCodeType.None
  Else If Value = 'Yellow'	 Then Data :=  	 FeedbackRatingStarCodeType.Yellow
  Else If Value = 'Blue'	 Then Data :=  	 FeedbackRatingStarCodeType.Blue
  Else If Value = 'Turquoise'	 Then Data :=  	 FeedbackRatingStarCodeType.Turquoise
  Else If Value = 'Purple'	 Then Data :=  	 FeedbackRatingStarCodeType.Purple
  Else If Value = 'Red'	 Then Data :=  	 FeedbackRatingStarCodeType.Red
  Else If Value = 'Green'	 Then Data :=  	 FeedbackRatingStarCodeType.Green
  Else If Value = 'YellowShooting'	 Then Data :=  	 FeedbackRatingStarCodeType.YellowShooting
  Else If Value = 'TurquoiseShooting'	 Then Data :=  	 FeedbackRatingStarCodeType.TurquoiseShooting
  Else If Value = 'PurpleShooting'	 Then Data :=  	 FeedbackRatingStarCodeType.PurpleShooting
  Else If Value = 'RedShooting'	 Then Data :=  	 FeedbackRatingStarCodeType.RedShooting
  Else If Value = 'GreenShooting'	 Then Data :=  	 FeedbackRatingStarCodeType.GreenShooting
  Else If Value = 'SilverShooting'	 Then Data :=  	 FeedbackRatingStarCodeType.SilverShooting
  Else If Value = 'CustomCode'	 Then Data :=  	 FeedbackRatingStarCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PayPalAccountLevelCodeType);
Begin
       If Value ='Unverified'	 Then Data :=  	 PayPalAccountLevelCodeType.Unverified
  Else If Value = 'InternationalUnverified'	 Then Data :=  	 PayPalAccountLevelCodeType.InternationalUnverified
  Else If Value = 'Verified'	 Then Data :=  	 PayPalAccountLevelCodeType.Verified
  Else If Value = 'InternationalVerified'	 Then Data :=  	 PayPalAccountLevelCodeType.InternationalVerified
  Else If Value = 'Trusted'	 Then Data :=  	 PayPalAccountLevelCodeType.Trusted
  Else If Value = 'Unknown'	 Then Data :=  	 PayPalAccountLevelCodeType.Unknown
  Else If Value = 'Invalid'	 Then Data :=  	 PayPalAccountLevelCodeType.Invalid
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PayPalAccountTypeCodeType);
Begin
       If Value ='Personal'	 Then Data :=  	 PayPalAccountTypeCodeType.Personal
  Else If Value = 'Premier'	 Then Data :=  	 PayPalAccountTypeCodeType.Premier
  Else If Value = 'Business'	 Then Data :=  	 PayPalAccountTypeCodeType.Business
  Else If Value = 'Unknown'	 Then Data :=  	 PayPalAccountTypeCodeType.Unknown
  Else If Value = 'Invalid'	 Then Data :=  	 PayPalAccountTypeCodeType.Invalid
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BusinessRoleType);
Begin
       If Value ='Shopper'	 Then Data :=  	 BusinessRoleType.Shopper
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : UserStatusCodeType);
Begin
       If Value ='Unknown'	 Then Data :=  	 UserStatusCodeType.Unknown
  Else If Value = 'Suspended'	 Then Data :=  	 UserStatusCodeType.Suspended
  Else If Value = 'Confirmed'	 Then Data :=  	 UserStatusCodeType.Confirmed
  Else If Value = 'Unconfirmed'	 Then Data :=  	 UserStatusCodeType.Unconfirmed
  Else If Value = 'Ghost'	 Then Data :=  	 UserStatusCodeType.Ghost
  Else If Value = 'InMaintenance'	 Then Data :=  	 UserStatusCodeType.InMaintenance
  Else If Value = 'Deleted'	 Then Data :=  	 UserStatusCodeType.Deleted
  Else If Value = 'CreditCardVerify'	 Then Data :=  	 UserStatusCodeType.CreditCardVerify
  Else If Value = 'AccountOnHold'	 Then Data :=  	 UserStatusCodeType.AccountOnHold
  Else If Value = 'Merged'	 Then Data :=  	 UserStatusCodeType.Merged
  Else If Value = 'RegistrationCodeMailOut'	 Then Data :=  	 UserStatusCodeType.RegistrationCodeMailOut
  Else If Value = 'TermPending'	 Then Data :=  	 UserStatusCodeType.TermPending
  Else If Value = 'UnconfirmedHalfOptIn'	 Then Data :=  	 UserStatusCodeType.UnconfirmedHalfOptIn
  Else If Value = 'CreditCardVerifyHalfOptIn'	 Then Data :=  	 UserStatusCodeType.CreditCardVerifyHalfOptIn
  Else If Value = 'UnconfirmedPassport'	 Then Data :=  	 UserStatusCodeType.UnconfirmedPassport
  Else If Value = 'CreditCardVerifyPassport'	 Then Data :=  	 UserStatusCodeType.CreditCardVerifyPassport
  Else If Value = 'UnconfirmedExpress'	 Then Data :=  	 UserStatusCodeType.UnconfirmedExpress
  Else If Value = 'Guest'	 Then Data :=  	 UserStatusCodeType.Guest
  Else If Value = 'CustomCode'	 Then Data :=  	 UserStatusCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : VATStatusCodeType);
Begin
       If Value ='NoVATTax'	 Then Data :=  	 VATStatusCodeType.NoVATTax
  Else If Value = 'VATTax'	 Then Data :=  	 VATStatusCodeType.VATTax
  Else If Value = 'VATExempt'	 Then Data :=  	 VATStatusCodeType.VATExempt
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TaxTypeCodeType);
Begin
       If Value ='SalesTax'	 Then Data :=  	 TaxTypeCodeType.SalesTax
  Else If Value = 'WasteRecyclingFee'	 Then Data :=  	 TaxTypeCodeType.WasteRecyclingFee
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TaxDescriptionCodeType);
Begin
       If Value ='SalesTax'	 Then Data :=  	 TaxDescriptionCodeType.SalesTax
  Else If Value = 'ElectronicWasteRecyclingFee'	 Then Data :=  	 TaxDescriptionCodeType.ElectronicWasteRecyclingFee
  Else If Value = 'TireRecyclingFee'	 Then Data :=  	 TaxDescriptionCodeType.TireRecyclingFee
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SummaryFrequencyCodeType);
Begin
       If Value ='EverySunday'	 Then Data :=  	 SummaryFrequencyCodeType.EverySunday
  Else If Value = 'EveryMonday'	 Then Data :=  	 SummaryFrequencyCodeType.EveryMonday
  Else If Value = 'EveryTuesday'	 Then Data :=  	 SummaryFrequencyCodeType.EveryTuesday
  Else If Value = 'EveryWednesday'	 Then Data :=  	 SummaryFrequencyCodeType.EveryWednesday
  Else If Value = 'EveryThursday'	 Then Data :=  	 SummaryFrequencyCodeType.EveryThursday
  Else If Value = 'EveryFriday'	 Then Data :=  	 SummaryFrequencyCodeType.EveryFriday
  Else If Value = 'EverySaturday'	 Then Data :=  	 SummaryFrequencyCodeType.EverySaturday
  Else If Value = 'MonthlyOn1st'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn1st
  Else If Value = 'MonthlyOn2nd'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn2nd
  Else If Value = 'MonthlyOn3rd'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn3rd
  Else If Value = 'MonthlyOn4th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn4th
  Else If Value = 'MonthlyOn5th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn5th
  Else If Value = 'MonthlyOn6th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn6th
  Else If Value = 'MonthlyOn7th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn7th
  Else If Value = 'MonthlyOn8th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn8th
  Else If Value = 'MonthlyOn9th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn9th
  Else If Value = 'MonthlyOn10th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn10th
  Else If Value = 'MonthlyOn11th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn11th
  Else If Value = 'MonthlyOn12th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn12th
  Else If Value = 'MonthlyOn13th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn13th
  Else If Value = 'MonthlyOn14th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn14th
  Else If Value = 'MonthlyOn15th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn15th
  Else If Value = 'MonthlyOn16th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn16th
  Else If Value = 'MonthlyOn17th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn17th
  Else If Value = 'MonthlyOn18th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn18th
  Else If Value = 'MonthlyOn19th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn19th
  Else If Value = 'MonthlyOn20th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn20th
  Else If Value = 'MonthlyOn21st'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn21st
  Else If Value = 'MonthlyOn22nd'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn22nd
  Else If Value = 'MonthlyOn23rd'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn23rd
  Else If Value = 'MonthlyOn24th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn24th
  Else If Value = 'MonthlyOn25th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn25th
  Else If Value = 'MonthlyOn26th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn26th
  Else If Value = 'MonthlyOn27th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn27th
  Else If Value = 'MonthlyOn28th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn28th
  Else If Value = 'MonthlyOn29th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn29th
  Else If Value = 'MonthlyOn30th'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn30th
  Else If Value = 'MonthlyOn31st'	 Then Data :=  	 SummaryFrequencyCodeType.MonthlyOn31st
  Else If Value = 'Every31Days'	 Then Data :=  	 SummaryFrequencyCodeType.Every31Days
  Else If Value = 'Every60Days'	 Then Data :=  	 SummaryFrequencyCodeType.Every60Days
  Else If Value = 'CustomCode'	 Then Data :=  	 SummaryFrequencyCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PaidStatusCodeType);
Begin
       If Value ='NotPaid'	 Then Data :=  	 PaidStatusCodeType.NotPaid
  Else If Value = 'BuyerHasNotCompletedCheckout'	 Then Data :=  	 PaidStatusCodeType.BuyerHasNotCompletedCheckout
  Else If Value = 'PaymentPendingWithPayPal'	 Then Data :=  	 PaidStatusCodeType.PaymentPendingWithPayPal
  Else If Value = 'PaidWithPayPal'	 Then Data :=  	 PaidStatusCodeType.PaidWithPayPal
  Else If Value = 'MarkedAsPaid'	 Then Data :=  	 PaidStatusCodeType.MarkedAsPaid
  Else If Value = 'PaymentPendingWithEscrow'	 Then Data :=  	 PaidStatusCodeType.PaymentPendingWithEscrow
  Else If Value = 'PaidWithEscrow'	 Then Data :=  	 PaidStatusCodeType.PaidWithEscrow
  Else If Value = 'EscrowPaymentCancelled'	 Then Data :=  	 PaidStatusCodeType.EscrowPaymentCancelled
  Else If Value = 'PaymentPendingWithPaisaPay'	 Then Data :=  	 PaidStatusCodeType.PaymentPendingWithPaisaPay
  Else If Value = 'PaidWithPaisaPay'	 Then Data :=  	 PaidStatusCodeType.PaidWithPaisaPay
  Else If Value = 'PaymentPending'	 Then Data :=  	 PaidStatusCodeType.PaymentPending
  Else If Value = 'PaymentPendingWithPaisaPayEscrow'	 Then Data :=  	 PaidStatusCodeType.PaymentPendingWithPaisaPayEscrow
  Else If Value = 'PaidWithPaisaPayEscrow'	 Then Data :=  	 PaidStatusCodeType.PaidWithPaisaPayEscrow
  Else If Value = 'PaisaPayNotPaid'	 Then Data :=  	 PaidStatusCodeType.PaisaPayNotPaid
  Else If Value = 'Refunded'	 Then Data :=  	 PaidStatusCodeType.Refunded
  Else If Value = 'WaitingForCODPayment'	 Then Data :=  	 PaidStatusCodeType.WaitingForCODPayment
  Else If Value = 'PaidCOD'	 Then Data :=  	 PaidStatusCodeType.PaidCOD
  Else If Value = 'CustomCode'	 Then Data :=  	 PaidStatusCodeType.CustomCode
  Else If Value = 'Paid'	 Then Data :=  	 PaidStatusCodeType.Paid
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TransactionReferenceCodeType);
Begin
       If Value ='ExternalTransactionID'	 Then Data :=  	 TransactionReferenceCodeType.ExternalTransactionID
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TokenStatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 TokenStatusCodeType.Active
  Else If Value = 'Expired'	 Then Data :=  	 TokenStatusCodeType.Expired
  Else If Value = 'RevokedByeBay'	 Then Data :=  	 TokenStatusCodeType.RevokedByeBay
  Else If Value = 'RevokedByUser'	 Then Data :=  	 TokenStatusCodeType.RevokedByUser
  Else If Value = 'RevokedByApp'	 Then Data :=  	 TokenStatusCodeType.RevokedByApp
  Else If Value = 'Invalid'	 Then Data :=  	 TokenStatusCodeType.Invalid
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TopRatedProgramCodeType);
Begin
       If Value ='US'	 Then Data :=  	 TopRatedProgramCodeType.US
  Else If Value = 'UK'	 Then Data :=  	 TopRatedProgramCodeType.UK
  Else If Value = 'DE'	 Then Data :=  	 TopRatedProgramCodeType.DE
  Else If Value = 'Global'	 Then Data :=  	 TopRatedProgramCodeType.Global
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ReasonHideFromSearchCodeType);
Begin
       If Value ='DuplicateListing'	 Then Data :=  	 ReasonHideFromSearchCodeType.DuplicateListing
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BoldTitleCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 BoldTitleCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 BoldTitleCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BorderCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 BorderCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 BorderCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : HighlightCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 HighlightCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 HighlightCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellerBusinessCodeType);
Begin
       If Value ='Undefined'	 Then Data :=  	 SellerBusinessCodeType.Undefined
  Else If Value = 'Private_'	 Then Data :=  	 SellerBusinessCodeType.Private_
  Else If Value = 'Commercial'	 Then Data :=  	 SellerBusinessCodeType.Commercial
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : SkypeContactOptionCodeType);
Begin
       If Value ='Chat'	 Then Data :=  	 SkypeContactOptionCodeType.Chat
  Else If Value = 'Voice'	 Then Data :=  	 SkypeContactOptionCodeType.Voice
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : QuantityAvailableHintCodeType);
Begin
       If Value ='Limited'	 Then Data :=  	 QuantityAvailableHintCodeType.Limited
  Else If Value = 'MoreThan'	 Then Data :=  	 QuantityAvailableHintCodeType.MoreThan
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ListingSubtypeCodeType);
Begin
       If Value ='ClassifiedAd'	 Then Data :=  	 ListingSubtypeCodeType.ClassifiedAd
  Else If Value = 'LocalMarketBestOfferOnly'	 Then Data :=  	 ListingSubtypeCodeType.LocalMarketBestOfferOnly
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : GiftIconCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 GiftIconCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 GiftIconCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PeriodCodeType);
Begin
       If Value ='Days_1'	 Then Data :=  	 PeriodCodeType.Days_1
  Else If Value = 'Days_30'	 Then Data :=  	 PeriodCodeType.Days_30
  Else If Value = 'Days_180'	 Then Data :=  	 PeriodCodeType.Days_180
  Else If Value = 'Days_360'	 Then Data :=  	 PeriodCodeType.Days_360
  Else If Value = 'Days_540'	 Then Data :=  	 PeriodCodeType.Days_540
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : QuestionTypeCodeType);
Begin
       If Value ='General'	 Then Data :=  	 QuestionTypeCodeType.General
  Else If Value = 'Shipping'	 Then Data :=  	 QuestionTypeCodeType.Shipping
  Else If Value = 'Payment'	 Then Data :=  	 QuestionTypeCodeType.Payment
  Else If Value = 'MultipleItemShipping'	 Then Data :=  	 QuestionTypeCodeType.MultipleItemShipping
  Else If Value = 'CustomizedSubject'	 Then Data :=  	 QuestionTypeCodeType.CustomizedSubject
  Else If Value = 'None'	 Then Data :=  	 QuestionTypeCodeType.None
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ProPackCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 ProPackCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 ProPackCodeType.Disabled
  Else If Value = 'PowerSellerOnly'	 Then Data :=  	 ProPackCodeType.PowerSellerOnly
  Else If Value = 'TopRatedSellerOnly'	 Then Data :=  	 ProPackCodeType.TopRatedSellerOnly
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : HomePageFeaturedCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 HomePageFeaturedCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 HomePageFeaturedCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeaturedFirstCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 FeaturedFirstCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 FeaturedFirstCodeType.Disabled
  Else If Value = 'PowerSellerOnly'	 Then Data :=  	 FeaturedFirstCodeType.PowerSellerOnly
  Else If Value = 'TopRatedSellerOnly'	 Then Data :=  	 FeaturedFirstCodeType.TopRatedSellerOnly
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeaturedPlusCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 FeaturedPlusCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 FeaturedPlusCodeType.Disabled
  Else If Value = 'PowerSellerOnly'	 Then Data :=  	 FeaturedPlusCodeType.PowerSellerOnly
  Else If Value = 'TopRatedSellerOnly'	 Then Data :=  	 FeaturedPlusCodeType.TopRatedSellerOnly
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MarkUpMarkDownEventTypeCodeType);
Begin
       If Value ='MarkUp'	 Then Data :=  	 MarkUpMarkDownEventTypeCodeType.MarkUp
  Else If Value = 'MarkDown'	 Then Data :=  	 MarkUpMarkDownEventTypeCodeType.MarkDown
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FlatRateInsuranceRangeCodeType);
Begin
       If Value ='FlatRateInsuranceRange1'	 Then Data :=  	 FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange1
  Else If Value = 'FlatRateInsuranceRange2'	 Then Data :=  	 FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange2
  Else If Value = 'FlatRateInsuranceRange3'	 Then Data :=  	 FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange3
  Else If Value = 'FlatRateInsuranceRange4'	 Then Data :=  	 FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange4
  Else If Value = 'FlatRateInsuranceRange5'	 Then Data :=  	 FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange5
  Else If Value = 'FlatRateInsuranceRange6'	 Then Data :=  	 FlatRateInsuranceRangeCodeType.FlatRateInsuranceRange6
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FlatShippingRateOptionCodeType);
Begin
       If Value ='ChargeAmountForEachAdditionalItem'	 Then Data :=  	 FlatShippingRateOptionCodeType.ChargeAmountForEachAdditionalItem
  Else If Value = 'DeductAmountFromEachAdditionalItem'	 Then Data :=  	 FlatShippingRateOptionCodeType.DeductAmountFromEachAdditionalItem
  Else If Value = 'ShipAdditionalItemsFree'	 Then Data :=  	 FlatShippingRateOptionCodeType.ShipAdditionalItemsFree
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : ListingFlowCodeType);
Begin
       If Value ='AddItem'	 Then Data :=  	 ListingFlowCodeType.AddItem
  Else If Value = 'ReviseItem'	 Then Data :=  	 ListingFlowCodeType.ReviseItem
  Else If Value = 'RelistItem'	 Then Data :=  	 ListingFlowCodeType.RelistItem
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : OrderStatusFilterCodeType);
Begin
       If Value ='All'	 Then Data :=  	 OrderStatusFilterCodeType.All
  Else If Value = 'AwaitingPayment'	 Then Data :=  	 OrderStatusFilterCodeType.AwaitingPayment
  Else If Value = 'AwaitingShipment'	 Then Data :=  	 OrderStatusFilterCodeType.AwaitingShipment
  Else If Value = 'PaidAndShipped'	 Then Data :=  	 OrderStatusFilterCodeType.PaidAndShipped
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ListingEnhancementsCodeType);
Begin
       If Value ='Border'	 Then Data :=  	 ListingEnhancementsCodeType.Border
  Else If Value = 'BoldTitle'	 Then Data :=  	 ListingEnhancementsCodeType.BoldTitle
  Else If Value = 'Featured'	 Then Data :=  	 ListingEnhancementsCodeType.Featured
  Else If Value = 'Highlight'	 Then Data :=  	 ListingEnhancementsCodeType.Highlight
  Else If Value = 'HomePageFeatured'	 Then Data :=  	 ListingEnhancementsCodeType.HomePageFeatured
  Else If Value = 'ProPackBundle'	 Then Data :=  	 ListingEnhancementsCodeType.ProPackBundle
  Else If Value = 'BasicUpgradePackBundle'	 Then Data :=  	 ListingEnhancementsCodeType.BasicUpgradePackBundle
  Else If Value = 'ValuePackBundle'	 Then Data :=  	 ListingEnhancementsCodeType.ValuePackBundle
  Else If Value = 'ProPackPlusBundle'	 Then Data :=  	 ListingEnhancementsCodeType.ProPackPlusBundle
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DescriptionReviseModeCodeType);
Begin
       If Value ='Replace'	 Then Data :=  	 DescriptionReviseModeCodeType.Replace
  Else If Value = 'Prepend'	 Then Data :=  	 DescriptionReviseModeCodeType.Prepend
  Else If Value = 'Append'	 Then Data :=  	 DescriptionReviseModeCodeType.Append
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : GiftServicesCodeType);
Begin
       If Value ='GiftExpressShipping'	 Then Data :=  	 GiftServicesCodeType.GiftExpressShipping
  Else If Value = 'GiftShipToRecipient'	 Then Data :=  	 GiftServicesCodeType.GiftShipToRecipient
  Else If Value = 'GiftWrap'	 Then Data :=  	 GiftServicesCodeType.GiftWrap
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : HitCounterCodeType);
Begin
       If Value ='NoHitCounter'	 Then Data :=  	 HitCounterCodeType.NoHitCounter
  Else If Value = 'HonestyStyle'	 Then Data :=  	 HitCounterCodeType.HonestyStyle
  Else If Value = 'GreenLED'	 Then Data :=  	 HitCounterCodeType.GreenLED
  Else If Value = 'Hidden'	 Then Data :=  	 HitCounterCodeType.Hidden
  Else If Value = 'BasicStyle'	 Then Data :=  	 HitCounterCodeType.BasicStyle
  Else If Value = 'RetroStyle'	 Then Data :=  	 HitCounterCodeType.RetroStyle
  Else If Value = 'HiddenStyle'	 Then Data :=  	 HitCounterCodeType.HiddenStyle
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : RecommendationEngineCodeType);
Begin
       If Value ='ListingAnalyzer'	 Then Data :=  	 RecommendationEngineCodeType.ListingAnalyzer
  Else If Value = 'SIFFTAS'	 Then Data :=  	 RecommendationEngineCodeType.SIFFTAS
  Else If Value = 'ProductPricing'	 Then Data :=  	 RecommendationEngineCodeType.ProductPricing
  Else If Value = 'CustomCode'	 Then Data :=  	 RecommendationEngineCodeType.CustomCode
  Else If Value = 'SuggestedAttributes'	 Then Data :=  	 RecommendationEngineCodeType.SuggestedAttributes
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : SiteCodeType);
Begin
       If Value ='US'	 Then Data :=  	 SiteCodeType.US
  Else If Value = 'Canada'	 Then Data :=  	 SiteCodeType.Canada
  Else If Value = 'UK'	 Then Data :=  	 SiteCodeType.UK
  Else If Value = 'Australia'	 Then Data :=  	 SiteCodeType.Australia
  Else If Value = 'Austria'	 Then Data :=  	 SiteCodeType.Austria
  Else If Value = 'Belgium_French'	 Then Data :=  	 SiteCodeType.Belgium_French
  Else If Value = 'France'	 Then Data :=  	 SiteCodeType.France
  Else If Value = 'Germany'	 Then Data :=  	 SiteCodeType.Germany
  Else If Value = 'Italy'	 Then Data :=  	 SiteCodeType.Italy
  Else If Value = 'Belgium_Dutch'	 Then Data :=  	 SiteCodeType.Belgium_Dutch
  Else If Value = 'Netherlands'	 Then Data :=  	 SiteCodeType.Netherlands
  Else If Value = 'Spain'	 Then Data :=  	 SiteCodeType.Spain
  Else If Value = 'Switzerland'	 Then Data :=  	 SiteCodeType.Switzerland
  Else If Value = 'Taiwan'	 Then Data :=  	 SiteCodeType.Taiwan
  Else If Value = 'eBayMotors'	 Then Data :=  	 SiteCodeType.EBayMotors
  Else If Value = 'HongKong'	 Then Data :=  	 SiteCodeType.HongKong
  Else If Value = 'Singapore'	 Then Data :=  	 SiteCodeType.Singapore
  Else If Value = 'India'	 Then Data :=  	 SiteCodeType.India
  Else If Value = 'China'	 Then Data :=  	 SiteCodeType.China
  Else If Value = 'Ireland'	 Then Data :=  	 SiteCodeType.Ireland
  Else If Value = 'Malaysia'	 Then Data :=  	 SiteCodeType.Malaysia
  Else If Value = 'Philippines'	 Then Data :=  	 SiteCodeType.Philippines
  Else If Value = 'Poland'	 Then Data :=  	 SiteCodeType.Poland
  Else If Value = 'Sweden'	 Then Data :=  	 SiteCodeType.Sweden
  Else If Value = 'CustomCode'	 Then Data :=  	 SiteCodeType.CustomCode
  Else If Value = 'CanadaFrench'	 Then Data :=  	 SiteCodeType.CanadaFrench
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : CharacteristicsSearchCodeType);
Begin
       If Value ='Single_'	 Then Data :=  	 CharacteristicsSearchCodeType.Single_
  Else If Value = 'Multi'	 Then Data :=  	 CharacteristicsSearchCodeType.Multi
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : PromotionItemSelectionCodeType);
Begin
       If Value ='Manual'	 Then Data :=  	 PromotionItemSelectionCodeType.Manual
  Else If Value = 'Automatic'	 Then Data :=  	 PromotionItemSelectionCodeType.Automatic
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PromotionItemPriceTypeCodeType);
Begin
       If Value ='AuctionPrice'	 Then Data :=  	 PromotionItemPriceTypeCodeType.AuctionPrice
  Else If Value = 'BuyItNowPrice'	 Then Data :=  	 PromotionItemPriceTypeCodeType.BuyItNowPrice
  Else If Value = 'BestOfferOnlyPrice'	 Then Data :=  	 PromotionItemPriceTypeCodeType.BestOfferOnlyPrice
  Else If Value = 'ClassifiedAdPrice'	 Then Data :=  	 PromotionItemPriceTypeCodeType.ClassifiedAdPrice
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellerLevelCodeType);
Begin
       If Value ='Bronze'	 Then Data :=  	 SellerLevelCodeType.Bronze
  Else If Value = 'Silver'	 Then Data :=  	 SellerLevelCodeType.Silver
  Else If Value = 'Gold'	 Then Data :=  	 SellerLevelCodeType.Gold
  Else If Value = 'Platinum'	 Then Data :=  	 SellerLevelCodeType.Platinum
  Else If Value = 'Titanium'	 Then Data :=  	 SellerLevelCodeType.Titanium
  Else If Value = 'None'	 Then Data :=  	 SellerLevelCodeType.None
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : GalleryStatusCodeType);
Begin
       If Value ='Success'	 Then Data :=  	 GalleryStatusCodeType.Success
  Else If Value = 'Pending'	 Then Data :=  	 GalleryStatusCodeType.Pending
  Else If Value = 'InvalidUrl'	 Then Data :=  	 GalleryStatusCodeType.InvalidUrl
  Else If Value = 'InvalidProtocol'	 Then Data :=  	 GalleryStatusCodeType.InvalidProtocol
  Else If Value = 'InvalidFile'	 Then Data :=  	 GalleryStatusCodeType.InvalidFile
  Else If Value = 'ServerDown'	 Then Data :=  	 GalleryStatusCodeType.ServerDown
  Else If Value = 'ImageNonExistent'	 Then Data :=  	 GalleryStatusCodeType.ImageNonExistent
  Else If Value = 'ImageReadTimeOut'	 Then Data :=  	 GalleryStatusCodeType.ImageReadTimeOut
  Else If Value = 'InvalidFileFormat'	 Then Data :=  	 GalleryStatusCodeType.InvalidFileFormat
  Else If Value = 'ImageProcessingError'	 Then Data :=  	 GalleryStatusCodeType.ImageProcessingError
  Else If Value = 'CustomCode'	 Then Data :=  	 GalleryStatusCodeType.CustomCode
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : PictureManagerSubscriptionLevelCodeType);
Begin
       If Value ='Free'	 Then Data :=  	 PictureManagerSubscriptionLevelCodeType.Free
  Else If Value = 'Level1'	 Then Data :=  	 PictureManagerSubscriptionLevelCodeType.Level1
  Else If Value = 'Level2'	 Then Data :=  	 PictureManagerSubscriptionLevelCodeType.Level2
  Else If Value = 'Level3'	 Then Data :=  	 PictureManagerSubscriptionLevelCodeType.Level3
  Else If Value = 'Level4'	 Then Data :=  	 PictureManagerSubscriptionLevelCodeType.Level4
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : GalleryTypeCodeType);
Begin
       If Value ='None'	 Then Data :=  	 GalleryTypeCodeType.None
  Else If Value = 'Featured'	 Then Data :=  	 GalleryTypeCodeType.Featured
  Else If Value = 'Gallery'	 Then Data :=  	 GalleryTypeCodeType.Gallery
  Else If Value = 'Plus'	 Then Data :=  	 GalleryTypeCodeType.Plus
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PhotoDisplayCodeType);
Begin
       If Value ='None'	 Then Data :=  	 PhotoDisplayCodeType.None
  Else If Value = 'SlideShow'	 Then Data :=  	 PhotoDisplayCodeType.SlideShow
  Else If Value = 'SuperSize'	 Then Data :=  	 PhotoDisplayCodeType.SuperSize
  Else If Value = 'PicturePack'	 Then Data :=  	 PhotoDisplayCodeType.PicturePack
  Else If Value = 'SiteHostedPictureShow'	 Then Data :=  	 PhotoDisplayCodeType.SiteHostedPictureShow
  Else If Value = 'VendorHostedPictureShow'	 Then Data :=  	 PhotoDisplayCodeType.VendorHostedPictureShow
  Else If Value = 'SuperSizePictureShow'	 Then Data :=  	 PhotoDisplayCodeType.SuperSizePictureShow
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PictureSourceCodeType);
Begin
       If Value ='EPS'	 Then Data :=  	 PictureSourceCodeType.EPS
  Else If Value = 'PictureManager'	 Then Data :=  	 PictureSourceCodeType.PictureManager
  Else If Value = 'Vendor'	 Then Data :=  	 PictureSourceCodeType.Vendor
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PolicyComplianceStatusCodeType);
Begin
       If Value ='Good'	 Then Data :=  	 PolicyComplianceStatusCodeType.Good
  Else If Value = 'Fair'	 Then Data :=  	 PolicyComplianceStatusCodeType.Fair
  Else If Value = 'Poor'	 Then Data :=  	 PolicyComplianceStatusCodeType.Poor
  Else If Value = 'Failing'	 Then Data :=  	 PolicyComplianceStatusCodeType.Failing
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : PictureManagerPictureDisplayTypeCodeType);
Begin
       If Value ='Thumbnail'	 Then Data :=  	 PictureManagerPictureDisplayTypeCodeType.Thumbnail
  Else If Value = 'BIBO'	 Then Data :=  	 PictureManagerPictureDisplayTypeCodeType.BIBO
  Else If Value = 'Standard'	 Then Data :=  	 PictureManagerPictureDisplayTypeCodeType.Standard
  Else If Value = 'Large'	 Then Data :=  	 PictureManagerPictureDisplayTypeCodeType.Large
  Else If Value = 'Supersize'	 Then Data :=  	 PictureManagerPictureDisplayTypeCodeType.Supersize
  Else If Value = 'Original'	 Then Data :=  	 PictureManagerPictureDisplayTypeCodeType.Original
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : RefundingSourceTypeCodeType);
Begin
       If Value ='ScheduledPayout'	 Then Data :=  	 RefundingSourceTypeCodeType.ScheduledPayout
  Else If Value = 'Paypal'	 Then Data :=  	 RefundingSourceTypeCodeType.Paypal
  Else If Value = 'BankAccount'	 Then Data :=  	 RefundingSourceTypeCodeType.BankAccount
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : RefundFailureCodeType);
Begin
       If Value ='PaypalBillingAgreementCanceled'	 Then Data :=  	 RefundFailureCodeType.PaypalBillingAgreementCanceled
  Else If Value = 'PaypalRiskDeclinesTransaction'	 Then Data :=  	 RefundFailureCodeType.PaypalRiskDeclinesTransaction
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : RefundStatusCodeType);
Begin
       If Value ='Successful'	 Then Data :=  	 RefundStatusCodeType.Successful
  Else If Value = 'Pending'	 Then Data :=  	 RefundStatusCodeType.Pending
  Else If Value = 'Failed'	 Then Data :=  	 RefundStatusCodeType.Failed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 StatusCodeType.Active
  Else If Value = 'Inactive'	 Then Data :=  	 StatusCodeType.Inactive
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : RefundLineTypeCodeType);
Begin
       If Value ='PurchasePrice'	 Then Data :=  	 RefundLineTypeCodeType.PurchasePrice
  Else If Value = 'ShippingPrice'	 Then Data :=  	 RefundLineTypeCodeType.ShippingPrice
  Else If Value = 'Additional'	 Then Data :=  	 RefundLineTypeCodeType.Additional
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ValueTypeCodeType);
Begin
       If Value ='Decimal'	 Then Data :=  	 ValueTypeCodeType.Decimal
  Else If Value = 'Text'	 Then Data :=  	 ValueTypeCodeType.Text
  Else If Value = 'ISBN'	 Then Data :=  	 ValueTypeCodeType.ISBN
  Else If Value = 'UPC'	 Then Data :=  	 ValueTypeCodeType.UPC
  Else If Value = 'EAN'	 Then Data :=  	 ValueTypeCodeType.EAN
  Else If Value = 'Date'	 Then Data :=  	 ValueTypeCodeType.Date
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DiscountCodeType);
Begin
       If Value ='Percentage'	 Then Data :=  	 DiscountCodeType.Percentage
  Else If Value = 'Price'	 Then Data :=  	 DiscountCodeType.Price
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PromotionalSaleTypeCodeType);
Begin
       If Value ='PriceDiscountOnly'	 Then Data :=  	 PromotionalSaleTypeCodeType.PriceDiscountOnly
  Else If Value = 'FreeShippingOnly'	 Then Data :=  	 PromotionalSaleTypeCodeType.FreeShippingOnly
  Else If Value = 'PriceDiscountAndFreeShipping'	 Then Data :=  	 PromotionalSaleTypeCodeType.PriceDiscountAndFreeShipping
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ValueFormatCodeType);
Begin
       If Value ='FullDate'	 Then Data :=  	 ValueFormatCodeType.FullDate
  Else If Value = 'PartialDate'	 Then Data :=  	 ValueFormatCodeType.PartialDate
  Else If Value = 'Year'	 Then Data :=  	 ValueFormatCodeType.Year
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SelectionModeCodeType);
Begin
       If Value ='Automatic'	 Then Data :=  	 SelectionModeCodeType.Automatic
  Else If Value = 'Manual'	 Then Data :=  	 SelectionModeCodeType.Manual
  Else If Value = 'Prefilled'	 Then Data :=  	 SelectionModeCodeType.Prefilled
  Else If Value = 'SelectionOnly'	 Then Data :=  	 SelectionModeCodeType.SelectionOnly
  Else If Value = 'FreeText'	 Then Data :=  	 SelectionModeCodeType.FreeText
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : VariationPictureRuleCodeType);
Begin
       If Value ='Required'	 Then Data :=  	 VariationPictureRuleCodeType.Required
  Else If Value = 'Enabled'	 Then Data :=  	 VariationPictureRuleCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 VariationPictureRuleCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : VariationSpecificsRuleCodeType);
Begin
       If Value ='Enabled'	 Then Data :=  	 VariationSpecificsRuleCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 VariationSpecificsRuleCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PaymentMethodSearchCodeType);
Begin
       If Value ='PayPal'	 Then Data :=  	 PaymentMethodSearchCodeType.PayPal
  Else If Value = 'PaisaPay'	 Then Data :=  	 PaymentMethodSearchCodeType.PaisaPay
  Else If Value = 'PayPalOrPaisaPay'	 Then Data :=  	 PaymentMethodSearchCodeType.PayPalOrPaisaPay
  Else If Value = 'CustomCode'	 Then Data :=  	 PaymentMethodSearchCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PreferredLocationCodeType);
Begin
       If Value ='ListedInCurrencyImplied'	 Then Data :=  	 PreferredLocationCodeType.ListedInCurrencyImplied
  Else If Value = 'LocatedInCountryImplied'	 Then Data :=  	 PreferredLocationCodeType.LocatedInCountryImplied
  Else If Value = 'AvailableInCountryImplied'	 Then Data :=  	 PreferredLocationCodeType.AvailableInCountryImplied
  Else If Value = 'SiteImplied'	 Then Data :=  	 PreferredLocationCodeType.SiteImplied
  Else If Value = 'BelgiumListing'	 Then Data :=  	 PreferredLocationCodeType.BelgiumListing
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemConditionCodeType);
Begin
       If Value ='New'	 Then Data :=  	 ItemConditionCodeType.New
  Else If Value = 'Used'	 Then Data :=  	 ItemConditionCodeType.Used
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SimpleItemSortCodeType);
Begin
       If Value ='BestMatch'	 Then Data :=  	 SimpleItemSortCodeType.BestMatch
  Else If Value = 'CustomCode'	 Then Data :=  	 SimpleItemSortCodeType.CustomCode
  Else If Value = 'EndTime'	 Then Data :=  	 SimpleItemSortCodeType.EndTime
  Else If Value = 'BidCount'	 Then Data :=  	 SimpleItemSortCodeType.BidCount
  Else If Value = 'Country'	 Then Data :=  	 SimpleItemSortCodeType.Country
  Else If Value = 'CurrentBid'	 Then Data :=  	 SimpleItemSortCodeType.CurrentBid
  Else If Value = 'Distance'	 Then Data :=  	 SimpleItemSortCodeType.Distance
  Else If Value = 'StartDate'	 Then Data :=  	 SimpleItemSortCodeType.StartDate
  Else If Value = 'BestMatchCategoryGroup'	 Then Data :=  	 SimpleItemSortCodeType.BestMatchCategoryGroup
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemTypeCodeType);
Begin
       If Value ='AuctionItemsOnly'	 Then Data :=  	 ItemTypeCodeType.AuctionItemsOnly
  Else If Value = 'FixedPricedItem'	 Then Data :=  	 ItemTypeCodeType.FixedPricedItem
  Else If Value = 'AllItems'	 Then Data :=  	 ItemTypeCodeType.AllItems
  Else If Value = 'StoreInventoryOnly'	 Then Data :=  	 ItemTypeCodeType.StoreInventoryOnly
  Else If Value = 'FixedPriceExcludeStoreInventory'	 Then Data :=  	 ItemTypeCodeType.FixedPriceExcludeStoreInventory
  Else If Value = 'ExcludeStoreInventory'	 Then Data :=  	 ItemTypeCodeType.ExcludeStoreInventory
  Else If Value = 'AllItemTypes'	 Then Data :=  	 ItemTypeCodeType.AllItemTypes
  Else If Value = 'AllFixedPriceItemTypes'	 Then Data :=  	 ItemTypeCodeType.AllFixedPriceItemTypes
  Else If Value = 'CustomCode'	 Then Data :=  	 ItemTypeCodeType.CustomCode
  Else If Value = 'ClassifiedItemsOnly'	 Then Data :=  	 ItemTypeCodeType.ClassifiedItemsOnly
  Else If Value = 'AdFormat'	 Then Data :=  	 ItemTypeCodeType.AdFormat
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SearchFlagCodeType);
Begin
       If Value ='Charity'	 Then Data :=  	 SearchFlagCodeType.Charity
  Else If Value = 'Gift'	 Then Data :=  	 SearchFlagCodeType.Gift
  Else If Value = 'NowAndNew'	 Then Data :=  	 SearchFlagCodeType.NowAndNew
  Else If Value = 'LocalSearch'	 Then Data :=  	 SearchFlagCodeType.LocalSearch
  Else If Value = 'FreeShipping'	 Then Data :=  	 SearchFlagCodeType.FreeShipping
  Else If Value = 'Gallery'	 Then Data :=  	 SearchFlagCodeType.Gallery
  Else If Value = 'Picture'	 Then Data :=  	 SearchFlagCodeType.Picture
  Else If Value = 'GetItFast'	 Then Data :=  	 SearchFlagCodeType.GetItFast
  Else If Value = 'Lot'	 Then Data :=  	 SearchFlagCodeType.Lot
  Else If Value = 'GermanMotorsSearchable'	 Then Data :=  	 SearchFlagCodeType.GermanMotorsSearchable
  Else If Value = 'WorldOfGood'	 Then Data :=  	 SearchFlagCodeType.WorldOfGood
  Else If Value = 'DigitalDelivery'	 Then Data :=  	 SearchFlagCodeType.DigitalDelivery
  Else If Value = 'CustomCode'	 Then Data :=  	 SearchFlagCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemSpecificSourceCodeType);
Begin
       If Value ='ItemSpecific'	 Then Data :=  	 ItemSpecificSourceCodeType.ItemSpecific
  Else If Value = 'Attribute'	 Then Data :=  	 ItemSpecificSourceCodeType.Attribute
  Else If Value = 'Product'	 Then Data :=  	 ItemSpecificSourceCodeType.Product
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : QuantityOperatorCodeType);
Begin
       If Value ='LessThan'	 Then Data :=  	 QuantityOperatorCodeType.LessThan
  Else If Value = 'LessThanOrEqual'	 Then Data :=  	 QuantityOperatorCodeType.LessThanOrEqual
  Else If Value = 'Equal'	 Then Data :=  	 QuantityOperatorCodeType.Equal
  Else If Value = 'GreaterThan'	 Then Data :=  	 QuantityOperatorCodeType.GreaterThan
  Else If Value = 'GreaterThanOrEqual'	 Then Data :=  	 QuantityOperatorCodeType.GreaterThanOrEqual
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MyMessagesAlertResolutionStatusCode);
Begin
       If Value ='Unresolved'	 Then Data :=  	 MyMessagesAlertResolutionStatusCode.Unresolved
  Else If Value = 'ResolvedByAutoResolution'	 Then Data :=  	 MyMessagesAlertResolutionStatusCode.ResolvedByAutoResolution
  Else If Value = 'ResolvedByUser'	 Then Data :=  	 MyMessagesAlertResolutionStatusCode.ResolvedByUser
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DepositTypeCodeType);
Begin
       If Value ='None'	 Then Data :=  	 DepositTypeCodeType.None
  Else If Value = 'OtherMethod'	 Then Data :=  	 DepositTypeCodeType.OtherMethod
  Else If Value = 'FastDeposit'	 Then Data :=  	 DepositTypeCodeType.FastDeposit
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PaymentHoldStatusCodeType);
Begin
       If Value ='PaymentReview'	 Then Data :=  	 PaymentHoldStatusCodeType.PaymentReview
  Else If Value = 'MerchantHold'	 Then Data :=  	 PaymentHoldStatusCodeType.MerchantHold
  Else If Value = 'Released'	 Then Data :=  	 PaymentHoldStatusCodeType.Released
  Else If Value = 'None'	 Then Data :=  	 PaymentHoldStatusCodeType.None
  Else If Value = 'NewSellerHold'	 Then Data :=  	 PaymentHoldStatusCodeType.NewSellerHold
  Else If Value = 'PaymentHold'	 Then Data :=  	 PaymentHoldStatusCodeType.PaymentHold
  Else If Value = 'ReleasePending'	 Then Data :=  	 PaymentHoldStatusCodeType.ReleasePending
  Else If Value = 'ReleaseConfirmed'	 Then Data :=  	 PaymentHoldStatusCodeType.ReleaseConfirmed
  Else If Value = 'ReleaseFailed'	 Then Data :=  	 PaymentHoldStatusCodeType.ReleaseFailed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PerformanceStatusCodeType);
Begin
       If Value ='TopRated'	 Then Data :=  	 PerformanceStatusCodeType.TopRated
  Else If Value = 'AboveStandard'	 Then Data :=  	 PerformanceStatusCodeType.AboveStandard
  Else If Value = 'Standard'	 Then Data :=  	 PerformanceStatusCodeType.Standard
  Else If Value = 'BelowStandard'	 Then Data :=  	 PerformanceStatusCodeType.BelowStandard
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PaymentHoldReasonCodeType);
Begin
       If Value ='NewSeller'	 Then Data :=  	 PaymentHoldReasonCodeType.NewSeller
  Else If Value = 'BelowStandardSeller'	 Then Data :=  	 PaymentHoldReasonCodeType.BelowStandardSeller
  Else If Value = 'EbpCaseOpen'	 Then Data :=  	 PaymentHoldReasonCodeType.EbpCaseOpen
  Else If Value = 'ReinstatementAfterSuspension'	 Then Data :=  	 PaymentHoldReasonCodeType.ReinstatementAfterSuspension
  Else If Value = 'CasualSeller'	 Then Data :=  	 PaymentHoldReasonCodeType.CasualSeller
  Else If Value = 'NewPaypalAccountAdded'	 Then Data :=  	 PaymentHoldReasonCodeType.NewPaypalAccountAdded
  Else If Value = 'NotAvailable'	 Then Data :=  	 PaymentHoldReasonCodeType.NotAvailable
  Else If Value = 'SellerIsOnBlackList'	 Then Data :=  	 PaymentHoldReasonCodeType.SellerIsOnBlackList
  Else If Value = 'Other'	 Then Data :=  	 PaymentHoldReasonCodeType.Other
  Else If Value = 'None'	 Then Data :=  	 PaymentHoldReasonCodeType.None
  Else If Value = 'CustomCode'	 Then Data :=  	 PaymentHoldReasonCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : NotificationEventStateCodeType);
Begin
       If Value ='New'	 Then Data :=  	 NotificationEventStateCodeType.New
  Else If Value = 'Failed'	 Then Data :=  	 NotificationEventStateCodeType.Failed
  Else If Value = 'MarkedDown'	 Then Data :=  	 NotificationEventStateCodeType.MarkedDown
  Else If Value = 'Pending'	 Then Data :=  	 NotificationEventStateCodeType.Pending
  Else If Value = 'FailedPending'	 Then Data :=  	 NotificationEventStateCodeType.FailedPending
  Else If Value = 'MarkedDownPending'	 Then Data :=  	 NotificationEventStateCodeType.MarkedDownPending
  Else If Value = 'Delivered'	 Then Data :=  	 NotificationEventStateCodeType.Delivered
  Else If Value = 'Undeliverable'	 Then Data :=  	 NotificationEventStateCodeType.Undeliverable
  Else If Value = 'Rejected'	 Then Data :=  	 NotificationEventStateCodeType.Rejected
  Else If Value = 'Canceled'	 Then Data :=  	 NotificationEventStateCodeType.Canceled
  Else If Value = 'CustomCode'	 Then Data :=  	 NotificationEventStateCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : NotificationEventPropertyNameCodeType);
Begin
       If Value ='TimeLeft'	 Then Data :=  	 NotificationEventPropertyNameCodeType.TimeLeft
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AddressTypeCodeType);
Begin
       If Value ='Contact'	 Then Data :=  	 AddressTypeCodeType.Contact
  Else If Value = 'Registered'	 Then Data :=  	 AddressTypeCodeType.Registered
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : NotificationEventTypeCodeType);
Begin
       If Value ='None'	 Then Data :=  	 NotificationEventTypeCodeType.None
  Else If Value = 'OutBid'	 Then Data :=  	 NotificationEventTypeCodeType.OutBid
  Else If Value = 'EndOfAuction'	 Then Data :=  	 NotificationEventTypeCodeType.EndOfAuction
  Else If Value = 'AuctionCheckoutComplete'	 Then Data :=  	 NotificationEventTypeCodeType.AuctionCheckoutComplete
  Else If Value = 'CheckoutBuyerRequestsTotal'	 Then Data :=  	 NotificationEventTypeCodeType.CheckoutBuyerRequestsTotal
  Else If Value = 'Feedback'	 Then Data :=  	 NotificationEventTypeCodeType.Feedback
  Else If Value = 'FeedbackForSeller'	 Then Data :=  	 NotificationEventTypeCodeType.FeedbackForSeller
  Else If Value = 'FixedPriceTransaction'	 Then Data :=  	 NotificationEventTypeCodeType.FixedPriceTransaction
  Else If Value = 'SecondChanceOffer'	 Then Data :=  	 NotificationEventTypeCodeType.SecondChanceOffer
  Else If Value = 'AskSellerQuestion'	 Then Data :=  	 NotificationEventTypeCodeType.AskSellerQuestion
  Else If Value = 'ItemListed'	 Then Data :=  	 NotificationEventTypeCodeType.ItemListed
  Else If Value = 'ItemRevised'	 Then Data :=  	 NotificationEventTypeCodeType.ItemRevised
  Else If Value = 'BuyerResponseDispute'	 Then Data :=  	 NotificationEventTypeCodeType.BuyerResponseDispute
  Else If Value = 'SellerOpenedDispute'	 Then Data :=  	 NotificationEventTypeCodeType.SellerOpenedDispute
  Else If Value = 'SellerRespondedToDispute'	 Then Data :=  	 NotificationEventTypeCodeType.SellerRespondedToDispute
  Else If Value = 'SellerClosedDispute'	 Then Data :=  	 NotificationEventTypeCodeType.SellerClosedDispute
  Else If Value = 'BestOffer'	 Then Data :=  	 NotificationEventTypeCodeType.BestOffer
  Else If Value = 'MyMessagesAlertHeader'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessagesAlertHeader
  Else If Value = 'MyMessagesAlert'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessagesAlert
  Else If Value = 'MyMessageseBayMessageHeader'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessageseBayMessageHeader
  Else If Value = 'MyMessageseBayMessage'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessageseBayMessage
  Else If Value = 'MyMessagesM2MMessageHeader'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessagesM2MMessageHeader
  Else If Value = 'MyMessagesM2MMessage'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessagesM2MMessage
  Else If Value = 'INRBuyerOpenedDispute'	 Then Data :=  	 NotificationEventTypeCodeType.INRBuyerOpenedDispute
  Else If Value = 'INRBuyerRespondedToDispute'	 Then Data :=  	 NotificationEventTypeCodeType.INRBuyerRespondedToDispute
  Else If Value = 'INRBuyerClosedDispute'	 Then Data :=  	 NotificationEventTypeCodeType.INRBuyerClosedDispute
  Else If Value = 'INRSellerRespondedToDispute'	 Then Data :=  	 NotificationEventTypeCodeType.INRSellerRespondedToDispute
  Else If Value = 'Checkout'	 Then Data :=  	 NotificationEventTypeCodeType.Checkout
  Else If Value = 'WatchedItemEndingSoon'	 Then Data :=  	 NotificationEventTypeCodeType.WatchedItemEndingSoon
  Else If Value = 'ItemClosed'	 Then Data :=  	 NotificationEventTypeCodeType.ItemClosed
  Else If Value = 'ItemSuspended'	 Then Data :=  	 NotificationEventTypeCodeType.ItemSuspended
  Else If Value = 'ItemSold'	 Then Data :=  	 NotificationEventTypeCodeType.ItemSold
  Else If Value = 'ItemExtended'	 Then Data :=  	 NotificationEventTypeCodeType.ItemExtended
  Else If Value = 'UserIDChanged'	 Then Data :=  	 NotificationEventTypeCodeType.UserIDChanged
  Else If Value = 'EmailAddressChanged'	 Then Data :=  	 NotificationEventTypeCodeType.EmailAddressChanged
  Else If Value = 'PasswordChanged'	 Then Data :=  	 NotificationEventTypeCodeType.PasswordChanged
  Else If Value = 'PasswordHintChanged'	 Then Data :=  	 NotificationEventTypeCodeType.PasswordHintChanged
  Else If Value = 'PaymentDetailChanged'	 Then Data :=  	 NotificationEventTypeCodeType.PaymentDetailChanged
  Else If Value = 'AccountSuspended'	 Then Data :=  	 NotificationEventTypeCodeType.AccountSuspended
  Else If Value = 'AccountSummary'	 Then Data :=  	 NotificationEventTypeCodeType.AccountSummary
  Else If Value = 'ThirdPartyCartCheckout'	 Then Data :=  	 NotificationEventTypeCodeType.ThirdPartyCartCheckout
  Else If Value = 'ItemRevisedAddCharity'	 Then Data :=  	 NotificationEventTypeCodeType.ItemRevisedAddCharity
  Else If Value = 'ItemAddedToWatchList'	 Then Data :=  	 NotificationEventTypeCodeType.ItemAddedToWatchList
  Else If Value = 'ItemRemovedFromWatchList'	 Then Data :=  	 NotificationEventTypeCodeType.ItemRemovedFromWatchList
  Else If Value = 'ItemAddedToBidGroup'	 Then Data :=  	 NotificationEventTypeCodeType.ItemAddedToBidGroup
  Else If Value = 'ItemRemovedFromBidGroup'	 Then Data :=  	 NotificationEventTypeCodeType.ItemRemovedFromBidGroup
  Else If Value = 'FeedbackLeft'	 Then Data :=  	 NotificationEventTypeCodeType.FeedbackLeft
  Else If Value = 'FeedbackReceived'	 Then Data :=  	 NotificationEventTypeCodeType.FeedbackReceived
  Else If Value = 'FeedbackStarChanged'	 Then Data :=  	 NotificationEventTypeCodeType.FeedbackStarChanged
  Else If Value = 'BidPlaced'	 Then Data :=  	 NotificationEventTypeCodeType.BidPlaced
  Else If Value = 'BidReceived'	 Then Data :=  	 NotificationEventTypeCodeType.BidReceived
  Else If Value = 'ItemWon'	 Then Data :=  	 NotificationEventTypeCodeType.ItemWon
  Else If Value = 'ItemLost'	 Then Data :=  	 NotificationEventTypeCodeType.ItemLost
  Else If Value = 'ItemUnsold'	 Then Data :=  	 NotificationEventTypeCodeType.ItemUnsold
  Else If Value = 'CounterOfferReceived'	 Then Data :=  	 NotificationEventTypeCodeType.CounterOfferReceived
  Else If Value = 'BestOfferDeclined'	 Then Data :=  	 NotificationEventTypeCodeType.BestOfferDeclined
  Else If Value = 'BestOfferPlaced'	 Then Data :=  	 NotificationEventTypeCodeType.BestOfferPlaced
  Else If Value = 'AddToWatchList'	 Then Data :=  	 NotificationEventTypeCodeType.AddToWatchList
  Else If Value = 'PlaceOffer'	 Then Data :=  	 NotificationEventTypeCodeType.PlaceOffer
  Else If Value = 'RemoveFromWatchList'	 Then Data :=  	 NotificationEventTypeCodeType.RemoveFromWatchList
  Else If Value = 'AddToBidGroup'	 Then Data :=  	 NotificationEventTypeCodeType.AddToBidGroup
  Else If Value = 'RemoveFromBidGroup'	 Then Data :=  	 NotificationEventTypeCodeType.RemoveFromBidGroup
  Else If Value = 'ItemsCanceled'	 Then Data :=  	 NotificationEventTypeCodeType.ItemsCanceled
  Else If Value = 'TokenRevocation'	 Then Data :=  	 NotificationEventTypeCodeType.TokenRevocation
  Else If Value = 'BulkDataExchangeJobCompleted'	 Then Data :=  	 NotificationEventTypeCodeType.BulkDataExchangeJobCompleted
  Else If Value = 'CustomCode'	 Then Data :=  	 NotificationEventTypeCodeType.CustomCode
  Else If Value = 'ItemMarkedShipped'	 Then Data :=  	 NotificationEventTypeCodeType.ItemMarkedShipped
  Else If Value = 'ItemMarkedPaid'	 Then Data :=  	 NotificationEventTypeCodeType.ItemMarkedPaid
  Else If Value = 'EBPMyResponseDue'	 Then Data :=  	 NotificationEventTypeCodeType.EBPMyResponseDue
  Else If Value = 'EBPOtherPartyResponseDue'	 Then Data :=  	 NotificationEventTypeCodeType.EBPOtherPartyResponseDue
  Else If Value = 'EBPEscalatedCase'	 Then Data :=  	 NotificationEventTypeCodeType.EBPEscalatedCase
  Else If Value = 'EBPAppealedCase'	 Then Data :=  	 NotificationEventTypeCodeType.EBPAppealedCase
  Else If Value = 'EBPMyPaymentDue'	 Then Data :=  	 NotificationEventTypeCodeType.EBPMyPaymentDue
  Else If Value = 'EBPPaymentDone'	 Then Data :=  	 NotificationEventTypeCodeType.EBPPaymentDone
  Else If Value = 'EBPClosedAppeal'	 Then Data :=  	 NotificationEventTypeCodeType.EBPClosedAppeal
  Else If Value = 'EBPClosedCase'	 Then Data :=  	 NotificationEventTypeCodeType.EBPClosedCase
  Else If Value = 'MyMessagesHighPriorityMessage'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessagesHighPriorityMessage
  Else If Value = 'MyMessagesHighPriorityMessageHeader'	 Then Data :=  	 NotificationEventTypeCodeType.MyMessagesHighPriorityMessageHeader
  Else If Value = 'EBPOnHoldCase'	 Then Data :=  	 NotificationEventTypeCodeType.EBPOnHoldCase
  Else If Value = 'ReadyToShip'	 Then Data :=  	 NotificationEventTypeCodeType.ReadyToShip
  Else If Value = 'ReadyForPayout'	 Then Data :=  	 NotificationEventTypeCodeType.ReadyForPayout
  Else If Value = 'BidItemEndingSoon'	 Then Data :=  	 NotificationEventTypeCodeType.BidItemEndingSoon
  Else If Value = 'ShoppingCartItemEndingSoon'	 Then Data :=  	 NotificationEventTypeCodeType.ShoppingCartItemEndingSoon
  Else If Value = 'ReturnCreated'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnCreated
  Else If Value = 'ReturnWaitingForSellerInfo'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnWaitingForSellerInfo
  Else If Value = 'ReturnSellerInfoOverdue'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnSellerInfoOverdue
  Else If Value = 'ReturnShipped'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnShipped
  Else If Value = 'ReturnDelivered'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnDelivered
  Else If Value = 'ReturnRefundOverdue'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnRefundOverdue
  Else If Value = 'ReturnClosed'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnClosed
  Else If Value = 'ReturnEscalated'	 Then Data :=  	 NotificationEventTypeCodeType.ReturnEscalated
  Else If Value = 'UnmatchedPaymentReceived'	 Then Data :=  	 NotificationEventTypeCodeType.UnmatchedPaymentReceived
  Else If Value = 'RefundSuccess'	 Then Data :=  	 NotificationEventTypeCodeType.RefundSuccess
  Else If Value = 'RefundFailure'	 Then Data :=  	 NotificationEventTypeCodeType.RefundFailure
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BidActionCodeType);
Begin
       If Value ='Unknown'	 Then Data :=  	 BidActionCodeType.Unknown
  Else If Value = 'Bid'	 Then Data :=  	 BidActionCodeType.Bid
  Else If Value = 'NotUsed'	 Then Data :=  	 BidActionCodeType.NotUsed
  Else If Value = 'Retraction'	 Then Data :=  	 BidActionCodeType.Retraction
  Else If Value = 'AutoRetraction'	 Then Data :=  	 BidActionCodeType.AutoRetraction
  Else If Value = 'Cancelled'	 Then Data :=  	 BidActionCodeType.Cancelled
  Else If Value = 'AutoCancel'	 Then Data :=  	 BidActionCodeType.AutoCancel
  Else If Value = 'Absentee'	 Then Data :=  	 BidActionCodeType.Absentee
  Else If Value = 'BuyItNow'	 Then Data :=  	 BidActionCodeType.BuyItNow
  Else If Value = 'Purchase'	 Then Data :=  	 BidActionCodeType.Purchase
  Else If Value = 'CustomCode'	 Then Data :=  	 BidActionCodeType.CustomCode
  Else If Value = 'Offer'	 Then Data :=  	 BidActionCodeType.Offer
  Else If Value = 'Counter'	 Then Data :=  	 BidActionCodeType.Counter
  Else If Value = 'Accept'	 Then Data :=  	 BidActionCodeType.Accept
  Else If Value = 'Decline'	 Then Data :=  	 BidActionCodeType.Decline
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : ProductUseCaseCodeType);
Begin
       If Value ='AddItem'	 Then Data :=  	 ProductUseCaseCodeType.AddItem
  Else If Value = 'ReviseItem'	 Then Data :=  	 ProductUseCaseCodeType.ReviseItem
  Else If Value = 'RelistItem'	 Then Data :=  	 ProductUseCaseCodeType.RelistItem
  {Else Result  := 	 ''};
End;*)

(*Procedure StrToEnum(Const Value: String ; Var Data : PictureManagerDetailLevelCodeType);
Begin
       If Value ='ReturnAll'	 Then Data :=  	 PictureManagerDetailLevelCodeType.ReturnAll
  Else If Value = 'ReturnSubscription'	 Then Data :=  	 PictureManagerDetailLevelCodeType.ReturnSubscription
  Else If Value = 'ReturnPicture'	 Then Data :=  	 PictureManagerDetailLevelCodeType.ReturnPicture
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : RCSPaymentStatusCodeType);
Begin
       If Value ='Canceled'	 Then Data :=  	 RCSPaymentStatusCodeType.Canceled
  Else If Value = 'Paid'	 Then Data :=  	 RCSPaymentStatusCodeType.Paid
  Else If Value = 'Pending'	 Then Data :=  	 RCSPaymentStatusCodeType.Pending
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PromotionalSaleStatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 PromotionalSaleStatusCodeType.Active
  Else If Value = 'Scheduled'	 Then Data :=  	 PromotionalSaleStatusCodeType.Scheduled
  Else If Value = 'Processing'	 Then Data :=  	 PromotionalSaleStatusCodeType.Processing
  Else If Value = 'Inactive'	 Then Data :=  	 PromotionalSaleStatusCodeType.Inactive
  Else If Value = 'Deleted'	 Then Data :=  	 PromotionalSaleStatusCodeType.Deleted
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MessageTypeCodeType);
Begin
       If Value ='AskSellerQuestion'	 Then Data :=  	 MessageTypeCodeType.AskSellerQuestion
  Else If Value = 'ResponseToASQQuestion'	 Then Data :=  	 MessageTypeCodeType.ResponseToASQQuestion
  Else If Value = 'ContactEbayMember'	 Then Data :=  	 MessageTypeCodeType.ContactEbayMember
  Else If Value = 'ContactTransactionPartner'	 Then Data :=  	 MessageTypeCodeType.ContactTransactionPartner
  Else If Value = 'ResponseToContacteBayMember'	 Then Data :=  	 MessageTypeCodeType.ResponseToContacteBayMember
  Else If Value = 'ContacteBayMemberViaCommunityLink'	 Then Data :=  	 MessageTypeCodeType.ContacteBayMemberViaCommunityLink
  Else If Value = 'CustomCode'	 Then Data :=  	 MessageTypeCodeType.CustomCode
  Else If Value = 'All'	 Then Data :=  	 MessageTypeCodeType.All
  Else If Value = 'ContactMyBidder'	 Then Data :=  	 MessageTypeCodeType.ContactMyBidder
  Else If Value = 'ContacteBayMemberViaAnonymousEmail'	 Then Data :=  	 MessageTypeCodeType.ContacteBayMemberViaAnonymousEmail
  Else If Value = 'ClassifiedsContactSeller'	 Then Data :=  	 MessageTypeCodeType.ClassifiedsContactSeller
  Else If Value = 'ClassifiedsBestOffer'	 Then Data :=  	 MessageTypeCodeType.ClassifiedsBestOffer
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : OrderStatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 OrderStatusCodeType.Active
  Else If Value = 'Inactive'	 Then Data :=  	 OrderStatusCodeType.Inactive
  Else If Value = 'Completed'	 Then Data :=  	 OrderStatusCodeType.Completed
  Else If Value = 'Cancelled'	 Then Data :=  	 OrderStatusCodeType.Cancelled
  Else If Value = 'Shipped'	 Then Data :=  	 OrderStatusCodeType.Shipped
  Else If Value = 'Default_'	 Then Data :=  	 OrderStatusCodeType.Default_
  Else If Value = 'Authenticated'	 Then Data :=  	 OrderStatusCodeType.Authenticated
  Else If Value = 'InProcess'	 Then Data :=  	 OrderStatusCodeType.InProcess
  Else If Value = 'Invalid'	 Then Data :=  	 OrderStatusCodeType.Invalid
  Else If Value = 'CustomCode'	 Then Data :=  	 OrderStatusCodeType.CustomCode
  Else If Value = 'All'	 Then Data :=  	 OrderStatusCodeType.All
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SortOrderCodeType);
Begin
       If Value ='Ascending'	 Then Data :=  	 SortOrderCodeType.Ascending
  Else If Value = 'Descending'	 Then Data :=  	 SortOrderCodeType.Descending
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : NotificationRoleCodeType);
Begin
       If Value ='Application_'	 Then Data :=  	 NotificationRoleCodeType.Application_
  Else If Value = 'User'	 Then Data :=  	 NotificationRoleCodeType.User
  Else If Value = 'UserData'	 Then Data :=  	 NotificationRoleCodeType.UserData
  Else If Value = 'Event'	 Then Data :=  	 NotificationRoleCodeType.Event
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeFilterTypeCodeType);
Begin
       If Value ='AllInvolvedDisputes'	 Then Data :=  	 DisputeFilterTypeCodeType.AllInvolvedDisputes
  Else If Value = 'DisputesAwaitingMyResponse'	 Then Data :=  	 DisputeFilterTypeCodeType.DisputesAwaitingMyResponse
  Else If Value = 'DisputesAwaitingOtherPartyResponse'	 Then Data :=  	 DisputeFilterTypeCodeType.DisputesAwaitingOtherPartyResponse
  Else If Value = 'AllInvolvedClosedDisputes'	 Then Data :=  	 DisputeFilterTypeCodeType.AllInvolvedClosedDisputes
  Else If Value = 'EligibleForCredit'	 Then Data :=  	 DisputeFilterTypeCodeType.EligibleForCredit
  Else If Value = 'UnpaidItemDisputes'	 Then Data :=  	 DisputeFilterTypeCodeType.UnpaidItemDisputes
  Else If Value = 'ItemNotReceivedDisputes'	 Then Data :=  	 DisputeFilterTypeCodeType.ItemNotReceivedDisputes
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeSortTypeCodeType);
Begin
       If Value ='None'	 Then Data :=  	 DisputeSortTypeCodeType.None
  Else If Value = 'DisputeCreatedTimeAscending'	 Then Data :=  	 DisputeSortTypeCodeType.DisputeCreatedTimeAscending
  Else If Value = 'DisputeCreatedTimeDescending'	 Then Data :=  	 DisputeSortTypeCodeType.DisputeCreatedTimeDescending
  Else If Value = 'DisputeStatusAscending'	 Then Data :=  	 DisputeSortTypeCodeType.DisputeStatusAscending
  Else If Value = 'DisputeStatusDescending'	 Then Data :=  	 DisputeSortTypeCodeType.DisputeStatusDescending
  Else If Value = 'DisputeCreditEligibilityAscending'	 Then Data :=  	 DisputeSortTypeCodeType.DisputeCreditEligibilityAscending
  Else If Value = 'DisputeCreditEligibilityDescending'	 Then Data :=  	 DisputeSortTypeCodeType.DisputeCreditEligibilityDescending
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : VeROReportPacketStatusCodeType);
Begin
       If Value ='Received'	 Then Data :=  	 VeROReportPacketStatusCodeType.Received
  Else If Value = 'InProcess'	 Then Data :=  	 VeROReportPacketStatusCodeType.InProcess
  Else If Value = 'Processed'	 Then Data :=  	 VeROReportPacketStatusCodeType.Processed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerSoldListingsPropertyTypeCodeType);
Begin
       If Value ='NotPaidNotShipped'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.NotPaidNotShipped
  Else If Value = 'PaidNotShipped'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PaidNotShipped
  Else If Value = 'PrintShippingLabel'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PrintShippingLabel
  Else If Value = 'PaidShipped'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PaidShipped
  Else If Value = 'PaidNoFeedback'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PaidNoFeedback
  Else If Value = 'PaymentReminderSendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PaymentReminderSendError
  Else If Value = 'PaymentReceivedNotificationSendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PaymentReceivedNotificationSendError
  Else If Value = 'RequestForShippingAddressSendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.RequestForShippingAddressSendError
  Else If Value = 'ShippingNotificationSendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.ShippingNotificationSendError
  Else If Value = 'PersonalizedEmailsSendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PersonalizedEmailsSendError
  Else If Value = 'WinningBuyerNotificationSendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.WinningBuyerNotificationSendError
  Else If Value = 'FeeCreditRequest'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.FeeCreditRequest
  Else If Value = 'PayPalPayment'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PayPalPayment
  Else If Value = 'FeedbackMessageNotSent'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.FeedbackMessageNotSent
  Else If Value = 'FeedbackReminderSendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.FeedbackReminderSendError
  Else If Value = 'NotShipped'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.NotShipped
  Else If Value = 'UnpaidItemReminder'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.UnpaidItemReminder
  Else If Value = 'EscrowCancelled'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EscrowCancelled
  Else If Value = 'EscrowCompleted'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EscrowCompleted
  Else If Value = 'EscrowInitiated'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EscrowInitiated
  Else If Value = 'EscrowManageRefund'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EscrowManageRefund
  Else If Value = 'EscrowReleasePayment'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EscrowReleasePayment
  Else If Value = 'EscrowShipToBuyer'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EscrowShipToBuyer
  Else If Value = 'EscrowSoldAll'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EscrowSoldAll
  Else If Value = 'ShippedAndAwaitingFeedback'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.ShippedAndAwaitingFeedback
  Else If Value = 'InternationalSale'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.InternationalSale
  Else If Value = 'eBayGivingWorksDonationOwed'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.EBayGivingWorksDonationOwed
  Else If Value = 'PaymentOverDue'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PaymentOverDue
  Else If Value = 'PadiWithPaisaPayEscrow'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.PadiWithPaisaPayEscrow
  Else If Value = 'CustomEmailTemplate1SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate1SendError
  Else If Value = 'CustomEmailTemplate2SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate2SendError
  Else If Value = 'CustomEmailTemplate3SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate3SendError
  Else If Value = 'CustomEmailTemplate4SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate4SendError
  Else If Value = 'CustomEmailTemplate5SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate5SendError
  Else If Value = 'CustomEmailTemplate6SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate6SendError
  Else If Value = 'CustomEmailTemplate7SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate7SendError
  Else If Value = 'CustomEmailTemplate8SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate8SendError
  Else If Value = 'CustomEmailTemplate9SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate9SendError
  Else If Value = 'CustomEmailTemplate10SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate10SendError
  Else If Value = 'CustomEmailTemplate11SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate11SendError
  Else If Value = 'CustomEmailTemplate12SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate12SendError
  Else If Value = 'CustomEmailTemplate13SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate13SendError
  Else If Value = 'CustomEmailTemplate14SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate14SendError
  Else If Value = 'CustomEmailTemplate15SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate15SendError
  Else If Value = 'CustomEmailTemplate16SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate16SendError
  Else If Value = 'CustomEmailTemplate17SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate17SendError
  Else If Value = 'CustomEmailTemplate18SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate18SendError
  Else If Value = 'CustomEmailTemplate19SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate19SendError
  Else If Value = 'CustomEmailTemplate20SendError'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomEmailTemplate20SendError
  Else If Value = 'ResponseRequiredForReturnCase'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.ResponseRequiredForReturnCase
  Else If Value = 'CustomCode'	 Then Data :=  	 SellingManagerSoldListingsPropertyTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerSoldListingsSortTypeCodeType);
Begin
       If Value ='SalesRecordID'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.SalesRecordID
  Else If Value = 'BuyerEmail'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.BuyerEmail
  Else If Value = 'SaleFormat'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.SaleFormat
  Else If Value = 'CustomLabel'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.CustomLabel
  Else If Value = 'TotalPrice'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.TotalPrice
  Else If Value = 'SaleDate'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.SaleDate
  Else If Value = 'PaidDate'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.PaidDate
  Else If Value = 'EmailsSent'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.EmailsSent
  Else If Value = 'CheckoutState'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.CheckoutState
  Else If Value = 'PaidState'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.PaidState
  Else If Value = 'ShippedState'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.ShippedState
  Else If Value = 'FeedbackLeft'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.FeedbackLeft
  Else If Value = 'FeedbackReceived'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.FeedbackReceived
  Else If Value = 'ShippedDate'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.ShippedDate
  Else If Value = 'BuyerPostalCode'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.BuyerPostalCode
  Else If Value = 'DaysSinceSale'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.DaysSinceSale
  Else If Value = 'StartPrice'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.StartPrice
  Else If Value = 'ReservePrice'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.ReservePrice
  Else If Value = 'SoldOn'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.SoldOn
  Else If Value = 'ShippingCost'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.ShippingCost
  Else If Value = 'ListedOn'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.ListedOn
  Else If Value = 'CustomCode'	 Then Data :=  	 SellingManagerSoldListingsSortTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : InventoryTrackingMethodCodeType);
Begin
       If Value ='ItemID'	 Then Data :=  	 InventoryTrackingMethodCodeType.ItemID
  Else If Value = 'SKU'	 Then Data :=  	 InventoryTrackingMethodCodeType.SKU
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerProductSortCodeType);
Begin
       If Value ='ActiveQuantity'	 Then Data :=  	 SellingManagerProductSortCodeType.ActiveQuantity
  Else If Value = 'AvailableToList'	 Then Data :=  	 SellingManagerProductSortCodeType.AvailableToList
  Else If Value = 'AveragePrice'	 Then Data :=  	 SellingManagerProductSortCodeType.AveragePrice
  Else If Value = 'AverageUnitCost'	 Then Data :=  	 SellingManagerProductSortCodeType.AverageUnitCost
  Else If Value = 'CustomLabel'	 Then Data :=  	 SellingManagerProductSortCodeType.CustomLabel
  Else If Value = 'ProductName'	 Then Data :=  	 SellingManagerProductSortCodeType.ProductName
  Else If Value = 'LastSubmittedDate'	 Then Data :=  	 SellingManagerProductSortCodeType.LastSubmittedDate
  Else If Value = 'ScheduledQuantity'	 Then Data :=  	 SellingManagerProductSortCodeType.ScheduledQuantity
  Else If Value = 'SoldQuantity'	 Then Data :=  	 SellingManagerProductSortCodeType.SoldQuantity
  Else If Value = 'SuccessPercent'	 Then Data :=  	 SellingManagerProductSortCodeType.SuccessPercent
  Else If Value = 'UnsoldQuantity'	 Then Data :=  	 SellingManagerProductSortCodeType.UnsoldQuantity
  Else If Value = 'FolderName'	 Then Data :=  	 SellingManagerProductSortCodeType.FolderName
  Else If Value = 'CustomCode'	 Then Data :=  	 SellingManagerProductSortCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellingManagerInventoryPropertyTypeCodeType);
Begin
       If Value ='ProductsOutOfStock'	 Then Data :=  	 SellingManagerInventoryPropertyTypeCodeType.ProductsOutOfStock
  Else If Value = 'Active'	 Then Data :=  	 SellingManagerInventoryPropertyTypeCodeType.Active
  Else If Value = 'InActive'	 Then Data :=  	 SellingManagerInventoryPropertyTypeCodeType.InActive
  Else If Value = 'LowStock'	 Then Data :=  	 SellingManagerInventoryPropertyTypeCodeType.LowStock
  Else If Value = 'WithListings'	 Then Data :=  	 SellingManagerInventoryPropertyTypeCodeType.WithListings
  Else If Value = 'WithoutListings'	 Then Data :=  	 SellingManagerInventoryPropertyTypeCodeType.WithoutListings
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CombinedPaymentPeriodCodeType);
Begin
       If Value ='Days_3'	 Then Data :=  	 CombinedPaymentPeriodCodeType.Days_3
  Else If Value = 'Days_5'	 Then Data :=  	 CombinedPaymentPeriodCodeType.Days_5
  Else If Value = 'Days_7'	 Then Data :=  	 CombinedPaymentPeriodCodeType.Days_7
  Else If Value = 'Days_14'	 Then Data :=  	 CombinedPaymentPeriodCodeType.Days_14
  Else If Value = 'Days_30'	 Then Data :=  	 CombinedPaymentPeriodCodeType.Days_30
  Else If Value = 'Ineligible'	 Then Data :=  	 CombinedPaymentPeriodCodeType.Ineligible
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TaskStatusCodeType);
Begin
       If Value ='Pending'	 Then Data :=  	 TaskStatusCodeType.Pending
  Else If Value = 'InProgress'	 Then Data :=  	 TaskStatusCodeType.InProgress
  Else If Value = 'Complete'	 Then Data :=  	 TaskStatusCodeType.Complete
  Else If Value = 'Failed'	 Then Data :=  	 TaskStatusCodeType.Failed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ListingTypeCodeType);
Begin
       If Value ='Unknown'	 Then Data :=  	 ListingTypeCodeType.Unknown
  Else If Value = 'Chinese'	 Then Data :=  	 ListingTypeCodeType.Chinese
  Else If Value = 'Dutch'	 Then Data :=  	 ListingTypeCodeType.Dutch
  Else If Value = 'Live'	 Then Data :=  	 ListingTypeCodeType.Live
  Else If Value = 'Auction'	 Then Data :=  	 ListingTypeCodeType.Auction
  Else If Value = 'AdType'	 Then Data :=  	 ListingTypeCodeType.AdType
  Else If Value = 'StoresFixedPrice'	 Then Data :=  	 ListingTypeCodeType.StoresFixedPrice
  Else If Value = 'PersonalOffer'	 Then Data :=  	 ListingTypeCodeType.PersonalOffer
  Else If Value = 'FixedPriceItem'	 Then Data :=  	 ListingTypeCodeType.FixedPriceItem
  Else If Value = 'Half'	 Then Data :=  	 ListingTypeCodeType.Half
  Else If Value = 'LeadGeneration'	 Then Data :=  	 ListingTypeCodeType.LeadGeneration
  Else If Value = 'Express'	 Then Data :=  	 ListingTypeCodeType.Express
  Else If Value = 'Shopping'	 Then Data :=  	 ListingTypeCodeType.Shopping
  Else If Value = 'CustomCode'	 Then Data :=  	 ListingTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : RecipientRelationCodeType);
Begin
       If Value ='_1'	 Then Data :=  	 RecipientRelationCodeType._1
  Else If Value = '_2'	 Then Data :=  	 RecipientRelationCodeType._2
  Else If Value = '_3'	 Then Data :=  	 RecipientRelationCodeType._3
  Else If Value = '_4'	 Then Data :=  	 RecipientRelationCodeType._4
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : EndReasonCodeType);
Begin
       If Value ='LostOrBroken'	 Then Data :=  	 EndReasonCodeType.LostOrBroken
  Else If Value = 'NotAvailable'	 Then Data :=  	 EndReasonCodeType.NotAvailable
  Else If Value = 'Incorrect'	 Then Data :=  	 EndReasonCodeType.Incorrect
  Else If Value = 'OtherListingError'	 Then Data :=  	 EndReasonCodeType.OtherListingError
  Else If Value = 'CustomCode'	 Then Data :=  	 EndReasonCodeType.CustomCode
  Else If Value = 'SellToHighBidder'	 Then Data :=  	 EndReasonCodeType.SellToHighBidder
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DiscountReasonCodeType);
Begin
       If Value ='SpecialOffer'	 Then Data :=  	 DiscountReasonCodeType.SpecialOffer
  Else If Value = 'Promotion'	 Then Data :=  	 DiscountReasonCodeType.Promotion
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeReasonCodeType);
Begin
       If Value ='BuyerHasNotPaid'	 Then Data :=  	 DisputeReasonCodeType.BuyerHasNotPaid
  Else If Value = 'TransactionMutuallyCanceled'	 Then Data :=  	 DisputeReasonCodeType.TransactionMutuallyCanceled
  Else If Value = 'ItemNotReceived'	 Then Data :=  	 DisputeReasonCodeType.ItemNotReceived
  Else If Value = 'SignificantlyNotAsDescribed'	 Then Data :=  	 DisputeReasonCodeType.SignificantlyNotAsDescribed
  Else If Value = 'NoRefund'	 Then Data :=  	 DisputeReasonCodeType.NoRefund
  Else If Value = 'ReturnPolicyUnpaidItem'	 Then Data :=  	 DisputeReasonCodeType.ReturnPolicyUnpaidItem
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeExplanationCodeType);
Begin
       If Value ='BuyerHasNotResponded'	 Then Data :=  	 DisputeExplanationCodeType.BuyerHasNotResponded
  Else If Value = 'BuyerRefusedToPay'	 Then Data :=  	 DisputeExplanationCodeType.BuyerRefusedToPay
  Else If Value = 'BuyerNotClearedToPay'	 Then Data :=  	 DisputeExplanationCodeType.BuyerNotClearedToPay
  Else If Value = 'BuyerReturnedItemForRefund'	 Then Data :=  	 DisputeExplanationCodeType.BuyerReturnedItemForRefund
  Else If Value = 'UnableToResolveTerms'	 Then Data :=  	 DisputeExplanationCodeType.UnableToResolveTerms
  Else If Value = 'BuyerNoLongerWantsItem'	 Then Data :=  	 DisputeExplanationCodeType.BuyerNoLongerWantsItem
  Else If Value = 'BuyerPurchasingMistake'	 Then Data :=  	 DisputeExplanationCodeType.BuyerPurchasingMistake
  Else If Value = 'ShipCountryNotSupported'	 Then Data :=  	 DisputeExplanationCodeType.ShipCountryNotSupported
  Else If Value = 'ShippingAddressNotConfirmed'	 Then Data :=  	 DisputeExplanationCodeType.ShippingAddressNotConfirmed
  Else If Value = 'PaymentMethodNotSupported'	 Then Data :=  	 DisputeExplanationCodeType.PaymentMethodNotSupported
  Else If Value = 'BuyerNoLongerRegistered'	 Then Data :=  	 DisputeExplanationCodeType.BuyerNoLongerRegistered
  Else If Value = 'OtherExplanation'	 Then Data :=  	 DisputeExplanationCodeType.OtherExplanation
  Else If Value = 'Unspecified'	 Then Data :=  	 DisputeExplanationCodeType.Unspecified
  Else If Value = 'UPIAssistance'	 Then Data :=  	 DisputeExplanationCodeType.UPIAssistance
  Else If Value = 'BuyerPaymentNotReceivedOrCleared'	 Then Data :=  	 DisputeExplanationCodeType.BuyerPaymentNotReceivedOrCleared
  Else If Value = 'SellerDoesntShipToCountry'	 Then Data :=  	 DisputeExplanationCodeType.SellerDoesntShipToCountry
  Else If Value = 'BuyerNotPaid'	 Then Data :=  	 DisputeExplanationCodeType.BuyerNotPaid
  Else If Value = 'UPIAssistanceDisabled'	 Then Data :=  	 DisputeExplanationCodeType.UPIAssistanceDisabled
  Else If Value = 'SellerRanOutOfStock'	 Then Data :=  	 DisputeExplanationCodeType.SellerRanOutOfStock
  Else If Value = 'CustomCode'	 Then Data :=  	 DisputeExplanationCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeActivityCodeType);
Begin
       If Value ='SellerAddInformation'	 Then Data :=  	 DisputeActivityCodeType.SellerAddInformation
  Else If Value = 'SellerCompletedTransaction'	 Then Data :=  	 DisputeActivityCodeType.SellerCompletedTransaction
  Else If Value = 'CameToAgreementNeedFVFCredit'	 Then Data :=  	 DisputeActivityCodeType.CameToAgreementNeedFVFCredit
  Else If Value = 'SellerEndCommunication'	 Then Data :=  	 DisputeActivityCodeType.SellerEndCommunication
  Else If Value = 'MutualAgreementOrNoBuyerResponse'	 Then Data :=  	 DisputeActivityCodeType.MutualAgreementOrNoBuyerResponse
  Else If Value = 'SellerOffersRefund'	 Then Data :=  	 DisputeActivityCodeType.SellerOffersRefund
  Else If Value = 'SellerShippedItem'	 Then Data :=  	 DisputeActivityCodeType.SellerShippedItem
  Else If Value = 'SellerComment'	 Then Data :=  	 DisputeActivityCodeType.SellerComment
  Else If Value = 'SellerPaymentNotReceived'	 Then Data :=  	 DisputeActivityCodeType.SellerPaymentNotReceived
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SecondChanceOfferDurationCodeType);
Begin
       If Value ='Days_1'	 Then Data :=  	 SecondChanceOfferDurationCodeType.Days_1
  Else If Value = 'Days_3'	 Then Data :=  	 SecondChanceOfferDurationCodeType.Days_3
  Else If Value = 'Days_5'	 Then Data :=  	 SecondChanceOfferDurationCodeType.Days_5
  Else If Value = 'Days_7'	 Then Data :=  	 SecondChanceOfferDurationCodeType.Days_7
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TradingRoleCodeType);
Begin
       If Value ='Buyer'	 Then Data :=  	 TradingRoleCodeType.Buyer
  Else If Value = 'Seller'	 Then Data :=  	 TradingRoleCodeType.Seller
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PromotionMethodCodeType);
Begin
       If Value ='CrossSell'	 Then Data :=  	 PromotionMethodCodeType.CrossSell
  Else If Value = 'UpSell'	 Then Data :=  	 PromotionMethodCodeType.UpSell
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StringMatchCodeType);
Begin
       If Value ='CustomCode'	 Then Data :=  	 StringMatchCodeType.CustomCode
  Else If Value = 'StartsWith'	 Then Data :=  	 StringMatchCodeType.StartsWith
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CountryCodeType);
Begin
       If Value ='AF'	 Then Data :=  	 CountryCodeType.AF
  Else If Value = 'AL'	 Then Data :=  	 CountryCodeType.AL
  Else If Value = 'DZ'	 Then Data :=  	 CountryCodeType.DZ
  Else If Value = 'AS_'	 Then Data :=  	 CountryCodeType.AS_
  Else If Value = 'AD'	 Then Data :=  	 CountryCodeType.AD
  Else If Value = 'AO'	 Then Data :=  	 CountryCodeType.AO
  Else If Value = 'AI'	 Then Data :=  	 CountryCodeType.AI
  Else If Value = 'AQ'	 Then Data :=  	 CountryCodeType.AQ
  Else If Value = 'AG'	 Then Data :=  	 CountryCodeType.AG
  Else If Value = 'AR'	 Then Data :=  	 CountryCodeType.AR
  Else If Value = 'AM'	 Then Data :=  	 CountryCodeType.AM
  Else If Value = 'AW'	 Then Data :=  	 CountryCodeType.AW
  Else If Value = 'AU'	 Then Data :=  	 CountryCodeType.AU
  Else If Value = 'AT'	 Then Data :=  	 CountryCodeType.AT
  Else If Value = 'AZ'	 Then Data :=  	 CountryCodeType.AZ
  Else If Value = 'BS'	 Then Data :=  	 CountryCodeType.BS
  Else If Value = 'BH'	 Then Data :=  	 CountryCodeType.BH
  Else If Value = 'BD'	 Then Data :=  	 CountryCodeType.BD
  Else If Value = 'BB'	 Then Data :=  	 CountryCodeType.BB
  Else If Value = 'BY'	 Then Data :=  	 CountryCodeType.BY
  Else If Value = 'BE'	 Then Data :=  	 CountryCodeType.BE
  Else If Value = 'BZ'	 Then Data :=  	 CountryCodeType.BZ
  Else If Value = 'BJ'	 Then Data :=  	 CountryCodeType.BJ
  Else If Value = 'BM'	 Then Data :=  	 CountryCodeType.BM
  Else If Value = 'BT'	 Then Data :=  	 CountryCodeType.BT
  Else If Value = 'BO'	 Then Data :=  	 CountryCodeType.BO
  Else If Value = 'BA'	 Then Data :=  	 CountryCodeType.BA
  Else If Value = 'BW'	 Then Data :=  	 CountryCodeType.BW
  Else If Value = 'BV'	 Then Data :=  	 CountryCodeType.BV
  Else If Value = 'BR'	 Then Data :=  	 CountryCodeType.BR
  Else If Value = 'IO'	 Then Data :=  	 CountryCodeType.IO
  Else If Value = 'BN'	 Then Data :=  	 CountryCodeType.BN
  Else If Value = 'BG'	 Then Data :=  	 CountryCodeType.BG
  Else If Value = 'BF'	 Then Data :=  	 CountryCodeType.BF
  Else If Value = 'BI'	 Then Data :=  	 CountryCodeType.BI
  Else If Value = 'KH'	 Then Data :=  	 CountryCodeType.KH
  Else If Value = 'CM'	 Then Data :=  	 CountryCodeType.CM
  Else If Value = 'CA'	 Then Data :=  	 CountryCodeType.CA
  Else If Value = 'CV'	 Then Data :=  	 CountryCodeType.CV
  Else If Value = 'KY'	 Then Data :=  	 CountryCodeType.KY
  Else If Value = 'CF'	 Then Data :=  	 CountryCodeType.CF
  Else If Value = 'TD'	 Then Data :=  	 CountryCodeType.TD
  Else If Value = 'CL'	 Then Data :=  	 CountryCodeType.CL
  Else If Value = 'CN'	 Then Data :=  	 CountryCodeType.CN
  Else If Value = 'CX'	 Then Data :=  	 CountryCodeType.CX
  Else If Value = 'CC'	 Then Data :=  	 CountryCodeType.CC
  Else If Value = 'CO'	 Then Data :=  	 CountryCodeType.CO
  Else If Value = 'KM'	 Then Data :=  	 CountryCodeType.KM
  Else If Value = 'CG'	 Then Data :=  	 CountryCodeType.CG
  Else If Value = 'CD'	 Then Data :=  	 CountryCodeType.CD
  Else If Value = 'CK'	 Then Data :=  	 CountryCodeType.CK
  Else If Value = 'CR'	 Then Data :=  	 CountryCodeType.CR
  Else If Value = 'CI'	 Then Data :=  	 CountryCodeType.CI
  Else If Value = 'HR'	 Then Data :=  	 CountryCodeType.HR
  Else If Value = 'CU'	 Then Data :=  	 CountryCodeType.CU
  Else If Value = 'CY'	 Then Data :=  	 CountryCodeType.CY
  Else If Value = 'CZ'	 Then Data :=  	 CountryCodeType.CZ
  Else If Value = 'DK'	 Then Data :=  	 CountryCodeType.DK
  Else If Value = 'DJ'	 Then Data :=  	 CountryCodeType.DJ
  Else If Value = 'DM'	 Then Data :=  	 CountryCodeType.DM
  Else If Value = 'DO_'	 Then Data :=  	 CountryCodeType.DO_
  Else If Value = 'TP'	 Then Data :=  	 CountryCodeType.TP
  Else If Value = 'EC'	 Then Data :=  	 CountryCodeType.EC
  Else If Value = 'EG'	 Then Data :=  	 CountryCodeType.EG
  Else If Value = 'SV'	 Then Data :=  	 CountryCodeType.SV
  Else If Value = 'GQ'	 Then Data :=  	 CountryCodeType.GQ
  Else If Value = 'ER'	 Then Data :=  	 CountryCodeType.ER
  Else If Value = 'EE'	 Then Data :=  	 CountryCodeType.EE
  Else If Value = 'ET'	 Then Data :=  	 CountryCodeType.ET
  Else If Value = 'FK'	 Then Data :=  	 CountryCodeType.FK
  Else If Value = 'FO'	 Then Data :=  	 CountryCodeType.FO
  Else If Value = 'FJ'	 Then Data :=  	 CountryCodeType.FJ
  Else If Value = 'FI'	 Then Data :=  	 CountryCodeType.FI
  Else If Value = 'FR'	 Then Data :=  	 CountryCodeType.FR
  Else If Value = 'GF'	 Then Data :=  	 CountryCodeType.GF
  Else If Value = 'PF'	 Then Data :=  	 CountryCodeType.PF
  Else If Value = 'TF'	 Then Data :=  	 CountryCodeType.TF
  Else If Value = 'GA'	 Then Data :=  	 CountryCodeType.GA
  Else If Value = 'GM'	 Then Data :=  	 CountryCodeType.GM
  Else If Value = 'GE'	 Then Data :=  	 CountryCodeType.GE
  Else If Value = 'DE'	 Then Data :=  	 CountryCodeType.DE
  Else If Value = 'GH'	 Then Data :=  	 CountryCodeType.GH
  Else If Value = 'GI'	 Then Data :=  	 CountryCodeType.GI
  Else If Value = 'GR'	 Then Data :=  	 CountryCodeType.GR
  Else If Value = 'GL'	 Then Data :=  	 CountryCodeType.GL
  Else If Value = 'GD'	 Then Data :=  	 CountryCodeType.GD
  Else If Value = 'GP'	 Then Data :=  	 CountryCodeType.GP
  Else If Value = 'GU'	 Then Data :=  	 CountryCodeType.GU
  Else If Value = 'GT'	 Then Data :=  	 CountryCodeType.GT
  Else If Value = 'GN'	 Then Data :=  	 CountryCodeType.GN
  Else If Value = 'GW'	 Then Data :=  	 CountryCodeType.GW
  Else If Value = 'GY'	 Then Data :=  	 CountryCodeType.GY
  Else If Value = 'HT'	 Then Data :=  	 CountryCodeType.HT
  Else If Value = 'HM'	 Then Data :=  	 CountryCodeType.HM
  Else If Value = 'VA'	 Then Data :=  	 CountryCodeType.VA
  Else If Value = 'HN'	 Then Data :=  	 CountryCodeType.HN
  Else If Value = 'HK'	 Then Data :=  	 CountryCodeType.HK
  Else If Value = 'HU'	 Then Data :=  	 CountryCodeType.HU
  Else If Value = 'IS_'	 Then Data :=  	 CountryCodeType.IS_
  Else If Value = 'IN_'	 Then Data :=  	 CountryCodeType.IN_
  Else If Value = 'ID'	 Then Data :=  	 CountryCodeType.ID
  Else If Value = 'IR'	 Then Data :=  	 CountryCodeType.IR
  Else If Value = 'IQ'	 Then Data :=  	 CountryCodeType.IQ
  Else If Value = 'IE'	 Then Data :=  	 CountryCodeType.IE
  Else If Value = 'IL'	 Then Data :=  	 CountryCodeType.IL
  Else If Value = 'IT'	 Then Data :=  	 CountryCodeType.IT
  Else If Value = 'JM'	 Then Data :=  	 CountryCodeType.JM
  Else If Value = 'JP'	 Then Data :=  	 CountryCodeType.JP
  Else If Value = 'JO'	 Then Data :=  	 CountryCodeType.JO
  Else If Value = 'KZ'	 Then Data :=  	 CountryCodeType.KZ
  Else If Value = 'KE'	 Then Data :=  	 CountryCodeType.KE
  Else If Value = 'KI'	 Then Data :=  	 CountryCodeType.KI
  Else If Value = 'KP'	 Then Data :=  	 CountryCodeType.KP
  Else If Value = 'KR'	 Then Data :=  	 CountryCodeType.KR
  Else If Value = 'KW'	 Then Data :=  	 CountryCodeType.KW
  Else If Value = 'KG'	 Then Data :=  	 CountryCodeType.KG
  Else If Value = 'LA'	 Then Data :=  	 CountryCodeType.LA
  Else If Value = 'LV'	 Then Data :=  	 CountryCodeType.LV
  Else If Value = 'LB'	 Then Data :=  	 CountryCodeType.LB
  Else If Value = 'LS'	 Then Data :=  	 CountryCodeType.LS
  Else If Value = 'LR'	 Then Data :=  	 CountryCodeType.LR
  Else If Value = 'LY'	 Then Data :=  	 CountryCodeType.LY
  Else If Value = 'LI'	 Then Data :=  	 CountryCodeType.LI
  Else If Value = 'LT'	 Then Data :=  	 CountryCodeType.LT
  Else If Value = 'LU'	 Then Data :=  	 CountryCodeType.LU
  Else If Value = 'MO'	 Then Data :=  	 CountryCodeType.MO
  Else If Value = 'MK'	 Then Data :=  	 CountryCodeType.MK
  Else If Value = 'MG'	 Then Data :=  	 CountryCodeType.MG
  Else If Value = 'MW'	 Then Data :=  	 CountryCodeType.MW
  Else If Value = 'MY'	 Then Data :=  	 CountryCodeType.MY
  Else If Value = 'MV'	 Then Data :=  	 CountryCodeType.MV
  Else If Value = 'ML'	 Then Data :=  	 CountryCodeType.ML
  Else If Value = 'MT'	 Then Data :=  	 CountryCodeType.MT
  Else If Value = 'MH'	 Then Data :=  	 CountryCodeType.MH
  Else If Value = 'MQ'	 Then Data :=  	 CountryCodeType.MQ
  Else If Value = 'MR'	 Then Data :=  	 CountryCodeType.MR
  Else If Value = 'MU'	 Then Data :=  	 CountryCodeType.MU
  Else If Value = 'YT'	 Then Data :=  	 CountryCodeType.YT
  Else If Value = 'MX'	 Then Data :=  	 CountryCodeType.MX
  Else If Value = 'FM'	 Then Data :=  	 CountryCodeType.FM
  Else If Value = 'MD'	 Then Data :=  	 CountryCodeType.MD
  Else If Value = 'MC'	 Then Data :=  	 CountryCodeType.MC
  Else If Value = 'MN'	 Then Data :=  	 CountryCodeType.MN
  Else If Value = 'MS'	 Then Data :=  	 CountryCodeType.MS
  Else If Value = 'MA'	 Then Data :=  	 CountryCodeType.MA
  Else If Value = 'MZ'	 Then Data :=  	 CountryCodeType.MZ
  Else If Value = 'MM'	 Then Data :=  	 CountryCodeType.MM
  Else If Value = 'NA'	 Then Data :=  	 CountryCodeType.NA
  Else If Value = 'NR'	 Then Data :=  	 CountryCodeType.NR
  Else If Value = 'NP'	 Then Data :=  	 CountryCodeType.NP
  Else If Value = 'NL'	 Then Data :=  	 CountryCodeType.NL
  Else If Value = 'AN'	 Then Data :=  	 CountryCodeType.AN
  Else If Value = 'NC'	 Then Data :=  	 CountryCodeType.NC
  Else If Value = 'NZ'	 Then Data :=  	 CountryCodeType.NZ
  Else If Value = 'NI'	 Then Data :=  	 CountryCodeType.NI
  Else If Value = 'NE'	 Then Data :=  	 CountryCodeType.NE
  Else If Value = 'NG'	 Then Data :=  	 CountryCodeType.NG
  Else If Value = 'NU'	 Then Data :=  	 CountryCodeType.NU
  Else If Value = 'NF'	 Then Data :=  	 CountryCodeType.NF
  Else If Value = 'MP'	 Then Data :=  	 CountryCodeType.MP
  Else If Value = 'NO'	 Then Data :=  	 CountryCodeType.NO
  Else If Value = 'OM'	 Then Data :=  	 CountryCodeType.OM
  Else If Value = 'PK'	 Then Data :=  	 CountryCodeType.PK
  Else If Value = 'PW'	 Then Data :=  	 CountryCodeType.PW
  Else If Value = 'PS'	 Then Data :=  	 CountryCodeType.PS
  Else If Value = 'PA'	 Then Data :=  	 CountryCodeType.PA
  Else If Value = 'PG'	 Then Data :=  	 CountryCodeType.PG
  Else If Value = 'PY'	 Then Data :=  	 CountryCodeType.PY
  Else If Value = 'PE'	 Then Data :=  	 CountryCodeType.PE
  Else If Value = 'PH'	 Then Data :=  	 CountryCodeType.PH
  Else If Value = 'PN'	 Then Data :=  	 CountryCodeType.PN
  Else If Value = 'PL'	 Then Data :=  	 CountryCodeType.PL
  Else If Value = 'PT'	 Then Data :=  	 CountryCodeType.PT
  Else If Value = 'PR'	 Then Data :=  	 CountryCodeType.PR
  Else If Value = 'QA'	 Then Data :=  	 CountryCodeType.QA
  Else If Value = 'RE'	 Then Data :=  	 CountryCodeType.RE
  Else If Value = 'RO'	 Then Data :=  	 CountryCodeType.RO
  Else If Value = 'RU'	 Then Data :=  	 CountryCodeType.RU
  Else If Value = 'RW'	 Then Data :=  	 CountryCodeType.RW
  Else If Value = 'SH'	 Then Data :=  	 CountryCodeType.SH
  Else If Value = 'KN'	 Then Data :=  	 CountryCodeType.KN
  Else If Value = 'LC'	 Then Data :=  	 CountryCodeType.LC
  Else If Value = 'PM'	 Then Data :=  	 CountryCodeType.PM
  Else If Value = 'VC'	 Then Data :=  	 CountryCodeType.VC
  Else If Value = 'WS'	 Then Data :=  	 CountryCodeType.WS
  Else If Value = 'SM'	 Then Data :=  	 CountryCodeType.SM
  Else If Value = 'ST'	 Then Data :=  	 CountryCodeType.ST
  Else If Value = 'SA'	 Then Data :=  	 CountryCodeType.SA
  Else If Value = 'SN'	 Then Data :=  	 CountryCodeType.SN
  Else If Value = 'SC'	 Then Data :=  	 CountryCodeType.SC
  Else If Value = 'SL'	 Then Data :=  	 CountryCodeType.SL
  Else If Value = 'SG'	 Then Data :=  	 CountryCodeType.SG
  Else If Value = 'SK'	 Then Data :=  	 CountryCodeType.SK
  Else If Value = 'SI'	 Then Data :=  	 CountryCodeType.SI
  Else If Value = 'SB'	 Then Data :=  	 CountryCodeType.SB
  Else If Value = 'SO'	 Then Data :=  	 CountryCodeType.SO
  Else If Value = 'ZA'	 Then Data :=  	 CountryCodeType.ZA
  Else If Value = 'GS'	 Then Data :=  	 CountryCodeType.GS
  Else If Value = 'ES'	 Then Data :=  	 CountryCodeType.ES
  Else If Value = 'LK'	 Then Data :=  	 CountryCodeType.LK
  Else If Value = 'SD'	 Then Data :=  	 CountryCodeType.SD
  Else If Value = 'SR'	 Then Data :=  	 CountryCodeType.SR
  Else If Value = 'SJ'	 Then Data :=  	 CountryCodeType.SJ
  Else If Value = 'SZ'	 Then Data :=  	 CountryCodeType.SZ
  Else If Value = 'SE'	 Then Data :=  	 CountryCodeType.SE
  Else If Value = 'CH'	 Then Data :=  	 CountryCodeType.CH
  Else If Value = 'SY'	 Then Data :=  	 CountryCodeType.SY
  Else If Value = 'TW'	 Then Data :=  	 CountryCodeType.TW
  Else If Value = 'TJ'	 Then Data :=  	 CountryCodeType.TJ
  Else If Value = 'TZ'	 Then Data :=  	 CountryCodeType.TZ
  Else If Value = 'TH'	 Then Data :=  	 CountryCodeType.TH
  Else If Value = 'TG'	 Then Data :=  	 CountryCodeType.TG
  Else If Value = 'TK'	 Then Data :=  	 CountryCodeType.TK
  Else If Value = 'TO_'	 Then Data :=  	 CountryCodeType.TO_
  Else If Value = 'TT'	 Then Data :=  	 CountryCodeType.TT
  Else If Value = 'TN'	 Then Data :=  	 CountryCodeType.TN
  Else If Value = 'TR'	 Then Data :=  	 CountryCodeType.TR
  Else If Value = 'TM'	 Then Data :=  	 CountryCodeType.TM
  Else If Value = 'TC'	 Then Data :=  	 CountryCodeType.TC
  Else If Value = 'TV'	 Then Data :=  	 CountryCodeType.TV
  Else If Value = 'UG'	 Then Data :=  	 CountryCodeType.UG
  Else If Value = 'UA'	 Then Data :=  	 CountryCodeType.UA
  Else If Value = 'AE'	 Then Data :=  	 CountryCodeType.AE
  Else If Value = 'GB'	 Then Data :=  	 CountryCodeType.GB
  Else If Value = 'US'	 Then Data :=  	 CountryCodeType.US
  Else If Value = 'UM'	 Then Data :=  	 CountryCodeType.UM
  Else If Value = 'UY'	 Then Data :=  	 CountryCodeType.UY
  Else If Value = 'UZ'	 Then Data :=  	 CountryCodeType.UZ
  Else If Value = 'VU'	 Then Data :=  	 CountryCodeType.VU
  Else If Value = 'VE'	 Then Data :=  	 CountryCodeType.VE
  Else If Value = 'VN'	 Then Data :=  	 CountryCodeType.VN
  Else If Value = 'VG'	 Then Data :=  	 CountryCodeType.VG
  Else If Value = 'VI'	 Then Data :=  	 CountryCodeType.VI
  Else If Value = 'WF'	 Then Data :=  	 CountryCodeType.WF
  Else If Value = 'EH'	 Then Data :=  	 CountryCodeType.EH
  Else If Value = 'YE'	 Then Data :=  	 CountryCodeType.YE
  Else If Value = 'YU'	 Then Data :=  	 CountryCodeType.YU
  Else If Value = 'ZM'	 Then Data :=  	 CountryCodeType.ZM
  Else If Value = 'ZW'	 Then Data :=  	 CountryCodeType.ZW
  Else If Value = 'AA'	 Then Data :=  	 CountryCodeType.AA
  Else If Value = 'QM'	 Then Data :=  	 CountryCodeType.QM
  Else If Value = 'QN'	 Then Data :=  	 CountryCodeType.QN
  Else If Value = 'QO'	 Then Data :=  	 CountryCodeType.QO
  Else If Value = 'QP'	 Then Data :=  	 CountryCodeType.QP
  Else If Value = 'JE'	 Then Data :=  	 CountryCodeType.JE
  Else If Value = 'GG'	 Then Data :=  	 CountryCodeType.GG
  Else If Value = 'ZZ'	 Then Data :=  	 CountryCodeType.ZZ
  Else If Value = 'RS'	 Then Data :=  	 CountryCodeType.RS
  Else If Value = 'ME'	 Then Data :=  	 CountryCodeType.ME
  Else If Value = 'CustomCode'	 Then Data :=  	 CountryCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : TransactionPlatformCodeType);
Begin
       If Value ='eBay'	 Then Data :=  	 TransactionPlatformCodeType.EBay
  Else If Value = 'Express'	 Then Data :=  	 TransactionPlatformCodeType.Express
  Else If Value = 'Half'	 Then Data :=  	 TransactionPlatformCodeType.Half
  Else If Value = 'Shopping'	 Then Data :=  	 TransactionPlatformCodeType.Shopping
  Else If Value = 'WorldOfGood'	 Then Data :=  	 TransactionPlatformCodeType.WorldOfGood
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemSortTypeCodeType);
Begin
       If Value ='ItemID'	 Then Data :=  	 ItemSortTypeCodeType.ItemID
  Else If Value = 'Price'	 Then Data :=  	 ItemSortTypeCodeType.Price
  Else If Value = 'StartPrice'	 Then Data :=  	 ItemSortTypeCodeType.StartPrice
  Else If Value = 'Title'	 Then Data :=  	 ItemSortTypeCodeType.Title
  Else If Value = 'BidCount'	 Then Data :=  	 ItemSortTypeCodeType.BidCount
  Else If Value = 'Quantity'	 Then Data :=  	 ItemSortTypeCodeType.Quantity
  Else If Value = 'StartTime'	 Then Data :=  	 ItemSortTypeCodeType.StartTime
  Else If Value = 'EndTime'	 Then Data :=  	 ItemSortTypeCodeType.EndTime
  Else If Value = 'SellerUserID'	 Then Data :=  	 ItemSortTypeCodeType.SellerUserID
  Else If Value = 'TimeLeft'	 Then Data :=  	 ItemSortTypeCodeType.TimeLeft
  Else If Value = 'ListingDuration'	 Then Data :=  	 ItemSortTypeCodeType.ListingDuration
  Else If Value = 'ListingType'	 Then Data :=  	 ItemSortTypeCodeType.ListingType
  Else If Value = 'CurrentPrice'	 Then Data :=  	 ItemSortTypeCodeType.CurrentPrice
  Else If Value = 'ReservePrice'	 Then Data :=  	 ItemSortTypeCodeType.ReservePrice
  Else If Value = 'MaxBid'	 Then Data :=  	 ItemSortTypeCodeType.MaxBid
  Else If Value = 'BidderCount'	 Then Data :=  	 ItemSortTypeCodeType.BidderCount
  Else If Value = 'HighBidderUserID'	 Then Data :=  	 ItemSortTypeCodeType.HighBidderUserID
  Else If Value = 'BuyerUserID'	 Then Data :=  	 ItemSortTypeCodeType.BuyerUserID
  Else If Value = 'BuyerPostalCode'	 Then Data :=  	 ItemSortTypeCodeType.BuyerPostalCode
  Else If Value = 'BuyerEmail'	 Then Data :=  	 ItemSortTypeCodeType.BuyerEmail
  Else If Value = 'SellerEmail'	 Then Data :=  	 ItemSortTypeCodeType.SellerEmail
  Else If Value = 'TotalPrice'	 Then Data :=  	 ItemSortTypeCodeType.TotalPrice
  Else If Value = 'WatchCount'	 Then Data :=  	 ItemSortTypeCodeType.WatchCount
  Else If Value = 'BestOfferCount'	 Then Data :=  	 ItemSortTypeCodeType.BestOfferCount
  Else If Value = 'QuestionCount'	 Then Data :=  	 ItemSortTypeCodeType.QuestionCount
  Else If Value = 'ShippingServiceCost'	 Then Data :=  	 ItemSortTypeCodeType.ShippingServiceCost
  Else If Value = 'FeedbackReceived'	 Then Data :=  	 ItemSortTypeCodeType.FeedbackReceived
  Else If Value = 'FeedbackLeft'	 Then Data :=  	 ItemSortTypeCodeType.FeedbackLeft
  Else If Value = 'UserID'	 Then Data :=  	 ItemSortTypeCodeType.UserID
  Else If Value = 'QuantitySold'	 Then Data :=  	 ItemSortTypeCodeType.QuantitySold
  Else If Value = 'BestOffer'	 Then Data :=  	 ItemSortTypeCodeType.BestOffer
  Else If Value = 'QuantityAvailable'	 Then Data :=  	 ItemSortTypeCodeType.QuantityAvailable
  Else If Value = 'QuantityPurchased'	 Then Data :=  	 ItemSortTypeCodeType.QuantityPurchased
  Else If Value = 'WonPlatform'	 Then Data :=  	 ItemSortTypeCodeType.WonPlatform
  Else If Value = 'SoldPlatform'	 Then Data :=  	 ItemSortTypeCodeType.SoldPlatform
  Else If Value = 'ListingDurationDescending'	 Then Data :=  	 ItemSortTypeCodeType.ListingDurationDescending
  Else If Value = 'ListingTypeDescending'	 Then Data :=  	 ItemSortTypeCodeType.ListingTypeDescending
  Else If Value = 'CurrentPriceDescending'	 Then Data :=  	 ItemSortTypeCodeType.CurrentPriceDescending
  Else If Value = 'ReservePriceDescending'	 Then Data :=  	 ItemSortTypeCodeType.ReservePriceDescending
  Else If Value = 'MaxBidDescending'	 Then Data :=  	 ItemSortTypeCodeType.MaxBidDescending
  Else If Value = 'BidderCountDescending'	 Then Data :=  	 ItemSortTypeCodeType.BidderCountDescending
  Else If Value = 'HighBidderUserIDDescending'	 Then Data :=  	 ItemSortTypeCodeType.HighBidderUserIDDescending
  Else If Value = 'BuyerUserIDDescending'	 Then Data :=  	 ItemSortTypeCodeType.BuyerUserIDDescending
  Else If Value = 'BuyerPostalCodeDescending'	 Then Data :=  	 ItemSortTypeCodeType.BuyerPostalCodeDescending
  Else If Value = 'BuyerEmailDescending'	 Then Data :=  	 ItemSortTypeCodeType.BuyerEmailDescending
  Else If Value = 'SellerEmailDescending'	 Then Data :=  	 ItemSortTypeCodeType.SellerEmailDescending
  Else If Value = 'TotalPriceDescending'	 Then Data :=  	 ItemSortTypeCodeType.TotalPriceDescending
  Else If Value = 'WatchCountDescending'	 Then Data :=  	 ItemSortTypeCodeType.WatchCountDescending
  Else If Value = 'QuestionCountDescending'	 Then Data :=  	 ItemSortTypeCodeType.QuestionCountDescending
  Else If Value = 'ShippingServiceCostDescending'	 Then Data :=  	 ItemSortTypeCodeType.ShippingServiceCostDescending
  Else If Value = 'FeedbackReceivedDescending'	 Then Data :=  	 ItemSortTypeCodeType.FeedbackReceivedDescending
  Else If Value = 'FeedbackLeftDescending'	 Then Data :=  	 ItemSortTypeCodeType.FeedbackLeftDescending
  Else If Value = 'UserIDDescending'	 Then Data :=  	 ItemSortTypeCodeType.UserIDDescending
  Else If Value = 'QuantitySoldDescending'	 Then Data :=  	 ItemSortTypeCodeType.QuantitySoldDescending
  Else If Value = 'BestOfferCountDescending'	 Then Data :=  	 ItemSortTypeCodeType.BestOfferCountDescending
  Else If Value = 'QuantityAvailableDescending'	 Then Data :=  	 ItemSortTypeCodeType.QuantityAvailableDescending
  Else If Value = 'QuantityPurchasedDescending'	 Then Data :=  	 ItemSortTypeCodeType.QuantityPurchasedDescending
  Else If Value = 'BestOfferDescending'	 Then Data :=  	 ItemSortTypeCodeType.BestOfferDescending
  Else If Value = 'ItemIDDescending'	 Then Data :=  	 ItemSortTypeCodeType.ItemIDDescending
  Else If Value = 'PriceDescending'	 Then Data :=  	 ItemSortTypeCodeType.PriceDescending
  Else If Value = 'StartPriceDescending'	 Then Data :=  	 ItemSortTypeCodeType.StartPriceDescending
  Else If Value = 'TitleDescending'	 Then Data :=  	 ItemSortTypeCodeType.TitleDescending
  Else If Value = 'BidCountDescending'	 Then Data :=  	 ItemSortTypeCodeType.BidCountDescending
  Else If Value = 'QuantityDescending'	 Then Data :=  	 ItemSortTypeCodeType.QuantityDescending
  Else If Value = 'StartTimeDescending'	 Then Data :=  	 ItemSortTypeCodeType.StartTimeDescending
  Else If Value = 'EndTimeDescending'	 Then Data :=  	 ItemSortTypeCodeType.EndTimeDescending
  Else If Value = 'SellerUserIDDescending'	 Then Data :=  	 ItemSortTypeCodeType.SellerUserIDDescending
  Else If Value = 'TimeLeftDescending'	 Then Data :=  	 ItemSortTypeCodeType.TimeLeftDescending
  Else If Value = 'WonPlatformDescending'	 Then Data :=  	 ItemSortTypeCodeType.WonPlatformDescending
  Else If Value = 'SoldPlatformDescending'	 Then Data :=  	 ItemSortTypeCodeType.SoldPlatformDescending
  Else If Value = 'LeadCount'	 Then Data :=  	 ItemSortTypeCodeType.LeadCount
  Else If Value = 'NewLeadCount'	 Then Data :=  	 ItemSortTypeCodeType.NewLeadCount
  Else If Value = 'LeadCountDescending'	 Then Data :=  	 ItemSortTypeCodeType.LeadCountDescending
  Else If Value = 'NewLeadCountDescending'	 Then Data :=  	 ItemSortTypeCodeType.NewLeadCountDescending
  Else If Value = 'ClassifiedAdPayPerLeadFee'	 Then Data :=  	 ItemSortTypeCodeType.ClassifiedAdPayPerLeadFee
  Else If Value = 'ClassifiedAdPayPerLeadFeeDescending'	 Then Data :=  	 ItemSortTypeCodeType.ClassifiedAdPayPerLeadFeeDescending
  Else If Value = 'CustomCode'	 Then Data :=  	 ItemSortTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CommentTypeCodeType);
Begin
       If Value ='Positive'	 Then Data :=  	 CommentTypeCodeType.Positive
  Else If Value = 'Neutral'	 Then Data :=  	 CommentTypeCodeType.Neutral
  Else If Value = 'Negative'	 Then Data :=  	 CommentTypeCodeType.Negative
  Else If Value = 'Withdrawn'	 Then Data :=  	 CommentTypeCodeType.Withdrawn
  Else If Value = 'IndependentlyWithdrawn'	 Then Data :=  	 CommentTypeCodeType.IndependentlyWithdrawn
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeedbackTypeCodeType);
Begin
       If Value ='FeedbackReceivedAsSeller'	 Then Data :=  	 FeedbackTypeCodeType.FeedbackReceivedAsSeller
  Else If Value = 'FeedbackReceivedAsBuyer'	 Then Data :=  	 FeedbackTypeCodeType.FeedbackReceivedAsBuyer
  Else If Value = 'FeedbackReceived'	 Then Data :=  	 FeedbackTypeCodeType.FeedbackReceived
  Else If Value = 'FeedbackLeft'	 Then Data :=  	 FeedbackTypeCodeType.FeedbackLeft
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ListingStatusCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 ListingStatusCodeType.Active
  Else If Value = 'Ended'	 Then Data :=  	 ListingStatusCodeType.Ended
  Else If Value = 'Completed'	 Then Data :=  	 ListingStatusCodeType.Completed
  Else If Value = 'CustomCode'	 Then Data :=  	 ListingStatusCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : GetAllBiddersModeCodeType);
Begin
       If Value ='ViewAll'	 Then Data :=  	 GetAllBiddersModeCodeType.ViewAll
  Else If Value = 'EndedListing'	 Then Data :=  	 GetAllBiddersModeCodeType.EndedListing
  Else If Value = 'SecondChanceEligibleEndedListing'	 Then Data :=  	 GetAllBiddersModeCodeType.SecondChanceEligibleEndedListing
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CurrencyCodeType);
Begin
       If Value ='AFA'	 Then Data :=  	 CurrencyCodeType.AFA
  Else If Value = 'ALL'	 Then Data :=  	 CurrencyCodeType.ALL
  Else If Value = 'DZD'	 Then Data :=  	 CurrencyCodeType.DZD
  Else If Value = 'ADP'	 Then Data :=  	 CurrencyCodeType.ADP
  Else If Value = 'AOA'	 Then Data :=  	 CurrencyCodeType.AOA
  Else If Value = 'ARS'	 Then Data :=  	 CurrencyCodeType.ARS
  Else If Value = 'AMD'	 Then Data :=  	 CurrencyCodeType.AMD
  Else If Value = 'AWG'	 Then Data :=  	 CurrencyCodeType.AWG
  Else If Value = 'AZM'	 Then Data :=  	 CurrencyCodeType.AZM
  Else If Value = 'BSD'	 Then Data :=  	 CurrencyCodeType.BSD
  Else If Value = 'BHD'	 Then Data :=  	 CurrencyCodeType.BHD
  Else If Value = 'BDT'	 Then Data :=  	 CurrencyCodeType.BDT
  Else If Value = 'BBD'	 Then Data :=  	 CurrencyCodeType.BBD
  Else If Value = 'BYR'	 Then Data :=  	 CurrencyCodeType.BYR
  Else If Value = 'BZD'	 Then Data :=  	 CurrencyCodeType.BZD
  Else If Value = 'BMD'	 Then Data :=  	 CurrencyCodeType.BMD
  Else If Value = 'BTN'	 Then Data :=  	 CurrencyCodeType.BTN
  Else If Value = 'INR'	 Then Data :=  	 CurrencyCodeType.INR
  Else If Value = 'BOV'	 Then Data :=  	 CurrencyCodeType.BOV
  Else If Value = 'BOB'	 Then Data :=  	 CurrencyCodeType.BOB
  Else If Value = 'BAM'	 Then Data :=  	 CurrencyCodeType.BAM
  Else If Value = 'BWP'	 Then Data :=  	 CurrencyCodeType.BWP
  Else If Value = 'BRL'	 Then Data :=  	 CurrencyCodeType.BRL
  Else If Value = 'BND'	 Then Data :=  	 CurrencyCodeType.BND
  Else If Value = 'BGL'	 Then Data :=  	 CurrencyCodeType.BGL
  Else If Value = 'BGN'	 Then Data :=  	 CurrencyCodeType.BGN
  Else If Value = 'BIF'	 Then Data :=  	 CurrencyCodeType.BIF
  Else If Value = 'KHR'	 Then Data :=  	 CurrencyCodeType.KHR
  Else If Value = 'CAD'	 Then Data :=  	 CurrencyCodeType.CAD
  Else If Value = 'CVE'	 Then Data :=  	 CurrencyCodeType.CVE
  Else If Value = 'KYD'	 Then Data :=  	 CurrencyCodeType.KYD
  Else If Value = 'XAF'	 Then Data :=  	 CurrencyCodeType.XAF
  Else If Value = 'CLF'	 Then Data :=  	 CurrencyCodeType.CLF
  Else If Value = 'CLP'	 Then Data :=  	 CurrencyCodeType.CLP
  Else If Value = 'CNY'	 Then Data :=  	 CurrencyCodeType.CNY
  Else If Value = 'COP'	 Then Data :=  	 CurrencyCodeType.COP
  Else If Value = 'KMF'	 Then Data :=  	 CurrencyCodeType.KMF
  Else If Value = 'CDF'	 Then Data :=  	 CurrencyCodeType.CDF
  Else If Value = 'CRC'	 Then Data :=  	 CurrencyCodeType.CRC
  Else If Value = 'HRK'	 Then Data :=  	 CurrencyCodeType.HRK
  Else If Value = 'CUP'	 Then Data :=  	 CurrencyCodeType.CUP
  Else If Value = 'CYP'	 Then Data :=  	 CurrencyCodeType.CYP
  Else If Value = 'CZK'	 Then Data :=  	 CurrencyCodeType.CZK
  Else If Value = 'DKK'	 Then Data :=  	 CurrencyCodeType.DKK
  Else If Value = 'DJF'	 Then Data :=  	 CurrencyCodeType.DJF
  Else If Value = 'DOP'	 Then Data :=  	 CurrencyCodeType.DOP
  Else If Value = 'TPE'	 Then Data :=  	 CurrencyCodeType.TPE
  Else If Value = 'ECV'	 Then Data :=  	 CurrencyCodeType.ECV
  Else If Value = 'ECS'	 Then Data :=  	 CurrencyCodeType.ECS
  Else If Value = 'EGP'	 Then Data :=  	 CurrencyCodeType.EGP
  Else If Value = 'SVC'	 Then Data :=  	 CurrencyCodeType.SVC
  Else If Value = 'ERN'	 Then Data :=  	 CurrencyCodeType.ERN
  Else If Value = 'EEK'	 Then Data :=  	 CurrencyCodeType.EEK
  Else If Value = 'ETB'	 Then Data :=  	 CurrencyCodeType.ETB
  Else If Value = 'FKP'	 Then Data :=  	 CurrencyCodeType.FKP
  Else If Value = 'FJD'	 Then Data :=  	 CurrencyCodeType.FJD
  Else If Value = 'GMD'	 Then Data :=  	 CurrencyCodeType.GMD
  Else If Value = 'GEL'	 Then Data :=  	 CurrencyCodeType.GEL
  Else If Value = 'GHC'	 Then Data :=  	 CurrencyCodeType.GHC
  Else If Value = 'GIP'	 Then Data :=  	 CurrencyCodeType.GIP
  Else If Value = 'GTQ'	 Then Data :=  	 CurrencyCodeType.GTQ
  Else If Value = 'GNF'	 Then Data :=  	 CurrencyCodeType.GNF
  Else If Value = 'GWP'	 Then Data :=  	 CurrencyCodeType.GWP
  Else If Value = 'GYD'	 Then Data :=  	 CurrencyCodeType.GYD
  Else If Value = 'HTG'	 Then Data :=  	 CurrencyCodeType.HTG
  Else If Value = 'HNL'	 Then Data :=  	 CurrencyCodeType.HNL
  Else If Value = 'HKD'	 Then Data :=  	 CurrencyCodeType.HKD
  Else If Value = 'HUF'	 Then Data :=  	 CurrencyCodeType.HUF
  Else If Value = 'ISK'	 Then Data :=  	 CurrencyCodeType.ISK
  Else If Value = 'IDR'	 Then Data :=  	 CurrencyCodeType.IDR
  Else If Value = 'IRR'	 Then Data :=  	 CurrencyCodeType.IRR
  Else If Value = 'IQD'	 Then Data :=  	 CurrencyCodeType.IQD
  Else If Value = 'ILS'	 Then Data :=  	 CurrencyCodeType.ILS
  Else If Value = 'JMD'	 Then Data :=  	 CurrencyCodeType.JMD
  Else If Value = 'JPY'	 Then Data :=  	 CurrencyCodeType.JPY
  Else If Value = 'JOD'	 Then Data :=  	 CurrencyCodeType.JOD
  Else If Value = 'KZT'	 Then Data :=  	 CurrencyCodeType.KZT
  Else If Value = 'KES'	 Then Data :=  	 CurrencyCodeType.KES
  Else If Value = 'AUD'	 Then Data :=  	 CurrencyCodeType.AUD
  Else If Value = 'KPW'	 Then Data :=  	 CurrencyCodeType.KPW
  Else If Value = 'KRW'	 Then Data :=  	 CurrencyCodeType.KRW
  Else If Value = 'KWD'	 Then Data :=  	 CurrencyCodeType.KWD
  Else If Value = 'KGS'	 Then Data :=  	 CurrencyCodeType.KGS
  Else If Value = 'LAK'	 Then Data :=  	 CurrencyCodeType.LAK
  Else If Value = 'LVL'	 Then Data :=  	 CurrencyCodeType.LVL
  Else If Value = 'LBP'	 Then Data :=  	 CurrencyCodeType.LBP
  Else If Value = 'LSL'	 Then Data :=  	 CurrencyCodeType.LSL
  Else If Value = 'LRD'	 Then Data :=  	 CurrencyCodeType.LRD
  Else If Value = 'LYD'	 Then Data :=  	 CurrencyCodeType.LYD
  Else If Value = 'CHF'	 Then Data :=  	 CurrencyCodeType.CHF
  Else If Value = 'LTL'	 Then Data :=  	 CurrencyCodeType.LTL
  Else If Value = 'MOP'	 Then Data :=  	 CurrencyCodeType.MOP
  Else If Value = 'MKD'	 Then Data :=  	 CurrencyCodeType.MKD
  Else If Value = 'MGF'	 Then Data :=  	 CurrencyCodeType.MGF
  Else If Value = 'MWK'	 Then Data :=  	 CurrencyCodeType.MWK
  Else If Value = 'MYR'	 Then Data :=  	 CurrencyCodeType.MYR
  Else If Value = 'MVR'	 Then Data :=  	 CurrencyCodeType.MVR
  Else If Value = 'MTL'	 Then Data :=  	 CurrencyCodeType.MTL
  Else If Value = 'EUR'	 Then Data :=  	 CurrencyCodeType.EUR
  Else If Value = 'MRO'	 Then Data :=  	 CurrencyCodeType.MRO
  Else If Value = 'MUR'	 Then Data :=  	 CurrencyCodeType.MUR
  Else If Value = 'MXN'	 Then Data :=  	 CurrencyCodeType.MXN
  Else If Value = 'MXV'	 Then Data :=  	 CurrencyCodeType.MXV
  Else If Value = 'MDL'	 Then Data :=  	 CurrencyCodeType.MDL
  Else If Value = 'MNT'	 Then Data :=  	 CurrencyCodeType.MNT
  Else If Value = 'XCD'	 Then Data :=  	 CurrencyCodeType.XCD
  Else If Value = 'MZM'	 Then Data :=  	 CurrencyCodeType.MZM
  Else If Value = 'MMK'	 Then Data :=  	 CurrencyCodeType.MMK
  Else If Value = 'ZAR'	 Then Data :=  	 CurrencyCodeType.ZAR
  Else If Value = 'NAD'	 Then Data :=  	 CurrencyCodeType.NAD
  Else If Value = 'NPR'	 Then Data :=  	 CurrencyCodeType.NPR
  Else If Value = 'ANG'	 Then Data :=  	 CurrencyCodeType.ANG
  Else If Value = 'XPF'	 Then Data :=  	 CurrencyCodeType.XPF
  Else If Value = 'NZD'	 Then Data :=  	 CurrencyCodeType.NZD
  Else If Value = 'NIO'	 Then Data :=  	 CurrencyCodeType.NIO
  Else If Value = 'NGN'	 Then Data :=  	 CurrencyCodeType.NGN
  Else If Value = 'NOK'	 Then Data :=  	 CurrencyCodeType.NOK
  Else If Value = 'OMR'	 Then Data :=  	 CurrencyCodeType.OMR
  Else If Value = 'PKR'	 Then Data :=  	 CurrencyCodeType.PKR
  Else If Value = 'PAB'	 Then Data :=  	 CurrencyCodeType.PAB
  Else If Value = 'PGK'	 Then Data :=  	 CurrencyCodeType.PGK
  Else If Value = 'PYG'	 Then Data :=  	 CurrencyCodeType.PYG
  Else If Value = 'PEN'	 Then Data :=  	 CurrencyCodeType.PEN
  Else If Value = 'PHP'	 Then Data :=  	 CurrencyCodeType.PHP
  Else If Value = 'PLN'	 Then Data :=  	 CurrencyCodeType.PLN
  Else If Value = 'USD'	 Then Data :=  	 CurrencyCodeType.USD
  Else If Value = 'QAR'	 Then Data :=  	 CurrencyCodeType.QAR
  Else If Value = 'ROL'	 Then Data :=  	 CurrencyCodeType.ROL
  Else If Value = 'RUB'	 Then Data :=  	 CurrencyCodeType.RUB
  Else If Value = 'RUR'	 Then Data :=  	 CurrencyCodeType.RUR
  Else If Value = 'RWF'	 Then Data :=  	 CurrencyCodeType.RWF
  Else If Value = 'SHP'	 Then Data :=  	 CurrencyCodeType.SHP
  Else If Value = 'WST'	 Then Data :=  	 CurrencyCodeType.WST
  Else If Value = 'STD'	 Then Data :=  	 CurrencyCodeType.STD
  Else If Value = 'SAR'	 Then Data :=  	 CurrencyCodeType.SAR
  Else If Value = 'SCR'	 Then Data :=  	 CurrencyCodeType.SCR
  Else If Value = 'SLL'	 Then Data :=  	 CurrencyCodeType.SLL
  Else If Value = 'SGD'	 Then Data :=  	 CurrencyCodeType.SGD
  Else If Value = 'SKK'	 Then Data :=  	 CurrencyCodeType.SKK
  Else If Value = 'SIT'	 Then Data :=  	 CurrencyCodeType.SIT
  Else If Value = 'SBD'	 Then Data :=  	 CurrencyCodeType.SBD
  Else If Value = 'SOS'	 Then Data :=  	 CurrencyCodeType.SOS
  Else If Value = 'LKR'	 Then Data :=  	 CurrencyCodeType.LKR
  Else If Value = 'SDD'	 Then Data :=  	 CurrencyCodeType.SDD
  Else If Value = 'SRG'	 Then Data :=  	 CurrencyCodeType.SRG
  Else If Value = 'SZL'	 Then Data :=  	 CurrencyCodeType.SZL
  Else If Value = 'SEK'	 Then Data :=  	 CurrencyCodeType.SEK
  Else If Value = 'SYP'	 Then Data :=  	 CurrencyCodeType.SYP
  Else If Value = 'TWD'	 Then Data :=  	 CurrencyCodeType.TWD
  Else If Value = 'TJS'	 Then Data :=  	 CurrencyCodeType.TJS
  Else If Value = 'TZS'	 Then Data :=  	 CurrencyCodeType.TZS
  Else If Value = 'THB'	 Then Data :=  	 CurrencyCodeType.THB
  Else If Value = 'XOF'	 Then Data :=  	 CurrencyCodeType.XOF
  Else If Value = 'TOP'	 Then Data :=  	 CurrencyCodeType.TOP
  Else If Value = 'TTD'	 Then Data :=  	 CurrencyCodeType.TTD
  Else If Value = 'TND'	 Then Data :=  	 CurrencyCodeType.TND
  Else If Value = 'TRL'	 Then Data :=  	 CurrencyCodeType.TRL
  Else If Value = 'TMM'	 Then Data :=  	 CurrencyCodeType.TMM
  Else If Value = 'UGX'	 Then Data :=  	 CurrencyCodeType.UGX
  Else If Value = 'UAH'	 Then Data :=  	 CurrencyCodeType.UAH
  Else If Value = 'AED'	 Then Data :=  	 CurrencyCodeType.AED
  Else If Value = 'GBP'	 Then Data :=  	 CurrencyCodeType.GBP
  Else If Value = 'USS'	 Then Data :=  	 CurrencyCodeType.USS
  Else If Value = 'USN'	 Then Data :=  	 CurrencyCodeType.USN
  Else If Value = 'UYU'	 Then Data :=  	 CurrencyCodeType.UYU
  Else If Value = 'UZS'	 Then Data :=  	 CurrencyCodeType.UZS
  Else If Value = 'VUV'	 Then Data :=  	 CurrencyCodeType.VUV
  Else If Value = 'VEB'	 Then Data :=  	 CurrencyCodeType.VEB
  Else If Value = 'VND'	 Then Data :=  	 CurrencyCodeType.VND
  Else If Value = 'MAD'	 Then Data :=  	 CurrencyCodeType.MAD
  Else If Value = 'YER'	 Then Data :=  	 CurrencyCodeType.YER
  Else If Value = 'YUM'	 Then Data :=  	 CurrencyCodeType.YUM
  Else If Value = 'ZMK'	 Then Data :=  	 CurrencyCodeType.ZMK
  Else If Value = 'ZWD'	 Then Data :=  	 CurrencyCodeType.ZWD
  Else If Value = 'ATS'	 Then Data :=  	 CurrencyCodeType.ATS
  Else If Value = 'CustomCode'	 Then Data :=  	 CurrencyCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AccountHistorySelectionCodeType);
Begin
       If Value ='LastInvoice'	 Then Data :=  	 AccountHistorySelectionCodeType.LastInvoice
  Else If Value = 'SpecifiedInvoice'	 Then Data :=  	 AccountHistorySelectionCodeType.SpecifiedInvoice
  Else If Value = 'BetweenSpecifiedDates'	 Then Data :=  	 AccountHistorySelectionCodeType.BetweenSpecifiedDates
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AccountEntrySortTypeCodeType);
Begin
       If Value ='None'	 Then Data :=  	 AccountEntrySortTypeCodeType.None
  Else If Value = 'AccountEntryCreatedTimeAscending'	 Then Data :=  	 AccountEntrySortTypeCodeType.AccountEntryCreatedTimeAscending
  Else If Value = 'AccountEntryCreatedTimeDescending'	 Then Data :=  	 AccountEntrySortTypeCodeType.AccountEntryCreatedTimeDescending
  Else If Value = 'AccountEntryItemNumberAscending'	 Then Data :=  	 AccountEntrySortTypeCodeType.AccountEntryItemNumberAscending
  Else If Value = 'AccountEntryItemNumberDescending'	 Then Data :=  	 AccountEntrySortTypeCodeType.AccountEntryItemNumberDescending
  Else If Value = 'AccountEntryFeeTypeAscending'	 Then Data :=  	 AccountEntrySortTypeCodeType.AccountEntryFeeTypeAscending
  Else If Value = 'AccountEntryFeeTypeDescending'	 Then Data :=  	 AccountEntrySortTypeCodeType.AccountEntryFeeTypeDescending
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MessageStatusTypeCodeType);
Begin
       If Value ='Answered'	 Then Data :=  	 MessageStatusTypeCodeType.Answered
  Else If Value = 'Unanswered'	 Then Data :=  	 MessageStatusTypeCodeType.Unanswered
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeatureIDCodeType);
Begin
       If Value ='ListingDurations'	 Then Data :=  	 FeatureIDCodeType.ListingDurations
  Else If Value = 'BestOfferEnabled'	 Then Data :=  	 FeatureIDCodeType.BestOfferEnabled
  Else If Value = 'DutchBINEnabled'	 Then Data :=  	 FeatureIDCodeType.DutchBINEnabled
  Else If Value = 'ShippingTermsRequired'	 Then Data :=  	 FeatureIDCodeType.ShippingTermsRequired
  Else If Value = 'UserConsentRequired'	 Then Data :=  	 FeatureIDCodeType.UserConsentRequired
  Else If Value = 'HomePageFeaturedEnabled'	 Then Data :=  	 FeatureIDCodeType.HomePageFeaturedEnabled
  Else If Value = 'AdFormatEnabled'	 Then Data :=  	 FeatureIDCodeType.AdFormatEnabled
  Else If Value = 'DigitalDeliveryEnabled'	 Then Data :=  	 FeatureIDCodeType.DigitalDeliveryEnabled
  Else If Value = 'BestOfferCounterEnabled'	 Then Data :=  	 FeatureIDCodeType.BestOfferCounterEnabled
  Else If Value = 'BestOfferAutoDeclineEnabled'	 Then Data :=  	 FeatureIDCodeType.BestOfferAutoDeclineEnabled
  Else If Value = 'ProPack'	 Then Data :=  	 FeatureIDCodeType.ProPack
  Else If Value = 'BasicUpgradePack'	 Then Data :=  	 FeatureIDCodeType.BasicUpgradePack
  Else If Value = 'ValuePack'	 Then Data :=  	 FeatureIDCodeType.ValuePack
  Else If Value = 'ProPackPlus'	 Then Data :=  	 FeatureIDCodeType.ProPackPlus
  Else If Value = 'LocalMarketSpecialitySubscription'	 Then Data :=  	 FeatureIDCodeType.LocalMarketSpecialitySubscription
  Else If Value = 'LocalMarketRegularSubscription'	 Then Data :=  	 FeatureIDCodeType.LocalMarketRegularSubscription
  Else If Value = 'LocalMarketPremiumSubscription'	 Then Data :=  	 FeatureIDCodeType.LocalMarketPremiumSubscription
  Else If Value = 'LocalMarketNonSubscription'	 Then Data :=  	 FeatureIDCodeType.LocalMarketNonSubscription
  Else If Value = 'ExpressEnabled'	 Then Data :=  	 FeatureIDCodeType.ExpressEnabled
  Else If Value = 'ExpressPicturesRequired'	 Then Data :=  	 FeatureIDCodeType.ExpressPicturesRequired
  Else If Value = 'ExpressConditionRequired'	 Then Data :=  	 FeatureIDCodeType.ExpressConditionRequired
  Else If Value = 'SellerContactDetailsEnabled'	 Then Data :=  	 FeatureIDCodeType.SellerContactDetailsEnabled
  Else If Value = 'CustomCode'	 Then Data :=  	 FeatureIDCodeType.CustomCode
  Else If Value = 'MinimumReservePrice'	 Then Data :=  	 FeatureIDCodeType.MinimumReservePrice
  Else If Value = 'TransactionConfirmationRequestEnabled'	 Then Data :=  	 FeatureIDCodeType.TransactionConfirmationRequestEnabled
  Else If Value = 'StoreInventoryEnabled'	 Then Data :=  	 FeatureIDCodeType.StoreInventoryEnabled
  Else If Value = 'LocalListingDistances'	 Then Data :=  	 FeatureIDCodeType.LocalListingDistances
  Else If Value = 'SkypeMeTransactionalEnabled'	 Then Data :=  	 FeatureIDCodeType.SkypeMeTransactionalEnabled
  Else If Value = 'SkypeMeNonTransactionalEnabled'	 Then Data :=  	 FeatureIDCodeType.SkypeMeNonTransactionalEnabled
  Else If Value = 'ClassifiedAdPaymentMethodEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdPaymentMethodEnabled
  Else If Value = 'ClassifiedAdShippingMethodEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdShippingMethodEnabled
  Else If Value = 'ClassifiedAdBestOfferEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdBestOfferEnabled
  Else If Value = 'ClassifiedAdCounterOfferEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdCounterOfferEnabled
  Else If Value = 'ClassifiedAdAutoDeclineEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdAutoDeclineEnabled
  Else If Value = 'ClassifiedAdContactByEmailEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdContactByEmailEnabled
  Else If Value = 'ClassifiedAdContactByPhoneEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdContactByPhoneEnabled
  Else If Value = 'SafePaymentRequired'	 Then Data :=  	 FeatureIDCodeType.SafePaymentRequired
  Else If Value = 'MaximumBestOffersAllowed'	 Then Data :=  	 FeatureIDCodeType.MaximumBestOffersAllowed
  Else If Value = 'ClassifiedAdMaximumBestOffersAllowed'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdMaximumBestOffersAllowed
  Else If Value = 'ClassifiedAdContactByEmailAvailable'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdContactByEmailAvailable
  Else If Value = 'ClassifiedAdPayPerLeadEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdPayPerLeadEnabled
  Else If Value = 'ItemSpecificsEnabled'	 Then Data :=  	 FeatureIDCodeType.ItemSpecificsEnabled
  Else If Value = 'PaisaPayFullEscrowEnabled'	 Then Data :=  	 FeatureIDCodeType.PaisaPayFullEscrowEnabled
  Else If Value = 'ISBNIdentifierEnabled'	 Then Data :=  	 FeatureIDCodeType.ISBNIdentifierEnabled
  Else If Value = 'UPCIdentifierEnabled'	 Then Data :=  	 FeatureIDCodeType.UPCIdentifierEnabled
  Else If Value = 'EANIdentifierEnabled'	 Then Data :=  	 FeatureIDCodeType.EANIdentifierEnabled
  Else If Value = 'BrandMPNIdentifierEnabled'	 Then Data :=  	 FeatureIDCodeType.BrandMPNIdentifierEnabled
  Else If Value = 'ClassifiedAdAutoAcceptEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdAutoAcceptEnabled
  Else If Value = 'BestOfferAutoAcceptEnabled'	 Then Data :=  	 FeatureIDCodeType.BestOfferAutoAcceptEnabled
  Else If Value = 'CrossBorderTradeEnabled'	 Then Data :=  	 FeatureIDCodeType.CrossBorderTradeEnabled
  Else If Value = 'PayPalBuyerProtectionEnabled'	 Then Data :=  	 FeatureIDCodeType.PayPalBuyerProtectionEnabled
  Else If Value = 'BuyerGuaranteeEnabled'	 Then Data :=  	 FeatureIDCodeType.BuyerGuaranteeEnabled
  Else If Value = 'INEscrowWorkflowTimeline'	 Then Data :=  	 FeatureIDCodeType.INEscrowWorkflowTimeline
  Else If Value = 'CombinedFixedPriceTreatment'	 Then Data :=  	 FeatureIDCodeType.CombinedFixedPriceTreatment
  Else If Value = 'GalleryFeaturedDurations'	 Then Data :=  	 FeatureIDCodeType.GalleryFeaturedDurations
  Else If Value = 'PayPalRequired'	 Then Data :=  	 FeatureIDCodeType.PayPalRequired
  Else If Value = 'eBayMotorsProAdFormatEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProAdFormatEnabled
  Else If Value = 'eBayMotorsProContactByPhoneEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProContactByPhoneEnabled
  Else If Value = 'eBayMotorsProContactByAddressEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProContactByAddressEnabled
  Else If Value = 'eBayMotorsProCompanyNameEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProCompanyNameEnabled
  Else If Value = 'eBayMotorsProContactByEmailEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProContactByEmailEnabled
  Else If Value = 'eBayMotorsProBestOfferEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProBestOfferEnabled
  Else If Value = 'eBayMotorsProAutoAcceptEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProAutoAcceptEnabled
  Else If Value = 'eBayMotorsProAutoDeclineEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProAutoDeclineEnabled
  Else If Value = 'eBayMotorsProPaymentMethodCheckOutEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProPaymentMethodCheckOutEnabled
  Else If Value = 'eBayMotorsProShippingMethodEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProShippingMethodEnabled
  Else If Value = 'eBayMotorsProCounterOfferEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProCounterOfferEnabled
  Else If Value = 'eBayMotorsProSellerContactDetailsEnabled'	 Then Data :=  	 FeatureIDCodeType.EBayMotorsProSellerContactDetailsEnabled
  Else If Value = 'LocalMarketAdFormatEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketAdFormatEnabled
  Else If Value = 'LocalMarketContactByPhoneEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketContactByPhoneEnabled
  Else If Value = 'LocalMarketContactByAddressEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketContactByAddressEnabled
  Else If Value = 'LocalMarketCompanyNameEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketCompanyNameEnabled
  Else If Value = 'LocalMarketContactByEmailEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketContactByEmailEnabled
  Else If Value = 'LocalMarketBestOfferEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketBestOfferEnabled
  Else If Value = 'LocalMarketAutoAcceptEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketAutoAcceptEnabled
  Else If Value = 'LocalMarketAutoDeclineEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketAutoDeclineEnabled
  Else If Value = 'LocalMarketPaymentMethodCheckOutEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketPaymentMethodCheckOutEnabled
  Else If Value = 'LocalMarketShippingMethodEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketShippingMethodEnabled
  Else If Value = 'LocalMarketCounterOfferEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketCounterOfferEnabled
  Else If Value = 'LocalMarketSellerContactDetailsEnabled'	 Then Data :=  	 FeatureIDCodeType.LocalMarketSellerContactDetailsEnabled
  Else If Value = 'ClassifiedAdContactByAddressEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdContactByAddressEnabled
  Else If Value = 'ClassifiedAdCompanyNameEnabled'	 Then Data :=  	 FeatureIDCodeType.ClassifiedAdCompanyNameEnabled
  Else If Value = 'SpecialitySubscription'	 Then Data :=  	 FeatureIDCodeType.SpecialitySubscription
  Else If Value = 'RegularSubscription'	 Then Data :=  	 FeatureIDCodeType.RegularSubscription
  Else If Value = 'PremiumSubscription'	 Then Data :=  	 FeatureIDCodeType.PremiumSubscription
  Else If Value = 'NonSubscription'	 Then Data :=  	 FeatureIDCodeType.NonSubscription
  Else If Value = 'IntangibleEnabled'	 Then Data :=  	 FeatureIDCodeType.IntangibleEnabled
  Else If Value = 'PayPalRequiredForStoreOwner'	 Then Data :=  	 FeatureIDCodeType.PayPalRequiredForStoreOwner
  Else If Value = 'ReviseQuantityAllowed'	 Then Data :=  	 FeatureIDCodeType.ReviseQuantityAllowed
  Else If Value = 'RevisePriceAllowed'	 Then Data :=  	 FeatureIDCodeType.RevisePriceAllowed
  Else If Value = 'StoreOwnerExtendedListingDurationsEnabled'	 Then Data :=  	 FeatureIDCodeType.StoreOwnerExtendedListingDurationsEnabled
  Else If Value = 'StoreOwnerExtendedListingDurations'	 Then Data :=  	 FeatureIDCodeType.StoreOwnerExtendedListingDurations
  Else If Value = 'ReturnPolicyEnabled'	 Then Data :=  	 FeatureIDCodeType.ReturnPolicyEnabled
  Else If Value = 'HandlingTimeEnabled'	 Then Data :=  	 FeatureIDCodeType.HandlingTimeEnabled
  Else If Value = 'PaymentMethods'	 Then Data :=  	 FeatureIDCodeType.PaymentMethods
  Else If Value = 'MaxFlatShippingCost'	 Then Data :=  	 FeatureIDCodeType.MaxFlatShippingCost
  Else If Value = 'MaxFlatShippingCostCBTExempt'	 Then Data :=  	 FeatureIDCodeType.MaxFlatShippingCostCBTExempt
  Else If Value = 'Group1MaxFlatShippingCost'	 Then Data :=  	 FeatureIDCodeType.Group1MaxFlatShippingCost
  Else If Value = 'Group2MaxFlatShippingCost'	 Then Data :=  	 FeatureIDCodeType.Group2MaxFlatShippingCost
  Else If Value = 'Group3MaxFlatShippingCost'	 Then Data :=  	 FeatureIDCodeType.Group3MaxFlatShippingCost
  Else If Value = 'VariationsEnabled'	 Then Data :=  	 FeatureIDCodeType.VariationsEnabled
  Else If Value = 'AttributeConversionEnabled'	 Then Data :=  	 FeatureIDCodeType.AttributeConversionEnabled
  Else If Value = 'FreeGalleryPlusEnabled'	 Then Data :=  	 FeatureIDCodeType.FreeGalleryPlusEnabled
  Else If Value = 'FreePicturePackEnabled'	 Then Data :=  	 FeatureIDCodeType.FreePicturePackEnabled
  Else If Value = 'CompatibilityEnabled'	 Then Data :=  	 FeatureIDCodeType.CompatibilityEnabled
  Else If Value = 'MinCompatibleApplications'	 Then Data :=  	 FeatureIDCodeType.MinCompatibleApplications
  Else If Value = 'MaxCompatibleApplications'	 Then Data :=  	 FeatureIDCodeType.MaxCompatibleApplications
  Else If Value = 'ConditionEnabled'	 Then Data :=  	 FeatureIDCodeType.ConditionEnabled
  Else If Value = 'ConditionValues'	 Then Data :=  	 FeatureIDCodeType.ConditionValues
  Else If Value = 'ValueCategory'	 Then Data :=  	 FeatureIDCodeType.ValueCategory
  Else If Value = 'ProductCreationEnabled'	 Then Data :=  	 FeatureIDCodeType.ProductCreationEnabled
  Else If Value = 'MaxGranularFitmentCount'	 Then Data :=  	 FeatureIDCodeType.MaxGranularFitmentCount
  Else If Value = 'CompatibleVehicleType'	 Then Data :=  	 FeatureIDCodeType.CompatibleVehicleType
  Else If Value = 'PaymentOptionsGroup'	 Then Data :=  	 FeatureIDCodeType.PaymentOptionsGroup
  Else If Value = 'ShippingProfileCategoryGroup'	 Then Data :=  	 FeatureIDCodeType.ShippingProfileCategoryGroup
  Else If Value = 'PaymentProfileCategoryGroup'	 Then Data :=  	 FeatureIDCodeType.PaymentProfileCategoryGroup
  Else If Value = 'ReturnPolicyProfileCategoryGroup'	 Then Data :=  	 FeatureIDCodeType.ReturnPolicyProfileCategoryGroup
  Else If Value = 'VINSupported'	 Then Data :=  	 FeatureIDCodeType.VINSupported
  Else If Value = 'VRMSupported'	 Then Data :=  	 FeatureIDCodeType.VRMSupported
  Else If Value = 'SellerProvidedTitleSupported'	 Then Data :=  	 FeatureIDCodeType.SellerProvidedTitleSupported
  Else If Value = 'DepositSupported'	 Then Data :=  	 FeatureIDCodeType.DepositSupported
  Else If Value = 'GlobalShippingEnabled'	 Then Data :=  	 FeatureIDCodeType.GlobalShippingEnabled
  Else If Value = 'AdditionalCompatibilityEnabled'	 Then Data :=  	 FeatureIDCodeType.AdditionalCompatibilityEnabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : GranularityLevelCodeType);
Begin
       If Value ='Coarse'	 Then Data :=  	 GranularityLevelCodeType.Coarse
  Else If Value = 'Fine'	 Then Data :=  	 GranularityLevelCodeType.Fine
  Else If Value = 'Medium'	 Then Data :=  	 GranularityLevelCodeType.Medium
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BestOfferStatusCodeType);
Begin
       If Value ='Pending'	 Then Data :=  	 BestOfferStatusCodeType.Pending
  Else If Value = 'Accepted'	 Then Data :=  	 BestOfferStatusCodeType.Accepted
  Else If Value = 'Declined'	 Then Data :=  	 BestOfferStatusCodeType.Declined
  Else If Value = 'Expired'	 Then Data :=  	 BestOfferStatusCodeType.Expired
  Else If Value = 'Retracted'	 Then Data :=  	 BestOfferStatusCodeType.Retracted
  Else If Value = 'AdminEnded'	 Then Data :=  	 BestOfferStatusCodeType.AdminEnded
  Else If Value = 'Active'	 Then Data :=  	 BestOfferStatusCodeType.Active
  Else If Value = 'Countered'	 Then Data :=  	 BestOfferStatusCodeType.Countered
  Else If Value = 'All'	 Then Data :=  	 BestOfferStatusCodeType.All
  Else If Value = 'PendingBuyerPayment'	 Then Data :=  	 BestOfferStatusCodeType.PendingBuyerPayment
  Else If Value = 'PendingBuyerConfirmation'	 Then Data :=  	 BestOfferStatusCodeType.PendingBuyerConfirmation
  Else If Value = 'CustomCode'	 Then Data :=  	 BestOfferStatusCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ProductCreationEnabledCodeType);
Begin
       If Value ='Disabled'	 Then Data :=  	 ProductCreationEnabledCodeType.Disabled
  Else If Value = 'Enabled'	 Then Data :=  	 ProductCreationEnabledCodeType.Enabled
  Else If Value = 'Required'	 Then Data :=  	 ProductCreationEnabledCodeType.Required
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PaymentOptionsGroupEnabledCodeType);
Begin
       If Value ='eBayPaymentProcessEnabled'	 Then Data :=  	 PaymentOptionsGroupEnabledCodeType.EBayPaymentProcessEnabled
  Else If Value = 'NonStandardPaymentsEnabled'	 Then Data :=  	 PaymentOptionsGroupEnabledCodeType.NonStandardPaymentsEnabled
  Else If Value = 'eBayPaymentProcessExcluded'	 Then Data :=  	 PaymentOptionsGroupEnabledCodeType.EBayPaymentProcessExcluded
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ProfileCategoryGroupCodeType);
Begin
       If Value ='Inherit'	 Then Data :=  	 ProfileCategoryGroupCodeType.Inherit
  Else If Value = 'None'	 Then Data :=  	 ProfileCategoryGroupCodeType.None
  Else If Value = 'ALL'	 Then Data :=  	 ProfileCategoryGroupCodeType.ALL
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CharityAffiliationTypeCodeType);
Begin
       If Value ='Community'	 Then Data :=  	 CharityAffiliationTypeCodeType.Community
  Else If Value = 'Direct'	 Then Data :=  	 CharityAffiliationTypeCodeType.Direct
  Else If Value = 'Remove'	 Then Data :=  	 CharityAffiliationTypeCodeType.Remove
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ClassifiedAdBestOfferEnabledCodeType);
Begin
       If Value ='Disabled'	 Then Data :=  	 ClassifiedAdBestOfferEnabledCodeType.Disabled
  Else If Value = 'Enabled'	 Then Data :=  	 ClassifiedAdBestOfferEnabledCodeType.Enabled
  Else If Value = 'Required'	 Then Data :=  	 ClassifiedAdBestOfferEnabledCodeType.Required
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemSpecificsEnabledCodeType);
Begin
       If Value ='Disabled'	 Then Data :=  	 ItemSpecificsEnabledCodeType.Disabled
  Else If Value = 'Enabled'	 Then Data :=  	 ItemSpecificsEnabledCodeType.Enabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AdFormatEnabledCodeType);
Begin
       If Value ='Disabled'	 Then Data :=  	 AdFormatEnabledCodeType.Disabled
  Else If Value = 'Enabled'	 Then Data :=  	 AdFormatEnabledCodeType.Enabled
  Else If Value = 'Only'	 Then Data :=  	 AdFormatEnabledCodeType.Only
  Else If Value = 'ClassifiedAdEnabled'	 Then Data :=  	 AdFormatEnabledCodeType.ClassifiedAdEnabled
  Else If Value = 'ClassifiedAdOnly'	 Then Data :=  	 AdFormatEnabledCodeType.ClassifiedAdOnly
  Else If Value = 'LocalMarketBestOfferOnly'	 Then Data :=  	 AdFormatEnabledCodeType.LocalMarketBestOfferOnly
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ClassifiedAdPaymentMethodEnabledCodeType);
Begin
       If Value ='EnabledWithCheckout'	 Then Data :=  	 ClassifiedAdPaymentMethodEnabledCodeType.EnabledWithCheckout
  Else If Value = 'EnabledWithoutCheckout'	 Then Data :=  	 ClassifiedAdPaymentMethodEnabledCodeType.EnabledWithoutCheckout
  Else If Value = 'NotSupported'	 Then Data :=  	 ClassifiedAdPaymentMethodEnabledCodeType.NotSupported
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : GeographicExposureCodeType);
Begin
       If Value ='National'	 Then Data :=  	 GeographicExposureCodeType.National
  Else If Value = 'LocalOnly'	 Then Data :=  	 GeographicExposureCodeType.LocalOnly
  Else If Value = 'LocalOptional'	 Then Data :=  	 GeographicExposureCodeType.LocalOptional
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemCompatibilityEnabledCodeType);
Begin
       If Value ='Disabled'	 Then Data :=  	 ItemCompatibilityEnabledCodeType.Disabled
  Else If Value = 'ByApplication'	 Then Data :=  	 ItemCompatibilityEnabledCodeType.ByApplication
  Else If Value = 'BySpecification'	 Then Data :=  	 ItemCompatibilityEnabledCodeType.BySpecification
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ConditionEnabledCodeType);
Begin
       If Value ='Disabled'	 Then Data :=  	 ConditionEnabledCodeType.Disabled
  Else If Value = 'Enabled'	 Then Data :=  	 ConditionEnabledCodeType.Enabled
  Else If Value = 'Required'	 Then Data :=  	 ConditionEnabledCodeType.Required
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : INEscrowWorkflowTimelineCodeType);
Begin
       If Value ='Default_'	 Then Data :=  	 INEscrowWorkflowTimelineCodeType.Default_
  Else If Value = 'WorkflowA'	 Then Data :=  	 INEscrowWorkflowTimelineCodeType.WorkflowA
  Else If Value = 'WorkflowB'	 Then Data :=  	 INEscrowWorkflowTimelineCodeType.WorkflowB
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AttributeConversionEnabledCodeType);
Begin
       If Value ='NotApplicable'	 Then Data :=  	 AttributeConversionEnabledCodeType.NotApplicable
  Else If Value = 'Enabled'	 Then Data :=  	 AttributeConversionEnabledCodeType.Enabled
  Else If Value = 'Disabled'	 Then Data :=  	 AttributeConversionEnabledCodeType.Disabled
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CombinedPaymentOptionCodeType);
Begin
       If Value ='NoCombinedPayment'	 Then Data :=  	 CombinedPaymentOptionCodeType.NoCombinedPayment
  Else If Value = 'DiscountSpecified'	 Then Data :=  	 CombinedPaymentOptionCodeType.DiscountSpecified
  Else If Value = 'SpecifyDiscountLater'	 Then Data :=  	 CombinedPaymentOptionCodeType.SpecifyDiscountLater
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SocialAddressTypeCodeType);
Begin
       If Value ='Facebook'	 Then Data :=  	 SocialAddressTypeCodeType.Facebook
  Else If Value = 'Twitter'	 Then Data :=  	 SocialAddressTypeCodeType.Twitter
  Else If Value = 'Linkedin'	 Then Data :=  	 SocialAddressTypeCodeType.Linkedin
  Else If Value = 'GooglePlus'	 Then Data :=  	 SocialAddressTypeCodeType.GooglePlus
  Else If Value = 'Myspace'	 Then Data :=  	 SocialAddressTypeCodeType.Myspace
  Else If Value = 'Orkut'	 Then Data :=  	 SocialAddressTypeCodeType.Orkut
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CharityStatusCodeType);
Begin
       If Value ='Valid'	 Then Data :=  	 CharityStatusCodeType.Valid
  Else If Value = 'NoLongerValid'	 Then Data :=  	 CharityStatusCodeType.NoLongerValid
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PaymentStatusCodeType);
Begin
       If Value ='NoPaymentFailure'	 Then Data :=  	 PaymentStatusCodeType.NoPaymentFailure
  Else If Value = 'BuyerECheckBounced'	 Then Data :=  	 PaymentStatusCodeType.BuyerECheckBounced
  Else If Value = 'BuyerCreditCardFailed'	 Then Data :=  	 PaymentStatusCodeType.BuyerCreditCardFailed
  Else If Value = 'BuyerFailedPaymentReportedBySeller'	 Then Data :=  	 PaymentStatusCodeType.BuyerFailedPaymentReportedBySeller
  Else If Value = 'PayPalPaymentInProcess'	 Then Data :=  	 PaymentStatusCodeType.PayPalPaymentInProcess
  Else If Value = 'PaymentInProcess'	 Then Data :=  	 PaymentStatusCodeType.PaymentInProcess
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BestOfferTypeCodeType);
Begin
       If Value ='BuyerBestOffer'	 Then Data :=  	 BestOfferTypeCodeType.BuyerBestOffer
  Else If Value = 'BuyerCounterOffer'	 Then Data :=  	 BestOfferTypeCodeType.BuyerCounterOffer
  Else If Value = 'SellerCounterOffer'	 Then Data :=  	 BestOfferTypeCodeType.SellerCounterOffer
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BidGroupItemStatusCodeType);
Begin
       If Value ='CurrentBid'	 Then Data :=  	 BidGroupItemStatusCodeType.CurrentBid
  Else If Value = 'Cancelled'	 Then Data :=  	 BidGroupItemStatusCodeType.Cancelled
  Else If Value = 'Pending'	 Then Data :=  	 BidGroupItemStatusCodeType.Pending
  Else If Value = 'Skipped'	 Then Data :=  	 BidGroupItemStatusCodeType.Skipped
  Else If Value = 'Ended'	 Then Data :=  	 BidGroupItemStatusCodeType.Ended
  Else If Value = 'Won'	 Then Data :=  	 BidGroupItemStatusCodeType.Won
  Else If Value = 'GroupClosed'	 Then Data :=  	 BidGroupItemStatusCodeType.GroupClosed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BidGroupStatusCodeType);
Begin
       If Value ='Open'	 Then Data :=  	 BidGroupStatusCodeType.Open
  Else If Value = 'Closed'	 Then Data :=  	 BidGroupStatusCodeType.Closed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeedbackRatingDetailCodeType);
Begin
       If Value ='ItemAsDescribed'	 Then Data :=  	 FeedbackRatingDetailCodeType.ItemAsDescribed
  Else If Value = 'Communication'	 Then Data :=  	 FeedbackRatingDetailCodeType.Communication
  Else If Value = 'ShippingTime'	 Then Data :=  	 FeedbackRatingDetailCodeType.ShippingTime
  Else If Value = 'ShippingAndHandlingCharges'	 Then Data :=  	 FeedbackRatingDetailCodeType.ShippingAndHandlingCharges
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeedbackSummaryPeriodCodeType);
Begin
       If Value ='ThirtyDays'	 Then Data :=  	 FeedbackSummaryPeriodCodeType.ThirtyDays
  Else If Value = 'FiftyTwoWeeks'	 Then Data :=  	 FeedbackSummaryPeriodCodeType.FiftyTwoWeeks
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : HandlingNameCodeType);
Begin
       If Value ='EachAdditionalAmount'	 Then Data :=  	 HandlingNameCodeType.EachAdditionalAmount
  Else If Value = 'EachAdditionalAmountOff'	 Then Data :=  	 HandlingNameCodeType.EachAdditionalAmountOff
  Else If Value = 'EachAdditionalPercentOff'	 Then Data :=  	 HandlingNameCodeType.EachAdditionalPercentOff
  Else If Value = 'IndividualHandlingFee'	 Then Data :=  	 HandlingNameCodeType.IndividualHandlingFee
  Else If Value = 'CombinedHandlingFee'	 Then Data :=  	 HandlingNameCodeType.CombinedHandlingFee
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DiscountNameCodeType);
Begin
       If Value ='EachAdditionalAmount'	 Then Data :=  	 DiscountNameCodeType.EachAdditionalAmount
  Else If Value = 'EachAdditionalAmountOff'	 Then Data :=  	 DiscountNameCodeType.EachAdditionalAmountOff
  Else If Value = 'EachAdditionalPercentOff'	 Then Data :=  	 DiscountNameCodeType.EachAdditionalPercentOff
  Else If Value = 'IndividualItemWeight'	 Then Data :=  	 DiscountNameCodeType.IndividualItemWeight
  Else If Value = 'CombinedItemWeight'	 Then Data :=  	 DiscountNameCodeType.CombinedItemWeight
  Else If Value = 'WeightOff'	 Then Data :=  	 DiscountNameCodeType.WeightOff
  Else If Value = 'ShippingCostXForAmountY'	 Then Data :=  	 DiscountNameCodeType.ShippingCostXForAmountY
  Else If Value = 'ShippingCostXForItemCountN'	 Then Data :=  	 DiscountNameCodeType.ShippingCostXForItemCountN
  Else If Value = 'MaximumShippingCostPerOrder'	 Then Data :=  	 DiscountNameCodeType.MaximumShippingCostPerOrder
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BuyerSatisfactionStatusCodeType);
Begin
       If Value ='Excellent'	 Then Data :=  	 BuyerSatisfactionStatusCodeType.Excellent
  Else If Value = 'Good'	 Then Data :=  	 BuyerSatisfactionStatusCodeType.Good
  Else If Value = 'NeedsWork'	 Then Data :=  	 BuyerSatisfactionStatusCodeType.NeedsWork
  Else If Value = 'Poor'	 Then Data :=  	 BuyerSatisfactionStatusCodeType.Poor
  Else If Value = 'VeryPoor'	 Then Data :=  	 BuyerSatisfactionStatusCodeType.VeryPoor
  Else If Value = 'Unacceptable'	 Then Data :=  	 BuyerSatisfactionStatusCodeType.Unacceptable
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ShippingPackageCodeType);
Begin
       If Value ='None'	 Then Data :=  	 ShippingPackageCodeType.None
  Else If Value = 'Letter'	 Then Data :=  	 ShippingPackageCodeType.Letter
  Else If Value = 'LargeEnvelope'	 Then Data :=  	 ShippingPackageCodeType.LargeEnvelope
  Else If Value = 'USPSLargePack'	 Then Data :=  	 ShippingPackageCodeType.USPSLargePack
  Else If Value = 'VeryLargePack'	 Then Data :=  	 ShippingPackageCodeType.VeryLargePack
  Else If Value = 'ExtraLargePack'	 Then Data :=  	 ShippingPackageCodeType.ExtraLargePack
  Else If Value = 'UPSLetter'	 Then Data :=  	 ShippingPackageCodeType.UPSLetter
  Else If Value = 'USPSFlatRateEnvelope'	 Then Data :=  	 ShippingPackageCodeType.USPSFlatRateEnvelope
  Else If Value = 'PackageThickEnvelope'	 Then Data :=  	 ShippingPackageCodeType.PackageThickEnvelope
  Else If Value = 'Roll'	 Then Data :=  	 ShippingPackageCodeType.Roll
  Else If Value = 'Europallet'	 Then Data :=  	 ShippingPackageCodeType.Europallet
  Else If Value = 'OneWayPallet'	 Then Data :=  	 ShippingPackageCodeType.OneWayPallet
  Else If Value = 'BulkyGoods'	 Then Data :=  	 ShippingPackageCodeType.BulkyGoods
  Else If Value = 'Furniture'	 Then Data :=  	 ShippingPackageCodeType.Furniture
  Else If Value = 'Cars'	 Then Data :=  	 ShippingPackageCodeType.Cars
  Else If Value = 'Motorbikes'	 Then Data :=  	 ShippingPackageCodeType.Motorbikes
  Else If Value = 'Caravan'	 Then Data :=  	 ShippingPackageCodeType.Caravan
  Else If Value = 'IndustryVehicles'	 Then Data :=  	 ShippingPackageCodeType.IndustryVehicles
  Else If Value = 'ParcelOrPaddedEnvelope'	 Then Data :=  	 ShippingPackageCodeType.ParcelOrPaddedEnvelope
  Else If Value = 'SmallCanadaPostBox'	 Then Data :=  	 ShippingPackageCodeType.SmallCanadaPostBox
  Else If Value = 'MediumCanadaPostBox'	 Then Data :=  	 ShippingPackageCodeType.MediumCanadaPostBox
  Else If Value = 'LargeCanadaPostBox'	 Then Data :=  	 ShippingPackageCodeType.LargeCanadaPostBox
  Else If Value = 'SmallCanadaPostBubbleMailer'	 Then Data :=  	 ShippingPackageCodeType.SmallCanadaPostBubbleMailer
  Else If Value = 'MediumCanadaPostBubbleMailer'	 Then Data :=  	 ShippingPackageCodeType.MediumCanadaPostBubbleMailer
  Else If Value = 'LargeCanadaPostBubbleMailer'	 Then Data :=  	 ShippingPackageCodeType.LargeCanadaPostBubbleMailer
  Else If Value = 'PaddedBags'	 Then Data :=  	 ShippingPackageCodeType.PaddedBags
  Else If Value = 'ToughBags'	 Then Data :=  	 ShippingPackageCodeType.ToughBags
  Else If Value = 'ExpandableToughBags'	 Then Data :=  	 ShippingPackageCodeType.ExpandableToughBags
  Else If Value = 'MailingBoxes'	 Then Data :=  	 ShippingPackageCodeType.MailingBoxes
  Else If Value = 'Winepak'	 Then Data :=  	 ShippingPackageCodeType.Winepak
  Else If Value = 'CustomCode'	 Then Data :=  	 ShippingPackageCodeType.CustomCode
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : ProductStateCodeType);
Begin
       If Value ='Update'	 Then Data :=  	 ProductStateCodeType.Update
  Else If Value = 'UpdateMajor'	 Then Data :=  	 ProductStateCodeType.UpdateMajor
  Else If Value = 'UpdateNoDetails'	 Then Data :=  	 ProductStateCodeType.UpdateNoDetails
  Else If Value = 'Merge'	 Then Data :=  	 ProductStateCodeType.Merge
  Else If Value = 'Delete'	 Then Data :=  	 ProductStateCodeType.Delete
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : CalculatedShippingChargeOptionCodeType);
Begin
       If Value ='ChargeEachItem'	 Then Data :=  	 CalculatedShippingChargeOptionCodeType.ChargeEachItem
  Else If Value = 'ChargeEntireOrder'	 Then Data :=  	 CalculatedShippingChargeOptionCodeType.ChargeEntireOrder
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CalculatedShippingRateOptionCodeType);
Begin
       If Value ='CombinedItemWeight'	 Then Data :=  	 CalculatedShippingRateOptionCodeType.CombinedItemWeight
  Else If Value = 'IndividualItemWeight'	 Then Data :=  	 CalculatedShippingRateOptionCodeType.IndividualItemWeight
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BuyerProtectionSourceCodeType);
Begin
       If Value ='eBay'	 Then Data :=  	 BuyerProtectionSourceCodeType.EBay
  Else If Value = 'PayPal'	 Then Data :=  	 BuyerProtectionSourceCodeType.PayPal
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BuyerProtectionCodeType);
Begin
       If Value ='ItemIneligible'	 Then Data :=  	 BuyerProtectionCodeType.ItemIneligible
  Else If Value = 'ItemEligible'	 Then Data :=  	 BuyerProtectionCodeType.ItemEligible
  Else If Value = 'ItemMarkedIneligible'	 Then Data :=  	 BuyerProtectionCodeType.ItemMarkedIneligible
  Else If Value = 'ItemMarkedEligible'	 Then Data :=  	 BuyerProtectionCodeType.ItemMarkedEligible
  Else If Value = 'NoCoverage'	 Then Data :=  	 BuyerProtectionCodeType.NoCoverage
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PricingTreatmentCodeType);
Begin
       If Value ='STP'	 Then Data :=  	 PricingTreatmentCodeType.STP
  Else If Value = 'MAP'	 Then Data :=  	 PricingTreatmentCodeType.MAP
  Else If Value = 'None'	 Then Data :=  	 PricingTreatmentCodeType.None
  Else If Value = 'MFO'	 Then Data :=  	 PricingTreatmentCodeType.MFO
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeRecordTypeCodeType);
Begin
       If Value ='UnpaidItem'	 Then Data :=  	 DisputeRecordTypeCodeType.UnpaidItem
  Else If Value = 'ItemNotReceived'	 Then Data :=  	 DisputeRecordTypeCodeType.ItemNotReceived
  Else If Value = 'HalfDispute'	 Then Data :=  	 DisputeRecordTypeCodeType.HalfDispute
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeStateCodeType);
Begin
       If Value ='Locked'	 Then Data :=  	 DisputeStateCodeType.Locked
  Else If Value = 'Closed'	 Then Data :=  	 DisputeStateCodeType.Closed
  Else If Value = 'BuyerFirstResponsePayOption'	 Then Data :=  	 DisputeStateCodeType.BuyerFirstResponsePayOption
  Else If Value = 'BuyerFirstResponseNoPayOption'	 Then Data :=  	 DisputeStateCodeType.BuyerFirstResponseNoPayOption
  Else If Value = 'BuyerFirstResponsePayOptionLateResponse'	 Then Data :=  	 DisputeStateCodeType.BuyerFirstResponsePayOptionLateResponse
  Else If Value = 'BuyerFirstResponseNoPayOptionLateResponse'	 Then Data :=  	 DisputeStateCodeType.BuyerFirstResponseNoPayOptionLateResponse
  Else If Value = 'MutualCommunicationPayOption'	 Then Data :=  	 DisputeStateCodeType.MutualCommunicationPayOption
  Else If Value = 'MutualCommunicationNoPayOption'	 Then Data :=  	 DisputeStateCodeType.MutualCommunicationNoPayOption
  Else If Value = 'PendingResolve'	 Then Data :=  	 DisputeStateCodeType.PendingResolve
  Else If Value = 'MutualWithdrawalAgreement'	 Then Data :=  	 DisputeStateCodeType.MutualWithdrawalAgreement
  Else If Value = 'MutualWithdrawalAgreementLate'	 Then Data :=  	 DisputeStateCodeType.MutualWithdrawalAgreementLate
  Else If Value = 'NotReceivedNoSellerResponse'	 Then Data :=  	 DisputeStateCodeType.NotReceivedNoSellerResponse
  Else If Value = 'NotAsDescribedNoSellerResponse'	 Then Data :=  	 DisputeStateCodeType.NotAsDescribedNoSellerResponse
  Else If Value = 'NotReceivedMutualCommunication'	 Then Data :=  	 DisputeStateCodeType.NotReceivedMutualCommunication
  Else If Value = 'NotAsDescribedMutualCommunication'	 Then Data :=  	 DisputeStateCodeType.NotAsDescribedMutualCommunication
  Else If Value = 'MutualAgreementOrBuyerReturningItem'	 Then Data :=  	 DisputeStateCodeType.MutualAgreementOrBuyerReturningItem
  Else If Value = 'ClaimOpened'	 Then Data :=  	 DisputeStateCodeType.ClaimOpened
  Else If Value = 'NoDocumentation'	 Then Data :=  	 DisputeStateCodeType.NoDocumentation
  Else If Value = 'ClaimClosed'	 Then Data :=  	 DisputeStateCodeType.ClaimClosed
  Else If Value = 'ClaimDenied'	 Then Data :=  	 DisputeStateCodeType.ClaimDenied
  Else If Value = 'ClaimPending'	 Then Data :=  	 DisputeStateCodeType.ClaimPending
  Else If Value = 'ClaimPaymentPending'	 Then Data :=  	 DisputeStateCodeType.ClaimPaymentPending
  Else If Value = 'ClaimPaid'	 Then Data :=  	 DisputeStateCodeType.ClaimPaid
  Else If Value = 'ClaimResolved'	 Then Data :=  	 DisputeStateCodeType.ClaimResolved
  Else If Value = 'ClaimSubmitted'	 Then Data :=  	 DisputeStateCodeType.ClaimSubmitted
  Else If Value = 'UnpaidItemOpen'	 Then Data :=  	 DisputeStateCodeType.UnpaidItemOpen
  Else If Value = 'UPIAssistanceDisabledByeBay'	 Then Data :=  	 DisputeStateCodeType.UPIAssistanceDisabledByeBay
  Else If Value = 'UPIAssistanceDisabledBySeller'	 Then Data :=  	 DisputeStateCodeType.UPIAssistanceDisabledBySeller
  Else If Value = 'CustomCode'	 Then Data :=  	 DisputeStateCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DescriptionTemplateCodeType);
Begin
       If Value ='Layout'	 Then Data :=  	 DescriptionTemplateCodeType.Layout
  Else If Value = 'Theme'	 Then Data :=  	 DescriptionTemplateCodeType.Theme
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MinimumAdvertisedPriceExposureCodeType);
Begin
       If Value ='PreCheckout'	 Then Data :=  	 MinimumAdvertisedPriceExposureCodeType.PreCheckout
  Else If Value = 'DuringCheckout'	 Then Data :=  	 MinimumAdvertisedPriceExposureCodeType.DuringCheckout
  Else If Value = 'None'	 Then Data :=  	 MinimumAdvertisedPriceExposureCodeType.None
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeStatusCodeType);
Begin
       If Value ='Closed'	 Then Data :=  	 DisputeStatusCodeType.Closed
  Else If Value = 'WaitingForSellerResponse'	 Then Data :=  	 DisputeStatusCodeType.WaitingForSellerResponse
  Else If Value = 'WaitingForBuyerResponse'	 Then Data :=  	 DisputeStatusCodeType.WaitingForBuyerResponse
  Else If Value = 'ClosedFVFCreditStrike'	 Then Data :=  	 DisputeStatusCodeType.ClosedFVFCreditStrike
  Else If Value = 'ClosedNoFVFCreditStrike'	 Then Data :=  	 DisputeStatusCodeType.ClosedNoFVFCreditStrike
  Else If Value = 'ClosedFVFCreditNoStrike'	 Then Data :=  	 DisputeStatusCodeType.ClosedFVFCreditNoStrike
  Else If Value = 'ClosedNoFVFCreditNoStrike'	 Then Data :=  	 DisputeStatusCodeType.ClosedNoFVFCreditNoStrike
  Else If Value = 'StrikeAppealedAfterClosing'	 Then Data :=  	 DisputeStatusCodeType.StrikeAppealedAfterClosing
  Else If Value = 'FVFCreditReversedAfterClosing'	 Then Data :=  	 DisputeStatusCodeType.FVFCreditReversedAfterClosing
  Else If Value = 'StrikeAppealedAndFVFCreditReversed'	 Then Data :=  	 DisputeStatusCodeType.StrikeAppealedAndFVFCreditReversed
  Else If Value = 'ClaimOpened'	 Then Data :=  	 DisputeStatusCodeType.ClaimOpened
  Else If Value = 'NoDocumentation'	 Then Data :=  	 DisputeStatusCodeType.NoDocumentation
  Else If Value = 'ClaimClosed'	 Then Data :=  	 DisputeStatusCodeType.ClaimClosed
  Else If Value = 'ClaimDenied'	 Then Data :=  	 DisputeStatusCodeType.ClaimDenied
  Else If Value = 'ClaimInProcess'	 Then Data :=  	 DisputeStatusCodeType.ClaimInProcess
  Else If Value = 'ClaimApproved'	 Then Data :=  	 DisputeStatusCodeType.ClaimApproved
  Else If Value = 'ClaimPaid'	 Then Data :=  	 DisputeStatusCodeType.ClaimPaid
  Else If Value = 'ClaimResolved'	 Then Data :=  	 DisputeStatusCodeType.ClaimResolved
  Else If Value = 'ClaimSubmitted'	 Then Data :=  	 DisputeStatusCodeType.ClaimSubmitted
  Else If Value = 'UnpaidItemOpened'	 Then Data :=  	 DisputeStatusCodeType.UnpaidItemOpened
  Else If Value = 'CustomCode'	 Then Data :=  	 DisputeStatusCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : EndOfAuctionLogoTypeCodeType);
Begin
       If Value ='WinningBidderNotice'	 Then Data :=  	 EndOfAuctionLogoTypeCodeType.WinningBidderNotice
  Else If Value = 'Store'	 Then Data :=  	 EndOfAuctionLogoTypeCodeType.Store
  Else If Value = 'Customized'	 Then Data :=  	 EndOfAuctionLogoTypeCodeType.Customized
  Else If Value = 'CustomCode'	 Then Data :=  	 EndOfAuctionLogoTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeCreditEligibilityCodeType);
Begin
       If Value ='InEligible'	 Then Data :=  	 DisputeCreditEligibilityCodeType.InEligible
  Else If Value = 'Eligible'	 Then Data :=  	 DisputeCreditEligibilityCodeType.Eligible
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DaysCodeType);
Begin
       If Value ='None'	 Then Data :=  	 DaysCodeType.None
  Else If Value = 'EveryDay'	 Then Data :=  	 DaysCodeType.EveryDay
  Else If Value = 'Weekdays'	 Then Data :=  	 DaysCodeType.Weekdays
  Else If Value = 'Weekends'	 Then Data :=  	 DaysCodeType.Weekends
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PromotionSchemeCodeType);
Begin
       If Value ='ItemToItem'	 Then Data :=  	 PromotionSchemeCodeType.ItemToItem
  Else If Value = 'ItemToStoreCat'	 Then Data :=  	 PromotionSchemeCodeType.ItemToStoreCat
  Else If Value = 'StoreToStoreCat'	 Then Data :=  	 PromotionSchemeCodeType.StoreToStoreCat
  Else If Value = 'ItemToDefaultRule'	 Then Data :=  	 PromotionSchemeCodeType.ItemToDefaultRule
  Else If Value = 'DefaultRule'	 Then Data :=  	 PromotionSchemeCodeType.DefaultRule
  Else If Value = 'CategoryProximity'	 Then Data :=  	 PromotionSchemeCodeType.CategoryProximity
  Else If Value = 'RelatedCategoryRule'	 Then Data :=  	 PromotionSchemeCodeType.RelatedCategoryRule
  Else If Value = 'DefaultUpSellLogic'	 Then Data :=  	 PromotionSchemeCodeType.DefaultUpSellLogic
  Else If Value = 'DefaultCrossSellLogic'	 Then Data :=  	 PromotionSchemeCodeType.DefaultCrossSellLogic
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemFormatSortFilterCodeType);
Begin
       If Value ='ShowAnyItems'	 Then Data :=  	 ItemFormatSortFilterCodeType.ShowAnyItems
  Else If Value = 'ShowItemsWithBINFirst'	 Then Data :=  	 ItemFormatSortFilterCodeType.ShowItemsWithBINFirst
  Else If Value = 'ShowOnlyItemsWithBIN'	 Then Data :=  	 ItemFormatSortFilterCodeType.ShowOnlyItemsWithBIN
  Else If Value = 'ShowOnlyStoreItems'	 Then Data :=  	 ItemFormatSortFilterCodeType.ShowOnlyStoreItems
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : GallerySortFilterCodeType);
Begin
       If Value ='ShowAnyItems'	 Then Data :=  	 GallerySortFilterCodeType.ShowAnyItems
  Else If Value = 'ShowItemsWithGalleryImagesFirst'	 Then Data :=  	 GallerySortFilterCodeType.ShowItemsWithGalleryImagesFirst
  Else If Value = 'ShowOnlyItemsWithGalleryImages'	 Then Data :=  	 GallerySortFilterCodeType.ShowOnlyItemsWithGalleryImages
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ItemSortFilterCodeType);
Begin
       If Value ='EndingLast'	 Then Data :=  	 ItemSortFilterCodeType.EndingLast
  Else If Value = 'EndingSoonest'	 Then Data :=  	 ItemSortFilterCodeType.EndingSoonest
  Else If Value = 'HighestPrice'	 Then Data :=  	 ItemSortFilterCodeType.HighestPrice
  Else If Value = 'LowestPrice'	 Then Data :=  	 ItemSortFilterCodeType.LowestPrice
  Else If Value = 'NewlyListed'	 Then Data :=  	 ItemSortFilterCodeType.NewlyListed
  Else If Value = 'RandomlySelected'	 Then Data :=  	 ItemSortFilterCodeType.RandomlySelected
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PaymentTransactionStatusCodeType);
Begin
       If Value ='Failed'	 Then Data :=  	 PaymentTransactionStatusCodeType.Failed
  Else If Value = 'Succeeded'	 Then Data :=  	 PaymentTransactionStatusCodeType.Succeeded
  Else If Value = 'Pending'	 Then Data :=  	 PaymentTransactionStatusCodeType.Pending
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : ExternalProductCodeType);
Begin
       If Value ='ISBN'	 Then Data :=  	 ExternalProductCodeType.ISBN
  Else If Value = 'UPC'	 Then Data :=  	 ExternalProductCodeType.UPC
  Else If Value = 'ProductID'	 Then Data :=  	 ExternalProductCodeType.ProductID
  Else If Value = 'EAN'	 Then Data :=  	 ExternalProductCodeType.EAN
  Else If Value = 'Keywords'	 Then Data :=  	 ExternalProductCodeType.Keywords
  Else If Value = 'MPN'	 Then Data :=  	 ExternalProductCodeType.MPN
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : MyMessagesFolderOperationCodeType);
Begin
       If Value ='Display'	 Then Data :=  	 MyMessagesFolderOperationCodeType.Display
  Else If Value = 'Rename'	 Then Data :=  	 MyMessagesFolderOperationCodeType.Rename
  Else If Value = 'Remove'	 Then Data :=  	 MyMessagesFolderOperationCodeType.Remove
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : FeedbackResponseCodeType);
Begin
       If Value ='Reply'	 Then Data :=  	 FeedbackResponseCodeType.Reply
  Else If Value = 'FollowUp'	 Then Data :=  	 FeedbackResponseCodeType.FollowUp
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BuyerPaymentMethodCodeType);
Begin
       If Value ='None'	 Then Data :=  	 BuyerPaymentMethodCodeType.None
  Else If Value = 'MOCC'	 Then Data :=  	 BuyerPaymentMethodCodeType.MOCC
  Else If Value = 'AmEx'	 Then Data :=  	 BuyerPaymentMethodCodeType.AmEx
  Else If Value = 'PaymentSeeDescription'	 Then Data :=  	 BuyerPaymentMethodCodeType.PaymentSeeDescription
  Else If Value = 'CCAccepted'	 Then Data :=  	 BuyerPaymentMethodCodeType.CCAccepted
  Else If Value = 'PersonalCheck'	 Then Data :=  	 BuyerPaymentMethodCodeType.PersonalCheck
  Else If Value = 'COD'	 Then Data :=  	 BuyerPaymentMethodCodeType.COD
  Else If Value = 'VisaMC'	 Then Data :=  	 BuyerPaymentMethodCodeType.VisaMC
  Else If Value = 'PaisaPayAccepted'	 Then Data :=  	 BuyerPaymentMethodCodeType.PaisaPayAccepted
  Else If Value = 'Other'	 Then Data :=  	 BuyerPaymentMethodCodeType.Other
  Else If Value = 'PayPal'	 Then Data :=  	 BuyerPaymentMethodCodeType.PayPal
  Else If Value = 'Discover'	 Then Data :=  	 BuyerPaymentMethodCodeType.Discover
  Else If Value = 'CashOnPickup'	 Then Data :=  	 BuyerPaymentMethodCodeType.CashOnPickup
  Else If Value = 'MoneyXferAccepted'	 Then Data :=  	 BuyerPaymentMethodCodeType.MoneyXferAccepted
  Else If Value = 'MoneyXferAcceptedInCheckout'	 Then Data :=  	 BuyerPaymentMethodCodeType.MoneyXferAcceptedInCheckout
  Else If Value = 'OtherOnlinePayments'	 Then Data :=  	 BuyerPaymentMethodCodeType.OtherOnlinePayments
  Else If Value = 'Escrow'	 Then Data :=  	 BuyerPaymentMethodCodeType.Escrow
  Else If Value = 'PrePayDelivery'	 Then Data :=  	 BuyerPaymentMethodCodeType.PrePayDelivery
  Else If Value = 'CODPrePayDelivery'	 Then Data :=  	 BuyerPaymentMethodCodeType.CODPrePayDelivery
  Else If Value = 'PostalTransfer'	 Then Data :=  	 BuyerPaymentMethodCodeType.PostalTransfer
  Else If Value = 'CustomCode'	 Then Data :=  	 BuyerPaymentMethodCodeType.CustomCode
  Else If Value = 'LoanCheck'	 Then Data :=  	 BuyerPaymentMethodCodeType.LoanCheck
  Else If Value = 'CashInPerson'	 Then Data :=  	 BuyerPaymentMethodCodeType.CashInPerson
  Else If Value = 'ELV'	 Then Data :=  	 BuyerPaymentMethodCodeType.ELV
  Else If Value = 'PaisaPayEscrow'	 Then Data :=  	 BuyerPaymentMethodCodeType.PaisaPayEscrow
  Else If Value = 'PaisaPayEscrowEMI'	 Then Data :=  	 BuyerPaymentMethodCodeType.PaisaPayEscrowEMI
  Else If Value = 'IntegratedMerchantCreditCard'	 Then Data :=  	 BuyerPaymentMethodCodeType.IntegratedMerchantCreditCard
  Else If Value = 'Moneybookers'	 Then Data :=  	 BuyerPaymentMethodCodeType.Moneybookers
  Else If Value = 'Paymate'	 Then Data :=  	 BuyerPaymentMethodCodeType.Paymate
  Else If Value = 'ProPay'	 Then Data :=  	 BuyerPaymentMethodCodeType.ProPay
  Else If Value = 'PayOnPickup'	 Then Data :=  	 BuyerPaymentMethodCodeType.PayOnPickup
  Else If Value = 'Diners'	 Then Data :=  	 BuyerPaymentMethodCodeType.Diners
  Else If Value = 'StandardPayment'	 Then Data :=  	 BuyerPaymentMethodCodeType.StandardPayment
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : InsuranceSelectedCodeType);
Begin
       If Value ='NotOffered'	 Then Data :=  	 InsuranceSelectedCodeType.NotOffered
  Else If Value = 'OfferedNotSelected'	 Then Data :=  	 InsuranceSelectedCodeType.OfferedNotSelected
  Else If Value = 'OfferedSelected'	 Then Data :=  	 InsuranceSelectedCodeType.OfferedSelected
  Else If Value = 'Required'	 Then Data :=  	 InsuranceSelectedCodeType.Required
  Else If Value = 'IncludedInShippingHandling'	 Then Data :=  	 InsuranceSelectedCodeType.IncludedInShippingHandling
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CompleteStatusCodeType);
Begin
       If Value ='Incomplete'	 Then Data :=  	 CompleteStatusCodeType.Incomplete
  Else If Value = 'Complete'	 Then Data :=  	 CompleteStatusCodeType.Complete
  Else If Value = 'Pending'	 Then Data :=  	 CompleteStatusCodeType.Pending
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : CheckoutMethodCodeType);
Begin
       If Value ='Other'	 Then Data :=  	 CheckoutMethodCodeType.Other
  Else If Value = 'ThirdPartyCheckout'	 Then Data :=  	 CheckoutMethodCodeType.ThirdPartyCheckout
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : InsuranceOptionCodeType);
Begin
       If Value ='Optional'	 Then Data :=  	 InsuranceOptionCodeType.Optional
  Else If Value = 'Required'	 Then Data :=  	 InsuranceOptionCodeType.Required
  Else If Value = 'NotOffered'	 Then Data :=  	 InsuranceOptionCodeType.NotOffered
  Else If Value = 'IncludedInShippingHandling'	 Then Data :=  	 InsuranceOptionCodeType.IncludedInShippingHandling
  Else If Value = 'NotOfferedOnSite'	 Then Data :=  	 InsuranceOptionCodeType.NotOfferedOnSite
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : PictureManagerActionCodeType);
Begin
       If Value ='Add'	 Then Data :=  	 PictureManagerActionCodeType.Add
  Else If Value = 'Delete'	 Then Data :=  	 PictureManagerActionCodeType.Delete
  Else If Value = 'Rename'	 Then Data :=  	 PictureManagerActionCodeType.Rename
  Else If Value = 'Move'	 Then Data :=  	 PictureManagerActionCodeType.Move
  Else If Value = 'Change'	 Then Data :=  	 PictureManagerActionCodeType.Change
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : DisputeResolutionReasonCodeType);
Begin
       If Value ='Unresolved'	 Then Data :=  	 DisputeResolutionReasonCodeType.Unresolved
  Else If Value = 'ProofOfPayment'	 Then Data :=  	 DisputeResolutionReasonCodeType.ProofOfPayment
  Else If Value = 'ComputerTechnicalProblem'	 Then Data :=  	 DisputeResolutionReasonCodeType.ComputerTechnicalProblem
  Else If Value = 'NoContact'	 Then Data :=  	 DisputeResolutionReasonCodeType.NoContact
  Else If Value = 'FamilyEmergency'	 Then Data :=  	 DisputeResolutionReasonCodeType.FamilyEmergency
  Else If Value = 'ProofGivenInFeedback'	 Then Data :=  	 DisputeResolutionReasonCodeType.ProofGivenInFeedback
  Else If Value = 'FirstInfraction'	 Then Data :=  	 DisputeResolutionReasonCodeType.FirstInfraction
  Else If Value = 'CameToAgreement'	 Then Data :=  	 DisputeResolutionReasonCodeType.CameToAgreement
  Else If Value = 'ItemReturned'	 Then Data :=  	 DisputeResolutionReasonCodeType.ItemReturned
  Else If Value = 'BuyerPaidAuctionFees'	 Then Data :=  	 DisputeResolutionReasonCodeType.BuyerPaidAuctionFees
  Else If Value = 'SellerReceivedPayment'	 Then Data :=  	 DisputeResolutionReasonCodeType.SellerReceivedPayment
  Else If Value = 'OtherResolution'	 Then Data :=  	 DisputeResolutionReasonCodeType.OtherResolution
  Else If Value = 'ClaimPaid'	 Then Data :=  	 DisputeResolutionReasonCodeType.ClaimPaid
  Else If Value = 'CustomCode'	 Then Data :=  	 DisputeResolutionReasonCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DetailNameCodeType);
Begin
       If Value ='CountryDetails'	 Then Data :=  	 DetailNameCodeType.CountryDetails
  Else If Value = 'CurrencyDetails'	 Then Data :=  	 DetailNameCodeType.CurrencyDetails
  Else If Value = 'PaymentOptionDetails'	 Then Data :=  	 DetailNameCodeType.PaymentOptionDetails
  Else If Value = 'RegionDetails'	 Then Data :=  	 DetailNameCodeType.RegionDetails
  Else If Value = 'ShippingLocationDetails'	 Then Data :=  	 DetailNameCodeType.ShippingLocationDetails
  Else If Value = 'ShippingServiceDetails'	 Then Data :=  	 DetailNameCodeType.ShippingServiceDetails
  Else If Value = 'SiteDetails'	 Then Data :=  	 DetailNameCodeType.SiteDetails
  Else If Value = 'TaxJurisdiction'	 Then Data :=  	 DetailNameCodeType.TaxJurisdiction
  Else If Value = 'URLDetails'	 Then Data :=  	 DetailNameCodeType.URLDetails
  Else If Value = 'TimeZoneDetails'	 Then Data :=  	 DetailNameCodeType.TimeZoneDetails
  Else If Value = 'RegionOfOriginDetails'	 Then Data :=  	 DetailNameCodeType.RegionOfOriginDetails
  Else If Value = 'DispatchTimeMaxDetails'	 Then Data :=  	 DetailNameCodeType.DispatchTimeMaxDetails
  Else If Value = 'ItemSpecificDetails'	 Then Data :=  	 DetailNameCodeType.ItemSpecificDetails
  Else If Value = 'UnitOfMeasurementDetails'	 Then Data :=  	 DetailNameCodeType.UnitOfMeasurementDetails
  Else If Value = 'ShippingPackageDetails'	 Then Data :=  	 DetailNameCodeType.ShippingPackageDetails
  Else If Value = 'CustomCode'	 Then Data :=  	 DetailNameCodeType.CustomCode
  Else If Value = 'ShippingCarrierDetails'	 Then Data :=  	 DetailNameCodeType.ShippingCarrierDetails
  Else If Value = 'ListingStartPriceDetails'	 Then Data :=  	 DetailNameCodeType.ListingStartPriceDetails
  Else If Value = 'ReturnPolicyDetails'	 Then Data :=  	 DetailNameCodeType.ReturnPolicyDetails
  Else If Value = 'BuyerRequirementDetails'	 Then Data :=  	 DetailNameCodeType.BuyerRequirementDetails
  Else If Value = 'ListingFeatureDetails'	 Then Data :=  	 DetailNameCodeType.ListingFeatureDetails
  Else If Value = 'VariationDetails'	 Then Data :=  	 DetailNameCodeType.VariationDetails
  Else If Value = 'ExcludeShippingLocationDetails'	 Then Data :=  	 DetailNameCodeType.ExcludeShippingLocationDetails
  Else If Value = 'RecoupmentPolicyDetails'	 Then Data :=  	 DetailNameCodeType.RecoupmentPolicyDetails
  Else If Value = 'ShippingCategoryDetails'	 Then Data :=  	 DetailNameCodeType.ShippingCategoryDetails
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : BestOfferActionCodeType);
Begin
       If Value ='Accept'	 Then Data :=  	 BestOfferActionCodeType.Accept
  Else If Value = 'Decline'	 Then Data :=  	 BestOfferActionCodeType.Decline
  Else If Value = 'Counter'	 Then Data :=  	 BestOfferActionCodeType.Counter
  {Else Result  := 	 ''};
End;

(*Procedure StrToEnum(Const Value: String ; Var Data : RefundReasonCodeType);
Begin
       If Value ='CannotShipProduct'	 Then Data :=  	 RefundReasonCodeType.CannotShipProduct
  Else If Value = 'WrongItemShipped'	 Then Data :=  	 RefundReasonCodeType.WrongItemShipped
  Else If Value = 'ItemBadQuality'	 Then Data :=  	 RefundReasonCodeType.ItemBadQuality
  Else If Value = 'ItemDamaged'	 Then Data :=  	 RefundReasonCodeType.ItemDamaged
  Else If Value = 'BuyerRemorse'	 Then Data :=  	 RefundReasonCodeType.BuyerRemorse
  Else If Value = 'Other'	 Then Data :=  	 RefundReasonCodeType.Other
  {Else Result  := 	 ''};
End;*)

(*Procedure StrToEnum(Const Value: String ; Var Data : RefundTypeCodeType);
Begin
       If Value ='Full'	 Then Data :=  	 RefundTypeCodeType.Full
  Else If Value = 'FullPlusShipping'	 Then Data :=  	 RefundTypeCodeType.FullPlusShipping
  Else If Value = 'CustomOrPartial'	 Then Data :=  	 RefundTypeCodeType.CustomOrPartial
  {Else Result  := 	 ''};
End;*)

Procedure StrToEnum(Const Value: String ; Var Data : DisputeMessageSourceCodeType);
Begin
       If Value ='Buyer'	 Then Data :=  	 DisputeMessageSourceCodeType.Buyer
  Else If Value = 'Seller'	 Then Data :=  	 DisputeMessageSourceCodeType.Seller
  Else If Value = 'eBay'	 Then Data :=  	 DisputeMessageSourceCodeType.EBay
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SeverityCodeType);
Begin
       If Value ='Warning'	 Then Data :=  	 SeverityCodeType.Warning
  Else If Value = 'Error'	 Then Data :=  	 SeverityCodeType.Error
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ErrorClassificationCodeType);
Begin
       If Value ='RequestError'	 Then Data :=  	 ErrorClassificationCodeType.RequestError
  Else If Value = 'SystemError'	 Then Data :=  	 ErrorClassificationCodeType.SystemError
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DisputeResolutionRecordTypeCodeType);
Begin
       If Value ='StrikeBuyer'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.StrikeBuyer
  Else If Value = 'SuspendBuyer'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.SuspendBuyer
  Else If Value = 'RestrictBuyer'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.RestrictBuyer
  Else If Value = 'FVFCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.FVFCredit
  Else If Value = 'InsertionFeeCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.InsertionFeeCredit
  Else If Value = 'AppealBuyerStrike'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.AppealBuyerStrike
  Else If Value = 'UnsuspendBuyer'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.UnsuspendBuyer
  Else If Value = 'UnrestrictBuyer'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.UnrestrictBuyer
  Else If Value = 'ReverseFVFCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.ReverseFVFCredit
  Else If Value = 'ReverseInsertionFeeCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.ReverseInsertionFeeCredit
  Else If Value = 'GenerateCSTicketForSuspend'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.GenerateCSTicketForSuspend
  Else If Value = 'FVFCreditNotGranted'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.FVFCreditNotGranted
  Else If Value = 'ItemNotReceivedClaimFiled'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.ItemNotReceivedClaimFiled
  Else If Value = 'UnpaidItemRelisted'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.UnpaidItemRelisted
  Else If Value = 'UnpaidItemRevised'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.UnpaidItemRevised
  Else If Value = 'FVFOnShippingCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.FVFOnShippingCredit
  Else If Value = 'FVFOnShippingCreditNotGranted'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.FVFOnShippingCreditNotGranted
  Else If Value = 'ReverseFVFOnShippingCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.ReverseFVFOnShippingCredit
  Else If Value = 'FeatureFeeCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.FeatureFeeCredit
  Else If Value = 'FeatureFeeNotCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.FeatureFeeNotCredit
  Else If Value = 'ReverseFeatureFeeCredit'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.ReverseFeatureFeeCredit
  Else If Value = 'CustomCode'	 Then Data :=  	 DisputeResolutionRecordTypeCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : InvocationStatusType);
Begin
       If Value ='InProgress'	 Then Data :=  	 InvocationStatusType.InProgress
  Else If Value = 'Success'	 Then Data :=  	 InvocationStatusType.Success
  Else If Value = 'Failure'	 Then Data :=  	 InvocationStatusType.Failure
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DetailLevelCodeType);
Begin
       If Value ='ReturnAll'	 Then Data :=  	 DetailLevelCodeType.ReturnAll
  Else If Value = 'ItemReturnDescription'	 Then Data :=  	 DetailLevelCodeType.ItemReturnDescription
  Else If Value = 'ItemReturnAttributes'	 Then Data :=  	 DetailLevelCodeType.ItemReturnAttributes
  Else If Value = 'ItemReturnCategories'	 Then Data :=  	 DetailLevelCodeType.ItemReturnCategories
  Else If Value = 'ReturnSummary'	 Then Data :=  	 DetailLevelCodeType.ReturnSummary
  Else If Value = 'ReturnHeaders'	 Then Data :=  	 DetailLevelCodeType.ReturnHeaders
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AckCodeType);
Begin
       If Value ='Success'	 Then Data :=  	 AckCodeType.Success
  Else If Value = 'Failure'	 Then Data :=  	 AckCodeType.Failure
  Else If Value = 'Warning'	 Then Data :=  	 AckCodeType.Warning
  Else If Value = 'PartialFailure'	 Then Data :=  	 AckCodeType.PartialFailure
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ErrorHandlingCodeType);
Begin
       If Value ='Legacy'	 Then Data :=  	 ErrorHandlingCodeType.Legacy
  Else If Value = 'BestEffort'	 Then Data :=  	 ErrorHandlingCodeType.BestEffort
  Else If Value = 'AllOrNothing'	 Then Data :=  	 ErrorHandlingCodeType.AllOrNothing
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : WarningLevelCodeType);
Begin
       If Value ='Low_'	 Then Data :=  	 WarningLevelCodeType.Low_
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AnnouncementMessageCodeType);
Begin
       If Value ='None'	 Then Data :=  	 AnnouncementMessageCodeType.None
  Else If Value = 'Deprecation'	 Then Data :=  	 AnnouncementMessageCodeType.Deprecation
  Else If Value = 'Mapping'	 Then Data :=  	 AnnouncementMessageCodeType.Mapping
  Else If Value = 'DeprecationAndMapping'	 Then Data :=  	 AnnouncementMessageCodeType.DeprecationAndMapping
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AccessRuleCurrentStatusCodeType);
Begin
       If Value ='NotSet'	 Then Data :=  	 AccessRuleCurrentStatusCodeType.NotSet
  Else If Value = 'HourlyLimitExceeded'	 Then Data :=  	 AccessRuleCurrentStatusCodeType.HourlyLimitExceeded
  Else If Value = 'DailyLimitExceeded'	 Then Data :=  	 AccessRuleCurrentStatusCodeType.DailyLimitExceeded
  Else If Value = 'PeriodicLimitExceeded'	 Then Data :=  	 AccessRuleCurrentStatusCodeType.PeriodicLimitExceeded
  Else If Value = 'HourlySoftLimitExceeded'	 Then Data :=  	 AccessRuleCurrentStatusCodeType.HourlySoftLimitExceeded
  Else If Value = 'DailySoftLimitExceeded'	 Then Data :=  	 AccessRuleCurrentStatusCodeType.DailySoftLimitExceeded
  Else If Value = 'PeriodicSoftLimitExceeded'	 Then Data :=  	 AccessRuleCurrentStatusCodeType.PeriodicSoftLimitExceeded
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AccessRuleStatusCodeType);
Begin
       If Value ='RuleOff'	 Then Data :=  	 AccessRuleStatusCodeType.RuleOff
  Else If Value = 'RuleOn'	 Then Data :=  	 AccessRuleStatusCodeType.RuleOn
  Else If Value = 'ApplicationBlocked'	 Then Data :=  	 AccessRuleStatusCodeType.ApplicationBlocked
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AddressUsageCodeType);
Begin
       If Value ='DefaultShipping'	 Then Data :=  	 AddressUsageCodeType.DefaultShipping
  Else If Value = 'Shipping'	 Then Data :=  	 AddressUsageCodeType.Shipping
  Else If Value = 'Invalid'	 Then Data :=  	 AddressUsageCodeType.Invalid
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ApplicationDeviceTypeCodeType);
Begin
       If Value ='Browser'	 Then Data :=  	 ApplicationDeviceTypeCodeType.Browser
  Else If Value = 'Wireless'	 Then Data :=  	 ApplicationDeviceTypeCodeType.Wireless
  Else If Value = 'Desktop'	 Then Data :=  	 ApplicationDeviceTypeCodeType.Desktop
  Else If Value = 'SetTopTVBox'	 Then Data :=  	 ApplicationDeviceTypeCodeType.SetTopTVBox
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : EnableCodeType);
Begin
       If Value ='Enable'	 Then Data :=  	 EnableCodeType.Enable
  Else If Value = 'Disable'	 Then Data :=  	 EnableCodeType.Disable
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : NotificationPayloadTypeCodeType);
Begin
       If Value ='eBLSchemaSOAP'	 Then Data :=  	 NotificationPayloadTypeCodeType.EBLSchemaSOAP
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : DeviceTypeCodeType);
Begin
       If Value ='Platform_'	 Then Data :=  	 DeviceTypeCodeType.Platform_
  Else If Value = 'SMS'	 Then Data :=  	 DeviceTypeCodeType.SMS
  Else If Value = 'ClientAlerts'	 Then Data :=  	 DeviceTypeCodeType.ClientAlerts
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AccountDetailEntryCodeType);
Begin
       If Value ='Unknown'	 Then Data :=  	 AccountDetailEntryCodeType.Unknown
  Else If Value = 'FeeInsertion'	 Then Data :=  	 AccountDetailEntryCodeType.FeeInsertion
  Else If Value = 'FeeBold'	 Then Data :=  	 AccountDetailEntryCodeType.FeeBold
  Else If Value = 'FeeFeatured'	 Then Data :=  	 AccountDetailEntryCodeType.FeeFeatured
  Else If Value = 'FeeCategoryFeatured'	 Then Data :=  	 AccountDetailEntryCodeType.FeeCategoryFeatured
  Else If Value = 'FeeFinalValue'	 Then Data :=  	 AccountDetailEntryCodeType.FeeFinalValue
  Else If Value = 'PaymentCheck'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentCheck
  Else If Value = 'PaymentCC'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentCC
  Else If Value = 'CreditCourtesy'	 Then Data :=  	 AccountDetailEntryCodeType.CreditCourtesy
  Else If Value = 'CreditNoSale'	 Then Data :=  	 AccountDetailEntryCodeType.CreditNoSale
  Else If Value = 'CreditPartialSale'	 Then Data :=  	 AccountDetailEntryCodeType.CreditPartialSale
  Else If Value = 'RefundCC'	 Then Data :=  	 AccountDetailEntryCodeType.RefundCC
  Else If Value = 'RefundCheck'	 Then Data :=  	 AccountDetailEntryCodeType.RefundCheck
  Else If Value = 'FinanceCharge'	 Then Data :=  	 AccountDetailEntryCodeType.FinanceCharge
  Else If Value = 'AWDebit'	 Then Data :=  	 AccountDetailEntryCodeType.AWDebit
  Else If Value = 'AWCredit'	 Then Data :=  	 AccountDetailEntryCodeType.AWCredit
  Else If Value = 'AWMemo'	 Then Data :=  	 AccountDetailEntryCodeType.AWMemo
  Else If Value = 'CreditDuplicateListing'	 Then Data :=  	 AccountDetailEntryCodeType.CreditDuplicateListing
  Else If Value = 'FeePartialSale'	 Then Data :=  	 AccountDetailEntryCodeType.FeePartialSale
  Else If Value = 'PaymentElectronicTransferReversal'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentElectronicTransferReversal
  Else If Value = 'PaymentCCOnce'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentCCOnce
  Else If Value = 'FeeReturnedCheck'	 Then Data :=  	 AccountDetailEntryCodeType.FeeReturnedCheck
  Else If Value = 'FeeRedepositCheck'	 Then Data :=  	 AccountDetailEntryCodeType.FeeRedepositCheck
  Else If Value = 'PaymentCash'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentCash
  Else If Value = 'CreditInsertion'	 Then Data :=  	 AccountDetailEntryCodeType.CreditInsertion
  Else If Value = 'CreditBold'	 Then Data :=  	 AccountDetailEntryCodeType.CreditBold
  Else If Value = 'CreditFeatured'	 Then Data :=  	 AccountDetailEntryCodeType.CreditFeatured
  Else If Value = 'CreditCategoryFeatured'	 Then Data :=  	 AccountDetailEntryCodeType.CreditCategoryFeatured
  Else If Value = 'CreditFinalValue'	 Then Data :=  	 AccountDetailEntryCodeType.CreditFinalValue
  Else If Value = 'FeeNSFCheck'	 Then Data :=  	 AccountDetailEntryCodeType.FeeNSFCheck
  Else If Value = 'FeeReturnCheckClose'	 Then Data :=  	 AccountDetailEntryCodeType.FeeReturnCheckClose
  Else If Value = 'Memo'	 Then Data :=  	 AccountDetailEntryCodeType.Memo
  Else If Value = 'PaymentMoneyOrder'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentMoneyOrder
  Else If Value = 'CreditCardOnFile'	 Then Data :=  	 AccountDetailEntryCodeType.CreditCardOnFile
  Else If Value = 'CreditCardNotOnFile'	 Then Data :=  	 AccountDetailEntryCodeType.CreditCardNotOnFile
  Else If Value = 'Invoiced'	 Then Data :=  	 AccountDetailEntryCodeType.Invoiced
  Else If Value = 'InvoicedCreditCard'	 Then Data :=  	 AccountDetailEntryCodeType.InvoicedCreditCard
  Else If Value = 'CreditTransferFrom'	 Then Data :=  	 AccountDetailEntryCodeType.CreditTransferFrom
  Else If Value = 'DebitTransferTo'	 Then Data :=  	 AccountDetailEntryCodeType.DebitTransferTo
  Else If Value = 'InvoiceCreditBalance'	 Then Data :=  	 AccountDetailEntryCodeType.InvoiceCreditBalance
  Else If Value = 'eBayDebit'	 Then Data :=  	 AccountDetailEntryCodeType.EBayDebit
  Else If Value = 'eBayCredit'	 Then Data :=  	 AccountDetailEntryCodeType.EBayCredit
  Else If Value = 'PromotionalCredit'	 Then Data :=  	 AccountDetailEntryCodeType.PromotionalCredit
  Else If Value = 'CCNotOnFilePerCustReq'	 Then Data :=  	 AccountDetailEntryCodeType.CCNotOnFilePerCustReq
  Else If Value = 'CreditInsertionFee'	 Then Data :=  	 AccountDetailEntryCodeType.CreditInsertionFee
  Else If Value = 'CCPaymentRejected'	 Then Data :=  	 AccountDetailEntryCodeType.CCPaymentRejected
  Else If Value = 'FeeGiftIcon'	 Then Data :=  	 AccountDetailEntryCodeType.FeeGiftIcon
  Else If Value = 'CreditGiftIcon'	 Then Data :=  	 AccountDetailEntryCodeType.CreditGiftIcon
  Else If Value = 'FeeGallery'	 Then Data :=  	 AccountDetailEntryCodeType.FeeGallery
  Else If Value = 'FeeFeaturedGallery'	 Then Data :=  	 AccountDetailEntryCodeType.FeeFeaturedGallery
  Else If Value = 'CreditGallery'	 Then Data :=  	 AccountDetailEntryCodeType.CreditGallery
  Else If Value = 'CreditFeaturedGallery'	 Then Data :=  	 AccountDetailEntryCodeType.CreditFeaturedGallery
  Else If Value = 'ItemMoveFee'	 Then Data :=  	 AccountDetailEntryCodeType.ItemMoveFee
  Else If Value = 'OutageCredit'	 Then Data :=  	 AccountDetailEntryCodeType.OutageCredit
  Else If Value = 'CreditPSA'	 Then Data :=  	 AccountDetailEntryCodeType.CreditPSA
  Else If Value = 'CreditPCGS'	 Then Data :=  	 AccountDetailEntryCodeType.CreditPCGS
  Else If Value = 'FeeReserve'	 Then Data :=  	 AccountDetailEntryCodeType.FeeReserve
  Else If Value = 'CreditReserve'	 Then Data :=  	 AccountDetailEntryCodeType.CreditReserve
  Else If Value = 'eBayVISACredit'	 Then Data :=  	 AccountDetailEntryCodeType.EBayVISACredit
  Else If Value = 'BBAdminCredit'	 Then Data :=  	 AccountDetailEntryCodeType.BBAdminCredit
  Else If Value = 'BBAdminDebit'	 Then Data :=  	 AccountDetailEntryCodeType.BBAdminDebit
  Else If Value = 'ReferrerCredit'	 Then Data :=  	 AccountDetailEntryCodeType.ReferrerCredit
  Else If Value = 'ReferrerDebit'	 Then Data :=  	 AccountDetailEntryCodeType.ReferrerDebit
  Else If Value = 'SwitchCurrency'	 Then Data :=  	 AccountDetailEntryCodeType.SwitchCurrency
  Else If Value = 'PaymentGiftCertificate'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentGiftCertificate
  Else If Value = 'PaymentWireTransfer'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentWireTransfer
  Else If Value = 'PaymentHomeBanking'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentHomeBanking
  Else If Value = 'PaymentElectronicTransfer'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentElectronicTransfer
  Else If Value = 'PaymentAdjustmentCredit'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentAdjustmentCredit
  Else If Value = 'PaymentAdjustmentDebit'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentAdjustmentDebit
  Else If Value = 'Chargeoff'	 Then Data :=  	 AccountDetailEntryCodeType.Chargeoff
  Else If Value = 'ChargeoffRecovery'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeoffRecovery
  Else If Value = 'ChargeoffBankruptcy'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeoffBankruptcy
  Else If Value = 'ChargeoffSuspended'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeoffSuspended
  Else If Value = 'ChargeoffDeceased'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeoffDeceased
  Else If Value = 'ChargeoffOther'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeoffOther
  Else If Value = 'ChargeoffWacko'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeoffWacko
  Else If Value = 'FinanceChargeReversal'	 Then Data :=  	 AccountDetailEntryCodeType.FinanceChargeReversal
  Else If Value = 'FVFCreditReversal'	 Then Data :=  	 AccountDetailEntryCodeType.FVFCreditReversal
  Else If Value = 'ForeignFundsConvert'	 Then Data :=  	 AccountDetailEntryCodeType.ForeignFundsConvert
  Else If Value = 'ForeignFundsCheckReversal'	 Then Data :=  	 AccountDetailEntryCodeType.ForeignFundsCheckReversal
  Else If Value = 'EOMRestriction'	 Then Data :=  	 AccountDetailEntryCodeType.EOMRestriction
  Else If Value = 'AllFeesCredit'	 Then Data :=  	 AccountDetailEntryCodeType.AllFeesCredit
  Else If Value = 'SetOnHold'	 Then Data :=  	 AccountDetailEntryCodeType.SetOnHold
  Else If Value = 'RevertUserState'	 Then Data :=  	 AccountDetailEntryCodeType.RevertUserState
  Else If Value = 'DirectDebitOnFile'	 Then Data :=  	 AccountDetailEntryCodeType.DirectDebitOnFile
  Else If Value = 'DirectDebitNotOnFile'	 Then Data :=  	 AccountDetailEntryCodeType.DirectDebitNotOnFile
  Else If Value = 'PaymentDirectDebit'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentDirectDebit
  Else If Value = 'DirectDebitReversal'	 Then Data :=  	 AccountDetailEntryCodeType.DirectDebitReversal
  Else If Value = 'DirectDebitReturnedItem'	 Then Data :=  	 AccountDetailEntryCodeType.DirectDebitReturnedItem
  Else If Value = 'FeeHighlight'	 Then Data :=  	 AccountDetailEntryCodeType.FeeHighlight
  Else If Value = 'CreditHighlight'	 Then Data :=  	 AccountDetailEntryCodeType.CreditHighlight
  Else If Value = 'BulkUserSuspension'	 Then Data :=  	 AccountDetailEntryCodeType.BulkUserSuspension
  Else If Value = 'FeeRealEstate30DaysListing'	 Then Data :=  	 AccountDetailEntryCodeType.FeeRealEstate30DaysListing
  Else If Value = 'CreditRealEstate30DaysListing'	 Then Data :=  	 AccountDetailEntryCodeType.CreditRealEstate30DaysListing
  Else If Value = 'TradingLimitOverrideOn'	 Then Data :=  	 AccountDetailEntryCodeType.TradingLimitOverrideOn
  Else If Value = 'TradingLimitOverrideOff'	 Then Data :=  	 AccountDetailEntryCodeType.TradingLimitOverrideOff
  Else If Value = 'EquifaxRealtimeFee'	 Then Data :=  	 AccountDetailEntryCodeType.EquifaxRealtimeFee
  Else If Value = 'CreditEquifaxRealtimeFee'	 Then Data :=  	 AccountDetailEntryCodeType.CreditEquifaxRealtimeFee
  Else If Value = 'PaymentEquifaxDebit'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentEquifaxDebit
  Else If Value = 'PaymentEquifaxCredit'	 Then Data :=  	 AccountDetailEntryCodeType.PaymentEquifaxCredit
  Else If Value = 'Merged'	 Then Data :=  	 AccountDetailEntryCodeType.Merged
  Else If Value = 'AutoTraderOn'	 Then Data :=  	 AccountDetailEntryCodeType.AutoTraderOn
  Else If Value = 'AutoTraderOff'	 Then Data :=  	 AccountDetailEntryCodeType.AutoTraderOff
  Else If Value = 'PaperInvoiceOn'	 Then Data :=  	 AccountDetailEntryCodeType.PaperInvoiceOn
  Else If Value = 'PaperInvoiceOff'	 Then Data :=  	 AccountDetailEntryCodeType.PaperInvoiceOff
  Else If Value = 'AccountStateSwitch'	 Then Data :=  	 AccountDetailEntryCodeType.AccountStateSwitch
  Else If Value = 'FVFCreditReversalAutomatic'	 Then Data :=  	 AccountDetailEntryCodeType.FVFCreditReversalAutomatic
  Else If Value = 'CreditSoftOutage'	 Then Data :=  	 AccountDetailEntryCodeType.CreditSoftOutage
  Else If Value = 'LACatalogFee'	 Then Data :=  	 AccountDetailEntryCodeType.LACatalogFee
  Else If Value = 'LAExtraItem'	 Then Data :=  	 AccountDetailEntryCodeType.LAExtraItem
  Else If Value = 'LACatalogItemFeeRefund'	 Then Data :=  	 AccountDetailEntryCodeType.LACatalogItemFeeRefund
  Else If Value = 'LACatalogInsertionRefund'	 Then Data :=  	 AccountDetailEntryCodeType.LACatalogInsertionRefund
  Else If Value = 'LAFinalValueFee'	 Then Data :=  	 AccountDetailEntryCodeType.LAFinalValueFee
  Else If Value = 'LAFinalValueFeeRefund'	 Then Data :=  	 AccountDetailEntryCodeType.LAFinalValueFeeRefund
  Else If Value = 'LABuyerPremiumPercentageFee'	 Then Data :=  	 AccountDetailEntryCodeType.LABuyerPremiumPercentageFee
  Else If Value = 'LABuyerPremiumPercentageFeeRefund'	 Then Data :=  	 AccountDetailEntryCodeType.LABuyerPremiumPercentageFeeRefund
  Else If Value = 'LAAudioVideoFee'	 Then Data :=  	 AccountDetailEntryCodeType.LAAudioVideoFee
  Else If Value = 'LAAudioVideoFeeRefund'	 Then Data :=  	 AccountDetailEntryCodeType.LAAudioVideoFeeRefund
  Else If Value = 'FeeIPIXPhoto'	 Then Data :=  	 AccountDetailEntryCodeType.FeeIPIXPhoto
  Else If Value = 'FeeIPIXSlideShow'	 Then Data :=  	 AccountDetailEntryCodeType.FeeIPIXSlideShow
  Else If Value = 'CreditIPIXPhoto'	 Then Data :=  	 AccountDetailEntryCodeType.CreditIPIXPhoto
  Else If Value = 'CreditIPIXSlideShow'	 Then Data :=  	 AccountDetailEntryCodeType.CreditIPIXSlideShow
  Else If Value = 'FeeTenDayAuction'	 Then Data :=  	 AccountDetailEntryCodeType.FeeTenDayAuction
  Else If Value = 'CreditTenDayAuction'	 Then Data :=  	 AccountDetailEntryCodeType.CreditTenDayAuction
  Else If Value = 'TemporaryCredit'	 Then Data :=  	 AccountDetailEntryCodeType.TemporaryCredit
  Else If Value = 'TemporaryCreditReversal'	 Then Data :=  	 AccountDetailEntryCodeType.TemporaryCreditReversal
  Else If Value = 'SubscriptionAABasic'	 Then Data :=  	 AccountDetailEntryCodeType.SubscriptionAABasic
  Else If Value = 'SubscriptionAAPro'	 Then Data :=  	 AccountDetailEntryCodeType.SubscriptionAAPro
  Else If Value = 'CreditAABasic'	 Then Data :=  	 AccountDetailEntryCodeType.CreditAABasic
  Else If Value = 'CreditAAPro'	 Then Data :=  	 AccountDetailEntryCodeType.CreditAAPro
  Else If Value = 'FeeLargePicture'	 Then Data :=  	 AccountDetailEntryCodeType.FeeLargePicture
  Else If Value = 'CreditLargePicture'	 Then Data :=  	 AccountDetailEntryCodeType.CreditLargePicture
  Else If Value = 'FeePicturePack'	 Then Data :=  	 AccountDetailEntryCodeType.FeePicturePack
  Else If Value = 'CreditPicturePackPartial'	 Then Data :=  	 AccountDetailEntryCodeType.CreditPicturePackPartial
  Else If Value = 'CreditPicturePackFull'	 Then Data :=  	 AccountDetailEntryCodeType.CreditPicturePackFull
  Else If Value = 'SubscriptioneBayStores'	 Then Data :=  	 AccountDetailEntryCodeType.SubscriptioneBayStores
  Else If Value = 'CrediteBayStores'	 Then Data :=  	 AccountDetailEntryCodeType.CrediteBayStores
  Else If Value = 'FeeInsertionFixedPrice'	 Then Data :=  	 AccountDetailEntryCodeType.FeeInsertionFixedPrice
  Else If Value = 'CreditInsertionFixedPrice'	 Then Data :=  	 AccountDetailEntryCodeType.CreditInsertionFixedPrice
  Else If Value = 'FeeFinalValueFixedPrice'	 Then Data :=  	 AccountDetailEntryCodeType.FeeFinalValueFixedPrice
  Else If Value = 'CreditFinalValueFixedPrice'	 Then Data :=  	 AccountDetailEntryCodeType.CreditFinalValueFixedPrice
  Else If Value = 'ElectronicInvoiceOn'	 Then Data :=  	 AccountDetailEntryCodeType.ElectronicInvoiceOn
  Else If Value = 'ElectronicInvoiceOff'	 Then Data :=  	 AccountDetailEntryCodeType.ElectronicInvoiceOff
  Else If Value = 'FlagDDDDPending'	 Then Data :=  	 AccountDetailEntryCodeType.FlagDDDDPending
  Else If Value = 'FlagDDPaymentConfirmed'	 Then Data :=  	 AccountDetailEntryCodeType.FlagDDPaymentConfirmed
  Else If Value = 'FixedPriceDurationFee'	 Then Data :=  	 AccountDetailEntryCodeType.FixedPriceDurationFee
  Else If Value = 'FixedPriceDurationCredit'	 Then Data :=  	 AccountDetailEntryCodeType.FixedPriceDurationCredit
  Else If Value = 'BuyItNowFee'	 Then Data :=  	 AccountDetailEntryCodeType.BuyItNowFee
  Else If Value = 'BuyItNowCredit'	 Then Data :=  	 AccountDetailEntryCodeType.BuyItNowCredit
  Else If Value = 'FeeSchedule'	 Then Data :=  	 AccountDetailEntryCodeType.FeeSchedule
  Else If Value = 'CreditSchedule'	 Then Data :=  	 AccountDetailEntryCodeType.CreditSchedule
  Else If Value = 'SubscriptionSMBasic'	 Then Data :=  	 AccountDetailEntryCodeType.SubscriptionSMBasic
  Else If Value = 'SubscriptionSMBasicPro'	 Then Data :=  	 AccountDetailEntryCodeType.SubscriptionSMBasicPro
  Else If Value = 'CreditSMBasic'	 Then Data :=  	 AccountDetailEntryCodeType.CreditSMBasic
  Else If Value = 'CreditSMBasicPro'	 Then Data :=  	 AccountDetailEntryCodeType.CreditSMBasicPro
  Else If Value = 'StoresGTCFee'	 Then Data :=  	 AccountDetailEntryCodeType.StoresGTCFee
  Else If Value = 'StoresGTCCredit'	 Then Data :=  	 AccountDetailEntryCodeType.StoresGTCCredit
  Else If Value = 'ListingDesignerFee'	 Then Data :=  	 AccountDetailEntryCodeType.ListingDesignerFee
  Else If Value = 'ListingDesignerCredit'	 Then Data :=  	 AccountDetailEntryCodeType.ListingDesignerCredit
  Else If Value = 'ExtendedAuctionFee'	 Then Data :=  	 AccountDetailEntryCodeType.ExtendedAuctionFee
  Else If Value = 'ExtendedAcutionCredit'	 Then Data :=  	 AccountDetailEntryCodeType.ExtendedAcutionCredit
  Else If Value = 'PayPalOTPSucc'	 Then Data :=  	 AccountDetailEntryCodeType.PayPalOTPSucc
  Else If Value = 'PayPalOTPPend'	 Then Data :=  	 AccountDetailEntryCodeType.PayPalOTPPend
  Else If Value = 'PayPalFailed'	 Then Data :=  	 AccountDetailEntryCodeType.PayPalFailed
  Else If Value = 'PayPalChargeBack'	 Then Data :=  	 AccountDetailEntryCodeType.PayPalChargeBack
  Else If Value = 'ChargeBack'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeBack
  Else If Value = 'ChargeBackReversal'	 Then Data :=  	 AccountDetailEntryCodeType.ChargeBackReversal
  Else If Value = 'PayPalRefund'	 Then Data :=  	 AccountDetailEntryCodeType.PayPalRefund
  Else If Value = 'BonusPointsAddition'	 Then Data :=  	 AccountDetailEntryCodeType.BonusPointsAddition
  Else If Value = 'BonusPointsReduction'	 Then Data :=  	 AccountDetailEntryCodeType.BonusPointsReduction
  Else If Value = 'BonusPointsPaymentAutomatic'	 Then Data :=  	 AccountDetailEntryCodeType.BonusPointsPaymentAutomatic
  Else If Value = 'BonusPointsPaymentManual'	 Then Data :=  	 AccountDetailEntryCodeType.BonusPointsPaymentManual
  Else If Value = 'BonusPointsPaymentReversal'	 Then Data :=  	 AccountDetailEntryCodeType.BonusPointsPaymentReversal
  Else If Value = 'BonusPointsCashPayout'	 Then Data :=  	 AccountDetailEntryCodeType.BonusPointsCashPayout
  Else If Value = 'VATCredit'	 Then Data :=  	 AccountDetailEntryCodeType.VATCredit
  Else If Value = 'VATDebit'	 Then Data :=  	 AccountDetailEntryCodeType.VATDebit
  Else If Value = 'VATStatusChangePending'	 Then Data :=  	 AccountDetailEntryCodeType.VATStatusChangePending
  Else If Value = 'VATStatusChangeApproved'	 Then Data :=  	 AccountDetailEntryCodeType.VATStatusChangeApproved
  Else If Value = 'VATStatusChange_Denied'	 Then Data :=  	 AccountDetailEntryCodeType.VATStatusChange_Denied
  Else If Value = 'VATStatusDeletedByCSR'	 Then Data :=  	 AccountDetailEntryCodeType.VATStatusDeletedByCSR
  Else If Value = 'VATStatusDeletedByUser'	 Then Data :=  	 AccountDetailEntryCodeType.VATStatusDeletedByUser
  Else If Value = 'SMProListingDesignerFee'	 Then Data :=  	 AccountDetailEntryCodeType.SMProListingDesignerFee
  Else If Value = 'SMProListingDesignerCredit'	 Then Data :=  	 AccountDetailEntryCodeType.SMProListingDesignerCredit
  Else If Value = 'StoresSuccessfulListingFee'	 Then Data :=  	 AccountDetailEntryCodeType.StoresSuccessfulListingFee
  Else If Value = 'StoresSuccessfulListingFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.StoresSuccessfulListingFeeCredit
  Else If Value = 'StoresReferralFee'	 Then Data :=  	 AccountDetailEntryCodeType.StoresReferralFee
  Else If Value = 'StoresReferralCredit'	 Then Data :=  	 AccountDetailEntryCodeType.StoresReferralCredit
  Else If Value = 'SubtitleFee'	 Then Data :=  	 AccountDetailEntryCodeType.SubtitleFee
  Else If Value = 'SubtitleFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.SubtitleFeeCredit
  Else If Value = 'eBayStoreInventorySubscriptionCredit'	 Then Data :=  	 AccountDetailEntryCodeType.EBayStoreInventorySubscriptionCredit
  Else If Value = 'AutoPmntReqExempt'	 Then Data :=  	 AccountDetailEntryCodeType.AutoPmntReqExempt
  Else If Value = 'AutoPmntReqRein'	 Then Data :=  	 AccountDetailEntryCodeType.AutoPmntReqRein
  Else If Value = 'PictureManagerSubscriptionFee'	 Then Data :=  	 AccountDetailEntryCodeType.PictureManagerSubscriptionFee
  Else If Value = 'PictureManagerSubscriptionFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.PictureManagerSubscriptionFeeCredit
  Else If Value = 'SellerReportsBasicFee'	 Then Data :=  	 AccountDetailEntryCodeType.SellerReportsBasicFee
  Else If Value = 'SellerReportsBasicCredit'	 Then Data :=  	 AccountDetailEntryCodeType.SellerReportsBasicCredit
  Else If Value = 'SellerReportsPlusFee'	 Then Data :=  	 AccountDetailEntryCodeType.SellerReportsPlusFee
  Else If Value = 'SellerReportsPlusCredit'	 Then Data :=  	 AccountDetailEntryCodeType.SellerReportsPlusCredit
  Else If Value = 'PaypalOnFile'	 Then Data :=  	 AccountDetailEntryCodeType.PaypalOnFile
  Else If Value = 'PaypalOnFileByCSR'	 Then Data :=  	 AccountDetailEntryCodeType.PaypalOnFileByCSR
  Else If Value = 'PaypalOffFile'	 Then Data :=  	 AccountDetailEntryCodeType.PaypalOffFile
  Else If Value = 'BorderFee'	 Then Data :=  	 AccountDetailEntryCodeType.BorderFee
  Else If Value = 'BorderFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.BorderFeeCredit
  Else If Value = 'FeeSearchableMobileDE'	 Then Data :=  	 AccountDetailEntryCodeType.FeeSearchableMobileDE
  Else If Value = 'SalesReportsPlusFee'	 Then Data :=  	 AccountDetailEntryCodeType.SalesReportsPlusFee
  Else If Value = 'SalesReportsPlusCredit'	 Then Data :=  	 AccountDetailEntryCodeType.SalesReportsPlusCredit
  Else If Value = 'CreditSearchableMobileDE'	 Then Data :=  	 AccountDetailEntryCodeType.CreditSearchableMobileDE
  Else If Value = 'EmailMarketingFee'	 Then Data :=  	 AccountDetailEntryCodeType.EmailMarketingFee
  Else If Value = 'EmailMarketingCredit'	 Then Data :=  	 AccountDetailEntryCodeType.EmailMarketingCredit
  Else If Value = 'FeePictureShow'	 Then Data :=  	 AccountDetailEntryCodeType.FeePictureShow
  Else If Value = 'CreditPictureShow'	 Then Data :=  	 AccountDetailEntryCodeType.CreditPictureShow
  Else If Value = 'ProPackBundleFee'	 Then Data :=  	 AccountDetailEntryCodeType.ProPackBundleFee
  Else If Value = 'ProPackBundleFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.ProPackBundleFeeCredit
  Else If Value = 'BasicUpgradePackBundleFee'	 Then Data :=  	 AccountDetailEntryCodeType.BasicUpgradePackBundleFee
  Else If Value = 'BasicUpgradePackBundleFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.BasicUpgradePackBundleFeeCredit
  Else If Value = 'ValuePackBundleFee'	 Then Data :=  	 AccountDetailEntryCodeType.ValuePackBundleFee
  Else If Value = 'ValuePackBundleFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.ValuePackBundleFeeCredit
  Else If Value = 'ProPackPlusBundleFee'	 Then Data :=  	 AccountDetailEntryCodeType.ProPackPlusBundleFee
  Else If Value = 'ProPackPlusBundleFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.ProPackPlusBundleFeeCredit
  Else If Value = 'FinalEntry'	 Then Data :=  	 AccountDetailEntryCodeType.FinalEntry
  Else If Value = 'CustomCode'	 Then Data :=  	 AccountDetailEntryCodeType.CustomCode
  Else If Value = 'ExtendedDurationFee'	 Then Data :=  	 AccountDetailEntryCodeType.ExtendedDurationFee
  Else If Value = 'ExtendedDurationFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.ExtendedDurationFeeCredit
  Else If Value = 'InternationalListingFee'	 Then Data :=  	 AccountDetailEntryCodeType.InternationalListingFee
  Else If Value = 'InternationalListingCredit'	 Then Data :=  	 AccountDetailEntryCodeType.InternationalListingCredit
  Else If Value = 'MarketplaceResearchExpiredSubscriptionFee'	 Then Data :=  	 AccountDetailEntryCodeType.MarketplaceResearchExpiredSubscriptionFee
  Else If Value = 'MarketplaceResearchExpiredSubscriptionFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.MarketplaceResearchExpiredSubscriptionFeeCredit
  Else If Value = 'MarketplaceResearchBasicSubscriptionFee'	 Then Data :=  	 AccountDetailEntryCodeType.MarketplaceResearchBasicSubscriptionFee
  Else If Value = 'MarketplaceResearchBasicSubscriptionFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.MarketplaceResearchBasicSubscriptionFeeCredit
  Else If Value = 'MarketplaceResearchProSubscriptionFee'	 Then Data :=  	 AccountDetailEntryCodeType.MarketplaceResearchProSubscriptionFee
  Else If Value = 'BasicBundleFee'	 Then Data :=  	 AccountDetailEntryCodeType.BasicBundleFee
  Else If Value = 'BasicBundleFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.BasicBundleFeeCredit
  Else If Value = 'MarketplaceResearchProSubscriptionFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.MarketplaceResearchProSubscriptionFeeCredit
  Else If Value = 'VehicleLocalSubscriptionFee'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalSubscriptionFee
  Else If Value = 'VehicleLocalSubscriptionFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalSubscriptionFeeCredit
  Else If Value = 'VehicleLocalInsertionFee'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalInsertionFee
  Else If Value = 'VehicleLocalInsertionFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalInsertionFeeCredit
  Else If Value = 'VehicleLocalFinalValueFee'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalFinalValueFee
  Else If Value = 'VehicleLocalFinalValueFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalFinalValueFeeCredit
  Else If Value = 'VehicleLocalGTCFee'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalGTCFee
  Else If Value = 'VehicleLocalGTCFeeCredit'	 Then Data :=  	 AccountDetailEntryCodeType.VehicleLocalGTCFeeCredit
  Else If Value = 'eBayMotorsProFee'	 Then Data :=  	 AccountDetailEntryCodeType.EBayMotorsProFee
  Else If Value = 'CrediteBayMotorsProFee'	 Then Data :=  	 AccountDetailEntryCodeType.CrediteBayMotorsProFee
  Else If Value = 'eBayMotorsProFeatureFee'	 Then Data :=  	 AccountDetailEntryCodeType.EBayMotorsProFeatureFee
  Else If Value = 'CrediteBayMotorsProFeatureFee'	 Then Data :=  	 AccountDetailEntryCodeType.CrediteBayMotorsProFeatureFee
  Else If Value = 'FeeGalleryPlus'	 Then Data :=  	 AccountDetailEntryCodeType.FeeGalleryPlus
  Else If Value = 'CreditGalleryPlus'	 Then Data :=  	 AccountDetailEntryCodeType.CreditGalleryPlus
  Else If Value = 'PrivateListing'	 Then Data :=  	 AccountDetailEntryCodeType.PrivateListing
  Else If Value = 'CreditPrivateListing'	 Then Data :=  	 AccountDetailEntryCodeType.CreditPrivateListing
  Else If Value = 'ImmoProFee'	 Then Data :=  	 AccountDetailEntryCodeType.ImmoProFee
  Else If Value = 'CreditImmoProFee'	 Then Data :=  	 AccountDetailEntryCodeType.CreditImmoProFee
  Else If Value = 'ImmoProFeatureFee'	 Then Data :=  	 AccountDetailEntryCodeType.ImmoProFeatureFee
  Else If Value = 'CreditImmoProFeatureFee'	 Then Data :=  	 AccountDetailEntryCodeType.CreditImmoProFeatureFee
  Else If Value = 'RealEstateProFee'	 Then Data :=  	 AccountDetailEntryCodeType.RealEstateProFee
  Else If Value = 'CreditRealEstateProFee'	 Then Data :=  	 AccountDetailEntryCodeType.CreditRealEstateProFee
  Else If Value = 'RealEstateProFeatureFee'	 Then Data :=  	 AccountDetailEntryCodeType.RealEstateProFeatureFee
  Else If Value = 'CreditRealEstateProFeatureFee'	 Then Data :=  	 AccountDetailEntryCodeType.CreditRealEstateProFeatureFee
  Else If Value = 'Discount'	 Then Data :=  	 AccountDetailEntryCodeType.Discount
  Else If Value = 'CreditFinalValueShipping'	 Then Data :=  	 AccountDetailEntryCodeType.CreditFinalValueShipping
  Else If Value = 'FeeFinalValueShipping'	 Then Data :=  	 AccountDetailEntryCodeType.FeeFinalValueShipping
  Else If Value = 'FeeReturnShipping'	 Then Data :=  	 AccountDetailEntryCodeType.FeeReturnShipping
  Else If Value = 'CreditReturnShipping'	 Then Data :=  	 AccountDetailEntryCodeType.CreditReturnShipping
  Else If Value = 'FeeGlobalShippingProgram'	 Then Data :=  	 AccountDetailEntryCodeType.FeeGlobalShippingProgram
  Else If Value = 'CreditGlobalShippingProgram'	 Then Data :=  	 AccountDetailEntryCodeType.CreditGlobalShippingProgram
  Else If Value = 'FeeAuctionEndEarly'	 Then Data :=  	 AccountDetailEntryCodeType.FeeAuctionEndEarly
  Else If Value = 'CreditAuctionEndEarly'	 Then Data :=  	 AccountDetailEntryCodeType.CreditAuctionEndEarly
  Else If Value = 'FeeFedExShippingLabel'	 Then Data :=  	 AccountDetailEntryCodeType.FeeFedExShippingLabel
  Else If Value = 'CreditFedExShippingLabel'	 Then Data :=  	 AccountDetailEntryCodeType.CreditFedExShippingLabel
  Else If Value = 'FeeReturnRefund'	 Then Data :=  	 AccountDetailEntryCodeType.FeeReturnRefund
  Else If Value = 'CreditReturnRefund'	 Then Data :=  	 AccountDetailEntryCodeType.CreditReturnRefund
  Else If Value = 'FeeStoresSubscriptionEarlyTermination'	 Then Data :=  	 AccountDetailEntryCodeType.FeeStoresSubscriptionEarlyTermination
  Else If Value = 'CreditStoresSubscriptionEarlyTermination'	 Then Data :=  	 AccountDetailEntryCodeType.CreditStoresSubscriptionEarlyTermination
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AccountStateCodeType);
Begin
       If Value ='Active'	 Then Data :=  	 AccountStateCodeType.Active
  Else If Value = 'Pending'	 Then Data :=  	 AccountStateCodeType.Pending
  Else If Value = 'Inactive'	 Then Data :=  	 AccountStateCodeType.Inactive
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : MeasurementSystemCodeType);
Begin
       If Value ='English'	 Then Data :=  	 MeasurementSystemCodeType.English
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SellerPaymentMethodCodeType);
Begin
       If Value ='NothingOnFile'	 Then Data :=  	 SellerPaymentMethodCodeType.NothingOnFile
  Else If Value = 'CreditCard'	 Then Data :=  	 SellerPaymentMethodCodeType.CreditCard
  Else If Value = 'PayPal'	 Then Data :=  	 SellerPaymentMethodCodeType.PayPal
  Else If Value = 'DirectDebit'	 Then Data :=  	 SellerPaymentMethodCodeType.DirectDebit
  Else If Value = 'DirectDebitPendingSignatureMandate'	 Then Data :=  	 SellerPaymentMethodCodeType.DirectDebitPendingSignatureMandate
  Else If Value = 'eBayDirectPay'	 Then Data :=  	 SellerPaymentMethodCodeType.EBayDirectPay
  Else If Value = 'CustomCode'	 Then Data :=  	 SellerPaymentMethodCodeType.CustomCode
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AddressOwnerCodeType);
Begin
       If Value ='PayPal'	 Then Data :=  	 AddressOwnerCodeType.PayPal
  Else If Value = 'eBay'	 Then Data :=  	 AddressOwnerCodeType.EBay
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AddressStatusCodeType);
Begin
       If Value ='None'	 Then Data :=  	 AddressStatusCodeType.None
  Else If Value = 'Confirmed'	 Then Data :=  	 AddressStatusCodeType.Confirmed
  Else If Value = 'Unconfirmed'	 Then Data :=  	 AddressStatusCodeType.Unconfirmed
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AddressRecordTypeCodeType);
Begin
       If Value ='Residential'	 Then Data :=  	 AddressRecordTypeCodeType.Residential
  Else If Value = 'Business'	 Then Data :=  	 AddressRecordTypeCodeType.Business
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AdFormatLeadStatusCodeType);
Begin
       If Value ='New'	 Then Data :=  	 AdFormatLeadStatusCodeType.New
  Else If Value = 'Responded'	 Then Data :=  	 AdFormatLeadStatusCodeType.Responded
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : StoreCategoryUpdateActionCodeType);
Begin
       If Value ='Add'	 Then Data :=  	 StoreCategoryUpdateActionCodeType.Add
  Else If Value = 'Delete'	 Then Data :=  	 StoreCategoryUpdateActionCodeType.Delete
  Else If Value = 'Move'	 Then Data :=  	 StoreCategoryUpdateActionCodeType.Move
  Else If Value = 'Rename'	 Then Data :=  	 StoreCategoryUpdateActionCodeType.Rename
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : ModifyActionCodeType);
Begin
       If Value ='Add'	 Then Data :=  	 ModifyActionCodeType.Add
  Else If Value = 'Delete'	 Then Data :=  	 ModifyActionCodeType.Delete
  Else If Value = 'Update'	 Then Data :=  	 ModifyActionCodeType.Update
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : AutomatedLeaveFeedbackEventCodeType);
Begin
       If Value ='PositiveFeedbackReceived'	 Then Data :=  	 AutomatedLeaveFeedbackEventCodeType.PositiveFeedbackReceived
  Else If Value = 'PaymentReceived'	 Then Data :=  	 AutomatedLeaveFeedbackEventCodeType.PaymentReceived
  Else If Value = 'None'	 Then Data :=  	 AutomatedLeaveFeedbackEventCodeType.None
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : SetUserNotesActionCodeType);
Begin
       If Value ='AddOrUpdate'	 Then Data :=  	 SetUserNotesActionCodeType.AddOrUpdate
  Else If Value = 'Delete'	 Then Data :=  	 SetUserNotesActionCodeType.Delete
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PictureUploadPolicyCodeType);
Begin
       If Value ='Add'	 Then Data :=  	 PictureUploadPolicyCodeType.Add
  Else If Value = 'ClearAndAdd'	 Then Data :=  	 PictureUploadPolicyCodeType.ClearAndAdd
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PictureWatermarkCodeType);
Begin
       If Value ='User'	 Then Data :=  	 PictureWatermarkCodeType.User
  Else If Value = 'Icon'	 Then Data :=  	 PictureWatermarkCodeType.Icon
  {Else Result  := 	 ''};
End;

Procedure StrToEnum(Const Value: String ; Var Data : PictureSetCodeType);
Begin
       If Value ='Standard'	 Then Data :=  	 PictureSetCodeType.Standard
  Else If Value = 'Supersize'	 Then Data :=  	 PictureSetCodeType.Supersize
  Else If Value = 'Large'	 Then Data :=  	 PictureSetCodeType.Large
  {Else Result  := 	 ''};
End;
function ProviderTypeToStr(aProvider: Integer): string;
begin
          if aProvider =0 then Result := 'FedEx'
     else if aProvider =1 then Result := 'UPS'
     else if aProvider =2 then Result := 'US Postal Service'
     else Result := 'Canada Post';
end;

End.
