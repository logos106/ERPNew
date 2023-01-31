unit ShipIntegrationTypes;

interface

uses
  ibxezship, SysUtils, ibxupsship;

type

  TAddress = class(TObject)
  public
    AddressLine1: string;
    AddressLine2: string;
    AddressLine3: string;
    City: string;
    State: string;
    PostCode: string;
    Country: string;
    CountryCode: string;
    Updated: boolean;
  end;

  TShipperType = (spNone, spFedEx, spUPS, spUSPS, spCanadaPost, spTNT);

  TShipperError = class
  public
    ErrorNumber: string;
    ErrorName: string;
    ErrorNameHuman: string;
    ErrorCode: string;
    ErrorDesc: string;
    constructor Create(ex: exception);
  end;

  TSpecialServiceRec = record
    Flag: Int64;
    Name: string;
  end;

  TProviderRec = record
    Provider: TibxezshipProviders;
    Name: string;
  end;

  TUPSShipServiceTypeRec = record
    Service: TibxupsshipServiceTypes;
    Name: string;
  end;

  TPackageProvider = (ppFedEx, ppUPS, ppUSPS, ppCanadaPost, ppUSPSEndicia, ppUSPSStamps);
  TShipServiceOption = (ssoUSDomestic, ssoUSIntl, ssoMailInnovations);
  TShipServiceOptionSet = set of TShipServiceOption;

  TShipServiceTypeRec = record
    Service: TibxezshipServiceTypes;
    Name: string;
    Providers: set of TPackageProvider;
    Options: TShipServiceOptionSet;
  end;

  TPackageTypeRec = record
    Package: TibxezshipPackageTypes;
    Name: string;
    Providers: set of TPackageProvider;
  end;

  TCodeTypeRec = record
    Code: integer;
    Name: string;
  end;

  TShipLabelImageFormatRec = record
    ImageType: TibxezshipLabelImageTypes;
    Name: string;
    Providers: set of TPackageProvider;
  end;

  TUPSShipLabelImageFormatRec = record
    ImageType: TibxupsshipLabelImageTypes;
    Name: string;
  end;

  TPayorTypeRec = record
    Payor: TibxezshipPayorTypes;
    Name: string;
  end;

  TPackageCODTypeRec = record
    COD: TibxezshipPackageCODTypes;
    Name: string;
    Providers: set of TPackageProvider;
  end;

  TPackageSignatureTypeRec = record
    Signature: TibxezshipPackageSignatureTypes;
    Name: string;
    Providers: set of TPackageProvider;
  end;

  TUPSEndorsementRec = record
    Id: word;
    Name: string;
  end;

  function ProviderTypeToStr(aProvider: TibxezshipProviders): string;
  function StrToProviderType(aProvider: string): TibxezshipProviders;

  function ShipServiceTypeToStr(aService: TibxezshipServiceTypes): string;
  function StrToShipServiceType(aService: string): TibxezshipServiceTypes;

(*
  function UPSServiceTypeToStr(aService: TibxupsshipServiceTypes): string;
  function StrToUPSServiceType(aService: string): TibxupsshipServiceTypes;
*)

  function PackageTypeToStr(Packaging: TibxezshipPackageTypes): string;
  function StrToPackageType(Packaging: string): TibxezshipPackageTypes; overload;

  function StrToPackageType(Packaging: string; PackageProvider: TPackageProvider): TibxezshipPackageTypes; overload;

  function ImageTypeToStr(ImageType: TibxezshipLabelImageTypes): string;
  function StrToImageType(ImageType: string): TibxezshipLabelImageTypes;

  function UPSImageTypeToStr(ImageType: TibxupsshipLabelImageTypes): string;
  function StrToUPSImageType(ImageType: string): TibxupsshipLabelImageTypes;

  function PayorTypeToStr(PayorType: TibxezshipPayorTypes): string;
  function StrToPayorType(PayorType: string): TibxezshipPayorTypes;

  function IsUPSMailInnovations(ServiceType: TibxezshipServiceTypes): Boolean;

  function FedExImageTypeToStr(ImageType: integer): string;
  function FedExImageTypeToExtStr(ImageType: integer): string;
  function FedExStrToImageType(ImageTypeStr: string): integer;

  function PackageCODTypeToStr(aType: TibxezshipPackageCODTypes): string;

  function SignatureTypeToStr(aType: TibxezshipPackageSignatureTypes): string;
  Function intToPackageProvider(Const Value:Integer):TPackageProvider;

  function PackageProviderToStr(Value: TPackageProvider): string;Overload;
  function PackageProviderToStr(Value: TibxezShipProviders): string;Overload;

//  function TibxupsshipServiceTypes

(*  function  FedExServicetypes: Array of String;
  function  UPSServicetypes:Array of String;
  function  USPostalServiceServicetypes:Array of String;
  function  CanadaPostServicetypes:Array of String;
  function  ServicetypeForProvider(Const Provider:TPackageProvider):Array of String;*)

const

  UPSSpecialServiceList: array [0..11] of TSpecialServiceRec =
  (
     (Flag: $00000004;          Name: 'COD'),
     (Flag: $00008000;          Name: 'Hold At Location'),
     (Flag: $00100000;          Name: 'Liftgate Delivery'),
     (Flag: $00200000;          Name: 'Liftgate Pickup'),
     (Flag: $08000000;          Name: 'Return Shipment'),
     (Flag: $10000000;          Name: 'Saturday Delivery'),
     (Flag: $0000020000000000;  Name: 'Return of Document'),
     (Flag: $0000040000000000;  Name: 'Import Control'),
     (Flag: $0000080000000000;  Name: 'Commercial Invoice Removal'),
     (Flag: $0000100000000000;  Name: 'Exchange Forward'),
     (Flag: $0000200000000000;  Name: 'Carbon Neutral'),
     (Flag: $0000400000000000;  Name: 'Dropoff at UPS Facility')
  );

(*
  PackageSpecialServiceList: array [0..1] of TSpecialServiceRec =
  (
     (Flag: $00000001;          Name: 'Appointment Deliery'),

     (Flag: $00000010;          Name: 'Non Standard Container'),
     (Flag: $00000040;          Name: 'Additional Handling')
  );
*)

(*  Package Special Service Options                               FedEx UPS   *)
  OptAppointmentDelivery =  $00000001; //  Appointment Delivery   X
  OptDangerousGoods =       $00000002; //  Dangerous Goods        X
  OptDryIce =               $00000004; //  Dry Ice                X
  OptyPriorityAlert =       $00000008; //  Priority Alert         X
  OptNonStandardContainer = $00000010; //  Non Standard Container X     X
  OptCOD =                  $00000020; //  COD                    X
  OptAdditionalHandling =   $00000040; //  Additional Handling    X     X
  OptSignatureOption =      $00000080; //  Signature Option       X
  OptAlcohol =              $00000100; //  Alcohol                X

  OptAppointmentDeliveryBit =   0;     //  Appointment Delivery   X
  OptDangerousGoodsBit =        1;     //  Dangerous Goods        X
  OptDryIceBit =                2;     //  Dry Ice                X
  OptPriorityAlertBit =         3;     //  Priority Alert         X
  OptNonStandardContainerBit =  4;     //  Non Standard Container X     X
  OptCODBit =                   5;     //  COD                    X
  OptAdditionalHandlingBit =    6;     //  Additional Handling    X     X
  OptSignatureOptionBit =       7;     //  Signature Option       X
  OptAlcoholBit =               8;     //  Alcohol                X

  { FedEx Shipment Special Services }
  ssBrokerSelect =                              0;
  ssCallBeforeDelivery =                        1;
  ssCOD =                                       2;
  ssCustomDeliveryWindow =                      3;
  ssDangeriousGoods =                           4;
  ssDoNotBreakDownPallets =                     5;
  ssDoNotStackPallets =                         6;
  ssDryIce =                                    7;
  ssEastCoastSpecial =                          8;
  ssElectronicTradeDocuments =                  9;
  ssEmailNotification =                         10;
  ssExtreamLength =                             11;
  ssFood =                                      12;
  ssFreightGuarantee =                          13;
  ssFutureDay =                                 14;
  ssHoldAtLocation =                            15;
  ssInternationalControlledExportService =      16;
  ssHomeDeliveryPremium =                       17;
  ssInsideDelivery =                            18;
  ssInsidePickup =                              19;
  ssLiftgateDelivery =                          20;
  ssLiftgatePickup =                            21;
  ssLimitedAccessDelivery =                     22;
  ssLimitedAccessPickup =                       23;
  ssPendingShipment =                           24;
  ssPoison =                                    25;
  ssProtectionFromFreezing =                    26;
  ssReturnShipment =                            27;
  ssSaturdayDelivery =                          28;
  ssSaturdayPickup =                            29;
  ssTopLoad =                                   30;
  ssInternationalTrafficinArmsRegulations =     31;




  ShipProviderList: array [0..3] of TProviderRec =
  (
     (Provider: pFedEx;          Name: 'FedEx'),
     (Provider: pUPS;            Name: 'UPS'),
     (Provider: pUSPS;           Name: 'US Postal Service'),
     (Provider: pCanadaPost;     Name: 'Canada Post')
  );


  UPSShipServiceTypeList: array[0..104] of TUPSShipServiceTypeRec =
  (
    (Service: stUnspecified;                              Name: 'Unspecified'),
    (Service: stFedExPriorityOvernight;                   Name: 'FedEx Priority Overnight'),
    (Service: stFedExStandardOvernight;                   Name: 'FedEx Standard Overnight'),
    (Service: stFedExFirstOvernight;                      Name: 'FedEx First Overnight'),
    (Service: stFedEx2Day;                                Name: 'FedEx 2 Day'),
    (Service: stFedExExpressSaver;                        Name: 'FedEx Express Saver'),
    (Service: stFedExGround;                              Name: 'FedEx Ground'),
    (Service: stFedExGroundHomeDelivery;                  Name: 'FedEx Ground Home Delivery'),
    (Service: stFedEx1DayFreight;                         Name: 'FedEx 1 Day Freight'),
    (Service: stFedEx2DayFreight;                         Name: 'FedEx 2 Day Freight'),
    (Service: stFedEx3DayFreight;                         Name: 'FedEx 3 Day Freight'),
    (Service: stFedExInternationalPriority;               Name: 'FedEx International Priority'),
    (Service: stFedExInternationalEconomy;                Name: 'FedEx International Economy'),
    (Service: stFedExInternationalFirst;                  Name: 'FedEx International First'),
    (Service: stFedExInternationalPriorityFreight;        Name: 'FedEx International Priority Freight'),
    (Service: stFedExInternationalEconomyFreight;         Name: 'FedEx International Economy Freight'),
    (Service: stFedExEuropeFirstInternationalPriority;    Name: 'FedEx Europe First International Priority'),
    (Service: stFedExSmartPost;                           Name: 'FedEx Smart Post'),
    (Service: stFedEx2DayAM;                              Name: 'FedEx 2 Day AM'),
    (Service: stFedExFirstFreight;                        Name: 'FedEx First Freight'),
    (Service: stFedExInternationalGround;                 Name: 'FedEx International Ground'),
    (Service: stFedExFreightEconomy;                      Name: 'FedEx Freight Economy'),
    (Service: stFedExFreightPriority;                     Name: 'FedEx Freight Priority'),
    (Service: stUPSFirstClass;                            Name: 'UPS First Class'),
    (Service: stUPSPriorityMail;                          Name: 'UPS Priority Mail'),
    (Service: stUPSExpeditedMailInnovations;              Name: 'UPS Expedited Mail Innovations'),
    (Service: stUPSPriorityMailInnovations;               Name: 'UPS Priority Mail Innovations'),
    (Service: stUPSEconomyMailInnovations;                Name: 'UPS Economy Mail Innovations'),
    (Service: stUPSNextDayAir;                            Name: 'UPS Next Day Air'),
    (Service: stUPSExpress;                               Name: 'UPS Express'),
    (Service: stUPS2ndDayAir;                             Name: 'UPS 2nd Day Air'),
    (Service: stUPSGround;                                Name: 'UPS Ground'),
    (Service: stUPSWorldwideExpress;                      Name: 'UPS Worldwide Express'),
    (Service: stUPSWorldwideExpedited;                    Name: 'UPS Worldwide Expedited'),
    (Service: stUPSExpedited;                             Name: 'UPS Expedited'),
    (Service: stUPSStandard;                              Name: 'UPS Standard'),
    (Service: stUPS3DaySelect;                            Name: 'UPS 3 Day Select'),
    (Service: stUPSNextDayAirSaver;                       Name: 'UPS Next Day Air Saver'),
    (Service: stUPSSaver;                                 Name: 'UPS Saver'),
    (Service: stUPSNextDayAirEarlyAM;                     Name: 'UPS Next Day Air Early AM'),
    (Service: stUPSExpressEarlyAM;                        Name: 'UPS Express Early AM'),
    (Service: stUPSWorldwideExpressPlus;                  Name: 'UPS Worldwide Express Plus'),
    (Service: stUPSExpressPlus;                           Name: 'UPS Express Plus'),
    (Service: stUPS2ndDayAirAM;                           Name: 'UPS 2nd Day Air AM'),
    (Service: stUPSTodayStandard;                         Name: 'UPS Today Standard'),
    (Service: stUPSTodayCourrier;                         Name: 'UPS Today Courrier'),
    (Service: stUPSTodayInterCity;                        Name: 'UPS Today Inter City'),
    (Service: stUPSTodayExpress;                          Name: 'UPS Today Express'),
    (Service: stUPSTodayExpressSaver;                     Name: 'UPS Today Express Saver'),
    (Service: stUPSWorldwideExpressFreight;               Name: 'UPS Worldwide Express Freight'),
    (Service: stUPSSurePostLessThan1LB;                   Name: 'UPS Sure Post Less Than 1 LB'),
    (Service: stUPSSurePost1LBOrGreater;                  Name: 'UPS Sure Post 1 LB Or Greater'),
    (Service: stUPSSurePostBPM;                           Name: 'UPS Sure Post BPM'),
    (Service: stUPSSurePostMedia;                         Name: 'UPS Sure Post Media'),
    (Service: stUSPSExpress;                              Name: 'USPS Express'),
    (Service: stUSPSFirstClass;                           Name: 'USPS First Class'),
    (Service: stUSPSPriority;                             Name: 'USPS Priority'),
    (Service: stUSPSParcelPost;                           Name: 'USPS Parcel Post'),
    (Service: stUSPSMedia;                                Name: 'USPS Media'),
    (Service: stUSPSLibrary;                              Name: 'USPS Library'),
    (Service: stUSPSOnline;                               Name: 'USPS Online'),
    (Service: stUSPSGlobalExpress;                        Name: 'USPS Global Express'),
    (Service: stUSPSParcelSelect;                         Name: 'USPS Parcel Select'),
    (Service: stUSPSCriticalMail;                         Name: 'USPS Critical Mail'),
    (Service: stUSPSStandardMail;                         Name: 'USPS Standard Mail'),
    (Service: stUSPSExpressMailInternational;             Name: 'USPS Express Mail International'),
    (Service: stUSPSFirstClassMailInternational;          Name: 'USPS First Class Mail International'),
    (Service: stUSPSPriorityMailInternational;            Name: 'USPS Priority Mail International'),
    (Service: stUSPSPriorityExpress;                      Name: 'USPS Priority Express'),
    (Service: stUSPSRetailGround;                         Name: 'USPS Retail Ground'),
    (Service: stUSPSFirstClassPackageInternationalService;Name: 'USPS First Class Package International Service'),
    (Service: stUSPSPriorityMailExpressInternational;     Name: 'USPS Priority Mail Express International'),
    (Service: stCanadaRegularParcel;                      Name: 'Canada Regular Parcel'),
    (Service: stCanadaExpeditedParcel;                    Name: 'Canada Expedited Parcel'),
    (Service: stCanadaXpresspost;                         Name: 'Canada Xpress post'),
    (Service: stCanadaLibrary;                            Name: 'Canada Library'),
    (Service: stCanadaPriority;                           Name: 'Canada Priority'),
    (Service: stCanadaPriorityEnvelopeUSA;                Name: 'Canada Priority Envelope USA'),
    (Service: stCanadaPriorityPakUSA;                     Name: 'Canada Priority Pak USA'),
    (Service: stCanadaPriorityParcelUSA;                  Name: 'Canada Priority Parcel USA'),
    (Service: stCanadaXpresspostUSA;                      Name: 'Canada Xpress post USA'),
    (Service: stCanadaExpeditedParcelUSA;                 Name: 'Canada Expedited Parcel USA'),
    (Service: stCanadaSmallPacketAirUSA;                  Name: 'Canada Small Packet Air USA'),
    (Service: stCanadaTrackedPacketUSA;                   Name: 'Canada Tracked Packet USA'),
    (Service: stCanadaTrackedPacketLVMUSA;                Name: 'Canada Tracked Packet LVM USA'),
    (Service: stCanadaPriorityEnvelopeInternational;      Name: 'Canada Priority Envelope International'),
    (Service: stCanadaPriorityPakInternational;           Name: 'Canada Priority Pak International'),
    (Service: stCanadaPriorityParcelInternational;        Name: 'Canada Priority Parcel International'),
    (Service: stCanadaXpresspostInternational;            Name: 'Canada Xpress post International'),
    (Service: stCanadaSmallPacketAirInternational;        Name: 'Canada Small Packet Air International'),
    (Service: stCanadaSmallPacketLandInternational;       Name: 'Canada Small Packet Land International'),
    (Service: stCanadaParcelAirInternational;             Name: 'Canada Parcel Air International'),
    (Service: stCanadaParcelLandInternational;            Name: 'Canada Parcel Land International'),
    (Service: stCanadaTrackedPacketInternational;         Name: 'Canada Tracked Packet International'),
    (Service: stFedExDistanceDeferred;                    Name: 'FedEx Distance Deferred'),
    (Service: stFedExNextDayAfternoon;                    Name: 'FedEx Next Day Afternoon'),
    (Service: stFedExNextDayEarlyMorning;                 Name: 'FedEx Next Day Early Morning'),
    (Service: stFedExNextDayEndOfDay;                     Name: 'FedEx Next Day End Of Day'),
    (Service: stFedExNextDayFreight;                      Name: 'FedEx Next Day Freight'),
    (Service: stFedExNextDayMidMorning;                   Name: 'FedEx Next Day Mid Morning'),
    (Service: stFedExSameDay;                             Name: 'FedEx Same Day'),
    (Service: stFedExSameDayCity;                         Name: 'FedEx Same Day City'),
    (Service: stFedExSameDayMetroAfternoon;               Name: 'FedEx Same Day Metro Afternoon'),
    (Service: stFedExSameDayMetroMorning;                 Name: 'FedEx Same Day Metro Morning'),
    (Service: stFedExSameDayMetroRush;                    Name: 'FedEx Same Day Metro Rush')
  );

  ShipServiceTypeList: array[0..89] of TShipServiceTypeRec =
  (
    (Service: ibxezship.stUnspecified;                            Name: 'Unspecified';                              Providers: []),
    (Service: ibxezship.stFedExPriorityOvernight;                 Name: 'FedEx Priority Overnight';                 Providers: [ppFedEx]),
    (Service: ibxezship.stFedExStandardOvernight;                 Name: 'FedEx Standard Overnight';                 Providers: [ppFedEx]),
    (Service: ibxezship.stFedExFirstOvernight;                    Name: 'FedEx First Overnight';                    Providers: [ppFedEx]),
    (Service: ibxezship.stFedEx2Day;                              Name: 'FedEx 2 Day';                              Providers: [ppFedEx]),
    (Service: ibxezship.stFedExExpressSaver;                      Name: 'FedEx Express Saver';                      Providers: [ppFedEx]),
    (Service: ibxezship.stFedExGround;                            Name: 'FedEx Ground';                             Providers: [ppFedEx]),
    (Service: ibxezship.stFedExGroundHomeDelivery;                Name: 'FedEx Ground Home Delivery';               Providers: [ppFedEx]),
    (Service: ibxezship.stFedEx1DayFreight;                       Name: 'FedEx 1 Day Freight';                      Providers: [ppFedEx]),
    (Service: ibxezship.stFedEx2DayFreight;                       Name: 'FedEx 2 Day Freight';                      Providers: [ppFedEx]),
    (Service: ibxezship.stFedEx3DayFreight;                       Name: 'FedEx 3 Day Freight';                      Providers: [ppFedEx]),
    (Service: ibxezship.stFedExInternationalPriority;             Name: 'FedEx International Priority';             Providers: [ppFedEx]),
    (Service: ibxezship.stFedExInternationalEconomy;              Name: 'FedEx International Economy';              Providers: [ppFedEx]),
    (Service: ibxezship.stFedExInternationalFirst;                Name: 'FedEx International First';                Providers: [ppFedEx]),
    (Service: ibxezship.stFedExInternationalPriorityFreight;      Name: 'FedEx International Priority Freight';     Providers: [ppFedEx]),
    (Service: ibxezship.stFedExInternationalEconomyFreight;       Name: 'FedEx International Economy Freight';      Providers: [ppFedEx]),
    (Service: ibxezship.stFedExEuropeFirstInternationalPriority;  Name: 'FedEx Europe First International Priority';Providers: [ppFedEx]),
    (Service: ibxezship.stFedExSmartPost;                         Name: 'FedEx Smart Post';                         Providers: [ppFedEx]),
    (Service: ibxezship.stFedEx2DayAM;                            Name: 'FedEx 2 Day AM';                           Providers: [ppFedEx]),
    (Service: ibxezship.stFedExFirstFreight;                      Name: 'FedEx First Freight';                      Providers: [ppFedEx]),
    (Service: ibxezship.stFedExInternationalGround;               Name: 'FedEx International Ground';               Providers: [ppFedEx]),
    (Service: ibxezship.stFedExFreightEconomy;                    Name: 'FedEx Freight Economy';                    Providers: [ppFedEx]),
    (Service: ibxezship.stFedExFreightPriority;                   Name: 'FedEx Freight Priority';                   Providers: [ppFedEx]),

    (Service: ibxezship.stUPSFirstClass;                          Name: 'UPS First Class';                          Providers: [ppUPS];         Options:[ssoUSDomestic, ssoMailInnovations]),
    (Service: ibxezship.stUPSPriorityMail;                        Name: 'UPS Priority Mail';                        Providers: [ppUPS];         Options:[ssoUSDomestic, ssoMailInnovations]),
    (Service: ibxezship.stUPSExpeditedMailInnovations;            Name: 'UPS Expedited Mail';                       Providers: [ppUPS];         Options:[ssoUSDomestic, ssoMailInnovations]),
    (Service: ibxezship.stUPSPriorityMailInnovations;             Name: 'UPS Priority Mail';                        Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSEconomyMailInnovations;              Name: 'UPS UPS Economy Mail';                     Providers: [ppUPS];         Options:[ssoUSDomestic]),

    (Service: ibxezship.stUPSNextDayAir;                          Name: 'UPS Next Day Air';                         Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSExpress;                             Name: 'UPS Express';                              Providers: [ppUPS]),
    (Service: ibxezship.stUPS2ndDayAir;                           Name: 'UPS 2nd Day Air';                          Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSGround;                              Name: 'UPS Ground';                               Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSWorldwideExpress;                    Name: 'UPS Worldwide Express';                    Providers: [ppUPS]),
    (Service: ibxezship.stUPSWorldwideExpedited;                  Name: 'UPS Worldwide Expedited';                  Providers: [ppUPS]),
    (Service: ibxezship.stUPSExpedited;                           Name: 'UPS Expedited';                            Providers: [ppUPS]),
    (Service: ibxezship.stUPSStandard;                            Name: 'UPS Standard';                             Providers: [ppUPS]),
    (Service: ibxezship.stUPS3DaySelect;                          Name: 'UPS 3 Day Select';                         Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSNextDayAirSaver;                     Name: 'UPS Next Day Air Saver';                   Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSSaver;                               Name: 'UPS Saver';                                Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSNextDayAirEarlyAM;                   Name: 'UPS Next Day Air Early AM';                Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSExpressEarlyAM;                      Name: 'UPS Express Early AM';                     Providers: [ppUPS]),
    (Service: ibxezship.stUPSWorldwideExpressPlus;                Name: 'UPS Worldwide Express Plus';               Providers: [ppUPS]),
    (Service: ibxezship.stUPSExpressPlus;                         Name: 'UPS Express Plus';                         Providers: [ppUPS]),
    (Service: ibxezship.stUPS2ndDayAirAM;                         Name: 'UPS 2nd Day Air AM';                       Providers: [ppUPS];         Options:[ssoUSDomestic]),
    (Service: ibxezship.stUPSTodayStandard;                       Name: 'UPS Today Standard';                       Providers: [ppUPS]),
    (Service: ibxezship.stUPSTodayCourrier;                       Name: 'UPS Today Courrier';                       Providers: [ppUPS]),
    (Service: ibxezship.stUPSTodayInterCity;                      Name: 'UPS Today Inter City';                     Providers: [ppUPS]),
    (Service: ibxezship.stUPSTodayExpress;                        Name: 'UPS Today Express';                        Providers: [ppUPS]),
    (Service: ibxezship.stUPSTodayExpressSaver;                   Name: 'UPS Today Express Saver';                  Providers: [ppUPS]),
    (Service: ibxezship.stUPSWorldwideExpressFreight;             Name: 'UPS Worldwide Express Freight';            Providers: [ppUPS]),
    (Service: ibxezship.stUPSSurePostLessThan1LB;                 Name: 'UPS Sure Post Less Than 1LB';              Providers: [ppUPS]),
    (Service: ibxezship.stUPSSurePost1LBOrGreater;                Name: 'UPS Sure Post 1LB Or Greater';             Providers: [ppUPS]),
    (Service: ibxezship.stUPSSurePostBPM;                         Name: 'UPS Sure Post BPM';                        Providers: [ppUPS]),
    (Service: ibxezship.stUPSSurePostMedia;                       Name: 'UPS Sure Post Media';                      Providers: [ppUPS]),

    (Service: ibxezship.stUSPSExpress;                            Name: 'USPS Express';                             Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSFirstClass;                         Name: 'USPS First Class';                         Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSPriority;                           Name: 'USPS Priority';                            Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSParcelPost;                         Name: 'USPS Parcel Post';                         Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSMedia;                              Name: 'USPS Media';                               Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSLibrary;                            Name: 'USPS Library';                             Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSOnline;                             Name: 'USPS Online';                              Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSGlobalExpress;                      Name: 'USPS Global Express';                      Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSParcelSelect;                       Name: 'USPS Parcel Select';                       Providers: [ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSCriticalMail;                       Name: 'USPS Critical Mail';                       Providers: [ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSStandardMail;                       Name: 'USPS Standard Mail';                       Providers: [ppUSPSEndicia]),
    (Service: ibxezship.stUSPSExpressMailInternational;           Name: 'USPS Express Mail International';          Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSFirstClassMailInternational;        Name: 'USPS First Class Mail International';      Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stUSPSPriorityMailInternational;          Name: 'USPS Priority Mail International';         Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Service: ibxezship.stCanadaRegularParcel;                    Name: 'Canada Regular Parcel';                    Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaExpeditedParcel;                  Name: 'Canada Expedited Parcel';                  Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaXpresspost;                       Name: 'Canada Xpress Post';                       Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaLibrary;                          Name: 'Canada Library';                           Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaPriority;                         Name: 'Canada Priority';                          Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaPriorityEnvelopeUSA;              Name: 'Canada Priority Envelope USA';             Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaPriorityPakUSA;                   Name: 'Canada Priority Pak USA';                  Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaPriorityParcelUSA;                Name: 'Canada Priority Parcel USA';               Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaXpresspostUSA;                    Name: 'Canada Xpress Post USA';                   Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaExpeditedParcelUSA;               Name: 'Canada Expedited Parcel USA';              Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaSmallPacketAirUSA;                Name: 'Canada Small Packet Air USA';              Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaTrackedPacketUSA;                 Name: 'Canada Tracked Packet USA';                Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaTrackedPacketLVMUSA;              Name: 'Canada Tracked Packet LVM USA';            Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaPriorityEnvelopeInternational;    Name: 'Canada Priority Envelope International';   Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaPriorityPakInternational;         Name: 'Canada Priority Pak International';        Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaPriorityParcelInternational;      Name: 'Canada Priority Parcel International';     Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaXpresspostInternational;          Name: 'Canada Xpress Post International';         Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaSmallPacketAirInternational;      Name: 'Canada Small Packet Air International';    Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaSmallPacketLandInternational;     Name: 'Canada Small Packet Land International';   Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaParcelAirInternational;           Name: 'Canada Parcel Air International';          Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaParcelLandInternational;          Name: 'Canada Parcel Land International';         Providers: [ppCanadaPost]),
    (Service: ibxezship.stCanadaTrackedPacketInternational;       Name: 'Canada Tracked Packet International';      Providers: [ppCanadaPost])
  );

(*
  UPSServiceTypes: array[0..7] of TUPSServiceTypeRec =
  (
    (Name: 'UPS 2nd Day Air';             Service: stUPS2ndDayAir),
    (Name: 'UPS 2nd Day Air AM';          Service: stUPS2ndDayAirAM),
    (Name: 'UPS 3Day Select';             Service: stUPS3DaySelect),
//    (Name: 'UPS Expedited';               Service: stUPSExpedited),
//    (Name: 'UPS Express';                 Service: stUPSExpress),
//    (Name: 'UPS Express Early AM';        Service: stUPSExpressEarlyAM),
//    (Name: 'UPS Express Plus';            Service: stUPSExpressPlus),
    (Name: 'UPS Ground';                  Service: stUPSGround),
    (Name: 'UPS Next Day Air';            Service: stUPSNextDayAir),
    (Name: 'UPS Next Day Air Early AM';   Service: stUPSNextDayAirEarlyAM),
    (Name: 'UPS Next Day Air Saver';      Service: stUPSNextDayAirSaver),
    (Name: 'UPS Saver';                   Service: stUPSSaver)
//    (Name: 'UPS Standard';                Service: stUPSStandard),
//    (Name: 'UPS World Wide Expedited';    Service: stUPSWorldWideExpedited),
//    (Name: 'UPS World Wide Express';      Service: stUPSWorldWideExpress),
//    (Name: 'UPS World Wide Express Plus'; Service: stUPSWorldWideExpressPlus)
  );
*)

(*

 ptNone,
  ptPostcards,
  ptLetter,
  ptLargeEnvelope,
  ptFlatRateEnvelope,
  ptFlatRateLegalEnvelope,
  ptFlatRatePaddedEnvelope,
  ptFlatRateGiftCardEnvelope,
  ptFlatRateWindowEnvelope,
  ptFlatRateCardboardEnvelope,
  ptSmallFlatRateEnvelope,
  ptPak,
  ptBox,
  pt10kgBox,
  pt25kgBox,
  ptSmallExpressBox,
  ptMediumExpressBox,
  ptLargeExpressBox,
  ptFlatRateBox,
  ptSmallFlatRateBox,
  ptMediumFlatRateBox,
  ptLargeFlatRateBox,
  ptDVDFlatRateBox,
  ptLargeVideoFlatRateBox,
  ptRegionalRateBoxA,
  ptRegionalRateBoxB,
  ptRectangular,
  ptNonRectangular,
  ptTube,
  ptMatterForTheBlind,
  ptPallet,
  ptYourPackaging,
  ptDocument,

  ptFlats,
  ptParcels,
  ptBPM,
  ptFirstClass,
  ptPriority,
  ptMachinables,
  ptIrregulars,
  ptParcelPost,
  ptBPMParcel,
  ptMediaMail,
  ptBPMFlat,
  ptStandardFlat,
  ptRegionalRateBoxC,
  ptThickEnvelope,
  ptSmallBox,
  ptMediumBox,
  ptLargeBox,
  ptVeryLargeBox
*)

  PackageTypeList: array [0..50] of TPackageTypeRec =
  (
    (Package: ibxezship.ptNone;                       Name: 'None';                         Providers: [ppUPS,ppUSPS,ppCanadaPost]),
    (Package: ibxezship.ptPostcards;                  Name: 'Postcards';                    Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptLetter;                     Name: 'Letter';                       Providers: [ppFedEx,ppUPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptLargeEnvelope;              Name: 'Large Envelope';               Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptFlatRateEnvelope;           Name: 'Flat Rate Envelope';           Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptFlatRateLegalEnvelope;      Name: 'Flat Rate Legal Envelope';     Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptFlatRatePaddedEnvelope;     Name: 'Flat Rate Padded Envelope';    Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptFlatRateGiftCardEnvelope;   Name: 'Flat Rate Gift Card Envelope'; Providers: [ppUSPS,ppUSPSEndicia]),
    (Package: ibxezship.ptFlatRateWindowEnvelope;     Name: 'Flat Rate Window Envelope';    Providers: [ppUSPS,ppUSPSEndicia]),
    (Package: ibxezship.ptFlatRateCardboardEnvelope;  Name: 'Flat Rate Cardboard Envelope'; Providers: [ppUSPSEndicia]),
    (Package: ibxezship.ptSmallFlatRateEnvelope;      Name: 'Small Flat Rate Envelope';     Providers: [ppUSPS,ppUSPSEndicia]),
    (Package: ibxezship.ptPak;                        Name: 'Pack';                         Providers: [ppFedEx,ppUPS]),
    (Package: ibxezship.ptBox;                        Name: 'Box';                          Providers: [ppFedEx,ppUPS]),
    (Package: ibxezship.pt10kgBox;                    Name: '10kg Box';                     Providers: [ppFedEx,ppUPS]),
    (Package: ibxezship.pt25kgBox;                    Name: '25kg Box';                     Providers: [ppFedEx,ppUPS]),
    (Package: ibxezship.ptSmallExpressBox;            Name: 'Small Express Box';            Providers: [ppUPS]),
    (Package: ibxezship.ptMediumExpressBox;           Name: 'Medium Express Box';           Providers: [ppUPS]),
    (Package: ibxezship.ptLargeExpressBox;            Name: 'Large Express Box';            Providers: [ppUPS]),
    (Package: ibxezship.ptFlatRateBox;                Name: 'Flat Rate Box';                Providers: [ppUSPS,ppUSPSStamps]),
    (Package: ibxezship.ptSmallFlatRateBox;           Name: 'Small Flat Rate Box';          Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptMediumFlatRateBox;          Name: 'Medium Flat Rate Box';         Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptLargeFlatRateBox;           Name: 'Large Flat Rate Box';          Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptDVDFlatRateBox;             Name: 'DVD Flat Rate Box';            Providers: [ppUSPSEndicia]),
    (Package: ibxezship.ptLargeVideoFlatRateBox;      Name: 'Large Video Flat Rate Box';    Providers: [ppUSPSEndicia]),
    (Package: ibxezship.ptRegionalRateBoxA;           Name: 'Regional Rate Box A';          Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptRegionalRateBoxB;           Name: 'Regional Rate Box B';          Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptRectangular;                Name: 'Rectangular';                  Providers: [ppUSPS]),
    (Package: ibxezship.ptNonRectangular;             Name: 'Non Rectangular';              Providers: [ppUSPS]),
    (Package: ibxezship.ptTube;                       Name: 'Tube';                         Providers: [ppFedEx,ppUPS,ppCanadaPost]),
    (Package: ibxezship.ptMatterForTheBlind;          Name: 'Matter For The Blind';         Providers: [ppUSPS]),
    (Package: ibxezship.ptPallet;                     Name: 'Pallet';                       Providers: [ppUSPS]),
    (Package: ibxezship.ptYourPackaging;              Name: 'Your Packaging';               Providers: [ppFedEx,ppUPS,ppUSPS,ppUSPSEndicia,ppUSPSStamps,ppCanadaPost,ppUSPSStamps]),
    (Package: ibxezship.ptDocument;                   Name: 'Document';                     Providers: [ppCanadaPost]),

    (Package: ibxezship.ptFlats;                      Name: 'Flats';                        Providers: [ppUPS]),
    (Package: ibxezship.ptParcels;                    Name: 'Parcels';                      Providers: [ppUPS]),
    (Package: ibxezship.ptBPM;                        Name: 'BPM';                          Providers: [ppUPS]),
    (Package: ibxezship.ptFirstClass;                 Name: 'First Class';                  Providers: [ppUPS]),
    (Package: ibxezship.ptPriority;                   Name: 'Priority';                     Providers: [ppUPS]),
    (Package: ibxezship.ptMachinables;                Name: 'Machinables';                  Providers: [ppUPS]),
    (Package: ibxezship.ptIrregulars;                 Name: 'Irregulars';                   Providers: [ppUPS]),
    (Package: ibxezship.ptParcelPost;                 Name: 'Parcel Post';                  Providers: [ppUPS]),
    (Package: ibxezship.ptBPMParcel;                  Name: 'BPM Parcel';                   Providers: [ppUPS]),
    (Package: ibxezship.ptMediaMail;                  Name: 'Media Mail';                   Providers: [ppUPS]),
    (Package: ibxezship.ptBPMFlat;                    Name: 'BPM Flat';                     Providers: [ppUPS]),
    (Package: ibxezship.ptStandardFlat;               Name: 'Standard Flat';                Providers: [ppUPS]),
    (Package: ibxezship.ptRegionalRateBoxC;           Name: 'Regional Rate Box C';          Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptThickEnvelope;              Name: 'Thick Envelope';               Providers: [ppUSPS,ppUSPSEndicia,ppUSPSStamps]),
    (Package: ibxezship.ptSmallBox;                   Name: 'Small Box';                    Providers: [ppFedEx]),
    (Package: ibxezship.ptMediumBox;                  Name: 'Medium Box';                   Providers: [ppFedEx]),
    (Package: ibxezship.ptLargeBox;                   Name: 'Large Box';                    Providers: [ppFedEx]),
    (Package: ibxezship.ptVeryLargeBox;               Name: 'Very Large Box';               Providers: [ppFedEx])
  );

  ShipLabelImageFormatList: array [0..12] of TShipLabelImageFormatRec  =
  (
    (ImageType: itNone;     Name: 'None';    Providers: [ppUSPS]),
    (ImageType: itEPL;      Name: 'EPL';     Providers: [ppUPS,ppUSPSEndicia]),
    (ImageType: itGIF;      Name: 'GIF';     Providers: [ppUPS,ppUSPS,ppUSPSEndicia]),
    (ImageType: itJPG;      Name: 'JPG';     Providers: [ppUSPSEndicia]),
    (ImageType: itPDF;      Name: 'PDF';     Providers: [ppFedEx,ppUSPS,ppCanadaPost,ppUSPSEndicia,ppUSPSStamps]),
    (ImageType: itPNG;      Name: 'PNG';     Providers: [ppFedEx,ppUSPSEndicia,ppUSPSStamps]),
    (ImageType: itSPL;      Name: 'SPL';     Providers: [ppUPS]),
    (ImageType: itTIF;      Name: 'TIF';     Providers: [ppUSPS]),
    (ImageType: itZPL;      Name: 'ZPL';     Providers: [ppUPS,ppUSPSEndicia]),
    (ImageType: itStar;     Name: 'Star';    Providers: [ppUPS]),
    (ImageType: itEltron;   Name: 'Eltron';  Providers: [ppFedEx]),
    (ImageType: itUniMark;  Name: 'UniMark'; Providers: [ppFedEx]),
    (ImageType: itZebra;    Name: 'Zebra';   Providers: [ppFedEx])
  );

  UPSShipLabelImageFormatList: array [0..4] of TUPSShipLabelImageFormatRec =
  (
    (ImageType: uitGIF;   Name: 'GIF'),
    (ImageType: uitEPL;   Name: 'EPL'),
    (ImageType: uitSPL;   Name: 'SPL'),
    (ImageType: uitZPL;   Name: 'ZPL'),
    (ImageType: uitStar;  Name: 'Star')
  );

  PayorTypeList: array [0..1] of TPayorTypeRec =
  (
    (Payor: ibxezship.ptSender;     Name: 'Sender'),
    (Payor: ibxezship.ptRecipient;  Name: 'Recipient')(*,
    (Payor: ibxezship.ptThirdParty; Name: 'Third Party'),
    (Payor: ibxezship.ptCollect;    Name: 'Collect'),
    (Payor: ibxezship.ptConsignee; Name: 'Consignee')*)

  );

  PackageCODTypeList: array [0..4] of TPackageCODTypeRec =
  (
    (COD: ibxezship.codtpAny;               Name: 'Any';                Providers: [ppFedEx,ppUPS,ppUSPS]),
    (COD: ibxezship.codtpCash;              Name: 'Cash';               Providers: [ppFedEx]),
    (COD: ibxezship.codtpGuaranteedFunds;   Name: 'Guaranteed Funds';   Providers: [ppUPS]),
    (COD: ibxezship.codtpCompanyCheck;      Name: 'Company Check';      Providers: [ppfedEx,ppCanadaPost]),
    (COD: ibxezship.codtpPersonalCheck;     Name: 'Personal Check';     Providers: [ppfedEx,ppCanadaPost])
  );

  PackageSignatureTypeList: array [0..6] of TPackageSignatureTypeRec =
  (
    (Signature: ibxezship.stServiceDefault;           Name: 'Service Default';      Providers: [ppFedEx,ppUPS,ppUSPS,ppCanadaPost,ppUSPSEndicia,ppUSPSStamps]),
    (Signature: ibxezship.stAdult;                    Name: 'Adult';                Providers: [ppFedEx,ppUPS,ppUSPS,ppCanadaPost,ppUSPSEndicia,ppUSPSStamps]),
    (Signature: ibxezship.stDirect;                   Name: 'Direct';               Providers: [ppFedEx,ppUPS,ppUSPS,ppCanadaPost,ppUSPSEndicia,ppUSPSStamps]),
    (Signature: ibxezship.stIndirect;                 Name: 'Indirect';             Providers: [ppFedEx,ppUSPS,ppCanadaPost,ppUSPSEndicia,ppUSPSStamps]),
    (Signature: ibxezship.stNoSignatureRequired;      Name: 'No Signature Required';Providers: [ppFedEx,ppUPS,ppUSPS,ppCanadaPost,ppUSPSEndicia,ppUSPSStamps]),
    (Signature: ibxezship.stUSPSDeliveryConfirmation; Name: 'USPS Delivery Confirmation';Providers: [ppUSPS]),
    (Signature: ibxezship.stAdult19;                  Name: 'Adult9';               Providers: [ppCanadaPost])
  );

  UPSEndorsementList: array [0..4] of TUPSEndorsementRec =
  (
    (Id: 0; Name: 'No Service Selected'),
    (Id: 1; Name: 'Return Service Selected'),
    (Id: 2; Name: 'Forwarding Service Requested'),
    (Id: 3; Name: 'Address Service Requested'),
    (Id: 4; Name: 'Change Service Requested')
  );

  { match address fields }
  Match_Address1 =          'Address1';
  Match_Address2 =          'Address2';
  Match_ChangeType =        'ChangeType';
  Match_City =              'City';
  Match_Company =           'Company';
  Match_CountryCode =       'CountryCode';
  Match_Country =           'Country';
  Match_MatchPercent =      'MatchPercent';
  Match_ResidentialStatus = 'ResidentialStatus';
  Match_State =             'State';
  Match_PostCode =          'PostCode';

  Ship_TNT = 'TNT';

  function USPSImageTypeToStr(ImageType: integer): string;
  function USPSStrToImageType(ImageTypeStr: string): integer;

implementation

uses
  types, StrUtils, Character, ibxFedExShip, ibxUSPSShip;

{ TUPSError }

constructor TShipperError.Create(ex: exception);
var
  arr: TStringDynArray;
  x: integer;
  s: string;
  errName, errDesc: string;
begin
  ErrorNumber := '';
  ErrorName := '';
  ErrorNameHuman := '';
  ErrorCode := '';
  ErrorDesc := '';
  arr := StrUtils.SplitString(ex.Message, #13#10);
  { we are only interested in the first line .. }
  if High(arr) < 0  then exit;
  { split up first line }
  arr := StrUtils.SplitString(arr[0], ':');
  if High(arr) >= 0 then ErrorNumber := arr[0];
  errName := '';
  errDesc := '';
  if High(arr) >= 2 then begin
    errName := arr[1];
    errDesc := arr[2];
    if High(arr) > 2 then begin
      errDesc := errDesc  + ' (';
      for x := 3 to High(arr) do begin
        if x > 3 then errDesc := errDesc + ' ';
        errDesc := errDesc + arr[x];
      end;
    end;
  end
  else if High(arr) = 1 then begin
    errDesc := arr[1];
  end
  else
    exit;

  if errName <> '' then begin
    ErrorName := Trim(errName);
    for x := 1 to Length(ErrorName) do begin
      if (x > 1) and TCharacter.IsUpper(ErrorName[x]) then
        ErrorNameHuman := ErrorNameHuman + ' ';
      ErrorNameHuman := ErrorNameHuman + ErrorName[x];
    end;
  end;
  if errDesc <> '' then begin
    s := Trim(errDesc);
    x:= Pos(']',s);
    if (s[1] = '[') and (x > 0)  then begin
      ErrorCode := Copy(s,2,x-2);
      ErrorDesc := Trim(Copy(s,x+1,Length(s)));
    end
    else
      ErrorDesc := s;
  end;
end;



function ProviderTypeToStr(aProvider: TibxezshipProviders): string;
var
  x: integer;
begin
  for x := Low(ShipProviderList) to High(ShipProviderList) do begin
    if ShipProviderList[x].Provider = aProvider then begin
      result := ShipProviderList[x].Name;
      exit;
    end;
  end;
  raise Exception.Create('ProviderTypeToStr - Provider type not found.');
end;

function StrToProviderType(aProvider: string): TibxezshipProviders;
var
  x: integer;
begin
  for x := Low(ShipProviderList) to High(ShipProviderList) do begin
    if SameText(ShipProviderList[x].Name, aProvider) then begin
      result := ShipProviderList[x].Provider;
      exit;
    end;
  end;
  raise Exception.Create('StrToProviderType - Provider type not found "' + aProvider + '".');
end;

function ShipServiceTypeToStr(aService: TibxezshipServiceTypes): string;
var
  x: integer;
begin
  for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
    if ShipServiceTypeList[x].Service = aService then begin
      result := ShipServiceTypeList[x].Name;
      exit;
    end;
  end;
  raise Exception.Create('ShipServiceTypeToStr - Ship Service Type not found for ' + IntToStr(Ord(aService)) + '.');
end;

function StrToShipServiceType(aService: string): TibxezshipServiceTypes;
var
  x: integer;
begin
  for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
    if SameText(ShipServiceTypeList[x].Name, aService) then begin
      result := ShipServiceTypeList[x].Service;
      exit;
    end;
  end;
  raise Exception.Create('StrToShipServiceType - Ship Service Type not found for ' + aService + '.');
end;

(*
function UPSServiceTypeToStr(aService: TibxupsshipServiceTypes): string;
var
  x: integer;
begin
  for x := Low(UPSServiceTypes) to High(UPSServiceTypes) do begin
    if UPSServiceTypes[x].Service = aService then begin
      result := UPSServiceTypes[x].Name;
      exit;
    end;
  end;
  raise Exception.Create('UPSServiceTypeToStr - Service type not found.');
end;

function StrToUPSServiceType(aService: string): TibxupsshipServiceTypes;
var
  x: integer;
begin
  for x := Low(UPSServiceTypes) to High(UPSServiceTypes) do begin
    if SameText(UPSServiceTypes[x].Name, aService) then begin
      result := UPSServiceTypes[x].Service;
      exit;
    end;
  end;
  raise Exception.Create('StrToUPSServiceType - Service type not found "' + aService + '".');
end;
*)

function PackageTypeToStr(Packaging: TibxezshipPackageTypes): string;
var
  x: integer;
begin
  for x := Low(PackageTypeList) to High(PackageTypeList) do begin
    if PackageTypeList[x].Package = Packaging then begin
      result := PackageTypeList[x].Name;
      exit;
    end;
  end;
  raise Exception.Create('PackageTypeToStr - Packaging type not found.');
end;

function StrToPackageType(Packaging: string): TibxezshipPackageTypes;
var
  x: integer;
begin
  for x := Low(PackageTypeList) to High(PackageTypeList) do begin
    if SameText(PackageTypeList[x].Name,Packaging) then begin
      result := PackageTypeList[x].Package;
      exit;
    end;
  end;
  raise Exception.Create('PackageTypeToStr - Packaging type not found "' + Packaging + '".');
end;

function StrToPackageType(Packaging: string; PackageProvider: TPackageProvider): TibxezshipPackageTypes;
var
  x: integer;
begin
  for x := Low(PackageTypeList) to High(PackageTypeList) do begin
    if SameText(PackageTypeList[x].Name,Packaging) and (PackageProvider in PackageTypeList[x].Providers) then begin
      result := PackageTypeList[x].Package;
      exit;
    end;
  end;
  raise Exception.Create('PackageTypeToStr - Packaging type not found "' + Packaging + '".');
end;

function ImageTypeToStr(ImageType: TibxezshipLabelImageTypes): string;
var
  x: integer;
begin
  for x := Low(ShipLabelImageFormatList) to High(ShipLabelImageFormatList) do begin
    if ShipLabelImageFormatList[x].ImageType = ImageType then begin
      result := ShipLabelImageFormatList[x].Name;
      exit;
    end;
  end;
  raise Exception.Create('ImageTypeToStr - Image Type not found.');
end;

function StrToImageType(ImageType: string): TibxezshipLabelImageTypes;
var
  x: integer;
begin
  for x := Low(ShipLabelImageFormatList) to High(ShipLabelImageFormatList) do begin
    if SameText(ShipLabelImageFormatList[x].Name, ImageType) then begin
      result := ShipLabelImageFormatList[x].ImageType;
      exit;
    end;
  end;
  raise Exception.Create('StrToImageType - Image Type not found "' + ImageType + '".');
end;


function UPSImageTypeToStr(ImageType: TibxupsshipLabelImageTypes): string;
var
  x: integer;
begin
  for x := Low(UPSShipLabelImageFormatList) to High(UPSShipLabelImageFormatList) do begin
    if UPSShipLabelImageFormatList[x].ImageType = ImageType then begin
      result := UPSShipLabelImageFormatList[x].Name;
      exit;
    end;
  end;
  raise Exception.Create('UPSImageTypeToStr - UPS Image Type not found for ' + IntToStr(Ord(ImageType)) + '.');
end;

function StrToUPSImageType(ImageType: string): TibxupsshipLabelImageTypes;
var
  x: integer;
begin
  for x := Low(UPSShipLabelImageFormatList) to High(UPSShipLabelImageFormatList) do begin
    if SameText(UPSShipLabelImageFormatList[x].Name, ImageType) then begin
      result := UPSShipLabelImageFormatList[x].ImageType;
      exit;
    end;
  end;
  raise Exception.Create('StrToUPSImageType - UPS Image Type not found for "' + ImageType + '".');
end;

function PayorTypeToStr(PayorType: TibxezshipPayorTypes): string;
var
 x: integer;
begin
  for x := Low(PayorTypeList) to High(PayorTypeList) do begin
    if PayorTypeList[x].Payor = PayorType then begin
      result := PayorTypeList[x].Name;
      exit;
    end;
  end;
  raise Exception.Create('PayorTypeToStr - Payor Type not found.');
end;

function StrToPayorType(PayorType: string): TibxezshipPayorTypes;
var
 x: integer;
begin
  for x := Low(PayorTypeList) to High(PayorTypeList) do begin
    if SameText(PayorTypeList[x].Name,PayorType) then begin
      result := PayorTypeList[x].Payor;
      exit;
    end;
  end;
  if trim(PayorType) ='' then exit;
  raise Exception.Create('StrToPayorType - Payor Type not found "' + PayorType + '".');
end;

function IsUPSMailInnovations(ServiceType: TibxezshipServiceTypes): Boolean;
var
 x: integer;
begin
  result := false;
  for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
    if (ShipServiceTypeList[x].Service = ServiceType) and (ssoMailInnovations in ShipServiceTypeList[x].Options) then begin
      result := true;
      exit;
    end;
  end;
end;


function FedExImageTypeToStr(ImageType: integer): string;
begin
  case TibxfedexshipLabelImageTypes(ImageType)  of
    fitPDF: result := 'PDF';
    fitPNG: result := 'PNG';
    fitEltron: result := 'Eltron';
    fitZebra: result := 'Zebra';
    fitUniMark: result := 'UniMark';
  end;
end;

function FedExImageTypeToExtStr(ImageType: integer): string;
begin
  case TibxfedexshipLabelImageTypes(ImageType)  of
    fitPDF: result := 'pdf';
    fitPNG: result := 'png';
    fitEltron: result := 'epl';
    fitZebra: result := 'zpl';
    fitUniMark: result := 'mrc';
  end;
end;

function FedExStrToImageType(ImageTypeStr: string): integer;
begin
  result := Ord(fitPDF);
  if ImageTypeStr = '' then exit;
  if SameText(ImageTypeStr, 'PDF') then result := Ord(fitPDF)
  else if SameText(ImageTypeStr, 'PNG') then result := Ord(fitPNG)
  else if SameText(ImageTypeStr, 'Eltron') then result := Ord(fitEltron)
  else if SameText(ImageTypeStr, 'Zebra') then result := Ord(fitZebra)
  else if SameText(ImageTypeStr, 'UniMark') then result := Ord(fitUniMark)
  else raise Exception.Create('FedExStrToImageType - Invalid Image Type "' + ImageTypeStr + '"');
end;

function USPSImageTypeToStr(ImageType: integer): string;
begin
  case TibxuspsshipLabelImageTypes(ImageType) of
    sitNone: result := 'None';
    sitTIF: result := 'TIF';
    sitJPG: result := 'JPG';
    sitPDF: result := 'PDF';
    sitGIF: result := 'GIF';
    sitEPL: result := 'EPL';
    sitPNG: result := 'PNG';
    sitZPL: result := 'ZPL';
  end;
end;

function USPSStrToImageType(ImageTypeStr: string): integer;
begin
  result := Ord(sitNone);
  if ImageTypeStr = '' then exit;
  if SameText(ImageTypeStr, 'None') then result := Ord(sitNone)
  else if SameText(ImageTypeStr, 'TIF') then result := Ord(sitTIF)
  else if SameText(ImageTypeStr, 'JPG') then result := Ord(sitJPG)
  else if SameText(ImageTypeStr, 'PDF') then result := Ord(sitPDF)
  else if SameText(ImageTypeStr, 'GIF') then result := Ord(sitGIF)
  else if SameText(ImageTypeStr, 'EPL') then result := Ord(sitEPL)
  else if SameText(ImageTypeStr, 'PNG') then result := Ord(sitPNG)
  else if SameText(ImageTypeStr, 'ZPL') then result := Ord(sitZPL)
  else raise Exception.Create('USPSStrToImageType - Invalid Image Type "' + ImageTypeStr + '"');
end;

function PackageCODTypeToStr(aType: TibxezshipPackageCODTypes): string;
begin
  case aType of
    TibxezshipPackageCODTypes.codtpAny: result := 'Any';
    TibxezshipPackageCODTypes.codtpCash: result := 'Cash';
    TibxezshipPackageCODTypes.codtpGuaranteedFunds: result := 'Guaranteed Funds';
    TibxezshipPackageCODTypes.codtpCompanyCheck: result := 'Company Check';
    TibxezshipPackageCODTypes.codtpPersonalCheck: result := 'Personal Check';
    else result := '';
  end;
end;

function SignatureTypeToStr(aType: TibxezshipPackageSignatureTypes): string;
var
  x: integer;
begin
  result := '';
  for x := Low(PackageSignatureTypeList) to High(PackageSignatureTypeList) do begin
    if PackageSignatureTypeList[x].Signature = aType then begin
      result := PackageSignatureTypeList[x].Name;
      exit;
    end;
  end;
end;
(*function  FedExServicetypes:Array of String;
begin
  result := ServicetypeForProvider(ppFedEx);
end;
function  UPSServicetypes:Array of String;
begin
  result := ServicetypeForProvider(ppUPS);
end;
function  USPostalServiceServicetypes:Array of String;
begin
  result := ServicetypeForProvider(ppUSPS);
end;
function  CanadaPostServicetypes:Array of String;
begin
  result := ServicetypeForProvider(ppCanadaPost);
end;
function  ServicetypeForProvider(Const Provider:TPackageProvider):Array of String;
var
  x:Integer;
begin
  SetLength(Result , 0);
  for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
    if (Provider in ShipServiceTypeList[x].Providers) then begin
      SetLength(Result , length(Result)+1);
      result[high(result)]:=  ShipServiceTypeList[x].Name;
    end;
  end;
end;*)
Function intToPackageProvider(Const Value:Integer):TPackageProvider;
begin
  if Value = 0 then result := ppFedEx
  else if Value = 1 then result := ppUPS
  else if Value = 2 then result := ppUSPS
  else if Value = 3 then result := ppCanadaPost
  else if Value = 4 then result := ppUSPSEndicia
  else result :=  ppFedEx; // default
end;

function PackageProviderToStr(Value: TPackageProvider): string;
begin
  case Value of
    ppFedEx: result := 'FedEx';
    ppUPS: result := 'UPS';
    ppUSPS: result := 'USPS';
    ppCanadaPost: result := 'Canada Post';
    ppUSPSEndicia: result := 'USPS Endicia';
    ppUSPSStamps: result := 'USPS Stamps';
  end;

end;
function PackageProviderToStr(Value: TibxezShipProviders): string;
begin
  case Value of
    pFedEx: result := 'FedEx';
    pUPS: result := 'UPS';
    pUSPS: result := 'USPS';
    pCanadaPost: result := 'Canada Post';
  end;
end;


end.
